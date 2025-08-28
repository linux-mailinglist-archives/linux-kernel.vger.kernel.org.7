Return-Path: <linux-kernel+bounces-790068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2C0B39EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4886D3B060C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877A31E25F2;
	Thu, 28 Aug 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XUSIrien"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02A220F2A;
	Thu, 28 Aug 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387809; cv=fail; b=EECOR+lVuZslThMKa6KNjnfcRRYtgUZCvrvpQ06EAZLBRVAU4it/o+YJNb3bQrtEzR349jJd97yXgxLHz+KTwUDF3QHosNbZPebxIMYcp/pLW2TF83nYNiwxxHteyzVa7xssr6fgctzwO2BhyFkn9MaHMIwMl5aZJ3442HXcu3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387809; c=relaxed/simple;
	bh=5Mq1ZIukHFRcY3mlfvN/663DFxYQac/D+XERQIezcN8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g2L8beTodcKyPYuXDszh5yrJWWEN4coT1blG1tc+fh4JiD0RloeHjFuavH74NpkUSlq2v1y2mCm5BVfJnjNlAE4DHEh8npReOXOVJKjvGIpHKT2PKjNWrKel30/PSqpZlqhSrtVgkmXqAtCBv57/4JV5i2DgiHhSuMeOgQbRLUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XUSIrien; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmvrAnMuvQUkmrVF0up2dsk3HXNT8SqNOidsCW2IEBdarcAtFIWxZx7qCojYZWew4rm5zbglG5lLz9N1hmJk/8w0+Dt/O8piZmtUBVaKQ+62LzuW7Lc2BC72/64q+VhFgJNiVERYhS8IlfYomnIdHHCdlUxTxUsvzINQRSXrVz3TKUw6/OZNzn1hGiQmf/c50uY8NVzPHVbw5iJCjgPeaFfPezTj19yxi/DebWcSuLLknRICyfRABcOgw3YraaKyBWmbBix3gaXeTGlJjKWZsEn3Yv3DDFrCXm7BIlS+m1Usnr0MzHmYbumhZ+s1adCIuz9l/vmWTzo16UxB5odD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Mq1ZIukHFRcY3mlfvN/663DFxYQac/D+XERQIezcN8=;
 b=tCASLNIIWsSj5UrlS/3pI7gFS1EreFslc8xLrdmG5dtivmmFbnqP1bnuI6izhKhvN8fN8KSrWVQWWd1HFxhNKmcM5YKqTs2mOmiTAkZDc3PEiIhI4s+I8jqt3aOf7TbNA7SOuqUZpFJSGtYQ8Oa/hr3dg2h25+T0cjSN2WL47kGFT5N5bbh2fsfcm5cJzCvwH7Inw028tI2BXTYNStM55sWC7iI8/WgA3nETgQNTh8rCpvIZUdKBogo9YYCPl9bFP1h/mdWJ1wps/h5x5AJKCMC5JzbpbgUV+mMPZAa/t7IeGhqHqde+31jEhDTu93X/Sqm6lrW5ycl+MBUtR7VIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Mq1ZIukHFRcY3mlfvN/663DFxYQac/D+XERQIezcN8=;
 b=XUSIrienkzMKS/t1luwt/ddzjTCe/AlFILarQZ6XYT8BmH0UJ8J0VPRap9myGiFPOqjZHi5ACsyhdFujjblSuH91x/ak5IJiPt8VqH9stAVZnxjtRi6SBHm4bWdEljEOMjFGHyzu6yrwIY21RaSLHbkzgCahGv2ZFOynSXLbW7I=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 13:30:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9052.017; Thu, 28 Aug 2025
 13:30:01 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Prasad, Prasad"
	<venkataprasad.potturu@amd.com>, "Mukunda, Vijendar"
	<Vijendar.Mukunda@amd.com>, Charles Keepax <ckeepax@opensource.cirrus.com>,
	Peter Zijlstra <peterz@infradead.org>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ASoC: amd: use int type to store negative error codes
Thread-Topic: [PATCH 1/3] ASoC: amd: use int type to store negative error
 codes
