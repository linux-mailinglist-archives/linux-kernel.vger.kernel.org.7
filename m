Return-Path: <linux-kernel+bounces-730681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CFBB0480F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B17AD633
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340123182D;
	Mon, 14 Jul 2025 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8zZN4Lh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD22E630
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752522393; cv=none; b=QsD0qXYYcgnrSRbOLLwpz3WQibLF8BQdITBB8dDK45sdXXB0LdzGjgrlJFS8vxhy38Tb6XFvG9/HG2rf/fESwAQ+fCN+MmwCaRmRYiZsny9NdLOGDdeEhGgHH5XSJayZWAfDyzbZV2EcOSqRJnFcp2Vx67TQGMhOXs2kYInQth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752522393; c=relaxed/simple;
	bh=vQOqi9iZD6wccfid1TBvWsr440HmgFH1TPenVglGRzM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CvH6u9RFwuZHI2VyoC1GkLOzkKQApcr9yx2WyJQbbinJjLd02auWLHRHgLK8UKiCbXDe7Jk/nSz2qlpNowyScriJg1l1sf5LZJqx27VblVn6fBdLsXNo692ZvQykRXI3f5IXIWkUUSCEPCYXgAJYE3wFZ0KpRU6QGlDtyEgVGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8zZN4Lh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752522389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e77DmMCoRU1Wn+QB8qyXAVxRpVcBX5B1RuM9TG938xk=;
	b=E8zZN4LhfuUBVOabp0cyJg2x5+OHLSNljtTqdtwmc4ZBEhCZiACCNcmcIHv4Mr5gFPsXNN
	WdJV2URKt2AjGJSIZd1Xe30cHVU+LzP2aWw6h9/AKQvvOrFGilL3vftWEoCcFTqp+T+Shw
	TOwE2mCbAJrJRDO3t9454NfpVlF6UB8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-XkIw0RZPNBy-hoMkX_BeIQ-1; Mon, 14 Jul 2025 15:46:27 -0400
X-MC-Unique: XkIw0RZPNBy-hoMkX_BeIQ-1
X-Mimecast-MFC-AGG-ID: XkIw0RZPNBy-hoMkX_BeIQ_1752522387
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-704817522b9so72158356d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752522387; x=1753127187;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e77DmMCoRU1Wn+QB8qyXAVxRpVcBX5B1RuM9TG938xk=;
        b=coGKkHIO8uN/rwdeAzOVCgP/lMvas8HrjaVSpg/aVCu1PUco4DOLMvxRNT5WUCgTGS
         g8s0VrUXsAEzNESvd+7QP3lQyFgYcvzjUcQM43FnyygtyYJ+O3Yc3SNUJU3+yNuqMomA
         8Kvu0rh8GoJDlf9N1PQlY2qBiZ1WrCWr2pkHmYu6JJxlGxCKHNvAVz2TVbSIHQiPogYX
         CNH1bILcQNhGO2/m09j0feIl+QVp7S4YpYUV7La3gLKk3iaMHZG20JA/zErnQ4amxcfB
         zljhPieFUrDLz4JEy+KHXraSUjDcxBzZj66tXQFh2KwXpnBhthZXlMsV8A2ZB4PZfo+2
         Yxzw==
X-Forwarded-Encrypted: i=1; AJvYcCUzpVsMjoD9CjMhojRlTKpcPgXs9rHsANZJjYSexaWfnQNIYN3pj+ZnILxioXQXpch7Uq8Snqln/2fDytc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOEPMvRNWsc6tqG+qLHOr/bXaVjZQXlCdLoxZY2dDtyM0QsAvq
	hhov140RhBzB/ZQ2weBGa3OBQXMTUT0ouKoczcHcSu4GWx5DFS307XalgefXdMK22LrK74q1C7N
	hqw2y8V+NtVsZ4V8esCAeK+TYq2B3l4kVZAThXg22Nm7w5hsQjySUgYLIlHo0T2O4pg==
X-Gm-Gg: ASbGncuTNstZ/2Y6MN2eknYFQ3l2h6PfvevFlR5o8DQH+ur4UYOa6/ftGk5Ofvdplq4
	1JBZtV1uhd8piFC2WeLKJYKS8VGOf9QPUjyNGrkUO0HU7csGrzVz4SmcA0yBEp6h8kZMgzctKlC
	n+yQ7Y6w46F3Gsf+rRBHrk+4fkNaowzt75DGfxknuJlowKuZ78xPxJf34tyQeTATxJkdNaMNB+P
	njHndf/Ff3AH8O7ColNUYkDQSB1kSzm717tLi7XXzOaschgRhvUTvmPOLIuoOz12k44+Mb7/OSW
	V6NToWPhWuIWSKAclqtfsd8cWGh8etfghRU4oFj+Sd3hpFk41jTcgdHw5+S+FskcZCFiQthP+k3
	ZyXcD4xW3vg==
