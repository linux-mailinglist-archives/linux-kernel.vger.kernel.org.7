Return-Path: <linux-kernel+bounces-785552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABDAB34D81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B200207D31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5528F1;
	Mon, 25 Aug 2025 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9umoNnG"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C168528FA91
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155926; cv=none; b=ftbsHeBVJZtBx2EStY88VhZnPZL90vSN6TuuExFP5rIs6RLgVKGo9Ssqs4oik9vzsMRVvdDbEd0Kb/AZIsJyawPslFk0KH1SwL4DVCsYioPHK8vPnuFlamF5002Hv5nTTqgXvXV8JegwjxzE1JSWukVTYshP0Cw/qwz7BhuJPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155926; c=relaxed/simple;
	bh=FMCrqrks/dXpZHsprf5BWivpfad0MjoU6jkP3WQ/7Og=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IAQVYuAbM5qVCh5dHysWDzqyx1RSfl69Mk1aYY4rVmxg4hN5oyQRkBKMc6Uy6fiWuCxkqLzi0nT+rsmWChOBV5X7AvVtLWru//Fuef6Q4tqpl9V1qvbzBcRx66A5T+aoQI66R8DBoitPodFMsc3kVw2AMn+0RDA40LdbBRQ9M4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m9umoNnG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e41e946eso8937088a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756155924; x=1756760724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7d15ca6DDhUkwd5VLfHJQyeR86hJJRH7e9ofbHHP6cU=;
        b=m9umoNnGILYqNDaKr7ZJw2hjYFHmzqKLHKpnRXjARP1K/u8ZwGywfslURERyjYemag
         SPkVcYvRdUAPcbt7kNlpFu/NjncDHgnnjAC7rwbGE1LH/OkKQjIPVJsq1ZNOnnfcRLvs
         0lyFFBmCI490zKXkbFhuTWVdWgEkYEOyokA3mMcJym/cvSN1lmTlLMHQ+wdoc7D6WHdw
         2XXQ+oo4U0GKK28YnaxmrHX/IRgxDGNV0Us7Zk9DgOKckvhiO/WNCN4G4OA2kg7//aoF
         B8Z3SJ8bxtN5QTf7NtKSUaw4iIwN83kr24GAjANZpZzQf/wyDUUEG1VxTgnyG+/+0aXp
         D5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756155924; x=1756760724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d15ca6DDhUkwd5VLfHJQyeR86hJJRH7e9ofbHHP6cU=;
        b=ZTsj+Gop6ooENniAC2JeJT2R8TPszuuWlGQjBjXOrx0BME9rv7e7bHDd7mEJBfDN7J
         csJTo5btMQwQYKcHIJ3HzJmYw/IF+7mgAzMeKEWsRzMIMBeLgy4DZgzQ9rc+jPUFDzoX
         hqp1SPCpKVAkjqlfB7es4gdFj6Y2LChMXbSibQcryirasfCCieqEvVlF+vQ8Fb/B7Cq6
         3WTc46M4qudjrhSMooKjMM5xpJUjnxaz3r6/YXXtn3a/cd2pZFZwdWpxTuZvvEMmBD9D
         zxaXkR9nUeWUUvqUazA4RS1MTfsSwX1XveKiX0STwddai9ThG7kI9NZlXNKXupe86pCa
         fIzg==
X-Forwarded-Encrypted: i=1; AJvYcCUyV9Ml47xH/+aVUjaFS+MHMvB/EBS8I3aoRbim1CkHbBMJ8rgcYXN7QUKn0QxAT3Am2U1juQ7o3MdAtqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcK7FcBcCAqYmhOpP/2zrLvleQsEi2NsrCLyaxWUagLxvh6PqR
	+fOQZdAM7DC74KTHmhWemJ4aI5/sMOMIG32y2y2T2wj7nl6LbRW29rf/jlplGJplQc911aCqljM
	9mDrHEA==
X-Google-Smtp-Source: AGHT+IEm4/q7R9vqsalDGxIoUCdP69IoDYNKhvzEhXQffHVAOixTwa8x+rJdf1yKoahs9B9e41d388NCl58=
X-Received: from pjn5.prod.google.com ([2002:a17:90b:5705:b0:325:b894:3c4f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384a:b0:325:8e03:c159
 with SMTP id 98e67ed59e1d1-3258e03c39amr6971375a91.9.1756155924087; Mon, 25
 Aug 2025 14:05:24 -0700 (PDT)
Date: Mon, 25 Aug 2025 14:05:22 -0700
In-Reply-To: <20250822080235.27274-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822080100.27218-1-yan.y.zhao@intel.com> <20250822080235.27274-1-yan.y.zhao@intel.com>
Message-ID: <aKzQEi4fykQwvqLE@google.com>
Subject: Re: [PATCH v3 2/3] KVM: Skip invoking shared memory handler for
 entirely private GFN ranges
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, peterx@redhat.com, rick.p.edgecombe@intel.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 22, 2025, Yan Zhao wrote:
> When a GFN range is entirely private, it's unnecessary for
> kvm_handle_hva_range() to invoke handlers for the GFN range, because
> 1) the gfn_range.attr_filter for the handler is KVM_FILTER_SHARED, which
>    is for shared mappings only;
> 2) KVM has already zapped all shared mappings before setting the memory
>    attribute to private.
> 
> This can avoid unnecessary zaps on private mappings for VMs of type
> KVM_X86_SW_PROTECTED_VM, e.g., during auto numa balancing scans of VMAs.

This feels like the wrong place to try and optimize spurious zaps.  x86 should
be skipping SPTEs that don't match.  For KVM_X86_SW_PROTECTED_VM, I don't think
we care about spurious zpas, because that's a testing-only type that doesn't have
line of sight to be being a "real" type.

For SNP, we might care?  But actually zapping private SPTEs would require
userspace to retain the shared mappings across a transition, _and_ be running
NUMA autobalancing in the first place.  If someone actually cares about optimizing
this scenario, KVM x86 could track private SPTEs via a software-available bit.

We also want to move away from KVM_MEMORY_ATTRIBUTE_PRIVATE and instead track
private vs. shared in the gmem instance.

So I'm inclined to skip this...

> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  virt/kvm/kvm_main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f769d1dccc21..e615ad405ce4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -620,6 +620,17 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
>  			gfn_range.slot = slot;
>  			gfn_range.lockless = range->lockless;
>  
> +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> +			/*
> +			 * If GFN range are all private, no need to invoke the
> +			 * handler.
> +			 */
> +			if (kvm_range_has_memory_attributes(kvm, gfn_range.start,
> +							    gfn_range.end, ~0,
> +							    KVM_MEMORY_ATTRIBUTE_PRIVATE))
> +				continue;
> +#endif
> +
>  			if (!r.found_memslot) {
>  				r.found_memslot = true;
>  				if (!range->lockless) {
> -- 
> 2.43.2
> 

