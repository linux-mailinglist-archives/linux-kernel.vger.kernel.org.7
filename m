Return-Path: <linux-kernel+bounces-888392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D953C3AB65
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D383BDD0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EE431353E;
	Thu,  6 Nov 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="na+1rJtV"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48753128AB;
	Thu,  6 Nov 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429517; cv=fail; b=L7dCGvWu0o9bGyax7ojQFYuS/W6TMciJOsEcjldGyzg8QHKaHguDlmAISLh1TnDySdeD8sVffJTFS4iavazSjSt8kXKp0F7pCsHPM1CMFeBo7npZ+EaTs7q2Uyhte8gUy+iL4MB1Vibn0qf3vutXgM+J894ij/L98qPmAOVi6x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429517; c=relaxed/simple;
	bh=BLCF13iB57C7qB+I41CcGE6HIpmuKjYvBM6a2UrQPqM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=jdWbMdU24sZK9QyGmt6ucE41Q2kdTU2Qf1z3cK1YmxSHxEX7hjGE98i7TXXFl56gxriE06Qsxawr2QuQMTcIEOQOEVGnhMnl5ne2XbV0ObXq4Nx8KtMzx7vBEFJeK7WiabeSRu7P8rixYquI/LtdzErfXLBIUB+ZGHnjZ3a9Neg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=na+1rJtV; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W566F+sgh+KAE+3HIqsL15GJ4EA3fGljngOI8JxhCA/MKbu866fS9JdLMsXTWsatPf7pu+dq+lLu/P7v++pFjK27CtHEcDYGdXBaLG6b5cI2z0eID73zkgSJGRAhxbn9Mt374xP/AyQZz/gKBy9et7/N2zTv8dnzSQfgsJ+UDdCPZY470Ov1sMDqLpZ1q81aPZLkOwPXsHF2G8BL1BBs/z6tTyEtqf7W9j2l439ag7GeI7DEVQ5NfR3mI7Dd9suVuqDxyky9pCVnrNOz1qXLNn2POYofghQr/yFc3Z6jSzTosiHz46WfVQ6D9Ll7v5b/F+e3jbdHmHBJmy2Aam5wdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42gN3QQWdc16+fA230FbIpUOqMITApbFhbdvEChD6Lg=;
 b=cYE6jzOiFG/CqzyXPvzY/a7shZdvxMyxmbvJrQLYYyEi/Y8L8TbaLmiWWk3Kc69SBOaXkCikmXDxkikLxvBY7qddYaUX+vlo4FsCr7LO4aeowKk0m23gMrGiLsUYFBHOqwlcQszNh2KZ/htNcAcbBAKyKYunqs+TRrqHBsWmxI5UqpPEV/rLeGwKtUVhRNbGg6ukw7nZE57BqdlLv5ZSelruLRpREd6o3jIMenat5BIaWbDpcb3vhOOgTBpTLkWVGeIdvoJPEwnQB8FZyTZN4fI7VP5L1vt9UIYdCFScALL9R5Q4u4Js/2CA15yAAtWMv9Z5u1WvHnwouRNYEICkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42gN3QQWdc16+fA230FbIpUOqMITApbFhbdvEChD6Lg=;
 b=na+1rJtVOFMprCqErTDq/zn0lKmn8Pf7sYaReyPGQ7DdYLaFhjb7mWGZiOKLOT7M4pmTD3mIY+S6hMaoAR5P3chIXZ3aI8R/QZmLAWfv0dU2DqecPov0e5Ao3rN04QIMDrr3p6AyA/Fh03uV5TRp4GSDxphrr+Z/YtYvd/aPB8Dw90PgdO3S6ZIWCbdkEdN1tP1+oySUh12rho8kXvZOTqPuv3cHeghTNy29S1gQL0hwmt1CBny66uCzJBKXC46/pyn09RpPfZBI7CrfRIWf66PDKFiO8Cemi6jr1fYM7Oip6skSm/mpx6vyzcIeh3QPBWspXsSsdk8dUIPR/jL6Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 11:45:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 11:45:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Nov 2025 20:45:07 +0900
