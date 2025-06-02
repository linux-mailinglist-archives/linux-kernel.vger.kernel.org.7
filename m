Return-Path: <linux-kernel+bounces-670401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7220CACADE5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 14:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4571960D64
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC82021421D;
	Mon,  2 Jun 2025 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFTVmOcE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACFA1F150A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866860; cv=none; b=M/lxITDu2E/sutx4sEvc5lrlq66G3nm4MsCYMEqcKeuPD9maXqbOEXg2s2WtdovDrSPMecLse6miKsG5knkM4SMHJNhXtJrVd2ymevWL7NIGMZx6ODym+Zxipk4SihTsNx+J6nV/X+t5Ur5/xhybSDkrEQpBZ6C+dJ+e480JEdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866860; c=relaxed/simple;
	bh=7VexDBZvf3qNOI+5jXD27gKijSNLI0gBrzQTwaG/cno=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u5mpkpVhD0X4QXPxj8H5yy/fhvfwjXx8jwrWloSykF5X3pDdp5te9mTPd9Fvfk9BFjE0ukFvWsg/I1271HeVku1OZwbEV483sc27qX0dBN1YllAiU2M25Rs8QMzpq3peu5wS+dKCtakazg3Ov/72s3zUhTte7fwk0KYBIv0HBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFTVmOcE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748866857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fha/wYALl1qC/d0EpO8TYe7+VBeqcFERTe14lUW/UoM=;
	b=jFTVmOcEdkHOe6QFmUCh7tsTjuy/pRtP5++Ylk7EgFBXMc44O43PKANSnkrKxyXZBUXdXT
	8TGjKVTfknlU8j2UqsCaK4oVcw6cK10L2qe77zKPIZ8YHzeq5UVlJr5kHI/fvI7ohe+mle
	9P/gZGW6+A6sAKSz3aFWX+legvPMpRo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Q5KavhefPAmocm--0Yelkg-1; Mon, 02 Jun 2025 08:20:56 -0400
X-MC-Unique: Q5KavhefPAmocm--0Yelkg-1
X-Mimecast-MFC-AGG-ID: Q5KavhefPAmocm--0Yelkg_1748866855
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450cb8ff0c6so21390535e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 05:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748866855; x=1749471655;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fha/wYALl1qC/d0EpO8TYe7+VBeqcFERTe14lUW/UoM=;
        b=Cxft8q9r4+qU27m7oCy9xIgnbK+2k1qLoVC5SlYArG8x1wck4f5ulwaewERGDYtC2X
         hmXn1jso6wrLr3Q1SVg9xIwrTwhp/31T2u7d73T3TET9EmUFaOquC5eWLw5G7K7lhcTl
         4pSqsWUWRfhH3yuVAxwidp5LLVLRg+pBIVR0vo2Oi2XP0oorbifjc6J92j4megnKNHJX
         Tae7J3CO2D74gfF5mUn4aFOF6YDdkPJ/SkfdYfkRKpAkASHxtL8nlxOqkcwaj+7F81R5
         201BiJNzWtouj33y3S66emlRW21hnZFx5+11WeGjaRtuIr4sqe4CCrL8tSvqukVFMNnm
         7S0A==
X-Forwarded-Encrypted: i=1; AJvYcCViy3kbSHObFk+16aLgklE4v1aQVtaNMdPS1xIFWOAYPuWWKbLp5nGtPi+UqBzgmYJA3y8vA6BPISyME3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ+44OvGGXRmi8kwtANYFrO5OB7vp/KSxQU81XyB6LxaP5cjxm
	A4cxeyfKZU3/caacCXxqKpIQ4Y2ZgehdjKSkkapkzqHTgUBYsdgvNE3ES82fOBi9/T233SULlQm
	i2D8bTJbXXp4rhh4bn03zcHfsrD/tbRVJHmwwCTgUq27wY7BmONWwQut2uJCgSHiuhQ==
