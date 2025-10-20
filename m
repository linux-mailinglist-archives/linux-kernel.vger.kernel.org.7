Return-Path: <linux-kernel+bounces-861369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4151BF28D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4150A18A4E78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB0A330327;
	Mon, 20 Oct 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k859wTNc"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB232F75E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979155; cv=none; b=G5UEQwqco6xmmFIW95ha3x/88O+Uz77tMAwCoqN9FyanXTVDQ4kY5AI+//Y1luq3WqyCg0YGOq+9jzXgXGPh2DeuECIo2KyQ90Oo5Y572wQQYU3PaMUj42QLteL6TR6o5DucQJ9SPXWv6RHfPKDdk+ZWjIcVrnSGRsLzxQt5btY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979155; c=relaxed/simple;
	bh=VGY/x1kIS534CzT9D6vJ0eJzvz/olSx+22wEh+RM81g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRQup6ULvrjzS9DDKijW5cdjugS6yxu1CnCzrQn9bGVwlRnJqTNP42km28IMSrf1XUzJpWQOAHMeWf9Im0WPvK+oISADB3S80q+H52ab2Ah27q3MkhWluTSjV1gGSXJpMFKx3f/BNkJqmllkBQug+/kWQSr3kIf7T5EzQzyU7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k859wTNc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42702037a01so677327f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760979151; x=1761583951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvrXdPe/IseXzzKyTO9oasxSIj9lw1Wz1YtOS0FGX6A=;
        b=k859wTNc5mVZdxvkLXOn/7shR1+OoGcJEYNWBjQhFtc8S4yD2onMY2jRbDx1hIP2JV
         y3RfnOApysmLF6KMnWIyIuYOFwCPGWRPc2JV3MTPltMO2CiME9RNf0zpHOglkZkvHvjy
         K8UFZbAV09VGsbn0qz+RJdATZxXTeepGQqRkqoXmBmsLOBkyrgWQsS/RH6Fz9DnU6pwf
         P7eHL8x+RtR5cJjRDOaJGNxIISglZm/jh28lDv+UACICBQtMCPRq8+zCA5WFBMvkfNNN
         DVqtNdMmK6zcn995JuNeMqTaZaSw5rXiQPwmztaIP5JrLRJoJXbmcblRXqxvdXcETwtY
         lTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979151; x=1761583951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvrXdPe/IseXzzKyTO9oasxSIj9lw1Wz1YtOS0FGX6A=;
        b=ncU+R4TRelIEtIHYW2XdmGNbpMSHARgz7dtH0aMyXAN4tu/LHmGCbtlrgm57qVCkly
         g2OW8gCQ1N4u1wqITV92uKm5OGKGtsKmEL6ePAuebzJD15NugChvEd51ORbbqBd/kbLh
         QOc1fF7EHcw1XYlyX2Ozgf/pVLmYLJr8IcjzRFZYehaOR+9YhR43WTE/3JtyeyIr3iOr
         WxorYkK6xIcewq06bmuUCcujSL9CoSJW1mVOe233owmVJ4k8JRGdAJKWW3ajrhDpUpz9
         1nZqG9/HBboSs11DdAdDuFDzs1uJPGBTTiScKiedvY0yuzGoDSHXndHSnr89na/UowK5
         ECcg==
X-Forwarded-Encrypted: i=1; AJvYcCV4mCSpH0byOYRmDmM2iAD1rGzsIkDp2ZULEqpd8qbfRwphrW4VrWbkJvxu5vHkYMZ0xpySkGYJtn4uSqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynqipn+6xhHm5liKUc0JEPOrhUKga3SHxURFmHdlTjoWSRkEPk
	MW27a+nXYQbQk4ZBrEZzIWjFow2D0B28hnvZm0j8Cex1skXmFc5CXCQr0FYqEirDUNE=
