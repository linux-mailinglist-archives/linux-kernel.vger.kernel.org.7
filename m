Return-Path: <linux-kernel+bounces-884345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5688C2FFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF9F1885ED3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2F131282A;
	Tue,  4 Nov 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qr9fTJGJ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED34312802
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245404; cv=none; b=pcs1LeS39rEdHBp8F39rlB9Zrhjz8jUVek/YjPgs6k+LraVYH2A1fegLRCd/iSyA5L49FBsHvp3LIoaYaC3Jr+GUAjyetqM1IEe5m4I88nHut+2Btp2rGFSzcl/NHBg3HYGYgcqFC9JyUCvI3j0bR5opEr1ciMb0OklU+raR5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245404; c=relaxed/simple;
	bh=7uUuCR2ls+iaa0LzJrp8WYXBp0z3pvh0OeUVw47BKXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sQ3eEgDY2ZfSy8ChQK09z4ln0kHVpqdoqKpdg2GUJu03np2JuZX5jRvJEx1yZgpLoK429ByHAvS0gF+l/So1rsslOjaup2cK+lZg0/TxqfStp3hUljxlmclzL3f6V3XQlIM1ktjKykHP/sfVDOZ2g6Pk3mE6lR0lLpRsINi25ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qr9fTJGJ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 603522a2b95911f08ac0a938fc7cd336-20251104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IwoMQZgAiMDGMp0dhfCLY+pPdAnU6iLDOBK8OSYXqYw=;
	b=qr9fTJGJSKkue7JxTPdOtzaA2qPGmSg6HBiyh//RgVLBvP9PoAfM/fqJ54tdyOE1QEleqxKzAKAghZ5mWZhq1xEbIMjepuTiCGpAzbCo+PsHPLxDoDSfGFblfeJq7r/o5xmLhNcJg+zM0qts+G49lut98hEqWt1SWIpJEJvPfOs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:23db89b6-3d82-4462-bbdc-f6cba170ea49,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:180fe47c-f9d7-466d-a1f7-15b5fcad2ce6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:-7|-6|
	0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 603522a2b95911f08ac0a938fc7cd336-20251104
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <niklaus.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1431637125; Tue, 04 Nov 2025 16:36:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 4 Nov 2025 16:36:35 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 4 Nov 2025 16:36:34 +0800
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
Date: Tue, 4 Nov 2025 16:34:12 +0800
Message-ID: <20251104083630.13541-1-Niklaus.Liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series is based on linux-next, tag: next-20251103

Refer to the discussion in the link:
v1: https://patchwork.kernel.org/project/linux-mediatek/patch/20251103134241.3773-2-Niklaus.Liu@mediatek.com/
v2: https://patchwork.kernel.org/project/linux-mediatek/patch/20251104031533.9419-2-Niklaus.Liu@mediatek.com/

Subject: [PATCH v3 0/1] soc: mediatek: mtk-regulator-coupler: Add support for MT8189

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

Niklaus Liu (1):
  soc: mediatek: mtk-regulator-coupler: Add support for MT8189

 drivers/soc/mediatek/mtk-regulator-coupler.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.46.0


