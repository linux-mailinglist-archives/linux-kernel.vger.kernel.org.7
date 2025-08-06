Return-Path: <linux-kernel+bounces-758144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0B2B1CB98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC6B626C77
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9CC1F0E26;
	Wed,  6 Aug 2025 18:04:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9161EA7CF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503457; cv=none; b=Btb5aQ1DI5NqcWw/bbqETXYqbIpDGNYlTtoGxbghRuJ6QvDKGrA7S1D9Y8b/pjbB1PUHglAnnAMMIwGpIsOBjOb9H7/hau3bfksDPgqar9289bNfqEPW7g9vwGYQVtwgox2qlXjNpGGORcuksAO1YJz+8LwOXbyTQM52RiO/1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503457; c=relaxed/simple;
	bh=85QX/kG+EB2oGh7pLPRIpkxE6/0C+8XGuHFXj07ZXJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7jOjp0+wzbri38Ej19V5E+48yCcDJs7R6vAhuP+N1AdaucZecSp2I42CGCmvpTUNFmmeufHOsYZRA+CMgvdTVqCjMb3D5nviuO4/UWRoyzUr1r1I5G78hV+VNPLxHoyK8odIno//CGYKpiOviZNd2Kb1WfVzAohObcFBKldzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04131176C;
	Wed,  6 Aug 2025 11:04:07 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B85C3F738;
	Wed,  6 Aug 2025 11:04:09 -0700 (PDT)
Message-ID: <6a77726d-1881-4590-8021-623c877bb5d7@arm.com>
Date: Wed, 6 Aug 2025 19:04:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/36] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
To: Catalin Marinas <catalin.marinas@arm.com>
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
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-14-james.morse@arm.com> <aIIiazUK4S_G6loe@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <aIIiazUK4S_G6loe@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Catalin,

On 24/07/2025 13:09, Catalin Marinas wrote:
> On Fri, Jul 11, 2025 at 06:36:25PM +0000, James Morse wrote:
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>> only be accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until
>> the system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
>> Start with driver probe/remove and mapping the MSC.

>>  arch/arm64/Kconfig                          |   1 +
>>  drivers/platform/arm64/Kconfig              |   1 +
>>  drivers/platform/arm64/Makefile             |   1 +
>>  drivers/platform/arm64/mpam/Kconfig         |  10 +
>>  drivers/platform/arm64/mpam/Makefile        |   4 +
>>  drivers/platform/arm64/mpam/mpam_devices.c  | 336 ++++++++++++++++++++
>>  drivers/platform/arm64/mpam/mpam_internal.h |  62 ++++
>>  7 files changed, 415 insertions(+)
>>  create mode 100644 drivers/platform/arm64/mpam/Kconfig
>>  create mode 100644 drivers/platform/arm64/mpam/Makefile
>>  create mode 100644 drivers/platform/arm64/mpam/mpam_devices.c
>>  create mode 100644 drivers/platform/arm64/mpam/mpam_internal.h

> Bikeshedding: why not drivers/resctrl to match fs/resctrl? We wouldn't
> need the previous patch either to move the arm64 platform drivers.

Initially because I don't see any other architecture having an MMIO interface to this
stuff, and didn't want a 'top level' driver directory for a single driver. But, re-reading
RISC-Vs CBQRI[0] it turns out that theirs is memory mapped...


> I'm not an expert on resctrl but the MPAM code looks more like a backend
> for the resctrl support, so it makes more sense to do as we did for
> other drivers like irqchip, iommu.

Only because there are many irqchip or iommu. I'm not a fan of drivers/mpam, but
drivers/resctrl would suit RISC-V too. (I'll check with Drew)


Thanks,

James

[0] https://patchew.org/linux/20230419111111.477118-1-dfustini@baylibre.com/

