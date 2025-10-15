Return-Path: <linux-kernel+bounces-855279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 011B0BE0B97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596D71A22FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B82D595B;
	Wed, 15 Oct 2025 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVw3uGxQ"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061C2D3220
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561935; cv=none; b=aI2dFv3ZYPTMc5MGGh6xrmNW6OJk8kggtYXvKl40yUeeZTNQ6nKx6hj9MID9Xqr924eXktPvl5VxmJdeG8D8BNywYPQXo9Z+GCcD+G38kziaYFhvdnFBVbWtou5aaGgzV05rqCEUYqwQMfeS+waCTgzNpi6NY0tTUbrRhKh+YRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561935; c=relaxed/simple;
	bh=9oKedthnDgcqjeJTSYDoAWPAhfEUZcc0tuqZJRzrBek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POqTQqySJ4wRy1JI3DPIgZOnfXWpQNV4s4LeuQTEEh2bfLt1WyNP7ye5+BCoMegmMFTUSicv4K4s2skYmOZNRv45flGMWnxX4Lj/+m7ytYbvnBnS3ljKbN9MQ1EDJ7FYiPlqROPhXejafjDWoa/UpJNOsbZmjkG4hXwA4yNGG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVw3uGxQ; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5d613937df1so3530342137.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760561932; x=1761166732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe4T7nGAO3K6RbfLMiEl1u7UF8ay3GS5UPkvepueBL0=;
        b=NVw3uGxQPMSwRo79dxMpEbTxEMIxDmxw7ukZYWrXZefXrByfNiE9qUFiJ99+FobXMD
         XzCBh4Ll+s11Femq6Jx0H10/Ap1shfRq+5SZaRjjm04S5hvBkbw+Kr1sXWFOB/8uD7Nf
         wFSchiVZZ9Q8bnnyJREqERG0U5raxRxtA04rk9ujasUW3wFfvm3OXNIyrE5ZjWfzFdsh
         b4mRW5ULdZa5N/rv51yE+qv6Wg7fumVkXOcUSqMau4yAvbbzX+p5OfVAixWYQKSlpl1X
         npyRITceUyx11g1B43l1L4Md68cW2q3ihJPbo1KePpKBpu8k5IHowHb3Qg1qofhgxfF5
         RuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760561932; x=1761166732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qe4T7nGAO3K6RbfLMiEl1u7UF8ay3GS5UPkvepueBL0=;
        b=TDv1CO61KMIAn+RUQlxJ8urXLURtX6Ti2gPg85SzGWcwBiYuvbXo4O+e9uk5Udc3iO
         byiIb48YmEpKz1Y6ZJSwdHz4BHXCDutVfRTIRNVwiCSUmEOUN8pYPlhwHh0qUTO8FB1u
         Qv8Fk3oE3vw0CGEdW++VUYGny3GVQKQax1pjl3co0nQfsog3zCY9y7rzvtA7JtEK2wpa
         28BKuVuD8cWUEH6KJmO6vueoUcT0z7a8I1j7NnTk0Gr1VLtWGAd4Sqv9uN6Zpmm8YNod
         rjWQC7FXOnn5YBHsynfbD5wRFjXDtk71K+l5NTMf8C2Ew5xZ3KExIpSO0P3LYvHT3ivC
         nXiw==
X-Gm-Message-State: AOJu0YwtRrygYned8aGgscaAcSCToWdYvfXsavEMnjw5uBeL7A+zW6Xu
	kTAxKxeqHIQFVHuCakumimQLP9xZA0psZSyDrzBlR+wie8bQHunQxg9whYPDtsy1zHudGshiJPI
	YsBYx7mFoZrOJbWY8fVA5KU3kLZXeOl/rits2
