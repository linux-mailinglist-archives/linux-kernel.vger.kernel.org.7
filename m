Return-Path: <linux-kernel+bounces-805902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC3B48EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3917B1EE1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9862F30B523;
	Mon,  8 Sep 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vm0Xrrt0"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA46A30ACEF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337183; cv=none; b=I1ENzHjY/1UlfhVlNGpBjV5xZ34IDl0+4USUNYRCi5RmghCmAt8Mm9UYPa8pkc4+LBKBue9nyiG8R0cBgjSLsikpK5Q0PVRFf1cTVPJlDQ9Z07mIr/r0QG5RkzpV09ZqXNLaPoHMcemhNasfiVaa5BG5p2UQvzf/HJ7bYP/DcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337183; c=relaxed/simple;
	bh=d16ATURJXaVteyF3Qps5PT9fGye6OfeD6faAj7tSV9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dqK7M4RNCv6e4Fj7Qb9nWprEqVeuabUTkd+AIVN62Gyf84hU1wsVPqAmmL2jNcYT7Bsopgzmkcfd+PNv7m3r87sDGqM2yC+WYCkCBBxsSFrFcgXY43aCM1Ka7pl9ha6fx6ZIHkDqcAhYbC5m2fLha2w5jej8tW4HA9uFkEgsuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vm0Xrrt0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45de287cc11so6435965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757337180; x=1757941980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dqFZom65YcEQkXmUqTDd4+m17RatDWu3bIoNbEjE50=;
        b=Vm0Xrrt0lJarz765OySh/xBjJzRY2eLuKX7ei+L2VPuXjabjjP27pfRZ/UL/eZ92/k
         GMco9CXCLjalhXpBzBgPZjQHo5KwicvsxL0lbsmQ3sS0+fK6UFuQBNnoooFLWGGpM6SN
         TMVzzfqaE1tAjzC+8RG9iNcpyt++inF5fl7bJ1VPIRWb1VoZyH7xrKkKjfI98hnw9IYQ
         QdM9JAz3XZtl8bDBiBBbwoWpj/fUpipbZ4e3Hz53AfDnuKQF5zT7/ejNAgZLYGUXIUk4
         OPZ6vAL0Da6pNT1f8UnP6ha3i7LSucYR2Bms713h4RYkGQlMufbQdhHdElh6oXF+0RvV
         F2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337180; x=1757941980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dqFZom65YcEQkXmUqTDd4+m17RatDWu3bIoNbEjE50=;
        b=O2KcDlI4/yPfuCocN+yMwN+trX136U9yUwD5wNQsSLvjMcl0vVFUAfKUu1WPpgELND
         seHV5j5jSfsonNIcsVi3Zo2NpCTYnLN2hceCabg1vlLWzW38oWz1o/GeEK0P8IHZxj8w
         o+4CUS0p6FUSCzpZ0yIzISyU1urBkL9J8KPRL1sGXBwLZ7VdvAaA/AEpKak6/icC6dFF
         +hbUT4flrWA9jIToRScfmXTtUvJnCgdkawgJKepb4EBUgacslCidE2AddoMoTJvorEG8
         CinrXi0X66Jg0LDi1NM/yOH3yPSX0MMFlYID+OOLDMfNl/InWuLYDxefVaKuj/BPGq7M
         yiqg==
X-Gm-Message-State: AOJu0YzPPfChFSbKuSVWyclul24nZq3Nyz581TMAhKKE0OQ+Fh4aK6g4
	7nTL75M9AXhXgu9mwdfFLOi03++GBZvwZiML2jCCQZVqnNfv9zb2Druh7/HsfilcH9o=
X-Gm-Gg: ASbGncsBHQ4Bc7R6qa1XRHwIrIRekcbjuAhWJ8hMcw5zf2wYM/RtigZsBCT+y2jLCFI
	Mm2cM+XTttSLyjB/JAQ+q9cHnflV9K6QRBGVIQEaeFmySPbiiyNSAqvsslsnjcZjurqQcPU7P5D
	VlH+c6RPMTL3cvBlUXVLx6FWB9oUmC/R9qkViywdc8sY2ecs3vDJELDNjerBHPwOKhw+/esO4Mw
	obkVA0dEzUooBPqfAPw/+nPrVZtE/2F3MnI21HKUop183U2z0LOjsahRsYs3rHYzWYhyhM5yf6x
	ktxXFsFcF/B1mCuU+erTwCfGg/Nl6zfoR3i06xMG7Htv4nzglhpplep1tOf6Wfe0a31HWFL6U1p
	TOdg0V/Eio9U6jjo14Esl6iU9ziAbdsaUXji7EG6S/rvOcd50ejseUeGo5Z1rbKGjGLlTO0eVpF
	/Z3A==
