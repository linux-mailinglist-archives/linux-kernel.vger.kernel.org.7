Return-Path: <linux-kernel+bounces-772693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6DB2961E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495323BD385
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B1F23506A;
	Mon, 18 Aug 2025 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J35OhwDd"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0B24111D;
	Mon, 18 Aug 2025 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480389; cv=fail; b=ORZ1JGsWsaoNdwqRkxiCT/YoXd9Fg2A014LlTPDFITSwutWGUfYTVz9Kq81O/wnCUNSG9ikdqQ9Zxl3cLWp0oECj8dkWIWhOYFxbqoINfr3zWxQ/uJ8rQZrFejucI05eSVnj1wPmpwRD2wmpYe3BBTQun/ywMm+MEnS/PSi0OpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480389; c=relaxed/simple;
	bh=Nq0TP8uy7KoQJwljPII6bS8TfjfhacSwcrPXmIERH/Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m2pod1WhFJ+uPoiPXny4ErpMWoaEKCic41JdILcikpRqkNtjA3HXWRmriPJ+V453XKZuq7T/TTuHmCIeaO2Wr2l7DGgqlfchwCm7Wim0CoAvesi38Lfr/p7e+INCW7IpgHbgwVVCHDHTCEmd34K7uVN5FgHoM5oA0wQ+ZoOuABI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J35OhwDd; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3nHE0nTIkda0fm3teLA59hJPJirAaulkBTN7xfsalF7k+CsyXA1gmkBgpxG/SiTuKJtf51NWA2UpBxMCeIVRPJJEtvwO/EH/cohMa2jpsvNNncKHlep7jaHLSTjDem3wwGxYDkeQnax8+HZdXivaDFnYdDJXufqzdaSb09ic5ANZ9ED8fHSdSxtX7K+gdGWx1iFMWvGpJbeFl+MF/GSpKrRWuHdwNFX61THRTHclLclPWoEGZvSpTKVV0lVrtukZBFfBq7nOdfArCVNQ5562V/6Fa+AhAXp03HicrJnBO7OC82etotM4AHQn+OuF83GypH1MFe12x9Au6llfYt9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WykjTkSAeGBFqpzuPmuinFcyrs1lwQMug4p/2FtxdhM=;
 b=CuQ4dcMvs6lmN16AEVPcL+i9+6/Wqw0s9dLFH0OdYCicsDpf4q61mK//MEAuyhle1A7KcCSEaiBdINpuqWjYjviTo1/PpCfmvlnoblxrHdynxm3t8SbHyzYCsHNrc/6oyQCof8q7KmsX4K9+zRY3svti7wZd7AC6TPlDaUkp0zcNw9wEZr8a74KnO2E0qgHaR67umxj7SB4N1jeET+GI3zpnRexUHpwrAACUV+h8yATJrfU0bMG8f5vDHTCzpcm5h4HpJrpnJiHfiF7k+3VPWRj4Xn+2ykNWybckB9wQ4G+b20mvRcaIU/aWBDV7J29h2a4X9q4wOzWqnfk8X+F9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WykjTkSAeGBFqpzuPmuinFcyrs1lwQMug4p/2FtxdhM=;
 b=J35OhwDdOsnBAbTm+IYGeylh+RpD5hhh3eIcIndXQwI11Cvsy7/1igKopa9bLFIl59zoi6hXqk/Wf25nyOhMX7WxrMEYFHl8HR9jmkMhZplPNgUY5MrIn2BP9pbghVjMXd4rCCCxwAnJnMPSTim3UFWy/wwTzrOAFcY/m9fJA/gwASyxjloQWxho/kpOtlNuCNU0KAdZbdWypgMlZplZ4OYPgqpFHnZaWHT/4QeA5Sh2dBkmJSOBidfSs5VsFRlt75bp5xibGVkTZi61E3CwKPx6H8Cp2aXhlB0Dj/+uYFF/gscIy/h/0G0c5Ml/zQqNeWAFb70oMToA0tF6QkxbdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11530.eurprd04.prod.outlook.com (2603:10a6:102:4e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Mon, 18 Aug
 2025 01:26:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 01:26:26 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 18 Aug 2025 09:25:39 +0800
Subject: [PATCH v2 09/11] arm64: dts: imx95-19x19-evk: Add pca9632 node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx9-dts-v2-9-8ba787fb5280@nxp.com>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
In-Reply-To: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755480344; l=942;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Nq0TP8uy7KoQJwljPII6bS8TfjfhacSwcrPXmIERH/Y=;
 b=RiGwUdS7CQC17oLhrw/3mE4rzO60C0ZfSptf5SXGAaFCMu42Rj1njeRT6iVih/tle9EOz9nTe
 Fk6FEWGdsafC9At0DwGDyS1ZGTU4uj9KJAStKDBdx+ZJn7Ift+knc5v
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
X-MS-Office365-Filtering-Correlation-Id: bb6411e6-998c-491e-e6d7-08ddddf63ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnpLdjRSeFFVR3NDeHRHcUgreWh2SzJXV2xVQTNHaXE0QjhWMUZLWEpFVy9T?=
 =?utf-8?B?cmxRUFR5ZUhTYUoxWlp3eGNoQkdoWE1wdUJlU3dleGxXc3ZrWnBFK242OUVS?=
 =?utf-8?B?WXhIcThrc2REWmhYSGFrT1h4c2Y4REZGMkRISitIVG5KWUg0WjlrVHo4R1Ro?=
 =?utf-8?B?RHpMVEUvSUVDUGRjWVZQOUdsd0JsNFZSRVhHL2FMbjRUREpuUGNSQW9FR2s2?=
 =?utf-8?B?U1BQZDEzM2NDT2tRUTVGc1EyUS9PVWhlaWRHTUlqemc4QkEvcFVWSDZwTHc1?=
 =?utf-8?B?eHJUUTdzSzdyNVRkYzdHVXlYaVZQUW5vaUdmVlMyVElCS2NSVTY1WWtRWGIw?=
 =?utf-8?B?Wmd4enNGbkEwMkFqTU9hWjNHUUNpVXN4L0RUVDhYTDVlL0xXcnVqSlhqQWlK?=
 =?utf-8?B?ZXhwRW1MTXZqZkJBejE1U0lEaWx5ak1HWk5yV3N1dmZGYmRvV3NoQ2FZbHlv?=
 =?utf-8?B?L2E3VmgzUUJ1eVIrQjVlUk90aGlnK1Q2Yi9SSk9mMFNUVHQ4SkNqQ0dsc20w?=
 =?utf-8?B?VjdFWmYwTWMwUmw0VjR4dlBJMDY4bk5LZXZOamVnNHJDeFV4MEZiRW5XMEsv?=
 =?utf-8?B?V0xxbCtuTnRqOEp4UTc0OFRSQ0tyZzNzZzZjWVRTb0xkM2tmSytzRjBEK2Mr?=
 =?utf-8?B?aGlmS2VpQTZNM3RzcGlFWGVqMWNrNzRHaFYvYjRGRTYyUmRsUFNYbEI1SllW?=
 =?utf-8?B?RWozZFNlc1h5OGoyVU4vcm1uSVFZVXpnSVVRNFhuYkZKdjNPSXFqSUx5Vk8x?=
 =?utf-8?B?TFBidkdFbm50bGJKd0ZuaEJiMTJRR2lhRmZscEZwVDM5QXZPQmtBTnVWR3hQ?=
 =?utf-8?B?Y3NmT2ZhUUJGMjYxbE9RZ2NpYUE0dmRDajBwNUwxWTFaM0IzaWtSUEUrM0Js?=
 =?utf-8?B?ZEU2WkhrbUVMT3dXK204M1g5TlkrMCs3a2srZktqTkkwbGdWV1NpNUlIN0VW?=
 =?utf-8?B?NzU0SUZjWXhPUlU0UlZENXRtZytnSlk4UnB5YUVDdDdxSDlZVVh4eUpKanlG?=
 =?utf-8?B?N1VCdFg4OEw3dmI3Skt0dEJVcENRc2llaHU2SzZUaHJYSU5XQTM3a2JQaXpW?=
 =?utf-8?B?NXREWjkzRHhvYVBpMlo3aXovdFF1WXVvb2dwaWdqVzhOaEJTTjk3anZDUWxD?=
 =?utf-8?B?cXlxUHdyckhNQVZBSFE1TlZiYUQrcWtXQ0t1OGtvZW9hVFZudlVjcFBhRExp?=
 =?utf-8?B?bDRQcnVVaGdOc3JtV25TN3c3aVJuWEtGdmdjMnRkWHpzTENIMFp0NWtnVlAy?=
 =?utf-8?B?c29IakdNenZBRHBCQjZKQXc2MWttUUp4NTAwYWowZXdZZnUrUjNMZFg1OHRy?=
 =?utf-8?B?QVArZW1YMXRZY1FxY2EvRGtoNDB0THZzWm16NC9DcnVtdUhDR1JTcmNjZnpv?=
 =?utf-8?B?YWlFMkJNQyttRWNsWlpVRm15aXhURXpCMW1Tc2FLdWRlQlVidGlEWGR4VzR0?=
 =?utf-8?B?aW1LSFp1b3ZHQ2QwY1RIeG5TK2FQbFVOMWtXZEdnRkt3N1ZvTjVpYis5Sjdl?=
 =?utf-8?B?SXFXSUtiTmk4RzlacGJVWTVrTUExRWp0STJlSWNOb3ltRDNNQXF1dTdsNTJ5?=
 =?utf-8?B?M1VYTkxLNDVrdGNQUWJzeU9paDI1RmdqYUx6K1N0TG9SbHA4S2J2Q1pSREEz?=
 =?utf-8?B?aUdQcnQ5Qk4wWk5QTklZYUpNdm5sdFduS1MveDQ4aGNJYlpKc2FiSHRENVFZ?=
 =?utf-8?B?aEw3SWNLQzZncnB1R3ExYnZ0dGZvUE95cWk0ZGxRTXdXREpoRm02dkUyUFFW?=
 =?utf-8?B?Q0lENUl0Um5MdXNOVWNEdE85TVE1ajVUenorU25yenZTdjJaL1UraDRRWTZ2?=
 =?utf-8?B?SjhXd1Z0YlI4YmlibFN2UmVpNFd2Q1lXc0tiSXdiRnBxTENkaGV4SVNtYWJO?=
 =?utf-8?B?NDUrM3RGMy92bmdYMTJKVUVreTF2Vng3UHJoQ1c3d3d0MFh4K3ZBT09Xb25k?=
 =?utf-8?B?RVJ2QnArWU1VSFhybGNBRDdTYTVSWVROVk9YMUZjYmpSdDI2R3YxL2xaTTAw?=
 =?utf-8?B?MlRtMGlCd29RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytaYWllSG15YVQyQVVkaEs3cnJqS0Q3T0lXak42dUt3M3dUQ3VDLzc1L3ov?=
 =?utf-8?B?elEyTHNZSzc1WjlBdWoralRmUzlYOG8yNUwvSURoY3o4VU9YK2ttbGx0N0dv?=
 =?utf-8?B?L2VDUVptZ0ViRGtlbVZyRG0yQ0E4MEx1UCtkazlVdkdMWFFIODJidnlJZ1NW?=
 =?utf-8?B?ekRSYWZuLzIyWVgrM2JZTm9hK0pROXBRMWF2Y05rMnNrcHcraE1HcmRYZHky?=
 =?utf-8?B?NUFXSDhaNnZqRWNnL0loSmFrZVdiSmpITFYxaEFNRlVwSUhFRUNjT2k2NzNV?=
 =?utf-8?B?ckVpMEZUcTd3VFhsTWRiYkdvNmh5R1NTRDYySTlNN0xMYUNZeGZ6MGt4OG5x?=
 =?utf-8?B?a0V4WmFXcHVsOUxzUm1WanlvbW9WT01lUEFPUmxYM2swRFlLZldaaVZiTVZi?=
 =?utf-8?B?Nk13WlVQZHRIa2lhT3VNVG5CaGRtUFBackduSUUyZSs1QTVWaEhLazBEemlI?=
 =?utf-8?B?L3B2M3Q0QVlGYnYvbHVVbUpIcHJzUlExTUd2TG41T1MreWFhbkpXUUhDdEEw?=
 =?utf-8?B?a0tGZDIrYWlWNHBJc2ltb0xTcFJITHo0QjBucmJaZnMwc2I4RHpxeG5mQ3Aw?=
 =?utf-8?B?dzVzRVp3UEswN0E0TG9hY3loTGpwMHZZbEZOVzF4QmZSRFYva0p3QTRrU0JJ?=
 =?utf-8?B?bklVTFFGaEc5UVlHSUdBMnltVEI1Qmt3VC9uUENQWXJ1SmdCWnVTdUw5Vm96?=
 =?utf-8?B?NnFGZVdvN29TbEhMNURGempjajNPQUlMa3NsMWYwNlpST2M3TnZTRXNad095?=
 =?utf-8?B?ajQ5WVFLeVNCazYzVHFWUTZyRHhxS0Qwd1M3SkxqOTgzTTV6K1BPT3NYcWtX?=
 =?utf-8?B?QVk1Q2d1cG9vVVlmVzFrM3lmV0dpUjVYMy9BMkJDRWoybmlPR3V4UlZyN3FH?=
 =?utf-8?B?NEdXS2I0SXJkem5xbG1mZDY0QmFqS2ZscmZVcGdicUtkcENIdFR5Ny9KbnJQ?=
 =?utf-8?B?MFp4Vjd6a296UzFmaEI0R0hoY2xZQ0NDUU5Jc2hxTHFaaGFCazREOHo5RFBt?=
 =?utf-8?B?blVhcTUvaFhDQks2SENNaHJxakNZaUFtNm9SciszK2NPRG43MkpzZ0pMRnlI?=
 =?utf-8?B?ZzlrVzJ6Z3c4SWVtcHE3clU2NGl2cjJEYmw5elM3aHh3THZjdCs1UkFud0d1?=
 =?utf-8?B?WFRULytNa3Q4ZkJIa0JyYVFjbUxIS3pzUGdoS2Q3elpVN01Qd1ZqcXAvSmp6?=
 =?utf-8?B?T25CTnZqNkx1MGU5YkJyMm04cEU0Tm1oTkpiSW1mdUFQU2lLaDFRT01Jam1F?=
 =?utf-8?B?cm9JMFcxSUlsOHpnUTFlMEllMjYyRGZSVFpiRGNmYjdhZnR5cWQzNmJOcTRL?=
 =?utf-8?B?OTRhUG9MVGFsaTNBVG9sMzZDNjBOR3pqQ2FrUWJrcHZTcklQMEVNN3kvZ2p5?=
 =?utf-8?B?M2Fib2d2SDdEMjlHelJnRDFlMVRSZTNmVzdjNG5oOVJoaE44TnBsT3J1UURs?=
 =?utf-8?B?UFJrZ0x3NW5wayt3UWsySlJYZ3ZrQ3BVcFNYd09zYzVqdE9vaUYxZEpXM3VG?=
 =?utf-8?B?ZEIzbzB4enJ0TXJLa05sV09JcnlsVUlEUkszRDY0VmZsKzNDRkh2N2pweUM5?=
 =?utf-8?B?ekE5ZzBJckVwV3ZJRVBKQkdSN2JCekhoQnF5SzFURGVCQUV6MCswVnR0NUFq?=
 =?utf-8?B?RjI0bDBwNE5sQWtOcnRTYUNUbVRuZ2Vzd21ZVUlhazZzUlRYOFRESCtqU2M5?=
 =?utf-8?B?bzdxdU81cjBIeTFUSGRnaXBTamwzSzVTL3d2Qktzak1XR3hZMkx0OVZnaWV3?=
 =?utf-8?B?NWQ4ZHEybUEvVkFqWGR2SXV5SWdRTXV1ZGhOWjBjQlJqTjBXTHJxVUt5SEFw?=
 =?utf-8?B?ZUhRRmxQQzlKQjZobXhTc0JmR1JiVndQeXZlRkFubGpjcy92M2ZIck9YcWpG?=
 =?utf-8?B?dWVXSG5pdGZnRTNrSzNweENPVml6OGpyVnUwS21TdUpKL1g1YWVISnFudjFX?=
 =?utf-8?B?WkdaUDZEd1QzTSt1TmZJUnR4QThCYVgxaFR3YjhIdzhpZk1XTElnWVlDQS9o?=
 =?utf-8?B?c2syR0h5eHJYSzdYWWJtZ2JzMkFQeS8yOHBFRnI5RW4rVDBEd2tzeGkwa2Z4?=
 =?utf-8?B?SVBGUHk0V2F0UXJBdzZ0RW9IaTdQYTB6NW5wL1JVL2dmVUVKd0lQWThhZDZj?=
 =?utf-8?Q?M74qSo7uaVQgPpo2uldRfTFY8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6411e6-998c-491e-e6d7-08ddddf63ffb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:26:26.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5O9+Q23BGK7ItnK/cYK6+J84Q4VPoc9rtY5RrN9MJvMR3p2Lidt9QJCsJqq5eltabv6UonsPgWtAv2wc3rlWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11530

Add an I2C controlled 4-bit LED driver PCA9632 under lpi2c3.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 6d2f09404bdb8bee62532f1e02f59bd5a899833e..11393bd57582dd9097732c84e6281be2662145f7 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -310,6 +310,19 @@ i2c3_gpio_expander_20: gpio@20 {
 		reg = <0x20>;
 		vcc-supply = <&reg_3p3v>;
 	};
+
+	pca9632: pca9632@62 {
+		compatible = "nxp,pca9632";
+		reg = <0x62>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led_baclklight: led@0 {
+			reg = <0>;
+			label = "backlight";
+			linux,default-trigger = "none";
+		};
+	};
 };
 
 &lpi2c4 {

-- 
2.37.1


