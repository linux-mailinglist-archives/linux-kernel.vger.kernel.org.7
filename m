Return-Path: <linux-kernel+bounces-759148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32491B1D929
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E2216711D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C195259CA9;
	Thu,  7 Aug 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oJKEDv8N"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012019.outbound.protection.outlook.com [40.107.75.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657126281
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573761; cv=fail; b=gpBYbdXFCbiSSCFOaiLUXkcNyDFS56EP0CPIGKY5m96l6KAlJCXpi9FNqPGT5KwYnBmudvNfkAVcUGhvrLjPcpNGe63sNc1qjGzm/KyiH3FGACECPeDHv3Egk+bDKYKsEMAAnag+bakWOZgNInwPWnt8UQk7qYCV6Y3bIjB+Sjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573761; c=relaxed/simple;
	bh=DpkmO3CzAIITolUqcIm8SIyJsLheeQFFoM2uVB+k23Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n/JwZunFmPjsjtqVnyJRQ10qwHkckPpArXpVH5W9LdHCh1SKI4bf5GRD0RNFM0GQmcHMXXcxXtZhpH7biutmbGC3oSxyXbVcze3xa5I5qXejXIwYgl5DMbrj9fnLvdOnPxGCzLBLSvttXtYNNbtc6+/+HGmyfW/G/eeWmh8gz40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oJKEDv8N; arc=fail smtp.client-ip=40.107.75.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=demoWX0EU78T3Yphpp6FMuUjVay2z397aohp9eCT1wuhMna3NPbFakIoN7sCwDItivzexhVyCIF00b0TaXBSOWFpzIRWUAkTj3dkJgL6C4m6Gp95hIKWxm7w99LCjyNtP3cB5fPHqYvstir2PhhqcPX0L8Hh9XZOP3opt+AoBhYdZRns8LaNSPE0tJde6u+nDCC36jgSzOUfZ4/vh1eZh/QeWv4tC/Q9XkNtThzMzTrQZtZjDB0gwNxZmqazoQ1mRmLMII9Y16DkZybfjnXOP+luS9M5ZAEkvIxxRcgEN4Mk/XMXoNSP5FoOMiqsY8qYTSZcW3jItaACsEW8Tu3ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZCOD1+85Us5QOOijfG1w6IXj4sUl7GT2jw3DIzpWb8=;
 b=DBi2BaseMIV1/55LMuS2Bhf64GWjzw2fJnIuJlMC4kNHgB9deunHwE9jbMFSFXtnNU+IL5gyHP8bwk0Wx4vsVKRuHuJ1YZ3731HhV+V2NPqjj5M15hvgRHm9NyfK8wLEkJ9VUuMrxLuLF5cNeJQ30VARySoi2dqkWgD/ob0vxazMOz7rDrX3uJDae+nnIRvzPDTeY2XRBNWFBD3aoBPa8OosR0aktij8TYFBNQtRTn2gWI7E6as0/iwIlkwpCY0LaIsdxaIGJmfqpGQl9CzJQG1ZMiDuGG7koCKUvCPAQxWfXG7IjodNRCLTUGtpzvj+r2w099xqzaJq6oX8ZiKCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZCOD1+85Us5QOOijfG1w6IXj4sUl7GT2jw3DIzpWb8=;
 b=oJKEDv8Nmbu1mZzGJkW+H2pxdZm2pAmyCjki28nRNRxTIaM+ADRcNU7U1dV9Kge/UzN6QkUQniXEUBZ2joCLl1TSRF/2hePmwTbWKq/Sf6qMsz7X/+0Esl3YsUjvfAo20wGC/T1bHgG5iQKWM8xrR/n75+eILZuNSsWVIZafJHcdDliruXOFH5EhVQA0Z+y879u06nE8TYTU4b38Qu+bxj8utIDIZNtZWKq1TNdpzXa55StzniLoshuKCUxuyzQqoYjIZ5GL4gFN3/fXPoAsIsjwxlYLWabRHba6gbvlKk/oooMyBdKJILR/NmFkHCrOjReCyCeQsgCScuVgo6Dt6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY1PPF33E28B4E6.apcprd06.prod.outlook.com (2603:1096:408::90e)
 by TYUPR06MB6271.apcprd06.prod.outlook.com (2603:1096:400:352::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 13:35:54 +0000
Received: from TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 ([fe80::6beb:51d8:f9a4:d4ed]) by TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 ([fe80::6beb:51d8:f9a4:d4ed%8]) with mapi id 15.20.8989.015; Thu, 7 Aug 2025
 13:35:54 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH v6] f2fs: add reserved nodes for privileged users
