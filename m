Return-Path: <linux-kernel+bounces-891032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8ADC41A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D66A4F27AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB6A3370FF;
	Fri,  7 Nov 2025 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lpGTIAnU"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C93370FE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548832; cv=none; b=nAymPt7CQbBckFQSByAOznIPXH9gQxSH0MOjYEWoT0ksXdW16g1OnZU4MTsL7suvsPAhFs3Rrsct8R0GO+V8GzBZ8M+3MeU72Eobkjgd85zSE/1ocXE0+yT/TCXzmk4r/LMNrmJmPHdXc9QXVgiEYnbwszr6jySbsaBZ30q/afk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548832; c=relaxed/simple;
	bh=SSI0SDfdzuTFSZUxXbce1zwCpj2iLjVhwuT4WvAAlLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b98+0AKuVvXAFMNr3OX2P6fLrUwfyhmGWqRWwo1TLPhgULAIAM44pB31kkcacpXC0C2N0xQBy4I6Vpq3VpEj4GQBzp4hODyetP7KAuYmABbmSwm+lscKUd2CqY5bkIpSu7fUNrqSH1Bk0SMbSqHZpXrWkyZqdN/JxddIDjo6CK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lpGTIAnU; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-656cb7b20ccso495292eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762548828; x=1763153628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEuLcTpBWY/VBsTt3a3S2ALMGGYfGqylnafUO+qzJ7Y=;
        b=lpGTIAnUICOjF8BsUqvIoHlZiCLNOsBh0LQ8pbvttvkFXqoIer4Lty/RsyViPAqkEt
         WgOhkAQqY4O4eAE/wCLFdvHY/yCFztdzC3VfGN0l/mYOusXlsDDaF3Y0t7KDDj3ZKZU2
         2Sjiwwv/yjGgDH/GHWF+2okildzGtd+emmBt3Thbah18l2XnOTphtlz0qir6vuTSJ0bA
         6wyMqhB3nLlWl+PiUOBbGTL/YjzK2QqrtI8OorCqa7aSTL/TPUuTmoB4VcdCVNlZB/H3
         StsOmljIc4TngPl15QIDsktxDuiV9MIQvO4sXHH0PPvgppW5Z6wqH0VfKhKocr8pTEJk
         0Llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548828; x=1763153628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yEuLcTpBWY/VBsTt3a3S2ALMGGYfGqylnafUO+qzJ7Y=;
        b=rujKAjPvAeLXzedlQdYHT/iGRPU5ST/foQ6sMOvcTLhUszf8GzcAqjtDtIjz+3x5Od
         n2gTs28N4QjiRD1/yoSSJ2f0k4H/PpgzOWh5VyUUQAYAkK5yC+GmOdgxxUZBLS9J1dCE
         1Y3XQiZSGtMCB7e0B3yeZx98zy3/QgYuHL2/4PZV1WoNMjNxHq8cL7mUmf6SqPTi+KAb
         BT//4MW+TuIoZ+oZPaMdKQvlpEZo7+eXL51rvn/gtj+fIG41seUe2+mkjBWwVWKG2aJi
         Zb/qxFT2mRmqqq7DeAKmbEgcbV27MXV0gLXrf0yeHJW38qjD2JVcOJvoiPbuqGbqsCAi
         EF9A==
X-Forwarded-Encrypted: i=1; AJvYcCU4DaPZIFYVnQ2AB/dk3Zh9SMoAjciODuJh2Ab1MrQDKooGRnPupPaoMvuv4tQGLjH3WRFGIDcBE2p45Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDXnloxnppiIk/w9aZclQQ25kBWLf0M54dRZdElKR19TtIXTZn
	Cw1bgE5omHjvIB1srOOW0bQgk8RK1GSmmsQcun6dFmQSxs3gbkprCa9flqF2nzujuhg=
