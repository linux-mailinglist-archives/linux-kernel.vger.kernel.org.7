Return-Path: <linux-kernel+bounces-862186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1834BBF4A10
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52713B6243
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384A23D29A;
	Tue, 21 Oct 2025 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZPa/Tjqi"
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEC1CEAB2
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761023768; cv=none; b=RD/8KYF8kOlIexAsAB3f+3G9DmGP6wIE0WgVCr1Ce7IQQmQ/7vqLesANkowUsjhHX+ZNT8ksTxU/T3nnGFLFmJkPFhxp48PK6Wn+GEVhx9D4Cz5PgCtcNmLmDxhSEp3tWAB60k55P5/+K8XrAWOlj8QVco9Iaq4bBqpibo12jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761023768; c=relaxed/simple;
	bh=Er1pGz4jbhbE9R2r5QDV4+2MGHB1I6MuLCV6ZnHKtxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WRyXXDDZcHjf059Q3bc0EEOkxtwOl+mQRMVaZ/azkRQBAWRADhJU2gVZP1fD7KDyq4b1rkjgen15tDdxu+UFX0mHiUx4QBGyKx1jFu10a1+O638En1M13zPgLIbIzjvD9o+rHNVomLpaKqMNchYLkQARQbIngv1vUsPhJD/qd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZPa/Tjqi; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=guTIZEFggjaq5nryVlm57Vv0mxdFlJr2OoRy1KbrSJk=;
	b=ZPa/TjqiZGLSkV/w48JyZ+F9Hah2IFYBJY2Nen0oCC/3W/bglBCPVxPddy2A1sxPARFhDoeJv
	lXFCKuVYM+94DmIUVSACsW55J4fROvSvJUSq+TscQPCkcLMlVl5j5sPcJwxwfdBk6QPSvnjGlBv
	YXRHFqh49XKZYykVC0SaLj8=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4crL924BRbz1prLM;
	Tue, 21 Oct 2025 13:15:34 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id CE064180B66;
	Tue, 21 Oct 2025 13:15:58 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 13:15:58 +0800
Message-ID: <47cc4984-a424-410d-a1b8-9947c1a42ccb@huawei.com>
Date: Tue, 21 Oct 2025 13:15:57 +0800
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
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4zF4JOPXpkzmR+invqefLstcaB=xaGEfueHEQRSg2oLOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/10/21 10:59:05, Barry Song <21cnbao@gmail.com> wrote:
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +dma_map_benchmark
>> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
>> new file mode 100644
>> index 000000000000..4acbd9e00cfa
>> --- /dev/null
>> +++ b/tools/dma/Makefile
>> @@ -0,0 +1,17 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +bindir ?= /usr/bin
>> +
>> +CFLAGS += -idirafter../../include/uapi
> 
> I'm a bit confused — it seems you haven’t tried to understand what the issue
> was in v1 [1]. You were using -I for kernel header files (under
> include/linux but not uapi), which caused those kernel headers to take
> precedence over the system headers, leading to build errors. The uapi
> headers, however, are specifically designed to be installed into the system by
> the toolchain.
> So that’s no longer the case — -idirafter is not the correct flag for uapi.
> 
Hello Barry :
If I delete -idirafter, like:

CFLAGS += -I../../include/uapi

It will get warning info:

[xiaqinxin@localhost dma]$ make
cc -I../../include/uapi dma_map_benchmark.c -o dma_map_benchmark
In file included from ../../include/uapi/linux/map_benchmark.h:9,
                  from dma_map_benchmark.c:13:
../../include/uapi/linux/types.h:10:2: warning: #warning "Attempt to use 
kernel headers from user space, see https://kernelnewbies.org/
KernelHeaders" [-Wcpp]
    10 | #warning "Attempt to use kernel headers from user space, see 
https://kernelnewbies.org/KernelHeaders"

So I keep -idirafter there.

There's another way, like:

CFLAGS += -I../../usr/include
(need make headers_install first)

Maybe I haven’t thought it through.
If you have a better way, you can give an example.:)

>> index b12f1f9babf8..5474a450863c 100644
>> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
>> +++ b/tools/dma/dma_map_benchmark.c
>> @@ -10,7 +10,6 @@
>>   #include <unistd.h>
>>   #include <sys/ioctl.h>
>>   #include <sys/mman.h>
>> -#include <linux/types.h>
> 
> What’s the reason for this? Is it to work around a build error?
> If so, no — please keep it.
> 
>>   #include <linux/map_benchmark.h>
> 
> Thanks
> Barry

Moved it to map_benchmark.h, otherwise some x86_64 build errors
would occur.

