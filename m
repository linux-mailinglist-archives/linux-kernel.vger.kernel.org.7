Return-Path: <linux-kernel+bounces-735542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A398AB090C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315B97B44BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5942F9483;
	Thu, 17 Jul 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l+jT9Iio"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1131E572F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766882; cv=fail; b=hdncvNDqmsnUWHLnunJ5u8kmPt4mWY+EKm6SBFTchBISsNdIyxLzsxDFzzA2/hIf5OuhRUy6ju27GiW/P0NmfZDmPvyzVRGJgSAvwsLH1wRrbEM9yJBfY9K60LgmK6iCxWHkT2mM7eHUAWvm0T058NbS2hDwDcvR5y14kNcAQgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766882; c=relaxed/simple;
	bh=3W3w2Qk9yUim1SB/ak3nKgkp6hfaozrQNY1YuUigfdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ta//+MPpaK+dwYhi0l0ARdT35dbk750+hpdnA5CgpCD0yUcFKGOHWAZbX0sYeB4rsR3542ik021YkOFcgbqMp7l2azJ9YQRd709kI7CerfrDAL4pg19nXfKcnGom5aZ1STO5b2UZaDb2oVHqVVXpr4EbE1bRmtNUfk1xMN0ceZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l+jT9Iio; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHCPb8L3knJC8Irt8PJ7ViywUEovvWNV124TpcH5/nXKyI5xcQGMVDn+lGc4kom/jRduEoG1XBnfoVmkMizthtgl3/QSpYz3HWvfSCqo5PYAcTmDTcdObxuYuSfyPVFN8QgUAjAt6gcGis5k0rTGtTUWcK1ms3MLrIM7HMrUJ311fqXm1uGUWgX5ABhTvvoyabaauULmLXoZgjU5eTgFwTTno//dlTZUUIaCuCrwbym3OQAM3Gu1kTw9SqXI6hZYFG1h6TcpUsedYnWYcO5G3YBdvhf21pm8HWNCqiQDneE88usfVQbWqfkDWPAl1JQ6qGVRPbHg6qLHZYyUhaysDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqSF6TSazLWtHpPCD4qGfhV2q4qMa6+ZHjPhWkitpLo=;
 b=yJ6FUvMdeeAms2JUxbW33w0hAOE25JQKmvpQ1H9qGYzQd1aPIvFTPfKtusojrmyDwr6bNBWr+ij+yeWm9n/GJLbLAOAci+dfP8WmeI0Thz1jdXPuTjkZzxyaW/LghzeBv+E9H6tm59EsiDRBUrrAO5FW6bpBCTS+4vtBJ/kPKeHMZQzlD7fT//vkL56X1Dfo0UltfUu73vTZzy4KlUZhFPY+oXTUXSuhaLn/1QMsOfSP7r6QzAeil/paxaONlX4IShgGPy97OM8Hf3JmRJBm6QMFHSQPpBx/gtFtWhHxAf+L55lH86E/KUZSGCfrd4iI+CBpClGceIiZbXgR2ybHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqSF6TSazLWtHpPCD4qGfhV2q4qMa6+ZHjPhWkitpLo=;
 b=l+jT9IioD5JjhrscCQJcC1rKDyYj9qvgUvCmJxbyzRPG9Xy0Usd83tjQRcIlY2IzQsh779ikj2PdQScNXQxwpWA9mFf0kpUCPAQ/BonILkSBIjlqDJQIPghwzMzdT6ICFxLb68kDpwP25GncUjHrKiFO3+PTg39ikZ+egpVKBpmwKlJ8UQgoEIhqkzI/sWWwTAkC2EdfLcr+KOpbZtGxI+Rz9LiEDHqYfGXmZQl1N1Rk4hX2dT4R1+8/OPnfKbBT3b/i4vwm47G31FQqWajMqAtOUBOkEuDNBVqjkhG4s7UK6juHavaMkUEnl4x/6G8WrrbGnDc4fucLvLJdP7C4Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 15:41:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:41:06 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Balbir Singh <balbirs@nvidia.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
