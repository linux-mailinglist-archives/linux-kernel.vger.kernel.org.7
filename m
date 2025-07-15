Return-Path: <linux-kernel+bounces-732229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE211B063AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B164E78A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2DC246BB8;
	Tue, 15 Jul 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/qcXfdi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57984A3E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595252; cv=none; b=diBnVfAvB8h4bE47yvijmR8Jju391vLMqm5g/pzRRI5L8r9weAuuAphhbLXA8estPDPk8YEZAYHvUXsCBMLDCiDpjYmUhur3go4SB2Nsfhf1jYtVBxYaCEgihR2hNMY/GQd6xCA34aK7STCYiX71nl9I8ma6x3ikLqoAo2Yy2nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595252; c=relaxed/simple;
	bh=QGDL0kvdCWFlRnKscgJjq+k+L0QvyBPNvfMVFZrVcWo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lQQKIqPcpjJ+KNP+zBsiUtotdKtcclCpffO1tBWODppmSDgTolj/CN0qDjBnfRnIH1RnxEiHlrmWGdirtVzE12z57h41NAS1GsfPggUwcj6jT2mhig36lH4/FCZ5/XynRNXpF+ftxiu/WaK9Vjq4RaUXCqbfeH72d98caPRYV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/qcXfdi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752595250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXwosRAk7cpmUzQUy+WVJ4W1gQSc+hb1c+UjkCUp6Uk=;
	b=F/qcXfdicNdnBsuxAHQQ9p5V8Iro6HcW5KWxDMmRUrFTe6nnb3kbOls7eJar6l+DYysq1/
	SqMF0jVJF3nsKSztYllZpkfSGRZUNWjntx/YKv0QGktILruWOm7M1U5sRBqF6GWxq8nR6d
	egngJdadKF/18ijGZuSgAkog+915CSA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-RsErZ6CvPiiGxqDkedHcJQ-1; Tue, 15 Jul 2025 12:00:48 -0400
X-MC-Unique: RsErZ6CvPiiGxqDkedHcJQ-1
X-Mimecast-MFC-AGG-ID: RsErZ6CvPiiGxqDkedHcJQ_1752595248
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e095227f5dso531958785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752595248; x=1753200048;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXwosRAk7cpmUzQUy+WVJ4W1gQSc+hb1c+UjkCUp6Uk=;
        b=htVs0EtNXsnhgCwDN5M0f66f9mUUXMz6ZK4OI/OWTw/z52lpq3NlE33+uWiVzRFdk/
         DesEW49arc7Eh7xDqxNEdUCX1qDTKiAb+Zth9rwTZRhQh7LwlgrTAVSIBuHRtv89DYSs
         cnNm8iZTiIh4LB67rH5Cac2d4TbPKsJD5xA7uomCvwMUckzUhzabwlJXJb5gbELrrjLT
         9iXnxWAKLQAFFVOQ3CDPXw+a/Kwn1Br0E2C0h7TVsZjHQhhU3p5jD8qwBckRL1d2et9M
         1g75LESj4g2w+9FpSYA0+QBQbBYmfHeW56vQmWnaXr0JgJfxMGzx2hEgLypaV8EdRppM
         Z5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWSgzNXT60kKXmUStjOAtn1Lk29sUR0zPmxxfAZsgHDMZ+dGFXGYXr6W7YDB8pJhlfKwR9ISWE50gYbAUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydDidnvZJa86K14Vf05+Vwp3GKxYo046eeCfiRnyu397F/DxSp
	USqk/3i8eIpzuUvElnmg9z0zzziTO1hwUMkbMwUGmI3jRp/n2mWnMmc7fqknb+w+WCG5PnUZo74
	lVSrXFRd88P+w4AoRhFgt8K9rYQtmBg+5jOu2kHGYfg/uQSizpggYMGdz2qNA5Wczrw==
X-Gm-Gg: ASbGnctKDVLpLV3P/4QjnSxGNHrnpE/GKLPsQOu7siOIksyTgLq7p+b4O4yHzn3aD1g
	otNY4Xy/hmCsI3LObU0iR6dkbRZPF++WIlonvGbJUrDT86UdCFE1hoBjHiauc37K3dzJIEMGTkk
	ipUuhGR3QwqDx9RdPYiakh7olvaVxunIm3+DDQViJlt430g6IpdFlpWrrG8sd5DrwE66nq7zjaw
	uC4bpJtCnaIOCDpnHCYRGXaAk24pEuIm+rWk0aQ6OOW2qxpN0LRroGk3R2b3AeRN1NlKZkOgeUQ
	ksbJhQBWU1ytDCTEdPbakkvM4jpR4LuEKuJywCavhPK7VkkSQTtyphTXVc4JzmHDm+mM45UsiPs
	eU3t9JG8gOg==
