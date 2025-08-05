Return-Path: <linux-kernel+bounces-756764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C76B1B8F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8ED183F54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4A1277026;
	Tue,  5 Aug 2025 17:06:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD29720A5EC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413618; cv=none; b=pN24cmZw8pFDDfv6JCa7Fp9R3NNt86sbJwYasJmgJxd5m8uWDLXePTfIhO//TiQB8a194w6m95o979B89bdl/rDRY36a6+7SP0AXr0nooLL6mz+nmA4F/CwscYJ9DOdDk5IR5sMaq+3OFgaNLuBAgt0SHck4OGqnlpnEKzTDbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413618; c=relaxed/simple;
	bh=mjEIOao5QKD/MF2MfNJrHOvpFaMMSoJcsWCYROuYyf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvdnqlkW4uI7cfC9FMHOPvLZa+3HwrX+TO7OOXrLFucPs3Pm/bMI31zpi4ziE/dFCiqMe01udQvKY6ei7KFDY/ut3OYqDyXrZxClxRE0P5W2U6Cas87w1Y/s9Y2hDTmYzthHZ5WpWRMdh7/6ZyF+5pnu+TidpZGZCoMgfEeVc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF5E1150C;
	Tue,  5 Aug 2025 10:06:47 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 408923F673;
	Tue,  5 Aug 2025 10:06:51 -0700 (PDT)
Message-ID: <d6aeda30-152f-4dde-ba76-57f703f24b1c@arm.com>
Date: Tue, 5 Aug 2025 18:06:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/36] ACPI / PPTT: Find cache level by cache-id
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Rohit Mathew <rohit.mathew@arm.com>,
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
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-8-james.morse@arm.com>
 <20250716172144.00000715@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250716172144.00000715@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 16/07/2025 17:21, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 18:36:19 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> The MPAM table identifies caches by id. The MPAM driver also wants to know
>> the cache level to determine if the platform is of the shape that can be
>> managed via resctrl. Cacheinfo has this information, but only for CPUs that
>> are online.
>>
>> Waiting for all CPUs to come online is a problem for platforms where
>> CPUs are brought online late by user-space.
>>
>> Add a helper that walks every possible cache, until it finds the one
>> identified by cache-id, then return the level.
>>
>> acpi_count_levels() expects its levels parameter to be initialised to
>> zero as it passes it to acpi_find_cache_level() as starting_level.
>> The existing callers do this. Document it.

> A few suggestions inline.  Mostly driven by the number of missing table
> puts I've seen in ACPI code. You don't have any missing here but with a
> bit of restructuring you can make that easy to see.

Sounds good,


>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 13ca2eee3b98..f53748a5df19 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -912,3 +912,76 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>>  	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>>  					  ACPI_PPTT_ACPI_IDENTICAL);
>>  }
>> +
>> +/**
>> + * find_acpi_cache_level_from_id() - Get the level of the specified cache
>> + * @cache_id: The id field of the unified cache
>> + *
>> + * Determine the level relative to any CPU for the unified cache identified by
>> + * cache_id. This allows the property to be found even if the CPUs are offline.
>> + *
>> + * The returned level can be used to group unified caches that are peers.
>> + *
>> + * The PPTT table must be rev 3 or later,
>> + *
>> + * If one CPUs L2 is shared with another as L3, this function will return
>> + * an unpredictable value.
>> + *
>> + * Return: -ENOENT if the PPTT doesn't exist, or the cache cannot be found.
>> + * Otherwise returns a value which represents the level of the specified cache.
>> + */
>> +int find_acpi_cache_level_from_id(u32 cache_id)
>> +{
>> +	u32 acpi_cpu_id;
>> +	acpi_status status;
>> +	int level, cpu, num_levels;
>> +	struct acpi_pptt_cache *cache;
>> +	struct acpi_table_header *table;
>> +	struct acpi_pptt_cache_v1 *cache_v1;
>> +	struct acpi_pptt_processor *cpu_node;
>> +
>> +	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
>> +	if (ACPI_FAILURE(status)) {
>> +		acpi_pptt_warn_missing();
>> +		return -ENOENT;
>> +	}
>> +
>> +	if (table->revision < 3) {


> Maybe a unified exit path given all paths need to do
> acpi_put_table() and return either error or level.
> 
> Or maybe it's time for some cleanup.h magic for acpi tables. I've
> been thinking about it for a while and mostly stuck on the name ;)

(Isn't that the hard bit?)


> (simpler suggestion follows)
> 
> static struct acpi_table_header *acpi_get_table_ret(char *signature, u32 instance)
> {
> 	struct acpi_table_header *table;
> 	int status = acpi_get_table(signature, instance, &table);
> 	
> 	if (ACPI_FAILURE(status))
> 		return ERR_PTR(-ENOENT);
> 	return table;
> }
> 
> DEFINE_FREE(acpi_table, struct acpi_table_header *, if (!IS_ERR(_T)) acpi_put_table(_T))
> 
> Finally in here and loads of other places we avoid chance of missing an acpi_put_table
> and generally simplify the code a little.
> 
> int find_acpi_cache_level_from_id(u32 cache_id)
> {
> 	u32 acpi_cpu_id;
> 	acpi_status status;
> 	int level, cpu, num_levels;
> 	struct acpi_pptt_cache *cache;
> 	struct acpi_pptt_cache_v1 *cache_v1;
> 	struct acpi_pptt_processor *cpu_node;
> 
> 
> 	struct acpi_table_header *table __free(acpi_table) =
> 		acpi_get_table_ret(ACPI_SIG_PPTT, 0);
> 
> 	if (IS_ERR(table)
> 		return PTR_ERR(table);
> 
> 	if (table->revision < 3)
> 		return -ENOENT;
> 
> 	/*
> 	 * If we found the cache first, we'd still need to walk from each CPU
> 	 * to find the level...
> 	 */
> 	for_each_possible_cpu(cpu) {
> 		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> 		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> 		if (!cpu_node)
> 			return -ENOENT;
> 		acpi_count_levels(table, cpu_node, &num_levels, NULL);
> 
> 		/* Start at 1 for L1 */
> 		for (level = 1; level <= num_levels; level++) {
> 			cache = acpi_find_cache_node(table, acpi_cpu_id,
> 						     ACPI_PPTT_CACHE_TYPE_UNIFIED,
> 						     level, &cpu_node);
> 			if (!cache)
> 				continue;
> 
> 			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> 						cache,
> 						sizeof(struct acpi_pptt_cache));
> 
> 			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
> 			    cache_v1->cache_id == cache_id) {
> 				acpi_put_table(table);
> 				return level;
> 			}
> 		}
> 	}
> 	return -ENOENT;
> }
> 
> 
> A less 'fun' alternative is pull some code out as a helper to make put the get and put
> near each other with no conditionals to confuse things.

I still find the cleanup stuff slightly sickening ... so lets use it some more.

Added to linux/acpi.h to make it easier to use elsewhere. I think the earlier patches in
this series are simple enough in this area its not worth changing them...


Thanks,

James

