Return-Path: <linux-kernel+bounces-854076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0F0BDD7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 091224F7BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94813168E1;
	Wed, 15 Oct 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Prq7odDq"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76225D1E6
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517985; cv=none; b=S7iV3meFVcKkC5Aq2dXyos1qKu6iE5SpPVIAd1nR25xihPSxIrhJqHoK3dYZAoPIBIqur7os5Nwvmx8Y7B6yJy9BPvX7A2mo4FecBdBX60H791tpep0ufTiJZjJvlnoAqHFDUhjbLCikspFMEN9u+kKBm+eW/VfUvtjKzYULvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517985; c=relaxed/simple;
	bh=N9KkZd+pM68XQzC/KDaa8K/rt0ZDeoywElkFBglTxNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjcScSe73z6d6Po50RUbfK8IbUXSwMUc8sgHp6LR358VYQUmq0y9Nlc8nZCAsyIQxgJTOCO/3Jzkk1u9FWAI9pcFj531ykPD4PkWAUSL1qYYGGxEJu7LFcylfhfwOJ/NN89Pxn7QQuK40zdRWMXpAHu3/9vrWh/v/GPyRPBkmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Prq7odDq; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1760517670;
	bh=tCf5xnXjEo8+PnWIJEfZ+l0Xg8DhM30RbLgPsShmo0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Prq7odDqZRHuRxWvZoZ91wXSEO/MMnb68kEw4cqgZE5yx7BueRhloCaCJYdZpNs4W
	 fvy5p4+7MYKoyAObEwKB1GPxCodm6GjjEWsLLhFPDV3t7H1E/MH6chMwMiQQdq0oL1
	 D4WJak8w43O9q2ijiqVAnHoKX7uYNFC24RODQuTg=
Received: from [IPV6:240e:474:40:8499:7ffc:cd5d:d629:4752] ([240e:474:40:8499:7ffc:cd5d:d629:4752])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id A47366A8; Wed, 15 Oct 2025 16:41:07 +0800
X-QQ-mid: xmsmtpt1760517667tpixyqqoc
Message-ID: <tencent_864D604B16C284549B49EAD596815A2A7606@qq.com>
X-QQ-XMAILINFO: NlUc2cqXmL74SDUhNpt6WWc+mexzGgdYXNpFl56bpGhkbrSEDuu/59njYkjhOC
	 PwOL5Ykp4QzalkI8Ci/MEIWLBU1M3fH7tQsVQZr8AxiafPSUVYCbXWjDijFyMWtJRppcU8p7q8nW
	 JointL8yjUlJnu3iTXV4QQe5hL/7yu3t3WmiduhJcWa303uwHGHfwE81KeA8LFrs4bCVMJZSzeX6
	 UCVFgwV90/mNzEFH+7TgYcebVhW7Hux+/7b26EJsR9EM6dEmv4JgQwzMmF5sk23sYJGRkpwZnC+g
	 qCKjymn6GTfGz5aHoV/2kZYtA1H82d1Axox/5MGLZuSH2YNRuv2bIB+gcyJ3Wy0s7CCt8u5tb7KV
	 xvjZ5EqhFHrab7R+nkX9mwGVWXX/D/+HBkj6AtylPRmiXDNcaoImZrRaL04ELTSSVfi6njgsPmVV
	 LNxyrFwW/zkT/ezLVRxcwaRWYihtkJiD59raHPS2aYzIVSNO30yVoE0W3AAnAwB/FwdHCdagfY8n
	 A9+QOjRLEOXbE8pJv18IzP6V3XlaCSDZ3xq6DPS0a9W7bSCfziT7A2LWe51m1GbFIBy3pOpE5BZx
	 34bCO/4+regm/lxrTuobfuYicF1D/g+N6YXTHpqJloF13/ylAyXaWtOg9hUWV/0PwT2sOB/60v1b
	 dpeZJ/IQJYj7cHt9fEcpgTpW2zgnGqj91mnKTcH/meWLQ9VoTP5/UXI3mDmOUrjG1ZRKAMdWyfoE
	 fHjxr7E3GjngLFoqy1mLNPXkUO1ksEtrAURftL1wxTcjfihbJHEpdqVQPMlU2Uwb9klqCX2F5Toy
	 gyUY7j21qdUW7vp/s/sAwxsxcYcNlM+bTCwGA+L+A7qV4GZuuGjz5XftU0aOrngb4VhHqnQWwh/1
	 K3zKBb7K4gDpWCgPW093DFruJT4K0ozIPRsyfa2Y9cDwXdAie17zp4ow08HL4qui+VMIMZ3fN8vk
	 ep1Xd86MYOlqPXXtMtKSgftJjQbf/LuEH8eiMbNxKESIZ1MGEgq9mhKaPOzp5AjThdCTmseIG3Xz
	 VXqTZf6k2KvwUS84MrokG2GaQAzoWgZgiQbh8zmjmVO9eVwtfHaH+aHHoMeXxdAj8US5oDmTmrP/
	 t0Y6CD
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <1d911694-9640-4ce0-a5c9-c272318765a8@foxmail.com>
Date: Wed, 15 Oct 2025 16:41:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] sched/fair: Only update stats for allowed CPUs
 when looking for dst group
To: Peter Zijlstra <peterz@infradead.org>,
 Adam Li <adamli@os.amperecomputing.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, cl@linux.com,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com,
 shkaushik@amperecomputing.com
References: <20251011064322.8500-1-adamli@os.amperecomputing.com>
 <20251014113731.GO4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Chen Yu <yu.chen.surf@foxmail.com>
In-Reply-To: <20251014113731.GO4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/25 19:37, Peter Zijlstra wrote:
> On Sat, Oct 11, 2025 at 06:43:22AM +0000, Adam Li wrote:
>> Load imbalance is observed when the workload frequently forks new threads.
>> Due to CPU affinity, the workload can run on CPU 0-7 in the first
>> group, and only on CPU 8-11 in the second group. CPU 12-15 are always idle.
>>
>> { 0 1 2 3 4 5 6 7 } {8 9 10 11 12 13 14 15}
>>    * * * * * * * *    * * *  *
>>
>> When looking for dst group for newly forked threads, in many times
>> update_sg_wakeup_stats() reports the second group has more idle CPUs
>> than the first group. The scheduler thinks the second group is less
>> busy. Then it selects least busy CPUs among CPU 8-11. Therefore CPU 8-11
>> can be crowded with newly forked threads, at the same time CPU 0-7
>> can be idle.
>>
>> A task may not use all the CPUs in a schedule group due to CPU affinity.
>> Only update schedule group statistics for allowed CPUs.
>>
>> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
>> ---
>> Resending this patch from the patchset:
>> https://lore.kernel.org/lkml/20250717062036.432243-2-adamli@os.amperecomputing.com/
>>
> 
> Right, lets start with this then ;-)
> 
> No need to do the cpumask_and() thing, that's just more changes vs
> update_sg_lb_stats().
> 


I just saw Peter's comments on this.  I'm OK with the current
version and Adam please feel free to keep my Reviewed-by tag
for this non-cpumask_and version.

thanks,
Chenyu


