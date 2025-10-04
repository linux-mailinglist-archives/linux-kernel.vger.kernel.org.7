Return-Path: <linux-kernel+bounces-841923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA56EBB88AC
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 05:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E95A346A5C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 03:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8662A41C71;
	Sat,  4 Oct 2025 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J5giOyR/"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC12628D
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759547007; cv=none; b=OvFP0UPAxN+95Q+7odd2jv41g7K+klW+jzXAgCG+50kx17/ISxhPpHESwFVXibsdJfDDTTDO4H71fsxq22U+QWHVaGRqscJPjm7migdDGZNCjlmsA2zdk69IKd8HT0EfD5wCakDEAjwu5vA719HejHQ0NxcHRlPoitop5noMRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759547007; c=relaxed/simple;
	bh=oAkVYQWfuKaXR5iR9HS3hJHtwrtkR3SGwGoRw1bqi/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6XidRr5CN/n63iCcI11lS+yEIDbDRDZBQxsZ3Y8xuSrrp1Ln05gba/X8Agx+F3X2hM6+Ve87Uiiyz1Jm447MbII0T5+wkL4EEdJrkTwuLA20CrFfn7XQ8ErxQ9nYNFz+RficJ1ytoT3fzAAet1/3JHLQQ961SeSEq7DhWYObko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J5giOyR/; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a36c9776-d158-4add-86d0-c41a09e4a255@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759547002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3w0aPrtz6owLHfo4rKJJGMrd3gYAmvp7fLTky+PAPA=;
	b=J5giOyR/se7ekCKx5d8TRoepFqoYKyM4sDqCkBMDHeM9cIW0yMp4RAR6VjFS9lcB206Qvi
	IK8YfpHIpHsq9thLfgThvt/61NZg2PZ0NrV569eO5F40KoDftwQ9QVhMGSWTBZUKpvv9Sj
	/dNa8V8JMS91Y6gcFxNwtcL5OG+VUSY=
Date: Sat, 4 Oct 2025 11:03:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 2/2] mm/khugepaged: merge PTE scanning logic into a
 new helper
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, david@redhat.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, akpm@linux-foundation.org
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-3-lance.yang@linux.dev>
 <0d55d763-81ff-4b99-bb13-3dbb9af53cdc@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <0d55d763-81ff-4b99-bb13-3dbb9af53cdc@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/4 01:05, Dev Jain wrote:
> 
> On 02/10/25 1:02 pm, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
>> and __collapse_huge_page_isolate() was almost duplicated.
>>
>> This patch cleans things up by moving all the common PTE checking logic
>> into a new shared helper, thp_collapse_check_pte().
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
> 
> In hpage_collapse_scan_pmd(), we enter with mmap lock held, so for
> an anonymous vma, is it even possible to hit if (!folio_test_anon(folio))?

Ah, indeed :)

> In which case we can replace this with VM_BUG_ON_FOLIO and abstract away
> till the folio_maybe_mapped_shared() block?

So you meant something like this:

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2a897cfb1d03..ef87d7fe3d50 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1374,11 +1374,7 @@ static int hpage_collapse_scan_pmd(struct 
mm_struct *mm,
                         goto out_unmap;
                 }
                 folio = page_folio(page);
-
-               if (!folio_test_anon(folio)) {
-                       result = SCAN_PAGE_ANON;
-                       goto out_unmap;
-               }
+               VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);

                 /*
                  * We treat a single page as shared if any part of the THP


