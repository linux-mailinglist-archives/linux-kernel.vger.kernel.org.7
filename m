Return-Path: <linux-kernel+bounces-595015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B75EA81909
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 00:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABB73AA7B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 22:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FAB2561BB;
	Tue,  8 Apr 2025 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vW5fBzAe"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562EB2405EB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152663; cv=none; b=VMBtZ22EFiQ2KwlbjuUzjVSQvWUGt2kiYKfuDeSmDV53229nDwOlNp2kbRMfgM7/FTMnl40LGdOAYmt7ZER/gfpwwZBAWAPJvzPf7M7quzQiV+bRk80ijbV3oQXfVk2LJivpV6+i9Rny05EUA82Dd1cyJyMGlKkioSFmiOUKIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152663; c=relaxed/simple;
	bh=vMn/pqlIgdXeLiIiX6Qi2jw179hC4RQghNBS8hGqYZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0zLxmX6+C7xEGFwLZmkyPhrx5uysAQd+sb4PSAiNyYFEFEl7O0PmPq9X/GBP1KUkgCM4/sO7ZvAV9Wwk2KbkJswDRSrPVeumxO1gH48ka1S3jP3dUjUVW6mnDa1Md9FYLz9pe2aGGN94LHSQqUmlLi9vTQvijGu5YPbWBRB24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=vW5fBzAe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7398d65476eso121729b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744152661; x=1744757461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4e6TcScSbS46TYPzeS1oWS93atKNlcHoXycK2oxcMQ=;
        b=vW5fBzAe0imxu4fNHVLF4G0+rBz6dchsprA38wmkFpTUyJDs6MmA0hRVK/3TJEarkR
         wcOFCYgPGCGbQxejqah1vjSnYWaXl0Llt8YGa3+DTV/7ykPq0WdD21xS7uJ0HWEwy1W+
         vduYKCqV9Vb+QmQEkayZNQpKBCaFWcN4XG9PYDTduUz/euckEU4pCV1wLbfeRWF581FW
         23v7nbe75gdUBCvuyyczWq7xsX14MWOIYjs6iktc4bOM0b6I9ByH6sGQEfQ84LGPztfG
         RnI46D+hkTBe7mJ49Iu6Ggr54GFr/RqMqjyuan0gzOJ1Bo0AevAjEMsb7A4H8f53AL/O
         C3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744152661; x=1744757461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4e6TcScSbS46TYPzeS1oWS93atKNlcHoXycK2oxcMQ=;
        b=c5Mah1MxLGKRj5f/f+Ulryyq7EiOeDWJwWx1GuS9Hrn3a2T3T2qH7Ou2b2XAo6jViM
         JhY3/Endk+BrG0MOlORgV2R+P1lxm1ESSYGvbIJ2d1vvDyrSk5nHUfJDjyGBUQ7ECDSM
         ugBjaZK/qh+wij1PlOzdlKZEqyZymz/KoSlLt+iaO9nWN6Vn+u53mLdm7If9lY+mU9T9
         hWjT7JZmQGB6Z5rjPnq1Uz40WLldw1Imh10lL1kgoEhOwyMqiq/MiaFFsaa/kZc7P6Cj
         AJnKsCnJxsAxBBaiqCRTifj0Y9xOFNeMmNm0eY6S4f2VXhwvqNoPLiVoDDFxAz8Wp1rc
         bruw==
X-Forwarded-Encrypted: i=1; AJvYcCWagwU72g0aVHc/RP+l6I2CeFw0N4DTib0UXZ1Px1z/Wdwm9wT1AIUK7HFEswB7m5u/kp4f66B54nbdjpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwshVsf4RedTCBRWvv7UtqPr/nqziYOUEiZP29TmS9immLFX92t
	FVD/PtNm1a+rqRAO1wKJmiTztzlTAwKSDyk2c9Xb+Jrny34HC2wkpwY15IM2ioo=
X-Gm-Gg: ASbGnct0Vdzxa31O7VxXk978Krs0Ayk44X11u52lVk5gaYA93rEMmNjv0jqOo+OkCHS
	tRw0dSoa7XMFSKtuj8ZrzPLHRicJI11zgkL14l6hObD4XPzjm/GepQZ8Ic+W2KkJXEczY525L4P
	Kyl4m/9W0QXyS/N+eNyZ0sibuK7iGFS/m3eYL5Sx21sjV6ktgNLdp4UXZtweFUwCtFUBT6y86ma
	d05nKWBbARM07waFgEYeUSBAJITjy110AAYsUT9cGSIldEQui9AW4Jy1BMB9YDBsAoFkCAxNhfs
	KL+88zIFAsMhiLo2Ngrseuv76LD+ervDoqWScv4/xd6kGuQPG8a0IqkvnqAUBHHiooF1VKdI2BY
	PTn7I3/TGi1cN46kaRbILBMOeV8Re
