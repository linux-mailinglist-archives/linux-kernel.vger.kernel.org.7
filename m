Return-Path: <linux-kernel+bounces-758146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4811B1CB9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937411888D34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48AE1F0E26;
	Wed,  6 Aug 2025 18:04:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03A21990A7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503486; cv=none; b=slHkaLHfoQ+fsOpk4zGG+QFsjSfSHcaZekubiKFNjOxNbdGec70/2IwyDLYQTUJKGX0cPGlVtF78D2anwubxNlvjp0r8rGo3wfL+oNtrUo/ZSLsFw22T6CMZ3ax+Uh3hGtWrxyrEJj+Bt3cc4SJjLc15myLPMOhPDW0hj2E5EC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503486; c=relaxed/simple;
	bh=Qhn8PBec+7adJwWZMI2WufQ740LOh7u74Ojn/AWu7AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAU1YJYCOtpXSKXiiAM7KHO+Xu9kfhtI/U/ZvgW98E/pI0gllpH1Bs73Tf62766EvT5uMtl3nHPpj0jHQ+7pkqbyZYr6GLyfVt7t7byqk/At9EIWxlXkl4eU7v9RhJNYMyHRATwHI97LnIlAUSU5klwMLx/97kfdYxKYpxsue1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4398F176C;
	Wed,  6 Aug 2025 11:04:36 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D27493F738;
	Wed,  6 Aug 2025 11:04:38 -0700 (PDT)
Message-ID: <897b0cde-79b7-403b-91b2-7688cfd3f893@arm.com>
Date: Wed, 6 Aug 2025 19:04:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/36] arm_mpam: Add MPAM MSC register layout
 definitions
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "amitsinght@marvell.com" <amitsinght@marvell.com>,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-17-james.morse@arm.com>
 <OSZPR01MB87980409C12B21D619324C5E8B51A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <OSZPR01MB87980409C12B21D619324C5E8B51A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 17/07/2025 02:04, Shaopeng Tan (Fujitsu) wrote:
>> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
>> (MSCs) with an identity/configuration page.
>>
>> Add the definitions for these registers as offset within the page(s).

>> diff --git a/drivers/platform/arm64/mpam/mpam_internal.h
>> b/drivers/platform/arm64/mpam/mpam_internal.h
>> index d49bb884b433..9110c171d9d2 100644
>> --- a/drivers/platform/arm64/mpam/mpam_internal.h
>> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
>> @@ -150,4 +150,272 @@ extern struct list_head mpam_classes;  int

>> +/*
>> + * MSMON_CFG_CSU_CTL - Memory system performance monitor configure
>> cache storage
>> + *                    usage monitor control register
>> + * MSMON_CFG_MBWU_CTL - Memory system performance monitor
>> configure memory
>> + *                     bandwidth usage monitor control register
>> + */
>> +#define MSMON_CFG_x_CTL_TYPE           GENMASK(7, 0)
>> +#define MSMON_CFG_x_CTL_OFLOW_STATUS_L BIT(15)
>> +#define MSMON_CFG_x_CTL_MATCH_PARTID   BIT(16)
>> +#define MSMON_CFG_x_CTL_MATCH_PMG      BIT(17)
>> +#define MSMON_CFG_x_CTL_SCLEN          BIT(19)
>> +#define MSMON_CFG_x_CTL_SUBTYPE        GENMASK(23, 20)
>> +#define MSMON_CFG_x_CTL_OFLOW_FRZ      BIT(24)
>> +#define MSMON_CFG_x_CTL_OFLOW_INTR     BIT(25)
>> +#define MSMON_CFG_x_CTL_OFLOW_STATUS   BIT(26)
>> +#define MSMON_CFG_x_CTL_CAPT_RESET     BIT(27)
>> +#define MSMON_CFG_x_CTL_CAPT_EVNT      GENMASK(30, 28)
>> +#define MSMON_CFG_x_CTL_EN             BIT(31)
>> +
>> +#define MSMON_CFG_MBWU_CTL_TYPE_MBWU
>> 	0x42
>> +#define MSMON_CFG_MBWU_CTL_TYPE_CSU
>> 	0x43

> MSMON_CFG_CSU_CTL_TYPE_CSU?

Yup, copy-and-paste error. Thanks!


James

