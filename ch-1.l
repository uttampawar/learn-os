%{
/*
 * Word recognizer with a symbol table.
 */

enum {
  LOOKUP = 0,
  VERB,
  ADJ,
  ADV,
  NOUN,
  PREP,
  PRON,
  CONJ
};

int state;

int add_word(int type, char *word);
int lookup_word(char *word);
%}

%%
\n        { state = LOOKUP; } /* end of line, return to default state */

^verb     { state = VERB; }
^adj      { state = ADJ; }
^adv      { state = ADV; }
^noun     { state = NOUN; }
^prep     { state = PREP; }
^pron     { state = PRON; }
^conj     { state = CONJ; }

[a-zA-Z]+ {
            if (state != LOOKUP) {
              /* define the current word */
              add_word(state, yytext);
            } else {
              switch(lookup_word(yytext)) {
                case VERB:
                  printf("%s: verb\n", yytext);
                  break;
                case ADJ:
                  printf("%s: adjective\n", yytext);
                  break;
                case ADV:
                  printf("%s: adverb\n", yytext);
                  break;
                case NOUN:
                  printf("%s: noun\n", yytext);
                  break;
                case PREP:
                  printf("%s: preposition\n", yytext);
                  break;
                case PRON:
                  printf("%s: pronoun\n", yytext);
                  break;
                case CONJ:
                  printf("%s: conjuction\n", yytext);
                  break;
                default:
                  printf("%s: don't recognize\n", yytext);
                  break;
              }
            }

          }

,         /* ignore anything else */

%%

int main()
{
  yylex();

  return 0;
}

struct word {
  char *word_name;
  int word_type;
  struct word *next;
};

struct word *word_list;
extern void *malloc(size_t size);

int add_word(int type, char *word) {
  struct word *wp;
  if (lookup_word(word) != LOOKUP) {
    printf("!! warning: word %s already defined \n", word);
    return 0;
  }

  wp = (struct word *)malloc(sizeof(struct word));
  if (wp == NULL) {
    perror("malloc for word node");
    return 0;
  }

  wp->next = word_list;

  wp->word_name = (char *)malloc(strlen(word)+1);
  if (wp->word_name == NULL) {
    perror("malloc for word itself");
    return 0;
  }

  strcpy(wp->word_name, word);
  wp->word_type = type;
  word_list = wp;
  return 1;
}

int lookup_word(char *word) {
  struct word *wp = word_list;

  for(; wp; wp = wp->next) {
    if(strcmp(wp->word_name, word) == 0) {
      return wp->word_type;
    }
  }

  return LOOKUP; /* word not found */
}
