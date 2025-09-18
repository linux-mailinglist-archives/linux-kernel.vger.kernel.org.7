Return-Path: <linux-kernel+bounces-764401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8A4B22291
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D28188BBCF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB892E7F35;
	Tue, 12 Aug 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bLAKH8HK"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783E2E7F20
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989886; cv=none; b=JKPPOZ5pP63x3H9iKcDm3w8JyPuYBLq9qXZKl8FkU0POiNsPvg1GuVJcl0oLNcGN+tpyxHjP3mL6uvUOfrZXL+f3QWdB1Pxjs1jtr+2roNE7hUYFp5dgALL3XZCHJ3HXQGQLiWpwnch/hHatijz+aGh/FZC40j4BO1IkVZcXzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989886; c=relaxed/simple;
	bh=PUGgDDQWFyEN8FapYMcSYXBqOMRdjtFyBA2weB75KGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3YEmBd29Uib35gQe3D8AiF91OVffIUseVtioafMQciHyvuv5PryRXDhsNKh1PDnJJ84swBvwWjzPJobTSJjeOK65YGRCUC6SoCqVptNNQaxnyU2vrLhRyt6ERmEXfXcnjRdvQpVaq+EoYyQLqh4ssz8ZhARYFA1/vuhpTTzW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bLAKH8HK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so8624122a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754989883; x=1755594683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtVswNnng5a3i7kggSLAURNiGU+X7VfdWUXcHsf9Rh0=;
        b=bLAKH8HKiYdL3NVtBwgZ4tbKPAtp57oDU87SdMR2AXpmIqFuSsHyup7sowr3ZXNdEd
         H0G8bdqSacKx3cv+RC9QGgZFLoAmo7sL9baMVhOPNhEcdT4FXbYjj2PdjaFXMIhwWd0R
         FkfGhbihQT8/Cst1prHeVYJbYkcBsvJ3sJK8f20SwI5YunODsEmxVrQykHQ6wHrS6B99
         ZCt2Et0k/a4XjTC2Wd5ETP450K81ByvwmAt5lF5wqSgAvExH7EGXj2kkxTQN/yaAdaDl
         GqjQAGbP2W0qg/G5elNIwzqD0DCrgvF3hgHYSRfOVUl8hquokdQJtdSxa6BF+fuP7rXh
         WAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989883; x=1755594683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtVswNnng5a3i7kggSLAURNiGU+X7VfdWUXcHsf9Rh0=;
        b=rRgDjV5JZl6v1QAWu99q/p63wbcirA1dKg9yAuxXJQ4aEQjLjkeAklBlRmO6YoF3ug
         BOus8Q46xqgX6f+bG4JtktqsrUMsLzZaz6oy/qEnXlQj2KDuLdCmPR40VuNFbE4X5Dpc
         +rwDE7X4nynS3szsDFNyNs7NfHH1irXS7OyEiJdwogUpw6prKjaNWDsnGzlPtjI62d9q
         HvI11opXxYvAac7PGlpn5bHh1Pjp26od+OOe3y/+/+lCzyoyIebKTF5lH0qtdddMIHjc
         EIjLPnjhTTdmAdfOgWEgXT2A0bE6+j15XP01XWIH27RrFksWz1XL5s4bM1+8jEh7vgTS
         iKdg==
X-Forwarded-Encrypted: i=1; AJvYcCU55au9wlceHrNPhDFNEJJ/ptaOrdwOs1YaB0ryIC7iddat3+TvlRRSxjLUbpPAWswewyXtzad2fCyEv2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZgynvMhnmEdY0sQAJC87Ld8BPmDNmCBCLIB9UTIfeyBapjcW
	v7/PrSQ8tXwFJiWWmRkwd3qKgrZGpFoXOQ8Tx/quo9+wPORxWAMCpoTMO2lV/hLFJio=
