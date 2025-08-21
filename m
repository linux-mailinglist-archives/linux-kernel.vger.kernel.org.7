Return-Path: <linux-kernel+bounces-780261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B62EB2FF73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AA5B61A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CB429E0F6;
	Thu, 21 Aug 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW0MiWog"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06D29D272;
	Thu, 21 Aug 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791869; cv=none; b=ZqehXDxt3AlbL7sjNDA/iBE/VH2YLVx7JuGkM/tShya10v71MAa886o0dTStFTCY60IA4VvoTNoRbA2EGdYGfuZ6lUZ2f9YhEe4bpEj+bEiL0xarUQJcBxkBpTnHvQXidas1kJlsUQ9ncuraSRTI7u3aBAAIq4Qo5aK7hx8wO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791869; c=relaxed/simple;
	bh=wJH6bCh+c84MG5dltlJIecbSR1A7z9mKknCoraX6plo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=km8ItN9JZXfmsXF0VulcWL6YjjnvomDTosFWB5zGNtzAvd1C/goqgl/WphtJn0qTXPQ/ZY+jpvgRZprmCovQsBo9LQ247DbV7v81+By4IEiOkZGmb3ihIdOSPDA2RjTjtkCwONIJnjpxnhl2aWHE1FhyAJRVyPnICqktRVFyz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW0MiWog; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e563b25c4so906682b3a.0;
        Thu, 21 Aug 2025 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791867; x=1756396667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=fW0MiWogLWoiXsTc5vIzAoaoJw3syuJmepzdQT14ozgD0oXyFCvhmUmQZWmR4bANox
         ms+lCuUheqPabee4wVojVEqulq18BMb1AMkjpAeSBBI5KNPFH1sTINAAd5JlwiQYiNYa
         p3ieJhnwwSbMrTmKT4EsV3mnkV5JtjNa5EOisba/20L83F35kDu4oInAIr53rAXjCTUh
         3bSON/hKm0eYKOr9PHiKcaBO82/WmzC77ZbTx6w+G0mATPsTHyucTDt+dwmJ5V109bw5
         Q125EkA4x/f9bp9Kgy35QLHvplDR68cpWjTlRC3Rg9ikDz7d42X7Mv4ce+YmTiUwSZxD
         TZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791867; x=1756396667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=PayVdPuAQ8ftPBL3vqnTIUMV7+aKnIYPzRb4a9PK5iVEQNWu0Ti15k6L9gw2YAVkbH
         Yh2oDsUKedRY/KY4uPMEbPtys4i1dj4S7brp23MGy2frF3eIgP1SVUdz7KDi2URgvRR0
         M+k+xMqLlKdqkfEb64gJoyeBwI81Rfka6rZRyHTmZyiCWvVz23Cbw0l3XbLZJajx3lxI
         y9KIOaDEDoDO+pynxHIYaTfU7key/SfoXPtm7S+xrbjUcgDc0c8KBW9N345Z/UEiLrQH
         FaPn5Ae/Fc4shA7ry2eD9fxz0jzYq8Q5f/gN4wQ8PufsbGQ8UZRvwaYLYWpGprxN77xN
         DNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOqm079AprLfEfgkCROcB1jdstW32ot78VNIeAJH+IF7MUuY4Crdc4DavbOmdH7rMvtCOsMVutBdjy@vger.kernel.org, AJvYcCXa0RIRux9s//Lhz4z2Xmd3TzMvl0yQXAQq5VXBLvUJSZwcps5BpW5C36b3lLrl/WIpbR1IHT9COx2cAhl9@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxiFaKvqOqL1Z9CfsGA2PqxtxBhneOoR+UwkMbEiPNieLJFQU
	9PZDgWrhTw6Y2rphLJ8jSs+aQkvEihXuwe+FSBU+QNYIP1dD2r82Cw/t
X-Gm-Gg: ASbGncsGFmMGrqefigRYn/ERrJeq7KsGtG5ZkKJqFCbP88HLomxfSJDH4AAihdb6bRp
	2UayFJ6vqTqpPfy2ADzYQzp0bzyz5dYE8EEqHL9pE4WDIekqk2DnSixDi6lt//xCNQVqqrQ7OzD
	moHYVTKYribj1WfjM51EK2HxR7zz/mwPKh+wClh8X8+6JRb5Wq2ZaNJt+5zF5P2M34XBaf4BxN3
	pb1dFugTQyhtJ/IyV5AhZm32+ATYBjMA91Gq3zF9DWDiswjicBqp/Z9cgaSbqqFoytGmRzmx4jo
	mgQbob3Z/KKIablUDhx2me7idP6OhU1Lb+QkwJ3+6RDqxemG1EZ09X9c15y9Nb/CzPauWiVFuuI
	wiZytz1QZ1+xC16I9p0Sl947LyKhjyQFTIDKNQrRIQbh3kbU=
X-Google-Smtp-Source: AGHT+IHE9fgaPPSfoST2vYimjcU0YIs92qxt+lOf7Yhtfyjt1G9Z059hmKnvX2aribVrwcXalhAGdA==
X-Received: by 2002:a05:6a20:2591:b0:243:78a:827b with SMTP id adf61e73a8af0-24330b47cd1mr3790459637.51.1755791867100;
        Thu, 21 Aug 2025 08:57:47 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:46 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:42 +0800
