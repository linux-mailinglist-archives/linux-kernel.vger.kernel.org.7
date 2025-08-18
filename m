Return-Path: <linux-kernel+bounces-772756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A90B29726
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BE8171DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FFE259CBB;
	Mon, 18 Aug 2025 02:53:33 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332D219A71
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755485612; cv=none; b=q4Yfv9RUf9NSz3xhTrvLSuF34jg359A1uwf5b3r5+4FL9wHvrtwFwNMsnpCjTNVXFk66DGC3wbFkrgry4mJPyoUHQYtOFTV9O6VIQ1gfBPtIJRfn7cX3LbAXnK0z9eUv/moVz8nkYg7mNWPDUB+fVtHmOWL6LwZ25YdkJcvHXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755485612; c=relaxed/simple;
	bh=OTn/pAR55lmeCaLBw6E5GxGwqiGSh55pc8wkQ0uJDQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qzeIblJaZ1IWS/Uu7d59JGqIU61npl1BtRnfuJcwnWnC9wV1x5kLhAxE+bXMb5pCK9fx9S3PRwPxVF2juvsKgSbljeGHSLevQluJVbq46yn+XCctWZX9+Q0kcLm7XTbBgduDfh4EsaDHCcDgZNxbMAcwtVd3UZfNB8bcYKvAQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c4y3j1D6dz3TqXp;
	Mon, 18 Aug 2025 10:54:25 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FE8918001B;
	Mon, 18 Aug 2025 10:53:20 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 10:53:19 +0800
