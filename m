Return-Path: <linux-kernel+bounces-890745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC07C40D05
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBD0535072A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD593358C5;
	Fri,  7 Nov 2025 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVHx0Jj/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D332D7D3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532019; cv=none; b=U/vp5fnebHN2+wtyrngTO3auOjRaUzt5SzYegVa15vFJxx8MX+NEZIQFoRrLSEEXFkXtRpiCbyBGytLG70KlgEd54UzUtZPTXgzb0FHwaGRw9GVsQf3u3mFQjiaX/1zsMMKCAx4seVwU4YWJOuS9T2yEbO7MH7U9ecczKSf/sXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532019; c=relaxed/simple;
	bh=xF31XLgsg71i4GGxvf84aYmQNof3dwV5B7dwqDvBkGs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm3xfVVQRUhA+Mu4s80h0JdpL/1GkJvytLFibowqksov0v96796XBQOvT753vVXvV6Ri90UVa/DrS10OW4p6TYI1UxZE1miPABAnC8P/dTpvg8xLCqWicRMz/Knd1Bcges9mv0935lMRI20IsDsTcg8Dx5Pasj2sbj2EMuj285k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVHx0Jj/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710022571cso9442855e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762532016; x=1763136816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uXFJLRO/6xfTI8EDTIMKnyNwnwfpmuqxZVfQHRB7zA=;
        b=bVHx0Jj/aVKT72wWxawiOPPICz/q9HhFi/awet6rKIDEdFqWNNWVqxBXLyIrWuTh+l
         0nAjVyZVHQPZ2COAKClcFmwMge6dK+8X2HSIRLR3fwq3JmRPi8+it5EdlXZosX0Ivd14
         l3Oa3dS8NwiGSEHkRUyFxWB/ZzuX9GfQy61DlHbbXw6hCk+zd4vDv9BUwkPtiHdUTU/Z
         SyrZ10E+MsDz6Hw4Wnt3fgyxKHf7MvF7nvfuIK8cTIfFpfu4rIaRVZnImI5UKldXDg3t
         BDMSWpNRzriKot94kLUvAc9DmxptqkAyy//Gke3t4+KH/QLfe1MaS4Jv3hEk4bWbyQba
         kMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532016; x=1763136816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4uXFJLRO/6xfTI8EDTIMKnyNwnwfpmuqxZVfQHRB7zA=;
        b=uLLi+Or6wBGCpx+6cFrE/3fyluOTtwJemDp7kr1+yjpe4TPOn/argEmucPiQZzbYy3
         GeuK3HU+4VHYH6ZBJN/pM6JJnB2VeQR/1cpusqF35ZYrBnLm3NYE4m4VHF3JL4eD0k0y
         wcqQd7wawOVuuXqR25lbcV5pnsUmp/gffaVY9+5zFh8RubRvr0KTjergQovLXlF/ZRQy
         +W6zjRc/efiIVt9xoUP0futL6Ry8d5oLdHjfDWhvFpFyg9V24TIfkCu309UjqKvV+Yqc
         3IcomOlJjv2iP1ORlu8Lud9IOT+Qp5aN46DTsguVH77GsUOw9e+EmO6t96qtiC9aIul1
         mNaw==
X-Forwarded-Encrypted: i=1; AJvYcCXiPsDpja8/Muw1i08p5EtReFkXMKgRB4Q6k9XeybwCKRqZiWoTHaNXOZbDs1wON5vz842eEYMn+r4kP9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfInLoNqjlvUC/uxQT9qbCNc+Ja+uv6+kF+ipSxPh1icBQBq67
	twp8sjya89rn5uVD82RbJQStmqNdIuLNhKWQFjRG7YYQ+4mSmayP5D/E
X-Gm-Gg: ASbGncuHpjSlxCxlSHGGULxuVuHa/5+rsDOoY4L/MOA/RTr2AvjGlZn2ifm5kmdI8SF
	uk6SX+Q1/FCBpIrPzaXM5G8DkMsmY7t+wq/FIUSYSBT8ewisnq2+U7TVF1ILEpYmYe5UGNHDbeb
	6GzpqSUb7fM6WaHmCZeDFqmS15IjdvXqcSDGEe7KiCBXTr75PDdtpCkZ8qI/HWYboF32Ew9ao7n
	eONwLCjP8CU8QSUwfDTZoEhYhib+dFXfpMatRKkOOmBkr+xGlZAiEvmUrrJavt38c44Rx2ig0VB
	0pggasGSx7dwoJ6HqYre4zFHASDVcpbexw4IPnQ6gRTvIj7EMum5HXXonVeaY4ZhK8VbNbn188j
	pZSRsJ+2jmfPR07cg2Mx+pIYB/uZRBtoJlF5odwJQT/fBSOvxZivboFp70ACXFy9v+ksC+ciMcu
	9Lvhsi3bChRjUqYM7bMCuP29ANMMQUUg==
X-Google-Smtp-Source: AGHT+IFawPAtIcw8BLF2+oxvmm5q0IcgtK7Mrxbx5kWdFRcrimIuVIqUr5MJ29xpOz+U8b2csbXeEA==
X-Received: by 2002:a05:600c:1e8a:b0:477:e66:406e with SMTP id 5b1f17b1804b1-4776bcc376emr32637375e9.29.1762532015818;
        Fri, 07 Nov 2025 08:13:35 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4776bd087b1sm66665955e9.16.2025.11.07.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:13:35 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: nvmem: airoha: add SMC eFuses schema
Date: Fri,  7 Nov 2025 17:13:21 +0100
Message-ID: <20251107161325.2309275-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107161325.2309275-1-ansuelsmth@gmail.com>
References: <20251107161325.2309275-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha SMC eFuses schema to document new Airoha SoC AN7581/AN7583
way of accessing the 2 eFuse bank via the SMC command.

Each eFuse bank expose 64 eFuse cells of 32 bit used to give information
on HW Revision, PHY Calibration,  Device Model, Private Key and
all kind of other info specific to the SoC or the running system.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/nvmem/airoha,smc-efuses.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml b/Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml
new file mode 100644
index 000000000000..e21ce07c4f41
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/airoha,smc-efuses.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha SMC eFuses
+
+description: |
+  Airoha new SoC (AN7581/AN7583) expose banks of eFuse accessible
+  via specific SMC commands.
+
+  2 different bank of eFuse or 64 cells of 32 bit are exposed
+  read-only used to give information on HW Revision, PHY Calibration,
+  Device Model, Private Key...
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - airoha,an7581-efuses
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  '^efuse-bank@[0-1]$':
+    type: object
+
+    allOf:
+      - $ref: nvmem.yaml#
+
+    properties:
+      reg:
+        description: Identify the eFuse bank.
+        enum: [0, 1]
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    efuse {
+        compatible = "airoha,an7581-efuses";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        efuse-bank@0 {
+           reg = <0>;
+        };
+    };
+
+...
-- 
2.51.0


