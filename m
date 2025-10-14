Return-Path: <linux-kernel+bounces-852456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFECBD908D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 344C74FB8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC330DEA4;
	Tue, 14 Oct 2025 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="pfN/SgFQ"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760D30C625
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441416; cv=none; b=b4QQ2tiM/8fTNKMziq0rmNl8OlZDEaBBy8OvEzEdXpU9gW8dTN/pXP6tGZvpyreCBZLYYbfmd3bmxe6s8oihp54N3HZ3ba8rcdh+wzS03G59aoVWFR0/2hXohqfQHa3Pk067SjJMovmT4TTrk71vo/u1+Ck7z8bZwzzMvxJPEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441416; c=relaxed/simple;
	bh=QPLQ8S5Z+CsJsGt24MgXa/YtJJ4/cZaedUMHMTuRgPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oam6CICVikZYHN6Ym0DuJy7NScHpRknO0VckufjWYYqxsqE8dnpTr9k2VuuCIAZLjmCbya7ngHdCqrLJQqsYiT8Qg86ohwM9GEoQ2gxHX/CVRGa1XSCtmruGY6pGr3W9rQhfNf+/nlvyxcQVwBoyk2P9uWtTlaPHMgntCgQMqMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=pfN/SgFQ; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1760441411;
	bh=XuiZZX2bdYokcEIW6becPyXT1zpVn2AQfemG2M9o3UI=;
	h=From:Subject:Date:Message-ID;
	b=pfN/SgFQSrEjCB6axw8obWTRAsCKMinfHGaIcVc7B7CSzOpmnm+VIb9yIXf7gHKam
	 l8HSsLvG30ALPxzu+0VX5gR+rOkFwqlwftoH1iepj5yMqNzGWxnBh8FUTkBeYU4Nmi
	 +HbNsZZ1QZ6IM7gtNeP5ZsUUHO3Sp4U1hY7Gxskk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68EE343400007D1B; Tue, 14 Oct 2025 19:29:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8044336685184
X-SMAIL-UIID: FAFC45108EE14A7F85C90DE2B7CC568D-20251014-192958-1
From: Hillf Danton <hdanton@sina.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 0/3] mm/page_alloc: Batch callers of free_pcppages_bulk
Date: Tue, 14 Oct 2025 19:29:45 +0800
Message-ID: <20251014112946.8581-1-hdanton@sina.com>
In-Reply-To: <20251013190812.787205-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Oct 2025 12:08:08 -0700 Joshua Hahn wrote:
> Motivation & Approach
> =====================
> 
> While testing workloads with high sustained memory pressure on large machines
> in the Meta fleet (1Tb memory, 316 CPUs), we saw an unexpectedly high number
> of softlockups. Further investigation showed that the zone lock in
> free_pcppages_bulk was being held for a long time, and was called to free
> 2k+ pages over 100 times just during boot.
> 
> This causes starvation in other processes for the zone lock, which can lead
> to the system stalling as multiple threads cannot make progress without the
> locks. We can see these issues manifesting as warnings:
> 
> [ 4512.591979] rcu: INFO: rcu_sched self-detected stall on CPU
> [ 4512.604370] rcu:     20-....: (9312 ticks this GP) idle=a654/1/0x4000000000000000 softirq=309340/309344 fqs=5426
> [ 4512.626401] rcu:              hardirqs   softirqs   csw/system
> [ 4512.638793] rcu:      number:        0        145            0
> [ 4512.651177] rcu:     cputime:       30      10410          174   ==> 10558(ms)
> [ 4512.666657] rcu:     (t=21077 jiffies g=783665 q=1242213 ncpus=316)
> 
> While these warnings are benign, they do point to the underlying issue of

No fix is needed if it is benign.

> lock contention. To prevent starvation in both locks, batch the freeing of
> pages using pcp->batch.
> 
> Because free_pcppages_bulk is called with the pcp lock and acquires the zone
> lock, relinquishing and reacquiring the locks are only effective when both of
> them are broken together (unless the system was built with queued spinlocks).
> Thus, instead of modifying free_pcppages_bulk to break both locks, batch the
> freeing from its callers instead.
> 
> A similar fix has been implemented in the Meta fleet, and we have seen
> significantly less softlockups.
> 
Fine, softlockup is not cured.

> Testing
> =======
> The following are a few synthetic benchmarks, made on three machines. The
> first is a large machine with 754GiB memory and 316 processors.
> The second is a relatively smaller machine with 251GiB memory and 176
> processors. The third and final is the smallest of the three, which has 62GiB
> memory and 36 processors.
> 
> On all machines, I kick off a kernel build with -j$(nproc).
> Negative delta is better (faster compilation).
> 
> Large machine (754GiB memory, 316 processors)
> make -j$(nproc)
> +------------+---------------+-----------+
> | Metric (s) | Variation (%) | Delta(%)  |
> +------------+---------------+-----------+
> | real       |        0.8070 |  - 1.4865 |
> | user       |        0.2823 |  + 0.4081 |
> | sys        |        5.0267 |  -11.8737 |
> +------------+---------------+-----------+
> 
> Medium machine (251GiB memory, 176 processors)
> make -j$(nproc)
> +------------+---------------+----------+
> | Metric (s) | Variation (%) | Delta(%) |
> +------------+---------------+----------+
> | real       |        0.2806 |  +0.0351 |
> | user       |        0.0994 |  +0.3170 |
> | sys        |        0.6229 |  -0.6277 |
> +------------+---------------+----------+
> 
> Small machine (62GiB memory, 36 processors)
> make -j$(nproc)
> +------------+---------------+----------+
> | Metric (s) | Variation (%) | Delta(%) |
> +------------+---------------+----------+
> | real       |        0.1503 |  -2.6585 |
> | user       |        0.0431 |  -2.2984 |
> | sys        |        0.1870 |  -3.2013 |
> +------------+---------------+----------+
> 
> Here, variation is the coefficient of variation, i.e. standard deviation / mean.
> 
> Based on these results, it seems like there are varying degrees to how much
> lock contention this reduces. For the largest and smallest machines that I ran
> the tests on, it seems like there is quite some significant reduction. There
> is also some performance increases visible from userspace.
> 
> Interestingly, the performance gains don't scale with the size of the machine,
> but rather there seems to be a dip in the gain there is for the medium-sized
> machine.
>
Explaining the dip helps land this work in the next tree.