X-Received: by 2002:a05:620a:4592:b0:7e0:2c05:6b98 with SMTP id af79cd13be357-7e338be52fbmr423927885a.20.1752595247467;
        Tue, 15 Jul 2025 09:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8OqdBxsggnkLBvim314ncx0zbBASpaeaktiw40LuYsgyHA1nGTYgcxijPhPza/ECjub3h5Q==
X-Received: by 2002:a05:620a:4592:b0:7e0:2c05:6b98 with SMTP id af79cd13be357-7e338be52fbmr423920985a.20.1752595246781;
        Tue, 15 Jul 2025 09:00:46 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e3081e036esm240838585a.107.2025.07.15.09.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 09:00:45 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <eec0c87e-b5bf-45b7-9eff-b84d53784678@redhat.com>
Date: Tue, 15 Jul 2025 12:00:43 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cpuset: fix warning when attaching tasks with
 offline CPUs
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, peterz@infradead.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250715023340.3617147-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250715023340.3617147-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 10:33 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A kernel warning was observed in the cpuset migration path:
>
>       WARNING: CPU: 3 PID: 123 at kernel/cgroup/cpuset.c:3130
>       cgroup_migrate_execute+0x8df/0xf30
>       Call Trace:
>        cgroup_transfer_tasks+0x2f3/0x3b0
>        cpuset_migrate_tasks_workfn+0x146/0x3b0
>        process_one_work+0x5ba/0xda0
>        worker_thread+0x788/0x1220
>
> The issue can be reliably reproduced with:
>
>       # Setup test cpuset
>       mkdir /sys/fs/cgroup/cpuset/test
>       echo 2-3 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
>       echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
>
>       # Start test process
>       sleep 100 &
>       pid=$!
>       echo $pid > /sys/fs/cgroup/cpuset/test/cgroup.procs
>       taskset -p 0xC $pid  # Bind to CPUs 2-3
>
>       # Take CPUs offline
>       echo 0 > /sys/devices/system/cpu/cpu3/online
>       echo 0 > /sys/devices/system/cpu/cpu2/online
>
> Root cause analysis:
> When tasks are migrated to top_cpuset due to CPUs going offline,
> cpuset_attach_task() sets the CPU affinity using cpus_attach which
> is initialized from cpu_possible_mask. This mask may include offline
> CPUs. When __set_cpus_allowed_ptr() computes the intersection between:
> 1. cpus_attach (possible CPUs, may include offline)
> 2. p->user_cpus_ptr (original user-set mask)
> The resulting new_mask may contain only offline CPUs, causing the
> operation to fail.
>
> To resolve this issue, if the call to set_cpus_allowed_ptr fails, retry
> using the intersection of cpus_attach and cpu_active_mask.
>
> Fixes: da019032819a ("sched: Enforce user requested affinity")
> Suggested-by: Waiman Long <llong@redhat.com>
> Reported-by: Yang Lijin <yanglijin@huawei.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

Thanking further about this problem, the cpuset patch that I proposed is 
just a bandage. It is better to fix the problem at its origin in 
kernel/sched/core.c. I have posted a new patch to do that.

Cheers,
Longman

>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f74d04429a29..2cf788a8982a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3114,6 +3114,10 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>   static cpumask_var_t cpus_attach;
>   static nodemask_t cpuset_attach_nodemask_to;
>   
> +/*
> + * Note that tasks in the top cpuset won't get update to their cpumasks when
> + * a hotplug event happens. So we include offline CPUs as well.
> + */
>   static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   {
>   	lockdep_assert_held(&cpuset_mutex);
> @@ -3127,7 +3131,16 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   	 * can_attach beforehand should guarantee that this doesn't
>   	 * fail.  TODO: have a better way to handle failure here
>   	 */
> -	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
> +	if (unlikely(set_cpus_allowed_ptr(task, cpus_attach))) {
> +		/*
> +		 * Since offline CPUs are included for top_cpuset,
> +		 * set_cpus_allowed_ptr() can fail if user_cpus_ptr contains
> +		 * only offline CPUs. Take out the offline CPUs and retry.
> +		 */
> +		if (cs == &top_cpuset)
> +			cpumask_and(cpus_attach, cpus_attach, cpu_active_mask);
> +		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
> +	}
>   
>   	cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
>   	cpuset1_update_task_spread_flags(cs, task);


