Return-Path: <linux-kernel+bounces-755480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89885B1A6C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFD6188B980
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA322749C1;
	Mon,  4 Aug 2025 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiweZ2v5"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD871271A94;
	Mon,  4 Aug 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322920; cv=none; b=gMXWDkLGjRyE10JA2Yz/p/lVQsADuBq590upN+EnT3pD44fvGyqspVaajhmMNKRBQ0dk9QTiKsSmD8jQJ6mKqwBz/V8QeGmqVzZW/DTWPzevAUPN65F74nVIyuoXTbgKF8ccsP6XhGnnzfWT96bTdWgWGyU3sXk1qmsDsy4fw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322920; c=relaxed/simple;
	bh=UY6jthgCNIsr9tlTLUKjXHRvM6vQnmImDhByNLafsHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZWqUxWK8fCOoGKqGGAwd8N8Rtpu9wu0okouIorQf4SGLFK9Wpd0z1SW2KEgL/X9ovjkPWR1QIA9NjMM9sxigeFa3uiMLIVbfwZ4nig/TJv6Ny+BJhDmvCGqh7/HgaK68hckpPvUIf7vGTXeE7vH8a2BSEinz4wLTQPwVVmi/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiweZ2v5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af967835d0aso191004766b.0;
        Mon, 04 Aug 2025 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322917; x=1754927717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txCGfkTtBsBSyGuNpD8Xj+5OLa4IbnLzvuc16UnT9Y8=;
        b=BiweZ2v5+Jk2hkSzl5kUl5+tjtOwAY2XwAMB///rqesj/SdLwEiRCqKEE8HlwKIThx
         EQUyZSBU8JIaaL1ULLJEg1fvyxgiA28z+em3+TcrmVUXWu0SaNZP6SfBewet/uhhr2st
         2ISSUvcR8uQDtfN2I5I5sLL7+mQd6NhFMCuQqDwOGtJUdq6x223CiPsmvOfxvtCT6RCC
         UVKkKxrQB2O56aAqwzctGFUN8Z6NArPhJbnrEyxr4oetjL9eZE0rEBn7i1lyrS2li1B2
         P7KTMNwKnF6DyQWuT7BfONKy/RbUAMyEQfuUXxvqeema2fiMoc4GnrpkNNEX5Qheuwu5
         MJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322917; x=1754927717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txCGfkTtBsBSyGuNpD8Xj+5OLa4IbnLzvuc16UnT9Y8=;
        b=uf5rSpdgmV1f6CEm8HyQgffaCzaeFU4jRU7x8BAo3lG7Qhd1BbtN6/e7jvK9E8onz7
         V6LFx2xt2XBb5bbcnAtLazs7y2oXbyyDoTFf2gJKHGlUk2YRFvJNuNOR0oiyBFT6uho5
         e9G2evXkZp4R4T/wzcE1pMWOFJRFaIqPuDuRqRn34IwqpGMG1CIhyhjZ3NP9H6yEWUov
         WMfDpSOOaOaFjTX5HNX0HkG9Egx/KxfF2AIlNoa31C3WTb0Ig4QYnlUiEET3xqRXQGOV
         E9wpO4Ed4/9Ts0FMUrZqOevpCVLKhjs1t0ArEkOp1mb0/5DY7ookJY3T0xulJR8uIJQU
         Dk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHl4S0mYroI3/jjKs8QeQmxIPAMf1XHGEe4PFTDPnTUuvIoYKO9HKCuGGwIYfpF694Q6MGeO4nrHQC5ycf@vger.kernel.org, AJvYcCXcQbH3Hes71gpggGg3lmPDTF1c5WqeTcvJsJCbdf8LvOU0xDk/WS2855th/Z72E5cf6OSq/HFt+dyu@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0JMtcx7mmJw3e7Bzgf7b3A7fYGtDESD0ylL38SHz+MfvUBrK
	HRAKoKd1fggBaTfRzU2dvSqDxJRLwCpQc6JTGjWuIZOdkoVit2HLRMAx
X-Gm-Gg: ASbGnculr9tq11fA1ndeQgg7gJvF8NxfGxadshPxNK2PJZ623m6lgCPCieyTzPC+4lA
	CDQIwxJ+WapwI20SCMb616/e2l52TyCfy7EJU51oyApNhXQVVaIsC72KlHlwPofrtQmPNueCNe3
	TWuzWRhHN0BRVJvItH3HyNErL6Gz/oo3M7xOVrOqRftkYXkcnAM9y38K2sDbnO43FSzi8AaH3b8
	J2eZErdSw/MlyfO4uBivarV7A9KgmYxW/ImRrcjZJbGkKn3ZlzX5e7djmmfiUPGx4IRwpvlAqci
	QnIcLY3SvtaCtPc56XWW/eLTQmcAj1/lJ1l1B6Fa1EwC4MGrDHZTvUNdItPJQ1XlQ3ZwTkHIol5
	CmdMZcO4v/auZxWs8zI/nW39bfE11dNB5wRVm8z6JMikv/dWsWSBElArvucE=
X-Google-Smtp-Source: AGHT+IFE9fsToHPB1HzXL7CA2N5HVySncDZwT+zwwfREXgYG8O5U9/e+DlJl3UaSJhFPEZ4jMCwWYA==
X-Received: by 2002:a17:907:9721:b0:af9:3d0a:f392 with SMTP id a640c23a62f3a-af9400202f7mr1152845866b.15.1754322916887;
        Mon, 04 Aug 2025 08:55:16 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a075a74sm761114266b.17.2025.08.04.08.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:55:16 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 3/7] dt-bindings: clock: document 8ULP's SIM LPAV
Date: Mon,  4 Aug 2025 11:54:03 -0400
Message-Id: <20250804155407.285353-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add documentation for i.MX8ULP's SIM LPAV module.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/clock/fsl,imx8ulp-sim-lpav.yaml  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
new file mode 100644
index 000000000000..ef44f50921f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,imx8ulp-sim-lpav.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8ULP LPAV System Integration Module (SIM)
+
+maintainers:
+  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
+
+description:
+  The i.MX8ULP LPAV subsystem contains a block control module known as
+  SIM LPAV, which offers functionalities such as clock gating or reset
+  line assertion/de-assertion.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8ulp-sim-lpav
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: lpav_bus
+      - const: hifi_core
+      - const: hifi_plat
+
+  '#clock-cells':
+    const: 1
+    description: clock ID
+
+  '#reset-cells':
+    const: 1
+    description: reset ID
+
+  mux-controller:
+    $ref: /schemas/mux/reg-mux.yaml#
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8ulp-clock.h>
+
+    clock-controller@2da50000 {
+        compatible = "fsl,imx8ulp-sim-lpav", "syscon";
+        reg = <0x2da50000 0x10000>;
+        clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
+                 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
+                 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>;
+        clock-names = "lpav_bus", "hifi_core", "hifi_plat";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.34.1


