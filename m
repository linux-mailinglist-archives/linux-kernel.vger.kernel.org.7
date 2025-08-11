Return-Path: <linux-kernel+bounces-763182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3302B21164
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367B96E1AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE419311C3A;
	Mon, 11 Aug 2025 16:03:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A3311C02
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928192; cv=none; b=Yxh0aBPk7p/r0+P5PEtBE2l873qn2+pxkziXGhlRLbeOWk+hoKUxlon1aXHernswlI6fUF2UpHbamPkl6JR2r8PVc8ItYbi4tyMdzMNqMSHE7dTdza9nSgq/40/+UOE77RAlh957g+3zNHafkPXp9kd5sFsUY5XCnEh7PPlf1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928192; c=relaxed/simple;
	bh=iK2McGU9OO4eh35vhn+HE9Ge1tIJXywTspirp7UkxHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBBOFQMTLOsGo8Dm5FepV1FP6vCD2E5Tzy7igmg3HaLUYWAl0IJD3KvcMSZilOby7fCdW5Htx8n/2T+cOuGWaXtYDQp9UaEsJ0MUErA2lrIO+liE/LMlgjkim4rdKa6fndovx3IfLLkxvGfSKyM+FbP84V7j/ZcdVWV7FNyf35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 387D9266C;
	Mon, 11 Aug 2025 09:03:02 -0700 (PDT)
Received: from [10.1.28.163] (e137867.arm.com [10.1.28.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CEB73F738;
	Mon, 11 Aug 2025 09:03:06 -0700 (PDT)
Message-ID: <a3a8c0b8-e953-4c93-ab4d-0d9a4b3e47b1@arm.com>
Date: Mon, 11 Aug 2025 17:03:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v7 0/7] arm64: entry: Convert to generic irq entry
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
 sstabellini@kernel.org, mark.rutland@arm.com, puranjay@kernel.org,
 broonie@kernel.org, mbenes@suse.cz, ryan.roberts@arm.com,
 akpm@linux-foundation.org, chenl311@chinatelecom.cn,
 anshuman.khandual@arm.com, kristina.martsenko@arm.com,
 liaochang1@huawei.com, ardb@kernel.org, leitao@debian.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <6bd09b5b-9830-42b4-ad9e-9ad1e153e564@arm.com>
 <94757d00-5a8e-ac6b-f832-030f33ccf771@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <94757d00-5a8e-ac6b-f832-030f33ccf771@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2025 09:11, Jinjie Ruan wrote:

> On 2025/8/5 23:08, Ada Couprie Diaz wrote:
>> Hi Jinjie,
>>
>> On 29/07/2025 02:54, Jinjie Ruan wrote:
>>
>>> Since commit a70e9f647f50 ("entry: Split generic entry into generic
>>> exception and syscall entry") split the generic entry into generic irq
>>> entry and generic syscall entry, it is time to convert arm64 to use
>>> the generic irq entry. And ARM64 will be completely converted to generic
>>> entry in the upcoming patch series.
>> Note : I had to manually cherry-pick a70e9f647f50 when pulling the series
>> on top of the Linux Arm Kernel for-next/core branch, but there might be
>> something I'm missing here.
> It seems that it is now in mainline v6.16-rc1 and linux-next but not
> Linux Arm Kernel for-next/core branch.
You're right, I misinterpreted the `-next` of the subject, thanks for the
clarification !
>> I'll spend some time testing the series now, specifically given patch 6's
>> changes, but other than that everything I saw made sense and didn't look
>> like it would be of concern to me.
> Thank you for the test and review.

I've spent some time testing the series with a few different configurations,
including PREEMPT_RT, pNMI, various lockup and hang detection options,
UBSAN, shadow call stack, and various CONFIG_DEBUG_XYZ (focused on locks
and IRQs), on both hardware (AMD Seattle) and KVM guests.

I tried to generate a diverse set of interrupts (via debug exceptions,
page faults, perf, kprobes, swapping, OoM) while loading the system with
different workloads, some generating a lot of context switches : hackbench
and signaltest from rt-tests[0], and mc-crusher[1], a memcached stress-test.

I did not have any issues, nor any warning reported by the various
debug features during all my hours of testing, so it looks good !

Tested-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Thank you for the series !
Ada

[0]: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/
[1]: https://github.com/memcached/mc-crusher


