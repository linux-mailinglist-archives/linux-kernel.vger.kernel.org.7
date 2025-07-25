Return-Path: <linux-kernel+bounces-745564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB635B11BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C734D1CE2DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D582E2F05;
	Fri, 25 Jul 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tbxW4u/r"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F532DFF13;
	Fri, 25 Jul 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438042; cv=none; b=ZBXWb8buRuLbJYrfgrptG6HMo9OUzikcoDblj9CqtLNHXFydSSqZtrrRcNBDYk19E+vLwwNuBwp4sWejpuWdMe72WwYpf40Qs2rMr3oQrGrBUi3DQKF9sI9Dituk/LJuZ0O77w9OuVNXfWeJgBpktFZC/3DtWPYQo8tsFuejzIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438042; c=relaxed/simple;
	bh=R2l6+W5QwfXmzUvuIVHbVP9W3Ss6liO/aeyfle0u7PE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gkagyogxlJsiCAdTuJ45+rPAeaiPdHN8xhXarYCF/iWlbRNlrFHEUJOqnLqKFK3Hmx2GU646nhaHdfIqmDtCTU7HPcU/lobr+K2Mt97Fii3QA9Du9E6oZcIrGNDZzqQY+OgYNOqrzMY5Z7PiUhDiMwpjUdFketGnsXhyG/NdV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tbxW4u/r; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9eWnr023360;
	Fri, 25 Jul 2025 12:06:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	YMZCUSvts68iCk1RBUo7wm42UGnUcBwInw/trKgvtPs=; b=tbxW4u/r3d3CG3yV
	9+ZoZQbdbq9V4RiwjGPfVQInz6CtuVUkBOuA3e+ihzsAph0/BODhjgblJNrEV84q
	ubyh14eTAYRs+C5dTdpS7NjzLk5dy0Om44tgGVj7UBOJg0c737O7V+6hCds+xeio
	7PHOUQEn/cXq3aJx+DfNhiM5Ep9WxThek5gPOMk8jg6mtnvP2SUbv99lSQLatFV7
	4irAiA1x4iFpmrgl80fk9T57ZN/gSrKXbCH2lE158K96tFT6LNuncJrkWhoX5UbA
	wGcmBmU2ia+GtVn0iKdlYQ/Nrr9ZSBsTWLIklTzEyZpUH2lQcM0+wYRsmdviH5pR
	D/YkkA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 483w3ethj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 12:06:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A175D40053;
	Fri, 25 Jul 2025 12:05:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CE4B97A19C5;
	Fri, 25 Jul 2025 12:04:30 +0200 (CEST)
Received: from localhost (10.252.19.90) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 12:04:30 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Fri, 25 Jul 2025 12:03:57 +0200
Subject: [PATCH 05/12] dt-bindings: arm: stm32: add required #clock-cells
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250725-drm-misc-next-v1-5-a59848e62cf9@foss.st.com>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
In-Reply-To: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01

On STM32MP25 SoC, the syscfg peripheral provides a clock to the display
subsystem through a multiplexer.  Since it only provides a single clock,
the cell value is 0.

Doing so allows the clock consumers to reach the peripheral and gate the
clock accordingly.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 .../bindings/arm/stm32/st,stm32-syscon.yaml        | 31 +++++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
index ed97652c84922813e94b1818c07fe8714891c089..95d2319afe235fa86974d80f89c9deeae2275232 100644
--- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
@@ -36,20 +36,31 @@ properties:
   clocks:
     maxItems: 1
 
+  "#clock-cells":
+    const: 0
+
 required:
   - compatible
   - reg
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - st,stm32mp157-syscfg
-          - st,stm32f4-gcan
-then:
-  required:
-    - clocks
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp157-syscfg
+              - st,stm32f4-gcan
+    then:
+      required:
+        - clocks
+  - if:
+      properties:
+        compatible:
+          const: st,stm32mp25-syscfg
+    then:
+      required:
+        - "#clock-cells"
 
 additionalProperties: false
 

-- 
2.25.1


