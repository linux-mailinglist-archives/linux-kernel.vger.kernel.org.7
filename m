Return-Path: <linux-kernel+bounces-732007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7987AB060FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBDB5A2B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7612288C09;
	Tue, 15 Jul 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBTdE9Mh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58934288520
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588401; cv=none; b=DJfwP1lVn3O8fRnXlCRqEK55JuDDBNqImIlTn+m5ghsuXQnaiE7TKyke4HnMUepaqc81MRdCzVAeOoZ2Sn/NGWkRuOkg5gWid8gw9EOjvXV/46ribC4IOJ8q0JWijYrLwzlrOqvtH0WYuZVsXH4G6sSIRPtom1nUqnzQL+WeX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588401; c=relaxed/simple;
	bh=NGjl+k0iCeICYYeTIxSQzRMo78FaxzR0hHeAkayY7lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAEnjSycEb/tCp1SgqVf460DHp5UXa5G19aq/uV8qVpF0IBgJeetAPKwEBjJ5X3g3AmFfDj5H4GaI+QPKRHzWVDAQA0mCgNLBl1F/pCeZWKEKFYoGO6hAxtGsK5hsrxtK+/JK1XnARgZK1Wir8TGj2QaFyFJniOmBK8zvN1z7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBTdE9Mh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752588397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBxA7fPx+kaOUHpIDxI1a9myrZ8g1CRn9224twnAPJQ=;
	b=VBTdE9Mht/erlxJzrCEEmJj+Gucd0WCK3OmpwU0TFC8TX7fsLPYvC0eXMfH4hut2dwBN48
	RJmZgsB3XU+9v5vKm5ZBIN4Ddcflvu91H1z7pZLHIrBG9ZEJ8NQEzIWoN6r+QBIkQujWhH
	q24b0uXkh1gw7cssdK8i7+UHaewGT8M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-MlTp-Td3NzyOwKgblv0WNA-1; Tue, 15 Jul 2025 10:06:35 -0400
X-MC-Unique: MlTp-Td3NzyOwKgblv0WNA-1
X-Mimecast-MFC-AGG-ID: MlTp-Td3NzyOwKgblv0WNA_1752588394
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso4218117f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588393; x=1753193193;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBxA7fPx+kaOUHpIDxI1a9myrZ8g1CRn9224twnAPJQ=;
        b=n+l0pBtWGJaORZZy+iwt79lRHMEAo5Ruv1KBBkjJNIio/G9IT018jlCOIYVxU3VtRN
         3yS4nmG//pKztJ0HQS61FEfT9DlzmFMxf6X7WXWO5mxVeTpjgql4BptGtD+U1Y8pyQ0Z
         sYYAqzlO1DrranjVXW87KuqH76jYM52CbEcSlOUe1bOtVgRKE8obZZeQQ1OnRZUNA2dM
         ndAF81R7k3wHxhwk9lMFHZFtctRP5updoQjxYlZ9XNznEIhG5Ke/zU0AolOH3z1tXti6
         n5iFSnXWMNNXu4PQTuVo4NQ5VrZK2MJI20SMZNYe8bawub0cg88r6u0d421HmCxOZJjm
         nq8A==
X-Forwarded-Encrypted: i=1; AJvYcCXABDrOVvES1mJZL7ovBc9MiXXGC/y9Sxeod+uMqURTqq3oOb1ftOM/jkyT0zGN16vrJKm2b01T7HBBTw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztuyVpPvPaWVX6/YIwnou/01kTbDW0XVL4zZfhFSdrzTh42RK5
	zfr98chhcFUDbRtGzILhUi7IO9NbzSCKmJJ7xGE1tOx8hibwZ3bMGk0O+WOrDsRbzgDdMpYNhqe
	2P3QHTjSlSkA3w9nU4ReZIW35AMQ2+iy6cs/u0v/IlfhGE8Ru/NFsf/Nhf+x9gael+g==
X-Gm-Gg: ASbGncvf1h+kcYfdyOaHdCIXEm88g67DOKUFFCETh0QXZ3MLXSeoWzMjqEuxzIL5JXn
	8k1yET1Ys2KkAnLY7W8G89/mvK/IS02XNGP0zpCg5oVRJUgQiHB+PyKqYXxgSXo1ynuwCnKpzsZ
	T6BTbAC67vS3SgBiQC8Nz5hMYpii/ykDt8Tab9/5Ph6ZAQUNaKawaUkSSJNkt0uecLoaFhktVZD
	qsG+m26JEEnRhgkt1XeHEECVbiZfPRZxkt7CUneGGJy13RgWFW4Rp8VLrrO6IAdjjQFCleRH2dR
	4TrZ9Qn7ZE9sbARg0GgGYOz7NCecWXdoVf8lH3iBUHrytFi+ysFFKPJ7mzu4v+ORpGO0a1UxIRi
	8SExdACBF+6xue9ZJZPOXaMQCLromhXLNWv7iOPnBhAvpyRn7rJdr/AaDfCIcgbhTDSs=
