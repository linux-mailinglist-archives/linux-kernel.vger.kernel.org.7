Return-Path: <linux-kernel+bounces-749171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC63CB14AED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BE47A6732
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FA1287265;
	Tue, 29 Jul 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du1NcOp/"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8242877C6;
	Tue, 29 Jul 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780448; cv=none; b=RAGXn8JsUZupjIrNvDF8ZfMmkuhGG1pX4qiEExaJPOkZancnAEpOwU3JToWxtQYH7CYQs85M5vwsYfNDjuCKocUO0KJwnS73eUtXML94mFBUaS6oK2S+6zXUrxGOrQFCGq89KcJ4Fb/RXPuRwy9oRQjpI5McSM1mKpdteSgr7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780448; c=relaxed/simple;
	bh=N2Dmzvg/4ZCxBDZwNT9DZo8FgkHuriddsUJnyBpeCEI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2TnqsdTP5DQcaVU6k6Txwm/DMLAxQYYvIdPl+8nwtflNQLF7W6ORs3kOcWuug5UQBLt/A6ibh7U2g1pwvYlE+DRN6V+epqsRO9j3u8bU7DGpTOsir9QRqOVsTHMlk48G5Vtuc8M5uoOZq9ASHM8OUy4UXzmca3nW5+9Ip5QSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du1NcOp/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76a3374b143so186869b3a.0;
        Tue, 29 Jul 2025 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780446; x=1754385246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEtF7qEvsNXTmyOD1T2fZBfkSHd2BexV1VORoI+Vnis=;
        b=du1NcOp/etOLJUq1TnQEkEtIyQOfxskMYaVMZtvzro96E12kIAwZev533w8do6Rowt
         FiNz7qnhUHazj3XKk792QhN2XVdJKQk1jaSRewTVDFY0GIrPcGXgE89AA/0fN2EVzoDO
         oGmJKN5TdtmiDW1NkPIOdPr3vnL7z8+Wvi/FcD4jIKCgtW1xtY+EupiXz6Fel0JxbhcE
         deA/l3QTKSg6Q5P0y7gTIA1zIvd4HndsOxKdURsTtoYvVPXhHuRy1onuGPj2EY7PFHiY
         /MbczkGizg5T2bgaog5KiucEmW4dIuOxeTXUwAwSwh431k8pw1nOA/nVMSd48J5Q+vfc
         ofeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780446; x=1754385246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEtF7qEvsNXTmyOD1T2fZBfkSHd2BexV1VORoI+Vnis=;
        b=f0aysy832y+SWydeYD6usjCnT+XQKCYCE4IxKUG/RrIZPE7nTI2ToQZRAHyqpf1W4w
         leFPYMmgobOp8k933AjPbGvecu5rqrjo5sMz/15YQRhsUlvm5Lar5floKDi/0kvwMjQa
         jxUEccbAPzt+zxqxxLsxGY6g52s+p6+a5dpf4cyoW0VBivpnVbxbsiI98Y3I2u8Y3yIK
         fdMOMBkGkvZOJ1irmafUPwn8Tt7kh7MJQ9ybGWpf2NqBF7stl0LQeNShQYr68hVVI0q9
         rwXLZ3hA5IbsDE+O86mMYuNqC9kZnzs12gJUC4lLGWCpc97hgLsMeG+MHIm3/puVb8OI
         bhgA==
X-Forwarded-Encrypted: i=1; AJvYcCURRjVZHzjCIuBIIqsSi4tcjt7QEg1yQ1iCexqGEYWNIx98nkjkhDXpUt9VD3+MfO7cdwBhl3g3tCKZFLgY@vger.kernel.org, AJvYcCVLtQJMjuSC3JVDponmSTsZtryRredeSAJu2gdvnzzv5Ee5KD8wtcTrS6ViBFoEjEoACjMM24NV584s@vger.kernel.org
X-Gm-Message-State: AOJu0YwhNNwAYNDeN8hpt2kbPn/veNZhJPT4Fjugu8SZUsY5PSH7HJwe
	NXAOhTdOI919mUJU8Yp1JgbV4OOzfSvqGt46p6Zp513AxbukLaUigJjS
X-Gm-Gg: ASbGncvm5sH6wiSpPSKje0sRMC4juYgmjJD4V0naabRNbKjRshBx1pvJY4I4EM2PjR4
	hErThqM8VvDQI/gkWx3RCjeNbjV+A+o5xtopEZ4gJWAvn1VC352VLlG0rMUl8c1mtEBccOuHMVi
	FTxISYLM59Uf6nPAQPhb9E8iBkjccKDo9qg44vJoQ5wJEB0u68KNxvG/7m6oTZa9u5h6OLyCODp
	bUuejg1SK6PQuXZty/5PhfF34P4oPhk78vUuQUoamR98St5gr+edVqNxIn9lEf1lCm0NOyOETCq
	Yr67z1MyhPZXCegmtcWVDVm3wWmhtjegOGTYvagmVctZibT2CIvk29y8YI9DGonWQ/J6zpVpwYI
	b+aRFbDMogYRthDwx4BqNX3vQVkqXgojgPdf8vj/l/x/2ZlRpACU/lzpCCjbtNm5vAKtTsRbnzO
	4LWnz5J2CtoiJijIVB6/JiEAri3aGLzXE+uo38LVEejXz/owc=
X-Google-Smtp-Source: AGHT+IGZbRiJ4XM9/7SP0TbANTsh6WCA507Pa7WbbQuyrxdcEdrxbpHYh29JWvG1Csf/3GaK7l82Mw==
X-Received: by 2002:a05:6a20:7491:b0:21c:fbf0:21bb with SMTP id adf61e73a8af0-23d70171d80mr25597800637.24.1753780446288;
        Tue, 29 Jul 2025 02:14:06 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e38d-c586-0429-5c72-053d-8858.emome-ip6.hinet.net. [2001:b400:e38d:c586:429:5c72:53d:8858])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b06ddsm7528612b3a.121.2025.07.29.02.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:14:05 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] ARM: dts: aspeed: santabarbara: Adjust LED configuration
Date: Tue, 29 Jul 2025 17:13:45 +0800
Message-ID: <20250729091351.3964939-4-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
References: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new power fault LED on GPIOB5 and relocate the ID LED to GPIOQ4.
The ID LED is now driven by the CPLD, allowing it to reflect multiple
system states depending on CPLD logic.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index ed30f3bf61a4..c7eb30e5baad 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -94,7 +94,7 @@ led-0 {
 		};
 
 		led-1 {
-			label = "fp_id_amber";
+			label = "power_fault";
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
 		};
@@ -104,6 +104,12 @@ led-2 {
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
 		};
+
+		led-3 {
+			label = "fp_id_amber";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
+		};
 	};
 
 	memory@80000000 {
-- 
2.49.0


