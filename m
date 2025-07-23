Return-Path: <linux-kernel+bounces-743355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E023B0FD9D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321825A118B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0826D4E8;
	Wed, 23 Jul 2025 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy+KKMdx"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F02741B0;
	Wed, 23 Jul 2025 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313428; cv=none; b=nMJy+iHhXVArIqkJ+xNZoBmSnkLCkQY4A9p0FhbfGlj4AiKqJ9c0n70icQPdEy7Ad9ET3QEnOdsm1zfYd/GBkvHEvXjqISxGpjpRTL/AVkTdEeO2i+P2ptDj6wc2XfQzPXYMq0xyM+YIEabASGOFjVwrKYJO6pCw02n+tAxk2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313428; c=relaxed/simple;
	bh=pvWVd0fI2f7a7cAI0R0Y8/7FqaC0BizRGiMWT5gC7N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWAKv8YFv5nIz/meEu8thBfWOyCnH5sKNqZqolQOX1EyaPxPDjf1FJ+6OUcWk+/MGX0PCrnXdbea6L2WfSnhbhtJOjkF2HZ8dY2IOY0tBkOQH2GE8f3tR/bMN1/Wm72Ku382LldPE9j6VKmmmfD+nRXYoso6n+7+BTJwARlwyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iy+KKMdx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23c8f179e1bso3763225ad.1;
        Wed, 23 Jul 2025 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313426; x=1753918226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkVzo5NE0GNCbJSinTR7TyExPK/C8GmZwMd+EFgVEoM=;
        b=iy+KKMdx5JBdlNUFLtDXkjQygxNyWMRHLHBvsRH+ifvKAdbLcQzes9XhFB89kPVb1t
         THPoZH7uRjJKDp4Vrgqz7OHjNt6UCY2i+bdw9AebE9zWcod4UhVYPkwWTFTbO+2kR2kR
         J38QWnHdsM4UvMe7D5R/dkTlfZTy2xFGlL8tn8CR7XRs9g/Dn7F6y6sloXedvzM9cxm0
         xSi+ND3iPptikGtTE5N223LabEhZ21H7ciy9tJzXG1ssZ3Fl6YKm+3r5JJZXKBOrwDec
         F6Fw5Z1RynxlRMRZI8zNp7mYHGZbSiLh/QSeszxNAWabmRQCfI16T86/LsQrURbvtmEy
         I1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313426; x=1753918226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkVzo5NE0GNCbJSinTR7TyExPK/C8GmZwMd+EFgVEoM=;
        b=gOe+A/rDoURsRaS2eFEtl+1Vp8LmHv9g/8M/6xRapfoFRYT6oeuNv99/vgPUDprWOV
         RQKbIfnydtoJhCt63jHdCQbm5qkiKRFbPmby6/eZ+c4nBaYteNlQ2or5iE41gHXh5tVg
         QaxePEsRWIAWUZKLNiSUZz/P4ewt20OpnLICyN2MWCTAToZNT5TlHueGfT9GGrSzxNfF
         t2ody7nYqSjmJXPM1VdWaAAZJ10e8yH250XY5D3pJOR4Voi/Z2kszZbjfuiN8GjxvUTS
         kpc9Td7NrWNjEBMKlu/sLlHSrHlFvCpEHRWCGwUzfD14bPGHp8P6GJRDMqsONyhve8BO
         8LXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtroHIVJy3FqtUUqFofEwM+XXe4H8lSzqc7x9zCVxxWSQ9mEQlkpz5JKBNknQ+LtTrj62rrIlA7bbIeCV5@vger.kernel.org, AJvYcCWYUVDB8nA14h9vNNckFlolYlosJoxRLWgmYBMY517wdxSp2Y9YgxbggJQqtR70Lw48DT7EhXoZjMHq@vger.kernel.org
X-Gm-Message-State: AOJu0YytmlxLQFU+EcvtXjE1BF8bEc0/KWY6GHz+Nx4qYdsmLoe8B5MG
	v1gnAlPNgBs0mdA3cGmeG9++PVIkSQyCEf/fQ/qDQ5LBFDkRdY0PR7No
X-Gm-Gg: ASbGnctzSn9if39Z6t76QtxoGpeO/z+75X6CBS7oV5nszsRSjjevLP/LQ6kN0RBXrNj
	T3z+4SDSAYJzUCcv8j28cypDNkfx98VK0LMkea5vDsuxyGtPmZn4IQlVeMOxgWzBSgJqgBXjv2V
	rqG5UW7GVMnfwvDs9qJDxKmzXM9RJw8ypfLHvo9U7yF69KYhMRQzespQII6I+iF3YM7djQjXe4T
	k+fmR/3b9v35yz9q/09Inw9nqcN0Vu21uVMdMuyVORfA6hvglguNpBVEcX9ll2G94FN5tFbfS+z
	6ejYj2xQpUOxCFVe5v3uPlQBWRFoOk1CP/EyIUO+pIgu9NU46FYiEP7J8J8RGgJNxNbV5mH9DRY
	/DMrqIRRnc989y0wqjujEPkfbYf14JTKJZQV7LxJ5pz/GWI1mHD92PBLGVgpMCyqbfIKMxq88Vn
	s=
X-Google-Smtp-Source: AGHT+IHzWqipQFV1rlMjfGMj2ZYctdbfed8wRJ1YF4iYb6xdbsKUiD0L697jJ9ynyQV7v99kSM5TEg==
X-Received: by 2002:a17:903:2b03:b0:234:c549:da10 with SMTP id d9443c01a7336-23f981d2e75mr67924515ad.47.1753313426507;
        Wed, 23 Jul 2025 16:30:26 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:26 -0700 (PDT)
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
Subject: [PATCH v3 04/13] ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
Date: Wed, 23 Jul 2025 16:30:00 -0700
Message-ID: <20250723233013.142337-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Move eMMC entries from ast2600-facebook-netbmc-common.dtsi to each
platform because eMMC is removed from future Meta/Facebook AST2600
Network BMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None.
Changes in v2:
  - The 3 emmc-related patches in v1 are squashed into this patch.

 .../boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts   | 12 ++++++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts | 12 ++++++++++++
 .../dts/aspeed/ast2600-facebook-netbmc-common.dtsi   | 12 ------------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
index 74f3c67e0eff..ff1009ea1c49 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
@@ -201,3 +201,15 @@ fixed-link {
 		full-duplex;
 	};
 };
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index 840d19d6b1d4..d0331980d082 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -1243,3 +1243,15 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii4_default>;
 };
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 208cf6567ed4..0ef225acddfc 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -156,18 +156,6 @@ &vhub {
 	status = "okay";
 };
 
-&emmc_controller {
-	status = "okay";
-};
-
-&emmc {
-	status = "okay";
-
-	non-removable;
-	max-frequency = <25000000>;
-	bus-width = <4>;
-};
-
 &rtc {
 	status = "okay";
 };
-- 
2.47.3


