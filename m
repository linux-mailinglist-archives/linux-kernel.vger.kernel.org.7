Return-Path: <linux-kernel+bounces-833233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC34BA17B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A001881B10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ADA322547;
	Thu, 25 Sep 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q6lcDghV"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942B31D733;
	Thu, 25 Sep 2025 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834862; cv=fail; b=BR2pIn8S9i6gJGb6zgjyBi/xIDUXi4DTNVSV4gBfjiCCfmekalG7PO9GUKC9TIlS9jMFqS8LHsBgpgIeh+yVqxEzFi/8HcVo326o9RXlzfXuqlmQNaInpA4fGj6ZIJKeleHN0zC7NyeLmXiimvEFwBZ/6GYHQbvQgvFdq+mciHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834862; c=relaxed/simple;
	bh=lku6LEUNLaDEbJgtYd21vyazgkoJ0tgikQxZ7UlDai8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JZ/40sVgb+B0BxZoGjEdFnsJXQ2bysbdqJ3N4Q10fu1WuKjYIvWiyLWJJWq3W1H+5fpxvcXAEVQ9ChL6Yj2BR9ByS4HWZ2hF9oJB8jXNbwxqXUVYFQEUg1fOKKVgiWIZJx+rGmzI/CP9pH2HuI/GijPoErDJ7k3Z7uDWezTzToE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q6lcDghV; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzbCwPDNreKjhj1kof8bUINu9rfzfEISpZxiGuOA2SraNJf6ftYgxKJcvpj92q7r/asMXoUsnw0bNjaBjyZ5nzBD4vxQ138qrfis7as1X5qJdsNH6J14HDArQsI0OwrYIwZ224TaFM7134uB6wHRHYROrXn1d9DVG2X8vMRiVB4m2KMQmghhy59FrtCv2jpAvlCNjajDmYmB8esUahG9dUrmLkYqWOxmrDbuhHbo1D3Xk+jlGwyk4/HRaAWZuo6JwZOCDuwLmUnKRC+I2CKrQgGkZfQolaSu8e1l3Z4h0yueOW/XtYxK2vF1eQfB1yk1eXBTe7CYZL6bLl7cpVQkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/NMBWR17GAx508bwsDdoerARHmBPnidaxou5gkzLnU=;
 b=EBe0+JCBqxyBpWSbKEWi3WiQO3gsQXUjWlxbgVxMuvVL00xym/d8CMqRVLX0d7x69XWbUb7q3M6taVDb84YIoBdIAkmc1TQ0xQ9SHeIT0wKNsDeZgmV7gIO+qBpqe7oKmLs+YZuU+03m86FcXHUUKUn49KwoWoVFUpLf+oHd4TkjIT0HzEaedxVcaKVlwv077GCy5maSrl1jyFcB4/BfpIfHcTg9X/jz2EIBWNJaMeVWaQH9pwep6kgg6DdFl1RjGFhmM9FAMOJtZ6n3hns2DUnGerhq3Im3fYhet/UzneYkbvomKYINIrsqFFWjT2l4sbpeKT27wfzU2HEarfCO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/NMBWR17GAx508bwsDdoerARHmBPnidaxou5gkzLnU=;
 b=Q6lcDghVDjqug+OXlKmn0JO0UNMMrUBmJGEVJ5FjK2uhf1AkeKFpeEiNDMVL9b2WYN9YCb98PCvqEdz71FMQ5H6VBaUCNZDGh/b0kldCsbL+/4FitdzkDDOk/H3VZBxx4Lrh3ocVrkR26xFlq/ik1u8bJcSV+3QqYpv5AuWTHjgQKrCqzwI8HBnMI7i+dXFWWm8um4yR+FU1ytLMvXHc0nSsXbMJYN0Ze4wWaM7vdR5RpVq14evDxEzPS3Pq7IcoexvLU2WFmpWzlfz+VOiW9Zi1W6l/Lbnuir3gW3DQtVskev+o00avO/68Oi9N701aND8gW6+XvdyKUpEj96cHLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:16 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 17:13:48 -0400
