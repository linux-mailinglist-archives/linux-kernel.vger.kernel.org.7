Return-Path: <linux-kernel+bounces-892296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0752C44CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995F33AF5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213A233707;
	Mon, 10 Nov 2025 02:45:21 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F244369A;
	Mon, 10 Nov 2025 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762742721; cv=none; b=iMWb08DOMHUR6r86/Mm3YhQbZAuzjCfZzbkeOCkbmD9Fm2YRwAnzMX1XfqY6QBoR5YAQDbrsQMJpG09+0syhLgYdG7Trd7heHs3GFFBae0aEsQSJ8ckgVlF45pLoDgQMtD38PzzKlBQQP3LeHcnv2/duZrlVkugjXFePkC8Y0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762742721; c=relaxed/simple;
	bh=y4WfvXv5b4L717iLbIXBeiLiyCL2YGQGylM54A2grs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMISbDDEQmoJOsUrHVa0gQdS4AkIwjD6bus+IB67DajyT895k4ddc2PUBu1K7hops4jmRVakFGmY0U2TuihIKbkNq5WMwtEzO+h37aRWHrS3KkcCX9bnbwv1nxPde+AqQTZeILONWYkc+TZom2s6msoRTIFro9rAY/dpn9f4yuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006493LT.eswin.cn (unknown [10.127.112.153])
	by app1 (Coremail) with SMTP id TAJkCgC3sGivURFptWZuAA--.10678S4;
	Mon, 10 Nov 2025 10:45:05 +0800 (CST)
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
Subject: [PATCH v7 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Date: Mon, 10 Nov 2025 10:45:00 +0800
Message-ID: <20251110024500.104-1-caohang@eswincomputing.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20251110024339.73-1-caohang@eswincomputing.com>
References: <20251110024339.73-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgC3sGivURFptWZuAA--.10678S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy8Xw1UXFW5XFWrtr15XFb_yoWrtry7pa
	1q9a4YkrZ5GFs3Ka9ay3WkAF13KrsrCry5tryxC3Z2qr1Dt34UGFyvg3WFqF95GryxXry5
	Ga1kKFy8uF47X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The EIC7700 instantiates two USB 3.0 DWC3 IPs, each of which is backward
compatible with USB interfaces. It supports Super-speed (5Gb/s), DRD mode,
and compatible with xHCI 1.1, etc. Each of instances supports 16 endpoints
in device's mode and max 64 devices in host's mode.

This module needs to interact with the NOC via the AXI master bus, thus
requiring some HSP configuration operations to achieve this. Ops include
bus filter, pm signal or status to usb bus and so on.

Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Signed-off-by: Hang Cao <caohang@eswincomputing.com>
---
 drivers/usb/dwc3/dwc3-generic-plat.c | 71 +++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index e869c7de7bc8..704cd1c490ea 100644
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
@@ -20,6 +28,11 @@ struct dwc3_generic {
 	struct reset_control	*resets;
 };
 
+struct dwc3_generic_config {
+	int (*init)(struct dwc3_generic *dwc3g);
+	struct dwc3_properties properties;
+};
+
 #define to_dwc3_generic(d) container_of((d), struct dwc3_generic, dwc)
 
 static void dwc3_generic_reset_control_assert(void *data)
@@ -27,9 +40,38 @@ static void dwc3_generic_reset_control_assert(void *data)
 	reset_control_assert(data);
 }
 
+static int dwc3_eic7700_init(struct dwc3_generic *dwc3g)
+{
+	struct device *dev = dwc3g->dev;
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
-	const struct dwc3_properties *properties;
+	const struct dwc3_generic_config *plat_config;
 	struct dwc3_probe_data probe_data = {};
 	struct device *dev = &pdev->dev;
 	struct dwc3_generic *dwc3g;
@@ -77,12 +119,21 @@ static int dwc3_generic_probe(struct platform_device *pdev)
 	probe_data.res = res;
 	probe_data.ignore_clocks_and_resets = true;
 
-	properties = of_device_get_match_data(dev);
-	if (properties)
-		probe_data.properties = *properties;
-	else
+	plat_config = of_device_get_match_data(dev);
+	if (!plat_config) {
 		probe_data.properties = DWC3_DEFAULT_PROPERTIES;
+		goto core_probe;
+	}
 
+	probe_data.properties = plat_config->properties;
+	if (plat_config->init) {
+		ret = plat_config->init(dwc3g);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to init
+					     platform\n");
+	}
+
+core_probe:
 	ret = dwc3_core_probe(&probe_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register DWC3 Core\n");
@@ -150,13 +201,19 @@ static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
 		       dwc3_generic_runtime_idle)
 };
 
-static const struct dwc3_properties fsl_ls1028_dwc3 = {
-	.gsbuscfg0_reqinfo = 0x2222,
+static const struct dwc3_generic_config fsl_ls1028_dwc3 = {
+	.properties.gsbuscfg0_reqinfo = 0x2222,
+};
+
+static const struct dwc3_generic_config eic7700_dwc3 =  {
+	.init = dwc3_eic7700_init,
+	.properties = DWC3_DEFAULT_PROPERTIES,
 };
 
 static const struct of_device_id dwc3_generic_of_match[] = {
 	{ .compatible = "spacemit,k1-dwc3", },
 	{ .compatible = "fsl,ls1028a-dwc3", &fsl_ls1028_dwc3},
+	{ .compatible = "eswin,eic7700-dwc3", &eic7700_dwc3},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);
-- 
2.34.1


