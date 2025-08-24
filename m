Return-Path: <linux-kernel+bounces-783493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EACB32E4C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91EF1B288AD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3238426B2AD;
	Sun, 24 Aug 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="wW8HgERh"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9C25B692;
	Sun, 24 Aug 2025 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024847; cv=none; b=ExvO309Vt/gAk/qds772CyPh41Qs0exlEAZQ2uupuY40IeFIchfVVrXFLk4mv+bwSe0A3jtlY6y9vj7C2Ur3XbDK5CfTI2MbQRxOJJztlFwU3F5/9AFGDL5Yeix3oJ/wKaO0PRREU0Rc87Fm7xLGV1/F/1UKpn2gRNLfHyA1JBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024847; c=relaxed/simple;
	bh=ZUrL1GUtAJCNKt2pUUAfCSXGuuvKhhmY6ZNaHjLFvb8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z5N0QTy8uKE7NCdbxCyAIyjMON9cBS8BsGGtDCKVZwBT+sZznVlz/6JACVPEEr/OE8Ev2SuLj3rlEzv2ossiccDTIFKwsIITaECcuXEQgnAfTNDLucUMs4S+5+7gajF3N2akiZBAU4wx0faYf1iD2gip2DS9gBPw989iOoJgleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=wW8HgERh; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1756024825;
	bh=O7QkqLL1Uz4POVfUWaVHKWCebfO78hHJLlMwMJBxzhk=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=wW8HgERhgh9HtdqJPr+g240VO7nCNqy+PGwe60d4YG5AiXaSdn/L0I9kss+AajgDf
	 dyZ1SsUpHns7sI1nCwsDVAygLfb9QA4fDhhi1y7+xUxTPamk8b3MVfpwC2dJE8Zpix
	 c3MQ2XaOnKYryumMvZVXtiddClTody8VA7/cwmCQ=
X-QQ-mid: zesmtpip2t1756024819t4c5e839e
X-QQ-Originating-IP: upKO0L+yIpZXn8455s8h5c8yHNVZ/SB8e48qzQtjrRI=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 24 Aug 2025 16:40:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4970945692771033576
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH RESEND v5 0/2] clk: spacemit: fix sspax_clk
Date: Sun, 24 Aug 2025 16:39:59 +0800
Message-Id: <20250824-k1-clk-i2s-v5-0-217b6b7cea06@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN/PqmgC/3XPsa7CMAwF0F9BmQlKXNy0TAywMsCIGNrEAQtoU
 QMVCPXfifr0BAgYbeueK99FoIYpiMngLhpqOXBdxQGHA2F3RbUlyS7OAhSgMtrIvZb2sJcMQdI
 YDHjtc42liIFTQ56vPbYWy/lqvpiJTdzvOJzr5tZ3tNBf/ziAV64FqST4jJynxBXleHrg6nIdh
 VNh6cjnka2Pvdcmr0b2ZiTRQGfQ5F4BgPlmDP/fSfRHFnyK6FypbOp/9uOzP9PvBkaDysI5lZK
 mXH81uq57AAupCF95AQAA
