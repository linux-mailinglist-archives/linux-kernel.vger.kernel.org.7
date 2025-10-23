Return-Path: <linux-kernel+bounces-867651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C99D3C03330
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7ECD4341DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6D634CFC6;
	Thu, 23 Oct 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9x77gtU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982034D4DA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248271; cv=none; b=DGSoOlkMc/TY2ERlFWo7HSa5UwL5DfV91rQtpJ5qIaX5SoBU4P3eJNuC8HSaP2xZInt1zOwS4yTeonlRgg9Tc0KXb8xQQ9RG+cv7mvLcag8VzOWqhpWw7DgUtMRfTZAw6W0o/j42CkTH+8TH42O+5t7azlow6sKeB41TG+LnzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248271; c=relaxed/simple;
	bh=UFb5eBaca1W7nnSvUTjHGbvCgRW99J8DbLNt0suFnYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KigddbhKG9vYJ3H7imNBscDtou3AAW7GywPSGxLkhTZj2PUueJUN/VXBTaDPiOxgtoHyoiq07jIOZcNceuLhBAM/r+kLmSA7E39kcg/+CItVE7eAZ2cUizeP3VF7QCTNv7WT2HpynD6GSJBG2LpAPscRXDicgdlf8WRD2Tr/OII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9x77gtU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761248269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mPouUhrqRxgjcMBstonzlhFIxQsnreNI+UXdXwtR76k=;
	b=X9x77gtUeFB9P2Y1NDhdz+y4dG0Qtj6fNerHDAr21cajZCTrfEtJ7y3Rbzlh5QtLFb0d44
	BAZ8+4Px5hGKLS9Duk9Bqpw5Jj9AckHDz8isM6zaWJDsbyYsfIzd0BEqYeZ3Zoqz5+REjI
	JFi/n1wiYxN/11RkjJo3A8xR2F8ncTM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-zmHbvTuoNdm9Nn0u5j84xQ-1; Thu, 23 Oct 2025 15:37:46 -0400
X-MC-Unique: zmHbvTuoNdm9Nn0u5j84xQ-1
X-Mimecast-MFC-AGG-ID: zmHbvTuoNdm9Nn0u5j84xQ_1761248265
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-470fd49f185so11759665e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761248265; x=1761853065;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPouUhrqRxgjcMBstonzlhFIxQsnreNI+UXdXwtR76k=;
        b=WXz/TKuuP6IG0H7ebIPl20jjDkpPn0BfUuBmKdFgFHM026o2WZYiB4uWEoA8Y1mfuT
         mrFs8dTTnLaZtok+Ziql4/hXNyjqkr42cR1bkz2aotRBtLiAFUZZ+gDEbGTSUqq2aJBS
         j15IPbPznqN8oHQdw+N0iZ5fTo1lgYK7j06BP/pimFwhdrr3mVYGZp7n+/537GmWYt/4
         mrB5b+TZKuEbotI2U7IDQgxqXSXABoGGEr2v2Tt2YYLqFIR4zXCyJZTIWBoxS5IsdQKe
         HlW6sgmk9eZHX9upPU71xPshOzBXvFojmEMyhhuQdF0OIJgbLt32QyTkXaE1iW00uzYr
         0XRQ==
X-Gm-Message-State: AOJu0YwWrBuvIJsX5UYsz8EVnvfppMQy2B0RhmxS1PnYU4ARTts7SBI3
	/uqTVQJcNzMClljc+QlRkvIb+JDs9D6CIU8a8XVrBLSADdpOOyGcCZvSuoee7iSs+TumTaYspg9
	w1RW2BWWTuzq5n5aNqdRq0GutYtxcMsYSnEICoIKBJGjLw2e2FA6NDrWK4TDtfWlXLw==
