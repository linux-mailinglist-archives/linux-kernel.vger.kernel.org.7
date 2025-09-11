Return-Path: <linux-kernel+bounces-811274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70309B526E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2227B7181
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4560226165;
	Thu, 11 Sep 2025 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="YTlxKpMS"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E9218ACC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560137; cv=none; b=h73+99vLxP/u6gAyVJxi5xqwiDSHQ4TSxYzucoA7sPB2l/lsOLqkBBbxnjRnOIMMBrpaBKNkUOz4ImSYqeNVsxmlkK6I2TZ2a1wHwwTtfyLGcDrI5d47DqTbK4b0YUuqWuW1Qwrc4OCqYfIploZhgtSsg+x7alqgA2Mt8ZJmQxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560137; c=relaxed/simple;
	bh=bgcaVa8rMGcBrZfsrzhFJtttqvFxPe7HhoFjF8JSFbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jfUtP+OqNqiOPCGt4uAzeu32+MVuu3ONonsXzNY1qY6risnhimVeELWSgW4/y8J6P2YB7lgJ8Ugc13qmZ27XqpfZX6zY44NC0SaDlLSbsQamcgB4M3ufJxiUuwp2GG4VD68HGZG7mXzLM34Xqc0e/SbN1Y9gOGAUrYjkD8zJCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=YTlxKpMS; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757560133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZTCpuqimHVRO54aoEghZv3ss2SMTvWddizLriMnT94=;
	b=YTlxKpMSxc+KN6zC+TnOvkTqk69PF+MlAzgepLsKw/Q05v4UBQyWnNk6ljrw78ArbFd8qC
	S2oBA7eD/MQLIbEDj2xoS5CXli4LhkF+g4MId2N1LqcfPH2XD2xEu+fB3L6x3CESEomssm
	+sw+j88jFsVcrrYzFbEjm4SD1Q6gAL/Ifkibf2g9VxC+x6nWnMkVvsIOK/m50iq2k/utXH
	ZQhxRQ6pjzl+/kdQYpBPlW3/lxuLEhAxDUDAR4tv36BGquEXnH0Mgar0Jb4w09SoKz10qC
	piEGusrkgANrWi1XOJiho+DybAtkk2uc0i9MVl6BmdfDviCxB0bicwSc4TjvUg==
From: Paul Sajna <sajattack@postmarketos.org>
Date: Wed, 10 Sep 2025 20:08:21 -0700
Subject: [PATCH 2/3] dt-bindings: display: panel: Add devicetree
 documentation for lg,sw49410
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-judyln-panel-v1-2-825c74403bbb@postmarketos.org>
References: <20250910-judyln-panel-v1-0-825c74403bbb@postmarketos.org>
In-Reply-To: <20250910-judyln-panel-v1-0-825c74403bbb@postmarketos.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Amir Dahan <system64fumo@protonmail.com>, 
 Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757560120; l=2069;
 i=sajattack@postmarketos.org; s=20250422; h=from:subject:message-id;
 bh=bgcaVa8rMGcBrZfsrzhFJtttqvFxPe7HhoFjF8JSFbU=;
 b=7RhDhMLDi49eJwI2wSG7OL9L35ioUiwGsk0ZM7W7E0/TdZooIC37LAH0lc9r5O4ITwPL5oE0i
 35ag74JZ7iaDzXrcikMCZGp54+Ze1LqNE5g8la6LIGj6MN6thF4rMAr
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=TwacvEOiRJ2P2oAdEqIDrtQTL18QS4FfcHfP/zNsxkQ=
X-Migadu-Flow: FLOW_OUT

Document how to use lg,sw49410 in a devicetree

Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
 .../bindings/display/panel/lg,sw49410.yaml         | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7e0db98687d9cfc4da7137e8781752e1401d5ed7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,sw49410.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG SW49410 MIPI-DSI panels
+
+maintainers:
+  - Paul Sajna <hello@paulsajna.com>
+
+description:
+  LG SW49410 6.1" 1440x3120  panel found in LG G7 ThinQ smartphone.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: lg,sw49410
+
+  reg:
+    maxItems: 1
+
+  backlight:
+    description: Backlight device reference
+
+  reset-gpios:
+    description: Reset pin reference
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display_panel: panel@0 {
+            reg = <0>;
+            compatible = "lg,sw49410";
+
+            backlight = <&pmi8998_wled>;
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+            pinctrl-names = "default", "sleep";
+            pinctrl-0 = <&sde_dsi_active &sde_te_active>;
+            pinctrl-1 = <&sde_dsi_sleep &sde_te_sleep>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
+...

-- 
2.51.0


