Return-Path: <linux-kernel+bounces-691795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D31ADE8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8210D17693D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7E42C08A2;
	Wed, 18 Jun 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MGmjqVSP"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD729ACEA
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242154; cv=none; b=m18hHj6NGsPvQdcN73ReFA7DlQtazRQXrmYRCszj/eQ0CrWed3OlMc28zg+FDfs68VxVd0piLtnH/x/Ky1kvsjtjk1yFywvZ7/OEtSlnREqH6KCoS+cl2vWrj97Ap83o7hpcVk0tAE/b7iY0mM3YVZjQjBqnSbAymXWqgD5eVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242154; c=relaxed/simple;
	bh=OlOKEb1016tChtzQe/1JM0xl1h+O48eXY4P93Z5L2TY=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=h2UVYM7GeaaTZrPpVQ83Ae5Sse5YDcVtdTPtmO52w8yngWBWlWMuPcGYvzWDFqRaswt0dt+SccAozUoWk4lNn9tLxfmO4LnpgkXzCMWegx1yzBU9+mA70NlRctLieP/mt8Hc4XZX8ZQlCBovTKRhH20aSl1lYKgai3FAYlx8O4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MGmjqVSP; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250618102229euoutp02408d329c4cb0e63d599dfe381e2af76e~KG-Yb5DzM2423024230euoutp02g
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 10:22:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250618102229euoutp02408d329c4cb0e63d599dfe381e2af76e~KG-Yb5DzM2423024230euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750242149;
	bh=tFyef9Zk5foTthqWHu/oFmYdMYhqggHXZgBAaGBnWFU=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=MGmjqVSP4FIayvMOMwTgyV2A8OHTlORbdxEeX56KWV4ihe630Tjpq1LMgZxE2z6oD
	 eoR44u8VIwHSTdHmaWI1EPIPbt2kfDF/ZDjwDjcUbCDISbrk+hTKBm3PXPcgFk6S1p
	 u//DZJGksCAG52PKB0kHjkhyhXINMvcQxkdHCJvo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250618102228eucas1p1906803f73cc004e68f281b2bdf871da3~KG-X8Syqe1595015950eucas1p1U;
	Wed, 18 Jun 2025 10:22:28 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250618102227eusmtip11305416c6f5b7e92a8f4c4b15a74c1b9~KG-W_GGjU1000610006eusmtip1F;
	Wed, 18 Jun 2025 10:22:27 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 18 Jun 2025 12:22:09 +0200
Subject: [PATCH v5 3/8] pmdomain: thead: Instantiate GPU power sequencer via
 auxiliary bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-apr_14_for_sending-v5-3-27ed33ea5c6f@samsung.com>
In-Reply-To: <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>,  Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Frank Binns
	<frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,  Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250618102228eucas1p1906803f73cc004e68f281b2bdf871da3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250618102228eucas1p1906803f73cc004e68f281b2bdf871da3
X-EPHeader: CA
X-CMS-RootMailID: 20250618102228eucas1p1906803f73cc004e68f281b2bdf871da3
References: <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com>
	<CGME20250618102228eucas1p1906803f73cc004e68f281b2bdf871da3@eucas1p1.samsung.com>

In order to support the complex power sequencing required by the TH1520
GPU, the AON power domain driver must be responsible for initiating the
corresponding sequencer driver. This functionality is specific to
platforms where the GPU power sequencing hardware is controlled by the
AON block.

Extend the AON power domain driver to check for the presence of the
"gpu-clkgen" reset in its own device tree node.

If the property is found, create and register a new auxiliary device.
This device acts as a proxy that allows the dedicated `pwrseq-thead-gpu`
auxiliary driver to bind and take control of the sequencing logic.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/pmdomain/thead/Kconfig             |  1 +
 drivers/pmdomain/thead/th1520-pm-domains.c | 51 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pmdomain/thead/Kconfig b/drivers/pmdomain/thead/Kconfig
index 7d52f8374b074167d508a80fd807929c53faef12..208828e0fa0dc91256bf808b905bea32bb84250d 100644
--- a/drivers/pmdomain/thead/Kconfig
+++ b/drivers/pmdomain/thead/Kconfig
@@ -4,6 +4,7 @@ config TH1520_PM_DOMAINS
 	tristate "Support TH1520 Power Domains"
 	depends on TH1520_AON_PROTOCOL
 	select REGMAP_MMIO
+	select AUXILIARY_BUS
 	help
 	  This driver enables power domain management for the T-HEAD
 	  TH-1520 SoC. On this SoC there are number of power domains,
diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
index f702e20306f469aeb0ed15e54bd4f8309f28018c..9040b698e7f7f2400163841530fecacfb0f917bc 100644
--- a/drivers/pmdomain/thead/th1520-pm-domains.c
+++ b/drivers/pmdomain/thead/th1520-pm-domains.c
@@ -5,6 +5,7 @@
  * Author: Michal Wilczynski <m.wilczynski@samsung.com>
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/firmware/thead/thead,th1520-aon.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -128,6 +129,50 @@ static void th1520_pd_init_all_off(struct generic_pm_domain **domains,
 	}
 }
 
+static void th1520_pd_pwrseq_unregister_adev(void *adev)
+{
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int th1520_pd_pwrseq_gpu_init(struct device *dev)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	/*
+	 * Correctly check only for the property's existence in the DT node.
+	 * We don't need to get/claim the reset here; that is the job of
+	 * the auxiliary driver that we are about to spawn.
+	 */
+	if (device_property_match_string(dev, "reset-names", "gpu-clkgen") < 0)
+		/*
+		 * This is not an error. It simply means the optional sequencer
+		 * is not described in the device tree.
+		 */
+		return 0;
+
+	adev = devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->name = "pwrseq-gpu";
+	adev->dev.parent = dev;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, th1520_pd_pwrseq_unregister_adev,
+					adev);
+}
+
 static int th1520_pd_probe(struct platform_device *pdev)
 {
 	struct generic_pm_domain **domains;
@@ -186,8 +231,14 @@ static int th1520_pd_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clean_genpd;
 
+	ret = th1520_pd_pwrseq_gpu_init(dev);
+	if (ret)
+		goto err_clean_provider;
+
 	return 0;
 
+err_clean_provider:
+	of_genpd_del_provider(dev->of_node);
 err_clean_genpd:
 	for (i--; i >= 0; i--)
 		pm_genpd_remove(domains[i]);

-- 
2.34.1


