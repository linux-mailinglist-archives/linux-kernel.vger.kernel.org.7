Return-Path: <linux-kernel+bounces-812819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0468B53D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D685688EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91328AB16;
	Thu, 11 Sep 2025 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfLo38YN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917122877D5;
	Thu, 11 Sep 2025 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622236; cv=none; b=Pim67VLNRrLTnxYnLQ0ADnvkRGSIAQSjc8INJC8W76ZRk7LADFFAZ3itwmzJoviHz7Z3WznsjOHveS2gwPM1RplCnU0jXqO6wpCspF9BGm0u0rT4krjGk0dWuX2TG7KCmSKdStrDhnjj1+nlEB1UJ3jJXMMH6Wy22K/2V+jVy/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622236; c=relaxed/simple;
	bh=jJN/CVQ4Z0j0qCr/H8XKJBMu2Fbgqv5mOAyr2KXEcTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sc0ZjL62YRTzGQPoRLR40xc1T2LjaclxBHJMprcwo7U16rCNiXgVyfJlBwMxyjGyja/j9lGFopG7laaKqUx/9OCXFFUjpDdJ2OSlnrYnIbgmeqQX3RaIIhwT3jc5QyjFIGK0ZhzeiNts82czbhCE9g05mG9oBfHc2avNlRS5kOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfLo38YN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34C5FC4CEF5;
	Thu, 11 Sep 2025 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757622236;
	bh=jJN/CVQ4Z0j0qCr/H8XKJBMu2Fbgqv5mOAyr2KXEcTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cfLo38YNLgCaBRXyhWEJKqEhLFUodB3gv66ew+Nwj+iEfZnkz4wg3/xtMPvFF7bTq
	 TW5sC099WQJb7y2I6AVwUaqduq5Vruu60Gebtm75zCIdzfzXzRsCWmakxwvU3Lx+dp
	 b0/HjqBjokPLpFhD0vFMqm1ZWFW3HFUydtdpfHc6VOipkCLKuXeY1eiMkmmcppuFJg
	 Ag603e4Ep2ib8GmmNXnG356LZEQ+0qcLysfeVjpt3NSx2XqLlGM5Zqge4jZfsGulJD
	 RJEVAp8SmFKasKKS5nJYTy7GIrGPZZhLx4qor9KuYpu7vftgnzg6zt+Psgq/qBdRO8
	 h5bNTIxSMgODA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245AECAC58E;
	Thu, 11 Sep 2025 20:23:56 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 11 Sep 2025 22:23:55 +0200
Subject: [PATCH v3 1/3] ARM: dts: allwinner: orangepi-zero: Add default
 audio routing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-opz-audio-v3-1-9dfd317a8163@posteo.net>
References: <20250911-opz-audio-v3-0-9dfd317a8163@posteo.net>
In-Reply-To: <20250911-opz-audio-v3-0-9dfd317a8163@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757622235; l=1327;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=jlkkNRSXPvyKb7VkFE4rQa+2nclFteLVP/Fzwz7oW+A=;
 b=Z8C6IY54/f4oSOkqb/qp4iZvO2BDFKeNxw7f4oP0smdBBrUsLMOPexmO5cGlajmBQS//udCD7
 tabOi9+px2mBlP+zxypShC9lYgL2dP2II4X9n+YQnNYEq9z4d9CohaH
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Line out playback and microphone capture work, after enabling the
corresponding ALSA controls. Tested with the Orange Pi Zero interface
board.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
v3:
- no change

v2:
- Add an explanatory comment
---
 .../arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts
index 1b001f2ad0efd2e77218742efe6d8edfdd18a816..b23cec5b89ebf61701e1d917929589eb6e884afd 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts
@@ -112,6 +112,20 @@ wifi_pwrseq: pwrseq {
 	};
 };
 
+/*
+ * Audio input/output is exposed on the 13-pin header and can't be used for
+ * anything else. However, adapter boards may use different audio routing.
+ * - https://linux-sunxi.org/Xunlong_Orange_Pi_Zero#Expansion_Port
+ * - Allwinner H3 Datasheet, section 3.1. Pin Characteristics
+ */
+&codec {
+	allwinner,audio-routing =
+		"Line Out", "LINEOUT",
+		"MIC1", "Mic",
+		"Mic",  "MBIAS";
+	status = "disabled";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_vdd_cpux>;
 };

-- 
2.48.0.rc1.219.gb6b6757d772



