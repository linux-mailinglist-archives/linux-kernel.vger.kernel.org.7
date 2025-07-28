Return-Path: <linux-kernel+bounces-747792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B98B13867
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223214E0ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4726D25486A;
	Mon, 28 Jul 2025 09:49:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B847483
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696180; cv=none; b=K8QHbKgYc7q6lSku1ne/LZBru4CKWRqKPs7Jfm2EG4BY96cseSgV4U6EFOfx96+QDyDrsqfyeawzSuCWYhyTtZ37wFNLCkq9+FYOEGqnjrWTurKwJ9b9bMO8+YYvyhFSCdxwRW1OhabPQRQVezgLrGKa8Ter6EpU7Ald7F1ecXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696180; c=relaxed/simple;
	bh=x0r6+aItH5l4NyFg4s/9uqtt4xXrU1NiwFS7Qd7MJRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGesZWXybD2RkXVEcaXG01XZp9v8EWP+3uGaBW5Sl9JZ6OcW6IiqVCDT01xfwQUbNhy2LCmpDfoCyJjbAo0rY4GVFlQzTbEu+bX8Z3J7SQnxntKDtgxDCk24PaGQbCoJmwDOJDOTKALhtlX75K/PR5YI7SDvVSNhw4wN/un4q4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B4DB150C;
	Mon, 28 Jul 2025 02:49:29 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ED263F66E;
	Mon, 28 Jul 2025 02:49:33 -0700 (PDT)
Message-ID: <b69f7207-84b3-424f-b675-b423c56e5dcd@arm.com>
Date: Mon, 28 Jul 2025 10:49:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 22/36] arm_mpam: Reset MSC controls from cpu hp
 callbacks
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-23-james.morse@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250711183648.30766-23-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/11/25 19:36, James Morse wrote:
> When a CPU comes online, it may bring a newly accessible MSC with
> it. Only the default partid has its value reset by hardware, and
> even then the MSC might not have been reset since its config was
> previously dirtyied. e.g. Kexec.
> 
> Any in-use partid must have its configuration restored, or reset.
> In-use partids may be held in caches and evicted later.
> 
> MSC are also reset when CPUs are taken offline to cover cases where
> firmware doesn't reset the MSC over reboot using UEFI, or kexec
> where there is no firmware involvement.
> 
> If the configuration for a RIS has not been touched since it was
> brought online, it does not need resetting again.
> 
> To reset, write the maximum values for all discovered controls.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/platform/arm64/mpam/mpam_devices.c  | 124 +++++++++++++++++++-
>   drivers/platform/arm64/mpam/mpam_internal.h |   8 ++
>   2 files changed, 131 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
> index 7b042a35405a..d014dbe0ab96 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -7,6 +7,7 @@
>   #include <linux/atomic.h>
>   #include <linux/arm_mpam.h>
>   #include <linux/bitfield.h>
> +#include <linux/bitmap.h>
>   #include <linux/cacheinfo.h>
>   #include <linux/cpu.h>
>   #include <linux/cpumask.h>
> @@ -849,8 +850,116 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   	return 0;
>   }
>   
> +static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
> +{
> +	u32 num_words, msb;
> +	u32 bm = ~0;
> +	int i;
> +
> +	lockdep_assert_held(&msc->part_sel_lock);
> +
> +	if (wd == 0)
> +		return;
> +
> +	/*
> +	 * Write all ~0 to all but the last 32bit-word, which may
> +	 * have fewer bits...
> +	 */
> +	num_words = DIV_ROUND_UP(wd, 32);
> +	for (i = 0; i < num_words - 1; i++, reg += sizeof(bm))
> +		__mpam_write_reg(msc, reg, bm);
> +
> +	/*
> +	 * ....and then the last (maybe) partial 32bit word. When wd is a
> +	 * multiple of 32, msb should be 31 to write a full 32bit word.
> +	 */
> +	msb = (wd - 1) % 32;
> +	bm = GENMASK(msb, 0);
> +	if (bm)
> +		__mpam_write_reg(msc, reg, bm);
Drop the 'if' as the 0 bit will always be part of the mask.

> +}
> +
> +static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
> +{
> +	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
> +	struct mpam_msc *msc = ris->vmsc->msc;
> +	struct mpam_props *rprops = &ris->props;
> +
> +	mpam_assert_srcu_read_lock_held();
> +
> +	mutex_lock(&msc->part_sel_lock);
> +	__mpam_part_sel(ris->ris_idx, partid, msc);
> +
> +	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
> +		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM, rprops->cpbm_wd);
> +
> +	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
> +		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM, rprops->mbw_pbm_bits);
> +
> +	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
> +		mpam_write_partsel_reg(msc, MBW_MIN, 0);
> +
> +	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
> +		mpam_write_partsel_reg(msc, MBW_MAX, bwa_fract);
> +
> +	if (mpam_has_feature(mpam_feat_mbw_prop, rprops))
> +		mpam_write_partsel_reg(msc, MBW_PROP, bwa_fract);
> +	mutex_unlock(&msc->part_sel_lock);
> +}
> +
> +static void mpam_reset_ris(struct mpam_msc_ris *ris)
> +{
> +	u16 partid, partid_max;
> +
> +	mpam_assert_srcu_read_lock_held();
> +
> +	if (ris->in_reset_state)
> +		return;
> +
> +	spin_lock(&partid_max_lock);
> +	partid_max = mpam_partid_max;
> +	spin_unlock(&partid_max_lock);
> +	for (partid = 0; partid < partid_max; partid++)
> +		mpam_reset_ris_partid(ris, partid);
> +}
> +
> +static void mpam_reset_msc(struct mpam_msc *msc, bool online)
> +{
> +	int idx;
> +	struct mpam_msc_ris *ris;
> +
> +	mpam_assert_srcu_read_lock_held();
> +
> +	mpam_mon_sel_outer_lock(msc);
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(ris, &msc->ris, msc_list, srcu_read_lock_held(&mpam_srcu)) {
> +		mpam_reset_ris(ris);
> +
> +		/*
> +		 * Set in_reset_state when coming online. The reset state
> +		 * for non-zero partid may be lost while the CPUs are offline.
> +		 */
> +		ris->in_reset_state = online;
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +	mpam_mon_sel_outer_unlock(msc);
> +}
> +
>   static int mpam_cpu_online(unsigned int cpu)
>   {
> +	int idx;
> +	struct mpam_msc *msc;
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
> +		if (!cpumask_test_cpu(cpu, &msc->accessibility))
> +			continue;
> +
> +		if (atomic_fetch_inc(&msc->online_refs) == 0)
> +			mpam_reset_msc(msc, true);
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +
>   	return 0;
>   }
>   
> @@ -886,6 +995,19 @@ static int mpam_discovery_cpu_online(unsigned int cpu)
>   
>   static int mpam_cpu_offline(unsigned int cpu)
>   {
> +	int idx;
> +	struct mpam_msc *msc;
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
> +		if (!cpumask_test_cpu(cpu, &msc->accessibility))
> +			continue;
> +
> +		if (atomic_dec_and_test(&msc->online_refs))
> +			mpam_reset_msc(msc, false);
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +
>   	return 0;
>   }
>   
> @@ -1419,7 +1541,7 @@ static void mpam_enable_once(void)
>   	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
>   
>   	printk(KERN_INFO "MPAM enabled with %u partid and %u pmg\n",
> -	       mpam_partid_max + 1, mpam_pmg_max + 1);
> +		READ_ONCE(mpam_partid_max) + 1, mpam_pmg_max + 1);

