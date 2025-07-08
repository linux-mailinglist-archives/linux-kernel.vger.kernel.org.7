Return-Path: <linux-kernel+bounces-721839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB9AAFCE72
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A827B025E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9022332E;
	Tue,  8 Jul 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="biu4aKAC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7E2E0938
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986824; cv=none; b=Mq14IKU+RXEWvvbA1xhn3w07q/wENIay5/bbDTCj3xzYbjWBlMeDSDyyANTlL42iX2saejyIalVPsiNCMQPr0tddhMkgOi41dFYRg0n27v5tGezex+jrdBVPKiRn0swfnqznzPEC+DP7XGduB/5hd5S8Vhc9JfHTGRTk7A9zmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986824; c=relaxed/simple;
	bh=oubSlw9c6CwwNGJChX5pk5uvHul9AR5futtvxpba9J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gyFjd54E3FgjUTbDWNulVKbsrmAN/BY4lcRbxVRQ7eQcCwCtfvi9oWSsGHQ+EBvC2CXj8gM0+HuxTLUe/34eFXqRaxHdylv2fQk9gzd2AJMTu5zDwKuOnTUtpKPKoUcVHJUBZVDeG7ChdI0G5XToDlycyTZ/A+jXn8mN+TTBLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=biu4aKAC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-454b1d0a115so15387845e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1751986819; x=1752591619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYl+uMBjHYHOG7bkXi/XB3f8f6YY8kSh6gh2qtJwtzA=;
        b=biu4aKACauSb4umshrzMzEgm2E4u2EAxc3C5L1iv4BFOpn7jNR53S476Y0NtzOm7t9
         tz9r51wcYX7375E8BhKMT0u+nATXuRwB0BeiqhDAcub8m6QQKFVycccexEX/ULjACp4Z
         o3/FEP+fqipMG7xNJ6lcY2JHWgWC5LWsh60IYQeOQWMRJTs2ofkj0KhMt9pSDuu1baUc
         jxhxq34cDZTg/aRudvAkI1F6PL7vBqwm68C18N29teUHFOW4BnOl7GY21hPQwzGnUFqn
         lC453SEzxXZK9Vt08TFq3EWlu0B9fwrTMM/QFR2/qDFNM3l/9hngqsjEQb970uFUHbpG
         WC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986819; x=1752591619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYl+uMBjHYHOG7bkXi/XB3f8f6YY8kSh6gh2qtJwtzA=;
        b=ow28lZPVOs8cOY4thEtaWItqnUIyJ8yptMNliEZlZ7TecBXHUeULNuFiolPE+lOUzk
         DZCT7AGW2fgO9m3yxkTaAE3dOI09OuV8EGjug2i3aLYQxI2KbuppxHw7hQlBs7BqsNkY
         S41jdCw5uihIL80AM2ua4vFL8TaUHIz0mZlE19OklCtLb5IWVba6FncHTwBPUTdSTdrd
         pmL2a9GNNTVcohkHiKCsrLbvs0dQrpr3dENcyJEhD1IZLQxmIgXzRgSK4qMzYNJEiN6i
         1Si+oLyo45mJ2RDAD2pIfuM6hSZ6DnQyfaWo9b2P+hKtchi8Ld1jlrrTh8yzYQmCEasr
         BsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzPeCr95ZPWWpE4+c0iMrCJ+BkpidZkWzzG1MVvtv5rDpIoua0X5XSB5V0xfDMnHuXb8GJLVB+y/zLmF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1+DMSooOrAN6drHGj/U96gKMz9w5p716PJ51z+AfIwJH4zt/6
	tiIg9/8ZfuzFlgOL5akw7m4OVKIGACHX7ETfSo3tw9Gc1h+cK0UFhbJP4laqCh+XsJEk1d3tmES
	rtSXxk5c=
X-Gm-Gg: ASbGncuO8rg//ooRF8P66qJk1h74QbELq3NW4PwozusDVzIBMz+snG0VWVKNeIxh7W3
	fZHXA78pHUtuzHePQF2pvgjaLL9RLMmrIDPNTK+/UKEKwCMkOFCdFDdUd8Y4vpZQH1OKa6QDXMW
	5d8IVvXL0KuW7L3g49WCueI34a0DKv3HMuvfaEUHXRYCNjwNkZ7Jn3StPCtxPvQ7wM9M1RO9qFi
	c+10x1HO56SSa7YnGfe/exHbR6BgC+uKr8RxmoTJYngeZEhpAolzy5AP7sBGOrGXsouMm0s9wkJ
	wU4r05GhwaFEYNNFmz6xR7xxT4a5fIfAFkLiy6ovdVAZZQs89liALJZ+bGGVl6NONXz7Hlp4oL5
	jFH0=
X-Google-Smtp-Source: AGHT+IFlo7yukXz1+RpPI+9aM+Wv+VR26H54kHPCJ0VBY6icdoCFLAGnDf70y3tI5+eVHEmKCs6qtg==
X-Received: by 2002:a05:600c:1c06:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-454b4e682ebmr166687725e9.2.1751986819301;
        Tue, 08 Jul 2025 08:00:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c7:1d1a:9c01:f9da:8274:e1d1:97ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030b4f6sm13517433f8f.10.2025.07.08.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:00:18 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Tue, 08 Jul 2025 15:59:47 +0100
Subject: [PATCH v3 3/3] dt-bindings: leds: issi,is31fl3236: add
 issi,22kHz-pwm property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-leds-is31fl3236a-v3-3-d68979b042dd@thegoodpenguin.co.uk>
References: <20250708-leds-is31fl3236a-v3-0-d68979b042dd@thegoodpenguin.co.uk>
In-Reply-To: <20250708-leds-is31fl3236a-v3-0-d68979b042dd@thegoodpenguin.co.uk>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751986814; l=1098;
 i=pzalewski@thegoodpenguin.co.uk; s=20250625; h=from:subject:message-id;
 bh=oubSlw9c6CwwNGJChX5pk5uvHul9AR5futtvxpba9J8=;
 b=LBQ1yPV/JzboE//xuT/t1MfJoj3jNSbBfc86H1rwbBeRybamxiXNZS2wzbfmz+da+JbhLGweW
 nZuDXpKQnACDWBCqmmsdkV2yYF8gC2MHfA8H0Ak5QK09N0soZnVl4wF
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=hHrwBom/yjrVTqpEvKpVXLYfxr6nqBNP16RkQopIRrI=

Add an additional and optional control property for setting
the output PWM frequency to 22kHz. The default is 3kHz and
this option puts the operational frequency outside of the
audible range.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml b/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml
index d0f9add5af01ac06c4bb87b0cd0faec71d0ef37c..5bce0fc48f84c7ae804e6522e312c51ed2d77bc5 100644
--- a/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml
+++ b/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml
@@ -42,6 +42,12 @@ properties:
   "#size-cells":
     const: 0
 
+  issi,22kHz-pwm:
+    type: boolean
+    description:
+      When present, the chip's PWM will operate at ~22kHz as opposed
+      to ~3kHz to move the operating frequency out of the audible range.
+
 patternProperties:
   "^led@[1-9a-f]+$":
     type: object

-- 
2.48.1


