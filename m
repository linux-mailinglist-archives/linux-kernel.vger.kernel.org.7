Return-Path: <linux-kernel+bounces-865250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACB0BFC984
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E46634487A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3822566DF;
	Wed, 22 Oct 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9hfDUYp"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D035BDD5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143951; cv=none; b=gC1B7cov/AxjrMlwvybtr94oRdZlmwrd3Aq0iDVvgPwuguW8RL1PRxJxWMXnCJ6lTTCXRsGcq7iI8P3dUF4sPFdekX6BkcQ9qkFN+NgErBLY/9h7ENezfAttAriuD5+5mKz54Z2V2utGtdpt7HZZs3mOxeP5zWsrX/XJmJVa4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143951; c=relaxed/simple;
	bh=GVcLhE5L4o4+4FvrWDSt+s7YUxa3ZxzGPz1vT1dnQuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOzSWDX/fnq+aA3u1xcBEkIrQ5ZKqVQOcmoV/ZAgXkDz4WPTpd/GWndV5tZZ1BJv0CHwTDx7qxSJ0j+DVIpk9vC0KdXoU9pLFUamK+RJ8bUhwHZCyoaL5M18+ybHb2QOk1Eb+XPYM/2OheLihCD9G6/3461ECbHNHzU1UtoCxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9hfDUYp; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7815092cd0bso72973407b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761143948; x=1761748748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUx6gdNdTYzzjqltaNY50WEDVxdUw+Z6zLWtzDzW/es=;
        b=e9hfDUYpQfHScsNwEaOmLB9NvcRdutXx/vGzPfzkjKLC3nidkzEztBz1IPyzv02uKC
         Itx+Qn/+5WVVLldSEVaCZzytjJnai3uCkf4WVtda+K32QDJ4iYtvf/UXz2APGoIz2yaw
         y/gTRGuX9SUs3v8zs3li+s/wOUh8JH9ATIGTpa68agJ3f98vIoDF8L99MxrdPxsgrW89
         fprES8QL05I3PT8Y1k0NTRfEi7bv8yOGV/BIQ2h551QUI2kqUKmuCfLoA92OOmJudsh1
         NRuX7f4ahJozOXJXEeUtKFyCelMx6+dlASgrNhueOzGeEeQwoKagAXvHgAX4/F4JmQQC
         IOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143948; x=1761748748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUx6gdNdTYzzjqltaNY50WEDVxdUw+Z6zLWtzDzW/es=;
        b=YFk0nv5O9ASFAgiOayJNjGt34odUpKlMeJxdd+lInnEa6W6B9UoEXDFGey4x1VyU/R
         N1ydcoQe/8DLbryA+EpJxyMWon3aiW4I4vAc7dCTWBbKeWfgxA2oj0jGole0N+JQpacR
         /Td2c/qJvhSW4WlRcbLqMcSccfhzgWakHoJRU9tJqBfgd1i1SWbp+rJy9eFRmuLAM8SB
         go2/I0tH3iMS64QMRb4Sq8BTAo3elD+WICEPlD5xG/KXkWWsqibfxsixj2+3k9xPKyfC
         XVrk1AzIW/H5pt49/2Zq9Td3/IzTErHfcRTdh0n+iU8NaNJx8rIJiznXS+69/o4eoN+5
         jEEw==
X-Forwarded-Encrypted: i=1; AJvYcCWjbNeCsvoU0inMrqw6lvYWlMiZdFUKXPGiGbSrajuW1wrdxW8w+DxhviKxL12leeYz3t7rRztR2Ee2dD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGt96sP2a6cCVcem0IGiAz32hIQVtVo6Jt9zIZRkC4Vp5hbis
	cX4FVwflMhGQL1WnCci+u+sMuXIsTbBoUtXcJkO2lOBwr0SjYI0fq4v9
X-Gm-Gg: ASbGnctA0iaOREEr9J/b48P+Y+IiJGkLZEdbXKr9fPxErrdr5p/e00W9sqdNHQr7GJ9
	peFonK7iVBHsL0C9xm924NpUJ1TKa+WKCIhLH/DBrbDrLLtibTU8YLmAx1TcqGrWZJuANm5YFPF
	rlXi2A4c0sSf1sEdEBVNtI4uwebjLfKtBd8mmWmZDa7QQ3Qg2bwkLCxp+z8AvarvDuWWDZni5/u
	Om6fXwhbDurWYChsQwNO5svMhzGd2hWQuANpodoO3t2QZcdYZVvAtORNRF7NwFcdRKcas7B/OTD
	I0TopJr5tC81seQUvmeJU5ydDw0hrCwiptvOwclWFgfehMN9DPq3bK5swbcROuvqDsZ1aibcCDh
	96weHFLQgsK8ZZkcYAtVwFK6qpnQV4C80adGB6KUhwusuHKOEXLLop1ePKeu6f2A3bvEsR+3104
	e43gwONSQEDJCK0xj1QPysGVWfL/umhAcOo2aa5TmnZyNmaK6bn2HGUw==
X-Google-Smtp-Source: AGHT+IGbdjGLYpbL0qlMetPGFIIVPkWMLPYZ5C7pSeuTMnOttPQxgvRO/yT23wLL3ahh/7calwEKmg==
X-Received: by 2002:a05:690c:2c01:b0:784:94d5:847b with SMTP id 00721157ae682-78494d58aa3mr158818427b3.20.1761143948445;
        Wed, 22 Oct 2025 07:39:08 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63e2680dcb5sm4073067d50.25.2025.10.22.07.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:39:08 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	vivek.kasireddy@intel.com,
	jgg@nvidia.com,
	nicolinc@nvidia.com,
	nathanc@nvidia.com,
	mochs@nvidia.com
