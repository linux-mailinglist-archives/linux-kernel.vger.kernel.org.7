Return-Path: <linux-kernel+bounces-882097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC71BC299F8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 00:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F4221188A1E9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 23:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819E3632;
	Sun,  2 Nov 2025 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="HclN4aGW"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD634D380
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125699; cv=fail; b=CG0bY92XZmQNqyfn031WBOj45BqktEN7VbLotJ8aXXtvI7leM4m/lgml7RN+qg4F1y0+OZKggCpOBIjb7yfgqjp1yNO+MLM/ZZ3fEE0lKyj5d6GbdGw28VnDVX+koqsJonaL1Ku5XgJL6S5WR849vX4Et4gHqBqsnuUx2tvJkw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125699; c=relaxed/simple;
	bh=3BNTich1NgfxwHeN/p/E7yA831RbZbdVL7BBkm6Lbiw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UztEu/adhV+LR2lzDHIB9eRNZ+nn5vMs1Fj7npzBjgKZfqDOqpT3q5qVCBobD9P+OWqxuM7+Go/+2MeIAuYca2XBt7vRRAX5f/uVVwfQyNDbd5NpS6VUmQz6oSNwBbAAwFz0Z7D6a91Y+gBtqZRP2A9QrILKrCF3mC1tngzmuJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=HclN4aGW; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/Sg9x3pw8OOEvqMlscFZGHL/Qs9ICwx7RmIuDche18s+r3Z2lVQcWnEuVl1pU2TbEda36at2kCkwla19ulxaEhu8PKhIlqM9soVJv3YWpMVSkixM7RAeM61gvAH8+tM9QxwuY2xqroAQZ0xqM5Pqogl+Hhf8gMR+80qKhkj++2YVelToNIGF+XEAfB3V4OjM0hE8M8BEHawKjEXM4n1CxTKwq6BxIGeVGNtPHS98nRpwYHVn02cA9c8M6VoId4GRlqaEN+cB4FjSNfgDHqBYQEtnRgtEY1u3E4o9VQTsB30R7W9zepoeSx+XYUZb1IkqFN0X3HZISQX8kGo3alpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNevTDSSvIcbJtpVRNJUKu9Z/X8uFuza0Aj2ejPN9CE=;
 b=vpaSMq0/FOpuRH8gSG1XExCz/xkegYFpI8kGcEVDCQ0j7Ci2H8cbPF467JnZdZH3ARs6/jl6+yLjaDHzhuh5l8pa+xEAAyG+rCuKrB0mZbzsvhVB6U5qXV3WAILTxuDIHoGXY5iTewacg6aM5ru0+DtBPIQmuXhrrXbDQ2J3IweLlyKeAgrIDz+G9KoE8KvAiJB99/8EdSZUpiG8ib+gHrbV+3yOyzG3L5MSRU7E9uT6SJz9ZtgYLmB57CGQtWKIKeKxQuUZJ3FizTcPL6DJb6BVtki0EtfqAqzid8qWelsdgg9KIq+wiyXMijg8wxPibbKXPKP0TI0vof3J07n5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNevTDSSvIcbJtpVRNJUKu9Z/X8uFuza0Aj2ejPN9CE=;
 b=HclN4aGWuyX3EnS4a+iJ7evdh+Xas5CYOfjanCBhuC8/EvSqooDuoKgezh7/dHyV9v8ctDliQqf9r86r5zNYweXzuAi1ityrzOuNSqQQZh/Bm0VK/netWZz4eDd9cRlKlSRlHK0MUnuVp9S1K+SUhZCM5zgou1TmYzzZvZoJygAc6A/ITBx3D+RySJFcsue+ZcvK6GVr1qZrDppdukk3JVrPUmOdh91nCDTYu8l+tyuVoJLJXzpuDCuf1K89F3y0h/X4vBh537ges0q9t90upc6jir9roCHQVpBgO7coWBI5pTTf5k1l+AbPx2+rB2WRQOlZYfnn8nWBxS+fOkIJIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH0PR03MB5672.namprd03.prod.outlook.com (2603:10b6:510:3a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 23:21:33 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Sun, 2 Nov 2025
 23:21:33 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: dinguyen@kernel.org,
	linux-kernel@vger.kernel.org,
	Ang Tien Sung <tiensung.ang@altera.com>,
	khairul.anuar.romli@altera.com
Subject: [PATCH v3 1/1] firmware: stratix10-svc: fix bug in saving controller data
Date: Mon,  3 Nov 2025 07:21:28 +0800
Message-ID: <f3f620cd38250ed9ae4e44a8bd881a16c05c7bf8.1762125299.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762125299.git.khairul.anuar.romli@altera.com>
References: <cover.1762125299.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0153.namprd05.prod.outlook.com
 (2603:10b6:a03:339::8) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH0PR03MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f0ba65-379a-4f5e-6d2b-08de1a668f6b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EHqp+Q0nNgtMpEF8tF3tPhQFYSJaBh/jnOV3AP9pOy0jgTz1hPqAPqYi+WTf?=
 =?us-ascii?Q?Bg+wbAVh6GFDrfFzXPgywEihjPgXQFKom78QlgvLnm/xYrgnLRs/TRi5wasK?=
 =?us-ascii?Q?faezaO1oomoM5QOkhtbDCISypZiWrrczNFTS0jlxNAZafyqNRwoeCj6iWY+S?=
 =?us-ascii?Q?cGXK7pq2xSIzs/JhF9cjM4LaHV7zvGIId+uKo1I+BBF5MsCiZioywpSuz/aV?=
 =?us-ascii?Q?q3iLWlWmJipAzDLGLTpIWEOv3XcP/yYJtcntRFJIb7onThDPvj7jSotckZ5O?=
 =?us-ascii?Q?vZSAoJ/0hWgESj06QG4cuWxXuZrjGKANS/gGmApUoz8Cj12WSZpOc2YpCLxR?=
 =?us-ascii?Q?3y3VfiN3DdL3L9di3MidGoWpjmBkbJLGH2Y/y9J1Cd8eZrUHz7F74CRALzZr?=
 =?us-ascii?Q?u0YtJVZJxVQZXXso0mV929E5GsliuZztyEX7JAhUwF/asJ5Jt2aK2ZUOBg4H?=
 =?us-ascii?Q?o+C3ST590jkS7b0n7ux3/vIYE7jysBKZGeDOod1ZnXWZw/wGJm4SqJnNkZET?=
 =?us-ascii?Q?ek+VL0im4b+WrqhYDPGFbMJp880zdk2dWfh9epeEYFPGAdTW2fCenjqxOpu9?=
 =?us-ascii?Q?1BB+g4zG/0NUdqkP+XVDSLiMxjPTRtztN8G+a9U/ue7IB+7qOhnx32DPSsOR?=
 =?us-ascii?Q?pH9pJTBDyKX+w/WXeFPZu/ITlO7e3f+EnFMMtXmkD2lMOc07YjSfX6emrJS9?=
 =?us-ascii?Q?z6YYJkZh4YWgtwSTkTKD2tfgF5nxzOjDZk1hRh/gx+GBrXfNxVToegfcm13L?=
 =?us-ascii?Q?ix/PxXBOqcoyP1T5TEzrKu/T8mJv3g7nXp9gaW1GkVY+9FyApmLfjTJG4aby?=
 =?us-ascii?Q?D1XcMXLgOMOk/cTnzpTRf9OUdwe9T62oainA2hzRxlBOFwmWJFu+2wVbNLVV?=
 =?us-ascii?Q?oRQ5yEtA93Oo9PZmjO8vMYGMK/fKizd+TmUg2p5+KJtY7TH81I49LlZgfeXt?=
 =?us-ascii?Q?jq54GaQvFB37OhUdEZOHI0s2vJV2UNtLPFaWNllrTZBk2kZPe9TXsiSzDm7d?=
 =?us-ascii?Q?S5ZFqZlZItX3/tSA9c/qAtOhOC/Px+e7XE+9YD3QF4GOJn+XnPoUQ4+ZD5ON?=
 =?us-ascii?Q?/J1VDTja4SjmWGfN2Eoedbd3SnLVbid9gjH8J3q0B34+fQIyl9hys9L/tGQt?=
 =?us-ascii?Q?q5L5egHuqxjnEZumL8mIlCJkus25gFJL717VOU3qfUUj3EtbJRee0OIgI9br?=
 =?us-ascii?Q?DCILhSNSYA/e5I8f/du/9XzWKevB71wIupIQHmqT3yofpCemWBY/ANgpEanw?=
 =?us-ascii?Q?GWk9+341Pd3oY41zRZ6MgGtO6fbOA2FxTv9WhEkVktK+2/cH5dkLHT6MnGoN?=
 =?us-ascii?Q?THV9nE2B3VnTVnOcThcpOpLZuf1n7sVG+a4T5bcARIxrobLJnAErLDtVmuJ2?=
 =?us-ascii?Q?B/Xz8VFcaNBDoqa3KtAk9JlNsYIHNPQvU+dy9+udYNWIMO4IX1McojR8ZdUq?=
 =?us-ascii?Q?QwJMwFGpR+Fy9SS8kWw1q32Zczq8cMgz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2zTHjYc82pZVtHb6wycCeV+lb4x5PWhe4fsqjfYIvUkVTwcdNSdbQbbiDoP/?=
 =?us-ascii?Q?MpkexrYTF41VjjfBGYmCUvoRKWXtML8rKhZv0uXf/Cd4QnL7XqB1SBs9dEJg?=
 =?us-ascii?Q?S7UTrYoVn5iEJSSy/wSQXz9bLrKRuyhbGefOtvbqK9UkSNeyiZQ1A1Z8Ul03?=
 =?us-ascii?Q?5D56VBDxa6GXz3W/HPKiOhAjGcqK6yULJ1Qwfc5L9j414O6WKzlO3zPBKmbz?=
 =?us-ascii?Q?NMwu9PZm6V7xW3ijZuFsRe8/ZoSsp142h/d2SZZ2zBnwssDsm0IoHnkMSv0f?=
 =?us-ascii?Q?7vHlLv0xFnWzAp7XSRQDHKlQOZcSQrFTJiIAQh/f49hkBsjPh5xSNFt8iE5k?=
 =?us-ascii?Q?5/EDKxMqRv4xaQCyP0nBGlMJORxXsuBC08ILbW3KXzFtVA7u7rwbMePPtNDP?=
 =?us-ascii?Q?LDymhs1MQfeWud2bd9XyVJ6JInermg4mCLC35oRDktrYud8rSnnY9EMQvDeO?=
 =?us-ascii?Q?XM6b9KywhR18CYnrJ7uR9DzGk8F/xh53pqTSGQYVNDwMuYjfWSYcxqckOPel?=
 =?us-ascii?Q?YNwpB8FnH0FNpSFSw0r4K3x9SxaGl8/8mImNtsH0whX/MAiX38+PyHtds0ET?=
 =?us-ascii?Q?lKBr4SoV2i/c/2c9OIQaF3aERIg4Pwzgf2Ej+zR84/C7a+w67fJAIc6KW0XA?=
 =?us-ascii?Q?oLvhhHIDXI5VydihAYDi3aJ42LX5ui048IWjTpQWRc3DjDeyWdyFFSarXUT8?=
 =?us-ascii?Q?6Art+nbzb7sFfD/+09okhKQS9TY/osn73VpIuHVpFCwtD6Z65b3yFkgrvQ9C?=
 =?us-ascii?Q?WpEnV7AYsKTV1j1yKQ3o9cP0skKtdmSymVE3iMwUXEm5zmmEdI224BrnfnMB?=
 =?us-ascii?Q?TK5A3dxVJ/Zt10TauRpIYlSU6smSRykUpK32B9fLUeDEsZziL438Lu+6ptij?=
 =?us-ascii?Q?Z2hBvT2Y6algOEMXEycSjPMlvQELQqzr5LhEGBv/GfbnsSUhsuOwR3Rw9vsy?=
 =?us-ascii?Q?e7/pgKlf91BSVsX71NssycAPMbLJwo3yvyrXr9V/xWJmszkAby5PbCIfWo8A?=
 =?us-ascii?Q?RLPXo4YqIryy7DEFpmPNmS9Rl5l7pOJ0I8fMsTfBQQpPqcDwUkWSziSpiKcV?=
 =?us-ascii?Q?NTOCfIYI+O/QuwZkhFtRAcn8H+jabONbi8u6+EU1jUFGyGWaV32PuYTZD+D0?=
 =?us-ascii?Q?GEh21r9vOQp+hCRxoA0vNv9p5KVycpSzVdeWjZ7HKlr28jcBo4wzAqusTPRq?=
 =?us-ascii?Q?47njyJ9gwBNPHbUyu6fPvdtm977//itsZTnnVF0wxrmO+LCgHSdUWVzajR2a?=
 =?us-ascii?Q?4/8F1SiHhf43yODzWd1wdwlLSKr+xnqwlXRuhDZ02fO7WqkhPaXjQ6ptNMk8?=
 =?us-ascii?Q?aQNVDhIivQ+cMMJaxRLkj1P0Z4OHyKjQVO9TAOWAzvFEF0aGHOv63pEl8NN0?=
 =?us-ascii?Q?ABY3mFjmikr9cltDD6H2jDgmOkQuRpqR5xaYTVWh5dZDi//85/R9ylVwuZIS?=
 =?us-ascii?Q?pCZPWi3ToFyfKgO0i+BYot612vVXDf7kBOZw6X1A4SK7CKNRVZqO6+AVPzv2?=
 =?us-ascii?Q?vBDS/A0qxKBIfT0C8MIfJLb2yo6nVcUktPo0/XCcfilezVAhCSXrn4z912y+?=
 =?us-ascii?Q?jj8q9cwcL088cQp8xKqi1U4B/tUbLSdRdttUGnNQG4eYltAEpxW/djK8+8kh?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f0ba65-379a-4f5e-6d2b-08de1a668f6b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 23:21:33.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEwsr+jwEaY8iRht2lQfUIgCwqe+36GR4ZPyiiE1ZHpeHUzS4popSn27rI2oCG2CwekC/cSNtn2lCbtS5nQ5/+1I74xl0/XoGZa7w6cMV6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5672

Fix the incorrect usage of platform_set_drvdata and dev_set_drvdata. They
both are of the same data and overrides each other. This resulted in the
rmmod of the svc driver to fail and throw a kernel panic for kthread_stop
and fifo free.

Fixes: b5dc75c915cda ("firmware: stratix10-svc: extend svc to support new RSU features")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v3:
	- Rebase on v6.18-rc1
	- correct cc -> Cc
	- Include link to original patch that was not sent in 2023 but was not
	  merged.
Changes in v2:
	- Add CC that was missed in the v1 and original patch from 2023
 drivers/firmware/stratix10-svc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d7..00f58e27f6de 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -134,6 +134,7 @@ struct stratix10_svc_data {
  * @complete_status: state for completion
  * @svc_fifo_lock: protect access to service message data queue
  * @invoke_fn: function to issue secure monitor call or hypervisor call
+ * @svc: manages the list of client svc drivers
  *
  * This struct is used to create communication channels for service clients, to
  * handle secure monitor or hypervisor call.
@@ -150,6 +151,7 @@ struct stratix10_svc_controller {
 	struct completion complete_status;
 	spinlock_t svc_fifo_lock;
 	svc_invoke_fn *invoke_fn;
+	struct stratix10_svc *svc;
 };
 
 /**
@@ -1206,6 +1208,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_free_kfifo;
 	}
+	controller->svc = svc;
 
 	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
 	if (!svc->stratix10_svc_rsu) {
@@ -1237,8 +1240,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unregister_fcs_dev;
 
-	dev_set_drvdata(dev, svc);
-
 	pr_info("Intel Service Layer Driver Initialized\n");
 
 	return 0;
@@ -1256,8 +1257,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 static void stratix10_svc_drv_remove(struct platform_device *pdev)
 {
-	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
+	struct stratix10_svc *svc = ctrl->svc;
 
 	of_platform_depopulate(ctrl->dev);
 
-- 
2.43.7


