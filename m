Return-Path: <linux-kernel+bounces-860012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 955B6BEF22A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3604F4E9450
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A123229B77E;
	Mon, 20 Oct 2025 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfmuYfc2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5ED29ACC3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929089; cv=none; b=DoEu7zwg8MWV5NIZptEPEqJqlREefJbdipR8nmkw0vlsUsIzzOYyPPsdxA1dIp7/qOH9so2jDe7k2yuAA79Y7v/sTROk/ljZ74QhQNa3vMsJp0OpqPR89TFY9mwzmCnMGITvIHjvfGo61RCTpGH6NIabTw/BA5uwJznEMhNAPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929089; c=relaxed/simple;
	bh=EWmvzyLTmCu7mh578Qmd7yMylN1LmR7oK7sJObRqmiU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nbr7neV9ZruijxDTiEFqTh9JNHtV+5UilOm69pR9JEuaknKJNcVNKYSrvzTm4tGM+DKG0FAcWk4Mogop7sMYYBaBI/53STJUVPyet07LbqwJt1CQrR8jNKkU8ER5CVm6g0ACFsTqJ8bbNnhK9wPLRUO/+mWLPf8mMoXIB7HT3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfmuYfc2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760929086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4O+nIUmfTz6JULGHDolX9ZYDJ4L1CoH/69z6aydnVWU=;
	b=LfmuYfc2Wyjt/ewYwNGLTxaYhPIDPTlNmjb2B78oDDcs9knlmdlyeWcx178PiNTOsJipI3
	ZLIqWHldORYwak/CQ50jC79XKQHdhiOZod2OQpxBkW3mkgy1Csw9Qp1XInamBAKq2i0N/y
	0kP3pZEx7TenJVT2xQ/zMy40U2UOB3g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-UHbJik80Pvaa5yyNa24fow-1; Sun, 19 Oct 2025 22:58:02 -0400
X-MC-Unique: UHbJik80Pvaa5yyNa24fow-1
X-Mimecast-MFC-AGG-ID: UHbJik80Pvaa5yyNa24fow_1760929082
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c20035ad3so112538616d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760929082; x=1761533882;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4O+nIUmfTz6JULGHDolX9ZYDJ4L1CoH/69z6aydnVWU=;
        b=Q3Y6E51ZrxJ9EvMmiSvwmzXsVdMLwAcXIrGYOZ9FH2Cql5qtlkhlKPos7k/3wBSan5
         LUFioMW5kFD6sPbi2hGjJWZoCg6GRoCZ1BxPGXTGkSP4dE06dghvloqq21DleNnFMqa1
         EeWhz1Aa+eJh5J4d39HJhSsmjqkIRU1somUUNgk0uhHnXeh7EoMvZvjP2GdRF0tyh+vo
         4riXpZwFTr7v3ThWo+fwJNQlAFHeUp1mjGukpTchB1DLnyTkAZZfd/pjgmfYyVFpCMAr
         vfrMHzUVICEs4JpO54/1kmg8AGnXwLvaQpCL0sfrZDTsmwILhV+gNMUPT44qBI4GJ2nn
         OrDA==
X-Forwarded-Encrypted: i=1; AJvYcCUsQ+EYYhWgsOF7GVBJX2toQ/BciqQohKdOTmvPwqcob+qcaKhhQVmRaMQm1gmUcVxLKB4d3yFDQx/euMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzct7g1Pct+BtUNFBalrsjsyhoxkWxBr35vk0lC+krJyqfbUyxk
	sKkb4qKFCjpYj8lNXnWQ1k8vsWDQ/LW8VuEGFvtJCIT9qK05//eg0fVFCIbWhTQI/2rSfTLo6an
	x2Z2eQ6Joth+SLzOt9BDKK4g4DuhHJHQM0rDPURNu8eJw72gNjSlsPaCYjW6Alvn2VA==
