Return-Path: <linux-kernel+bounces-758151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24EB1CBAC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4467222CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F19E202996;
	Wed,  6 Aug 2025 18:07:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D361EA7CF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503644; cv=none; b=G8KNrbtth8O5zSdwWe/O74giwmnD53jOP6qiyktTH2IJnkiB+MwI7pnFK4dXwW4MN2INl8HxMwrEpgaM6vupp81rdhMPVwBX1jguRSj//EIQFFlaYt34S8tagz03R3ZzkVXtCOd5Sv5kpl/TSZuGyoUGBhxSId1X5qw36A0mLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503644; c=relaxed/simple;
	bh=Om4ps8LWfWrE7iytBcnEp0gl/lf6uH6lcmL7E5D5m/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Spp1QhhdmrA1HmoccziAu7CVW2yRTOn1Z58rr/EZ3CSe+aqOhI7MOAHa0IIL1ao24FyYiOZ/Mh7pKk0ze9cqBnSp6iPqV730HnmBkZ7IWC2zjd7T/T2QsZjhqjzPur8u6cjU6q0HX8ma6pL/SYj50kL3kFB0OgTG4kn+F4bupvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05FBB176C;
	Wed,  6 Aug 2025 11:07:12 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81FBC3F738;
	Wed,  6 Aug 2025 11:07:16 -0700 (PDT)
Message-ID: <4da6ec99-0de5-46f1-859e-8246bc3025ff@arm.com>
Date: Wed, 6 Aug 2025 19:07:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/36] arm_mpam: Add cpuhp callbacks to probe MSC
 hardware
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
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-18-james.morse@arm.com>
 <48e482f2-e7a8-4d6a-bf16-ad29f9331e3b@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <48e482f2-e7a8-4d6a-bf16-ad29f9331e3b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ben,

On 24/07/2025 15:13, Ben Horgan wrote:
> On 11/07/2025 19:36, James Morse wrote:
>> Because an MSC can only by accessed from the CPUs in its cpu-affinity
>> set we need to be running on one of those CPUs to probe the MSC
>> hardware.
>>
>> Do this work in the cpuhp callback. Probing the hardware will only
>> happen before MPAM is enabled, walk all the MSCs and probe those we can
>> reach that haven't already been probed.
>>
>> Later once MPAM is enabled, this cpuhp callback will be replaced by
>> one that avoids the global list.
>>
>> Enabling a static key will also take the cpuhp lock, so can't be done
>> from the cpuhp callback. Whenever a new MSC has been probed schedule
>> work to test if all the MSCs have now been probed.

>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/
>> mpam_devices.c
>> index 0d6d5180903b..89434ae3efa6 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
>> @@ -513,9 +541,84 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>>       return err;
>>   }
>>   -static void mpam_discovery_complete(void)
>> +static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>   {
>> -    pr_err("Discovered all MSC\n");
>> +    u64 idr;
>> +    int err;
>> +
>> +    lockdep_assert_held(&msc->probe_lock);
>> +
>> +    mutex_lock(&msc->part_sel_lock);
>> +    idr = mpam_read_partsel_reg(msc, AIDR);
>> +    if ((idr & MPAMF_AIDR_ARCH_MAJOR_REV) != MPAM_ARCHITECTURE_V1) {
>> +        pr_err_once("%s does not match MPAM architecture v1.0\n",
>> +                dev_name(&msc->pdev->dev));

> The error message need only mention the major revision. You've added support for v1.1 and
> v1.0.

Makes sense,


Thanks,

James

