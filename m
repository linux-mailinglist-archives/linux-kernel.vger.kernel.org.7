Return-Path: <linux-kernel+bounces-798849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F6B423DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1951BC2EE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BCB202F71;
	Wed,  3 Sep 2025 14:37:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74287202960
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910236; cv=none; b=hbN6YMr6r7OBaWUytpvYsZX50Z6juwbHAsGUkMDx5gdaKnbQ36qqK3BmCGGzkH61dwI1vNvgUc4jCOz0ek0+jc/r3KIJ/6zKHyVoyfBFtzB68JZQ1MEIqxinX2mGxR3B63y8zUsfRY7yZXgNcG9hArwO9eoF2Sghp56hHdSdIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910236; c=relaxed/simple;
	bh=PcOjhdY+ZMXUBSxoY4BtwPLxiuiXz2lgAGnUSqNddSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCjSfU9OsfQaCcoEiUxz0bsYJ0diTJfeCcCpwPspUfJSiSqSiBHHphe/8TGZyGT7WTQIyYVID1XO/6cKDhwMKVPaywY15GeWc1cJbzwNfNw8S6sIQ67Zojb21fVLzGRO7Pm97zPrQ/Y8qoikRPgTkdAoJIMs9wuAG61vATsBB1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18B601688;
	Wed,  3 Sep 2025 07:37:05 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A2EB3F6A8;
	Wed,  3 Sep 2025 07:37:12 -0700 (PDT)
Date: Wed, 3 Sep 2025 15:37:09 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tony.luck@intel.com,
	reinette.chatre@intel.com, julia.lawall@inria.fr,
	james.morse@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/resctrl: Convert lock to guard
Message-ID: <aLhSlXbj+GNQzpJU@e133380.arm.com>
References: <20250903122017.1331877-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903122017.1331877-1-karanja99erick@gmail.com>

Hi,

You seem already to have been told that patches of this sort are
unlikely to be helpful.  Greg summed it up pretty well, e.g. [1], [2].


With regard to this specific patch:

On Wed, Sep 03, 2025 at 03:20:15PM +0300, Erick Karanja wrote:
> Convert manual lock/unlock calls to guard and tidy up the code.

The very first sentence under "Describe your changes"
in submitting-patches.rst is: "Describe your problem."

So, what problem is being addressed by this patch?

> Generated-by: Coccinelle SmPL
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>

Coccinelle is a powerful tool, but ultimately somebody has to take
responsibility for the correctness of the output.  How have you
verified that the result is correct?

Also, this is a lot of diffstat for what is really just a change of
coding style that fixes nothing (or at least, you don't claim that it
fixes anything).

While all contributions are welcome, they do need to deliver a net
benefit.

I can't speak for the maintainers, but given the pain that they would
likely have fixing up all the merge conflicts that this patch would
cause, I think that the benefit would need to be substantial.


If you found actual bugs as part of this process, then that would
definitely be worth looking at (?)

Cheers
---Dave

[1] Re: [PATCH 0/2] staging: rtl8723bs: Use scoped_guard for mutex handling
https://lore.kernel.org/lkml/2025042511-dose-rage-4c72@gregkh/

[2] Re: [PATCH] staging: rtl8723bs: Replace manual mutex handling with scoped_guard()
https://lore.kernel.org/lkml/2025042905-enunciate-sixfold-bd3f@gregkh/


