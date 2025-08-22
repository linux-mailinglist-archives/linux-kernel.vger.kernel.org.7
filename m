Return-Path: <linux-kernel+bounces-782499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0DFB3214D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1370B208B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D6326D43;
	Fri, 22 Aug 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="fFZZo2fE"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DC313550
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882659; cv=none; b=L+Tkt8BV5XKu7F4hFXoDAzJzUUs/6rjHE/K0yWU63A0EUxUKLRAcR7gWEg2RbOfzr4CTRwqunrQe5cMiYbLc7b7MZatPb8eo3fsAZcu+Ckz36T4/AqAzA8SiLSiQ8s8IU3IQ7SUBnLpl9aq4lBkn3J6S9MWE5/vzPKvRt0/w3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882659; c=relaxed/simple;
	bh=GC6F3/Jn5vtalbPADycR9a2Ilql3ZeepeVFqnze4ARw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fd+bBzFF2cVrfjKhj95FT6i+ZwqZ1ir8xFeyvbUz8PRqLN3TY1A3USwuc6OLk/SJdgm53VKHiIH+4GWfCl+0PIDI/bmMDbE7TEKsg3XB+WBDcjRJ0UZRCieDOMAwzVHub0y9sltQEmZNXO1mSumCbBAlCzlgRs5BC78uftbcBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=fFZZo2fE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso13953745e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1755882654; x=1756487454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c7uejE+UWAVBp++A3P0eUre76yYfUCzitGMEvBnArM=;
        b=fFZZo2fE8UbZYhXWfP6aqYKG5KMS6E1gySY0//7Ve0fasvPYRIilwZqmjTT/vEuoGK
         bSAKsL76ivH2ngkS0+ZtBZfB6uHjJltLR4CxyCZeyAzH6mr2a2BTJCOdm7jR1D58DteM
         p/pbkq6jsaCfwiCybdDhtHgnSzQjOQvSo0XIq3huvNvrfWP+PWgYhwzJHUoDVI2+Bt28
         LS8lGO9Ewl9oF9F6Zwh33Wc1rYlttSfhn+q6E1cMhtyzYUTg9JchM444xx2V5o520SwE
         NrQLcrE5XfQYyq95JhNHc3gW2u/sYixWH1KdWV7nGnOlQsETvmuNHdixRwEVqxi7bThr
         +fQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755882654; x=1756487454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c7uejE+UWAVBp++A3P0eUre76yYfUCzitGMEvBnArM=;
        b=kI20N/6Vhg84T963HUWyoVe5a1iwAXzZJqQJiW8nNuTytqe5AA68Zq7wBbIquxW0iy
         gJ5H8XjvhAyrhDWumsiLmvRvLI7kB5phR6lY9yeEoWuQcyN15qIyl+VdDD+6zVQVpnfD
         J61wNS2HQ4xHFPRjmxupHG2goJoOFr4YDUaq1pCEADr840q94J2eUSJXEi3X3BOJKoHB
         nlpvqXucVfJkDUkFKin5V9EtYKADQmq5o655m2yjneBxJnLeDSWEqNtfde0diqnIRjns
         NBDWDjz1yrX3aH4EvdbHt7hAi09FDhBC+zoA/imq80fvuT8T0vrUkPgArkU/92wFs9eS
         0LMg==
X-Forwarded-Encrypted: i=1; AJvYcCUeUJWGAle7ZSXBGh1c8YH0VrSBcQKvdDs5/ADukxY8BUCr4MjceBqLVvjdUdHyF9tnDuvE4LcopF3cZEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2zs7UcLX3VbuThRELUeY05b0zdnkhPQBadVO4V46rQYPuutF
	lC9Hh2cmv31A9SCZTBvy1KIpIC46VpkKYe8ueUAsgCDE1dKHl3NYJbu5b45Aw24HYKncos07xHA
	3/+n/xE+pfg==
