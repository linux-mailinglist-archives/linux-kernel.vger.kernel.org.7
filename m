Return-Path: <linux-kernel+bounces-758566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 317BEB1D0DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 04:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10067A5806
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ADE86328;
	Thu,  7 Aug 2025 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxTsUZrB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD39461
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754533030; cv=none; b=Lj8e4v989d6L3BfZutSEaRPb25BvfGReU8dyk189l8HjjPf4hTHALKaa1dsOzPwi/gTjTF6u5ySFZjwRc2LmuY27h7NTBM3VDGAEvagtR6GI7A7zx1tNSYboWIdhZ/DOBTwekZGnFc96s7JdxzyCYSEwZ9Y0iSloFEo9frPrqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754533030; c=relaxed/simple;
	bh=wkliaXFvL9tf/gTZe5R9KQygVRIhjs+PQ2GmO03IRuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSkdiDLeHXqM5rX9x7fVgGcu2NLkOjOTojfVKFT+CvinNNNmKk35k0vTY2TEBmzjSKI2c66CoTgFEemM/yv4e8p+tI4u4nabHyV3z7MMm8teYMIsm0Tsnc07F8lHrjZ6rZZJQjfiVOq+Tfq0tCLLcH0MxFBAOH6+jkN98ZJWEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxTsUZrB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459ea4f40afso918835e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 19:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754533027; x=1755137827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emjKbcLCSNF5Kwzi2fOAO+eIRhNUx/cfK6ZORT1QxHE=;
        b=YxTsUZrB8386OCxN4Ailz9jWAFB0GbifV62LOfwqFw6pS76HREZ5DPn6mbGk1JyhmQ
         JCLFqP6NnsKFQwlyVGgSR53gSwMhJE7BWM+cHi0FUFAdW0mcWR46gHbJoJZTSpkSysL0
         dmJ/98rvvgycivqobqXciU0KS9Ytm3wSuS8QYCbU0wgBpMSGwoChRj2vxg36lr6gPukk
         Tcfp5fHOuSJIaHFBoSe6wsKF1pMKrY8/qq7Cbq1sfNuGn5x5gj1Ihw0Q25PBs/gz5s2a
         w+Rv6WOKjOXJLCMlziZwn2rOHFUwe4M4iTSHNRA+/vvWeDLNW0VWDNOgmnyAAyfzq/BI
         WXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754533027; x=1755137827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emjKbcLCSNF5Kwzi2fOAO+eIRhNUx/cfK6ZORT1QxHE=;
        b=Cq1WQSFIhNm3QC1G87T87+KTkXcdGner4Bm2xAYZxZU8mGmT4f7pz4N9XM3rps2qen
         ldU9gUlQ8dZHlf6rNW8+bFA4reHi5x1akdD3DG3FjjK524buVH94/TJHwV578UX4UT+h
         2d3k+nBxnADQ/4DmnkSGKhLNtM7qK5+NezbUQ1xgzMgCbU+wIasU+h88a7/JeihowTW7
         4RHr+AIXwSwmC9fUQDkeUntAY8idM7hX/FMu0/knEe+223YePjqB8dSzKyvCPbwVjwSu
         yWA/Cjgb+Tg1Whp8W4KjW1X8H/g8yJ8rf/u9ivHv+Kv7CQVZCbk3mged8jmaClsTySje
         DRvA==
X-Forwarded-Encrypted: i=1; AJvYcCXGp+DNz3IVd9Wscf3X644VEb1+EPRcYHQZGKKeCN/X0C5Y7cPj7GxznqEVO7Q5GkIZIESoFfi+LaaqUMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSR0f+u8UGMS2CFkgQrOhYBK1velF5Bb+kR6/qPzKw/dy9TyMe
	GCIbFiYuE1Uxfux0E4+Dj25QeHk+HLs4SlJIWA6NFVR9hbDQfSUwJmxSyIlOn2tTvC6NfC6Kf4I
	CUy7Koy7wVGWAEHmTQjAP8anw+c9hWOA=
X-Gm-Gg: ASbGncvmQFANe8dAn7z40kuFsp/PXDKovoiLBNv99mNY7/n0e+ebBw4DFBF6/hhxLbr
	1/1so5CX1jhCVLQyU//bvbA+pNHva0BsxOpg9WneVZ+FdLxhYcbBmI++6gjnVHnnTusoyGTGcD8
	5BRZ9bDght9kvPgFsYUSZ/jLj5dh/PGUU0bPgzzGdI+dviS7rh4QnsYXOc4p8aOC9wJb0rF2fHv
	1+GwSwt4+SckxtPBvzI0w717HYCyQ==
X-Google-Smtp-Source: AGHT+IHosFPRBu6qdkS0P/9ANurx7HeX4wmp1afJzS7stgR2tcfKH7FgQbFtsoP1L1Gpk+e+c84RDMyHX3ebaxl/lJQ=
X-Received: by 2002:a05:6000:2c0c:b0:3a4:f7ae:7801 with SMTP id
 ffacd0b85a97d-3b8f41ba350mr1653500f8f.8.1754533026692; Wed, 06 Aug 2025
 19:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731084700.1230841-1-chao@kernel.org>
