Return-Path: <linux-kernel+bounces-822608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE786B844D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461E4623C52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A7F302170;
	Thu, 18 Sep 2025 11:12:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466DCA55
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193925; cv=none; b=OhDB1wlNIoc3APvQC0qb/aWs+rRwCdMNxpxCyFEejzjBOYpdOx5O02D87R06YMtioCA5M9S9NKWqPDZtyBAzQZ5MMzt/rAB/WRpAWXJaDV88LPCv2yqi7qmhFznDkJSD1kNjx1igt9sYgmd4qR7C/nSe9RuTEJi6NPwCltYsosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193925; c=relaxed/simple;
	bh=FLEsT8JAr3pGNNcKahnr/nd1z8+z2fgK7EWbnj5Coyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTgtoAtzzL9cM/DWfjxOhv38nhoy6nEKxq4cdztT/BOv1OwI9ewhNqDhAo6C5EYuMJfOqv/yyeSDNiQt/Z0bApBGAlSc5SaWli1GcWldfbbvP/ai9Hs6Zq3bLiNddEPcq+pfsgo5dfVn1VdxJgdkXSzCVB/1FiPYkFm2Yh/ttCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77B711762;
	Thu, 18 Sep 2025 04:11:55 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AA663F66E;
	Thu, 18 Sep 2025 04:11:58 -0700 (PDT)
Message-ID: <8f49bd75-5314-43e4-aecc-e0ef3616f7fd@arm.com>
Date: Thu, 18 Sep 2025 16:41:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard
 PTEs
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, kirill@shutemov.name, hughd@google.com,
 mpenttil@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-3-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250918050431.36855-3-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 18/09/25 10:34 am, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
> lightweight guard regions.
>
> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail when
> encountering such a range.
>
> MADV_COLLAPSE fails deep inside the collapse logic when trying to swap-in
> the special marker in __collapse_huge_page_swapin().
>
> hpage_collapse_scan_pmd()
>   `- collapse_huge_page()
>       `- __collapse_huge_page_swapin() -> fails!
>
> khugepaged's behavior is slightly different due to its max_ptes_swap limit
> (default 64). It won't fail as deep, but it will still needlessly scan up
> to 64 swap entries before bailing out.
>
> IMHO, we can and should detect this much earlier.
>
> This patch adds a check directly inside the PTE scan loop. If a guard
> marker is found, the scan is aborted immediately with SCAN_PTE_NON_PRESENT,
> avoiding wasted work.
>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


