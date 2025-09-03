Return-Path: <linux-kernel+bounces-798534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D384B41F6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0569C18849BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8362FE56B;
	Wed,  3 Sep 2025 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7GgaKq5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52501283FEF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903296; cv=none; b=Oh+djkM35PDSaYT6cBivmIeybnHYlngvKCNLJm2GW7nxeKGKGBtx8TxlbPTlHmtCnK1g/EyXYg3Ng+NEK17vqjbH1Mjb5DGqCZHhyvbkTkgkTuvITjoKIOMJWqgLxqg5MAHas3OSdKQeq8F+FzS7CtxR7bg5ZM86dRGzW0FLIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903296; c=relaxed/simple;
	bh=1bMKLwA3yVezwjA/NXm+mVFKX9IkAnMhR1j/fyXXsH4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t8A2c6h5b8yDsQVLvTivtfJ7Jgs7IDVK9glTmQirz++SMdKT8xOHDtX4o98+C39BpTUpCRQyd1QVcpq2GIZc283Zmuxujjh8XZmymzKuNLn2UuUAQ5ItUG9gaUNj5hdE+zXWT6skk2t1GgBOzraHjeTINy3+7KYi3CyBTVD1W+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7GgaKq5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756903294; x=1788439294;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1bMKLwA3yVezwjA/NXm+mVFKX9IkAnMhR1j/fyXXsH4=;
  b=k7GgaKq59A/Irg37izscrwSrmILQ4uHoISCCjMYYT+9H+9HkI1GmLk/+
   DH3p2hKvgTGcAj7p8HsbPI3pLemOJr9rcSpH9+TTAlnvGF3TCY0zLd9vA
   Ic/LV1TBB4tPMDo0K4x5nBKDzEvgz8DAucp7flF7tk5o/+CU3GOyfErJg
   NMOffZhy6vzB0oeCX8imRaWtBYeLZigzfsl+1nh+U0/HmgrTz2vG5fVsj
   MhgCskUbkDwB+Yx6DBYExG3le4gmGkEp28mE0u6ixK3BgyzGTTJkDmu9N
   H038qdZfV2f84fyrNmJ3rQgKVLYp/+rhfcyQHOOF4jtietHzi2HzpkJuH
   w==;
X-CSE-ConnectionGUID: EXt8U2mHQ/WaEke6KDj52A==
X-CSE-MsgGUID: R8rCwWWxRXq+db5HoaI0ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59150164"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="59150164"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 05:41:34 -0700
X-CSE-ConnectionGUID: RW5IjBTITy2XAlIeT6MRpg==
X-CSE-MsgGUID: Rv6epN5sQQq0fHxnD9qZKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="171718586"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.1])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 05:41:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 3 Sep 2025 15:41:26 +0300 (EEST)
To: Erick Karanja <karanja99erick@gmail.com>
cc: tony.luck@intel.com, Reinette Chatre <reinette.chatre@intel.com>, 
    julia.lawall@inria.fr, Dave.Martin@arm.com, james.morse@arm.com, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/resctrl: Convert lock to guard
In-Reply-To: <20250903122017.1331877-1-karanja99erick@gmail.com>
Message-ID: <ed4b7c07-9331-3ed7-fd8d-0e6fbd1c9c6a@linux.intel.com>
References: <20250903122017.1331877-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Sep 2025, Erick Karanja wrote:

> Convert manual lock/unlock calls to guard and tidy up the code.
> 
> Generated-by: Coccinelle SmPL
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
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

Why don't you use guard() for cpus_read_lock() as well so there wouldn't 
be no need to use scoped_guard()?

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

Same here? There seems to be more cases below which I won't mark.

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

Why not use guard()? Is coccinelle confused by the extra comment line? 
Didn't you read your own patch through after coccinelle spit it out?? :-/

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
> 

-- 
 i.


