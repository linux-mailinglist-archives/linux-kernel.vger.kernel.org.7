Return-Path: <linux-kernel+bounces-611374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 991DBA940FB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 04:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D8C189E2CF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 02:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34DE7082A;
	Sat, 19 Apr 2025 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y14edkmc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7541F956
	for <linux-kernel@vger.kernel.org>; Sat, 19 Apr 2025 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745028409; cv=none; b=AETGEYf0mfcsebHINfZV1LvbvA70W8lBJbZ1oK030zh+er4wEz9daHLHw4WFciM/64uqX0QRdlow4VipFeeaSkKhEGpJYmbm0l5DsHR+sMJSX/i4Lu1Q7GvIs3IRP+hSkY0MCaqKhj+gmlbUIMJdCxk9i9+J532HM5zQVaDXc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745028409; c=relaxed/simple;
	bh=J8edkT/dlhLbGssrkoyx6Tobg+gIJo+zAqjLwecFDA4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bbkw6A58S/4XDsmnNFYunctHyqx65Zp+2a9uohTuxTHwPIdZFMM27TqH1WoTK9uwYfd2x3Tn5G3JxjkfHCes5Kfh2pmWpfddH/sUCtzN/y5woz1tamncfRpN9yYeeuwo5H455B72nC+l0oRHKgEK1u+gYiFOe+LuOBqQWhccpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y14edkmc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745028405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fg5jTz0E8wfSFW3z1gz+claCWc6uoPxGD1UaNbxQo8M=;
	b=Y14edkmcvISSCIxXaciN3kcDGQz+/Ji5+Q4q9CCHCsb+K5IlRvvzyd4Fjn8194qM4SxeKt
	NUoaPGET8qiwSftktsKJIK3OP4z8tQQaE2bPHod/j6caLbGFhwxwC+jC9nQhVUWQwDUepu
	7RX+2Z1o3iTikM+Z6YmigRZtovESESY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-uXQNRMLdP0eEYxrpxRtOlA-1; Fri, 18 Apr 2025 22:06:44 -0400
X-MC-Unique: uXQNRMLdP0eEYxrpxRtOlA-1
X-Mimecast-MFC-AGG-ID: uXQNRMLdP0eEYxrpxRtOlA_1745028403
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5750ca8b2so332447585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 19:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745028403; x=1745633203;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg5jTz0E8wfSFW3z1gz+claCWc6uoPxGD1UaNbxQo8M=;
        b=g5gIuEIEU9nbUPzzD59lZQQmFWLPazZcSBXHUyDGflTg9gAivdzxvduv0+eIt/nXSI
         MTWQT295fBiFj5lR1wyuAxXAJiYOeFwaX5LfRT6VgQSqM15dqyFrOSKHcJYV9DRjqYbs
         4mB2rsp0w3hZhPDqjhAXmTVF/wiXmc0IBC13kcwWDbY8XeV8HWlJHsszlClTJq4a8kcv
         IuEwU1x44os0tciW6PzGnju+eYN2/DbvrwgjsOQyTZxWPOXQsCYyD6CXbKsvQZG8eMME
         qLnJmPi9WiuMIoSqp47CEwcZOZrNnMyiNoYp8hV1N26E9Y1Cnp8SDdtESn4ydwiGTjEO
         uKQg==
X-Forwarded-Encrypted: i=1; AJvYcCWWs6o+gIQHwh5JISn/I0v09AB+L9MEy0PmiWyhTR6YnZnPHK1caqWNWFBW0toc421vPLdT/ZZ+qlw44I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQGJdPJav1rqayWWjsU9iTbS8bi4oISN8WBgfaa0FSCeMyH6Gj
	6bG35oAG/iYlrTa+bi7IhVR8Q9jdA7tESolDQ7wuwYqk+mHzygXcKzXbsxJYplZ8kqdoqq2oZea
	NQ530SoHQDEELkfTPvGgWyC7uSxm7f344CJlbqRW3zK9HY2sknm4/NcJdTKo4Xg==
X-Gm-Gg: ASbGncsJXeOmRuHt1pggr6KO6/x4xMkRnegG5MO3KjNSLB8Dt4+RSpEPwpcn31RR6kK
	89tMUzQdntdZWW945hZnHaq0UoJNlcS/e3F/ugIVf4az9rFGv6w/zZNWrGit+i4VMupjYpaPVGv
	VZZCni4uO7BUykBmx09NBdS6CqZEGWLP0WLJ9eXV09qeVmG8OUjE8lyjln8o+E0nWlzQ4oS0iVR
	iTgnU9Fr1ziQMiJFDU4Z6bOlqAH0LbA9RhnpEr9URjoG9cl3mtfKPXHIXLW4ZEBLCHkqdrPG8FC
	a0M/HkTD6kgyCLjEkNnXcabtXtlvCAHDg+tz5zKoDsEVGta4Tg==
X-Received: by 2002:a05:620a:1a88:b0:7c5:4caa:21b7 with SMTP id af79cd13be357-7c928049e4fmr805917685a.56.1745028403368;
        Fri, 18 Apr 2025 19:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Vva5HgQYqt3HAguwTyJTqtBqylBMgw/o808p/lVSAP69/kKkHthGT+f5tt9sh/5MY+qQTg==
X-Received: by 2002:a05:620a:1a88:b0:7c5:4caa:21b7 with SMTP id af79cd13be357-7c928049e4fmr805915785a.56.1745028402963;
        Fri, 18 Apr 2025 19:06:42 -0700 (PDT)
