Return-Path: <linux-kernel+bounces-768010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49551B25BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0520F7B6C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B4F25332E;
	Thu, 14 Aug 2025 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjiK4xVf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04576239E67;
	Thu, 14 Aug 2025 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153181; cv=none; b=ZDPAVgXAyxGjFBx8SQmY7ig2QtJvkVzybUrBwgBu+vAg/uaCK7XjvPy5FN1f+xOYI+JbAiVPIZvbwV6fzjGmcsaaJInA9UOKGh41yiISw84XcFQAYbpJK3gDeHsxNi5PYIkqfRYBjvdNWP9gXhHGpsandviq2fJ/THj2hGs12Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153181; c=relaxed/simple;
	bh=OUSduZHpQytaAfXKSV2SoQ+CWi6AI0udx0LxSMgifvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RX/4SFQbiyYZKNnoyqHNyn939I29bU12mtTC8doKzXV/j7SCg3xbN8j3pDsfmsr174nQe/dXjugcsXwuSFVjTQCNJfyGL4JvLyMymRlP3/R+4CroG2ZjCEIWjRYcKHi0jzj+64A2dqhHdbn8/pzA5NllvNG3TW73rz1lUaYoIZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjiK4xVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F6D7C4CEF5;
	Thu, 14 Aug 2025 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755153180;
	bh=OUSduZHpQytaAfXKSV2SoQ+CWi6AI0udx0LxSMgifvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qjiK4xVfT+BD6LcYE4yVxmg6/loKD3035deHerx5W5E/pjhi1g/hXkB84h+C03wU2
	 qeHBtgE4ZBcL+Kgxl1Eb2adCe+wx1RmJFEvcLDedDQ0oc6H2S685MwqKjUyWTC8nfP
	 GEqhneZCjp8113tsY5mrRJWozxWhBWu9+TYaMTelBz22uCSXcoSzoS+PFXlczI7ZqI
	 qZCdoVxxek2731vomCbughwGPsOPjgwlWAjoYHQ3Rb4tZwiBtxn+uDmIdZK+/R6hwe
	 46lvTZ8EPUdlTOa1R8K6z48O7jrzIoFeWA5weFzhJUWqdKb+Lkan2Zb29z2kdWWTnd
	 qs1ci7l634vZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED02CA0EDC;
	Thu, 14 Aug 2025 06:33:00 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Thu, 14 Aug 2025 14:32:44 +0800
Subject: [PATCH v2 1/2] dt-bindings: clock: add video clock indices for
 Amlogic S4 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-add_video_clk-v2-1-bb2b5a5f2904@amlogic.com>
References: <20250814-add_video_clk-v2-0-bb2b5a5f2904@amlogic.com>
In-Reply-To: <20250814-add_video_clk-v2-0-bb2b5a5f2904@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755153176; l=1113;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=bgu6e/fPXdfrF8SBobYJP00S8M4VvuEqG6nMELJh9dQ=;
 b=dLOnByYR4ot9TJREpWOoEnTKvj/IOsLcAtxaBMxhrBz8/5bDjbyeYgRStS76ese8bvWi2onpv
 YDWOoJ4ipPQCOGmKZjZiol6b/nO4oG8z6xhEZ5rr1QjccNJRUsQjm6K
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



