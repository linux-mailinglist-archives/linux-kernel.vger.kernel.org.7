Return-Path: <linux-kernel+bounces-747343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB38FB132C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56BA1717A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 01:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665B518B47D;
	Mon, 28 Jul 2025 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjkwVSbk"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD072AD2C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753666184; cv=none; b=p40Hz2i8YgLbE3Uwf3aaPn4RNaqfFyep8vXZ+/v/6RNAa++lsnsoqiGYY7afSmmkUdBwSlzno0LksFpcHbnMpcH54yqwNZPrVm86mQ/0u+wAcD4nZas56jnoFi+HVpDdWn1zgCh1kJBZxzuXJ1G11lF87L33LaDeU0sWtZZCSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753666184; c=relaxed/simple;
	bh=/Heo0XbK2scB1YsT2b5Pzs85Zg+YVkvBv1J7MlRDUPE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=THBvIZBsBk5VrSpSt98T6XMzyBdfoi8elKwwvvXPYiBTZdXQb6q0dfLI2z8o8O9AsR4N/2nD8ueIdFIqzOJtV6m6hUGXhxvgNxt4M9aC0O56uJFL8XkQW2CLQpxgy/9QkHZfVYmv/2JWD6XaHdE8QErk00YsWGFDCfJHF22P5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjkwVSbk; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71967cd1072so37002087b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753666181; x=1754270981; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QXzodV/jBlhC38ImoktgPqG+GQYIP1R1NbRSdleQsxw=;
        b=tjkwVSbk1n6lNBe0U0jJFV/P9K82ZNFHbz5kaZMuP1/33QFEIeULXfFMJCOQSW6V4Y
         XkMdD05vecIoudjalcrwNEIUroBuMF2bP0LJuNqV/Vooz8NtZzGQyTwNUoQKZ4IVSTfM
         ebLj7Gi06CrpQQGjXOSpHWQRFGby0cZ90KZSrV4hidOb8U0Db5ruRz1QiuZiO2aFlnAx
         dJpRBszmh094ZSSVcKf4Co3FjFQSkMe4AIFEyUtnRVQB3KKwG2Q/xyrgfg75AvM7UUSP
         jlk4tins7gKDzJi00kmprDhOz8rnjzdpDLM+Aqh01mcEe3FdM5NcKZuMNd54277c5Ble
         3gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753666181; x=1754270981;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXzodV/jBlhC38ImoktgPqG+GQYIP1R1NbRSdleQsxw=;
        b=wtaKdGaKAll7bhuPGpFLBuarFy+EEucECeIopo/F7pFn8e9UKCck8EiNNNs6/Af4+F
         yWgZxQt/syBnc5obiqDIxn8+jy+e2F40lc05kdXzbaJzBBcIa17RjNV9XBRcEqiJGvsK
         oQbD3T/3Dz6MIxZ/rppskwYWffBRX0AbaarJPUmuIzk+nLMeodcqflrlWmpDyzE7COlp
         zt08CLgrPO/JSajUuvYKNlh6l1JblN+OH7H1AeOczLUq8c0MZQMuFwwMhj9Ue53TaHsa
         izv9aA/50HIkFIFL+Bh4L8LMm702iVIl6P9DNCHo3zIGIuV86wwKTsVokoyHHYzt3sFZ
         Y5ng==
X-Forwarded-Encrypted: i=1; AJvYcCU9HvKpgALWVdqp2sjPHGhyOyXhA6k/XrNLSoIMHYswrAlyEcU/lJMTrGqP8OLh8DrUG5c4j5TRLuAtuAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzcgi2MaDQ0RO42RHFAtBJ7McgH9b0wjC2ayTZlBvszrH5ov5j
	v87Eji4DzfPl48swC9z65t/rrXw1oZog6qSGVVXzq+FTwrIsdjYEVp3vMf094rwzYg==
X-Gm-Gg: ASbGncuikwwa7wlV0xCG46GOB79xJrApFEriMAVCPKWvVIaeBQkwDW/qsqaLWiVtcoI
	dV77vnyt2sZVL8Gqdy+Xdj9/iQyPhW8IEPFgryVlC6jQzJxeOkqVyFW8jHtQASs9YZi4c2cwzVH
	V+teAsvA+DX1EXYNpKA8ttwruzCkoRuh+FUC9FopesxxqATnaUVumFakV5FxhZ43fP8D0geED1L
	DX8voEa2F+JOoDF5Sl794G3bbYv+Wmit6IwdT9zFXtFCbfP4OM0fHhleLNXTQPfzfwCrpGnxxiQ
	3rY5F63ej6+krARmQ90MJvFnm9b9wI8sfBIstcBDockm45X4IWXIaN+JAgo/Amswyarvqgdl2WN
	zqpzeRDJ18y3C0UoOFRCsqTvoDNL48NaetYa36bmO4yzaAWV/ghBEa0MW1BYGcEwtV8pYvHUS0v
	/GB9GvAlU=
X-Google-Smtp-Source: AGHT+IHyl1uoYTE/3bxt0XxcnIs92jhdJgwHAJKa/Ig8u6IhOgcUFj/dbVcmdAEuHHoRMFXxQNCwcw==
X-Received: by 2002:a05:690c:4907:b0:718:37f7:66fa with SMTP id 00721157ae682-719e3461618mr115753457b3.30.1753666180336;
        Sun, 27 Jul 2025 18:29:40 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f23e48e7sm10357757b3.81.2025.07.27.18.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 18:29:39 -0700 (PDT)
