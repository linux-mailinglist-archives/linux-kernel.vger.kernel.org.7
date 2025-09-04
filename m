Return-Path: <linux-kernel+bounces-800542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5DFB43906
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119E81C27AE5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE82FAC1E;
	Thu,  4 Sep 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l3x76SuR"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC32F99AA;
	Thu,  4 Sep 2025 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982506; cv=fail; b=VBJ1e5w5MthEebSJWR/jC4en7D2M3Og7EiDaRFAmM6TG4SdzJVG83MsxK2NSFsV/dEI3VSKCicsW/A1sfYSTgfhTgISLpv50QBUHaOhcFywIvMIFvKUQYPcr31N13fIhPjyd48MSHjmsvGH6pQcQAnQaqgLlLdubHZLNsH8+Jc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982506; c=relaxed/simple;
	bh=G7rbyozGJppMFsysGsQeHFXq2K035Q6g4X8HvuK6nFk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jORzeCkhtjBYeOKjOI3RuICnyxAIv4m/8XEzKZNhqD6tl66dJykvwj6rhzNxWGTlrVb3Tleq6kueF/omktF0ftHOLql2+a84bHaA/aONAIn+jE3oFiImrScxlzTpIhRHdi1goBNkKnmGi57vNd3siJ6C7Bmj6dV6vwiT6tiWgoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l3x76SuR; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1IUxwtSce9pAairqcCztUrO61hbp0N29azOX+FKSZOQQAR2lj9rcjTA3ONgY3xc9KaZ5urtX9WyuVoixe8StSQcDQMmDpXZuZHebCIVSerhsuVv9JIgGx+NXxLa1bo9gHYMeJ5t6P2qj+yeTdGZmbYKlDvnoSwX1KvZCWE4u0G1PcAlYifbkFEiD6JHBJ1ifF7dcOU3RY6fmocIZYFUn3ps+Ge8vwKopU7p5zPl7ZAlirSJ7ZEBqRbejT9xYMpuSrGcUQA2PHxFJOMWHb85EyQYixlH4KBROHmhWWjSWbB+Nuw9pAa1WVGwVdHouODOc730kpIHyyVpGaXU6SDwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C797hCkSye7AmjEVDpFPKrHWxBgXI19BBxSQV+aReiY=;
 b=THpPYnZHNBfc4oonBPLg4juMdJFMSkB2nFfDKH1cIl3ndORkb3pmmw5cUXLLwl1jukW37r+s4Issg/ZBDkcDAwJR3hrEchObhooj05eij+cPb/mPWytO7Urib9oM7fg4JhagfN29N9WjWp2q9iu+hkjP0jsrV/ZA5CYmMlUAfZWwyFFwaXoW2vjsW+l/uJFxvIMXJCurIq8jgasrGEzcw1plvvLJGD71lvttuqfsMwCwG84oFrPUN/gRxd3VM4+vHtzeoa94aMePElwHqhG2OLdJeDu6Zlgj8DSYiI07LVJPCyDNZQRB7DeerSah7y1OuXv4lgME/KY0nBER+sZBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C797hCkSye7AmjEVDpFPKrHWxBgXI19BBxSQV+aReiY=;
 b=l3x76SuRUg+X/BsGElyIKw9zj2SyArQMFdA/T4/iavC3x7qv8OPdW49ptpyAALQTZrwGtv8SlfKFGohezDH8ZhKkvbLTKb1QVzQE2pp0ZGd+Vm6mMAozIgBz8Qt+B0wKxgC8h9LAiK/yUZ7HEScApMmDpusFyVuKD7OWd36XAeo3opiTkS4rVBeXhe4qytlcft8KdxL4CgIaq+FgSj0bCRXkgMOdXCguurL2ux8gJ5sQYMrL+KkZCZi4N35W+lRHOb/GTpgJ65wGfbAGpNlcjiw2bxBz4LI2axRR3X2Z2LH5QsOXUJZ4+sLAQRUOIVRYhdbp14gJqm5vJ4mzd2ljow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 10:41:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 10:41:40 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 18:40:42 +0800
Subject: [PATCH v4 1/6] firmware: arm_scmi: imx: Add documentation for
 MISC_BOARD_INFO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-sm-misc-api-v1-v4-1-0bf10eaabdf1@nxp.com>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
