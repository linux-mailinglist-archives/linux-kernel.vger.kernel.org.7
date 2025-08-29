Return-Path: <linux-kernel+bounces-791398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2047FB3B65F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7764985562
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F6E2D9488;
	Fri, 29 Aug 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeiwQAjo"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20522D9481;
	Fri, 29 Aug 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457316; cv=none; b=eZ9zo5tXnCTnPv7EJUFSjuV5cG2RqsEIR4tBIt+m9j0U42roVQQOC0N3zGPabvpOxNj1mXLz1o4+ZKvUgdg68M3/VwvV6/DCqbTGeTvtDjJ6C0xdAuDHuMm7fg/cENTrRdTjL6xcpY7ZP/nHn05LZEchdwbgES8aTZmzE35k6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457316; c=relaxed/simple;
	bh=eza6FXzy++LDogP3zcMgk9YsALnXaMYkVZLvx8dfpus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhGNwmFwVtraMsi7FUjYI5Uuz5746xA8ZP/UDeOKzLg+i9acd2CdeXNYVKXJkDTTjKPhyNFIj9CL5ZwOhENm9rrJ4ltWjVhsY1iGHbOYoxDExeK8oUHnW4Ht0lvNeVWmJGOUPmufbaSzPtPHWJ8vAzwC3Iugf5kkk7aSJpBFqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeiwQAjo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2487104b9c6so16759515ad.0;
        Fri, 29 Aug 2025 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756457313; x=1757062113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=getXY6n5cmVJNwnrUl8uG3DyV7kHjWYHn6/PT6xrbnQ=;
        b=HeiwQAjoOW3C5LN/0wmcfIxELpBc0Yf4ewJSe8+NdsHWD30QcFSoo4h9U2XCiQFt3M
         cnFAhdKQv2FkBilzVW4sGXt0E6ikfEAlwR5lXaw/SbgleMYjYNH4cHX+HqwCq2CCmYkz
         IKdHAGKmmM5Oq+979UATVlPuJW85rNpkHGtnzM1/5lS62hAyzHW97FpdFpK5GX3wnsQy
         pnLXFo0Dm5JJs2YiS0dlETLsmo3V4p+9ec8OAB19NNbMA+ZGZRsWLh2kl+n28JZlQV9D
         OPRGn26NOEGnwR6boJ24K0/5IPQbMfJBVDZkWWeemCHfUOCkkVZLEAuqiF+aww491Ut8
         viHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457313; x=1757062113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=getXY6n5cmVJNwnrUl8uG3DyV7kHjWYHn6/PT6xrbnQ=;
        b=Ps7Wxw3Oxf70XZvU5mn4gaMBJZPO54coqHxR0UTMNwbKciPAw+UZ5EHqOQUyoJuIfP
         iMN/gHVpSnQh3fZx9POZud5YLHCfHSS3QXQ01dc//yfqDyhYVecxFMlPVOCXPp1+LLKk
         v+jpi/mGhu42wHhJ22Yygn8qmzc075GL2UIIRGApG98ELxNdLGQyt1CSVu4rMuz9tUBh
         EdadWYQbsHi+C8SuAwGyGouVYgQ1ALsUHCJcMSWE6P/LZURWhl71VwEueK0qbnbTmbzz
         XuJipPC9npg4bsDYRPI4nPGTjgpqE+PPoMvdD0qBw2C9f6qO2oz8yashFAMTbw7T31Mi
         4E8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUviTGNheudZrg7L32pVQEkdR+baLs+pSmgtRyz94J77Cc/KoJ4BBx4m7/ygOXdfmnI5LnzeNK3Yomc@vger.kernel.org, AJvYcCWqs9k0x9K1ZflMnfG3EuyKx0xAiQL1o6/W6XEwgd4MEMO+MQUm9lHTshsxcxeRN63AVY9ht/d9Y4kraaGK@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwONyvxq/pcLOOHZp3m7C2QuCAnVEkfeKNfVGX3c7j0o8tWh+
	Z25wNtfpycSEoIQWpUPftJqn8lY1lWN/d5psflka5PPM70HZP6A+KzJT