Received: from [192.168.130.170] (67-212-218-66.static.pfnllc.net. [67.212.218.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a90ce7sm167726485a.47.2025.04.18.19.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 19:06:42 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <162f1ae4-2adf-4133-8de4-20f240e5469e@redhat.com>
Date: Fri, 18 Apr 2025 22:06:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vmscan,cgroup: apply mems_effective to reclaim
To: Gregory Price <gourry@gourry.net>, cgroups@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 akpm@linux-foundation.org
References: <20250418031352.1277966-1-gourry@gourry.net>
 <20250418031352.1277966-2-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20250418031352.1277966-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/25 11:13 PM, Gregory Price wrote:
> It is possible for a reclaimer to cause demotions of an lruvec belonging
> to a cgroup with cpuset.mems set to exclude some nodes. Attempt to apply
> this limitation based on the lruvec's memcg and prevent demotion.
>
> Notably, this may still allow demotion of shared libraries or any memory
> first instantiated in another cgroup. This means cpusets still cannot
> cannot guarantee complete isolation when demotion is enabled, and the
> docs have been updated to reflect this.
>
> This is useful for isolating workloads on a multi-tenant system from
> certain classes of memory more consistently - with the noted exceptions.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   .../ABI/testing/sysfs-kernel-mm-numa          | 14 ++++---
>   include/linux/cgroup.h                        |  7 ++++
>   include/linux/cpuset.h                        |  5 +++
>   include/linux/memcontrol.h                    |  9 ++++
>   kernel/cgroup/cgroup.c                        |  5 +++
>   kernel/cgroup/cpuset.c                        | 22 ++++++++++
>   mm/vmscan.c                                   | 41 +++++++++++--------
>   7 files changed, 82 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> index 77e559d4ed80..27cdcab901f7 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-numa
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> @@ -16,9 +16,13 @@ Description:	Enable/disable demoting pages during reclaim
>   		Allowing page migration during reclaim enables these
>   		systems to migrate pages from fast tiers to slow tiers
>   		when the fast tier is under pressure.  This migration
> -		is performed before swap.  It may move data to a NUMA
> -		node that does not fall into the cpuset of the
> -		allocating process which might be construed to violate
> -		the guarantees of cpusets.  This should not be enabled
> -		on systems which need strict cpuset location
> +		is performed before swap if an eligible numa node is
> +		present in cpuset.mems for the cgroup. If cpusets.mems
> +		changes at runtime, it may move data to a NUMA node that
> +		does not fall into the cpuset of the new cpusets.mems,
> +		which might be construed to violate the guarantees of
> +		cpusets.  Shared memory, such as libraries, owned by
> +		another cgroup may still be demoted and result in memory
> +		use on a node not present in cpusets.mem. This should not
> +		be enabled on systems which need strict cpuset location
>   		guarantees.
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index f8ef47f8a634..2915250a3e5e 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -632,6 +632,8 @@ static inline void cgroup_kthread_ready(void)
>   
>   void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
>   struct cgroup *cgroup_get_from_id(u64 id);
> +
> +extern bool cgroup_node_allowed(struct cgroup *cgroup, int nid);
>   #else /* !CONFIG_CGROUPS */
>   
>   struct cgroup_subsys_state;
> @@ -681,6 +683,11 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
>   
>   static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
>   {}
> +
> +static inline bool cgroup_node_allowed(struct cgroup *cgroup, int nid)
> +{
> +	return true;
> +}
>   #endif /* !CONFIG_CGROUPS */
>   
>   #ifdef CONFIG_CGROUPS
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 893a4c340d48..c64b4a174456 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -171,6 +171,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>   	task_unlock(current);
>   }
>   
> +extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
>   #else /* !CONFIG_CPUSETS */
>   
>   static inline bool cpusets_enabled(void) { return false; }
> @@ -282,6 +283,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>   	return false;
>   }
>   
> +static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +{
> +	return false;
> +}
>   #endif /* !CONFIG_CPUSETS */
>   
>   #endif /* _LINUX_CPUSET_H */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 53364526d877..2906e4bb12e9 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1736,6 +1736,11 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
>   	rcu_read_unlock();
>   }
>   
> +static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> +{
> +	return memcg ? cgroup_node_allowed(memcg->css.cgroup, nid) : true;
> +}
> +
>   #else
>   static inline bool mem_cgroup_kmem_disabled(void)
>   {
> @@ -1793,6 +1798,10 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
>   {
>   }
>   
> +static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> +{
> +	return true;
> +}
>   #endif /* CONFIG_MEMCG */
>   
>   #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index afc665b7b1fe..ba0b90cd774c 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -7038,6 +7038,11 @@ int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
>   	return 0;
>   }
>   
> +bool cgroup_node_allowed(struct cgroup *cgroup, int nid)
> +{
> +	return cpuset_node_allowed(cgroup, nid);
> +}
> +
>   /*
>    * sock->sk_cgrp_data handling.  For more info, see sock_cgroup_data
>    * definition in cgroup-defs.h.
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d6ed3f053e62..31e4c4cbcdfc 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4163,6 +4163,28 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>   	return allowed;
>   }
>   
> +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +{
> +	struct cgroup_subsys_state *css;
> +	unsigned long flags;
> +	struct cpuset *cs;
> +	bool allowed;
> +
> +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> +	if (!css)
> +		return true;
> +
> +	cs = container_of(css, struct cpuset, css);
> +	spin_lock_irqsave(&callback_lock, flags);
> +	/* At least one parent must have a valid node list */
> +	while (nodes_empty(cs->effective_mems))
> +		cs = parent_cs(cs);

For cgroup v2, effective_mems should always be set and walking up the 
tree isn't necessary. For v1, it can be empty, but memory cgroup and 
cpuset are unlikely in the same hierarchy.

Cheers,
Longman


