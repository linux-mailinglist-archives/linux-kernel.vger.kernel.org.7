Return-Path: <linux-kernel+bounces-849356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7869BCFEA7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 04:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6AFB3ADF27
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 02:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD9F1D90C8;
	Sun, 12 Oct 2025 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQJ/v6Ya"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9111A2392
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760235980; cv=none; b=F5RuXnqQddnt2/bf9KMvMb2RQybj+e73uRvHJK7BmSTs1MgHfwtgASxEy/N5mUquAmsTOOg3vrzx6bHpG76b9cNglk8aaumEo3Odu8x50EpIAyaYMMKtvBT9K2dBIGHpgFDNKCzOpj6fEOiYbt7/uoA5ud+6tMkbzgvVEaogjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760235980; c=relaxed/simple;
	bh=Eqt79fSlOJq/HqDwqQJC4lZ1h3nSfxXHoYjtimE2BTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6Rksy49rHfg0328teXCDHhfesfwxZ6WkFt/qoaV+0ju4t8GF3UqX/64mEiJD2ynA/Tv27xvAm55RkkEHPUQKUifKCx7vyrlPoOC4H2Uj2BHwwWO3l4pi56DaKscUAaxR8/NqRL4JxXO6jzJjylZyxdNzoze3fIfQRyPy0Q34LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQJ/v6Ya; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781010ff051so2243348b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 19:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760235978; x=1760840778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYj9BHj7cwVf87n8ZMWQnat/cLLuDjVQjaIpUr5Z/nc=;
        b=YQJ/v6YajXGk6UkeTA9z1P7NMS54SMnCDvMb43povPCX/2SoHwxyzvWjBsDLWgtQm0
         Mt8gDw354JPfTRk7k/R5D3rIXLL8dXrReOQBz6xgwsIDHHRvx/g3Pe91C/NZuWNwOMtT
         5uf/1XDQQTT3kEGfb86UlCfVaV0khFpyf/XfWqCqU7GuCtNsCe0vhTgfE0aMRRqv5ZrP
         sVAIEJDwMrS/HnoTpUFIukaXvinA1bXngZEsBVLoNL6w1Ybu/0g28npcdmOlaUwhW7zs
         UH/TvfgSvi2C8Lfb1NxLw/Y+YfKbZilXmA5p4krgLErYkIZ84vSQckH71SJyohuQBtgD
         a+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760235978; x=1760840778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYj9BHj7cwVf87n8ZMWQnat/cLLuDjVQjaIpUr5Z/nc=;
        b=dndXGexp2da3FoITBOy03vjS4jlDXFpcuVeBfZTLQZIOAi6VSowX3O5qvDBBjcujxR
         Ho/E1Fg9DPdtPQAKINk44gtkUAVwceRFgPGfhIN37u65F4SMLblGceeF/vv7OUBmnCw6
         dtWJe/BazOdued/sMQWcC/APX18eual9yyvbdGoDcdo2Ex6Ohi3JMSANouEi4xwE9l+t
         LHPGBvZxlPYeMa4Qy/0GOD4V2i8qA33zpVzlI/ib3OMJTmeBIBpBuH+EV/CRUPDJXNKs
         AaoRXSUEKOWkVJ7+T4vhq83bZ0ThygTfasTv6j5SDzZ5Dh641ahYL21bx+YWf340PQBU
         n4ug==
X-Forwarded-Encrypted: i=1; AJvYcCXBTEKf+6thewRvPm9ZGm1DS66i4vGOIWAdChwIoVmoA4EMPovIa7UR1r3lATo7W1hcMuZArZW1ts2eCxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJwndTngPLeRayo4iOGRogIZQhoHG1vrV+VkVlG/Y4Jar8Z83
	E1KYbNWZTh5c+TLu0+fRmlijTK7P6N87paLtTHoaBTcMmUoJDrseKCGu
X-Gm-Gg: ASbGnctjlhOCB5VPWdimzhKyn7cZ+xQDmR12fwB7kvMz2m9iVKx+gF5bltxE+0/C5VW
	4tItxRdHpLGYnbAeQFTB39yOSsYXsg3HIAaT7jg8UXHeqVMtliK56bDF804xAwVuvOJYNqJ1/y2
	K7G9d+T9hpVfHDe24Jk3ueKTIEu0wsnGtG1O3AuMm+Bx7MgPA9PH8ve0UkAcD7ZgzL023Ip/Zco
	E3q7V2bkLyiyX9ISu/Q195BAvWJmE0jVU/voXpyHppXlcixnX+I9jSy+j47NeHQig0XG8ETyDF8
	4BfNnNyM1eXQza5yhZNgLbjNZc4/CZUEVgijK/j3dg4/xG+rIsP43VxlQqTZV6vpv7nyh646Hfg
	75FmevuBb2YdEqf5CgPMBwgaRu+bWLVpeQg+fap+EJQTbKLzqHI1y17+W8lVrDkMBikB/
X-Google-Smtp-Source: AGHT+IHkPmQUQfunFHahd09uFFipzQG8nUYJ4jLN6bvERJ5STyPU28/LTOdCiOsyRzsvL6DNxvTF7A==
X-Received: by 2002:a05:6a00:1394:b0:792:574d:b1d with SMTP id d2e1a72fcca58-79385703ba7mr22526012b3a.14.1760235978345;
        Sat, 11 Oct 2025 19:26:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d9992ddsm7180489b3a.80.2025.10.11.19.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 19:26:17 -0700 (PDT)
From: Longbin Li <looong.bin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Longbin Li <looong.bin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v1 1/3] dt-bindings: soc: sophgo: add TOP syscon for CV18XX/SG200X series SoC
Date: Sun, 12 Oct 2025 10:25:52 +0800
Message-ID: <20251012022555.6240-2-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012022555.6240-1-looong.bin@gmail.com>
References: <20251012022555.6240-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sophgo CV1800/SG2000 SoC top misc system controller provides register
access to configure related modules. It includes a usb2 phy and a dma
multiplexer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 .../soc/sophgo/sophgo,cv1800b-top-syscon.yaml | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
new file mode 100644
index 000000000000..d1993f2156b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800b-top-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV18XX/SG200X SoC top system controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description:
+  The Sophgo CV18XX/SG200X SoC top misc system controller provides
+  register access to configure related modules.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: sophgo,cv1800b-top-syscon
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  "dma-router@154":
+    $ref: /schemas/dma/sophgo,cv1800b-dmamux.yaml#
+    unevaluatedProperties: false
+
+  "phy@48":
+    $ref: /schemas/phy/sophgo,cv1800b-usb2-phy.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@3000000 {
+      compatible = "sophgo,cv1800b-top-syscon", "syscon", "simple-mfd";
+      reg = <0x03000000 0x1000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+    };
+
+...
--
2.51.0

