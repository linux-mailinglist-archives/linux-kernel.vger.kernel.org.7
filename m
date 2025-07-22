Return-Path: <linux-kernel+bounces-740390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE2CB0D388
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6887B4845
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBC02E425B;
	Tue, 22 Jul 2025 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Jd8wLbL1"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E32D3723;
	Tue, 22 Jul 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169848; cv=none; b=TxfJmNzwtv1CdTx/S/IHGJwZ9nvwdoScZzGuHgdxG9e2LLQzor87B8dbGc77K1EIMW+C6kD2TYIiqo+YAW1m8d9w+RjhyJMMJ3bdewQiKaRcR1CfB4rjmXadcZKQXkAlZOzeIZGBPAeBjr9D9Q7XyxLzqkJghCZ48yHVGOb89lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169848; c=relaxed/simple;
	bh=0XUvAvsfHaff6g28QDK8UZbmnijtvMKUzjxWMgcstW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mcqar4ZWU8XMArg25xLO4D3XNby3uTD/2f2H+RM8wJBUGIi0Tk0e2Ws58XVALiLBY1YmdvULUuHW6gkhOhzvmLGeDKvyoo9CwSJigPxJk8r2xrC294JSNCQx+YbnirnJp9oAYA8XHnYAlcuQB5q9sFcjt9cBFMOWgVcZlgkE9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Jd8wLbL1; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1753169831;
	bh=JUyZIy4STLgGKV6n0Rtjh+3mXpolfFOBxvl+rc7sCTw=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=Jd8wLbL1MjJWf5mP2M3KuXPQ2VoHHYxpkeZmWggqptGi4uVAl+p4UQQ7Vb5sdi+kt
	 WwF3QnJ6RhYRPD/aEAk1c2BCe0gH+w5CUl2ma+JqLKoMiN5+HWm335AxYFZJkCtoSb
	 P205E/YUnV8sdx5JLpitd5v9NQthEDUYQOgu/mwg=
X-QQ-mid: esmtpgz14t1753169829t213f62df
X-QQ-Originating-IP: BRDEE0KNGCSRu018HljDnqbQ5/Bkizy8x9JNb6qaSPA=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:37:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1888360680555149108
EX-QQ-RecipientCnt: 15
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Tue, 22 Jul 2025 15:36:31 +0800
Subject: [PATCH v2 2/2] dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK for
 SSPA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-k1-clk-i2s-v2-2-2f8edfe3dab4@linux.spacemit.com>
