Return-Path: <linux-kernel+bounces-773190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DF7B29C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3527F172D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391963019D0;
	Mon, 18 Aug 2025 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WErQeEiM"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0130149E;
	Mon, 18 Aug 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506618; cv=none; b=sx7eHRj0i0t8iC/0biUj4konVuQS3UJo1ngNUhTPXR5rKc//Tud/JeoQyEwYQEcAK/4hRyAClF8vje86gdxJXM1tXfc97Nyig3hYSG4eCWzJkFhi0jJWwExKM0PWWGZHbSdlJsMxnvNAf0BQvXZ8LYOFnZO9SkZ5egDaKK4xxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506618; c=relaxed/simple;
	bh=svMsQbdVjQ089a4loHQsnYthHi7jkbh4sKxZEGMZ2G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oEkSuIMY9dBs/0ulSP0ylUcXokE7sYq9oN2BcCPfk6yAOuu80Zds07KRZoeg5uuYAa/z1k8IuCJrrBFUGOzegY11gJt3120hukJDD7a8z7i3o5O2YJqWE33/S1Nk/fmnXcjF76Sh0m0AJ3tO2dMgestJ9G1FjJEsEQSQh+H6ohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WErQeEiM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24458263458so29661655ad.3;
        Mon, 18 Aug 2025 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506616; x=1756111416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=;
        b=WErQeEiMTq3fV/4ZuEZXQEvVKKNY3SMORIKcn1aOYaIoG93fMccD+E3vg5MliYeY0k
         KulxGvGNEf9L4jXzyoBZFOKutDCsAk9ASDpeKbliSeaKPMF9e8o7An6gleT8s2qKSxoP
         gqG3rtPdhe1NzEuKX9/0tTUVf0CJ8dbaLmAJ2dh6ugVOmc7yIXszn1fMK0iZjQawgYOd
         GVuNG6ArcFu+563NLfNVdIuia7MriPWTS+3CQQCVvC6Ik1y0TGwe6CNG+qfQ0yVIiijj
         Pr7MH0b98dBzapB9f7aDRpwiX24Iq/RO1Uo97voV0b22k0NWE2Ye+lVz0Wdth1UAy0Xh
         uNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506616; x=1756111416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=;
        b=I5q1LRZ7l0FKkWSEWdodKVxjKII1PWN/503Ywh0Dm5dqHr0lGrj5JqD3dWSoFAkZzl
         tfptS3S6zS9NKtxkP1h0WdnQwfL2U67ARaaJw6IeBthgskhkC64NMfaw8PtR3soUAol+
         DnQFLv9DjbW37V+2CAipMpOYzBQYKNeJGRNqLwF0pR1lbExCEZPnujCgULPDl9ve7R4h
         tKWJpiOd9Vh73UEpz8/+nd6AlL4V8YhF1KXA8tkPHvN//PLYJWUNi27f7XO97/k4J8/d
         Irp0wJxpX/tvN3zKBKCmIdL+3pP/9d9ABjfi8l/txg2fK11lfAnTDjaSQilC02Zpwxd0
         C7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW1G3Dno/eicFJDc9dIBSkv1LLwZ/vfgdH/gNuu2ytMtKmlVgQIdtiKZWqG7JidzXXbg3aVhTvUkLY/kA9J@vger.kernel.org, AJvYcCWXAcEevfUbMAAu17B1f64AtTZ5zpHr3nlGUPqBVfaxq7IaP1WcZgKIg9ON6XWokbmCulQelU0XV7lX@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFnyV8qxxb1UDQK+6tSYrJsbnytzfyuSWNrTjl4qPLedIHD3R
	rL3vfCQegOVGu+LvhRV+2f4szjnf6py7+KU7nYiCebO1yPWrB3B9Lndo
X-Gm-Gg: ASbGncv0t5usFvwmP6PdDQ119csm28H9oRK9FWRl4rbaBNZGIoKvyvr+m3Q2FbB22sP
	EeeinzjtLiHOusmDEOG422GiJ0wT5N8Aq2pRwSjX/xAnqSi55nW/sUAN+lSRCNUAx+XFyLccz2F
	5c8Ddb4jKHFqVOI0tlmCRKUEb4rI5nr/DYoXA5ka7Iner5GXSMyf4cQvFlRPnVioZVmuC+y/fiK
	jAJ1fc3Gi/VygqttaikF4t/i6IWpVKKcrsqkcZV68FjfULJW7OdcBSVfUorF4+l+1+iayqMu27s
	k3PoxXOcoYP0n742EGStsg8q6Un7ptWdgtzcNYXgnUohi00fPj1pbKSCyj1xVQwFgQn75/oMDMS
	sQ8OynowThm/W1/H+HJeJVVe09u4eBaByNUMby9gPoepR6tQ=
