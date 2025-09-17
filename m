Return-Path: <linux-kernel+bounces-820606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48580B7CB35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C151BC14F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5EF30CB29;
	Wed, 17 Sep 2025 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qM0/0PqL"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604837428E;
	Wed, 17 Sep 2025 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110859; cv=none; b=OmkawToGMKa5i1U3yWtWG5tuWouMesaNa0+6j+EGDlJ86W0LLioar0Hk/8sJvyCjbXu3PvgUNseG4aX7EJ89IPzRUS2i8y+v1KevByMKnM9XTP9vs+TZFlb/DLJqtFh7w5RGrFB5E5blSXXVCn2y6kupOiVBEQ9ipLPdBg5ZZ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110859; c=relaxed/simple;
	bh=5ig2eU5Fg0cCn3yPw6Y//iD8ou9gBDzeU/No0OLigJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHGY62XOJBqN7wezS389NIL1Bdrie+F5rQcqn4A1tk/IQMRML39+yQu8U4OWCSTQA3pu0aCsQI5AWER9hhbLBbizcnNlaagD6dZakSWipts5cfIkiwmcw/E2jX9E3JFWi/Ocx+F6v+J9TMNjEFoqMVr/HThyaaC/sHfABF+eV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qM0/0PqL; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e34f538093be11f0b33aeb1e7f16c2b6-20250917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4rWzUh3OtAgbptX2XM346gfFjl3YVUXZFKF3qDFzE+Y=;
	b=qM0/0PqLReVY+QIuAvqyeNw9B5gcqKb8QLvbKTyID/D1yaQvULRRHWuEqZmQEwpHED5eKIoONa8Z5wG217NyweCGXLwN3CS3Vc9j2Oz1nY8utdmmlQMOH7WVOBb6T3JDs/sKzMIzbID96KHPkYu0cBCKzDP6k4SkN4OPFUXdQKk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:f15a3503-3892-4440-88a6-ad4a09d0e4c3,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:f4e16ba9-24df-464e-9c88-e53ab7cf7153,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836,TC:-5,Content:0|15|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e34f538093be11f0b33aeb1e7f16c2b6-20250917
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1576178336; Wed, 17 Sep 2025 20:07:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 17 Sep 2025 20:07:29 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 17 Sep 2025 20:07:29 +0800
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
Subject: [PATCH v11 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
Date: Wed, 17 Sep 2025 20:07:17 +0800
Message-ID: <20250917120724.8650-3-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250917120724.8650-1-friday.yang@mediatek.com>
References: <20250917120724.8650-1-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

To prevent handling glitch signals during MTCMOS on/off transitions,
SMI requires clamp and reset operations. Parse the reset settings for
SMI LARBs and the clamp settings for the SMI Sub-Common. Register
genpd callback for the SMI LARBs located in image, camera and IPE
subsystems, and apply reset and clamp operations within the callback.

Signed-off-by: Friday Yang <friday.yang@mediatek.com>
---
 drivers/memory/mtk-smi.c | 151 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 733e22f695ab..117ff528db01 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -10,11 +10,15 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/soc/mediatek/mtk_sip_svc.h>
 #include <soc/mediatek/smi.h>
 #include <dt-bindings/memory/mt2701-larb-port.h>
@@ -34,6 +38,8 @@
 #define SMI_FIFO_TH1			0x238
 #define SMI_FIFO_TH2			0x23c
 #define SMI_DCM				0x300
+#define SMI_COMMON_CLAMP_EN_SET		0x3c4
+#define SMI_COMMON_CLAMP_EN_CLR		0x3c8
 #define SMI_DUMMY			0x444

 /* SMI LARB */
@@ -134,6 +140,7 @@ struct mtk_smi_larb_gen {
 	unsigned int			larb_direct_to_common_mask;
 	unsigned int			flags_general;
 	const u8			(*ostd)[SMI_LARB_PORT_NR_MAX];
+	const u8			*clamp_port;
 };

 struct mtk_smi {
@@ -150,6 +157,7 @@ struct mtk_smi {
 };

 struct mtk_smi_larb { /* larb: local arbiter */
+	struct device			*dev;
 	struct mtk_smi			smi;
 	void __iomem			*base;
 	struct device			*smi_common_dev; /* common or sub-common dev */
@@ -157,6 +165,10 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	int				larbid;
 	u32				*mmu;
 	unsigned char			*bank;
+	struct regmap			*smi_comm_syscon; /* smi-comm or sub-comm */
+	u8				smi_comm_in_port_id; /* smi-comm or sub-comm */
+	struct notifier_block		nb;
+	struct reset_control		*rst_con;
 };

 static int
@@ -478,6 +490,19 @@ static const u8 mtk_smi_larb_mt8195_ostd[][SMI_LARB_PORT_NR_MAX] = {
 	[28] = {0x1a, 0x0e, 0x0a, 0x0a, 0x0c, 0x0e, 0x10,},
 };

+static const u8 mtk_smi_larb_clamp_port_mt8188[MTK_LARB_NR_MAX] = {
+	[9]	= BIT(1), /* larb10 */
+	[10]	= BIT(2), /* larb11a */
+	[11]	= BIT(2), /* larb11b */
+	[12]	= BIT(3), /* larb11c */
+	[13]	= BIT(0), /* larb12 */
+	[16]	= BIT(1), /* larb15 */
+	[17]	= BIT(2), /* larb16a */
+	[18]	= BIT(2), /* larb16b */
+	[19]	= BIT(3), /* larb17a */
+	[20]	= BIT(3), /* larb17b */
+};
+
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
 	.port_in_larb = {
 		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
@@ -531,6 +556,7 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8188 = {
 	.flags_general	            = MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_SW_FLAG |
 				      MTK_SMI_FLAG_SLEEP_CTL | MTK_SMI_FLAG_CFG_PORT_SEC_CTL,
 	.ostd		            = mtk_smi_larb_mt8188_ostd,
+	.clamp_port                 = mtk_smi_larb_clamp_port_mt8188,
 };

 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
@@ -582,6 +608,53 @@ static void mtk_smi_larb_sleep_ctrl_disable(struct mtk_smi_larb *larb)
 	writel_relaxed(0, larb->base + SMI_LARB_SLP_CON);
 }

+static int mtk_smi_larb_clamp_protect_enable(struct device *dev, bool enable)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	u32 reg;
+	int ret;
+
+	reg = enable ? SMI_COMMON_CLAMP_EN_SET : SMI_COMMON_CLAMP_EN_CLR;
+	ret = regmap_write(larb->smi_comm_syscon, reg, larb->smi_comm_in_port_id);
+	if (ret)
+		dev_err(dev, "Unable to %s clamp for input port %d: %d\n",
+			enable ? "enable" : "disable",
+			larb->smi_comm_in_port_id, ret);
+
+	return ret;
+}
+
+static int mtk_smi_genpd_callback(struct notifier_block *nb,
+				  unsigned long event, void *data)
+{
+	struct mtk_smi_larb *larb = container_of(nb, struct mtk_smi_larb, nb);
+	struct device *dev = larb->dev;
+	int ret = 0;
+
+	switch (event) {
+	case GENPD_NOTIFY_PRE_ON:
+	case GENPD_NOTIFY_PRE_OFF:
+		/* Clamp this larb to avoid the redundant commands */
+		ret = mtk_smi_larb_clamp_protect_enable(dev, true);
+		break;
+	case GENPD_NOTIFY_ON:
+		ret = reset_control_reset(larb->rst_con);
+		if (ret) {
+			dev_err(dev, "Failed to reset smi larb %d\n", ret);
+			break;
+		}
+
+		ret = mtk_smi_larb_clamp_protect_enable(dev, false);
+		break;
+	default:
+		break;
+	}
+	if (ret)
+		return NOTIFY_BAD;
+
+	return NOTIFY_OK;
+}
+
 static int mtk_smi_device_link_common(struct device *dev, struct device **com_dev)
 {
 	struct platform_device *smi_com_pdev;
@@ -638,6 +711,46 @@ static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
 	return ret;
 }

+static int mtk_smi_larb_parse_syscon(struct mtk_smi_larb *larb, int larbid)
+{
+	struct device *dev = larb->dev;
+	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
+	int ret;
+
+	larb->smi_comm_in_port_id = larb_gen->clamp_port[larbid];
+	larb->smi_comm_syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
+								"mediatek,smi");
+	if (IS_ERR(larb->smi_comm_syscon)) {
+		ret = PTR_ERR(larb->smi_comm_syscon);
+		larb->smi_comm_syscon = NULL;
+		return dev_err_probe(dev, ret,
+				     "Failed to get smi syscon for larb %d\n", larbid);
+	}
+
+	return 0;
+}
+
+static int mtk_smi_larb_parse_reset(struct mtk_smi_larb *larb)
+{
+	struct device *dev = larb->dev;
+	int ret;
+
+	larb->rst_con = devm_reset_control_get_exclusive(dev, "larb");
+	if (IS_ERR(larb->rst_con))
+		return dev_err_probe(dev, PTR_ERR(larb->rst_con),
+				     "Failed to get reset controller\n");
+
+	larb->nb.notifier_call = mtk_smi_genpd_callback;
+	ret = dev_pm_genpd_add_notifier(dev, &larb->nb);
+	if (ret) {
+		larb->nb.notifier_call = NULL;
+		return dev_err_probe(dev, ret,
+				     "Failed to add genpd callback\n");
+	}
+
+	return 0;
+}
+
 static int mtk_smi_larb_probe(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb;
@@ -648,6 +761,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	if (!larb)
 		return -ENOMEM;

+	larb->dev = dev;
 	larb->larb_gen = of_device_get_match_data(dev);
 	larb->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(larb->base))
