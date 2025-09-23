Return-Path: <linux-kernel+bounces-828620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDCFB95059
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50FE2E0DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC70931D379;
	Tue, 23 Sep 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="teLO8FaW"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A09031CA56
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616619; cv=fail; b=F9WNZjNlGDhouiRbWCy/EyOmxem7DShh8Qfy6Zl82Pe6j+ltL2SPYPCl/A2w6lYO/ZRDxVko0Gct0C276EUK3uaibqpbgwQhdzQoJYUTVPO3TdUAvMQT1fIM8pYZFCjWiORNKWxnGhALdgxsDP7VIsHYgmHGu9ZsbJS0HNzN/wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616619; c=relaxed/simple;
	bh=YhPKHhn3njADkxdNivjYl4WYLi6v4WPrqU+FdUlwqSg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LCt56Q+Ay+dR4rc9Z1JCgkphijPCUGbJr4+OvuN3b7yufpKEgTq3zdZscMy7PfmSbsXGYQFWofnBROCwClBOq3/KOPf0Ushzl2umaJkT2KxvmsXiS8iUWhFmnrSSPpO+PR7cDxiJCbNxh4ZzqQb0mw/8RHBHFM7U2J4CXWjE2DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=teLO8FaW; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jF4p5wMxdsLQKfmZlMdYoMYTJzW/0DF7gi8uD2Zd94XFcGIB6tHyruz0edhpia+UElpGE0IDilsLvHtSX/HkXU3AEQBgN9wHDLmDdRmYqQzVQeR3crVgK887OfJ55K6qbkr32pkvpNnqLNic6GYQ25aCZN0r5aU+Sh7lRPbGEsdnT1JO+9TPub1UWrFa3HXs58ixzSwghmJ/2N3T4UULsAxBZY0XQ8vNJGW/afRw6A+wrYcKqoJFqdONhPjZa4vsj0h9WqpYEgunowO6BZPC/AqYP2HjMkzXhhwEx6u4/P4GSVLflaBHgcaiYfAh/B74vgKYzEAVE5LxdPs2FD09gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdIJ7BqTWxjXEIUFX4zshCKmyeks7W+an+sDVTnNrcY=;
 b=AQ6yy9gsANDQ8nJFbJGT5xUVIZgqRACYqdy8gywlEK548JTT/EmAWMbJyQGLNev4F/D4gTpfDdYXJoNGH6exwc5A48cSQQM08RvYN3v9yFpTZ06VrngBpJGho1nTTTBW6cTFQRKok+9rsgMRv2icO62z3EbVsbygmDMV3My47IiCoZEc3anp6jZcyRI/tBE4wP6IgQZPE/nYIWW2OSRbJMemUtGAIG6LL4gcWae1XJG550mtJ4d18M6LzPvk7QPCUrgWJ/PrZnM2jndCl1fmFv8oAkpSPhob/vNQ46PL9fsRnO0KigrxAoiFLYU9pB8rsrPCgjGRyUKniwgHW6VQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdIJ7BqTWxjXEIUFX4zshCKmyeks7W+an+sDVTnNrcY=;
 b=teLO8FaWJArMBisgEYgVXZfvns1KQNXX9DlywF4NaGrrD7iXU/XPD1tNvDmjfE26EiA3zW5WaB7co1oRBLeAadSzmI0YCYNlEoT5Mrc2bvOYq0Jg1TB+2QK4/vZ55q6Csx/FtpcUeJmt30nnXTdeLCNTFscMyn9znyZT4Dt3f/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 08:36:53 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%5]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 08:36:53 +0000
Message-ID: <02da5912-b77e-42fa-be1c-d10c915730d2@amd.com>
Date: Tue, 23 Sep 2025 14:06:42 +0530
User-Agent: Mozilla Thunderbird
From: Raghavendra K T <rkodsara@amd.com>
Subject: Re: [PATCH v7 13/16] mm: memory: support clearing page ranges
To: Andrew Morton <akpm@linux-foundation.org>,
 Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 david@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
 acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
 willy@infradead.org, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-14-ankur.a.arora@oracle.com>
 <20250917144418.25cb9117d64b32cb0c7908d9@linux-foundation.org>
