Return-Path: <linux-kernel+bounces-849175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D3BBCF578
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16AB406E2E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8B22749C4;
	Sat, 11 Oct 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="awgSJglI"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB7135A53
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760187490; cv=none; b=H//EOE4SF8RWY1oOu929hc+0DW8g10patlpMdWaJPxrr+1Q5rjJrPTLbbIyCHJKYM1RgRAy692IexJknh1U0suhvYFEFZJtK569/hoclMiQhN22vqeBcuYBEhps0YmN4BNvDNIXrWxCVNi0R6gRpXt7dwlbeMgSIUM3qcXLKz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760187490; c=relaxed/simple;
	bh=89rRaiWPsApdm1cw1YJX21z9mIPg1mtxgIKLOJ//pho=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZyeP4ByCFKK1Jg05kaaaaiTG3qswnwV6yKhDQJHPjBAjovbRUkh36ejuYafyMoJKubYng6XQMrwuBk6NXb1kyMmWrFnrwFiotRS5s4dedXfQxX+zOraoFDeUeQSRiDLe80aUB1GmiC6bRXfPTa+/Nt4Bz/MyP0IKH8eo5+9GUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=awgSJglI; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3954ac60-e818-42a0-b114-c2a09d34572b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760187481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LI0ebVFo/IUV6FiZoBk7dM1G5eL/sv9Wz3HHgolsQNA=;
	b=awgSJglISvkYKaa2u26ASTX6O+M9NeM5gMIRbMNxNe7W8d0sIawfQtlDrulh+uSezLqxf6
	3z3u8QfOecJBC9sm2cdNp6tubyzDINOzFT9g1KltE5C43Lx2XY+ucbxL8omDwCM9deCX61
	i+jYigqjvm8R1wYe/gx02vm5XwIJJ5c=
Date: Sat, 11 Oct 2025 20:57:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory
 failures
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
To: Miaohe Lin <linmiaohe@huawei.com>, qiuxu.zhuo@intel.com
Cc: Longlong Xia <xialonglong2025@163.com>, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, xu.xin16@zte.com.cn,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>, david@redhat.com
References: <20251009070045.2011920-1-xialonglong2025@163.com>
 <20251009070045.2011920-2-xialonglong2025@163.com>
 <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
 <CABzRoyYK38imLh6zN2DZKPRyQrJkKyvpswqJAsWzEeECtOxaMA@mail.gmail.com>
 <55370eb6-9798-0f46-2301-d5f66528411b@huawei.com>
 <077882e3-f69f-44f3-aa74-b325721beb42@linux.dev>
In-Reply-To: <077882e3-f69f-44f3-aa74-b325721beb42@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Cc Qiuxu

On 2025/10/11 17:38, Lance Yang wrote:
> 
> 
> On 2025/10/11 17:23, Miaohe Lin wrote:
>> On 2025/10/11 15:52, Lance Yang wrote:
>>> @Miaohe
>>>
>>> I'd like to raise a concern about a potential hardware failure :)
>>
>> Thanks for your thought.
>>
>>>
>>> My tests show that if the shared zeropage (or huge zeropage) gets marked
>>> with HWpoison, the kernel continues to install it for new mappings.
>>> Surprisingly, it does not kill the accessing process ...
>>
>> Have you investigated the cause? If user space writes to shared zeropage,
>> it will trigger COW and a new page will be installed. After that, reading
>> the newly allocated page won't trigger memory error. In this scene, it 
>> does
>> not kill the accessing process.
> 
> Not write just read :)
> 
>>
>>>
>>> The concern is, once the page is no longer zero-filled due to the 
>>> hardware
>>> failure, what will happen? Would this lead to silent data corruption for
>>> applications that expect to read zeros?
>>
>> IMHO, once the page is no longer zero-filled due to the hardware 
>> failure, later
>> any read will trigger memory error and memory_failure should handle that.
> 
> I've only tested injecting an error on the shared zeropage using 
> corrupt-pfn:
> 
> echo $PFN > /sys/kernel/debug/hwpoison/corrupt-pfn
> 
> But no memory error was triggered on a subsequent read ...
> 
> Anyway, I'm trying to explore other ways to simulate hardware failure :)
> 
> Thanks,
> Lance
> 


