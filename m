Return-Path: <linux-kernel+bounces-775804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E81B2C503
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C03967B480E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907BA340D96;
	Tue, 19 Aug 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJ5OpBRH"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4801F4CB5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609359; cv=none; b=YNPiozk9Xp7vA2NMBzBcu9jGdKp6diEzcL3UES5a/OXjCLbRS+KdQXC702uh0TKb8mLmfp6Rq1Wu5kSElg5NmmYOjy7xs1jpRBDna+Dc7/u2po7bI+6xvX7yZPD9z+GtJ5rbh0SwmDWC8E5LwGWNRGLbq8R6YiW2NJAtwBGUyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609359; c=relaxed/simple;
	bh=hcciJ3JEjRJw2/6qsmBCQwKrAUZmXoESCyk80czkwi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNLtzLI0ilRzmogPqzsQvuHkHmG5XRMxl78vs6YnTw4CJeQ3CL503M0QDedSo5UUoeUhfNOcauNofeEJvI77t/lCC/LULDSlklt7kbfFrUaRcLIZsyGDwnBUxrlYQcjTCgcxDW2RRKvEvsZ3Ci67vZI4MVBeR63N8JYzhFhABl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EJ5OpBRH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7322aa0so75565766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609356; x=1756214156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OE5+Il4drYFb68+K9H3WTtaiI5C7tn33MG/1x7pFl90=;
        b=EJ5OpBRHRd5vZZDH2kp0mP272oDRB3gNWwvoge+dSzudHc7sBONPTirAHTE40s4jx5
         r/wbquSwBMwcn+bo7dw6KKupM0lcS8gxh6BkgX3yDJBERPBon6tHrhJno1ET48pPOKGt
         GjYv47dvQnF+IFBRJ+XsBB8aWWyo2dH3mzyDrgHGjMjpna24guS1Z7Yjzv21SrqgxZZW
         UA4hWT67Ysov1Gspgl4me/83jvjadT5S1SWxSqf0kHItEJDCzKZc+yTEtl/8R7oLI5Rd
         0sCwPsdcb0cFj3Etn900swvFZj3wqBMjLgmlqWD0L3gl2A8H+c8t+eBE9eM+cuNifS6Y
         ekmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609356; x=1756214156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE5+Il4drYFb68+K9H3WTtaiI5C7tn33MG/1x7pFl90=;
        b=FLWKWmJUz8NKWEayLL+eLrUZrqtpJewJoW9OvVfmctd2J+VbUPxwVRdzkkLm2wjiTx
         X5xb5LK5+lyKlQOhFfpBadHUJ+8R79kABp+R1YI9YZi6NsvavvCMSuivtlkJYtPHU6OK
         PgwxeQSkguU3LJrtm2cuCv7whleTFkG5nFjy53h/mWh5yen27cjNE/PQxe+keBZleW3W
         P5LJPWK6pqsuc2T8y8OY9KmKJNDseXqGyijeitqt9IT1a7A6FM99tVyloz8JHt7HzeJT
         PxKpx9JXPUIYOv0GO/pStE7IowmzT8zHzo0MHg025Epke9Frj9rSrj5DiFjWbUrgl43/
         U3uA==
X-Forwarded-Encrypted: i=1; AJvYcCUo35o37OWRCwOt4bGgPLyq/MzPAoBfxPAsZaz1C2/vrh6bSm9KxT2C1xXyK/AOJdP/fm3/FaioAAXv6d4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7t43dO+fGXf8xqq5gv57KaVVQJc9sJwQxQeYymaw00HGCs3PC
	+Qt/GyeFai6SI+4s5pSTz+PhEX/xsdW5/8kV94vltDiYDGs+gVhCKfou1BniR3b1c/U=
