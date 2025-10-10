Return-Path: <linux-kernel+bounces-848145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79961BCCACD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F50189D875
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EFC2EE612;
	Fri, 10 Oct 2025 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RtlNnldi"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013047.outbound.protection.outlook.com [40.107.162.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C22F0676;
	Fri, 10 Oct 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094083; cv=fail; b=QY9plBhIn8c1aXIFgEWrVQfNfihuxGKbQzZ61UQlmlRYs7uSo6r7E6Yfj3sCmHi5LCpsRsTiZIE2ZepDYTNcWI/6ud4+9aqpiT5r6qW+6Vkrlyj2PJ2JycGjGiwAErjK0pi9i1vXtUAcYG3B8qW8U2sR8oUfYbghuZNn2NeyPcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094083; c=relaxed/simple;
	bh=ymzXP8gRWPELWNKZf+WX3KBEGMEasYyeiyl1VwhZ7Yw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mf9n88msKVXboJh9MdTd5eafZQ2bZu0ZKlsA2Qe6jli4GL3LYWLvExbSW1fDqel65daICyN5CjELaQG8igCSX5JNCuY5yuAvLlbOaybnoRH43tSZYFViJ/etBCN2CTLLBU6op92lOlfVVTti19BKup3uWMY4GoxEm0d+fFodeiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RtlNnldi; arc=fail smtp.client-ip=40.107.162.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1MePdbCDdaMSn7J7ND3E2UcHmVIAF+UUhmRADotlFO0VdUlCr0cHbyHu+/tZj5dOq1hgu32N8iqbWyQBa3YkKFok4WAXz58m86OhEH7PWe4+4L4YkjCeScbm04CQVNoOp2XXxwOo3rVhpyQctlXihKxm48AfS1cQiCTDTmlphywS+90YExiY5zPNRDTeoED7FiyP90TcNhMg/wGheMQ+JCTYItD3D+wqSWRz1sZ3V5vWJA5fx5t6xR6mBGTzpysvpI44DDH7XOZ/fc55aPbWUc0W137DCSx7+1FQT/VaPnt161DwhJhD1O8l2F9Tur35DKxD6IwC46UWsxJ1AY7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE7Y7rlxbWLLEhTO7JFiq4UtgflLdwBu1hOkpg3If4c=;
 b=ph+GGpAO7rCxzCTQ+14/OqCE56RrDO0R7mM6K+YcMm4vc/gc+SQayEIijf53pHfZMoevcY93HDWUgrbG7nbcHemxf+5qavlADojmrH4fkglLpzg/ZDGIQZJWEBiOhX6H8Q1ymJTJDdjcSlobUvH29SuLebgV7lPGsQTzePe85CS+S+uiwqDQGHzRr/tNM9rciDkfE9S6nHLrt1KUwQg/WoUXLtjYdtNCDmQ7lAxRNoefPhoWtP0uUy97IHISaVWbhVaXXaCT1FxvWahGyhSxcFnP5feBW1/1BJsDKw2v7qcEKtCSt6aU4NLZ8sjkmBltD5N+k84wwkMxsFVTCn8daA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE7Y7rlxbWLLEhTO7JFiq4UtgflLdwBu1hOkpg3If4c=;
 b=RtlNnldixLLinbQ1W4B7ph2oWl58osPzj2r5MFmgCzfe6DIL8IzRe2NnSpVVNOY5Jggihwox5iPICS22cbQRH5/k9Gw/9MaeNhIn/s22Eqf1uY5q5tBcEv1b+Ut4aUxXR6Qbv7nuDhnbIRayhVIARCNasK78oLXaj1IBfl+8eaeLBo7lz7tEuqMGTmKqSX7UtGJaf6Xb9y/qHNzc6gFl0a+kzV1NjYXKmYLyL5+D1U6zIdyWbgIp0qovTFh/Fe/Ki3M5v/fKL8mxATbRVIqO/SGMn/speQrFu9QSU9KGwFHDPRq5CbRi5thaB99Xw74QM4Sr4vL0TWpAZ2xlqqAc5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:01:19 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:01:19 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 10 Oct 2025 19:01:13 +0800
