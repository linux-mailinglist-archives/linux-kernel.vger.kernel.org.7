Return-Path: <linux-kernel+bounces-807370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E80B4A387
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9608176E17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD12307ADD;
	Tue,  9 Sep 2025 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJjGRusI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B412305974;
	Tue,  9 Sep 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402978; cv=none; b=IISUw6fVTd7dyiBqVaeJk9/AypZic8QnNmeeAOfofz+37ghe5YselIq35AO37a/1r6SdxI/jY5eWzu7L4nAOD+bi23zgOd31A6I4Ju9HADm+pymNWJ/1rzA5s4iua+XNuYlhEues1qP9l6qH8SQQ9P8/lgfSuPNpDImqyxoXoMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402978; c=relaxed/simple;
	bh=cauIuu3t3nXyrpfWxbbzIxeCXogR2ZYnkCIvBtpd90A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6glB2KAj8CmKcSDKCMt50WeGsLywuFg0IZYR3lBduOCvrqv8kxiMkxuLWzMPYSdZxTUGl1lBEnGfjbz3PQoyBl6xyaAgtJjMM78L1Z27t+jhYsX2mAVw0JPRRPjB6ncmB+8QLhakarvUuUEJZ98da4WiyannXwWcdnAT3uy9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJjGRusI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2157AC4CEF8;
	Tue,  9 Sep 2025 07:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757402978;
	bh=cauIuu3t3nXyrpfWxbbzIxeCXogR2ZYnkCIvBtpd90A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aJjGRusIkFkez0cgwDn/9b6cfhjKmLl2cb7LZg9bERRszHwycMCz5LoBPKrwpqPp5
	 s/FvUfIH7qRBqDqirQn9GSgVKDqVlkdZ2x3SQEzE94dbkDuL9CkcIEn0+rzS3X9oIr
	 8jnrGKNvoE0lrwQhThHyaJG8MLjzMzAVng6D3k6renPRsc804AGDzbxoqdzL46MK94
	 Ws4by6UC9dJXV5aNQ+XBTugD/vjhuHevUccJ8UCa5KMy10I+H9+abB1gvLVPVQwitV
	 z3+07IGYhVxzxpeJkbYz2p27TNTdSmH4vi5O4DmeZG2UHLBPMqj0PFmhpeftv6rVfv
	 ov+DXJfvx0GEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFBFCA0FED;
	Tue,  9 Sep 2025 07:29:38 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 09 Sep 2025 15:29:11 +0800
Subject: [PATCH v4 1/2] dt-bindings: clock: add video clock indices for
 Amlogic S4 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-add_video_clk-v4-1-5e0c01d47aa8@amlogic.com>
References: <20250909-add_video_clk-v4-0-5e0c01d47aa8@amlogic.com>
In-Reply-To: <20250909-add_video_clk-v4-0-5e0c01d47aa8@amlogic.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757402973; l=1224;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=slpmx/KfVVq60h+CXDXC7IwZgqak4zePml0fpt3Y4+4=;
 b=gO5dTZsUoIpIzbuoYVrT/Xd4KYCf0kds59m28nMGG8953yhHU8LpJJS8J73YA4Tpa/BfYL0Dy
 A15wpJ+8PRoDLkT6bgpLyYTasu0TlMphLMnmgs8nbHoKIIbQ8m6zg33
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



