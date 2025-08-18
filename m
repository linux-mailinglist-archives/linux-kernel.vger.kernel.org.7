Return-Path: <linux-kernel+bounces-773694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5467B2A5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386D91B233D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94132252B;
	Mon, 18 Aug 2025 13:24:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D755E322525
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523474; cv=none; b=q96+i3oAzjJ0gY0RzbZbTiMwlgLXhnsnJZa9Qabr7yBcyPoRskmaJfn+V+67KlhR0ZLbt2sTFwsKxp+rYFCOfc1r5AZZgS2k+kvaXKS/ryAaU+mfPBknL1aBtIfdqfLCxQnkQtLzLXzy75gd33bSfPVbiHVMWO5uG6dUo0tU7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523474; c=relaxed/simple;
	bh=ZIt/8w+UJkdvLXYCLqzxQ/7y6bqoXrJBtRTFVDudyVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjR1M5tABiy4JhWsZYZ+go1tQNIzSBqPjJvulptI6CAZF1OHyCIn8BN02kHXPjrOvxI+M/U/jYAVHorKwapaTFrFnWnJmACd6F5eC0dPSIpE/h3tlfiO8WURLNOnk0p41GwqZ8Mz8SQLuWtQjGJ4878ue+RGFbpXw1kqGoFrcuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E87151596;
	Mon, 18 Aug 2025 06:24:23 -0700 (PDT)
Received: from [10.1.37.41] (e127648.arm.com [10.1.37.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC9073F738;
	Mon, 18 Aug 2025 06:24:29 -0700 (PDT)
Message-ID: <87212818-1f59-45e4-9a51-dca62ddb9633@arm.com>
Date: Mon, 18 Aug 2025 14:24:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/fair: Remove sched_idle_cpu() usages in
 select_task_rq_fair()
To: Chengming Zhou <chengming.zhou@linux.dev>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
References: <20250818124702.163271-1-chengming.zhou@linux.dev>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250818124702.163271-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 13:47, Chengming Zhou wrote:
> These sched_idle_cpu() considerations in select_task_rq_fair() is based
> on an assumption that the wakee task can pick a cpu running sched_idle
> task and preempt it to run, faster than picking an idle cpu to preempt
> the idle task.
> 
> This assumption is correct, but it also brings some problems:
> 
> 1. work conservation: Often sched_idle tasks are also picking the cpu
> which is already running sched_idle task, instead of utilizing a real
> idle cpu, so work conservation is somewhat broken.
> 
> 2. sched_idle group: This sched_idle_cpu() is just not correct with
> sched_idle group running. Look a simple example below.
> 
> 		root
> 	/		\
> 	kubepods	system
> 	/	\
> burstable	besteffort
> 		(cpu.idle == 1)
> 
> When a sched_idle cpu is just running tasks from besteffort group,
> sched_idle_cpu() will return true in this case, but this cpu pick
> is bad for wakee task from system group. Because the system group
> has lower weight than kubepods, work conservation is somewhat
> broken too.
> 
> In a nutshell, sched_idle_cpu() should consider the wakee task group's
> relationship with sched_idle tasks running on the cpu.
> 
> Obviously, it's hard to do so. This patch chooses the simple approach
> to remove all sched_idle_cpu() considerations in select_task_rq_fair()
> to bring back work conservation in these cases.

OTOH sched_idle_cpu() CPUs are guaranteed to not be in an idle state and
potentially already have DVFS on some higher level...

