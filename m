Return-Path: <linux-kernel+bounces-752293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E80DB1739A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633CB58025A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F35C1D6193;
	Thu, 31 Jul 2025 15:00:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41022A8C1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974017; cv=none; b=Eo8Z1LMHoMrBFOsmKuHnwHgRTAzYfSHsm89NQ8eDILJ2VWR7OYvL82999FrrRQLBsOEB3VT6S/0QnUFNlliR8NkdOEevgVnB+qkwpTXp6i7+Gb/SzZoPz1OnYK/TEwsGLqlEumMvkF6AL21ZU8sqwMZlV4x1L7AM2uOb1n6qus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974017; c=relaxed/simple;
	bh=4IFRiv9fjPG+5vdtrTheT5TfgT13RGbDqLNISf9IOBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O58Bu1eweXVgICJgkeQeTXJ+A4vgyiEgqAC7cwPcsXt7K+v03q9PmOxy9O7HT9oWN9g9wKA8SpOsZsJjWoXYYP793zbBhK1ynshPjANKvxE3sjIvgNLCjotNJoXcf2VwVOZ81RjNIB+NKAd9dK8Nu7MccBWfwE2XKHu6535j2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C43E21D13;
	Thu, 31 Jul 2025 08:00:06 -0700 (PDT)
Received: from [10.1.33.50] (e127648.arm.com [10.1.33.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08A3E3F66E;
	Thu, 31 Jul 2025 08:00:11 -0700 (PDT)
Message-ID: <2990c9d8-c957-4443-a2c5-4b62e48dc818@arm.com>
Date: Thu, 31 Jul 2025 16:00:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] sched/deadline: Fix RT task potential starvation
 when expiry time passed
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Kuyo Chang <kuyo.chang@mediatek.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 jstultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250615131129.954975-1-kuyo.chang@mediatek.com>
 <CAMuHMdWZHwr_nmMbVREKC9nQCYigT_gvKH3M9v+oyYqk6FLONw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAMuHMdWZHwr_nmMbVREKC9nQCYigT_gvKH3M9v+oyYqk6FLONw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 11:06, Geert Uytterhoeven wrote:
> Hi Kuyo,
> 
> On Mon, 16 Jun 2025 at 14:39, Kuyo Chang <kuyo.chang@mediatek.com> wrote:
>> From: kuyo chang <kuyo.chang@mediatek.com>
>>
>> [Symptom]
>> The fair server mechanism, which is intended to prevent fair starvation
>> when higher-priority tasks monopolize the CPU.
>> Specifically, RT tasks on the runqueue may not be scheduled as expected.
>>
>> [Analysis]
>> ---------
>> The log "sched: DL replenish lagged too much" triggered.
>>
>> By memory dump of dl_server:
>> --------------
>>     curr = 0xFFFFFF80D6A0AC00 (
>>       dl_server = 0xFFFFFF83CD5B1470(
>>         dl_runtime = 0x02FAF080,
>>         dl_deadline = 0x3B9ACA00,
>>         dl_period = 0x3B9ACA00,
>>         dl_bw = 0xCCCC,
>>         dl_density = 0xCCCC,
>>         runtime = 0x02FAF080,
>>         deadline = 0x0000082031EB0E80,
>>         flags = 0x0,
>>         dl_throttled = 0x0,
>>         dl_yielded = 0x0,
>>         dl_non_contending = 0x0,
>>         dl_overrun = 0x0,
>>         dl_server = 0x1,
>>         dl_server_active = 0x1,
>>         dl_defer = 0x1,
>>         dl_defer_armed = 0x0,
>>         dl_defer_running = 0x1,
>>         dl_timer = (
>>           node = (
>>             expires = 0x000008199756E700),
>>           _softexpires = 0x000008199756E700,
>>           function = 0xFFFFFFDB9AF44D30 = dl_task_timer,
>>           base = 0xFFFFFF83CD5A12C0,
>>           state = 0x0,
>>           is_rel = 0x0,
>>           is_soft = 0x0,
>>     clock_update_flags = 0x4,
>>     clock = 0x000008204A496900,
>>
>> - The timer expiration time (rq->curr->dl_server->dl_timer->expires)
>>   is already in the past, indicating the timer has expired.
>> - The timer state (rq->curr->dl_server->dl_timer->state) is 0.
>>
>> [Suspected Root Cause]
>> --------------------
>> The relevant code flow in the throttle path of
>> update_curr_dl_se() as follows:
>>
>> dequeue_dl_entity(dl_se, 0);                // the DL entity is dequeued
>>
>> if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se))) {
>>     if (dl_server(dl_se))                   // timer registration fails
>>         enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);//enqueue immediately
>>     ...
>> }
>>
>> The failure of `start_dl_timer` is caused by attempting to register a
>> timer with an expiration time that is already in the past. When this
>> situation persists, the code repeatedly re-enqueues the DL entity
>> without properly replenishing or restarting the timer, resulting in RT
>> task may not be scheduled as expected.
>>
>> [Proposed Solution]:
>> ------------------
>> Instead of immediately re-enqueuing the DL entity on timer registration
>> failure, this change ensures the DL entity is properly replenished and
>> the timer is restarted, preventing RT potential starvation.
>>
>> Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
> 
> Thanks, this fixes the issue I was seeing!
> 
> Closes: https://lore.kernel.org/CAMuHMdXn4z1pioTtBGMfQM0jsLviqS2jwysaWXpoLxWYoGa82w@mail.gmail.com
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 

FWIW the reported issue is also present on an arm64 rk3399 and
$SUBJECT fixes that.


