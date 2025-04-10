Return-Path: <linux-kernel+bounces-598041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 107E4A8418D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 13:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBD64A3DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5887F281520;
	Thu, 10 Apr 2025 11:14:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9071E25E3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283695; cv=none; b=ZGJrhh6tkQj95Lkt0KLrS8ZOoKb4raZk9TOqOQjkFkHHYM6/YemPuQFdC4Dtoi1avdFCs765z2MqKdLev9cEtg0eCO/SPmyy6BV2n0PabkH6R8H+Zvhn3vRG3PHA/U0G1iK3eYmxmHMtM2fmf6Ae1ef/ZG8jQr1be3GNl/RTP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283695; c=relaxed/simple;
	bh=cy0vXy2j7xjX68N0rV2QUNjvYZIznsKsgNK//n1r64o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahLAOvYJUpsfYa1x8+LTwv6+Wlq1honegWrfAVHznjTgl3N24zIiazBNOl2g6Iy62cr2L0OILN5UKDv2IN5SdP4yXPikCv9U0madDrv/jVecG0kP+D1vFNX6xxQsaSOk7POboAjkpm6Ou4lCQX2V/ND9opjOufvfn+l+7naxOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E943E106F;
	Thu, 10 Apr 2025 04:14:52 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE7B73F6A8;
	Thu, 10 Apr 2025 04:14:50 -0700 (PDT)
Message-ID: <2e2ad90b-9e48-4711-a8da-85668493259b@arm.com>
Date: Thu, 10 Apr 2025 12:14:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/mediatek: Fix NULL pointer deference in
 mtk_iommu_device_group
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, kernel@collabora.com,
 Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250403-fix-mtk-iommu-error-v2-1-fe8b18f8b0a8@collabora.com>
 <CAGXv+5HJpTYmQ2h-GD7GjyeYT7bL9EBCvu0mz5LgpzJZtzfW0w@mail.gmail.com>
 <2792b9df-fc82-4252-af64-cf888a36f561@arm.com>
 <CAGXv+5E=NhFcS0fG_kbLTnF6xfTkBOHQwsNxszHDcgWfn3zFiA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAGXv+5E=NhFcS0fG_kbLTnF6xfTkBOHQwsNxszHDcgWfn3zFiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/04/2025 5:46 am, Chen-Yu Tsai wrote:
