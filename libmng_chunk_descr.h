/* ************************************************************************** */
/* *             For conditions of distribution and use,                    * */
/* *                see copyright notice in libmng.h                        * */
/* ************************************************************************** */
/* *                                                                        * */
/* * project   : libmng                                                     * */
/* * file      : libmng_chunk_descr.h      copyright (c) 2004 G.Juyn        * */
/* * version   : 1.0.9                                                      * */
/* *                                                                        * */
/* * purpose   : Chunk descriptor functions (implementation)                * */
/* *                                                                        * */
/* * author    : G.Juyn                                                     * */
/* *                                                                        * */
/* * comment   : definition of the chunk- anf field-descriptor routines     * */
/* *                                                                        * */
/* * changes   : 1.0.9 - 12/06/2004 - G.Juyn                                * */
/* *             - added conditional MNG_OPTIMIZE_CHUNKREADER               * */
/* *                                                                        * */
/* ************************************************************************** */

#if defined(__BORLANDC__) && defined(MNG_STRICT_ANSI)
#pragma option -A                      /* force ANSI-C */
#endif

#ifndef _libmng_chunk_descr_h_
#define _libmng_chunk_descr_h_

/* ************************************************************************** */

#ifdef MNG_OPTIMIZE_CHUNKREADER
#if defined(MNG_INCLUDE_READ_PROCS) || defined(MNG_INCLUDE_WRITE_PROCS)

/* ************************************************************************** */

void mng_get_chunkheader (mng_chunkid       iChunkname,
                          mng_chunk_headerp pResult);

/* ************************************************************************** */

#define MNG_F_SPECIALFUNC(n) mng_retcode n (mng_datap  pData,   \
                                            mng_chunkp pChunk,  \
                                            mng_uint32 iRawlen, \
                                            mng_uint8p pRawdata)

MNG_F_SPECIALFUNC (mng_deflate_itxt) ;

/* ************************************************************************** */

#define MNG_C_SPECIALFUNC(n) mng_retcode n (mng_datap  pData,   \
                                            mng_chunkp pChunk)

MNG_C_SPECIALFUNC (mng_special_ihdr) ;
MNG_C_SPECIALFUNC (mng_special_idat) ;
MNG_C_SPECIALFUNC (mng_special_iend) ;
MNG_C_SPECIALFUNC (mng_special_gama) ;
MNG_C_SPECIALFUNC (mng_special_chrm) ;
MNG_C_SPECIALFUNC (mng_special_srgb) ;
MNG_C_SPECIALFUNC (mng_special_iccp) ;
MNG_C_SPECIALFUNC (mng_special_text) ;
MNG_C_SPECIALFUNC (mng_special_ztxt) ;
MNG_C_SPECIALFUNC (mng_special_itxt) ;
MNG_C_SPECIALFUNC (mng_special_bkgd) ;
MNG_C_SPECIALFUNC (mng_special_phys) ;
MNG_C_SPECIALFUNC (mng_special_sbit) ;
MNG_C_SPECIALFUNC (mng_special_time) ;

MNG_C_SPECIALFUNC (mng_special_jhdr) ;
MNG_C_SPECIALFUNC (mng_special_jdaa) ;
MNG_C_SPECIALFUNC (mng_special_jdat) ;
MNG_C_SPECIALFUNC (mng_special_jsep) ;

MNG_C_SPECIALFUNC (mng_special_mhdr) ;
MNG_C_SPECIALFUNC (mng_special_mend) ;
MNG_C_SPECIALFUNC (mng_special_loop) ;
MNG_C_SPECIALFUNC (mng_special_endl) ;
MNG_C_SPECIALFUNC (mng_special_defi) ;
MNG_C_SPECIALFUNC (mng_special_basi) ;
MNG_C_SPECIALFUNC (mng_special_clon) ;
MNG_C_SPECIALFUNC (mng_special_back) ;
MNG_C_SPECIALFUNC (mng_special_move) ;
MNG_C_SPECIALFUNC (mng_special_clip) ;
MNG_C_SPECIALFUNC (mng_special_show) ;
MNG_C_SPECIALFUNC (mng_special_term) ;
MNG_C_SPECIALFUNC (mng_special_seek) ;
MNG_C_SPECIALFUNC (mng_special_expi) ;
MNG_C_SPECIALFUNC (mng_special_fpri) ;
MNG_C_SPECIALFUNC (mng_special_need) ;
MNG_C_SPECIALFUNC (mng_special_phyg) ;

MNG_C_SPECIALFUNC (mng_special_dhdr) ;
MNG_C_SPECIALFUNC (mng_special_prom) ;
MNG_C_SPECIALFUNC (mng_special_ipng) ;
MNG_C_SPECIALFUNC (mng_special_ijng) ;
MNG_C_SPECIALFUNC (mng_special_dbyk) ;

MNG_C_SPECIALFUNC (mng_special_unknown) ;

/* ************************************************************************** */

#endif /* MNG_INCLUDE_READ_PROCS) || MNG_INCLUDE_WRITE_PROCS */
#endif /* MNG_OPTIMIZE_CHUNKREADER */

/* ************************************************************************** */

#endif /* _libmng_chunk_descr_h_ */

/* ************************************************************************** */
/* * end of file                                                            * */
/* ************************************************************************** */