X-Change-ID: 20250717-k1-clk-i2s-e4272f1f915b
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Yao Zi <ziyao@disroot.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756024814; l=2110;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=ZUrL1GUtAJCNKt2pUUAfCSXGuuvKhhmY6ZNaHjLFvb8=;
 b=0UsnuH+nwaZtbx9QBe9ToLPKe7brpz7gls5WfkZlfGM3b1yjiv6asuooZN47hWHhRp0wERvOe
 IKXR/VWBmYGCO9gUUUT3UiqKkLP9fPQ+Y0N0WCghE+fLOdxN5ur3mPA
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NUAR720uS3BXN31/TXGTQ51lxQJ4YOQ57YCzFslEax+BnPsuonG+YqG9
	rfisgnGGGkgO8oqzKAPwpocj4ksTktScZUDb7Unlw791URqqZNvOKFBQATcXa5ZpUJfBYY0
	ffEW38zs7Q5PCLOl4Qml2ksLfPh0wZQnwaZO0gWgyJWatAlRNpuwaN99kCdcSZOiL10DjYe
	f5Y3zwJmGaTtseSRkfUSDG3oAcig32+i5zPETfX1oU9HHwSbaEDXhaVLK5mmTUihGfbW3G+
	wzxli2L4UpqYZwZz2pKUfJDGk/UcLWEoIDne0XlImM5R03D1uciXndMl8go22OUVHbnWldk
	aifuj4GPYVwCy/XLdUgFBRB8irklzM2T/I/zFowzneomwDGFd8f5XRUWvlBR8jPJXyiCcWN
	z52gCpq9Tj8g2deFb0eO6aiXAjhGgxC0uguKPOZaVo7w+Gt35sGT9sSaE9ky97VHJenZu4s
	8/MZIIaXiZLTWbl+pbuJ01j8i7HQ1d0125/ConMms3bZAnZ9megkfWd8AinVe8Z5jCC32kh
	GMtxiNj26TKipmwqhdjs1IvQdnF3XzvvMlddLZekuMxchiPAdhHfLF7LbLlvPNe9GsooCVb
	3I6HR9Ok0OqujdkmYBWGHzuEMEV3VNoITEQhovoOy9Z2y1EPWxgeyZ8TLApGoWhTHSBU2VO
	fXReYRR6Gr4YghpnAIFsAzRX2tgwmU8i1pe3sEvc6dHZroMGXwviBPwNrhcucCPJ7jCA+8T
	n7gEMaxxex33fucUKlHfIkhj+9cYJtklbYSK4TCEzlk9dD1IuTPlfpVSJ8an70B60g5diZE
	4r73isUOVonuAVLKrH6uofMhEUvagRxnXjhzPFLNQRTJ8JFsq/U3dcQa8xGSxuZmJLYq9h5
	xTPrtqySIqh1GitA2DPm54tlYBxE+RxGqTaf4wO/EnIIJ9WF/6aXhyO78Sq56sKbcwYIoc2
	DaEFsizl0/tyCzW0aoMSVPLBeviOTU7Z2glEChwGLlZ4zK8GLdWPfcfa2GXfE0rg2dH/KYw
	E1isZag/jdfe450s5WiT+YYqloadjUh8eQhzg/2a5P91D3Vz8seBVxbTw20qiO0tW24jOLt
	QXBcJ3udYKooaqMRqQbiG6PsqD7oMlw22How+H5QlYpufa7N4uNLPc=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

In the SpacemiT public document, when the FNCLKSEL field of
the APBC_SSPAX_CLK_RST register is 7 (3'b111),
which is a reserved value. And BIT3 of the same register is
a reserved bit.

But the documentation is incorrect. In reality, the value 7 (3'b111)
of FNCLKSEL is not reserved. Instead, it indicates that i2s_bclk is
selected as the parent clock. Similarly, bit 3 is not reserved either.
When FNCLKSEL is set to 7, bit 3 determines whether i2s_bclk is actually
enabled as the parent clock.

In all other cases (i.e., when FNCLKSEL is not 7), bit 3 has no effect.

Importantly, whenever FNCLKSEL is set to 7, bit 3 must also be set to 1,
otherwise the selection of i2s_bclk becomes invalid.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
btw, the public documentation for the k1 clock has been updated.
---
Changes in v5:
  - move fixes tag from cover-letter to patch1/2 and patch2/2
  - modify commit messages
  - Link to v3: https://lore.kernel.org/r/20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com

Changes in v4:
  - add comments
  - add tags
  - Link to v3: https://lore.kernel.org/r/20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com

Changes in v3:
  - Fixing ABI-breaking behavior
  - Modify commit msgs
  - Link to v2: https://lore.kernel.org/r/20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com

Changes in v2:
  - Use virtual gate instead of new function for sspa
  - Add Suggested-by tag: Yao Zi
  - Add Fixes tag
  - Link to v1: https://lore.kernel.org/all/20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com/

---
Troy Mitchell (2):
      dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK for SSPA
      clk: spacemit: fix sspax_clk

 drivers/clk/spacemit/ccu-k1.c                  | 29 ++++++++++++++++++++++----
 include/dt-bindings/clock/spacemit,k1-syscon.h |  2 ++
 2 files changed, 27 insertions(+), 4 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250717-k1-clk-i2s-e4272f1f915b

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.spacemit.com>


