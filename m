Return-Path: <linux-kernel+bounces-738809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5340B0BD82
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364A6189D43F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F48283FC4;
	Mon, 21 Jul 2025 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cOcYhQ0F"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F46283C8E;
	Mon, 21 Jul 2025 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082209; cv=fail; b=qk56C8IuFNHXAlE4PPOpNr3bQvcdkevpdVDkciOqH9FjxrLWPjjSUulvOevtYXNlRu7VoZc1o/YUrtA4+WGGlECbA62pmSS1+yuTBykfVRvpbq4oGFTtBvqVov5aqqb3wJLAaRHRKSlFa05KH1B9vvojrnMnULjfyvgBV6UCBSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082209; c=relaxed/simple;
	bh=he00pNeo36WFlEtyZEI+y306OOPdBc0TH9jFBcKlgsA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gNJQUSpuydS59vLYFqmYucyinAjJY9WJc4JuRxfVIrpNICGwyGEWfoQbB3fbYQ1A4FgTlo+qEqSBOKRR5BCUvYGVWx9D7IUe7HKqKaUYLTUqrKmYmniPN5kW099NvGs113NSEt1CWkI/hAw/jGkQmxEf5+k7eX39SewTb+v0Pog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cOcYhQ0F; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7qp1tZKBTf/O84xym6HonWJok4y9X0TfP1zoMTGKdCDlZlFD/z5YjNpkQZ94Jc42kk8szjgbpNxyc4SI6AISPPhJRLcP63uNzgFoiPbxKtPq6gxJeiJ0jOeVYfz61C+eRMyC5ieFwM4oPUtp4uA142oNCJRKTFCdOn4eFFOuBitXqZUwiDDFWTAcsBPrj+tOeijtabHli+SUOxdc1Jxf8zOxy7JUfMo5UYErINImuvRTQRRZNfCvM+WzSi7yJpRh8rK5Qf4zO4QO69VCa7HIOgNplFD8Fn5RTs3NDVO/ebMilUYBDDgSmzqR8bDPb03cu0AX/QemRR1uVSxfvrqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfuIkGBXdfj2TY7fm5lq5r9b/hPY7ii5pqXacQo4HNs=;
 b=YoWAvewo8d1sWL6nCLBwk3xD5gmD5jH5nmXJQw7jKfnjMEEGwdg0Hcts3mPIgEK6uDNySi5qkytAuRo3Fwp8VkQes4W6bw5sbmncPJ1N3YXHCwLYhwRSIUaQ1pTI2dU1mNStfQ6WpL+4TBnfrNm4oSskBZxyf7q75TlE4TVJIV0GSR/vlu97y/negqogeGcylop3wZYi0u/460+HvzZT3z2QJZBbQnzBSwBiw8ZTg1agm+HJWtvEPCpGQjy6R01Q3HJxq43A79PzBUb9ZeUt9r2qYOdjKlsdb1G/HW3gYrqNiAWZIjndzM4q9WNRZdcIa5HsyN76aF8X93gB4vALFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfuIkGBXdfj2TY7fm5lq5r9b/hPY7ii5pqXacQo4HNs=;
 b=cOcYhQ0FvQwj8Do+GX5XioSC/1n0m53Kfx7xHU4iH/ZwZtt6Oz11cpZR/gJs5HFcDzi8aDJGMbo0w+00zlJnUBVqcl5/0vcx574SYTTPmBzL+PqNovcXwZwSigficEcCeWKOZl0g1OGPqXjqDARyxoR+OaUEGC933yl0SWcPRGuQ/35ot8Ixfou3WUN+GL/OSWbpDgsZAY7JFsuBpT5T5E+eQmsGH9Aor9boAMArdoFMMdUzsz1+9HfWFZnHJ5RFwn6AJ1lEF57AebTtqAqiiWegmokVLdmmn2pyGBntJ8sNf+AVucc5oYvzmHqZGy/pH/Glf7urnYlgPZtSULDhGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by GV1PR04MB10845.eurprd04.prod.outlook.com (2603:10a6:150:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 07:16:44 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 07:16:44 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Mon, 21 Jul 2025 15:11:28 +0800
Subject: [PATCH v2 2/2] regulator: pf0900: Add PMIC PF0900 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-b4-pf09-v2-v2-2-e2c568548032@nxp.com>
References: <20250721-b4-pf09-v2-v2-0-e2c568548032@nxp.com>
In-Reply-To: <20250721-b4-pf09-v2-v2-0-e2c568548032@nxp.com>
To: Joy Zou <joy.zou@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MA5P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::13) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|GV1PR04MB10845:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a98269-29e8-4353-7f9f-08ddc8268bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDQ3NDVta1YwYXlrMHh4RTB5YlZoQ3VjQ25Dc0h3Z1JkT3Fqa0VoUlZEUmdy?=
 =?utf-8?B?UVlVQ3FZdk5WYVVwY0ZTRXRsNXdoL2lDSDI0YmZ6RUk3TFRMSU5hTk9pN3Rq?=
 =?utf-8?B?VlVoSkxMdzU0QTdHYkdwNVFPaURZSDE4MmM2Qyt5b0hhQjA4VjZPa3QvNVNl?=
 =?utf-8?B?cUtBbmtSQXcwUFNLUURmWU1WSTE4T3c1eVNVdVpiZTc0ai9EK2hLMUV3Vjhu?=
 =?utf-8?B?Q0hubmxRVDRZbnhxclMwRjVnN0NpdURMczF5TjdqR3FnenRqY2FSMmhBVHEw?=
 =?utf-8?B?enRjSjN4eURwVkk3bzdNVEdMTEhSb1RFY2p2ZVpVWFBaQUFDSm11WlFvcThj?=
 =?utf-8?B?cXQwTkx4TmhXZnBlQW54VEg2T0dtWFNaTTRYL1gxaFJ6UVpkOTJYWmFoMnVv?=
 =?utf-8?B?ZUEzRFJ2VklqS1ErQkFOZ2Vwc3VuT1o1YVpFa1Z3aDRHUHhyb2h6V2tSNlJa?=
 =?utf-8?B?dDVjcUFHZ083Qk9yVjhDMUI3NG9sU21nNkhUdlBRNzFHdlpvZDRmY053cXRX?=
 =?utf-8?B?elZqZUJ2ZzN3ZVRZK1k5cjNpZ2JKVjJ4a1BHQnk4SzJmODF3eVhyNjE4cnoz?=
 =?utf-8?B?TldJRWhQdUZ2TEh5NTVxZ2pUSU9CTWdQNGN3K3RvMTM4c3JMendhc0ZLbVJ1?=
 =?utf-8?B?T3huT09TN3E3M1ZVTmttQldWenZGSkFabDB1cXFDaDcwUHJkWU84ZEFFOVZ4?=
 =?utf-8?B?ZFp3SGlVbWExT01ncTg5UEJLWTZLbnRCdFQzUTA0Smx2VEVKMHE0elpoYXJY?=
 =?utf-8?B?MjlZV2tXN0QyOXVCU2svSkpvOEVwdHNzRnJnRGgzdEE2ZFFNMndYLzJyVEUz?=
 =?utf-8?B?Q1ozcmp4eXFFbHNOWDdpZTcwZFFSbnpnSjJWZUFIeGhSc1pSM0IrUURrb0FZ?=
 =?utf-8?B?NmxpTEUvTCtOdE1WNEJaS2VuYm4rQUVKL2VnblVyU0xzcWcwdXAyS3ZhWVJO?=
 =?utf-8?B?dU1uNWxrRERtdEpwdU1QOWM1bmowWVdqL0czeExCYlIzRUxGUEJLeGZpMHpx?=
 =?utf-8?B?U3Z2ZTVDakZyRmc5TGdiUlZRV0RKOWo4cXFaeXJvQVcvUW16OFNyOVFXZ2hG?=
 =?utf-8?B?aTRubmEzS0dKSTZXM202cWcrT3VXTGtOZHUyZEc1bWZGcTRsb1AvY2d0WDdi?=
 =?utf-8?B?WHdYdjIzcEVSQmNtUzd6ajZwN2xJdVhIK2JuL3pITzdDaUY3bVJjNVgxa1hy?=
 =?utf-8?B?YmYzN25GSGtGb2NlNmRwMTd4ZUswYnZ2M1QzU0UzVEIxOEltRVRLaWlzcHdD?=
 =?utf-8?B?VEZveG9qZGl6bW4weEVBMDk2NDNsTmFlbnVObkFtMnlKOGpsQUw0NGxRUTho?=
 =?utf-8?B?ZG1aRE9DS0lNbUFSQVFpaXp6dnZUcGlNOVc1b2xub1Y3S3IyZXdXcDRPTkRh?=
 =?utf-8?B?UXhIaVc1M2lFWlFMb2FBME4rVTNPcEVrN21jeFQrTXpMUHV4eHBaOXJiSHZP?=
 =?utf-8?B?NmQrakhVbEgwSXNudkNobTlDb3FDNldWM2w5eW5aajVhMkxaZ3JBRGFRQ01m?=
 =?utf-8?B?czhiMXpZUTcrenhqRFIvUHFzY3hmR1ZHVFYrMVphM1ByR1JyekRwdGxPUUIy?=
 =?utf-8?B?YUJmUDZEWm5KeTc1WnRXcy9DWnNSRVF5bUh1N2JJWlpHUzdFM1RqVjJQK2Ur?=
 =?utf-8?B?eUVncUNJcjVIVFpGelVDT3Z5KzlKQzFTWjZScmh5WmRuaHZFU2FwTlpyS0hx?=
 =?utf-8?B?N1FSMjh4Tkk1YW9pTWg5TzRneHdreEFMQzIrOVhqcEM3aThGQlhUcHAwYVdq?=
 =?utf-8?B?bUdZRWJKdjlsSDgwU2gxTEg5dDJqaXhCVHZFUi9VcmkybkMvVlpkRE9XbnR6?=
 =?utf-8?B?VGVRTW5xb01mRTRXVTRjTmtMSGNQajNJbjMwMUJwU00rd0Urc1QyQnhKRHZs?=
 =?utf-8?B?YlNtclVETDdvbUJxU1dyWTlEU25STjRKZnRzTUpqVjRxYWgwR3RhV1VPQVdj?=
 =?utf-8?B?aEIyUE8vamhyQjBHTzloWG1iKzIxSklLOHlaQkV4bTVBMmZZWitjdlVHaXNJ?=
 =?utf-8?B?bmRuSFJtb25RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ky9SbENZYzBQTFJoVGdEcVRmMmN6RWFnbGFkeWVvanJ2MjBPamxDZVMwaHlN?=
 =?utf-8?B?NGk3MjJkbGUrUXQ3UXY3eEkzRjJTRTM4U2ErR01zM2gwZHVWUHlXelFHRmc2?=
 =?utf-8?B?Wll0QllZcDZxaHRNZ1V6NmYrcjZNUkVycldOMVVSVUJJZ1p2c3pGNEtKYlhs?=
 =?utf-8?B?eHFTVnYyallCWm45ZzkvRlhqWUl2dmd2SW9PL1RieVFOa3l3NnhrajVZQTdS?=
 =?utf-8?B?OEtldFpPSGNYR1ZEK0JJaHZGRG1lak5JNDZhZ1dIc1FyVlRpUVNLUkxIbno0?=
 =?utf-8?B?d25QQ3ZFQ2FvMzRlUTNKM29SQXgxaDNMMEN1RXBQcTRmem04bnhTdzBXa2cw?=
 =?utf-8?B?QkM5bTRwVTgrL01UeDdkSm9ZMHJLY2k0cjl1c3N1enE1d0lSK1VuelkvcFBW?=
 =?utf-8?B?OFNQelc2YzcySTlvRHcxU3NlUWJJUWQvRGZLeS9VL1ZXQ3JxQ2taYTlqYnpx?=
 =?utf-8?B?ZGpIb3l2UEFKTmtObkdnMG0yRFlnM3hCNWJ6NWpuZEQ3SEpXKzhvdTFMeWt6?=
 =?utf-8?B?T2ErTWlkUU1QYmpnYW5tc2dZbHV5eEZLQTMwcyt4cytZNzhkQ0pUSVZXeXpv?=
 =?utf-8?B?dzExbFNKRURHVkRPTHpINHdsbVY3QU5tVm9YUFFHdjhNSStTVUN1aHYwTmcz?=
 =?utf-8?B?NExBdTVmK29qS2phWm5xVUZqekx4NXUvMmdYaTB4Zkp5SXRPeks2Y1lkdjJj?=
 =?utf-8?B?TkRhWXRwci9SQkVoeXdIQ0hvK1hxTkpUdERzNzdGanpVeVRTOFRrVFgxK0JI?=
 =?utf-8?B?MENVWC9LM0REN0c0Q2FwdGZtaE5tcWxIcjlqbTV1L2FROWI2c3Zqd09iQU0x?=
 =?utf-8?B?WFl5L0ZNQWlkMGdtOGI2dERsT0lMOHNya3BYRUU3N1YzbzA3cHozS1BDVVZV?=
 =?utf-8?B?ZDM5RElnUkJoNytZcjBkNVU2d3RzR3hXOTUydzZZeEd1M1ZjYlZhWm14TFJX?=
 =?utf-8?B?dDYydlkvZG1JRzduZzZoTHVUR0VhaXVVWS9xckVCWklhTnh5M1l4ZStEeW14?=
 =?utf-8?B?SjBoN3V2YXp2TFJ3R29iT3ZZRDYyZkNaWWhhV3dTZnVRVW9PaHNMMVJwenFm?=
 =?utf-8?B?cE9CRis3bTBsdi9TcVBjdU1yMFNyOWhBUHY4NUFEeDcyTmQ0ZTR3cFpXRTN2?=
 =?utf-8?B?VTdsVG91SWtYQ0RYSk9Qd0Y5NjEyenNkbVdoNThZendRdlBKOXZRbnk5eTdt?=
 =?utf-8?B?a0Z6aXdHQTlsbFdnYWcxM3R2QW1OQ0hVeWsxQnBoUVpqa3dKQVpHTklQc1Z4?=
 =?utf-8?B?Y2doR2N3dFp6TkFNQUs5Vjc1WCtWQ1ZITzQ0L2Jqa0VUUVZjRm42aW1MTUh5?=
 =?utf-8?B?NDRidkxhMjU2eHJkRXF5Z3hYWEVRbmdlTG95OE5ndW1EOWRyRkY0cFBFbmNr?=
 =?utf-8?B?WkRxV2NjbHB3dVRVQjNKMFVBMUF6Zm1SdllMNlhoSkJ2bTg1eHFsbWFWWHor?=
 =?utf-8?B?VGVKVGFSK3hESkZ5aFVIdWlPWU9LVVdkSXZicWg4d1p6SVpYbWNUT3p1L3FG?=
 =?utf-8?B?TSt6NEFIS2M2cnVtWUVOVHBqMHoraVdIOFpBbXdJalJVdHRpeVN3bjZURkRL?=
 =?utf-8?B?L2VHLzNlUlgzWVhieWxldFlBUEhoRWhXMjNNeHlaTDBqUXFZNjZuakRzaVdh?=
 =?utf-8?B?QjVaSGR0djJ1cmV2TThWZWFKM1NFOEU3UWJNM21hbTVEQlVNQlA4eXdIS1Rn?=
 =?utf-8?B?VDRGR1FSZ2dmRUVDWFpwRHFoSGtNUjk0SkRqTW9hbGwyKzJNWW9UVCtiNUhv?=
 =?utf-8?B?emNEdmZXajA3ck12K3dNMVU2ZlRBQzNRaE9oTkpsSmN1M0h6c1ZVTDNtSlRm?=
 =?utf-8?B?WkVMMTFYdGduSmVqM25PY1VYd2RKRjhFcklJa3J1ZnFxV3NUK0laamplZTNW?=
 =?utf-8?B?eFNVajY5Qm9ZdDk3aWtrek42WVdtdmhDcjVqZkthUDQwUExMaHFXM01jSWdy?=
 =?utf-8?B?R3ptUk1zaFYrMVU0dU5JcXpxS0pJRTRlbUtHMUp3ZS9yUlREWFB4OXBlclZy?=
 =?utf-8?B?amQ0a0NMYkRWUFN0STF6UVpZVUEzQzcwRHRqM3dUL2FpeTgvV0V1N3lRSVNr?=
 =?utf-8?B?blBFeG1tVVFyUkxybFVzUWE0QzAwTkRhMFpDY3V5WXpvNUpJbzdaOTFsaWNI?=
 =?utf-8?Q?NEPOCOZOG0cpnDWI7jrrQQNnT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a98269-29e8-4353-7f9f-08ddc8268bfe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 07:16:44.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZRzjGBNwLeWP1CRoPDi8sUjAqdfVQRccy8CYaFCqDgmWdPyvgMZlyhrJEryejHd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10845

