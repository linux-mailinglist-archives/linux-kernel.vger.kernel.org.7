Return-Path: <linux-kernel+bounces-770697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8986DB27DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EA41BC6F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907992FE04F;
	Fri, 15 Aug 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aBjruVn3"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013051.outbound.protection.outlook.com [40.107.44.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116012FD1CD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252378; cv=fail; b=K9KZcHWs5rSkzS7IutCU1hhu+o2sx25Y90zyaEkOZ4a3r/FRoI0dyssiW1yrWOc8+OvPaUjJGeGrO+ccSSc0w5Zgnn5hs91rAHzTXoOZ315mk0tttWkjoz3E8bLG12uKhH86Gzi+d29QaO9Au3nP1aVqY3B3mfR73NQ8AVdzKIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252378; c=relaxed/simple;
	bh=dbrKiG0fshhJad5xSClgDkeEQ70n/reSncucZMBzThg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KTkvfdmw2NxfRfrxeno5vQzNWHcnn5O1dfbvdMlCJQFZN/U88dlEN4EVG6hDiIobsd+AC1DVjOQwBbDnUC/bcM3t7o5f7ba7WXSXTVHq+jTQ3KUGc5dOpIMsmmFsdSt+ycL9ymkVFTptcKZ/OkBelt5JJIawM2ca1n6aTiGHP3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aBjruVn3; arc=fail smtp.client-ip=40.107.44.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyiCE2DJLfdr874kZQyUE/a1BalfIbxtXAiIiSEoLvhFuffcJbmyTDAp/LuciTwp6CBsua7EfWmMmLrcG/j/Xtk9rC4JDJW72FikPfnsmgzULeCL6OZGRLYG/3TBAFZgEZgR2kfU9dh96U/xZhTfyCq5VcsMiuvvSceru/2Ig5EB8P+bykJUUOSEMCbXQjhIKwY6au/Vg+tu2gcqQZyXax2BVit3PgudwyOof+ya7PciodNhNV5E77k0Hu3j0OCQsiYYXIPv1haIyuT4+LyICGawXLJRxRmuFzIH7vRA8nlEK4mFmjwyTY5sJ/mHLMIgfeTnZmArRiDAbiHdXAhNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44fDScV9JDkeWFPWlV/qKfXJbgxbXvfH1FNCznf/j4A=;
 b=uI362hMXME71kk6fJN8bkvTyYzVHsG6+2PK+QF1UOaoNbGFvPjYAbF0QEMZofH3hKvt57pxu2IlYu2XjAwzqsA9DsE5FRrGysAX7j+1Hl3TF6tvKkRH86vb3DODbSPx5WlI57gN8anvJBiCa5Qc8q2WwYOQxjo+D89WeF3qiJ14l8fE/V+eI2vyR7kBsl+RgMMCxJ/R+AsqPp9fw541wejKDDHCv4sO4pspvIARmsTrcEojkeN2XKLiHJF5wADabfgA9zGQEXKUe/C9+DrKalDILKC1bQIO2kp7RyUqhzBePaJFRrRdlHOj3ESLIe1U5SZ3j/zyO9oWxDsDheXCqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44fDScV9JDkeWFPWlV/qKfXJbgxbXvfH1FNCznf/j4A=;
 b=aBjruVn3bxvBtvMB03uolVLIA4IEnzP6rRho7dRc88Je37FzpfP9rFi6W27wQahCvGRN/qdy8/U/BbXpZLuvHtM1os1HIv55Ndo5K9cHyeLqs0yTUm1wrbr9MfJcn+qRq7w19lIOTsAH897XqAnTJ7G5kBIDzqk7vI94FTyVKAo6hya/4nfq0kFgCdgoF9x7WCecpXuc8zJdgzW8EOS083AkAFY3RKDH6xDQmxbvmEzZGIrQea857d/MJO6pGPj8sTHXQmYJJQdHg43bBp9Y7zZ7zcxesUAI/jNx5T0K+OhU3fxlEkdRYPS0x+Us7yrF/ZgD9xqyvawnpDau72p9NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TY2PPFF72AB57F6.apcprd06.prod.outlook.com (2603:1096:408::7b2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 10:06:10 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 10:06:10 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] mfd: Use dedicated interrupt wake setters
