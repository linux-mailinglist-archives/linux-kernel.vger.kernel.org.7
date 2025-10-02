Return-Path: <linux-kernel+bounces-839789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1512BB2692
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 05:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692D9380263
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 03:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76B23DEB6;
	Thu,  2 Oct 2025 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LnpyTI6o"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14865208CA;
	Thu,  2 Oct 2025 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759374206; cv=fail; b=OaBOCZ8ZnyyFwKb7T10u3MmO8AKBOGk8Yg3kH4Auf8VvET0i4nD203plDS01KwT5JRsY+BApF9lCQPilKmGtS+jeE1382/BOIztt3GwIJGMSQg2zdiT+RyQHRLfqmaO9MZn5GeYKT47sv8k2RBx37EG44OHu8MvlJrcHyCw+rHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759374206; c=relaxed/simple;
	bh=GrG9R++GEZJ0grZOUDPo5GrNHLuX2GkVXv8655UNuN0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WUD7NVelqEIHRMferspOysxZ0Y+JIhoQcU89Ndhq4XtaU0NcuJemDImP0fYkx6A3KnYuZkFhPCZshPVx+ZIJC6yJaml3T68VEZ0RJebd5VG3EX4AituwrfdZrdlxOO21bsJpCmCB3Z5WyuWlWYFgpFu2Ia9es8xyJQqXj3PGShE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LnpyTI6o; arc=fail smtp.client-ip=40.107.209.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtJMjTZYmGjUgLeDi0TuV4jyS1WWmSq8ypS17wMH1iCtqIKDAEC+Axp7DtZBqrU/zBk+kPS9lXhdd3woT0QU6yHoQjm4cDa1SKZOk7D/XNzK95WdU9y7z2EWM6G+1QWckbeYqStGQJMpz6FGnJqx3jjgGxHMKEWNuC5yI0TNHGs1o+lpL39kDN06GdLqLe9Fhf8k55ntKocIUdgzoNx2yo+LWDojiw4MYljVvlIb9JTSbeIqGnOtqwljwtZpWoavLKFaTpqS1dauZ//aQhhEM6UnNmYfGsNj2EBe9gAaIk/TbCr1SsAKKTvHHyPrHUj9pmXVBXEFD0p+ldK682TEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpqxcn89z9R6A8aBEiIC3830SRlw1jH2WbA9rbQcnNk=;
 b=nB1I5fQU9ewlSUEYa3lNq+HAOMmc/YGjEqnqS0GOXT0Ta6+DPWPCBxdmtfsvFddYjnBT4y80q9Rb7vFhvDkfBLsCoVKmAePE7JdYEHZMJsnC6jm+IRipgdzC2cBtXOsusaGi9xYsElyZfcm8p0QnnIzQIR4ntURhxSLcwyri+4C1KYfGpbCw9B1348A0Gd9T9Ry3Ui9stVTOVjBzH7WTC1dGGBoYYTtzE9uL7Jo9H+gRelxyAIxegFTO4Gqu5h/xOj/BQBLSwivfkoKda5HSgwHIXi5tmsW9KZlUmhYm/LlcDBNjMEpjGCJ1hueDeEs4EYVftnpj8nb+wEWJAFTLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpqxcn89z9R6A8aBEiIC3830SRlw1jH2WbA9rbQcnNk=;
 b=LnpyTI6oyQNU+fzZ9RfM03qi7EH9zQf/kbU49SKw9/picwwYfPFFPEqLcMkG5Yx1aVOnbHU4DOa9Ip+xYRt43Ddj8eRUZurUdn+nBuXIXpXmoGIi48VsaeeFzsceZ3k9qqr3R9pGHlMS6ww1fHd8YhDPzZVKGFpmxlmDTjk6G/JlkxeB/1mKhkyDKvY1zKuS0n1QCZzgOjTsF6mldxpF4Bg5rO3KPcrcIL5NGtt6Rl/q8FfGjc6YsrronsZjnOyk/VXCQQz7A7o2YuDz5Ob47QUXWGyWXeLg9GJibTiUV4WkV7o/4LHdx8Wvfhx+4tPjsbmljKovqBYfqJnRtCHDJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 03:03:19 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 03:03:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 12:03:15 +0900
Message-Id: <DD7I3NGT6DHI.114KADERSQ8VG@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] rust: bounded integer types and use in register
 macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com>
 <6d4b5659-7c0e-4720-8305-5b0053807443@nvidia.com>
