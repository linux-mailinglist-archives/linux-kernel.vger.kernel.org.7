Return-Path: <linux-kernel+bounces-861362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3449FBF2883
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCF404F1FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993363314CD;
	Mon, 20 Oct 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="AF1rsUlx"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB3330317
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979124; cv=none; b=MisbH8t+4zq90Co7lMfuRPWg1ilwWITUtvdEzy94tG283D2YhOgqhaEGeVYuU2AjVXfeYtQ6xEDjbepKMijj36ddINCKGUHUTP1CEoDFNT6fHLG8dtih65TXyd2SmVszvn2w4Rt8AdjqQAoE1/bOc/RLOJCQTltlxSyiiXiPYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979124; c=relaxed/simple;
	bh=NVCZabHEL1WTH8+GxShWLpaijc+G+GBkOY3veIVd+BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5aKDFWp4hDqtUyGHinrZ5ngadaJoXE0fcKI7gMrFA35TLlv/BkQTUgHyJwfXZ1ZssVF1N6+4CE7/yJoV/+JXIUCX3IIiO281vvtmytDJtHbc1ylrf1ihezWrJnyKM/44nofQhy0b0Y17B77+z5AT2KVgMIDbL7FrjcL0oUbekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=AF1rsUlx; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430da72d67bso8197075ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979121; x=1761583921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AztIAt2eykX0RjbkZdmQk0KjjmCuZftCSORZ8HPCkE=;
        b=AF1rsUlxzwByVYo7a3QdnCcZtcF/1/hCbHwpOiHXUr9Y1GWSW7Fa//nMZYWcJQyVNn
         trTzaf9+tRvvCGSqh2gdH3qmkSYS1ahXG5KlNLWGY1jmGPEqH1Qn4RGiA6xoiiWaVgbX
         wvOKrlOPRgfl2imZPNhHNJFmozJRwaMHkKRNI7IJde2FODNQAfyHlWIY1eByjLyTLSyE
         YrbjQnjZ2Os+dycpfEc/iL67+HVDYg44/EomzwgcBdegy6BUt2lAtZ8pFx5oDNfoc6wz
         CCDs9RpjTKhizV8ltmqlsI23y5q2iPtAphJ2GN3qYd2XIlgPh6iSHkoacpitr6YOjs1q
         Fykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979121; x=1761583921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AztIAt2eykX0RjbkZdmQk0KjjmCuZftCSORZ8HPCkE=;
        b=FsszowolcLbF64Y75D2yXHtWqq6iYnHgK7ADkCcQkl4g2vumqiyIATeJJ+dPPwiJTw
         oe+07RHIdpmiu39dm+An2XakjAIrbbP3wCN5FWHIjsKaUtbPmW8Zc4ifeLKTrj7S2EL8
         WCzI9AICwPbQbwXUYeeYObIb2gIeGitCgyFOdHjUs8BjUeQV+E4sUFDWkPlQ48qD7m+a
         hZDTr1VkrDwlIhfqhgI00vCIe5AXSrimheI3z1NY9EwSGqXgGkrlAw9Xa2MXA8Me25++
         ZZU7mx8pp+ayXCiXBaj8IdSEAW6RScihAHP4VvVHVfqtqK9weNkvFCZdkZeE45DG1p3A
         hW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEeEoH4UD8f+WfHU0/aaLT85yzIS8GnfF2jisifUHdV1HY1HJZheGEDbYKkqQKj8THmnqVuWr3ZSw4DLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzDxjsLvsMRsgFCdMxvhUbzglz+WhIdEB85Oey/89o+lPfjNAU
	rXwSpR2IM/b6S4rcnmksEp5irRoHlgBlUp24pUnpxOXLZ1vualIGngwrfXhJvzfyDsY=
X-Gm-Gg: ASbGncsey46Ej/3HA4I013ktHJNeJPLWwgv6jrPAP4CHT8IvkJCPdEg3JAVCJP6jMUI
	fDxeCN1bB6W8WEZW2Ib/O0tl3d8wreZOM0KEMgO5IaCVv+RARoOHXGght3WMiHGPWcbBOAnqRjz
	J9KhdbAIzTxhByChO5YnU2SjtPUrFWUha46K5EXjt5qjXyYOYKiGn9ao/e4QjbaWZ1g+99PIyVY
	hNcmAd8D2llm0Bq9wy2U2FUcenkkG4W6yeRPixTAE44GDY+nc16WOEOWnkt4O78duI29N6uLaXF
	9OVGlk510OGRKhviNuI+WgE0edh2YZV3w1vaf44KAT52157MymxBUEsY9LcSSIM76P0Htxno+UQ
	lhLNifTX6vIkUbThQmGBCaY5ThKpDPteWkf8fF2VJMkAANaGV1JtolL77ozKyk3zC3nxTViQSEB
	8Q2Qy7dFsF/0paO4MioQQh7hrMcfRQjZxEPvgi0kDhtWycXlcpJvcp4w==
X-Google-Smtp-Source: AGHT+IFtVH7UjM/87oCHJ6DUbsAetp8PBWDPda8ZOgIZ6EU4bkSIEhABKs7/sgWo14aF9mEKEUu9sg==
X-Received: by 2002:a05:6e02:1745:b0:430:e5a4:6f26 with SMTP id e9e14a558f8ab-430e5a4724emr31688155ab.6.1760979121057;
        Mon, 20 Oct 2025 09:52:01 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:00 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org,
	p.zabel@pengutronix.de
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] spi: fsl-qspi: add optional reset support
Date: Mon, 20 Oct 2025 11:51:46 -0500
Message-ID: <20251020165152.666221-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for one or more optional exclusive resets.  These
simply need to be deasserted at probe time, and can remain that
way for the life of the device.

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


