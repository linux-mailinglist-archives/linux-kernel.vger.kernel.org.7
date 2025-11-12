Return-Path: <linux-kernel+bounces-896346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F63FC50286
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B74F34BE61
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794F2220F29;
	Wed, 12 Nov 2025 00:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SvuSJhbR"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2514B96E;
	Wed, 12 Nov 2025 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762908924; cv=fail; b=NmzXauO7RpQwnsyWle8ouj//l4E7pPp4IyzX4G4jgKIapQoxVF0hwW8RH71pvtlgVWCih1rvgwp4y/QubedJ66vN3+45UN6bMdAxXgEl8IQk2GNAad2h/9RfoM+iR1+jKkBxJ+gHYM4MyK4XmeVSjPrqGLGAMgzIfka5Fp5niAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762908924; c=relaxed/simple;
	bh=CJcnjIFsbTBKwFvteSmM6uqrlUcMB0AhXkeSbhsS4i8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=p7feOgOxsVFNU2s2QyO4T7bYlpBtrwxIGh2eXtm3w13UPEKEbbeeuBweQ4rbsLePLCahficUMT73LmMssTSmEY8aatoO3Icj9BNR0Oz4oujw3H2bfz5WiOMOmk0hbwQrCKE9ZArttA6Z8FuOAt0ISw2wVD5vtnyBJnoYnTxx1Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SvuSJhbR; arc=fail smtp.client-ip=52.101.48.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxqxrLaxyczg5kTr76diZIXzb8rnz43E9lEZXVSPvNe50rkse3Rc4qiL8kNFrW4cu0mC9ey+2lGFdkVTnV84LpJ1pI0qtXSLLBvt4A8Xl7zuRd8DgOwgX/+VgmrAaEjRQJ2QRSyqk5eIpU0aIoCJpwoxE5zbTRyakBYXpNBukk5uaOekfIsLGRUihu+qvgbOTD6ER76+0BMAIz5pn3d4LXircfGUCLQfcNf6oagnrKMiECSXjxf358njh1njWFUO6/mtawdmvO7+3uvL3VYU2VN9TyfuzTiQ7ZyKLRP48S1KcBOhqalkPXx35Eselp0INpiLlLeRaTE0apwhlbr7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJcnjIFsbTBKwFvteSmM6uqrlUcMB0AhXkeSbhsS4i8=;
 b=hqH1Y/rKUb5+xuDDqDobKDCGrjSrNOEXYHcIW32r/zU8RCvqQ/hsqJJfc7Fi9UC8Ae1JxeSnvQ2HN+f69RXxH89fzJbwhYOxy7j1FN/x5h40Xd4UieLfWvPLK1+q4i8Hpvx70sm7O44mU9PJzUyWW/sNoZsJTJi0wdRhnIdfmcSZtxMxuyAQXY8vnYGT6Oidqii2BS1onRfOSnYAjFEf6l0xRe6otwUQNFA2oVT/tn98yqxXTANsVjbv8L8YBKdOauLcJOQIxJVgQNfe2p8YmQcZ/Ju7tCpcfI4DWx2gKQdAaEI6tDw0ZPPxBUrapa6/OF/AVwdnkwEZFVq8t5nl5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJcnjIFsbTBKwFvteSmM6uqrlUcMB0AhXkeSbhsS4i8=;
 b=SvuSJhbRzm6gXhhkonUhbuz1uJZZvDEJMrfcqz9xqD8sPI/5cjVtq3FkLrgyw6rgkhJJBNppasOjYFBU8Ti0/E+N1dfyXP4lpeHJ4u3rHVv23mKaiBoVvIpk1N6mBUb6Zy6pNx7zTaJ/B+uljWWvUxuzNOfdQDgQ+hfVFzpSQfBdQhvkdwafsWplrFu1q2ASVmakZ6B/JWKFzV2NikTqKOXKS3H6EZySbXEvJx8vqLL0ISLGfEzU3uqZewkIm0JuvF+V+a+gFQSsSEp00AKNmd3fuvj/GDIMZ/P7uEAQRhtaAMCnoEo8JIA9waau6N0lP6HyuIEEfmqThpjKB3oy4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS5PPF7856D51FE.namprd12.prod.outlook.com (2603:10b6:f:fc00::654) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 00:55:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 00:55:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Nov 2025 09:55:12 +0900
Message-Id: <DE6B1Y80A2EF.80GLFFRD9VR8@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Jesung Yang"
 <y.j3ms.n@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] rust: add Bounded integer type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com>
 <DE5PQ3927GMS.31N4JGGZK3M1N@nvidia.com>
 <CANiq72nYgvsTLvaXkGDN6ZReHipZVSgg1BzCgjC05h+dmsFe3g@mail.gmail.com>
