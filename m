Return-Path: <linux-kernel+bounces-780260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 445EBB2FF69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A52B61BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C27528F92E;
	Thu, 21 Aug 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du4U08og"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD627702B;
	Thu, 21 Aug 2025 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791863; cv=none; b=kETdAF7eTgNeQ9GoWB/iSS+wvS3HtLS2OjuhWg4U1MyxOX0U0cwQTZJJAwkBb5yvhHSeadejXfmcgQuiXzUgoxULceF2qaZAAP4O6zBzbqdohBhDiqLYehpG9dyKB8V72eosgK7HIvSFUWFWDYIt3dEdgWo86OZtOzx0dv8nN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791863; c=relaxed/simple;
	bh=SfdgOsOFi3dLK60ZgLb2wBFpqlY1bGwIVMJiWwSGmDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEblOm/mxxoBvbG7SsRJTqhcwxLOiU6cUpLZ3ggvF8y9sYaEqux5+zbJAUePehBbx9NYDjHfVYRbfnx9aKa+RzttRX3MAFTR71GZdZeeVlS6ZlzysjU2qnJzaA+92qNYD6wuba2HcSuuXZudUsTlW5njBGhwEiufnDv87FExzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du4U08og; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2eb20a64so1389100b3a.3;
        Thu, 21 Aug 2025 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791861; x=1756396661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=;
        b=Du4U08ogHLVbAcU8tKLeCDFzhV9ivkTrnIeQEwsTv2bXDzl4+5UGpXPtqODPP0DSDt
         7R40AWiHO3P2yC7KKJ4zct8XmvxN6A9OIhXVy1EwJuZW/BpuJ1k1qrV2Idqkp08JX/YV
         OYO/fIWJ7j+RjtcrmcGnS3CD8IwWlGVzht4gW0XwZzwrxQFKdHkly9ZoSDVVQks3ofDj
         jeMgmzRhu27UFdIYq8jk+xoPVFZELFphUv5pWCiq2TVx7KuKkfNgcyhPN06FVSgo5PXK
         Zng6Ab1e/7Y189BcbCYUNUMEl4vUFie1mnHDtUYbl3Pbw0tcuhhW+o2bQmTiNOPiXiIe
         JfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791861; x=1756396661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=;
        b=C7/NhMek4wSacZ/P0o7j/QHwNiHthiibqRiw6jRQp6W8yKNGdYmmL0+bGNw4eiedHz
         2zyQwRbT4Jm/mk8qan+8bdALj1ZBYGm0nu76St75/e4xPLTLJbKBjNeLgJEyTqescbWE
         wsa4WCexq579eRoe9Mm2vQSKS9IrExbBN2XdSlWl/7XX+qfLDMF5lMRkE39lqCcq/C00
         0POltrkiFrfyDHmU+9J+izwVFxRyEve2G9wMwG3BK+6bIQsejf+JDZpSjlMHLTmgICgE
         xoh7Lw8Qra7PdIfPdwhVgzYg6OlES3k/ftRjyTqmF4tIb57tHDaBj9hN4oAGaYxUjMqn
         PR6A==
X-Forwarded-Encrypted: i=1; AJvYcCUm646iXVAj8Gfzzii8HNqmHS0P/7nzr3JWWPJeA4h4cKw6RrnEyAimlLE6O99dMkukE8fRXCEEkjFVymww@vger.kernel.org, AJvYcCVOzDM93UVkFpeWg4e4alDSoQkJJD4C3uu2fheJ9Cru6fjJQ4FyM+WSVWr4sqh/ODNKr6eRFVwGqMX3@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDbz6kl2iONVjS1r+qHt+kHPwRLRcTWOQkwW2wASy2/hj9PkB
	2WUSKnszCx8HjiBPRLBrObOWt2fmyyBM2BYr5Vag3twdIeXk8VcIjpFuPW6au5OC
X-Gm-Gg: ASbGncuZ3n5pIMincDubSNdIjTU35vvpFtItyTB4wJLm2+K3u8bfT0pFq4jXejVPvNs
	IuIFTcBHUnxqFaqoEmtJYsck+2C9oL61qoWsyDds0SOueN9uzSfVg5r5GlMh0r4cZrrNO24Pp5w
	btcd2xhEITIX1iixd1qUVjCzRMbWUogQMfPQ4ppAvJxBH5sFERI2FjaBynOLaJQ37f4gZpFEZ0m
	r5vjBTQRcB8iXAWXff26wGtkAjtwz3d3ddWzcrm7NyhVX8rqEP3imwynqGs1gsSfC6W2JhgF36x
	tbuW7Q39si25F6NN9SRaMY1tak4JjYdALA5PMz+fnf9M5BFnImqPtokzaFDs74VIW/DvErXcmsz
	7GWXe5LA/YfmBlUdJh+P6hC3Hl8ex3uI5SSp59bRoSnqxKAI=
X-Google-Smtp-Source: AGHT+IFaU8yhtF4FFIW1hpaOV+kXnGjxNNTFWVUFtb6OBi3B+EkjNWrkNm8/OJ6NhTYEe/kYZZJ70w==
X-Received: by 2002:a05:6a20:1594:b0:23d:68da:e40 with SMTP id adf61e73a8af0-243307ca9f1mr4413857637.19.1755791861128;
        Thu, 21 Aug 2025 08:57:41 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:40 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:41 +0800