In-Reply-To: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756982492; l=2979;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=G7rbyozGJppMFsysGsQeHFXq2K035Q6g4X8HvuK6nFk=;
 b=Mhv0jFXyzcG6pxB3EOiY5gCurpc4R9OVgKXequ5rv+O+qaT4rpOr+IG87raFRT7Cqs8CeLV4k
 EncN2Jh4IgaCMuNxIw4HUtQKfxm1difdl+YNFZ7rGaPkoybXasyh5Ul
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9a3ba3-bba2-457a-4799-08ddeb9fa1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em9rd0UyemxtbEpRTUFiT2lDV2lPd1NoWlNVMnBnM1hjYzdDYUxSNkNRNGFZ?=
 =?utf-8?B?WFpMQTJmc0RDYlJ4M1BXN0xQMk1hS0gycFdKd3lyNllwbHQ1S1F0ODBNc0VL?=
 =?utf-8?B?STB1Y3hnemtPakFoaTdxcjRCSlZRS05PcVpDYldHbTFJd3ZmYm5Ob1dIWVdR?=
 =?utf-8?B?UmtEK1VDNEhBb3pLa3NLTGFvWThsN3ZhQUtETWducENGMkp6Znl6TUJFNC91?=
 =?utf-8?B?dU1ncFFTbTdkeEYxZjZndERjNWNuZU9jak9VdU1PNlRnZG9LZWQxTklJZkFE?=
 =?utf-8?B?Mzk3RUNTaHNxZXc5S0Jpa2RRM09CUkdaN1NVWlBQeUhhd2RQN0hHMSs0c2kv?=
 =?utf-8?B?TU1tQ2lySWJrZmVNdGViSVYzaTRITVhXWGN3T242eUVnZDk0MVVOUUpjNDBl?=
 =?utf-8?B?Z1lySFRGN0tKT2Y4dEZsb3NvM1c5eVRyTEpwSzljVy90ZG5UaUpFTU5MdVRa?=
 =?utf-8?B?YlZrUXR2cHg0L1BpUjFPSGpTbWFlTjF4T1hpdEw0M0cvRXFEaDVkS21Zb3Rx?=
 =?utf-8?B?c0xoc0tNTS9sUTdja05GS0p3amFYVDlGU09IcVA4TXJhaUkxRkE1S1ZqWkwy?=
 =?utf-8?B?WXppR25RWTBRYm1kVXAyb0dEVDZKK1RNMXlYNHMyWmU4TG1DY1p4a2RlRVRt?=
 =?utf-8?B?SmFkTnUxV1ZBZlYxdmtMU01kNWtEWkI3aHdxRng3a00zcGJaU2hEU1gyNU1S?=
 =?utf-8?B?WGMvUTZzTk9wM3JrR3NLWHdBaFhHYmFidm1hbWNSSm45YUk1L2t4VUpGYitM?=
 =?utf-8?B?N0NXR0YxTEswaXVlOFQzNXJlZ2VJdU1KV0RuWXpWQ0pFeE1sTm1QaU9ZRURK?=
 =?utf-8?B?WW1lS2YxbFdjL2E2M1luVEZHcjJ5OVBOU2oyVWhCODBObzFXeXAvbzBHU1ZJ?=
 =?utf-8?B?MXMzK1NPU2VJNVlPTFh6NnAxOXltQ083MGQ2N1dTMjF1bjNSS0FxNTVvUFAw?=
 =?utf-8?B?Y1RBUy8rWk9qZ01wd0pyVlR2M1VXRW1FRkNQb0V4bkx3OE90Z2VtcVB0SkNj?=
 =?utf-8?B?TXlydEVURlZlN0V2RjhSc2k3SG05VkozbWwyRTVaRC9TZkh2Q2RLWFlqQU9T?=
 =?utf-8?B?bER3TzhCaWFERW04NlpVMjl4R0xuNElna21uUEFCUDk2R0gzNWJXSUIrcGU4?=
 =?utf-8?B?bmFzcEZUY0diR09tM1N5WEV4U0o5OVIrazdueWZDdXVsb1VBQk1hc05DSzZT?=
 =?utf-8?B?MjF3KzFEUVN2N0ZlR0JlRDF6SHhxS2NVRUNYUWZqN1daVlFIRHpQZzQrL2JX?=
 =?utf-8?B?QTh0Z3NBM09TVVRCNWF0ZlczaG1uaHlqV3FwN0cvU2hmTHQwbWJremlEL2xy?=
 =?utf-8?B?Z01hQjRRMS82OWZ6cnFZUStiN2VmaGxYaDF6Wld4K0d4VDhnM1p5NVp2Rlds?=
 =?utf-8?B?REZRYWJBTG9ud2F6Y1hGMDVFa3NLWE50bzVQWkowV3ArRzJjUG16Z0VjUG9i?=
 =?utf-8?B?Rit1dE54bjAvbDNnbkNkOGRmNTB2TFpzZGJYR0tzTGlFUi9UNTVMd0FUK3Iy?=
 =?utf-8?B?RXo2d1lhOHc4dmFLa3JXL3V5MjlSdyt1c2RKcEdCN2JoMytkSURJZTNBQXBK?=
 =?utf-8?B?cStmb3l1M2t4Rm90cUlYOGUvcHpaQ3lYT3lsbG41VFBpc0IrZVpaNWw5WS9o?=
 =?utf-8?B?NHNVVjBQRXBFeXB2MFZsTytpTm8wcWI2TmVWK2dkenJFK1JlV2E2QTMwMWdt?=
 =?utf-8?B?Y09ocHdwRkdnTlhNUHo4U1lTTnlyNm1wdnlWYy9hOEExTjNkRlloUVpReTFz?=
 =?utf-8?B?a1lNOUhWVWtROWR1aG5nZVhJYVJaRHZRYlBsdFY4aG9wc3Jvc1BFaE5uaWRt?=
 =?utf-8?B?SmR4M3dJNERNZjZPNk9YNVhab1oyZDBqeThkR09xOGQzWkltazYyM29GVk11?=
 =?utf-8?B?aG5MR3g2RjFCWHpuMDdNdXU4RXRPbDV3OGtLcHNYVUtlUmdFbG1neWpncnFn?=
 =?utf-8?B?NEpoY0pMSGZOeGVMQnkrSVhSL0V0c29vOTc3ckU4VGVSRm1rTVZrNURYTkdW?=
 =?utf-8?B?WjVhRFAvS2pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEFjR3puT1pnT1l6UVlIWm5idzVJTGF2WVBDQkxOYXp4UDFvdDVoTDRGVHZ1?=
 =?utf-8?B?aUZpUHRGaWFBUDAveG1yUjZaQnhsYVlaRFhOblVSdjNJTXN4S2ROTm11eERW?=
 =?utf-8?B?bWtyN0hCaG9iWVpGZy9CUFVhNzBHVUlkb0pzOFlDbmJlTnZDaWIwcktpWVAz?=
 =?utf-8?B?a3pmQnY2SnRuMW42U0tZa0c0NnpPUC85OEs5d1k4OE1TcytPTEtCaFluMk5S?=
 =?utf-8?B?R3BBRTJ6TCtvWmRCc1IzdzZBckQ3c2J6b053cHNiRWI5V3BxMGFXd2gveHZB?=
 =?utf-8?B?a1M2UzY3eHc1WGhHL213bThWVi8ySFFMQTJSK1p4bDdGTldzcFFLVXRoNlh3?=
 =?utf-8?B?MjJiOXlZUHhjclRqdG5WaWNuRWU0NmVJS1BYYktCd29zNmV0QkVrUDViTDdX?=
 =?utf-8?B?MzRoZXZ6ZEl6MEtNajU5aHBjVENEZTZmdWpkREVaRnhLQ2JzQlAzcnlKZ3gz?=
 =?utf-8?B?S3Y3aXV0dmdXMVI3bklVT0Zoamc4c0RJQUZYd1VnbHBsVVpWbjVlR0ZsSFhu?=
 =?utf-8?B?TFZ5Q1h5NGFqZnhDSWxHTldERjE2VjdJb2lpMHBVMFZLZEVvWWV3OGk4dm1R?=
 =?utf-8?B?MisxNHRjbm93RDd1M2xSYUJjSzU5R0kxVk1XK3lsY0JJVDdReGc1RDdITW1x?=
 =?utf-8?B?Q3pkMWt4dUN5UW95Qm9VL1grWHJPR05UdlNyZ0RTdUdaTUlYNElUbVkzUzZY?=
 =?utf-8?B?VEVJdXRyN24yZjRVd2loYWxZSkFvMGN1V1NXeEd0T3M3YnIrMndyM1FvbjZJ?=
 =?utf-8?B?bDRySlVXRFdLT0RicUlGOUtXdmIvTnZLV2F0UWtnd0pVU29ReVRXSENKaUl3?=
 =?utf-8?B?NktWMTZza0VRYjdBbXloMUJidk9wd1ZRNHN4ZEp5bnNUOVlqUG1oY0JRRk80?=
 =?utf-8?B?ZDY1U09UYlJUS2h1dSs2cmU4Ym9CSFNLSVdidHhYb1A2elM2QU5abnZVRkh1?=
 =?utf-8?B?eWdBU3ljdjlpMDRXWE9Cb2hQZUJ1Y01CR2Z3ZlRGcEM0VFl6eVlQUkNoaDhh?=
 =?utf-8?B?NUorVENvK3AxbnRUUUZyUG1TeHZPZjc4UFAyYXBPVzhKZHd1ZkJnaHBqaWc2?=
 =?utf-8?B?SE9TVHQ2VUl5SnI4QkZXOUYxYjFRaXRCTkErUXQzbEN0UklhanEzdlN2SExP?=
 =?utf-8?B?VW9ZUk5rSXdQYXdWKy9mTjgyUktDbGlER0lHZU8zNjRZTVJodUhjMkRqTHNp?=
 =?utf-8?B?bWt0eGM5WGd5STZyb0FJcTgvTXlDc0hOR2xhVUlWMXVDR0dUWUZ3R25BZ1VB?=
 =?utf-8?B?bm1GNEZ1UEl2aXVmOFlDMFdiQ3JEQ2d2d0ptS3Vwd1ZxcEo4NjhCR0c0bjlk?=
 =?utf-8?B?YlVUbnQvN0xlcGVncGxTV1d5RktoR2haZSsrSUExOE84QnpCTXpBekVicDd0?=
 =?utf-8?B?VzlBTDNJUEFhWkc1cEJKKzJtb09KMzE3UTlOLzJ6cWFpY05veHorUkE0UDJh?=
 =?utf-8?B?K1FSeE5jNnlIdHZSTzRsb2lrQWQ3dDBIbFh1Zm9pTldZUFVSY29uQSthY1NG?=
 =?utf-8?B?YmlheXIxMVZvR042N24vcHRrNFhDRjhyaDBlNkxqVHd1cFlMM09oNmQveVl5?=
 =?utf-8?B?TEhMbmhuK3BSYmFuOTdISGs3bGVJbW1aT0M1eFFoK2k3ejdNWW5DWUs1UzUv?=
 =?utf-8?B?MnVkRWtwRUNIeDczSWVzUEp3NDdaSDRGQ3o1d0pHWVhydkZNT0NQa0hzVkZS?=
 =?utf-8?B?M1hXSzl2SGVDTTZFQ2thdGI1VmV5S3hDQ1ZvcGhhYndld2hjSHdVSmVOWVlD?=
 =?utf-8?B?N0JrNEFzdHB5eHlMTEF6OURzZC95R2RtRjNUakNPUkMxR0FXR2tBSmNuOFFW?=
 =?utf-8?B?RlpvU2tzdXgzdU1TeU45T01WZnAwdi9aSjNMMzhNTlRyUFUxRzJlWUFSRGZ4?=
 =?utf-8?B?M05PenNxR2NyOVJjVmlNVkNOT2tSVmpKbGlCa0JGUTVSTVM3VjV0eHZoc3lW?=
 =?utf-8?B?RGhlaFVQNzlVbTd2V2YxMWUwRTZNbFFxcGxFUFgwdDV4YWhDaHVWQ09raGhx?=
 =?utf-8?B?V2cxWkZVd0pqVlBRT1ZxS0NhemxvSUpWUnFWTDdkNVlMdHI3bDlFTHRJRUVX?=
 =?utf-8?B?MnJsKzJySWlHL0ZYU3REM3B6N3EvYWpnZm15YzQwSGllRnVNNVZIZHF5cHpV?=
 =?utf-8?Q?Qq4UAEgqMb9Bk95yeNedJ6BEI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9a3ba3-bba2-457a-4799-08ddeb9fa1c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:41:40.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QsoIssdRTkuJbZ75p4vOC8zICJDmZIVSZd6BxmJKLeDoubTIj4EZ5hHAm8KOVv0zV5GgUyx6Acr4l5GRaG6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653