X-Gm-Gg: ASbGncsi6n+X4T8wCD2BgQngKz0znHv39ItdTZM0AYDnPJwcg2RJwEXtSfosuMgQncd
	ZunSvNHLMFFbq1vMM2eQPu6xcVDv4iqQGdnoXeSUunvhXRwqySqWUCO6cvGFryM4l4/wHA+elY8
	LFo1fCh8LVZWAY2yhok8Navlf9XdPDGuUFAM4tgpMJowxhSwVy4MyLTh/jlPRqxVLlTSKb+VGZT
	mJQ+jOBAaDjvQXz8TsUUFIm5REQR8HGjbm6MSQqi8+sqe2NslLH8bJRtTT1uj2OuFduxt537aWu
	tqJkeYPYGMU8htPKV5dn1JFAnY1lkNEoA1QVguJjH6NmybAOrUTEBSk4UjKALGGcSbKrAdzKNIp
	iIIAaWDDfgKaPx7YFAGm0SyuhllZg9yJDqD4d1Qc2sZRxiw==
X-Received: by 2002:a05:6214:3009:b0:788:82e0:3a9 with SMTP id 6a1803df08f44-87c202b3aa2mr109189376d6.21.1760929081981;
        Sun, 19 Oct 2025 19:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5+lmNwUUqV1pvAgY7Y9DSWnPsQF5gc9KvMinCgkCaZdnm7g0ocAwmn+afOyNKp1Wf1od7gA==
X-Received: by 2002:a05:6214:3009:b0:788:82e0:3a9 with SMTP id 6a1803df08f44-87c202b3aa2mr109189276d6.21.1760929081423;
        Sun, 19 Oct 2025 19:58:01 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8d0f2sm42520796d6.56.2025.10.19.19.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 19:58:00 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9a6a1e0e-e96e-4afe-bd10-113e76a8dfc0@redhat.com>
Date: Sun, 19 Oct 2025 22:57:59 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 09/16] cpuset: introduce
 local_partition_update()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-10-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-10-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/28/25 3:12 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Extend the partition_update() infrastructure to handle local partition
> updates.
>
> The local_partition_update() function replaces the command partcmd_update
> previously handled within update_parent_effective_cpumask(). The update
> logic follows a state-based approach:
>
> 1. Validation check: First verify if the local partition is currently valid
> 2. Invalidation handling: If the partition is invalid, trigger invalidation
> 3. State transition: If an invalid partition has no errors, transition to
>     valid
> 4. cpus updates: For local partition that only cpu maks changes, use
"cpu mask"?
>     partition_update() to handle partition change.
>
> With the introduction of this function, update_parent_effective_cpumask()
> function is removed, simplifying the partition update code path and
> creating a cleaner separation between local and remote partition
> operations.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 376 +++++++++++++----------------------------
>   1 file changed, 122 insertions(+), 254 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e460d03286ba..d0217db04b69 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1622,12 +1622,14 @@ static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
>   	bool isolcpus_updated;
>   	bool excl_updated;
>   	struct cpuset *parent;
> +	int old_prs;
>   
>   	lockdep_assert_held(&cpuset_mutex);
>   	WARN_ON_ONCE(!cpuset_v2());
>   	WARN_ON_ONCE(prs <= 0);
>   
>   	parent = is_remote_partition(cs) ? NULL : parent_cs(cs);
> +	old_prs = cs->partition_root_state;
>   	excl_updated = !cpumask_empty(tmp->addmask) ||
>   			!cpumask_empty(tmp->delmask);
>   
> @@ -1645,6 +1647,8 @@ static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
>   	update_unbound_workqueue_cpumask(isolcpus_updated);
>   	if (excl_updated)
>   		cpuset_force_rebuild();
> +	update_partition_exclusive_flag(cs, prs);
> +	notify_partition_change(cs, old_prs);
>   }
>   

Again, change to partition_update() should be done in the patch that 
introduces it.

