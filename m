Return-Path: <linux-kernel+bounces-788262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC128B381F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A709812A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E313019B8;
	Wed, 27 Aug 2025 12:07:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F530148E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296453; cv=none; b=Aw4YD98K2Ou696Q68F+fBjlaI34N7YXICLJVSziLoguyHK0xU4qdfqUOp1NHcV3Q8vnd6QaiLF1h/PEPwc8fcWcAVyfWQZjoxy+vdMl6X/tc8feMtlwOtZnou2+igOmUoQ+Tz54fD9lnklo0o5v9QFjjZRbsXx2W2KFAv0jxG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296453; c=relaxed/simple;
	bh=N551f1zEeh77RdBWR5xcd7hebFhagadFzC2VtCRqMz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K7LxAjvZAek5Qpi55aP56DDWLoQnQ+MeTRRDB9ncHhPOXVe9WDn8qjmvreHD9jxl6stGo3m51+Wlef3ecSEc8n9mHhiVjdB5uIV5CzE/oKtx0p91YOHdeLdf6H1n8Z9xgBsQ1Kt/w7T0wRPryTcX8YR7r0eIubRH9Ycx+zcgKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cBjvZ028gz14MQj;
	Wed, 27 Aug 2025 20:07:22 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id EEE6C1402D0;
	Wed, 27 Aug 2025 20:07:28 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 20:07:28 +0800
Message-ID: <e0584468-ca8e-4a3e-944d-c0bff8569a83@huawei.com>
Date: Wed, 27 Aug 2025 20:07:28 +0800
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
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4yTOPoO98TTh3oQ4t6rag==yqeYP8HQ1wKvYdvg4e1RTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/8/22 09:12:07, Barry Song <21cnbao@gmail.com> wrote:
>>
>> Does usr/include have header files? Did you run make headers_install
>> before make?
>> [xiaqinxin@localhost linux]$ make headers_install
>>     HOSTCC  scripts/basic/fixdep
>>     HOSTCC  scripts/unifdef
>>     WRAP    arch/arm64/include/generated/uapi/asm/socket.h
>>     SYSHDR  arch/arm64/include/generated/uapi/asm/unistd_64.h
>>     HDRINST usr/include/asm-generic/mman.h
>>     HDRINST usr/include/asm-generic/stat.h
>>     HDRINST usr/include/asm-generic/ucontext.h
>>     HDRINST usr/include/asm-generic/int-ll64.h
>>     HDRINST usr/include/asm-generic/unistd.h
>>     HDRINST usr/include/asm-generic/kvm_para.h
>>     HDRINST usr/include/asm-generic/types.h
>>     HDRINST usr/include/asm-generic/ipcbuf.h
>>     HDRINST usr/include/asm-generic/termbits-common.h
>> ...
>> [xiaqinxin@localhost linux]$ cd tools/dma/
>> [xiaqinxin@localhost dma]$ make
>> cc -I../../usr/include -I../../include dma_map_benchmark.c -o
>> dma_map_benchmark
> 
> This is really frustrating. Why do other parts not need this, but
> dma_map_benchmark does? It is also not acceptable to hardcode the
> path to usr/include.
> 
> It is also not good practice to access a kernel header directly from a
> userspace tool - such as -I../../include.
> 
> Shouldn't map_benchmark.h be a proper UAPI header that gets installed
> into the toolchain like the others?
> 
Hello Barry :

This include file is inherited from the original version, and there are 
similar

method in other parts ：

pcmcia/Makefile:CFLAGS := -I../../usr/include
laptop/dslm/Makefile:CFLAGS := -I../../usr/include
accounting/Makefile:CFLAGS := -I../../usr/include

During compilation, the system searches for header files from 
../../usr/include first.

If no header file is found in ../../usr/include, the system attempts to 
get header files

from the system directory of the compilation environment. So maybe in 
some compilation

environments, compiling these modules might have the same problem...

'struct map_benchmark' is defined in map_benchmark.h which is used by 
map_benchmark.c

Do we need to define them separately in the kernel and uapi header files?>>
>> My test is ok.
> 
> 
> Thanks
> Barry


