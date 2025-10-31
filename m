Return-Path: <linux-kernel+bounces-880781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E59C268B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152BF4225DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783E35471E;
	Fri, 31 Oct 2025 18:17:34 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021142.outbound.protection.outlook.com [52.101.95.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71D5350D79
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934653; cv=fail; b=N890b2sz1qlirjF3o33wDPtWIt/VCNWVw6j5MlkjOmVtvRmtCbNId3/UHfskr1WPHYfXBdtD3KyP1z5fwazlQoI0CGMyOUmjgqxomtlRTgYel5MJ5SaObJsQwwZ9/w+jsLvFcAh/8ogTewPa0eYerY/ORz40FkkIS2sr228oEWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934653; c=relaxed/simple;
	bh=b1PZPBPQ7+159SdaCxUutSXWMquBzBC46Gs5gYfJ7mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=keXG1mmsoNjIz1o8aQCjmcnokKThvo/g2ojPKbNocmgU1M88aw9/i5hwaij8WqpkHaU78ryxUqVdldeDtU+xrbEe6lo0P5WguMX6lG5WWUMK2JvCH7a7R/eZX1Ib0z4ZyK+T0M9PHTg9Ifm3Wg96CdkFFbSamqtNOLb5vr5cc1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJg5exXopwKI7m/8cufwYI61wQWXSW04hWUpOFU6sdSRKvJfinxvo7vhDaCm6Kuw59BkibcmjZYZYq06ZXYxQJPLeiLJroMOJNLG8VESMaCEYc2CYDxM0SMTg1bKBYkGOcZ2X+p185mZeTCisVpF4Fn4qpJVV2cdkuwW67WGaggmtZmBYiaojtJrvFrfgyJ80r58XE/dEfVCCg+nYLhI4O92XlxgpcQz6ursr0tMVLCFu2pVOeBHLGdO0EgvD+J1mVfvuBavW4b3TYG98xtZ8yqzvstGHiNDxnCPO4jSsNbBEUpXLLYCpKtE7lXRhNfUMjzjcJRcRpXshN2v7GthIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3Fyf+JvSEgbbfwN8CvWZB6T6PbCZLs6Tzc6pER2YHM=;
 b=JM8Dye1wCqrjSH+RsFst6BR0pUNNvVdaMjAuO02RXnNVba09ccA28M/V0vx/oCI7MPvZgH8bTFvfhy3RDYWmmboqU2FLnuJa+/yAPdqdVkrh7G//RubpXQOpaXfys9sX5tnWmPoVudoiNCshbMbtGHpDR9R8YsE/FcXmwfMdbU0irQInb2JIsy8g43g8blf3f3J2OW4xrNQE9CZ9wYlqnzOhMBcja6JI2ZPGF4NrWrm98OrIF4C7VfkgPB6ZrXe41TNLMJpM7hgW7ZFrmhNZe28g+GzyVHAI5aik82cXnNUN5frf2zU8ijWVCO+ayr5FN6S7m05rRcLVTQdRk6z0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB2719.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 18:17:30 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 18:17:30 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: tony.luck@intel.com,
	reinette.chatre@intel.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] fs/resctrl: Show domain CPU list in schema output
