Return-Path: <linux-kernel+bounces-772695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF5AB29622
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914DF3AE198
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35B7237172;
	Mon, 18 Aug 2025 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n3X8wVce"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4712451F0;
	Mon, 18 Aug 2025 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480398; cv=fail; b=kN/MaddnBUocHwdzssPPJwpAoncwBlSAKx+XXXMkPHg7FjONUNC4P0SXugzuW3gAloLQCt+MO30qxh8oUQXCcdzozFmYBzcvSR3Wp+5nOg298t+gKVx5/VuAVp/D4ji/rYhtTf0IqQXPRkOd81sf09OV0ItcPIFwyQmiCyRLTHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480398; c=relaxed/simple;
	bh=l5lPXx3VAKBYz3C1vzIEqg7BgG6Q6eckFHMLLdaPAeA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YR04gsIUIiVEt3m2UAa6/NBQB6hXNBF3y18YyRV4HaRUslE+BWbf+UOCrV9hvVh741m2LXRP1RY35lQpTtH6h6keoxB8RAFCqAQKANDnlK4UvTpbJrFJZU+A1NeUyzSwfbCorqCaxahO6DDebTUkeHU4reHqx0I1TrmCkYgSThk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n3X8wVce; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHKaxtMlkkRU36tCPP68YMQrcespbEPGiXewcSo/K2pZ7CruY2jSGA7x1yeAWEJLRZ8RJEf9Fbq/ltS+e8ZVAZ4DKg47p5i+MsgxCS2OTdM56qnJRIH/ZJpYz1vNEeeSaZoyRJ8Yfodm+k7Q4bniriTJnTLkoPUOIOqzC5XxENCTv7Qp/COwpfK4SQjBGa1+FMmVD3LtJZy0Cx7VNjyH4xikVOD4I80ldahR3uu5fCBGBGkGook4gsPjIpKd+uq7NidTd9zjniRJTkLodYIuuRcoWb/DUj7uwo8Nt8ofXFC6bR2ZEbHvLLL1NUiwgagpfXDuGc2FagPws4S5QMMQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcW7GzptXmtBu569CEveEnv7/WpK4zFiNCC7R7A7AxU=;
 b=pL4665exGmMnMPS0+9hzml/H0Tc52+kNj7wKbzJgRA/Hxnr33LW9zYzzcKw23v9axx8owo4xHzkbCtrZO2ynWtk3NDYYcODbI0ykFq1+pp2LSuz+8R4zopnXZ6WkYqSGEbRkVLE4lj8u6x7rt1bAYbKy2vOR/tQKdDDAcLK2aBtKLkcZCYEAaLIEpa8OIZyy9u/Ttq4n+qQtjYXQUmAJoG5MChdzB+KswwOPUxW0HxHjxFzLkmoeRA7tzn10gfL6kuDGB/O22CwK0hIiyuTkRJV3FQw1YzP83UQ1Shdr6RI5qv7y8DBg6sAjTa96DoYFUJwiAgT0jkZ+SlNERdrpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcW7GzptXmtBu569CEveEnv7/WpK4zFiNCC7R7A7AxU=;
 b=n3X8wVceK+UlTyZMLcquGvocNDQ8PpLERW32abHQvhq6gig5mEResCGMrsYJgXBhdVnKT+ixw7O2XKdw5oj6wZF/6yb3o+MBt55ZQsTGl+B4ShcZzkOl16mHwCRR4k46BkGo54TKCP0hd53Yru3hXdY6cXJfEu+GsjS3r6fzIBIEfTdo8VwdJ7iktgnPFddISA/S5xbg5+osxkJfgprHZd6a+ANifWG8bcI43FUX4UhCGTnqeRbUJj1Pu57c9VVSwdeIi+ARNB8dgFi1T5pBPxbrXca93yDJPNHP4PhKCSdn2pXCBVo3r3hUjmfqR+JgyZxR6Jv47LnzqLhhEh6Jrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11530.eurprd04.prod.outlook.com (2603:10a6:102:4e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Mon, 18 Aug
 2025 01:26:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 01:26:34 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 18 Aug 2025 09:25:41 +0800
Subject: [PATCH v2 11/11] arm64: dts: imx95-15x15-evk: Change pinctrl
 settings for usdhc2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx9-dts-v2-11-8ba787fb5280@nxp.com>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
In-Reply-To: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755480344; l=1479;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=wPG8ZujBt1mtzROCQ8r53MirnjXZ1jm4rkiWQ04DbvA=;
 b=dIzqcoMC7EAlU+1ld645IWw9UWGd/YEyHPVDIVx8usb8D3/D+nf0VnheIliJ0ZeL0uki54PTW
 pCUUmYP02uDC7eNhTU8WeEXuq7jGuI1YQ6+kJ9g/kDddJanASPwSHUi
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MAXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11530:EE_
X-MS-Office365-Filtering-Correlation-Id: 4005398d-d90a-40b2-f588-08ddddf644dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXV4QTgzZEF0eWNFcHNpb1crRU9Gclp0L3ZEczlPdEVINGlwMG4vUXR5Vi9w?=
 =?utf-8?B?bHhqbDRRczJ3eU5XQXZBdmhKRHJqTVZWODhhd0pyYi9yaHVTRTAwVXdBaXJ4?=
 =?utf-8?B?VllTVTNZLzNONHR0bmprWUl2dE1tdHZ4UzJXVzNaUmEwL0d5cytzOHZqYVY2?=
 =?utf-8?B?clVhVnNRZG8vRWx4S083L2dVaDhwTEZOb0N3b3l5NTBFS3VuQ1VoUzl3TXVN?=
 =?utf-8?B?cE55VTdZUFNrSmlTNWJzWEF2dkdJTVpiRjFoS2JiMXV3dFdmUnYwb0dQS0N5?=
 =?utf-8?B?QTBsODBmOTU3SFgvS1I5UHRBamc0a0RjQ2dwNitrNCtjNUZvV1R4aTEya0Iy?=
 =?utf-8?B?ZXA0MWtLQXVZSU9LOWcyTFI5M1lES2F3M05FdHI2MksxdUhxVkRrRGdEOHRW?=
 =?utf-8?B?ZlAzN0d3V0x0aktBNXRqbVV4aFdOcUdCVU9xWmtLT2FjbVFRdVZUMEdRenZE?=
 =?utf-8?B?cCtMQUJwQzBaYnBNWjRybGcvUU5iUnN2dmNBbitCanRCS0VEWXRDWEVsT0dN?=
 =?utf-8?B?ZzduMWVxazBJc2ZyVnVJYUtHY1RJZWgySWlvNTkwK2tCeEdheXl2aXJLV3pR?=
 =?utf-8?B?dGRHU0ZoaGg4YVZiSi8rWE9jTm5hSlAxNlg4aVFCbjdXT0JkZmhrRnBLUm8w?=
 =?utf-8?B?RWtPVmRoWlRzWWZQbzRnY2lLN0FIUXdqRzVUVytFM2xpNHJYaUQyaGU4UUMw?=
 =?utf-8?B?c2htbEtySWs5QUd0Rmhibk1SR2YyaFZKWXBLVmNvRWRHMVJ0S2pxMmgvS1g1?=
 =?utf-8?B?d3JIcS81ZU9QYXpBZk5Ic2JCSVNTSzVadGZnRjNZcG5pRTFYUFRsUFRjRUMx?=
 =?utf-8?B?N2ZWT0JPRHBkUXhQRHJsQ0JxYk1najZMOW5oQkVLSDgyYi91a1hDd0l2MnNQ?=
 =?utf-8?B?aGRpL1RmZnJDSzlab2V0TklQbjgvWTRyb1UwcXU2Slh3ZjdRUkZGMXc1cGg4?=
 =?utf-8?B?eklVV0c1azJGNFpzS3VJR3o0UHcybEMxcWFGMXozRGhkcU9KQmY5djQvWTND?=
 =?utf-8?B?MHJGVldhZ3NQcU5kdXJYcTlYbUttWElBV0tVSEM0ZHhjbm93emVwaktvay90?=
 =?utf-8?B?NUZubWorbmVkYWMwOEVqeHB6VGhtVkQ1T2VGQ2FXMUV5Y1hLVHBIRjRHM0hV?=
 =?utf-8?B?czM0eXY0NU9XemRlUk5VdUZNMExPRXJtQVdTUlRXdFpRK3l0S05BTDJ0c2R4?=
 =?utf-8?B?K1orYlBqVHdCSmNuWEpnbmFUMnVFbE1TTjdwQTRYU1lSdTQyRUt1eWNVUkFI?=
 =?utf-8?B?MGdYL05iTWRYSEdEV3hHejdqVkErcTRTZ1oxS0VxVUJzMkFubmIwcldZWVps?=
 =?utf-8?B?V1JlTnBWTjBUNkVoQzllYUFrWUlYcTRrRjgrSkpEa0ZXYTlrdDl1eXpUblFG?=
 =?utf-8?B?Smd3Qk9hOU43bWNoZk9DYTZKZGFzNW9CRGFCa0x2WVUvNXV4SEpaUTdBSU1x?=
 =?utf-8?B?MUxrWEIxeFVpeUQ2YnluQ3IzWmlXWi82a0k1aUF3aUN3WEZ5bUYzVEljZ2Z0?=
 =?utf-8?B?Q3JDemx2MWdLQ0VBM3RxeVhSSDN4dmdUdngvY3JwdzhHT2E1M3VkbkxHOSs3?=
 =?utf-8?B?UXFUSE9nTlc5SG10RUowbWtka082MEN1Z1p2Wnc5UVJPYVMyRHZnVDIvbW1B?=
 =?utf-8?B?SWJnaGZHMzhRMDZWdkFhODlZZUNUY2IxVFFHK0lyM3oyN1FVaHcxRVduTUp5?=
 =?utf-8?B?UEdNUWp2QnJHakFzV3E4NGZ3TFF5aTRVZG1nSytmRlZpWjVadVBWWlZ0elZq?=
 =?utf-8?B?UFlKeG1xTG9TdSszVTNON2NtZkw4dG4zeFgra0tYKytZSUw4Z2ZGRnhudUN5?=
 =?utf-8?B?TUNJKy9SZW1OUjZ6b1p5N3FEUXRKZTRxaC9UWElJLzZBeEFtdVRhc3Z0OUNM?=
 =?utf-8?B?SWpkVDBnSWh4OHE4ZFZzeFUyYlAzKzVzMFdyVng5d3pBL0I5VGM1Y2RqS2RN?=
 =?utf-8?B?T01QS1RjRGs2dGJjQ1c0cVAxVENTcmZFdjhKU3lBTGRtWVhValVtQzJ4d0Rk?=
 =?utf-8?B?d1Y0LzJyMmJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU9BSEdPSDk5Tk82Qkt3TnMzaDhtS3NuYnRmSGt0cDExRGhMa2RxbVBrMmtI?=
 =?utf-8?B?QmpVeU5Yd05keDg1UHhzeW9YcDhnUm1xTVladVcwUmpZenpiOUxFVzROS0t0?=
 =?utf-8?B?cFUzT1F6eTQ5R0p1cUJDTG1sTkl0alJGT3lDZEp6dFNKdU95TzdhbWlnWTU5?=
 =?utf-8?B?SW9nTnNkVlorMjljTjdqYUMrTDhlQnRMeGExaDNzdkRQRStaZVllNzlwdE9C?=
 =?utf-8?B?Y3JiSy95emVJbVMxQW9sUzJ4UkhxU0NiV1lsOVVxMVdBWkc2eDU0TGtlYWEv?=
 =?utf-8?B?WmQ3SXVONnd1OXF0ZHFrZmNFQ0ZXU01XL0JHQ09PR1Ruaml4R0RnVy85NUMw?=
 =?utf-8?B?ZFUvVlU2ZExkd2lEUFI1SE80Zm1zVTVSaG0vYkU2c0V3OVRqamw5SUxXKzlH?=
 =?utf-8?B?UWQzWDNGUmhJaG1rOFJkc3dBMUVzbThJOWUrUjBPYWpJdTlRT0g0RGVxcFd0?=
 =?utf-8?B?WTcrUHNZVnBQL0RMRFFETlRmZ1hRcWIxZ21iTDQ4Z1hENyt5d21KMWVkK0p2?=
 =?utf-8?B?K0NRRGZHN0l1VFdJUU93Z2FDUXZGNWRyK3lUUWxwWHJjU01yRVJjd2NJZmpK?=
 =?utf-8?B?cEQ5bktpRzMrS0U2MDJqenhXYWtJU1l2WWY5WDF3WlVyTGptV25ianZTUnRo?=
 =?utf-8?B?ZnRhaGZRWDVnb2VlQ21TaTBDVHdRVWVkd3JIN1E2L2JpQlY3eVl4QndHY0Yx?=
 =?utf-8?B?TTRFSzY3ZkRydjd4WHo2SVdxbWRWNTdhUUN2czIrQ1h6WExlb3hwNEkxWjcv?=
 =?utf-8?B?YUdRak5CR3RUM3lxdzdRRzZOYTkrUjlEUXRObVVJMndPanJyMHpkRE8xK0lL?=
 =?utf-8?B?UWJnTTF1aHA4WmJsM3pnRm5lMXlrM1ZuK1NsMVlqWEZ5Tk5KbUpwTVhGV3d0?=
 =?utf-8?B?cngxSUFMdXFraml2V1IxOWR0R1BXMGFidXA4c0ZkNTBBdm9QL2RUa1RLSUJR?=
 =?utf-8?B?dDlMekNrTGk5WE50ZnhHZndRWnFTT0tQVVlncGFWRzM3ejNZN2FTQWZaeUxr?=
 =?utf-8?B?ZG5ZZ2NzZlF0SjhmR2NwdllxeXcwS0dnOXIwbk1kdXBGVkg2YVcwTkFqbWpa?=
 =?utf-8?B?Q3JwQ3pqc3JQMEs2ZTE0NG92YXRpOG00NzhuOHpEODUzOEY5cFhNd2Fsamx2?=
 =?utf-8?B?VzAzZ0hZVHI4TFdRckJDT1NEWTdmVi9RakUzZjZkNnR2bC9sblhpYlF2SWho?=
 =?utf-8?B?blRiWHZLUndJdkRsVUp1OU5tVHVKZWhIQTA4KzZRejhDZ1VBNGdmS2pZeXRN?=
 =?utf-8?B?K3RVWjZEQkJXNkVNODNQa1MzbDlMSUJEZ2k4aG9kUG5SazZwL2pYMVZxOHJ2?=
 =?utf-8?B?MkZzOWJHRVpUQVZueUN4U1R6ZHUvRWsyT2k0OENmLzRtTHBSSTZ6S0RGdkp3?=
 =?utf-8?B?WDRmVi9Nc2FrSVkwbjNadzV4ZkhkdkEyRThnV09YUUN6Z0pIbVFGK3I2eWlk?=
 =?utf-8?B?MmRMbmcvVU55UXhneitwNVJMTzRZYnFXUjhrRjYvU0FrYndMdXhNQW5DLysz?=
 =?utf-8?B?TWM2cGFjV2ljT3Z3ZU5RdDM0WTJJUWRUanE3SHMrRDNjS2VZYitMbXIwSTRy?=
 =?utf-8?B?dURwVjU2Y2QzY3BPNzBTRXVTTTZXdTcvS3dvMkUvR3FRaTdTb0tyQnM3RkhN?=
 =?utf-8?B?VmdMdHkwWmUrZVBOUmpMOFNIVVoyUS9ZcWx3Z1RrU1ZFSVljeUdVL094T3pJ?=
 =?utf-8?B?aURkeCszMXg5dFJ6ald1dUd5MS9MZDQ5amNsWlFRWEVLb3NLUWVCbVBFdnM5?=
 =?utf-8?B?R3c5OERtREswUFRZVWg4RmVyaVZBckhMNGthWFV2S0lST0QwRDNZSU1rMEJQ?=
 =?utf-8?B?Yng4aDFMQkppVm1vbkwzMG1ZSkJaMFBnbzNGN1FXOVlrUU9UaW9lWURoUHY4?=
 =?utf-8?B?Lyt6dEVscm9uYTd4aTh3M2phWXg5akwwZUtNUzM0dnNlVjNJeXFibzNTUUM0?=
 =?utf-8?B?VjZLOXZPWDBoQzZpZUtvVWY0U0hEQUphMEhaYmtlT2VTcVM5eG8vQUYvN0dz?=
 =?utf-8?B?U0Vsd3loenJVTlNmOU5qQXZyQjVId003VldCREh0R0RTSkk1d1dtZUw5Qllu?=
 =?utf-8?B?alRlOTZMSXpjRVp3UUtqTlVjTmd6UGl5S0t5SlVMYVBtcGYrendJMW9ERkF1?=
 =?utf-8?Q?P/L93DsggH/tUwDSNrirEEFkp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4005398d-d90a-40b2-f588-08ddddf644dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:26:34.4778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z300rAYe+zL0cceV2rbF7T9Gl3y4q+r8koopq197kl/gbyZVrkm7tC9mUm0IEcvMxyH/zdrWr/UIpU5qlxrI/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11530

From: Luke Wang <ziniu.wang_1@nxp.com>

The drive strength is too high for SDR104 mode. Change the drive
strength to X3 as hardware team recommends.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index de7f4321e5f9d7d6a6c46741d3710756dd2b69cf..3c23022923e68fe0f5205d322ad6f8834a46dc56 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -881,12 +881,12 @@ IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
 
 	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
-			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x15fe
-			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x13fe
-			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x13fe
-			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x13fe
-			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x13fe
-			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x13fe
+			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x158e
+			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x138e
+			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x138e
+			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x138e
+			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x138e
+			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x138e
 			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
 		>;
 	};

-- 
2.37.1


