Return-Path: <linux-kernel+bounces-717265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD864AF920B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 14:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DD31C8739E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 12:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682762D63E1;
	Fri,  4 Jul 2025 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eeRrU6Ee"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BDE2D6603
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751630545; cv=none; b=qF2BVIe921zehIA4Bcv5jwmIy7bXb4so+Zqcc1hR3lnE7QWJxLG0z9DesrhKnVScQqikoIF1jzGKBIaVzOZFx6UBvWoe7Nx5e4e9yLZBw41bmt4xl4mAvvwax660FtkFrec58mxoEJR9srSZtRkeDpwvDElT74tGuulHXfat6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751630545; c=relaxed/simple;
	bh=vdcWZxEt5GgmZ/qNCfGYjG62TVEeA9ZeTeIBWLZxMd8=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=qmuNdK4Fyq6hsEGgc6ykwEy2RY2qTCLJNIPmQy3pgoLCeh0+aGIylSpn4eSSrDl/i3uX1D9akuwaKnvhkFyUu/iwU1EeJpyCv+Jg5GL9S9EZZhhJ4Ua4QiUAS13oqPVUbpjqtY8ItrklowQHvHsWNsxu1P6YAs6XSUXeXdBeT6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eeRrU6Ee; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250704120217euoutp026b1ce68a50b2fc1679a8214c31e9a084~PCrGBR4n31041010410euoutp02c
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 12:02:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250704120217euoutp026b1ce68a50b2fc1679a8214c31e9a084~PCrGBR4n31041010410euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751630537;
	bh=tGc9y4qS8y5wRZhv2AKAuqTuYZtBk95xYshUQ8iiGHU=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=eeRrU6EeosK1xMCxvVbd2Wl9gHFSuHpTlKnnZK3b/WU+TZcWrbn59t7VZD0R5k3Hw
	 qWf1H2NQrR7LnPCkf+tSzHOGeWuOHfMKdK2aJTKG3/TOyobjkyGSzuDYrEgf5NiCEh
	 E7b3aoMMwV1tSakozgKS7EFcW9VDd0KOTpbPbRrE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250704120216eucas1p24df9ce8c9f74315b265ad8117491aa1e~PCrFa11jz3068930689eucas1p23;
	Fri,  4 Jul 2025 12:02:16 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250704120215eusmtip1d95ca58543424a705d0ac6e3cd929f91~PCrD8hfWq0550905509eusmtip1i;
	Fri,  4 Jul 2025 12:02:15 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 04 Jul 2025 14:01:15 +0200
Subject: [PATCH v8 5/7] dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rust-next-pwm-working-fan-for-sending-v8-5-951e5482c9fd@samsung.com>
In-Reply-To: <20250704-rust-next-pwm-working-fan-for-sending-v8-0-951e5482c9fd@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,  Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Marek Szyprowski
	<m.szyprowski@samsung.com>,  Benno Lossin <lossin@kernel.org>,  Michael
	Turquette <mturquette@baylibre.com>,  Drew Fustini <fustini@kernel.org>,
	Benno Lossin <lossin@kernel.org>,  Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org,  Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250704120216eucas1p24df9ce8c9f74315b265ad8117491aa1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250704120216eucas1p24df9ce8c9f74315b265ad8117491aa1e
X-EPHeader: CA
X-CMS-RootMailID: 20250704120216eucas1p24df9ce8c9f74315b265ad8117491aa1e
References: <20250704-rust-next-pwm-working-fan-for-sending-v8-0-951e5482c9fd@samsung.com>
	<CGME20250704120216eucas1p24df9ce8c9f74315b265ad8117491aa1e@eucas1p2.samsung.com>

Add the Device Tree binding documentation for the T-HEAD
TH1520 SoC PWM controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Drew Fustini <fustini@kernel.org>
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
index 2449178a6d7b83b5202f8209c0b38e8302bc6b15..b58853a503875f16a338274eba080f31c3442f9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21522,6 +21522,7 @@ F:	Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
 F:	Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c

-- 
2.34.1


