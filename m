Return-Path: <linux-kernel+bounces-847868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4A6BCBEBA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33DDF4EE08B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE90273D7B;
	Fri, 10 Oct 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="iGZoLv0h"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67B1F5435
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081393; cv=fail; b=oCWanLiohRAN7u1TARiFS/5sbpzKDT72lI51qYNfPGuJ9FTqYLUcGF10acjGwueNqJMbJ33yDgQI8gXx5Rjb1Ce+ZNAL9dg6MxTAOQoyHaLqSbgA2JNfYlgQejQNkrCAIaB+xAqzRfgaEy/a7j31Lc8zH0OjgaasRzJPG4CcQs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081393; c=relaxed/simple;
	bh=a83p9dET9/VwfpCMh+pWs/MThOOYCA7jIsGFsfjTBnw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GTY9KpH9IkxjEoSUkt7+AJF81fdAaNcGtOrV9Y+vo64TS0kFp4m5u1qkjN+qGqzmRycuXujqn7pyVWV7TnFCWTg7bTcTzmqW7UpmZDvP9u+s7jt6gNTOeu7yaOzimt7vZC27xEtgMBFjsJuqa+ybR705DIQZUeFD2P8OnPxOkM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=iGZoLv0h; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AV1DeWdyGn8bqqh33674V4e3Y8APbRkTyAux0iN1SMSe7fhjYgoeblH+hMVDOq10dkhZY+ETLLMHO/TOdW6nyoQtq43o+Jyec5b1QtPL5BA/iS8jzJ6o2ny+Gh7TG0V+CtqtW1u0x3hguM2fthS3DgLLH2vKde29lKD/W2CPwy8oP16jQGHAy9OWVwyaNa4FXiOPa9VGKk9sNST3y/z9fW5+Jomp6HQ7vjmMmEvbkYhmIvdBPccOFhRPNz37J5e5KkNW2HEWqLfHv4faLezHULy0q3av+xTFmvR/l4CVvG/kcK/Ue9qVgIBEM2MZd+PccFnF1oYc/tsyM9+z7ougZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osVjU6/3HvPxoKbGOzab4V9/CWq3EJ0SikkkdAGPHyo=;
 b=rTgOzwJunYwnxEn9d6XkbewAxPQyDuIcKRRT/iNz6Gvz5+28F+sTYLJVlPSAeS6+2LNqME3icMIqee4GcA4iGOyzq4AQkjoIGo0rf9X4iJhjmd+PzVrnys2PdUK803UDOC3CBoO+X9XY4zOVmQaLSuHfzFYMmECHM0iBU161JpAejvMMzixyPj2T+8Bp0UNqhjds3PNDXQfDkKoragAmpp0vM9GwVryeVs7T62RJL9Cz1e7YgYFbZZvvBHtMAL4t4kpFUGk4Td4zqip+D71DYyrqqU72qyuvXocpq84S2f5Pu10hucqejZf3QC0VC9DUz2Pg3lfaap7JKCaivcrWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osVjU6/3HvPxoKbGOzab4V9/CWq3EJ0SikkkdAGPHyo=;
 b=iGZoLv0hF3oA55HmFE1i+pKpl1E7TbP/OLmvcBpUV1hcaKFOuCct4EmEwVb5yXFNwWZgCwfmR3qtNSnVdBiQV0QDQWPn0pqyryB5MQOIEOBsZHGFEG1ayVXoKv7oz+cdAqO+jnEksDrJ8rF8VcnqAuSwkB5UF2COyNaTgJknalf1/tZLQvannrSJdnIfnPBIZCl+BTXbAydp+U1N7sW03d3sa+EteOj+eP9Bd3rWrETDKk7igqHHblZIQXGnZuCz5eNSej/5WcK+deiT9XWzBM3mKiIhwAoVWS+LfWdY80fMiJDr/QR42P/6jmu2jTfIMG11pGU0Si6cIzNrkCKIXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by DS0PR03MB7678.namprd03.prod.outlook.com (2603:10b6:8:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 07:29:48 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 07:29:48 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL STRATIX10 FIRMWARE DRIVERS),
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 1/1] firmware: stratix10-svc: Add definition for voltage and temperature sensor
Date: Fri, 10 Oct 2025 15:29:44 +0800
Message-Id: <9730131748869104e1926cef0ea0ff3f58868d43.1760081348.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1760081348.git.khairul.anuar.romli@altera.com>
References: <cover.1760081348.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::19) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|DS0PR03MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: df8e1d3f-0604-44cf-c541-08de07cecae6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+JGRJ9fucMN5EUrwjQi7DFkT4dQZRGPmRn081OiVb7UAyCK1nCavLgfDrap/?=
 =?us-ascii?Q?8kj7mvF8I9gFBqivrjyU/gezIGgYTAEqhiAUz8++gLxmWMNl7VZPqZOlLDVK?=
 =?us-ascii?Q?0YeGRDfWoE2l+TN/kon2vsUV7wOfsXx2lK11PRWThRhxxx3iJ8C4YLq5QAal?=
 =?us-ascii?Q?V5Zl4WhbLxVikPl7LM4yPGbAXB0LCfuVGMtRHFqYC1hJM1EzITCy4xm1Rliv?=
 =?us-ascii?Q?UpsxmexK0Nei+U6yJ+rwiu8oz+otH4p4EKeHSQ86y+YljZC8ikovZLxKnnFC?=
 =?us-ascii?Q?Skw4KgsaPXnFMSDsUsd/q5oyKVevJ97/NJsnT4e9gbt9rVD65IoslVxJQ3AY?=
 =?us-ascii?Q?z2+CVLHKszUJxn+FEIBujbZa2m8rQ86zkdG99Qz7mjw61/uELtuC8yP4wnvm?=
 =?us-ascii?Q?8UC5S0u3H2hqhijqvRMFumVp4XYMya4lu3btI78jTXk6rrZ13MC24mvOxMQ3?=
 =?us-ascii?Q?4WyHrTGWyVuOxLaNhfS0doH22OxSl93YY3hxWdcGi7DIq71FALC6vbXjs6Ej?=
 =?us-ascii?Q?EQ9uHLq/nBBeYZVV4IpoejcBwy//smBGQDEteWnkmpNKMRAo9YxB5xW5ELie?=
 =?us-ascii?Q?sXKYjM71GtF0t2lhUneFFAV2Hor9sw+4zWLhHID3A1rYAXMzR98mFQUVh4Kx?=
 =?us-ascii?Q?Eh6sxsW7Lt2RXaK/xajC8M51aG25maE4EPgkt8UjA15L6FIL9uGCXJ1s50ej?=
 =?us-ascii?Q?easOmXCvpacXQd4p501M9SVlxLtsHKDYUAX1R8TPRJlwBoTfzZaYNtpnLuc3?=
 =?us-ascii?Q?I3YY3nwEP3vEzJXMER4J9xvrHvQOipelNnxTzxJubi2ckPaiz7xFNTQhO9dx?=
 =?us-ascii?Q?bJqrJ9qlrMVDJyfA6rluoaNRWnVOCE/zQOosPuLDsLIWJpt4vEo/5IAYQpEb?=
 =?us-ascii?Q?XkjciUaALttHI2fHouMTgX/80TJ+ep4txo9uKZknnt6dt3+U+koAKn5mUj2s?=
 =?us-ascii?Q?hWZqRyiBWRqrJvrImmd6/G3CRCBXz/7dkajBZ4X0kqlD3e043T653OVOPH+p?=
 =?us-ascii?Q?rYRlbwNNFgs5P141WFGoNP/UoD4gjSUB1Lf3Xo9HoDkt0nlEh/27LBCFodx/?=
 =?us-ascii?Q?APRBEKZtMp4qNmAQM2sqL3HC1w3B+ABdASU5ghM4HAhHZ2U2xrfWNHIi/OL1?=
 =?us-ascii?Q?R76xL20xuQRv3CVoekFeIud8Orwvf8wC0UCi9xBaxgTzLxDDefnCLL5QzzFk?=
 =?us-ascii?Q?YCSsbxlDW1mWSmEh2B65TkmZTuMuFlAs1LMdFuhS7iNmxJo9wgdeB6ldZwJb?=
 =?us-ascii?Q?4BQYI8+ehy39Bq8fVAx3YJGUsv7ddzYULe3kIPqXFlPPhTCXKLlPfNABtOPB?=
 =?us-ascii?Q?9FDSL+sjUOR3uznrgkwYIw/Olqjf2hLFs7SpNL3LlrataoVwFQQvSQe2Ezt9?=
 =?us-ascii?Q?VL7G6+r2OA0yLvR66+JxHHlDinQj0ESZGeclDPDvQeAsTO/lg6ipiNe93sHJ?=
 =?us-ascii?Q?CK04IC/oYbkCeE1G/l7psgSOa6NwxE2o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E8J+BzhtRlBBxdzelIk4mPYd5B52Wtv9NH5v2KU+3h/mEiZEH/btsQCOJiHY?=
 =?us-ascii?Q?ZDua8N2mBG7gpvcPUoFnGzSGGs+kyaae772XShKnC159z+jsbaQo05Scq5uF?=
 =?us-ascii?Q?ykd7u+v+tnqmWxLBcwrgKctsQKElphJW3Zh/GSAS6gwscViOK6pdq5GRKlxR?=
 =?us-ascii?Q?XomoFVFtnf0FWcI2u8LpnonJIcBhDjVFg85I5aCSqPH1AiPqSfMB9XBqjGJ8?=
 =?us-ascii?Q?co3mUMaU0jptjy9Wlq0TKCitIXuxzGgDete3rNNGDJyyHnsImSXCbIgcXeDE?=
 =?us-ascii?Q?v1UqAXDQd2Fg1QULAa77QRW08Kui1cpfE6cJySaWwu5NRJOn7hJmCeiEDiNm?=
 =?us-ascii?Q?/N+Hz0jUo/53OEm5Fp+ugcxylHCXSvHb/5VVWptlhUsM/C//JIqeTTjmzXzM?=
 =?us-ascii?Q?kHx41oJx3Cw47ZHm0vL6sQfe29YxHnOXTcXmWwYllTGAMoOdDuf5O+hVfW1N?=
 =?us-ascii?Q?r/4WaxzoPH2bqbIQpcvkQhmVrRRi9LutHYM3WcV6WxYXTC2gHxh8Vu6Sl73F?=
 =?us-ascii?Q?W277udp/xji647uEl96GnFj6NE5FaZ3PxuJb6FPwFQcyKoKDdHARNuXxUMjV?=
 =?us-ascii?Q?92bs5lD7C4MUeDGFuljWvDlxkPKs6TqImxeyw/gF/r/zsrjcMwUB87qN9dW/?=
 =?us-ascii?Q?xoJQWLoYqodCpC21Pz0zZPRZ9DuKJF/gbCb6gUEot+htZ4YE/Ohnf/hN8vXo?=
 =?us-ascii?Q?aJHQnJRB5x5fdsTGZtNhYJo7zPObpTO4maW985ZJVcQ1mQv/9CodXHvf40Gw?=
 =?us-ascii?Q?UiGavCdfxkfXaoaXQzKF1W9s6aU2II53N/B51dnXdwRhl3YoqmSpiPmx301N?=
 =?us-ascii?Q?8YaQb0itOAvUH8pQ9BpCg07Dk5jQBNYNT9IyWXUgVMXyfaGe7kgCCIswDtXl?=
 =?us-ascii?Q?Lq48XgfBNOwJJD+BccQtNzolK50gBuWqZJ/K5Q8D1P3GQlgUMnhgnLRKEU9v?=
 =?us-ascii?Q?tnBRgruVs0WL7wa7OypL835bUmD+40bYP+G8w/y3e1kWyLqm45vZ97l172fp?=
 =?us-ascii?Q?FQY8DwvjGIV5/lfyaaPKd5btIOUFqp3VtZt2Ge8EsARxXvcBvermJ1fwxppr?=
 =?us-ascii?Q?N8VbSc4IgVZixQpx77p7hhNlRJkXkK5xPPJ13brKo+9p6/BwbIpGqMMfYqW7?=
 =?us-ascii?Q?lXPuCFgGotds5sDrY/a4u8H0dt8f1ayQA+CJIJBQRssuBBi6Wpn8atVgOkbo?=
 =?us-ascii?Q?Aq6ZiUJhb+tJUMas9R4CksC4nIbcKOjnba0MI6yFgSRXayHC2d9OUXuXKN/M?=
 =?us-ascii?Q?NLL3ghqU5fRBkzChUpM53OzxWkPK1WkgItWoZ7fPIDsK0sKr7+ipr7v1aULJ?=
 =?us-ascii?Q?NSorq/dxwpcHUnDm5EveE9Rdcf+RQTVyPheaAUbfYKG0PK7wVdPNhXmkHgvc?=
 =?us-ascii?Q?oB98B07IXJdrq/B32y26axgpqmVTPBEkqI6Qy/Bl7yu8TbNl4Cn8Hmxaujz/?=
 =?us-ascii?Q?kVOzIepOZy8fewoJbhNtp+mlIy800T3ij9bYFWHKL+qmUXUgYbwZeD3GG3we?=
 =?us-ascii?Q?eQ8tKEw3FqXCdDbC13qj4GoC8YOIWV03YIEtSpEzJYj0t7O9zNlZCOPqz5Iq?=
 =?us-ascii?Q?SkImWimOe5oExT0aaUemNaSeiYGzy6NFuNqhAVCAZ+a7wLMZbvA7N3mfOewd?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8e1d3f-0604-44cf-c541-08de07cecae6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 07:29:48.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rG5cZFMQ7tpl2qrdEKJRrQijP+n9OYdpePX/kQSm6Z4VxZKXrNk8e/0vCHdqfPXyHRlAED4QhdpyoO+/Q+skMJhIYV3EPP6TiP6Ij9fqfSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7678

