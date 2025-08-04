Return-Path: <linux-kernel+bounces-755185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E282B1A2C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0693662161C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C82026B760;
	Mon,  4 Aug 2025 13:02:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D7A1E5213
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312573; cv=none; b=YIHAls9qgu8aoFY03t4P5Hn8Ahzlfh4vQAUpX3B6Ao6dQLaxAmm2ifRhRH22dgYmBrZVU4zRShtOTh3uU9tlSyFmjdCGQ39359AKMZDycF1nsw2H4ZLyYcbF/B9DzvOcpLMzBLd5/WnQI8SSULk7I8LyzD3LR6uWCF4pms6CS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312573; c=relaxed/simple;
	bh=KVFdHv6v0HPgtkAz+4l8lGdkysZRAs30mbAPN7yO0tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LabFCxlIUaklQNKC9k/Tomp3Ej/DkyhKtfXP+7xbTMi/PBA4wjpAhyqHlxZ4/iSkHbqIN3HrYOKWCJ6N8hCm9Hd+h5U8Mixqv77vPxwuj1MnG0oKuObU9v294ScmuPIBoVYHZ0yeuJuuwa18E5JpkWZn4ovibuve8Rjzvjc/z7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50485150C;
	Mon,  4 Aug 2025 06:02:43 -0700 (PDT)
Received: from [10.1.25.45] (e127648.arm.com [10.1.25.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A49B63F673;
	Mon,  4 Aug 2025 06:02:49 -0700 (PDT)
Message-ID: <1ae1700c-9102-44b1-93f0-1c2ebc4f433e@arm.com>
Date: Mon, 4 Aug 2025 14:02:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
 mingo@redhat.com, peterz@infradead.org
References: <20250804112743.711816-1-christian.loehle@arm.com>
 <20250804112743.711816-4-christian.loehle@arm.com> <aJCqb-ZI4pd15cr5@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aJCqb-ZI4pd15cr5@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/25 13:41, Andrea Righi wrote:
> On Mon, Aug 04, 2025 at 12:27:43PM +0100, Christian Loehle wrote:
>> Most fields in scx_bpf_cpu_rq() assume that its rq_lock is held.
>> Furthermore they become meaningless without rq lock, too.
>> Only return scx_bpf_cpu_rq() if we hold rq lock of that rq.
>>
>> All upstream scx schedulers can be converted into the new
>> scx_bpf_remote_curr() instead.
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  kernel/sched/ext.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 1d9d9cbed0aa..0b05ddc1f100 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -7420,10 +7420,18 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
>>   */
>>  __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>>  {
>> +	struct rq *rq;
>> +
>>  	if (!kf_cpu_valid(cpu, NULL))
>>  		return NULL;
>>  
>> -	return cpu_rq(cpu);
>> +	rq = cpu_rq(cpu);
>> +	if (rq != scx_locked_rq_state) {
> 
> I think you want to check rq != scx_locked_rq(), since scx_locked_rq_state
> is a per-CPU variable.

Duh, of course. m(

> 
> We may also want to add a preempt_disable/enable() for consistency. How
> about something like this?
> 
> 	preempt_disable();
> 	rq = cpu_rq(cpu);
> 	if (rq != scx_locked_rq()) {
> 		scx_kf_error("Accessing CPU%d rq from CPU%d without holding its lock",
> 			     cpu, smp_processor_id());
> 		rq = NULL;
> 	}
> 	preempt_enable();

Ack