In-Reply-To: <CANiq72nYgvsTLvaXkGDN6ZReHipZVSgg1BzCgjC05h+dmsFe3g@mail.gmail.com>
X-ClientProxiedBy: TYCP301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS5PPF7856D51FE:EE_
X-MS-Office365-Filtering-Correlation-Id: b5205e94-6de8-43f9-d903-08de21862551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REJiaENnUTFDL2x5NTY0ZXM3ME5BeEd5QVA4a1dSSllIMWlSRHU4RXhGZ2lm?=
 =?utf-8?B?ejNIZDlqYjIvaDNPV0pUUjI1UVBXNXRaRkZSM0hjdUF4TnREelZSanFpYzA0?=
 =?utf-8?B?OElKcUxhVmRrUFVnTjRBTUhocDNobnprVWI1eS84UlFiMFBZNXU0ZWhrZ25l?=
 =?utf-8?B?cmdqT00yN2IrOEZoWjBQcHdiamZid29kV3VidTl0UTA3WEhSWkdyRVdHUTZX?=
 =?utf-8?B?Q3pCMWxhZlFLMXdYenB1N1VBYWVoK2VVbTljL1FXZ0VyMElxNzBNNFdzLzZX?=
 =?utf-8?B?dzNyQmlRM0FzK3pBNHQxZEpVS1hNd2VOSnA4R3RGblR6NzcrZkhmcDM4UzBw?=
 =?utf-8?B?NWIrVlNYNmNuQjJzbk9ZZFZiVERsY1ZhdGNCMmxiVjZFZnA1YTg2dWROZ05S?=
 =?utf-8?B?Vi8yWk14M1paTVplWHRUUWZoWlpmaTN0ZlFQeDh6Y2hHQmpORE13Y054RFh2?=
 =?utf-8?B?cFc5bFBpZzRZVVJ1VXBUMDVreEhZQlgxR3JhVTBNOHRiY0l6OTdHUU0yamdK?=
 =?utf-8?B?aTd3Rk1LVnJxSnBjQnZGcW5STlhtTHhrZEpXQldIMzFUdWk1K2pibmpJeDlu?=
 =?utf-8?B?YkNoUis3MzdOUUs2UC9TM3o4ZEdLbnNxS2JyWWtlaUNBVGs2RUdwaDNJYWV1?=
 =?utf-8?B?cExvWkR4MHIrRFl2NkQ0L2F5YndDdlBoNVc0NkVMRmJmMVF3MzBKdXEzR0k3?=
 =?utf-8?B?WW5pbUdOOHI3aTNUSDFHYlVSdzV4WTNtczFUbUo0Rnk0ZjBzSXhQQWp5dE55?=
 =?utf-8?B?djZlQTZzbVpERjdCNWU1NXNFVzJhYUJVQnRRdzNkbDNyREFUM20vTlRHS0tB?=
 =?utf-8?B?US9LaU5iUEdnZ0xHS2IxVHJiZktycnlmSXhKQTduMkdLdjg3eHE0VzFJS1lW?=
 =?utf-8?B?YVFwSWttdCtmMVV1SVl3R1Z2ZzhsbEZTZ0NrS0dPbEJTUVpKMUxONWpSZVFx?=
 =?utf-8?B?eURLRHRjTmF3OVo1NDFzVkRhdWY2Z0dzem90YjFXMTVMcWpoRjZxRktSQ1Nm?=
 =?utf-8?B?aHRZUmtZZEJ0ZHZkU3p5WHkwTFFLdmRZOGVlZ1piRGU5NDBlSndYbHh0MU4y?=
 =?utf-8?B?bXczS0tkclpRRCtKaW5aQ3ZaK0pQaGFFaW1lbkpPSjdZN1N5ZnAyUUhQdG5H?=
 =?utf-8?B?Rkg5YXJiZkJiWWhDVmJtOTdRR1phaGxtMGVzTTQ0VGFJRlhZZEV1eWllcnFP?=
 =?utf-8?B?YmxZNEdZWmtZY1BjbWVFb1Vod1UyWTQ0bjJMOWNtVGdkY2JvVDV5cHVSSmJ3?=
 =?utf-8?B?d3J2eVd5TFdYZ1E1MVBoQ0JnL291cmlpR1VCWEc0SFZidkd3M01YSHJQU1Uv?=
 =?utf-8?B?N01nUHYxcHlnTFVjQ0hxZ215aVJPcDZzY2FQbm5QY0dnaXBKd3FPb1VsYzUv?=
 =?utf-8?B?MXJmcHc2TDM5eWFsUzVSOUt0c2UwOUtwZnd0SyszaTJFQ3J2TEpINk5yUkJ0?=
 =?utf-8?B?OHoxbURuUGxvN2RteXloUFpieExMQi9zWVdiSzByV0JuYmk2SDFLSFVJTG9x?=
 =?utf-8?B?cFh4TmpOeE1Ud25ocHoyalpzcUdVN2plbUtLVk04VEZqR3dKM0FSK2NPTEdy?=
 =?utf-8?B?RmN1N3Y2MWx6alZCQy90VW1OUUcxZE55UytncnpsSVc2R3E3Umw5cVV6VVpo?=
 =?utf-8?B?WStHeEZkZ2ZCbkpSZnpXZGxGMS81RkVXNUVwc1NwMkpFRmdWdjh2UXhsYUtm?=
 =?utf-8?B?THR5STgzR1hDRjZIell2VUFCL2R6ZFVPRVFDaVFSZjFqZXEvOTdFN0tRRm1r?=
 =?utf-8?B?YS96UVNuRjBCd2FabHp2R1ZkM0N6V2k5Wnp3WXNSdEtocmF0cHU1blJ4NXlu?=
 =?utf-8?B?ZmJVZTlSSEk1U3lqc2VYa3N0dWxFRFNPQVVZSWlScTlJNHorWkh6L0VtZ2lo?=
 =?utf-8?B?VHphb1ZEK0lrVGRFNHM3MU5GdHpRYjFWODVsQUttM0UwTEpNL0szTVlRbmoy?=
 =?utf-8?Q?+9WyzmGbudRymF5LQOilbfx9cWnIVESj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2dGTVRISzZFcmkyQVJaVEVPbXlaOVg0dW00WTVwQ1dmRjJGZm1OT0NWTWl6?=
 =?utf-8?B?dDF6bVJWWW1sczZCN2xWSVlhb3ZENFltWnVhWjMzcElPK2Y3L1FGNEE2Ynd1?=
 =?utf-8?B?SkdMNzFqRU5JbmlKTm1qMTdRU2VVazJyZ1lza3ZsaTdoazQxbm8zWU11NXpG?=
 =?utf-8?B?eXloWGtybjFXVThPYjIvUTUxN3VmdG9ISDg3bWVNeE1YMGhmQUVXeHU3eDFa?=
 =?utf-8?B?aWxXODMvaHRTNzhpRDBuM1RDM3dqaUd5S1dMbG1pTEdoWnVXZkhoQ0lQVFJY?=
 =?utf-8?B?SjRSeXoyZ0duSSszRVRkZ2RCVi9xKzQ1eE9nTWdwbzhiMWhOdCtDemtWSTJ4?=
 =?utf-8?B?MlgxdVp5S0sydkxFYXNHeFZJMUErNDV2RVIra25KK09DbGhRWEllU1hMeUF6?=
 =?utf-8?B?ZFdMbUtFaWhiM1VPVy9LQy9hUjRiNWFmNVZ4SXNHaFp6bUFBdHRUdDNkNDNI?=
 =?utf-8?B?TVFzSUYwcTFBbE12dU8xTTRJUnBScllFK3M5UldRYWJXaFVIVGVhV0RMWnFS?=
 =?utf-8?B?TUpMckIwRTRZMjRwZjViZGdEbzlwRmpmc1d0K3UxT3UyOWJKcndsdE1qMUE5?=
 =?utf-8?B?UVZzWTZYRFZoRFRmbmlYZDZMUk02Y2ZCSXFsaFBueDRZT0h2dTF6WjJaZzgz?=
 =?utf-8?B?M2JENHlkWDVWR3dNandZR1lWaTVQL0xVeFkzOE1zRUcwc3F2Ynd2aFJaaGha?=
 =?utf-8?B?VlR2OE8zdjJEOXJ6MlZvb2pqNjd2RmFrejJ6V3h6dHVGVVZoMlFsQTM5bDIz?=
 =?utf-8?B?OU9zQUxPSGdjaFNoakdOSDFyUnNkYUQ5ZVJxaUFOSWVpL0plaUJHYS9pRjhx?=
 =?utf-8?B?VWhaMVROVXBMbTVHVXhVMXd0SGJKbXpHMSt3N3JuZUpJbTJOdEpaQ1RBcUNR?=
 =?utf-8?B?c1pzcWVydTUzZGxnUkc2WEg3UTR2c3RrbENhV1FHTnFWMWZiVUhPY3U1ajZW?=
 =?utf-8?B?OTY2Q3pjb1JLMFpUN2dxYklBS2MvTnM5aUt3dVJIM3JQQWJYenJPMXpmV1dy?=
 =?utf-8?B?V25XOFVnTHk5dWgraGVTOW85Sy8rejduWWlsTGFuL0tVMDg3Mm9DNVhhWWoz?=
 =?utf-8?B?Wm9qaUhsQSsvSDR4ODhFSkI1S1c1S3BxcDBiOHRLemk5OTU3Vk5GbUQ1Q2JD?=
 =?utf-8?B?TjVqSElWZHltSDh2OHRJSGFndDhka2E3TTh0RXVLSTkrY2FjYzZkY001blpH?=
 =?utf-8?B?ZnFqVlNaRmtiM3hpbnBTSTZza2hBamJjTHF6ZVlyeC80MmJUemIvZGo0WEVB?=
 =?utf-8?B?RDBpZWV5eHBPMnBiaFpIY2xjNTVCeGMwVkZJNkYyeGI5S2M0Z1hzQmtwTkZr?=
 =?utf-8?B?M3JDYzNmdEx4bFFrK2N1WmlvOUhVd3MvckxPaC9iSGtDMVRCWUdQWGlmZ1Iv?=
 =?utf-8?B?UzgycmVXTHlBOXBpUzlqdTVGTm12cndqWlZjRDdZUE1UK21tSFFLcW5nZkJ1?=
 =?utf-8?B?S1RsNktyTWtOVTBPaVpscjNEWmhOTWpJT1VoYU45YUhSNUovYmlvM2tDRDZq?=
 =?utf-8?B?WDRrVU5ZbmNVNUhaV0JJUTM3eFNSYnVwMTFuVnRkbGI3Tnk1V2tnQTlzS3Nv?=
 =?utf-8?B?dGpiNG5UVGRWWTdXRE02Sk5hWDQzZUdOaWJIZjhwbGgrOVBXbG9tRUc0cTRt?=
 =?utf-8?B?V0pCQjJXaVVGZ0hURkdOc1FmTWxaWlhBWDV1ZnRQL2tFVmJmd3VZcmM3VCsv?=
 =?utf-8?B?MU5qLzluU3JhNnN1Z1ArSWxrQVdYams2OVcwcGJzQ2FwaGxRU2h2cDZIeGJ0?=
 =?utf-8?B?YkJVVy9pMDY4WmwxekM5SWRLcjJidExWd0RsNTl3SkZPTTMrNzJqcHo2YVc4?=
 =?utf-8?B?RDdRMlBuZmo2dXdDWnJaNTF5OUh3RUx0Y1VObStnTGhoNXp2TExoWUdLS2J6?=
 =?utf-8?B?Z0JtdTIxTE1ndkJXbERQUktrWVJuUTVpY0xyTXF6S3FzaUwvWVIrd0FqRk45?=
 =?utf-8?B?dHdKdTJnWUpqay9za1g5ZEcxR0ZmVGlPbjNMc0kycytpYWdlMSsyVkExTXdE?=
 =?utf-8?B?TmxNdGliYzRvdHJXK1Rvd3ZuSWhMQ1lvVDI2YkdXd0M1ZWxDNHBpSWFvSGdU?=
 =?utf-8?B?Q2NsR2s1bzhCSnVoRkxSSzZzQXlaenErTDJGQXVYOGFYZ2cwMzY2RG81M2ta?=
 =?utf-8?B?ei9KMkFmVWZIUWllcFRsNldxa3Z0dVkzQU1XS1JzM2hLa2RNdHNvL3UwOXFV?=
 =?utf-8?Q?dYugDeRsgZdtV9HayfgWBgDh3d1ZqVp8jF0wIF0zuiv/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5205e94-6de8-43f9-d903-08de21862551
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 00:55:17.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msrGdj9EKlrn55AuDKBy0Yzh2KQ2p2msT2N3w+wlB49WyWJ2c+rbVjuL3m9canmWrtU0S4/WeJVMuU0+CdBm5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7856D51FE

On Wed Nov 12, 2025 at 5:46 AM JST, Miguel Ojeda wrote:
> On Tue, Nov 11, 2025 at 9:12=E2=80=AFAM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> Hi Rust core team,
>>
>> With -rc6 approaching, may I enquire on the appetite to merge this for
>> 6.19? This is the last hard dependency for moving the bitfield/register
>> macros out of Nova, so we need it if we want to tackle this for the next
>> cycle.
>>
>> Please let me know if there is more I can do to bring this to shape! :)
>
> Let's get some testing in linux-next :)
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks! What is the path from this to linux-next? IIUC we wanted to
merge this series (minus patch 4) through the Rust (not drm-rust) tree.