X-Google-Smtp-Source: AGHT+IHQuRcWK5Ty3gJ8EDDZyN29LLDBRSuplCA9CS1qObTIJotcC+MlRz8nfjoDQTZLml+SROaIIA==
X-Received: by 2002:a17:902:cccb:b0:243:80d:c513 with SMTP id d9443c01a7336-2446d6e444dmr157996225ad.4.1755506616342;
        Mon, 18 Aug 2025 01:43:36 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:35 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:55 +0800
Subject: [PATCH v2 2/9] soc: apple: mailbox: Add Apple A11 and T2 mailbox
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-2-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=svMsQbdVjQ089a4loHQsnYthHi7jkbh4sKxZEGMZ2G4=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouelfGGdkBgEHG0WSSN06ixVCaplhe9IXYpwA
 fSyXY6BH+iJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JKi9EACPGx5B4ynlooZmqJSOUDRbTtw86AQjMxJMrqdy5M9a1dzv/ohFAvFKQVLkTWDQJGsNEMT
 4RtdLI4zz9tUFdf//1mm/KicenY/m7IcOgEDsHpD9fQ5qBphjPm5/VZtiUt5L9xi/3rOXqf6key
 BNsUCY1kM46g4TbPTKnh4ztQMVoyI3jjBY3QQXG04K4zZfK5sTpDx2uVkk8T/yYbu5ThaAvHh2O
 VXctp72NYqR4fR9ANuln87BRqce6uRTZnyq9xZl4HGext90aQtMG52Ng/T1voOek3oSCvJgxbXZ
 4r+UePjqz77cmbN1N4qdjPql4Y8qemXMpHkMtGoa7ugfi5VDEbFVbVE03PKr424RqZBtOEMpoT/
 uflfkwncEWHHXVaYhT2d56PDjPT2sgiTEZhL4xEq0dTpI3fmtY/jr44Tq9+05EtAHuKpjAgHUP2
 1y5VX02TT6/BzZU1adsjPlFMHiw2013wQXEa+AStCGIv/3i9YJ3/Jsi0xhMd0b8qEEslubbK9Xi
 7BfSuo9xGQBSzPVXcP1GBtogu/XCbTQn9M/NRLy9d5i5NTdXKNCLqfoHMIqMN/39zgy8WexrhVo
 i7/woatmmUWbQU53nzm7IpIWuuiqTIFh5KOfX9Cb6eoLi4heaPFsp9vAg9Z8LCPASVZttAkn1Hg
 eKljbtns6nT9W4A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add ASC mailbox support for Apple A11 and T2 SoCs, which is used for
coprocessors in the system.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/mailbox.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/soc/apple/mailbox.c b/drivers/soc/apple/mailbox.c
index 49a0955e82d6cf5eef83e5f63ba8d31194c65324..8f29108dc69ac964236121d439e86c923a441265 100644
--- a/drivers/soc/apple/mailbox.c
+++ b/drivers/soc/apple/mailbox.c
@@ -47,6 +47,9 @@
 #define APPLE_ASC_MBOX_I2A_RECV0 0x830
 #define APPLE_ASC_MBOX_I2A_RECV1 0x838
 
+#define APPLE_T8015_MBOX_A2I_CONTROL	0x108
+#define APPLE_T8015_MBOX_I2A_CONTROL	0x10c
+
 #define APPLE_M3_MBOX_CONTROL_FULL BIT(16)
 #define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)
 
@@ -382,6 +385,21 @@ static int apple_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct apple_mbox_hw apple_mbox_t8015_hw = {
+	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
+	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
+
+	.a2i_control = APPLE_T8015_MBOX_A2I_CONTROL,
+	.a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
+	.a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
+
+	.i2a_control = APPLE_T8015_MBOX_I2A_CONTROL,
+	.i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
+	.i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
+
+	.has_irq_controls = false,
+};
+
 static const struct apple_mbox_hw apple_mbox_asc_hw = {
 	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
 	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
@@ -418,6 +436,7 @@ static const struct apple_mbox_hw apple_mbox_m3_hw = {
 
 static const struct of_device_id apple_mbox_of_match[] = {
 	{ .compatible = "apple,asc-mailbox-v4", .data = &apple_mbox_asc_hw },
+	{ .compatible = "apple,t8015-asc-mailbox", .data = &apple_mbox_t8015_hw },
 	{ .compatible = "apple,m3-mailbox-v2", .data = &apple_mbox_m3_hw },
 	{}
 };

-- 
2.50.1


