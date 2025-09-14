Return-Path: <linux-kernel+bounces-815650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541B6B56970
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8D63A96F3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976F81F09AD;
	Sun, 14 Sep 2025 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TITA8mok"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071801D554
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757857526; cv=none; b=lByKK+nb/IHZfH+2RPmbvr7meuBx2R4rfEi2hJFuifpptOZ8HwNqQ2xriVS/61mv2HeRkTNu5c06dkKAFYQNc0KqRli95TAEwIqONcaTcHW74EoXAXQmmWzLzXhzy0Eb8whqfOynZa389PTmTpl0vDws2skJqdu01L3DWCOq1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757857526; c=relaxed/simple;
	bh=ZyIwDRc1karmnPZqugX4+B0QPTIr0vD/Nuuu4fYp4xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSuoHW82npcvHrdm/FIsNaG3e22s6ZVFp/5jNA/WxgaxfiI5ng2MCMpc3fjo61T9rGClpiJHx7VGytjyQAGi2VY/07AhI5O/d8A1RdOkx4eHb3Cvp8y79tDKxCbAW6VghOAnQj/rlXzC27DGabfd0AeZFHQqF7QU0LvaBiBIVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TITA8mok; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so1365065e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757857523; x=1758462323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV3zHUbx1e+LhTjQHrHCchQZpY4e/gFltYNW4sD9Hjk=;
        b=TITA8mokEpQ+xw1RuF9qNrXl6uFUthDmKm4Ef0GjSZNpOkGDeaiaf869+vs0h4kO6N
         VbeQ4U2VH+JlCsfbIdplbgh+6pcvdIUI8EwxFpYTQ+VeinTdUivwAUzRwYi6UMsf8fj1
         K1MBFMPwHfvF61SLBvn1JdbeqqDHfIFsT7U3zvGGx+iDOdchPu9sjvNACg/S3RY756Sg
         iOWc15//SWy0b0U9Un8PRaWvUaZ+hhc4lzzKY34yiFImJs+o+cTd74cCdXql+WdKLAae
         T7/6UnCrzAoq0DBYjX36T4rUKtyYcUlGB2F2FpX2KHmTa6M7HGhVRLS+8xA0fQAxuEBL
         y6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757857523; x=1758462323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PV3zHUbx1e+LhTjQHrHCchQZpY4e/gFltYNW4sD9Hjk=;
        b=sUijE60AuRJMzSKzyPj2GwEaHmIVGyp4ykoYA+8HGIppOZaw9f5zQBDR6LYWKhCJTW
         ZBypv+PBgavkv1vzum3xTaPwC0+BtQFzCws4VG3lmhoitfsDfHBb8PS7T27nvLeI3v7u
         MuYv8/BZuHcDdPu3NUgRjsM+Rwx0Nca50YFBaL2lWsZ2iw8ugKvDIB0VRAKTaZQJcxqW
         J3AC0FK5OqINaltLjRLHkuDWlikp5y3RgXz5ZJVmiDwFZWWF+VU+2geRn+ba5hwdXD/1
         RldT1owSE1TAl3OWS7olmN0A8IwV6bL8Pw78gr88YPGTgTaf7gr4FRbTJBpt1V1aMuDA
         aYCg==
X-Forwarded-Encrypted: i=1; AJvYcCXHjuYAXqSsdk4OaqWIrXPAciqPxFSyQogseeU8+/fSjM3yEC3xo6yJ/FL/QS1lJrA2FljfAcCsQjmXxk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMNiSeaJuTzYsOH98BF5rDm9tddj9T1rHnQGO+zQXFQ4Y6a6Y
	QpMM0pmVtw9Dzk8y11YgLIzClO7uNOD24/I1bgHVpwhdp1IyXIaYSyuQ
X-Gm-Gg: ASbGnctMAdkGASyLdoAHMRL30f38DYlpM6epzesMeRii3bTGK5/pEBCj9+mmJa1tvqk
	1D/jKn0iqMR89PpgeDQ9xhI+EfPtRv/0joB6jAZIQpEeaSMGWmjnLp7jhdTE6dSob05v3rfRrGv
	0EZGa+RcL6OaLCVP1wc3YpvuhttNLcXTu6MKWM/P+ss+vF0CRDIqCRkHjdBXV3o7Yw2dlBuHp0B
	wSDWlw+niptKqSNZJcMUy6Z2eB0IcOXFIapvEmv2xF3BAz5EVjwLxWriMr6DGkfw/iFs1ylqGmA
	F5tKqXqYhsCFpMeNetgtwDA1yB/DGqb4Y+7XJr0Hs24EoUF+uwdbxbrCDP471vOB4x/gkNWx1yY
	FJ0QIf9IRlooICv1PmJpwpVx2gh8lBzOwyUQSuyUQbmX0ysjdIAhxCisoQh8mXLEKOqlMdgYUdX
	rJ62KPy2k/
X-Google-Smtp-Source: AGHT+IH4PxlS+eMu4I7zsqkF333IE4ZBIXWlFwsih4mbbMUXY1y5US4lIdGFnDdmKTKa+deYcjSRTg==
X-Received: by 2002:a05:6000:2408:b0:3b8:d360:336f with SMTP id ffacd0b85a97d-3e7658c1c6emr8490202f8f.28.1757857523258;
        Sun, 14 Sep 2025 06:45:23 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea4b52b7fcsm1467591f8f.33.2025.09.14.06.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:45:22 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: input: document Samsung A552 touchscreen controller
Date: Sun, 14 Sep 2025 16:44:56 +0300
Message-ID: <20250914134458.2624176-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914134458.2624176-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914134458.2624176-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Samsung A552 touchscreen controller, present in devices like
the Samsung Galaxy S7.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../input/touchscreen/samsung,s6sa552.yaml    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sa552.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sa552.yaml b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sa552.yaml
new file mode 100644
index 000000000..af151e245
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sa552.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/samsung,s6sa552.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S6SA552 touchscreen controller
+
+maintainers:
+  - Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6sa552
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
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - vdd-supply
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@48 {
+            compatible = "samsung,s6sa552";
+            reg = <0x48>;
+            interrupt-parent = <&gpa1>;
+            interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+            avdd-supply = <&ldo30_reg>;
+            vdd-supply = <&ldo31_reg>;
+            touchscreen-size-x = <4096>;
+            touchscreen-size-y = <4096>;
+        };
+    };
-- 
2.43.0


