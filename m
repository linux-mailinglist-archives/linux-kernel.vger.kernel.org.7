Return-Path: <linux-kernel+bounces-800040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694B3B432B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04B61C21D94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72BF278751;
	Thu,  4 Sep 2025 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+N2XwRs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBBD277C8A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968145; cv=none; b=iqvbgZilEwh1oZ3dXE65vGLNN8xi11FcgoIgfNwyuyGy2jwR44uBNKltQ2sIfnJaOwy56fzLUBl0qN4QVkzBXEA6N0P+l7s0I//uPUNvQS3iaFZvZERjhUXg9WytvL6TwkxMaSk0OKAboNd2qnTRBoRbaApbQs4dMDQmOeDficE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968145; c=relaxed/simple;
	bh=mbsCidHuDFSi5UmseFFsnCuUNGS7u0uaYSOr+Ziijs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xk7+yD4OYXZ7lVImzn4E8R3eQlRuiH+4Z7De5RWsaQBafPjRl5/FqXHl4GvxhmC8VUobgv29D0QGPHClat4tLNKFXgNeu0xaZW6jrZ3xrDDtEJ8t6XdJOKuFNajB0EsxFcn0tSAGMj06vye5CRCbAUSyeU+cSrGZ6j/99k5kuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+N2XwRs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756968142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KToomWKj9mg5gO92HiOMCLhfsKGdUXoXNpj3PWwnJys=;
	b=a+N2XwRsVY1jQOT10nRME0eYTnh6g1eK9MEB/vFifgJXRlAGrt0uqUvDGJFR06JvesM384
	dBA3Dg6Dc3cQTmskahgvd6jnEpQdMSTO27MLw72OOPuPwBsf33DxPGwuytV8oRM218qNxx
	Kw7axC7klSDyWcukl79J3eEXJGhLGkY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-0k8cyXsmNkmDTa_qsnLWYQ-1; Thu, 04 Sep 2025 02:42:21 -0400
X-MC-Unique: 0k8cyXsmNkmDTa_qsnLWYQ-1
X-Mimecast-MFC-AGG-ID: 0k8cyXsmNkmDTa_qsnLWYQ_1756968140
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b869d3562so4853965e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968140; x=1757572940;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KToomWKj9mg5gO92HiOMCLhfsKGdUXoXNpj3PWwnJys=;
        b=FviHCZY50KCU88DOopO/2IDf7WKAlM2zKjYvgaRIkf9Njs0+IjyNiSVVywB3r0wuzR
         dQUA1SboO2LOPSiWTMTQIB0qH7IaFUTrsiHlkkRFRtR76emUGgvtJ0ybtdg6qZ80GrN3
         VktJ5KL7Ahv7tlrV6OzA8nQe3WkwZJhUpMlzULfPRSUjTgC+ksYgmvjSV+HMhMrF7bf1
         IGOwiO3okn3U3DMDSWbrLjAjX9gVkWnLJndkjYP0ONS4lXplnGVtSzyGh3qOzIFznxCA
         kPauxdRDHDWUgMV6eNXuy+iQtfjP/3CH8t1QPYjI1DhOT8Wj5QHRTb93uCNpUVZ6CpWo
         VqNA==
X-Forwarded-Encrypted: i=1; AJvYcCU4x6KQX0IV0Qzi5ZKkwQAg4Z6+6Ingms/ohKjHT0+h4XItIfchL7pLLFxL/4z9H1BOPCMakDVfb7OIRFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFSwhwPBJP3LvYa5DH5JOablmiqpdS699b6d0D/sEpiqULrbe9
	d8N87wva7YjmI44s5jNcPHZYBEyDqiuOXjrtGGSv4Vx47xbEOjrn35tMm3m7Fnw20hZyxoRFtXd
	WYej9V2jr7B2/EfbRFuFYM9ERmr+1Q3m17aSczg6O0ZIgV9zt4nXhaOpcEvJ/mjbYYg==
