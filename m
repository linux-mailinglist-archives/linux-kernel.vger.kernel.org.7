Return-Path: <linux-kernel+bounces-777706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8AB2DCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9A91899F26
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B8131A064;
	Wed, 20 Aug 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w86SCndN"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB79308F30
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693787; cv=none; b=lsMlgsKroWaDYQ/0e3vBI4j2Dopj2H7HEIunGDGp9Z2tVmsG/9v340/JSfgAvTkGcKv6UWDfdS8P9cDSsVhiksvBTs9OrN4LDXs3AHgl5XxDnXkUzfJwun5ySqwiQ8whVVkyU/SVukOkt4tcwXcsNIeTEXvjXYWK6oo47qiXYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693787; c=relaxed/simple;
	bh=51A7apjZ8IFVa0Yg300u5/+5kMrmxbdazMNe8d87/KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5or64B6iPzOkAAM4KcTOBYy+AOIB5gUS9MJvT5eC9J+KtOWJHHqvSP9QVy1ae2WFyTZtk0Y2DLvd7tfLtff/iV7nl04aY2cGC4TVJNM95TYtPXwWAcQq+EALnfvaoyzceshDObK24A4Ss7qNFxwUC4+hrTg19n3svTDeYQff6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w86SCndN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7a8dd3dso918040566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755693783; x=1756298583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwZuyqe06pEPgm8WrxHlNtoUHhvQcJ+8KnDBnyp1UJ8=;
        b=w86SCndNnGmtUMUT0OX250cIf6Moep2rk1xpcBmRY93sCPo7VTnUxn8SsQmFcCP2Vs
         0ElgdQ1vROyZCq8USJJJ94DZUsNjuoMdKo6TnDF65Pgsr/ebvmSAa8rOwg1UBC31E5Y5
         xqjP2UqQz3UYPdvBs9V3Ye8+cer78JGYvhWseOcrhmNDR4SirMWlfT1WY0kClBEIBg5r
         cEepb7VPCbRVA/gm+cevR4v8h6LW4uD5BMap4Yi+UvMlXimQYKrKzNeQneRCI6VX0FMc
         Sqh2COiwjU7yJKWc45ZA2p64cUx8vvddd4XO3l2/weHtf46y37j0hVS5HNTRlLKTXV0u
         8c2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693783; x=1756298583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwZuyqe06pEPgm8WrxHlNtoUHhvQcJ+8KnDBnyp1UJ8=;
        b=UnDHcKewA4y/wHHd7BTXYpMYc4Cc0MoEgTyqq7DeC+3MrwdKlG8F1x7NTijlfoagOY
         utyweKluxZ0jcIRjNODNuy9Ko4c2k1jgsc2qTwHAKrYXmIBCqpKEyaKHkBc+Shivsacf
         9dO25lubjmBWlGxdCbkdr2OkFz3hvljruHBpr7VNRQyYr0R9Cf9yqbSTHZpyTfFJbI+i
         bxOQN4YXe/gwRby+7cSTTpP3BflwytasTtrtcDw/gFiSJ6gR/FzrctI+jJdcL5VeM1P8
         1aPvB2kZmXWP1lqSS023uYwL/vsHW3wbfptdCiVjdPdacmEVlQyKz5Y1dEVSOuCqZVy/
         nbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX283fYBt2FRH8eLAmtMaJKUnL4dEweFfyxwNZ9SK27k/gQDAougpc0pnQDs+uplugH9ORkVtbUjFluPDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqs8B6ocfhGqI75Q4UxBE3J60L2gJEh+kGfBOAGevB1HKgDn5N
	AftNHrv7TpkfN4IMYC8ztxPZ4HmN19J4GoHCAqbFyX56BpclUbhpzuq6MoWls/YO/m8=
X-Gm-Gg: ASbGncs+4iILJpZ26pnA2f2/HarPYXqCEFg96B34nlbkMGiaT0E1kIM/xBpQfosiCsk
	AuOVCBvPbxJzXBhBFsF2+Zhrjz5zP4XCPyO2NPoxMzuTtUihybWTbBcAUTJTFNYiuBSYfqyDP2/
	lcc8OgJSw3vcHBCLFMzMMwtfUXXKuHazFIi0g9PPb83VDghjR1hJY/bYzE5RejScmD8me4n1xW5
	6NttRdSHyCbj6Ukfi7Dc6h7Co3RzICiU9Ax6x3AzheolYWyRSEzpl4/S0Z5UNaPxAlYMbGiQNx1
	2iLQBvpsIn8vULyFkB1UzcAmEiC4O7phjVk7LY2t8ee0xeEwcacubeXRqFelYtBzJKk7Zf4eAWa
	dFzbYK5uZ2eUhc0f9UA==
X-Google-Smtp-Source: AGHT+IHVxY9C2B9taD88Cxqvj6obkaYcfXI9ph7iwjcVzwEn033IZvRkXZCjUiNo9LHBqDddmiHmgw==
X-Received: by 2002:a17:906:c141:b0:af9:8cbf:6053 with SMTP id a640c23a62f3a-afdf0049eeamr202227366b.6.1755693782774;
        Wed, 20 Aug 2025 05:43:02 -0700 (PDT)
Received: from localhost ([2001:4090:a245:849b:bc8d:b969:7631:815])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded539d39sm169436366b.110.2025.08.20.05.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:43:02 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 20 Aug 2025 14:42:25 +0200
Subject: [PATCH v9 1/4] dt-bindings: can: m_can: Add wakeup properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com>
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
In-Reply-To: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=msp@baylibre.com;
 h=from:subject:message-id; bh=51A7apjZ8IFVa0Yg300u5/+5kMrmxbdazMNe8d87/KY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoylh/ZKzOsTPc8b8uxn84xzGfvzYm7N2zsp8edhjvUCG
 cnBW52MOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiVtKMDH8Pby569cDFMmKt
 22Hbx/uDLP8ujXv4U+T0nv+Gz13nrDnO8E+bkclcS+jC286JkRFx+vM2t2/t+eJz6fN7x4qPHdN
 4t3ACAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The pins associated with m_can have to have a special configuration to
be able to wakeup the SoC from some system states. This configuration is
described in the wakeup pinctrl state while the default state describes
the default configuration. Also add the sleep state which is already in
use by some devicetrees.

Also m_can can be a wakeup-source if capable of wakeup.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..0e00be18a8be681634f25378bb2cdef034dc4e6b 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -106,6 +106,26 @@ properties:
         maximum: 32
     minItems: 1
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Can be Sleep or Wakeup pinctrl state
+
+  pinctrl-2:
+    description: Can be Sleep or Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. Other states are "sleep" which describes the pinstate when
+      sleeping and "wakeup" describing the pins if wakeup is enabled.
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+      - const: wakeup
+
   power-domains:
     description:
       Power domain provider node and an args specifier containing
@@ -122,6 +142,11 @@ properties:
     minItems: 1
     maxItems: 2
 
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      List of phandles to system idle states in which mcan can wakeup the system.
+
 required:
   - compatible
   - reg

-- 
2.50.1


