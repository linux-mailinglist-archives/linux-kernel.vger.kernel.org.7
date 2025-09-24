Return-Path: <linux-kernel+bounces-831174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8455DB9BC50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BEE326A03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1A26FDB6;
	Wed, 24 Sep 2025 19:50:43 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E98A257820
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743442; cv=none; b=gQjVIm86VSkfzCOHdH06SHL0olq8P3zMFxyx+qcVaFiSSc1y+Iq1OSHk2k//NYYvZ6KV2eC86Tfa0fxyiWFGkyq1jq85YYywfdGwiJ6W7HXFSAZNmAjqOG07Chvznk/FnRQwzGpsqvUiGOLVaTFLhz3pzTPKd3pcf/jQZ94wwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743442; c=relaxed/simple;
	bh=KIl6uivd6CfXc/76fYfOdwQRrrMamrdpxG7JJouDqhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xd+3XQ3DVobicjoGLPXtj+ux0psFWcTgxNfOt9QN819+Hb/FnSIkCwI5gHDgbmAbHkTcMhdfyiaN8X/R1EjGa5yyXbEsDhQMw4i1VJN5TCnSF+O7smW2/qUn6tbgnNscqCt+dGGNrUx4+o5artDPKea6FdiM/q98NGvphGlOjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cX64v3MX8z9sRr;
	Wed, 24 Sep 2025 21:15:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MjkCrWp6j8_X; Wed, 24 Sep 2025 21:15:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cX64v2BmNz9sRk;
	Wed, 24 Sep 2025 21:15:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A1358B770;
	Wed, 24 Sep 2025 21:15:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WzjUaTohc-zd; Wed, 24 Sep 2025 21:15:43 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F2AA8B763;
	Wed, 24 Sep 2025 21:15:40 +0200 (CEST)
Message-ID: <d168030f-388c-4f58-987f-648bba5b32f9@csgroup.eu>
Date: Wed, 24 Sep 2025 21:15:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/base/node: merge register_one_node() and
 register_node() to a single function.
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>
References: <cover.1758736423.git.donettom@linux.ibm.com>
 <40257b5228dec05e5b252f02438608eb8d681a2d.1758736423.git.donettom@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <40257b5228dec05e5b252f02438608eb8d681a2d.1758736423.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/09/2025 à 20:40, Donet Tom a écrit :
> register_one_node() and register_node() are small functions.
> This patch merges them into a single function named register_node()
> to improve code readability.

This is unclear.

What it really does is it folds register_node() into its only caller 
which is register_one_node() and then it renames register_one_node() 
into register_node().

