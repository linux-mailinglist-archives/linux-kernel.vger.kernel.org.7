Return-Path: <linux-kernel+bounces-867929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E64C03F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFC2B4F73B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134C318C933;
	Fri, 24 Oct 2025 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ja96+Ccw"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003E61FFE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265200; cv=none; b=TL8cqs3jxUrObDVsAoJYxX3j2o2zx5beNBW9E44dIckCIPfokhKFoBm3A+Egkt6k5QOtlnaeiy3VBsTxlQ/G8E+/WJLYTbDxyAprzP8KkaF1i9G6JqqyfuWEN+tx/elrrjrq1RLFufkJqozJNqoKuXMyOD3zv3h5NSFZIYeggAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265200; c=relaxed/simple;
	bh=dm7/c9bb0REvgJNyYmPMxF1V7DMMb9c4iJy+pOclAA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIflhjunWQbIbZ4MSustwebXyxIcxUERYx2+N77OMCKafj9JhTSWs9FBPbCS93A4yC6yaQfBOAHsC1igfyKy+DCrCQ+W11S+EgmgTm8wcqGYgfOxROKbZo74XL7vfSgP4Np70W2k/8J5NlAUT9juAsOEaz90e6SLWq16MG02IMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ja96+Ccw; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 373002C02D0;
	Fri, 24 Oct 2025 13:19:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1761265189;
	bh=llMjB6+kanojOxFgrkopncfGYac/Q7a3EaLJjzWLC3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ja96+CcwHN4lWZHpOvxzI8ZXYHXZtDwDNgWZ7/rOH3fuTtYmj2c+F3lE+1PKNHtJo
	 RNsPdCa7asogIdIqGg+vaxGFMZOJbF90a+7Wxqx/51sJeofEWrwJMlchpN8D/LD/rH
	 aXRKoUqpxJrgs+vD7Ox8XWYIs6/gPeH2fiD/SST3SPu9r7ZSWpiZPNPRyuvikdMhrD
	 VuJPJlUHK1G4JfwB/QHDvdvUIRMJz4yapDVEwUdeHG+4lvhy0iIfqRdj6eFKLBzQK3
	 OfAYNISCcwdrge5Qb8FO03bVLMqxRA29Cy6/HQs+rDMnOhu1+77DGd7Yl8AlLyMvb1
	 KW6cnYbsn9UWw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68fac6250000>; Fri, 24 Oct 2025 13:19:49 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.12.16])
	by pat.atlnz.lc (Postfix) with ESMTP id 1047813ED0C;
	Fri, 24 Oct 2025 13:19:49 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 104A82A0433; Fri, 24 Oct 2025 13:19:49 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vadym Kochan <vadym.kochan@plvision.eu>,
	Aviram Dali <aviramd@marvell.com>
Subject: [PATCH v0 2/2] mtd: nand: relax ECC parameter validation check
Date: Fri, 24 Oct 2025 13:19:42 +1300
Message-ID: <20251024001943.29557-3-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024001943.29557-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20251024001943.29557-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=NbFF1HD4 c=1 sm=1 tr=0 ts=68fac625 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=x6icFKpwvdMA:10 a=jVrhuUISFK8t4rmaT40A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Due to the custom handling and layouts of certain nand controllers this
validity check will always fail for certain layouts. The check
inherently depends on even chunk sizing and this is not always the
case.

Modify the check to only print a warning, instead of failing to
init the attached NAND. This allows various 8 bit and 12 ECC strength
layouts to be used.

Fixes: 68c18dae6888 ("mtd: rawnand: marvell: add missing layouts")
Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/mtd/nand/raw/nand_base.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand=
_base.c
index c7d9501f646b..ad6d66309597 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6338,11 +6338,14 @@ static int nand_scan_tail(struct nand_chip *chip)
 		ecc->steps =3D mtd->writesize / ecc->size;
 	if (!base->ecc.ctx.nsteps)
 		base->ecc.ctx.nsteps =3D ecc->steps;
-	if (ecc->steps * ecc->size !=3D mtd->writesize) {
-		WARN(1, "Invalid ECC parameters\n");
-		ret =3D -EINVAL;
-		goto err_nand_manuf_cleanup;
-	}
+
+	/*
+	 * Validity check: Warn if ECC parameters are not compatible with page =
size.
+	 * Due to the custom handling of ECC blocks in certain controllers the =
check
+	 * may result in an expected failure.
+	 */
+	if (ecc->steps * ecc->size !=3D mtd->writesize)
+		pr_warn("ECC parameters may be invalid in reference to underlying NAND=
 chip\n");
=20
 	if (!ecc->total) {
 		ecc->total =3D ecc->steps * ecc->bytes;
--=20
2.51.0


