Return-Path: <linux-kernel+bounces-589095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E33CA7C1BE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 18:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E983BAE80
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F920C004;
	Fri,  4 Apr 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35za31AV"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5121171C
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785261; cv=none; b=mkvRwTb9WNxyZleQSQ4yDAqeRYQnT7x91EQj3CfBNmMn5jeElZcHwmxXnT72wa4FOh3JmBAaV+jTW3yp5h3MpbCStX7EyjiI6C7pnyAaBVKemptjtnKqKwPR7PFsOGS2jwMCxQX0aRFGldSfedjF3VDvHKXJFagCDLfgBHsRVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785261; c=relaxed/simple;
	bh=kBOspWRNQ4BmOfPjA2PvOZq3vMDxXt5Q1YQqo0gJ9fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQbiFSAtbx2olXyXySk/L3gIcq7VFYf42qNA4RBrXXynhJhizghGcZSCt6HlXKUhPzgORuBn5dNTrRbQpyVaz/Iy0fqHY51JWoTHvUcREAq9gJlcIf0PRgw/l3fdecE+4z+uZk5G8uYJrKHy4RY49Q9Txmdzd0gLOwKe8fXtT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35za31AV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so1919268f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743785257; x=1744390057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjzowwCzDt7F+kKBoh3+rUz7yp+YdCsAa/lYm8cjXDA=;
        b=35za31AVfXdRc0/Zuc9pHXF/ltzmo6No3PSHGMxYB2iI/QqquaFTOqBTcQCu/rMNyd
         CXjlFhyQiS3Be8lMG1jh0OapUBcfabh6GERsC4iR2L6UuJ7gupwUYDNBXQ25mvmvhbTO
         lmJeQm0k+DUVgdp8v7NyFiiv0VOyuGc1tMs/okqYjC4geXheUxm4UkjD5c+4Wr1jFKgC
         Q9WspE10YvcuKK44Q6RvXxvd+zmj7hcEGGOwwn5UZcoPG+IqsZa3MVsOI2dlEQB+Uyi1
         xnZrLGFY3gKx0uscnD9Q6zBv7DwQGQGLf0cneDiWNjRXNCgR5uI8ABo8tGzsLMl9Hbxn
         dSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743785257; x=1744390057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjzowwCzDt7F+kKBoh3+rUz7yp+YdCsAa/lYm8cjXDA=;
        b=PkaFAzQVWlZh7GhfSuUt5onkkZwetFPzjMVa8RJ/eCG/pcruE/Wm5gz0P8QSb3lxqZ
         qp/QQN4dmEieOVMRQnqq6wLFs0tpQBTShzVR8ztQ3IYFh/mpHFq4JBFMgaDL911DRIwQ
         86zbw8F+gfBAAEU5HLe8YCSjFz88SqQQoQ9a/qrlfTw1fkxO+gbuYZE5dIgWzHFBnT/t
         4wGf6z6AKlc6wT9ob7/I5LoRUCU+EgeWqiRNbxHODTn0Li91cBHwDuA1eu3mumhKiBBj
         2OU7aXFwdVeN/rrUgXTLQTq+KMnxnFRxRbI+q8M6EUX7FTh9v1h7RaNtf7BcvWtAFteU
         oZQA==
X-Forwarded-Encrypted: i=1; AJvYcCU+oKoa9aurWz6IP0LULoWP1deH30yklmJbk6OiaeE4ETb8op+Knos7T3Ng54DBII29YZZv7B0cJFV+OUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypdYGJtmeLT115vDLddJ9ezLfa2r4sH8bWFjK6Q/8mKtf2hBSN
	h44VJ4pju6kCguo/ui+0qO0JQsg9mWY9kufWHGqwFWWPRYwMkaQRfLR/iYnpEg==
X-Gm-Gg: ASbGncvM272BRp9oU50HXHM1jiZQgslK2jUd6tUT16MWBEWFA/MbHZCHBf5CB5aamCt
	MOm1g8qjn2Y5ej/MEdkf88FAxHjLZzR2qW5KwW0R7jXSkF1lwDbppGCQAT9eaAEoRdhEaFzLiJ5
	I7LIdJIxAwO4+IR1IuC++wPMgZtdE4F/kgc22RFkZ5s/01XYk1ebY1wXYeoBHpwotc3Eb4b9mYB
	iAkzlPHuimxGdrxXQ1Pz7EU4ztJKAxfFnFbE4WoM/HBtYGq86ggSQg5Bqg8bbpVaBzDohOTZDHT
	0r30QKn0l86rhwm7d69bNeGkLVw8ChdBsnuwG2XHgVKIXIQ2DgZ7UeGLOwK2wp7dxeNmW4TgIEH
	q67vzOjU=
X-Google-Smtp-Source: AGHT+IFzHQAEkpFtCO+t1gRCJIagbYhnnjuyRaUGQM6bW98s2AD1DwEmZUlzJZcYV+93fHKKsfUsjA==
X-Received: by 2002:a5d:584a:0:b0:399:6dc0:f134 with SMTP id ffacd0b85a97d-39cba98b9c4mr4046259f8f.51.1743785257188;
        Fri, 04 Apr 2025 09:47:37 -0700 (PDT)
