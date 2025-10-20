Return-Path: <linux-kernel+bounces-860263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B49FBEFB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35D2C4EE4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0002E1F04;
	Mon, 20 Oct 2025 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YQhvmUfU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2678E2E0402;
	Mon, 20 Oct 2025 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946152; cv=none; b=BGWyhtU359eTduAAQQjbvoV2YJVXpwNabqlhyI0zwIGB/IgPaJNhGJZeToSyr0cBymaLUfg96IS+sxU7x8Ebf5lcy26r9udcLqNUGg8124RnryDrTDvw1vRq7X/sdWZj9bnJaf0KN4LZXT9sDT89KFavp07jjQx61S564UWfplY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946152; c=relaxed/simple;
	bh=HHYRzGLIRTk70bEVaBefMaWgJw39oIvRMcke4VpDEec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyEZAfeEuOYRHpVAtucbJhSgnNm2yQWk8+zwq+x96zBaYv9sieu9spT3qCgICTz2jQTlv0GO+o84hAkwQdFfdGGpRcm/yJzJANR9B0JXnx/7kGbWBn5+VPiRNszo7xKH9NYHqp/vR2yRYCMJNkmVPdcPp3t3Jrtri9s8Lb0td8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YQhvmUfU; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 515e6a90ad8811f0ae1e63ff8927bad3-20251020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QZ0/BOM3uqDC1x1Wyeb6sEDVqg8r0llXZyH9gaact54=;
	b=YQhvmUfUxalb3rr3sH6GlaVKuGKHn6CGhw29DbK3VD7P29YYpxBxAWoarAcYTz/hG2NsacYAoGdpq75K/wtVTqdnv61BFOX9RPzyOwb4HVH3OzcaMGQd/qKjd8glguLM4/nvgGdBY5OWBUf3Z29R2JtvmFUMRkdUZHdayhPabyM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1e08ce21-b539-4abd-b90c-42a567a3e03a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:43416686-2e17-44e4-a09c-1e463bf6bc47,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 515e6a90ad8811f0ae1e63ff8927bad3-20251020
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2109368698; Mon, 20 Oct 2025 15:42:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 20 Oct 2025 15:42:18 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 20 Oct 2025 15:42:17 +0800
From: Xiandong Wang <xiandong.wang@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Yongqiang Niu
	<yongqiang.niu@mediatek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Xiandong Wang <xiandong.wang@mediatek.com>
Subject: [PATCH v1 04/13] dt-bindings: soc: mediatek: add dither yaml for MT8189
Date: Mon, 20 Oct 2025 15:40:17 +0800
Message-ID: <20251020074211.8942-5-xiandong.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251020074211.8942-1-xiandong.wang@mediatek.com>
References: <20251020074211.8942-1-xiandong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add compatible string to support dither for MT8189.

Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,dither.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
index abaf27916d13..be4be0e20de8 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
@@ -28,6 +28,7 @@ properties:
           - enum:
               - mediatek,mt8186-disp-dither
               - mediatek,mt8188-disp-dither
+              - mediatek,mt8189-disp-dither
               - mediatek,mt8192-disp-dither
               - mediatek,mt8195-disp-dither
               - mediatek,mt8365-disp-dither
-- 
2.46.0


