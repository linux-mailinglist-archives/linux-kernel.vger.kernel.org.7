Return-Path: <linux-kernel+bounces-837355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E84BAC1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181D0189561E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECF72F4A00;
	Tue, 30 Sep 2025 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XttyYDmM"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A132F532F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222016; cv=none; b=sp22xvplKPtDp8nclnzWYLCgfr5si6bPYjmpBLC5Yu0roJB04zujntw+/D97ZKupZNMWOxyhRGWw3l7wdJwu2YaBBoBmnH5YuVpZTVu1U9cItvTF1wthexb0LWWSCcW5HH3sJBJFHm6O+nKG3X/CBx6wdc35kY8poqvelwI9fNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222016; c=relaxed/simple;
	bh=zn+CaRbVeke91i9T3DQ7+L4MQQGRwZK7VRhzOr2u8RA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qf3l/gVEPhcNuDv0tpQIMf6eEdMSbXCbpIOBJKNr8NaX2IQmfAg83qNVxvb8Avy/g5vDhPqcbYGiv2MXrjA4K9ZZhBV1T0lhNVzrAm2KHGdYk+1OyudU94ijDFgWInkeb6w0ohF2ntbdAhi76CWpgsL+EzktbmFxv7AkegGcqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XttyYDmM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e30ef74b0so39083765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222013; x=1759826813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V33lrbDBdpgDfc9x4hYQa/F6X3VcQqYOJF639C+QnLE=;
        b=XttyYDmMvRIG02/ZyPu8rYaQV+8WziP8W8KhOEheKBC7ieJp0JTb8bWQ7jxy6NNG5u
         I9S4bFIwEZGazeN0HxdmooAdONnHe31ja3Qg13+5VfEA/W/fFUU9xKWsoAoAviwBcM0Q
         a25ty7TcJOWw+FzwpWu9RKQRP4RAq6Mq/9eWtVl8sZ22braR3S0GpIIjrUOIXQouQga+
         4/tYweo6m74cWELpYq/soGkeaynSs2wJ7iYvzMTqBZHvNihbEry2UM6WVOl8DXj/B1gp
         3hM8lz68fGmtNgATJ4CwLXTVfKdN/DCMLLPfvi472568jzf5EjFLTinA6ILZQzn7rOYr
         SLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222013; x=1759826813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V33lrbDBdpgDfc9x4hYQa/F6X3VcQqYOJF639C+QnLE=;
        b=qOk5j09hRGh9kxr8HJkGtaIvSOdzVI3jyRjUDg/GV2SK9f/QdxBRhLuiPWFMOUSWJX
         pbWC2obRU7Rx2w3Lb8AMKDg6P2N+zaqxJWPYw2EXpm5+UH+yu5oBxMmVwzl24uPsfFTX
         opiZIwnpG1ZZq1QtxNRCEIrSaGPtGSTSafhzBFRejNfwpzja5PfYCyfA1FVJ2Va73OGC
         UQirJa5qOlH7ZnI6woffJqrNMibGin2HOConZksEszgb9iuTfOPvaKvTSzIYA8xR8RVF
         PuiYDcoDb13eehK2n0LJMU68ySEqCdn1Wtxm3X4asNapToCaX85GQgkDiw4nEatlC7qq
         22mw==
X-Gm-Message-State: AOJu0YyaYFWTBwoejgbTqEpFv2A0QdFKFhQZj6m21nJXsrFLiIfWOfW8
	luRFfmNDMWsm/7J0CkJWsUwOzDDkUrRf0W1c9dWpYENTGMt+EcoOk9Qz
X-Gm-Gg: ASbGncvay2hgoXE1WpBVp0DWI/QJdsz7UrNkJyRxrylRMOyBUTl0ncGtGwEUg3t1OUF
	ZJBYZLWdJHfZ2blvfUSr8cyiwECJ3T8oeV0NuruXPgiEiSwgJtRU+QvhULvFPf8kM+G0ITaWyYp
	Djf2EPhMBEyMmrtpFWvSFS97nzDIbHMQN1graLqTGJVX7redR3YCItPWymvn2L9EBXtP0ChzqqS
	6CWbIloLuFjsaJfR1hxdhY9hInEkc9MJ/n+0MV7Iox+Kr91P1KbWvcezaaN5yZb5uFbIwRkkz3b
	lYs7JIT4AymrVvIs+I1FC0jD0sB4ZT8FgOtCmoX4uaDgxvZO/VxdQVFxSvAXVr7dSYumYpOGVNs
	L9wmQpLEQJkKMlycyDEFSaQfCoab429bKO2T843+zL9nRCKeK5gClYjzI9S8XTKGAtzUsfgu2gh
	LhqBl/oaTUhZEq1MmY2LZnfKS3Ei8V63iq/uNsXSS7
X-Google-Smtp-Source: AGHT+IE6t7X9LCnai11B2rSAFpAnlmP2yS3ko2WKL5rG+zgL8fO97OZwBT8DQj4yAE2uWbubKrm0RA==
X-Received: by 2002:a05:600c:a0d:b0:46e:45f7:34f3 with SMTP id 5b1f17b1804b1-46e45f736d6mr114824825e9.8.1759222012854;
        Tue, 30 Sep 2025 01:46:52 -0700 (PDT)
Received: from localhost (2a02-8440-7149-a758-f461-9bc4-1c75-ebc1.rev.sfr.net. [2a02:8440:7149:a758:f461:9bc4:1c75:ebc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f3dcacsm48573735e9.2.2025.09.30.01.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:46:52 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 30 Sep 2025 10:46:45 +0200
Subject: [PATCH v8 2/7] dt-bindings: memory: introduce DDR4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-b4-ddr-bindings-v8-2-fe4d8c015a50@gmail.com>
References: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
In-Reply-To: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Introduce JEDEC compliant DDR bindings, that use new memory-props binding.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 .../memory-controllers/ddr/jedec,ddr4.yaml         | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
new file mode 100644
index 000000000000..a2eb6f63c0ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,ddr4.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DDR4 SDRAM compliant to JEDEC JESD79-4D
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+allOf:
+  - $ref: jedec,sdram-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - pattern: "^ddr4-[0-9a-f]{4},[a-z]{1,20},[0-9a-f]{2}$"
+      - const: jedec,ddr4
+
+required:
+  - compatible
+  - density
+  - io-width
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ddr {
+        compatible = "ddr4-00ff,azaz,ff", "jedec,ddr4";
+        density = <8192>;
+        io-width = <8>;
+    };

-- 
2.43.0


