Return-Path: <linux-kernel+bounces-757518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 415FFB1C318
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1557A4E13A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0857F288CA1;
	Wed,  6 Aug 2025 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pKfhi8v6"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012066.outbound.protection.outlook.com [52.101.126.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6563220F3E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472025; cv=fail; b=V2JEm6+e96DYfbyU5NPNJrI82pu9cgG4itXagHwJqObLY6mDJBL0c9tw+qjkJ0hqsU0isxLUK7GAuauiwHwF40vp/20xQ2Fvdq/GmNhHAf9yVoquhqMIP+EXBbCYY7Ptr8kDgX7RKh+UNxkqheoKNnjQONlzFUKOhQKIPVeo3AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472025; c=relaxed/simple;
	bh=XvxfG2dJoWntU01f2z+ExPQ5v8Bg2U3ECfkKawD0g6s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HA+NtMs1JVP4vJnVG7q3uWBiXJxWOclswfQa4rL3MqJ5cQF68xdr4lN3hWWpVKyvTdkZ9p5poi+WorbmBQsFBBg8FY1ZUKHq0LciVDFcciwOYZ3qKgFsOGk4iIq81wtzEwtfKhXdJtXgbJg1r+GHmFcQFbr9R+yvDPJLVVG6ljY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pKfhi8v6; arc=fail smtp.client-ip=52.101.126.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVwpQqq0gG/FYvrlmouNoHDfCOlilGMI+kILngz93wktyg26xT3OjURxcupCTswSdbb39vc1gu3Orqc33ygVmwAXTG3CUcCDl+tqBx/YHpNoYXBir+HJSqQ7vcH/EMIMlU9VtSWsGuoAlf19wI0Cz12n435O/YtGh8ru0mabqEsPL4/iYOOw8q56dAsF5btltGpYmsCC7mpP2F1/7K7a7jCMyE66694lQ2rl1YFNzAKfRIY9OlMqFyf11WQons1d5TCNTi0SNp3A0bB1aWKf7dkXy3A4HWHnzyd0mr6u6kxxMuoizgOJae64tFxdQb0cnxxH4p43O5WqRbWWpIZzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tap/MpGRxCQdp0WXsQ3/Bs/3duBrtCmCbKRKQ36n+qg=;
 b=RjPElnKSOHkK/edm0w7wcCfGfSYdaqEh9nWinInKOyOGrRuFT5fVt358kpzLD5WNe4MOa/mcdX7S1XaiYVUzLYvHCyTzIQqebLK24GuSK+rSTSj+DAYsQPye2jcGx0Q+4kZRQGuCtjphprmVCDOhNBPlexDQWA8Sb9rZcw7WAQ3dNBLetYo5RGSz2IMD9VftlymstwpJ6ouuC0t0NvZoqhvdZuFEn59dmgyyZfEH2UahLvEV1lTgpxocATUta28TaNOC4A+fy5rfmO+gbFub2+iXk8cJtWLba7I10l1UYDC5O+btALJTT0+m0P3Z25TJ6nQtcaZlvQ1TOi6WTCCh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tap/MpGRxCQdp0WXsQ3/Bs/3duBrtCmCbKRKQ36n+qg=;
 b=pKfhi8v6xhrCGvGjKINXZat5+HjB3TEPfqjXdR+8FoyUXjo+AP+gFaVzkFF5YQ0yVVKWfToWOOGs64UWKPnvFViLLy/BwhQNVdNyX3liWqKg3s/9ZfvDbCJyuxUphiKw/6owqr2t6PmJjia5Qed69uQP6SxgINjqFbt6cB54vOfKSbwCKFK5rOUTKbV5FuKn+TtOv20at6AO4aMnFORh9aTxmaIcvznqMR8W2BcO3oZmM7w78uQ5T3wzj3bg01tiFexzlKwBYnXHKT5+5kRLc2xd22JDTPjl1AFpXN1gQFA0sM8EmMyaMlrhJLdGpRk6gsjo8ppGhMhJm8EW4Ytn2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PPF5540628D6.apcprd06.prod.outlook.com (2603:1096:308::24e)
 by TYSPR06MB6409.apcprd06.prod.outlook.com (2603:1096:400:411::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 09:20:20 +0000
Received: from PS1PPF5540628D6.apcprd06.prod.outlook.com
 ([fe80::5f12:df6:9716:ecb2]) by PS1PPF5540628D6.apcprd06.prod.outlook.com
 ([fe80::5f12:df6:9716:ecb2%7]) with mapi id 15.20.8989.020; Wed, 6 Aug 2025
 09:20:19 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH v5] f2fs: add reserved nodes for privileged users
