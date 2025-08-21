Return-Path: <linux-kernel+bounces-780258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E37B2FF60
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC9394E4A49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822EF27E7DA;
	Thu, 21 Aug 2025 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjA2DRMj"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572EA26A1C4;
	Thu, 21 Aug 2025 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791850; cv=none; b=SloFG2la6sutgIP6IAYFp5fE3EF5JqI3uWEl9j0c9LfUHCRwBekIBF59hDcoq9CSWcSjiKr0vnEd0BciaATJcrGi49/Lix0hODhXfFYi9k4uD/8/cawNGcnVxOnHk2WvgefPTF0BNHyn2IdcCpBS+M3by4a1+Y//u/oF4A6L4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791850; c=relaxed/simple;
	bh=svMsQbdVjQ089a4loHQsnYthHi7jkbh4sKxZEGMZ2G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FcVB87uIyzpeHcxG8FVNh95aLxjDAM9DFgOKVdT0belz79Zl9YzT2WjpH91NMqMokVMX1ACachByZj1Nc9/qQpr6HbJAoR9ThRL+RH6w1oG0tbdKwBpZzzU7036df+voIzlFXZo43ldDhVYyQ+32x6xTcMeKc1+qmox1PLA+zEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjA2DRMj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea79219so1453132b3a.2;
        Thu, 21 Aug 2025 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791848; x=1756396648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=;
        b=jjA2DRMjqJX/CawUZgrFcKK88ledbVbxaLEi7PIetVGHcq9JpVoMwp51DOSECapAND
         O/ytwdXDM5UaJf8UvPB6oD3TvixPVS8IWZeNKn0RaPiLDxqdUtCV8qCm2dlIezxI1bZy
         ku1zqtbN4RLDUeghnYtI/ru8hKH2puJZ2zddromdjumXPCa9tKL5VWRD1GmYk9Gct2EA
         Lh/AG+BOQpIm775kf34BQbC4AZMHSGKzybeS1WiSSDbVxUQ8sz4OB/+1izA23r8nT3Da
         Zz7096fedp1FPgSJ5Q6v7k+tGl8X8YGjj4KTZ2uu9l0imW8mHUhv9aACkmgMPZs/c4U1
         PHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791848; x=1756396648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liRBVRNyAnOklnxAr3VQmJBjVpYUwLEwgd0SLy2njow=;
        b=j1/eKb2EBMstJSEGB/UJom9eSIeWDKN0Rt3lSGOdljr2aCzPjmPmMiPreT8P+snZ+R
         vwK84J9shMUoOP6TEHd4s8fmImsBH2LAFMj9ijEwGB35qioa5RkDR5WizRlwhI2j4u/b
         AY9GVpeMk0lNFS9wTxfB2fnXb63duQU+XzO9ApFSWMOTCOiKEl/SUWnzVMPjaXu5sj4j
         XkZTerz1tAgsGtzXEvBXotTinlOykHdOtwDrPTMhYDBrbZY94/9JyBeLgPJa/VkcZ748
         5I7WirDNC15yWkD2Cz27tYTo3uPzKuIyhuH+8oGiJcky6TKGaBZA/u64vV9TuZY4J6Cd
         rHkw==
X-Forwarded-Encrypted: i=1; AJvYcCUb3X3k7K/MZ2PqREjJEmvSG7BHaXpyhrMCq/ylaUWzoxIDMkBZ12awkd4h3m0+u4zpxbVkgca6u5vk@vger.kernel.org, AJvYcCW6shSVKZaLfEycoLGl/h2HqiZegxEhpppt+zo3CRVWx0DncOy3PpuXfraCcy5ucLLMJJ9ofIFm21tb4A5q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2ZpFprB2JTlE80zrXxM20PU5QkjyCrRSH2u8/6tRMlUI20pP
	1NQ+icV0rMUMPC8MLMgiAxCG1YF3EaIGrnm9dgr1pbbSM1WkEdAtJXZgXnCS2Ce6
X-Gm-Gg: ASbGncu0biVejHvb8Zcsy6lQ+xeUrUJIhi2RRjz0lRJdKEvdEaibNucZ8SKiefZGHmB
	vRVTaQvgBKDfpOk/aP0VX3AgO/e/9rTPYXQI9CXyy5Ro1XAGDO8SrIruNJtkmxHVwqFqKc0U6Ek
	L6OPjLpbnTNgVfWjn1ny90C8xql+Lzg5tJ1/39EhQuCCqH+Kv1NYjg1IQMh/YE1tAvyQyXslcTi
	mzhoEqvyw+NF6M1X2ncfzdVNv1cdCrVZ3DQv83N8wcW88pBUKBRtgodfNZCI1Dnbd13/Q7ND+Jp
	UsMX1gIkr1H0xHllbhXRybov0XgFr5O895uTHVTx3IXGLPpNvt/sYkrWA85T2GvDOUUSVzhIv+o
	XD8XHmkM+pdM1tqyq8frGuSTTih51lk4m8rLr3zF23fYr9/k=
X-Google-Smtp-Source: AGHT+IFJECtN2JBxWTnx/B5whjt3GAKIljMS7Cdf8bpeBXhuCcAUtRueDJJA33kBEPKfW+AfsuryVA==
X-Received: by 2002:a05:6a20:7349:b0:23d:ac50:333e with SMTP id adf61e73a8af0-24330a6922bmr4449826637.43.1755791848470;
        Thu, 21 Aug 2025 08:57:28 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:27 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:39 +0800
Subject: [PATCH v3 2/9] soc: apple: mailbox: Add Apple A11 and T2 mailbox
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-2-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUsDkeUyeY8L8Ri1VshHhDwApV456m3+yPI
 5Fi+gqjcEeJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JPpqEACU9bzBFeE/CYD4VSK97ziuAegkJJYF/LPx5Ws6y6IIDDAhrhJKUyNxTI6OpltFHUqA0F/
 i4ANEHT/uMb2Y9iJr9Ydp6oP6s6bex2+Jr/xYe3OtGPO1cWitxqEhUORWZ4qViICtbJ6D/H6Cwz
 CZ2+GyBHtn6vggUsNFH0hJMJ2h32eRNBlP8i3MRI1k+RUasl5GQIQLwMRhlVuUJ/1mdkqzIqKEm
 0PiIXBv166RtN0aWa3cC/3Ck+vuK3Lc5pzpj1JLM6hyDTW0Xmhq7j3gR+f3GF+x2B2vQ+/tccQd
 Mn81SfmS7f37AcPsh1PfvmHs5xJjOl9T6ryDVFNIwxMwpPGf++ISMkgn0zvwj9x9jXfbhFhBiMn
 nCSOWlAI1/q+2hn1lbgtdVM0b4ZNWcoakAH9CVoOWOU47okzBVXfK9FKlCb86eYryM2KlvXfCez
 5utJZjQdIL47aXWOtrSh8U5avHWRj5Ondzi72vl01s3g9Kn4tYOzFh2g8mc90aOhgR0yUTYtycV
 bAn2p4vHQfOJZqLv6hXlzIyp5ROriNbr7tw0jaFRYtk+uVIvJr5/asLUQBAE2DX6J+XUWHr062o
 cUfoL0d1tyLIFPSuvZ6QstRD7eGGBfpd9g7IGp1eRPz5isuWprfzyC2alt+VrBhp7kmyErDogqW
 Ktfu26RYg2uDigA==
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


