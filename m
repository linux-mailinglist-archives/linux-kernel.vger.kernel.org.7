Return-Path: <linux-kernel+bounces-777396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 732A4B2D8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928751C8274D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE772E612C;
	Wed, 20 Aug 2025 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t2eeBea0"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DE2DCF72;
	Wed, 20 Aug 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682726; cv=none; b=cmjlYc3S56EQkhuDHm1YXzpxLaaPMzysuNSwqMdIiyYc7CerP1t4CvlySDu7i7qBlNFmiHqdyvP6V9OiIcaHUCp8Ni80k/G/IZh5hem/jYamppVS7HP5tekG0O2gI6VL+fm8rS+ZPpmoG39ODGQwFVwb3ygyVWR8RddIJK1VgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682726; c=relaxed/simple;
	bh=A2FKhP2BETOtsK0ZOOK3QfNhmDMzvLvKXwyRUSvS9KU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u9kOGNa1Ry5anasXhicnHenuL0CKqqNI02Rpi8U47EKeXgtpr/O3rhS+gWeM1Q8xaJMvIi775y7tPaj7bp798m0DAf3MjiJIqIoIwzjloYqKwmL61iX+Xr2k2+5NtjMCAm0O3nxvf2eBlW/XaoaR2jGb/+qVo531JWzZoxTIZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=t2eeBea0; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 712699ba7da911f0b33aeb1e7f16c2b6-20250820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=l1zMvEX5DRNOfBq8wZXAWH0EFZuVIv7jq4PHjQLkxbo=;
	b=t2eeBea0GsVvey88vYSGGq/fLapNffZACFo2ZDS5n/nI8hfEGBCBfnilbs1YPzYGDH+sdzy5w6v1OK06aFCS++B0VsNWUilumcSklqAZRydlONcfhWBUDubRQQ4vvjN16J98+JZgwYfRJz1itEIPplQHL4EwWO2oOQ6Djylchv8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:92f585f7-ebd6-4594-afec-f5a4ac20f4d9,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:cd9a6a6d-c2f4-47a6-876f-59a53e9ecc6e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 712699ba7da911f0b33aeb1e7f16c2b6-20250820
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <xiandong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1381413739; Wed, 20 Aug 2025 17:38:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 20 Aug 2025 17:38:33 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 20 Aug 2025 17:38:32 +0800
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
Subject: [PATCH v4 0/4] Add CMDQ driver support for 8189
Date: Wed, 20 Aug 2025 17:38:19 +0800
Message-ID: <20250820093831.23437-1-xiandong.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The patches are based on the series:
https://lore.kernel.org/all/20250601173355.1731140-3-jason-jh.lin@mediatek.com/
https://lore.kernel.org/all/20250601173355.1731140-4-jason-jh.lin@mediatek.com/
https://lore.kernel.org/all/20250601173355.1731140-7-jason-jh.lin@mediatek.com/
https://lore.kernel.org/all/20250601173355.1731140-8-jason-jh.lin@mediatek.com/

Changes in v4:
-Modify the order of driver data for 8189.
-All uppercase characters in the GCE header have been converted to lowercase characters.
-Link to v3: https://lore.kernel.org/all/20250819033746.16405-2-xiandong.wang@mediatek.com/

Changes in v3:
-Modify unused property of 8189 driver data
-Link to v3: https://lore.kernel.org/all/20250819033746.16405-4-xiandong.wang@mediatek.com/ 

Changes in v2:
-Modify the title for series.
-Link to v2: https://lore.kernel.org/all/20250819015948.15450-2-xiandong.wang@mediatek.com/

Changes in v1:
-Add GCE driver data for 8189.
-Modify the clk api for 8189 gce suspend/resume.
-Link to v1: https://lore.kernel.org/all/20250814070401.13432-1-xiandong.wang@mediatek.com/

Xiandong Wang (4):
[v4,01/04] dt-bindings: mailbox: add cmdq yaml for MT8189
[v4,02/04] arm64: dts: mediatek: Add GCE header for mt8189
[v4,03/04] mailbox: mtk-cmdq: Add CMDQ driver support for mt8189
[v4,04/04] mailbox: mtk-cmdq: Fix clock handling using clk_bulk_prepare_enable

 .../mailbox/mediatek,gce-mailbox.yaml         |   1 +
 arch/arm64/boot/dts/mediatek/mt8189-gce.h     | 870 ++++++++++++++++++
 drivers/mailbox/mtk-cmdq-mailbox.c            |  24 +-
 3 files changed, 885 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-gce.h

-- 
2.46.0