X-Gm-Gg: ASbGncs7XCDKihSisL6qJ/SAtW5nnE0TK3kxht+0TyeBEDexWIDfr+yof1HjBRV56id
	TkMwW1rX/0qDXiK2L0jB7kJoGcBZd3WYElqUxioBXX3fdeUDikE2VnKLgAMh8gcDY86fAAHvFrb
	QQpepwdi1fkf0EZIvPsUe4puw4Q1oAGNPuLHuD6W2EDtJLSzAuRmKHeqJ5jOxUBr+XVwUSZrPMm
	RBlyI4FC2oxhNIJ4SzhRr+1AOcwNJXfY5S4Ekb/aTxgHHS2odTHUOFeSfHrw6cosKagw5nxsCc/
	JB70tMoHfP+mq5xJ4ax77UHIDCfEVCMlhlfq0P9hXDQDia9/uG14WmB8sQSywYRuIIT0b9ZrZau
	uXiz4JliN5ZGxsk2W9lFYeMYoz0dV7OW7ug==
X-Google-Smtp-Source: AGHT+IG4KTbZO8LcfQ30OvU9YlImtjjMx+/FQDo5HoX0RNFAy7RBraEUBzYhhrqCR+YvCl3Qva33qA==
X-Received: by 2002:a17:906:d54f:b0:afc:d540:add4 with SMTP id a640c23a62f3a-afddd241018mr115990366b.8.1755609356407;
        Tue, 19 Aug 2025 06:15:56 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755f8a61sm1771773a12.14.2025.08.19.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:15:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] riscv: dts: microchip: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:15:50 +0200
Message-ID: <20250819131549.86279-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=hcciJ3JEjRJw2/6qsmBCQwKrAUZmXoESCyk80czkwi0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHkFB6KWZYNHKcB/PWHff8odXyHWo1X4hTKT+
 9yX28P0HP6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5BQAKCRDBN2bmhouD
 1w0ZD/0ZhRotOVRHIIlha+Ddf7VVmjL9AqsBqtw35BBCtjM/J1lBtJbZov664WjaD89YEJAqIm7
 1nDJAcrW8zyKPuGFZPkhgk7fS1W+e1lQys7mCiUHbT9gZaoEhhZ8QlRQTPEzmAOqjIZyRMqJKZj
 zJUKN69xKV5plTt0PSYoXZI5YXg6enLdYWu4WvAyMS4iCPw+zZQpbs47FE2iDS7i1GvfZVMb7iy
 1tFoY5YP76Z9gMnO6LnvES1ZXStyK3brSgpkaxwO/SxP2IrqHcV6yaOSh436BnnMAORn7YlRIMo
 Ooqq5rbcO8usuNli+NgYBu3Zn3Fmz5GlqQUPUG2ejNWG54mqlP8/GVW8zTb29LKa3uZtXOf2xlt
 3EmbX+6XTCeZNL4zvsMM915xv1yhREHodM1i8ibl+l/t9LOi71YIUIZ2zIxwOrkc0ak/4r+kiJo
 zQRRK03U9PBEGv/HGZeI+7AFB5A1DdLlU2MXm9EwJVvJ/JrtEdM/H+ngytiWEIDHe6/rP40QCzF
 v3lv+9QXttsQQlvkorfdMiX0KU2E8rlVufMAnnogVPd3T8ejG6jeEg/dhVJ+f8dYwvyq7eAcjvI
 8cFyAivH7Il/3SZGHOjGoJcRUnx+ByqzqHPIe3PI83XPdO7jKLerwGME6rnkniKa0oeUL8inC6Z Jjnz9NU7AfP7VyA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
index 47cf693beb68..55e30f3636df 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
@@ -88,7 +88,7 @@ &gpio2 {
 		     <53>, <53>, <53>, <53>,
 		     <53>, <53>, <53>, <53>,
 		     <53>, <53>, <53>, <53>;
-	ngpios=<32>;
+	ngpios = <32>;
 	gpio-line-names = "P8_PIN3_USER_LED_0", "P8_PIN4_USER_LED_1", "P8_PIN5_USER_LED_2",
 			  "P8_PIN6_USER_LED_3", "P8_PIN7_USER_LED_4", "P8_PIN8_USER_LED_5",
 			  "P8_PIN9_USER_LED_6", "P8_PIN10_USER_LED_7", "P8_PIN11_USER_LED_8",
-- 
2.48.1


