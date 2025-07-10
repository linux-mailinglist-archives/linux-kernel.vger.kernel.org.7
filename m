Return-Path: <linux-kernel+bounces-725264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4120FAFFC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006D13A6D04
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B2228C840;
	Thu, 10 Jul 2025 08:42:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C71285C89
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136932; cv=none; b=SbuazwvVyaUbyvBR88ApnrKimhyXT/63FqXGfVAbEI01qVYhjlCnNUQPW21nQWGFPKfShEsMYadQk32Iem8TUxjsszuZD6ZrAqJ0KpR96Zy1x8GuGJ5oKhARds9IVKldLlqnPFshax2ZCfMOkca/Ixbda111dEtx/MB8oUD/qg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136932; c=relaxed/simple;
	bh=jlaQKK2eUFw82DLpzWcK3zH7m/um69ZY8vEnM3PCR+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHzmMA9+ab5NhKrJ/Juqf6udjXZdPD6tRj0EWpnyg0YjCRQTt9EndRaZUU+7yzcBw7UBZrFIzAPNgiA7Ii9EfGKqL6c4SLH5vpVkSfs/4wMAnk8YZ6NNIl4FSU9JRZiRjYeT0OI+t++qXP6OsccshzSxFMmcRRzCKla/vMCxnVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A969B1EA6;
	Thu, 10 Jul 2025 01:41:57 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CF243F738;
	Thu, 10 Jul 2025 01:42:04 -0700 (PDT)
Message-ID: <21236218-b1a3-4333-aaef-cace303288b3@arm.com>
Date: Thu, 10 Jul 2025 09:41:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sched/uclamp: Exclude kernel threads from uclamp logic
To: Zihuan Zhang <zhangzihuan@kylinos.cn>, xuewen.yan@unisoc.com,
 vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, hongyan.xia2@arm.com, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 kprateek.nayak@amd.com, kuyo.chang@mediatek.com, juju.sung@mediatek.com,
 qyousef@layalina.io
References: <20250703091437.79861-1-zhangzihuan@kylinos.cn>
 <675563a5-8f1d-4249-9828-9fb353dd7dd1@arm.com>
 <6414cb05-11d3-4b2a-ae97-7bb0ca0ea898@kylinos.cn>
 <8a64cb22-24f7-4ca7-8e4e-22e1612124d9@arm.com>
 <386d99d3-aa97-4069-8d63-d197262832bf@kylinos.cn>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <386d99d3-aa97-4069-8d63-d197262832bf@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/10/25 01:47, Zihuan Zhang wrote:
> Hi Christian,
> Apologies for the late reply, and thanks for raising the concerns.
> 
> 在 2025/7/3 18:17, Christian Loehle 写道:
>> On 7/3/25 11:07, Zihuan Zhang wrote:
>>> Hi Christian,
>>>
>>> Thanks for the question!
>>>
>>> 在 2025/7/3 17:22, Christian Loehle 写道:
>>>> On 7/3/25 10:14, Zihuan Zhang wrote:
>>>>> Kernel threads (PF_KTHREAD) are not subject to user-defined utilization
>>>>> clamping. They do not represent user workloads and should not participate
>>>>> in any uclamp logic, including:
>>>> Why not?
>>>>
>>> As Xuewen mentioned, some kernel threads may intentionally set scheduling attributes for performance. So instead of unconditionally excluding all kernel threads, I’m now considering a more conservative approach:
>>> skip only those kthreads that haven’t explicitly set any clamp values.
>>>
>>> This should help avoid unintended clamp aggregation while still supporting performance-tuned kthreads.
>> I'm skeptical, fundamentally you cannot exclude some fair tasks from uclamp logic.
>> At least the cpufreq part they will be affected by, so if you 'exclude' some
>> kthread that doesn't have clamps set (i.e. has min=0, max=1024) its
>> utilization may not contribute to sugov frequency selection by being
>> clamped by other task(s) (let's say you only have one other task with
>> max=0, excluding the unclamped kthread now leads to sugov requesting
>> the lowest OPP? Is that always correct/desired?)
>>
>> Is there a specific issue you're trying to solve?
>> FYI there has been discussion around reworking the uclamp mechanism to solve
>> some issues you may have been facing, but so far they haven't lead anywhere:
>> https://lore.kernel.org/lkml/cover.1741091349.git.hongyan.xia2@arm.com/
> Our original motivation stems from the observation that uclamp is primarily designed to manage frequency selection based on user-space task behavior. Kernel threads typically do not represent user workloads and are often not considered meaningful participants in uclamp-driven decisions.

Two comments to that:
- It's also used to drive task placement, not just frequency selection.
- There can be cases where a kthread is fundamentally part of a user workload,
thinking about io_uring here, but others exist too.

> To be clear, we are not aiming to exclude all kthreads from affecting frequency, but rather to explore ways to avoid unnecessary uclamp aggregation overhead from kernel threads that have no explicit clamp values set (i.e. uclamp.min=0, max=1024).
> As you pointed out, fully excluding these tasks might interfere with sugov behavior in certain edge cases. So a more balanced approach might be:
> 
> - For kernel threads that do not set any clamp values, skip the clamp aggregation step
> 
> - If a kernel thread explicitly sets clamp attributes, it should of course remain fully visible to uclamp logic.
> 
> This would preserve correctness while reducing unnecessary overhead in the hot path, especially on systems with many runnable tasks.

So an unclamped task not being part of uclamp will definitely affect the UCLAMP_MAX
result, as I've mentioned above, you'll apply (other tasks) UCLAMP_MAX restrictions
even if the kthread has UCLAMP_MAX==1024. That is not always desirable.
Or would you let it take part in uclamp if the user explicitly set UCLAMP_MAX==1024
instead of relying on the default? That wouldn't be consistent IMO.

Regarding the optimization part:
Is there a specific workload where the overhead is an issue? It should
be rather small. Some numbers should help.

