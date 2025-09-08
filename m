Return-Path: <linux-kernel+bounces-806628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC06B4999B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF252058EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCCE1B21BD;
	Mon,  8 Sep 2025 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UUD/ajQq"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45751E2312
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358945; cv=none; b=IjlJf22BHy5jMgRAvlELUb676b5EhhYyYeUx9jcFizl+ie6l6VaGq9Bwjjm9P25gXS3iaJ5swJ/A8/6X0eG0k1CqQTictZDt4KmcPFHU4hcsvrC8HTNxS+iELgXxZKzzbsItxNNnbkvWpp+YqAapuSPRu2z/EGTAgEpUbxU+tzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358945; c=relaxed/simple;
	bh=YPKZOl89AJQZwlz1VpSwOMG/7dUSS4j86kNPIqkOXN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=BLxCE4mq7XrGNvYnjNGgUQGpsAdgP/8Ip3CxsZtEB8zi6n44galIO79B0GLEyC4QSjvrFbSl88c0eYm+24gbxUMlo2BrRcYvSlced/IHBrpNav8IddzI2psKkgYVdiGoPMHb1jFWeP0kfdQnAMa3NVjsnoH4DSekxcUXcUeft40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UUD/ajQq; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588JFXRr118736;
	Mon, 8 Sep 2025 14:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757358933;
	bh=XbuHFsOvA66sjk/Cm+9qrr4i3NfWmWgnU0tnmjhfxdk=;
	h=From:Date:Subject:To:CC;
	b=UUD/ajQqhmJG1AonVXN2n20H64B3c2WRVekpTrMjNO09PLAKHMM1V3WWLEiEtBBXy
	 aRwT9o++ssDU1GbYFt4nLpuEoi2+JSyEG8ivgVuP7j49EE1co015VTRYVSrg+dWK3m
	 WimN9Rcb2unflJ/XLulUCBPZ1a7jJRPFk98pPKWw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588JFXjq3170991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 14:15:33 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 14:15:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 14:15:32 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588JFWqI1096033;
	Mon, 8 Sep 2025 14:15:32 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 8 Sep 2025 14:15:28 -0500
Subject: [PATCH] soc: ti: k3-socinfo: add information for AM62L SR1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-62l-chipid-v1-1-9c7194148140@ti.com>
X-B4-Tracking: v=1; b=H4sIAE8rv2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMLXTOjHN3kjMyCzBTdFONkI1Nzw1QzUwtzJaCGgqLUtMwKsGHRsbW
 1AG/rREdcAAAA
X-Change-ID: 20250908-62l-chipid-d3c2571e6587
To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544; i=bb@ti.com;
 h=from:subject:message-id; bh=YPKZOl89AJQZwlz1VpSwOMG/7dUSS4j86kNPIqkOXN0=;
 b=owNCWmg5MUFZJlNZol4ITgAAZv///7/fp//+jJ7+N8ks/d5v5h9+/37fnttz9c4///L99m6wA
 RsYHaQAA9QGgaAAAeoAwgAAaAAAZABoAAeoB6jQZAGR6RpkNohppmpjaoZQaaA00NBo00aMmmQA
 BpkAAHpAAbSGg0ZGaRoNqA00AGgGTIANA9QPSA9IyHJhGmTI0GIABo0GmTTQ0A0A0ANABoYjaTI
 YCGEaA0AaNNMmTQAAaBoyaYGDVIkjYQJ0YHhWwAyHz9MrLiM4nIVlQK47mGi4kES9uTnBpOt7FA
 ThHAlYADzB4TLvP2yK/PgMCZr2zS1W/iozJzIoYbHtLscQqtQjjHUhNcxZ3mLygG20Prp94gMeB
 Tq6gM8RfabUy4QL1XvXQh+W3koRLg3Dfxl1QAIR00jUmM4E3U8bVjNphFSXKWrwdtLMOv96JPgi
 47u3cEMsFiYg3C0iVwKWK6YrVpoq5XVnBi+/PGGfYNwtlEVTjMN86pfMYfaWoUctQ8hkdExUpRz
 ie8DD/FQpBdaqTfqRzsgnc1gqB0rIVmnLqFvrWiKz9mN5qy1ezhtbPOoWk2gEWGNifYHHXU+uJi
 RTFMiQgLy1iCpPhWhsQg9O+RPtPYqRAiXvIQKgwSjZYB6+MzB27FkzUiGzTNFwF3uUUAI32AWA2
 5z/F3JFOFCQol4ITg==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The second silicon revision for the AM62L was mainly a ROM revision
and therefore this silicon revision is labeled SR1.1

Add a new decode array to properly identify this revision as SR1.1

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index d716be113c84f1b87a2547f9292a5a7138c00f3f..50c170a995f90bb7d153f7a54c9d321de783622b 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -66,6 +66,10 @@ static const char * const j721e_rev_string_map[] = {
 	"1.0", "1.1", "2.0",
 };
 
+static const char * const am62lx_rev_string_map[] = {
+	"1.0", "1.1",
+};
+
 static int
 k3_chipinfo_partno_to_names(unsigned int partno,
 			    struct soc_device_attribute *soc_dev_attr)
@@ -92,6 +96,12 @@ k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
 		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
 						   j721e_rev_string_map[variant]);
 		break;
+	case JTAG_ID_PARTNO_AM62LX:
+		if (variant >= ARRAY_SIZE(am62lx_rev_string_map))
+			goto err_unknown_variant;
+		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
+						   am62lx_rev_string_map[variant]);
+		break;
 	default:
 		variant++;
 		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0",

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250908-62l-chipid-d3c2571e6587

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


