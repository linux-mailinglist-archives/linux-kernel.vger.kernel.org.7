Return-Path: <linux-kernel+bounces-730466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E20B044EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1547316BF94
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E03725C83A;
	Mon, 14 Jul 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwPwM1Ho"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729B2561D1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508988; cv=none; b=e6ebQr46PKPvUnq1WCvr4NcQjFYXidKPrZxSmVbCf9EbY12HwQVQqf6UY0C8zlvmyMypRIY597bsKQqKxD/S+xodQbp9gqXmQQbFpVNP50szCH3NFd+vpv3GQkqKrZ0IfwrxiEbC+WME007ai6Gfuz5jQ4z9khncv6af+gnpcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508988; c=relaxed/simple;
	bh=Agq3glvLyM+Hu+0gjVSSne1ThzaoFQ8Es6T9yyDoNJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwYw+g/Po6eA6N8ECbfBQwx0Mlg3ALXnUXQ7kvFQrFwx96NqdJGgoVBGgp8bbjasFzEJ1lwVQoGSJWffB9Sl3SCYe1eWMvztOGhbpLaDkaiRQhOuvDO/5ddbZnWZwH1FUH5kWDpAvxpMgS/WAVX8vMAnqQuFtShRRfv/oYVSzdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwPwM1Ho; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752508986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GV6PSSefxKzCSWO7S7vajPJfsMxjvhE+nCxM7rf1U24=;
	b=BwPwM1HotdPY/+xKBMPpIkSZ/sEW+Q1wKB6bYVXyU3+6FnPXe6DUvr9MxV8fZwegYvq1aJ
	Z5TdOlihc5cz4wHdfVhW0EGpy2xFA0Wu543Qo8MlhrSmqaxp+jAPPNT2DvdGJmG7oZSz4F
	knHWwhZ6gIfFrDlQWLTUFvYKD/xwiy8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-rDfTX3Q6Pu-xj-Jy4SU8xQ-1; Mon, 14 Jul 2025 12:03:04 -0400
X-MC-Unique: rDfTX3Q6Pu-xj-Jy4SU8xQ-1
X-Mimecast-MFC-AGG-ID: rDfTX3Q6Pu-xj-Jy4SU8xQ_1752508983
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so1829216f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508983; x=1753113783;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV6PSSefxKzCSWO7S7vajPJfsMxjvhE+nCxM7rf1U24=;
        b=pKoHGMmwoUEYFWds/hkdsv8Siqdd5onLD2j1u38NOzlFMjpRgkpLaOovbqZL3yFuc3
         DKwj1qZlbsy6bS6ytwUG0DZTWoGPY5WXmzPO2CuChItDskk4u37bQt2zGi0P3OZx0OwI
         UW6oVcWMgnS5/KrZYMWQiotgR3KLtZ7GQ7n37EQi0kM2Ms8+akRlnp/0k81V/u3eULuN
         +A73O7hhFB0s6UwCstrkWx7bv80Xt8MLq2F+jOEQzFXWzw4DQWCuWTNz9weghNdG7OPj
         y0P+Cz985ftHwDvw2L0gjODHZicCBoA+KffFLyDyt4M+umjnHXtojBgfPR4pNcecz3fL
         XQRA==
X-Forwarded-Encrypted: i=1; AJvYcCW+MGk8D7PdmnI/cBCT+s97NHyHa0QlU40fkEoqkzm+9EN0IiueT3pKI70hR8OrF5P7DbvYD6KXo7quL3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/xHX9CSDE156AJ5XBvR39YB9WpuW+iJgQRPYhN4o4NnZgJQF
	t0053zmX2Qgax15S4eCVWKJU9HCAb+H1lgrKTtd/WVfflUZY/KLUnUakojKXBljSlxR5f1Z0DZh
	ntOxuOfDSeLgTz4WGHqyAUEnA0u4kWk4/sAlEJX2fxZazz/o9GRnZl0eType6qqOOfw==
X-Gm-Gg: ASbGncvzGNC6iz/cWD45jD/hkFQxpnNW52Nsc1tALfotiet8l8RaXjrfXB5ca6k0eKr
	05pbrenD1znFXAwrpbCRGGI5y9FK8SGdcP1MM4QC3Cf9cxrWcrHAi7ZPkHeq/6zzeg16u2r4hc2
	1P1Dh2nVEJeq7iuvOew3uPAQGPlEIDvEttB55i0qoYhQOAZ9b1HQfLkw2PCsuT3v288iTiOVr0j
	+gspF3ywhy7gdBi5/1pd8DhjWW5l/azAMK6NT3XaZu7EoQxGj0gmUyaAVLpTY4llXLfYLHx8xzA
	6IidzG89gNPT5dbjCBgT6OnZc9Y+yv3yNMWiEaus31POukUYkEaFAFWOiTq98t+cZ/xbWntaCp8
	308dJS7dizdSPxsDMLphZ2AKiMNZE/kUY7i02zYjAi66qx+SRRKvuWIhzmIwEr4XP
X-Received: by 2002:a05:6000:1a8b:b0:3b2:e0ad:758c with SMTP id ffacd0b85a97d-3b609520267mr121415f8f.3.1752508982856;
        Mon, 14 Jul 2025 09:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYX8DhnPzZT8aBr082szZrq3t2cQhQjtSV//+pqGWtN3JAoScFltm7i6CtiBKnmJfigF+5rA==
