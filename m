Return-Path: <linux-kernel+bounces-744157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C31CDB108D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE8818876AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B5726E17A;
	Thu, 24 Jul 2025 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JdcniV1r"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139D26A0AF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355644; cv=none; b=aInZXkQMujkX9ai4kae7zf7BQRRjUH/hbCUlRaeHeRN9ufo7jBw7n1UoHoqJ1AJ5CV55I2OtEOcnwfXrQRARsjr00qUPXpvW7iVIZ6+2emuDKT6HkvRbkGTOM/cAFgojABRF006T+1kjosWYLfUC02atzLUr4Hft9lmqTmF2C8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355644; c=relaxed/simple;
	bh=zYD7UiO3dez7RbH8uvDCPOH/dX9cX5UxYcjvd1wxDbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZyzniA39R5h+FseihdlW6GCKPvQPaB62SVrMxR6PYtN/3T4+z37eIK0fBS3qGgAYq6Kd+re+xonhO0JrSg2hwOBWOl4MaThvAU2fTp6i3jvhAlJdImMdDrY8ncVCQrCo8yN9OJTPDniMlh+wCVd4E9FjbBXee8EGSYTBDPhw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JdcniV1r; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae6d8584e08so16120666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753355640; x=1753960440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGjfPszrVrEVOxka0UUUD+znsu6IGYgXm5WWAeRergQ=;
        b=JdcniV1rtzmZYxuFD9KH+D6fIZy89PYXWaPLGA2rxwi4tPKEHis45Ynu05O5Bz3NCB
         vwFD+rrhD3B+HBC2LD6DcjwAGMRhEd/1gwHmbwf9Cy2naWd3WykW0OUSQ/pTKVa2fOWX
         6zCUtbqcucjWqxnakDRA1lm0U7RRXDEalCYgdwmy71BMML0KxuAgAowJwWSakh5ydnQW
         ulUFgqD2V90KPTtY8JaY0all+8B3K2B/Uo3BLE8EoNu5qrjavRHX3QV15e9qTJ1rhbZQ
         CS9pF4KN0ns8OxmAopLjqmucXQyH2myePdb9DVR0aWxtXmuBzp57SU3m9nfX/CB6MkMi
         wt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355640; x=1753960440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGjfPszrVrEVOxka0UUUD+znsu6IGYgXm5WWAeRergQ=;
        b=mMLbguqpIS3TUUjyEpk64+dMDXI9gAkbn2CDxXWdBxf7Ngb7eNAcRCBMJcHLuOTbEV
         fAhwlnC1J3AHCqcM/EQ7iAEZAYQom7YzH2/N9P3ZOfbHJEeMe/MI6Hzz5mXEg/qWhC+n
         +nTZA7pYkm2WpqCoC+7yxcJHN1xlj/a9O83aoRUUMmX+p7wrgwmXPNBbRNxLDhaQLCbK
         1uqebHs1TsGBguB0LtlsUM926k8B3v54CssTOiVrJu9BEa1DTTCNJlKifNl1YCRG+euS
         1pcnztHqA0JBGTIxBOce0NA36XXBfv4lmur0Mh3G1xq3xpBiXN8+X8sSb+Wyoq+viNBC
         WPsw==
X-Forwarded-Encrypted: i=1; AJvYcCViwW95BuEOrgv8nyBcHkffTvfaHgIEEZmWsUMn2zGpagvMUqhl9VL/gJziAu766NUTomSIc69j8v6zVII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5hXrRWBIOkapLnF/3oYYh93h8Ygngf7Be7JWukeKV97AvYuR
	ArKmZ58PlP4gYjYMwWrLqyvcXa0/Wtf/3a9PbriA4puo1/hBxxm6qjfpQfuV6JCzgNA=
