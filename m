Return-Path: <linux-kernel+bounces-828263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A235DB94476
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C532A8166
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE8730E820;
	Tue, 23 Sep 2025 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wfMr0eHe"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3165878F20
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603916; cv=none; b=GCuFqZ3/6zW/YWpeSZl7PSgaOSIwfmQai2XT4S0dT/Q4k4YEkTCVfPuswAfQZUCK/QI/u8+APoPJ4R5rKcKwV006oqAM2pE89s982j/A3gFETqrK1UpXyYS6wlPE3YHApZZFkG5VQrZSY0o8nCPWioMTXEtO4m6dBMyFZZZGpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603916; c=relaxed/simple;
	bh=LeT0w47lOKIi8oHWk5urCybJ9Xx7F89KyeYXL02OqFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMDLamCR9xtyjwCL91UKcpswwyRmOo+lXfkTZFRhQcSGEHFa1ku/b1hEuAuFC28u44oJPysN9jw0wH/o4Huo6/SB1c6EU7DhuKkttYoNTQ5EdPTXSbsGKjApjH3f2AzJdb13T14lVhKiJ2nN4QW3yeCTspf5S2muK7NXgSF+wrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wfMr0eHe; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <188710e0-6683-4bc3-af64-9ce1e8ae4b32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758603911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Onfd9zYeL+OEf7fiK3TSj5PyIeGLL4m+H+3TpOEWGw=;
	b=wfMr0eHeLbrLQ3sqtgI2OVXU+fV60p1sUB/DRs87DoUK/bMRNC4UeVwc39oy5L5HYtrIPB
	UuGFzBIT8H/WQDm1hHKQaQgxnfYPN588eHXLx3TqjzoVP1ycc6nan7+cJ3fYu108XfXhnz
	576/7u+y7X6gLaAvm4NFwihKHjXOiNo=
Date: Mon, 22 Sep 2025 22:04:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
 Chris Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250921054458.4043761-1-rppt@kernel.org>
 <20250921054458.4043761-4-rppt@kernel.org>
 <8f893019-bd87-4f54-8238-acd8fdeed051@linux.dev>
 <20250922160836.8d0dc984ff0986b3809c9ab0@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250922160836.8d0dc984ff0986b3809c9ab0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/22 16:08, Andrew Morton 写道:
> On Mon, 22 Sep 2025 15:31:42 -0700 "yanjun.zhu" <yanjun.zhu@linux.dev> wrote:
>
>>> +int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
>>> +{
>>> +	struct kho_vmalloc_chunk *chunk;
>>> +	struct vm_struct *vm = find_vm_area(ptr);
>>> +	unsigned int order, flags, nr_contig_pages;
>>> +	unsigned int idx = 0;
>>> +	int err;
>> This is a trivial issue. I’m not sure whether RCT (Reverse Christmas
>> Trees) is used in the Linux MM mailing list.
> Not as far as I know.  Some like it.
>
> If I was to have a preference I'd suggest that things be laid out in a
> logical order rather than by column count.  Group like things together,
> avoid use of unintialized storage in initializers(!).

Thanks for your input. I consider this a trivial issue. RCT will help 
make the local variables more organized. Since the Linux MM code does 
not currently use RCT and prefers to group similar logical variables and 
initialize these local variables, I am fine with the current approach.

Yanjun.Zhu

>
-- 
Best Regards,
Yanjun.Zhu


