Return-Path: <linux-kernel+bounces-724848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2E7AFF791
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A321C4658B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072C1284682;
	Thu, 10 Jul 2025 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqmYIC2T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F692236A73;
	Thu, 10 Jul 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118572; cv=none; b=l8w8SSC1+LH4VtodPdMO5EHXvuW2ro7Nv+2RBS2fZ+7FLXOHSsN5y9Grtocj0xOntOEo1bN+dULtbXrQD/ihCbCV7rXYF2oxOCmaALdchPQKNqrWikzYI9Bz8TbJUxRO80DSHz1CovSOW9cWBL+lvVLcWVQmpopNXZGE2AfkASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118572; c=relaxed/simple;
	bh=mpUMB0zy8d4IkeeacZr5LroYN19aKGV0mgmO87Hknc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBAJM7hcBmA4iJW1uuJrkDg/xrBRPX0BORWElDzsOOMB/v1muMzoi3GF5KAGytZqUmA9ttbyxZokgHneuFGAGsMr5dQpc8NJwZeETI43FNx1V88CdA/jAQ8oGqGaCCixCmACEJX3QpfGCyB3d64de2F2fzsJrrPuXytfz+YopC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqmYIC2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE029C4CEF0;
	Thu, 10 Jul 2025 03:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752118572;
	bh=mpUMB0zy8d4IkeeacZr5LroYN19aKGV0mgmO87Hknc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MqmYIC2TvUl5cqXOetMbnAjWs3Jty+0b+VeS3iOpYlas7PKaDOMS9frp39TLXrFig
	 iCiTYJCYoJFi02Mzgv85Lo9di/0EUJ4dppZ0DaOTDxAXzZC60zrQm1TI9ZB5HfD0V5
	 UimsrqSDtPlqCRPMiC56sXkGkxeXAfjYFImyPm1uuh97gV8l6APP5W+XpiMhvRcMeL
	 uhk7mtCiipM3/qmC72yv+5poROjyNj/iOgV+aTrak1IZXverHozEaxWQFQw0dn9d3+
	 IRstQ2zuRCRGYT7XR3ggBorJbsdpc4+KSqjcejvVSftPbFGStHbsU5wy1f8I8MIshT
	 CXsfsKIramVYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B3CC83F15;
	Thu, 10 Jul 2025 03:36:11 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Date: Thu, 10 Jul 2025 11:35:38 +0800
Subject: [PATCH v5 2/6] dt-bindings: clock: axg-audio: Add mclk and sclk
 pad clock ids
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-audio_drvier-v5-2-d4155f1e7464@amlogic.com>
References: <20250710-audio_drvier-v5-0-d4155f1e7464@amlogic.com>
In-Reply-To: <20250710-audio_drvier-v5-0-d4155f1e7464@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com, 
 jiebing chen <jiebing.chen@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752118569; l=1242;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=IyTHVLGWO5xe9zBV3oLCL3jIvL/ZzNRNr/wMbGfHF7Q=;
 b=wLH8mhxBd9/NHwiDozn4mbXi1/wluasl2S2512oRM2xJvxwZrYsNQAvd251pRYetBh4ZvD67A
 uwwz2NjZuy5C8i3KK3aVOwBADF8/XT+nypbpGtcMPdTlWG7RoZtH5Fd
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

From: jiebing chen <jiebing.chen@amlogic.com>

Add clock ID definitions for the MCLK pads on S4 SoCs.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jiebing Chen <jiebing.chen@amlogic.com>
---
 include/dt-bindings/clock/axg-audio-clkc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
index 607f23b83fa7287fe0403682ebf827e2df26a1ce..75dde05343d1fa74304ee21c9ec0541a8f51b15e 100644
--- a/include/dt-bindings/clock/axg-audio-clkc.h
+++ b/include/dt-bindings/clock/axg-audio-clkc.h
@@ -162,5 +162,16 @@
 #define AUD_CLKID_EARCRX_DMAC_SEL	182
 #define AUD_CLKID_EARCRX_DMAC_DIV	183
 #define AUD_CLKID_EARCRX_DMAC		184
+#define AUD_CLKID_TDM_MCLK_PAD0_SEL     185
+#define AUD_CLKID_TDM_MCLK_PAD1_SEL     186
+#define AUD_CLKID_TDM_MCLK_PAD0_DIV     187
+#define AUD_CLKID_TDM_MCLK_PAD1_DIV     188
+#define AUD_CLKID_TDM_MCLK_PAD2         189
+#define AUD_CLKID_TDM_MCLK_PAD2_SEL     190
+#define AUD_CLKID_TDM_MCLK_PAD2_DIV     191
+#define AUD_CLKID_TDM_SCLK_PAD3		192
+#define AUD_CLKID_TDM_SCLK_PAD4		193
+#define AUD_CLKID_TDM_LRCLK_PAD3	194
+#define AUD_CLKID_TDM_LRCLK_PAD4	195
 
 #endif /* __AXG_AUDIO_CLKC_BINDINGS_H */

-- 
2.43.0