X-Gm-Gg: ASbGncuGm6SzWJ5yqGEL8wfXL+yNLI0JeirNY2OwARvA5E3dixcu60RFsr6yCc0vVI/
	gG+/sDqNkA9TCCNdGICiIYhVeToRnszekJ7k8y89w+4SzVAmpAohiOZIHFiLbmyKtnGOnRWaLMp
	O/jsCxWvUIlR+bLKVRbA/5s6OJfeUB+KtCxQXgjUhsxA25aivS8yZgCZCjSuZYK7sBvObC2eNCZ
	rI688uiyJ21qaLThM0TLT23E2eAn/9zvYxA6TdPDT62iiXJQ9lu2ZSlUYhX/8EaidsTv3YstckM
	71IoTKoclF0+gM9HYCNrhcFvyfdB06JJ9NLObOQ81u8PD7fvkc56KAGQtq2fQlyt1PTO7QYRZ0E
	+lXSrPSXV0naDwW/qnCs6sLUmbhME61kq
X-Google-Smtp-Source: AGHT+IGT5QDdYa15M0nAX2eTGKcvGeF8vLhDDbNPFrB/tqkQztblqIfePsQl2N6GdzxuxEtq31HroA==
X-Received: by 2002:a17:907:6d23:b0:ad8:8702:bc97 with SMTP id a640c23a62f3a-af2f8e71cf2mr227712366b.13.1753355639425;
        Thu, 24 Jul 2025 04:13:59 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6b416sm98680266b.40.2025.07.24.04.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:13:58 -0700 (PDT)
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
Subject: [PATCH 2/4] dt-bindings: iio: adc: Replace hard-coded GPIO/IRQ flag with a define
Date: Thu, 24 Jul 2025 13:13:47 +0200
Message-ID: <20250724111345.47889-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1546; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=zYD7UiO3dez7RbH8uvDCPOH/dX9cX5UxYcjvd1wxDbY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoghVt6VNb8EiMjGMt4ZyBRzMjh+nf+5u/Li4cb
 AspQBZbA7iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaIIVbQAKCRDBN2bmhouD
 1yreD/9pAXwvGQvWMsustFAtHpbJbZEysb2q48IDvkbMYbOWCebNv0ITYPDGcuruq2O708eDewd
 YmVn88qZDD0cLdy28IZfI+xQ5USH50CizIjVevVOjhCd62C2jt8GzLuir+zh0ImdWOYMpTSad9p
 dooXHQX+Kwn4+5CjOKUWRJliaYpWWHubOlVDTaeX5/zzPMMJDWM5NrQVqmF6Lrz17U9HvQgkYHA
 5ybZe0Q7/szL552pc6G/b8QCu3igFe+kpgVKt5aaX7/kcQAnI9m9zVXBLiAilqe8zTyGwlwuTfb
 sbqx6OPnH4VsKrRXcomLJC0e077hX+ArYstwfo8prizIQsdcBpf81EFxYq2bt5rEe7FMSJ4A7me
 t79ep/dKYeNiDbWU18ut1Ha8IUdwqWaeBiKjhv7v5aPXnLR/vTAS7b/6W6+yoz7MUvZUTj9U+tN
 1eMDgfKBJVXu0bX+oywTOVNdDMoFasdPCy+ZYMRlWOpVKSAXypnFw/aK//zI4eZ8zo8uiPC8PMD
 Y5V1i5PXiyl2fPd7rW0tlldrzDfHegX5E+C77NTfaBhNaXmq2vgRpvWmnbGoz8RfNYlJzZlfCjD
 p+5fWU0WqttjpSIu2LzQsvEDEgsY06cxoI5hQut4/Y6ZIN032JG3YB+5lNjzz3yzgU5axclQ9XA Ni4tforndR1vKWA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

For readability use known defines instead of hard-coding GPIO or
interrupt flag.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml | 2 +-
 Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
index ef8d51e74c08..592854766583 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
@@ -63,6 +63,6 @@ examples:
             vdd-supply = <&adc_vdd>;
             vref-supply = <&adc_vref>;
             spi-max-frequency = <1000000>;
-            shutdown-gpios = <&gpio 26 1>;
+            shutdown-gpios = <&gpio 26 GPIO_ACTIVE_LOW>;
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml b/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
index 503285823376..4a8f127de7e3 100644
--- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
@@ -81,7 +81,7 @@ examples:
             reg = <0x10>;
 
             interrupt-parent = <&gpio1>;
-            interrupts = <29 8>;
+            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 
             vdd-supply = <&dummyreg>;
             iovdd-supply = <&dummyreg>;
-- 
2.48.1


