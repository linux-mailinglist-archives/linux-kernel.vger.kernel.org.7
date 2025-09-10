Return-Path: <linux-kernel+bounces-810016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEA4B514A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FD53AF346
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D593148CE;
	Wed, 10 Sep 2025 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kexfxwR9"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543E266584
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501874; cv=none; b=ZCYYphmTSHfTjTOyrWNjvj+l1RjHY/K4r9AGFEQVJ4MTesIuYSR+syKv30dLHZg8USvJr7wIkAuJJWTr/vnX5p6QHvEUMfPuz5SYHbS2Fd1fmdO+xRUOTpS5r3+6F343BTR1GgOta4IJoFOc7Sls484EE/njwHZvLWvTUnVAIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501874; c=relaxed/simple;
	bh=1XzPMNT6HexsKKEzkNhkhpN2yDAhI75Mku53f0bIKJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSwkuXgPPUmR10WGvVHGGKfRwMou7c59WzzpvDRmYai7/vbTda796eThSHyPGEBUOFqtRuYEN1kAGgZ17lCBccBzjtAdzGg9Svsg9MFWD8oRZX4FzYX3Ea9+QLlshpQQf6H+nKE4oe0EVgZYyI+2hEX3xFMihVol9rjfTO16Bts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kexfxwR9; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757501862; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=dPkQpdVa99UyynuCGcWlFBgQL5dWjTgOTDlsFXVLJp4=;
	b=kexfxwR9F1g5pi5vn9Dd1guvyhFPgxHEcHYk14YoDn4S1XRuha4277IowRH1xugCdKVSY8iDW1PdrpUTBa/geoDELSR5kbIGhlMdm0dxdhFU+VpL/STObIwU/nnrYy0sF0y6AAsIjytDCFh8krDzGTrnk9eR0QOiYSBkLv4JAIg=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WnhraVx_1757501849 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 18:57:42 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,  James Morse
 <james.morse@arm.com>,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Don't broadcast TLBI if mm was only active
 on local CPU
In-Reply-To: <20250829153510.2401161-1-ryan.roberts@arm.com> (Ryan Roberts's
	message of "Fri, 29 Aug 2025 16:35:06 +0100")
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
Date: Wed, 10 Sep 2025 18:57:27 +0800
Message-ID: <87segumv6w.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> Hi All,
>
> This is an RFC for my implementation of an idea from James Morse to avoid
> broadcasting TBLIs to remote CPUs if it can be proven that no remote CPU could
> have ever observed the pgtable entry for the TLB entry that is being
> invalidated. It turns out that x86 does something similar in principle.
>
> The primary feedback I'm looking for is; is this actually correct and safe?
> James and I both believe it to be, but it would be useful to get further
> validation.
>
> Beyond that, the next question is; does it actually improve performance?
> stress-ng's --tlb-shootdown stressor suggests yes; as concurrency increases, we
> do a much better job of sustaining the overall number of "tlb shootdowns per
> second" after the change:
>
> +------------+--------------------------+--------------------------+--------------------------+
> |            |     Baseline (v6.15)     |        tlbi local        |        Improvement       |
> +------------+-------------+------------+-------------+------------+-------------+------------+
> | nr_threads |     ops/sec |    ops/sec |     ops/sec |    ops/sec |     ops/sec |    ops/sec |
> |            | (real time) | (cpu time) | (real time) | (cpu time) | (real time) | (cpu time) |
> +------------+-------------+------------+-------------+------------+-------------+------------+
> |          1 |        9109 |       2573 |        8903 |       3653 |         -2% |        42% |
> |          4 |        8115 |       1299 |        9892 |       1059 |         22% |       -18% |
> |          8 |        5119 |        477 |       11854 |       1265 |        132% |       165% |
> |         16 |        4796 |        286 |       14176 |        821 |        196% |       187% |
> |         32 |        1593 |         38 |       15328 |        474 |        862% |      1147% |
> |         64 |        1486 |         19 |        8096 |        131 |        445% |       589% |
> |        128 |        1315 |         16 |        8257 |        145 |        528% |       806% |
> +------------+-------------+------------+-------------+------------+-------------+------------+
>
> But looking at real-world benchmarks, I haven't yet found anything where it
> makes a huge difference; When compiling the kernel, it reduces kernel time by
> ~2.2%, but overall wall time remains the same. I'd be interested in any
> suggestions for workloads where this might prove valuable.
>
> All mm selftests have been run and no regressions are observed. Applies on
> v6.17-rc3.

I have used redis (a single threaded in-memory database) to test the
patchset on an ARM server.  32 redis-server processes are run on the
NUMA node 1 to enlarge the overhead of TLBI broadcast.  32
memtier-benchmark processes are run on the NUMA node 0 accordingly.
Snapshot is triggered constantly in redis-server, which fork(), saves
memory database to disk, exit(), so that COW in the redis-server will
trigger a large amount of TLBI.  Basically, this tests the performance
of redis-server during snapshot.  The test time is about 300s.  Test
results show that the benchmark score can improve ~4.5% with the
patchset.

Feel free to add my

Tested-by: Huang Ying <ying.huang@linux.alibaba.com>

in the future versions.

---
Best Regards,
Huang, Ying

