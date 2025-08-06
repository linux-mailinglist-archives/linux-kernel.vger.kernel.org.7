Return-Path: <linux-kernel+bounces-757356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CDEB1C130
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378F418A609F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700C42185B1;
	Wed,  6 Aug 2025 07:20:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E983B211A11
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464816; cv=none; b=bQ5Nphp7ryMjgoNi51kn0bM5Nixv0OZ1mdAAkslIDdtieeBCxs4O3mX9hvexdBDJDvRXOCmFG1GoezYkEJ/KMkXpygiCTL6Yu94vG1/iuuY1PvaB7a3EF47ht3wQmvrULFy6Arc/kaaxp3GTkjxKVannwn3/n7un4VqShj4W87E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464816; c=relaxed/simple;
	bh=ITc5j2EdBGbnc8FR5zHr/8buf88ufpYEjsvJUHui298=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oc4ErN0q/egu0oYUCYZQqkNLwnFv++dliA1fhrzrWN3sAVjjzWwaeHp4mXbrdndSQm16zDH0kZUfnlutfB7Kgrbo8OpZ7wSSZLUh7Mct2YiQMvwxV9nAqZVCM05IfD2nd3yO3AGxUtg+Sqqgu1RzVZCp+ReTcU8ProB1+04Ydjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD7141F37;
	Wed,  6 Aug 2025 00:20:04 -0700 (PDT)
Received: from [10.57.88.107] (unknown [10.57.88.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DD7F3F5A1;
	Wed,  6 Aug 2025 00:20:11 -0700 (PDT)
Message-ID: <b2d3e684-e3dc-41b5-9708-ca5926c55ebf@arm.com>
Date: Wed, 6 Aug 2025 08:20:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: mm: support large block mapping when
 rodata=full
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
 <20250724221216.1998696-4-yang@os.amperecomputing.com>
 <0e86671e-18bb-4f3b-9294-c583299ad49e@arm.com>
 <e65ed11d-68ef-4b9c-80ad-7e880743b3d3@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e65ed11d-68ef-4b9c-80ad-7e880743b3d3@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/08/2025 19:53, Yang Shi wrote:

[...]

>>> +    arch_enter_lazy_mmu_mode();
>>> +    ret = split_pgd(pgd_offset_k(start), start, end);
>> My instinct still remains that it would be better not to iterate over the range
>> here, but instead call a "split(start); split(end);" since we just want to split
>> the start and end. So the code would be simpler and probably more performant if
>> we get rid of all the iteration.
> 
> It should be more performant for splitting large range, especially the range
> includes leaf mappings at different levels. But I had some optimization to skip
> leaf mappings in this version, so it should be close to your implementation from
> performance perspective. And it just walks the page table once instead of twice.
> It should be more efficient for small split, for example, 4K.

I guess this is the crux of our disagreement. I think the "walks the table once
for 4K" is a micro optimization, which I doubt we would see on any benchmark
results. In the absence of data, I'd prefer the simpler, smaller, easier to
understand version.

Both implementations are on list now; perhaps the maintainers can steer us.

Thanks,
Ryan

