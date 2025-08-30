Return-Path: <linux-kernel+bounces-792903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8775CB3CA3E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C471B2774C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F1279DB4;
	Sat, 30 Aug 2025 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRIg47MI"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9C227815D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756550171; cv=none; b=e94d3qOYJWVTEhGMYTPanpY7Ra8uJD09qlVBpgrNgtljqVssPrQAVPGWN3sRe3OSOcz2ltdwphSRjsbj9bjEUl4HQtVSryNWGRbF2lfO6Mss/aLrUooRjTk3IVK7QaX0GT89AEbCbz77wbliVILOR/7oVl4isMeXQel3Gp2u7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756550171; c=relaxed/simple;
	bh=OqkXFaVqOLu0Cm9orjJGa0kO4kQoIt5LQSmBFk9V1j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIVyBDzN7pYTvunM/Lzp6/JOE0wS3rPS7mfLTdRaJuEr1h6wQffYvee7H7tkAoluKIRFuZYy+YfFab7ooAgLOtyr67bOWTRzOA+PAXxmp09lDxbmJwyT1Gu8PCU88j853CjgP50gNY1oMdFBawFCEi140M+jvG9aoClnKHijUDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BRIg47MI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afe7f9fdb96so36835266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756550168; x=1757154968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xy2PldNrENiSaVtPT3x+tCYdtLAjiL+P5W5nR+7AJsQ=;
        b=BRIg47MITHOwGmcVnouy9G2W1oJcEfqswOh3wzGqc9NQbvKTk3qaYhJ8cCj6xYrktH
         KriOE1EoJB6OYvfIRzgjjQMBeJD1glLuKBO2ebaLdIiERLlICmmrThOJI2k/R/MsCX+y
         U/OMMSnqKDGIJdq/Pm9k1GrRwZYWzYDJeOzL2B01E6hkt79X4KTXp076kq7/cqgWbmZC
         xyxIf5SRaEWDu4lOG6Y0lkZiBAvPxmwu4BbZ5QxfdrH8+sFC27eMLlZ0rfBHsBOZZqfC
         ZrKcKr83Px36FIBrRK7DeVVqMduEnd+2CPcESGKWjD7fcPDtRrYVQ6oWcjg6koKHHHCw
         Q1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756550168; x=1757154968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xy2PldNrENiSaVtPT3x+tCYdtLAjiL+P5W5nR+7AJsQ=;
        b=krwst2tFYIQO3X/g408I0IR/KJAa0hfGTnYtPf9FN9D5Xbv4A3R9YcTpf3LU3lpdKm
         ecL2bpOSla64tOm2/LBIqyLCwisBhZo5Xkq51y4C3RQjBPqJa/b6mjThK6F/E7ira55t
         Iop30ocGMqvFyBNwfEdjF44GjNBb8HPKUy5r8GluNyAxshlLvqu34aqBP4pWvbHY/s6u
         TW2cpscdVFqjw1OSgZQKVG+QGknohW/OCV/cKsE1U7mpIrUo5dm+M7eqAN+q7vITyJjA
         Te08MqKWKK0x+RznNZUPJJqaj4P1OK3ebU0EXbwnCzfP2jjW844oHIDIl+by3QOjbUHA
         RPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEqGW+wTluuRKswDB9/6KN0JrnjOpDaUW8TjtLYdy5SguXVU9+AyGBFW8UQBpLdwtv9qOdesJfrklfpXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9nLkAzKyb4qB5Kk1bbMsEsIj/QXL+ixwm16t6swrOhTQtGG7
	fW+lnSYYkxqZysisXaRfWeXDEUnxLSnb/4pWIh8QfDBZ+xjPqJ6OO8djPZg2k1H35Ls=
