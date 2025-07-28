Return-Path: <linux-kernel+bounces-747405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C344CB13373
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D721747F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9B2116F4;
	Mon, 28 Jul 2025 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d0s3LpDc"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78B1C3C04;
	Mon, 28 Jul 2025 03:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753673981; cv=fail; b=Uv8V5a7i5npRswQyZ1enzEgB/4P+YOeg0Cg1aUvq5PQEE100AHF25sUiwFFYEZWa8aUlVV35x8rsswWtPti+BIJ3wa96KvAic14VgQ2T5jqSt3AS0EDaTSwf2czbXimMvDc5U41omZnI2RBclDkGhFddNmZGe45Fqvvk+jecQn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753673981; c=relaxed/simple;
	bh=vZ9DsweaeygdlDrBU+pvED7rIX8gv0rdCU4C/gsaD/s=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=lGjo2hm+f4MGda+cBbGOjaKz7o8HG7w4ACfuKvx4ZLQStnR+txGLDwhA880JMQJxVV/LCUEBYClYzPXzqgdSXFj0jBb4w/MxS2W/FGJ+BvJZ1I/FymqjB0OO7vqKzNib7EWxue/COVLFe3vqDZ1rRQ9Nv2qcWpq7pHEdgugaZz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d0s3LpDc; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLbkbuXElRbwSKQRiIY6rM0gY2B+F/vc0Vwq2NAgUYmEikmzwTgk/RnURP6JUmhBJTPAOt2a35StgDrIqtQncvX4U4Pxiy5iCi2kTQm9yPLsytwkLnhn7tnsqra6KmkEFjNBwYy21MhsMDtsfjJSvmUnc6g2bpNBdSbsC+9xG0v2YPHmFP7A3YtqLK+BmZ5GTF9JJatKyPaDjlOz9hEpQsptct2LjenHNOjhLYtGnU8siY3su5v8MvfDc9RHofI3NJ7gz9wsaUwLtL1hgkoL+6JqOCV0/W6pGEShhBQkgBnnhYTiL79flaok13EAuOGviD4KzuZ/097De0e5zLXNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBPHi5SHqRb8Z7futgfWKlbbG7ZPiXV0rFYNiTHoMeA=;
 b=aQRwXTnAnxeYqRVlJWGnMQjzAv85+c4JoUyvl74zbz0ScCUS2nY4WbCclUjZHKugUkzLzQqFDoAe/YoTSltEq7FmrBTX1lzExFegmu5teGEpC77KzhhV91rcmnTJOB2zi1Y0zqDT1xGgTj7CXTB9nFc2VErMb7MICvHjhjD8wDO/bvvNlMc1FaLeAsLBNlxmIsC2d6d/9HEa8sGIVA4iJYN0iKzCt1tPfBbRE1QAhSM16ouyusI6PqTzxugD8wWNcicZMWtzIrQVuF7PbcU3n969lJzxJd4bFNo7iA5ejlKwvxvvPo0Zm/6CBfDSsWwrRJ9MCSujvNRJWvYOCqHiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBPHi5SHqRb8Z7futgfWKlbbG7ZPiXV0rFYNiTHoMeA=;
 b=d0s3LpDcewOHCJgGk2gcicTwB6Vl099mIgz7IjNGDBKMblF3mf9G7DimBukfIZAk9emKDB0PqNkVzNYQuqAilHEvMMhgZOh77fbwVljzC9KjX/oyN7AJTUxTjNotOZGQUNo0D1E43yEs0Nsh5r5YKVBOZYydLSKzAv8f5Yn4GEVM+j4VaK3bvXhO2vii8uyJm6RVdHQSIq9mLhysk6jW8q9GyKigGwMqaZ5jWRBT/3RuSzMBYXkMjoV5QrvsoOdCpiSZDtRP3Avt64HKzv7mNPC2uw1P5N/11ZlqNm9BS0SO+VGqqjJnzgMxbbspfPAcp6R0aXq27XX1R3Y8PKTb/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 03:39:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.023; Mon, 28 Jul 2025
 03:39:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 12:39:31 +0900
