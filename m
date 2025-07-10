Return-Path: <linux-kernel+bounces-725393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743F8AFFE6D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DF316E9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049042D542B;
	Thu, 10 Jul 2025 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="m0IleSPE"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023086.outbound.protection.outlook.com [40.107.44.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B12D3EE6;
	Thu, 10 Jul 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140905; cv=fail; b=iTEsYmZxy/ofZY6DYMVRw9+RTNWNd5MYjgUIxEgtKT/SIFYI5//gYvLzDO1NI7eku2uJYLcq7IQqHXNjx8zy6lqwSdTj3ccg6i34QB1tE/UQHVzMMraZP6dYP22XOeb7wd0d9EBosNaQ0YdMglNOECU62kpnXev9N0pMXv2/l58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140905; c=relaxed/simple;
	bh=7v0B5PUdHAsCi6O6WH2/RBnO1JNZfqxjamaHH2+1pNI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J6DAcmxcC3MB10FrRbsTxMjpbLfEbbORN4uArHi70JzTSGk57WmTcWz9X8fvBz53M++rrVOOxYfdEFAjaqCxct2kk4kQOq0N1fkTO8KywC33ONCbySN3Y5+Aik9ABvVUU7UxfO8jgZioFSxkGHX0DGkbtbYNrnNdf+wE1MH5kU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=m0IleSPE; arc=fail smtp.client-ip=40.107.44.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTf8Q414a1drQIPgvfJhPewisSCVwDvnAfWluxi5PgKu/ihB+c7rxMtehZ7qyrD/wpdbNiCXwM4aBhpSdMu6VmjUVoLFOlEeU9qcZHA1GFQMZsUqI0CvP9MhsN/rsCWRe9+urcoy/WjzIYm8l2IfqI3Ufhc8C44dTmXX+1LTyi089N3/QxP78+qVo8scF2G3EVnBB42E6W0hd8mmWhWNXO8CvA1SkjKmOdT0gSAjXB2/1d9QolRqnmJ0BNo2Enjj6ggI9Yl7P419fuzu+rTQQXFacjA7eA83qaYZ9LrT5eKGQ1aYG2VrX4VEu4HMQ2HUtn16AH6pxOKBGcW6ikAoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3y7XMfYPXVR0mof668UnZkeJBun02DbEWdVxxyYeGU=;
 b=HmTW91XH1Aj2Yo0v+Jrp5NNUNjgdkB8MsXsgL1NuEGqiF6AcZYE9kkBF5S6Sg8nXc8yeKrUn09/fPAbQhziPCOfeXZZQiuADbzdqa8+OedlD0RSdeEz9IeahsdGKkGz6m1kZBsUb0UKvdo9ocmTfZpfgKSQiNc9I/pDN2uwjykjmw3GA0BSJWnbiPLtysTFIrKjlr78FA+05fpWsGTnMm5YDU9Q3YnBvBKRYsBYUJgzi5VU13F2A1GlKh5nvUJVYFvTTl3fKQmw/byr7odTt2uUHx31KMwwgIGbjE5EzoACsg3P+0U6xtqJAM/ASIsU1FSyMn3BnyaEjJ/E1G/g5+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3y7XMfYPXVR0mof668UnZkeJBun02DbEWdVxxyYeGU=;
 b=m0IleSPEdfeqCWqJ+zZAXXlVUFa49LUpE+lYkg7mWZekZsJsuRG0R9rL+NfLDnwWvZrz197EaPu9Q3w/yp5WWJoHkmPt/iQ19WRoIjfk3WNa6QkvcJEf+lmR0mVvoguDlHD7wuPvoNhSYn2QAqWcXts3VOqi6dSrSabsNGv9PsNIjvYlLqapTvrICNvLG3trPcjeZaMhVcbdMSYvDp8UmUsVnzHwjgFlZtF6w1QMoAqBoJY4TJmItfXVbwnoxiNbi35JvPt0nUaYjbt3VMKoT8ziU763GyAvJSV0baVji3Qr1xEBAHirUMQeNOwtlqtcSmfAJzoiJS+UKEAlhTQNRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by SE2PPFC68D788ED.apcprd03.prod.outlook.com (2603:1096:108:1::4a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 09:48:17 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%3]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 09:48:17 +0000
Message-ID: <54b2a8fd-cdef-42c2-bd15-0b35352cec1f@amlogic.com>
Date: Thu, 10 Jul 2025 17:48:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] arm64: dts: amlogic: Add Amlogic S4 Audio
To: Jerome Brunet <jbrunet@baylibre.com>,
 jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com
