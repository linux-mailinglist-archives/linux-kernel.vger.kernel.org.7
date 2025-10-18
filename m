Return-Path: <linux-kernel+bounces-859003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E52BEC747
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1DA64E99B2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369D2459E1;
	Sat, 18 Oct 2025 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWKywFiR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E9A1448E0
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 04:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762122; cv=none; b=dDsvPadsc7Y9jrMDbv46iuhEaSC1cnTAM2uedbxtXONYiigkrD3lCiHVF6y88nQT9lkI3lEznpLhcyJmmI7mBtFR2VN+CkwyxWlSer4/oIRKdVrjVNR7Umok8Z2UroMpQq7+VaErLNDetgcQ5PQAOzKibbmScJ2iWAM9ItPeaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762122; c=relaxed/simple;
	bh=IRlElH/s4TgwQF25W5IbthX1Ni1hpN8zqJF38YL9VDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmBhTVuaajw/AlfLDo6y6syp1DrLDBhokyYP8DBxFWT3SfzR1R+gNUi2kYLf4Rfvq3J1/iyi+souZfqYt7lTGKdAgqJFjrwKDmxzl/WMzUTkX7bhzy6q69DEqHeszBgTR74c5X/RUSDGv8kbO9CfU4uCwYxxWG3x0jGXdeLUCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWKywFiR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-279e2554c8fso24762535ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760762121; x=1761366921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FwE+FlafPdFDMuivWnU+BJHVFOy/nLZHlq4G67TTc0k=;
        b=UWKywFiRFTcbr0WoKz3tq0jYWoWWEFA99sV0VV5grcfrEG9Grf4aalRUNbOa59XBBg
         93jiaJJiNNLcTumGzmCJWv2GO5fyaa50/drTB5k0NcxQkrgUirR6jHUhu+UgbT2pdKS9
         3PLWshh367KYrBkcP5qvsYwi50+RHVWBwfFfnjsbbcZ0F89A50J7prgVAz/XDACj51Gu
         yGeuTY0m6uEOaID0AV4JqFiuV4EFCMR//4bSiaCTg89lG+rAp7jnwUf4xOPPLwaRvLKg
         1rCohe6nTQjl0VHgodswC2cZIhROm2wyUcD7T8sL0FMEVkCXhRyA2PMkuTitIPrqCE5S
         pzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760762121; x=1761366921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwE+FlafPdFDMuivWnU+BJHVFOy/nLZHlq4G67TTc0k=;
        b=fqpujZ4flkEGzMI1GekkZj9BIV2cr5rEGPDRIdy8b7EZc10amqijChMl6ARZSnCmO8
         CHi5vIz7wUH7MpThkONyfnfHrs3M2WThruuABoFw6rx6pU8gBnjtjbLYoirusdIy5f0v
         xl6nJ4Sm8ZVuwhDfbgCpqyQPC/hOA/vAF9FBQtyCTdDDZGQlYMqzbm0zcKivQKD7PgjE
         O4O8yYdB0VJaziLaFGrofKz2EnUPMtfE8cq7zrHZYS8yFQ/EIfvMCrMMrXn5kRZKiUTB
         TYdVylQ5CDFSrpgEfTiDLJcVx5s+RxqgZgp5qhCHBRN0cj7o3jruW010jqfqIscXbEib
         Kc/w==
X-Forwarded-Encrypted: i=1; AJvYcCU3HVlf8Vvem9sOPxba6qRcgJBo6UMt6A82EFLbwE0B1YSqPiSbLykxbL3zU2NcDJi8AHXPgYv9k9TeQUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKm8A+9DkPhABQUBgUb7dSybVB1v3oIenr8LoiCQ9iWZl6kr/X
	ZIeFRKGccfiCb+pPUrrw/K5lBLki+lqqB5YnBgC++bXEiyKpsC4Eow66
X-Gm-Gg: ASbGncueRgSz3H3CYAxr8nm8vxm4vfCi6KeldkcQtA+rv5sMa/tGtPvubDtNqF59Jnd
	V0Qsxtb/TqFcWCZ3r25/9fHDA9Z/TXu9RyMpz9VX0nCHkXKci5xyrlYq/eyc55znsz+yfNTeZOm
	N5QJ8MHkgSlly6vrcIBRfCft1rHCGqKe/QM1S5BEjS1eb7mrDB8x0OaIbx5iFJao2BAKw5LpyZg
	5kMlCcJjd7swkHCrb+WvG8uYWRUDgh9c/im7XbVHorQ0ZrPtC0i026CcSstA9j6Z+i2ivERf4bx
	8P997QesT2/g1sJnyo5+93+MpfW94rYOdn7BiRcd7Hin4i8zoXdjs3R0rT9eR/Kr1d3ZzcqH+ms
	eoNkPwOAbnrbYr/tp8531RjxQAHJ6K/3E7N9CxI7m0SEqn1+XoLwaFPiLyyVPsbI9ikkq1gxeOk
	iHZNUXnLLj9zR1onhoHTAhwE2ov6ZicYhzh9sO/JqXD9DHCCW4jIM6x2XH5L2XKcDuq2oo2taRF
	dmE
X-Google-Smtp-Source: AGHT+IFjj+JR7R/Q2O8WxGOAy+zB1ukpFPQ6elAKB9VmH+ImOjLf6iOrU+WTRyaZ3nV4hWJdz9cmxA==
X-Received: by 2002:a17:903:3bc4:b0:290:b131:31dd with SMTP id d9443c01a7336-290c99aa9a0mr69186125ad.0.1760762120750;
        Fri, 17 Oct 2025 21:35:20 -0700 (PDT)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247218eafsm12167715ad.101.2025.10.17.21.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 21:35:20 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v2] ARM: dts: aspeed: bletchley: remove WDTRST1 assertion from wdt1
Date: Sat, 18 Oct 2025 12:33:09 +0800
Message-ID: <20251018043310.1056032-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the external signal configuration from wdt1 to prevent the
WDTRST1 pin from being asserted during watchdog resets.

The WDTRST1 pin was originally configured to reset the TPM during
watchdog events. However, the pin is incorrectly routed to SRST#
on the hardware, causing unintended system resets. Since the TPM
is not currently utilized on this platform, remove the external
signal configuration to avoid the incorrect reset behavior.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 24969c82d05e..abdb1562115a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -1080,11 +1080,5 @@ pinctrl_gpiov2_unbiased_default: gpiov2 {
 
 &wdt1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdtrst1_default>;
 	aspeed,reset-type = "soc";
-	aspeed,external-signal;
-	aspeed,ext-push-pull;
-	aspeed,ext-active-high;
-	aspeed,ext-pulse-duration = <256>;
 };
-- 
2.43.0


