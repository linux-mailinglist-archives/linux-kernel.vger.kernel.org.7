Return-Path: <linux-kernel+bounces-884174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B8C2F858
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB98518C0534
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB42E8B6C;
	Tue,  4 Nov 2025 06:52:59 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B428C854;
	Tue,  4 Nov 2025 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239179; cv=none; b=Zqwn4AkWJsuWMUYT7kfc8H3Yn9a0SjTrIVioQUmlJE69bQWbwLHEQJjgLUUFkWvqkt9c62hFL7oVa0Xf0EArWJnBL+AEA5v+w7OhvOBdnx7KC7DMszSiNoxNCgfwlu/Na6uKBqgyxSeeLgxEo000AbxX4xTLES5YKWY5ohgftl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239179; c=relaxed/simple;
	bh=hQ/ZtY9OF1joKZSrQToCv+8b9j7Rq8+/+XJFW0yXm9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvZe0dsiOs0FhvE3a4+KSyXPH0KVFPOFIx63f2pRhvhXGk+ZV4vqzPqNQsa/naFnySz7xuH8F1XpzY6NCm8FETTJls67ePwa+PYr0ydJggmexnX6uUCmypjw+T6wce4xuagGZx7oAkTL2JSP6W8BbgKrpn0Z7c7D7lWLGrh6Mi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006493LT.eswin.cn (unknown [10.127.112.153])
	by app2 (Coremail) with SMTP id TQJkCgAHSq25oglpeo4iAA--.58890S4;
	Tue, 04 Nov 2025 14:52:43 +0800 (CST)
From: caohang@eswincomputing.com
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Hang Cao <caohang@eswincomputing.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v5 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Date: Tue,  4 Nov 2025 14:52:26 +0800
Message-ID: <20251104065226.1513-1-caohang@eswincomputing.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20251104065045.1464-1-caohang@eswincomputing.com>
References: <20251104065045.1464-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAHSq25oglpeo4iAA--.58890S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrZr45Cw15ZF4xKw17ZFb_yoW5AFykpF
	4vkFyYkrZ5Gr4xKan3t3Z5AF1fKan7GryrtryxG3ZFvw1Dt34DGr18Wa4Fqr95GryfXFy5
	Jw4kJrWfCF47ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHCJQUUUUU=
X-CM-SenderInfo: xfdrxt1qj6v25zlqu0xpsx3x1qjou0bp/

From: Hang Cao <caohang@eswincomputing.com>

Add the eic7700 usb driver, which is responsible for
identifying,configuring and connecting usb devices.

Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Signed-off-by: Hang Cao <caohang@eswincomputing.com>
---
 drivers/usb/dwc3/dwc3-generic-plat.c | 43 ++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index 770fedc16bb8..89ad952a4a4c 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -10,8 +10,16 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 #include "glue.h"
 
+#define EIC7700_HSP_BUS_FILTER_EN	BIT(0)
+#define EIC7700_HSP_BUS_CLKEN_GM	BIT(9)
+#define EIC7700_HSP_BUS_CLKEN_GS	BIT(16)
+#define EIC7700_HSP_AXI_LP_XM_CSYSREQ	BIT(0)
+#define EIC7700_HSP_AXI_LP_XS_CSYSREQ	BIT(16)
+
 struct dwc3_generic {
 	struct device		*dev;
 	struct dwc3		dwc;
@@ -27,6 +35,34 @@ static void dwc3_generic_reset_control_assert(void *data)
 	reset_control_assert(data);
 }
 
+static int dwc3_eic7700_pre_init(struct device *dev)
+{
+	struct regmap *regmap;
+	u32 hsp_usb_axi_lp;
+	u32 hsp_usb_bus;
+	u32 args[2];
+	u32 val;
+
+	regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+						      "eswin,hsp-sp-csr",
+						      ARRAY_SIZE(args), args);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "No hsp-sp-csr phandle specified\n");
+		return PTR_ERR(regmap);
+	}
+
+	hsp_usb_bus       = args[0];
+	hsp_usb_axi_lp    = args[1];
+
+	regmap_read(regmap, hsp_usb_bus, &val);
+	regmap_write(regmap, hsp_usb_bus, val | EIC7700_HSP_BUS_FILTER_EN |
+		     EIC7700_HSP_BUS_CLKEN_GM | EIC7700_HSP_BUS_CLKEN_GS);
+
+	regmap_write(regmap, hsp_usb_axi_lp, EIC7700_HSP_AXI_LP_XM_CSYSREQ |
+		     EIC7700_HSP_AXI_LP_XS_CSYSREQ);
+	return 0;
+}
+
 static int dwc3_generic_probe(struct platform_device *pdev)
 {
 	const struct dwc3_properties *properties;
@@ -83,6 +119,12 @@ static int dwc3_generic_probe(struct platform_device *pdev)
 	else
 		probe_data.properties = DWC3_DEFAULT_PROPERTIES;
 
+	if (of_device_is_compatible(dev->of_node, "eswin,eic7700-dwc3")) {
+		ret = dwc3_eic7700_pre_init(dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "eic7700 init fail\n");
+	}
+
 	ret = dwc3_core_probe(&probe_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register DWC3 Core\n");
@@ -160,6 +202,7 @@ static const struct dwc3_properties fsl_ls1028_dwc3 = {
 static const struct of_device_id dwc3_generic_of_match[] = {
 	{ .compatible = "spacemit,k1-dwc3", },
 	{ .compatible = "fsl,ls1028a-dwc3", &fsl_ls1028_dwc3},
+	{ .compatible = "eswin,eic7700-dwc3",},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);
-- 
2.34.1


