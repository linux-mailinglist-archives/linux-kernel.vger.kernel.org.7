Return-Path: <linux-kernel+bounces-871680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A9C0E0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C771419A6CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1325FA2D;
	Mon, 27 Oct 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="XFwbodya"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4A23817D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571822; cv=none; b=n5Kpd4ch+9O8t3RX8AWLucQlGwceUHSejmPlS/mzU1awPCAmxWgDUGjT3koi4wu1jfNg1fKjwBKcb2RoNEIp4F9wKaD2E/iAwqKwLECByXnpVO5VlT81Pw5vq3kKO4M2sn5eiu5DxPlWCtiJyM156wa2JDArUVEgRInUeIpg9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571822; c=relaxed/simple;
	bh=h91Mh4hoPgByHdcKd6/RneQUViXMJHcN0u0JxmaBjQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFP6kIRZvYx1y6hbgXIFrOoFu9Bipu30fYZCjWnkygKOHykA2MPoAvSlO8wJ7FEzKFklrRXvNy/S24CvNfKBMCPp7JPKAR7t3UOYHhbMzSCNMglKGnGwdB+zsk9sCWQo/7dUT1vEEHyDaWyQmS1Zc8ckz4/qVCWfMMVTBnmIONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=XFwbodya; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430c17e29d9so19345535ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571818; x=1762176618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXEnNR948aKFzOMEVavf8q+kCpka+pPq8yUEtfNzTFc=;
        b=XFwbodya7ASLTFrUJZnH3e1+gvWRhoQYr9B1ytUZYVTRuhQ0fQ8Af/Kgkf4IoxcjTI
         IDzoVpEMe2y3pL0bpfCA+b+BZMGcDVOGC3n3pzNob865kA95FqDEMfZvLWmNTDUQFNmR
         BalfJVwRT2Hrx+atarXkRwsQO3Lz/dig9tKQt2mAL0RLQ0MsKo0I5T/mKqgIZiD0kfj7
         LTaz1U0Hb/oMjZ+KzcDNBMvUDbPWdpjHybLnemSExi0Bvn2PlYK/ghNmCe27+7gLAiIL
         LhN9JgyPh89uYKcNMyaxk0VoGIl4H6FJsughZjRHhitwC2Cs16715B7Kh8+AZ6X07kSA
         CEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571818; x=1762176618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXEnNR948aKFzOMEVavf8q+kCpka+pPq8yUEtfNzTFc=;
        b=CjRVb0cNn4aIQgXbn5JzKd0wRjDQHB6TbYThilZjNwOarM+B5tMmWbEOBi24n/vVpg
         F/vGBZFOkN3GN+XyiBxsRumRLHDD4CBPZTUUvsPPtoYvZgqXntIETwoGmM0NmOar14Lg
         qIQNeObBmZlIawSmJrPdRslsFmqfYJA4MCTQ0fXSDFZIl9cC5ES5H/p7+0DE4PFLy6+L
         xay9DtNbzVAQbDn9HY5ovh3rqhUS17Q4A8+RuPYJ0hAJEDB1+PZsEf3LWQz8/8FSEmIL
         mZcvwt8RC+7yzwIxN8ehbPznj7iZ9vHki+VmZUt2CDo6Cd3Zvo+BqPMSFFnzBEhlyxTX
         wlhw==
X-Forwarded-Encrypted: i=1; AJvYcCVCo4gwFOwO49aZuY+4p2CJWNoFIVgLFDAtsjrumn7pGY+2GPwp9PFWzIR/PcrxsIfEMZoumCxoLKELFQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNrHucD8JPdgRGL0kBOymbnh8/XpjV8asTutZoT0WHOKvpkv3z
	2Mkoqf6It+F1lxuGrqPpMCyCRNhpGjJtuN7m8X7snyySfcUJe3/uVUgbpKr9DBQ5zZU=
X-Gm-Gg: ASbGncvZFsallfIr++NQCZIp2Ytxd4XqADhLR1rQ/S1zINFvbxXq+1Xa1ynoqG4z1uJ
	wB21Ptp8CN9fQHGpFf2qhTchARGrtOptqUkbgY/200+tDm+RsWbEZyNhYgzbsc1bF45oEHGYs5v
	L+gUfzQXB7qiT+BnzMVBAC+I1hyaHDdByXoruTJI0D46tDm9LogSX3y4RH+x6DRlGeUIELUnLS6
	cmSQXN/pkYG1m+g0Bn8c5hHChMJ9XPCCswjyCEYGoy1t3T6TXqM1bbTXX6+5+OSwnobhyU8Smwn
	Ic0nGDoi55gW9Xj32poix+js+idw9mGy9TdD+Aj5ogJ4S0d3RQwHvi4tCGKjUtjv2Im7uu6WRPw
	VGBp2GMjGly1ec+202eebP0wCj/1TmOHGzKi1AFwilYTaMcR2kfAF9Fca8ej804mkDfp1wiK3j0
	Ahzzog7I0QE0/6Ome7OeVk304EQXpkL5TlXmoxhd8Mt2c=
X-Google-Smtp-Source: AGHT+IH0glKysst9aA3Dl1hO2CkWup00aLcqDqNV6Kijix8yVXf6s0ExlLzii7wtaTpwbQLaOSZlgw==
X-Received: by 2002:a05:6e02:2689:b0:430:aea6:833f with SMTP id e9e14a558f8ab-4320f6c7f59mr1567415ab.8.1761571818580;
        Mon, 27 Oct 2025 06:30:18 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:18 -0700 (PDT)
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
Subject: [PATCH v4 3/9] spi: fsl-qspi: add optional reset support
Date: Mon, 27 Oct 2025 08:30:01 -0500
Message-ID: <20251027133008.360237-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
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
2.48.1


