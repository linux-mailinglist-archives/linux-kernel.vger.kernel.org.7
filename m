Return-Path: <linux-kernel+bounces-749388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D9B14DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1779F545398
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9047C2741CE;
	Tue, 29 Jul 2025 12:31:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9041D156CA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792275; cv=none; b=IUon+JUrbWDLDPw5QMKIqXQPRR1pAufNcvGzulnIun/7ivFchfp7M3RQfft8TBAhxSRBjePBWqETnuP3RYXa4uI35fvmDBvh0oxiOButdvsLSKhwCTmd1fPUMyMI75TfLIZGS5cuOUlKo7529Lb50Xeb+uSAWOQqfD1sIOI4Vvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792275; c=relaxed/simple;
	bh=1xrPYfRT5/UXSh2kIirV17Q/ZvkY4matxR8vh416ZV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ai/jrokPIzPLr9Ivogy1p6mlPllDqXNxgvQO3Qt0PtNLbEzV9uHD7wsKclCFQGA8V9C6ZhoSt5/JUrf/3KBLZQBZKXajhCLjSV4VP+sECOKFCk2SdHVCxPHQ5jX7+j3WKVP8nU9mGW/75wH5kHb2u8xCw7VJuXBLdEJetc7K/Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14F041516;
	Tue, 29 Jul 2025 05:31:05 -0700 (PDT)
Received: from [10.57.3.117] (unknown [10.57.3.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A99D3F673;
	Tue, 29 Jul 2025 05:31:11 -0700 (PDT)
Message-ID: <422098f2-4c91-4e55-a890-7e80a1e04249@arm.com>
Date: Tue, 29 Jul 2025 13:31:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] coresight: Fix and improve clock usage
Content-Language: en-GB
To: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
 <175343531849.493374.1972746372917823.b4-ty@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <175343531849.493374.1972746372917823.b4-ty@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/07/2025 10:22, Suzuki K Poulose wrote:
> 
> On Thu, 24 Jul 2025 16:22:30 +0100, Leo Yan wrote:
>> This series fixes and improves clock usage in the Arm CoreSight drivers.
>>
>> Based on the DT binding documents, the trace clock (atclk) is defined in
>> some CoreSight modules, but support is absent. In most cases, the issue
>> is hidden because the atclk clock is shared by multiple CoreSight
>> modules and the clock is enabled anyway by other drivers. The first
>> three patches address this issue.
>>
>> [...]
> 
> Applied, thanks!
> 
> [01/10] coresight: tmc: Support atclk
>          https://git.kernel.org/coresight/c/e96d605a66ff
> [02/10] coresight: catu: Support atclk
>          https://git.kernel.org/coresight/c/7eca4399060d
> [03/10] coresight: etm4x: Support atclk
>          https://git.kernel.org/coresight/c/14fb833b8204
> [04/10] coresight: Appropriately disable programming clocks
>          https://git.kernel.org/coresight/c/ce15ee28bddd
> [05/10] coresight: Appropriately disable trace bus clocks
>          https://git.kernel.org/coresight/c/90b0000bd501
> [06/10] coresight: Avoid enable programming clock duplicately
>          https://git.kernel.org/coresight/c/5c0ead76597b
> [07/10] coresight: Consolidate clock enabling
>          https://git.kernel.org/coresight/c/f47d7f7da638
> [08/10] coresight: Refactor driver data allocation
>          https://git.kernel.org/coresight/c/7471c81e60b9
> [09/10] coresight: Make clock sequence consistent
>          https://git.kernel.org/coresight/c/d4cf59aa905b
> [10/10] coresight: Refactor runtime PM
>          https://git.kernel.org/coresight/c/2b52cf338d39
> 
> Best regards,

I have dropped this from -next, due to the issues reported by
Mark.

Suzuki