The PF0900 is a power management integrated circuit (PMIC) optimized
for high performance i.MX9x based applications. It features five high
efficiency buck converters, three linear and one vaon regulators.
It provides low quiescent current in Standby and low power off Modes.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506181134.0Hkvy7CK-lkp@intel.com/
Signed-off-by: Joy Zou <joy.zou@nxp.com>

Changes for v2:
1. modify the copyright comment block to C++ style.
2. add reg_read/write for regmap_bus.
3. remove original pf0900_pmic_read/write.
4. remove many regulator operations.
5. use regmap_read replace pf0900_pmic_read.
6. use regmap_update_bits and regmap_write_bits replace pf0900_pmic_write.
7. move the code from pf0900.h to pf0900-regulator.c and delete the header file.
8. remove unmask status interrupts and add unmask regulator interrupts.
9. remove many interrupts check warning print from irq_handler.
10. add notifier for regulator event.
11. remove unused macro define.
12. add PF0900 prefix for IRQ macro define in order to avoid duplication.
13. use GENMASK() and BIT() to replace mask marco define.
14. remove redundant enum pf0900_chip_type.
15. remove redundant print info and comments.
16. add dvs property present check because this property is optional.
17. remove ret == -EINVAL check from sw_set_dvs() function.
---
 drivers/regulator/Kconfig            |    8 +
 drivers/regulator/Makefile           |    1 +
 drivers/regulator/pf0900-regulator.c | 1028 ++++++++++++++++++++++++++++++++++
 3 files changed, 1037 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 7423954153b07f55d2a618fcc4a78bfd631db774..cc0f86c374886261844004071067da263a4f3f01 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1006,6 +1006,14 @@ config REGULATOR_PCAP
 	 This driver provides support for the voltage regulators of the
 	 PCAP2 PMIC.
 
