Return-Path: <linux-kernel+bounces-867458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D5AC02B37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D457735AF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE069347FC1;
	Thu, 23 Oct 2025 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxwnwsQM"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC0238C2A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239771; cv=none; b=eUr6yudXuTg77Tk+xT1cP3vaUEe5FrqiAkKx5MvPu1/E1V7AGVYveGITTnloCswQWGaybWPQNCrIX6FcuzoESLuLZ/OZho4FDEwJEQpcA/6glZ28eSWmSPNyVUUnCnOQZIo9HLjha1RayYH7gHrkCgDjJcjkkEGGVky2QVSx1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239771; c=relaxed/simple;
	bh=3vjklBZDK91NfPPKB/m+mZXiuBD949DF/IdVW5vVnss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GnCMTUl/r60gnnaqZSuA2rJT/87rxde+nZJgFYgP5tTmGtImKuXs9A/+ZJBxrkTK6DaKADKycuCIFRYogUeUCMgAU8uYIrFH8ITjhXvHSj6rlIfYlxbfXbK7mnF5vyhjFQwzvI1foPDFbg2j1nYzA2CXaMhzGl4LNzNblNI7BTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxwnwsQM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27c62320f16so10739055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761239767; x=1761844567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DTN4f9sYvKKbqzH4zMTtt+lW5xHHb7Uewe/2Me0Lwc=;
        b=LxwnwsQMjWRMGpoXy31nd6AyCrOukM0uUMX7deu20qo7q30KMCjEEZDYhkC40aOus+
         dESIMOiz59htetzN1GY+a8d39hT5AwOH2LqpPmPqsN806OVexEEppo/cfCrs6l75beiN
         ttzi/+XVmKZsgLSonurq+SM+UjFV6WqRIckRbo8jONK1rJFyMUSfcdAuL79XjfckdTkx
         qVkqUu7cHFjAXeiAuRtY6BUprhRaLtAviTIC90i+MPxtZzwfBtUGIx+fdAB6fayacJnL
         q3B/8iiudaM1yFOowITDFdKAXmNeWYPPKfIER8Ll0hxwryvbM0KaRrW4lmGmVT92L3Dy
         WoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761239767; x=1761844567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DTN4f9sYvKKbqzH4zMTtt+lW5xHHb7Uewe/2Me0Lwc=;
        b=idx10RUDwAYfdhz6yyrgws06lv0+C7sRpanpj20kKA8KDbDNKw5eLVI5oF4cYeDGkv
         qIsBKtnKkqUwZIWkdiNajCxNtouIZhF4oK3lBjgtzIBMMIyRPz+Ub1enveMW0/af4Kex
         QE2vevdvAowGpUgDvSsuS8u09+/jVMnqGYYIxbqQwRJpEzXKb8osNxlev8MU2wKCrT1K
         weISfQzL0r0yIz3sNcv1PzyVEZu7sbDzRLe9KU2hqmqLNJc5FfZZoTj2iyIin35qVt+o
         KlRAe5UKBUD8n1VWOvS3DeBeV6e51zmYjicOPqKtj9Nxqa9of7tEm/xnwY4GPpa43p2X
         eIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk/YVFnXohBwALLIiyERfXioxh3IAUA9vn/DvmcqmJOiempinZ9XfZLBHDOXM0SzO1lWmGgqBCt91Mo/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzKf4FJaxkzV0qX3HX54F4ElOULmpZsrPQLVTeB0unuT33lXM6
	RDZE1KyMYh2QZhanGnq6maTK92pOikgJGeoIDRmRd2SDJsS3uiMOXVXxqFelQc0jbzeuvjx8G8k
	Pjk3AFg==
X-Google-Smtp-Source: AGHT+IHWPgGmZKfo+3ImlZCUG7AewIscdCvWipQB1xDHXcjZQxceHYcdCY71wfIfELDOVuODkQ3p+Aq3kE8=
X-Received: from pjkm11.prod.google.com ([2002:a17:90a:730b:b0:33b:e0b5:6112])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88e:b0:267:da75:e0f
 with SMTP id d9443c01a7336-290c9c897bbmr312407025ad.11.1761239766935; Thu, 23
 Oct 2025 10:16:06 -0700 (PDT)
Date: Thu, 23 Oct 2025 10:16:05 -0700
In-Reply-To: <20251013151502.6679-3-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013151502.6679-1-jackabt.amazon@gmail.com> <20251013151502.6679-3-jackabt.amazon@gmail.com>
Message-ID: <aPpi1c-8EpWuo87B@google.com>
Subject: Re: [PATCH v2 2/4] KVM: selftests: Fix unaligned mmap allocations
From: Sean Christopherson <seanjc@google.com>
To: Jack Thomson <jackabt.amazon@gmail.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	isaku.yamahata@intel.com, roypat@amazon.co.uk, kalyazin@amazon.co.uk, 
	jackabt@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 13, 2025, Jack Thomson wrote:
> From: Jack Thomson <jackabt@amazon.com>
> 
> When creating a VM using mmap with huge pages, and the memory amount does
> not align with the underlying page size. The stored mmap_size value does
> not account for the fact that mmap will automatically align the length
> to a multiple of the underlying page size. During the teardown of the
> test, munmap is used. However, munmap requires the length to be a
> multiple of the underlying page size.

What happens when selftests use the wrong map_size?  E.g. is munmap() silently
failing?  If so, then I should probably take this particular patch through
kvm-x86/gmem, otherwise it means we'll start getting asserts due to:

  3223560c93eb ("KVM: selftests: Define wrappers for common syscalls to assert success")

If munmap() isn't failing, then that begs the question of what this patch is
actually doing :-)

> Update the vm_mem_add method to ensure the mmap_size is aligned to the
> underlying page size.
> 
> Signed-off-by: Jack Thomson <jackabt@amazon.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index c3f5142b0a54..b106fbed999c 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1051,7 +1051,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>  	/* Allocate and initialize new mem region structure. */
>  	region = calloc(1, sizeof(*region));
>  	TEST_ASSERT(region != NULL, "Insufficient Memory");
> -	region->mmap_size = mem_size;
>  
>  #ifdef __s390x__
>  	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
> @@ -1060,6 +1059,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>  	alignment = 1;
>  #endif
>  
> +	alignment = max(backing_src_pagesz, alignment);
> +	region->mmap_size = align_up(mem_size, alignment);
> +
> +	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
> +
>  	/*
>  	 * When using THP mmap is not guaranteed to returned a hugepage aligned
>  	 * address so we have to pad the mmap. Padding is not needed for HugeTLB
> @@ -1067,12 +1071,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>  	 * page size.
>  	 */
>  	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
> -		alignment = max(backing_src_pagesz, alignment);
> -
> -	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
> -
> -	/* Add enough memory to align up if necessary */
> -	if (alignment > 1)
>  		region->mmap_size += alignment;
>  
>  	region->fd = -1;
> -- 
> 2.43.0
> 

