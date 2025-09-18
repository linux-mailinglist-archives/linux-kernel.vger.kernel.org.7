Return-Path: <linux-kernel+bounces-822397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEAAB83C24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C353A4B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41782FF648;
	Thu, 18 Sep 2025 09:23:40 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82A2F9DB2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187420; cv=none; b=bPlUp4lOzxphsuyCU+1jj4Y3KDrul97UG7NnEytJIOCNmLazj31JjA5fm0Isf4eVyiMIiCmKRqws+mH4UoKXBxa3iS8zGXrnwegvtk1wkOVCtfsmWVKuYuvkiEkKhRGUB3kUoFHsLlsr1mHxY3KNbuE5BuTpYPjqPW9pv1e0gqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187420; c=relaxed/simple;
	bh=nkO9Kl8XPHS7wZBNuU9uqvFUkKXv3uCXoQDj2IkZLIo=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I4ULgPWammlk8P8Aq6dS2EPH5Paa31ppKDtekR6Ux2BhjaQs7s1CTYH/sEYbZK454Hg5HCyTGkEVklxkAHmJ7C2gte3DsmEQBdKhNQS2mMtJFrYGx93C+uZmkaqyhd0soGzW5obJI/j68qNpzG2fw/2T2szZtsAsmcVJiP6LekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cS9764xnDzPtWM;
	Thu, 18 Sep 2025 17:18:58 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id ABAAB1800B4;
	Thu, 18 Sep 2025 17:23:34 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 17:23:34 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 17:23:33 +0800
Subject: Re: [PATCH v2] arch_topology: move parse_acpi_topology() to common
 code
To: Yunhui Cui <cuiyunhui@bytedance.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <sudeep.holla@arm.com>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <dakr@kernel.org>, <beata.michalska@arm.com>,
	<sumitg@nvidia.com>, <ptsm@linux.microsoft.com>, <yangyicong@hisilicon.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250918014828.78383-1-cuiyunhui@bytedance.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <0020389a-676c-74ab-b68f-cd0a44538980@huawei.com>
Date: Thu, 18 Sep 2025 17:23:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250918014828.78383-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/9/18 9:48, Yunhui Cui wrote:
> Currently, RISC-V lacks arch-specific registers for CPU topology
> properties and must get them from ACPI. Thus, parse_acpi_topology()
> is moved from arm64/ to drivers/ for RISC-V reuse.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/arm64/kernel/topology.c  | 87 +---------------------------------
>  drivers/base/arch_topology.c  | 89 ++++++++++++++++++++++++++++++++++-
>  include/linux/arch_topology.h |  1 +
>  3 files changed, 90 insertions(+), 87 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 5d07ee85bdae4..55650db53b526 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -26,7 +26,7 @@
>  #include <asm/topology.h>
>  
>  #ifdef CONFIG_ACPI
> -static bool __init acpi_cpu_is_threaded(int cpu)
> +bool __init acpi_cpu_is_threaded(int cpu)
>  {
>  	int is_threaded = acpi_pptt_cpu_is_thread(cpu);
>  
> @@ -39,91 +39,6 @@ static bool __init acpi_cpu_is_threaded(int cpu)
>  
>  	return !!is_threaded;
>  }
> -
> -struct cpu_smt_info {
> -	unsigned int thread_num;
> -	int core_id;
> -};
> -
> -/*
> - * Propagate the topology information of the processor_topology_node tree to the
> - * cpu_topology array.
> - */
> -int __init parse_acpi_topology(void)
> -{
> -	unsigned int max_smt_thread_num = 1;
> -	struct cpu_smt_info *entry;
> -	struct xarray hetero_cpu;
> -	unsigned long hetero_id;
> -	int cpu, topology_id;
> -
> -	if (acpi_disabled)
> -		return 0;
> -
> -	xa_init(&hetero_cpu);
> -
> -	for_each_possible_cpu(cpu) {
> -		topology_id = find_acpi_cpu_topology(cpu, 0);
> -		if (topology_id < 0)
> -			return topology_id;
> -
> -		if (acpi_cpu_is_threaded(cpu)) {
> -			cpu_topology[cpu].thread_id = topology_id;
> -			topology_id = find_acpi_cpu_topology(cpu, 1);
> -			cpu_topology[cpu].core_id   = topology_id;
> -
> -			/*
> -			 * In the PPTT, CPUs below a node with the 'identical
> -			 * implementation' flag have the same number of threads.
> -			 * Count the number of threads for only one CPU (i.e.
> -			 * one core_id) among those with the same hetero_id.
> -			 * See the comment of find_acpi_cpu_topology_hetero_id()
> -			 * for more details.
> -			 *
> -			 * One entry is created for each node having:
> -			 * - the 'identical implementation' flag
> -			 * - its parent not having the flag
> -			 */
> -			hetero_id = find_acpi_cpu_topology_hetero_id(cpu);
> -			entry = xa_load(&hetero_cpu, hetero_id);
> -			if (!entry) {
> -				entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> -				WARN_ON_ONCE(!entry);
> -
> -				if (entry) {
> -					entry->core_id = topology_id;
> -					entry->thread_num = 1;
> -					xa_store(&hetero_cpu, hetero_id,
> -						 entry, GFP_KERNEL);
> -				}
> -			} else if (entry->core_id == topology_id) {
> -				entry->thread_num++;
> -			}
> -		} else {
> -			cpu_topology[cpu].thread_id  = -1;
> -			cpu_topology[cpu].core_id    = topology_id;
> -		}
> -		topology_id = find_acpi_cpu_topology_cluster(cpu);
> -		cpu_topology[cpu].cluster_id = topology_id;
> -		topology_id = find_acpi_cpu_topology_package(cpu);
> -		cpu_topology[cpu].package_id = topology_id;
> -	}
> -
> -	/*
> -	 * This is a short loop since the number of XArray elements is the
> -	 * number of heterogeneous CPU clusters. On a homogeneous system
> -	 * there's only one entry in the XArray.
> -	 */
> -	xa_for_each(&hetero_cpu, hetero_id, entry) {
> -		max_smt_thread_num = max(max_smt_thread_num, entry->thread_num);
> -		xa_erase(&hetero_cpu, hetero_id);
> -		kfree(entry);
> -	}
> -
> -	cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
> -	xa_destroy(&hetero_cpu);
> -	return 0;
> -}
>  #endif
>  
>  #ifdef CONFIG_ARM64_AMU_EXTN
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1037169abb459..c22746b45d57a 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -823,12 +823,99 @@ void remove_cpu_topology(unsigned int cpu)
>  	clear_cpu_topology(cpu);
>  }
>  
> +__weak bool __init acpi_cpu_is_threaded(int cpu)
> +{
> +	int is_threaded = acpi_pptt_cpu_is_thread(cpu);
> +
> +	return !!is_threaded;
> +}
> +

you seem to miss the comment here in v1. acpi_pptt_cpu_is_thread() may return
-ENOENT, in which case the CPU shouldn't be threaded?

thanks.

