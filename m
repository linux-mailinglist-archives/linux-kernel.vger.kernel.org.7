Return-Path: <linux-kernel+bounces-769268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C600B26C43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5373D6281D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC6306D46;
	Thu, 14 Aug 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjbXN+IY"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC64302CB8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187641; cv=none; b=NNC+7/qaznM7niNN7Psrip4ntfBteBgPwvNwDGkZ895cJTHxRxRsIx14q2bvePWMDh4/2+nSXwYNN0+uKSVZVYrLVtwKgl3G6QTRciw0mhWtqLyqgyfFbxPBpKcy6GBiWFLdJ8xJe5u2iFTQRsW9FPY9Y5nYDQX1Gm/TFtYTSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187641; c=relaxed/simple;
	bh=+rq+9BGDr8wJ7iR/RwIfiOewQa5sKFiC9C2659q5u04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uHJZcHHRybBihOOD+AVSFIlR+HqpgSk5vCscE6ZFUgVZt63VvW9E0LQUiUAWaukM+qCflg3A57MozF9OTAwc6SJPq8ZkboRu4BfpjLv0JZQ4b0+w3RLJQBjp9mO+zCE4uWCEs9lMe8No66zQ/Ryy1VrXqs20n7BnQn6Cjn5syCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IjbXN+IY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so7599395e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187636; x=1755792436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdsFgMvzLev3pjfqMcBF4MpZ0JDQWqKgzuICi66wU9g=;
        b=IjbXN+IYqeYBNZdqhxXrQUSAT7XYY/KjSN25ICMHW/uBv8+Pr9s1+oW8bw+iqj27BU
         4ntem6jamDJNDSPdvsoheJavAOW+4Pw3nJr2wPtQ5rqtzXkH82Gyk6Hxn3yfzY+0KHUq
         LxQeHWl5DlcKg5wCm2PCZq8a7nIeIXvBjKCr202c0jBp/JxaLTeJzEBBSMKYPwiF+rC8
         54RL7T2ilR6jSKkUnTACIB1V2KbdwtVNAFHKLymWqa3Ra2ZFRP8q926O/m/CPFj3VuG1
         3dhw3dA5Q3dpOh/eyaUFYy5a7WxVg2GDQP7NMYAa25L5Z8JDIG16LdfuSHsyLqg/Rb+r
         rA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187636; x=1755792436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdsFgMvzLev3pjfqMcBF4MpZ0JDQWqKgzuICi66wU9g=;
        b=lMo8olaDSpWZ6oZy6tvKvhruW1wmORJ1WEHl5QGZ7KgXt1+EvWcBeXDrKXzg/deQpX
         m6JbppFGxY5txlCev9H6me8Sx/g20R4FdTgmzZhB6vFnsAF1bwye1FzP0w8jtQpxz6kK
         /tkLCvMpz9DcDdG81I5w7hij5CW91BR6hqZvy6YUYbxY0qlxFO8WVHQOhuGVFcgL8Vyc
         glaymoGYbrqMBU9HoTGau5mXeHcDSu/qoPvM4VdNgzLjE/00rEwMeI+i23mxfVx1Cdlj
         o3+HP8LQIsEUWbq3Xt3Iqf6440FEf0cPinVRFELdplWh6cWHS42L+rBgQAN9Jtx9JsPy
         CHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4krfH54/uph4bbSBtIRHusM57q9mKhEBqr9g2d9zCZ1t42gcEFiyhvKaPYCkXOMaV/lfhW4i47NVGF3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5mkrUt84VFvEGomWLdtBzyjUxKy4EnpJYRFQ1oK/MsFlOR1Oe
	JDWKU9nCF7zNZm/5SJ0XbcjYEgcxKrNcPjolL8fp54JPPCLZEYmiLjd7eCDx3tH+SnI=
X-Gm-Gg: ASbGncvKu/2o9YYoPb9m9Ytzd60+RYZ9+8sqrBtSmhepnzjzG0dnyGDDcfXYQD431E1
	u3rN9u2c4fLaxuBpKsRLvRxQpY8ZuEd/wiN+st70z08pfxLaBrC5k86sUQzC4LodBYL5OtWHer8
	XYbKIsfGoaK3PFSQriajnuSQxewe7N+iW2N3s5rgvcDMxGF272qrDpHGorw0qabz/3+bEuNkyN8
	0P3682yVht15qrNWNQUofmj0eZYsmtxv1ftiHWCh9toLCYG09AZ6GAuRW9ZELheB3hq4go8rNqG
	G0t+7TtvDe3qNp/VjFyrxWesJvomDY/B6z8NbPbfgL7v0q3GFBL31HObk0ZiN/i3PiG9SoEZ1y5
	cCp9Z7YRCshPGGrg+Z8xeXlBpRR5scsE=
X-Google-Smtp-Source: AGHT+IHYk5C7hCYyM8ADnaIqffGtiumP8f9Dmz3RPTAWKY3pFIZH3LXw+Mpypp1GBsMLsBv+UgnJRA==
X-Received: by 2002:a05:600c:8b4b:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-45a1b61eaf8mr35450955e9.13.1755187635781;
        Thu, 14 Aug 2025 09:07:15 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:15 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:52 +0100
Subject: [PATCH 12/13] dt-bindings: lpspi: Document nxp,lpspi-pincfg
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-12-9586d7815d14@linaro.org>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
In-Reply-To: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fugang Duan <B38611@freescale.com>, 
 Gao Pan <pandy.gao@nxp.com>, Fugang Duan <fugang.duan@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

Document the two valid pincfg values and the defaults.

Although the hardware supports two more values for half-duplex modes,
the driver doesn't support them so don't document them.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index ce7bd44ee17e..3f8833911807 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -70,6 +70,19 @@ properties:
   power-domains:
     maxItems: 1
 
+  nxp,pincfg:
+    description:
+      'Pin configuration value for CFGR1.PINCFG.
+        - "sin-in-sout-out": SIN is used for input data and SOUT is used for
+                             output data
+        - "sout-in-sin-out": SOUT is used for input data and SIN is used for
+                             output data
+      If no value is specified then the default is "sin-in-sout-out" for host
+      mode and "sout-in-sin-out" for target mode.'
+    enum:
+      - sin-in-sout-out
+      - sout-in-sin-out
+
 required:
   - compatible
   - reg
@@ -95,4 +108,5 @@ examples:
         spi-slave;
         fsl,spi-only-use-cs1-sel;
         num-cs = <2>;
+        nxp,pincfg = "sout-in-sin-out";
     };

-- 
2.34.1


