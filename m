Return-Path: <linux-kernel+bounces-863975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD65EBF9A29
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B26DD4EE3DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CF91CAA92;
	Wed, 22 Oct 2025 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="aIU7weqm"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143027081F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097575; cv=none; b=GMZFg+pBKauixxxUKiqU+QrggmJZufP5vDRZ365VANpdcYGhO1aK1N4/+1KoUmxfEToHNTwoQw1+FSsiu5UoOaUI4Hd9FkVwZkHktFNQzxZ7v3NLDSCPNEnXqwxVDSyhVJ7sR7RmhZdDAcj9fnBHt9zwk3rqyTuiXZR0d8Cekkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097575; c=relaxed/simple;
	bh=91SF0CerLZEBFUXVC7GfrfHZUrgGDtrRxmHGYgJPn3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBo3cyALTldUPjWn7QEMfn7IDAyKrADIrQ9MsnTJaECIIse7P+PJNUM9LotDbcW548SSMoUTWaCsqYTxFBXMvGE+GJ1qpOG6NFIHea0QYp1MQo2+MDunv55nnmiS10Moj6Eqoj6hogu0QhpHYVvtN2ABaKPvGNH7oT7uZWEhFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=aIU7weqm; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AD7792C0241;
	Wed, 22 Oct 2025 14:38:02 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1761097082;
	bh=/MbsSW3+Q9BLBlm5Zj/MlkP5p2oUX/nDrISBbxMv0L4=;
	h=From:To:Cc:Subject:Date:From;
	b=aIU7weqmGR8oKtXCsz5CVMJA0P+t1Z1uwi4F1RxEygGoZNpoRrLxHWq1C9NSHgMCT
	 6ek8WHH42EHM8RK+8rW6lC7hrMS79dq4EAY5qb3KY5GCe+Dim3gmD2XYMeEkw0WeK6
	 QO3eMRitYR0IZ+hFuhVaIXGnwT2fNjf9JY4wHFEIRh/atVmmG5CaSIvnP6C9gKCd1g
	 oq7Z8k7B9ZFQtdIOKCJU6EAuBT53d4IHX8fYXLp8vp4eZnqNYrdDpuPw2nbIy4uYnr
	 urJUjDTXiDX4kfGaVzVUsyLtYYPjWVe8AWpiRlqz2jImpnQYN7nr000GNSybLkgXBh
	 cHsWSj5e7pOuw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68f8357a0000>; Wed, 22 Oct 2025 14:38:02 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.12.16])
	by pat.atlnz.lc (Postfix) with ESMTP id 79A7913EE36;
	Wed, 22 Oct 2025 14:38:02 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 751342A0433; Wed, 22 Oct 2025 14:38:02 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Elad Nachman <enachman@marvell.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v0] mtd: rawnand: marvell: fix 8bit ECC layouts
Date: Wed, 22 Oct 2025 14:37:52 +1300
Message-ID: <20251022013752.2381694-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=NbFF1HD4 c=1 sm=1 tr=0 ts=68f8357a a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=x6icFKpwvdMA:10 a=JNAATqg39HOsAI6RquoA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

These were modified to appease a check in nand_scan_tail. This change led
to the last spare bytes never being written to or read from.

Modify the fix by restoring the layouts and setting ecc->steps to the
full_chunk_cnt value in the 8 bit ECC cases (4k and 8k page size). This
allows the driver to continue reading/writing all chunks while also
passing the check in nand_scan_tail.

Fixes: e6a30d0c48a1 ("mtd: rawnand: marvell: fix layouts")
Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/mtd/nand/raw/marvell_nand.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
index 303b3016a070..c20feacbaca8 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -292,10 +292,10 @@ static const struct marvell_hw_ecc_layout marvell_n=
fc_layouts[] =3D {
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,64, 30),
 	MARVELL_LAYOUT( 2048,   512,  16, 4,  4, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 4096,   512,  8,  4,  4, 1024,  0, 30,  0, 64, 30),
+	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
 	MARVELL_LAYOUT( 4096,   512,  16, 8,  8, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 8192,   512,  8,  8,  8, 1024,  0, 30,  0, 160, 30),
+	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
 	MARVELL_LAYOUT( 8192,   512,  16, 16, 16, 512,  0, 30,  0,  32, 30),
 };
=20
@@ -2286,7 +2286,16 @@ static int marvell_nand_hw_ecc_controller_init(str=
uct mtd_info *mtd,
 	}
=20
 	mtd_set_ooblayout(mtd, &marvell_nand_ooblayout_ops);
-	ecc->steps =3D l->nchunks;
+
+	/* Validity checks in nand_scan_tail assume even sized chunks, but in t=
he case of 8bit
+	 * ECC with 4k/8k page size the last chunk is spare data, which is not =
sized to the data
+	 * chunks. Overwrite the ecc->steps to pass this validity check, while =
maintaining the
+	 * correct number of chunks in-driver.
+	 */
+	if (ecc->strength =3D=3D 8 && mtd->writesize > SZ_2K)
+		ecc->steps =3D l->full_chunk_cnt;
+	else
+		ecc->steps =3D l->nchunks;
 	ecc->size =3D l->data_bytes;
=20
 	if (ecc->strength =3D=3D 1) {
--=20
2.51.0


