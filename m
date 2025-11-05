Return-Path: <linux-kernel+bounces-885777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734DEC33DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9D318C5AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28C62765DC;
	Wed,  5 Nov 2025 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZi7d2sU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F21D9324
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314118; cv=none; b=PaYbuGX2NbnYBKTjVJhPaoFpG5LRtgzn4fA2wohShbH2HkqZFFmr7hWao1NxOykbe9EP8D/XAbPou3pyGgCw6X8QxzWljpUEGELy4FEleBEhTz8CTD0b+N5K6BfOqkqw5sh4f5mGL1N3Hp6oY4lB2nbZDJHxnLWedI5kt/8J2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314118; c=relaxed/simple;
	bh=A7T7h1LobUivdMEwPvmLCL0uHKn/vDln9L++QIr/1v8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=nXWquKEBrgsqJba2DHVkamtF9uXv9o4sQX5o3dRMVljVxZ7K0FicWeC8P9mLXZN/GddGbVaP2AWwSipgRvkpCiMYwbeks2kV9XITTnWkXpq8dEc6H0d8VgGghlpbMUqQPMeBFNXaMmR5SAm4JIHmtlSzbhWCUgn5NCdEzxRMdXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZi7d2sU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2952048eb88so68096595ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 19:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762314117; x=1762918917; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PpcYW9rXkka09Jy11m9xJQRt/n8jdZMdqOTeKYVeZk=;
        b=VZi7d2sUgMaFcZboFmJzXN6+BycKSs/it+WL0w1wuJbbtKEkYvFP1k6V/6dERNrJdp
         TqmP/eRybHARHG1kDdqHRYKJmHV8TjTt49/FkRpt85rTK2+sSEiQWRXEJ6zo58dgNzqd
         FwgwPtJV/BLJTl6aL2Psc2L1Te0M4nVyvoxJAttGB464xD3/5yQl3xouyCx4NrjcHIlq
         X/LYJEREmMC2yZ5egAY0Ez964tCXaqRstPPkg7x4I/2B9EaofJCiXQvSvErS1q3fMlFa
         1NKQSBdorRwBVVsU+aByxRbl4YsyTcG+fbuXOaWmoPRDKth1qsXVB41eU9ZI1FOYZOxa
         zwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762314117; x=1762918917;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PpcYW9rXkka09Jy11m9xJQRt/n8jdZMdqOTeKYVeZk=;
        b=G23MZv6NpU6TZZ/K+1Qcc+4uFqKexqZT0FTGpYddMkkefKHbutQ44Se8FQQRMX1uXq
         tzM4FYr4QYYO/E+GThEYmU1HLJkmM151FzwOdTI6mD7ThMWdcVFY3hCHWmRqlWOzmhA0
         jo5sXFUXMiQWfHuOiHagqMB2XoXMP+ZqQ9DaXZU2rtuQ48KOEEwfYin7ss04KAxdrOJP
         CNDnimtkJuCgvA0x8I/uC0su0AfFPWE6N75N4xENwXQLHD+IzTOtX+dH88rcosCBJSlH
         nNK14qEx/w3Zyr7VPakrwJzVkDbgrMQrmN8kEo7S7fOr7iFEoJsaTXeoql/JsDvetXWK
         J1Mw==
X-Gm-Message-State: AOJu0Yyf204Ss194w8YqN//meb44yiUTicQIkaYoxpgJzrPxVCmaT1Mh
	Ommq+hUCVTmOvTsmS8+JxUVQafHg9BTxbyHPHqVmXZfHoEWg5dQeWjfK
