Return-Path: <linux-kernel+bounces-762771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C457CB20AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C813318C17A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576A21B9F4;
	Mon, 11 Aug 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsUcrYVb"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C71E492D;
	Mon, 11 Aug 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920304; cv=none; b=mm6LaBH71oKXj7/wroT68YVa7ZzyvvpgBEYzLjjdF2aSgtLhqtIZDQudseCRxW8boTs384N3eYg5Je/jyQ9pAS8Wq7xbHXLe1B51dRA14nrfmoxxElCmcoEG5gH7fGCzaZFnSyf1GRs7ts+wwvEu9Mn339Wl8t13puN+KRte4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920304; c=relaxed/simple;
	bh=qu53Npl9p1UJIa6YTj/hRvC8zr9mwt5eIRHVXIxtFxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DzpTIG1BJEBrj/x0c3eYQCzrsqisjCqordizIY3cIW17bFxp4x5E8K57b0uJAlKeCSDosn5pPUW7ac/fmXRtihE3DY2rJQ21WIkrIhEGmi+M3PTFWFgK0BuNK2dwD9JsfrkTlRHgYg4bqyHASG8ret6AwnMegGWIBQyvaLT5yjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsUcrYVb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bde897110so3441349b3a.3;
        Mon, 11 Aug 2025 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920303; x=1755525103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Z8PyP5sKcVvm50Lc4ho4ozdCtTBci5j1M5U5sqHCfE=;
        b=KsUcrYVbuZ5wS8Qr34175v0eajFFumnOBkFRbdjoJqbWgFbftolo/phwwoAlnerY6u
         lh6s/wf1JMZr6X8HUHni3xyqhQ0YkMHL4I1v6vSe2QSN0GxoOzHMqk8fU6j07Cpqltw+
         p3G3sw9z5JWsJEr3/qg7l+Tj4DDWN7IO0WIa3eF91nXs9p93H16oTahPXpgwPg18DS0m
         AzIFYgZLWKvyqdPcP6hG18G09a9LKqoVJzqU6cEUE0dOdhPuui7T1OWcItwTQr9VVnT+
         zym9QM+r50ZT9c4UKuxXxhXM3VKdFM1grkwyJoOGxbmb7d+wdZTvq7c/Hi69z4OkrzJ2
         EIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920303; x=1755525103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z8PyP5sKcVvm50Lc4ho4ozdCtTBci5j1M5U5sqHCfE=;
        b=XTIBr0zCLHdHk4uijr3qsNbBwXKhsMfbNlbURt2BukfBAhLE8sretxs7R5tybFaMKg
         iCF7gmClCBzCEsyppbjq+DNfM9yeqD5Dxtipaz38lINKM+iDroSIW3zS4IIJtC+UaysE
         zC09kCWB8xQwcdb9ShDLwkcoNyuuAbhepD5/IyqOsfe//GH0wUxOMZP2E+0tBTXMWwTo
         /x0Xdw8trVfP4v6j3+adZ+u1qRIISz/R+nWdHbbf/bfM3uDDYVKqeeHEFGJ7/k6eUBM4
         YZEDOt4T4ogNkdEu9H89MIXOqgg0tc7h39TzzWiZ0knuG7imjvTKlFcU3yjMRxFksAKh
         hd3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMm8gagJ97hN9OYo5ElOGh8GTWagFE/vHGYCA1J7ZTDFLAl4YF7ZaYnBXx8gHh+ZkvUbHTJlAGoAkV@vger.kernel.org, AJvYcCWXHZGZeZr/K778/DhGP1rgcTFqplK73vlUgziRhgNuumpnko/JPxgAPniprMnQyets9AHl1JKOozRtBnmC@vger.kernel.org
X-Gm-Message-State: AOJu0YwoK9PAeb9/fuwL/xRpxscgIiSlKrGrxvgcfYwFcCR6YCTClKUl
	TRFw2RK8i5/eqX7ebVAaYSFadh9sY7IEPSJNm8kTdl324QU6qSMPVgEn
