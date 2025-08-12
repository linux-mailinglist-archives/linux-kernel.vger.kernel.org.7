Return-Path: <linux-kernel+bounces-764894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15149B22875
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7CD423CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A127F187;
	Tue, 12 Aug 2025 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snffIGnN"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C027E1B1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005094; cv=none; b=f5riYxcFsQgwd79wnwhxwNUELhJ/ASt6vuqA47ZTMJ/zanH1xu8pxfBc4cAr1DyMr8eRvDsj8OkEKFS/Ekeu5yAZ6SZK1vnwsAUNNjikexlBsJ/jct+2S6Xjo6vXbvRCq3RuJ1o7i5Q5fpOm5Q1D+l1+NNCjB8yHEbwgtdMkUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005094; c=relaxed/simple;
	bh=Gf90/pHp5CpXSUGL2hjNMT/bBSAS8DnZpsS3Yd0qYoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DXtYZ+7y8aVJc/KHgcCagd4ZN2GVsQ20cmY30bGhXG7LlN7UkU6Gog+aOdJVB+zB9eIp25bBvLT7QkM9MIXyKtbwcnj1Chx+lBQU3d3Br5LPJ6dCIg4BTJ49uAIXlUY4Vded20ByFjm7sSVBI5wkcDiIIyYscEd/IYI/wio7JBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=snffIGnN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af95a5989a2so71174366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755005090; x=1755609890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8RI+MamHncx3o1Ahq5d696tmTBIcFmRxxxMBZrqMbs=;
        b=snffIGnN0R22OEyqekU+W9Kd7HuKmerYXVz84QSaM8mCGf4sklNmngS2zaV2DHbe5m
         YUA77+M6zR6Ey2kS6yNCxFCtWsvowSvJFBTH/pxiCVD7Gz8Wgk/T27VU1OXaed7oiXH6
         Ps4hWvg9z118CkMpiD2iRhtQD71Zgl18PCVNNhbOjQ2m/P3eK9iZfdgNLxkb+SlBcQDM
         vuonm14w8KFHRhGWVsRI8ZeHsTDIyzYFQO9Nsw7wLCP8vV1jSZuPCr3K2xbM0iX6UsZm
         U4+HoV5wAjGbxfgTBkLGaEUybbgSuGBbQzcALov9t+c8CYIWV4wiFRD6DuK/XDN3qcpQ
         zUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755005090; x=1755609890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8RI+MamHncx3o1Ahq5d696tmTBIcFmRxxxMBZrqMbs=;
        b=wGT7CzDEt76kRcNIuquLLCkO6rzwroqcvcr5WNS5PfBKMQ7jN2lhNQyy/A/Ydo3mS1
         XBDx6fKtjTN674TGNxHvD47cTVl8eWiiJh8ANQJVGIpoOr1C0piui6ZCOQCYUZbu0aJJ
         mgkh6OyDzPOQmF0Zk1x8z7C+JWtUUQpUhFWZw5d0bhVhUdIkrMVr8fZAuaY2rB0GR7x8
         mH7yMkQgOff+INOfy+Rx8j7xfo8fG1FAc45Yjry4g725/sGv6Ip9nDBNxJcPhNY1pCXZ
         NkFz1RUDsoZQtcE8UWsbIAapp5vu/fj8PXSKc1G88sy4O76rTujF9BlPK46oAmairXgw
         f5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhAH9YtejXBfh6dfUwfFsXaBkJEG4/xVO1I3Ww6UX2YTDakvvpUoFKqIsEvNWOXyDtTJYX0McqIpZTS1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHlhEclFGpIwXX3x2XNqU3dnchhvKoVOqM90RKqwqkADCS1bx
	NTKuZKYQIf8bfs9fkp+17R/wAVTKmJb5ZSNnoa25cXepY6uJkV6JjOeIja3jfsNohcY=
X-Gm-Gg: ASbGnctLLAPo/XJsrBlLHM7cnJ2Pe+dFB2K7TsRtO+MjmOYhQCrrLh6GNkdG++mVzn8
	XGNvooJ0qFSQ3dwi9wVS1qtT6lpeFaZseI6tY3ddbOfEa4yIktWDLgqu+/E3ng/mtiiSS7I9iX/
	tVorJpaaAX9u6iryGOLOHnRZPmiOFO29HIPxc9Kpt9qJQvmeq3cnJxYbSGV1FG/l4TdILmQBwbm
	PoFufm6yUBPWJdrm4bEwrxR4Mii+/w5mQC9bQH/XpaGw8bXIYpxz3/lhgeQrrGhwUyc4Lk91Kgw
	0lqjZw0OS8JeUXzKnn68WqNME4StsajDIFbTfm+WGofZeYrt1HWoM+XZI6pcQ8dWZImEGA8/IKI
	RBSnQu5VFZ2Iw4qqq5A7UcNhN4X3HDgJqxRR9r+7Sm8JV
