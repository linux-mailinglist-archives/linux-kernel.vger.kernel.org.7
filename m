Return-Path: <linux-kernel+bounces-748960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B27ABB1480A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD418189F357
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82769259498;
	Tue, 29 Jul 2025 06:11:58 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261F16F8E5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753769518; cv=none; b=gaWmoXHvfRtjmtuI+82WXbINiXL58zB6r1s0DYdvT0mKZ7agZX4OzrzxaAxOHP2lLG9+059JtjHY2pql0ctONSMp9JGEr5VMU1vr1bZRbz8XwD+W1j4JwmRP+SjZqToCXlBkEXkPdIzUshFucEEXmpmubbQ9bJNicrBZ6MUoAPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753769518; c=relaxed/simple;
	bh=qkfI9+Yz91vV8uUhQjgEeB7XweQsYounuUkDz6WYYvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1NtBYv7I2ucaviIGjzHL53W+MMcabzUoWpwYW21PrGI0wcbjIdbtygdEWQckA7q2AOFhO9eDlfOAbzDzctPADDlFUmJr2NLL3osuJEahv4KOsCOpjuzGDspVPad3JnfIQtvldG8ynnB+pnDOYhpUVkNKFD7Ho6vjCh19ckax/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 56T6BUc7063426;
	Tue, 29 Jul 2025 14:11:30 +0800 (+08)
	(envelope-from baisheng.gao@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4brlGs62QBz2KJGTb;
	Tue, 29 Jul 2025 14:06:45 +0800 (CST)
Received: from BJ15137PCW.spreadtrum.com (10.0.73.32) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 29 Jul 2025 14:11:28 +0800
From: Baisheng Gao <baisheng.gao@unisoc.com>
To: <james.morse@arm.com>
CC: <amitsinght@marvell.com>, <baolin.wang@linux.alibaba.com>,
        <ben.horgan@arm.com>, <bobo.shaobowang@huawei.com>,
        <carl@os.amperecomputing.com>, <dave.martin@arm.com>,
        <david@redhat.com>, <dfustini@baylibre.com>, <kobak@nvidia.com>,
        <lcherian@marvell.com>, <lecopzerc@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <peternewman@google.com>, <quic_jiles@quicinc.com>,
        <rex.nie@jaguarmicro.com>, <robh@kernel.org>, <rohit.mathew@arm.com>,
        <scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xhao@linux.alibaba.com>, <zengheng4@huawei.com>,
        <hao_hao.wang@unisoc.com>
Subject: Re: [RFC PATCH 17/36] arm_mpam: Add cpuhp callbacks to probe MSC hardware
Date: Tue, 29 Jul 2025 14:11:27 +0800
Message-ID: <20250729061127.206-1-baisheng.gao@unisoc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711183648.30766-18-james.morse@arm.com>
References: <20250711183648.30766-18-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 56T6BUc7063426

Hi James,

> Because an MSC can only by accessed from the CPUs in its cpu-affinity
> set we need to be running on one of those CPUs to probe the MSC
> hardware.
> 
> Do this work in the cpuhp callback. Probing the hardware will only
> happen before MPAM is enabled, walk all the MSCs and probe those we can
> reach that haven't already been probed.
> 
> Later once MPAM is enabled, this cpuhp callback will be replaced by
> one that avoids the global list.
> 
> Enabling a static key will also take the cpuhp lock, so can't be done
> from the cpuhp callback. Whenever a new MSC has been probed schedule
> work to test if all the MSCs have now been probed.
> 
> CC: Lecopzer Chen <lecopzerc@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/platform/arm64/mpam/mpam_devices.c  | 149 +++++++++++++++++++-
>  drivers/platform/arm64/mpam/mpam_internal.h |   8 +-
>  2 files changed, 152 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
> index 0d6d5180903b..89434ae3efa6 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -4,6 +4,7 @@
>  #define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
>  
>  #include <linux/acpi.h>
> +#include <linux/atomic.h>
>  #include <linux/arm_mpam.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpu.h>
> @@ -21,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> +#include <linux/workqueue.h>
>  
>  #include <acpi/pcc.h>
>  
> @@ -39,6 +41,16 @@ struct srcu_struct mpam_srcu;
>  /* MPAM isn't available until all the MSC have been probed. */
>  static u32 mpam_num_msc;
>  
> +static int mpam_cpuhp_state;
> +static DEFINE_MUTEX(mpam_cpuhp_state_lock);
> +
> +/*
> + * mpam is enabled once all devices have been probed from CPU online callbacks,
> + * scheduled via this work_struct. If access to an MSC depends on a CPU that
> + * was not brought online at boot, this can happen surprisingly late.
> + */
> +static DECLARE_WORK(mpam_enable_work, &mpam_enable);
> +
>  /*
>   * An MSC is a physical container for controls and monitors, each identified by
>   * their RIS index. These share a base-address, interrupts and some MMIO
> @@ -78,6 +90,22 @@ LIST_HEAD(mpam_classes);
>  /* List of all objects that can be free()d after synchronise_srcu() */
>  static LLIST_HEAD(mpam_garbage);
>  
> +static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
> +{
> +	WARN_ON_ONCE(reg > msc->mapped_hwpage_sz);
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +
> +	return readl_relaxed(msc->mapped_hwpage + reg);
> +}
> +
> +static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
> +{
> +	lockdep_assert_held_once(&msc->part_sel_lock);
> +	return __mpam_read_reg(msc, reg);
> +}
> +
> +#define mpam_read_partsel_reg(msc, reg)        _mpam_read_partsel_reg(msc, MPAMF_##reg)
> +
>  #define init_garbage(x)	init_llist_node(&(x)->garbage.llist)
>  
>  static struct mpam_vmsc *
> @@ -513,9 +541,84 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>  	return err;
>  }
>  
> -static void mpam_discovery_complete(void)
> +static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  {
> -	pr_err("Discovered all MSC\n");
> +	u64 idr;
> +	int err;
> +
> +	lockdep_assert_held(&msc->probe_lock);
> +
> +	mutex_lock(&msc->part_sel_lock);
> +	idr = mpam_read_partsel_reg(msc, AIDR);
> +	if ((idr & MPAMF_AIDR_ARCH_MAJOR_REV) != MPAM_ARCHITECTURE_V1) {
> +		pr_err_once("%s does not match MPAM architecture v1.0\n",
> +			    dev_name(&msc->pdev->dev));
> +		err = -EIO;
> +	} else {
> +		msc->probed = true;
> +		err = 0;
> +	}
> +	mutex_unlock(&msc->part_sel_lock);
> +
> +	return err;
> +}
> +
> +static int mpam_cpu_online(unsigned int cpu)
> +{
> +	return 0;
> +}
> +
> +/* Before mpam is enabled, try to probe new MSC */
> +static int mpam_discovery_cpu_online(unsigned int cpu)
> +{
> +	int err = 0;
> +	struct mpam_msc *msc;
> +	bool new_device_probed = false;
> +
> +	mutex_lock(&mpam_list_lock);
> +	list_for_each_entry(msc, &mpam_all_msc, glbl_list) {
> +		if (!cpumask_test_cpu(cpu, &msc->accessibility))
> +			continue;
> +
> +		mutex_lock(&msc->probe_lock);
> +		if (!msc->probed)
> +			err = mpam_msc_hw_probe(msc);
> +		mutex_unlock(&msc->probe_lock);
> +
> +		if (!err)
> +			new_device_probed = true;
> +		else
> +			break; // mpam_broken
> +	}
> +	mutex_unlock(&mpam_list_lock);
> +
> +	if (new_device_probed && !err)
> +		schedule_work(&mpam_enable_work);
> +
> +	return err;
> +}
> +
> +static int mpam_cpu_offline(unsigned int cpu)
> +{
> +	return 0;
> +}
> +
> +static void mpam_register_cpuhp_callbacks(int (*online)(unsigned int online),
> +					  int (*offline)(unsigned int offline))
> +{
> +	mutex_lock(&mpam_cpuhp_state_lock);
> +	if (mpam_cpuhp_state) {
> +		cpuhp_remove_state(mpam_cpuhp_state);
> +		mpam_cpuhp_state = 0;
> +	}
> +
> +	mpam_cpuhp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mpam:online",
> +					     online, offline);
> +	if (mpam_cpuhp_state <= 0) {
> +		pr_err("Failed to register cpuhp callbacks");
> +		mpam_cpuhp_state = 0;
> +	}
> +	mutex_unlock(&mpam_cpuhp_state_lock);
>  }
>  
>  static int mpam_dt_count_msc(void)
> @@ -774,7 +877,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!err && fw_num_msc == mpam_num_msc)
> -		mpam_discovery_complete();
> +		mpam_register_cpuhp_callbacks(&mpam_discovery_cpu_online, NULL);
>  
>  	if (err && msc)
>  		mpam_msc_drv_remove(pdev);
> @@ -797,6 +900,46 @@ static struct platform_driver mpam_msc_driver = {
>  	.remove = mpam_msc_drv_remove,
>  };
>  
> +static void mpam_enable_once(void)
> +{
> +	mutex_lock(&mpam_cpuhp_state_lock);
> +	cpuhp_remove_state(mpam_cpuhp_state);
> +	mpam_cpuhp_state = 0;
> +	mutex_unlock(&mpam_cpuhp_state_lock);

Deleting the above 4 lines?
The mpam_cpuhp_state will be removed firstly in mpam_register_cpuhp_callbacks
if the mpam_cpuhp_state isn't 0.

> +
> +	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
> +
> +	pr_info("MPAM enabled\n");
> +}
> +
[snip]

Regards,
Baisheng

