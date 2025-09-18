Return-Path: <linux-kernel+bounces-747830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9389B138DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2E4166196
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB34220F3E;
	Mon, 28 Jul 2025 10:23:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C519478
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698180; cv=none; b=M7UCNFGNUhwjsIsRHs/QWNnU8uH7gAePmL/FBzAxtmuVf7FE29da1lb4L3O4sYpvfpJlFrJuvvSupBAYmtuwhbiqookaTfJugWbd1FYwvckVWion856TCcwr8D8N6zQqZbgckMkCrGMlJR2niw7TM/cjgUSVj/VuG1MGGnk6s4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698180; c=relaxed/simple;
	bh=fRV2Qep9cGV9q7FgNe1T6WVdWfGosUva0wSAd4Ek4qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5ouuDoZWLy4atW2iGz9V0kcn8vMf7dBTgXumqomPu2WOenreDcOY1+j+sKgiyCFKPkM3nQX0m6Q+fG6y8eg/V7/2yg+gIauwqUMLFD+RPz+p6sUYLYs3eFex2wKRjtQR1bDo+4Rz7AWE18n6xB22OYXBLlh92gAbWZ02d+Tzx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93294152B;
	Mon, 28 Jul 2025 03:22:49 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 419383F673;
	Mon, 28 Jul 2025 03:22:54 -0700 (PDT)
Message-ID: <fcbe5517-0256-48ce-aa50-8017928737d7@arm.com>
Date: Mon, 28 Jul 2025 11:22:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 24/36] arm_mpam: Extend reset logic to allow devices
 to be reset any time
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
 <20250711183648.30766-25-james.morse@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250711183648.30766-25-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/11/25 19:36, James Morse wrote:
> cpuhp callbacks aren't the only time the MSC configuration may need to
> be reset. Resctrl has an API call to reset a class.
> If an MPAM error interrupt arrives it indicates the driver has
> misprogrammed an MSC. The safest thing to do is reset all the MSCs
> and disable MPAM.
> 
> Add a helper to reset RIS via their class. Call this from mpam_disable(),
> which can be scheduled from the error interrupt handler.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/platform/arm64/mpam/mpam_devices.c  | 62 ++++++++++++++++++++-
>   drivers/platform/arm64/mpam/mpam_internal.h |  1 +
>   2 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
> index 2e32e54cc081..145535cd4732 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -916,8 +916,6 @@ static int mpam_reset_ris(void *arg)
>   	u16 partid, partid_max;
>   	struct mpam_msc_ris *ris = arg;
>   
> -	mpam_assert_srcu_read_lock_held();
> -
>   	if (ris->in_reset_state)
>   		return 0;
>   
> @@ -1575,6 +1573,66 @@ static void mpam_enable_once(void)
>   		READ_ONCE(mpam_partid_max) + 1, mpam_pmg_max + 1);
>   }
>   
> +static void mpam_reset_component_locked(struct mpam_component *comp)
> +{
> +	int idx;
> +	struct mpam_msc *msc;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +
> +	might_sleep();
> +	lockdep_assert_cpus_held();
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_rcu(vmsc, &comp->vmsc, comp_list) {
> +		msc = vmsc->msc;
> +
> +		list_for_each_entry_rcu(ris, &vmsc->ris, vmsc_list) {
> +			if (!ris->in_reset_state)
> +				mpam_touch_msc(msc, mpam_reset_ris, ris);
> +			ris->in_reset_state = true;
> +		}
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +}
> +
> +static void mpam_reset_class_locked(struct mpam_class *class)
> +{
> +	int idx;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_cpus_held();
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_rcu(comp, &class->components, class_list)
> +		mpam_reset_component_locked(comp);
> +	srcu_read_unlock(&mpam_srcu, idx);
> +}
> +
> +static void mpam_reset_class(struct mpam_class *class)
> +{
> +	cpus_read_lock();
> +	mpam_reset_class_locked(class);
> +	cpus_read_unlock();
> +}
> +
> +/*
> + * Called in response to an error IRQ.
> + * All of MPAMs errors indicate a software bug, restore any modified
> + * controls to their reset values.
> + */
> +void mpam_disable(void)
> +{
> +	int idx;
> +	struct mpam_class *class;
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(class, &mpam_classes, classes_list,
> +				 srcu_read_lock_held(&mpam_srcu))
> +		mpam_reset_class(class);
> +	srcu_read_unlock(&mpam_srcu, idx);
> +}
Consider moving to the next patch where you introduce interrupt support.
> +
>   /*
>    * Enable mpam once all devices have been probed.
>    * Scheduled by mpam_discovery_cpu_online() once all devices have been created.
> diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
> index f3cc88136524..de05eece0a31 100644
> --- a/drivers/platform/arm64/mpam/mpam_internal.h
> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
> @@ -280,6 +280,7 @@ extern u8 mpam_pmg_max;
>   
>   /* Scheduled work callback to enable mpam once all MSC have been probed */
>   void mpam_enable(struct work_struct *work);
> +void mpam_disable(void);
>   
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);


Thanks,

Ben


