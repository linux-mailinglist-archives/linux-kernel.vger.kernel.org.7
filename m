Return-Path: <linux-kernel+bounces-818650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA770B594A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9393AC33E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B612D061D;
	Tue, 16 Sep 2025 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS8CSB2E"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E626CE3A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020560; cv=none; b=HW3B/+V1YPGH1fhBry+CAIYI1Y3rMhl5mvgx+BxMnZoy/KkM1i03YJzp2PohVC6LyUq/Br3jH6o8fl2JznxtljfK0KTxtFXO5i/clBZMQnl7u5YosoRMzgp56/73Ef8GDdyKCR8x2VKV7n/j5NMtwzSuuj2HKNn99DOSaVSvydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020560; c=relaxed/simple;
	bh=y9jnqLmE0N2IfF6Kb1ZTaozI7fYb0EitahVJY1Lv5CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWvnII+YhBdQ2Pvr99zYVSmWYwz0NTroAC+nOEELyTM0wwq1QkCSwn3fKannvUCCuwmpSTyqneygjKVepROTrmV79cuqn2TJ+el6UqlfYCPif3xaTzyg+U7eX2ZMK2S4mmLwDxxPhkHsR1qU7RlcpV5rX/04ukg7s/qxcHfg5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS8CSB2E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26763bb9a92so16547275ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758020558; x=1758625358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnhnAohADwwgLMymLFupZmG/k4zaXDapUOznK23UZtA=;
        b=TS8CSB2EIikax9/hAOi/dx3Ta3VjgucC6rMWgdRSjS5gDUy3mJmVet77u8PhLeB+r5
         YJetb+7BcI37dPFn3issqmxZaPfEv2STwW1pSYotBggX0InhprTsSUkohT8tmNdYSDUK
         mR+E2IqdwI51A1aju6xUAgMNrQbokYbRdq0hi5QsvChBmjRq2U22SmkIf6GlBdIWLaQ3
         N2xwZUnzsNipod1YTXAW55bBNCREiZaq7dO2klG3YgxVszOrtiyH0updYW7QnYkNp+yb
         wq2zy5XeWYSRRoNfRi5yKY0FJCbmuBaLDoeJj54Ea9i8wv8yv3cHddNk2+tMSctBUQG/
         uLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020558; x=1758625358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnhnAohADwwgLMymLFupZmG/k4zaXDapUOznK23UZtA=;
        b=CrqKMACCq2SmslpRJOmVoIH4I95LgganGsXZYVflk6AekPRvEZhqxhPvWsadYn+aQd
         dc+oRfN2VtCtD+mAAIWwkajtXk8LRMrn8kLUgF29hlavesapT+vUuUnGWW1SXK7R1LGu
         Uo/KqowwroQ0Vce+H4bXsWQfF/MUIC4KFrRrvDIXkICsqbjwsk9bw/YgolKP1FP2EjKK
         WV5Wq2ASgmoV7o1Sr82UfkjsAWhNBsEPfbU2O62g9VcszbB/FO/R61mvpxcG5QYGR7SI
         0LHscjBVQ9gjUDfVv9aoBSmOB3yOFLCgub5kH3hHkctZHIBnmetxOVDgsEgCtYYfC/Sj
         ZSiw==
X-Forwarded-Encrypted: i=1; AJvYcCXS4gj11TBT6s+vwEQwVPTePTxzNVu6p0UebG0/PGK7kT0pzryiYoJVVvn1h9yVXQkQOSYxP37jz0VVKqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkzlkhLa0cSjAesiwN5ZDF/5JHzUxdQEIuRLFawGM81FyI+sLF
	u9JSGX07IHIAGoC8Veayd19JSqveIeNVyvqTwiW6QuCDXKqpc+7lxMNF
