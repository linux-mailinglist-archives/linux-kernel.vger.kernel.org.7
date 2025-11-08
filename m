Return-Path: <linux-kernel+bounces-891322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF7EC426EF
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 05:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 894F334AC0A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 04:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B48D283C87;
	Sat,  8 Nov 2025 04:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFK/RhjY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kwN//YEL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275C236A70
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 04:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762576308; cv=none; b=VYgMCyQgpzzTp07kAwNu04R6Tycra8r/Qs9hG9DKWI3qNC4GdEC8lHGycV3XHnf3bl7IgRQQrxyDMyXVpXxlwE351OadDci2fuwSA3rc3i1DFYfsu22owy/KdkJw0M7qbR/37+j4B8EOsGsMBYAmlJU1J/SnFUAAMx2U0RGfofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762576308; c=relaxed/simple;
	bh=Q/AN2q4B+8KYquEvvEbpRI1ceQuCQ64SKRyzXK6Kxhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRrU5U3eI3PD6TDMRE7xfppJyWich8EtsS0T7lATI1muS9stJpjWMoPgCA7rlcRErsik3LtUr064bFvzjlhjB0Bez3l1FAxCaoCY9MJed7rxzJ6XxKsYncRVNCiLLPUWJ0+bYwH9olW2OT4714B4cCz6xqAS+pj03ZUYuWwntzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFK/RhjY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kwN//YEL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762576305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf3dtK9whnvoieMQrk7xUOMK4ZkLioSOkS+mxb2q8k8=;
	b=BFK/RhjYE4Mfs/uB9b8NxKmCdFG6Ll4tYKxqSyXXcGBdzp1JIZBYt9nc5j/OX9N3dKhUL+
	2C0HUslAUVnyZ6lbkoSDWDjyJkEQG1IlSGNzHw+WqAsdsdnqf5nL0Ll3SvGRABKcxq7EHe
	VfzZy1X5LUUGT9yH5O7RXS+fKhVZHrk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-qxGcxRrDOHqADwhkgDX2vQ-1; Fri, 07 Nov 2025 23:31:44 -0500
X-MC-Unique: qxGcxRrDOHqADwhkgDX2vQ-1
X-Mimecast-MFC-AGG-ID: qxGcxRrDOHqADwhkgDX2vQ_1762576303
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2956a694b47so18841255ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 20:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762576303; x=1763181103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gf3dtK9whnvoieMQrk7xUOMK4ZkLioSOkS+mxb2q8k8=;
        b=kwN//YELf14PWedULYyHKMhjdDjuV60cGc0C06Gy8soXEKO6OpWqlbqU66+65eyjym
         JIUCKDf4iaJZYzOyTv2w4noCWnNDk3O7sn6YLzgAiK2v3vG7x30/zncj19+JD0WAh0T6
         2+IsfOReuU3gD3OiPVIvPHUKLSt0H7gn7R5VQYQHbwvRepOPhkMP474fkxji4uGbTm57
         DT6tMvQMck0puF+zLboBqnXOaTsHQiOSvOv7s8mt1tYK4eq04oEfjyh6nE/79ieAM5lZ
         PGtG2nLshjm4kIGODvLR1ncdsrB5wZitS9IfIIN9D04A+BoqoNPbDq/ukpapOQImq0+D
         LCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762576303; x=1763181103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gf3dtK9whnvoieMQrk7xUOMK4ZkLioSOkS+mxb2q8k8=;
        b=FeIwI6YOv4ZZ+ZYPgLjXuVbWNsx03CEoWf7YwtuBLeXLwbZ4QLiVvOadE2DbETo+J+
         Trf0Qjex0RX1vdMYEI35jxQaUG+5xyQRmYFMS+o/iq/MVNqj8xBJ+N0DcmazHIs4y0qh
         88EFTkuJJRnQwaAmX+EX9cg/1N8s1Gs2pvCqNDilIszcdOFNlDk0q+QWIc0dIOuV9/RC
         doTaYPrBC9spFpysS/mGE+RkjNdgtLHuihjvvICvJ6F36vwgo+lpf7eTrn9OPNoAvs3I
         iNgMhv9jLzAksvUKrk9R3bni4736MFqWMId+ltNXMbZjf+pu5j9W4bVs8iSA/pJqczlu
         Nk1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/zqN3/6U9qChJwiwNexOdwujPk3W+a6Inc8NIZUIh+LHkQ31Wkbt8UIrDFrxMgWhI4IpSWuPfyrf/vLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyI267K1YnWpy9yYVSPkIm9Y5PHfQT7vyfsvTy8JLBCAAylD9
	ATUTJMR9G3zv4YetrdZXbm/WLtzGedGD3ldCEHVp2mSWVFVOKFiBGMoU5UETiko8aYid1PkYB+n
	4YNPIoAt5aZEJD5DrUjSoL3+OtmyDN5LshZfjp1Zu0Nz5mnsTXYBfWXEGJhso+wOzyQ==
