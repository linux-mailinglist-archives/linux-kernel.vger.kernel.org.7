Return-Path: <linux-kernel+bounces-725605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9382B0014F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2EA1C86E63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154DF2494F0;
	Thu, 10 Jul 2025 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0z6+ZSD"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A236E244694
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149536; cv=none; b=TKjaYeUDslYZTDKaqgAT81k39K55mb19H5CVNq1CoOOavzropvkgK0pkRQmO+mFFDQsnRh75Qa5OOhCyAg6SID8R+mYuftpx3BJEKjV/JsCTfnJcGwZ4LbOd5a6fPvRDfaqTVMgmM4WGLDr6EAD5+X2lqk+yzbtt7edVUdyRshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149536; c=relaxed/simple;
	bh=AH8PUv+euepMKRWca/8bFoBxDHoGj+7/UhyCSRJViVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqN5lmVZRgcpG5do0Imc/mVp2rpX1zjbHj/qNMrMIHhiBw47/SaTpOCborVl3k6PkTBEYwaREqS2ETyMfO7RrpTitw28v45COai2u29/C/0gW0xIZKrt7rOTEzpr9UB8FPhGlWZIOlD9N1AZ1jxTrp4iqiDHfwrFdI4qxMl8mEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q0z6+ZSD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so843161a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752149534; x=1752754334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l5fKQkJlzxFNzCa91Lb1dJiWX0paIysgWrqFRDcZl1w=;
        b=Q0z6+ZSDn4TJj2ibUp7xPOIQ0pr02Ehy7lyQZmOtlkicQYFomWdbjABfE8sP/+v0HQ
         vHIvwUxBz4jnYkWGlzOXaF7Yjyt62QJJdUMDFWHn20RNoE5AluQOXn1xj7yC5Mrvv7EI
         33V/YXu0xp06NiG96NeZEV/GrOuLdR1hbI+NfqjeVS3qhdbsmFn0dANubS24d60q/XEt
         jEpCZ7itKrDB806FGrK6zyBuNiTFz8Pmhouhh8PIeBiLGZlV0wO03LzZ7xUkk7eU0R0z
         tJIKNeKCn4EYw6MQEKnBuZY6vd3i58lbsKPNd4Dlpoa6NwK9dBWuijnO2d96j0tzRt5X
         u3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752149534; x=1752754334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5fKQkJlzxFNzCa91Lb1dJiWX0paIysgWrqFRDcZl1w=;
        b=dmZ5aqIPa2qkB28ghXoqtEdpiMRxc0lnM1YuZXgcL3rJ1A7Ix5WUk48uFq75BeX9I5
         sOzqVz/4hdTJUAlMR3gxTHacfBd4doVZHV4tFffSZdyJHhwLZ1LhZNU8+3DDrGk2mL3C
         IHMWgjQGeAL1GvburkPf+MKr4j3X6KOyGRyBw0xp2Fmg5tsyMYdaXkKsgug6z+lpVIuK
         MkEiQqDv+p6c6Z/Yfp3oSlsl50yVHo0byjRtZKwRuoSWBLr/HVtOtMi2ntVs7tezsjlr
         szblAf8Tu65eXyPFn5yFAAQUTKLez7ui2OPQTO9wu/KibIQzo7shDmTNJX3ph8+DR4uy
         jn6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEqukkh/8KpDBB4A9ytNKrigG33cnTlq2m41qTWsIPNFHCCT4Pd2bY1LciE9LMlD5Jai13hRYa71SOJIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLswUcSgjO/ub1UvkMOcuepnY6CCPL+T/OYuE7vhBT6cVr3FlH
	ziuJtWZHqkcTlrA3opZ19+5a5w90mEEye6eCNxUAyJYNzm9XyWXzmqVzgYVj3i9FCTVedD4lmbM
	LfzWwSnccdp67q+RwR0lso0dfvTvd0z2F5E4pADmGfg==
X-Gm-Gg: ASbGncu5dVEdsjvH8ZrJysAhGZX5UjbbGa0o8MTdSLjx8bF8x8SAzxJeCeFPuw0r1wU
	gZU3TbewYa4fceQTeMh9dHeT7mKDv0sg/PzWrpmEOUb5RAS3uNL84Z7ZpbdEPRDG3bI1RMgE5Ny
	YR7eC6Cd1ApgraW/6sak4hK7OZ7qfulmWH+R0psd27XLRObmJJVocwl1XVyCvYhM1jQJuHSdpK5
	m0S
