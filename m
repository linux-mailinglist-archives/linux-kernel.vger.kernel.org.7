Return-Path: <linux-kernel+bounces-770551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F75B27C50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92A71881F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A626FA5E;
	Fri, 15 Aug 2025 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Svyfvu9B"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013054.outbound.protection.outlook.com [52.101.72.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747932701DA;
	Fri, 15 Aug 2025 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248676; cv=fail; b=EJ1GYog7AXgpf2bXzv8TGvpGmG2L5KW+xHQUtQW2mzfb/PsnhA6gOzmpvlDZxr09+u/NUeVp0zJ2yA00Pd/L26X+En8eOws/A19ZkgzTDOP4Y+uxPIcDPDOBWQW9B6NP/6pZgrrqW5PPNG/2+TKU0K7sX7C8318vrjndATEvIC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248676; c=relaxed/simple;
	bh=w/pcws1S/wbHmCCo5wKCRut69inpBX2ooeClsr0x/4E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HaorGjdRIrxf8V0Djo3Z7TMbKEuXPhmFIIdLQzqY1mvRNWdTqjGwgMxtAbPHJYqyskzvaaE5STivDryOZWdlrIHAteke0HqOs3178dcvqhNgtSXgWS67gf7oQuBdccFMx9D9A6jSS+wuGI6GFO84VFurhM5r/v2s5tcEt984Aqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Svyfvu9B; arc=fail smtp.client-ip=52.101.72.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NK8bubY6QdQP5JoHQNRTLlxpb+B8F69RRAiujtIEiP2qm2c9BcBy8+Ig3ee1SmxpNN2bwFXHznoGQQciWgxnEdsj5Y6LWF0wEpYi2pSZWq4R4BcoheZ207JJi3uDuQDNqCqS7RBIFqTOHOPTakWx/pkR4WxnG/O/jqRtxoJb81vRA+6UaZh58Vs64DTaAZWaSIqvy6Sl3GTTQnRctl53uJhFajEPWjtaMUhKECbPk4KJRnghpaY1IotIIm4v7pVArDEzHN0llIJ/SC21rt+L6U4FHg7Jihlm7TXYMzGuFa1Qh5DcgrRcSq1rFW/P22qAXm73K0RSk5v+RkCw4ej15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBZru+1V2pxaEvBhtspvmCdDdin6xC8tNMJv4wtJMe0=;
 b=BPONHm0w8XL4cRP3pBg2c/VmMKMrZQft+AYhtxVbX/HImS7WpLmhNE84/U2kke0Wsr/31LvYj3VOz2FLJkfX+mZPSS/C/dkVuAvGSWFpkaygDPDUbF/tR1hzS36J3K5OtMVq/EiO3ly0fW+cFxnRSGvBmy+uxCG/rLBxCgQ1Z/cp1SgHw/Pab6dLPGi+3UBAjDrTWTnPqkzU/qMwpp2Xg5K4x4h0hG1DEQ4d2OzMZMuLbDM2jEgh4Pet2FCfhy8UspSEeLdeA3BEcUqwDnJN6cpS2rWTB/tdsTAs7mtm3vZSS2I3gPVyuirdBzr9+IZ4et6GeYK8DdDyLkD9Dr0fqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBZru+1V2pxaEvBhtspvmCdDdin6xC8tNMJv4wtJMe0=;
 b=Svyfvu9B1hQ/Oap62TDdmILVk3iH/lJCLjntP/acgL+ASoxv1IYrC85OOIkm6Uk5U0rFG5RDIjQy2+n0iBCUnSn85IMUkpK9D4OQeu6f1Oqwju1G1Py2Z2GgkRNN832f29ypJ1Gb4muk7IXrL6MNrmVs8V9YR2ub07f+rNNON5uHY1ZI1LsPWuXAcKJr8RXvRiPZuIuZiPQBUEqWw/D7ZCHMX49JZY0RS7KGjoy/2CmWjjtUhICany/IJVBgSW8JoIJhAj6K58ThsKP+A0edpicz462WyyiUwrkpKLCZTa9q5slwhF4T3zj+zLi0VFTwSxXn6LOXXPFT+BQB56ZX1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 09:04:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:04:30 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 17:03:48 +0800
