Return-Path: <linux-kernel+bounces-879960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C8AC247C6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57492461905
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DFE311C24;
	Fri, 31 Oct 2025 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c0ufGMqi"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577D2EAB8D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906956; cv=none; b=PwccvnpODHJU7ngqulmD3pfBncDZ0HAdxzWW7ONMKlLcF4nVFYCAwrolCtCLaJcWRZduarD+pTyaDrstjdNOAKYH1b0bxPXnW0uzvhyfZtqe8VuEXwUrR3veGYy/TK4JoB3KWBXW4UaLDO+wEO5VeNbOkFfsdU4PMqeMi9d3Xi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906956; c=relaxed/simple;
	bh=hYrVj6ok2nxBIVt4E+DNQAUBQ3OOa5k9T6vp5QjX7Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHfejwY6AanyD/hqLZzfVXmqrbQBrBFY9/QDagtatRCcmeu9a37r6Dw5nyXa9PXpl8MdvKfnPt4E5vBd+dUk0mjbUiNCxs4a36Ak2a3K0k9Qbm4wNfDIvGNYRu76SRLBziESagIXYt5Ysw0oT3MxCQpYmRLtZDmnMYV2S18+Sds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c0ufGMqi; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4d2006d5-01c1-4bea-9071-7827b1fb2c85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761906942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hA88PfMvT7s/ypjD/Vu1krMCrweTiktQkOm7yWYdPeo=;
	b=c0ufGMqiRA30r8ZbzAxJk1JAjkGhKvS/qeIRy1TZUJGI65clbzcFx2MprvLinIt5BYTd9f
	QjWF+cBAlAOor3mB5p1sRWmdG3/CORLLMbRRPWHVmyUC4UqxkcIuyLS9hOoNtxRdBg2dJG
	felui++sKubhXXBzfiguWtQNc5NtW2U=
Date: Fri, 31 Oct 2025 18:35:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/secretmem: fix use-after-free race in fault
 handler
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, big-sleep-vuln-reports@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, stable@vger.kernel.org,
 Mike Rapoport <rppt@kernel.org>
References: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
 <20251031091818.66843-1-lance.yang@linux.dev> <aQSIdCpf-2pJLwAF@kernel.org>
 <38f0ff98-3dcd-4dc2-87f1-3ea34bb9935a@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <38f0ff98-3dcd-4dc2-87f1-3ea34bb9935a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/31 18:19, David Hildenbrand wrote:
> On 31.10.25 10:59, Mike Rapoport wrote:
>> On Fri, Oct 31, 2025 at 05:18:18PM +0800, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> The error path in secretmem_fault() frees a folio before restoring its
>>> direct map status, which is a race leading to a panic.
>>
>> Let's use the issue description from the report:
>>
>> When a page fault occurs in a secret memory file created with
>> `memfd_secret(2)`, the kernel will allocate a new folio for it, mark
>> the underlying page as not-present in the direct map, and add it to
>> the file mapping.
>>
>> If two tasks cause a fault in the same page concurrently, both could
>> end up allocating a folio and removing the page from the direct map,
>> but only one would succeed in adding the folio to the file
>> mapping. The task that failed undoes the effects of its attempt by (a)
>> freeing the folio again and (b) putting the page back into the direct
>> map. However, by doing these two operations in this order, the page
>> becomes available to the allocator again before it is placed back in
>> the direct mapping.
>>
>> If another task attempts to allocate the page between (a) and (b), and
>> the kernel tries to access it via the direct map, it would result in a
>> supervisor not-present page fault.
>>> Fix the ordering to restore the map before the folio is freed.
>>
>> ... restore the direct map
>>
>> With these changes
>>
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Fully agreed
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Cheers!