References: <20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com>
In-Reply-To: <20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753169819; l=3905;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=0XUvAvsfHaff6g28QDK8UZbmnijtvMKUzjxWMgcstW0=;
 b=k5GPBMnuflbw6w5YYY/wSRbxzcKYTo+sAbNQujyR6OtwOjWRfniZlDNr1on6JbxWYRTUA4F5f
 GD09MtbJb+CC1vZ/84afMi0wLhIAFI0yt6fILL4Gv1ss8U3sJb4ccou
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MoZqUia8aYdxJYUWpm9FkMaaL3pC8L7ePcF0YGgHG+PA+oca32o406+H
	RWnDvawZQnyP6zaiui35fGhdFfdCfZ+VEY0SiE+wz/hxI7Ahw6Tz18feGJ7tz6SEVRjveNf
	F5/1OsjIxrs/NCTZT8k44cFP2t1tabV2/VxukinrCU77whqzF17s97nNC6VezXnLJXo9D+2
	sJWO8A1+yUZ0HdDq1BKNIk/A3Yuib1c4jD4GHiHzGa4p2J8eKASxHz+VwA0bmk3yHhH/ke6
	3zQRTdPIkuqx8gEQgOecDj43vgGCWxDEkBlTHzZTalF322kaeqfHKf78I9OSblXSe+SP0p8
	2FtWspUrxl1TEg0LYOU2HvFWs/BjsJrEvvUVQsNRRiVOwwGnqTLjS5FzXc0ZmBhPVZncKDi
	10bCYoLjvs7Iz0w0m92U8DLBk2OA6dV37exv+HiVAwzrpKNwYQMl9+gtJHqCWxw7isJJKrX
	hyv+wJGYtPybB+5M9eeaZHgyc+cTWyK5ulgUv/rtbKRRJXQc4xIm7M8LZSwZnxhPo8qW6f5
	7IL6fa0sUp1BxPLIktvHY8B69L0VcC10D43YV6BSbaWz2cShYaaprlscBdu96AeNib9NiU+
	BepfvJDNDTQxs3sX8F9rHu6WMZP2NAbaMjBTrzSCCKuSFw/U8ixDAhWdeIjcv8GH2UmYGyp
	H9UPvJDVkcnq9XzFQgTTKf4r24QKD7sXCG+Y4P88rnQZWAo8y5DL23h6FZYdK/cNBAa48ck
	c1v0srNioms6Orkl29/yASgCevREZI7HsJ6k0naO0ninArfr2v6QvzzYjWhAHk0jFEgm3wE
	j4y9ZYVT4ynbyMlFvPDAYEnz5GzSkEwYxqp1NL12lrpxBJmaXB1mJ3LY5o4dWfeJ4QNKuhq
	HY78v5Vg/IaRWA0CvS2uYolaGA93NBNObFKHyi4Ez40QUBr/dcmVbb7MfZrj4fH/4s2Jn93
	Pu/n1j90TWF0RRJIuNY08iQJFCvlu7xvA1uuYtxcxit0i2Ok0t0E6/HvSNnSLrqum6QU36p
	Lu3yDRssaDYVANYSsfEv0xYfxLEEGTTZAWeYT18mtT+sSCdWCldjD+u7R8PMBoFKUkk41jw
	lI1/dQfxDxPFsv3XqoM6CE=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

This patch adds macro definitions: SSPAx_I2S_BCLK,
to introduce a dummy gate for i2s_bclk.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 include/dt-bindings/clock/spacemit,k1-syscon.h | 114 +++++++++++++------------
 1 file changed, 58 insertions(+), 56 deletions(-)

diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
index 35968ae98246609c889eb4a7d08b4ff7360de53b..6914ccf5be45a1071d5b6eac354cacb67888e00c 100644
--- a/include/dt-bindings/clock/spacemit,k1-syscon.h
+++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
@@ -123,62 +123,64 @@
 #define CLK_TIMERS2		41
 #define CLK_AIB			42
 #define CLK_ONEWIRE		43