Add entry in Stratix 10 Service Layer to support temperature and voltage
sensor.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 drivers/firmware/stratix10-svc.c              | 21 ++++++++++--
 include/linux/firmware/intel/stratix10-smc.h  | 34 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  8 ++++-
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d7..5a32c1054bee 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -34,7 +34,7 @@
  * timeout is set to 30 seconds (30 * 1000) at Intel Stratix10 SoC.
  */
 #define SVC_NUM_DATA_IN_FIFO			32
-#define SVC_NUM_CHANNEL				3
+#define SVC_NUM_CHANNEL				4
 #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
 #define BYTE_TO_WORD_SIZE              4
@@ -341,6 +341,8 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_RSU_MAX_RETRY:
 	case COMMAND_RSU_DCMF_STATUS:
 	case COMMAND_FIRMWARE_VERSION:
+	case COMMAND_HWMON_READTEMP:
+	case COMMAND_HWMON_READVOLT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
 		break;
@@ -525,7 +527,17 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = (unsigned long)pdata->paddr;
 			a2 = 0;
 			break;
-
+		/* for HWMON */
+		case COMMAND_HWMON_READTEMP:
+			a0 = INTEL_SIP_SMC_HWMON_READTEMP;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
+		case COMMAND_HWMON_READVOLT:
+			a0 = INTEL_SIP_SMC_HWMON_READVOLT;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -1197,6 +1209,11 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	chans[2].name = SVC_CLIENT_FCS;
 	spin_lock_init(&chans[2].lock);
 