X-Gm-Gg: ASbGncvNXxgR6ZN167DVV4n0qVVxBPEy/247O+MZzBlfRfnHsKVCjLgRU2aCT938e+8
	2R48PKsq7FOmAngR8YkH/bqSlcpaJzjWOHq8YV1uu2nVL/zvBQzNBXY3gp4Fpy2CcuNMctbGDvn
	l0sQUY77dCFBMtrlWiGgiPIaAEApDimocfxhFJtQxTDXrISxqVIXKc1ds3p4qp7nmLi/5Oi1my3
	PBDCWjCd+SmBLjSPR0QrJDbsJNNIMzzzicDI5CRdzPPjDwJqT8I+RoXXuEIGtCiXOdDHULkiUFn
	Qg8n2Ko0L2Qh2Q/YzZj46CbFlVSl5CrNCMKd/ZRARuCTij+vZ+wLlqxM/krjfO8T4QEOkqne6oI
	pR8MdDnJn2CKeEQxi1YFFWd5LEmojjIdesr7RfNBDNQADJbG/pswHo14f6hBFMeVOJCGo3g==
X-Google-Smtp-Source: AGHT+IHU+u4c4m70sp/Km2qphWV2GETQaiqBJlBLQ9oH8KuDbSRxjLHzXNgoB+GOOUcEEs7QOw2HMQ==
X-Received: by 2002:a17:903:944:b0:295:7f1d:b02d with SMTP id d9443c01a7336-2962ad3340fmr26429125ad.22.1762314116721;
        Tue, 04 Nov 2025 19:41:56 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a61418sm43663725ad.96.2025.11.04.19.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 19:41:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Subject: Re: [PATCH v4 03/12] powerpc/mm: implement arch_flush_lazy_mmu_mode()
In-Reply-To: <20251029100909.3381140-4-kevin.brodsky@arm.com>
Date: Wed, 05 Nov 2025 08:45:06 +0530
Message-ID: <87pl9x41c5.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-4-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Brodsky <kevin.brodsky@arm.com> writes:

> Upcoming changes to the lazy_mmu API will cause
> arch_flush_lazy_mmu_mode() to be called when leaving a nested
> lazy_mmu section.
>
> Move the relevant logic from arch_leave_lazy_mmu_mode() to
> arch_flush_lazy_mmu_mode() and have the former call the latter.
>
> Note: the additional this_cpu_ptr() on the
> arch_leave_lazy_mmu_mode() path will be removed in a subsequent
> patch.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  .../powerpc/include/asm/book3s/64/tlbflush-hash.h | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> index 146287d9580f..7704dbe8e88d 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> @@ -41,6 +41,16 @@ static inline void arch_enter_lazy_mmu_mode(void)
>  	batch->active = 1;
>  }
>  
> +static inline void arch_flush_lazy_mmu_mode(void)
> +{
> +	struct ppc64_tlb_batch *batch;
> +
> +	batch = this_cpu_ptr(&ppc64_tlb_batch);
> +
> +	if (batch->index)
> +		__flush_tlb_pending(batch);
> +}
> +

This looks a bit scary since arch_flush_lazy_mmu_mode() is getting
called from several of the places in later patches(). 

Although I think arch_flush_lazy_mmu_mode() will only always be called
in nested lazy mmu case right?

Do you think we can add a VM_BUG_ON(radix_enabled()); in above to make
sure the above never gets called in radix_enabled() case. 

I am still going over the patch series, but while reviewing this I
wanted to take your opinion.

Ohh wait.. There is no way of knowing the return value from
arch_enter_lazy_mmu_mode().. I think you might need a similar check to
return from arch_flush_lazy_mmu_mode() too, if radix_enabled() is true.


-ritesh


>  static inline void arch_leave_lazy_mmu_mode(void)
>  {
>  	struct ppc64_tlb_batch *batch;
> @@ -49,14 +59,11 @@ static inline void arch_leave_lazy_mmu_mode(void)
>  		return;
>  	batch = this_cpu_ptr(&ppc64_tlb_batch);
>  
> -	if (batch->index)
> -		__flush_tlb_pending(batch);
> +	arch_flush_lazy_mmu_mode();
>  	batch->active = 0;
>  	preempt_enable();
>  }
>  
> -#define arch_flush_lazy_mmu_mode()      do {} while (0)
> -
>  extern void hash__tlbiel_all(unsigned int action);
>  
>  extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
> -- 
> 2.47.0

