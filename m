Return-Path: <linux-kernel+bounces-690337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A27ADCF60
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 16:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666B7188F9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CF82ED164;
	Tue, 17 Jun 2025 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jqbg0K/Z"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95652EA466
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169328; cv=none; b=Gq0MK0NJKLGgXKwm8CnouNgCmFG0mRs4BcWDEt72g09VWeoK/YRv5cN8x83lr7TJhC/C1nLfpmjgBScObGvXGDQLI49S21VT1lVECtDWPHC5yn1/y64f6daHWgIZoJ/nJMCI2twxSoRgrLRWZvmOHSm7e30WPvMKBpiIa0zVXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169328; c=relaxed/simple;
	bh=j0ilmlWvuGDdPVedpFQAMvM2nuPCAwx7uovcp5sfOBM=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=GmrmbYK5LYgsb6OL0PWhB/7NR1B9mh1svwwUFKoy7CW3Fe2jl3D43Y5Ffej3gASBZPyRpmyjEd9cSbAWX+jFBUnMaL/SNeyd1UKzRI1iZzevjId9N5pLuAv0vOzpcercYWgwufoOQq+POBql9qvlVLbwRLXao9JS0jC8gda8Kcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jqbg0K/Z; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250617140843euoutp02d5ea17fee8203a5f2fddda98a3898e09~J2boKiKYW0211802118euoutp02H
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 14:08:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250617140843euoutp02d5ea17fee8203a5f2fddda98a3898e09~J2boKiKYW0211802118euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750169323;
	bh=fxnoWq4OQxd1ZCOVWNMF+siSVgYpXr1G0SglMgA6Kss=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=jqbg0K/ZQgslWuBeBWCR/VYQEK+++Ml5utZGEgM3/BhZW45n9qiQE85Nod8AQB0Bl
	 oaJw6mDyarlqjTtOX7pXpVjA0V4KujzRD0YDaJBkB+cyseio57n4xQrc5OU56/iBIR
	 1b/d1MmSoVEAK8YGs1Y+Qi4EvDA90+ZSzvt4f9ME=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250617140842eucas1p22777d6dfc4881099161ecf9404d909b2~J2bnYZ7001709617096eucas1p2n;
	Tue, 17 Jun 2025 14:08:42 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250617140840eusmtip108f1c6553ca05a2d32cba322f7a4b807~J2bmCsuDM2238622386eusmtip1E;
	Tue, 17 Jun 2025 14:08:40 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 17 Jun 2025 16:07:29 +0200
Subject: [PATCH v3 6/9] dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-rust-next-pwm-working-fan-for-sending-v3-6-1cca847c6f9f@samsung.com>
In-Reply-To: <20250617-rust-next-pwm-working-fan-for-sending-v3-0-1cca847c6f9f@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,  Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>,  Guo
	Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
	<conor+dt@kernel.org>,  Paul Walmsley <paul.walmsley@sifive.com>,  Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,  Alexandre
	Ghiti <alex@ghiti.fr>,  Marek Szyprowski <m.szyprowski@samsung.com>,  Benno
	Lossin <lossin@kernel.org>,  Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,  Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250617140842eucas1p22777d6dfc4881099161ecf9404d909b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250617140842eucas1p22777d6dfc4881099161ecf9404d909b2
X-EPHeader: CA
X-CMS-RootMailID: 20250617140842eucas1p22777d6dfc4881099161ecf9404d909b2
References: <20250617-rust-next-pwm-working-fan-for-sending-v3-0-1cca847c6f9f@samsung.com>
	<CGME20250617140842eucas1p22777d6dfc4881099161ecf9404d909b2@eucas1p2.samsung.com>

Add the Device Tree binding documentation for the T-HEAD
TH1520 SoC PWM controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../devicetree/bindings/pwm/thead,th1520-pwm.yaml  | 48 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml b/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..855aec59ac53c430adc849271235686e87b10e6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/thead,th1520-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 PWM controller
+
+maintainers:
+  - Michal Wilczynski <m.wilczynski@samsung.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: thead,th1520-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC PWM clock
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      pwm@ffec01c000 {
+          compatible = "thead,th1520-pwm";
+          reg = <0xff 0xec01c000 0x0 0x4000>;
+          clocks = <&clk CLK_PWM>;
+          #pwm-cells = <3>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 879870471e86dcec4a0e8f5c45d2cc3409411fdd..8a55e8d88394a269aa152e80a03c439a36e6062e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21394,6 +21394,7 @@ F:	Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
 F:	Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c

-- 
2.34.1


