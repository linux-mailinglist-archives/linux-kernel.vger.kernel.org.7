Return-Path: <linux-kernel+bounces-799373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BEAB42AB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D50683CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B435F36C09C;
	Wed,  3 Sep 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L1lriQD5"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6EB2DE6FC;
	Wed,  3 Sep 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930826; cv=fail; b=bFgWKHk7rP1yXObHcesuPHpCnH7Y+Y5A0eTpukSSg13z1tWHkYnoWrSaTSpL6yHx+8ggX+TWqGRIz7Qu9Jv0ERSwP+wbzXwN1DZi8l6CgluZm0jm4hbVNAodx4+JDJN1UheKi4xcNGQYlJvnGzu2qeh9a2yIa3df6fGV+iv5L7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930826; c=relaxed/simple;
	bh=7odL/WBQc7DCRTI+++WilPexC9k6tTf6t6u6MfZsxK0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=W3g3NV1YW1tqpPQhg91bJptf0yZwnpWfW/NxC8bzL0IyKwisq9g3fI8IGUfezgrXZQ/NA6Ii7Ui/evR4xAD202f50nb4B0f7hMxSlCsHX53aWWgftlTXPlnSRPcX5TTrxtVGGcpRX68bGwrkYazIeWQJ/dCi3YlVQwuDL+Z9JFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L1lriQD5; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xU/vDc/ZYBSWq4FXVW0Il8K7ue5FpzFiXHB6V/cYTE1LxHQVtXXSo91K+JOJukPHai3j0WbMyb8FCXTMjRyty1zb0Li8ImGkrXGf+e69N59KPDYP42OMPkTnIs1/w1GFJv45FU1ZZ82hjgrsJJDs9CiWm20dYHMXTM/L6qzttgM/Sy5k+EThecj/HkWMzJjNZTnlmZOM6JsQ6udp0UqzjHvXf4afTOAEu1K8WABfAlbJdKGNx5qShFIA6eyn9hJkaHekT/erirrIbR4VUL1MUk9ZfXBBC8Pja0e6vy2S3lBupJZRNrXvh3yCH8fAxLn/mCo8rFotdbtn7EeuJAZ0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OG5/FqjlEIVBE44FtK+ZxlfveSk2AA5XbKG8hV3aTw=;
 b=r300/sXAv3ddsK5p4MEGKDO1B9cdH65t0anvYaFGaJOSPAdvUPbt0tRXhj4kN7cmTO4fCZ1xEC01FgE1GhF6/RtS817K0gFwkk4M7NCdhCEmZ8Bjpo5bMRwjokxocd/PBVPf5Ys67RZ8BKzKwagxDJ6gz9PgZAa+4ETa0pQ1LKTmoI1SvLog3gRqdyPBMdrG99oUGCeLcLpSpYc3bw/XVPzZ2zAANGSQEv2ybCfmi3njChgDdCpq3lhL8pvnPduJB/auCmW70cJHG3/0DyHMt4K8IO6pRBdavVg9g8Ha2vrMlBs4aZiGIgksztT62ROAILMJjn6XL9ZhUXb5rrTLzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OG5/FqjlEIVBE44FtK+ZxlfveSk2AA5XbKG8hV3aTw=;
 b=L1lriQD55mmrPaKAnsQ/fbQn1PD1S3AoWlkc+hN4vclYLhStOZ2gQKlM5kH2WprKmiLHSwN3psomrm6sqvxs69l9LMd5qDbLSmKELZ//Wc28p4sHqBpa00t9XTgHOK7Xxm+4zK67lmST3QUZlz7P0G7Zcqbi/Hf2L1IZFeIvsgy6XJk3jCOj+z3yLpwSHF7aM8XQGT1CrnVA5MTnNhGdD3ZycvgYeQGI1wiHiwq1qxw22kAjvIcdoyohCJ+k1LTeJjbH4kH2MQxFRxmAMroifmZYBvdHocw4f/rPiu402v+d+6i803cmzpKWqszpzVJARRtGHvaQHP1s9uI/0xnQCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:19 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:19:57 -0400