Content-Language: en-US
In-Reply-To: <20250917144418.25cb9117d64b32cb0c7908d9@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0110.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::11) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: f971f4cc-8262-420e-82d0-08ddfa7c5898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2lKTjJ1WmRBa1JDZ0FHaFFJcy9FTDRabDdSdDhZNnl1MW04eEFkTURjaGQ5?=
 =?utf-8?B?VHBqNTUyUTl5VTZBZC9tdEZ6RS90aGRIT0xpQ29oazZTWEFHUGkwOGovWUJi?=
 =?utf-8?B?RWFLUTgwS1lycHo5NCtuWUliemllbk9MRnlUMjU4WngwS0QrV0tsUFE5eEFT?=
 =?utf-8?B?WHFiam9uRHNTSnBjWW1wN0FhdStickVQc3JweU13R3I0MUFMVmF3alRocmtj?=
 =?utf-8?B?eldESml1QjhwdEhqKzQyb2ppdFVraWZrK1Jqd2NrYU9RVTJwaGdNUWdmZGNw?=
 =?utf-8?B?bTFxWWxOME5BVXlQMnU2b2xULzVlNDBlckRYRmtaZGlNMWg5V1N0NnZVc3V3?=
 =?utf-8?B?aHlHUVR3ZUgzNWwyOVlBODd1QnRMeVJrOFhUVWdSWG14NFZGWU9XZGhseEg4?=
 =?utf-8?B?aTFUdXFKOW9aUG16M0NrSWl0cVI4OEpRRnRkdzlSZnhLbkw5RDNlLzZQU3da?=
 =?utf-8?B?MmppTVJKZGg4NmFpV0N2V25pSjRJU0hFMGRqalFEdDJvYXBsTEhTN2xGMkNt?=
 =?utf-8?B?dms5b0FrZitoc2crblA3N21ZZ0tPWk8zYWw2dlJBOEVQOGc4dWRrakhrUVZi?=
 =?utf-8?B?YW9VRmM2ZWxwQWdRTHhpSTN6TXh1cGJuVDFzL3piMlVpRDBxQzVxalpOQzVo?=
 =?utf-8?B?RDZrdXhSY1VNWXA5bUhENGVkb281Mk01SnFQbk92Vm5WV0lXLysvVU9OQnJI?=
 =?utf-8?B?cWY0aFEvL0QvTDBwKzdpdU4xVHRxUmhmekdBeVJqYzcwclRBV1FmYjdvTUhl?=
 =?utf-8?B?b1huR1Azd2FZajVwMU1zd01CR3Zrd3EybVk3RzdYc0YvT08rVlBwbUdpM2Uy?=
 =?utf-8?B?ZWdFSGhsV244bHVpeE9RL2Zqczg0K09TemdJZmxBMzFBTzg5N0FFOWwveXY1?=
 =?utf-8?B?Wk9Hdzh6VkFzalE2UVYwNnV4TmwxOUNzcklDR2FKTU53dmRoc2hLaVF1QzBU?=
 =?utf-8?B?eldUb1BGSUhFVlVOSzNPTUI5RjNNaTNucTZJQ1lDdDVrUU5JcXlYUU1HY3Vv?=
 =?utf-8?B?NW1GR3R4a1Y3UjV1VG1hOHpLRkJvaGF3d3IyYzZTTGJTUnA1SnNnbFgvSGRv?=
 =?utf-8?B?L3pLVG5HbjRxOWVXTFQ5RmJBc0ZpZWhEcTlwMmlxeUhlNXBnSDQvYUc4Vk9O?=
 =?utf-8?B?OHJyYUJTTCt2cnh5NU42QU9HbWZ6M2d0VzVaZVJNaWFwc0tIUnNxaXFjVzN0?=
 =?utf-8?B?TkpRVkdVcU1jMlhyZXZFUnZEcVRIOFNpL2lNSlEyelpoUkZRUExxb0ZZMk40?=
 =?utf-8?B?ZWttOWZGdVl2YnI4REl5YTI5c1J1RGpHeFl2MXg5SFd1Rm05bnpLa20rN09B?=
 =?utf-8?B?Sm5uOTdGVmhPTXJWOHZGbFVRVHVUZWhvaGw2WFdKTGdNRE1xN1lqSW01VDll?=
 =?utf-8?B?Zkg3dXZ3Um8xWTM5LzFDdC9ON2NHWEh1TU51dTdXN3BhUlRJNkNkcjVhN1Bt?=
 =?utf-8?B?a1JUQ0QzRVFVTUlMQ0dkQmtSa2M1U0xNYmhTdEJEV1h5STZxSlV0eDl2cmlN?=
 =?utf-8?B?UVo2SXM5eFBoeWFxR2VXM3kzMDI2UU9Fak5UZ0VtRlZkN29YdkZ5TXk4a0JO?=
 =?utf-8?B?UGl2dnlSUHhDaStxbTg2aVNzZ1V5QkU5NndqL2J4U0dIOVQ4WUVSTWJra2pQ?=
 =?utf-8?B?d1Fmd1hTWDZuYWwwMDNzRlhoTmdmczBnelM4am94TTBMb2YvV1FLMEdYakVz?=
 =?utf-8?B?TXhoVGN5Tm95Mm9kYmxsOVFsdlF6dHNWdUhtSjJXcVZyNUtBeFEyUUJha2hZ?=
 =?utf-8?B?NVgybVpOZVpNY05jS3cwNm5nR1U3MUdPbjBRamxCbjJkV0xEc3BuQ1ZtdVNv?=
 =?utf-8?B?bVhtK3NqR3dmN0I2QzIraTdkOE10ZjVNa201RXpDUGRwWmNwbndGWTUwNDZT?=
 =?utf-8?B?cUFpcEZsZVZSYldqQkFOVFJZSS92Sm55VG44cWtEQWVxUkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elhqbVhqT2g4RHk3VER2cWVPMFRuTlRzZFZYUzJxT2diRnN0aHNiaTFYVno5?=
 =?utf-8?B?MGhsS3dIc0c2dkRhU1BwRHpLOHJiWW5Ldk40bmwzaDMvKzhuYml3R2JCaVA3?=
 =?utf-8?B?MWRZcjhpYVRINVBTQVYrYVpXbkxtK2luYXVHb1pxd082TlExMVF5OWFmS0xR?=
 =?utf-8?B?U1Y4bm5HL04yb3JuVDRoSjMwc1dyQ3gyaGcwN3FRRGd3MEErUys5VGZjVzZV?=
 =?utf-8?B?ZW90d0pOcGFrbTNvb09wSzJCTGx1dHg3STFHOWVJQzdXcWxBVzY0UzR1V3Na?=
 =?utf-8?B?dmNRblMyR2dwT2dBNEhTcGlxT3V4VlYxMG5zV2UveHlnTEYvR1BIazlBVWVk?=
 =?utf-8?B?R0cwYU5semNXWlMyQ2xmRGNYNGV1RDl6TWVjU1p1YUFGUWF2K0ZpMVpsU1Ro?=
 =?utf-8?B?ckF6cTBCMVRXTHNCNStERDFZR2FMbWc4ZVVwL1lXcnVLMFV5TnZKa01iaTVP?=
 =?utf-8?B?RmVQbG14WkdFb3VUVFZCNkNJVnhnSkh5Njh5Q1BNUFU0UDc1K3VsaC9BbGpI?=
 =?utf-8?B?UjFMK0NERHZaNjlrZjhxWnNiUk92MG9oam00TGtCZzB2MCtzNGpqM1NOb0NC?=
 =?utf-8?B?V0Mrd2tvMHhyQ3UreXRzZlc2VXY5WUNVNFpPemZmQzBIMTdTTy82SlBZaCtB?=
 =?utf-8?B?UW5oQWF5UGp1MGhwSFVVQzl0K2w0Z3llUDBpRGltUjV1U3RGdlRTTEt4KzQy?=
 =?utf-8?B?Z0NLanU4ZWxmemFDbFg4eGt0am5nRWszMzJmSWVReUtCWUZXZWFtWmUrUXZG?=
 =?utf-8?B?WENEaldoZysvaFRLMHNqMktnSGJDR1FVMHdPNU4wdTQ3R0l2cmMrYlg2R0sr?=
 =?utf-8?B?T2tzTmR6USt5aFB6c1laNk9ORTNMRGhzV1VTM1IyU2w1Unc1c3dTckhLaSsx?=
 =?utf-8?B?UGhRSFFYaEtzSzZobEE5MzRHTW5oZ0cxVkkwa2w3NEg0dlRjejZGeTVCelIy?=
 =?utf-8?B?VnFtSHl2SC9GRmNaYlhwUGI2SGhma0x2by9DZkJTVWlaaHNHVTR0Wkw4VEw4?=
 =?utf-8?B?Z3NHaFpxcWFwSHRiZFk3d21vK1JmZEV3elRVMExNeUxrSEp5UVVVZTNneGNO?=
 =?utf-8?B?QkRveE1oU3h3ZU1JYVFVYVdtT01idzNlcGxnZlBhRENLRm5UNnBoTTRhbUZL?=
 =?utf-8?B?bkZyczhEdVdjckZHQmNLd3pJUWJQZDlsSUc4Vm1OUzBLMW5LelFhK1A1MlRH?=
 =?utf-8?B?cFA1L0pkYTI0K2RVaFJCZU9CcHBhek54Y0pzQ0xxUkVTWEZveFpRVkFQRE5I?=
 =?utf-8?B?bWtweHN4Z2tpbEpzY0JNb1ROdU9CMUprUTBZaFk2bzRQZ3JPdmpJQjJRNEV0?=
 =?utf-8?B?VEZjYWIzSG1jc2V1ZEdPZDY4MmExRVIxb2xuQjUwYVRydDZ4d1o2c1F2RjJK?=
 =?utf-8?B?RVUvUy9DMGMxT3pFUDUxN2ZRYWNtRDFIZm12eXpxZWNSbUdjUUpQT3JiY0M2?=
 =?utf-8?B?d2kzck5JUGVoQVdnV1VxdHhvUG1GWURsU2dnd0hkdldpa2ZURXhGMVRndDBI?=
 =?utf-8?B?aktiTkFpdVErRDlKcWpuempVamZsbmdhWXF1UnFRUkduR3lFWFFyMks2Y3Y1?=
 =?utf-8?B?dVl4dldwVmxxSXozeTF6ZE85Yk1UeVd4NXRxTjVGdFV3ZTd5SEY2SFF0OXhj?=
 =?utf-8?B?M2FSMlcwd28vTm1uOEkvN0g1NFFaNnVhQ2Mrd2tlUFdOaUNmc2FCT1RxOUVV?=
 =?utf-8?B?YVBtV3R1T0lMeVh3ZDd6QUwzNitxV056WlRzWHFEZG9UM0tTcmZRaWN6bHR4?=
 =?utf-8?B?SWUvVVd2VGJPM3E4NkxITEhhbXJ3SGNHZHpINlM4dEhDY2ZvaWg2UE42ODFp?=
 =?utf-8?B?MmhkVG41dFpQb3hPSHpVWmx1UkpYNVRSdmRzbWRnS0dEUWtuV1RPdmpPejZN?=
 =?utf-8?B?SnNycHQ0dEQ5TDU2aU5udkxOaEhZRzlpWXZMNHA5dzZvM3N0UUdFbUY2QTdi?=
 =?utf-8?B?L1V0L3VwMG1KUE1tWS9NaFdHMWJLWjJUOUgyMzIyRFp4bndhd0NnOU5xTWN5?=
 =?utf-8?B?eHVSLzhwK0RST2xZN1JWQzIvVUVSMEhUV0ZWd2I0S3Y1YUs5R2pJWkdZS1JZ?=
 =?utf-8?B?SHBhSWNqQ0g4S0NaemUvMlY1c3lvRzdQbnVpTnRwZndGSGxENWpGVnZyckw3?=
 =?utf-8?Q?Fm1ur0UTSxBHlA/l4KDo6XuBz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f971f4cc-8262-420e-82d0-08ddfa7c5898
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:36:52.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGft2egnUdVAmQJxYUZOik5mTsxghL2rRCqQZQMSO3qsQFjW8qiDFQ2rwSBCgCzPI4X2Q+nMRJSC84CbsCvoGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045



