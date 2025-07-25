Return-Path: <linux-kernel+bounces-745767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94591B11E48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523781C84C13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF04247DF9;
	Fri, 25 Jul 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TJyJ/bL3"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C52459DC;
	Fri, 25 Jul 2025 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445551; cv=fail; b=H/ZkNcFbraEinPvjbexqPCboUXqokpvOEBa956yuwxrnkjzWJzLbdlJtuXjNm76QDGVAoXCmh9kCwbr0qFAjC5F1+LbuPA/YSVYsRDKJd0qYDGKq0nswyIIxPSrQQhsh+EUItY+8TD+/DI4eIX+wyq2Znt41cO19aGU8npJuLr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445551; c=relaxed/simple;
	bh=uVAdKpShZiAqXfEa8nqZfzSjH0XmzSSPSEHpq3GmY/0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=Toe2jKKcK43GsRrQy2LIGEN19c5oWoxPcKNCVKzdtga1GVmCGrBIR7S27zdMq3xEfnrLhQtbZCQk3KdmPWzfL4zg6A/s2/TD/ghDG/PVcN24h53rKn+czX6iDS+hmdhzKyQDiJjtGtjWZd3lMK2k9f2REV20eDbSDbg5PPiPphA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TJyJ/bL3; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsW/a9Xgn4qG2lfKqLM8Dz/ou2sjGGdiUnZKt/yUbdl/cFcT8uaH8G50MI9u0OGfJo+2sQdZ9PaCTG64DrEd4GfUW/9GWkCTYjs261zdmpULUjEhU16MoEkn81bGsEGoSEnJqKO0F7+edXtDj8pYAr8TOweZgtpN2SJGVEOsb2tOYMFRP3N/RYDbVaH2uF2pukVHdtkvofnYV+st4tsmeC3Ng3PSS4U9LsQfqHgz58UIuJcDeMdZZ08vTp6R9Otnb0uk6KyIsSyyReEKQx144a+Ufmy5pKy7Ha3SaEQF2A/v/Ev4Z54Q6oOKBTCqO/w6EW6W43TmPVc+2ELfWAAq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmnnFD9p7G3Go/rzzQrXGDXIeSbj+N7Vj9pZIaDEoHU=;
 b=DZX2dX1kSMBGDzQR/X/lW7unZWz/IeskZBDJ1IccB+eMg1dVHF9OHy6isGaYTa4JvK0o7MqEiLRrBdr9ntAocVvUK8xeCe//5pIPiQ0zC13jSTtNtr+CxNcQJ74pnuDsdvyAOQC2aXyCWU2epcHaoOt6OCzm24bAf0nfBQmFg8kc5UZk/AgFcEHsloJylfe6YVZxO+5/hkkqlvtG1xO3geuN0p3ZTh0ydkAddnjTnKpi9s/5gJWySiBaUBaGkjCRIB74wv70jQmg/1Tw6F+OUn/WTub5OUTyIqu6WKW8ezFn6Ru6RVUVoQS5sqGUcEHcP4XXgkPmGoC8tzKfIfnFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmnnFD9p7G3Go/rzzQrXGDXIeSbj+N7Vj9pZIaDEoHU=;
 b=TJyJ/bL3z1YBmt/ZHU45fS4tLbB8PeTo1Fm9sb3G9nkJEdIwcbrfHf4zcC96ZqCVxMPdxyTsIHCsWW6ENdvgSV/dksB2z3VQZLgqhkGFODrGv8E7Y7KqZuxX7Mci1+Fwu+hgRBsYxAoqRshzvVHGyzYp0VZDr2j6cGeDYphg4X4yB6qb+PB5xO6t1BteBB/KKx3UaLeDHKnGLYcxxsICFUt2kczpJ4bf6dsJJEQ7vhAASQsIyohnzwRxzaypOLgJ1jrePY8KHkOctnPE0tbUVjucZiRMR0MW4Oz5Tu5sZ0hxPJuSpNwabL5GfgXOeeU50IquEcuAXihHfCLMQdwJ3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 12:12:27 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 12:12:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 21:12:21 +0900
Message-Id: <DBL4KH9KRMW4.2CG55BFPM0RXN@nvidia.com>
Subject: Re: [PATCH] rust: transmute: add `as_bytes` method for `AsBytes`
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Robin
 Murphy" <robin.murphy@arm.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Trevor Gross" <tmgross@umich.edu>, "Christian S.
 Lima" <christiansantoslima21@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250725-as_bytes-v1-1-6f06a3744f69@nvidia.com>
 <CAH5fLgj-crrKyZbgPBLyWNmzw_oB6ZVc==rqAFt5jr6402nHLA@mail.gmail.com>
