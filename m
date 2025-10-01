Return-Path: <linux-kernel+bounces-839047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5643CBB0B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE86189E696
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207F25A645;
	Wed,  1 Oct 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LREd/2vq"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BCD23E32D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329077; cv=none; b=Y5PHpbegw4oTJjX9HvOhyq3c4UWDoO+PPfSvpFxqDgCkea7MpjpXUWkz18gp2WXhwsXyNqlBJH1s3QriLha0Bjt0KzQbXltG72nMe6Z0dhwLIWe4IHZfKDT6H1pF5JuRf7lu15ZEDZdcsiklSIKZp79cfYYSlItEVvjhvs4UEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329077; c=relaxed/simple;
	bh=XWZPUaaF3htAs1jXMpQkvVgHfFhx17l90EvgzHPAih4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItyTfZQUXpoDezgT6S9/XwTeQisxho3RLl21bEuig2w0PcXWNM4Ah0N7OhXfM2avy4zXVqHavKLDHfa4kkLVAvFT6NPfGkXnKptzurIzA154msAuLknp296VLxbKO7J225nsOY1jNey2IT9+EYHnpogM8r3lUzOMgxBrBgkxGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LREd/2vq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7ae31caso1099536566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329073; x=1759933873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hm8p+oRUJotaddP1TSvfnFNBE3k3mXNPqR5Ais0Uds8=;
        b=LREd/2vq9Zl5L/W7CLQYyAd4EVHfcKh+/YsVy+8bHyp0yO5Q6BEjT3YgDUNylJo2JD
         QbUgqHxFo2GyyzOK9zaem5LTzxD6+h3YhrNh1bO1DKWPyJ66wDoRAxRR4t4Z8wJAl/Xk
         dC91hwP1T7Igm1eEgRG640dlKJPBrk+zR18BmYdFFlf7gcn5QKK6BU8eOnHbYJXtgaJ9
         VEf1pjkIUXILdN0PxX2Q1Z8A84awE1zPz6acfvWWA35Z64BzH6QJKZxoN7NSz5/xFXkh
         e78g2ESvVZiURDMpqg0m/FC3+BRb7zlU7Eml2ac0a0uOZgtkBYNbT1E1/hbdEyh6GNjU
         O31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329073; x=1759933873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hm8p+oRUJotaddP1TSvfnFNBE3k3mXNPqR5Ais0Uds8=;
        b=u6KoP5xywVBq0l9tW356QnPrGCDUnFn+uE3UOciXRcldi3XjhYizXx59XAqFbIyTDP
         BDg3M7klr0vRVFM6L67/sI08gzm29lktUqIn25jdstoVA3pgGskyHmCOjhDf+KVvFltN
         8hOVsim9dEYcP5PDk3x3k5zFjkiOyiWAaXxIhhVEd4dUXJuqRccw1Knu3a/QlOpO5WiK
         Cs98YU58TuxHxdlfrzYQS1w1PxtI5FwxhYOPXMftunBK3VeSpsg5vG5ECitWfKB7TywM
         xp6EdenQuNIT/Fcv7/eFtZdsdWePqAq/FcblaIWdb0QgrWqGItkfc1HCg5yyYuX/kgKN
         06HQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2alBGoos98dBouCkkAStjkfagxo3zvKpQLVufg9B1SfzvPpchLT/ULoHXdFFQ5ndAx/iCgA49++n7Rp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmr9PW7KHJaOKaNh8vi5fJ0PTMvny/Ai4FUD/Hs9tX9O1JZIxO
	QmcNIb9tXan+NVyZ051h8c4Ed4MdmNHsH3HwGv4Ffl08/0Zz1kXVLh8Z0ebbh5kGOVk=
X-Gm-Gg: ASbGnctMfYWv32JCdYgQ31Horpvbbm6wo07fUjPwDpsYSkbVUsAx+A7Xrt8uccPjRbq
	1coZ528QBvBbwMzNq6Skau7gcss6HrdYQeyGNcJRt1F5kIrvM+e6mS/5Xe/1/1yjCYB5gowKD/K
	NP+9hGi/GTDCgjns1vSnXt5iHo43Xw8jZIIzzfi+YmUPgOghH+H+Q5DxnrTGgooT1iyNmQTh2hv
	OvfOfEc7/RafEadU5PTUm2iSz62x4ADlOpAA5wRspv4jtyGW/ugGrUvmTG8JXTnLwwSdczJ85ND
	5PnYcJu0/f9/+xH5tbx90UfQkgZAY88taLUv3VP940I1cM/rGSAuihhPBUe+uRbg7OIjwGKX4iI
	cvukeImHltzdhVKNs2op+gXwm98GnCdRiyhR0F3LIffId
X-Google-Smtp-Source: AGHT+IHFmCw9M7RXCZRtcPimiE3xYGWmiFdckmISU5XdmOOsx8oWJtSKmAidkIoaUD91Rq4E5XkMwQ==
X-Received: by 2002:a17:907:3d42:b0:b3d:9c3c:9ab6 with SMTP id a640c23a62f3a-b46e6afd22fmr373738766b.29.1759329072722;
        Wed, 01 Oct 2025 07:31:12 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b3fb818fb90sm607739266b.63.2025.10.01.07.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:31:12 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:30:19 +0200
Subject: [PATCH v10 1/4] dt-bindings: can: m_can: Add wakeup properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-mcan-wakeup-source-v6-12-v10-1-4ab508ac5d1e@baylibre.com>
References: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
In-Reply-To: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vincent Mailhol <mailhol@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=msp@baylibre.com;
 h=from:subject:message-id; bh=XWZPUaaF3htAs1jXMpQkvVgHfFhx17l90EvgzHPAih4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy71sI/mqZEXFbZ5rHrr8krW/aez89esqRFKG92/HjN8
 kSkq314RykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzknDYjw0abY2oqP/J+sIfH
 rNbffP4Bg+cyCx9Xy+Ai5p/PS5/ufsHI8P/Li83dL9pSlytNdG22VxX9+IwrJVTlurDx1t9v/7x
 8zgQA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The pins associated with m_can have to have a special configuration to
be able to wakeup the SoC from some system states. This configuration is
described in the wakeup pinctrl state while the default state describes
the default configuration. Also add the sleep state which is already in
use by some devicetrees.

Also m_can can be a wakeup-source if capable of wakeup.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 61ef60d8f1c78c40a6c8458ed30b940b1121d83f..2c9d37975bedd652b3060ab11ba75c37565edaad 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -109,6 +109,26 @@ properties:
         maximum: 32
     minItems: 1
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Can be "sleep" or "wakeup" pinctrl state
+
+  pinctrl-2:
+    description: Can be "sleep" or "wakeup" pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. Other states are "sleep" which describes the pinstate when
+      sleeping and "wakeup" describing the pins if wakeup is enabled.
+    minItems: 1
+    items:
+      - const: default
+      - enum: [ sleep, wakeup ]
+      - const: wakeup
+
   power-domains:
     description:
       Power domain provider node and an args specifier containing
@@ -125,6 +145,11 @@ properties:
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
2.51.0


