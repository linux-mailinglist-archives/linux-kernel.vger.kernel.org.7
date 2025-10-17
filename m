Return-Path: <linux-kernel+bounces-857164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F9BE611E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E26384ED78E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34BC238C08;
	Fri, 17 Oct 2025 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LXjkzaHz"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B623BD05
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666213; cv=fail; b=kngFzwy+wnM22LAcqzrVRs27XplisApZXC3C/OcEh2QTFKjJ7AohGiQueAs4rsTfHNCS5HX3dmy8yezi2pREjcEUli/v01+0000qG58WxB6CR9U8+hmlIyAPOz7Wtm5SOQFDEsNz/1Vrr46rW8wmvmtQWdQRnv/sIXTphM7/uEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666213; c=relaxed/simple;
	bh=LFknW3gOShXilTrSNabhdfPa1/6xVSeARt/VxjSyF7k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=baLh2GRCEXD3q5JwynoLM4ZV+yTBjAEnGX+N9296OnuMde5kCF+sW0fWpr6hPgyiEE3rwKFo/S5QzuqCOnJEx4nuZwKeD1dHBfrHMfZrgZLomA6C0xnG8CXJtqbz01txIMiaROJE5ZNqGl40OAiy0kr7aSl8xdLfVDN8xbHErHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LXjkzaHz; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1FIgOMKtefD9et3inrbSk87UYJ6G4EdGGWF7yonoCwBpkhElWRJWFcBgY6qMpADTh96pp5ByxZ6DVz3dKh/FtTrjicMwKOjTh16TieBgRquCkvxQpO2URZTDbJX9DweiegpGsC3mKaI/7aztIaKuZRAB53MHUkUOzMSzJl5d2MooQttGITk34yI9tQwLQ3ol1rbGwrvjkCQmsfyNLtmIpBbBhZMOSfoCp8fgol2MHc9NtLIpMraWkclDgP+J5hUY09ai01XAzRyMl7eUjE5M06x26yP9iDw6bGkIU7DotH0Ex3Kt3OzSfF8ZEt+BAt9Glhoy6h5Vdh7iUESTox4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoQNzECjeBwskJBcB448uxtxPgnqe/oweVtk+22q26Q=;
 b=LVQneLWgyRimCMgiObbsHhc+JqPKiahtJHe90aTclYsnpBIbLCfl+pNIcNssNdb8eVhz5VOcRnlRorwqf/qfFitlXUl2dSFe6EFdh+LCY8TCzp8Io3L7b/c6cRsJ80IgAFlNbvomUJ4CEUVvu0Y2Zo1emMXuCcBU04aWexv1q62w5GYi2D7TIWE18NvNDt3OxHc2+DhmI2h84k/xKLNCABxgDOOkEvL3ipyqbnr5vB3A00j122HkdXVnlXm7amSa6UgOUXgiSsmqRcsklTfDr9zHzcT1LT8e6vSUtroYJZT7Wh/ItTL2CGXZ4nnZ5AeblClnMLUUEfvNcAwaax21og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoQNzECjeBwskJBcB448uxtxPgnqe/oweVtk+22q26Q=;
 b=LXjkzaHz80Iv4SZ/On/yTidRrAfmIzlR7X0l95uQhVitbhQs7MTywaHeNV8HEM6oEDgu9bagVkhj0PRowZc8Yl5zaZ/fF+eKcB0jF+QDRrXDykJCJ+w3LUxcyEpTgjJb1nRoPmcbPrQOnmd5ayNiSIy/73leLS13/GZ8MPaP+3JHGFOuvcssBUPOs39ZtR2gfG1S8dFY7POXhTv91LRAr/c4a3zPDy7ybdyjlLMHV/QqaRa9kXslKdryeozgXIJI3j/3xPb5LqCa18xYINQUZYK820Zfcr/UIyp2shsmH4gPTWDNv/2rjtGMuxcAgvdzi+ildo8tEC+kOOsLcbF/Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Fri, 17 Oct
 2025 01:56:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 01:56:50 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 17 Oct 2025 09:56:25 +0800
Subject: [PATCH v2 2/8] firmware: imx: scu-irq: Free mailbox client on
 failure at imx_scu_enable_general_irq_channel()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-imx-firmware-v2-2-b58f68ec2ea9@nxp.com>