Subject: [PATCH v2 4/4] clk: imx95-blk-ctl: Add one clock mux for HSIO
 block
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-usb-phy-alt-clk-support-v2-4-af4b78bb4ae8@nxp.com>
References: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
In-Reply-To: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760094078; l=2145;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=ymzXP8gRWPELWNKZf+WX3KBEGMEasYyeiyl1VwhZ7Yw=;
 b=Nk5OnJmGfObLRxRYGNwBghJJlzEwN0csQo6kptmGUkpuG15JDkYBIFgI4eyUWGp2/qY9YZt8X
 7Aq2jO1RxKqCJe3Hpz/RuC54QBI9hNfxIg+O2/BpBr8K6yLMF/7Fekd
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de58d77-dee7-4c2a-d838-08de07ec5721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekhSdDZ6L1NsbkxVd1dnWUhXVXRuVzdudks1bTZQdm9sWHVrK2M1NlRRRXZZ?=
 =?utf-8?B?ZnF1SWhZbTg4T2h2OUNheGhNQTgwNjFsQ0xaZEN2ci9oWnBsVWdBSTYzV0cv?=
 =?utf-8?B?aHZsUEQrUkF3R1JyQnZON1h6SU5YUGhQTnN0UjhZeWE1bGpWZ0lLVTN3dlMv?=
 =?utf-8?B?cjdtaXFSRkFGYS9DSS92WTVJSFlvNE9hNHVOM0lEK29oK3BZb3d5UHBHRlZS?=
 =?utf-8?B?L0VjSWN1d0ZmNnRWaTBURHFzVDYvNHloUGVlN3V5V3ZqT2xGTWs1R0tsZkk3?=
 =?utf-8?B?RjlmaXM3S3NaNEZ0dkphRjV4aXBuRVlrSUtKM2pPbm9jeXlZMDdBWG9kcWRO?=
 =?utf-8?B?UU0zdXhERkZSQmZ1ZjhYNWxRUUxWTHRKTUxucHY2VDdRc2dWUTQ4azZlWWR2?=
 =?utf-8?B?Vlo1dVQzV2NOZmI5bGZvbTRxMWhmQjRjdVJZSHN4SStHdkQrWW91SFdab3ZG?=
 =?utf-8?B?djhZV0FMR3g5YU52T2EyVHBadWpoSGtTcTZuRUVxZDRSNTgzNGIySUZFbVVk?=
 =?utf-8?B?elAycVlyaWxPZTFIQkRjNHJMbDFuYm1KZEkzc3YxdklCS2N0Rk1VaWtic0dV?=
 =?utf-8?B?OXQ2V2l1Z2kreW1VWjJwK3o0aW1UZXRkYjQ2MHRqdXNzZjhqNHVZUFhSZnNj?=
 =?utf-8?B?Z0lxSGFVamltSGpEdlV0VDNvUmI5blNRSnZUZ3psVWdBY3d2QzBIWVFMZHE5?=
 =?utf-8?B?S21uZDF6QTRoT3QvaFYyaksxM2VGVFJpMk1QeklEaGF2bVJjWmJ3NEh4WkxE?=
 =?utf-8?B?VEJwdjdBZXVPN2RzSE1rREovWFNjOGE1OUM5NkFzR3ZaVlcwUTA2THJTYy9E?=
 =?utf-8?B?Y1ZmRXh3VDExUVdEa1pFa1k3RE1DcmdzUnlQWVBpSmo1NDRBNkFwZGVnalJL?=
 =?utf-8?B?cTUzbnpWdTlzeUZWVGxYQ3N3aGF5Z0dmdjJpM2U3VHU4ZG82NG0xRk9VbkNF?=
 =?utf-8?B?MEZQN2xSaER4a1hJNUlmeE9zT2swTklYL21sQkZtWVFyVUYwSDNNMG9nUHdD?=
 =?utf-8?B?Rzl2ZTZtc0x5U2x1c1ZVWU1qRUhUc2JXVytPU2NteFk5Nm9kSFUzekRMRHF2?=
 =?utf-8?B?VlgxOUZHTE9USC9TOXdPU0hnME1TM09ZSjFLbWQwMmxZb3JDbU5jRUt3RDAv?=
 =?utf-8?B?a0ZVZkhJWG9Vbk5sMHlNRzFkT21KVG9MYTRtNUJ2VFc1Z2phS3ZUQVVwUTFV?=
 =?utf-8?B?UzNkSUNNbnhVcEIrUXBNSGJmbEh5KzBjOFZwRjhQdGF0SzJ4c2ZYbXZGZ0lO?=
 =?utf-8?B?VEdOU0Q0L2JlYU9yVnJtWkRwb1VhMlBFcnQrUktSWitBUnN3SEIwa1E2YXZt?=
 =?utf-8?B?dkY0bjZteXZKU3pXbE9UOXFjNmRHZ1EzZkw4a2hxRG0waG1LaXdIRGxTYmgv?=
 =?utf-8?B?bGJWbFlUWUFSV2o3SE81bGJVOXYyT0V6UlFiWU4wcFd4Z0RqTUZ2VTR1NTlQ?=
 =?utf-8?B?QTBidkJrdWxvQ3ovNFNHU3g1eDFVYVErTXlIMzFpdlhnTEJXZWo5c1JzN041?=
 =?utf-8?B?cDJQM3JLT3dMeWJjY1dEaG9PcHlNMndKK29GNTYyMno5MGRnL3ZwOEJDTU10?=
 =?utf-8?B?anNuaTBuVkcrRU55cHA0RG9ZR0tFb2VIY1p2cFV1NitOMHZjdmJzOHV0V2hQ?=
 =?utf-8?B?djNXR2hWdXg4RWRwR2E4blpURkhDR1JDSk84RCtPbDQ1L2gzOHQzR1ZnOVVj?=
 =?utf-8?B?SDgrdXlwRnkrK0x2blN1VUY3U25tb3dFWWVqQlk4cEVWNGx3Nit1TzZXcnZ3?=
 =?utf-8?B?MjNFVUN5cTdjTk5hS0lkMlNJcXg2YWpRNGdKVlNOcnI5dzJYVVlFcnhla212?=
 =?utf-8?B?Y2o2NzFhRUZJS09ldzJtRXh1Yzl5Q0EvVUFrVEN6cUljTEZNaHVhUWVLR0Vl?=
 =?utf-8?B?eHpuZVlZbEVEdUhlZXZBWjZ6Uml4RkRuTUlkVWhiVnZwWlp3dGI1RWJwSjhD?=
 =?utf-8?B?Vm1mZW1TWkVqVVRHVWdNN0RiRzQyZnIycE9MeGFDY1hEcU9EUXU2dWI3ZDJV?=
 =?utf-8?B?aHViaFpKT09mcko3ZmRkbVIvTVZqb1I0MHhBdEtOMHNZZ2NiSWZNOGxCUTMx?=
 =?utf-8?B?N3M4RTB6d0JsaXY4YUR1bkJ3V2JIQ2dGZUl6QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y21xVkZjK2FLMjN3RjJXTHppcGxIa0Y0TDRFMlVMSDRmeGpHWTVPd3BwcXlr?=
 =?utf-8?B?RHdWZjg4SG5lczdHOHZwVGdNeGZGWW0yK2pmNjUzdC9INGRPKzIxRzg2SFRB?=
 =?utf-8?B?cXI0SGJvMmJwWTZ6YUxzWXlNbUhYOEVmbXFHcEhmb21PTDIxeVowV0wvUTBu?=
 =?utf-8?B?b1hxNTFPclFsUEZYR2t6aktnQkZBS1FORGZpUWR5a3E4Uy9QMnA0M1h6cDEx?=
 =?utf-8?B?ZExRQVFQT2JZOUd5ZE5JTTROOVpBZFFNNUFDWmQvODRuRUdZU2xhOXRlV090?=
 =?utf-8?B?b1hYTFc0OVNmeTBDRlJROVFFRXJ4WGRkbk1URFVlbm9pajlJREZQaTFqUUJM?=
 =?utf-8?B?RzZkSDAxUHEzOExGS1VnbC9MdDNzNWtOSEtFd3I0aWhsZWRIN3dNWDE5SkFJ?=
 =?utf-8?B?UElTcFJqZ1BCcEVPcUh2aUxDcFVTK2RNazUrRjdva1RSQ08zbzh1SlN6OVo3?=
 =?utf-8?B?Zm5GQzU4RmlSWnhlNWUyMy82TTh0b2lXbGxCdHhVT0p3cnl6dG5WTnRmK0dB?=
 =?utf-8?B?eDk5TzkvaXZ3Z1ZONXQwcFNhK0xnMkxUeUd6ZFhnUTBYVTdQdHRhMkpIMEx4?=
 =?utf-8?B?bDA0SmxkcUJJWFBWWkV0a1FUcWxZaXM3aTRyZm0vYkhGUTd5UHZTUndzRGpQ?=
 =?utf-8?B?ak9vQTNGeTBTc05nWkdydElpRXA1WUxIWmRFMjdJamZuKzg2RjQveWxMSk9L?=
 =?utf-8?B?SFhneklJVE50d3NhS3NUREF5SWxVSzJXQ2h2cVZ2anI2eWVlZTM3N0JsR2xa?=
 =?utf-8?B?bmZMdVk1eG9nZGpXTkxPcnFOWmxaOTZZdWY0MmhIeVpFSmxhNXpKanRWamlo?=
 =?utf-8?B?Yk5uYXJ4alZMb09GbmhONGk4WEFuRkFzNVVnaE5nZDFVUEFwbFRKcCtJbXl5?=
 =?utf-8?B?cmhQY0xpbkdEUFlUMWJJamMwVUdkV1JMMUljZ0pURUdkbFlUSXNObkVTemlF?=
 =?utf-8?B?Sm9qSkUvVGNjZm9RaUNqMTgwSGVMTHgrem9HYVJ1ZkZuY29BL3JNaEh3ck03?=
 =?utf-8?B?dHJmQnJZT3JGL0Q0WlQyM1U1YUNPVXBGcGZmazRNbldZLy82NWxrQkhoRDVB?=
 =?utf-8?B?cm9FbVQ2eXdBbVFvWTBUUm53OUgrYXRhc01qTHJLZFZ1Q09XWmJLUytUcDFu?=
 =?utf-8?B?QTVMdE0zMnkxMTZVTVdrWWFXNDRZQ3ZwYlVFSkM4dllkZkRxWDQ4N1VwRXNZ?=
 =?utf-8?B?WEpTRkN0TW0zYU5MTHg0YXozSEdZZEY0Y3NkdllldEFlcGxuTHhZQWljb0wr?=
 =?utf-8?B?OXhGK1VMWVVPajdkUkl1VnBMQkF4elBxbFZIK3lHVE5OZ25aZmpyU0lhKzg4?=
 =?utf-8?B?UEl1U25CelQ5TGxrSWJ1TVNpYUlpS01WOFptWEdOOVg5ZVZoSkdiNVkyemhN?=
 =?utf-8?B?SGxJWEhmdy9TOCticGhaclA0T3N2MTh2citBZDF1ZXJzKzBDUHk2RzN0eXlw?=
 =?utf-8?B?ZDQwaVJYL2pmWWtpelJzN2RLZENFUXJDR2RXMHZ3dEtPVDZ6Vlh6azBjTks0?=
 =?utf-8?B?dmR5Q0xyUmEzeFRTZXI4Y1pqNElFdWd5enRpbnQzbXhZbk9ZVVJCejBuTy9l?=
 =?utf-8?B?ckQ5YXRPSTVKRlNsK2t3RkRTOFUzY2U2WE1nVGdkOHcxbEVyOGY0d3N6dmdG?=
 =?utf-8?B?TGlKSG5KMEZ4VGFSYjJGczJtSDFTK1hGT0dGS3hZenJJSVFRY3ZVMEplcEJ1?=
 =?utf-8?B?N2hpcnNKY1hZcU1xYlpLYlErcGhOaGxXcllJN0ZkYks5Y1hJSVByWllNaHR5?=
 =?utf-8?B?YU9iV0hETm94Q3pDM250NFNjcUpxMXVEa1B4eWFEdjUwQW4ycmlDZklvZXpu?=
 =?utf-8?B?aDNGSDVWcHZRVklXbDh5QloxU1ZEbDZQSVFlYnAwMTNUVXZtZ1J3OXRlUUdD?=
 =?utf-8?B?WHREeUMzb3M4OFJXOE5UTWI0eUgzOGtGbFRWWXhaTjhWeFQ1cE52Rmt4ZTN6?=
 =?utf-8?B?Ylg5ZEhDdVRvb1kwcmxLbUI2YXltVlhoT290b09Cak9vS0hFMEVsSWtubmZZ?=
 =?utf-8?B?a21CekpkdExrenlqRUcvZktVeFBOdXpFNXZIVjMvUXNmSDNrYVB5L253U1Rv?=
 =?utf-8?B?Q1lkZ2kyOElJeEdjM3E2U214Q2s0WmwyR2JBWElIT1NncXFib1RPYkpGMVlN?=
 =?utf-8?Q?FVTOwgxN3s+dxs31+Q3DxDo7u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de58d77-dee7-4c2a-d838-08de07ec5721
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:01:19.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGENf3+1PT+nwUipS0MMJ48eeLOf559LrtNAYy2oEw/c/O9q9Rr6TarhsxU+bO+w5VMK/kyMvqUZb5wJFDlsZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270

