Return-Path: <linux-kernel+bounces-744158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC6BB108CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B045F5A62AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB026CE30;
	Thu, 24 Jul 2025 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUXuB8dU"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87B26E142
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355647; cv=none; b=BzBF8a6lQKjmg4qg/30pO4wECjoLNzsvdh9CzVeEONxrYbpGbaslQHwPUGXOzrZydeSzBqzAY8aY/p1XBOXtyaD42NlBWjwA/XWJ0CCFzasgvCTseab1oPKYMi7ze+KBKgkShtN2KSLbFRyxWn/3qvRGSyEN8/RLOzQs9mMaZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355647; c=relaxed/simple;
	bh=QUlUkMxYLf0SjVpBsl0OVkwsTq7YyKk/KjAw6Del9ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA3YZ1zTqNGIlx3fZH33OzFrsmtUVAOQyiCVRmELCQMfUoaMdZK0Xf9HLuOR/iSMC5N3G8HCee+RQxAgfnGAHw8XIEkGk/voQkwEjZb3xhllrVGvAasAFPMiI7XluaG5Nl7sHMctRSpk2AIil2ZyYPV2YMDuUvpBtfB9cX+mB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OUXuB8dU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae35eb87810so17035466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753355642; x=1753960442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlXiIo1YTe81LzNvByvFXaqoppLPAdO13nkKqXERm8A=;
        b=OUXuB8dU0RZCQdve72E3reseoZ9KffQ+cRCr6FIx1sQYUb8ZiSFECkC1Uhn5wO4BFb
         2Zjqen5Qv7xFb/q+ashmbPH6cEw0BtDrtvkxXvw7EXHtYZZ3tC48Wz4Prsz+2POr3fe0
         TROa9I6SVthk6efxrxsr+XHLkDJV7Y0EU2MHWcHed/L15bis7yTJqK/SdLuhTu/vaTDk
         CcNE6J6U5rKRLZFQv6+nP6hLc5PTpENqz6lowAyIKAEDZq9WL1Wj3VJQn4NVDFiNE4Je
         wAhUrAZGCkEtgwDBp39yqs1wgx8UI8yECLdGMa5JvcwmdxWLk6LjL6H7KmI2anvcdZSq
         bk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355642; x=1753960442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlXiIo1YTe81LzNvByvFXaqoppLPAdO13nkKqXERm8A=;
        b=i7h1OvktE3PmZWOSlvUNgJmzQxUqIgnQp0+69f67kuaIHeKYjNh6rgJ3CLpKte7ntD
         7GI4bKbT7AkHLjS/vXBCgeqpNVfQ7aRswbY0aeNNErVAPOHB0ifflnvc5n6ZFBFRf6XC
         Cxb8C5cLLa5XZdGF6rq35rEJ/gJuIY37yOgr+BWETVc5PrxyqYj02KV57SKSg95i2oXe
         8z4ItQP8lQ1WG51vdKDdRvpDYrFwLrh9+HU+kSUIHcmnMy64B8ppYA+05k9F5BbeOe9B
         KfdGPyJpffq9trFzvoWxhKsjaNH3TeexANEItAOi9HRWvhm+7FlqEOr7Ppjl2CkcF0x5
         7NRg==
X-Forwarded-Encrypted: i=1; AJvYcCXBJzldTbJgFZaWf0YS6+IaKS+2S3M4wjj6yxCgwTdInjc9YxqkZWQ/+nifePU6+XMmRpYY6IJo3Mt0DRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesbBTdy4gV2j+oQmycWztydRCGgcSfKixYfjPfopU4DBs2Dgs
	11Bm4hiREzzYnmzb6HL0fZ2CX2+zsGfniaNoibCsUlWr0y31HBZYp0aRLNPQYK3C/b4=
X-Gm-Gg: ASbGncsQfU0LXye7qJz20+8zVXhw+ypFZ93YW24YqH2GuIQH2B2HJnViYpQe4qonrQ/
	u9ifpfhu1EbSFxmQS6ABV6PItVnaDzfCWKwjUzLji1c6EKu8KGcogAH5EEdAD8+jmqCxRkqOmzP
	7CZIYAjcHbR2qnX49OdyTK7mr1hVO4t2UsM047LbMnIn3P1KNtN1qkschVv73ZUAn965YQ/cJWv
	c/+Il45MkurncLM3dHsaFTaF71UNn8WS7XhcQgoAKHGx6aiQAXjMho35RNyvhZbyXIsaScfHltB
	DSEspXEacY5eG7gX6NZx2CUIFlxrSQtjwNLY1nCR5nzIyIxKHD2u6uLmJtfnv/12ohemdDBH4/v
	9dv/RfVrCEIjC/y78BtbgtOyegxz0deQn
