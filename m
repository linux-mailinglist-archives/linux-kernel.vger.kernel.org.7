Return-Path: <linux-kernel+bounces-755162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C0B1A23B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0ED53AF4E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FE126059E;
	Mon,  4 Aug 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FVaDJIzt"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C9325A626;
	Mon,  4 Aug 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311948; cv=none; b=ADx3cx+2HYuvdjlnOBYBiEC3JcbRj5bhp/esVuIv0nBaA4FvisaNzpy+/u1KaMQr8RntQPjk2mPZB6Lk7V6TLVM2y3skmnmxi6ov9rKk7/YAlDMuEAe/QbARRIo4YJhkHB4lkx/AnohvCBXfPGey4pcOGFJWZ339zhXpbQz0EFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311948; c=relaxed/simple;
	bh=jKLcK+Dd+sbmxQEcabkdl6mjLBpxwtBD6rmKwXtih+8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fL3YywT01H48yEpqaGDDVcieHF08FUyAp7xxoRN+z3RHeA31Pc11LKL7YeppaIUM/we2nL2ID4owoXPo2ZD5ObxGzy99gULKvMsiw7FduOtzv/aNlXH6CgTd/InugF5bz7VEtUNdAbEGq4SkEbrlf5La3ASCKxROAlCKzEZjAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FVaDJIzt; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: db689b2c713111f08871991801538c65-20250804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rYMR5chlPy2tpwvio9NlfPgzh2Cb5gxMxxA1dz+0yWU=;
	b=FVaDJIztjGKJW2kFpvPS3+qHIGjM7headQVPnJv9nBA7m9vRW80rL2Ilb+PedtQlma9UOTh39h3qmkSKxwNp/Vm0swuqi4vehSNlSwouavRcSqEsx4rD0q6W5xYUhLSpGsplanttEYPC2vVJpfX36Rxi5PakNEf2RASvZo3fLbI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:f2b9f652-b2af-4ea7-8751-4dfd21d8ce30,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:49029150-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: db689b2c713111f08871991801538c65-20250804
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1855628458; Mon, 04 Aug 2025 20:52:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 4 Aug 2025 20:52:17 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 4 Aug 2025 20:52:16 +0800
From: Friday Yang <friday.yang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: Friday Yang <friday.yang@mediatek.com>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v9 0/2] Add SMI reset and clamp for MediaTek MT8188 SoC
Date: Mon, 4 Aug 2025 20:51:52 +0800
Message-ID: <20250804125215.23076-1-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on tag: next-20250804, linux-next/master

On the MediaTek MT8188 SoC platform, we encountered power-off failures
and SMI bus hang issues during camera stress tests. The issue arises
because bus glitches are sometimes produced when MTCMOS powers on or
off. While this is fairly normal, the software must handle these
glitches to avoid mistaking them for transaction signals. What's
more, this issue emerged only after the initial upstreaming of SMI
driver.

The software solutions can be summarized as follows:

1. Use CLAMP to disable the SMI sub-common port after turning off the
   LARB CG and before turning off the LARB MTCMOS.
2. Use CLAMP to disable/enable the SMI sub-common port.
3. Implement an AXI reset for SMI LARBs.

---
Changes in v9:
- Add 'dev_pm_genpd_remove_notifier' in 'mtk_smi_larb_remove'.
- Remove unused macros.
- Rename 'sub_comm_syscon' to 'smi_comm_syscon'.
- Rename 'sub_comm_inport_id' to 'smi_comm_inport_id'.
- Add more detailed descriptions in change log.
- Fix incorrect tags.

Changes in v8:
- Fix incorrect tags.

Changes in v7:
- We replaced 'pm_runtime_enable' with 'devm_pm_runtime_enable' in the
  v6 patch. This changed the order of cleanup, and reviewers expressed
  concerns that it could introduce unexpected issues. So v7 discard this
  change and continue using 'pm_runtime_enable'. We need to conduct
  further investigation to determine if there are any issues related
  to the cleanup order. This might be resolved in the future, but for
  now, we just maintain the current status.

Changes in v6:
- Fix coding style.
- Add another patch to replace 'pm_runtime_enable' with
  'devm_pm_runtime_enable'.

Changes in v5:
- Use 'devm_pm_runtime_enable' instead of 'pm_runtime_enable'.
- Remove 'pm_runtime_disable' in 'mtk_smi_common_remove' and
  'mtk_smi_larb_remove'.

Changes in v4:
- Use 'devm_reset_control_get_optional_exclusive' instead of
  'devm_reset_control_get'.

Changes in v3:
- Remove redundant descriptions for 'resets' and 'reset-names'.
- Modify the requirements for 'resets' and 'reset-names'.
- Rename 'mtk_smi_larb_parse_clamp' to 'mtk_smi_larb_parse_clamp_optional'.
- Rename 'mtk_smi_larb_parse_reset' to 'mtk_smi_larb_parse_reset_optional'.
- Merge 'mtk_smi_larb_clamp_protect_enable' and
  'mtk_smi_larb_clamp_protect_disble' into one function.
- Modify the definition for mtk_smi_larb_clamp_port_mt8188,
  use 'larbid' as the index of the array.
- Use 'syscon_regmap_lookup_by_phandle' instead of 'device_node_to_regmap'.
- Do Not parse 'resets', just check the return value of
  'devm_reset_control_get'.
- Add 'has_gals' flag for 'mtk_smi_sub_common_mt8188'.

Changes in v2:
- According to previous discussions in v1, divided these four
  patches into two topic separately.
- Modify the description for 'resets' in binding.
- Add const value 'larb' for 'reset-names' in binding.
- Modify requirement for 'resets' and 'reset-names' in binding.
- Delete 'mediatek,smi-sub-comm' in binding.
- Delete 'mediatek,smi-sub-comm-in-portid' in binding.
- Modify the example in binding.
- Add 'mtk_smi_larb_clamp_port_mt8188' definition in SMI driver.
- Change the way to parse the 'resets' in driver.
- Change label from 'err_pm_disable' to 'err_link_remove'.

---
Friday Yang (2):
  dt-bindings: memory: mediatek: Add SMI reset and clamp for MT8188
  memory: mtk-smi: mt8188: Add SMI reset and clamp for MT8188

 .../mediatek,smi-common.yaml                  |   2 +
 .../memory-controllers/mediatek,smi-larb.yaml |  19 +++
 drivers/memory/mtk-smi.c                      | 131 ++++++++++++++++++
 3 files changed, 152 insertions(+)

--
2.46.0


