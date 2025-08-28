Return-Path: <linux-kernel+bounces-789011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87658B38FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1277C1635
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682AE1519B4;
	Thu, 28 Aug 2025 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t9cl2Dgb"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E030CDA0;
	Thu, 28 Aug 2025 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340242; cv=fail; b=YP5hX5/k+5bDZe0vHCAhRwQBGVLglCYTdwn8VHrMrmF+1+rGkEXiTsy60lka8rf7AbzioC505YCB1rAGb99x0PkIwWcjYjp+UsS2o8d7mhs+58vFDQMtT6JczpiAV6LGU3nF5xnMqbVEAM3eb/9M6Fk8ghsp3cuU0kj3gOFLxtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340242; c=relaxed/simple;
	bh=/AvlK2U5pJIoWUYjbGv1I9dJqc9CTcZCwn9bQ2q8o0g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Y61g4uM3z/4Z3A0BrxiA2XZRdx/gFlabMHyIPS/jLx4L9l0hVuvkaiwfOJMtBV/Mb1iHevnabDnclKW8v6d3vKxEq6Cb9OUbq5mqs0DqpPWg9pYp3NvboeMpPTJHC7+aHOWtyz9FBFBHQ7TUucJMg2psFIFB31wXiNaPMFEiV58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t9cl2Dgb; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCaa8R10SoHw4Rx1ctqD962r0bAHtvLYnklVBbWDk88OerxBdwTNX2P3CnecGfWB2OHbABNLawE46E+25Wg+hz6Ndb6g7j/QMD6L7PSp8OjjTtG0OZGTkZ3/oSQ9o9vsQTZejJSQAxeqbkR/kOQ/r/p/dYkQ4os58dAkJVkAWTCyJx5IjRhJVQi1kzn4eygk2tn//8QLm9C2rK3y+QWGsgDCEr2ul23L3f3JV7FQXMiUY2vvVnq+9GHstNm1vMeVW5bFtNws9gNfy2zShxX2txcHKLNzMmvm2n3nXgFSrxatEJEyVvR680czFKZ8sSonyu+20/K2Meo2R1RhT+LMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AvlK2U5pJIoWUYjbGv1I9dJqc9CTcZCwn9bQ2q8o0g=;
 b=IciJZYhRIfalVDh97hTMyEQ8u8PV5l7I3e1lXQTQRzlp2WIVH0joXvj3FMu7xzaLxE5WEauS0zzpnwMFznFVV08nqb/hvB0sBDYH+RsfT5lvDB18qzRwBntyEGC6XEvHHU8YwvThCebx/8K1WsqnuG5CpoZvLpFZ2IUiPtuM7DMaB09gMdDjDh0bvq0S2J4flS/FWw745IvQdU1wkGRnr0l7CAJLDc+/gWyXu/3Lm/xvHrtQA8m6Aq5Q2OfqMZjPlhuvdsKy1tKu21HdUYd41TYgwOq3sOF/lfzU0vA/1rdwKe2LWxJ1B9+EMFV8iDkx+7mhDJ0c0gZSs3J+3r5XBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AvlK2U5pJIoWUYjbGv1I9dJqc9CTcZCwn9bQ2q8o0g=;
 b=t9cl2DgbKFpaHn7ZhE3Pz/VHwO68pOZgCSiJrJwWNXlHPggsmoxyLI2KkXvmpvRNkT+lgAqb0a2gBwcpmHSnzgn+nwYMHBmxJReu2nL5KI85K3f5IpGXIdTN1mNqtIb2us6HNQ04lczLi7KfynkwJ0TQ214E1xUBLu7Mbi0k3sItHL6GCsTNcMjEITwXDlwiid06JX9q6KhTEq4MhC/bVKL6zmU/1Dm9cbR08/NPPO+QMMolFDAC7nmj5zkVUmZQvri0HnL1d9DGcOgj0OSUZ5gH4ZeJM1h8sNPOV20kx748svunHc6TRovsuIFv0uDC9p5+kIz3zgqAoVHWE/0DGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Thu, 28 Aug
 2025 00:17:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 00:17:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 09:17:14 +0900
Message-Id: <DCDMNH6OY7NP.3UE5CGYETB8HI@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
Subject: Re: [PATCH v10] rust: transmute: Add methods for FromBytes trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Christian" <christiansantoslima21@gmail.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250824213134.27079-1-christiansantoslima21@gmail.com>
 <CANiq72kGh2PS-c1n2Q1g0t24J-b3ctB0kN3GK8RDXhtQMGAtTA@mail.gmail.com>
 <CABm2a9fQOMvg4Yjqz2-ba=1HwdXiu_Ep=Jsqz--69Vpec+iRXw@mail.gmail.com>
