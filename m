Return-Path: <linux-kernel+bounces-888021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A02C3C39987
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086F21890123
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DC83081DB;
	Thu,  6 Nov 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VUUrHcCc"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF02D515;
	Thu,  6 Nov 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417968; cv=fail; b=Jo78zHsi9DN9Ctf0bBvd6WsNteWKeeovTYG+fHNbV3RAdH6dqLJoRv/lHFhPG3IbTvXJMEDO4HkRzxJCxpiTiUyONhgV8jz1ZgJuCL+ICP+KjCWVA/8UinOUzOoUXMCmP+qxoujxx7EMZJliLsDYbHAVUOmZlMQegYoXSrMvvm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417968; c=relaxed/simple;
	bh=PlBiecy3aoGCUXJio21nFmMQfuLvoeafUw+Dlu/3SP4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=REqYTx2k0oN1vbBCnh3oWDlxkzRWNDs6qYBEB3k68Cey1T4phRRLVo/84nhKkM5t/dRwTNv/gNm2qXqc3i35O3lZAr3pdJRjUAZKjWGlZti4cc5xlcvlYYDiPIKAxkgNGF34jcXWyGd7bTlXynEnBhIfZKhutYbrERi2OBzgRoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VUUrHcCc; arc=fail smtp.client-ip=52.101.61.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuOER1qpiIUmoL3vbQLvDsKaybhVH/Lsu73qYQ/ZgNUXTkDlyjnIFEkhVQSc7BnBLaXyotOoO7eJZJyezgQz1tsR9WoqhzNPRAxmI7lGMXLCa1/3cy2C7KK37z85UgqIiXY6BTv9QJtqeVYyqKaiCjOg5tLnFOLc58hlQEWAwkFNoD6ytvK1lidjbe6Wi7S6mCCUFVAZmEoH1F8d5ZgG3L0iMeu8HKKpl9L2MyFLqcgbtICSDkxHETHUQrN+yY8v/Ve52irYjUPN1R048r2XAJZ2eflC1g8Epxi8KboNj4XCcJLWrb63vKikq/fSKpZGQ9FNBM61qodr8sb150CMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlBiecy3aoGCUXJio21nFmMQfuLvoeafUw+Dlu/3SP4=;
 b=EkUibvPN0dr8iEhGPseHSMGMtZHrkCEFr0lSgYQFwZ1+zfUPhnRGHe3BMZf1fTcWPCLggjs6647CLf/SdcP/ljuuN1kQfkb+eD7OxupfJtJXtdVodMB5EMdMIzPCgwyeZX6fW+YMAmS6RMMK0G4tBZZ0uhWhMlIBaoL3mx4EQ7TrBT6rEVVRxMv/AcI/NBKb44JykI0hKRgvloOStpR9csTkN+kjZxtrW9Yde3YV0GAZ7N0WFcXMmUGQ5jmJ454j6Z1bds/pPNc3njLtZmDaeA3cxhIfIjVXIbqBjnYAowu0f+RqAIF+OntL8mzey3H15UeaUm5NokjItYq4i/Fx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlBiecy3aoGCUXJio21nFmMQfuLvoeafUw+Dlu/3SP4=;
 b=VUUrHcCcAEMEHO0hBfkKaCGQ1QnsQcfU0OgoAMH9Qxvu/Et3R9NAGEqLk74VzUffWZN8CsP34AwNljfpgLxtlu2Dic2YgAOjksI62dEHNumTFVlF8lmNVT9UNTDRwsheQqVZXwLdEIFgbB93Vp9StI9Hz7ca6trSYmvtNGyEV4yz1PRjFa6T2BWs36JSvTei3afMpkZYmEwE6bML6sx6Bc4khvDDMg8BFyBbA/ZjzhTUZfcL5wwb+d//7M4YVA3pSlvI3pvqa6pUpkQJVa7/6H2NCc2pHJpBFaIDig6RmvsK5LQ7K5oIpAjw7STYTwz75ylXGnRGXPmg0hBNo8GNbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 08:32:43 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 08:32:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Nov 2025 17:32:33 +0900