Message-ID: <8db50f47-9295-4c7c-8bbc-dbbbd3fb5f79@huawei.com>
Date: Mon, 18 Aug 2025 10:53:19 +0800
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
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4wbgqGavjQNXtbFVeMw8j8oSCEVSdL4BrBVWEuNHzomPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/8/15 18:03:28, Barry Song <21cnbao@gmail.com> wrote:
> On Fri, Aug 15, 2025 at 1:35 AM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>> dma_map_benchmark is a standalone developer tool rather than an
>> automated selftest. It has no pass/fail criteria, expects manual
>> invocation, and is built as a normal userspace binary. Move it to
>> tools/dma/ and add a minimal, the original selftest/dma/Makefile
>> entry is removed to avoid duplication.
>>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>   tools/Makefile                                  | 13 +++++++------
>>   tools/dma/Makefile                              | 17 +++++++++++++++++
>>   tools/{testing/selftests => }/dma/config        |  0
>>   .../selftests => }/dma/dma_map_benchmark.c      |  0
>>   tools/testing/selftests/dma/Makefile            |  7 -------
>>   5 files changed, 24 insertions(+), 13 deletions(-)
>>   create mode 100644 tools/dma/Makefile
>>   rename tools/{testing/selftests => }/dma/config (100%)
>>   rename tools/{testing/selftests => }/dma/dma_map_benchmark.c (100%)
>>   delete mode 100644 tools/testing/selftests/dma/Makefile
>>
> 
> Please ensure the build passes at least. If you cd into tools/mm or
> tools/spi, everything builds fine.
> 
> tools/spi$ make
> mkdir -p include/linux/spi 2>&1 || true
> ln -sf /home/barrysong/develop/mm/tools/spi/../../include/uapi/linux/spi/spidev.h
> include/linux/spi
> ln -sf /home/barrysong/develop/mm/tools/spi/../../include/uapi/linux/spi/spi.h
> include/linux/spi
> make[1]: Entering directory '/home/barrysong/develop/mm/tools/spi'
>    CC      spidev_test.o
>    LD      spidev_test-in.o
> make[1]: Leaving directory '/home/barrysong/develop/mm/tools/spi'
>    LINK    spidev_test
> make[1]: Entering directory '/home/barrysong/develop/mm/tools/spi'
>    CC      spidev_fdx.o
>    LD      spidev_fdx-in.o
> make[1]: Leaving directory '/home/barrysong/develop/mm/tools/spi'
>    LINK    spidev_fdx
> 
> 
> tools/mm$ make
> make -C ../lib/api
> make[1]: Entering directory '/home/barrysong/develop/mm/tools/lib/api'
>    CC      fd/array.o
>    LD      fd/libapi-in.o
>    CC      fs/fs.o
>    CC      fs/tracing_path.o
>    CC      fs/cgroup.o
>    LD      fs/libapi-in.o
>    CC      cpu.o
>    CC      debug.o
>    CC      str_error_r.o
>    LD      libapi-in.o
>    AR      libapi.a
> make[1]: Leaving directory '/home/barrysong/develop/mm/tools/lib/api'
> gcc -Wall -Wextra -I../lib/ -pthread -o page-types page-types.c
> ../lib/api/libapi.a -pthread
> gcc -Wall -Wextra -I../lib/ -pthread -o slabinfo slabinfo.c
> ../lib/api/libapi.a -pthread
> gcc -Wall -Wextra -I../lib/ -pthread -o page_owner_sort
> page_owner_sort.c ../lib/api/libapi.a -pthread
> gcc -Wall -Wextra -I../lib/ -pthread -o thp_swap_allocator_test
> thp_swap_allocator_test.c ../lib/api/libapi.a -pthread
> 
> 
> If you navigate to tools/dma and run make:
> 
> tools/dma$ make
> cc -I../../include -I../../usr/include dma_map_benchmark.c -o dma_map_benchmark
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
> In file included from /usr/include/stdlib.h:395,
>                   from dma_map_benchmark.c:8:
> /usr/include/x86_64-linux-gnu/sys/types.h:59:17: note: previous
> declaration of ‘dev_t’ with type ‘dev_t’ {aka ‘long unsigned int’}
>     59 | typedef __dev_t dev_t;
>        |                 ^~~~~
> In file included from dma_map_benchmark.c:13:
> ../../include/linux/types.h:25:33: error: conflicting types for
> ‘nlink_t’; have ‘u32’ {aka ‘unsigned int’}
>     25 | typedef u32                     nlink_t;
>        |                                 ^~~~~~~
> In file included from /usr/include/stdlib.h:395,
>                   from dma_map_benchmark.c:8:
> /usr/include/x86_64-linux-gnu/sys/types.h:74:19: note: previous
> declaration of ‘nlink_t’ with type ‘nlink_t’ {aka ‘long unsigned int’}
>     74 | typedef __nlink_t nlink_t;
>        |                   ^~~~~~~
> In file included from dma_map_benchmark.c:13:
> ../../include/linux/types.h:31:33: error: conflicting types for
> ‘timer_t’; have ‘__kernel_timer_t’ {aka ‘int’}
>     31 | typedef __kernel_timer_t        timer_t;
>        |                                 ^~~~~~~
> In file included from /usr/include/x86_64-linux-gnu/sys/types.h:130,
>                   from /usr/include/stdlib.h:395,
>                   from dma_map_benchmark.c:8:
> /usr/include/x86_64-linux-gnu/bits/types/timer_t.h:7:19: note:
> previous declaration of ‘timer_t’ with type ‘timer_t’ {aka ‘void *’}
>      7 | typedef __timer_t timer_t;
>        |                   ^~~~~~~
> In file included from dma_map_benchmark.c:13:
> ../../include/linux/types.h:52:33: error: conflicting types for
> ‘loff_t’; have ‘__kernel_loff_t’ {aka ‘long long int’}
>     52 | typedef __kernel_loff_t         loff_t;
>        |                                 ^~~~~~
> In file included from /usr/include/stdlib.h:395,
>                   from dma_map_benchmark.c:8:
> /usr/include/x86_64-linux-gnu/sys/types.h:42:18: note: previous
> declaration of ‘loff_t’ with type ‘loff_t’ {aka ‘long int’}
>     42 | typedef __loff_t loff_t;
>        |                  ^~~~~~
> In file included from dma_map_benchmark.c:13:
> ../../include/linux/types.h:115:33: error: conflicting types for
> ‘u_int64_t’; have ‘u64’ {aka ‘long long unsigned int’}
>    115 | typedef u64                     u_int64_t;
>        |                                 ^~~~~~~~~
> In file included from /usr/include/stdlib.h:395,
>                   from dma_map_benchmark.c:8:
> /usr/include/x86_64-linux-gnu/sys/types.h:161:20: note: previous
> declaration of ‘u_int64_t’ with type ‘u_int64_t’ {aka ‘long unsigned
> int’}
>    161 | typedef __uint64_t u_int64_t;
>        |                    ^~~~~~~~~
> In file included from dma_map_benchmark.c:13:
> ../../include/linux/types.h:116:33: error: conflicting types for
> ‘int64_t’; have ‘s64’ {aka ‘long long int’}
>    116 | typedef s64                     int64_t;
>        |                                 ^~~~~~~
> In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>                   from /usr/include/stdlib.h:395,
>                   from dma_map_benchmark.c:8:
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous
> declaration of ‘int64_t’ with type ‘int64_t’ {aka ‘long int’}
>     27 | typedef __int64_t int64_t;
>        |                   ^~~~~~~
> In file included from dma_map_benchmark.c:13:
> ../../include/linux/types.h:137:13: error: conflicting types for
> ‘blkcnt_t’; have ‘u64’ {aka ‘long long unsigned int’}
>    137 | typedef u64 blkcnt_t;
>        |             ^~~~~~~~
> In file included from /usr/include/stdlib.h:395,
>                   from dma_map_benchmark.c:8:
> /usr/include/x86_64-linux-gnu/sys/types.h:192:20: note: previous
> declaration of ‘blkcnt_t’ with type ‘blkcnt_t’ {aka ‘long int’}
>    192 | typedef __blkcnt_t blkcnt_t;     /* Type to count number of
> disk blocks.  */
>        |                    ^~~~~~~~
> make: *** [Makefile:11: dma_map_benchmark] Error 1
> 
> Thanks
> Barry
I'm so sorry, there were some mistake，'usr/include' should be placed
before 'include' during include :
CFLAGS += -I../../usr/include -I../../include
After the modification, it'll work.In the next version, I will submit
the two patches separately, and put the modification of the file path
in MAINTAINERS into this patch. Is there anything else that needs to be
modified?