Date: Sun, 27 Jul 2025 18:29:29 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Christian Brauner <brauner@kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    Klara Modin <klarasmodin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
    Anuj Gupta <anuj20.g@samsung.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 11/14 for v6.17] vfs integrity
In-Reply-To: <20250725-vfs-integrity-d16cb92bb424@brauner>
Message-ID: <0f40571c-11a2-50f0-1eba-78ab9d52e455@google.com>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-integrity-d16cb92bb424@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Jul 2025, Christian Brauner wrote:

> Hey Linus,
> 
> /* Summary */
> This adds the new FS_IOC_GETLBMD_CAP ioctl() to query metadata and
> protection info (PI) capabilities. This ioctl returns information about
> the files integrity profile. This is useful for userspace applications
> to understand a files end-to-end data protection support and configure
> the I/O accordingly.
> 
> For now this interface is only supported by block devices. However the
> design and placement of this ioctl in generic FS ioctl space allows us
> to extend it to work over files as well. This maybe useful when
> filesystems start supporting PI-aware layouts.
> 
> A new structure struct logical_block_metadata_cap is introduced, which
> contains the following fields:
> 
> - lbmd_flags:
>   bitmask of logical block metadata capability flags
> 
> - lbmd_interval:
>   the amount of data described by each unit of logical block metadata
> 
> - lbmd_size:
>   size in bytes of the logical block metadata associated with each
>   interval
> 
> - lbmd_opaque_size:
>   size in bytes of the opaque block tag associated with each interval
> 
> - lbmd_opaque_offset:
>   offset in bytes of the opaque block tag within the logical block
>   metadata
> 
> - lbmd_pi_size:
>   size in bytes of the T10 PI tuple associated with each interval
> 
> - lbmd_pi_offset:
>   offset in bytes of T10 PI tuple within the logical block metadata
> 
> - lbmd_pi_guard_tag_type:
>   T10 PI guard tag type
>     
> - lbmd_pi_app_tag_size:
>    size in bytes of the T10 PI application tag
> 
> - lbmd_pi_ref_tag_size:
>    size in bytes of the T10 PI reference tag
> 
> - lbmd_pi_storage_tag_size:
>   size in bytes of the T10 PI storage tag
> 
> The internal logic to fetch the capability is encapsulated in a helper
> function blk_get_meta_cap(), which uses the blk_integrity profile
> associated with the device. The ioctl returns -EOPNOTSUPP, if
> CONFIG_BLK_DEV_INTEGRITY is not enabled.
> 
> /* Testing */
> 
> gcc (Debian 14.2.0-19) 14.2.0
> Debian clang version 19.1.7 (3)
> 
> No build failures or warnings were observed.
> 
> /* Conflicts */
> 
> Merge conflicts with mainline
> =============================
> 
> No known conflicts.
> 
> Merge conflicts with other trees
> ================================
> 
> No known conflicts.
> 
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:
> 
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
> 
> are available in the Git repository at:
> 
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.integrity
> 
> for you to fetch changes up to bc5b0c8febccbeabfefc9b59083b223ec7c7b53a:
> 
>   block: fix lbmd_guard_tag_type assignment in FS_IOC_GETLBMD_CAP (2025-07-23 14:55:51 +0200)
> 
> Please consider pulling these changes from the signed vfs-6.17-rc1.integrity tag.
> 
> Thanks!
> Christian
> 
> ----------------------------------------------------------------
> vfs-6.17-rc1.integrity
> 
> ----------------------------------------------------------------
> Anuj Gupta (5):
>       block: rename tuple_size field in blk_integrity to metadata_size
>       block: introduce pi_tuple_size field in blk_integrity
>       nvme: set pi_offset only when checksum type is not BLK_INTEGRITY_CSUM_NONE
>       fs: add ioctl to query metadata and protection info capabilities
>       block: fix lbmd_guard_tag_type assignment in FS_IOC_GETLBMD_CAP
> 
> Arnd Bergmann (1):
>       block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()
> 
> Christian Brauner (1):
>       Merge patch series "add ioctl to query metadata and protection info capabilities"
> 
>  block/bio-integrity-auto.c        |  4 +--
>  block/blk-integrity.c             | 70 ++++++++++++++++++++++++++++++++++++++-
>  block/blk-settings.c              | 44 ++++++++++++++++++++++--
>  block/ioctl.c                     |  6 ++++
>  block/t10-pi.c                    | 16 ++++-----
>  drivers/md/dm-crypt.c             |  4 +--
>  drivers/md/dm-integrity.c         | 12 +++----
>  drivers/nvdimm/btt.c              |  2 +-
>  drivers/nvme/host/core.c          |  7 ++--
>  drivers/nvme/target/io-cmd-bdev.c |  2 +-
>  drivers/scsi/sd_dif.c             |  3 +-
>  include/linux/blk-integrity.h     | 11 ++++--
>  include/linux/blkdev.h            |  3 +-
>  include/uapi/linux/fs.h           | 59 +++++++++++++++++++++++++++++++++
>  14 files changed, 213 insertions(+), 30 deletions(-)

It would be great if Klara's patch at
https://lore.kernel.org/lkml/20250725164334.9606-1-klarasmodin@gmail.com/
could follow just after this pull: I had been bisecting -next to find out
why "losetup /dev/loop0 tmpfsfile" was failing, and that patch fixes it -
and presumably other odd failures for anyone without BLK_DEV_INTEGRITY=y.

Thanks,
Hugh

