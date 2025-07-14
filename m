Return-Path: <linux-kernel+bounces-730334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32978B0433B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA434E0C43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A7225A63D;
	Mon, 14 Jul 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S706DXF2"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2EC25B2FA;
	Mon, 14 Jul 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506062; cv=none; b=bveNyaDOIV/GYcDj/jc39rU+OMgHJkz1jvwKQOA2uG4FKA8NH10VIwhjupsw9Nhf3VPX9KKJ5eH+tHr3ICdIzUkqdCiYd9UXnewad8cel+AXdjEUzVyg7pI6x+zDxOLhSkuMblY6QijuMKD3rQLAiNHYEXHyJmxlZJAbL0h9EmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506062; c=relaxed/simple;
	bh=hWL/Py0JsAvPKRmAoBxnLvY1qSJ/ecSTBwIFllvm5IE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IBD+VV46yBD/RO1zHbVqY3/zz7ODXW11Xvhb/tQW6L6TR6Wa/vrAm7XLlQ4fy6prqChpXovEx+JT2CQOHwciEje4aEXeEkn3bAnWVtgRHXKKBHTDFIbjZwtyzIkhkgLKezC5vsKDTmUG6MVCHObvv+1RrkDnJQoEWIbwL1weChc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S706DXF2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-454ac069223so27676725e9.1;
        Mon, 14 Jul 2025 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752506059; x=1753110859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YqjEqn5P40o8JrfMBkaW819hcdIhWbq17UYYqxjCfpg=;
        b=S706DXF2T4s0gtYbWnky0uS58XNP5rJoUQOn7QtByb8DJN+RhRZYbI496tHJMG0PGR
         afI4G96XD0ztWnJZk/KhwL5WoSfR8oF7EONkKL61Ykr85FLo3r77QFnAl/70YjbyPFJh
         zw/f+wZL4Z1HWvdjm89pxswU/UT9DMdvOEcfzIJpgozRTSyRKTfd94B6qN2yw7dD/ljA
         /2AQ24jcXUZ2nHUk7c0culZIatXu46d7z8VwTVU7+qG54uE0B016jqt1DSuIBFoWTe4a
         Q2855cY8wrIz/dZcCaW8gOch13NszMV4RYYXV9iEL+pwMSYV3HB6AZxd10HZlOsH7wU/
         fx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506059; x=1753110859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqjEqn5P40o8JrfMBkaW819hcdIhWbq17UYYqxjCfpg=;
        b=nT4TExdHtvlsbZd7ZKOftm5YGwQrzvfGIxN3xDxeFZeAdUOVG5lzCyqb1MjqCPAx41
         omKLwLehHADa2utfS6ZzOsq4V1y32Snfqi/Z5nRBrmm2ovgN9vfjJooLMHM9cScX6tNG
         RypyzKRmFktiEGkBuJliTaJyK00XRmq7Pp+4YpBTzZerJ/5GCZpDT7xMeL0E/ejs343d
         eX8zD6jAM4DYZb/bKm7t+QqGO7myzvcguaZbjJy9FmsMb/nO9idMB/CwA6pm3Lo+QucF
         26HCAN7qi/Cae63oWUzIeBayACf25OzhKPVbTctQGveY994Xu9+Mfc9gQXoUiL6EdLXb
         ZthQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKmkayOOyzFKXXUaEOcd+Iy7GyZAdIUQ/75SGvBQJyAVkuNj3cT0qNZxxm7k8el2SeoIVrySclx6KHi5hb@vger.kernel.org, AJvYcCWNPPmhcyN7u5d1FReN93qWUCrtJG4jPCQEWV76xZ5l0bSJujRtml8WJEIrvDy21FgV/0ha3W2FpVE2@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlQEkw64MUAGX3TGyvVkElvo5HexW+pTuV8RosdT8f5Gr/7SA
	HSmDXWnGU8l3073wrYNWWlN7k10z1RGlFcf8Wxydmih4Sa3tTG0TD2mv
X-Gm-Gg: ASbGncsc0NCb+mGLAy/tLhqHoDZTJFtHbh56XHJqrEmoyDasHBfYnvJK/Aqn4/K/jku
	aEpr+PQu2FUnxRv3oh1JgmzN+b55JZXlPq5hmTDXvT/mNIctBSdy2Y/OmnrM0ST8XR6LwG+4sfO
	2iwFkQaDfTcKTZFjX/7H0BtLyGMN/YtAwaG0pa6TUKrez4dTPbHtfhUTj8V9QaMtqY672ZAQDZA
	SVMD0Sj0PxyonsnPO6DIO5UwR9Fz3u1y1MZ6BLXD3dp26SANZV8cSxZUtzBrzmHAwBXwIBU+CWc
	fE4dWFE+KvyTTzw7cyH/BWIiPFnznUsNRrdopQT5mxfwwnQA0mLFNwzC9s6/zebqCWmoOg06rJt
	9XVrq4AY6Q7C31DkYYgK5/7LQKoOeK97ypuLAZtRWv76UYGofHZhxul7FhBkMja3mW7hK5/PJ3B
	oIrR4eHAAXIg0v
X-Google-Smtp-Source: AGHT+IF9FUH35fas71QAMNTOPsJNATr+0G2h9SVHWRssQMQ4HhB66Kh3gmpvdbRNHPO48pSJjIcV+A==
X-Received: by 2002:a05:6000:3c3:b0:3a4:f70e:bc25 with SMTP id ffacd0b85a97d-3b5f1e96113mr9060552f8f.27.1752506059124;
        Mon, 14 Jul 2025 08:14:19 -0700 (PDT)
Received: from localhost.localdomain (host-212-171-170-230.retail.telecomitalia.it. [212.171.170.230])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26f3asm12872427f8f.98.2025.07.14.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:14:18 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: nvmem: airoha: add SMC eFuses schema
Date: Mon, 14 Jul 2025 17:13:46 +0200
Message-ID: <20250714151349.28368-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
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
---
 .../bindings/nvmem/airoha,smc-efuses.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml b/Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml
new file mode 100644
index 000000000000..399c3c14f6ea
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
+        description: Identify the eFuse bank. (0 or 1)
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
+    airoha-efuses {
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
2.48.1