X-Gm-Gg: ASbGncukt+KACBmXlwA3Ohmp/jpI6d0SlPmFp/6LnGGFTw1wgVYlKZd4MEEMELqup2y
	gFSJDxEUSF2Zm01GmM1y1mXYxQ9WHaxMQMIyMSDdL8GuJ3UwqSZpcbNDOSwzRakof9EE/wXWfRX
	cVVbTcbgGzlWO27FEev2VeSUj3+V8pQJsgjNHnI0qiWKa2mJkP2q96Fi/V2fCl4kP5xjKV91XNB
	ATN7vrWf+kPaSvrS9hM2bjANkvNGYA82AxpD5+wzjQfMFW/4r/Qmaj3q1K5UmxZK2/k7cLe8UZQ
	grYoDJL2y4MnX5oWsS+1qQDR2R8z0gF/vm3NXrSQvn8D1Lj59lp0bgPSDAAauSEyKSys7JDakZH
	ghaTFDpa7CDrRIIUBqmIGgDXqzuh+FMhpm5I2LBw=
X-Received: by 2002:a17:903:40c9:b0:295:56da:62a4 with SMTP id d9443c01a7336-297e56caea4mr15886865ad.45.1762576302820;
        Fri, 07 Nov 2025 20:31:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQTitOB0enfK3OsnV3JV6rJIse5pQU20FSNU11DFWBQoFKK5PuvCsMDdw2vNkdjw8y8BgN8Q==
X-Received: by 2002:a17:903:40c9:b0:295:56da:62a4 with SMTP id d9443c01a7336-297e56caea4mr15886445ad.45.1762576302385;
        Fri, 07 Nov 2025 20:31:42 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0ee9sm76355185ad.112.2025.11.07.20.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 20:31:41 -0800 (PST)
Message-ID: <11f80800-2e0b-4f41-a022-a88ad9792da8@redhat.com>
Date: Sat, 8 Nov 2025 14:31:28 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 processor container
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-2-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-2-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> The ACPI MPAM table uses the UID of a processor container specified in
> the PPTT to indicate the subset of CPUs and cache topology that can
> access each MPAM System Component (MSC).
> 
> This information is not directly useful to the kernel. The equivalent
> cpumask is needed instead.
> 
> Add a helper to find the processor container by its id, then walk
> the possible CPUs to fill a cpumask with the CPUs that have this
> processor container as a parent.
> 
> CC: Dave Martin <dave.martin@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Refer to processor hierarchy in comments (Jonathan)
> Fix indent (Jonathan)
> ---
>   drivers/acpi/pptt.c  | 85 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  3 ++
>   2 files changed, 88 insertions(+)
> 

Two nitpicks below...

> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 54676e3d82dd..69917cc6bd2f 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -817,3 +817,88 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>   	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>   					  ACPI_PPTT_ACPI_IDENTICAL);
>   }
> +
> +/**
> + * acpi_pptt_get_child_cpus() - Find all the CPUs below a PPTT
> + * processor hierarchy node
> + *
> + * @table_hdr:		A reference to the PPTT table
> + * @parent_node:	A pointer to the processor hierarchy node in the
> + *			table_hdr
> + * @cpus:		A cpumask to fill with the CPUs below @parent_node
> + *
> + * Walks up the PPTT from every possible CPU to find if the provided
> + * @parent_node is a parent of this CPU.
> + */
> +static void acpi_pptt_get_child_cpus(struct acpi_table_header *table_hdr,
> +				     struct acpi_pptt_processor *parent_node,
> +				     cpumask_t *cpus)
> +{
> +	struct acpi_pptt_processor *cpu_node;
> +	u32 acpi_id;
> +	int cpu;
> +
> +	cpumask_clear(cpus);
> +
> +	for_each_possible_cpu(cpu) {
> +		acpi_id = get_acpi_id_for_cpu(cpu);
> +		cpu_node = acpi_find_processor_node(table_hdr, acpi_id);
> +
> +		while (cpu_node) {
> +			if (cpu_node == parent_node) {
> +				cpumask_set_cpu(cpu, cpus);
> +				break;
> +			}
> +			cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
> +		}
> +	}
> +}
> +
> +/**
> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPUs in a
> + *                                       processor container
> + * @acpi_cpu_id:	The UID of the processor container
> + * @cpus:		The resulting CPU mask
> + *
> + * Find the specified Processor Container, and fill @cpus with all the cpus
> + * below it.
> + *
> + * Not all 'Processor Hierarchy' entries in the PPTT are either a CPU
> + * or a Processor Container, they may exist purely to describe a
> + * Private resource. CPUs have to be leaves, so a Processor Container
> + * is a non-leaf that has the 'ACPI Processor ID valid' flag set.
> + */
> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
> +{
> +	struct acpi_table_header *table_hdr;
> +	struct acpi_subtable_header *entry;
> +	unsigned long table_end;
> +	u32 proc_sz;
> +
> +	cpumask_clear(cpus);
> +
> +	table_hdr = acpi_get_pptt();
> +	if (!table_hdr)
> +		return;
> +
> +	table_end = (unsigned long)table_hdr + table_hdr->length;
> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> +			     sizeof(struct acpi_table_pptt));
> +	proc_sz = sizeof(struct acpi_pptt_processor);
> +	while ((unsigned long)entry + proc_sz <= table_end) {
> +

Unnecessary blank line here.

> +		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR) {
> +			struct acpi_pptt_processor *cpu_node;
> +
> +			cpu_node = (struct acpi_pptt_processor *)entry;
> +			if (cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID &&
> +			    !acpi_pptt_leaf_node(table_hdr, cpu_node) &&
> +			    cpu_node->acpi_processor_id == acpi_cpu_id) {
> +				acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
> +				break;
> +			}
> +		}
> +		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
> +				     entry->length);

Need we to check if @cpu_node does crosses the boundary (@table_end), as what's
doing in acpi_find_processor_node()? Actually, the similar hunk of code from
the function can be reused here.

static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_header *table_hdr,
                                                             u32 acpi_cpu_id)
{
		:
	while ((unsigned long)entry + proc_sz <= table_end) {
                 cpu_node = (struct acpi_pptt_processor *)entry;

                 if (entry->length == 0) {
                         pr_warn("Invalid zero length subtable\n");
                         break;
                 }

                 /* entry->length may not equal proc_sz, revalidate the processor structure length */
                 if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
                     acpi_cpu_id == cpu_node->acpi_processor_id &&
                     (unsigned long)entry + entry->length <= table_end &&
                     entry->length == proc_sz + cpu_node->number_of_priv_resources * sizeof(u32) &&
                      acpi_pptt_leaf_node(table_hdr, cpu_node)) {
                         return (struct acpi_pptt_processor *)entry;
                 }

                 entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
                                      entry->length);
	}

		:
}


> +	}
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 5ff5d99f6ead..4752ebd48132 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1541,6 +1541,7 @@ int find_acpi_cpu_topology(unsigned int cpu, int level);
>   int find_acpi_cpu_topology_cluster(unsigned int cpu);
>   int find_acpi_cpu_topology_package(unsigned int cpu);
>   int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
> +void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
>   #else
>   static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>   {
> @@ -1562,6 +1563,8 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>   {
>   	return -EINVAL;
>   }
> +static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
> +						     cpumask_t *cpus) { }
>   #endif
>   
>   void acpi_arch_init(void);

Thanks,
Gavin


