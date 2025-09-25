Return-Path: <linux-kernel+bounces-832220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A865B9EAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D631BC7851
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A05A2EF67A;
	Thu, 25 Sep 2025 10:33:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F212EC084
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796398; cv=none; b=WerGvnmI0XjAydF0c5unGpqSjyn0DVez9inwbtD09LjkqSxNS/an3CGCBHB3YYGFHKeEvnB//N4Yyq+Q+L/uCAzgGCHMYQqPoTZ8RhnQ3rBuAX16Q8c84V4g+U+OCTWkE9zAPIPZM1c9TYeKy3lK1tN3oIWE3dB+/6NSHwgXO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796398; c=relaxed/simple;
	bh=1op2Ibn7VqOnUlHonvgbjxUq2q39FT9SvtVfk9QoayM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Poq7XWOSA6TZPei/NS81T0FVyHtQfryuVOs9vOG4JtYwxqFEjK4/kCVTvr9Xd9BNzYEFGMPy9GRTHTCAfsKbvDJHQmm3NDm5g9+iqw3P3lH0/FeKuMj72IfidSzKZp5A+Own6rH29PZjjjBDhSowrRX9YTZIaMNwy34YBtLzq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37F0B1692;
	Thu, 25 Sep 2025 03:33:08 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 701BB3F694;
	Thu, 25 Sep 2025 03:33:13 -0700 (PDT)
Message-ID: <45e08ee0-c85e-469e-a3eb-4ca2e8b7ec0c@arm.com>
Date: Thu, 25 Sep 2025 16:03:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: move rmap of mTHP upon CoW reuse
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lokesh Gidra <lokeshgidra@google.com>
References: <20250925085429.41607-1-dev.jain@arm.com>
 <072b8684-47fe-4a2a-bf69-f6d348f0489b@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <072b8684-47fe-4a2a-bf69-f6d348f0489b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 25/09/25 2:46 pm, David Hildenbrand wrote:
> On 25.09.25 10:54, Dev Jain wrote:
>> At wp-fault time, when we find that a folio is exclusively mapped, we 
>> move
>> folio->mapping to the faulting VMA's anon_vma, so that rmap overhead
>> reduces. This is currently done for small folios (base pages) and
>> PMD-mapped THPs. Do this for mTHP too.
>
> I deliberately didn't add this back then because I was not able to 
> convince myself easily that it is ok in all corner cases. So this 
> needs some thought.

Thanks for your detailed reply.


>
>
> We know that the folio is exclusively mapped to a single MM and that 
> there are no unexpected references from others (GUP pins, whatsoever).
>
> But a large folio might be
>
> (a) mapped into multiple VMAs (e.g., partial mprotect()) in the same MM

I think we have the same problem then for PMD-THPs? I see that 
vma_adjust_trans_huge() only does a PMD split and not folio split.

> [--- snip ---]
>

