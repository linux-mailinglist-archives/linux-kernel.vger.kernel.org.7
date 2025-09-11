Return-Path: <linux-kernel+bounces-811292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1AB5270F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0B71887A25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B20236453;
	Thu, 11 Sep 2025 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="uamyh68U"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB51E32B7;
	Thu, 11 Sep 2025 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757561685; cv=none; b=CPvROzY/mLz50y+CppDTvXrKRxapdN+2I6R9pmr3tXAQS4ijofCoJCN6H909ojow8uNCIel7k2JJwnkRHmoaW9Z9ITLiCASLiXAR5/fExWHDKBZ2sxdQ7GvxQUERYEXYE3EMpLK//jyS1yotVMMDd0JC7qPaPUkLDUD8SRvUQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757561685; c=relaxed/simple;
	bh=MpbEVQJf2AVIQqx//peGNwuMBg67BNUIUbJjcb88MlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhQbABsYiqenAVFltYMDGSgPOLdBK7D2jQfId4bCySDU/ILvywyjnkLKfiNiahVVuBFVspcUN6gcnFOcx98BQf/v72PUPaLGnUnOnJyhl7FJieK8iX9alwY84iKH/ZvAGYp/0ivk6PUGHM4ddkoNZrwRcj8d3Ve1brICL3q9a90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=uamyh68U; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1757561658;
	bh=x5heRWWxoAFSgKGfAwL+UUBZ/SH0X/KEucfW1kCohLA=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=uamyh68UQ/9WAQV9iNwgdFN/LsAbqDpixCYYuoJBF5qR3992SK9DtLI98ubMexCZn
	 mhSUIN+wumvONt9QJqKBSWbfjrYv8pd6JCpDSGOGif4wUEWY3Q8HwngIXy7TCgjcgU
	 8UMIPhMA6UiFDh8NOYRcHwHFo6Lz8Do46BvD/1g8=
X-QQ-mid: zesmtpsz2t1757561652t4b838e95
X-QQ-Originating-IP: Qp+B9ePOiwoUsGLiwQOkSRppr9ndituH0TM+4FnkRBk=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Sep 2025 11:34:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7849737783869679119
EX-QQ-RecipientCnt: 17
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 11 Sep 2025 11:34:03 +0800
Subject: [PATCH RESEND v4 1/3] dt-bindings: clock: spacemit: introduce i2s
 pre-clock to fix i2s clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-k1-clk-i2s-generation-v4-1-cba204a50d48@linux.spacemit.com>
References: <20250911-k1-clk-i2s-generation-v4-0-cba204a50d48@linux.spacemit.com>
In-Reply-To: <20250911-k1-clk-i2s-generation-v4-0-cba204a50d48@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757561644; l=1199;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=MpbEVQJf2AVIQqx//peGNwuMBg67BNUIUbJjcb88MlM=;
 b=rJtTCJbkHV68WSAj3AA4O5N9sWEvL4JzfqV7QHzEt3JilpuSsg+tpZqj+UenUr0AyzvQgMkO6
 HNOIIvHjIjpBSk9zDm9JO2k2vzfrzJXoYpVw5iCFRcHahAINTOG96fL
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NlLEkF+Y0lKeL/hQmrPt4bSLqDk2TPGNwHxxeLywOQxe1R4utBs+fIiQ
	rkb2n1f6hM26Jate3I0lHpP6hwjLTvtV9r2sgD7uBv7z25Sw1MvDXrD8FXkLKOnti4bzBrl
	aHx946kaOZdirXoOAWf3GOCtE+2ue2nEw3g38M9aU3LnM9EZ5/apnCDpiUH9nbmvcc69r9Z
	lVO47KAaVa6JWqj3KZnTV6kSH5voQBAuAnhBXGYZn2B7Ti5MpW8GUbV0pqmZmuDhD3xODc5
	pkAsM5gjfK8M+Z5cfbdg+pI538x/sO5G93qB02yJcQVAb/FX34omltD4Y1v7M0JUQvrMto+
	lFnZ3RYS28QzNVrMftXG/qjZimMP18MZsALlCh/kKwOfFHRRZJ6CMqkQGiJ/JFxRiG9X4vg
	j8o0jD0MYUmkCZltWUqRKz0MhSE0dpYbFEJ7zaeasW94rwbLHDAw/2gzRAV7sD294t1kLG9
	BukFm+9r/PpFsZ2wHLvxh9UBbqY/9RfU3zMIa5rAKQyvNvq3ogs4BbL7eP7Tm39gA9aCZve
	tcj30Wnngjo94gQ/LXEbdn1B9b1tAfADaykDAjoLFLr3l3w4qwYtis9wWIcQw22ey5Uww0O
	BN15Yi+6e6LODM8N3zDcOhyvCQO0towpEv286IeRBpyfJcSnEUiHz7Er5bqyRUDYsIikTpt
	hoF3yTy6SMgfNaHbk5M0NcygRoRMTIOg+uitFjtNiNkxrfSVx+mfeRheJlzNXJjuwh70UET
	AzO6DIcw8Fm68hk28P9RlPZ408tnq94ECkqTeFQNl2p71PZgc+k3dulfNgtuAJ0Dr6UalRl
	lOk/fT3SQYyUS6MDR7nbieTrWdRSt5VokVZwXiPnjE4e/ph4zEZxci50/uonPB0NhjQpzo0
	fbGU85URd7UEvmZWZUyrhsNlglYcQUsH268+wUDcVrcsd/fFAHdSWVfcLio9Ncki5FiBo1J
	qIYv5e/0O7hzLKQ6sd9en/IRnUQhOYDX8vejZB1wTPvwpAd73gN50hOjAYILcsN1ivIw8qO
	d54oF4TBRTB6bpLugx+WrDnY4n8TLrA0Sz6aqMgfgGP0rMIZlc8GXjeNC0ubF8KaZ9Y84S4
	Q5f0CvdrvyOGwUn0MX8CHjKMWAF3nbtxe0MN+8cg84J
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
2.51.0



