Return-Path: <linux-kernel+bounces-888274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61289C3A58D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1862350AC0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781E2D9EEF;
	Thu,  6 Nov 2025 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PS/F2yIG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C5BF9EC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426078; cv=none; b=KjknPcoGmkbvsBnEelsgXKHchH4wdObLUnGc59WJbRTaIgr39JOt2jR1yULyumTirDitW2clgSwFdshKPEnUm4OJaMkaKjIXOg0xsyMIqWQTwgCbeo8kS3Sbsk8BqlzfvLlBObusDAdj2Bhk+hnUvVNvt5DLkbfNJ5q4LWyksz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426078; c=relaxed/simple;
	bh=/FpkFrA9fQ5Co4sREpsA53fBqhFYLaucWXHBlukwxrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5jBD7KK5XyW6yvcUAKSiRRO5hSpsLxz2q+dMF1sF3z6uehGYGaYXbZ3hGwrPqem0XteE6q5ZDLWNEk9mG5sNYPuJUbO7mGT1eVh++Tn/oIeT5fw9YxoRYBMsHvb/16D8HVnfm3LntFuSzII9xYmxYhX1eCEr3WDDJmDkeREciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PS/F2yIG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762426074;
	bh=/FpkFrA9fQ5Co4sREpsA53fBqhFYLaucWXHBlukwxrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PS/F2yIGQqUteSZPniP+/AcA3JxHORBfZlp7/wWr4PslcwvWy3d87CJnFybaVtj69
	 C54JaMteMB2zvTCxErNddQzi72YiQliOGyKYgTzdkb6AT9GUxS5KYxn3uAE4ALC7X7
	 tsiG7J5Vh+WBgYvgebE/NdDMb+Fa2IfLzXtBWCCCmc1i7udkBx6GpvxDd2At6Z+Xa7
	 CiysOPyJhiQrSrpkPT9YgfwZLpxrFvSynAaWFN87xFQqLVaS2Ax/c0tZIbUGI98bNZ
	 SfT39phzjtzC8ERNiM8NPJkWa9nbLLRtTjIYkX1tn2gWwBdgEXOgJZNEw/ET0ocUGm
	 +lXoinHKTHFfQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2802317E128C;
	Thu,  6 Nov 2025 11:47:54 +0100 (CET)
Message-ID: <145da72b-b209-4e8d-9dcd-b82a412b800a@collabora.com>
Date: Thu, 6 Nov 2025 11:47:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] soc: mediatek: mtk-regulator-coupler: Add support
 for MT8189
To: Niklaus Liu <Niklaus.Liu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com, zhigang.qin@mediatek.com,
 sen.chu@mediatek.com, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
References: <20251106054854.1395-1-Niklaus.Liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251106054854.1395-1-Niklaus.Liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/11/25 06:48, Niklaus Liu ha scritto:
> Refer to the discussion in the link:
> v3: https://patchwork.kernel.org/project/linux-mediatek/patch/20251104071252.12539-2-Niklaus.Liu@mediatek.com/
> 
> - reply comment:
> Hi Angelo:
> We have already confirmed with the GPU Owner/HW team that for the MT8189 SoC without AOC 2.0, the GPU power sequence requires vgpu to be enabled before vsram. This is also the case for the MT8188. In addition, we have already implemented MFG0/1 for GPU/GPU_VSRAM. Is there anything else that needs clarification from our side?
> 

I have just rechecked MT8188. You're right, there, the sequence is inverted - but
on that SoC the coupler works just fine, and the first setting of power rail
PP0850_DVDD_SRAM_GPU (mt6359_vsram_others) doesn't produce the side effect that
you are describing in this commit.

I'm still not convinced about that, and if this commit is *really* required, it
logically has to be required for at least MT8188 as well as MT8189, but then I
don't understand why MT8188 works.

This needs some more research efforts because, if there's anything wrong, it's
more than what you're fixing here. Let me check a bit.

