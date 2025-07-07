Return-Path: <linux-kernel+bounces-720648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E43AFBEBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DDC3BD105
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345228D8EA;
	Mon,  7 Jul 2025 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsfLc3bL"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27128AB1A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932005; cv=none; b=Xz2ozzamlTir5ssGrY5nUFmOaC+tNu6szW2D1YjaRSalMmA+nvMbqCPMIHhSwj16/BrpwRBDbjbo7hRX4lbkwOQCZV1inxM35W/dyqzzH95e2FitTclDuptAEH4DcEknruPLv7VPDbo+yhOLIUTlG49Q/aXrLctbnAv3XMA9Ei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932005; c=relaxed/simple;
	bh=KJpdRf6NMnf6Rt2dZ0cJp/N9YNrV0YJHu/s2iy7Kdmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWU8rrhSkWNVGw4XadMdRQrg3aQ1vURohikmtE3Xy6tOrSdsdFWMNJ+V1M7ivlDum/G5l+sETn7+se+GQN0YAxqTCMa1AEgtTEpvsT/Dbah9vRT+SOycbznKxVSwO1vVO07lBYM+pb0TrEBcl67tOmQUslVIsze17eSweCovDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsfLc3bL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad572ba1347so577050066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 16:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751932002; x=1752536802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR7QgFUkw7RoWN72KVKLvsWt9CALHQJ4apvzKDpFkZI=;
        b=bsfLc3bLGp+XbzBY01cut6Hx/ek6ruR7IQo1FtMpjD/uKmdLRGGT50UoxN6AF0ue4n
         PV/Vj5+cIfwgrCwVt0aoW86NXEYC2Zu3kgRVfZqN71Cb/fomv1hcwZiKWjvOv54s3igI
         Puep6fOfei/VtsKijZZs8sej3TL53CFua0LKwYvB19yYXW/+48wHhjJAD5c/Co+RdfYn
         +GssOG+iI07yK9+pMKwZvdLl4H07mV74GTsbqaSGelrKqc98vfUd/V2VHI7y6O7KRXAX
         5kQUX64nKJfvbB0JZ+QTx54JoxI95AA8L9eRGcUe8YvbGQPyTWDppdz+yiGqQA/91Z42
         +kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751932002; x=1752536802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR7QgFUkw7RoWN72KVKLvsWt9CALHQJ4apvzKDpFkZI=;
        b=cB8nKepVGX+SfcR2+xCPM1ylXsjSQAkISe6uLM2QWLxhwbYdxtrMvP4XaYoVuyN5T4
         YKnbAJv2E3je735Hd35of2JRXF8bAtxALgjsIRJLPYuNDDWS+V2wIeyVm22pBHCvjHSs
         ouHikuZ2AVNE4A8SbZ689SXQvShEiRfY9Ca8E4He6cHuSjfOHLlrocAoe/8h0r7dANCG
         I6J+UJelOw8SngQk6HMCO0jiu1yossVl6wXpWq8QoCNF6Ghs5lyWIjipyQasgf5GN+hS
         LGVDnll1OOTKSLky39+I1eL/oWrmDmisokR2ARsdVeK6Cxcbbl6RGxRz6KOofntCyQyj
         vvHg==
X-Forwarded-Encrypted: i=1; AJvYcCVQB/gv0ObudtqY7ISUzJ4TmORmjbDNzCzifqQWWw37dWkM8ob66EjVXMNwiS/t76W7SirWx6Hkf5whrxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YycyXL/w9Sb5RITJEwFRkX1PybTqo8uaHRN7tOBLpOvnZhJ2lTA
	3b2zCkCXfqRLmQnSlk0FS9pYOXPF6UmSHFhpdRfu4Eir7fra411OE5fp
