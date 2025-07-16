Return-Path: <linux-kernel+bounces-733422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55157B0747D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5D04E7FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204D42F2373;
	Wed, 16 Jul 2025 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qm8Mv9qI"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FE2C15B9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664762; cv=fail; b=RB2De2tcZmiSp5MT2YIENwgaKlrRwB4XcsjM7mAWBLxoAm7EkklBfCo7dFpAZQBHDGwoLUP5PszBiHVCFZWJyiQp55nDE7ChseS857F/cAdtVz1R+LDnp97s2ECn87qoM7k7G5R8/p9Vu6paw9R7nujsDfciqVm70lrmjnaXVvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664762; c=relaxed/simple;
	bh=slAvbRpvNQCZ32ZgLcODuqgDW/kjw3nA5/czQXjydPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G4h7jBv3DSF0pGpGdLuomC4bZji/zPtY2PAOvZvq1yil0fpRo+HoD7W0bCuwz27RGDan++E9WjhE9+MqENFPjiKZc+JABp1XMHz8Myrwx0FrQ6dF/cwiDNNZYdwVECz/U7AW+Lfhh59jkfjjkZgOpFAySvRIFVPP1hMNpbIqGXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qm8Mv9qI; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wobpbeN/U0n0puO/3c0upxpkGCpEZcjOsy8lhtsM5BW+KJ+wy4J3qsZor1PhHAFwwFLor9M9yzB+I4gHrPm7vrdRNBmm+wz6NGZQK3mwtDeBVXIDLjYRaLHAiG9CYOoi4NRx9XJSTd6yHSS0tcjvjObejWA+BZLxx6Xzi3jfaE6Olef0L84WILBvDLk+GNdRKcHido7y6Wk+zedtUZWmecNiNQoT88rzmDlNJG15fMeXHkTLxbvwxmHSCAOTELK/htM4OofXbvjMmmQgDrfePDyjaJrInr2NOOCzOwR5T9pkAJoEQ2e6es+14krEwaKWmvhMExFyvVoSuOZ6IvGwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dISxPZUq6Rl0BRCVHlcNukR43f9+wGsizqoQZ6HT0jI=;
 b=HHJDPFn277S+MzzXNvumsW6efnihsBtnxqmMnf6QqNe+wzDA2sqzXv5XasAeXsaC3SNvUHYNhNilDTAIhSDlGMzsy1dEZB0FA+dd6Ho0umZ0vQMS2A6ByMJdGHh4dzwLQ3yXfgQJ4WI4OZKODp4BZEPkOLkmn96zLblXBale3bs9ahjT96f0f3id/KZuGowa8PKazr25w3Y9MkWd74d561vvSbxRRuE+yKGBtwCtr8CjTw4yvd63rTHQMUEx/PZBSB7gufvdn6luscaAQu+Le2CQJeV0VqUcgT2hkfv8bCXOjIj1bc+RZEAboVUwohq9Kyku0M+ZWSm1FsV+lEVu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dISxPZUq6Rl0BRCVHlcNukR43f9+wGsizqoQZ6HT0jI=;
 b=qm8Mv9qI2+I4TxUIKE8AM42Yu2sF9cxv8VxnG6qBxVQ7Xr4Oc6X3QKNGyfNMYmTqzwcqkwpxxNQqNYjwWYKPCuutSjJsWONeDthJJjj2iS5UaDUSzQ8E8jq+YrH4hLTc7K8EGxwcfHZFLI3Ydc30LKaSQtWqS6JUJqTIpaFsW0s3yKlBvDcQpyfdpms6QvmLo0AHej+OsBNt+R9/CiKXa27AVuMWGXrWHtkgez1Xyp9eLnxXLx+otuAv1aAG0ZeDpJgzkTrPNwASvsfanFCagZVzFvaxJJDHDd0iXXKRoTO2+VDp3A2gnlkWpPCDmTqzmBVcW+4+tO40bFLUGhTBEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 11:19:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 11:19:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Donet Tom <donettom@linux.ibm.com>
