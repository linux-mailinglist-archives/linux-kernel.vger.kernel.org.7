Return-Path: <linux-kernel+bounces-801958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5555DB44C12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4691C248A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5724DCE5;
	Fri,  5 Sep 2025 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OCsUuA8Y"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320814C9D;
	Fri,  5 Sep 2025 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041298; cv=fail; b=rJfNObARjSokt/zcn8Ql6Z89TB8xR2w7nAS4UZHqIdHVck2y5kQMA5bvhqI1YL/g5nraS+rYDep1+VF0qFmSLpgK589cwNVijW6goEVQhPb4CVVVExdbt22ODoRdSfBQDjKvRJLTeGYP27f+3NI2xjEWy7v1ZCArj4kYy05VYTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041298; c=relaxed/simple;
	bh=Ftp7gIvMIlS0ySV3bxVT1ppQbmqxX3ICaF5OfS6Zsao=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=hjnELxKqCulc17aUlnWVrDD35rwk5CcYzd+opQyqiNaNtDF2MpeePoXGh834bQUrzh5SuHjURgNGfy0EwC38cQV3U16XHFE6S7ImGQK/xS72R679lEtVFuEc3PqLizD8vNB4ych28FjBUVAnXHF56DrGiXsXIi+/GF4k7KgzUHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OCsUuA8Y; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9p7HA3/e1K62tN+NzTs8DVfoPC/0ZhIoxFMcL+gUgg5m3fAr8pmoV1HmFicaL5G/5ZmlqesSDGdvqMmO7uaw8ZH23PBLeXaBtXWtuTuHvCQzXOBQ9ib39C2R8JsobQd43ntbc4AIE4pnjfUOeDp1uUOtHAne+lrB3jWCv2peZ3ukumLMrpReSVceyvphCYNV8aGkegbgVSX6RZGfqPWCFdZ1wc9ZNO/j+FSYKmZGNFldTTmskDNxI8mEH1iMCOwsEb5DjW5qOaY3iDGGx75CV4MjM+D9YN9NUFrlh6UIFWeWgVy4gY9t13K77wyuXqe20lChZPO+TlN85LFkaXIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLiWqjrsXC/7UUBkPv5qF6TzCGN+MoFLT5Uf8eE8epU=;
 b=fVIiRDpcPW1P+c1TGLtLnTyr8Cx2dOYagtr66aDGrlF28N32iEPQIj/5LcAke1bV0iOlMDLLuThrEFOU1Lr+/Xt+uUoKIqfEs/ANenIiXavyrUg8pIReXf1hz0Tsft3VZZFxfs3Uqf1E09kw0d4imdeIjxp0drcqAfZ6lY5TmcLWod0t9UkNsAEeszbo1r++5DMQcAYN+HCuGJs/tlS5MlI8aQ5zzs1mHn5/NAbcdngYlF15JNBZoFeg+au9/P0jnnRcyLMGsHP4Zcy3H2CcO1QHfEdGAc9inYDoJrGTQ7ce7XayxA6SAsNA1OnDBAR7G+1Cljr/rfv6IJHDgymL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLiWqjrsXC/7UUBkPv5qF6TzCGN+MoFLT5Uf8eE8epU=;
 b=OCsUuA8YvepLNpGLbD+HGP+j7YdQmXrnAVlvnJYK+3XIfyIK3LtWlyNqrLLEQJALHngoydreD9W5NqXLeatPeWBmd/mja4XGKyIZnxbt1qr++1QQzva9Ojio2VW+XcYc3RrAa3iBJnpU9jw78nwSOEOzePJiFHd/Pu9BQmzOjxjjrnQztks0PTdmMjVTSx7LhBp+zSVwmut1jZ3M2gdm1sh0JDkRaStXvWoarG04NyPx0L0ziRKmJCUi1XSPgnIX0pCTecuQI/xD0g+gZTWzF2iZ6WO1Zxd7RluwVTIo/d0eaFgcBGKBsn4muQ+96JjtBVbqWYOURTJ4iXP1rL0sZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8207.eurprd04.prod.outlook.com (2603:10a6:102:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 03:01:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 03:01:33 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 05 Sep 2025 11:01:09 +0800
Subject: [PATCH] arm64: dts: imx8mp: Correct thermal sensor index
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-imx8mp-thermal-v1-1-64401ac8edb0@nxp.com>
X-B4-Tracking: v=1; b=H4sIAHRSumgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNT3czcCovcAt2SjNSi3MQcXQMLI3PDZNPkJNNkcyWgpoKi1LTMCrC
 B0bG1tQBIiAQmYAAAAA==
X-Change-ID: 20250905-imx8mp-thermal-08271c5cb5c7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Amit Kucheria <amit.kucheria@linaro.org>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757041287; l=1478;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Ftp7gIvMIlS0ySV3bxVT1ppQbmqxX3ICaF5OfS6Zsao=;
 b=oc9XN7aSQa09uWPsqkMzk3c1su8OfFsAevtFpehDrYfXyLkBIUaAG8ihprKiAQ91aD+9UiUji
 Jp2AnvB/M3YD0Eo7RMQ9CtrbJA7EAWAhaM0Wdul3cquGYCn7QCKun7y
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: cf033142-64e2-45de-dcbf-08ddec2884aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm1oRW91RzJhSGZlNzUwNkx0V1BnalBOWGcvR21uUHhtSUJsUy80QVhHRTI1?=
 =?utf-8?B?S3RmampIdW5qSVhkMUdPKzB3eGpoMFBCVVVDVWV4QlRDM3BIUk80dUEzWWti?=
 =?utf-8?B?KzV0Q2NCRTRCdHZhQXNaVmdHTDFadFM4SWxLcXVXSWJicDU0V1pIcFBoaGJy?=
 =?utf-8?B?MmdzUHdoRVh6VXlwR1hiMkFqdXNXZHpRTlBldkdudkZuSm1VQ3BWV25yTWh5?=
 =?utf-8?B?S0NkUmgrSitmTkNzV1JqeEV5UFRyWEpwVmUzV04vOHNQT2FtbWhFRWxUWXV2?=
 =?utf-8?B?M2YweFlWQThoSHBxaU55SUJqbjYzT1ozZHdDREY4dDRzbEJhVFV2dWh2QmZT?=
 =?utf-8?B?OHIxVEdNdnUzMTNFYkliTkp6THdEdXpqT2Y5YWxSSGRSY0NzTkwzamV4UC9J?=
 =?utf-8?B?eHNWbnk4ZHJJNjlzYzRmS3lLTXRPQ1Fxbjd0cDZuNmhhMTdiaXdSZUdYWUE1?=
 =?utf-8?B?c0phVXh4Uk4vTVNCYlZWOGIrNER5c244bnUxVk1CWm5tN2hQSyt5ZFZxcldw?=
 =?utf-8?B?YzY4TG5ObWE5T3RNS2FCbU9rT29EVDhWSEZFZTI0c29vWW52YndSaVR4MWt1?=
 =?utf-8?B?Z05FTUFXQzNqS29XTEp1WDlnUVJxWThsNnFML0IyWStzR3FkUFRNK0lPeEtG?=
 =?utf-8?B?RDZseWRKbWJqM3NVeTlVcFo0dzREaVdvc0V1UFBlalBiQTFRUy9KaHVYMXR4?=
 =?utf-8?B?bEZ5WTduTVlNSTdzMGJuKzNkeXoycTNpa1NMNTJRZzliVytSM2NVa2hzSEIz?=
 =?utf-8?B?ZG9iZ3dWVlRxb3RiUjBoa1FybUFtMExvTUpXRVpMQWxaSzVwYnVNc1Z3Yjkv?=
 =?utf-8?B?dEVPMFRkV092SWNjMytXUEVydkptTDdnYVlaK3l0dGZrV2lMNVFEd092bkd3?=
 =?utf-8?B?bGhuYWxNN2JweHNMV3M5OWZYMWJDeUt3TXdRSCsxVEFVelhqSGpqU3BFTThx?=
 =?utf-8?B?UFNWcmZvajduZUlSNnRwMHFIdHFxeWFDenl5Yjg1UmcrZnI4eFlGMUl6Vm1P?=
 =?utf-8?B?TGJMSHIzUFNwQ3BPeEVGK05HVEtReXQvRi9BZ05rK2E1a0c1aDZzNXR5c3Nk?=
 =?utf-8?B?cm5LVzN1UVlERnRPYXZkTnI3aFBTL24wUkdVNlhHSjBvY0w3b2lydVhqdlcz?=
 =?utf-8?B?clptNU5ZKzVtaFNGMlhRWHl0RklTWkk2VkhxZ2doZk94Y3FNVzVOMFNHTEdK?=
 =?utf-8?B?c3hRUlhxMlBoc29rRzZmK01TUldGSStzZU9OQzZIcGI3K2dyMVZPbUp6cktH?=
 =?utf-8?B?L0pEbWswcjIzaGx5RElaaHBRNjB6b1NldDNWWXQ0bGZoTEp3ejdzNDRBb1hP?=
 =?utf-8?B?YnFBQVAzYTZ6cmxkR1QwTCszTEJFcVJSYjByd2RYWUovMTVZeXhmZjJxSnov?=
 =?utf-8?B?SmlGQkJZWCtJQTQwYS9lQ2xLa3F0RUQyZFRlUklMajkwbFc2TkNpZ1VGQ2ZO?=
 =?utf-8?B?aDZOTXpNSFpJMk55ZXhaM2pNSlNsODRuZFpNbFdJWkNzWVBWVGoyYnFiOWIv?=
 =?utf-8?B?UnpmMkZ3MjZZK1g0bWp1eTJlMTZ4M1NqT3laU045V1hoaVRnT2o0cGNuTTBx?=
 =?utf-8?B?dzF1OHFNclVMTkZLTkN3bk1nc25jNGxJaytxcCsxSVlhWG1kTDBVRmcxT3BI?=
 =?utf-8?B?amJYd1U1N3hka0ZWOWdBMUtaTzVlWG0rb3F2L21jM255d204a05LMUYvQ2xW?=
 =?utf-8?B?b2tJTldMUHB1c0Rzb0QrUklvbUpjd2lGeWlqVVRRZ1BzZW90M0JOK0ExYmhu?=
 =?utf-8?B?bmIrb3hEV2xCQnV3V3V5TnFJVjV3UEh1RU5YSTRPSW5LRno4R0M2eFJqS3Ew?=
 =?utf-8?B?V2gxTzdYZTV3bmhzWllubHhXQ0xiTndSbVRobUtDWFFkS2JCeW9mQXJxMUNr?=
 =?utf-8?B?eDJDV2QxMWF1eTgxM0pkc2pWejZ3cGdieGQxME9tZ21zdmZhelJOdlE5dHNh?=
 =?utf-8?B?VXcxK0tvMzRackpMcWRhOTRteUN6MWpwZ01SS1QvQUhYSm9PZEV4KzFFMmJL?=
 =?utf-8?B?b3Z3Y3Qwbit3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFVWOVJRNi92V2FIU2VlTGdDSDBTcjhSUnFUMkNSRnU0d0c2eUtzZ0dJU0dP?=
 =?utf-8?B?UUxkbXZ4eklYNlVFenJ3bXhlZEs4WGFwc0krM21UdDBjRVZvSlp1VlpIbTh1?=
 =?utf-8?B?ckJaUTc0U3Y5NXRiS1hXSXVCTUJXQjFtOGwva210VXVhcmFLQUE3dEdYZ3lT?=
 =?utf-8?B?R3BLcDZrYlFsTTFTZ1hmQUVTS1FsRUptZ3EwRC9yRGdXOHZsSmZkMnRzY1ZV?=
 =?utf-8?B?RHJucXNhZHg2SERScVg5dXNHbEVxaGV5YkV3ZWIzU2FEQmY0VDFsS1FiaGVR?=
 =?utf-8?B?K3RSME14UEhRUklQbEVBNEh5K0xDSXdsN05kRDBOWW5kbk9wZW5TWlNqUm8y?=
 =?utf-8?B?RWNBVTdKcjVLR3VGdEx1NjdpQ0lPRHdobXczSTdlTFZ2bGkwY0NYZlRvbFkw?=
 =?utf-8?B?V2U5M2NPNUJIaHladWFBWDRUNWZkUk9XMHFiUVJxSHRoRkVkaW1zYVJ5YkNC?=
 =?utf-8?B?cGVtSzJVRHUwcUppMVl0SHl0cHF5eEYzb1BaNnVjdGdFSkxwV0dxZTFTYWVK?=
 =?utf-8?B?MFFpeHpYMy9FTU14STZ2a0MwZmhzT3p3NGJvL05HV2l0ZjRpMUdjZVEwRlJ4?=
 =?utf-8?B?Q3FaWnY0WFFIMkd3TFFaeGJzZTZsOU1VQW44alNzeVQ3R0NlRGd3SkR4ZHNX?=
 =?utf-8?B?MEMwNlI2ZHliek5ZSmQ5N2dkN29Ba2FYUHRFRzVuSnVOblg0dGpnWnE0QTZy?=
 =?utf-8?B?UHFkSDJvbTVVcDRKUWVWbzk2dDF0ZDRLM1FqclIzZ2ticmRBTmlwUlRDVjly?=
 =?utf-8?B?QXF4SnVoOFJTUXErS2drU0VwN3VXelhCdkJWQW5jblF0ZkN6M1FNOFFMUkFI?=
 =?utf-8?B?UXg5NFFDS1BJcTBCQnkyc2I5b1FjdlRzaG5lWVRCUWpRNm1MOHpNT3I2bzRu?=
 =?utf-8?B?QnNEY0tiV0ZodGx6Y1Awc2tleHZKYTluTjRJL0RENHpZb2xwa2VlaTRXNHlQ?=
 =?utf-8?B?QU5JRmpFZDk1NnJuZVRIR3hMeDVoSnllZHY2eTZCVm1yNkxxWEEwU0FFbHZv?=
 =?utf-8?B?Yk8xM2ZqVk1oWExDWnBpV01icmJCSDNsUDgvVDUrVGRZdXllc1BKTFBjY1VN?=
 =?utf-8?B?UEFibWNGdlg3V2J1RzZKVkpnb3h0TytLbytOM2JDMzluNWN1NXQxTjFNNytJ?=
 =?utf-8?B?SlpaU0I2NDVIL0hhQUpQWTFpRjVVK0xkOEhad1B1NFJQMjR3UXQ5QytNeXhv?=
 =?utf-8?B?WWFMMkdMVmNVT1FvRFpxSy8yN20yTTRsOGFjcnpyNkpPUTdoTmdYL1g2S1dp?=
 =?utf-8?B?bVhvZWd6ZWVJM2R5QlcyeEdva2laZzF3T2tCaGU0R091ZWZJOHBhbElyQ3lj?=
 =?utf-8?B?bi9ZNWh3MjhsVFZjMmE4TXRicnZMZVN3Yy93UFhBcDBUd0hxdUJrRUNxdUc5?=
 =?utf-8?B?bXQxdmRNdmVxb004MWU5TVhoL1diMVc5RC9tRDBCaWM1ZjlnVFZodTM4MXpL?=
 =?utf-8?B?bHZXMy9pd3NMNHhHYjVicWp0Ujh3M29vRGpBN1k2WTk0eU9KZ1pBTFVtOE9s?=
 =?utf-8?B?M21CNFBxeDd5d3BsZTZSRitsd1dsdzhmKzR1WUdrN2dRcm9EanUxUUZwN3h0?=
 =?utf-8?B?SlVNR0Y3WVRzNFpyaVRpc0JPenhLcERucE01bWIzRjVMaXVHRHRETWo5OUo4?=
 =?utf-8?B?Ni8xS0lZQmJ5cHNMSUNEWWpjbDY0Q2lVUHJzRTRsL2xsNXpmTVdwd3cyanFh?=
 =?utf-8?B?c0N3bFBEZXNyZWJDZ1RnRmpYNndnL21EdVFhTFIzSERpQkVwTjVRTGdKZ2o3?=
 =?utf-8?B?NVl3aTVGVzE4ZE9qbEw1RUkxVjg4THVHV3h4Z3gzWStrcC9FZVV1YjltV1Ix?=
 =?utf-8?B?YU1EeUtEZUowaWczSG1rM2dUaStCOTFHRTdDdDNHQkEvVDdwMG01TVpCTDNJ?=
 =?utf-8?B?bmN0enQyK0VHZHpNSDJFQlR0cm1zMUJXc2xOVjdRU1o3b1BKbEdvQUpyazh3?=
 =?utf-8?B?VFF3SGRyRG5EV0pnblhIZXgyUHNWWC9ycWVmQi8yTkNLTjJyQlVud3p0VG9w?=
 =?utf-8?B?RlJFVTc1eDRJQUpRT0pReWxaYlhiVVhuM1BjaTJUL1JWTVJmOGhBR0M2dWRS?=
 =?utf-8?B?YVZyV0REZlhoVEJid2oyT2xZcXdlODJGK0x6UEdzRnZuek9xSTZQRzdZbUp1?=
 =?utf-8?Q?RS9QZtN7rJLw4rG1FVbMiRfbq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf033142-64e2-45de-dcbf-08ddec2884aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 03:01:32.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2onRtcUPviMRKrf2zBkUpP3usGFeywkCDg2RxDwaRulpifLBg8yZ8QraOqdYNwdWUPnze4AH5TicG+51jNDJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8207

The TMU has two temperature measurement sites located on the chip. The
probe 0 is located inside of the ANAMIX, while the probe 1 is located near
the ARM core. This has been confirmed by checking with HW design team and
checking RTL code.

So correct the {cpu,soc}-thermal sensor index.

Fixes: 30cdd62dce6b ("arm64: dts: imx8mp: Add thermal zones support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 5d10de3950c3488acc80f574c8c59b55b6fbf575..91e47b1d6902fc22a368511a57522aa7d55ae167 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -298,7 +298,7 @@ thermal-zones {
 		cpu-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-			thermal-sensors = <&tmu 0>;
+			thermal-sensors = <&tmu 1>;
 			trips {
 				cpu_alert0: trip0 {
 					temperature = <85000>;
@@ -331,7 +331,7 @@ map0 {
 		soc-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-			thermal-sensors = <&tmu 1>;
+			thermal-sensors = <&tmu 0>;
 			trips {
 				soc_alert0: trip0 {
 					temperature = <85000>;

---
base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
change-id: 20250905-imx8mp-thermal-08271c5cb5c7

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