Date: Thu,  7 Aug 2025 21:35:01 +0800
Message-Id: <20250807133501.551848-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0307.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::15) To TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 (2603:1096:408::90e)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PPF33E28B4E6:EE_|TYUPR06MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc0424c-dc22-4482-9c7c-08ddd5b7550b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D4gY0KomGa2qSxNpNhFmta0w49BIxUi1DrQbgh/Q8tsJh4MtajaCZJ38g3Qx?=
 =?us-ascii?Q?IjoyfZ3yRqn5wXdxj3y+XkNY+r9f8M0gNYy4/roFyDob6/IpQ+xQuB8m4IUc?=
 =?us-ascii?Q?vGIgawvZqrQVrn4hHcwN3h8DEqLIZsmFNypqqwrkGypY8v08KCrxv4pfKXSs?=
 =?us-ascii?Q?hSi67HvIdFStLonQukRTkguoBKkiLiwt5T29S/m/eo8XKx7QnfSN8BbeNt8s?=
 =?us-ascii?Q?WZP+vHBuRllRxofhRWdPPAjS6IwoeP5x5pAGQ1/QR412AS24DVoBk2w53QCs?=
 =?us-ascii?Q?ZaACsj+yUMRNXFF79DqCuCJNwUz0mKg2OM425O7CgytGzCHu/e5gtNuNZ6u/?=
 =?us-ascii?Q?spXP4IkqTqZ2Mt49nn6cLwjooGYhbm+4HZXc1/IWdCWARmc06UlCqLrxWGRF?=
 =?us-ascii?Q?xnqZr3DnPJUthTeMp50kzlRHk3YGtPHyCTZZg055IzgLiAz/ZtprQrJJLmw/?=
 =?us-ascii?Q?Fr55PQbIlbSKwBqYX5HtgesoxfHLXH56NWGNR/T3s/KIpf/M3QJm9T/JyZQP?=
 =?us-ascii?Q?YnQ2MeBFBySDwUpcRCUCCQr4vXUFbv6n+iW8SR1WuW1rfc4+9bg3SwwlOWMA?=
 =?us-ascii?Q?TupL6hOT62CdmBclBlFbzO7FVGYU97HXxgeX4AsYgGEABpmbWoESC/k4VvpG?=
 =?us-ascii?Q?rC6xADBasRuSg4HrLiyJopgxHtyqcDoRghabguEPP4WgFCilC7OH3mr922kU?=
 =?us-ascii?Q?1gDk9c/oD0j8P3Yk9vkvwyAIjJGAMswQchst/lVLplqI+qhLIsrASJRdrFkh?=
 =?us-ascii?Q?MqsGwJ33o+3RFLiwGCue+gi6RRsQiDr/09bxep+q43m9eHzOKBi4TKLSt7Hy?=
 =?us-ascii?Q?9grCfz6xXGcjfbvBLsoo51k5r8c4MaMyQpQTOTbrBDjj4wHhvtr1FRZSPkvx?=
 =?us-ascii?Q?jSI+7QXEcbFNAlUYMgDSitDu0kcIBPGf87EwvRIlxmF1vAt8j/dB68fFd8tO?=
 =?us-ascii?Q?3StbxB4rdc0lGQ9STWQlq6jWhPKrm2Q2+ni3VnnW2l6GZTrQq3uM9jKaawEW?=
 =?us-ascii?Q?Efdw5oTaSkzv61SV1+vJeSEur25aXz5BFv52ot9piG3fHvwPkKkvd8FpwAGS?=
 =?us-ascii?Q?TWwJ4F2RfWD1MxgmQfHvPwvxnq5nIgCWZ/ExDNtldVPZuwcnk4ZJJHKUl90L?=
 =?us-ascii?Q?9vSBoIKhvr/bpt1SE+0NEo+n0Fvn6tuy5o0e5k/1cRGQ2w/dhBjbo4meL2tA?=
 =?us-ascii?Q?Jz1Pib82dsckXAw0n2JC+fhLoQTdRAyCBDAzfVAW3ZMjjpGffXctXId++LRx?=
 =?us-ascii?Q?8JkY8M7gL7jiG4/FjmcEc3Y0+VMpPv/lW1Pk2B6t3EPRQmf0MIRcoT4rSON3?=
 =?us-ascii?Q?sdDtT+q3lSiQUmLZ0NsXsGTTpuxa6NiHW3ObZJxaJK8u+IrY09xy+QqzbUj1?=
 =?us-ascii?Q?Zt9isrqY/og0nG/n89tXbWA/kPXiVlTPg4vcl3o2O3guQQn87pmJMceaRUWg?=
 =?us-ascii?Q?7DEOk/W389bPXzZk/gVu3qRsbh0AvGVICDTfxwGzVaN21+MUQuPC7y0Cy+8n?=
 =?us-ascii?Q?m3TsCUooeNzC9Y0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PPF33E28B4E6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kw005l0RLenHYU7w1hhvrL43sufbrZq4IWk+5a3ueSxHiX7zd7kM6EN9lg68?=
 =?us-ascii?Q?KvxZ5tTYupnGOls6d3XmP7cgcp0nhZUurk/mbY2WG9NuOAP5jiyGMgzHDkDW?=
 =?us-ascii?Q?5BUBPGGAXoeaWfGn0hUSRbvpCyK7FKsRS5ynAJqvTMuJxc1X6adDlhOht34F?=
 =?us-ascii?Q?wom+2raxhmVzfUdUgaYAiH3DtHYRPKLFJsEDsM604XHhDQ5Roi2ntyRGROAx?=
 =?us-ascii?Q?zzWoWB0d5TxAc6H2QE+o2iEEoNR76blx7xBbLY6Xk97gdFy/qsPAZEKyJvuD?=
 =?us-ascii?Q?Ba1R/yDN75chHbyxFEuxHpevaqz4rJk4MnU5FSkIWDL+3ahZrK+KM3I53LLU?=
 =?us-ascii?Q?OCTzyGQ6L3Tri8/caAItOCAgFY5i4jWudZCsi+DyjDz8pLDAA7TfpPXFNlVC?=
 =?us-ascii?Q?N+awXzruIkouKYeGNloEQTs3ZvEYrJzhWuOjItqX5RMhrDSA+lUp5XtNWYQ1?=
 =?us-ascii?Q?9Z8oQ8VIA8XKJZwFtch9iimW/BBm/j4OD+6bI/eUxLs6DViPmNPciH8lxTWm?=
 =?us-ascii?Q?kj8SPaNySEB2AqL0ydHIFto3V2sCluyxvgywc1H3u+hbdlsvRkeO+Gkca89e?=
 =?us-ascii?Q?SgtygvhMZsO+z+9h0el5GQUdGZwRrxubbTSfl12JWUXy4gDLcGXxa75llTbL?=
 =?us-ascii?Q?f8mwFukkeOgoIa+dZhnVfaEQdoUjV1j1Da4P/QWTj7OsfLeWcDHY2DDxMEfV?=
 =?us-ascii?Q?AzlNLpinzE3yx+L/av5nX9Q8r3KyYiekmXkL+04DPCsCWIFcTeUbrP7ejM6S?=
 =?us-ascii?Q?CAG2TI8wMkphccMng8i8mtWzA95BYQmSCtF7COgrcP3XV8FwDJzAoormT+i/?=
 =?us-ascii?Q?0sHxI5n56R8rkgiDC+rp6WCf8u/VMSDniTjky5QMIXdg5FoP/eyifBpRL9dz?=
 =?us-ascii?Q?HDaWOfxFcHHBrAwYhkUKvk574RtkpUtJfV3bQfy5dupB1d6T/RL4J87bhd3u?=
 =?us-ascii?Q?+fRuHhnA87v8VXL8uJQ/eombSyszzbOIsVaf+5Bh1KH5hxXyRtWXQc5YKshL?=
 =?us-ascii?Q?nGSOEO+wvWxxrA1Hq9ypxYGe4/A3m+UlwBnqbN2SQf1k65XY0YCteO5sO7KD?=
 =?us-ascii?Q?P8SMkrd6B6hHbeToI+lCyUBTbCPnM2TKKpGh77v0zlW4UBbykGC0Z9kyOCR4?=
 =?us-ascii?Q?H1qaMxU2Wz9BKVhRBlGLt9q0kXrvLEUQIqjhH/2Lp558XuiLLc63XbboLPtt?=
 =?us-ascii?Q?t2XokVPa44ATPDlxj2T8XBJDtE2GFyS+RX8dLV7ay3fRO3GOSfjV6GKi4fgf?=
 =?us-ascii?Q?YtLP4+7bFmzPeysCLg6+mcafFHBdWkDwQZ3/hCYjyjsANtmVqofVwZznGEm+?=
 =?us-ascii?Q?y41MnGTqBWU7itJMCv8lSAK0JvN/eJzQsbjQJs3o2pycFVXg3tlVznUDPbs+?=
 =?us-ascii?Q?9+0kcqVYsas58lwShPjSp6NVkSiIpRurxKVr/324hNsgz7NO5Srkm6aPM+aK?=
 =?us-ascii?Q?+YEoaN5bDjtB8I3nckfLhpfuhKM5sm1rCf5tckhFZ/9qUuvXpkSWZL0aWjrl?=
 =?us-ascii?Q?Z+JN3rtcQLlondayUhs27MdrOsBbedHVIC1/IASgXPYvwptZRN9TeT2lp5Ll?=
 =?us-ascii?Q?tOlNSlIa9ikYv3z/LbTfNAEElt/fT/VsbAlFdy0J?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc0424c-dc22-4482-9c7c-08ddd5b7550b
