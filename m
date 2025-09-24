Return-Path: <linux-kernel+bounces-830431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D397B99A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0F83B2EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C802FE052;
	Wed, 24 Sep 2025 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qY66QdpD"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75672DFA3B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714460; cv=none; b=jX70x3WMBCOV08oPrGAhNC7RnaBK4vNZwtLwSmdqeaB4uqxNKXC7awxhN420nMlfWEGZqlCtvfuwgTohzMUedSiZ/r69rFaFUao4CqzwQAq8uaz1j18P/h0u4gjdtXLWQG6PianddqJ4TBshcY9Q2ku3T61g/vioKkEjIdYhhPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714460; c=relaxed/simple;
	bh=Umn7lAXySQdSfHE/td8ThDBVs4E2qFo6My0ycKda0Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3EGfcBphBNCWjw6RWELRtqz4L2uIk3CwOeNShTJXe8l6IFMmpvBkaNUSCDZXysPvoGc30NDA+h1GoBQbYCO4OXTAbufaS2UpJ2xD+Qp/q76OdIvhmvAPgECSD8F4FAENL4zQ6VXYlsBO+JtxuEa+VmQFifM2BmLvBEyILi0IXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qY66QdpD; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <69621b58-5142-48ea-9dd8-6baed69e50f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758714449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdcuQ8Buyt2j7x4RPegt18kSFyuHpvpqm9DsW5GElrw=;
	b=qY66QdpDELzY/5yp8cWJGqLqn036vXC519/RCLb15ck8tZjNsuwyKNx9nflHkSV7+DPYdH
	e9f6ElixZrGIqXGYlkQLkmxtwRjfgnDllGf8+d+tIU2rcJFw9xLfT3SVBuWyphoDIqHiVu
	fNqjgNIPtDeQSenrm1+ei04ezkjb8No=
Date: Wed, 24 Sep 2025 19:47:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: abort collapse scan on non-swap
 entries
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
 ioworker0@gmail.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com,
 akpm@linux-foundation.org
References: <20250924100207.28332-1-lance.yang@linux.dev>
 <1282de5a-3dce-443d-91d1-111103140973@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <1282de5a-3dce-443d-91d1-111103140973@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/24 18:10, David Hildenbrand wrote:
> On 24.09.25 12:02, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> The existing check in hpage_collapse_scan_pmd() is specific to uffd-wp
>> markers. Other special markers (e.g., GUARD, POISONED) would not be 
>> caught
>> early, leading to failures deeper in the swap-in logic.
>>
>> hpage_collapse_scan_pmd()
>>   `- collapse_huge_page()
>>       `- __collapse_huge_page_swapin() -> fails!
>>
>> As David suggested[1], this patch skips any such non-swap entries early.
>> If a special marker is found, the scan is aborted immediately with the
>> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>> work.
> 
> Note that I suggested to skip all non-present entries except swap 
> entries, which includes migration entries, hwpoisoned entries etc.

Oops, I completely misunderstood your suggestion :(

It should be to handle all special non-present entries (migration,
hwpoison, markers), not just a specific type of marker ...

How about this version, which handles all non-swap entries as you
suggested?

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7ab2d1a42df3..27f432e7f07c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct 
mm_struct *mm,
         for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
              _pte++, addr += PAGE_SIZE) {
                 pte_t pteval = ptep_get(_pte);
-               if (is_swap_pte(pteval)) {
+               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+                       ++none_or_zero;
+                       if (!userfaultfd_armed(vma) &&
+                           (!cc->is_khugepaged ||
+                            none_or_zero <= khugepaged_max_ptes_none)) {
+                               continue;
+                       } else {
+                               result = SCAN_EXCEED_NONE_PTE;
+                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+                               goto out_unmap;
+                       }
+               } else if (!pte_present(pteval)) {
+                       if (non_swap_entry(pte_to_swp_entry(pteval))) {
+                               result = SCAN_PTE_NON_PRESENT;
+                               goto out_unmap;
+                       }
+
                         ++unmapped;
                         if (!cc->is_khugepaged ||
                             unmapped <= khugepaged_max_ptes_swap) {
@@ -1293,7 +1309,7 @@ static int hpage_collapse_scan_pmd(struct 
mm_struct *mm,
                                  * enabled swap entries.  Please see
                                  * comment below for pte_uffd_wp().
                                  */
-                               if (pte_swp_uffd_wp_any(pteval)) {
+                               if (pte_swp_uffd_wp(pteval)) {
                                         result = SCAN_PTE_UFFD_WP;
                                         goto out_unmap;
                                 }
@@ -1304,18 +1320,6 @@ static int hpage_collapse_scan_pmd(struct 
mm_struct *mm,
                                 goto out_unmap;
                         }
                 }
-               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
-                       ++none_or_zero;
-                       if (!userfaultfd_armed(vma) &&
-                           (!cc->is_khugepaged ||
-                            none_or_zero <= khugepaged_max_ptes_none)) {
-                               continue;
-                       } else {
-                               result = SCAN_EXCEED_NONE_PTE;
-                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-                               goto out_unmap;
-                       }
-               }
                 if (pte_uffd_wp(pteval)) {
                         /*
                          * Don't collapse the page if any of the small
---

Thanks,
Lance

