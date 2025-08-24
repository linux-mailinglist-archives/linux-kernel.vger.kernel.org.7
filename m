Return-Path: <linux-kernel+bounces-783496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC344B32E50
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A838F1B64B95
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F84271448;
	Sun, 24 Aug 2025 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="GKbwYKEp"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED126B760;
	Sun, 24 Aug 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024852; cv=none; b=aKjt8tT7iqUvbh4iVXcn6IriiwKFy7t5xazkELlok8y+3vQ6waJkzhlwN9Fy8o4zoQS3z/KOuwd5KAuXpkCrF3OHtx1iGG1qKfEt+HoPzaeJ/JAPERZ3z2AEUaDgWMaf1C4kWu0CEaUCftTtt3XvgxstRY4JaImxMSmhfq3OPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024852; c=relaxed/simple;
	bh=v/t1aI3aNag38Iw54UrTz56l99+UEE1QCM7Cs9uZPv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aklbzH9ZilaNtX3uemHZ2uIp0Ez00jAn+Par16CoL6bMmbCg8ojhRCj+6TdOlxOzsXPGPAYBhqphlkSdlRv5H5ctNXmK9DnHGNcc6r+EkkaNFtC/eGDjVXCH13WNdgW0szKi2aFMrcYJ4GpFGljSd9X7JDsZJVtyQgFbEaIMhFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=GKbwYKEp; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1756024831;
	bh=uIeFRp7srlfzTl3qg/h25R18H1T9HniV32V3H37+zLo=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=GKbwYKEpik6QLJbcHuSWJhkX1LzKHnBobBPBQFIfpjiwLqMjUfFbcqMR/454lbGj5
	 j3SCkajM4TPrpi91c97NsquZxLSjorr2/MA3LljLTt9DfTQ+LS7Hk1eC5oqHUPmYIE
	 q0iPc3HRl7Tdsnt/++RAIE+VWVvAtYNq02nr2fOI=
X-QQ-mid: zesmtpip4t1756024829ta2e03abb
X-QQ-Originating-IP: R+FEK3RJ0uU9/B5/5AD3L4JnXkWhDGlpkAywfX6XE6s=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 24 Aug 2025 16:40:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17996591963032369533
EX-QQ-RecipientCnt: 15
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Sun, 24 Aug 2025 16:40:00 +0800
Subject: [PATCH RESEND v5 1/2] dt-bindings: clock: spacemit:
 CLK_SSPA_I2S_BCLK for SSPA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-k1-clk-i2s-v5-1-217b6b7cea06@linux.spacemit.com>
References: <20250824-k1-clk-i2s-v5-0-217b6b7cea06@linux.spacemit.com>
In-Reply-To: <20250824-k1-clk-i2s-v5-0-217b6b7cea06@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756024814; l=987;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=v/t1aI3aNag38Iw54UrTz56l99+UEE1QCM7Cs9uZPv4=;
 b=iONwEIHlXVoixiSORjJxTfn/gRA3ySjVcx44485CZagW2P+78goqG1fL/Z+oleVAPbN/wYGb2
 RQryHUz9mJjBnXwhtDnWU94+xGj896RrrhljBPr/wCbDoUstkk/2IWX
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MWzGDmnScki3k3C5VIVHaDBd8z4Roju4+0neCTSnYOxzh9F3UIJVkRW7
	vbNS57Rn+P6EcKYl1wMCksANQzKMZtZ7Ogsjr3wfaS2Wp/UH+9xJtc51Y7O/g5Kt5r7bNpf
	kG04qQiJdNBRzvXTLTndAIXxALEb7mcO1/2eL0M79UCuQu0rDRUbbkLm8EA1Z1WzSKFSwlf
	j9TDqZViB3pEerwDDIVNRUhgtKl6UpSe8X0cbI0c7Xb1oQgBeEql5XxJzVf8UXg0jkShZMO
	Cq+bnC4BeCfwxux/FehkKkC9etkHyrt9Ay4QjhdYQ0JhriCK060bbzGb2E0GjOnFeo1fYFy
	069xZ82vns/DfyroYIZv2wtVFIktA9lxvLXJgWbTODwJkfdv6SqqVOIAq0bPVY7M8Ej0btQ
	mhLz7A7xVwfOH+ldGk7cxiIeuLs5ppefKzYT+IFbc4sl4kcUJnZ9NPa8zRLhgFmxAwQqObH
	jgwTUy7b+2moPpLhM3RhAmyj/lUtt9YyHOwnIKE+tlOhp6Xh2uX83VfyNBtpvRE4VUU+WL0
	W2rm/USXdStM32e5pu5poXVNmVfqIwfK2hdffPTaoJB8e/Q5fRw1xQmQIhLnbkyFt3JkDO8
	qivqhVKgunAj5FG8I/FuzoSs9fUz8HTmVjlZM2IhNjv0w/rT7cIyM4U/njgeAP0DIk6iWce
	IMr/5sz79vfm5AiHh2nZdRpeJklGRxULJyWwIBQC1t3iZzlmyt8JCLBAQDOISHsOtjsiB4D
	3jdTvmA63mLbDDyHyZPhCpSzs7scFWCxEcBKPkv8EtJFc9VZtdhvyNwQeQ3offQCnEFdYAp
	sivDEIHgmgYXc+qE0y5TBQXL4tR7tQhX+dNN97bFvVPVRgekpnxrW3UKA2ps4MQKonXg8YN
	A2WfOm6k2XZUsH7F8lllU2QoI5C9uXkhV3uemraTVX8msZsYADSjSWT4uDunA6RDFMSCvnX
	XHZxiwV5EfxAcTopjhp3eG3t82WSU+UVzQEChY6Y+LJ6RngOf29PINzhIm+dGdPSm1qYWYL
	zLVmpD6qNzJmxPygSy+C2HREFiQ4nXTPP9tGI8MlJxmSIepxMetqJUcFIh3/wGuj594zYsW
	o8DP69ICqdhPrg5TgIHPAU=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

In order to use the virtual clock SSPAx_I2S_BCLK in the device tree and
register it in the driver, this patch introduces the macro definition.

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 include/dt-bindings/clock/spacemit,k1-syscon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
index 2714c3fe66cd5b49e12c8b20689f5b01da36b774..505205453d7f19ad478b3b741d83f4498fcb8c0d 100644
--- a/include/dt-bindings/clock/spacemit,k1-syscon.h
+++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
@@ -182,6 +182,8 @@
 #define CLK_SSPA1_BUS		97
 #define CLK_TSEN_BUS		98
 #define CLK_IPC_AP2AUD_BUS	99
+#define CLK_SSPA0_I2S_BCLK	100
+#define CLK_SSPA1_I2S_BCLK	101
 
 /* APBC resets */
 #define RESET_UART0		0

-- 
2.50.1