> ---
>  fs/resctrl/rdtgroup.c | 249 +++++++++++++++++++-----------------------
>  1 file changed, 113 insertions(+), 136 deletions(-)
> 
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 77d08229d855..3c81f1535dbb 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -916,14 +916,13 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
>  		      struct pid *pid, struct task_struct *tsk)
>  {
>  	struct rdtgroup *rdtg;
> -	int ret = 0;
>  
> -	mutex_lock(&rdtgroup_mutex);
> +	guard(mutex)(&rdtgroup_mutex);
>  
>  	/* Return empty if resctrl has not been mounted. */
>  	if (!resctrl_mounted) {
>  		seq_puts(s, "res:\nmon:\n");
> -		goto unlock;
> +		return 0;
>  	}
>  
>  	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> @@ -952,17 +951,13 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
>  			break;
>  		}
>  		seq_putc(s, '\n');
> -		goto unlock;
> +		return 0;
>  	}
>  	/*
>  	 * The above search should succeed. Otherwise return
>  	 * with an error.
>  	 */
> -	ret = -ENOENT;
> -unlock:
> -	mutex_unlock(&rdtgroup_mutex);
> -
> -	return ret;
> +	return -ENOENT;
>  }
>  #endif
>  
> @@ -971,13 +966,12 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
>  {
>  	int len;
>  
> -	mutex_lock(&rdtgroup_mutex);
> +	guard(mutex)(&rdtgroup_mutex);
>  	len = seq_buf_used(&last_cmd_status);
>  	if (len)
>  		seq_printf(seq, "%.*s", len, last_cmd_status_buf);
>  	else
>  		seq_puts(seq, "ok\n");
> -	mutex_unlock(&rdtgroup_mutex);
>  	return 0;
>  }
>  
> @@ -1062,66 +1056,66 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  	u32 ctrl_val;
>  
>  	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -	hw_shareable = r->cache.shareable_bits;
> -	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
> -		if (sep)
> -			seq_putc(seq, ';');
> -		sw_shareable = 0;
> -		exclusive = 0;
> -		seq_printf(seq, "%d=", dom->hdr.id);
> -		for (i = 0; i < closids_supported(); i++) {
> -			if (!closid_allocated(i))
> -				continue;
> -			ctrl_val = resctrl_arch_get_config(r, dom, i,
> -							   s->conf_type);
> -			mode = rdtgroup_mode_by_closid(i);
> -			switch (mode) {
> -			case RDT_MODE_SHAREABLE:
> -				sw_shareable |= ctrl_val;
> -				break;
> -			case RDT_MODE_EXCLUSIVE:
> -				exclusive |= ctrl_val;
> -				break;
> -			case RDT_MODE_PSEUDO_LOCKSETUP:
> -			/*
> -			 * RDT_MODE_PSEUDO_LOCKSETUP is possible
> -			 * here but not included since the CBM
> -			 * associated with this CLOSID in this mode
> -			 * is not initialized and no task or cpu can be
> -			 * assigned this CLOSID.
> -			 */
> -				break;
> -			case RDT_MODE_PSEUDO_LOCKED:
> -			case RDT_NUM_MODES:
> -				WARN(1,
> -				     "invalid mode for closid %d\n", i);
> -				break;
> +	scoped_guard (mutex, &rdtgroup_mutex) {
> +		hw_shareable = r->cache.shareable_bits;
> +		list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
> +			if (sep)
> +				seq_putc(seq, ';');
> +			sw_shareable = 0;
> +			exclusive = 0;
> +			seq_printf(seq, "%d=", dom->hdr.id);
> +			for (i = 0; i < closids_supported(); i++) {
> +				if (!closid_allocated(i))
> +					continue;
> +				ctrl_val = resctrl_arch_get_config(r, dom, i,
> +								   s->conf_type);
> +				mode = rdtgroup_mode_by_closid(i);
> +				switch (mode) {
> +				case RDT_MODE_SHAREABLE:
> +					sw_shareable |= ctrl_val;
> +					break;
> +				case RDT_MODE_EXCLUSIVE:
> +					exclusive |= ctrl_val;
> +					break;
> +				case RDT_MODE_PSEUDO_LOCKSETUP:
> +				/*
> +				 * RDT_MODE_PSEUDO_LOCKSETUP is possible
> +				 * here but not included since the CBM
> +				 * associated with this CLOSID in this mode
> +				 * is not initialized and no task or cpu can be
> +				 * assigned this CLOSID.
> +				 */
> +					break;
> +				case RDT_MODE_PSEUDO_LOCKED:
> +				case RDT_NUM_MODES:
> +					WARN(1,
> +					     "invalid mode for closid %d\n", i);
> +					break;
> +				}
>  			}
> +			for (i = r->cache.cbm_len - 1; i >= 0; i--) {
> +				pseudo_locked = dom->plr ? dom->plr->cbm : 0;
> +				hwb = test_bit(i, &hw_shareable);
> +				swb = test_bit(i, &sw_shareable);
> +				excl = test_bit(i, &exclusive);
> +				psl = test_bit(i, &pseudo_locked);
> +				if (hwb && swb)
> +					seq_putc(seq, 'X');
> +				else if (hwb && !swb)
> +					seq_putc(seq, 'H');
> +				else if (!hwb && swb)
> +					seq_putc(seq, 'S');
> +				else if (excl)
> +					seq_putc(seq, 'E');
> +				else if (psl)
> +					seq_putc(seq, 'P');
> +				else /* Unused bits remain */
> +					seq_putc(seq, '0');
> +				}
> +				sep = true;
>  		}
> -		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
> -			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
> -			hwb = test_bit(i, &hw_shareable);
> -			swb = test_bit(i, &sw_shareable);
> -			excl = test_bit(i, &exclusive);
> -			psl = test_bit(i, &pseudo_locked);
> -			if (hwb && swb)
> -				seq_putc(seq, 'X');
> -			else if (hwb && !swb)
> -				seq_putc(seq, 'H');
> -			else if (!hwb && swb)
> -				seq_putc(seq, 'S');
> -			else if (excl)
> -				seq_putc(seq, 'E');
> -			else if (psl)
> -				seq_putc(seq, 'P');
> -			else /* Unused bits remain */
> -				seq_putc(seq, '0');
> -		}
> -		sep = true;
> +		seq_putc(seq, '\n');
>  	}
> -	seq_putc(seq, '\n');
> -	mutex_unlock(&rdtgroup_mutex);
>  	cpus_read_unlock();
>  	return 0;
>  }
> @@ -1625,24 +1619,24 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>  	bool sep = false;
>  
>  	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> +	scoped_guard (mutex, &rdtgroup_mutex) {
>  
> -	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
> -		if (sep)
> -			seq_puts(s, ";");
> +		list_for_each_entry(dom, &r->mon_domains, hdr.list) {
> +			if (sep)
> +				seq_puts(s, ";");
>  
> -		memset(&mon_info, 0, sizeof(struct resctrl_mon_config_info));
> -		mon_info.r = r;
> -		mon_info.d = dom;
> -		mon_info.evtid = evtid;
> -		mondata_config_read(&mon_info);
> +			memset(&mon_info, 0, sizeof(struct resctrl_mon_config_info));
> +			mon_info.r = r;
> +			mon_info.d = dom;
> +			mon_info.evtid = evtid;
> +			mondata_config_read(&mon_info);
>  
> -		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
> -		sep = true;
> -	}
> -	seq_puts(s, "\n");
> +			seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
> +			sep = true;
> +		}
> +		seq_puts(s, "\n");
>  
> -	mutex_unlock(&rdtgroup_mutex);
> +	}
>  	cpus_read_unlock();
>  
>  	return 0;
> @@ -1763,15 +1757,15 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
>  		return -EINVAL;
>  
>  	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> +	scoped_guard (mutex, &rdtgroup_mutex) {
>  
> -	rdt_last_cmd_clear();
> +		rdt_last_cmd_clear();
>  
> -	buf[nbytes - 1] = '\0';
> +		buf[nbytes - 1] = '\0';
>  
> -	ret = mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
> +		ret = mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
>  
> -	mutex_unlock(&rdtgroup_mutex);
> +	}
>  	cpus_read_unlock();
>  
>  	return ret ?: nbytes;
> @@ -1789,15 +1783,15 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>  		return -EINVAL;
>  
>  	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> +	scoped_guard (mutex, &rdtgroup_mutex) {
>  
> -	rdt_last_cmd_clear();
> +		rdt_last_cmd_clear();
>  
> -	buf[nbytes - 1] = '\0';
> +		buf[nbytes - 1] = '\0';
>  
> -	ret = mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
> +		ret = mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
>  
> -	mutex_unlock(&rdtgroup_mutex);
> +	}
>  	cpus_read_unlock();
>  
>  	return ret ?: nbytes;
> @@ -2786,7 +2780,7 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
>  {
>  	struct task_struct *p, *t;
>  
> -	read_lock(&tasklist_lock);
> +	guard(read_lock)(&tasklist_lock);
>  	for_each_process_thread(p, t) {
>  		if (!from || is_closid_match(t, from) ||
>  		    is_rmid_match(t, from)) {
> @@ -2812,7 +2806,6 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
>  				cpumask_set_cpu(task_cpu(t), mask);
>  		}
>  	}
> -	read_unlock(&tasklist_lock);
>  }
>  
>  static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
> @@ -2959,22 +2952,22 @@ static void rdt_kill_sb(struct super_block *sb)
>  	struct rdt_resource *r;
>  
>  	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> +	scoped_guard (mutex, &rdtgroup_mutex) {
>  
> -	rdt_disable_ctx();
> +		rdt_disable_ctx();
>  
> -	/* Put everything back to default values. */
> -	for_each_alloc_capable_rdt_resource(r)
> -		resctrl_arch_reset_all_ctrls(r);
> +		/* Put everything back to default values. */
> +		for_each_alloc_capable_rdt_resource(r)
> +			resctrl_arch_reset_all_ctrls(r);
>  
> -	resctrl_fs_teardown();
> -	if (resctrl_arch_alloc_capable())
> -		resctrl_arch_disable_alloc();
> -	if (resctrl_arch_mon_capable())
> -		resctrl_arch_disable_mon();
> -	resctrl_mounted = false;
> -	kernfs_kill_sb(sb);
> -	mutex_unlock(&rdtgroup_mutex);
> +		resctrl_fs_teardown();
> +		if (resctrl_arch_alloc_capable())
> +			resctrl_arch_disable_alloc();
> +		if (resctrl_arch_mon_capable())
> +			resctrl_arch_disable_mon();
> +		resctrl_mounted = false;
> +		kernfs_kill_sb(sb);
> +	}
>  	cpus_read_unlock();
>  }
>  
> @@ -4008,7 +4001,7 @@ static void rdtgroup_destroy_root(void)
>  
>  static void rdtgroup_setup_default(void)
>  {
> -	mutex_lock(&rdtgroup_mutex);
> +	guard(mutex)(&rdtgroup_mutex);
>  
>  	rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
>  	rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
> @@ -4016,8 +4009,6 @@ static void rdtgroup_setup_default(void)
>  	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
>  
>  	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
> -
> -	mutex_unlock(&rdtgroup_mutex);
>  }
>  
>  static void domain_destroy_mon_state(struct rdt_mon_domain *d)
> @@ -4029,17 +4020,15 @@ static void domain_destroy_mon_state(struct rdt_mon_domain *d)
>  
>  void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d)
>  {
> -	mutex_lock(&rdtgroup_mutex);
> +	guard(mutex)(&rdtgroup_mutex);
>  
>  	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
>  		mba_sc_domain_destroy(r, d);
> -
> -	mutex_unlock(&rdtgroup_mutex);
>  }
>  
>  void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
>  {
> -	mutex_lock(&rdtgroup_mutex);
> +	guard(mutex)(&rdtgroup_mutex);
>  
>  	/*
>  	 * If resctrl is mounted, remove all the
> @@ -4064,8 +4053,6 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
>  	}
>  
>  	domain_destroy_mon_state(d);
> -
> -	mutex_unlock(&rdtgroup_mutex);
>  }
>  
>  /**
> @@ -4116,15 +4103,13 @@ int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d
>  {
>  	int err = 0;
>  
> -	mutex_lock(&rdtgroup_mutex);
> +	guard(mutex)(&rdtgroup_mutex);
>  
>  	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA) {
>  		/* RDT_RESOURCE_MBA is never mon_capable */
>  		err = mba_sc_domain_allocate(r, d);
>  	}
>  
> -	mutex_unlock(&rdtgroup_mutex);
> -
>  	return err;
>  }
>  
> @@ -4132,11 +4117,11 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
>  {
>  	int err;
>  
> -	mutex_lock(&rdtgroup_mutex);
> +	guard(mutex)(&rdtgroup_mutex);
>  
>  	err = domain_setup_mon_state(r, d);
>  	if (err)
> -		goto out_unlock;
> +		return err;
>  
>  	if (resctrl_is_mbm_enabled()) {
>  		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
> @@ -4156,18 +4141,14 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
>  	if (resctrl_mounted && resctrl_arch_mon_capable())
>  		mkdir_mondata_subdir_allrdtgrp(r, d);
>  
> -out_unlock:
> -	mutex_unlock(&rdtgroup_mutex);
> -
>  	return err;
>  }
>  
>  void resctrl_online_cpu(unsigned int cpu)
>  {
> -	mutex_lock(&rdtgroup_mutex);
> -	/* The CPU is set in default rdtgroup after online. */
> -	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> -	mutex_unlock(&rdtgroup_mutex);
> +	scoped_guard (mutex, &rdtgroup_mutex)
> +		/* The CPU is set in default rdtgroup after online. */
> +		cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
>  }
>  
>  static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
> @@ -4202,7 +4183,7 @@ void resctrl_offline_cpu(unsigned int cpu)
>  	struct rdt_mon_domain *d;
>  	struct rdtgroup *rdtgrp;
>  
> -	mutex_lock(&rdtgroup_mutex);
> +	guard(mutex)(&rdtgroup_mutex);
>  	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
>  		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
>  			clear_childcpus(rdtgrp, cpu);
> @@ -4211,7 +4192,7 @@ void resctrl_offline_cpu(unsigned int cpu)
>  	}
>  
>  	if (!l3->mon_capable)
> -		goto out_unlock;
> +		return;
>  
>  	d = get_mon_domain_from_cpu(cpu, l3);
>  	if (d) {
> @@ -4225,9 +4206,6 @@ void resctrl_offline_cpu(unsigned int cpu)
>  			cqm_setup_limbo_handler(d, 0, cpu);
>  		}
>  	}
> -
> -out_unlock:
> -	mutex_unlock(&rdtgroup_mutex);
>  }
>  
>  /*
> @@ -4338,9 +4316,8 @@ void resctrl_exit(void)
>  	cpus_read_lock();
>  	WARN_ON_ONCE(resctrl_online_domains_exist());
>  
> -	mutex_lock(&rdtgroup_mutex);
> -	resctrl_fs_teardown();
> -	mutex_unlock(&rdtgroup_mutex);
> +	scoped_guard (mutex, &rdtgroup_mutex)
> +		resctrl_fs_teardown();
>  
>  	cpus_read_unlock();
>  
> -- 
> 2.43.0
> 
> 

