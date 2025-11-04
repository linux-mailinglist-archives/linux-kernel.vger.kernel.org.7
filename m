Return-Path: <linux-kernel+bounces-885029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3CC31C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27BB24FE01F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24CA3314B7;
	Tue,  4 Nov 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksycI02C"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A7330313
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268828; cv=none; b=lmiKuqB9zRiimF4KqF1uApkXy3s+j/WwvSS+LZSkKXetnXrPfgHL0gytYdLl5qBTq+Wx7byekS1WadTSxFD+kTUBKn3MGykWnM2qU6Z05LCBTmj+T3PKp+xAg7RGJjRpOJcv4sQASGVnrG114f+fMyJNyfGYzUDDCUamN9qRxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268828; c=relaxed/simple;
	bh=/gzHGuZ/b71YHeLNSCqF7HwGsuPs7oNiMaA7VmETx8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivBtS9wBRbH50axbYMVssAivup1ZEU1K4/r99lfFmcyQkqyigAlBLoIgvppvmYhPzMKITg4PhXtGgGbx1M1/fZCUhPHX0N4Khi3+TIarzIa5tiVLO1Wf7WE8cAYXoGv63hfaIPupPbKXYAgihlTxtiw55HWBoF/uLW/4GP8ux2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksycI02C; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso5596900a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268825; x=1762873625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9kL7sLOaubIomrxMG9EMGJEPQDeUh/zlxyCoHi0rRk=;
        b=ksycI02C7PeUQGw8PenXpGZk68bbADO3Uz04QMy1is0yoNTf7tOmfOI6V7lTrQvTWW
         5OW/p2wbhgCO+HX3ZMojVpBxbXwbnZCoXnx78pzRrlyOmqZAlAitOS0WTfmJNR3ugMXp
         aJxT/dcvz01xpmu7YPOWmf+kTdC48J6KooupyyowBPzby/a6iCh/R5/Ze7GiBqHYzud0
         6SAa08xYkWv5m0KziG4A+Fhlc0raZqK9cy0ARA0ntKrRgy9uM0Sx402+YxdJVNqKWwUF
         Et27ZyfAyxyaQkPxk3H21ZEb5y5+yg4Ccu8SQyGZpCHX1H502eVHFKcr+TjS7+Bnf+2l
         m0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268825; x=1762873625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9kL7sLOaubIomrxMG9EMGJEPQDeUh/zlxyCoHi0rRk=;
        b=cIMZ44r7Lq0nBDQQj84YrzKfnZb/hac/fJKrMizaCc1NVCBhiTI1YFh3KYwZosbdgw
         L+VLYjBWoLHGnjQs6HUQvQMmdxj7xDzb0b4o6HEYZNlWjeHvWik4Q2hcJRBNy9/pgI/S
         BEkRlCa8PN4vrFyvfTHmcORQc5DKkicXuw8v8xUl0dd9I4/V6MY86xb5zta9VoFHjLZF
         hqTC4X+rUQTXDWma+CwZ/jvE7V0QCSq+p4MBfSMtzmZ5O2zP/d4gToLxa4AjF/AYs1Yu
         PwMsQfjIuWwd4/dmIP+OeHoZfHWNKT/K9G9c/hUfAGHjIgk+hcRLGipWV+jSpIgfLU9W
         pJrg==
X-Forwarded-Encrypted: i=1; AJvYcCXtL0I9FlcVPFCwi0i+2p3PgnQbEdkog8H0YHrWdTmUJ1Xx9VYkNmOKZcYx+/+fQ8uISKxsWnw9/EPSpaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylrOzAgvJJBcXaR4e9qPpgG/T287FCfPHpni7M4Mqcq43pWEad
	4DmM97TBjiNk/GOunCT+npXfTnqbEHfqwflUoLEqaWQtq6+gTfbU+TC9
