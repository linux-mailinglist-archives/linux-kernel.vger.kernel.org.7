Return-Path: <linux-kernel+bounces-760233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17065B1E848
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFC83B17F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044D277CA0;
	Fri,  8 Aug 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="e45pRocT"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1827780E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656037; cv=none; b=fHIr+HprOm2KWDYu+i/HzhP+VDvnNfx1qrlEAMe35kK04bhNxKehB9x57+2f51aVfC2jgQAVrILImN+SVlbV1uSdZvgEmLhvl3rDuTOnWCZNVHvlCpqI09QzrD8GrEeKmPl+22Cb6hUnu5hzRCRghsYmdfkknU/9IHQ4e1hPpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656037; c=relaxed/simple;
	bh=55xyNih1p/jm8DNDiay6Vgkq0BIb6mLAUammufSbVHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWt+PpbSeq+8mpWTLrki4ouivp13a/sQNKAcliYcilD+/IHtWb+QU3ZCJEuPDHNNJckBf9UBPu1gT4DiX4ninctQ4yGjiXRKObebfOOSK6dNLlygNVg9TUf+cxQkfKCUx5CX3SYk6/WMWP54HyI4gOD2mlDOgbLrbhaEDaG+FGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=e45pRocT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bfabdbef5so1983699b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1754656035; x=1755260835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJ2tefdglAjtygFqd1QbWGrd125necdYQVliSr1KcFQ=;
        b=e45pRocTY9m9eLsaL2CzWhlxb54ZJgypNjtaTVWli/TXBbNaWQJCsGCRIWe2geCk1C
         h6Y8CoGStq6eq995nkWyZztlkX+RueFYXAlYf35pF6uTjE7420gltpMREDcsH/cBvG7d
         PzmOTvLb3y7zGORu1Sfk3m/GpzhHDcNWgIqYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656035; x=1755260835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJ2tefdglAjtygFqd1QbWGrd125necdYQVliSr1KcFQ=;
        b=p3eb4+Iyj6GynD2JFmweCL6h9mStep8Mfx3XFIbBQnoltmrw70Z11ES60NDUm3tuHU
         kt773T9rtTyoHe4i3jgPJ8snYqbOnFkzW39KTUDxyiD9A/QpjLLbemfLRVEo1A2nYRdm
         p1Va37ji5dUg50RAUY8KyRzQuzzu8u4gVGLJhufZE6gYZ7SfRg4/zd7pyM8diVG7ui+D
         nUQjZw9Z8jKFjngiq9XkLPT8zHCfeab1rtcTRFir4DjFiybxHcodwB3cpDYp85q4XUVn
         J1MvDx9T/yQp5w9jt4VClfm7VlyHstMxMPAuJS3JNfmabh24gTHjA/uB/0Ha1Vy+P77C
         X34g==
X-Forwarded-Encrypted: i=1; AJvYcCWczgeltKviZVNgtIDLW2GbXt0BpMyM7NjmLCjXImmBGJzUloKVu/OE1ZaVdqFJNq6Qe8V6UvT+z6vX6cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlh+tL/DmWGFjJ2KgLhI43WZ095k5pEvZqrkR3t1QEe9insJ2Z
	lOJRDbFadmXkHrK5kSagflPdbJxrLVQTnBalxN9QMRD05XrjML3Sg0TCTanRD5EWM7g=
X-Gm-Gg: ASbGncsww61l3T1om5y+XHVMVZ54nkPDuWqYj+TH4R8NWYoVs3aPzgAT2mKSKj3l/bG
	cqOb6Kk4vV4axqP1kT8d2EmTPz/+Z6QtW8ek0Sjk36kmSm8Fw1G3zHOMOVDleiPZaxutdvgtIql
	K+0t6LuIiYwuxIitF60bAiiblU+dW0yCJORWjHh7beujJFcBWJ8E7sZU+gYEpk8x1Dle25eGF+W
	I7SYo0Gtu/1vmMa/wTfkvQyrbhgBhFt3d3DHPqh3uHOC5FmnAYsCYFKJDRP4K/ztGITE5bD56X9
	ul1Nu4KgrfWIEvLdzzA79J0p+oYunq7uyu6PH0RLTQF4Ij3B/kiiy/4JDkfPhKM6gmcVaubWaX6
	60+7vFsOUTXTMoVGS0vy5C/XqFO8zdIzuwck3hlI2McUM+w==
X-Google-Smtp-Source: AGHT+IERx8aVenHBuTli8JAbJCc9oxtQxg7z2FMu+cbVVrScQ3tjY/TvMSb6NyxPz69iUhJCLa6iiQ==
X-Received: by 2002:a17:902:f688:b0:240:7235:6292 with SMTP id d9443c01a7336-242c224cca8mr50641925ad.39.1754656034890;
        Fri, 08 Aug 2025 05:27:14 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a8cdsm208296665ad.121.2025.08.08.05.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 05:27:14 -0700 (PDT)
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
To: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	herbert@gondor.apana.org.au,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ruud.Derwig@synopsys.com,
	manjunath.hadli@vayavyalabs.com,
	adityak@vayavyalabs.com,
	Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>,
	Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Subject: [PATCH v4 1/6] dt-bindings: crypto: Document support for SPAcc
Date: Fri,  8 Aug 2025 17:56:26 +0530
Message-Id: <20250808122631.697421-2-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250808122631.697421-1-pavitrakumarm@vayavyalabs.com>
References: <20250808122631.697421-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings related to the SPAcc driver for Documentation.
DWC Synopsys Security Protocol Accelerator(SPAcc) Hardware Crypto
Engine is a crypto IP designed by Synopsys.

Co-developed-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Signed-off-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Acked-by: Ruud Derwig <Ruud.Derwig@synopsys.com>
Signed-off-by: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
---
 .../bindings/crypto/snps,dwc-spacc.yaml       | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml

diff --git a/Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml b/Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml
new file mode 100644
index 000000000000..1053deaea304
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/snps,dwc-spacc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Security Protocol Accelerator(SPAcc) Crypto Engine
+
+maintainers:
+  - Ruud Derwig <Ruud.Derwig@synopsys.com>
+
+description: |
+  The Synopsys DWC Security Protocol Accelerator (SPAcc), which is a
+  semiconductor IP designed to accelerate cryptographic operations, such as
+  encryption, decryption, and hashing.
+
+  In this configuration, the SPAcc IP is instantiated within the Synopsys
+  NSIMOSCI virtual SoC platform, a SystemC simulation environment used for
+  software development and testing. The device is accessed as a memory-mapped
+  peripheral and generates interrupts to the ARC interrupt controller.
+
+properties:
+  compatible:
+    items:
+      - const: snps,nsimosci-hs-spacc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    crypto@40000000 {
+        compatible = "snps,nsimosci-hs-spacc";
+        reg = <0x40000000 0x3ffff>;
+        interrupts = <28>;
+        clocks = <&clock>;
+    };
-- 
2.25.1


