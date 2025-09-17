Return-Path: <linux-kernel+bounces-820605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B369B7CADF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464F65814AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F0393DE8;
	Wed, 17 Sep 2025 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gr5ali9U"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73C37C103;
	Wed, 17 Sep 2025 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110858; cv=none; b=sAlo2knjKQpUIziFIkWfMLNK82uGKOZM/eFWem0IWIgMGIHcy/+8hzkcuOdiFLlR6pt6u+sI9rpzNIsm7OCauNqfOxJX4iaeIgwnAiCcuEMFBqFoJrINlXGTjOak2avG8oURXN+LAbkB3sSJHS/H1WhA+mj0U17r6x7HyLDx6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110858; c=relaxed/simple;
	bh=BJhiBrqq2sloeNw+EH3KAeDY8MIsGLxoaYBZchWOtmQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UTp5mCQNX5vSl0KopS2ZbNkbhQdEwDDBSy30i7XpZqWDxIyrwRuD9JLLv3lAhnPO1u1+Qf2wTpw91huNwhJk/1onLkhA9ty2yR3jM+FrX2+S5WO6DcSOHolXBY7lRqyVMe9eAS4lrwYZ3aZfwdbjgbT9xZZnHlPf1GU2qOWZxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gr5ali9U; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e148e22293be11f0b33aeb1e7f16c2b6-20250917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4bOud9qjAxW5fippeolvgsdJ9dk6b5FIb1o0FJOlHWU=;
	b=gr5ali9UymmN1cDIkZECdrpRGYKmnAyOcwGnaj0nHgIs/v+NN0BMvukyoX52lxzm1NSHcz02o9fjscBBgrwcM3VK4WZjvUGvOzUXzGRJhTYPcOGQKSuWaRYs7HSQp8lPMPGg515gTDvGuyHhh3tgQ+cFKh0BwqdRa/FdXhim54E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:b2488756-dde2-4a77-9395-f024854d0835,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:51fea76c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836,TC:-5,Content:0|15|50,EDM:-3
	,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e148e22293be11f0b33aeb1e7f16c2b6-20250917
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 900360238; Wed, 17 Sep 2025 20:07:28 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 17 Sep 2025 20:07:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 17 Sep 2025 20:07:25 +0800
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
Subject: [PATCH v11 0/2] Add SMI reset and clamp for MediaTek MT8188 SoC
Date: Wed, 17 Sep 2025 20:07:15 +0800
Message-ID: <20250917120724.8650-1-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on tag: next-20250916, linux-next/master

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
Changes in v11:
- Add error checking in the 'mtk_smi_genpd_callback' function and use
  'switch-case' statement instead of 'if-else'.
- Use 'larb->larb_gen->clamp_port[larb->larbid]' to determine
  whether smi larb requires clamp and reset operations or not in
  'mtk_smi_larb_probe'. Remove the '_optional' suffix from the
  function name.
- Replace 'devm_reset_control_get_optional_exclusive' with
  'devm_reset_control_get_exclusive' in 'mtk_smi_larb_parse_reset',
  return the error code if it fails to get the reset controller.
- Remove genpd callback when smi larb probe fails.

Changes in v10:
- Rename 'smi_comm_inport_id' to 'smi_comm_in_port_id'.
- Return 0 when it fails to get 'larb_id' in
  'mtk_smi_larb_parse_clamp_optional'.
- Link to v10:
  https://lore.kernel.org/lkml/20250806085946.11383-1-friday.yang@mediatek.com/

Changes in v9:
- Add 'dev_pm_genpd_remove_notifier' in 'mtk_smi_larb_remove'.
- Remove unused macros.
- Rename 'sub_comm_syscon' to 'smi_comm_syscon'.
- Rename 'sub_comm_inport_id' to 'smi_comm_inport_id'.
- Add more detailed descriptions in change log.
- Fix incorrect tags.
- Link to v9:
  https://lore.kernel.org/lkml/20250804125215.23076-1-friday.yang@mediatek.com/

Changes in v8:
- Fix incorrect tags.
- Link to v8:
  https://lore.kernel.org/lkml/20250521063347.31578-1-friday.yang@mediatek.com/

Changes in v7:
- We replaced 'pm_runtime_enable' with 'devm_pm_runtime_enable' in the
  v6 patch. This changed the order of cleanup, and reviewers expressed
  concerns that it could introduce unexpected issues. So v7 discard this
  change and continue using 'pm_runtime_enable'. We need to conduct
  further investigation to determine if there are any issues related
  to the cleanup order. This might be resolved in the future, but for
  now, we just maintain the current status.
- Link to v7:
  https://lore.kernel.org/lkml/20250430094545.23932-1-friday.yang@mediatek.com/

Changes in v6:
- Fix coding style.
- Add another patch to replace 'pm_runtime_enable' with
  'devm_pm_runtime_enable'.
- Link to v6:
  https://lore.kernel.org/lkml/20250408033206.12176-1-friday.yang@mediatek.com/

Changes in v5:
- Use 'devm_pm_runtime_enable' instead of 'pm_runtime_enable'.
- Remove 'pm_runtime_disable' in 'mtk_smi_common_remove' and
  'mtk_smi_larb_remove'.
- Link to v5:
  https://lore.kernel.org/lkml/20250311122327.20685-1-friday.yang@mediatek.com/

Changes in v4:
- Use 'devm_reset_control_get_optional_exclusive' instead of
  'devm_reset_control_get'.
- Link to v4:
  https://lore.kernel.org/lkml/20250221074846.14105-1-friday.yang@mediatek.com/

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
- Link to v3:
  https://lore.kernel.org/lkml/20250121064934.13482-1-friday.yang@mediatek.com/

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
- Link to v2:
  https://lore.kernel.org/lkml/20241120063701.8194-1-friday.yang@mediatek.com/

Friday Yang (2):
  dt-bindings: memory: mediatek: Add SMI reset and clamp for MT8188
  memory: mtk-smi: mt8188: Add SMI reset and clamp

 .../mediatek,smi-common.yaml                  |   2 +
 .../memory-controllers/mediatek,smi-larb.yaml |  19 +++
 drivers/memory/mtk-smi.c                      | 151 ++++++++++++++++++
 3 files changed, 172 insertions(+)

--
2.46.0