Message-Id: <DE1H0USFAGNU.FFRA802H95RG@nvidia.com>
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/4] nova-core: Simplify `transmute` and
 `transmute_mut` in fwsec.rs
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel del Castillo" <delcastillodelarosadaniel@gmail.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251104193756.57726-1-delcastillodelarosadaniel@gmail.com>
In-Reply-To: <20251104193756.57726-1-delcastillodelarosadaniel@gmail.com>
X-ClientProxiedBy: TYCPR01CA0170.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::10) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f31a19e-2d15-4e62-5869-08de1d0f0d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1pDVDBIY1pBNTJhMDRqWkhxWGVPbm9Mei9LNmpid2N6ZXkvMjc3RkRqVWFm?=
 =?utf-8?B?VkpvVzA0c2NKbjdoajFod2c1ZHRmUktabmJFWVVUN3N0UWw5YVlNYlRZdGZp?=
 =?utf-8?B?OWRnRDdDczR5OEZjd0RnVnlRNm9ubnBNUWI5U0RWUVRuaUxmdVJoeFZ0K1hS?=
 =?utf-8?B?aVpkYTQvVWRNdWhzd2NGdUdhNXlUaWdBOFpVZ3NJcDFMQVBEQ3Q4SVo3aFVx?=
 =?utf-8?B?a2pTNm5ySnVMeHI5SmFGWVlJZzdyQ0xuUkFreGU3SVJtdjN1ZTJ6SkZmbHpx?=
 =?utf-8?B?SUE0Y0xlTGVCamdmTTRIbkNpUG93dG80NzdpVmR4eHpGZlJjVW40Z0drQzlE?=
 =?utf-8?B?azdLTVFHdzQxR3ZZaHpkcHQ0eEtkN1czTVlkUnBWZGE0b2NuNkpWdE4yODBz?=
 =?utf-8?B?N2lQOE1QbGVtZk1LTlpMOWdJMjBaZVUyYVNIQWlBRmxPWGZKOEYyamtSZC9H?=
 =?utf-8?B?WEFwN0oreGQxV3BWOVRKeVJhR3g3OWhKaDh0RjdEaXhFVWpEM21CWXRxQWpz?=
 =?utf-8?B?K3BBZzI5aUdlZ1ZsZi95ZUZGUU5qMDJpZ3d4T29rcTFjVWhIcTRjYkxZNC9F?=
 =?utf-8?B?QVU3WXE3RnZGUzNmVitlY0s4RlYrR29RR0g3WmhmQVR4ZnJxeUtsY25XeTRB?=
 =?utf-8?B?SEFGQTl3ZWNQb3R4UUdLbHdETG9RZmlaMUZKWUlMbXJTTGNlR2tXWW81VS9E?=
 =?utf-8?B?M3F4T1JTbU5JSjB5Ni85OHpHWklLQk5IYnV6bmFYdHRCNk5NNmF1YzBrdkt3?=
 =?utf-8?B?LzhVMFZ3Z0dtS3dsZlpQYmNjOTNNRUR1ZEJpVFE1YXdWTnVoNU9Ub0JmTzdk?=
 =?utf-8?B?Zmx0RG1IQnBJRXRSenZWTnJNOHJkVVowRS90dDVaL2x3aU4rcmxEdG12UXZS?=
 =?utf-8?B?Y0hpR2tETGY2V1M4OTJ4YWdHdUZmTDdDaWQ2TXlIYTMwbkUvNm1NM0pYdHpu?=
 =?utf-8?B?YUNETzNETGpkME5zVURrcnBjQ2FHRXppTC9DZlZ4WUpFNU44Z3NiVTAzT2Qv?=
 =?utf-8?B?bTA4bG9URHNGaDQ1SkVvZzZLaUpabFpwZ01mdWtETFdpZHFPb3RKYVlod0Rs?=
 =?utf-8?B?ZGpVVjA0eVhvcDRkNVpPd3prQ25sMVV3Z2NCMkZieWxEWEFGaDFsSG9iNDQ1?=
 =?utf-8?B?YTIxVE45UFFTSFBCMS93c2x0TkdVMjR6RXFxeTcwM0V3T3d3WGtaNE4wRXNt?=
 =?utf-8?B?REpudDVPQW1hZzdHM1lKZmlNcnVhUHdZc1pqL050alhYcFVqVWFTNzFpWEJN?=
 =?utf-8?B?MkE3ajFrUFZ0UzdYSExmTFhxTDh1UXd1bTZyekRMd1EwdE5jWWVVZGQrVnlI?=
 =?utf-8?B?TVhlZ1B4ckZOb1dudzlub1orWTh4dHJtWSsrVWdOVjhmOG1PSEZUM3BnbWsx?=
 =?utf-8?B?SjBYcjlPZGE2KzBvUzVlNXphRzVNTUlPUGpUbndtUEZxbmRlN3orZE15WXQ4?=
 =?utf-8?B?dVVxamZNUGVBUU1RV1liYW1uTFRoY2lROUpuTEp5dnZ5NEE0ZkRnQUREVmJ6?=
 =?utf-8?B?WEFUMjJEM2dlVFJVaXNKR3ZBaDBzWlljVFFoMlFxOTFzY09UYnY2cUpiQVgv?=
 =?utf-8?B?OWE2K1pxM21oRHhReWtLWVNDeHpzcE15dUFFRjY0bzFaR2hab3RVS3l2NlFQ?=
 =?utf-8?B?bGhDUlZEVmdvUTlXY2dYSFhPUnNOS1E4ZjI0SG9GWWRmckdHcmd0MDF3ZzVk?=
 =?utf-8?B?NVdOc1JDZEM0Z1ZsemdMankxalFqODZHR2crV1JLb0Zlc1pTT2k5d3dQVzNj?=
 =?utf-8?B?OVdZWTRTMHZmdEorNTZzNGlHYmVhS2hOTWVyMGQ0V2xNWmVQaFpETEc3Kytr?=
 =?utf-8?B?R0NaNGNwWVJxWlM2bHFEeDk1Y0UrSDJPR2dPbzFLcU8rQ2hBRkpPdkpPakdp?=
 =?utf-8?B?ZEJCaUQ4bEN6ZHk2L2hGWjFJOURkMkhaRE45T0NzZ3R4a0ZHcENZbFp6ZCt5?=
 =?utf-8?Q?pdSBxN6EN0GFjwtlivs+45PF7n45EasO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUxTbnZhRWNTTU1KK0xMM3VySjJJMHR0Y1hSU3RwY0hoZzNZRkZQUVVXeThp?=
 =?utf-8?B?UXh5UnpXMURvc1hBNnhZb0ovTExIcVNiQ21reG5nc3ZONFlEZ2V6NExITXRv?=
 =?utf-8?B?NEcvRGpYUExLaXNxQ29UOUVHNXJsaG9rYWVKNkgvN3hVRmwyaVFibjY3MlRU?=
 =?utf-8?B?QUR5Zm56UGtGU2RSUm5XSFd4TlFzTWZLbER6SU4vVVZMOE91N2hmTjlMSkp6?=
 =?utf-8?B?VlQvb0VmdkMxQkJMRHVGR0U1WEFuWVR6UXVwU3MzaUIrczJZNEpVVU5KY0ZU?=
 =?utf-8?B?QUQ5djU3dlJTc1NkRWNQdklNMUU5SjhQUmEvd0RCc0Fxb0QxU24zMHE5anlS?=
 =?utf-8?B?VWE2LzFOV3loaVBSdHpSdmNFeHNNWmNJclZubWNxbGNQdVN2c1NLc0lZak9P?=
 =?utf-8?B?SDIrSVcwaHFrWnpiSEd1UjcwMnppMzA4NWpCYnZ2clFsc2xGbHVERG9IbUNM?=
 =?utf-8?B?RmVPN1dJdmhvTnR5VmRLWWp6SUZhZVBqQTM3Y0pQMUw4N05VeS9nMFF2dTlm?=
 =?utf-8?B?Y0dXWG1iaDRiWG5FNjE3RXpSeUVkdEN2UmRZeDFJNUxhNmxvQXhFVENFYVNS?=
 =?utf-8?B?RTVyRHozL3hPZlF2SDdFVUtWaXRRaHJKdE51YU5VUEJnR1BSVXdXVFdqTUc5?=
 =?utf-8?B?RWdQVm1RNS96UHNHK0x6U2ZVYnhjMEZ6Q05SQ1d3RUJhZ1FBc1VEZEhzUFZq?=
 =?utf-8?B?RjBzNjlwTGZBU2cwZHhsd21lV01vcVQ1bEhNM1JWNVRJUU5XSnh6a21RTmxM?=
 =?utf-8?B?ck56bzl6TW0vTEx3Wng2TzBvV281R3BUL2J5RHJzU0dmTHBONDVleTdXbWFI?=
 =?utf-8?B?a2p2ajdOZFRsY0w4NFdPc2tib1o5MnUwdTB6eUR1MUQvZWpZWk9zYkhGYStj?=
 =?utf-8?B?aVNZNzRRUy9tMm4vN1BLYnlzUm9JVEZVUjdaSUFsajlPSmtVcWljbVA5WktE?=
 =?utf-8?B?Q0hUcmszVlJFb2EwS3JMWU9vc1lLanFHaW15bE1aT0NTNU5obTIrRjZFVlIz?=
 =?utf-8?B?Nkw0NkkwbWMveWNoaTRTenBQbGlNMWcwQXJ3TXhOV2wzaVZqVUlMa2owQUVK?=
 =?utf-8?B?ZmZISzRGY0xRTnorUHlZSGNkdlFkWTJZYlFOVlhEUGFLRXREUDFZcFUzbWE5?=
 =?utf-8?B?Z1dsRzh0YllVZnRQYTE1WS9hNmxhTFM3WFBJSHVpdWRDNjFpZC9UUEhpNXli?=
 =?utf-8?B?OVJoeUxaYUt6bTdIc1BmY21jL0h1Y1czTUwzRTVGVTM2OEQ3cGpZNTUrUC9L?=
 =?utf-8?B?YThwOXZ3alZzUnpuOEsxRE01T3ZycDB4OGtESmFWTkNOYnIraklKYlVQYVpx?=
 =?utf-8?B?SzE3OHV2bnJaYUJEY05nQkhKWnZKYy8wVFRpNkV1UHBkSlJjaHhGTm9FZUhQ?=
 =?utf-8?B?clZsOUY0TERKSHJHTjdocE9zUi9xd0psdklTZ2tHejZTaE00QlFvNC8xVytl?=
 =?utf-8?B?R2ZvT20wMWRhZFNNcENrTWwvbDQ2cjVsems1K2toOFErQkFJY2VrNFp1ZEdH?=
 =?utf-8?B?K01hQlUxM0RaNmU5RVBOd05CbHMwUGRZVjBjeHZ3WktYQ2g3Vll6V1hPSzlu?=
 =?utf-8?B?ME9xUHVPbGRMVWRERGEzY1hSRGdIMlFzeTUxMmtvS1NUalExZm16MUU4UUZ6?=
 =?utf-8?B?WktxOWxPT21sR0xwZzVzc0Z2Zmd0OCtnYk1tOXBRQ1ZmcGtucTJlNXhKbDBt?=
 =?utf-8?B?L3hhTTYyc2FBSDI2NzYyL2lESEszb0JOSXN2M1hkVThsR3lXZXVUeXh1NnlJ?=
 =?utf-8?B?UHBPZEUrS0tPWUVadzRXd1R2MVB3VXp0L2ZXUi9WVEJxOXM2Q1JoNDdGT1h2?=
 =?utf-8?B?azN2WVk3ckMrN1FNSi92Nk0ybUFxK0drdEhubGd4RkxDV2V5S0hxL3E0Q21Q?=
 =?utf-8?B?NWRmQWFCOHk2aTFwWjY2dnJMQ0Rlc0Rnd2UyVkY2K2NEQWJ1T3NGMkZWUk1L?=
 =?utf-8?B?WVh0QmMwYzJrbkNHTitkcEtQNW1rcnY0ZWx6MW95UHp5UFNXMk9GQzNtdng3?=
 =?utf-8?B?UVZYNHF5RHhnSi93VFdOOGNpSmUwR0tzRGpKdUZUOU42czRValphT3hhWlFv?=
 =?utf-8?B?VGdjMVJVQ1RUYmVvaTRFYmdHNFE5U21LbEQvY2poYzBDam0rZWpBYTZsTmNM?=
 =?utf-8?B?MFlodHgxTHVLYXVHaHJKWnpRbE84SFlnZ3ZlTnBya1dweWlLUDlNNGRLTWlO?=
 =?utf-8?Q?9Z/ZJUgY0VElOdbUwRPAJ3xmP7rlW40yo+OIGWz7uDoJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f31a19e-2d15-4e62-5869-08de1d0f0d73
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:32:42.8639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QTIlswSq3GpnNOZPGzJ/tresRBu0wQ3Odef8mD3IXe2lReclfIOI+jU7wZ3tfBt42C/TFrGOX2F6VM4obyjtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768

On Wed Nov 5, 2025 at 4:37 AM JST, Daniel del Castillo wrote:
> This patch solves one of the existing mentions of COHA, a task
> in the Nova task list about improving the `CoherentAllocation` API.
> It uses the new `from_bytes` method from the `FromBytes` trait as
> well as the `as_slice` and `as_slice_mut` methods from
> `CoherentAllocation`.
>
> Signed-off-by: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>

Thanks, this looks great so I am staging this series for pushing after a
short grace period (probably tomorrow if nobody screams).

One nit, the prefix for Nova patches is typically "gpu: nova-core:", but
I will fix it when pushing.

