Return-Path: <linux-kernel+bounces-867652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 653B2C03348
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22E38505650
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2F34D4C1;
	Thu, 23 Oct 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaUgJiS4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A0834BA57
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248299; cv=none; b=agzGST+rAHvdBGKgGIvpf4XGZAGKFev1So6fZThXTzA1DD8KrBEW88PysT/HkkaWoRxVpga/1jDXBUgmQRRRdPbKsuMhLwkuBATpysDfa7/ySlrVfPQA8QP71a2a7trLGVmniO3G+CSFcA5yK1uxqA9XPSg5/JtZPRzNn5+0bO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248299; c=relaxed/simple;
	bh=sTUN+OOQ61RIqfM1uoiECgcH1Z+fsNbDFGTm9/X8/M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDtw+tOHOifluucfGUjcRJkqC8C6txsz3BRmXomnl7jX8L1ScsaqtGqAQISDhMtjvjKN0104E9XlIznyKtgXSyp0n/clmfXAkBL+15LUz6cGxh8qwb/LTb/z9/nQdfyhgEJ5aXCT4/9oAmTML1okr+61uQY2TNwqzQF2ucw+h28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaUgJiS4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761248297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VQ7IyiPkbQDl/6FlpFFPP3SSIBn2cmNYnYEr3eJHlB0=;
	b=WaUgJiS4lnTXdFuXbmtBc+ovBYRyZFk/GY87gSYhn6slSvAipbKaOrAXyF0pe0Lkq7PUqq
	H5TQdOzI4ta62Os8GBuYgX46aCuaOW3mFGqw9qF10rfyaee8X/ZwwBOO1+Fwm5uKu5HNH/
	NBND0Wh0hqI6OBLJWNdDn3ajtOJ7B/k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-dBvIHHNvM4Ol2Qk1DjXhxA-1; Thu, 23 Oct 2025 15:38:15 -0400
X-MC-Unique: dBvIHHNvM4Ol2Qk1DjXhxA-1
X-Mimecast-MFC-AGG-ID: dBvIHHNvM4Ol2Qk1DjXhxA_1761248294
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47106720618so8012705e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761248293; x=1761853093;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQ7IyiPkbQDl/6FlpFFPP3SSIBn2cmNYnYEr3eJHlB0=;
        b=oouge8Xis7zNZzK0kpCWQvLMTknWlZAu4bIEEXo++WLmK+gviJEaVSCEMyZ84D+GjI
         cnwxO4Pr2CcvmA1Nf5VEmVZn6eRotbX6PzddTbFiFJSiVwU8XcXtNV/gHEgYRWbyQMoC
         wm11kwiPb81vsLYtpOpruzHTq45Fmup2Ejl8KyjWyCGywUuQz8b3alZGcu+WXNIRP8y2
         Z8zNkWJlZ3UtGqAYbQz/KD1O1ouvXYucAb8LRQ9UcCLmrreeKt9LZAsFGjtaQ03zWA2v
         ckZON6whzXaQOK9oS2RPOS++MLSB3HAbw/Cw/lj3a8NL58BOY79qluU6Ho1GIBS37Jxx
         DMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw92fFMYsbpt7SJABrqu8MQnP+IbQv1AukaZr3RfyNQA7TCImvIfkLQ5xb9kQ9HX6+hfbVwqdqC2W1T70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSGKXJt73yOsjRHUe5bHp4e7j1K+T1EbhwJ9ThC2F8FVHUHctd
	cfV1hAAB1ZnF4DkIhpCwh6vd98HigmomrACqNhyKdn6o9R7i1CeNT8fHmLGWWZieXWK6YOu6sHj
	eyVP8Hga8rEFN611/L4Qut0kkQwYCkgJVDSxdZwo0FjwgOXVGh5cbtoWM+MFrVrSHYw==
X-Gm-Gg: ASbGncsQpgH6kFS2hBQZ3rFTp+kCL9iDftcwbSR24eEBvchL6lRpUMfTeqSMRaN3tV9
	/vmzcIZ86gI2Gr190V9VBUf1AXak7JaBNGZfkEnTtMmYH3PYY7k+v/UNfDxgxG/DbhN6h4dCN10
	ynHAqm2GdJhwIG7z4zLj+iOr+A1jXEEKBfONR91QPBXQ5fVugKnCv0NNEQ09WjSNukuWLEx9/AJ
	6bWSPNpBHuObrdUwdWLVdb3Vlu3Mp42cA+d2PRHSM+diRGSd0v9HiWKT2A7fDBZ5mqW+JojFUJq
	066zq+6MmJespGXqHwpbjJgrf35CtiZiksbx6h8oUFfv4UQptW/KMcwB5itQHaZif4D1uS3Xt8N
	a7Wqm14yU6qG3GJ2Tr5blrdGpWIwRnsR9Q45X9IGApoWjc1wnnvb82yVdE6G6RHtPJdGx1GtLhU
	OFbkTd16C7UfJGw5usruDH9l7JF4Q=
X-Received: by 2002:a05:600c:3145:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-4711791e7a4mr225365405e9.34.1761248293295;
        Thu, 23 Oct 2025 12:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK4kvb9VXDfRke79DTEDXEtAKVHmaVqzR/ZxHwP2FSjJo/KXXf7lv5KID4JKHr2iZrwUPcWA==
X-Received: by 2002:a05:600c:3145:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-4711791e7a4mr225365155e9.34.1761248292920;
        Thu, 23 Oct 2025 12:38:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898eb549sm5405252f8f.41.2025.10.23.12.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 12:38:12 -0700 (PDT)
Message-ID: <dd3011ec-23cc-4431-95a3-a0c2965e7062@redhat.com>
Date: Thu, 23 Oct 2025 21:38:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] mm: introduce CONFIG_ARCH_LAZY_MMU
To: Kevin Brodsky <kevin.brodsky@arm.com>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
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
 Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-6-kevin.brodsky@arm.com>
 <aPNjd2dg3YN-TZKH@kernel.org> <3836a43f-809e-419d-a85d-74606d9daa0f@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3836a43f-809e-419d-a85d-74606d9daa0f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 12:37, Kevin Brodsky wrote:
> On 18/10/2025 11:52, Mike Rapoport wrote:
>>> @@ -231,7 +231,7 @@ static inline int pmd_dirty(pmd_t pmd)
>>>    * held, but for kernel PTE updates, no lock is held). Nesting is not permitted
>>>    * and the mode cannot be used in interrupt context.
>>>    */
>>> -#ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
>>> +#ifndef CONFIG_ARCH_LAZY_MMU
>>>   static inline void arch_enter_lazy_mmu_mode(void) {}
>>>   static inline void arch_leave_lazy_mmu_mode(void) {}
>>>   static inline void arch_flush_lazy_mmu_mode(void) {}
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 0e26f4fc8717..2fdcb42ca1a1 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1372,6 +1372,9 @@ config PT_RECLAIM
>>>   config FIND_NORMAL_PAGE
>>>   	def_bool n
>>>   
>>> +config ARCH_LAZY_MMU
>>> +	bool
>>> +
>> I think a better name would be ARCH_HAS_LAZY_MMU and the config option fits
>> better to arch/Kconfig.
> 
> Sounds fine by me - I'm inclined to make it slightly longer still,
> ARCH_HAS_LAZY_MMU_MODE, to avoid making "LAZY_MMU" sound like some HW
> feature.

LGTM.

-- 
Cheers

David / dhildenb


