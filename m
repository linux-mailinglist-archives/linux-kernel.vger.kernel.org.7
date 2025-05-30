Return-Path: <linux-kernel+bounces-667355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C686AC8435
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A7F16C0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 22:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1C21FF3C;
	Thu, 29 May 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PdlwNPOP"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997F21D5A4
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557455; cv=none; b=LYrGgjXjZDkwpvXMQIX6Wvi4T/bD6L2MbgaSeV8IH9HCX4A80ib4Yp1ltT7PGRfV0oxub0OJ2eD5iQ4Xr3hvWZHI8JXqF1nPvevzoVRiJ523xGxn4/Mu+BWNfKk9v6+uIkDnwpWr3IZrS4wRlXFp045ai6MPz0NKCmDrskV1Ne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557455; c=relaxed/simple;
	bh=LKLrrWq8thhk1EMk6yfw2Nl2anZxcSL9JmtArSpirfg=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=aDOIYviCIK4Y7uaAJU3vmaJZBgq9yAI/mLxqq/cLe9Qu34bWKjwbvwNxTE7tLgAS6Q4SDMVs/7riWuzvz+Ej9POHLoPG1E1+bRh44DraiVLTbFQTDYO+qWKCV85NGsLXS/ysEbzoaELNv2vQKQbDx3wdB/gOqcvojt55c7aL91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PdlwNPOP; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250529222405euoutp01c9d0ae2b8090cd345003ce75ec93457a~EH7uJLt5N2316223162euoutp01s
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 22:24:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250529222405euoutp01c9d0ae2b8090cd345003ce75ec93457a~EH7uJLt5N2316223162euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748557445;
	bh=YWgZEAPcMH46NIGH2/oSKhwnvWs2dOgmME8UVmfVxfk=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=PdlwNPOP7Bq6mAnKXwUUKOtMzeH42uNn7zWl+n5xLfLi4AmEtVSivsrBSDR/3kAhM
	 wPFrUy503C1TVlyEuXqJo/BRIgCHm1/2YKxlRUOQZCbGwPP0QsecSm0y7i1Yh2DE0p
	 JJuXDfCPTdFS49H/jNLU1o7vwoAnJHKiRfzaaqA8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250529222403eucas1p1923fe09240be34e3bbadf16822574d75~EH7sXLUlv2958729587eucas1p1j;
	Thu, 29 May 2025 22:24:03 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222402eusmtip2d7d50774a6c6e15081addf3fce030b9c~EH7reGp5Y3031530315eusmtip2K;
	Thu, 29 May 2025 22:24:02 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 30 May 2025 00:23:48 +0200
Subject: [PATCH v3 1/8] dt-bindings: power: Add T-HEAD TH1520 GPU power
 sequencer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-apr_14_for_sending-v3-1-83d5744d997c@samsung.com>
In-Reply-To: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
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
X-CMS-MailID: 20250529222403eucas1p1923fe09240be34e3bbadf16822574d75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222403eucas1p1923fe09240be34e3bbadf16822574d75
X-EPHeader: CA
X-CMS-RootMailID: 20250529222403eucas1p1923fe09240be34e3bbadf16822574d75
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222403eucas1p1923fe09240be34e3bbadf16822574d75@eucas1p1.samsung.com>

Introduce device tree bindings for a new power sequencer provider
dedicated to the T-HEAD TH1520 SoC's GPU.

The thead,th1520-gpu-pwrseq compatible designates a node that will
manage the complex power-up and power-down sequence for the GPU. This
sequencer requires a handle to the GPU's clock generator reset line
(gpu-clkgen), which is specified in its device tree node.

This binding will be used by a new pwrseq driver to abstract the
SoC specific power management details from the generic GPU driver.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/power/thead,th1520-pwrseq.yaml        | 42 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/thead,th1520-pwrseq.yaml b/Documentation/devicetree/bindings/power/thead,th1520-pwrseq.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..4c302abfb76fb9e243946f4eefa333c6b02e59d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/thead,th1520-pwrseq.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/thead,th1520-pwrseq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 GPU Power Sequencer
+
+maintainers:
+  - Michal Wilczynski <m.wilczynski@samsung.com>
+
+description: |
+  This binding describes the power sequencer for the T-HEAD TH1520 GPU.
+  This sequencer handles the specific power-up and power-down sequences
+  required by the GPU, including managing clocks and resets from both the
+  sequencer and the GPU device itself.
+
+properties:
+  compatible:
+    const: thead,th1520-gpu-pwrseq
+
+  resets:
+    description: A phandle to the GPU clock generator reset.
+    maxItems: 1
+
+  reset-names:
+    const: gpu-clkgen
+
+required:
+  - compatible
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    gpu_pwrseq: pwrseq {
+        compatible = "thead,th1520-gpu-pwrseq";
+        resets = <&rst 0>;
+        reset-names = "gpu-clkgen";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0d59a5910e632350a4d72a761c6c5ce1d3a1bc34..78e3067df1152929de638244b03264733d08556e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21355,6 +21355,7 @@ F:	Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
+F:	Documentation/devicetree/bindings/power/thead,th1520-pwrseq.yaml
 F:	Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c

-- 
2.34.1