X-Gm-Gg: ASbGncuT60jmKsApFZP/VtbbI0MXoL6FbUEHhCLQys0x0+oS0ainCXqIENGSuwRADHr
	UM9Fq6rr9B5emCfdLCYB9uoI0I3BKQ9I7+nkIacd2nnwFGX3y0+U68k+HdvbhxochTCC/beU0rf
	z9L5A9l44spCdpu4QR2ianQXAdZLXuYP9gn8x0U4yVhuXCqDcp8vqr6a7I+DhYYKGC/dFEygmD/
	IBLVLp1Rln253mzIpPi39FpA0bHTt6gRmuhJGuZxsCIBoBUhHoGX75Jtz3dMobFPxeHPDeblPJi
	0QcTu87GSEoZ0bL3sdezS5X8LgIhizPb9hWRcKpebuQeVlvpnYFb5U3FPIRLjBRZRTYRGbsGMvx
	rqcafNulHmNHUasJEHGlNyS3vXHW8bP5MRCppEsrsN3+emvtrJGPA+Nf2/oIAYlF/
X-Received: by 2002:a05:600c:3f0a:b0:45b:8703:741b with SMTP id 5b1f17b1804b1-45b870374demr140352285e9.32.1756968139749;
        Wed, 03 Sep 2025 23:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDY+KZJxIteq5+5ELGWzXe1Yo4ms4pskv7HMB5FhUoffpW2kCYxWLFHE3oFlp3rlHbnFi9+g==
X-Received: by 2002:a05:600c:3f0a:b0:45b:8703:741b with SMTP id 5b1f17b1804b1-45b870374demr140351995e9.32.1756968139315;
        Wed, 03 Sep 2025 23:42:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45c6faad9cfsm80007195e9.0.2025.09.03.23.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 23:42:18 -0700 (PDT)
Message-ID: <239ecae6-2fc0-43be-bc63-08f52b39a524@redhat.com>
Date: Thu, 4 Sep 2025 08:42:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix kernel stack tagging for certain configs
To: Matthew Wilcox <willy@infradead.org>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Kees Cook <kees@kernel.org>,
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250902175903.1124555-1-vishal.moola@gmail.com>
 <aLdFxtVpOX-qf0qc@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aLdFxtVpOX-qf0qc@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 21:30, Matthew Wilcox wrote:
> On Tue, Sep 02, 2025 at 10:59:03AM -0700, Vishal Moola (Oracle) wrote:
>> There are 3 cases where kernel pages are allocated for kernel stacks:
>> CONFIG_VMAP_STACK, THREAD_SIZE >= PAGE_SIZE, THREAD_SIZE < PAGE_SIZE.
>> These cases use vmalloc(), alloc_pages() and kmem_cache_alloc()
>> respectively.
> 
> I missed that the third case existed ...
> 
>> In the first 2 cases, THREAD_SIZE / PAGE_SIZE will always be greater
>> than 0, and pages are tagged as expected. In the third case,
>> THREAD_SIZE / PAGE_SIZE evaluates to 0 and doesn't tag any pages at all.
>> This meant that in those configs, the stack tagging was a no-op, and led
>> to smatch build warnings.
> 
> I didn't see those smatch warnings.  Were they cc'd to the mailing list?
> 
>> We definitely have at least 1 page we want tagged at this point, so fix
>> it by using a do {} while loop instead of a for loop.
> 
> We can't do this.  Pages can only have one type at a time.  Since
> they're allocated from slab, they have PGTY_slab.  This will lead to
> a warning at runtime:
> 
>          VM_BUG_ON_PAGE(data_race(page->page_type) != UINT_MAX, page);   \
> 
> But for our purposes (trying to figure out how fragmented the vmap
> stack is making the memmap), we don't need to do this accounting.
> These pages are already being allocated from slab, and slab allocates
> naturally aligned, so we can skip all of this for these configurations.

IIUC what you mean, I am not a fan of having PGTY_stack being properly 
set or not based on a kernel config.

I much rather prefer this being done cleanly for all cases, or not at 
all (OOT for research/debugging purposes).

-- 
Cheers

David / dhildenb