X-Google-Smtp-Source: AGHT+IEbGag45vPX20LYB1WfopE+qzWBntuEjRkdvpr5wWxVk98Pkdq2jfNu+AIQodZOnj6MJXuypQ==
X-Received: by 2002:a17:907:a44:b0:af9:6666:4acb with SMTP id a640c23a62f3a-afb8d2889e9mr47673066b.10.1755005090215;
        Tue, 12 Aug 2025 06:24:50 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0a4sm2209111666b.109.2025.08.12.06.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:24:49 -0700 (PDT)
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
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: iio: Replace bouncing Analog emails
Date: Tue, 12 Aug 2025 15:24:46 +0200
Message-ID: <20250812132445.75398-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5871; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=Gf90/pHp5CpXSUGL2hjNMT/bBSAS8DnZpsS3Yd0qYoQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBom0CdLawzbdg5SHABJ9mkeI0NywQinQuUswts5
 DApnJGmm+CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJtAnQAKCRDBN2bmhouD
 12WbD/wKouB7wmK4OxH3waJb/3ZCqzLwwlhmFpjI4NuB+iQo5Fid4ueRvVHHg9NxUFXWSSK2VDg
 vGYLlAVkVQ+U6p2FxaXymZ5xEzJo4p6pvy81RWQ2x73nYMixgb+oVaarh37iQclF9HIBVI52gXc
 y8GuXHyLe6VVpvPkditS/yYIBqEEmU+RUode2LqB2F9uZbw68c7VR280C6P8PD0GIwEEtV90I4x
 5bnWwrR+BUUFw9APBMBIMg7ZGmT/H6m+UxuQErTykTCTnJVmnucXGL+EpoUjC3nW7Fy+i9gpgWa
 kYlrBTANxawQY/RTxkqtJAfz96sYlmB2SJa5sOFy0zGxt2AsxHe62yjsp8JCHdhHXdQ8zBxYce6
 3btPxFq7ZvEfIWhRB3waHQ+JK6Vz4AXdKI3uREoo9Kg9htXOJN4yZ0iYbQhkHqGHIfMBF6OxwDj
 07HDx/HGk0VHD3sQSkkn0lCMh+Gm/eD+AlM5gI4ipO4XXf/WDEf/sLOMgq1NkmflvEfCmIJUlnT
 r3BfLAmhYFbWsFqV8j5xRDP+feRfMq0DW5vBfkDqekDZ68aaIGprL9PusGpNupUOHyAvkUG5yvM
 7Cjq43BklNsp4bpUb7hDHTDxdQPDrqWcAnqoYfr4qdgWUsbNq5a5rv72EVz48qKRBE4wi99r13/ WdHa7GH2Nq+Ofcw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Emails to stefan.popa@analog.com and alexandru.tachici@analog.com bounce
permanently:

  Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'

so replace them with Marcelo Schmitt and Nuno Sá (listed alphabetically
by first name) from Analog where appropriate.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2:
1. Add Nuno, based on discussions on the list.
2. Add Rob's Ack.

This change got agreement on the list, but still would be nice if you
folks Ack it formally.
---
 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 3 ++-
 Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml   | 3 ++-
 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml      | 3 ++-
 Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml    | 1 -
 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 3 ++-
 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml   | 3 ++-
 Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 3 ++-
 7 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
index 3dc973b98f81..a92e153705f3 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ADIS16240 Programmable Impact Sensor and Recorder driver
 
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
 
 description: |
   ADIS16240 Programmable Impact Sensor and Recorder driver that supports
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
index 88aa67bf2280..0ba0df46c3a9 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
 
 maintainers:
-  - Stefan Popa <stefan.popa@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
 
 description: |
   Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that supports
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 7146a654ae38..4dd5395730c1 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -8,7 +8,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices AD7124 ADC device driver
 
 maintainers:
-  - Stefan Popa <stefan.popa@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
 
 description: |
   Bindings for the Analog Devices AD7124 ADC device. Datasheet can be
diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
index 5207c919abe0..eac48166fe72 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
@@ -9,7 +9,6 @@ title: Linear Technology / Analog Devices LTC2496 ADC
 maintainers:
   - Lars-Peter Clausen <lars@metafoo.de>
   - Michael Hennerich <Michael.Hennerich@analog.com>
-  - Stefan Popa <stefan.popa@analog.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
index 82b0eed6a7b7..091cc93f1f90 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
@@ -8,7 +8,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices AD5770R DAC device driver
 
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
 
 description: |
   Bindings for the Analog Devices AD5770R current DAC device. Datasheet can be
diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 53d607441612..2e1ff77fd1de 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices ADF4371/ADF4372 Wideband Synthesizers
 
 maintainers:
-  - Popa Stefan <stefan.popa@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
 
 description: |
   Analog Devices ADF4371/ADF4372 SPI Wideband Synthesizers
diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
index 7a1a74fec281..43ecf46e9c20 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices ADIS16480 and similar IMUs
 
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
 
 properties:
   compatible:
-- 
2.48.1


