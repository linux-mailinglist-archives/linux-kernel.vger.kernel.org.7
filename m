Return-Path: <linux-kernel+bounces-867513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8DCC02D15
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D21B14E3857
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75EC34BA57;
	Thu, 23 Oct 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kvb7XYB3"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A634B431
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242371; cv=none; b=k5YVxXMqLCk66ky18ztnJhcGKMqUYQUECUsDPQ9ITWrZH/DOvfUv9ZblaCi8GhVINI05lPQtrDSoqaNaUuJRF1VBW0q2dOpABOLnOnnJu+R2dN7Z7wCgFUyDlsVeLQ6mpHOZ4Imeh+2UDoGONIv3MSa5eunP3FK4f6fBOXch9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242371; c=relaxed/simple;
	bh=7lcSZM0dC9g4v/BNnBxiVygQKnTYtxHeK/OZIIXwV00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kwk6j9fbG7ZKtPuqY0P8Jgh7jvNguIlIQsS/D7NwT0DeDTLt/YqQFYP16aMjvraj3u3JxLNweJ2y0jzn41Wb8EzjHssKjckOhTq7VDQS9/i6ISqkWc/S39bYxPNIsGsBw+kwvONgzSzhTf3eWVj4tQfKmDyFJW2NLISRYR/P544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kvb7XYB3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33d896debe5so1383852a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242369; x=1761847169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=On265SWIIsjj6cFhkQLuouFdBySNyVnfLyhJagcyMrU=;
        b=kvb7XYB3HbP+XqgyX64WJvz9k6k9lQO+gNLdeXEIE/mhHRsI/2feXrOKw87J0jkVDq
         zMlTBgI0IwiDUENWRU8j8afAsPhtoPNlfi2BxrXJWyod880jt5QRy13mgo+8aK1vOM17
         i8qF0+QL1b3VpUbY4jtcHGXNjZaUuLFDM/zIsF5zFubEbk68wuUk2vJ7FeybLIqG0PkE
         +ld/zVd6O3S/lq3/o3B9V5YVHRRJBgOB8dU3Q0uQydw37thWnB6IvtKPrK/XMwIHqXGw
         gKrEKD9pEl6s8SgUF/TVXItuyJPjQCwo5xruTh5P+cKvCTq5YzIiGCxvhEpLSntUC9yV
         XogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242369; x=1761847169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On265SWIIsjj6cFhkQLuouFdBySNyVnfLyhJagcyMrU=;
        b=RN9bs/kPnwyHrfMfCWUzBBxTLHy6++6nYnxQN5gFx8bwraB7MRLCYKicZ1Ux6JMisZ
         bhlzGioijZv5bmxvNvY2Wcy59qh9StpDV893NzTwJKlkmU5HE7SAiPBDMS4RHBf68UqY
         az7JmWwBRIb+0GXY3SZN5fQ6HAGrF+fud553L9cph2xmIr2hZT3n+Vffx+VP+Yzx5z6B
         Jeq4kPdfVmGpF8w74fcwfaEsFFPU20uaRzOZeVWMuryefrcg7Z3LKgTlCV9Jp4lAdcxn
         7HH4UMYspIVggik3mM3K3niLgZ/pOdDPXdHfTQJzJHyYI5G+Zwx/L/buA5b91NLhfkRG
         2AeA==
X-Forwarded-Encrypted: i=1; AJvYcCW2M8n19uQn1RvcJyyDkAQjuZ2E9OiqUzTxmiSdrgjV7JYFqKXWk+z5ITFOofuZJ2k8iocJiRT96ZIw0zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsrD+Zv3brhzLvYodmZ1yOlZ2NrYET9GT1htSjiGkd5MUFtInl
	1Emuz6p+7X+1J4lUwhFTRl7q6g+pyQOw0ECEg7DGrTrGd8FeobtjPR//852IXUgrdm4=
X-Gm-Gg: ASbGncuU+KSZjAucScjSLL/PnE5hbR/e417l94mKsAFrGMzaJKqzsCLQK0qjqW1CpQ0
	iiMsiwvjMOuYsg90Mx7tTBLmY31sGZTQLSrF85RBGG8s2iJQ825dkBRETYbxdrCzOLGmRzapKPU
	+NqByUodiO7Jl+AC/bCV4ssAocQgDCNes6krzpthH1kl8dy0gXL2StXd0iMkryBSMpvPowAULoH
	xHCNbwmsLsIRxAGACEzSJiODNxhGB1s2+Eoc6Knq0jSRHZYtau6WwDhtOnytQiMBzoGOU6BOz3P
	blFNWzvy+lIDCkSEu6nyFX9aFqezqoEhYtmYDALQYAJdakAVyqs8qjvAb6tv+O9d3I5BatjJk9y
	FCe3m2ZeEqEY0jEMRzMeWyoymqTkR2ta5ADg8kwJEq99N6/VqBwJhuhsGOujv59N8rzIX89MOF+
	IJ7lw04A7Wg/+Xej6yzxoxYiU=
X-Google-Smtp-Source: AGHT+IHMRWTLOcYt9GF5JwdHPs17n3sdItQgiLvosy748nQ99rSr70fD9GfdnC6xjLJTc4YsYnnuZA==
X-Received: by 2002:a17:90b:248f:b0:33b:cfae:3621 with SMTP id 98e67ed59e1d1-33bcfae47d8mr20130607a91.32.1761242368668;
        Thu, 23 Oct 2025 10:59:28 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:28 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org,
	p.zabel@pengutronix.de
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 3/9] spi: fsl-qspi: add optional reset support
Date: Thu, 23 Oct 2025 12:59:15 -0500
Message-ID: <20251023175922.528868-4-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for one or more optional exclusive resets.  These simply need
to be deasserted at probe time, and can remain that way for the life of the
device.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - Added Frank Li's Reviewed-by

 drivers/spi/spi-fsl-qspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index c887abb028d77..1e27647dd2a09 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
+#include <linux/reset.h>
 #include <linux/sizes.h>
 
 #include <linux/spi/spi.h>
@@ -267,6 +268,7 @@ struct fsl_qspi {
 	const struct fsl_qspi_devtype_data *devtype_data;
 	struct mutex lock;
 	struct completion c;
+	struct reset_control *resets;
 	struct clk *clk, *clk_en;
 	struct pm_qos_request pm_qos_req;
 	struct device *dev;
@@ -857,6 +859,8 @@ static void fsl_qspi_cleanup(void *data)
 {
 	struct fsl_qspi *q = data;
 
+	reset_control_assert(q->resets);
+
 	fsl_qspi_clk_disable_unprep(q);
 
 	mutex_destroy(&q->lock);
@@ -902,6 +906,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	if (!q->ahb_addr)
 		return -ENOMEM;
 
+	q->resets = devm_reset_control_array_get_optional_exclusive(dev);
+	if (IS_ERR(q->resets))
+		return PTR_ERR(q->resets);
+
 	/* find the clocks */
 	q->clk_en = devm_clk_get(dev, "qspi_en");
 	if (IS_ERR(q->clk_en))
@@ -923,6 +931,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = reset_control_deassert(q->resets);
+	if (ret)
+		return ret;
+
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-- 
2.43.0


