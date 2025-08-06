Return-Path: <linux-kernel+bounces-758141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE74B1CB95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C7117DB6A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8371F0E26;
	Wed,  6 Aug 2025 18:03:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9981B960
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503415; cv=none; b=GevF//TZ8D28inxWVU/JMF9eDJW+KdY3Ic4StgNfx6+ytByh89RhOlTItA6sSG6ZWgwp8Ltbhy1wmTw3+eoEjetvXkRXBayhdxQMn5RdR4nhZjyX8JOFI27mkiKlPyxM/9jqWOFwvM9Xp7SLd9eyjdxcWdTS7ojmhoeJaIyBptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503415; c=relaxed/simple;
	bh=yWAL40Ngk9Uq4evHNsGp6DdrhnP+usHRaSodRtHKO/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mioeQdPMJedD02AOPBl/wXflL27lEk676sEdF4rBf8LJvoSeyt6KGeUP33vCFhqN2+JdY9skdv7Cd/hvWb7hQEO2s4YWaGMEwbgy8Oa0o22gfHD1ftx2Y33zqUdx05i/jH7TBBQu+ophq77sFsrPKxwMwY4ywXffqi2NLe1DE+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BAF8176C;
	Wed,  6 Aug 2025 11:03:24 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4651D3F738;
	Wed,  6 Aug 2025 11:03:18 -0700 (PDT)
Message-ID: <514df895-e9bc-4855-b18d-29b1949f67cf@arm.com>
Date: Wed, 6 Aug 2025 19:03:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/36] platform: arm64: Move ec devices to an ec
 subdirectory
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
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-13-james.morse@arm.com>
 <20250721173202.00002b51@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250721173202.00002b51@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jonathan,

On 21/07/2025 17:32, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 18:36:24 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> commit 363c8aea257 "platform: Add ARM64 platform directory" added a
>> subdirectory for arm64 platform devices, but claims that all such
>> devices must be 'EC like'.
>>
>> The arm64 MPAM driver manages an MMIO interface that appears in memory
>> controllers, caches, IOMMU and connection points on the interconnect.
>> It doesn't fit into any existing subsystem.
>>
>> It would be convenient to use this subdirectory for drivers for other
>> arm64 platform devices which aren't closely coupled to the architecture
>> code and don't fit into any existing subsystem.
>>
>> Move the existing code and maintainer entries to be under
>> drivers/platform/arm64/ec. The MPAM driver will be added under
>> drivers/platform/arm64/mpam.

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4bac4ea21b64..bea01d413666 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3549,15 +3549,15 @@ S:	Maintained
>>  F:	arch/arm64/boot/Makefile
>>  F:	scripts/make_fit.py
>>  
>> -ARM64 PLATFORM DRIVERS
>> -M:	Hans de Goede <hansg@kernel.org>
>> +ARM64 EC PLATFORM DRIVERS
>> +M:	Hans de Goede <hdegoede@redhat.com>
> 
> Smells like a rebase error as Hans' email address chagned
> to the kernel.org one in the 6.16 cycle.

Bother - yes, that's exactly what happened.


>>  M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>  R:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>  L:	platform-driver-x86@vger.kernel.org
>>  S:	Maintained
>>  Q:	https://patchwork.kernel.org/project/platform-driver-x86/list/
>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>> -F:	drivers/platform/arm64/
>> +F:	drivers/platform/arm64/ec

> Other than that looks sensible to me but obviously needs tags from Hans or Ilpo.


Thanks,

James

