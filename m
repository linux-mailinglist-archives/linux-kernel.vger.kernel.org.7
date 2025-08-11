Return-Path: <linux-kernel+bounces-762747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4BEB20A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BAAA7B0627
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96EE2DE71B;
	Mon, 11 Aug 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="hUUTSkdc"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250A224891;
	Mon, 11 Aug 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919666; cv=none; b=WbwctxBz/Gj44QFkuGGC1K03eZ6C6O1WzkmSLrcWSIkSvuFdiBs5y5z1eY4yukbnR3rRGbSGxcLfGdkFIshUvhpKxNED7WuMzA2CK06uU3QBGR33VGCdvIJvx40Wj2Vr+GElljZppSIFw0ZzdutzhIC5SsHdFTty+bZau8jvTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919666; c=relaxed/simple;
	bh=v/t1aI3aNag38Iw54UrTz56l99+UEE1QCM7Cs9uZPv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c87+014/Bn5vpjRXFh580j2vJ7PI5aeK/fFo+iHu89MaOnlIa8e4y6R0cMJGGpin5xFg1OXBsqdd3nQTRcz8PtmOHRe18fVJ7+59jV3Qns2kh4l506DoFqeJs3NcbqZbao2hmjOcfYPvjnBbMBCk/fnzqBUZC7OIHrPGsx9LoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=hUUTSkdc; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754919644;
	bh=uIeFRp7srlfzTl3qg/h25R18H1T9HniV32V3H37+zLo=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=hUUTSkdcWmto6VZl/4IQ1STJE6sZoBysCOPpgUfi0hLIDk+V0AchTkPHlvj+kH8Cx
	 TUaFmvhtXdUFXP8PO9OELVlmWLT09dRmFJsORkTjDk94CsZNywuTvhFxAEVmK6OoCn
	 0QtgBb3gBirg0TuNc2eZO0YEBVHgykRW75fP0IG0=
X-QQ-mid: zesmtpip2t1754919642t9229f5a3
X-QQ-Originating-IP: oT9x3PC+R3Dfu0OvSz9rCuURNF5kYhPnlXD/FgPgQj8=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 21:40:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16647974151986818985
EX-QQ-RecipientCnt: 15
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 11 Aug 2025 21:40:33 +0800
Subject: [PATCH v5 1/2] dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK for
 SSPA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-k1-clk-i2s-v5-1-ebadd06e1e91@linux.spacemit.com>
References: <20250811-k1-clk-i2s-v5-0-ebadd06e1e91@linux.spacemit.com>
In-Reply-To: <20250811-k1-clk-i2s-v5-0-ebadd06e1e91@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754919637; l=987;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=v/t1aI3aNag38Iw54UrTz56l99+UEE1QCM7Cs9uZPv4=;
 b=XDOHjzDt/8Bwy+RRA8v116qZP150LO1bgNRRsDV6NYYcy/qAG6+L7cLb3aW4R559pub1Hb7ok
 nlF5AxmwrioC0C/xmLN3pELovIUov390m2CXwboOprAQ2UzgmR+JCYe
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MUZU+Zjxo+2H/SviOkQOyUABZ8qb/vbRbhid4lB2ZFMLswzPopA0lOmR
	W2rcRB5g+RXNmN/ew5iEs7tLDVj6yLV4hdLBtntTGK0m3xQ77kxFvgUlCO3Occd2snx+OaP
	9Q6pWmwAjpbotp9F11jOQoVPh8K8kg5/tqa9X4vNERNFW8bTpy9k7UPsNgXKemeRRVGx83i
	+bx6bUibw7YFbf/7wPKphIY6Jhpv+esBvhBbE/YmZA3gtgBZPUc3YLnQ1ve7ySHnxewaLb5
	yBtEarcLAIXT1vdvJI29dg9Y58I6oPWOMDpPnwRIVU69U3V0cyjTnHBexztgv74bAzDzhDJ
	sogDgHZhVALeFrJySDss3m6Nd6mXuOJZoakCQeBh2SvCR4vgqmVv8y4xZSCIy+dprDfKgur
	KhlqD0XPIdzGhmNi9ExRTJEMDq1TIJjpJLxadzqNss186N6OzXCUJOxjekKcGEN73TcYmzk
	B4hS0FYSoqbAkOveAWDUMDMd3tPhz2J6YZcEKmm9E5+I0eiX3I9h2Hjv2U5wHVEIRSmdQuG
	YeAG/VLELXLW8gSWoeF3Y6bbYHMHzkqiZ9aijnha+NSVUGf/8vlu990/IWa8bjYQQvP7pR/
	IiQDNL4iO6mlO6NiwbsMwBiLJ5AFyKurXvsH/vqZFB399wopmeTdLDSsMk7/aPsyFGctL/Z
	cTh+DgwVZL2I6NYPsAEA/tyxp93nKI3KqMVNkyNvaDt7ZK6aQRHhQze6EmQssDKTdVtFQuX
	kX6i9eaF6vXb/99oe+RqamE1HuN0Uw3W+3EqYumZdLGtOts9QGc7ak8YYqFzw2jheXsxzfi
	uL6DSWOABi/juG5I+NzFkKPo4lF6EoNagRHQpFVyDKFzlem3D6HUTUmkEwX6JEc1k+Q7E81
	iqGaTZ990ZI8V+Cjbn1qIYWo12dVFSJ4GM0jDS2HzaKcvxsJfMIj3kPo4RjekK2snrcVmZe
	cVPOcZWcqhMacm6HuOi1nq8M2c7AGnnLtNrEp3w9/rqo867oHgTZLEN8SK0ZtGK/OhA9pAm
	8KhyxowPvC81gNqmrXIkSc9wVeh8f1yz6EPUqW13rKVAf0q2Cp/AMf0iI+H7a6M+arLRTmg
	VIamivBPbTP7rM7HN2CH/E=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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


