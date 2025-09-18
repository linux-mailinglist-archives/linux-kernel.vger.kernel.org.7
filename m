Return-Path: <linux-kernel+bounces-822153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A1FB832C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C10C4A344F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860042DA744;
	Thu, 18 Sep 2025 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lcwG92qZ"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5307A2D7DE9;
	Thu, 18 Sep 2025 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177608; cv=fail; b=bxKQ7ltWpDUVWSpPyEYgV9vBv8EPFPB8wHpfQY1K2H+36+EnGxZHCIYGzPorvQ0L+6qShnEUxZu34Zygp3fq8riMZw8PjWTlpch+fcsnZUoYxSLaaHVB21RH+lIabbWjGts2Oot924cTnYtuL+vkiiwtaPZnSKhh5FqpJRWzv+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177608; c=relaxed/simple;
	bh=Tfp5zLYpQ1WfGSR/mIWLtn5trwZztlkghhszHhMomvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H5S6cqcoyHBhPRwrxRTZSXQRw1OAbkouE7vc3hliHj1j7G25Y8ad/ZPsgeSjuUwPyBS9dqEh3WGdTZYEgBAg2tvPnumvERxJmtvXWGfaGzKFi7Sa7whXyR76wbFtOrIl3jZy5UVAwAB5VvvaJaIosq/o8h7t0quj0Bf8HnjhgbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lcwG92qZ; arc=fail smtp.client-ip=40.93.194.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK6dJHq5Cc41d7PsVAf6zC0Spo/3T1pVfebNtJP/Es3SZXp9CUsJnP28w6kDCj0NgppQZqa/onCf3VHIrtdH0CAv3LY0AxWYVbcBDIoxfFI8QtKU4FWHubEMLDK/1OKRKmBxM3Ya0GTFauGCMQUWYtvD2iw6RHH2XN+B1jUBiXBPEPYO/ohaDtLtWnhh0een6sqo68tPJ6WlXOWEtgpMJzyzEHxcV/Diy310yH4BOPBRY/aL5SZNePmtn7ddQNTxvjEBBsF29m1iclGuWhs+k06qwzKp+cBLGiN9Nn0QFqMzhkb1mai2OfKL2gw2xQi4ASo0ebybrNAR+XP7ho8Q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tfp5zLYpQ1WfGSR/mIWLtn5trwZztlkghhszHhMomvQ=;
 b=svYfCK/2wD4ZzFxvwrZoO/bUY8UPR4QrJYCZcqtro5L9WhfbhI7Z6j5/lpsh/GmF8KGp17uFaAbNM2g4rvsjHVfQYdNxTQQmV6OpENEuH7+iV/WxXqgdtOQsWAmvekeQzZlQTq6bgStnOOM9ywy33hmQ3R50OYbPBILcO6hKxBdyXVHpt8filM8RjvRGOeuiwXIL5KEqAa/Vlhm2c/AhYX4BDDTjCzJiq/vIKIjz8ao0Iilu3pYEuKetMX7AbrE2GK+ZSYUPOyY/MEzedVIcSwJGNL8C4qJCkL560i+3EQ2jrb+SS3ryCKwjzNoRNcph7n6QxPRvUHVC/hnK3qu5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tfp5zLYpQ1WfGSR/mIWLtn5trwZztlkghhszHhMomvQ=;
 b=lcwG92qZaEsiWd6f/H3a3C8nULz9AJzfMLljnmVLB3KhqCQOugZzDMvdbcA7eh12IcMWwyRtx+6umJDfGEToFrhII0TNR9dcqGzFmteEKBrsF8qHo5iReDKYC4uUyfBmJRgb93ta8QsPOhFrPp4x7CT63Il4yH3vrFnXbw2oPlCDBwEm/g5D4OOzHqLlESa5pKQHLDLhgDZaNfW5AakJSQN0myxISVDPPx8JbCviqZTWZA5C7Tfwt/7zDJxPbANI/tb7lSIdFmCmdiwYgQqsE1DetMX1aX6LIunbjZo5dIMkwd3hdLquQVa/or/cP7y5L4V+jJw66VRQ27SulRx0XA==
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Thu, 18 Sep 2025 06:40:00 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347%6]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 06:40:00 +0000
From: <Durai.ManickamKR@microchip.com>
To: <jarkko.nikula@linux.intel.com>, <Frank.li@nxp.com>,
	<wsa+renesas@sang-engineering.com>