X-Gm-Gg: ASbGncsG4BMzQyvUn+eXkyvHEnBMYGwGC2lysgv9v36Rrz+U/a35pV4Ui0NkDDQRzr8
	6a5y1jpMMpLBQYRfkDyMl+pM6VF+25rNThtYr4N/3/IZm2oaemBKzGExEU9fUiaCvD9ZFsldNkv
	Ei9ewIObAg0t/GjVG7LHdM7aX2zg6iw9k9riBPmk6/56jDUs7b6WaBM4khl3HRxcqYRLXg6kokV
	4YWovGBquwlTI3J8nhZzaJbnfqGy+C+GSxQEfWii0yMYY2/5mSD5iGJGU342sEqBb85vMmDD9gF
	pMCX/qLOSyhtYE4EOzDS183HLbYX
X-Google-Smtp-Source: AGHT+IEtDrpsbtd3NPXFM1POrlZ7X5TsLlc7h2i5ennQbHkDhlKBg/LxqqNyadbD/JwTXygApZHUm/RkEq7ei9ZsmLk=
X-Received: by 2002:a05:6102:2928:b0:529:96b9:1fce with SMTP id
 ada2fe7eead31-5d5e2375d2cmr11654508137.27.1760561932183; Wed, 15 Oct 2025
 13:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014201817.1111991-1-daeho43@gmail.com> <00916380-b510-45ed-83bd-4f120e8d3c70@kernel.org>
In-Reply-To: <00916380-b510-45ed-83bd-4f120e8d3c70@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 15 Oct 2025 13:58:38 -0700
X-Gm-Features: AS18NWCmoCxq2Wf9RXYyCsnJFq2VuCNMnYMueO6fNqAu2YNxUuBFAdvLnu6HoTM
Message-ID: <CACOAw_wKScFUsFr5uziN0=z6iuHr5yDShk0puEarT6KGswq9ow@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: revert summary entry count from 2048
 to 512 in 16kb block support
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 1:21=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> Daeho,
>
> I can not apply this patch to last dev-test branch, could you please
> rebase it?

Let me rebase it.