In-Reply-To: <CAH5fLgj-crrKyZbgPBLyWNmzw_oB6ZVc==rqAFt5jr6402nHLA@mail.gmail.com>
X-ClientProxiedBy: OS7PR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:604:253::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 465f709e-1058-46bb-38df-08ddcb748567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnIyc0ZBdURhOW1UWHYwYjhTNWpZVkRzdm1wSVVCZnJKSk1za3ZkcjNSeWw3?=
 =?utf-8?B?aEVUbUtOT3N5RUNQRUI4bmx0V1Q1WXFoc0NjeXEyWER2M3FHYUNNRkJBTjdq?=
 =?utf-8?B?K3FVOU5HRHM0MnUza3ZPNkJmSzNPSTZPTE1PNG1CUXBSSGUreTB0SWJjcmFN?=
 =?utf-8?B?ZksxRXJpYUNtV0VGNlFteWdkaVF6SXdHK0VhbDNZSnNPenRoaE84OXNBL2dQ?=
 =?utf-8?B?eFhUWXNSWEl0RldZYjFkdDJ6Q3JQRjZSR05XYWhkNnVhOVRUMWo0YUdwa0Nk?=
 =?utf-8?B?QUk4eDhwODZ3Q2QxZnNXWmtFcUZGNFpCbGZXT1NtL3pqNlluQzFhQ2prTnNj?=
 =?utf-8?B?OHZWQ3FvN0tQSW5YR29tMGJJdGVGTGF0T0ZqYmJIMVZVVU5iWXRoeWMvZ0xJ?=
 =?utf-8?B?TndrRmlGaXJYdUJrVHg5ODFFR0R6bFozVkNaUU8zZkVsMHlGZFNWMkN6RXJn?=
 =?utf-8?B?V2ltV2dzeXpadkIzT2FQYWxZamFYMU9OL2ozVmovUi8zaWZiaUZjNVNTd2xr?=
 =?utf-8?B?U1kvSTR1Wk5pVU1IRXVkV2xJQUFaOXN4WCtOZmF3YTQrSEEzU0FxOGp3N2RT?=
 =?utf-8?B?S0FnQnJNZnVGUkp5WXhMWStSUTg4Y0JEQ3VFMlQzd1pHaUIwNVQwNnZ6RnRj?=
 =?utf-8?B?WjBRZ1lzeEF4UVZWbXlxdkthNSs3M2ZQVHFMNXo0WUhTMDUvT2FLRUFPR1ZV?=
 =?utf-8?B?V0lGNEpMVC95clVvUFh5UUFYRjVWcXNLYmNVbll4VVRDN3daVzZJM1JiWG9i?=
 =?utf-8?B?Z2VqUmhpQmp4S09zQmoyalFjUmd2TTA4SWFWSmtOd1pGeWdma3ZZVWpDSkhV?=
 =?utf-8?B?VzRSc1pGL2tFYVdIMVRPWWk1MHNJS28xOVpwRThOeUs4ajFia0VCaWtvTXNC?=
 =?utf-8?B?dms4L2NCUGMxd1EwS2hGVklnbkxoVzNwMVB6Sm5zaUpxaUZKVjh1dlZIdzlX?=
 =?utf-8?B?blZubHFsR0wzTC94dmF5WnErWC82YW5hZ0pmSkZyTFdFQWMyZytXVll3Nkg2?=
 =?utf-8?B?cFFzUndtMFJyNTN2U2h2dXZGQ3ZqTGExbEloTjJpNHA1VzlmdEtpaGZTYzNK?=
 =?utf-8?B?d2lURFdtOHpHU2I0YW5UY2lCRjJKME03K3NXek1qUW50UnVsbytsUEZsUDla?=
 =?utf-8?B?dUxlWCtienhIVURSQTRhak9OSWlxVmRkNFNBaks4QkRnRUZhYWJLR3FTN2th?=
 =?utf-8?B?d0toMmczbXlqTkxsSUJrVGxpVW1kS3NkSVl4MjA3WXVHSUNndkY0V2xmazBS?=
 =?utf-8?B?Q2I2dkVMTUFVa0JpWjFnZUNQYzJZRVpXcmlHcE9RUDN1eDB0eXd5TGloWmlT?=
 =?utf-8?B?d2dTSXY3UEF1MzErbytESEdSNVRqcGErQkg2a2NnNTdTc2RmWWc1bTNSSFU4?=
 =?utf-8?B?b3VWYXZMOXRUcTVDSW9CZUpQUlFLb25LbzhJcDVZTmNWSUdRQlZTL0t0OHg0?=
 =?utf-8?B?bmhBMS82WFd1NXpRazM4NWJzUEtvOFFBQUN1ekloMUkrb0VITy9mWCtNZHNJ?=
 =?utf-8?B?aWZlTkFtVDhVbEcrV05mYURUanhUZGM3MllaMExOaVRLMkVYTzJPMi9HaUsv?=
 =?utf-8?B?NFBqT051V1FCZkZzdDh4RW5xcnRZcXI5K3Z5WTVackJXMUlyOXdJbzd1Qzcx?=
 =?utf-8?B?WldLMUQ0Q1ROREUwaGVRelBlaVVGdm5EUWhEL2h5SVBiaXB5ZzBtNDZ2K1JD?=
 =?utf-8?B?b3d6QnFOYm80MXRNc3ZjOTI3bVBUTWJBeXc4TWRKR0lHZ2hSNkJXbTJ1ME45?=
 =?utf-8?B?UVNoMVFzc3FER0UrQi9iZThxOGZVZ25LME41K0JlaHl4R3gvcnZmTWtOcXp5?=
 =?utf-8?B?MjQzKzFaajZleEJpejNFYU9NdnV3Z09XS01qZzNZS3J2Z3FacWkyK1RYQmU5?=
 =?utf-8?B?MHJyTVh5KzkxYjA0d3lDK01HdEdGZzZIeTA0S25iMGVkY3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekh1UGxMSHp2bTMwaWVqTWF6QUtxeFJDUnFtRUpvTHQzTXR6WWdOZWdZS2oz?=
 =?utf-8?B?TWhObFdGRFdleUpIQ1RBRmRuSnh5aFova3B0U3RjV0E2RGhIamVIWkRZM3hm?=
 =?utf-8?B?MGxjTm5uNHhzeW1SL1hFeFFBUVRHb3hzNWVXOUZHUUl6MWhuQU5ZSXp4c2Zm?=
 =?utf-8?B?b1NmWHd5eXVpeEltK0tkaGZLR3I1TlF6dTZCSjgzc0ZUeWZJdUJyVzE5QkR3?=
 =?utf-8?B?OGQ3ajh6Uy9jR2VIV1VVUmYxYzRvdFJaSkVzaU5rVkdzakRnNWttUnBPUndn?=
 =?utf-8?B?aFBjSFpCT2tKbStxdFhTY3B2SXZUSTBYQVg3bEdPSTMwNTBiSUY5YjhJMFlR?=
 =?utf-8?B?S0lDQVlaME1RRXBXS0ZqV0Q0OERRa1ptTmlHeEFqMlNrTUpkRFJwTW5UYlRC?=
 =?utf-8?B?VkY1NlZkSTQ3SkpUM3puNksreEFWUlYrVm1PdGxZcTFINlNJbXhRRkRUY2Fn?=
 =?utf-8?B?blJ3Qm03YWozVUQ5U1YvZ3NLK3FsdkdKYnp4L1BYNGFJM0N6MFBoTlhQYWpQ?=
 =?utf-8?B?M1dPS1NrKzFwQzM2eWZSbStIdFg3Y2VUcTB4RlEwUFlnd0xpUGdyemRTZGZz?=
 =?utf-8?B?aWJXU0hwMG5ta09FK0xoK212bGhmVGhMV2lkOTBHNHArR0w4Q3VoNGhNYXQz?=
 =?utf-8?B?THhsQnFFdStETkFNNDZKQlpVS0ZXTldEeFY2bm9XSXRFUGo2WjJQekJQR2w1?=
 =?utf-8?B?ZVZ5ci8wSUZjZXN3N2pMdk40blJRU252KzNxRzhSRVlkRW1TQS9KU0c4R2hz?=
 =?utf-8?B?V0JMWHFXbldIdE1laW9hOHJjZEhScmFlcm1HbFdCMjQyZHZYY2ZPOGRXTnJk?=
 =?utf-8?B?KzhSdGRzYnRtVXpNL0dPS3BiNEZudC9BbC9sNjRnZXdjYVo5MWJBWkp4Ym5L?=
 =?utf-8?B?MEtxTGpaQ0lnQmFrSWtGWjlYcWFacWNocnFPb0dkR2xTL2tKbE9ySzZlSUls?=
 =?utf-8?B?RWp1UzlFeHBxelZHOVNUVElVNTJ3c1JtdTJuUklSN0k5QXpKb2oxRXE2dUZN?=
 =?utf-8?B?SEsySXhXbmJEanBJNlg2Mkp4RmxwMWFWUWIyVnBYVGdjaW1VU1BnUHBaQkJk?=
 =?utf-8?B?a1hIWTFRREdiWmtUakU0bnk1R2RuRXN2WWU1WS9tL3RIL01WZHV2ampCMVpR?=
 =?utf-8?B?Sy9mOWhJTFM4WllYNEppTDRFNXd3U1ptWDIvaHQ0S1RTL3NCZ2dCVXFQT2Uw?=
 =?utf-8?B?SFpwK2NrcTBvU3cvcnhQSFRwelR2Ukh3NFJVZk90cXFBWnlhTnlLOWEvOUlB?=
 =?utf-8?B?OVBYaWlFdVBhMXdaRmZWOC9rZlB5ZU9VS1paVkw1Nm5VVUc2N0Qyb3pJeEhx?=
 =?utf-8?B?K0c4M2t5NVZ0VE0raUd3R3R1ZFh1aU9HZUVrSk54L2ZycHlnWUNpLzI3d09z?=
 =?utf-8?B?WWJsWnBNWXFublBEeTdlemo2Vmc4YlhoYmhFNUE0RE41ZmxjQnpBOUlXTVZW?=
 =?utf-8?B?Q1NUSGRrei83WnB2S0Y2OVlwT21xZlFxVGovWUc4S1dPQXp1QWMybWpsbXAv?=
 =?utf-8?B?Mld1VnZhcmJGcTZFVEwraDNiWkNxN0RNMkJmWkNTdlpwM1h6V0NYcXJRQy91?=
 =?utf-8?B?c1AyUXBZOWwrMnA2aVpQM2thbE1nb0lQbXc0bUxnbW11VWowQ25kZ2IzT0pz?=
 =?utf-8?B?MHlpOGVLdVNMT1krZkdJOWhDRkJpcFVxZFlhcmMzbUFtL2VQT1hyRm1Ecno4?=
 =?utf-8?B?NHhmMEIrWTlhYldoUVZ6TnowOVhWSGZUTlhoMFFOOUpXS0RtTVJZb0EwRDkv?=
 =?utf-8?B?V2ZicGt4ZVQ3b3lDTi9DdGhxd2N4SmJ4bE1IcDRUQ3hnMXVheGNXWjJmUGV2?=
 =?utf-8?B?eFN5WmszYU4wVWt4eEU0Q1IwY1hKRUE2WFBrYkNCbWZ0R2ptV1VXMXQxK0ZQ?=
 =?utf-8?B?Vmw5eDhTdG05S3pZRTZLcm4wYkVNOHhjM2NVMjZzbEZVWGNib3J6SzR1WWtp?=
 =?utf-8?B?TkZFT1grSlVObkJveTJ4VWdoazVaMjdLNUxQWDZEelUvT3ptSW8rNUhLNm9z?=
 =?utf-8?B?WEhrcEorSDlaRWFhYUIzQ1hVbU1wY2ZaL3JKbmZuM2w1b0RBb3B3ODZPWXFJ?=
 =?utf-8?B?dys5eGNFendkWnFybjNIcklheE1FbDk5RENYNzlkOWRGWTRYVGFpV2hGalpI?=
 =?utf-8?B?Zm9kMlJ5bG5JUTBCdFluQm40Q1MxWXZsZHU1M1RBNmdKNTFCSjVJUExaTUd2?=
 =?utf-8?Q?jYionL5afgkq417AmM5H5KJxfkLwRcaBToo4tMwi/0yU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465f709e-1058-46bb-38df-08ddcb748567
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:12:27.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTUVErwbODqSxCh3hQlupecDI8Q5NH2uosZFEZzmzUuZfgxbjvsTrZUU7Rrnolst2sUGWhKUwJ9bSBTAis7pgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730

