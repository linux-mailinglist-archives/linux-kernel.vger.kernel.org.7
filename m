Return-Path: <linux-kernel+bounces-843265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C242DBBECA1
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB2F44EFEEE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AE23D7FA;
	Mon,  6 Oct 2025 17:20:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC18623F421
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771247; cv=none; b=sIGouIizzIrrusxpoiwEiZJ205g3+47ZNDD9CVxCrHUCPrf9oziZQ8immazsCqPzeBnaHegjijfLiV7hV1f2KF0bDvxCyTZIDTBw9hD5A/xcDIwYUBlFG9UhXOCjAlcTDn9Z66yaihFCbtHpePN4KVmodW8A/fn9S/Oy0DyDMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771247; c=relaxed/simple;
	bh=0p2/19Do06d59d47h1DHn3Xs9zc1OPed4fBr2nJ8xzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/YQ3XDkoVXqXmymevpEKlyNSayl7qqZEFYbj5FiU3SIjzGMZDTy1ET0WkO1o19EbsLzSJHlTV5wHkJJG19++BdXq2yg/H1bpnifg43idvNMru0nJhDY0wMdbYbQTOcmSjfboBTjDCWHq4k2ICmqappQh8WoYkg1Dvs3eqOZRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 152921515;
	Mon,  6 Oct 2025 10:20:36 -0700 (PDT)
Received: from [10.57.5.180] (unknown [10.57.5.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6DFE3F66E;
	Mon,  6 Oct 2025 10:20:42 -0700 (PDT)
Message-ID: <cbc8d5bc-4ae7-4b61-81f4-9629857736f3@arm.com>
Date: Mon, 6 Oct 2025 18:20:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] sched_ext: lockless peek operation for DSQs
To: Ryan Newton <rrnewton@gmail.com>, linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev, tj@kernel.org, arighi@nvidia.com,
 newton@meta.com
References: <20251006170403.3584204-1-rrnewton@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251006170403.3584204-1-rrnewton@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 18:04, Ryan Newton wrote:
> This allows sched_ext schedulers an inexpensive operation to peek
> at the first element in a queue (DSQ), without creating an iterator 
> and acquiring the lock on that queue.
> 
> Note that manual testing has thus far included a modified version of the
> example qmap scheduler that exercises peek, as well as a modified
> modified LAVD (from the SCX repo) that exercises peek. The attached test
> passes >1000 stress tests when run in concurrent VMs, and when run
> sequentially on the host kernel. Presently, tested on the below
> workstation and server processors.
> - AMD Ryzen Threadripper PRO 7975WX 32-Cores
> - AMD EPYC 9D64 88-Core Processor

Is the adapted qmap and lavd available somewhere?

> 
> Initial experiments indicate a substantial speedup (on schbench) when
> running an SCX scheduler with per-cpu DSQs and peeking each queue to
> retrieve the task with the minimum vruntime across all the CPUs.
> 
> ---
> Changes in v3:
>  - inline helpers and simplify
>  - coding style tweaks
> 
> Changes in v2:
>  - make peek() only work for user DSQs and error otherwise
>  - added a stress test component to the selftest that performs many peeks
>  - responded to review comments from tj@kernel.org and arighi@nvidia.com 
>  - link: https://lore.kernel.org/lkml/20251003195408.675527-1-rrnewton@gmail.com/
>  
> v1 link: https://lore.kernel.org/lkml/20251002025722.3420916-1-rrnewton@gmail.com/
> 
> Ryan Newton (2):
>   sched_ext: Add lockless peek operation for DSQs
>   sched_ext: Add a selftest for scx_bpf_dsq_peek
> 
>  include/linux/sched/ext.h                     |   1 +
>  kernel/sched/ext.c                            |  56 +++-
>  tools/sched_ext/include/scx/common.bpf.h      |   1 +
>  tools/sched_ext/include/scx/compat.bpf.h      |  19 ++
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../selftests/sched_ext/peek_dsq.bpf.c        | 265 ++++++++++++++++++
>  tools/testing/selftests/sched_ext/peek_dsq.c  | 230 +++++++++++++++
>  7 files changed, 571 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c
> 