In-Reply-To: <CABm2a9fQOMvg4Yjqz2-ba=1HwdXiu_Ep=Jsqz--69Vpec+iRXw@mail.gmail.com>
X-ClientProxiedBy: TYCPR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:405:2::25) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2e9deb-aba4-4761-1c63-08dde5c83f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlA1bGtjREZXNDdYaGVuZlpQWEZlek5QSUl2NGFiYUNIbjU4SzAzc08vQzJR?=
 =?utf-8?B?RXVSdnpRNVZmcDNXK3VaaFI2NDYvMHFaRzRpcmFXNWkwYjYwakZuSmVCNEFt?=
 =?utf-8?B?cWVZMUQzN09IUXpRTDNFcGVCejVUeWpaajJ1Z0RteWFFQUhiRkhOM3JiSWxU?=
 =?utf-8?B?OUF4R1lkM1hDajFkMlZvdm9TZGRDc2drbWViSjhFYU10M2VNdkowbm80WmR2?=
 =?utf-8?B?Y0VRZTQvOVV0emM2NGdYbjNSeWxhYnU5eTVCMTh2ZWFhQ1hoZGpVQVRoR01m?=
 =?utf-8?B?SEdYNjFMR3dHUXJsekRqVXNyR25EL2pkLy9SeC8xdjNsNWpNQjRXa3U0T3ZL?=
 =?utf-8?B?aFRHTmpMVi9hQ3N1OVArNG5FSFZtTkhDcTZoTHlOaHNWMXBsM0t0bU1aak1x?=
 =?utf-8?B?dXBBUGhsQlBURmZaR1VWb0FhU2tRMmlqNm1uQi9mWDFkL1VFRDJzS0t4SFQr?=
 =?utf-8?B?bWJWR3pFakEyRERUZE40VExNSzgwM0pSQWlaSnJ4b2ZQVEJiblRjWjZBakth?=
 =?utf-8?B?aUhydFpBT3lvREJNWnNzSzZlTDVqZEcreXYzcEJCYjhsTEY5bnJ5Q09iYXRu?=
 =?utf-8?B?b3ZMM1JHZnkvQUI0ZEVqelByM1B0UVgvL3lNKytYaWRiYzZqbHZQRHVHUEZ4?=
 =?utf-8?B?QlZNazI2T3ZSNUhDam1vZEdmTWZGOU9jTHYxRnJiUVRIYWhabnFZTVltbzd2?=
 =?utf-8?B?S3pKdHBuTWxlN0hLc0U1YVNHYjlGVlJ4VkNQR0QvMXQ4ZnExWkhhSTZiR0tT?=
 =?utf-8?B?aUV0N0Z4aWsvSWM5Q0hzcW5FVW1KVGE4MUkxZHRtblpucDVJc2JneUxNYUFx?=
 =?utf-8?B?S3BjdHMwZFJxUWNiZXlRZVk1V0R0SlVXWENDc3A2VmFsbHlGZXp5c3BkM3Jj?=
 =?utf-8?B?eWxINXI1MEt4ZHp3MUd6MmNlK0hXSVAvZmV0MmNybGlXR0k1V2V1Z0s2cmFk?=
 =?utf-8?B?SmEvcHFQZU8ySzM5VTRwYzJvM2YxV05heXFwcXY5M1o5Z1RpbC9DYjNOaVhp?=
 =?utf-8?B?eWNFL05uR1pIYUo4cVBnZy9vMjBYdlNrWkplNDFlV1pBekZoUEJDdW05QnY5?=
 =?utf-8?B?UG4yR2JON0RTTHR1T3dGczI3SUZzc3czZkNDWVRubXQ5YXYxZkxJR2xGLzAw?=
 =?utf-8?B?OUdwRDEwMEZyeklScHNPQmQxbDI4bWRwVHRsMUdSVFl5bElRMlFzOEhWVU1D?=
 =?utf-8?B?czFCTnJjMytVMlZXK3BZcUlsTHdKbE4wM29mUDZocUt1VnYwdFB4MzArWVdj?=
 =?utf-8?B?bERxM1k2aUlZaDZlYWdKL1dFQVJHS3puL291VU5pVStkMlVkUmpqeHVzMDFu?=
 =?utf-8?B?SmFWL2pTUGwvRDlnK3pYcC9uaStuUElvWkgrOHVvd3lSckNvazFLWkpDOHV4?=
 =?utf-8?B?WXJkWFRubWpEbWc5WGI4TlBaUDgreVFwNmMrci9nQnF5YzJmM3FWUGpkTjFS?=
 =?utf-8?B?ckRkRG8zQXpPa2xiTHhVYkF1ZkFGMzVOcGJsUHZ3TnlTekdhbEpyU3h5QXpO?=
 =?utf-8?B?bDNUUVhEd2xrS0MwV3VETXFVSjNiUDAzN3dWd3lmaStHRXpQTkpSMHFIUVpU?=
 =?utf-8?B?MEdSeGhSZzJNQkY3dm5Da1JlblFCSkZaWEV4THNKZVNnbTgrWkExeERQTHdn?=
 =?utf-8?B?MjdvSVk3cXpPVXAzRFMyVk9kN2dxT3VwbEpLck5SVnFyaWhEMzJIQS91MGh1?=
 =?utf-8?B?Z0FWM21TdmFONFJLSDNDbFdUUElSY29ZY1RkRnV2VkJTTjBWQ3B1dE1EZWkr?=
 =?utf-8?B?K1RRZUk4ODNXTEgvVWdxaDNZR0w4c09IWjF5UHg4cW1NcnowY3V6b3FCUXZQ?=
 =?utf-8?B?YlF3dFlYSFc2b3hKZEJuall3M1dnT1hwL3RtaExBOW1KV1orLzNtMnY1S1Jl?=
 =?utf-8?B?NmVTZmNsamhYVU80TGl2M0RjVytBZUNBR3BFNi90RnJPKzNRUm1PYXp2NVo3?=
 =?utf-8?Q?ZBHlGb1iDi0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytTYXlwMFd4OGJUQjlQbVluTmpZYkt3ZXZLMFFIblNUVko4VElvTEFWS0p1?=
 =?utf-8?B?SkFGZ0VRZWZrbVUxcEpKaGEyVStNTFZUMTcvR2d5U0sva2xyVFo2cFJDV3NE?=
 =?utf-8?B?T2tNRTFDdUxwRXBXZ1JOY29PTEZ4RmxWVkExb3ZqY0JvVzBGcEE3Y0ZIV0g0?=
 =?utf-8?B?UzNld3ZtS0FVc0pqanpEOXhGTmNDSElyWDMySVFDVlQxb2IwSWRqYzdNd2lH?=
 =?utf-8?B?K0NtQW1xYkRTUnYxRVRITVRubWFTTnljOGNsMU9HUHJJSzkyNE8xTTRvN0di?=
 =?utf-8?B?OGVMS2JqeGp5b2l3QUpZdEMyYndHL3lZSDlMcWxTZ2xZM0hsS1JObzRKOVRs?=
 =?utf-8?B?VUtPWDRMZXFtam1FWWQvN0k4YTBUMUlJWVpTdE13VWw3c2hiYXg0NkphU1FS?=
 =?utf-8?B?b2pUc3VkNU50RmlRUnFSeERzV05GcVJJMzdLd016eU1JcllRQXdyV1pBTzhE?=
 =?utf-8?B?NzdJV1pKaDRKTFBSZ0I5V09QWWkvNG84RWN1N0p2VFJhOWZwdGNrMDZGZG1s?=
 =?utf-8?B?THV1M3JtRi84YjlFUlgwU3ovMi9DSUVLb3FldUJTMmxEMEZjSGRPZU5tdFIr?=
 =?utf-8?B?cUU4QlJpMVNxOGV0dDd5WVpzVFprZHZXd1REcStmeHhWQWc2TFlob25NQ2R3?=
 =?utf-8?B?c0FMZ2c4N05EVC9UUXFQWjl1Z21MT1ZNZE1yQ09CMHhvNzRVcVY1SDRTdXdk?=
 =?utf-8?B?dnhpaTcxYVgwU0UvaUlkMko0YkxZaFdTZFVvSVRXVlhjSkJPZk84Tmlqd0F2?=
 =?utf-8?B?bGpTR01IajBjK0w0Qm45L3FnSUxUOTVzRjZKSXVhek15ZWJBVjF4c2hiNkk0?=
 =?utf-8?B?OU9VWXJ0UjNtbmJBbnZLcE9JNTdGY0VuUnViZkNZOE11UGxIRTRsc3NFUDVw?=
 =?utf-8?B?akt2N1pzZHFhOWpTZ2pCSHN1WHpQUkVPUlA0eGpvMlh4NVJ6THRuUXBLcXNV?=
 =?utf-8?B?T0gzT2U4Ny9XTE1ZK0FBTk52THVvTkNvNkIybWVBU0FQRE9NclByWDdKaWM5?=
 =?utf-8?B?bUwwY1JsbW1VTm1UeGpjR0hMY1VmNmE3anlXUlFCUXBESTZ2SlJwRXc2bmht?=
 =?utf-8?B?RFRkOGltY1lqSGdTVXNTU1ZuNWpXWnVHeVZvM3pseU9LMDcxM3BuTURJZ0Jh?=
 =?utf-8?B?UU55Z3d4T3YxRFhmMUZRa0dKcnl1M1ZadEtvYWJHYTlmN2orZEcrMXFJdmZ5?=
 =?utf-8?B?QkNBcE1jdldqMnR1VVdiRnBDcHJ2enUvNXRpbTlqVTF3TE83YUYwdmRwWDR1?=
 =?utf-8?B?cVRHVnNOVzRrMXRabTh0THVrc200OEpvTnY5VDkydkhrRjl4Y0FuOFp0Sk9i?=
 =?utf-8?B?OUh2dE02RDdkQmpwV0pLOGg1aVhnV1RWNUE2WWFJQ3A3MTgvMFZ1WjZxeXlm?=
 =?utf-8?B?L3VzT09OeXRGUzR1akJHbGZwWmFyVVRoQy9HaURWYUZPbzYxL0FEMGJJTnJX?=
 =?utf-8?B?ME9paXU0Ui9PNzBPd0JVMDk3WHQvVHhIbk5KUVd1bjhaWUk3TmZ4TDBodG13?=
 =?utf-8?B?aEhldzdPS0hmOTd0VVFnbS9ITlRVTlFIZ0I0eU1meFVtWGRpeG1hckx4VGpN?=
 =?utf-8?B?NGhXWjEzQytWaEUxMlRQOGlGNUtmaTJyQVoxV0hXWDJOUkFyaXdxaVNhcE8y?=
 =?utf-8?B?YkVpQzRWNU9OVUM4OElCTUFEeisvOUYzNlNETG1JV0I3TkI4ZkV2ZzFYeFlr?=
 =?utf-8?B?NVBRRXJTRVgraWkxSFVqbWd1ZTVPaEdwTjZVYWpBbkI2djZ4UmNZU09BL3Bi?=
 =?utf-8?B?NmlySzVjcXRjUE5mZ3JDSkhuZTROSnpjUnlLTUtpaXhRa2lzZEZoTU9xRS9j?=
 =?utf-8?B?N2VjUVRxTElwSmdxNzFHd0NMajhmMS9jaENBandpcERkN3lwYjFDNWM1eVoy?=
 =?utf-8?B?Z1BXQlJKYnQ0V2FZMUcralF3MGhHSFp5WTNwaHNobWo1K2NkTENLSVFvN0VB?=
 =?utf-8?B?RHF5WGFuUkE2RWRCZTdtZ1p6T1hidzlPWkNKM2wvZHJpZnJhNXRmc04xYmtB?=
 =?utf-8?B?MWd4eFpHeDdiaXVXN0JBVmsrY3NpM0I4TExoTTZoblpBOGRTNHB3WGVKY3Qw?=
 =?utf-8?B?RmJnNGNmMlN1M2Z6aVFXZDRrRkl1ZXduQnpvNENsdjY1UWpRREJORG5yZ1hk?=
 =?utf-8?B?ODZtT1p5QndZTGhaRjBEeXdqdU9zeEdKaWpsd1lOVkxWSHl2TzZQYUJJSEhG?=
 =?utf-8?Q?FVQb9xl1/QxyRopZmwlC7Q3oBywrZDZZ9tQDe7Jdr1/k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2e9deb-aba4-4761-1c63-08dde5c83f82
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 00:17:18.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsOdDnK1mo2aevWVhvkeW8oN2jf8WJRC4jNYcRqI3gRYSpaPBrZdaJgYtdaheN9MrlQoGSmzkFrDlRR+ry5Z9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

On Tue Aug 26, 2025 at 4:51 AM JST, Christian wrote:
> Hi, Miguel.
>
>
>> > Link: https://github.com/Rust-for-Linux/linux/issues/1119
>> > Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
>>
>> Please add a link to the original suggestion if possible. If it is the
>> link above, then the tags should be in the opposite order.
>>
>> Did Benno and Alexandre both suggest it?
>
> Benno suggested the link to github in the issue there. Alexandre
> helped in most of the design. It was a mistake by my part not to
> specify that. Even if it's good, put you too as suggested-by, because
> the idea of using `is_aligned` was yours. Maybe Alexandre can put it
> there?
>
> If I understand correctly, should be:
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>,
> Link: https://github.com/Rust-for-Linux/linux/issues/1119
>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Link: https://lore.kernel.org/rust-for-linux/DC5INTQKY0EX.1T4HD6OU8C4PI@n=
vidia.com/
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72mnxRquFmjoJemb=3D3LSq=
+ZdUfs9J+HXTwM6AavprsVNUg@mail.gmail.com/

Unless Miguel disagrees, I'll just keep Benno's entry as what Miguel and
I did was more part of the regular review process IMHO.

