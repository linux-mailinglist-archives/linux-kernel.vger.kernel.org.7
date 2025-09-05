Return-Path: <linux-kernel+bounces-802464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45210B452B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 475B5B60FE3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A9031077A;
	Fri,  5 Sep 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ9VMjq/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A84B283145;
	Fri,  5 Sep 2025 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063206; cv=none; b=WVVLN/ld5torGo70UGT9FRsAAfFfj+G5UATKxY92fvoD+y8uxJP/LMp3Y+8iQDzz5iWEfH7Q8d3Mf6aXoAv+NKTivFGHLWXZ5FXLfAp+pn00vTxvixYpTlpXrcDygHmdJK27W8Kt7ri2b4+SABp/RWdz4f1Z6KBsNURpQAOShPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063206; c=relaxed/simple;
	bh=OUSduZHpQytaAfXKSV2SoQ+CWi6AI0udx0LxSMgifvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpOh/wszR9TKwXee82KBx6aYyzaS2XI8ZtKZMl11iJRlA52y6Jh++t/wL+mO64lZ6EeFzc5Wq/4AQjYOfmtAudhyhMGuvmg2OdDtzw7v483IbHspF5GQg6nS0tJPfSsPSehicyb6k1qi7hErCUVDV8Qaf2JRhzpkkfFTVgUywUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ9VMjq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC7BBC4CEF9;
	Fri,  5 Sep 2025 09:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757063206;
	bh=OUSduZHpQytaAfXKSV2SoQ+CWi6AI0udx0LxSMgifvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XZ9VMjq/lujMZqIuoOmIgvJW0tFX8x3xvhSRioiEUc1OjKhKaD0OcuPI4Nvh6yrO5
	 DYLDPumP+deJpzAXozQZ8eQNwlpLkQ0ggzEJGGgLply3RaPXAPF0sV1I0Z9bEkHvVZ
	 TbP7Msr6OJGu9AksOO3UBytgOdtLf02rrpxK+xhPENA92cPCmcOA0SUIW9lQv7Q1Fo
	 aAv7zbPN1upn9+1qg1cG23BeeqeIv+ovkwVjRyMK0+e5NmNM4iWJeimcXLv1zCQcu8
	 3tPMvHvHrYf184b7dW5zCJ73/73KHiaaT2WK2AMEQfdzQyu0Dtjo+3/VD7CkpQD4D8
	 ye5JqetFtNofA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB6CA1015;
	Fri,  5 Sep 2025 09:06:45 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 05 Sep 2025 17:06:38 +0800
Subject: [PATCH v3 1/2] dt-bindings: clock: add video clock indices for
 Amlogic S4 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-add_video_clk-v3-1-8304c91b8b94@amlogic.com>
References: <20250905-add_video_clk-v3-0-8304c91b8b94@amlogic.com>
In-Reply-To: <20250905-add_video_clk-v3-0-8304c91b8b94@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757063204; l=1113;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=bgu6e/fPXdfrF8SBobYJP00S8M4VvuEqG6nMELJh9dQ=;
 b=kfwLaqWah0xsMRA97VXkD7xs9E8CRixyqUPl75F/w7L6f8CP0IXJIjp2pU9RVECX+Z+gHaSha
 rqClD3gmLU6Ad5rhG88yPygZWmAZ39Vwafp3PiYP6lu5NLW+6BSS9lr
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