X-Google-Smtp-Source: AGHT+IE7mUMhuSHckm+BOVWYPNlPL88vc/oJXt6OY3cNSKgPrAVUivteuSdEdtgHuOKT9kbXSWZ9Uw==
X-Received: by 2002:a05:6000:400c:b0:3dc:2f0e:5e2e with SMTP id ffacd0b85a97d-3e628cd5aecmr6211828f8f.13.1757337179849;
        Mon, 08 Sep 2025 06:12:59 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9dbfsm41650181f8f.43.2025.09.08.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:12:59 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 08 Sep 2025 13:12:42 +0000
Subject: [PATCH v4 1/5] dt-bindings: firmware: google,gs101-acpm-ipc: add
 ACPM clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-acpm-clk-v4-1-633350c0c0b1@linaro.org>
References: <20250908-acpm-clk-v4-0-633350c0c0b1@linaro.org>
In-Reply-To: <20250908-acpm-clk-v4-0-633350c0c0b1@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757337178; l=3056;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=d16ATURJXaVteyF3Qps5PT9fGye6OfeD6faAj7tSV9U=;
 b=suYt9exuHS5pnrnU/6Dl3RDrK+E1WIxhvGPdwwQ3FPHy9Br2xJnfDunovLjDzC9kuHFmAcIiL
 C/CqsWwn9aPBC/3KL2PvOOXAQkSEBn7TCUXkTH/9eEvTIYcZoUOWhDe
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The firmware exposes clocks that can be controlled via the
Alive Clock and Power Manager (ACPM) interface.

Make the ACPM node a clock provider by adding the mandatory
"#clock-cells" property, which allows devices to reference its
clock outputs.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/firmware/google,gs101-acpm-ipc.yaml   | 11 +++++++++
 include/dt-bindings/clock/google,gs101-acpm.h      | 26 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
index 9785aac3b5f34955bbfe2718eec48581d050954f..d3bca6088d128485618bb2b538ed8596b4ba14f0 100644
--- a/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
+++ b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
@@ -24,6 +24,15 @@ properties:
   compatible:
     const: google,gs101-acpm-ipc
 
+  "#clock-cells":
+    const: 1
+    description:
+      Clocks that are variable and index based. These clocks don't provide
+      an entire range of values between the limits but only discrete points
+      within the range. The firmware also manages the voltage scaling
+      appropriately with the clock scaling. The argument is the ID of the
+      clock contained by the firmware messages.
+
   mboxes:
     maxItems: 1
 
@@ -45,6 +54,7 @@ properties:
 
 required:
   - compatible
+  - "#clock-cells"
   - mboxes
   - shmem
 
@@ -56,6 +66,7 @@ examples:
 
     power-management {
         compatible = "google,gs101-acpm-ipc";
+        #clock-cells = <1>;
         mboxes = <&ap2apm_mailbox>;
         shmem = <&apm_sram>;
 
diff --git a/include/dt-bindings/clock/google,gs101-acpm.h b/include/dt-bindings/clock/google,gs101-acpm.h
new file mode 100644
index 0000000000000000000000000000000000000000..e2ba89e09fa6209f7c81f554dd511b2619009e5b
--- /dev/null
+++ b/include/dt-bindings/clock/google,gs101-acpm.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright 2025 Linaro Ltd.
+ *
+ * Device Tree binding constants for Google gs101 ACPM clock controller.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_GOOGLE_GS101_ACPM_H
+#define _DT_BINDINGS_CLOCK_GOOGLE_GS101_ACPM_H
+
+#define GS101_CLK_ACPM_DVFS_MIF				0
+#define GS101_CLK_ACPM_DVFS_INT				1
+#define GS101_CLK_ACPM_DVFS_CPUCL0			2
+#define GS101_CLK_ACPM_DVFS_CPUCL1			3
+#define GS101_CLK_ACPM_DVFS_CPUCL2			4
+#define GS101_CLK_ACPM_DVFS_G3D				5
+#define GS101_CLK_ACPM_DVFS_G3DL2			6
+#define GS101_CLK_ACPM_DVFS_TPU				7
+#define GS101_CLK_ACPM_DVFS_INTCAM			8
+#define GS101_CLK_ACPM_DVFS_TNR				9
+#define GS101_CLK_ACPM_DVFS_CAM				10
+#define GS101_CLK_ACPM_DVFS_MFC				11
+#define GS101_CLK_ACPM_DVFS_DISP			12
+#define GS101_CLK_ACPM_DVFS_BO				13
+
+#endif /* _DT_BINDINGS_CLOCK_GOOGLE_GS101_ACPM_H */

-- 
2.51.0.355.g5224444f11-goog