Date: Wed,  6 Aug 2025 17:19:54 +0800
Message-Id: <20250806091954.180602-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0211.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::14) To PS1PPF5540628D6.apcprd06.prod.outlook.com
 (2603:1096:308::24e)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF5540628D6:EE_|TYSPR06MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfa75a5-ee22-4c5c-e580-08ddd4ca7697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ILUfywnAUUGjiVfxUFIs4F2HE9wFFmi9r4wBd2LvVL/3zQXWxDUXLOMUQHDz?=
 =?us-ascii?Q?8FTRsgywFu0hnNzXJPWPuTcETbO1G6qh0YBZ+cUTlHG5crOnampe7PrgSEXq?=
 =?us-ascii?Q?jDMIi5/L3GrXXFAcFQslrF3JTclVnznN61arBJwu6+2aQt0MJag9W3Y0Kri8?=
 =?us-ascii?Q?pX5F4qFp2iV8FOSv1JjaVe9SMMDnRPhl75ZIhv+xG3nEfx3TLDG4mea4VZQH?=
 =?us-ascii?Q?d2tekGxeMhlHMj+vb3UIM2PIde5vG9c8Va4/u+yXW6j7OMm23pH4VWuM4UB/?=
 =?us-ascii?Q?wBUKvH0DGGI2SxRfuZPolTVftW+VtaYhREO5espOWYPoSg04wJgI4YPGlDM0?=
 =?us-ascii?Q?Fa8ExuswMuR+CwVcr+XvNqia6+VojJ0A2zkXQcm/hYaX++0BDthNL1yHQPLJ?=
 =?us-ascii?Q?sX7CxiaTNLmlpCXumukWgU68dtU2wFlIzO5QzLRp3S4QcyxW6qje/1QfygbD?=
 =?us-ascii?Q?kh7lK3RuTSzE8Isdhpj4BkEx4PkgMHrQ3jEwgVmQDPltg3+q9fFGuyZ0Axse?=
 =?us-ascii?Q?1EDu7TpGDsIa8UPZbrEbiQ0OrzdEfrd8Qqkr7q2l5zch20m2+Aj+9aQByuEG?=
 =?us-ascii?Q?OLLNcbR09anIxyxX4ufso8CXh1/V+4rivegGYqKokMe/Hp814aZK1g5aSIgq?=
 =?us-ascii?Q?YSUfrrpew/+MgA7YCdgSde2599w8kkdiNXMxsHqbDJOTfrKhKeGJlkKrK+cT?=
 =?us-ascii?Q?7y/WrPUmBsviXdpiqyNGo7D8rMRCi1jzmIe+0w05oxr2Y5ILN1KCS+/MDZ31?=
 =?us-ascii?Q?Fo0IlRU0bLtfDnAP1HIJbof9TZAu6ArPXrXo+K/uVxrtLG/yfnKJAw+QAYrK?=
 =?us-ascii?Q?VNJKDEutKkL0fJJ6o1FsmI/jh4INVf5yuim6Q3H6iRDNRApdQCEZJgrT1Ri4?=
 =?us-ascii?Q?Ul+DwMMKb3cGEuW80cZXjXd0Tj7tH6SsatM0Pb8U5FHJY9T5Hym3nnLSQeW5?=
 =?us-ascii?Q?5QABEhUX8isRgeaQUqdrIbY7LWRa/suopGEHj6Z6uG6NzOvWITLzCcZlghZx?=
 =?us-ascii?Q?vymodOQKyoiiM3PMWMmCg27b3XLbmCgjlqMTQKEwc6nUM2yu4AXT7twhyuC1?=
 =?us-ascii?Q?EvZKt06PqleFoBVMUDsKv4J//yxJEjnZwRV3GsE3H4vJeehkp3zL9QiAvFm2?=
 =?us-ascii?Q?24FnIl4BfKE8CteHJfZgYEWuQEaOlkK09yODgbdCG0xFJH+jYJkwqvzSWVvy?=
 =?us-ascii?Q?0SDUxoiT1e9/q6v7XU5rBK4hf0rmhwCBBlaKmKYtOjaDYMl4vJfRobePVOt3?=
 =?us-ascii?Q?xw4/YKCe3j4zQpUWnYaE5ch/kJ1afjZBVEQHeMJWB1Y9cYRsbjhjtHoeL6UO?=
 =?us-ascii?Q?bw3DNHT0MP8rSYJRBp7rTbrWwAne2R8p/2aONwLgl5qp3hY7ounOt1b/OatI?=
 =?us-ascii?Q?w1FILyeFTm1mLM2wvPUr/SROa68oSVEczUAt7VIqS2XRmGMYgxZ26dAjSTtK?=
 =?us-ascii?Q?C6mgMB5vCHUWHWWMRMih/HaDRkaiBBhVUgNxSB8I2oS5VOYRyE+Q09uOt5Ne?=
 =?us-ascii?Q?v1anGsLE1rELkf8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF5540628D6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rVcYzl0j2Y6Eyt3yASHuprd2OdbROMTR0im98eGJvjRkT8GoHjNJYUligxAI?=
 =?us-ascii?Q?N9xOoifimrDZeOFSWUDOc19VqD1QW8CEtF2o3bril55ZzFSvI+bsMX49TZS1?=
 =?us-ascii?Q?fSQWSkmLHHK4O/XXKmUl39d3icdEbGUAZjck1NNRb4j2ywM3bDA6e1ACaIKd?=
 =?us-ascii?Q?Uub5jxPkc+8Jvfka200yE9KZInvxi7BdKSZNIHYd0/aBrg66nfnXFidqHgcr?=
 =?us-ascii?Q?Tq5h3I4CMxfy/kwnvzGaSciZCSJls6gMKooh6zqxs+gGCG+6aRBvG2UzSGOo?=
 =?us-ascii?Q?iwvfYnDnbofK80vAigyqk2th+LlT86CpE9PIl5XLHL1YSo5oexh4ptZcnfcW?=
 =?us-ascii?Q?p83AQm20GXrFL5sOb7CyEevVyOim5jzrsn2HqwtYnpgPAuJtN/x/4h/kl9T1?=
 =?us-ascii?Q?hu7shtKFwK0VQycm1xgZ2XZXfreVHETIknu9J7VgFIEVRWLI39pForEkeFQH?=
 =?us-ascii?Q?OtpIyKOCu3ZwFsgw+TyVtPSGAwP3FS6pvhNtskijAwNN5LUJX/HdEgV/t/sM?=
 =?us-ascii?Q?bSwoQ1LCkrK33MHMN+YYjAgoCfw0+b0GAU53KPwA2vHc1JKU7UadUGJoZ9Dd?=
 =?us-ascii?Q?K4wHhZDHMIsWXypiPVqG+HVZAFFU0Hdfy723jd/+FzkzykfaxlX92Atm/dNo?=
 =?us-ascii?Q?ifGbcwbRpCWYhyPpUNRQIk6WcTx2QnyiLdZzO2EIMNWlQDcShltXtKC515DH?=
 =?us-ascii?Q?Ge2GFcEJe4uScp2kk6OtVHbX7vULhHJQUfsKJOdsSZPPowro18MnywB1wXU1?=
 =?us-ascii?Q?yhE1qjSX0faXi72NRVPvuZJJ6oAPLfVkq+Pl1PqQ54Vy88tOpFn6J1YQNITZ?=
 =?us-ascii?Q?ZTmBZ4OPL9AzTHEFi7lkshsY3yIlDT0gc3WqleD/V6HIAbs1uxhJhvRuDpb6?=
 =?us-ascii?Q?jBi+us1TSCg1h5LU3SEd6WmpMk6KaROoo7Z/d67u3A49+4s6tiRYrgu1wmRS?=
 =?us-ascii?Q?IqfPmVImL38J77yySXpUgwXxxs4jkvtET19F+Z90+4UUs9no9rzAUmmpfrdF?=
 =?us-ascii?Q?nKZHzcYgmtwkSJpNZk49xkwDjNZ7ZODUz3io9z9tA7XDO1oi54Y5N0oeN6B6?=
 =?us-ascii?Q?V9DExJM7UodpEulylysWdqS1EHOuGvWE1SRuV8292FEGc+9GuMbpXK4i+WHt?=
 =?us-ascii?Q?VSP7R1IjH8n4gjyBwy23ZhXTK9qCjMfpZOVUFYWXUjzsWiWa7iuhCczuSQlP?=
 =?us-ascii?Q?Ni9Ed0a/jeyOweJCCqiOpY1x4WlnEu3hyDALLGJWrxrdizPpOvL5KD0m9X1l?=
 =?us-ascii?Q?/mVVbcd5swgdUhjW2Uwhcvi94Z+s8Gzxw9Ko+0AhNsRloZ59QYGwXfBmiUid?=
 =?us-ascii?Q?kROua/c/j3Rrc0j40+L4Ccy8oWuASqQL2lCuF/BigayRIpMBle0zvL52pn7S?=
 =?us-ascii?Q?SPrU+Z5zf5tO8B7V6xnV1GkhdcrwgEN1Arc+zbprxbStlsgksRBjDtjYuUpF?=
 =?us-ascii?Q?Y+bhBtnTrVb+GAqJXR96nKqzzaEO2l+kZ41hUPJPDwdz69EIqdXOJDgP0K6X?=
 =?us-ascii?Q?wOirCZzVNNKGhiG6V0f7JJYHB1SrYvt0WCnkTcWaCfrX4iCtL8hPurnJMzzB?=
 =?us-ascii?Q?xWXP16msJClYTHKvRnHp90G3XR0QhS3kFPlT100O?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfa75a5-ee22-4c5c-e580-08ddd4ca7697
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF5540628D6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:20:19.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZrVUr15WaDI+iURskrFdVQeTqrbjvq+u4q297TmJbVdsmBRlrmfA+oVee1MBBsMyAQ6NsF+LxSlR1cLlINL2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6409

