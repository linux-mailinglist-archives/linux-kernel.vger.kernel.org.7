Return-Path: <linux-kernel+bounces-818224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C6B58E64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C951BC108A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781032D8377;
	Tue, 16 Sep 2025 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Seh2nPtJ"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160381FBC92
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003702; cv=none; b=LTEet9ulLmK0vDge8kIG5RTkBmV/38FaOYeD87GH0QppJCNTvbctgbOf4pBKldYpNi+Hv/YvZryox+K9M1sjhPAAY8ush+s4e/P87VTVYmoiqSrtGFgjy2PJ/X1UyWASKsvyGx0sejLaIeDxHc02aIm1QessIRMRI7rucWdSi1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003702; c=relaxed/simple;
	bh=DS17qPU/LFdcxgWkUoSD+8lRrTdAsNmB7ZLdTBMU5LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG7X4i9Ef/rjmN7dHWETVESgfRd89UT9YKh9JliGbpfHfh6zooyEHePMcsj57xOS2o/guvw+G/XfMifMOqXbvPug85eznip/h55jLFsUBXjK9bFs4A+UAFE3h7yMrqtKvdDPZXPHf3LShwps10u6q5F99eYOOzfbB/ASC5n8mJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Seh2nPtJ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0ec4014-384b-4c04-bf0b-777c989eabcb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758003697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5O2cdufxu/AELj6UvYc8/DQeqBxhvUUJJsLRMzLjvpQ=;
	b=Seh2nPtJk5tjHCOFVUre7hDuVjTO3aRsfIaSULTWr44UoY7sHbVGCOXPV2M04onztQZg31
	8aRG70vfaPmxLj0M/oC/NuWjSEuGRzfOWWhjw7MfJuINp3TXMG1rq2dQk/1mhr0cjR+T/S
	jRmorKRDUbX9/tmYmPyaAl6DETdO1nc=
Date: Tue, 16 Sep 2025 14:21:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier in
 khugepaged_scan_mm_slot()
Content-Language: en-US
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-2-lance.yang@linux.dev>
 <bc86d5f7-5b23-14fb-0365-b47f5a6f13c9@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <bc86d5f7-5b23-14fb-0365-b47f5a6f13c9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Hugh,

Thanks for taking a look and for raising this important point!

On 2025/9/16 13:32, Hugh Dickins wrote:
> On Sun, 14 Sep 2025, Lance Yang wrote:
> 
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Let's skip unsuitable VMAs early in the khugepaged scan; specifically,
>> mlocked VMAs should not be touched.
> 
> Why?  That's a change in behaviour, isn't it?
> 
> I'm aware that hugepage collapse on an mlocked VMA can insert a fault
> latency, not universally welcome; but I've not seen discussion, let
> alone agreement, that current behaviour should be changed.
> Somewhere in yet-to-be-read mail?  Please give us a link.
> 
> Hugh

You're right, this is indeed a change in behaviour. But it's specifically
for khugepaged.

Users of mlock() expect low and predictable latency. THP collapse is a
heavy operation that introduces exactly the kind of unpredictable delays
they want to avoid. It has to unmap PTEs, copy data from the small folios
to a new THP, and then remap the THP back to the PMD ;)

IMO, that change is acceptable because THP is generally transparent to
users, and khugepaged does not guarantee when THP collapse or split will
happen.

Well, we don't have a discussion on that, just something I noticed.

Thanks,
Lance



