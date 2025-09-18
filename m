Return-Path: <linux-kernel+bounces-823287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5365CB860DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C0A1C0159F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F723176E1;
	Thu, 18 Sep 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fmstMp9f"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B0311C17
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213093; cv=none; b=Onzhf5Wx1CbqZWgtUWyyMj6dzr8rhEcHU/3cnhZi0v6iRULouhmJTcnePTy/TSKzMrlVJc29v5XzY2MJOZv6Wq2+uESqIwKA3y9+L+7ViBhT8SBQqTn7IX3XlHlFmlnJ+e0OcOeMaN8YI1Cg1kOebBPcBwSGxLUbkPcp8FhMXPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213093; c=relaxed/simple;
	bh=3KNQBrmuTJnLnWcZwGaVeyMZ6PXTJNOElnm2MX06lJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9SFH31KPDhh8nuFBZFDlMyUztVym/HI70I1/nmKJOV1L4yL62QR5GSonn6awkacGqnby4SsVegT67+G3WCOrbd9j4dONKCwfWHOq4Yze5/oYSrwwjeR4ohCg51Sp3uAfamnrb8kivOIi4/TFKH4nd7UnxV0gaWyUudu3k4FfFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fmstMp9f; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <abc0f24a-33dc-4a64-a293-65683f52dd42@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758213079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1p1A6UBHOrPki1VrYn/yNmVc9P78XZFmtuQXerf7RA=;
	b=fmstMp9fFges487/IV/ethWtE9xqvl2Y3omU0qNnsk16lV33roM+pUJJvKak8LfzJmdCAl
	iti9nBCbaf6nwA8oIkoucZHMwaU5feBVcCs2OngyWavgznRf4PgymK6tFR38r9jLVj5nuH
	BhOjnbq/D6J6nfPRrgripqVxBXXgsOo=
Date: Thu, 18 Sep 2025 09:31:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix race in do_task() when draining
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org, rpearsonhpe@gmail.com
References: <20250917100657.1535424-1-hanguidong02@gmail.com>
 <a321729d-f8a1-4901-ae9d-f08339b5093b@linux.dev>
 <CALbr=LZFZP3ioRmRx1T4Xm=LpPXRsDhkNMxM9dYrfE5nOuknNg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <CALbr=LZFZP3ioRmRx1T4Xm=LpPXRsDhkNMxM9dYrfE5nOuknNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/17/25 7:21 PM, Gui-Dong Han wrote:
> On Thu, Sep 18, 2025 at 3:31 AM yanjun.zhu <yanjun.zhu@linux.dev> wrote:
>> On 9/17/25 3:06 AM, Gui-Dong Han wrote:
>>> When do_task() exhausts its RXE_MAX_ITERATIONS budget, it unconditionally
>>   From the source code, it will check ret value, then set it to
>> TASK_STATE_IDLE, not unconditionally.
> Hi Yanjun,
>
> Thanks for your review. Let me clarify a few points.
>
> You are correct that the code checks the ret value. The if (!ret)
> branch specifically handles the case where the RXE_MAX_ITERATIONS
> limit is reached while work still remains. My use of "unconditionally"
> refers to the action inside this branch, which sets the state to
> TASK_STATE_IDLE without a secondary check on task->state. The original
> tasklet implementation effectively checked both conditions in this
> scenario.
>
>>> sets the task state to TASK_STATE_IDLE to reschedule. This overwrites
>>> the TASK_STATE_DRAINING state that may have been concurrently set by
>>> rxe_cleanup_task() or rxe_disable_task().
>>   From the source code, there is a spin lock to protect the state. It
>> will not make race condition.
> While a spinlock protects state changes, rxe_cleanup_task() and
> rxe_disable_task() do not hold it for its entire duration. It acquires
> the lock to set TASK_STATE_DRAINING, but then releases it to wait in
> the while (!is_done(task)) loop. The race window exists when do_task()
> acquires the lock during this wait period, allowing it to overwrite
> the TASK_STATE_DRAINING state.
>
>>> This race condition breaks the cleanup and disable logic, which expects
>>> the task to stop processing new work. The cleanup code may proceed while
>>> do_task() reschedules itself, leading to a potential use-after-free.
>>>
>> Can you post the call trace when this problem occurred?
> This issue was identified through code inspection and a static
> analysis tool we are developing to detect TOCTOU bugs in the kernel,
> so I do not have a runtime call trace. The bug is confirmed by
> inspecting the Fixes commit (9b4b7c1f9f54), which lost the special
> handling for the draining case during the migration from tasklets to
> workqueues.
Thanks a lot for your detailed explanations. Could you update the commit 
logs to reflect the points you explained above?

The current commit logs are a bit confusing, but your explanation makes 
everything clear. If you rewrite the logs with that context, other 
reviewers will be able to understand your intent directly from the 
commit message, without needing the extra explanation. That would make 
the commit much clearer.

Any way,

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>
> Regards,
> Han

