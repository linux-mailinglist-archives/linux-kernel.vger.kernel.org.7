Return-Path: <linux-kernel+bounces-804133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DACEAB46A5D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4576B1894E0F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68E29E0E9;
	Sat,  6 Sep 2025 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAHSwb6+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27D26C391;
	Sat,  6 Sep 2025 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149800; cv=none; b=om/KNePq8xy9Mw0oxJCT4AqKKxQXPWYKow5NfPUrLozQdZd8r0SdeXK4A//Vxp9DZAfdonInHYPPT6TSHWpl2tv+I1sxp6a35qB/MIY2WGEzL1+L/3GW4Ww1ybaLrCX1f2CqIcX4XapezBgJ8Yb4HC//P1BcceIJX2YYQqpyRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149800; c=relaxed/simple;
	bh=CKaMxVjr2jWFkmaLip35qyMUvXrsM1VU1NB2L1dKWEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNn3UIwTmLlfZZzDWdNgaA7IZABtwa27/XRXDjAMIXa23/NuEz2S0X0wl7/wNCx8otO6Sgr03y7NXsi+EjQDMMFwrC8/deGyhux1ExkA9rpJl/cmn9g/0eeKfWzmtv5DzFTRuLvyFF90ilRwqu4ZTZRPKCa4vHSQP9DvywlQaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAHSwb6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9439C4CEF4;
	Sat,  6 Sep 2025 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757149799;
	bh=CKaMxVjr2jWFkmaLip35qyMUvXrsM1VU1NB2L1dKWEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SAHSwb6+5FMtTO2rsGdBGumNvDHdj7GS7PyaP6UEEIjQapAB4Y1FazsW02ps3qxb3
	 ognqgZA5+nqu2Kz/TeMZ03Iij2Mmxsgy7ED+QHlUO0vtJm1Opb3Yob6WOgxpfpktfD
	 d5n7oMid81tHG6hR8CEZvW83JN6nfXGt3QcA7GnNg7BrYz+lH6IWnfQUBQMny6EHbV
	 8D8fiAQ/Mg7Q5eikqBJlml+lCFyapnMDGNqbk41GnIEfJUbGl6npyy15tUIXoi/tzx
	 X13Is9+7djfdQ5qJO11sowFxi9hNa9gBsfCe9Yaz9wfYjxFF/d61PD3q3wr06Q5X3L
	 BDAvDPQ49KXDg==
From: Andreas Kemnade <akemnade@kernel.org>
Date: Sat, 06 Sep 2025 11:09:12 +0200
Subject: [PATCH 1/4] dt-bindings: mfd: sy7636a: Add missing gpio pins and
 supply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-sy7636-rsrc-v1-1-e2886a9763a7@kernel.org>
References: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
In-Reply-To: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <akemnade@kernel.org>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=CKaMxVjr2jWFkmaLip35qyMUvXrsM1VU1NB2L1dKWEQ=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBm7fwVY2l80u7DcT/GRy07WRQYZ/9nvBn2cvvOc8oUJ3
 Ffydm+M6ChlYRDjYJAVU2T5Za3g9knlWW7w1Ah7mDmsTCBDGLg4BWAi0msYGZ6FiL2exPV/iX1L
 dtO+P8+sfj1pKFUwbL9949K/1JMbV3gxMnz/cuqHprc7m+sGic9pPBb1mz4vzIuR+Oz82oXlmEj
 tD34A
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

To be able to fully describe how the SY7636A is connected to the system,
add properties for the EN and VCOM_EN pins. To squeeze out every bit
of unused current, in many devices it is possible to power off the
complete chip. Add an input regulator to allow that.

Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
---
 .../devicetree/bindings/mfd/silergy,sy7636a.yaml         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
index ee0be32ac0204..08ad593e237f1 100644
--- a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -32,6 +32,22 @@ properties:
       Specifying the power good GPIOs.
     maxItems: 1
 
+  en-gpios:
+    description:
+      If EN pin is not hardwired, specify it here to have it set up.
+    maxItems: 1
+
+  vcom-en-gpios:
+    description:
+      If VCOM_EN pin is not hardwired, specify it here to have it set up.
+    maxItems: 1
+
+  vin-supply:
+    description:
+      Supply for the chip. Some vendor kernels and devicetrees declare this
+      as a GPIO named "pwrall" which does not exist in the datasheet,
+      disabling it makes the chip disappear on the bus.
+
   regulators:
     type: object
 

-- 
2.39.5