Belongs in 'arm_mpam: Probe MSCs to find the supported partid/pmg values'.

>   }
>   
>   /*
> diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
> index be56234b84b4..f3cc88136524 100644
> --- a/drivers/platform/arm64/mpam/mpam_internal.h
> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
> @@ -5,6 +5,7 @@
>   #define MPAM_INTERNAL_H
>   
>   #include <linux/arm_mpam.h>
> +#include <linux/atomic.h>
>   #include <linux/cpumask.h>
>   #include <linux/io.h>
>   #include <linux/llist.h>
> @@ -43,6 +44,7 @@ struct mpam_msc {
>   	struct pcc_mbox_chan	*pcc_chan;
>   	u32			nrdy_usec;
>   	cpumask_t		accessibility;
> +	atomic_t		online_refs;
>   
>   	/*
>   	 * probe_lock is only take during discovery. After discovery these
> @@ -247,6 +249,7 @@ struct mpam_msc_ris {
>   	u8			ris_idx;
>   	u64			idr;
>   	struct mpam_props	props;
> +	bool			in_reset_state;
>   
>   	cpumask_t		affinity;
>   
> @@ -266,6 +269,11 @@ struct mpam_msc_ris {
>   extern struct srcu_struct mpam_srcu;
>   extern struct list_head mpam_classes;
>   
> +static inline void mpam_assert_srcu_read_lock_held(void)
> +{
> +	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
> +}
> +
>   /* System wide partid/pmg values */
>   extern u16 mpam_partid_max;
>   extern u8 mpam_pmg_max;


Thanks,

Ben


