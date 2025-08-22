Return-Path: <linux-kernel+bounces-780965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A6EB30BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4C9160F04
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866BC1B808;
	Fri, 22 Aug 2025 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PFlP7V7T"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21719D07A;
	Fri, 22 Aug 2025 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828755; cv=none; b=VojhVLotpsBiU0u6zFyE12OgTS0Tc0V7/tmo6USvJay3ib3B7jVyQ58MqkUWVFEvu7bbMmuNBgHZ5kryA5PSZpsIXDucCzVhxSHVIFU9aMk6P+Fg6PonohNTPYXiaPoEgVmGfTtESaWVeYzlW/N3lWyyn87GoOwQIx/tc896Ewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828755; c=relaxed/simple;
	bh=QBS7Ct8cfFbYUO9JWEHxoMkQ6cDFeEQmWzvd9X5VqJU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LQdWEeoASsef/TECwiqZGwhC6uwO/liIlMZnImjGqhTDmFErB8OaxYvY+Is/7cEVThWocW9tKI9e2LMlYrf1IetsaiBertd6aXuF/omZLXN4Z9rGP+FMOnl/RuX54SLqIBgziabtmC3jZ/JO+t9VRbwRjz6IcJd5dBBgve8NcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PFlP7V7T; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6fff37367efd11f08729452bf625a8b4-20250822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ReGN8GZ3oUseLHMEQPdaMihgASxibz46v8lFIrib4lc=;
	b=PFlP7V7TIpAfJD0NVBSzWlK0mfAAXOWRA00ULI0PY+4GvSWSdQvO0rzthi+lZWfi3BY8TJmghedTI1FD6JVX7DXX/hZsGVIYeNknh7SpGx2C+eELTQFPEixSuDCIEiGL4u81y/DVVTQA+as44zkVbXYmLaXhaB4Mg1YiHYlquGo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:6a47cc85-47d2-432c-8417-bd1fd47907ba,IP:0,UR
	L:0,TC:0,Content:100,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:70
X-CID-META: VersionHash:f1326cf,CLOUDID:af927c6d-c2f4-47a6-876f-59a53e9ecc6e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|801,TC:-5,Content:3|15|50,EDM:2,
	IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6fff37367efd11f08729452bf625a8b4-20250822
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1503081314; Fri, 22 Aug 2025 10:12:21 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 22 Aug 2025 10:12:19 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 22 Aug 2025 10:12:18 +0800
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
Subject: [PATCH v5 0/2] add VCP mailbox driver
Date: Fri, 22 Aug 2025 10:12:07 +0800
Message-ID: <20250822021217.1598-1-jjian.zhou@mediatek.com>
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

This is v5 of my VCP mailbox driver.

Changes since v5:
- bindngs:
  - Patch 1 fix 'make dt_binding_check' errors.

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
 drivers/mailbox/mtk-vcp-mailbox.c             | 174 ++++++++++++++++++
 include/linux/mailbox/mtk-vcp-mailbox.h       |  32 ++++
 5 files changed, 266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.yaml
 create mode 100644 drivers/mailbox/mtk-vcp-mailbox.c
 create mode 100644 include/linux/mailbox/mtk-vcp-mailbox.h

--
2.46.0


