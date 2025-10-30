Return-Path: <linux-kernel+bounces-878670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5A5C21367
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E21C74ECD6F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A110C2C325C;
	Thu, 30 Oct 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyNcFOBO"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB012773F0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842093; cv=none; b=Rklq71Vin6Mf4JjIYtNHWNdZ3OB084+unvswKzBpBjQLRTl3uculpdnkPoZSdhgblXdMcFc12Qa1zV0CbqbQYfuzukoyQ8Ik/EGuJhzE+OhP8OoDkoHTK58SbWhaxYbWz/1Shxl1aO99NkmBpf3cr4ELtxFixx24BUQarr5ZXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842093; c=relaxed/simple;
	bh=NaAhwhcT0GhzI+5hmo8klT6kVaD5KvGtkWB20H+nKZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gv2F+J/OaG3uREPJbzqJ1AYVg0s/6y+ApvFpsX/XDbGLu64po0D1SPMV+nrnQwvcZP/Jp/hSvSGioA6gY2Q9IWGAtahoZI3rj/obW3HlNeDSGj8Czy0MRUY8gq/unT2guaYluUtMCeVOVB2RN0GVL2f142uFOI3oO7N4Oaq1Xu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyNcFOBO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cea7c527bso973947a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842091; x=1762446891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EesdB0mWIJlesJlzqwPz+0cVXOTJiZY2fqJ5tr7PE+E=;
        b=YyNcFOBOwcqd+gjRghfjhtKssNBcr1TD9lZ+tRS4u72c8GFJA7pmFRY1X0Q0RA+Msl
         jQtRbQOQLZquGhfcMHaGUGrWqn5tWOx64tFwmKZSqNHTQph3qUZP4ir2vCBdZjadkLSK
         pN1tVwVQGEKV6SotMUpdq+JSKc42yR86VuLzgjB+Q32kBWON0QSsbXpkf77jU1PhUAFc
         S+DBpjhpnO23HkNSOArjMpDeFw8479qbbzsrvbt68HelR+ZF+jMpoIOgCxO5ZZd1diHP
         hFdiIfDgeoIIpDfYmagOt6OblvOl0QOOuxmDjRrvu8fwoA1JmYr77R0rKjrKosds0dZ4
         ZgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842091; x=1762446891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EesdB0mWIJlesJlzqwPz+0cVXOTJiZY2fqJ5tr7PE+E=;
        b=UXms4hZ1mCxIVMyxm3h4gm9MLiEO3s5y3+nWuluxohx2aSbQPc/yFfJ/wFdM1CTCBS
         nEtn9lW7Iaz3EXCcvzn0Tpr/V6DLq3tg0pYJ77sxxVtyaGQJzHe5PNNsGhg7curWrdhv
         QZ7SftcZtGChCvP5H4+oBm9fuUKhr0TArG+FZchv7nKhXISzN3VKvAGipqFVamn0ksvM
         Gm0gqsDVU7S72wpXYo0iDpocetUg3l4oG7gcXzz+zzPju0GVCYetNDRK/e8RBFFTBV2u
         RxG6g1ISybGqmr63F2RvVFCKF0HvXqtezg7t4YKI3cn6UCD1ZrzcgGgNT5mdLnu3DCK9
         IYlA==
X-Forwarded-Encrypted: i=1; AJvYcCUglC3F0A3Hvz59z4tuakThq/48Spu1lI9yUgyv8Kmt8tcuOBZqQ9U6N8Z4htNWhNU/FEoV5zn7ahR4F3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NBm4Iv/3KmKyWVTWI0rugOhBKKcggMGLKxCkfYgI3sAhCRRz
	/nkw6h/TSUMlWSIaTIOzbaMZqo2ADx1N9hbQDpzg6ZamtTMte3ZeCH9H
X-Gm-Gg: ASbGncun5Dy23zbtyxhf+GHErgNqr7uB98vCroMXXkzdXKG1cLThX+fxJ58ENRxce4U
	GI7db6t9mg2wUcwPphkLOmX8e8hOarPPvuTzBc3xFskjTLzQ7gGncjF+Dxjv5uRXkXy4WYQKtNg
	SkDK7QcD8OXl5ki4JLG5SZMg8i8aDa6fzqvuQYQSelbLw5QvO54Yh+qVP13l31SOJw9kaWtma8m
	XSdB4Gki1FUEtnMmRaQjmC3+Aw33CDiZgzgmL6IR+XUthbYlfkvL3Wsm/0ZNllVBKjk9sjU9a48
	youDBKDJ44RCI/YjlxK2A7sivvTZ1Fkp0ogly4FLBYN0h2LP2YkZ+0pD2lFEB4CmWKkmOYQLJwH
	3D7OhNEUq2VXj7KxealOJ/Y6UqxrIBvHANGphjK/wZi1SC41J/ZtD0DxojOGv+fehWT/PJk8pa8
	fneL0v+oAtfWtYfHHAy4vTaXb1kDQBEAJnJk+SCw7igKUR7B1g2SNFoA52llKrgdbkrFAc1j0XC
	+rrZDllentoV+hIBChduAY4OJOKtq+grju9t+WdHXnvE7I=
X-Google-Smtp-Source: AGHT+IEOK5HPt/F8XF57/daB9IQTS2AhlduO2GsrV+6HzQnWa8iY1lYUOXSbd0WJUC0DwrxVWqok/A==
X-Received: by 2002:a17:903:246:b0:269:82a5:fa19 with SMTP id d9443c01a7336-2951a4aa4b6mr4203125ad.45.1761842091135;
        Thu, 30 Oct 2025 09:34:51 -0700 (PDT)
Received: from ajianan-Latitude-5591.. ([2402:e280:21d3:2:339d:c9c4:e069:47f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm190932845ad.100.2025.10.30.09.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:34:50 -0700 (PDT)
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith Anandhan <ajithanandhan0406@gmail.com>
Subject: [RFC PATCH 1/3] dt-bindings: iio: adc: Add TI ADS1120 binding
Date: Thu, 30 Oct 2025 22:04:09 +0530
Message-Id: <20251030163411.236672-2-ajithanandhan0406@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the Texas Instruments
ADS1120.

The binding defines required properties like compatible, reg, and
SPI configuration parameters.

Link: https://www.ti.com/lit/gpn/ads1120
Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
---
 .../bindings/iio/adc/ti,ads1120.yaml          | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
new file mode 100644
index 000000000..09285c981
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1120.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS1120 4-channel, 16-bit, 2kSPS ADC
+
+maintainers:
+  - Ajith Anandhan <ajithanandhan0406@gmail.com>
+
+properties:
+  compatible:
+    const: ti,ads1120
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 4000000
+
+  spi-cpha: true
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads1120";
+            reg = <0>;
+            spi-max-frequency = <4000000>;
+            spi-cpha;
+        };
+    };
+...
+
-- 
2.34.1