Subject: Re: [v1 resend 08/12] mm/thp: add split during migration support
Date: Wed, 16 Jul 2025 07:19:10 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <1DD0079E-0AF6-49F5-9CB3-E440F36D2D9B@nvidia.com>
In-Reply-To: <aHc5/pmNLf4e9brJ@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-9-balbirs@nvidia.com>
 <D129A3F2-D79C-482E-BC70-A26C781B149E@nvidia.com>
 <1a451d37-56c3-4d60-8e06-3abae72e6bbd@nvidia.com>
 <007E2728-5BFC-40F9-8B8F-25504863D217@nvidia.com>
 <aa4f94a3-f601-4379-b6ca-4389421ccca4@nvidia.com>
 <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
 <aHc5/pmNLf4e9brJ@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL6PEPF00013DFA.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:d) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: de8a974d-dd75-49c3-0935-08ddc45a9831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1Nad0hOdElYZndEWk9XYnJPUHJEblRPVGl0Yy9MMDIvZ2loVmJCU2hMOVZi?=
 =?utf-8?B?OURGbllCUnYweis1eTVXMnZCQlNMeVhKR1phd2c3aUVmajJCQ0gyR3NDTTNR?=
 =?utf-8?B?cjBmL3NnUkE2TVBhRWFaY1JDK0xpQ3pNT1lDNC9IRWkzRFNZVWZ4T3lCbUtm?=
 =?utf-8?B?L3hwY2FRb2hTdi8xS0pNUW9VQy9sMW83V1RCcDY4aHN4TW5ja2VZUGYxakpk?=
 =?utf-8?B?UCtrdEc2TUM0eldQOGNDcFBGcVVMZnhFeXpwNTdVWmt5UTZsR3BVRk1sQUtn?=
 =?utf-8?B?bUwyendraUlXdUp5dGZJSU9obTlRejl1RnpEK3dSaDVxMzF5UjZqYlRDWVZ4?=
 =?utf-8?B?bUE4eWc2azdTOGxFOTA5VTJ2RnZWRlhCT21WdHVPeVhwQkVibUErNGxyUEtL?=
 =?utf-8?B?bWNvMGFTU3Z6YWpDcldBc256WUtDWTdmeGQzZnQ1bmRlOXpVMDVIb1FUbm5B?=
 =?utf-8?B?U3gxWUI3Vm8xZ2hTOEt2STBuc0FWc1Y0NE9GcFR1UGp1bE9BTHVaN3QwNVRP?=
 =?utf-8?B?RDhyNlljRmlQc1hnREk2aGg0dHhuUWVzdUlwNTBkcG1DcEE2dnJOeUQ3WExl?=
 =?utf-8?B?MFR6TGswS3hhMjdjK2tXcVZJL1RWR3FiL2pQUGlCV0M0WEtQNEVaRmJXbnBl?=
 =?utf-8?B?blZmZGNHaUhmM2todHVkYWVwYjQyWktaRG5kU2RDYXJZak1QcTduR1lML3d1?=
 =?utf-8?B?SmZuWlJBQWM2NWFSTXQ4VzlDRTBmSG5kQUhnclNsRW5xdHpPcng3TVJJNEJN?=
 =?utf-8?B?ZWRUMEJ0dDZxNFJHeURBS3d2RE1CN0lmTENFK3FyZXFIbkI4OXo4cWMwSkdT?=
 =?utf-8?B?WGFacXhER2NwWjk3OFdzb3FZKzlRNzlRVDVqRWFvbHJReFZWNnl6WDZOUDFY?=
 =?utf-8?B?bDhwQlRiaC9ueGcwQ1hMZEorSlc1N2c4UHlPcjJpaU02dys0ZWVFemlObnBD?=
 =?utf-8?B?V1lHUFJYR2RZbXEzNFAraWFLODJPUFhyVHhJOFB3TUU3dnNLWmwvK2VHRndu?=
 =?utf-8?B?Yy9aMDgreTg0eGVoYWhIQjR2TUxib1g0eE1qVUx1N1hMN0dHZHgzUE9PTHl6?=
 =?utf-8?B?bHlzTXQyUzhaMjRDTTBhYjVwNFhNWmFpQkd6YW13U1NhSWlkenpTTUxtRzY2?=
 =?utf-8?B?RHNnRCtDT0JZTDZodmpwN21BbHhWMlRuTk1abWt3WTZ1eGlBK0kxVDh1a0tO?=
 =?utf-8?B?UkpVSFAzL3FVdFJCa1NnVTkzTW4rSHBHODZqVm5OOWZpUGs1VnY4NFVxMm5u?=
 =?utf-8?B?TkloS2owZWVZMlBoSG4yLzQvV2YyYjJzOTBOTUtCVXEwdGxXNVlHQ1hQcHJ3?=
 =?utf-8?B?N1BCaWxXem1IWHVaZ1kxZ3RNNTZnejRSWVZCaFhuREs2OWcveSthRWdVR0d0?=
 =?utf-8?B?dzFaYjVDNnA2QjVhR2FhWVp1d1ViS21LdHZWaWNraXVaSjdKRmdEYVhuem9D?=
 =?utf-8?B?dVZ1OGo2eEFRWmRXYVdLdGRlQmlvcFh1KzlEMWh1a0JQRmZkbVVwZTJ0cWVn?=
 =?utf-8?B?cDJicFJCWmhlTVY1c3hnenBFK092cXRjdzdvL0JoQmo2WWRCakVSRlVtRGVB?=
 =?utf-8?B?YlZNR0N6dFI3LzgwLzkrdHo0S3FOaU1GOVN1T2hCTlBoMjFDVlhzT0I4VUt5?=
 =?utf-8?B?eTNmcDlNYmdZOXkyOUNQbURxWFMwK1c4TEw5cUtLLzhXV3k2VlhWUEZud3lY?=
 =?utf-8?B?bUZpbTFHR0RZS0l2dlpaM25QVVlMOGRqdnV3b1RIRzdsOWhnYjZac1k2YXRx?=
 =?utf-8?B?WWhZRlRCNWxsR3lvM2xiYTFKaElFVHNwUTYwbUlwVDkycG1obDNmYSsrZXNo?=
 =?utf-8?B?ZEZ6UE93R3hrcmpEQ1l6R3ZEdWd0dUUxT2d1TmFmSld1MDAydzR6ZDhHeUZE?=
 =?utf-8?B?WW5QR0JvWXhpK2Y0RzJQckJYcEZHNjQwV3ZqUXYvRFFRYlNrTURpbWxkbGx3?=
 =?utf-8?Q?wvAosvYN2Ag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d002SE1LMUdlU2VvSWZVek1lV3FtY3c0ZW1sYldaVGNKdjlKYkQwWDNFSTVi?=
 =?utf-8?B?ZFM1MU1MS01QNUY5RnJBRGs4ZzBtcDVjamROOUpKdko2VGpHZnZxdFdrbUo1?=
 =?utf-8?B?RWEwMDJQVzJtdGtJUVhXSXVZWkNGYWtmazArU1dWV0pBbmVXSVowVFhJa2N6?=
 =?utf-8?B?OFZRV1p4MXFpVEg5NWxjQmRQRzRvWUd4RkZsOUhrYnU3Y2lrS3dsNWxFUndF?=
 =?utf-8?B?NE5zY1FWcUhTanVkamNCU1NrRFZMOFhLemx5UmJ4dDlNaUJ3RFFwcjNmZG4z?=
 =?utf-8?B?YzY0aDY1R2tPeEVPNGtocGg4MmdWeXZqRStrakc2MGk3NnQxay96ZzRxSFBn?=
 =?utf-8?B?NlowV2MzUGEvZUEzcjFIQ291YTJ3dmUrM2llbVVFLzBhdUFTd1NPc2JlbHpr?=
 =?utf-8?B?Z0RFbFdZaDMyc0daNzg4ZEViUTNzeGJqOUwvZERkTlpsL1NjQlg3ckhLM3M0?=
 =?utf-8?B?YStMemhtb0ZGeEQyTlRaR1I4ZTFHbUJnS0xTaDN5OFhqdEpWY2l3UFRhVlg1?=
 =?utf-8?B?NlNXTjdrMTEwV21FcXcvVTJUbFYwSzdLK1JGRlhtT3N3REpUV05kQmlYL0NS?=
 =?utf-8?B?NlVyVXJVTVFCejA1b3Q0OHAwNjN6MWRvTkZaR3pmd2ZTek8zNElzcjZBOC82?=
 =?utf-8?B?N0l5cEZTeHd2S2hxQUxsQnBBK0o0M2xHa3ZNeHJNaG96dUZWakIxUlR1aVhv?=
 =?utf-8?B?eSt2REwxR3hOazI1U1FYalJlWXY0ak84bUdRbjZESHBoeDc3MndBT3BpZmcz?=
 =?utf-8?B?N1Zyd2EwOXN6N3ZGdGN5QmUzdG9oQlZVZDBvTHVqUlV3d3YyQThXdm9rR1Np?=
 =?utf-8?B?YUJ3ZXAzeGQ1YkhsMUcxM1UxS3VldDBmbTRzd0lWMFBHeVIwZklSK2t4Yllt?=
 =?utf-8?B?cFd5dTFoMUtsYVRaSk1KeXVucGFIdGpyTnN6Y2hwRW9UVjdjbndNNmJHS2pG?=
 =?utf-8?B?SHN1Q0hzaUtEb2dCTC84NUhjMkhwci9ENE9FbzRiN0llQ1Mvdi9RVGc3REky?=
 =?utf-8?B?bGJwOTJ6RUkvdENBK0dIYlVIZ1VKdjNUQ3g1aUl6bm9CbHF2SUplYkU5SDJh?=
 =?utf-8?B?enFpdU0yNHFwaVZiZ24zTnFMWUxIOFRtekZRL1BuVFV4WkJqZW9WeGVJeE0v?=
 =?utf-8?B?NzZ4STU4QkxHd2xoN1RiTis0V0xTZHFkUGlRMFp5T0tGUG5iaG5tMFFuN2x6?=
 =?utf-8?B?TURrcFdjdFBkaTZqeUk1Zi9TekUvS1c3dkNtakx6d0MyODREelhJVnppNDcv?=
 =?utf-8?B?SC9NUmRhQWw2VW1yTlcxc3ZWYlY1aWMzY2R2Y2FnNjh1TWZOcXBCOUNNRmhj?=
 =?utf-8?B?MURMaEV5YlhTVDRXSVd4NjVReTRhWllwejdVNlJrVERraEhKM09iVEhyb25J?=
 =?utf-8?B?MURWeHlLQ2JYb1Q1eEhqKzVwT0hpWWpGUXM4TllqMWF2SUNscEtNa2hMN25O?=
 =?utf-8?B?bjVCSmY5Q1NXNWZ3dkVWTUFmM1hRSFA5SGRzNzBHb3JPM2VBVURiLzBHWFpO?=
 =?utf-8?B?alBQMnV3a1dPUmVnM3l2MDBPdW9sQUxndGRUSHVYT050ekRxd3djY2F0UDJa?=
 =?utf-8?B?NDN2cnFIbW1WU29RVW1pY3pqb3loRXdqQU5lQ2lSWkRyVWQvREhWK211bktu?=
 =?utf-8?B?YTczcGtzTncrSHFjMXJwd0x2eVFQTElCOU5zc3NJMHBrTXJrNVp4L3YwMG1P?=
 =?utf-8?B?WjdxSnpWQXB0Sy9Da2h6NWxUSUZSRENuazRXamUyMjlxSVczTzAyQXpnRnpN?=
 =?utf-8?B?U2RTSk9PSWZ5djRVRFVRelVNVG1sRjgvdTgwT0U4dGw3bE1ucldhWkdMaEpD?=
 =?utf-8?B?cVMvSG5mbVJnZkE4aVJ2VmlaQkRMZjdUQ1JzQU0vODlkRXdpUGlhdVUzUEFm?=
 =?utf-8?B?V0dlU1UxZTVQbGJBOXd4S3JBejkybnFVMFBYcDkyUTZncURhRmt0M2IrYVl3?=
 =?utf-8?B?VFozckxJUDNCWHZHSkZlUk9FY2NDdW5WTnBaamdFckJ4REprTXlXWk9IQzRH?=
 =?utf-8?B?elVnNm95a0ZpdUt5eWgzSW1PR2ExcVlqREM1UGxTMVlCaWx0WVBhQ1VGdkU3?=
 =?utf-8?B?dXFoeFUzVlVKSDkrcU1DQ1dEUkFOT2NFZkF4Z1FUNkZaOUEvV3JIaFdnOCtE?=
 =?utf-8?Q?iqcDJ9z3EBC+0FHuqgP8ncBHy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8a974d-dd75-49c3-0935-08ddc45a9831
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:19:13.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csBjHJ3EPXxpCuhZGbs8ijDEvn2KtYNlN7Mk6VA2dEZ8XSHm24xNgOzAeB+3zKjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981

