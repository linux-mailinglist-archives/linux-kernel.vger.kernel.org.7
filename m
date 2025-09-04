Return-Path: <linux-kernel+bounces-800511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09DBB43898
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D5167874
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4740A2FB61F;
	Thu,  4 Sep 2025 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjtQl9Cc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D82C08C4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981262; cv=none; b=N+yRH/+0Tu1EVeCHcHu/rGjTl7Q0IqbVweyxsu3XkiWXyqSeTZBvbHORLrJFXr+lb9ucoEJmCDDym+VAdhpzsZyumXoO+Gu13lC2aRnxf98rIdf68bmmTGC1SO3wFeT7FvBIl41fRu7ZU1uhxxQaCbsLoMEZItcg99efwOGvYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981262; c=relaxed/simple;
	bh=732vDEKo8hDEqqWoTU/wCxT8PtxZsWnBfNwt+276tbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HHuUJ6JvINPxpdjJzfQ0Bn1pmRIm/FLYDq4zyDgvQKoBSSWsa/7es00PE5kH86aqzDDLG3oP0i8k+ssxhyYL3LwlF8XISWxG6zcsktLV1+O+vnbYEB5T0hLzj90Su3v3FfSG1UY6/vv2sKMXAVQRuXCIDpy9mwa4edgJncPFklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjtQl9Cc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756981259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XqzxQnS5sSJsuoXOVa9kL/tW9erHLpA/VVyNbOMAZ2E=;
	b=WjtQl9CcK0swP2FTFTAf87pUfoS8OeJuieMFW7AawMt/pErczDMEXoFsK87PiLKtyG/1Kl
	/fgJ1X2U+O25Ze7iw8SO1fFUnrkM1JcFb8/jL0QlQdPfYKnz5HGEaDBSBVFRwZRi8A2QYk
	tVzWRgSzJu0AB3FHMPEgnGlEZp3hjXw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-asmExJiQPJ6oaozxegZfvw-1; Thu, 04 Sep 2025 06:20:58 -0400
X-MC-Unique: asmExJiQPJ6oaozxegZfvw-1
X-Mimecast-MFC-AGG-ID: asmExJiQPJ6oaozxegZfvw_1756981257
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so4611825e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981257; x=1757586057;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqzxQnS5sSJsuoXOVa9kL/tW9erHLpA/VVyNbOMAZ2E=;
        b=FmTdn9KOv6p6OmXTl/dyjaxEvEc1yG87ALzruffnKlvCsu2GkcsHGoIBwbCuX71PBW
         c8VTwEwZMf1UhrLqc3A7mYsxf13vVSodlXfeO8tleIDumjAfKHvvgKkRtsTMxi7GLxpH
         i9m//0hvCAy/yNCTlDv2amoTZVxrwNimYH6uRRqsbdTk9TXOyY2RxeGOQ8NOpA4QQ9L+
         tvK4kNN74wMza2zP9df2Mijvy17S7TjMSmr4Hppf9MHjeS+vQ/xniuB9IGjrtIE8ahrW
         QvK+YlZBEUZV/jyhTl/b64HAEq71TA7gNhetGDqVJpXpTt+r5yIVzApLRpr1MCV31aN/
         NI1A==
X-Forwarded-Encrypted: i=1; AJvYcCWZByDSB28BfzkGmiW8xbe1IIaoQt4GQG61zqGPu2zOqDhbys5mEnb2LnmGK15+v2QEVPjAeIVHsgUWbvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+82rDatrt6b2ikh3LAOGL3dX3NsJxi+mZ85U8477RzP8BSmLb
	J+uOPq4dyQBeRID6qjmex9lmHs7jtqcs3cK1nMg450k4iDyJzomOI54lWhoqozprc2biVvbCfi/
	nIrnCDmPHk8EEzMZDb8WKPpAx0U18lxq+crEPPx56DOLyFOmffVKlYl6ZZWpyZjxl8A==
X-Gm-Gg: ASbGncuzmqQJ+YaE9KIK2tDgpTE4YmXUirviOuys0MA0bAralRGs4V8Rx/mGM/ASZlz
	wEYy0mTcsOnbE+w7Y+zkyQdK3CGco+LSzUrmwwp3RAkGJk4VyOSsMAneP8ku74PjFxuCYL1XEOT
	9sxc6XU4tZZCdvJbeFpGODcV84VtndQJ2RZrHB3KT+j59oOf84ZLIRryv2UavHiLWbpIPMGuGTR
	1MsXOi+DmRiw980+fRlnzltv1o83dgG0s/A1AspsPkrQ2cYZNfplQmpVpcAWvtxX8JqSkL55gna
	N0n2WR7S/3fidXsuDjl44RuZhO8UjtHGB8uDd01dO43QakpHjfFgv3vp609qs6qOoBocZ6NA28s
	8I5nvE6S+YFw8MTOnfQupA7LFVIf8jpiTMvT6+LRrvseoBoRNQnLrsmuhskZonKIo
X-Received: by 2002:a05:600c:1d04:b0:45b:82e8:c94b with SMTP id 5b1f17b1804b1-45c9ba76d74mr55369345e9.18.1756981257440;
        Thu, 04 Sep 2025 03:20:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt40vKoCxxtZ137G/2w8y2vZ/D5RV93vrW4FJDSiKcaV6bHThukQaGyBp+jrhYjHYtnwgyZQ==
X-Received: by 2002:a05:600c:1d04:b0:45b:82e8:c94b with SMTP id 5b1f17b1804b1-45c9ba76d74mr55368995e9.18.1756981256972;
        Thu, 04 Sep 2025 03:20:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2304e16sm16012995e9.7.2025.09.04.03.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 03:20:56 -0700 (PDT)
Message-ID: <a3777992-21fc-4e55-9a5e-72b17dc86135@redhat.com>
Date: Thu, 4 Sep 2025 12:20:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] mm/memory: Add tree limit to free_pgtables()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com,
 kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org,
 chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
 <20250815191031.3769540-5-Liam.Howlett@oracle.com>
 <39c46a52-f63a-4f3d-a276-6f59c55680ba@lucifer.local>
 <hs5nuhqzqyt5mp3fzznuaiyyck6b6ovuxoxayvm5ofhoa5324m@gtmezuqareiq>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <hs5nuhqzqyt5mp3fzznuaiyyck6b6ovuxoxayvm5ofhoa5324m@gtmezuqareiq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.25 22:19, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250819 15:14]:
>> On Fri, Aug 15, 2025 at 03:10:29PM -0400, Liam R. Howlett wrote:
>>> The ceiling and tree search limit need to be different arguments for the
>>> future change in the failed fork attempt.
>>>
>>> No functional changes intended.
>>>
>>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>
>> (Obv. in addition to comment about broken VMA tests :P)
>>
>> I guess intent is that if we discover any page tables beyond tree_max then
>> we ought to just wipe them all out so, in effect, we don't consider
>> mappings at or past tree_max to be valid?
> 
> Actually... there are some archs that map outside the vma and they are
> valid.. I think mips? and I think lower, but yeah.. it's needed.  This
> is why prev->vm_end and next->vm_start are used as page table limits,
> afaik.  This is a serious annoyance because it frequently adds walks
> that are infrequently necessary to the vma tree.

Hm, does that still exist?

I recall something odd ... was it that gate area thingy (in_gate_area) 
we also have to handle in GUP code? The is x86/arm though, not mips.

-- 
Cheers

David / dhildenb