X-Gm-Gg: ASbGncvspoDWs0msYAzNRwq6Ew3Wt0m28Fc8uV6b8W+oqHGq8Qg0fkEb4igy2x9lARu
	+D/LF0sc5ODWLTrgJaMzybiHfFczZ001icrMOTdlmSUO0Nsaf4wwPcB3ld/xzQMVbJ+veLeHAXX
	65KCLMRkYrF2NtxW0HVE6UiKu+YXtX6zWGuu+rutw1vkgBdpypqkCq+QNGkz4Hsu/MGCddz144X
	BSUHruhSWCLaQgzZmpxZWDj29mrZOvADjmrUzNWC3VT2de0oEsVbZ+e5Ios3X8tn9K2imvkEiQc
	nP5eZfoWRJuJwA5J9+ZmaIOQqT59rwXRM0J5b/d7JXzh7ibBGQ+8HNAcvZ9h9aHxcFhr1PeDap6
	lrnhhxx177qtfJ73W9XrKjZZILg0jhgEXTtGvS4C2jAZjP0/MxQ==
X-Received: by 2002:a05:600c:608a:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-450d87fd857mr103237805e9.6.1748866854937;
        Mon, 02 Jun 2025 05:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIX1lEBcvIjIUWzMHUVHY0RO1zDGA/tS4Yya6bs5LYBrcaJXLO7aiOIgpY/seevYUJEdu6Rg==
X-Received: by 2002:a05:600c:608a:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-450d87fd857mr103237275e9.6.1748866854547;
        Mon, 02 Jun 2025 05:20:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:a300:1c2c:f35e:e8e5:488e? (p200300d82f34a3001c2cf35ee8e5488e.dip0.t-ipconnect.de. [2003:d8:2f34:a300:1c2c:f35e:e8e5:488e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8edf9sm120150665e9.3.2025.06.02.05.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 05:20:54 -0700 (PDT)
Message-ID: <799691d6-d9dd-43fd-805e-7dce6efff3e6@redhat.com>
Date: Mon, 2 Jun 2025 14:20:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] mm: Remove redundant pXd_devmap calls
From: David Hildenbrand <david@redhat.com>
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: gerald.schaefer@linux.ibm.com, dan.j.williams@intel.com, jgg@ziepe.ca,
 willy@infradead.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
 balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, John@Groves.net
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>
 <9c465b24-8775-4852-9618-0873cbf2aaf7@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9c465b24-8775-4852-9618-0873cbf2aaf7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.06.25 11:33, David Hildenbrand wrote:
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1398,10 +1398,7 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>>    	}
>>    
>>    	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
>> -	if (pfn_t_devmap(pfn))
>> -		entry = pmd_mkdevmap(entry);
>> -	else
>> -		entry = pmd_mkspecial(entry);
>> +	entry = pmd_mkspecial(entry);
>>    	if (write) {
> 
> 
> I just stumbled over this, and I think there is something off here in
> the PMD/PUD case.
> 
> vmf_insert_folio_pmd() does a folio_get() + folio_add_file_rmap_pmd().
> 
> But then, we go ahead and turn this into a special mapping by setting it
> pmd_mkdevmap()/pmd_mkspecial().
> 
> Consequently, vm_normal_page_pmd() would ignore them, not following the
> rules documented for vm_normal_page() and behaving differently than
> vmf_insert_page_mkwrite()->insert_page().
> 
> 
> folio_add_file_rmap_pmd() should never set these things special/devmap
> in the first place :/
> 
> What am I missing?
> 
> Note that fs/dax.c calls vmf_insert_folio_pmd() for PMDs and
> vmf_insert_page_mkwrite() for PTEs.
> 
> Consequently, PTEs will never be marked special (corner case, shared
> zeropage), but PMDs would always.
> 
> Hm?

What an ugly piece of crap this pmd handling code is.

Just noting because I stumbled over that myself:

pmd_mkdevmap() does *not* imply pmd_special().

... in contrast to pte_mkdevmap(), which will imply pte_special().


-- 
Cheers,

David / dhildenb