X-Gm-Gg: ASbGncsH4T4R7mXsASf3w6mXUO23b1i/nZ5RrUyS8kxOqCiHOp6fQMLWrJSca5svE57
	ltIhSd2tgBQzJd1uck49Lo2BBg8L6pUSNdl++9M7BIR7AnCImvvPd82VzovTsRPiT+jkpogG6y2
	P0FQQpY1QYyD8FrpXTaDxtpwJayiUJEE8Qdm458WBHHvlnQkyvGz2t80utbMiHJa+NS5ZPl5A4x
	J5qVEpCa1CkCnSrhvXcNkpnaYIGpT96rOfyYVFLmaKIxDOhWiHPBmwOkxsoYiI6yp6wkumdQIO/
	Ehf0RqexATdKfIXrYcpdweCB7Uv3LD2hMxbyQwKeNKKHqG0BasjGoUtwWJdcsj0F0bnuj2vBQqb
	snzyOiAxsYJkkc+ujrZ6r0djoWUYyYk5appe25W4cU4NY9Z8uNsI373mE9jdV4uDfiyyAZf6eb1
	bBfk9RGeu3drHxagU=
X-Google-Smtp-Source: AGHT+IELkzg/Of84t9nsWUqhdVT6cx3AtRHpbp9W/yhXXlclhMmomOmCFDfPyUuBjs5CBkNK0crRXA==
X-Received: by 2002:a05:6820:6706:b0:654:f200:1490 with SMTP id 006d021491bc7-656d1b95d83mr1523298eaf.1.1762548828588;
        Fri, 07 Nov 2025 12:53:48 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57eae5esm2915601eaf.16.2025.11.07.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:53:48 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Nov 2025 14:52:51 -0600
Subject: [PATCH v2 5/6] dt-bindings: iio: adc: adi,ad7380: add spi-buses
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-spi-add-multi-bus-support-v2-5-8a92693314d9@baylibre.com>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2055; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=SSI0SDfdzuTFSZUxXbce1zwCpj2iLjVhwuT4WvAAlLU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpDlxHSOYmvskhvEqT8odlqy/PkdbyYBsitZwDm
 oHuMNz9yqaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaQ5cRwAKCRDCzCAB/wGP
 wIM0B/4yu2sr3jOslO693wsOVfFOZsHgNwoP8mw6JTqbQykHS4iGs29iabDb3AP2v7dEzPqrAV9
 Mo2/6DumSMFtRFIHwUz4C5jY6iFWs5E2tRn5G9afvp/Eppwah99OrHWLsGxT5KMRJi0nJUP4R2n
 loEXzwW3FL+tI+qXP70AjwEDPtjC5pWymgUW/6l+roajx6Kv8+RzOAOZvusc5uJtqND4+sUwatd
 imEB239jVE3keaghxkQ4qrAhM3PrbnGpWSfwwxH6xeLTXQMloUneZx9HD/TZlUS5fpM5QOHnxvd
 +Em532FK9mUGEoKWISea9IvwIJ7WrljKaoW48YpHpQFxxSI2
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add spi-buses property to describe how many SDO lines are wired up on
the ADC. These chips are simultaneous sampling ADCs and have one SDO
line per channel, either 2 or 4 total depending on the part number.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index b91bfb16ed6bc6c605880f81050250d1ed9c307a..9ef46cdb047d45d088e0fbc345f58c5b09083385 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -62,6 +62,10 @@ properties:
   spi-cpol: true
   spi-cpha: true
 
+  spi-data-buses:
+    minItems: 1
+    maxItems: 4
+
   vcc-supply:
     description: A 3V to 3.6V supply that powers the chip.
 
@@ -245,6 +249,22 @@ allOf:
       patternProperties:
         "^channel@[0-3]$": false
 
+  # 2-channel chip can only have up to 2 buses
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380
+            - adi,ad7381
+            - adi,ad7386
+            - adi,ad7387
+            - adi,ad7388
+            - adi,ad7389
+    then:
+      properties:
+        spi-data-buses:
+          maxItems: 2
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
@@ -260,6 +280,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            spi-data-buses = <0>, <1>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;
@@ -284,6 +305,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            spi-data-buses = <0>, <1>, <2>, <3>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;

-- 
2.43.0


