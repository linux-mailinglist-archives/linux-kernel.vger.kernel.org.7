Return-Path: <linux-kernel+bounces-876740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D5C1C8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C454640514
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BDF350A22;
	Wed, 29 Oct 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSdr/5bv"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0A34F27D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755641; cv=none; b=g84WR9GdquZU5EvM5dLwbi9QIQvp4dMKAHls7kX9zox2YPXqNTwG5mKGOyb1sKKlTrAybc8j6inlYCtlqXfZ3qXbf0mYln1v60hbYjKr229ceKBhwdYIDyAOsMxeepyOkN79eZgTlPV+J0HSdW8+M97S1uSpWcRpl8GDaPy/sP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755641; c=relaxed/simple;
	bh=KUSAVjewTwFiW9VLR1yzUFBIzCxCjea5cQlqAAL9Lys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hr4/BNBNFcR8Xs5VmD6hf0+MZkLnUf4mxkmx7J04P91ofilZ4+DM6TTG369q82txi3HOupuGQO7Pf7YyNP1It4IvJk9YtnEsBR8VpGbXFzgseOQWhYZ2ZGNQGkc50xtD2cngcTkt1sLAwnzKwyaI2iB9dNQ9SbtHAf7hb23FtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSdr/5bv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so4799797a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755636; x=1762360436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhxpRTp1uOQ7/yJc+0xNuSmcJdpaGHV/pw/kDcH2Yfg=;
        b=lSdr/5bvX4L9Id/q8FSipvEwyetUWz4WBkeyFYVVVBlPnTV0rwAUOnpEDqL/+tXuVS
         GWLtaRaqPNWhScrtCqGSSZ98mmwDjO+WvH7T1yO8nP9q1FAMPcGqOuObAHYfNdZF0+9B
         bXXAVe9Cozlc9uzmQ8teNiGwlXYryaqB1D731+cUoqfSp2P6yQKgQ1UXp7UAWaPfZGSv
         RSMgbmZdoi+3AXqfLwumOuYWEKwtFi4b8lc6qU/xzrKw8n2zBAOlOBCcIWQcs4HF4ep1
         /IDVCbq9wBw+RZUO8VY9DM/HQ7eVcmMHMiy9uH8+dZk4CV4dt+fw1/fa2fb9mMMDBdqD
         bktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755636; x=1762360436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhxpRTp1uOQ7/yJc+0xNuSmcJdpaGHV/pw/kDcH2Yfg=;
        b=Kx1klBWpypMG/jA/dGbQ+JDzhcuh/OXLKDV9LReC8QW7QZcvvAA8Mt29DShJlXGCn/
         kaZoLbOpimmiVwLjNa/WMMGMJ+g64L2TxrlszFKKdwDVWJbkx8W1Pk5BfibzXKZafQ8x
         Q+aI+R8L5MijG9L7L3yRB/FTdH3O+nGVOonwxnTKaPDJ8WjW2oRhBMM/rdER//YKoBa4
         csAkjp22ztvSXwipZtCO6qXcDxvc1Cj3gVPBXJshALWiCe7k/XxWhMOsbphlf0zC8VHn
         8x35P65aZWpZJMcUAAgS0siM0dF/OiLsnnZyTGv6RCfNXaV2WT+0SQ/X5CJUqzA3JUCS
         CJYg==
X-Forwarded-Encrypted: i=1; AJvYcCWAM1hNWr7CPwW2sk+l3kBMMI5r/WMrg0BciBpHx56J2fDJ9Ss6sU0RhR2bxRL1eJblUDcMc3EIt6N3APA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuQsxGc6cpY+IYvMFlq8vSSQVdVSqq1MCTvrl8qUEB1Sy2UF3g
	Nxkt/7UB3E9bZEigbYF5sedjxAsZWk3JCuWO24HzCApV0KVCU3+Ui0Ds
