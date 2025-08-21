Return-Path: <linux-kernel+bounces-779567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C842B2F5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E386AA80CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3CA30DD31;
	Thu, 21 Aug 2025 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPP8tN97"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976C30BF7F;
	Thu, 21 Aug 2025 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773815; cv=none; b=malB8yn6FfrzEWFBH9WZC5dGnXyELivaw1U1zz20iEP6bV+2tFjLb3EpW0ujb9zmHWzMiAUx0pMAPthJREZJoPsK84Myh2bz0lnMhvMiU2ZgkY52lhTRYLcnmzzSEiQeteAEMFSjIXcQS7wqB6duleGqOgr/wib1ph4rBuSkdlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773815; c=relaxed/simple;
	bh=1QYvmumnrQVxK5rKCYmD/4xmuhFCKlHqnY40YuMrTis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epq0lYpBrgyiJ4mUYN0+Zey7YUTiPEBlES4zs5q+aNM2ZaVhIxaiHEkqUPOcDAnp6HyG4WgPyCFKvj9OS74oYeZfCHWIFkZjRy6TLQVbemX9N85zSFTDRMYBPiWrnleiEqkP3cQfPlyq1HsI6R36k/TF/MXj0fouLBblRSoXCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPP8tN97; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-618b62dbb21so1727032a12.2;
        Thu, 21 Aug 2025 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755773812; x=1756378612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2daTJdOUs7gwwo4Y6Ley9/OGggF+jXeQxzTCIINH4FI=;
        b=OPP8tN97m2iDBt2MY/ycfDUx5DggyU+qsf0ULTpm3NT1o69jwUH3FvWarjume1WV2A
         nJmSWlZsntn5BarQZQ7/Vd7xr4T8USxSUVzYGbC1AwdUcdcVZ3qZl+Eh+MJeUgPcbwzm
         1SDhcwr1l1JhQSIirZ/PhyDDCeSpcdgQpQW4tkZfq1obiImiLAGAicPurIDA6GuLixhm
         zCV4R3AkzTRKuvBm/Ua1dbRSjJF9/MiOH8IkDX25aNOCZ30HCuKZA1EoXcPTvfoaZ6iU
         6hopLwMCmZvOUCuZ3wQ+v7Yqml0AhHdNcfVn7IF67WDV2GmrsWMh6k1nkTN7CgDA/eM+
         6rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755773812; x=1756378612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2daTJdOUs7gwwo4Y6Ley9/OGggF+jXeQxzTCIINH4FI=;
        b=OsV1DFzLCWxYPYd9K/34aeGqojYEkJY0wmDmH6N5+Fm74wIJwi7eL7Gba5jftpYRSS
         LD+Dz/cISQRpTX460UTqdovR2wBicac2f7v+FoPvv0fxl0w4ePgj0lMs9y3VEAao8M4C
         Bsi02YzY3MsqrC/9VCAk5Gqoh74SMRJ0RH0w71lXqrQfLqvOZOHWURYL2On6H8oFMqjB
         UwOW2I9G7q3fFORqll9MnUFe3fhLSHx+UD2J3+p6FaWKdS9JAuQb3KEVMAavAm+6c8rw
         0iDTdhI4AZFhubdyRqF599Uf1JrzwxCUDiDcMvjKq5WISOEvWyaTMCpbdpByv+GdcYw3
         F0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUIphD+8ALShhy+Mq48Kq2LK9dfsSc+uk+BniGIajatU8a4MqivysR5ZHfgz4v9XMw7cRCLtL5MnbD8@vger.kernel.org, AJvYcCX3/43Qq7n8GaFwYq9ssvjutc6Im6v3MDjk1kBnynFpthlUmWyCwwxFKZAK2wwBUgeSOtWAFn2GyTKM7UNz@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIo3A3enAFF4+Vg8UXvg1SP9bzqqzI6MLT3cmue5zWAGCBDtj
	8BclbDXOyKjlR92RaeEt2SVGX+lmQ2Nz/sEa1gVMqs/ugCnYG9KFEYcH/WfBlIsQ
X-Gm-Gg: ASbGncvvA2DQ8v90v8Pafr0JoPmzBNod1Jcfr59N3bD6EeucBjf76ylW5Jbu4l0iDda
	bIKozW/pRzUGV3Y7Nminn4CRkm0aiZEAFJ5miw3q45YOecZC1xQegt3GJvbZ2KGcUYJm1dVma4n
	SkHKzmaw2o7+udZSpWWx5kytxK6gN7BV7fv6OQH+NarTph4ePqeXBxuvE7sq2DlXF99z2oo80oL
	GCjjOuiIC5dS51Pv6d6iYZPvmEj830qc0wG8I0utRx3nyWqypOcgqWNY/E0prS54N4P0q4rkR4U
	J4LYz4SjKa6KdWZW9BcTwIJq2c9zDTcRNO8DJaRiNEFzZDZ06NS390P1rXhz1Jl9vqvFSfNqTHE
	jmN1scIXWD6LKwqQaJ7d7676xKvcsbIs3dJpdHa+nzsjF0/SuPad+
X-Google-Smtp-Source: AGHT+IFEe+0qmb0RjWgma2YAE8GxP9EJJf5z+x4gnLaWMQuiKVo3goUUZWAAcFHsJ3Iv3pAdS9sTvw==
X-Received: by 2002:a17:907:3d10:b0:af9:8438:de22 with SMTP id a640c23a62f3a-afe07d9c920mr191769866b.39.1755773811822;
        Thu, 21 Aug 2025 03:56:51 -0700 (PDT)
Received: from DESKTOP-TTOGB9M.localdomain ([92.120.5.3])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afded4790bbsm373602866b.56.2025.08.21.03.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:56:51 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: imx8mp: add aipstz-related definitions
Date: Thu, 21 Aug 2025 13:56:33 +0300
Message-ID: <20250821105634.1893-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821105634.1893-1-laurentiumihalcea111@gmail.com>
References: <20250821105634.1893-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add header file with AIPSTZ-related definitions: consumer types,
master/peripheral configuration bits, and master ID definitions.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-aipstz.h | 33 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  1 +
 2 files changed, 34 insertions(+)
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
index b62bb821cf61..afcd8c785cfd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
+#include "imx8mp-aipstz.h"
 #include "imx8mp-pinfunc.h"
 
 / {
-- 
2.34.1


