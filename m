Return-Path: <linux-kernel+bounces-758650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A805B1D20A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7C97B0916
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9961EB9E3;
	Thu,  7 Aug 2025 05:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plo4Y/9q"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A0BE46
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 05:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544705; cv=none; b=TRkdYU7fGjSrSAUJBGRLNIe7y/Bhk1y/C3hlhphvShGMJ1PxPGpW1RvbehTTsmw9ek4TB10Nw29wLEPg0Xoa1ugpL9wKlqZ9QwNKgB72AIQIXpv71F6I8gIKX/IoFP7giVE1FkEY8Fws8oahGuJtZbKOOCIyHe4ujjURfUA5SAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544705; c=relaxed/simple;
	bh=AS6s4IT1YzGRsUIdjsSPDVN0moYEi0p2uCvIfsfOCZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZaNk26OlSpRW82uShnnp5Iw4bPfLHSOznn66321PSktNXqkN73JQyPEtj+luEabbx84bIOyEy0FSAggko8lOiDsWQvNERSMGnL7rlXuOnu/Aj5IoVYYRAjnBMq8mosJS8Pcqc4PAutTkhmfgVkH0XQVjTCG56rJ9NwfJyCU9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plo4Y/9q; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b780e4fb03so71134f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 22:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754544702; x=1755149502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njZCyAMu9kVs+e9nxOAr6y+cEt3JyrSwGOU1aOFwKhw=;
        b=Plo4Y/9qYtQwerDs0NMgUOEU3PcsWX1xxq4If54bBc5WnVblP84WC9sGR/e5BOfCqO
         pZcAGBemVrC1084OZ4tUl6Wl/wOHJsKcz9GDImnOOWFeF+M3x7oOk3cFmCdAupZvGYA3
         eUtVSCV86GuBlrJFszbvkTcWwZwR0RzLAL8zyG69ZsVdbEzZOruV5f4rSXN83DcafJsq
         JFeE7uWwEmfuPgiLn/oyK1lEGBdjPEx6ZH22i2QkmyeIeL5+53leTlFWqphyGIR5PU+A
         IA2Msr0DbruDbGrmFF7lAlfu+phUkKfsJJIyyagON8/eH2lYHEZDQtkc4Y0pUZtno2in
         dPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754544702; x=1755149502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njZCyAMu9kVs+e9nxOAr6y+cEt3JyrSwGOU1aOFwKhw=;
        b=eL8agCp/vnZbi+tzsXNMYQwmx92X0D2mrJLXHg5hSXyRDzlevAhda/B+SvDBbO+oHL
         2GiZYKzzkisECmYKGTo71iBFBin+jRKcQiVc425ATpM4Bu/HKvx327ibef/SSzw+2WoH
         GFDNt/3n1MaC3NW5XLoXhgQVf28MA6w76zS7N6fQ6pWubpCEU2e1zsoMxuwpE2Dl4XlX
         EB4/+b6UQvNTOEQqL8gO6jDf5sZNxyn6JB4puzddeMq65snxoChilXXbGnLi10V9NeVE
         tEdGLfRe2qxGZkYESyw3EIex/cSwIoDsJyhkWvnyCIPcrVNUQbjAKjCnVIshmm3ptw6j
         YQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUKlSooGKydZ5Yc1yHapZOI9WU9E92LTiX4m/yjtXy1ZlMqUTYBX7h4cOO7mN/RR9DK+gwxQ2EJOvOZuNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUPAyM94OT8GGLfP2iT5JSz+NrtOLVF4373JtTBBA0+MhRvSl
	kUs5Hml7YvAYlJUiEi7zZafo0GCbRfUY16tIyc9MqHPlSA09ODwgVHh77z152neiSEoErB7Aoqo
	+gLxp6AvZ3GVYqqiHtyXvznmFJybVe4o=
X-Gm-Gg: ASbGncslrkUQFJVWwbLqKni1BlZwNcm4HxKiRVY9iMIZyEAB5KXsxMS1En1GiEfLAtY
	Sps22qyW09jPxkNPuXh9AHMSXOffMy5zl+bLtE6JwFRV9WOvK3ureu8SCriQcYkGnovL/oi1WCy
	2u+xISLoe8OamZLhu4yNpkge9Sc1g0yJETR7tc0iW5cRNoGNWMONn1QPiBraHFxCNkXAfNvyge7
	DDkL+vK
X-Google-Smtp-Source: AGHT+IFm5LqeXhOW47Zl3FuUL7jTfekl2INwaEKG+Hodxz8s4tdxlmAYh783y41tz/50OledFd6Ggn0PWg/Yt6oNqvA=
X-Received: by 2002:a05:600c:3d95:b0:459:4441:1c13 with SMTP id
 5b1f17b1804b1-459e710369bmr21082195e9.6.1754544701297; Wed, 06 Aug 2025
 22:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807034838.3829794-1-chao@kernel.org>
