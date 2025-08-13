Return-Path: <linux-kernel+bounces-766425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A1EB2466F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AF2885B25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5D02FF146;
	Wed, 13 Aug 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M67J4EER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59F92FDC21;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078830; cv=none; b=rgUTnNV8J55Po1FLP9OQuZekMSQsiJ9bB3LZEjaYf2yH7ZS7iN4THBQq0Bzc1pK7OgFOp1nIWMqKwCfkeQzD9Lny62skcYtpWfo4reF2DMpiQeil3hvbSbKxTH2aGQgLIGFciphUvl9WtbybPCkQo70dU4uB1JRAhMqLe1gMd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078830; c=relaxed/simple;
	bh=Ha5dEuqV8NyStkOm/Hu12jV5CVCm/XkYT4uR220+Lss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d9pPpwPYUfxIRZcysMJ+uRFwBQmbTdl0wSsMW1lkeSyHfkMo6+texGDAEWViPPQrK1PaG6cHZcBvHjjzyey6hVT29BgFptnvVmkPdZScqAh2pEB791rr3IfY6BeH8T0VXIoS5TW7CA0WTKpj89Gz2rybbrO17C3mJWFKv1m670U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M67J4EER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E650C4CEFD;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755078830;
	bh=Ha5dEuqV8NyStkOm/Hu12jV5CVCm/XkYT4uR220+Lss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M67J4EERGcUplYJuGDjL9tQgqb74vyC5oU4EvnobEEgKyg1qGffMQ0Pqrv+/dALKm
	 CF46C9aTvB/EqBATFcA9LM0s2+cSdFLGZwN15jRAMZWVKAUxU/833cTGparhhVUglY
	 ZqOpIPEbxjHGh4OSe8SkTVTdCXaRjUX6ZTyeDp2XDkYnvTg/nwe0kP2dP7gD2XuC5z
	 qgnuZp+xIDOfaYV3YOGtp/kME275f5cW/bdrMtjBKNKfBTFSZXfTSV9XOp03VAlEIh
	 UAapdOkQryyXc63CAPCBPMl2hx2MSf/1BbVeJpwPXEIc4pteV27su+/TbA4Fetw53F
	 9ak0knWU+vxSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E30CA0EE6;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 13 Aug 2025 11:53:35 +0200
Subject: [PATCH 3/5] arm64: dts: apple: t600x: Add bluetooth device nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-apple-dt-sync-6-17-v1-3-209f15d10aa0@jannau.net>
References: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
In-Reply-To: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5002; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=C2YwY38W49BVPlqekZccmVQQ104q7sB0ZkEUHkDIXu8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhow5CWuYtHo0f/1vSt+eLWglGlpdeSL2geTTZU0lMgohR
 ydJTjrXUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCJyoowMF9nPxilazN7M9eP+
 lHzWNZv+W4TZrhPbOW1P6Jss5vw3sYwMd2Ifrxfc0bTw+5R2+Y1XRJ6sWSm6Ycq+qiuOT1f+ito
 XygIA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Hector Martin <marcan@marcan.st>

Add bluetooth PCIe device nodes to specify per device brcm,board-type
and provide the bootloader filled "local-bd-address" and calibration
data.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t6000-j314s.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t6000-j316s.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t6001-j314c.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t6001-j316c.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t6001-j375c.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t6002-j375d.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 8 ++++++++
 arch/arm64/boot/dts/apple/t600x-j375.dtsi      | 8 ++++++++
 8 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6000-j314s.dts b/arch/arm64/boot/dts/apple/t6000-j314s.dts
