Return-Path: <linux-kernel+bounces-884024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8EFC2F1F9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27B6189CD49
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E7A264A74;
	Tue,  4 Nov 2025 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RFwJLlL7"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C791DF24F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762226151; cv=none; b=r4WBNJ/TR+R8G7tbfTDC+MmoCppjKM3mI2kLrF7KkbCe0IHtZMEoARgmaohVB0W4bIfznJRXpRFuMtRTJC3F8uwur5Avn/z4y7mKIfxW+P8TIythPh5xZbai/rMD9Ook98nIVxXlsjUh5+vhGMI9uuTNZ2G9skXZBCnzj2JLsVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762226151; c=relaxed/simple;
	bh=01mMD+ZG8oD4x45Vuj+MSWEjXKL1O8I3bwpjvEXUPHw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yb/7+dHO63N/f+DEwyS6DiGhr++CAmO4r+G9+161sdZhjHkYx4wf9F2ffK6sF2HVsABtAYFaP1cwsXkrVgDTfk38u9EXq+K5SODOXwy1cR/8OZdunRyJqpQfVOKZy/kyK3xeoh05bst9zuc88bztA2+8XSpSd1cPl/wov7h6Qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RFwJLlL7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8c2b5552b92c11f0b33aeb1e7f16c2b6-20251104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eZ6ZtD8Gmf0w5lKM2vkfFs2CimSRsAbkAEMvQcHMakY=;
	b=RFwJLlL7+MKoQLWWAzFUCRxteNhb9THukX13pl2fEFAVCLGuMPqUctUIJSxe+9y3JDJEbgOuZF50GlohbBEv8RUvjuspv97DMsC7W+Mg3yq3OvPxgWpktD7fUp3AlY2oCsP4GXKW6DsTEa8CfDzDoXAj2InOxKbi33DEhGOOYgQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:bd521406-20d3-45ae-befb-deaea2c68463,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:8ebde218-3399-4579-97ab-008f994989ea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:-7|-6|
	0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8c2b5552b92c11f0b33aeb1e7f16c2b6-20251104
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <niklaus.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1066804111; Tue, 04 Nov 2025 11:15:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 4 Nov 2025 11:15:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 4 Nov 2025 11:15:35 +0800
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
Date: Tue, 4 Nov 2025 11:15:10 +0800
Message-ID: <20251104031533.9419-1-Niklaus.Liu@mediatek.com>
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
V1 patch link:https://lore.kernel.org/linux-mediatek/20251103134241.3773-2-Niklaus.Liu@mediatek.com/

Subject: [PATCH 0/1] soc: mediatek: mtk-regulator-coupler: Add support for MT8189

changes in V2:
 - change title for patch
 - reply comment: This is a software regulator coupler mechanism, and the regulator-coupled-with
configuration has been added in the MT8189 device tree. This patchaddresses an issue reported by a 
Chromebook customer. When the GPU regulator is turned on, mediatek_regulator_balance_voltage already
sets both the GPU and GPU_SRAM voltages at the same time, so there is no need to adjust the GPU_SRAM 
voltage again in a second round. Therefore, a return is set for MT8189.
If the user calls mediatek_regulator_balance_voltage again for GPU_SRAM, it may cause abnormal behavior of GPU_SRAM. 


changes in V1:
 - mediatek-regulator-coupler mechanism for platform MT8189 

Niklaus Liu (1):
  soc: mediatek regulator: Add Support for mt8189

 drivers/soc/mediatek/mtk-regulator-coupler.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.46.0