>
> On 10/15/25 04:18, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > The recent increase in the number of Segment Summary Area (SSA) entries
> > from 512 to 2048 was an unintentional change in logic of 16kb block
> > support. This commit corrects the issue.
> >
> > To better utilize the space available from the erroneous 2048-entry
> > calculation, we are implementing a solution to share the currently
> > unused SSA space with neighboring segments. This enhances overall
> > SSA utilization without impacting the established 8MB segment size.
> >
> > Fixes: d7e9a9037de2 ("f2fs: Support Block Size =3D=3D Page Size")
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v2: detect legacy layout and prevent mount.
> > ---
> >  fs/f2fs/gc.c            | 116 +++++++++++++++++++++++-----------------
> >  fs/f2fs/recovery.c      |   2 +-
> >  fs/f2fs/segment.c       |  23 ++++----
> >  fs/f2fs/segment.h       |   8 ++-
> >  fs/f2fs/super.c         |  38 +++++++++++++
> >  include/linux/f2fs_fs.h |   5 +-
> >  6 files changed, 129 insertions(+), 63 deletions(-)
> >
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 88bbcf291034..85c06ca0eae7 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1732,7 +1732,7 @@ static int do_garbage_collect(struct f2fs_sb_info=
 *sbi,
> >       unsigned char type =3D IS_DATASEG(get_seg_entry(sbi, segno)->type=
) ?
> >                                               SUM_TYPE_DATA : SUM_TYPE_=
NODE;
> >       unsigned char data_type =3D (type =3D=3D SUM_TYPE_DATA) ? DATA : =
NODE;
> > -     int submitted =3D 0;
> > +     int submitted =3D 0, sum_blk_cnt;
> >
> >       if (__is_large_section(sbi)) {
> >               sec_end_segno =3D rounddown(end_segno, SEGS_PER_SEC(sbi))=
;
> > @@ -1766,22 +1766,28 @@ static int do_garbage_collect(struct f2fs_sb_in=
fo *sbi,
> >
> >       sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
> >
> > +     segno =3D rounddown(segno, SUMS_PER_BLOCK);
> > +     sum_blk_cnt =3D DIV_ROUND_UP(end_segno - segno, SUMS_PER_BLOCK);
> >       /* readahead multi ssa blocks those have contiguous address */
> >       if (__is_large_section(sbi))
> >               f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
> > -                                     end_segno - segno, META_SSA, true=
);
> > +                                     sum_blk_cnt, META_SSA, true);
> >
> >       /* reference all summary page */
> >       while (segno < end_segno) {
> > -             struct folio *sum_folio =3D f2fs_get_sum_folio(sbi, segno=
++);
> > +             struct folio *sum_folio =3D f2fs_get_sum_folio(sbi, segno=
);
> > +
> > +             segno +=3D SUMS_PER_BLOCK;
> >               if (IS_ERR(sum_folio)) {
> >                       int err =3D PTR_ERR(sum_folio);
> >
> > -                     end_segno =3D segno - 1;
> > -                     for (segno =3D start_segno; segno < end_segno; se=
gno++) {
> > +                     end_segno =3D segno - SUMS_PER_BLOCK;
> > +                     segno =3D rounddown(start_segno, SUMS_PER_BLOCK);
> > +                     while (segno < end_segno) {
> >                               sum_folio =3D filemap_get_folio(META_MAPP=
ING(sbi),
> >                                               GET_SUM_BLOCK(sbi, segno)=
);
> >                               folio_put_refs(sum_folio, 2);
> > +                             segno +=3D SUMS_PER_BLOCK;
> >                       }
> >                       return err;
> >               }
> > @@ -1790,61 +1796,75 @@ static int do_garbage_collect(struct f2fs_sb_in=
fo *sbi,
> >
> >       blk_start_plug(&plug);
> >
> > -     for (segno =3D start_segno; segno < end_segno; segno++) {
> > -             struct f2fs_summary_block *sum;
> > -
> > +     segno =3D start_segno;
> > +     while (segno < end_segno) {
> > +             unsigned int cur_segno;
> >               /* find segment summary of victim */
> >               struct folio *sum_folio =3D filemap_get_folio(META_MAPPIN=
G(sbi),
> >                                       GET_SUM_BLOCK(sbi, segno));
> > +             unsigned int block_end_segno =3D rounddown(segno, SUMS_PE=
R_BLOCK)
> > +                                             + SUMS_PER_BLOCK;
> > +
> > +             if (block_end_segno > end_segno)
> > +                     block_end_segno =3D end_segno;
> >
> > -             if (get_valid_blocks(sbi, segno, false) =3D=3D 0)
> > -                     goto freed;
> > -             if (gc_type =3D=3D BG_GC && __is_large_section(sbi) &&
> > -                             migrated >=3D sbi->migration_granularity)
> > -                     goto skip;
> >               if (!folio_test_uptodate(sum_folio) ||
> >                   unlikely(f2fs_cp_error(sbi)))
> > -                     goto skip;
> > +                     goto next_block;
> >
> > -             sum =3D folio_address(sum_folio);
> > -             if (type !=3D GET_SUM_TYPE((&sum->footer))) {
> > -                     f2fs_err(sbi, "Inconsistent segment (%u) type [%d=
, %d] in SSA and SIT",
> > -                              segno, type, GET_SUM_TYPE((&sum->footer)=
));
> > -                     f2fs_stop_checkpoint(sbi, false,
> > -                             STOP_CP_REASON_CORRUPTED_SUMMARY);
> > -                     goto skip;
> > -             }
> > +             for (cur_segno =3D segno; cur_segno < block_end_segno;
> > +                             cur_segno++) {
> > +                     struct f2fs_summary_block *sum;
> >
> > -             /*
> > -              * this is to avoid deadlock:
> > -              * - lock_page(sum_page)         - f2fs_replace_block
> > -              *  - check_valid_map()            - down_write(sentry_lo=
ck)
> > -              *   - down_read(sentry_lock)     - change_curseg()
> > -              *                                  - lock_page(sum_page)
> > -              */
> > -             if (type =3D=3D SUM_TYPE_NODE)
> > -                     submitted +=3D gc_node_segment(sbi, sum->entries,=
 segno,
> > -                                                             gc_type);
> > -             else
> > -                     submitted +=3D gc_data_segment(sbi, sum->entries,=
 gc_list,
> > -                                                     segno, gc_type,
> > -                                                     force_migrate);
> > +                     if (get_valid_blocks(sbi, cur_segno, false) =3D=
=3D 0)
> > +                             goto freed;
> > +                     if (gc_type =3D=3D BG_GC && __is_large_section(sb=
i) &&
> > +                                     migrated >=3D sbi->migration_gran=
ularity)
> > +                             continue;
> >
> > -             stat_inc_gc_seg_count(sbi, data_type, gc_type);
> > -             sbi->gc_reclaimed_segs[sbi->gc_mode]++;
> > -             migrated++;
> > +                     sum =3D SUM_BLK_PAGE_ADDR(sum_folio, cur_segno);
> > +                     if (type !=3D GET_SUM_TYPE((&sum->footer))) {
> > +                             f2fs_err(sbi, "Inconsistent segment (%u) =
type "
> > +                                             "[%d, %d] in SSA and SIT"=
,
> > +                                             cur_segno, type,
> > +                                             GET_SUM_TYPE((&sum->foote=
r)));
> > +                             f2fs_stop_checkpoint(sbi, false,
> > +                                     STOP_CP_REASON_CORRUPTED_SUMMARY)=
;
> > +                             continue;
> > +                     }
> >
> > -freed:
> > -             if (gc_type =3D=3D FG_GC &&
> > -                             get_valid_blocks(sbi, segno, false) =3D=
=3D 0)
> > -                     seg_freed++;
> > +                     /*
> > +                      * this is to avoid deadlock:
> > +                      * - lock_page(sum_page)     - f2fs_replace_block
> > +                      *  - check_valid_map()        - down_write(sentr=
y_lock)
> > +                      *   - down_read(sentry_lock) - change_curseg()
> > +                      *                              - lock_page(sum_p=
age)
> > +                      */
> > +                     if (type =3D=3D SUM_TYPE_NODE)
> > +                             submitted +=3D gc_node_segment(sbi, sum->=
entries,
> > +                                             cur_segno, gc_type);
> > +                     else
> > +                             submitted +=3D gc_data_segment(sbi, sum->=
entries,
> > +                                             gc_list, cur_segno,
> > +                                             gc_type, force_migrate);
> >
> > -             if (__is_large_section(sbi))
> > -                     sbi->next_victim_seg[gc_type] =3D
> > -                             (segno + 1 < sec_end_segno) ?
> > -                                     segno + 1 : NULL_SEGNO;
> > -skip:
> > +                     stat_inc_gc_seg_count(sbi, data_type, gc_type);
> > +                     sbi->gc_reclaimed_segs[sbi->gc_mode]++;
> > +                     migrated++;
> > +
> > +freed:
> > +                     if (gc_type =3D=3D FG_GC &&
> > +                             get_valid_blocks(sbi, cur_segno, false) =
=3D=3D 0)
> > +                             seg_freed++;
> > +
> > +                     if (__is_large_section(sbi))
> > +                             sbi->next_victim_seg[gc_type] =3D
> > +                                     (cur_segno + 1 < sec_end_segno) ?
> > +                                             cur_segno + 1 : NULL_SEGN=
O;
> > +             }
> > +next_block:
> >               folio_put_refs(sum_folio, 2);
> > +             segno =3D block_end_segno;
> >       }
> >
> >       if (submitted)
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index 4cb3a91801b4..4fda8d2afdc8 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -519,7 +519,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb=
_info *sbi,
> >       sum_folio =3D f2fs_get_sum_folio(sbi, segno);
> >       if (IS_ERR(sum_folio))
> >               return PTR_ERR(sum_folio);
> > -     sum_node =3D folio_address(sum_folio);
> > +     sum_node =3D SUM_BLK_PAGE_ADDR(sum_folio, segno);
> >       sum =3D sum_node->entries[blkoff];
> >       f2fs_folio_put(sum_folio, true);
> >  got_it:
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index cc82d42ef14c..0416815185f6 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -2712,7 +2712,7 @@ struct folio *f2fs_get_sum_folio(struct f2fs_sb_i=
nfo *sbi, unsigned int segno)
> >  void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
> >                                       void *src, block_t blk_addr)
> >  {
> > -     struct folio *folio =3D f2fs_grab_meta_folio(sbi, blk_addr);
> > +     struct folio *folio =3D f2fs_get_meta_folio(sbi, blk_addr);
>
> f2fs_get_meta_folio() can fail due to a lot of reason, we need to handle =
error
> case of it?

Oh, I missed it.

>
> >
> >       memcpy(folio_address(folio), src, PAGE_SIZE);
> >       folio_mark_dirty(folio);
> > @@ -2720,9 +2720,14 @@ void f2fs_update_meta_page(struct f2fs_sb_info *=
sbi,
> >  }
> >
> >  static void write_sum_page(struct f2fs_sb_info *sbi,
> > -                     struct f2fs_summary_block *sum_blk, block_t blk_a=
ddr)
> > +             struct f2fs_summary_block *sum_blk, unsigned int segno)
> >  {
> > -     f2fs_update_meta_page(sbi, (void *)sum_blk, blk_addr);
> > +     struct folio *folio;
> > +
> > +     folio =3D f2fs_get_sum_folio(sbi, segno);
>
> Ditto,
>
> Or maybe we can allow struct curseg_info to cache entire 16KB-sized block=
,
> and then update entire block w/ original f2fs_update_meta_page().
>
> > +     memcpy(SUM_BLK_PAGE_ADDR(folio, segno), sum_blk, sizeof(*sum_blk)=
);
> > +     folio_mark_dirty(folio);
> > +     f2fs_folio_put(folio, true);
> >  }
> >
> >  static void write_current_sum_page(struct f2fs_sb_info *sbi,
> > @@ -2970,7 +2975,7 @@ static int new_curseg(struct f2fs_sb_info *sbi, i=
nt type, bool new_sec)
> >       int ret;
> >
> >       if (curseg->inited)
> > -             write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, s=
egno));
> > +             write_sum_page(sbi, curseg->sum_blk, segno);
> >
> >       segno =3D __get_next_segno(sbi, type);
> >       ret =3D get_new_segment(sbi, &segno, new_sec, pinning);
> > @@ -3029,7 +3034,7 @@ static int change_curseg(struct f2fs_sb_info *sbi=
, int type)
> >       struct folio *sum_folio;
> >
> >       if (curseg->inited)
> > -             write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, c=
urseg->segno));
> > +             write_sum_page(sbi, curseg->sum_blk, curseg->segno);
> >
> >       __set_test_and_inuse(sbi, new_segno);
> >
> > @@ -3048,7 +3053,7 @@ static int change_curseg(struct f2fs_sb_info *sbi=
, int type)
> >               memset(curseg->sum_blk, 0, SUM_ENTRY_SIZE);
> >               return PTR_ERR(sum_folio);
> >       }
> > -     sum_node =3D folio_address(sum_folio);
> > +     sum_node =3D SUM_BLK_PAGE_ADDR(sum_folio, new_segno);
> >       memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
> >       f2fs_folio_put(sum_folio, true);
> >       return 0;
> > @@ -3137,8 +3142,7 @@ static void __f2fs_save_inmem_curseg(struct f2fs_=
sb_info *sbi, int type)
> >               goto out;
> >
> >       if (get_valid_blocks(sbi, curseg->segno, false)) {
> > -             write_sum_page(sbi, curseg->sum_blk,
> > -                             GET_SUM_BLOCK(sbi, curseg->segno));
> > +             write_sum_page(sbi, curseg->sum_blk, curseg->segno);
> >       } else {
> >               mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> >               __set_test_and_free(sbi, curseg->segno, true);
> > @@ -3815,8 +3819,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info =
*sbi, struct folio *folio,
> >       if (segment_full) {
> >               if (type =3D=3D CURSEG_COLD_DATA_PINNED &&
> >                   !((curseg->segno + 1) % sbi->segs_per_sec)) {
> > -                     write_sum_page(sbi, curseg->sum_blk,
> > -                                     GET_SUM_BLOCK(sbi, curseg->segno)=
);
> > +                     write_sum_page(sbi, curseg->sum_blk, curseg->segn=
o);
> >                       reset_curseg_fields(curseg);
> >                       goto skip_new_segment;
> >               }
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index 5e2ee5c686b1..510487669610 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -85,8 +85,12 @@ static inline void sanity_check_seg_type(struct f2fs=
_sb_info *sbi,
> >  #define GET_ZONE_FROM_SEG(sbi, segno)                                \
> >       GET_ZONE_FROM_SEC(sbi, GET_SEC_FROM_SEG(sbi, segno))
> >
> > -#define GET_SUM_BLOCK(sbi, segno)                            \
> > -     ((sbi)->sm_info->ssa_blkaddr + (segno))
> > +#define SUMS_PER_BLOCK (F2FS_BLKSIZE / F2FS_SUM_BLKSIZE)
> > +#define GET_SUM_BLOCK(sbi, segno)    \
> > +     (SM_I(sbi)->ssa_blkaddr + (segno / SUMS_PER_BLOCK))
> > +#define GET_SUM_BLKOFF(segno) (segno % SUMS_PER_BLOCK)
> > +#define SUM_BLK_PAGE_ADDR(folio, segno)      \
> > +     (folio_address(folio) + GET_SUM_BLKOFF(segno) * F2FS_SUM_BLKSIZE)
> >
> >  #define GET_SUM_TYPE(footer) ((footer)->entry_type)
> >  #define SET_SUM_TYPE(footer, type) ((footer)->entry_type =3D (type))
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index e16c4e2830c2..8ca58f5a034a 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -3957,6 +3957,44 @@ static int sanity_check_raw_super(struct f2fs_sb=
_info *sbi,
> >       if (sanity_check_area_boundary(sbi, folio, index))
> >               return -EFSCORRUPTED;
> >
> > +     /*
> > +      * Check for legacy summary layout on 16KB+ block devices.
> > +      * Modern f2fs-tools packs multiple 4KB summary areas into one bl=
ock,
> > +      * whereas legacy versions used one block per summary, leading
> > +      * to a much larger SSA.
> > +      */
> > +     if (SUMS_PER_BLOCK > 1) {
> > +             unsigned int required_ssa_blocks;
> > +             unsigned int expected_ssa_segs;
> > +             unsigned int total_meta_segments, diff;
> > +             unsigned int segment_count_ssa =3D
> > +                     le32_to_cpu(raw_super->segment_count_ssa);
> > +             unsigned int segs_per_zone =3D segs_per_sec * secs_per_zo=
ne;
> > +
> > +             required_ssa_blocks =3D DIV_ROUND_UP(segment_count_main,
> > +                                                     SUMS_PER_BLOCK);
> > +             expected_ssa_segs =3D DIV_ROUND_UP(required_ssa_blocks,
> > +                                                     blocks_per_seg);
> > +             total_meta_segments =3D
> > +                     le32_to_cpu(raw_super->segment_count_ckpt) +
> > +                     le32_to_cpu(raw_super->segment_count_sit) +
> > +                     le32_to_cpu(raw_super->segment_count_nat) +
> > +                     expected_ssa_segs;
> > +             diff =3D total_meta_segments % segs_per_zone;
> > +             if (diff)
> > +                     expected_ssa_segs +=3D segs_per_zone - diff;
> > +
> > +             if (segment_count_ssa > expected_ssa_segs) {
> > +                     f2fs_info(sbi, "Error: Device formatted with a le=
gacy "
> > +                                     "version. Please reformat.");
> > +                     f2fs_info(sbi, "\tSSA segment count (%u) is large=
r "
> > +                                     "than expected (%u) for block "
> > +                                     "size (%lu).", segment_count_ssa,
> > +                                     expected_ssa_segs, F2FS_BLKSIZE);
> > +                     return -EOPNOTSUPP;
>
> Alright, this may break userspace after kernel upgrade, do we need to kee=
p
> backward compatibility for page-sized block feature.

Maintaining backward compatibility is incredibly painful and requires
disproportionate effort
compared to the benefit we get. Therefore, this patch is designed to
detect outdated formats
and recommend that users simply reformat instead of forcing us to
support them indefinitely.

>
> BTW, since this changes the disk layout, let's add feature - commit recor=
d into
> section "Detailed features description" at https://en.wikipedia.org/wiki/=
F2FS,
> that helps user and developer to know what kernel version and f2fs-tools =
version
> a specific feature relies on.

Let me update the page after the patch is merged.

Thanks,

>
> Thanks,
>
> > +             }
> > +     }
> > +
> >       return 0;
> >  }
> >
> > diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> > index 2f8b8bfc0e73..f6b2149d5e81 100644
> > --- a/include/linux/f2fs_fs.h
> > +++ b/include/linux/f2fs_fs.h
> > @@ -17,6 +17,7 @@
> >  #define F2FS_LOG_SECTORS_PER_BLOCK   (PAGE_SHIFT - 9) /* log number fo=
r sector/blk */
> >  #define F2FS_BLKSIZE                 PAGE_SIZE /* support only block =
=3D=3D page */
> >  #define F2FS_BLKSIZE_BITS            PAGE_SHIFT /* bits for F2FS_BLKSI=
ZE */
> > +#define F2FS_SUM_BLKSIZE             4096    /* only support 4096 byte=
 sum block */
> >  #define F2FS_MAX_EXTENSION           64      /* # of extension entries=
 */
> >  #define F2FS_EXTENSION_LEN           8       /* max size of extension =
*/
> >
> > @@ -440,7 +441,7 @@ struct f2fs_sit_block {
> >   * from node's page's beginning to get a data block address.
> >   * ex) data_blkaddr =3D (block_t)(nodepage_start_address + ofs_in_node=
)
> >   */
> > -#define ENTRIES_IN_SUM               (F2FS_BLKSIZE / 8)
> > +#define ENTRIES_IN_SUM               (F2FS_SUM_BLKSIZE / 8)
> >  #define      SUMMARY_SIZE            (7)     /* sizeof(struct f2fs_sum=
mary) */
> >  #define      SUM_FOOTER_SIZE         (5)     /* sizeof(struct summary_=
footer) */
> >  #define SUM_ENTRY_SIZE               (SUMMARY_SIZE * ENTRIES_IN_SUM)
> > @@ -466,7 +467,7 @@ struct summary_footer {
> >       __le32 check_sum;               /* summary checksum */
> >  } __packed;
> >
> > -#define SUM_JOURNAL_SIZE     (F2FS_BLKSIZE - SUM_FOOTER_SIZE -\
> > +#define SUM_JOURNAL_SIZE     (F2FS_SUM_BLKSIZE - SUM_FOOTER_SIZE -\
> >                               SUM_ENTRY_SIZE)
> >  #define NAT_JOURNAL_ENTRIES  ((SUM_JOURNAL_SIZE - 2) /\
> >                               sizeof(struct nat_journal_entry))
>

