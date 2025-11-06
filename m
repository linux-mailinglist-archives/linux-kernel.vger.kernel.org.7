Return-Path: <linux-kernel+bounces-889331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E8C3D4CD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCB044E71D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653EF3559CA;
	Thu,  6 Nov 2025 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j7ZVEuhq"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB3355811;
	Thu,  6 Nov 2025 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459078; cv=fail; b=tjCm1xEsEt1zZwmsHldfCcGhHr4Ps4+QMErPeilyagEG8S0pJ+3rEXeDI2BhpC9aDe8puAgDBCVaPv0ePL2bNmtFCnXWl8Y1qB1KPNA2neSJ/ecwcI9c8N837L0+9zx7XhK7JDBPYhqv2IWnTgouS5oZKmiLOLJ8c2EfPmuKssA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459078; c=relaxed/simple;
	bh=lhT2vXtUAbuVxSdVz4i2QyO+V8jXLBnb3vIumD0rNXo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Z9gJjmMmV8kCz4c7SAjVnhZFw84ZC0cDc7Hglgvx8+5fp/8L5hjtKIJ8fbX+R2c0kmHQo2R4M+4luR9Q8vr24GlHDfVwyzLyS8qjR3J5kbUDvQwY0XYdV5aqVb0HFiw2iuTIsgntOjO6jeEyyGSvKLDdo9hkM903Xkttyo+vXY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j7ZVEuhq; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldLVjJoQAdf8YOTgHRHxjHzRvH+OEkC6dNgO4AJPzOs4CPlZQwwSk8Wi1uWhKNrtz5vPULJRNA0v+DvDCnU1bzdBB5y3c/x55eFN+eBlp73URjUJn0EwvNK1AsjIKK985MeLnC6TTEN862v0BtHXm5P3g7cf17Pjm2Jufyrhd8z63CBGnASt1LTES62FywKGOa4f7gwzt/B/+AG2zDoRDQE/XIgkcjYD45/jO4sfRptpJx+jdHK8ZneznDjeFB0QQIWIczET9xEiJ9qsMmJG0NMI7quL0j7OH9TYTxm/geR2CFbVuiiUDnmLuCbyYNqzcRDAQbL8bt8s/JVTjOUXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKeNxEDgcn69qsIh/uHBhQolHnILVbREU+zLwKOtvL8=;
 b=ZtvambBWCdNyNzsmXhe4O/rnYOXlBVGSUqD++AQFuMo7TiGYARegoB5HtOnpLjcn3mye0purBBTY3x0voQTbmF472lVYJcofDXqz2l+FRU4MymUaLv6czxP/4ryrcMCIxYOEItcQIGNpEoQMbDTPFUc/NCLgN6zjx53t5zV0Gf2YGVRMGbW8BZrPkIoF+3Z5VIL9W9K2M9UEPwtFKPcIyqo3t/QkOgC3PzwGKAPkl4Vb+WW6IK6zdVxKrzZ1uvyQXqzGjx/ZzZe/1vKSdFqKJSjkbcMWgZ7y3Uy5Mkgkl+WcUgweRP3s61WhNIIiYqn8WZvXnBtdV+mxTvFx/I4NZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKeNxEDgcn69qsIh/uHBhQolHnILVbREU+zLwKOtvL8=;
 b=j7ZVEuhqGAOmsyYLGpwo//uaYYUMw2QTHGjSDZtARtc5IqmpUjXjMM+UDS+uMiSCKdI+vwBb1tnXnz2MiwmWVSpmuygvZza3DQo02wTmHN1ihAOCWBBkV8+Vj/ffmtLH590STTr0FsHr1lbj7G06JEmTMPVRJTOXZymMJTMzzSSOMnshrZbo2RyeyfDazLe/DhABXKD0FCYdfTMGSvhkaNiZX0qarUkne7z75Uq5Gn8LFudnz0V0Ob8AgaJiu8b0fnjxIq5IOxf3s14UYrij2o3dMFgx5EzWxCYdyoNktCTHUeFfqRvG+zYO61Iyyyd3if7imfbEyIFQTCyrrz1q4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8756.eurprd04.prod.outlook.com (2603:10a6:20b:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 19:57:53 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 19:57:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Nov 2025 14:57:23 -0500
