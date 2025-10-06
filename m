Return-Path: <linux-kernel+bounces-843285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5B7BBED67
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACAA134A8D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442E82571BC;
	Mon,  6 Oct 2025 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZxqVh7It"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D44D24679A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772658; cv=none; b=NCSki8SXyHmtn7UAHPgE45tTYB4JGJk3MROtsRCX8wf+F3b7zV2K5lo/zYrtMI4qDgeD5QRxfSZp6uk6Bhd9sE+UCaM46Bpkk7//NbssHCyZ15WzjiII6LPDNWkGTjgUAhgvKmY6Bn8CjPqOvYqf3H7C0m3o/YpOFRuDO5/3Qyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772658; c=relaxed/simple;
	bh=o5l5mXnTufqPwWpkCxK8mb3zhCUr0ejTPKcGXYktr5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ORuemLnCVvJYQmkCUa4Ge1w2AiJRL3nCEU9iIgqCUHsBihFc1IQJ23t7dvmSrdkFBrAu2ORLBwXViVi8STb2nxy5VXBhoIG3qkzKcU87CWYIc9rKb4aB01KFuUY2gySqBZps/M96HJp4Fm+eG2x+WtNXJcAAYcRUsp/MEFZI9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZxqVh7It; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759772652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QcosD5rlzA4TE7AntBZPfeAW0/FnSxIJ3VMLbX62WUE=;
	b=ZxqVh7ItL0Tel/7B30RzqqAsLAe9Tay1fWGS1l5VTeYoHM2MLnWp5pZaEFzgsOB+TSCK1s
	Ny80HiVfF9LMmEhag8nyFNiq/lRp0oFmHHyA4xV+enn3M8SmbIoUmrZ1ni8B3iabRROqIu
	1TW2ECx5W1zO0B8tZwGI3KQxozwH1cw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Dev Jain <dev.jain@arm.com>,  linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: readahead: make thp readahead conditional to
 mmap_miss logic
In-Reply-To: <e2zblaknfnzjtlo3df4aozoxuir6zgnycdjj4ywbu7rsnpw6hr@ocemkpucjd2d>
	(Jan Kara's message of "Mon, 6 Oct 2025 14:31:06 +0200")
References: <20251006015409.342697-1-roman.gushchin@linux.dev>
	<e2zblaknfnzjtlo3df4aozoxuir6zgnycdjj4ywbu7rsnpw6hr@ocemkpucjd2d>
Date: Mon, 06 Oct 2025 10:44:07 -0700
Message-ID: <87qzvg6i3c.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jan Kara <jack@suse.cz> writes:

> On Sun 05-10-25 18:54:09, Roman Gushchin wrote:
>> Commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
>> introduced a special handling for VM_HUGEPAGE mappings: even if the
>> readahead is disabled, 1 or 2 HPAGE_PMD_ORDER pages are
>> allocated.
>> 
>> This change causes a significant regression for containers with a
>> tight memory.max limit, if VM_HUGEPAGE is widely used. Prior to this
>> commit, mmap_miss logic would eventually lead to the readahead
>> disablement, effectively reducing the memory pressure in the
>> cgroup. With this change the kernel is trying to allocate 1-2 huge
>> pages for each fault, no matter if these pages are used or not
>> before being evicted, increasing the memory pressure multi-fold.
>> 
>> To fix the regression, let's make the new VM_HUGEPAGE conditional
>> to the mmap_miss check, but keep independent from the ra->ra_pages.
>> This way the main intention of commit 4687fdbb805a ("mm/filemap:
>> Support VM_HUGEPAGE for file mappings") stays intact, but the
>> regression is resolved.
>> 
>> The logic behind this changes is simple: even if a user explicitly
>> requests using huge pages to back the file mapping (using VM_HUGEPAGE
>> flag), under a very strong memory pressure it's better to fall back
>> to ordinary pages.
>> 
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: linux-mm@kvack.org
>> 
>> --
>> 
>> v2: fixed VM_SEQ_READ handling (by Dev Jain)
>
> OK, but now we'll do mmap_miss detection and bail-out even for VM_SEQ_READ
> | VM_HUGEPAGE vmas. And without VM_HUGEPAGE we won't do it which is really
> odd. So I think you want to make the whole mmap_miss logic conditional on
> !VM_SEQ_READ...

Yeah, agree, good point.

Thanks!

