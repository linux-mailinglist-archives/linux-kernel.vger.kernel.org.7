Return-Path: <linux-kernel+bounces-747485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5EB13461
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C7318974CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0417C2222CC;
	Mon, 28 Jul 2025 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajkTkCPM"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132E220F33;
	Mon, 28 Jul 2025 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682186; cv=none; b=i3IVgtXRy+rdE/J8tkf6T+Zbo6IE6cV5nQvqp7Z/v4qlxV4v0QdObgEWdBl/1YKE/fVPmVtDrwctmalGNCCQxFhOhl4LSRqJlFtZpdXEF3U9tGR189461wtb12U2e86Ng9NBwQxWI2pkckRlD732A2prpH4uTm2SLL+UbWsWXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682186; c=relaxed/simple;
	bh=AlJNDxTloo8N9g3tzJfIzcjWNUgaaZy/6lUZ1fVbrhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHyyXmsKMf9oZDswjgpQEsf1vckdd3cAwq0l263pqH+b/4FtOBcs7Z2VM5h5ivYdFtEWkJ84MCI76VOxDcdv/ew8gbpRQo6GAGVlwW1PqMrN/hBEeyvhSpugUzBk5cVE8I2eTY0snGUQvIJedA+9rbPv5ILqL9kce6oXTbN5iWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajkTkCPM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2403ca0313aso3193655ad.0;
        Sun, 27 Jul 2025 22:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682184; x=1754286984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vkeH24+gNLlbvhdNPWZDqLWHaKhUsYjVBX3EEgueV8=;
        b=ajkTkCPMwMo6J51zZuy2ZKDmnevhaIF8uTkvXaATYtEDkksBezTz5VkRLeq1NZsqdn
         CcQOxamkkC6sDZMSo0s+Wlq1QEGo5jQA+gEmdSYAuyb0l/ydjr7/ZPtOCKQwehtGFJJC
         zGA4CE3q8mPUsQQIO+Aovm2ZtIvJHtfT9b2e6DRGhFSgqcYCHs+lpnhwrCnGl5JX1nL6
         7Mulwh8e5DmUBYnl/3UHEJ+ohWEnCEXIkvkOopWa3JgH1dRfLEpdAHhm++6LfzWXggs9
         i6DRHBYIILWPmNCiXu5nfov5rmx1tjl9vE7YrMk5qifFW70OHpa+3iDcJxDaJOtMMQg7
         DcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682184; x=1754286984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vkeH24+gNLlbvhdNPWZDqLWHaKhUsYjVBX3EEgueV8=;
        b=i0nHjOcD5EfYIUq2CERdnetNxmKaAJQ94EjSzdSvSdtFuMfgbFBcB7048PVsWshrMs
         cKbzuRNY8watUwX8vn3VlBS6QhEvG4RvAfRsjC8fF1bRcIA7GM5jRL+GsaXRTeqUcyei
         aTaRvece5dNrpbAQVIEIu/CKUnmfwd1iA8QLz+xYOvu9brZj0O8aIo3MuNuRZDxQQwhi
         8xHWYI1Nu9EpQlKyBrslJZFz1BOV0xs2x893Gu6q78B/NEJfbF/6CGbLkSCCsdgzlegw
         Zs+/uwssmkfKuInSMhrouV4p3n/uGSEBbxLioTsUlZVbaYQGsp7SVqVMP4dRW9/ePsao
         ZaLg==
X-Forwarded-Encrypted: i=1; AJvYcCUzKxX4mpF1x8JmNF8qZhN7y2luO2io5vkQ3DScPGxbWJbuMzOWHMz+WdCttn1GUOhFWJGorJjC99to@vger.kernel.org, AJvYcCX1glf2jvrfTx0EXbz9B822azLWCwZTZRBhHIeMv8oxYU3CFkTB90zKJavksd1UqzvGsceG53KxQKtUfHFR@vger.kernel.org
X-Gm-Message-State: AOJu0YxJVbEFA3EhSd+fn68zSS1Ht1Fshb6NrxjOf4jnjy+67J/VBh1n
	LZzJvyp05mQvUD9l8Ns2KnWScYzqHZFoYQr4HIy0tdyAr9n3lUClIe8j
X-Gm-Gg: ASbGncseBzZ3r8M1LI45+okJnT1XnTJAMiqvNawgqDFFjkzLUEKrNCg/pexCXXJR3yR
	t+Eoe5f1zaS+mYDZmIa2CD98CxxLWudw5L4JcdVZFIK4ebfw9S6aP2mBAmNRla6PvFPahgDgQCV
	YmmuSCZqFcNVbb7tFAQk9hTU67Ddv0IBKdm+XyV9/ONOTi5p5t8HrkA7jFVCPWnxhfWLdfBB845
	uLKSTHcsV1fLH199o9iBSRg3BcaP2Jc1KcMnFYcDsCjm+kf5XUJxEiWkpPGo6il1iX7nYq31HAY
	hbg75kyya2qKB1xkY4BY/jSeE18CADVp3hwSH3myhp8TVGmW69XHUUEh5rooB5rn83Iaf+FjqOJ
	zQYlJZ0+X+413edMK/K41N9L5zNmn1LThPvuuf/hC2FnpTCD3ZM+FXPsMckmdAwna6QMUbtXANa
	w=
X-Google-Smtp-Source: AGHT+IEe4NPcl+6E+41WcJkDUHNM9DOXgmDHX/lVp0PVK2XqtqJdjesfJx4tkgXmB0ihpgb06l3TIw==
X-Received: by 2002:a17:902:d591:b0:234:d778:13fa with SMTP id d9443c01a7336-23fb30ab963mr126148285ad.26.1753682184183;
        Sun, 27 Jul 2025 22:56:24 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:23 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 01/13] ARM: dts: aspeed: wedge400: Fix DTB warnings
Date: Sun, 27 Jul 2025 22:56:03 -0700
Message-ID: <20250728055618.61616-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Fix the deprecated spi-gpio properties in wedge400 dts.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2).

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index 5a8169bbda87..3e4d30f0884d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -75,9 +75,9 @@ spi_gpio: spi {
 		#size-cells = <0>;
 
 		cs-gpios = <&gpio ASPEED_GPIO(R, 2) GPIO_ACTIVE_LOW>;
-		gpio-sck = <&gpio ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
+		sck-gpios = <&gpio ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 
 		tpm@0 {
-- 
2.47.3


