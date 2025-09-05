Return-Path: <linux-kernel+bounces-801983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3121B44C5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735631C810D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698F229B02;
	Fri,  5 Sep 2025 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="K22zrDyu"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022109.outbound.protection.outlook.com [40.107.75.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0AD143C69;
	Fri,  5 Sep 2025 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757043432; cv=fail; b=h4oXOIBrLzzaFCTREI1vprtiIoyQHqtZ2doDQdw3GBcr+AcLxL3PHfCs4CHMFtPQz6XsXA471WWZcu/aPDka6yQff55vaC/VhaN/lZKDvAFcmcMqBRuwM1Lac6pRn8ITRP+y0onbCQVTba7+ED7Z9TU19w6KsHqcfQEL2/7+B4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757043432; c=relaxed/simple;
	bh=ErrZQDzE/Qgk73bmx+RjTrZ3TwjCec2ETL29TLfD1P0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lea5VdW2j5rvH3VyX6XbH4UC3I3mgCTmagJsupNWN66rAL4GzpDANi/RfnzkL3qJemWLnw+ZB5pjfZNm1n2lUY+/9oFqFyifAge+9wRCBA4zITWTazyKsFU4urWzcLuYTpsLklMl/dXrl6okDfBqOcMMKEP3oDBtzZjjdoa+exo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=K22zrDyu; arc=fail smtp.client-ip=40.107.75.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAjrqaeDkzsfym/YtMQIpfkejK3tWMi8waGAUFgfwEGg/30lW4PvABDyRfUVSjyqAdmaJ/nRXlKp2Cd1kdV6jyO2Xm9gnMewD/pJ0X0ksI0jm7sMM6Q+wvox54bIvg8SgSgN9y0bXjcqvpHb2fdsTnFb9/Bg6oahfIOdXg6q4vJSz6uemv1WVJRkyvwqYKdSGPx57HqvjXUhkOa/OnauRYHyhw2bms83teK7tQ0Pomu9N4OQBrYvLjIBU2U3UxWsLmVxei4709mIiqGAt10fweeZ2rm6mq6Wl4OojmpA1VxH6DQakGH5odBZddI1/chwVGUCCrVBMXdyNM/BwuVuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYUcoa1VEnZ7gMIVNMGoZt7x3VVCyCW9tPDvDdvnZ1E=;
 b=sjsncR2uGqkPdZ7HBI/2db3kM6vBmcXniUkB3Y00QKhlvn/rByVY+/7q/Q4aAxrkcIvu5IUFA+/lyRTW7CZ8D7qifs4/LCoAMd4ZYv7MZYwqga/apn5XOZHrfXxu92sxswZ7M1CcreTJELIxc9m6PapS+qIiWpsuw7ON5PNqoTr7wpjlxTNhapUebf66UiIXOihXFeJ86awTavcE9XYlB+HFbIrPK9g8y/5lEWyhjX8r8Si4byt5lgckd1mgnr1e73V/aLHMQJ+e35aB0U5qgOuLQ3NUfzXDbvao2/TUIK6B2g4EHyg+a3ZL03uHOgBhzX2yEKCYr1PK5xkgqf0Dxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYUcoa1VEnZ7gMIVNMGoZt7x3VVCyCW9tPDvDdvnZ1E=;
 b=K22zrDyubEDmhb78ZTeZTI1RmPgnb8Zr3PYqU1WP7ain1VZBZsdrybwN4kybhdXT2i0NYcB8n73hh2yYj8QBrIrIkWffDtMfHO/Hs24zQMP/jyulO+pENmZ2tuen9LRV7uFp8LRVmR7AyUr6Vx6aDazmqFLG0TMIcVPsq2Kg8a3DqP/5gsSyXSD3r/x6FBIsFAetRSKxarZfgJL4gVTxVlesN430nJ9DnE+I1ykkhsRuJCOxRb0yOKEemQCT6EdMAB2IrLsfb77xTPu0V8IpqFlQr/dE0dN2GhTUy3KNGzHtNrAIyqGI6uIq2AAe/83GCHixv/UlzD4yH358SqVtQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB8036.apcprd03.prod.outlook.com (2603:1096:400:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 03:37:07 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 03:37:07 +0000
Message-ID: <474fb92a-660f-4edc-8a46-bff4a40b8821@amlogic.com>
Date: Fri, 5 Sep 2025 11:37:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dts: arm: amlogic: fix pwm node for c3
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250717-fix-pwm-node-v2-1-7365ac7d5320@amlogic.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20250717-fix-pwm-node-v2-1-7365ac7d5320@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 98423aa1-c3c0-44fa-2ca3-08ddec2d7ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGZwVk80U3VRZ0thZ0xUclBRekRxcjd5OGtjUDBiK2UrOWZuakRSdWxaR1VM?=
 =?utf-8?B?a1N1cWFpbUhMc3NQWVJjSG0vQ3Q1Vkszb3drL2xieHZKQVZjSi96RWo5TGN1?=
 =?utf-8?B?VXlhU0pYVjRkRUl3UllLL1YzZlFDSjJwaWF0eDB2WDcvTHhVZVRyakk0SExZ?=
 =?utf-8?B?QWxsaXNrMFBtc3RhYmd5S09UVmVqM1F5RkZaNlU3QkZNQjRxQXhKd2pkS0Rh?=
 =?utf-8?B?enZjd1FUb3JkcXNtR0pCK1ZrZkxubmFTdVBiMnAyN2ZPajZLQWpya0NPUTU4?=
 =?utf-8?B?WGJkVWk1UG1kSGdRRUVLMk92d3FoTDd4azJQZ05TVW0wLzlCRmpUaUlnV2Vu?=
 =?utf-8?B?QVZBUWd3Z1doYUhmSEFFRmdZNTVWOVZ5ais5THNBdVR0dnlqRmhBS3BDWFRH?=
 =?utf-8?B?STFYL0diZWZvc0VQUjA5NE5NYnJPQnNSY2lWREM2N3VTUS9jMU10dzlDT2tX?=
 =?utf-8?B?TElvcmY2VlppK2RMY1kvaGUvREw4SW1wbEF6dTZZeERzbzBXYVVxQklTRGRY?=
 =?utf-8?B?N1ppWmI3L2YvckEvb0J1MW1qYVI1ZlIzYS9qZGlSdk5taXN2aWt0dlIwOGEr?=
 =?utf-8?B?R1BYWHNOa0UrbEZERG1GWjBGOWhCYWpIK3pNdHFydlNwNVdBRHVXdno2RkYr?=
 =?utf-8?B?R0pWNW1QTklGV29rSllQVGdsRG5aRVZLaytOeCtIN0ZUcXF5b01CWE5mYVlm?=
 =?utf-8?B?YXdDa1NvWHlkV1hHd1ZIc2R3cXdjU2U1QTNReFZSMXo1dUl1OFEwUy9CNlVI?=
 =?utf-8?B?MkFlSjlFMlYxd0ZYUUlTTi9oMDVIeTlIYXU5ZyttdDU1OFBWYkVRcnlFek9L?=
 =?utf-8?B?U0N5OWxZdDZhOStPdW9ZdlpqTWpuc21aZGszU0JoMmRMdjZtZVlSZ05xblFZ?=
 =?utf-8?B?WXhoeXJPaEdnVHc1VVNob1EyMmlrSjg4Ni9ja2JjYWZhU1VYOXAwNTFFQkhE?=
 =?utf-8?B?RHBKQ05TY0JDc1ZacWJiWk5RN1VCbmRwM0ZuVWVVdkhUZkhMOW1aVENaZXlH?=
 =?utf-8?B?ZFVyaUZMZkhjbkY4L3hMczJ5VnpmZVNCTEM4R2tQSUVFRWJJT1I0Y3pWd3dk?=
 =?utf-8?B?akR0NWdHalBhbm1rR25LTVdtMUF6WEVDWDNtZkdJRE1sMEFrUGxjaUM2enhE?=
 =?utf-8?B?Q1BUV3VBbXVxaTZRazZRMnJJTTgyUkhiNGRKYitPQXM4SzV3UzFPTDhnRDNu?=
 =?utf-8?B?ZTUxWExHUTdxVEVYb0o2bHNDbE9jZW5DNjJwNGc1cERpQ3RGdm5JQStCMlVV?=
 =?utf-8?B?YWdRQ2ZwVXRVM0lNdlZuZjQvZDFZamtEQXdPN2M4NXo2RkEvVTBmaVkrMGZ0?=
 =?utf-8?B?eHFPWDQvZENDdjkwMWoycmtVckFLcStzSTY5cUZDK25FcnJmT3M2KzdGYjcy?=
 =?utf-8?B?Q3IrenVTZGI5YnI4U09uM2FBZHNsS2FYMEowdkY5N1FsRExZSDkvZGhUT2c4?=
 =?utf-8?B?R0xCR21WZlpHTjJJZ1IwQStxaGpuNWI5VkR3M1VOOStJb1V3NTZtUGViU1kv?=
 =?utf-8?B?MTg1SUJuUFRlekdWNWdFVEJ5a3liSWQvRWpWMmFOYVc0SmZDN1k0MENVd2c4?=
 =?utf-8?B?RVhLRTZXeW40YndFMVcwTXRwQkJ6YzdLaWliRkRsbVEvbWpWeVVDcHRMNkZO?=
 =?utf-8?B?QlBPL2JOd21RM2F6cUU4UjNHa2lRM1hGNjRaQytKMWtZSWxuV1lNd25tcjls?=
 =?utf-8?B?MVJ2akZtay94dW9iMmg0Q3hSSll6TktYV29oNzY3aWw4cUFjQnhhbGxvalAy?=
 =?utf-8?B?dUtqcmVyb0ZzN2hUTi9VcEdTTTJRQ3k2R0tvdTk3Vnd4aUNncmd2MDBJNHJC?=
 =?utf-8?Q?leWwYSCpMPh+YF/Y0n0QGoDgunbv70OPW2sG4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW9FTTlBdnkvMTBmVDNSZCtLSE9CK3krcXJNTWVGc0pBNG9IRDNPVW1Jb2xq?=
 =?utf-8?B?TVpJRG9Cd1RGRCtDSTVCTW5Rcnd5TkIzL0RjL3g1cHAwVUJSY0E0SGRwUG9D?=
 =?utf-8?B?ZGc4WXhFSWdGSjJUdmlPVFFBdUI4VTIxNkI1RSt1eTdHM1dXZ29raituVThv?=
 =?utf-8?B?YlRWRmxweWozbTFhR3Ztc2Z2a1dzMUtYMHJPOEZ3UHkwRDEwQS84RjhWUnRp?=
 =?utf-8?B?ZnhoamZPWiszbyt0eDJBM2RCSFpYRUdYMG1KUWtra3pyRHFpdG04K1NEbDBm?=
 =?utf-8?B?TytPNVRsU3I0V2ppaVVYM1IyWjVRM2ZJT2RPZTdhV1NnRGRmaDJEVzFnWENh?=
 =?utf-8?B?V01UeVc5VFpBblBsRWRHVmxzcENxd0ZPdExCVlVnQ3JUVXVZemRWYXVCaWgv?=
 =?utf-8?B?RGUrbTVXamFTQ0p1WlhtM01ybVplQUV5dEljYkJwRDhJUVAwK0xQM053YnZM?=
 =?utf-8?B?Y0s0VjNiSWt5WW43WSt2bG4vZjFnTFhld3BYNmVwME1lU0l2YmRockw2ZjJy?=
 =?utf-8?B?b3hHc3RhaWs2eUdnQVZKaHJ5bUFkNHpBbHNhdHpLWnNiaWpWZU04SWlCSjJ1?=
 =?utf-8?B?VUpWUmVyTGlrdjNWRWV5WkJ5Y0d6SCsrNFJlakYwdmhVTHFWd3JnRWp2SkRw?=
 =?utf-8?B?UXF0blVnQkg0WFpOL0hFYThlTkpybStQRjJxeW93eTBJTzdvZytYU0VCS0pH?=
 =?utf-8?B?aG9Lc2Q3ZUJya3dyWkMvMDEveURJT2pxUnZlNW10enZmK2N4Y0YwaUlDaWZD?=
 =?utf-8?B?L0w5QmFWcjRhUThxRGlRdVR6RDcrdUNQUTdkempYeHlOVkRlVXpVVHRTbmsr?=
 =?utf-8?B?MzJwT3hWbmFKRnFJS21IUER6K2VwSUNJYTNvS0JJMTdSSVJ1WXhQRmZFMWF1?=
 =?utf-8?B?TTJtdWFINFpHa1JqK2pOWWJqUjFXYVJzYmNjblU0T1JIbTJoVW9DeVNXR3E2?=
 =?utf-8?B?Q3laL1IxSm5CT0ZRbndLZlVlTkZydjBuRVhZUkF0ZWlTZ3JvRENIMTVaN09l?=
 =?utf-8?B?cUpBejVBaEtLM05BQWFIWVpnelJUT2M1VnlqN29KeUlBK1hqVzFOV2xTdk82?=
 =?utf-8?B?dWV5cnRxZm1ZUUIvS2hUVy9BVGJqSDkzVXdUVEdGcXlseUpHRlZSWG95ejRH?=
 =?utf-8?B?Zzc3T3BhNzZwYTJzSytpY05NZnl6cDVGRGdYbngvN1Bhc2o5RGtXay9IaEJX?=
 =?utf-8?B?QTlhWmhXemNDNi9vTXg3SEttZTMwYjBvSE5uVEtRbUJFdmVHNmJwRDNQT1BR?=
 =?utf-8?B?Z09OaUVEZENHU1ZobjZGRVFOUmVxc3hlUXdGVS9xbFp5UHBVWGIvTW1SZ3NP?=
 =?utf-8?B?aGp4WGFqMFNhakU5eHlacXFiQWdhTnVBaGhzU1pvNUpSRDhoWUcvTzJVRFhJ?=
 =?utf-8?B?VjFFbVg2aEFwdzRMUm1nNjY5eXI2bm8rZ0h0TGF2bVVIanp5eWNmMU9IRWNr?=
 =?utf-8?B?OStUblB6MXpqeDBnR0V2SnhjYmZMSGZleE1naHplYXhETmVFOUVQWUF3MEFm?=
 =?utf-8?B?TWNkd0t2eWEvRWhMU3RUL1VVMStQdmNzd1JhajZGT2Z6ZWtnSFMwdkJ4Z2J0?=
 =?utf-8?B?V0NaM0FpOUNkWTJMRkx4MytmVVVxK0FrWG1XcEdqUFZUV3dTTHNHekg1UUJB?=
 =?utf-8?B?RDJxblYvZTVhbXM1QTB0QTRtOFpuVDhQRmxHMWNhdEZYVkU3RUU0WUtXMkhX?=
 =?utf-8?B?bks0Sk1iMGp4T1NHa0dmeDhRVHRwZ3dOVmh0b0psVnZhcjVoV0w5Y3UvWWhU?=
 =?utf-8?B?d2lZaGlWSjZ0Rm9RQmhNTkR6Q25kRG1teFFiTm01cVlnOW9GYmVCMWhCek5W?=
 =?utf-8?B?Rk5jQXhNV3d3MklqUWFSN2EydUkxV3o3Q2RPUTAyWmduelJieFhIczVvdXFk?=
 =?utf-8?B?TTVxamIzTG9zUVRXUlUwUmhFdElLZHljWjNkbDV1dE9OUEV0WWlZWlZuSGV1?=
 =?utf-8?B?ci9hckRaV1dBRjk0aDQrdTQ4WUttajdJeUhtcThNak9KQldoMVFuZ0x6NUFq?=
 =?utf-8?B?QlYyS2E1R3hLNm1SNGhCMHZBVElvc3drbkovNXB4NkowSUlVN2JaUlF1dGtS?=
 =?utf-8?B?dGJBbDhubEhyM1RQV2txRncvRzA4dGxPLzJubC92L0JxODlsRldRZzR3bFRJ?=
 =?utf-8?B?c2VtTTBWanNQcVdoQUVQb3IycEQvbU9FdDZzUk5yL0U3eVZ4RnRWSFlEaXBZ?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98423aa1-c3c0-44fa-2ca3-08ddec2d7ce4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 03:37:07.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXg2tiFDvv6Gv2NeNrrboOE6VgNZTCaXcbnHLMMH/gC6kA0PCd2/pwjAcqSACgwTtlxaNhJ17HG7AuQsVmDGfFX1sLLx0tjXp0UscHKG5OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8036

Hi Neil,
    Could you please take some time to review this submission?

On 2025/7/17 17:29, Xianwei Zhao via B4 Relay wrote:
> [ EXTERNAL EMAIL ]
> 
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Fix reg address for c3 pwm node.
> 
> Fixes: be90cd4bd422 ("arm64: dts: amlogic: Add Amlogic C3 PWM")
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Fix c3 pwm node reg.
> ---
> Changes in v2:
> - Fix commit change-id about Fixes.
> - Link to v1: https://lore.kernel.org/r/20250717-fix-pwm-node-v1-1-45021777efa9@amlogic.com
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> index cb9ea3ca6ee0..71b2b3b547f7 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -792,7 +792,7 @@ spicc1: spi@52000 {
>                          pwm_mn: pwm@54000 {
>                                  compatible = "amlogic,c3-pwm",
>                                               "amlogic,meson-s4-pwm";
> -                               reg = <0x0 54000 0x0 0x24>;
> +                               reg = <0x0 0x54000 0x0 0x24>;
>                                  clocks = <&clkc_periphs CLKID_PWM_M>,
>                                           <&clkc_periphs CLKID_PWM_N>;
>                                  #pwm-cells = <3>;
> 
> ---
> base-commit: 58abdca0eb653c1a2e755ba9ba406ee475d87636
> change-id: 20250717-fix-pwm-node-61ef27ba9605
> 
> Best regards,
> --
> Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> 

