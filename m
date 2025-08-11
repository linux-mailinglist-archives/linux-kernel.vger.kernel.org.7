Return-Path: <linux-kernel+bounces-762772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA8B20AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8FA18C1A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82821222586;
	Mon, 11 Aug 2025 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4XCf1XT"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A91F873B;
	Mon, 11 Aug 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920310; cv=none; b=Rtmch70Jqyu5GQn9hSH5M9ac5p5FtO11hqE1BXaFW5F3vXUq3mxH31S8GpULyPmHrKRklGiGiGmH8xKjD7VoQhL4C076dzFvx2GK+cH48mdGv74d0OCrWLp+EwFQk4auVuKZOB9lDFoUymCc7eQhFpAJ3KtDLXZ9HB23GzHTG8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920310; c=relaxed/simple;
	bh=HASc/UE1e+zwLEpdDftsFG871JkJOER0qIdXrNOZ2Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZCxo+Wv8A43W0Jwrg00u75G8lXC1jsxWnRVgTcgfgNOHMU4v+xCbUGb2RONTC5kn2Yva1aJkCuiflkpc3zZaJLsYekZcx2JXeaQuIsOKHw8wXS2GsWj8z9x3KGRtgC0rBILnvb6UFHJYLR9h/+NQCOmsP5BzuN4YsY2zMZRlVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4XCf1XT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so4548180a91.1;
        Mon, 11 Aug 2025 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920309; x=1755525109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEfy1d6REVklGGsJ2sHwNoDWcI0j2BApVTLhGkHwAVE=;
        b=l4XCf1XTL6m7pC8GZ9aLiYSYIqzqSp7ioumfeU+7X1KmZTn5h2Fp/AlJAMcqs7uP63
         q5LbeEW2LDOMMKomJpZmDfj85ZlTygS+4IPRYO5gYh1aDc898mmPkeFmOWwpKolF1zjd
         zji66uCJMMJ5a/PnCzaxJnogmd5cp4wkMRIzt6YESB8zouujtimrJw+UnqmlONPSrEAi
         c472+aSlcvUNE8lNyl9zIzkMQV8QhAKR09NG+pxU1d0lr6aJuHyJvIS6DyDKSni89yHv
         xvPslXLY0C2WeH7PrS5Z2Kq9FdpRpE67GgbxpWOoLqKy0FWVf1J4wVpY8tnPKUpnIiAV
         ojsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920309; x=1755525109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEfy1d6REVklGGsJ2sHwNoDWcI0j2BApVTLhGkHwAVE=;
        b=QkxZmkmfEBV7kQmO2wHrltVeEaV68eztB1ATSUWZmrQP3rQ0XJ28juFy0bG38+RH6P
         Zr9xWOHezE7VTlzC9oi42I1waYjyxDobzZZHL2BmNe3Tg4HakDtPPyCDJPyBSCkBQBpP
         7ZgYbl3+JoJxJkSdIBtGGvKnc50kuUe+AgYYAbfBspIVJbAXr1vsfWTpylruoYnljaeg
         y2/8X9OTacdbWZFAnmvawAMucTe+pACl14DZKwTO5pWolObtzMdYox4kXy/eUH/MEew9
         OG2Wk5hsAxnGIaifgGKUZd3+LMqcaV1LmrN/ik2p+onHbX0/4rVJbyXuovx52t1fkoKf
         tQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYiYR7ZaNIj2v2EkwoAQn/1pxjsgEfbOB5/0Fkx43kPLjs3G70C9Cz+PsaGX3UHaoiCJB2if0tZhgLZEjW@vger.kernel.org, AJvYcCXV+qDXG3cpMme1590NaMccXEzkNCc/SjRvCS6u9N+TpgSo9NkAY74b9At3CPf9QShPiXU0BWpp5/4a@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxuhg9AkSm7isRlDFADLBB7yTSCk+vnH+7qW/GBF1sHnhhijtj
	ttf+fdrhiJnza++fH4+0RxISnCYHoGVHQ4jXpwtQqZLuqpmgfG8taFhT
