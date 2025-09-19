Return-Path: <linux-kernel+bounces-824184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F23B884D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A9F3B70E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5702FF670;
	Fri, 19 Sep 2025 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Pz5xx5FV"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1752FE051
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268711; cv=none; b=mKRuEmo9d0fX4AV+oVm2pAI5AqZCGc4whQRP/uGQVQxmVC69cSYvvZm2weKPv7m0kzwfmVb+jSA9ZHK+k+ABsiQn02K7zeSkakAwlYWFxTNFIP4FVCi9d29H3ZUnEGT5auKTOr0xsgbVJVHv8lAq7uHjJqejTGljLI5MKgTqPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268711; c=relaxed/simple;
	bh=E9K9Tcmx1fU8Xgf0QCX4J3/M1M7kY8m1UWq24vz65k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaOjGQMm7WkD2zh9YMdgwC6oXPs0i9jEDICkR+d6l/6E+1OSELjy2nTiMSsGQajD+yZykw7jY+78Aft5b4CW4qG2EBxoHlPD4wWvyZCYfck+VxRyqd+t/phNpi87q0nZOHMpeOvoKj/Zkhju51elkOEBE2BrW0edALx+j/gbea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Pz5xx5FV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b00a9989633so377080866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758268708; x=1758873508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT6JvarRuFKmmTEv7wD5leEJ64JN5pVMHm6P1LFVOTI=;
        b=Pz5xx5FVT5Gx7LZkKNAnxJ1fS5YKC4gfIkjEukcW72+zwz4yFGP3wx+n26Uwh5Nx8p
         eMWHUoF50LWcVdqL7RsJBpvJ/T5TGI1s3i3PIkj35e5GydDHV3Ym++MykwF9vg0xMmHF
         zyWpdRN1dZdhwLSYdhuHIz0/GRWyvrXQJJwLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268708; x=1758873508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PT6JvarRuFKmmTEv7wD5leEJ64JN5pVMHm6P1LFVOTI=;
        b=EcgyFMZmV9arcpFJoZudPf9IfwmcNT69sLrg89vWixjq0415ogUzAumPWWOTwHIxVP
         Mbo8ERTFS96hbbZgtW9gsWxRSwsYFY9u9B6DpNf6SDFhT7rEV1raZTyuuU5vVefza+d9
         5S6SsMOEl1qNmjLWXo7YQEXepSpCQNU0Nz/hRgkqvmc9qnl8wjGpbUEbS27u0PX2nrG5
         Hi2pmYejChB0iG1hAh1INmT9LupZWw9V/IbKLXd7cEHiHUouTzBf4+/rwzr9HGQh0QC2
         Mx4Ccs/LfX+52xAGty6BYaeRBnYmXk5h9VLe5lshpnsE1tcxsZYeNEqvQ3x7fQaOGL/n
         hhFw==
X-Gm-Message-State: AOJu0YwjwZkJrZv6u7FFqf8IzgavcPEQQPWDtR+QQUpC1HhSrEcSdynR
	v6GoLJwugNqa5QhQygIeZE4fvzMuWamfYCD3FJF1rnZ8unWE+/ZysUQbDqHMxFZNkzoIGAafm4b
	iJOqz
X-Gm-Gg: ASbGncu8dBgpb0lcRw4Uu+fA3CXL7UiGHbJu93TxtdYItZ9qD2Lx75Xvz22UPBT6jkJ
	IPDFuseGu5sDZc07oPoc9x6zp/0eVGgNUAX2TTCEzx4PLZPoniouKYrFcZ2mecc2EUoNhjlvR0f
	Tp9xLm3rJ1HZcN09bGlx6tuGLGS8Ud5Wx5o4qJs23jSY3MizpFlryIMMU8xktoalfxw3fY+DtBH
	vj99BbIvVMHcfR8/u/nCgBt7T/yuiw5cRZkcvXoeZ5AcofmCpfh+qdxVL1KJTBOeSjgI6O+x4tt
	SgGtBvBB6xNlZlVbusPOholfgRYDsTgEnpVvOOLmv3u5A1HJ3Ezjg+0fWVpw6twycbEI3pQX/7R
	EyjTZMwy6dA1RB0L3+KSuWHkdghUwTBI8aVIVYZzF+nHgSyR5QxzCNTR/anJYy2lcRWErWZxGc9
	atrM+dm3xjTnADG/Jr75hxSqmEEM1EbO8gQqw9lcsEzYVAVy5ZWXxLPsUwZS71xaVn
