Return-Path: <linux-kernel+bounces-787674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D997B3797E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24217C172E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0630C606;
	Wed, 27 Aug 2025 04:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QbsP6cJ5"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F030BBBD;
	Wed, 27 Aug 2025 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270786; cv=fail; b=BjZo65o/5NmAFJaooc2ARgnddNn0eTLHOCJWjHfLUJQxUnrF27sR3Lr4AR+KA1DUAiBqIUSGjuzlZOWej4eW82XZW44mLxas3jsFxej2tozgUU0KJiupT4HrsXzh4p5x0qJNZGipPaaSannupQbRQ8XgHc1Bgir2Y2/kccvmi9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270786; c=relaxed/simple;
	bh=OP1ZOS3HlOb5R3CAaKN0u2Bh23plx76VXDC45z5aTKU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Lxq4/RvV8xkutdUsFFM3QSJT90JozvBUGuEbFMza+2rhZ8Kad0yOkKQN1gKNigYihNM+OxycYZbBWospnH7OwOIRLMqqb3pHb1Hi3QDIqI2okwhQQaG9gGmyt0IqYq5vavAqAU96n72inGb4mvLmF9xmgOWj+LOAip2PwbzebxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QbsP6cJ5; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCw4QOVQoYa4kGlF97dui5DlVdZhlDtxjs9hgPNpSW6BnbcmWNzE3cCaLR6xw/jjoZAG7oz/XjoRok7r2T7K5orhSgRs2hqd47yXiky3qGaWpC3B6Wpbnvl9S6mLcwI99Sl+F+Z2aS8IIkUE7fMLmErpj4rHGw+yIW6WteaNJEJIYKxNz1cqbdu59K0+lNm+0KN3grS/mNfTs+rpicoNsR9AXAL+cZZA/GEKPQOWGhVSbTQGtvunwqCaPNc8L8wSsMIFOXGWQlJ2pUzqsQAYgARpspOdPkwMhrEc0mZjw/TtwWAUGL5/3GVx2DB12yoUP6X6gcQd/QufLTNGIrzo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u91wH6g+4wgPWVkc+/faoK8LUbGLetIdC8NR4sYUqG4=;
 b=kSIfO7mAzNEDwFDQZABpa5ooHSeh+fV9w/+bDZtgfAR155KYR/z3DkMZr/Yr4havMPGIZAB2VszxPds7kPUp6cijvStLd4NesrTkV54cO0hmDA7ihW9JOo6YjAYnMpFYOCTxW8i0tG3p3/wXRy/BHHzKhB3ADWH1SXpIF/x3ImO6bBt0AIo9sICRzrIJqX0TctaurFBFjoQyzIIsldsALULeqs1SZNrn2G6tchQlROBZSM+ptvcMshtnb+8D0t3KvlVZTGibTfoBvscswGbfp2q3pMOdvjao06Ra0Yn5AVdpK/U6KAICKb9jPgP3wDA0utQlQFCReFhnDYxiodROtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u91wH6g+4wgPWVkc+/faoK8LUbGLetIdC8NR4sYUqG4=;
 b=QbsP6cJ5dk4xFNeyUJ+cGxJUmx3SPN9Cc67zNQfH4qWbgN1WXzzuJe7Mpubg/3BeWREg2MYUC9BIfD4Ly6x/xXYYcvhlU+eQeZIkcWS0YKbLM9JO6qDhfVI9ZZk5c1asBpGK40TFYdcPJF0Rlz6D8yjrvRxYwHDNYk2GVfRapvw8dqZO784bjU9DnRZOGBn7bbSr1yg7Mc5PuifbsNtQIpNDeJQHbM5smawA9AQyl9BRoUVqGcq+YnmOWA5VyzVX7DaRYvnqgQhavhWadCU5Mu1/Lccqc8WE2XvwaQUBF+DKAcCJE7NFCRxDQqOXku0Nhx2HqV6DBSYeyQ3WIa6n+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6899.eurprd04.prod.outlook.com (2603:10a6:208:183::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 04:59:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 04:59:39 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 27 Aug 2025 12:59:14 +0800
Subject: [PATCH v3 2/6] firmware: arm_scmi: imx: Support discovering
 buildinfo of MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-sm-misc-api-v1-v3-2-82c982c1815a@nxp.com>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
In-Reply-To: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756270768; l=2678;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=OP1ZOS3HlOb5R3CAaKN0u2Bh23plx76VXDC45z5aTKU=;
 b=1YO+fDXL+QxZvCX21Aj9h/fC/f1f79R3DNJ6DKIPHHaCd1m/3IEVBuG9O/riN7zZ0Dp3ROrmp
 p67wDkJ6cd7BXGM0JvP+cH+5DtBBnrPqOH2zj81cA5qEx1mhTZIm9gA
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf7bf96-9273-4700-8c67-08dde5268752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUl6QUs3VktxaXhVUExrTmhqUWhWZXdTTGErTjVYdGQ3Qkk1UGdLbUh3YVFD?=
 =?utf-8?B?dDNYY2FZbkpsQXE0OEY2MkxvemE0elJ5TmQvK2prbStzKzZ3K3RwUktXMEVR?=
 =?utf-8?B?N0lTQWpVSGc0N0hhU0ZCUk9pN0lnQjJ3MUY0Z2pneHdNLzd2bUxWWnpUVUxV?=
 =?utf-8?B?UGlnbzFyYkFIZHJIdVplZ25BcW1pTlU5QU5Ba1RwWG1ndWt1MDc5amJKb25D?=
 =?utf-8?B?QlNCNHhncXg2bmdsRHVVQ1NYVGluS2JUbFdKa3NIM3BqZE56c0ZVWDU1R25P?=
 =?utf-8?B?Nk9iR3lheVI2VGN3b29zaUg1UjhYbnpna21CQzd0OVdaOHNKRHJNV1ppMGQ4?=
 =?utf-8?B?WGpSWmpuY3F1Q0pkRDZFbUEwbHVHZDVaUmkzUTIyRlpJVGs2eWJvK1dUQ1Vx?=
 =?utf-8?B?ZW9IOThaNmUzS2R2SkEyaE9HY2ZManVRc0RTL3lGNGJQUDZKYXN1aEtqZEVG?=
 =?utf-8?B?TzBFU3V2WEpKY0JWREZQNnJOQ1hqSmVyM2w1OGpheHZlM1ljcFduTFJOYm04?=
 =?utf-8?B?ODRpU2Y5ZWZoMzJraE1HS3FKTktVQ3hMMjY4bUVJZGEwMDk4SGErbjRTR09D?=
 =?utf-8?B?cVA5aDh2bzFjZGlNWUd4NWNxRUdZYTFqOEdlVVU0eFpDVVpqTHdpY1dCRzhy?=
 =?utf-8?B?UnVLck1VVkpMMkpqTEk0NThkYUhFdENKTWNRSFMycVZuQjR4QytjSUFQaFRY?=
 =?utf-8?B?NGxXdnA2bE5Ub1FncjVZcXRpWThIa2lhdTUzRktsbzN3Vy9Bdnh4YjZFdnJa?=
 =?utf-8?B?bHhKSGk2ZVlnMG1talM2eVFRc1JaUm9Ncm54TEN1VWxSc1p3VFJhZTlWNmtw?=
 =?utf-8?B?NVlnVnpONzB2czVtOHY5ZXlhOEd5YTE2d1kyVDFpWFJnK3Axdit1UDFRUFVu?=
 =?utf-8?B?eTVnMDFMaDMyYjNzNXNpcjZhNTRUeW5Nd3ppaWw1cHdlTis4SE9ZWHcwd3Yr?=
 =?utf-8?B?S1hoUFhTQlFnV2xPNVJ0NEFWQU9QMndPSlJKK3VoK05MRVJwRDd5SkdpWGRm?=
 =?utf-8?B?WW81eFM1TGFCelFXK2ZxM2k4S2xtc2FmOWZ5NXEydDAyT2NXb2ptTG1Zc1Fa?=
 =?utf-8?B?OGh5dTg5TTY4b2oxQlJ2MGZUcTJIMUJET1pHOWQySXVjUjRjYWFEUTJZMGhB?=
 =?utf-8?B?a0tlT1J4cDZ3NXpPRHRSMDB2eW9xam01RTR0bFYya1BlRnYxTWNsZFpVZ0hw?=
 =?utf-8?B?ZzZENmY5U085a0VXL1k3UGkvOW9VRGRnKzhOVUIwRm1sSGdnTW1lZGVNYmRn?=
 =?utf-8?B?RHNnS0M1NElSNG82amlQRkFlVE1yNlhCMXZrMldybFJ2by9GRjFnNzZuWmlt?=
 =?utf-8?B?WGNJQkVHMnBhQ09QQi9QZGRKRzFNNG84bEpJSWp0VS9kdXZXWWJib21mWnZn?=
 =?utf-8?B?bEpUU1Z3NEYvMnFTT1ZjVlRReXVpSTYwdWxRZkNoZ3phRDByV0c1dlF0Z1p3?=
 =?utf-8?B?L2p4dnh6WDNKeElRY2hYUUE5WTg3ditpcllmMWtnZmFlK3hnN0VOVmlGcHA3?=
 =?utf-8?B?UW1NWFQ5cTN6QlBOcHgrcGEwRHRDcUhVeDNzeEw1Qmo4YmZ5Skg4eTlkMnAw?=
 =?utf-8?B?MEpSSHJyUjFXQ0xMSXZsbjJ6WDBTRll4TXozME9GWnB1Z0xQT2ZIUFpzdmNr?=
 =?utf-8?B?OFJNRE0reUpCS0VyN0VjKzhuT3psTjZyNnhGNlhsTXR1TEhvc252RmtWNHQx?=
 =?utf-8?B?WlRLQUE3U3NKR2drWG9sckROM2QzSlBEdm1JTzlhbHhZOXpIVDlNdjZHSFY4?=
 =?utf-8?B?bCt1dkpHRGkxOWRKbk5zNGI2Z3k2STBLV3k5aDVlWkhkWnVabTl4NVJvQVRs?=
 =?utf-8?B?RXhnRFkwL0xzREN2VDZrdkI3Q0lhMDhCcWdKckh4WVRTY2NRZm1CUUJwUW9S?=
 =?utf-8?B?UTB0ZUN3RVd5bWM2Y3gyM1ZXMUpTSmZMZENzUWg5V3o3TkFqMldlTzVDaFQr?=
 =?utf-8?B?SUUyM3pFdFlZZkZEK2tIRkd1U3V4VTJOeU5yMlBDUDhiS0kvY0pPWlZ4VXVo?=
 =?utf-8?B?eE16bUF0L3h3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2EwbW1aOGZEdXJSaXNncHNRUUcxelcrWUNDbmJ5M1pISy9idmFmRjlGZFA3?=
 =?utf-8?B?UVpmRFlNZFNYK21ORVgxMEQ0aGVrSXd3U1VIQkpjUmRvajRTRVpITzJNc2lU?=
 =?utf-8?B?UWowUFdSQ1phK2QxeXRkVUJkU0lWS2V3alcwTk5rdmJIMFJhNkVSdG1RMHdE?=
 =?utf-8?B?ZFNpWWpTVXhnK0tLUTZaM21ySngzRFk0S2RPZC9BMHQwRFlKMjZHUkZVMlVP?=
 =?utf-8?B?T3pkcUE0RDA2cEVIYUlEbnI1dFVvaEIxZFN2aFNwTWVENHBYMGlPUWZxSTlE?=
 =?utf-8?B?MVE2YjcvR09xbVQ0dUJkVmdDbWZ1NTBDZUtLVXZtOEEyK0orNEJvUVY5cG1E?=
 =?utf-8?B?SHQ4K3d0OEhSaThhUTBhdUF6WDFGbVF4bUtJMEMzNTMvNVJpdjVxUzY0Z0Vs?=
 =?utf-8?B?bFJGWWgzcHMwSXpreGFJVENMbDgrZGRHUEl6VGVBbUorWXdLUmRBbVkvU2xa?=
 =?utf-8?B?MmdvMllmQWlWRDkxdFM4ZXdhMUVXbjU3aWdIQ0VqOG9CK0FQWnZ4ZUdJZEMv?=
 =?utf-8?B?dWltdWNRQ2Y2dVAwVXZXa1NaTmgxcm0wNitIVHdIMGlNY2ZpL0NlM2pnUUd0?=
 =?utf-8?B?WG9rbDg3MVk2RjU2UGJlcW9Xay8vbHlGQ2F3eXZoUUprMEZyWVJyUmZrUTVy?=
 =?utf-8?B?aDl3b0VMK0Vucit5dFZIbzB6VS9VUEJJTERxa2JWdHhNUFlKVHIwLzFOSm9T?=
 =?utf-8?B?SXVmaDNkTUxVZEpxb1NnbG5hZ09rYS9ieGgwc3lsaUV5a1RZazJTaHg3KzJ1?=
 =?utf-8?B?SzdBUDV6Mi85RXFxUlQwTHo2NEJwSHhnMmpPdSsxSjN5MEQyMDA0ZnFvODQ4?=
 =?utf-8?B?L1h1NW5FQ1g2Ym1KOXRXWTNLdzRpOEo1Q1Zia0dVNUNmYzBNbi85dDFUK2Zq?=
 =?utf-8?B?NVBvRDZERlZlV2hGd0k0VHI2eHEvRTg4YTZIdThFeExTNTR3QUZrT2NYMUk5?=
 =?utf-8?B?VVhFOE5HMDdxRjNrRDVNWjZYTjgrRnlrc0MyTTNKcXYxOWZCYlZQOVVsSlFn?=
 =?utf-8?B?WUo0aUcvd05FOTRycWwyK0dnNHlmSXZKZFRvT0RRdHFTVjNvWTIrQUI4QVA1?=
 =?utf-8?B?S1IraU1YQmsxeEIyR0Q0YXFQeHM3RE96YUliYlpYa0hKUzVFZzNFVG5pVUN3?=
 =?utf-8?B?U0ZTdlp6a3ZNc1c3MGNQaVF1K2kzWmJKSXBsQXVrTmcvb0duMTFvZUxMZUd4?=
 =?utf-8?B?cEoyb3JwTmlmalNkYWhrZHZpd0RjNlV4b0JjMERHWVdVRkdiU1ZFZmQ2cUlz?=
 =?utf-8?B?UXA1YW04bTBIZFcwSFlpRXEyT0djNWhuY0xnSGpZekRTTGZ2Nzg3SGJhc1pv?=
 =?utf-8?B?RWIvYWlNaVJHOVZuMFdhZ2ZKTEpIVXBSb0tsUTJWMXV5NGU3em9LYVUyZUE0?=
 =?utf-8?B?NWc5dXU0bjJqNnV3VXQrWmtmL2R0OTBIS3ZMNEFtOVVXOUxkUURuWXF6Y3FX?=
 =?utf-8?B?NUJUa1IrMVhndzdnb3Z6ZDI4L3NSTGI1Y09tbTJvODRmN0dYdHp2MUhWbTQy?=
 =?utf-8?B?YU5mc0Z3OU5HUUxTMjYybThueHhxRys3dEtsdzVVbG9mNnhGdUZSNVpUNTVi?=
 =?utf-8?B?S0hlaTBPTGQveXlPMkZIVGhObWtESENCQnJuaU5QREdmcWxVdVNLUC9aQzMw?=
 =?utf-8?B?bXo0RUUzSkpMSHBJcFpwWGwrSUhjSVBSZm5vSnRHcW81YVBWNnpwN1NhQm5h?=
 =?utf-8?B?WEtNb2pEWVN0V2F4OFhLbWRsYWs5OGtwSldtcVJQcWkxZlFXckR2d0F2VHc4?=
 =?utf-8?B?Zkg0MWJPa1VyVXBnYXZ1bFJWNnMwdEJ0NGRrQ205QW1MSTNORTJTcFI1NEJW?=
 =?utf-8?B?aUFqUzMvZk9lVnM1TzFTVS9mTHo3WUh6K3paR2x6b015YU9maGNDWTZGTjl3?=
 =?utf-8?B?TlBrU3NSeUkrek9Ga21wd2FmRCtCQW1NaWlvcG1SYkE2YjJ6SjFrWWpmNmM0?=
 =?utf-8?B?R1FMbE9IbUo0eTBaWUJteThCbFgwN2Y4NnRkcEZYNGt5bFJYMEZCRXpPY1ZL?=
 =?utf-8?B?bWhuSzZucFYxN1pKSk90NVNqWjZJNyttYlc0aUIySkFYSGVVZUdDakhGb2Fv?=
 =?utf-8?B?cllpeG5PekVJU0xhbUxnNGpTbndwbVpVdGpOaFBKeDhQTWpRQ3pOZHdZaFFL?=
 =?utf-8?Q?vu0Dd+rxuHzBCN3JqMVeXeCA0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf7bf96-9273-4700-8c67-08dde5268752
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:59:39.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWRWl6VGGu2J18wfIlp70SpN0xoAAF3/kGpYwxWtjXt51zvjhopyqrI+/vvWt4mXVkcdv49wDYOnFv0gsFFzGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6899

MISC protocol supports discovering the System Manager(SM) build
information including build commit, build time and etc. Retrieve the
information from SM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index a8915d3b4df518719d56bfff38922625ad9b70f6..464afeae8267d8c1eca4c4d5e008eca6d741c6ff 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -25,6 +25,7 @@
 enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_CTRL_SET	= 0x3,
 	SCMI_IMX_MISC_CTRL_GET	= 0x4,
+	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 };
 
