Return-Path: <linux-kernel+bounces-856541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C46ABE4706
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88A2A508B35
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C3836996E;
	Thu, 16 Oct 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JaeXl5WT"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8D3570BF;
	Thu, 16 Oct 2025 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630438; cv=fail; b=CjlHyZ90rMFvl5dLTAnEP3VQKvczfW5eFfBsAXzJkmArB+R55wkWdznjSAJmgtsFWnbbtkg/cAFcdOJd0syiPLySqSXCTTk6KRQUhIb1QbB68jamLnGt/gkfAEMeSYgnh4Ex3HYej4x+VnpEAHz7eqJvY3ZUEBNeF0E+PM8Gs1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630438; c=relaxed/simple;
	bh=lku6LEUNLaDEbJgtYd21vyazgkoJ0tgikQxZ7UlDai8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bCzSRQBr3K+BrdCxpDlDhMks52EfZuEN2U1W6rDFeHf3LQIy3vt/7GzUDfvpk2XKXnOlc6hR2zKD0yWQzNmXV+etwGmvDGTQrMAfPJOxLtONC+ajQ+wbASGK4ZbvsT28gfCMwZkC/mNjG93hcRTvsX/R8aEBGlD47faOXeTE0o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JaeXl5WT; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFZ6p74mixu45FIPaeNjcN6LmBK3usaEPa0m41arj5rW5Io16tZSR5LKGz37NB9l8aA1FjttzbdsRowOoTKkpmZueHA4LK3lr3PXWlF7wo5YzqH5jM82KCqDlVwpHq0DsEx6zYATxulKvobtmx7+jL6l9EoNznfExy/V2aJGeD/G4AaUlJHdrBj7mcErqEDCRiUQPT0Hy86ks6MTL13vtjJKC4HsqTmNnqiNFTfPhsrVlOGlmQqKAj1hJeWsGOhHJjAFEpV0ogEFUtCAb5I1S0WscaMkUZULke8ErjOstJBx5ghqnyEwCu12hnFVzTi0TNETyFrNdYVXcDwf1RmZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/NMBWR17GAx508bwsDdoerARHmBPnidaxou5gkzLnU=;
 b=tdgqiRnSVnL1XDqmfTgjbnJtyLDZ6Lmghg2xBcnR7IqkQTvdEFh+jCc70CktqtqCpjctmj0ZYpnz6oGbJ/PQYzhOBD4R9u+ofnXzsRUSnTeRGa3JoHLHb+ZGo6YVX53vll1aa82l9b4J2Rqm0cvU4DJrltFiqzMfe4gIwQWpTMunG8sPuGuNG9mDkw3Ll9++l7rPZnUtLXCq6VjOsralf8w4cK60cKqOOL5WA3aHPxb2UX9Zdy8wtHj6Y3vmJEYVnwQvhg38VXQZ7wCyri0oj4wSENPL961oMI5xvGXOotCIBT3K4cbIEvb5O0GJPjkp89Mfq5ngUzaCndQ8MkD5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/NMBWR17GAx508bwsDdoerARHmBPnidaxou5gkzLnU=;
 b=JaeXl5WT0QCrnxBmLerc7XuyxRw7yNNKHZTyMMiBbmcRoW6Aa4ykK92WHBdlfBuMpg7SD+0beOOOJkUXVeWuVWajmhDlTsWzKRSP5GsftVIsZeQhYEq+pi86Zi9fLsw9mMd4uqVY5s5w3P60j531b6RJ7mrYSN54HKGhaXPatAxe/amhla3jJ7Ea+RtiSR1caVXr6znTWvLyhuWz1Td6KmllX37oNNXlZNQsIwFv5mJurLI3bxurPqEqk0A0nN1gQ+eNpnif8tHcL7qjeiLw13Tl9dZY0uh5wS5XIq4YdZ1E8gNjX4I0jeCgNOU71T7e545q6sIWKQRTuASkpezwKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10069.eurprd04.prod.outlook.com (2603:10a6:150:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:00:34 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:00:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 16 Oct 2025 12:00:08 -0400
Subject: [PATCH v3 04/11] ARM: dts: imx6qdl-ts4900: rename ngpio to ngpios
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-imx6_dts_cleanup-v3-4-baf2814f8a15@nxp.com>
References: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
In-Reply-To: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760630413; l=943;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lku6LEUNLaDEbJgtYd21vyazgkoJ0tgikQxZ7UlDai8=;
 b=lk8tI6S/D1w4sN2lTlcPMDDdklgXB8Xob4hd+zexRw9EYiauDYwENOV72HaLDLmJYu4ZQ4kHH
 /VH4V38Tpv/CHeSDxGf2z9gqgN3A5lg118IgpM6T7Kj8iu/Q+Ka4fZi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10069:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f77d63-0775-436a-93ff-08de0ccd2267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1o3cEw5NC9BVkxWTkZvT3RndU1lMXg5LzYvODR3b2FaN0NLN2FJWXg5V01F?=
 =?utf-8?B?K0s5bTgvazNnQXpPY2tGOVd5aUFpSGFRYThLRmt3NDJqUitJUFA2azR2Ykdj?=
 =?utf-8?B?VUsrQkpzam5MbUhiWk9uSktRU0pCaWJuL3hpTUhvTTVUSVliUU5KOUNvMVEv?=
 =?utf-8?B?M0RvUVBrSVRQNGlMeXA1QmFVKzV2R0xCU2ZOcnd0d2NQeU5Wa1ZLdVcrWXBt?=
 =?utf-8?B?ajZvTC9oL1ZITmwrcGdzU3FZSXNSdi92UFN1WXVrTjhtRjJNL1pmZUxXZkwr?=
 =?utf-8?B?OUR2MGV1Q3JmQWZTN3IxcWF0N0pYcEF3V0ozYmtObHZJN0hKVTdqcWtJakFt?=
 =?utf-8?B?bEFXV1hONGVpS3JMSEhIWVFrMnA2VzRQQVIxUFJlVlA3UUhHbzRRRzFTOFo2?=
 =?utf-8?B?MXpsZ0xQMHNxczc0enEzMURBcjgrUm1vanhjcXZCbGtWTFY0YlkwbWRGRWJZ?=
 =?utf-8?B?cHRIWHR4L0NOTlBxc1BwQjNPcFM1SklRQmJoV2pidU5rVFdzbUJoTWZnMWVC?=
 =?utf-8?B?RVNQcTFzZ2lOZGVVa2VuS2FPSEtuaXpvTGQ3T3hEYXd1UDcxMldhSUFLWHdZ?=
 =?utf-8?B?T3JkMGVnMEVCNFN1N1pPRTZkYWlJL3dad0tuNjJ0UDR0aVZGWEdyVWRWOVIx?=
 =?utf-8?B?VllCTE1zUVkzRzlXaThtSXR0UDNhNndTWDBraUpUY1BzaVdNTDQyM2d3SEx4?=
 =?utf-8?B?djhmVEFFM1dxb1Y5ZmtTUXUvb1J3MzNvN2J4RnNuOFZlOXpNdCtUL1l3b2gv?=
 =?utf-8?B?WmlYRVRwajBhblVoRkxWdExuQm1SS0E5d2pxQ0p3V21oWnoxaW9WUzM3NFNE?=
 =?utf-8?B?SG1VdytlbU11djJORHVjS2VmRm4xUWxDVWQwY25OSkliL3I4ajUwaWJSNmlO?=
 =?utf-8?B?bStLdXZzWWZNMmw2RlEwbFVodWpEZlhaTTJyK3IrbVMvY2lXTklTRkF4L2x6?=
 =?utf-8?B?ODVsVHlYSTNaSVl2alcwMlliSGFVdTRyUTlxZ29rZVVPUk9kNGNDRkVrUWVK?=
 =?utf-8?B?c3Q5dkEraUdvV2Q0dXBaazZWQVN2SkppNXJQS0xLMytHcnkwRkxxZzNReUNz?=
 =?utf-8?B?VzcycFRGQ1cxdHpxb3FXNFZEeEdBdmdjTXhhd1ZVTkNHdEJZNUhqUG5JdS81?=
 =?utf-8?B?UzF3ZGpyWW9hRG41WDlHQVVnaVRmcjRJTnRpOEQ2aXBpeEdCY1VRWGNXclBV?=
 =?utf-8?B?M3ExamR3SjJOVHg1MWFkK2RJUnFXbDlsMW9IYWR2WVVSY0NqUDF4ZmtKSXV3?=
 =?utf-8?B?R1lEcytYTDUybE42ZlU0MXVMeFk5WkdxRkJZUitjZEVvTUxwdDRWQUloRk5W?=
 =?utf-8?B?K3RRNTdWbExDTFUvRTVqajlzNG5UTGQ3R2x3TWcrL041bUZyMkN0N1JsTGVR?=
 =?utf-8?B?N0czSlloUHFEdG50SDloRCs1ajlDVy9ZRXFoRTZXbC9DemloTlFYZ1JYbUd6?=
 =?utf-8?B?REN1b0tRZjFYQUNMZkVRR2llM25PR1BTNGZFbmJhSHVtRDFiblF2aUNRL3ZZ?=
 =?utf-8?B?U2FLVHk0TGRBdEtnOFhNVnhiMmFRRDRrWHE0dCs1V3puRitiWUdNc0VZVURG?=
 =?utf-8?B?R1ozS25TSzRXNzNPYUl4M0QvSTNiNVM0N1VEaHdZeXpvTXc0eHNqUnluVy9Q?=
 =?utf-8?B?eW1JeGttZVJoT0t0NndnT3UwT2FBTWxZYTFEZnZSUGlFdnpReVNEVUtvQkFp?=
 =?utf-8?B?TVhlVW5vSFFncjE3SnZUa3BtcUZUc3ozWmVGS3hINi9WcEhIRFpGNWwxZmw4?=
 =?utf-8?B?VjVVS1pBUldHaFhSbkhuSjk5NldMb0V6dmg3S0RsaWQ3ekY5K0tkTVpocHZv?=
 =?utf-8?B?Z2JlUURtSWlOaHZQQnhPWHlFLzVsdjBPcFhiblk5ZkZHYWwyVTN1VnZqb1A1?=
 =?utf-8?B?dFlVMHF6RGc1QVRKVkU4RVl1Y0VZWk91cGJSMGtrdTc0T2ZDemh4c3QwNFFM?=
 =?utf-8?B?bzRuRkMrTk9EUkYzaHdudXlWZ3Y3Zml0MEtkQmQ1VEZ2azJ2N2ZUTXVXM3hB?=
 =?utf-8?B?b1RkYXhaek5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlNiUU9zQ3hSa3lUUWVhV0pZNU9Iby8wLzhhTUJCcGVyVzQ4cXZpeVBWOGY5?=
 =?utf-8?B?cmhabkNLbVV0amgxRXRQY1d5UWZRQkZXSGZTMmNWR1NEYkdSYU0vcExHdDRL?=
 =?utf-8?B?bGUvbERTMGR5N0pFTzZoeW9PK2RKeGtsT3FtM1ErdjJZM3Q5akpZOEMyTnJ3?=
 =?utf-8?B?Z0x4eTR3VzdxRzZIOXRpMWUxY2thUU1UY054OTd5RHJxenYvSGtJWTFpRXpo?=
 =?utf-8?B?WkUyZWxpS3gvZGtRWlhhM1N1OGF5MTBXSGRWeDRMMjdmaGQ2Q1hZbk9xUEdF?=
 =?utf-8?B?L0lHMFJrbXIyYXZpVkdhVVN2Q0w1OXIzc01FaFNaN2hWZ0l2Y3pPTDhyYXdD?=
 =?utf-8?B?a1RLSm0yakxCcFM4bU5OL3c4OVNCK3B1Y0Z6ZlVFZlNYVmV2ZVRpWmVxSnZX?=
 =?utf-8?B?WkM3U095SHFCN0h3NFZ2Vm9XOThqOXc2R2NFSFVISTJYMTg0eGY4RVEvL0d2?=
 =?utf-8?B?amlvTkFBR05oQkd2dnZ5d1pVVDN3K25na3lpSWN5Vk5BZDRZUzh1c3hNbWc4?=
 =?utf-8?B?RE1QVjBMdEwwRDBTUnhQL0JmYS9qcXhDc3RKWnRKVVNLY0VwNUxnMFVBcmc4?=
 =?utf-8?B?dkR5TmtiZERJTWM3MEFkWDd4Ym8wdzcxUm5pZlFQNE1qLzNIYW42Y2NTT3l0?=
 =?utf-8?B?dHNCSjVoa2lKd3hUSVFTdzdpa0FuZFdJUkRXdWJZYTBvVHBhSytBTU1Da3Q2?=
 =?utf-8?B?RWdsS2ZUbHQyN1N5VjVzL0VwUW0ydXMrSTJlbS9FcDJhdVB4NUlaUE5KM1NJ?=
 =?utf-8?B?TXRlU1VCU3gxemJySnRJTGxmNEJ4aVFkWWlHUUF5ZHBqZWxDL0R5RldOcjNJ?=
 =?utf-8?B?YTY2Q0JILzR4RGJKMWhJTGNBWnlobmx6WTc0U0FZOVJFSWUwU1dRV2EraWhy?=
 =?utf-8?B?TlZzUzAwQmdJenZycjVPVU5xTjArVnoyWHF6eGk1NFZhODFLVHFNZFRHUjRy?=
 =?utf-8?B?bG54NGlxellmY1Y1UHJVT21zQ0xpYmVETC8vR1NrUk8xSDl1RVp3Y2l5a05x?=
 =?utf-8?B?Yk1meCs5czkyb3VOZDQrVlJlbmdzV0JtRXR0cVRTZm5PQzFvRzVaNzZPZEIz?=
 =?utf-8?B?NjBRcFh1NFpScnFpbkE0OTR4NThTR1NKNkJuQWo3ZnZZcmw5ZjF2RUFnYjdO?=
 =?utf-8?B?M0Z1dGJmTDkyNk9QM21Tbkd2YzhYOGdTeTlEY21JdWtOZ2ttKzE1QUhzMWZZ?=
 =?utf-8?B?U2t2Ung1LzkrQ2h1SDJXSWVkQTBwMkVORDR1amhGMlJubU5zUzROTDJKRmlO?=
 =?utf-8?B?RHJlLy9pNE51dW9LNEh4eHlSYWJLK3hxWFVHOFRucjBHZ3ZIcHp2RzdaRlJW?=
 =?utf-8?B?L0xFSTZxUU1OMVp3T2tBM3JoZlFuZ1dDaVRZNXppeXhXUWh1REdnMjYrbTZu?=
 =?utf-8?B?VGJhc3lGajNqcEZpOG5IbXg3eXBjY05ibytuck14bWtvS2h5dS9OTm5kYWtJ?=
 =?utf-8?B?U3hBYk1mZzRMa2pvNktNbldqTmJUd1JwNlNMd2VBU3BoRHdTYUdFTVY2MU5Q?=
 =?utf-8?B?ajU1TDJaQ3owdkdCUGhtVXdqbTFuVVBLTlZqZkVhUUNkajhuR1M1dFF2TEpI?=
 =?utf-8?B?RG96Nyt5SjM1TVdqRVJOajJDcEhDbWNwb1VFMnBoVk9Ea3BaQWN4TW9PbVBS?=
 =?utf-8?B?RjZXZFh4Znp4TTgrSlBZYWY1WFF2RnFORWdYYStPemY3UDlOdzFpTFkxSWZs?=
 =?utf-8?B?V2t3SVpZYTlrYnl4amdmTkVoZzd1RXl6QnR1eFNkWUhSTWtUZmdSemFUbXBU?=
 =?utf-8?B?SHQ1VXpVK012UFc4d2xPWUFDR01RSlZoVTl3dE1sdmxLM0pYR1R2Qm5NdHdy?=
 =?utf-8?B?eTJtTUNFdGVNU2NtZkVsem41aklIYlY4a28vMHA5Z2FyWnpRU25kYWtkYytu?=
 =?utf-8?B?RUd2RzBicnd4OEE5YzFrU29nM1dxRlU3akduOVoweHlMWUtmckpiWW92dTg5?=
 =?utf-8?B?WnNTVG1CYnJ6U2ZBV0ZWMGN5OHNxVzIvNUdxaDN0T1BXUnFwMUx6ZXh5UURN?=
 =?utf-8?B?aWVOVzZYV1IvK2dVVkdrOGRRUXhLMWtqdFBaWmFSY25XY3NCQ1RWZTdXbm11?=
 =?utf-8?B?NmZyRXN3VGcyNHA0dDdQVWRDZThUNUVnWlpCZ0djOXJhbzFCMzd1NzBtTlFO?=
 =?utf-8?Q?LWneOKkXR1WSkBR/8HWF28RHM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f77d63-0775-436a-93ff-08de0ccd2267
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:00:32.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /13hHWeLhx3xqr5xHUQbTar8kDz9uRxLknATMeT5pdBL3q+2xqmpl6XNKMyBI8VNJWIlDHA9H7M/94OK0q+d5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10069

Rename ngpio to ngpios to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6dl-ts4900.dtb: gpio@28 (technologic,ts4900-gpio): 'ngpio' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/trivial-gpio.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi
index f88da757edda5a172d82745d5b5c1abb935b7d79..948b612496a5b70d832c1ce13f2504b36d9da46b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi
@@ -140,7 +140,7 @@ gpio8: gpio@28 {
 		reg = <0x28>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		ngpio = <32>;
+		ngpios = <32>;
 	};
 };
 

-- 
2.34.1


