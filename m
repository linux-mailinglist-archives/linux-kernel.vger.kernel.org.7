Return-Path: <linux-kernel+bounces-822988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69CB853ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9172716DF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80823128BA;
	Thu, 18 Sep 2025 14:20:03 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB130CDB1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205203; cv=none; b=QXWiDtEVBYEzKv1sYpcE6RDvVAt4/QIeLzxUVI0pzBLqkZifc8fwgII6fAGc1VxYA98goDL9vh695z3OD2NSjwof5PiSAmzImOTmVK5aqrhts66gJ23X4YNOzEexPosGrqAneN1Mq/jigKajPUtWtZ3pNqfjvbo3qtMQ8cjeqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205203; c=relaxed/simple;
	bh=D9Y8Bt/owQ1FynHSVP9fIaoI5MEzStCl0tka+CC3snE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=p1B1UhKfdRMAVWFWfGuHFg1ofBr77mGghYk8HVoihlvG9ZqeAocG0yG9TUgjRaTyIDqHnt9woTo3iJr2G95e7vfZ0QmLRAkXQJmxsv2r/609Yl4bWSOarDgT2s8+fqTFpvNVIvuqksBYXtaWD0ESdj7FpsCfxAYdME1wAW3/OKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cSHjZ34hkz13NNP;
	Thu, 18 Sep 2025 22:15:46 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BBAB1402CC;
	Thu, 18 Sep 2025 22:19:57 +0800 (CST)