Subject: [PATCH v2 3/3] ARM: dts: imx: add required clocks and clock-names
 for ccm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-ccm_dts-v2-3-12fa4c51fde7@nxp.com>
References: <20251106-ccm_dts-v2-0-12fa4c51fde7@nxp.com>
In-Reply-To: <20251106-ccm_dts-v2-0-12fa4c51fde7@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762459054; l=8065;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lhT2vXtUAbuVxSdVz4i2QyO+V8jXLBnb3vIumD0rNXo=;
 b=polThelg3wnHwGebXhUWFyzQ154p0yv25QwjnajrfsqHBrPMdWLWwLcWy2LMTpH7IoOO8RwxZ
 hPKbFQZkBJ6AKOm+YK+ZB3QkcVjcz3Sxx51a0fJBjeDZTEv+Sku+XjB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: b18c1924-3240-42e0-3204-08de1d6ec563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVM0MklyMzM0eE4xU1AwdzVYbEk2UHRjejNIWk45c2pMK09LVVhKSFh3Wlpw?=
 =?utf-8?B?bFJwY3RnU1VQc1h6TFptNE5yWmIwNC9uQzJBS01XRVhpT0dxazdjQzRhakR0?=
 =?utf-8?B?ZE5xWlJOREx1MlJ5b2lGS282ZmJPd204SGswa2xlMkpqSXEvaVpFR0ptanhO?=
 =?utf-8?B?SW80MUxMWjFrUnVnNWJ6RExNYXRIcDVWTVRmenBRSFMyVlZUQTVHOUVoanJ3?=
 =?utf-8?B?VW9Oa0tiK2psUk5oM0Z3dEhuRWVmZWRaaEtqKzdIZTJhSFhTbnJuWWE0NDVG?=
 =?utf-8?B?Z0hoZk9qWHA0bUlQZllXbWZ5aUVBb212QzFWZFBMNTRJR0VqU2RyS25oME8y?=
 =?utf-8?B?MmVBYldJTEpPNnM5clcrMGVWdm9FelYwTndBZkU3Z3dRWUs2RG9BUWlRQUtH?=
 =?utf-8?B?Z0R4a1FSRkh4dFNhOEVHbmJkdnh4S011MmFlZFcrY3U0UlpqamZaTFgwY1M0?=
 =?utf-8?B?cDlqUFZ5blBFT2NhT1R1bnE4cVJyUzVQc1FlTWNSZ01EUzhrWmRiOXFpOTNs?=
 =?utf-8?B?WUY5VnFTS09wcm84V3cvYWxFb3NoMmZtWGpxSnBoQk1CcklDSUU1V3IvSW5E?=
 =?utf-8?B?UzZjWFNrY0kwdnFuR1dlODVhZHcxR1h5RGE2UElGZlNlcmRwa2tScExWL0Nt?=
 =?utf-8?B?RVc0M3VvVHpiL2UzeEY2L2I1L0ozMjMxejBVSnJpaThFWmp2RXh5eG05a3NU?=
 =?utf-8?B?R0tCbUNjYXE3djJpS242TU1FcFVYSjNuY1ZwZHBJTWJ3eWhSZDJhay9sREV2?=
 =?utf-8?B?c1VERlFXRy8wTUkrNnpPMElNLzIyVmNsTWRLVG1hN1VRNnNaVU12ZEZWY1M3?=
 =?utf-8?B?N29FWldHZGNsY0p0dkR2Vm5KWkJ1ZW5NbDBhM2dONjE4eTE1OGtDTFAzeTdL?=
 =?utf-8?B?MnZBSHdnVjBBQWZrN1hwNkhoVXFJSmg4NnFvdWZzUGNCMG92STFZMVRwcUZw?=
 =?utf-8?B?WDJQZERFMEVUOXM5YkpXaG1rQW9yck0wTEkvSUZTbUJ4OWtFZ01tTFRWUHdC?=
 =?utf-8?B?Z1MwR0w5U0NIbWFtZDgxa25vN2wvR0p2VEZ6SE9ORGJDRkhrcmU5Y3lDeG52?=
 =?utf-8?B?bEpDUHV2WFRlWGpmaGYrQnpXbEV3WVFWM1VRaWhEcXNrbDRNSVNpRElGQitk?=
 =?utf-8?B?ejc2ODBxVVp1dEFCandiRnB6N3FvajNXYVJjbFduMG44Ym85VVJiWGJoTzUz?=
 =?utf-8?B?RVNvVWhPaVc3U2ZCU2VyNzgrNm4wczRhT2I3QWN3Rk0xUFA1WWpEYlBvR0Nx?=
 =?utf-8?B?UUVydlEyU2NMWndxeG5vN1czZ3lhSjVoOUtYWW81UmJ4YlBUcnhFbTFJQnVJ?=
 =?utf-8?B?eWMrRnlhMjhvb2l3cjdjbkNMV3NVSEpjTjdZWHAzb240WkxvakJWWGs3aS9m?=
 =?utf-8?B?VFY2eHd5VXNaaStnSUFFNTZzOE50QldyU3hIU3RXcVlDek9KR29ReXN0bjUw?=
 =?utf-8?B?cjRBQXNJUXBlWldGc0VlUVZTTmdzUGxQK3F4S3lHZUQyQ0RYUlI0ajFrSGMr?=
 =?utf-8?B?Z3BJMXhoT2FLTkVnS1cxWWJyTHIzSEE4Zkx0SWVsNExFQXBqb09TTGQ1eDZj?=
 =?utf-8?B?VFVXRmpTRGJxT1doKzZOUzFLVDdrNXNCTjNFU0hmamJKR25nK2Urbm94cnFr?=
 =?utf-8?B?MXY0Q0owSVdua2czS3RDcFNHN2ZoYWFzcXdHUzA2ZStDY1A1QVpsT3U2bkpN?=
 =?utf-8?B?S0lsUVVqOG5DMHdzUXBDelZsSnJFWWpWbldYem9Bc1FCaGs5SDBjaUErL3FF?=
 =?utf-8?B?SGlsVTZUMW1KdkE4VDcvcTJuRm1obFltOTdtdnZiSTVPL2tUNHBrSS9sNDlV?=
 =?utf-8?B?OUk4OEtCcDZsVUhobnVmSHlURWZhMTcyaTBDVUFMOUZWcGhoTEpPc2E3dzhp?=
 =?utf-8?B?L1pmSjBzTGtjSjJ2T3V1dElFNmVaMTl5QmxqczRMWlNkdTZkSHNacEtCMWI1?=
 =?utf-8?B?WFlBZHlNU05sUVM0WGRKSXowTzg4K1RUSVBwTkZXbWU2b0V1dmI3U25MWmNu?=
 =?utf-8?B?N2NQZ0I4cDhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkFuMDl2am9KSm9OTTI1bG42aTBGRUpVaWorYWcxRDJrWENTWkEvOWFCakY1?=
 =?utf-8?B?cHA3TjF3eFpGalpla2x1ZE0xR01YcE8yUXF2YVlScjhoRnRKQ2VONUlsR000?=
 =?utf-8?B?dC9Od2kzZ09lRll0RVRjT1lIS3ROMks0ZkFaTkJ6blRpNFFvYldjNTA0c0Vs?=
 =?utf-8?B?U3RoVDUrbS9NWGlWcGh4NWRzdU4zTkVVNS9KUWwvYTc5MGVBcFZ6ZjZ6d000?=
 =?utf-8?B?NkZRVGw0KzZhZnhKU2ZwMXN0K3htQXVUZkErTlY3bVJXNW1xSzhJZDVXTzJn?=
 =?utf-8?B?OWpFbkZkRDRFb0MvQnR6UE8vaUpkcXVLU3g1TlNWTFFTTThKWDVMNUdSZXQ0?=
 =?utf-8?B?aXFCVDZtb2NMTUQxV1lyUFIxVlJnMnRxYTBtdkNtc2w0TkhzRWlSQ0o4WWdM?=
 =?utf-8?B?eXhlbXl5TnlnTWlYQ1kwc0FIZGRZSURNN3Vyc2o2NlNqdFBISkM3TVNvNk8r?=
 =?utf-8?B?bDAvcGliNmtPUGFuOGthWFJ1b3FKVmdCRGI2aEFTMmRobnlmWktNVGhvclJi?=
 =?utf-8?B?QUpiR3RBeU5lSWVINWR2TXZGaWFsT2VnWUNvUHM5REtmdm9PT1hab1dYaWpW?=
 =?utf-8?B?d1RWOERWa1BNSkpaZFhjUUdtcmppWVNaZ000ZDBUV25lSlkvTWdKSktlS2lo?=
 =?utf-8?B?enFOOGhmRWZKaVJqUHFVMmRrbHQzOTFFV0pTbmJ3OXVXUDBwdHpvVVl5Tmo4?=
 =?utf-8?B?djFhU1VNbmpydzFHSjlwZFMzZmt0UXBmU2hvalk0RXQvTVBDb0k4R0RnSFk1?=
 =?utf-8?B?MlNvbmNJVnlCTDFHRklyQ1ZKS25KZVpXMmJPTE9JWjJOSUFxaHBqSUZLLzh2?=
 =?utf-8?B?Ny9QTjlpTFZXZXF2M2ZRS1Z2eTg5dWFwdHFiOUhpZDJxTm9CSVhKM01QeTky?=
 =?utf-8?B?VXRUbjhmWUx1akhNd0VldnM2K0dNWEJNdzRhS2VzTzRIODNOTHVkbkYvV0NB?=
 =?utf-8?B?OERWNXF2R1VNWlJJWm5uclZFUUZjbndBR3VoMVY3QjhwVkZmL0d1YWNERlhl?=
 =?utf-8?B?UUNTdkNWdjJMemsrbktUWU9KaVQ2S083bU1TaUt2Mjd4dGlSNHpzMGpEUVFm?=
 =?utf-8?B?bU4vMzB0bXpESDFlQWNLT3hOZkY0a1gvcEE1L1U2RnFRMG4vZHhXZXlzM0ti?=
 =?utf-8?B?UEYxWlZwaktsWklIeXZyQzB1WDRTTGVkcTN0Y3JqS01NV1VFVzh3YnRPZFRD?=
 =?utf-8?B?RUNHdXMzenRSODNmT0hSd1JZL1VMODRjZ1lkOHBFbmVjZGhUcHpQUlk5a09j?=
 =?utf-8?B?YUcwQlBsZjQyK0dCc3c0b2RZMHNGZWVYY3poV3dCZUQ2NDdUYk45anNzdDlt?=
 =?utf-8?B?eWJ6WU9xeXVMVWdjNXphOWlZbEtZd0M5WmMwUkF2Tlg2ajZDSDNveUloNHMw?=
 =?utf-8?B?VzdnWFdBYTFROHZUa3BVQlFkTWN5bEI1d0VPQnVrUTZLRGJEZElxaUw1b0Fy?=
 =?utf-8?B?UVc3S09xeXMzR2E5b2hzeWo1MEVLcXNrM0dGTEFHdi9uMTFlZnJVNmFJdDdS?=
 =?utf-8?B?UXo5REwveFFEeXFReWE3QXFxN2xoKzVTVXBJeUtPN2Iybm9zdVpjN1hMSzlH?=
 =?utf-8?B?d2lmWmp3c09DTmFPSEpTc1ovMzlCMEZXTmIvbDlHNm94SkZuSEVRK1M1Y0x6?=
 =?utf-8?B?TTNFVGFBYlgyNytGWUZUeTM4ODF5anZwaStQdG9yQXlDM3hJdC8xM1V1SVJG?=
 =?utf-8?B?WWR4U3IvcWk4SmFTMkh5STR6c0hQUFBVQ1M0aThUQ0ZFV3BnT25UcWJDaTUz?=
 =?utf-8?B?TVM5eHQ0Zmw2OVp3WVZaNWV0WFBIUmtKVjEreVR3VExBS203OEptTW1qcm1P?=
 =?utf-8?B?WmtXU0p0aWpHWld1N1lRcFczby9vRmxDcndNYmhEdUZIUGFpK1plUlN1Ylo4?=
 =?utf-8?B?Wi95Wm9meFRIWkVXVkdEZXdJRGdyWlZ6WW9oLzc5RDhhSGVYWUUxNVZ2NHBZ?=
 =?utf-8?B?SHQ2NG80ZjBidkdscXpkdGkwNFRRK3JYVEQyQjRFWlNTQ3VHT0FVSzJjSEZk?=
 =?utf-8?B?Z3lheGZ1blRZNWVHdDNodGVNck8zdkZZdFo1MnZOMkJhVG13SGdVb0JvajE0?=
 =?utf-8?B?bXQ3U3dxQ1cxL2ZUbksxcWV1ZlZ6RW5kdUdnWDJ6ZjExQnFjSWJrVXZUVkQx?=
 =?utf-8?Q?DBbc/bvfKFaHyO02OexD+9pcb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18c1924-3240-42e0-3204-08de1d6ec563
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 19:57:53.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZKMot0Ibpl5VzawtxPQfND8EB4JU1KfkkW2DaFW4vnA73iLaVuhUOrgZeqfBCnjvzkFj0r9VqPeyoVwgTjTgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8756

