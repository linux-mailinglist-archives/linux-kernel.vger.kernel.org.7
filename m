Return-Path: <linux-kernel+bounces-731876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6A5B05AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B2E4A181C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C172DC346;
	Tue, 15 Jul 2025 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="exWub5Tm"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022136.outbound.protection.outlook.com [40.107.75.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA81F0E26;
	Tue, 15 Jul 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584940; cv=fail; b=X4GQ9RUh1dnfqebtBTM8bSOb+Mgo/XmE0VAnmWZTFBlAdyBG2P1cr8C4JETLMblKOp477CNvXWcs87jZ4TGJ8hoUWvgEYU8eSNphYOQYJJ5bKCbE/sL2UYwhEIhM5JjQavyAi3wTPyGrp+xIkOHGwYYG1cxAiNtNr7oQ9X/dYao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584940; c=relaxed/simple;
	bh=o6XE3ZCpLhd/xkN0PdFYb/9TCNpcJ0Krs4jmr5jGNN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kHkC2g40NfZDOlsQWObL17WzyCuNbHN0s7gwfpcA9y1UTRY3U9ux0CTZbkQ4An8eRCYmXxBPAk3pDZHB4cx5LAJOS3/ex+qQZoyEBY5WX5jgFUsOycGmXUuMKk6uDKb+4/7Ey19e6C3pU188MFdJzHoA8GxDDsujHZRIEvdIzWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=exWub5Tm; arc=fail smtp.client-ip=40.107.75.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j55+xtppjIxQfJvz9JG8c/24DP108r5RKnHbDAOlDmX7drycNSl/hgLcZh1D0JDv3xsOyHMiAiaH6Sfp/00WHolfKLjVpFHB+qVp43s8mJ7QorTVVx6mfYBoqj0jiH+nmO3isFh5gBAQ/DM8mI5HKzIgkeZs7quzXR2Z5z2YfPQeyD/0jlf4oq/5S0MocG492BD6zsfIm/RnFk5kgwJgMMOH6lmLOQJVsg+0BSRyfU3nLBSYbaf8kApLeVmh2V7BBTqFbpFvSCSQOuEodlHKI0eu3FKUZAmPjSgaC/YpxuukUbO1U8tyWQydzrWejy6n6NKUUWJRM+v7gAGOCYvDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfSkwLBYLY419kt51A0vFXLxJBBorL9q75zkUpkz5Js=;
 b=A6baNrWP74j7Tht87ghuPy5hFLnFCoCI8q/bwMIKHauNEFyCcHoHPNtSrtRbPwkubjxTQP0WPyK67mMgEYRIARImkNWCCkKboQPY+zeroF6LUHor50AcdfwHWrh/vAziT9dpQsyuTnW20PUV35cs+Zl9yvn+6loNC2xm4wbmriQedkDksh2lV87MWjJFlaOJr3UskfM2AKdt0jVQsr193KU5f7UjrkDcRHnDGCS2Rkd/d7+5piRWuCFyruJPV2chVVGvpAe+eeAdhJDMUnmWlnWGGguJrELXM5MA7hH2VW/CmQCjzQXqB6RgMghiW3oNq8Jpws1YCzWkqPSRIorCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfSkwLBYLY419kt51A0vFXLxJBBorL9q75zkUpkz5Js=;
 b=exWub5Tm40Hst2WM+jO2p7io733mRZjouPoOTtsbNIX66cDXrB+UdBhi66yljuKQNXxi9IBaOsfqljS3KQjHKeVqLAVLFi4j3+OOvQi7sFfzVlIMgX6nKSsHiS71wg1EQ+vak5ERh4KcScPqC/pqeOy63ov7u77FAGMyW2viBJbR4KKdscV2ATxpcLzoP4gdZjwq3w3xl+xnIgZ2oV+C9EEHohFZ90XOzyeQFXxvXmE/GCZZNoFx1VyZL4F+9MXP/iZUQqQJZFtNxQXEMgpZe9B26/tXmK5IvcYkUGR5WGNq33sIVPh49wgMaluknxu1NMQmIpc6EppKM26dFHMWvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEYPR03MB7796.apcprd03.prod.outlook.com (2603:1096:101:16a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 15 Jul
 2025 13:08:51 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%6]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 13:08:51 +0000
Message-ID: <aeb3c8f6-e3a4-4927-9743-b8e59eb5137b@amlogic.com>
Date: Tue, 15 Jul 2025 21:08:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: amlogic: add video-related clocks for S4 SoC
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com>
 <20250715-add_video_clk-v1-2-40e7f633f361@amlogic.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <20250715-add_video_clk-v1-2-40e7f633f361@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEYPR03MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 943f8721-ef9d-4567-4210-08ddc3a0be45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEJPYmxzSTlRZnU2OXI3UXh6Nk93TEcwYS82T094enhhMk5laEpzSWl6N3RC?=
 =?utf-8?B?MzFPQWR5NjRDSUtpNzhUR0NLRXlUVzNZT2JNMDVzSVBjWmlmNnVVdkVWd1pV?=
 =?utf-8?B?cWp0b1RWV2ZicjBBRko0NmJEd1lkTlVNVmVrMjNjVS8wS2dKWFBDNzRqSnFz?=
 =?utf-8?B?TUxEb20wK3cwMlJjWHRFYmlORVg3ekRySTErUUNzQ055NE1Ga1ovenY5ekdq?=
 =?utf-8?B?WEFLcnlydkJIUjd5UlNPS3d4YXNvMTZyY1Bxd2JadWV5ZnlOTUt2czR4RDNK?=
 =?utf-8?B?OVZPN21uZDFXOG1OZ1kyU0VOZ0ZaR2IzVkR6dzllS2dnVFN4djZUNTNBYTlB?=
 =?utf-8?B?QWp0WEh1NHNScEJnNjBsYXYvMTU1Q1hxNjVUT3dPUEJGbUFKMDlLYTR1cFdj?=
 =?utf-8?B?eHhKNHJZY0FSdTdQd2NXNnhtUFVMS2t5akNjSlhPWnpRd1pMSW56UWFQNWli?=
 =?utf-8?B?ZW92NGZ0N01kaDVNb05kSUhHRzhHNTI4LzJOL3lQalcxQWp3R2NvNVNBdWZr?=
 =?utf-8?B?TnlSS25Xckl3YXRTbXJsNUNIVld6RTdvR1lkWis0SFJXeE1nSzZ4U2s0b05K?=
 =?utf-8?B?Zjh3Qk0rQmF3Q3c3QWtBeXZQVSt6d1p5UnpRT21kcDNTMVVaQ0p5VlhRODIx?=
 =?utf-8?B?M0tZQ3BqUktCUVpUN1MvamVUSUdaVWhqV2ZQVmJVOVNVNHNPTlhPQUdaclhO?=
 =?utf-8?B?YlpuTGJDUTllYm50dytsWjVjVnR2NTJ5VnF4WjFKYk1XUHNQVTdlM090eUd3?=
 =?utf-8?B?bHJyWkFDZHpSUHZVbm85UzlPVXdaZDF4aVFvRVgrdm1ONUpVMTRscE9VekJJ?=
 =?utf-8?B?ZzVxSjhibEJUeUJqV3locUdLU21uSnMvUkVOUEg1aGYzMEVxV3h5anlLTjJq?=
 =?utf-8?B?T0FwMFZQZmVadE9uZUxqdHdOUjJzS2pxbGkvbjdiSkgwQ3JVbHdheXorS0hi?=
 =?utf-8?B?dmFabEVwWTFZSk4zMXBDcGV1VVBwc1lDeVRaUjF0Q1hHZE1FbXFydTV5eGM1?=
 =?utf-8?B?UVJQZWJhQWN4S0VYbWhSOGhqS0FNQ0JpT2FEbW5sUTlvRjBFejY4RklxdnJC?=
 =?utf-8?B?QjlHY3JObCtBbWZ0S2lvS1RGc1E4dUVrZjRuMWtMUGp1YzZGRlVpdk5TZWMx?=
 =?utf-8?B?YnNyQ3pVSW1ZZnVUbW83VTdJQnhqTjYyWkFhcU50VTVmWTFmaURycVdka0FZ?=
 =?utf-8?B?Szl2Tzh0KzZJZ003b21jVmQ3MExRQWRWTkw1ekdWbHA4SU5tT1E5Tkt5ME04?=
 =?utf-8?B?K0JHdTNzZ1R6RDVjb2F5T0xhZ25RNXl5NDRNdUkrTFJRZjlYZVk5dkx1U3V2?=
 =?utf-8?B?bjhYdHZLeDFMTjlxSFRscDhmSEFqUVhhM1JiSm9VcTJNVFFMRHM1OUVuSXcw?=
 =?utf-8?B?NEV3cUFBbnJkNVdRRXdJa3dHSUlieFJCWnZZL1Qwb2FVamlHVEZ4eTVPakhp?=
 =?utf-8?B?QTRlY2J6OCtWVVEweDJUVGpvWnYxeGg4S2dEMHMzYjllNW5tTlNwYzI1M2Zk?=
 =?utf-8?B?WTdHTVIyNmxycXc3czhlRzUwNitldzIxOHlUNHFzYjFxOW8rMXBkT1d5N3Fw?=
 =?utf-8?B?aUxhTjNVMjVNeWgyc21rNERvdzA5N3R4TDNKK0VOWVpJMzQ0ZFZySHliQS9O?=
 =?utf-8?B?V3hPOXNwZGNEL0duRzIyeGNjODB0Yk55bzlEdWhuRlVWcWdDcGNGU3lsbU90?=
 =?utf-8?B?VTVjMGxKRC9YaFdhYmhaUnkrbjNJbjk3dy8rbVQrWitBOStNZzNDUE9LY05s?=
 =?utf-8?B?Yy9qNlMxNGVDVFVDaHgyd0JFdEhNVWtzc2N0dUZyVjFQbXR1Yjh3R3FlYkZo?=
 =?utf-8?B?Z2NxRWQ0emJWb2NnVGwxeXlTWFN5SEVud3JJcE1xNjRTRFBFU2VNWlI5Qytz?=
 =?utf-8?B?S1EwdzFDT3Z5bFd3aUpHRzU1Qk1vd3lrQ3RHbStMNXdFUVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uko4cDNFQkdoS1A0aXdBMG56ektEdGM1MlB4ZFg1Y3V2K1dGZWdRZWxMa0k4?=
 =?utf-8?B?bzA4NkhnZ0NFV29RTVlObTQzWFcrdksxWENxMnNER0dVQWcxMGZRUEFrSm1O?=
 =?utf-8?B?b0xIcy9HRGJlRmFyUUJtQzhCSnJCU1Z1T1ppQW5Ic0MyWmdpdDh6V2VBUzc3?=
 =?utf-8?B?aVlhclFOWUNodFZ5VHZrYS9NODVPdlN4ZFF3U1o0Q1c0a0YvQ3NXeGxaaHNx?=
 =?utf-8?B?SXpmNmY2OU5CZFMxNWdSaDZUVDlZa0hURTUwRjYwQ252QXY3bEQ1VlVmNTZT?=
 =?utf-8?B?SUlwOGRhTWwxZS9PTWxsWXYrd2VBZ1J2TG5QM0J5MUI4MWhDQUFkREdsa05I?=
 =?utf-8?B?Y2JsaDRjT3owTFJnUkJBRnphSkJodU9yZkEyb1dKSTJ0dnZXTFJ5ZkFydHM3?=
 =?utf-8?B?V1NOTlF1RVh1NkpLOStpaFNjb3lQYm51TVowY2M1NVJVNHlMRUltZ3ArS0pt?=
 =?utf-8?B?ODVKZjhoNmdON3g2RjUwZEZ6QXA4STEvU2I4VWx1M3dJd2JiMi8rWXRPemRP?=
 =?utf-8?B?OWFUWWRrdXF3OHhmNUNIbGx0TWd5VURTUlRQM2ZEOUNmc1VTUGV5Z0N0cnl3?=
 =?utf-8?B?UlNKbFRjWWdJL2hUUjk0QkZWSE14K0RrU2NiUERYWTFSQmc3SHhRT0ZqRmM4?=
 =?utf-8?B?WVdDVi9uUWJ0QUtpL2U2bVI2c1lPMWdHMkZHUHZmY2JWVzBlVUhuUDV4TUlB?=
 =?utf-8?B?SGE4ek9mL3lQVFY3dWV3ekNJRWFnSndQdzZCN1dHZ3VQNERGNnJVaEx0VlhO?=
 =?utf-8?B?bktHVkJxYVVKZUpCVVl3VHEvZWJVWVRHbDY4NXlvZitOM1NyT0xJL1lXYmlR?=
 =?utf-8?B?bnNXcDd3dTdvVmEyemdpQ2tuZUxHOGxid1FBOWcxUFl5T0FlMSs0ejZBUDhL?=
 =?utf-8?B?UnBFLzl1cHF5V3ZhVmJhWVdXOVhhSGpGaXFhQ2lEanpwcFZSK1kwbzFFT3Jh?=
 =?utf-8?B?amdjM0I5YWd5RnczQlM0dmVycTdmaWRreVBUREtaUFlEbVVXSWNJa21uMk1B?=
 =?utf-8?B?ZlFoaVcwTjRyR0hoMFNxc3J6SjRVU1JTVDFpS21WRjBuMWZDQ3hZVGxoTC9V?=
 =?utf-8?B?OEx0K0RIZVhTTytaY2dzN2FaL1c0Y1BkdW40SnZyVXRNekNqMWtsVmxPdkRX?=
 =?utf-8?B?M2Z2TkxYZ204eEh0cWJKVmxseDEwVVV4N3JVU0JPemtCYmxkR3pQeWlYKzRL?=
 =?utf-8?B?RjQrYlNibHI1aHY0eHkzODhTUFFrR0k5MDh2VUovV250VGhPS1F1d0hjWUpG?=
 =?utf-8?B?cjN2KzVRb1h6NU1HOTRMWFpJS0RvSzh3UGpoS0pjc01ZbUpWNHZMWVUzb3h6?=
 =?utf-8?B?SWdHeGJwcUpmaUZjOFV3VGd0SG54UFlVNGRVeEtUWWlQWUwxcW80ZDZ1OU1Z?=
 =?utf-8?B?R2lsREhLamZ0M0E0cUxCQ2RvTVRsSzdUTjBNWndGVVpVQkxncStVMnRQaER5?=
 =?utf-8?B?ak9DSE5JdTJiaWFraFVIeFMvTVNSOE9wQW91enRkR29ZYXRuZEZ2UU9hMVlv?=
 =?utf-8?B?NXcxaUkyTUVzQUczOXRsUis1SE1aaStlS0R6ditOTW9uMjNSN0tSS3lIT3pG?=
 =?utf-8?B?aWZlL1AyeVVVd2tYVEw2L0cza1F2RXdDSmNHUHhXUTFlNjFvcmIyckJzUExK?=
 =?utf-8?B?VXJpSGJIc3lKUGorUVM0bGhBR0pPNy91UTVITm1PMENSek0xU2FQdlhnYWhK?=
 =?utf-8?B?RGdwaHc4TGFiVm9WZzNicEViYzYwTEd5Wnpia1c3NWdjMWJtMFRGdnA2Q0Fs?=
 =?utf-8?B?SnBuZS92ZkJCamhKVld3eTlhdys4czB5SG1hc2FoQmFEcWRXZmNpeDJETEV0?=
 =?utf-8?B?cyt4c1BmSXZ0dkhXNW5TNGVFTHZnS0JZayt1Mi9lcFRSUVlTczUyd2xXc3VT?=
 =?utf-8?B?Wi9UdTNjaW9Zc3dNQXpRc3VCTkVaMEQyQ1FxZ3E5T1lEWitLenpCcDRSQ1RF?=
 =?utf-8?B?UENGZlNHbXN1QWYyS1d5OHRRTTdEZ2RZTWdXNFhqY0lMYlBoUHU4T0dINUR4?=
 =?utf-8?B?OXFGVjRmUjJJRWUvY2RGRmFQdko4K3RsUzVra2N0dW9PUTM0UFFNeHlNdEdJ?=
 =?utf-8?B?ZlZ5RFBjcGJ4QXhiY2dpaXBkQnNVR2lOREE2bmx5R09rcW4vaGVTdTY2S09s?=
 =?utf-8?Q?QIK8JuuBo/RiuRWaZWtnlklmH?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943f8721-ef9d-4567-4210-08ddc3a0be45
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:08:51.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Lzm4Pinjl/nrOxaNYfhTiub2fNZhI5Ic2X4oG5OTKeSC4kq2mEnG5/zsTSnDKiag0mJXKDiD0HOxaxqQBjdvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7796


On 7/15/2025 8:51 PM, Chuan Liu via B4 Relay wrote:
> [ EXTERNAL EMAIL ]
>
> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Add video encoder, demodulator and CVBS clocks.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>   drivers/clk/meson/s4-peripherals.c | 256 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 256 insertions(+)
>
> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
> index c9400cf54c84..f43526d506b1 100644
> --- a/drivers/clk/meson/s4-peripherals.c
> +++ b/drivers/clk/meson/s4-peripherals.c
> @@ -44,6 +44,7 @@
>   #define CLKCTRL_VDIN_MEAS_CLK_CTRL                 0x0f8
>   #define CLKCTRL_VAPBCLK_CTRL                       0x0fc
>   #define CLKCTRL_HDCP22_CTRL                        0x100
> +#define CLKCTRL_CDAC_CLK_CTRL                      0x108
>   #define CLKCTRL_VDEC_CLK_CTRL                      0x140
>   #define CLKCTRL_VDEC2_CLK_CTRL                     0x144
>   #define CLKCTRL_VDEC3_CLK_CTRL                     0x148
> @@ -1117,6 +1118,22 @@ static struct clk_regmap s4_cts_encp_sel = {
>          },
>   };
>
> +static struct clk_regmap s4_cts_encl_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = CLKCTRL_VIID_CLK_DIV,
> +               .mask = 0xf,
> +               .shift = 12,
> +               .table = mux_table_cts_sel,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cts_encl_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_hws = s4_cts_parent_hws,
> +               .num_parents = ARRAY_SIZE(s4_cts_parent_hws),
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
>   static struct clk_regmap s4_cts_vdac_sel = {
>          .data = &(struct clk_regmap_mux_data){
>                  .offset = CLKCTRL_VIID_CLK_DIV,
> @@ -1196,6 +1213,22 @@ static struct clk_regmap s4_cts_encp = {
>          },
>   };
>
> +static struct clk_regmap s4_cts_encl = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = CLKCTRL_VID_CLK_CTRL2,
> +               .bit_idx = 3,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "cts_encl",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_cts_encl_sel.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
>   static struct clk_regmap s4_cts_vdac = {
>          .data = &(struct clk_regmap_gate_data){
>                  .offset = CLKCTRL_VID_CLK_CTRL2,
> @@ -1228,6 +1261,56 @@ static struct clk_regmap s4_hdmi_tx = {
>          },
>   };
>
> +static struct clk_regmap s4_lcd_an_sel = {
> +       .data = &(struct clk_regmap_mux_data){
> +               .offset = CLKCTRL_VIID_CLK_DIV,
> +               .mask = 0x1,
> +               .shift = 11,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "lcd_an_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_vclk_div6.hw,
> +                       &s4_vclk_div12.hw,
> +               },
> +               .num_parents = 2,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_regmap s4_lcd_an_ph2 = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = CLKCTRL_VID_CLK_CTRL2,
> +               .bit_idx = 7,
> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "lcd_an_ph2",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_lcd_an_sel.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_regmap s4_lcd_an_ph3 = {
> +       .data = &(struct clk_regmap_gate_data){
> +               .offset = CLKCTRL_VID_CLK_CTRL2,
> +               .bit_idx = 7,


Apologies for the oversight - this should be '.bit_idx = 6'. I'll 
correct it in the next revision.


> +       },
> +       .hw.init = &(struct clk_init_data) {
> +               .name = "lcd_an_ph3",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_lcd_an_sel.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
>   /* HDMI Clocks */
>   static const struct clk_parent_data s4_hdmi_parent_data[] = {
>          { .fw_name = "xtal", },
> @@ -3174,6 +3257,165 @@ static struct clk_regmap s4_gen_clk = {
>          },
>   };
>
> +/* CVBS DAC */
> +static struct clk_regmap s4_cdac_sel = {
> +       .data = &(struct clk_regmap_mux_data) {
> +               .offset = CLKCTRL_CDAC_CLK_CTRL,
> +               .mask = 0x3,
> +               .shift = 16,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cdac_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_data = (const struct clk_parent_data []) {
> +                       { .fw_name = "xtal", },
> +                       { .fw_name = "fclk_div5" },
> +               },
> +               .num_parents = 2,
> +       },
> +};
> +
> +static struct clk_regmap s4_cdac_div = {
> +       .data = &(struct clk_regmap_div_data) {
> +               .offset = CLKCTRL_CDAC_CLK_CTRL,
> +               .shift = 0,
> +               .width = 16,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cdac_div",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_cdac_sel.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_regmap s4_cdac = {
> +       .data = &(struct clk_regmap_gate_data) {
> +               .offset = CLKCTRL_CDAC_CLK_CTRL,
> +               .bit_idx = 20,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "cdac",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_cdac_div.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_regmap s4_demod_core_sel = {
> +       .data = &(struct clk_regmap_mux_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .mask = 0x3,
> +               .shift = 9,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "demod_core_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_data = (const struct clk_parent_data []) {
> +                       { .fw_name = "xtal" },
> +                       { .fw_name = "fclk_div7" },
> +                       { .fw_name = "fclk_div4" }
> +               },
> +               .num_parents = 3,
> +       },
> +};
> +
> +static struct clk_regmap s4_demod_core_div = {
> +       .data = &(struct clk_regmap_div_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .shift = 0,
> +               .width = 7,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "demod_core_div",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_demod_core_sel.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_regmap s4_demod_core = {
> +       .data = &(struct clk_regmap_gate_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .bit_idx = 8
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "demod_core",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_demod_core_div.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +/* CVBS ADC */
> +static struct clk_regmap s4_adc_extclk_in_sel = {
> +       .data = &(struct clk_regmap_mux_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .mask = 0x7,
> +               .shift = 25,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "adc_extclk_in_sel",
> +               .ops = &clk_regmap_mux_ops,
> +               .parent_data = (const struct clk_parent_data []) {
> +                       { .fw_name = "xtal" },
> +                       { .fw_name = "fclk_div4" },
> +                       { .fw_name = "fclk_div3" },
> +                       { .fw_name = "fclk_div5" },
> +                       { .fw_name = "fclk_div7" },
> +                       { .fw_name = "mpll2" },
> +                       { .fw_name = "gp0_pll" },
> +                       { .fw_name = "hifi_pll" }
> +               },
> +               .num_parents = 8,
> +       },
> +};
> +
> +static struct clk_regmap s4_adc_extclk_in_div = {
> +       .data = &(struct clk_regmap_div_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .shift = 16,
> +               .width = 7,
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "adc_extclk_in_div",
> +               .ops = &clk_regmap_divider_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_adc_extclk_in_sel.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
> +static struct clk_regmap s4_adc_extclk_in = {
> +       .data = &(struct clk_regmap_gate_data) {
> +               .offset = CLKCTRL_DEMOD_CLK_CTRL,
> +               .bit_idx = 24
> +       },
> +       .hw.init = &(struct clk_init_data){
> +               .name = "adc_extclk_in",
> +               .ops = &clk_regmap_gate_ops,
> +               .parent_hws = (const struct clk_hw *[]) {
> +                       &s4_adc_extclk_in_div.hw
> +               },
> +               .num_parents = 1,
> +               .flags = CLK_SET_RATE_PARENT,
> +       },
> +};
> +
>   #define MESON_GATE(_name, _reg, _bit) \
>          MESON_PCLK(_name, _reg, _bit, &s4_sys_clk.hw)
>
> @@ -3453,6 +3695,20 @@ static struct clk_hw *s4_periphs_hw_clks[] = {
>          [CLKID_HDCP22_SKPCLK_SEL]       = &s4_hdcp22_skpclk_mux.hw,
>          [CLKID_HDCP22_SKPCLK_DIV]       = &s4_hdcp22_skpclk_div.hw,
>          [CLKID_HDCP22_SKPCLK]           = &s4_hdcp22_skpclk_gate.hw,
> +       [CLKID_CTS_ENCL_SEL]            = &s4_cts_encl_sel.hw,
> +       [CLKID_CTS_ENCL]                = &s4_cts_encl.hw,
> +       [CLKID_LCD_AN_SEL]              = &s4_lcd_an_sel.hw,
> +       [CLKID_LCD_AN_PH2]              = &s4_lcd_an_ph2.hw,
> +       [CLKID_LCD_AN_PH3]              = &s4_lcd_an_ph3.hw,
> +       [CLKID_CDAC_SEL]                = &s4_cdac_sel.hw,
> +       [CLKID_CDAC_DIV]                = &s4_cdac_div.hw,
> +       [CLKID_CDAC]                    = &s4_cdac.hw,
> +       [CLKID_DEMOD_CORE_SEL]          = &s4_demod_core_sel.hw,
> +       [CLKID_DEMOD_CORE_DIV]          = &s4_demod_core_div.hw,
> +       [CLKID_DEMOD_CORE]              = &s4_demod_core.hw,
> +       [CLKID_ADC_EXTCLK_IN_SEL]       = &s4_adc_extclk_in_sel.hw,
> +       [CLKID_ADC_EXTCLK_IN_DIV]       = &s4_adc_extclk_in_div.hw,
> +       [CLKID_ADC_EXTCLK_IN]           = &s4_adc_extclk_in.hw,
>   };
>
>   static const struct regmap_config clkc_regmap_config = {
>
> --
> 2.42.0
>
>