In-Reply-To: <20250807034838.3829794-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 7 Aug 2025 13:31:30 +0800
X-Gm-Features: Ac12FXy7DHOlFps8GQ9i084054Llw7QNVpciKeEv5CLYspV6oxEmfwjDo9keYCI
Message-ID: <CAHJ8P3+tT70BLK38ROh_jiZO-OBWGXDSu65Q0w+ppMW0QHSFSA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: introduce flush_policy sysfs entry
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2025=E5=B9=B48=E6=9C=887=E6=97=A5=E5=91=A8=E5=9B=9B 11:50=E5=86=99=
=E9=81=93=EF=BC=9A
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
> v3:
> - export f2fs_submit_flush_wait()
looks good to me.
Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

>  Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
>  fs/f2fs/checkpoint.c                    | 11 ++++++++++-
>  fs/f2fs/f2fs.h                          |  9 +++++++++
>  fs/f2fs/segment.c                       |  8 ++++----
>  fs/f2fs/sysfs.c                         |  9 +++++++++
>  5 files changed, 41 insertions(+), 5 deletions(-)
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
> index db3831f7f2f5..2450e382fe6b 100644
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
> @@ -1594,6 +1596,13 @@ static int do_checkpoint(struct f2fs_sb_info *sbi,=
 struct cp_control *cpc)
>
>         __set_cp_next_pack(sbi);
>
> +       /* flush device cache to make sure last cp pack can be persisted =
*/
> +       if (sbi->flush_policy & BIT(FLUSH_POLICY_CP_NO_FUA)) {
> +               err =3D f2fs_submit_flush_wait(sbi, sbi->sb->s_bdev);
> +               if (err)
> +                       return err;
> +       }
> +
>         /*
>          * redirty superblock if metadata like node page or inode cache i=
s
>          * updated during writing checkpoint.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 46be7560548c..e7b866a98c92 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1594,6 +1594,11 @@ struct decompress_io_ctx {
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
> @@ -1845,6 +1850,8 @@ struct f2fs_sb_info {
>         /* carve out reserved_blocks from total blocks */
>         bool carve_out;
>
> +       unsigned int flush_policy;              /* flush policy */
> +
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>         struct kmem_cache *page_array_slab;     /* page array entry */
>         unsigned int page_array_slab_size;      /* default page array sla=
b size */
> @@ -3821,6 +3828,8 @@ int f2fs_commit_atomic_write(struct inode *inode);
>  void f2fs_abort_atomic_write(struct inode *inode, bool clean);
>  void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need);
>  void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg);
> +int f2fs_submit_flush_wait(struct f2fs_sb_info *sbi,
> +                               struct block_device *bdev);
>  int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino);
>  int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
>  int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index cc82d42ef14c..d68c903f1ad3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -544,7 +544,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, boo=
l from_bg)
>         f2fs_sync_fs(sbi->sb, 1);
>  }
>
> -static int __submit_flush_wait(struct f2fs_sb_info *sbi,
> +int f2fs_submit_flush_wait(struct f2fs_sb_info *sbi,
>                                 struct block_device *bdev)
>  {
>         int ret =3D blkdev_issue_flush(bdev);
> @@ -562,12 +562,12 @@ static int submit_flush_wait(struct f2fs_sb_info *s=
bi, nid_t ino)
>         int i;
>
>         if (!f2fs_is_multi_device(sbi))
> -               return __submit_flush_wait(sbi, sbi->sb->s_bdev);
> +               return f2fs_submit_flush_wait(sbi, sbi->sb->s_bdev);
>
>         for (i =3D 0; i < sbi->s_ndevs; i++) {
>                 if (!f2fs_is_dirty_device(sbi, ino, i, FLUSH_INO))
>                         continue;
> -               ret =3D __submit_flush_wait(sbi, FDEV(i).bdev);
> +               ret =3D f2fs_submit_flush_wait(sbi, FDEV(i).bdev);
>                 if (ret)
>                         break;
>         }
> @@ -748,7 +748,7 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
>                         continue;
>
>                 do {
> -                       ret =3D __submit_flush_wait(sbi, FDEV(i).bdev);
> +                       ret =3D f2fs_submit_flush_wait(sbi, FDEV(i).bdev)=
;
>                         if (ret)
>                                 f2fs_io_schedule_timeout(DEFAULT_IO_TIMEO=
UT);
>                 } while (ret && --count);
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

