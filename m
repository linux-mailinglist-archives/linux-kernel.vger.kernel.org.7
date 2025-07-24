Return-Path: <linux-kernel+bounces-744462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01F3B10D45
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0131721E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB3C2DBF45;
	Thu, 24 Jul 2025 14:13:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7162D5C97
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366401; cv=none; b=BFv7t7xJpJ7Qs65G+7r2UoORCiBB8E797bl51X1xuw9KQnPXBBZy0Cd7KvuF1osBjS4fRm5dsS+W9P7AultnQMe8HRoGEhwE6AIhq+CzypcC3fvHIpAkwLgLK50ilHZKHdV0ivO4+YGCGbVpGyPN1mcEftxTg6cKp748ckHvFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366401; c=relaxed/simple;
	bh=9yD5qowNf+3o65b72QRPPjF5YvE3rW9R+UjlazwDXsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ge57KSMYFu72a16WOZf4uqtw3lmGpgWs5q4jatsFIkvU5NOg1N9AzHBcQXdn3kAyvZ3TwGIX12tMyruSsCd7tnyHRlGllEzO0B5CH+a2Pek+2jbm1zHYK9Qkpec0Dnvhaku3Y/3+2L2hDAXMKY9t7rUPUys4/wwhZyfsCzrhIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DA3F1A00;
	Thu, 24 Jul 2025 07:13:12 -0700 (PDT)
Received: from [10.57.84.166] (unknown [10.57.84.166])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDAB03F66E;
	Thu, 24 Jul 2025 07:13:15 -0700 (PDT)
Message-ID: <48e482f2-e7a8-4d6a-bf16-ad29f9331e3b@arm.com>
Date: Thu, 24 Jul 2025 15:13:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/36] arm_mpam: Add cpuhp callbacks to probe MSC
 hardware
Content-Language: en-GB
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
 <20250711183648.30766-18-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250711183648.30766-18-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/07/2025 19:36, James Morse wrote:
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
>   drivers/platform/arm64/mpam/mpam_devices.c  | 149 +++++++++++++++++++-
>   drivers/platform/arm64/mpam/mpam_internal.h |   8 +-
>   2 files changed, 152 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
> index 0d6d5180903b..89434ae3efa6 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -4,6 +4,7 @@
>   #define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
>   
>   #include <linux/acpi.h>
> +#include <linux/atomic.h>
>   #include <linux/arm_mpam.h>
>   #include <linux/cacheinfo.h>
>   #include <linux/cpu.h>
> @@ -21,6 +22,7 @@
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <linux/types.h>
> +#include <linux/workqueue.h>
>   
>   #include <acpi/pcc.h>
>   
> @@ -39,6 +41,16 @@ struct srcu_struct mpam_srcu;
>   /* MPAM isn't available until all the MSC have been probed. */
>   static u32 mpam_num_msc;
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
>   /*
>    * An MSC is a physical container for controls and monitors, each identified by
>    * their RIS index. These share a base-address, interrupts and some MMIO
> @@ -78,6 +90,22 @@ LIST_HEAD(mpam_classes);
>   /* List of all objects that can be free()d after synchronise_srcu() */
>   static LLIST_HEAD(mpam_garbage);
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
>   #define init_garbage(x)	init_llist_node(&(x)->garbage.llist)
>   
>   static struct mpam_vmsc *
> @@ -513,9 +541,84 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>   	return err;
>   }
>   
> -static void mpam_discovery_complete(void)
> +static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   {
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
The error message need only mention the major revision. You've added 
support for v1.1 and v1.0.> +		err = -EIO;
> +	} else {
> +		msc->probed = true;
> +		err = 0;
> +	}
> +	mutex_unlock(&msc->part_sel_lock);
> +
> +	return err;
> +}
[snip]
Thanks,

Ben