On Fri Jul 25, 2025 at 4:52 PM JST, Alice Ryhl wrote:
> On Fri, Jul 25, 2025 at 4:11=E2=80=AFAM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> Every time that implements `AsBytes` should be able to provide its byte
>> representation. Introduce the `as_bytes` method that returns the
>> implementer as a stream of bytes.
>>
>> Since types implementing `Sized` can trivially be represented as a
>> stream of bytes, introduce the `AsBytesSized` proxy trait that can be
>> implemented for any `Sized` type and provides an `AsBytes`
>> implementation suitable for such types. Types that are not `Sized` need
>> to implement `AsBytes` directly and provide a method implementation.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Is the AsBytesSized trait necessary? Can't we just do this?
>
> pub unsafe trait AsBytes {
>     /// Returns `self` as a slice of bytes.
>     fn as_bytes(&self) -> &[u8] {
>         let size =3D size_of_val(self);
>         let ptr =3D self as *const Self as *const u8;
>         unsafe { slice::from_raw_parts(ptr, size) }
>     }
> }

Wow, I was completely oblivious of the fact that `size_of_val` also
worked with non-Sized types! Yes, this works perfectly well and is much
less intrusive and overall way better. Thanks a lot.

... now it also makes me anxious about why we didn't include this
method when the trait was introduced, since it is so simple. ^_^;

