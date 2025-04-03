Return-Path: <linux-kernel+bounces-587023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE592A7A6F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 17:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F3517AF66
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E7250BE5;
	Thu,  3 Apr 2025 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzSoEL+p"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013F2505DD
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694043; cv=none; b=XlenbyrJwzeAS538Zu8KieLrwBpZFtr1HL1YX6V20f69OMzCgU1GmTiHJkHUdXfsEvptJMT4r9j7MNpyIVl6TIDZR4qJn8J8H3f/xPEBCyTQaHIIoBj8RZzEqgnYiZmYJzGqKK15XBsrTg93slAdEPUc7HNai9y5nMDLcipMD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694043; c=relaxed/simple;
	bh=REhjuZvcA3i8G0dTb+3RkycXOZa+eB7qm8HZB2lP/Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYRmMSYKFa+/3rqQUtJkITV86lo2HS/EUalUrNEURsaxONYGbLv3q7ayBWTNX5wl7+2ChrJWW3CzRdK2TOxBEXkYyCkS+s03CYiuN2U1LsowxlUt16IBmeQDBXLRCAtLRgSohEB2T0p0yYcg0K9tv7tIQ8P6wPF0/WV1bzZK5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzSoEL+p; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so1823053a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743694040; x=1744298840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTskUv4HRecH8zkwhc0nWGv0insFCOczgkdAhLL+Odk=;
        b=tzSoEL+pcs2db5j0mdfjR1d4j+NimgVWvtB4nyyV/RLAFWaZix0/st17mKFeXlHP4C
         EVC9JLuS7dcQs7PN51s6jiNU52RkTzEBOzIXnAmMNVdeA8mAIKEtnKV+HTcsLSwOYWv/
         uefcLBpX1CB1uEc/wXbrV5JpYD6iC65lJAgj/FRZpIEVZJKZUG13YbuszLufAYB3fqQn
         NEc9QuMbzbZbKLMgC0S+WNDpRNosdcCLqvf34nH/8WbyXb1OiDYqwe63hmo6Dsq++aog
         yF/JUaVLLtRoFOWYWT3aR4QkTIvGh6GHQhcOn6OHOVRckmJDmkpMj7Thl3iYdmL2t0Fy
         6wqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743694040; x=1744298840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTskUv4HRecH8zkwhc0nWGv0insFCOczgkdAhLL+Odk=;
        b=FHJ2TFN2HdKRIf+4zFy08Nwk42LOblmXF58+axbe43RVl44zALLXwK4SnUHC/G4Aov
         T2FCvGl70XgApdCtJoh0/5ovGKWdxmL74GozrKAweSlwxy1iJ5XBtympstn5HoOUvhbo
         S8HX+D8p1uG3VkQwLOqf64uSjVFtK3LcvYL7o4qrIcoSmz2MHPY8XcgJuRXECtl5QCq3
         qPaC6Ndc589+Zf4DZ7HrgSbkBNtYgeJd//tiz6Hw5mjh9jL2HEQoo31OjNKHfvsghsAi
         1h7aLyM7RE6GDC50WT4+mq0l5/kjCxMdAfp+q22xpLaL4wri21Os2NPQrX1+5ldM8A96
         pbFA==
X-Forwarded-Encrypted: i=1; AJvYcCUucNSFCMNS0U1CirUcZsMKWK1jRyU3nvvGXLZU4ZQ2/xR4r2i9X15QoYuZo+fe4HXtHFfvd0i6FlsBvOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2SUwTuxdiEPTzbsV8TGSxNRQG1F2ksEQgerABxo7FvMfCLON
	3h45f9ILMdDjAP3tuJHyO6dSRXvlf+QDf6H+TsgOzLfS1yiuB3/tbq5D4Xktzw==
X-Gm-Gg: ASbGncvL1VD/r1ysLEO49nDLHkDG5r12lvpV5hho37maeSo4OsHGUTC7bghsEt0+MFR
	Om2fzvM+NwKk1e/1fPKH2xVT0J9HNuwqTDs3RFAsvR7Pub702BbbEtJEy6HIs053DVt+5wZsXVr
	K/9ocEvItV8k+JCX1s3SQYL4w8/nLcrfpDfRR0R9KeozYF4GEWs71Bh/LtuPlW+rydGdmB5nPv3
	kWRWn9F9xoXvKtB4selU4KcJ0kwdxnZFrRnPYhRBadhMCOeqpEVSrzdWFij9M2vXWBuDRH+Bw3e
	eieoAqpoLQh40gkLgBs2DfB95BisEalohOcXVpo9mvgUkBjAO30oV6h2fTUrEAuXjPyxFzxcOQw
	xjAHbpw==
