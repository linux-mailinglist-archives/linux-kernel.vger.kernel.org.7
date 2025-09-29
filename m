Return-Path: <linux-kernel+bounces-836173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DA1BA8EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A701C0AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34EB2FDC29;
	Mon, 29 Sep 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH5I27T2"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA552FDC5D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143410; cv=none; b=uM3s+82Y/DdVkI5fY+V3DuB2OyqadEdpKGJpGgzxx2JwuLyJU2xss6Fdmpi+5yJr7RzmjBKZ3xb3uYcj3kqg4/vTOcWWGIWg96bVQki2fZR+63wlw8nOTQFrA9dfoNDajip5ACTnQthXcmB3CibhomiWptyoG3eZJdYRjK8hAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143410; c=relaxed/simple;
	bh=Beq3zJ9Yir84ESXbuDFoAJxQDiqZxmnkRmEwjSUBkHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AINg46FRYODoxOFy0t7pgxyCev75RNMQMikJTmn4FYts/CEIEII2v/Ht04yU/m29xWsXNRAZzLl2lEPI8hovDWy8TLsT8yygbnD99mI5ezbWhrXSYmT7z+Gh+U6EebnS7ZY4FkC5XcFqstBpj6CkamcGKQPG95GVeW/GzeSuPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH5I27T2; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so3123030a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759143408; x=1759748208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pe1j9chdIMcilasNbgcFZSIoZX4HxLtPrmn8vQTZBk=;
        b=WH5I27T2xVM/8AsKTrQk6ON+Mxoq3CUBS+LxLiuhsR53pO6fMeaAEQU7l3djbVceBT
         E4dlWnFYsF93xBLYOc3Bnd9lG6sGlb8gJCWYkSt/j2rPMmKl1yz3gF8Yfd7EPJ09LI2j
         4iv1aZzUABeYKfQ9SbYATycyNJtEBOxqCUaXjuEfnB7SIhxxaNkFMeQoKOaU4ZIVR5xY
         XiovIs82JgrPQctk8e+IX0w8SCCVrhekINxCiY97PP6GRNBm3JJHxmNklDMthBVdc+JH
         NQ6tp17BPSS4JT6rVEt7XHfMkW9L7+Wqy7g5Y+LZ9YpiyIcrXWECw3GNPUrA1FXtBkX6
         74Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759143408; x=1759748208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pe1j9chdIMcilasNbgcFZSIoZX4HxLtPrmn8vQTZBk=;
        b=TqheXJ5104tupWJ4y3DzApRckug9Yt5zuJKkN81aRRe/y17HL5By+ZX9ye1yDCb0fO
         UZVKZLkVwFsfxNJLYruUdsVtHNEI8Ub60YBIVUTHxERxuQBJDD9Cx85j6WVwb3+hlTsg
         oIk4o8rIRiO1oCZlw0bLLnFKBBY6QUznY7/sKMUcoQw5ZPJ4z54CuH6ekKafWUBek4vJ
         8uihE+Sn7G45haxIkARjJSDLQbC78JLTcizleOj0stn6YtuGhmmfdcETqtB2TidAdZar
         4cBwXzDyFRGdMAauQMSAkhoUM9UpaSMsAdjdup/4NUI4JdgdVrxvvZrC2kGpTRsrl1kI
         kP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8mthIXVzkLI+IoZmUAkBQhTMkl6ayzJHKsz6x6LYgpYCJycFyqRa9QxmGZG6wLfFx5AzWClanCZW15U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQX7korriJESvRqwAPF16BiJL0jal8NfVNxpS61RggAJyJhojg
	YNY9G1/ye6CFRlMma81R2bb7Ru122dL40yWGY+N3LSk7kg5tNrwnq5UK
X-Gm-Gg: ASbGnctDPdT/iooaG0lMt6qTCpTjfyBl26B6Ww/gloSRqkfE/CcpJS7BEh+oFmc0/78
	3ehotSDo4SaD6V11ehhzbv1m4umeLObKe9PhndvA9+4Nj5SapW/AJXC4ng5gDvWN/KSnyTpTDhN
	cL9OfzH7IqtmZ/uQJLyOk30lPY6dNwjBb7zGyUSg3LGAYT0Tt6rimrtU7NydsfhKIR/vGLcjFVs
	QNRiMiSUsKQpvlnkUlSsQlI5qPZqwh6fFBzADBdo/j+ATIHbJmhUPrZfVPR8nAj5IaPpsbhbVlC
	zkkuTw1b/5yQWir1ypcjXCYeS9OVETGWYwSzh1pvfHInEGgsHyJASkM0QMJbICcpXtt3iqFRT5V
	vDWSudo4iz66x4oMLIxk1FUG+SB6ZxMjvnmZjxFxJmtV2+u4VyBFD