X-Gm-Gg: ASbGncvVvY3vwelm/LfU+vGasSdyCWy1QbPVmB7iHbJVSSiPEjgLRJE1AtUf3LYrgD4
	jhHz/5IscwXvNr9CCYLwJR86W6EK9iOqQz3lsRSXS6Dk20FPjd5oJrhlEDqq7nolD1Ck5KB7hXt
	RBfsN78igBycAGve4eoneTXgTXBteLSIoaOme6Dtb9rBkDXkJ1XI2Nhkp4smkH8yVf/rHbJTcrH
	DWj/NzAq+zYpW9DsLEuxDbO8YuD9HDSW7IJ3i/bZi0f4IRo8M0CJ2UHiMa43TgLokYeXLVtuhwU
	2uETWyNx+6+GiFJ49pBr3rUyEKrbyYTHIsS6yLBgmmYWmJ9gyT5ytruQUw0F+tA8t8GGh2L+5Mt
	9uF97koZOfO2Qycj7s6hJFKCQmltTBIXhNkc5CrhDsHCDNG4=
X-Google-Smtp-Source: AGHT+IHrA+7zJge9i962S6orPzAQDEhO1XUkEFQ5EVyEYNFg3sFEV8xqGFfQsZM23vmED8/k7VCvpw==
X-Received: by 2002:a05:6a20:3c8f:b0:240:195a:8324 with SMTP id adf61e73a8af0-24055015142mr19729554637.2.1754920302821;
        Mon, 11 Aug 2025 06:51:42 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:42 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:56 +0800
Subject: [PATCH 4/9] soc: apple: sart: Make allow flags SART version
 dependent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-4-ef9c200e74a7@gmail.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
In-Reply-To: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=qu53Npl9p1UJIa6YTj/hRvC8zr9mwt5eIRHVXIxtFxQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVQh6mVaSEh/31vtj9Sp/TjrE7dHgIyGxnSV
 ZSHXuJG3rSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UAAKCRABygi3psUI
 JMdNEACdXz4QPo+kOUFthywvLIAGegRvepLxUfokbyfdsVmpojMj5j9zId3XrjZaa8HjvdpGKmE
 rZZGAFvoGvQfoE/WIO2Hn1MS26yqKsXPYsIxtkaQnAuObrk2MhZPxHCcka4i1aokE8sC9lAKL+/
 WwNhnJr/hD5WTXNy6wC+RBRn4tXEdiOI7/Ix6tts1yudkv7AhcmLE4u6G5QuDs+8t8FHIA9Y+wo
 AEmSOYgHvNYgA2jvkRzinP0p6ogaX10fBWbfMlN34q/OHGUN6MLsHWhrq/KnOlYnfdPuvWYCXnF
 j5b6JVgeZB8TJH7fol5y549AWuyPtfVkyrsCoPfRWd2kssvzwjmcYX+eTlpLhK9REMjWTTc0/SD
 jWQpFkqaYYAUrqGl8WozokSUmyXcVwyzC60zqOpAqPAbFuz3xb6fPkFatm7RB5/9KRQwnNmqQX2
 EU1RBIF/CxOMBhYAgMaL0GeQT+4xMMc8twKbo8+XNJwuZeY9E0cJfTLhEfJkUzfIpv6rb/iR7gN
 0zE3w+661aGxZ+mpWdJYw6kKLSJNdhAzEjrB+8vIGNF7GaAFIIHPBJa1MuafMfvTzAYRVZmJ3UK
 KzuQzPYuHQhNcKrimU/dsRcNl8OQyzso+9rPKwiTQaKpTuieMMwgj2cTa0fCYOA4Jd95hwZU1lJ
 OvHb0vAmQYyExsQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

SART versions that uses different allow flags will be added.

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