> On Mon, Apr 7, 2025 at 8:38 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2025-04-07 6:17 am, Chen-Yu Tsai wrote:
>>> Hi,
>>>
>>> On Thu, Apr 3, 2025 at 6:24 PM Louis-Alexis Eyraud
>>> <louisalexis.eyraud@collabora.com> wrote:
>>>>
>>>> Currently, mtk_iommu calls during probe iommu_device_register before
>>>> the hw_list from driver data is initialized. Since iommu probing issue
>>>> fix, it leads to NULL pointer dereference in mtk_iommu_device_group when
>>>> hw_list is accessed with list_first_entry (not null safe).
>>>>
>>>> So, change the call order to ensure iommu_device_register is called
>>>> after the driver data are initialized.
>>>>
>>>> Fixes: 9e3a2a643653 ("iommu/mediatek: Adapt sharing and non-sharing pgtable case")
>>>> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
>>>> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
>>>> Tested-by: Chen-Yu Tsai <wenst@chromium.org> # MT8183 Juniper, MT8186 Tentacruel
>>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
>>>> ---
>>>> This patch fixes a NULL pointer dereference that occurs during the
>>>> mtk_iommu driver probe and observed at least on several Mediatek Genio boards:
>>>> ```
>>>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>>>
>>> This is a reminder to please land this and send to Linus ASAP.
>>>
>>> This fixes the v6.15-rc1 kernel on all the MediaTek Chromebook platforms,
>>> except for MT8188, which seems to have another issue in iommu_get_dma_domain()
>>> used from the DRM driver:
>>>
>>>       Disabling lock debugging due to kernel taint
>>>       Unable to handle kernel NULL pointer dereference at virtual
>>> address 0000000000000158
>>
>>   From the offset and the stacktrace code dump, this would appear to be
>> the dereference of dev->iommu_group->default_domain, when
>> dev->iommu_group is NULL (and CONFIG_DEBUG_LOCK_ALLOC makes the mutex
>> really big). Which is a bit weird, as to get into iommu-dma at all in
>> that state would suggest that whatever device this is has been removed
>> and had its group torn down again after iommu_setup_dma_ops() has run...
>> but either way that implies the DRM driver is passing an arbitrary
>> device to the DMA API without making sure it's actualy valid.
>>
>> Trying to trace the provenance of dma_dev from mtk_gem_create() back
>> through the rest of the driver is quite the rabbit-hole, but it seems
>> like in at least one case it can lead back to an
>> of_find_device_by_node() in ovl_adaptor_comp_init(), which definitely
>> looks sufficiently sketchy.
> 
> It kind of makes sense since the "display controller" is composed of
> many individual hardware blocks. The struct device tied to the DRM
> driver is more or less just a place holder. Only the first block,
> either the OVL (overlay compositing engine) or RDMA (scanout engine)
> accesses memory, so I think it makes sense to use that as the dma_dev.

I'm not disputing whether the choice of dma_dev is semantically 
appropriate, I'm just saying that the method of pulling a struct device 
reference out of the DT topology shows no *obvious* guarantee that that 
specific device will have a driver bound and be validly configured 
before that dma_dev can be used via any other path. Especially when it's 
all happening off the back of another fake device created by the fake 
DRM device itself.

Maybe there's some hidden magic in all the component stuff which makes 
it work out fine, I don't know. This was just an observation since I 
went looking for potential bugs and found something which at first 
glance *looks* rather fragile, compared to, say, if mtk_mdp_rdma's own 
probe() or bind() were to directly set itself as the DMA device.

> With some more logs, I did find something else fishy. Here the IOMMU
> for the second display pipeline fails to probe:
> 
>      mtk-iommu 1c028000.iommu: error -EINVAL: Failed to register IOMMU
>      mtk-iommu 1c028000.iommu: probe with driver mtk-iommu failed with error -22
> 
> Then later on, deferred probe times out, and the display pipeline is
> brought up regardless:
> 
>      mediatek-disp-ovl 1c000000.ovl: deferred probe timeout, ignoring dependency
>      mediatek-disp-ovl 1c000000.ovl: Adding to IOMMU failed: -110
>      mediatek-disp-rdma 1c002000.rdma: deferred probe timeout, ignoring
> dependency
>      mediatek-disp-rdma 1c002000.rdma: Adding to IOMMU failed: -110
>      (repeats for all the individual components of the display pipeline)
>      mediatek-drm mediatek-drm.16.auto: bound 1c000000.ovl (ops
> mtk_disp_ovl_component_ops)
>      mediatek-drm mediatek-drm.16.auto: bound 1c002000.rdma (ops
> mtk_disp_rdma_component_ops)
>      (repeats for all the individual components of the display pipeline)
>      mediatek-drm mediatek-drm.16.auto: DMA device is 1c000000.ovl
>      [drm] Initialized mediatek 1.0.0 for mediatek-drm.16.auto on minor 1
> 
> And all without a functional IOMMU.

Ah, that I was not expecting, and it does indeed explain how things get 
into that state.

> So I think this brings up two more questions:
> 
> 1. Why is the IOMMU failing to probe?
> 2. Why is the core code still going the IOMMU DMA alloc path if there
>     is no usable IOMMU?
> 
> I'll look into the first question first. Insights welcome for the second
> one.

I had a think about it, and although there's very much a historical mess 
in this area, I'm inclined to agree that we could do better. Patch sent.

Cheers,
Robin.

