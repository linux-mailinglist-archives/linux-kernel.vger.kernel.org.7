Return-Path: <linux-kernel+bounces-725251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981BBAFFC75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753D864562D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B745D28CF4A;
	Thu, 10 Jul 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mxSQG57X"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475328B519;
	Thu, 10 Jul 2025 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136530; cv=fail; b=gouRf53mBBTrB5CpUgpmDZK0SBECNRV56pjVPKc8Y2303uFRGzRgL1ADvzF/PhLOBRk6CaRyMsMAIZdXuGjYd74xv/yzeWniMo6WVLx45S+J5gzhQ2Ptr/3vsmL0DZLzrxQRAkxmaAl0fhLyXTqZFxNUCqjGjPvQgVHz5C7Y1iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136530; c=relaxed/simple;
	bh=pifyHl+upSEXGrNwu9AkYdfkgfYp1MPBPDO65pNL0jE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=atj+EErYbtzTg8psGwIg1k2qNgYAHMJvrwr6lrjFMrLWuXSePgqmUn9Z+cAWD021Goic6PNrS+PF+2oI1eQVTcvf05jFXiw8Ld3G8zpvQQcIBRf4jDGjNNgAEyzpfClZE4gZPzAIAtn3eXkBKWaUjIwLeBGL05Tgbvw69H1L/m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mxSQG57X; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYlaaZjJQp65BoISPDiBVii2AKeWE7bt0CmKrWQZDOLik9IF6TsPhrf/PQMMbHrg+EFDUHia0JN/gi3kHLilZ+62/A2MDefm+vuY1xh2753OXun945mGZwbsGkf872qiVL6Tjo3nyZxHVORnRR9DnYIU5PK6bPTNIDUSlOtolMOM51MdJ+euEUBGKiCG3iLNUu1U6XUgik4ZIKPJDzwviw78r3vSuLvVM7fEO2lzZwajt6DfTG+6bCpiXgbry8RfreWXAI7+Acw1vE52oagqR8YnDAocLdRVvvz1I09gQdh0gIArQKyHGuLs1qvWio9Su0X7B7aBwBYGa83fMTClPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmaWIJQRVbWQYyTwQ6DOIzUSTeRMjOT2bz/abwmpcao=;
 b=Qv+fY/MRkMcinn36zX4s6M3C4BeIZt/TJIbW0pcfqFPpZAPLuwcAxYizKZ4X3YZRA/nYeDzjqabJAANZVLuZ3/chBvBTpIlX3pf9eCtgX8S7/mXs+EoKVDzViDwgrXsRwXkJcDAq29EmWkKZ6HNfWR1YIeZGEf4BMyqMmnCGJjj0qms4PyfMzTwYknxudK1/BTCEhUGRjWjls6GggEwYQ/jjBRFD4H/NV5Q7Z2CeD2aqc6tMaVGxP7kIa1NbancCgaJKTi2N97eIKjxygCuAvjPo6XIKOzSpD9yp+GCKY49uC0maSJz3PbTp6tuNBLRpHZ3qEZIAEer5WLb5xYDndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmaWIJQRVbWQYyTwQ6DOIzUSTeRMjOT2bz/abwmpcao=;
 b=mxSQG57X2+2QnC5MTOTowthRpGxzKW+SXpZvd15LaLaBQquT9Qjk/UTwfmYkEXg6KWWI5L0fI91CY6+zGFdZbUEr4hbg8qAModzmDJMv8WVIQbQjHGVZGYsju66XmNLQYjOFrz/oEct2pjB9dTFdvJLKyl/XfBm7gfZxtxbR6gEhFo42faNlN5gkxv1DAIsSysKIfp+UWAl+w+RS9S84Clps/BnfFg5uNcdONIdMfULECl0bYOdrq+KZ7Oi9jc/C2fDew0Ar/MpgYwyUmScU5KK5UlmU0PHc+J6AO9ZSGZiWaWFEXTyUtzpaKDlLnQ+ZnZFexPUj6PyAxV1wGgonLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB11512.eurprd04.prod.outlook.com (2603:10a6:10:5e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 08:35:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:35:26 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 10 Jul 2025 16:33:26 +0800
Subject: [PATCH v2 1/6] firmware: arm_scmi: imx: Add documentation for
 MISC_BOARD_INFO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-sm-misc-api-v1-v2-1-c3e953e34be6@nxp.com>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
In-Reply-To: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752136418; l=2251;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=pifyHl+upSEXGrNwu9AkYdfkgfYp1MPBPDO65pNL0jE=;
 b=+ZEfubarliAvb5AIFEUtbnhk/O8Y9POa+9scyvq1pK6iK4Y5wOuS/MXUcWDq4Pf9f/cOJheav
 aqQGxL+x9ZBB+L15vC1lbf31hY/CeVhFDcB+X1TKqww4g/HqLHeqdLZ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 382eedaa-5875-4326-8eb5-08ddbf8cb839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Smp0c3dkbTBsOENLZXBsSUl6czJ3L0RzV1djbnprbUJ2UmNnVzBweWsxNlBv?=
 =?utf-8?B?S2F1Qk5iVGRlM2Rsc2lXeU5LYXpBbkM3V3FxOStwT1hWd0xKbldwWnVUWENt?=
 =?utf-8?B?RWY4bW5Oajl6Vmw1eS82ZUdNSzVNNnM4R1ExRUN2TnNxVlVzanBvZmtUVXRm?=
 =?utf-8?B?NTJhM3V1MXcvSzBCdW9jaGNYQXdOaTlzNVg0eHhhMkU4NzN0VGUwVmR5aE96?=
 =?utf-8?B?RFR3dGVWN0c4V1U3V1h1STd6SEpIM3l5QVNOVTM2ejM1Z0M1L1dUR3RXUlNQ?=
 =?utf-8?B?VWxpV1AyOVZ0MjEzbVR0Q0cySGtzM2o5MTNUUlNFTXkyWThjYlQ0SHpKNWdj?=
 =?utf-8?B?UWF4ZUVlNkNWOGw1dUpjU1MrNWF5WVVNci9iUzdnaUZCcUhaQUpuck1hOUw5?=
 =?utf-8?B?d1RGOXAzSDErQVNZdm81Q2lVeHZXeDRUckVIUjZjR3EweSt2bm9wcmZ6RWk2?=
 =?utf-8?B?bFhyMGY5bFpSRGhnK3JwQUdhb1o3V0krVGJmT1E0NEVtcjhCVXV2L1VwTFZJ?=
 =?utf-8?B?ODRkekh5ZkpzOGxtYnU1V0VISzhWMUlpLzMvSm5WOFY5TzNHakRTZUJSOThz?=
 =?utf-8?B?MmdKQVg4WCtldjd5SEdjUi84cXEzdUpPckZhS0hhVWNCREdxbHJCUHRKa0Qx?=
 =?utf-8?B?WTJ1RGNTcGhwLzJNeVVFVCtXc3NHWUQ0K2ZrY1BkOWQzMFdDUHlBR3RhMmwz?=
 =?utf-8?B?TkszZTBwcjVITzMwQmhyMDJZckpoK1VhYmhlSmsycnRWaW1aU1ZnNDRFV3hx?=
 =?utf-8?B?VUIwSUtrYTJKdU5ndy9VSTBrem8xM1ArYm1hcGF6UUJIbVR1WjZZM1JHN0tL?=
 =?utf-8?B?Um1pR0ErSTBCVGdNQWVGemJrbGdzTVVMK0doc2ZhQ1QwdTlpZHdtZ2VOQlNW?=
 =?utf-8?B?a0tnb0N1cHErN3ZxMzFNa0M2WktHc2ZUNGEyNFVuYVdpY295clNMUFhHaFky?=
 =?utf-8?B?NE4yMGZPMWE3NHNrQVQ4OURNRWR6T0srMjdCUFR6UXI1bFlGSmt0WGpWL1Fy?=
 =?utf-8?B?ZDZCazlmb3ZYbWpqQW10M2Q4dkZCUldRdTA4MUVVd1A2aHRlc3JPOUZtQzdl?=
 =?utf-8?B?azIycW9vRnZBOGJkbTNkdjY0K0paMGwwU0xlSWZsdFNRUHl0R0NjOGVrZWQ5?=
 =?utf-8?B?MkI0ZDB6NnVVOCtHOHRiTmdsbkp0MWwzODUrR3dZY2g2MHlocEJiaVNXdjIw?=
 =?utf-8?B?NGErcUxkSnFXVVNVak9ueDRiWmVON2sxcmxCcEFyK1RKT3dHU3NIUDIrT2NV?=
 =?utf-8?B?UzZKR3FSblBXWUh4Rks0VFNqcjFZazBLaEZDN3EveGJjZzV0cWtnaXRoRFhL?=
 =?utf-8?B?QzdXRGlOSHoxTVV1cXJTaDR5YjVqOWkvbWRzQjBOWWF4Qi9xbjZlcXYyUkZC?=
 =?utf-8?B?V2lGSEpiOU54SStCcXBFUFRUaDdFU1p0MmFKY29xVDdYK1k2WUU5MWU5TWVr?=
 =?utf-8?B?emJlVmp4SElvK3o5UFhzSDBzL2RzMG9OcnB4VlhmS1VGU3l6aktMb3lmTGNX?=
 =?utf-8?B?MndRQUFmL2RqWFNjTmNlTmlpdmovSjB1UEJPc3VGS1pHMDkxTnliaHMyc1F1?=
 =?utf-8?B?RDM3Q2YyZTJSMFYzaXpWWG5vWVJiQ2RMTmJuVkVCQzEzdThQdUFoV3VSam5O?=
 =?utf-8?B?NG5lZnpoRFRMN09tUy92bDMxcDdvbmd5RjdudCtiSFJta1dFV0xpTlJFdWVn?=
 =?utf-8?B?cmNvSkhHOGduUlRTUHIvODZQWVA3UEJyeGJTTDNiU2hmQVRnNmVrM0FBM1Ju?=
 =?utf-8?B?UkI1N2JQdStrL0tac0lPNXRObkNpZVdpV1lSRkNrRFZDQmRBdjRWMndaV1hj?=
 =?utf-8?B?UzlySW91WGhYcURyc1ZVTjB5TzRyV1J5eTlkaWh4dmMrMUJpNlFEa0duWU42?=
 =?utf-8?B?d1FDQWNXUTFscCtZNVQ3YlZSNjNHQVFjdWRCaGRRVEt6TjJLQ28yckZTZEhk?=
 =?utf-8?B?bklwY1BQK0Nyb2V2Qm9INGY1TXFhQnBBdEZTd2FJbjQ0SDRqT1lnd1dPemV6?=
 =?utf-8?B?R3RkSWw1bnV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjFHTzF5YjEvYk42cFZEZ2VreE5YNTZtaUlEWkhaSkx3WUxUc1JhSHlVQ2Ns?=
 =?utf-8?B?RnBDVlZTVDE2UmIvZDZrTXlNYncwVkhManlDdi82YnA3Y2paM0pCV01sWmps?=
 =?utf-8?B?RUoyOC9CZXdZU0hhb1hGc01RTmNqelVtR2UyVnpNdFpIQnZNaEE3UjFGTVZG?=
 =?utf-8?B?OTZvdisrZGMyRXg3Y2J6VmJ0QXJMcWowWnc4UzVpYjhLamF0Wlc5Z1hRaVJY?=
 =?utf-8?B?cVhiT3ZrZTZSOC84Z2RPMW4wTzcyN0Q4eUd5ZEhVYW1UNURSTjNEc051ZEZw?=
 =?utf-8?B?a1ZLanpEVDFvaEFNS0h3VnlmdnpjcWhZY0didG9vcSt4OHRKa29oUmJCc282?=
 =?utf-8?B?SGJpVmZNWC95VEhhMFZJQmlqSk1rZytIQ1BjT3l5ekk4ekd6T0dtektsYzht?=
 =?utf-8?B?VEFvTkJIOXZxQk9Yaiszc2hrTDFuSlZPdlI3M2M2M1dUa1Rvak1GSmxZZ3BQ?=
 =?utf-8?B?TFMwMkp3cDNzU2c4Zk1Gc2pLcDEvSml3QnZqUkJ3RkxrVWs0akRiM3cwbTFy?=
 =?utf-8?B?b1REcU1hZTNzcUdyZjdoaTlMeGxiVS9OOVI5SXBiNEhsV2lTYzZmQmNBQWg4?=
 =?utf-8?B?bDRMakNUUW5oMXM1WGN6ZlBwUFJjT1ZWc08wTlJrdWV3U1BseUZLcHgzclNF?=
 =?utf-8?B?alhNSlp6N2JnTUxwYmxnNitFVUtpc01ERnYwZWROZGRHbXoyVGMvR0dQY0pl?=
 =?utf-8?B?bGxrblFVSmJGK0o0azRhMlNtTDZlZVJtZDFkODJzaGRDdnA1YmoxbGlHUXJE?=
 =?utf-8?B?N3dxWGJuZjVUTStteEpXOGFhSng5Y2U0KzRpdC84a25XYUVYZEl1dXNTQjJT?=
 =?utf-8?B?RGx5YTFGTUg4c3FUTENMZURZdzMzNEZGTkwzZVN0N2FFYWVmRmVOSHh6NFp6?=
 =?utf-8?B?TjUxeXBWUHIxRFM4QlB5Ym9yZFRHT29lZUlXKzBVc2RCd1pmaVJkbnpPNm1X?=
 =?utf-8?B?R0ZqN1NXbnZtZ0dYWmY1M1BlMkQ2clV5MmlEdkRaNktyWktZQWVJVTJqckd2?=
 =?utf-8?B?dFhHeS90TjQ5a0I3TmhNb2xxWkkrTDl0Z2llS0VTSXJlZmgwZDNPUitNd1JG?=
 =?utf-8?B?T2E0MGs3bGRhcnA3emdOYnJscXRjWnprY0NjOGJZWk9aWjNXOWpjNmswd0Q2?=
 =?utf-8?B?clllTGNyV3RVeEp1ZVdVd0Nid21hTVlFMklMWW1idy9XNGNCNVNFV3J2N2ow?=
 =?utf-8?B?ZWpTTEt1eS9PQVlxUnpUdVhVTDRxVzg4ZzlZL1FiaDhKOUJwZUpTYW1nZ1FS?=
 =?utf-8?B?Q3lHNWlmNnJwTThDT2pWbEJvSUsvRmRuZ1Q3d3FKVm1LVmJHSWxRNk5ZbUdr?=
 =?utf-8?B?OFQ4aU1lelZIRVZaeTgzOHppdTlob2ZYUnZ1UXVVTlU0anJNYWRyeU00L2F1?=
 =?utf-8?B?dlJEVWRXL0hvOTRXNk8xakF6QUlIUFdxNVIyWGhVRUZNa2N6VHZrNC94a3BP?=
 =?utf-8?B?Zmxteno1dndFMlBoOGZ4VFJmVVBhRjVteWYvRDRKMmIzMlZCWGNKbXRxZ0hT?=
 =?utf-8?B?Rjk5VEMxMzRQa1g0MHVMMXZyd3FNMzc0WFdkTy9sQm1FZ1Y1c1NQQmwvcFdn?=
 =?utf-8?B?RFpoNUFZSEJtZU51NGVweldOZ3U0MVVWL2syZlBra01BUFZRYlRuMDl0TWNu?=
 =?utf-8?B?YkpPSGEzSUtiYUtkekozK0FRK3d3UmVBQi9JeTdUZzI3RERTUEQ2OXgwS1hC?=
 =?utf-8?B?R0Vab1NrSFZWRHlMYVRiZEdMbHpTMnpvTzd4SlI3dzNKS2dUbUQwc3pUclFl?=
 =?utf-8?B?dUVRZi81a2Q0bzV2enNzWjF0eHk4a0twSmYrRjBmektPeTE5MFREY0paVGdQ?=
 =?utf-8?B?Mzdrc3FaeEtsVkNXYjZQbXZZZWhYNHA5M2R5ZDdpZElmQXN2bUF4Q1I0TGxu?=
 =?utf-8?B?TTFEeEgyL3FxQlp2cEgvRUI3RkdLL2xpL2w0R3VyaGNuRGVsOU9Ta2I2YjF6?=
 =?utf-8?B?UW0yb2ZBNmM0eWxJVVZJeFBkbXVCRDhteDNpdnF3TDRyanNHSmtLK0x3R1lk?=
 =?utf-8?B?Sm5KUm5CbUJZeldTTGZETHVxSXdrUzVFYkpMN3A4UzN0RitLdkJRVzNqMnZj?=
 =?utf-8?B?Z0R3cnJtdlU0WXlzRXIzZDV2czBjZGlpc3EyR0ZkeVY0OHdndVJnMnRBcHh0?=
 =?utf-8?Q?TeVZCT4+TBWJYS28VF/PP53Zv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382eedaa-5875-4326-8eb5-08ddbf8cb839
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:35:26.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwgCnTTxUOT4usFYZkrz1RFy3wHNwuhp/7OolQlt47i+gMtkIACEuYErW40ggHiWeyx2KKmyRUI7vwZDvmKpxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11512

System Manager Firmware supports getting board information, add
documentation for this API

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
index 4e246a78a042a79eb81be35632079c7626bbbe57..0a4d157b3ea12c7735aa19d8d6c64ae8504d0c71 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
@@ -1670,6 +1670,28 @@ protocol_id: 0x84
 |uint32 syslog[N]    |Log data array, N is defined in bits[11:0] of numLogflags|
 +--------------------+---------------------------------------------------------+
 
+MISC_BOARD_INFO
+~~~~~~~~~~~~~~~
+
+message_id: 0xE
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: config name return                              |
+|                    |NOT_SUPPORTED: name not available                        |
++--------------------+---------------------------------------------------------+
+|uint32 attributes   |Board specific attributes reserved for future expansion  |
+|                    |without breaking backwards compatibility                 |
++--------------------+---------------------------------------------------------+
+|uint8 boardname[16] |Board name. Null terminated ASCII string of up           |
+|                    |to 16 bytes in length.(This is SM exported boardname     |
+|                    |which may not align with the boardname in device tree)   |
++--------------------+---------------------------------------------------------+
+
 NEGOTIATE_PROTOCOL_VERSION
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 

-- 
2.37.1


