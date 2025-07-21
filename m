Return-Path: <linux-kernel+bounces-739109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFBFB0C1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928A817D4B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A4328FFE3;
	Mon, 21 Jul 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="pT0ltWUY"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC629827B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095343; cv=none; b=qnzLW28gnj7uKA7dc1IAyhD/DMBNvYN8kMU6d25gd7RPnUTvmeJQ7YeQ4M+fqLF/1amNHDn3KY6g8grBRW6seUWvCeNn38aevbWavUVhyUC1NeDeN8rY7lq/byg44YRxqsqh1L5O9vnzCJTMiLm5B3Rvy1bG8XQH30kXQnlmYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095343; c=relaxed/simple;
	bh=QtNA1Zw67oY6g9wXhby6BPpqc4kJTg0rFQpE0bGv9MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HGOHatijkbNPuxGp1zcYfecCLEfVb7X9cE1gF3kSHuG61B5Rtu2Khs/yOwCfsjKEzAG/HH1IapLyX0kdoHVYaoqgMhunQKhq0CsbRhQP3+UgXWyH4BJNi6jnYadA7qRgHPC5ylJtkhWmlOCLsTwbM7dpEbjuKqPpcf7Ri0RFkxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=pT0ltWUY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so33944645e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1753095339; x=1753700139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHC9dKSjhgDmCS3Dc0Ob+PRUH+xtz/BK7VzlQay8jS0=;
        b=pT0ltWUYe6TkCAuKWAeopr/nLRLmlB0Dknr+5QhNuaJUBhqC4ELiWsnPXh0s43/qgZ
         NBjzLOSF/3Qspr/MIbWEVIib8WXZE7HWs7l1ntqss3nywoOnI3EMUqAaEDoopCGFVAuX
         A3KlEGyXy+boNDvFrCprRAT8E5GsuQ2MD1e6cLhaLjBjqxB6MXYXiuIwEGPVUPAC3sIh
         QrvwGOi8K0mRcx+FMBadG7vGrqTs8H9CjvbkrcroS7dr8YSdi/m5f7B8hOtO2IzXgEiY
         RDzHlPMrDxBp+9Zgf0pDBeETtQOJGAPvWMDqmQ0QQHZ/yD8PxuRgPsKGofUUqhoLCTG5
         ScmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095339; x=1753700139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHC9dKSjhgDmCS3Dc0Ob+PRUH+xtz/BK7VzlQay8jS0=;
        b=XHtRVR7TnR8ptdpI5vBZ+fUmAa3vIexuVD6Oggt8IRljiPB7JHoubwB5K9QT3TePN1
         ZEnr7BZUPngrSNdJCJz/RxrD/yElYbaXTcxhflK5XoBzL28nfrFyWtgqWH0bqKe04b+M
         UrGDOj+gG+v4fNCaV2XqIE9acozoTJecpiA1un52nSCttXlUBIPJiZcc/G6A5qbUQ0Z3
         fOvFuToiC5/oF9Dv9K2piIKVliOfsnEDo3CtjKseJTzw3gRqcGOp42vZsc1idSWSOsls
         J+uoX3u8Ooh8F0Hp3zLSDCdPfF2CNRduhtahl/CACTiyRIjrn8jB/rIfxIeU1Vz/HxLP
         FZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZOJWSvGsDFvF7kdKoxysdbwKynJ68cvQ7kMqks5vQ1bMg9A7IwYSvmx4dgAoG/gS3E3BzRjIbGest/kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwneySdzw44eNEhx7zOqrCcucqx9qgEFUWdj+pJdA4wKXKQPXwR
	fvSJeMnpvdpPkwjV2zOzGIgruTXxTYFUSFfWheUaL2c/T4NuUMyEWEUUALOwHKrGFfM=
X-Gm-Gg: ASbGncv4JsEVDtXCxv0njIFGjaRmCl9W4HvU6FVy7dNn7bDkkSwy9+bzhJyOdGlAGvE
	b2x5GALCFxynAMxV5ejQvBa7fATObZby15D99FWKufzD/sXXjERLC7ighzKNJzphnweZ+2EK4h7
	iQCLSxWM2qpBr9FckAN+Md9nXtdsKww7rUfmHVWQEY4x0TV+J/mowXDWPgWDI/tyuu5cKUyhyTf
	6Db4Q4vIthUJt4MSmz96ZTpH+NUlBift8tTpJ6S2KHrxze2vdT+lO4c+WQPVbVQhFLLuOZp+U1s
	eQrLMsYcPk82M+kWucu4ODR6pwG6jhzbmpo/LDRwHXRLLIhxlDy4D+7cBMJuH77/iiA0YHzTA7B
	wNUn73y5iXv3P8zjx8QebEPyAtykwOqjbuWkhsn8=