Subject: [PATCH 02/13] arm64: dts: imx95: Add System Counter node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx9-dts-v1-2-e609eb4e3105@nxp.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
In-Reply-To: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=963;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=w/pcws1S/wbHmCCo5wKCRut69inpBX2ooeClsr0x/4E=;
 b=bd2K0mUIwWlIuY7/HL1D1rzN20MygLBkhdGjF2hijDmRepPI84HjsMBuGaaUAw6qbQXWhlUOw
 zIjyKJV7L30BP92A6/YZ/lbyzXD29QF68R/27REVdwppvjQG5hkLDBv
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b862741-360c-4961-bc93-08dddbdabeb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkZuOXRKWWlGd0pzeE45czZGenQxMUpQMFlpMytTbVdELyt2cU5qTVFGRTZB?=
 =?utf-8?B?clhycXZvZzMrNUt1WXVjMStmTnJlRWU5K2NJMjdCcTlpMExFZ0MvbDRHMlFR?=
 =?utf-8?B?L3Z1UTlyRlFldEE0Mnd2Sy9YYXhxL3E3N3hQNEVGeGdteVg0VHhZVnY5V3hI?=
 =?utf-8?B?d1FlN3VyZldTZk5yandXMVYremlFSkxKOEVCcHRRYU5MdEQvcWh6WkF4SEtN?=
 =?utf-8?B?Vkxmc2Nvb3ZiOFV3bjNVaUdsSmtuSkNvK0wrTE9VTEdzWVcyRUF3VitlbDZG?=
 =?utf-8?B?TW94dHMzZE5BU2J0QXdQVVlKU2lyTEpwU3pqK2xSMWk2citJR2UvamZnemw5?=
 =?utf-8?B?Q3BVbDJ4T1NJeWQvdE0yaTdOWC9FSDBtYktRTStKa0VQZThRZ3RJYmYyUm9Y?=
 =?utf-8?B?a0F2M3d1QTBwZXVxMXd4SHMzV2FDQks0empzakp0a1FpQTZaN283WWJzenpw?=
 =?utf-8?B?cFhNTUFDMk5Iem52ZnhiY0lZenRIbGp3Yk13QWpLQ1BraHFkdlpseWdBMHNj?=
 =?utf-8?B?TVFhZHRLUmY5MWVEVWN2dGlQdXZ2eFhocFdlUlRWbytuWGRNREZZY1pqUklI?=
 =?utf-8?B?am1pWE0zRVNPTzRTMEZSa2xnYWh1T2ZwWmpkYUZDeFFvRXRJdjd6NzE0N1U5?=
 =?utf-8?B?clE0bUt0UFBReXFJT3BpY2FwYUcrcXdJdGJrNk1RUXh6V25qcHc0R0RUelI2?=
 =?utf-8?B?cU8zdkUwb05zOWwyRnhUdy9PZXJUVDY4eERDemE0eFpabnR2VTFmWHljSkxh?=
 =?utf-8?B?ZHM2cWZ0SHg0cDYyS2M1aE5kRzYrLzkwdEV6V2pxcVBqVW1RTTE1VlhzODc5?=
 =?utf-8?B?SlBNKzRZdVZod3VDLytqRXFKOU1DMWd3aG5zQXN0VXhzU2dWL2FrbjcxTm1S?=
 =?utf-8?B?QlhiR0lpNHh3dUtqSVZES2RpZ0U0RW9aWE5NRTdBY1lQV1pETm54bDlESlps?=
 =?utf-8?B?ZTNVTVEzVWhzNlpJM2g1a2h2NEQ0U2p6OWNncERYTjI4amdNSnZxaCsvNkVs?=
 =?utf-8?B?UFlQeCtHUlJGYTdIQWp6QmkvMWNCY2dFazhOdzE1TXZ2cWNRUTdaeWpLZUxY?=
 =?utf-8?B?Z2dxZTVnZjFUdTJsWkNwTkdEdDRIYzRoUFc2TzV2QTBtVUpUVzBYQ0FEUVZ3?=
 =?utf-8?B?Mk9DYnhpemJCb2JQbW84OXI5VXlTT2E2U0Z0ei93aGhaaml3R1U0MENibTRM?=
 =?utf-8?B?dFlTTWoybk1PT1JoNDFKWlRpeW04VTl6cWczL3RaWkZXOG5UY3lvNUNVTkZM?=
 =?utf-8?B?cjY3ZlFVWXhUY2dqUzl6KzByY2NHbU5QOXVLUWlTQnpFT3pFcmVQei9uck9N?=
 =?utf-8?B?Z25UZ0NwR3hzc0NMOTdJV3FHc2plYm53ckV1aDBBd0tFYWMwTXNBMnltUDhP?=
 =?utf-8?B?K0IrTitaQWxTMk13ekxudDRBRVlWNXE2NUo5UFJKeC9IdHJmclF1b3ZhZVZy?=
 =?utf-8?B?emFFUSt5ZUN5b014RVcwNGw1dW1ycjdBRDI1MUlYU0d2NEhNczhkNUhjdGhI?=
 =?utf-8?B?OGk4a1l3WDJINy9uejNsUTFkWmFhY3ZmNUNFL2QxMXMvVzJueitmZVgxZXNm?=
 =?utf-8?B?ditxWlhPLzl3U0RpK1dDeFlwdUxPWDBQZ0JETFpZbFZ2WFVYUzJYdmhDQlhP?=
 =?utf-8?B?THZyNHpDVk45RFdWUGYyaXBqWFFLenA1YW40NEo5NzVKNVJKeWZYS1RpT2hR?=
 =?utf-8?B?aVNqMTVoVXY2M1YyQlpvZElIY1drTXU5MXRrOTQ4NXNZMFJST1EwL3FzREt4?=
 =?utf-8?B?RjRHOFBGdVpvV25qTDJhc0RmLzliQmZGVmhTdi9BZ0M3aDRKRU5GWFE3UUVz?=
 =?utf-8?B?OEoxd25yK0tBU1JwUW9ubnlTVXNtTUFLd1hUWW53dzkyWFJId3lZM0F6S0Ni?=
 =?utf-8?B?ZG1pOXM1KzdtM2NlZ08zekRGaWtXdGhVS0p4R2YyYWV6azkybmZkSGR1S0tE?=
 =?utf-8?B?d3UrRzFtWkV5WVg4cUdLZlBZRk5BRENPK08vZ3FGZVhKT2V0RW1PMm5qaWxi?=
 =?utf-8?B?elIrWVdvelh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0kzVTkrNjd1Z3ljQjJPV21GME5nMWFqcDhESUxxNkRoVnJldEtvUmxRbUN3?=
 =?utf-8?B?dGszR0FJOHVTWUwyUkgrRElKaHZlZFRXKytSaFV0TWU1V0xVNi9DcDRvOHVJ?=
 =?utf-8?B?UmEyYThSVnZHdGJPKzBwR2xjS3lTUmJZeVJvTmJ2V05EWll3Qm5KcHczUlZS?=
 =?utf-8?B?T1ZNTXV6RnNDUUt1b1pHVk9CWi9nUGpDS0xNcko3NWxrUDdIamFrWXEvalV6?=
 =?utf-8?B?WXdQdUlRMVdOUDJ6WGpWakhhZnBId1l2MHlySGVkT1JrTTUwaHMwR1lKbUNH?=
 =?utf-8?B?TTRRYXpmb09GSnBmSWwwUkl0cUFDMy91aUJoNDVBVEdKc3R1Z1E5L3pNNDRl?=
 =?utf-8?B?cTd1ZDBMY2lRVGdsc0NzZzNsM01oMERNRmZaWGJNWVZuOXV4QmN0TWs2TEFK?=
 =?utf-8?B?Y01zcWs2U1pBTlF2cjh6RGJsd2JwK0luMy91dVJpUk5sOXhYZlFpNHJ1ZWEy?=
 =?utf-8?B?OWhLbHNuZDJNYUkvaStZYXRreVkvRWtaY1pjTC9lNmRCUXI2RHlxYmNOZDR6?=
 =?utf-8?B?OUkyWnc3d2FoY2ErSFp4SVVSVUJNM0JYRGZTUWpsWDhNN28yMXRPMmNzSjZN?=
 =?utf-8?B?cCthR2NkSEgyMHBhUlhJMWxYYWJ0R21CaDVPSW4vVXNDZ05BTkZRWXJXZ1FD?=
 =?utf-8?B?MVNyTFBjOFNncmhBbjB0UVlvRmlZYU1Ia2Qxcjc5Tkp6Vm54SjZyMmUrUTNq?=
 =?utf-8?B?Z0tWYjdINGh4eFBFTjBGa1VFclZnRXU3UDVjOSs1WTliNUVadXJyY0t5QWpQ?=
 =?utf-8?B?ZjI1K3pLL1F3VUtpVFA1U0hkZmQ5NGJJa2NLZFhWWC95NVlOQldwa1hnV2VF?=
 =?utf-8?B?eFlKVnNqWFpic3BRTW1Tb0dNN0xhSi93T0hRdm5RazFIZ2dNbHdXdG5rcUxv?=
 =?utf-8?B?cDUvQmVTdDI4NjNkN2Vjb1RuSVo0aStHRVpDdVU2SUZ1TnorenhGbVdOejE3?=
 =?utf-8?B?TGRoY1RibHV0S1VzUk40ZWt2L1YzZmhaNmRSYjJOWHZiWUhRaWY5S0ZSV0ZF?=
 =?utf-8?B?ZXowTGlwZjEyZUpZY2JyelkrVzhHdDkrSEtrT0xCZXlNT3h3U3o1UjU1Zzk3?=
 =?utf-8?B?UUthSVhSV0FlY1BLUVlWZCtZTEZPNW9tUzQ2VjBwazNnbEpxbFpOTjlUUFdJ?=
 =?utf-8?B?TjFnOERFMHNRMStQVTY4TEFMVlI1NEgySU1oSEt3M2xMZnNORGtLWG1yaHln?=
 =?utf-8?B?UjV5MURKaGdiQnltMk9QSTgzYTdMdTFTN1FsM1ZtMTUvcXNYdVRmZXFaVzQ4?=
 =?utf-8?B?aW52aHo0aWN2elBOZjJPS3hpS2NQUW1kL1NrbThyOUtyWFV2eEYvVTJrWERQ?=
 =?utf-8?B?NjJEMXFOeitzSVlqRGUxaDFIYmpkZE1uaFQ2K2tDa2RWRXBsL1NwbjdRNXJF?=
 =?utf-8?B?eVNnV0JJMVVKQmxDaXMrTmprbWYrZisrMWE5UnNpZmJ2WitLSEoyL0R0ekxo?=
 =?utf-8?B?Q1VybzQ5ajVuVC9xQklWeUpOY0tRYW1GUGd1RG9zM0trN2RuN1VZMWIzZ0N2?=
 =?utf-8?B?bkRuckxRQUVQWi9iS1UrNkNETUZleVZoS2g5RWtzWGkzcXZvaTdQV285MVhi?=
 =?utf-8?B?enZ0cU1USmdkMU9TUGhkanFSa2ZqcjZlamtHd0FTTFR6dkJxS3ZNVUw4cTFn?=
 =?utf-8?B?eWFIVlAyK2l4RFE5UnNlV3B5VytjdC9JKzhLWWhJN2RPZ29PSjRvc2czcVNQ?=
 =?utf-8?B?R2Z5QVJ5bGZ1aWduM3VKeTk2TEVacFdQUkxRUy8yOXZUUGdLYWd4Q0RCbWVO?=
 =?utf-8?B?OU1QS2g3WHlPR3ppWVg1cCtjS09rWnFhUkd6d1BoekoxeEd0MEJpZEU5dHdK?=
 =?utf-8?B?cE1reEtodDlHVUdwMks4aE5laVZTbUdxMHNGRlRCSzl5OEI0b0F3NW5vQSsy?=
 =?utf-8?B?RVZrMUd4ak1SZGZIYTdwNEwxNWJWbXI1ckhjNzR5MDUyN1FPSlpGS2pKV0dR?=
 =?utf-8?B?ZzZVczhmM1dJRTZBZ2h3MGNyUk9KZWlyR3o5aFpBS1VSdWQwQW9ocVZ0RDBN?=
 =?utf-8?B?WklnY00vMTFIWlU1emF3MzFxVDRDTUJYb0lPUGRXYUl3YzFCUFQ3OXRsb3lj?=
 =?utf-8?B?bGtKcDczYXJvczRSY09iMFdmcVFRU2grSnBsSmoyZzNsZHBxNkRTcVN0OVJD?=
 =?utf-8?Q?KWS47Mw0HwU+y+j+DSTQanAx+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b862741-360c-4961-bc93-08dddbdabeb7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:04:30.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sU4E0LP3TjVHVfJUqFlsp5bR05zB5OT6a8t+F3jRn3CxMC5gcG0XLz+pn9TTILYF0eGDLJaFobbqo9eD3QzCQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

Add System Counter node to support cpuidle when arm generic timer stops

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index dbcc557d07f5b8a0ef27d68b7211b07d26fdb9bc..642dc4b7a4770be50960f53a73db965ea4374e24 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1260,6 +1260,15 @@ mu1: mailbox@44220000 {
 				status = "disabled";
 			};
 
+			system_counter: timer@44290000 {
+				compatible = "nxp,imx95-sysctr-timer";
+				reg = <0x44290000 0x30000>;
+				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&osc_24m>;
+				clock-names = "per";
+				nxp,no-divider;
+			};
+
 			tpm1: pwm@44310000 {
 				compatible = "fsl,imx7ulp-pwm";
 				reg = <0x44310000 0x1000>;

-- 
2.37.1