>   /*
> @@ -1790,6 +1794,27 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>   	return false;
>   }
>   
> +static bool cpuset_user_cpus_exclusive(struct cpuset *cs)

The cpuset prefix is only needed if it is an externally visible 
function. For this one, I think a better name should be 
"is_user_xcpus_exclusive".

> +{
> +	struct cpuset *parent = parent_cs(cs);
> +
> +	struct cgroup_subsys_state *css;
> +	struct cpuset *child;
> +	bool exclusive = true;
> +
> +	rcu_read_lock();
> +	cpuset_for_each_child(child, css, parent) {
> +		if (child == cs)
> +			continue;
> +		if (!cpusets_are_exclusive(cs, child)) {
> +			exclusive = false;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return exclusive;
> +}
> +
>   /**
>    * validate_partition - Validate a cpuset partition configuration
>    * @cs: The cpuset to validate
> @@ -1818,6 +1843,39 @@ static enum prs_errcode validate_partition(struct cpuset *cs, int new_prs,
>   	return PERR_NONE;
>   }
>   
> +/**
> + * local_partition_check - Validate for local partition
> + * @cs: Target cpuset to validate
> + * @new_prs: New partition root state to validate
> + * @excpus: New exclusive effectuve CPUs mask to validate
> + * @excl_check: Flag to enable exclusive CPUs ownership validation
> + *
> + * Return: PERR_NONE if validation passes, appropriate error code otherwise
> + *
> + * Important: The caller must ensure that @cs's cpu mask is updated before
> + * invoking this function when exclusive CPU validation is required.
> + */
> +static enum prs_errcode local_partition_check(struct cpuset *cs, int new_prs,
> +							 struct cpumask *excpus, bool excl_check)

I would suggest naming it to "validate_local_partition()" as the local 
counterpart of validate_partition().

> +{
> +	struct cpuset *parent = parent_cs(cs);
> +
> +	/*
> +	 * The parent must be a partition root.
> +	 * The new cpumask, if present, or the current cpus_allowed must
> +	 * not be empty.
> +	 */
> +	if (!is_partition_valid(parent)) {
> +		return is_partition_invalid(parent)
> +			? PERR_INVPARENT : PERR_NOTPART;
> +	}
> +
> +	if (excl_check && !cpuset_user_cpus_exclusive(cs))
> +		return PERR_NOTEXCL;
> +
> +	return validate_partition(cs, new_prs, excpus);
> +}
> +
>   /**
>    * local_partition_enable - Enable local partition for a cpuset
>    * @cs: Target cpuset to become a local partition root
> @@ -1945,280 +2003,85 @@ static void local_partition_invalidate(struct cpuset *cs, struct tmpmasks *tmp)
>   }
>   
>   /**
> - * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
> - * @cs:      The cpuset that requests change in partition root state
> - * @cmd:     Partition root state change command
> - * @newmask: Optional new cpumask for partcmd_update
> - * @tmp:     Temporary addmask and delmask
> - * Return:   0 or a partition root state error code
> - *
> - * For partcmd_enable*, the cpuset is being transformed from a non-partition
> - * root to a partition root. The effective_xcpus (cpus_allowed if
> - * effective_xcpus not set) mask of the given cpuset will be taken away from
> - * parent's effective_cpus. The function will return 0 if all the CPUs listed
> - * in effective_xcpus can be granted or an error code will be returned.
> - *
> - * For partcmd_disable, the cpuset is being transformed from a partition
> - * root back to a non-partition root. Any CPUs in effective_xcpus will be
> - * given back to parent's effective_cpus. 0 will always be returned.
> + * __local_partition_update - Update local CPU partition configuration
> + * @cs: Target cpuset to update
> + * @xcpus: New exclusive CPU mask
> + * @excpus: New effective exclusive CPU mask
> + * @tmp: Temporary mask storage for intermediate calculations
> + * @excl_check: Flag to enable exclusivity validation
>    *
> - * For partcmd_update, if the optional newmask is specified, the cpu list is
> - * to be changed from effective_xcpus to newmask. Otherwise, effective_xcpus is
> - * assumed to remain the same. The cpuset should either be a valid or invalid
> - * partition root. The partition root state may change from valid to invalid
> - * or vice versa. An error code will be returned if transitioning from
> - * invalid to valid violates the exclusivity rule.
> + * Handles updates to local CPU partition configurations by validating
> + * changes, managing state transitions, and propagating updates through
> + * the cpuset hierarchy.
>    *
> - * For partcmd_invalidate, the current partition will be made invalid.
> + * Note on exclusivity checking: Exclusivity validation is required when
> + * transitioning from an invalid to valid partition state. However, when
> + * updating cpus_allowed or exclusive_cpus, exclusivity should have already
> + * been verified by validate_change(). In such cases, excl_check must be
> + * false since the cs cpumasks are not yet updated.
>    *
> - * The partcmd_enable* and partcmd_disable commands are used by
> - * update_prstate(). An error code may be returned and the caller will check
> - * for error.
> - *
> - * The partcmd_update command is used by update_cpumasks_hier() with newmask
> - * NULL and update_cpumask() with newmask set. The partcmd_invalidate is used
> - * by update_cpumask() with NULL newmask. In both cases, the callers won't
> - * check for error and so partition_root_state and prs_err will be updated
> - * directly.
> + * Return: Partition error code (PERR_NONE indicates success)
>    */
> -static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
> -					   struct cpumask *newmask,
> -					   struct tmpmasks *tmp)
Separate out the removal of update_parent_effective_cpumask() into its 
own patch as intermixing the removal of this code and new code make it 
harder to review.