On 16 Jul 2025, at 1:34, Matthew Brost wrote:

> On Sun, Jul 06, 2025 at 11:47:10AM +1000, Balbir Singh wrote:
>> On 7/6/25 11:34, Zi Yan wrote:
>>> On 5 Jul 2025, at 21:15, Balbir Singh wrote:
>>>
>>>> On 7/5/25 11:55, Zi Yan wrote:
>>>>> On 4 Jul 2025, at 20:58, Balbir Singh wrote:
>>>>>
>>>>>> On 7/4/25 21:24, Zi Yan wrote:
>>>>>>>
>>>>>>> s/pages/folio
>>>>>>>
>>>>>>
>>>>>> Thanks, will make the changes
>>>>>>
>>>>>>> Why name it isolated if the folio is unmapped? Isolated folios ofte=
n mean
>>>>>>> they are removed from LRU lists. isolated here causes confusion.
>>>>>>>
>>>>>>
>>>>>> Ack, will change the name
>>>>>>
>>>>>>
>>>>>>>>   *
>>>>>>>>   * It calls __split_unmapped_folio() to perform uniform and non-u=
niform split.
>>>>>>>>   * It is in charge of checking whether the split is supported or =
not and
>>>>>>>> @@ -3800,7 +3799,7 @@ bool uniform_split_supported(struct folio *f=
olio, unsigned int new_order,
>>>>>>>>   */
>>>>>>>>  static int __folio_split(struct folio *folio, unsigned int new_or=
der,
>>>>>>>>  		struct page *split_at, struct page *lock_at,
>>>>>>>> -		struct list_head *list, bool uniform_split)
>>>>>>>> +		struct list_head *list, bool uniform_split, bool isolated)
>>>>>>>>  {
>>>>>>>>  	struct deferred_split *ds_queue =3D get_deferred_split_queue(fol=
io);
>>>>>>>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>>>>>> @@ -3846,14 +3845,16 @@ static int __folio_split(struct folio *fol=
io, unsigned int new_order,
>>>>>>>>  		 * is taken to serialise against parallel split or collapse
>>>>>>>>  		 * operations.
>>>>>>>>  		 */
>>>>>>>> -		anon_vma =3D folio_get_anon_vma(folio);
>>>>>>>> -		if (!anon_vma) {
>>>>>>>> -			ret =3D -EBUSY;
>>>>>>>> -			goto out;
>>>>>>>> +		if (!isolated) {
>>>>>>>> +			anon_vma =3D folio_get_anon_vma(folio);
>>>>>>>> +			if (!anon_vma) {
>>>>>>>> +				ret =3D -EBUSY;
>>>>>>>> +				goto out;
>>>>>>>> +			}
>>>>>>>> +			anon_vma_lock_write(anon_vma);
>>>>>>>>  		}
>>>>>>>>  		end =3D -1;
>>>>>>>>  		mapping =3D NULL;
>>>>>>>> -		anon_vma_lock_write(anon_vma);
>>>>>>>>  	} else {
>>>>>>>>  		unsigned int min_order;
>>>>>>>>  		gfp_t gfp;
>>>>>>>> @@ -3920,7 +3921,8 @@ static int __folio_split(struct folio *folio=
, unsigned int new_order,
>>>>>>>>  		goto out_unlock;
>>>>>>>>  	}
>>>>>>>>
>>>>>>>> -	unmap_folio(folio);
>>>>>>>> +	if (!isolated)
>>>>>>>> +		unmap_folio(folio);
>>>>>>>>
>>>>>>>>  	/* block interrupt reentry in xa_lock and spinlock */
>>>>>>>>  	local_irq_disable();
>>>>>>>> @@ -3973,14 +3975,15 @@ static int __folio_split(struct folio *fol=
io, unsigned int new_order,
>>>>>>>>
>>>>>>>>  		ret =3D __split_unmapped_folio(folio, new_order,
>>>>>>>>  				split_at, lock_at, list, end, &xas, mapping,
>>>>>>>> -				uniform_split);
>>>>>>>> +				uniform_split, isolated);
>>>>>>>>  	} else {
>>>>>>>>  		spin_unlock(&ds_queue->split_queue_lock);
>>>>>>>>  fail:
>>>>>>>>  		if (mapping)
>>>>>>>>  			xas_unlock(&xas);
>>>>>>>>  		local_irq_enable();
>>>>>>>> -		remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>> +		if (!isolated)
>>>>>>>> +			remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>>  		ret =3D -EAGAIN;
>>>>>>>>  	}
>>>>>>>
>>>>>>> These "isolated" special handlings does not look good, I wonder if =
there
>>>>>>> is a way of letting split code handle device private folios more gr=
acefully.
>>>>>>> It also causes confusions, since why does "isolated/unmapped" folio=
s
>>>>>>> not need to unmap_page(), remap_page(), or unlock?
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> There are two reasons for going down the current code path
>>>>>
>>>>> After thinking more, I think adding isolated/unmapped is not the righ=
t
>>>>> way, since unmapped folio is a very generic concept. If you add it,
>>>>> one can easily misuse the folio split code by first unmapping a folio
>>>>> and trying to split it with unmapped =3D true. I do not think that is
>>>>> supported and your patch does not prevent that from happening in the =
future.
>>>>>
>>>>
>>>> I don't understand the misuse case you mention, I assume you mean some=
one can
>>>> get the usage wrong? The responsibility is on the caller to do the rig=
ht thing
>>>> if calling the API with unmapped
>>>
>>> Before your patch, there is no use case of splitting unmapped folios.
>>> Your patch only adds support for device private page split, not any unm=
apped
>>> folio split. So using a generic isolated/unmapped parameter is not OK.
>>>
>>
>> There is a use for splitting unmapped folios (see below)
>>
>>>>
>>>>> You should teach different parts of folio split code path to handle
>>>>> device private folios properly. Details are below.
>>>>>
>>>>>>
>>>>>> 1. if the isolated check is not present, folio_get_anon_vma will fai=
l and cause
>>>>>>    the split routine to return with -EBUSY
>>>>>
>>>>> You do something below instead.
>>>>>
>>>>> if (!anon_vma && !folio_is_device_private(folio)) {
>>>>> 	ret =3D -EBUSY;
>>>>> 	goto out;
>>>>> } else if (anon_vma) {
>>>>> 	anon_vma_lock_write(anon_vma);
>>>>> }
>>>>>
>>>>
>>>> folio_get_anon() cannot be called for unmapped folios. In our case the=
 page has
>>>> already been unmapped. Is there a reason why you mix anon_vma_lock_wri=
te with
>>>> the check for device private folios?
>>>
>>> Oh, I did not notice that anon_vma =3D folio_get_anon_vma(folio) is als=
o
>>> in if (!isolated) branch. In that case, just do
>>>
>>> if (folio_is_device_private(folio) {
>>> ...
>>> } else if (is_anon) {
>>> ...
>>> } else {
>>> ...
>>> }
>>>
>>>>
>>>>> People can know device private folio split needs a special handling.
>>>>>
>>>>> BTW, why a device private folio can also be anonymous? Does it mean
>>>>> if a page cache folio is migrated to device private, kernel also
>>>>> sees it as both device private and file-backed?
>>>>>
>>>>
>>>> FYI: device private folios only work with anonymous private pages, hen=
ce
>>>> the name device private.
>>>
>>> OK.
>>>
>>>>
>>>>>
>>>>>> 2. Going through unmap_page(), remap_page() causes a full page table=
 walk, which
>>>>>>    the migrate_device API has already just done as a part of the mig=
ration. The
>>>>>>    entries under consideration are already migration entries in this=
 case.
>>>>>>    This is wasteful and in some case unexpected.
>>>>>
>>>>> unmap_folio() already adds TTU_SPLIT_HUGE_PMD to try to split
>>>>> PMD mapping, which you did in migrate_vma_split_pages(). You probably
>>>>> can teach either try_to_migrate() or try_to_unmap() to just split
>>>>> device private PMD mapping. Or if that is not preferred,
>>>>> you can simply call split_huge_pmd_address() when unmap_folio()
>>>>> sees a device private folio.
>>>>>
>>>>> For remap_page(), you can simply return for device private folios
>>>>> like it is currently doing for non anonymous folios.
>>>>>
>>>>
>>>> Doing a full rmap walk does not make sense with unmap_folio() and
>>>> remap_folio(), because
>>>>
>>>> 1. We need to do a page table walk/rmap walk again
>>>> 2. We'll need special handling of migration <-> migration entries
>>>>    in the rmap handling (set/remove migration ptes)
>>>> 3. In this context, the code is already in the middle of migration,
>>>>    so trying to do that again does not make sense.
>>>
>>> Why doing split in the middle of migration? Existing split code
>>> assumes to-be-split folios are mapped.
>>>
>>> What prevents doing split before migration?
>>>
>>
>> The code does do a split prior to migration if THP selection fails
>>
>> Please see https://lore.kernel.org/lkml/20250703233511.2028395-5-balbirs=
@nvidia.com/
>> and the fallback part which calls split_folio()
>>
>> But the case under consideration is special since the device needs to al=
locate
>> corresponding pfn's as well. The changelog mentions it:
>>
>> "The common case that arises is that after setup, during migrate
>> the destination might not be able to allocate MIGRATE_PFN_COMPOUND
>> pages."
>>
>> I can expand on it, because migrate_vma() is a multi-phase operation
>>
>> 1. migrate_vma_setup()
>> 2. migrate_vma_pages()
>> 3. migrate_vma_finalize()
>>
>> It can so happen that when we get the destination pfn's allocated the de=
stination
>> might not be able to allocate a large page, so we do the split in migrat=
e_vma_pages().
>>
>> The pages have been unmapped and collected in migrate_vma_setup()
>>
>> The next patch in the series 9/12 (https://lore.kernel.org/lkml/20250703=
233511.2028395-10-balbirs@nvidia.com/)
>> tests the split and emulates a failure on the device side to allocate la=
rge pages
>> and tests it in 10/12 (https://lore.kernel.org/lkml/20250703233511.20283=
95-11-balbirs@nvidia.com/)
>>
>
> Another use case I=E2=80=99ve seen is when a previously allocated high-or=
der
> folio, now in the free memory pool, is reallocated as a lower-order
> page. For example, a 2MB fault allocates a folio, the memory is later

That is different. If the high-order folio is free, it should be split
using split_page() from mm/page_alloc.c.

> freed, and then a 4KB fault reuses a page from that previously allocated
> folio. This will be actually quite common in Xe / GPU SVM. In such
> cases, the folio in an unmapped state needs to be split. I=E2=80=99d sugg=
est a

This folio is unused, so ->flags, ->mapping, and etc. are not set,
__split_unmapped_folio() is not for it, unless you mean free folio
differently.

> migrate_device_* helper built on top of the core MM __split_folio
> function add here.
>

--
Best Regards,
Yan, Zi

