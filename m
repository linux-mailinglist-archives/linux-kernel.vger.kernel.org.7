Return-Path: <linux-kernel+bounces-865090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43EBFC342
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A68D544630
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE01348864;
	Wed, 22 Oct 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBhLgU/o"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0634886B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140072; cv=none; b=lWLhr5zi4CRnRdK8NZ0h9rp5/K0pYMToy/duk9oC7yYmbvtJnVfr3ikB27+hn/2m9RcqC3o7nrjtLqPsEA8QJQ2TBPrcaVHyzb3/L9QDrbYCxroPRBVArXxqFXAASr6xGGw/r3uI9/jbrqWZ/vYeTz2Y6XEAh2//bEOM0z0ifvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140072; c=relaxed/simple;
	bh=t58k7nuf9fXppT7leLM5wPeiFjCn4yr98+SyB7CjCIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcRSrGn4Prdb8gPB1k18xN+byQiF722PObtLwo5047xORXVFDXuVVcGhns+0XWm64x6v+9dy+WlSZoUDrtM9rFXrk86ejOo056xxT+hJDFwpd00BELGtzx/Jb/ivCL7KOLhQfCgWvrRfMPY1XqrAKKM8gefD/LnjZ4U1QjjXxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBhLgU/o; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4285645fdfbso99129f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761140068; x=1761744868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFXbojovxWliJMkNJdsF09HvmueXHOHMsMOPKrCfmZA=;
        b=gBhLgU/ojivpduN2gcdB3lUg9+9Jw7ht01gSzRJMbpFRrvZ+TsIcl3tzsrQ06XaBYG
         b/LGE6I5n81903wXqo+Oj8YUcX9v2nTq2N3tkW6GZQpPck8w/Pum/0u/RAJu4722PNgX
         OOsuBrDMVTccEUBqEflyQojt028JOadAoosJXDH/K6f8MsDlY8PWnKXQXFfQPmBNAMEL
         aVvi//PoQF0unp1IUDv2llfwZ/pM3QWUMpzFeeS50lXHlD5BtgE+jCq96b1pGGBPcasy
         OZQkOTuqoW7zZiyVw3/KiA/3NKHozYEDWHNd8RRJKErg7Ik0/uuPM66ay3u9bxalaaxV
         5fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140068; x=1761744868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFXbojovxWliJMkNJdsF09HvmueXHOHMsMOPKrCfmZA=;
        b=C2VvswuooWAYc8eJfUe5ig8Z7e1qbOEmrlG8QVpDpg6b4kG5DidRTCDVnJCoYMM3Fh
         ShD2six8SWU3gLMb+u5nc4gEIMnhcreIra8+20TU6JxzrK4OOtoKz5oBBSYjXbwJ2sYx
         DN7qDe7U3cvs9kRs3hoydoXrJTrp4/GTmK5Y/ftAnFkU6nt/sN0OPtggcAfKQEtzB74c
         gvocOgPek/cbAnXEuzQjDxm4W4VT5eMS3KaLQtFAHfgDR5a496T4JXIMkgz1OTBtpipq
         UUwsECTZjDTh5+PqSnJ8f0bND8himBhptoV7tOwduEQCCb/zjgjcMCZjp9e7MHodcJSk
         fghA==
X-Forwarded-Encrypted: i=1; AJvYcCW5tifbd+e6SUhEyg7cRbqXqVHFEhCy/smTU5Z+XQ0i8UsZi3YFyJuocnvdJRoHUhErbEK9caBa/SLuIXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMGYIA7lGomv/Ke1nC7s2jcpn7LXSfgtPWJaBUm3h2xXt/yxt0
	hD53lTNz+U6ov2jOOE5MrbgESp4IHGPGfpO2pKAhrQAl1QcO1MABJKgnIIhc2ezA77g=
X-Gm-Gg: ASbGncs2V3xqxHXrSzu2DxAnkqFBoYGHRNPozD2yL1HVK51vcPGFAM6XFgGnBDeeuZB
	HLCrXC9a7CG8HzyvTiM7aBqPFMnbYv+d7vjP6c9sx05IBnrVAYPe91XucEkVSxAhGvlCCyp0el3
	eZ0U6SE96Da+Qu6BYFQteoTskjHoqT04E8WsVpY985lC5LkUZnD1fl0mEr5AWXTPWZt9HIGVIRc
	r+lIg6OX5MBdDWRxsUJT3T7Hf3QNvpMHtXMWF6HNJS01l5E207a6QYcX5wBLDMP7uPTUcdI1yy0
	zdJ35z4B6786zhpDcyri3hChtgDmAYY/sTD0DWLC3VbnIvg7pTRRJAcMQ9U/rMal8khmzkJVbiM
	ElilT6qMWqleqeQhC6u0lrHdz3SBtoDEkRLzIPAqQFys+qfGMKLesPt/XimM8v67S/22lOOVLTt
	Xgx2N6vLYAPAyCw5Yh4slL9A==
