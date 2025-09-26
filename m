Return-Path: <linux-kernel+bounces-833840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4172BBA3308
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB913A9BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F6529BD95;
	Fri, 26 Sep 2025 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck3dFJNk"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBA626C391
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879465; cv=none; b=lXkptjxChRDLw7Z2CQsdOzRIhxbyU8twEhTXiI6GMv2PJDDgM8iyyzV4v1mp4FffZLyieKmbTmg7oq6bzImsNSGDs8rxKQj9rStMfVjRiXWhW3jUpDNUSA+atiX5eQonw6K/pTvoDcYDrzhSJ6v2Aqf+kmKt7Sr05niggfYKV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879465; c=relaxed/simple;
	bh=thNDQviaGyibFyGAqfP3goBA/6Fj0do4LHltc3WJriE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FW+qm90cNK9m73dEBneg1HDRptltmbSWtZqAQLjexl5FGzdZGeTMj7ZA7WkdIrJ5bQWNdeCDgeH51PePFY1AuXGMx4vVaQT7zdqi0dCpVVOrjg3NWLU3OIQ0/IdAO9TDpKQb5d7BYsHo6oXswgUBDAwudNjDLbYIO0vd5DmcAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck3dFJNk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3304a57d842so1543043a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879463; x=1759484263; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UoStl/6O0pPwy/s/NQABzja2ZbIsUSjfUYP6v+Jyo+o=;
        b=ck3dFJNky7QlQciS4HTNzG1DlsB5tGbjBlMHPASTFEHLWDwB60qI53Ciqdex2xK8/t
         GxJ9Ak3rRgjn/cdsFpDQnKjUADg8OqjtwTdsd+j0vx/5WO5CZ/VwpGdUnTvzvq16jsEZ
         FTbSwMUaz01lZgzxW2agXsNEJRh2+fkP/ImQAl47h9F8q2sGDrtNpHzs4pLF8ZhsHc5Y
         Py15NnJY7Go/85d4kmNwKLFHelCOroIkkD9tgGBB0brgCEbyUIhE+iwDddnGWXSYS5Fh
         o+2dabBLXVMdGMDHuTeLHgjf6jHSoAxJ8/xFYzVI3nG8yTtjU3fVPYmoBjjfDzWcTyg3
         1Ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879463; x=1759484263;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoStl/6O0pPwy/s/NQABzja2ZbIsUSjfUYP6v+Jyo+o=;
        b=pABa9NvdP8ep7d41j+528/vAT0QJ5Emw99TrxQf4BJcuQupe3gjXouxOPPH/xRoLFS
         3JbJV03FdVNhFHGALByrTW7s4BaIZ7Ekfc2w9ELLHfvodWtPD1smKmxP2DnJEtOkkjCc
         5P3IVO6qY4I/PXgb3PQPaDVjuhx+gkvlK979TLwx7nze0bOF0dYkWHc5Rj5iwZPGto3W
         7JNKfJLEXK6uD97G6vaSVQPIhdWfIN6G6NubPZE5ubDc0SUXd9UveneXXrf9Prg80eRw
         mOxhNC0+HEGUHCi32kp+760//kOoG45OWKbeD6a2NN0PYiJ2mkjZRQLe9k0rsFzkM4/B
         J+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmLIzv6KbR2Q/PJ9g5Pn4PKdHUDfksvghrJaqcRadvBp0AbRZ+1w/gPuIjaDkgk/wtthRQy9RKPr704O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykx5zi4U3witO6xEuFbyd32in+CezRyT18eGmFr4kJaFUmQONu
	R5qnDifZmMR/S2Xayg7bVGzeNJLHrLQx5qRySC9EtEEpFEoCuOFgRtC8