The GPR_REG0 register has an USB_PHY_REF_CLK_SEL (bit 6) to select USB 3.0
PHY reference clock.

USB_PHY_REF_CLK_SEL:
bit[6]   - 0b 24 MHz external oscillator
         - 1b 100 MHz high performance PLL

Add a clock multiplexer to support USB3.0 PHY clock selection.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - add Rb tag
---
 drivers/clk/imx/clk-imx95-blk-ctl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 56bed44719954d6a644606914b61dad672cd82cf..c078b2ee28e81155ca3a93d26c2e757c8ddc91be 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -302,6 +302,24 @@ static const struct imx95_blk_ctl_dev_data hsio_blk_ctl_dev_data = {
 	.clk_reg_offset = 0,
 };
 
+static const struct imx95_blk_ctl_clk_dev_data hsio_usb_blk_ctl_clk_dev_data[] = {
+	[0] = {
+		.name = "usb_phy_ref_clk_sel",
+		.parent_names = (const char *[]){"osc24m", "hsiopll"},
+		.num_parents = 2,
+		.reg = 0,
+		.bit_idx = 6,
+		.bit_width = 1,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data hsio_usb_blk_ctl_dev_data = {
+	.num_clks = 1,
+	.clk_dev_data = hsio_usb_blk_ctl_clk_dev_data,
+};
+
 static const struct imx95_blk_ctl_clk_dev_data imx94_lvds_clk_dev_data[] = {
 	[IMX94_CLK_DISPMIX_LVDS_CLK_GATE] = {
 		.name = "lvds_clk_gate",
@@ -519,6 +537,7 @@ static const struct of_device_id imx95_bc_of_match[] = {
 	{ .compatible = "nxp,imx95-display-csr", .data = &imx95_dispmix_csr_dev_data },
 	{ .compatible = "nxp,imx95-lvds-csr", .data = &imx95_lvds_csr_dev_data },
 	{ .compatible = "nxp,imx95-hsio-blk-ctl", .data = &hsio_blk_ctl_dev_data },
+	{ .compatible = "nxp,imx95-hsio-usb-blk-ctl", .data = &hsio_usb_blk_ctl_dev_data },
 	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
 	{ .compatible = "nxp,imx95-netcmix-blk-ctrl", .data = &netcmix_dev_data},
 	{ /* Sentinel */ },

-- 
2.34.1