In-Reply-To: <20250731084700.1230841-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 7 Aug 2025 10:16:55 +0800
X-Gm-Features: Ac12FXy4abTVjzlt0lrkD09Avc9qQGimskVCDTgC2N8xRhDE55hHWCAVvZyWSRU
Message-ID: <CAHJ8P3+GJu8ztM85pMUih93RUsDF65n2OUc-F7QPwvGwv2x48w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce flush_policy sysfs entry
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2025=E5=B9=B47=E6=9C=8831=E6=97=A5=E5=91=A8=E5=9B=9B 16:49=E5=86=
=99=E9=81=93=EF=BC=9A
>
> This patch introduces a new sysfs entry /sys/fs/f2fs/<disk>/flush_policy
> in order to tune performance of f2fs data flush flow.
>
> For example, checkpoint will use REQ_FUA to persist CP metadata, however,
> some kind device has bad performance on REQ_FUA command, result in that
> checkpoint being blocked for long time, w/ this sysfs entry, we can give
> an option to use REQ_PREFLUSH command instead of REQ_FUA during checkpoin=
t,
> it can help to mitigate long latency of checkpoint.
>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
>  fs/f2fs/checkpoint.c                    | 10 +++++++++-
>  fs/f2fs/f2fs.h                          |  7 +++++++
>  fs/f2fs/sysfs.c                         |  9 +++++++++
>  4 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/=
testing/sysfs-fs-f2fs
> index bc0e7fefc39d..2fedb44b713b 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -883,3 +883,12 @@ Date:              June 2025
>  Contact:       "Daeho Jeong" <daehojeong@google.com>
>  Description:   Control GC algorithm for boost GC. 0: cost benefit, 1: gr=
eedy
>                 Default: 1
> +
> +What:          /sys/fs/f2fs/<disk>/flush_policy
> +Date:          July 2025
> +Contact:       "Chao Yu" <chao@kernel.org>
> +Description:   Device has different performance for the same flush metho=
ds, this node
> +               can be used to tune performance by setting different flus=
h methods.
> +
> +               policy value            description
> +               0x00000001              Use preflush instead of fua durin=
g checkpoint
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index bbe07e3a6c75..10cc27158770 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1419,7 +1419,9 @@ static void commit_checkpoint(struct f2fs_sb_info *=
sbi,
>         f2fs_folio_put(folio, false);
>
>         /* submit checkpoint (with barrier if NOBARRIER is not set) */
> -       f2fs_submit_merged_write(sbi, META_FLUSH);
> +       f2fs_submit_merged_write(sbi,
> +               sbi->flush_policy & BIT(FLUSH_POLICY_CP_NO_FUA) ?
> +               META : META_FLUSH);
>  }
>
>  static inline u64 get_sectors_written(struct block_device *bdev)
> @@ -1606,6 +1608,12 @@ static int do_checkpoint(struct f2fs_sb_info *sbi,=
 struct cp_control *cpc)
>         f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
>         stat_cp_time(cpc, CP_TIME_WAIT_LAST_CP);
>
> +       if (sbi->flush_policy & BIT(FLUSH_POLICY_CP_NO_FUA)) {
> +               err =3D f2fs_flush_device_cache(sbi);
> +               if (err)
> +                       return err;
> +       }
Hi Chao,
sorry for late interruption.
f2fs_flush_device_cache is just used for multi device cases, so this patch =
will
not be suitable for a single device if the user changes flush_policy
by sysfs, otherwise it
will not use FUA write when committing checkpoint? Is this expected?
Thanks!
> +
>         /*
>          * invalidate intermediate page cache borrowed from meta inode wh=
ich are
>          * used for migration of encrypted, verity or compressed inode's =
blocks.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5c0ea60e502e..5bba24ca15c8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1621,6 +1621,11 @@ struct decompress_io_ctx {
>  #define MAX_COMPRESS_LOG_SIZE          8
>  #define MAX_COMPRESS_WINDOW_SIZE(log_size)     ((PAGE_SIZE) << (log_size=
))
>
> +enum flush_policy {
> +       FLUSH_POLICY_CP_NO_FUA,
> +       FLUSH_POLICY_MAX,
> +};
> +
>  struct f2fs_sb_info {
>         struct super_block *sb;                 /* pointer to VFS super b=
lock */
>         struct proc_dir_entry *s_proc;          /* proc entry */
> @@ -1873,6 +1878,8 @@ struct f2fs_sb_info {
>         /* carve out reserved_blocks from total blocks */
>         bool carve_out;
>
> +       unsigned int flush_policy;              /* flush policy */
> +
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>         struct kmem_cache *page_array_slab;     /* page array entry */
>         unsigned int page_array_slab_size;      /* default page array sla=
b size */
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index f736052dea50..b69015f1dc67 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -852,6 +852,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>                 return count;
>         }
>
> +       if (!strcmp(a->attr.name, "flush_policy")) {
> +               if (t >=3D BIT(FLUSH_POLICY_MAX))
> +                       return -EINVAL;
> +               *ui =3D (unsigned int)t;
> +               return count;
> +       }
> +
>         if (!strcmp(a->attr.name, "gc_boost_gc_multiple")) {
>                 if (t < 1 || t > SEGS_PER_SEC(sbi))
>                         return -EINVAL;
> @@ -1175,6 +1182,7 @@ F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
>  #endif
>  F2FS_SBI_GENERAL_RW_ATTR(carve_out);
>  F2FS_SBI_GENERAL_RW_ATTR(reserved_pin_section);
> +F2FS_SBI_GENERAL_RW_ATTR(flush_policy);
>
>  /* STAT_INFO ATTR */
>  #ifdef CONFIG_F2FS_STAT_FS
> @@ -1371,6 +1379,7 @@ static struct attribute *f2fs_attrs[] =3D {
>         ATTR_LIST(max_read_extent_count),
>         ATTR_LIST(carve_out),
>         ATTR_LIST(reserved_pin_section),
> +       ATTR_LIST(flush_policy),
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(f2fs);
> --
> 2.49.0
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

