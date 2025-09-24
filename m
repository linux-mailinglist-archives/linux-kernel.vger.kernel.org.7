Return-Path: <linux-kernel+bounces-830780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E09B9A80D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B1F3B46E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA72D30C622;
	Wed, 24 Sep 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZiaUoOg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7030BBBD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726674; cv=none; b=C4Y6gKXPs1EpSMIxklFz/K93wLD8w3n2t0kn7jZLwKGAfCNnL2le82CWQDn/U9H4LyeyfvTDgm42kq8gMZByt+Vez5qbadeKACNMDl7HIUC1bfloMGS8b4uSFKP0hdm06YV0UCNazLS6x8Jp3MU6A1wD1JGJBYpNnNq386gAGAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726674; c=relaxed/simple;
	bh=NkT+Yg9cYGQ08mwihOyEX0wXQkJh1dzuD63z7Z//UsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poMuO1D5qh44+1dWYS6JD9x7sgYn+fKBwMajXTzK5+vp5qSdbRj/iRQvFb9rswaayhh+NzBOWQAUXC917In2ODeiXHhFDxI4tnMEETMx5sA/I4y6j2jui+4KR+vm5o12gmzA2Aeo8/OOMCj6DNwFXwtpYU/roVTHDUVagv6/Gjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZiaUoOg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so47323315e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758726670; x=1759331470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09aADhRx97hgFBUXBrs2wpmXKNGHwu9T21ONWFuPPkc=;
        b=uZiaUoOgZ0PmSq5Wyx++wurn8P+av3N2E/ggXwBxvyIL3Fk09sZ1h7+5JWrqm+BF01
         UJTdyfK6cXWfAxuPCKJSN1wWtDV4aACVsDNqfm/E/qOJl8tUCs9pTDc7jC6OPSLvnGOm
         lZzzdomIvjriVig5MGtCh3Mmwwk0cdFhkTDC4r/Ug2mYrIUIk8Xwoi5v8jh1Zk+gkaAF
         3TaAxFj+o/FfnXDP+XJPfS9kHkPB63vdOuWlqpegzRr5yoB5MsHrRDXOmvXCoeglLrCQ
         piCJVqNkQtdNzG4oLNGGnyUprRvv36F/PyiZy+wXIDhVN//KVTNrEnTu9quyANR84oUg
         2Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726670; x=1759331470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09aADhRx97hgFBUXBrs2wpmXKNGHwu9T21ONWFuPPkc=;
        b=vrDiFR7LHVzDIMN1KgONyDXvSO0O3NR6DNFZH2TwO6TnO/ByBlVpnFLoK0hQbAROso
         VB42euSGThS31PKtRbbZAp5fwQIuncQOQ4wZXFpTZvyUd7vvz4c2STLTW56TZpO95oJW
         dcraUnFzRhmZ0oLidyoPkl1xisQtpnxI+FtzIxHgCCV3bTsx8tee4tt1HhX9s29lcR+b
         HkxAA4o7WKSvyuS2MtvVLSnVfs2PucVcssD7iI0Y7bqZdTxqNvkTBwWjYyW+AzeojWqW
         /QLoKwXWSybP9VgT8HPqLKCcKr3yMPJt9gVQck2Fw25aRmzdubsT12qklXoVEA+57lNA
         wEhQ==
X-Gm-Message-State: AOJu0YxMRBIeEYOfrBd3KQjYLvIBcpgNTiMAIUecpxTvFFCynSljPzGW
	NBjipVG9euLTC7Rk+1KlJb3lJMIPCS+T6NnDHOGmIEyPCuirLs4ZvJbsM9LKo3+qkSA=
X-Gm-Gg: ASbGncuwVBaJZuEWTEmJHRIhu68BNeKLSZbunmWOn+F3BPxilR93dHPNbG+drWJ3IA7
	z9mjrQ+7D4/nYziWNCcjGnWwC5S9in0YOiQ1JtQkT6u3soVnbXTuSbOsFArwnftizCEGK7VxDxk
	wUfPPt8xO8uArIp4EhKj+sQMYCHW73Zi1IyNplJb1aznPChAgZwFZxxAvi+SvTcZthXUX55Bnfa
	aQPQo7sBLQLUwaYW/tvxUxk7XmfgUxCJuoRYiUPJTcqBUnwz6Ww7WWemDNaqOJlgMWoV7wTS334
	d12MLTBbK1ccK40Ii5915USXRM0IMei+LCUu8Q/vCKobMd72kekmjF+2ZhhwaXfUGd5LHFFHT71
	Woq9uEC4H0OxMdP+u7sJbW1qfpnAkELmH6yCKitGih2doFOl15PphkQ+/Z47zBqU0K9m7a4rUQU
	g=
X-Google-Smtp-Source: AGHT+IEs8QQ7m3gKJ792ZHmSzLEcZBZ4i1CTXbR5D1PZeV8nN8Q4fLpYid2Xg1E6ZQRkaWTb8EXBNg==
X-Received: by 2002:a05:600c:4686:b0:45f:29e4:92ff with SMTP id 5b1f17b1804b1-46e329e4e87mr2559865e9.17.1758726670313;
        Wed, 24 Sep 2025 08:11:10 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a7c8531sm36045145e9.0.2025.09.24.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:11:09 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 24 Sep 2025 15:11:00 +0000
Subject: [PATCH v5 1/5] dt-bindings: firmware: google,gs101-acpm-ipc: add
 ACPM clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-acpm-clk-v5-1-4cca1fadd00d@linaro.org>
References: <20250924-acpm-clk-v5-0-4cca1fadd00d@linaro.org>
In-Reply-To: <20250924-acpm-clk-v5-0-4cca1fadd00d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758726668; l=3182;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=NkT+Yg9cYGQ08mwihOyEX0wXQkJh1dzuD63z7Z//UsU=;
 b=XV1rlGn+zByellycKzW8IPoG9nI0fOQeoVrNmoZlVgT6Gi5o6TgZ4a67vO6MX5vbPdR65Dv3R
 aPujGM0WjaOA27mL0pW6hLtNDiuiCIpedYIQ6aCyTj6JTkwfMz+UUXQ
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The firmware exposes clocks that can be controlled via the
Alive Clock and Power Manager (ACPM) interface.

Make the ACPM node a clock provider by adding the mandatory
"#clock-cells" property, which allows devices to reference its
clock outputs.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org> # on gs101-oriole
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
2.51.0.536.g15c5d4f767-goog


