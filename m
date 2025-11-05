Return-Path: <linux-kernel+bounces-885768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E2C33DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBAD42907E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F124262FD7;
	Wed,  5 Nov 2025 03:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OVG9PyAO"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9B424469E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762313911; cv=none; b=oS25Oc4SjxKnIuHANt8EdNT/qEuFEdZbidkReDi8kKOcbJcXwy/XIFBS97u39fBU0f3I7/LOdje3sJtxW09xeWboQTFckbg6EEjbV7lcNAI5Zee0ea5iQ8lS/GqAjhOJorRBojkJEsVBSsida41SX4Lg+Kvq6QQiuaI7fAmlgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762313911; c=relaxed/simple;
	bh=bKT861QrBOrRNykMHnn0OzMFIvHNKmpOr3UJq0gzY/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i13ihUQqCBatW+1bSqn4oLSbX1R/YWqVSc8+mSgeQBWQRIn5r6EOao1DmY39zemf2CSW2gg89k/NGatqkWLdF3zyN7EV/N+wNmjHguKEbPZRKHy3FKZZD1QxST+4BZ7pDeG5SkDkZYtATOL4xfTbAWPlutfmR7HWNvqSCIkZ1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OVG9PyAO; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e0b80102b9f811f08ac0a938fc7cd336-20251105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tnfcvaksRPKklhkGVZFWEH1eyMy2i0IOXmhjqtvAMyo=;
	b=OVG9PyAOLiQi9F19TyjkOk+H+CTWe0cxl88RyEexot0Evf9ecwDJ2M7weAxz5znzPCZZvpUU4pJTOzpbLsjBaHxJfPGyh5e68dwUnLNuffBFYnF/CAYfbx/kW/5xWK62vTdEU23HDrsQV1NzYAkrupu+PB/nYxiJK/uhn02ULPw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:4ce7a5aa-25cb-4cfb-907c-b96deb50039e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:76fe0c6b-d4bd-4ab9-8221-0049857cc502,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:-7|-6|
	0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e0b80102b9f811f08ac0a938fc7cd336-20251105
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <niklaus.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 946494365; Wed, 05 Nov 2025 11:38:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 5 Nov 2025 11:38:20 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 5 Nov 2025 11:38:20 +0800
From: niklaus.liu <Niklaus.Liu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <zhigang.qin@mediatek.com>, <sen.chu@mediatek.com>,
	Niklaus Liu <niklaus.liu@mediatek.com>, niklaus.liu
	<Niklaus.Liu@mediatek.com>
Subject:
Date: Wed, 5 Nov 2025 11:38:02 +0800
Message-ID: <20251105033817.20427-1-Niklaus.Liu@mediatek.com>
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

Subject: [PATCH v4 0/1] soc: mediatek: mtk-regulator-coupler: Add support for MT8189

changes in v4:
 - reply comment:
1. MTK hardware requires that vsram_gpu must be higher than vgpu; this rule must be satisfied.

2. When the GPU powers on, the mtcmos driver first calls regulator_enable to turn on vgpu, then calls regulator_enable to 
turn on vsram_gpu. When enabling vgpu, mediatek_regulator_balance_voltage sets the voltages for both vgpu and vsram_gpu. 
However, when enabling vsram_gpu, mediatek_regulator_balance_voltage is also executed, and at this time, the vsram_gpu voltage 
is set to the minimum voltage specified in the DTS, which does not comply with the requirement that vsram_gpu must be higher than vgpu.

3.During suspend, the voltages of vgpu and vsram_gpu should remain unchanged, and when resuming, vgpu and vsram_gpu should be 
restored to their previous voltages. When the vgpu voltage is adjusted, mediatek_regulator_balance_voltage already synchronizes the 
adjustment of vsram_gpu voltage. Therefore, adjusting the vsram_gpu voltage again in mediatek_regulator_balance_voltage is redundant. 


changes in v3:
 - modify for comment[add the new entry by alphabetical order]

changes in v2:
 - change title for patch
 - reply comment: This is a software regulator coupler mechanism, and the regulator-coupled-with
configuration has been added in the MT8189 device tree. This patchaddresses an issue reported by a
Chromebook customer. When the GPU regulator is turned on, mediatek_regulator_balance_voltage already
sets both the GPU and GPU_SRAM voltages at the same time, so there is no need to adjust the GPU_SRAM
voltage again in a second round. Therefore, a return is set for MT8189.
If the user calls mediatek_regulator_balance_voltage again for GPU_SRAM, it may cause abnormal behavior of GPU_SRAM.


changes in v1:
 - mediatek-regulator-coupler mechanism for platform MT8189

*** BLURB HERE ***

Niklaus Liu (1):
  soc: mediatek: mtk-regulator-coupler: Add support for MT8189

 drivers/soc/mediatek/mtk-regulator-coupler.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.46.0