Received: from google.com (35.157.34.34.bc.googleusercontent.com. [34.34.157.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d975sm4848736f8f.75.2025.04.04.09.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 09:47:36 -0700 (PDT)
Date: Fri, 4 Apr 2025 17:47:33 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Quentin Perret <qperret@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/9] KVM: arm64: Add a range to
 __pkvm_host_share_guest()
Message-ID: <Z_ANJQXw7maV8TlT@google.com>
References: <20250306110038.3733649-1-vdonnefort@google.com>
 <20250306110038.3733649-3-vdonnefort@google.com>
 <Z-6o0zcLa4Aw0N6R@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-6o0zcLa4Aw0N6R@google.com>

On Thu, Apr 03, 2025 at 03:27:15PM +0000, Quentin Perret wrote:
> On Thursday 06 Mar 2025 at 11:00:31 (+0000), Vincent Donnefort wrote:
> > +int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu *vcpu,
> >  			    enum kvm_pgtable_prot prot)
> >  {
> >  	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
> >  	u64 phys = hyp_pfn_to_phys(pfn);
> >  	u64 ipa = hyp_pfn_to_phys(gfn);
> > +	enum pkvm_page_state state;
> >  	struct hyp_page *page;
> > +	u64 size;
> >  	int ret;
> >  
> >  	if (prot & ~KVM_PGTABLE_PROT_RWX)
> >  		return -EINVAL;
> >  
> > -	ret = check_range_allowed_memory(phys, phys + PAGE_SIZE);
> > +	ret = __guest_check_transition_size(phys, ipa, nr_pages, &size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = check_range_allowed_memory(phys, phys + size);
> >  	if (ret)
> >  		return ret;
> >  
> >  	host_lock_component();
> >  	guest_lock_component(vm);
> >  
> > -	ret = __guest_check_page_state_range(vcpu, ipa, PAGE_SIZE, PKVM_NOPAGE);
> > +	ret = __guest_check_page_state_range(vm, ipa, size, PKVM_NOPAGE);
> >  	if (ret)
> >  		goto unlock;
> >  
> > -	page = hyp_phys_to_page(phys);
> > -	switch (page->host_state) {
> > +	state = hyp_phys_to_page(phys)->host_state;
> > +	for_each_hyp_page(phys, size, page) {
> > +		if (page->host_state != state) {
> > +			ret = -EPERM;
> > +			goto unlock;
> > +		}
> > +	}
> > +
> > +	switch (state) {
> >  	case PKVM_PAGE_OWNED:
> > -		WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_SHARED_OWNED));
> > +		WARN_ON(__host_set_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED));
> >  		break;
> >  	case PKVM_PAGE_SHARED_OWNED:
> > -		if (page->host_share_guest_count)
> > -			break;
> > -		/* Only host to np-guest multi-sharing is tolerated */
> > -		WARN_ON(1);
> > -		fallthrough;
> > +		for_each_hyp_page(phys, size, page) {
> > +			/* Only host to np-guest multi-sharing is tolerated */
> > +			if (WARN_ON(!page->host_share_guest_count)) {
> > +				ret = -EPERM;
> > +				goto unlock;
> > +			}
> > +		}
> > +		break;
> >  	default:
> >  		ret = -EPERM;
> >  		goto unlock;
> >  	}
> >  
> > -	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
> > +	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, size, phys,
> >  				       pkvm_mkstate(prot, PKVM_PAGE_SHARED_BORROWED),
> >  				       &vcpu->vcpu.arch.pkvm_memcache, 0));
> > -	page->host_share_guest_count++;
> > +	__host_update_share_guest_count(phys, size, true);
> 
> So we're walking the entire phys range 3 times;
> 
> 	1. to check the host_state is consistent with that of the first
> 	page;
> 
> 	2. to set the state to SHARED_OWNED or to check the
> 	host_share_guest_count;
> 
> 	3. and then again here to update the host share guest count
> 
> I feel like we could probably remove at least one loop with a pattern
> like so:
> 
> 	for_each_hyp_page(phys, size, page) {
> 		switch (page->state) {
> 		case PKVM_PAGE_OWNED:
> 			continue;
> 		case PKVM_PAGE_SHARED_BORROWED:
> 			if (page->host_shared_guest_count)
> 				continue;
> 			fallthrough;
> 		default;
> 			ret = -EPERM;
> 			goto unlock;
> 		}
> 	}
> 
> 	for_each_hyp_page(phys, size, page) {
> 		page->host_state = PKVM_PAGE_SHARED_OWNED;
> 		page->host_share_guest_count++;
> 	}
> 
> That would also tolerate a mix of OWNED and SHARED_OWNED page in the
> range, which I'm not sure is needed but it doesn't cost us anything to
> support so ... :-)
> 
> Wdyt?

That sounds good, I'll drop __host_update_share_guest_count at the same
time to fold it directly into the share/unshare functions.

> 
> >  unlock:
> >  	guest_unlock_component(vm);
> > diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
> > index 930b677eb9b0..00fd9a524bf7 100644
> > --- a/arch/arm64/kvm/pkvm.c
> > +++ b/arch/arm64/kvm/pkvm.c
> > @@ -361,7 +361,7 @@ int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
> >  		return -EINVAL;
> >  
> >  	lockdep_assert_held_write(&kvm->mmu_lock);
> > -	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, prot);
> > +	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, 1, prot);
> >  	if (ret) {
> >  		/* Is the gfn already mapped due to a racing vCPU? */
> >  		if (ret == -EPERM)
> > -- 
> > 2.48.1.711.g2feabab25a-goog
> > 

