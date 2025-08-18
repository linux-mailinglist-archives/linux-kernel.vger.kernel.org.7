Return-Path: <linux-kernel+bounces-773298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00521B29DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61293B84B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1895230E843;
	Mon, 18 Aug 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="bP130bh1"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082C220687;
	Mon, 18 Aug 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509349; cv=none; b=VQ/mioH32DF4eArL2hPI+ZnbInJ/y3zGe6i7BCij37xR2QDtaCgPEV42aMXW4aAb0Dr3Z0zC1N/YYEl3I6OjlhR6cyZumHYgqw3MPwQv9us2naoS/YZbLUIhS54gxe3bmcp+nJ1UyNGwtTtUuE/OlZBjy+srlMGDcEmq/WSJXEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509349; c=relaxed/simple;
	bh=/hJv0mzHXIS6bEs1DcXOmRFXRROo56LNrivXaAlRwYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B/LCi4gi26bd9klP0N6XVxRhbpV0Ys3k8Cc6IfFotZXVGPrQplrrgKj59a14/zvWbC4E/d9FRB96dyHLmQmV0reLgmNljF3Q72juyV4CiNB++mmuCruZ4mR0tKHzIflViXup8PllXXxTDLDjyN+3V3qrtKUiwnqkZ5RQRCAyF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=bP130bh1; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755509320;
	bh=SK3FakjrDopXlK4b5FMuZJRoz8l5i/5MUhXQJMfoKCo=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=bP130bh1M4cf2F50uTkxyZa+hsCNY6ClaNJneQ1wUof6VDX8mn8NDD/FbWYyCOrTs
	 +rRX/ua++DLTLnYsFpoAvg7BKJmt2tDGNoVJzxdnd0H6gPwFEInWPPOR6su1AX1oFt
	 OrlcsUm4vaAd/lHRnqhp6COVcupgEa2KafqSqhwg=
X-QQ-mid: esmtpsz21t1755509314tc4b3f005
X-QQ-Originating-IP: L38W9V9/NIsHLDRox8+OFBX7sY7Zm9fj9dMmiK4F+k0=
Received: from = ( [14.123.254.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 17:28:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2456046681612972940
EX-QQ-RecipientCnt: 17
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 18 Aug 2025 17:28:20 +0800
Subject: [PATCH v3 1/3] dt-bindings: clock: spacemit: introduce i2s
 pre-clock to fix i2s clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-k1-clk-i2s-generation-v3-1-8139b22ae709@linux.spacemit.com>
References: <20250818-k1-clk-i2s-generation-v3-0-8139b22ae709@linux.spacemit.com>
In-Reply-To: <20250818-k1-clk-i2s-generation-v3-0-8139b22ae709@linux.spacemit.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jinmei Wei <weijinmei@linux.spacemit.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509307; l=1199;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=/hJv0mzHXIS6bEs1DcXOmRFXRROo56LNrivXaAlRwYY=;
 b=ZtadIMTCPcMoagONLw2fcK0RfQQmIg9zoCpUCUgEN+CJ8bCi+82+iMoYoG1qE3w4cjauBbzxA
 HfHdrwxXtpDAGFvrB4k/veMHhwIUHtM5WEzH7JMVsKAH+BPEXvNtw2Z
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NDTr/OXP+ntDO3t+2bNJzDKugs0wXL//a3Ht0i5JETb+Yr5ToK8R/0BW
	FBOZ2SgfRk9cORHfvHa+ZtDFP6+TRUVGsitpE0SeIMUQlQDGgKlt9j6fsuzJ1DMi8+RZ7mP
	YuYxiaFN7WAdk/RfW2wPfoynOzO/vLtRCfUGZ7a/hBd1WCKf2KRgHm0MVJA2/LLtFh46A8m
	YN+Nl+dLOzJUe0ABxupzogTFIRUwmjMcjkPFnpk5fGzowxOZXkMpyEsUqHwSMMnJcn+95qZ
	O3F5OoFDypwt4AnRe4k/xwVDBpP65PXFhA2oUwpF68kYq9HKEPQl20n1SUqkm6twVJCDWPT
	scELFyV+/H5YUODgfWOSl0uQVgT978gOi8PSGGi4CIB8Rc3htoTPobG1ZVWbJgDRkOnaCmB
	iZvlG4VxODIOIH0yD6U5P/Iv6FUl/mVkiFJbC2/I6gZGNaLFbrNVTnk3wuNvs3KbMIm3O61
	4tTq7/W6gYUaQApeU0wyyjvOld3R4LAS3KIysEMq96cLMwFFyvHbIZHvg/1Gx4CLK+YTmE3
	uXHI9yCmqeOgJ4+MgFYYt90N2dXLdu09rTjWgxTuaIu9ZhhbXl+vvFgVdGdvd+JdVUyo397
	npUBUKIaWOL1Mh+OY8YQsEG8fucZJT/LHerItU67cM2818FMODyHP2y/PlUv3swkzRAD0AF
	DNAd3meVgswyuGVC5W/XQfrfhUukGklWbZCHg9V75YsbEwioRM7YWfSDFSkSl+U+7KfIjWa
	fSi/cKFZZfL0ewsXRNGupTdDjFy7Dvp4fhs+u2ENe4MM7OS3SOe7G6gbBQGhfttYau1mHZt
	xtB6bauoSSzepnBQ52v1tfMU384cHbhSPagJewYN2WdAskGiuG3VJ+8r3KXU9PLizIHEgJr
	1zIGt8VbigfP/AmAgfXjZoz9AMwQI6y3BpWNcJwCdnNOMafFPhfzC5TSPbYOD2BK0QqVuDI
	ylb4mXaVsPcO3E4fu3TaZywkHc71NoTx3vLfm3eaAjE6lDwGL6EtP59fPgDvuqGuOxFqWxT
	WaZyAN8AcEtZjYz2uJ3kHED4DvkngZOEZkHtJYQz3qZQ5azinh2DbiY0m0zjhfJHt/WpEhi
	aVDYIJQaT0dmXZrEsYdg5r0kfBm9EOIb/La8xi5W2D7M05eE3EXMHw=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Previously, the K1 clock driver did not include the parent clocks of
the I2S sysclk.

Introduce pre-clock to fix I2S clock.

Otherwise, the I2S clock may not work as expected.

This patch adds their definitions to allow proper registration
in the driver and usage in the device tree.

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 include/dt-bindings/clock/spacemit,k1-syscon.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
index 2714c3fe66cd5b49e12c8b20689f5b01da36b774..ad62525be43a909633f8d3a65ece1acd60ba8052 100644
--- a/include/dt-bindings/clock/spacemit,k1-syscon.h
+++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
@@ -77,6 +77,10 @@
 #define CLK_I2S_BCLK		30
 #define CLK_APB			31
 #define CLK_WDT_BUS		32
+#define CLK_I2S_153P6		33
+#define CLK_I2S_153P6_BASE	34
+#define CLK_I2S_SYSCLK_SRC	35
+#define CLK_I2S_BCLK_FACTOR	36
 
 /* MPMU resets */
 #define RESET_WDT		0

-- 
2.50.1


