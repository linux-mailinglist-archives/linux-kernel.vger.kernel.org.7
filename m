Return-Path: <linux-kernel+bounces-858468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7604BEAE73
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 180C95A5902
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F242C327D;
	Fri, 17 Oct 2025 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIdrEGkz"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A12C11D0
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719372; cv=none; b=cH9FDxu5B/NEOBujtkHPYP8MMLF5fpTndPoXi3W6WPzWBeVCNNNl4ZPLd36olQ3I3FQsULI5IoyNkYUzeiqRP+tgRolInltdTZ4ZBGBrelgeWCVIo8xBVLatz2+tO3pxUtQ8zRUwgzWdNxM3U4TOiBoLPYWRfHQJ+0WPleXs7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719372; c=relaxed/simple;
	bh=OhAPqaXLXCmsNIfo7/tILARHNy+GrLJldAAVbkxmaW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9a4u5yqgJL1FmCfRiJpqeyfa70CSND6/w8eLnCbFlSBlxqVtfp3CDJ77EnQJLJkx2sInXLzdykyWhCC3rXHe+PK35j1lalYguzkUHkyzjRZN5/AYuEq3hgXRdBeg8s+ne9ibVZ6WmuXXDhPSQwlp2uobdlpNyjLPa1SxNJ/Tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bIdrEGkz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42706c3b7cfso396507f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760719369; x=1761324169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=bIdrEGkzJ9zLWurrd84XDZ/h4zlLfEtPO39/QayrOAaQaLE7MN2tE6FWIAAa0ULX+n
         PttfE+zkF+I9FEDFgIlYx63QwoKaKFHF5G864DANPuEvtDSkoj4GlSrEE+wNBfuwzeBu
         pGE/XszQCtVO4thFI8uqOH0u5ghzsKNiZJaBK9ntzfKglApjgE+se5YSYiaN32prbO3a
         Z24yv7sC17cLRuokIelltdG0OCl5WGPTMoW8O0agu7DBqx7AOoNFwBTZ+g28gfseOhU9
         783iZadVe19aUL4OQ3nVfAZdP75/MNNRWXY8tIXebezU28ZhYoBZktOC9L5e05kv2liX
         0OCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719369; x=1761324169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=KoUZ5yt/Gs6begaEJSlARso3EGXvo4Kq/zw7KK86cOIP0mClifvrJ2BgkJdQCAfRfr
         w31MVa690Fms+JBDfhUOhewpJS0X5glOufytUu8Vg6So8yf8KAnoWOusXxrinf3PPC9S
         tEllleFdajA5xS2juI3Reo4Bpj0zaHm3GmqS1ZyvIl1UComvIiCla3m5Ibr9Ww1hfqBR
         eBUPJSqlMi1MFk1JBDMJiR1CXJejoo3IM4tB2k/M47ZC2TiPx1T4tLHwqKDTsAADadna
         o4Br/ukrqCXzEG+t1W9SL+XgOOtN+1Bickt89MiZW8D+GSx8TIDm4wNNMfivWaVRR8t5
         TFeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU16dJUVkqFLW7SDAwZeteCM+xxmMD18wtz8Pn/AxGSBO6yYe93AXk7NMDwOgrGU5CdDlERuRl2ogmTBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNcG774ysHpf3xFwqAl4tQblFun6yFcgdW0bGsFFxx1NxpZyk8
	T2APzEAhKIjmS24VBLFetnY891XtUrcLTTNJmAIMaZ4Gm2q/DZnHkVhKuFPbL2MsThs=
X-Gm-Gg: ASbGnctphPcHRQh/j1bZ5kehIdM43Y3vfuHHecoTGMK0Ohkqpi5gMDNjiVowmJCm5Ag
	njiVOeDP/o/gkLEQ7g4abqqQB1M7cQphlImenu52FGb3RtSQhpc3iil4qvq7bkMDpfx13gpVCsE
	kfCwHN/O6rpgXCktw0SANyrKz/qS3JGPzpx7t1ic//UQ2DVCnS6CZQ9eEtUdmzZ45Rl5JorV/3F
	x6Ru9bh3Vi3pYSyba7lvr4fKjxctzNNRO08sMAg2RakrZfeDdvx+VYhZRcq09IdOoRM5D4WtNQv
	6S8j1puumrBEliPmBrCZvRqwql8COjPXphp2h1KE9TurXdbEONAK3lggYpotrIZ68iiT7BXsL9E
	LZyVRHrfldK5CXR0RFx1fOhdvGWra5j1/dxYZZLkpQrQRNcBr/VlvCrxOMOC/gBu18E28J78Jiz
	0SyycyMSblfGiSy7rpWBz0B1EznETDyTo=
X-Google-Smtp-Source: AGHT+IE+QF8NRHxVF3WbV0r6vQC/Zqzlbkc5AhwK4SZWbzOeytdjjtaSiGHMWgQlotCjTVuwThRDPw==
X-Received: by 2002:a05:6000:26d1:b0:425:7f10:d477 with SMTP id ffacd0b85a97d-42704d51136mr2976147f8f.2.1760719368973;
        Fri, 17 Oct 2025 09:42:48 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:f253:278f:af81:a956])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm3392125e9.1.2025.10.17.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:42:48 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
Date: Fri, 17 Oct 2025 18:42:37 +0200
Message-ID: <20251017164238.1908585-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
References: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The s32g2 and s32g3 NXP platforms have two instances of a Successive
Approximation Register ADC. It supports the raw, trigger and scan
modes which involves the DMA. Add their descriptions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
new file mode 100644
index 000000000000..ec258f224df8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nxp,s32g2-sar-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Successive Approximation ADC
+
+description:
+  The NXP SAR ADC provides fast and accurate analog-to-digital
+  conversion using the Successive Approximation Register (SAR) method.
+  It has 12-bit resolution with 8 input channels. Conversions can be
+  launched in software or using hardware triggers. It supports
+  continuous and one-shot modes with separate registers.
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nxp,s32g2-sar-adc
+      - items:
+          - const: nxp,s32g3-sar-adc
+          - const: nxp,s32g2-sar-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    adc@401f8000 {
+        compatible = "nxp,s32g2-sar-adc";
+        reg = <0x401f8000 0x1000>;
+        interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks 0x41>;
+        dmas = <&edma0 0 32>;
+        dma-names = "rx";
+    };
-- 
2.43.0


