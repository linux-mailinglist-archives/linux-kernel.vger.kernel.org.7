Return-Path: <linux-kernel+bounces-753537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BB4B18445
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3640A83375
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6739626E6ED;
	Fri,  1 Aug 2025 14:54:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8778A2571D8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060081; cv=none; b=P9+DLODoDhR09OHlamlZpX+iPWKWHo02sGJv63U3KpwL2VMnqtq0yzVVEPg7HQ1FRMKbZMmWo50UwMS2bwc6zyL1fBLwJdQ/PA0r4h1Zo3Vk1rc5VekQMe56Xzk+nas1Zuc3G3ORBL6lTSaDGMImMNqT18Y5mfE9e5IaE8a22SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060081; c=relaxed/simple;
	bh=3vwxf43HnM6fp2DvlIv0MBH+Wklk/GbWFUrJKGnUpN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmJq5xUGX92eNQtcgE4aIgYTFNmCQdrLWSqQNhe9Ed4WHx5+HjZ6WFuqYNdgIBFw8Xe1SFp7NV+9SPMUGTSHki+P6Jk/sOi9IG5Yp4WXFxok8nu0y7KFhPnVG4vhxak9QKv9cslNNa8575pFbbU3AHH+uDBQ0cswNXCeClXKHH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA05B1516;
	Fri,  1 Aug 2025 07:54:30 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FD9E3F66E;
	Fri,  1 Aug 2025 07:54:36 -0700 (PDT)
Message-ID: <cb977466-ad2d-48af-b388-b3c55a5169e2@arm.com>
Date: Fri, 1 Aug 2025 15:54:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org,
 void@manifault.com, mingo@redhat.com, peterz@infradead.org
References: <20250801141741.355059-1-christian.loehle@arm.com>
 <20250801141741.355059-4-christian.loehle@arm.com> <aIzUX4d0KRXI4E8O@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aIzUX4d0KRXI4E8O@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/25 15:51, Andrea Righi wrote:
> On Fri, Aug 01, 2025 at 03:17:41PM +0100, Christian Loehle wrote:
>> Most fields in scx_bpf_cpu_rq() assume that its rq_lock is held.
>> Furthermore they become meaningless without rq lock, too.
>> Only return scx_bpf_cpu_rq() when we hold rq lock of that rq.
>>
>> All upstream scx schedulers can be converted into the new
>> scx_bpf_remote_curr() instead.
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  kernel/sched/ext.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 92e66bb0b5f2..627df3088fd0 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -7425,7 +7425,7 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
>>  }
>>  
>>  /**
>> - * scx_bpf_cpu_rq - Fetch the rq of a CPU
>> + * scx_bpf_cpu_rq - Fetch the rq of a CPU if its rq lock is currently held
>>   * @cpu: CPU of the rq
>>   */
>>  __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>> @@ -7433,7 +7433,7 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>>  	if (!kf_cpu_valid(cpu, NULL))
>>  		return NULL;
>>  
>> -	return cpu_rq(cpu);
>> +	return this_cpu_read(locked_rq) == cpu_rq(cpu) ? cpu_rq(cpu) : NULL;
> 
> Maybe we should consider an access to an unlocked rq as invalid and trigger
> scx_exit(), similar to what we do with the kf_cpu_valid() check?

Makes sense to me!

> 
> Also heads up that locked_rq has been renamed scx_locked_rq_state in 6.17.

Ah, thanks! I'll rebase!

