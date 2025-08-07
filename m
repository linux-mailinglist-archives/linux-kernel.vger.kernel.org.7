Return-Path: <linux-kernel+bounces-759549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CDDB1DEFB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11A31AA1BE9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4119426CE3E;
	Thu,  7 Aug 2025 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up+I9puW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9924DD17;
	Thu,  7 Aug 2025 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754603043; cv=none; b=JHFN9fV0qgtxkM/Tm9/NlHFwvkAoAt05K4cXjpVoIpAJsImScwaRazyGuEKieV1nR65TiWGo7PWTSBDBVwpQkHkzrFxVjyTZWdWF60A3tDKx3ejxzfQSTK/AcKYeW/YiVqPWfUEgBAvhMhArEtBGvSwon1a/gV6naUYtA7GWXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754603043; c=relaxed/simple;
	bh=4Hhu1mY/9d5fc4oL/G5cBEXvFuP6pZFVnFE808w7EtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u28aJwVUX0XfmMafXnd2hBroGXPyWSyxUa0m/loDf+GkazkBkfWWDpLIQWE+G5gE/XctEBX2LLkcwrUvSUTLgPj2sU+L0pgLtGLQUK/pmabJ1WVUUY1d3aIcS5w2V/j6bRWfRApUgCjk+qFh59D/fZOom7Kv4CfxJLAF4PmvgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Up+I9puW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88C0C4CEEB;
	Thu,  7 Aug 2025 21:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754603043;
	bh=4Hhu1mY/9d5fc4oL/G5cBEXvFuP6pZFVnFE808w7EtU=;
	h=From:To:Cc:Subject:Date:From;
	b=Up+I9puWM3oEE1Q/1CwuKRzUqxg3kHpLkqWTEJjBti0j9cgoD95zMXxI9m5o/e0Ai
	 PGbhwjMfOKggtYcltqjPAGeJQTg9haPoGMEQfGAg1OKLz6aTwuHGYCThOKyh+kJEW1
	 ceVI8s/b3s2vO18QACXme5GoIH2GDNDjZVjPBp0mTXpezDFBN5bPznUWiu1pp3/HiH
	 cJQvbI3SJvxcm+3+CX5RZBLr1kst7v5yP2IahcZ0eEG7ilaovLW0ZCCqn3+BXwhner
	 UF+x353kaUz6OaICKFULCE++0QHgMHiHmRQ8tOeycYE/UJwj2eEdU4yseZIbC2wwA5
	 D7Ft8yp9p0QHQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: Drop imx-audio-sgtl5000.txt
Date: Thu,  7 Aug 2025 16:43:57 -0500
Message-ID: <20250807214358.4172451-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "fsl,imx-audio-sgtl5000" binding is already covered by
fsl-asoc-card.yaml, so remove the old text binding.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/sound/imx-audio-sgtl5000.txt     | 56 -------------------
 1 file changed, 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
deleted file mode 100644
index 2f89db88fd57..000000000000
--- a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Freescale i.MX audio complex with SGTL5000 codec
-
-Required properties:
-
-  - compatible		: "fsl,imx-audio-sgtl5000"
-
-  - model		: The user-visible name of this sound complex
-
-  - ssi-controller	: The phandle of the i.MX SSI controller
-
-  - audio-codec		: The phandle of the SGTL5000 audio codec
-
-  - audio-routing	: A list of the connections between audio components.
-			  Each entry is a pair of strings, the first being the
-			  connection's sink, the second being the connection's
-			  source. Valid names could be power supplies, SGTL5000
-			  pins, and the jacks on the board:
-
-			  Power supplies:
-			   * Mic Bias
-
-			  SGTL5000 pins:
-			   * MIC_IN
-			   * LINE_IN
-			   * HP_OUT
-			   * LINE_OUT
-
-			  Board connectors:
-			   * Mic Jack
-			   * Line In Jack
-			   * Headphone Jack
-			   * Line Out Jack
-			   * Ext Spk
-
-  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX)
-
-  - mux-ext-port	: The external port of the i.MX audio muxer
-
-Note: The AUDMUX port numbering should start at 1, which is consistent with
-hardware manual.
-
-Example:
-
-sound {
-	compatible = "fsl,imx51-babbage-sgtl5000",
-		     "fsl,imx-audio-sgtl5000";
-	model = "imx51-babbage-sgtl5000";
-	ssi-controller = <&ssi1>;
-	audio-codec = <&sgtl5000>;
-	audio-routing =
-		"MIC_IN", "Mic Jack",
-		"Mic Jack", "Mic Bias",
-		"Headphone Jack", "HP_OUT";
-	mux-int-port = <1>;
-	mux-ext-port = <3>;
-};
-- 
2.47.2


