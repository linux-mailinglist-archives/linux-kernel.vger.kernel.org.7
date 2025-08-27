Return-Path: <linux-kernel+bounces-787612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7702B37891
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0E168682C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A402045B7;
	Wed, 27 Aug 2025 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="GB//F0Yo"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023085.outbound.protection.outlook.com [52.101.127.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032092AD04;
	Wed, 27 Aug 2025 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756265444; cv=fail; b=C9rNjCA3dLPF1pNOcl9cI2TAhaalwJfhQmE3t2AF/rmDQc5ofoTdJjFeJu+Q+RZ1yy9hnbNJR3ygHqHv+SI/BX4jxvewG1dAqGQ2i2iz9xSxiwNsWLqFF5+PMyQzFRq/YIiN7W5bljyVO5XlcwTBTcKWCFFrdlvfPCyXRCd2WhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756265444; c=relaxed/simple;
	bh=60syY7I+QcT8mkztaJ0gy9ElINpm1EzK2CVbdv1i8eE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQt8Y6St8zr3ALDDuhl7MJ/6ROoxQxpcHrMo09zAZDvao5daUc+za3su9WWzbFTI52B66bK6s3qypDFX15TlKm7nqYAQWQrzSpMh0x6U/v4sKxkmEy+ohRzCov253CHzphYuogfoJ9J5v4MGud61zRgxmMj1vqRcqlOlSqI+JHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=GB//F0Yo; arc=fail smtp.client-ip=52.101.127.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axIHXfVw33qyKjVS28iKUb7GbjxucwTDVHAd0nkWz7Ng71iAYyz/vkID4p1qrJRKCP4em4UrEueifv4t/cANNygxr+d/flRazC+ZOzmWDqnLF2XEkw01ycailYHBXOWMrIePmq1I6GU3ffSgYbYXL8iJx3npxYgG9w9JzJnVrOlQAHG3SXMk5LHOQGKi0dhcPY1nrDt5Sjmy6AeGH7ObwdSpQqakHcvOPuiAxa/6sW1dvcXvBm2hdwKAwZnG0Yn6wLGjg3fLd9pdbcEYBJKwRvaO0+ujLGyG4MB8X1OI39TBXDYr79GfcmWgq1/a10cZd+Jebz3PKBW/q1jj24g1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+kmzeSfTmlnIJWXyJ9/yt9TqO2koIktUZEVzGDu4EE=;
 b=KahoGTdEKenaaEHNclkrRZsxxunSxHmN/459EzOCjbbT+QIPBovIlmvRVR9PSd+RG9MYmjExJRtIW1Hv6BIQ0NCn6rCqNgJDVnyrDXTwTzYAaJ/H78rPeQA16aopSCQ4JPECycFYX/p/T6lsnKQVHOdgAlG627r6xq+0Tf79lcqpl9CZGrnuZY7hdSnl5x8cdzWFlZOZhaMCkU/y8wpBn5riPgCuewnt/3stssTrJDUS0wI491CRWyUh46pJhIL0X0jP2qhr1UmgFusLsN/FePybbdktH5baKnWAOb/Dg4CmxjQ7HyHZLzBcc4I1ezHQsUVqD065TAB/9BFhk44yiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+kmzeSfTmlnIJWXyJ9/yt9TqO2koIktUZEVzGDu4EE=;
 b=GB//F0YoubIo7C1fSUSJ7BMMsLCa54Aj1MMvwxFMyocpJofduElmKkBKV1gQHvuLy1OenRlU0mwKQbItMrr51CKkmgbJ2Fjsi47JiA7gvcHFVH3uypoU4OVK/6OVDVOt7dsMNJfVgkH3Hr8INoYwqBoxQCfh0FMsTl+e6h+k3+pTTbYOYL8AOjf8b34fRXVMmDaaaKT4+4affYonp1+U5LUqbFfi3onlaprw0UskouCkivMBXH8DJlEHDz5VrNyrnLZqkVlMG6qYisFz3J6P9g5EVNtioPhyAK6iz73OoQ8nPygL8EHAB3H/NBiVdNbx04lPiGmFQ+r4GfseUgOmPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEZPR03MB6960.apcprd03.prod.outlook.com (2603:1096:101:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 27 Aug
 2025 03:30:35 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%4]) with mapi id 15.20.9052.013; Wed, 27 Aug 2025
 03:30:35 +0000
