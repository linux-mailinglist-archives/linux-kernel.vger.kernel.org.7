Return-Path: <linux-kernel+bounces-774732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEFEB2B689
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70925520653
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB7D2868AD;
	Tue, 19 Aug 2025 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IUbXgbRE"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173663595D;
	Tue, 19 Aug 2025 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568803; cv=none; b=ZhXU20N7KNHicKo1RLkL+S8jipUbd3DRQAdKcpgMZQQzujIsO60vChfSowmXI3nOHFuTbw8AeXMvjINY+/yXD/mUIQkPtQzcJoYXRx90ANp/TxdrihM7fH6aJmkUaO0R4yooWFZS+AbbFG28btW5AHHLh1logOUgxan7aN9cMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568803; c=relaxed/simple;
	bh=9Kd806kwdlKfMa2Cjv554/NSpPHwWxgGoRf932mvi6c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HkAwVgGEFqxcflbTQFJEdnMw1o9s+dmE+rX2F+KMRDtq1LxN3PdSJs5YVnEOUTmeRW88iYigaAzdNobzVNLL4E9m3zoITj83kKRqamslgGi2Ig0Nmb6LBELsObv8rnKJzYAmWmcyo578/sBTTP9Tfhd6yZsbEdEAmUyuVhPhPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IUbXgbRE; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3403b27a7ca011f08729452bf625a8b4-20250819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=w72hmReb5KMNMVr1REunFBZzQRf6nu6DrZtxaxj3TWE=;
	b=IUbXgbREQa5WHcrOXbsqaoofXd0mYdUWJBvxAOHIsCpYRr9eixTeu4REs8QByKSRwFtBae8NQPxnQCVO8yWiQkzqwTYwtxMFrHOYbu0hgBD+qfk/nmEEH8E5zW3CjO8XYy44cD5UDBipxskXgp8tORmqE9fSRfnMJ+UgMMl1lcw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:07ab7875-fdac-420b-8284-0d06e138357b,IP:0,UR
	L:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:100
X-CID-META: VersionHash:f1326cf,CLOUDID:2382457a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|801,TC:-5,Content:3|15|50,EDM:-3
	,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3403b27a7ca011f08729452bf625a8b4-20250819
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1528973073; Tue, 19 Aug 2025 09:59:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 19 Aug 2025 09:59:53 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 19 Aug 2025 09:59:52 +0800
From: Xiandong Wang <xiandong.wang@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Houlong Wei
	<houlong.wei@mediatek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Xiandong Wang <xiandong.wang@mediatek.com>
Subject: [PATCH v2 0/4] Add GCE driver for 8189
Date: Tue, 19 Aug 2025 09:59:37 +0800
Message-ID: <20250819015948.15450-1-xiandong.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This serides patches dependent on:[1]https://lore.kernel.org/all/20250601173355.1731140-8-jason-jh.lin@mediatek.com/

Xiandong Wang (4):
 [v2,01/04] dt-bindings: mailbox: add cmdq yaml for MT8189
 [v2,02/04] mailbox: mtk-cmdq: Add cmdq driver for mt8189
 [v2,03/04] arm64: dts: mediatek: Add GCE header for mt8189
 [v2,04/04] mailbox: mtk-cmdq: modify clk api for suspend/resume

 .../mailbox/mediatek,gce-mailbox.yaml         |   1 +
 arch/arm64/boot/dts/mediatek/mt8189-gce.h     | 870 ++++++++++++++++++
 drivers/mailbox/mtk-cmdq-mailbox.c            |  24 +-
 3 files changed, 885 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-gce.h

-- 
2.46.0