X-Google-Smtp-Source: AGHT+IFfmyWrTKMc40a2U0IAHYIOZlLiCjW5rNWsqaDLQ9B5AQ5QDUuo3j6YMdMQxsUaTDXfNwPjYg==
X-Received: by 2002:a17:907:94c2:b0:ac2:a50a:51ad with SMTP id a640c23a62f3a-ac7d1893010mr177366b.14.1743694039740;
        Thu, 03 Apr 2025 08:27:19 -0700 (PDT)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013ec0esm108015266b.98.2025.04.03.08.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 08:27:18 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:27:15 +0000
From: Quentin Perret <qperret@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/9] KVM: arm64: Add a range to
 __pkvm_host_share_guest()
Message-ID: <Z-6o0zcLa4Aw0N6R@google.com>
References: <20250306110038.3733649-1-vdonnefort@google.com>
 <20250306110038.3733649-3-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306110038.3733649-3-vdonnefort@google.com>

On Thursday 06 Mar 2025 at 11:00:31 (+0000), Vincent Donnefort wrote:
> +int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu *vcpu,
>  			    enum kvm_pgtable_prot prot)
>  {
>  	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
>  	u64 phys = hyp_pfn_to_phys(pfn);
>  	u64 ipa = hyp_pfn_to_phys(gfn);
> +	enum pkvm_page_state state;
>  	struct hyp_page *page;
> +	u64 size;
>  	int ret;
>  
>  	if (prot & ~KVM_PGTABLE_PROT_RWX)
>  		return -EINVAL;
>  
> -	ret = check_range_allowed_memory(phys, phys + PAGE_SIZE);
> +	ret = __guest_check_transition_size(phys, ipa, nr_pages, &size);
> +	if (ret)
> +		return ret;
> +
> +	ret = check_range_allowed_memory(phys, phys + size);
>  	if (ret)
>  		return ret;
>  
>  	host_lock_component();
>  	guest_lock_component(vm);
>  
> -	ret = __guest_check_page_state_range(vcpu, ipa, PAGE_SIZE, PKVM_NOPAGE);
> +	ret = __guest_check_page_state_range(vm, ipa, size, PKVM_NOPAGE);
>  	if (ret)
>  		goto unlock;
>  
> -	page = hyp_phys_to_page(phys);
> -	switch (page->host_state) {
> +	state = hyp_phys_to_page(phys)->host_state;
> +	for_each_hyp_page(phys, size, page) {
> +		if (page->host_state != state) {
> +			ret = -EPERM;
> +			goto unlock;
> +		}
> +	}
> +
> +	switch (state) {
>  	case PKVM_PAGE_OWNED:
> -		WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_SHARED_OWNED));
> +		WARN_ON(__host_set_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED));
>  		break;
>  	case PKVM_PAGE_SHARED_OWNED:
> -		if (page->host_share_guest_count)
> -			break;
> -		/* Only host to np-guest multi-sharing is tolerated */
> -		WARN_ON(1);
> -		fallthrough;
> +		for_each_hyp_page(phys, size, page) {
> +			/* Only host to np-guest multi-sharing is tolerated */
> +			if (WARN_ON(!page->host_share_guest_count)) {
> +				ret = -EPERM;
> +				goto unlock;
> +			}
> +		}
> +		break;
>  	default:
>  		ret = -EPERM;
>  		goto unlock;
>  	}
>  
> -	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
> +	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, size, phys,
>  				       pkvm_mkstate(prot, PKVM_PAGE_SHARED_BORROWED),
>  				       &vcpu->vcpu.arch.pkvm_memcache, 0));
> -	page->host_share_guest_count++;
> +	__host_update_share_guest_count(phys, size, true);

So we're walking the entire phys range 3 times;

	1. to check the host_state is consistent with that of the first
	page;

	2. to set the state to SHARED_OWNED or to check the
	host_share_guest_count;

	3. and then again here to update the host share guest count

I feel like we could probably remove at least one loop with a pattern
like so:

	for_each_hyp_page(phys, size, page) {
		switch (page->state) {
		case PKVM_PAGE_OWNED:
			continue;
		case PKVM_PAGE_SHARED_BORROWED:
			if (page->host_shared_guest_count)
				continue;
			fallthrough;
		default;
			ret = -EPERM;
			goto unlock;
		}
	}

	for_each_hyp_page(phys, size, page) {
		page->host_state = PKVM_PAGE_SHARED_OWNED;
		page->host_share_guest_count++;
	}

That would also tolerate a mix of OWNED and SHARED_OWNED page in the
range, which I'm not sure is needed but it doesn't cost us anything to
support so ... :-)

Wdyt?

>  unlock:
>  	guest_unlock_component(vm);
> diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
> index 930b677eb9b0..00fd9a524bf7 100644
> --- a/arch/arm64/kvm/pkvm.c
> +++ b/arch/arm64/kvm/pkvm.c
> @@ -361,7 +361,7 @@ int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
>  		return -EINVAL;
>  
>  	lockdep_assert_held_write(&kvm->mmu_lock);
> -	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, prot);
> +	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, 1, prot);
>  	if (ret) {
>  		/* Is the gfn already mapped due to a racing vCPU? */
>  		if (ret == -EPERM)
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

