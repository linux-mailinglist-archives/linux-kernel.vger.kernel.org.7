Return-Path: <linux-kernel+bounces-687572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90113ADA6B1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 05:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EB516DD9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 03:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E9B2949F4;
	Mon, 16 Jun 2025 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bm/nr8l5"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9121C27;
	Mon, 16 Jun 2025 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750043509; cv=none; b=uWewo9WrrpJtg80E1P/uNKl4dIr5kHdP2rtUZ8GPggakuRhOC62wK7MQOLp1KKRheBfuibWaamnyiZTdkOl9Yh5NV+cyKKF544JQ5w/0Zb3k+fm/qA2ssU3M1r1PHx3SV+y+cFWOU502FmfNWe0n7fqxGj6vaYtuwQWLzr4p4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750043509; c=relaxed/simple;
	bh=a2uo9elXTgzLFuBHkfb3Lr35t8qxBu6vGbz8AGG56CI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D9TNMKOLeviQefjn30z2oZ1dbdnsziI+tLgxaRxzGrtZYADrfWtaCN1y0ORB4tsJoXFHHwh0Ql/k5A/lbiRa9qNVFjy5aao4SzIELbdeeNCnxZI8ari66rV+X2zz6c0vg4lHDmlIs5f2bezR94E40DHcCst+o0a6t0w+0AO9pow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bm/nr8l5; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 830f1e884a5d11f0b33aeb1e7f16c2b6-20250616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=umZZODBC0zwW+FQGVQ1VvC9xChtDdOxEYWQjHr8vmZw=;
	b=bm/nr8l5c4yKanc+nOIpT0Bu1GoMYHmOQlKsM0+BCxuNH91CkaZU3uvhw11g3SaKj/UJCg5mvIZ48GbhOGzSEe6/x4k+kE0b3fYjkcEWwTKgz8YqRrf5u+Eb7IG6JWDc4QrLipt748EXCQaQe7LH+8rwEA9C2NHfEb+KM6AF3I8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:57973a7f-8708-4e1f-b11e-3f3f3a8f14ae,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:09905cf,CLOUDID:7c93b703-0d95-4f6b-a95f-3c560ebcf3ab,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 830f1e884a5d11f0b33aeb1e7f16c2b6-20250616
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1095104460; Mon, 16 Jun 2025 10:56:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 16 Jun 2025 10:56:31 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 16 Jun 2025 10:56:31 +0800
From: Xueqi Zhang <xueqi.zhang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>, Ning li
	<ning.li@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <iommu@lists.linux.dev>, Xueqi Zhang
	<xueqi.zhang@mediatek.com>
Subject: [RFC PATCH 0/8] Add mt8196 SMMU support
Date: Mon, 16 Jun 2025 10:56:06 +0800
Message-ID: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patchset add mt8196 SMMU support.
1. Mediatek SMMU interrupt is low level active rather than the
standard edge. Process Mediatek SMMU wrapper interrupt and dump
detailed information when a translation fault occurs.
2. In some projects, Mediatek also have EL2 driver, so put the pm
operation in TFA(EL3), then all the kernel and EL2 could control
the pm. Thus implement rpm get/put function which send smc call to
TFA to get/put SMMU power.

Xueqi Zhang (8):
  dt-bindings: iommu: mediatek: Add mt8196 support
  iommu/arm-smmu-v3: Add SMMU implementation
  iommu/arm-smmu-v3: Add implementation for MT8196 MM SMMU
  iommu/arm-smmu-v3: Add implementation for MT8196 APU SMMU
  iommu/arm-smmu-v3: Add IRQ handle for smmu impl
  iommu/arm-smmu-v3: mediatek: Add wrapper handle for IRQ
  iommu/arm-smmu-v3: Invoke rpm operation before accessing the hw
  iommu/arm-smmu-v3: mediatek: Implement rpm get/put function

 .../bindings/iommu/arm,smmu-v3.yaml           |  24 +-
 drivers/iommu/arm/Kconfig                     |   7 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   3 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c  |  16 +
 .../arm/arm-smmu-v3/arm-smmu-v3-mediatek.c    | 536 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  96 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  14 +
 7 files changed, 691 insertions(+), 5 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c

-- 
2.46.0