X-Gm-Gg: ASbGncvF8RwO5jpnKuCaiumAgVB80UjK9qH43Wi9JX131O2Rur+k7SBjqZW2LRG8nha
	YdITaicDE0HkDBVr8nG/watYHGb9DnzW4HcuFolFlj5TxuoTnf7h4nHIWAnGVyvJWIwo69Oa2Pn
	lK0gDiDUZGaYxYbVivIE19ngHdvUqucywx3rj9X+xa9fGi7E9dtYfD1WYco9QZMZWnKVaPhyNCT
	T7M9DqMyrDNQmIEGc/bKh1HaE/djXGXUOIWHfsZB/ucR+iKnuTAlZlV0zx/4Bp7t5VHa26nK+ed
	2/6mvCDYyHlF/K6kSO+m8o7PJo1ZdJ2x2OUIzjk4b4t0+iW9ADJjegJQxG6d7FdCuEd1jT3xnzh
	WX0zBLRPtpyo74R5m5jCZKb9qwnjl1m0Cr4JYcxjG
X-Google-Smtp-Source: AGHT+IF5fbPcLMPGPUXxbyvocoXnUfM5BMARF/EqU2fvSvNEGovDCG+sKKo5gJeocqQhhXEZzLbNiA==
X-Received: by 2002:a05:6000:430c:b0:3be:51c6:16aa with SMTP id ffacd0b85a97d-3c5ddd7ed53mr2426800f8f.45.1755882654054;
        Fri, 22 Aug 2025 10:10:54 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:c77a:e59e:20e0:4966])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70f237fefsm233780f8f.30.2025.08.22.10.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:10:53 -0700 (PDT)
From: Aliaksandr Smirnou <support@pinefeat.co.uk>
To: jacopo.mondi@ideasonboard.com,
	hverkuil@xs4all.nl,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aliaksandr Smirnou <support@pinefeat.co.uk>,
	Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
Subject: [PATCH v4 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Fri, 22 Aug 2025 18:10:40 +0100
Message-Id: <20250822171041.7340-2-support@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822171041.7340-1-support@pinefeat.co.uk>
References: <20250822171041.7340-1-support@pinefeat.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Device Tree schema and examples for the Pinefeat cef168 lens
control board. This board interfaces Canon EF & EF-S lenses with
non-Canon camera bodies, enabling electronic control of focus and
aperture via V4L2.

Power supply is derived from fixed supplies via connector or GPIO
header. Therefore, the driver does not manage any regulator, so
representing any supply in the binding is redundant.

Signed-off-by: Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
---
 .../bindings/media/i2c/pinefeat,cef168.yaml   | 47 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  6 +++
 3 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml b/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
new file mode 100644
index 000000000000..1295b1f4edeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2025 Pinefeat LLP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/pinefeat,cef168.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pinefeat cef168 lens driver
+
+maintainers:
+  - Aliaksandr Smirnou <support@pinefeat.co.uk>
+
+description: |
+  Pinefeat produces an adapter designed to interface between
+  Canon EF & EF-S lenses and non-Canon camera bodies, incorporating
+  features for electronic focus and aperture adjustment. The cef168
+  circuit board, included with the adapter, provides a software
+  programming interface that allows control of lens focus and
+  aperture positions.
+
+properties:
+  compatible:
+    enum:
+      - pinefeat,cef168
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        camera-lens@d {
+            compatible = "pinefeat,cef168";
+            reg = <0x0d>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 77160cd47f54..dab27f769b0a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1195,6 +1195,8 @@ patternProperties:
     description: Picochip Ltd
   "^pine64,.*":
     description: Pine64
+  "^pinefeat,.*":
+    description: Pinefeat LLP
   "^pineriver,.*":
     description: Shenzhen PineRiver Designs Co., Ltd.
   "^pixcir,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..811c6a150029 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19985,6 +19985,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml
 F:	drivers/input/keyboard/pinephone-keyboard.c
 
+PINEFEAT CEF168 LENS DRIVER
+M:	Aliaksandr Smirnou <support@pinefeat.co.uk>
+L:	linux-media@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
+
 PLANTOWER PMS7003 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.34.1


