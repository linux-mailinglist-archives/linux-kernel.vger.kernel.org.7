Return-Path: <linux-kernel+bounces-899124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390CEC56D78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04693A8A44
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2D320A0B;
	Thu, 13 Nov 2025 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B4ay0LcB"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563BC2DAFD7;
	Thu, 13 Nov 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029641; cv=fail; b=KXMH6qbkt+/nTMXhyi54x8+mGMLxMqnH4iLXfsM3dPzbdyNI8ypx+PSWlfl3XWUP2+aOrd9A4QA3zVoC4+cdmmDt0Yl4RXYcH10xPGuyS8o7BO7mUBm8lN4rIeg2MU17IfdTC9v8NlrY0nx8YaxOCY4jjM9+OO5U2LQ6pjBT3yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029641; c=relaxed/simple;
	bh=Qp7QQaJYZcNCgvs271RoAeOjHvGwFUfmY7eN/aJBL2Q=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=iQ6e8xQopdIm44aqgmdg0gn9e4k+y2uwJ0g+pmq/lINFJzxWUBVUk7DY6yeMljV6X+Ymq+ffRcNm7nGKC9swhKAE3xXjgc5FW6+snApl8Ig+sA7GtSJRMYJkigX+lBRM5plsJP6PcsMGmm9ESeVK+7ASk+yNI91qqt2oEczvmr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B4ay0LcB; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkhsiI89QS5GpUs0miIOMFpUUWAcZGq2WEifVDbJSfLjcwqA/0jdVdXlLn+aWhZYrPTzQ5Z4oqvIKwCj6GKqjTBeFbWjoayG070OoQl026eJ59/gM65vCmnPSNnQZlrj8H7y+2GtohkP6GXVo5BwBYMiKJis/xuZL4hXw9ulJxbzHPwE0ipwnNK0DGzzMdSSEsInCKW7dd5diFdU557t+HQ3heE8+aU0KGHareyDOupamqVqSvNlvJDtFhF9g0gMDVc3N4qDXt26fMr40B3BDtmF5KJ83pBN0m6jlhubivJ/asFe9su/xLWGg75VhEki3nkVKygZ5qoPdQnIgR0plQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM4TN7O7MvB9MZso4G9Z8Gnw+oL6QkliXSeODqFmaTs=;
 b=t8QUQ0dJH1hQ8vNCnIOm4WZaCUPSwx58ZVBJXgvXDacgB398zYnk7Ij02kz3KgGDt4+hkSbzWPdMffFiPfMlJngS0bK5YvOhf/K/4/+s2TaIQpRmGAcDXbo5Kvad165v2qOlf3e3s6XB14mHqxr7BHolyuar4CUFwhiSQvsBDmo0/q80OOI2ks5f2nqudGeFeL1wDGdF5xe2zljYawOsP+fhI+QulG4iRMuCbIDVoT5HriafyLLV3MLOBeLncNl/FXfS7535hl5MLfr+t3/KXUK6KuleHDowMxDHlBkMOIo1v/2P9G8BKlNAx9Qt7FSminzNk03fqnN00LiZneuN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM4TN7O7MvB9MZso4G9Z8Gnw+oL6QkliXSeODqFmaTs=;
 b=B4ay0LcBeEqNmwqLJUirWfaYgLybsUkBJMMvHTd12ePRaFjlXi68BanzJstg5FiVQhqGvrHpNGWD2tRjpNZWJxcUHbdGKy+NN15SbXzxDJq6pfr6hDYKbiGMM5g7txI5dd7OlknDS5wkKoUMat9wp5WMcJm3lcBt0uysI+UmlHf9vTVkDfV5NY6TsLpXq7JP3+OmQu37P70X6WW5BmrwTRQMsM0EIRQRy5xKUqTjiiMTWTOi0xRpb7khKvTaYhX2N5p9iTsChDiae4C51HuWNc7RK6guu8Nb/za7gouZ97VWEk2K9Jd7SlwaxDdLSJ+xVUWNSxZN128t6UDZosN6Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:27:14 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 10:27:14 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Subject: [PATCH v8 0/5] Add MIPI CSI-2 support for i.MX8ULP
