Return-Path: <linux-kernel+bounces-756765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D769FB1B8F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A264E18A6EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF297292B36;
	Tue,  5 Aug 2025 17:07:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C51552FD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413628; cv=none; b=AE0x0/wtVGAYBIiKtRTn4/WX9LJRLmONIzN0JdMTNb0rGfBS9XMzsRUEXU6liHEQH8w1JdhfSjam9kzFgrZ2eF3dqPlpLaS0LE5dKL9/kBHaTfBqfIn4ta3YpNnM0yZT1S4NwJHdclTGpFVPArnHcL8Ih8VoJwyJt5w21zMcuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413628; c=relaxed/simple;
	bh=g5C/io3TOQ7jken/35p/RbosbLsPPnOWDKRxiSD7t9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8trDmhxM8iG9KY1ad8zIFguIa2QIRDYYTU5fVcjH96UDtL2/bcokHsutslUDMT//XIuoYFSRQpkxwt6yVlG9JPIBAlVAfVbCj/0J9MoQy2cETz9ECNbIYtVXi9Dd2N460+2TXP0hLrYVTOaDiU507U4zB7ipLMsRJWZnqPcjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B98F150C;
	Tue,  5 Aug 2025 10:06:58 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2A433F673;
	Tue,  5 Aug 2025 10:06:57 -0700 (PDT)
Message-ID: <20b39d32-b50e-4ab7-a060-6d7221e9d893@arm.com>
Date: Tue, 5 Aug 2025 18:06:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/36] ACPI / PPTT: Add a helper to fill a cpumask
 from a cache_id
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
 <20250711183648.30766-9-james.morse@arm.com>
 <20250716172442.000001d6@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250716172442.000001d6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 16/07/2025 17:24, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 18:36:20 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
>>
>> The driver needs to know which CPUs are associated with the cache,
>> the CPUs may not all be online, so cacheinfo does not have the
>> information.
>>
>> Add a helper to pull this information out of the PPTT.

>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index f53748a5df19..81f7ac18c023 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -985,3 +985,73 @@ int find_acpi_cache_level_from_id(u32 cache_id)

>> +int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
>> +{
>> +	u32 acpi_cpu_id;
>> +	acpi_status status;
>> +	int level, cpu, num_levels;
>> +	struct acpi_pptt_cache *cache;
>> +	struct acpi_table_header *table;
>> +	struct acpi_pptt_cache_v1 *cache_v1;
>> +	struct acpi_pptt_processor *cpu_node;
>> +
>> +	cpumask_clear(cpus);
>> +
>> +	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);

> Similar suggestions to previous patch apply here as well.

Done!


> 
>> +	if (ACPI_FAILURE(status)) {
>> +		acpi_pptt_warn_missing();
>> +		return -ENOENT;
>> +	}
>> +
>> +	if (table->revision < 3) {
>> +		acpi_put_table(table);
>> +		return -ENOENT;
>> +	}
>> +
>> +	/*
>> +	 * If we found the cache first, we'd still need to walk from each cpu.
>> +	 */
>> +	for_each_possible_cpu(cpu) {
>> +		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>> +		if (!cpu_node)
>> +			break;
>> +		acpi_count_levels(table, cpu_node, &num_levels, NULL);
>> +
>> +		/* Start at 1 for L1 */
>> +		for (level = 1; level <= num_levels; level++) {
>> +			cache = acpi_find_cache_node(table, acpi_cpu_id,
>> +						     ACPI_PPTT_CACHE_TYPE_UNIFIED,
>> +						     level, &cpu_node);
>> +			if (!cache)
>> +				continue;
>> +
>> +			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
>> +						cache,
>> +						sizeof(struct acpi_pptt_cache));
>> +
>> +			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
>> +			    cache_v1->cache_id == cache_id) {
>> +				cpumask_set_cpu(cpu, cpus);
>> +			}

> Unnecessary {}  Fine to keep them if you add something else here later.

The condition being broken over multiple lines de-rails my C parsing abilities... 'Fixed'.


Thanks,

James