References: <20250710-audio_drvier-v5-0-d4155f1e7464@amlogic.com>
 <20250710-audio_drvier-v5-6-d4155f1e7464@amlogic.com>
 <1jzfdcpfla.fsf@starbuckisacylon.baylibre.com>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <1jzfdcpfla.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To PUZPR03MB7135.apcprd03.prod.outlook.com
 (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|SE2PPFC68D788ED:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d84195e-4d16-43bc-16cc-08ddbf96e52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkhkRy90STFsT240UExXVnd4SUNvQW5NbVhoR2dtcEE0NHlqcGtzRys2b1hn?=
 =?utf-8?B?WGdlNnB6VytEamxWc0J2ZEU3UnRpNDN4aTd0WXU1Rmd6M0ZLNzFvcDlLVERj?=
 =?utf-8?B?ZWdkUVNzVldDaWRZb1BVZUt3eDFKZnduVHp4cHkzNGNaQmJvdVBMQlJTelcr?=
 =?utf-8?B?cWFyVEN6Vncva2lqQU5nSGkwZm5MR2d4RjJlS21sSnM4SE1EOHh0dS90ZGRR?=
 =?utf-8?B?MWpSeHhIdTNXQnBBWS82M2Mwa3BPMWJnS2RwaTQ0OHg2UHk3QVJDSHh4UXdL?=
 =?utf-8?B?cFVoMEd3SFA0cng0cVBla2JQZVhmRG9zWlNsdzNjOW9LYnhiekFQaUFUd0xn?=
 =?utf-8?B?cXFTcG5ydjVQc2JSS3FwQW5PcVhiVU9GTGtFaFVXNzFsSHQ0aU9oYTNPN21G?=
 =?utf-8?B?M0dabE5IUlNUKzZMZlg1NTBNdWZBdVdqL0NybHluVDMwNGpNY3hibDFKWGtK?=
 =?utf-8?B?RW1vSk56MlFpeks1VmpLRWJkSUxYZzZDbk5kNHZtZEdycGpNTnNPUVFWR3Vo?=
 =?utf-8?B?QVlWYzFTL2gzWUdQWHM1eDZ2MXovS2ZJYTkwc0l6b1FmV2s4MFlXeGZHWG5I?=
 =?utf-8?B?YTdscjYveVpsejRoRnllZlNaVWQ1Z2ZlRTQyWFZHZ00xQXpyMGpjUm5BL25B?=
 =?utf-8?B?bTdyUHpLK2ZtdmZieEQyRGJQWlMzdGtLQTZTRmdwNUkzWUg1ZjN4aGlhM1h3?=
 =?utf-8?B?cURFWk4wZ0VBZFY0Z0s4VzhnTStJVlpaZ3d4VTdIVk52SlBQenpxdmx6WFI3?=
 =?utf-8?B?bkFwejhYbEdFT0RsOVFCZ2tFbkxpU3hmb2hQZE5wVjF6b0JVK2J5WjZ6dkU4?=
 =?utf-8?B?SFpMb1NBUDh5TGNDTGtXYXRZOGI0Q3dvb3B6N3U4RlBCZ3pNNnBpS3YweVpK?=
 =?utf-8?B?R1JRV1lqUnFkV2xWUnI4ZFVoaHV1ZExER0VjWmhlRm1MSk1YZlJZdWVNcVFl?=
 =?utf-8?B?ZWFQYzBicFp3N2x5QVQwdkQvTTQ1Sm94ZDZJWEsrbGN3bkg3WkhQQnJRTm5S?=
 =?utf-8?B?VnF5b0RPQVBzY2diSEUvYzR6NzlDTVJKTGkwalFmVWthSmNzRGF5Qy91cTlV?=
 =?utf-8?B?bWNDVTQ4RjN3aFNrd0lXWHI5dHFvbmZWUjlydzhoNWdsYlVMQ1U3aXdCaHVQ?=
 =?utf-8?B?V3pvZHZyRnJQZk1oVWFINXVuS3UwWHM2aDVUTnVSUEhpeWNReU1tL3A2WnUz?=
 =?utf-8?B?djNYZnYwMmZ4ZStYQ1ZZNGJYOVpBaVJkcUZueSttTkRpNms0cmhXa2VzOFNO?=
 =?utf-8?B?bW5zNGYrRHdnb1VaMjBwRGVCM3pUZ0N0akRkWDd3akhad1lLQ3kzYWdQRlJT?=
 =?utf-8?B?SjdCMktNdWZmTERxbEZDRGIzeGhzRmZaUlFHb1ZUNmRJeWxhKzRqc01oZmNU?=
 =?utf-8?B?N3hvQmplL2dSRnFSclRpTnpsSTVFQ3Y5WG1YYjRDS24yLzVEYmFBeDMzT0Y2?=
 =?utf-8?B?eFJHQTRIc1R2UCt5WVA3ODJSUVFhZjBSUDh2elNaL3VEUWcyV0RGdm1XUFRZ?=
 =?utf-8?B?VGRxSHAxclpEOXFuYk9BdVI1V08xN0MwNEF5NklId3FCQ3kxaCsvMkJjeEgw?=
 =?utf-8?B?eUwrRkFRMGNDRWRyc0w1NDVpanBTZk1GcnFLS3V1YmVWckhRYWhVNVBYMVFs?=
 =?utf-8?B?cVlRZWpKeWNaQ2ZKOXJBSmkxTkZlT3p5NUVpeFBiTEY2bzl5cmNrYkJ6SGtH?=
 =?utf-8?B?Si82aHc4SWlwYlQrbDRuNEFTTlhkY2lyRWxid0JwL2h2RUx2VldmaWxBVmw3?=
 =?utf-8?B?VWRCZFBFcmtxa290dEhwOWpuOUZkbWJLZGU0T1hFMy9sbGpuZEF0clhPNHBo?=
 =?utf-8?B?SThuRGc0eHlFaURFTUZocWx1ZGNrbjgvamNnS3hKOGJvQnJLRjRHS1dTQ2d1?=
 =?utf-8?B?RUFld0lEU0JSTnlKeU5WNkN2YyswMkl5V29HVkJRUWowblRhUUY4eHFoSk96?=
 =?utf-8?Q?XASCBqAgBJM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TC81ZmEvd2dYTVRUQld1eXlUSXoxSVdFdXBZUHh5VDIvR21uT3Z1NXNyT2I3?=
 =?utf-8?B?S0lnc2MyVXdXZzRNLy9EQ3I0MElpTjNiMDlhbldwZzZKRjFVb2NWVXpCV0tU?=
 =?utf-8?B?QlJKOU1CRjUyMnMwdTJvSjlBVDIvRkVEMzFDSXRsdVFqTitSUkhMV1RCdDAv?=
 =?utf-8?B?V2dIOEppUWdRdFRsa281WHY1VGJLSzNVdFluWkxnQlpva2xrTTRLTllXM3dR?=
 =?utf-8?B?Z3hEZktpUDk4VC9PMXExdjBzSEpIMmI0QVd4VE5sRXZsWHY0UTU1U0p3M0pO?=
 =?utf-8?B?WGVtbk4yV0ZsQzN6Z2ladUtmSzJhQldnRk1iTEVWSkd2RWRsL0p0dlE1d01I?=
 =?utf-8?B?Y1AreVJnUGtja09lVHVwSVRLc2tNbjBCZDFoQ2YxamV0YW5nMUNVM1JZanVZ?=
 =?utf-8?B?OXoxWGFOMy8zbitFaVJvYXkrVUZXWTIwRzZMckljL3VMSDRxNHVQNkNEaWQy?=
 =?utf-8?B?OVBraGpTVkRuU2x0NCt6ZHVITDV2K3p6YkxUS05rSTRnTklreENrRGUzcmF2?=
 =?utf-8?B?SmlHcmk5MDVZNHc0VjhEUmdncDhiQmpLbVBFREpXWXExWW5iY0FoMGhtYWkz?=
 =?utf-8?B?VGtYbmxhOWxjY2pNaDJ5MVRPdVlTZzNrMEpDb3kvcWxnNzFxMkVYK3V5Zzh3?=
 =?utf-8?B?ZU1OTlJsdmVkL1VHVmVGSXhlU1F4cnhmOVExVVljUDRBNFdaODdoVnA5YkdO?=
 =?utf-8?B?enNaL0ZOVUlhTXF4cVRIRkFKNnpDRFpMU2RHallJNlFndkpvRlV4TjNOL2hI?=
 =?utf-8?B?YVdUWFk3VG9wMUw4Mkg2OE13NWp3S09iekFKK0xiU1hqL0F1ODNVMTB6bUlS?=
 =?utf-8?B?MGl3Q0xjenVuSURQcXAwcjNaaGtlbzhtbUZ3M1I1Vm1MVndidm8za1FURVU1?=
 =?utf-8?B?ZmtxK2VuWCt5czU3VnhqU0RscCtRS3hGMm02bjBiOC9zZ3hEZkhDQWpaLzRi?=
 =?utf-8?B?RUJscDNjbVhNd0lyTHhGbGNIdlJyYXBRSkx6ejlPNXo4cU13NFVJb3F5WDNk?=
 =?utf-8?B?M0l5NWJGUHJUcEQvbHcxMk95UEFCcGFOd2NkUjJkYkk2eEFla09sZ0VvSUlF?=
 =?utf-8?B?MU9DUytWdDNKNUVGK1ArYnVzZEdYVWttYzhGR1BSZXFDN1VZdFFUdm5XU3ND?=
 =?utf-8?B?dzlqY1d1bHRaRmFtODlOTkxWWVBzd3RkRUtjUzdtTkNaZ0xXSVo2N0d4dmFu?=
 =?utf-8?B?bUh1MmhtdXRnQUVxMGcvWlNvc3gxVVlFQnNzN1FxQjZzVFF5WS9wc1FDcDlw?=
 =?utf-8?B?Y2FYQkpCeWNNdlExSGRqb0lkNURnTzZoM2x5cm1tNlNCWWFORUt1aEhKazIy?=
 =?utf-8?B?Y3B3ckZxWDlsV1JXemFMakE2SzNHM21aZnpyZmdQei9lbXA3ZXZmalZZRnov?=
 =?utf-8?B?dHZoNS9qYjhTRlo2VEZpd0J4VUhMRGVqVmdxb0ZPYThnaERxeHFCU0NIa3Nn?=
 =?utf-8?B?UDZjRGtZS3VNSUE3RjE4RnE0OUZlMVQrb2N0aVczM0g1ZW5aWUE2bGEwc2hv?=
 =?utf-8?B?MTF5LzErbHFlWVEydkFDWExhaHl0N0RVUjBvSjJyS1FjWGJIOThTOWFDa0tU?=
 =?utf-8?B?UGVRNjdUQUZoWTNZVFd1WVhnd00ybkFsa1d5WjhXUy9xVDZzNjZuZE00NDBo?=
 =?utf-8?B?d1hPTjZCd1o3V0RCempyLzh2OExvOEprMG1mbzI2QU1NOTBjYVZjckZDOWZN?=
 =?utf-8?B?U0tYdmR2Y1pNTVowK1hNZXRYWkhzZHJSUnY1cXdyRlpHOHkyNVhuL3hMN1hV?=
 =?utf-8?B?V1Uza1EzU3ZqR3gxRFNhdk5jU1BwS3J1RVZmakxCZEhpcjQ3L2pyaDJOS1Zr?=
 =?utf-8?B?SjFkb3JnNjh6NHI5a29SQnVtejg4YU9JbGVJSnB0Z1l4SWFHUXE1VWovNHJB?=
 =?utf-8?B?ZU9MbVk5Ri90NnFZSzlTNlJ4M2cyalRRV3kxb3ZNb2VDTENuWWNoblUrNjRD?=
 =?utf-8?B?bUhZbXEzTzhkbVhwUjQ3Uk45VkQyNFE0TzNUODBlNHZCQkR4UGFCOFhyaEY0?=
 =?utf-8?B?a01vdloyRHhyWit3U1VnVDM4OFV1bXRIUWFJRFltL2pZaVgrSHR2L3hITHh5?=
 =?utf-8?B?dDl1RUQ4cThzYzhNYzdUaUJrSWVoVVY5bHpQbmxmRVRMbzB6SEVQVStkWitH?=
 =?utf-8?B?blRpV1NFcDhtWE9xM2dOa2xuOW50b0Q4UUhNZk1HTjhreFZUditUaG8wUWJa?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d84195e-4d16-43bc-16cc-08ddbf96e52e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 09:48:17.0328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4M9GLa4hJtyubE+7aPikU9i+L3q3DJw7gYheagFhRjvdg4sI5/mVtSAHrNEt/DV1wQO+kyr6y5qcT5dA0cYbBfONTSjmd3AR6jL8MyB2go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFC68D788ED


在 2025/7/10 17:20, Jerome Brunet 写道:
> [ EXTERNAL EMAIL ]
>
> On Thu 10 Jul 2025 at 11:35, jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org> wrote:
>
>> From: jiebing chen <jiebing.chen@amlogic.com>
>>
>> Add basic audio driver support for the Amlogic S4 based
>> Amlogic AQ222 board.
>>
>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>> ---
>>   .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     | 218 ++++++++++++
>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 387 +++++++++++++++++++++
>>   2 files changed, 605 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
>> index 6730c44642d2910d42ec0c4adf49fefc3514dbec..47c6b8d63fdfca01281f0935f3dc419af6d86a25 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
>> @@ -75,6 +75,19 @@ vddio_ao1v8: regulator-vddio-ao1v8 {
>>               regulator-always-on;
>>        };
>>
>> +     vcc5v_reg: regulator-vcc-5v {
>> +             compatible = "regulator-fixed";
>> +             vin-supply = <&main_12v>;
>> +             regulator-name = "VCC5V";
>> +             regulator-min-microvolt = <5000000>;
>> +             regulator-max-microvolt = <5000000>;
>> +             gpio = <&gpio GPIOH_7 GPIO_ACTIVE_HIGH>;
>> +             startup-delay-us = <7000>;
>> +             enable-active-high;
>> +             regulator-boot-on;
>> +             regulator-always-on;
>> +     };
>> +
>>        /* SY8120B1ABC DC/DC Regulator. */
>>        vddcpu: regulator-vddcpu {
>>                compatible = "pwm-regulator";
>> @@ -129,6 +142,211 @@ vddcpu: regulator-vddcpu {
>>                                <699000 98>,
>>                                <689000 100>;
>>        };
>> +     dmics: audio-codec-1 {
>> +             compatible = "dmic-codec";
>> +             #sound-dai-cells = <0>;
>> +             num-channels = <2>;
>> +             wakeup-delay-ms = <50>;
>> +             sound-name-prefix = "MIC";
>> +     };
>> +
>> +     dioo2133: audio-amplifier-0 {
>> +             compatible = "simple-audio-amplifier";
>> +             enable-gpios = <&gpio GPIOH_8 GPIO_ACTIVE_HIGH>;
>> +             VCC-supply = <&vcc5v_reg>;
>> +             sound-name-prefix = "10U2";
>> +     };
>> +
>> +     spdif_dir: audio-spdif-in {
>> +             compatible = "linux,spdif-dir";
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "DIR";
>> +     };
>> +
>> +     spdif_dit: audio-spdif-out {
>> +             compatible = "linux,spdif-dit";
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "DIT";
>> +     };
>> +
>> +     sound {
>> +             compatible = "amlogic,axg-sound-card";
>> +             model = "aq222";
>> +             audio-widgets = "Line", "Lineout";
>> +             audio-aux-devs = <&tdmout_a>, <&tdmout_b>, <&tdmout_c>,
>> +                              <&tdmin_a>, <&tdmin_b>, <&tdmin_c>,
>> +                              <&tdmin_lb>, <&dioo2133>;
>> +             audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
>> +                             "TDMOUT_A IN 1", "FRDDR_B OUT 0",
>> +                             "TDMOUT_A IN 2", "FRDDR_C OUT 0",
>> +                             "TDM_A Playback", "TDMOUT_A OUT",
>> +                             "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>> +                             "TDMOUT_B IN 1", "FRDDR_B OUT 1",
>> +                             "TDMOUT_B IN 2", "FRDDR_C OUT 1",
>> +                             "TDM_B Playback", "TDMOUT_B OUT",
>> +                             "TDMOUT_C IN 0", "FRDDR_A OUT 2",
>> +                             "TDMOUT_C IN 1", "FRDDR_B OUT 2",
>> +                             "TDMOUT_C IN 2", "FRDDR_C OUT 2",
>> +                             "TDM_C Playback", "TDMOUT_C OUT",
>> +                             "SPDIFOUT_A IN 0", "FRDDR_A OUT 3",
>> +                             "SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
>> +                             "SPDIFOUT_A IN 2", "FRDDR_C OUT 3",
>> +                             "SPDIFOUT_B IN 0", "FRDDR_A OUT 4",
>> +                             "SPDIFOUT_B IN 1", "FRDDR_B OUT 4",
>> +                             "SPDIFOUT_B IN 2", "FRDDR_C OUT 4",
>> +                             "TDMIN_A IN 0", "TDM_A Capture",
>> +                             "TDMIN_A IN 1", "TDM_B Capture",
>> +                             "TDMIN_A IN 2", "TDM_C Capture",
>> +                             "TDMIN_A IN 3", "TDM_A Loopback",
>> +                             "TDMIN_A IN 4", "TDM_B Loopback",
>> +                             "TDMIN_A IN 5", "TDM_C Loopback",
>> +                             "TDMIN_B IN 0", "TDM_A Capture",
>> +                             "TDMIN_B IN 1", "TDM_B Capture",
>> +                             "TDMIN_B IN 2", "TDM_C Capture",
>> +                             "TDMIN_B IN 3", "TDM_A Loopback",
>> +                             "TDMIN_B IN 4", "TDM_B Loopback",
>> +                             "TDMIN_B IN 5", "TDM_C Loopback",
>> +                             "TDMIN_C IN 0", "TDM_A Capture",
>> +                             "TDMIN_C IN 1", "TDM_B Capture",
>> +                             "TDMIN_C IN 2", "TDM_C Capture",
>> +                             "TDMIN_C IN 3", "TDM_A Loopback",
>> +                             "TDMIN_C IN 4", "TDM_B Loopback",
>> +                             "TDMIN_C IN 5", "TDM_C Loopback",
>> +                             "TDMIN_LB IN 3", "TDM_A Capture",
>> +                             "TDMIN_LB IN 4", "TDM_B Capture",
>> +                             "TDMIN_LB IN 5", "TDM_C Capture",
>> +                             "TDMIN_LB IN 0", "TDM_A Loopback",
>> +                             "TDMIN_LB IN 1", "TDM_B Loopback",
>> +                             "TDMIN_LB IN 2", "TDM_C Loopback",
>> +                             "TODDR_A IN 0", "TDMIN_A OUT",
>> +                             "TODDR_B IN 0", "TDMIN_A OUT",
>> +                             "TODDR_C IN 0", "TDMIN_A OUT",
>> +                             "TODDR_A IN 1", "TDMIN_B OUT",
>> +                             "TODDR_B IN 1", "TDMIN_B OUT",
>> +                             "TODDR_C IN 1", "TDMIN_B OUT",
>> +                             "TODDR_A IN 2", "TDMIN_C OUT",
>> +                             "TODDR_B IN 2", "TDMIN_C OUT",
>> +                             "TODDR_C IN 2", "TDMIN_C OUT",
>> +                             "TODDR_A IN 3", "SPDIFIN Capture",
>> +                             "TODDR_B IN 3", "SPDIFIN Capture",
>> +                             "TODDR_C IN 3", "SPDIFIN Capture",
>> +                             "TODDR_A IN 6", "TDMIN_LB OUT",
>> +                             "TODDR_B IN 6", "TDMIN_LB OUT",
>> +                             "TODDR_C IN 6", "TDMIN_LB OUT",
>> +                             "10U2 INL", "ACODEC LOLP",
>> +                             "10U2 INR", "ACODEC LORP",
>> +                             "Lineout", "10U2 OUTL",
>> +                             "Lineout", "10U2 OUTR";
>> +             assigned-clocks = <&clkc_pll CLKID_HIFI_PLL>,
>> +                               <&clkc_pll CLKID_MPLL0>,
>> +                               <&clkc_pll CLKID_MPLL1>;
>> +             assigned-clock-rates = <1179648000>,
>> +                                    <270950400>,
>> +                                    <338688000>;
>> +
>> +             dai-link-0 {
>> +                     sound-dai = <&frddr_a>;
>> +             };
>> +
>> +             dai-link-1 {
>> +                     sound-dai = <&frddr_b>;
>> +             };
>> +
>> +             dai-link-2 {
>> +                     sound-dai = <&frddr_c>;
>> +             };
>> +
>> +             dai-link-3 {
>> +                     sound-dai = <&toddr_a>;
>> +             };
>> +
>> +             dai-link-4 {
>> +                     sound-dai = <&toddr_b>;
>> +             };
>> +
>> +             dai-link-5 {
>> +                     sound-dai = <&toddr_c>;
>> +             };
>> +
>> +             dai-link-6 {
>> +                     sound-dai = <&tdmif_a>;
>> +                     dai-format = "i2s";
>> +                     dai-tdm-slot-tx-mask-0 = <1 1>;
>> +                     mclk-fs = <256>;
>> +                     codec-0 {
>> +                             sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
>> +                     };
>> +                     codec-1 {
>> +                             sound-dai = <&toacodec TOACODEC_IN_A>;
>> +                     };
>> +             };
>> +
>> +             dai-link-7 {
>> +                     sound-dai = <&tdmif_b>;
>> +                     dai-format = "i2s";
>> +                     dai-tdm-slot-tx-mask-0 = <1 1>;
>> +                     mclk-fs = <256>;
>> +                     codec-0 {
>> +                             sound-dai = <&toacodec TOACODEC_IN_B>;
>> +                     };
>> +                     codec-1 {
>> +                             sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
>> +                     };
>> +             };
>> +
>> +             /* 8ch HDMI interface */
>> +             dai-link-8 {
>> +                     sound-dai = <&tdmif_c>;
>> +                     dai-format = "i2s";
>> +                     dai-tdm-slot-tx-mask-0 = <1 1>;
>> +                     dai-tdm-slot-tx-mask-1 = <1 1>;
>> +                     dai-tdm-slot-tx-mask-2 = <1 1>;
>> +                     dai-tdm-slot-tx-mask-3 = <1 1>;
>> +                     mclk-fs = <256>;
>> +                     codec-0 {
>> +                             sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
>> +                     };
>> +             };
>> +
>> +             /* spdif hdmi and coax output */
>> +             dai-link-9 {
>> +                     sound-dai = <&spdifout_a>;
>> +
>> +                     codec-0 {
>> +                             sound-dai = <&spdif_dit>;
>> +                     };
>> +
>> +                     codec-1 {
>> +                             sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_A>;
>> +                     };
>> +             };
>> +
>> +             /* spdif hdmi interface */
>> +             dai-link-10 {
>> +                     sound-dai = <&spdifout_b>;
>> +
>> +                     codec {
>> +                             sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_B>;
>> +                     };
>> +             };
>> +
>> +             /* spdif coax input */
>> +             dai-link-11 {
>> +                     sound-dai = <&spdifin>;
>> +
>> +                     codec {
>> +                             sound-dai = <&spdif_dir>;
>> +                     };
>> +             };
>> +
>> +             dai-link-12 {
>> +                     sound-dai = <&toacodec TOACODEC_OUT>;
>> +
>> +                     codec {
>> +                             sound-dai = <&acodec>;
>> +                     };
>> +             };
>> +     };
>>   };
>>
>>   &pwm_ef {
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> index 957577d986c0675a503115e1ccbc4387c2051620..3af2fb333cf7b1ca35f1ff7ad8479bcd859e608a 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> @@ -11,6 +11,11 @@
>>   #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>>   #include <dt-bindings/power/meson-s4-power.h>
>>   #include <dt-bindings/reset/amlogic,meson-s4-reset.h>
>> +#include <dt-bindings/clock/axg-audio-clkc.h>
>> +#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>> +#include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
>> +#include <dt-bindings/sound/meson-g12a-toacodec.h>
>> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>>
>>   / {
>>        cpus {
>> @@ -849,4 +854,386 @@ emmc: mmc@fe08c000 {
>>                        status = "disabled";
>>                };
>>        };
>> +
>> +     tdmif_a: audio-controller-0 {
>> +             compatible = "amlogic,axg-tdm-iface";
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TDM_A";
>> +             clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_A_MCLK>;
>> +             clock-names = "sclk", "lrclk","mclk";
>> +     };
>> +
>> +     tdmif_b: audio-controller-1 {
>> +             compatible = "amlogic,axg-tdm-iface";
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TDM_B";
>> +             clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_B_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_B_MCLK>;
>> +             clock-names = "sclk", "lrclk","mclk";
>> +     };
>> +
>> +     tdmif_c: audio-controller-2 {
>> +             compatible = "amlogic,axg-tdm-iface";
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TDM_C";
>> +             clocks = <&clkc_audio AUD_CLKID_MST_C_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_C_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_C_MCLK>;
>> +             clock-names = "sclk", "lrclk","mclk";
>> +     };
>> +};
>> +
>> +&apb4 {
>> +     acodec: audio-controller@1a000 {
>> +             compatible = "amlogic,t9015";
>> +             reg = <0x0 0x1A000 0x0 0x14>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "ACODEC";
>> +             clocks = <&clkc_periphs CLKID_ACODEC>;
>> +             clock-names = "pclk";
>> +             resets = <&reset RESET_ACODEC>;
>> +             AVDD-supply = <&vddio_ao1v8>;
>> +     };
>> +
>> +     clkc_audio: clock-controller@330000 {
>> +             compatible = "amlogic,s4-audio-clkc";
>> +             reg = <0x0 0x330000 0x0 0xd8>,
>> +                       <0x0 0x330e80 0x0 0x10>;
>> +             #clock-cells = <1>;
>> +             #reset-cells = <1>;
>> +             power-domains = <&pwrc PWRC_S4_AUDIO_ID>;
>> +             clocks = <&clkc_periphs CLKID_AUDIO>,
>> +                      <&clkc_pll CLKID_MPLL0>,
>> +                      <&clkc_pll CLKID_MPLL1>,
>> +                      <&clkc_pll CLKID_MPLL2>,
>> +                      <&clkc_pll CLKID_MPLL3>,
>> +                      <&clkc_pll CLKID_HIFI_PLL>,
>> +                      <&clkc_pll CLKID_FCLK_DIV3>,
>> +                      <&clkc_pll CLKID_FCLK_DIV4>,
>> +                      <&clkc_pll CLKID_FCLK_DIV5>;
>> +             clock-names = "pclk",
>> +                               "mst_in0",
>> +                               "mst_in1",
>> +                               "mst_in2",
>> +                               "mst_in3",
>> +                               "mst_in4",
>> +                               "mst_in5",
>> +                               "mst_in6",
>> +                               "mst_in7";
>> +
>> +             resets = <&reset RESET_AUDIO>;
>> +     };
>> +
>> +     clock-controller@330e80 {
>> +             compatible = "amlogic,clock-pads-clkc";
>> +             reg = <0x0 0x330e80 0x0 0x10>;
>> +             #clock-cells = <1>;
>> +             power-domains = <&pwrc PWRC_S4_AUDIO_ID>;
>> +             clocks = <&clkc_periphs CLKID_AUDIO>,
>> +                      <&clkc_pll CLKID_MPLL0>,
>> +                      <&clkc_pll CLKID_MPLL1>,
>> +                      <&clkc_pll CLKID_MPLL2>,
>> +                      <&clkc_pll CLKID_MPLL3>,
>> +                      <&clkc_pll CLKID_HIFI_PLL>,
>> +                      <&clkc_pll CLKID_FCLK_DIV3>,
>> +                      <&clkc_pll CLKID_FCLK_DIV4>,
>> +                      <&clkc_pll CLKID_FCLK_DIV5>;
>> +             clock-names = "pclk",
>> +                               "mst_in0",
>> +                               "mst_in1",
>> +                               "mst_in2",
>> +                               "mst_in3",
>> +                               "mst_in4",
>> +                               "mst_in5",
>> +                               "mst_in6",
>> +                               "mst_in7";
> Assuming I understood where you are tyring to go with this, those are
> not the input in of this clock controller. The only reason *may* have
> worked is because you referenced the clock by names instead of fwname

yes, just as you understand it.  from your previous suggestion, I found 
that adding this is much more convenient than modifying a large amount 
of code.

>
>> +     };
>> +
>> +     toddr_a: audio-controller@330100 {
>> +             compatible = "amlogic,sm1-toddr",
>> +                              "amlogic,axg-toddr";
>> +             reg = <0x0 0x330100 0x0 0x2c>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TODDR_A";
>> +             interrupts = <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
>> +             clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
>> +             resets = <&arb AXG_ARB_TODDR_A>,
>> +                      <&clkc_audio AUD_RESET_TODDR_A>;
>> +             reset-names = "arb", "rst";
>> +             amlogic,fifo-depth = <8192>;
>> +     };
>> +
>> +     toddr_b: audio-controller@330140 {
>> +             compatible = "amlogic,sm1-toddr",
>> +                              "amlogic,axg-toddr";
>> +             reg = <0x0 0x330140 0x0 0x2c>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TODDR_B";
>> +             interrupts = <GIC_SPI 33 IRQ_TYPE_EDGE_RISING>;
>> +             clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
>> +             resets = <&arb AXG_ARB_TODDR_B>,
>> +                      <&clkc_audio AUD_RESET_TODDR_B>;
>> +             reset-names = "arb", "rst";
>> +             amlogic,fifo-depth = <256>;
>> +     };
>> +
>> +     toddr_c: audio-controller@330180 {
>> +             compatible = "amlogic,sm1-toddr",
>> +                              "amlogic,axg-toddr";
>> +             reg = <0x0 0x330180 0x0 0x2c>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TODDR_C";
>> +             interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>> +             clocks = <&clkc_audio AUD_CLKID_TODDR_C>;
>> +             resets = <&arb AXG_ARB_TODDR_C>,
>> +                      <&clkc_audio AUD_RESET_TODDR_C>;
>> +             reset-names = "arb", "rst";
>> +             amlogic,fifo-depth = <256>;
>> +     };
>> +
>> +     frddr_a: audio-controller@3301c0 {
>> +             compatible = "amlogic,sm1-frddr",
>> +                              "amlogic,axg-frddr";
>> +             reg = <0x0 0x3301c0 0x0 0x2c>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "FRDDR_A";
>> +             interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
>> +             clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
>> +             resets = <&arb AXG_ARB_FRDDR_A>,
>> +                      <&clkc_audio AUD_RESET_FRDDR_A>;
>> +             reset-names = "arb", "rst";
>> +             amlogic,fifo-depth = <512>;
>> +     };
>> +
>> +     frddr_b: audio-controller@330200 {
>> +             compatible = "amlogic,sm1-frddr",
>> +                              "amlogic,axg-frddr";
>> +             reg = <0x0 0x330200 0x0 0x2c>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "FRDDR_B";
>> +             interrupts = <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>;
>> +             clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
>> +             resets = <&arb AXG_ARB_FRDDR_B>,
>> +                      <&clkc_audio AUD_RESET_FRDDR_B>;
>> +             reset-names = "arb", "rst";
>> +             amlogic,fifo-depth = <256>;
>> +     };
>> +
>> +     frddr_c: audio-controller@330240 {
>> +             compatible = "amlogic,sm1-frddr",
>> +                              "amlogic,axg-frddr";
>> +             reg = <0x0 0x330240 0x0 0x2c>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "FRDDR_C";
>> +             interrupts = <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>;
>> +             clocks = <&clkc_audio AUD_CLKID_FRDDR_C>;
>> +             resets = <&arb AXG_ARB_FRDDR_C>,
>> +                      <&clkc_audio AUD_RESET_FRDDR_C>;
>> +             reset-names = "arb", "rst";
>> +             amlogic,fifo-depth = <256>;
>> +     };
>> +
>> +     arb: reset-controller@330280 {
>> +             compatible = "amlogic,meson-sm1-audio-arb";
>> +             reg = <0x0 0x330280 0x0 0x4>;
>> +             #reset-cells = <1>;
>> +             clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
>> +     };
>> +
>> +     tdmin_a: audio-controller@330300 {
>> +             compatible = "amlogic,sm1-tdmin";
>> +             reg = <0x0 0x330300 0x0 0x40>;
>> +             sound-name-prefix = "TDMIN_A";
>> +             resets = <&clkc_audio AUD_RESET_TDMIN_A>;
>> +             clocks = <&clkc_audio AUD_CLKID_TDMIN_A>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_A_LRCLK>;
>> +             clock-names = "pclk", "sclk", "sclk_sel",
>> +                               "lrclk", "lrclk_sel";
>> +     };
>> +
>> +     tdmin_b: audio-controller@330340 {
>> +             compatible = "amlogic,sm1-tdmin";
>> +             reg = <0x0 0x330340 0x0 0x40>;
>> +             sound-name-prefix = "TDMIN_B";
>> +             resets = <&clkc_audio AUD_RESET_TDMIN_B>;
>> +             clocks = <&clkc_audio AUD_CLKID_TDMIN_B>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_B_LRCLK>;
>> +             clock-names = "pclk", "sclk", "sclk_sel",
>> +                               "lrclk", "lrclk_sel";
>> +     };
>> +
>> +     tdmin_c: audio-controller@330380 {
>> +             compatible = "amlogic,sm1-tdmin";
>> +             reg = <0x0 0x330380 0x0 0x40>;
>> +             sound-name-prefix = "TDMIN_C";
>> +             resets = <&clkc_audio AUD_RESET_TDMIN_C>;
>> +             clocks = <&clkc_audio AUD_CLKID_TDMIN_C>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_C_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_C_SCLK_SEL>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_C_LRCLK>;
>> +             clock-names = "pclk", "sclk", "sclk_sel",
>> +                               "lrclk", "lrclk_sel";
>> +     };
>> +
>> +     tdmin_lb: audio-controller@3303c0 {
>> +             compatible = "amlogic,sm1-tdmin";
>> +             reg = <0x0 0x3303c0 0x0 0x40>;
>> +             sound-name-prefix = "TDMIN_LB";
>> +             resets = <&clkc_audio AUD_RESET_TDMIN_LB>;
>> +             clocks = <&clkc_audio AUD_CLKID_TDMIN_LB>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMIN_LB_LRCLK>;
>> +             clock-names = "pclk", "sclk", "sclk_sel",
>> +                               "lrclk", "lrclk_sel";
>> +     };
>> +
>> +     spdifin: audio-controller@330400 {
>> +             compatible = "amlogic,g12a-spdifin",
>> +                              "amlogic,axg-spdifin";
>> +             reg = <0x0 0x330400 0x0 0x30>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "SPDIFIN";
>> +             interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
>> +             clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
>> +             <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
>> +             clock-names = "pclk", "refclk";
>> +             resets = <&clkc_audio AUD_RESET_SPDIFIN>;
>> +     };
>> +
>> +     spdifout_a: audio-controller@330480 {
>> +             compatible = "amlogic,g12a-spdifout",
>> +                              "amlogic,axg-spdifout";
>> +             reg = <0x0 0x330480 0x0 0x50>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "SPDIFOUT_A";
>> +             clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
>> +             <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
>> +             clock-names = "pclk", "mclk";
>> +             resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
>> +     };
>> +
>> +     tdmout_a: audio-controller@330500 {
>> +             compatible = "amlogic,sm1-tdmout";
>> +             reg = <0x0 0x330500 0x0 0x40>;
>> +             sound-name-prefix = "TDMOUT_A";
>> +             resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
>> +             clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
>> +             clock-names = "pclk", "sclk", "sclk_sel",
>> +                               "lrclk", "lrclk_sel";
>> +     };
>> +
>> +     tdmout_b: audio-controller@330540 {
>> +             compatible = "amlogic,sm1-tdmout";
>> +             reg = <0x0 0x330540 0x0 0x40>;
>> +             sound-name-prefix = "TDMOUT_B";
>> +             resets = <&clkc_audio AUD_RESET_TDMOUT_B>;
>> +             clocks = <&clkc_audio AUD_CLKID_TDMOUT_B>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_B_LRCLK>;
>> +             clock-names = "pclk", "sclk", "sclk_sel",
>> +                               "lrclk", "lrclk_sel";
>> +     };
>> +
>> +     tdmout_c: audio-controller@330580 {
>> +             compatible = "amlogic,sm1-tdmout";
>> +             reg = <0x0 0x330580 0x0 0x40>;
>> +             sound-name-prefix = "TDMOUT_C";
>> +             resets = <&clkc_audio AUD_RESET_TDMOUT_C>;
>> +             clocks = <&clkc_audio AUD_CLKID_TDMOUT_C>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK_SEL>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_TDMOUT_C_LRCLK>;
>> +             clock-names = "pclk", "sclk", "sclk_sel",
>> +                               "lrclk", "lrclk_sel";
>> +     };
>> +
>> +     spdifout_b: audio-controller@330680 {
>> +             compatible = "amlogic,g12a-spdifout",
>> +                              "amlogic,axg-spdifout";
>> +             reg = <0x0 0x330680 0x0 0x50>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "SPDIFOUT_B";
>> +             clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
>> +                      <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
>> +             clock-names = "pclk", "mclk";
>> +             resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
>> +     };
>> +
>> +     toacodec: audio-controller@330740 {
>> +             compatible = "amlogic,s4-toacodec",
>> +                              "amlogic,g12a-toacodec";
>> +             reg = <0x0 0x330740 0x0 0x4>;
>> +             sound-name-prefix = "TOACODEC";
>> +             #sound-dai-cells = <1>;
>> +             resets = <&clkc_audio AUD_RESET_TOACODEC>;
>> +     };
>> +
>> +     tohdmitx: audio-controller@330744 {
>> +             compatible = "amlogic,sm1-tohdmitx",
>> +                              "amlogic,g12a-tohdmitx";
>> +             reg = <0x0 0x330744 0x0 0x4>;
>> +             #sound-dai-cells = <1>;
>> +             sound-name-prefix = "TOHDMITX";
>> +             resets = <&clkc_audio AUD_RESET_TOHDMITX>;
>> +     };
>> +
>> +     toddr_d: audio-controller@330840 {
>> +             compatible = "amlogic,sm1-toddr",
>> +                              "amlogic,axg-toddr";
>> +             reg = <0x0 0x330840 0x0 0x2c>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TODDR_D";
>> +             interrupts = <GIC_SPI 45 IRQ_TYPE_EDGE_RISING>;
>> +             clocks = <&clkc_audio AUD_CLKID_TODDR_D>;
>> +             resets = <&arb AXG_ARB_TODDR_D>,
>> +                      <&clkc_audio AUD_RESET_TODDR_D>;
>> +             reset-names = "arb", "rst";
>> +             amlogic,fifo-depth = <256>;
>> +     };
>> +
>> +     frddr_d: audio-controller@330880 {
>> +              compatible = "amlogic,sm1-frddr",
>> +                               "amlogic,axg-frddr";
>> +             reg = <0x0 0x330880 0x0 0x2c>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "FRDDR_D";
>> +             interrupts = <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>;
>> +             clocks = <&clkc_audio AUD_CLKID_FRDDR_D>;
>> +             resets = <&arb AXG_ARB_FRDDR_D>,
>> +                      <&clkc_audio AUD_RESET_FRDDR_D>;
>> +             reset-names = "arb", "rst";
>> +             amlogic,fifo-depth = <256>;
>> +     };
>> +
>> +     pdm: audio-controller@331000 {
>> +             compatible = "amlogic,sm1-pdm",
>> +                          "amlogic,axg-pdm";
>> +             reg = <0x0 0x331000 0x0 0x34>;
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "PDM";
>> +             clocks = <&clkc_audio AUD_CLKID_PDM>,
>> +                      <&clkc_audio AUD_CLKID_PDM_DCLK>,
>> +                      <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
>> +             clock-names = "pclk", "dclk", "sysclk";
>> +             resets = <&clkc_audio AUD_RESET_PDM>;
>> +     };
>>   };
> --
> Jerome

