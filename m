Return-Path: <linux-kernel+bounces-865182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8FABFC646
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A894934D66C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F7E34B416;
	Wed, 22 Oct 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="FN+A5Zdz"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023137.outbound.protection.outlook.com [52.101.127.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EECE34B402;
	Wed, 22 Oct 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142099; cv=fail; b=KdVhu5yQzSrg6X+yF+kETVS3ujZbl3yo8qONVl7GyAdJO1r4RZpMqZGv9VSC4XPa7CyyJ82gcdvfK1047mXWTjfeFOlsKju9zK5jF8LhQ1PspasEyXHnbW32pqMK/BYNWaiVaqzJFisgWs9frP5E+NxM2DbFR6iK5hcZz3Sgp70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142099; c=relaxed/simple;
	bh=VRa8dkhwMsSM1QNkbqwsQ9intJcDG6CKsWFtzLLz10w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fLIiw/dva3Vyslp2cDlBrSQzMv0jwHLmTLI+SEeS5xccQ+yA9gmydZiIgeI0yx3V6sXfuX8jLUGFrDEE1a9rUulku+nHbOXy+hqd29vbrfKbJTmw+YpGn3E3LSzrz9ksjKUFImLJjTovNPipAXX9DaYQt8GMeTTJCrKf/7Lwqlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=FN+A5Zdz; arc=fail smtp.client-ip=52.101.127.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUSP1qO5d6+Dz2ysgvMgrQtk3caBX2P3lDuDTioa78ijdVx15n/75K8LUPnZFm+J6YZsGMr87102z4VILsgjdypEU5d5jX6LcyqhtlyRC3Y0KcLAktMKcM9BNgEH6B1v7Mo6HlS018893cP8M9XcUBbpDAA5cD0qJLQEfO7rrAvL/Z1/TcEA3NxegFAxoFFI125KFW3kdVwJfKDldzP0OS53pzD4q4TM0VC/6Wtg3rYlFnfZ3B3zGNbHpjHavkkpiitmNkJb4JUw0LecO0/8EGius1osREBY6BHfCAijh74VW9K+bUjArgeugjeG/AHcYHjdK1V8leBzr0cIi+4iEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bEvHpV3yKR755FH2QqqBlJv9jNl9uBTW98Xu7ShwC0=;
 b=Hz0N8nzVlD8amCzJ+PQlXueOvp3p5s5UkQNR/GoKe8ZiANcEh1YR8qfvNL5/qZ2PRUMQoaUuTsIkAEJnO41DnDjP0pLwA2vcQPkcJBC4x8rvzZjzb1pNzqFtM9krxW31D46cG4xL9f2Xv1iiDFaztkrUGKTDDVSRvh2CPjFFS4b+RzXr0k9sRwMGORgkuSqfusWB+0eIX9u5xHbidPg3yAShcwgU4xj9i6lLe8bxeEUpi49KmbVhBooEbGFWsuLjA/M2GW6n50ptnRALNYYmkaHt5mZi2wftFxd8Or5xT3guAGTmcc1JZgTkx8MpPgkXCZdVYGDkELfJSvLey9zzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bEvHpV3yKR755FH2QqqBlJv9jNl9uBTW98Xu7ShwC0=;
 b=FN+A5Zdz5qE+CONExE77dZ7xsIqiGOvV6YhxfOOVrI1d3ZJlwy8t+enB8rztoqjr4+C08MUe4dOZ0OlDdWGJ3oFTLDPsWCO/wx5+7lCY+esQMt3mNxODwYaFmsIeAj2lG2FXPSDmvrfS+Fphz7wCRcw5z3l1q6fM6SwOIRna4c4qUJlEDZkP4hXl6gQQjWHPN7zEL5tl2gIwhvCQJahy202HIiC0A38RLM+aEUmq/PPjlZuwoJJ+ebT466lMbG+kMiWCnKsZxq6GltMuaWVwGIUydmgd1G8e9iRKvdPMy0z1ITmGulXaPu1tlvEfEWon5XqFIE8rqJB02Dh9WSM2aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by OSQPR03MB8713.apcprd03.prod.outlook.com (2603:1096:604:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:08:12 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:08:12 +0000
Message-ID: <61c2738d-7291-4a45-aa73-f18528c81ba8@amlogic.com>
Date: Wed, 22 Oct 2025 22:07:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: amlogic: Optimize PLL enable timing
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251022-optimize_pll_driver-v1-0-a275722fb6f4@amlogic.com>
 <20251022-optimize_pll_driver-v1-2-a275722fb6f4@amlogic.com>
 <1j347b403i.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1j347b403i.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::16)
 To KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|OSQPR03MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: a90824ea-ea64-4d64-b9c6-08de11746f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1RuVGxsbTBIMitIZnhhdlh4R3kwblM0MHdSWENQRnhMQ3lIL1NrTEJXQldS?=
 =?utf-8?B?bVp0VmlaRE4vS09UMmpIblpTUDBPclh1NjUvYzdPWDc3WGtnYkJWdkJOZjVK?=
 =?utf-8?B?RlNmSVEzdWlDanVXbDh0dERUQkdDUSt5MmdiMHBHTlZuemdqdnNXZ05hWnM4?=
 =?utf-8?B?M2VXSjJDUElLTWUzbTFVNG1UUThBd2JabFYveXUvbEEwTlQzR1laQy9PSHNl?=
 =?utf-8?B?bFFmenQ0ZkdsZWVGUDhSbzNBTkM5RXMxN2dqdDhKb1YyeENnNis3ZW5mTFJY?=
 =?utf-8?B?RE96elFjQmFyYjJBS3BMMTYzM3JvZHMzcHpZZGQzbHdtT2ZRa3Z2VlpWWE1v?=
 =?utf-8?B?dFZLQ2V5MFlzbXBUTTVmcllERUpoYWZpWndWNmFrOXJ5TVlSOGg0aTVXd3lk?=
 =?utf-8?B?Zzd4UVZFZEFpczZZZlg2eXpIdU5qdjJzZVhWRExuUTZQRTNCMFNVNW15ek1l?=
 =?utf-8?B?NjY3aDZXZVlMQmlSNW9seDVaT29Vb1BGR2RodkpvdDROYitYdzlMMHBGWU43?=
 =?utf-8?B?dmVKaUVPYU9DV2wrTlBnNVpmcldVaEk5UCsrWUFpY3Z2V2NEM1F1YjJaanYx?=
 =?utf-8?B?Y3l0cUk0VGVvUHgvOWN0azdsL2FmT0FKOG8yQlp5WEgrRWRETWZ2SlM4UENt?=
 =?utf-8?B?WTNpUTl5STQxSnN6S2wzYTdVcTA5RlhOK2p2aWRFMnhtZWhiRjNLR1BaQkNt?=
 =?utf-8?B?MjY5ZFpjMStEMWlWekdhS0N3VFVkT3lqRnBSNHFVZUNidTlCcW5GYmQralpE?=
 =?utf-8?B?QmdqbVg4NGlRNFBPQWloWUxNZXJRMkRvT0ZLQWJOdzBKaDduZE9wS1dVbHRS?=
 =?utf-8?B?K2RxN0NQaWF1Qi9KSEc4dVBoVzZRd0ZibXE5TjFJbXRKanh0S0R5NnlhUDFV?=
 =?utf-8?B?MjZkMW5SbWFLcDV6bm5SenZMN0xFYW9jb0FzUGdBZndKNnBDREQ4WTh6NHM3?=
 =?utf-8?B?UmYybkx6MzVqTTZ5bVFNTHlQQWo2MlpiZitDZ05KMkNGYThoZVQ1T09sMlJC?=
 =?utf-8?B?RjZnZDc0ZFZUangyaVRPVk9ncVRoS1BHZkwzMHhVOTJRVSthWUwxZTA0K0hv?=
 =?utf-8?B?SUd4YjV4Kzd5TnR0OFpUVFFmdjU1dkl2VHVzQThYUnJ3aWlMQ0ZSZDZrTERO?=
 =?utf-8?B?dk85TldJamFGRDM4aloxckZxUUVYMWFRMm5adnVVVkc2VHNVRjVZa2pyQmp3?=
 =?utf-8?B?UVRJNWlnVGllbU0wQ2wwM2p2L3VsaUpmL2NtOXVraThkVU5oQ0lBd1dRNVpT?=
 =?utf-8?B?eGtDRWlCUXorSmluditONWhCaE9nOEF4cHJnZUI4VFZRYzZuYUNZai83VVRo?=
 =?utf-8?B?SXR0Z0NuUy85L29Rd1d0NmVjeVVhNHdvTVdINVpZUmRkcjUrOGVDU0w1TE05?=
 =?utf-8?B?VWFscmlGRjl4UmZzM09xYVptclJrR3Q5N3lwZGF4WmlKelBWYnFaV29hRFJL?=
 =?utf-8?B?cm5OWkQvMWFFVU5JZEtLMTZFZTlrZVQzUVNSNFlZbjJRd21SenNUTDZUUXJS?=
 =?utf-8?B?dFBsTFVrU2FaUnBXeFVGQzBLd0c1aldVeVJvZzZWN2FQMmY5RHFoakE3TEtS?=
 =?utf-8?B?QmtScEpuQjNDVTNieVlYL1JRMm9qM25DZnJZWktkSmJId1NzTG9qdE5makRZ?=
 =?utf-8?B?dUJkR1JPaXAybG1PQ3Q3M2NXcWRyU3JCRXdvaTJXZTE3QnNPaCtPNEdrRHBl?=
 =?utf-8?B?d2ZxQkhnRW0wM2tNNDRaZFU5RzRkb2h1czhpbWRiZ1QvR2JiMGMvVmxqTEdv?=
 =?utf-8?B?eC9mbm4yVFZvNmVUNnY4RGxGNndaOWlSV1lMYitTei9oTHdYU3p2UHRrMXA5?=
 =?utf-8?B?OU50L2V3a1h3V3lhWFY5R2ZXVm1FajZvelc3c0l2STJYNU1nTEk0MVNGclV0?=
 =?utf-8?B?ZlQxVDBLaEN2RXNydi95SFNpRDVhVXFtT3o1NGtYZTAzODFPMVFVWTZPeHgz?=
 =?utf-8?Q?bFZKLIJ24Gmvj6ignvcxHV54/pau0D6e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVJhQ0lCM1pteDJmUDhEN2FHYVFLczJDcUlBeXJQTkUrd0hoQ3VRTC9uaWxh?=
 =?utf-8?B?UW5IRUl5NTMvSEZSMjBjcGYwYUQ3V3c2eHZBYkpBamZzNXR3WkxnL3F0VEZP?=
 =?utf-8?B?NGFieHUySmhZRFRkZ1NScTMwWEdKekNzcUFiNkJDRTgybEVoeXlrYnVURDZR?=
 =?utf-8?B?NFJtL09NTkZxeHgvejdSam5jSDkrZ2tJYWlNTEhDYWIyd3B6b0JpSWxQdHZY?=
 =?utf-8?B?dWdUQ0xWL0ZWSFV4UkI0QXl0SzFUKzVlRTNoNTc1Rk12NStsTmFPQzBoYUVE?=
 =?utf-8?B?aVJaVUlTMkNSZDRVKzEvKys1K0k1ampjazNLcjVtWnllRWp4eTZ4TUZ1MWFU?=
 =?utf-8?B?L0RzUEVIdE1lRjRkVVM2SmpSWVVjYjI3b3puRmJLeW9UTTQ5cWQ3RXlMOEhv?=
 =?utf-8?B?dlZMT0pXNGkzbDNyM2tJZU1hYk4xTGorQVVmMElPSkJJbUVoYVRYVWVDMUpr?=
 =?utf-8?B?SWd0M1ZLVWVYc2V2SUgzTFNwdVZGOGtmd3NQSVlhSUw3YThKMGhvT3JhOFVV?=
 =?utf-8?B?R2hla3RIL0sxZXlQeTM3OHd4QXo3anV4bUxnbmFCbWlNTGswK3lxVzRaWXc4?=
 =?utf-8?B?ZThqWGtRdkpUdDZRR29PQS8ybzlWQ1F0dm40NkUwQlB2Z0drbzFlazFDZjlB?=
 =?utf-8?B?K1lmRjBlMFVaZGdMQlRHSU9HWGwxQ0EzQ0ZCVDZJT1VwdnVxOVQ0QmJyc0ph?=
 =?utf-8?B?OWZqWWJNaE5DSEV5SjVaRGYzcjFkZHQ5OFQ5cUVZOXdoOUoxeUtwMzVacXpi?=
 =?utf-8?B?clI0Qk5vQ2wySzhtY0NBVnJvTDlCTll1eGZFR2lXZjNlYTMyOVJLcTErUkQr?=
 =?utf-8?B?MUQraXdwSFFIWGU0NGMyRVF4clBLR25iczlsSHhpRDZza2d6NWh1WUY1dEZ1?=
 =?utf-8?B?VDdlK2RqSGdjYS9hZzFWSnlPRytFNWhoVWtuamlEU0hWYnNPNlpZb0pRVmdu?=
 =?utf-8?B?MmV1S3BiOFNxZ1NtalRPRTUvTXhod1BUQk5GTXlsL0IzMW0rYmVOMmlLQ1N4?=
 =?utf-8?B?RTRic3BRS0FoQWRRa0UyOEtXczRHcXhQT1NNNUVrZmFzR25FeW9sS3M4LzZY?=
 =?utf-8?B?NS9YdVQzeWpYRGhNODBFRjA4WW9ZaTRaVE9nNmNqM1F1Y0NpNmx5M1FLakkw?=
 =?utf-8?B?dGl2cmZrejlXRmprYURYSGxYM1BnV1BaK2xIMmt0RE1vbE9oME5OUVBRNzYz?=
 =?utf-8?B?czNldlJVZkRnUnZBdDF6MUl4VDRyMUdDcEI1ejZnOHppR2ZJT29vS3A4eWs0?=
 =?utf-8?B?Sk5OS3d5YlhpeU1WaTdxaGFFdGRPZXYwcFFWU3dYdGYxWmVQU0RNdUZlYjVP?=
 =?utf-8?B?K3F5UjRPSkQ4K2RVTXBkUCtTdVByTjR0S0JQQ25ZOEhFakRESkRVMHhhRVFS?=
 =?utf-8?B?ZW1tNldkNmRkQm1sZEQ4a0kvQkJxNk8wbjJVRTBSQ3hLUzBZNkk2bkxXVmlH?=
 =?utf-8?B?VmNLZWdhakRUQUZiKytCUlVvbGhLamY3Q3Y4SFVOSHpEcFdWL0ExWEZSWG53?=
 =?utf-8?B?Y2s2UmJlUjRFb1hTUFE0S3ExYXRZaFVMU1E3MUtyRnh0VnhTVlNzaFRsWVY5?=
 =?utf-8?B?NjN1T0ZJZkZHSkt3RG8vZFlIZUhGMzNnbnorQ1NBalhSWW5pOExmTG5GdFlk?=
 =?utf-8?B?aGVNbjVxeFFwWnVIOXVVTGJTQ3pNRkdmUTdlZkphUit6OWlMbEVydnBsUUdu?=
 =?utf-8?B?L0ZaZlYrV1J3dE8vd3JUcGZ5Z3N6elV6eXBycVZuQkw2cjJKcHgxUHlVR3Ir?=
 =?utf-8?B?VVk5R2gzZzlVaXZ2MURoVG1adWk4SUVIUWdDTU9YNDVtYWNKOFZqMGZFelNo?=
 =?utf-8?B?U09BZGJmWHhWaUNwb1VrWXhPVWVFdGVieGNVcHU1alRxZkVVdSs3OEhFK1VH?=
 =?utf-8?B?cmREeDU2ODdTcGtIV0lpSkROeDh3UnNuWnhvUTF2dmRsODVPNHFoYUtIMjBU?=
 =?utf-8?B?S2FKVmdrclB0aGxZY2hQL0RYVytaR09MRlVsNTFiVzVpWU9hT3RXa0Z2Nm1T?=
 =?utf-8?B?bGkrWGJSblFoZldqNEJBRmtKc3YzQTE2NEtBWGdHbnM1SFpPdi8yQWJXa0pw?=
 =?utf-8?B?T1pRUXYzSmdWSVExbTFXRWhLcU5uRGdPaitlZWI0SGFiZHRyd1dHK3h6aEVM?=
 =?utf-8?Q?gPV6Sq04H4qSdcL7/qgXbUKQv?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90824ea-ea64-4d64-b9c6-08de11746f9b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:08:12.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDAYPFmM9C6a0exscn6b/EHtmbAPU3KWuVE/Kkbf74h61xdhNXSYqbZbUkSJoveX20D5URlTQiwsBxq0xIjZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8713

Hi Jerome,


On 10/22/2025 8:01 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed 22 Oct 2025 at 14:58, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
> 
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> Amlogic PLL locking procedure shall follow this timing sequence:
>> 1 Assert reset signal: Ensures PLL circuits enter known initial state.
>> 2 Deassert lock-detect signal: Avoid lock signal false triggering.
>> 3 Assert enable signal: Powers up PLL supply.
>> 4 udelay(20): Wait for Bandgap and LDO to power up and stabilize.
>> 5 Enable self-adaptation current module (Optional).
>> 6 Deassert reset signal: Releases PLL to begin normal operation.
>> 7 udelay(20): Wait for PLL loop stabilization.
>> 8 Assert lock-detect signal: lock detection circuit starts to work.
>> 9 Monitor lock status signal: Wait for PLL lock completion.
>> 10 If the PLL fails to lock, it should be disabled, This makes the
>> logic more complete, and also helps save unnecessary power consumption
>> when the PLL is malfunctioning.
> 
> Is this applicable to all supported SoC ? from meson8 to s4 ?

Yes.

> 
> What did you test ?

We have tested this on the G12A and later SoCs without any issues.
Internally, we have adopted this configuration sequence in our branch
and verified it on a large number of SoCs.

We haven't maintained the meson series for a while, so it hasn't been
included in our recent validation. I also don't have any meson boards
on hand. If you have one available, it would be appreciated if you
could help verify this, Thanks.

This PLL sequence adjustment for meson SoCs adds a 20us delay after
enabling the PLL and after releasing its reset. The delay addresses
rare PLL lock failures observed under low temperatures. As a result,
it slightly increases enable time but improves stability.

> 
> 
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>>   drivers/clk/meson/clk-pll.c | 68 ++++++++++++++++++++++++++-------------------
>>   1 file changed, 40 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>> index b07e1eb19d12..26c83db487e8 100644
>> --- a/drivers/clk/meson/clk-pll.c
>> +++ b/drivers/clk/meson/clk-pll.c
>> @@ -353,6 +353,23 @@ static int meson_clk_pcie_pll_enable(struct clk_hw *hw)
>>        return -EIO;
>>   }
>>
>> +static void meson_clk_pll_disable(struct clk_hw *hw)
>> +{
>> +     struct clk_regmap *clk = to_clk_regmap(hw);
>> +     struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>> +
>> +     /* Put the pll is in reset */
>> +     if (MESON_PARM_APPLICABLE(&pll->rst))
>> +             meson_parm_write(clk->map, &pll->rst, 1);
>> +
>> +     /* Disable the pll */
>> +     meson_parm_write(clk->map, &pll->en, 0);
>> +
>> +     /* Disable PLL internal self-adaption current module */
>> +     if (MESON_PARM_APPLICABLE(&pll->current_en))
>> +             meson_parm_write(clk->map, &pll->current_en, 0);
>> +}
> 
> I don't get why you moved that code around and make the diff even harder
> to read

