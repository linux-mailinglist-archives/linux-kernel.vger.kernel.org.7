Return-Path: <linux-kernel+bounces-759818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9CAB1E334
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A89D583364
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F9722B8D0;
	Fri,  8 Aug 2025 07:17:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0488121B9E7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637469; cv=none; b=d4pFXgAIDFrzBYVUxSy+R+WOBIjUmKzYmCbsjmB4pKSaQ2xUr1Nd1nfWmtSprE8d7FIOf8f1wIKLt9RrNnxlQE3vbYj16RCeyG8Z6RLzwEVFO70R/rWdrGWGoWL7UbmDEcA5Ec9mi4pxtstjxrZZk9YTn2bHvuuwvf2K02wldFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637469; c=relaxed/simple;
	bh=CoiS717ISQqTCH2BWVuR7s+G92cZynahbRrK0Kl+bYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtMS/yt8xaXlY5YJbPpKUOqZNhNE6w7bwocC+F2vTdhZQJpissmbd4QYTeMIYsmD2sZ+d79JNr8ZPp+WTCZEYSydbZ+8iWEyxKoL/gFEy6poJZa4WZDbK0qWy7+9drZe20Ly4CC+QbVNlZEjrTe3XGVHSaRKJu5toVIuV1J65nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77C2E16F8;
	Fri,  8 Aug 2025 00:17:39 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38D8F3F673;
	Fri,  8 Aug 2025 00:17:42 -0700 (PDT)
Message-ID: <b7318d03-7138-4fbb-8c83-6368928d465d@arm.com>
Date: Fri, 8 Aug 2025 08:17:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/36] arm_mpam: Allow configuration to be applied and
 restored during cpu online
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
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
 <20250711183648.30766-28-james.morse@arm.com>
 <4778e89f-0b94-441e-947a-dfc9839b250b@nvidia.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <4778e89f-0b94-441e-947a-dfc9839b250b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fenghua,

On 04/08/2025 17:39, Fenghua Yu wrote:
> On 7/11/25 11:36, James Morse wrote:
>> When CPUs come online the original configuration should be restored.
>> Once the maximum partid is known, allocate an configuration array for
>> each component, and reprogram each RIS configuration from this.
>>
>> The MPAM spec describes how multiple controls can interact. To prevent
>> this happening by accident, always reset controls that don't have a
>> valid configuration. This allows the same helper to be used for
>> configuration and reset.

>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/
>> mpam_devices.c
>> index bb3695eb84e9..f3ecfda265d2 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c>>   @@ -909,51 +913,90 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg,
>> +/* Call with MSC lock held */
>> +static int mpam_reprogram_ris(void *_arg)
>> +{
>> +    u16 partid, partid_max;
>> +    struct reprogram_ris *arg = _arg;
>> +    struct mpam_msc_ris *ris = arg->ris;
>> +    struct mpam_config *cfg = arg->cfg;
>> +
>> +    if (ris->in_reset_state)
>> +        return 0;
>> +
>> +    spin_lock(&partid_max_lock);
>> +    partid_max = mpam_partid_max;
> partid_max is not used after the assignment.
>> +    spin_unlock(&partid_max_lock);
> 
> Doesn't make sense to lock protect a local variable partid_max which is not used any way.
> 
> [SNIP]

Because you cut the user out:
| 	for (partid = 0; partid <= partid_max; partid++)
|		mpam_reprogram_ris_partid(ris, partid, cfg);
|
|	return 0;
| }

mpam_reprogram_ris() needs to snapshot the value because it can be called via mpam_reset_msc() -
which does run before mpam_enable_once(). This can race with mpam_register_requestor(), but the
race can only reduce partid_max, all the MSC are guaranteed to support at least the original value.

Taking the lock is so you don't get a torn value which is larger than the original value.


Thanks,

James