X-Google-Smtp-Source: AGHT+IEzNnzMQUmm64U2sdZ4qlIa1+onrCYJuYxc25Qz80fDiR49PF6DfOmnvPqN0nbAF5tDS663og==
X-Received: by 2002:a17:902:e74b:b0:24c:caab:dfd2 with SMTP id d9443c01a7336-27ed4a7aef4mr181988215ad.61.1759143407725;
        Mon, 29 Sep 2025 03:56:47 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28cef7db380sm4762325ad.107.2025.09.29.03.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 03:56:47 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: regulator: Add MAX77675 binding header
Date: Mon, 29 Sep 2025 19:56:16 +0900
Message-Id: <20250929105618.177511-2-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929105618.177511-1-joan.na@analog.com>
References: <20250929105618.177511-1-joan.na@analog.com>
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

Signed-off-by: Joan Na <joan.na@analog.com>
---
 .../regulator/maxim,max77675-regulator.h      | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 include/dt-bindings/regulator/maxim,max77675-regulator.h

diff --git a/include/dt-bindings/regulator/maxim,max77675-regulator.h b/include/dt-bindings/regulator/maxim,max77675-regulator.h
new file mode 100644
index 000000000000..df12cae5e250
--- /dev/null
+++ b/include/dt-bindings/regulator/maxim,max77675-regulator.h
@@ -0,0 +1,78 @@
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
+// Define the voltage limits for 12.5mV and 25mV steps
+#define MAX77675_MIN_UV            500000    // 500 mV
+
+#define MAX77675_MAX_UV_25MV       5500000   // 5.5V in microvolts for 25mV step
+#define MAX77675_MAX_UV_12_5MV     3687500   // 3.6875V in microvolts for 12.5mV step
+
+#define MAX77675_STEP_25MV         25000     // 25 mV
+#define MAX77675_STEP_12_5MV       12500     // 12.5 mV
+
+#define MAX77675_NUM_LEVELS_25MV   201
+#define MAX77675_NUM_LEVELS_12_5MV 255
+
+/* FPS source */
+#define MAX77675_FPS_SLOT_0       0
+#define MAX77675_FPS_SLOT_1       1
+#define MAX77675_FPS_SLOT_2       2
+#define MAX77675_FPS_SLOT_3       3
+#define MAX77675_FPS_NONE         4
+#define MAX77675_FPS_DEF          5
+
+/* nEN Manual Reset Time Configuration (MRT) */
+#define MAX77675_MRT_4S           0x0
+#define MAX77675_MRT_8S           0x1
+#define MAX77675_MRT_12S          0x2
+#define MAX77675_MRT_16S          0x3
+
+/* Internal Pull-Up Disable (PU_DIS) */
+#define MAX77675_PU_EN            0x0
+#define MAX77675_PU_DIS           0x1
+
+/* Bias Low-Power Mode (BIAS_LPM) */
+#define MAX77675_BIAS_NORMAL      0x0
+#define MAX77675_BIAS_LPM_REQ     0x1
+
+/* SIMO Internal Channel Disable (SIMO_INT_CH_DIS) */
+#define MAX77675_SIMO_INT_NORMAL  0x0
+#define MAX77675_SIMO_INT_LDO     0x1
+
+/* nEN Mode Configuration */
+#define MAX77675_EN_PUSH_BUTTON   0x0
+#define MAX77675_EN_SLIDE_SWITCH  0x1
+#define MAX77675_EN_LOGIC         0x2
+#define MAX77675_EN_RESERVED      0x3
+
+/* Debounce Timer Enable (DBEN_nEN) */
+#define MAX77675_DBEN_100US       0x0
+#define MAX77675_DBEN_30MS        0x1
+
+/* Rising slew rate control for SBB0 when ramping up */
+#define MAX77675_SR_2MV_PER_US    0x0  // 2 mV/us
+#define MAX77675_SR_USE_DVS       0x1  // Use DVS slew rate setting (maxim,dvs-slew-rate)
+
+/* Dynamic Voltage Scaling (DVS) Slew Rate */
+#define MAX77675_DVS_SLEW_5MV     0x0  // 5 mV/us
+#define MAX77675_DVS_SLEW_10MV    0x1  // 10 mV/us
+
+/* Latency Mode */
+#define MAX77675_LAT_MODE_HIGH_LATENCY    0  // Low quiescent current, high latency (~100us)
+#define MAX77675_LAT_MODE_LOW_LATENCY     1   // High quiescent current, low latency (~10us)
+
+/* SIMO Buck-Boost Drive Strength (All Channels) */
+#define MAX77675_DRV_SBB_FASTEST      0  // Fastest transition (~0.6 ns)
+#define MAX77675_DRV_SBB_FAST         1  // Faster transition (~1.2 ns)
+#define MAX77675_DRV_SBB_MEDIUM       2  // Moderate transition (~1.8 ns)
+#define MAX77675_DRV_SBB_SLOWEST      3  // Slowest transition (~8 ns)
+
+#endif
--
2.34.1


