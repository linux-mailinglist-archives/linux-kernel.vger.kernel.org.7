Return-Path: <linux-kernel+bounces-880184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3920EC25122
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B194934D5DB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202AC34B1BD;
	Fri, 31 Oct 2025 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/LYzlz7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730091D88A4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914725; cv=none; b=eTGj3nptcrxo7vlnRDbbWYUW21Wp0fP25UgRAzMBSg4qpHRb0kMbglTxL+Ik2CrBNXzpqtRejUlmdMKQds1lChSgmAGdyyybI/kGS+ZI0dcjdItwRGO1pSUZ3sGRsibM3zeIrDRN1wKTRQk24OF1tCe5rr+BUQU8HzQqu5EFMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914725; c=relaxed/simple;
	bh=sdrHsJNK5w1wePKRU9wLpHaRPe0gYufMWkbjaBq2T7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYSkGlWgjf2B32Gx7Eq6wFWvESk0zreDk4PTe57eGyrrHrXB7QFywmOyVnj0lGgcIguLJKwSW85A5OqAlLqGrDS+tiYsZzVl5vJvEMEelWFbJNO5o69o4QTjaJ13PwxlTzf1STL6DBMdF9VOqcPlmkD+4nPI9j4J9+SmPY+PXNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m/LYzlz7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-471191ac79dso24484845e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761914718; x=1762519518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUYZv3Cu0MKcgzaUFYaSO+i6DnVIY6p94zccSzaHA0Q=;
        b=m/LYzlz71hysIwNcKHoTUPxaOWjKAdrJtPowqlCGkGXdCO2NF+iXDdQR39MIzbcx+h
         rEsZTroy1+zMguUL6su+h6CgAXh/hAXRDbuPUxePA8H5zOZIMJ7pTOhAXMF3t2wpvq/Y
         X0SpDU+YqvVDRM6IS9WG9K6OlTr4trEPO8QVSNNyFc5LmhftoDAT7V145xPkhvD2EGvB
         Of/1Ckfdfr4RbdDZCRg+Ab2OVt63qKaY41kFMrzt6Rk26+LjTFngyeFYFuP60oPyLfXo
         Pnl2lPz4ZFSQqIs5+wQcIrPEX2ELe7XZG66IAWDE9/AkSEotLB35NYKYL1gsHv9YkUXU
         ZIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914718; x=1762519518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUYZv3Cu0MKcgzaUFYaSO+i6DnVIY6p94zccSzaHA0Q=;
        b=sVPLNUNJTlAk9SuRyjm1whUgiZnSNQT4+OyoywCHuRM2xzCc8uj8FIWy3AWeg8SDbv
         7iqvGtyvmZUT0H8Hoy2Q7KqKU5u+fVkAy6hklxR4cMW7mAHywf2l3Gyqb9ZLPcuJr0Lw
         8kytxcrX31YOMTb3H82Z+7u2n6A2LR9MOoDIpMJyKRlXL0CiypvNTfbXcBU1n0QJd4cK
         JnPrmPOvFsuzlSxvCoBIE6vpL81sx0bKr3wX6Gq4qN2cgJgEhNZRWsGYcejSO75p4+TV
         RsZ6KP1laKrLVa6QSeP/yddM/Ma1bIa5mnae2aVGpEbCyVvQcRrHYC0GnJD0wh3txzF3
         6xBg==
X-Forwarded-Encrypted: i=1; AJvYcCVOPw+BL2xiPqdqdpRnbHqBD2n5Y3CDrDXbImIaGA6T33nlctqqDUca5blufakGP6ddOZZLeRYAaLY7pF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHZM85ISH0EZleEdtBnevaogbOPR61vr9IhKK/tRmrmD/uoT3
	eI6/1xP/Y/ter9wpRrdam8jRhJbCnu8rt1TBH3G3MBKKgbfe3zVfAoUJ4A8LcXpVj4Y=
X-Gm-Gg: ASbGncsZAleCHPWFVQLjh5d4bfACAa10N9htL+w/XHMYbmg8PwngZ3grQBXHxt6no/M
	ChdlkRdbdA0ajgNlJ0wTgFStOjTw7DMLxXUPoGOQ+SZdqgHMAykE5DVJTPSQdG+4JYw0apnE+vO
	H0sdk2DHvhTl48kBMQ/aKx+GbwuxEJElpsjBQdTD3T/AKBMi5LKSvsFGV3aD2H6t6l8Ghfu2fF+
	a1WugDUTGLmR1q9s7D09pMRZAOSqUFftiwbjETGooDqea72qZzuY++5NQ9zRdvxlrfaB+EkEpoy
	6iM6i0pygVfomWMdQwaZcbSOJmLo1t7z+TDMcy1Rk5nIPMOWdeLNri6lyrAntmAOz5G66GekoP2
	K2//qx1Wbw2lGhhu2myKn7oIzwKUikUPwknnbw/U1718wS1ZKGWhVzWDqkqwwQ34pJ3nQRDyGRg
	WG6GNzNIqYXhd/6y21J0nUUjluUnl16UM7NBO8UcU73HEOk23Wyh7YpIpl/kl9Vlc=
X-Google-Smtp-Source: AGHT+IE1jX74SrJdWKq2vwBSCF6/p454jL2nStHGd6BUee4PeD5edlVBtzGDARF52ob7VXL18M0biQ==
X-Received: by 2002:a05:600c:1f0e:b0:471:1717:411 with SMTP id 5b1f17b1804b1-477308b6105mr31513855e9.24.1761914717490;
        Fri, 31 Oct 2025 05:45:17 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff7fdbsm31077535e9.16.2025.10.31.05.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:45:17 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:45:09 +0000
Subject: [PATCH 1/5] dt-bindings: nvmem: add google,gs101-otp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-otp-v1-1-2a54f6c4e7b6@linaro.org>
References: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
In-Reply-To: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: semen.protsenko@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761914716; l=2206;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=sdrHsJNK5w1wePKRU9wLpHaRPe0gYufMWkbjaBq2T7Y=;
 b=AzeBS3xPCS7ipIbmYRwBNmPpWeii/0REg4uHEKIlalF+Nqp39ED1ebruQ20wc/fQ2pKxt0v3Q
 vvYd2l2dU4uBxwKMIQ2L5J3vjcn7FMvU7YTvXTWg7YNSDkjXjZYV38P
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add binding for the OTP controller found on Google GS101.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/nvmem/google,gs101-otp.yaml           | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/google,gs101-otp.yaml b/Documentation/devicetree/bindings/nvmem/google,gs101-otp.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2144911297beb89337b0389b30fe6609db4156ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/google,gs101-otp.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/google,gs101-otp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google GS101 OTP Controller
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
+
+description: |
+  OTP controller drives a NVMEM memory where system or user specific data
+  can be stored. The OTP controller register space if of interest as well
+  because it contains dedicated registers where it stores the Product ID
+  and the Chip ID (apart other things like TMU or ASV info).
+
+allOf:
+  - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml
+
+properties:
+  compatible:
+    items:
+      - const: google,gs101-otp
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pclk
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - clock-names
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/google,gs101.h>
+
+    otp: efuse@10000000 {
+        compatible = "google,gs101-otp";
+        reg = <0x10000000 0xf084>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        clocks = <&cmu_misc CLK_GOUT_MISC_OTP_CON_TOP_PCLK>;
+        clock-names = "pclk";
+
+        product_id: product_id@0 {
+            reg = <0x0 0x4>;
+        };
+
+        chip_id: chip-id@4 {
+            reg = <0x4 0x10>;
+        };
+    };

-- 
2.51.1.930.gacf6e81ea2-goog