X-Google-Smtp-Source: AGHT+IEWcnZIaP2wLBKfRqry0HILeS5KfSEJcKKwt34JV4PPLBebPsmgOhwbhA8EkzXLqs8P73MPpA==
X-Received: by 2002:a5d:55d1:0:b0:426:fff3:5d0c with SMTP id ffacd0b85a97d-4284e531afamr2257012f8f.1.1761140068108;
        Wed, 22 Oct 2025 06:34:28 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42855c2fb92sm2981201f8f.46.2025.10.22.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:34:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: toshiba,visconti: Fix number of items in groups
Date: Wed, 22 Oct 2025 15:34:26 +0200
Message-ID: <20251022133425.61988-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "groups" property can hold multiple entries (e.g.
toshiba/tmpv7708-rm-mbrc.dts file), so allow that by dropping incorrect
type (pinmux-node.yaml schema already defines that as string-array) and
adding constraints for items.  This fixes dtbs_check warnings like:

  toshiba/tmpv7708-rm-mbrc.dtb: pinctrl@24190000 (toshiba,tmpv7708-pinctrl):
    pwm-pins:groups: ['pwm0_gpio16_grp', 'pwm1_gpio17_grp', 'pwm2_gpio18_grp', 'pwm3_gpio19_grp'] is too long

Fixes: 1825c1fe0057 ("pinctrl: Add DT bindings for Toshiba Visconti TMPV7700 SoC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../pinctrl/toshiba,visconti-pinctrl.yaml     | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
index 19d47fd414bc..ce04d2eadec9 100644
--- a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
@@ -50,18 +50,20 @@ patternProperties:
       groups:
         description:
           Name of the pin group to use for the functions.
-        $ref: /schemas/types.yaml#/definitions/string
-        enum: [i2c0_grp, i2c1_grp, i2c2_grp, i2c3_grp, i2c4_grp,
-               i2c5_grp, i2c6_grp, i2c7_grp, i2c8_grp,
-               spi0_grp, spi0_cs0_grp, spi0_cs1_grp, spi0_cs2_grp,
-               spi1_grp, spi2_grp, spi3_grp, spi4_grp, spi5_grp, spi6_grp,
-               uart0_grp, uart1_grp, uart2_grp, uart3_grp,
-               pwm0_gpio4_grp, pwm0_gpio8_grp, pwm0_gpio12_grp,
-               pwm0_gpio16_grp, pwm1_gpio5_grp, pwm1_gpio9_grp,
-               pwm1_gpio13_grp, pwm1_gpio17_grp, pwm2_gpio6_grp,
-               pwm2_gpio10_grp, pwm2_gpio14_grp, pwm2_gpio18_grp,
-               pwm3_gpio7_grp, pwm3_gpio11_grp, pwm3_gpio15_grp,
-               pwm3_gpio19_grp, pcmif_out_grp, pcmif_in_grp]
+        items:
+          enum: [i2c0_grp, i2c1_grp, i2c2_grp, i2c3_grp, i2c4_grp,
+                 i2c5_grp, i2c6_grp, i2c7_grp, i2c8_grp,
+                 spi0_grp, spi0_cs0_grp, spi0_cs1_grp, spi0_cs2_grp,
+                 spi1_grp, spi2_grp, spi3_grp, spi4_grp, spi5_grp, spi6_grp,
+                 uart0_grp, uart1_grp, uart2_grp, uart3_grp,
+                 pwm0_gpio4_grp, pwm0_gpio8_grp, pwm0_gpio12_grp,
+                 pwm0_gpio16_grp, pwm1_gpio5_grp, pwm1_gpio9_grp,
+                 pwm1_gpio13_grp, pwm1_gpio17_grp, pwm2_gpio6_grp,
+                 pwm2_gpio10_grp, pwm2_gpio14_grp, pwm2_gpio18_grp,
+                 pwm3_gpio7_grp, pwm3_gpio11_grp, pwm3_gpio15_grp,
+                 pwm3_gpio19_grp, pcmif_out_grp, pcmif_in_grp]
+        minItems: 1
+        maxItems: 8
 
       drive-strength:
         enum: [2, 4, 6, 8, 16, 24, 32]
-- 
2.48.1


