#include <stdio.h>
#include <sys/time.h>

int main(){
        int i,num_loops=3; //100;
        struct timeval tv;
        struct timezone tz;
        long sec_start, sec_end;
        int micro_start, micro_end;
        double duration;

        gettimeofday (&tv, &tz);
        sec_start=tv.tv_sec;
        micro_start=tv.tv_usec;
        printf("Seconds since 1/1/1970: %f\n",(float)tv.tv_sec);
        printf("Microseconds: %f\n",(float)tv.tv_usec);
        printf("Microseconds with decimal: %f\n",((float)tv.tv_usec)/1000000);
        duration = (float) ((float)tv.tv_sec + ((float)tv.tv_usec)/1000000);
        printf ("duration %.6f \n", duration);


        duration = (float)tv.tv_sec + (float)tv.tv_usec/1000000;
        printf ("duration %f\n", duration);
        printf("\n.....\n");
for ( i=0; i<num_loops; i++){
        gettimeofday (&tv, &tz);
        printf("loop Seconds since 1/1/1970: %ld\n",tv.tv_sec);
        printf("loop Microseconds: %ld\n",tv.tv_usec);
        if (i == (num_loops-1)){
                sec_end = tv.tv_sec;
                micro_end = tv.tv_usec;
        }
/*      printf("Minutes west of Greenwich: %d\n",tz.tz_minuteswest);
        printf("Type of Daylight saving time correction: %d\n",tz.tz_dsttime);
*/
        printf("\n.....\n");

}
        printf("out loop Seconds since 1/1/1970: %ld\n",tv.tv_sec);
        printf("out loop Microseconds: %ld\n",tv.tv_usec);
        long usec_val  = tv.tv_usec/1000;
        printf("out loop iusec_val: %ld\n",usec_val);
        printf("total out loop Microseconds: %f\n",(float)tv.tv_sec + (float)usec_val - (float)duration);
        printf ("out duration %f\n", duration);

        printf ("final seconds_difference : %ld\n", sec_end - sec_start);
        printf ("final useconds_difference : %ld\n", (long)micro_end - micro_start );
        duration = (float)tv.tv_sec + (float)tv.tv_usec/(float)1000000.0f - duration;
        printf ("final duration %f\n", duration);

return 0;
}