This patch allows privileged users to reserve nodes via the
'reserve_node' mount option, which is similar to the existing
'reserve_root' option.

"-o reserve_node=<N>" means <N> nodes are reserved for privileged
users only.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
v4->v5: Apply Chao's suggestion from v4.
v3->v4: Rebase this patch on https://lore.kernel.org/linux-f2fs-devel/20250731060338.1136086-1-chao@kernel.org
v2->v3: Apply Chao's suggestion from v2.
v1->v2: Add two missing handling parts.
v1: https://lore.kernel.org/linux-f2fs-devel/20250729095238.607433-1-guochunhai@vivo.com/
---
 Documentation/filesystems/f2fs.rst |  9 ++++---
 fs/f2fs/f2fs.h                     | 17 ++++++++----
 fs/f2fs/super.c                    | 43 +++++++++++++++++++++++++-----
 3 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 03b1efa6d3b2..95dbcd7ac9a8 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -173,9 +173,12 @@ data_flush		 Enable data flushing before checkpoint in order to
 			 persist data of regular and symlink.
 reserve_root=%d		 Support configuring reserved space which is used for
 			 allocation from a privileged user with specified uid or
-			 gid, unit: 4KB, the default limit is 0.2% of user blocks.
-resuid=%d		 The user ID which may use the reserved blocks.
-resgid=%d		 The group ID which may use the reserved blocks.
+			 gid, unit: 4KB, the default limit is 12.5% of user blocks.
+reserve_node=%d		 Support configuring reserved nodes which are used for
+			 allocation from a privileged user with specified uid or
+			 gid, the default limit is 12.5% of all nodes.
+resuid=%d		 The user ID which may use the reserved blocks and nodes.
+resgid=%d		 The group ID which may use the reserved blocks and nodes.
 fault_injection=%d	 Enable fault injection in all supported types with
 			 specified injection rate.
 fault_type=%d		 Support configuring fault injection type, should be
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eb372af22edc..a4e4c3931441 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -131,6 +131,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
  * string rather than using the MS_LAZYTIME flag, so this must remain.
  */
 #define F2FS_MOUNT_LAZYTIME		0x40000000
