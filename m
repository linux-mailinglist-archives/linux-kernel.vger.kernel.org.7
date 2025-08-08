Return-Path: <linux-kernel+bounces-760271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB603B1E8C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33E57B0CC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D227AC5C;
	Fri,  8 Aug 2025 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HRYjc71K"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6440327A903;
	Fri,  8 Aug 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657847; cv=none; b=uCtycvi2KSHif2qKOttVQra5z9A972B9OSZOd1dHd2hgKGMPFo6WCpGdOSifN9KDCvCMUHvI5clxg7lpmaIEZTdMULn2Yir0fB6bbPwCIhoCJyE1urDxZpuVJKjs8p0s3p4V57TEliuTCLaTWWoaDoxW5n/Lb+776ZDuyk/vvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657847; c=relaxed/simple;
	bh=3ikxVchMVH5jgWbMMrsXxHTJ9ZhRQ76kLhxi31HSEYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=se8HksKj8m2LOB4h+2l57kDpU0zb5DM4gOueoOSUbUPx0D38V0sAVe90co2MzRJ75jKZ7H1UTERO3vFre43WbDueQccYjG0IbSQT1NnhBx9lGddGSZbDf/yKi37X58OhAbTjr52CJhZqD8/OVI6kr7VBp335Bdw5J4hpzC5befc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HRYjc71K; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 311641aa745711f0b33aeb1e7f16c2b6-20250808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xaE7a1WlCpQG5LbP5mkDzB5O43tR9+ymx9MnqHR0iHc=;
	b=HRYjc71KTMfEBOF00J40q/iigNHvrUFl9WY4bO2H/9TOu2Gnxb3ZT96M7q8VG+EJYklxDzOrbT8WDiWraPN3AO/cvy0jVrsrQnqBbKra5uYYZo1244HSN4OWi6BJRy86yW3Rrk0L8Gl2qrqB6tTM4zEKS+7vOPDCKKoGGUKwDmI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:c98c5727-448b-40fd-bbbf-ed318966eed9,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:068d3551-d89a-4c27-9e37-f7ccfcbebd5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 311641aa745711f0b33aeb1e7f16c2b6-20250808
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1270083541; Fri, 08 Aug 2025 20:57:08 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 8 Aug 2025 20:57:06 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 8 Aug 2025 20:57:04 +0800
From: Jay Liu <jay.liu@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Jay Liu <jay.liu@mediatek.com>
Subject: [PATCH v3 3/6] dt-bindings: display: mediatek: ccorr: Add support for MT8196
Date: Fri, 8 Aug 2025 20:53:58 +0800
Message-ID: <20250808125512.9788-4-jay.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250808125512.9788-1-jay.liu@mediatek.com>
References: <20250808125512.9788-1-jay.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a compatible string for the CCORR IP found in the MT8196 SoC.
Each CCORR IP of this SoC is fully compatible with the ones found
in MT8192.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Jay Liu <jay.liu@mediatek.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
index fca8e7bb0cbc..581003aa9b9c 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
@@ -32,6 +32,7 @@ properties:
               - mediatek,mt8186-disp-ccorr
               - mediatek,mt8188-disp-ccorr
               - mediatek,mt8195-disp-ccorr
+              - mediatek,mt8196-disp-ccorr
           - const: mediatek,mt8192-disp-ccorr
 
   reg:
-- 
2.46.0