CC: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Balamanikandan.Gunasundar@microchip.com>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 2/4] i3c: master: add Microchip SAMA7D65 I3C HCI master
 driver
Thread-Topic: [PATCH 2/4] i3c: master: add Microchip SAMA7D65 I3C HCI master
 driver
Thread-Index: AQHcIXrqGVMOWFOs9UayQYE6vyTQPbSLW8GAgACVJwCAAC8WgIAMayeA
Date: Thu, 18 Sep 2025 06:40:00 +0000
Message-ID: <1a5dc012-eec2-40c5-90ea-bbff1ff713cd@microchip.com>
References: <20250909111333.170016-1-durai.manickamkr@microchip.com>
 <20250909111333.170016-3-durai.manickamkr@microchip.com>
 <aMCZw2v8Ey6aGbqk@lizhi-Precision-Tower-5810>
 <3229da67-9d67-47ff-9f01-0d71bfabb6a6@microchip.com>
 <c25bf384-a312-47a9-a27a-a943cbd33050@linux.intel.com>
In-Reply-To: <c25bf384-a312-47a9-a27a-a943cbd33050@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6541:EE_|CH0PR11MB5219:EE_
x-ms-office365-filtering-correlation-id: 4cec62e2-875c-4682-57e6-08ddf67e30db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SllQaWUwdldRbUhiT1VBQzRDeWw0MGlXYzd1QzRuZmJpL0hsbFZZUXJIQ1Jt?=
 =?utf-8?B?WTVSK0FTYXFXUzFlbFVhY05yeFRydnoyeURRajNhQ2NPQ1lIZU5kcDZ5L0tk?=
 =?utf-8?B?MGJFNm1iWWdMcjBlTWQyVDFmUm8zdkRwWThUOFlkVzFOUzBzQzdvb1M1QkRX?=
 =?utf-8?B?WFdFK0kweVdVeFMrNGNqa1JWS2dmRllNZ1dObWZoR1o3cDMzcjBZMHh0WktI?=
 =?utf-8?B?Qm14VS9DL3NEakpVZW16TG9MOXNVUjNta21mMzdRUVZyc011aXRBMWFJUnBw?=
 =?utf-8?B?L2Q0MWVWRThueXNtV0ZtbHp3d3ArMUpQWHNCUlgrTk1qb2I5UlpEeCt2Zk9n?=
 =?utf-8?B?T1hoOVdraTJRTjV5Q3EzSzhCVkNtOEU5cFdXcnRwR09aQ2Zsa0Q4aVo5ZHVW?=
 =?utf-8?B?SEc4RkdzZ0tNWlFncUNhUzFieHN6YzBoSjU0ZkdURTBVaDVKK212K3JGc0tW?=
 =?utf-8?B?Yk91M0MxTWJDUy9wcGlIdXFkejhkWE5LVUord2Vjb3c1Qm1FajlXTzVOWG9H?=
 =?utf-8?B?cmtRQW9leGc1aDNYQnYyNmMyOVBvV1FpVk9FcnJpMW9oQUxTV1Y5emdmM0FN?=
 =?utf-8?B?WHlrTXl0MFI1YkxCM0xjTGRXcnpPaS9ZeXV1bnBmWUlIcVBFSEIzbE52c0xn?=
 =?utf-8?B?RTdCeEtWSG9pV1Vza2NtZld4TGVSZE00emdQNCtoaGVJNUFGdVU2TVFhMHll?=
 =?utf-8?B?RnU2UW9oaWJJKzdMbExVK3diWEZtRWZZcE5xYWZ5RWVtU1NsQTFIVVdiRXJl?=
 =?utf-8?B?KzJLTTJ0WXdRTWZCL1FwUm1KdVgrS2ZhR2JTSENvZk40cXM4WmllZFFiMisy?=
 =?utf-8?B?anJKMEEyK0g5enVpdk90ZC9HK3BScytZRVlCejh2Q01od2Y3SlB3RzdZVlV5?=
 =?utf-8?B?bnB2Z1ZGNTJOYlMrSGw1QzlBUjFldkVSY1JjdjV4T3hUa09RQUpDUUNaSmZr?=
 =?utf-8?B?L2gyK1FxN1d4S2kySDhqejErVmpMR1lrdEI4MUhlV1JSNlpqU1FITXN3bXdZ?=
 =?utf-8?B?NHkrOHFUVXlWaVR3blUxL05xOC9xSFRpbW5vZzZseGtMbkNtQ2ZDcE1wdk1N?=
 =?utf-8?B?ZTgvYUQzUVlVL0NiM1NlSGxCSzFPa3NkYjkycnFlaFNOMlN4UVZKVUFMcmFL?=
 =?utf-8?B?d0l2cDRGbVF0YVVzSyt1ZkpxeWVNZjA5anVtWXdDQkphR0d3cnArMHhFN3lV?=
 =?utf-8?B?N2wyeFRPTElkSi9OV0I2R25vcndLS1AyS3UwTHBRekRwS1pleVhqUTNWUFZX?=
 =?utf-8?B?WUVFVk5iQmpsVGF2RWthWVAzRFVlbmIyUHlhTlhrVnBxVUxUZVhtL01ZK3N4?=
 =?utf-8?B?bFFaS2htaEJubnlTWTQ3RzZLZWx1L1lJdk0zYlRueTRqelIra3FveG1QdTdE?=
 =?utf-8?B?TFVuUm5HOW8zemR0VEp1K0xRc0UzQ3gzU2FYeThjdUNCT3ZPeEZic2FBQkFk?=
 =?utf-8?B?YS9OaVhaWkxNait5TXpzMC9qWFlPd0t5b3c3bWdGTld2QmpjVkVPOWdHQ3p2?=
 =?utf-8?B?U05aTFdTQUhDWDhHNWpaeHIrZUZObVRmNnNDR2JueHBpcCtXakpyUUJkeGNk?=
 =?utf-8?B?REY5NWgvRysxb0M5aGpERE5Ua2YwU3V2ZUptQ0hLTExNNXE0ckUvRTIzVXZ3?=
 =?utf-8?B?RGlpTDRaNmdYQk0vWlpodEpEYTVRLzdhWUVTb3FNTkpRNnJtaTN2blJUZC9j?=
 =?utf-8?B?dmNIRnFuVUVpY2JLRFFjVGZObTkyOFBiWlRlbTk4Y0dkYTlpVmtQdkFtbWho?=
 =?utf-8?B?THkwS01xV2hzRkUvdVlwZ1hWQk04cUZyeFR0bkFKZEN6cWhqajlhU091cTNY?=
 =?utf-8?B?VEpNcGl3TGd2bkJnSHRDejNlVzU2VE9mWHRGSHVGZTZPd2JKYjY5ZS9xN0Zn?=
 =?utf-8?B?a0NxelhHQnFkS2xJQ2NZZkJMTGRRSmp2VGtaTHI2Z0IzaG9Md0hOM0NGamRD?=
 =?utf-8?B?eHFxQlFlOG9CUkNuSysxM0tqV3plOGd2TFBFcTllT0ljVGxXMnYyT0hTVE1p?=
 =?utf-8?B?ZFpsRW5SREdRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1Z0cjV5SmMwZVJmSGZrTjJkcEV6RXJUN1dsVEZOLzBPV2xjL1IxQjhkVlhl?=
 =?utf-8?B?WmtGMG5UY0djSHpHNFoxbEdraXI1OXd3ZFBHSS9BSEF5T0pKSFpyQWN4ZGMr?=
 =?utf-8?B?dHA3SGp3VW5IQkordHpHNFVtN2wzNi9JakNwcnFJTlFRUUxNYkJTNkV2OUMw?=
 =?utf-8?B?YURlNmR5RXMvODJqZWJFNHF0aUVjcUhMRWs4WHNoa0RnWFZOSjdKempiYnBP?=
 =?utf-8?B?NklMRkFtVmszRWlYL09hREJ4STg5cGJ3MFVRTFh3U0tkV215dmVJMlN6VEtx?=
 =?utf-8?B?Z3pvM1BHNUlNUnlEYmd3SkFSdFZzV3hBK1BOY1F1SmNQRUptOEN2cFBWWVJY?=
 =?utf-8?B?TUR1UC9JcTBLRlVSa3dva1l0WVRWQWp4WlZNR1d5bGdxR2dxb29TeWhpejdP?=
 =?utf-8?B?MjA2UEdGY3BSZlZzdEY0ZUNpeTBsbUlxZlE3QjlSenNmU2dWc2J2SVJBVFk1?=
 =?utf-8?B?UHJ0bVhrMEF5cEZHVi9uYlBGTnA4L0VlN0NneTdnSE9wYlJSZ09pRVhqUkcv?=
 =?utf-8?B?NDgydWI5YVdsMDEwL2ZNVThOQzZnM2YyU2tQYnFZc1BPdkJ4RzVoQys4Z20x?=
 =?utf-8?B?QStHNk9YOXIzTkQ0a3RQaHRxZjE4UEdyaUVxVUpEK1RkWXIrelFXaURWYVZv?=
 =?utf-8?B?WW5HTm9vVzNZeWJ5VU5qQWdiNXVaYUtIL1poc25XTjJoUzd1aUg5NWtlaGRa?=
 =?utf-8?B?SUdrZnFPdDg1aTIvNXpwYVh0YWVDWTdTVSs4UFFrdE81bGEzOS8wbHBnVms4?=
 =?utf-8?B?S2pIMGM0UXB4ZkYyeFVxcEozSmw5clVZeEVMUDFFUUMrQ1FqN1Irdk9uRFJm?=
 =?utf-8?B?U0t0eTU0bzMvVkVKWlg2Ky9pVHJUazBrd09VY29QUW03U0pYYTkzOGdIUXhF?=
 =?utf-8?B?K1htZkZhenZxRW5UcEZwWEhOOGo1MDBUa0hydkJ0SHZsVWJRV0g5VXJZZEwz?=
 =?utf-8?B?VDZJaXJ1MVIrMUlrSkpxcjZEYytyR29nemwvbDFRd0VGdkIwVllkeXZUQkRr?=
 =?utf-8?B?ZVI5VUJqUzlxOWNJQmVXRnpXbVZFWTJ2N0o4L1VoMXpma0ZmT1NoVUYvV0Q5?=
 =?utf-8?B?NWRGb3hHTWRxMy83ZmxZOWVSTG9sMHA3SGU3aXQ5OVhrUnBtcVFQcEJyUFZl?=
 =?utf-8?B?YVMrcEM0V0hzNHNkVnV2dlVnbWpSc0ZVc2tSMDJYRURCMXlrZlhEZzZ4SU9t?=
 =?utf-8?B?c3NWMlJOM0hpYUxaTVZseCtYMTdUWHFBaUdSdlgyY05CS3FMVHp0bXRBM0Mx?=
 =?utf-8?B?UThyMGE3elNFbUFIYWhyL1Z3aC9mWHYwdUVFaTJzZ1YyalUwaTdBUGtNblZT?=
 =?utf-8?B?K0Y3SXBzZEYxN2VYQlE5MVVoRHJpNDV5OXZmc3lTcXhiYWZ3TkdBcHUwZ0Yr?=
 =?utf-8?B?cnIzb0Rua1I3N3RvUHdJaHRLemZLZlg0d3A3UCs2a09sQkxPMVB4TTArNlh6?=
 =?utf-8?B?WC9mZnljbVQ2dG9tcWE2Z0J1YmlISlM1cHFWd0MvVDA0SjdGYjVOeVhsalU5?=
 =?utf-8?B?R01ZR1hpQUpsRi9qV0ZZY3RSWkJFMjM2Zmc4a2VMdjdsdEZ2dkpHUUdwRDB3?=
 =?utf-8?B?VVZORmdhSGRna1N0VkxpazlUbWlxbWcvTlVoT2NQODVwZWZubFhJUUxObCs2?=
 =?utf-8?B?Um5mZDZTU01CWHVPbzZjeE1iRlU2UmFJTVpDamNoTElsZk5jK2pBZnp0VUEv?=
 =?utf-8?B?L2JlZmFNTU1lT3dDa3l1dlBvU3dQQklFVkgvell4Y1pqMlEvRXgrcXBnMGFP?=
 =?utf-8?B?RHU4SlIxVEpEa1c4UDVhTEQxcEc5ZE5YaG80SnpDSHJWdWpmWVVLbTBKZE9m?=
 =?utf-8?B?S21rV3QvRjFIMXJMSEFGT2I0bmZFQ0hlTkEvWWR5cTZpMSthWFVsQzBQWU51?=
 =?utf-8?B?Mm0xZGxiekRoYzlWTi9GNTJkdEx2eElNMW5aeXBTbkxiLzVCY1V1amZVS0h6?=
 =?utf-8?B?SzB0V3VBNGxTQ3ZmZWFKNWhvMElIeGR6Mk96Qzk1dzREQUFDTVdhVkNFNERK?=
 =?utf-8?B?NktYZUNTbVhXcHIxbEpQSFQyNUt0MVJKK2dpNnV0N2lKekJZK0x5Y1hMdjVk?=
 =?utf-8?B?cUYrNHQrREhNRUFHMUIyazBlM0taWExUbXo5Wk1CL29aazgydDJFRGJPRFc0?=
 =?utf-8?B?WDJsNDZBVWFDZDJmQ2ZCLzg0MGdFcnR1eENBMWF2VGFkbHRJUnkzS2lrc3Bk?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1810102C3E846143ACC5236AB473C9BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cec62e2-875c-4682-57e6-08ddf67e30db
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 06:40:00.2003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdsOC9aqU8wD7AF/Lufl0TKX1JhcujPt4oln94T2QVnuHTcEYhcrp0zGkrFxP8zhPQ6E/+LcRwa2vNzWT4IHzCysmt9Ra8b+Rxwumu7Y/yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219

