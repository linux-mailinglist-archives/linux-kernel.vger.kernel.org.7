Return-Path: <linux-kernel+bounces-838672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF71BAFE33
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE1F1C780C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCC22D97AF;
	Wed,  1 Oct 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gJ3r1JI5"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336AB2D97A1
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311520; cv=none; b=nPvHvQbQ6DswhoN6Ig8T01S/xNEgUR2caEtGtQWCw5TkZ6MjdWucnBrE0TAb4bLVObpJGsfdA/O3gFnXbBiNR7kSdx8k91Qp1Ppf8Z/xlkzxfe61hUFP0YOlXVIAKQsyIBPih+4yFCiE/1aP7zdVnc3RQUcSJOmMRR/NRixIkK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311520; c=relaxed/simple;
	bh=l+Iq3s9ic3ncC7AVdq6IwYoPya+HPnetNYenQKnHiRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6OvomMfA8nIQjRel+Glzl5V20J1cbjuyyss1yKXIc5HaZTiSKrySYmV/OFhgKqSDR1xRYtJpqyw4hUrkyH60UsxTXcppHP6S5fGroVOI8diJhlBU72RN9Lf3O4cFul3pE2b2vdTy8puSiCOWOdn2TSSk44t5R5wcGO4mVsjp0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gJ3r1JI5; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4640ec4f-57ee-40f1-92c1-6bc703de7933@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759311513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GV4zvLAZCIS+DJquNo2kGvLSwP9qlPaKfOY4TEmQGuw=;
	b=gJ3r1JI5yO396r9SYNygihameJKZ6f9cXVO1ivaQvB4rLWWT2b9k+EWJydC9FYOwu9QUe1
	JSjK/3oFbWbQ8+theezba8BRMS83uSkYEYJOj4UKekV3eOEeFi7IxVUKfnUOYWfT6VVg2g
	QsTD+DmU8dHl8a0y0ATkGDi3LPbe7Ko=
Date: Wed, 1 Oct 2025 17:38:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
 ioworker0@gmail.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com,
 akpm@linux-foundation.org
References: <20251001032251.85888-1-lance.yang@linux.dev>
 <f07edfc2-0952-486f-ae47-5e3bbd77e4c0@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <f07edfc2-0952-486f-ae47-5e3bbd77e4c0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/1 16:31, David Hildenbrand wrote:
> On 01.10.25 05:22, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Currently, special non-swap entries (like migration, hwpoison, or PTE
>> markers) are not caught early in hpage_collapse_scan_pmd(), leading to
>> failures deep in the swap-in logic.
>>
>> hpage_collapse_scan_pmd()
>>   `- collapse_huge_page()
>>       `- __collapse_huge_page_swapin() -> fails!
>>
>> As David suggested[1], this patch skips any such non-swap entries
>> early. If any one is found, the scan is aborted immediately with the
>> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>> work.
>>
>> [1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb- 
>> a7c8-1ba64fd6df69@redhat.com
>> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680- 
>> dcd55219c8bd@lucifer.local
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
> 
> Could have mentioned you adjust the flow of code to resemble what we 
> have in __collapse_huge_page_isolate().

Thanks for pointing that out! Let's do that separately. I'm working
on a follow-up patch that will unify the scanning with the
almost-duplicated code as you suggested ;)

> 
> Acked-by: David Hildenbrand <david@redhat.com>

Cheers!