X-Gm-Gg: ASbGncvQu6mPGkvP+mWXfGe+e+qTeo3dXdXkOJmx9Pguw+5Dj273xtHaAcp8l5ZkGlD
	g1KwA1MDduKET4+1Qe9MM71NupxJtHUVP+sIzb1My1PQpnfCAKKgu+v1ccWcTQlSPaSbF89I3h1
	/fVcQPDZY32V3ffhPiQ0TAe6fgxTzwoq/k546/R8BOUzPb49JPmhALBOcPP+1g3WQkduYRqkKuE
	xmcF2/5Ipv3CzSjmKjLU6+QLqjZgocNER5fPLsm/c61z5FLX+EetHhzIhqhS2Cfuo5l4hz7ya9a
	xdPNYw/qHqv4gdxOgpcKGSrwOrjTbOK6sDMiZPMvbwAX3vkQw9mwXYaZ8dWIZ1UmC5FmlAG5ZWG
	+s/7K0veufLTQU/q/Ss15ukHpQfqS7D50XiFs0MejMpKyg7sM156X3dmG+iaHw2nwuHWy6HKaLP
	bWoSSc2IMDusm7k2ZZyJwp/PaUryg=
X-Received: by 2002:a05:600c:3149:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-471178a7ea5mr175792325e9.16.1761248265279;
        Thu, 23 Oct 2025 12:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZq8ETk/dxv6lw5okKbvprrCeAKa5W7ysoK9CYeQHAr2H0Pl+EqcgQ1cUF8EEIwcu7bpKOCw==
X-Received: by 2002:a05:600c:3149:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-471178a7ea5mr175791855e9.16.1761248264842;
        Thu, 23 Oct 2025 12:37:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b5esm130845595e9.15.2025.10.23.12.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 12:37:44 -0700 (PDT)
Message-ID: <b0373792-a7fa-41c4-9bf8-979c10be49a0@redhat.com>
Date: Thu, 23 Oct 2025 21:37:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] sparc/mm: implement arch_flush_lazy_mmu_mode()
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-5-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251015082727.2395128-5-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 10:27, Kevin Brodsky wrote:
> Upcoming changes to the lazy_mmu API will cause
> arch_flush_lazy_mmu_mode() to be called when leaving a nested
> lazy_mmu section.
> 
> Move the relevant logic from arch_leave_lazy_mmu_mode() to
> arch_flush_lazy_mmu_mode() and have the former call the latter.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>   arch/sparc/include/asm/tlbflush_64.h | 2 +-
>   arch/sparc/mm/tlb.c                  | 9 ++++++++-
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
> index 8b8cdaa69272..925bb5d7a4e1 100644
> --- a/arch/sparc/include/asm/tlbflush_64.h
> +++ b/arch/sparc/include/asm/tlbflush_64.h
> @@ -43,8 +43,8 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>   
>   void flush_tlb_pending(void);
>   void arch_enter_lazy_mmu_mode(void);
> +void arch_flush_lazy_mmu_mode(void);
>   void arch_leave_lazy_mmu_mode(void);
> -#define arch_flush_lazy_mmu_mode()      do {} while (0)
>   
>   /* Local cpu only.  */
>   void __flush_tlb_all(void);
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index a35ddcca5e76..7b5dfcdb1243 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -59,12 +59,19 @@ void arch_enter_lazy_mmu_mode(void)
>   	tb->active = 1;
>   }
>   
> -void arch_leave_lazy_mmu_mode(void)
> +void arch_flush_lazy_mmu_mode(void)
>   {
>   	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
>   
>   	if (tb->tlb_nr)
>   		flush_tlb_pending();
> +}
> +
> +void arch_leave_lazy_mmu_mode(void)
> +{
> +	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
> +

Just like for ppc now a double this_cpu_ptr(). I'd similarly just 
replicate the two statements.

> +	arch_flush_lazy_mmu_mode();
>   	tb->active = 0;
>   	preempt_enable();
>   }


-- 
Cheers

David / dhildenb


