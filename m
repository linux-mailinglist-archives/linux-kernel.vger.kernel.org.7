Return-Path: <linux-kernel+bounces-813541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE908B54742
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A035F3A7B38
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A180D280308;
	Fri, 12 Sep 2025 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIgFH+24"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB9277CBF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668814; cv=none; b=ujB5EDSJxLcSET8CHUjAUeMQDFok2jFeToMYLRgBVpmlrBJCjhG7nORGpZf8Jnd9OPqfEIGnr/4K3TGUEanJl4G9PDQRE3HJgYNpjnZxK550XPKKMaHGjsz1PdYekbMQXMZv1+XODR0VCJShPEsTt5m3RbgytWWkhEI6P3PQCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668814; c=relaxed/simple;
	bh=xjTvdo/L0AxTEDZhqxkuhpa1VCc2uJtoIGiiUhrWrT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ovo60tOJ2AY3RI8p2BFMXhPvaLckgY+UesJwUtTLNftDH8L3hFlkeLYU1a0Bi2EiKV/Gef+iePoONOJf52EmSlBbgDQiwiUTI4sjvoLLS7MTCrS+pHoE3ipE2REwEY3yp32qOGJ+yZ+V7jwT4ePEi5ARMetF2zAvfCwSgXNFueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIgFH+24; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757668811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+MzP8ZtzjuFzx7no/Z95bzESB3nOqylto37d5k77ugs=;
	b=JIgFH+24Jj9eHdrh2r65d4whFVGZufAQ+j/FAkutV92PVhRkzAHJ/yOY9JZlTRpjm/wZP+
	iI0RcanYPQB1SnWjvfJyidjhtEzVKNdvgvttpHrxhp2+8sgwGefP2R0jmvx5SAgyJ8SQpi
	bp6NwxNeonrlymbSvAQc+16C0KSL26Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-1iwPZFscMW6HYDeRznIO7w-1; Fri, 12 Sep 2025 05:20:09 -0400
X-MC-Unique: 1iwPZFscMW6HYDeRznIO7w-1
X-Mimecast-MFC-AGG-ID: 1iwPZFscMW6HYDeRznIO7w_1757668809
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45e05ff0b36so5822575e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668808; x=1758273608;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MzP8ZtzjuFzx7no/Z95bzESB3nOqylto37d5k77ugs=;
        b=jTUnfQTjoye2gwfCkvAwGq+k5Krkn5OXvOgHedrHEOcaF7mZJTXmDTt2OOm5WK3F4s
         rJ5tVXMTab53LJjkCrKhJz6uCV6fGb5H3q9///3PehjXS5I+kHMtx+7xABnAP4IZHe+H
         HDKtxhAN/AKdPVoiYJWxDvcipRTt35w9oR8n51R/B4wCofSAaUm7fAlw8ep48yxAkE9R
         8GX65BLa6F3xDiC+gOVv0B+EYHOeNVuNovkafZ+IAVa52Wuxc4Cau/5DeIQj0FtGb9l2
         QYBo2+B5hhCHsio5LpZgDqg4zlM/ZVOsAI7K9F1N0YIKVP5WfsczgBn6DLEFUZM8BLvM
         ARTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEklvAzFv8Ut1Lcf5nx/vk+ho93MlZz6WSotvux3HCoAXBxL30Zi/ybjushBHTXdEsRx7+3jor3sZgBNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+dWtHWszajs5R12kjSSd/jz1Zhjs6CQqtuEM8+uKt/x03J5z
	Xzu1Dirru40z6ZbzldbLvHG77wpmkgUzXz70/xF3hnFjnLu9xoAynYN0mcPHN1+myO/daeG/UyY
	jsnlQntu1l4yN6R+r8BATZdPLP5sZ912zlFypg5mEF8LtR0IBpMUWbGiiqpGWx6IxoQ==