X-Google-Smtp-Source: AGHT+IFcdBu3ShGiBGJn+ltA7oFTW8H9YPFMEt2jDVSnZb+bs7admyDliyazn/63MyRc/plsPEFqBEjlFwltytTTDLQ=
X-Received: by 2002:a17:90a:d40c:b0:313:d361:73d7 with SMTP id
 98e67ed59e1d1-31c3cf9aaffmr4844081a91.13.1752149533668; Thu, 10 Jul 2025
 05:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707140814.542883-1-yi.zhang@huaweicloud.com> <20250707140814.542883-12-yi.zhang@huaweicloud.com>
In-Reply-To: <20250707140814.542883-12-yi.zhang@huaweicloud.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Jul 2025 17:42:02 +0530
X-Gm-Features: Ac12FXxqcUh80kkxN_CSIp8V6OeaHoAn1HkqXzhs7QI6_m3OzxtvkLSTuknIS9Q
Message-ID: <CA+G9fYtFSzngosVVY=Ps+L=ER4mtMn7eAbpLfMdKMnZNqN4pkA@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] ext4: limit the maximum folio order
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, ojaswin@linux.ibm.com, sashal@kernel.org, jiangqi903@gmail.com, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 19:53, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>
> From: Zhang Yi <yi.zhang@huawei.com>
>
> In environments with a page size of 64KB, the maximum size of a folio
> can reach up to 128MB. Consequently, during the write-back of folios,
> the 'rsv_blocks' will be overestimated to 1,577, which can make
> pressure on the journal space where the journal is small. This can
> easily exceed the limit of a single transaction. Besides, an excessively
> large folio is meaningless and will instead increase the overhead of
> traversing the bhs within the folio. Therefore, limit the maximum order
> of a folio to 2048 filesystem blocks.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Joseph Qi <jiangqi903@gmail.com>
> Closes: https://lore.kernel.org/linux-ext4/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

I have applied this patch set on top of the Linux next tree and performed
testing. The previously reported regressions [a] are no longer observed.
Thank you for providing the fix.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Reference link:
[a] https://lore.kernel.org/all/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/

> ---
>  fs/ext4/ext4.h   |  2 +-
>  fs/ext4/ialloc.c |  3 +--
>  fs/ext4/inode.c  | 22 +++++++++++++++++++---
>  3 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index f705046ba6c6..9ac0a7d4fa0c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3020,7 +3020,7 @@ int ext4_walk_page_buffers(handle_t *handle,
>                                      struct buffer_head *bh));
>  int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>                                 struct buffer_head *bh);
> -bool ext4_should_enable_large_folio(struct inode *inode);
> +void ext4_set_inode_mapping_order(struct inode *inode);
>  #define FALL_BACK_TO_NONDELALLOC 1
>  #define CONVERT_INLINE_DATA     2
>
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 79aa3df8d019..df4051613b29 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1335,8 +1335,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>                 }
>         }
>
> -       if (ext4_should_enable_large_folio(inode))
> -               mapping_set_large_folios(inode->i_mapping);
> +       ext4_set_inode_mapping_order(inode);
>
>         ext4_update_inode_fsync_trans(handle, inode, 1);
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4b679cb6c8bd..1bce9ebaedb7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5181,7 +5181,7 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
>         return -EFSCORRUPTED;
>  }
>
> -bool ext4_should_enable_large_folio(struct inode *inode)
> +static bool ext4_should_enable_large_folio(struct inode *inode)
>  {
>         struct super_block *sb = inode->i_sb;
>
> @@ -5198,6 +5198,22 @@ bool ext4_should_enable_large_folio(struct inode *inode)
>         return true;
>  }
>
> +/*
> + * Limit the maximum folio order to 2048 blocks to prevent overestimation
> + * of reserve handle credits during the folio writeback in environments
> + * where the PAGE_SIZE exceeds 4KB.
> + */
> +#define EXT4_MAX_PAGECACHE_ORDER(i)            \
> +               min(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
> +void ext4_set_inode_mapping_order(struct inode *inode)
> +{
> +       if (!ext4_should_enable_large_folio(inode))
> +               return;
> +
> +       mapping_set_folio_order_range(inode->i_mapping, 0,
> +                                     EXT4_MAX_PAGECACHE_ORDER(inode));
> +}
> +
>  struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>                           ext4_iget_flags flags, const char *function,
>                           unsigned int line)
> @@ -5515,8 +5531,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>                 ret = -EFSCORRUPTED;
>                 goto bad_inode;
>         }
> -       if (ext4_should_enable_large_folio(inode))
> -               mapping_set_large_folios(inode->i_mapping);
> +
> +       ext4_set_inode_mapping_order(inode);
>
>         ret = check_igot_inode(inode, flags, function, line);
>         /*
> --
> 2.46.1
>

--
Linaro LKFT
https://lkft.linaro.org

