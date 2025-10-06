Return-Path: <linux-kernel+bounces-842570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E59BBD0D8
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 06:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C4704E44A3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 04:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6907424338F;
	Mon,  6 Oct 2025 04:48:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BED22ACEF
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759726099; cv=none; b=DRzFwwYS0GMeblCoy7ItA0eUAzU/TjtPRJryVpdrqAUjcHRNsXEB7aOXN8loi4gY4gdsq8+FQBmR2mFYO0pmyrmRb781+0TSYE54mvjuIBsRaNyN5ZQdqlBZ0X4BEhuKVJRqcRban+L2iiq70je4anY8yLCH9TPuJW4zDgWdUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759726099; c=relaxed/simple;
	bh=WR5z416GdyHVMtZv8PL/xhfJeDMKBMQyDzp3mXaNyaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlMC9Pd+1vviL13gPaP44inkCd/H07QJSRXTVMHw55JgB96sUmFA4uiQh8tDGJ9kcYHkeVbBZdC74vEEBz7fD5ntJzLdjODQaLLHXsPKFWHL/Fz9NXbgShZga0FBhtCEmj5JNmw01MyH/60kejNfpkDyPsHnETbLnGWSRsHwRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30E551516;
	Sun,  5 Oct 2025 21:48:07 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81953F59E;
	Sun,  5 Oct 2025 21:48:12 -0700 (PDT)
Message-ID: <3c0169a4-78b3-4deb-b991-14733b5f0aff@arm.com>
Date: Mon, 6 Oct 2025 10:18:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: readahead: make thp readahead conditional to
 mmap_miss logic
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
References: <20251006015409.342697-1-roman.gushchin@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251006015409.342697-1-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/10/25 7:24 am, Roman Gushchin wrote:
> Commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> introduced a special handling for VM_HUGEPAGE mappings: even if the
> readahead is disabled, 1 or 2 HPAGE_PMD_ORDER pages are
> allocated.
>
> This change causes a significant regression for containers with a
> tight memory.max limit, if VM_HUGEPAGE is widely used. Prior to this
> commit, mmap_miss logic would eventually lead to the readahead
> disablement, effectively reducing the memory pressure in the
> cgroup. With this change the kernel is trying to allocate 1-2 huge
> pages for each fault, no matter if these pages are used or not
> before being evicted, increasing the memory pressure multi-fold.
>
> To fix the regression, let's make the new VM_HUGEPAGE conditional
> to the mmap_miss check, but keep independent from the ra->ra_pages.
> This way the main intention of commit 4687fdbb805a ("mm/filemap:
> Support VM_HUGEPAGE for file mappings") stays intact, but the
> regression is resolved.
>
> The logic behind this changes is simple: even if a user explicitly
> requests using huge pages to back the file mapping (using VM_HUGEPAGE
> flag), under a very strong memory pressure it's better to fall back
> to ordinary pages.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: linux-mm@kvack.org
>
> --
>
> v2: fixed VM_SEQ_READ handling (by Dev Jain)
>

As you said in a previous mail, we definitely need some other way of measuring
memory pressure here. Since your workload is doing madvise(MADV_HUGEPAGE) (which
means it expects to take advantage of the hugepage by accessing it frequently) and still
getting lots of cache misses, I guess it must be due to swapping out due to
tight memory.max. Anyways, the change looks correct to me.

Reviewed-by: Dev Jain <dev.jain@arm.com>


