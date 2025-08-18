Return-Path: <linux-kernel+bounces-774484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6FB2B2E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F2C58529A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C3527A462;
	Mon, 18 Aug 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KMjmJNSS"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57F27991C;
	Mon, 18 Aug 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550135; cv=fail; b=ZdpEFsYLMMHpsREM5U3wMyvt0ML/0oYkoW+0ohkeoplzG0Eyc3pDQVcI0AAiARsPqGzjuH4wYfFgUvlJ0C7jzLFpCGZYMvv9tRu2L1Vqyl4tQBQFyWe71ynw5QEXfpdsHj7QfI0G/KM6G+3a4sMOcQT6VUitp2ZtTk8z3k5+Qgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550135; c=relaxed/simple;
	bh=OU51j4nS20MTeVvTRqJxuHliGh/KedmSQQBo7Ks2RY4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CjlmKfpACAjEW0AhfuieRuY0GxAg0sV+kpIEkFMeyEDNktCDT/0aqhmLMdWmxWrzE8XWKb+bFTARtKmg7RSkxDvk8clintnWGnQ5LtMXFgJwSaXU+7Jlp4NicQNIsSW7r/Y7od2gT1rIIZMZsSxrebg+/A3WgM6tT1WFwq4sD+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KMjmJNSS; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYzk342dYAxutMml2iVLXC4TlvmwOs5zzXi3lP5UbiSCf5munPImzvV6zZQ6p60If0Vl0anWSbBrEtOaavqHX+4hAVxjJ5BNFy4E0f+9oTRcqwXa64KqVGCc7FExyj430rU+94+IF06v4y5gFaThebW7RdGAHEUTziXLYdl+CpuWwiFuKsmiLoKbinrTOYKSqr0necYPTc7iZJIC4xF+p8vT7Gciap0KtD5ijHAWag8zaxjL4ptL7R9OCtN2h/7fXfzS28Ix0P6dOtBCb0cEqQe8Pu3WH5x6JBFl5iXlhI47eafGo0ppPmEHLYO52HpfUjK4KnOuoftslOfwwWN5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/nqc1rA7zyAjXlx8zVdZHwPWZXvZCTBXmT2M+i97ZE=;
 b=O9H/g9cpsUSKh+RG5xYc5Ey8CRq0RAKENfLMOpp3xBXVplwedP++L25p/Ka0Yo2oogAKKLbai5wbb6rLbyJ8Q72MiLN7P6Rd+6vDtDTtaP2AfHGvglQ1R1Dz/IEKQLGwe61yX5oy/n3fc7gfH/fyNnhIJoxBtizIGT6KTMvLSES5ok8gmSLREiU2FkwwoyzbI5Jh6i3mP+rJe5h91adrFr29vGZnYGYGdLbvj7nXj6rO6/CFCwhEPoU5E1IHi+lVKAYy/j2d6caKm8tLZA8NNo0/PVBYqpn2WEFyxFFF0FYENyUvAd3C65e8QFTY+wlpZlFn5gvXyI1fVD/KweytfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/nqc1rA7zyAjXlx8zVdZHwPWZXvZCTBXmT2M+i97ZE=;
 b=KMjmJNSSIcgQSPPre+Jt++/F9TGc88RXpCAWeeDHgqfdEWfDx6IQeDDLKZUZ7rqjD5eT9GMvHd0zzoHQCPFAvSfxSq1AV6PS7XIJpiBVdMSxaz/cI1UD0ilvOIZwSPIRIfQxRiK6fCo7s/QivxUT2Zqvof9BoEm5qJMsmktiY5jZsfv6PE5CGpxA/ZMFx9c4thYxdvNApNaygFx2p6AgaaXVu4nQRCEQz8kC20K5XzIDKwPfmeUY4pJ18OPs4VnIM5YyVGUCZqHTdceTqfEbQIe3eUzK71jBOG6RcxW7urQ5oQL+DWqwt/5uZ+xKjO2T3c8gltcaZ/iYEpHAmRR5GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9009.eurprd04.prod.outlook.com (2603:10a6:20b:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:22 -0400
Subject: [PATCH 11/15] ARM: dts: ls1021a: add fsl,ls1021a-wdt for watchdog
 node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-11-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=1094;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OU51j4nS20MTeVvTRqJxuHliGh/KedmSQQBo7Ks2RY4=;
 b=LJy7ibq/fhWbjii30DHoG4g6h8hNXlZh4BtrWnhIKByKbRvuEHmZfSTr8P4OhC9EsryDLlmdI
 fNcMLtutyRECU8wmEKHKMFYOKT+6P/wK53QlqxKRPZYz3l9rr2hMQsy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 6670b2b7-00c8-40f7-2018-08ddde98a1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFgwVmhEVHdBOGZ3UUxzRW1jbGRZV1lkbCsxamNodGR0ZUJ3RWRKei9Yd0Nz?=
 =?utf-8?B?Y01MU3VuSWhPeE50WlBzdGpmVjRqc0MzZXBqNzZWOW9jUXNnSVgyVGFlWTk3?=
 =?utf-8?B?UU1sMUdxU0pjbTZPQm5Xdm8vSjFmWjJ1VjhHRlpoaDBTRHJVRTBwREtvVzVL?=
 =?utf-8?B?Vlo3aTBjWGdacXhrcUYwK3Z6bmZiTG5Dc0FFZ1oyeW1WV1JQRDA3eG0vMlM5?=
 =?utf-8?B?R0YrbFRZSE5oazBjOGRUL3BOd1lrUXFPaUV0OUpBQ3JUUE5FRVEwQnp5MGdM?=
 =?utf-8?B?M3Flc0tkejBaWS9EdmZXU3ZmL21wU0RJL3dYYVFuUUgrNGZHNEorQ0xkYk10?=
 =?utf-8?B?N3ZuV0NXQk4xU1k2TG5PcGw3SmNkbzB6U0k2ZkZsT0lkZEJjbDF4WHhUWmtv?=
 =?utf-8?B?VDhOd2FyV2V4c1JRNUZXNFdUaDc3TWlRQmRwUFpTSnREZlNLMmx1MWlENDRa?=
 =?utf-8?B?c1IyQnBwRENxdWpMR2FyeHdmYjBBS3dmYkNtTzVJWXMvcDk4S3VuYjJpSW0v?=
 =?utf-8?B?Wm0vV0llZWF3SmhDMEJCTnVlVkJPRUJyR29ZUUNHYk5ueUxPYitQZER6Qk0z?=
 =?utf-8?B?bVdWSlVLNnBKbUFkaWo0RVI2eWNNeVZiVW8xd1E5aDA2NGNrM2tFeXZDdHNs?=
 =?utf-8?B?ZWRVY3BFS3ZRRGdsM1FLbG9qMEJkcE9XeHdhcDBtWWxhVUp2cVpVa3VScGdC?=
 =?utf-8?B?OUxhaUNrMmpDaDYyL2tsR3dzWFBJMTFrbUxjMGE3dDRGdXJqMmI3U1czd29C?=
 =?utf-8?B?OVJTL1FqQzdMOUFxdGZkWm5jS2x1MHlZWlBOWC9ob09tVmgvcVo5SzRQOVRT?=
 =?utf-8?B?U1NBTHZtVzNvMDJUd1ZFZmMwTXVDdWpPdG5KYkM0aUVDMkFLNGJCU1pEWkdW?=
 =?utf-8?B?cllGREcvU2N1a25yZU5LcTJJZVhPSThBNS9PQ3FSMHJxM3pnTXV2cFJjWUhl?=
 =?utf-8?B?UUhuODlmdjZNOHNZcDBjUE5wRzJ2Qm8xNnVBdlZHczE2Y3JpbGlyY1JlZDB0?=
 =?utf-8?B?cUFQZHR0TkxZWEZ5TXhIamhkaFFhc3BqR2hCSzJDUVJNcE9yQVArLzVTaXZO?=
 =?utf-8?B?RXlZWEZ0VWlOa1NTazZZYmViV0cwMThYRnlGTUtwcUJQMlJNLzZQTFl1T083?=
 =?utf-8?B?SWFsaGFxSkYxNHFuT1VxMGtzSlBEVkovUUx5Nkd0cks5MExyV3dyZDFmZGpw?=
 =?utf-8?B?cnZrMFB5Z1ZIMnU4OVp1VUVCSWl2bHNsVU1vdmJSdlUwMnR5ZVorWktEQ2xG?=
 =?utf-8?B?WHliR3I3eXZDNHJ5bG5qV2lNQlkyT1JqcTYrTUYzQ0sva1gvWkdvUFFlMXRm?=
 =?utf-8?B?WVdiQVVzQzhDcC9FQ2NBdm5XWWlZTnJ4V3dHYkljc28vOThXSDYweDgzVVov?=
 =?utf-8?B?M2pyelF6cEZuSjFpQThBenFRcFNaVFg3TWhSUEtxUlMwUDlXZERaWU5aYUs0?=
 =?utf-8?B?azB0azJMdTVWMlBwYXZHMERkOXhaMjZnR3d1MDRDeFpTeHZaNnJkV0QxZ1NM?=
 =?utf-8?B?TVFEWFIzQlVRK2kwOGZXY3Q4aVhaa0dwN1ZJNTdRVEhhZjNoOVYwYUNwd2Ry?=
 =?utf-8?B?OVBTM2pMZnRBSjlad3l2RnEza0x6cU5Ob2theGJkdnZNMzZ5U09vaE0rdGtz?=
 =?utf-8?B?bk5vTXFhV0pGampBTUdEUjRuS3VuNFdGSWIxaFIzSHY2d0p1bDQ4ZmtsUTYx?=
 =?utf-8?B?KzRSOHJOMkZCWGxhblVjU3AwTEJmWlIrMEVpNGcrZWZDMCs1TVZRb0ZESFZp?=
 =?utf-8?B?Y0xWenQvck1ERFh1eVFrU1cwUkRRcGNrSkVQekVqODhxZHg5Zm15YmMyRmpO?=
 =?utf-8?B?SnAyaE9Hcm10SWY4SUJGV2xoZjFWc25XcUFSbXgrQnBwUDRYdnNvdUhxdWxQ?=
 =?utf-8?B?RzJhZEs2c1QvanlHZ0VCOFZ2NklGWkVpZUJ3RUJPV05qNDh6R1M5SjJ3ekll?=
 =?utf-8?B?L1dNakdJOFFmeUw2QldWZEIxUEpvSDNFWStPY213Z0NPczNSazJ5b0dKN1No?=
 =?utf-8?B?Z2lnSEtsQWl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1JVN1FsYkFKNksxY3YxNW9paWkxZjdrWnl5eGU1LzJvOEErTlIxSDFYVXEy?=
 =?utf-8?B?WHRNd1Q0c1ZOaDQxelZYQmJrWkdhNG50MFAxT0NBUTMrZDIrNDhEL2JiejJS?=
 =?utf-8?B?Z1lLeUdPL3Q0bW9ib3ptdk5YdFVXYU1vU0FpbEJNMi9NNUlRcG1DaHRuR0pm?=
 =?utf-8?B?SUlDVjRaQ1NoY0xzL05CTFRCNnNkY1l5WGhjcHlzU3g2TllSVkl3WjVscjBH?=
 =?utf-8?B?aTZkS21ydHJ2aXpmWE9ST1JLRnBlMTVrWFo1N3JQZHVOcUN4VER1TWFrRmFm?=
 =?utf-8?B?YlM4N0V0ZFV5TVJCSU1ySlN6eGZ1VHlpWmFyRW9xT2hiZVlnSkNXaUR5MFcy?=
 =?utf-8?B?T2V6aTZKekgrOC9Ja1d4Z1U3YjdVdTZHcVVKbzFoMmkrYlFqazRhSkgyQVp6?=
 =?utf-8?B?WkZJY09YTWtTNExlZWtGbHprTy85Y2N0RGZTeHdOQzllckJSdkdkNTZYNlUy?=
 =?utf-8?B?cFNBUXdQVldBZkJDRWF1Qjk5NGlQVUZ0aGxNZy9qWDBQSGpZZkkvckVUUmp2?=
 =?utf-8?B?Q1Vjak5ETTJFTkJVUnVBVDBHMXdpTWxiaUlGdzIzdmFBMUhvSHRFb1J5Ujlq?=
 =?utf-8?B?dGNtOWJic1lvWmhBaytHVlM1VkRWbHBkRWhaOVF2b0ttdWkwSUxRM1dmWnlE?=
 =?utf-8?B?OSthcXRHU3N4RE9QZzl6eFRuVEl3RTV1eXRLdXQ3RFc5aVRKWWk0MVlIZ0FQ?=
 =?utf-8?B?ZnZ1RGJjQ1NYQXpVTDNnRm9EN01SUDl1S01WbFNwNnlhTE0rUXc3T29MbjZu?=
 =?utf-8?B?U0ZsTGczQ0d6U2VsL2tLVTB5L3BsOTE2UUg3bEZPcHRucVdvT1ozU2tVcU9w?=
 =?utf-8?B?a2lPWEJXWnp3WEVjemVObUQ5cE1Ca25mRGR5RWxPQ0t6VFZnekZzMFlzL2U4?=
 =?utf-8?B?N1hjVjlBMTZWbEJKVFJCekRuNjM0NzdGVWJQT2dvTFowRDYzOWNuZ3ZaWXg5?=
 =?utf-8?B?eUZxOG12U1Vnc25SWFpTUDVSNm81a0pBdkNsako0bHkzUHUwd2xuTDZPTHcz?=
 =?utf-8?B?TmlMVDdvSUZNaXVKS0dENWxMTC8ramJ3dkJiZ1RDcWtKZVpzWWVXb3FwUmU3?=
 =?utf-8?B?TVRHT285RnhpWnQzWU1mdGpGZmU4VGtkK1dFWVlHbTZ5bzhmTDVSNmhIU1B6?=
 =?utf-8?B?MGkyRFMvS1pmand4MXlEWlhtS3lQMnBlVjZ4VFIzZFMvaWpwY0sxanNtcVhP?=
 =?utf-8?B?c0RqTzk5MklNMkgwM3I0SzdQcVNNN3NmNE5BZXVkaDQ1amwzRWhHbFNCNTNC?=
 =?utf-8?B?eHJQTEhSLzRqQzNDNmp6RzdsV1djUFV5clozN0ZPSkRiYnliNVRNbkV5Q05Q?=
 =?utf-8?B?Ni9BTWtvaVJmMElOUGFYUXhkRVI3eW0rK2Q1d1ZIK0pldFpKNitiSitHYjhl?=
 =?utf-8?B?MDVsd05DckpVMDhGYzQvTnpDWU9EejN6NDBGMDdYb0tyRk5pVCs5bjNRaXFO?=
 =?utf-8?B?OEF0aGkrSHdSSzZJWFh1YytMZjdzanM2a3RuQlpiRmIreWtYZ3NjcC9JaWxw?=
 =?utf-8?B?YmFYSVNmVEZJOEt0aWozdUNmQnVsZDBQeG9oSFNTd1RDZVdRYWVWYjl6Y2FL?=
 =?utf-8?B?bng4Qlc0UkVxdmNLbGdKSm56ZFVkZWR5S2xwMG9UcCs3NXVobDBXSVgrNTFC?=
 =?utf-8?B?cklKTlE2KzNxQjR1SnB0Y2hicnEvRmNSLytYSWZ5NjY3MHNaYnRXSE5janQw?=
 =?utf-8?B?UTRtZllhckd6ZFhvRjd2UEl2S3hBMy92Zm5nNlVhK0lhb3pHR2NWOXhUTDN6?=
 =?utf-8?B?NVhxaE45OW5vMnlEYmw2ZStEMkZSNExHUFR1aEtJblpUNGlkYWFhRHVFNkZv?=
 =?utf-8?B?RGVpdE1qRlpYcEkxY0lpYVIydGlzN2ZmOUw2VWZVUnMxUm56WjVlcnpKbkZW?=
 =?utf-8?B?MFBMVEowenVWdGNRZ1VWUlltYmpnaEpCYkwxTjRwNkpJeE1XbldCd0RyRWht?=
 =?utf-8?B?cGtQaHAxS3N4Q1krWS9OVk55V1luM0NQU29VMTlsaExxcHY2aHNBUGFrNUVH?=
 =?utf-8?B?NVhhZ0VzcnB6QnQ1eDZSTjQyRGZOS2lncXprYlNJMWV5TmZWMCtQWFE0SUdI?=
 =?utf-8?B?NEJkcmVDbkp3MmcxRkxBUURyUGNRSkVxcDBpakRPK2RTbG14QkhSTEkrZHdB?=
 =?utf-8?Q?Hjxo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6670b2b7-00c8-40f7-2018-08ddde98a1cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:48.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOI22GZVDHN3cLSZBR3pz1Qsls31WJmxJGqjecp+JSAiprqLwbEd8hciusqDHcO0OAFCaxaVc/9Cb4TMkZ272A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9009

Add compatible string fsl,ls1021a-wdt for watchdog node and failback to
fsl,imx27-wdt. And remove undocument property clock-names.

Fix below CHECK_DTB warning:
arch/arm/boot/dts/nxp/ls/ls1021a-moxa-uc-8410a.dtb: watchdog@2ad0000 (fsl,imx21-wdt): big-endian: False schema does not allow True

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 444fa5e2d42cc8f0ad81efded818b4420683622b..20a9de74d5822904b7f9be56f1b25171cbe64aad 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -609,11 +609,10 @@ pwm7: pwm@2a40000 {
 		};
 
 		wdog0: watchdog@2ad0000 {
-			compatible = "fsl,imx21-wdt";
+			compatible = "fsl,ls1021a-wdt", "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
-			clock-names = "wdog-en";
 			big-endian;
 		};
 

-- 
2.34.1


