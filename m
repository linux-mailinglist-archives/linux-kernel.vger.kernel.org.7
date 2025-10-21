Return-Path: <linux-kernel+bounces-862490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F6BF573F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F6118A7111
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E289432ABC0;
	Tue, 21 Oct 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tMOoEmu6"
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7C25A659
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038028; cv=none; b=Yf0DUrIAsdNTrd95EYop+Pk3xR0YPZca+ecNV9QPJQBDlzWd7KNZOT3izW9RqevEECy5ZNhVEwBK0m6CBmxHS5LEq0tSONV1l3i35uZKZdUSpWyYz/SNl+KZ6RhUAQ69fRzBhF9hV9cHfVOJxhg+ANvs/d2DF+d6EioU+2B6zQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038028; c=relaxed/simple;
	bh=B4hxnksy8dbQNwHtdiKDOicPmw/Kaxm2ayaBMjjbcwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rvneG3/m0Ko/lMsB7psTLrgRkbMG/WsW/SZelklhBDBrLqhT3imYMIHixB8MFsXEIzJ1cc00zhSapUq3X9sip/Kgz+cMC4a4Q191iDUZSzEJi0IgU5JGeRVcimIWtmML2J5OYEBS/rvMAMOPlE/cVSI0RI6qiBn6JHrfPgYGetQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tMOoEmu6; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VPA429mAGd9KThKfhnTFlN2F3yl0esZo9b/HvhkaZ0E=;
	b=tMOoEmu6GqOGKAKQRFBAOG7pluC2NrpB030wqbeXY6mlreosaJBrlbGnw966z8KLmNBTLyowq
	RBujO4rLbr8taT7cfYWsPcyo61kwI9gm76z8pIKjUfVK0bZZA5/DeLTXF6dCucifZl4fy4Mcal6
	Mwa/dceGJ6tSlKKPNs1Kwfk=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4crRRC3kbtz1cyQ9;
	Tue, 21 Oct 2025 17:13:11 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 702BD140148;
	Tue, 21 Oct 2025 17:13:35 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 17:13:34 +0800
Message-ID: <caeedd6c-4aa8-4787-b1a6-5df7928f1fde@huawei.com>
Date: Tue, 21 Oct 2025 17:13:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tools/dma: move dma_map_benchmark from selftests to
 tools/dma
To: Barry Song <21cnbao@gmail.com>
CC: <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<wangzhou1@hisilicon.com>
References: <20251021011739.1468912-1-xiaqinxin@huawei.com>
 <CAGsJ_4zF4JOPXpkzmR+invqefLstcaB=xaGEfueHEQRSg2oLOg@mail.gmail.com>
 <47cc4984-a424-410d-a1b8-9947c1a42ccb@huawei.com>
 <CAGsJ_4zf31seJif1N93yk_mUaEYh4SzwedASK9VPnPm_JJ6t3Q@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4zf31seJif1N93yk_mUaEYh4SzwedASK9VPnPm_JJ6t3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/10/21 14:23:40, Barry Song <21cnbao@gmail.com> wrote:
> On Tue, Oct 21, 2025 at 6:16 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>>
>>
>> On 2025/10/21 10:59:05, Barry Song <21cnbao@gmail.com> wrote:
>>>> @@ -0,0 +1,2 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>>> +dma_map_benchmark
>>>> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
>>>> new file mode 100644
>>>> index 000000000000..4acbd9e00cfa
>>>> --- /dev/null
>>>> +++ b/tools/dma/Makefile
>>>> @@ -0,0 +1,17 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +bindir ?= /usr/bin
>>>> +
>>>> +CFLAGS += -idirafter../../include/uapi
>>>
>>> I'm a bit confused — it seems you haven’t tried to understand what the issue
>>> was in v1 [1]. You were using -I for kernel header files (under
>>> include/linux but not uapi), which caused those kernel headers to take
>>> precedence over the system headers, leading to build errors. The uapi
>>> headers, however, are specifically designed to be installed into the system by
>>> the toolchain.
>>> So that’s no longer the case — -idirafter is not the correct flag for uapi.
>>>
>> Hello Barry :
>> If I delete -idirafter, like:
>>
>> CFLAGS += -I../../include/uapi
>>
>> It will get warning info:
>>
>> [xiaqinxin@localhost dma]$ make
>> cc -I../../include/uapi dma_map_benchmark.c -o dma_map_benchmark
>> In file included from ../../include/uapi/linux/map_benchmark.h:9,
>>                    from dma_map_benchmark.c:13:
>> ../../include/uapi/linux/types.h:10:2: warning: #warning "Attempt to use
>> kernel headers from user space, see https://kernelnewbies.org/
>> KernelHeaders" [-Wcpp]
>>      10 | #warning "Attempt to use kernel headers from user space, see
>> https://kernelnewbies.org/KernelHeaders"
>>
>> So I keep -idirafter there.
>>
>> There's another way, like:
>>
>> CFLAGS += -I../../usr/include
>> (need make headers_install first)
>>
>> Maybe I haven’t thought it through.
>> If you have a better way, you can give an example.:)
> 
> I see — the uapi headers haven’t been installed yet. This issue will
> automatically resolve once the toolchain is upgraded. Before that, we
> can try the following:
> 
> tools/gpio/Makefile
> 
> #
> # We need the following to be outside of kernel tree
> #
> $(OUTPUT)include/linux/gpio.h: ../../include/uapi/linux/gpio.h
>          mkdir -p $(OUTPUT)include/linux 2>&1 || true
>          ln -sf $(CURDIR)/../../include/uapi/linux/gpio.h $@
> 
> prepare: $(OUTPUT)include/linux/gpio.h
> 
> I guess we could copy and paste GPIO’s Makefile and make a few minor
> modifications?
> 
>>
>>>> index b12f1f9babf8..5474a450863c 100644
>>>> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
>>>> +++ b/tools/dma/dma_map_benchmark.c
>>>> @@ -10,7 +10,6 @@
>>>>    #include <unistd.h>
>>>>    #include <sys/ioctl.h>
>>>>    #include <sys/mman.h>
>>>> -#include <linux/types.h>
>>>
>>> What’s the reason for this? Is it to work around a build error?
>>> If so, no — please keep it.
>>>
>>>>    #include <linux/map_benchmark.h>
>>>
>>
>> Moved it to map_benchmark.h, otherwise some x86_64 build errors
>> would occur.
> 
> Let’s avoid moving types.h — that feels more like a workaround than a
> proper fix.
> 
> Thanks
> Barry
Hello Barry:

Sorry, I don't think it a workaround.When kernel builds with
'CONFIG_UAPI_HEADER_TEST=y'. The build system will checks on the
user space API header files in the usr/include directory.
The header file must be compiled independently.

'__u32' '__u64' in map_benchmark.h depends on the definition of linux/
types.h. If map_benchmark.h does not include types.h,there will lead to
hdrtest error.

That's why I do that.


