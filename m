Return-Path: <linux-kernel+bounces-746059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112D2B122AC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CD43A3CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE24C2EF9B5;
	Fri, 25 Jul 2025 17:05:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB042882DC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463159; cv=none; b=SH1Zk5rL0yj7/W2CHyI0euOR1+hTS/eWZ1jlud4OacpegDaALH+PAQLQmlz591TU4KnaHFb9U32MFBIdWVrrapgCRUWrW/6PG9+ivwqYCL5G8Wkax3FlC/UVM03GCpThKDHy4LOA+02vZvoEuZRBhZLv18FjnzkMVs07gNqsaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463159; c=relaxed/simple;
	bh=7d/+iASQMybHR/tMX/RIRDRqSIKIWpUdei5sXq19BN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcIOd+MraEpWKF+w5+J7jkk4SgzdeinxngEsBc0ZylNEH+r/iTQ3gPUkVJsCw63o1eZp6qnCT0Lo+wcjzMEdNwO5EODaGAJJiQzq19R2X9zHvShL3qz6QvpXv8Ai38AACPyng07CVAJOG5U6xlMuDWcQS6x+CcsXOGrU+35YfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD78C176C;
	Fri, 25 Jul 2025 10:05:48 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E763F66E;
	Fri, 25 Jul 2025 10:05:51 -0700 (PDT)
Message-ID: <3fe6b4a6-d27b-4530-9f76-eb6c0daabbde@arm.com>
Date: Fri, 25 Jul 2025 18:05:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/36] ACPI / PPTT: Add a helper to fill a cpumask
 from a processor container
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
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
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-6-james.morse@arm.com>
 <46e3ead8-411d-4e51-b38b-da791e568b94@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <46e3ead8-411d-4e51-b38b-da791e568b94@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ben,

On 23/07/2025 15:42, Ben Horgan wrote:
> On 7/11/25 19:36, James Morse wrote:
>> The PPTT describes CPUs and caches, as well as processor containers.
>> The ACPI table for MPAM describes the set of CPUs that can access an MSC
>> with the UID of a processor container.
>>
>> Add a helper to find the processor container by its id, then walk
>> the possible CPUs to fill a cpumask with the CPUs that have this
>> processor container as a parent.

>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 54676e3d82dd..13619b1b821b 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -298,6 +298,99 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct
>> +/**
>> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPUs in a
>> + *                                       processor containers
>> + * @acpi_cpu_id:    The UID of the processor container.
>> + * @cpus        The resulting CPU mask.
>> + *
>> + * Find the specified Processor Container, and fill @cpus with all the cpus
>> + * below it.
>> + *
>> + * Not all 'Processor' entries in the PPTT are either a CPU or a Processor
>> + * Container, they may exist purely to describe a Private resource. CPUs
>> + * have to be leaves, so a Processor Container is a non-leaf that has the
>> + * 'ACPI Processor ID valid' flag set.
>> + *
>> + * Return: 0 for a complete walk, or an error if the mask is incomplete.
>> + */
>> +int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
>> +{
>> +    struct acpi_pptt_processor *cpu_node;
>> +    struct acpi_table_header *table_hdr;
>> +    struct acpi_subtable_header *entry;
>> +    bool leaf_flag, has_leaf_flag = false;
>> +    unsigned long table_end;
>> +    acpi_status status;
>> +    u32 proc_sz;
>> +    int ret = 0;
>> +
>> +    cpumask_clear(cpus);
>> +
>> +    status = acpi_get_table(ACPI_SIG_PPTT, 0, &table_hdr);
>> +    if (ACPI_FAILURE(status))
>> +        return 0;
>> +
>> +    if (table_hdr->revision > 1)
>> +        has_leaf_flag = true;
>> +
>> +    table_end = (unsigned long)table_hdr + table_hdr->length;
>> +    entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
>> +                 sizeof(struct acpi_table_pptt));
>> +    proc_sz = sizeof(struct acpi_pptt_processor);
>> +    while ((unsigned long)entry + proc_sz <= table_end) {
>> +        cpu_node = (struct acpi_pptt_processor *)entry;
>> +        if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
>> +            cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) {
>> +            leaf_flag = cpu_node->flags & ACPI_PPTT_ACPI_LEAF_NODE;
>> +            if ((has_leaf_flag && !leaf_flag) ||
>> +                (!has_leaf_flag && !acpi_pptt_leaf_node(table_hdr, cpu_node))) {
>> +                if (cpu_node->acpi_processor_id == acpi_cpu_id)
>> +                    acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
>> +            }

> acpi_pptt_leaf_node() returns early based on the leaf flag so you can just rely on that
> here; remove has_leaf_flag and the corresponding extra logic.

Aha! I was only doing this to try and avoid that extra descent of the tree. I missed that
its already taken into account.


Thanks,

James