Date: Thu, 17 Jul 2025 11:41:01 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <214884E5-15A2-48F6-A495-6133CE07E1C6@nvidia.com>
In-Reply-To: <5c97b1a8-b877-438b-91a9-1d1da19964a3@lucifer.local>
References: <20250714171823.3626213-1-ziy@nvidia.com>
 <20250714171823.3626213-2-ziy@nvidia.com>
 <5c97b1a8-b877-438b-91a9-1d1da19964a3@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 460e38b9-a39b-4502-3d16-08ddc548582b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cC9TYUZWY3ZPdmQ4S2o1MEs3RHN6VmJxMzR4UXNHbzRveTgyUTNpd1dObWJq?=
 =?utf-8?B?K29xUHhmZ0IraXliVVgzS01OSm4rejBNT3FUYWNkUHlkQ0krSTZRS3FOTmdo?=
 =?utf-8?B?MUpEdjNwcmF0SE9xYzVRS3lzUmU0RFBkRG42WFQzM09IRXpSZ2pndVk1RjJJ?=
 =?utf-8?B?VGRycDF6UnpWNkVkUklTaXhkRS90dEtjbEl2cmgwQ1lMVUZNbW4vS0pVY1Fj?=
 =?utf-8?B?WENpV0Q3UUM0ZHo0bWZ0UlYyVmV3Rk9LRVF0Wkg3cUdJbS80TnR4NTZDcThW?=
 =?utf-8?B?VGJZWUtkK20yc1hUdmRiVDl2TDlXSGF2T2NaSTIxdkdUQllVZlFoQ2U4YVVi?=
 =?utf-8?B?U1hFTWswR2pBaXArN2hsQnRZVVRQU0FIU0l2UFBIaXRKSzJvSXc5Q3FKcnJQ?=
 =?utf-8?B?NXBtd0lXTmhyVldrSUZPbm9OZy9nYW9BSFZxS2VoVlZ0RTVNeWI3MlVDNU9s?=
 =?utf-8?B?MWNRT0tpVHV3ZU1Ka096dmZsUjJPWklKTUMxeUxUQ0ZWelVkL0xYdDUxVHZK?=
 =?utf-8?B?ckZYNzFiUExtSmd1d1dOYmswckFGR0ZFOVZuSGEvMXZOT3FaWTR1dkNlOFRJ?=
 =?utf-8?B?MXp1NFZ4aFpyWkltelVQcWhxclRRWS9XckFRNDRBMTBvNWtGSzVLOHlkYXVB?=
 =?utf-8?B?enRsc2hMNWRNZFNadi9PNUswWkhiUGEvQUZTY2czVGQrN0dSdDI1ZUprUEdo?=
 =?utf-8?B?UDNCN3ZaRkh5RmQ0ZkZBK1BidFprb3VHNkVIZ3U4MFBLb1RiQVY2cmI1cUpZ?=
 =?utf-8?B?RjhwSnBYMzR3L3dEVjFVS2srbjEySGxWM1JBVGRUeHU1akZuMlNOakNGaGg1?=
 =?utf-8?B?NkpxejhNR3kxbVZNU1c1T3p2aGVtQUMrL2gyV282Ymd5by9YV2Y2RlZVSVl6?=
 =?utf-8?B?SFh4RXJGQ3JYaGM4NWFtOGFjb0xLQW9YamlHYU93QkR4TWtWRWNOSTZqc3lO?=
 =?utf-8?B?LzlNZyt6T05LcUZkb1JOamVzZ213N3VxaFFLOFhCZGlkSzB5N0VDK21sSDZl?=
 =?utf-8?B?cXF4MGg4eTgzOEF0cFZFazc4bklyMWFpbDBKd2FBYjd2SjJrZ1BCaGovV1Ez?=
 =?utf-8?B?SkJWY0lWR3V0b2VXMW11bGpKQ1pCUEJtR1Ntd2U2QldHbWJITjdwOU9IZUp5?=
 =?utf-8?B?eFRBVnRNMmYwdlhoK2E4Vzl5WmFuZjBaTThGNTlicFRNMmR2enRhSGVyb005?=
 =?utf-8?B?aHZjVklWR3NLZ0JTMlR0cmdpb0xwemZ6VStqNEF0aSt6YmpnM050SXUyTjFl?=
 =?utf-8?B?VnNkUGFDVmI0Q0x6VEdoRkRQSmRwOFlDeHNVRUxPVWhFSEFaSi9qWFlBQ2Vn?=
 =?utf-8?B?UlRJU1lUQkNtd0I3RFBVVVU0Vkhzc2dSRmFQbVBQd3l6bVFFL2RpQlhKZThv?=
 =?utf-8?B?MGxzZUlaTjhBVjVCaHNvRjhtNVZPV0g1TVJ4S0MzS3hnUUVOS09rWk9qaUIr?=
 =?utf-8?B?cXQ5Sm0yVFNPaXZWVUNhNDJhbGRoZy9tM245cEk3bFhTanBLUXU0WWZNeWUx?=
 =?utf-8?B?cTFhWW5PMm5acW5NRENhZm9Iem9qZzlMMXkxdHJKMnVJK1VXR29tZ1RuOHAw?=
 =?utf-8?B?MlBSTWgyMWg3NFlwaEMybVFxQ2VlM2V4V1ZzbnZ1NXJEQWttZDV4ZUNXS1N6?=
 =?utf-8?B?ak0yc0tMQlRSZmpiUUJYeWVqaHdKMUFXdHp6NkxUaVFCdUhHd1FhMFhHSmxm?=
 =?utf-8?B?M3NORHJtMUtncHBkUExCdXhzeEZPRWx2bTZmdXVGNjA4L21GTnVoY2l6WmFz?=
 =?utf-8?B?TWw1TytPTE42b1VJS1c1SGcxVjlvMlZMZ1dvUFYvTmhZREt5N3lHdmk0RVR6?=
 =?utf-8?B?UUpCbEhUMUcxTENVL3BSR2E0U1IrckNhRThIU0xDTXJTR3RhdmlOWnJ0bklt?=
 =?utf-8?B?MXdDLzBldjRVVkZaL1pBQzJON2E5WmYzaTZpSUZnNlROQ1ptdlZ0b1dpVnRU?=
 =?utf-8?Q?Zvme9z5os80=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUd5dXV4N0F3NW9mQ0htdVJiQUJBMFFkNy9xN3JGSmx0b0tBM0ZtdlArWEZY?=
 =?utf-8?B?Sk8yMHdYT1RlQk5Hc0lNY0d0WVY3bjJBaGFYVzltSWxoUUdvUHRUZm1NV3pz?=
 =?utf-8?B?SExBZEVYY2xrdmdSdjBQV0NJMjF3QnNRODhRVGhHaXpkTmJJVzhTN1diMEIy?=
 =?utf-8?B?VXFjN2VsRVVyZGdjT2VlbDB5Z3JUSWw0amZER21xWEc2MmpnM1FmaGlLSkNI?=
 =?utf-8?B?b0Q5OGxsbWNSd1RNWlpGdFVPbS9HUVRnM1o0bGxRdjBoQVYzb1JOcnUyb2NR?=
 =?utf-8?B?eEFsT3p3a0loQXdJTy9nTGlZT1dJUk5ySm96S2pNU3g0Rm1Td2UxaUQ4bDZF?=
 =?utf-8?B?V29MdS9hY2JrdEhEeGk2OFBiK0M3VHVZTERNQkhldkRZalJ0dmtRY1hYaDJR?=
 =?utf-8?B?aG40L2MvVW14SmEwbXk0OUFxR2pJY0JXc0RHRGpHWmVIZ2xiMGhReVVjRXo3?=
 =?utf-8?B?ek9qYnp0bnZyUE4yQ2VMQThZMlgvYmZvYVFaNUwwMFhkSWZUdEZQWFVBaUNB?=
 =?utf-8?B?WXVNamhaMTVmb1Mrc2UwaHEwdnlmTDVOS1Z6M2VVbjBaclN1cExKS2U5VDZB?=
 =?utf-8?B?SHBNYkROTzRSazZEU2NlNDA0SXFBVzBSMWJNdDZNQmxNTlo5dWdhQnNUenR5?=
 =?utf-8?B?UjFqSit6MzRKS3ArWHVPaUxMZS94T3NEdFJtSDlXQi96Vnh1YW9GRFhtY09t?=
 =?utf-8?B?UWhtWWlvMUw5MXJrcm14MFo3SzFjOXRoSzhydmdGQlhVWEZBcDJkV2VkcXhI?=
 =?utf-8?B?SmJuRjJvRmMrU2lJeDlMR1RKZUd6ekFraGI2UnZEaU9rMTZwZ1dOZG4vekR1?=
 =?utf-8?B?MGpPcW1sa3BVdVNmbE90dmZYUkMxdHRZTjFNMXJoRUl1YzFYNFpKZlkvZGMr?=
 =?utf-8?B?VVVBckN3Rmt4ZkhINU9TTks5dktGS29IVldPSW45OTRDOXpNRHJXT2FMVEdK?=
 =?utf-8?B?QkJLZTZva1F3WEgrVitFQ1Rza0h2Q2krd3haVE5QbmExbTJNMDg2alh6MnlP?=
 =?utf-8?B?T2NXeFZyVTJYQ3lVZlVzQjRXRGpTK2pRZ21ZNitGYmhsZzY5TXZQNys5NVlI?=
 =?utf-8?B?aytuOHZPMUs4WWsvdnlSWE9pM0NHTlFwckg5bThETGxNQjBPYnVlRmdLcDVD?=
 =?utf-8?B?L3haQnNBbVR1SUNqbXN5dDdXL0xMYzZlY2sxU1hRTWtlODhNdnk2NVg4RVJC?=
 =?utf-8?B?LzFrNkppL09wRlRwUXd5U3Z6anMzLzgyZ20zVG9GeVZSMFBUNFRjaXp0dnNH?=
 =?utf-8?B?b05UaW16WU1sczBwM1ozMDU1VlpwQTJJdTN6VXFMbTJQSGg0SHhRcWx1aVNl?=
 =?utf-8?B?K3QrOVFNV2R0TkxlRnpkVEhldjk2NmhtVXFEc1EzVE5kL3hMOE5lWHhtM0w0?=
 =?utf-8?B?dlFYZzJVZE5HT3M1NnBmYlF5UERaUDNSaE50Y0N4Ulh5d3ppZytVNWljVU44?=
 =?utf-8?B?NjdNYndIdnczd1p5MGZheEZyMFEvb2Rwa2g3YWFzMTF6eVBURVdwNVAxOVhS?=
 =?utf-8?B?S2pZWnp3WmVldFlHUjlZQ3k5ZkJTd2xPVnFGckRPcU53UVlXZTIwKzlRSG5I?=
 =?utf-8?B?VXFvSHhCSU9IZWNhRGxteDNCVEdhSVg3UVFuNSs1eFZacnJSUlhQN0NXSm1p?=
 =?utf-8?B?VWU0ZGlseGJ3OHFnK2tYYjhONXJCTjBGTGIwUlpNcHFrU0F6NFJCci9uYW8y?=
 =?utf-8?B?aHdWN1RIcTcrNDFpMm1RWUFyeEMvZ1BZa055NWxJaGx5UlMxMExxSlJHM1RE?=
 =?utf-8?B?c09pc2F5TXpaYkRFdm1oaW44amV0Q2hyZlJxbmUvL3ZLOWNSMGtQT0hRNmVX?=
 =?utf-8?B?WGxlVW1RSTFOMmVsTkVHY2F1L0gxYjhKYSs1dWkzZEpsOTZEemxCUzdOd3Jo?=
 =?utf-8?B?SDZ6Rm9PSXlqWjJLeGRidTlVeTZoaTNtTWRhUzRvNGU4b09pdDMwSEtGakxn?=
 =?utf-8?B?NHR4dFNyWHhKclpyNlFoRElFVVFzRE81RXhpQmE0QzhNdU9WMEUwdWpBQXJv?=
 =?utf-8?B?R1k4K1dVeEVWcDhxaERTL1BtVGN2WnNLektsNXNkczllaXVlQ2hSWEl0WWhw?=
 =?utf-8?B?RHlHbVY0YU1lRG0wQ21ZS21nVk1WVUhzS3JJV1VLNXkvbCtYU0ZiVno2ME1R?=
 =?utf-8?Q?yl2M4Gk4EIslnzz95mpFtSz1K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460e38b9-a39b-4502-3d16-08ddc548582b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:41:06.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEhxD5qqXFJbomm24uFjw2Ds19Zkvn7MuV+IG3V/vs3RXEJOfUB9OCkucLPzQWVs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839

