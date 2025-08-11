Return-Path: <linux-kernel+bounces-762036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB98B20167
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB06D189DF2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C9B2DA750;
	Mon, 11 Aug 2025 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9Q3Z0sa"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81644213248;
	Mon, 11 Aug 2025 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899790; cv=none; b=sTUpy9f1PKFfoLs/vRAGW1TRDnGLEAXF+HTiwng9GqI1i7so35Y2JG8KbCQtq6qyRlZ7gvfuV433gBORFldD48wUaHSfd2oCJy+U5GE2mqOlNywUwXDVIhUSQ4SGrlwFoMPTnOqEBUDOdHQ15jqDezS7ZxMjGHc83nqI1CckRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899790; c=relaxed/simple;
	bh=+QqWlm3rGso0+UcYO+hK1E17JCywz2jnf3gkiTG9H90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugY+2ZcAUMnQ30EaXqseCOVJYpfl14X7iGgdx0xF06gFqYwh2mlweb+TQjD2x9Jicfq4TasOMHQ59nXFQc1Iss9iaDVGhDEJryLMFJuPFdI2G2ae6k9WJkhUWE2BQyXi4AYFvkF1bNK4SLLI3MpzzJVSu4aUTJjDjviW71jwh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9Q3Z0sa; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af934d7c932so533894766b.3;
        Mon, 11 Aug 2025 01:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899786; x=1755504586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9iM/fW0ELKckN8krdlmQElBPjiaAbgPOkucLoHAJxQ=;
        b=Z9Q3Z0saInoxtl5uwrg3C/iaxwpI9fC3woWPAJt0WGBBAuYG9TZ36O40h0Fa1uGQ6c
         s5ACR08jBmRCPU03wEZMj5loF2blSHlpeMZtvVu5Ubcd9vQ1XF8y9RFO81cACwT63c7H
         eJ+0z5LhNQuuTfEwpd0Ln1RKYd/GqG1PQvUxX84HhUlCRNRgDGwrnbB1eEiGeO3ixbjL
         TmjnlfXKmtNiTi5dtUtKP9qOW21fzWNJ5BN4eZ1AOvC53G6sL3NOP5IeK6nynFc3bhYs
         nO/s8evu1mItZrzmJ4hefA8wgaTbr3DuX4iH8zyFcZ6jEKOvKxDdnS55EC8a70wBGwR9
         T8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899786; x=1755504586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9iM/fW0ELKckN8krdlmQElBPjiaAbgPOkucLoHAJxQ=;
        b=Jgj0JMYkq/BuOVFTdruil4EG+lk18l2SF+HBdld2084KnVmK+a8cl5txVdxb3aXdYD
         jwbmhyrxoTf5BXUKcuCo/PwMJJQCfDy49imZA5TrNjG2K8KGwooocwtcUNEVAtgdCM4i
         iIWRjRm5mK1QpjisxqNXPVww7uoAgEpFgKHE/shzinRmcWq8uk+EXvOR3Zdrlp53xvEi
         3zYViTufqp4wYWj1QXUb+0YCeDMPZw06bm4yLEx05JHbb4IL5xOe67fNcpE1UwCyTk8N
         iYQNTZTA8mcUbRT4qyfxfTvxG/tz8ElKD5VjTQBeCSRzf+LnSgap4s8otmyOC8VOjTVg
         iLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBvW8w2veFh5uhiQvR3AIeGPelenDU2+mDV3RdwUYme0eDwTyWdhHcG9hmccd9hMT0BWk9frMpYioobWY=@vger.kernel.org, AJvYcCXbmjEaYTzDh8lu/iR5l4FX6APbMX48yDQZFfxnI9OMf9VpEB3ruxsRWmLlEILFaPOaPqpvw0fIIemWJ4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3tjHvutls/ukaCQU8QEh9sUTSbn86a6AoJVIT3Vu2tyqdNGH
	xutBhTmz4cfm3rsTQUVQnX79IkF8kIT7q6vXubzJrVZPRCyLh8jXt8cJ+ZEXMiY0Hz7tVg==