Subject: Re: [PATCH] mm/hugetlb: Fix incorrect error return from hugetlb_reserve_pages()
Date: Wed, 22 Oct 2025 07:39:05 -0700
Message-ID: <20251022143906.2780172-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022102956.245736-1-skolothumtho@nvidia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 Oct 2025 11:29:56 +0100 Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> The function hugetlb_reserve_pages() returns the number of pages added
> to the reservation map on success and a negative error code on failure
> (e.g. -EINVAL, -ENOMEM). However, in some error paths, it may return -1
> directly.
> 
> For example, a failure at:
> 
>     if (hugetlb_acct_memory(h, gbl_reserve) < 0)
>         goto out_put_pages;
> 
> results in returning -1 (since add = -1), which may be misinterpreted
> in userspace as -EPERM.
> 
> Fix this by explicitly capturing and propagating the return values from
> helper functions, and using -EINVAL for all other failure cases.

Hello Shameer,

Thank you for the patch! The goal of this patch makes a lot of sense to me.
I just have a few comments:

> Fixes: 986f5f2b4be3 ("mm/hugetlb: make hugetlb_reserve_pages() return nr of entries updated")
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  mm/hugetlb.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 795ee393eac0..1767f7599f91 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7269,6 +7269,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	struct resv_map *resv_map;
>  	struct hugetlb_cgroup *h_cg = NULL;
>  	long gbl_reserve, regions_needed = 0;
> +	int ret;
>  
>  	/* This should never happen */
>  	if (from > to) {
> @@ -7308,8 +7309,10 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	} else {
>  		/* Private mapping. */
>  		resv_map = resv_map_alloc();
> -		if (!resv_map)
> +		if (!resv_map) {
> +			ret = -EINVAL;
>  			goto out_err;

NIT: What if we just initialize ret = -EINVAL in the declaration? Then we
can just preserve the original code and goto out_err here.

> +		}
>  
>  		chg = to - from;
>  
> @@ -7317,11 +7320,15 @@ long hugetlb_reserve_pages(struct inode *inode,
>  		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
>  	}
>  
> -	if (chg < 0)
> +	if (chg < 0) {
> +		ret = -EINVAL;

Is there a reason we set ret = -EINVAL here? I think it makes sense to
preserve what chg would have been returned here. There are two ways this value
gets set; for shared mappings, we have chg = region_chg(), and for private
mappings we have chg = to - from.

For shared mappings, region_chg() may return -ENOMEM, and I think this is
something that we would like to propagate, as the commit message of this
patch suggests. For private mappings, it does make sense to set it to 
-EINVAL, since we don't want to return a random negative value there. 

So maybe something like this? (Including the initialization of ret to -EINVAL
from above)

if (chg < 0) {
	if (chg == -ENOMEM)
		ret = -ENOMEM;
	goto out_err;
}

I'm sure there is also a more elegant way to handle this : -)

Although, there is a rare case that region_chg returns -ENOMEM because
add_reservation_in_range returns a negative value equal to -ENOMEM. In that
case we want to overwrite it with -EINVAL but will return -ENOMEM instead.

But this seems too rare : -) Maybe it makes sense to change region_chg or
add_reservation_in_range to check for a negative chg, and return -EINVAL
there instead as well. 

>  		goto out_err;
> +	}
>  
> -	if (hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
> -				chg * pages_per_huge_page(h), &h_cg) < 0)
> +	ret = hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
> +						chg * pages_per_huge_page(h),

NIT: Should we just unindent this line once and include &h_cg on the same
line? It seems like the original line also pushed the chg * pages... to
before the open parenthesis in the first line anyways.

> +						&h_cg);
> +	if (ret < 0)
>  		goto out_err;
>  
>  	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
> @@ -7337,14 +7344,17 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	 * reservations already in place (gbl_reserve).
>  	 */
>  	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
> -	if (gbl_reserve < 0)
> +	if (gbl_reserve < 0) {
> +		ret = gbl_reserve;
>  		goto out_uncharge_cgroup;
> +	}
>  
>  	/*
>  	 * Check enough hugepages are available for the reservation.
>  	 * Hand the pages back to the subpool if there are not
>  	 */
> -	if (hugetlb_acct_memory(h, gbl_reserve) < 0)
> +	ret = hugetlb_acct_memory(h, gbl_reserve);
> +	if (ret < 0)
>  		goto out_put_pages;
>  
>  	/*
> @@ -7363,6 +7373,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  
>  		if (unlikely(add < 0)) {
>  			hugetlb_acct_memory(h, -gbl_reserve);
> +			ret = -EINVAL;
>  			goto out_put_pages;
>  		} else if (unlikely(chg > add)) {
>  			/*
> @@ -7423,7 +7434,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  		kref_put(&resv_map->refs, resv_map_release);
>  		set_vma_resv_map(vma, NULL);
>  	}
> -	return chg < 0 ? chg : add < 0 ? add : -EINVAL;
> +	return ret;

We only return ret in the error case. If I understand the function correctly,
this part is only reached if there is an error somewhere. Should we rename
the 'ret' variable to 'err' instead? I think that will actually
add some clarity to this code path, since it's not immediately obvious that
this portion is just error handling & propagation otherwise.

I hope all of my comments make sense. Please feel free to correct me if
I've misunderstood any of the code or your intent with the patch as well : -)
Have a great day!

Joshua

