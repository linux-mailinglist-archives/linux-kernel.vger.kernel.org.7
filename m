Return-Path: <linux-kernel+bounces-871494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF4C0D78F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9F13B6130
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399B113B797;
	Mon, 27 Oct 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lUnCNaqx"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EA72417C6;
	Mon, 27 Oct 2025 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567322; cv=none; b=h3gAHA93/mY9ueKsfru7y3xDvM6SbCsqRqQl6d5kBtkQjebU2Fo6OL/sg80teckyquuSF85PMxRgv3T1Ryei9XTTcwOm/e042Cws7j7uSJkbRPABIDYRtMANFLbk5pp+uPJcFA/V4W/r/yVQ0dP6tne2q8LuABvCWL/DVMSR1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567322; c=relaxed/simple;
	bh=+nOkp3IWdM2UhJJLngXTroRkS/xiDVRL2RL9/FRxswo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EnGmYC7jEXVZGlBLzTI70xzjW1YNyH7FWv1ybI8FTopojy9Ezk0Mv38Kmz8CmKs8EEQlsLTkJplUOrjsXPWtHfb3mrDiRwGfpkTOV+XMFlVsvtlUaxBnc75Tc/wqU59akddFjDqusL0o4b4GKRNlkQWMt43K2VGwM34rUxCyCKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lUnCNaqx; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 95f18150b32e11f0ae1e63ff8927bad3-20251027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5MoVf5Kl/6L1RrhGRcruXT/51Lf6AulqPFulSW9hKkI=;
	b=lUnCNaqxmtr7DSdHq3OfLvKLxVrYHs4jhRwvZ1CmwnPQOjU2ELigq5/pL9IImInpLDafDPH8QBtIp6DbdnU+RJq09y5VG7zhSdZB3jDE8SQKNLAsyK/4EinoigixLdIgLPAclRozC/oS7EN9SHjhoSuYbwhf+j2DeYO8t6gHcWA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:37acbe48-bdad-4c88-8a03-2ad54999bc76,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:22205a84-4124-4606-b51d-d5c9eec0e7b9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:99|1,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 95f18150b32e11f0ae1e63ff8927bad3-20251027
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1352561052; Mon, 27 Oct 2025 20:15:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 27 Oct 2025 20:15:06 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 27 Oct 2025 20:15:05 +0800
From: Zhengnan Chen <zhengnan.chen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Zhengnan Chen
	<zhengnan.chen@mediatek.com>
Subject: [PATCH v2 0/2] MT8189 SMI SUPPORT
Date: Mon, 27 Oct 2025 20:14:26 +0800
Message-ID: <20251027121443.16783-1-zhengnan.chen@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on tag: next-20251024, linux-next/master

This patchset add mt8189 smi support.

---
Changes in v2:
Just modify the mediatek,smi-common.yaml file as follows:
- Add schematic diagram explanation between smi-common and smi-sub-common
- Change the clock numbers of smi-sub-common to minimum 2, the third clock
  is optional
- Link to v1:
  https://lore.kernel.org/all/20250919081014.14100-1-zhengnan.chen@mediatek.com/
---

Zhengnan Chen (2):
  dt-bindings: memory-controllers: mtk-smi: Add support for mt8189
  memory: mtk-smi: Add mt8189 support

 .../mediatek,smi-common.yaml                  | 25 ++++++++++-
 .../memory-controllers/mediatek,smi-larb.yaml |  3 ++
 drivers/memory/mtk-smi.c                      | 44 +++++++++++++++++++
 3 files changed, 70 insertions(+), 2 deletions(-)

-- 
2.46.0


