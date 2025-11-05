Return-Path: <linux-kernel+bounces-886069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41918C34A76
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 259FC4FD791
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157FF2ED848;
	Wed,  5 Nov 2025 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ip5xis/3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C82EBDE5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333003; cv=none; b=EzImGU6HkOcRiMdSK7Qn1xdybkeRODz4gNZnF394ZH8ATyten1URqBsXF1QzUPpElXpikgpKugBpVyogoVR5iAer3aD0otY6yt9aS5c868Z1gCj2+TNJJoNsX33kFdtl8QeYgNYK1lt2/zkd2xmcQrILEZjUHq1pgAuqMvd7QUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333003; c=relaxed/simple;
	bh=kBp4Td7c7VXvdJdflYb0aWyuRBLxQrptcQOf2UCMU7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4rC5dTjwE6mFOjmX6XDX/jznaJyf7T9/4txQK5pIMyrqlLSJcqg98aqLenLJPsT22s0x4WznwtzctzsJ5OyO+dx0m1c7+oddmpEe/kO4+hRjfutO5CX6H0cbEy/ToRlXc7wfaFx2H4RAmaVnAu7ECSW93q8GahC+rQGRGuPu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ip5xis/3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762332999;
	bh=kBp4Td7c7VXvdJdflYb0aWyuRBLxQrptcQOf2UCMU7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ip5xis/3G2I0Atgv3TPwLeesXyCBzCZNyX+tpF7mDwEnOSEI7RG+vQw6lE0wIsUds
	 6nxpdrDz7CnDqSmUkkqb2m9Ib6xPz2+QIbC4xVPRQLPM+kUHNmx0jqZspwjornd4sY
	 xmY9Jwl6MATfCL+9bVf1V3YNiNiNccGUeD71BH09hM1SOFT5oYwiVTDLc6gLjQnvfC
	 cyIIbsTGTavWkn0c449imX25A/VBZurd9QnrdHLfhfEtJJs32R7eCK4Wehz3K0eYRL
	 f3kuDzDiSuQ3RmSsg75OqlGnh7fi3r8Y7VH5zaW+H1/fXPoL63bCUS/eqy/RzfPOkI
	 fiRJtfvCT3feg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EBD3B17E12AA;
	Wed,  5 Nov 2025 09:56:38 +0100 (CET)
Message-ID: <7d67d78e-3d97-4551-8fde-01667f2ca260@collabora.com>
Date: Wed, 5 Nov 2025 09:56:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: "niklaus.liu" <Niklaus.Liu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com, zhigang.qin@mediatek.com,
 sen.chu@mediatek.com
References: <20251105033817.20427-1-Niklaus.Liu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251105033817.20427-1-Niklaus.Liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/11/25 04:38, niklaus.liu ha scritto:
> Refer to the discussion in the link:
> v3: https://patchwork.kernel.org/project/linux-mediatek/patch/20251104071252.12539-2-Niklaus.Liu@mediatek.com/
> 
> Subject: [PATCH v4 0/1] soc: mediatek: mtk-regulator-coupler: Add support for MT8189

The subject of this email is .. empty. That's really bad, and it's the second time
that it happens. Please make sure that you're sending emails the right way, and/or
fix your client.

While at it, please also fix your name, as it should appear as "Niklaus Liu" and
not as "niklaus.liu".

> 
> changes in v4:
>   - reply comment:

Niklaus, please just reply inline to the emails instead of sending an entirely new
version just for a reply: it's easier for everyone to follow, and it's also easier
for me to read, and for you to send a reply by clicking one button :-)

> 1. MTK hardware requires that vsram_gpu must be higher than vgpu; this rule must be satisfied.
> 
> 2. When the GPU powers on, the mtcmos driver first calls regulator_enable to turn on vgpu, then calls regulator_enable to
> turn on vsram_gpu. When enabling vgpu, mediatek_regulator_balance_voltage sets the voltages for both vgpu and vsram_gpu.
> However, when enabling vsram_gpu, mediatek_regulator_balance_voltage is also executed, and at this time, the vsram_gpu voltage
> is set to the minimum voltage specified in the DTS, which does not comply with the requirement that vsram_gpu must be higher than vgpu.
> 

2. -> There's your problem! VSRAM_GPU has to be turned on *first*, VGPU has to be
turned on *last* instead.

Logically, you need SRAM up before the GPU is up as if the GPU tries to use SRAM
it'll produce unpowered access issues: even though it's *very* unlikely for that
to happen on older Mali, it's still a logical mistake that might, one day, come
back at us and create instabilities.

Now, the easy fix is to just invert the regulators in MFG nodes. As I explained
*multiple* times, you have a misconfiguration in your DT.

GPU subsystem main MFG -> VSRAM
GPU core complex MFG -> VGPU
GPU per-core MFG -> nothing

> 3.During suspend, the voltages of vgpu and vsram_gpu should remain unchanged, and when resuming, vgpu and vsram_gpu should be
> restored to their previous voltages. When the vgpu voltage is adjusted, mediatek_regulator_balance_voltage already synchronizes the
> adjustment of vsram_gpu voltage. Therefore, adjusting the vsram_gpu voltage again in mediatek_regulator_balance_voltage is redundant.

If you fix your DT, N.3 won't happen.

Regards,
Angelo

> 
> 
> changes in v3:
>   - modify for comment[add the new entry by alphabetical order]
> 
> changes in v2:
>   - change title for patch
>   - reply comment: This is a software regulator coupler mechanism, and the regulator-coupled-with
> configuration has been added in the MT8189 device tree. This patchaddresses an issue reported by a
> Chromebook customer. When the GPU regulator is turned on, mediatek_regulator_balance_voltage already
> sets both the GPU and GPU_SRAM voltages at the same time, so there is no need to adjust the GPU_SRAM
> voltage again in a second round. Therefore, a return is set for MT8189.
> If the user calls mediatek_regulator_balance_voltage again for GPU_SRAM, it may cause abnormal behavior of GPU_SRAM.
> 
> 
> changes in v1:
>   - mediatek-regulator-coupler mechanism for platform MT8189
> 
> *** BLURB HERE ***
> 
> Niklaus Liu (1):
>    soc: mediatek: mtk-regulator-coupler: Add support for MT8189
> 
>   drivers/soc/mediatek/mtk-regulator-coupler.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 