X-Gm-Gg: ASbGncsKkG9XUGAlMKz7/TNePfmj4sR9RY5UldPebjj8m2YboMHorwUsWemDtOkgb7Z
	uqfP9rLB7X1b0YDQmisU67kH7/eJXBmQ9XH+iKIWO7oyA5/abedkEJCG2R0tTybGKbgUQY12tPP
	NfKAvyU6sG8/GZDw5CD/ql8I6x9QGx5FPHOGYi2sMC9dGmFlP0k25Tq6dbjTtpbSzkMrRlaBfR2
	Ue2gYlnJcwywHxUZITa793OY8PHHNfsSkIO4e27MBAjE3Xfktd6jqisUIrEHs79cAf9+iKq4AaX
	MXlb1F3DzQ5OZflzUvEy3NE2nx6QMdF3FOYTV40JyEbOUMCwh6WHvzWNAwNYjLUajNRioUaxl6l
	8TRVIr53nebNH4nE6lg==
X-Google-Smtp-Source: AGHT+IGhA4rMEe2VrDFUP8QXdGsWvzZGFh7h4ZPkXbLqb1oWGSF8vld5DLTvTW/ITvReqH+4qplLdw==
X-Received: by 2002:a17:907:9686:b0:af2:42e8:ad9f with SMTP id a640c23a62f3a-af9c6516b7dmr1378807066b.39.1754989882646;
        Tue, 12 Aug 2025 02:11:22 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af91a21c081sm2145677066b.97.2025.08.12.02.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:11:22 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:10:24 +0200
Subject: [PATCH v8 3/4] can: m_can: Return ERR_PTR on error in allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-mcan-wakeup-source-v6-12-v8-3-6972a810d63b@baylibre.com>
References: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
In-Reply-To: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3540; i=msp@baylibre.com;
 h=from:subject:message-id; bh=PUGgDDQWFyEN8FapYMcSYXBqOMRdjtFyBA2weB75KGU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZrNqaC64Z/X37Vif62uzJPgFroxXSz6XcXDZxg4sB2
 zk5tyqmjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhI1hVGhs2aClvMvr4Ja/aw
 1WR6XuFg/PfRnmUCzCp/co/oeiuYXWRk6J0W9GpPQ2vSjf/XSvWafk2wrxfP83X//5Hzql6KxIe
 //AA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

We have more detailed error values available, return them in the core
driver and the calling drivers to return proper errors to callers.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c          | 6 +++---
 drivers/net/can/m_can/m_can_pci.c      | 4 ++--
 drivers/net/can/m_can/m_can_platform.c | 4 ++--
 drivers/net/can/m_can/tcan4x5x-core.c  | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c68c95cc97075ddf72dbd2f177a999a09b8a21ca..e08fae5ddf5efa8345670dd50d50954ec5d52b29 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2392,7 +2392,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 					     sizeof(mram_config_vals) / 4);
 	if (ret) {
 		dev_err(dev, "Could not get Message RAM configuration.");
-		goto out;
+		return ERR_PTR(ret);
 	}
 
 	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
@@ -2407,7 +2407,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	net_dev = alloc_candev(sizeof_priv, tx_fifo_size);
 	if (!net_dev) {
 		dev_err(dev, "Failed to allocate CAN device");
-		goto out;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	class_dev = netdev_priv(net_dev);
@@ -2417,7 +2417,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
 	spin_lock_init(&class_dev->tx_handling_spinlock);
-out:
+
 	return class_dev;
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index 9ad7419f88f83016e93667f4847fe536eca39ad1..eb31ed1f964491ab41c7811be317706a09951390 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -111,8 +111,8 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	mcan_class = m_can_class_allocate_dev(&pci->dev,
 					      sizeof(struct m_can_pci_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	priv = cdev_to_priv(mcan_class);
 
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index b832566efda042929486578fad1879c7ad4a0cff..40bd10f71f0e2fab847c40c5bd5f7d85d3d46712 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -87,8 +87,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class = m_can_class_allocate_dev(&pdev->dev,
 					      sizeof(struct m_can_plat_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	priv = cdev_to_priv(mcan_class);
 
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 39b0b5277b11f5cf86137528e7ebea93a6d29c80..31cc9d0abd45360de8700d0a0270af8d3e42967d 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -416,8 +416,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	mcan_class = m_can_class_allocate_dev(&spi->dev,
 					      sizeof(struct tcan4x5x_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	ret = m_can_check_mram_cfg(mcan_class, TCAN4X5X_MRAM_SIZE);
 	if (ret)

-- 
2.50.1


