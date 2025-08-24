Return-Path: <linux-kernel+bounces-783721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F3B3319A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CCE20338A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6D52E03F3;
	Sun, 24 Aug 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="YpZFKnhH"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021093.outbound.protection.outlook.com [52.101.65.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A252DFA28
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055632; cv=fail; b=apcsfoD7ZpLwEbrkO+OMmG2GRHRWDZGDMWo/3DRmhAhYN1BPIgHiFgGQRAcRKVl0YU2Juc5LvaJ9ihGsc12Zm8yIuLu9xrmMuUT2uhjWfrWh+DWzHL+6tgMjLofbmEnq7K1BynCBW88yRW/QPUBqA2gLgdi1xLMziHU+odFmscw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055632; c=relaxed/simple;
	bh=bQ5vLcmq2zdqLn0Tb7YCnOklNW5oaKe0nNgn2qnG1zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B0CGSE5DYl3OKdmCobHuepPIWhXdHvaEIOTsui9Rd8c4Hsrj7xKOcHpltcVciJBXpjzouSwN7eaK6KWghG6cHHw0s0EHDGAEPUUj+jUwrdKw/cTrrLhlc1ns8wfMZpzAXwqnCamqZiU2Gtdcng7zAMOq50dVfIvnVa5nfl5ysGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=YpZFKnhH; arc=fail smtp.client-ip=52.101.65.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2ncbkcc3ZqyMSN/40axYzuHSP2tguWQ0UPvjMAK6iLThYxdjEsuWpWoI5wpxcFBdYZ4bGzNC9zwBMCRUYlKO/7xQR7MZ5iEL8eqcuM4lgkmBU5e/kKs1mZnXEZRW8CyKJk+oapIwTgD++KYhJ0IwsYIu6+WWK/iSjDGXhABVkNMRCSsAk19YkeCi/fiFUQiZq9Mpa+RRYN87P8sRDSqv0HxrouOtvmkH070C6DsrNJtdxanDysU1LFEMXjGy6NEBE4i21pfvdHmj5ZGirOlD8/kNbCv4Pur4MxwqfjaDTTu2zn4OfnVm/P3yZ8PJ6S+JxXOG+PtOMABGl4Qvn2qVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VT9NMzqZCjVdBwvXOCsCUkrYxBVp8siKFy8LVUaPos=;
 b=eLuonIBqr6WPodGntMQ3Xa624vaWvs5QSm+5IyWgjGVnuToNgW0B+Vn8qvEtlcuKBj0pwRhfFQRQTLxMtCEaFu8hoVCYIIKuezUbBxOCIUnWXgvsYXVGToOB4Wn0XglyK/i0hYBKAcFDlh8Gw0ntUscakD2Wn0kvgD9z26KqFY/ft6PsX8vzmqXHgkHRNbZlm0+o2KKeZofZiEqZMMVScWQkb/nJrT8R5S/BAr2TKTluasMKO4N7/0tTHoHAlt5R4lvR+iZWIYCkUr/FP7tzlWNL8MSbk2Skk6TgjGl6I5f2J6bt4DEu/OtjcUs42KCzt4wgxy72ZW/x+89hZeyWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VT9NMzqZCjVdBwvXOCsCUkrYxBVp8siKFy8LVUaPos=;
 b=YpZFKnhHhdsxQPTSnfN2s3j30I7paeeHzoZKTWYbyPAoQxyUV4KEoLmUjMzh0JfiWrlAry/IeYUcFiLClxJEeT9B0CIUzBFD+5iHAi/X4E9BSBQltL/c+477kdSqg7Yd/Gi3Gm1x7/VsiV/BSdCjthueBWmSCWhtk2uHJ80kTTzxq/kL2irveJfVdvWkFJIzJjneSUnB2AiK6fQJygZehTmAt7oTCcMw6JX9vbDotS9/OCSrChxMGFmgDillXfXEgpSKMU9YXyX5PWqHRRjdU/1WFlkUVQdSCIY5bDmDjFsCoJMwGf7hiDOOWYCurWnBFhimRXWNfQDbeQXPYfh0rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7908.eurprd08.prod.outlook.com (2603:10a6:10:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 17:13:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sun, 24 Aug 2025
 17:13:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 3/3] mtd: spinand: repeat reading in regular mode if continuous reading fails
Date: Sun, 24 Aug 2025 20:13:31 +0300
Message-ID: <20250824171331.3964537-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824171331.3964537-1-mikhail.kshevetskiy@iopsys.eu>
References: <87bjo4it13.fsf@bootlin.com>
 <20250824171331.3964537-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004530.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::359) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: b19cd893-0dd9-4304-b05d-08dde3319427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JcYknfTQOyT16QlBEaR8TPs+L22DjO2/N/3Ta866GrsxiCpnpPr2wHuZ7/hr?=
 =?us-ascii?Q?C18A18XMvs1FBWYeSL+39DTv/TOu0LeGlLFM19ZQCfZCXwpMJrRMHKwYYQPo?=
 =?us-ascii?Q?trECT5y0MasBwwFz1y4VodFm/VnZ0GWLMc3MDYsvkxb7/QLbtLdy62G1LPWQ?=
 =?us-ascii?Q?2tg39WnMc7YT9yPQqPtY4QKypXUSQGCoaOzeq0gBa3OWi0gwdoSY1cQ7Ainv?=
 =?us-ascii?Q?KFAc3WoYDA3hlCSy+SxB5E0G6t69Zeh2tuQ/P1H/7ta9AJZl8xrCYHy0QVWe?=
 =?us-ascii?Q?phTh4upzHGXAsclxkPmMyazmnPTSSOTKBSc9PavCTPAuYmVhnIB1cFHDnp04?=
 =?us-ascii?Q?goGpHVk174P0a/2laFMbhILi6HbZYBc/4Lakj5wJ7pKvlk0Ovvm1+aNvmGBG?=
 =?us-ascii?Q?9B/ZnDOcJB9F5nh0CtJehfJUi+Qm1faNRwOlzHF6r/4z1cqf6tMFSC/ymott?=
 =?us-ascii?Q?hVyoVINfdzTGpEqvy1oce6vZqaJh3pOw0Lye1Hsy3mg9RwTI2ruDDuw6h0FZ?=
 =?us-ascii?Q?4bj+6z5C/NJruDnxMHUr5tXNc8JN8uxk19DYSPeTUc0Unq1a0bDEWLAK0Twl?=
 =?us-ascii?Q?S+qKcvd/lOZvtygntlLo55rnKctg1XrOLAsf5QjSRDPI2RJ9tdClxSKeEFkw?=
 =?us-ascii?Q?/e2eilMUBMjSlr1QYrnU6CIyYJLP2/ofuFqZcKKtEUtWIpVeYGsm25J/YxJg?=
 =?us-ascii?Q?ttrDUDpIWwo0sA3WXStFxCqrCIepxihGN00J1jffzo+JdrsYZyC0ELMzN0yq?=
 =?us-ascii?Q?F8I8niajA8ImZbkPULhlm1Z7YpEJRMjPOdirBzTyZAsiLhwIvfhFYUXbOR63?=
 =?us-ascii?Q?yERy5VCGQ72ESWwLjsjKmxGWN38wcD5yAPDRf3yOZ+UHi8fJHKN2VMeHaaDJ?=
 =?us-ascii?Q?LO6zB3jYFJ4AMvbs4ReC9ukjgWgONz1QiIOLdGGLnae1FnpYUK9LlTdR6ONr?=
 =?us-ascii?Q?tcsg5TajFVCWX6iyjMzQ/EWX5TuNrVm+O2xOfiztx4TGjN1/wjMaKDXjLF+Z?=
 =?us-ascii?Q?SmSiH3xnS6cJ3JgeUYX29vhGNkgH6rCrnjmWiiPECO3QX6PelMDJSAU9ZoYP?=
 =?us-ascii?Q?2AhGd6EHChw9IjxaPweToa37/f8KjggbZDi6cPahzkNhQJCwlZ6u0Kadcuvg?=
 =?us-ascii?Q?MZ3jSWjjQ9Kcfk3pY3DAeD09+f7UwvaMnRHpkl+3PgRQ/dqyUZoAHUOaYBZS?=
 =?us-ascii?Q?FBNdOEeCE4O0WGQp3/3SH5mWOKsSrYxqZr9duByGuvyoS41IF7eaWSmXeHN3?=
 =?us-ascii?Q?wf9huF8HS618IPxQY6Qy787IrUIprejALg2RYi49Q9M/jGgo8Iv6PXNraz5A?=
 =?us-ascii?Q?85wLnCw5W7EfttdkUBFZPT6kDHVqL501fuTxN6wsshD2sIrtUBg0mbN0ZPmr?=
 =?us-ascii?Q?Ahg2hkcZfOeX8djzB9GypiBToXXi1jSMAwAzwWqbgxNNPDNqJ9mubxB9iHgY?=
 =?us-ascii?Q?ZnOxoYF43ojHUCWjDir4UIZrZn2OzB0j7+VETmUq6V6h0//STQtzvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?486JoCijIMa8nuNdASisiM9nmOcSDnPYOsCQaWn0NTs385Wby3XcS2MOi6iQ?=
 =?us-ascii?Q?eikHnfU0o2W6XG2JaQG3WNKeMG/RsEvNc/0FcDFezDPeus9WFQz5LGL5mU4r?=
 =?us-ascii?Q?MH7eI8fXSlp+iU9EOPID+EpFsQlh/ey6iSelnoFuqW0e0qRm6Lf1fzizH7FD?=
 =?us-ascii?Q?jEcqdXZKOXW3EPZDb6A6bHY1CkractXmkgJY/sAtN5CZQANlKgainxKK+TFa?=
 =?us-ascii?Q?bxVDV8SDm8+dCBEDU8VOEr1EVSPOBu4AyWkURsABAQvlYU0CfNRSiXpSgwDB?=
 =?us-ascii?Q?HQVfAiydTTJ37Sd1DmsPswunxwW8lzzAO+nlAyLUB+BRRrles71hzL/pDL1z?=
 =?us-ascii?Q?hEsbGlu8DisxKde0tyMmn2pQnYT++vuSjOJ5jXzsBfUHJFzWnoo/3PtorObh?=
 =?us-ascii?Q?yuAR4r69HISqq0KKAueIjMpW8f4Os3/cSSNY/M5URkxk8puBkN5RRUGZT5XB?=
 =?us-ascii?Q?5etyrtlUUCxnzdC/5qYA9YDHGnkWZed+MN3dMdtNV2K5BCLCz0AeDFWkYc5m?=
 =?us-ascii?Q?VpWTfZP38yRphyzbUEs3f2ya8EJF+4Re/hanaEz+TEtwO/RwH1qQPs8DeP/D?=
 =?us-ascii?Q?P9CyoKFcVG2YKCk+vNn3OjMHVdne8rx2lv17E8r7cEBii7ZP4X+oQeUpFxyd?=
 =?us-ascii?Q?FmPT3OPmXlcQlXS3txZtO4gUYd1Bx+HhM4ibViWq3iEzII3T44u+lT9vWTGB?=
 =?us-ascii?Q?/JXRbKFFThLJufBNwle6GqO7S8/qdBd32C6EZ4XtgP5Nk0QseFPVjmhoT7RK?=
 =?us-ascii?Q?O7lyISfuAjaZtDPIRcbdLXj2BH1x9gc6TXV3dlx6vFU1sBkO8b0uQ1fiACv4?=
 =?us-ascii?Q?MeOyypGLI+wkJF7u7mTutklJO2SfE+QQeAK8pQ/GKkl3lu8vWJy8guz8bFzc?=
 =?us-ascii?Q?2OYi+FVS9RvfeWQsZNA03iwnLvSLqBP7g5HJenFR9ZFMDgaaHm5rBi85P0Zs?=
 =?us-ascii?Q?+Hv9+r1dFAqOsCSkvTbQfcXk5n2vckgH0btS4imRSSnSE9fxvbMc2wOBBpis?=
 =?us-ascii?Q?MRHJmGEHK13le088F6CZU1FEw9n8wh7lelLCa/VHzMDws8OQjBoWNSvUjVX1?=
 =?us-ascii?Q?ENwx7SXAG/YlgQOnsyzErOzAi9G9Oi1DWpKbhGbj3imqrdADz0se/qSl3KV1?=
 =?us-ascii?Q?BB/JLMReM4uowy5kgs+/8dPD1lWST/UFZUv7E5tiJBb+jQxunCKhvVS6Cc0e?=
 =?us-ascii?Q?2BFl+AEA1EOfg2LOyb4AEenmo98vyC1p7o6TBrdc5cBe0BQ6/csyiDF4AyuT?=
 =?us-ascii?Q?g0GcqWCUVA/KwyQVw5HqkC6g+GJ1c4VTYGGYFZARlNYXwZkjguCOdWOBec4r?=
 =?us-ascii?Q?lg/9Fm5xO3lJ3PRdW3Mf2NiJjalsZ7LgJLpbAoWIE+FjR9ijez1KNPcaJZGY?=
 =?us-ascii?Q?muPRVaqnSnAGKSxHdR5jhuVv4aTX1DyX68VZxhfGy9dHil8Xe95usjYRetSg?=
 =?us-ascii?Q?KF597ltWtzyYQyD/xpXMBsO6rsgD7MlnNPFO3caDrPHMiaJ16h4wHKwyUthH?=
 =?us-ascii?Q?2SWTDJqPaK6X3/JPsZTqey+wWe3HA3YG9Dgd7Bg37kBHd6Vz410zbBmls/8G?=
 =?us-ascii?Q?KpoAnebMq6TbC6aigrxdrVI8o+OuEC1RmwWahJqKbVynRPPvPRgiYhJpzWzd?=
 =?us-ascii?Q?WwIIj7xwuhWHWhEBdIgxmNE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b19cd893-0dd9-4304-b05d-08dde3319427
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 17:13:43.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNHEQjIcNUeGHiHkVQ+6h/uz55MVqPpplDRRwleZkVy1emSyRJm697Ew8bVgyFhetrCqv79AEyHjupH4zZrulNe3f09Y9UpcHSuQxdzZJEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7908

