Return-Path: <linux-kernel+bounces-770550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E92B27C42
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A27F16CFB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155DC26E719;
	Fri, 15 Aug 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hcn0fVxt"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F826056D;
	Fri, 15 Aug 2025 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248670; cv=fail; b=cDyj7E5zQVAN4e5t6l5WpQnJNH3agYLao/ax1Pvry4ecFj+2s69R2MCOZTiClfnGed7i2jZPLztpNb6lSqiDVXChIsQGeHbDPJ6uuHl95gxbZp5w0ut1uyHIq8W/OEeZU7ol4iZbmwfwn/+I9ztH16Wo9pGa02A0qrRpmtRe770=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248670; c=relaxed/simple;
	bh=sceJFLUqespLtUkk96wGxgw1cAIFIFxYpUkS/4e18sM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=d1yUmDzyM2gc44J1deeR6WWOCGcE2vMDe0B9ueLVUKLGlrPd5UN265aMctv0tA/Kbkx8Ff3nIR511EXUJ3w1t1jAVV6SMfI09YSwXF/W9ZLOrrkLtD5iefcFBz5nrHXWVjiPFHIGq1a7YhQ8u2yVWubYQ1Ur1eQeEllmvzsNs50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hcn0fVxt; arc=fail smtp.client-ip=52.101.83.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwX+hpUxw1mCeYgG00XqERtxh+x1KBTy9sSKvlInEEBtcxMNRAAG5OlDC5UqVZ0Xg2fcQDfs65oJDO2P81EusETLk5M2pu5pMvtLpmt6ZSP2X+PL7xK7N2EgQ8ZamLIHLEnhcq7gvM3iRrjLcw0R+rNAGWfTelzsqtZv75xVjcblliiXtJflAfI9Ea+GAumjpY1fRLmRmU5xl6GiTUZGfvP1pnVhjAQ5VC3t0lbzZfJw/TV8CbjdbX/RGxDsmc31gLdBZy0KeWINVYz9/QdETfmh6jmyiHkAXKIOkHU1jj+fpS96TbytmFsqcpekGLDQFvwS/dAoS29699jOcfsPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDeFfr/9vX7AivkI4eLgkP8wt2FjCHA8EH+hZAt922I=;
 b=wKek4SzOMIgaWjwPNhu2OuYLQZnq3sqj3V5TF9VGLw07XajM1USVW0UPRacS0M7psSzmbc8gYJaLvARhSLrtqRAsU6a2ZmqAKZmkKd91m8i+W2mwv3qO3nM5ljmuaZNSlsImIIUfTjo1B7mYxmTX3LRtF66gNffYVYeTjsqWcvKPg5UCiA4OZHhEZg2P4QUlR5ePggq04hoDF3TOcYCawudRQCC1Zi+tv2btVLcX0QBn+q2u+SCLBGx1+mWPHf//ueOQx1JJbMLmAIMqdAUfbcc8cB1FRDuHLjPZwQ6G+RxpfvSHcAsa40hsAmdRNKyfELCyiDVjmIpy7wQlsZSavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDeFfr/9vX7AivkI4eLgkP8wt2FjCHA8EH+hZAt922I=;
 b=hcn0fVxt1lGi4z6MDevquXaMnWqp4ZD/0dx7eq77iwWJnIevIV6iV/YbMDNez4ycK6z/7vtR2r3EATFMn9rpbuCttoZJP7/r4BJ1GwQNSk4sysHeGbbpxLDKT+Evwvs8/qZ8VbI0SJvfrzUmVeWg40zmnJNrUpVGrSVdJa2CX+3dU4WweK0H3Y7hyxBoI56UNxuRC2UK7+t0k7FIDHUH5OyX6hyScw0CH47mZZP13tpovNWxk+HSMcccxiJqOJb5v6HjpsIw557ehjocZB/cgTwqEqX29jNum14c0fY+BvQOViY7safiY1eBN8/0M+tQesZerrBigyCRQBz+9ppsPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 09:04:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:04:26 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 17:03:47 +0800
