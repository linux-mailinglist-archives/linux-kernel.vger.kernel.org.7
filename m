Return-Path: <linux-kernel+bounces-733946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4B8B07B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A7816BA36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55FD2F3C3E;
	Wed, 16 Jul 2025 16:21:52 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898C481CD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682912; cv=none; b=WUqhvAcCjSi/e8fRvLGkd/aM0Us806HLl/vnJ7MwkG+rwvkT+lzMJeI+g+LYywUH2PIMYBJuRVZ5EAz8MOHs9Jo4pE/1inf2qYYoMzGB0k/74tqG1UBHCjJOzuYXzYHd1pLvae9l0SpTwNzJZtwEoEf1EIDWbqzbEdeWSCl/vTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682912; c=relaxed/simple;
	bh=M1oZgVTyYsLbNfFExN5SMkfDRrewPjlJvZlI2EMnlaU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFBK5tyB959Y+El7RB9QMKVyTCsmt2gKZZghR2g5NYkqUVB3k4q4+wAPxLOqxBMNynmMFpRSxaenX7P07GoScDkWmJNdAzOApZytI2mPatphlCrbfNZdwT4Rlk6X+3cBTXb8zjZOeLUr9o3zj9BHF5lvb3lUDnpSjbn3OaDCXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bj1W32DCTz6M4P9;
	Thu, 17 Jul 2025 00:20:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EE67814038F;
	Thu, 17 Jul 2025 00:21:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 18:21:45 +0200
Date: Wed, 16 Jul 2025 17:21:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Rob Herring" <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>, Rohit
 Mathew <rohit.mathew@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	"Zeng Heng" <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
	"Carl Worth" <carl@os.amperecomputing.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <lcherian@marvell.com>,
	<bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, <peternewman@google.com>, <dfustini@baylibre.com>,
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>, Koba Ko
	<kobak@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 07/36] ACPI / PPTT: Find cache level by cache-idUIRE
Message-ID: <20250716172144.00000715@huawei.com>
In-Reply-To: <20250711183648.30766-8-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
	<20250711183648.30766-8-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 18:36:19 +0000
James Morse <james.morse@arm.com> wrote:

> The MPAM table identifies caches by id. The MPAM driver also wants to know
> the cache level to determine if the platform is of the shape that can be
> managed via resctrl. Cacheinfo has this information, but only for CPUs that
> are online.
> 
> Waiting for all CPUs to come online is a problem for platforms where
> CPUs are brought online late by user-space.
> 
> Add a helper that walks every possible cache, until it finds the one
> identified by cache-id, then return the level.
> 
> acpi_count_levels() expects its levels parameter to be initialised to
> zero as it passes it to acpi_find_cache_level() as starting_level.
> The existing callers do this. Document it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

A few suggestions inline.  Mostly driven by the number of missing table
puts I've seen in ACPI code. You don't have any missing here but with a
bit of restructuring you can make that easy to see.

> ---
>  drivers/acpi/pptt.c  | 73 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  5 +++
>  2 files changed, 78 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 13ca2eee3b98..f53748a5df19 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -912,3 +912,76 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>  	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>  					  ACPI_PPTT_ACPI_IDENTICAL);
>  }
> +
> +/**
> + * find_acpi_cache_level_from_id() - Get the level of the specified cache
> + * @cache_id: The id field of the unified cache
> + *
> + * Determine the level relative to any CPU for the unified cache identified by
> + * cache_id. This allows the property to be found even if the CPUs are offline.
> + *
> + * The returned level can be used to group unified caches that are peers.
> + *
> + * The PPTT table must be rev 3 or later,
> + *
> + * If one CPUs L2 is shared with another as L3, this function will return
> + * an unpredictable value.
> + *
> + * Return: -ENOENT if the PPTT doesn't exist, or the cache cannot be found.
> + * Otherwise returns a value which represents the level of the specified cache.
> + */
> +int find_acpi_cache_level_from_id(u32 cache_id)
> +{
> +	u32 acpi_cpu_id;
> +	acpi_status status;
> +	int level, cpu, num_levels;
> +	struct acpi_pptt_cache *cache;
> +	struct acpi_table_header *table;
> +	struct acpi_pptt_cache_v1 *cache_v1;
> +	struct acpi_pptt_processor *cpu_node;
> +
> +	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_pptt_warn_missing();
> +		return -ENOENT;
> +	}
> +
> +	if (table->revision < 3) {

Maybe a unified exit path given all paths need to do
acpi_put_table() and return either error or level.

Or maybe it's time for some cleanup.h magic for acpi tables. I've
been thinking about it for a while and mostly stuck on the name ;)
(simpler suggestion follows)

static struct acpi_table_header *acpi_get_table_ret(char *signature, u32 instance)
{
	struct acpi_table_header *table;
	int status = acpi_get_table(signature, instance, &table);
	
