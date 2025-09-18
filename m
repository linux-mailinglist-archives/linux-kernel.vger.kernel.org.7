Return-Path: <linux-kernel+bounces-772760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B038B2972E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A7F179D20
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D345325A352;
	Mon, 18 Aug 2025 03:00:05 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368EB25A2CD;
	Mon, 18 Aug 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755486005; cv=none; b=NZBty2sEjTzr6h1DiuMy6no5y83wkX85jjT2AhxeBp77mx2UohTGqnOt1fMxGHdUx8xPoahh63GKgCyUtsbYHZjZAG6Y7vw4AC4YmRbK7QcRU5aPAqSfuMxu6eZb6TSEwDnIWCZGgE9FiYxj7obnv9GeKYEqz1ipDGN6yuL9u3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755486005; c=relaxed/simple;
	bh=bQlXvockhKFH3O7EY/UuSs9p6fvQc7UsNhVlF3281uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9TqFKNYwnhEGNR+4F1q4Jw48MX25hZmeNBwSrc/ontwQIP5QyTvWCXRhWw6IJLGJzGiRfDn98IwE8L2dk04UqoQPYcSSzfYfS2HK+W7bhKKpMffY4vKxpQh5MhUVHpXo8ZFCXiuN/yBu741Oeyrc/lLsqK/jvw7AxV+q49UZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <daniel@iogearbox.net>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<eddyz87@gmail.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<martin.lau@linux.dev>, <sdf@fomichev.me>, <song@kernel.org>,
	<wangfushuai@baidu.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf] bpf: Use cpumask_next_wrap() in get_next_cpu()
Date: Mon, 18 Aug 2025 10:58:51 +0800
Message-ID: <20250818025851.21413-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <75cd7b00-53b6-496f-a934-339eed8f9a72@iogearbox.net>
References: <75cd7b00-53b6-496f-a934-339eed8f9a72@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc11.internal.baidu.com (172.31.51.11) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

>> Replace the manual sequence of cpumask_next() and cpumask_first()
>> with a single call to cpumask_next_wrap() in get_next_cpu().
>> 
>> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
>> ---
>>   kernel/bpf/bpf_lru_list.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>> 
>> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
>> index 2d6e1c98d8ad..34881f4da8ae 100644
>> --- a/kernel/bpf/bpf_lru_list.c
>> +++ b/kernel/bpf/bpf_lru_list.c
>> @@ -21,10 +21,7 @@
>>   
>>   static int get_next_cpu(int cpu)
>>   {
>> -	cpu = cpumask_next(cpu, cpu_possible_mask);
>> -	if (cpu >= nr_cpu_ids)
>> -		cpu = cpumask_first(cpu_possible_mask);
>> -	return cpu;
>> +	return cpumask_next_wrap(cpu, cpu_possible_mask);
>>   }
> 
> Lets then get rid of the get_next_cpu() function since its only used
> once, and just use the cpumask_next_wrap() at call site ?
> 
> [...]
>                  raw_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
> 
>                  steal = cpumask_next_wrap(steal, cpu_possible_mask);
>          } while (!node && steal != first_steal);
> [...]
>
 
Thank you for your suggestion.

> Btw, in $subj please target [PATCH bpf-next] given its a cleanup,
> not a fix.

I will send a v2 shortly.

Regards,
Wang.