Continuous reading may result in multiple flash pages reading in one
operation. Unfortunately, not all spinand controllers support such
large reading. They will read less data. Unfortunately, the operation
can't be continued.

In this case:
 * disable continuous reading on this (not good enough) spi controller
 * repeat reading in regular mode.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 39 ++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 0f8636047365..5528e1f72dbc 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -378,7 +378,8 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 }
 
 static int spinand_read_from_cache_op(struct spinand_device *spinand,
-				      const struct nand_page_io_req *req)
+				      const struct nand_page_io_req *req,
+				      bool *controller_is_buggy)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
@@ -430,8 +431,11 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		 * Dirmap accesses are allowed to toggle the CS.
 		 * Toggling the CS during a continuous read is forbidden.
 		 */
-		if (nbytes && req->continuous)
+		if (nbytes && req->continuous) {
+			if (controller_is_buggy)
+				*controller_is_buggy = true;
 			return -EIO;
+		}
 	}
 
 	if (req->datalen)
@@ -646,7 +650,7 @@ int spinand_read_page(struct spinand_device *spinand,
 
 	spinand_ondie_ecc_save_status(nand, status);
 
-	ret = spinand_read_from_cache_op(spinand, req);
+	ret = spinand_read_from_cache_op(spinand, req, NULL);
 	if (ret)
 		return ret;
 
@@ -770,7 +774,8 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 
 static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
 					    struct mtd_oob_ops *ops,
-					    unsigned int *max_bitflips)
+					    unsigned int *max_bitflips,
+					    bool *controller_is_buggy)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
@@ -808,7 +813,7 @@ static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
 		if (ret < 0)
 			goto end_cont_read;
 