@@ -664,6 +778,30 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;

+	/* The larbid are sequential for IOMMU if this property is not present */
+	if (!of_property_present(dev->of_node, "mediatek,larb-id"))
+		goto pm_runtime_en;
+	ret = of_property_read_s32(dev->of_node, "mediatek,larb-id", &larb->larbid);
+	if (ret || larb->larbid >= MTK_LARB_NR_MAX) {
+		ret = -EINVAL;
+		goto err_link_remove;
+	}
+
+	/*
+	 * Only SMI LARBs in camera, image and IPE subsys need to
+	 * apply clamp and reset operations, others can be skipped.
+	 */
+	if (larb->larb_gen->clamp_port && larb->larb_gen->clamp_port[larb->larbid]) {
+		ret = mtk_smi_larb_parse_syscon(larb, larb->larbid);
+		if (ret)
+			goto err_link_remove;
+
+		ret = mtk_smi_larb_parse_reset(larb);
+		if (ret)
+			goto err_link_remove;
+	}
+
+pm_runtime_en:
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, larb);
 	ret = component_add(dev, &mtk_smi_larb_component_ops);
@@ -672,7 +810,11 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	return 0;

 err_pm_disable:
+	if (larb->nb.notifier_call)
+		dev_pm_genpd_remove_notifier(&pdev->dev);
+
 	pm_runtime_disable(dev);
