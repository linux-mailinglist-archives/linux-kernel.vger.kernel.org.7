Return-Path: <linux-kernel+bounces-824322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB0EB88A92
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4297B43B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C57222585;
	Fri, 19 Sep 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zHZncw3+"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E91614286
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275548; cv=none; b=auLZD6L/fakzvQRBRUEiK03eeRdxxofs943qckxrS06BNF5dWjDNx/nkeLUzmlveZzFa+SLrKzY3YSnav7VlFDm5Ezs8PJwvpv2z1jV/afdVXae8wG8EoNQ9z7tRnryuryYZluC2kj1WViWYRh8nurFJvB6ancVJjjD9hchX3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275548; c=relaxed/simple;
	bh=NXtV1b+xb2CwF1HZDhTTmEnGT96qLK6WuDF/rWwgzd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJaIlA9Av/kKAmbTd3DCzWdYgvpzH/YkrTiKPb6GjSJ8RCaRb5F0BHfButqAGFtrlrM7iDq4Q8tHkyCqScF/aJK7iWXlDc+xaegg+aoMjqKAXsgaREOqpCewCa3Vwmk1eePsg1k1sa+R+NLn+igpWlmQGwc+ZtH8/KzI24RW7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zHZncw3+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-571a58b385aso2394796e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758275544; x=1758880344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAjbnEPAZMAdFwjUN3o9+aXIN1g6BbdbU7cFibLkhCE=;
        b=zHZncw3+T/SP7zNt+6cjjiMZrStMZarphwCwk+imdbcC4s+1ymnnxkSxVa+t8ag8JI
         38XjV54POfr6PREm6d3jC8zDIqNvisgX38bo+JHtYHOJfPrBAzE7sbaxS/+nj2bRrhB3
         cxdV/x2/0Ag8/HJ8P4ahBh9czFPPVMsFlnRiBNugDcvVrwMFuI2aVIGiRvY3ys17R5/h
         iXYg/giDsnUBSvXu9xizqMPEKG6CLHjZLYqKNjsIFeElOYxwgC75VZwQuqyZSFbtRx8p
         eUOrLKUabyXSIbbEJ9JDu3swQcfuqHDZaPNyvk9HZaCxaEOrH8LuZG868cmgriVxm0pa
         iXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275544; x=1758880344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAjbnEPAZMAdFwjUN3o9+aXIN1g6BbdbU7cFibLkhCE=;
        b=f+u/2Ee+txlJTUnMqygQlhj1HMl1zTy29ada4fR64Bu0b/nlSjCA0pttySOGpSSnpM
         QZapw9DXzhDqGZHsvdeHDnAge/FSxYHf6/UClTFYceCDGuOt3/FNOJ2bSaQQNMwzuCv6
         9wzhw9M3UesPRYleLevMQbd0wpezfxBACwKZWRCV4ZewI56GEXifR6upM9DqeVm95AFf
         fr9p0mTomb6cznjBJSss7apInwWbksEx8IxworL5hjEKcS4oZ8htGI5+212v7qvTaYiw
         +I2Hx/gLHJNIcKtPmpzqYvgQ2ETGivJxjM0vJkLErSoeAej12nm+Vo4OFXA5lCW94onP
         QGqA==
X-Forwarded-Encrypted: i=1; AJvYcCVsMTpxs94bqrxWobhsyjkT6AGpojp7x2sHKoW3IIBjFSEv7Y36Bw/2J+xbwi7ur55B7yh3PYTEu0fFdeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQpyba/HyugOr2MqDiCypbBAhyOuMUNG5JvQLd7zAnKeWT2XGb
	z0LpSZnkiQ93DzZ1CCJaFrKjA3itVhMqmBWUqtzYS1k5EeLE3o6iAjubp0MfCf8fBpRXc8H0FQy
	iC8I63w==
