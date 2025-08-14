Return-Path: <linux-kernel+bounces-769065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C572B26969
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A44127AF6D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9361C2DB2;
	Thu, 14 Aug 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="VeX4dCJW"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0311C3C08
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181915; cv=none; b=KKBGTwR8KG/eP/WPi9NWdFz6LW3ipZm8P4BsMXzvMXLAGagr/Qa7LFxGEda66fWhU6pusobr6PZwc8SOGffhZudENtGccgH59ONRdwchU/aI9YnIxk6H/AU+W1zoK0TdPTUW8AvWs2oWovrYc9HFTCTa+7nG9mZj12TjS6AQzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181915; c=relaxed/simple;
	bh=BZdTeafb2fIS+8xb3EXpKbZfWOteCkbfzVO0j3x+Ptg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmZyaxuEbSq4agkNGBvXOZqcNB/bIYT+7WJd2AyTPCeADDLHiR8azIvC4l5mwPf2nbkgn+bYkfNnwbXUz2Bemha7Q4nyh33S7TGVMsocD9LwyWyVRrKjArUP0LG72LJ69P1TR2J9OQUvYLMZXxEsXxjXiJ/C2qEFSDZkDUypqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=VeX4dCJW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b6f501cso1255599a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1755181912; x=1755786712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEqX9zvov7BfNQVFU55b1bzbOryL5AKEWqRXjMmfMXU=;
        b=VeX4dCJWP+vsOvz1BixDVE5+CF8Jsi6tAIJ6EgjoxTzbGJfaH0F4qFReYZcRTRIZkz
         a4J+1varcbah6+LnMIyKngSJCWNKqjMSjjEqVyJ38vgGN1cXfOxlq5bPoqmjayeJMGjL
         QbHSF6sTkAIKWr99A1JoQuwWrUlulER//R5NgjJqkAjg7PkJjezHUqgTYPKE0QMIg1pd
         G7BvEyqDOI9W7iEjGikUZ7/Jn2oV31fept1tu75b89KG0H3HPf/EDIu4a0D4+dOroPUh
         uaHeHdVXqHEMuZv2Pt1xHruoTt96jhxf5NxVsODv4QmmEz5H/v9mcEVsS87lhgm53vuD
         xycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755181912; x=1755786712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEqX9zvov7BfNQVFU55b1bzbOryL5AKEWqRXjMmfMXU=;
        b=Ni8lKXgr0nQJ/eVdD/AIXy5iq8619gLBw7255nQCnh0gqsMqLaQrD7yTgQNtmIPKwv
         MEG6i0E9v4Mwx34qnCvzVrPjt4vOZzAp056Au/c51VtpVyxaosNmz4NyXmFJ1OU7MiJf
         ZfTXlLL0UFjTDyuMQsDu2UeR/4/9YuR4/oD88sFGUvm/8J7ygpNcj9z/5n/sm7hXypZ1
         tqJ6G8D0KcfFei0edG2KoKC2JOLmQkay+wITaI0IxGDVmKxvw2o8vCvwxASkpq3712jI
         kaW5oJB15GhYT3eLt1skfU1ut78kYWL+3mYonI62ut/RBe5sG3ct9ue0b7kMcI7BaRb2
         0efQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+ngg5wqRTjNDTDKVp042YhqYKIiw6OOrDdvXQ53HFqZx+qGGODi56omdR4YqU7WiI8HRD2UGKu+tNu7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jUz2273tQH0XmL9dqE1DNcVKr1VSpYDjPCsvlX7Lo8JUcN52
	xfdX9QLG5JosCDpr+3zEf+N5BoyKh46RGJRXy4GYAipkqd5rMbM5BaVz2xukpPGhFHQ=
X-Gm-Gg: ASbGncvPGVluJ6Rb6tbwFCg8eD97ZLC3z9zn+ouf/0BX6ZooEwDxns1kEs4/5Xtrsbg
	wChqKi8WzhEiBRGXMEhnGFt2gUQj+5p/AufCxBW797GhtI+MZXp/wt8LgQ8kuMZMjFYt9pHa//3
	Zk01SUOeitjunprIrA4hAqpMHRFA98YrAcplxlPO1uv2sSQClYOhz+ifEpEiXoDiG+0SbqgsMvX
	LduExo9wlMOffANAc++JzCV52npWNyxerI3lCT3Q5wzL55y7EvFI6XSTbkcW6JTweoZcCpJXevd
	2ixmK0y5aAHlYMqtgCsrtHprg3h5aVbUF/DlUAFNyohGegEz0oxfnwjVlMrf3NqaBE2nBqlve/z
	g05lfKfuoWXLfOnOClmnk3RaD9A1k746CA0I4clHJw9ayY0GVOk1KNXHKuO4jp9Ub34YmhK5ptW
	k/3kQi4Ol+OFdrGA==
X-Google-Smtp-Source: AGHT+IEscad7XFu9F5AnodmiCH/Hokbb83KhwDiZDACpHGTrIewPrZnEhM8Ko3M6BprKO/NXfmD88w==
X-Received: by 2002:a17:906:aac8:b0:afc:c736:8b0d with SMTP id a640c23a62f3a-afcc7368bf6mr152416666b.22.1755181911822;
        Thu, 14 Aug 2025 07:31:51 -0700 (PDT)
Received: from [172.16.220.71] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a313esm2609421066b.32.2025.08.14.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:31:51 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 14 Aug 2025 16:31:35 +0200
Subject: [PATCH v3 1/3] dt-bindings: input: Add Awinic AW86927
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-aw86927-v3-1-c99434083e6a@fairphone.com>
References: <20250814-aw86927-v3-0-c99434083e6a@fairphone.com>
In-Reply-To: <20250814-aw86927-v3-0-c99434083e6a@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755181907; l=1690;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=BZdTeafb2fIS+8xb3EXpKbZfWOteCkbfzVO0j3x+Ptg=;
 b=cUbTJuFur+OPq6hsBbfa8gIQC7YNKpH9hQq8W6bp2waXgGoHR172g8sJez7QnVRXykls0oWHo
 sMHDPtgLJitB1CrZPpEW11K2xfRSBKfdKe05N8pIEoBA7q6HUxApa+G
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add bindings for the Awinic AW86927 haptic chip which can be found in
smartphones.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 .../devicetree/bindings/input/awinic,aw86927.yaml  | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
new file mode 100644
index 000000000000..b7252916bd72
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/awinic,aw86927.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW86927 LRA Haptic IC
+
+maintainers:
+  - Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
+
+properties:
+  compatible:
+    const: awinic,aw86927
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vibrator@5a {
+            compatible = "awinic,aw86927";
+            reg = <0x5a>;
+            interrupts-extended = <&tlmm 101 IRQ_TYPE_EDGE_FALLING>;
+            reset-gpios = <&tlmm 100 GPIO_ACTIVE_LOW>;
+        };
+    };

-- 
2.43.0


