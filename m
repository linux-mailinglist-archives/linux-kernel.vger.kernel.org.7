Return-Path: <linux-kernel+bounces-867927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78367C03F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63B51A40A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7107E110;
	Fri, 24 Oct 2025 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="H6vzN5kp"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0081757EA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265199; cv=none; b=B8CBMUhoTWxGwZvDWt9DT8ikEhCZyY7DWp47YagLqgdfbW6ncNklcte68NNkheFiYnOq27TlrnwgW7GgCCf5irNlmqnbEtPvc1hqygUUA/x5Qk5amEPcaNp0c62KSUA5IYm7MLtrpTcI88n2RhKsifgaYouLC1bDFu68ty7ukGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265199; c=relaxed/simple;
	bh=so3Dc81GZuYb4eb51WiOE/NCk9wIbacQ7MbsaPPKHVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpOy5y+y/ys8JOXfpH3nonZTRHDoYh5cBZ4KvFNSFpMXUL7sduz0XOSPPQaZEQXYyEZ2kEohNGPXYNtdiyUiQaV4erb6KAURDqiC0meP7L3xPf5z4mJpUqc1eAkMzRqcXyhkWRc58ZnVz9ps6aeVoAUDnPVyqzg0KFOcskaOUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=H6vzN5kp; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 187592C0220;
	Fri, 24 Oct 2025 13:19:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1761265189;
	bh=L4QwmTgTcJEAaK2M3tB5ezRq7uzaVfAc3OY7SGjM9l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6vzN5kpj/oFnfzMShiXYaLkRq+8kBIrQRPL+sS0S2VwZ9vuLhC2O4hLq+8qz7dJj
	 ymrce+WvSBGxWkd+6+/om0jAiVzp6jh58xMKZJrE9OU8cAAbnBBWgdFcH8guSGnAFP
	 1l2+JZYVdqln6Qj+FoQ94YtTUoaxt3bB0hFpHYAJRcfmf+VxE4zhwwgiEd3hgOiV3d
	 JVW7oIO5J4Kgc1bqYItz7A1lIMQSYMd5jZJI9NCL0gQMQNl2v1/lx+uaVMyXIABSlF
	 JENE8MHm8o9UK7AT/o9Qmovpcwuc1YhwU47HufzVmS0A2mT2135sy/U4PS73T5W++u
	 OWiDZ92Ovo0LA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68fac6240001>; Fri, 24 Oct 2025 13:19:48 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.12.16])
	by pat.atlnz.lc (Postfix) with ESMTP id E371413ED0C;
	Fri, 24 Oct 2025 13:19:48 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id E37602A0433; Fri, 24 Oct 2025 13:19:48 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH v0 1/2] Revert "mtd: rawnand: marvell: fix layouts"
Date: Fri, 24 Oct 2025 13:19:41 +1300
Message-ID: <20251024001943.29557-2-aryan.srivastava@alliedtelesis.co.nz>
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
X-SEG-SpamProfiler-Analysis: v=2.4 cv=NbFF1HD4 c=1 sm=1 tr=0 ts=68fac624 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=x6icFKpwvdMA:10 a=7ObwLiBfByo8Q1K0N5QA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

This reverts commit e6a30d0c48a1e8a68f1cc413bee65302ab03ddfb.

This change resulted in the 8bit ECC layouts having the incorrect amount
of read/write chunks, the last spare bytes chunk would always be missed.

Fixes: e6a30d0c48a1 ("mtd: rawnand: marvell: fix layouts")
Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/mtd/nand/raw/marvell_nand.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
index 303b3016a070..38b7eb5b992c 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -290,13 +290,16 @@ static const struct marvell_hw_ecc_layout marvell_n=
fc_layouts[] =3D {
 	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,32, 30),
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,64, 30),
-	MARVELL_LAYOUT( 2048,   512,  16, 4,  4, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT( 2048,   512,  12, 3,  2, 704,   0, 30,640,  0, 30),
+	MARVELL_LAYOUT( 2048,   512,  16, 5,  4, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 4096,   512,  8,  4,  4, 1024,  0, 30,  0, 64, 30),
-	MARVELL_LAYOUT( 4096,   512,  16, 8,  8, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
+	MARVELL_LAYOUT( 4096,   512,  12, 6,  5, 704,   0, 30,576, 32, 30),
+	MARVELL_LAYOUT( 4096,   512,  16, 9,  8, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 8192,   512,  8,  8,  8, 1024,  0, 30,  0, 160, 30),
-	MARVELL_LAYOUT( 8192,   512,  16, 16, 16, 512,  0, 30,  0,  32, 30),
+	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
+	MARVELL_LAYOUT( 8192,   512,  12, 12, 11, 704,  0, 30,448,  64, 30),
+	MARVELL_LAYOUT( 8192,   512,  16, 17, 16, 512,  0, 30,  0,  32, 30),
 };
=20
 /**
--=20
2.51.0