X-Google-Smtp-Source: AGHT+IFVmMbGPcUOVB2f/NGML0r+wfIEIHxLP2WkZddjteThkPE2Q3SgJjeYXbW4lXGUcYeGwGiGUA==
X-Received: by 2002:a17:906:eecb:b0:b0c:fdb7:4df3 with SMTP id a640c23a62f3a-b1faa413cc1mr735074866b.11.1758268707834;
        Fri, 19 Sep 2025 00:58:27 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc890cc98sm384693466b.49.2025.09.19.00.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:58:27 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v5 2/3] dt-bindings: arm: bcm: raspberrypi,bcm2835-firmware: Add touchscreen child node
Date: Fri, 19 Sep 2025 09:58:10 +0200
Message-ID: <20250919075823.2557865-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919075823.2557865-1-dario.binacchi@amarulasolutions.com>
References: <20250919075823.2557865-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Raspberry Pi firmware 7" touchscreen controller device tree
binding to json-schema.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v5:
- Move bindings into raspberrypi,bcm2835-firmware.yaml
- Remove raspberrypi,firmware-ts.yaml
- Update the commit message

Changes in v3:
- Drop firmware-rpi node and use only touchscreen node to fix warnings
  you can see in
  https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250913092707.1005616-3-dario.binacchi@amarulasolutions.com/

Changes in v2:
- Added in v2

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 27 +++++++++++++++++++
 .../touchscreen/raspberrypi,firmware-ts.txt   | 26 ------------------
 2 files changed, 27 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index 1f84407a73e4..044544c17e8e 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -103,6 +103,27 @@ properties:
       - compatible
       - "#pwm-cells"
 
+  touchscreen:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: raspberrypi,firmware-ts
+
+      firmware:
+        deprecated: true
+        description: Phandle to RPi's firmware device node.
+
+      touchscreen-size-x: true
+      touchscreen-size-y: true
+      touchscreen-inverted-x: true
+      touchscreen-inverted-y: true
+      touchscreen-swapped-x-y: true
+
+    required:
+      - compatible
+
 required:
   - compatible
   - mboxes
@@ -135,5 +156,11 @@ examples:
             compatible = "raspberrypi,firmware-poe-pwm";
             #pwm-cells = <2>;
         };
+
+        ts: touchscreen {
+            compatible = "raspberrypi,firmware-ts";
+            touchscreen-size-x = <800>;
+            touchscreen-size-y = <480>;
+        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
deleted file mode 100644
index 2a1af240ccc3..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Raspberry Pi firmware based 7" touchscreen
-=====================================
-
-Required properties:
- - compatible: "raspberrypi,firmware-ts"
-
-Optional properties:
- - firmware: Reference to RPi's firmware device node
- - touchscreen-size-x: See touchscreen.txt
- - touchscreen-size-y: See touchscreen.txt
- - touchscreen-inverted-x: See touchscreen.txt
- - touchscreen-inverted-y: See touchscreen.txt
- - touchscreen-swapped-x-y: See touchscreen.txt
-
-Example:
-
-firmware: firmware-rpi {
-	compatible = "raspberrypi,bcm2835-firmware";
-	mboxes = <&mailbox>;
-
-	ts: touchscreen {
-		compatible = "raspberrypi,firmware-ts";
-		touchscreen-size-x = <800>;
-		touchscreen-size-y = <480>;
-	};
-};
-- 
2.43.0

base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
branch: drop-touchscreen.txt