In-Reply-To: <6d4b5659-7c0e-4720-8305-5b0053807443@nvidia.com>
X-ClientProxiedBy: OSTP286CA0073.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:226::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 200c7ddc-3c66-4792-51ec-08de01603d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2tzZFN5eC9HUVJWR21ISGg4TWZEVVRUTkRaRkMzaGpzMU1LbGQzSlRKRVQ4?=
 =?utf-8?B?U2s4eHRlMDdWVGRmZ2RZZGs3RkR2ZnYzaDFWS0NQSlhES09hTk4yNDhidTd4?=
 =?utf-8?B?V3RZUHU3RzVhRFdtZFZHQW1raENlWXhkOVBTS3lJYmlkMmtYL2dISzhweHEw?=
 =?utf-8?B?RkMxMHF6QWRrSkJXYStuMHh6N3dpSkZjblNTQXNvd0NFWU5QMi9TcmQ1aFAw?=
 =?utf-8?B?bWFtQWdKU0VrWGhBQUsrdU0wdTJ0RGZMNGVHVy9XMTBVVDM0QXV5VnJtMUVG?=
 =?utf-8?B?NFI3UlYyeFhUTFo4SEYwSUZPZW5XLzJrSWZld3diS1FDbC8rRVB2ano0RU1s?=
 =?utf-8?B?MmZWVFp2Q0prTWk4NVZoQUtVa2lMQjlJd1pVUFB5UE5nSVBuR1puRGx6UTNx?=
 =?utf-8?B?YndkenV4T0R5NmNYcVlhZU44Yk5lYkR4SUZaOVdsOXphNVRYWW5NSkQ0aUxu?=
 =?utf-8?B?TzNmaFZjVExkVm04M0NIeWY3bFV3dWhpaEJzT0JtaGoyeXZRZzk5RmFEZ0ta?=
 =?utf-8?B?Vm5DSXgwRnZ5M0o1YVErczE5VW5zYkF3QUZmNmtIdWdrM1FjY25JTHVVcXJx?=
 =?utf-8?B?Q1E5S1lZL0ZCSldEWFRqKzJlQ2N0UTNQcUJrNlFCcW5mZEVUbm9VY3o0MHNp?=
 =?utf-8?B?TTF5bWVuSWVmcE1FRTdjeFhDaUpnc3RnSkovVGJUbnZjdzMzRDB5RmF6R08v?=
 =?utf-8?B?M1ZpZnVwaUUzak16eWZGQmNqVSthSjVmaWNHQVFRbW5hY2hKNWk1MklSb05S?=
 =?utf-8?B?ejJCeWJNMk9iZEViUHV5K2RpSTl2M05hdG5ZY2JKTUtGQ0tyTTMzVTlaeXcw?=
 =?utf-8?B?cTNZM1l2NGJPWlZENlpVcDJtL1QyN0JmbGtlRzI1cmJvRkJDTmZ5eXBBdEpW?=
 =?utf-8?B?cnFPTUhzbGNCcllGNFJiSEs2dVdnb2JOamRRbDBsN2t0RHJRL3YvZE1WTzhr?=
 =?utf-8?B?NWdhUFFxZmxGc1oyMzduS1cvb1RNVFV3VkdCRHRYayt3MXlRTkRRRVVCaFM2?=
 =?utf-8?B?Q0JmNlhraG9aUDBWbjZzVVZISXhmQ2VKRjkybkdHSVlxSUplMnQxVUVUWGt5?=
 =?utf-8?B?VkNjTjI4aWVGQmIrbjErdnQwQ1E0L1lLbkF4c0d6NUhxVytJaW9ZcVJiUkdI?=
 =?utf-8?B?cVVkQXU0U094dW9EcUNPL3NDekVYdGFRR2VldDY0NFdWQmhaU2JyTHRCMUtP?=
 =?utf-8?B?RkRyUnJWZlJVdVRKWmI4VkdOdUpBQVdRNFNVRnBadzNkRWh4Vk1DSFJRSlNw?=
 =?utf-8?B?cTRLY3ljZ1lDTldKdnZJdENIS0x0N1NXU05BSEcxMjhHck1zREMvWjBrY2ky?=
 =?utf-8?B?dm5CWDlzWk43TklxU2EzZkY3RDJWZ2VaL0ZzMEc0aHpuYmc3VmdBY0dPQ0Vr?=
 =?utf-8?B?MUZxZmJlVmNhUURJakF0YjRaV3FWUy84bmZEdkxaRGdOejJ0TzdReWdBajBv?=
 =?utf-8?B?anFEdEM2QkZDWk9JbEtFVk1yZCtNWTBUUGQvK0FjMXJwK04wZjRHRWltQUlW?=
 =?utf-8?B?Qi9ETCtKTGZ4OWppOG5LRnJ6RlFHY2pGVDMyZGhtM3hVTHgvV3JUSmRGN2xR?=
 =?utf-8?B?S2lWMFROTmYvSEFqL3h6cm0rSzNINU5VZlk3cng2dktSNjh2MCtVZDdZN1lV?=
 =?utf-8?B?bEk5aWZSNXVlVXBpMkhuRXpNTHJ1VDU5MkRENlUwc3c4SklwS1FEdk4wWHdq?=
 =?utf-8?B?WEtaM3g1am5NcUJ0NXpkVG8wK3gxWWNMUmUrakZoKzJ5T0Q1WUE2bW5jRVJx?=
 =?utf-8?B?VEQzaVF4OFp2TVM5dHpud3RpOU9BMmdCVVVjckVla2NZK1plVlNjVEVsNVlu?=
 =?utf-8?B?Ry95Ri9ZaFQ0eW5SbmlJT2RQd2xkRUpsWnR6WXg5MVNZNUsydHNCcG1RakxI?=
 =?utf-8?B?S2RrM3d1bVZERDRVeFp4ekJHWkJWUWVFNVhwWGlvOHNZUVY4UHBxdTBVN1hG?=
 =?utf-8?Q?mouniFn4SmlLd+SxvYaoEicFj48+hc8C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU5rbnVPbGpjd1JKaVJ5RWRVb0k2Ym11ajZPUStIVkhvWXNJbkJDVEorRnVh?=
 =?utf-8?B?ckplMU5LUHpoclFFanFhR093ZDVBOHBja0xSUXFtQUpuOENBa0RKTHNMejdT?=
 =?utf-8?B?di9YZkxmODNocVM5cWo5YXRqNS9WY0xHQzBLSWszVE53SUw4ZzVLZjFWOVVO?=
 =?utf-8?B?UVQ1bXpZYUdYaGs2OFd0ODdIbGoxS0cvWHZXYWxvVXN1NDhOZ3pPdTVPMXU5?=
 =?utf-8?B?UzJiSXhrQmU0Y3lwald2RCtpZHJabU93RVVocXNyMnRpTUFmRXRJeUxHMHlR?=
 =?utf-8?B?S1N4NHlaVUdZUFpkbUMyT05sdERoRUx3NWVPM0l6eE45Tk9adzVtdmE1UFJW?=
 =?utf-8?B?THZtTm40U2d4d3BFamRxRUxpelROM3phQUVtY3Iyd3ZQbjhrRE5TN1JrRFM4?=
 =?utf-8?B?aDE0S05SNE1TRXJoSlRPNjBmem5QWWkxVFA0aDg5U1kvLzdhTHhkcVhuNzZh?=
 =?utf-8?B?S3FqY3VBbVRYNGdYS2J1SnVNUjUwQkMyaGpLTG5XanFFVHZzWEJrTGlmZGhX?=
 =?utf-8?B?NXF1a2wyL2JiUE42aFpvNVlIeFFBVHNxYk9FMlBXK2Z0UFZKdEtkNUkvWm5G?=
 =?utf-8?B?bUNGbHh0YTRhdE5tdzg4NjBNbHVGUkNnenVtdXlUckgvOVNlWTh1cjJwSWpo?=
 =?utf-8?B?enQ3TTVxSlRqdDVTMGRpNkFKRkRlcjZFcmxjQzdNdUNEMHhjUWZKSEc1Q1Zs?=
 =?utf-8?B?MHVTV3FVT3JQbkwrTS9TUXFaditkclNTV3lBL0FQUEhncHM1ZU0vVGh2ay80?=
 =?utf-8?B?ZEJYS1lyVGxmOFNYQ3Q0KzFlbTNreWVYNzNSSGZjVjgzcFBLdkR0NVVQcnBQ?=
 =?utf-8?B?aWpDYVRDSEdYdzlrbE12MVBwVzdudSs4VXk0RDNCRkdQS0ZGWk5oN2NubzF2?=
 =?utf-8?B?Vk41dWVUbFd5Z2trZURYRkVHZC9VVjNhMHRsSWtycXBqTVNvUzFDL0hyQ2Rm?=
 =?utf-8?B?bEd5VnZac2dkcWRacXJENnFrUWFQS0tOakVoOVdZeUtLL0tFRURBbHVha2Zw?=
 =?utf-8?B?dWZVY2F3aFBzOUlwdnFOZHNvbk1yRTVHV0gxTU9WbnA0d1N0aVlhbW13Rysz?=
 =?utf-8?B?U1RjMGpHSW94ZkNOYUJEV0o5bGtpOVdDNHdxQnNXY2c2aktMSmNNTnpZYkxi?=
 =?utf-8?B?MFovRFI3VURmTFpIT3diVUxObGlsV2QwZS9ELzc3K2V3SjB6NngrZVVmMXBx?=
 =?utf-8?B?UW9xbjVQUFd0aGVmeFh1VU5ET0xUNTRxSWR6L2s0MlZiNU9MN3pjbEcvQUtx?=
 =?utf-8?B?MStqeFJGOGdxU29FaGpCRWc1VXBFZWdSeXZuMWIyS2l1SGo2R0ZjdlpIUVZL?=
 =?utf-8?B?aCs4Z0NqK0lOZkQ1MUJLUjN6dy93Uy9UVUY0TkQvSFhUSEt0VXBqYmNiVVgw?=
 =?utf-8?B?QXVoREp1ekVqK2RGN0doUkFSZXRqQ3E0UkZUVzdMQ2l0eDF3aUtqOXJTRkZs?=
 =?utf-8?B?LzkrQ0h2aTl5WVRFajVhN1BuNEFDWlZpOEk5OHEwc21SejdqZEhBVTdVeUF4?=
 =?utf-8?B?ckNnNzBNSU9BNzkyREdUQlQ1N1pLZzhmY1VmTndQeERtb0lCZXExdmp2b1BY?=
 =?utf-8?B?T1ZOVHVRUmU0anRVaEJlNWErd0RINDdUOXJYK0Q4V3NiNXlBZDh6WTM1TUg2?=
 =?utf-8?B?cU84RFlCa3Q5b1BPeExRd3hvbEV6Nzg3U3pOL1VFdUFVTUQyTU8yUWx0YXht?=
 =?utf-8?B?QVVMTWJSR3l1bFA0U2pMM2ViV2g3SEg3YTRBSy84dlVWS3g1bGptWDFGWGho?=
 =?utf-8?B?SE50TGZWem9HbGpMNDVvT0JMODhkNHgxT1E1Z25RMm5jVnc4dWJmME9UZjdM?=
 =?utf-8?B?anVaeGFWTFRZdGlwZERsdTVtSFZ5SDhLcUtFWjF6OXpmMkpNUFkvSjJySlhI?=
 =?utf-8?B?SVdyejdUVXJtOWt2TkRrR2ovT2JIU0FObUlXeGdjRVN6UVhWdlFLTTFYQzM4?=
 =?utf-8?B?OWxxZk4vemxqNThYWG9SL1dIZUpQZ1NaYnRqazhoQzNJSFNuUmdvWm1nN0w2?=
 =?utf-8?B?UkxwYnRpVjdSMEllZmZPUjBrNEZnMEo0NkhqZVRRQm9SU2l2Vk93eFZpTmdu?=
 =?utf-8?B?eS83U25iKzZHa2oyaWVSSXRWcUZldkMzM29SOGxBa1oxNXYzTStLcVlBbVFP?=
 =?utf-8?B?b3lnUi9NNGlJM0JqdHNuYlZFYVNZOTFFUkJzZWZFbmV1ZG03WkVpTlNZYlh6?=
 =?utf-8?Q?yExhVqP+LboXU+fPMrQ/UwvFDJ1PwQrcpqOC3qaFJtPI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200c7ddc-3c66-4792-51ec-08de01603d21
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 03:03:19.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlF1hCxWSR53o6962N/WKeNCFAbs6XlGJPMMsSrxBYBGUenz+v8tfUe2ZS4dNN8gCSSATmy1c+KXx1lCzBE7uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605