+	chans[3].scl = NULL;
+	chans[3].ctrl = controller;
+	chans[3].name = SVC_CLIENT_HWMON;
+	spin_lock_init(&chans[3].lock);
+
 	list_add_tail(&controller->node, &svc_ctrl);
 	platform_set_drvdata(pdev, controller);
 
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index ee80ca4bb0d0..7306dd243b2a 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -620,4 +620,38 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_HWMON_READTEMP
+ * Sync call to request temperature
+ *
+ * Call register usage:
+ * a0 Temperature Channel
+ * a1-a7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Temperature Value
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_HWMON_READTEMP 32
+#define INTEL_SIP_SMC_HWMON_READTEMP \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READTEMP)
+
+/**
+ * Request INTEL_SIP_SMC_HWMON_READVOLT
+ * Sync call to request voltage
+ *
+ * Call register usage:
+ * a0 Voltage Channel
+ * a1-a7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Voltage Value
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_HWMON_READVOLT 33
+#define INTEL_SIP_SMC_HWMON_READVOLT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READVOLT)
+
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 60ed82112680..520004a5f15d 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -11,12 +11,14 @@
  *
  * fpga: for FPGA configuration
  * rsu: for remote status update
+ * hwmon: for hardware monitoring (voltage and temperature)
  */
 #define SVC_CLIENT_FPGA			"fpga"
 #define SVC_CLIENT_RSU			"rsu"
 #define SVC_CLIENT_FCS			"fcs"
+#define SVC_CLIENT_HWMON		"hwmon"
 
-/*
+/**
  * Status of the sent command, in bit number
  *
  * SVC_STATUS_OK:
@@ -70,6 +72,7 @@
 #define SVC_RSU_REQUEST_TIMEOUT_MS              300
 #define SVC_FCS_REQUEST_TIMEOUT_MS		2000
 #define SVC_COMPLETED_TIMEOUT_MS		30000
+#define SVC_HWMON_REQUEST_TIMEOUT_MS		300
 
 struct stratix10_svc_chan;
 
@@ -171,6 +174,9 @@ enum stratix10_svc_command_code {
 	COMMAND_MBOX_SEND_CMD = 100,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
+	/* for HWMON */
+	COMMAND_HWMON_READTEMP,
+	COMMAND_HWMON_READVOLT
 };
 
 /**
-- 
2.35.3