X-Gm-Gg: ASbGncvV4VpHzZuXZpfmcme82YyKGDqRLzAwl2GVMQmtEYURWuCdAeDkUgxMEVIpHZ/
	uJsLmngghUc2gx1F5ehKq6Tg6pcdNkutcddy4hwV1MVvqQV5QlVDyN28KLXtPcwRPW3PFfEuxyT
	MCKXSUJUM+hgqM6zPSra8NzRXS3fr3c4StMPaZj1gMeiWS/79vVctu5a7Xe1Av3kRctx8I94RVQ
	2hQ1HHqM8bYG/JBKY74TGVym8FQPTYP6xxC6ZHWLqbbgZwBI8kK/GB7GHKDy1y2V+7jYZdfSJsz
	TyLP3ThedjiLnvQJzinG0uO/pmed+l3gvFpO/y4d/bVTGMsO6onWbQ7dPlDfVKmSWVmrg18JPP6
	f4a08pZXeANYW6iqSlEWres0trPjcIdVo2hL9i4rS26scOnITOqssMp6X
X-Google-Smtp-Source: AGHT+IFKy+FwZofZjdcvEDLB/j3u6QlsxJjpuXcH/jzqyXhI1pRvoG7N8aLbvnRsyKe4C6YJXaCgJw==
X-Received: by 2002:ac2:4f08:0:b0:576:fbdc:e3d7 with SMTP id 2adb3069b0e04-579e28e0ff7mr996313e87.57.1758275544122;
        Fri, 19 Sep 2025 02:52:24 -0700 (PDT)
Received: from google.com (146.92.88.34.bc.googleusercontent.com. [34.88.92.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f447f3sm1288190e87.13.2025.09.19.02.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:52:23 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:52:20 +0000
From: Quentin Perret <qperret@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	sebastianene@google.com, keirf@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Validate input range for pKVM mem transitions
Message-ID: <cf3v4dn233bf6y74ythiqulwfnshcdmddsdx3iqcenqjos5cct@zkcw7g5ieei7>
References: <20250918180050.2000445-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918180050.2000445-1-vdonnefort@google.com>

On Thursday 18 Sep 2025 at 19:00:49 (+0100), Vincent Donnefort wrote:
> There's currently no verification for host issued ranges in most of the
> pKVM memory transitions. The subsequent end boundary might therefore be
> subject to overflow and could evade the later checks.
> 
> Close this loophole with an additional range_is_valid() check on a per
> public function basis.
> 
> host_unshare_guest transition is already protected via
> __check_host_shared_guest(), while assert_host_shared_guest() callers
> are already ignoring host checks.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 8957734d6183..b156fb0bad0f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -443,6 +443,11 @@ static bool range_is_memory(u64 start, u64 end)
>  	return is_in_mem_range(end - 1, &r);
>  }
>  
> +static bool range_is_valid(u64 start, u64 end)
> +{
> +	return start < end;
> +}
> +
>  static inline int __host_stage2_idmap(u64 start, u64 end,
>  				      enum kvm_pgtable_prot prot)
>  {
> @@ -776,6 +781,9 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
>  	void *virt = __hyp_va(phys);
>  	int ret;
>  
> +	if (!range_is_valid(phys, phys + size))
> +		return -EINVAL;
> +
>  	host_lock_component();
>  	hyp_lock_component();
>  
> @@ -804,6 +812,9 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
>  	u64 virt = (u64)__hyp_va(phys);
>  	int ret;
>  
> +	if (!range_is_valid(phys, phys + size))
> +		return -EINVAL;
> +
>  	host_lock_component();
>  	hyp_lock_component();
>  
> @@ -887,6 +898,9 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages)
>  	u64 size = PAGE_SIZE * nr_pages;

It occurred to me that this can also overflow, so perhaps fold that
calculation into your helper as well to be on the safe?

Thanks,
Quentin

>  	int ret;
>  
> +	if (!range_is_valid(phys, phys + size))
> +		return -EINVAL;
> +
>  	host_lock_component();
>  	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
>  	if (!ret)
> @@ -902,6 +916,9 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
>  	u64 size = PAGE_SIZE * nr_pages;
>  	int ret;
>  
> +	if (!range_is_valid(phys, phys + size))
> +		return -EINVAL;
> +
>  	host_lock_component();
>  	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED);
>  	if (!ret)
> @@ -949,6 +966,9 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu
>  	if (ret)
>  		return ret;
>  
> +	if (!range_is_valid(phys, phys + size))
> +		return -EINVAL;
> +
>  	ret = check_range_allowed_memory(phys, phys + size);
>  	if (ret)
>  		return ret;
> 
> base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
> -- 
> 2.51.0.470.ga7dc726c21-goog
> 

