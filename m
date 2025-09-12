Return-Path: <linux-kernel+bounces-814442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F950B5542A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CB81D65BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1302263F49;
	Fri, 12 Sep 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcMw5SUv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4F222560
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692304; cv=none; b=QAGECUNvFQ6jX5165T9oENWYA8KuFtzHs3KiQYbow3IiqLHIM8noCGblz21j2fdoHm+vtZq5s390zQVY0IbECiMTMiQTLMeh9fXRckUqxs3b3Epa10Q0Ow8xUdceDgHuP1QJJlmnYglpAm8NugrLvFDWlBF4raOZDt8CdCcnt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692304; c=relaxed/simple;
	bh=8rdXAHjf1qNhSLyvo4ghb/MFVMN9CJC6T58LiqUjX7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAAGff9PuW/3zd6tKVsC+K8QSJIwi1LUCsX/tuA4D7DbEA+yyEC5DoodU3JjG8Ts61fXxKMi2KRg+Uq41Q2+asEv4/897oPWkqFhAz94lyZyiLtZZmokAZjScIx6uqoJwcRFOV1zu+bjDhzQpQBpCYc5BpAOEJByHpA1gE2o1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcMw5SUv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757692302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=evSM+hUM6XOAVnv4pWD+Pp87EHuxINXdM8cowVunr7o=;
	b=UcMw5SUvI9wT0spNvE4O6YS4ihll63pjbUUdShE9Jrq3HQp13uH1vkpHWQ0IyudWEglS4n
	y5gSaK+I82LAVOtgSsB8ZP/clAZvuxkFrlJoNMyGGhvgsG2ngQzLExHBcAFm6tRBKvEGQe
	uVR5BQ9v1zDNoo+MYxgwOXIGZw7NBWk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-XJf5sLRaO8KnUZXSU9NIkw-1; Fri, 12 Sep 2025 11:51:41 -0400
X-MC-Unique: XJf5sLRaO8KnUZXSU9NIkw-1
X-Mimecast-MFC-AGG-ID: XJf5sLRaO8KnUZXSU9NIkw_1757692300
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so11774135e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692300; x=1758297100;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evSM+hUM6XOAVnv4pWD+Pp87EHuxINXdM8cowVunr7o=;
        b=QAogEp9lPsni9eC3naVYoR+3yq4V6SNLJsxTFEfv2G46xVYKmi+NDzWiqkfYhnKqqe
         P74JT/y9g0k5Z4Pk/BAkc0vI1CxC9x6tBkL80bZZ59Ynom1g1JO4Hr2pTS2Oq1HdT43O
         oAf4horUuX0qQxelnc3ndTuXyx0q1whBiyzUr+fGvU+MbHiMWb+ksSjZXHy093jBZ+uD
         zeOuopP/U/hg3V8s79Xu+H06Kz4nRNiRzU/WT193kAqDSRPgb/GM+Do8SE9TftAOhJDx
         Maim5J22KH8WG9OL3LtrhBeBr7hwcaOTUGBL72el5J1XKs8NJ49RztBJn24Dgv6mP4cq
         xM2g==
X-Forwarded-Encrypted: i=1; AJvYcCUqZEeJsBjTNhVCYl/TxBinuIT3yiMA/k73IhHg9gjscAHD6Mpj6BTyMlkc397OzmSOYL8RyPMAB8L9pZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO/OkfG5VvnqAylsczqM72i6Y2G2fB/+oA844wz5SsXm1yHTYA
	V5mw0PAudxxOs8XD/gEbNP2rroQ9vmX51E881NmYph5brUfDZSft44en4Kt2d6YKWviysI2YMMW
	kVeMZfI4hrWxD88lgQV82U4aoe+9Yh4ljSumSCxb2mQpMAGRka+gVDTTeJCVoP88xzw==
