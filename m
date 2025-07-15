Return-Path: <linux-kernel+bounces-732090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0345B061FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCFD5855A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462D61E3DF8;
	Tue, 15 Jul 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVSimqry"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E91E5701
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590809; cv=none; b=ojBQGjoNEn/c7JxNITZ3WnQJpkkGENPgyYzFMWU59IS6WA0GzXCG05Lj0imSrR0OQ+0tg1xsY/lGtt3UE4bjRAb45YLWU1DOiVanr/ZnrBbGzCfsaezT3S+AhsTJKVv3lUdgqCkIJFspkWT4AIK/IEnq3on18ZJfWJdZX8SaKRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590809; c=relaxed/simple;
	bh=4Dx7X+adfNMe1QrirxtiVSDzHq+xAnMsYW1YjuFFRVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qMAV7L1Ntg0J9b13NcdlkuX7N+DODxGmhMsCV5l1aFl9o/c90OWkXKb3GeEjo5Xs8Qbc9EXwLUyC5UHC2HWhYokc/rslEyJmB87xeBe7ZdQiYMml1YO9kh+8idlosZchsPJNU674hrc0UQoipg29xwGZ5HR7WtERnOH9g0L5X2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVSimqry; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752590807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzGhqdPWIdp6qa4/aszQPMFbX29AViQCZYajzErY1Go=;
	b=JVSimqryFlMHtHPaJcAONdmtof6n7/4EE/L9obSF0GF3xPbqHfV5cKLf3Vsg3WbIZLyPw6
	2QPco8KoikOIlNbTAZlqHSoMcYX0XLB38jKMBSHvG7gxBOQsBUqpaMWvwUpHpeMdBmeh2O
	k/n1idixBSwEOyq/Q02w3b5K+CILsfQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-2UvPVVoIMxeLi81s7lnbhg-1; Tue, 15 Jul 2025 10:46:43 -0400
X-MC-Unique: 2UvPVVoIMxeLi81s7lnbhg-1
X-Mimecast-MFC-AGG-ID: 2UvPVVoIMxeLi81s7lnbhg_1752590802
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45359bfe631so33377765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752590802; x=1753195602;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzGhqdPWIdp6qa4/aszQPMFbX29AViQCZYajzErY1Go=;
        b=WCxiiMyMiSmOaOz6xj+Pjcp/qeJ6c8WopC51TIfZgx9VYujcrgKrlD9retb/pf1opC
         UYVIziUCX0sbz4BQjmfR3jS9SQIibEK0oD9tugehyMKA7ykTVVnjA0hCvfw/p5sYuY5Z
         ceCCbYGftEPoNI9Ou0EI2ypVAYa0ewrUHh5iChO/IuhN+OUpDgXkrIWcim4oxmV8H8iW
         9Y/iO1+xAqF8KVcFu7rk+Etv3wo/IFr6Qq+foFMKQiQdF0Pb1/eYK+bB2FNFvTWSqpwm
         lwyELXGAHhTdx1BETitREbvRulq8DeiAyrjhMlqqJPD/IhHhK3IOZL4Z9Y55C9JICE2R
         DkVA==
X-Gm-Message-State: AOJu0Yx7PbVrvkum1W8q5Z8J0qzvagXi1Ge4KY/iwewRG3TOZiVEe3N3
	uByzI0IxwxNSj3lufZ7PxWex5hgQNur2LnAjZUozKO/DynfNw5bj4dxnhsgnxCtXZunDfsE+Uzz
	SL2SKIVXMEBSvxHl0mup1y+WpYTD7Oyv1yL6cD18L1OCioaOkd4shTpIHffR9S7U0qA==
X-Gm-Gg: ASbGncutubkGBjwVcKn39QLKudkFTxlJoxqg2GCbmWUe4MX+yimk+yp7i3yy2AeEc7d
	ZCI3CLGEyOnFQM+2dImAMFRu9iDOku5HfegsGmE9OdSYF18aPjWgZV/7f2k93b0bgfyMmZzE+kK
	qlZT2orlc5Cpa9HRwCrig17M+8+bk9qfq/UhrP3KgDeM6PQJvQcZCX7myeuJIFDxYS6Dsa9MLFq
	P6yQwwj1rafy+M7uJCDCLq9ss+WbCUaPbx4FTMK1fmZJwS+s7k/03dmZXYK72wzGXVWEHW5eYs6
	WHMzj1kgZ24G+2B7Qcl6QDgnKQtux0Ei1iKj5Z2gck/PV2YnJxriBPottkgPy50+Kwm9jMSyUH6
	m0miOALlYFFgRm7BCJhg7jyPPvtfu1y81hEdpYUKnw0+Nykx3o9drPhqCDOem4ga5vv4=
X-Received: by 2002:a05:600c:1913:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-4561a16064fmr92241325e9.12.1752590802058;
        Tue, 15 Jul 2025 07:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqjgRt6fG2l+5726ftG86wKHrZnvMgD5gCYV3wjOd0XaKxS9B031j2vkd+aj4JONoIpTYuyQ==
X-Received: by 2002:a05:600c:1913:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-4561a16064fmr92240845e9.12.1752590801526;
        Tue, 15 Jul 2025 07:46:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600722780sm7615699f8f.23.2025.07.15.07.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:46:40 -0700 (PDT)
Message-ID: <bfbb1fa6-6537-4714-b5ff-a386a86c06c8@redhat.com>
Date: Tue, 15 Jul 2025 16:46:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm: add largest_zero_folio() routine
From: David Hildenbrand <david@redhat.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-5-kernel@pankajraghav.com>
 <0793154d-a6ca-43b7-a0c3-01532d9cccc8@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <0793154d-a6ca-43b7-a0c3-01532d9cccc8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 16:16, David Hildenbrand wrote:
> On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> Add largest_zero_folio() routine so that huge_zero_folio can be
>> used without the need to pass any mm struct. This will return ZERO_PAGE
>> folio if CONFIG_STATIC_PMD_ZERO_PAGE is disabled or if we failed to
>> allocate a PMD page from memblock.
>>
>> This routine can also be called even if THP is disabled.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>    include/linux/mm.h | 28 ++++++++++++++++++++++++++--
>>    1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 428fe6d36b3c..d5543cf7b8e9 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -4018,17 +4018,41 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
>>    
>>    #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
>>    
>> +extern struct folio *huge_zero_folio;
>> +extern unsigned long huge_zero_pfn;
> 
> No need for "extern".

Scratch that, was confused with functions ...

-- 
Cheers,

David / dhildenb