Date: Fri, 15 Aug 2025 18:06:01 +0800
Message-Id: <20250815100601.622923-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TY2PPFF72AB57F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 760729c5-d730-464a-de0e-08dddbe35be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OOaOZhbexWK8W5xfiJObiWstp0kUnjGhx3Na3EDJ7puhjRIlfhcZXMC6uQt/?=
 =?us-ascii?Q?PB2fErFoWv+wlayAVQ6k7myQjMOOCqLJVEFGL56p/l+wFxHxQtC3NS3f2ZMH?=
 =?us-ascii?Q?oyAWPPt2xErHdOkcoVBBdDtUCyZmGN9yM7YbvR5jP+2YouojIktGtbX63wiA?=
 =?us-ascii?Q?qrAaJ7srEczZw7XxN0wiKtbGXWPKW0LaVgXb6u50+kBsV3AO7jwUVnERsUgm?=
 =?us-ascii?Q?1atISlHC+nOE5vmY2lf9POqIKqwMUIlL37kggiIgGIgYeybBgJTD1zv/6H1W?=
 =?us-ascii?Q?Yd7Trs6f1AFLh2nEqsb1QyICoI91aLAYQBE0aIKUOuSzA8btWmQ4wJSVAImV?=
 =?us-ascii?Q?CFvjUYWrsly0g2Na3CKNVJkMyvZCWbYHyWdYO+yKSSREQ18DfOBV6HYdwa8I?=
 =?us-ascii?Q?2jd1fRZICAj7WmqXAz+0eYecMA9lF3/NIodznVmoXfMQwXpKceLlu7ilf512?=
 =?us-ascii?Q?IF+EbUpEKV9oHv3Dzb7cD9y7ESePgaWwkgAYo3cNMw4iAwegyus6TmfZCIKk?=
 =?us-ascii?Q?O8E63fUFqMdUporZlo8ZYIx2WeecWSliYzlzJuity8YNS4d5tmT0BSbf3XDQ?=
 =?us-ascii?Q?KGlr58Ze9O5ABjCartoZTvSGWe5vmVj/pfuBM/zFEAEfWxdNF15F+AU0FycG?=
 =?us-ascii?Q?BaQvPb8abpdxzED5feXU+3wiVqPE5QEgEbaEINkRekqSds+I483aoGRVNnk5?=
 =?us-ascii?Q?0kI+SbXEi6NBPQD4QiyJ+5e6+gIDEvtHDqJNrQuyucdYSr04flNZefYfsVor?=
 =?us-ascii?Q?Y2etsSKiZBjBP4HStbnNILKTx1fKqxBrzXuKBiulg/PtGyhekEXDotLK2ee1?=
 =?us-ascii?Q?/yLs9Cng3uOamzQdIsxZr8j3HWuT2PRIG3vxXIvoNLN6Glki5GpG7yNd2Upt?=
 =?us-ascii?Q?GloLdSYh4HLyPaN0EBZJafd/COgOKBll5N1qTu6LZQ2m6jLln8aV4vjBZ19Z?=
 =?us-ascii?Q?VeXdcBiSew94FLo91QL8ZlzIR0A/EFbB0/vPheKwrOIyICpPSSWIVST9ucqB?=
 =?us-ascii?Q?6/OTUlstk34z6vcnQsIV3WI9RS0m5M4KwXnQq7cyWH64jr5LE5m9efiRNVkX?=
 =?us-ascii?Q?uPS6ryg2HZ4g0YvDUbX2iqu89BD54NllaOfD21Aj603n8IkylkLv4awjxtlE?=
 =?us-ascii?Q?S1IdZnK1OXMHDJWfQWnphHIBDgjBAmyNZnrcM+oQYasR5Gsk4mSQ0j8ag4ed?=
 =?us-ascii?Q?HZ93pgCuif2o5WVnTSYIEfwp0MGXpBL3IfP9Sjzml02zSxc8alBkacpqte/y?=
 =?us-ascii?Q?za123Yg7caXpftFFRSK4sf3RQGr6ZcG0Um8s2Yuwzl8MU1KgA9F89Q4aLB7z?=
 =?us-ascii?Q?T6BbSbOMeE0Unta0JtHm/Unlh10SrqUSewUkgsTtSKGId5LAwREQNjNLu7Su?=
 =?us-ascii?Q?nS6X/sS+qU7imCLbkrr1g1eN3bhHcjZp/96eRU7QewWUVdkFTyRuMdkd01DZ?=
 =?us-ascii?Q?tf2gsUHOMu+cEGwnvMtFUzxCuS/XtcuBL4kxDidoqTjdbIshn6jnlbScQwPu?=
 =?us-ascii?Q?kMdkOUah6jZioFM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xlCUib6u0la2Vpin4YbJnQlEHSvlR/pmnPmnqr3gEfxB8T4Xt85JEhcqmOAW?=
 =?us-ascii?Q?B3+juUvWyniNkTAQde2PC+OFLc1dZWQELyQLOzHH9+8f7pLSdHcqUjuzs/ET?=
 =?us-ascii?Q?W0n/U/IzJGNVbQBl3w7Rw7fBCMsKMn718qbX03U9p2Qn91ktFDTtleHie1DO?=
 =?us-ascii?Q?GdI3Yr+5NkThZAG7XMuUddjec2sqt0PFPkpdwAJpFgqDcsd3w6DtrWmEqLBk?=
 =?us-ascii?Q?w5CExCkqRo8gEzHvCQmOkPMg+Ac2NTXwmF6grKGeC7GOxlW9IrMjfWtUujsi?=
 =?us-ascii?Q?TRYN4HJQ8/1Kt5puku4ZYlKzPuULxaX8TgVVolUCWYBs6SBsAV7OTwNn46/e?=
 =?us-ascii?Q?C84/vBV2BatNAOQt914F9AaTUIRhdTKk6RKMLrD+xuGmf+7JnNysu9g4f1l7?=
 =?us-ascii?Q?G4j2yp1+dy2DVUVXWSuGiSX+EVZb9LGJoF3L9gvAir1x7pnYDc9ylGv7RhOn?=
 =?us-ascii?Q?GCaiWBUyGJWv9/ICVbinREPSs5TcVEBqxFPscw99qvVAFWH+rJs50ZnBafUh?=
 =?us-ascii?Q?OOCVlamKMJBlqz41YQrrUwH/EWdezDWujESwydtBtjOSWfwuFwYGhLWTm/zx?=
 =?us-ascii?Q?UKcg+IsGcFIa6SHTvTWr3mfUEGsdBPsYwGCMxbpY9hNV5LQ1e41aWNvT2fvk?=
 =?us-ascii?Q?7XMLR06+plJDHsG+DqdvNy8SEOP+p894cg/bk9+ceneA5vcV8eeqBXIfwG3H?=
 =?us-ascii?Q?1Dsxh0N3FYF7ueJguhycda3aU4bOX2Uk3gVLabPXcSRjo2n/EVnpwNBEuUje?=
 =?us-ascii?Q?iRUMVMlyufdwwdroxu0e1wCVGLGbGgezYGtOAMcjPx/VVYsNtFvl8datbwa6?=
 =?us-ascii?Q?FDEeZp4kAqjMLunEGg99pTA486PuGxeZ6YOz11KeYF8D1GmrNItSiKbFuFRJ?=
 =?us-ascii?Q?kGW69jx52tZy0vXhJ6v+VohdgcBbdKzCGChuyjY4WS30gBED1ZSw1SgMcYN3?=
 =?us-ascii?Q?7ARrgRjMk4vjc5K+N/N65xCn1a91gp4XtMdAUxLY0wZXi70JzesmotrPo9sc?=
 =?us-ascii?Q?086daUYwkpP7k4ysF5uD3WYk+Tv0q+jFAi3sl00MUVj3oW2te+4X0OQv0clf?=
 =?us-ascii?Q?4xPmRQaULfaRxdAlUK+VsuFjztRJL7SZIqBbE+hPwgpywpu5RMYxtkuPbHW5?=
 =?us-ascii?Q?vjbGASHR2o5RRde9aNVm1e0aCLxKUdebGfumldfAnsawQ/FPgs44S+rkSdYs?=
 =?us-ascii?Q?VSirFwPe0MyGbRBu/51D+atO+XOaoix1w2MGffNpTlPpyy57hDTKAWhzL0kN?=
 =?us-ascii?Q?kENj2PnNGw8EDUz6koX6aNA6gm07PA9hLkr2JJ/Neju4S8wbCRC+pCTeWxBa?=
 =?us-ascii?Q?gVOoo8AB7T43hP5GPw5CDyI/lGIN6q4Zth561LMQuQlC1yXhHX4aIQbQAokG?=
 =?us-ascii?Q?mr+5OG6nft8qLemMFnhIItBKUDDiiGuuBD0m0J0QimM8x0EV80MKmS4vcJ8q?=
 =?us-ascii?Q?XGyJOuDPE2JS1pZC3ZcwhPUav6Tg1+T41N5L4peEiXSfj/b3349OQ5n9gSzA?=
 =?us-ascii?Q?u0nqo4o04FRDsfuTWUIi3iAB+AGqE1TdgJ0e7T3ytO9hIxU92dr1Skp72TDo?=
 =?us-ascii?Q?kObNrZkRHEx4LBBr4QrY9iMjyCHJNUqJk20646on?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760729c5-d730-464a-de0e-08dddbe35be7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 10:06:10.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbZxFgAqPga0tiuJdlDj4enZpOv7br7sQ9+F5Z8gw9IZ3Qvh3V2j/LWR2OF1tQY+Lz1zzuOp6wOcgH3OpQbXoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFF72AB57F6