References: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
In-Reply-To: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760666195; l=1178;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=LFknW3gOShXilTrSNabhdfPa1/6xVSeARt/VxjSyF7k=;
 b=vqL+evfcSpqaSCzBSa1cPBJ++Ke5e9CQKvgzxq1soa7B5PWBPHwO/BedrObYa08nPlF8aaHub
 UGo0ZZ3/drXCRCpbvWwgrJ9ALLHnJhueZwiEqLNwANTIGRfr+vIi0Fs
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3aee58-50a0-4c5e-992a-08de0d206fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckNBdzF2VE53bDkxaU9qajQ2UnllU2tTcWhEVG4zcUN5NjMwNzVCaVlONVdZ?=
 =?utf-8?B?aGp6aUhHU0FyRzNZVktNUkxqWTh1YWo5OWZQam5lVExrNDBsdmNuMGMxKy9X?=
 =?utf-8?B?ZG5WMHhmdFlsZGJOb3dVS3dpWm5UclUvZ0hJT3JXUURzSnptMHZCYkNYeU1U?=
 =?utf-8?B?ZzRXR2dFYTV1R2N1THZBYXM2WktLWUJsOFIzd3FsdGFxK25pc2lqVUltdGp2?=
 =?utf-8?B?VWtOVysvRHorNnJCTklDNzBub08yNllNNGZ6V3pNaVR5OTFBTHBpVjI2Mi8v?=
 =?utf-8?B?alhSS1Nxa2d0bmV6RGFvL0NjbW5IZTl6KzZWc25UUEF0ZjJsMWNlamdUTVd1?=
 =?utf-8?B?Y3NZV2RjNXRuZVZSZzhHYTZMZlF6YmtYaURiZUpLMEZvU0RaQ3l4VVRZT3A3?=
 =?utf-8?B?OGdBQkpEaU1qR2ZUdmsxLytvRmhDWnhpSkZWTFBVZmsxeDhHMGovQmtlME5C?=
 =?utf-8?B?ZHFHeWZVdDhubUlhanhkVHdFbTk1YWVubHdCbFQ3NFFIOHc1bEZCWC9vYmVr?=
 =?utf-8?B?L1I2dTQ5K2NWTGdqWTFuang3RUt4Qk5KZXo5WjJKRndOSnRhc2ZUNjJxK1pJ?=
 =?utf-8?B?MjJLUjBicSt1bk9IZ2lNVjhiN2FJR1NaMTRTSThBc21DRENUTnZSRWdKMGN1?=
 =?utf-8?B?dUJ0YjdKREZFejgwTmVrTm5HYWNxaWFFcE81eWFqTFMxeE1tRUloZG9zWFZh?=
 =?utf-8?B?a1lGdm5OcVNueVd1cEp1ZHpIcG91dUY5VDZQY2VGb3BaeEVnRFJVNURwc3Zn?=
 =?utf-8?B?TXoxYTkvcE9TWnJ4ZFNkWWxINDhoWGhuTW5pWjFkanB0QW9TZTZSaHcxTThq?=
 =?utf-8?B?R2ZzN05wNWFlVnNUR2RJa3pHRHl1M29HYmtmSnZNa3lSRlBON29nNzMrL0tR?=
 =?utf-8?B?aVJSdEw2NFpLVjNROFgvME9LUlNZb3QrS24yL2Q3TCtWb0JSRlMrQXZZM3h0?=
 =?utf-8?B?emt2RkJGNWFQN0o5WTZ3S0dtcmVJSllEOXl6Y1I2WC9SbHpURXRUMFA0UDhj?=
 =?utf-8?B?YlB2eDhnK0hWNzdIVlpqemc5UkQ0WlBScDJvQ0RwVGI4QTBDZk5vQkRzVStv?=
 =?utf-8?B?eE4rbkZXU25Sc2FGaGU4THArTXVtODRwWmp4K2NaekJtWVBNOFFKOEZQcDFU?=
 =?utf-8?B?MzRRaUZmOG14SGROdUhrV1BibmVxaFQ0UWdiQy8vNFpMaEE3eWtuZG1oWHcz?=
 =?utf-8?B?WW1kc0VRRHBPcDE0dTdBNTNDamtwcWlmanNHN0REVG55NWVWQnhaRnVRVDJP?=
 =?utf-8?B?NEx1aC9TY3FQdDFsYUtrUVRDdGxmeVBWa1ZoNWc3ZEtWbWp3K1lHRGNGNFJQ?=
 =?utf-8?B?VEE2SnQrVlYwNEQ5U1k4ampUUUo3d2hJaVZyTW4vTWRiaVplNlhjU0Rxclph?=
 =?utf-8?B?QW9LQTRRbVc5eFdHcTMwVXBnTXcvSEZDZkFaR2hqNWpGb1pPdkdHNThGc2Fk?=
 =?utf-8?B?NmZYZEh5bzM0MXFNYXpQZ2hua01uTW95K0wrbmgzcDlQd1ArTG9kRTZDa3My?=
 =?utf-8?B?SjRCMDJiRE9CVVpQTjdQZXZTMXc1MnRRa3VLbnd3bzhJZDc2RDJpYW9DeUhQ?=
 =?utf-8?B?Q3c1UkdEb0xRUnJJSExNNGpVTW9wV1pISjQxaExzSUUwVUdBNHQ0MTl0VFU5?=
 =?utf-8?B?cmovUnMza3lUb2haR0R0eUlTd0p4UGpodlJqZ0tuUVZiUXpIVU5Wanc2VXdB?=
 =?utf-8?B?Mk90WkxvdlYvZlJ1VEQrR0JKWldic2ZFc0o4Z2xQL2V3UHNBNk9aeU9RNTNJ?=
 =?utf-8?B?bzJFbmplWnA2UU9DN01zMWZtTlJEekxrQmVKKzR5RnlSekhhRnJBY2FHWVpi?=
 =?utf-8?B?bGtSdzJpbFp0Z1FUNkZ5ZDkrc05aN1g3bzZsMytDN3ZtNUQ0Q0FVQmwvVVdu?=
 =?utf-8?B?MmR2SFpjWnA1aTBDVUc1dUNxbjBQZHBRMDh5ODRyY2hTQUJQWFlWUXl1VU9n?=
 =?utf-8?B?NHJWeEVmMk1jUFJJN2hmSTg0Z0NneFZnNTlnNmZaaGdGaGQra0VJb1JjZS9l?=
 =?utf-8?B?emphODFFNGJReCs2ZjA2bnJVcE0zN200OFpyaWJKZzNadFFKVzFKNXpEZFpm?=
 =?utf-8?Q?3xUm8X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVpkN3F1c1RrOVlaMUpGZmh2bWVNWGd5NG9QRG9QeUNJa0RnR2hoenp1UlNG?=
 =?utf-8?B?K3Jxbk9Tc0EzQ2Z1Um5vaHB4Rzl5L2o2YlByK2R0Z3U0SFlKZk55L0RxWXlr?=
 =?utf-8?B?cEhydW5XeHc5VjBmWTRTTXo2OG80T1FGZXAyS0dUeVV2UWNwL1Z6M2xuSVNI?=
 =?utf-8?B?SkJ3OGZPb1NsM2pVK1V4U1NnRGRPSGpDdnVqRUltQkxmSUpGUm5oOElhenBu?=
 =?utf-8?B?RWRBYWR5K2I4dk0wdUpZZmMvS3R0d09hb094dVMza01Da2gwYytmWForQ3kz?=
 =?utf-8?B?NnloWXI4amhvcm9OenhwSVRLZXkxNnl3N3dUa1BRS2hWMFhOZ09tTXp4TnhQ?=
 =?utf-8?B?K0UrVC91VmJPb1dHR2RhRUdrSjRuVUt6VWNrVkNjVnNLeXdvMWk1VnBLcFVj?=
 =?utf-8?B?R3ZUSXdrRVBGbHpHM3d1N3l6Z0dPYWdtWVRQN2J3QU1SNUJWUmVHbzJxbVpY?=
 =?utf-8?B?akZCSXVqck54QTR6ZG1zSnhhZ2VRdnlJZWhzckwzbmhabEl0UE83VXczQXhV?=
 =?utf-8?B?Tlc2VUpydE0rbDlkWTNSYkF1OTYyUXZsU1d0VkVIeGg2bFhNeGc1dEFFOGRa?=
 =?utf-8?B?b2NqdmI0ZE93TEFrTzRjSVVsWS9ZYmxBNWNWUUEwNDlxREJwOVdRc0pIem5I?=
 =?utf-8?B?N3lQU01KTW12RGkxNXcrRDR0bytBTnBiZEpwVVdvWEdoUnpHTjVlL3RCRUMy?=
 =?utf-8?B?aDVJdlRSQWFQMC81ZHB4RGl2UFZabVM0OCtYcjIwdUtsdml5WmtINmlyNFQx?=
 =?utf-8?B?U3RLWmJxaWJ2SktVcVlrMHFidUFPaHYyQnprVnhKc1VreHhTUWY5bFlEOXZS?=
 =?utf-8?B?UHJzSVduNU52RkN1YmljUitnaXo5RkJ3VENlNnZ2RnhINjQrQ25aajMyU0VT?=
 =?utf-8?B?VGd2TDQ0c3ZzZExMNXJwb3Fic3RvT3N3MnhOZGRyLy9PQlNUcGUyd1NTSzJO?=
 =?utf-8?B?c2Izc2xFWmVLVWxUdk1lZ2MrNXJNelBqcjhsamtEck5BMnJRYklYT0FET2lT?=
 =?utf-8?B?a0VQenh5a1h1bUR1T1RLT1BpQzgreDZnTjVMTU5BQmlsTEg4elk0aTNqVVNl?=
 =?utf-8?B?aGxPN0Zldy9UL1psTldJUm5KZk1MODVoSExpbEFZTTZRd1ZVT05LeHVISEor?=
 =?utf-8?B?Y2pNeTR0Znl1bGJvd1JvWElyWG9lcjRpTzNyQlY3VGFQUWdFN1dJSDNsQllY?=
 =?utf-8?B?ZlkxZ3RqL3c0REpSQm52WmplWGQrRllpTEM2dW96NmhucWxkTmFWVUgxbDhB?=
 =?utf-8?B?UHp1VDQvbEhQVEE3aXpYTmZKUjE0QWJpV1JrQ2dKTVdrMDczL2JrR3FZTEND?=
 =?utf-8?B?dEJBblZLUllreHlpdURON0dCenNvMVZnMTBYY2VJV1hSNVFPclkwSGVyZElN?=
 =?utf-8?B?UG1UdUIxdUNMRzZEUjU0VmNIWWIraEc5MlVQRGI0bUExT1hJWDd6aXF5dmV1?=
 =?utf-8?B?ZTVZL3AwWXhOcnJUb2dHQWVzdmNsUHBPeG9iUndja0ZWd0pESStNTDUzbTkr?=
 =?utf-8?B?VDhYNzJuZzRpRTJRRGVrNGMwWGZlaTR3T2djMFBJQmM1cExZTGRYQjJwcTJq?=
 =?utf-8?B?NU5admR0ZFN2TklhMitxYk1HeXdBMEtleDRld09LRUVDME0ycWFwT0E5VU54?=
 =?utf-8?B?OVJ3REFuUGVrdk5UYU80ekt0dTdEZGg0clpJcjdzY1FCSVA3SFI0UHN4Q1U4?=
 =?utf-8?B?U3g1U2hOcWpqRWFFdmhwRit5djR4VlBtQXBoL0t6Yit6RkJyZTRGdm5WR05J?=
 =?utf-8?B?QkEvcysxUG5OVHJWdklFYzJnTGt3TnJsVlRqWjlqdTdIU0pGQ3lXZGVWN0Fh?=
 =?utf-8?B?ZEt4ZXI2SEtUS0tMQTQwWkUzdm15TXBBSkVydDhsSSs2V2p6UEpUQkNiVENu?=
 =?utf-8?B?bXhXKzRyMzN4WXg0M0h4dG5mR2puWWk4U2V1bytVQXIxUE52M0ttS1IvKy9z?=
 =?utf-8?B?ZFhjU0xPZFdzc29zb0NzMDVtQ1BxUmtHMU95YUhmVDNYV01jd0YzbFpuYndq?=
 =?utf-8?B?dW9QWE1XZXcvVnJzOHROZXBqYUozdHJWdWE1SGNDT0NWQjAvcW5iSjVuUGpN?=
 =?utf-8?B?dmtxcHFxdDBDMWh3UUVOTW11bHpnOUNCT0pNU1h5b09MbG9kTTZDeGs0RVds?=
 =?utf-8?Q?1LAKRsRC41OJd6ykUhYE6S61U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3aee58-50a0-4c5e-992a-08de0d206fc7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 01:56:50.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWPTy7YawNflzLOaxcK2xj2Ng2ysbrT4wT5gz+/eVhmpVeR1qd5IXHGK3uN5IUfH/u/6Nvj6tnhBfes7QzpwQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

The IRQ mailbox is an optional channel and does not need to be kept until
driver removal when an error occurs. Free the allocated memory in the
error path.

Add 'goto free_cl' when mbox_request_channel_byname() fails, to keep free
at one place.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index f2b902e95b738fae90af9cbe54da4f488219906f..d6fd04404e2a3113a6d22b1a580e6c0ac48f5975 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -219,8 +219,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 	if (IS_ERR(ch)) {
 		ret = PTR_ERR(ch);
 		dev_err(dev, "failed to request mbox chan gip3, ret %d\n", ret);
-		devm_kfree(dev, cl);
-		return ret;
+		goto free_cl;
 	}
 
 	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
@@ -255,6 +254,8 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 
 free_ch:
 	mbox_free_channel(ch);
+free_cl:
+	devm_kfree(dev, cl);
 
 	return ret;
 }

-- 
2.37.1