X-Gm-Gg: ASbGncvmNRlFZaIs+WfI9bQgzEn4/uxl7bZ9mYhMasCILbODU8cx8Jr/eYSPqHBB4B1
	ieAB5BmySRr8ZH6VzeQoW/k37VFHWpFcNogdi/BgY6jInBdGp05orUHWDKYUtEUg5u58kukGXGu
	RuGVWyiFAbnb2783EHS10LESXOsGfPUC+9tE/pjiD7olkRY0p+m1UB6vj3FiTZEAaOdOKQ+b0eq
	uVQ6B0V9YFIFofhVUvohpb3hgM4/EvkZIEj4aHpl58mId5zTyoiZPtWJRkdOfxZn6/k3JHG3cew
	eej52jH+gzangZuyzvAjM1le8L6iFvgvj8tPGBbYza1pXrgPa7kbsUGqGdFCEvaKxYBy8TbIeb+
	FQuzfVwL5URwT
X-Google-Smtp-Source: AGHT+IHSPVn2yeCaJ2nP6CO51hxzeHYSAJ6z9hDqawrZtnAR+5n8p3tGaeJ5Ydui1h6Wg/6+6VWsdQ==
X-Received: by 2002:a17:907:da17:b0:af9:5766:d1e2 with SMTP id a640c23a62f3a-af9c6506cc4mr1094370566b.47.1754899786154;
        Mon, 11 Aug 2025 01:09:46 -0700 (PDT)
Received: from mmk-tp ([139.179.215.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fec4sm1981775966b.121.2025.08.11.01.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:09:45 -0700 (PDT)
From: Mahdi Khosravi <mmk1776@gmail.com>
To: devicetree@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahdi Khosravi <mmk1776@gmail.com>
Subject: [PATCH v5] ASoC: dt-bindings: realtek,alc5623: convert to DT schema
Date: Mon, 11 Aug 2025 11:09:40 +0300
Message-ID: <20250811080940.7909-1-mmk1776@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert alc5623 audio codec binding to DT schema.

Also add "realtek,alc5621" to the compatible list for
existing use in kirkwood-t5325.dts.

Signed-off-by: Mahdi Khosravi <mmk1776@gmail.com>
---
Changes in v5:
- Add "realtek,alc5621" with explanation in commit message
- Update title to remove alc5622
- Drop "realtek,alc5622" as it is not used

Changes in v4:
- Add "realtek,alc5621" and "realtek,alc5622" to compatible list

Changes in v3:
- Drop allOf, just use $ref for uint32
- Remove stray '>' in descriptions
- Fix subject to "to DT schema"

Changes in v2:
- Add dai-common ref
- Switch add-ctrl/jack-det-ctrl to allOf uint32
- Use unevaluatedProperties
- Fix example compatible
---
 .../devicetree/bindings/sound/alc5623.txt     | 25 ---------
 .../bindings/sound/realtek,alc5623.yaml       | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,alc5623.yaml

diff --git a/Documentation/devicetree/bindings/sound/alc5623.txt b/Documentation/devicetree/bindings/sound/alc5623.txt
deleted file mode 100644
index 26c86c98d671..000000000000
--- a/Documentation/devicetree/bindings/sound/alc5623.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-ALC5621/ALC5622/ALC5623 audio Codec
-
-Required properties:
-
- - compatible:	"realtek,alc5623"
- - reg:		the I2C address of the device.
-
-Optional properties:
-
- - add-ctrl:	  Default register value for Reg-40h, Additional Control
-		  Register. If absent or has the value of 0, the
-		  register is untouched.
-
- - jack-det-ctrl: Default register value for Reg-5Ah, Jack Detect
-		  Control Register. If absent or has value 0, the
-		  register is untouched.
-
-Example:
-
-	alc5621: alc5621@1a {
-		compatible = "alc5621";
-		reg = <0x1a>;
-		add-ctrl = <0x3700>;
-		jack-det-ctrl = <0x4810>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
new file mode 100644
index 000000000000..683c58c3ef50
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,alc5623.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ALC5621/ALC5623 Audio Codec
+
+maintainers:
+  - Mahdi Khosravi <mmk1776@gmail.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - realtek,alc5621
+      - realtek,alc5623
+
+  reg:
+    maxItems: 1
+
+  add-ctrl:
+    description:
+      Default register value for Reg-40h, Additional Control Register.
+      If absent or zero, the register is left untouched.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  jack-det-ctrl:
+    description:
+      Default register value for Reg-5Ah, Jack Detect Control Register.
+      If absent or zero, the register is left untouched.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1a {
+            compatible = "realtek,alc5623";
+            reg = <0x1a>;
+            add-ctrl = <0x3700>;
+            jack-det-ctrl = <0x4810>;
+        };
+    };
-- 
2.50.1


