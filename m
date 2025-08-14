Return-Path: <linux-kernel+bounces-768468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F56B26147
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE409E3E05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9A72EAB9D;
	Thu, 14 Aug 2025 09:37:54 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76091239E7E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164273; cv=none; b=Bn/rWDzFrCUjOeIYDr6eHb/3iLYrW+Ylnz/DBgHVXzbV3xJJu1SBrbojCMT0NBkAvpQ/oEfUX4rY6571MW9fFHEVTdcR9N2XvCT0egiVZZ9Yv26rQUxa9wsaPCyZG7pEys+gCPo4d7bZekDlzknxKYNFW0FqzYcHqXtxZqtO0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164273; c=relaxed/simple;
	bh=fwx8siD17JqEXvrGQeimrhNPQ6pdiWziduef/SP96IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R8G2CuJ5696l4Jb6vVGOnWSQYubyXhuOl+e5E2Dun8vA0Rhxs1tL6CLIWMmODnu+soqi3rF2KoKVFFgDErtihD5wWtPiKIgFExWdJoNhFKxOot94tyYqKA12WjcgzrcT1fVtrUwlEekBdg5EQhYoAF2z/VklwkbdGIxyEmQTFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c2g7t6B27z2TT7M;
	Thu, 14 Aug 2025 17:35:06 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 51B151A0188;
	Thu, 14 Aug 2025 17:37:48 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 17:37:46 +0800
Message-ID: <2530ba09-73eb-c0fd-5d77-4e6c5a0810a6@huawei.com>
Date: Thu, 14 Aug 2025 17:37:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v7 0/7] arm64: entry: Convert to generic irq entry
Content-Language: en-US
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <mark.rutland@arm.com>, <puranjay@kernel.org>,
	<broonie@kernel.org>, <mbenes@suse.cz>, <ryan.roberts@arm.com>,
	<akpm@linux-foundation.org>, <chenl311@chinatelecom.cn>,
	<anshuman.khandual@arm.com>, <kristina.martsenko@arm.com>,
	<liaochang1@huawei.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <6bd09b5b-9830-42b4-ad9e-9ad1e153e564@arm.com>
 <94757d00-5a8e-ac6b-f832-030f33ccf771@huawei.com>
 <a3a8c0b8-e953-4c93-ab4d-0d9a4b3e47b1@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <a3a8c0b8-e953-4c93-ab4d-0d9a4b3e47b1@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/12 0:03, Ada Couprie Diaz wrote:
> On 06/08/2025 09:11, Jinjie Ruan wrote:
> 
>> On 2025/8/5 23:08, Ada Couprie Diaz wrote:
>>> Hi Jinjie,
>>>
>>> On 29/07/2025 02:54, Jinjie Ruan wrote:
>>>
>>>> Since commit a70e9f647f50 ("entry: Split generic entry into generic
>>>> exception and syscall entry") split the generic entry into generic irq
>>>> entry and generic syscall entry, it is time to convert arm64 to use
>>>> the generic irq entry. And ARM64 will be completely converted to
>>>> generic
>>>> entry in the upcoming patch series.
>>> Note : I had to manually cherry-pick a70e9f647f50 when pulling the
>>> series
>>> on top of the Linux Arm Kernel for-next/core branch, but there might be
>>> something I'm missing here.
>> It seems that it is now in mainline v6.16-rc1 and linux-next but not
>> Linux Arm Kernel for-next/core branch.
> You're right, I misinterpreted the `-next` of the subject, thanks for the
> clarification !
>>> I'll spend some time testing the series now, specifically given patch
>>> 6's
>>> changes, but other than that everything I saw made sense and didn't look
>>> like it would be of concern to me.
>> Thank you for the test and review.
> 
> I've spent some time testing the series with a few different
> configurations,
> including PREEMPT_RT, pNMI, various lockup and hang detection options,
> UBSAN, shadow call stack, and various CONFIG_DEBUG_XYZ (focused on locks
> and IRQs), on both hardware (AMD Seattle) and KVM guests.
> 
> I tried to generate a diverse set of interrupts (via debug exceptions,
> page faults, perf, kprobes, swapping, OoM) while loading the system with
> different workloads, some generating a lot of context switches : hackbench
> and signaltest from rt-tests[0], and mc-crusher[1], a memcached
> stress-test.
> 
> I did not have any issues, nor any warning reported by the various
> debug features during all my hours of testing, so it looks good !
> 
> Tested-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Thank you for your comprehensive testing and code review.

> 
> Thank you for the series !
> Ada
> 
> [0]: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/
> [1]: https://github.com/memcached/mc-crusher
> 
> 

