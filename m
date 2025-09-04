Return-Path: <linux-kernel+bounces-800591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E53BEB4399D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1666188BF7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79992FC001;
	Thu,  4 Sep 2025 11:09:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53269EACE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984184; cv=none; b=bpiAenYb4Shy977hM6UdeL7Kf+M4ZW88gNM10d+xS2ykiSjBEkHchSdnvt3Ol1I8Jr6ypijlutrAprWeas0dSgEFkz+YiptGU/uay0Sn903Fbvr0EDMlA46o3X5e66MXj6CDzgaub2JQHpuyeRiGhku40NzfhkojBSeLtkkpqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984184; c=relaxed/simple;
	bh=Xqh2aD2Vvp/DqdBeYlK7aykeGXTdxQvCN+3UqSAXeNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNLVt3oCv8KEyYJWdw+C9f09aZBEKOpRw30kRcIh6ABO+nVDOIS0VMgx54KnXILTIQYFs4h7iTxRfr2RsqQh2x6xu60hGgst+ZNezGuQKKpI1O8kGiMA33EvE4/+14fZgwdhvLscAlaUudH/xcpawxyjwYJVHrfzcWOfYLyvhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A24E1756;
	Thu,  4 Sep 2025 04:09:34 -0700 (PDT)
Received: from [10.1.37.179] (XHFQ2J9959.cambridge.arm.com [10.1.37.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE9E83F6A8;
	Thu,  4 Sep 2025 04:09:40 -0700 (PDT)
Message-ID: <74603a7e-74f7-4d8f-9c2e-7caa42f2399f@arm.com>
Date: Thu, 4 Sep 2025 12:09:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] arm64: mm: Optimize split_kernel_leaf_mapping()
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yang Shi <yang@os.amperecomputing.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dev Jain <dev.jain@arm.com>, scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-5-ryan.roberts@arm.com> <aLiU9xnZl-7LBqkX@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aLiU9xnZl-7LBqkX@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2025 20:20, Catalin Marinas wrote:
> On Fri, Aug 29, 2025 at 12:52:45PM +0100, Ryan Roberts wrote:
>> The common case for split_kernel_leaf_mapping() is for a single page.
>> Let's optimize this by only calling split_kernel_leaf_mapping_locked()
>> once.
>>
>> Since the start and end address are PAGE_SIZE apart, they must be
>> contained within the same contpte block. Further, if start is at the
>> beginning of the block or end is at the end of the block, then the other
>> address must be in the _middle_ of the block. So if we split on this
>> middle-of-the-contpte-block address, it is guaranteed that the
>> containing contpte block is split to ptes and both start and end are
>> therefore mapped by pte.
>>
>> This avoids the second call to split_kernel_leaf_mapping_locked()
>> meaning we only have to walk the pgtable once.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> And I agree with Yang, you can just fold this into the previous patch.

Yep, will do. Thanks for the review.

