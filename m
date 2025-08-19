Return-Path: <linux-kernel+bounces-774705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E66DB2B65D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4C31B63D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D31246769;
	Tue, 19 Aug 2025 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="LgYiPgTl"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A841F416B;
	Tue, 19 Aug 2025 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567363; cv=none; b=pBoLZy8D4hSBcHSpMwinFzBYtYzVgCH7URQXGZvn41Bj/7u+isGOg0Dp3ddsvl3oCVHdYCfZc8pIbCjzyhLvbUCPRnZpu6WneR3BlaaGMUjWTqPU5xUTBT9o+sd4lxGcSfCU1Vxg6w60dggpgjoMwjM+Iavt4pZXF8g6opBMUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567363; c=relaxed/simple;
	bh=/hJv0mzHXIS6bEs1DcXOmRFXRROo56LNrivXaAlRwYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VppVspq4IDEABiv0nEiRNXnBlT5/rt1PNojWnxAIYRx1aaxGe2J2GozQNXjKXqCRi3z0reS7D9IYxQvQBe/ZRDOxjHv0NH3s7BGiD276b8GMa7mRpR1rCYJAOlTlos7+FRRwF4ZXYjqAdVy43fFF6mvD9W+JgU9t+7C5mF8Krmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=LgYiPgTl; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755567326;
	bh=SK3FakjrDopXlK4b5FMuZJRoz8l5i/5MUhXQJMfoKCo=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=LgYiPgTlN03SYxiLsZ7lLzwWKcAOkTNw1U8hM5WlQhODZlCAUTPpMK9OVXYdpfqe9
	 URiGNBiL4c03FgzA2FJo8ILcUqeUIo6LwOZlp0y0TvLRszhtYkmnrmYcMOyYvFeT6L
	 XFBYemz/x6uY70qNKhL3QlLVt/yo6z1uAMoozWSg=
X-QQ-mid: zesmtpsz8t1755567320t10858b5e
X-QQ-Originating-IP: 2YKpn87vCa46PGfFmKGjP3sxuCDc0QCYQ4bnMNTeHms=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Aug 2025 09:35:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6033226300495281637
EX-QQ-RecipientCnt: 17
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Tue, 19 Aug 2025 09:35:09 +0800
Subject: [PATCH v4 1/3] dt-bindings: clock: spacemit: introduce i2s
 pre-clock to fix i2s clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-k1-clk-i2s-generation-v4-1-80174edd04eb@linux.spacemit.com>
References: <20250819-k1-clk-i2s-generation-v4-0-80174edd04eb@linux.spacemit.com>
In-Reply-To: <20250819-k1-clk-i2s-generation-v4-0-80174edd04eb@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755567312; l=1199;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=/hJv0mzHXIS6bEs1DcXOmRFXRROo56LNrivXaAlRwYY=;
 b=lxfwkInvVlzITCkxhNZsnwfYrvWEuKp82wNatT2pHJ7c2Na1nYQNMachZD/QUYBYCbYyqzu5t
 TOYFEJc7KhJDompSouwpMPXpIEMdM3C5qrjPrUfhqOAkdSE1S584k4/
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NyqxpP01dmH56y/keP2ITShVG99cGlVLdkQlyTyMZSG3yUZpfj7U72Aq
	NBtY+7yzzpNxCErLVZvYzhHGUQ3Sc//pLehFgKcrDl+157sAEEH4v6IYejGfteshfpcEOyn
	7eTDJCFm2IHMH0WgZkUe09gvcuw2j7sG86fsoWm7yt2TTDwFnAIfSvpdgazLyp4sKq244AY
	hxn4B5rdCGgqpGfa9tVFqicqpxcCfrFAoDAORB/77Se3T4nlL3yNbhUhvhzK8CUfqRT4ftK
	n63Fg5hYRexVpXdaNT80HXe3PJohDUORz5RyXJXXZuMN+BhdH9W7Bhco5eHtupqDNXl3e2L
	TEBNJLd3ujdy1TIR7SiKe/FkI18/tCJPrTj7QFjRzUT6vTYzb+hQtEEoQYNkWvEzFfWMqTe
	UoMmfrM8cN5YowXzuS8ybssCRD6In/owVyGdiHjgofvqto4Mofp93uVchTSBxsJHwRA/e6M
	9DCKOw2ash4/0V8Dbmz8xtLuSR7JwvgvEKIzhIt9U922UX9qD7k6nzCOKpSaq8wNDDrEsjH
	ZizJwbCbFksvM5R/+grGrGw0bCa1KKwdC1LO5jUqW/8Gdxjt9z3+b05sBSI9oBRTQwPh1jp
	7e4lD+KMhRSN4WjJ/1hMN0HhKT0qmsZ0Og1O8aGUcwjjRU+GJes0VyOeTY8GIquaainf8b7
	DeEJKP6vpN9iv7PC58Hr4x6xU65dwx97l2ZS1M3gnl8L0oE6UtsgttXaK+mJJr6Vl+giGU2
	GNc4DwfNFkUxTnJLqBZwLwS5KsA8Y0tSJmYT38TnAbBzNhViKNkRTV7WYrCMvY0HJUF65fj
	EZ4dKNSPuz3GxA/butj7PJJTwnH4A7UXVbu2qCrIiy0Fq6zXcCBJfKeRzHINyqnJkRm937M
	ydUqIq0qD9NqJWa/gXQ/NR3MmcNPSf//7QH/CZdz1mhq6odPL4l/4rFWMOXwG35ELF8rK73
	wY6MdPbB1YrrhO7Z33FFPl2POo7cnZpxlQwlFhj7YwuYmeo4AzajEJQJUBLUY+m4fM4gMcp
	/xgiqrtiSOYu/O8WC+Mi20XuUU8QFP4GgV+BtetRBXFKy3HkpaDFJi6mQFhDYLhn+QQ1ea6
	TC1df4h6ilYxgeU/tCVChEmfq32LOCYY2H1Bj1kOl/rzDK7cua9xKw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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



