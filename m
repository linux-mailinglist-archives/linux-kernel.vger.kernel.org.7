Return-Path: <linux-kernel+bounces-869445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB9C07E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548F91C236D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CAE29AB15;
	Fri, 24 Oct 2025 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="UFGiBeRL"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C6293B5F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333948; cv=none; b=ky+Ad69WXCoYqhzU4QUM+oe5mtCK8LNGHZ7bhbJfpeCc126m9eTXVx7i28zjP1wVCzF5XiKTg8UuqJNSro7vuUHnPkT0HxL5+64yEgEVW1CmxYixMKMsVCr3a2xkaIZ2FEhf5x/wJ7xpEuAq5aAiLJ65fe+j25WCO+fV1CoqfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333948; c=relaxed/simple;
	bh=RA1HBJr1pvpGPQx/F/QWCM3HnULtIcuIEao9BpBXpjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdlefcFLpPvaxEVZrGF3ARTObTnOU4CXGTxM8h5TMkNoAJyrz2rVm7ijAawM+X3v19v36U3Lg4JxOmKTkk7fpbXItWAQ73usBAafWRVVVfS8igg8BHDqFS9ihkV7D7+gZDIYvEWdKzjTh3itaDOgzS91MVC4BljWKy1wH+42D7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=UFGiBeRL; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4e88ed3a132so29557941cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1761333945; x=1761938745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvGYViK2JagPLVRvTto0N8MsPE3ARm8sobByJt0eGdw=;
        b=UFGiBeRLJsGyrAi2uk/s6x+LI2a/Orux20tB9ZOJZPVvabEAuruelD/PETtGEfRxAx
         +xYGlCEZkOcrct0bQnguLB25sqnCNNIqoQXejOcErqUhj4q9O1Fe8/7s/bWKCOJ7SMyD
         Bi4Hhr0gR4cLmxVLyMaMYkkD5IFHhxGkqhCZ6Xi6bRo4/8JoztBT+WWx7SI828mOyYIQ
         IR6aX5WAVwmymqW7FKMoSf0yqWfx1ct8f5A9bLog4BaausiXoyNqveJjCmLmM2wuZYXq
         uSWB4K1YfQ2g4iVY2v5FkSnw6pFVFjQJV4fp6n2JA9IZ7W3CQ9vC+25hEWJNQid1z2X/
         TIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333945; x=1761938745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvGYViK2JagPLVRvTto0N8MsPE3ARm8sobByJt0eGdw=;
        b=ZRtlNCZ3g47q0jG9VyF5Cw76zsFFxGjFcsSA2m/8KN0XPY845dxFERrtSIqx5Us1LB
         Hx4OB16KN+vAhEKQIV5mxCwspBmtd9KR5fYzmzgseApCqK4b+V4MrWPAwuPXddKpUzLV
         kLf54G79d8nWTemqyQ9AjAV+h+SVA9bEHEl9mHTWdnt0GNs1RhD8R1x11HqtfqK0bHnk
         nTRPxOfImLjLvhkfIUtJLunWJX8WRfBDQeBI2JYRERv9r7gsikhIiG1iakcaAXpa98yI
         3MnPq21tMg+KsizyolJ3PQ1JhMUk8etPmU3JfHNpuhW7+PTR5osAkYs9lTBc8eWMOg+B
         ZivQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5tvB2gm6kkKGfJ5l5ZC4QtjiHLt0f0gufo9aSKUWFh0nfSEuDWpoZaKU8+hjU0jFiZuwt/6pzMWEjn2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAfIl9pZudasXm1x1gwLkT0XV3fxJv/v/nTVOgW8SKUXoNhZq
	wffI3nnwZKZjNBojh1fD7ZbBIMNrCi3lRA+XPhWnhmad8U2vrONp522S4sSeWa6+XSI=
X-Gm-Gg: ASbGncttuGnn29HzP6ZHottSn50G5kaaxiXDCSySE2dCY6qRw06yPR04Bj0pB5mvgy7
	zcJZMl1c2twCY96VrZiqwjVAHF+dcXAxj9bFoq9Q3odxzxgNh7O5cbsetGLWkVohDB2mPfM6vH4
	oRRcGImrZg7CnCZslQ/LbEgYKOHelwL74q1EZ0SLcyEgZwkkOaV99ngBpXTJRlO3kVBD7dGFcSq
	5EjVy89CCJR+W7Z6JnrUS7mol1Y9SnHFLiwcIqyP4H4mAWUJbhBXS+gDB+ET7igl5Yx+67KdMrE
	vKahMZrRntjzzxJVQj39JBBpRsLuCwpCic6Hbe1i6yX5SNIhWBRuQDAMP5wcyE+/I21IN82hxlm
	Jo/NSQ/mmKJ4imUL6Vvx08tjuOkSGmJk34GTKF216+KtXSv8688uCpSLG6kZYmubiFfoOhDqvmy
	9YVGFM/xtyPEt8rYETCK+nS9pWUCk=
X-Google-Smtp-Source: AGHT+IHWqTqM7qpQwb44DeW10IvVUPdY02tQLEZoYK1mvAdCabWKcBGvVJZ0721R/SqM+DcQ9UDPhg==
X-Received: by 2002:a05:622a:1:b0:4e8:8274:5efa with SMTP id d75a77b69052e-4eb92abbbc3mr51602341cf.8.1761333945392;
        Fri, 24 Oct 2025 12:25:45 -0700 (PDT)
Received: from fedora (dh207-15-125.xnet.hr. [88.207.15.125])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-89c0e97efa6sm438239185a.24.2025.10.24.12.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:25:44 -0700 (PDT)
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
Subject: [PATCH 2/2] nvmem: lan9662-otp: add support for LAN969x
Date: Fri, 24 Oct 2025 21:24:53 +0200
Message-ID: <20251024192532.637563-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024192532.637563-1-robert.marko@sartura.hr>
References: <20251024192532.637563-1-robert.marko@sartura.hr>
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
index e0d88d3199c1..d88b917889bf 100644
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
2.51.0