On 17 Jul 2025, at 10:07, Lorenzo Stoakes wrote:

> On Mon, Jul 14, 2025 at 01:18:22PM -0400, Zi Yan wrote:
>> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
>> splitting unmapped folio operations. Move them out to the caller so that
>> __split_unmapped_folio() only handles unmapped folio splits. This makes
>> __split_unmapped_folio() reusable.
>
> Nit but maybe worth mentioning the various renames etc.

You mean release -> new_folio, origin_folio is replaced by folio?
Sure, I can do that.

>
>>
>> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Acked-by: Balbir Singh <balbirs@nvidia.com>
>
> After a lot of staring, 2 difftastic's at once and exactly 0 coverity
> instances, I've convinced myself this looks right.
>
> I think you really should have split this up into smaller patches, as thi=
s
> is moving stuff around and changing stuff all at once with a lot of
> complexity and moving parts.
>
> However not going to make you do that, since you got acks and I don't wan=
t
> to hold this up.
>
> I have a few nits + queries below that need addressing however, see below=
.

Since I need to address these nits, I might just split this up.
How about:

1.

>
>> ---
>>  mm/huge_memory.c | 291 +++++++++++++++++++++++------------------------
>>  1 file changed, 144 insertions(+), 147 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 3eb1c34be601..a7ee731f974f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3396,10 +3396,6 @@ static void __split_folio_to_order(struct folio *=
folio, int old_order,
>>   *             order - 1 to new_order).
>>   * @split_at: in buddy allocator like split, the folio containing @spli=
t_at
>>   *            will be split until its order becomes @new_order.
>> - * @lock_at: the folio containing @lock_at is left locked for caller.
>> - * @list: the after split folios will be added to @list if it is not NU=
LL,
>> - *        otherwise to LRU lists.
>> - * @end: the end of the file @folio maps to. -1 if @folio is anonymous =
memory.
>>   * @xas: xa_state pointing to folio->mapping->i_pages and locked by cal=
ler
>>   * @mapping: @folio->mapping
>>   * @uniform_split: if the split is uniform or not (buddy allocator like=
 split)
