Return-Path: <linux-kernel+bounces-887731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D28C38F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959CB1898489
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36C02C0295;
	Thu,  6 Nov 2025 03:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh/0XwzC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F58F7D;
	Thu,  6 Nov 2025 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399747; cv=none; b=krVvl7jDsgssYj+siDVDkFQthQcvXoLJRhauPs6JWrJDImir/JzfIQEU7r1bcLxDLU4auTaUxTPBSlW0YZssl0js0rjfB591L2GlZ9yW/Kh/+/+/1aPNu6b/iyQ/b6H2cQnvBz44qWCx7vlDJqu8V35Vmv2Sfz6E3AtT3NnzQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399747; c=relaxed/simple;
	bh=M0+1u9tcjtZAWeIYRMKAetnt82+eDnNc/pxxjVmeGJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Usos+19bmSderRsk1NZsqg7u+VZNWMAQmgw0e3l70V896D4/QeZ9gsXeNcQksaR+sxnn5FKA91QGLAYuFqypV07RJHahbRHKOKlonB9axgwWWzcaK71ANEGYaxA2y26yOJS9fxXoqIlClGPvig4YnMfdsBjNONvucVHtdgiYwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh/0XwzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55A9DC4CEF5;
	Thu,  6 Nov 2025 03:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762399746;
	bh=M0+1u9tcjtZAWeIYRMKAetnt82+eDnNc/pxxjVmeGJ8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Dh/0XwzCtPCb0+qYPzg7D7KZCE9NvK2+eQz0QYIYPccpP3TpZCVGlWnTBz/kDIP+I
	 VXA59TVihOTPfE3z700wZC8gLk/1MxZF95f8JJ5P+QDe1Wx57NEtOdFUjfv3LCvC7i
	 0ZPVuir+WBdj6jXJk6+bVx7VtydAp/iOWprFEJDYs5PB3gGGhiLfoA6mqpcz/bcX44
	 aT2N+7JDGvi0JyAOVQRqxHpWdUHz5Ivd3N6jaijEBGMbTHl05FbWtL+EfJ9ygVO/fB
	 AXEP0egvtMYYyAwNoPBy0V/NsTw9aJP4WmY7U3MeG1SRw+yi+YFigpA9Vf8jKg+ePZ
	 IR3dpCojZa3Vg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E65ACCF9F8;
	Thu,  6 Nov 2025 03:29:06 +0000 (UTC)
From: Kimi Chen via B4 Relay <devnull+kimi.zy.chen.fii-foxconn.com@kernel.org>
Date: Thu, 06 Nov 2025 11:28:57 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: add gpio line name to io
 expander
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-dts-add-gpio-to-io-expander-v1-1-b4765c092ebe@fii-foxconn.com>
X-B4-Tracking: v=1; b=H4sIAPgVDGkC/x3MMQqAMAxA0atIZgO2WgevIg6hiTVLW1oRQby7x
 eXDW/4DVYpKhaV7oMilVVNsMH0H/qAYBJWbwQ7WGTPMyGdFYsaQNeGZsFXuTJGlIE1+tN7vbia
 CdshFdr3/+7q97weaqovrbQAAAA==
X-Change-ID: 20251106-dts-add-gpio-to-io-expander-a4c32ccf56aa
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, Kimi Chen <kimi.zy.chen@fii-foxconn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762399744; l=1184;
 i=kimi.zy.chen@fii-foxconn.com; s=20251105; h=from:subject:message-id;
 bh=AqtmtuP+jr8hv72i4Nsvgu+5GWsxpYdSguFgfPJMrrg=;
 b=gWTwCX2zWlQlFmQ63qT3cV1Pcm+eKRpXeZgl3/1S5mJQoeNAfaz9EI1I+tUftf1a7t2j1hDTo
 eWJkfoeyTbcD7nRo1MdQ4AHqWcYF0SRWvsqNNqGdct6+z+VvOuuCC5b
X-Developer-Key: i=kimi.zy.chen@fii-foxconn.com; a=ed25519;
 pk=3zHetsW/3CYYIgQlYV9dqSS7aW7aZXLUaIvc+OKr3NM=
X-Endpoint-Received: by B4 Relay for kimi.zy.chen@fii-foxconn.com/20251105
 with auth_id=559
X-Original-From: Kimi Chen <kimi.zy.chen@fii-foxconn.com>
Reply-To: kimi.zy.chen@fii-foxconn.com

From: Kimi Chen <kimi.zy.chen@fii-foxconn.com>

The chassis power cycle process requires a forced shutdown before
cutting off the standby power. Therefore, SCM CPLD adds a hard shutdown
host function and triggers it via the IO expander in Clemente platform.

Thus, a new GPIO line named "hard_shutdown_host" is added to the
PCA9555 IO expander at line 10 to notify the CPLD to execute the hard
shutdown host function.

Signed-off-by: Kimi Chen <kimi.zy.chen@fii-foxconn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 450446913e36..0eafd8ea04ac 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -983,7 +983,7 @@ io_expander4: gpio@4f {
 			"",
 			"",
 			"",
-			"",
+			"hard_shutdown_host",
 			"",
 			"",
 			"",

---
base-commit: 6953afcd81a2cc73784e3dd23faa0a1aaf97441a
change-id: 20251106-dts-add-gpio-to-io-expander-a4c32ccf56aa

Best regards,
-- 
Kimi Chen <kimi.zy.chen@fii-foxconn.com>