On Thu Oct 2, 2025 at 7:07 AM JST, Joel Fernandes wrote:
> Hi Alex,
>
> Nice!
>
> On 10/1/2025 11:03 AM, Alexandre Courbot wrote:
>> For convenience, this PoC is based on drm-rust-next. If we decide to
>> proceed with it, we would do it after the patchset extracting and moving
>> the bitfield logic [3] lands, as the two would conflict heavily.
>
> I would strongly prefer this as well, to avoid conflicts. On initial look=
, this
> seems to be in the right direction and solves the pain points we were see=
ing.
>
> -            .set_sec(if sec { 1 } else { 0 });
> +            .set_sec_bounded(BoundedInt::new(if sec { 1 } else { 0 }));
>
> Here, I would prefer if we did not add _bounded, since the idea is to sol=
ve the
> problems in the macro's setters itself (make it infallible, not panicking=
 etc).
> So we can just modify those?

Oh absolutely, the and goal is to replace the existing accessors. For
this RFC I went the lazy way and added new ones, otherwise I would have
had to update more call sites in nova-core.

>
> Also, BoundedInt sounds like a good name to me IMO.
>
> Also, since TryFrom trait is implemented in the first patch, then in nova=
 we can
> just do the following?
>   .set_foo(value.try_into()?);

Yes! That does work indeed and is more concise. And we can also make
things less verbose on the caller side by adding a new generic setter in
the form of:

    fn try_set_field<T: TryInto<BoundedInt<..>>(self, value:T) -> Result

This setter could try to perform the conversion itself and return an
error as needed, and the caller would just need to call e.g.

    .try_set_foo(value)?;

instead of building the BoundedInt themselves.

There are also many other improvements that can be done, like having
fields with a round number of bits be represented by the relevant
primitive directly instead of a BoundedInt, but that will requires some
more macro magic.


