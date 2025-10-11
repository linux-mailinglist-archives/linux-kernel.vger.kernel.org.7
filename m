Return-Path: <linux-kernel+bounces-849098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF7BCF322
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB1019A16CF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D4924BBE4;
	Sat, 11 Oct 2025 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WnZ7HDOR"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527052441B8
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175523; cv=none; b=UV33PElvvihmy/pcr+Z6W+r5Rx2UbuVNlIODJDEBQHY8Vy+t8zvAAkRO0ZPIdFVkAqV906zlLIUsMP86BdTigfGJcyEgdeMNi2aoyViiTq7NusskNTOgr/+7iFq11Cy8Zs8EGWXC2IJA6vV9WkoKyKALkUQcyCrcpuRAWaLWHvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175523; c=relaxed/simple;
	bh=LG9wB+ondeCChCLh10s+uBs1cacK5MZiiGqo+RBQwzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVVMvv39HPbh3W7aaqzsV/ui6hLXB46krU7AT8I6qk0MzNzMOvcn24hwp6mhFeadfBLUA9WVa0jS9Fur04sXXZJbIwObOoeIJYVQvPSukYBTsn16IlYgT5fflLzApvbdZrKCNSgAKv1j+I5//j6n7ZRNJBN4MDgH0kmxf//f9N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WnZ7HDOR; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <077882e3-f69f-44f3-aa74-b325721beb42@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760175515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU9ccrGCxLrD5q9ZcZ92Iy4RlaTWTf5iyTMrPa72q+g=;
	b=WnZ7HDORXRw0FkzY9RY5Hx8Lv3cOFBm336RWJnRpjIUiK2INkFvHgzAft+IaFLiQRSzeaU
	U4xxGNBNVa4j1hj8Dgg4zdJHYbKlR9ZPlhV57nYVbBNlvS0GkSghei13pvQ6cwiLxcNSGu
	vQos+1NrIOp8uHZjz9O/j9CWOsSnxG0=
Date: Sat, 11 Oct 2025 17:38:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory
 failures
Content-Language: en-US
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Longlong Xia <xialonglong2025@163.com>, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, xu.xin16@zte.com.cn,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>, david@redhat.com
References: <20251009070045.2011920-1-xialonglong2025@163.com>
 <20251009070045.2011920-2-xialonglong2025@163.com>
 <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
 <CABzRoyYK38imLh6zN2DZKPRyQrJkKyvpswqJAsWzEeECtOxaMA@mail.gmail.com>
 <55370eb6-9798-0f46-2301-d5f66528411b@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <55370eb6-9798-0f46-2301-d5f66528411b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/11 17:23, Miaohe Lin wrote:
> On 2025/10/11 15:52, Lance Yang wrote:
>> @Miaohe
>>
>> I'd like to raise a concern about a potential hardware failure :)
> 
> Thanks for your thought.
> 
>>
>> My tests show that if the shared zeropage (or huge zeropage) gets marked
>> with HWpoison, the kernel continues to install it for new mappings.
>> Surprisingly, it does not kill the accessing process ...
> 
> Have you investigated the cause? If user space writes to shared zeropage,
> it will trigger COW and a new page will be installed. After that, reading
> the newly allocated page won't trigger memory error. In this scene, it does
> not kill the accessing process.

Not write just read :)

> 
>>
>> The concern is, once the page is no longer zero-filled due to the hardware
>> failure, what will happen? Would this lead to silent data corruption for
>> applications that expect to read zeros?
> 
> IMHO, once the page is no longer zero-filled due to the hardware failure, later
> any read will trigger memory error and memory_failure should handle that.

I've only tested injecting an error on the shared zeropage using 
corrupt-pfn:

echo $PFN > /sys/kernel/debug/hwpoison/corrupt-pfn

But no memory error was triggered on a subsequent read ...

Anyway, I'm trying to explore other ways to simulate hardware failure :)

Thanks,
Lance


