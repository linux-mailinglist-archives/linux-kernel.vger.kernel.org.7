Return-Path: <linux-kernel+bounces-849939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE96BD1635
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCE284E4461
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E482BEC55;
	Mon, 13 Oct 2025 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FdBkcPvM"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951B5221739
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760330582; cv=none; b=CjBj1En6nQs5nvybZM4Kzk89xcVhH5Z+PBS4vWAdZxfV6Ws8Oo4TMBwonBbSKWm34VE9/4WtcWUIN47ZT/DP9m/MmxxE/0XBv2Whvzb9+L68U1WZgwvWZLcR9/4TC5kiSNvdizya1NzJL+/kPld+Fn8Zagz/V3NEZl2ks8Um7bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760330582; c=relaxed/simple;
	bh=Z3lPYRA0QSarmAGVYuhVIIqEYBts2oW1WwiETHiQdxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBezgo/Ena9N5HQ5UG6CooC8tOKj8hl6BzbCYtck2Rwb9iJpGPPkfkHuLYlAEu9gj4xgn5vJmU0CMhSjzyMYOHWKs8HwLrZTdV78WE2BbeJHTLJgmU8VKSMVDR9koXsmyLxEvehUEXENV+pQNsRE9GsQfXWxr5oWThPSHFiOeHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FdBkcPvM; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f12dfacb-05dd-4b22-90eb-fcc1a8ed552b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760330576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ymR7QfQsF87bu4c+bQc9EVZLMVmDMUhrDS31dRLbS4=;
	b=FdBkcPvMmknwE4VwbFFFviJ83DTLQvoTOVrIKCsCw+mSzfMSPz972QNOYpoY6cZzHFDtvA
	NhK45tz5y1KoFne5MX7p3OWdYXGc0yKGiPUZrRDp/Uh2GaqB1Dr+TSQNkaBPHLh+AhfsTV
	JkyMCfHDF4O277B9ZavDsERWR+FeUIs=
Date: Mon, 13 Oct 2025 12:42:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory
 failures
Content-Language: en-US
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
 <839b72b8-55dc-4f4e-b1da-6f24ecf9446f@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <839b72b8-55dc-4f4e-b1da-6f24ecf9446f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/13 11:39, Miaohe Lin wrote:
> On 2025/10/11 17:38, Lance Yang wrote:
>>
>>
>> On 2025/10/11 17:23, Miaohe Lin wrote:
>>> On 2025/10/11 15:52, Lance Yang wrote:
>>>> @Miaohe
>>>>
>>>> I'd like to raise a concern about a potential hardware failure :)
>>>
>>> Thanks for your thought.
>>>
>>>>
>>>> My tests show that if the shared zeropage (or huge zeropage) gets marked
>>>> with HWpoison, the kernel continues to install it for new mappings.
>>>> Surprisingly, it does not kill the accessing process ...
>>>
>>> Have you investigated the cause? If user space writes to shared zeropage,
>>> it will trigger COW and a new page will be installed. After that, reading
>>> the newly allocated page won't trigger memory error. In this scene, it does
>>> not kill the accessing process.
>>
>> Not write just read :)
>>
>>>
>>>>
>>>> The concern is, once the page is no longer zero-filled due to the hardware
>>>> failure, what will happen? Would this lead to silent data corruption for
>>>> applications that expect to read zeros?
>>>
>>> IMHO, once the page is no longer zero-filled due to the hardware failure, later
>>> any read will trigger memory error and memory_failure should handle that.
>>
>> I've only tested injecting an error on the shared zeropage using corrupt-pfn:
>>
>> echo $PFN > /sys/kernel/debug/hwpoison/corrupt-pfn
>>
>> But no memory error was triggered on a subsequent read ...
> 
> It's because corrupt-pfn only provides a software error injection mechanism.
> If you want to trigger memory error on read, you need use hardware error injection
> mechanism e.g.APEI Error INJection [1].
> 
> [1] https://www.kernel.org/doc/html/v5.8/firmware-guide/acpi/apei/einj.html

Nice! You're right, thanks for pointing that out!

I'm not very familiar with hardware error injection. Fortunately, Qiuxu 
is looking
into that and running some tests on the shared zeropage.

Well, I think he will follow up with his findings ;p

Cheers,
Lance


