Return-Path: <linux-kernel+bounces-758604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A38AB1D14B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23EC0188DA85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDA31CAA65;
	Thu,  7 Aug 2025 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxU14lLV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667A3208
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754538481; cv=none; b=H1aUguPzY9VuoJRxSEReSAAkOWoLkoz65NN1d03dNivDlPAXeT6lMrnbPV7E83jszlwb9oDkvs2TpepWdsbE3u9qfTPq3W6/5scFZcrtlWlIL35MkoAISLaurItBkPAxYeOBRViHrrsJ8e/Pvs/j3X4Z/Wug6/wWKHcCia+MV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754538481; c=relaxed/simple;
	bh=MQa68olvsewbD7tAouOqgJ/kUBzOL2SkBZA57KMg3tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkU2LkyEkWeYj5s/2FEV27QC5wid4XWJjM+6nvyK9gfxiR41Y5a919na3Z7BSjzgMxwVQWsFf9Njl2ZOykX2Yy7q0HsaXnHcGtpeLvy03zXCW7GyMiP/ZfXU8TX+2GpMTsc//+UbN/4iPwUdfk8nhiwRI4tsd94L8bhYT1hHyuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxU14lLV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4594440145cso850595e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 20:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754538478; x=1755143278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AccB817uW9Z1ldXTkpaOZgtO+G8kpHCoO5sj1SyUU4Y=;
        b=IxU14lLV9uABlsas3S+CNbw0++Hs4PYkjJ5bIp/w2Q6TBfZvZsL9iqLbPvIkcj2ti1
         ub5PJo2fp3c0m2QA1W6MfMS0RFG5fZ+QGR03MCkrxXxZA48EKAqmQU5Da4oeKxqAIF0J
         GP4xpOm3C310zpfFtC0gbMINlIr6lcm2Spl0aFdwoa3mfA+kSbkO5eqrHVbTRY6Q63ew
         YghuzeAJ9TRi03WAlfkLExp7VJHh5mUkmYzCiL9NokxDODyDG3FWD0sQcYCGRNy6T5zt
         /aoVChwGctmnst0q4qkm/pab8DyfOlsvbI3i05VDcKttILNUcJWcihNfZ5Vo+FlguQhk
         JwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754538478; x=1755143278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AccB817uW9Z1ldXTkpaOZgtO+G8kpHCoO5sj1SyUU4Y=;
        b=G6ZgvwJfhJW0wHKjROYuBw/BrCso8lCXsUBrD+RUa81PDfqKUbmQZklVIcHDYB1c09
         RV41AsgA5vE20iKEM9fiSeHLflTQ7OoVjTcxEGJOhIzcmoYpOL021SoU1AMraZeM3cOx
         EKnDvgKIyrkBbrhXWZ7gWOAo6dNtRZDMrzSDDVblXwQuyFLPf6VaubHf0LkpqqUN0G5y
         fE3nQtgtENIjY7AHIbN1Ku/aNo3eyghiR+Q4v/f8tLEeIUsu/Lt3fTk04EXlzDn0rZlC
         9L4jaEMQFm6HdR8mlsqnlahP1RrYDydH/0uokFXGOnK9jSVaWdrDmzkHaXyEEM4I+tAn
         JnBw==
X-Forwarded-Encrypted: i=1; AJvYcCXS4NOpaoZ32uD5w82eYpcvT4kJC0kkDQOxMiOZIKZ+xfFI+JvgIEDWpjo00DEcob4MiXxZaK9RpnnxPuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdAwpoBME5Ho64M9sSIrEivygSufT55nay3AWv/HMaVxUdkEc
	9CokIe8jXN8HcEwJ3iLP5mKyYsCw+BjD6PgNqOyNVnnm4UgLTi93Wejjz1NnQONPojbeN1lPS4H
	NyDnODhTj7yInGRfdKXeV9fM/uYIg508=
X-Gm-Gg: ASbGncsl6pp9aMlmIAbymuBGHu1eiTcGhO7t3M6bATKeiWiT+1j1VvvNn9jfOnoXM2r
	NlFAtSH7pmT46BRK8x4hXTTvfiLvd0vrDY6U9ZJrxGpDioAidcrQMz/tJ+p/EVTjaZujk0PU+Hr
	ls+lMU/luLCU/7kbAm5jLS/0Q9F63vBKOpVd23wUQsyJ/gnZ5taLdbQdqk5SQPmAvRTk5aazfEE
	n1QU3hD
X-Google-Smtp-Source: AGHT+IG5NhqzP9cPRq4GUvf4m+7Dubrfw/7RdQzbNISOzR+ffeKHG5cpCPqlTCi3wTjh/z+MUT6Vf67hQt3sQsbiawU=
X-Received: by 2002:a05:600c:348b:b0:43b:c844:a4ba with SMTP id
 5b1f17b1804b1-459e7105b64mr19849455e9.3.1754538477436; Wed, 06 Aug 2025
 20:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807032406.3817056-1-chao@kernel.org>
In-Reply-To: <20250807032406.3817056-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 7 Aug 2025 11:47:46 +0800
X-Gm-Features: Ac12FXxBYIv3So14Gs9o02UWkKJ243W16c2f6tIN2hppfxW8_1vL7AyDGn_iLb8
Message-ID: <CAHJ8P3L9VRghpbpn=ndQQfDXKjit=5PY28yR_19mnbgvda1LxQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce flush_policy sysfs entry
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2025=E5=B9=B48=E6=9C=887=E6=97=A5=E5=91=A8=E5=9B=9B 11:27=E5=86=99=
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

Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> v2:
> - use __submit_flush_wait() instead of f2fs_flush_device_cache() to
> just flush primary device cache
>  Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
>  fs/f2fs/checkpoint.c                    | 11 ++++++++++-
>  fs/f2fs/f2fs.h                          |  7 +++++++
>  fs/f2fs/sysfs.c                         |  9 +++++++++
>  4 files changed, 35 insertions(+), 1 deletion(-)
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
> index db3831f7f2f5..fafa2156732d 100644
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
> +               err =3D __submit_flush_wait(sbi, sbi->sb->s_bdev);
> +               if (err)
> +                       return err;
> +       }
> +
>         /*
>          * redirty superblock if metadata like node page or inode cache i=
s
>          * updated during writing checkpoint.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 46be7560548c..5db5eba4cbd7 100644
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

