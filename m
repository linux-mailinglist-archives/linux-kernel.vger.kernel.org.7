Return-Path: <linux-kernel+bounces-801135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E46EDB4403F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FFB188D595
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D6D3093A5;
	Thu,  4 Sep 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiUI9uF1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD72367DC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998888; cv=none; b=jBf/8CeiJz7um7rUTUrkZmowoXo0I/Y2CQg+TnZynOUbOP58BYFasI5hB3oLwiYuddE+P3bOFGVm4W9KINY3gJArDVBnjiB4lkBOZ52TQfkwkF64ZF2pUMjQana6u/pR4HEPiiEcrU4Qk2fRMGhBm5oTKQGX4BEPnpowWKz9o0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998888; c=relaxed/simple;
	bh=Es3xJgSyV5ubbFXim7HhW6chbOaw4tA+tA8z1d8jieQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dVLyPWGm4/cB8EJW8sF6dSgw9klyjla+DI7fCt+asu/Vcq+yskvsVGPA4fOL5t2PlT0SWsRKVDiL+f/oU0GE4uacTS8ey2GshkrTF+KHDXeVdHeIomM2e+3Mz8ILAiVxWKOmTQs12uMBFulqdEMT1oKJQBEpwlYGv/k+9daNEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NiUI9uF1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756998885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQcfxj93p9pyY/lE2JQrIRJoIbF3Xo19cf91KEKjQ5U=;
	b=NiUI9uF175do5ZAvGahNpqwLX8WoEN12w4MFHA4dnms31Hyh93hs89eGZsY6YjF0ltCdov
	rlK/oS1/JEhdNBlBS3MeZIx/P2vA9o0b1pOpO0txculJwnd4FZw8oqvqOhm42/Ndu+eiv9
	sMBnj1XsW74bLF3Ouk034Vz6arYIcD0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-N0cmT4nlNLuAqTBBjy_hQw-1; Thu, 04 Sep 2025 11:14:43 -0400
X-MC-Unique: N0cmT4nlNLuAqTBBjy_hQw-1
X-Mimecast-MFC-AGG-ID: N0cmT4nlNLuAqTBBjy_hQw_1756998882
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b47b4d296eso23968831cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998882; x=1757603682;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQcfxj93p9pyY/lE2JQrIRJoIbF3Xo19cf91KEKjQ5U=;
        b=kIFYbpyGFRXfTIVG9BiooJoLq2qYrxiO3NRmH+7EJJpK5N5uzoRRRNb4pTVkWUcE5u
         zWioEkVQWFXLudc1FfKjkJrSs5Ou9K0nIIvBDkziVs0Utsd3W7Urd8f0uGmKiIQIPiWk
         A++V1aaExYsViktr8760O67RsjEvvEtU+5yWJ7lDHaeJ0ZqQ24gweJLE0S7X0j8uYWq5
         /+WQstwb2QbsmC4BK0IgE1c1NJw/fLRb0Qad8NUHqksS/YcIGmAtsb7pBjO4ln6LJ5up
         umYbvf7sB5z8AdDvLiHVhNoxM5EnKzRhBxDqCzWcH3aGamlcfBcSDlKmoi7FQfUWCV1/
         sHiQ==
X-Gm-Message-State: AOJu0YxyUYT/C4386JzAONylxjmEUyY67wAxgbrnVWJ0OkaT1TByHqoq
	w20rrcmhaWIIO/LVUm/BiAAVze4UswUkZwEF99uxX/hgUXvi4R8DYo6bynDz1Bf0LyitZBHi3j0
	z6UXBzNMDXXV5O6A239aK9q4qN71Z79CngK0Cdj9lxpORi/0ndEdcrFz1Iq7vpxiitg==
X-Gm-Gg: ASbGncvlaJGkfXU39Ek9NXAJSIJsBYx1Ft0GLZryecyFZjvLF3BX6qA4hKVTYzmldFx
	XjuAJS9r0gFlVbBB4jbqCrbIuX/Y+JiXq8FvVIqRs2yu0TKp6OVkfEOX5rOvl/1GfQTzUSBtIK4
	4V1BH6hIAsVZEzpbpl7pKhmecdcfMzink0qbBMD2ns6ADa8vlwOaBgvDTw6exNYRkNFlaqvO45Z
	keASvuGgDHDsU3dYdzIbPU7Uf5KNc/SX0/VkDgtMv+OT1usO/kJ8sbAsLiRExz0H6XBLTcjhp9/
	zDkDHSD2ka32JGlg3elovAfTnIbxvsghQozMFr6yLOY9vNpAZ+dKaueMC5w9QkPKapRxeE4JUx9
	Js6nYwvqphA==
X-Received: by 2002:ac8:7c54:0:b0:4b5:e5fc:949f with SMTP id d75a77b69052e-4b5e5fc960emr8583141cf.5.1756998882203;
        Thu, 04 Sep 2025 08:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF28DqFWEmqSrhb8wDFbh16otq/iXi+zIimbsE7P+Oyk9KAyLBrF/7M/3xl6RwOVgVrWtGBFA==