Subject: [PATCH v3 5/9] soc: apple: sart: Add SARTv0 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-5-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=wJH6bCh+c84MG5dltlJIecbSR1A7z9mKknCoraX6plo=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUSDKOE7o9/KxkLrLGisPDzdwRuzUZKZVkV
 7t/hhYav/uJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JEf3D/9MTNaRSanW5d+XC6IKcZa3GXuBd2THZSYlnSMl/pfWwiWIbQF5SB4vv859yM0RFDxVNMW
 enLM8hzLdaD5r2oRWcL96Nod5A4EqiuZvW7aGis8F/E+kjVUPsn0xQnS8lKuZNWMBVNoIzSrUor
 E36L2vEbycW204QtjTRjwf14pH7jPEkmqIOnT0yO7nvbEVTdydbNO3uUX5g5J0Yro1eWXpUAEs9
 m5W1CEKXBGH/T/KB0xVf09DSqJSBXaiEe+sd4ApT8v/HZsUSZ3+pazTwk3Yqk/OLoVS+NfVM6bb
 NNxHirWbh0or9sSKaZ8OPRYD6MiFPT3WdjW5c8ujlR0xZ6yJvP9gKV7ERuEGuNo3gw75yI4pihD
 zYHh/7Wz6gnBZR129m7mJYboTPn17sO777Khk9lxyD+0V9xzfoUnr2Xf4Jr9qObs7peOHkrsBPP
 Pzqfj6X2P92L9oQIEVLeNNHpX2YcMNtQ9V1g1T2De5yCIX2Z/eLYXFOef1MDbycGXWyE7XA0qaL
 ED2IcpHnSfBe1Cy7gsLVY2znvNhiELVxQ4bvEB8tKDNjhDpDtYla2IpttmBlFMuO5VGC75iyJ+e
 C3heKdxfJwbYnLLkrwskHcN2AWgVDklnhvps4Hzqm8M4NlL6XHB39DsxPtEVp6Fdiv7QrtH6EnO
 XKmwQT0EXEP0rjw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for SARTv0 as found on Apple A11 SoC.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/sart.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
index 318f6e518a54f6edb8b97e320519df8f77c7f143..4ff1942b82a74cabeda99540ba63c6e92386986d 100644
--- a/drivers/soc/apple/sart.c
+++ b/drivers/soc/apple/sart.c
@@ -25,6 +25,18 @@
 
 #define APPLE_SART_MAX_ENTRIES 16
 
+/* SARTv0 registers */
+#define APPLE_SART0_CONFIG(idx)       (0x00 + 4 * (idx))
+#define APPLE_SART0_CONFIG_FLAGS      GENMASK(28, 24)
+#define APPLE_SART0_CONFIG_SIZE       GENMASK(18, 0)
+#define APPLE_SART0_CONFIG_SIZE_SHIFT 12
+#define APPLE_SART0_CONFIG_SIZE_MAX   GENMASK(18, 0)
+
+#define APPLE_SART0_PADDR(idx)  (0x40 + 4 * (idx))
+#define APPLE_SART0_PADDR_SHIFT 12
+
+#define APPLE_SART0_FLAGS_ALLOW 0xf
+
 /* SARTv2 registers */
 #define APPLE_SART2_CONFIG(idx)	      (0x00 + 4 * (idx))
 #define APPLE_SART2_CONFIG_FLAGS      GENMASK(31, 24)
@@ -71,6 +83,39 @@ struct apple_sart {
 	unsigned long used_entries;
 };
 
+static void sart0_get_entry(struct apple_sart *sart, int index, u8 *flags,
+	phys_addr_t *paddr, size_t *size)
+{
+	u32 cfg = readl(sart->regs + APPLE_SART0_CONFIG(index));
+	phys_addr_t paddr_ = readl(sart->regs + APPLE_SART0_PADDR(index));
+	size_t size_ = FIELD_GET(APPLE_SART0_CONFIG_SIZE, cfg);
+
+	*flags = FIELD_GET(APPLE_SART0_CONFIG_FLAGS, cfg);
+	*size = size_ << APPLE_SART0_CONFIG_SIZE_SHIFT;
+	*paddr = paddr_ << APPLE_SART0_PADDR_SHIFT;
+}
+
+static void sart0_set_entry(struct apple_sart *sart, int index, u8 flags,
+	phys_addr_t paddr_shifted, size_t size_shifted)
+{
+	u32 cfg;
+
+	cfg = FIELD_PREP(APPLE_SART0_CONFIG_FLAGS, flags);
+	cfg |= FIELD_PREP(APPLE_SART0_CONFIG_SIZE, size_shifted);
+
+	writel(paddr_shifted, sart->regs + APPLE_SART0_PADDR(index));
+	writel(cfg, sart->regs + APPLE_SART0_CONFIG(index));
+}
+
+static struct apple_sart_ops sart_ops_v0 = {
+	.get_entry = sart0_get_entry,
+	.set_entry = sart0_set_entry,
+	.flags_allow = APPLE_SART0_FLAGS_ALLOW,
+	.size_shift = APPLE_SART0_CONFIG_SIZE_SHIFT,
+	.paddr_shift = APPLE_SART0_PADDR_SHIFT,
+	.size_max = APPLE_SART0_CONFIG_SIZE_MAX,
+};
+
 static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
 			    phys_addr_t *paddr, size_t *size)
 {
@@ -319,6 +364,10 @@ static const struct of_device_id apple_sart_of_match[] = {
 		.compatible = "apple,t8103-sart",
 		.data = &sart_ops_v2,
 	},
+	{
+		.compatible = "apple,t8015-sart",
+		.data = &sart_ops_v0,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, apple_sart_of_match);

-- 
2.50.1


