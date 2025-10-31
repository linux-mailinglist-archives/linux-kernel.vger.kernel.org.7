Return-Path: <linux-kernel+bounces-880711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5CC26629
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CBE421026
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F243350D5B;
	Fri, 31 Oct 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RD+p5LMi"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8234FF79
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931717; cv=none; b=kX4z7csCtBi3q9MZJ3DNGJEoR/OgiFFHv4+xtDgY4JlaV4oitPf+IQ+qmTd8p0a7pzhB3ZXv/GD/tT4+U1B7tBmJc8i0rr+p2/59iAFHwbmkIQmX48P7DL5y87WPF0MT6UbRCsIriwNqZ+LiWDJBN2WVsy+ZgYbWzjUiHIg+TEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931717; c=relaxed/simple;
	bh=s9QP08vtkGDYwazwgqrfFxRGwX8EU+BTdFOQiiYeVRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3uRMVafhqZrmtcwBc1mY9taI03XM02vbgLf3W5G6hwOJQ0wHQQNjI7l8rCEWc4SNF+sfSpwYk1jGw4+qtxQJWfHUKeqfZqB7TkJUDOL8zZx80Je4TIzbvNz0yRcOv5i4QyLhTpvAYo7/IdNBw30DxvyctHiss91dMRabZsZruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RD+p5LMi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D28B94E41446;
	Fri, 31 Oct 2025 17:28:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A829160704;
	Fri, 31 Oct 2025 17:28:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 176E21181800A;
	Fri, 31 Oct 2025 18:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931711; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SSScNc/ZTYByCMEF9q858dnRFAdSrotGIfTOHWGCemk=;
	b=RD+p5LMiV31QgnitgyjquqxiAyyuIQfYCl7nXRnzvC2LANs0sSmkqRx4xlfjHbGnFZ0CoQ
	/iV0N8qk3ji+C+YXK468xQBh6sXnVJpMJsEIU3QPP6G6jCZCBUMFRA1v9EbC0ct61TXHIr
	NWnq6PAYWI2enYSBP/VuIKLM3mQ9bsvKPN0I6SkLDFAyvXqnvkpMHr5prucSHYrIEbsFjl
	Bghd1fQ93xZu1bLVPijRSg8Qic7GLdmkcVJUC7J8tSybaV5kFibC2wGEypckFk/hR5ULeU
	9K9bTwUGFKJ9zACa22v0DBP2wM0Y4Re9uX46aPd1Bi0mrfJCXeteNAwMcAnkMA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:00 +0100
Subject: [PATCH 16/28] mtd: spinand: macronix: Register vendor specific
 operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-16-be42de23ebf1@bootlin.com>
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Provide the Macronix specific "read ECC status register" operation so
that the core can verify if it is supported by the controller before
using it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/macronix.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index a847ea8f49a8a7005405f6083a4aaac942974998..6b7cbcc6e2872d3369b8eb765dede05c7299c896 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -47,6 +47,9 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 		   SPI_MEM_OP_DUMMY(1, 1),				\
 		   SPI_MEM_OP_DATA_IN(1, buf, 1))
 
+static SPINAND_OP_VARIANTS(macronix_ops,
+		SPINAND_MACRONIX_READ_ECCSR_1S_0_1S(NULL));
+
 static struct spi_mem_op
 spinand_fill_macronix_read_eccsr_op(struct spinand_device *spinand, void *valptr)
 {
@@ -174,6 +177,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35LF2GE4AB",
@@ -195,6 +199,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -208,6 +213,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -278,6 +284,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX31UF1GE4BC",
@@ -288,6 +295,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 
@@ -301,6 +309,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
 		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD",
@@ -312,6 +321,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
@@ -324,6 +334,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
@@ -336,6 +347,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -351,6 +363,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
 		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD",
@@ -362,6 +375,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
@@ -374,6 +388,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
@@ -386,6 +401,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -399,6 +415,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read)),
@@ -410,6 +427,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF1G24AD",
@@ -420,6 +438,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
@@ -432,6 +451,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read),
@@ -445,6 +465,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
 		     SPINAND_CONT_READ(macronix_set_cont_read)),
@@ -456,6 +477,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX3UF2GE4BC",
@@ -466,6 +488,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
+		     SPINAND_INFO_VENDOR_OPS(&macronix_ops),
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status)),
 };

-- 
2.51.0


