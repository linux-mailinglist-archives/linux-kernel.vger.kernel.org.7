Return-Path: <linux-kernel+bounces-750472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BC5B15BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A0C3BBC15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D7B27144C;
	Wed, 30 Jul 2025 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRoZoA1X"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758E27603B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867915; cv=none; b=Om6zzLcDO7/KSy4+GPsX1wvca6GjrcIWdMa5lmo4MX6cyy6W6LZAzTmxldpMxeVOeaUP9YdDesnvGleVY3OeGJbZAZFzMRYJUQbBCFr00Fv39ShbKCgrrFCI8c7Koy7cLUqGpxWDdtBys4HYrD5q0k8/NiYV0SHbVwdOS02fNFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867915; c=relaxed/simple;
	bh=z0sV7SsJGuqFTYd+996vC08KW4HD/oyOt5IUehYunPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZ6t61r44m3ArgCuKrVGPG+OTzeRts/udXUx/4cMBbkLMYnQDHgugnLBXTHlRTprlgGDGAjdAMMtFRSbXgdJRoUm/ws4MJX0hO7zo03H4/iriZEsuSI7/73cKlyUs/20qsQBM3/i6HBTzvJWq4hyLPBzjKfKFCx2qWIRp9q1w0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jRoZoA1X; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61564c06e0dso2991803a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753867910; x=1754472710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGjRMX4G/COI/IQf9/y2Lgcl/FQUEBYc+9lDliHqOG8=;
        b=jRoZoA1XKBRFDe+qdAVZjLUGo18CsWEeKrteg4OlGq5ZIrJIDCT5cPd/YXQaGK9S6j
         kmpdVMVY/y+wH230Zuvb7S4UlZaPkVheCTPpeQZesCrMwfwaGjshtlvwnDQ5zzdfQxKY
         odLg5WZTEQ0+/SDOZ6aGo7yil4Q+yl0PLprCgFgSRWPkHWD+82BklO+6ScMXcWkMGbI6
         3PSuOJeGoIeepz4r+0GUOrA2hwgeE2NOqCISk/S62Pob9SM9lLkGEpiJxCG8OAtnbMUD
         jWpLZtCygBJcahy9lgnufhScAtaOAKtoOcf+Fxa0l9WazCJqkBuVqq5TsFU4xdRqpe1j
         yugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867910; x=1754472710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGjRMX4G/COI/IQf9/y2Lgcl/FQUEBYc+9lDliHqOG8=;
        b=weHDFaxZOIQbcJAC5PcFL6iMzJu/TO2OAEOWkzf7iEnSXn6BrOEmECgLcHlgN+zMfd
         0UbDhtm6lp84pUWFrG9ek4URnek2zUsFg1HgjWwm1OguR1vZ+T+ELSuO8hASBln86j0U
         Sd3klK4b3AK4TGR/oLLcGw7Zh8KElpNFIlE6np/AxkD8SUDo05ooQ3AvfsSBFtHUnZ8b
         dbs5NiUqJ7ZOwuCMVFB61gdb2hGr+Ws/oEATg7pTER31PTEu9Ntz3X3hdLCHWDScasaZ
         PXnwyxkaiBRj2fFsXDcf7rBIWIubh7tn95Vx4HnWwKtY5Od5fEj3B5ZWCkgJPlkC8F1Q
         2LUw==
X-Forwarded-Encrypted: i=1; AJvYcCXNioo04rNU/MbGM4jEf571ZfbUeJPFw6gYukKV4b0GxMybf1zQ95Rh9z9wVZMDao3ac/BSwl5JqDHWRcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzPnm8WRjSvVjQtco42DpcXLPK/M9K3sFHjDqi6l9irMyMDvL7
	o51WfmoDXN+3qxADIC0ANaLMplZAVldJeX00T1om3dQvroCP61q9iJZcqS5POssgM54=
X-Gm-Gg: ASbGnctKODbgZS46R9rZon2Qndhgg0t05Cp6ncfufsbN9GRmi/j9iK4aHK0jOqw3Xip
	3BbBNvT9PnjwVh/wYsQ4GX+HQ+3o1miCKhYjQTc6SfUjiqQhypfznaGh+a5zu6vAQxCRE6pbBZ4
	XkXDqrcleZeLxJ8TFyKm5bUptzFb6nLpc7CNkqRol8CNv8NQiLyhMOv8gDuHHB/vTPUGAi0DeaT
	uU3/9FgORMwP230C1ODfhTWHBM0DSJ2Xx7GUiwB9M+R0xnshAFY8gHZqjZ+yTers0j9baN/Fkr3
	AuzPkZLK681lwu9UT1cMz9npPTiXoXYSf7+h3Nv+tRxjyKMf178AkD3HUnYPb68PkdzeIWL5/UP
	onkqCPszBndykuthRRGw9tiMO9wuBDg3zHqTyoqIAWTOl5t9coAm5+KvIEe1CzE7YSqnl+Sq2C9
	0XVWogXA==
X-Google-Smtp-Source: AGHT+IEUMxf3gSpGjkAUfDfzDG2wfz30DekTf/PJZewF4AZbZS4xARY+7EQX+t4IEFMHZ+3vt+QMSg==
X-Received: by 2002:a05:6402:40c5:b0:615:9b4e:7b81 with SMTP id 4fb4d7f45d1cf-6159b4e7f50mr683882a12.7.1753867910401;
        Wed, 30 Jul 2025 02:31:50 -0700 (PDT)
Received: from puffmais.c.googlers.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61536916dbasm4090424a12.43.2025.07.30.02.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:31:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 30 Jul 2025 10:31:34 +0100
Subject: [PATCH v5 1/2] dt-bindings: clock: samsung,s2mps11: add s2mpg10
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250730-s2mpg10-v5-1-cd133963626c@linaro.org>
References: <20250730-s2mpg10-v5-0-cd133963626c@linaro.org>
In-Reply-To: <20250730-s2mpg10-v5-0-cd133963626c@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The Samsung S2MPG10 clock controller is similar to the existing clock
controllers supported by this binding. Register offsets / layout are
slightly different, so it needs its own compatible.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml b/Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
index d5296e6053a1881650b8e8ff2524ea01689b7395..91d455155a606a60ed2006e57709466ae8d72664 100644
--- a/Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
@@ -25,6 +25,7 @@ description: |
 properties:
   compatible:
     enum:
+      - samsung,s2mpg10-clk
       - samsung,s2mps11-clk
       - samsung,s2mps13-clk # S2MPS13 and S2MPS15
       - samsung,s2mps14-clk

-- 
2.50.1.552.g942d659e1b-goog