On 9/18/2025 3:14 AM, Andrew Morton wrote:
> On Wed, 17 Sep 2025 08:24:15 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:
> 
>> Change folio_zero_user() to clear contiguous page ranges instead of
>> clearing using the current page-at-a-time approach. Exposing the largest
>> feasible length can be useful in enabling processors to optimize based
>> on extent.
> 
> This patch is something which MM developers might care to take a closer
> look at.
> 
>> However, clearing in large chunks can have two problems:
>>
>>   - cache locality when clearing small folios (< MAX_ORDER_NR_PAGES)
>>     (larger folios don't have any expectation of cache locality).
>>
>>   - preemption latency when clearing large folios.
>>
>> Handle the first by splitting the clearing in three parts: the
>> faulting page and its immediate locality, its left and right
>> regions; with the local neighbourhood cleared last.
> 
> Has this optimization been shown to be beneficial?
> 
> If so, are you able to share some measurements?
> 
> If not, maybe it should be removed?
> 

I reverted the effect of this patch by hard coding

#define PAGE_CONTIG_NR 1

I see that benefit for voluntary kernel is lost without this change

(for rep stosb)

with PAGE_CONTIG_NR equivalent to 8MB

Preempt mode: voluntary

# Running 'mem/mmap' benchmark:
# function 'demand' (Demand loaded mmap())
# Copying 64GB bytes ...

       34.533414 GB/sec


with PAGE_CONTIG_NR equivalent to 4KB

# Running 'mem/mmap' benchmark:
# function 'demand' (Demand loaded mmap())
# Copying 64GB bytes ...

       20.766059 GB/sec

For now (barring David's recommendations),
feel free to add

Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>



