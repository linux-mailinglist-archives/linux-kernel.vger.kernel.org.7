Return-Path: <linux-kernel+bounces-871854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0AFC0E91D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4A63BF5F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CB1EEA49;
	Mon, 27 Oct 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh+ZDdbM"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49C1DF247
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575901; cv=none; b=fnvJRV8OFDLn2Asd4M4hNOtSPva4R00AdmMpStIUwLXmf46IUrusPXJUKBQbGfAR86LGvTrXKuVpF5pT5al/kHefzB933SI6N73s07zBC7bxYqYxziDpht4L2Whl95IV65YptfHnta313sK+d1MYYEBT69JsXMYxqKjJ8thNwI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575901; c=relaxed/simple;
	bh=0pShFjpqQjGKo2CkPefjjS/oxlG1mBnuCqhUSYNDqBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t45O0IG/PYCQmCLQfV5El5H1ATA94BBlpI8PcC9ypsRZGNyfUXGUES/Y8anxFw5p/PD6k02vJIbVXU7C2YrIRNyEWOeHGQqTt+oUHdrCcc6QPnfjlDgnEcJfYe3QWCFCXbqKOcflnDeHkWrJ9QsIknJvsWLkFI6F4VDKFCv347U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh+ZDdbM; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-931028aeaf9so3725467241.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761575898; x=1762180698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ix2LC29LasUPNiPrTADurQ0PHTkXUcE0C/fRj3VlTPI=;
        b=lh+ZDdbMlAPTOpuOX1t3CeOJx7Fps0babTmayOf6oXcBl2+JSP1ZJhdABVru3gJZNx
         E1ZAQIAVWNZerMLoHKRb9HBuiTDV2xvPx8xt9+nUh6aeOKRF8eJ9WwhUWSq5X30xiJYE
         2ChikqHvdXxgEzERjiJAVVvMdFN7poyCklGePYv0kE20Jd6Sm4jY0UNz3WFmvkTz9sws
         bb8KyW3HyugQl8kvObBqQcQcIggeSrv9vZcBSf/RmWp7JmU+YQcgA1oLjX/vBZ5WkEMG
         BUMsQQHpRvBrrFaPhpUU9dpZE5jMbS3On0YndQy7RkoXr84aF9lO+h/tcZ6vFxLdBiBJ
         agXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575898; x=1762180698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ix2LC29LasUPNiPrTADurQ0PHTkXUcE0C/fRj3VlTPI=;
        b=rneVUztPZYjOgkiLMx7NABFuGWpdvEa54It1eeMb/Egc6PAlTPdd5jzQNRAh3ET8ck
         qSOTZSQAJMZ0mIjSy+VKYm6WFUpjBCs2PVX2omkDFHFV4ynM0Ftg8ImC8zBBrevs6TxH
         c1jc4yr3oXGFxRR4OWxj7TvKvUFxlm4xczbrBMCW7pd9QZDY/5RoYO+XX0gdn8+my/w9
         eEBai/wgWqiBp0Y5ykQGSDDBmURfS0rU1Zal+/XUWig6p0wwzVlJGAXReJw7MC44RbTp
         WlQkRvYQilwCSXUgXJDnX1OkPiLSbh3nKSL/exY/q8dIHmvjyKFdLwRcW/bcXoQMnS0/
         X9gQ==
X-Gm-Message-State: AOJu0YwC0f2N7RUZcKFp9QQmy6sT401wYDZxM340Hot0H6UXuv6aPHzm
	2d9UIPPcXyddFyGlqdlyF4uIQOiQOiW9nm7DKJPK+CQ/47THgx4yqtxaSGhINdyW0F5ub2EGRXV
	tS0lUDhWLTcBBmwEpOpDjwPlkDZFCs4o=
X-Gm-Gg: ASbGncsiyoZrVg42xm7jDoDa0RtYt0n5Hg4oZ0pENFtBgXi18uETmy7713QnJ2Gq9OI
	yJIakG+ZcqygCo5kXmzTlxFr4WptkuV5nG6od6bkvIiVhtuGh5NSRVQft/woxpO2RE6feWPBln3
	AVbaqM4kWoqHqWufibW90GDV8Dvc/bt8ky/F1rmPAvhU6mhZgAmMDBsAihsImh0d5475PJ16Ob2
	BVZomnCCdv8aD+p2ITQvRrZUDkprJ82eN3RdZIGYZC6d6ihRGs7VtnzhAIWGQiBsq/uU2dQ69F7
	CAnnPRbQ9vSMYnOl2Dcu0dVgTsE=
