Return-Path: <linux-kernel+bounces-824031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F54FB87F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CECB5808AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A0028727A;
	Fri, 19 Sep 2025 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdmmGPmg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B42153D2;
	Fri, 19 Sep 2025 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758261551; cv=none; b=eKwKRqdy17qQZxzZzXUET6CUqcgAR/7GQgLn56uL6Kv9OamlIsUSsP1mtlML+VQ19xZk5fXTFmoOL+vDWBYIrs0d6ej2h4QxTDwILo3B9NSlJBZDxd/phcLAWDcdGMsZ0OgMpFpKHRQCC1v5vJv5n6A1R2yMzyiLAYFrhdcwZqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758261551; c=relaxed/simple;
	bh=QLoUf6MbemExweEkSHZ6Cs4Fo/cev8YIR8uKZymd67k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lL9FzGcwfK64PEmt4VCiHpZkSiTS9fe4xxYBwsfaDegtPrdfknRBhFLqrEHlcyU97KebpKvfuD9xfG3CoUiV3hvjWPd4oxL1LmC+h3rZQ3fcFrjwl3ST9WS3ctgwFfIzsHvlbO74HyudzQQ2SK2nI1MqTwFbj2645DG9e0X1nFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdmmGPmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91F59C4CEF7;
	Fri, 19 Sep 2025 05:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758261550;
	bh=QLoUf6MbemExweEkSHZ6Cs4Fo/cev8YIR8uKZymd67k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DdmmGPmg3TR3TMfxLtnLjyVcgG9cVOkyMT+JFYcLGXFUlyF1fl4JODVB8CF+VTHXK
	 F9ExPLXTcQNzAbSun1YmtzOxc+VouR635zPDG0pVePHDRIHDOvzi9ZZZVYL5fu4RLC
	 iBJgGBFBI6AbE13rqU7/kCXUFZ7z3V7dxU4Ljkv0OQ2KMBZUkLglxrWAxTBeSestrI
	 hUefAAbJsKFsxUQ/jHTSvFFyQc2pV9XDWvHooqRrVDsW8m3jqWR2lF2rLMuUJMPpeD
	 fLLjwS2Hb7+yXhhd3QQ0vXwBX4bLW/2ob86U+aXmdZsCkm7PtyeLRqY60sL8/9d8eb
	 0NJyA/08sSyiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81091CAC5A8;
	Fri, 19 Sep 2025 05:59:10 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 19 Sep 2025 13:58:59 +0800
Subject: [PATCH v6 1/3] dt-bindings: clock: add video clock indices for
 Amlogic S4 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-add_video_clk-v6-1-fe223161fb3f@amlogic.com>
References: <20250919-add_video_clk-v6-0-fe223161fb3f@amlogic.com>
In-Reply-To: <20250919-add_video_clk-v6-0-fe223161fb3f@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Chuan Liu <chuan.liu@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758261548; l=1277;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=oFTBK7GmWCd1bTbEyxd9lw2QoXtneH1SDFph2xdcxG4=;
 b=qgOii3kCYety9Xap68/0E6rPikg6BVV+MXY2JSJ82KyPp0Vw9nm3HCAFXsY+3VabzegaeHx4p
 P0bxD3847auCuNMQOyYEvyTNeronrG/nAohEiE3pqXV7p+ioBRh4M0x
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add indices for video encoder, demodulator and CVBS clocks.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
index 861a331963ac..b0fc549f53e3 100644
--- a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
+++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
@@ -232,5 +232,16 @@
 #define CLKID_HDCP22_SKPCLK_SEL		222
 #define CLKID_HDCP22_SKPCLK_DIV		223
 #define CLKID_HDCP22_SKPCLK		224
+#define CLKID_CTS_ENCL_SEL		225
+#define CLKID_CTS_ENCL			226
+#define CLKID_CDAC_SEL			227
+#define CLKID_CDAC_DIV			228
+#define CLKID_CDAC			229
+#define CLKID_DEMOD_CORE_SEL		230
+#define CLKID_DEMOD_CORE_DIV		231
+#define CLKID_DEMOD_CORE		232
+#define CLKID_ADC_EXTCLK_IN_SEL		233
+#define CLKID_ADC_EXTCLK_IN_DIV		234
+#define CLKID_ADC_EXTCLK_IN		235
 
 #endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */

-- 
2.42.0