Subject: [PATCH v3 4/9] soc: apple: sart: Make allow flags SART version
 dependent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-4-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=SfdgOsOFi3dLK60ZgLb2wBFpqlY1bGwIVMJiWwSGmDY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HU7NMtHnDkY5eAbeUg897zyDtXJql3NIamI
 rTb/5lcQeqJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JMYhD/49jIthH6VQtzMK6W2zDSG32o6Id0W/AMPYXsqaYqU5n8yIYzQxh+q4gahOIF/mXdloZTB
 93x5zyPVbtFwwBEkANe4rDpwYqUKuuVMYxpWMd0Oye0wcvjNNkPtVMIar/d5dXEki1gGBk1RnA0
 GuA/y2QzBC4jfmur40VswT4HmEvN5T7/HXdaE3zS/uxQPfhatEUWjC9Tq9/16CcVISf5TUWyWGj
 sWcLbdSRtRYpO5KSAbxkzSVsPBEVZv2i55IIpa4g2FWcHSTuKQt3jJr8/6FXlGuPsc2+rvswJEg
 TL2Zrs4nI9nqA+mHcYLzq8DqdnMU4AiMQdSEK9/6EwSgGm0nLPNUb8VW6JpOTQSsFSZTira5e9r
 mE503tlw9DVn9n5tteADeet1LcNtQI1GUuEQZHWI9hEgEAB0pw/4PNSVLz29tJmBZBljQwCC13D
 Pgb2Sob83ISI9pVshvulPR7iRRF93g4NLV8MWWLwXH1Vfy55vDszY6L6xoH2yIpUhgpYE5OqipC
 6o6lWV4MgMbdOR7ovpubJDs5BWviByBYSSazFjlIX80CKPeViTNDsM/mwEtGQXQZfbfpx9USdJt
 no3pwe4OfZiSOWPoG68N4c0PVc/LkhvUm0sy4KesT8v7HTk1ipCminef5J+BzFWxsX6JkNdZxJC
 9oEqRbSmCDAQ3aw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

SART versions that uses different allow flags will be added.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/sart.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
index afa11173689979f100a63221af03214f4a928a7c..318f6e518a54f6edb8b97e320519df8f77c7f143 100644
--- a/drivers/soc/apple/sart.c
+++ b/drivers/soc/apple/sart.c
@@ -25,9 +25,6 @@
 
 #define APPLE_SART_MAX_ENTRIES 16
 
-/* This is probably a bitfield but the exact meaning of each bit is unknown. */
-#define APPLE_SART_FLAGS_ALLOW 0xff
-
 /* SARTv2 registers */
 #define APPLE_SART2_CONFIG(idx)	      (0x00 + 4 * (idx))
 #define APPLE_SART2_CONFIG_FLAGS      GENMASK(31, 24)
@@ -38,6 +35,8 @@
 #define APPLE_SART2_PADDR(idx)	(0x40 + 4 * (idx))
 #define APPLE_SART2_PADDR_SHIFT 12
 
+#define APPLE_SART2_FLAGS_ALLOW 0xff
+
 /* SARTv3 registers */
 #define APPLE_SART3_CONFIG(idx) (0x00 + 4 * (idx))
 
@@ -48,11 +47,15 @@
 #define APPLE_SART3_SIZE_SHIFT 12
 #define APPLE_SART3_SIZE_MAX   GENMASK(29, 0)
 
+#define APPLE_SART3_FLAGS_ALLOW 0xff
+
 struct apple_sart_ops {
 	void (*get_entry)(struct apple_sart *sart, int index, u8 *flags,
 			  phys_addr_t *paddr, size_t *size);
 	void (*set_entry)(struct apple_sart *sart, int index, u8 flags,
 			  phys_addr_t paddr_shifted, size_t size_shifted);
+	/* This is probably a bitfield but the exact meaning of each bit is unknown. */
+	unsigned int flags_allow;
 	unsigned int size_shift;
 	unsigned int paddr_shift;
 	size_t size_max;
@@ -95,6 +98,7 @@ static void sart2_set_entry(struct apple_sart *sart, int index, u8 flags,
 static struct apple_sart_ops sart_ops_v2 = {
 	.get_entry = sart2_get_entry,
 	.set_entry = sart2_set_entry,
+	.flags_allow = APPLE_SART2_FLAGS_ALLOW,
 	.size_shift = APPLE_SART2_CONFIG_SIZE_SHIFT,
 	.paddr_shift = APPLE_SART2_PADDR_SHIFT,
 	.size_max = APPLE_SART2_CONFIG_SIZE_MAX,
@@ -122,6 +126,7 @@ static void sart3_set_entry(struct apple_sart *sart, int index, u8 flags,
 static struct apple_sart_ops sart_ops_v3 = {
 	.get_entry = sart3_get_entry,
 	.set_entry = sart3_set_entry,
+	.flags_allow = APPLE_SART3_FLAGS_ALLOW,
 	.size_shift = APPLE_SART3_SIZE_SHIFT,
 	.paddr_shift = APPLE_SART3_PADDR_SHIFT,
 	.size_max = APPLE_SART3_SIZE_MAX,
@@ -233,7 +238,7 @@ int apple_sart_add_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
 		if (test_and_set_bit(i, &sart->used_entries))
 			continue;
 
-		ret = sart_set_entry(sart, i, APPLE_SART_FLAGS_ALLOW, paddr,
+		ret = sart_set_entry(sart, i, sart->ops->flags_allow, paddr,
 				     size);
 		if (ret) {
 			dev_dbg(sart->dev,

-- 
2.50.1