X-Google-Smtp-Source: AGHT+IF83UMyOrC8M+cGVrlodlJ5uehxGH3WmSj8+qcaONiEa5Yd7HBNNqOy2jqXF+nheJNZhqwWw2uBDqIPjLU55Xs=
X-Received: by 2002:a05:6102:290f:b0:5c8:c906:e3c1 with SMTP id
 ada2fe7eead31-5db7ca98dffmr44014137.17.1761575897462; Mon, 27 Oct 2025
 07:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015211133.1895311-1-daeho43@gmail.com> <398451e1-3cc4-4f9d-be0d-6ecf68e71f55@kernel.org>
 <CACOAw_xQpov14gw2-e_dW9xXW_LvPnz-0BBX4jR4W4REe4xn-Q@mail.gmail.com>
In-Reply-To: <CACOAw_xQpov14gw2-e_dW9xXW_LvPnz-0BBX4jR4W4REe4xn-Q@mail.gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 27 Oct 2025 07:38:05 -0700
X-Gm-Features: AWmQ_bnZ8_ScCFRY66lLEbcTe0zppE2KNVAsuKwxG8EX9A7JZh1RLAzTCrVVLEk
Message-ID: <CACOAw_y7VA1feOqmknCHkw1_uh2eCr4LM-rVqp1YkeNspSHG_w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: revert summary entry count from 2048
 to 512 in 16kb block support
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:34=E2=80=AFAM Daeho Jeong <daeho43@gmail.com> wro=
te:
>
> On Mon, Oct 27, 2025 at 12:00=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
> >
> > On 10/16/25 05:11, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > The recent increase in the number of Segment Summary Area (SSA) entri=
es
> > > from 512 to 2048 was an unintentional change in logic of 16kb block
> > > support. This commit corrects the issue.
> > >
> > > To better utilize the space available from the erroneous 2048-entry
> > > calculation, we are implementing a solution to share the currently
> > > unused SSA space with neighboring segments. This enhances overall
> > > SSA utilization without impacting the established 8MB segment size.
> > >
> > > Fixes: d7e9a9037de2 ("f2fs: Support Block Size =3D=3D Page Size")
> > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > ---
> > > v2: detect legacy layout and prevent mount.
> > > v3: error handling for a failure of f2fs_get_meta_folio().
> > > ---
> > >  fs/f2fs/gc.c            | 117 +++++++++++++++++++++++---------------=
--
> > >  fs/f2fs/recovery.c      |   2 +-
> > >  fs/f2fs/segment.c       |  29 ++++++----
> > >  fs/f2fs/segment.h       |   8 ++-
> > >  fs/f2fs/super.c         |  38 +++++++++++++
> > >  include/linux/f2fs_fs.h |   5 +-
> > >  6 files changed, 136 insertions(+), 63 deletions(-)
> > >
> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index 8abf521530ff..af2f4d28462c 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -1732,7 +1732,7 @@ static int do_garbage_collect(struct f2fs_sb_in=
fo *sbi,
> > >       unsigned char type =3D IS_DATASEG(get_seg_entry(sbi, segno)->ty=
pe) ?
> > >                                               SUM_TYPE_DATA : SUM_TYP=
E_NODE;
> > >       unsigned char data_type =3D (type =3D=3D SUM_TYPE_DATA) ? DATA =
: NODE;
> > > -     int submitted =3D 0;
> > > +     int submitted =3D 0, sum_blk_cnt;
> > >
> > >       if (__is_large_section(sbi)) {
> > >               sec_end_segno =3D rounddown(end_segno, SEGS_PER_SEC(sbi=
));
> > > @@ -1766,22 +1766,28 @@ static int do_garbage_collect(struct f2fs_sb_=
info *sbi,
> > >
> > >       sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
> > >
> > > +     segno =3D rounddown(segno, SUMS_PER_BLOCK);
> > > +     sum_blk_cnt =3D DIV_ROUND_UP(end_segno - segno, SUMS_PER_BLOCK)=
;
> > >       /* readahead multi ssa blocks those have contiguous address */
> > >       if (__is_large_section(sbi))
> > >               f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
> > > -                                     end_segno - segno, META_SSA, tr=
ue);
> > > +                                     sum_blk_cnt, META_SSA, true);
> > >
> > >       /* reference all summary page */
> > >       while (segno < end_segno) {
> > > -             struct folio *sum_folio =3D f2fs_get_sum_folio(sbi, seg=
no++);
> > > +             struct folio *sum_folio =3D f2fs_get_sum_folio(sbi, seg=
no);
> > > +
> > > +             segno +=3D SUMS_PER_BLOCK;
> > >               if (IS_ERR(sum_folio)) {
> > >                       int err =3D PTR_ERR(sum_folio);
> > >
> > > -                     end_segno =3D segno - 1;
> > > -                     for (segno =3D start_segno; segno < end_segno; =
segno++) {
> > > +                     end_segno =3D segno - SUMS_PER_BLOCK;
> > > +                     segno =3D rounddown(start_segno, SUMS_PER_BLOCK=
);
> > > +                     while (segno < end_segno) {
> > >                               sum_folio =3D filemap_get_folio(META_MA=
PPING(sbi),
> > >                                               GET_SUM_BLOCK(sbi, segn=
o));
> > >                               folio_put_refs(sum_folio, 2);
> > > +                             segno +=3D SUMS_PER_BLOCK;
> > >                       }
> > >                       return err;
> > >               }
> > > @@ -1790,68 +1796,83 @@ static int do_garbage_collect(struct f2fs_sb_=
info *sbi,
> > >
> > >       blk_start_plug(&plug);
> > >
> > > -     for (segno =3D start_segno; segno < end_segno; segno++) {
> > > -             struct f2fs_summary_block *sum;
> > > +     segno =3D start_segno;
> > > +     while (segno < end_segno) {
> > > +             unsigned int cur_segno;
> > >
> > >               /* find segment summary of victim */
> > >               struct folio *sum_folio =3D filemap_get_folio(META_MAPP=
ING(sbi),
> > >                                       GET_SUM_BLOCK(sbi, segno));
> > > +             unsigned int block_end_segno =3D rounddown(segno, SUMS_=
PER_BLOCK)
> > > +                                     + SUMS_PER_BLOCK;
> > > +
> > > +             if (block_end_segno > end_segno)
> > > +                     block_end_segno =3D end_segno;
> > >
> > >               if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno))) {
> > >                       f2fs_err(sbi, "%s: segment %u is used by log",
> > >                                                       __func__, segno=
);
> > >                       f2fs_bug_on(sbi, 1);
> > > -                     goto skip;
> > > +                     goto next_block;
> > >               }
> > >
> > > -             if (get_valid_blocks(sbi, segno, false) =3D=3D 0)
> > > -                     goto freed;
> > > -             if (gc_type =3D=3D BG_GC && __is_large_section(sbi) &&
> > > -                             migrated >=3D sbi->migration_granularit=
y)
> > > -                     goto skip;
> > >               if (!folio_test_uptodate(sum_folio) ||
> > >                   unlikely(f2fs_cp_error(sbi)))
> > > -                     goto skip;
> > > +                     goto next_block;
> > >
> > > -             sum =3D folio_address(sum_folio);
> > > -             if (type !=3D GET_SUM_TYPE((&sum->footer))) {
> > > -                     f2fs_err(sbi, "Inconsistent segment (%u) type [=
%d, %d] in SIT and SSA",
> > > -                              segno, type, GET_SUM_TYPE((&sum->foote=
r)));
> > > -                     f2fs_stop_checkpoint(sbi, false,
> > > -                             STOP_CP_REASON_CORRUPTED_SUMMARY);
> > > -                     goto skip;
> > > -             }
> > > +             for (cur_segno =3D segno; cur_segno < block_end_segno;
> > > +                             cur_segno++) {
> > > +                     struct f2fs_summary_block *sum;
> > >
> > > -             /*
> > > -              * this is to avoid deadlock:
> > > -              * - lock_page(sum_page)         - f2fs_replace_block
> > > -              *  - check_valid_map()            - down_write(sentry_=
lock)
> > > -              *   - down_read(sentry_lock)     - change_curseg()
> > > -              *                                  - lock_page(sum_pag=
e)
> > > -              */
> > > -             if (type =3D=3D SUM_TYPE_NODE)
> > > -                     submitted +=3D gc_node_segment(sbi, sum->entrie=
s, segno,
> > > -                                                             gc_type=
);
> > > -             else
> > > -                     submitted +=3D gc_data_segment(sbi, sum->entrie=
s, gc_list,
> > > -                                                     segno, gc_type,
> > > -                                                     force_migrate);
> > > +                     if (get_valid_blocks(sbi, cur_segno, false) =3D=
=3D 0)
> > > +                             goto freed;
> > > +                     if (gc_type =3D=3D BG_GC && __is_large_section(=
sbi) &&
> > > +                                     migrated >=3D sbi->migration_gr=
anularity)
> > > +                             continue;
> > >
> > > -             stat_inc_gc_seg_count(sbi, data_type, gc_type);
> > > -             sbi->gc_reclaimed_segs[sbi->gc_mode]++;
> > > -             migrated++;
> > > +                     sum =3D SUM_BLK_PAGE_ADDR(sum_folio, cur_segno)=
;
> > > +                     if (type !=3D GET_SUM_TYPE((&sum->footer))) {
> > > +                             f2fs_err(sbi, "Inconsistent segment (%u=
) type "
> > > +                                             "[%d, %d] in SSA and SI=
T",
> > > +                                             cur_segno, type,
> > > +                                             GET_SUM_TYPE((&sum->foo=
ter)));
> > > +                             f2fs_stop_checkpoint(sbi, false,
> > > +                                             STOP_CP_REASON_CORRUPTE=
D_SUMMARY);
> > > +                             continue;
> > > +                     }
> > >
> > > -freed:
> > > -             if (gc_type =3D=3D FG_GC &&
> > > -                             get_valid_blocks(sbi, segno, false) =3D=
=3D 0)
> > > -                     seg_freed++;
> > > +                     /*
> > > +                      * this is to avoid deadlock:
> > > +                      *  - lock_page(sum_page)     - f2fs_replace_bl=
ock
> > > +                      *   - check_valid_map()        - down_write(se=
ntry_lock)
> > > +                      *    - down_read(sentry_lock) - change_curseg(=
)
> > > +                      *                               - lock_page(su=
m_page)
> > > +                      */
> > > +                     if (type =3D=3D SUM_TYPE_NODE)
> > > +                             submitted +=3D gc_node_segment(sbi, sum=
->entries,
> > > +                                             cur_segno, gc_type);
> > > +                     else
> > > +                             submitted +=3D gc_data_segment(sbi, sum=
->entries,
> > > +                                             gc_list, cur_segno,
> > > +                                             gc_type, force_migrate)=
;
> > >
> > > -             if (__is_large_section(sbi))
> > > -                     sbi->next_victim_seg[gc_type] =3D
> > > -                             (segno + 1 < sec_end_segno) ?
> > > -                                     segno + 1 : NULL_SEGNO;
> > > -skip:
> > > +                     stat_inc_gc_seg_count(sbi, data_type, gc_type);
> > > +                     sbi->gc_reclaimed_segs[sbi->gc_mode]++;
> > > +                     migrated++;
> > > +
> > > +freed:
> > > +                     if (gc_type =3D=3D FG_GC &&
> > > +                                     get_valid_blocks(sbi, cur_segno=
, false) =3D=3D 0)
> > > +                             seg_freed++;
> > > +
> > > +                     if (__is_large_section(sbi))
> > > +                             sbi->next_victim_seg[gc_type] =3D
> > > +                                     (cur_segno + 1 < sec_end_segno)=
 ?
> > > +                                     cur_segno + 1 : NULL_SEGNO;
> > > +             }
> > > +next_block:
> > >               folio_put_refs(sum_folio, 2);
> > > +             segno =3D block_end_segno;
> > >       }
> > >
> > >       if (submitted)
> > > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > > index 215e442db72c..af72309b9bfc 100644
> > > --- a/fs/f2fs/recovery.c
> > > +++ b/fs/f2fs/recovery.c
> > > @@ -519,7 +519,7 @@ static int check_index_in_prev_nodes(struct f2fs_=
sb_info *sbi,
> > >       sum_folio =3D f2fs_get_sum_folio(sbi, segno);
> > >       if (IS_ERR(sum_folio))
> > >               return PTR_ERR(sum_folio);
> > > -     sum_node =3D folio_address(sum_folio);
> > > +     sum_node =3D SUM_BLK_PAGE_ADDR(sum_folio, segno);
> > >       sum =3D sum_node->entries[blkoff];
> > >       f2fs_folio_put(sum_folio, true);
> > >  got_it:
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index b45eace879d7..77aa2125b8ca 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -2712,7 +2712,10 @@ struct folio *f2fs_get_sum_folio(struct f2fs_s=
b_info *sbi, unsigned int segno)
> > >  void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
> > >                                       void *src, block_t blk_addr)
> > >  {
> > > -     struct folio *folio =3D f2fs_grab_meta_folio(sbi, blk_addr);
> > > +     struct folio *folio =3D f2fs_get_meta_folio_retry(sbi, blk_addr=
);
> > > +
> > > +     if (IS_ERR(folio))
> > > +             return;
> > >
> > >       memcpy(folio_address(folio), src, PAGE_SIZE);
> > >       folio_mark_dirty(folio);
> > > @@ -2720,9 +2723,17 @@ void f2fs_update_meta_page(struct f2fs_sb_info=
 *sbi,
> > >  }
> > >
> > >  static void write_sum_page(struct f2fs_sb_info *sbi,
> > > -                     struct f2fs_summary_block *sum_blk, block_t blk=
_addr)
> > > +             struct f2fs_summary_block *sum_blk, unsigned int segno)
> > >  {
> > > -     f2fs_update_meta_page(sbi, (void *)sum_blk, blk_addr);
> > > +     struct folio *folio;
> > > +
> > > +     folio =3D f2fs_get_sum_folio(sbi, segno);
> > > +     if (IS_ERR(folio))
> > > +             return;
> > > +
> > > +     memcpy(SUM_BLK_PAGE_ADDR(folio, segno), sum_blk, sizeof(*sum_bl=
k));
> > > +     folio_mark_dirty(folio);
> > > +     f2fs_folio_put(folio, true);
> > >  }
> > >
> > >  static void write_current_sum_page(struct f2fs_sb_info *sbi,
> > > @@ -2987,7 +2998,7 @@ static int new_curseg(struct f2fs_sb_info *sbi,=
 int type, bool new_sec)
> > >       int ret;
> > >
> > >       if (curseg->inited)
> > > -             write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi,=
 segno));
