Return-Path: <linux-kernel+bounces-773193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD3BB29C85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F11749A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF723074B3;
	Mon, 18 Aug 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPwQgW7d"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49EB304BC2;
	Mon, 18 Aug 2025 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506636; cv=none; b=LBnVIjOnrROo5MTOOl2/h3PvOOnvdziTJoXw/xdRcjIdL51sF/Q52tJnHaosh4qEJ4md0ZBQMFbUJNy0sIHlaq5kMfRU3E0s3AIG5xkYu5NSTP52ug/UUHh3hHVJ1s7KGWsaYPHra+sW9gmScmsLN7HpUTpPlv8bF0LuLUUzAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506636; c=relaxed/simple;
	bh=wJH6bCh+c84MG5dltlJIecbSR1A7z9mKknCoraX6plo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YB3Onz+/e8U9A1UVfgylLnqH0THo/lNYyG3MKukPyHSdXy5Brq/eEHAmVyA2UwfCri636Hr5GRr1XrGbB/gO4dNO6tkuItybE7+VPo5G7qlpX8BMJ1s2OpyuVU1faohA+TKmYNiPPoc9kMMFS5buCiNwCuzJX/E2SHl2YnugcZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPwQgW7d; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b474e8d6d01so114549a12.0;
        Mon, 18 Aug 2025 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506634; x=1756111434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=EPwQgW7daafJ0WNAftWDvnyd9qKK7frxTRcjnZvekvLDYgCgIowDbDnmXxnj0VP9Ln
         /xA4rGXE951JREn0Hmogsfs08sHQpLQvl7FzQnbTAzIQFnHNLVDsPJ/1e9cA1CuAvPrZ
         iwngMwbGbGt4o7PN+xo/oSx2Js0D2z1EHJb9gnL2rWR/0ZNvcROh2nMp6Z6sA/tH0w2+
         NpqRviIElTmdvKu/7q8Jo7Z+ejj/bwm+yUbkQklpsGwTub/cOwZUE1ZawJQjHVNgADUB
         sYClHVdD3rlF5LCZR+GMSjwoIUsJNStvA7xtr50j40bu8hzBoNM2xzFPr65XFxbNSPJo
         Bs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506634; x=1756111434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=JcL/pZQi8uneqeuhZ1LaJ18UvzxCFhd2A0OSDyPjOVXlGugTGdrUjQzHMy09kno9HI
         /WK2JGiZXQCJae+hk2ZglvVOrqMxbA/YQTpPzqv/EDPWhV2RXsKdY0XS8hbBACxnQBHv
         DXcdWOU7EmfwLzjM5uTLwrtPjs7k8Cy/gRRIw5MNIc0k5Xq4rxCNUC+g5NtFGtd1Y8DK
         AGDzuEoUEBUO215/yizwRSL4K1Xc96QidDev7TFaORCFBZUMfYKiiBu5+1B4YImtyw1n
         bfICYuERHnVRyN1CTiZb9HkErvdZbd68kRF6tW3KE5RRp/T6T/CPOv6gI/mY8dJHcPJp
         N2GA==
X-Forwarded-Encrypted: i=1; AJvYcCVqkfo+HoP0t0eB7j/2goKW0X6pYxgnMsc+lfYQ0+22q3m7P2UuxIGNeDPT8Xg4wXSbZekiHG4CO4Ka@vger.kernel.org, AJvYcCWVJw5tLpJPzT6Gn9YZUblwFiujQDQzp8RE6yRDvRPZYVpJq9nyjJTsEStMPafWJj2+ewmKRu24yVu0G4uA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9fJhD51knvK5aN+zj+sYFvTTaooMv6sjPZQcKYxtsTBonIoT
	hp9WlJcLT6ll4i+O/MN8P1arMJ4TgE947ENF7oF/iIOvv/TP0JlRmttb
X-Gm-Gg: ASbGncuAL+hPtlMqZuqv15ZLHjoJkPATL19svvMtCdrAhJ/g+O89qcFgaBfHypZ9RCM
	wv9uyU9y6QTPEV7w2OImMPdBW62QSV8+1uLDY2mpEgpuFMm3KVZHfNvoy/v0UR6ecQVzmap1x+S
	mKNhNUD6oS5rXi7RYqe6iiXA54q6n9CJpU61U5A2L/TkHhXsTmp1vz8TA0Ezc0iFQpK06L7Bfu0
	KpOQ14NTNWlrE1Y7baKA78G+iUPR4h+PkOCJMLf2KwjHqzkxcXUVMJszPdPXwOf4ANo2klvFKMP
	y/DNc7fofBIFHjDTwzK72hLAfpRHdLrcFhsM23MELqMQ3IlTexS0Ar/PW+S1FFWu9dv5mjcsOQy
	6bxfbW+NM+r1qmZmcfKG5PKj5C3MqPDwbQ+vGdxsXuAZipqY=
X-Google-Smtp-Source: AGHT+IHZT2isaZc8TNK+Ul72AEXTJHFHaWWnaLR1o3EAxYeINyGXfuxT+CWND5sj2IAPUNrSMUB1ww==
X-Received: by 2002:a17:903:1ae6:b0:240:25f3:211b with SMTP id d9443c01a7336-2446d980b96mr146776455ad.51.1755506634073;
        Mon, 18 Aug 2025 01:43:54 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:53 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:58 +0800
Subject: [PATCH v2 5/9] soc: apple: sart: Add SARTv0 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-5-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=wJH6bCh+c84MG5dltlJIecbSR1A7z9mKknCoraX6plo=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouel7tB5pMk9ZRPwFi3VYfo+wHw0Ob6V61kt0
 cM9qXkKNL2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JAzLEAC3GE6E0JJaoSCxIkhKLQwRO5CQqJZORLUx2kZckZ15RN2ygxITFBkfPiprq86LvbbkbkE
 I0p7uritaNmuEOWjwLU0GLKgNMgDrdHOVr46dPQmjLA+eYyZdLDBWVcgPh19bhvkI3vNYiiiLNY
 T1aA0yScyUMImiJYFXJ7JetUa+L33QKyMVYEo3ahLtQgDpgM+N5xBWz5Qb7xczGySFHR3oymxd7
 CE++jb6XpkCJ65D3KUIx5UihSCcya0EdlU0a/wJJhXgBe3Z44PUuhxHibvVQNBk2BWZ0dCJG8Sk
 Lc6fUQA+mg8RiZlTyPaW0lfhWkkQm7gU4nIjhC+b8r1ZQ8/82kIxy5Q+zxw453asfjDntuEdml0
 Rx0YGtaqd6XTWiDi5jiZAEi6uJba+cmA39hS7G8LhGiTpsvI3ajeqaRAIaLXZXnJipyEIz1Bg67
 LhzLbIaK2SbgcfrU+I4LrZULDInsrjjSC0PLZ/sQ9ipvWIXLCzotPFR5IuzUaesLEueit8tmRjf
 SJhZOLzPmKai2LhRugKpEpD2OVRhzYZtHmFiZWoVmpIf/kLbXyT7sFaVgVfdMmkyOzbVgCs3gb3
 KuymzpXLz20+s/gEvuuKa9OXRnMfKHrDhUVNtdeZ93M/BJOGQ9QacRoQp0kNnlrtVcnLeIffl+E
 gNvlqFtZeOmGY8A==
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


