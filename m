Return-Path: <linux-kernel+bounces-746061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE0DB122AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A167F7B8B43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D752EFDB4;
	Fri, 25 Jul 2025 17:06:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6952EF9D5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463166; cv=none; b=N3u/4YKOYHW/o1bcbovkoKwf3a8+EuDSG292doa+FvFnvdzueG+6s5kdCFv8s+MVm/FA0iadow7XBs06wnRzrump6zmBInN1rAbo8STHpOk3ScgCwNv8XeX643eZWFXWYRZ+xZFCy6fFgK1ArOEqgdAsqOa+3y6yFB1+xIrtRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463166; c=relaxed/simple;
	bh=sUnMmghG3K0XmTiWULZ2zPSu0EwKFFvlidAFa+7DMkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPWh1m5IiUV1H7ANXaXDprbSAr0FurU6frJ04gOiwOm/cK12t8BfKWfzKeLsgFA3AigiIO9Ap/olkwhXchRnUKB9v8l3rBZg6BApJupepqwxGpvRh4uhVjYszG4vsqdviq9CRkwgSGEV8dCjEEj0J3MA0t4JgO91KjqMUjjXWm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01C1E176C;
	Fri, 25 Jul 2025 10:05:58 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A0BC3F66E;
	Fri, 25 Jul 2025 10:06:00 -0700 (PDT)
Message-ID: <1097d0cf-deb7-4247-93eb-2fe8b23dbd6c@arm.com>
Date: Fri, 25 Jul 2025 18:05:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/36] ACPI / PPTT: Add a helper to fill a cpumask
 from a processor container
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
 <20250711183648.30766-6-james.morse@arm.com>
 <20250722152807.000069d3@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250722152807.000069d3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 22/07/2025 15:28, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 18:36:17 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> The PPTT describes CPUs and caches, as well as processor containers.
>> The ACPI table for MPAM describes the set of CPUs that can access an MSC
>> with the UID of a processor container.
>>
>> Add a helper to find the processor container by its id, then walk
>> the possible CPUs to fill a cpumask with the CPUs that have this
>> processor container as a parent.

>> +/**
>> + * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPUs in a
>> + *                                       processor containers
>> + * @acpi_cpu_id:	The UID of the processor container.
>> + * @cpus		The resulting CPU mask.

> Missing colon.
> 
> From a W=1 build (and hence kernel-doc warning).

Thanks!

W=1 spews so much output I tend to rely on the kbuild robot to report if I'm making it worse!


James