+config REGULATOR_PF0900
+	tristate "NXP PF0900/PF0901/PF09XX regulator driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	Say y here to support the NXP PF0900/PF0901/PF09XX PMIC
+	regulator driver.
+
 config REGULATOR_PF8X00
 	tristate "NXP PF8100/PF8121A/PF8200 regulator driver"
 	depends on I2C && OF
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index be98b29d6675d8be1ca984c2d137bdfc4ba2de87..74b029d29a8b7faf79f3f82bb848eab65568753f 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
+obj-$(CONFIG_REGULATOR_PF0900) += pf0900-regulator.o
 obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
 obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
diff --git a/drivers/regulator/pf0900-regulator.c b/drivers/regulator/pf0900-regulator.c
new file mode 100644
index 0000000000000000000000000000000000000000..7310fec3e66ea30b4a961666f48eb9889aae98b8
--- /dev/null
+++ b/drivers/regulator/pf0900-regulator.c
@@ -0,0 +1,1028 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2025 NXP.
+// NXP PF0900 pmic driver
+
+#include <linux/crc8.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+enum pf0900_regulators {
+	PF0900_SW1 = 0,
+	PF0900_SW2,
+	PF0900_SW3,
+	PF0900_SW4,
+	PF0900_SW5,
+	PF0900_LDO1,
+	PF0900_LDO2,
+	PF0900_LDO3,
+	PF0900_VAON,
+	PF0900_REGULATOR_CNT,
+};
+
+enum {
+	PF0900_DVS_LEVEL_RUN = 0,
+	PF0900_DVS_LEVEL_STANDBY,
+	PF0900_DVS_LEVEL_MAX,
+};
+
+
+#define PF0900_VAON_VOLTAGE_NUM 0x03
+#define PF0900_SW_VOLTAGE_NUM   0x100
+#define PF0900_LDO_VOLTAGE_NUM  0x20
+
+#define REGU_SW_CNT             0x5
+#define REGU_LDO_VAON_CNT       0x4
+
+enum {
+	PF0900_REG_DEV_ID	    = 0x00,
+	PF0900_REG_DEV_FAM	    = 0x01,
+	PF0900_REG_REV_ID	    = 0x02,
+	PF0900_REG_PROG_ID1	    = 0x03,
+	PF0900_REG_PROG_ID2	    = 0x04,
+	PF0900_REG_SYSTEM_INT	    = 0x05,
+	PF0900_REG_STATUS1_INT	    = 0x06,
+	PF0900_REG_STATUS1_MSK      = 0x07,
+	PF0900_REG_STATUS1_SNS	    = 0x08,
+	PF0900_REG_STATUS2_INT      = 0x09,
+	PF0900_REG_STATUS2_MSK      = 0x0A,
+	PF0900_REG_STATUS2_SNS	    = 0x0B,
+	PF0900_REG_STATUS3_INT      = 0x0C,
+	PF0900_REG_STATUS3_MSK      = 0x0D,
+	PF0900_REG_SW_MODE_INT      = 0x0E,
+	PF0900_REG_SW_MODE_MSK      = 0x0F,
+	PF0900_REG_SW_ILIM_INT      = 0x10,
+	PF0900_REG_SW_ILIM_MSK      = 0x11,
+	PF0900_REG_SW_ILIM_SNS      = 0x12,
+	PF0900_REG_LDO_ILIM_INT     = 0x13,
+	PF0900_REG_LDO_ILIM_MSK     = 0x14,
+	PF0900_REG_LDO_ILIM_SNS     = 0x15,
+	PF0900_REG_SW_UV_INT        = 0x16,
+	PF0900_REG_SW_UV_MSK        = 0x17,
+	PF0900_REG_SW_UV_SNS        = 0x18,
+	PF0900_REG_SW_OV_INT        = 0x19,
+	PF0900_REG_SW_OV_MSK        = 0x1A,
+	PF0900_REG_SW_OV_SNS        = 0x1B,
+	PF0900_REG_LDO_UV_INT       = 0x1C,
+	PF0900_REG_LDO_UV_MSK       = 0x1D,
+	PF0900_REG_LDO_UV_SNS       = 0x1E,
+	PF0900_REG_LDO_OV_INT       = 0x1F,
+	PF0900_REG_LDO_OV_MSK       = 0x20,
+	PF0900_REG_LDO_OV_SNS       = 0x21,
+	PF0900_REG_PWRON_INT        = 0x22,
+	PF0900_REG_IO_INT           = 0x24,
+	PF0900_REG_IO_MSK           = 0x25,
+	PF0900_REG_IO_SNS           = 0x26,
+	PF0900_REG_IOSHORT_SNS      = 0x27,
+	PF0900_REG_ABIST_OV1        = 0x28,
+	PF0900_REG_ABIST_OV2        = 0x29,
+	PF0900_REG_ABIST_UV1        = 0x2A,
+	PF0900_REG_ABIST_UV2        = 0x2B,
+	PF0900_REG_ABIST_IO         = 0x2C,
+	PF0900_REG_TEST_FLAGS       = 0x2D,
+	PF0900_REG_HFAULT_FLAGS     = 0x2E,
+	PF0900_REG_FAULT_FLAGS      = 0x2F,
+	PF0900_REG_FS0B_CFG         = 0x30,
+	PF0900_REG_FCCU_CFG         = 0x31,
+	PF0900_REG_RSTB_CFG1        = 0x32,
+	PF0900_REG_SYSTEM_CMD       = 0x33,
+	PF0900_REG_FS0B_CMD         = 0x34,
+	PF0900_REG_SECURE_WR1       = 0x35,
+	PF0900_REG_SECURE_WR2       = 0x36,
+	PF0900_REG_VMON_CFG1        = 0x37,
+	PF0900_REG_SYS_CFG1         = 0x38,
+	PF0900_REG_GPO_CFG          = 0x39,
+	PF0900_REG_GPO_CTRL         = 0x3A,
+	PF0900_REG_PWRUP_CFG        = 0x3B,
+	PF0900_REG_RSTB_PWRUP       = 0x3C,
+	PF0900_REG_GPIO1_PWRUP      = 0x3D,
+	PF0900_REG_GPIO2_PWRUP      = 0x3E,
+	PF0900_REG_GPIO3_PWRUP      = 0x3F,
+	PF0900_REG_GPIO4_PWRUP      = 0x40,
+	PF0900_REG_VMON1_PWRUP      = 0x41,
+	PF0900_REG_VMON2_PWRUP      = 0x42,
+	PF0900_REG_SW1_PWRUP        = 0x43,
+	PF0900_REG_SW2_PWRUP        = 0x44,
+	PF0900_REG_SW3_PWRUP        = 0x45,
+	PF0900_REG_SW4_PWRUP        = 0x46,
+	PF0900_REG_SW5_PWRUP        = 0x47,
+	PF0900_REG_LDO1_PWRUP       = 0x48,
+	PF0900_REG_LDO2_PWRUP       = 0x49,
+	PF0900_REG_LDO3_PWRUP       = 0x4A,
+	PF0900_REG_VAON_PWRUP       = 0x4B,
+	PF0900_REG_FREQ_CTRL        = 0x4C,
+	PF0900_REG_PWRON_CFG        = 0x4D,
+	PF0900_REG_WD_CTRL1         = 0x4E,
+	PF0900_REG_WD_CTRL2         = 0x4F,
+	PF0900_REG_WD_CFG1          = 0x50,
+	PF0900_REG_WD_CFG2          = 0x51,
+	PF0900_REG_WD_CNT1          = 0x52,
+	PF0900_REG_WD_CNT2          = 0x53,
+	PF0900_REG_FAULT_CFG        = 0x54,
+	PF0900_REG_FAULT_CNT        = 0x55,
+	PF0900_REG_DFS_CNT          = 0x56,
+	PF0900_REG_AMUX_CFG         = 0x57,
+	PF0900_REG_VMON1_RUN_CFG    = 0x58,
+	PF0900_REG_VMON1_STBY_CFG   = 0x59,
+	PF0900_REG_VMON1_CTRL       = 0x5A,
+	PF0900_REG_VMON2_RUN_CFG    = 0x5B,
+	PF0900_REG_VMON2_STBY_CFG   = 0x5C,
+	PF0900_REG_VMON2_CTRL       = 0x5D,
+	PF0900_REG_SW1_VRUN         = 0x5E,
+	PF0900_REG_SW1_VSTBY        = 0x5F,
+	PF0900_REG_SW1_MODE         = 0x60,
+	PF0900_REG_SW1_CFG1         = 0x61,
+	PF0900_REG_SW1_CFG2         = 0x62,
+	PF0900_REG_SW2_VRUN         = 0x63,
+	PF0900_REG_SW2_VSTBY        = 0x64,
+	PF0900_REG_SW2_MODE         = 0x65,
+	PF0900_REG_SW2_CFG1         = 0x66,
+	PF0900_REG_SW2_CFG2         = 0x67,
+	PF0900_REG_SW3_VRUN         = 0x68,
+	PF0900_REG_SW3_VSTBY        = 0x69,
+	PF0900_REG_SW3_MODE         = 0x6A,
+	PF0900_REG_SW3_CFG1         = 0x6B,
+	PF0900_REG_SW3_CFG2         = 0x6C,
+	PF0900_REG_SW4_VRUN         = 0x6D,
+	PF0900_REG_SW4_VSTBY        = 0x6E,
+	PF0900_REG_SW4_MODE         = 0x6F,
+	PF0900_REG_SW4_CFG1         = 0x70,
+	PF0900_REG_SW4_CFG2         = 0x71,
+	PF0900_REG_SW5_VRUN         = 0x72,
+	PF0900_REG_SW5_VSTBY        = 0x73,
+	PF0900_REG_SW5_MODE         = 0x74,
+	PF0900_REG_SW5_CFG1         = 0x75,
+	PF0900_REG_SW5_CFG2         = 0x76,
+	PF0900_REG_LDO1_RUN         = 0x77,
+	PF0900_REG_LDO1_STBY        = 0x78,
+	PF0900_REG_LDO1_CFG2        = 0x79,
+	PF0900_REG_LDO2_RUN         = 0x7A,
+	PF0900_REG_LDO2_STBY        = 0x7B,
+	PF0900_REG_LDO2_CFG2        = 0x7C,
+	PF0900_REG_LDO3_RUN         = 0x7D,
+	PF0900_REG_LDO3_STBY        = 0x7E,
+	PF0900_REG_LDO3_CFG2        = 0x7F,
+	PF0900_REG_VAON_CFG1        = 0x80,
+	PF0900_REG_VAON_CFG2        = 0x81,
+	PF0900_REG_SYS_DIAG         = 0x82,
+	PF0900_MAX_REGISTER,
+};
+
+/* PF0900 SW MODE */
+#define SW_RUN_MODE_OFF                 0x00
+#define SW_RUN_MODE_PWM                 0x01
+#define SW_RUN_MODE_PFM                 0x02
+#define SW_STBY_MODE_OFF                0x00
+#define SW_STBY_MODE_PWM                0x04
+#define SW_STBY_MODE_PFM                0x08
+
+/* PF0900 SW MODE MASK */
+#define SW_RUN_MODE_MASK                GENMASK(1, 0)
+#define SW_STBY_MODE_MASK               GENMASK(3, 2)
+
+/* PF0900 SW VRUN MASK */
+#define SW_VRUN_MASK                    GENMASK(7, 0)
+
+/* PF0900 SW STBY MASK */
+#define SW_STBY_MASK                    GENMASK(7, 0)
+
+/* PF0900_REG_VAON_CFG1 bits */
+#define VAON_1P8V                       0x01
+
+#define VAON_MASK                       GENMASK(1, 0)
+
+/* PF0900_REG_SWX_CFG1 MASK */
+#define SW_DVS_MASK                     GENMASK(4, 3)
+
+/* PF0900_REG_LDO_RUN MASK */
+#define VLDO_RUN_MASK                   GENMASK(4, 0)
+#define LDO_RUN_EN_MASK                 BIT(5)
+
+/* PF0900_REG_STATUS1_INT bits */
+#define PF0900_IRQ_PWRUP                BIT(3)
+
+/* PF0900_REG_ILIM_INT bits */
+#define PF0900_IRQ_SW1_IL               BIT(0)
+#define PF0900_IRQ_SW2_IL               BIT(1)
+#define PF0900_IRQ_SW3_IL               BIT(2)
+#define PF0900_IRQ_SW4_IL               BIT(3)
+#define PF0900_IRQ_SW5_IL               BIT(4)
+
+#define PF0900_IRQ_LDO1_IL              BIT(0)
+#define PF0900_IRQ_LDO2_IL              BIT(1)
+#define PF0900_IRQ_LDO3_IL              BIT(2)
+
+/* PF0900_REG_UV_INT bits */
+#define PF0900_IRQ_SW1_UV               BIT(0)
+#define PF0900_IRQ_SW2_UV               BIT(1)
+#define PF0900_IRQ_SW3_UV               BIT(2)
+#define PF0900_IRQ_SW4_UV               BIT(3)
+#define PF0900_IRQ_SW5_UV               BIT(4)
+
+#define PF0900_IRQ_LDO1_UV              BIT(0)
+#define PF0900_IRQ_LDO2_UV              BIT(1)
+#define PF0900_IRQ_LDO3_UV              BIT(2)
+#define PF0900_IRQ_VAON_UV              BIT(3)
+
+/* PF0900_REG_OV_INT bits */
+#define PF0900_IRQ_SW1_OV               BIT(0)
+#define PF0900_IRQ_SW2_OV               BIT(1)
+#define PF0900_IRQ_SW3_OV               BIT(2)
+#define PF0900_IRQ_SW4_OV               BIT(3)
+#define PF0900_IRQ_SW5_OV               BIT(4)
+
+#define PF0900_IRQ_LDO1_OV              BIT(0)
+#define PF0900_IRQ_LDO2_OV              BIT(1)
+#define PF0900_IRQ_LDO3_OV              BIT(2)
+#define PF0900_IRQ_VAON_OV              BIT(3)
+
+struct pf0900_dvs_config {
+	unsigned int run_reg;
+	unsigned int run_mask;
+	unsigned int standby_reg;
+	unsigned int standby_mask;
+};
+
+struct pf0900_regulator_desc {
+	struct regulator_desc desc;
+	const struct pf0900_dvs_config dvs;
+};
+
+struct pf0900_drvdata {
+	const struct pf0900_regulator_desc *desc;
+	unsigned int rcnt;
+};
+
+struct pf0900 {
+	struct device *dev;
+	struct regmap *regmap;
+	const struct pf0900_drvdata *drvdata;
+	struct regulator_dev *rdevs[PF0900_REGULATOR_CNT];
+	int irq;
+	unsigned short addr;
+	bool crc_en;
+};
+
+enum pf0900_regulator_type {
+	PF0900_SW = 0,
+	PF0900_LDO,
+};
+
+#define PF0900_REGU_IRQ(_reg, _type, _event)	\
+	{					\
+		.reg = _reg,			\
+		.type = _type,			\
+		.event = _event,		\
+	}
+
+struct pf0900_regulator_irq {
+	unsigned int  reg;
+	unsigned int  type;
+	unsigned int  event;
+};
+
+static const struct regmap_range pf0900_range = {
+	.range_min = PF0900_REG_DEV_ID,
+	.range_max = PF0900_REG_SYS_DIAG,
+};
+
+static const struct regmap_access_table pf0900_volatile_regs = {
+	.yes_ranges = &pf0900_range,
+	.n_yes_ranges = 1,
+};
+
+static const struct regmap_config pf0900_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &pf0900_volatile_regs,
+	.max_register = PF0900_MAX_REGISTER - 1,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static uint8_t crc8_j1850(unsigned short addr, unsigned int reg,
+			  unsigned int val)
+{
+	uint8_t crcBuf[3];
+	uint8_t t_crc;
+	uint8_t i, j;
+
+	crcBuf[0] = addr;
+	crcBuf[1] = reg;
+	crcBuf[2] = val;
+	t_crc = 0xFF;
+
+	/*
+	 * The CRC calculation is based on the standard CRC-8-SAE as
+	 * defined in the SAE-J1850 specification with the following
+	 * characteristics.
+	 * Polynomial = 0x1D
+	 * Initial Value = 0xFF
+	 * The CRC byte is calculated by shifting 24-bit data through
+	 * the CRC polynomial.The 24-bits package is built as follows:
+	 * DEVICE_ADDR[b8] + REGISTER_ADDR [b8] +DATA[b8]
+	 * The DEVICE_ADDR is calculated as the 7-bit slave address
+	 * shifted left one space plus the corresponding read/write bit.
+	 * (7Bit Address [b7] << 1 ) + R/W = DEVICE_ADDR[b8]
+	 */
+	for (i = 0; i < sizeof(crcBuf); i++) {
+		t_crc ^= crcBuf[i];
+		for (j = 0; j < 8; j++) {
+			if ((t_crc & 0x80) != 0) {
+				t_crc <<= 1;
+				t_crc ^= 0x1D;
+			} else {
+				t_crc <<= 1;
+			}
+		}
+	}
+
+	return t_crc;
+}
+
+static int pf0900_regmap_read(void *context, unsigned int reg,
+			      unsigned int *val)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct pf0900 *pf0900 = dev_get_drvdata(dev);
+	int ret;
+	u8 crc;
+
+	if (!pf0900 || !pf0900->dev)
+		return -EINVAL;
+
+	if (reg >= PF0900_MAX_REGISTER) {
+		dev_err(pf0900->dev, "Invalid register address: 0x%x\n", reg);
+		return -EINVAL;
+	}
+
+	if (pf0900->crc_en) {
+		ret = i2c_smbus_read_word_data(i2c, reg);
+		if (ret < 0) {
+			dev_err(pf0900->dev, "Read error at reg=0x%x: %d\n", reg, ret);
+			return ret;
+		}
+
+		*val = (u16)ret;
+		crc = crc8_j1850(pf0900->addr << 1 | 0x1, reg, FIELD_GET(GENMASK(7, 0), *val));
+		if (crc != FIELD_GET(GENMASK(15, 8), *val)) {
+			dev_err(pf0900->dev, "Crc check error!\n");
+			return -EINVAL;
+		}
+		*val = FIELD_GET(GENMASK(7, 0), *val);
+	} else {
+		ret = i2c_smbus_read_byte_data(i2c, reg);
+		if (ret < 0) {
+			dev_err(pf0900->dev, "Read error at reg=0x%x: %d\n", reg, ret);
+			return ret;
+		}
+		*val = ret;
+	}
+
+	return 0;
+}
+
+static int pf0900_regmap_write(void *context, unsigned int reg,
+			       unsigned int val)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct pf0900 *pf0900 = dev_get_drvdata(dev);
+	uint8_t data[2];
+	int ret;
+
+	if (!pf0900 || !pf0900->dev)
+		return -EINVAL;
+
+	if (reg >= PF0900_MAX_REGISTER) {
+		dev_err(pf0900->dev, "Invalid register address: 0x%x\n", reg);
+		return -EINVAL;
+	}
+
+	data[0] = val;
+	if (pf0900->crc_en) {
+		/* Get CRC */
+		data[1] = crc8_j1850(pf0900->addr << 1, reg, data[0]);
+		val = FIELD_PREP(GENMASK(15, 8), data[1]) | data[0];
+		ret = i2c_smbus_write_word_data(i2c, reg, val);
+	} else {
+		ret = i2c_smbus_write_byte_data(i2c, reg, data[0]);
+	}
+
+	if (ret) {
+		dev_err(pf0900->dev, "Write reg=0x%x error!\n", reg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct regmap_bus pf0900_regmap_bus = {
+	.reg_read = pf0900_regmap_read,
+	.reg_write = pf0900_regmap_write,
+};
+
+static const struct regulator_ops pf0900_avon_regulator_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+static const struct regulator_ops pf0900_dvs_sw_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay	= regulator_set_ramp_delay_regmap,
+};
+
+static const struct regulator_ops pf0900_ldo_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+/*
+ * SW1/2/3/4/5
+ * SW1_DVS[1:0] SW1 DVS ramp rate setting
+ * 00: 15.6mV/8usec
+ * 01: 15.6mV/4usec
+ * 10: 15.6mV/2usec
+ * 11: 15.6mV/1usec
+ */
+static const unsigned int pf0900_dvs_sw_ramp_table[] = {
+	1950, 3900, 7800, 15600
+};
+
+/* VAON 1.8V, 3.0V, or 3.3V */
+static const int pf0900_vaon_voltages[] = {
+	0, 1800000, 3000000, 3300000,
+};
+
+/*
+ * SW1 0.5V to 3.3V
+ * 0.5V to 1.35V (6.25mV step)
+ * 1.8V to 2.5V (125mV step)
+ * 2.8V to 3.3V (250mV step)
+ */
+static const struct linear_range pf0900_dvs_sw1_volts[] = {
+	REGULATOR_LINEAR_RANGE(0,        0x00, 0x08, 0),
+	REGULATOR_LINEAR_RANGE(500000,   0x09, 0x91, 6250),
+	REGULATOR_LINEAR_RANGE(0,        0x92, 0x9E, 0),
+	REGULATOR_LINEAR_RANGE(1500000,  0x9F, 0x9F, 0),
+	REGULATOR_LINEAR_RANGE(1800000,  0xA0, 0xD8, 12500),
+	REGULATOR_LINEAR_RANGE(0,        0xD9, 0xDF, 0),
+	REGULATOR_LINEAR_RANGE(2800000,  0xE0, 0xF4, 25000),
+	REGULATOR_LINEAR_RANGE(0,        0xF5, 0xFF, 0),
+};
+
+/*
+ * SW2/3/4/5 0.3V to 3.3V
+ * 0.45V to 1.35V (6.25mV step)
+ * 1.8V to 2.5V (125mV step)
+ * 2.8V to 3.3V (250mV step)
+ */
+static const struct linear_range pf0900_dvs_sw2345_volts[] = {
+	REGULATOR_LINEAR_RANGE(300000,   0x00, 0x00, 0),
+	REGULATOR_LINEAR_RANGE(450000,   0x01, 0x91, 6250),
+	REGULATOR_LINEAR_RANGE(0,        0x92, 0x9E, 0),
+	REGULATOR_LINEAR_RANGE(1500000,  0x9F, 0x9F, 0),
+	REGULATOR_LINEAR_RANGE(1800000,  0xA0, 0xD8, 12500),
+	REGULATOR_LINEAR_RANGE(0,        0xD9, 0xDF, 0),
+	REGULATOR_LINEAR_RANGE(2800000,  0xE0, 0xF4, 25000),
+	REGULATOR_LINEAR_RANGE(0,        0xF5, 0xFF, 0),
+};
+
+/*
+ * LDO1
+ * 0.75V to 3.3V
+ */
+static const struct linear_range pf0900_ldo1_volts[] = {
+	REGULATOR_LINEAR_RANGE(750000,   0x00, 0x0F, 50000),
+	REGULATOR_LINEAR_RANGE(1800000,  0x10, 0x1F, 100000),
+};
+
+/*
+ * LDO2/3
+ * 0.65V to 3.3V (50mV step)
+ */
+static const struct linear_range pf0900_ldo23_volts[] = {
+	REGULATOR_LINEAR_RANGE(650000,   0x00, 0x0D, 50000),
+	REGULATOR_LINEAR_RANGE(1400000,  0x0E, 0x0F, 100000),
+	REGULATOR_LINEAR_RANGE(1800000,  0x10, 0x1F, 100000),
+};
+
+/* SW1 dvs 0.5v to 1.35v
+ * SW2-5 dvs 0.3v to 1.35v
+ */
+static int sw_set_dvs(const struct regulator_desc *desc, struct pf0900 *pf0900,
+		      struct device_node *np, char *prop, unsigned int reg,
+		      unsigned int mask)
+{
+	uint32_t uv;
+	int ret, i;
+
+	if (!desc || !pf0900 || !np || !prop)
+		return -EINVAL;
+
+	ret = of_property_read_u32(np, prop, &uv);
+	if (ret)
+		return dev_err_probe(pf0900->dev, ret, "Failed to read property %s\n", prop);
+
+	for (i = 0; i < desc->n_voltages; i++) {
+		ret = regulator_desc_list_voltage_linear_range(desc, i);
+		if (ret < 0)
+			continue;
+		if (ret == uv) {
+			i <<= ffs(desc->vsel_mask) - 1;
+			ret = regmap_update_bits(pf0900->regmap, reg, mask, i);
+			if (ret)
+				return dev_err_probe(pf0900->dev, ret,
+						     "Failed to write voltage to register 0x%x\n",
+						     reg);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int pf0900_set_dvs_levels(struct device_node *np,
+				 const struct regulator_desc *desc,
+				 struct regulator_config *cfg)
+{
+	struct pf0900_regulator_desc *data = container_of(desc,
+							  struct pf0900_regulator_desc, desc);
+	struct pf0900 *pf0900 = dev_get_drvdata(cfg->dev);
+	const struct pf0900_dvs_config *dvs = &data->dvs;
+	unsigned int reg, mask;
+	int i, ret = 0;
+	char *prop;
+
+	for (i = 0; i < PF0900_DVS_LEVEL_MAX; i++) {
+		switch (i) {
+		case PF0900_DVS_LEVEL_RUN:
+			prop = "nxp,dvs-run-microvolt";
+			reg = dvs->run_reg;
+			mask = dvs->run_mask;
+			break;
+		case PF0900_DVS_LEVEL_STANDBY:
+			prop = "nxp,dvs-standby-microvolt";
+			reg = dvs->standby_reg;
+			mask = dvs->standby_mask;
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (of_property_present(np, prop)) {
+			ret = sw_set_dvs(desc, pf0900, np, prop, reg, mask);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+
+static const struct pf0900_regulator_desc pf0900_regulators[] = {
+	{
+		.desc = {
+			.name = "sw1",
+			.of_match = of_match_ptr("SW1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_SW1,
+			.ops = &pf0900_dvs_sw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_SW_VOLTAGE_NUM,
+			.linear_ranges = pf0900_dvs_sw1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_dvs_sw1_volts),
+			.vsel_reg = PF0900_REG_SW1_VRUN,
+			.vsel_mask = SW_VRUN_MASK,
+			.enable_reg = PF0900_REG_SW1_MODE,
+			.enable_mask = SW_RUN_MODE_MASK,
+			.enable_val = SW_RUN_MODE_PWM,
+			.ramp_reg = PF0900_REG_SW1_CFG1,
+			.ramp_mask = SW_DVS_MASK,
+			.ramp_delay_table = pf0900_dvs_sw_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf0900_dvs_sw_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pf0900_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PF0900_REG_SW1_VRUN,
+			.run_mask = SW_VRUN_MASK,
+			.standby_reg = PF0900_REG_SW1_VSTBY,
+			.standby_mask = SW_STBY_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "sw2",
+			.of_match = of_match_ptr("SW2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_SW2,
+			.ops = &pf0900_dvs_sw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_SW_VOLTAGE_NUM,
+			.linear_ranges = pf0900_dvs_sw2345_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_dvs_sw2345_volts),
+			.vsel_reg = PF0900_REG_SW2_VRUN,
+			.vsel_mask = SW_VRUN_MASK,
+			.enable_reg = PF0900_REG_SW2_MODE,
+			.enable_mask = SW_RUN_MODE_MASK,
+			.enable_val = SW_RUN_MODE_PWM,
+			.ramp_reg = PF0900_REG_SW2_CFG1,
+			.ramp_mask = SW_DVS_MASK,
+			.ramp_delay_table = pf0900_dvs_sw_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf0900_dvs_sw_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pf0900_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PF0900_REG_SW2_VRUN,
+			.run_mask = SW_VRUN_MASK,
+			.standby_reg = PF0900_REG_SW2_VSTBY,
+			.standby_mask = SW_STBY_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "sw3",
+			.of_match = of_match_ptr("SW3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_SW3,
+			.ops = &pf0900_dvs_sw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_SW_VOLTAGE_NUM,
+			.linear_ranges = pf0900_dvs_sw2345_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_dvs_sw2345_volts),
+			.vsel_reg = PF0900_REG_SW3_VRUN,
+			.vsel_mask = SW_VRUN_MASK,
+			.enable_reg = PF0900_REG_SW3_MODE,
+			.enable_mask = SW_RUN_MODE_MASK,
+			.enable_val = SW_RUN_MODE_PWM,
+			.ramp_reg = PF0900_REG_SW3_CFG1,
+			.ramp_mask = SW_DVS_MASK,
+			.ramp_delay_table = pf0900_dvs_sw_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf0900_dvs_sw_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pf0900_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PF0900_REG_SW3_VRUN,
+			.run_mask = SW_VRUN_MASK,
+			.standby_reg = PF0900_REG_SW3_VSTBY,
+			.standby_mask = SW_STBY_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "sw4",
+			.of_match = of_match_ptr("SW4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_SW5,
+			.ops = &pf0900_dvs_sw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_SW_VOLTAGE_NUM,
+			.linear_ranges = pf0900_dvs_sw2345_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_dvs_sw2345_volts),
+			.vsel_reg = PF0900_REG_SW4_VRUN,
+			.vsel_mask = SW_VRUN_MASK,
+			.enable_reg = PF0900_REG_SW4_MODE,
+			.enable_mask = SW_RUN_MODE_MASK,
+			.enable_val = SW_RUN_MODE_PWM,
+			.ramp_reg = PF0900_REG_SW4_CFG1,
+			.ramp_mask = SW_DVS_MASK,
+			.ramp_delay_table = pf0900_dvs_sw_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf0900_dvs_sw_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pf0900_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PF0900_REG_SW4_VRUN,
+			.run_mask = SW_VRUN_MASK,
+			.standby_reg = PF0900_REG_SW4_VSTBY,
+			.standby_mask = SW_STBY_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "sw5",
+			.of_match = of_match_ptr("SW5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_SW5,
+			.ops = &pf0900_dvs_sw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_SW_VOLTAGE_NUM,
+			.linear_ranges = pf0900_dvs_sw2345_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_dvs_sw2345_volts),
+			.vsel_reg = PF0900_REG_SW5_VRUN,
+			.vsel_mask = SW_VRUN_MASK,
+			.enable_reg = PF0900_REG_SW5_MODE,
+			.enable_mask = SW_RUN_MODE_MASK,
+			.enable_val = SW_RUN_MODE_PWM,
+			.ramp_reg = PF0900_REG_SW5_CFG1,
+			.ramp_mask = SW_DVS_MASK,
+			.ramp_delay_table = pf0900_dvs_sw_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf0900_dvs_sw_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pf0900_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PF0900_REG_SW5_VRUN,
+			.run_mask = SW_VRUN_MASK,
+			.standby_reg = PF0900_REG_SW5_VSTBY,
+			.standby_mask = SW_STBY_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("LDO1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_LDO1,
+			.ops = &pf0900_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_LDO_VOLTAGE_NUM,
+			.linear_ranges = pf0900_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_ldo1_volts),
+			.vsel_reg = PF0900_REG_LDO1_RUN,
+			.vsel_mask = VLDO_RUN_MASK,
+			.enable_reg = PF0900_REG_LDO1_RUN,
+			.enable_mask = LDO_RUN_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo2",
+			.of_match = of_match_ptr("LDO2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_LDO2,
+			.ops = &pf0900_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_LDO_VOLTAGE_NUM,
+			.linear_ranges = pf0900_ldo23_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_ldo23_volts),
+			.vsel_reg = PF0900_REG_LDO2_RUN,
+			.vsel_mask = VLDO_RUN_MASK,
+			.enable_reg = PF0900_REG_LDO2_RUN,
+			.enable_mask = LDO_RUN_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo3",
+			.of_match = of_match_ptr("LDO3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_LDO3,
+			.ops = &pf0900_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_LDO_VOLTAGE_NUM,
+			.linear_ranges = pf0900_ldo23_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_ldo23_volts),
+			.vsel_reg = PF0900_REG_LDO3_RUN,
+			.vsel_mask = VLDO_RUN_MASK,
+			.enable_reg = PF0900_REG_LDO3_RUN,
+			.enable_mask = LDO_RUN_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "vaon",
+			.of_match = of_match_ptr("VAON"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_VAON,
+			.ops = &pf0900_avon_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_VAON_VOLTAGE_NUM,
+			.volt_table = pf0900_vaon_voltages,
+			.enable_reg = PF0900_REG_VAON_CFG1,
+			.enable_mask = VAON_MASK,
+			.enable_val = VAON_1P8V,
+			.vsel_reg = PF0900_REG_VAON_CFG1,
+			.vsel_mask = VAON_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+};
+
+struct pf0900_regulator_irq regu_irqs[] = {
+	PF0900_REGU_IRQ(PF0900_REG_SW_ILIM_INT, PF0900_SW, REGULATOR_ERROR_OVER_CURRENT_WARN),
+	PF0900_REGU_IRQ(PF0900_REG_LDO_ILIM_INT, PF0900_LDO, REGULATOR_ERROR_OVER_CURRENT_WARN),
+	PF0900_REGU_IRQ(PF0900_REG_SW_UV_INT, PF0900_SW, REGULATOR_ERROR_UNDER_VOLTAGE_WARN),
+	PF0900_REGU_IRQ(PF0900_REG_LDO_UV_INT, PF0900_LDO, REGULATOR_ERROR_UNDER_VOLTAGE_WARN),
+	PF0900_REGU_IRQ(PF0900_REG_SW_OV_INT, PF0900_SW, REGULATOR_ERROR_OVER_VOLTAGE_WARN),
+	PF0900_REGU_IRQ(PF0900_REG_LDO_OV_INT, PF0900_LDO, REGULATOR_ERROR_OVER_VOLTAGE_WARN),
+};
+
+static irqreturn_t pf0900_irq_handler(int irq, void *data)
+{
+	unsigned int val, regu, i, index;
+	struct pf0900 *pf0900 = data;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(regu_irqs); i++) {
+		ret = regmap_read(pf0900->regmap, regu_irqs[i].reg, &val);
+		if (ret < 0) {
+			dev_err(pf0900->dev, "Failed to read %d\n", ret);
+			return IRQ_NONE;
+		}
+		if (val) {
+			ret = regmap_write_bits(pf0900->regmap, regu_irqs[i].reg, val, val);
+			if (ret < 0) {
+				dev_err(pf0900->dev, "Failed to update %d\n", ret);
+				return IRQ_NONE;
+			}
+
+			if (regu_irqs[i].type == PF0900_SW) {
+				for (index = 0; index < REGU_SW_CNT; index++) {
+					if (val & BIT(index)) {
+						regu = (enum pf0900_regulators)index;
+						regulator_notifier_call_chain(pf0900->rdevs[regu],
+									      regu_irqs[i].event,
+									      NULL);
+					}
+				}
+			} else if (regu_irqs[i].type == PF0900_LDO) {
+				for (index = 0; index < REGU_LDO_VAON_CNT; index++) {
+					if (val & BIT(index)) {
+						regu = (enum pf0900_regulators)index + PF0900_LDO1;
+						regulator_notifier_call_chain(pf0900->rdevs[regu],
+									      regu_irqs[i].event,
+									      NULL);
+					}
+				}
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int pf0900_i2c_probe(struct i2c_client *i2c)
+{
+	const struct pf0900_regulator_desc *regulator_desc;
+	const struct pf0900_drvdata *drvdata = NULL;
+	struct device_node *np = i2c->dev.of_node;
+	unsigned int device_id, device_fam, i;
+	struct regulator_config config = { };
+	struct pf0900 *pf0900;
+	int ret;
+
+	if (!i2c->irq)
+		return dev_err_probe(&i2c->dev, -EINVAL, "No IRQ configured?\n");
+
+	pf0900 = devm_kzalloc(&i2c->dev, sizeof(struct pf0900), GFP_KERNEL);
+	if (!pf0900)
+		return -ENOMEM;
+
+	drvdata = device_get_match_data(&i2c->dev);
+	if (!drvdata)
+		return dev_err_probe(&i2c->dev, -EINVAL, "unable to find driver data\n");
+
+	regulator_desc = drvdata->desc;
+	pf0900->drvdata = drvdata;
+	pf0900->crc_en = of_property_read_bool(np, "nxp,i2c-crc-enable");
+	pf0900->irq = i2c->irq;
+	pf0900->dev = &i2c->dev;
+	pf0900->addr = i2c->addr;
+
+	dev_set_drvdata(&i2c->dev, pf0900);
+
+	pf0900->regmap = devm_regmap_init(&i2c->dev, &pf0900_regmap_bus, &i2c->dev,
+					       &pf0900_regmap_config);
+	if (IS_ERR(pf0900->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf0900->regmap),
+				     "regmap initialization failed\n");
+	ret = regmap_read(pf0900->regmap, PF0900_REG_DEV_ID, &device_id);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Read device id error\n");
+
+	ret = regmap_read(pf0900->regmap, PF0900_REG_DEV_FAM, &device_fam);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Read device fam error\n");
+
+	/* Check your board and dts for match the right pmic */
+	if (device_fam == 0x09 && (device_id & 0x1F) != 0x0)
+		return dev_err_probe(&i2c->dev, -EINVAL, "Device id(%x) mismatched\n",
+				     device_id >> 4);
+
+	for (i = 0; i < drvdata->rcnt; i++) {
+		const struct regulator_desc *desc;
+		const struct pf0900_regulator_desc *r;
+
+		r = &regulator_desc[i];
+		desc = &r->desc;
+		config.regmap = pf0900->regmap;
+		config.dev = pf0900->dev;
+
+		pf0900->rdevs[i] = devm_regulator_register(pf0900->dev, desc, &config);
+		if (IS_ERR(pf0900->rdevs[i]))
+			return dev_err_probe(pf0900->dev, PTR_ERR(pf0900->rdevs[i]),
+					     "Failed to register regulator(%s)\n", desc->name);
+	}
+
+	ret = devm_request_threaded_irq(pf0900->dev, pf0900->irq, NULL,
+					pf0900_irq_handler,
+					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					"pf0900-irq", pf0900);
+
+	if (ret != 0)
+		return dev_err_probe(pf0900->dev, ret, "Failed to request IRQ: %d\n",
+				     pf0900->irq);
+	/*
+	 * The PWRUP_M is unmasked by default. When the device enter in RUN state,
+	 * it will assert the PWRUP_I interrupt and assert the INTB pin to inform
+	 * the MCU that it has finished the power up sequence properly.
+	 */
+	ret = regmap_write_bits(pf0900->regmap, PF0900_REG_STATUS1_INT, PF0900_IRQ_PWRUP,
+				PF0900_IRQ_PWRUP);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Clean PWRUP_I error\n");
+
+	/* mask interrupt PWRUP */
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_STATUS1_MSK, PF0900_IRQ_PWRUP,
+				 PF0900_IRQ_PWRUP);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_SW_ILIM_MSK, PF0900_IRQ_SW1_IL |
+				 PF0900_IRQ_SW2_IL | PF0900_IRQ_SW3_IL | PF0900_IRQ_SW4_IL |
+				 PF0900_IRQ_SW5_IL, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_SW_UV_MSK, PF0900_IRQ_SW1_UV |
+				 PF0900_IRQ_SW2_UV | PF0900_IRQ_SW3_UV | PF0900_IRQ_SW4_UV |
+				 PF0900_IRQ_SW5_UV, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_SW_OV_MSK, PF0900_IRQ_SW1_OV |
+				 PF0900_IRQ_SW2_OV | PF0900_IRQ_SW3_OV | PF0900_IRQ_SW4_OV |
+				 PF0900_IRQ_SW5_OV, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_LDO_ILIM_MSK, PF0900_IRQ_LDO1_IL |
+				 PF0900_IRQ_LDO2_IL | PF0900_IRQ_LDO3_IL, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_LDO_UV_MSK, PF0900_IRQ_LDO1_UV |
+				 PF0900_IRQ_LDO2_UV | PF0900_IRQ_LDO3_UV | PF0900_IRQ_VAON_UV, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_LDO_OV_MSK, PF0900_IRQ_LDO1_OV |
+				 PF0900_IRQ_LDO2_OV | PF0900_IRQ_LDO3_OV | PF0900_IRQ_VAON_OV, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	return 0;
+}
+
+static struct pf0900_drvdata pf0900_drvdata = {
+	.desc = pf0900_regulators,
+	.rcnt = ARRAY_SIZE(pf0900_regulators),
+};
+
+static const struct of_device_id pf0900_of_match[] = {
+	{ .compatible = "nxp,pf0900", .data = &pf0900_drvdata},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, pf0900_of_match);
+
+static struct i2c_driver pf0900_i2c_driver = {
+	.driver = {
+		.name = "nxp-pf0900",
+		.of_match_table = pf0900_of_match,
+	},
+	.probe = pf0900_i2c_probe,
+};
+
+module_i2c_driver(pf0900_i2c_driver);
+
+MODULE_AUTHOR("Joy Zou <joy.zou@nxp.com>");
+MODULE_DESCRIPTION("NXP PF0900 Power Management IC driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


