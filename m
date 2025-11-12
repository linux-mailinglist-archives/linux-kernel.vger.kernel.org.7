Return-Path: <linux-kernel+bounces-897252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D90C52673
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C6C3BB633
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B332C921;
	Wed, 12 Nov 2025 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Igt6GX04"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFEF337107
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952551; cv=none; b=RZJjZAHu1H8wMA+U4kisJCvJvzPrF1XoLW1+4dkEkqWC6HJm+5WleCLPKwHmaohaiMacOLRmfH27/IeYHqIELWFCOztlwniBRPhNhcXGxUbASGqpvPdf1DfHEM4sLx7FKjgR24J3KGPyqtxtb5eCxvJpprf+GUj6qFn1l7nevG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952551; c=relaxed/simple;
	bh=uTTV7+rhUF2ZOtHrUPfP83PWlSbGey69jgR92QKB/kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5dKhwzXTDlHRcSZIiupwyU948nyIVWnO0Sn/Yvu2WsEOTgB78kqMgxeXZ8BPjJwamVp1Fv4EUhJM+PhwOETDaJlr7aEaSphFo/KBY+74PrYk1sMamzGf1ObXkRyymc9044DrQyBRQhE3eRVdiKJLKghJpavP3jcwQ0FVSwmOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Igt6GX04; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-880439c5704so6317176d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1762952549; x=1763557349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvsLZmz0LO78fqlpIggjRou3geT1ERNSaNZfluxHnzk=;
        b=Igt6GX04ALcbyn7CP+bqqJSeTX6QTdinb4w47/rciJC6PP8KhqFsvSwC/f6d5yd4/t
         UfT4y5KLAu9n1SPe0usQYWneuh1k8vrRqJehkwQQPvUSc2zHAnI/xubKWYSn8pQkvsnM
         bA9sZgbbs3Ufa3dtRR39fy7RP4gF8ydX6TdWtHeLn+GU6Z8N1ESk75aAcSYv2NaT5gMo
         mEEDjQFzbep5hXD6669pjscm+4dEhEPH8JFztLyK6xXZOeoZJeWTR5gwI9fNv8Lgmh1D
         HRNjnvGgZyQw8tOLNuqP2c1rJ3OxlNs6GmPWsK5Zb3lAKGJLYiF9N6uCZItzFngfR00H
         Of7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762952549; x=1763557349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DvsLZmz0LO78fqlpIggjRou3geT1ERNSaNZfluxHnzk=;
        b=f9paXyIumkfllFqVXLyvJvxqHPSl7kVdpQ+tQbQZ995p1ev+T+PbaNcJxZ9brepNPO
         xB+sMxRXHWiKrUHbEwP6CFwHLpp+1CoOKTYjKW+Xy8GqKvnfuUX2uyYxmJ1jW0O5B+SF
         /9Ow1DeA2VsHqKzYbg1Mm/Imy/aocb5kbAF3dDeQRxV8tQy7GxKBhXbxsUc2kZxfi/aR
         qlQY9czTOeGlFg6/+IcFl/yBLPTeZn5uTRV/xwBW6kPZzdvqx8BwJ0meNlb/qiadKLI+
         FzTg3LVcbl72QDVB6idBrPhTmOXU1UVSQs/zFevB75qTGRhid+gnWDUkayTZx0s43/8f
         rVgA==
X-Forwarded-Encrypted: i=1; AJvYcCWlXZ878+0s3YA1XO/wdWrze5uElrY2gSlLHj8WWJkOyvN6Hb+UlGf45XLLFz6oj13gsGBy0phiKTQnBcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkMGH0+azlOK1R+gt2dtHrkePT49Gn1yq1UIWQNZ36jGauGIP
	CgWBKqYTRxkwMB+9NRV3qe9IwM6kWwHUZETMQCEWFh+ktFJyCs+6iIPTU4QrGlc+7VE=