-		ret = spinand_read_from_cache_op(spinand, &iter.req);
+		ret = spinand_read_from_cache_op(spinand, &iter.req, controller_is_buggy);
 		if (ret)
 			goto end_cont_read;
 
@@ -892,6 +897,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct mtd_ecc_stats old_stats;
+	bool controller_is_buggy = false;
 	unsigned int max_bitflips = 0;
 	int ret;
 
@@ -899,10 +905,25 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	old_stats = mtd->ecc_stats;
 
-	if (spinand_use_cont_read(mtd, from, ops))
-		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
-	else
-		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+	if (spinand_use_cont_read(mtd, from, ops)) {
+		ret = spinand_mtd_continuous_page_read(mtd, from, ops,
+						       &max_bitflips,
+						       &controller_is_buggy);
+		if (controller_is_buggy) {
+			/*
+			 * Some spi controllers may not support reading up to
+			 * erase block size. They will read less data than
+			 * expected. If this happen disable continuous mode
+			 * and repeat reading in normal mode.
+			 */
+			spinand->cont_read_possible = false;
+			ret = spinand_mtd_regular_page_read(mtd, from, ops,
+							    &max_bitflips);
+		}
+	} else {
+		ret = spinand_mtd_regular_page_read(mtd, from, ops,
+						    &max_bitflips);
+	}
 
 	if (ops->stats) {
 		ops->stats->uncorrectable_errors +=
-- 
2.50.1