Subject: [PATCH 01/13] arm64: dts: imx95: Correct the lpuart7 and lpuart8
 srcid
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx9-dts-v1-1-e609eb4e3105@nxp.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
In-Reply-To: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=1406;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=H5klBBUNnebvCDg1P/D40TBqHf/LKOv2PfCx6yYZZkc=;
 b=W2Et0Y4auBXM5mEkn+m7hozWgWp3ajccdlJ4yYNDKQ5vPjbZbuAR0nUDbUj5Kz+KtC3IFEw2p
 Nzxu3OPOMvFAVs/cVBHrQaxEW+KXxjogkCQtLBf10q+aerQgar4/J/8
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
X-MS-Office365-Filtering-Correlation-Id: 5bce8694-eb75-4c3d-b74d-08dddbdabc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1B1cmVITlBSdjNnNUhua29HVlZLQjdxeGlhSE5VemtnMmo5bFMzNWFqbUs3?=
 =?utf-8?B?NjNIb0FTS284V2k0RnR3K0ZqQ2c2dUFYSHYrWlZPMnZDTUhxcmZrbkk4bFV5?=
 =?utf-8?B?LyszbmJ4VEorYVhORiszY0FPVlF6MFp0cUFoenhuS1krb1NQK0VzQXVuNHNM?=
 =?utf-8?B?R25Mbmp1VllGbS9GNGpmZTAyZG02TUNyU0toaUhRVHZKd1BTZTAyelhFTzZi?=
 =?utf-8?B?YStCT3Y0bUtJdmVTa3BYditKRk5lSlRCSkVQMlZHeUNpQmJZK05uMEdLaUps?=
 =?utf-8?B?WHR2VzNmdWx3TUdhaFE4TjdBVURZTzVxdDdQaEYxL1FDQWVyaWVJTFNxbCt4?=
 =?utf-8?B?OHJkcFVQZWRqZTNJZGVTSVZiRHVxeU5rYXRzTmRueUphT0JEcTZoNlBEZ2Np?=
 =?utf-8?B?OTcvZ1ZaUHNORTZ3QVBxZnFSeUlVNW84aFNaQlZzSlhZaFdXRERxTHI1Zlh4?=
 =?utf-8?B?blJmSEdpT1dXK0pRYXNmNHV1YWhVZEUrNWxqNGpWZ0Q0Nmx2bzJvVHNqQWtI?=
 =?utf-8?B?V0k1RllUelpvQ0g2NHNRa2J3eWdPcGZMTEVMK2dIMlkzMzk1WTZ1TjV6Y1Q4?=
 =?utf-8?B?OEdwM3pvLzVRUFMyLy9aWHZjVDZoeFJ3dEdGckFqTkx3aDdOemRZd1dDZ3Zv?=
 =?utf-8?B?VUd0dE1BaGFzUElSdXVkeXc4S1JXZE5OajNvU0FCenNhYnJzRjEyQ0xCaW1w?=
 =?utf-8?B?MDB6TUdpYitXSkdXMUlFMjV5YklxQUR5QXgwSVQ2RVlWQVkvcWhEeVRRKy9q?=
 =?utf-8?B?WVplTjlPVVpKMldaRm5OZE5GSU5BM05NUnNSOXFFTUJ6dGNISW11ajlURGpB?=
 =?utf-8?B?RXBxYmQ4WUJNQmo4MWVVMUl2SWZNNEtqR3BNU3pwNEVxNXQ2YXpkSzZFUjdx?=
 =?utf-8?B?Ukw0b29pMzlwemdOTmY1amo3NDR4cW9jNlc3dGhuNDhhbzliNFBIcEZPaVd4?=
 =?utf-8?B?aFY1OVhDdEgwYStCaDdocnZkVkI3eXd1aEV0b0NUQTE0d0dJWkQ3bzZtRmJ1?=
 =?utf-8?B?bjR0MzNMcHhiRlNHRHIveDh5LzhqY1h6c2p3YlZnSHlETlBCWjIySjc4bnJQ?=
 =?utf-8?B?QXJWbFlqV3pXQm56eVYyRGZaV3RCbS9GZkNoa3B1Ykp5ZTZLdnk0dlkwcEZz?=
 =?utf-8?B?Qys2N3ZYWm9hQ2JGNGtZVFBwVFVlMkU0MURCT2pQV3Y4ejlzTXpibW85Z2JK?=
 =?utf-8?B?ZjBnKzBJZk5HQUYxNEpYWnF0SE00THNabHlEM3NjaTR6MmF6eDBzK2VsQlZq?=
 =?utf-8?B?WjRKVGdWM3ppRjFJYjF1Q2d6WTN5akdxVG1rMWZTNzRibFVPaFlxQnBVRXJt?=
 =?utf-8?B?Nk9Qeksvd3NiZUx0OXlUTzBlNUUvcW00ZjdtSytiTjgxbWpqNFpITG9Da1A3?=
 =?utf-8?B?Q2g5YkgzdklvT1R4Z3I2WnM2YVhIZDBPQXNLOXBISGU1Ulg1TTd5OHQ3dCsz?=
 =?utf-8?B?bmhkSi9hVDI2WVNXNkwrcXByR0JsaHpBL3o0dDdBVkpzMkgzNFlmOXVuREpF?=
 =?utf-8?B?Zzl4bk56Z3VmMTYvYXQrRlNNN0RwWTQzK2tVdEUyQVZOeE5TWUxxdDl0SUpo?=
 =?utf-8?B?Q1U1N0NWdXg5SGxtR1lnK1Y2RVJJbERsSDIwZHNNYmo1eU4weDlJWFVaOU1H?=
 =?utf-8?B?UHpSd0FJRWtNTTJaYVpsWWswbjZHcFFnakVGV3NPZm9WdnI2TzhTemhtRVEx?=
 =?utf-8?B?a3lsUmxaMWlwMGZVZk9hSU9mMDBJeEs4bmorbDhjUHJoSmV3eU9PRy8walBR?=
 =?utf-8?B?VSszaVBIQlp6U3F2Q084Sy8yaWswcHBiU2NYQ0Y2SitUQVZ2eWlxeFdHUWwv?=
 =?utf-8?B?S2wyNGgwM25FdlhDcE1JUEc4Um5uOXprclVBbnBvSzh3RzROeUl1ekMwMUl3?=
 =?utf-8?B?M08yOUtOa0lRZW96ZTdLZUg4WlFRaEltVFVVVmVpeHZNVkt3eUZVNGV5eGZw?=
 =?utf-8?B?YnVac3o5aWJzMm5Mdi9Xaml5RjBqdVBwaTJZNHVZcHNNVnhsTlpGREo2QkFv?=
 =?utf-8?B?R01hemJmNHF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1JGNXJTcnVmVHhhWVJQWjFrRndMeDM4bVZCVVEvT1RpM3NCVmg3aEdLd0Fj?=
 =?utf-8?B?Y2JHOWJueDlCTzRKMkRROFp0c3pQd2FQb1YxYTVjeUkzY2hheE8rNW9tMEZR?=
 =?utf-8?B?K01BTHNIZ0d5SXFrR3lkYUNKZW10TGxFNUUrZ2lCamRQOVNNeTBUaGhtM0p2?=
 =?utf-8?B?THpaTDM1L1NWYk5zM1k0TVY3bWgvZDRJZnV2N2dzWGRuK0N6MnArclZDLzVj?=
 =?utf-8?B?eVU2Lzk2eFBBTTdaenZNK0hqamFtMCtuMEMzdHlBNGlHOWJzUDF0ZmRDVTR1?=
 =?utf-8?B?Ymc3VmcxYk1oU1ovUUhra203b3Z1cGVwYytmZDFvRmFCQ1hrcHcyYSthd20z?=
 =?utf-8?B?aUoza0JNdDBzYzVmYjExMnNpTVpUU3FiV2RycnBKanpOYlZyVksxamxpOXdF?=
 =?utf-8?B?anMzRjJicmp0VitZWFR1aVZlWlV0ZTJaN1IxTlFoTWJ3UUZ6RTB3OWpuY1Z5?=
 =?utf-8?B?aWVMS1hUbDNSaGd1M29ZTFNwUit2akd6Qlo2LzgydXpNeXFxL3AyTkI4b1Fw?=
 =?utf-8?B?bUViVGJ1Y25PWFJ6VUtPYUF2V3dXQjlSVkJIZ0NYdWtlT1JuZyt2dUZMZVc0?=
 =?utf-8?B?bzVhWjdBcWh4cjVSMUF5TXh3bVVnOEgzSG9sNEFhL20vc3Juem1LRW80ZmpD?=
 =?utf-8?B?ekE2aENZTXVKK3VBU2VvWnlEcGduOGFyWHhHWTNwV2VFWllHTFU2c05mZVR4?=
 =?utf-8?B?TEhuRk43dVI3TFVERWhIRUlRM2RSVUZhTk1aVlpTMmtCUkV0RUtnVStLd2RK?=
 =?utf-8?B?NFBLUGJjcnVKazM5amx4UUE3WmcrYjk4S0tGdmVCNzBoQzRodWlvMDFzeWZI?=
 =?utf-8?B?VWhxTWZhMXVFNExSQkU5Y09CSGhPc29sb3M3bEhQaGFzY29zc0pkRCtIWEs5?=
 =?utf-8?B?emFOaFk1QXk3OVRudFlwYmRpQnFyMjg4SEVVRTFFSlBicjJXTXpjb3FQYUtL?=
 =?utf-8?B?MmpSbU1FbTVMMDNCakcyelZyb0thdHNSc3hBMDhxM1F0a0o0SGQrU3hlRE12?=
 =?utf-8?B?VDVINFNpQnRJSGdmT2l1VmE5ZlM5Rm9JdURnMThkMFJrNi8waVlvdmxVdXZS?=
 =?utf-8?B?R21DR1Y2djZPUGNRaG85NExqSE16NS9JK3hJTmhoZCtMaEFLSGNKUXlOc2Rk?=
 =?utf-8?B?eWZwR2svL201SHN4aGcyNEhBUmdlN0p6aER0V0RPY0pHbzRrK0lWYnBYTEo4?=
 =?utf-8?B?SkVkL2ZiZVR3T0c5RWk0Qzh6OTQreFgvWWF3d0taM3JZRzNvK1AyZkVSdUlm?=
 =?utf-8?B?RDd0ZjdZWGVMd1FrbXVlQ1V4L0tnUWhVVnVjSGRmWndyakFQT2F6c1pucVVY?=
 =?utf-8?B?SWtYRitEUnFMdmNxQmkrZkhNOE1leGEvNXRRalp2Y2w3K2p0V29ncTJ1SkdJ?=
 =?utf-8?B?NHBCV2hmbG42VDFwcFV4d04xL2NaZTIrQ0huNFd0ZkY3b3RoMFVYVU91ajEx?=
 =?utf-8?B?TjJwaVdiTGdKc3RnRXRYakx1VDVNYkNlZGxRZ0tPOUhxYXpkZ2RRNy9Wb05W?=
 =?utf-8?B?K2FMM0wySkdyM3diK2RzZmVwdGxYYWNZZkxmVU14aEY4VzV0K2xLdXdyVXVi?=
 =?utf-8?B?TUNJZ3FYc3dPb0IxNTlLdEpEd29vY1RGZTE5Q1lmOUF2NmRTYmg2WUNxN1dJ?=
 =?utf-8?B?ai9FbmZNVzNxbmhud1BDWUVmaGVhRGpxUEFqMlcrck5sNWpHaG5LTUdZeUl5?=
 =?utf-8?B?MFJ5czM4RW5zNi90VUQ0UUptWjB4UnYvV3I2bm00N1pBc2RKdWtpazlSUGJy?=
 =?utf-8?B?YXFyeEpUQW9xTUQ5Y0hXY3JEaEdBMVZ3VG9LRUt1Q2diTWxJdHBSYUc0VXIx?=
 =?utf-8?B?bkJKZEdqYmZrbVh6N0Zua1Y4emVqZEdZbldKMmNObkMvOWVvbmdyd0QrUEZy?=
 =?utf-8?B?TkxLbXplTmhmSk1pSkErTjJBMTNLOUUzM1VHeDIvcmplam9hTUFLM3VXYS84?=
 =?utf-8?B?aVJFUVRNS21NWXZaRkU3czYzbDVoUkdyVFFlb09zNlJ0ZUdzR1d3N3FMM084?=
 =?utf-8?B?S3dlUlVrdjVQRi9Tb0xvcU40aFNJV2EySjlZV2hLWk40TEZtVkZaMERyb2lj?=
 =?utf-8?B?dnVhUzhnSGt0TWExVGwvM1JNYmNPM3JDdE5teHJEd2g5eXMzL2krM2QvOXVw?=
 =?utf-8?Q?X6MRetXdlMGwkOGPWBQBiOlq9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bce8694-eb75-4c3d-b74d-08dddbdabc3e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:04:26.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SE6OIHt5SBi3JtHNju46BlHzkM4+cul/3V81vSp52MZNFBnyu0osh5i7QWmLNn7uysFjbmldpGCLSXZy9XWcVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

From: Joy Zou <joy.zou@nxp.com>

According to the imx95 RM, the lpuart7 rx and tx srcid is 88 and 87,
and the lpuart8 rx and tx srcid is 90 and 89. So correct it.

Fixes: 915fd2e127e8 ("arm64: dts: imx95: add edma[1..3] nodes")
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 4ca6a7ea586eaa5fbbaa56be8b821f7c929b7dc4..dbcc557d07f5b8a0ef27d68b7211b07d26fdb9bc 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -913,7 +913,7 @@ lpuart7: serial@42690000 {
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART7>;
 				clock-names = "ipg";
-				dmas = <&edma2 26 0 FSL_EDMA_RX>, <&edma2 25 0 0>;
+				dmas = <&edma2 88 0 FSL_EDMA_RX>, <&edma2 87 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -925,7 +925,7 @@ lpuart8: serial@426a0000 {
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART8>;
 				clock-names = "ipg";
-				dmas = <&edma2 28 0 FSL_EDMA_RX>, <&edma2 27 0 0>;
+				dmas = <&edma2 90 0 FSL_EDMA_RX>, <&edma2 89 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};

-- 
2.37.1