Message-Id: <DE1L4ADMFPXX.3UAY6MJAFNNKO@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Jesung Yang" <y.j3ms.n@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] rust: num: add Bounded integer wrapping type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251106-bounded_ints-v3-0-47104986a5c3@nvidia.com>
 <20251106-bounded_ints-v3-2-47104986a5c3@nvidia.com>
 <aQxwBn6wOarZ5ApN@google.com>
In-Reply-To: <aQxwBn6wOarZ5ApN@google.com>
X-ClientProxiedBy: TYCP286CA0262.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ce18fd-c6d2-4453-764a-08de1d29f10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmNQSUJPNy83SnMyQitaREwrSncyUXRFUFFWeUJxMFlzT2NqdDB6V2dia09O?=
 =?utf-8?B?dlRveDN5V04vWk9USHVQUmZudFZERjc2d1ZqTnFvNmFyYXVpK3dUVG5IdHpw?=
 =?utf-8?B?di9wcXd1SXhTK2cycWdJREJoL09oS202V2wreUNOSy83R0lTc2cxYkpERE8v?=
 =?utf-8?B?RUhkdWtqeGUwZ3hiU1c2b25QNnp3YlE4OGZwWHIzaFFWNTgxMzJQbHJhdU82?=
 =?utf-8?B?RTVyV2NONGlBRDk2ZVAxdkNXMXhqbkZtS2t2VS91Uk5KNmZNVDhkMmxSVUor?=
 =?utf-8?B?NkZWZE1tcmdBRDkwcnhObXViTkZaSHVCTCtxbmRDTnlwYTVsUmQxQXBZTlZo?=
 =?utf-8?B?a0FucjR3aFNNcjc0Rm9aRk1lQ0tweDNZbmhNYVVva3dGT2w3TDNhV2lQZGw0?=
 =?utf-8?B?VTA5K0pUcDh1bXRKcEVYbnU3Yjc4N0dQWkYvMzFWek9Gd2wvQUtlK01UVEdB?=
 =?utf-8?B?MU1FOXdIbDZDQ0hpcDk5T3NpOUV5UTlrVWlRUHFwcTBabi91RlhZbE5uTFVw?=
 =?utf-8?B?ZitCU0IycjhLd0o5eHZmTXJSaTk3NlNKN3NieERrT3dwOEJYN1ppeHkvVm9X?=
 =?utf-8?B?Wi8xVFZ1Y25JWWtBQVk2RVR4YVJocjVKYlRRZ1RicWEzK0dFRm5mS0NsUWg4?=
 =?utf-8?B?amphQXBlWW9zQy9zTnA2c0lFZTBqRXJwbWJTTkVFUVYxdFRGY0tFRjd4aGZC?=
 =?utf-8?B?ZHdVb0hUclNKYTJRZlMvZVF0MWlBY25OY2YvVzNLckk5RjZVNVFTaU44WXpF?=
 =?utf-8?B?Q1ZjTm00YktUNUxhWCtnT2tPei9qN1pnblBFK1hwcTRSbHZ0UFN0ajh0TDlN?=
 =?utf-8?B?OElNTE9GLzNBYTdXMXNlRzJmSnd5TWFHTjNXN0ZZaUNEMFFzSWl0VXZtN3FX?=
 =?utf-8?B?STNET0FKdzhxRkt0MGpZZ2xEeExQZ3phcER3VWV5eklHL2ViZzYzVHVaQU8v?=
 =?utf-8?B?aSt4VUhsUklGMlhMV1pRdlhWSWpFWXh5WHhkaHdia2VpemV5N0t1NkcvN0I5?=
 =?utf-8?B?VFRRdzdUcktLaS94TytlK3RLNm42Q29sZkJRY3FiQmxKdytleExubTFlZksv?=
 =?utf-8?B?Wk9Fak1Iblo4TU9KMjVSNHhuTmZ1ak56ZVB0YkRKeVdHeDVWZExNdXJOMmY1?=
 =?utf-8?B?bHdBZzBPYlFiZFFhYzJWNkhBQ2d1NGQ5TUY0TkRKWGhlc1NDdzJDRW1nL2NH?=
 =?utf-8?B?cVhEb2hUdzd5QlJEQjFxWjFzYk9IV2phOWJYdlRYYzFSZGQ4YUFXMnVPY1B2?=
 =?utf-8?B?UmhubG82Nk41ckNSa0xubjVWZUptTU9pbWlUS3FDSWpFcjR1dkpSdCsxak9k?=
 =?utf-8?B?Y2Q4Q0FuRmYxTkkvMWhJbkVoeVFIRU1oSnpiNk1UREpKM3dEeGYyeVlPT0pT?=
 =?utf-8?B?M0pvMmVMaWdFRmFSREFKNlRmbTZvdmdKV2c2WUdxYkVaUXI4OHcwNGJkSVBp?=
 =?utf-8?B?MS9qQS9oYmxqb3VpcHI4eVE3alNzdzlhWWU1OE01OS9IMFZsSkZGYWRqTzQy?=
 =?utf-8?B?SXRoR1pPSEIrZUFpcGpkKy80Qm9ISGFhckQ0VEVQTjdyb1NoK0crTkJQeTVP?=
 =?utf-8?B?RVZkMDVUNzd6S1pZTjlhY1ZLditkaVF0WGxuVzI4cVgya1NVZWYwckRxaitB?=
 =?utf-8?B?OXQwWENxMUVKUC85YnBIbzFrOHJtN2NkNHQvUFhuWE1BOXZaei9Fc050TDFI?=
 =?utf-8?B?bnVYWm1nUEhYQXBTWlJwV1Q4TnZOaE1EQ2MrZDFDdFEwSytSZWFZWEpjVnNa?=
 =?utf-8?B?UkE3MXA2OVUvREJvWFFLMHBtMVMyV0ROQ0s0ZjhzcHlzajk1Z2FDMm9Yeldr?=
 =?utf-8?B?d2syU0xVWVQ5WTdod2daTG5OQ2lwZ2dGRnhsenVpSy9FcjZaT3dMalVmeEZL?=
 =?utf-8?B?MDV5NDA1SGRtTjBxbS81T1VXdmdRb2RNRkxwMFQzUnQvUWVIRGJUa3ZpVFdR?=
 =?utf-8?Q?ywjhzt2mcsrlVE0lCWpBcA8QvW+dmQy4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1F6aTVhMUZKZG5nekNiU0VxOXVUcFlodGhkVGVMR3JTeGtLSGJ4c2c4dHJK?=
 =?utf-8?B?bXlqQitRYTZ6WEhoT3dMWWw1Q3dtbmpDSldnVmQyZlJpY0JSOXVmY3BXemg2?=
 =?utf-8?B?dW9TRG4yYytSdFI3aVg5Q0RnMitUaDZEZ2c3cDhvQm5mbExJWlIwZE9kZ2Nl?=
 =?utf-8?B?ZTlwVkFQbm15eEVRZVA0ekVoSXZteDNDWkdteDl1Nkkzdm9oakZRa21vYi9m?=
 =?utf-8?B?UWcwRGtBUmdHVWpWVWl1eWhFY1AvcXZPUlBVV2o3VG5uWHZXZkgzN01Obnc5?=
 =?utf-8?B?TkY5ZDJ3d2doVjhDS0VHN0FjTHNsM1AwdW9OR2lCRzh6OUZnUFlVUmVGaW5M?=
 =?utf-8?B?UnhhZ29JOU9JSnZKeGZJaUUzMThmWms2VStrdFBrU0pwS2F3Q3BnMEpjdXFq?=
 =?utf-8?B?SUZKeHZjN21WYTNwV1JyM29BMlFZVlFubExqekV2U3psMnJCSEF1S1hGTHRE?=
 =?utf-8?B?Ukt5S0I1TDFSUWVlUWFCdnlCY2JVell4TEVSM1dtRWViV2FnTml5WkJxblN0?=
 =?utf-8?B?cDhzZ2dvR28xU2pQVjY3RHcyYTdtMlNBVXd4cDRpanBZMGVaamFvK1RiaUlo?=
 =?utf-8?B?WEJSaXIyRk1WVFBuTHJMb2E2ZXRqVXVVZi96ckJHQ0xRT0pvcXJUNVVtU1Rn?=
 =?utf-8?B?K1JpMUsxaG5NaE5aR0pLZzZodWw5OHdXRXorTWwrelVNRTI2VFNJR0I4ZEV0?=
 =?utf-8?B?R0pDVExZNkFubHVNd3JueEtvQzlxR0hMWUdWVFA3YzIzaC8yYTlwcXRhbzl3?=
 =?utf-8?B?RWNDcUFjUFZUQ3FaWjhDRTQrTm5sMTlia3RyNjhJU0x2SnJkdVJkUmJjc0Zm?=
 =?utf-8?B?ZDlUTjEzRHJuckZHNGFhV2h0WlRqRm9UamRnYWxQdG5OMk5OdlBXM1pxZWxm?=
 =?utf-8?B?Wk11d0RBNU5HTU83VlhoV0M3VENBeDNTN1ZTVUQwVERMbE56TFp2S1dMeExp?=
 =?utf-8?B?R1VtUjR4TnBwN3ZCUWpwZGhESXpoRnBDUkpOZFNrTVpRZ1dmdnM4cWJibFFU?=
 =?utf-8?B?R3pEK1Z4WG8yK3JvVU9sYW5DakJrc2d0QlZldzFQWUpNYXdHMlBLeVFObWlq?=
 =?utf-8?B?aFBoVU41NnFzcjRCQUROYWNyN25nSVdvSXpTRVBRcmRLTzkySkk5Q0M3cGky?=
 =?utf-8?B?OWVjZ1Z0S1ZEeEk3S3hBZVBSQ3V4WnB2SytwYVRnazNReDY2QnhSa21tRDVC?=
 =?utf-8?B?V3Q1dGc4T3FCRGNRTTF6U3g2ZFByZy80d3ZMRGx3TEs2cFFjWVdEc3l4WTZk?=
 =?utf-8?B?am5maCt3dU1tWWVKZmgyTUlHb1A2K05MMnMvcDdvenJsa2FIeEVZNXpVSWRu?=
 =?utf-8?B?c2YrVmxXbThXS1FGSWVlK0pGdjRwSEF2eERETHlFZlIrRVArUzd3TUxKUm5X?=
 =?utf-8?B?eGFYM3hheHN2YVBSeW9jQ3FrSE5RdVZJY2Q2amdJVzBOS2R2MndFZHhPN1oy?=
 =?utf-8?B?SGV5cjgwQmJpK0UvTmltVTVLNVhIdmVwWW9vTWlNeS81NktyNGs4K2FCSmp0?=
 =?utf-8?B?NDZNVlo1b2piaTF2Y3VpdHZsWW1ZQVRVWDVjdzFjQ082dXdoRGpJNlh3Vzdh?=
 =?utf-8?B?L1JqdVZUc2FKdnhXci9xT3ZoR0VYYks2VWlBdGJDbzV4NVpiS0VUbTVHRjZQ?=
 =?utf-8?B?SEllYk42aXRyZDMxVnBkU2EzSFp1NlNldFFEaFZqSVhpbjJwdHJSL3pLdyt2?=
 =?utf-8?B?RDBHTzFldk16djNYK2lyUWhsQzVjQTNDazgyWXFPSlIzZVhlNG9Fck4vaWNC?=
 =?utf-8?B?TmY1UHlrekJJTW1PYU5FMUE5b3IxeWc4L2lOV1E2RUFXdHR1T0hLaSsrT3dK?=
 =?utf-8?B?bkxLUG4yYjFyM3F1WnBMUHFSWE1QNlNlSktCYW54Ulp6UWRHMi9ZM05HWWE0?=
 =?utf-8?B?WERXR0ZYWTdRSWlDeDZxUVFOOXR5OVRVT0t3bzZtdXdITjJOUk9UWUticS9r?=
 =?utf-8?B?dlpwWmk4UmtpVGJuYjlPZnBWT0RFeXhaL1lISEdnbnJIRVpUeEtzNVc1WStZ?=
 =?utf-8?B?UzBsOWhCVmRoYzZJamQxUG5PZmx0ZkYzZzN6cDdaV3E4dUsxV0ovOUNIMVV0?=
 =?utf-8?B?bk45NG9UVUt5UVVVbk8yTTZpc3dUV3lyek9UdVljR3pQVXJWNC9VMTExdjBn?=
 =?utf-8?B?OEdNcnlTNVVlN3lxWXVmZG1aYVBxbm1ZblhTOCtmSHF4V0lOUkdud3pyNUtl?=
 =?utf-8?Q?ukiaYkG3hLTXxSn4eY5kQGhb4rg2Cqka4etHGrHDi7tK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ce18fd-c6d2-4453-764a-08de1d29f10f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:45:11.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDalek9z8pT5NQ7PSqqz1U6Hq7SmNVLUr2V9GZ0sKOd8XiUD/jCm8IG8Bp6qvKj2qHvhX9iHbHOmh2HR9WlJwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490

