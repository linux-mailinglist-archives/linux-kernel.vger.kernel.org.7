Return-Path: <linux-kernel+bounces-883592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE12C2DD1C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07A5834BE29
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6197B296BA7;
	Mon,  3 Nov 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHcHng2Q"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9959A296BC4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197287; cv=none; b=EHOwlrRB6Z3/X2x7ASiEsYOD9MNLYVf/bXUg5rEGEppcGWhcbNGxcgwCtL8x1t93q4oNmwSXP27lxvLBbl7AqT7qYX6Ks3M5XoPwxTrZZ7VCbs7WbAexie1kITjJlci4TuXVQfmrocdqNu/k7R9MkAmMm9/25yseI7cpHgdOLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197287; c=relaxed/simple;
	bh=ejj9kJsYojTy8kY0emUovee3HgANnA/sFYcyWzPbjL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZpElRBigPIyBooeHRc+Y7jQVx4H6cUKTgRbvwuAz81veGa/rYMMgYbGNXLaSED07s1H392kLaDehvEfJRZQ359Feac11hb2TdX/6MB4qAmdFWYQU69YnnaIn9E51jrkaxmqsKAMqa/WwpPlyaDU/6MBVO1AcNO1e6aQGcM09BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uHcHng2Q; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b715064bed6so111967166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762197284; x=1762802084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAD+8NeyQVmzpy451OsrQR3u3cBqGgc3vr3oTrRtuug=;
        b=uHcHng2QWSK+Z2p/UtkA7xpbHwoq5fAIaerhq4SwEb0/jepxhldfL5dVvQnp/18ou8
         H9hwbwD4uTBx1MynJHrlbOn1MI6u5554IKbVymh1QWQ//nhxy7HOISVRUVHZa6kNvrqD
         Gx4lSHh4EV1w5NrsjszbQyNZ0j0E/8FVDDAQGx6waNkHybbBHiRJFEVjsmaF5ZxUh51o
         UoJfr5PuF+xN6VzZWnwLU9oJwJdW6SRllhILl5tqpZrI+MIQG4L9pJent7xzl5XPRJRB
         KB+XmtJWutrNeS5GZmj7ExanfF4J2kQjv8JgHbOQobhGJQ259NrQ5cYuvKAPA9/ey6lv
         UH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197284; x=1762802084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAD+8NeyQVmzpy451OsrQR3u3cBqGgc3vr3oTrRtuug=;
        b=mpHoh/H4Jue/EC+NgJZ0Ogie+0xjumoaBIUxLUhploDSHw5+bcqaqn5c8B6zLfU7Vz
         jXsBamAsFOcXYJo7XUAJU5Wn5fPdToaKPq0Ia/6OxTkSTG0979YZETA8gL/RWTjVcdcR
         73V0T4LbAQ5eALFGlMvuxv4k8896kq5xRco5WYjvLoUa1Ljsk08JlYTEXqyqW9kvUCfi
         2n293f6hz3pZPzcxtdbSungcMyYrjHeF1U0Qpk+wQpV3jNA5e+TTeP+v1tSB1pGLd8op
         alRXYcC19TiOvJi8QbGY1RhAw1XULvOJ6YkU7WDR28kctpGR6uev5p0SwhVPC+vmiwca
         wmbg==
X-Forwarded-Encrypted: i=1; AJvYcCXFUPJuoJdJpIB77otwdMTngZnykLLXmItmHRJ3lFamdm/eV3xsW8vIUwe3sLcwOb2ADOflBC7sOD9/9eM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XDC/kn/TgANv9ufGf+JVHNB2OJ73n/fJ2PdTbZsckl0gQmlr
	H9m66NYYVMcDGIKEBtLN57NPNzkquROyLFq6mp3TZo8zPYF50S9Anb4k7+LZ69Lx+To=
X-Gm-Gg: ASbGnctF4Nhnf1wQmTwQO1yleG7ICt70za2fzh54eVyJnIt2uxL6MCziwxW4FHsya9d
	1MiRJNkBnjUPoMyUCU8v13r7f5uaQtc05A6TO9d+vJBAdMpH/JbSaXaDlsgKLFBrtX4q/u2dgYi
	DYy+Jfp0cNkIpjsqSE0k3beeSB74aqS0On+QK3d99VTOqSXWqkUfMoWWrJSo/sHUrQo/w0OSK3S
	yiQQUE00b+k7+ADISfzT92+Yw4bi3Gl8DnwvxlDEFX35CjdUJmmanXrc6azYKq1TzcZflQa5R+p
	cWxKWzNKlXtgZaFnQqo8cVYIfbVHyINj3OnrJpNqxtgJXwywmIJK622rXrVfJsX3Mx94GiLALFT
	+vK7awRJE2r0/LFMyWzOTSbHrMK6D48C+hZUI/EJ/39RXsb7Xqvri2nsZGjDV79V6rAYbnnX0XZ
	bwnwWFLW3tU6dSnGYbm36686SI3g5SyYDW6/dNyxAuluMWIyO1VIT3sIh7eau5HVkgfoBwNm0=
X-Google-Smtp-Source: AGHT+IH1Jz8fqW76WNvYz44wUTW1tTql//vRV5mtFjB41+gy5qQDi25+8ZqrUFo6A5byoIUzomDssQ==
X-Received: by 2002:a17:907:5ce:b0:b6d:5c4e:b0b8 with SMTP id a640c23a62f3a-b70700ad41dmr1309354266b.8.1762197283933;
        Mon, 03 Nov 2025 11:14:43 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm466765066b.8.2025.11.03.11.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:14:43 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 03 Nov 2025 19:14:40 +0000
Subject: [PATCH v3 01/20] dt-bindings: firmware: google,gs101-acpm-ipc:
 convert regulators to lowercase
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251103-s2mpg1x-regulators-v3-1-b8b96b79e058@linaro.org>
References: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
In-Reply-To: <20251103-s2mpg1x-regulators-v3-0-b8b96b79e058@linaro.org>
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
2.51.2.997.g839fc31de9-goog