> +static int __local_partition_update(struct cpuset *cs, struct cpumask *xcpus,
> +				  struct cpumask *excpus, struct tmpmasks *tmp,
> +				  bool excl_check)
>   {
>   	struct cpuset *parent = parent_cs(cs);
> -	int adding;	/* Adding cpus to parent's effective_cpus	*/
> -	int deleting;	/* Deleting cpus from parent's effective_cpus	*/
> -	int old_prs, new_prs;
>   	int part_error = PERR_NONE;	/* Partition error? */
> -	int subparts_delta = 0;
> -	int isolcpus_updated = 0;
> -	struct cpumask *xcpus = user_xcpus(cs);
> -	bool nocpu;
> +	int old_prs, new_prs;
> +	bool cpumask_updated = false;
>   
>   	lockdep_assert_held(&cpuset_mutex);
> -	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
> +	/* For local partition only */
> +	if (WARN_ON_ONCE(is_remote_partition(cs) || cs_is_member(cs)))
> +		return PERR_NONE;
>   
> +	old_prs = cs->partition_root_state;
>   	/*
> -	 * new_prs will only be changed for the partcmd_update and
> -	 * partcmd_invalidate commands.
> +	 * If new_prs < 0, it might transition to valid partition state.
> +	 * Use absolute value for validation checks.
>   	 */
> -	adding = deleting = false;
> -	old_prs = new_prs = cs->partition_root_state;
> -
> -	/*
> -	 * The parent must be a partition root.
> -	 * The new cpumask, if present, or the current cpus_allowed must
> -	 * not be empty.
> -	 */
> -	if (!is_partition_valid(parent)) {
> -		return is_partition_invalid(parent)
> -		       ? PERR_INVPARENT : PERR_NOTPART;
> -	}
> -	if (!newmask && xcpus_empty(cs))
> -		return PERR_CPUSEMPTY;
> -
> -	nocpu = tasks_nocpu_error(parent, cs, xcpus);
> -
> -	if (newmask) {
> -		/*
> -		 * Empty cpumask is not allowed
> -		 */
> -		if (cpumask_empty(newmask)) {
> -			part_error = PERR_CPUSEMPTY;
> -			goto write_error;
> -		}
> -
> -		/* Check newmask again, whether cpus are available for parent/cs */
> -		nocpu |= tasks_nocpu_error(parent, cs, newmask);
> -
> -		/*
> -		 * partcmd_update with newmask:
> -		 *
> -		 * Compute add/delete mask to/from effective_cpus
> -		 *
> -		 * For valid partition:
> -		 *   addmask = exclusive_cpus & ~newmask
> -		 *			      & parent->effective_xcpus
> -		 *   delmask = newmask & ~exclusive_cpus
> -		 *		       & parent->effective_xcpus
> -		 *
> -		 * For invalid partition:
> -		 *   delmask = newmask & parent->effective_xcpus
> -		 */
> -		if (is_partition_invalid(cs)) {
> -			adding = false;
> -			deleting = cpumask_and(tmp->delmask,
> -					newmask, parent->effective_xcpus);
> -		} else {
> -			cpumask_andnot(tmp->addmask, xcpus, newmask);
> -			adding = cpumask_and(tmp->addmask, tmp->addmask,
> -					     parent->effective_xcpus);
> -
> -			cpumask_andnot(tmp->delmask, newmask, xcpus);
> -			deleting = cpumask_and(tmp->delmask, tmp->delmask,
> -					       parent->effective_xcpus);
> -		}
> -		/*
> -		 * The new CPUs to be removed from parent's effective CPUs
> -		 * must be present.
> -		 */
> -		if (deleting) {
> -			cpumask_and(tmp->new_cpus, tmp->delmask, cpu_active_mask);
> -			WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, parent->effective_cpus));
> -		}
> -
> -		/*
> -		 * Make partition invalid if parent's effective_cpus could
> -		 * become empty and there are tasks in the parent.
> -		 */
> -		if (nocpu && (!adding ||
> -		    !cpumask_intersects(tmp->addmask, cpu_active_mask))) {
> -			part_error = PERR_NOCPUS;
> -			deleting = false;
> -			adding = cpumask_and(tmp->addmask,
> -					     xcpus, parent->effective_xcpus);
> -		}
> -	} else {
> -		/*
> -		 * partcmd_update w/o newmask
> -		 *
> -		 * delmask = effective_xcpus & parent->effective_cpus
> -		 *
> -		 * This can be called from:
> -		 * 1) update_cpumasks_hier()
> -		 * 2) cpuset_hotplug_update_tasks()
> -		 *
> -		 * Check to see if it can be transitioned from valid to
> -		 * invalid partition or vice versa.
> -		 *
> -		 * A partition error happens when parent has tasks and all
> -		 * its effective CPUs will have to be distributed out.
> -		 */
> -		if (nocpu) {
> -			part_error = PERR_NOCPUS;
> -			if (is_partition_valid(cs))
> -				adding = cpumask_and(tmp->addmask,
> -						xcpus, parent->effective_xcpus);
> -		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
> -			   cpumask_subset(xcpus, parent->effective_xcpus)) {
> -			struct cgroup_subsys_state *css;
> -			struct cpuset *child;
> -			bool exclusive = true;
> -
> -			/*
> -			 * Convert invalid partition to valid has to
> -			 * pass the cpu exclusivity test.
> -			 */
> -			rcu_read_lock();
> -			cpuset_for_each_child(child, css, parent) {
> -				if (child == cs)
> -					continue;
> -				if (!cpusets_are_exclusive(cs, child)) {
> -					exclusive = false;
> -					break;
> -				}
> -			}
> -			rcu_read_unlock();
> -			if (exclusive)
> -				deleting = cpumask_and(tmp->delmask,
> -						xcpus, parent->effective_cpus);
> -			else
> -				part_error = PERR_NOTEXCL;
> -		}
> -	}
> -
> -write_error:
> -	if (part_error)
> -		WRITE_ONCE(cs->prs_err, part_error);
> -
> -	if (cmd == partcmd_update) {
> -		/*
> -		 * Check for possible transition between valid and invalid
> -		 * partition root.
> -		 */
> -		switch (cs->partition_root_state) {
> -		case PRS_ROOT:
> -		case PRS_ISOLATED:
> -			if (part_error) {
> -				new_prs = -old_prs;
> -				subparts_delta--;
> -			}
> -			break;
> -		case PRS_INVALID_ROOT:
> -		case PRS_INVALID_ISOLATED:
> -			if (!part_error) {
> -				new_prs = -old_prs;
> -				subparts_delta++;
> -			}
> -			break;
> -		}
> +	new_prs = old_prs < 0 ? -old_prs : old_prs;
> +	part_error = local_partition_check(cs, new_prs, excpus, excl_check);
> +	if (part_error) {
> +		local_partition_invalidate(cs, tmp);

local_partition_invalidate() should only called if old_prs > 0.

> +		return part_error;
>   	}
>   
> -	if (!adding && !deleting && (new_prs == old_prs))
> -		return 0;
> +	/* Nothing changes, return PERR_NONE */
> +	if (new_prs == old_prs && cpumask_equal(excpus, cs->effective_xcpus))
> +		return PERR_NONE;
>   
>   	/*
> -	 * Transitioning between invalid to valid or vice versa may require
> -	 * changing CS_CPU_EXCLUSIVE. In the case of partcmd_update,
> -	 * validate_change() has already been successfully called and
> -	 * CPU lists in cs haven't been updated yet. So defer it to later.
> +	 * If partition was previously invalid but now passes checks,
> +	 * enable it and update related flags
>   	 */
> -	if ((old_prs != new_prs) && (cmd != partcmd_update))  {
> -		int err = update_partition_exclusive_flag(cs, new_prs);
> -
> -		if (err)
> -			return err;
> +	if (is_partition_invalid(cs) && !part_error) {
The !part_error check should be unnecessary as this path will not be 
reached if part_error is non-zero.

> +		partition_enable(cs, parent, new_prs, excpus);
> +		update_partition_exclusive_flag(cs, new_prs);
> +		update_partition_sd_lb(cs, old_prs);
> +		return part_error;
Just return PERR_NONE if it is not expected to be set.

>   	}
>   
> +	cpumask_updated = cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
> +	cpumask_updated |= cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
> +	partition_update(cs, new_prs, xcpus, excpus, tmp);
>   	/*
> -	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
> -	 * only).
> -	 *
> -	 * Newly added CPUs will be removed from effective_cpus and
> -	 * newly deleted ones will be added back to effective_cpus.
> -	 */
> -	spin_lock_irq(&callback_lock);
> -	if (old_prs != new_prs) {
> -		cs->partition_root_state = new_prs;
> -		if (new_prs <= 0)
> -			cs->nr_subparts = 0;
> -	}
> -	/*
> -	 * Adding to parent's effective_cpus means deletion CPUs from cs
> -	 * and vice versa.
> +	 * Propagate changes in parent's effective_cpus down the hierarchy.
>   	 */
> -	if (adding)
> -		isolcpus_updated += partition_xcpus_del(old_prs, parent,
> -							tmp->addmask);
> -	if (deleting)
> -		isolcpus_updated += partition_xcpus_add(new_prs, parent,
> -							tmp->delmask);
> -
> -	if (is_partition_valid(parent)) {
> -		parent->nr_subparts += subparts_delta;
> -		WARN_ON_ONCE(parent->nr_subparts < 0);
> -	}
> -	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> -
> -	if ((old_prs != new_prs) && (cmd == partcmd_update))
> -		update_partition_exclusive_flag(cs, new_prs);
> -
> -	if (adding || deleting) {
> +	if (cpumask_updated) {
>   		cpuset_update_tasks_cpumask(parent, tmp->addmask);
>   		update_sibling_cpumasks(parent, cs, tmp);
>   	}
> +	return part_error;

Ditto.

Cheers,
Longman