On Thu Nov 6, 2025 at 6:53 PM JST, Alice Ryhl wrote:
> On Thu, Nov 06, 2025 at 04:07:14PM +0900, Alexandre Courbot wrote:
>> Add the `Bounded` integer wrapper type, which restricts the number of
>> bits allowed to represent of value.
>>=20
>> This is useful to e.g. enforce guarantees when working with bitfields
>> that have an arbitrary number of bits.
>>=20
>> Alongside this type, provide many `From` and `TryFrom` implementations
>> are to reduce friction when using with regular integer types. Proxy
>> implementations of common integer operations are also provided.
>>=20
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  rust/kernel/num.rs         |    3 +
>>  rust/kernel/num/bounded.rs | 1045 +++++++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 1048 insertions(+)
>>=20
>> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
>> index 3f85e50b8632..bc9abcc3a317 100644
>> --- a/rust/kernel/num.rs
>> +++ b/rust/kernel/num.rs
>> @@ -4,6 +4,9 @@
>> =20
>>  use core::ops;
>> =20
>> +pub mod bounded;
>> +pub use bounded::*;
>> +
>>  /// Designates unsigned primitive types.
>>  pub struct Unsigned(());
>> =20
>> diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
>> new file mode 100644
>> index 000000000000..2e4bc4ce9af5
>> --- /dev/null
>> +++ b/rust/kernel/num/bounded.rs
>> @@ -0,0 +1,1045 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Implementation of [`Bounded`], a wrapper around integer types limit=
ing the number of bits
>> +//! usable for value representation.
>> +
>> +use core::{
>> +    cmp,
>> +    fmt,
>> +    ops::{
>> +        self,
>> +        Deref, //
>> +    }, //,
>> +};
>> +
>> +use kernel::{
>> +    num::Integer,
>> +    prelude::*, //
>> +};
>> +
>> +/// Evaluates to `true` if `$value` can be represented using at most `$=
n` bits in a `$type`.
>> +///
>> +/// Can be used in const context.
>> +macro_rules! fits_within {
>> +    ($value:expr, $type:ty, $n:expr) =3D> {{
>> +        let shift: u32 =3D <$type>::BITS - $n;
>> +
>> +        // `value` fits within `$n` bits if shifting it left by the num=
ber of unused bits, then
>> +        // right by the same number, doesn't change it.
>> +        //
>> +        // This method has the benefit of working for both unsigned and=
 signed values.
>> +        ($value << shift) >> shift =3D=3D $value
>
> I'm still confused about whether this works or not for signed values.
>
> I guess for a signed 4-bit int, the range of values is -8 to 7, so those
> are the values that this shift should preserve the values of. Is that
> what it does?

Let's roll these examples, using a 4 bit integer backed by a i8.

-8i8 in binary is 1111_1000. Shift it left by 4 (`i8::BITS - 4`), and
you get 1000_0000. Shift it back right by 4, you get 1111_1000, which is
the original value. The smallest possible representation of -8 is
`1000`, which indeed fits in 4 bits.

Now -9i8. In binary it is 1111_0111. Shift it left by 4, you get
0111_0000. Shift back right, you get 0000_0111. The value is different,
it doesn't fit - and indeed, its smallest representation is 1_0111,
which requires 5 bits.

And if you go with smaller negative numbers, some `0` will eventually
end up in the 4 MSBs and lost in the shift, so any value < -9 is
properly detected as non-fitting.

Now for the positive limit. 7i8 is 0000_0111. Shift left by 4,
0111_0000. Shift back right, 0000_0111, original value. Smallest
possible representation of 7 as a signed integer (thus including the bit
sign) is 0111, so that works.

8i8 now. In binary, it's 0000_1000. Shift left by 4, 1000_0000. Shift
back right, 1111_1000. Doesn't fit, because its smallest possible
representation is 0_1000, 5 bits.

I have confirmed the above with a kunit test as well. Actually I will
probably add these to the doctest for `try_new` - since all that
constructor does is call `fits_within`, that will cover these edge
cases.