X-Gm-Gg: ASbGncuR35AroaOHWTyMkIKux8EBHHdcPxxO2VlAW/UVQ0shVN4D/cVPkIIfIuRtBOM
	PY2TBzNyQY6aiObGozLxpPIoAed0BQry1vb07hVJr7a9XrTLqzdOP5di+yBOlbgZwBg/xZxIib0
	59aDEX5Mb5NtDqNP8T5Dtj+JEVTujfbpTmJ3qRl/yRRNkP36eJH7wWnhxUpTrCE718GipDAOsZy
	96kqiJu9YQqsISnhbTCCK4UlQJhM5B5Alg8O90xjE6HjcWP19RhJ28tSz9ra1y9H1GBc0TfZYrI
	8g9+k63JWmvrupi5S99u2XxnuqIhMZPmwR744CUrpWIj6zcCRa0lA5TbmolLpukCQzoFNSTTyuC
	5Fm85a1I820b4QRezPwC1LddlNYuWZDm32UTQr3/LNfb9
X-Google-Smtp-Source: AGHT+IFx+My0FmYEI7yM3GGPS1Qs9nZQxJH6ip07Fyet0g7/yxeKatQnAkiffmCmgeNC9lyoW5P2eQ==
X-Received: by 2002:a17:902:d58a:b0:264:c48:9cae with SMTP id d9443c01a7336-2640c489f42mr124067255ad.38.1758020558299;
        Tue, 16 Sep 2025 04:02:38 -0700 (PDT)
Received: from MRSPARKLE.localdomain ([206.83.103.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304ce8sm158761725ad.128.2025.09.16.04.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:02:38 -0700 (PDT)
From: Jonathan Brophy <professorjonny98@gmail.com>
To: lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jonathan Brophy <professor_jonny@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: leds: Add YAML bindings for Virtual Color LED Group driver
Date: Tue, 16 Sep 2025 23:02:15 +1200
Message-ID: <20250916110217.45894-3-professorjonny98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916110217.45894-1-professorjonny98@gmail.com>
References: <20250916110217.45894-1-professorjonny98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Brophy <professor_jonny@hotmail.com>

Document Virtual Color device tree bindings.

Co-developed-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Signed-off-by: Jonathan Brophy <professor_jonny@hotmail.com>
---
 .../leds/leds-group-virtualcolor.yaml         | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-group-virtualcolor.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-group-virtualcolor.yaml b/Documentation/devicetree/bindings/leds/leds-group-virtualcolor.yaml
new file mode 100644
index 000000000..945058415
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-group-virtualcolor.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/leds/leds-group-virtualcolor.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+title: Virtual LED Group with Priority Control
+
+maintainers:
+  - Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+
+description: |
+  Virtual LED group driver that combines multiple monochromatic LEDs into logical
+  groups with priority-based control. The driver ensures only the highest-priority
+  LED state is active at any given time.
+
+allOf:
+  - $ref: leds.yaml#
+
+properties:
+  compatible:
+    const: leds-group-virtualcolor
+
+required:
+  - compatible
+
+patternProperties:
+  "^led@[0-9a-f]$":
+    type: object
+    $ref: leds.yaml#
+    properties:
+      reg:
+        maxItems: 1
+      monochromatic-leds:
+        type: array
+        items:
+          maxItems: 1
+          $ref: /schemas/types.yaml#/definitions/phandle
+        minItems: 1
+        description: List of phandles to the monochromatic LEDs to group
+      priority:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Priority level for LED activation (higher value means higher priority)
+      blink-delay-on:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Time in milliseconds the LED is on during blink
+      blink-delay-off:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Time in milliseconds the LED is off during blink
+
+    required:
+      - reg
+      - monochromatic-leds
+
+additionalProperties: false
+
+examples:
+  - |
+    leds {
+        compatible = "leds-group-virtualcolor";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led@0 {
+            reg = <0>;
+            label = "status:red";
+            monochromatic-leds = <&led_red>;
+            priority = <2>;
+            blink-delay-on = <500>;
+            blink-delay-off = <500>;
+        };
+
+        led@1 {
+            reg = <1>;
+            label = "status:green";
+            monochromatic-leds = <&led_green>;
+            priority = <1>;
+        };
+    };
\ No newline at end of file
-- 
2.43.0