System Manager Firmware supports getting board information, add
documentation for this MISC_BOARD_INFO command.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
index 4e246a78a042a79eb81be35632079c7626bbbe57..06687fa4c44ff76c1589ad4ddf4225a1b55c2246 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
@@ -1660,6 +1660,7 @@ protocol_id: 0x84
 |Name                |Description                                              |
 +--------------------+---------------------------------------------------------+
 |int32 status        |SUCCESS: system log return                               |
+|                    |NOT_SUPPORTED:  system log not available                 |
 +--------------------+---------------------------------------------------------+
 |uint32 numLogflags  |Descriptor for the log data returned by this call.       |
 |                    |Bits[31:20] Number of remaining log words.               |
@@ -1670,6 +1671,29 @@ protocol_id: 0x84
 |uint32 syslog[N]    |Log data array, N is defined in bits[11:0] of numLogflags|
 +--------------------+---------------------------------------------------------+
 
+MISC_BOARD_INFO
+~~~~~~~~~~~~~~~
+
+message_id: 0xE
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: config name return                              |
+|                    |NOT_SUPPORTED: name not available                        |
++--------------------+---------------------------------------------------------+
+|uint32 attributes   |Board specific attributes reserved for future expansion  |
+|                    |without breaking backwards compatibility. The firmware   |
+|                    |sets the value to 0                                      |
++--------------------+---------------------------------------------------------+
+|uint8 boardname[16] |Board name. Null terminated ASCII string of up           |
+|                    |to 16 bytes in length.(This is SM exported boardname     |
+|                    |which may not align with the boardname in device tree)   |
++--------------------+---------------------------------------------------------+
+
 NEGOTIATE_PROTOCOL_VERSION
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 

-- 
2.37.1


