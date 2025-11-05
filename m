Return-Path: <linux-kernel+bounces-887047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5074C3711D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4708634F8B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E07E33C51B;
	Wed,  5 Nov 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hHxBlpEQ"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44B334C25
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363652; cv=none; b=ppz/BTCBHiLmM9JDh1z2lljo29ep4kSo4djr3C5OAYZdMuqNp4FM11D3RsOS9lqHg4eT1nTLnSIt6v4cBg7UZulT1JI85h3dLI/EFpS0WJc2BE3fZN8i3wV6rUsSfaEIi5JgipauFh/Azxj6e7K+0puet848BGC2UgXSJD3d540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363652; c=relaxed/simple;
	bh=eThQIE/jvXOT4DOWR+X/o1T5PCOa2qjzsppR3EBwd9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFkp3M4Odc08rFCHodq32xVhzpG0fkoVZdbJuMxXlBIIkma2ktosu1eq0jnKGwOPry6FnqeUM57yv+pPgtXFBjbZ+dhcGDchLDaz30Am/5wl5h/2ieoW1UivmTMWnQcfJZs/8nXKF2PzO2mK0YuW0Yp0LBZIN8qsrPgUpT1jg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hHxBlpEQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2DB074E4153C;
	Wed,  5 Nov 2025 17:27:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 051C860693;
	Wed,  5 Nov 2025 17:27:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 585CC10B50864;
	Wed,  5 Nov 2025 18:27:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762363648; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wwGaYNz99ZwGjnDc7GOe6i79irbzdaxgzSs6VbSV9+E=;
	b=hHxBlpEQnkUHEjmN2EBgImPfeIdn4+Qi9TRm9IAgZo6jimne/zYs9HeX2P2eg0+O5QmNXg
	jjFmXewAyaUnL0lVHXoYRY2oUJNPEjzlxAuUkerLIxikcUnT8hLNy5A9iB6HJFPIxGOQYI
	yGc0ubbmATflDupMpAlev74SrLkkfjcJEYjpUl+w729Fxdb0LiV9hktve/LvYlbIaKcy9h
	vQlLK5NLuluDWyYTPL9UQxmBZceYmdYIETJFq7ZMMNpUnHyZtwxULK1fVUYCCZe1nCY6pA
	syF0lYcHNiM94pseYh+uScMBTkMl0fOdAO8UNq9Loe0TtAeTxZscDmVXyfKQHw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 05 Nov 2025 18:27:02 +0100
Subject: [PATCH 3/6] mtd: spi-nor: winbond: Add support for W25Q02NWxxIM
 chips
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-winbond-v6-18-rc1-spi-nor-v1-3-42cc9fb46e1b@bootlin.com>
References: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
In-Reply-To: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

These chips must be described as none of the block protection
information are discoverable. This chip supports 4 bits plus the
top/bottom addressing capability to identify the protected blocks.

Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
cat: can't open '/sys/bus/spi/devices/spi0.0/spi-nor/partname': No such file or directory
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
ef8022
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
winbond
$ xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450060101ff00060110800000ff84000102d00000ff03000102f000
00ffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffe520fbffffffff7f44eb086b083b42bbfeffffffffff
0000ffff40eb0c200f5210d800003652b50082ea14e2e96376337a757a75
f7a2d55c199148ffe970f8a1ffffffffffffffffffffffffffffffffff0a
f0ff21ffdcff
$ sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
679145368f2188ac975ec3f4c9b691e7e250147c13b6f18a28a9192700925d95  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
$ cat /sys/kernel/debug/spi-nor/spi0.0/params
name		(null)
id		ef 80 22 00 00 00
size		256 MiB
write size	1
page size	256
address nbytes	4
flags		HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_16BIT_SR | NO_READ_CR | HAS_SR_TB_BIT6 | HAS_4BIT_BP | SOFT_RESET | NO_WP

opcodes
 read		0xec
  dummy cycles	6
 erase		0xdc
 program	0x34
 8D extension	none

protocols
 read		1S-4S-4S
 write		1S-1S-4S
 register	1S-1S-1S

erase commands
 21 (4.00 KiB) [1]
 dc (64.0 KiB) [3]
 c7 (256 MiB)

sector map
 region (in hex)   | erase mask | overlaid
 ------------------+------------+---------
 00000000-0fffffff |     [   3] | no
$ cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode	0x13
  mode cycles	0
  dummy cycles	0
 1S-1S-2S
  opcode	0x3c
  mode cycles	0
  dummy cycles	8
 1S-2S-2S
  opcode	0xbc
  mode cycles	2
  dummy cycles	2
 1S-1S-4S
  opcode	0x6c
  mode cycles	0
  dummy cycles	8
 1S-4S-4S
  opcode	0xec
  mode cycles	2
  dummy cycles	4
 4S-4S-4S
  opcode	0xec
  mode cycles	2
  dummy cycles	0

Supported page program modes by the flash
 1S-1S-1S
  opcode	0x12
 1S-1S-4S
  opcode	0x34
$ dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
$ mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
$ mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
$ hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
$ sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
$ mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
$ mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
$ sha256sum spi*
5cff8d15609f3eab8d8008699191d5418da5b346e4f98ab67d5d89702b584042  spi_read
5cff8d15609f3eab8d8008699191d5418da5b346e4f98ab67d5d89702b584042  spi_test
$ mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
$ mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
$ sha256sum spi*
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
5cff8d15609f3eab8d8008699191d5418da5b346e4f98ab67d5d89702b584042  spi_test
$ mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 268435456 (256M)
mtd.erasesize = 65536 (64K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0
---
 drivers/mtd/spi-nor/winbond.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 580c9cb37958136e7e9fbc71152de55ab008812e..a65cbbccbbac64c83227c8158ff85abfa3441868 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -351,6 +351,10 @@ static const struct flash_info winbond_nor_parts[] = {
 		/* W25Q01NWxxIM */
 		.id = SNOR_ID(0xef, 0x80, 0x21),
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_4BIT_BP,
+	}, {
+		/* W25Q02NWxxIM */
+		.id = SNOR_ID(0xef, 0x80, 0x22),
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_4BIT_BP,
 	},
 };
 

-- 
2.51.0