X-Gm-Gg: ASbGncv4DKWB8I8YIwgvX8XimZJIpUt4bdmlTPPFPv2W+1B4zEuy04lfeFwJbO27VbG
	BnQciq1nu0eLqWZYW1kQITM1IexVs9VHkhkhN9wxjpd6nDFkTyJ+D/vjeyACuYwe+oYYNxS3NCL
	sGAScPbY+dKtX/j8BVKmbeerPJwbR/PmiCcrzTMkgRqbifiiJvzOOtNp4SDvnm6sZSJaXw6eTbS
	N8B9rFRZBBbXnswPwRK7YwPkufedq25gg8Z1pRuhz3As5ZkM0484KKE7FU49ZGLsVL8+JKB1WcB
	lsdgjAlQ4QWyO3SeuYkZvhdXV/5leZpzjd+HVGACwm1q09ATn8MZBLAAPYWtVjlF4uzeE7oCrNQ
	/82yGpDb28QAVDSw07fi0CSwdfybJeJEb8SF58NvIUw3e1ra3X/6MTQ9lNKdyNDJGgRx3RtncvJ
	sd/a9jctgZvH1DXLVz2RYyPvr1OXw=
X-Google-Smtp-Source: AGHT+IFs8+VDD1HwDzXYd2o2JzNV58PxChHEybIBT+0O2/lgmpW4hTOAZB4Fzu7cZ2Sy3ljLLoCDvg==
X-Received: by 2002:a05:600c:3b0a:b0:46e:3c73:2f9d with SMTP id 5b1f17b1804b1-474943059b7mr2017135e9.6.1760979151310;
        Mon, 20 Oct 2025 09:52:31 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c82c9sm238324695e9.14.2025.10.20.09.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 Oct 2025 18:52:20 +0200
Subject: [PATCH 1/3] dt-bindings: watchdog: Restrict timeout-sec to one
 number
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-dt-bindings-watchdog-timeout-v1-1-d0f3235eb327@linaro.org>
References: <20251020-dt-bindings-watchdog-timeout-v1-0-d0f3235eb327@linaro.org>
In-Reply-To: <20251020-dt-bindings-watchdog-timeout-v1-0-d0f3235eb327@linaro.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Timothy Pearson <tpearson@raptorengineering.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=857;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=VGY/x1kIS534CzT9D6vJ0eJzvz/olSx+22wEh+RM81g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBo9mjJ8OEV9qUVjKuKJKKlc/IRRYs1ynjO+igSJ
 g9Z/tH9QTqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaPZoyQAKCRDBN2bmhouD
 16XfD/9rrYKLQfAJSyG6Tsw9kWsTq9GZLMH5lp38IseC6ZnSDkH/mighSdw4exin9C8VcTzSPF5
 qFksakzrJrs5ARrgorvyK+2vtznBHstBXSjOVYMLSCXhrBiFZYGUCPGNUpyf4Yg3wvY13UBS4N0
 TDGMqf1qbwIJdiUugff94Jrw9FLuTJlVjcoktBb+Gg9R5sf3nDxl9oF1hlurHr86UHI49JzNwq1
 kbQfQwiQPrctM96lR1rLAV4MMki6O/qEVKtsgq0JTvIpJmL9kacAIunUzzjkpA2nzZY+iEXvUHw
 Oe3lfKDI+7UU5QnVN2StwzaRTIIaNcxqN+Zj3F8k/hL3F4eZph7QtOozvoFK/VgF7C2hf9OphYG
 xtjQUYefJkVOHHF4aE35ePxtGYm1wC9Ur0UY3dBl1wQMu5lDAIMZmMv1uJiMqvB5h6ufo/YOo7w
 clhGq5l9KGVypDUA2hEqXTHURkgnZjUIQWpVgQBS/Tw3pW+I1Yxh+XHQss6AD3PCAt7pzhM0xhk
 9B9Hm1rV0TPGiexiHzn55suF2E8DmrW0MuevC+WoRPmPwTzdERSjC2Zn+aTuZ7t1vREG8FDJBnm
 DSCzBaUnDFBUBKtA+UThzqruNLRiJfdqXDdGoBKeyX6kbaAQrW/8E6WP4WgWxLfqDYTBCw1DgXs
 ur6Zm5LCck24LiQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Linux kernel expects only one number for the watchdog timeout and the
type is an array (defined in property-units.yaml in DT schema), so
restrict the property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/watchdog.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
index f0a584af1223..be0327f587eb 100644
--- a/Documentation/devicetree/bindings/watchdog/watchdog.yaml
+++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
@@ -24,6 +24,7 @@ properties:
     pattern: "^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$"
 
   timeout-sec:
+    maxItems: 1
     description:
       Contains the watchdog timeout in seconds.
 

-- 
2.48.1