Sorry about the misaligned formatting. I moved meson_clk_pll_disable()
earlier in the code because I added handling for PLL lock failures,
which unintentionally broke the alignment.

I'll split the PLL lock failure handling into a separate patch in the
next version to make review easier.

> 
>> +
>>   static int meson_clk_pll_enable(struct clk_hw *hw)
>>   {
>>        struct clk_regmap *clk = to_clk_regmap(hw);
>> @@ -366,53 +383,48 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>        if (MESON_PARM_APPLICABLE(&pll->rst))
>>                meson_parm_write(clk->map, &pll->rst, 1);
>>
>> +     /* Disable the PLL lock-detect module */
>> +     if (MESON_PARM_APPLICABLE(&pll->l_detect))
>> +             meson_parm_write(clk->map, &pll->l_detect, 1);
>> +
>>        /* Enable the pll */
>>        meson_parm_write(clk->map, &pll->en, 1);
>> -
>> -     /* Take the pll out reset */
>> -     if (MESON_PARM_APPLICABLE(&pll->rst))
>> -             meson_parm_write(clk->map, &pll->rst, 0);
>> +     /* Wait for Bandgap and LDO to power up and stabilize */
>> +     udelay(20);
>>
>>        /*
>>         * Compared with the previous SoCs, self-adaption current module
>>         * is newly added for A1, keep the new power-on sequence to enable the
>>         * PLL. The sequence is:
>> -      * 1. enable the pll, delay for 10us
>> +      * 1. enable the pll, ensure a minimum delay of 10μs
>>         * 2. enable the pll self-adaption current module, delay for 40us
>>         * 3. enable the lock detect module
>>         */
>>        if (MESON_PARM_APPLICABLE(&pll->current_en)) {
>> -             udelay(10);
>>                meson_parm_write(clk->map, &pll->current_en, 1);
>> -             udelay(40);
>> -     }
>> -
>> -     if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
>> -             meson_parm_write(clk->map, &pll->l_detect, 1);
>> -             meson_parm_write(clk->map, &pll->l_detect, 0);
>> +             udelay(20);
>>        }
>>
>> -     if (meson_clk_pll_wait_lock(hw))
>> -             return -EIO;
>> +     /* Take the pll out reset */
>> +     if (MESON_PARM_APPLICABLE(&pll->rst))
>> +             meson_parm_write(clk->map, &pll->rst, 0);
>>
>> -     return 0;
>> -}
>> +     /* Wait for PLL loop stabilization */
>> +     udelay(20);
>>
>> -static void meson_clk_pll_disable(struct clk_hw *hw)
>> -{
>> -     struct clk_regmap *clk = to_clk_regmap(hw);
>> -     struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>> +     /* Enable the lock-detect module */
>> +     if (MESON_PARM_APPLICABLE(&pll->l_detect))
>> +             meson_parm_write(clk->map, &pll->l_detect, 0);
>>
>> -     /* Put the pll is in reset */
>> -     if (MESON_PARM_APPLICABLE(&pll->rst))
>> -             meson_parm_write(clk->map, &pll->rst, 1);
>> +     if (meson_clk_pll_wait_lock(hw)) {
>> +             /* disable PLL when PLL lock failed. */
>> +             meson_clk_pll_disable(hw);
>> +             pr_warn("%s: PLL lock failed!!!\n", clk_hw_get_name(hw));
>>
>> -     /* Disable the pll */
>> -     meson_parm_write(clk->map, &pll->en, 0);
>> +             return -EIO;
>> +     }
>>
>> -     /* Disable PLL internal self-adaption current module */
>> -     if (MESON_PARM_APPLICABLE(&pll->current_en))
>> -             meson_parm_write(clk->map, &pll->current_en, 0);
>> +     return 0;
>>   }
>>
>>   static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> 
> --
> Jerome