	if (ACPI_FAILURE(status))
		return ERR_PTR(-ENOENT);
	return table;
}

DEFINE_FREE(acpi_table, struct acpi_table_header *, if (!IS_ERR(_T)) acpi_put_table(_T))

Finally in here and loads of other places we avoid chance of missing an acpi_put_table
and generally simplify the code a little.

int find_acpi_cache_level_from_id(u32 cache_id)
{
	u32 acpi_cpu_id;
	acpi_status status;
	int level, cpu, num_levels;
	struct acpi_pptt_cache *cache;
	struct acpi_pptt_cache_v1 *cache_v1;
	struct acpi_pptt_processor *cpu_node;


	struct acpi_table_header *table __free(acpi_table) =
		acpi_get_table_ret(ACPI_SIG_PPTT, 0);

	if (IS_ERR(table)
		return PTR_ERR(table);

	if (table->revision < 3)
		return -ENOENT;

	/*
	 * If we found the cache first, we'd still need to walk from each CPU
	 * to find the level...
	 */
	for_each_possible_cpu(cpu) {
		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
		if (!cpu_node)
			return -ENOENT;
		acpi_count_levels(table, cpu_node, &num_levels, NULL);

		/* Start at 1 for L1 */
		for (level = 1; level <= num_levels; level++) {
			cache = acpi_find_cache_node(table, acpi_cpu_id,
						     ACPI_PPTT_CACHE_TYPE_UNIFIED,
						     level, &cpu_node);
			if (!cache)
				continue;

			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
						cache,
						sizeof(struct acpi_pptt_cache));

			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
			    cache_v1->cache_id == cache_id) {
				acpi_put_table(table);
				return level;
			}
		}
	}
	return -ENOENT;
}


A less 'fun' alternative is pull some code out as a helper to make put the get and put
near each other with no conditionals to confuse things.


static int __find_acpi_cache_level_from_id(u32 cache_id, struct acpi_table_header *head);
{
	u32 acpi_cpu_id;
	int level, cpu, num_levels;
	struct acpi_pptt_cache *cache;
	struct acpi_pptt_cache_v1 *cache_v1;
	struct acpi_pptt_processor *cpu_node;

	if (table->revision < 3)
		return -ENOENT;

	/*
	 * If we found the cache first, we'd still need to walk from each CPU
	 * to find the level...
	 */
	for_each_possible_cpu(cpu) {
		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
		if (!cpu_node)
			return -ENOENT;
		acpi_count_levels(table, cpu_node, &num_levels, NULL);

		/* Start at 1 for L1 */
		for (level = 1; level <= num_levels; level++) {
			cache = acpi_find_cache_node(table, acpi_cpu_id,
						     ACPI_PPTT_CACHE_TYPE_UNIFIED,
						     level, &cpu_node);
			if (!cache)
				continue;

			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
						cache,
						sizeof(struct acpi_pptt_cache));

			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
			    cache_v1->cache_id == cache_id)
				return level;
		}
	}

	return -ENOENT;
}

int find_acpi_cache_level_from_id(u32 cache_id)
{
	int ret;
	acpi_status status;
	struct acpi_table_header *table;

	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
	if (ACPI_FAILURE(status)) {
		acpi_pptt_warn_missing();
		return -ENOENT;
	}

	ret = __find_acpi_cache_level_from_id(cache_id, table)
	acpi_put_table(table);
	return ret;
}


> +		acpi_put_table(table);
> +		return -ENOENT;
> +	}
> +
> +	/*
> +	 * If we found the cache first, we'd still need to walk from each CPU
> +	 * to find the level...
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> +		if (!cpu_node)
> +			break;
> +		acpi_count_levels(table, cpu_node, &num_levels, NULL);
> +
> +		/* Start at 1 for L1 */
> +		for (level = 1; level <= num_levels; level++) {
> +			cache = acpi_find_cache_node(table, acpi_cpu_id,
> +						     ACPI_PPTT_CACHE_TYPE_UNIFIED,
> +						     level, &cpu_node);
> +			if (!cache)
> +				continue;
> +
> +			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> +						cache,
> +						sizeof(struct acpi_pptt_cache));
> +
> +			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
> +			    cache_v1->cache_id == cache_id) {
> +				acpi_put_table(table);
> +				return level;
> +			}
> +		}
> +	}
> +
> +	acpi_put_table(table);
> +	return -ENOENT;
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 8c3165c2b083..82947f6d2a43 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1542,6 +1542,7 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu);
>  int find_acpi_cpu_topology_package(unsigned int cpu);
>  int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>  int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
> +int find_acpi_cache_level_from_id(u32 cache_id);
>  #else
>  static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>  {
> @@ -1568,6 +1569,10 @@ static inline int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
>  {
>  	return -EINVAL;
>  }
> +static inline int find_acpi_cache_level_from_id(u32 cache_id)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  void acpi_arch_init(void);