index ac35870ca129ce353b04296800b197bf684d0bd7..1430b91ff1b152e5a23025d5377f189601bb5a09 100644
--- a/arch/arm64/boot/dts/apple/t6000-j314s.dts
+++ b/arch/arm64/boot/dts/apple/t6000-j314s.dts
@@ -20,3 +20,7 @@ / {
 &wifi0 {
 	brcm,board-type = "apple,maldives";
 };
+
+&bluetooth0 {
+	brcm,board-type = "apple,maldives";
+};
diff --git a/arch/arm64/boot/dts/apple/t6000-j316s.dts b/arch/arm64/boot/dts/apple/t6000-j316s.dts
index 77d6d8c14d741e9b6a0dc44f764ea54f966e0d59..da0cbe7d96736b1491497243bdbd1d13c9ab6c62 100644
--- a/arch/arm64/boot/dts/apple/t6000-j316s.dts
+++ b/arch/arm64/boot/dts/apple/t6000-j316s.dts
@@ -20,3 +20,7 @@ / {
 &wifi0 {
 	brcm,board-type = "apple,madagascar";
 };
+
+&bluetooth0 {
+	brcm,board-type = "apple,madagascar";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001-j314c.dts b/arch/arm64/boot/dts/apple/t6001-j314c.dts
index 0a5655792a8f1cb6d0029bf9f967aa74cf6c01f7..c37097dcfdb304d8fcdf77de82e494e158d94c72 100644
--- a/arch/arm64/boot/dts/apple/t6001-j314c.dts
+++ b/arch/arm64/boot/dts/apple/t6001-j314c.dts
@@ -20,3 +20,7 @@ / {
 &wifi0 {
 	brcm,board-type = "apple,maldives";
 };
+
+&bluetooth0 {
+	brcm,board-type = "apple,maldives";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001-j316c.dts b/arch/arm64/boot/dts/apple/t6001-j316c.dts
index 9c215531ea543e9afe8c131f7c8dc68cfaae666c..3bc6e0c3294cf98c89dddfb4891eefbe8aae7020 100644
--- a/arch/arm64/boot/dts/apple/t6001-j316c.dts
+++ b/arch/arm64/boot/dts/apple/t6001-j316c.dts
@@ -20,3 +20,7 @@ / {
 &wifi0 {
 	brcm,board-type = "apple,madagascar";
 };
+
+&bluetooth0 {
+	brcm,board-type = "apple,madagascar";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001-j375c.dts b/arch/arm64/boot/dts/apple/t6001-j375c.dts
index 88ca2037556cec4307d27bba0244d7ba7f45b184..2e7c23714d4d0007b7096d469f32c689944c85ff 100644
--- a/arch/arm64/boot/dts/apple/t6001-j375c.dts
+++ b/arch/arm64/boot/dts/apple/t6001-j375c.dts
@@ -20,3 +20,7 @@ / {
 &wifi0 {
 	brcm,board-type = "apple,okinawa";
 };
+
+&bluetooth0 {
+	brcm,board-type = "apple,okinawa";
+};
diff --git a/arch/arm64/boot/dts/apple/t6002-j375d.dts b/arch/arm64/boot/dts/apple/t6002-j375d.dts
index f56d13b37eaff1c3c14815575a71024661669296..2b7f80119618ad1b497b67597c55968585bd92a9 100644
--- a/arch/arm64/boot/dts/apple/t6002-j375d.dts
+++ b/arch/arm64/boot/dts/apple/t6002-j375d.dts
@@ -42,6 +42,10 @@ &wifi0 {
 	brcm,board-type = "apple,okinawa";
 };
 
+&bluetooth0 {
+	brcm,board-type = "apple,okinawa";
+};
+
 /* delete unused always-on power-domains on die 1 */
 
 /delete-node/ &ps_atc2_usb_aon_die1;
diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
index b699672a5543c1c172f9a788d36287c0b09051e1..c0aac59a6fae4f6f4b387483665349a8e2521c1e 100644
--- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
@@ -13,6 +13,7 @@
 
 / {
 	aliases {
+		bluetooth0 = &bluetooth0;
 		serial0 = &serial0;
 		wifi0 = &wifi0;
 	};
@@ -105,6 +106,13 @@ wifi0: wifi@0,0 {
 		local-mac-address = [00 10 18 00 00 10];
 		apple,antenna-sku = "XX";
 	};
+
+	bluetooth0: bluetooth@0,1 {
+		compatible = "pci14e4,5f71";
+		reg = <0x10100 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-bd-address = [00 00 00 00 00 00];
+	};
 };
 
 &port01 {
diff --git a/arch/arm64/boot/dts/apple/t600x-j375.dtsi b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
index 95560bf3798bfebe133afafba674005a3e62ddcc..ed38acc0dfc36a1e30b1d44f1a8dcee089e87232 100644
--- a/arch/arm64/boot/dts/apple/t600x-j375.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
@@ -11,6 +11,7 @@
 
 / {
 	aliases {
+		bluetooth0 = &bluetooth0;
 		serial0 = &serial0;
 		wifi0 = &wifi0;
 	};
@@ -90,6 +91,13 @@ wifi0: wifi@0,0 {
 		local-mac-address = [00 10 18 00 00 10];
 		apple,antenna-sku = "XX";
 	};
+
+	bluetooth0: bluetooth@0,1 {
+		compatible = "pci14e4,5f71";
+		reg = <0x10100 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-bd-address = [00 00 00 00 00 00];
+	};
 };
 
 &port01 {

-- 
2.50.1



