Return-Path: <linux-kernel+bounces-825439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B03CB8BCDC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCC31C05877
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD8A212566;
	Sat, 20 Sep 2025 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1mcR9M1"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835B91D7E5C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758332729; cv=none; b=qqL6SPOOFH7Bdzekhcv7fMe8IkfFu2GqcKgZwFMksiWs5608Ddlg7VGACsaUQg0HM6rjMmiULp4+hnCfnYDrODFMgwyqdPPH/VodsPYZR0aPZZ7igbkw04d9neYVURpMuoD20Cq2Mxfxah8nDdxG16LRbp1r+hT4gSGQdjO72WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758332729; c=relaxed/simple;
	bh=pBL+gVGPk5Oe6pgI0u7TV5kZR7rId+e7XFYkDX4Yyd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oda8caF61Nt/BtC8/jlJeDTzWglX1vC1RmzHPIuoKCOaZ+vVnNqY+imVrn0htGqdgz7WcVULKigAtTyfQf8JOcWxrtVp5tHNnz1658vknOTNnNxOD4QSqonBW/dKRbGFEfJtunsSnFmBNKRNWAy6XgnF6KoFEgTwxtbHaSkE7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1mcR9M1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so2758576b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758332727; x=1758937527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g3X7itFcaYd0uyiDe5Igj71JtDo3enYD8GOD7zyyH0=;
        b=g1mcR9M1H4OE/tqDUPn/KWIVoO7KDOIq7A+byt4N6uy/nsEuqGzOsAhDGuP3n2rFXm
         DOzRgfGiTezHK8VMmjK2TZz3cRROnk8Znv1Zt5XppCmnXC5lT8Nw0TQ3vZl64uLTdkzq
         gtyEeqY0upuagPp/Lt9hFD2nFGFn99ouzdQIIGbM4+K89MsCKPfBMw8T6Ggx0R5pmdTY
         Ifye1nDJqxyYTXxGjcJVJ5P3/uAW6j4SSft/oDeaYpsmu8wMi0/M8Z4ASDG5OTasl/6R
         gW/lNrtq1RA8hfave17gt5IEEnFiJybPcWIvgKJHDJ8cRzJMgh2nZpG2HcdxK8bAuPjs
         M9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758332727; x=1758937527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0g3X7itFcaYd0uyiDe5Igj71JtDo3enYD8GOD7zyyH0=;
        b=W18gfB3mfp3opXma5TfZGW1D9C2IJOlxVMrmJASlmQcemWNfw3yOKwBUmNkaTmAMzx
         VAu6MACVHyPPwY7Y7s7GNuwDclHqswWrLWY/FXSOVz1anYlm50X+1QAPqY4NtIJEATFr
         AUC750wxOvJh4NwXvf8w86ZXGHvFKRfZ2NqWywBHlx4zL9Ytrq83csBPZPmwLZpYUc/d
         Nd/8zIVGOIA9WS8nW4aW1U6FuUcYlZBMuUFQ6W1C7yY/H5zRPk6OxTBP6hDI9/0E6POU
         RC3r5yzor0MTY/lwDZpy3Wo1HkhJUFslUr9e86BrvJ0nCz58yzmtPIEwXLjkITQquKDt
         xa9A==
X-Forwarded-Encrypted: i=1; AJvYcCUpLPzPygBrqG1n5m1Ad0T+IqfFSr9bZymYOvkmtNwizIV/R5lGW6PFjC+uwirMP0BupGsiuKu0GQlhv3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/wZt7Fc7iFVIPVSVWt6mIkleIr9vWOM/9KzRu/GOz97R9B7/
	zKuLYTyT33tnpBZpk4jAO90R3HPmp8yDYtFQv8CjyGFFJpMBNhRsyn4Q
X-Gm-Gg: ASbGncvycphcRap52weJvwOppCbEVxqadYGT2HhD+ROjCwdtrw5TIolcmzQUV83tttL
	LyU9SFmi4vsyAVrFywnsDcqXwvQMmkj4Iayr53qIFczhHqBtH+i1FgO2J7/PhvIGil4vlLVYszH
	VPjL5JWq7QA6MxH4hpC/1se0EG935/p/9r/i0uR+0DDTdVm4Lx/jZKwy6iXhbruu7fdEfWMENkY
	P0O8ae5IsHXU2CCpTw/m88LawQLwuPMHScllIb09JSPmIFQ3mWOc+dkVOZsuXh8g2Cnlk7MAdmY
	xPwwUYkQw/YsqlDDNW4FHD53LIhHfu5A3wgQDceSB0eu7oJ8gqyPB+r8m/n8Jc5rHQ/6Z3bFvDo
	x8MCo1ZuVMyREdCbKVNx8
X-Google-Smtp-Source: AGHT+IH46WKyw6dARtEBBxsg7fBtDAYRS7xjAqSCeJOf6ViP/DWyFWnfqtCB+n4K1vLBS6bTt8oifA==
X-Received: by 2002:a05:6a00:b86:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-77e4e5c39eemr6702571b3a.18.1758332726883;
        Fri, 19 Sep 2025 18:45:26 -0700 (PDT)
Received: from archlinux ([191.193.70.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1a72e7afsm529395b3a.92.2025.09.19.18.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 18:45:26 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Henrik Rydberg <rydberg@bitmath.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: input: Add ST-Microelectronics FTS2BA61Y touchscreen
Date: Sat, 20 Sep 2025 01:44:49 +0000
Message-ID: <20250920014450.37787-2-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920014450.37787-1-ghatto404@gmail.com>
References: <20250920014450.37787-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the bindings for ST-Microelectronics FTS2BA61Y capacitive touchscreen.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 .../input/touchscreen/st,fts2ba61y.yaml       | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/input/touchscreen/st,fts2ba61y.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,fts2ba61y.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,fts2ba61y.yaml
new file mode 100644
index 000000000000..d5565b5360fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/st,fts2ba61y.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/st,fts2ba61y.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST-Microelectronics FTS2BA61Y touchscreen controller
+
+maintainers:
+  - Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: st,fts2ba61y
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  avdd-supply: true
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@0 {
+            compatible = "st,fts2ba61y";
+            reg = <0x0>;
+            interrupt-parent = <&gpa2>;
+            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+            avdd-supply = <&ldo17_reg>;
+            vdd-supply = <&ldo28_reg>;
+        };
+    };
-- 
2.51.0