X-Received: by 2002:a05:6000:2085:b0:3a4:e667:922e with SMTP id ffacd0b85a97d-3b5f2dacddamr13012952f8f.4.1752588392966;
        Tue, 15 Jul 2025 07:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWK4HuTxAUxy5B//ipMMWWwodJ7JkwfIbQV6DrOEaPS5dsc6t+pb8z58e8T3W45U4i7z4JQw==
X-Received: by 2002:a05:6000:2085:b0:3a4:e667:922e with SMTP id ffacd0b85a97d-3b5f2dacddamr13012870f8f.4.1752588392263;
        Tue, 15 Jul 2025 07:06:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc217esm14797863f8f.28.2025.07.15.07.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:06:31 -0700 (PDT)
Message-ID: <c3aa4e27-5b00-4511-8130-29c8b8a5b6d9@redhat.com>
Date: Tue, 15 Jul 2025 16:06:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Pankaj Raghav <kernel@pankajraghav.com>
Cc: Zi Yan <ziy@nvidia.com>, Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
 <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
 <be182451-0fdf-4fc8-9465-319684cd38f4@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <be182451-0fdf-4fc8-9465-319684cd38f4@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 16:02, Lorenzo Stoakes wrote:
> On Wed, Jul 09, 2025 at 10:03:51AM +0200, Pankaj Raghav wrote:
>> Hi Zi,
>>
>>>> Add a config option STATIC_PMD_ZERO_PAGE that will always allocate the huge_zero_folio via
>>>> memblock, and it will never be freed.
>>>
>>> Do the above users want a PMD sized zero page or a 2MB zero page? Because on systems with non
>>> 4KB base page size, e.g., ARM64 with 64KB base page, PMD size is different. ARM64 with 64KB base
>>> page has 512MB PMD sized pages. Having STATIC_PMD_ZERO_PAGE means losing half GB memory. I am
>>> not sure if it is acceptable.
>>>
>>
>> That is a good point. My intial RFC patches allocated 2M instead of a PMD sized
>> page.
>>
>> But later David wanted to reuse the memory we allocate here with huge_zero_folio. So
>> if this config is enabled, we simply just use the same pointer for huge_zero_folio.
>>
>> Since that happened, I decided to go with PMD sized page.
>>
>> This config is still opt in and I would expect the users with 64k page size systems to not enable
>> this.
>>
>> But to make sure we don't enable this for those architecture, I could do a per-arch opt in with
>> something like this[1] that I did in my previous patch:
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 340e5468980e..c3a9d136ec0a 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -153,6 +153,7 @@ config X86
>>   	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
>>   	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
>>   	select ARCH_WANTS_THP_SWAP		if X86_64
>> +	select ARCH_HAS_STATIC_PMD_ZERO_PAGE	if X86_64
>>   	select ARCH_HAS_PARANOID_L1D_FLUSH
>>   	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>>   	select BUILDTIME_TABLE_SORT
>>
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 781be3240e21..fd1c51995029 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -826,6 +826,19 @@ config ARCH_WANTS_THP_SWAP
>>   config MM_ID
>>   	def_bool n
>>
>> +config ARCH_HAS_STATIC_PMD_ZERO_PAGE
>> +	def_bool n
> 
> Hm is this correct? arm64 supports mutliple page tables sizes, so while the
> architecture might 'support' it, it will vary based on page size, so actually we
> don't care about arch at all?
> 
>> +
>> +config STATIC_PMD_ZERO_PAGE
>> +	bool "Allocate a PMD page for zeroing"
>> +	depends on ARCH_HAS_STATIC_PMD_ZERO_PAGE
> 
> Maybe need to just make this depend on !CONFIG_PAGE_SIZE_xx?

I think at some point we discussed "when does the PMD-sized zeropage 
make *any* sense on these weird arch configs" (512MiB on arm64 64bit)

No idea who wants to waste half a gig on that at runtime either.

But yeah, we should let the arch code opt in whether it wants it or not 
(in particular, maybe only on arm64 with CONFIG_PAGE_SIZE_4K)

-- 
Cheers,

David / dhildenb