X-Google-Smtp-Source: AGHT+IH1vqfq5KmC7q977AO5WgEcrZQ60lrohQ1dtQpSWtpSiqHurs35gj5R27z5qJYFLZ4y41PN8w==
X-Received: by 2002:a05:6a00:2411:b0:734:ded8:77aa with SMTP id d2e1a72fcca58-73bae4cc284mr829197b3a.9.1744152661136;
        Tue, 08 Apr 2025 15:51:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0a71sm11117925b3a.113.2025.04.08.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 15:51:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u2HmT-00000006F85-0aHp;
	Wed, 09 Apr 2025 08:50:57 +1000
Date: Wed, 9 Apr 2025 08:50:57 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 02/12] xfs: add helpers to compute log item overhead
Message-ID: <Z_WoUawfJ_QFF5kP@dread.disaster.area>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408104209.1852036-3-john.g.garry@oracle.com>

On Tue, Apr 08, 2025 at 10:41:59AM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Add selected helpers to estimate the transaction reservation required to
> write various log intent and buffer items to the log.  These helpers
> will be used by the online repair code for more precise estimations of
> how much work can be done in a single transaction.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_trans_resv.c |  6 +++---
>  fs/xfs/libxfs/xfs_trans_resv.h |  4 ++++
>  fs/xfs/xfs_bmap_item.c         | 10 ++++++++++
>  fs/xfs/xfs_bmap_item.h         |  3 +++
>  fs/xfs/xfs_buf_item.c          | 19 +++++++++++++++++++
>  fs/xfs/xfs_buf_item.h          |  3 +++
>  fs/xfs/xfs_extfree_item.c      | 10 ++++++++++
>  fs/xfs/xfs_extfree_item.h      |  3 +++
>  fs/xfs/xfs_log_cil.c           |  4 +---
>  fs/xfs/xfs_log_priv.h          | 13 +++++++++++++
>  fs/xfs/xfs_refcount_item.c     | 10 ++++++++++
>  fs/xfs/xfs_refcount_item.h     |  3 +++
>  fs/xfs/xfs_rmap_item.c         | 10 ++++++++++
>  fs/xfs/xfs_rmap_item.h         |  3 +++
>  14 files changed, 95 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
> index 13d00c7166e1..ce1393bd3561 100644
> --- a/fs/xfs/libxfs/xfs_trans_resv.c
> +++ b/fs/xfs/libxfs/xfs_trans_resv.c
> @@ -47,7 +47,7 @@ xfs_buf_log_overhead(void)
>   * will be changed in a transaction.  size is used to tell how many
>   * bytes should be reserved per item.
>   */
> -STATIC uint
> +uint
>  xfs_calc_buf_res(
>  	uint		nbufs,
>  	uint		size)
> @@ -84,7 +84,7 @@ xfs_allocfree_block_count(
>   * in the same transaction as an allocation or a free, so we compute them
>   * separately.
>   */
> -static unsigned int
> +unsigned int
>  xfs_refcountbt_block_count(
>  	struct xfs_mount	*mp,
>  	unsigned int		num_ops)
> @@ -129,7 +129,7 @@ xfs_rtrefcountbt_block_count(
>   *	  additional to the records and pointers that fit inside the inode
>   *	  forks.
>   */
> -STATIC uint
> +uint
>  xfs_calc_inode_res(
>  	struct xfs_mount	*mp,
>  	uint			ninodes)
> diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
> index 0554b9d775d2..e76052028cc9 100644
> --- a/fs/xfs/libxfs/xfs_trans_resv.h
> +++ b/fs/xfs/libxfs/xfs_trans_resv.h
> @@ -97,6 +97,10 @@ struct xfs_trans_resv {
>  
>  void xfs_trans_resv_calc(struct xfs_mount *mp, struct xfs_trans_resv *resp);
>  uint xfs_allocfree_block_count(struct xfs_mount *mp, uint num_ops);
> +unsigned int xfs_refcountbt_block_count(struct xfs_mount *mp,
> +		unsigned int num_ops);
> +uint xfs_calc_buf_res(uint nbufs, uint size);
> +uint xfs_calc_inode_res(struct xfs_mount *mp, uint ninodes);

Why are these exported? They aren't used in this patch, and any code
that doing calculate log reservation calculation should really be
placed in xfs_trans_resv.c along with all the existing log
reservation calculations...

-Dave
-- 
Dave Chinner
david@fromorbit.com

