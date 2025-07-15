Return-Path: <linux-kernel+bounces-731856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01BBB05AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC417534F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D02E0400;
	Tue, 15 Jul 2025 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIoCqEGv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD68220C00C;
	Tue, 15 Jul 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583903; cv=none; b=VrC7UenGy8WNNkbCbGCx+NVE13NqJw/i7larLG8B4W66poso1oQQaUPrkIatkB1R9tVGwtb6fZn6VD1DHywF7LK2G4S46FG0qepKI4D/+jXY5uvcZMtkXcYJYcdHdDEFSULkoHMXUtZ9q5QP+kNVtTeGUCRgxOUkcHxJm1nDkqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583903; c=relaxed/simple;
	bh=2TkqcdkiWyrnm1Y72+wWgizVw6FEwqJ4t2W4Sl/s5HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pM6MRzuBWAorE1OnDgt7pmsAcT9WTIQ7oG23dSGXEOafJH/skoKuasZwjJXV49fwdtcPyBPfSbBDTLsu56lIOsRPcfrcjump5wT/CWtydMQwf6pbamh83O4AqgDaPbEtRl9y5ZTX6U4wqbNTjba/EKLHv6/E1YV3dAtN5mC7ZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIoCqEGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6896AC4CEF6;
	Tue, 15 Jul 2025 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583903;
	bh=2TkqcdkiWyrnm1Y72+wWgizVw6FEwqJ4t2W4Sl/s5HQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TIoCqEGv0LZj54U2MgqyqflIK2m5GfGdmC7j8er6E+p5yUgyDSDCcKM7DPSzpC/oo
	 qxGdmI7mCU5HB1VOGKnjFlCnV+8M2iM+MDvBRqwDyLrXtnPqV8FKkYRU77Ekp6J4ae
	 mRnDhu+4ulNMMNQoxPTGKXTbQ0Zd9C3UMwBcn8Nkt8VqsaM0N8lJL/oGecE4LiTMGO
	 yNqeaBU7fNb2VKFtcpfqmgduCxZuDC+PHfYlzNawfeMl0s5VqyrJ7bJTB7rtjDX+52
	 WJ2NmjcCCstD65Fpn8nU7etJJaois9QF4el9rPhqCqxfKKpS/wtaXeIOx13TP6vv3I
	 hHih3xvWGJ2CQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FBEC83F21;
	Tue, 15 Jul 2025 12:51:43 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 15 Jul 2025 20:51:38 +0800
Subject: [PATCH 1/2] dt-bindings: clock: add video clock indices for
 Amlogic S4 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-add_video_clk-v1-1-40e7f633f361@amlogic.com>
References: <20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com>
In-Reply-To: <20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752583900; l=1212;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=LztxELd9EtqmjCHRSvnKXiDEtIhmTixy/0hdsbLfFOA=;
 b=H9D6zYFXC/H+ChDtNW3x0uSFhuScIdrRXaA1ArwghGEqWePsiq/3BLToknEoNOGIzsLvNoED7
 Ek24Wg8K0TNDNgnd9VqLJPVZuJUu7vagTAQu5PiiMFhgy7HYBtzljT5
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add indices for video encoder, demodulator and CVBS clocks.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
index 861a331963ac..a1cd22b25102 100644
--- a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
+++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
@@ -232,5 +232,19 @@
 #define CLKID_HDCP22_SKPCLK_SEL		222
 #define CLKID_HDCP22_SKPCLK_DIV		223
 #define CLKID_HDCP22_SKPCLK		224
+#define CLKID_CTS_ENCL_SEL		225
+#define CLKID_CTS_ENCL			226
+#define CLKID_LCD_AN_SEL		227
+#define CLKID_LCD_AN_PH2		228
+#define CLKID_LCD_AN_PH3		229
+#define CLKID_CDAC_SEL			230
+#define CLKID_CDAC_DIV			231
+#define CLKID_CDAC			232
+#define CLKID_DEMOD_CORE_SEL		233
+#define CLKID_DEMOD_CORE_DIV		234
+#define CLKID_DEMOD_CORE		235
+#define CLKID_ADC_EXTCLK_IN_SEL		236
+#define CLKID_ADC_EXTCLK_IN_DIV		237
+#define CLKID_ADC_EXTCLK_IN		238
 
 #endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */

-- 
2.42.0