X-Google-Smtp-Source: AGHT+IEMnp6KbrZ/evTevPv2kZc+1Fdq1BSnaHkk6zE9iOTVsYyUW2/Ifq29t44BarT0k46Gkbj4Pg==
X-Received: by 2002:a05:600c:a113:b0:456:18e:eb7f with SMTP id 5b1f17b1804b1-4563a4fcf8bmr96958405e9.3.1753095339250;
        Mon, 21 Jul 2025 03:55:39 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c7:1d1a:9c01:f373:f0d1:903c:a9bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4566dd6b8bfsm18141065e9.35.2025.07.21.03.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:55:38 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 21 Jul 2025 11:55:35 +0100
Subject: [PATCH v5 2/3] dt-bindings: leds: issi,is31fl3236: add support for
 is31fl3236a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-leds-is31fl3236a-v5-2-264e841f4da9@thegoodpenguin.co.uk>
References: <20250721-leds-is31fl3236a-v5-0-264e841f4da9@thegoodpenguin.co.uk>
In-Reply-To: <20250721-leds-is31fl3236a-v5-0-264e841f4da9@thegoodpenguin.co.uk>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753095336; l=2235;
 i=pzalewski@thegoodpenguin.co.uk; s=20250625; h=from:subject:message-id;
 bh=QtNA1Zw67oY6g9wXhby6BPpqc4kJTg0rFQpE0bGv9MM=;
 b=kl9gQTsUW6V3nUgx7XzUBEW8xg/8kh7RSP58BqI2GETCvvwvvwT3kfXLGwKz3vr5oecVu+B8C
 LSu8L6wqtEhDmtZaFE5ShDr9kOIaUm6zZWTQBGNdariuj2bn1izZyGu
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=hHrwBom/yjrVTqpEvKpVXLYfxr6nqBNP16RkQopIRrI=

Add an additional and optional control property for setting
the output PWM frequency to 22kHz that exists on is31fl3236a.
The default is 3kHz and this option puts the operational frequency
outside of the audible range.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 .../devicetree/bindings/leds/issi,is31fl3236.yaml  | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml b/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml
index d8164876611f5e629215fe2715ebff1745f93a26..58f5aa4d0b644fe550e2c48b141c41c37fdf98e9 100644
--- a/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml
+++ b/Documentation/devicetree/bindings/leds/issi,is31fl3236.yaml
@@ -17,6 +17,7 @@ description: |
 
   For more product information please see the links below:
     https://www.lumissil.com/assets/pdf/core/IS31FL3236_DS.pdf
+    https://www.lumissil.com/assets/pdf/core/IS31FL3236A_DS.pdf
     https://www.lumissil.com/assets/pdf/core/IS31FL3235_DS.pdf
     https://www.lumissil.com/assets/pdf/core/IS31FL3218_DS.pdf
     https://www.lumissil.com/assets/pdf/core/IS31FL3216_DS.pdf
@@ -25,6 +26,7 @@ properties:
   compatible:
     enum:
       - issi,is31fl3236
+      - issi,is31fl3236a
       - issi,is31fl3235
       - issi,is31fl3218
       - issi,is31fl3216
@@ -40,6 +42,12 @@ properties:
   "#size-cells":
     const: 0
 
+  issi,22kHz-pwm:
+    type: boolean
+    description:
+      When present, the chip's PWM will operate at ~22kHz as opposed
+      to ~3kHz to move the operating frequency out of the audible range.
+
 patternProperties:
   "^led@[1-9a-f][0-9a-f]*$":
     type: object
@@ -56,6 +64,22 @@ patternProperties:
     required:
       - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - issi,is31fl3236
+              - issi,is31fl3235
+              - issi,is31fl3218
+              - issi,is31fl3216
+              - si-en,sn3218
+              - si-en,sn3216
+    then:
+      properties:
+        issi,22kHz-pwm: false
+
 required:
   - compatible
   - reg

-- 
2.48.1