X-Google-Smtp-Source: AGHT+IEFsO1jeCJCKKhxjlisy/SsUZZ3OuDpWFhFwhM5aFP4wr0fQrdhbCZsUAkk2m0dTOMZzux8qg==
X-Received: by 2002:a17:906:7956:b0:aec:5d6d:2180 with SMTP id a640c23a62f3a-af2f8c55a72mr223332966b.13.1753355642274;
        Thu, 24 Jul 2025 04:14:02 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6b416sm98680266b.40.2025.07.24.04.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:14:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dan Robertson <dan@dlrobertson.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Stefan Popa <stefan.popa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Alexandru Lazar <alazar@startmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	David Heidelberg <david@ixit.cz>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Andreas Klinger <ak@it-klinger.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] dt-bindings: iio: adc: samsung,exynos-adc: Use correct IRQ level in example
Date: Thu, 24 Jul 2025 13:13:48 +0200
Message-ID: <20250724111345.47889-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1492; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=QUlUkMxYLf0SjVpBsl0OVkwsTq7YyKk/KjAw6Del9ZE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoghVuzHS4uXkyTU6sLVWBewujbkHFikNttM/IZ
 isOEeWsOKCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaIIVbgAKCRDBN2bmhouD
 10l9D/9DQ2PDHDgUtLpbh1bG9p4sGi3ncJTi0AN2Is3G8KmpxmpfhMyu1KOOykbxxWYASd5nQQn
 XLCKNWaU40/sTcE05eH6IeyPkaVbBAmrqOIKiWYnkGPWLk2hFeyeDjU1i/299W2erhYLqqImuFZ
 BdUteV1wXC9ce8uWNX0o14sewzu6cz7tRYfaCcM+TSmP/Ngj1xDy+4HOIgw/dZb5jaDN0Dkx+oF
 BX7F0Toypv9+/XDHBm/ToCHcF68AHBVsUH4Sun7kLo6gnUu8uqDZ3wyDq6inD9w+iUkkwb1kquX
 kunMrEATyImHxNK9PBKolSZe1BnFjP6qM/G796nPqDzotG3blFp7admLxwk20kfNBGgeBF9LGPV
 BSAbdxqQcxiN33p/icJcU6hLpEy7wsLgPguvVkL+3qwBWfKo9mlnlmf0GpyVGh1qAm5o9v3p/Mg
 T/Ut7KQp4l00G0fmEBvTELyk8iXW4KRMZTFoeNFChPU+iXoJCKRfY5ULOtpSzXYn8wJnoRLwVkf
 DSpoXxNqM1g8gim36z+BCRQgS5jFE9Miduv2EhAZQVedb+0Tu0Tep62i7ZLXUpl6KKGTCsmj3bE
 vAdNuW2Cslh5TlRotpuzZ+fv3XaVrA+z6fLaIfLrL18NXt0ptrlGhgOjMlhPNV8wLYZZ/RG649H oPxf6PSkRACc8nQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The interrupt line to GIC is IRQ_TYPE_LEVEL_HIGH, so use that instead of
"none".  Also replace the hard-coded GIC_SPI flag.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index 4e40f6bed5db..8069e99ddac8 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -128,10 +128,12 @@ allOf:
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     adc: adc@12d10000 {
         compatible = "samsung,exynos-adc-v1";
         reg = <0x12d10000 0x100>;
-        interrupts = <0 106 0>;
+        interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
         #io-channel-cells = <1>;
 
         clocks = <&clock 303>;
@@ -152,11 +154,12 @@ examples:
 
   - |
     #include <dt-bindings/clock/exynos3250.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     adc@126c0000 {
         compatible = "samsung,exynos3250-adc";
         reg = <0x126c0000 0x100>;
-        interrupts = <0 137 0>;
+        interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
         #io-channel-cells = <1>;
 
         clocks = <&cmu CLK_TSADC>,
-- 
2.48.1


