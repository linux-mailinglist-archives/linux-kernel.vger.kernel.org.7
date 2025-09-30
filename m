Return-Path: <linux-kernel+bounces-837277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C6BABD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B5AA4E20B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402724C068;
	Tue, 30 Sep 2025 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I7LfKX44"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415571DD0EF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217807; cv=none; b=tD1qW6gcOw1r7yJ3tXnidqc70nRAFh6fUb+fyXQyjVr3G/7t9xhVoXGMbub+VCp7Mo4xzG/GwRWzfV9R+kt3Wj32S8LHvMy2KCvQ4JWyX8xQ35QPJWkRtthG8Odp+8wZA7RSpRKM8l6FVYgDVxlDjsgY5LZ8QOFSFt5uUYk6tzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217807; c=relaxed/simple;
	bh=qpUApFk0wJ6OlTpk0tXn0F0JrnEyHoYEzL/w+Uhmr04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHfrrZjb5KlQ9Q2cyi9Hvvs4vOfi6w2P4/yJ9QSu/ws8Ys5zIlcjKvOqzxh0yfMLijugl1yjBzxUkHHMnoQOs0Oku9xGvhjy7LGZYj4G4B8Ek0UTzxYN8HZTPvKmvASRDI69aIfLRpbqRsqJiyeL7NzdJd7uzh9R5IkdS+1Iepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I7LfKX44; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <556e072d-6bec-421a-a78c-fcde61af67f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759217803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMbO9Tlys5llPIB/GKS5R/+Lw3U9d4/u9TV/lNk2GF8=;
	b=I7LfKX44os0xFnVKDz31DNnBjFvIrbnjN2gggYFuKyx1SoGR9d/Xs/QWF4i1I8nA2V5RWl
	W85GgcOtwqUi+YQglSgCu2t2Q0M0gzq8vFreEoFROs6WgbEcu960J7PO4AXZWGr9y45Q5H
	DN77mofyd0GxSn0DtEEpDiyjEUy/2X4=
Date: Tue, 30 Sep 2025 15:36:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/ksm: fix spurious soft-dirty bit on zero-filled
 page merging
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: xu.xin16@zte.com.cn, chengming.zhou@linux.dev, ran.xiaokai@zte.com.cn,
 yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ioworker0@gmail.com, akpm@linux-foundation.org
References: <20250928045207.78546-1-lance.yang@linux.dev>
 <e74ae9da-9dfb-4673-ae9f-c0b27b796cf0@redhat.com>
 <8476e9be-3f80-4d7a-9a38-f910661e61c6@linux.dev>
 <02c8cf41-116d-46ab-9d40-803cc26dbbf8@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <02c8cf41-116d-46ab-9d40-803cc26dbbf8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/30 15:32, David Hildenbrand wrote:
> On 29.09.25 12:08, Lance Yang wrote:
>>
>>
>> On 2025/9/29 16:25, David Hildenbrand wrote:
>>> On 28.09.25 06:52, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> When KSM merges a zero-filled page with the shared zeropage, it uses
>>>> pte_mkdirty() to mark the new PTE for internal accounting. However,
>>>> pte_mkdirty() unconditionally sets both the hardware dirty bit and the
>>>> soft-dirty bit.
>>>>
>>>
>>> Right, that's one think we should clean up at one point.
>>
>> Got it. I’ll take a look when I get a chance ;)
>>
>>>
>>>> This behavior causes false positives in userspace tools like CRIU that
>>>> rely on the soft-dirty mechanism for tracking memory changes.
>>>
>>> IIRC, false positives are not a problem. We get them all of the time
>>> when merging VMAs etc.
>>
>> Right, Indeed.
>>
>>> So I am not sure if this here is really worth fixing. Soft-dirty is not,
>>> and never will be false-positive free.
>>
>> Makes sense to me. It doesn’t seem worth the trouble to fix. Let’s go
>> ahead and drop it.
> 
> Yeah, I would prefer if we can just decouple soft-dirty from dirty 
> handling at some point. I recall I had a use case around 
> PageAnonExclusive at some point.

Cool. I'll give it a try ;)