Received: from kwepemq500001.china.huawei.com (7.202.195.224) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 22:19:57 +0800
Received: from [10.67.146.137] (10.67.146.137) by
 kwepemq500001.china.huawei.com (7.202.195.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 22:19:56 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1:Check whether indirect table is
 supported in allocate_vpe_l1_table
To: Marc Zyngier <maz@kernel.org>
CC: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <guoyang2@huawei.com>,
	<wangwudi@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>,
	<wangzhou1@hisilicon.com>, <guozicheng3@hisilicon.com>
References: <20240122160607.1078960-1-tangnianyao@huawei.com>
 <86sf2p91zt.wl-maz@kernel.org>
 <5de3da53-9c0d-2a2d-876b-2181e540fa2f@huawei.com>
 <86r0i98o0a.wl-maz@kernel.org>
 <de3c10be-f4d4-75d0-bc70-0791e5217516@huawei.com>
 <86v83fmn9l.wl-maz@kernel.org>
 <cae508d5-c846-5daf-a1b8-4014f14759e5@huawei.com>
 <86ldmc144o.wl-maz@kernel.org>
From: Tangnianyao <tangnianyao@huawei.com>
Message-ID: <4a17190d-3d02-9c8c-699e-62e5aff63f08@huawei.com>
Date: Thu, 18 Sep 2025 22:19:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86ldmc144o.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500001.china.huawei.com (7.202.195.224)



On 9/18/2025 17:50, Marc Zyngier wrote:
> On Thu, 18 Sep 2025 03:56:04 +0100,
> Tangnianyao <tangnianyao@huawei.com> wrote:
>>
>>
>> On 5/15/2024 17:34, Marc Zyngier wrote:
>>> On Wed, 15 May 2024 09:56:10 +0100,
>>> Tangnianyao <tangnianyao@huawei.com> wrote:
>>>>
>>>> On 1/22/2024 22:02, Marc Zyngier wrote:
>>>>> On Mon, 22 Jan 2024 13:13:09 +0000,
>>>>> Tangnianyao <tangnianyao@huawei.com> wrote:
>>>>>> On 1/22/2024 17:00, Marc Zyngier wrote:
>>>>>>> [Fixing the LKML address, which has bits of Stephan's address embedded
>>>>>>> in it...]
>>>>>>>
>>>>>>> On Mon, 22 Jan 2024 16:06:07 +0000,
>>>>>>> Nianyao Tang <tangnianyao@huawei.com> wrote:
>>>>>>>> In allocate_vpe_l1_table, when we fail to inherit VPE table from other
>>>>>>>> redistributors or ITSs, and we allocate a new vpe table for current common 
>>>>>>>> affinity field without checking whether indirect table is supported.
>>>>>>>> Let's fix it.
>>>>>>> Is there an actual implementation that doesn't support the indirect
>>>>>>> property for the VPE table? I know this is allowed for consistency
>>>>>>> with the original revision of the architecture, but I never expected
>>>>>>> an actual GICv4.1 implementation to be *that* bad.
>>>>>>>
>>>>>>> If that's the case, I'm a bit puzzled/worried.
>>>>>> I met this problem in a developing implementation and find it's allowed by GIC spec.
>>>>>> In such environment,  in a common affinity field with only redistributors and without
>>>>>> any ITS in it, forcing its_vpe_id_alloc to allocate a large vpeid(like 65000), and there
>>>>>> comes an error message "VPE IRQ allocation failure". It originally comes from
>>>>>> allocate_vpe_l2_table, reading GICR_VPROPBASER with GICR_VPROPBASER_4_1_SIZE=1
>>>>>> and GICR_VPROPBASER_4_1_INDIRECT=0.
>>>>> Really, you should get your HW engineers to fix their GIC
>>>>> implementation.  I'm OK with working around this issue for
>>>>> completeness, but shipping such an implementation would be a mistake.
>>>>>
>>>>> [...]
>>>>>
>>>>>> I have another question here. The max number of pages  for GITS_BASER
>>>>>> and GICR_VPROPBASER is different here, while GITS_BASER.Size is
>>>>>> bit[7:0] with max 256, and GICR_4_1_VPROPBASER.Size is bit[6:0] with max 128.
>>>>>> Kernel usually probe ITS basers first and then probe GICR_4_1_VPROPBASER in
>>>>>> a common affinity group. Maybe we need to check this in "inherit_vpe_l1_table_from_its" ?
>>>>> This is because GITS_BASER[] is generic (also works for devices and
>>>>> collections), while GICR_VPROPBASER is tailored to the VPE table which
>>>>> is usually smaller.
>>>>>
>>>>> I would expect that GICD_TYPER2.VID reports something that cannot
>>>>> result in something going wrong (in this case, the L1 allocation
>>>>> cannot be more than 128 pages).
>>>>>
>>>>> Overall, the kernel isn't a validation suite for the HW, and we expect
>>>>> it to have some level of sanity. So if none of this is in shipping HW
>>>>> but only in some model with crazy parameters, I don't think we should
>>>>> go out of our way to support it.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> 	M.
>>>>>
>>>> Hi Marc,
>>>> Friendly ping. Do we have plan to fix this problem on kernel, or any other plan ?
>>> Hi Nianyao,
>>>
>>> My earlier question still stand: is this something that affects a
>>> shipping implementation? If not, then I don't think we should support
>>> this upstream, as this doesn't seem like a realistic configuration.
>>>
>>> If your employer has actually built this (which I still consider as a
>>> mistake), then we can add the workaround I suggested.
>>>
>>> Thanks,
>>>
>>> 	M.
>>>
>> Hi Marc,
>>
>> For GIC4.1 of HIP09,HIP10,HIP10C, it only support one-level vcpu table and GITS_BASER<n>.Indirect
>> is RAZ/WI. It implements page size 16KB and entry size 32B,  each page support 512 vpe, and our
>> clients have requirement 1 or 2 pages at most, so it just supports flat page to simplify implementation.
>>
>> Our designer has confirmed with ARM architect that we can waive this rule:
>> Quote from GIC spec 12.19.1 GITS_BASER<n> description, if the maximum width of the scaling factor
>> that is identified by GITS_BASER<n>.Type and the smallest page size that is supported result in a single
>> level table that requires multiple pages, then implementing this bit
>> as RAZ/WI is DEPRECATED.
> I can read the spec just as well. Doesn't make it a good option.
It maybe a good option for clients that do not use many vpe?
So we try to convinced ARM to waive this rule and received a positive response.

>> We have actually built this in HIP09,HIP10,HIP10C and would like to
>> fix this in kernel.
> Isn't that the broken systems that can't even do vSGIs properly?
>
>> Can we merge the above bug-fix patch to kernel?  Or we need to fix with errata for HIP09,HIP10,HIP10C?
> Frankly, I've completely lost track of what this patch is doing. This
> has been going on for over 18 months, and you have been silent on the
> subject for over a year. What do you expect?
>
> If you want anything to be done on this front, please repost a patch,
> and we'll review it again.
>
> 	M.
>
We have tested the last patch in our internal build and now aim to fix the open-source
kernel to support our SoC. We hope to address this either through a community patch or an errata fix.

I will repost the patch shortly. Thanks for your review.

Nianyao Tang

