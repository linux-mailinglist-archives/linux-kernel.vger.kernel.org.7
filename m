Return-Path: <linux-kernel+bounces-723257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76DFAFE510
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EB8170CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A87128A1E6;
	Wed,  9 Jul 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="uPF4YPmX"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48529288CAE;
	Wed,  9 Jul 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055449; cv=fail; b=BkLL6rwp2w4tCk1tyvy9E/RCLax+HBGqyDmIJjUBiYyBpBMngEO+9YcYe6p2aZoDAbw/+/u81Ic2bL01j0I65r3tJcfEeVAPpijJJdO8g23EJq0lXSnw8WbXPZZkHARY99PefbxNwcPqE5l3ZQ/lqy+n3SR8Pxi+yuHyoMJ5xI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055449; c=relaxed/simple;
	bh=T8KFoyN5e6KjnJ7N2VJpA/wr/UANS1TbL9dXC6/4hYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K70r/gWza589eKd/TnQrjcoKRDonKYq4hu4r2fZbYlVmWeyJO2uKYnGa7Hql86SaSU+1brz50gehotq58o8Gq64HhYit1S5FN/Ma7kRhPvaoJeZ9xo5+iMXkk3iAwFuZepztewZA/f4Uq3qDgnPPadbc1eCFlJ6PtNplbnnfoHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=uPF4YPmX; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvVCMW6v9bxkzkP/Ok6OSLw/J7y6QcoRUbSBMTlAEmFGtv71V2R2AW4t5/kLM8a3hziO+k2EDG3/zWk0w0wU9t0aZKyNELvL2XQpDYS+ee05PLp+AqjuGgLwNa/2Tv80CwmOo9HL2i7IkHx8saCYigJ/TJqDXuJQTHlkiKTYKXLesZDkV2AQRZwFHzcnMriYfRuVcp6G7zl64UAOLlUwgnJfpkNDXHqPXlCU3My2x6KhMHLO1GcOklo8tNPExqnkLV5r4vO1IRc02FKqolZodGK/x8SiKDB53cOP1E1kBpC64EXXX1S4gIsKFLE+ixwL8t39xC8XN/oGgBMXPetYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL1CadwMqw2b5Cts+gkE2U/OZYLHSOZYpDrsRmVQ1Mo=;
 b=pfGumDhRFFWmyw5DNGn6pMf6EsDX57B2TI2mamRCY6e7O0DmWkwj0k4QNtzx3g5rB2JxIc7RuQE8fBoaJamLyovLcdniyJz6luKrvXtIH1MREjQ3INLMBCCTgsrE2MUZKYHdJ/5uW40gLZu7ufeYvBgMhHEt+60FExjRiyolhJQ6xFuoJ0VFX3j0MYAsKhl69h7Pp1dAYa1pxv0a98FS2RlUwS3F6MxTTl+KG6o2oQxAWmXAfAAF5ewqSdcFsddWDPb6mnXw7HR0ZZxB81nre4hPvG+/j33u9Dpgku5AcD7mgLDVFAWolLOHb014cOqO7oEzTe9iidoZBzYEjyC5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL1CadwMqw2b5Cts+gkE2U/OZYLHSOZYpDrsRmVQ1Mo=;
 b=uPF4YPmXK5kNSdhK0va5lS475+sz08QsAC1zn+Dnc/U685GUhc9fDaKoQh5UlHHX63HtFArkILnW8CIpbrIk9MjQyypxEZT2PQs/PE1VyuB3HPxWQc0tD4JpRb7yv1BkkrYf6LGtXn09eZCDGvi/bpSON+bNfRwWOnBGYikLTGjd41YvT8tDsWuhqDrds9TDCrhiWUBoCBR2UWUKYukqpkhRb4s/5l6rlkSUibP+bZOqMUxqsUHTXymE6aYyAcRw8t40X7JRfaqt+KVo2ka32bFqLgSt9Y3GrgyYkm9blJMmIyzc3EJNIyy1aK2SI/o4EM4deGTQ8yzvtXFSSowZiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DU2PR03MB8123.eurprd03.prod.outlook.com (2603:10a6:10:2f2::12)
 by GV1PR03MB10584.eurprd03.prod.outlook.com (2603:10a6:150:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 10:04:02 +0000
Received: from DU2PR03MB8123.eurprd03.prod.outlook.com
 ([fe80::a4:d971:86e0:ff72]) by DU2PR03MB8123.eurprd03.prod.outlook.com
 ([fe80::a4:d971:86e0:ff72%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 10:04:02 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wojciech Dubowik <wojciech.dubowik@mt.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Tim Harvey <tharvey@gateworks.com>,
	Markus Niebel <Markus.Niebel@tq-group.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Heiko Schocher <hs@denx.de>,
	Andreas Kemnade <andreas@kemnade.info>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andre Przywara <andre.przywara@arm.com>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Junhao Xie <bigfoot@classfun.cn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: vendor-prefixes: Add Mettler-Toledo
Date: Wed,  9 Jul 2025 12:03:24 +0200
Message-ID: <20250709100341.1492456-2-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709100341.1492456-1-Wojciech.Dubowik@mt.com>
References: <20250709100341.1492456-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0200.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::11) To DU2PR03MB8123.eurprd03.prod.outlook.com
 (2603:10a6:10:2f2::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR03MB8123:EE_|GV1PR03MB10584:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c56be8-9710-46aa-ce12-08ddbecfedee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eaETaznVue6/MYJ52LAlJSkQUwCP9dJfEeAJ+enddsoA3efHYvFaSoHaxXJ5?=
 =?us-ascii?Q?fcmuaiRw1hoG9IhkwU3hNrnRnZikmxPGw1zFj27KB4vl4lf8VxfSvHpQnApd?=
 =?us-ascii?Q?skfLrCLdUHYOrL93BdlvlsgAbexRHsA8Vo0cw4QpdTdt0MaP9l93urnDg67v?=
 =?us-ascii?Q?5Px5Mla5Ac1PsmTcl5AIuApXCKShjkAAZu8cWUdRcSiz6rrAJqikFE3H/bqX?=
 =?us-ascii?Q?t7DMbrzk5U6cNe8e3XokWdjMjOUz+MnC+WKvUkbjHIGyLFANQqQZWV6kTCxx?=
 =?us-ascii?Q?tFb6c9bgkGJi5AJ9p1bM3M+NJjq1Z5XBAlr0pWkM9NgTDi44Ewff+XPBWQ2V?=
 =?us-ascii?Q?motytLZhUoxLBp7jbSkg9vjmz30HN9HgwKjKcIq6iS6XapdEwmqYjW1jEfGc?=
 =?us-ascii?Q?gxgwqlTOmVj8KASaHYNz0cCecygI1HjhCgyZ5gfSIG67I79lLte9hnhTDqIl?=
 =?us-ascii?Q?TFyS3xLRrsuBX4HXx15DYokynb1cKQA4y0unj48ASYu8II06GyPOhyGM8KAZ?=
 =?us-ascii?Q?HihNzNlo9V4ceFV7jRtWUW63O4/n9mkP4+9ibBBhUW4Ihon1PwzI6NTsCNOE?=
 =?us-ascii?Q?Ed86RL3E9ZqRiEKcO9t8T5XPuRYxW5F2xFkyB+hp2s8pJTwxJC+J06DXcj+p?=
 =?us-ascii?Q?vqRFXhtv0MCXn5eG/5rWMDMn9k+VnslZKuC+qkPTo6RXJwPe96FuBBxgXi1C?=
 =?us-ascii?Q?3YyQCiHWbkVF7BBC9Ery8GFslsgmYPzoXdpqF+3I+pkA9zDoTHd+Msjxp5p6?=
 =?us-ascii?Q?SjzXU6Tyx0JowKcEK3jNQbyZAiM1XSas8Ct7mNKF+y0s7jSzd6ktVXKIvpxN?=
 =?us-ascii?Q?/UNSUCmRFRdHAEAV/U+amXL1kR/P5IkBHxe1Zq/KxQ1r8c+Q2m/laQnxlY94?=
 =?us-ascii?Q?m82AYMAGseIwc8UanURA519aauis7+edUJKwcSQSFEQOsAaCaRv/jXLvKXwi?=
 =?us-ascii?Q?6+yfrGwHJqCxQFmtJDgPHjgLkMdEdN1ioJ6uCDH+iv52BJAoAq3aUNoXaMZV?=
 =?us-ascii?Q?vsE2wxIIJMyGR9tj7fccesrzuejt0Smg+tr2sbFrfKEK5V2zULiTGJ310tT+?=
 =?us-ascii?Q?d4jE09jv5YsfiFdIbnvAjGnvjAnjjtIzp0emxe/yLdUhxgOuUzLrZVCW4wJK?=
 =?us-ascii?Q?0rUQ2ITtt/ybHo3zNZiLD5hIMbiZB8AydyO2j27E8skYHnDxsdcS/1ZsuCgX?=
 =?us-ascii?Q?NeFXw8As0GDxUFLrYnwVi1tZ8qxyu0YauJOMQGsn3C7HY5d+oOx5KNzNlwUH?=
 =?us-ascii?Q?KpXqZVp/esTrHsWBvvsNR4m5+nzhckOpLRg9OsyUGc3AchdiOPfQxZVMEjhR?=
 =?us-ascii?Q?YwCZcJ+kjVOtI4RE/+xWewYM86CmTADx9eL+x11Z+BKOYlDRpIewvAlfM8UQ?=
 =?us-ascii?Q?ixVXGiuJxUFHk0l7IOG2MV4WT3wa5UclGd2q3WTHTpIFVm646mpLp9U9qB/n?=
 =?us-ascii?Q?6q24af0MjpT0ufARO7FrEtf603f37cWouTdEe+h/jqvcoQ0ufj4wjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR03MB8123.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2BqcZtu3QdJoT2iqb6Q1VEkHvtIJLC8koTqeasGtxW14hS/9hlPWBEgBgKt5?=
 =?us-ascii?Q?EPnMDICiY+dNChyVL9WKrB6RJI5pzgFWZxGGdGpeGGKF9dbEPaYfQD7UfSmL?=
 =?us-ascii?Q?HQKnxe2GXJFqZdXFMGIEuCrgj8zQ4eeC3vTp9J6ZOsbKnGcncIezcs6lJl/l?=
 =?us-ascii?Q?666Qru+3wbVUIVW8UyRVvFYB882aWk+u8t0lgetp7WGpP2Z+wPO0YB9osikQ?=
 =?us-ascii?Q?xk737J0K7rOsqhOjFqEhQedTP/pgUxOUqHKQDrrJ/xQlqaiLHq2OaXgdu1qu?=
 =?us-ascii?Q?h9yOMk4RlM7TVfYjc9K8+6xsBDB0f6JcV3z/M1oNmA1FNHOB7DWldgoT7O86?=
 =?us-ascii?Q?YAGjwtz0B6KdC1eki3F1/HIi3m+8OHPDdKVqZWRgiWPapjBhRErp8mYLLjDg?=
 =?us-ascii?Q?s1qFpODXcajpuCBaBajTMHDLwB0BipJnkbY3vFJ20RaiOgE45dGurqBvZKRz?=
 =?us-ascii?Q?Brsr63CAd5fB8z6IfmEDyYiUhq7kg31zt2MFIzv/TYcDe75ZX64zxl69v/WX?=
 =?us-ascii?Q?XPsLxh7hKDo4yQg0n3Hd7qvb6iReV1nZaW+q+uJTqvymQPkbc9U/oQROIwdW?=
 =?us-ascii?Q?624S7xZhhZMhLcrfi0ocwM5Hmj/97WXSnpvSJRFjoxfCcM5LuekYFmbqewGi?=
 =?us-ascii?Q?Mv+NncFyxXV+PVa8A4I17kx4fpEo4dEnwpOPPMSDWwmRftbFr8HF7q1nrwg6?=
 =?us-ascii?Q?GcPlJgncJJ3yVEhv/0efZpzVBqD9w6RBZldVrPFglID3M7zkfYZ1cX2VS9uQ?=
 =?us-ascii?Q?e3whUK3yzuWNG9EP+h5rkoGLWZ1SgOUNkQxzXhFv7oCCHEsZEc5bszkiNzWE?=
 =?us-ascii?Q?7Fj8vjciG1CrfgbC+i8ct9xY9MsbK9R/Xmof9wgS/nMJd9Uu2kbAFpG/tkyd?=
 =?us-ascii?Q?LRif9hhPi8HtoIUK1kXrYuk+iiiJzVzMSjNOH2NUiGHNjP70l0dIQOo12ZOc?=
 =?us-ascii?Q?cTgUTAgKCt4EKx54nntirknOguzNlinbjnqv6VMFYkBT07VgrDpgKSs4S0Zm?=
 =?us-ascii?Q?1bm4NHRHN7ie6SaE/uZm9cvFYu6+cYVLLZckDeW5yqPFOsNlA/i59g48ICrI?=
 =?us-ascii?Q?UhyCTXsC4TNpvZ2+bPLrKgE/ISEv0pK9VYPN7oxAfQTuUWlA6VkAHQqV9BHP?=
 =?us-ascii?Q?mtJY48Jy+73Q/VYkuk/3FNgjh/6bhonJVeklVSmI1IIxY/G01uK7zgtssotN?=
 =?us-ascii?Q?FlVAYCjtNLqtFMdDDZ/pLyGPBfoi3PGMpxC1NDIgbwT62wu4VWlAVsXLPH3E?=
 =?us-ascii?Q?2mJM+OgRcxy5shguyNIjxfwHd+UAfFdcQ6OoAHIYoO0KiF8AEMWLfBEZloa0?=
 =?us-ascii?Q?o/Lo0THv17ozYOngtiISpugwrbnCjjuU1UoMi6v3wrTHq11+f5weBph50RyZ?=
 =?us-ascii?Q?rZRJJYVnmcuWp0MnuMu5iSw9PcQ74qGIZckTR7ZgA3Qk0kZRzysdyayWi8d5?=
 =?us-ascii?Q?52mx4+qsFZJKXNroG1k02zLVfMf4YRM4s/1bqyewJ6YvAHgZDUo/3PVQ63XC?=
 =?us-ascii?Q?SjZSbVUTMk1nx47Qhn2UWz+xJ6mvcPbM2lwj3bB6Ak38ndntR19IUG2QqpRU?=
 =?us-ascii?Q?RBEmP/Yyqyy61wGDhygrnz6wrl+FX5sdwzBtPnYp?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c56be8-9710-46aa-ce12-08ddbecfedee
X-MS-Exchange-CrossTenant-AuthSource: DU2PR03MB8123.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 10:04:01.7173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D792COqMCJ388dbf9QF3fgoDlCDi7CTWLJSo2eWYoOKjpuzRWOMBPTmIfxUbasmFa+EX8qypGvzBGhVKh6PxAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10584

Add the "mt" vendor prefix for Mettler-Toledo.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..0534ae640348 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1018,6 +1018,8 @@ patternProperties:
     description: Micro-Star International Co. Ltd.
   "^mstar,.*":
     description: MStar Semiconductor, Inc. (acquired by MediaTek Inc.)
+  "^mt,.*":
+    description: Mettler-Toledo International Inc.
   "^mti,.*":
     description: Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
   "^multi-inno,.*":
-- 
2.47.2