Add required clocks and clock-names for ccm to fix below CHECK_DTBS
warnings:
  arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dtb: clock-controller@20c4000 (fsl,imx6q-ccm): clock-names:0: 'osc' was expected
        from schema $id: http://devicetree.org/schemas/clock/imx6q-clock.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- use enet_ref_pad instead of enet1_ref_pad (only use at 6ul).
---
 arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi            | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts            | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi       | 4 ++--
 10 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts
index 9bb36db131c21956a33f0a5a013c5bb4cffe1890..aed4fb7843e2f2a5bc57499aafd3431b582437dd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts
@@ -193,8 +193,8 @@ &can1 {
 };
 
 &clks {
-	clocks = <&clock_ksz8081>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clock_ksz8081>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clock_ksz8081>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts
index 5ed55f74b398f24a69245dbf88f5c93ee0d347d8..5f61eeb9fad0c590e778d82d42d201fc2b0a7c3f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts
@@ -66,8 +66,8 @@ &can2 {
 };
 
 &clks {
-	clocks = <&rmii_clk>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&rmii_clk>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&rmii_clk>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
index 47a6d63c8e04cf28795310aafcdd3b2b05740830..9bde6546255825ed871aaee592347e23da4d4141 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
@@ -119,8 +119,8 @@ &can2 {
 };
 
 &clks {
-	clocks = <&clock_ksz8081>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clock_ksz8081>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clock_ksz8081>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts
index 84f34da06267ebd477fbe71b465a44ffe5b4c098..69e790ba56624ee8ee8611ddac5ae3c9585a5c2b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts
@@ -101,8 +101,8 @@ &can2 {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clk50m_phy>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts
index 0ef24a07dedf986efdf4ce8ad4032814752e7271..fbff77944ce327f390abcabde638f4162d45eadf 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts
@@ -199,8 +199,8 @@ &can1 {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clk50m_phy>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts
index 2160b71778355623a9f124975e2cd4dfba4be900..dcd5a4099c602d03704c35860f4d6f0beed1862d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts
@@ -294,8 +294,8 @@ &can2 {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>, <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>, <&clk50m_phy>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
index d5baec5e7a7824c05ca64c36a1839efff0bd7f71..fb674ac2c2485a818ae593c63388bcec548a100e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
@@ -71,8 +71,9 @@ IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT1_SSI0)
 };
 
 &clks {
-	clocks = <&rtc_sqw>;
-	clock-names = "ckil";
+	clocks = <&osc>, <&rtc_sqw>, <&ckih1>, <&anaclk1>, <&anaclk2>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2";
+
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
 			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL2_PFD0_352M>,
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
index 76b0007d20ad22eee738ab40ed126435a8fd17fd..18019a6bb3af07c43730ef60f884fefd810553bd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
@@ -160,8 +160,8 @@ vdiv_hitch_pos: voltage-divider-hitch-pos {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clk50m_phy>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts
index 0e02e448db1085e7f508e55cd55d4441d2f51a54..5ef1ce80869914f8866cf71e79dc1b3d54d56f5f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts
@@ -57,8 +57,8 @@ &can1 {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clk50m_phy>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
index 131a3428ddb86796ed843b46cbae12f5d095b2f4..894e5c28b2ac036cc29a2d23d4c6451f0da9dff4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
@@ -238,8 +238,8 @@ adc: adc@0 {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clk50m_phy>;
 };

-- 
2.34.1


