Return-Path: <linux-kernel+bounces-795505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E11EB3F362
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6CE1A81EFE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA522E03E6;
	Tue,  2 Sep 2025 04:08:43 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92E21C17D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756786123; cv=none; b=jCfbLT+XBFpVX/u17tVhiX4EpY/zsHPgO95+drKXky4cNQBmj30MibCPuDPYv2LGL7OmxH8Tx07Oheoxrpb/QtJEZRFJbtWtgE94OLDwkjtdttr0nTjZbiNAKNM8x9EGNkWNZCU1LkOkvSXMPjqK+6PcyqORRwkUuZW5nEhdgmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756786123; c=relaxed/simple;
	bh=Y21/hLWqWRA9fv7azlwkhSss1Rwt7KeYacBCdD7lF94=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bW54HvzyZBfEl5sSuQ2aSrbzwqSyrsCfUzjgACrVE9m1k1gS/7TfK/uPeSepr1bE8iifbC21YkUEiSbJ75PPHfeMAKX4fZLVTDLvLwjjS03VGK2+P57C/jgwX/2LMFzxY+qcHr/iujk/qFejgGQ+DiXSvngtWYP2wQw19enMAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cGBvD4mZvz2CgPQ;
	Tue,  2 Sep 2025 12:04:08 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 266A5140296;
	Tue,  2 Sep 2025 12:08:37 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Sep 2025 12:08:36 +0800
Message-ID: <751409ee-86e6-4322-a14b-1387a845be79@huawei.com>
Date: Tue, 2 Sep 2025 12:08:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools/dma: move dma_map_benchmark from selftests to
 tools/dma
To: Barry Song <21cnbao@gmail.com>
CC: <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <yangyicong@huawei.com>
References: <20250814133527.2679261-1-xiaqinxin@huawei.com>
 <20250814133527.2679261-2-xiaqinxin@huawei.com>
 <CAGsJ_4wbgqGavjQNXtbFVeMw8j8oSCEVSdL4BrBVWEuNHzomPg@mail.gmail.com>
 <8db50f47-9295-4c7c-8bbc-dbbbd3fb5f79@huawei.com>
 <CAGsJ_4xXt2uEtAohcq+3XF_cKdsZiWsRaRh+ZK4nj0-Zw-yWYw@mail.gmail.com>
 <ca162322-b97e-4ec1-828e-dad7b09f4735@huawei.com>
 <CAGsJ_4yTOPoO98TTh3oQ4t6rag==yqeYP8HQ1wKvYdvg4e1RTQ@mail.gmail.com>
 <e0584468-ca8e-4a3e-944d-c0bff8569a83@huawei.com>
 <CAGsJ_4y+J9uaj=h6JfmKeq5SM5ic9ZKwgDONBP+JbUm6SJtzNg@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4y+J9uaj=h6JfmKeq5SM5ic9ZKwgDONBP+JbUm6SJtzNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/8/29 05:22:21, Barry Song <21cnbao@gmail.com> wrote:
> On Thu, Aug 28, 2025 at 12:07 AM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>>
>>
>> On 2025/8/22 09:12:07, Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> Does usr/include have header files? Did you run make headers_install
>>>> before make?
>>>> [xiaqinxin@localhost linux]$ make headers_install
>>>>      HOSTCC  scripts/basic/fixdep
>>>>      HOSTCC  scripts/unifdef
>>>>      WRAP    arch/arm64/include/generated/uapi/asm/socket.h
>>>>      SYSHDR  arch/arm64/include/generated/uapi/asm/unistd_64.h
>>>>      HDRINST usr/include/asm-generic/mman.h
>>>>      HDRINST usr/include/asm-generic/stat.h
>>>>      HDRINST usr/include/asm-generic/ucontext.h
>>>>      HDRINST usr/include/asm-generic/int-ll64.h
>>>>      HDRINST usr/include/asm-generic/unistd.h
>>>>      HDRINST usr/include/asm-generic/kvm_para.h
>>>>      HDRINST usr/include/asm-generic/types.h
>>>>      HDRINST usr/include/asm-generic/ipcbuf.h
>>>>      HDRINST usr/include/asm-generic/termbits-common.h
>>>> ...
>>>> [xiaqinxin@localhost linux]$ cd tools/dma/
>>>> [xiaqinxin@localhost dma]$ make
>>>> cc -I../../usr/include -I../../include dma_map_benchmark.c -o
>>>> dma_map_benchmark
>>>
>>> This is really frustrating. Why do other parts not need this, but
>>> dma_map_benchmark does? It is also not acceptable to hardcode the
>>> path to usr/include.
>>>
>>> It is also not good practice to access a kernel header directly from a
>>> userspace tool - such as -I../../include.
>>>
>>> Shouldn't map_benchmark.h be a proper UAPI header that gets installed
>>> into the toolchain like the others?
>>>
>> Hello Barry :
>>
>> This include file is inherited from the original version, and there are
>> similar
>>
>> method in other parts ：
>>
>> pcmcia/Makefile:CFLAGS := -I../../usr/include
>> laptop/dslm/Makefile:CFLAGS := -I../../usr/include
>> accounting/Makefile:CFLAGS := -I../../usr/include
>>
>> During compilation, the system searches for header files from
>> ../../usr/include first.
>>
>> If no header file is found in ../../usr/include, the system attempts to
>> get header files
> 
> The difference is that, for them, the build still passes even without
> running `header_install` (and thus without `../../usr/include`).
> 
> tools/laptop/dslm$ make
> gcc -I../../usr/include    dslm.c   -o dslm
> 
> tools/pcmcia$ make
> gcc -I../../usr/include    crc32hash.c   -o crc32hash
> 
> For tools/accounting, the build fails mainly because the UAPI header
> files in the toolchain may be older than those in the latest kernel. so
> we need make headers_install to update.
> 
> But I don’t really understand why we need it. My guess is that the
> "-I../../include" option overrides the system header files, which then
> causes type conflicts.
> 
> cc -I../../include dma_map_benchmark.c -o dma_map_benchmark
> In file included from dma_map_benchmark.c:13:
> ../../include/linux/types.h:20:33: error: conflicting types for
> ‘fd_set’; have ‘__kernel_fd_set’
>     20 | typedef __kernel_fd_set         fd_set;
>        |                                 ^~~~~~
> In file included from /usr/include/x86_64-linux-gnu/sys/types.h:179,
>                   from /usr/include/stdlib.h:395,
>                   from dma_map_benchmark.c:8:
> /usr/include/x86_64-linux-gnu/sys/select.h:70:5: note: previous
> declaration of ‘fd_set’ with type ‘fd_set’
>     70 |   } fd_set;
>        |     ^~~~~~
> In file included from dma_map_benchmark.c:13:
> ../../include/linux/types.h:21:33: error: conflicting types for
> ‘dev_t’; have ‘__kernel_dev_t’ {aka ‘unsigned int’}
>     21 | typedef __kernel_dev_t          dev_t;
>        |                                 ^~~~~
> 
> You should be referring to the system types.h, but the -I../../include
> option makes you pick up the wrong kernel types.h. However, when you
> do have "../../usr/include", you end up with the correct types.h from UAPI.
> 
> I really dislike all this *mess*. You can fix it by doing the following:
> 
> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
> index 841b54896288..cec09abf47cd 100644
> --- a/tools/dma/Makefile
> +++ b/tools/dma/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   bindir ?= /usr/bin
> 
> -CFLAGS += -I../../include -I../../usr/include
> +CFLAGS += -idirafter ../../include
> 
Hello, Barry:

Let me see... 'make headers_install' installs the UAPI header files to 
the usr/include directory in the kernel source tree by default, rather 
than directly to the system's /usr/include directory.

This means that when 'map_benchmark.h' is moved to uapi/include, 
compilation tool chain cannot get the header file from the system path. 
Users need to install the UAPI header file to the system directory or 
set environment variables to reference it from the environment variables.

Could this get a little complex?  Should we keep ' -I ../../usr/include 
' ?>>
>> from the system directory of the compilation environment. So maybe in
>> some compilation
>>
>> environments, compiling these modules might have the same problem...
>>
>> 'struct map_benchmark' is defined in map_benchmark.h which is used by
>> map_benchmark.c
>>
>> Do we need to define them separately in the kernel and uapi header files?>>
> 
> Ideally, yes—then the -I../../include option would no longer be necessary.
> 
> Thanks
> Barry


