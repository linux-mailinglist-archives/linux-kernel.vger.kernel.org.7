Return-Path: <linux-kernel+bounces-812820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3BDB53D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020B8488AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E74828725B;
	Thu, 11 Sep 2025 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc3cXZad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A42877D0;
	Thu, 11 Sep 2025 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622236; cv=none; b=pfBDqtM2SH9x6c0k6et5CK0Q1lpcQqRSPa+sjMTcC9vU9i7Tok+uNZFBFJRE6Zq6g3ail1r0mvtJlSlCejz6HWkxGkmPhKxv3TIqTUZ4QDdDR/5EG4fGMy1PSMVdHilg7/eza4ZFxKJPOEoDUn0RuqL+zajvmlDi2DY96WrfPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622236; c=relaxed/simple;
	bh=+fg2XJ6V4EXpVY8foeoIiAPGVpFlrVbSUzSPWYbWq4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVXQjWI0CwNDF8JyBBgWxS4F13yuhsGrK2kcVH99XiE9QJ3bvVEu9cyht4vhuiNBNnp2FZAOjX8svkHgHih6tqyLsVYEMBJWc0tgFOgcACWLcSkAOkNz40yGlrxLqr3gPTtO2x6fBWeQMG3gXTSbnxZePKD+6bDBfVcTAi93uog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc3cXZad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 446EDC4AF0B;
	Thu, 11 Sep 2025 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757622236;
	bh=+fg2XJ6V4EXpVY8foeoIiAPGVpFlrVbSUzSPWYbWq4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zc3cXZadCJfCfmGCGjgmJmKVmaWRc7jEFsic8KQoJ+DvoK/FMGr+M6rG8blQzdYK5
	 zKeDyM/6YYK1nBZGHfSbWc7S1hnAFz0yYht/8RGraT1vjd4BrzrgWMMl6vOzzKoAHu
	 RniCbZ9lnARURUb2oqrwnWg3iZRMMz1LFUM9fjL8F15Mrf6llrOQcn2xbPcPJ7wtSl
	 MbPjWQNj3V5Bz3t5t6YLtBnop+ql8K97i/hcG7BNy5lxcwzqkKBRwChHAnH28mwz83
	 Ublkr9mfVhhi2LhZyb55cz9V+vI6wg2eWmCNhUEXU92ZM7p0mqTdgzczkqXtNe1qlC
	 ZFWlHvwvHZpSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33372CAC594;
	Thu, 11 Sep 2025 20:23:56 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 11 Sep 2025 22:23:56 +0200
Subject: [PATCH v3 2/3] ARM: dts: allwinner: orangepi-zero-plus2: Add
 default audio routing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-opz-audio-v3-2-9dfd317a8163@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757622235; l=1762;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=dWHMhK9+i25A6TeKPx+ibyL8vqsj2DN+ba2hhjCRSyM=;
 b=dsa6mV8JoKpL+Qr+VFEifgbXsEmJJM5mCEaCbUN9IxqQ+N84Pi0MbBFR1u1c+EHOGNj8rAsEa
 bGwabK9R1DKAIrBfbgdWS4A506AQCGJoKR19ZtiBYxgaJtPE7UM4rzD
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

The Orange Pi Zero Plus 2 has the same pinout[1] as the Orange Pi
Zero[2] (with the possible exception of line-out left/right being
swapped), and the Orange Pi Zero Interface Board is sold[3] as
compatible with both of them. We can thus use the same audio routing.

[1]: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-Zero-Plus-2.html
[2]: https://linux-sunxi.org/Xunlong_Orange_Pi_Zero#Expansion_Port
[3]: https://orangepi.com/index.php?route=product/product&product_id=871

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

v3:
- Fix board name in commit title, as reported by Chen-Yu Tsai

v2:
- new patch
---
 .../boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
index 7a6444a10e2534458b7380882ea4fd42bd54fea8..97a3565ac7a819be6b18d324fa6f65d0d1d2b2ad 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
@@ -99,6 +99,20 @@ wifi_pwrseq: pwrseq {
 	};
 };
 
+/*
+ * Audio input/output is exposed on the 13-pin header and can't be used for
+ * anything else. However, adapter boards may use different audio routing.
+ * - http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-Zero-Plus-2.html
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
 &de {
 	status = "okay";
 };

-- 
2.48.0.rc1.219.gb6b6757d772