Date: Thu, 13 Nov 2025 18:27:30 +0800
Message-Id: <20251113-csi2_imx8ulp-v8-0-2ebe378f7111@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJKyFWkC/13RzW6EIBSG4VuZuC4GDv9dzX00TQMCI0lHjIzGd
 uK9FydtR12exfPmI9yr7Ifoc/V6uleDn2KOqSuHejlVTWu6i0fRlbsCDBwrolGTI3zE66zGzx5
 pZ6kSzgnrQlVIP/gQ50fu7b3cYUhXdGsHb7YRWENAa4KJpowjgi5j6uJYf7dpPKec627u6yZd1
 2Qb8y0NX4+BE6zh3wzAfssECCMQhjFGNdOCn/8q65KJbik/UFoo5UpxY40A2+wp21J1oKxQA0F
 LS7i1Wu0pf1KNyYHyQoXUgjnCJAl0T8WGEnmgYn0rNZRzrcCHsKfynxIM9EBlodw3tnxC46W2T
 7osyw+1PAEPEAIAAA==
X-Change-ID: 20250819-csi2_imx8ulp-9db386dd6bdf
To: Rui Miguel Silva <rmfrfs@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Martin Kepplinger <martink@posteo.de>, Purism Kernel Team <kernel@puri.sm>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763029686; l=3435;
 i=guoniu.zhou@nxp.com; s=20250815; h=from:subject:message-id;
 bh=Qp7QQaJYZcNCgvs271RoAeOjHvGwFUfmY7eN/aJBL2Q=;
 b=v0RaNwImI5jlJXRkyRHOyjH+1d88usW/QGoG4GJvWe3tvABEH3qkW2DsL9JbKrcvBQ3SgABz9
 0aAHpmpeoj0AG35cEd6aL7QOD5vPsikxhdVUMKfIkQwjWtdLPsHqztI
