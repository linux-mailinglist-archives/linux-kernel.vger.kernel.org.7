Return-Path: <linux-kernel+bounces-773630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5110B2A34F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93798188F551
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401D531E0EB;
	Mon, 18 Aug 2025 13:01:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519CB31AF15
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522094; cv=none; b=sYWQBeODixvM/TBrjN7hxP6nxMrNI7ZFUVcf8UesYnCU7uSUPFzYUHMCTJ4ac54Ss1t7mp6A/CupuIOtMe8xeHfdNF4EJabpjYBXIAueDXDV5xJ+LhS7h9El1m8U6VHXHVAnqTl+hBbuT10xQ3BvROEXlFgfcy9fi+dUkR+b8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522094; c=relaxed/simple;
	bh=lYZ4xblenSXqTgBcJ1Ts2ig91XG8BZggQjJLEkjVl44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lK23IlGuuryv0G5uU+7W+2FPfbcKrw0v9AJJO84O2fKlTi0HOzd8VP3po1ZlDy7EUoxdmv2TGa5TgvkwT54Q4ySydKGPlbPKs9rDE1bc6jybu4sBOSNMtFI1IYLe+WtZrkEcwa7BlheA1uj7vhNEUkDpb4nbjgJHfD4UAY61yT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1unzUD-0003t9-OS; Mon, 18 Aug 2025 15:01:17 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1unzUD-000uE4-0K;
	Mon, 18 Aug 2025 15:01:17 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1unzUD-005swT-06;
	Mon, 18 Aug 2025 15:01:17 +0200
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Date: Mon, 18 Aug 2025 15:01:08 +0200
Subject: [PATCH 2/2] ASoC: dt-bindings: ti,pcm1754: add binding
 documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-v6-12-topic-pcm1754-v1-2-e1dd189ea99a@pengutronix.de>
References: <20250818-v6-12-topic-pcm1754-v1-0-e1dd189ea99a@pengutronix.de>
In-Reply-To: <20250818-v6-12-topic-pcm1754-v1-0-e1dd189ea99a@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The Texas Instruments PCM1754 is a simple stereo DAC without any digital
management interface but soft mute, PCM input format and 44.1 kHz
digital de-emphasis can be configured via strapping pins. Only soft mute
and PCM input format selection is currently exposed via optional GPIOs
in the driver.

Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
---
 .../devicetree/bindings/sound/ti,pcm1754.yaml      | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm1754.yaml b/Documentation/devicetree/bindings/sound/ti,pcm1754.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..924386092a60e6637a1134f174511e7e61b16839
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm1754.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,pcm1754.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments PCM1754 Stereo DAC
+
+description: |
+  The PCM1754 is a simple stereo DAC that is controlled via hardware gpios.
+
+maintainers:
+  - Stefan Kerkmann <s.kerkmann@pengutronix.de>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,pcm1754
+
+  VCC-supply: true
+
+  '#sound-dai-cells':
+    const: 0
+
+  format-gpios:
+    maxItems: 1
+    description:
+      GPIO used to select the PCM format
+
+  mute-gpios:
+    maxItems: 1
+    description:
+      GPIO used to mute all outputs
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    codec {
+      compatible = "ti,pcm1754";
+      #sound-dai-cells = <0>;
+
+      VCC-supply = <&vcc_reg>;
+      mute-gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
+      format-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+    };

-- 
2.39.5