Thread-Index: AQHcF/EAOT8GM++1V02KpXB7kLYEPrR4D9OA
Date: Thu, 28 Aug 2025 13:30:01 +0000
Message-ID: <1ed8cbda-e594-4a53-8801-78c03093ac55@amd.com>
References: <20250828075406.386208-1-rongqianfeng@vivo.com>
 <20250828075406.386208-2-rongqianfeng@vivo.com>
In-Reply-To: <20250828075406.386208-2-rongqianfeng@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DS7PR12MB6143:EE_
x-ms-office365-filtering-correlation-id: c8405c36-e875-49a1-e6af-08dde636fdd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWU0MVJ0R2sxS3FOU2E0NTh0UG9xUVArcTUraEFqQmIzaUpiTTFjdDlhZ2tw?=
 =?utf-8?B?bHJIV3pXN0JKQ2ZHc3F1WTlnWFc4VkdVaWRrQVpEem02cDlXbG15UG43RVNZ?=
 =?utf-8?B?WWdqOVMrdlFKTTMzYWIwKzhSdXJMT3NkbEVpZHhkRmhUUGZtejVPTEc2RjZO?=
 =?utf-8?B?ck9vRjdGZXBEczVsVE9iNzQ0a1A0SkhYNDZBL21tcU5iWnJuMGt2dnV1Ty80?=
 =?utf-8?B?eUZaZmVWaERxNjVtVkpYeXdOaEY3dCtSU3IrWTR3ZEpBSThCUzEzUUwyakNI?=
 =?utf-8?B?WWZiT2ZnUkZXOCs0amVjL0tyNjBMZS9sY0Z4dk9EM29aZk5adklockVrZ2ZS?=
 =?utf-8?B?WmFFd2JxTEZaQ1Q3aEloOXJyQktIdW9uc1RiMkRMUlRzUS9XNWNtYXFRY01l?=
 =?utf-8?B?ejRZUkxNRlMwV1NIbEFWVGlsSGMvMXlhYll5dlVueDZOdkpCOEp1VmlhNHo1?=
 =?utf-8?B?RWJUVUl6bmVhYUdra1pmNEY0UWFJdFhVdzJYaEcxZVhnVy91MG95bGhuK1h4?=
 =?utf-8?B?TS9MRm5ndExtam1JTWt3WHFFb2V3TU01Q2xIMjE5Tk5FWDY4b3NNbmNxQm5S?=
 =?utf-8?B?V0ZDK2tqWEVSU2daKy9wY3JrTkx3Lzd2ckNzVlJWY1dQVjQvZHppL3ExRjhs?=
 =?utf-8?B?b29UK2krbWowN3F3T1o3MGJmc0FacUlMMEsxWVRKYjAwNzk1WmoyZXYrRHFY?=
 =?utf-8?B?U3pucm9HbWZmWHB0bU8wZm5tUGR3bE1EaTczN0hqcTlnTVY1ZDhsUGN2MXZp?=
 =?utf-8?B?b2V2QW9mb1p1Ukl3QUg3WG82TGZNbGpVZ2JtTkZ3ZUo3L1NpUEREaG5wMUVa?=
 =?utf-8?B?MmpibmM4RmI2cTBlRTUrUjVBTTJaU3FwRHFreXNWOXhuRWNnK21Vekc4WTRT?=
 =?utf-8?B?TWNscDc5TEpUaEUxNzBLZEkyMTFNdGl4NCtyODZaWGtYaWk3VWpFeHBodkpx?=
 =?utf-8?B?YnJYaGJIeWdYMFR3dVNaOUU4d09mMmwvQmxRWDF0RXQrVG54Z044Z1lUVitN?=
 =?utf-8?B?VDlNRnRMdEhidDhqaEI3UithY2R5dHRwbnQyODViM3RDL3hVb2MvTGFlVjg2?=
 =?utf-8?B?TWprQkUwT1hDZkpUeHhydUxPanVqQ3JKOFFCclBKMU1uS2RVVjJvNGRNWDRp?=
 =?utf-8?B?Z1NzNWpNRFMxenZkRkJxM0c5TU90K1hnWDluY3hFNmw0c0pRQUdPek9SM0NB?=
 =?utf-8?B?b1ZGOVh3Sk1Oa3E1MnZ3bkkxTi8wMGJLRjFjbWVTOW1tY3J2SnlhNXJRWHdM?=
 =?utf-8?B?UmsxL0w5ZWgwS2VCTytHU2oxalBMQTRUaENnaDlITHFoN2M0L29xb25MdmF3?=
 =?utf-8?B?am8vVTZVdUhMYzBEenptRllOcTlIZ3EzUXZFTDNjYmdBNHRVSk40Z0xNVWtJ?=
 =?utf-8?B?Q09LcXoxaDVWcGFxSFpmaXkxc1Z5cXBuekN3MXVQRlI0ZHpvV3h3MVpsdDN6?=
 =?utf-8?B?TjAza3l3d051NWRXd0ovbG5YSEhWS3ZKdXN1Yi8vSFZyOUM1ckVEMitFOVEv?=
 =?utf-8?B?alhObXREVElQR2xwUWNiNXY5Q2FGZUpYQi9hR2drVXJIWFNQc3BrbGVydEZo?=
 =?utf-8?B?MVBDUlhXdGt4TVFlNFdDUHdUV0hyNFlRVU1XOFJrNjFuQU1YV0w5UkJlZmhL?=
 =?utf-8?B?OHN1b2hPZHRtSTQ2NVZiQ2t6cjFBK1ZhdjFXK3dCOG5SQXltN1ZwQ0ZYUnhx?=
 =?utf-8?B?K2hYNVpxR1ZuRWtweFQ0aGQrYmpWTVNSazVQdzdKcUFOUmxSRFpldW01ZGx2?=
 =?utf-8?B?YmVBUXg0MHA1ZVRBUHNiZkJ4QVk0MDdjL0c4ZUZYNkFGZWNieEw4NDVlVHI5?=
 =?utf-8?B?RzJFWkwzWk1KZkZsRk5yU2Q2TVJYRWF6dktZTFFaajltZHh1eTlHNTRmdGp1?=
 =?utf-8?B?MndUZ01sYUN2UmhzQ2ptR3c2NE9xdUFNNTEvWHBwVU1WekIzd1dnRllRUzNQ?=
 =?utf-8?B?ZGFuVHlHbGk2NjBKV3ltOXYyaWEwSjUvUGNwNVRGZmt2Ujc2Tm41b2hqS09p?=
 =?utf-8?Q?w7NsV1x4ed9jv5GXoN3Jg5ddK+RIWE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2FEeUxKc0IxUENvcjZEdGgvSW01ck1KNUpPc0N3ZmRRMXo5aWFRL0x2ckYr?=
 =?utf-8?B?SmkvRFRHZ2ZvV3JuNy8xdWVwZ21tYStHa0tZaTgxd1djVmtpUzkvYXBBRHlh?=
 =?utf-8?B?ZHRvOEs0RVo2WVhKTkNJMnd0a3hGbWYwZW1FSk94VGIxZW5hbWx1SksxZmxQ?=
 =?utf-8?B?QVk1SnZ0SHpnUlhZWlZ6a2NnaHBGQnNxRWJkbmhocFNxNHU1SEVqSm02OGxE?=
 =?utf-8?B?VXA3aXovQmhJOUMrTHBVTEJIdUZoY0p4RVpNa3hjVWl1dmRCZTVLeHlKU0Ja?=
 =?utf-8?B?Tk1kWWhGUndQWTRSNjBtMmEySlNveUs2SzBTNk4vOUFHTG8yRW1EdzUrUEhz?=
 =?utf-8?B?azBreFljSDRhV0NmTGRGY0k0NFplaFVjOVJaVk14Ly9qenNueHRkU1lxRGw3?=
 =?utf-8?B?T3VjSDd5Sk9ZckgwekQzbFBMMmoxeEE0Zm1WTWdtQmdSc0o1RlVmN3dscUx1?=
 =?utf-8?B?SDJNbS9SdFcySUdublNza1VPSk9OUllUMlBuZG9KVE1hUXZKeHh2NzN3OU5W?=
 =?utf-8?B?UGFlNlY5dmpzbXRZTTl0VGNibVgzNXl0U1E1UU5QMWh5NW5mMVpNN255NVcv?=
 =?utf-8?B?LzZMSHdSc0l0TzN2TkR3ZTRxOGxEeU5jVU9pS2dDeXl1U0NQQnJiWUlVbUhP?=
 =?utf-8?B?RjJGU3pVOVVoVTYySGJoOXJUdDNvQU0vRjFseU9oYU5XN0xaY0c1a1R3K2ht?=
 =?utf-8?B?TUx6MWNWVGhpT09WcDJWZmpLZ2s0MllqcktjcDJ4dVJMOG9KU052QnpVTXhl?=
 =?utf-8?B?dFFVWGdGL2xmTVRaTDZrMXNCZ1YrSzBhN3BvQnI1VE5mMjVMU0JaSFNobXFJ?=
 =?utf-8?B?K0FSMkkvR01yRndQbUpkRGlUaElJWVVQcDJNaForcGNJbWZMejVSK0JsdWkz?=
 =?utf-8?B?U1ExZTE3RFpOMGx0VlZaWnFaVFFsV3UzVXdNdXNJUThWQ1Y5RWYwZjRTRmpJ?=
 =?utf-8?B?QmZxWGNBMmhCSnhqM3dJVVEwRlVPK1Vrb2E0Y01LOTc5TVFxRXVzNmNTNEkw?=
 =?utf-8?B?RVNXUkJDNXZvYlJVbkxiVVVpYVc1SkROdkVBY3I4bnVQQjRwUlhBaGorMFcr?=
 =?utf-8?B?UkdHanVDdWUzVElCc3Z2aHhiTVNHZG03OFRGUi91M01FOUtvZFBGcjFKb2ZJ?=
 =?utf-8?B?bDZBOXlVNVhTdm54S0Mxd2ZFUmNySlJYTGtNNE1PN0JuVFp0ZktLVzR4a0lu?=
 =?utf-8?B?dzlsNG1PTWlIOTRxVzFKVSs4WXdYR3RmUVhha0NyMzN4Y2J0Q1daRVVGSldX?=
 =?utf-8?B?Y0ZSTzBqT3NSSWhjcHlUYW1tWEY2WHVaVlNsbndIM3hPWllVUmtYTXdIZS9m?=
 =?utf-8?B?SGdGV3VBdWZkdk9ialZxVnVXeXo0T0VjcUVncTdmTXpyMU1NL0I5eGxIN0M5?=
 =?utf-8?B?bGNaMUpsNXVycHFpak5jLzR1TXZxSjRLU1ZFaVNxMjM3NFd3L0U5ZE9RaDdL?=
 =?utf-8?B?NVNOTUlCcjA2RnQxcXNSRHg0V1J0bU5MZFpxYlNmbVV1QlZNNklLSXN1ZHp4?=
 =?utf-8?B?djluUy92TUJ1TWFXYzZwSTV2Ui9pcWhvWko0RU9VdFFBMTduNTdEQ1ZrN3Ew?=
 =?utf-8?B?ZlU3SjhPSnVwSXFvenozZkpLc2lidlBGYjRDRmV3RHR6WnZRMVllblM2ME1L?=
 =?utf-8?B?YVRCU1l1SkltRGJjQjB0V3hXMWIxSjJCVUZ1N2JiMXc5QUh4b3MyRy9ycDZq?=
 =?utf-8?B?d1NSRFdUcXpYUHVyMXY4dUlKQlpaajJ5UVRIQVZhR3hxekNTQmlFWHc1WnFD?=
 =?utf-8?B?ZmR4MFBISU1IOHFEajZaSzhxRlJoUXMzS0RvVVh3RWRPWjVyUXdWdG51dDZG?=
 =?utf-8?B?UEkwZDBmTFVUMXdZUWk1aEp6cWZWU2xvSHN6MW82U2dxT3pKek4wcXlDUWsx?=
 =?utf-8?B?anNvaE9ndU1KMlhxWFk2cEpEakdZWkpzZHdoZFZzZHh1Q2MxK0wyUUhtSWZp?=
 =?utf-8?B?SStYMnNOWTlUQ3paSmdtRmdBTXp3WTM3UmZicVhlZ28rSVFPNitZakprNjlt?=
 =?utf-8?B?K1RhMzhVNVg0dzlZQjA4SXgxWlkyMjZLeTEvVWpodWNWL3hFekFscjNLbEhu?=
 =?utf-8?B?MTd0cXBCRDlWRFp1eVhSVjhrUEtjYUtFMVdJUlRSa0xTOC8wK3hjUDduYTlG?=
 =?utf-8?Q?Xp6k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47DCB764E7BB054A90E54CED9ED9CB16@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8405c36-e875-49a1-e6af-08dde636fdd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 13:30:01.7579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1inDq0dlWVlsLFjES0jt9CercBRAFlXvoNxoxH2B2mN4Qo5gd4ndTgjZSbstQE27SnGfC7jVUn4RWstbZ0zIUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