X-Received: by 2002:a05:6214:cc2:b0:704:7dfc:f56e with SMTP id 6a1803df08f44-704a3613b4dmr244553046d6.18.1752522386915;
        Mon, 14 Jul 2025 12:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElhu76RklpmkE20l9U4kG/pwoEeaDE5mQBdKQN+0kBAtrFc9uJ9PSyHoUopb1ufV0fL2J4VQ==
X-Received: by 2002:a05:6214:cc2:b0:704:7dfc:f56e with SMTP id 6a1803df08f44-704a3613b4dmr244552446d6.18.1752522386276;
        Mon, 14 Jul 2025 12:46:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d71424sm50382696d6.85.2025.07.14.12.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 12:46:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0dac8a78-79d1-41d0-bc82-0c8af8db9104@redhat.com>
Date: Mon, 14 Jul 2025 15:46:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: fix warning when attaching tasks with
 offline CPUs
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, peterz@infradead.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250714032311.3570157-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250714032311.3570157-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/13/25 11:23 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A kernel warning was observed in the cpuset migration path:
>
>      WARNING: CPU: 3 PID: 123 at kernel/cgroup/cpuset.c:3130
>      cgroup_migrate_execute+0x8df/0xf30
>      Call Trace:
>       cgroup_transfer_tasks+0x2f3/0x3b0
>       cpuset_migrate_tasks_workfn+0x146/0x3b0
>       process_one_work+0x5ba/0xda0
>       worker_thread+0x788/0x1220
>
> The issue can be reliably reproduced with:
>
>      # Setup test cpuset
>      mkdir /sys/fs/cgroup/cpuset/test
>      echo 2-3 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
>      echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
>
>      # Start test process
>      sleep 100 &
>      pid=$!
>      echo $pid > /sys/fs/cgroup/cpuset/test/cgroup.procs
>      taskset -p 0xC $pid  # Bind to CPUs 2-3
>
>      # Take CPUs offline
>      echo 0 > /sys/devices/system/cpu/cpu3/online
>      echo 0 > /sys/devices/system/cpu/cpu2/online
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
> The fix changes cpus_attach initialization to use cpu_active_mask
> instead of cpu_possible_mask, ensuring we only consider online CPUs
> when setting the new affinity. This prevents the scenario where
> the intersection would result in an invalid CPU set.
>
> Fixes: da019032819a ("sched: Enforce user requested affinity")
> Reported-by: Yang Lijin <yanglijin@huawei.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f74d04429a29..5401adbdffa6 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3121,7 +3121,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>   	if (cs != &top_cpuset)
>   		guarantee_active_cpus(task, cpus_attach);
>   	else
> -		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
> +		cpumask_andnot(cpus_attach, cpu_active_mask,
>   			       subpartitions_cpus);
>   	/*
>   	 * can_attach beforehand should guarantee that this doesn't

Offline CPUs are explicitly included for tasks in top_cpuset. Can you 
try the following patch to see if it works?

Thanks,
Longman

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3bc4301466f3..acd70120228c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3114,6 +3114,10 @@ static void cpuset_cancel_attach(struct 
cgroup_taskset *tset)
  static cpumask_var_t cpus_attach;
  static nodemask_t cpuset_attach_nodemask_to;

+/*
+ * Note that tasks in the top cpuset won't get update to their cpumasks 
when
+ * a hotplug event happens. So we include offline CPUs as well.
+ */
  static void cpuset_attach_task(struct cpuset *cs, struct task_struct 
*task)
  {
         lockdep_assert_held(&cpuset_mutex);
@@ -3127,7 +3131,16 @@ static void cpuset_attach_task(struct cpuset *cs, 
struct task_struct *task)
          * can_attach beforehand should guarantee that this doesn't
          * fail.  TODO: have a better way to handle failure here
          */
-       WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+       if (unlikely(set_cpus_allowed_ptr(task, cpus_attach))) {
+               /*
+                * Since offline CPUs are included for top_cpuset,
+                * set_cpus_allowed_ptr() can fail if user_cpus_ptr contains
+                * only offline CPUs. Take out the offline CPUs and retry.
+                */
+               if (cs == &top_cpuset)
+                       cpumask_and(cpus_attach, cpus_attach, 
cpu_active_mask);
+               WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+       }

         cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
         cpuset1_update_task_spread_flags(cs, task);


