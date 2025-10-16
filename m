Return-Path: <linux-kernel+bounces-855853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF01BE27E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 138844F0A13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571A12D73B6;
	Thu, 16 Oct 2025 09:48:33 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD9D23A564;
	Thu, 16 Oct 2025 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608112; cv=none; b=V3UEBVMqkzfV6qBTpIskaUse8YJzeLBocKn2r9BOuvdf3DddoA2jWclW1mU6PmSIexPCkqVmy76xjdKdAc9iHZOEQwmkQ8TMKGC+eX4PVwRNsZNrpTLY/ux/aA+Q0CN626gjqGKWHBAJwjuuPP/LQbnJ1I+FIkmnwFUNuuVzuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608112; c=relaxed/simple;
	bh=RA34cpqVuqj2vO2KVbsTQXHKHww4Zz+7bA7fQuzFXA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9+KmABrp+5yHd2DrjOK/v7tW2kftXvjOjnLCgIknmcagRS5F5tXG0t1RavjzHaXOkjGPrnyikETBrzA36eBgWZG8FDb75AA6Y3t3187zChyITd+NMeMRzY/jvj1E9WRFFQY4pbH4E1EKPPvNo+yubjqWeOynF3UOTox3igT/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006493LT.eswin.cn (unknown [10.127.112.153])
	by app2 (Coremail) with SMTP id TQJkCgBX9pRfv_BoRBIOAQ--.48733S4;
	Thu, 16 Oct 2025 17:48:17 +0800 (CST)
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
Subject: [PATCH] usb: dwc3: eic7700: Add EIC7700 USB driver
Date: Thu, 16 Oct 2025 17:48:12 +0800
Message-ID: <20251016094812.739-1-caohang@eswincomputing.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20251016094654.708-1-caohang@eswincomputing.com>
References: <20251016094654.708-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBX9pRfv_BoRBIOAQ--.48733S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrZr47XF4fZw4rXFyrWFg_yoWrXry5pa
	ykuFyYkrs5Grs3Kws3t3Z5AF1agrs7C3yUtryIk3Z2vr1qq34UGFykWr1rXasYkryxXF15
	tr4ktFyxuF47Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 drivers/usb/dwc3/dwc3-generic-plat.c | 58 ++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index d96b20570002..98448bc434a5 100644
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
@@ -20,8 +28,41 @@ struct dwc3_generic {
 	struct reset_control	*resets;
 };
 
+struct dwc3_generic_match_data {
+	int (*init_ops)(struct device *dev);
+};
+
 #define to_dwc3_generic(d) container_of((d), struct dwc3_generic, dwc)
 
+static int eic7700_dwc3_bus_init(struct device *dev)
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
+
+	return 0;
+}
+
 static void dwc3_generic_reset_control_assert(void *data)
 {
 	reset_control_assert(data);
@@ -29,6 +70,7 @@ static void dwc3_generic_reset_control_assert(void *data)
 
 static int dwc3_generic_probe(struct platform_device *pdev)
 {
+	const struct dwc3_generic_match_data *data;
 	struct dwc3_probe_data probe_data = {};
 	struct device *dev = &pdev->dev;
 	struct dwc3_generic *dwc3g;
@@ -75,6 +117,14 @@ static int dwc3_generic_probe(struct platform_device *pdev)
 	probe_data.dwc = &dwc3g->dwc;
 	probe_data.res = res;
 	probe_data.ignore_clocks_and_resets = true;
+
+	data = of_device_get_match_data(dev);
+	if (data && data->init_ops) {
+		ret = data->init_ops(dev);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "failed to init ops\n");
+	}
+
 	ret = dwc3_core_probe(&probe_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register DWC3 Core\n");
@@ -139,6 +189,10 @@ static int dwc3_generic_runtime_idle(struct device *dev)
 	return dwc3_runtime_idle(dev_get_drvdata(dev));
 }
 
+static const struct dwc3_generic_match_data eic7700_dwc3_data = {
+	.init_ops = eic7700_dwc3_bus_init,
+};
+
 static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(dwc3_generic_suspend, dwc3_generic_resume)
 	RUNTIME_PM_OPS(dwc3_generic_runtime_suspend, dwc3_generic_runtime_resume,
@@ -147,6 +201,10 @@ static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
 
 static const struct of_device_id dwc3_generic_of_match[] = {
 	{ .compatible = "spacemit,k1-dwc3", },
+	{
+		.compatible = "eswin,eic7700-dwc3",
+		.data = &eic7700_dwc3_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);
-- 
2.34.1


