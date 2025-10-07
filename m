Return-Path: <linux-kernel+bounces-843754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B8BC0291
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 06:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D1E44E6352
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 04:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EE31917D6;
	Tue,  7 Oct 2025 04:39:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BFB5FDA7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 04:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759811974; cv=none; b=AvE0zsJECLRRK967JPPeCfteilRnWxeegaS+93CR4gN5TWiB09HE8Eul159cFNX+EG6rDRLYY/DgVZFIX2oybnR1yiJ3P+mkqRFV2PpR2gLmwJOz18tGWsMlx2Wasvsee3LZFSlEoB6X9vzGM7uMWWTNYocmD2eKKflpBbud3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759811974; c=relaxed/simple;
	bh=ZEjwKV7KCaCqaG6CV2M/Yiahp9JEm8AkBNAcW4fQQgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnAo8gYFV/w3hRP3vZ7Y3t7VKeABsN+A/Lv+wn9lza3dGNSg7219eFBm7G5lDt2hDF8k/w00JU6x2FE5U4iLsa7YvEhqqeWDPJBeXn+ve8wv4F4eITJf0SglGvomKzFMsSr5l8tSBRRcIwgPSKSyvBj5dS5TBsIa7lmwWmfedJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B1FE14BF;
	Mon,  6 Oct 2025 21:39:24 -0700 (PDT)
Received: from [10.163.65.24] (unknown [10.163.65.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8FF63F59E;
	Mon,  6 Oct 2025 21:39:26 -0700 (PDT)
Message-ID: <0d1bcfdc-031f-4841-b0f3-15ae1d1ffb8e@arm.com>
Date: Tue, 7 Oct 2025 10:09:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 2/3] mm/khugepaged: use VM_WARN_ON_FOLIO instead
 of VM_BUG_ON_FOLIO for non-anon folios
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251006144338.96519-1-lance.yang@linux.dev>
 <20251006144338.96519-3-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251006144338.96519-3-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/10/25 8:13 pm, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> As Zi pointed out, we should avoid crashing the kernel for conditions
> that can be handled gracefully. Encountering a non-anonymous folio in an
> anonymous VMA is a bug, but a warning is sufficient.
>
> This patch changes the VM_BUG_ON_FOLIO(!folio_test_anon(folio)) to a
> VM_WARN_ON_FOLIO() in both __collapse_huge_page_isolate() and
> hpage_collapse_scan_pmd(), and then aborts the scan with SCAN_PAGE_ANON.
>
> Making more of the scanning logic common between hpage_collapse_scan_pmd()
> and __collapse_huge_page_isolate(), as suggested by Dev.
>
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>