X-Gm-Gg: ASbGncvaOhFjYQ6+8NeJoTf2se2pUNQA3FDtG2rUQQBvW8kS3dQpEjMcC0UzoYXsB5Z
	pK8coDl+lVM/2V02Dc1096gTibv+0CxnSN0XAraSk8MqJ9SbE6ZDIpbQvWQAQSOPQSCaDqXR+Lx
	ZH+V3CSiH0eimTa3fek4fuWDHMFErO+h0UhHdfeH/KRnv/PKuBpC9EP8320OSx8qHQSDl0DK14x
	CoXB7oLVmVgT0SxX7ZqvkumauHQuDwFg4N+fBdjl/S9a8rG9+i7OjfQrYHXaCkZqfMe+b6Kz1av
	mL0cq0gzAQEduECSi1RXsDwftlbu2kLEdlHVM1CjsSLJF4GmTnjSwgnykYoD+RtbBTQcB74+6bk
	mOrAePvHT83DHc9L3O8ZoO8bTCGIZ2LhfnLwHFc1Uzcxr7fyEytgb9zfDMFkH+bMgD0Q=
X-Received: by 2002:a05:600c:c112:b0:45b:9b9f:88cb with SMTP id 5b1f17b1804b1-45dfd5fa22amr49779915e9.16.1757668808484;
        Fri, 12 Sep 2025 02:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXkEspv+20MlFbesTl37GXWHbZfquxB4ih7Dl0E1NZ+jD5GQeintUf727ez0VnQ0g0eWxksw==
X-Received: by 2002:a05:600c:c112:b0:45b:9b9f:88cb with SMTP id 5b1f17b1804b1-45dfd5fa22amr49779515e9.16.1757668808019;
        Fri, 12 Sep 2025 02:20:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0156c64bsm58222385e9.2.2025.09.12.02.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:20:06 -0700 (PDT)
Message-ID: <3674bdb2-0e59-4f0d-8adf-4794a6db546c@redhat.com>
Date: Fri, 12 Sep 2025 11:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 01/15] mm/zone_device: support large zone device private
 folios
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: damon@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250908000448.180088-1-balbirs@nvidia.com>
 <20250908000448.180088-2-balbirs@nvidia.com>
 <8c5267ec-cc85-4eff-b890-eb705472e2b2@redhat.com>
 <f98d3149-9cc1-4211-af8f-e49547134b8c@nvidia.com>
 <244005a2-4796-4985-853e-f916bdfd096a@redhat.com>
 <ce40579b-4ded-473b-8fdb-a41d5b5021d5@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <ce40579b-4ded-473b-8fdb-a41d5b5021d5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.09.25 06:49, Balbir Singh wrote:
> On 9/11/25 22:52, David Hildenbrand wrote:
>> On 11.09.25 14:49, Balbir Singh wrote:
>>> On 9/11/25 21:45, David Hildenbrand wrote:
>>>> On 08.09.25 02:04, Balbir Singh wrote:
>>>>> Add routines to support allocation of large order zone device folios
>>>>> and helper functions for zone device folios, to check if a folio is
>>>>> device private and helpers for setting zone device data.
>>>>>
>>>>> When large folios are used, the existing page_free() callback in
>>>>> pgmap is called when the folio is freed, this is true for both
>>>>> PAGE_SIZE and higher order pages.
>>>>>
>>>>> Zone device private large folios do not support deferred split and
>>>>> scan like normal THP folios.
>>>>>
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>>>>> Cc: Rakie Kim <rakie.kim@sk.com>
>>>>> Cc: Byungchul Park <byungchul@sk.com>
>>>>> Cc: Gregory Price <gourry@gourry.net>
>>>>> Cc: Ying Huang <ying.huang@linux.alibaba.com>
>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>>>>> Cc: Nico Pache <npache@redhat.com>
>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>> Cc: Dev Jain <dev.jain@arm.com>
>>>>> Cc: Barry Song <baohua@kernel.org>
>>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>>
>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>> ---
>>>>
>>>> You missed my comments of this patch in v3.
>>>>
>>>
>>> Hi, David
>>>
>>> Looks I missed your comments, just checked those were largely about alignment and
>>> integrating the code for DEVICE_COHERENT and DEVICE_PRIVATE cases into similar looking
>>> bits for zone device folio free and code-alignment. I'll take a look and update as needed.
>>
>> Yes, and the confusing folio->mapping = NULL that I cannot connect to THP support.
>>
> 
> I can remove that, let me reunify those bits, seems relatively straight forward

BTW, I was wondering when we invalidate folio_test_anon() by clearing 
folio->mapping int he current code flow?

I mean, this must happen at some point when freeing device folios.

-- 
Cheers

David / dhildenb


