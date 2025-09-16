Return-Path: <linux-kernel+bounces-818522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D90B592DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02D17AD020
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE7929BD91;
	Tue, 16 Sep 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KoJv1iYi"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B6299922
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016862; cv=none; b=j0uLLyP9TEIi9PUcZZAtkpdHRKnympLQX9WXhJQ6RhPcoWfudKxF0aR513FjxjNOqtvsLTJ/sIMKEv49ozjRaJ0bEiHMI4vBWvTW+bufwOduL89u+67w8StKEcVgIcVP25KYRTY1pkjQwfR/KvGfqJubn0MmulzsSIEDIXascF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016862; c=relaxed/simple;
	bh=AFx3DSbbgYC4n7auq8ePo43AbuOgQmrlI2oS884xTwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ya2TsAahTs8SHr/I6voT6eWrTDvQ31h40MX0tP8VB3lLOiyQ5g8e9m+aDeEmjlFmPiNrKCtVO3zWGTg7Y701/tOYycgwoRBM0ZuE7MSheNFSFBuEcvyxAqHykD08pZcPshje9VlYl/6e+OQme6r0tPbW45wjYZEGhrqcHmQGbhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KoJv1iYi; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5444e983-9e97-4d08-8177-4e7899f8b4c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758016858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pv8nnJU20/3QFgImqCLzbA2pGGEsV64z3luXt/A/Aw=;
	b=KoJv1iYi1+qrHDV3DNM4u5cnl+TDNO+Kw9mKv6P49QumfUCoE9QpT781nQRR5gwTs00g9L
	n+ZMq2U7N59VMhW70+nGS6egwCius84/twp57CC5rRZKrzjWNBH0OnWa49ZfnEr/1pFJQP
	Hf5mO+YqJxJQsjMuRvJ2NT/36Fd6A8Q=
Date: Tue, 16 Sep 2025 18:00:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier in
 khugepaged_scan_mm_slot()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kiryl Shutsemau <kirill@shutemov.name>
Cc: Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-2-lance.yang@linux.dev>
 <bc86d5f7-5b23-14fb-0365-b47f5a6f13c9@google.com>
 <a0ec4014-384b-4c04-bf0b-777c989eabcb@linux.dev>
 <ol447ofo44vwtyfwg3zrdtcdlkfzzmx4rre6qhyotmwvecnec4@usa3nonuk2sn>
 <2466c068-ccd7-41a1-bef7-6f3fefc6ff55@lucifer.local>
 <3az7vzkhpa2pup3td5pbrek6ti2fij574qimtnbpecums7ixyl@upabkyqmtiaf>
 <8cd717a3-b149-4eb9-88d2-ea4b9b1112f5@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <8cd717a3-b149-4eb9-88d2-ea4b9b1112f5@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/16 17:58, Lorenzo Stoakes wrote:
> On Tue, Sep 16, 2025 at 10:48:22AM +0100, Kiryl Shutsemau wrote:
>> On Tue, Sep 16, 2025 at 10:39:53AM +0100, Lorenzo Stoakes wrote:
>>> On Tue, Sep 16, 2025 at 10:29:11AM +0100, Kiryl Shutsemau wrote:
>>>> On Tue, Sep 16, 2025 at 02:21:26PM +0800, Lance Yang wrote:
>>>>> Users of mlock() expect low and predictable latency. THP collapse is a
>>>>> heavy operation that introduces exactly the kind of unpredictable delays
>>>>> they want to avoid. It has to unmap PTEs, copy data from the small folios
>>>>> to a new THP, and then remap the THP back to the PMD ;)
>>>>
>>>> Generally, we allow minor page faults into mlocked VMAs and avoid major.
>>>> This is minor page fault territory in my view.
>>>
>>> Hm, but we won't be causing minor faults via reclaim right, since they're
>>> not on any LRU?
>>
>> PTEs are still present when we do THP allocation. No reclaim while the
>> access is blocked. We only block the access on copy and PTEs->PMD
>> collapse.
> 
> Right indeed, esp. with compaction being allowed for mlock, I agree with you
> that this patch should be dropped :)

Got it. Will do ;)

Thanks,
Lance


