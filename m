Return-Path: <linux-kernel+bounces-761182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AB0B1F564
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4731C626AA2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6912BEC53;
	Sat,  9 Aug 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuImT21Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1326E17F;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754756305; cv=none; b=aX6CFBGedtummOpwp0pwFSNayBSkmt2F/C6UxYr7pQlk0SQo3rjWn6GTU8y5C0LLMKVf1DrbFY/AX4AnM5nGoXyNBr6c9zMKuAZmeBgeZqVdlnrE5Y0thEquBAsJcG9UmdT+pIpPuZqt+AlsVegYLiILTwq9JFUmdQdjeVvRiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754756305; c=relaxed/simple;
	bh=MVrwPnbpDeCNYRZTsZwypV+xQ9Qr414IVgjU0A/5p68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOfkTeh+aAH10/lLG/X+QDw+3cwY+kMw9YcTvLSMWhdjOEZFSCHPxonNutS46JzceGBXWpi1fm3LmN7+mvlRmmuUpTEqD/QJzpahD429rwNe2aUnJ8dTBDXOoe1M3ppdO5uAWmG8CV5oiNqOaUUUc+C1+gtCkhbd7M84HG0WIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuImT21Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C9EBC4CEF6;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754756304;
	bh=MVrwPnbpDeCNYRZTsZwypV+xQ9Qr414IVgjU0A/5p68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tuImT21QtoybNQiEOZUO+R7ydTm/KKDDd0XaxuZUzj3mUQasEj/YsFd3/bQn6qVCx
	 vcj4wRgedxTDmTtYqD5cFFzh6IBVH1m0uMqJK5+wsZ4SuDE51fMtziBQ59GXSve4bA
	 cKCP71g45Liixqz0HkGjqUZoNjgLUyWgI6P5Nz+Ng36fh3No/yW/0dK/bwRTENTkRm
	 J90CbyPKibziccV/3sO3hfF987sSl92bJ+ELSfkbIS+CFh66HDdYXhGxsk6Pwk9NBH
	 wXv/bNhDVS+YrtB9SwJGFanvLskAIeHNMZi6pvOW35mMY/OV6W0rpMdabsA/uK4zG+
	 t9sk7n5ttQJAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8C0C87FCB;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sat, 09 Aug 2025 18:18:06 +0200
Subject: [PATCH v2 1/3] ARM: dts: allwinner: orangepi-zero: Add default
 audio routing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250809-opz-audio-v2-1-f4fd15552a82@posteo.net>
References: <20250809-opz-audio-v2-0-f4fd15552a82@posteo.net>
In-Reply-To: <20250809-opz-audio-v2-0-f4fd15552a82@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754756302; l=1309;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=/SmFcb4P8aLhRsUonrHuHU1uklC2E8xTPCWEXu/PUmE=;
 b=LI2h1mfVWU6kU0l7YHBPmkV41bCngpuBodn49BoN4gCg8R+zxYvaI4/Nk5ZoLTZ69o4JIpEmE
 2/oizJo7lvmB/nXbzNyJCIEUTRP39WBJ3XKgGLOpZXmp4eDUgfSCuk6
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



