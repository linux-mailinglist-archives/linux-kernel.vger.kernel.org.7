Return-Path: <linux-kernel+bounces-887833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DEEC39304
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FA544E3B66
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102522D5410;
	Thu,  6 Nov 2025 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eN5Jc3Rw"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963E1AA7BF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408146; cv=none; b=nXH/sCzGsQk7ScwTUL3gjU7B+Y3vNO+rfh09bKReCDx2cIoivyWuKJXtmtLAsSIC7FLCBdv/Ml0hbi9jytM5Hv19dH76DVY59SHr99M0O08aUtvl/YzzPPJgWYdKsW8+z9mvDs7ytp0bnE39BFvk2f01r1VA8EqxhltC+Ck/+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408146; c=relaxed/simple;
	bh=1SWZ5dJMXYAfckU3hzwl8ghlb5SPVLlHYomP60Onpyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aB6kbWLoZS73IHlJ27xHkqOGM3FcBCDi9jH52DDzcWn0VvIjNxGPCq20mwgeV50XMqI8x/T5NcT2zaZoVGPGviOFyhdP21HzqMOirrEnpnDszeSLYXhQSZk8wJO2Dn+dxYbinVLXjwRp5DyuYutib/4cIN/XTEmnE0VzZt351+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eN5Jc3Rw; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 496d0a90bad411f08ac0a938fc7cd336-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HyujfE2bQfleTrEZ9zgDhAaIhD1VJqM2orZjZ6pqvKo=;
	b=eN5Jc3Rw6I5FpVlhrn9req61sYlyJgUqGRzSQUiJHjfasQhxUAwnnzvC2G4Xe50vplTFEcHcHN7pBWOSFkn2oVVMi/zxwILL968XiFbUk93KxCsiBNWTmcFgrMr8PF7byJnIOUq8Vq1MfbLKASwjRA0tYPz9ES10g0WdzI0a9yk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:041bcb7e-23f1-445a-a401-bb76dd6cc1c7,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:d258fa18-3399-4579-97ab-008f994989ea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|83|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 496d0a90bad411f08ac0a938fc7cd336-20251106
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <niklaus.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 441798809; Thu, 06 Nov 2025 13:48:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 13:48:56 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 13:48:55 +0800
From: Niklaus Liu <Niklaus.Liu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <zhigang.qin@mediatek.com>, <sen.chu@mediatek.com>,
	Niklaus Liu <niklaus.liu@mediatek.com>, Niklaus Liu
	<Niklaus.Liu@mediatek.com>
Subject: Re: [PATCH v4 0/1] soc: mediatek: mtk-regulator-coupler: Add support for MT8189
Date: Thu, 6 Nov 2025 13:48:51 +0800
Message-ID: <20251106054854.1395-1-Niklaus.Liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Refer to the discussion in the link:
v3: https://patchwork.kernel.org/project/linux-mediatek/patch/20251104071252.12539-2-Niklaus.Liu@mediatek.com/

- reply comment:
Hi Angelo:
We have already confirmed with the GPU Owner/HW team that for the MT8189 SoC without AOC 2.0, the GPU power sequence requires vgpu to be enabled before vsram. This is also the case for the MT8188. In addition, we have already implemented MFG0/1 for GPU/GPU_VSRAM. Is there anything else that needs clarification from our side?

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

Niklaus Liu (1):
  soc: mediatek: mtk-regulator-coupler: Add support for MT8189

 drivers/soc/mediatek/mtk-regulator-coupler.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.46.0


