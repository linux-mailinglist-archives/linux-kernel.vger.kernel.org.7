Return-Path: <linux-kernel+bounces-861777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A894BF3A51
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F74E18C3C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE36A2DAFD8;
	Mon, 20 Oct 2025 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l/gV9aYL"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817EA2E719D;
	Mon, 20 Oct 2025 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994423; cv=fail; b=IHqm6Q7MmChJXeGB4LBCZ0BSeuBFhPOUPHnQ2XXFHXLU52/0EscM+p24l+Rgdc5hD59Zs8eNwMWc7jDLc+QAXXmdtLzYFK9SflHB0e/5M1fa1OwF+lKgPONIjjh3D8hkEkkKEhlZHJLfcrmw+mSLRCEUfwa04QBViS5sg32OQFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994423; c=relaxed/simple;
	bh=0/+sPO9m4walFVirTgLwEl6dGzcFPeWnC8OZDTjtk9U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rSKQ47KZ2sheYULkLU2FIPQxXYDGl/jjZSMnWpv4EnVOx/vHBG8qvqa9o96W8qEXboxYWNRRFiBYR5lvVtATDxCVh7vy3hLHp+AqgFs9zXksTyGYRJTfbQAubrUOhobo8Uv/vkiJdmFPbxb/5nfy/1CM/CcvHotTuI/rTb5Jksc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l/gV9aYL; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3MGeq4/SRzkkr81GY/y0b4U1ycpfdEZXHKRoYWc8mCcFnjJ1X7XhG2NABJZaFnVIfdcZjIiTPdZsJMke2sqGtKUxDwEpeL9l10+FZuqsPxkFjRwa3XZKdIbT5+tUMejPlUo1Oq8eICn1nEkZuDRxyQv/k7rdgQYzYvrdiXk3aZNhrDgg6owWYbwu3rasQQuvaglhgFEJA6Dy0aoLVc6Jz3MHAV9eLBWJHzwbBHMZqoepndspbtFBdy53/MYe/WWzzf6yRRPlwPpsSETwhz/tC6EBD3fH9N7ReYag9d0BsqWMBSpbilgja1y7FhKXfxIBzekVH+GFAB9AVWxXMZwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djOkWxneHat7Gq10w62jEDbIs5uynPqlIkwKKC3Qx+E=;
 b=FFY6rieaGaWtMwwdLi1oCaR/oQdCYfafBiRvVd5D8i2fHrBz7L0WAsFlNhqdJ3PivfH9ueEexri80atfYp1BYPqliVBcRfy29NpI7YsKTsm+oMyBacIiXC/pPs/lvWh1m87udjbvHP3X8xcsvfFWLsdrxftIUTif7yia2VHIvbA7kL6MCZXA0Q14kegoU5g630RW5agq3iei/tF68Z7aA2YwuF7A9vI43Jy81+0KsZWnN26RFAKCIKtCWOqhdyC+ddJ5TQapmh84i2C9s8/1UDj968FTgAmpdVQa5AbM8eN4+A7hNjWUP+gJMl2DtVk7cS+Xd6ymxPFH4NBVhlbmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djOkWxneHat7Gq10w62jEDbIs5uynPqlIkwKKC3Qx+E=;
 b=l/gV9aYLfH5uZTVf1kbtaKBChNV+vtDnph+lMnh1nlmhME5RelL4otfNT7in8AyFHme3lAz06YyKUYEGKaVtyoBUkyXSega6l2BUjnXmUK5C6EhmoVyPEiANhqktFzsPzkUqHBdLgP6cZrQN7gL3vDCPj35tpK/cMyttiCGN7AqddhVSoGHYOhHYI2y9pm+/4a5eQO87MEcULKVPMfg3hiCVS56T9ciywIgf0PVCSDg40c2p3+AZAjVChRE7DwQxzEMJMrRs0e5L8+1ZwMtAgbbD0HIxeJc4/ziGC8WaCO76V3jwhf2p58AwIBsx8obHyB4wSPnM14GwnlE4xuwAzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8105.eurprd04.prod.outlook.com (2603:10a6:10:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 21:06:58 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 21:06:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 Oct 2025 17:06:36 -0400
Subject: [PATCH v2 2/9] ARM: dts: imx6ull-dhcom-pdk2: rename power-supply
 to vcc-supply for touchscreen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx6_dts_clean_2-v2-2-3c12ead5094c@nxp.com>
References: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
In-Reply-To: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760994407; l=971;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0/+sPO9m4walFVirTgLwEl6dGzcFPeWnC8OZDTjtk9U=;
 b=ipEk3WtUkC/e8GnQfezBiqC1LxOgyDjl5OwYLMCDpBtHnfzMVOwB8/MBNk0fIJPFa5SAMuXZL
 16MtUcvDFFhBPOlHdIo+CfPNsn4tpj66t4ZbVDTBMkX62RXaV3OCVPU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:510:323::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: ac009506-20d7-44c9-8b7a-08de101c9b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmtnYTdBTEdtMG1oRVFVT1dwUGI3VlU3NVhIajJYU2xlMFp4M0RkSEhCOFRV?=
 =?utf-8?B?cGZ3Q05TNkpNb2VZQ1NSd1B0eVVGYnV1NkU4b1dEa25rdlBjcmF0S0FvQ3lP?=
 =?utf-8?B?dWJPazhLblhPaGtmaXN6eEczaEh0MHcweHlnYkJYZjJqYWJZTHljbThPWXN6?=
 =?utf-8?B?bVJWV2NQa2p6ODNzQ3FnRXJmZy9Vc0VlM1FmVXExNHFOOTNnS3RNdVFWRHBY?=
 =?utf-8?B?cWZxRkRHdXp1OWNuSk9ZWTR3M2pTa3RLTHlqdE4wQk9UdTVOYk1vbFdYTDJl?=
 =?utf-8?B?SWJFa2JLSEE4eFNpZmNZSGxEUzdaaHBpMXp5R0gyb29CRURXankva2E3R05q?=
 =?utf-8?B?Rkh4SGVXY1NMRCtORXZHWllaUVdVL1pXSngzcGdtckVMS3hBaVhTd0FJTzBv?=
 =?utf-8?B?eUNpeXdPMzVUclQ4dktqR1dIbEd1R1NhRnZKUnIwNEk0c0VyeTRDOXYzZDdp?=
 =?utf-8?B?Tm1tWklZK05Cb2VEVmpSd0RYWUc0ZmZUd0ZaSzNJZGRyS0lsSURaOUVtS095?=
 =?utf-8?B?bElhQUtuT2pxNTR0ZSsvVTFSdjA1eE5Yd2VZMHpmNDYyeW5pYWpuYW4wZ2dl?=
 =?utf-8?B?WmY5SUZhcDAwVy9RdjlIbktJZ3dUYm9XcTYxSlBXektsQ2pJbTRzQUNxN21F?=
 =?utf-8?B?RVdIYW0zckRBK0JxNm5zY0gvTGtBR2RVZUJES1JCWkluK3ZRRmRzMkd1OFJz?=
 =?utf-8?B?VHB5RW1ndkNSdjNWRXI0RVMyNDhjdGhwWXpBaFkxM2ZucS9Vc2wwMVVKL25P?=
 =?utf-8?B?RkNseWptdlBjeVI4aHkwakJyOVQxZVVQOGIvVlZYOCs3MjB6eDJYaHVnekMv?=
 =?utf-8?B?a1VjM3JiZU1PTWsrOGRJaW02NmVZeVVjRDg2ZzNPV0UxeTErQXc2VENBUEdL?=
 =?utf-8?B?V2QwLzE2bWQxc29nc1ltWnpyYTlDbzlJK2lyVmNoLzNJOTg1MVBrMlVUZS9C?=
 =?utf-8?B?aUplL21wZDh6SUI0Tmt5S3h1YlhzRlZhU0tHcGpicDNLRUZJVDB5bGgrVmNa?=
 =?utf-8?B?L3hMaWkrU1AzOThlNC9tVWhDZldjZmcxaDloKy9ZU3Rac2hPaThlVVMrdDRX?=
 =?utf-8?B?MUZxaHJ3VGlodit5clZQYWRGODRza2NibFl2NllVU2NGVk0vZE9MZEZtOFB1?=
 =?utf-8?B?VG84Mk5LWUJ3L0p4d3dFVTU5c09VQ29yM3dNd2ZmNkEvM0dyOVArZjN0K2tB?=
 =?utf-8?B?clpRMEV5eTB1NlRJZkxseER1QU9wNU1YZm1MbnYwRU9peUFDcG9FOFkyVHBU?=
 =?utf-8?B?WEt0T29Qa3ZvdS9vT2gyaWoxdWMxSFdNamFrTjVDMk5rWEdRVjBLT2R3VkVo?=
 =?utf-8?B?RGxnTm1CQ3NEZ2oyL0tKeDRDTnF4V1hLQm9mbCt3ZU1XWGJ2N3JUL0JMUmFh?=
 =?utf-8?B?VHlvaDVRRHlySStRbEVzTllOZGM3V2NHUDg4aW51d0VKY1YzOHpCdTNhZnZX?=
 =?utf-8?B?aWhKeloxRXdhRk9DNEJESTZFaXlKRUczREVZdzZQQnpEUFE0c25tRHhEOC9u?=
 =?utf-8?B?c2FwazBkaktndU16OEJHZVlFNnBpRGFtTnF6ZXEyVS9ab1pLbWg5RXlZSmkr?=
 =?utf-8?B?UFpGNDA2ajFUdThnVnAwaGdKNFJxRU1tb0ErVk5keUdjdWNFMWhiMXFLL0Jk?=
 =?utf-8?B?T1pmZmVmMENiSWl0ejltVUo1YjdpVTFHb1VmR1psS3NscVY1MEN6dFdPRW1z?=
 =?utf-8?B?WncwUmVmajhhdWczQitoRUhlVmV2c0VjVDhIenJaeVk5WUpENlJWS2t1TGhi?=
 =?utf-8?B?RDgyc3liUmFMTUpZeWRwNkpOM3lUUEZuZDJnTWhoSnN1SXVOeU80VXpDVzFr?=
 =?utf-8?B?Z1VmWGVSRzMzUERXVWwzeVorK0tuWXJOa1BPN0RYN3RWUGxuV3ZUS0tuaUlB?=
 =?utf-8?B?aHM5M21WU1dMZ1pCUlBhQWdJVmlick1XOXMvNCt5blpiK0RBVWZJSW90bStM?=
 =?utf-8?B?Y0Q1cld6ZFdWWEkxb0Q0eG02OFdlR0lLTXc3dWZwMFBpY08yR0VZdXQxb1F4?=
 =?utf-8?B?bjNkUmZEZzhoWTdOVmFEcWRXS2dBWUdFdVJQRFl3OUJsd1FzdmNObmU2eU85?=
 =?utf-8?Q?7kEBkP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnp6SlJHSWlMNjZseGdiVXNvNWlKM1hheTIwL2pTcjE0dDZWWkNpSENWS3Jo?=
 =?utf-8?B?YVpRb05lYnVHeU1sb0dzaEVoMXYyV3VyMEhudFlCTFNKNStGa2l4WW8rYi9F?=
 =?utf-8?B?MEZ1N29WT1ZBQms0eGgvc1M2TlhKY2N4YldxeHdmc3ZXd1FiTXZNU2pBamJu?=
 =?utf-8?B?dG5Hek1INEJ3Y2pCQ1dQek1COGU1NjlvdVBTMWJIOUdVek4wU0pJNEJIT1o3?=
 =?utf-8?B?TCtTeklSbUlpUGJJbnBqMGtLUGgrOGJ5NDEzUmdoU2dUaDdqVU5zeDVRc1lx?=
 =?utf-8?B?MkFFdEJaMjY0KytpNkJ3TE1Xd0tzT3Z4QXpZVTZWdGlNeFBsdjY1T3pQbnFw?=
 =?utf-8?B?bHZOTkpLQytSOU05MDVBTmtaU0kzbEJ0cmhsZzJ6QVk2NzkyUzE1TFlxVXl2?=
 =?utf-8?B?ckE3eWVydTk1ZXpRWnZEaU44R1VOazdzbDB2S0ovL2FLRVIyQUYwemdSd0lU?=
 =?utf-8?B?MnVxclRPZlRsTUZtN3h1N0FWSVNuTDFTb2xMaitDbHJBeFJabWI4SE5Ed2VP?=
 =?utf-8?B?Qm5kTnEzZDVYUDQxYmxyVFk2MWEvbkdBbndoSnd2eGUvSkg0bVRobVRqU2Ri?=
 =?utf-8?B?amVFRmp6SllIeDl1MEVha0VuWjVWRHRvd2JrOU84OHd6SXJyYVVDcGwwTEN1?=
 =?utf-8?B?U1BaNEJzMTBiNTVsM3kyVURpRG9KbnNMRTZvUy9TVGdwYW9EcWZsektCb2cr?=
 =?utf-8?B?by95VmplcG81eVI0MEUwQ21YbzNWNXFNbDJhVGxoVnJhWHE0VmhUUnhFZHdV?=
 =?utf-8?B?VTBLWHFPc1NkeVg4SHlpN3BsNmR4eENYUFprQ2p0ZGwzTGVSdkpoL211UDNE?=
 =?utf-8?B?ZXh0VTdqYWtJVVVDWmdxUWEyYThlTTBtMVFDR1JHckdwTDNOcW9wdER0YjJr?=
 =?utf-8?B?emQ2VG4rdkNRYzhXOEM4eGQ0QzB0b2gzQlFxbnREaGlGMmk5di93WUV1TG5G?=
 =?utf-8?B?bHdVRWE5WGFzQXJwQitWNlBobHdoV1F2S3ZoMWc5bU5WS3pYUmxBVWVhNXJw?=
 =?utf-8?B?WEZRYUxza2J1YTAvRTg1ekpVMk56bkl2SnVkWTNZbE9xRFRQNFZ2a0U1UXdJ?=
 =?utf-8?B?TXJnMHkra056WnFRZ1NDS3JKbTZZWE1pUTI3V2UxU0tzNUJab3V1RWI0MDM3?=
 =?utf-8?B?S1dYN3FSM2FzUmZQMHNIeG9pNGM1WjNTS0RpalBwYy8ySmUrSG1qUm9QMVVF?=
 =?utf-8?B?d0tsUGdrckM4cmZtbnBuZ3g0aEVMTW01cVp1bUtTZDRTOHphbHo4M0JieVBM?=
 =?utf-8?B?bmlQYnRhYjdzV2RlQ3ZNa0dlZVI4dXNRYkVqd0dNMnVURERQMUFQckpKRDA5?=
 =?utf-8?B?bnFoNkYrNVZXWGpNSVNyQ1hWSCtDR3pNZFk0ZjlaR2U3dmgxbDhvS2pUOXMy?=
 =?utf-8?B?VGpuSzNvUGRmOUx1a21JaEpNQWxUczk2TjFYT0dsYkx5UVlLczB4V21iVGpF?=
 =?utf-8?B?THVJVUV5c0FESGJ6MzFacDdCWkZ4UE92cU9RVVU4WWFib1NYMHBVYVhtOTdS?=
 =?utf-8?B?U2EzU09iY0xSMTN1eUF4R2g1OVpMeFV5b0JFT3ZUdFhHSVZkM09qUlFIZVdT?=
 =?utf-8?B?NWZKZlA0ckE2Wmc4RGFwRUgrTHJ1YTYxSFdlRzFkb0xhNUw0b2ZxQ1RlVFFC?=
 =?utf-8?B?V2k4TzQxZit1bEhDUGxQUnYvdnJXcVlrZVk2cFVmTnVtTDllekdkZkZUUXY2?=
 =?utf-8?B?bDdOM01HN1h3T05sS1RLdGVQR0NITnlZMWRHQVNTdWowYVRrOVM5aXBDMnpm?=
 =?utf-8?B?Mkl5K2VoRFpRUW10QzY1SDF5UEpLRWIwQzNTajlKRG9ZckNZcGNSVGY3THNW?=
 =?utf-8?B?VzN5c0JZdXQ5OTJFWEVYSUNJOXNrVmNybUFJM2IrdFVHKzgrZk96b1V5anVG?=
 =?utf-8?B?ZzdITU1PNE5zM2doQUltRVlrK3F6U3JsYUxZRDhSYm81ZXFXMU1EMmczRFhD?=
 =?utf-8?B?Q0VhUHlhNTl3UWU2NUNZNmRjVEY4YmVsTFNKMlAwQ2RBQ1dPY0tqMWhnTlEv?=
 =?utf-8?B?bDgxNzlJQ2dLOWM0WnNJMzl1bVIvZWFQVHZpTkw2c2ZLNE1wWFhuUWRYNnMz?=
 =?utf-8?B?c2x6NGM0UFFQd24vM1B6Uk1QR2tWWEh4dzE1alJYaEF4blhQc0loVldrNzlL?=
 =?utf-8?Q?oPp9h274YS73AqMApopdNR1U7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac009506-20d7-44c9-8b7a-08de101c9b03
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 21:06:58.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TD8m+lMZogiZFex72FiI5o+phb6ucyHXGn17RL8nIcWr6oCN58svH0tVd641zIBU8hPXTIgp2kkT299m4Ih2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8105

Rename power-supply to vcc-supply for touchscreen to fix below CHECK_DTB
warnings:
  arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dtb: touchscreen@38 (edt,edt-ft5406): Unevaluated properties are not allowed ('power-supply' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
index b29713831a74489e8cc0e651c18a40d85f9f9113..04e570d76e42cd67a38e0f3b2301598f712e6bd4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
@@ -199,7 +199,7 @@ touchscreen@38 {
 		reg = <0x38>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <4 IRQ_TYPE_EDGE_FALLING>; /* GPIO E */
-		power-supply = <&reg_panel_3v3>;
+		vcc-supply = <&reg_panel_3v3>;
 	};
 };
 

-- 
2.34.1


