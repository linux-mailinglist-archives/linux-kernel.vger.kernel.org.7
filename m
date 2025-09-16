Return-Path: <linux-kernel+bounces-819309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0D5B59E78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D457A3647
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795C831FEE4;
	Tue, 16 Sep 2025 16:57:14 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021091.outbound.protection.outlook.com [52.101.95.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D528D8D0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041833; cv=fail; b=M19aTg6o+ANoqPji+4F8GtZl4X0Rknkm3+CXA9hV4t9NnZ1KwA/hiMscfCSLmn6Fi5udLKnh+arxWxqcsO/IDvhDPHHlX3/b3wnSA5o2wxRV4eq5kt5mc5vIDeuCUIRPOV2hdd8lYzA0c5NCWpxd/5tEtI+FudOkUxdDIqRBgB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041833; c=relaxed/simple;
	bh=PcfuUEsUTq/w2zYtFvyom5Zs9TDTwvasO+/h6iuwp6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mu/pye/B7f+CeOw5yziRytb9WFGoVGhpLJzjAp/ftsVMCyPf6DHHhRftHa4gvBRsKJwWhJdGEKR7nLV+WjXe2AfCR34mq7ak26zhdyx23QpM3pN58O+xdTg+/VCpNnn1yufr8vQl4IQpj421+4IsXEmqaL/gVHTAtFTUA9+x/ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6TbmOBes5xOmtz3eaSIv+MsdEsJ9k5LOTxKYjTIooUPbJm9Nqi7dVpSf1Wy+zlrso5SjHZuW48UwR3kCtLlzgW2L3CgPag1/IdcWsLzQ5+55Wwbpb+QXI9S3Q5sb6rf5LRdfvXqWx4EV32u8igescgsCrdgYVhTlGmVFFKW7ymDlr2tHGapJwgyLpy379+zj/aHZi5kQTKqW63v9ERhxvg2f05Ff8EZPEuiTjErKY1kQ+vowbRbimelYXPtJ2kabKYgLPs12FQhd55eUzQumf1GYNjgleIAqWI1syjaI6KBTcKNOA5rDIIUdKJr8TuyCwV17eruu/NjnkRsFv2zKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAiQF9hO7a2p7lbhLatcDvlj1pA02yvMd60oE1zA/xw=;
 b=zUcSaVK6MWY7KeSool7gAuMDiVBIvSxZI4zOux/TQg290WkONPM9QW0xEm1hFQWz4t5DLPpQXcvmS9oboPHcGokZzzOpdaiA4a9MXSPKUZZ0dNhKjLC0Ht6StIkpI+Gf8hXhvMeoQvGykSkWqlAhGlw13AvyRKS11EPeeqKvDvu5e4WNxvnPaBajS0SPynJaQZZpxFS3CTi4s+6mV4fRmk8KHemK1DTgIWMgsnVUtnZGniFdDIPfROvU9H3S4qeM0eiwrBFC5fb825yTVMfn3Y09On2ytJRCnKSRKjZjo/JAcprVlLpKk230AOHd8FjhO3Kexr24+DZTknx/Ygqzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB3916.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:14d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 16:57:08 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 16:57:08 +0000
Date: Tue, 16 Sep 2025 12:57:04 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	shashank.mahadasyam@sony.com, longman@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Report failed rt migrations to non-root
 cgroup without rt bandwidth under RT_GROUP_SCHED
Message-ID: <ziakoghx6xbfvcocc5kcrcw5gv4xlphto44bptadkfbbtyf6op@d2fvj7rbec26>
References: <20250916011146.4129696-1-atomlin@atomlin.com>
 <6zi6fp2kgs2hjychav3rrf22qwwskegdq53ew33tfn7rylueik@slugq2khaakw>
 <4nafhr4wqvta5uk4jfuxi7rc7fyaurflrfxa54ajaajy3o57mj@55qzh24m2u6s>
 <3emv4bx2o7mdv7oc72ffdinlltqohqjt5nxgccdiyw47xjgbww@drvkcpiy5zq5>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3emv4bx2o7mdv7oc72ffdinlltqohqjt5nxgccdiyw47xjgbww@drvkcpiy5zq5>
X-ClientProxiedBy: MN2PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:208:134::41) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB3916:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3f5410-a79b-4ad9-06ec-08ddf542127b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VW9CWkRvWTFMSVZkcUw3ZWlLU0M5SStpQnlSVXcyckkweXpzMUdEdko3Tk56?=
 =?utf-8?B?MnVxNzE4Tll6cDZmS1hkQkhNVmsyVmVyaUZLMWx2Y0JiMlgxNnkycHAxU2tT?=
 =?utf-8?B?NlU1dmtrb0lHV2E1QnpWejA2b3JJR29RbzRhYU9yL25lL3I5Rnp6aWQ3UzBi?=
 =?utf-8?B?N2JXSFZ2ZXlSa2FKMkphWWZjTDNBU2lhS1hCM2x5dC9iMDVLcFhJN2pOZ2px?=
 =?utf-8?B?RUgrek1QR2RlSHF2TWVJSGVKWDFhZnVpOWo1a0JWNitRSW9waHZNMlM5bUw0?=
 =?utf-8?B?UUFuTFNqa2llMVFSYktvOTkxZWRWeUdtTGFMWjU2UW5zR3JXOXRzdmM0cWFt?=
 =?utf-8?B?R25XemRIb2ozSjZjOEM3M0dtazh3N3hKVXYvRHFxTlNWdWFXbDYyMUtzNEtp?=
 =?utf-8?B?OE1OcTFNR3AveG96bGNQYzFHN3RZTmdQMll4Sjk0ZEh1anVKSVlCMjk3RXUw?=
 =?utf-8?B?RTZYbFQ5WDZLRlRpZzBFYmFUc2hVY0Y5d1JaekRKM1J0ekZUYlIxbVp5VVBz?=
 =?utf-8?B?UWhJOGo2UGZZUVV4dnBLRktKaWJkMUc1L0Rtd1pYOWk5Ylh0UGVxZjZWRGF6?=
 =?utf-8?B?QkEzcDdPKzVFMlFBUUtiak5iN1VQTWZKVzNRT2JmNzNOUHZQdmFhcEpnRUpy?=
 =?utf-8?B?TkVCakpZRXYxZEMwbUUxN1BmQ0t5MExZVldMZFh0UzYyczEvNndZSnhaKzMr?=
 =?utf-8?B?eVNzd3R2bEp6RHVjcnFlV28xZVFPcTRuUXB3eXhpQ3FTQXdtQlo0alN2OEo1?=
 =?utf-8?B?SitmVmRvcVFWaldoSi9QT294V0tIQ3BHQm54emkyTHpkVFd1cGJoWXBES3h1?=
 =?utf-8?B?QmhIdUlvNDQrTjRIeG5PNWlWOHhqeE5kMFIwTi8zUkJqQTRiNnZxVHNhTmxm?=
 =?utf-8?B?Qmt4eHFPcUttSlBJOFpPWjVsK3dMaUhzOUtSZjQ2L1FKSE9WUXdOQWZHYWJh?=
 =?utf-8?B?UEpKNDluQXJFMzFoT2tSRzgwMlRSL3ltSXd4OU96YmVnek9rWnk1S0hCT1RT?=
 =?utf-8?B?MU9zemt4SkQ3MDMzUXEza3FaODBDSk1Pc29YdU0vclBIVzhZK2Y0UWtDSGZC?=
 =?utf-8?B?aklDOTYzd1JyTnMxbXdYQmNMaVRFNm9OZkVVYlBlZ0pBbVNvdkh4S05vb0Vo?=
 =?utf-8?B?cVVYMXFuL3BRY1hWcUpZeUhrcCtNdC85L0I0L1ZXdFV2cHlSUVJ5YXJPUzQw?=
 =?utf-8?B?cnR5NWd6eTZUcGZYbHNobHBiQTloMmxxOTQrQTV4Z3ZIT29EZ2oxc0R3OUo5?=
 =?utf-8?B?dDRoaUN4Z3lBWTU5SVZaRnN2VUxaMEtDbkRiRWw1eDlJTk0xU2lHS0Ixbk53?=
 =?utf-8?B?NDlPZ3hUSFE4Z05Xc0IwUmo4eHA1djczbTg4cy9YeGpZNzR2MU1Xc2pLbmNz?=
 =?utf-8?B?bXdzMXVYdEtKVk9jMDBBZVM3OEZMUFVwZVQyYmgvWUI1d3JQZ2ZBN05xdjVT?=
 =?utf-8?B?Z2dGeHIwai9KUnhTT3FqK0UxTG9KdVFNUUNyY0t0VDJBQ3VEaW5PcmovaGEz?=
 =?utf-8?B?U2IvQjlrVUVtZ2dMTURSV01EOE9HMWZiY2g3eDF2aUUzQTNpTjcxbDl1MUZa?=
 =?utf-8?B?Rlk1TmRtYVZUZ0xNRzhTcjJjMkl0dkR0RWlkSms2MFd4TzdsUTRZSkF1U3M5?=
 =?utf-8?B?RVBSbmx2L2hVZDZpS3dLMVRrOEp0L1RCY0dZaTkzN3VGbWsxb0xGbTRpQWlY?=
 =?utf-8?B?QTJPaTdnNDI4TnZPTUduSXc2QVJ4dldreUZKdmtMR0dSd3B0R0gzMGV6Qld0?=
 =?utf-8?B?bEsxZTR6V0hjWmlYVHgxWDdWNnA1cFpkMm5NUGdRaStDREx6T2MvSk9vWVFG?=
 =?utf-8?Q?U3FTV6/4+cIzFpT+CroKJH2lFuWNQoCsSNeIw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnVVbWpzaHRXWUVJZW9sUzhZbkd0dG9FVEVYU1FYMGtLb1RhSXhsRERRUlNn?=
 =?utf-8?B?S3ZNVTdIdmptZm10dGYrQnhiellScHFVZTRVUzZFY2dpak95elFZMzB5MUlY?=
 =?utf-8?B?YmxnK3BlcW5ZSkhCSE8rK3gzbS9UaVBveWhKRCsyTjBlNkpYUm96UVR1Z1F5?=
 =?utf-8?B?T1pzK2plM1hocWplSmdzS3htQWoyZ2t4VFRMUXg1NFBkZWdmQWJsU1NmUTY4?=
 =?utf-8?B?ZUs1MWtiWmJzQVY1WE0vUXZBbmN2N3E2QWlqRTl1MWRhT0xJY0NhbUEyd1U2?=
 =?utf-8?B?VmE1UFozNXBWcWhYRHJLRUs1eTJoc2lqN1pwWUI4QmFBeGVFSGZGQ3lKQVM5?=
 =?utf-8?B?ckVVRWFuUkk0SCtKUEwwRXh0NTJmVEpwSVlDUGtnMVdVQVh3YVFrRkVubWxq?=
 =?utf-8?B?aU4yZlRGNFhmak5nQWx0K3JjUjhlUHQ5MEwraVowVEs4Vk52MzhWamU4Uk1s?=
 =?utf-8?B?MnJjcDVzM3FzWmJxYzlXN0dxTmZCd1NSTHNscWRvYVkrZzNGR1VwekxhcGsw?=
 =?utf-8?B?WENXNU41TVNWSW1iWW1aa0VTaXRieHVHTkFGdjZySThyRXBoWlpnUU9aTGN2?=
 =?utf-8?B?WnFlNm9PQzY1WFlWVHBHOG9BaWVaaEZaek9HOFo3UFp0SW5uTytlWG9IclZh?=
 =?utf-8?B?YkxEQkYxVWdkMS8rQkQ5MFpDbkdpZFZHOENoTjZDUk5va3Y3eVFMdVJnREFp?=
 =?utf-8?B?V2FBK2Z6MkE2QjhDYi95SSsrMld3d1RVVUN1aGh6MTZ4bFNaa1dTWDQ2Kzli?=
 =?utf-8?B?K3pFL2gwaHFKODU2aThvOVBtZTUyOTdpd25PUjNoa2hyWFdUV3VFcGZvYXI0?=
 =?utf-8?B?UjJQK21YczBCSWExQWZsaEsweXYxY3BUdVExNlFVbFJkN2Z0Z2dJa1pUdXJV?=
 =?utf-8?B?Ky9ybHBHZFFzdlZRMWkraHJhcG5CR0h6YkgxRk93M3E1TElSejFNQ0NWSGxh?=
 =?utf-8?B?NWVvaE81czlXZUFxMG4zVXEzelpNY2ZscFRPVzBGUEhDaW4waURaQ3oxd3NG?=
 =?utf-8?B?TTZzZWZUUnpmVFBpMHRnbjc0Y0xVT2hJeDBqMzFHSGVuaDlxOS9ib0lIcXdm?=
 =?utf-8?B?WFZrQVVWMXltZXdGTHJ2TFQ0eDB4SzM3ektDeUJuZ2VKNmp0aWJkZDF5OFJh?=
 =?utf-8?B?aFd3Qm41L0J4MWhhV0wzeElMNzFRNzBQbDJTRHd1UE9adlhITzF2VFZZSTQ1?=
 =?utf-8?B?NWdCL1FLUzJKMjlTUUNvbXdwU1p0d3hIU25wblFpSEhpL0NxajRWQzJVMndI?=
 =?utf-8?B?RVRNOFd6OEw4UzAxNmF1ekJ5Y2VaQ1JXMVlMZFNQTDByeXAyUHJldGVvU1I1?=
 =?utf-8?B?WWpmdmx4a2RrSmpZS2VnazhpM29qWkxDRDgvclppMW9GbFJQUnJjWlpoa0Zl?=
 =?utf-8?B?V2FvWTRLWGc4eGx6eVM2eWNWaDdzR1lDVU0xajFhUWEwVXQybjRaMEtqUkRL?=
 =?utf-8?B?bXJpQkpCQkNzZ3NxYmtMNXArc3Y1MHAyeUdJb1V6OWpSMzZ2NDBjR3JPSUJM?=
 =?utf-8?B?NmxORmRzenM0Mm44Ni9oSG5SK2dDbHlrWUZ6VlVjTW93T2VYbHNyMy9XOUNJ?=
 =?utf-8?B?bU1xenhNcFhFTGNSL3pwbTJac1BLUEgwbXhiWk9yMFZPN2lYNHFUbmtEZ2tF?=
 =?utf-8?B?V0FWWGdaYlowSnZPcEI3UTVyYUV4M1BmQWcrd2JCb0c3aHRXcTdCT0V0bVhR?=
 =?utf-8?B?WGMzcFZXWnlqOWtjbEFYTXFRQTlpMGxpTGVqMjBKVFUvSDJ3Q1pVY1EwbGRk?=
 =?utf-8?B?c2lGL3JTME9TUlBJNXlGOGRWK2hQczR1V2c4R3NIS1JoUUxyemZLdDN2dExT?=
 =?utf-8?B?S05uZjd0Q2NVOEF3WkY4YXFuTW5JbEI2S085MzloNzhaaWhINFoxbndIMnB0?=
 =?utf-8?B?S3QyUTBJdGplUzRlU0EwUTBWMlB4bnB3akc4NDFwV2JOcVVqMkZKV0p5TGVV?=
 =?utf-8?B?RE1IRDRFdnAvVDF4TE93akxlVWh5MFdGd0U5NkczeXNLWVlFV25oTElSU29G?=
 =?utf-8?B?amVNS1pEaDNRNW02Qlk0bFBKK0cyNDF5c0kvdDFZN2FGK3J6QlFsZFBEUmJw?=
 =?utf-8?B?NGtqTnZpVnlIUFFCRmFmdUxaa1o0QVdjdFE1M0RHRVRxVFlyWXZjWXlqcjQ2?=
 =?utf-8?Q?GzX1/24uyq8UqYOYDceDfT94N?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3f5410-a79b-4ad9-06ec-08ddf542127b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 16:57:08.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOn8gMhF0FwO24BPliLNjgrLKYumZU0krFAC9/n9aAgmY0GNsFuQHcu4hSIqJYDyPZyNF7Sm4cK31JcXvSfnrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB3916