>> @@ -3425,52 +3421,26 @@ static void __split_folio_to_order(struct folio =
*folio, int old_order,
>>   *    @page, which is split in next for loop.
>>   *
>>   * After splitting, the caller's folio reference will be transferred to=
 the
>> - * folio containing @page. The other folios may be freed if they are no=
t mapped.
>> - *
>> - * In terms of locking, after splitting,
>> - * 1. uniform split leaves @page (or the folio contains it) locked;
>> - * 2. buddy allocator like (non-uniform) split leaves @folio locked.
>
> Are these no longer relevant? Shouldn't we retain this, or move it
> elsewhere if appropriate?

With lock_at parameter, people can get this from the __folio_split()
call sites. But a comment is better than none. I will move it to
__folio_split()=E2=80=99s comment area.

>
>> - *
>> + * folio containing @page. The caller needs to unlock and/or free after=
-split
>> + * folios if necessary.
>>   *
>>   * For !uniform_split, when -ENOMEM is returned, the original folio mig=
ht be
>>   * split. The caller needs to check the input folio.
>>   */
>>  static int __split_unmapped_folio(struct folio *folio, int new_order,
>> -		struct page *split_at, struct page *lock_at,
>> -		struct list_head *list, pgoff_t end,
>> -		struct xa_state *xas, struct address_space *mapping,
>> -		bool uniform_split)
>> +		struct page *split_at, struct xa_state *xas,
>> +		struct address_space *mapping, bool uniform_split)
>>  {
>> -	struct lruvec *lruvec;
>> -	struct address_space *swap_cache =3D NULL;
>> -	struct folio *origin_folio =3D folio;
>> -	struct folio *next_folio =3D folio_next(folio);
>> -	struct folio *new_folio;
>>  	struct folio *next;
>>  	int order =3D folio_order(folio);
>>  	int split_order;
>>  	int start_order =3D uniform_split ? new_order : order - 1;
>> -	int nr_dropped =3D 0;
>>  	int ret =3D 0;
>>  	bool stop_split =3D false;
>>
>> -	if (folio_test_swapcache(folio)) {
>> -		VM_BUG_ON(mapping);
>
> Good to get rid of this.
>
>> -
>> -		/* a swapcache folio can only be uniformly split to order-0 */
>> -		if (!uniform_split || new_order !=3D 0)
>> -			return -EINVAL;
>> -
>> -		swap_cache =3D swap_address_space(folio->swap);
>> -		xa_lock(&swap_cache->i_pages);
>> -	}
>> -
>>  	if (folio_test_anon(folio))
>>  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>
>> -	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>> -	lruvec =3D folio_lruvec_lock(folio);
>> -
>>  	folio_clear_has_hwpoisoned(folio);
>>
>>  	/*
>> @@ -3480,9 +3450,9 @@ static int __split_unmapped_folio(struct folio *fo=
lio, int new_order,
>>  	for (split_order =3D start_order;
>>  	     split_order >=3D new_order && !stop_split;
>>  	     split_order--) {
>> -		int old_order =3D folio_order(folio);
>> -		struct folio *release;
>>  		struct folio *end_folio =3D folio_next(folio);
>> +		int old_order =3D folio_order(folio);
>> +		struct folio *new_folio;
>>
>>  		/* order-1 anonymous folio is not supported */
>>  		if (folio_test_anon(folio) && split_order =3D=3D 1)
>> @@ -3504,126 +3474,44 @@ static int __split_unmapped_folio(struct folio =
*folio, int new_order,
>>  				if (xas_error(xas)) {
>>  					ret =3D xas_error(xas);
>>  					stop_split =3D true;
>> -					goto after_split;
>>  				}
>>  			}
>>  		}
>>
>> -		folio_split_memcg_refs(folio, old_order, split_order);
>> -		split_page_owner(&folio->page, old_order, split_order);
>> -		pgalloc_tag_split(folio, old_order, split_order);
>> -
>> -		__split_folio_to_order(folio, old_order, split_order);
>> +		if (!stop_split) {
>> +			folio_split_memcg_refs(folio, old_order, split_order);
>> +			split_page_owner(&folio->page, old_order, split_order);
>> +			pgalloc_tag_split(folio, old_order, split_order);
>>
>> -after_split:
>> +			__split_folio_to_order(folio, old_order, split_order);
>> +		}
>>  		/*
>> -		 * Iterate through after-split folios and perform related
>> -		 * operations. But in buddy allocator like split, the folio
>> +		 * Iterate through after-split folios and update folio stats.
>
> Good to spell out what the 'related operations' are :) Of course you're
> changing this so this loop does some and the other loop does the post-spl=
it
> rest.
>
>> +		 * But in buddy allocator like split, the folio
>>  		 * containing the specified page is skipped until its order
>>  		 * is new_order, since the folio will be worked on in next
>>  		 * iteration.
>>  		 */
>> -		for (release =3D folio; release !=3D end_folio; release =3D next) {
>> -			next =3D folio_next(release);
>> +		for (new_folio =3D folio; new_folio !=3D end_folio; new_folio =3D nex=
t) {
>> +			next =3D folio_next(new_folio);
>>  			/*
>> -			 * for buddy allocator like split, the folio containing
>> -			 * page will be split next and should not be released,
>> -			 * until the folio's order is new_order or stop_split
>> -			 * is set to true by the above xas_split() failure.
>> +			 * for buddy allocator like split, new_folio containing
>> +			 * page could be split again, thus do not change stats
>> +			 * yet. Wait until new_folio's order is new_order or
>> +			 * stop_split is set to true by the above xas_split()
>> +			 * failure.
>>  			 */
>> -			if (release =3D=3D page_folio(split_at)) {
>> -				folio =3D release;
>> +			if (new_folio =3D=3D page_folio(split_at)) {
>> +				folio =3D new_folio;
>>  				if (split_order !=3D new_order && !stop_split)
>>  					continue;
>>  			}
>> -			if (folio_test_anon(release)) {
>> -				mod_mthp_stat(folio_order(release),
>> -						MTHP_STAT_NR_ANON, 1);
>> -			}
>> -
>> -			/*
>> -			 * origin_folio should be kept frozon until page cache
>> -			 * entries are updated with all the other after-split
>> -			 * folios to prevent others seeing stale page cache
>> -			 * entries.
>> -			 */
>> -			if (release =3D=3D origin_folio)
>> -				continue;
>> -
>> -			folio_ref_unfreeze(release, 1 +
>> -					((mapping || swap_cache) ?
>> -						folio_nr_pages(release) : 0));
>> -
>> -			lru_add_split_folio(origin_folio, release, lruvec,
>> -					list);
>> -
>> -			/* Some pages can be beyond EOF: drop them from cache */
>> -			if (release->index >=3D end) {
>> -				if (shmem_mapping(mapping))
>> -					nr_dropped +=3D folio_nr_pages(release);
>> -				else if (folio_test_clear_dirty(release))
>> -					folio_account_cleaned(release,
>> -						inode_to_wb(mapping->host));
>> -				__filemap_remove_folio(release, NULL);
>> -				folio_put_refs(release, folio_nr_pages(release));
>> -			} else if (mapping) {
>> -				__xa_store(&mapping->i_pages,
>> -						release->index, release, 0);
>> -			} else if (swap_cache) {
>> -				__xa_store(&swap_cache->i_pages,
>> -						swap_cache_index(release->swap),
>> -						release, 0);
>> -			}
>> +			if (folio_test_anon(new_folio))
>> +				mod_mthp_stat(folio_order(new_folio),
>> +					      MTHP_STAT_NR_ANON, 1);
>>  		}
>>  	}
>>
>> -	/*
>> -	 * Unfreeze origin_folio only after all page cache entries, which used
>> -	 * to point to it, have been updated with new folios. Otherwise,
>> -	 * a parallel folio_try_get() can grab origin_folio and its caller can
>> -	 * see stale page cache entries.
>> -	 */
>> -	folio_ref_unfreeze(origin_folio, 1 +
>> -		((mapping || swap_cache) ? folio_nr_pages(origin_folio) : 0));
>> -
>> -	unlock_page_lruvec(lruvec);
>> -
>> -	if (swap_cache)
>> -		xa_unlock(&swap_cache->i_pages);
>> -	if (mapping)
>> -		xa_unlock(&mapping->i_pages);
>> -
>> -	/* Caller disabled irqs, so they are still disabled here */
>> -	local_irq_enable();
>> -
>> -	if (nr_dropped)
>> -		shmem_uncharge(mapping->host, nr_dropped);
>> -
>> -	remap_page(origin_folio, 1 << order,
>> -			folio_test_anon(origin_folio) ?
>> -				RMP_USE_SHARED_ZEROPAGE : 0);
>> -
>> -	/*
>> -	 * At this point, folio should contain the specified page.
>> -	 * For uniform split, it is left for caller to unlock.
>> -	 * For buddy allocator like split, the first after-split folio is left
>> -	 * for caller to unlock.
>> -	 */
>> -	for (new_folio =3D origin_folio; new_folio !=3D next_folio; new_folio =
=3D next) {
>> -		next =3D folio_next(new_folio);
>> -		if (new_folio =3D=3D page_folio(lock_at))
>> -			continue;
>> -
>> -		folio_unlock(new_folio);
>> -		/*
>> -		 * Subpages may be freed if there wasn't any mapping
>> -		 * like if add_to_swap() is running on a lru page that
>> -		 * had its mapping zapped. And freeing these pages
>> -		 * requires taking the lru_lock so we do the put_page
>> -		 * of the tail pages after the split is complete.
>> -		 */
>> -		free_folio_and_swap_cache(new_folio);
>> -	}
>>  	return ret;
>>  }
>>
>> @@ -3706,10 +3594,13 @@ static int __folio_split(struct folio *folio, un=
signed int new_order,
>>  {
>>  	struct deferred_split *ds_queue =3D get_deferred_split_queue(folio);
>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>> +	struct folio *next_folio =3D folio_next(folio);
>>  	bool is_anon =3D folio_test_anon(folio);
>>  	struct address_space *mapping =3D NULL;
>>  	struct anon_vma *anon_vma =3D NULL;
>>  	int order =3D folio_order(folio);
>> +	struct folio *new_folio, *next;
>> +	int nr_shmem_dropped =3D 0;
>>  	int extra_pins, ret;
>>  	pgoff_t end;
>>  	bool is_hzp;
>
> There's some VM_BUG_ON_FOLIO()'s in the code:
>
> 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>
> That should probably be VM_WARN_ON() or VM_WARN_ON_ONCE(), maybe worth
> changing here too?

Sure. I can convert them in a separate patch. Basically:

if (!folio_test_locked(folio)) {
	VM_WARN_ON_ONCE_FOLIO(1, folio);
	return -EINVAL;
}

if (!folio_test_large(folio)) {
	VM_WARN_ON_ONCE_FOLIO(1, folio);
	return -EINVAL;
}

>
>> @@ -3833,13 +3724,18 @@ static int __folio_split(struct folio *folio, un=
signed int new_order,
>>  		 */
>>  		xas_lock(&xas);
>>  		xas_reset(&xas);
>> -		if (xas_load(&xas) !=3D folio)
>> +		if (xas_load(&xas) !=3D folio) {
>> +			ret =3D -EAGAIN;
>
> It is beyond words that the original logic manually set ret =3D=3D -EAGAI=
N...
>
> And this is the only place we 'goto fail'.
>
> Yikes this code is a horror show.
>
>
>>  			goto fail;
>> +		}
>>  	}
>>
>>  	/* Prevent deferred_split_scan() touching ->_refcount */
>>  	spin_lock(&ds_queue->split_queue_lock);
>>  	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>> +		struct address_space *swap_cache =3D NULL;
>> +		struct lruvec *lruvec;
>> +
>>  		if (folio_order(folio) > 1 &&
>>  		    !list_empty(&folio->_deferred_list)) {
>>  			ds_queue->split_queue_len--;
>> @@ -3873,18 +3769,119 @@ static int __folio_split(struct folio *folio, u=
nsigned int new_order,
>>  			}
>>  		}
>>
>> -		ret =3D __split_unmapped_folio(folio, new_order,
>> -				split_at, lock_at, list, end, &xas, mapping,
>> -				uniform_split);
>> +		if (folio_test_swapcache(folio)) {
>> +			if (mapping) {
>> +				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
>> +				ret =3D -EINVAL;
>> +				goto fail;
>
> It's a new code path (in prod we'd just carry on, or in debug we would
> haven oops'd), but I think valid.
>
> I wonder if this is almost over-cautious, as this would require a non-ano=
n
> folio to be in the swap-cache (since the is_anon path will set mapping
> NUL).
>
> But at the same time, probably worth keeping in at least for now.

Originally, it is a VM_BUG_ON(mapping). I am converting it to a warning.
I will move it to a separate patch to avoid confusion.

>
>> +			}
>> +
>> +			/*
>> +			 * a swapcache folio can only be uniformly split to
>> +			 * order-0
>> +			 */
>> +			if (!uniform_split || new_order !=3D 0) {
>> +				ret =3D -EINVAL;
>> +				goto fail;
>> +			}
>> +
>> +			swap_cache =3D swap_address_space(folio->swap);
>> +			xa_lock(&swap_cache->i_pages);
>> +		}
>> +
>> +		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>> +		lruvec =3D folio_lruvec_lock(folio);
>> +
>> +		ret =3D __split_unmapped_folio(folio, new_order, split_at, &xas,
>> +					     mapping, uniform_split);
>> +
>> +		/*
>> +		 * Unfreeze after-split folios and put them back to the right
>> +		 * list. @folio should be kept frozon until page cache entries
>> +		 * are updated with all the other after-split folios to prevent
>> +		 * others seeing stale page cache entries.
>> +		 */
>> +		for (new_folio =3D folio_next(folio); new_folio !=3D next_folio;
>> +		     new_folio =3D next) {
>
> Hm now we have 'next' and 'next_folio', this is quite confusing.
>
> Seems to me new_folio should be end_folio no, like the original? And mayb=
e
> then rename next to next_folio? As it is kinda inconsistent that it isn't
> suffixed with _folio anyway.

Sure. Will do. next_folio was coming from __split_unmapped_folio() code,
I should have renamed it. Thanks for pointing it out.

>
>> +			next =3D folio_next(new_folio);
>> +
>
> We're no longer doing what would here be new_folio =3D=3D origin_folio
> (previously, release =3D=3D origin_folio).
>
> Is this correct? Why do we no longer ned to do this?
>
> Is it because __split_unmapped_folio() will somehow take care of this in
> advance/render this meaningless?
>
> This definitely needs to be mentioned in the commit message.

Because =E2=80=9Cnew_folio =3D folio_next(folio)=E2=80=9D in the for loop i=
nitialization
part. The @folio is skipped at the very beginning. I will add a comment
to highlight this, since the code change is too subtle.

>
>> +			folio_ref_unfreeze(
>> +				new_folio,
>> +				1 + ((mapping || swap_cache) ?
>> +					     folio_nr_pages(new_folio) :
>> +					     0));
>
> Again, be nice to separate this out, but I think in a follow-up not here.

OK.

>
>> +
>> +			lru_add_split_folio(folio, new_folio, lruvec, list);
>> +
>> +			/* Some pages can be beyond EOF: drop them from cache */
>> +			if (new_folio->index >=3D end) {
>> +				if (shmem_mapping(mapping))
>> +					nr_shmem_dropped +=3D folio_nr_pages(new_folio);
>> +				else if (folio_test_clear_dirty(new_folio))
>> +					folio_account_cleaned(
>> +						new_folio,
>> +						inode_to_wb(mapping->host));
>> +				__filemap_remove_folio(new_folio, NULL);
>> +				folio_put_refs(new_folio,
>> +					       folio_nr_pages(new_folio));
>> +			} else if (mapping) {
>> +				__xa_store(&mapping->i_pages, new_folio->index,
>> +					   new_folio, 0);
>> +			} else if (swap_cache) {
>> +				__xa_store(&swap_cache->i_pages,
>> +					   swap_cache_index(new_folio->swap),
>> +					   new_folio, 0);
>> +			}
>> +		}
>> +		/*
>> +		 * Unfreeze @folio only after all page cache entries, which
>> +		 * used to point to it, have been updated with new folios.
>> +		 * Otherwise, a parallel folio_try_get() can grab origin_folio
>> +		 * and its caller can see stale page cache entries.
>> +		 */
>> +		folio_ref_unfreeze(folio, 1 +
>> +			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
>
> This line is horrid, probably one for a future series but this sort of
> calculation of what the number of refs should be post-freeze should clear=
ly
> be separated out or at least made abundantly clear in an open-coded
> implementation.

It is addressed in patch 2. And you already noticed it. :)

>
>> +
>> +		unlock_page_lruvec(lruvec);
>> +
>> +		if (swap_cache)
>> +			xa_unlock(&swap_cache->i_pages);
>>  	} else {
>>  		spin_unlock(&ds_queue->split_queue_lock);
>> -fail:
>> -		if (mapping)
>> -			xas_unlock(&xas);
>> -		local_irq_enable();
>> -		remap_page(folio, folio_nr_pages(folio), 0);
>>  		ret =3D -EAGAIN;
>>  	}
>> +fail:
>> +	if (mapping)
>> +		xas_unlock(&xas);
>> +
>> +	local_irq_enable();
>> +
>> +	if (nr_shmem_dropped)
>> +		shmem_uncharge(mapping->host, nr_shmem_dropped);
>> +
>> +	remap_page(folio, 1 << order,
>> +		   !ret && folio_test_anon(folio) ? RMP_USE_SHARED_ZEROPAGE :
>> +						    0);
>
> I really don't like this !ret but here, this isn't very readable.
>
> Something like:
>
> 	int flags;
>
> 	...
>
> 	if (!ret && folio_test_anon(folio))
> 		flags =3D RMP_USE_SHARED_ZERO_PAGE;
> 	remap_page(folio, 1 << order, flags);
>
> Would be better.
>
> But really this is all screaming out to be separated into parts of
> course. But that's one for a follow-up series...

Sure. Will add another patch to address this.

>
>> +
>> +	/*
>> +	 * Unlock all after-split folios except the one containing @lock_at
>> +	 * page. If @folio is not split, it will be kept locked.
>> +	 */
>> +	for (new_folio =3D folio; new_folio !=3D next_folio; new_folio =3D nex=
t) {
>> +		next =3D folio_next(new_folio);
>> +		if (new_folio =3D=3D page_folio(lock_at))
>> +			continue;
>> +
>> +		folio_unlock(new_folio);
>> +		/*
>> +		 * Subpages may be freed if there wasn't any mapping
>> +		 * like if add_to_swap() is running on a lru page that
>> +		 * had its mapping zapped. And freeing these pages
>> +		 * requires taking the lru_lock so we do the put_page
>> +		 * of the tail pages after the split is complete.
>> +		 */
>> +		free_folio_and_swap_cache(new_folio);
>> +	}
>>
>>  out_unlock:
>>  	if (anon_vma) {
>> --
>> 2.47.2
>>
>
> Generally I see why you're not using origin_folio any more since you can
> just use folio everywhere, but I wonder if this makes things more
> confusing.
>
> On the other hand, this function is already hugely confusing so maybe not=
 a
> big deal and can be addressed in follow ups...

Since it is causing confusion. I will use origin_folio in the moved code.

I will send V4 to address your comments and add
=E2=80=9Cmm/huge_memory: refactor after-split (page) cache code.=E2=80=9D i=
n.

Best Regards,
Yan, Zi

