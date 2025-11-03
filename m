Return-Path: <linux-kernel+bounces-883020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE857C2C492
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B460A4EF959
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8730F94D;
	Mon,  3 Nov 2025 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9Ii0nck"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DDD291C19;
	Mon,  3 Nov 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178257; cv=fail; b=JgwVk8RP5WNhctCxrbC4iJJ8S7wivkBVgZfeMg7HoIQMBV8aPd2cc3NT01V/nfRz6P3ZRyAE4GcAPTrrZ94WuKYRABze+hGRyXtrvglyMAwlWHJIELg40wK91lfvWwXpeSCuevts8IJRfjH5CoBCndvqr017SQRxqb6UUfIixQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178257; c=relaxed/simple;
	bh=wEE3pVE5iTVSLJrmqs/PPA5Bd3ro3r+LCLc+sgaQWjc=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=ucdwJh01NUV4u75ZD09Ph3v+zbM18D19z0fjl7dXg4QVYafHdB/jFBsC3/kH26CfWqt8+8SLSHvSWzcb8FMw5z8cJYtaz8ziWJXrTl5WwPolRrQSUAoyFnNgPzWPYOPsK6QylWs5a+o21xenpYF0PXRkDOj+btD5KR3n0O0liUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9Ii0nck; arc=fail smtp.client-ip=52.101.48.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFYkKs1VIJ21Ky4Uez96TiRU+HN8fyjfYKjOI5fmAW96K1EX+QdcKi/rDxCUZdAfb1rOv1F6YGdeE4x9X3mqn3NeI8Kdq968+cmywKkSDvLZaC2vOHXHK7coQHK8S581zj2ou7i8bxqodWytI+jMx9zVGp+QDFFiEsHy1sZp8Y553aglFV/FfmPAGvGjt/39utS3jQD+01ghxuwcntOQIm7ho4nXjAWWjp3ETiJwGDW8a/nZTgnXwRqf5pHvYTzxVUNXYD62RwtYShb3xI+M7OeENocY/D7NaN+xe6vaV7QSOM8WzgpqGUSG0OVp1fmjC5WQtonLxZny9ULN0fTSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEE3pVE5iTVSLJrmqs/PPA5Bd3ro3r+LCLc+sgaQWjc=;
 b=Si2xRNA9Vfin0BpnRTy5Hgu8d8H9cms8ZNhJg6ltqYKOuvf8yU34hoF8L2ZR4Ggqo1+46FOTr8sdj7VlddRWDmzA+DK/XSexW1tFEhPLXHuXGn0GB6xFKnw+76DVH/Qai1UqnaUoddE0KAqzexeYUvByuhwyWrwTQei/msLseQrbMsoU4DdSkx3rrGQlPpumn7lle7kC+9Z+luTMvagyj5HSgJSe1PHnE88uu24x9kdRdj0sg1VcGvRFIZZ+2zf7te2V4ybdcrU8a3bCsT1Lc2WYXEKJZIg2nMhWGgX7H+D+78yOu/16gNC4Rut9GTuiC8VJGsj4IopW+EuAH85BEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEE3pVE5iTVSLJrmqs/PPA5Bd3ro3r+LCLc+sgaQWjc=;
 b=n9Ii0nckmh7l5jK3t66XOKnyQsEJq16HN/TmOy5qa8N+LrRnWHtokjNvVQIGhR0dJMWNTHSMhrQw82NL/HFHN0wucUN5qKKNAnOKcYfPLc193juNezalf/zOT+Q3zUoiOE5bxBTxlut1ukZ63/qu8zbvUvGztI/NtlRje0Rax/h1cdvK4S16fjQx2El0aPPHF8cczhRwlAdI5opKGdPP6mAO+qeaN00uNulPn2I9YRB4/30sYZZyERbYTQbnO4DjUSE5F68yYV2Q6mxSnOxAI99GmSpKbD8Y9q0z/n2OuPF9Jy6tU4slImKycLwGggY8tiGdxD35lIqoElFoIH39jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:57:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 13:57:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 22:57:28 +0900