Subject: [PATCH 04/16] ARM: dts: imx6: add interrupt-cells for dlg,da9063
 pmic
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-4-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=2180;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7odL/WBQc7DCRTI+++WilPexC9k6tTf6t6u6MfZsxK0=;
 b=1tKpuiG5ADyEJY96CMx5kgywGo8+PqV1DtohvlrzGTmi6EN/+bwA50rFkzjk4HJeJq461lQs+
 Styh+/MbMQHDWzwEpB4gf/GfLyC+wDjWCXdLrfLVR7z2e00pMiQeW8e
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: b4892945-6dc3-4374-c11a-08ddeb274d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bytsYlF1b09NNVFiMXY2RnZ3czJNMHJzbmQ0SW1xUTNGUjFkckUzbVFLa25P?=
 =?utf-8?B?WFVXSERRaWovRk1NWWorMURwY09kRnNta0J0cCsyNjJ0ekJhT3RPdjJuTUpl?=
 =?utf-8?B?dGVSdW1nZVQvTVQvdFpnNWZWSTlmZW13WjFGNGNrWnJOWEdGT1BLNzJXYS93?=
 =?utf-8?B?ODk0Z0loVWlnY2hBRmorVlpIcHZDQ2FRWGZwWXptTUZXcnBvZXZIWFBOdEcw?=
 =?utf-8?B?NjNXMDVHNUt3RjJ1R3FpcWdUK1F1TjViTGdrb1VmN3JDTGJnRGRRbFUzdTl0?=
 =?utf-8?B?aHRoQkRnSnIzUXc3TW5vd0o5ZUdJei9oalVCa0VlUTY1YVFMZUUybEphRTll?=
 =?utf-8?B?amNudTlkQmFVb3RsQS9jZmlybUJIeFpNRlh0WTJ6dFZtWXBNd1M0RW55WHQr?=
 =?utf-8?B?QkNiRFE5VTZvZWE1SkJ5OGU1UnJwYTdndzd2ZjNZZkgrRWxZR3g5R2FCYytS?=
 =?utf-8?B?cEVrNTZKZjMvMndzTG16Y08zb0NHN1I5ZUZHQTlKK1k1d2JFRGdCWUI5Rk0x?=
 =?utf-8?B?Rkcwa0R5OVl6TllhcC9rM0k2M2djajh5ckF6bmkxcjU5cXNTL2RjdHBBZ2lJ?=
 =?utf-8?B?aG9OS0FtWjZnck0vamlmRXMxMFdwWWhsMHNhZzhPb1Jxb3o0U3RNQXNKMmg0?=
 =?utf-8?B?TTVSQWlFUDRxUk1BdERLK2NsWjVKTUV0SEhlZ0lxRDdGSzE1bUc3MlhVQ0R4?=
 =?utf-8?B?MUhGZWo0Si9paXNaWFZWbTVJaU0rdndZbU1UT3V5dzRNQm4reUM1OXI1UUF4?=
 =?utf-8?B?clVMQ3pFUmJoRkFJbUI3cnBsZDVuZFEyRklCb1R2a3RhMEgrN0RxZWNWTUNJ?=
 =?utf-8?B?bVR1TzFFTEszYW1idDZBS091cTdKRWI3MkpiQzdPcjRrN2M5R05wNVRjSUtl?=
 =?utf-8?B?YnFjWU52dzVYVnkyUWhoVjdsb2VwMHBhT2hTeWZNamhQL0F6UFB0SkhRZFp1?=
 =?utf-8?B?TnpHMWZJckhUeC9JWHplWkFld1VtZVRMenVGY1JiOVZQaCs4aENJekQ4Wmdn?=
 =?utf-8?B?V2hHMTV1cWdONUhHV3MvTEh2VmdvQndFNkJnbjd2NGRTRDlqS2c2ekhvOWhI?=
 =?utf-8?B?Sm04RE0vSlRqZkhqbi91YmcvWHVWMUtLVjBuc0x4UEFOcGxEemwrdUZaVmFO?=
 =?utf-8?B?aUgwcVhQcmlvaXRoMEUyV0RsVm14OHJ5V0FHNnp4czVoMSt3VjdET3A4ajcw?=
 =?utf-8?B?NDBEbTNVNnJkK0lvVUZuRXBMNXh3b2dWYmFKbnRPcml2ZysxNlBFUUsxdkcy?=
 =?utf-8?B?a0tVNHpOWURWc2xYdTVON3NyMS9oYm0yVHpSY0Vsc1g2TEhiWmVvRklZdmR2?=
 =?utf-8?B?a0REMXo1Zm1rdVJlR044bmx2bkJ4aXpCdXdLMlA3S0Y5OS9xZi9qcmtUMEsv?=
 =?utf-8?B?QXNPQ2RYK2tlc0RqWGxQWW1kQUVrQjJYRXJ3Uldsenc2ZS8vakdsUURpa0lk?=
 =?utf-8?B?OE5FMEt2WE5vQWVoTldTMHBXSnlKc0lWM29EZURJTUQ0VTVBSHlBeS81aVFW?=
 =?utf-8?B?ZEd6WGw1dTJRUWhOeTJ2QW5GaXRibWJZaU10SnpiWmtjS0JsTW9qVmpLOXZB?=
 =?utf-8?B?N1BjUzY2RDVrZXRLelIwVU5xYnJvZnFqS2F0dVVHQWZNL0pJbytGdGplQUdm?=
 =?utf-8?B?K0R5eDNwbSs3Y0xzK3RPVDdzQ0p2ejJDcjExcEovMFdyWlR1ZnlJYm1JNVVT?=
 =?utf-8?B?dUVsUmpUZ0R2MEZzckt3SGNCNjVMd2tLcUJtdWwyUDhMSnlBYnNFaVBQUkNl?=
 =?utf-8?B?c0trUFFVeXFiT0lJcW1UeXZnSThFWEoyalExUmdydnZWYktlTkdoZktwd25G?=
 =?utf-8?B?YXlIZTJFb2pTS3VJODRKSms1VDBRQmxra28yTTlHa3FhSnVvOWM5QUYzdTFP?=
 =?utf-8?B?YlQ5cE1sckFPcUgzMHZIRUdxNit0WldXQkU4MXpjQ1hMNjFPWW1adE5jM1Fl?=
 =?utf-8?Q?TpgHGIyfKBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWRKamxTVTY4ZGlzWWhYTEhQOXU3TkZ0UHd2eWhYRVlBb2FxS1Y2dGlzZ25M?=
 =?utf-8?B?TG1PTzFjc3dTenVVZ09iU0Z3T1pLUi9jT09aNi9qem5BSjBkZ0UvblNUeGNU?=
 =?utf-8?B?WUJ1SzRIUUdacm5Vd0lUbHplWGpGRy96NGYvVkNYcVg2YXdWSlBVZTd6QVBF?=
 =?utf-8?B?WDJCZEdIUVR0Y2IzMmhTQ3dUYjh3L20rdzIxcVBtQWh6bnd5N0k5Qmx0dEZO?=
 =?utf-8?B?SUJEcWg2bmlNdzc5VWN2dWNPM01xbE8wZXorU1NjeUducnpmNHFpSHpybjZp?=
 =?utf-8?B?aDlrODE3R2NXUi93T0U0d2xOeEYvaU95RWphL2o0bUZTYjYrRFNnU3ZtWVNu?=
 =?utf-8?B?bllKa0FqSGhpempSZi8vMkpMcVZoK0d4L0tpWTN3djVqM09sbllNRFFHT1hB?=
 =?utf-8?B?Z0NiWXR6TmZCU2ViV1piSHhiNjB5T1Rod3ZuVWRmUFovVVFOMGIxdlNkMm4r?=
 =?utf-8?B?N1p2Z1o1MUhQYjU3S21aOHpxYmZxSnpnSXBsMVNtbCtsVGNqRnpTZG5zQnhj?=
 =?utf-8?B?US9HRGozaDd3eVhTL2NySnB2Y2VSN1IwbTMrTkdxU1p1QU1oSFY3Z2dXRkND?=
 =?utf-8?B?UXM4MFVkeGo2dTVrSTlZQTlkM0xuczNTZkl2UUlwSUlGM0Voakl2ZDdpaDV2?=
 =?utf-8?B?a2tEcmFBY29lZGNhUjIrUGJ3eTRqZkZ0RWphTFF4ZC9GWEVENy9BT0g0WTlp?=
 =?utf-8?B?Vml1dGQreS80NmM3cjBlZmFiY2JsOSt2ejhkNk1JZFIvbTdBaWNDblBLR3ly?=
 =?utf-8?B?bytMdG5TRU1IbWJhQmx6c0kxM280dkRmUVUrRG9Hbk9DcWxreU9ROGJZS1RE?=
 =?utf-8?B?VUdVaFBsRmpMK3prbGloeGkvMGFzcWVjMlFISmdHL2JsYlFMeUlScXd5Qncy?=
 =?utf-8?B?ZC83OU5IMTE1ZUYwZ1ZNeUpnU25WbmZ1cW1QNzRhOTBuSXN4YS9ucC9FTGJT?=
 =?utf-8?B?SFQwOE1tdG1mN2ZXVGI5NHA0R2o4enBtTnNZL0IvVmd1TDBSc1dPNmQvRUVB?=
 =?utf-8?B?bDlJcTZyei9WNlZSd01RMDhmRTZqckZyQzJQY1o0T0U4WmpjUFg5RnRjbVlx?=
 =?utf-8?B?NmUweUpOMW00TmFpSnpzOGRLVEJrakRLY1JjWWJvNFFER01pZVBEcytmL3Qv?=
 =?utf-8?B?eS9mMm04QStVRDRFa1RuL0FHeHZkNjNtODc4S2tXd3luWjZXUXBGV2VDNTVz?=
 =?utf-8?B?cTZSRktEWVlZOUVYNE1YYWQvL0RWaUYwYTUwaDkzcUg3c0xnNHVzUXZrSFRq?=
 =?utf-8?B?c0dwTkI2ODVlZHBLTHpPV3hwN1hDVWNvZmZ5MzVkRGFoeFQ1bFdVSnNNMVpx?=
 =?utf-8?B?MzRLYkgvbk9INS9WU1A5T2R4aVE4aVYxemc1Y0o1QTU3V05nd0NLK1p2alB5?=
 =?utf-8?B?aE9jZ1NHQkM1R0ZJb1l1Yy9lcmlQaEFqSnVkUzJYY0JyRmdPM1pXem1VVDJN?=
 =?utf-8?B?N3NTUERIN0s4Y3FmV0NjbVhXQ2dsaldabGdFME1NT0tVT1F4aWtJWVVCM3U1?=
 =?utf-8?B?QU44VDJIWTJTajJYOXBiMXIzN3drNDBxTWVQemNoRW5obkE1MG9TTldPYXhu?=
 =?utf-8?B?cG9lYVNiSE1peW9GNzZjQmFtT1NNc25oNWoxUnF6bElWdVlGNS82M1dCTUlN?=
 =?utf-8?B?NDV0MnRpL3NNdnBXcnlXZXRCTm0zYUdtRVFiVFViQmdTdlhKejAwQVN6NUk4?=
 =?utf-8?B?QndRNSs2b3Fad3dxdU1pMnRqVGYvUmQrWjV2bkMvdE9kOXRXaTA0dkx3Y2NH?=
 =?utf-8?B?RFlNOHVrc2IyekdNVUswUVdVYTFnb3REdHd0RzlZVzYzeWs4TGt6Zmd4dU9q?=
 =?utf-8?B?aUlEM0tYQmdRbkdTWHV4OU5NN0lnZFZDT3YrWC9NUkZuTThlZmh3eGN4b2xZ?=
 =?utf-8?B?MkJQZW1zYlB1cnM3UGd1em5TOG5vbGJyTnprMkJmSTBBbkltT1gyZUpHOWRv?=
 =?utf-8?B?azNwTEtLSXdGK3dJc1gxS3VkQjFSUnZhWG1za3VudTZwTTJ6ejV2bEdsemZs?=
 =?utf-8?B?MEloTUMxeUNxQ3FDbEFldnJKSUVYcUxlUVdtb3pDeFRObTZtdFVzd0hpRzkv?=
 =?utf-8?B?VmsyTUZocFJ1WkRrTVBqbXR5VlUzb08vSEZvaTZoZjEwOW00VTlMQVJCVExq?=
 =?utf-8?Q?DyTh0K2oDc2aC52FE+bDH5AnI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4892945-6dc3-4374-c11a-08ddeb274d8a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:19.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+ePMTVYedoHZmDd+bDDSH0q5RVSCqQH86KY8+Sbj7FfVs7u8Ao8nEQcYB8AfH/RKeh3UEW+FOJ+BBGrNstwqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Add interrupt-cells for pmic to fix below CHECK_DTBS warnings:
arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dtb: pmic@58 (dlg,da9063): 'interrupt-controller' is a required property
        from schema $id: http://devicetree.org/schemas/mfd/dlg,da9063.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi            | 2 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi | 2 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi
index d77472519086bd749be6394282ad1a49a8b14064..53013b12c2ecbfab8cc02a08d2ad0bfa453e7395 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi
@@ -222,6 +222,8 @@ pmic@58 {
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio7>;
 		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		onkey {
 			compatible = "dlg,da9063-onkey";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
index 7cc7ae1959882e79c2ab2bf0ca8c986dc54b770b..5a04909ff9ee13db0726d2bd6710cdcfbaf83faa 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
@@ -150,6 +150,8 @@ pmic@58 {
 		reg = <0x58>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <04 0x8>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
 
 		regulators {
 			bcore1 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
index 6fb873c2983fc03195ffa46245ca89813ca3d999..9f4e746beb2d5c66b6b6e61e3bb52115408d6fac 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
@@ -225,6 +225,8 @@ da9063: pmic@58 {
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		onkey {
 			compatible = "dlg,da9063-onkey";

-- 
2.34.1