> 
> No functional changes are introduced.
> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/pci_dlpar.c |  2 +-
>   arch/x86/mm/numa.c                         |  4 +-
>   drivers/base/node.c                        | 52 +++++++++-------------
>   include/linux/node.h                       |  4 +-
>   mm/memory_hotplug.c                        |  4 +-
>   mm/mm_init.c                               |  2 +-
>   6 files changed, 28 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
> index aeb8633a3d00..8c77ec7980de 100644
> --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> @@ -29,7 +29,7 @@ struct pci_controller *init_phb_dynamic(struct device_node *dn)
>   	nid = of_node_to_nid(dn);
>   	if (likely((nid) >= 0)) {
>   		if (!node_online(nid)) {
> -			if (register_one_node(nid)) {
> +			if (register_node(nid)) {
>   				pr_err("PCI: Failed to register node %d\n", nid);
>   			} else {
>   				update_numa_distance(dn);
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index c24890c40138..7a97327140df 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -262,7 +262,7 @@ void __init init_gi_nodes(void)
>   	 * bringup_nonboot_cpus
>   	 *  cpu_up
>   	 *   __try_online_node
> -	 *    register_one_node
> +	 *    register_node
>   	 * because node_subsys is not initialized yet.
>   	 * TODO remove dependency on node_online
>   	 */
> @@ -303,7 +303,7 @@ void __init init_cpu_to_node(void)
>   		 * bringup_nonboot_cpus
>   		 *  cpu_up
>   		 *   __try_online_node
> -		 *    register_one_node
> +		 *    register_node
>   		 * because node_subsys is not initialized yet.
>   		 * TODO remove dependency on node_online
>   		 */
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 6b6e55a98b79..eab620e29c78 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -638,33 +638,6 @@ static void node_device_release(struct device *dev)
>   	kfree(to_node(dev));
>   }
>   
> -/*
> - * register_node - Setup a sysfs device for a node.
> - * @num - Node number to use when creating the device.
> - *
> - * Initialize and register the node device.
> - */
> -static int register_node(struct node *node, int num)
> -{
> -	int error;
> -
> -	node->dev.id = num;
> -	node->dev.bus = &node_subsys;
> -	node->dev.release = node_device_release;
> -	node->dev.groups = node_dev_groups;
> -	error = device_register(&node->dev);
> -
> -	if (error) {
> -		put_device(&node->dev);
> -	} else {
> -		hugetlb_register_node(node);
> -		compaction_register_node(node);
> -		reclaim_register_node(node);
> -	}
> -
> -	return error;
> -}
> -
>   /**
>    * unregister_node - unregister a node device
>    * @node: node going away
> @@ -869,7 +842,13 @@ void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
>   }
>   #endif /* CONFIG_MEMORY_HOTPLUG */
>   
> -int register_one_node(int nid)
> +/*
> + * register_node - Setup a sysfs device for a node.
> + * @nid - Node number to use when creating the device.
> + *
> + * Initialize and register the node device.
> + */
> +int register_node(int nid)
>   {
>   	int error;
>   	int cpu;
> @@ -880,14 +859,23 @@ int register_one_node(int nid)
>   		return -ENOMEM;
>   
>   	INIT_LIST_HEAD(&node->access_list);
> -	node_devices[nid] = node;
>   
> -	error = register_node(node_devices[nid], nid);
> +	node->dev.id = nid;
> +	node->dev.bus = &node_subsys;
> +	node->dev.release = node_device_release;
> +	node->dev.groups = node_dev_groups;
> +
> +	error = device_register(&node->dev);
>   	if (error) {
> -		node_devices[nid] = NULL;
> +		put_device(&node->dev);
>   		return error;
>   	}
>   
> +	node_devices[nid] = node;
> +	hugetlb_register_node(node);
> +	compaction_register_node(node);
> +	reclaim_register_node(node);
> +
>   	/* link cpu under this node */
>   	for_each_present_cpu(cpu) {
>   		if (cpu_to_node(cpu) == nid)
> @@ -980,7 +968,7 @@ void __init node_dev_init(void)
>   	 * to already created cpu devices.
>   	 */
>   	for_each_online_node(i) {
> -		ret =  register_one_node(i);
> +		ret =  register_node(i);
>   		if (ret)
>   			panic("%s() failed to add node: %d\n", __func__, ret);
>   	}
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 2c7529335b21..4dcf876cd0b4 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -168,7 +168,7 @@ static inline int hotplug_node_notifier(notifier_fn_t fn, int pri)
>   #ifdef CONFIG_NUMA
>   extern void node_dev_init(void);
>   /* Core of the node registration - only memory hotplug should use this */
> -extern int register_one_node(int nid);
> +extern int register_node(int nid);

extern keyword is pointless on functions prototypes.

checkpatch.pl usually complains about that.

I know previous prototype was extern and all surrounding also are, but 
it is not because mistakes were done in the past that you have to 
continue doing the same mistakes.

>   extern void unregister_one_node(int nid);
>   extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
>   extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
> @@ -181,7 +181,7 @@ extern int register_memory_node_under_compute_node(unsigned int mem_nid,
>   static inline void node_dev_init(void)
>   {
>   }
> -static inline int register_one_node(int nid)
> +static inline int register_node(int nid)
>   {
>   	return 0;
>   }
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0be83039c3b5..6c050d867031 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1311,7 +1311,7 @@ static int __try_online_node(int nid, bool set_node_online)
>   
>   	if (set_node_online) {
>   		node_set_online(nid);
> -		ret = register_one_node(nid);
> +		ret = register_node(nid);
>   		BUG_ON(ret);
>   	}
>   out:
> @@ -1542,7 +1542,7 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>   		goto error_memblock_remove;
>   	if (ret) {
>   		node_set_online(nid);
> -		ret = register_one_node(nid);
> +		ret = register_node(nid);
>   		if (WARN_ON(ret)) {
>   			node_set_offline(nid);
>   			goto error_memblock_remove;
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index df614556741a..e1a19a3dadd7 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1909,7 +1909,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>   		free_area_init_node(nid);
>   
>   		/*
> -		 * No sysfs hierarchy will be created via register_one_node()
> +		 * No sysfs hierarchy will be created via register_node()
>   		 *for memory-less node because here it's not marked as N_MEMORY
>   		 *and won't be set online later. The benefit is userspace
>   		 *program won't be confused by sysfs files/directories of