As Collabora is also bringing up MT8189 (Genio variant, same SoC anyway), I'll wait
until GPU is up on our Evaluation Kit and then I will check this regulator coupler
situation more carefully, directly on the hardware - because what is happening is
a bit too fishy to just accept a fast patch and let it go.

If I simply accept this patch and let go, some other SoC (newer than, or older than
8189) which is currently not upstream will probably fail as much as this one and
that is not acceptable, because this driver has to work with them all without any
quirk that is strictly SoC-specific (unless one of those has broken HW, which is
not the case here).

Hope you understand.

Regards,
Angelo

>>
>> changes in v4:
>>    - reply comment:
> 
> Niklaus, please just reply inline to the emails instead of sending an entirely new
> version just for a reply: it's easier for everyone to follow, and it's also easier
> for me to read, and for you to send a reply by clicking one button :-)
> 
>> 1. MTK hardware requires that vsram_gpu must be higher than vgpu; this rule must be satisfied.
>>
>> 2. When the GPU powers on, the mtcmos driver first calls regulator_enable to turn on vgpu, then calls regulator_enable to
>> turn on vsram_gpu. When enabling vgpu, mediatek_regulator_balance_voltage sets the voltages for both vgpu and vsram_gpu.
>> However, when enabling vsram_gpu, mediatek_regulator_balance_voltage is also executed, and at this time, the vsram_gpu voltage
>> is set to the minimum voltage specified in the DTS, which does not comply with the requirement that vsram_gpu must be higher than vgpu.
>>
> 
> 2. -> There's your problem! VSRAM_GPU has to be turned on *first*, VGPU has to be
> turned on *last* instead.
> 
> Logically, you need SRAM up before the GPU is up as if the GPU tries to use SRAM
> it'll produce unpowered access issues: even though it's *very* unlikely for that
> to happen on older Mali, it's still a logical mistake that might, one day, come
> back at us and create instabilities.
> 
> Now, the easy fix is to just invert the regulators in MFG nodes. As I explained
> *multiple* times, you have a misconfiguration in your DT.
> 
> GPU subsystem main MFG -> VSRAM
> GPU core complex MFG -> VGPU
> GPU per-core MFG -> nothing
> 
>> 3.During suspend, the voltages of vgpu and vsram_gpu should remain unchanged, and when resuming, vgpu and vsram_gpu should be
>> restored to their previous voltages. When the vgpu voltage is adjusted, mediatek_regulator_balance_voltage already synchronizes the
>> adjustment of vsram_gpu voltage. Therefore, adjusting the vsram_gpu voltage again in mediatek_regulator_balance_voltage is redundant.
> 
> If you fix your DT, N.3 won't happen.
> 
> Regards,
> Angelo
> 
>>
>>
>> changes in v3:
>>    - modify for comment[add the new entry by alphabetical order]
>>
>> changes in v2:
>>    - change title for patch
>>    - reply comment: This is a software regulator coupler mechanism, and the regulator-coupled-with
>> configuration has been added in the MT8189 device tree. This patchaddresses an issue reported by a
>> Chromebook customer. When the GPU regulator is turned on, mediatek_regulator_balance_voltage already
>> sets both the GPU and GPU_SRAM voltages at the same time, so there is no need to adjust the GPU_SRAM
>> voltage again in a second round. Therefore, a return is set for MT8189.
>> If the user calls mediatek_regulator_balance_voltage again for GPU_SRAM, it may cause abnormal behavior of GPU_SRAM.
>>
>>
>> changes in v1:
>>    - mediatek-regulator-coupler mechanism for platform MT8189
>>
>> *** BLURB HERE ***
>>
>> Niklaus Liu (1):
>>     soc: mediatek: mtk-regulator-coupler: Add support for MT8189
>>
>>    drivers/soc/mediatek/mtk-regulator-coupler.c | 13 +++++++++++++
>>    1 file changed, 13 insertions(+)
>>
> 
> Niklaus Liu (1):
>    soc: mediatek: mtk-regulator-coupler: Add support for MT8189
> 
>   drivers/soc/mediatek/mtk-regulator-coupler.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 



