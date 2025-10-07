Return-Path: <linux-kernel+bounces-843753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02796BC028B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 06:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9BAE4E279A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 04:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C617A318;
	Tue,  7 Oct 2025 04:34:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365AC5FDA7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759811642; cv=none; b=MSVzEFA8MUh8Vq7FDyKeKiQ2Tab9pPe4Wo5MjgGp6QUjGWtNBraHVEymmrtubR58AG3cM8SR/z2NOP7BeK+e3zMN++OauFBXw92fxqTIyD289svuA4QQzmpGO8+0p29d8z93WMMenfpGK21yR7a5B9gpdz995bzyCI2Bp73H8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759811642; c=relaxed/simple;
	bh=j8a+WlOKy5w+rhX+YaYErlrkNmdaBK3A51lmsxhWUcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQTtrMiSkpIHm1nss5Lw645R9S9yzHdPWQmUYqgu8KQ+vQACjncNbO5uUQwX48BXgh9v1nSjNQEVv4lAAfM1iizPnBYeU+thwOPZgtY6CB3hnAAVFLRnkQDrqBDbc4kuHkfUxEPdd/BMvgSx/it6zkUDWj4DkX+1ZlSSrkzSJZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3801214BF;
	Mon,  6 Oct 2025 21:33:45 -0700 (PDT)
Received: from [10.163.65.24] (unknown [10.163.65.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF6B93F59E;
	Mon,  6 Oct 2025 21:33:50 -0700 (PDT)
Message-ID: <5053378f-8cf7-4cb6-bbab-f0c2f14db677@arm.com>
Date: Tue, 7 Oct 2025 10:03:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: readahead: make thp readahead conditional to
 mmap_miss logic
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org
References: <20251006175106.377411-1-roman.gushchin@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251006175106.377411-1-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/10/25 11:21 pm, Roman Gushchin wrote:
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
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: linux-mm@kvack.org
>
> --
>
> v3: fixed VM_SEQ_READ handling for the THP case (by Jan Kara)
> v2: fixed VM_SEQ_READ handling (by Dev Jain)
>
>   

LGTM

Reviewed-by: Dev Jain <dev.jain@arm.com>