Message-Id: <DBNDJGIUQC1L.3EYGJ1ROIGMBY@nvidia.com>
Cc: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Robin
 Murphy" <robin.murphy@arm.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Christian S. Lima" <christiansantoslima21@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rust: transmute: add `as_bytes` method for `AsBytes`
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Benno Lossin" <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250726-as_bytes-v3-1-eb7514faab28@nvidia.com>
 <CAH5fLghNDDo0HKupPXe8G6z2TP4TJE881Bd76k0LDjSm75KcEQ@mail.gmail.com>
 <aIX-JDehurnGYppE@google.com> <DBMUEH5MYR2L.CXM12OIUH7TZ@kernel.org>
In-Reply-To: <DBMUEH5MYR2L.CXM12OIUH7TZ@kernel.org>
X-ClientProxiedBy: TYCPR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e0b15f-39f7-400a-8f63-08ddcd885e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXVjRmFaZFRhZ3pBbHBveFE5RW51N3laWDhYQ1U1VE1MdU05U1Z3QlFYUlRz?=
 =?utf-8?B?Y1dNYVljSXAwdzNGZ3VuY01kbkNmSCtnQk1mbmFYZE1SNTRTNFNIaUQ5QjFq?=
 =?utf-8?B?ay84Y2pYUFp5OVZnZ1A2VXozYVAxRmt6emc4Y24wb0tUT0VBeGJ3U3hKK1B4?=
 =?utf-8?B?QzcxdnlsYUNSbThjMzdkQitKTW56QWIzU0s2TWV6VTkwcGo0SXgyMVp6L3hM?=
 =?utf-8?B?M1gwMS9PRUVrZHFKcmErNUY1WG9pMldScVN3eU1SbFdNWldaS2JDQ01DOGxR?=
 =?utf-8?B?MzRRUG1FUXNta3U5aC8wU1VVLzVudE43TDlNcENieERBbUVscUVWdDBacWg0?=
 =?utf-8?B?YUZLd1IrOXhHR3JiSmkxeXBnUS9xeFo5R2trZWppL3RZUFQyaDRSY0FvSWNi?=
 =?utf-8?B?RDRyN2JTNTdKRFBkMEcvRzM5c2FuNjY0MHFIRjNhWHE4ekNJNzJmSkwyV3Zi?=
 =?utf-8?B?b3NOREZOTitucjkrWWhxYU0zWlY5MG9MOCtqK05IaG1iVllGUkZic0RxdUt1?=
 =?utf-8?B?b2tvM1dybDhYOWMvelVXdndRMXFLNDgvUXI1ZzVVNXVJOGtkZjRvcVFpQlhy?=
 =?utf-8?B?ZVhIZFQyZkxITDJtTHB1ZTNGQVR0VXZLdkpndlVRaVNRbzdubVlOWjJuekhS?=
 =?utf-8?B?QUVMU1dOQ3c1blpGMW9teU5iZUgwei9TajdiNVFVYkJMd2JWckFGOEdWRHNr?=
 =?utf-8?B?Q01HWll1c1oxaG00eGNiTC9DTEJHaGc1aDhKR0ZhNUozT1dIUzU5R0V5Y1RP?=
 =?utf-8?B?WEQzREJxZmlKMFVpVHcvTjdqTUkzZ0xPdmNiUzRUejZib2w3SDRmVXZXRGh2?=
 =?utf-8?B?OWQrSkhGb1B5SnFMeWswNlFnTk1pWUJCNnZPaUtBanpaV1N0bE9NalpzUnlL?=
 =?utf-8?B?b0QxeGczSlAzcmRweWFNZ3duMFA0OVd3VXpSTjZPa1JoTkkzZmw2ZytiQzBS?=
 =?utf-8?B?a3FRcFhhTDVWMVJzMUJucm91dTNLaStQT3dEVmVyTlpQT3RTalhiRU1kZFYw?=
 =?utf-8?B?M2V4YjN4ZURXM1UwTTV1M2o3Tm81cUZxbStCNnZyemdzeU9QeWswMUN2QUhh?=
 =?utf-8?B?akIvWHM4Rlo1L3Zhdno1ZDR3SjkvS3NvTVpTSkRUdkZ3OWpZeENRb0F6b29M?=
 =?utf-8?B?MkZ4RXh4amt6NmVNYWZZdmZMazBYcW1Wc0xJcytpekRoamVoQjZJRm1OcUNj?=
 =?utf-8?B?OUpOTjB4dkZpZjUzTFYvUlNzOFQ1N1g5WTR6d0Y5SWJJZzBsR01Tc3V5TGc1?=
 =?utf-8?B?ZlBPZmE4Mm02c3RucmZwZ2cxaXMwcW1zNEV1UkpiVUdvN3ovV2NJWWFKZUxo?=
 =?utf-8?B?Zk1mVk5tYWJCNnQvQTVraGwvVmlMRTVQc2lscmhnSC9YSys3NnZzVFlma3h3?=
 =?utf-8?B?Z290dlVTUEQ0UGhTL2xmalEvTHd5Uk93WXJGZEhScmtaQkZjMzRJeG5sNFNa?=
 =?utf-8?B?ajNmNFRUQ3N5RHJidTJydUZwSE1MdkhRRU4xOEQ2NEpKQk5vMXFTVFhnRE4y?=
 =?utf-8?B?VWtPL3ZyMTJyenBrNHcwRjlrdGNaaFFHK2xRNGdMekkxbGM5UVNoVHhoaGM2?=
 =?utf-8?B?eUtjWndTUFArMWt6V0U4QnhNNjU1enRWc2Z0clNKczBnSkRsNE1USlMzWllM?=
 =?utf-8?B?K2h6TmJ4bVhKSUZvYm1wQlVmUW4vRDhNZ1cyM09DM0lOck9RNFpkYWI3QU1M?=
 =?utf-8?B?bUhlU0ZhaGtBNFFRREdJSFgzR1NEejRCa1ZSUXBDc3Y2VUtlaGlhT3dDeEtp?=
 =?utf-8?B?akFGQzM2Vy92QldWVU5GRGdFM01TRVBIQWxvYzVvQ0JjR2sxbVkzaE9rcnk1?=
 =?utf-8?B?MWZxclFOdnRodTJkNjc4K3BpNDdyVlc3QjNqYm5MbEF6bEROTFVuWVluM3Fo?=
 =?utf-8?B?VENFVElXU1M1eE15Q2dIcEJ2d3JjWHBkcS9WU2hTR2JZViszZzZ3czVXb2ln?=
 =?utf-8?Q?ebJCUr96Y2A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzNIS0x1S3QwV2JzS0x4RUkxVitQUXdYSFluR1BkMmxrMk9lbjJpaTQ2Y2wy?=
 =?utf-8?B?R3k5MHB1TjNtNmp3UGx6V1NqTkw4ckhWSlRteElWVmdDZ3l5MkVjL2ZMTkx1?=
 =?utf-8?B?Z3pnZTZxMWJubU1UUG8vN01HajlsSlhhd3hZM0NDZXVRaWJBR0hsMGdrd0JJ?=
 =?utf-8?B?d0RNQkUwdHBuNEE1b3djQ25IQzFRQUpaNk56MWNIT0RpRWhZaDladStPeGE2?=
 =?utf-8?B?R3BSeVJPRElwWTEzRVhSS2xsaHhxck9pLzU1bjNURmx4VWJ5Zkh3ckd6N2w4?=
 =?utf-8?B?N2kydkVwNVJSNGZOdVdSQThoaGlNK3k5b0V5Yk9sL3dYWS9KSHdSVVlkbnZo?=
 =?utf-8?B?azhhWDJEaHpzQ1BrTTN2KzdtdWlMcmVWUmVyNW9hVWFMU24weFU4eGNmV0k5?=
 =?utf-8?B?QUJXTjdLemxuSGRqK3VvRjNhQ0QrdTM3Qm01dWgwdUp1Ui9MSkFNOWJSc2dp?=
 =?utf-8?B?S2VRMk1zMTB6SDFEdUU0QXp5R09LZjhBdVVzYzV1T0pXanZzT1VVcjN2SU1B?=
 =?utf-8?B?cVN1NGNEdi9wTHA4L2JQSGE0UFVjZ3k4U3hQTkxyNnA5QnBVUDRZNHE4N3Fy?=
 =?utf-8?B?TlF1d29JWlp6ZU04eGVMTmVid2dML0EyR0tieGNGeld1dTVpMVhoL0hiZmc2?=
 =?utf-8?B?UlZyKzBrcWpNQ0tsY2VPNUxNUlBNNnVabWRoVjBoc3U1RmZJMFVEMnRYc0V6?=
 =?utf-8?B?WlV0cDUxTXB4VjcvMkkzNWhaTkQxWW45c3pBU0JGcCt0cE1ySTBxbVBsRVRt?=
 =?utf-8?B?QTBnaGd3LzZqcjNRN0VxRGRrd3BwaU5vRXpsNythZWJtODNMK2dyb01CSXBQ?=
 =?utf-8?B?YmhYcDllZFpXaXlFWHcxd0tXdnV5c0h0TnlWbUJmb2gwd0xmem8yKzJwaUQx?=
 =?utf-8?B?NzRKamlYL2J2WkxsWTczdWtLdkFQR2FFb1FGS05vN2Uzd2hZQXQ2VVU5WWZx?=
 =?utf-8?B?NHlrejNQTytVKzZ3Yms1Ym8xdzl5Kzk5dzhPbEZJY2xDeUtsYVVSZHZ5bmt1?=
 =?utf-8?B?OHo4QVp0c3N2a3BjVm5tS0VlcEMzT2M3NENXNzBTYVVuSHRoN0JKL24raUhr?=
 =?utf-8?B?RU93TitiMXpCbjV5K1dIUmliZ0V4d09HcTJXR1FYRHRyaWhiQ3h6eGlpRVo0?=
 =?utf-8?B?dTNWb2dZRk5JdDlFVGZ5VnUvazZCbnQwdW55VCtJVjIzQ1FuTlFGVzRndkJD?=
 =?utf-8?B?WU9GLytVZEhHdHpVcm5KenNVSnNBMTdoYWV0dzhJZXA4TmE2N1RUcldPcWlG?=
 =?utf-8?B?dzdxdytKTHJ2VGxwaGpqbVVGVXkwY1FHcWxQWUxaTGlybHlFRFlDSFMxVnBG?=
 =?utf-8?B?SG8vTUJ0dFF2c2x0aXZCRVU1bjFSK3NSMzVwTHZmTEQ5MFM3bWs1UUgzK3ox?=
 =?utf-8?B?cXdEK0ZZSWpjeEZ2OUZiNWtqVWl2ZjFqQ3ptM29iWmpZb0VGajhGVHNXaExE?=
 =?utf-8?B?QjZJcEQ4UDVxL1BNOWV5WGl3TVpvOGkxU2NCL2c4ZGhBM2EzOGNRYkdhKzc0?=
 =?utf-8?B?NGdML0ZTWDZBeVdneGdJRjdMalozRitRZmhjb1dXcnFJL0l3cjBzMlBzZ3lS?=
 =?utf-8?B?KzBYeExnbnZsSFFyZ2JrUHdBR3Zoemw5alpBNGJlWnNnL2ZXakhVMjVUbStJ?=
 =?utf-8?B?YkJESC9lTWczS0hLOGtYdndVZVNRWnBaVTVrcGlOakc2ZStEZkVWK0N4bnFq?=
 =?utf-8?B?YjNLZWtJQ1RSQ0ZyZ2VLdEhLL0FOdTM0Wkl3T2lVSlJuODJCMWJKdzRqR0xn?=
 =?utf-8?B?anorZklhcmJweW5jdEJXY2s4NmpteCtWSkdQczYrMWVDTlRXNEJWK2ZKZEor?=
 =?utf-8?B?ckt0UTV5dFhGYzU4NUw4cWV0RHIvd0xabVM5RGJtZm95bUl6b21wTFI0bHdF?=
 =?utf-8?B?RHRXYUZRcnlOT0hESGF2TkxUNWY0MFN2V29nYWVUbFFTVHd5YWYxNDhZV3c2?=
 =?utf-8?B?VzJVVjNTSUNVYnc2NURzR0xsSE9UUVZydTh1ZzNadkN4dEFQdFNwY21WWVhj?=
 =?utf-8?B?dVVLM2ZFeVlrMVdMekhNRHlOWGRtZXVCWS9nOWZyL0pRUVBxNGVYVlJ5TVRs?=
 =?utf-8?B?c1NlTThQTzdJcjN5MG9rMzFKVFFTS3V6cGJMNjlZQnA4SjNWb0VuMDh6S2ln?=
 =?utf-8?B?S25zZUxxU2ptS0dUUDl4Vk5JVEdIeW9CRjZVVGRzR0tUeHRqYXNnRDZDdXpJ?=
 =?utf-8?Q?sM0jB60/0Ji93mrv0MuT7OEBDi315G2Qu8jHTKMAZ1I1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e0b15f-39f7-400a-8f63-08ddcd885e51
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 03:39:34.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5en+wC4XzK0Oyzw3CyDhWuNbDfvuabbB4HMfNkajnC0LtC6T9w+SjkS98nd5JM4UKPm1hjKWbu13sisTIYgrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651

