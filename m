Return-Path: <linux-kernel+bounces-762785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8266B20AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52ECA7B646D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137B1231840;
	Mon, 11 Aug 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLgBlGQi"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78002264BD;
	Mon, 11 Aug 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920462; cv=none; b=mFBh+F9vnwsfpw6w1gqmdgdm/6J3/BtaBuJUZ/2syr7xoQgtbrjGLGL6myUF/jPCavXz3bPC3xyhREAWoejR4Tt2j+dsvoDTM9L3ZLClgUrXLg6V3+SZ8xVy9UZkatZkNznb/SOl9BC4NTVNnMiPIhtM0bBW+PVs/1RSnZGiSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920462; c=relaxed/simple;
	bh=6sIMtSPHhd2FTXHOBnTqWI7MAFm5VIlJ0J7eqlFrmr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lsr8qlIiJYWAT3FR33tRmeQsuypKdKwg51aEja/QEdkfLuTN0YIyQWVon7QoCUeIZB0xugAPnYiK3WSsX7EEcLN/DX9C+NfT34nadYOTaXCLMyjvDFlflIIi+hfBk9VdWhD5AKnydU6/dmhd49x4GAmBoO0yqmseY3E0ZWTWv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLgBlGQi; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b428dd79d46so2816216a12.0;
        Mon, 11 Aug 2025 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920460; x=1755525260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InBvecGhedFSGu5Dcom4sxZqi83xWaTBh5VQlTlnfP0=;
        b=kLgBlGQii2fkC1ZPSYxIOiNtGL1hNHmP2nFv768b2bY7lr2mWI8EfO6XfAxVkJBd5n
         fY+7GCam62vyy+bsiVYjTPGZjMD7/cVG1crvL5IBX/FRy44WgxdytozLNqx6tLB7u0fQ
         EfDxvENOSNV3ibIDkgKQNq5mvsg1On/P/Xaz9/+TYS/cWYFINdYq3rKECAU0MyafLrvc
         p2ukv8O7EAsnmbZIAm+e3Fh08moaY45o7DwlSA01Wk+cKXA7k22lABNHwxK93pccjvDX
         B99CpmDxfDDCHC/YM+/J8ZummhRI5HHeH2JO2qspw6N1T09owIEUwnk3Cs4asfFRfj+U
         7zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920460; x=1755525260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InBvecGhedFSGu5Dcom4sxZqi83xWaTBh5VQlTlnfP0=;
        b=LtfDjrESzIlssn8qbCs9N5pQnUuNNKD/ADOcJFCX2pG94Lq8m37ElYsPfNk9jk5Zg5
         GfGvKxV4qHnQ5C4z14oDBVgAwS2axjSvFui6ARMbR0MYHV4q5hqMxQsPmKnfhlpLng6+
         BZSVAxUZz2JBl/W9gUVmKg3KBnOfIvSLcJ2Vbgm6zNeXWTxRla/8NRSODWV9usIEMkww
         sSIAjIgPbsrghV2gJllQrNkiGd99PhE/SAKKUVeJgABQQtpoyF+zmkfUM40xDZ6XU5h7
         SQQYwT/u+oBCSMsso0BTVIlyyc1W1RRE334/h5oLEEFMLl4FQEu3ELEO9rdrLwNTpB29
         swnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1DFCcm8kC/Pi9EKF2AW6wOuvIRzhUB/++w52h0ameY2sXM+krv8TjXT61vBm52+LVzEi0XNA2US2a@vger.kernel.org, AJvYcCX3QcL57fbOvnFOzWiKlda1zGqfdyrAcuim4KI5kOGuZI+bTLqW1XcvUCvkcbi1zf6r98Bf3NdON9pVC/Ni@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4tHWbK8yCCpk7gG8bNatQvOZt8xoMbuDVD124H5o4u5utWru
	f4qkCgZ3RDobsBnLNpl5sg3X1nRr3+OwN9YOcLtrmKfYX4BofaFE7mdI