X-Gm-Gg: ASbGncs8/ovXlJpZD4OS5/35TzQX6/sSlnCa72Ra8ilpJJMXnxbz1JV8t4BRF80X+Gl
	2oZNtYFbX0KAbZXNIk4irpzt3A69KoZBDiEVmW1hXXjrnaLy2SBtMAToj16/zZIFXVDrhhMMu06
	ry1jDybuU5hHbBDSnB91ihBBuCijEOBORx9FJnV0R3DCdaC6MjskFVktOWcMg2wlNi8VniBXhak
	o6dF4ay5MyUwHPPNrjTUHu6GS2cExeMocbbTb7OL2+7DaUwyXGnl0oSf+1cxFQfNbBW3xLV88I+
	dRVIXoOB60Y1ock3O0EWQDbxbb9l6qHUTD898sVW5bYE5GZBBJ2zq5Fy2zTo9v3roxHA6AoJBSk
	xlKqJ3zTw4N8WnEE+0ulWDcQlN8eQFXyVTA==
X-Google-Smtp-Source: AGHT+IHns48R/scKvtWP4TWucE7E7d46yoyfHop4qHeB2gkDdo7J3ardp9aE3MsDoUiXrG5oxykknA==
X-Received: by 2002:a17:907:94ca:b0:af9:6580:c34f with SMTP id a640c23a62f3a-aff0f132f63mr196770666b.9.1756550167604;
        Sat, 30 Aug 2025 03:36:07 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm393749166b.69.2025.08.30.03.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:36:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: i2c: samsung,s3c2410-i2c: Drop S3C2410
Date: Sat, 30 Aug 2025 12:36:03 +0200
Message-ID: <20250830103601.82046-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250830103601.82046-3-krzysztof.kozlowski@linaro.org>
References: <20250830103601.82046-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=OqkXFaVqOLu0Cm9orjJGa0kO4kQoIt5LQSmBFk9V1j8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBostQS1uyd9N0GDHCqVVSX6oqHmmLX/xx4H0z2u
 /GjYzXDLzSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLUEgAKCRDBN2bmhouD
 16V/D/sExMdSumruUenHBTZ2LC2Ld6Eo687uWRhy8+EsSXGEw+Dh63Bx4DG07nh1xePobQdweO9
 pv8xLTdgMUOyZPgqm9P9Xeme2Ys6Th0tgbwLHebSTreUKfTNYkfUtP9590Ze/KKhgg41m0XOkUm
 KLZeP0Whkbckym3b3kPdGRneHwICnfX9x1p0Jwkd023pm80H6+ayu0QojNI9fjndMe02bngi+C1
 ugDXAUHrayw5+1X5jxZp5wWCwgIyV2Hm8OpZoI3P2zGKB8UFmoGe0uZ7VeR/BWkk5fx1/vF4HjO
 eOLallZ/wPrlhvb8hd7uAY3gyVQ2Br2vxDmE6CVCOoZbm6jNG+/FCLN5qWZ1TXMbmwUDC5KTQZ1
 aIfINltTdbou4e3SGKTg00OTDTVAMyRpfwgQV95O7xd4s3t8SghtJAbBRu1A1EdFtEnnEgH3U8x
 /5Ozor31W3+P7vYF9lkWSb/j3Y0VcmeDFsT6/MoH2drVnpMLPqiR42HG+ca4GfVZBlNr+eo0AbH
 idjDWTsJf1ZL5+KKsPQgd6LOSCf8GJ0Wi2Wpl9brqQ9Irhmerp7ec0YTyiVdeidrZQjPViUaWN1
 HhAlj7rAacD7aqgr+pxqQPLSdrYm1kwjXXAkqlGL6n86sww9YULj2uQXqUg4QjQKd31jyxuSINx +JucnGYbFIy5ZEQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Samsung S3C2410 SoC was removed from the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of "samsung,s3c2410-i2c" compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml b/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
index 6ba7d793504c..a2ddc6803617 100644
--- a/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
@@ -13,7 +13,6 @@ properties:
   compatible:
     oneOf:
       - enum:
-          - samsung,s3c2410-i2c
           - samsung,s3c2440-i2c
             # For s3c2440-like I2C used inside HDMIPHY block found on several SoCs:
           - samsung,s3c2440-hdmiphy-i2c
@@ -93,7 +92,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - samsung,s3c2410-i2c
               - samsung,s3c2440-i2c
               - samsung,s3c2440-hdmiphy-i2c
     then:
-- 
2.48.1