On Tue, Sep 16, 2025 at 05:44:14PM +0200, Michal Koutný wrote:
> On Tue, Sep 16, 2025 at 10:47:56AM -0400, Aaron Tomlin <atomlin@atomlin.com> wrote:
> > I would prefer not to take any action. However, is there a strong
> > preference to demote the rt task so the CPU controller can be enabled in
> > this context?
> 
> Maybe more context clarifies. The preference is not to end up in this
> corner.

I see. If I understand correctly, in this context, are you suggesting to
modify the identified task's scheduling class (e.g. to SCHED_NORMAL) so the
CPU controller can be enabled?

> I wonder does this combination come from a distro or is it your custom
> setup? I assume the latter (but I'm curious if there's such a distro), in
> that case you likely want to have the cpu controller on v1 hierarchy. v1
> usage is what the boottime switch is currently useful for, v2 de facto
> doesn't support RT group scheduling as of today [1], v2 systems should
> simply unset CONFIG_RT_GROUP_SCHED to avoid issues enabling cpu
> controller.

Yes. Under Red Hat Enterprise Linux (RHEL) 9 Kconfig option
CONFIG_RT_GROUP_SCHED and Cgroup version 2 is enabled by default.
Albeit, upstream can disable SCHED_FIFO/SCHED_RT group scheduling at
boot-time via rt_group_sched=.

> HTH,
> Michal
> 
> [1] This [2] didn't make it into tree thus I'd be reserved with the
>     message printed in your patch too.
> [2] https://lore.kernel.org/all/20250310170442.504716-11-mkoutny@suse.com/

I see. Understood.


Kind regards,
-- 
Aaron Tomlin

