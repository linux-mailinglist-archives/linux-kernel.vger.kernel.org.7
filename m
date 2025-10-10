Return-Path: <linux-kernel+bounces-848047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BCEBCC597
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44A4188F2F1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E97626C399;
	Fri, 10 Oct 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TBSXId8M"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF022A7E9;
	Fri, 10 Oct 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088662; cv=none; b=bF/TszJppW6GfgBc2YRp9zUzxLxuPwl2/1XrrcOI7cAui/kaUpXBvTu/MnPnRA5MBjolp1HMre5YlA+tvPDhWD1b8F2FIaNm8rtI4G5jLVL5UcVqwo7gMfZYXDXV+yFWoFNVErJdBTYPg+xRabUYz/yhPoYegsdnNcVnrEWvCj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088662; c=relaxed/simple;
	bh=RV3nJe9Z1SgqRSaEEuLg6xCo0XUPt0Jjp+OWmtet9u8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=avCcQe+r8KGCq4vSqyC6L14hSYeaSUsXI0MWIGF0FyAc2lrScVqjRNwnYEVl37zR03FaGlyvlysLkVY1aMwEce5/ieE8/t8qF1VVfa5EmFkwx1VkT5I03o79IJJ0SsJ9ZIxXNUHOu8RQ2UVhZT4BF0VXWnFXBKSMNM7/Pg/vJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TBSXId8M; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b80c3fbea5b911f0b33aeb1e7f16c2b6-20251010
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=H3of7YrV+5xb3g+5AFeitSvuyxLrTP7gdg0SAaNkM/Q=;
	b=TBSXId8MeghtkdQdoKlJ9p1GaCK0zAoV9r8UMyjvfeHcn3biK0RnxwLKphjeQ3KVTBXYguXviLVLS8ze/FejInz8drRhuYhuix9fVoB1k7FU5jCr/X7e81GBbYiT8+8BzxWMxJi7kq8Hc64X4hsQ3ZcTF5bN5nXDj3OuYdxBgjQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ad416515-59ca-47b7-ac2e-e80579715fe9,IP:0,UR
	L:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:100
X-CID-META: VersionHash:a9d874c,CLOUDID:d8ef06b9-795c-4f99-91f3-c115e0d49051,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:3|15|5
	0,EDM:-3,IP:nil,URL:99|1,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b80c3fbea5b911f0b33aeb1e7f16c2b6-20251010
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1610317772; Fri, 10 Oct 2025 17:15:52 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 10 Oct 2025 17:15:50 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 10 Oct 2025 17:15:49 +0800
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Jjian Zhou
	<Jjian.Zhou@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jjian Zhou
	<jjian.zhou@mediatek.com>
Subject: [PATCH v8 0/2] add VCP mailbox driver
Date: Fri, 10 Oct 2025 17:15:10 +0800
Message-ID: <20251010091549.21325-1-jjian.zhou@mediatek.com>
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

Hi everyone,

This is v8 of my VCP mailbox driver.

Changes since v8:
- Rebase onto next-20251008 and fixed build breaks.

Changes since v7:
- mtk-vcp-mailbox.c:
  - Change type u32 to u16.
  - Change BIT(ipi_info->index) to if.
  - Put the platform_set_drvdata between "of_device_get_match_data"
    and "platform_get_irq".
- mtk-vcp-mailbox.h
  - Modify the definition to MTK_VCP_MBOX_SLOT_MAX_SIZE.

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
 drivers/mailbox/mtk-vcp-mailbox.c             | 170 ++++++++++++++++++
 include/linux/mailbox/mtk-vcp-mailbox.h       |  32 ++++
 5 files changed, 262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.yaml
 create mode 100755 drivers/mailbox/mtk-vcp-mailbox.c
 create mode 100755 include/linux/mailbox/mtk-vcp-mailbox.h

--
2.45.2