X-Gm-Gg: ASbGncts1EanMDJaPj1hb6WjWONoDxqvhOVgRA3yxGqv8DwphnVzLDo3P5NAN4+nID/
	W+qkFOIdN+OyU3tSZTjmCrMksvVEh1rMtCPzjxLfUYnF2c6pgkrIgm6zam8NeOCyUYgVpwKG5mk
	Xxc/Q10RjuK/0yYeaNC161iOtYt7UhA0zriCl1Ue7Cr1gaSrcsxSxMg7+A/DppHQ8bz1Vh732Ip
	/j5K55RRgUpf+1E3XpD0v60/T2iMhssoAp0XVo15xBb1JWt78Nd06UMAOh8HgQcLKtw1W0COOFN
	BjutrLywp7q+wb9NqeynM/Au/bybpaYpzoQ0VBLz71rrXkXerwzfofgsglu7FMDO9QK7kKq2G01
	NyIYgAJUhPLJqMGUHjne6UL+hWM1gAZJ2I+sa/LRt+4C9ze5jBS17bXTNVoUfFtZUsMh1TvnXOR
	9BQuUSAfjBO8TCus4EOZVsP2tKaxTBqW/IkKYmyLBqeg==
X-Google-Smtp-Source: AGHT+IFjWeuDwAJVzwRl35SyG8ATem21JqZqKZhpWyLwj7K8kIHZDEA4crXgOAY/XP1AzQwiKS1pKQ==
X-Received: by 2002:a05:6214:252b:b0:880:501f:5dd with SMTP id 6a1803df08f44-8827192b57dmr42197456d6.14.1762952547098;
        Wed, 12 Nov 2025 05:02:27 -0800 (PST)
Received: from fedora (cpezg-94-253-146-68-cbl.xnet.hr. [94.253.146.68])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-88238b7499esm91362126d6.41.2025.11.12.05.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:02:26 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: srini@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	horatiu.vultur@microchip.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/2] nvmem: lan9662-otp: add support for LAN969x
Date: Wed, 12 Nov 2025 14:02:00 +0100
Message-ID: <20251112130213.842337-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112130213.842337-1-robert.marko@sartura.hr>
References: <20251112130213.842337-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Horatiu Vultur <horatiu.vultur@microchip.com>

Microchip LAN969x provides OTP with the same control logic, only the size
differs as LAN969x has 16KB of OTP instead of 8KB like on LAN966x.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/nvmem/Kconfig        |  2 +-
 drivers/nvmem/lan9662-otpc.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index bf47a982cf62..f182a7c2ff93 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -138,7 +138,7 @@ config NVMEM_JZ4780_EFUSE
 
 config NVMEM_LAN9662_OTPC
 	tristate "Microchip LAN9662 OTP controller support"
-	depends on SOC_LAN966 || COMPILE_TEST
+	depends on SOC_LAN966 || ARCH_LAN969X || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This driver enables the OTP controller available on Microchip LAN9662
diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
index 56fc19f092a7..62d1d6381bf8 100644
--- a/drivers/nvmem/lan9662-otpc.c
+++ b/drivers/nvmem/lan9662-otpc.c
@@ -27,7 +27,6 @@
 #define OTP_OTP_STATUS_OTP_CPUMPEN		BIT(1)
 #define OTP_OTP_STATUS_OTP_BUSY			BIT(0)
 
-#define OTP_MEM_SIZE 8192
 #define OTP_SLEEP_US 10
 #define OTP_TIMEOUT_US 500000
 
@@ -176,7 +175,6 @@ static struct nvmem_config otp_config = {
 	.word_size = 1,
 	.reg_read = lan9662_otp_read,
 	.reg_write = lan9662_otp_write,
-	.size = OTP_MEM_SIZE,
 };
 
 static int lan9662_otp_probe(struct platform_device *pdev)
@@ -196,6 +194,7 @@ static int lan9662_otp_probe(struct platform_device *pdev)
 
 	otp_config.priv = otp;
 	otp_config.dev = dev;
+	otp_config.size = (uintptr_t) device_get_match_data(dev);
 
 	nvmem = devm_nvmem_register(dev, &otp_config);
 
@@ -203,7 +202,14 @@ static int lan9662_otp_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id lan9662_otp_match[] = {
-	{ .compatible = "microchip,lan9662-otpc", },
+	{
+		.compatible = "microchip,lan9662-otpc",
+		.data = (const void *) SZ_8K,
+	},
+	{
+		.compatible = "microchip,lan9691-otpc",
+		.data = (const void *) SZ_16K,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lan9662_otp_match);
-- 
2.51.1