+err_link_remove:
 	device_link_remove(dev, larb->smi_common_dev);
 	return ret;
 }
@@ -681,6 +823,9 @@ static void mtk_smi_larb_remove(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb = platform_get_drvdata(pdev);

+	if (larb->nb.notifier_call)
+		dev_pm_genpd_remove_notifier(&pdev->dev);
+
 	device_link_remove(&pdev->dev, larb->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
 	component_del(&pdev->dev, &mtk_smi_larb_component_ops);
@@ -803,6 +948,11 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8188_vpp = {
 	.init     = mtk_smi_common_mt8195_init,
 };

+static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8188 = {
+	.type     = MTK_SMI_GEN2_SUB_COMM,
+	.has_gals = true,
+};
+
 static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
 	.type     = MTK_SMI_GEN2,
 	.has_gals = true,
@@ -847,6 +997,7 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt8186-smi-common", .data = &mtk_smi_common_mt8186},
 	{.compatible = "mediatek,mt8188-smi-common-vdo", .data = &mtk_smi_common_mt8188_vdo},
 	{.compatible = "mediatek,mt8188-smi-common-vpp", .data = &mtk_smi_common_mt8188_vpp},
+	{.compatible = "mediatek,mt8188-smi-sub-common", .data = &mtk_smi_sub_common_mt8188},
 	{.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
 	{.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
 	{.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},
--
2.46.0