SGkgSmFya2tvLCBDb25vciwgRnJhbmsgJiBXb2xmcmFtLA0KDQogRnJvbSB0aGUgY29tbWVudHMg
SSByZWNlaXZlZCBmcm9tIHlvdSBhbGwsIEkgZ290IGNsYXJpdHkgbGlrZSBpIHNob3VsZCANCmlu
dGVncmF0ZSB0aGUgSTNDIGNoYW5nZXMgc3BlY2lmaWMgdG8gb3VyIFNvQyBpbiB0aGUgZXhpc3Rp
bmcgDQptaXBpLWkzYy1oY2kgZHJpdmVyIGJ5IHVzaW5nIHF1aXJrIG9yIHNvbWUgYm9hcmQgc3Bl
Y2lmaWMga2VybmVsIGNvbmZpZy4gDQpJIHdpbGwgcmVzZW5kIHRoZSBwYXRjaCB0byBtYWlsaW5n
IGxpc3Qgd2l0aCB0aGlzIGFwcHJvYWNoIGluIHNob3J0IGZvciANCnRoZSByZXZpZXcuIFRoYW5r
cyBmb3IgdGhlIHN1cHBvcnQuDQoNCk9uIDEwLzA5LzI1IDE0OjMxLCBKYXJra28gTmlrdWxhIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IA0KPiB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IEhpDQo+
DQo+IE9uIDkvMTAvMjUgOToxMiBBTSwgRHVyYWkuTWFuaWNrYW1LUkBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPj4gT24gMTAvMDkvMjUgMDI6NDgsIEZyYW5rIExpIHdyb3RlOg0KPj4+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IA0KPj4+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gVHVlLCBTZXAgMDks
IDIwMjUgYXQgMDQ6NDM6MzFQTSArMDUzMCwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+Pj4+
IEFkZCBzdXBwb3J0IGZvciBtaWNyb2NoaXAgU0FNQTdENjUgSTNDIEhDSSBtYXN0ZXIgb25seSBJ
UC4gVGhpcw0KPj4+PiBoYXJkd2FyZSBpcyBhbiBpbnN0YW5jZSBvZiB0aGUgTUlQSSBJM0MgSENJ
IENvbnRyb2xsZXIgaW1wbGVtZW50aW5nDQo+Pj4+IHZlcnNpb24gMS4wIHNwZWNpZmljYXRpb24u
IFRoaXMgZHJpdmVyIGFkZHMgcGxhdGZvcm0tc3BlY2lmaWMNCj4+Pj4gc3VwcG9ydCBmb3IgU0FN
QTdENjUgU29DLg0KPj4NCj4+IEhpIEZyYW5rLA0KPj4NCj4+IFdlIGhhdmUgaW50ZWdyYXRlZCB0
aGUgSTNDIEhDSSBJUCBmcm9tIHN5bm9wc3lzLiBCdXQgdGhlIElQIHdoaWNoIHdlDQo+PiBpbnRl
Z3JhdGVkIGludG8gb3VyIFNBTUE3RDY1IFNvQyBkb2VzIG5vdCBzdXBwb3J0IERNQSBmZWF0dXJl
LCBFbmRpYW5lc3MNCj4+IGNoZWNrIGFuZCBmZXcgb3RoZXIgaW50ZXJydXB0IHN0YXR1cy4gU28g
d2UgaGF2ZSB0byBpbnRyb2R1Y2UgYQ0KPj4gbWljcm9jaGlwIFNvQyBzcGVjaWZpYyBtYWNybyB0
byBtb2RpZnkgdGhpcyBkcml2ZXIuIFNvIHdlIGhhdmUgYmVsb3cgMg0KPj4gYXBwcm9hY2hlcywN
Cj4+DQo+IEknZCB0cnkgdG8gYXZvaWQgY3JlYXRpbmcgYSBjb3B5IGRyaXZlciBmb3IgdGhlIHNh
bWUgYmFzZSBJUCBhcyBtdWNoIGFzDQo+IHBvc3NpYmxlLg0KPg0KPiBNSVBJIEkzQyBIQ0kgZHJp
dmVyIHN1cHBvcnRzIGJvdGggUElPIGFuZCBETUEuIE5vdCBzdXJlIGFyZSB0aGVyZQ0KPiBpbXBs
ZW1lbnRhdGlvbnMgd2hlcmUgSVAgaXMgc3ludGhlemllZCB0byBzdXBwb3J0IGJvdGggYnV0IGZv
ciBleGFtcGxlDQo+IEFNRCBwbGF0Zm9ybSB3aXRoIEFDUEkgSUQgQU1ESTUwMTcgaXMgUElPIG9u
bHkgYW5kIEludGVsIGlzIERNQSBvbmx5Lg0KPg0KPiBJIGhhdmUgdHdvIGNvbmNyZXRlIGV4YW1w
bGVzIGJlbG93IHNob3dpbmcgaG93IGRpZmZpY3VsdCBpcyB0byBrZWVwIHN5bmMNCj4gY2hhbmdl
cyBhbmQgb25lIHNpZGVub3RlIGFib3V0IHVubmVlZGVkIGNvZGUgZm9yIHlvdXIgSFcuDQo+DQo+
Pj4+ICtzdGF0aWMgdm9pZCBtY2hwX2hjaV9kYXRfdjFfc2V0X2R5bmFtaWNfYWRkcihzdHJ1Y3Qg
bWNocF9pM2NfaGNpIA0KPj4+PiAqaGNpLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVu
c2lnbmVkIGludCBkYXRfaWR4LCB1OCANCj4+Pj4gYWRkcmVzcykNCj4+Pj4gK3sNCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHUzMiBkYXRfdzA7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGRh
dF93MCA9IGRhdF93MF9yZWFkKGRhdF9pZHgpOw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgZGF0X3cw
ICY9IH4oREFUXzBfRFlOQU1JQ19BRERSRVNTIHwgREFUXzBfRFlOQUREUl9QQVJJVFkpOw0KPj4+
PiArwqDCoMKgwqDCoMKgwqAgZGF0X3cwIHw9IEZJRUxEX1BSRVAoREFUXzBfRFlOQU1JQ19BRERS
RVNTLCBhZGRyZXNzKSB8DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IChkeW5hZGRyX3Bhcml0eShhZGRyZXNzKSA/IERBVF8wX0RZTkFERFJfUEFSSVRZIA0KPj4+PiA6
IDApOw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgZGF0X3cwX3dyaXRlKGRhdF9pZHgsIGRhdF93MCk7
DQo+Pj4+ICt9DQo+DQo+IFRoaXMgY29kZSBjYWxjdWxhdGVzIHRoZSBwYXJpdHkgd3JvbmcuIFNl
ZSBjb21taXQgZTU1OTA1YTNmMzNjICgiaTNjOg0KPiBtaXBpLWkzYy1oY2k6IHVzZSBwYXJpdHk4
IGhlbHBlciBpbnN0ZWFkIG9mIG9wZW4gY29kaW5nIGl0IikuDQo+DQo+IElmIEkgcmVjYWxsIGNv
cnJlY3RseSB0aGlzIGJlY29tZXMgdmlzaWJsZSB3aXRoIHRoZSAzcmQgb3IgNHRoIGRldmljZSBv
bg0KPiB0aGUgYnVzIGFuZCB0aGVyZWZvcmUgd2FzIGZvciBsb25nIHVubm90aWNlZC4NCj4NCj4+
Pj4gK3N0YXRpYyBpbnQgbWNocF9pM2NfaGNpX2FsbG9jX3NhZmVfeGZlcl9idWYoc3RydWN0IG1j
aHBfaTNjX2hjaSAqaGNpLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWNocF9oY2lfeGZl
ciAqeGZlcikNCj4+Pj4gK3sNCj4+Pj4gK8KgwqDCoMKgIGlmIChoY2ktPmlvID09ICZtY2hwX21p
cGlfaTNjX2hjaV9waW8gfHwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgeGZlci0+ZGF0YSA9PSBO
VUxMIHx8ICFpc192bWFsbG9jX2FkZHIoeGZlci0+ZGF0YSkpDQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+Pj4+ICvCoMKgwqDCoCBpZiAoeGZlci0+cm53KQ0KPj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhmZXItPmJvdW5jZV9idWYgPSBremFsbG9jKHhm
ZXItPmRhdGFfbGVuLCBHRlBfS0VSTkVMKTsNCj4+Pj4gK8KgwqDCoMKgIGVsc2UNCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZmVyLT5ib3VuY2VfYnVmID0ga21lbWR1cCh4ZmVyLT5k
YXRhLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhmZXItPmRhdGFfbGVuLCBHRlBfS0VS
TkVMKTsNCj4+Pj4gKw0KPj4+PiArwqDCoMKgwqAgcmV0dXJuIHhmZXItPmJvdW5jZV9idWYgPT0g
TlVMTCA/IC1FTk9NRU0gOiAwOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgdm9pZCBt
Y2hwX2kzY19oY2lfZnJlZV9zYWZlX3hmZXJfYnVmKHN0cnVjdCBtY2hwX2kzY19oY2kgKmhjaSwN
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1jaHBfaGNpX3hmZXIgKnhmZXIpDQo+Pj4+ICt7
DQo+Pj4+ICvCoMKgwqDCoCBpZiAoaGNpLT5pbyA9PSAmbWNocF9taXBpX2kzY19oY2lfcGlvIHx8
IHhmZXItPmJvdW5jZV9idWYgPT0gDQo+Pj4+IE5VTEwpDQo+Pj4+ICvCoMKgwqDCoCByZXR1cm47
DQo+Pj4+ICvCoMKgwqDCoCBpZiAoeGZlci0+cm53KQ0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG1lbWNweSh4ZmVyLT5kYXRhLCB4ZmVyLT5ib3VuY2VfYnVmLCB4ZmVyLT5kYXRhX2xl
bik7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoMKgIGtmcmVlKHhmZXItPmJvdW5jZV9idWYpOw0KPj4+
PiArfQ0KPg0KPiBTaWRlbm90ZSwgdGhlc2UgYm91bmNlIGJ1ZiBzdHVmZiBhcmUgY29tcGxldGUg
dW5uZWVkZWQgaWYgeW91ciBIVw0KPiBzdXBwb3J0cyBvbmx5IFBJTyB0cmFuc2ZlcnMuDQo+DQo+
Pj4+ICtzdGF0aWMgaW50IG1jaHBfaTNjX2hjaV9hdHRhY2hfaTNjX2RldihzdHJ1Y3QgaTNjX2Rl
dl9kZXNjICpkZXYpDQo+Pj4+ICt7DQo+Pj4+ICvCoMKgwqDCoCBzdHJ1Y3QgaTNjX21hc3Rlcl9j
b250cm9sbGVyICptID0gaTNjX2Rldl9nZXRfbWFzdGVyKGRldik7DQo+Pj4+ICvCoMKgwqDCoCBz
dHJ1Y3QgbWNocF9pM2NfaGNpICpoY2kgPSB0b19pM2NfaGNpKG0pOw0KPj4+PiArwqDCoMKgwqAg
c3RydWN0IG1jaHBfaTNjX2hjaV9kZXZfZGF0YSAqZGV2X2RhdGE7DQo+Pj4+ICvCoMKgwqDCoCBp
bnQgcmV0Ow0KPj4+PiArDQo+Pj4+ICvCoMKgwqDCoCBkZXZfZGF0YSA9IGt6YWxsb2Moc2l6ZW9m
KCpkZXZfZGF0YSksIEdGUF9LRVJORUwpOw0KPj4+PiArwqDCoMKgwqAgaWYgKCFkZXZfZGF0YSkN
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsNCj4+Pj4gK8Kg
wqDCoMKgIGlmIChoY2ktPmNtZCA9PSAmbWNocF9taXBpX2kzY19oY2lfY21kX3YxKSB7DQo+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gbWNocF9taXBpX2kzY19oY2lfZGF0X3Yx
LmFsbG9jX2VudHJ5KGhjaSk7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJl
dCA8IDApIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
a2ZyZWUoZGV2X2RhdGEpOw0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtY2hwX21pcGlfaTNjX2hjaV9kYXRfdjEuc2V0
X2R5bmFtaWNfYWRkcihoY2ksIHJldCwgDQo+Pj4+IGRldi0+aW5mby5keW5fYWRkcik7DQo+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2RhdGEtPmRhdF9pZHggPSByZXQ7DQo+Pj4+
ICvCoMKgwqDCoCB9DQo+Pj4+ICvCoMKgwqDCoCBpM2NfZGV2X3NldF9tYXN0ZXJfZGF0YShkZXYs
IGRldl9kYXRhKTsNCj4+Pj4gK8KgwqDCoMKgIHJldHVybiAwOw0KPj4+PiArfQ0KPg0KPiBTZWUg
Y29tbWl0IDJiNTA3MTlkZDkyZiAoImkzYzogbWlwaS1pM2MtaGNpOiBTdXBwb3J0IFNFVERBU0Eg
Q0NDIikuDQo+DQoNCg==

