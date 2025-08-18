Return-Path: <linux-kernel+bounces-774487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED38B2B2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BCC520FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446EF17A318;
	Mon, 18 Aug 2025 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OgExMqYS"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769327B516;
	Mon, 18 Aug 2025 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550143; cv=fail; b=VdBmHch0uwKFeDQ20DArWG9SskC5U2kegwmAVkNLvFmYNkGnTANkSitJbrWNaeO5/IDG/2bQSa2lk8o87dO6iyknbb8ay4D/gUcIB8BoSz8efu5WQuVhHhFC78gb9wT0UhOZbM5aB+eEkuG2OauSciR1wPNuf5RyNr5rqDtdx50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550143; c=relaxed/simple;
	bh=DZGv3ZfUtBR+iiZSZWrDuXpzwlKNeRYj4s46ZDAzOsc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AwHilMF/reUjWJcvKB4rjmPMSgJoQcCz+tNCWiz0014ppaAJmzWTi4TMU0rY3Ws3U8n/3v0GovC2N8uxtv9qj9VzRTjKrz81DorD5a2FCMw5SCnbT6VlYwkZm06w10WEsARZr/UjvafVlyTIcpIySR2/wQkU8qzDBY3nos+iNpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OgExMqYS; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iASTa1lukLTyckF1UyLfbQO1tjEe7WE09O3v9hVINxIz4lGcwbbTWtKtka2Wq0jTbjk0uNWjJP8D/sMF8b2joDfGn7HUUyN9qmjYtZb1Dc3tfL82XF+WcF7hNNd4b6jgxLOhBf+RWLS9sJmWiBpjeGC52htQ+JZjAFz5y1fFTEHiVcbSToi7TR166HJ8RwK2auFvTac16b/LS2AYyTe7mmBxPrP+4zMdUZ6yI6k6TClkkDMTCP2+huBa21l0MmORG0OfF3sI3LJpbipWzifMizsmpfyQlQP8UnchP4FHK9xiaPOiKlkCKcEHrCu0oMYvsJTelAdBfCgKQN+OPeeBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O+hq+hY44DfDaNpQgIGblS5i6+eiUSqEcA1ZYKVXm8=;
 b=ZjCnvwQrltKT6/yLcXtslcLmMOa6aa5gHhxjIgJk68CuI+iJuBu1IghaiyDHrDjdbpdDnlSY1pjNKpXSUKIh1bIiwDJ68TzNGqVFIrqfaUGDL3MmFNMdg03qt37qv/srZ1BtmAeIpToeWxkpUWw3w6QJ9nXcurZm9SAiDFABEYgK7ORV1lfdSP6apmFWuFnCMQPqYrh288bYIKF5FuvGOl30btFTzPpk6g4D7FpIstYmzMtXYnPgVOuedb1d54LJW1YHi5g0sv1gxcep1/xyN5XsDxa1uniuIuG/4wFxm3gFeaV3honXRjo4mW3EQ6VBl5rCkW17jHldbM6Nft9ouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O+hq+hY44DfDaNpQgIGblS5i6+eiUSqEcA1ZYKVXm8=;
 b=OgExMqYSjkZ+JL2T0Mp2cKeNBl/pCvaMYeBJ0qQW1eCN38yCJJv2bUwmKCw4P28zi3qXAQhhuzk7D7ToDISoLk5SEuw6Sp3HASq3IK1Vku3BwM3+qal57nA4reqPYaaiCHtVJVyEK+O0aVzFpIfox3c7pkvY2+LxzRexzD9IkWjdG5fb9mU/EFCIoLumfjuBFxxQ0cvqaz61/lM2ud9NNv4Puz6j7Y5SHS3BgJkUD/CCcbbXh2q4YoKJYOcKh4vV3mOvXUKCF0SJJPYCvXH34XoQZCF3oFu373etSL660tqed3NKEA1OrP+tYtLVJb/G1mM8kz5w6QyL6ghEGroZ8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9009.eurprd04.prod.outlook.com (2603:10a6:20b:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:25 -0400
Subject: [PATCH 14/15] ARM: dts: ls1021a-qads: Add fallback compatible
 string mdio-mux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-14-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=1003;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DZGv3ZfUtBR+iiZSZWrDuXpzwlKNeRYj4s46ZDAzOsc=;
 b=8CdfEUmbGuPOngzltD9WCWErMmChIhxkE1P2tGZnI68AWG4gUHgmRavxSYdvq42dtS4SNy8Dk
 er0Ep0fBq/VBA/RTlTLew+FOnkFAMT7BN3cVb9XiEY8qkbiY+4yFZ9o
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 4518adf5-f0d2-485c-4359-08ddde98a52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEZmZzVNQ2NETS9BWWhycE1hZlBZSGdwZVE3Wk85YlZ6SG1KOHo3WUpzZGxB?=
 =?utf-8?B?YTY4WFlRaktsa1BQWGppRmpxZDN4aU9vUFlGMjhsWktBNTkxYmxwUUl3SHlS?=
 =?utf-8?B?SUQrU2FROFl3NENsNDVzUDR5dlRuRUhkWER3TWRVdHFSK2xJZ3N1cEQ0N0do?=
 =?utf-8?B?bmZwa29XNUdNWHhYSEt0ZWE5cTU3ZFUwYTJVMkpqRzBpWGdSL0dhWDEzZ1Bj?=
 =?utf-8?B?bUo3WGxSWVRNd242aGZwMmRNRGZNMVJMTGI5UFlvc0lhTjdmdlhQdzF0NzRl?=
 =?utf-8?B?SGR4V2dNeFZDRWpsRXVzcU5jb25jZWR0UWNhek1YTU9pOXlIWjRiNncrMVhU?=
 =?utf-8?B?dlhkNC9NY0ZEc3pzRkkrYjZoZUIxY1ZFaUxmQ281Nnp1QWYxV3RUaUVHTnlM?=
 =?utf-8?B?czZpTm1KLzBHajVoWkRWbGlHU2N1ZEViaDFqRnI2VVA3UlBiQ2l5ZUZuMlRH?=
 =?utf-8?B?dDJnY2huOVJiSGQxdVBtMlZ0c2lYUEJrWHF2ZU1jL21JVVJDTkFZdHJmbThy?=
 =?utf-8?B?anFITTcydVVkdzQremE5UWpqaGFUVllIaFltSk1WYTVkb1VuaG9jYTFualRG?=
 =?utf-8?B?cFU4TXlqcFhUb2Y2VWZxU09xbXpiWFpPeHVNYVVIY2xmZGZLY0tnVGlmdktu?=
 =?utf-8?B?UmZmQlY1UEJtR1k1cmpycGFIK2F1SWhHRHczazJvdjVGaVYwUTRMZTd3b0xL?=
 =?utf-8?B?R0czZUg2QnhpU2ZPQnBUeHRYOXltandKRW45ekFoYkk2R3ByRUMxYnVpSTFh?=
 =?utf-8?B?cXlvdXorMlJ1bExKbFlwbFBqbU9xQmhxc3Bya2tRRHpwSFp4M0czRXpRQVBr?=
 =?utf-8?B?ZGJNM0l0UDJ3VStUUUhQZ3BBMjhqcTJWT2hMcFhQRnFkbUZ3NXhiU2JzYWJl?=
 =?utf-8?B?dVAydG02NFlVb2xXT3UvbGVwZjhvVExKZ25GUVhLa0IzK2Rzc216UUZKcjl4?=
 =?utf-8?B?ZHg2bm4wN1MwamxwYnorMWszRi8zTXYwNjU1Ri9sTlVzOTdpKzRSWDF3Wllv?=
 =?utf-8?B?SU56MENzdllWbEVUaWNDaUgybTNOSmRqL2JmTVUxT2svY1RNaTZDZEFQKzlX?=
 =?utf-8?B?cFRBL1A4WC9OdTRBUEJIMVJJSU1FU25UVmlITm1JUDdhMmtzbHc2MEhDWjRJ?=
 =?utf-8?B?cUxtWWF5YnRlM2NiYVlreENka2FneWFOZXFMYzJaOEpLQjB2MUJ4NDZsMHJB?=
 =?utf-8?B?SlNNd3BWM0d5YkdRY1BUbmdpUmkwbTlsNVMxb0xmbTNaVHliSklDazZRclh5?=
 =?utf-8?B?RGpiOXUwMEhrNFF3MWhVemZBTGhzSTc1eFhQS2dJdHV4QjV3aGtMNVowTkNR?=
 =?utf-8?B?RE5GSks3ckdkbDczZmVuRWhGVThGUzdHeUJJWUxhbUdsSmdQUFFSMWhNZ0w4?=
 =?utf-8?B?ZkpFeGN0ZW9vRkpjbkQrcWJIRmdBYWU4Rm5QMEswb0VtRFBhbHpuNlR1bVhE?=
 =?utf-8?B?bmVkbVBhczcvTm0vUk9YR05qUjBPQWxlanZaVmUva09RMXU4QW9SM1Jvb1Fj?=
 =?utf-8?B?TnFXU3NTWlFhWmtNNUFUZUpqUnYrYVEwcm1kTnBnc0d0REZ6SU53NEZGeFJM?=
 =?utf-8?B?aFhhdHpYYklwU3F5QWEzd3IrRGZsWGlsTlJUZWVWRGx0cmlRQTdxVEtWSHBN?=
 =?utf-8?B?NC81ZXVYVzJralpxYUQrVkZhQWljNndBKzRPS29iT3NxQ2xXVDFHSFhXN1NP?=
 =?utf-8?B?Ni9rZWhRZGN5emFtaldFQzBka0pZcmFUYWxpSGdzM2xGZFFTSGE5MDhlaHlE?=
 =?utf-8?B?VGt3VjMzY2o1ZjlzRzhIZnB2Uk0vQ2J6S2ZldWRpS2hXSmhhQWVqUjRoRlRm?=
 =?utf-8?B?czU3c1EwYkoyTGZnRFF5QUlDTWpjUlVxOUVQcWpobXpHb3JuSkxNN0xxSzhi?=
 =?utf-8?B?eE1hejVSTkVtTzdyT2JUNDhueXVNaktnR0xjU2JBS09ZS1JuUC96b21ualBM?=
 =?utf-8?Q?aSjN512D8RE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHRaM0lHbGwweWNVZm9hdmltdWFCL3Rya3F5cXMrdjlYQThUcjNtd2w1Vmw0?=
 =?utf-8?B?VjdwUytRc20zT252cmUvYnNTUlAweHRrcG10T29VVVdiMXNTM0hiSFgwRndL?=
 =?utf-8?B?dU5RY3RUT1pQdThET0IwdDFjSVFBUnF4R3JvRlJLYVRENzVHTW5jVnlLTE9Z?=
 =?utf-8?B?Ui80UW9uZHpoOG5BTENjN2kzNnhSeFhTdExGampzVTFyQjAxZGRFbDBWa1Vu?=
 =?utf-8?B?K1B6SVlWY3hWQlVoejRON2gwamZVc1pORUJ2d1BSU2lpN2NBVTQ1YjdXRXRL?=
 =?utf-8?B?dlhoTmNPZCtCUksySjQ1QnpIKy9xSVRKMWEzYkViUVJ5RjdKQzhwQ3RmRGdP?=
 =?utf-8?B?bkl2WHNoYWdCL0ZmUHB0cHRxT2VVWXpNbVFweTBDZytoUmd3NmxUb3dBcHpG?=
 =?utf-8?B?a0dmRFR3cnlvb2dXdnZPY0hvV0dTL0xPbGpGYlZpVndVSzZXY3YrTG5EUzVV?=
 =?utf-8?B?aVZSOHhlWEhlYnQwTmRTbDNLaDRwOWRFWnVGR0NicGd5dWppMVRrYTRFaXda?=
 =?utf-8?B?T2NwKzJRZWR2TWtZbTBZenVONkJCYVZoZzlFQmtvTlE1MGVrRUNSNWZWeE51?=
 =?utf-8?B?QXNVZUhmZm9neUpKTXpzaWEzU05iL2FtakVybGpCMm95Q1N2VVNQS1FtTU9h?=
 =?utf-8?B?Zk4rM0RtbkRLWWsxRUJJUjhCMVowU05QM2lickdIV3ZkUzk0L2h2VjZ1d2ds?=
 =?utf-8?B?aEtvYzVlMjkwaU1EUUJtMGdHY2x0azRUZElRS1hxcVl1ZWZpQm9hOVRNZHBu?=
 =?utf-8?B?VG0ySHY0ajR3amFPdWg4RFNxb09yNmhmeCtvNWh1Qk1wNzVlcmpIN0NvYkpB?=
 =?utf-8?B?VlRsZnJFaHQwSUdDdlZ1QW13VHd3TDFoL3ZkVXBGMU5MaHpjajFWVExnRlRI?=
 =?utf-8?B?dDdBZWxFRnY1cWJKQTQ4cWFIZE05NTBXVUttUm5EUjBXZEdmaDcyMjkvSW1R?=
 =?utf-8?B?alVINGdMZHpUbXlvZFNyUGNEbHI1YnRlVHlxQXIwbEVIK3k4UmphWUNhd0VF?=
 =?utf-8?B?SXBIcUJFTlcyMWhyYzlhSFpMS25RdExHclA1RGN1NTBxRk91RzZvMnRTdlBN?=
 =?utf-8?B?U2J6QWloN0xYeWd0cWZ3M1JpUndNVXFXNWVjOStHa2ViTjNNK1A3S3k0U040?=
 =?utf-8?B?TmN3M0dJZzZmNkdxcU93dkdjUUVKZzlIa1dGdlNUOFByRVBhNTFRLytBWHRC?=
 =?utf-8?B?bGNVcUpmbnQwOXVlMG10TTBwck1YTzhIeUNDVUpSRkNoUlhaOSs3cm45Z3lP?=
 =?utf-8?B?bldOMVVJSFc1SmtURFYxOUc0ck9NOWtQZEg2L1J6b2dRR1VTUHF6Vi9YQzZV?=
 =?utf-8?B?alN1Y3VGR290TmhzdG54eWdNenBKOFVGYUlBeGFoaXpMUlhhSTIwMDIyYlo0?=
 =?utf-8?B?T1NYb0YrWEJJczRBWTZ4a09BNC8waTdueVhVTm96Q3hnQ1M1MjlBTjRZZjUw?=
 =?utf-8?B?UGNiL2dsZTdXWXIrbnp3TXpmelRqRklTdE94ZHpNd2g3UFN2OGxCVUJaOXFp?=
 =?utf-8?B?TDhVT0lnaUxKNFpQTnZ3NnBVMXBGamc5YmxqV2hxcS9UWWU0VzR6QzNsSVNz?=
 =?utf-8?B?S21kZ3Y3LzJkVXQxcW9ncU5PSlZaWHVVVlVhRzI4bDFyQlY2M3VxTld0bmwy?=
 =?utf-8?B?aUJBZzEzNGlsSFQzVmtUQVFNcnRRTW9FYjNsOHVEWFdBaWg5UnVyMXZmS0Rr?=
 =?utf-8?B?dHA2Mmt3WEdoZDRLRGxwV2dXdVVVU3p3SW5TMFo2UjF6SHZRUHVhTWhqcGlU?=
 =?utf-8?B?Z3JnZUFKYy9XblhCakxiV2JCSWt1VnNiS3ZrbFEvWktUQWNnQjl4UkM0bGEy?=
 =?utf-8?B?alhyY3NJclVwZkhxNUE4SzFFYjhzbmlveEJjTGJqQ0hJd3VrSVNZOVlmeGNX?=
 =?utf-8?B?RWFQampZd1JwUUR4TzQzdG1lT3FUTUdzT1c1bFRFdzNRSHRXSEE5amw3QXhP?=
 =?utf-8?B?eTVKMk1vS0VNYUFsWndnUWdrQXlBdjhNS3VQdTZvTW5NR3F4SWR0TkVjSnVG?=
 =?utf-8?B?b1NoM0I3cnFPUkJYMjRHOW9ZQnczUkxvUE9td0lpNUU3Y1A0c3lyVnBPa0xN?=
 =?utf-8?B?TUNyajNyNER5U0hNV0VkZnVKVUN3NklsT1NNWk9EMmN1NEU1SXFPa3Y5bVZJ?=
 =?utf-8?Q?DeIw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4518adf5-f0d2-485c-4359-08ddde98a52b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:54.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QU03LykeNfV1Wto7W55cNOVTZT/KfwQTg5zxVp9g0GLjDgP/vQ8R68oOUt0yxY+7zXP/A9K1qZLlIVsM1bMuzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9009

Add fallback compatible string mdio-mux to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-qds.dtb: mdio-mux-emi1 (mdio-mux-mmioreg): compatible: ['mdio-mux-mmioreg'] is too short
	from schema $id: http://devicetree.org/schemas/net/mdio-mux-mmioreg.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
index 8bc8ff2e3b03d6eeb43d79fe0555842536ab735c..ce6e950ff10ea10b9431144e5147e75e3c0ce6cb 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
@@ -212,7 +212,7 @@ fpga: board-control@3,0 {
 		ranges = <0 3 0 0x100>;
 
 		mdio-mux-emi1 {
-			compatible = "mdio-mux-mmioreg";
+			compatible = "mdio-mux-mmioreg", "mdio-mux";
 			mdio-parent-bus = <&mdio0>;
 			#address-cells = <1>;
 			#size-cells = <0>;

-- 
2.34.1


