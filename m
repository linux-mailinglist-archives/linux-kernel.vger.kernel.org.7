Return-Path: <linux-kernel+bounces-827564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F82B9217E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D7A1789FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D229B30DED3;
	Mon, 22 Sep 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b="ghAnVNKN"
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3D2D876A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556622; cv=none; b=FRpxcysbaPq9WKPe6C5ubHymogooWM0nSgiImNIMm1YtcgsnQTtjOk1jnVMIZj8k3ptFIJp4CRHSFy6NlFDTgk/Q2MTjB7T1G77EDtSu7lOMxa2Je4b+1ZcM19swOFZM8tLJGE4qZoHl/llAaozALkq3+FGZrRw+GRMJ9uIpQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556622; c=relaxed/simple;
	bh=xOtc8YxJJUdB3wzAFS1kFTt7s4D8hxt1QMhbLXvRA4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka5Gip+9YbHJ3O2bsvE4KcqYBSFDl86Ud/ORPvqg1pPo9ZenX8MH7RhYd4JHYQPMYKKPgJJFqSN2NtjzKDsgCk63kRKd1IJYJLM3WcJh2mYJKY7g8BiwBdtRnDj2M91D6f+3nbm7I2MkCPUQL0iAJhrlWjkxMPOgnWf7ar4wiCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be; spf=pass smtp.mailfrom=zanders.be; dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b=ghAnVNKN; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zanders.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=zanders.be; s=202002;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=gluDp5vbGgiV/wuQkAXOB8YAjopU7SBxzSEGFDygyC4=;
	b=ghAnVNKNkZ9q6Hiag00nqu5VTxSAlfIndUVOZUfzIFXbAoNortAMD0J+Ikoi1db5umLDJYPZ35OZX
	 mYQq3z9zcsUKBk795+ZUKQGHHX+7t+Acg2IDlfwSfenHPYqfJm2UwnxtL7tbaQ0+RZy0ed35T7liFz
	 yln/ooh/1zNV7dyvo/DRTeMXmAuz+2BaAyC3s/xv6lEdvfsuS0LBs7VHs0hov0ad221tLHerXlKSeu
	 mfgNeLNBn0/TiTvuZQhgBIgaDFoSvrO0WRPyfHVF3OFuY7KtMeWOq9MIMiNnHu/UgqrsiXpS6L2lt2
	 0GnjuBUa9licRnXYM8OnwpyJ+a8jazQ==
X-MSG-ID: c17b4109-97cc-11f0-9d69-00505681446f
From: Maarten Zanders <maarten@zanders.be>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Boris Brezillon <bbrezillon@kernel.org>
Cc: Maarten Zanders <maarten@zanders.be>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: spi-nor: add configurable RDCR opcode
Date: Mon, 22 Sep 2025 17:56:32 +0200
Message-ID: <20250922155635.749975-2-maarten@zanders.be>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922155635.749975-1-maarten@zanders.be>
References: <20250922155635.749975-1-maarten@zanders.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new flash parameter to hold the read configuration register
(RDCR) opcode. Default to 0x35, which is the JEDEC standard.

This change does not alter existing behavior but prepares the driver
to support flashes that use a different opcode to read the CR.

Fixes: 10526d85e4c6 ("mtd: spi-nor: Move Macronix bits out of core.c")
Signed-off-by: Maarten Zanders <maarten@zanders.be>
---
 drivers/mtd/spi-nor/core.c | 12 +++++++++---
 drivers/mtd/spi-nor/core.h |  6 ++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ac4b960101cc..ff537bdad401 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -484,7 +484,7 @@ int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 
 /**
  * spi_nor_read_cr() - Read the Configuration Register using the
- * SPINOR_OP_RDCR (35h) command.
+ * SPINOR_OP_RDCR command.
  * @nor:	pointer to 'struct spi_nor'
  * @cr:		pointer to a DMA-able buffer where the value of the
  *              Configuration Register will be written.
@@ -496,13 +496,16 @@ int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 	int ret;
 
 	if (nor->spimem) {
-		struct spi_mem_op op = SPI_NOR_RDCR_OP(cr);
+		struct spi_mem_op op = SPI_NOR_RDCR_OP(nor->params->rdcr_opcode,
+						       cr);
 
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_RDCR, cr,
+		ret = spi_nor_controller_ops_read_reg(nor,
+						      nor->params->rdcr_opcode,
+						      cr,
 						      1);
 	}
 
@@ -2893,6 +2896,9 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	/* Default to 16-bit Write Status (01h) Command */
 	nor->flags |= SNOR_F_HAS_16BIT_SR;
 
+	/* Default to 0x35 to read configuration register */
+	params->rdcr_opcode = SPINOR_OP_RDCR;
+
 	/* Set SPI NOR sizes. */
 	params->writesize = 1;
 	params->size = info->size;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index ceff412f7d65..abac5fc45ca8 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -61,8 +61,8 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
 
-#define SPI_NOR_RDCR_OP(buf)						\
-	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDCR, 0),			\
+#define SPI_NOR_RDCR_OP(opcode, buf)					\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),				\
 		   SPI_MEM_OP_NO_ADDR,					\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_IN(1, buf, 0))
@@ -351,6 +351,7 @@ struct spi_nor_otp {
  *			in octal DTR mode.
  * @rdsr_addr_nbytes:	dummy address bytes needed for Read Status Register
  *			command in octal DTR mode.
+ * @rdcr_opcode:	opcode needed to read the Configuration Register
  * @n_banks:		number of banks.
  * @n_dice:		number of dice in the flash memory.
  * @die_erase_opcode:	die erase opcode. Defaults to SPINOR_OP_CHIP_ERASE.
@@ -384,6 +385,7 @@ struct spi_nor_flash_parameter {
 	u8				rdsr_addr_nbytes;
 	u8				n_banks;
 	u8				n_dice;
+	u8				rdcr_opcode;
 	u8				die_erase_opcode;
 	u32				*vreg_offset;
 
-- 
2.51.0