X-Gm-Gg: ASbGncsPP0/Xk8swpuISnrCr6ohZZ64kniAd/oLLRMb6BB6dxNd+QoxUi6tkKpxpdU/
	z0VSDwJc+o8r/smV+6tgEgIgWEdPiW/g/UZDB8NUufT3lULVp6XWs/xuwbKmFbouKarPIpYU7ce
	0/uJYkEfuFNqhDLFtt17ix1ZJYwYOYKlBTTgUtl0HSL11NOFT02CrsINx6CydY8ABIAAGnLjdiJ
	4RulKndIshRQVsaZ2Ev090V5sKNASqxkjp6gQVPKcO/7yPeHB/8zpXQiUiOG7GNnhKxtw8d+sQP
	7f3MIrctv09F4+2o0mAhQpfOtmVJ1tTZV7r4aJD+Jse7BDhHqfsr47VtLJD7pgojWyK2aCIu4Dp
	F3oU36To3boaMvb4ukaeYjfJ2bstZ+8hS+6Si6CaxSSaNlz8=
X-Google-Smtp-Source: AGHT+IHgqw9wE0vqk9PZuypkaZC6yHDvfMteYcqaUMA4xnpqeQP11i3EVr07/a/IvVKndMHAC1zZqQ==
X-Received: by 2002:a17:902:ef48:b0:240:640a:c560 with SMTP id d9443c01a7336-242c206b2d2mr204600595ad.24.1754920460174;
        Mon, 11 Aug 2025 06:54:20 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241e899d272sm272976285ad.135.2025.08.11.06.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:54:19 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:53:57 +0800
Subject: [PATCH v2 3/3] arm64: dts: apple: t8015: Add SPMI node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-spmi-v2-3-a291acf0d469@gmail.com>
References: <20250811-t8015-spmi-v2-0-a291acf0d469@gmail.com>
In-Reply-To: <20250811-t8015-spmi-v2-0-a291acf0d469@gmail.com>
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=6sIMtSPHhd2FTXHOBnTqWI7MAFm5VIlJ0J7eqlFrmr8=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfX8sfXf48Z+wcbAk7YpYAspcIELf649xiWch
 cZHfEwROuKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1/AAKCRABygi3psUI
 JKJ5D/9Y1nweI6YbiXz4vEhpuwsR1nPijEazr4bvFRnZa7AM5/JWnAyXvjTss6IEo4DvNWwOCiw
 oZJCdJLdJZFXtXSlIBbnHu+M3GmN0fyYz/Wk6vw6HPPykNNzsuXW/4V9DbMiahRr35U46zm3SOQ
 2+ijoFe/tbo+gExdIPybeYBE5OWq71rRwvWq05/jhxNRHq45Vrj5xW2TWUKHmETC8/2QH4KhSGv
 6ezyoEw3GEld9pI1g2LO/dWa84sQ+7Qj2ELQHcYzJEIah1mmxTksRhK3eHnwcRO7wboij93Nnfy
 bRKD333sg0NG0Qv6WrFR1i1csR97yL3/BnTG/8hYTrH3SqckRSl4R04IziE4SunVZPlNMtJ7VRu
 TC+JFS+SdYqFX6CvWG9LI97VeqGKmw8/6psttZpxeYjqZyVflbT1g3oY7lbicR2Ky7xoeSXsgw+
 ffI3JstSacuFTAitzHP2rkZj1JMxE9x9ggU4IpokQe1n37R7beeP5Aoj9LKWRSc37kig4YYV7R1
 CU8XP/L14mmhf/cKCdh57vLF7W6DByI0G1uQilwTupfL711HWBRyfVpd9Ub/hFFmE/ut7flSxih
 XdszsFkWHB46QlAkLdVKdrjsoKt0EzypgnTC5arXHK99rOXDr5aquDAXPQz/NdVhLLa6kucgGv+
 7WUw02KZDuxft9A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add SPMI node for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 12acf8fc8bc6bcde6b11773cadd97e9ee115f510..2eb0d9092da3218f75e731e49132a9f8ae4d0c9f 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/pinctrl/apple.h>
 
 / {
@@ -344,6 +345,13 @@ pinctrl_aop: pinctrl@2340f0000 {
 				     <AIC_IRQ 141 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		spmi: spmi@235180700 {
+			compatible = "apple,t8015-spmi", "apple,spmi";
+			reg = <0x2 0x35180700 0x0 0x100>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
 		pinctrl_nub: pinctrl@2351f0000 {
 			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x351f0000 0x0 0x4000>;

-- 
2.50.1