Message-ID: <e9d65b1d-912d-442a-bac1-4284bef72083@amlogic.com>
Date: Wed, 27 Aug 2025 11:29:52 +0800
User-Agent: Mozilla Thunderbird
From: Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH v2] clk: meson-g12a: fix bit range for fixed sys and hifi
 pll
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Da Xue <da@libre.computer>, Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250822002203.1979235-1-da@libre.computer>
 <c0e8cf9a-b5c7-4369-8b6a-c4f80a6bc398@amlogic.com>
 <1jy0r64fcr.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jy0r64fcr.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEZPR03MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 423a4945-e554-4712-9e06-08dde51a156b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2VCL0RPc0E3MGNYOWhGQiszYlJQeDNNL3ZJTUI5Ri9kaDI3K3hjd0dOZFBY?=
 =?utf-8?B?RUNETzREeUtxbDJBQm5ZMzB6bFhXTjJHbXVIRTFWRVMyYWhEZEFuOHozVlVh?=
 =?utf-8?B?U3lxUnErQktTTW1IaFJJWUtQMGVUWkhWRU1rVlNneEk1QmJ2MmJrcnVJZUlU?=
 =?utf-8?B?VHUrcHExbTMzL3h1bWFVeW9ybjJLbXdDUFQ3STg0dlJaQUJUQkpObDJqMWlQ?=
 =?utf-8?B?eXFmdGRvVCtycTZ4WUNPVTBERHlaNWlMaEF1YXBURHhIRi9OYnNBcndFalFM?=
 =?utf-8?B?Q2RMR1IvWUY1dVZpWTBBTE1UNExObnBtKzZQVElVcHdBaFdITUFXY3ZhM1Ni?=
 =?utf-8?B?SmxSbHJqYXJwdi9mUk5mZnVoMU5iL3ZsZnpKZ2RUWDNDSDg4aEJTbncrOVE5?=
 =?utf-8?B?MVFMczJ0b2JDb1N0aXk5S2szYjdBdG5xSDNBRGkxaURzK1VqSnpTM1g4cnUx?=
 =?utf-8?B?bkVkbWNYbTRSeUt6dkxURGJmZ0N2TTJTMmxpVlcramdOZkEwdmlHbWlnNzNO?=
 =?utf-8?B?ZkNKRTlpYVZYNmFZU2x0NUhlYWRzQ0VJbnAzQlBQUnZUWVhPblFDb0xZd2w3?=
 =?utf-8?B?bWJoVTF5MDFIaHV6Q1p5bGU0djRGSjhUK3hIaVNwNGtvUThqM0REYjMzbEtQ?=
 =?utf-8?B?c1diaGtoM2NZZG40MVovQ0l2eTlkaGo4bkFvSDcyZWJ5RFRWdmVURXUvSENr?=
 =?utf-8?B?eTB2dmtHd0k2Z05vcTFQMDdRRkQ2OFl4MExrS0tTNHhNZWtJWEFSNEh3QkNi?=
 =?utf-8?B?dHRzS1FDT1NGVTE2aFdqYlN2M0M2alJ3b01USkhueTNtY2NITFdUSm90UndW?=
 =?utf-8?B?eCtURDliOGJCK1VIaW9WMVNQTC9rMG9udnJVMzBIem13VGxZQmtMOVBMdmlm?=
 =?utf-8?B?K2M0RXlEQ1ZhWThSK0E2OXdsdmtQbzVZalV2T01XOGtzSmxTcFNxVWl6eEdT?=
 =?utf-8?B?UXFoVDhrSGhkVklveko4SEZ2MUowRkxVM2hpTFFTM2p2ZEpBelBZellyRkgx?=
 =?utf-8?B?THo3bFZneS9OQzAyMWVOQ1BsQmx2MXRINktQWm1iQlBCeVg0SkFFZC9uYVBW?=
 =?utf-8?B?eVNuL0c0YXc2L0dkQ0tjSnBrS2toQkJkbm80cStkRHlIYUNTR1pSbmNwNk5n?=
 =?utf-8?B?UUw3OTlkNE44QXVHbGpnenZKTWhMYWxSUG5qazZNSHlXWDRtb1F3TTRJVHlR?=
 =?utf-8?B?TDhXcWZVSERYTGZSU3dDcUpJSU9RU01KQVFlSGtJWGNVT3kyNmkxYUlNcE01?=
 =?utf-8?B?alRlRFlBU2s2cVdqNHo2UHFsZDVoQlZKVmcyck1HT21RMXVtSjZmR0xFK1Ax?=
 =?utf-8?B?ODF3RjB2V3ZRNk9DQzlOclRLeGcxeXc0MFk5YWk3aUtocnB6RlEraGFqeTMw?=
 =?utf-8?B?TWRtZ3VpR3NRTEdXVE1SL3B0aW5OUDNuMGJFOVVtQ2RsS2c3UUdXRENlaFkr?=
 =?utf-8?B?S2ozM1RzY2NHZlZhd3NHY3VCdGNTRm1sa09GOHNtZDNYUk1CSzU2UnlPb2Vv?=
 =?utf-8?B?ZG9ua2RLM3ljSHVpMGVuVGhEclA2ejJtMnNsM3g3a25uYVlQOGNmTk90QWdT?=
 =?utf-8?B?MVZZVTZpRnJsZkMwa21GUUh4NlZMZnZPUTlmcUQ4NUQ3eWpQRWVyclZZdGJk?=
 =?utf-8?B?V0l4NExidVl1c0hIaEVhcmY3WGx0TVFralBjMWE3WitZZVEraDFmeEVEdVcz?=
 =?utf-8?B?NHRZN1NTQyt6K3JuSGtXM1NzckhqTVJmU3QwMmdsa1JHcDFDem9nSm5xMHYv?=
 =?utf-8?B?L1Y2Yy85cGRsVXkrSUhHZHkzTlJsbVR6YkI5cUtLdkNOUDQ0QkVLbTZOcG0w?=
 =?utf-8?B?UUxoOEJqc0RUOGtQVk9mU2pmb3VnSitURkhVcjZUeXFUeW9TNVkzVWVPcVhp?=
 =?utf-8?B?L3o4YzhpaHQyMWhGRGJKTCtNV0NIbkkvNzVxYU5QOFVqeUdFdWliRnVsTHBU?=
 =?utf-8?Q?W4UDl884vRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1FwVzA1cUVibEF5NmlEZk1BK3IzcytMT3dlK045UzRUNDJicEhBY3BmR0lL?=
 =?utf-8?B?YTFJdkl2UXVWdjU4bE9MWGtDbXkzSlE4d2ZsczN5dGxoS1ptU1g0elYwVDFI?=
 =?utf-8?B?QzZMaU53MFZ1VCtoUHlnMnhQY2I5REFtcU5kcVpFTjlOUXlvOHIyWGwzazRI?=
 =?utf-8?B?UmV0cFRPbEd4dW5xcm42L3Q5MVNheUNZb0xlVnZkYVlmZEtzb25hL0FSblB6?=
 =?utf-8?B?ejRnL0crZ3luTWVMdEtuckJ2Qks5eTVTK2pwQzAyeXNFUklGODBPdTU5V2Zt?=
 =?utf-8?B?TlY1UzhhcVhmWHRZVFpwdkkxMzV4RFErdjlQZEdTMFFmSjRwQUwzTjJnMVdy?=
 =?utf-8?B?RnkxcXI5NmJyKzFIdlNHdzd3aUQ2Y1ptcmFOdFFkVVJVRlFFOXp2VVgwY3Rs?=
 =?utf-8?B?ZkpwdGpHSE1vU3FQb3dpbmhWVTEySTZRTzlQazFBNnZ0OGNCR2xkRGIxaTlq?=
 =?utf-8?B?N3F3cFVhTFE0UW5uUmxMOTN4VmRXbFFwZWEweitCZlpGT2YvY3NKckFMM2Rs?=
 =?utf-8?B?MDJpQ2txY3FPOWFYLzRXcncxZmozZkhCczhQY1lLOUtqNlBvdUdtdnhnTjhF?=
 =?utf-8?B?emJ0R040UlYxbkJIcGpVeUhYd3I4UnNoaUtuWW5XUzNMZmpuU1J1dWNkMThz?=
 =?utf-8?B?WEFUMUMyVVNhZmhreWVjWm5GczZCNmtsWUxtaDhCNnJQQ1dWdEdqcGJTMllv?=
 =?utf-8?B?aVNGb085Kyt1NmhRclYxa2xoYzNSUmJBejF5clFrejZhQUhRSzJ5OFZTZnhw?=
 =?utf-8?B?aUQ5V2JRNlRxTXY2NmdCMFo3T3ZlczVlSWpQY1dheHhoOVk1MWN0M3JHS0Rv?=
 =?utf-8?B?Sm9INmVGWTFTUVc5b2dFNUdTZGMvWjRFc1lldFZwWi9GUU9JWDkzOFd2RHFH?=
 =?utf-8?B?LzFzU1NoNG1MdkJDQzZMN3I3S2UzOEpjWVFCM0hyblhaSVdTamhUdUo0VlhO?=
 =?utf-8?B?SVBtZFlUaHZwU1pjeUk0b1F3bGNUczZFS2cvSUJoNWJlR0Fza1hNTEVmczVS?=
 =?utf-8?B?clpzWWxTUWNPZkt4UDBsK3FwOXFJYU1Gem9NajZpQ00rK3RZMTNsT0xYV0VM?=
 =?utf-8?B?MnY5cnEvRkF5NGdiRm1KOU5qL0lyRWw0aGRESDdDTmZodnFaRVhMR2prb0Rl?=
 =?utf-8?B?Y09rck4rRThxN1FIajNzbjVWN2FSRGlyT1g5Z3RLZHl5Z3F1TVdKVnVvYlc1?=
 =?utf-8?B?UEg5bERYRmJuQzJBbUxNYVlPeTF4SktOdG0yS0ZQSGU4SHhZSk9hSENOMjFK?=
 =?utf-8?B?bnkrSXErcnlWcWxQRXNCZEJPQ1FVY1FHVS9ENUt4bFgzQlpMRHVVMTdKRjl1?=
 =?utf-8?B?eW04K1crcGhvU2JKRGFIRHpiZkxlNFVFNEhYU1d3NVhsSjVvR3lhRTdLOTJ2?=
 =?utf-8?B?dklTMVZRYUFKYy80Q1o3MFZJbU1UUkNKbDNPZEVjZ2pGeTI0YkNFckpvV1Mv?=
 =?utf-8?B?ZUo2QjlTdlErclF4ZUpmalpTcnZobGltWVBlVC9UUWkxWFkzdG1vNUVaYTUw?=
 =?utf-8?B?cTBUWHBxckV3dHNqUUlXTWEyREdwY0dXcElLRWRDbUZ4YVI0OTdMOGRMODJz?=
 =?utf-8?B?VC9SMU5KMjkzazhheUJGY2x2djVabmRRZVQ5TUhma20yekkveUhaVjJ2dlY4?=
 =?utf-8?B?ZlBBdC91ZlY1cGhCTTRaU3BUbW9jbGUyOUF0Zy9BcmgxVnZ2WEVWYk4yQms0?=
 =?utf-8?B?Q2NkSUh1aUZwVGlubmd4Vnd1SjMzclV6OElwdUVHaHg1eUhzNlA2NlMvV0cz?=
 =?utf-8?B?dTdtSUhvNVVSdTRDcXcraWg4alZNa3c5YTQwY00rWnp5ckNrYjI5elZwRGN4?=
 =?utf-8?B?MHlJT0ZJRzhiK2NnTUd4dXR5aFBFTEV1MkRiSkRFVVk1MlNLWnluc1Z4M1BB?=
 =?utf-8?B?a05ycTJIWERCU1Y2elpsU1NIWTdTRXc0aVVKUzV0WEJLQXJSTm1hZmo0My9C?=
 =?utf-8?B?SDlpRXNPRk5rKzd0T05EYW5LNjk4cm15bFIreEU2WVh2WWtRdEZTT1JOVzlL?=
 =?utf-8?B?WnF5aXV3UmZBMmY2YnNMcEtLZ2ZJek1iNXMzL3ZsSmhVSXl2Y1NxaWZXK0l3?=
 =?utf-8?B?d29VQ2N6WlZxSzBSVG03S2doblpjSmpiamJFZHNKalBaa1VLUWZyRDF0eW5V?=
 =?utf-8?Q?19FmdiVuKttY/CmBurX86YLU/?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423a4945-e554-4712-9e06-08dde51a156b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:30:34.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdgvB0qQqvyQ2zbpb5Lttl0GDhpUMoZ/UTzgJ6HMRosp7Z3YlhReSPZv8kJZh+h+tro+JROeABcB4TaeBzpSYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6960