> > > +             write_sum_page(sbi, curseg->sum_blk, segno);
> > >
> > >       segno =3D __get_next_segno(sbi, type);
> > >       ret =3D get_new_segment(sbi, &segno, new_sec, pinning);
> > > @@ -3046,7 +3057,7 @@ static int change_curseg(struct f2fs_sb_info *s=
bi, int type)
> > >       struct folio *sum_folio;
> > >
> > >       if (curseg->inited)
> > > -             write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi,=
 curseg->segno));
> > > +             write_sum_page(sbi, curseg->sum_blk, curseg->segno);
> > >
> > >       __set_test_and_inuse(sbi, new_segno);
> > >
> > > @@ -3065,7 +3076,7 @@ static int change_curseg(struct f2fs_sb_info *s=
bi, int type)
> > >               memset(curseg->sum_blk, 0, SUM_ENTRY_SIZE);
> > >               return PTR_ERR(sum_folio);
> > >       }
> > > -     sum_node =3D folio_address(sum_folio);
> > > +     sum_node =3D SUM_BLK_PAGE_ADDR(sum_folio, new_segno);
> > >       memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
> > >       f2fs_folio_put(sum_folio, true);
> > >       return 0;
> > > @@ -3154,8 +3165,7 @@ static void __f2fs_save_inmem_curseg(struct f2f=
s_sb_info *sbi, int type)
> > >               goto out;
> > >
> > >       if (get_valid_blocks(sbi, curseg->segno, false)) {
> > > -             write_sum_page(sbi, curseg->sum_blk,
> > > -                             GET_SUM_BLOCK(sbi, curseg->segno));
> > > +             write_sum_page(sbi, curseg->sum_blk, curseg->segno);
> > >       } else {
> > >               mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> > >               __set_test_and_free(sbi, curseg->segno, true);
> > > @@ -3833,8 +3843,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_inf=
o *sbi, struct folio *folio,
> > >       if (segment_full) {
> > >               if (type =3D=3D CURSEG_COLD_DATA_PINNED &&
> > >                   !((curseg->segno + 1) % sbi->segs_per_sec)) {
> > > -                     write_sum_page(sbi, curseg->sum_blk,
> > > -                                     GET_SUM_BLOCK(sbi, curseg->segn=
o));
> > > +                     write_sum_page(sbi, curseg->sum_blk, curseg->se=
gno);
> > >                       reset_curseg_fields(curseg);
> > >                       goto skip_new_segment;
> > >               }
> > > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > > index 1ce2c8abaf48..e883f14c228f 100644
> > > --- a/fs/f2fs/segment.h
> > > +++ b/fs/f2fs/segment.h
> > > @@ -85,8 +85,12 @@ static inline void sanity_check_seg_type(struct f2=
fs_sb_info *sbi,
> > >  #define GET_ZONE_FROM_SEG(sbi, segno)                               =
 \
> > >       GET_ZONE_FROM_SEC(sbi, GET_SEC_FROM_SEG(sbi, segno))
> > >
> > > -#define GET_SUM_BLOCK(sbi, segno)                            \
> > > -     ((sbi)->sm_info->ssa_blkaddr + (segno))
> > > +#define SUMS_PER_BLOCK (F2FS_BLKSIZE / F2FS_SUM_BLKSIZE)
> > > +#define GET_SUM_BLOCK(sbi, segno)    \
> > > +     (SM_I(sbi)->ssa_blkaddr + (segno / SUMS_PER_BLOCK))
> > > +#define GET_SUM_BLKOFF(segno) (segno % SUMS_PER_BLOCK)
> > > +#define SUM_BLK_PAGE_ADDR(folio, segno)      \
> > > +     (folio_address(folio) + GET_SUM_BLKOFF(segno) * F2FS_SUM_BLKSIZ=
E)
> > >
> > >  #define GET_SUM_TYPE(footer) ((footer)->entry_type)
> > >  #define SET_SUM_TYPE(footer, type) ((footer)->entry_type =3D (type))
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index 6e52e36c1f1a..5c323850e298 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -4052,6 +4052,44 @@ static int sanity_check_raw_super(struct f2fs_=
sb_info *sbi,
> > >       if (sanity_check_area_boundary(sbi, folio, index))
> > >               return -EFSCORRUPTED;
> > >
> > > +     /*
> > > +      * Check for legacy summary layout on 16KB+ block devices.
> > > +      * Modern f2fs-tools packs multiple 4KB summary areas into one =
block,
> > > +      * whereas legacy versions used one block per summary, leading
> > > +      * to a much larger SSA.
> > > +      */
> > > +     if (SUMS_PER_BLOCK > 1) {
> > > +             unsigned int required_ssa_blocks;
> > > +             unsigned int expected_ssa_segs;
> > > +             unsigned int total_meta_segments, diff;
> > > +             unsigned int segment_count_ssa =3D
> > > +                     le32_to_cpu(raw_super->segment_count_ssa);
> > > +             unsigned int segs_per_zone =3D segs_per_sec * secs_per_=
zone;
> > > +
> > > +             required_ssa_blocks =3D DIV_ROUND_UP(segment_count_main=
,
> > > +                                                     SUMS_PER_BLOCK)=
;
> > > +             expected_ssa_segs =3D DIV_ROUND_UP(required_ssa_blocks,
> > > +                                                     blocks_per_seg)=
;
> > > +             total_meta_segments =3D
> > > +                     le32_to_cpu(raw_super->segment_count_ckpt) +
> > > +                     le32_to_cpu(raw_super->segment_count_sit) +
> > > +                     le32_to_cpu(raw_super->segment_count_nat) +
> > > +                     expected_ssa_segs;
> > > +             diff =3D total_meta_segments % segs_per_zone;
> > > +             if (diff)
> > > +                     expected_ssa_segs +=3D segs_per_zone - diff;
> > > +
> > > +             if (segment_count_ssa > expected_ssa_segs) {
> >
> > Daeho,
> >
> > Not sure, for an extreme small-sized image, e.g. 64MB, at most, filesys=
tem
> > has 32 segments, so 32 summary blocks are enough? Then, segment_count_s=
sa and
> > expected_ssa_segs could be the same (one segment)? Or am I missing some=
thing?
>
> In that case, segment_count_ssa and expected_ssa_segs will be the
> same, 1. Then, it's fine.
> What do you worry about? Could you elaborate?

Oh, I got your point. Let me think about it.

>
> >
> > Thanks,
> >
> > > +                     f2fs_info(sbi, "Error: Device formatted with a =
legacy "
> > > +                                     "version. Please reformat.");
> > > +                     f2fs_info(sbi, "\tSSA segment count (%u) is lar=
ger "
> > > +                                     "than expected (%u) for block "
> > > +                                     "size (%lu).", segment_count_ss=
a,
> > > +                                     expected_ssa_segs, F2FS_BLKSIZE=
);
> > > +                     return -EOPNOTSUPP;
> > > +             }
> > > +     }
> > > +
> > >       return 0;
> > >  }
> > >
> > > diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> > > index 6afb4a13b81d..a7880787cad3 100644
> > > --- a/include/linux/f2fs_fs.h
> > > +++ b/include/linux/f2fs_fs.h
> > > @@ -17,6 +17,7 @@
> > >  #define F2FS_LOG_SECTORS_PER_BLOCK   (PAGE_SHIFT - 9) /* log number =
for sector/blk */
> > >  #define F2FS_BLKSIZE                 PAGE_SIZE /* support only block=
 =3D=3D page */
> > >  #define F2FS_BLKSIZE_BITS            PAGE_SHIFT /* bits for F2FS_BLK=
SIZE */
> > > +#define F2FS_SUM_BLKSIZE             4096    /* only support 4096 by=
te sum block */
> > >  #define F2FS_MAX_EXTENSION           64      /* # of extension entri=
es */
> > >  #define F2FS_EXTENSION_LEN           8       /* max size of extensio=
n */
> > >
> > > @@ -441,7 +442,7 @@ struct f2fs_sit_block {
> > >   * from node's page's beginning to get a data block address.
> > >   * ex) data_blkaddr =3D (block_t)(nodepage_start_address + ofs_in_no=
de)
> > >   */
> > > -#define ENTRIES_IN_SUM               (F2FS_BLKSIZE / 8)
> > > +#define ENTRIES_IN_SUM               (F2FS_SUM_BLKSIZE / 8)
> > >  #define      SUMMARY_SIZE            (7)     /* sizeof(struct f2fs_s=
ummary) */
> > >  #define      SUM_FOOTER_SIZE         (5)     /* sizeof(struct summar=
y_footer) */
> > >  #define SUM_ENTRY_SIZE               (SUMMARY_SIZE * ENTRIES_IN_SUM)
> > > @@ -467,7 +468,7 @@ struct summary_footer {
> > >       __le32 check_sum;               /* summary checksum */
> > >  } __packed;
> > >
> > > -#define SUM_JOURNAL_SIZE     (F2FS_BLKSIZE - SUM_FOOTER_SIZE -\
> > > +#define SUM_JOURNAL_SIZE     (F2FS_SUM_BLKSIZE - SUM_FOOTER_SIZE -\
> > >                               SUM_ENTRY_SIZE)
> > >  #define NAT_JOURNAL_ENTRIES  ((SUM_JOURNAL_SIZE - 2) /\
> > >                               sizeof(struct nat_journal_entry))
> >

