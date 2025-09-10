Return-Path: <linux-kernel+bounces-810197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397EEB51725
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81BE27B8D13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE5E31B13C;
	Wed, 10 Sep 2025 12:42:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5031196C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508133; cv=none; b=IYK8kWW7FyJL8CBSWPnyX/rM05QRAmrK/LZfrnrHuiJkM/sKlxttOKCC047BiCNSHFj+wi2SMIeWdHW6qqSfsfm8mRb+6C0pJLa7u2DlzP175qPV3LnnWXKp3Oeg0bE8pcXQhHPWRtQQCaf2w/4Z/Fd16o4U59DMzje5dMyLFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508133; c=relaxed/simple;
	bh=XOdgTh/pATs6Eu2+69y/VeWBsYiCPjDIHDA6a/qj4cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxtnG3wcWK4NXR2WLAFKriQ6/9rmPrJdwKC7o2R1iibVLyCLmt/HXd2GCYRFUnX41OEW8/5nmMQTXB8Kxu6TgaWMHvNA95kKN0imb+1EogkT9EhLcgSmYpU3rGTI7+jRvP5HKIo/ObJvJcYTeeTt2QCF+56JGP8Fk8qcZxqok8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3E116F8;
	Wed, 10 Sep 2025 05:42:02 -0700 (PDT)
Received: from [10.57.90.208] (unknown [10.57.90.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A547E3F694;
	Wed, 10 Sep 2025 05:42:09 -0700 (PDT)
Message-ID: <f660749e-d515-4208-9610-ffc4155b4a0d@arm.com>
Date: Wed, 10 Sep 2025 13:42:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] Don't broadcast TLBI if mm was only active on
 local CPU
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
 <87segumv6w.fsf@DESKTOP-5N7EMDA>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87segumv6w.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/09/2025 11:57, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> Hi All,
>>
>> This is an RFC for my implementation of an idea from James Morse to avoid
>> broadcasting TBLIs to remote CPUs if it can be proven that no remote CPU could
>> have ever observed the pgtable entry for the TLB entry that is being
>> invalidated. It turns out that x86 does something similar in principle.
>>
>> The primary feedback I'm looking for is; is this actually correct and safe?
>> James and I both believe it to be, but it would be useful to get further
>> validation.
>>
>> Beyond that, the next question is; does it actually improve performance?
>> stress-ng's --tlb-shootdown stressor suggests yes; as concurrency increases, we
>> do a much better job of sustaining the overall number of "tlb shootdowns per
>> second" after the change:
>>
>> +------------+--------------------------+--------------------------+--------------------------+
>> |            |     Baseline (v6.15)     |        tlbi local        |        Improvement       |
>> +------------+-------------+------------+-------------+------------+-------------+------------+
>> | nr_threads |     ops/sec |    ops/sec |     ops/sec |    ops/sec |     ops/sec |    ops/sec |
>> |            | (real time) | (cpu time) | (real time) | (cpu time) | (real time) | (cpu time) |
>> +------------+-------------+------------+-------------+------------+-------------+------------+
>> |          1 |        9109 |       2573 |        8903 |       3653 |         -2% |        42% |
>> |          4 |        8115 |       1299 |        9892 |       1059 |         22% |       -18% |
>> |          8 |        5119 |        477 |       11854 |       1265 |        132% |       165% |
>> |         16 |        4796 |        286 |       14176 |        821 |        196% |       187% |
>> |         32 |        1593 |         38 |       15328 |        474 |        862% |      1147% |
>> |         64 |        1486 |         19 |        8096 |        131 |        445% |       589% |
>> |        128 |        1315 |         16 |        8257 |        145 |        528% |       806% |
>> +------------+-------------+------------+-------------+------------+-------------+------------+
>>
>> But looking at real-world benchmarks, I haven't yet found anything where it
>> makes a huge difference; When compiling the kernel, it reduces kernel time by
>> ~2.2%, but overall wall time remains the same. I'd be interested in any
>> suggestions for workloads where this might prove valuable.
>>
>> All mm selftests have been run and no regressions are observed. Applies on
>> v6.17-rc3.
> 
> I have used redis (a single threaded in-memory database) to test the
> patchset on an ARM server.  32 redis-server processes are run on the
> NUMA node 1 to enlarge the overhead of TLBI broadcast.  32
> memtier-benchmark processes are run on the NUMA node 0 accordingly.
> Snapshot is triggered constantly in redis-server, which fork(), saves
> memory database to disk, exit(), so that COW in the redis-server will
> trigger a large amount of TLBI.  Basically, this tests the performance
> of redis-server during snapshot.  The test time is about 300s.  Test
> results show that the benchmark score can improve ~4.5% with the
> patchset.
> 
> Feel free to add my
> 
> Tested-by: Huang Ying <ying.huang@linux.alibaba.com>
> 
> in the future versions.

Thanks for this - very useful!

> 
> ---
> Best Regards,
> Huang, Ying


