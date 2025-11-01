Return-Path: <linux-kernel+bounces-881266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A14EC27DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99C8E4E652B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52522F5461;
	Sat,  1 Nov 2025 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gmyek10j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4b1DlOa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E12DC348
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761999494; cv=none; b=a5A/GZ4wLaBaxtEFEXr8hfCOuAcYYjnCk2DBqkiWzvfVPkfbk/tXj+5ypl4OMyjaA9njnXk1YToE1TdUDPlGkoysTjQNgQciA84mnzvxIli8jVar+Mu9lcdRm8AS6ZOheUnkL74C7LrPMuKpvuuujMHKSUyC8FMB+sB2Ij9GHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761999494; c=relaxed/simple;
	bh=iALiYAM+OjoSTOjsw1z3TM71JjgKe88qXIqGpGDZqNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oX1PEn/EfqPmrfPbDcqM6FSjMCbaJBTxgFbtVBzDtU0Gkw3OzgtLx1WjyJMQ59dCfpL7qFyyDaUzc9RCzOIoJH80ZSjM1ejTZUzMUifIgFdNsIZDVvvjdfRlOZNrYMGwIIe0y0stgMfYKfVPnniFjBcBIS8jA9S2X+T4Wa1KQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gmyek10j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4b1DlOa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761999491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nakH/PvmVEC4FueXBEYiavMVStVvZPPhZqsGXFef+TU=;
	b=Gmyek10jlrx6Q8ozH7KMs213EE5JBRMus7S8X2g+ghkEYrU0ujMTAD159e6Z8zlhsNonkz
	8YTYOCfIeAw1hA408J+5U0p4HDjGoIcQPG5gxzMfGkOgzRm+oizsoT/N7opc599rxDo3mg
	5wMO7VYIqMKDygfOLgFCpZSZrXd2LKs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-0xoxyh4-MKegtoEbCAd5Vw-1; Sat, 01 Nov 2025 08:18:09 -0400
X-MC-Unique: 0xoxyh4-MKegtoEbCAd5Vw-1
X-Mimecast-MFC-AGG-ID: 0xoxyh4-MKegtoEbCAd5Vw_1761999488
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso27989015e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761999488; x=1762604288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nakH/PvmVEC4FueXBEYiavMVStVvZPPhZqsGXFef+TU=;
        b=i4b1DlOa3jtDesvX4CfqRaTlIOTJQ4TzmHF4fUVK2KI2Vf9z2mRsQwDwtd+v0eeX3n
         S0Slk0AYr63iaT7BJvyblrIA9qvsHCCwXmhj/kCDqD+EMRfYh6tL1UttBhN7j/Dkp0Lb
         CLL6qfHCo8feiFMf+ipJ/PrBqVplu6G6aGSajxVSBc+TH6eO+awwG4kr793/eoUOoo/s
         BRpHTRdYnK+PYm3/O9RwBWLtF+RXcK0NIZE8EJTeyoyAUp9kCugsTsBPRjCPChjoPMiE
         cROzahCx2tBUvqrq3CnDVLqNrX/3cL/HdYWsrZnRfoOwk+PA3DcUhdR6kTrsDU//FdiR
         zahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761999488; x=1762604288;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nakH/PvmVEC4FueXBEYiavMVStVvZPPhZqsGXFef+TU=;
        b=T09gdTPry5XWKvNcz0AjCtj6XT8gcZl+gLyqGm3wwW6mNHktMp9aDmeNf1dq6HheHM
         UMiIgz+BefmH1YOMWZFVAnoHLNLxG+dwiVBn5qFvS++gOVXju2HDz2YDAN7jR8Q6MM02
         0NnFMh5WRVRqmEh21Oaaqs0XKY1XKeotsty7YUurlq6l0FJiz8aLcYUHquKL5mKR2Ey6
         ZfpsCoGT/obi/o82m0Sk4D9j5RTXcOD5P/1LAwBJre9s+zbWbsabr3h9WdCPpxqVlDfz
         wv+RUaHUnJNEvZB23Kt2oRrZq52tFUHTVKzwSDBGfjDBHQXR7AZroeQZIETdk7xh4T0s
         RS9g==
X-Gm-Message-State: AOJu0YxxBUd22nYV9kzrRajzkC2KNgsNMYMC3PMyrdgN9ptl22LDQ39+
	wuGJ5uY90Z+NBFnmsAMw/+fa0d5XYVH8gepTMxRsCpCuj7GV0M/As1wmm6WWRnKehRi362M1T7G
	JaIE9NvXD1LNj62U7Bt3vHzV3PwebBaZ2eqYzjk2yTYk3yhu/tpvkFBafLzNEiwjBhw==