On Sun Jul 27, 2025 at 9:39 PM JST, Benno Lossin wrote:
> On Sun Jul 27, 2025 at 12:23 PM CEST, Alice Ryhl wrote:
>> On Sun, Jul 27, 2025 at 08:52:00AM +0200, Alice Ryhl wrote:
>>> On Sat, Jul 26, 2025 at 4:47=E2=80=AFAM Alexandre Courbot <acourbot@nvi=
dia.com> wrote:
>>> > diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
>>> > index 1c7d43771a37b90150de86699f114a2ffb84db91..69c46c19a89191d8a2abc=
5801564cacda232218c 100644
>>> > --- a/rust/kernel/transmute.rs
>>> > +++ b/rust/kernel/transmute.rs
>>> > @@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
>>> >  ///
>>> >  /// Values of this type may not contain any uninitialized bytes. Thi=
s type must not have interior
>>> >  /// mutability.
>>> > -pub unsafe trait AsBytes {}
>>> > +pub unsafe trait AsBytes {
>>> > +    /// Returns `self` as a slice of bytes.
>>> > +    fn as_bytes(&self) -> &[u8] {
>>> > +        let data =3D core::ptr::from_ref(self).cast::<u8>();
>>> > +        let len =3D size_of_val(self);
>>> > +
>>> > +        // SAFETY: `data` is non-null and valid for `len * sizeof::<=
u8>()` bytes.
>>> > +        unsafe { core::slice::from_raw_parts(data, len) }
>>> > +    }
>>> > +}
>>>=20
>>> Let's also have an as_bytes_mut() method. I would require the type to
>>> also implement FromBytes as it lets you replace the value with another
>>> set of bytes.
>>
>> s/I would/It would/
>>
>> FromBytes is needed only for as_bytes_mut(), not for the existing
>> method.
>
> I agree with your suggestion, but it can be an independent patch and
> doesn't need to go in via this one, right?

Given where we are in the merge cycle, it seems like we have a couple of
months until that code gets merged anyway, so I don't see any reason to
not send a v4 with Alice's suggestion? The only drawback I see is that I
would have to reset the Reviewed-by tags.

