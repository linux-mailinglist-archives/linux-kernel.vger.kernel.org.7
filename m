Return-Path: <linux-kernel+bounces-830356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC53FB99755
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B5C19C099D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CC22DFA5A;
	Wed, 24 Sep 2025 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2pZxXuB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8382E03E8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710457; cv=none; b=b33qFcCb0CgzBjxfefDEAo3kDpsaqit8deAeXPosDREeMy0P52wyiaSu+r+KH93Bq8KT5QGO5qfN95kcCGrqsNlkaURxYemaD4FQCrySFaGqCWlck+JpZJ6PURgN6+qEuQFfEMHHRH6WYdtXv52yQDbQF+1OKDxpvScdXaSvY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710457; c=relaxed/simple;
	bh=KQca6ohc3VuWV3PwlUNSpnpD6tBxN+6I8+U6ohAC/0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUM5WEg1ayOC9BLWCivOzRDJ7khKiOc7RTBuKF6Jl1Mfl7mRNyPQPnH1ddFg9rP7Dx1qJ37YfjMPqenJVQ0Sq8BKYFygJ3yZ24LkBHp0BsfCzxbX/QAxpnQHtjKP1DsgbcTVgFmy2rCq3WF9pEwZjj4KG3iIiwXEwj1F6DfWkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2pZxXuB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758710454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eYvl7ezRqdgxCLchmpqGNEskUuk4TYHOhQ80u6nmeiY=;
	b=T2pZxXuBvVxSXECEu8KJZc2ZYVl9k//JP7Tt+tABSm4kd5XwVPNWcfGcToxr15fJnME5tU
	lysJkvQM2xyA8iuklXtJI68rzUi0PR78OiJBL5Q/i+qcQmulLe2VKuLhuAa7sexCfTIXv7
	s2yWjAe6pR9lWX9Rzi9jLSmxf04cVWA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-irTK8YaGOFmOsO3cg9ZwYA-1; Wed, 24 Sep 2025 06:40:53 -0400
X-MC-Unique: irTK8YaGOFmOsO3cg9ZwYA-1
X-Mimecast-MFC-AGG-ID: irTK8YaGOFmOsO3cg9ZwYA_1758710452
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso28432275e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710452; x=1759315252;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYvl7ezRqdgxCLchmpqGNEskUuk4TYHOhQ80u6nmeiY=;
        b=uOGI19bdflUd+flCUHwkD3yOosKnNB+elAf3SQsY7fJte1P72O0DcCEc44zZmcNfrt
         8T8H4ssRp56F5daaSHgKrWYg0e8RERAVAK8IH1rw4eDL2LMcqRPqD+oIP5gPvXCPlnrA
         qPjBJp2zejRVU24fcme3e5m5SqstiH0u6RLoNgvnYA+UqZHp8rriNnYb+esrZhfYgFia
         GhQGnfy+rPfuYsvhcMLDtWtJzbhPp/C5PCK8No7Q1tkOIEXuX7HT65wZQTxuyFk62Gsj
         oJzEAltaKAPS/86lGxaUrkjq0OCqVjP02UNDLvvpDa7EdgUQu+ynaYsmjlKs6IMxkaib
         J1GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXks+qufUeA38YbPWSqICHdp99kv8zaDI+UDgKVnsuRziPCYx1rMqvMMlDtXE8WWXx5iQTFIySirVTxARo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8allizARIBEgqIezbeCr3hPYCGLlUdOh/GoK7k7yFkT5cWyIy
	czze7RCBlrjMl6tyHJGoUpgryy9Q1jIK0t9ddwVF8sXE/r5eF3BjxsnWlT3xuWPcDVgY7Hv5R/c
	Ic5cOdtce/DNFH1dNZWs4m4w6v23j/zv9ymszh2hCO4CYDu9Ru0wGwtX7jox3x4qTWQ==
X-Gm-Gg: ASbGncuIarsNGgpMTkMW/GGP7YM2mH2cswVC8uRmCtpJAE+u4TnQcdBMJ2WaBk7DdeR
	KZ460lsBxwZgHWkZHwBi4APN27oqeuCT0x9ZqMCfqDblMRMzXYKZ4Wn8EdFhSF22rwoG/Lwl1XD
	BQwUSGUo97xlqm814xi/QkJNANHn+ld1wfIPjrn0H/oYEHNySCSwriHqbob0ELGrgIkVsMrZkCU
	dMi97+TC7TdWzD7z6w2Z/QuH6dRGT7UA/FiLg/HVWuynR9iNc9wFi2E4mgbHk6ORAa8pk0g4H3x
	rRvB4x1KHR3JoJMEpTKP+ZvABedc1iJDkychhAOJDVG3W2c1B79MBmJRAy5Nhy0fG2FYn32cCeA
	ZmefqfIL3vcgERbSUPpQIwZRyndOrGAss1jZrHgnoMJ8Xi0e1VRMJKQR9HL0yF61Gcg==
X-Received: by 2002:a05:600c:8b16:b0:45b:7d24:beac with SMTP id 5b1f17b1804b1-46e1d988acamr63832525e9.10.1758710452004;
        Wed, 24 Sep 2025 03:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQUGWyhr6bvPS0QO0bjgArU7ygo/54DWi914RDCMaEcYUUvLnJDJjf0YevNsZ43xh89pWQVw==
X-Received: by 2002:a05:600c:8b16:b0:45b:7d24:beac with SMTP id 5b1f17b1804b1-46e1d988acamr63832145e9.10.1758710451594;
        Wed, 24 Sep 2025 03:40:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9af775sm26973055e9.7.2025.09.24.03.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:40:51 -0700 (PDT)
Message-ID: <bdb25331-4273-4bf8-b095-d052e5124003@redhat.com>
Date: Wed, 24 Sep 2025 12:40:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: abort collapse scan on non-swap
 entries
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com,
 ziy@nvidia.com, richard.weiyang@gmail.com
References: <20250924100207.28332-1-lance.yang@linux.dev>
 <1282de5a-3dce-443d-91d1-111103140973@redhat.com>
 <2i5t62obfweid2zrt33vo3boviw4okha4d3gglw76eqv43ofky@pdv3evw5yjmh>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2i5t62obfweid2zrt33vo3boviw4okha4d3gglw76eqv43ofky@pdv3evw5yjmh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 12:17, Kiryl Shutsemau wrote:
> On Wed, Sep 24, 2025 at 12:10:47PM +0200, David Hildenbrand wrote:
>> On 24.09.25 12:02, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> The existing check in hpage_collapse_scan_pmd() is specific to uffd-wp
>>> markers. Other special markers (e.g., GUARD, POISONED) would not be caught
>>> early, leading to failures deeper in the swap-in logic.
>>>
>>> hpage_collapse_scan_pmd()
>>>    `- collapse_huge_page()
>>>        `- __collapse_huge_page_swapin() -> fails!
>>>
>>> As David suggested[1], this patch skips any such non-swap entries early.
>>> If a special marker is found, the scan is aborted immediately with the
>>> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>>> work.
>>
>> Note that I suggested to skip all non-present entries except swap entries,
>> which includes migration entries, hwpoisoned entries etc.
> 
> Hm. So swap in is fine, but wait for migration to complete is not?

If so we'd have to add the logic to actually wait for migration entries, 
and not count them towards max swap entries.

But that's a different discussion and could be added on top of cleanly 
handling all non-swap entries.

-- 
Cheers

David / dhildenb


