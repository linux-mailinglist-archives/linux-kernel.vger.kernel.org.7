Return-Path: <linux-kernel+bounces-851847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E27DCBD76DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071D618A29BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466BE299949;
	Tue, 14 Oct 2025 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3xOYGg3"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A845261B9C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419971; cv=none; b=YRL+65BdCSD9aGi+G955sJTk9aiddj2kuzsSO9rmWBorc797GTDpdR7bujmz4MVjMK/D3x8IYtp1xrD38WrTlWMaez+LWO+KSGYgjBg4LEQJihyx/uUMiJLyEZYuJwOj5FqjHwc0Quy/VDsipZNcRvjFDzfFLrqu++KCv8148E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419971; c=relaxed/simple;
	bh=85lsaqBLyATDhWxcGtHCb8rrSMM1Zi40Ykn/mdczpbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6u4Y2W9BG9XBh+vXXHeI/4Sz1Jhd3DD9Az3WpfaE48sxyx2iTum7uBtFAhIp/KloPGBcT1KL4GVt22wS27pRJQynvkjHYHWdsw2fjv98jdapeWtUmDQzz/1Lu6L4NjQ91DKxrjLxBGhcq3xvFL99IboKlcztb9osn2MuyT7uQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3xOYGg3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4715311b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760419969; x=1761024769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIknfe4iunyEV+sctQbH+hV6F4kkt3Ymm4KKw2uvoJg=;
        b=V3xOYGg32HE+mQvWyVV3FGxhSu9YRa5qFNhVGENnLZ+3QUw5cMa3pXZTKYJeVCSQ1H
         imd7HOZqhG9HdSXnwfg5wv/NcT6yN+CPvSa1QPTJi+BR6R4P7JI2KwaIoaEAlwz34ThQ
         lU1fVHgs4POqm2cmGGXDjvMNyypfPmKTxpaVd7anfwBcxfQgSU2iTAE3bNnp1k+FdKCi
         YXlw/tiq2Xfgva/af3v7z4oCrpwDGjTh2+wR9yYw9MCMTM3ol929XOpJKalPRZs5OPxw
         EUuwCy1EKnbWFC6lDqIDQ+pdClkxSsX1yEj2Bvm8AogVDeemLdU+UEUcwTTFzIzZvoSf
         SXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419969; x=1761024769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIknfe4iunyEV+sctQbH+hV6F4kkt3Ymm4KKw2uvoJg=;
        b=Llvo1ibPk6KodbMtXvaaYuY0/BT/+U7oF7vDB/0LI7uGCnDvZtd8gEgIJfFMZj51Pu
         gZJ6jX3MQvdUOkY2iXn59w/utcZBzdZPeb8rAMlZ/XJmnggNkKLd8q8FdPyBDQnjLPw6
         id2HRbVVYa0rSm4Srw5QVKKmoSHboyLfP6DmWJInpEkItQqUEHsdZL2Bd+mSeYjJ0i7P
         Z/Bxu143XmkxmupB9z1/Mi9ESUAYjhTDHOH5TWC0LUYoIydcWrTIOXndsXsoml72b9YR
         xupaAnarJXlhiJLpxiiyvZ9PGERDNF17qqnKyCeqXQO1LiQFuF/mnDvKaYfHHnbpEpYB
         JcxA==
X-Forwarded-Encrypted: i=1; AJvYcCXY/QwdWE0iWbnDYXAx/5IFiwV3jmJOiJTCudS+LiaF8ZfFA/9QDTvBT3jjUGyO8FoLNlACeefu9V+hnfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuYoulEHqspfun15NuJzhX+sqdEie+58z8TYvYXwi441QXcqPz
	TB9p+EhV8Ek+b35HAasFYB1zZKxfnSMnbQ5LUBpsNpcDaByh+ghzrLig
X-Gm-Gg: ASbGnctwZhtQNRJGAihqd192KP3hNdQ8tF9E6izkBMlejmJ/mzMSqsjuAox79Hzf1/R
	Xj0Pj662qqU22SoStUP9zKCSRHsIcXWx+RR9gQNGmGgy7sVAipSa96+JlGht8R9OxKUvCLDIwup
	WOiL3NDwvoRry3bB3gaZ/czWMg/igMAXH5hrlT80JPGxs4rObKbVqprDbylLsm8Rm5KK7u27zrR
	pKc4QHgM3vqoxsp6P84paqCH/jwWc82jSK5cPvcI2lLMm4QPE0S9fIadsVDrVbWySi8y25IZlA3
	e8hJ3yq1VYAKLMrqWk+UcPavmyrYS3le9l6FFmtoV89Nvmvm+83F7geWl1quTwYOhA1TQqbWSPk
	9ewCJQAiCyZFV/PsJDFh/fkOjGR4vaMoHAh68togHOZ4n4cQCX1kBd/b2RM/zZmTN90sMuftag6
	uj3BWxfQ==
