Return-Path: <linux-kernel+bounces-893993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA81C4903B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7999C34AEA9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF353370EA;
	Mon, 10 Nov 2025 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nm4pFbuo"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7D533556E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802944; cv=none; b=Xci+Ja4Ipy883crs+BS7E4DfSWTAcXnlPUwGwvDeqSE+mbVlaH18Xp2C7U7nv07zgho1yv+864nDE6tCWyOnsCwRvAGlTNWgUDSVdzB4GmN3VMACh9oj+wzmYGDUVmNnMmF2wEXg/mdILbybHPQ+ccdbosxhrXgOZHeuAZHJGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802944; c=relaxed/simple;
	bh=83VsTolNJs8TOx5t5je1+Dgh3QeYaZvyttBMyQSF5Po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8D0qU1C6d9iUvCIIGHTMxk/WQ45ioQ/XPHPjXiFeYV/pQOetTSvIJoaUJR4f18l6zPYLUmVyS79m5yI3bKqD4WowLggBI2A49RCQ9U5+Q4mRN8APzoEAuGgVQOIQBlQ+7Y6psAxQb/ZoppL+8N+6Mo3L/uy+GPtKLlcMAL7+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nm4pFbuo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso1999970a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762802940; x=1763407740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfP9r+aA134P6xP9G9rUEiFSSucymGxSGs4llBYmBio=;
        b=Nm4pFbuobOQlggfIxdgG6t7pEXdzGehMljmEWDoqJNDp+QFWnWVqI0BINvqnhO0Ixm
         Sz5GSTFPiwTGdu25YcmYTpibFdkTE9Vfoh0bhjJgOyp0GVxoYGTRdl99V3eaioa5g0dg
         Lyn3kuzKh1Dzb5lcFWoAgOy1X+NentNRezsjJuT2xkn2aXPPLrBPQgXMlTZrI+j6itPu
         crZHd0e4kU1BwuMAr80Krxu8zQ1Ofmcd8HaU340O7KnkrR0XHGPfSYjpO0AAHaoD/Gsu
         l2hfWybKMf28JMSb2GxS6auBSKS0mckMhtdDrVVZmJSZlfLXuuJQDCMiYTSjOB/+86iH
         2znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802940; x=1763407740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfP9r+aA134P6xP9G9rUEiFSSucymGxSGs4llBYmBio=;
        b=I04T+khugC1y7MVIxXBJB1vfGqG74yFBs8iUgMYsR61Oc+Dw4W1mtdXj9i30gQ1kl1
         hq8aPFo4JNl6EvF0pIyMZ+Bed9y0xojIyj4fKJCKZ9FTYhlO7fR4A4BJ44n0cTDqdoxB
         J7MbzCTOiY5JHta2aDRGOxh3j07RFsoUuZrVCaJERMTBc59+6JJtgp98sBIO2xscik3b
         TFZR7jBS2NkYCwVGb1Q/PAcBhBcmIvGaaFagCgARJ3cYqBW8/T/sU6CDvz0tDWID7IQ1
         irvJq8t4QL6fA7AgDS/Vy7eHrmoqTDMwHJ2O0lN2+HbjZusbm229bQ+2YzpF+2IkPFSd
         rmBA==
X-Forwarded-Encrypted: i=1; AJvYcCU2P7nJchaJKG7666qaUwG3OCWYMm/NxibxdXZIQ9Hgosazi0u0dg/FOhLfYGJdKYqAG6/ye/EMoNk1g6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mvbWSSF6jIhoC+24ZrvYfn7Jx4IHi4owIYQsUb3bBbrILAGD
	MvrM3S3IR97pC6RPxLXHY1+2tJEEckaq1BMLGngZmGcdSWqhxmhGcgQ6rXLIXzOLUsY=
X-Gm-Gg: ASbGnct2qUsvPdYpNmp8VxbSER2QDCxn1NL1mFfgUUoZbD31eW4qFVuVCV4fYQKnZc5
	VaxV2al5hd9WTGn+5yrg9xGsQI9QkeSaqx1foQPE2HU4WEXtfnCEV9Za+T7z7f9x+7YySsm2MUi
	yUOX4p4j8HJRxeG2wZdWp4nyp9p+kmizu1MTBL/XubcQ+S1bDit+3bMqqMvcqWlhnI8V0x9GVgU
	NTO/WmH1YBpLqpV5ThpVVUv5cJyTnOQbHUUlsgShnrSxH4Xvv+gwtY3uoUb22ELUhinYR68fqOa
	lTIpCN/bZ0PJRyvYlyUvNi5xJt73ExfGBA+Tx49EqAfhFAQsRjGblY8eA409T2A4K+FwGmzwl/S
	nM/aDh7SyTXp/qXO0T7E2iaml1NPBgTLVPUxmLJVqINDujb8klbCF482ku48cQB+nRJjy14VpIf
	rfWOA5YE1cgg5cBkrS8P1RwfPPvUmxskKq7DmhBHO0CYhX3PmZOtHL79oJtiXPUOn02mQRpeJ3V
	8pazCCxYg==
X-Google-Smtp-Source: AGHT+IEZSSPtpeal08mT4JDkWnZNl6emyDrDOdTdmyu1o0WbaEe+XhWXtXX8M4p/UGGBXNH33FFv6g==
X-Received: by 2002:a17:907:6e8f:b0:b6f:9da9:4b46 with SMTP id a640c23a62f3a-b72e056cc6dmr966964766b.43.1762802940115;
        Mon, 10 Nov 2025 11:29:00 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d16esm1168178166b.35.2025.11.10.11.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:28:59 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 10 Nov 2025 19:28:44 +0000
Subject: [PATCH v4 01/20] dt-bindings: firmware: google,gs101-acpm-ipc:
 convert regulators to lowercase
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-s2mpg1x-regulators-v4-1-94c9e726d4ba@linaro.org>
References: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
In-Reply-To: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Using lowercase for the buck and ldo nodenames is preferred, as
evidenced e.g. in [1].

Convert the example here to lowercase before we add any bindings
describing the s2mpg1x regulators that will enforce the spelling.

Link: https://lore.kernel.org/all/20250223-mysterious-infrared-civet-e5bcbf@krzk-bin/ [1]
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
index d3bca6088d128485618bb2b538ed8596b4ba14f0..4a1e3e3c0505aad6669cadf9b7b58aa4c7f284cb 100644
--- a/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
+++ b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
@@ -75,7 +75,7 @@ examples:
             interrupts-extended = <&gpa0 6 IRQ_TYPE_LEVEL_LOW>;
 
             regulators {
-                LDO1 {
+                ldo1m {
                     regulator-name = "vdd_ldo1";
                     regulator-min-microvolt = <700000>;
                     regulator-max-microvolt = <1300000>;
@@ -84,7 +84,7 @@ examples:
 
                 // ...
 
-                BUCK1 {
+                buck8m {
                     regulator-name = "vdd_mif";
                     regulator-min-microvolt = <450000>;
                     regulator-max-microvolt = <1300000>;

-- 
2.51.2.1041.gc1ab5b90ca-goog