Message-Id: <DDZ41ZUCG09M.KYZOZGQ2TRGT@nvidia.com>
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Jesung Yang" <y.j3ms.n@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury> <DDZ3QBBUM27H.MJS1S3WHWJO0@nvidia.com>
In-Reply-To: <DDZ3QBBUM27H.MJS1S3WHWJO0@nvidia.com>
X-ClientProxiedBy: TYCP286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: d50d040a-6136-46a0-89b0-08de1ae0ef34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWVjQzFhV0RCeHAyWWdVNlY3R0VJczg3VUY4Uk0wcU55SjRNRWVjbHJic2Iy?=
 =?utf-8?B?TDR6Qm9zaUE4S2tvVFpRNG51eG00NnpwWTNaVmVLVzN4ZUJpbG5ydUo1Z3JY?=
 =?utf-8?B?QnU2N0d0dEt5QS9NMlZZVExrNGJJOG9QQ082am9NWEhwR0ViUjhSS0dvOWNW?=
 =?utf-8?B?TSt6RCs3MnAybUdXaHc5Y2x2b0xXUGJ2TW95eGR4dkpNRmw2N2hMR2hncmww?=
 =?utf-8?B?WG1qeEtYRkNrbUxMNGpucnhlem1xanVSQTg0VFE5dWl2TndYQ2VybEJJb1My?=
 =?utf-8?B?eFJSL1hIZlRDQ05UWmpjZ3hoVFhxWHcwMjZ3V3VuQnNmajQ1ZWcvTG5rVnhG?=
 =?utf-8?B?QXRhanBLdExJaUxwMlpNdnhTUC82bytjWUl5SXN2N1kwRklWRjhtSDl3bVZ5?=
 =?utf-8?B?ZUhZbGtleldqVDk1czVmeWx4U0lvUE5jV2pOWEl0N3ZJTGt4eGIwVmxwdUha?=
 =?utf-8?B?V1lKVzFqYUdsSllQdVpoUFB4b0FmY28zZW9xK21nYjFabjFaODZZNGJINndq?=
 =?utf-8?B?cVVkMGNpeDB5SHI5Mk1iQjRDa25uSUwrLytVbHFTR1Z3RjRqYm1iRzM2L2pK?=
 =?utf-8?B?RmlCUnVwdzRwejBLZ2VlZVU1YzZxQ1pwb0RuZEdiR0x2aXhwcVpDMHc5cTd3?=
 =?utf-8?B?NmREQVZKeHgwUUQrUmR5QURDQWFqeHdScmhrUmdBQkJzNjhXL1VtNDZqbVIx?=
 =?utf-8?B?bVJaaXFNUUFidGs0RzZwRVYzdHpkTFdBeThlYjlIVUtCejRPWmtaa2NwQWtD?=
 =?utf-8?B?S1N4MzFISmpqMSt3TFFXUkxldTFwa2dKTU5FNlhlMDhrZGtwL0dlbFJaZmdU?=
 =?utf-8?B?Q0QyQ3R2NGxPSmtuOWRwcThZckpHYlhuQjNEVXdTbFJRNzlaYmR2eGFHR2lN?=
 =?utf-8?B?cVhQZGZudDdXb2M1RlZqb2RTZGFYTXdXT3ZXVW5ncytsSE1QblJHWm5UcUtF?=
 =?utf-8?B?NWJKNzgwUkRPN3V3ZjZOc3VzUm80cHZlUWZweTVzOU1tdjVqb3M0b2hUODZh?=
 =?utf-8?B?TkQrQVdoR08xVVJXL2hpcDhkQzN6NDl6eU1nQ1VTT09PMUhWdDBVeU9GT1I4?=
 =?utf-8?B?Z0NqUWRhcTFkMTlQZEJXdTBzTnJCUmIwNWJEMml2d2hQak9rWE5ZY1FCaVZu?=
 =?utf-8?B?UUZ1a1N5ZHViTzRNcW56SzV4ODhDdG9zQ3FZeFYzZHNVOFk5bkIvTE05blI2?=
 =?utf-8?B?eTFDU3VMM1hTMFhHVi9iTlpCUFBXVWFmWkxDRGVoaC91U0g3Szh6a0RCbjBR?=
 =?utf-8?B?bFpxQ2YrMGdoUGVNQkhseWxkdGhQdURrblNBMlhEWWorTFN4WjZreHNMODVx?=
 =?utf-8?B?MHlmdkR4N0wyL0ZGL3FiTjBTcC81RmNGeHhKUHhOTno4UTc3U1kzeGphcE1R?=
 =?utf-8?B?RHM4bDVwMldwdDBHOEY0Ni8rUzQ2dHFkeWF1NHlJQTJ5K0FOVXhDVElSQ1J6?=
 =?utf-8?B?ckZUM0lHSmg5L01KQnZMQkYyd3hzdG9MSUR2OXpKMklaQ2NQV012Sk9wS2Qr?=
 =?utf-8?B?ZWNPcHBMVjVyZ1dJM1pjMXRVWk9CdkNCbFBQMUVqOU1jZDkxN3RVOWEycll4?=
 =?utf-8?B?emNJaGlRc1NHS3g3aHcrSWpxUklwVlZvc1VFMURHQkd0c2oxUU9oNEk0UFlH?=
 =?utf-8?B?Q0h6Unp0REQxMVJBaHJ4a0FBeUpzM0RpaXR5WGs3eFczV2w0cHdhN0w1TDdi?=
 =?utf-8?B?RjNPQUU2ODIwSGdJREtBcHVhSGpjUE5SOG91djB5Z3UvUCtuZndCZXB1bXVM?=
 =?utf-8?B?Z1NIYURNdEZhK213ZjJjcjFPcXJFUTAvVXZNbkl4MUlFU090aWwyOU5kbWpM?=
 =?utf-8?B?OUN6V0JFbHpDbVR2VG1Hd2VoVG1QQ1p3TG1qVnNDWjY5TXYrelE2Q05xZWhW?=
 =?utf-8?B?Z3JVZ2xEV1psLzFYK1dFWTAzZVdVbUN4VHI0VkVJSUZwYUd2Q2dHR1FFZlo1?=
 =?utf-8?Q?A4r8UXNDjA9RR+t23zdEqGz8dpCD9kLR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTlIdFkyWTFHUGpkdnUvRHRpdnpvckNXVUd6OU5HaVZjYVhBUFZMdzlnWkRq?=
 =?utf-8?B?QzczL0hXL3ZUWTJGWEV1WC9sRkcvUnBXWlkxeWlnWFFLTXdzSXNCWU1JZHM4?=
 =?utf-8?B?bVhwYUZuUzFwdUNPMlgzZHZHZWZYQTlpVUgwT2Q3UUExR0NVRXZTNU94RlQ4?=
 =?utf-8?B?ZHVEQ21BdEJPV2lCNlhEQXhTb0s5QWIwMWdheng2NHNiQ0RYWmxYRXhXclV0?=
 =?utf-8?B?NjdOR3E3ZHF2dkhmNjczR2pBUDE1T00xbkhLY0FtLzIzMWliUmp2amRLaE9z?=
 =?utf-8?B?SmY4V3RlVnhMTTBadGRQcEs2TnJiVDhab25oL3ByTU81NVhrZnMzUW54aTlh?=
 =?utf-8?B?NXdVVDdwYnVlRHBzSm85dGpWQkVpWEMyWTRTc3lUQm1IN3JQUDZML0hLMTlu?=
 =?utf-8?B?Vk1yUEdTUjVYUzVqTDZXa1NOYjkydEZuTDlJNkU1N1huUTd0Zlhka1dJYkRO?=
 =?utf-8?B?VmpCaUkwMnhpS0hoSU5Wa1dYZGRNemwrOE9wa2Q0U21aUENjUFJWL1M4cGhp?=
 =?utf-8?B?VkFQVzZPNlE2U0hVSXFleVB1SjNtRUxBbWhXR3FHTlp1M1h0VHNIM3M3R0xp?=
 =?utf-8?B?UDVWL29OMzM3bGFXOTR0cjBXRHpQamk5UkpKYVpJQ0hqazJ6dVRJOFlwbUFv?=
 =?utf-8?B?YTVQUy9qVERYVVFPNCt5ZkZiMG0xcmZoVkRtdnlwYnN0TnVnMHVQVTZ6UzBB?=
 =?utf-8?B?Nml1WjVjT2hsZ0QwRkhITVBDUExNRHpKZmpQUjRRZ2hHN0JIOHBCUVdJdzRE?=
 =?utf-8?B?NFNHZUVpREtoMi9QcFFMc0ZaK2FEYzdiQ29rZ29XcXpGWUk0L3RYVnQ3TXVI?=
 =?utf-8?B?bDZtdGpqMEpMQ3IyZ2IzRS9tRCtCRDdPbW9EdnZpcjhNWnp3aDJFaFlCWjZJ?=
 =?utf-8?B?THhTM05rZ1o0eFE3UGJNZnJGR2IybzNBS0poaHlvcmNuODV3TkJFYmkvM1ND?=
 =?utf-8?B?MXNXaEN5QUo1VlliTlNPTmpoSHp1VWtEUVI3Y0FXTDNSbmw0a2FjOFcxaWFR?=
 =?utf-8?B?K3ViWFo2MFVjSS9XZG00ckV0c0hBZGF1NHB2V1B3WEVNcURwRWNuM0FyWUtw?=
 =?utf-8?B?bDRKY0h5VjRpSE15TWlKaTJEQTNIdDBsVUx0MlZQR2xEWE5ITnEvdGp6bkNx?=
 =?utf-8?B?NTg4MzF3a0pXeXpoelFaUGpiQk40aTRKbGNGM0dlZEpidmdFaXltL1dNTUZJ?=
 =?utf-8?B?bUp6eEoxMlJNaWluRU5kNUNyVm81R3pJOVVmcnAvTk5aSjl6WXhCVHpKN1pw?=
 =?utf-8?B?L1VkdGI3UGVCQ01NSTQ5MmRqWlkrQ3hGenZGbzdpMFNFTlJMcE9qWVJNQWZm?=
 =?utf-8?B?dERJWjVxQ1kvQ2RYK3JtdFlxSUE1eUtPbWZlM0pZb3phbU13ZEh5OXI2QkdJ?=
 =?utf-8?B?V0hkS0pPMngyMktLb3UzbnRMY0srNkxLZDFETUtmbXliZ2tQOGsrZExyWW9r?=
 =?utf-8?B?WGo5VlBvSkNCOVZ4dVQxOGU3MjhZb0dtZjhUWTRjTmhTYTRYTktsVUUxQ2dW?=
 =?utf-8?B?ZmI1S0NGRisyVjVHRTFDRTNrRFo4YXJUMjZiaEZhTzI5NGtUNGdMTFlET3Vt?=
 =?utf-8?B?UGdBbWlnUXRsdmlXNUh5UmUvNzhvNnU3czczQjdEZ2VzaW1pcXBHZ0pCZHBo?=
 =?utf-8?B?d21MeTlBWmZEcm10S3NIOW1POU80M290eGYrYlYwN1NFUStpakN3MFFhQmVt?=
 =?utf-8?B?Tk5VOVQ4RGExaWoycHVmaFZCb0RwMWNhNVk4WnVzNjdpL3ZhZHl5UW1IQTlq?=
 =?utf-8?B?MUNSd0RoV1FVWlp5T04wZXIzT2txc2x4ZDhwOWNlN3NNUFRLem9zYXZGTTk5?=
 =?utf-8?B?elRzSGk3dGdZbEs0MnlIZG5BUGxWNmxzMkp4ZXpJWHVUdGJNMjRpdUY4eEhU?=
 =?utf-8?B?Vi9WVDI3QkJVYjFEejdIS2s1enlZQW1BMjZyNUpxeTFBbVJzUmdGSGx2NDdu?=
 =?utf-8?B?VVUwZCtnWVpZSVVFWGV6R1NGZUNXVURwOWppcXFxeCtvZUlSVE1pSmZxczc4?=
 =?utf-8?B?cXV5cFVDSyt5N3BnRHhuUy9WS0ZabVVMNTh1UHV0SXBNSGxUWGgzRXgxQmQr?=
 =?utf-8?B?SUIrdWJOYUx3c2tLUlZLL0h2djBuYU84R3R4RXZqaTRnUlpsTlp2WkMwT3BG?=
 =?utf-8?B?elE5Z2FVLzRQL2dTMnZWcng1ZkhObWxKTzJKbDZJNVY5cXNtZGd4cXgzQjlU?=
 =?utf-8?Q?pejD17migxzgDKxBXsrgMLyLiSTEZEXeUE4337kmSLV3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50d040a-6136-46a0-89b0-08de1ae0ef34
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 13:57:32.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wivRIn2StYMmvUcfii2LQBU/lwr6cV4ySZozD2jSDxaTgibCpoD69Dmkp4/k7g8Ko43gpmzyo22OxQlY8lGsIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824

On Mon Nov 3, 2025 at 10:42 PM JST, Alexandre Courbot wrote:
<snip>
> After comparing this implementation with C's `_BitInt`, I have also come
> to a more fundamental divergence between the two.
>
> The C `_BitInt` is used to express numbers with an arbitrary number of
> bits - which could be less than a primitive type, but also *more* - for
> instance a `_BitInt(4094)` is a valid thing!
>
> Which is really cool, but also not something we need or want in the
> kernel. Our purposes here is strictly to limit the width of existing
> primitive types to provide extra guarantees about the code. And even if
> we wanted to mimic the C `_BitInt`, we simply couldn't without compiler
> support as literal values larger than a primitive type cannot even be
> expressed.
>
> So although I liked the `BitInt` name, that makes it quite a bit
> misleading for our type as users could think that they will have an
> equivalent to the C namesake, while the purpose and use is different.
>
> The original `BoundedInt` name was a more accurate fit IMHO, but I hope
> we can find something shorter.

Actually - the core library names similar wrapping types `NonZero` or
`Wrapping` - not `NonZeroInt` or `WrappingInt`. So this type could just
be called `Bounded`, as its generic parameter makes it clear what it
sets the bounds of anyway.

