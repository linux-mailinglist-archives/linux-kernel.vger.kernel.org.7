Return-Path: <linux-kernel+bounces-834198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7488FBA42BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9A47409F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA0301706;
	Fri, 26 Sep 2025 14:20:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B801FBEB6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896437; cv=none; b=LMyxvlclP5mVoPKZ6sNiaYMpv8ROoFu32T+ep57cGAfrC+B6Q+1GAocXd/rpy7CDnnwLNA+DjuBHk8LJF5T37ceGT0UkdL/cTCEaNtdHlMdVjcgwR+M7UQ+XIsNh7KUT+m+DgjV3FwdNKS4FqHsnm19pHPOlBsFcCuy4zFr7aUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896437; c=relaxed/simple;
	bh=HHnl3lgv0iJm+LRjkq0lkXFSsO62NLuHMK3BFRO2hXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeE8M6HJV89IO4JPUbZaHPAT6jbpF47u4ZDinEaxNM1XXaZFooeIZi2ZxbJ9Qw5jK1O0QAyJfqhE9r9n6NcgQxHnR4lTOdjOpRYQ8pSecj+dl/41Isl2pk/dFNhRoxhG+34huDBLXgZRIxLgXWB3+v4usVlvjpUZItvaEuHzzQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cYBkM2mswz9sTk;
	Fri, 26 Sep 2025 15:48:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Q3lMEydGwPm; Fri, 26 Sep 2025 15:48:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cYBkM1Y8Xz9sTh;
	Fri, 26 Sep 2025 15:48:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2435C8B77A;
	Fri, 26 Sep 2025 15:48:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id iuKruXyQLJPN; Fri, 26 Sep 2025 15:48:27 +0200 (CEST)
Received: from [192.168.202.221] (unknown [192.168.202.221])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CF6348B779;
	Fri, 26 Sep 2025 15:48:25 +0200 (CEST)
Message-ID: <3a1e75dd-6b39-4506-b4d7-806915d2a6fa@csgroup.eu>
Date: Fri, 26 Sep 2025 15:48:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/numa_emulation: Move the size calculation in
 split_nodes_interleave() to a separate function
To: pratyush.brahma@oss.qualcomm.com,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250926-numa-emu-v1-0-714f2691bf8b@oss.qualcomm.com>
 <20250926-numa-emu-v1-2-714f2691bf8b@oss.qualcomm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250926-numa-emu-v1-2-714f2691bf8b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/09/2025 à 12:34, pratyush.brahma@oss.qualcomm.com a écrit :
> From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> 
> The size calculation in split_nodes_interleave() has several nuances.
> Move it to a separate function to improve code modularity and
> simplify the readability of split_nodes_interleave().
> 
> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> ---
>   mm/numa_emulation.c | 44 +++++++++++++++++++++++++++++---------------
>   1 file changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
> index 2a335b3dd46a..882c349c2a0f 100644
> --- a/mm/numa_emulation.c
> +++ b/mm/numa_emulation.c
> @@ -76,6 +76,34 @@ static int __init emu_setup_memblk(struct numa_meminfo *ei,
>   	return 0;
>   }
>   
> +static void __init __calc_split_params(u64 addr, u64 max_addr,
> +		int nr_nodes, u64 *psize, int *pbig)
> +{
> +	u64 size, usable_size;
> +	int big;
> +
> +	/* total usable memory (skip holes) */
> +	usable_size  = max_addr - addr - mem_hole_size(addr, max_addr);
> +
> +	/*
> +	 * Calculate target node size.  x86_32 freaks on __udivdi3() so do
> +	 * the division in ulong number of pages and convert back.
> +	 */
> +	size = PFN_PHYS((unsigned long)(usable_size >> PAGE_SHIFT) / nr_nodes);
> +
> +	/*
> +	 * Calculate the number of big nodes that can be allocated as a result
> +	 * of consolidating the remainder.
> +	 */
> +	big = ((size & (FAKE_NODE_MIN_SIZE - 1UL)) * nr_nodes) / FAKE_NODE_MIN_SIZE;
> +
> +	/* Align the base size down to the minimum granularity */
> +	size = ALIGN_DOWN(size, FAKE_NODE_MIN_SIZE);
> +
> +	*psize = size;
> +	*pbig  = big;

Having to return simple type values through pointers is usually the 
start of proplems.Whenever possible you shouldn't returning simple types 
via pointers.

Your function is void, it could return size instead.

And big seems independant, could be returned by another function.

> +}
> +
>   /*
>    * Sets up nr_nodes fake nodes interleaved over physical nodes ranging from addr
>    * to max_addr.
> @@ -100,21 +128,7 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
>   		nr_nodes = MAX_NUMNODES;
>   	}
>   
> -	/*
> -	 * Calculate target node size.  x86_32 freaks on __udivdi3() so do
> -	 * the division in ulong number of pages and convert back.
> -	 */
> -	size = max_addr - addr - mem_hole_size(addr, max_addr);
> -	size = PFN_PHYS((unsigned long)(size >> PAGE_SHIFT) / nr_nodes);
> -
> -	/*
> -	 * Calculate the number of big nodes that can be allocated as a result
> -	 * of consolidating the remainder.
> -	 */
> -	big = ((size & (FAKE_NODE_MIN_SIZE - 1UL)) * nr_nodes) /
> -		FAKE_NODE_MIN_SIZE;
> -
> -	size = ALIGN_DOWN(size, FAKE_NODE_MIN_SIZE);
> +	__calc_split_params(addr, max_addr, nr_nodes, &size, &big);
>   	if (!size) {
>   		pr_err("Not enough memory for each node.  "
>   			"NUMA emulation disabled.\n");
> 