X-Gm-Gg: ASbGncvrAZGIk2YX0iVBktNjnFWJCC9bhKAt8ucQiFrQbKH/RY2aeEJW9M11PNm6bGU
	3i+9GUEtHpu8aH1qfro9WNE8TdUyUeVuNSF8Z0lbzUflfhM1forxPZE9VJNg0u2MhIsuwBtIthB
	LQiQWVALd6HQ5pTyvFSR20/gud2gy9Z81XriQ3XAkzudsRPBZ9gJKSLp7FAW8F0uvq4ZqC0zZhu
	ASCB57t5tVf67PugLh7LMZXfb97hHptL3Ky06ImI9YcAm3Iztx0tHCUst9o6NtJ0K+Qokn9USR4
	STO7OLTz7/z9LXXTGob1rd533BG6DtjR6leJK0o2vmXUPRBohHGI+nBBQ1qWMXIO/k4kbI+5lo+
	9ENkO/LisXVtDVeDyTx836iOyiuxf2x1zzjN3piri74SgkF9CSAKyYEN6qMM=
X-Google-Smtp-Source: AGHT+IH2wN/vTNpoB41B7wJ4UIGDQlG1DOtuFCeTQt8xZvPtyijptE31fGlsQRHND0LCJie+ahas4g==
X-Received: by 2002:a17:90b:33c4:b0:330:8c87:8668 with SMTP id 98e67ed59e1d1-3342a259df0mr7079061a91.14.1758879463298;
        Fri, 26 Sep 2025 02:37:43 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55bd160sm4211056a12.47.2025.09.26.02.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:37:42 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
Date: Fri, 26 Sep 2025 17:37:29 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: Add HDD LED GPIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-leo-dts-add-shunt-resistor-v1-1-c871a68792f0@gmail.com>
X-B4-Tracking: v=1; b=H4sIANhe1mgC/x3MSwqDMBAA0KvIrDsQ06rYqxQX+Yw6IEmZiSKId
 2/o8m3eBUrCpPBuLhA6WDmnivbRQFhdWgg5VoM1tjOj7XGjjLEouhhR1z0VFFLWkgVN8O71nIf
 OB4IafIVmPv/5Z7rvHwEMnJFsAAAA
X-Change-ID: 20250926-leo-dts-add-shunt-resistor-0cba43f75bce
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758879460; l=1436;
 i=leo.jt.wang@gmail.com; s=20250618; h=from:subject:message-id;
 bh=thNDQviaGyibFyGAqfP3goBA/6Fj0do4LHltc3WJriE=;
 b=T71P6S/+uzqAe2pm19qHzYoz2nhygnZpGVvbKLhyWQcQWVsDSelLeccTY+VnuA6uzE1BPL8L4
 Lvp20VxcTRFDYgHucePFNrm13q3hBU7efTHRYQ5iBAKOa87ktB1nm+E
X-Developer-Key: i=leo.jt.wang@gmail.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Define a GPIO expander pin for the HDD LED and expose it via the
LED subsystem. This allows the BMC to control the front panel
HDD activity LED.

Changes include:
 - Add `led-hdd` node under the LED definitions
 - Name the expander pin "HDD_LED_N" in io_expander13

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index a614f947dafc9a6628c3f3d45b62ff3ca9d2b618..450446913e36b1418fab901cde44280468990c7a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -95,6 +95,11 @@ led-3 {
 			label = "bmc_ready_cpld_noled";
 			gpios = <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
 		};
+
+		led-hdd {
+			label = "hdd_led";
+			gpios = <&io_expander13 1 GPIO_ACTIVE_LOW>;
+		};
 	};
 
 	memory@80000000 {
@@ -1199,7 +1204,7 @@ io_expander13: gpio@14 {
 		#gpio-cells = <2>;
 		gpio-line-names =
 			"rmc_en_dc_pwr_on",
-			"",
+			"HDD_LED_N",
 			"",
 			"",
 			"",

---
base-commit: c65261717599d419e9c683d85f515d3ca2261549
change-id: 20250926-leo-dts-add-shunt-resistor-0cba43f75bce

Best regards,
-- 
Leo Wang <leo.jt.wang@gmail.com>