@@ -65,6 +66,15 @@ struct scmi_imx_misc_ctrl_get_out {
 	__le32 val[];
 };
 
+struct scmi_imx_misc_buildinfo_out {
+	__le32 buildnum;
+	__le32 buildcommit;
+#define MISC_MAX_BUILDDATE	16
+	u8 builddate[MISC_MAX_BUILDDATE];
+#define MISC_MAX_BUILDTIME	16
+	u8 buildtime[MISC_MAX_BUILDTIME];
+};
+
 static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
 					struct scmi_imx_misc_info *mi)
 {
@@ -272,6 +282,33 @@ static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *ph)
+{
+	char date[MISC_MAX_BUILDDATE], time[MISC_MAX_BUILDTIME];
+	struct scmi_imx_misc_buildinfo_out *out;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_DISCOVER_BUILDINFO, 0,
+				      sizeof(*out), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		strscpy(date, out->builddate, MISC_MAX_BUILDDATE);
+		strscpy(time, out->buildtime, MISC_MAX_BUILDTIME);
+		dev_info(ph->dev, "SM Version\t= Build %u, Commit %08x %s %s\n",
+			le32_to_cpu(out->buildnum), le32_to_cpu(out->buildcommit),
+			date, time);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
@@ -299,6 +336,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
+	ret = scmi_imx_misc_discover_build_info(ph);
+	if (ret)
+		return ret;
+
 	return ph->set_priv(ph, minfo, version);
 }
 

-- 
2.37.1


