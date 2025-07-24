Return-Path: <linux-kernel+bounces-744199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AE4B1095D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B882AE02F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A866C283FDE;
	Thu, 24 Jul 2025 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMChI+KB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1223D291
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357120; cv=none; b=HemQyRbioAem9zLXJlm4Ji3rQocjylAHbO4hm2hU9h4gJ4+eNHpekxR2Z2ZXG5oS/LIWXrhcnqPXwkzjNn6SFLYL5XH8t08G7LN1tQHjT9aCAWMDgBHKKTb/f2eRaLn/5TlEnNR4aojO3YLnUNJgljoGb67QuT4AL+eDI5K+oJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357120; c=relaxed/simple;
	bh=NkMGFi3p/c6kYxTwl4O888JKDkgwIVuVoG5nD328Dwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0wZzSxo5DWMOGlEe4BClukHzIX7LTSdnAMQES2ZwXAI/hsaeH9NzGtbB+lav2h9YD+k5EfUaJB94nhGR7PoW+5xgRf4AJAdF4v0nqcvUgUBGAuY+LITRRtoOGotDlto4fx8uahK8TV6ytEdagvAfBgwwo3nNMKs1qFvpAW/fhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lMChI+KB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-455f151fe61so495805e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753357117; x=1753961917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP1K4/AyesLutP+RsWSuK64TNdkfVSYVhgI2t7U6AVY=;
        b=lMChI+KBcrg2TR08HUoPhRiNvteGfMPXg9DDl7YRDdI4vCAs7G4fAlm54kzPenugSJ
         96JmDSLoGFMuHOyMQqHw7tb4uhN+WyAY7+vsCoAX4pdLTEdaHpQQDrhevFRpGf3xKk6r
         mAB1y+VGMcXclxTE+wDUQ3tmhvf5tb4ZRsHSJ+eHCb/x4pzrXcdgUI3sEylFiEpOxnH3
         iQnuEH6WqhwYArwCT/OOVc+I6LnwggXwobcCWBjIPrIXnRT++flNbtKa/MwrRtSbz1po
         i/z+iNrknIrN9Xk4+6TiSLO0KWWF0zz47UOX5PcvM2xV+Si72dJO+DUn/LFLnvpm+8bI
         VRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753357117; x=1753961917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZP1K4/AyesLutP+RsWSuK64TNdkfVSYVhgI2t7U6AVY=;
        b=uoDY+UQ6WeL/2LmlUUarQiuVzgjp1lZsVTuX1RnGTYuqkTJPWaSdNBCwH3DxwyPuZz
         7izO+gdzzm0hvXeswUo8RG3wIRSW4CrMM2O6nM+Ve2Tw+Ix0HJhoJTLANoxPmz1k59fg
         N8EZcWHHpd3I1lzSNxayKguqarJNVBHNjmcWsr2pd2chph9gOVOdgE7+G3pm/3NvwCKr
         HmFxp7LFET/4B+yWBlyB+HOmg59Or/TBI8wOJ1PeA3v8pSEvTX7oT/1lKxcuZG4S9TFk
         L8yDyvcE017eEieRBVErWVGpoPGkEItDt/TCLzEqlAaHJzDYIhYHkEAS3JxSqZtSO9Id
         ziyw==
X-Forwarded-Encrypted: i=1; AJvYcCWO1FNne3qYEy0R6TeauiK7WOYQqvnmWgx2ahwhjjYcM9QqrggzYAnGZPM2/yBtrWfMVOtvwyZUyRQli/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CbQLbHmAjmXQD6xzO0G3Ca4F9ot1EGwOzDLOlkxawPkD0S+P
	WnleSotQzUtr0jYEpNVByJW+p0oIvLO2Zf3C+06B6MZl64oU3fhDwPpzwoZTJlbKUT8=
X-Gm-Gg: ASbGnct/5SlTnwChBc2wvOmHslYKDl3YoSWwwDEG2FJqE2qF1APj+IuTVYcVjc19/Ml
	2HVs/dZVsqC18toKzDyRq7DwNIFuQRdTMmoQobORlK78HCwrr5c/qrQCxNueGsSr8Lj/HnAztG4
	bCrdz+b2YDu0Kbngmq50yQQ90vJnKrv5G/KZsg4OzII61RD6cS1a3kRO2X+3Z6CC4vQQyUL34x0
	5GNmyNg5wcXL4t9CqzRUcfUs3hDSrhWUwnmgmK1dtPbwkXDhu5B1jC6pyi3/qffFCDda70YG2Xz
	KoLFCFMrcZJpc6ysG60MvH3yseAkglmw6GTBtqVIXr6k9pkHQaUF9Be3+vnSpRLLBCfqY1oKm+r
	RRzMRYKBF1wYnC5g7rbpi8uRO7ndv0eoN