X-Received: by 2002:ac8:7c54:0:b0:4b5:e5fc:949f with SMTP id d75a77b69052e-4b5e5fc960emr8582391cf.5.1756998881603;
        Thu, 04 Sep 2025 08:14:41 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b55cf6c9sm48747136d6.49.2025.09.04.08.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 08:14:40 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b8a37b7f-839d-4456-b157-6ea7f59fec1a@redhat.com>
Date: Thu, 4 Sep 2025 11:14:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cpuset: Defer flushing of the cpuset_migrate_mm_wq to
 task_work
To: Chuyi Zhou <zhouchuyi@bytedance.com>, tj@kernel.org, mkoutny@suse.com,
 hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org
References: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
 <20250904074505.1722678-3-zhouchuyi@bytedance.com>
Content-Language: en-US
In-Reply-To: <20250904074505.1722678-3-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/25 3:45 AM, Chuyi Zhou wrote:
> Now in cpuset_attach(), we need to synchronously wait for
> flush_workqueue to complete. The execution time of flushing
> cpuset_migrate_mm_wq depends on the amount of mm migration initiated by
> cpusets at that time. When the cpuset.mems of a cgroup occupying a large
> amount of memory is modified, it may trigger extensive mm migration,
> causing cpuset_attach() to block on flush_workqueue for an extended period.
> This could be dangerous because cpuset_attach() is within the critical
> section of cgroup_mutex, which may ultimately cause all cgroup-related
> operations in the system to be blocked.
>
> This patch attempts to defer the flush_workqueue() operation until
> returning to userspace using the task_work which is originally proposed by
> tejun[1], so that flush happens after cgroup_mutex is dropped. That way we
> maintain the operation synchronicity while avoiding bothering anyone else.
>
> [1]: https://lore.kernel.org/cgroups/ZgMFPMjZRZCsq9Q-@slm.duckdns.org/T/#m117f606fa24f66f0823a60f211b36f24bd9e1883
>
> Originally-by: tejun heo <tj@kernel.org>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   kernel/cgroup/cpuset.c | 29 ++++++++++++++++++++++++-----
>   1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3d8492581c8c4..ceb467079e41f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -40,6 +40,7 @@
>   #include <linux/sched/isolation.h>
>   #include <linux/wait.h>
>   #include <linux/workqueue.h>
> +#include <linux/task_work.h>
>   
>   DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
>   DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
> @@ -2582,9 +2583,24 @@ static void cpuset_migrate_mm(struct mm_struct *mm, const nodemask_t *from,
>   	}
>   }
>   
> -static void cpuset_post_attach(void)
> +static void flush_migrate_mm_task_workfn(struct callback_head *head)
>   {
>   	flush_workqueue(cpuset_migrate_mm_wq);
> +	kfree(head);
> +}
> +
> +static void schedule_flush_migrate_mm(void)
> +{
> +	struct callback_head *flush_cb;
> +
> +	flush_cb = kzalloc(sizeof(struct callback_head), GFP_KERNEL);
> +	if (!flush_cb)
> +		return;
> +
> +	init_task_work(flush_cb, flush_migrate_mm_task_workfn);
> +
> +	if (task_work_add(current, flush_cb, TWA_RESUME))
> +		kfree(flush_cb);
>   }
>   
>   /*
> @@ -3141,6 +3157,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   	struct cpuset *cs;
>   	struct cpuset *oldcs = cpuset_attach_old_cs;
>   	bool cpus_updated, mems_updated;
> +	bool queue_task_work = false;
>   
>   	cgroup_taskset_first(tset, &css);
>   	cs = css_cs(css);
> @@ -3191,15 +3208,18 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>   			 * @old_mems_allowed is the right nodesets that we
>   			 * migrate mm from.
>   			 */
> -			if (is_memory_migrate(cs))
> +			if (is_memory_migrate(cs)) {
>   				cpuset_migrate_mm(mm, &oldcs->old_mems_allowed,
>   						  &cpuset_attach_nodemask_to);
> -			else
> +				queue_task_work = true;
> +			} else
>   				mmput(mm);
>   		}
>   	}
>   
>   out:
> +	if (queue_task_work)
> +		schedule_flush_migrate_mm();
>   	cs->old_mems_allowed = cpuset_attach_nodemask_to;
>   
>   	if (cs->nr_migrate_dl_tasks) {
> @@ -3257,7 +3277,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	mutex_unlock(&cpuset_mutex);
>   	cpus_read_unlock();
>   	if (of_cft(of)->private == FILE_MEMLIST)
> -		flush_workqueue(cpuset_migrate_mm_wq);
> +		schedule_flush_migrate_mm();
>   	return retval ?: nbytes;
>   }
>   
> @@ -3725,7 +3745,6 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
>   	.can_attach	= cpuset_can_attach,
>   	.cancel_attach	= cpuset_cancel_attach,
>   	.attach		= cpuset_attach,
> -	.post_attach	= cpuset_post_attach,
>   	.bind		= cpuset_bind,
>   	.can_fork	= cpuset_can_fork,
>   	.cancel_fork	= cpuset_cancel_fork,
Reviewed-by:  Waiman Long <longman@redhat.com>


