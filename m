Return-Path: <linux-kernel+bounces-789702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C88FB39966
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB5D7B8CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A294C30BF72;
	Thu, 28 Aug 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAtN/4dq"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC43081C4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376135; cv=none; b=ctWmhmUiE8wjaY9XJeu5xU3wyRAY+WGM7iK41dNGMSDPCdQTmrOzeKNXKrnb5m7tQYCUdVcUHEKgMaZ2ykV7NYsQtSAU1VwgfnoRFTBGp6x/RMMN7h805JaeBJGhAXTmXgtI3dzY7qVNcZ4dYvpQ/faXy4tsXOQE7J5BaA3o7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376135; c=relaxed/simple;
	bh=7zIHfbYuxqEFfC5pFIBPbouxdTNkb8pQDDivm5vTvI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYx2fAALwiCU8uzbsvH3SBQ01YWqcvn6Any1CDeXzO3D03jOk131kLPLx5mlprtArlrvf3wKQ2yVEfZ9spr2ILIBDNFc9TptP8mvnaaSrorZ8r7BslqrvlPwicW8y5YBJjSyafPYLkZ6DxBJwXs0AWLZc3bD09pO3EafrdpjIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OAtN/4dq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso5494315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376133; x=1756980933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXANAbHwVPpe4jvCbblWLvMrGtujuwItYgIeQizTWw0=;
        b=OAtN/4dqXpG6KxBIHhW/BUC4+0K6YlpI8t6t2mWv4WZdOLwvPkwgwzLhcopeh3gMm4
         uOmBzm5sk1F5/gzXoCkHQqmt2yz5phO9h/yaKndaM2UOoKGkvDAWtiQgkfoU3pQNZNuW
         lTVxx9VrsjItixBwkLsjjc2+P5nFeWDnflcJCuyg8dJT1K/sC6d6lHPaDWpCW2LjydUk
         fMeXWwXCxhINIuN2e7/p2oa/2vZ7G5A215WiLMT3e6Ph4IpD7h0Z+LGnIOD9xSjSyj2e
         obS4On0Mzi1l5T04quvoF31/zZzoM++eLCVZk2Rt26KEx+HmJs9eVkEgyJwRo+hr+Qal
         +18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376133; x=1756980933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXANAbHwVPpe4jvCbblWLvMrGtujuwItYgIeQizTWw0=;
        b=cGNBYQFVxwNQdaGsZMjLpTEuzR0Tx4nrXnxZ6MXqx0HOFP9OfylTUCF5yQdJPDptCe
         WAfEusrYkvL80qog3pfCvhldF1q/Ozw6HaUjV9lomv5WuU5eR4S6MPs8hQrvJ7amo9WY
         nRCxXfxL35kOIg9vPwob9tJMQ0kkoju/oYcRy31qxwu3+I5RBts7SyqpxKGT3fBQedku
         XOBa72sBH6+1EC9CUK38DmqkT3vTUSBrWj4eaTV0ZH5QqNOiMr3GV/Y9fszQgrgrQMj5
         aPW7fYUdWZR/M0y8MFbtMyNO9swYod4p2w+hvSVfVfDcxLfMcEUFNQ98UYd7amd/NhiZ
         WVcw==
X-Forwarded-Encrypted: i=1; AJvYcCVvZ5j4/5oeHiA0Pv7sb90PGnC5Hngv1fUi6nDkPP47+kpVNP4g8eqoVzTncybNE0ASqsCNBirjxV2pFxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAWrxct7GSOslkX7QGsLW1LFGgEVJBylmsrfT+yAS0fl0LYFX
	VfaJywfJq92JNOFjj6Aq1OPEfWzTR4YfJZnzLh5xDcT0RskThYCHXhajyF5UWpioknw=
X-Gm-Gg: ASbGncuLXIkpM7RxTl+dLM+yS1CV4lpWuV6V+7VojMtmweqZftArD7eR62p46m790RK
	AEr1vEydxaCoT1ApKuh6FqnryunL1hHSQat+Sl3YPkC43IjgQ1AxyuzLHL3oD9u6zK7YZh8jKPn
	622VDULqWVeUPSF25JPRp+18ijKZEaiNPHAFEbrioGs7NklmfX4TSCJEJ3cmSJykh4a01a5VCmG
	08eTfkABkrvQ5RBdTgtiIJmUpwWJ11rqdIVoWbZu33PZLQs3AzAF+KCzZoebOvf4QvLo5W1Kx4W
	YlIVPcSYVOOQFzanOyueSe2VwbMnHwtcoMv20Z2ceYJ7aqMMtH7Iz4H1Q46QBFs1by6dSKz5EpB
	nT/cw7oBJBCtPpfyV1lAClXBOh1nmcSI=
X-Google-Smtp-Source: AGHT+IEPuV+SVBjgix8/NEPnZ8nglpuTYsTPM2vPoIioxa72GpCO8DZr4EiqG2j2YOqQDR084wp4Tg==
X-Received: by 2002:a05:6000:18ad:b0:3b7:948a:1361 with SMTP id ffacd0b85a97d-3c5da741330mr16413826f8f.6.1756376132441;
        Thu, 28 Aug 2025 03:15:32 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:31 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:44 +0100
Subject: [PATCH v2 5/9] dt-bindings: lpspi: Document support for S32G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-5-6262b9aa9be4@linaro.org>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
In-Reply-To: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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

From: Larisa Grigore <larisa.grigore@nxp.com>

Add compatible strings 'nxp,s32g2-lpspi' and 'nxp,s32g3-lpspi' for S32G2
and S32G3. Require nxp,s32g3-lpspi to fallback to nxp,s32g2-lpspi since
they are currently compatible.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index a65a42ccaafe..a82360bed188 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -20,6 +20,7 @@ properties:
       - enum:
           - fsl,imx7ulp-spi
           - fsl,imx8qxp-spi
+          - nxp,s32g2-lpspi
       - items:
           - enum:
               - fsl,imx8ulp-spi
@@ -27,6 +28,10 @@ properties:
               - fsl,imx94-spi
               - fsl,imx95-spi
           - const: fsl,imx7ulp-spi
+      - items:
+          - const: nxp,s32g3-lpspi
+          - const: nxp,s32g2-lpspi
+
   reg:
     maxItems: 1
 

-- 
2.34.1


