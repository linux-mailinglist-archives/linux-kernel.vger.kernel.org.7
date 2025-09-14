Return-Path: <linux-kernel+bounces-815597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A1DB568C2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C13A73C9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9FA26E175;
	Sun, 14 Sep 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d37bmD31"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C19266B59
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853762; cv=none; b=O75ZE/ZENKy5877UwmB5yPhwamvKVMVdayzmvIhhB4XhmsJLozESLIy+iWywM0O7GuQ/lyOz15C46D2zeOGs3hd2wYCfw2Q/zT8bTxu8GbsTpp7k+oK+KRAwbM1TmcHdh2tM5w/p3DXeA7ZWs++WVeT8ovD1WPspdrZcW2d09MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853762; c=relaxed/simple;
	bh=XF2fZOZPuf6TK3Ja6tqEkOXwBn2O95DGQeB9O8Y0xMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ05d9FRIT9RG/rcNdw9i0K1OfkCnjcT+Q5wvzYlehd5A0sR+gQGSItGoYBJjDFAh3ioM8vpkiy/Am+pKAswcibbTutRKb2Mcnr+MeexfKlQpJpmOyz4X2tsmhdSEzdRlGG1NOU0kTUbvaY5aFIUPzfGstF4HrVbpWvakJG5FnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d37bmD31; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so2898955e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757853759; x=1758458559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL3h2k4pBCTkRmow4y5yXo+3wwdOgJcWXSzEovR09vA=;
        b=d37bmD317qyGBZNawxzwXLvWfUHvPkh6QbPiceO8BC021OePWQtyhk7BVDaXmhCl42
         ceGbsDirz142J1h2rWJORSNUNfaiRd8UIekA0ojNEg50nZCVW532D1y3zSX8FS9JDah+
         A28HiWiri+aYFCaIWnrXfhg5gJsxzi2Pk/almAqvbJ6W1WFzYKgYnhmaa41C1s/7xjVc
         YC9vD77otOa7VG7XQrgTxwtUBp7cLDlrzXK0gfTVIPyrdxdsJDfxz1Kb472vYFhtcNao
         S/dMMCZAq+zqOcJl4z9Nh2xVEzhLh3mhCOMsN517H0G3wHzT+HdNhk+Z5HcRER7HhFPv
         CVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853759; x=1758458559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL3h2k4pBCTkRmow4y5yXo+3wwdOgJcWXSzEovR09vA=;
        b=Qmw2NzjpkCm8njkJbTa1t0pQFJNZI62n1q/tgO6HFgCLnVxXeHq4HQM0Rb5CcAlp7j
         l3PSSqZc/PH9/3nJhSr0+u0vbE6NedmYBTu0VXE9oC9ohv8cVoI2APOZT3h9D7TzIgtk
         qx1DsiI0L3yFX/FlTF3AZw56d1C62Uqm/9a8y9Z6vYKd7mxNNTnB0ZYCrIkUN0xjuxlx
         EWC9FKMvAio9nWOXw1/2skkQJdEimo1P/yWi7s7ujjbv4jTUcjzkiE7lkDlk6hNucQgr
         FXKuIZs+R5IIC4Gp06Iqp6kWkkwYawDc+It2e6oYI8Ff1kq1i+pnwTL1rIabTdUCUtix
         JOiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3AsiutYh2aLOYkNA9WeCqp8wapphPqlpCXoxYnDvC/AFVus/Kgx6mnDvaKwF4zD7iroqvrZEnWf1glzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxszNPlMfrIIZvr/lNIZ06rgDaKf99Z9VJV56o+TxZH2bUnlWyC
	UkZlUiVxEdo2cyPAafFNedsqeJkuPev9Hm96LyS3EoEqpT/uiojvecIn
X-Gm-Gg: ASbGncv3Q19a49rZhi1zHUaaUaMSZuU94fcQNWF1/31WFfoRTqqK7K/GuwPIUjoYUBi
	VfYlKoUI95SlsdWsMuljwpK7BHAH+ZKTnE63vARBnGB9GzPpo9ywjIKpuAsxDpSsKhm2Z+M3bwC
	VbDKWexiZMLNxUMIEeLvPxUOlgMDdjzVMMdtLNx/s6IwNEVtxYLnJNHUDVq1L2mVF2isSPAKF2k
	oY6oL8n40AdfXjSNitoLyesN1t0b4dvRnRkY62CHZPu5LboFMpSaO9gdKAHD2bq+SpMv5LaQ2qJ
	rEqvDJtdBOLEIwvM/V9enDqhIZefKQxi0rc/KxPZr7RQ160Eunaq/typb4HGv8/1tdyeYVzxDLA
	bDkQimayUDU23fHBl8qlCP+wkTuTGCAalon3DahbO82YPSD/rAgKnzXdVjw2dNzkYXo1T6vZgQF
	KFy3ENp2yo
X-Google-Smtp-Source: AGHT+IFYosvL3hlqrkRZJH4U1D4gQFiKB/hkk7FIzmqQ6IP5m5X7qRfmT1T4W59kT9wKZJ/WlTy0JQ==
X-Received: by 2002:a05:600c:5798:b0:45d:ddc6:74a9 with SMTP id 5b1f17b1804b1-45f211d5507mr57562525e9.12.1757853759405;
        Sun, 14 Sep 2025 05:42:39 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9511abbccsm3727773f8f.9.2025.09.14.05.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:42:38 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/7] dt-bindings: mfd: samsung,s2mps11: add compatible for s2mps16-pmic
Date: Sun, 14 Sep 2025 15:42:22 +0300
Message-ID: <20250914124227.2619925-3-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914124227.2619925-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914124227.2619925-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S2MPS16 is a PMIC present in Samsung's exynos8890 devices. It houses
voltage regulators (38 LDOs and 11 BUCKs), an RTC and a clocks module.
Add the compatible string "samsung,s2mps16-pmic" to the PMIC.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../bindings/mfd/samsung,s2mps11.yaml           | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
index 31d544a9c..445596323 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mfd/samsung,s2mps11.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Samsung S2MPS11/13/14/15 and S2MPU02 Power Management IC
+title: Samsung S2MPS11/13/14/15/16 and S2MPU02 Power Management IC
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
@@ -13,7 +13,7 @@ description: |
   This is a part of device tree bindings for S2M and S5M family of Power
   Management IC (PMIC).
 
-  The Samsung S2MPS11/13/14/15 and S2MPU02 is a family of Power Management IC
+  The Samsung S2MPS11/13/14/15/16 and S2MPU02 is a family of Power Management IC
   which include voltage and current regulators, RTC, clock outputs and other
   sub-blocks.
 
@@ -25,6 +25,7 @@ properties:
       - samsung,s2mps13-pmic
       - samsung,s2mps14-pmic
       - samsung,s2mps15-pmic
+      - samsung,s2mps16-pmic
       - samsung,s2mpu02-pmic
       - samsung,s2mpu05-pmic
 
@@ -141,6 +142,18 @@ allOf:
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s2mps16-pmic
+    then:
+      properties:
+        regulators:
+          $ref: /schemas/regulator/samsung,s2mps16.yaml
+        samsung,s2mps11-acokb-ground: false
+        samsung,s2mps11-wrstbi-ground: false
+
   - if:
       properties:
         compatible:
-- 
2.43.0