T24gOC8yOC8yNSAyOjUzIEFNLCBRaWFuZmVuZyBSb25nIHdyb3RlOg0KPiBDaGFuZ2UgdGhlICdy
ZXQnIHZhcmlhYmxlIGZyb20gdTMyIHRvIGludCB0byBzdG9yZSBuZWdhdGl2ZSBlcnJvciBjb2Rl
cw0KPiBkaXJlY3RseSBvciByZXR1cm5lZCBieSBvdGhlciBmdW5jdGlvbnMuDQo+IA0KPiBTdG9y
aW5nIHRoZSBuZWdhdGl2ZSBlcnJvciBjb2RlcyBpbiB1bnNpZ25lZCB0eXBlLCBkb2Vzbid0IGNh
dXNlIGFuIGlzc3VlDQo+IGF0IHJ1bnRpbWUgYnV0IGl0J3MgdWdseSBhcyBwYW50cy4gQWRkaXRp
b25hbGx5LCBhc3NpZ25pbmcgbmVnYXRpdmUgZXJyb3INCj4gY29kZXMgdG8gdW5zaWduZWQgdHlw
ZSBtYXkgdHJpZ2dlciBhIEdDQyB3YXJuaW5nIHdoZW4gdGhlIC1Xc2lnbi1jb252ZXJzaW9uDQo+
IGZsYWcgaXMgZW5hYmxlZC4NCj4gDQo+IE5vIGVmZmVjdCBvbiBydW50aW1lLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUWlhbmZlbmcgUm9uZyA8cm9uZ3FpYW5mZW5nQHZpdm8uY29tPg0KDQpSZXZp
ZXdlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQoN
Cj4gLS0tDQo+ICAgc291bmQvc29jL2FtZC9hY3AvYWNwLXJlbWJyYW5kdC5jIHwgMiArLQ0KPiAg
IHNvdW5kL3NvYy9hbWQvcmF2ZW4vYWNwM3gtaTJzLmMgICB8IDMgKystDQo+ICAgc291bmQvc29j
L2FtZC92YW5nb2doL2FjcDV4LWkycy5jIHwgMyArKy0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9zb3VuZC9z
b2MvYW1kL2FjcC9hY3AtcmVtYnJhbmR0LmMgYi9zb3VuZC9zb2MvYW1kL2FjcC9hY3AtcmVtYnJh
bmR0LmMNCj4gaW5kZXggYWVmZmQyNDcxMGU3Li43ZTljMDc0ODhkY2MgMTAwNjQ0DQo+IC0tLSBh
L3NvdW5kL3NvYy9hbWQvYWNwL2FjcC1yZW1icmFuZHQuYw0KPiArKysgYi9zb3VuZC9zb2MvYW1k
L2FjcC9hY3AtcmVtYnJhbmR0LmMNCj4gQEAgLTE0Nyw3ICsxNDcsNyBAQCBzdGF0aWMgaW50IHJl
bWJyYW5kdF9hdWRpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIHsN
Cj4gICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gICAJc3RydWN0IGFjcF9j
aGlwX2luZm8gKmNoaXA7DQo+IC0JdTMyIHJldDsNCj4gKwlpbnQgcmV0Ow0KPiAgIA0KPiAgIAlj
aGlwID0gZGV2X2dldF9wbGF0ZGF0YSgmcGRldi0+ZGV2KTsNCj4gICAJaWYgKCFjaGlwIHx8ICFj
aGlwLT5iYXNlKSB7DQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvYW1kL3JhdmVuL2FjcDN4LWky
cy5jIGIvc291bmQvc29jL2FtZC9yYXZlbi9hY3AzeC1pMnMuYw0KPiBpbmRleCBlN2YyYTA1ZTgw
MmMuLjM1MjQ4NWRkOThiMSAxMDA2NDQNCj4gLS0tIGEvc291bmQvc29jL2FtZC9yYXZlbi9hY3Az
eC1pMnMuYw0KPiArKysgYi9zb3VuZC9zb2MvYW1kL3JhdmVuL2FjcDN4LWkycy5jDQo+IEBAIC0x
NDksOCArMTQ5LDkgQEAgc3RhdGljIGludCBhY3AzeF9pMnNfdHJpZ2dlcihzdHJ1Y3Qgc25kX3Bj
bV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCj4gICAJCQkJaW50IGNtZCwgc3RydWN0IHNuZF9zb2Nf
ZGFpICpkYWkpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgaTJzX3N0cmVhbV9pbnN0YW5jZSAqcnRkOw0K
PiAtCXUzMiByZXQsIHZhbCwgcGVyaW9kX2J5dGVzLCByZWdfdmFsLCBpZXJfdmFsLCB3YXRlcl92
YWw7DQo+ICsJdTMyIHZhbCwgcGVyaW9kX2J5dGVzLCByZWdfdmFsLCBpZXJfdmFsLCB3YXRlcl92
YWw7DQo+ICAgCXUzMiBidWZfc2l6ZSwgYnVmX3JlZzsNCj4gKwlpbnQgcmV0Ow0KPiAgIA0KPiAg
IAlydGQgPSBzdWJzdHJlYW0tPnJ1bnRpbWUtPnByaXZhdGVfZGF0YTsNCj4gICAJcGVyaW9kX2J5
dGVzID0gZnJhbWVzX3RvX2J5dGVzKHN1YnN0cmVhbS0+cnVudGltZSwNCj4gZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9hbWQvdmFuZ29naC9hY3A1eC1pMnMuYyBiL3NvdW5kL3NvYy9hbWQvdmFuZ29n
aC9hY3A1eC1pMnMuYw0KPiBpbmRleCA3ZGJlMzNmNGI4NjcuLmJmNzE5ZjYyODYxNyAxMDA2NDQN
Cj4gLS0tIGEvc291bmQvc29jL2FtZC92YW5nb2doL2FjcDV4LWkycy5jDQo+ICsrKyBiL3NvdW5k
L3NvYy9hbWQvdmFuZ29naC9hY3A1eC1pMnMuYw0KPiBAQCAtMjM0LDggKzIzNCw5IEBAIHN0YXRp
YyBpbnQgYWNwNXhfaTJzX3RyaWdnZXIoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJl
YW0sDQo+ICAgew0KPiAgIAlzdHJ1Y3QgaTJzX3N0cmVhbV9pbnN0YW5jZSAqcnRkOw0KPiAgIAlz
dHJ1Y3QgaTJzX2Rldl9kYXRhICphZGF0YTsNCj4gLQl1MzIgcmV0LCB2YWwsIHBlcmlvZF9ieXRl
cywgcmVnX3ZhbCwgaWVyX3ZhbCwgd2F0ZXJfdmFsOw0KPiArCXUzMiB2YWwsIHBlcmlvZF9ieXRl
cywgcmVnX3ZhbCwgaWVyX3ZhbCwgd2F0ZXJfdmFsOw0KPiAgIAl1MzIgYnVmX3NpemUsIGJ1Zl9y
ZWc7DQo+ICsJaW50IHJldDsNCj4gICANCj4gICAJYWRhdGEgPSBzbmRfc29jX2RhaV9nZXRfZHJ2
ZGF0YShkYWkpOw0KPiAgIAlydGQgPSBzdWJzdHJlYW0tPnJ1bnRpbWUtPnByaXZhdGVfZGF0YTsN
Cg0K