X-Gm-Gg: ASbGncttk7HpEOixObQNeSdN7PUC+BTuVDjrzo0y3hKUUjzt6RB0rpk4yj45cUF7LSB
	B/TTdkQDxiJEgwHCnRQixXbr27Kjh3aKxM6/g4BoPFbxgKlk7tik3qXXAibQlCEi5+kqT5Ac6AX
	STHiMbLTBkRO8zfJFn5LsHIvSs9nvvP8Yf5j/ifQ3C9cJnO3phWPy8z8UExTIymmrDkpfFWo2Fn
	hsttx3yljaETOmlKtpPIc6IFt/mPJ9aHK7TErjNvafMJ1ZIodW0UbDc9zavRSB13LpWriEYX4V/
	xvRYAXCUW+XV2OqqkWd/lbaEMGR9aaGROqSd8bXDW4LbDBwjEIhGj03B7aQZcn2nW43oVSuqqGP
	Gu+gOvIVL2+ZCMyyupsnUCc/e3DYrx5GIt+1LwJq/k4ZBYb7QtgBzhXT5hw==
X-Google-Smtp-Source: AGHT+IH1udNShnfKQ/kNxUt52VN2M3uRw5amTvYb5XrrZ+KNWAr5SidXvoeniU5jkLgzVeqPaTf4kQ==
X-Received: by 2002:a17:90b:4ac1:b0:31e:b77c:1f09 with SMTP id 98e67ed59e1d1-32183b3f438mr18169391a91.19.1754920308652;
        Mon, 11 Aug 2025 06:51:48 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:48 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:57 +0800
Subject: [PATCH 5/9] soc: apple: sart: Add SARTv0 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-5-ef9c200e74a7@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2748; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=HASc/UE1e+zwLEpdDftsFG871JkJOER0qIdXrNOZ2Wc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVR3nGx5ONiMyduDBTlKlsmAlWnDpuM62Yq3
 1N3xXx229qJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UQAKCRABygi3psUI
 JFIYEACa2AXuWbCL6bohXb58bhGalXB85bannxcDnOvFbk/9hPyEAcJYLE3oWmi6q8/BnaarPzy
 vtJo5ryAavk/GuSa2O39JQf4IOiemJXMGfUmZed9Jik0ezLUStqfF8pRmqBa26SG9Lo5m9blora
 r39zadSvSE10FzjxQPvib1FzmseVjU1LaPLlMuiPjSWyNwOJJoqJGw6m/rNgK/DPBXOFSDktWLN
 CEztWyoefNWA48CV0Chcl78Gdmc9oeGOW4MPfG0od56w1IBkCctlMG7EqvHwncVwBWaDxjI/Nw8
 hB6LEODLbV0xm4E3giTEFuPIDMIH9pLLyawH9Bw0CE8BUCdTIh4lg12cTgad4eDPlJC/OxdZYf5
 heIITrHpz896bc1SLDk8xBH6bZYruB/QDZ0cIsmV970NLUJM1HoslVdaxtm9WhpQ3/myGaymd5V
 d4KDoBiYzGj7r6bGsfFRlU+dZ8kxa2n4L7TBHldf0R1Z2e0qTA09rejZaXjg0NUxceqm5kkueT+
 rrJBk64uLytlRjdkZo8iRV/Ghkkx/rz6wxE2Qr2ovmE3LeUgVs6A+kLcYe0hpc2onC5/UXELzJk
 s7JrSKhzY/icHhpfMwf9x/Mv7wuNL9wNlFayZULYU5GXzbI8RYn3L2ZLAQt1RntQbskORxNxjP9
 XIrzGyz4qHp3GHg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for SARTv0 as found on Apple A11 SoC.

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


