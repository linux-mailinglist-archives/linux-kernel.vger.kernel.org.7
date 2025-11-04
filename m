Return-Path: <linux-kernel+bounces-884717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E2C30E11
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BD318C3CCF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB72EDD41;
	Tue,  4 Nov 2025 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNlrS3IZ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24C2F5468
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257851; cv=none; b=JnjD2VjQ86CRL02OXJJ/5MO0SveCDE9t5E6AauTWDeNvu7MXcWqiKmLxpMl2Rqgtzpxa4g4cthyiACyWf7RRI3m5pUbyub4CjkpdTj7AGD3uEJjeMfpZJ9+lkNLweJHShcWmrDB4doVQ8/+8Gyryu8rfD/PkpW4MFa/0DHhWNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257851; c=relaxed/simple;
	bh=0QxHrm9C2RbfZnvci62gAmEYua+kGV1/O6mGjSHQSUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxBBk5wNKnAHHwswXa/HeQn1KmGgMGRHq3wg7IdQDvfGkousjgLhix3WUw0jJARCvy1Iw0E06C65jJC77KKkSOLEjoMd/elD5lDcaNK/34Mvu1CtSaR0R/D6YVmxuyub73ZzoJX4Sj10+n3vitUkqn7BFw6buzZnhA94L1BYp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNlrS3IZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b4736e043f9so144131966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257848; x=1762862648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfVnfMnUFwyLNqs4rPjMOiNJ9iATrzCn1X86BIPjvdo=;
        b=bNlrS3IZb9sx57ttYwdoqDRysWYmOkUo3MJyndNkj0GrnDoGmlCYlc6HcPisxfprpo
         du0zjFNjXH/BxKEkLpXYjHltil0Hx0RcpArKozWm+J/C8kogT1VqLSGNTL4sryV0eQPQ
         sMS6ZzAvUI2dITToySaxBM9GbvKQQHZvWvbcC6Dhuul6h9reMhRSF6i7aYNm3kuVBXUA
         /nQ6OOgxTRPT++cOeL3wHhXD2qT1fNtK55AcYUEBXE4Oa7mQ/XwFswnaHCTPZr+lOfYo
         c7AooofcIg/IJ8QBIy1Xg4PmjCP+PD9R2ksr0AtTB2b73M0F1MWwDj/Jal19IZxPnm2l
         mSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257848; x=1762862648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfVnfMnUFwyLNqs4rPjMOiNJ9iATrzCn1X86BIPjvdo=;
        b=L/u8mtG0p+nuVb18bfBffCXzUdka28T8Tz73zZ+DRKDqkMpvsKbFgXQLXVPWape5kJ
         w3V+/vG3WzNyNSOqJ9CR3SZ+U4cdM/U2RY+Lt9T0xLgMtxf5ZDMl0pchvPtm8d4NVQaR
         zahTlj2pNdZScroAZRUJ0YQLYxhx3tum0YBUoDFhka0SWn+Ddj4iuy438yVfedoV0n9Q
         a1oiPfDn2+HEU4FDKU0xxl+D9d57CGaRY4L6tR8HZU1nG+XwaAVrUTU+VTq5Xu0pleMb
         I/HDPXXx3IGEtNYgpK8bzOE8r69idGlF53pYRSyPgk9JbPrUCNhrnlJcbxbduEUxxgvh
         PhTw==
X-Forwarded-Encrypted: i=1; AJvYcCWHV/eb9HuusPwRr5YdpUokhR758p1la0RTJFHyHLFgPnoJumpMqC3YpS3OKMAHsrC4JASBotc9iltxnS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5zXlrt08CJqpP4eGA/Gmp+eRZmhPKNvUxO8eGRIZSdG93c+C
	LxXx6jkg8ea7vLBWuBEpjL4z5uZaP7yq9HM95ydYDpKB5bWNjgwZv+oX
X-Gm-Gg: ASbGncv0YCcu6HLd8YydML2sdYvLx+IgejPhCBnph1a9TpjFX9EIXFw9oyD+yjV7mXu
	dvhQ2iiwnIhPRtBWlYUd/IiMdYATXyCVOffdghFOyUu2yKjQARc8NLb4vjp04cX06gfvXIRSYgP
	CxHb5Z1DCjomE2y9pQiT1adkMcqVdEtG0CC/AYd80+Oj4AIVHEdkhPf/gkvQXora3Gwu7HliAKS
	qB71nSFuuI1VFQ7h1mvKKNxRvUxGLrdgoQ+NitKLtbuLzWJ80iO0pKye19eqsbSq2jFEVO14nec
	rnizAnCxMAFWLrAa5Ag5dEo0qaSNvKr7JZB+dahV0B1tkcj/UeBCHSIvq4lW1W0OPr4qviBJeiH
	1j1KQTnX/CSIEfT3Yh15aKafZyFbRK024jLVo4jCRVGA4g1wChgqGZGrNjr2vfNuZPCmXo7/qC+
	rqs1UUYAeBf6CWD9c6QbGCvjRwvQ==
X-Google-Smtp-Source: AGHT+IEFmmFqmwF7IJGHYHQFLdfcj+i6AuRD6y5QTSlNabPHEjYgdTalWazPTsjhrKIiVzJb3z4NAQ==
X-Received: by 2002:a17:907:8692:b0:b71:a627:3d8c with SMTP id a640c23a62f3a-b71a6274340mr486414566b.56.1762257848026;
        Tue, 04 Nov 2025 04:04:08 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa038e0sm200894166b.54.2025.11.04.04.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:04:07 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 6/8] reset: imx8mp-audiomix: Extend the driver usage
Date: Tue,  4 Nov 2025 04:02:59 -0800
Message-ID: <20251104120301.913-7-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Switch to per-device reset map to allow reusing the driver for other NXP
block control IPs.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index 18a7f68aa59f..745b7e22b954 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -23,7 +23,12 @@ struct imx8mp_reset_map {
 	bool active_low;
 };
 
-static const struct imx8mp_reset_map reset_map[] = {
+struct imx8mp_reset_info {
+	const struct imx8mp_reset_map *map;
+	int num_lines;
+};
+
+static const struct imx8mp_reset_map imx8mp_reset_map[] = {
 	[IMX8MP_AUDIOMIX_EARC_RESET] = {
 		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
 		.mask = BIT(0),
@@ -41,9 +46,15 @@ static const struct imx8mp_reset_map reset_map[] = {
 	},
 };
 
+static const struct imx8mp_reset_info imx8mp_reset_info = {
+	.map = imx8mp_reset_map,
+	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
+};
+
 struct imx8mp_audiomix_reset {
 	struct reset_controller_dev rcdev;
 	struct regmap *regmap;
+	const struct imx8mp_reset_info *rinfo;
 };
 
 static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
@@ -55,6 +66,7 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
 				  unsigned long id, bool assert)
 {
 	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
+	const struct imx8mp_reset_map *reset_map = priv->rinfo->map;
 	unsigned int mask, offset, active_low, shift, val;
 
 	mask = reset_map[id].mask;
@@ -141,7 +153,8 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
 		return -ENOMEM;
 
 	priv->rcdev.owner     = THIS_MODULE;
-	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
+	priv->rinfo           = (void *)id->driver_data;
+	priv->rcdev.nr_resets = priv->rinfo->num_lines;
 	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
 	priv->rcdev.of_node   = dev->parent->of_node;
 	priv->rcdev.dev	      = dev;
@@ -164,6 +177,7 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
 static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
 	{
 		.name = "clk_imx8mp_audiomix.reset",
+		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
 	},
 	{ }
 };
-- 
2.43.0