X-Gm-Gg: ASbGncsgdeVIHcwIwRcG7pQiZn/f8ciTVAvrAu6pBHpXYFxA0eI3IzyC0qdL/xLFWjs
	dBgPb6K40gW0kgbZJLHL8WvDI8BqrI5+2Hju1dkrIQl1AmLZ36FY4SEqfNeUlM5qCSs7ZBglvh2
	aId38WrtQ1KrM2Pwn19XqQzJlla5QhslwJn0ZD1LulWsCa41mG204Bzn0Ty1RzF4PWKFRrLh7ou
	elwOsbkz58EwmTlYhCzZrf70AlE7sn+/rAJDesCWXg/+lv4mtaK0k7WH8Ky3YI902DzERmqfjkW
	U12f9d+r8phj+MFW8aJIFZQORtnlxtD1ruwEfgK/kLsKi6W0cSgSs9+msyLuL82gyuqQ0nMLniH
	u8iQPJpc1DznpAyv99PlV9oHuAV/eL9K6kEqVA3TrHI1B60VpaTCXuBWpOlwo/E96TLnUdWfWuP
	fXhtsK3blk79sQeWnD07F4uyqi2Uq9B/qCfpHruWa+jr48JnB1RT/yAV9puzDe7IUn0rkP
X-Google-Smtp-Source: AGHT+IEBhKyqSuQzRg5+jPbNr1lJJJfXBtMjYTViFyDgVE4pc7ia4Gu9caVkoUUyuihmK5MM+ILYDA==
X-Received: by 2002:a05:6402:5c9:b0:62f:50ff:b675 with SMTP id 4fb4d7f45d1cf-6404437f5a7mr2656312a12.33.1761755636037;
        Wed, 29 Oct 2025 09:33:56 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6404de640fcsm1695354a12.8.2025.10.29.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:54 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] irqchip/irq-imx-gpcv2: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:35 +0100
Message-ID: <20251029163336.2785270-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029163336.2785270-1-thierry.reding@gmail.com>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Pass the driver-specific data via the syscore struct and use it in the
syscore ops.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- adjust for API changes and update commit message
- remove unused global variable

 drivers/irqchip/irq-imx-gpcv2.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 04f7ba0657be..ebfc659af385 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -19,6 +19,7 @@
 
 
 struct gpcv2_irqchip_data {
+	struct syscore		syscore;
 	struct raw_spinlock	rlock;
 	void __iomem		*gpc_base;
 	u32			wakeup_sources[IMR_NUM];
@@ -26,8 +27,6 @@ struct gpcv2_irqchip_data {
 	u32			cpu2wakeup;
 };
 
-static struct gpcv2_irqchip_data *imx_gpcv2_instance __ro_after_init;
-
 static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
 {
 	return cd->gpc_base + cd->cpu2wakeup + i * 4;
@@ -35,14 +34,10 @@ static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
 
 static int gpcv2_wakeup_source_save(void *data)
 {
-	struct gpcv2_irqchip_data *cd;
+	struct gpcv2_irqchip_data *cd = data;
 	void __iomem *reg;
 	int i;
 
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return 0;
-
 	for (i = 0; i < IMR_NUM; i++) {
 		reg = gpcv2_idx_to_reg(cd, i);
 		cd->saved_irq_mask[i] = readl_relaxed(reg);
@@ -54,13 +49,9 @@ static int gpcv2_wakeup_source_save(void *data)
 
 static void gpcv2_wakeup_source_restore(void *data)
 {
-	struct gpcv2_irqchip_data *cd;
+	struct gpcv2_irqchip_data *cd = data;
 	int i;
 
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return;
-
 	for (i = 0; i < IMR_NUM; i++)
 		writel_relaxed(cd->saved_irq_mask[i], gpcv2_idx_to_reg(cd, i));
 }
@@ -70,10 +61,6 @@ static const struct syscore_ops gpcv2_syscore_ops = {
 	.resume = gpcv2_wakeup_source_restore,
 };
 
-static struct syscore gpcv2_syscore = {
-	.ops = &gpcv2_syscore_ops,
-};
-
 static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpcv2_irqchip_data *cd = d->chip_data;
@@ -279,8 +266,9 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	 */
 	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
 
-	imx_gpcv2_instance = cd;
-	register_syscore(&gpcv2_syscore);
+	cd->syscore.ops = &gpcv2_syscore_ops;
+	cd->syscore.data = cd;
+	register_syscore(&cd->syscore);
 
 	/*
 	 * Clear the OF_POPULATED flag set in of_irq_init so that
-- 
2.51.0