Subject: [PATCH 04/11] ARM: dts: imx6qdl-ts4900: rename ngpio to ngpios
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-imx6_dts_cleanup-v1-4-748380dd0d22@nxp.com>
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
In-Reply-To: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=943;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lku6LEUNLaDEbJgtYd21vyazgkoJ0tgikQxZ7UlDai8=;
 b=HE2NgWwRy0WiOdpptGN167GzY6SMLVXXS/6xbDqEGUIpHtn3KfSrUcLJwuxYQDtTdqOQRWhN+
 ZaCkyO/0sFDBEapN328m1rJW9MPPOK3ZxYA9jYPd7xwbaHwAaoN+/0U
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: b919b276-7a80-4cdf-1137-08ddfc787c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0c3WGFrUmRQYU5nRWJJb0NyUFlZRXFPRVBXdFZoTC9sUnp3WHM3VXp6aDlK?=
 =?utf-8?B?ZEVLTjdxdzV3eGhVa09GMERadHZZRkxoTTh1MkpleGw5bWdIMzBWa2tLbkxp?=
 =?utf-8?B?VGNNZFhHamNvdWtqOVBKcktBdzZXd0JvUGdpZyttci9xSWVmTDN5NWRxbmxa?=
 =?utf-8?B?WkNEdzhGTzhPTStNTi9uSVFkeUgvSlR1WW1kdmFaNzV3bkwzYVEwdCtHM2sr?=
 =?utf-8?B?TXR0MEhHdmlsak92MDUxZzhPTHgwa0pSQmVGSVVJSkRIbXlaaFJmK2h3czVm?=
 =?utf-8?B?VVMrTDNSUHIzRHFJd29qVHJURDJPckpQVTZETU5lejhTcWtMOWN6NHJ3K2dJ?=
 =?utf-8?B?SkVSWXczTkY0dG54Qjh5STNxTkxBWVp4c1JSek9wNExDNEdUOG5CMnAySUhw?=
 =?utf-8?B?UCsvaXh2THY3ZWVvcmY4NWMxN09qT2RIdDlUOWtWcVdtcnduRG54Q3VLLyta?=
 =?utf-8?B?eVc3ZFZnazNBV2hhYXRzRmkxTFE4M2w1RCtYMUY4VW52ZU9ZOWUvMEF1S0RB?=
 =?utf-8?B?WGxzUTliZjE4eGQwOUtabnJDd2s5ZUpJZFFBbzV1S2NQK0FHSGd2T2sxQk9j?=
 =?utf-8?B?SlQxUkIwVFNoOHlqc1h4UmhLb0xKcm1KUDA0RjdwTkY3bXh1MHZ2OGVMZjU0?=
 =?utf-8?B?SDY3aWdxd0ZONHRzWXBFOEdLU1NQMjE2TStadldLSTNMN2RuM2ZaNnJ1akwx?=
 =?utf-8?B?OTRPaGtCT1EzMkpFSG5EWHF5TzZMdktWeTczL0tJSWczZzJPL1FvRXZCbDN5?=
 =?utf-8?B?ekRDVE5XeUg0NU1RWHR0cURqMjIxWllyMkljbnYyRTlPankzNnd4ck9laDdl?=
 =?utf-8?B?K2d3UDFLOE5FYlFDanJXUllHZDl0YVlyUnBFQ0hqUHA2SjZWMTRHa3htREhh?=
 =?utf-8?B?dERiNWtRMUlUbkNLamN6YjVaMWUwOHZ6eXdnT04wbjludW5uZHBGK1VjVDVp?=
 =?utf-8?B?Q2tJZ0Y2TWYrU2Nqc001Vk9yNGowK3BJUmlVRzczaGRSL1BDenNoNERUNzhU?=
 =?utf-8?B?M1BBMEhMS0hwMS9PVDlMbnpNTXpxUGU3VytIdEYybFZuNmxDZVpVVTFBbmJs?=
 =?utf-8?B?Y0FXZkpSRlhmc0J3MDFIaGdlOWVLTTZLcDdmZGF3VDBjdGkyeERVc0JybFZx?=
 =?utf-8?B?SGtHQUtRdEx6TWRJUXROSHlNbGExS3JiWnZETkFtV3BsV01ycU85N2lYRURn?=
 =?utf-8?B?amo5dGtrbFF4WU56Ym96SFJ0czhQVExhRHNXSnhSaFNuRTI1My84MmtzUlYr?=
 =?utf-8?B?aE5zeHJ5Y2lvTUEyR1JMTDhKaFdBY3hwSWdtR2lHWnpweTlpL1U2eVQxRmk1?=
 =?utf-8?B?UU9adnNoakVLaXY1ZU9QK0hQcmN4b3MvWXF3cW83WDZlMjVTNytZdWkwamY1?=
 =?utf-8?B?U3lmWjVXOC9RZGpZb2JJb3M2RHpOZ2xDTmdaejBOMHFiWFNRL2F2d2xjSGRy?=
 =?utf-8?B?cVlRL25KOGdvVGdhUG1vSVhtdEpSUzVveFRZVFcvc2lTNlp0NlpvT1dyNzBk?=
 =?utf-8?B?eDA0Q1JQQTFQbFVYM1JkdjFHUWVZUzVDK1lHMUkxcktIQ1NzVWVXdURuQjhB?=
 =?utf-8?B?VEVnYmN5UiswekNjVWp4L2x6SWhzTG1Tb0hrR2VTZXlPTHhFK2NzR0NYSUlN?=
 =?utf-8?B?cEkvODJXaUoyQnZhc2pNWXY2MExoZTd4aWsxOVRvOFVUQ0FVR3FIR0JKZ2Zw?=
 =?utf-8?B?NmV5dUxXc0t5ZFRyY2dDR1RJbW04R2FSTDNQeXdOMXFFaTZvclFkWUNHdngw?=
 =?utf-8?B?WXFlajhnSzdLUUlIRW1WdUQ0VjFoS3I2T0FYT3F2TEdNdTFLVWJaTEZ0TnQ3?=
 =?utf-8?B?cHZCRG5kT2IzakVVRWNBL3lJWnZzWXlkeFd5T0hEM0xQNXBvaG40bjBEeGlh?=
 =?utf-8?B?Q3B4bDMwWDRSOGdIUXhaTUdiSEppbi9YZ2p1cHhUbW9vQUYvNjFsZk5RVzJM?=
 =?utf-8?Q?J5hqT6T72Rg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmR6NFpwc0tUMmttdHY5U1U5dk1sbktYSjhPNVo2bkNsQ1hJV1hhNEVLdXVr?=
 =?utf-8?B?UHJpYnRDQnFPUVJsNUE5dmFRejkyK0twS0pGRWRFaWg3RkZHbzY5aHZCa3Jj?=
 =?utf-8?B?S0ZHMkdJRGxHL2hXdXc4a0swUmVQeUNBbHNTWi80V0RLY0puSlg1WGxqTU04?=
 =?utf-8?B?SGpaYlUxRlppTUJ5QW9DRHBTb0gzcVhsamtNdGFCMmtDT3pCYVhBOERmWHUv?=
 =?utf-8?B?YlVHUnpKSVMveEtDaDJ5dTAxbWViS1hxd2owWVgrdFNjVk9NL28vK2hwMlNS?=
 =?utf-8?B?aVZwcFBiT1dOWU1UNys3ODJhZFZXc2dpTXhTRXVsc3VtSXJZVGZ0anhLeTZZ?=
 =?utf-8?B?RDdBamwwNmM3TmFKa1F3QlRyblF2RHpFRjJHRWdScndYczRMQ2NKK0w4NzBD?=
 =?utf-8?B?WEc4WDREd0Z4R1gyVDhPTmFXZ3BUZTczZzF6T25hTVJ1M1NqbkxuNFg3M29P?=
 =?utf-8?B?azdLT0ZXeWwxNSs4ODZZYThyRjc5S2dEbElueHVqdlZZMVNUM3J1WFpINE1H?=
 =?utf-8?B?aUVtN254bXhQaXp2bDd6N3BkN0k1VXI3bmpHZy9ZUysycEsrRWp4cnpydkRT?=
 =?utf-8?B?N1hIWGI5Z1BKRDgyTmgvUmZHWkpKYmxQU29iVkdPeU9UUitBZkpyc2VpcGpZ?=
 =?utf-8?B?YmRvY0paV1NPem0rcnV0eXQ0YXBCR1A3VmJOeGZEdXp2YVBpYUlrOGVWeTBV?=
 =?utf-8?B?L3h6dzFCbW5rbm9xZkFxRU9zVGREZldMQUJjZk5iU05iRndydWpkZTJKM25V?=
 =?utf-8?B?L1VoU3Y5RDFvbk1wRzkyWmtnVkNtMjh6NWtDZlU1TVRldE1VVlJQQ1V1NUVS?=
 =?utf-8?B?dUpjYm1nNVloSm9wbXljblgwaVZJOVdhdXdTTGxSbkhsVWhjSVlyUGhwWWh5?=
 =?utf-8?B?WGY1eDBQc0RuTGRsNnNPOG1VeklyREJjU3VnTUFsSitMQkhGQ1JkcE5lbGpU?=
 =?utf-8?B?R3Zvem9vK2Rxc2t0Wm9JVHliVU9aRjg2WDNzMVYwajdmQTAxQnZUeGtYTjFM?=
 =?utf-8?B?bWNtRWJYNnRxSGhXRlE4dEVPZWl0L3p5akFybzRmSjlMRUU0SjU4SzluakI4?=
 =?utf-8?B?Yjl1VGY2RDk4UVNLUHpUZnNnMDhHTnJabENxNFBIbHBaRUVZMm85Q1daVlkv?=
 =?utf-8?B?Y0xySzRHdVZkTnIyblkweE1USEh4dzVSZkF1OUNvTm5MM0lVOEVqak1saTNB?=
 =?utf-8?B?czV6RTd5S1p5TUhwZWxIZHptRHlVNzV1bWlLV1ZEYUVScFgwVHdPamhPdjRE?=
 =?utf-8?B?dFVZbGt5Vys1TUhCN1cwYkZ2VjJFb3J3VGZuMU1TVTNGUC9wK0ZiZ2NTdXpH?=
 =?utf-8?B?MkVnUXNENUZ2YVFETVZXYWJsVytzdlZSZExuMHlhdlgxak5ENldSU2NZUkNE?=
 =?utf-8?B?MDJYaVgrZmVKR1hQR2RoeFdSa1htVlJta0U5SFhMWCtJMUxjdGR2TjRrUG0x?=
 =?utf-8?B?Q25EaW8rbExGbWRSQUtjWURRNTFLM1lOYk03RFVFcWZpc3h5OWNpbUg3cWdk?=
 =?utf-8?B?aEpaLzNjODcxbWF3bDJuN2oxOXc1Nkc3ZllJamwxUUxPV0pUR09raENVVzJX?=
 =?utf-8?B?MFBIUGdFSHMrODV1d2JYWHA0dXQ1UUxTNmwyQ1BzK2xmUnlwbTRoU2dmUGFK?=
 =?utf-8?B?eGJHY3lYNGFUeUs3emxHNEpYM2FYdExBZTVjTlNFRUx3OVhsNm1LNENLa0hl?=
 =?utf-8?B?Q2JuYjZwNHpJcHg5Nk1VSnIxNWdqWlJzWjBhcHJSa3QrM241YTlSRmtGUnBv?=
 =?utf-8?B?YVYreE9rNk9UUEVWSVpxcVFwYU1WL0cvUXhzUTBlaGZWdC9BekpiVDlOd2J2?=
 =?utf-8?B?YXRNRmVqTzRGREYyQjBxM01FSnVnYzJyZnNZTWFFSVQydjlILzZmMnZBdjdP?=
 =?utf-8?B?QmR0UERRa2JRMUhEYkpTUjBDOFlHVFFGY2k4MGJONUlEQ1Y5dFUzNDlRWDZS?=
 =?utf-8?B?YnJnNERrdlhvd2N1dy84ck5tUlI2Z0c3TGM1MkFiUzkzcTVPNnI0QVoxcUdn?=
 =?utf-8?B?TmZSeTlJdk82M0oyWm9OVDhkU004bzRoc0tIdGVtenBrakxpbFFwMG1Qd2N3?=
 =?utf-8?B?S0VSeTNlYlBKZlovTm5Fa0NxUjhmc0hVUDBscFE2L0NaMW42c0pEOGowbG9Q?=
 =?utf-8?Q?eY62MZRL7CAv5CGGl1hlx9+B1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b919b276-7a80-4cdf-1137-08ddfc787c18
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:16.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1rplv/uqxXpDmlwFLIRzWCj/23h97G7Q3VZmWAYHf/EzccM0b8YWooXT4plMJLiGCyYBbTjGYYHNho1Vkci4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

Rename ngpio to ngpios to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6dl-ts4900.dtb: gpio@28 (technologic,ts4900-gpio): 'ngpio' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/trivial-gpio.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi
index f88da757edda5a172d82745d5b5c1abb935b7d79..948b612496a5b70d832c1ce13f2504b36d9da46b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi
@@ -140,7 +140,7 @@ gpio8: gpio@28 {
 		reg = <0x28>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		ngpio = <32>;
+		ngpios = <32>;
 	};
 };
 

-- 
2.34.1


