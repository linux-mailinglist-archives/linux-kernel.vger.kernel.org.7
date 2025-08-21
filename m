Return-Path: <linux-kernel+bounces-778890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34557B2EC78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B3E5C3166
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E287621ABBB;
	Thu, 21 Aug 2025 03:55:10 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425131A7264
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748510; cv=none; b=kp3LCX0oUR766JowKVNJm39diZezHw579L86lWQia9Ues995pmocMj/o+9wuoxv8lZHgXIJVjGQ9NYYOWchCZRAI+Aq22IZiNmiNPGzIHKLVzU3QIOHPDrVRKMfJhHkkSWyMMJotjAHm9Kid5YkQ7xPOaglOMUFEcs56LIrOYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748510; c=relaxed/simple;
	bh=Apnre9DzDyuEE1Owdns8eHF+Pe1h7bNuW72ddlkM6SU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SfanG94YIel/csB+hroiPwmzUoXFAEcpgHcBqxKiCKxTm/PHeZXAQt53uQDqGc8QAisX/Yurzl6Xw0rJUV/gCp0+GUBjbdW1V8GmXju1CjeYAFfK6QtTL4tMd/pzbcVNL1une84wDEjqNOS9FdEITdO64bXLoqU5z6oXgU52ols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c6qF92pVZztTDt;
	Thu, 21 Aug 2025 11:54:05 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DE3D180080;
	Thu, 21 Aug 2025 11:55:04 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 11:55:03 +0800
Message-ID: <ca162322-b97e-4ec1-828e-dad7b09f4735@huawei.com>
Date: Thu, 21 Aug 2025 11:55:03 +0800
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
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4xXt2uEtAohcq+3XF_cKdsZiWsRaRh+ZK4nj0-Zw-yWYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/8/21 11:39:14, Barry Song <21cnbao@gmail.com> wrote:
>> I'm so sorry, there were some mistake，'usr/include' should be placed
>> before 'include' during include :
>> CFLAGS += -I../../usr/include -I../../include
>> After the modification, it'll work.In the next version, I will submit
>> the two patches separately, and put the modification of the file path
>> in MAINTAINERS into this patch. Is there anything else that needs to be
>> modified?
> 
> i am still getting same build errors with the below:
> 
> tools/dma$ git diff .
> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
> index 841b54896288..c37393a3e937 100644
> --- a/tools/dma/Makefile
> +++ b/tools/dma/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   bindir ?= /usr/bin
> 
> -CFLAGS += -I../../include -I../../usr/include
> +CFLAGS += -I../../usr/include  -I../../include
> 
>   TARGET = dma_map_benchmark
> 
> 
> make:
> 
> cc -I../../usr/include  -I../../include dma_map_benchmark.c -o dma_map_benchmark
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
> 
> Thanks
> Barry

Does usr/include have header files? Did you run make headers_install 
before make?
[xiaqinxin@localhost linux]$ make headers_install
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/unifdef
   WRAP    arch/arm64/include/generated/uapi/asm/socket.h
   SYSHDR  arch/arm64/include/generated/uapi/asm/unistd_64.h
   HDRINST usr/include/asm-generic/mman.h
   HDRINST usr/include/asm-generic/stat.h
   HDRINST usr/include/asm-generic/ucontext.h
   HDRINST usr/include/asm-generic/int-ll64.h
   HDRINST usr/include/asm-generic/unistd.h
   HDRINST usr/include/asm-generic/kvm_para.h
   HDRINST usr/include/asm-generic/types.h
   HDRINST usr/include/asm-generic/ipcbuf.h
   HDRINST usr/include/asm-generic/termbits-common.h
...
[xiaqinxin@localhost linux]$ cd tools/dma/
[xiaqinxin@localhost dma]$ make
cc -I../../usr/include -I../../include dma_map_benchmark.c -o 
dma_map_benchmark

My test is ok.




