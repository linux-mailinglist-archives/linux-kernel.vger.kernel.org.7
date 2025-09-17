Return-Path: <linux-kernel+bounces-820116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 119EEB7CDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0493263ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9BD2F2617;
	Wed, 17 Sep 2025 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqA6MoCl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70231BCBA;
	Wed, 17 Sep 2025 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093298; cv=none; b=QvZXIOc5xMjFXY7WzSvJ7nMIUr64HUSdAWfBnRvhZMFwSzyWkLuUY/y3cqUb3SL+SeqROz4zS+MQ0GQjxAfdpz3Cn5PTt0dsllVnHaFid4kEpKxfbSAgEoikFDBO/CBxMavwQGTxYw3J/oK/J4vEVkP1hfqw/s70ANEjhja2Gvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093298; c=relaxed/simple;
	bh=Vy8T6/mn9AJwiVS8Y6wf4dci3WFA1RUm779pXGL5VPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ut9LO0sg+fQDb+j68x/vtbv19c6BaXk8a0HT9ewJPtUzIG445ySr4msmvLZ+bdhMYXzOwFYhmI3M1RAM9ylgRuxx4L+lZu3baCeaMk/gct4SaGdBjr002/UOCXlAVOY/8So4qCydDffRsqo/X+uCVtOYGxvTZLLbqO9i3MERyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqA6MoCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9C0C4CEF5;
	Wed, 17 Sep 2025 07:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758093297;
	bh=Vy8T6/mn9AJwiVS8Y6wf4dci3WFA1RUm779pXGL5VPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eqA6MoClEfQcR8aCziXs8fPeEDBdtzP0pNeKqSOisv0f/nTMJAi/mcMkzpA9RxjLD
	 Er2YB68U/aeB/skI+UcPdyy0xAl0rN+5KcSnqJcmoEZQFN1sweSy3bnCCTpTp22MU0
	 yfEIQZkuSSqPI8asxmRGOal04RrTpXnQeQJigUBJ+38yncHLrI3AKLgzf5vNv7GzKx
	 H6z4uoDX/Z0Ex2+xgUONpkqT1kva1LUGHZjyXgBiMmMZqRfiUCnL3KhrraHVay83Gf
	 OA7DAj+wZgDyVF/CfXo8XjVvm0Rnm896CFNeN2zM7oh9gyp1vMREGdRfYRWw9ScmxX
	 d77g6LJMr5cfw==
From: Andreas Kemnade <akemnade@kernel.org>
Date: Wed, 17 Sep 2025 09:14:29 +0200
Subject: [PATCH v3 1/3] dt-bindings: mfd: sy7636a: Add missing gpio pins
 and supply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sy7636-rsrc-v3-1-331237d507a2@kernel.org>
References: <20250917-sy7636-rsrc-v3-0-331237d507a2@kernel.org>
In-Reply-To: <20250917-sy7636-rsrc-v3-0-331237d507a2@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <akemnade@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=Vy8T6/mn9AJwiVS8Y6wf4dci3WFA1RUm779pXGL5VPs=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDBmn4l/uE7I2/rPE09BHea+qAEOoR4fip5+P1risC1nPf
 ve0S8WpjlIWBjEuBlkxRZZf1gpun1Se5QZPjbCHmcPKBDKEgYtTACZydikjw5Wq4jPPZDc6dvq/
 dLLarDU3+daSCUs9mVSNvYpW9eZM+8/IMN+4TvXuk6KUzv1LysxqF0j0i4R7rGg9dGKzi3+nr54
 PHwA=
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

To be able to fully describe how the SY7636A is connected to the system,
add properties for the EN and VCOM_EN pins. To squeeze out every bit
of unused current, in many devices it is possible to power off the
complete chip. Add an input regulator to allow that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
---
 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
index ee0be32ac0204..4f829fe75d41d 100644
--- a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -32,6 +32,17 @@ properties:
       Specifying the power good GPIOs.
     maxItems: 1
 
+  enable-gpios:
+    maxItems: 1
+
+  vcom-en-gpios:
+    maxItems: 1
+
+  vin-supply:
+    description:
+      Supply for the whole chip. Some vendor kernels and devicetrees
+      declare this as a non-existing GPIO named "pwrall".
+
   regulators:
     type: object
 

-- 
2.47.3