Hi Jerome:


On 8/26/2025 5:11 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Tue 26 Aug 2025 at 15:59, Chuan Liu<chuan.liu@amlogic.com> wrote:
>
>> Hi Da:
>>
>>      Thanks for your feedback. but this patch is wrong.
>>
>>
>> On 8/22/2025 8:22 AM, Da Xue wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> The bit range 17:0 does not match the datasheet for A311D / S905D3.
>>> Change the bit range to 18:0 for FIX and HIFI PLLs to match datasheet.
>> The upper 2 bits (bit18, bit17) of the frac were deprecated long ago.
> deprecated ? that is really confusing
>
> That seems to imply that it does have an effect but you are choosing not
> to use it. Please clarify.


After investigating the historical context of this issue, the original
design intent for frac[18:0] was as follows:

Bit [18]: Configure the sign for fractional multiplication:
0 → The fractional parameter configured in bits [17:0] is positive:
     fout = 24M * (m + frac / frac_max) / n
1 → The fractional parameter configured in bits [17:0] is negative:
     fout = 24M * (m - frac / frac_max) / n

Bits [17:0]: Fractional multiplier parameter, where:
bit[17] - bit[0] = 1/2^0 + 1/2^1 + ... + 1/2^17

However, the functionality of both bit [18] and bit [17] could be
replaced by simply adjusting the integer ‘m’ value. Moreover, actual
testing revealed that these bits did not perform as expected.
Consequently, this feature was eventually deprecated.


