Return-Path: <linux-kernel+bounces-731056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A18BB04DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3090D4A42BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CFC2D0C7D;
	Tue, 15 Jul 2025 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UXoMKCxX"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013040.outbound.protection.outlook.com [40.107.44.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C82D028F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547775; cv=fail; b=VbfKlURlUpXVBbUEes1KoJHo84MryK87tw0OubIyYyKXLQ2IrOVO9tvoHX3G7f9L9CNvps+PQAWTedAW4Xja6BUQK3BXf+Rz1RNamehLLL3z1lmfHeseLvStzFwIwPe7SToM7Rq5DD59E/BDt8vq0YSfof00T0rX5EU5e5/fk6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547775; c=relaxed/simple;
	bh=F6b4b7a/lLfUQlXq0+fdJL7+Hr8r1a79thBck29Dyn4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tW5cQiV58iys5FsFPO1ADjLej4pU1vVBCfN5jcXVk0xawIDemz6/jJk6DZ4NknILaWWHVzoANZyeq3P4QjCHch+7hDs+pwmH7D1rhZS/tajYVumPz1L2hOE7D+FRuJZ1sSlJJHnYO3AaRoTkLZds2zIJ0prkDk1/ztOsRs3SLPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UXoMKCxX; arc=fail smtp.client-ip=40.107.44.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywdQO6eNZgkdEhXIS4qAP2awdMLDyaJB7VOydbcmEwbAZ6Ba/7/m3rAL/8T9tqPh4nn+NO7HxE0KMjG1emHhVR60bRScQ3Pee0wIe6h8aLjRec8nPmiQCCeh+iw9GbktVSQ6Rv6u2voT2wV/R3EF61943PQ29d2JG+3egqWMKUB7t+9o+x1Iw3YivjWxcwHpjfWmvCHSvEXVZx+UHw5TmO5ZG8Lny7nbTb/cSHhFsRAh6oi6RNy8iIST94yYJmgBWGwrjphPsCihO+BMTR0k+ZJKobdbrRG8KuLyip89HhmiJv082Aa8NVuFaIWIa2yAPneW2QyubdMmwrvEktyBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRaKT4ux8+9JzaT/vUmji9SBbIWrr/zZ+CQ7J28j5Jg=;
 b=gwYVN7A6Wp25TjqHoEdEQMabMWHIXAZyIgca0KLqIQopIR1ZSv2TEjjSpbYXmLZWyzy3Hnp2EReFipUr53nhmBrrajGFdf9ADEMPI8btaB+IPq+caNXiWsTLhUE4nyKaOGnr7+x0eJj9KKv6LsfyviB45RW0E3TVfFqGe5yFD0Vi2/UlS2mLhFasLS4zf0G9qlwHOCs34DqwfQXhzxahY97/AwPDhfmB24ixUt6y2MoVNpXEszHpHRh2xQ/zJ2+Hd/paDdf799v2O8uPT4CkJW3LLSmVvyJz+byOwcsi1oRDr8yJTf78Sa8oqoXKRDOZ2OAoclUxRiSZ02iHlKsQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRaKT4ux8+9JzaT/vUmji9SBbIWrr/zZ+CQ7J28j5Jg=;
 b=UXoMKCxXeNZjr14vYbw2jk15pYywuoBIr3uoluIOflyN55L7kOpO/ZZOHP/Pc1o43v5bpNfxRQ/gUXLyp8FjB5zlnqcTYt6PU0lKShjGm0QyxwxDvcBlY5zhFPPwMf+bGgx9BnGSuEnYi+HxPIs8mdBdsGQiJLvlVMsdNZtHKQnXKX4gomQyl/woxtI9X0SKxUfrcDihJ8ZNY19uraoMkySPimyjHwkaNjrSXSu4m2GAqpjEpSGGGfxBAxB7qTpnqTe36YIpUjK1vVpKlJHXkf7+D6gPz+Qw9GbIaVxmmiGvfx1RUPfZlrPp83RMy1XR9de9kBDwrrdE7dnV65XXOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by TYUPR06MB6149.apcprd06.prod.outlook.com (2603:1096:400:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 02:49:27 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8901.028; Tue, 15 Jul 2025
 02:49:26 +0000
From: Qi Han <hanqi@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: axboe@kernel.dk,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH] f2fs: f2fs supports uncached buffered I/O
Date: Mon, 14 Jul 2025 21:10:54 -0600
Message-Id: <20250715031054.14404-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|TYUPR06MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 608457d8-daf8-4ded-35de-08ddc34a35e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oReKRSGEKTaBR/Q8hw5eONQl/NgmizRuxKFBI9EZ6fA7oyh659U2m9kpYgXv?=
 =?us-ascii?Q?wXZ5Bvx4sx4phOzk1JQueqPisDXA2tfZfnHUqQaisyxJ84s0zJ6iODnRuqkD?=
 =?us-ascii?Q?DHRtMhCG+lUgJsvmPsTgqe8It5ZlTHFKsr+wp19rqt0CgiLs3+DWxXyC62uj?=
 =?us-ascii?Q?4QK6qQpsVmS7TgvOpGTWtzyCZbMx+6TKSdyq1S0Mk7AiShzRYFYXst7F8Mnf?=
 =?us-ascii?Q?qVP6siD1g0cgksTOI2mIz78jD44NCH4wIbHylu8jG+Rx1H+Jr1zmvoVgGw7i?=
 =?us-ascii?Q?GcJ465Fjo9szatQTCmIGLOuL9RuOiJNKzfYLKNKd+1s7YWO/8sPJMVgcUy7B?=
 =?us-ascii?Q?5LlOcwJYnWELS+BExIAqQ3kKIA8dkMcL6j64tiHTa9W09CGI2CTb/5/m3kQl?=
 =?us-ascii?Q?GHDNyVavy9GP9+D9CB1kRF38VzUu+0quuuNZdoZ74iNyQfVU0pLZBbhip0Zw?=
 =?us-ascii?Q?6K5zaVzYYqpEH6iMvzWpCt1sl0B6OAqdxg9SvCkdcca9IxJWvH6twfuRA+z4?=
 =?us-ascii?Q?EQMbLwcjkAfted8xIII/PrUJF20caCtpyUz3x9xvAWXnPDFoodZA256bUUnS?=
 =?us-ascii?Q?bpOA3KiQgBmGXM0v6TlUFycHIg01Hgt1iGvrvJ0owMstiU4JYXYAd+QdEyO0?=
 =?us-ascii?Q?++QhzBhwyKxwun6kdjYa4TsB+A0xrqHxNP1qCNSOy5z2cAVcz0WcNy3dltP3?=
 =?us-ascii?Q?BLZBD+AUxgS5Xr2kk9G9jnINjho0REmoylVTzmXceemDWHVjj/08EZl/mC3x?=
 =?us-ascii?Q?coP/SuUGOyLHtj7KokvdDfyOSDaoRtkumJNZUGYNh4smwAKqfYncW8fx76su?=
 =?us-ascii?Q?uu5tkNu3VxEmxL0K6b/2owmfCDvXwiatuCcLa3+pwvWkeWLOXQ0fqIbQo5X1?=
 =?us-ascii?Q?u3eJJFMUmwiGbPI+BT8yoY87CM5vVDpAprROa04XPm3p334BZOl3bYfohz4J?=
 =?us-ascii?Q?SzpHsjnLf8PHnt2Srez/f4qtTQ/qZiBL0D7p2Av/Unx3SeKSknXK+brZnQIN?=
 =?us-ascii?Q?6pDqauhNm2miQyQ0Nmv4pV4H3nXYpvpqTC6YlI+QUX1D162E2PTe1xShT8zp?=
 =?us-ascii?Q?HRY3GjMGbsP9ikfcxgiA7EABAnXgF61VmT+FKSm9uuLXRKhxxCMeKtG4Ds6x?=
 =?us-ascii?Q?C/r284TemWPVMc2a+iXrMV3p1R+TJKOmMBKMcWnocmdH2SL1oOpZVveGEKIV?=
 =?us-ascii?Q?nrZC2KF3RXFgpzxVs5CGW1VVxqI/XymAfgGI3hiW5VREoq4XnSldJgwfrowK?=
 =?us-ascii?Q?Z7Nwb4bRgZczkrdm307TaTJvVktv4LE0VfNql9QeaPQv8pz36326Veylq8y2?=
 =?us-ascii?Q?SKpcfL7dNMTbxBoK/WDsbb1gbCLWyZfaGk2TfnKNnW8TUXN0/5rHACrYAp3v?=
 =?us-ascii?Q?wRlgqoWfj+IdXaExKw7P0c3wS5cgnVEHjyfTkkBGhbZrn2z7HLj9y2yCE0ir?=
 =?us-ascii?Q?j9cpcynkFTM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yoGYHSqcjEcCOMWkzxZYgH2KYP1BM4w9FfOoCOocvUzwCquBiB8KKdkA8WOI?=
 =?us-ascii?Q?6XsgozTY47pcKb1iG+DWEAUqwzbFdrXsdDzY+l/r54AymQS4Ss+K2/lpHfl9?=
 =?us-ascii?Q?GusvsBCn2ajpIA3KGjpGwxQ7NgY/hmOfxQVyzAGSJPdDxmaA2uEPy7Z3xv/k?=
 =?us-ascii?Q?SxCYyn8pMIGwR9muUVLwVU3YvKNt0iA0yFrXbG7xBHTGN5NRCpNM2Ac/c7/o?=
 =?us-ascii?Q?siFD5B0OYAZUmIVrwXNrnH7hIfhwA09F4XK6u/3PBKNDZ+3qjKMup3FO+tDj?=
 =?us-ascii?Q?L56hqy1hiZQuiN9RdMi/Lfhmcz2kH/UBOyTW3iXCyS6Ze7CIZheRP4TdHon1?=
 =?us-ascii?Q?Sl/6eruxXSer6HuyW1rp5Igqy2ek+m0UphhADKKBXXnwF35ap1SrMZJcRF6h?=
 =?us-ascii?Q?ltyyHpNsnjCl3wRCs5ToKp8B4TDICXTRm3JWjtKPDKVnZLZg3NjMvckFrAc0?=
 =?us-ascii?Q?mV3y/1duKK2CMx/f1D0lVZdK++MnGtdcc/jzJuTZTC6Ct781Piyt7VzvnVEt?=
 =?us-ascii?Q?uxFcQNZOMbEmi/53oOQmw7C9YyofZ5u37R6sPcira4KkGSVhmcUXlPK6miP1?=
 =?us-ascii?Q?LhiLWDUzJGPg39jPoe9g7rgp4pr7qJh78H9mrfycw0PmCnmXIx32OoBQEmnJ?=
 =?us-ascii?Q?P1EC9+f64q485Y1cuucwTX8UAGTY+Cehw1d0/UWiIqnLtLdsjN2SlffvtUxo?=
 =?us-ascii?Q?IEm4VJTkaSDxHZu5+z4rdmjjtV8u7XIW92PKVlwaF8oLEgxz83XXayHyv/70?=
 =?us-ascii?Q?JRR16MK3kV87uWTeNfUGsDS8hrjNV8PEEbsc56G2/l5AZg2H+keEuaSmxcq9?=
 =?us-ascii?Q?YONw9J/GacTi3ouIu1vL1MS2vD69KTs3qu3lAg0YCBeLmz04S4XbUxUbxdKI?=
 =?us-ascii?Q?DPD0UA6Gr+5Wm9eFclCKLwlbwdMuT4H8dh94Xw/0vmK95YanmTsnMSSuQYI+?=
 =?us-ascii?Q?tGMPbaAeygVsLDsbaxiHrX7Ol0q2vUC3e/c7dZitR9UaJuM+FQ9no5bXYzjw?=
 =?us-ascii?Q?zp37p00vHuZSkw1yg78UNiBkd0EjWQCpDnE8/lV1Sp1HILG9qYhwEdGTfZuE?=
 =?us-ascii?Q?cyrt2B1qnypguKcD0kRj1nglyb7f2S/UqY78ljzvNqtl4T14kJ+E9ayCW0y/?=
 =?us-ascii?Q?Bl/MtXdWWHVUy06t6p1gCgUSz3gwPyJ2FXpjxpIIbLJPbq39u3pReizIs5Cu?=
 =?us-ascii?Q?+SH7eJqdMNib1ezJjzz6nsSqVuPtk3mNcl9ht1zokL5doKLy7NWhe0Xaq7Vy?=
 =?us-ascii?Q?Hngc3a07IJhlEfHWj53gGOKwFc1O4syoE/xuLzvEOdas/SmMnkq+dGjWyede?=
 =?us-ascii?Q?Lu5hKmhHa8tGsH+YeMJfbHghDS5B7oxxqY24dHriQK5ZXY4oKvgrA7uMtsgq?=
 =?us-ascii?Q?Fd07WFueWZ8lj4QBfaSCEQ2IqLFvpbJWytQIkMOPgaWvtSwXUIKE7VtnI2gt?=
 =?us-ascii?Q?cDour7/4x4LYTiHe3WqoFfwU/Hhk5fJW2+bKolHS+me6HuSU8Y3CIqYKlpK9?=
 =?us-ascii?Q?z6Jm/G6QPztGZhksFPvATIYPdHwDDN/rPfV4FbbNSL2x5Y2ze7ay+xPk1aO1?=
 =?us-ascii?Q?ytg3zJ9WxhvQvJoA1Qs1gsgi379athxWvX2MDfAi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608457d8-daf8-4ded-35de-08ddc34a35e4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 02:49:25.9844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdOm9k2TQqzn+0vs45ofSw680trlmbQJ1yGSsVZ0BMMtaxkwsgicyEqjX+ySB4hEeUtUNiGGULOCgcFbRVCVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6149

Jens has already completed the development of uncached buffered I/O
in git [1], and in f2fs, the feature can be enabled simply by setting
the FOP_DONTCACHE flag in f2fs_file_operations.

[1]
https://lore.kernel.org/all/20241220154831.1086649-10-axboe@kernel.dk/T/#m58520a94b46f543d82db3711453dfc7bb594b2b0

Signed-off-by: Qi Han <hanqi@vivo.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 696131e655ed..d8da1fc2febf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5425,5 +5425,5 @@ const struct file_operations f2fs_file_operations = {
 	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 };
-- 
2.48.1


