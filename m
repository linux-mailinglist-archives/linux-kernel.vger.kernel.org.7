Return-Path: <linux-kernel+bounces-816935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEE8B57AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA27161429
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403D309DC0;
	Mon, 15 Sep 2025 12:25:39 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E52494F0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939138; cv=none; b=M8rKUAjvxVl/CpXuYqHAQVOdO5bUG+ytKsods4SCoKwgnfOkdQVxUFvYXqwcUKPNDDsurbo2eZ5rh1tRmzQUNx9zStAwIUE1za2Vf0GKnVcd0bpj2j5doBINmTE8tzxOaxVvMdMZ+swaXK+gWb0V+9JPFle+pa//olkoJUhIUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939138; c=relaxed/simple;
	bh=iaeHhIs+S9LdDKIPe/R2E2u8boYaPaEgi3VXNXT0I+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ltewQ3paTUXEjBaXTFNxhMLlZxqMZDJfU95VEM9UqQ0q6mqDXd6jwyvsbOse5sw9MPy9wZnoD8K5gXTFdq5F14zqaglgiFMlvZVJ3pj8cO8VCvNosPF5ZjaFPX6x9O8GY7IJgtvvWUM6Lb4sCCDvrpDufyWu4PoNFbw8SdHFbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cQPKm6pHrz2VRjg;
	Mon, 15 Sep 2025 20:22:04 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 665F9140230;
	Mon, 15 Sep 2025 20:25:27 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Sep 2025 20:25:27 +0800
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Sep 2025 20:25:26 +0800
Message-ID: <6c7cd1c2-0109-467f-aea2-099f3425274f@huawei.com>
Date: Mon, 15 Sep 2025 20:25:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 drm-dp 02/11] drm/hisilicon/hibmc: fix dp
 probabilistical detect errors after HPD irq
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <fengsheng5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<shiyongbang@huawei.com>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-3-shiyongbang@huawei.com>
 <aayi7zjrmru2ancexrqmcutams6ohde3nrkhqacixwp45dsk4v@7ig6hqzahdxf>
 <1dd93bb7-4f67-4b9b-8b6a-d7c5c77cf807@huawei.com>
 <ce47v3y77uc4dunlwyvmfe6j7d7mza4zfrbvu5dz67t66jdlop@vqgv47saj37i>
 <8bbfd02f-138d-420c-b456-10d0c913f46e@huawei.com>
 <cdmtfluxqes3bv3t7suctbajp4jmpih6fhegkbf7mxvy4umzrd@rtpupear4el2>
 <13b3f4d9-c8b4-445f-8f9e-a57a1fa2bbb5@huawei.com>
 <3sywcmtd4uksow6exaav6smx4wwrlp7mur6mcrpw3qklvbr3kn@dqypx4fmnhrw>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <3sywcmtd4uksow6exaav6smx4wwrlp7mur6mcrpw3qklvbr3kn@dqypx4fmnhrw>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100007.china.huawei.com (7.202.195.175)


> On Fri, Sep 12, 2025 at 09:23:05AM +0800, Yongbang Shi wrote:
>>> On Thu, Sep 11, 2025 at 05:32:40PM +0800, Yongbang Shi wrote:
>>>>> On Thu, Aug 14, 2025 at 08:19:41PM +0800, Yongbang Shi wrote:
>>>>>>> On Wed, Aug 13, 2025 at 05:42:29PM +0800, Yongbang Shi wrote:
>>>>>>>> From: Baihan Li <libaihan@huawei.com>
>>>>>>>>
>>>>>>>> The debouncing when HPD pulled out still remains sometimes, 200ms still can
>>>>>>>> not ensure helper_detect() is correct. So add a flag to hold the sink
>>>>>>>> status, and changed detect_ctx() functions by using flag to check status.
>>>>>>> THis doesn't explain what is wrong with
>>>>>>> drm_connector_helper_detect_from_ddc(). In the end, this function
>>>>>>> doesn't use the HPD pin.
>>>>>> I'm sorry about the misunderstanding.
>>>>>> The issue is that after plugging or unplugging the monitor, the driver takes no action sometimes
>>>>>> even though an interrupt is triggered. The root cause is that drm_connector_helper_detect_from_ddc()
>>>>>> still returns connected status when the monitor is unplugged.
>>>>>> And I will fix the way in the end.
>>>>> Can you perform a normal DP detection: read DPCD and check that there is
>>>>> a DPRX attached and that it's either non-branch device or it has one or
>>>>> more sinks?
>>>> I'm very sorry that I didn't get the last sentence's asking before.
>>>> It's a non-branch device. We just connect a DP monitor.
>>> Somebody might connect a different configuration than the one that you
>>> are using.
>> Okay, I can add the check drm_dp_is_branch() in the DP's detect_ctx() to
>> intercept branch devices, is that good?
> My suggestion is to implement DP detection in the way it's done by other
> DP drivers.

Okay, I will reference the code from other manufacturer ways.

Thanks,
Baihan.