X-Gm-Gg: ASbGncssKYSBxRDPORpfJYt+WGvMkPOfQG6dtgtv82/mLKAFtO6ueSdRP5rA3NapjFb
	5P5uvzL20U/6E34W/NoLO0uohLE7ZFF/Mr550pzSxaYjs/gi/tGVoLuXC1f5THBmdN0cUwA5F3T
	MODJJf9fbZ8IP0HUeA+YDCZkk44l0wv/5WZdmfnYuzRDmsUUg5woK893EObWgpIDDKCx7kQDbtb
	UYYmNkxA2ZOCrktwaIf0ZyNA4DM+ct83LvQXevnUYbL7VkN6G5+GXmy6dYzdO6vCamXueyJlz9J
	n8nr3h5mUG0DnNlgIKsSnmCloYwRClU/VjVA1xrpGgGSlIzN/FYd1U906baxSBSSh6sgYqCB7j2
	gmLj5zbYalxDEzkORhbe2EjW3XJT1rUOxaeQ0YmIFtRXXCnp3LPKKn6iHrzv3Wj7AU+jD8VbCSo
	ohLZaxEjDJtm/o6byzV0yTEbBo9A==
X-Google-Smtp-Source: AGHT+IFZdmElqbY9AODKm8wDfOCdQUqzn7Zp3okj0ZJauLQDD2dujxP+a4vOZzN9gWrLXe/og7S+0w==
X-Received: by 2002:a05:6402:51c9:b0:640:b825:183d with SMTP id 4fb4d7f45d1cf-640b8252621mr8119844a12.14.1762268825258;
        Tue, 04 Nov 2025 07:07:05 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6805da3sm2342014a12.15.2025.11.04.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 07:07:04 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'
Date: Tue,  4 Nov 2025 07:06:12 -0800
Message-ID: <20251104150612.1874-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104150612.1874-1-laurentiumihalcea111@gmail.com>
References: <20251104150612.1874-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The DSP needs to access peripherals on AIPSTZ5 (to communicate with
the AP using AUDIOMIX MU, for instance). To do so, the security-related
registers of the bridge have to be configured before the DSP is started.
Enforce a dependency on AIPSTZ5 by adding the 'access-controllers'
property to the 'dsp' node.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-aipstz.h | 33 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  6 ++++
 2 files changed, 39 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aipstz.h

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aipstz.h b/arch/arm64/boot/dts/freescale/imx8mp-aipstz.h
new file mode 100644
index 000000000000..6481c484ca37
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aipstz.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __IMX8MP_AIPSTZ_H
+#define __IMX8MP_AIPSTZ_H
+
+/* consumer type - master or peripheral */
+#define IMX8MP_AIPSTZ_MASTER		0x0
+#define IMX8MP_AIPSTZ_PERIPH		0x1
+
+/* master configuration options */
+#define IMX8MP_AIPSTZ_MPL		(1 << 0)
+#define IMX8MP_AIPSTZ_MTW		(1 << 1)
+#define IMX8MP_AIPSTZ_MTR		(1 << 2)
+#define IMX8MP_AIPSTZ_MBW		(1 << 3)
+
+/* peripheral configuration options */
+#define IMX8MP_AIPSTZ_TP		(1 << 0)
+#define IMX8MP_AIPSTZ_WP		(1 << 1)
+#define IMX8MP_AIPSTZ_SP		(1 << 2)
+#define IMX8MP_AIPSTZ_BW		(1 << 3)
+
+/* master ID definitions */
+#define IMX8MP_AIPSTZ_EDMA		0 /* AUDIOMIX EDMA */
+#define IMX8MP_AIPSTZ_CA53		1 /* Cortex-A53 cluster */
+#define IMX8MP_AIPSTZ_SDMA2		3 /* AUDIOMIX SDMA2 */
+#define IMX8MP_AIPSTZ_SDMA3		3 /* AUDIOMIX SDMA3 */
+#define IMX8MP_AIPSTZ_HIFI4		5 /* HIFI4 DSP */
+#define IMX8MP_AIPSTZ_CM7		6 /* Cortex-M7 */
+
+#endif /* __IMX8MP_AIPSTZ_H */
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 426c11853d84..2173b539dfb5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
+#include "imx8mp-aipstz.h"
 #include "imx8mp-pinfunc.h"
 
 / {
@@ -2479,6 +2480,11 @@ dsp: dsp@3b6e8000 {
 			firmware-name = "imx/dsp/hifi4.bin";
 			resets = <&audio_blk_ctrl IMX8MP_AUDIOMIX_DSP_RUNSTALL>;
 			reset-names = "runstall";
+			access-controllers = <&aips5
+				IMX8MP_AIPSTZ_HIFI4
+				IMX8MP_AIPSTZ_MASTER
+				(IMX8MP_AIPSTZ_MPL | IMX8MP_AIPSTZ_MTW | IMX8MP_AIPSTZ_MTR)
+			>;
 			status = "disabled";
 		};
 	};
-- 
2.43.0