+#define F2FS_MOUNT_RESERVE_NODE		0x80000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
@@ -172,6 +173,7 @@ struct f2fs_rwsem {
 struct f2fs_mount_info {
 	unsigned int opt;
 	block_t root_reserved_blocks;	/* root reserved blocks */
+	block_t root_reserved_nodes;	/* root reserved nodes */
 	kuid_t s_resuid;		/* reserved blocks for uid */
 	kgid_t s_resgid;		/* reserved blocks for gid */
 	int active_logs;		/* # of active logs */
@@ -2355,7 +2357,7 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 	return ofs == XATTR_NODE_OFFSET;
 }
 
-static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
+static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool cap)
 {
 	if (!inode)
@@ -2380,7 +2382,7 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks;
 
-	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_blocks(sbi, inode, cap))
+	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
@@ -2738,7 +2740,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
 {
 	block_t	valid_block_count;
-	unsigned int valid_node_count;
+	unsigned int valid_node_count, avail_user_node_count;
 	unsigned int avail_user_block_count;
 	int err;
 
@@ -2760,15 +2762,20 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 	spin_lock(&sbi->stat_lock);
 
 	valid_block_count = sbi->total_valid_block_count + 1;
-	avail_user_block_count = get_available_block_count(sbi, inode, false);
+	avail_user_block_count = get_available_block_count(sbi, inode,
+			test_opt(sbi, RESERVE_NODE));
 
 	if (unlikely(valid_block_count > avail_user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
 	}
 
+	avail_user_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
+	if (test_opt(sbi, RESERVE_NODE) &&
+			!__allow_reserved_root(sbi, inode, true))
+		avail_user_node_count -= F2FS_OPTION(sbi).root_reserved_nodes;
 	valid_node_count = sbi->total_valid_node_count + 1;
-	if (unlikely(valid_node_count > sbi->total_node_count)) {
+	if (unlikely(valid_node_count > avail_user_node_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 30c038413040..a24e855a38ed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -143,6 +143,7 @@ enum {
 	Opt_extent_cache,
 	Opt_data_flush,
 	Opt_reserve_root,
+	Opt_reserve_node,
 	Opt_resgid,
 	Opt_resuid,
 	Opt_mode,
@@ -265,6 +266,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
 	fsparam_flag_no("extent_cache", Opt_extent_cache),
 	fsparam_flag("data_flush", Opt_data_flush),
 	fsparam_u32("reserve_root", Opt_reserve_root),
+	fsparam_u32("reserve_node", Opt_reserve_node),
 	fsparam_gid("resgid", Opt_resgid),
 	fsparam_uid("resuid", Opt_resuid),
 	fsparam_enum("mode", Opt_mode, f2fs_param_mode),
@@ -336,6 +338,7 @@ static match_table_t f2fs_checkpoint_tokens = {
 #define F2FS_SPEC_discard_unit			(1 << 21)
 #define F2FS_SPEC_memory_mode			(1 << 22)
 #define F2FS_SPEC_errors			(1 << 23)
+#define F2FS_SPEC_reserve_node			(1 << 24)
 
 struct f2fs_fs_context {
 	struct f2fs_mount_info info;
@@ -437,22 +440,30 @@ static void f2fs_destroy_casefold_cache(void) { }
 
 static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
 {
-	block_t limit = min((sbi->user_block_count >> 3),
+	block_t block_limit = min((sbi->user_block_count >> 3),
 			sbi->user_block_count - sbi->reserved_blocks);
+	block_t node_limit = sbi->total_node_count >> 3;
 
 	/* limit is 12.5% */
 	if (test_opt(sbi, RESERVE_ROOT) &&
-			F2FS_OPTION(sbi).root_reserved_blocks > limit) {
-		F2FS_OPTION(sbi).root_reserved_blocks = limit;
+			F2FS_OPTION(sbi).root_reserved_blocks > block_limit) {
+		F2FS_OPTION(sbi).root_reserved_blocks = block_limit;
 		f2fs_info(sbi, "Reduce reserved blocks for root = %u",
 			  F2FS_OPTION(sbi).root_reserved_blocks);
 	}
-	if (!test_opt(sbi, RESERVE_ROOT) &&
+	if (test_opt(sbi, RESERVE_NODE) &&
+			F2FS_OPTION(sbi).root_reserved_nodes > node_limit) {
+		F2FS_OPTION(sbi).root_reserved_nodes = node_limit;
+		f2fs_info(sbi, "Reduce reserved nodes for root = %u",
+			  F2FS_OPTION(sbi).root_reserved_nodes);
+	}
+	if (!test_opt(sbi, RESERVE_ROOT) && !test_opt(sbi, RESERVE_NODE) &&
 		(!uid_eq(F2FS_OPTION(sbi).s_resuid,
 				make_kuid(&init_user_ns, F2FS_DEF_RESUID)) ||
 		!gid_eq(F2FS_OPTION(sbi).s_resgid,
 				make_kgid(&init_user_ns, F2FS_DEF_RESGID))))
-		f2fs_info(sbi, "Ignore s_resuid=%u, s_resgid=%u w/o reserve_root",
+		f2fs_info(sbi, "Ignore s_resuid=%u, s_resgid=%u w/o reserve_root"
+				" and reserve_node",
 			  from_kuid_munged(&init_user_ns,
 					   F2FS_OPTION(sbi).s_resuid),
 			  from_kgid_munged(&init_user_ns,
@@ -841,6 +852,11 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
 		ctx->spec_mask |= F2FS_SPEC_reserve_root;
 		break;
+	case Opt_reserve_node:
+		ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
+		F2FS_CTX_INFO(ctx).root_reserved_nodes = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_reserve_node;
+		break;
 	case Opt_resuid:
 		F2FS_CTX_INFO(ctx).s_resuid = result.uid;
 		ctx->spec_mask |= F2FS_SPEC_resuid;
@@ -1424,6 +1440,14 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
 		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_ROOT;
 	}
+	if (test_opt(sbi, RESERVE_NODE) &&
+			(ctx->opt_mask & F2FS_MOUNT_RESERVE_NODE) &&
+			ctx_test_opt(ctx, F2FS_MOUNT_RESERVE_NODE)) {
+		f2fs_info(sbi, "Preserve previous reserve_node=%u",
+			F2FS_OPTION(sbi).root_reserved_nodes);
+		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
+		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_NODE;
+	}
 
 	err = f2fs_check_test_dummy_encryption(fc, sb);
 	if (err)
@@ -1623,6 +1647,9 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 	if (ctx->spec_mask & F2FS_SPEC_reserve_root)
 		F2FS_OPTION(sbi).root_reserved_blocks =
 					F2FS_CTX_INFO(ctx).root_reserved_blocks;
+	if (ctx->spec_mask & F2FS_SPEC_reserve_node)
+		F2FS_OPTION(sbi).root_reserved_nodes =
+					F2FS_CTX_INFO(ctx).root_reserved_nodes;
 	if (ctx->spec_mask & F2FS_SPEC_resgid)
 		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
 	if (ctx->spec_mask & F2FS_SPEC_resuid)
@@ -2342,9 +2369,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
 		seq_puts(seq, "fragment:block");
 	seq_printf(seq, ",active_logs=%u", F2FS_OPTION(sbi).active_logs);
-	if (test_opt(sbi, RESERVE_ROOT))
-		seq_printf(seq, ",reserve_root=%u,resuid=%u,resgid=%u",
+	if (test_opt(sbi, RESERVE_ROOT) || test_opt(sbi, RESERVE_NODE))
+		seq_printf(seq, ",reserve_root=%u,reserve_node=%u,resuid=%u,"
+				"resgid=%u",
 				F2FS_OPTION(sbi).root_reserved_blocks,
+				F2FS_OPTION(sbi).root_reserved_nodes,
 				from_kuid_munged(&init_user_ns,
 					F2FS_OPTION(sbi).s_resuid),
 				from_kgid_munged(&init_user_ns,
-- 
2.34.1