X-Google-Smtp-Source: AGHT+IGJovsvV+Udvl43JVG7zG6hcSS18i/FprIMOEeqKVHDNHs9rT/+/8QdJpPDobp2mvdjmrAffQ==
X-Received: by 2002:a05:600c:4e05:b0:453:9b3:5b70 with SMTP id 5b1f17b1804b1-45868d7e0f1mr20719995e9.8.1753357117136;
        Thu, 24 Jul 2025 04:38:37 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcb888csm1913059f8f.59.2025.07.24.04.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:38:36 -0700 (PDT)
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
Subject: [PATCH] dt-bindings: iio: Replace bouncing Analog emails
Date: Thu, 24 Jul 2025 13:38:27 +0200
Message-ID: <20250724113826.61998-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5564; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=NkMGFi3p/c6kYxTwl4O888JKDkgwIVuVoG5nD328Dwc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoghsyKE4QqAMvcESOFmKNB/B4cDT6bZfowAkjU
 /PJSJ04CGmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaIIbMgAKCRDBN2bmhouD
 15GnD/0UT1uTaaOeXKKbWxjuPDDInnv+fENGDm7QwsvjqrPMS069NzSH3a7rfr0VscLaYZgm4XK
 H8BV8m8pbje0soM0TV7Zz/auzZKzpHSTWc8FZArkMVbBj57Zsn0yvsEpIvkOgUHcTOuDXCbJwv6
 5uZSWAa5thRN71BD05hYmMKmNHI/GDl1yGeKFEeCNfXX+CpHMadoKusyNxO42IoGNR9HqUX8bem
 v62cKr4EmQNlcs0CHBqkSm1UJwrDqRKoj6aJwRVK0nCykndv+OU+nMwzXhpePe6NfoZd0bOlWwz
 sUOnQXYkU0ml10xNF/wadoyYT2KjUpAiMKVz171R/IsmhSuKEued1+OP56akCi4IMamJkjsYTSs
 npKumOTjj46myjZDfwswiD5TrBcHfo6rJ8hqBIU6dSj4Wsvs0eMXWSIb1glwc+TC7u9tnti3wuS
 VKGU/iuZi+AUalK7Zu72vhAWmZor1V21LHHLxKWhaxlVZSPczzzpyep71kYoNjEOyGW4UK5FvAV
 PvGWQcQNW6LKeiYZtfOK4VNwx/uMBBWFPUkr81NVO5nLq5yhV5aUiJwOfKFVCtgT28Q3VDw3A3v
 Wkvs9d2ho1xG/CJAWMBUzpmzdbMb29MuabX5BN3wtP5nLjCT7CCzOC2afxtKc0gdZKlhCcI1/K4 cyBeN2rUnsxGvNw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Emails to stefan.popa@analog.com and alexandru.tachici@analog.com bounce
permanently:

  Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'

so replace them with Marcelo Schmitt from Analog where appropriate.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I don't know who from Analog should maintain these devices, so I chosen
author from Analog of one of last commits.

Marcelo Schmitt, could you confirm that you are okay (or not) with this?
---
 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 2 +-
 Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml   | 2 +-
 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml      | 2 +-
 Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml    | 1 -
 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 2 +-
 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml   | 2 +-
 Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 2 +-
 7 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
index 3dc973b98f81..40e9a40a7a60 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ADIS16240 Programmable Impact Sensor and Recorder driver
 
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
 
 description: |
   ADIS16240 Programmable Impact Sensor and Recorder driver that supports
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
index 88aa67bf2280..55e44c9292cf 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
 
 maintainers:
-  - Stefan Popa <stefan.popa@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
 
 description: |
   Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that supports
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 7146a654ae38..958a37def56c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices AD7124 ADC device driver
 
 maintainers:
-  - Stefan Popa <stefan.popa@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
 
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
index 82b0eed6a7b7..058df4c8ddf8 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices AD5770R DAC device driver
 
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
 
 description: |
   Bindings for the Analog Devices AD5770R current DAC device. Datasheet can be
diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 53d607441612..031b1657cde1 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices ADF4371/ADF4372 Wideband Synthesizers
 
 maintainers:
-  - Popa Stefan <stefan.popa@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
 
 description: |
   Analog Devices ADF4371/ADF4372 SPI Wideband Synthesizers
diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
index 7a1a74fec281..e49d5e6fab61 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices ADIS16480 and similar IMUs
 
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
 
 properties:
   compatible:
-- 
2.48.1


