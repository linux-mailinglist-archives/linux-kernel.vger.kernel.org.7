Return-Path: <linux-kernel+bounces-721563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB142AFCAF9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8613A4D95
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8D62DCBE0;
	Tue,  8 Jul 2025 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="po6FVY5x"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C52C17A8;
	Tue,  8 Jul 2025 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979084; cv=fail; b=krJ7Q3sNeiRW28/zmoGDPtYup4nAviuVKb//mDc3j02EutBRB0v5W48A2SUvuyC64dqxrojiwlxU+vaT/ZPtVMmf3ezDrtkZfI3eKLaCyy9mKwlOULYwYBqQ5RMsCJk1co6p5KNxRAhDcyZY/uylCDFSZ/C5csP/kJ6w/deXQLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979084; c=relaxed/simple;
	bh=EXzt/nKNzuabSYrlOO3NU3OTkQZKUbXls00PQmts6Z8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=cN+0HG59RQOh/wS47vspWchheefqPSXrcc3ryOQ6+y0iBBqioPXFoUzyOEbnCUVLd7NH/cAxrvmdxqE8IrJJ/0e0oXbxoMlC18aODMDhsN82DoSUjLIOr5mnTra5K3bJeLH+MNohbNGpPw1dE+Fxm7HgWe12z+ecl7DMTUIStEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=po6FVY5x; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5Y/JimPshgcZgjqRT7nV2IZG+YGJgwWMC1mdYtUKSgngPhHLyIq78PmAV43S+Efi7/vwh2iCQwXF6sV6/oPUKqLlmPeuhhw8oYpQvkza+YgrioNlb610n7tZcLlhPVs5EgyC0UOmiPawH1kB8UvMo54IQxyJ4P10Kg86w1h6P5ERvarMh2WJdSOfrfqgHY0Hg+dZh2kh7eVcpJfiJrNRIcgpbwYiygoA5tpgVHMpan0dsnY3SQUFjOBK0rs1KsnTDNf92lDTxLuLAmXc4R67/5ybd0UE8fEjJgtB5tFOeOy9AeiP8fdC7UzazNmjPUR17EomabzMJU8QZLEG3sOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXzt/nKNzuabSYrlOO3NU3OTkQZKUbXls00PQmts6Z8=;
 b=Bi4K/X3zzIFekQnVfynd03iyIZAm31cTq/3nKlfh895yOkvqTd38NaAfL4AS7Ugtp2uujt9UnKRKPDcwADQNGI6yemnfDMPLPt8N13QnSMyT+HE6PYTWD2sfE9lC0DM0dJfR+cyANasPiZMoZCEWW0RUEBVMWVxj9tIKZxYG81K94uONOhcRvxuRvbF+YyvagNvsIJGAjADNqHK+AYB2BBu8ZXuCxVzszuNWtp/7jdswA1Ebck4kOgrFRsSPkORklf9Y7vzhIdXCsBpV1/kXyO/DauJyV6DMUBp/OeC9BxExcPjQliEDe+3Ag65Eb8HFDGgyQ8mVWQCFXaouaPao3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXzt/nKNzuabSYrlOO3NU3OTkQZKUbXls00PQmts6Z8=;
 b=po6FVY5xuXpa/euEM/Sqgk3XstlciWuHOFRpVOaSLGDhUU36GlRl7VKyHlkGvXiiL8wBANyMY/6MSjQEhldepNc4RmzOxKvJywIBzPEWN+iIaIKFaT2B64fJLVw7hYNYK09UO6xGRcm6onPpCjQZrvXAV7+U+JTnxFPqwgw7BUe54j7bCuBo1nSTTCSUh+YHSbkXIZX3TZMlFOs+W+X6caQSU7Ypnr/r1Ouc9+0W8NlfKmZgyTMge7P7WR/19DaTtse8V0Xdit3XnM9m0f/HegRjNJE9Cgd3ZzLrArhzOms4Z2hd5TuCpZDwkpDagVRqIgNdjgjL6tHhSmw4XLnwWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 8 Jul
 2025 12:51:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 12:51:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 21:51:13 +0900
Message-Id: <DB6OQZFVOQ0A.1L90ENF8SAW3I@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <mattgilbride@google.com>, <wedsonaf@gmail.com>, <daniel@sedlak.dev>,
 <tamird@gmail.com>
Subject: Re: [PATCH v2] rust: rbtree: simplify finding `current` in
 `remove_current`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250708075850.25789-1-work@onurozkan.dev>