X-Gm-Gg: ASbGncu22zYb9q+tfqEUmuMoYBxa0uoVfQ7qihU/OSqnWOhoekqEU9FS1OpvEsG6+h9
	90Xtc5wiOX75+u8UPeRCUnWUZzDeHm4eJEyQKioAZ2g8MNY5KP3cEH7gFRN6rcxT+un4fOAleMA
	Fb0/zjru6iy3zYphHbcLrUY5/pUGm/CKFpWrbsgz5yBTKoZOtl42VGluc5aXJ/nSJ/6fLLUaUFv
	U1Cp2jYC2FaRNNl63uP+v18+/NEJNKWqW9q84EBrq9dZUiEr/KaCgsc/5tcaFr37tYb/PMq7S+S
	u40Xxb52D4gFs4pwarQLRR/eiuJ0Cqcf7S7E5jHdR6VqRDTtGUyrrXML5PpyZ7y8OhXp1jOEjZy
	GKioD1yqt6nqu6fkniRrqXNaMKohKESihJyaaZynDyPY2Z+2KNCAj/UoaJTueYo4U5AA=
X-Received: by 2002:a05:600c:2251:b0:45d:f7e4:88b4 with SMTP id 5b1f17b1804b1-45f211fee13mr31607545e9.30.1757692299860;
        Fri, 12 Sep 2025 08:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTJ5GavPsbuXit70YFZCDKrkElDxaBYazDmnr1RZ35Woeh3Th8WiB7RfPyeeDQGWEoFz+o1w==
X-Received: by 2002:a05:600c:2251:b0:45d:f7e4:88b4 with SMTP id 5b1f17b1804b1-45f211fee13mr31606965e9.30.1757692299300;
        Fri, 12 Sep 2025 08:51:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm647828f8f.27.2025.09.12.08.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 08:51:38 -0700 (PDT)
Message-ID: <6c8a85b6-232e-4341-8df1-501b9d73e14e@redhat.com>
Date: Fri, 12 Sep 2025 17:51:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Kiryl Shutsemau <kas@kernel.org>, Pedro Falcato <pfalcato@suse.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org,
 hughd@google.com, richard.weiyang@gmail.com, lance.yang@linux.dev,
 vbabka@suse.cz, rppt@kernel.org, jannh@google.com
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <20250912133701.GA802874@cmpxchg.org>
 <da251159-b39f-467b-a4e3-676aa761c0e8@redhat.com>
 <hcpxpo3xpqcppxlxhmyxkqkqnu4syohhkt5oeyh7qse7kvuwiw@qbhiubf2ubtm>
 <k54teuep6r63gbgivpka32tk47zvzmy5thik2mekl5xpycvead@fth2lv4kuicg>
 <y6ljs2byyzxkxqqxaf37kx5lqpshv47ndejksen2ihrvhcwksc@4r6f4sdtjd3g>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <y6ljs2byyzxkxqqxaf37kx5lqpshv47ndejksen2ihrvhcwksc@4r6f4sdtjd3g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 17:44, Kiryl Shutsemau wrote:
> On Fri, Sep 12, 2025 at 04:39:02PM +0100, Kiryl Shutsemau wrote:
>>> Shower thought: it might be in these cases especially where the FreeBSD
>>> reservation system comes in handy - best effort allocating a THP, but not
>>> actually mapping it as such until you really _know_ it is hot - and until
>>> then, memory reclaim can just break your THP down if it really needs to.
>>
>> This is just silly. All downsides without benefit until maybe later. And
>> for short-lived processes the "later" never comes.
> 
> The right way out is to get better info on access pattern from hardware.
> For instance, if we move access bit out of page table entry and make it
> independent of the actually mapping size that would give us much better
> view on what actually is going on.

We discussed this a couple of times in the past, the problem is that it 
does not help anybody really if all but a handful piece of hardware 
provides such a features.

Long long long term I agree, short term we cannot really build core 
infrastructure around any of that.

-- 
Cheers

David / dhildenb


