Return-Path: <linux-kernel+bounces-756438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10416B1B3EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE4D1891A69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5B7267AF6;
	Tue,  5 Aug 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="uHEJ1rrp"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B691F19A;
	Tue,  5 Aug 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398918; cv=none; b=nqbGZugD0XmK7J9p31uogWa6PBYVRvINP+8PSrx5J2+YnbKnlRD+FBGLRpiee5UJAKoh6QfPHX/1K5hYQZZ5gO7VGeZgNxzBnDbnAd4/FHP1+caQA+5FXSM2Jwd2lULPeUpqh5Aw1t4kCXNxPkIu7p+ZpBtgXloZoFUc/oUxD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398918; c=relaxed/simple;
	bh=5BkvHDYGZxcrey1OnIOFiDWh/mlgsN57huK66iChlDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTURHsc1RrCFKxZdocQ8tdzwwDgtS08zXnjpIGZ7QxYIRlkOYbCcvrqKLfbIJSNXRGdbEf12vcjDgoBxS0xO/tGt4MF2jBQvMH2ttg1Y+Jl1IW9BlvaKk/VMjW7+0EHtPG+iWGpStXQPp2JsyuM4UuOjKEetjyTnRXJw4VkBsPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=uHEJ1rrp; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754398896;
	bh=FVBPVEeUd1bxjQJhz//RpBXorx7jPTLOEKGvJHJaQ6I=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=uHEJ1rrp8lcFNQEhaZH83d0TGSxh9/MSb2rI3Tk71G4A78BOeZEnlqSzxd8bdC0gl
	 4aI8s8HHr62oWtRKRFX4+EBbzWUp74TfTUR0EDaWVYFaErzExwm6f17+9lZKHHgj9Y
	 Ehg63CRZep78d6sUEKcUIlloLxYs1XprVwDfObZ8=
X-QQ-mid: zesmtpip2t1754398895tfe7aa0dd
X-QQ-Originating-IP: CPpRJvHoFk9wwvAZxLC1CoM7Jc+eYsDtqwv2sfJO/dA=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Aug 2025 21:01:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9963814642751996560
EX-QQ-RecipientCnt: 15
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Tue, 05 Aug 2025 21:01:09 +0800
Subject: [PATCH v4 1/2] dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK for
 SSPA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-k1-clk-i2s-v4-1-038181284dd4@linux.spacemit.com>
References: <20250805-k1-clk-i2s-v4-0-038181284dd4@linux.spacemit.com>
In-Reply-To: <20250805-k1-clk-i2s-v4-0-038181284dd4@linux.spacemit.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754398873; l=907;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=5BkvHDYGZxcrey1OnIOFiDWh/mlgsN57huK66iChlDA=;
 b=SxTtW4MUMwC7dLisiqic3znXA6OPJqUWvrb5W5Pn6+JFG8K/Yh3eUkw2+FCEHT/mEu4vhreEc
 rAhO0DskONhChyvl0uXygnVqsvgGn/ntlTHpow6ebqltPYLSEQ4B0QC
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NaNf4b06WLAJYE2riTHfVtee7rzDHiQpvZJQ1KX3K2Ckt9m3ntLBJ7fX
	j4XLjWgkYORaEBslikgF/c5CYH9ccOobIEKZHxZyyspmCosCdPkg3Zm9zZMSg1J1SGSpCbn
	N8DeePNO4Kj3UFFp+XSrPDAnsaTUNAtuMrdbjc9JPiK7QR8LhugWZ2gzbNOBLS6H6qvc4zl
	V6G9QsP2eOEVOmG4a1W07/xYbW7qNMKsRUXHJ6TKjv4RFdIOM94rzgN0Up1jXpso3XFxjEg
	AB0nZrr1nnDJEtRiobnc8E7xUlmA5yoyDY8xco8VQLqRFWR2iPhkHOunLLQrSiJxQLIDgMQ
	CrumY2uadwFXMLORKDexupj00Fe8rMRfY7QJEsOtz5maK/y0NZUaU7IfIuz/AXbnWaN34uN
	FgYgdlEMTkma4zEwsr8T0K7CXuicHAXbA00E7f3txp4kM7hS448I3gOxlS7sgXTiyCNUsqJ
	QTguwVsgJY+YL0jqryuB1Vifh0XcAUOIpNWvhrownD2RfoxrrfFhem+M5Yb3HPAg+5/TtgN
	NPimnszEhJI+eiRjMeQPbcvT/iXLP/vbIpUZVkQ7p4Q+I9a78Vgh8pMW+BQ8PJNh26czQnt
	4mA6pfvft9R/MATxkwrG1cW3idow0huF/uA+U8CMMv3GuOEsjBZupKN4x7bB/aWqXG+EF7i
	CZgwEmed7+YKPq2J6Dj+jNSWNpnu6ZJhi/faZg8K1yJYbh8kEWFUnN8Jc371y9FRm+kKhJm
	mn1Dq8/aqvIE8qShDHEUQGENJku9+D7DhFLUrOMWrh2HKHgfg1gzwBlOYwpH2svSbBSI+HD
	6/aRUtYHhissNt2hQ5PE7jz/BBTzw4sNtRt5Hr7ze2dPYrWpxAgBdMqRlsE58dBjoPKwPCz
	IJr2MMR5uGpvG0ty/Astx7r/wlfa3g79lhONDlljnwTUVKVNgLRTNQgtEbePE00E/T7ChzU
	y9pF+ijfV8VzU4X6k+ZdvDNWPLGPmFXSmJSik75QyRsXz6rdHgJPgwZHvofwKkZ6+Je6Jtw
	rETLImEZ010dfH5rIVYVuQSmKdg9CYvnFdG3K38khV9awWd0Ml3QLc9Es4hyGgWSTt8MiCK
	pr3nRfbN1+XYZZgRpTRdFMaysO+MmCRaBuOTRG8OzFNZmBOe8J0xgFv//tikN12tQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

In order to use the virtual clock SSPAx_I2S_BCLK in the device tree and
register it in the driver, this patch introduces the macro definition.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 include/dt-bindings/clock/spacemit,k1-syscon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
index 35968ae98246609c889eb4a7d08b4ff7360de53b..9be578953d71e79e93eb10eaa35b47b97812e826 100644
--- a/include/dt-bindings/clock/spacemit,k1-syscon.h
+++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
@@ -179,6 +179,8 @@
 #define CLK_SSPA1_BUS		97
 #define CLK_TSEN_BUS		98
 #define CLK_IPC_AP2AUD_BUS	99
+#define CLK_SSPA0_I2S_BCLK	100
+#define CLK_SSPA1_I2S_BCLK	101
 
 /* APMU clocks */
 #define CLK_CCI550		0

-- 
2.50.0