In-Reply-To: <20250708075850.25789-1-work@onurozkan.dev>
X-ClientProxiedBy: TYCP286CA0132.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: c15c6d95-7aee-444e-9366-08ddbe1e2110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGFxZThUQUtpTUtOMTJDZ1FKcXJkN04rWk1IU2FCV2s0Q0pyWTZpakxIbHRC?=
 =?utf-8?B?dzVEam5BSFNFU0VzVzRDV3M2Zmk1TnptVmkraS92eEJlWUpxcFI5SGtheE5M?=
 =?utf-8?B?OFJaK0JXMVNndkthUGN3cUpPM3IvMytPQ1pEYTczdnN0ZGNMYnlaazZEMkJH?=
 =?utf-8?B?ZVVjelErd0pXTzlWcldNdGlaRzh0NEw2TU85Q3l6NWxpTS8rU1Vuc2hoNjZ1?=
 =?utf-8?B?V3ZZQ0drVm1uckFzR0ZSLzViYnM3c3pJOTZaS2Ewdkp6cGZwQjBGYTkrd0gr?=
 =?utf-8?B?L3kwMVBZOXBCZVI2Z0hmdExNcDFaZzlMTDYxV09UZnZFckJwUDIxV0V2KzFz?=
 =?utf-8?B?d0VNS3IxaGhqZnMyK3FjMG1jdzJDSDFubUpiQ0JLYTAxZ2N3TVFLTXVaK2Nj?=
 =?utf-8?B?SWI0WWF2djF4UCt4bW56RDZLWnVaNVJYWTdIT1FYU1g1b3BTQkpaaldoOG5C?=
 =?utf-8?B?NUJKTUtFM0JCNXRUc3pIWkxqanRRMUZSVUhKWjVpMnI3clNGZG9QOUhubHBP?=
 =?utf-8?B?enpzbzNxNk9HdCtDcFVHbTNTT3o2dCtMNEZGU0N2bURydEE5WjkwUXpvVlJ4?=
 =?utf-8?B?c3ZTdWM4VXp2ZmlHdk5FMytPZ0NtR2dOcUxIUVFxL09tU2lyTVNCbmVUYk8w?=
 =?utf-8?B?NG5ObE1SR0dhSzgwN0Q5azFFK3FtT1E1QXVSVlJLUXJEMW9uN2N2czJiaGJ5?=
 =?utf-8?B?SG9NT0NTdzZIWkVGOERkaE9oYjZUY0dGZWUvTDhUK1lCYnpZQW96RTMwdFBY?=
 =?utf-8?B?UG1vSVNoSDdvdGtIUVN0TFE2ekd2cEh0RHpHTUw3bmJTbmJBNlpZdUpKeDYw?=
 =?utf-8?B?aXZueGVxOHhiWmVMbFM2Y2hpTkd1eGI0SXhESHczcWxtekJvNGVqdkUzdW9i?=
 =?utf-8?B?cEJyd2ZYVEZDOThWQW1ZNEUwZXJkbGYzZVczSmRXY1RPRmxURmFVUUhGSnht?=
 =?utf-8?B?QjljaHdVemJWVHhCUlk0SDBid0MzWGwydUJhekFRSE1vb1NVazlETWJIeFBk?=
 =?utf-8?B?cHFKMnhJQTdlUVpudE9LYkFRR0lHNjB6MGJkU2R2MDhqcEtJN3ZDNEZFWGVE?=
 =?utf-8?B?cVl4K0FESktvVE05eUg1U0Y1ZXRUV3Q2UmZXZ0hxQzhmQ2pIMHVCVm5HTnc0?=
 =?utf-8?B?dDdmL0N2QzFaYnBSQTJqU1JhK0E0ajVjcXdQSTloOEpib3lNRzk5WGxEREhJ?=
 =?utf-8?B?WDB1aVR0azNaajUyWGxJZHQ1OW9lSlBLWjdEZEFCb1dkbFlBcUhSd2lKdSs1?=
 =?utf-8?B?WENEL0hDb1ptOVkxWXFEcEk3N0VsOHlVOWVEOTBCdWRveWNLWGZqNElMS2d0?=
 =?utf-8?B?OXV6aUt5VkNYaEpZOEprY1dlUWp2Z0JHQ1RFc3kwV0w0TzIyS0tRNEN4MHg1?=
 =?utf-8?B?WUFDTC9nWDljaDh4eFY3eTcwcmpJTWlpVkNmeU1DQ3JZZWowcDhKc2s0VWVn?=
 =?utf-8?B?SjBBaFgvSkF3YU40SGtrK21BSlVvTEFrcDZqT3FST0hGN1FQTXpWdjlnbHg1?=
 =?utf-8?B?OXpzdzJvOVNnMHRSbHJHTnVSR3hzcDlFRW9naUFFQkNGcFd1TTh1NGIxRENn?=
 =?utf-8?B?dUhVUlhnbTFzb2dhc21scGlhNnFkdkw2elVEbFdMbmt5ZUdET05oRmI1SVJU?=
 =?utf-8?B?Tk9OcGtwaVF0T1ltcjRGRktNcyt6Q0d0bHlRZ3Y0QUliUmY5L2xqa2wyRGF5?=
 =?utf-8?B?NWhubWppbm5Remt6VkxKQmt0VjlGSWNLWmZROUJsTlp3akxiYTdSZDFEOTJr?=
 =?utf-8?B?U3lSOFJoQ2RjOUx4RC84Z3hwSmJ0Ykd5STl2OGtDN090TUxIem9MaXlXbDYr?=
 =?utf-8?B?K3J5aFNyS3Y0Nmk2VUFoUVR1ZUhpNUF5c2FnTWpGcTArNnVGRDRlNHRBTEtX?=
 =?utf-8?B?U1RranZlWGZqVFIwMmhnbzBJTlhVM2xWZ2lDSm5IVm9HMVFHTnh6Z0g5RXRF?=
 =?utf-8?Q?24d3cjJzi+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RktGTVR6dWhKa1p2aWFOT01xQnBXdGk1Rm9FZFdiL3dybkxCME8rZ2V6SG95?=
 =?utf-8?B?NjlVMEVpVUFSNmVzWm9FbllxNG1iS2ZMNU5vK2MrdUttTjJZdGJiNW1NeXpu?=
 =?utf-8?B?ZGNSOTFTNHNobGtsTjhkSi9pQXljK0dlbzdPVEFuS2E1Y2NiQjF1aWtnZE12?=
 =?utf-8?B?R0szODh4WDM5SWlQb01pZmFOK09BN2NPMEhaYmVaMk9raStPYkFUM25sanYz?=
 =?utf-8?B?MTJuekpUS3J1SXord2lQdVJQV29kK3dXUmo0UVR2WUtsQnRjNmdmTTJxb3Y4?=
 =?utf-8?B?elRUNGhDZlUyWGlnM3RUb3RwSHVub20zZmtwZGpZbVJPb1FYN1BTSWVSZEgw?=
 =?utf-8?B?aUVkTWtJeXZub1IySWFoSklPRjJqbStvR29nMDNGRVRzL0lvUVBDTjlVbU51?=
 =?utf-8?B?MU5YMDRlVG9DZlpTc0UrNmlUVVNMbGlJMUxBcERUWDdmK3FOS0Y2Tk13S2dv?=
 =?utf-8?B?V1RPOVNnc2NtVyt5elJYWFlURW9hdG5vcGFUWWRTczNzL3g2NXBvWHJTcFBi?=
 =?utf-8?B?Y1pRdjFCNHpTSS9DaE4wL1RWSHlkZGlPMCtvZDJXUmg2SkJRV1ErUzl1R3Zr?=
 =?utf-8?B?YmJKSFI2YXlvdDJsSXhKMHhOYXhySGg2b0lWZ3VjbE1oS1hwdkFwSnQrZzEv?=
 =?utf-8?B?Y1IwMFR3TUk0SXpCZE9nRXVaZnJrZUNWdDNFa3B5M0QwM2cvM3Z3NU9ieEFo?=
 =?utf-8?B?a1BrbVpmQUpTZUpzV2ovV2h1UG9yd0JKZFlUMVpkMG45bjZQZUw4V0RleG84?=
 =?utf-8?B?THpvWUQwM0xrMlJHcFNndnNwUERWOFAraDh3N2tkNEFYMTZTbCtjWnFEa0lW?=
 =?utf-8?B?RXBFdzBlYmxmcndUNXgvSnJVQmRETERPUjNSNlgyZkZsVDNDWDdFWTVSVXNW?=
 =?utf-8?B?b0VJcE9IVEg0SVp0dlNpem5FMGNDaDV6Q09QQlZ5am5aanJyVVFFbUZWa0s1?=
 =?utf-8?B?WSs2dHBMS0tkdlp2ZUZJQTQ4bndoR3JWbytqR29YdlNJQkhFdmpvVzNkWkdT?=
 =?utf-8?B?bTh3aksvZUlTUzFwQVZNRkFaVmo5Q1lERWdFbTE1bGFpK1ZNU2dPQlZwOXlw?=
 =?utf-8?B?K1V0bHlUSGx3cm9mTUxDQzJmUkxDcm1BeklzSFdWR3huTFJWOHFVNnpMSEpo?=
 =?utf-8?B?ZnFhN2FIdVdqL3dIMXhYRlZHRjRyVnlGZ0RBTjVJQlVVbnFsWUppRE1ycDFj?=
 =?utf-8?B?Q2M4Z1BWcXZPU08vSmNjUnNIbmRqYWJ3cFdqTDIxeEdzbExxeUJxUSsvOEtO?=
 =?utf-8?B?U1huY2RWVjdaVU5HcUhmcEliZm9vbXlrUEVCd29INS91OS92N1ZQNzhtSnUz?=
 =?utf-8?B?WWlkWnNTbVp4NE02MnBNNVhSY3FUMThqUkd6azlTWHE2ZmJWVzNJL1N3Sk01?=
 =?utf-8?B?dE1sdXc1UlJJM0k1ZVdicDhKZmEzeTFrSkpJUVg0d1htdDdPbTNjMVVmUGY5?=
 =?utf-8?B?WnVkWkg2aVFoTkpTai9WZnFSeks1SjZYcDdsb0tGSVpHbEpwTWR1R0VBaDV2?=
 =?utf-8?B?bGFFYW5WSC9WcWwxaG1IVmhpN1R0OWlsc0dTNWV5TlJLdXhYaDZzLzBrWTJS?=
 =?utf-8?B?SjNXQ2lwVyt6d01yUUJTbGphYnQ5THB1VEZTaDg1MG14cUZSZGg4V3lldWNw?=
 =?utf-8?B?ZDd5TzBnelY0N1R0cEJCUHdyUlYxalRJWTVta3U3UzlTRmVpNWdxN2Iyakkz?=
 =?utf-8?B?U3o3ZTN4NGxpN1JDYWdkRDc0a3JFV3dTcnFSRnEyTkt5WTN0cU1JZXhYelZy?=
 =?utf-8?B?YnJFK0JZMS83SDhidVFFQVdpa0VsRWlGd24zUk9qZFh0RkV0UllOQ2ZKd1JW?=
 =?utf-8?B?cEY5UTlEUC92dlpBejl3ejhuMkJoYVJWY2VDdkpBVzdIOW1uVkcvM3pSZHpG?=
 =?utf-8?B?VEFaM0lUbkEzbkRXMzlORFQ2R2VMdFBMR0dXUGEvNHRHSzRHOGMxYjdRcmp1?=
 =?utf-8?B?eW8wSmtLSElTQ0N2VzJ5N1NjdFZKUWowV1VJSWZVNng4NjBpSjNYcTFDTko2?=
 =?utf-8?B?TWJ5QlFCUGkyVDlIOVgyalhkTnQ0eUFTSFhHdkpGM1FydHF1QlI3OWtKK2Er?=
 =?utf-8?B?M00rK1pEM3R0Tk1KVGRiQU9kZWtSY1h2dmo2bmtwaXF6em9WNjE0MmRkY0hQ?=
 =?utf-8?B?ZGVsL2ZLV1BUeXNPUzlGR2tZTnNaVVRsTlVaclQ3N2F6Nm1qbGFxMXRzQkow?=
 =?utf-8?Q?Y052dvp1mKXE03ZoC0zUr1IKOZebXujGbT2vWhpx76de?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15c6d95-7aee-444e-9366-08ddbe1e2110
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:51:17.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORnsyQ4AIisFGeMIJK9ggv4MaBAILn4gthq/qrXEdFiqN2cqihaXmF3TPedEoyvtVjJD5TM1aMxqUEEmq6NcAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797

On Tue Jul 8, 2025 at 4:58 PM JST, Onur =C3=96zkan wrote:
> The previous version used a verbose `match` to get
> `current`, which may be slightly confusing at first
> glance.
>
> This change makes it shorter and more clearly expresses
> the intent: prefer `next` if available, otherwise fall
> back to `prev`.
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Thanks, this is definitely easier to read.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