X-Developer-Key: i=guoniu.zhou@nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To AS8PR04MB9080.eurprd04.prod.outlook.com
 (2603:10a6:20b:447::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9080:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: fe14674b-27aa-4f49-4db1-08de229f35f5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MHZ3ais3ZDRkUmEvS1VRMEN2ZElPVkpTYytCL3RyeU9iY2NJWmhwaDZHU1Rx?=
 =?utf-8?B?VTFLY2pDY1F3Q01CTmVCVVlwYkNtTmVvUDdxZGhIMFZyN1A5UWJwWkdxaGVY?=
 =?utf-8?B?SkxoRVE2dWxtQU1iMmNoSkhHblVpNlA2YmVSMXZ2elhPNTJlaEE0Sk8xODQ3?=
 =?utf-8?B?TVFJQSszbE1xbGlrOFdteW80WHA0ajhHUXZxOU5TQVprU1JYNUVZWEg1Y2tt?=
 =?utf-8?B?OWZ4NTdwZ1ZpMHBPR2piVnp4elhTTTdzSEorbTFkV2RXNFd5eHBDYW1MM0ZU?=
 =?utf-8?B?Q3Z0WjJMQmtGVjlpdUFPOUJ5R3oxQVBsZWRwZUZMS0RrTmVHaTF5VzNUL2V1?=
 =?utf-8?B?WXcrYzZzZ3Rmanl1SkwyLzFpcnRoMDdTeGNOcHFFWlN3NWtvcmh3OUtTekQ4?=
 =?utf-8?B?ZWpZNzF2dUtjREUwKy9yVXVjMXF1V2VJaVU3M0RCa05nNlBsZzlsMXNTUlh4?=
 =?utf-8?B?ejlPdVNnRnBUU2tDcXU0NEViQ1pjV1dXRnlVejR1NWl3cTNiZW1aOVhBeSta?=
 =?utf-8?B?akpzSmhLSnhVRGhJSEpnT3JZcUZXQ1FDcWJISkNtRDR6RVZlbnpsNkQ5VGpR?=
 =?utf-8?B?Q1MyOGg0ZWxNTHVaRVQ1dldVc205dGV6dTNic3UybjBuTzJ3SnVUb3l4QnRK?=
 =?utf-8?B?Rkx0dmpxTlZNUThxQlgxa2h5Z21WS2V1cGdUVElXTDhhd1hteGpvc2NHMjRO?=
 =?utf-8?B?SGJmaDNtWkFIbDYxeWdXQUdENnkvMjBBRitoU25OTStzUitzUDF5ckk3R2Fr?=
 =?utf-8?B?TjFSazdhNU9VNUtGdzN6dVpWcHJTWEkvWi9mUHcrekR5SzVLMERsZFlXQjU4?=
 =?utf-8?B?Ykc4V2RkY21WdFFUTkRjNGFZVENJUXFIbHU1aDRKZFh6V244QVNKYVdVRXdY?=
 =?utf-8?B?ZGQ0VkFBanZoc0I3Tm1xNzEwMXpnNXVHWG5uQWMwaDJEdEQwUmwxTVovWkpa?=
 =?utf-8?B?SWFlbDdQclh5N0hQa0VkMDY0R2dXWTY4b0RFaE5OMWZESlZVdU14YUcrbWQ3?=
 =?utf-8?B?bmhyTGJ4Q2s0V0UrbGRiWXUxSm9sS1JNSkQ5bjc2N2lDTnNlc1BUNWRGUDQ4?=
 =?utf-8?B?aS9BK1FQcEJBUUkvYWZka3hZT2xaUUlVT2JjeDI5bm9LT25LQWNYMGI3ZE9B?=
 =?utf-8?B?L3lXbW1TUEdKa201blNENHdOVFRLNWhFcFNIT1NDRXh6Z3dPUkgybEcxVnNh?=
 =?utf-8?B?MCtBYSttQmxHWlVOT0lBL0JTajJQNUgyT1MyVG8rNThhRTYvSU1tQWp3dU5D?=
 =?utf-8?B?aXVodnkwY002UTJyblZEdVpRcWZzN2trcUIwK2dnSTZzdXVsd2YzZHpqS3Bu?=
 =?utf-8?B?eUw0TkdKY0xpMWd2Z2pJU0poQWRVT0d2cERjSk5SYXhKeklEVXphMCtvcVZy?=
 =?utf-8?B?cVhGZXVXWnhkYU1mR3dEaDZTWkFpMWR5d0F2cUk3aXQvMWZTK1BPUjdkNHVD?=
 =?utf-8?B?SXRIbEZ2QlNoWWxBdTloWS9HMkdGbk5uYUc3bERYT1FxRW1nQytnTGt6bjFC?=
 =?utf-8?B?dzUvbWxydjkzZFF2WFFCR0xJOTRrUCtDdE5ndEhjRHU1SllrZVUvVk80bFJq?=
 =?utf-8?B?YnBYMjhLK2xIaVdMSzF1RVZhODBOdURkWlV5S3VGNTdqUG5ocFpZYmFZNXVj?=
 =?utf-8?B?ZnNROElqdlR6MGEwcGdCdms4d2pYU1laUGU1aTJzb25Ya01keTZpdllVZDZF?=
 =?utf-8?B?aFpsdkVVZk10NjhCMTJ4TmoyenIzTzNvdis0K1FPUTltaGFaVmJsaHNJckll?=
 =?utf-8?B?cWl2OGRrUHF0L3R4dnY4ZVNaU3lIVWV0VHp0UjUxOW50WEtza2lwbUpCcG9l?=
 =?utf-8?B?WXVTVnFwZVA4N3MxdTJBUzd6eDNXV1o3QVIvWjlwbnNIOWRDR3pydE0wUU5Y?=
 =?utf-8?B?Qm9DbzRPUUtjSUhnNzZPNXdONHV5NXEvR0RTa2FvMUh3b2pGS2lxR3pCdHJ4?=
 =?utf-8?B?R3ZUNG8yZmVHdTl0M0tVV0YwaFNQZnpyTklaTTZLK3ZWbmp5L0hhRGlZd0VD?=
 =?utf-8?B?Yi9zTnY0Vm9EMkxOL013WHM5Q1Y0endCbWRreUprc1ZNamRJQUZHekxUZEVO?=
 =?utf-8?B?Y0tkZnVyUUh4VVpJQ1pYYjBkc1N5amwrQ1lwZz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Mmo5ejR0TE9nMGczTkVhUDRUaytKYlNGTlFabGFFTUM5aTZMSWZYNWhNMHNx?=
 =?utf-8?B?Q1pJMU1kem03RjZJZlhBZjJESlhQMG50U0NRYmtvWjRkZHJSbkxZQzEwcjZn?=
 =?utf-8?B?R3hIUXBTQUZSZXpWTHB1K01FVGUzNVNjZTFlcnEwMCtuajFoNjZPUGlyRXF4?=
 =?utf-8?B?RW1iUDNKOTNyUVF0RWZwWkVFZys1RzlnSlBVQ1A2UnBncDN6QXBnZnlMaGl2?=
 =?utf-8?B?NVpNRUg4bFRNTnlxdU42ZnJpQVRlZEc4Mk1yb3BNSjdXNmM2RTN0eSs1Y3dB?=
 =?utf-8?B?ajdYWklMb0tidUJwOUVmeFV1R3BFVkhQYVhRQWtwZ3FxeVkydW5OTW5ESk9H?=
 =?utf-8?B?aUpQVSt0QkZxTlN1OXlkTVgwOEMySlByNERlZ0lWdGhMSk1QWW9WQXZSdHJ1?=
 =?utf-8?B?cHdKZ2pLZjdZSWVzUXBIYVhaSnNGRXNSV0FIMTBRYjI0cGRrQXh3ZGtiMDRS?=
 =?utf-8?B?bmFGYWdBczhKbFh0V1lwWER2dkplUzMyd2YwUUdZV0lzd1IxTDV4dHlBbmMr?=
 =?utf-8?B?VXJET3I2TlRyQ0orVW5zcHkwYnE5ZER2UVZWajFiUEpiVjQwVWVGTTNSRnRB?=
 =?utf-8?B?NlVrc0xMNXJHYk9aVnJ3NTVmcjNoVGdOZkRzTnYycXQyOTNRWFg2NHFLWmZn?=
 =?utf-8?B?ei9mZFFKU0I2OG1FSExjRytZTjI1dXdqU0Z6dWhHa3luaTFCVFFtSStYcitZ?=
 =?utf-8?B?OW1jV1VNV0d3TXRVdXdoeXI4b3pRbzhTWmN1Z3MvQWtYZUxXU21JTEVlbzRp?=
 =?utf-8?B?S1NGeXVmUlVqMXovMm04M3FHcWlrRnE1NStQWUxJWi9JOXR1M3FiclRTNEJM?=
 =?utf-8?B?bHNLT3E3ZW1zbWlDaFIzcHpaU2xRUjgxT0hDZjl2UUxRMEw3UlZxakVuMmFN?=
 =?utf-8?B?akR2czg1UmJVUmpSRERuWFhaWHNWQm8zbXprQThQZU1ZMFRRZEhTOEUxdFF1?=
 =?utf-8?B?dFMydXh5S0d6V2dHdklVTGVOQktkL0tOc3Y5YUpTbzQzYXFhNXZQbHpnUlFY?=
 =?utf-8?B?SXNnMldoTjl4RHdnVTRIUDFjd3hLNmI3N012aGduRmJ3azNMWTMyNmc0QllW?=
 =?utf-8?B?SjVUNnVkeCtLNVp6aFNZRVZzWnBTc29LdlhFd0NYNGhsd3NPbzBLMXkvcC9W?=
 =?utf-8?B?Wk02NlZyWThoRVhwb1dvSUJUbkhqQ0VZaDc2c2UyM0hXM2hnbmJ3UTdRTzF1?=
 =?utf-8?B?NmJ4NStnSUE1MGxWNThuME4zcmlxVmU2ajdFZWh3Y0dBSFFKR2UwK3k3UDZt?=
 =?utf-8?B?dlMrTW1XNkZBQXovbFl4c3FoSlNBcmhQY1ArZEZianZRaUYyYVozOC9pYjBO?=
 =?utf-8?B?bmNXSG5UQXdKWjdFZTBtTEs3dU9EKzN2NjdxUVBjQTZlZjFkZjR6YnNad2Zz?=
 =?utf-8?B?RXBPZmhpOXhCTU9KYnVMMjd5OWxnbkZJZ0xHYkovc2F3dEo2YldpRnZycWw0?=
 =?utf-8?B?SzVISWNvSmE1ZWRNbEJhNC83NExPYk5RdUJWUzNQM3dGYWtzNEVuWWwyMGtt?=
 =?utf-8?B?QUxNMGFwR1lQNUZNQzhlMmpqM2NoL3BmRlk3Ny84VlNwWis2UTAwWVdUTUtk?=
 =?utf-8?B?ZEU0SmdMdHhkM1k1T0IrTFQyNDZYTE5RMGtWd2IvN1dVdXkvYmlIUCtpQXFJ?=
 =?utf-8?B?NSs2RVgrK2MvQWNNbFZ2YWhxODZncWlFRWVURWttRDVzS2tPQk9pMzl4YkVX?=
 =?utf-8?B?Uk9VVUFSSnU3TEJVQmZMcG9CNm9FZDFuWDhkOFlOL1QvQ3BlRllQME1UODJx?=
 =?utf-8?B?c0liOXcwTzhQTmRJS3pHbzJKRTQyaFVpSnhKVDJSUG9vdkt6UjVnZ3NyQmZQ?=
 =?utf-8?B?WGxOdmNOM1hBQnBObTd6YUV1SExmdDFhZFc4QkZjTFNlTm1TWnV0TFhIWUhD?=
 =?utf-8?B?MUVBcm1KRC9QTktHK2dGUmpoNnZRSmpNRVk4eXdodFBqNTVVNHdPb015Q243?=
 =?utf-8?B?RUxSN2J2cFBqRnNVN2VtcGlOVG9aZkFLamhtUE9jQzczbms4eE1XQ2JUMHFq?=
 =?utf-8?B?Q29tb080bnQ3cTc5T2FGSzdhWWU1a3FwOXhWZUNzeGo2YXZTZm1lR1B2cmJJ?=
 =?utf-8?B?eTdCeE41Nk14ZXBiOGNVMksxeVozS1ByN3V1Nk1UbjNZY2VlOElEV3lzYzBS?=
 =?utf-8?Q?gR15XExy8BDcMu0aN3DoaiPF/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe14674b-27aa-4f49-4db1-08de229f35f5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:27:13.9134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjWNitt6lvTnH6bFJGlj12CU2wgausbaQojr2NI//xlI9oRU0GJbaxGHSfn1ikWWnWKW6yXvL+467VEWC31ABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

The serial adds MIPI CSI-2 support for i.MX8ULP.

Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
---
Changes in v8:
- Rebased on latest media/next.
- Sort the conditional blocks by alphabetical order of the compatible strings
- Get esc_clk when probe and cache it in csi_state structure to avoid looking
  it up multiple times at runtime.
- Make state->num_clks unsigned.
- Return error when failed to get esc_clk.
- Link to v7: https://lore.kernel.org/r/20251023-csi2_imx8ulp-v7-0-5ecb081ce79b@nxp.com

Changes in v7:
- No functional changes, only move patch 2 after patch 4 to avoid dependency issues.
- Rebased on latest media/next
- Link to v6: https://lore.kernel.org/r/20250917-csi2_imx8ulp-v6-0-23a355982eff@nxp.com

Changes in v6:
- s/existed/existing/ in patch 1 commit log.
- Delete the compatible between 8ulp and 8qxp since 8ulp need one more clock.
- Update compatible string in dts for csi node.
- Add one new patch to handle 8ulp in driver.
    media: imx8mq-mipi-csi2: Add support for i.MX8ULP
- Link to v5: https://lore.kernel.org/r/20250901-csi2_imx8ulp-v5-0-67964d1471f3@nxp.com

Changes in v5:
- Delete else: block and move clock constrains to each case.
- List exact cases, but put imx8qxp/qm in one if:then: block to avoid
  repetitive code since they are same.
- Link to v4: https://lore.kernel.org/all/20250828-csi2_imx8ulp-v4-0-a2f97b15bb98@nxp.com

Changes in v4:
- Change csr clock name to pclk which is more readability.
- Add restriction to i.MX8ULP and the other variants remain the same as previous versions.
- Update commit log in patch 1 to describe why add new compatible string for i.MX8ULP.
- Link to v3: https://lore.kernel.org/all/20250825-csi2_imx8ulp-v3-0-35885aba62bc@nxp.com

Changes in v3:
- Correct the order of "fsl,imx8qm-mipi-csi2","fsl,imx8qm-mipi-csi2".
- Correct the order of minItems and maxItems.
- Restict all variants.
- Change pclk clock name to csr to match IP port name.
- Align description about csr clock with IP datasheet.
- Add reasons for adding a fourth clock(csr) in patch 1 commit log.
- Link to v2: https://lore.kernel.org/all/20250822-csi2_imx8ulp-v2-0-26a444394965@nxp.com

Changes in v2:
- Add more description about pclk clock.
- Change minItems/maxItems to 2 for resets property.
- Better to handle "fsl,imx8ulp-mipi-csi2" variant.
- Move comment to the top of reset_control_deassert().
- Move dts patch as the last one.
- Add "fsl,imx8qxp-mipi-csi2" to compatible string list of csi node.
- Remove patch 5 in v1.
- Link to v1: https://lore.kernel.org/all/20250812081923.1019345-1-guoniu.zhou@oss.nxp.com

---
Guoniu Zhou (5):
      media: dt-bindings: nxp,imx8mq-mipi-csi2: Add i.MX8ULP compatible string
      media: imx8mq-mipi-csi2: Use devm_clk_bulk_get_all() to fetch clocks
      media: imx8mq-mipi-csi2: Explicitly release reset
      media: imx8mq-mipi-csi2: Add support for i.MX8ULP
      arm64: dts: imx8ulp: Add CSI and ISI Nodes

 .../bindings/media/nxp,imx8mq-mipi-csi2.yaml       | 49 ++++++++++++++--
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         | 67 ++++++++++++++++++++++
 drivers/media/platform/nxp/imx8mq-mipi-csi2.c      | 66 ++++++++-------------
 3 files changed, 133 insertions(+), 49 deletions(-)
---
base-commit: b4fbb13db86adb0bae1d7f968b61ea8dc9635e33
change-id: 20250819-csi2_imx8ulp-9db386dd6bdf

Best regards,
-- 
Guoniu Zhou <guoniu.zhou@nxp.com>