-#define CLK_SSPA0		44
-#define CLK_SSPA1		45
-#define CLK_DRO			46
-#define CLK_IR			47
-#define CLK_TSEN		48
-#define CLK_IPC_AP2AUD		49
-#define CLK_CAN0		50
-#define CLK_CAN0_BUS		51
-#define CLK_UART0_BUS		52
-#define CLK_UART2_BUS		53
-#define CLK_UART3_BUS		54
-#define CLK_UART4_BUS		55
-#define CLK_UART5_BUS		56
-#define CLK_UART6_BUS		57
-#define CLK_UART7_BUS		58
-#define CLK_UART8_BUS		59
-#define CLK_UART9_BUS		60
-#define CLK_GPIO_BUS		61
-#define CLK_PWM0_BUS		62
-#define CLK_PWM1_BUS		63
-#define CLK_PWM2_BUS		64
-#define CLK_PWM3_BUS		65
-#define CLK_PWM4_BUS		66
-#define CLK_PWM5_BUS		67
-#define CLK_PWM6_BUS		68
-#define CLK_PWM7_BUS		69
-#define CLK_PWM8_BUS		70
-#define CLK_PWM9_BUS		71
-#define CLK_PWM10_BUS		72
-#define CLK_PWM11_BUS		73
-#define CLK_PWM12_BUS		74
-#define CLK_PWM13_BUS		75
-#define CLK_PWM14_BUS		76
-#define CLK_PWM15_BUS		77
-#define CLK_PWM16_BUS		78
-#define CLK_PWM17_BUS		79
-#define CLK_PWM18_BUS		80
-#define CLK_PWM19_BUS		81
-#define CLK_SSP3_BUS		82
-#define CLK_RTC_BUS		83
-#define CLK_TWSI0_BUS		84
-#define CLK_TWSI1_BUS		85
-#define CLK_TWSI2_BUS		86
-#define CLK_TWSI4_BUS		87
-#define CLK_TWSI5_BUS		88
-#define CLK_TWSI6_BUS		89
-#define CLK_TWSI7_BUS		90
-#define CLK_TWSI8_BUS		91
-#define CLK_TIMERS1_BUS		92
-#define CLK_TIMERS2_BUS		93
-#define CLK_AIB_BUS		94
-#define CLK_ONEWIRE_BUS		95
-#define CLK_SSPA0_BUS		96
-#define CLK_SSPA1_BUS		97
-#define CLK_TSEN_BUS		98
-#define CLK_IPC_AP2AUD_BUS	99
+#define CLK_SSPA0_I2S_BCLK	44
+#define CLK_SSPA1_I2S_BCLK	45
+#define CLK_SSPA0		46
+#define CLK_SSPA1		47
+#define CLK_DRO			48
+#define CLK_IR			49
+#define CLK_TSEN		50
+#define CLK_IPC_AP2AUD		51
+#define CLK_CAN0		52
+#define CLK_CAN0_BUS		53
+#define CLK_UART0_BUS		54
+#define CLK_UART2_BUS		55
+#define CLK_UART3_BUS		56
+#define CLK_UART4_BUS		57
+#define CLK_UART5_BUS		58
+#define CLK_UART6_BUS		59
+#define CLK_UART7_BUS		60
+#define CLK_UART8_BUS		61
+#define CLK_UART9_BUS		62
+#define CLK_GPIO_BUS		63
+#define CLK_PWM0_BUS		64
+#define CLK_PWM1_BUS		65
+#define CLK_PWM2_BUS		66
+#define CLK_PWM3_BUS		67
+#define CLK_PWM4_BUS		68
+#define CLK_PWM5_BUS		69
+#define CLK_PWM6_BUS		70
+#define CLK_PWM7_BUS		71
+#define CLK_PWM8_BUS		72
+#define CLK_PWM9_BUS		73
+#define CLK_PWM10_BUS		74
+#define CLK_PWM11_BUS		75
+#define CLK_PWM12_BUS		76
+#define CLK_PWM13_BUS		77
+#define CLK_PWM14_BUS		78
+#define CLK_PWM15_BUS		79
+#define CLK_PWM16_BUS		80
+#define CLK_PWM17_BUS		81
+#define CLK_PWM18_BUS		82
+#define CLK_PWM19_BUS		83
+#define CLK_SSP3_BUS		84
+#define CLK_RTC_BUS		85
+#define CLK_TWSI0_BUS		86
+#define CLK_TWSI1_BUS		87
+#define CLK_TWSI2_BUS		88
+#define CLK_TWSI4_BUS		89
+#define CLK_TWSI5_BUS		90
+#define CLK_TWSI6_BUS		91
+#define CLK_TWSI7_BUS		92
+#define CLK_TWSI8_BUS		93
+#define CLK_TIMERS1_BUS		94
+#define CLK_TIMERS2_BUS		95
+#define CLK_AIB_BUS		96
+#define CLK_ONEWIRE_BUS		97
+#define CLK_SSPA0_BUS		98
+#define CLK_SSPA1_BUS		99
+#define CLK_TSEN_BUS		100
+#define CLK_IPC_AP2AUD_BUS	101
 
 /* APMU clocks */
 #define CLK_CCI550		0

-- 
2.50.1


