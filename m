Return-Path: <linux-kernel+bounces-752249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21562B172FA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59FE1AA81F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B902D1F61;
	Thu, 31 Jul 2025 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="gFWL7plr"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F082D0C61;
	Thu, 31 Jul 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971287; cv=none; b=Haf2HHRW1ttn9+isUMkH+Ep80Qx3jGA31wYTwnUfCBTOKg+Kl8Jfi7ARqnubSSPmqc3mUrXc2Q6Hw2t0te50fyZzTZK9wJJwbuIoBgYobqr6Ke2oukg7s7Ws1/44/thqJmdPui4r3q4WJLWQvOvArvUUDMBjWlXbKPb3YOsncDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971287; c=relaxed/simple;
	bh=PxJJD5BdYiecz3+HAlAUv0mqXDsb9508pUsTSJAhu14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=koyaexihxAtuY+t4RDlOPfi+/07dRjnzSRPsA7k8OZQVOoBAkGZyHKgUKyXHYVLN3BpSFsYosMi3ZE4vQ433Nz9AppEWYQ3oYNDC0X/ufch8rUhgdNn+hqUJm9bkJU582X8MYWr/FccbqVnNjH4+zZEi56Ld5pFHPr01BY6tjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=gFWL7plr; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1753971261;
	bh=9fCuuegqOgh7yiTp50CPz7MDoO4s4zlMG+vfGbQq2dc=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=gFWL7plr3wIOFLw1USGzJyUvm7wnFPkewap6zTW0pc1SBNGEtQpLTdakfIezYXL15
	 75LVBb8/7x2SKd766hUrWDfBvZbGHtHNJ8JU3EPeOrC9IRnJluO9zuvWTAg6rJl29b
	 //riokJsuE2z1I+vqruFuSp5XOsCiIS/Iaz3iXFE=
X-QQ-mid: zesmtpip3t1753971259t7d3f21f9
X-QQ-Originating-IP: TenTfqs+CfHaj0Vw1Jf1EPSV90Ue4n9Xf6fnQuF3AZg=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 31 Jul 2025 22:14:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 374415705309625813
EX-QQ-RecipientCnt: 15
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 31 Jul 2025 22:14:06 +0800
Subject: [PATCH RESEND v3 1/2] dt-bindings: clock: spacemit:
 CLK_SSPA_I2S_BCLK for SSPA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-k1-clk-i2s-v3-1-2f655ddb0c6f@linux.spacemit.com>
References: <20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com>
In-Reply-To: <20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753971252; l=860;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=PxJJD5BdYiecz3+HAlAUv0mqXDsb9508pUsTSJAhu14=;
 b=Ge8h+yboIYawFvD0VS7n4GY2qkjNPCR43qjJnnuWIBTw2eyDPG73qm8w10ZV32dcGJDPpIJ15
 YosOy8//CGuC+NVKlXUdSsJuSukeWeRDtPKsP1vjXRNsUiFolMgl4/o
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Oe1GmYme0+2vk3NdPxhmASyQGt5TsfJON8kUGihziCv3v929EvsC37P7
	qkmRmR9sMsk+w2Aq7pbpwsdWYZXwIeO9inoCAkdSQKMzh1mJGfucRUlvonUacH69IwKK3sd
	8zoc0eo5HU5Vb9/KRXUqDBclvr99H1zKYlCQMUOnkSvZ2Uq2DKD0QrOhdA17XlfSnN+4o+l
	cfnEZgO8+TaY3VFbRFKmmT+o7OlU6fI4Y+e8oCRG2XI8KvOsdIL6TR5tvvc4uvd6OvlZBCZ
	vz8aPSWhYA+XU1ZQOPsH9yiLyo2J90OGKnScfUSLcdWQWTVTiBUSFNzdJYIoqTKvK7se5fe
	uLCiXO7efuCx6f/DVRzXxv/KL+zsNEKTxxJ/NRdK3NRm1ASlR0mqddhd4jT774zzAConydo
	XTYqjsG8rq3awkeHSKhgCFxxEn9UgftBs+fYKPhEUkgrLqzHMjzoO19HhCkRAdgqD/GdQnX
	83c/VpXBv5GfoJRe5nAfc7ovGsZe71/ruQHmuF10KEIPWHhGaafZORFxS/cuDzkpoIq7YG6
	oTXRO28PyWra3K37sFEbk4tIFPU3ZtBVk/7HnbnzbBSkEONxzLczxvUBa74lTRb6kKgLPdv
	jYFGvSjJ00IfO5vt5/TXttcmnxss9BpK2SDNN/KhmRLwUirAWsUGE7sBM/BUrtXV81qE1HR
	Au6dPv2BOqxoami9KgSxtOCuhG+xxYHXbo1XXloElhbfZZlzda2ykEQKf5DiYiY+dQauW1M
	t6jiJ4OgA5DLrmpEbtnQgqteJfKIe36c2ZwkSqvBdaSFIZz958pUhPoLIQvUtKOvoxu064u
	fLCsqjBnDC1+bUnbxIbGlV3r4ELU2EmjM435q3yDOZuYuwgdv1o5r1QlXbxEqNDvSW0H+SU
	vk9QC8Ay7MR1GLSJNd2ahw46/eGXH/LjlSwkRw3WyOdsXTDXQizna7oWRngQJEXgquvCncM
	vq6mF3WI9gEN+nde7YbuelifUhCk7B5oQzwGurYk0h4lRElR4x5v3jxOEY+Bm3tWdvnOXus
	KQydXBuQTTgWiNnic3T/BTOacv6Aen783tFKHjZOVSGj2RDZIep3WZ1gmGlPfjiYrDonfK4
	1xtSR6kKCNQP9/K6X9IeFvUcCzb3oLGEkKYxTwHuzhh4B+TuJEdC6Y5IzzKUf+3YpdjklOE
	H7v8
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

In order to use the virtual clock SSPAx_I2S_BCLK in the device tree and
register it in the driver, this patch introduces the macro definition.

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


