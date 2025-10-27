Return-Path: <linux-kernel+bounces-871679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBAFC0E0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1407319A54B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F3323A98E;
	Mon, 27 Oct 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="EFcmz/0q"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2581C3BF7
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571820; cv=none; b=p7DPFoo/BR7ZQHmMxRcFmoQL9Dhs7aDBoUdsF6+GGRltzfUlXVAJ79Y6tV82asaGl1rVFDuqWxNTuf+VzVoZ61Bs2ijQasGEZRAJyWiASp7nstQBgJK9haUlpo3m8MSwnM7JoFOClqftbxHL19Brtbi/ifleNPxzsIGbrfrh0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571820; c=relaxed/simple;
	bh=dosS9pDdgnVcYrxQ6KebJvE9ghDY6SThkSzJfM3JnQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ob8alD+7KAOIyfL7atCn+EstixVCeH8r7x6k8cHbhnRhUBXpXfN3zXpdQNUwqi+YdSPsGYPkE9kwOgug00esjxVPf9UM6v6X1vZouWp8eSMt6YRBp9DbljfpEWdCW97y5DKYglGj5uZ6+71IHwPrZxO2ac1rE/PlE6flWQsT4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=EFcmz/0q; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-9459db1337cso208029039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571817; x=1762176617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8ni6EXakGblNMElr9yGEmr1BYrUDmPrrWLSAOgcMRI=;
        b=EFcmz/0qlDEOl5AyhfQ00T+cm0NRZ6HCB7u0iHA7sUz9RZiddJUjdd7m8OU1BsKILK
         UvIT3eKCaG3VwyQV0ALm90Pxn3rk0l2dlBz64bWkN+0nQakaNbhxNmknufhm28Z0wrEB
         xnXeKc4LM/Bid1AC1IBLRBT8sw905Qbcc1XM+abXTe1LLH7dyXeGB1pU3LM5TAE7nzTd
         cj7k1KwXYf8lUXK9uUlfJpNmwAg/qcQV+fBxnD/VCtsMN9IqxK7Lb5JRBnaS5tRAf3VL
         StmBwWwKWZxzlvsYkPjmSj74GYxYyjn+XSfrFiUUwkCt6wx9uqC1ocvwDFnMkTOLkQlO
         zQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571817; x=1762176617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8ni6EXakGblNMElr9yGEmr1BYrUDmPrrWLSAOgcMRI=;
        b=Hfx1y3lVD2/MTBrLWM7i5LszQ/XQc2/T1eUom9l0wufJF8f856a6hl6I0DQv+RTJjV
         mgl3NbGJPEDoY6UkVMcXXRhlicscLh80IRJwtshTYCF+zyi9SRFJQPnQnquDqX4L+PcH
         3HACrL0dNuSgbELfxLM0RiZLSFGT6mNaF1N2UCcF6ohTtDsXuFholLbjMyBT1C0weKE1
         BTZzAM1pabCa8uKZ6EV/xjTDyjjaYr+LBdGn+5isOTL0vKBGsU5/lzRTYKnsCik1Excy
         /HD8UnVt9T33aKQUjrX1AUa5W/l/XdoaRVejjTeLheKm+qlf7pQETlEzo/or7XACkjzj
         Njow==
X-Forwarded-Encrypted: i=1; AJvYcCX9zZMjuagunPEzDEv+js4/MR/D2njX/nfm3M8bf1s+ipKFzLLoB0Kd5T/N7yOURmQuKKvRFzFBFtgBOio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKtki327eM+HO/0Z2sGeigLF4V08FKVbajJD0NWNppmIitznAH
	EOeVwHezfZLPOEozc0GMeWkEVFl1Si6g7q5DQxz0v8pPVgyqCfx8Ka2hBHqkgbcadWM=
X-Gm-Gg: ASbGncstH3BTxlnQsVInyNCJcokbuQSzqwjfMWLLGy0N4lYhoRQ2nXu7gqnFaTP+U6d
	teuLJ5YhcOLWV9PkShYbFvwFad+PH637TPaJUkKnWa2vvDwMaxe10OSl+f5yORt2s2TWc5fcytg
	+N0HaXNJI1GdfNj0WqjgoXsIuoazROtVQmJRIR2xUe9dpS4mLIO9AJX9o8JcyZSrpMHVwkCopfI
	EqnQzorySQmfNKGFof10EKmYykV3rIgV73tHJrnSTpB2svISPxiCMySwEtaOaMaM7dVCgD52lHm
	u88G2U8AKSCACisycLNmiRwpuO597brAb+smC78MhKe+YD9ZSUukdbI3lShUToGwKdUMTVQL7GU
	T8UnXvLUWIrmUK8NYls0x4k+sTCHVv9Ee6aM5T2+zFLIq5XqwCZWg1bnI4TEJokXDMGivYNEgI/
	Cawuj8uSAdaGGhVh92e6c3WZe1a8URO41fJXpNcKtsEdQ=
X-Google-Smtp-Source: AGHT+IF2HAyYtoY7tqjtENmVwo8nugPI2UtLxqpWE0EI0lLCgNJiG2I5oXemQ3pGAy09KPpQQnNXJw==
X-Received: by 2002:a05:6e02:12e1:b0:430:ca90:d0b with SMTP id e9e14a558f8ab-4320f7a8964mr1116135ab.26.1761571817075;
        Mon, 27 Oct 2025 06:30:17 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:16 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/9] dt-bindings: spi: fsl-qspi: add optional resets
Date: Mon, 27 Oct 2025 08:30:00 -0500
Message-ID: <20251027133008.360237-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow two resets to be defined to support the SpacemiT K1 SoC QSPI IP.
Move the allOf block down, below the required section.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v4: - Moved the allOf block below the required section
    - Added Frank Li's Reviewed-by

 .../bindings/spi/fsl,spi-fsl-qspi.yaml        | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index 5e6aff1bc2ed3..1d10cfbad86c7 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -9,9 +9,6 @@ title: Freescale Quad Serial Peripheral Interface (QuadSPI)
 maintainers:
   - Han Xu <han.xu@nxp.com>
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -55,6 +52,11 @@ properties:
       - const: qspi_en
       - const: qspi
 
+  resets:
+    items:
+      - description: SoC QSPI reset
+      - description: SoC QSPI bus reset
+
 required:
   - compatible
   - reg
@@ -63,6 +65,18 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: spacemit,k1-qspi
+    then:
+      properties:
+        resets: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.48.1


