Return-Path: <linux-kernel+bounces-810032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D856DB5150E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F107BFCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFC4318144;
	Wed, 10 Sep 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b="VPOkxCmm"
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5EE31064B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502482; cv=none; b=AYPMh9YILR5Ew9ZlgUsj3kX8miQMsrbdC8/V67Os1QXCjqFDDl95VDOgGYYC1Ggngg7k8maZ6XnYJEYUC3Bg/27Ezs4z77Phq+8I/FEOXWLHug2wbBx5Wwc5B3WlQtovdGdtprrdtETR+KTGjUGLELoCEgTLxu+o6flPVRbCaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502482; c=relaxed/simple;
	bh=O6kMD8HXSfTkDRewsR8EJQ27JNcIL0fez4Ni8uvB7kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJ8cJRJQlwaP43TNJnWao6a98/kYoQvAXvwPhsOZTA0G6sB2crQ0BSkSsyNNxXRut45dBfHqiEp6Ht9I1Azqqb4xRFzalSoS+NXHvDW0FXYyTzoHrR0Nn/XuDqqpYXFmom8AvxHVCT/kwnbVKJfUpOKI9fUwrKexfCATpGP+VYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com; spf=pass smtp.mailfrom=vinarskis.com; dkim=pass (2048-bit key) header.d=vinarskis.com header.i=@vinarskis.com header.b=VPOkxCmm; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail; t=1757502477; x=1757761677;
	bh=g4yIYgMlwfIYDvg+e1t36HW9ZkkuLGqLFC8H6k3D9N0=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VPOkxCmm2D0XCc5NONDIyKcf04iOECkn6CmscLfnBLn5bSmoJT7jKscbNriZcfQOq
	 INS82KHUTUISVetgyN56t91WdTXbyILksKe4eN17Cwxpx8NNelk6XZvgh6DPf297bt
	 pKdIyqWldGCigKwUTGzdNwQ32c2ckv8TRuNgY2xhrHCUjXF4eJ22Xb4TcjZ0VWmvXY
	 VsmwUtjVPzsCvxDHVt9BJviUbzdtqnssMumpzgVhqWLYf9KkyWsqJgCy2/VPGTOCnV
	 2gSTmXdTsFVScbkyXYP0QVjywbuS/in0a91MeQposDvzV3TzWs7AENgvLUD/nOdX3H
	 ijns3I6RswxyA==
X-Pm-Submission-Id: 4cMHwW2DTTz2ScCt
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Date: Wed, 10 Sep 2025 13:07:38 +0200
Subject: [PATCH v4 2/4] dt-bindings: leds: commonize leds property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-leds-v4-2-1fc320488233@vinarskis.com>
References: <20250910-leds-v4-0-1fc320488233@vinarskis.com>
In-Reply-To: <20250910-leds-v4-0-1fc320488233@vinarskis.com>
To: Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Jean-Jacques Hiblot <jjhiblot@traphandler.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 threeway@gmail.com, Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864; i=alex@vinarskis.com;
 h=from:subject:message-id; bh=O6kMD8HXSfTkDRewsR8EJQ27JNcIL0fez4Ni8uvB7kc=;
 b=owGbwMvMwCX2dl3hIv4AZgHG02pJDBkHY1iYeNicuYtWJP1ee1F29v1bH4/s6mt7e+781iWRj
 P6/vrk96ihlYRDjYpAVU2Tp/vM1rWvR3LUM1zW+wcxhZQIZwsDFKQATuR3GyLC1sH9717S3Bgyf
 VBQLpi72P5DbukD8jFLMJa1Zq+X/TPzHyLDo1nbdp5sv/ZiY+ctpn8iXM6vrAgzOJ4ocvnww+lT
 q/BdsAA==
X-Developer-Key: i=alex@vinarskis.com; a=openpgp;
 fpr=8E21FAE2D2967BB123303E8C684FD4BA28133815

A number of existing schemas use 'leds' property to provide
phandle-array of LED(s) to the consumer. Additionally, with the
upcoming privacy-led support in device-tree, v4l2 subnode could be a
LED consumer, meaning that all camera sensors should support 'leds'
and 'led-names' property via common 'video-interface-devices.yaml'.

To avoid dublication, commonize 'leds' property from existing schemas
to newly introduced 'led-consumer.yaml'.

Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
---
 .../devicetree/bindings/leds/backlight/led-backlight.yaml         | 6 +-----
 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml | 5 +----
 .../devicetree/bindings/media/video-interface-devices.yaml        | 8 ++++++++
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
index f5554da6bc6c73e94c4a2c32b150b28351b25f16..8fc5af8f27f9eb95b88eeeee32ad4774f5f21106 100644
--- a/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
@@ -23,11 +23,7 @@ properties:
   compatible:
     const: led-backlight
 
-  leds:
-    description: A list of LED nodes
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      maxItems: 1
+  leds: true
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
index 8ed059a5a724f68389a1d0c4396c85b9ccb2d9af..5c9cfa39396b0ba89830e520ade108bfd1a3f12e 100644
--- a/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
@@ -17,10 +17,7 @@ properties:
   compatible:
     const: leds-group-multicolor
 
-  leds:
-    description:
-      An aray of monochromatic leds
-    $ref: /schemas/types.yaml#/definitions/phandle-array
+  leds: true
 
 required:
   - leds
diff --git a/Documentation/devicetree/bindings/media/video-interface-devices.yaml b/Documentation/devicetree/bindings/media/video-interface-devices.yaml
index cf7712ad297c01c946fa4dfdaf9a21646e125099..3ad1590b04966f52c3643543f4ab28f71ab59638 100644
--- a/Documentation/devicetree/bindings/media/video-interface-devices.yaml
+++ b/Documentation/devicetree/bindings/media/video-interface-devices.yaml
@@ -17,6 +17,14 @@ properties:
       An array of phandles, each referring to a flash LED, a sub-node of the LED
       driver device node.
 
+  leds:
+    minItems: 1
+    maxItems: 1
+
+  led-names:
+    enum:
+      - privacy
+
   lens-focus:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:

-- 
2.48.1


