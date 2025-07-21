Return-Path: <linux-kernel+bounces-738807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A227B0BD65
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147043A4EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC47227FB05;
	Mon, 21 Jul 2025 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lf84atpx"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934719007D;
	Mon, 21 Jul 2025 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082201; cv=fail; b=M6mDm4RWZC9JuQeL2x+3Hw6yyoSONor+bvi+een5Ho9+PEED+ggIEbQ2bcqQllT7IOiisuyh1S3VASimrZxKbPwf+NeY1gQ1tEdSasI/E+2lUp8POw5kp0cSFPTuhKng+YeahHBKA3EKY/6lOI9f7UdPlW6NdNalX8xIcyiane8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082201; c=relaxed/simple;
	bh=/yA0qTG/ZpNZMMSJBCJJRyfItOMVhbkY1efWtzUv7SE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=cBD8yzr6Qyl9yFvkG7HraMMN9RxJuBByewzpywY8HCakIGqB0z374L/pDAWJlPc7y5R8RDhCc4c1fI79IFfC6Vmf2HUsWnOUGpWRa7jLzgluTzbF7nXYA5rGNMtBz02b1+v4vIbRHOjR5bS5AEIgINZYkpP+C8KIy01Z1ablS74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lf84atpx; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuZbDczxFM1G+GBC3PRE6gvUmS89+wws9qA8YEBrU3we6jb7Pi94045kk0RGX5HJrlFs6WtjIyT1Al29vdqxjIXMxk/iadT+rthSZy9sLCzdtGhqyFnbhyk9xYiL0WeTGiO8/NqNjCyo3Aen+dweq8IjZlsdE0xlpkTUXzKQXUddGbXOGh4h5fdZiK0ZgSqXVXO3j5laIz2wO5crxWJfNoq/QtP35qUKXbU3ikq73qweb2i4uvTRC4YuRYBvJKDYAdYrPsxR1vOIzYrF7PuDsFAeTrvNGyyfQKv5pfk6406HBVL75dPN+IQUQmyp2+EbHSYGPjtaoZjoOWyjAUSATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTKcb8T8SzM4pVHv5jnqTCKEsGcukj7qDhIi8LZnwh4=;
 b=NhC8M97aMSXX/SMFR/EomsKh2Wly2XUYAdfLHeK0ZMosDvCk7VgqlfAOsJCJHxm2fszjMxyqr1Z7mwq6mm6qRamzVcaM4fGwm+KrMYbx3zVentVz6V9hDaARkK2c6wHwbfGypuhR7UdevJDTaXNcwLn7/QJgrGoj/wBxa8+lqwKERE9ee4rpV1zQjZ4YqzqZWINnEeHZgX0v+aF1O/WHbwAzcDl15y2Xwnoi7Ld0NB3mdsKxFbk/mQzhbc4368ODvjPdrQ7YzcHbilnjdTnMjAb6HHpbOr+0P8BCFvMIYpeKoJS9PpTfqhoMhenu0vJDf6aiaoeiSQ8Fl18wjJWTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTKcb8T8SzM4pVHv5jnqTCKEsGcukj7qDhIi8LZnwh4=;
 b=lf84atpxTB7kE9ebq7zIABdzy9XOySQyqUrX2MF0NG2uFk6F+Y5gOKzbpKVsyOTvuTTzhiQoy31PVTgRvWhtbkr3Sbak8YHk/gDm+I5fBmu7CXTyhAC1oPb7sgh6xu1457a8M8AuXhfB/o4OO6DPIpoGJB7Tm0D4zng5akHr+hh4q+XcxpJ1PEt1e56780u4SOCnJTjPATB0Dnky6RV+EF6n9qiKYNpMB/zJLsV+8dnPD39FKlP84HJLe9s55phiHBRsrmj3Xry6v6MkAb0WyQgRXAuv4/ezowAwHizBNSqnPIxyH4Hg2YS6u4l3guQe9kz8QPurNv0DhMd3r6A6Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by GV1PR04MB10845.eurprd04.prod.outlook.com (2603:10a6:150:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 07:16:35 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 07:16:35 +0000
From: Joy Zou <joy.zou@nxp.com>
Subject: [PATCH v2 0/2] regulator: add new PMIC PF0900 support
Date: Mon, 21 Jul 2025 15:11:26 +0800
Message-Id: <20250721-b4-pf09-v2-v2-0-e2c568548032@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB7ofWgC/43OywqDMBAF0F+RrJuSmTw0XfU/ShdqJjWLqmgJF
 vHfGwt9UQpd3hnO5c5spCHQyHbZzAaKYQxdmwJuMlY3ZXsiHlzKDAVqkYPileK9F5ZH5BZqR2Q
 cYI4sgX4gH6Z72eGYchPGSzdc790R1uujRr/XROCCIxlNXmtjvdu3U7+tuzNbSyL+hpig9N4YZ
 QxIxCfcPAcXXyB3pVAILn3dX8AqCQIgrwpdfE6T79M+oUywQllbLA1p719wWZYbQR9HGHYBAAA
 =
X-Change-ID: 20250714-b4-pf09-v2-91cdee6d1272
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
X-MS-Office365-Filtering-Correlation-Id: 08a308c7-c4c7-4a2b-98ba-08ddc826868f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmQ5dndDMHpRNjZMRVRpbi9vcVFNRUVFcEVQeFgrTVdSZ3djVlVIRTVuV2dI?=
 =?utf-8?B?aC9PMzNqNjhvb3ZJYWtIS1FRMWh4b080azV2RUdYR3VTOVlLcWFhbXg5bTUv?=
 =?utf-8?B?RDFXL3FWcHRqZW9aZUZ3WXpZb29iaW8rVGMyWkh6V29HZWgwS3hMZFM1ZERV?=
 =?utf-8?B?WjROQTdzd3kzb2FIV1hNZVpHV1VtOTgzZWprdGRQSG1IY1hCakZCMkducUVO?=
 =?utf-8?B?TGZYODZIcUo0UXY5Y3lDYWVJZnFCdlRpY1Z1ckY4bUF1Z3ltWTVJNDVJL0xP?=
 =?utf-8?B?NU5iUmZpVFE4OHFMUGZnR3FrVGRHU2sva0FLWmdzRGMyOGZ0eEJyelBYQnZa?=
 =?utf-8?B?Y2ozcG00bUlJVXJTT0xuZWVRalB0WHRJdEFXS0pPcjJoak9sSjVOWnJ6eHdR?=
 =?utf-8?B?QitkWWZMeC9HM1BnYzRuNzljdStQallueFFjc0FUR1lIUTRKQnFUMDdDZGVP?=
 =?utf-8?B?VmxlVkVZME9iZHZiWmZoQnlhbEdJS3lCajVFbVhBUFRsL0xJZDBtTDZDb0Ri?=
 =?utf-8?B?UHhBZTVVbnYwQ042SWcwNDlxMUxWZ2xTMW5BekFIQUlJaUhGV3RwTFQ2OVZX?=
 =?utf-8?B?a01EZ2JxRjI3N3hXM3dwMGVjdjl6TmNmVWZjMGh3TVBkWTMwWitVN3REWkwx?=
 =?utf-8?B?a3VPSHhRTk5HeXBnNTVGRXNMSVZTeXZ5T040K2pZSXZWMWRFQkxyRW1LblBI?=
 =?utf-8?B?UHpCenlNWDVwY29zVnlFQmdxbC9Cc1Y4WW5HK1F6VTUzYS9LaVBKSVluZjB6?=
 =?utf-8?B?TDlVVGNVdzRpS1A3N2xvRVpMS1d4Rk5zbWlQUVYvZlBnNm80a0o1Q1dERjBM?=
 =?utf-8?B?TWU3dGp0WE9OdWRjYzdSS21WR1VYbVo1Z1JxUnA3UHFHbEVuN1htNDU5OVFD?=
 =?utf-8?B?NkVQcXBVeG5WaDlOWERzY0Q2akJZbHJtVUtpN0tjSDl0b0dsMndwOHRlcW1h?=
 =?utf-8?B?RERIbVVlTjhuZ3hNMmpGNHN2emNYMjdTQlNpcFZlR3UwYWx0Z3FJbkp3ZXRj?=
 =?utf-8?B?Y3UrT3NwdEtjT1BHdEZ4YnRqbVV0cHk0UGJyYjdVRllUYzhCSGFrZzhiZXFY?=
 =?utf-8?B?dFp3clBWb3BiZG1SMGJ5N201N1EzTGFYRnRzWkk5N3FNcDJSVzZQRjBBSGVp?=
 =?utf-8?B?anZkcGo2MXBmYUQrQ2Rqa0FlNzhvVVJpWHVZRWdVN2ZITTZ0U3BLYVZwbklj?=
 =?utf-8?B?cXBzRGVJQlVlYnA2ZEF6TWRoZHdCK281ZHJ3VGVqRVA0TEhJWm93TExYK1U4?=
 =?utf-8?B?KzByU050WklHVjBPRTU4WVYxL0JpenB4T09ibTZnaFBMeFc1N09uOGhwV3NI?=
 =?utf-8?B?Q1hVT2NTRndQM2lvTzgzMTF6T2FyTDlvSHYxOGNRSDFBM0kxWnA1bTFEcUY4?=
 =?utf-8?B?VmlqUTJqdGRQelNla3o1SHFKQ3NpNEgrVVNSTWF4R1phTThqd1dVRVFFNGN5?=
 =?utf-8?B?U2NlTm5OWUkwc0V1TzRLR3hqSVZ2djRGVUhWYmZWV0VTSUkreDFZR0dxTFZM?=
 =?utf-8?B?em93K3pya3p1b1NXRzlIaGxhZUlRM2J4QTdJdzlPMXEvSmRocDJoeVcvVWRO?=
 =?utf-8?B?d082VzJyRHlhTUh3ZFg3SisxbW90UWFZWFViNUdkVkVRdnNvWjZINEE5YWdr?=
 =?utf-8?B?SFJzWG1HSGQ1YzcvSHRJL3hWTmZUbUw1Si9EaEtEYkNLNkU1WElDQ1pFSHRX?=
 =?utf-8?B?dTJTeWhQYzNEdzRFcjZzWnAyVmszYkdsYlpWN3Y5bkRPOXpPWm82MDZsaXFp?=
 =?utf-8?B?MUpjanp0RGZIdUNUempNYkxocUtVa1hlM1ZNZEtPKzQxSmRzcEU4aU1iOHlZ?=
 =?utf-8?B?MG4vRytFTzVhZ2dNYlpuODhwK2VtZktocndGdExOeDEyTWV4akNpZW9LcGww?=
 =?utf-8?B?K2dYNnA1WlNKRmFnY3BDbzRxdUVPWTdKcStaU3VqbTVoY2xjSmN3eFJJUGJj?=
 =?utf-8?B?RTZwU1JxQTNRYy9oRi90enU4TVdOakM3MDJxUUFTTWsxOTNnVlVBYy9FT2M2?=
 =?utf-8?Q?g4CrVD4zwjw1Vl7ergBwwScTpDFYKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V01YUGZ0WXkzRlFpdDlqK0IzcEY2TEJYYTg3bDJtV1BaUFhNVWlsQ2dnQlMr?=
 =?utf-8?B?c1M3dWlmS09iR1B0M0gwUHRaUW4rYUxDb1grOVdwcFZxcXg5NlBqUStaaWR1?=
 =?utf-8?B?MW00QTdCZC9FV29ZTFNsUUZEK25qdXBobGhzZldLVXpFYlRtb2RURmRQT3VL?=
 =?utf-8?B?UHM0eTY3SE9VMGtrTVJRS0ZmeWt5dHNEQ2hSWjNsRHJENEl6NVd1ZUk2MVZk?=
 =?utf-8?B?U1M2SkJaeUpVVGFjbEZNVVNvdkpTQXZHeDM1RVRDd1VCRWlua0p6V0NTSDV3?=
 =?utf-8?B?NE1uaklicVptY01OMHZpUW9CNjY5OG5VQXVyOS95a1pPSFQ3UmtVYUJyRDhx?=
 =?utf-8?B?SlhhUXYzOVZya1RQR256eGtIUzRKSnBSZFN3MUZwdnhVVmd5bXZLLzdpbmZx?=
 =?utf-8?B?bTFyQVgrQmdEOGl2aUtjNmM3VmY5Tjd0UEY3SElya0MveFJUM1hjcDdzaC9Z?=
 =?utf-8?B?b0wvT2lHS0g4Sng3ZmxCQmw1UXFLMXJvVVBPUnBrVS8vbTN1bTdUaVBVYzd0?=
 =?utf-8?B?UUUvc21DVldvU1pzOEdWTEEwbHVjUy8yNUJSeUJGQXBBcTg1Rm9JNHhsSlJy?=
 =?utf-8?B?dVFkdDI2TlNCb0pBeDcybGR4T2ZzSHpDMmZ1eVM0cGxNUXFBTEx4YklibUlq?=
 =?utf-8?B?Ty9Ic3lVeFlBRFE2V1VxK0hYc2s2bkpSMkNVNGlJTk02dU1QcTE5NWhMQW96?=
 =?utf-8?B?OTlJdGRWblRuNnE4Y3FDd0JTeURWZkxBV09iVnFRaEFidXo2d0p6TzU5TnlZ?=
 =?utf-8?B?U0lZOXFLRS8xcWM5N1JDVUZqb1RMeFR1R0RIeDRIV3Rid1phN0RXd0xQOWxR?=
 =?utf-8?B?MW5Ed2RjQ3kyQnhTOWhMU0FCbllZN0ZtbzBpNzhmNmttUG93ZHZkMUJBOGVi?=
 =?utf-8?B?WkRmSFQ4K3h4ZEpKZjF1ajdpRmthSWlQc0RXMHRac3BUbDJhR3hpTFAvMTBW?=
 =?utf-8?B?eUNYbjg5T0ZGY2NSY2xSTm1PaFgzVkhTZGxYd2lzYkpZTFdBZG1pNmF1Tm51?=
 =?utf-8?B?Q3pKRDV1UktvcjVEZzJNNHFKbGRZNW10dWxNL0ZXY3YyWm5rOWlrZ05ZUU9n?=
 =?utf-8?B?TGZCOU9YS2pvMkIyY3J4K2h0YXZQb1NqQ21jbVdwdGZ3bFF0aWFucG13NDZu?=
 =?utf-8?B?UFpyMHlDLzl1WDMzdWpMMjJLaVJHTnJ3SHBhaitKUU4wUnpNNWNjbGwxNWcr?=
 =?utf-8?B?L1VrbXZnVE4raFFQc0hmQmQ3d0k3Smg4VHkyR0t5ZjR2K0lTOE5GRElVTFJV?=
 =?utf-8?B?RW1UbHlhU0VNL1RPVVArSll4NU9VaVRXVFBEYUZCUCtIRUUxOTh6ZUFLclND?=
 =?utf-8?B?TFNVNHo2R0o3NDlEQ0VyaUVtckdHeXUyU2dNUE91WlRzU2p5dmNKaGUzdmo5?=
 =?utf-8?B?eGU2TVFIZVRyTHg3aTZlUTNQOUo0d0lRSGxhcXNQVmg1VHVmb2ZVdzB0d0Na?=
 =?utf-8?B?WEErY0s5eEd6ZkVVRjQ5QXYxZHVBUG03cFBrUU5IUGF2OTh5cHJ3UndHU0JD?=
 =?utf-8?B?WlFkSDhBczJaZXVTS0VtSU5qd2oycWJBN1FxMzVBK1dTNTdyc2Y1YmRzWk9H?=
 =?utf-8?B?Ni9uZ05jVkRmYVhkRXF3OXowRlA3dm8wYzhJSGd1cVFIOXVVUEVPQ0cwTDZk?=
 =?utf-8?B?eC9iTUZ3d3hiQWNiaXFMelM4di8rUzNIT0hiOFluWFJLS0ViUXNxWG9Qc2Zk?=
 =?utf-8?B?UVJ6bGN3ancyY1lTc1ZYTnozMnAxaytzeUJJTHM2ZGZaSWhwVGJVeVdwZkpp?=
 =?utf-8?B?eGhLNWVFTkY1SVpIS2lyU2xmVDRKSkVnRXZOSytRMUVyQXVxYVBneXBVUnNV?=
 =?utf-8?B?azhsNUlhbUxjSkl5MVN2MFR1Ylkwb3phUTlYTkJjTnQ3Skl4YVZkUmlBL0FR?=
 =?utf-8?B?NWhsM3RUUnd2ZFZOeHNaeHQwbTl5bXR1OTVFNlJZbXlMMnVML0g2cVF6amY4?=
 =?utf-8?B?VEkrbWhUVTVTRUdKUDM1M3hkdXFHRU9Eb0hzbDRNSGVLRktJR2kyVWRzNGIx?=
 =?utf-8?B?MHJib2lnYmZmMzlmQk5UKzNwbkhPSkgvcXQ5bGxVQm9TSnkxTm5DcHBiSkgr?=
 =?utf-8?B?bUE1aEZJT3hkWkc4a2o4eEJ1R0U5cEtsbW1scWRrNzk5eEJVK1hsWE5ZK1ky?=
 =?utf-8?Q?1Cp5FwzX9TnnqhnNMal25Xb8Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a308c7-c4c7-4a2b-98ba-08ddc826868f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 07:16:35.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4b3gSidEZdWsv58jU1DChxvkhaARzyM5bkkpuV+2atTm/6xVn3qn8F+9scpTEtdf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10845

Add binding document and driver.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v2:

binding part
- modify the binding file name to match compatible string.
- add one space for dt_binding_check warning.
- remove unnecessary quotes from "VAON".
- remove the unnecessary empty line.
- move unevaluatedProperties after the $ref.
- move additionalProperties after regulator type.
- remove unnecessary regulator description

driver part
- modify the copyright comment block to C++ style.
- add reg_read/write for regmap_bus.
- remove original pf0900_pmic_read/write.
- remove many regulator operations.
- use regmap_read replace pf0900_pmic_read.
- use regmap_update_bits and regmap_write_bits replace pf0900_pmic_write.
- move the code from pf0900.h to pf0900-regulator.c and delete the header file.
- remove unmask status interrupts and add unmask regulator interrupts.
- remove many interrupts check warning print from irq_handler.
- add notifier for regulator event.
- remove unused macro define.
- add PF0900 prefix for IRQ macro define in order to avoid duplication.
- use GENMASK() and BIT() to replace mask marco define
- remove redundant enum pf0900_chip_type.
- remove redundant print info and comments.
- add dvs property present check because this property is optional.
- remove ret == -EINVAL check from sw_set_dvs() function.
- Link to v1: https://lore.kernel.org/imx/20250617102025.3455544-1-joy.zou@nxp.com/

---
Joy Zou (2):
      dt-bindings: regulator: add PF0900 regulator yaml
      regulator: pf0900: Add PMIC PF0900 support

 .../devicetree/bindings/regulator/nxp,pf0900.yaml  |  169 ++++
 drivers/regulator/Kconfig                          |    8 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/pf0900-regulator.c               | 1028 ++++++++++++++++++++
 4 files changed, 1206 insertions(+)
---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250714-b4-pf09-v2-91cdee6d1272

Best regards,
-- 
Joy Zou <joy.zou@nxp.com>