Date: Fri, 31 Oct 2025 14:17:21 -0400
Message-ID: <20251031181722.250851-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031181722.250851-1-atomlin@atomlin.com>
References: <20251031181722.250851-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:408:143::8) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB2719:EE_
X-MS-Office365-Filtering-Correlation-Id: 1007d606-4e58-4fec-dad2-08de18a9c0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5jOSXes1iTwL4uthxUoUbo/KdspaHlT9uAqsV+wA7mjD6LN87JQwGl9pKrMC?=
 =?us-ascii?Q?Y3DP6tp+yOckAfYhAPh/BDYiI5B1cvQ+0BRkYpy73VPdmtcFH3ffKC+xHxVc?=
 =?us-ascii?Q?FWbVpeA6Ti/4tasIhStkOfvThWzGcDf8ZM109VZTj6OMM/IjI8t+ulhB/uMR?=
 =?us-ascii?Q?LZWseULKA2p25juF+/TPieBCveaI5zR2opEpQVTR7ndj/8OJ7So0TkKRklY8?=
 =?us-ascii?Q?VM7wY0lgUm85twcckN35ed1twT20Xq7GOpMaWaOJYw7jdjlvw2OhzQ65EOwk?=
 =?us-ascii?Q?g1NLT8pCUdP6m2qDzmTRfW2ldFNIGLIVsHTT9u+g80d+d52D7Y+kCYZ80ZCd?=
 =?us-ascii?Q?2CC1KWZozyMaV8+AUkI+LPin4UTQy1M0P8m8/oejYX0I7XJRaE1zXGkIgjmm?=
 =?us-ascii?Q?3Klby4nDbgr6t1CeqGb8Sc7AnsxWO2n4PIKcXmhO79PdWABhoJGmhN4hpxDf?=
 =?us-ascii?Q?ixStMkCJKm2yGrYzQNWvDZ2KYO5qLBR6fLnmxNHRNrkCx3wS0Sfp4eVJPM2+?=
 =?us-ascii?Q?FJPyEs0zHXyCJEfscTIfLwlyPJzHTbU3IdEF+fX8+mA0wKMizM4KVVhmh9Z0?=
 =?us-ascii?Q?87Gvd2PdbuSQhMGavsIPRpq2b7TlyhuelxsoAp4hIeNT1TAJAt1srwIVS9jl?=
 =?us-ascii?Q?IR7x0EQpSz1G+DoLHb06ZtZm1kInCjv64C/zrMJTztmlWtU9IvhprPpVOU9t?=
 =?us-ascii?Q?+DiwxlzZQhDeDV69B4hhl9GAyWLKthxXvYgUsd/sYowKYkZVEj1BjYkq6U6a?=
 =?us-ascii?Q?cLaTIZa0WJBhjk+aGWfFF4U7rwacOZm7Lk5zb0SmWG/j3/O3BKp1bPNhxeW/?=
 =?us-ascii?Q?7WcqZNOtfAxkSR8Qwz1Zu1SOhmYdM58bHMQFR/x7YULJd5clTV7opt839fK3?=
 =?us-ascii?Q?WbLGgdSrlSNOzQKS+iA9yb/seZYsN7xJsG3Q5GHRoFpk/a1cWJRoEFY4N5/H?=
 =?us-ascii?Q?7X1M0q2BMqLY9H2a9hBRbrrSoZcmZjm2ToiCllIOzWrq6sovFca2p1178+1j?=
 =?us-ascii?Q?D+zIpUu1ftASTGdV635XM0z+2sV2I69xwuVeV7/5YYAAu0cb3FLaVNVgbmnm?=
 =?us-ascii?Q?wFh5rfISzZMpDVuA6Pl1B6ukNImStE+UyomkMLpZHfuNO0Ewzsx0mkq7QHrG?=
 =?us-ascii?Q?owxTX+7Fbkcc2s6VdDvS9wqqlxsNgGv3tsDB7h8qmrXa4CrEMPCdkZA7ZfB7?=
 =?us-ascii?Q?bFkt6GRtur6LKJNqYgd1R8Wbecq9PqONiRVePjJYdkcXHiGiCP116AiH9C2R?=
 =?us-ascii?Q?Q9/ayXqV55bPVAP54cgQ8wVtNtYE10g8domRfPNmA2Bhk7e2ahh+zap18F8u?=
 =?us-ascii?Q?61Ww4ak4BjKwgPL3WuunGSyE3v0/B//uragQ9Dl2zjWpWYotl220eqoGOEgd?=
 =?us-ascii?Q?HuuPgnj1Up7KC55TL5N7I9+Ue/XA4f5eCYqSpnOm8Khh8MJY7JMqvDvSkxdw?=
 =?us-ascii?Q?PYvgu+zfi81AmkbV/vnMEmYLwsKUa9u7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AKB8rmjSSzJ7cG6/q5O/6ugVTqvtk2+PhSUVyl855DXchZ/ELveKtlYweZ7X?=
 =?us-ascii?Q?YvcYy69nt6GDtm1V0P1deXzhjjiCuV3gGeCjq2kVsEuWyjqUHi9BJsLRWUNT?=
 =?us-ascii?Q?E7h+/26BTYk7Tbj+1XsdNF4jWMHr0foeNywBD/JLDI2/3Cbm0oJDZhSAiYkN?=
 =?us-ascii?Q?LGDgDRw1draffzKjhDALHVhmzZ5m797G0zg7EOT/hwtXFl8/ubynFBFPijQf?=
 =?us-ascii?Q?d00OXk8PTDH5dB92GGAK/dA4FMyc9lKYvGniR995zbN2M1PFFT/x3Ut8SctH?=
 =?us-ascii?Q?GlB9aouoFe0DWm05pUcpPO6qrj9RAtea7/SeIbRZTHMOS20zWoPBdgKZEaFn?=
 =?us-ascii?Q?ejZBeUIs+aC+Rqv6ecqpQ58yec/Mcukc/2C9nGbzJiUpfXWh1/2c87DZVDjA?=
 =?us-ascii?Q?oLDgFZDGVGGfBduD3mSBPP77yCly1jlySeQeV2lgdJhqjSFIKswoJTA1WA7k?=
 =?us-ascii?Q?pYx0mENmhiSg3eU8Uchoa17rpMXO5nk5vzAXhjIwcItE/TpNRGVz1cTBzpuE?=
 =?us-ascii?Q?pcjVjP6s41dl4TbZkxj3Df/3cblLQLmuxkwMXR/5iDnWscYfMEgWu8iGQJrh?=
 =?us-ascii?Q?ugXIqp+HGX0YYzdgc5T7778liGwqNDLXvnXIi8Th24EHDFIw5Uqma/hL3AmB?=
 =?us-ascii?Q?mMOIxlLsBWRBo65ngLjLB3iUWhC0BZ7Kdatv9SA9Y3MBaFNRQe58F+1kPfA7?=
 =?us-ascii?Q?8i5NwJo5My+lu9UzMjbWJigQeVOb7z8UZtO9w/6lGuktBzYThlpUxnfoX5La?=
 =?us-ascii?Q?uJiYhYs0dTsKSt4WNsK+QF+bQ19JYixNf3ooNi7mkhSG9L8NbzxQtGHfbioF?=
 =?us-ascii?Q?oyjyaWYn1qS4IFOiWYIkt8wLCjDR+nibZJ88MbGTpQsnLp9Oy4jtzig4EQAi?=
 =?us-ascii?Q?V9oCSCOwthMXMsC2FrLbdoSEWRu2JiEe5sDIVk4f75yceT+IdT5XyPK7FRED?=
 =?us-ascii?Q?Doh6bhwhFFp1f6AUUjyeOuzv0gUmRMpwU+rZ16dmlKnYRVCiQ8E+f0ELwWgD?=
 =?us-ascii?Q?JiNmKqfh7DUsaR3FZAtwYK6uCIsCgGUE40LYywIGn7TopScj5FPmhHD9Tgeq?=
 =?us-ascii?Q?z+w+lJjuIZmqfKCJuvx2EMNaxSKMcKLT9W9auGEwlYVx9kf3z/PS3OATZ1u6?=
 =?us-ascii?Q?XYFI17FG9AMVtmOYPELAU8FBEtBHZULe+d1egkBkYRuWmQsux0WjXTmTtQe5?=
 =?us-ascii?Q?RXYvbj0rh7KrBnicrLiISI0DjstmiLcD8D+dgecJJZgPiZMEkBBUks3XS/QO?=
 =?us-ascii?Q?kifQillNoedSYRXiVDet2o85hGMR+cHDvKoNK0QmCrH16bgC7rH3rtSIlrHL?=
 =?us-ascii?Q?pA51kNIL1RXzDJsbr7A3rYSUQZkLS9ruzCpPy6hYj3tEPv8yzBCECfF7/0Bh?=
 =?us-ascii?Q?D+Q+NvwM6jgH9KiNVAp57DZZK2tmuh8LbwcKTHehaveV2urJuUiyNZnT1XSF?=
 =?us-ascii?Q?f2YthBe2Dxkv/jKVHZquB7HdA6f6R9trJ0eDf75hJn2/F3UiI2g8WzI/rZit?=
 =?us-ascii?Q?9ZqUDewUkyzhSQqUVpLLlOl9MZ0qktwDiePMVBkM4l3Fy3QfTfxsQQNn9dya?=
 =?us-ascii?Q?GepxXmCfrG5SPVMnEWYf21hHDjMFADYT+hgknMM2?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1007d606-4e58-4fec-dad2-08de18a9c0e5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 18:17:30.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWF8VbuDILdC0kNzBI7tFiOh+w6Vu2xrR9SAKOpEnkNShiee6E7b7oe0eqaztAdlCiyzp61c/Eim7zqjy5QwTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2719

