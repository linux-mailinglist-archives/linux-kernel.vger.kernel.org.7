Return-Path: <linux-kernel+bounces-833785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06FEBA3117
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900A962596E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B776296BB3;
	Fri, 26 Sep 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D9FV5DaB"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42DC22127E;
	Fri, 26 Sep 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877523; cv=none; b=d36LUcjBSu0MevYuRBE1UeR186GxYnEkrBKxl5ljllh/S8mjys+8/Vo1t/3/zvX9w/saFmPpInO6bSfr5K5f3Z4IwpoYsR/CnoNJUQ1nHMJ+raYjA+8fRtlYqljr/PRCtp5gNlpH1gUgTUcksbeK04VIExks94Oh18eS8Chtn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877523; c=relaxed/simple;
	bh=TRdHmdPTLQqSTehLhaV94ckxcJcqtDCpI21G/ZDspug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnXesSoO+bW+mK0nQwuOR/PcBwG+i2cyb07e5TKFVtjtnzICDXW/86SfRu+TE9xU/pY59YSUfAzFc3Zb0RtPESp0Ll6IM+z3wmjTgaEZgNJmVbq7cvgo9znyZHlObRBSFqzrKAeyyXyqlwNq7ZJUFAEQRnKht5nxz9peZBUABwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=D9FV5DaB; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e71882ac9ab711f08d9e1119e76e3a28-20250926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fUJfv7mrUNSJLxysVEndj63sK2LC+Qrq359CtGzel5M=;
	b=D9FV5DaBKfG1dNbmV8HVl+UoOxRugTGzC76qkuqFE2lrYOpMKnfCgPEV5KVyjK7LsSl5khYwk4V7j3joeBtZmlxczJjauuc7CzTENkvOpMj5/rofLm0V3pDn4K/ywz0b7IdvtBAskHt9gM5q+k29krq71MKvryYaIftK58vKL+0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8333ec9b-8e73-4f5a-a5c4-913185ed5945,IP:0,UR
	L:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:100
X-CID-META: VersionHash:a9d874c,CLOUDID:e421b8f8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:3|15|5
	0,EDM:-3,IP:nil,URL:99|1,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e71882ac9ab711f08d9e1119e76e3a28-20250926
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1813086452; Fri, 26 Sep 2025 17:05:09 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 26 Sep 2025 17:05:06 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 26 Sep 2025 17:05:06 +0800
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Jjian Zhou
	<Jjian.Zhou@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jjian Zhou
	<jjian.zhou@mediatek.corp-partner.google.com>
Subject: [PATCH v6 0/2] add VCP mailbox driver
Date: Fri, 26 Sep 2025 17:04:58 +0800
Message-ID: <20250926090505.26267-1-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Jjian Zhou <jjian.zhou@mediatek.corp-partner.google.com>

Hi everyone,

This is v6 of my VCP mailbox driver.

Changes since v6:
- mtk-vcp-mailbox.c:
  - Replace mtk_vcp_mbox_priv with mtk_vcp_mbox.
  - Move mbox_controller to the first member.
  - Define "struct mbox_chan chan"; Remove allocate one during the probe.
  - Remove API get_mtk_vcp_mbox_priv.
  - Pass the private data since there's only one mailbox.
  - Modify mtk_vcp_mbox_xlate "return &mbox->chans[0]".

Changes since v5:
- binding:
  - Patch 1 fix 'make dt_binding_check' errors.
  - Link to v5
    https://patchwork.kernel.org/project/linux-mediatek/patch/20250822021217.1598-2-jjian.zhou@mediatek.com/

Changes since v4:
- binding:
  - Match the binding file name and compatible.
- mtk-vcp-mailbox.c:
  - Drop 'dev_dbg(dev, "MTK VCP mailbox initialized\n")'.
- Since the reviewer hopes to combine the VCP IPC driver and
  the VCP driver for a unified review, the original three patches
  have been split into two parts: the VCP mailbox driver and
  the binding remain together, while the VCP IPC driver is merged
  with the VCP driver and submitted as one.
- Link to v4
  https://lore.kernel.org/all/20250820094545.23821-1-jjian.zhou@mediatek.com/

Changes since v3:
- binding:
  - Remove unused lable '|' and 'vcp_mailbox0'.
- Link to v3
  https://lore.kernel.org/all/20250317110331.2776-1-jjian.zhou@mediatek.com/

Changes since v1:
- Link to v1
  https://lore.kernel.org/all/20250305082047.15746-1-jjian.zhou@mediatek.com/

In the v2 version, there is ongoing discussion about whether the VCP's
IPC should use mailbox or rpmsg. To prevent the discussion records
from being lost, the previous discussion link is attached.
https://lore.kernel.org/all/CAGXv+5FXqZb_v2dQNgCKbFpJrLhbVk3f0sWrrMCVk3jaWwoBqA@mail.gmail.com/

Jjian Zhou (2):
  dt-bindings: mailbox: mediatek,mt8196-vcp-mbox: add mtk vcp-mbox
    document
  mailbox: mediatek: Add mtk-vcp-mailbox driver

 .../mailbox/mediatek,mt8196-vcp-mbox.yaml     |  49 +++++
 drivers/mailbox/Kconfig                       |   9 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mtk-vcp-mailbox.c             | 168 ++++++++++++++++++
 include/linux/mailbox/mtk-vcp-mailbox.h       |  32 ++++
 5 files changed, 260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.yaml
 create mode 100644 drivers/mailbox/mtk-vcp-mailbox.c
 create mode 100644 include/linux/mailbox/mtk-vcp-mailbox.h

--
2.45.2


