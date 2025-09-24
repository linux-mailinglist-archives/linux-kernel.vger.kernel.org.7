Return-Path: <linux-kernel+bounces-831173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53B6B9BC65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEFB189E1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF92A245028;
	Wed, 24 Sep 2025 19:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A3B18B0A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743437; cv=none; b=tLgJrz2qmDzvqSs6UnwpKmxNhgYuDQ6MgAjByhuO+gNLp2usXXLf3TVXOgkOL434OuK9otU9r+wvCr7KFCYyeYZTdhhzSlcASqott3Gl9D/sci7Bgn5kFs/FQ0HZdICxUnUaNbEUPb4ZtTOWWWon0tmc6cjzvBcJSN06d88Fyto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743437; c=relaxed/simple;
	bh=0ELImTsyiVQ5crfDiBT8ci/aGwqDCdR0J0Tk5XCdYjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5YOIqIY42OKK7lB2bpNy1Lz6jlYhblAM2v5axfLp/IgcKrsDmjjn8bVjaFv56GR4fFrbYJpR+DWfeadvaVL05yrLTeD53fTppNP8iIZ0/WTvZ10xN1hAakHqJ4rxRYSlUGW7fm2bUYzPc9sEfmvk7/et8BYkmswJAwspvohMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cX69D2dJ6z9sRy;
	Wed, 24 Sep 2025 21:19:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nqpn_EP-cTuc; Wed, 24 Sep 2025 21:19:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cX69D0pt8z9sRk;
	Wed, 24 Sep 2025 21:19:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CC7DE8B76C;
	Wed, 24 Sep 2025 21:19:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id edNE7oeRg5Qo; Wed, 24 Sep 2025 21:19:27 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 135518B768;
	Wed, 24 Sep 2025 21:19:25 +0200 (CEST)
Message-ID: <fa2272b9-13f2-464f-bb95-72fd31f1dcf9@csgroup.eu>
Date: Wed, 24 Sep 2025 21:19:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers/base/node: merge unregister_one_node() and
 unregister_node() to a single function.
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
 <c99d97e253378455f1b3b7bec5b0c830d4e73074.1758736423.git.donettom@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <c99d97e253378455f1b3b7bec5b0c830d4e73074.1758736423.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/09/2025 à 20:40, Donet Tom a écrit :
> unregister_one_node() and unregister_node() are small functions.
> This patch merges them into a single function named unregister_node()
> to improve code readability.

Same comment than patch 1. It is not only because they are small that 
you merge them, it is primarily because unregister_node() only has one 
caller.

> 
> No functional changes are introduced.
> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   drivers/base/node.c  | 37 +++++++++++++++++--------------------
>   include/linux/node.h |  6 ++----
>   mm/memory_hotplug.c  |  4 ++--
>   3 files changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index eab620e29c78..d460c1675c77 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -638,23 +638,6 @@ static void node_device_release(struct device *dev)
>   	kfree(to_node(dev));
>   }
>   
> -/**
> - * unregister_node - unregister a node device
> - * @node: node going away
> - *
> - * Unregisters a node device @node.  All the devices on the node must be
> - * unregistered before calling this function.
> - */
> -void unregister_node(struct node *node)
> -{
> -	hugetlb_unregister_node(node);
> -	compaction_unregister_node(node);
> -	reclaim_unregister_node(node);
> -	node_remove_accesses(node);
> -	node_remove_caches(node);
> -	device_unregister(&node->dev);
> -}
> -
>   struct node *node_devices[MAX_NUMNODES];
>   
>   /*
> @@ -887,12 +870,26 @@ int register_node(int nid)
>   	return error;
>   }
>   
> -void unregister_one_node(int nid)
> +/**
> + * unregister_node - unregister a node device
> + * @nid: nid of the node going away
> + *
> + * Unregisters the node device at node id  @nid.  All the devices on the
> + * node must be unregistered before calling this function.
> + */
> +void unregister_node(int nid)
>   {
> -	if (!node_devices[nid])
> +	struct node *node = node_devices[nid];
> +
> +	if (!node)
>   		return;
>   
> -	unregister_node(node_devices[nid]);
> +	hugetlb_unregister_node(node);
> +	compaction_unregister_node(node);
> +	reclaim_unregister_node(node);
> +	node_remove_accesses(node);
> +	node_remove_caches(node);
> +	device_unregister(&node->dev);
>   	node_devices[nid] = NULL;
>   }
>   
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 4dcf876cd0b4..d721127964b3 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -124,8 +124,6 @@ static inline void register_memory_blocks_under_nodes(void)
>   }
>   #endif
>   
> -extern void unregister_node(struct node *node);
> -
>   struct node_notify {
>   	int nid;
>   };
> @@ -169,7 +167,7 @@ static inline int hotplug_node_notifier(notifier_fn_t fn, int pri)
>   extern void node_dev_init(void);
>   /* Core of the node registration - only memory hotplug should use this */
>   extern int register_node(int nid);
> -extern void unregister_one_node(int nid);
> +extern void unregister_node(int nid);

No 'extern' on function prototypes.

>   extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
>   extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
>   extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
> @@ -185,7 +183,7 @@ static inline int register_node(int nid)
>   {
>   	return 0;
>   }
> -static inline int unregister_one_node(int nid)
> +static inline int unregister_node(int nid)
>   {
>   	return 0;
>   }
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6c050d867031..94a8f6e8811a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1596,7 +1596,7 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>   error:
>   	if (new_node) {
>   		node_set_offline(nid);
> -		unregister_one_node(nid);
> +		unregister_node(nid);
>   	}
>   error_memblock_remove:
>   	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
> @@ -2201,7 +2201,7 @@ void try_offline_node(int nid)
>   	 * node now.
>   	 */
>   	node_set_offline(nid);
> -	unregister_one_node(nid);
> +	unregister_node(nid);
>   }
>   EXPORT_SYMBOL(try_offline_node);
>   