X-Received: by 2002:a05:6000:1a8b:b0:3b2:e0ad:758c with SMTP id ffacd0b85a97d-3b609520267mr121350f8f.3.1752508982151;
        Mon, 14 Jul 2025 09:03:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455ef31717dsm101130965e9.6.2025.07.14.09.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 09:03:00 -0700 (PDT)
Message-ID: <c5c964cd-947e-43ff-9c79-18c1555aea8e@redhat.com>
Date: Mon, 14 Jul 2025 18:02:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] KVM: TDX: Decouple TDX init mem region from
 kvm_gmem_populate()
To: Sean Christopherson <seanjc@google.com>, Yan Zhao <yan.y.zhao@intel.com>
Cc: Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rick.p.edgecombe@intel.com, kai.huang@intel.com, adrian.hunter@intel.com,
 reinette.chatre@intel.com, xiaoyao.li@intel.com, tony.lindgren@intel.com,
 binbin.wu@linux.intel.com, dmatlack@google.com, isaku.yamahata@intel.com,
 ira.weiny@intel.com, vannapurve@google.com, ackerleytng@google.com,
 tabba@google.com, chao.p.peng@intel.com
References: <20250703062641.3247-1-yan.y.zhao@intel.com>
 <20250709232103.zwmufocd3l7sqk7y@amd.com> <aG_pLUlHdYIZ2luh@google.com>
 <aHCUyKJ4I4BQnfFP@yzhao56-desk> <20250711151719.goee7eqti4xyhsqr@amd.com>
 <aHEwT4X0RcfZzHlt@google.com> <aHSgdEJpY/JF+a1f@yzhao56-desk>
 <aHUmcxuh0a6WfiVr@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <aHUmcxuh0a6WfiVr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 17:46, Sean Christopherson wrote:
> On Mon, Jul 14, 2025, Yan Zhao wrote:
>> On Fri, Jul 11, 2025 at 08:39:59AM -0700, Sean Christopherson wrote:
>>> On Fri, Jul 11, 2025, Michael Roth wrote:
>>>> On Fri, Jul 11, 2025 at 12:36:24PM +0800, Yan Zhao wrote:
>>>>> Besides, it can't address the 2nd AB-BA lock issue as mentioned in the patch
>>>>> log:
>>>>>
>>>>> Problem
>>>>> ===
>>>>> ...
>>>>> (2)
>>>>> Moreover, in step 2, get_user_pages_fast() may acquire mm->mmap_lock,
>>>>> resulting in the following lock sequence in tdx_vcpu_init_mem_region():
>>>>> - filemap invalidation lock --> mm->mmap_lock
>>>>>
>>>>> However, in future code, the shared filemap invalidation lock will be held
>>>>> in kvm_gmem_fault_shared() (see [6]), leading to the lock sequence:
>>>>> - mm->mmap_lock --> filemap invalidation lock
>>>>
>>>> I wouldn't expect kvm_gmem_fault_shared() to trigger for the
>>>> KVM_MEMSLOT_SUPPORTS_GMEM_SHARED case (or whatever we end up naming it).
>>>
>>> Irrespective of shared faults, I think the API could do with a bit of cleanup
>>> now that TDX has landed, i.e. now that we can see a bit more of the picture.
>>>
>>> As is, I'm pretty sure TDX is broken with respect to hugepage support, because
>>> kvm_gmem_populate() marks an entire folio as prepared, but TDX only ever deals
>>> with one page at a time.  So that needs to be changed.  I assume it's already
>> In TDX RFC v1, we deals with multiple pages at a time :)
>> https://lore.kernel.org/all/20250424030500.32720-1-yan.y.zhao@intel.com/
>>
>>> address in one of the many upcoming series, but it still shows a flaw in the API.
>>>
>>> Hoisting the retrieval of the source page outside of filemap_invalidate_lock()
>>> seems pretty straightforward, and would provide consistent ABI for all vendor
>>> flavors.  E.g. as is, non-struct-page memory will work for SNP, but not TDX.  The
>>> obvious downside is that struct-page becomes a requirement for SNP, but that
>>>
>>> The below could be tweaked to batch get_user_pages() into an array of pointers,
>>> but given that both SNP and TDX can only operate on one 4KiB page at a time, and
>>> that hugepage support doesn't yet exist, trying to super optimize the hugepage
>>> case straightaway doesn't seem like a pressing concern.
>>
>>> static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>>> 				struct file *file, gfn_t gfn, void __user *src,
>>> 				kvm_gmem_populate_cb post_populate, void *opaque)
>>> {
>>> 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
>>> 	struct page *src_page = NULL;
>>> 	bool is_prepared = false;
>>> 	struct folio *folio;
>>> 	int ret, max_order;
>>> 	kvm_pfn_t pfn;
>>>
>>> 	if (src) {
>>> 		ret = get_user_pages((unsigned long)src, 1, 0, &src_page);
>> get_user_pages_fast()?
>>
>> get_user_pages() can't pass the assertion of mmap_assert_locked().
> 
> Oh, I forgot get_user_pages() requires mmap_lock to already be held.  I would
> prefer to not use a fast variant, so that userspace isn't required to prefault
> (and pin?) the source.
> 
> So get_user_pages_unlocked()?

Yes, but likely we really want get_user_pages_fast(), which will 
fallback to GUP-slow (+take the lock) in case it doesn't find what it 
needs in the page tables.

get_user_pages_fast_only() would be the variant that doesn't fallback to 
GUP-slow.

-- 
Cheers,

David / dhildenb


