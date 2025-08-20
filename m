Return-Path: <linux-kernel+bounces-777708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4BDB2DCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70133BCFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CCA31DD8F;
	Wed, 20 Aug 2025 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F/YnlXhF"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C6305063
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693789; cv=none; b=GzT2WYbpOJ2hr2R4Ixs1fqZoa9cwFwLpBEwiRvWbTc/TKU+GazEg49DtofPfhJzkpMo99BRni6SOEu9y08rieyfR+acxDIf0kZ5xkxsgcc9Tg2NO51NTsMDhGrsVivgGju0wubc1pGE6FWqOeZRRC29Kakd3Ykzwgx1AyQUMbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693789; c=relaxed/simple;
	bh=PUGgDDQWFyEN8FapYMcSYXBqOMRdjtFyBA2weB75KGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qk1GB57dOrxJcduIQbWaySD060dv+9VSNx2R2dbupdpS5Fs3YGz4qEkknlUoPBlBjIpme4COxFMu6FgjLoNdcmoOyPUeiDC0xEIgqYw6lp/Ug2N3W9Jh77rdTIRS1SIiMK4BVkuuzleN3Zx50KsuktGEH7oIuUMCO/9we+oJGEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F/YnlXhF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b5b1f1cso7516490a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755693785; x=1756298585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtVswNnng5a3i7kggSLAURNiGU+X7VfdWUXcHsf9Rh0=;
        b=F/YnlXhFvc5J0443FQq3YcuMFOltY3A85skaAUIEwq8CJKWnVijIWaARaEEkKVLcWe
         8cSuqBu4P93EZzI4ZZNogxpJBNUvwDgHG5ZmWjy02YAkYjZroBzN3MRddH77EwZtScB/
         qScVunuZsXcrvW1lXQsoG04JaoRzc8OuPtC7fyIKO/33m+iEEkd6qO5AcG4sTjBCjvCQ
         4f4I+SuFqhoOB3k+COAGt5lyP+zokzisTWCXd5sato/kP6e9Igoo9bNqZDiiRMXtc53s
         lTPxJbigGcDNLbsWGiGEHky6KKE10qywXsmREvfG7+CuPkK6oWVh0dgwOVJwi4130BHd
         fhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693785; x=1756298585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtVswNnng5a3i7kggSLAURNiGU+X7VfdWUXcHsf9Rh0=;
        b=KcU4P5aVGnOYe7quH/eKks63qiwnmHk92mmIdeJH7WK67/9RvlroEj4KO3zARwhqjF
         W9Mk6FwUEVBEtnSt93T/qxKW1ueY37H0xIkTtxWPd1eeWV2Ag/T2TFfJkgybDl0tFtLw
         WY6QO1SGx5iQcogWw4ahBNG1vTJVuSFAQS+ak+GS5M9bdR/OX2Jwm9q6INYX7AdTU9ax
         OgTNx0pyXNKBFLpu6l2Fk05ytMKiMtHS+hvKe9xaWhOUVLR8cKTDuUlMhQAlkL9jIqe0
         FTmYun7Qp703q7q35W6IqMuWCST+9yfpvRY/TefFl8XA5+mnA9Jf8yMbsUp54mrUBfrX
         mM9g==
X-Forwarded-Encrypted: i=1; AJvYcCVujSNSbhVHtdOd84i0akb6IJURBKJBYqgdO+DFJiVKainzVdHiHTinYsOuMuyV3eKvoH/TGgJCbPaB0Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5U6q1GAL3W8mnA6VhAWuYJEcnmGZSMU/kZQIIsUVWOEU56Pe
	SsKPmA2SjRtlFmNgCe8E4BxNMzNPNhaA5SCz3A1P58OqLjIMpsHOlUBYiJyPncfZG2M=
X-Gm-Gg: ASbGnctagG9rky397Pns6gN+FNipPpK7NXWskcihrer8iHyFNzBhm8Lqfp4QXlAj22m
	Cuq3dniD5bWqjPiF5cEpMr+wJ+5SNFF01CS3uEzQfegYXu3pWSgcvbFN/nF/m+dwSiH9vRw7cNl
	ePIdIKN2TXPcfAyp7YyQILCddvZz7C3UUK0y2VnVswd3Jzp7BofmPuuV9n55zW3Kl1/aqBvUZpg
	bQyIt/D0llu6rUhfPztlw5dcUlnut0j8eXZnSUc1TxHxvo1x3+DjJTaP6rdndPGF9jKDyRgdMCz
	JmstJRnnfNra+V5k+A//ypPzWA9mORSxx/KKgVl4h/H1MiZ+f2tbm527iWZJWUziwN1uWWs4k6O
	qnul437uJK/t3hO4+CdXMjQl2/G0W
X-Google-Smtp-Source: AGHT+IF/D1na5o3T1o+6/k8oMdlTut6OQFKYUt+9oMli+Ebsak2sybwNmJQKo1CM0+TjjYexm6kMCg==
X-Received: by 2002:a17:907:6ea8:b0:af9:2668:4c36 with SMTP id a640c23a62f3a-afdf028af9fmr232646366b.48.1755693785168;
        Wed, 20 Aug 2025 05:43:05 -0700 (PDT)
Received: from localhost ([2001:4090:a245:849b:bc8d:b969:7631:815])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded478feesm171268366b.64.2025.08.20.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:43:04 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 20 Aug 2025 14:42:27 +0200
Subject: [PATCH v9 3/4] can: m_can: Return ERR_PTR on error in allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-topic-mcan-wakeup-source-v6-12-v9-3-0ac13f2ddd67@baylibre.com>
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
In-Reply-To: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoylh078CI/9tZR3Ucj6c4ue3471uyK2VH//wxWRBtoR6
 x4cT1np0FHKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQATUWlh+B+x3NldUev2UZ6i
 m4KfXU2rVijHXtFu88nfrGP8YDL7tQ2MDM847s4p/nx/wmfJJdESc09bKorJWfha/LXd96U4xfR
 XAzMA
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


