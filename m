Return-Path: <linux-kernel+bounces-883390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D08C2D46C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBA118863D1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8D31960A;
	Mon,  3 Nov 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqZuypYw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805E318155
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188807; cv=none; b=jsaB4DJLcGG1OFFd10FcQMvTiih66dDgUFEyGqD+KvkDIgTBI0dVbWt7vaoBTD/mM7yyPz+xBHFLoS+WfbIggdQqmNuCGEklu15atq+U7T4YjP+eNv3zPFuFdi/nhLoSMpsuk3dZneRUhYkpJEdIDwOAYqeB91d1KOKUtTinfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188807; c=relaxed/simple;
	bh=ZkLFIz0vvjDeD2wJOSQTr9Q/o5xR6ot5EVcHo9EzqcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOo4LvG8AA7RF1zfL/vF5DPMfk03GVYAMYrBO+QYia86WELYnESMQQOacAkmcrEMGhJ3eWaoBuyp8bsvNBH9CZRYOJ2RmJPUr/edRO73hfLhu83vKPYMoK0Hw6KFZXT5bQGPYXZO+THtGvvF80aIralmmeJl0IrAVcTCisRTcLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqZuypYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54741C4CEE7;
	Mon,  3 Nov 2025 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188807;
	bh=ZkLFIz0vvjDeD2wJOSQTr9Q/o5xR6ot5EVcHo9EzqcM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SqZuypYw81+njFxxCaYsGfEQYd+kxBwe0YRsRX1hV1YGEqo96Hxh0inlgQEfMWrJn
	 6tlXxeQY1lRmbVuXqstLs5+OTEyM8aZZuuVQuvjau7xitn8ECPIez/gTYYXyUZS8u5
	 DPrfzr0DXatM368eGnaT8jMeWvQtaWucQ0DEy/NOeaWu8+mIez5c3j2BA2nmeqd6R8
	 9XqUzerFozM0V/f7uS02Xk4gapLylS2u/Y8kgHCV1cfDAjWq2DCRcLa54SsQHZuahi
	 mRFXsM2qTglPv8wsD8hMi8b4s6SlHNR5ovQ/F/9PxU3YZLgxUMEqACdk/9RerJs/mC
	 /MmH3dF3KIP0Q==
Message-ID: <e323f1f3-f543-4e81-af6b-243fcf9ba750@kernel.org>
Date: Mon, 3 Nov 2025 17:53:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] ARM: mm: support memory-failure
To: Xie Yuanbin <xieyuanbin1@huawei.com>, linux@armlinux.org.uk,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
 rmk+kernel@armlinux.org.uk, ardb@kernel.org, nathan@kernel.org,
 ebiggers@kernel.org, arnd@arndb.de, rostedt@goodmis.org, kees@kernel.org,
 dave@vasilevsky.ca, peterz@infradead.org
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, liaohua4@huawei.com,
 lilinjie8@huawei.com
References: <9c0cd24c-559b-4550-9fc8-5dc4bcc20bf7@app.fastmail.com>
 <20250923041005.9831-1-xieyuanbin1@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20250923041005.9831-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 06:10, Xie Yuanbin wrote:
> Arnd Bergmann wrote:
>>>> It would be helpful to be more specific about what you
>>>> want to do with this.
>>>>
>>>> Are you working on a driver that would actually make use of
>>>> the exported interface?
>>>
>>> Thanks for your reply.
>>>
>>> Yes, In fact, we have developed a hardware component to detect DDR bit
>>> transitions (software does not sense the detection behavior). Once a bit
>>> transition is detected, an interrupt is reported to the CPU.
>>>
>>> On the software side, we have developed a driver module ko to register
>>> the interrupt callback to perform soft page offline to the corresponding
>>> physical pages.
>>>
>>> In fact, we will export `soft_offline_page` for ko to use (we can ensure
>>> that it is not called in the interrupt context), but I have looked at the
>>> code and found that `memory_failure_queue` and `memory_failure` can also
>>> be used, which are already exported.
>>
>> Ok
>>
>>>> I see only a very small number of
>>>> drivers that call memory_failure(), and none of them are
>>>> usable on Arm.
>>>
>>> I think that not all drivers are in the open source kernel code.
>>> As far as I know, there should be similar third-party drivers in other
>>> architectures that use memory-failure functions, like x86 or arm64.
>>> I am not a specialist in drivers, so if I have made any mistakes,
>>> please correct me.
>>
>> I'm not familiar with the memory-failure support, but this sounds
>> like something that is usually done with a drivers/edac/ driver.
>> There are many SoC specific drivers, including for 32-bit Arm
>> SoCs.
>>
>> Have you considered adding an EDAC driver first? I don't know
>> how the other platforms that have EDAC drivers handle failures,
>> but I would assume that either that subsystem already contains
>> functionality for taking pages offline,
> 
> I'm very sorry, I tried my best to do this,
> but it seems impossible to achieve.
> I am a kernel developer rathder than a driver developer. I have tried to
> communicate with driver developers, but open source is very difficult due
> to the involvement of proprietary hardware and algorithms.
> 
>> or this is something
>> that should be done in a way that works for all of them without
>> requiring an extra driver.
> 
> Yes, I think that the memory-failure feature should not be associated with
> specific architectures or drivers.
> 
> I have read the memory-failure's doc and code,
> and found the following features, which are user useable,
> are not associated with specific drivers:
> 
> 1. `/sys/devices/system/memory/soft_offline_page`:
> see https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-memory-page-offline
> 
> This interface only exists when CONFIG_MEMORY_HOTPLUG is enabled, but
> ARM cannot enable it.
> However, I have read the code and believe that it should not require a
> lot of effort to decouple these two, allowing the interface to exist
> even if mem-hotplug is disabled.

It's all about the /sys/devices/system/memory/ directory, which 
traditionally only made sense for memory hotplug. Well, still does to 
most degree.

Not sure whether some user space (chmem?) senses for 
/sys/devices/system/memory/ to detect memory hotplug capabilities.

But given soft_offline_page is a pure testing mechanism, I wouldn't be 
too concerned about that for now.

> 
> 2. The syscall madvise with `MADV_SOFT_OFFLINE/MADV_HWPOISON` flags:
> 
> According to the documentation, this interface is currently only used for
> testing. However, if the user program can map the specified physical
> address, it can actually be used for memory-failure.

It's mostly a testing-only interface. It could be used for other things, 
but really detecting MCE and handling it properly is kernel responsibility.

> 
> 3. The CONFIG_HWPOISON_INJECT which depends on CONFIG_MEMORY_FAILURE:
> see https://docs.kernel.org/mm/hwpoison.html
> 
> It seems to allow input of physical addresses and trigger memory-failure,
> but according to the doc, it seems to be used only for testing.

Right, all these interfaces are testing only.

> 
> 
> Additionally, I noticed that in the memory-failure doc
> https://docs.kernel.org/mm/hwpoison.html, it mentions that
> "The main target right now is KVM guests, but it works for all kinds of
> applications." This seems to confirm my speculation that the
> memory-failure feature should not be associated with specific
> architectures or drivers.

Can you go into more details which exact functionality in 
memory-failure.c you would be interested in using?

Only soft-offlining or also the other (possibly architecture-specific) 
handling?

-- 
Cheers

David

