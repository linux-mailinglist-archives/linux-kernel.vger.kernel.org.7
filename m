Return-Path: <linux-kernel+bounces-818022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08A0B58BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212654841DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A6238D52;
	Tue, 16 Sep 2025 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agXC5LkC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C88721579F;
	Tue, 16 Sep 2025 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988389; cv=none; b=HpimrXJHNPXzhzXqBTLbXgsYqT2jEMpgJFpmUMbuMzfZK0+oz3rIkYjIi+37hTnHnlLMzp7YtyzP3Stl1IW5UQa5GGkDFKLejMfuLLh7M7I+VmkPdMCEVNr0ulntQTBLs6qo2H4VKTHrESNHF5ti0+EPEMAT2SDQ6LzA1EN5ycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988389; c=relaxed/simple;
	bh=QLoUf6MbemExweEkSHZ6Cs4Fo/cev8YIR8uKZymd67k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4XEXLj4G6JSoM9vXah8BJc/mFgzvnAwkfbr344/SeGK3Cx8wVR9GSWKxsL9BRp2b3/TXRjJUCXqsPbjVwTXpCh/7N8zZeaDVGPuylXUKfl5dTfKEbV/1YSZCHclMpKvTMOyl250zFIKbsu/UbwuEjzEo0TEvjDR0fuo75mUjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agXC5LkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7AEDC4CEF9;
	Tue, 16 Sep 2025 02:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757988389;
	bh=QLoUf6MbemExweEkSHZ6Cs4Fo/cev8YIR8uKZymd67k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=agXC5LkCqWnp1biTl5BUVyg8SRFUovUf8ygMm5nxJhdZzpS8hI5Wqod1JkjpSxqRc
	 c5JjwdzhQJC/RAl3tnRr1HNafCjiLtRJrWYEKvx992Ms5ZptQTf89fMjUDin7oCrEY
	 925zBkjpvR4Cfp2zi7xfW/5qT8hqXCKGJljKuSVszi/7dKHFtFHkeO5SY9E9jF5BDq
	 2OnuloGHfpPieJT0SjUb/nBudwZNftcPJd56EnhOIGSkMdByk1vhLYHbeX+INbqgje
	 0EX8RLcOkgcLtwWEIAUTSwDywt1G9h1nWHHBbKQcl4g9G5XxRH2Caw6niYI+wYtBjW
	 R+Hd2RZg4T7oQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B56CAC599;
	Tue, 16 Sep 2025 02:06:28 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 16 Sep 2025 10:06:06 +0800
Subject: [PATCH v5 1/2] dt-bindings: clock: add video clock indices for
 Amlogic S4 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-add_video_clk-v5-1-e25293589601@amlogic.com>
References: <20250916-add_video_clk-v5-0-e25293589601@amlogic.com>
In-Reply-To: <20250916-add_video_clk-v5-0-e25293589601@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757988387; l=1277;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=oFTBK7GmWCd1bTbEyxd9lw2QoXtneH1SDFph2xdcxG4=;
 b=oMOS0qBWNYhTCkKeIJSvkDNEQ0rEh61ZqxQ/unVz/WlVjattQnvHeUAxpbBLp6uTsxK+3GdcQ
 bRx59VjWVi0DWeb2isz67xp/LBjCVFPxmrquIFsIf5kCP2ElCGt7DAA
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



