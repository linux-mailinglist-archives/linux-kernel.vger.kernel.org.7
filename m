Return-Path: <linux-kernel+bounces-834688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C90BA547A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 695747B2909
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978EA2EDD44;
	Fri, 26 Sep 2025 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egdhpLxX"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2B29DB8F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924143; cv=none; b=VMLxx+t9ojjmrblpZN289CUq+xRCIpaTD5AbnKJXFPBtPrkZLq48M/TIvHKmIM9qZDoBy6N4He9BQepYgr6ggL/pEldGiPv1NO/t2Gq4V2tCKg6Qvofy3GoULCVZVuNKmxQctqv8B70WjNE0Nu6zyvP28ROFtZwn7NLjll9KUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924143; c=relaxed/simple;
	bh=RWsMT7+A3hOigM/6lKe9y0xp7C7c2WQ715Dnkvpx1sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rTQXtAn2jcvHDCC9eYUxEPhun+/Hwofe7ni8qq1S7uw2UMgr8S4h6Lb/46AtI4cs0DWIIfYWb4FRY7kHZJuu/L8GxvE685pes35L9fjqV9XuYWx1PASgGcJ4Hp9WMczv+EMfh6fPY3g/OHY5yiIUkXMQ0Y0fM2rZoU2VcVD6ovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egdhpLxX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso16890765e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758924140; x=1759528940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EXqlzb/n7e+U7sXee7rlDRiXcbYy1hChaEgy4phOls=;
        b=egdhpLxX/WRPeasW/TVeIuEPLWLBy0B+WW++zRdX9QbNbb6ZJnh5twu6ZJbHeOANwF
         ZdJ29y3wMNCkZvRhuEnUmv+9/K9GNri9rP59hsw0h0N+Sj6UZwEeBzDQ7yj+BZ/mHlnW
         zd1jkEDxXRjWART3KPX07XgCi6yRXgZE/9X7CfnNrpAD0XRR0DBf3toDg8iPMp5hajPO
         B9zbh9sKNTvutVhM+JW/3ki4T2gufWaWzM9baewI97/oaIm+vP8kDf33SN0SpB7rBz10
         j+qlyVkxaZ4i8JyX/CHSjg8g6SCR3SyfbZbzNSF00St/d2hrLMZNM852gl68g2jnMx/g
         iq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758924140; x=1759528940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EXqlzb/n7e+U7sXee7rlDRiXcbYy1hChaEgy4phOls=;
        b=YVBOGA5EH+kE2drFoSfClB7qmZb0f6dH4xcQ5cRmqieOecZdpp7RGveJAkZ+ncTZ88
         xHeAUDIntAFBwHYQWb0k6pDDx98s9BEC0i4rEW3Da0Ff7ris73GpgmYIrzHfpaRgPc6o
         v3UptxayVphBctjjI9hvg/O2EuyAHU0A436rXaywGek/zA1tTwcRWvShh/CQT9oSv6y4
         kjKzYgrU4Gnb5Z+K1XYm7WwHK4v2JroG8/dMRkiLRyRybtGCQfmOWlGzjMTkEPS2WC/s
         1qQcGA7plzpP8iDWqhSaGC2yaCeyNJBmb5/TPRh6k0dKbaitfsiaHb7f9Eklnd1Z7Vyh
         0nsQ==
X-Gm-Message-State: AOJu0YwR7oCNlzcBmMEJ7aR+sXtUGiZgxS7KgXfirrYaui4YajA7VDn+
	fk6mLTKd0XNDzbrdq/eclPoTxzJPoP2cziuCGahJRdqFREE7bStImVGX
X-Gm-Gg: ASbGncsUERRw9d3eMQ+6V4vcI5vyVGDL6AfXPhi8X2gRlHBJ/jBqWhrg4q5TGwGQL7/
	FuKzXnCgzNOchVS2aSrq+qAa3YkAvAUWa0qbCkXAVczL8W3BbAvMsEjJ03dqXcILdO2B6U95DVz
	zx9DW88yidzTbeBjo0FwwQHKO6Tpcw1y7iYKyVkD3CKZ2GhwLWGZOxDSAYaIYyCR+bHmsIrM1HG
	Vwsn4mxDPm1qCzJVNkR9yp89Iu7GLEubBsGnxw6Oivj5kIuEDtWptIdfrwrHvSHcRJo4XibvmrE
	S+BhAAm9nHsHXIWmh4o7GrqFHmYq4IbdDu5mAWvx963W/wtVe6p47plaWDrGe3kX4BOI/PHEWro
	HnMrKGodlf17q8fK6Yd9/kb/fViQAPaluGeHYnWZ+
X-Google-Smtp-Source: AGHT+IH7h/zsn8iwy7dlJ0ttBXRrdAaX/ZYDdVFTzHOC6TZ+3whZtpTRUQMF7FAeTKjd4Lk6HMw8ig==
X-Received: by 2002:a05:600c:64c4:b0:46e:36f2:2a62 with SMTP id 5b1f17b1804b1-46e36f22d9fmr62324725e9.27.1758924140002;
        Fri, 26 Sep 2025 15:02:20 -0700 (PDT)
Received: from localhost.localdomain ([37.163.230.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2965sm8410236f8f.55.2025.09.26.15.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:02:19 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 1/4] dt-bindings: iio: pressure: add binding for mpl3115
Date: Sat, 27 Sep 2025 00:01:47 +0200
Message-Id: <20250926220150.22560-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250926220150.22560-1-apokusinski01@gmail.com>
References: <20250926220150.22560-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPL3115 is an I2C pressure and temperature sensor. It features 2
interrupt lines which can be configured to indicate events such as data
ready or pressure/temperature threshold reached.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../bindings/iio/pressure/fsl,mpl3115.yaml    | 71 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
new file mode 100644
index 000000000000..2933c2e10695
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/fsl,mpl3115.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MPL3115 precision pressure sensor with altimetry
+
+maintainers:
+  - Antoni Pokusinski <apokusinski01@gmail.com>
+
+description: |
+  MPL3115 is a pressure/altitude and temperature sensor with I2C interface.
+  It features two programmable interrupt lines which indicate events such as
+  data ready or pressure/temperature threshold reached.
+  https://www.nxp.com/docs/en/data-sheet/MPL3115A2.pdf
+
+properties:
+  compatible:
+    const: fsl,mpl3115
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    type: boolean
+    description:
+      set if the specified interrupt pins should be configured as
+      open drain. If not set, defaults to push-pull.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@60 {
+            compatible = "fsl,mpl3115";
+            reg = <0x60>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT2";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6..918d4a12d61c 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -113,8 +113,6 @@ properties:
           - fsl,mma7660
             # MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
           - fsl,mma8450
-            # MPL3115: Absolute Digital Pressure Sensor
-          - fsl,mpl3115
             # MPR121: Proximity Capacitive Touch Sensor Controller
           - fsl,mpr121
             # Honeywell Humidicon HIH-6130 humidity/temperature sensor
-- 
2.25.1


