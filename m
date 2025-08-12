Return-Path: <linux-kernel+bounces-764399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC63B2227D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887AB16331A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43272E7F34;
	Tue, 12 Aug 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u+w9oBSc"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B92E7BB6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989884; cv=none; b=P/4azlW2crC/mHHJ3rQg92Wzl05nkLNiSuMMXsacHOERdg6yiNSvhR66vCbUE+VGUdxNRgcz8PPcKznPsF6N7RhinLbdxfStU+Xr8PT4XmpDTDLXmaZ29qjlISmL3NKBY6eeIJcclFK/GHxNEYn3YUAO/aftawVqDXeqVv1PXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989884; c=relaxed/simple;
	bh=Tv0AJGiFsCFxKN7gqZSV8dIMDvArAvHyf1Cqo56pK6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzike7v2Y6ZOlUkdUqanjIqxdZPq1AMX2Y/N2fCrb7qdezd+zkhH8UzyMVEop8+SDCO/Hrh00l3yEdhDn2ol7ASctuNDnxw2s1KJO+GL3fTZCsAwLA5ghYCfYc3+fgWyk/5TEldCUinY/BEoq0Ky/mDqZ5Cv8utUvYljOEP5d/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u+w9oBSc; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so9277779a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754989880; x=1755594680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJC2PHMCZh5uCGWRu2/ONPI2KDseZ4/QrmpZ44TLrNE=;
        b=u+w9oBScHihJznC/hJ4qLUmelmgT/VGNawDL2Ipg8q7Qe0IxNvji0mnGENVsUtP53V
         PSdepFVL8HNp/L/qLEYcm+KSujyj2g9C81+jLKIVoBtUU5ar2I0+uqMQWYy56ijUI+WG
         lelG1znGASr4cyIAE3LU9BfTpolH5+odOlHD7aKTkkg1dWqqMzvmzAMd9iTYiYizSgXV
         96wfMZ7jp7Zrytp6OdbxSOedUmfUOmEQt8YF4bZFV8Ae7xbiBZp3TtXCWmAFzRk5wGJL
         CHcHF1hqofQsiOsB9lu235+TnKLkqRBE1JRId500STrpDahiO8ycl/vD7dJLwz6Qk/Iq
         my+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989880; x=1755594680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJC2PHMCZh5uCGWRu2/ONPI2KDseZ4/QrmpZ44TLrNE=;
        b=jcP/yTsfCSLdHKKSr/lTBXGdECGPanOhNyt16+by3Px99ZtJB/cw1VDHtTUULeZtjY
         Gu4CYnCAHixTgcSN4fze+FiEmtO6iihdHdsV8gcXx30dkgfw+sfEkWLgk4T+j5Y1iNXS
         HMVbH2QYNqMxkmgOcrZIWAfxDL38BoJVnAo9c8k6lF9wuavd3tSF7Eg7cCmS/3htwGBf
         SbgJxZPCllujmLuRh/RM0Jy48PR/R+d+mso8hvX/bnjvHwpn7Vr2bJJM9OEvZod9Dr3d
         jompfqYJvDJDIp6b+4rdcqv8oPaH2xVqVaVNcfroswXi/40i1cUwekaczr45IHiC5uoh
         KeDg==
X-Forwarded-Encrypted: i=1; AJvYcCWIc8J3NcQLZVT9yERNBb1bepN0gW0MDDcqOEoWIUrrtdKE4tMWOTc032p4HeMlrN1rOyRaU1+G+buYWBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Fe+QRtXBmQJI4Sd3pX/GYQgbJXGVPgmaD7UximRJXg8ZcbHR
	lqlEIi/EaOfZ7KEOlkQHQitMvhdlEvpeTpN889tXOnk4jHZPsdL8MKr6zkEIrs3SUFc=
X-Gm-Gg: ASbGncuh5ndk4xqe5Mla7No/FqphpGu6a+gIohqxDYpri6XxozL85bMMt8mddLGMUgz
	ewXDRstYHHufx93wu9QRuDQupyg6TYdfLzbNUQ2py80OjGCA+0FbwM4GzQ1z5qq5/byFdoS22ez
	sR4wMID/HP9kjLF3DfFFYnzVhVimdh9Ome+Zy9P7AxTKgHt6P5JmJELzGrEpr1desp/JuqkLurw
	KPOoJEx4HCPogI7BkQoaMgIvD5kWXargPsv7EE6YnfkQ3nP56KNjDo+oj6jDLPjAL7sGFAjVvli
	ED6b6UlKkEXT98jKtz0hdpzMPq9CO0s859u4JFNf1vQ8jn9EkGP9acIq9qUzTBdeWqfjTWwFNb/
	mWuiMR3a6r357W3/08yhD5CeK6a34
X-Google-Smtp-Source: AGHT+IHrwvHnT395xLvsUxvtvAA9RVe1fQydx2AltL0VFIKWabbwzUC4skcTIScFssoDO+VytMbrqw==
X-Received: by 2002:a17:907:9622:b0:af6:a116:f13c with SMTP id a640c23a62f3a-afa1df6fbbcmr220978266b.23.1754989880292;
        Tue, 12 Aug 2025 02:11:20 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-615a8f00252sm19809960a12.8.2025.08.12.02.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:11:19 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:10:22 +0200
Subject: [PATCH v8 1/4] dt-bindings: can: m_can: Add wakeup properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-mcan-wakeup-source-v6-12-v8-1-6972a810d63b@baylibre.com>
References: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
In-Reply-To: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Tv0AJGiFsCFxKN7gqZSV8dIMDvArAvHyf1Cqo56pK6s=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZrIq7E7VnKvA4bZl5+hK/lvGMbMvtOvpHFm5c5NEtb
 Jmk/624o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACYSZcbIcO3pho7fc2KmRbw2
 nnNNtu1gVNe/DVeOCMefcXe1ZQzm3cvwv+iCl0rkPKXyXW+jUtbt+V8wfXHoufM3b882W3i87N0
 vCyYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The pins associated with m_can have to have a special configuration to
be able to wakeup the SoC from some system states. This configuration is
described in the wakeup pinctrl state while the default state describes
the default configuration.

Also m_can can be a wakeup-source if capable of wakeup.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..ecba8783198fc1658fcc236d8aa3c89d8c90abbd 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -106,6 +106,22 @@ properties:
         maximum: 32
     minItems: 1
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. The second state called "wakeup" describes the pins in their
+      wakeup configuration required to exit sleep states.
+    minItems: 1
+    items:
+      - const: default
+      - const: wakeup
+
   power-domains:
     description:
       Power domain provider node and an args specifier containing
@@ -122,6 +138,12 @@ properties:
     minItems: 1
     maxItems: 2
 
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      List of phandles to system idle states in which mcan can wakeup the system.
+
+
 required:
   - compatible
   - reg

-- 
2.50.1


