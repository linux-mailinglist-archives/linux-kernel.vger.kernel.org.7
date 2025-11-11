Return-Path: <linux-kernel+bounces-895354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD3C4D925
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD318822FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CE8358D27;
	Tue, 11 Nov 2025 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvwE+mTZ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4FA2E3AF1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862471; cv=none; b=A3lBgK7mKJxd9gqg4EjNvQNXlUiGDtpXn99W+w0U8d/c6eXdF88KrnkMG8Jhsn0tO9SGRJkv5dLGd23mEnJXa4+B4bq6qoSlupK7wR52onwfHzV+AU1TBH9FsLv5WaRcpbDYDAsDLPGmRZbT5PDGSb0B448CqLFr1pmn3U5xOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862471; c=relaxed/simple;
	bh=/gzHGuZ/b71YHeLNSCqF7HwGsuPs7oNiMaA7VmETx8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0osxkUjGwj3Oum2jzGFld5KZmtG/kPlXkJoJSND+QHA1sOskhCjBLmNxmzZsnJ+8hUEZB+lJoRu2pXvsk8F+0LocWn3q2PJ+2IUriZtm8VxPN+GeilAaI+b/jtLgcDCJ2cJxXixqHiAuF/9jVZxmKyrpUZKUcheqFD9GEeBP2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvwE+mTZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso8097118a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862468; x=1763467268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9kL7sLOaubIomrxMG9EMGJEPQDeUh/zlxyCoHi0rRk=;
        b=IvwE+mTZciSfhqvPK3agkWbkUnd3cGqwlHgAv+uRYyoQSqaN3C0BOTVYuaS1S4rMeN
         ZRplJxbOYD+PRmvD2Zvkrr/UdM1NV3wS9H8XrJ9INdhG0tcCgew/aWkB6tgUYwsvHxhD
         ooZ+wRBTiRiLSsttNbPsnWCM97imu954pc21MFNsZ9n1ApEO3s6nJ7bPYakzOw6WTeTJ
         JKBZd338TanZgmgLfzKx5bv6MuCjZBErnQfjxjoUtWprjrfiwmnOeiFXPsrUVX51ilMR
         54GjPUSlRNeBsijSgP3UAxYmUxKw33ObS6uM1fKDIQGpOsrJZ3+31ayFI3F1+tKfcvbN
         a0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862468; x=1763467268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y9kL7sLOaubIomrxMG9EMGJEPQDeUh/zlxyCoHi0rRk=;
        b=AYgvP3Ls7/56CGma+B2GW+lSFfpXu82OrLcSfYWZ+I9BuUFnkKqQw8nCzEZOCsaIml
         hag4e5YE8YBsvCFNHd8gu9lm+h0gGuFrqTtB/t7YN7x6Wp1BT9k2q0lY9Ka+NOONSBXk
         u9TeUmmHzP0SKRbwbCJAxnKOh6NL7lPg5BZtO/Ru9PLf2ZDUFnuGSc5Ec2xPv2Bmcs28
         SR3Zi/LzwXXk/t0as45lzcRGNpSNcNIcziNs9ZfScxXHPTPwQN5eLdzD94gBrPW0v+38
         ++2oj07hU/WZYCeXPN0invZg4UrcBxjqiN1ydCX6O7HVGhl/vYd/ftGJE9CPQK8xQE6l
         n0BA==
X-Forwarded-Encrypted: i=1; AJvYcCWNFpQF/ci5YWwO1wFw+d/OXb+Kl+MJA7x7bqGHuduoHQVwQj1uWGeNZzGAovg8XxZ6Nl8Zr/MyU0CuGSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSpPYj1sQbUbaqg08rNFnR7bGefGR/7Qq0yC/foHIZZqy59wu
	FDJfnYWvkAAeYES5v+q8LreB9Hcd/Ru1vuAtQhn9ib2jNwWRtuUlonoA
X-Gm-Gg: ASbGnctJIJr2XweTInrh54wec4bYHiZNuHeHg7HAftrr4ylxEUZn1nGneiOMUTm/SLa
	4V2QkMr32za0oDdLxE/NW3VFPJUB8Bcy0CcsZQCy4E/rDicqT6FIpxcibWkezcSoFPrXr2NMefn
	yN+sKVK6sLQnms+wkzhdvwf4eXVmvJ3o174M+A66IKp7Iw4TzLrq3zBc08RxE5Yphd0AYKzOcdW
	jDXlH90rJeF1IBrAvntRLLu7gergnEQTIASEZPdIdqQfpd02j4nPzDFZqAchhGHeblwtLU4avlf
	KIiwN/GqT9o4kFPcg8mbs4pvIvVljA5scw8gvcKMuZNk23Qt1bGC9FWgoeEOqrGDLB0RhnMQn9L
	JMTI/FLqUYGYQiIEuyX6VT+WKWg7rn/wYizu0lIdMleucWFLsnHvTCk7qUjbb7iTwCLdfKrrV7S
	8LfhL5iD8QVXUbiRcsB5XVVGtrQ6eN2EM9+0vz
X-Google-Smtp-Source: AGHT+IGQs7jakKZkFO/dMmI5qT5oEtzxJPB2RdXOKmXDqglsY8VX/AxfcjPsqoxWzM27nSsqJCFqIA==
X-Received: by 2002:a17:907:7f21:b0:b72:5a54:1713 with SMTP id a640c23a62f3a-b72e04efb37mr1121724566b.58.1762862467536;
        Tue, 11 Nov 2025 04:01:07 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf407a01sm1340707466b.22.2025.11.11.04.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:01:07 -0800 (PST)
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'
Date: Tue, 11 Nov 2025 04:00:22 -0800
Message-ID: <20251111120022.696-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111120022.696-1-laurentiumihalcea111@gmail.com>
References: <20251111120022.696-1-laurentiumihalcea111@gmail.com>
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


