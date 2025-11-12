Return-Path: <linux-kernel+bounces-896744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E767FC511D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB1B24EEF09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A072F5A22;
	Wed, 12 Nov 2025 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCnqASjD"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5C2F2606
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936158; cv=none; b=S8uZb0vpm3FW3p6ycjf1baLGR2n4pafw9f1z9ZMHeGFtrUtckot3Wn9sutuT3ouVrFRlUvBX1KMoZi076k3nBHJYk3RSKcgH/iu7w0mNpYg2VWYdRvMrlq5Qx0bTxIURjUYS28VBt9oIVA19t/8dVywXiB0XJzswh0mB+nNS0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936158; c=relaxed/simple;
	bh=dEcSRRQtvE4xP0095DiinVR5fFEjss1bE4Kb607L5bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pLoZtA0dgmeRMF56jWC2k72Z+FjU8hyMOABM3O+O03no3WfekxKdpPt4DeIe9Rny/G70N/hAkSIi+AykR4YLYeU4yO2wc4VDzUZYXkvHhqoRZ4iGfqLPJspT2oIhAX9FgxaLRVrTvs3moZHDcO+ShPwbQ6pz4D6tgi/TxaGq9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UCnqASjD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b312a086eso346614f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762936155; x=1763540955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtogQFcSHlN8gkfKXvyp9GsEsbrpcQ/U+ViAyh1NORc=;
        b=UCnqASjDhudrSXX61bOwzWzYt8j9RKmc5pwdUoPXDcC2WVoy9wtdNoxI1i6SlV0opu
         t77fcK4yGqR3deYRj/zzTm65oka/BTLPB7JiioJwsDHwIiKV1L0cRpfDIpfST2ybRKEJ
         furXOP8QvjG5VofJomX+4EnWp+3pnxQBuvg4yTRDF0UE4GrymChZ6DlRg8YzLH+4Wn1i
         fFYNES2v9ULyV/jqbknXzDiaoRHQIjeOoqyYPy9yQERm1DOYpW6riYfZZ4NDFD0kveE/
         P+P6xxWP9T0Jm7saVljrwTe8b+Do6MPj8aCoA3RPCD1nO9gCqn92CU8pfpEyyZ2iA5fT
         zccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762936155; x=1763540955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JtogQFcSHlN8gkfKXvyp9GsEsbrpcQ/U+ViAyh1NORc=;
        b=Gd6LmGCK3SnJ3KgtqtHdVEZ9EOLR+dffVzeqvkrih4fXbCqg8t/cnCFpULM5uN7sRp
         Ads4KC8Ur0kct0xbw1sw1XzTQ79rpEss1OWusYAuozQrFl3rlwh7juYTA3MbBMXReTAQ
         iZZ5RC317nAUs3lVG60GlLtyBAlnfrqkxkVk71nvFRewpnBcINzuSuMR5HJg9azuNE5l
         yrCxbn25a9MqtexNzNaBx6t/4NxQyOA4XPRwpES8FjpZTdP07QzN3XMzAMZwfPPKxFBO
         O90JyhiIa97fI10KXCRVAC/LgnSvNb1mnbP1EoF2pvxW3+md117CeT5S6mp3oTgEaBN7
         nfkg==
X-Forwarded-Encrypted: i=1; AJvYcCVGR6pkpc/JgXxt0chFYF2HVyN/hRYl0AUfTie0FTh9MO0FBBhK2aMtTzqbh0iC6GN5TKZsD+HxVy8GGSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzybQcepPQtyt08W56gQMdiVDl5qdxcQ1EhWJaqDubJxe+BUTdy
	sSZyYyJ8dBhu9PwhuowGbK31urry9k+ztINCWqXr5SJgjPE7XgA8lnHOON7ukRGNpDc=
X-Gm-Gg: ASbGncs1FPeaK3keU1xyvXOu/Wf/520t/8OVKBqxjisIvy8gCl3V6VXSuazL9T3asGP
	W3UFGIWL7uWkM4X4hZvidgpzUiFBD0ZlBAUmnQrJ4Ixa6cmrdm25rkfcIeVlMreTJf1O2kDCJKq
	VOvBstTHetViaJF9JyIPI4q2XKp0vOYq9Tsqx7uJIOXYUf7l81BC+8dlB/Epdn0T6KIkWt3Y5Jf
	ARBCGQf9YAfjh2bKTFfZy0NsAEyJ5UfAqlEVqbNTToBPAJTM1ahuCKOXZ98EjbstwrBWbBh9KG9
	dFt53pQ7oBAQsM3jCVajku97Jeg18abo2NKwJj2ZfA6jmnd24iR79fRnLzbpdAyR5p54KBONBsq
	0exNRHNeKxWtJ2iqQimsFIiMSauN+gRWElcfRWgGU4jdDJJtbXCOYInTR8e0nGbdbY04D9cywYY
	tFdYeG2SPl4hWdVeeYJzwMMUQtdwWmMvsVkqFObchQLupDGlr61u9MWnJQ
X-Google-Smtp-Source: AGHT+IEU4FFylzRDbDiqTl5SDdc681V6U/fIzfBAB7L0TgSU5N2M6VMTglal8026StadrPU/haIBUA==
X-Received: by 2002:a05:6000:2888:b0:429:cc1c:c2e with SMTP id ffacd0b85a97d-42b4bb90b6bmr1430374f8f.1.1762936154894;
        Wed, 12 Nov 2025 00:29:14 -0800 (PST)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm31571428f8f.35.2025.11.12.00.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:29:14 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 12 Nov 2025 08:29:05 +0000
Subject: [PATCH v2 1/5] dt-bindings: nvmem: add google,gs101-otp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-gs101-otp-v2-1-bff2eb020c95@linaro.org>
References: <20251112-gs101-otp-v2-0-bff2eb020c95@linaro.org>
In-Reply-To: <20251112-gs101-otp-v2-0-bff2eb020c95@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762936153; l=1979;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=dEcSRRQtvE4xP0095DiinVR5fFEjss1bE4Kb607L5bU=;
 b=OOX0r/TY8rkVTDOz28jm+bgdNooRzs/EvPWQacDtL9RIRn5yJEOAYEXSxltqVpFD4s7fZonIU
 jteQzbYy5l0BJ5yhYs/b58SW4kymeDF8K5hTUQLkv3HwXTDar9OlFds
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add binding for the OTP controller found on Google GS101.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/nvmem/google,gs101-otp.yaml           | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/google,gs101-otp.yaml b/Documentation/devicetree/bindings/nvmem/google,gs101-otp.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ea87216761dbab9a7a5cecd87a553a6a2a1783f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/google,gs101-otp.yaml
@@ -0,0 +1,56 @@
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
+
+properties:
+  compatible:
+    items:
+      - const: google,gs101-otp
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/google,gs101.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    efuse@10000000 {
+        compatible = "google,gs101-otp";
+        reg = <0x10000000 0xf084>;
+        clocks = <&cmu_misc CLK_GOUT_MISC_OTP_CON_TOP_PCLK>;
+        interrupts = <GIC_SPI 752 IRQ_TYPE_LEVEL_HIGH>;
+    };

-- 
2.51.2.1041.gc1ab5b90ca-goog