X-Gm-Gg: ASbGncufFBhOHxo0KzUzaEI1/VRyRJkoTyJ8PeApd3qPVWWQ5ggde4Y73u3CycfBn20
	sLMnw4DUzpDPK3pFd9psjjmkpbST1j2/eDezxLhtJ1qyWZpbRnX9cMnrcjDDsPRtp94xaU5Pquz
	odgN8poFypj/NL3i2YaALFk4Y6MTHyAsUQm0G39yOiXzzrtAaJ7cUb5zc0Fa57MXBhglgttJQ1N
	T+MBuX/8PLzJv7bL4c1rSmo3UZVHOwI2EbsvrTfUE5lOL/A3g9ZwMrRlK5gxuyIK80YZWPupSaD
	RmExvW2UOecilHONdKhDrnSM16AHtCRoIFqy+ZYZb2G9Ubbr7fsA76MiyBnfg17F5T+JFgl1or4
	SXp0dzPBVvtNpsP2b+haQAsgS4No=
X-Google-Smtp-Source: AGHT+IGhBfJCAXApPTnMOx1BPvVN1cE26lZrndFkg1B8ZF/ybAWF0/Xb4YRLny1z0qgLJdczsbr8Gg==
X-Received: by 2002:a17:903:1248:b0:240:92cc:8fcf with SMTP id d9443c01a7336-2462ef53d83mr382357425ad.49.1756457313105;
        Fri, 29 Aug 2025 01:48:33 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249066e042asm18162565ad.146.2025.08.29.01.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:48:32 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 29 Aug 2025 16:47:01 +0800
Subject: [PATCH v3 2/3] arm64: dts: apple: t8012: Add SPMI node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-t8015-spmi-v3-2-58b15ee2c825@gmail.com>
References: <20250829-t8015-spmi-v3-0-58b15ee2c825@gmail.com>
In-Reply-To: <20250829-t8015-spmi-v3-0-58b15ee2c825@gmail.com>
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=eza6FXzy++LDogP3zcMgk9YsALnXaMYkVZLvx8dfpus=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBosWlUs0lzltNT/qLaVfaVX4h2HZkQ1Ro4GdE8q
 ftk/g4gb8KJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaLFpVAAKCRABygi3psUI
 JMStEACNFIJqKRV8SftSpcWaUUIKtllDistXE5BdZNVP0LwmXOfPJsANF+Bv3e7GoZHyw4qsUpP
 BisVDc3DwBxm/j27T+jODKwyTRGatj0p6eSb9gnhu5TB/Zzo+HKzrykuAeoXPGvM93eJo6kbd1y
 a3N6bbGHwJEE+IBgBEPyzhkkpfCh79U2O4F35oE+6DP8uiDVZx4jKqGh10lpRw/jU+qPm4guh1I
 TsTeC0xqHnUrwj5BeRpPDVc446vPSpcs5TpG6adyOJL9geeqj7e0aXzgB4ANMp3uB8ng7POUfX1
 JKd26yBgfI41vP+297ZHU/j+3YkczirTylI6ZIalctUJyT4eBWN9xUaIwNOcGQL7Qul0ahX207C
 CtDKTPLlRGwjUC8QlUceiAqe/DrV5CwjCOXDS0loUqQBK5LQXrXTR373gGq7iW/x5X2iab3Iaj0
 k7+bIQNpIcK1iUJaL8NLnYCkM1Fdp7jDx1jVLv9U+4QGYxrIAC3BWaR055KPlWK+8bk9Z7nIKKo
 D8bjio/WeXujyhxuoRhOtcEYH6drV1C2/YfVkpzHZOorUze3wquLDORn25JKDeljXMxt5RWYF2n
 jIRst+/f1v0Y5vXXvBXctdm6IOB82jilGlg4ugsQWFiQwqrcmgNXQOYloQPdMGipSHC2GaQQ3eZ
 VS8PtnsIwjpYhzQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add SPMI node for Apple T2 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8012.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8012.dtsi b/arch/arm64/boot/dts/apple/t8012.dtsi
index a259e5735d938cfa5b29cee6c754c7a3c0aaae08..164940757d446fd314154f83d49fe8b308757199 100644
--- a/arch/arm64/boot/dts/apple/t8012.dtsi
+++ b/arch/arm64/boot/dts/apple/t8012.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/pinctrl/apple.h>
 
 / {
@@ -220,6 +221,13 @@ pinctrl_aop: pinctrl@2100f0000 {
 				     <AIC_IRQ 137 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		spmi: spmi@211180700 {
+			compatible = "apple,t8012-spmi", "apple,t8103-spmi";
+			reg = <0x2 0x11180700 0x0 0x100>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
 		pinctrl_nub: pinctrl@2111f0000 {
 			compatible = "apple,t8010-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x111f0000 0x0 0x1000>;

-- 
2.51.0