>> The actual effective bit field for frac is bit[16:0]. However, the
>> corresponding datasheet has not been updated. I will provide feedback
>> and update the datasheet accordingly.
>>
> What about bit 17 and 18 then ? does it have any effect at all ?


The functionality of these two bits is deprecated, please ignore it.


>>> The frac field is missing for sys pll so add that as well.
>> PLLs with frac support are used in scenarios requiring a wide range
>> of output frequencies (e.g., audio/video applications).
>>
>> Since sys_pll is dedicated to clocking the CPU and does not require
>> such frequency versatility, it does not support fractional frequency
>> multiplication.
> You are mixing "HW support" and "usage choice" here.


Alright, the previous explanation may have caused some misunderstanding.
The actual intent was to explain why the SYS PLL does not support frac.


>
> What I read is :
> * Da says the SYS PLL does have HW support for the frac parameter
> * Amlogic does not see the point of using it since the CPU does not
>    require fine tuning of the rate.
>
> Is that correct ? or is the HW just no present ?


The SYS PLL HW does not present frac functionality.


>>> Patched:
>>>
>>> + sudo cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq \
>>> /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
>>> 996999
>>> 500000
>>> + sudo cat /sys/kernel/debug/meson-clk-msr/measure_summary
>>> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>>>    hifi_pll                      0    +/-1562Hz
>>>    sys_pll_div16                 0    +/-1562Hz
>>>    sys_pll_cpub_div16            0    +/-1562Hz
>>> + sudo cat /sys/kernel/debug/clk/clk_summary
>>> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>>>       hifi_pll_dco                     0       0        0        0
>>>          hifi_pll                      0       0        0        0
>>>       sys_pll_dco                      1       1        0        3999999985
>>>          sys_pll                       0       0        0        499999999
>>>             sys_pll_div16_en           0       0        0        499999999
>>>                sys_pll_div16           0       0        0        31249999
>>>       fixed_pll_dco                    1       1        1        3987999985
>>>          fixed_pll                     3       3        1        1993999993
>>>
>>> Unpatch:
>>>
>>> + sudo cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq \
>>> /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
>>> 1000000
>>> 500000
>>> + sudo cat /sys/kernel/debug/meson-clk-msr/measure_summary
>>> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>>>    hifi_pll                      0    +/-1562Hz
>>>    sys_pll_div16                 0    +/-1562Hz
>>>    sys_pll_cpub_div16            0    +/-1562Hz
>>> + sudo cat /sys/kernel/debug/clk/clk_summary
>>> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>>>       hifi_pll_dco                     0       0        0        0
>>>          hifi_pll                      0       0        0        0
>>>       sys_pll_dco                      1       1        0        4800000000
>>>          sys_pll                       0       0        0        1200000000
>>>             sys_pll_div16_en           0       0        0        1200000000
>>>                sys_pll_div16           0       0        0        75000000
>>>       fixed_pll_dco                    1       1        1        3999999939
>>>          fixed_pll                     3       3        1        1999999970
>>>
>>> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
>>> Signed-off-by: Da Xue<da@libre.computer>
>>> ---
>>>    drivers/clk/meson/g12a.c | 9 +++++++--
>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>>> index 66f0e817e416..f78cca619ca5 100644
>>> --- a/drivers/clk/meson/g12a.c
>>> +++ b/drivers/clk/meson/g12a.c
>>> @@ -157,7 +157,7 @@ static struct clk_regmap g12a_fixed_pll_dco = {
>>>                   .frac = {
>>>                           .reg_off = HHI_FIX_PLL_CNTL1,
>>>                           .shift   = 0,
>>> -                       .width   = 17,
>>> +                       .width   = 19,
>>>                   },
>>>                   .l = {
>>>                           .reg_off = HHI_FIX_PLL_CNTL0,
>>> @@ -223,6 +223,11 @@ static struct clk_regmap g12a_sys_pll_dco = {
>>>                           .shift   = 10,
>>>                           .width   = 5,
>>>                   },
>>> +               .frac = {
>>> +                       .reg_off = HHI_SYS_PLL_CNTL1,
>>> +                       .shift   = 0,
>>> +                       .width   = 19,
>>> +               },
>>>                   .l = {
>>>                           .reg_off = HHI_SYS_PLL_CNTL0,
>>>                           .shift   = 31,
>>> @@ -1901,7 +1906,7 @@ static struct clk_regmap g12a_hifi_pll_dco = {
>>>                   .frac = {
>>>                           .reg_off = HHI_HIFI_PLL_CNTL1,
>>>                           .shift   = 0,
>>> -                       .width   = 17,
>>> +                       .width   = 19,
>>>                   },
>>>                   .l = {
>>>                           .reg_off = HHI_HIFI_PLL_CNTL0,
>>> --
>>> 2.47.2
>>>
>>>
>>> _______________________________________________
>>> linux-amlogic mailing list
>>> linux-amlogic@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> --
> Jerome