X-Gm-Gg: ASbGnctLx+xBy0JGLCLbGfx0vxHaIIgEXHSByeBWh4m5YSS1gVQSDEKF0r8A+ajKCON
	jPbizhmmkyGwM8X4Z7s07LqEKMpO4YbXB6bGcL8eddK5M7i6TBF4Hb1ntHIeyt50o5S7C+h17mw
	Z9w5Z0lc71MEKOi//zzEU/7Nlp5PKDgUh5/eb6ZMBInRl2CW6IKrVHP1/5mpD93ypAGoM6z/hak
	33YLstXwhGeDWWkPaWCQ8SgIdwPE1rlJVkwR9NsXcubxAzjizGopezmCSMhxpI60L6KjTMTyyL4
	1Rnqh6SGoBK2zbhJ0+9uDPI9DKhDTtw39xwSDq/0wHx+YwCvxdwfpwSjE8dOuIHvCUbHSGQquyp
	K1moWyn8paSLsjQJfET93CxZwHDInJ/LDq3xrhLgBQtiq2620USYpqNPo9lLrp0/xXVlhr9irWF
	wVSxT5fX3l18X6r+mMj1s/+2ucrZc=
X-Received: by 2002:a05:600c:1d9b:b0:46d:996b:826a with SMTP id 5b1f17b1804b1-477308c8b64mr64006425e9.36.1761999488370;
        Sat, 01 Nov 2025 05:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYuiv87iZ7G8foU4ArwULKDJw8Idy7HTvUTtsGo13HOjZ3TpQsscDerygyrVDH0/hBtY+XhQ==
X-Received: by 2002:a05:600c:1d9b:b0:46d:996b:826a with SMTP id 5b1f17b1804b1-477308c8b64mr64006055e9.36.1761999487959;
        Sat, 01 Nov 2025 05:18:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec2csm45855895e9.11.2025.11.01.05.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 05:18:07 -0700 (PDT)
Message-ID: <8f3596e9-fe40-4591-946d-65e849955a2f@redhat.com>
Date: Sat, 1 Nov 2025 13:18:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] mm: introduce generic lazy_mmu helpers
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-7-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251029100909.3381140-7-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.25 11:09, Kevin Brodsky wrote:
> The implementation of the lazy MMU mode is currently entirely
> arch-specific; core code directly calls arch helpers:
> arch_{enter,leave}_lazy_mmu_mode().
> 
> We are about to introduce support for nested lazy MMU sections.
> As things stand we'd have to duplicate that logic in every arch
> implementing lazy_mmu - adding to a fair amount of logic
> already duplicated across lazy_mmu implementations.
> 
> This patch therefore introduces a new generic layer that calls the
> existing arch_* helpers. Two pair of calls are introduced:
> 
> * lazy_mmu_mode_enable() ... lazy_mmu_mode_disable()
>      This is the standard case where the mode is enabled for a given
>      block of code by surrounding it with enable() and disable()
>      calls.
> 
> * lazy_mmu_mode_pause() ... lazy_mmu_mode_resume()
>      This is for situations where the mode is temporarily disabled
>      by first calling pause() and then resume() (e.g. to prevent any
>      batching from occurring in a critical section).
> 
> The documentation in <linux/pgtable.h> will be updated in a
> subsequent patch.
> 
> No functional change should be introduced at this stage.
> The implementation of enable()/resume() and disable()/pause() is
> currently identical, but nesting support will change that.
> 
> Most of the call sites have been updated using the following
> Coccinelle script:
> 
> @@
> @@
> {
> ...
> - arch_enter_lazy_mmu_mode();
> + lazy_mmu_mode_enable();
> ...
> - arch_leave_lazy_mmu_mode();
> + lazy_mmu_mode_disable();
> ...
> }
> 
> @@
> @@
> {
> ...
> - arch_leave_lazy_mmu_mode();
> + lazy_mmu_mode_pause();
> ...
> - arch_enter_lazy_mmu_mode();
> + lazy_mmu_mode_resume();
> ...
> }
> 
> A couple of notes regarding x86:
> 
> * Xen is currently the only case where explicit handling is required
>    for lazy MMU when context-switching. This is purely an
>    implementation detail and using the generic lazy_mmu_mode_*
>    functions would cause trouble when nesting support is introduced,
>    because the generic functions must be called from the current task.
>    For that reason we still use arch_leave() and arch_enter() there.
> 
> * x86 calls arch_flush_lazy_mmu_mode() unconditionally in a few
>    places, but only defines it if PARAVIRT_XXL is selected, and we
>    are removing the fallback in <linux/pgtable.h>. Add a new fallback
>    definition to <asm/pgtable.h> to keep things building.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


