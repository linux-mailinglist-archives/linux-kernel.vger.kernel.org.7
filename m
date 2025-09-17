Return-Path: <linux-kernel+bounces-820203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29688B7EB62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EADC1C05644
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031A13093B5;
	Wed, 17 Sep 2025 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WWny4WVo"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80992308F25
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096347; cv=none; b=kPZKiIuzwO8mucFDIxs/JS7eh+bt38Wq63V+WRzPorO+XCcHK1Gv7f6OQAVKIwh/rqQ4fJNUOA4Bh0anb5oQHfMkursHTByJDxSrpMCEFvmkT8AsM4YGe2Z+075+9OInrd6FHpeNoxbr307tgpnTn7msUQR66lIZ8xDW+52Q+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096347; c=relaxed/simple;
	bh=is+QmPpGFqnxwUe0KKjrEay6S4ZGinDIfN9T4PpumlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coTKvAj71kfCEL2IBg1KntbdePK4ExNsDbXUg4uYQ8TkmlhF0LQbCNU2IqsvpR2SM3a/F2uReAO3Qg8FJHO57fIgFYXFSLAirG9zmL3rWa+ztkCsFPI8qyYng+tUUK6hY4vpHcVOCTyLJUXFEH19nLUNm7/eHD+V9aDzOJeZSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=WWny4WVo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f1987d44aso5632171a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758096343; x=1758701143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA/la65cC0J/yoE9Qt381Ko1XSyZ3tw4GtydE8nU3zI=;
        b=WWny4WVo+X6sRznOgMwvWCbSS6Ymekw+fU3m9vQmMdJX77oNMt2MtKi2+2Rin/MSeT
         rmPKbxJizmI901UejvCxkHJ2QaCuwzlm9xaMLYrmp2hVg8FSgemNqQ+8kmDWCXqS+T7u
         B30Rb5+lC6lYRblUOQBDoCi63eW5TmqCkin8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096343; x=1758701143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA/la65cC0J/yoE9Qt381Ko1XSyZ3tw4GtydE8nU3zI=;
        b=YVkAJC+LFEtIv0+pVmtoJItNa1tMKC8+5AfJCKlacjft093Vh0aeD8ggF4EaOkjJBT
         1yUc3XQ6S5xAqCF/zhGrITJFB86A7SveA+/Id/fpMbzsRgZPQax69YTS9IPuvs8rC7QI
         yXwYbHa48pYpHOlqfC9Yrwy2j6rnd6HF3/DQd+HyuvFz9VPjD4oXPk45184vZCjZO/ge
         1t7PTfza+St9R/UO+6cW4GqO0IwDf1ictMnbJ/lI/yD4D77P0UNbZhWBj1C5D3xdw8b/
         Fg+gwGWygo03AR9QOUfN29dgw5vwxv18upNrR7jrejWk6dibhJALFyWQoSMjg34lBNxS
         Q+Gw==
X-Gm-Message-State: AOJu0Yxwzd5LLsOVxcM38aqgRcnhnJKV1Cr4XY57V8ivzr54CquWE4gi
	RMiEwe8ZySbnZgM0wp9kItGw5FmWg8rKcT6bKiPHrm90utwcCXWa7Ys5fJ/jx2Y/CPz7qlIOHvY
	qc/hJ
X-Gm-Gg: ASbGncuW0FmyMiBf7Sb+WjVwK277Orr0c89IzQFiEAWTt48+kNPLROGuoaGpYMBFAka
	nP/MggGYDJpEF15E2Dker7oaRK2V1u0NmXkINYDjausr9PYzF9EdtjXu6/Mb0Bt+ikIeg+3GQEl
	KpT2yInmAT4AGYm08DYhp2XmILZCa6UPueDCHiX6EOs0A7xBANRDrng3TiFP01u+ErnIiItyITb
	r0wjk9+LWqgNfZiuLGXRF49qXyMyeOqT2eibQPSf+Nw6DqHTbkDWasoq9Qo8dCcZsX5YPKKHZEy
	EdntyQ49HV8mWvfHMR099QCEm2mnlRWc1CoUme3zqLg6eOt9O0UVw7ecE5Ehjuwccb8/WIP1iXg
	IAy/hX8zvhEEV3dyID6Gi80XndL5bCad47lOwJXIhKQsI5QNN2bjSLDZSOQg=
X-Google-Smtp-Source: AGHT+IHgnDmHgbGe7M2wf+eae5X2J65rFCbRDo8gVvx92rWiaCFtz+XyS2dWxPaksXXrHlaef/NgWA==
X-Received: by 2002:a17:906:d555:b0:afe:ef8a:ac69 with SMTP id a640c23a62f3a-b1bb7d419ddmr158716766b.43.1758096343566;
        Wed, 17 Sep 2025 01:05:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:1215:4a13:8ee5:da2a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07e1aed5ffsm924936766b.81.2025.09.17.01.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:05:43 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 4/6] dt-bindings: touchscreen: fsl,imx6ul-tsc: support glitch thresold
Date: Wed, 17 Sep 2025 10:05:09 +0200
Message-ID: <20250917080534.1772202-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917080534.1772202-1-dario.binacchi@amarulasolutions.com>
References: <20250917080534.1772202-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the touchscreen-glitch-threshold-ns property.

Drivers must convert this value to IPG clock cycles and map it to one of
the four discrete thresholds exposed by the TSC_DEBUG_MODE2 register:

  0: 8191 IPG cycles
  1: 4095 IPG cycles
  2: 2047 IPG cycles
  3: 1023 IPG cycles

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v4:
- Adjust property description following the suggestions of
  Conor Dooley and Frank Li.
- Update the commit description.

Changes in v3:
- Remove the final part of the description that refers to
  implementation details.

 .../bindings/input/touchscreen/fsl,imx6ul-tsc.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
index 678756ad0f92..1975f741cf3d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
@@ -62,6 +62,20 @@ properties:
     description: Number of data samples which are averaged for each read.
     enum: [ 1, 4, 8, 16, 32 ]
 
+  touchscreen-glitch-threshold-ns:
+    description: |
+      Minimum duration in nanoseconds a signal must remain stable
+      to be considered valid.
+
+      Drivers must convert this value to IPG clock cycles and map
+      it to one of the four discrete thresholds exposed by the
+      TSC_DEBUG_MODE2 register:
+
+        0: 8191 IPG cycles
+        1: 4095 IPG cycles
+        2: 2047 IPG cycles
+        3: 1023 IPG cycles
+
 required:
   - compatible
   - reg
-- 
2.43.0