The resctrl schemata output currently displays only the domain ID and
its configured value e.g., "0=ffff". This format lacks visibility into
the underlying topology, making it difficult for users to quickly verify
which logical CPUs belong to the listed resource domain.

This patch improves visibility and aids in validation when configuring
or monitoring resource groupings, changing the output format from
"0=ffff" to "0=ffff,0-15".

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 fs/resctrl/ctrlmondata.c | 4 +++-
 fs/resctrl/rdtgroup.c    | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 0d0ef54fc4de..5ad12d15b350 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -402,7 +402,9 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 			ctrl_val = resctrl_arch_get_config(r, dom, closid,
 							   schema->conf_type);
 
-		seq_printf(s, schema->fmt_str, dom->hdr.id, ctrl_val);
+		seq_printf(s, schema->fmt_str, dom->hdr.id, ctrl_val,
+			   cpumask_pr_args(&dom->hdr.cpu_mask));
+
 		sep = true;
 	}
 	seq_puts(s, "\n");
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 0320360cd7a6..cec89ae549e0 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2661,10 +2661,10 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 
 	switch (r->schema_fmt) {
 	case RESCTRL_SCHEMA_BITMAP:
-		s->fmt_str = "%d=%x";
+		s->fmt_str = "%d=%x,%*pbl";
 		break;
 	case RESCTRL_SCHEMA_RANGE:
-		s->fmt_str = "%d=%u";
+		s->fmt_str = "%d=%u,%*pbl";
 		break;
 	}
 
-- 
2.51.0