Use enable_irq_wake() and disable_irq_wake() instead of
calling low-level irq_set_irq_wake() with a parameter.

No functional changes.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/mfd/max8997.c | 4 ++--
 drivers/mfd/max8998.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index ffe96b40368e..7ba8ed1dfde3 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -438,7 +438,7 @@ static int max8997_suspend(struct device *dev)
 
 	disable_irq(max8997->irq);
 	if (device_may_wakeup(dev))
-		irq_set_irq_wake(max8997->irq, 1);
+		enable_irq_wake(max8997->irq);
 	return 0;
 }
 
@@ -448,7 +448,7 @@ static int max8997_resume(struct device *dev)
 	struct max8997_dev *max8997 = i2c_get_clientdata(i2c);
 
 	if (device_may_wakeup(dev))
-		irq_set_irq_wake(max8997->irq, 0);
+		disable_irq_wake(max8997->irq);
 	enable_irq(max8997->irq);
 	return max8997_irq_resume(max8997);
 }
diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index 6ba27171da28..eb13bbaeda55 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -234,7 +234,7 @@ static int max8998_suspend(struct device *dev)
 	struct max8998_dev *max8998 = i2c_get_clientdata(i2c);
 
 	if (device_may_wakeup(dev))
-		irq_set_irq_wake(max8998->irq, 1);
+		enable_irq_wake(max8998->irq);
 	return 0;
 }
 
@@ -244,7 +244,7 @@ static int max8998_resume(struct device *dev)
 	struct max8998_dev *max8998 = i2c_get_clientdata(i2c);
 
 	if (device_may_wakeup(dev))
-		irq_set_irq_wake(max8998->irq, 0);
+		disable_irq_wake(max8998->irq);
 	/*
 	 * In LP3974, if IRQ registers are not "read & clear"
 	 * when it's set during sleep, the interrupt becomes
-- 
2.34.1