X-Gm-Gg: ASbGncvGaxCNTui3nAPlhHm5FM97ztoKuvKzmCQJPntGIr0xymGSltPwlzRdPgZpXc7
	ztoZjwmM1J9d1o+2tVOMHNvTLxB/9HPCmX5BCeyRv/bnb057zcAdUxBMi7CrKzpQrAJ39chvOCz
	smQyORQiZ77vmIzw83uaLFlwEWwzDwwPfRonqyCs+Q5Au+HDYWBakGXZ+Bhj2X54P3PxbQTH1Lp
	dB57ksLh5YdiPl7GvjQv66a+NggEpMk1c0eRXZmsAHCY8RGWf3J7a8NIdfXymjTBhvqoXiVW8UH
	Qyh0+5OmPkS8lmSMu0tOCdVjfOZsQCdeKoWnuD7CqBMv/hhEhAbumFibFDBz50xpP1ORXca5i8U
	CLW0lA9eE2S5viJSOTZDgXUM=
X-Google-Smtp-Source: AGHT+IFbP5MkFe5LRHOPeI/e7qFg5vW/o+B53HDzNs80P8WQiqFztlyxMrGhQsVTbOFiRGtjwCCOMQ==
X-Received: by 2002:a17:907:608e:b0:ae3:bd9e:589f with SMTP id a640c23a62f3a-ae3fe7b4b5dmr1450488566b.38.1751932002093;
        Mon, 07 Jul 2025 16:46:42 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d1ae3sm781539266b.7.2025.07.07.16.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:46:41 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mark Brown <broonie@kernel.org>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/2] bus: imx-aipstz: allow creating pdevs for child buses
Date: Mon,  7 Jul 2025 19:46:27 -0400
Message-Id: <20250707234628.164151-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707234628.164151-1-laurentiumihalcea111@gmail.com>
References: <20250707234628.164151-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

devm_of_platform_populate() passes a NULL as the bus OF match table
to the underlying of_platform_populate(), meaning child bus devices
of the AIPSTZ bridge will not have its children devices created. Since
some SoCs (e.g. i.MX8MP) use this particular setup (e.g. SPBA bus, which
is a child of AIPSTZ5 and has multiple child nodes), the driver needs to
support it.

Therefore, replace devm_of_platform_populate() with of_platform_populate()
and pass a reference to the bus OF match table to it. For now, the only
possible child buses are simple buses.

Since the usage of devres is dropped, the complementary operation of
of_platform_populate() needs to be called during the driver's removal.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Fixes: 796cba2dd4d9 ("bus: add driver for IMX AIPSTZ bridge")
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Closes: https://lore.kernel.org/lkml/5029548.31r3eYUQgx@steina-w/#t
---
 drivers/bus/imx-aipstz.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/imx-aipstz.c b/drivers/bus/imx-aipstz.c
index 6610251f41c7..5fdf377f5d06 100644
--- a/drivers/bus/imx-aipstz.c
+++ b/drivers/bus/imx-aipstz.c
@@ -26,6 +26,11 @@ static void imx_aipstz_apply_default(struct imx_aipstz_data *data)
 	writel(data->default_cfg->mpr0, data->base + IMX_AIPSTZ_MPR0);
 }
 
+static const struct of_device_id imx_aipstz_match_table[] = {
+	{ .compatible = "simple-bus", },
+	{ }
+};
+
 static int imx_aipstz_probe(struct platform_device *pdev)
 {
 	struct imx_aipstz_data *data;
@@ -49,7 +54,13 @@ static int imx_aipstz_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	devm_pm_runtime_enable(&pdev->dev);
 
-	return devm_of_platform_populate(&pdev->dev);
+	return of_platform_populate(pdev->dev.of_node, imx_aipstz_match_table,
+				    NULL, &pdev->dev);
+}
+
+static void imx_aipstz_remove(struct platform_device *pdev)
+{
+	of_platform_depopulate(&pdev->dev);
 }
 
 static int imx_aipstz_runtime_resume(struct device *dev)
@@ -83,6 +94,7 @@ MODULE_DEVICE_TABLE(of, imx_aipstz_of_ids);
 
 static struct platform_driver imx_aipstz_of_driver = {
 	.probe = imx_aipstz_probe,
+	.remove = imx_aipstz_remove,
 	.driver = {
 		.name = "imx-aipstz",
 		.of_match_table = imx_aipstz_of_ids,
-- 
2.34.1