X-MS-Exchange-CrossTenant-AuthSource: TY1PPF33E28B4E6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 13:35:54.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qv+K0NiSEKipPL5kFCfx8jodng0hQvAQ9qMbkvaHnteaXyASeoTCqdT99TO8CqBwEiZMhan2tZ6QeCUu4ilDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6271

This patch allows privileged users to reserve nodes via the
'reserve_node' mount option, which is similar to the existing
'reserve_root' option.

"-o reserve_node=<N>" means <N> nodes are reserved for privileged
users only.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
v5->v6: Modified F2FS_SPEC_reserve_node from (1<<24) to (1<<25) following Zhiguo's suggestion in v5.
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
index 5cad369ceb92..e06cbb823bb7 100644
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
index f19472eb2789..047964d66736 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -131,6 +131,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
  * string rather than using the MS_LAZYTIME flag, so this must remain.
  */
 #define F2FS_MOUNT_LAZYTIME		0x40000000
+#define F2FS_MOUNT_RESERVE_NODE		0x80000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
@@ -178,6 +179,7 @@ struct f2fs_rwsem {
 struct f2fs_mount_info {
 	unsigned int opt;
 	block_t root_reserved_blocks;	/* root reserved blocks */
+	block_t root_reserved_nodes;	/* root reserved nodes */
 	kuid_t s_resuid;		/* reserved blocks for uid */
 	kgid_t s_resgid;		/* reserved blocks for gid */
 	int active_logs;		/* # of active logs */
@@ -2407,7 +2409,7 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 	return ofs == XATTR_NODE_OFFSET;
 }
 
-static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
+static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool cap)
 {
 	if (!inode)
@@ -2432,7 +2434,7 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks;
 
-	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_blocks(sbi, inode, cap))
+	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
@@ -2790,7 +2792,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
 {
 	block_t	valid_block_count;
-	unsigned int valid_node_count;
+	unsigned int valid_node_count, avail_user_node_count;
 	unsigned int avail_user_block_count;
 	int err;
 
@@ -2812,15 +2814,20 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
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
index 3f8bc42e0968..f37004780ce0 100644
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
@@ -273,6 +274,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
 	fsparam_flag_no("extent_cache", Opt_extent_cache),
 	fsparam_flag("data_flush", Opt_data_flush),
 	fsparam_u32("reserve_root", Opt_reserve_root),
+	fsparam_u32("reserve_node", Opt_reserve_node),
 	fsparam_gid("resgid", Opt_resgid),
 	fsparam_uid("resuid", Opt_resuid),
 	fsparam_enum("mode", Opt_mode, f2fs_param_mode),
@@ -346,6 +348,7 @@ static match_table_t f2fs_checkpoint_tokens = {
 #define F2FS_SPEC_memory_mode			(1 << 22)
 #define F2FS_SPEC_errors			(1 << 23)
 #define F2FS_SPEC_lookup_mode			(1 << 24)
+#define F2FS_SPEC_reserve_node			(1 << 25)
 
 struct f2fs_fs_context {
 	struct f2fs_mount_info info;
@@ -447,22 +450,30 @@ static void f2fs_destroy_casefold_cache(void) { }
 
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
@@ -851,6 +862,11 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
@@ -1438,6 +1454,14 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
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
@@ -1637,6 +1661,9 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 	if (ctx->spec_mask & F2FS_SPEC_reserve_root)
 		F2FS_OPTION(sbi).root_reserved_blocks =
 					F2FS_CTX_INFO(ctx).root_reserved_blocks;
+	if (ctx->spec_mask & F2FS_SPEC_reserve_node)
+		F2FS_OPTION(sbi).root_reserved_nodes =
+					F2FS_CTX_INFO(ctx).root_reserved_nodes;
 	if (ctx->spec_mask & F2FS_SPEC_resgid)
 		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
 	if (ctx->spec_mask & F2FS_SPEC_resuid)
@@ -2359,9 +2386,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
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