X-Google-Smtp-Source: AGHT+IEn0XEshB+1n9kBWgR2h4V4uZvGklzrs67V8SZIY7EpnFpo2hMt7lQhdAt8fnMMxg24vL1UEQ==
X-Received: by 2002:a62:b608:0:b0:77f:df:5c3b with SMTP id d2e1a72fcca58-792323d496cmr24204935b3a.16.1760419969299;
        Mon, 13 Oct 2025 22:32:49 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb11ca0sm13707518b3a.32.2025.10.13.22.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 22:32:49 -0700 (PDT)
From: Joan-Na-adi <joan.na.devcode@gmail.com>
X-Google-Original-From: Joan-Na-adi <joan.na@analog.com>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Joan Na <joan.na@analog.com>
Subject: [PATCH v3 1/3] dt-bindings: regulator: Add MAX77675 binding header
Date: Tue, 14 Oct 2025 14:31:40 +0900
Message-Id: <20251014053142.15835-2-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014053142.15835-1-joan.na@analog.com>
References: <20251014053142.15835-1-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joan Na <joan.na@analog.com>

Add binding header for the MAX77675 PMIC regulator. This header defines
voltage ID and regulator index macros used both in device tree sources
and in the driver implementation.

Fixes:
- Removed unused macros
- Renamed macros for clarity

Signed-off-by: Joan Na <joan.na@analog.com>
---
 .../regulator/maxim,max77675-regulator.h      | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 include/dt-bindings/regulator/maxim,max77675-regulator.h

diff --git a/include/dt-bindings/regulator/maxim,max77675-regulator.h b/include/dt-bindings/regulator/maxim,max77675-regulator.h
new file mode 100644
index 000000000000..b3b52d1668c2
--- /dev/null
+++ b/include/dt-bindings/regulator/maxim,max77675-regulator.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD 2-Clause */
+/*
+ * This header provides macros for MAXIM MAX77675 device bindings.
+ *
+ * Copyright (c) 2025, Analog Device inc.
+ * Author: Joan Na <joan.na@analog.com>
+ */
+
+#ifndef _DT_BINDINGS_REGULATOR_MAX77675_
+#define _DT_BINDINGS_REGULATOR_MAX77675_
+
+/* FPS source */
+#define MAX77675_FPS_SLOT_0       0x0
+#define MAX77675_FPS_SLOT_1       0x1
+#define MAX77675_FPS_SLOT_2       0x2
+#define MAX77675_FPS_SLOT_3       0x3
+#define MAX77675_FPS_DEF          0x4
+
+/* nEN Manual Reset Time Configuration (MRT) */
+#define MAX77675_MRT_4S           0x0
+#define MAX77675_MRT_8S           0x1
+#define MAX77675_MRT_12S          0x2
+#define MAX77675_MRT_16S          0x3
+
+/* nEN Mode Configuration */
+#define MAX77675_EN_PUSH_BUTTON   0x0
+#define MAX77675_EN_SLIDE_SWITCH  0x1
+#define MAX77675_EN_LOGIC         0x2
+
+/* Debounce Timer Enable (DBEN_nEN) */
+#define MAX77675_DBEN_100US       0x0
+#define MAX77675_DBEN_30000US     0x1
+
+/* Rising slew rate control for SBB0 when ramping up */
+#define MAX77675_SR_2MV_PER_US    0x0  // 2 mV/us
+#define MAX77675_SR_USE_DVS       0x1  // Use DVS slew rate setting (maxim,dvs-slew-rate)
+
+/* Dynamic Voltage Scaling (DVS) Slew Rate */
+#define MAX77675_DVS_SLEW_5MV_PER_US    0x0  // 5 mV/us
+#define MAX77675_DVS_SLEW_10MV_PER_US   0x1  // 10 mV/us
+
+/* Latency Mode */
+#define MAX77675_HIGH_LATENCY_MODE  0x0   // High latency, low quiescent current (~100us)
+#define MAX77675_LOW_LATENCY_MODE   0x1   // Low latency, high quiescent current (~10us)
+
+/* SIMO Buck-Boost Drive Strength (All Channels) */
+#define MAX77675_DRV_SBB_STRENGTH_MAX  0x0  // Maximum drive strength (~0.6 ns transition time)
+#define MAX77675_DRV_SBB_STRENGTH_HIGH 0x1  // High drive strength (~1.2 ns transition time)
+#define MAX77675_DRV_SBB_STRENGTH_LOW  0x2  // Low drive strength (~1.8 ns transition time)
+#define MAX77675_DRV_SBB_STRENGTH_MIN  0x3  // Minimum drive strength (~8 ns transition time)
+
+#endif
--
2.34.1


