Return-Path: <linux-kernel+bounces-745931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D20B1209E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8431E3BE504
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10012D8784;
	Fri, 25 Jul 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TtNLg9ea";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="khVt3kk7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D02BDC33
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456064; cv=fail; b=UXGTfsyb6hbWXR2bKqt9ryYNxMlJ/1GlfG+rjaZYRlLCySzRdNv2Ig8tg9KcgGst5UwWAqpmlZ2Rdryc5L/GzG0r32cB3zyecTt/pGmjjs712LNrGlwy48Zt29nRiOynqEqiixeRuSIli0NSWC5KTeHM2zDAJ61xgA9rb15CMaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456064; c=relaxed/simple;
	bh=6GkTPnfeHVHrwVOPn5oiqnK4TS3R/w11OW8atTBH2V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JvkyM65Jc5EqIgmwNT8It8dn+BlXOHIYqmJzGKLF8Pn8GPzVdCvMg/vw+H5ZM8sc0j8asR0NjiMOMzbaEm0meHTac8sVhFlfma7V7QCnZze+5btQCE/cBVVKKgNO926LZLu2l+l0DIB3AZfVo64kqmaAEHFJVRZumksGv21gPc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TtNLg9ea; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=khVt3kk7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PEJ2uK017989;
	Fri, 25 Jul 2025 15:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EeIJrW4BzMPtxZdARKwDXFNHKp0re2+rfCFpJfFaLaQ=; b=
	TtNLg9eaKoVhxL5s0zU4PUyibW2rZ8rrP61A8BD+w7+qOgjtVxuIpASygSN6oTIG
	czSzy/Jf+eMtXWqLtMkOrp440W8AfYhYlYshxmOa2LaQDh77FImqUuoo6BEHkre2
	DnsLndVRi9uNW2E8Zla85bsYOC526XtCzkobYrFpp4h2g3S+7nalQrAgR6iJGP/c
	DOARJin09CgOwUY7OruhHr4ISUuSbf9O6kBmpqmtuxobuh9e4Zz7UaNGtr7fIHSp
	0H8B1sJ+lYZ21z/MkdlyDDN/WE+2zsCsh0MwnfvA6SDegHBTKOc+DRRMzVtP7frd
	2PBxQiyj90Da4e6jXd/9bw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1n176p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 15:07:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PDAYsN038356;
	Fri, 25 Jul 2025 15:07:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801td7nk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 15:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDRLLkJmP0j4bXn3uULGgKhjAvecQPPEtSeRwxC2BomZiugxnl2znc+2h7vyMBtGkVYsWNwfsgWYyEHI3fudEHkY3aNJLvO93Z5vHTZ4vWQ7gEv2tF4v4ngXUA+g/fabUG0ZqsMZOQy0lPqZc1R87c7ZOsOnd1bS887FIwALDy20u+53iPLGCUDiQsDTaj97J5vtRxsRHMYcdEC0AaZV5VbNFfSDqHgA3YTqASJce4MdnpH+470RPCJegC1uL1oF3VDJf1zLwmyjPA8F77WVCmDa3AuNK+3yKBjMohKn3rC/cs7wXmo9MjjHBOOK7plHcX1B3RDgnJW8r9rtG5zXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeIJrW4BzMPtxZdARKwDXFNHKp0re2+rfCFpJfFaLaQ=;
 b=Npla1rHMFME3ltGeqckPIhBykZUA9053XICfqLMNTo0u+OEWWUo1t2WKzr3yx86ay/o1CT+RiP3vo1I3+BEgfTdkDPw6Kgk1XXKflpZ0RUrUplUoWWcYhPo7274elMPbbfu2BpeZiOMe8BfJFGDm2g9IEOivrolUrO8g3L6BRFJSxP25CKmSZcCspgUHLaNnlJrVgO5CF5BkFewBInXUwESlxET685YZ2G8N/0Ojqjk0dnmkag93HtW8g3j1W9XKWSmGEvpRK1DE6ZzeCXPGA2f3BPIACvt2rfLW+m+eCup+LLUrE8LvMLFX5xWtqmGPrZIPM4JXoAgV30/avqxL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeIJrW4BzMPtxZdARKwDXFNHKp0re2+rfCFpJfFaLaQ=;
 b=khVt3kk7n8xjSHQl5hQOyAFwI6BtGr3ChnsvRKJDhxtEoqe9ejNAaWdiq8T4ObeQSU66nhnpSrV/q1mPK5aCK5xWbHCGUKyG14lC7r2+xttcH5cFkH3TydCzF+AwHMHUbP3PzPNY5jPEkJh2oQF+Jk3rP6xsL++M35C4f55mjeQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7059.namprd10.prod.outlook.com (2603:10b6:a03:4d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 15:07:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 15:07:03 +0000
Date: Fri, 25 Jul 2025 16:07:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
Message-ID: <3cfc1146-1b62-4b04-a2e5-997d10ba4124@lucifer.local>
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
 <c3f04c75-a73b-48bb-b56e-7b18e57c2382@lucifer.local>
 <CAG48ez31aVnoBiMMjUczbmThWnRGmod4yppgMVqf2Nu5-hjU2g@mail.gmail.com>
 <50502c3b-903f-4018-b796-4a158f939593@lucifer.local>
 <CAG48ez1TOULrpJGsUYvRSsrdWBepCJf9jh-xPpurRUXbMmAkuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1TOULrpJGsUYvRSsrdWBepCJf9jh-xPpurRUXbMmAkuA@mail.gmail.com>
X-ClientProxiedBy: LO3P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7059:EE_
X-MS-Office365-Filtering-Correlation-Id: e8868f20-420a-4229-4374-08ddcb8ce9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXBQbG01L2VuSVA0bllwd0s4dWMxUnlXUWRYUDdrZEdkbWN0dFo4eFBkNGNn?=
 =?utf-8?B?UTkwd0pXQkFQVysxLzhPblFFd3VVZWdUR0JYY3oxeDl1RFczaWFTYnRlOEUw?=
 =?utf-8?B?QllMZUozb2tVcjlUclAwakVBNGZDSmtzSXFqUUMyUFJQYk9sWXBpbTR1U2Vt?=
 =?utf-8?B?TlZWQzNsbWszZHlCQ0luVVNFQ0RsR2lNb0RXR3pHU2VPdlhzTzFyenpra0N1?=
 =?utf-8?B?T0tVTTk3S0hiNE1iamJMSFc4b0phdVFxSVgxRHRvSGIvVFdQTFFjcGdEZkh5?=
 =?utf-8?B?TFpiYTVXK1pyeUxJTzYxWVlLVmd3RjdyQVBucFovZmVKVlBWYSswVENMbFUx?=
 =?utf-8?B?NEtOOEpzbWtoS00vWTNpR3RVL2ZXMmNtd09RbG5LbnRLVUU3OS84dEd2enZ5?=
 =?utf-8?B?djNjdnQ0LzMwbWlFcEpzMGQxc2h1Z2ZqTTcvYzFhWkJYcllFK1NJeitnYmFh?=
 =?utf-8?B?NXN5a1BBY0lFU05aMTNXUjhoSExOaDdYU3o1dTdrMUdST2loanBKVG40QW8r?=
 =?utf-8?B?d0hnZGN2eW9PU0dtQk10ekh5a2VtTUo0SEV3SlFLcnhySE9VVHRRYWdIUjd5?=
 =?utf-8?B?b2JoN0RNTGxYYVBzc0FMZ3RKTWQvSytmY3VsWjZCT0llRFUwZHo3WlBxNmNI?=
 =?utf-8?B?cGc1VGlMSnpJOGQ0a21CZDlkcy9xZ011ZFBTZ1VxZTg0c1FTZVZuUnlzR1JC?=
 =?utf-8?B?TFVjMEZyT3l0ZG1yeCt1QWdob095SHVYOWxzUzIwZVE0aHpGVFYxZDNQUXgy?=
 =?utf-8?B?WlB2dmw0NTdsVjZkUDJLYWVnMGFnZStPY2h2QzdNSERFUzRyYnFoM0dUeEZy?=
 =?utf-8?B?Ym9vcmVPK2krNXg0NG5OS1dRcGF3TFZyUklWaUtMS2c5dkxCbE1BUG9HeWpI?=
 =?utf-8?B?cTI4SVZzODdITzRDRk81LytwaUE2OWxiUE04bmtrV2E0NnlxQXJzSG02U1p3?=
 =?utf-8?B?MTdZYVdySEJ6RTI4RUFvVVJHMFJRMG9yNUorZU5INGQvZlNSeDRWNzA3SldW?=
 =?utf-8?B?TVdVSEltTDdXZDNaUUo5L2laa29ZcmI5Z0tpcnk1bmxUVS8zZ1g2Q1pxRHlO?=
 =?utf-8?B?L2tKMWJ1K1dUQzdhMXlWazNuNHN1RHhsaXJLc050TnBObjdneW5IVmVEbmly?=
 =?utf-8?B?KzFub1N2azFhciswelVsY0E3aktjaG5iMCt6RmtqcVR3TFZzZ1BtT0hQbzd1?=
 =?utf-8?B?bDFxOTdLeW05cExhWHVmQlFnaTlhak1rMmJHMXJMVHltS0M5bUsxWnl5Rkhn?=
 =?utf-8?B?R1cwUkpLQ1cyRnYvSC82OGJWdjV5VVlFNEQwQWg0T3ZBRERFRzJScjBBaUZP?=
 =?utf-8?B?WkFZVFhLVFVnYnFLMmZQNEloaFhwdHV3bS82L2RJZ3dBVktLcnB2YTRSWk5K?=
 =?utf-8?B?VHZmWjNqWXBCVXdpOWhOa3NWRytPUFgwNVkxbzR3SklWek5sT3ovVms0V3BB?=
 =?utf-8?B?WEprM1dPeHNZR3haS29yUFpXemtiVWd1R1RvTHM5N0VHL2RQdHV5bnZoS1ZX?=
 =?utf-8?B?enRRbjZTUk0vcG1DVDBEM2lyaFY4bXI0aUFyQTNudHpDSTNxK2JhN1piRi9u?=
 =?utf-8?B?b0VCeDdKSk5LekJUam43eDBXdTlGbVJmVzMrM3BJaGFkOUlRYjAzQ1QrVVJi?=
 =?utf-8?B?R1FXSFgxdjVmR2Y3dVBpV2VxUWxWZnViS3NITmtmV2Z4Qjdzc1UrdGVnUTcr?=
 =?utf-8?B?dGoxMHJuVVhvRUJXRXlxLzRERVFpbW9BUVdMUVE5MnoyQitlam9hdjFubjhY?=
 =?utf-8?B?VGNrSkJEZTdBa2g3c3hhK3UzVVJyTEd6YjFLSkR2bmRxWnZtWFhyU3ZNQ0U3?=
 =?utf-8?B?MG9NR01ZM3RjdnF6aDBxYXlOTjdNY3dGT2duT0llU1NGeFVLdFJsbUNuUDVl?=
 =?utf-8?B?SldsNmQrRHpyNWJ1c2ZCYmxGVXBxcTlFMy8zK3lQb1NkeUM3Yjk3ck5ZbHV2?=
 =?utf-8?Q?FZO8BBjn0K8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmRiTno4TXV1aFJvUjUvR3o3YXk3akJmN09FdzkzczhBT2xCd2tBdG9NQnVs?=
 =?utf-8?B?ZkEzTmd4NFJxN0pKeUo4VHRNbWhIN1FKd2dZVmFkWkhYdzllR2dPbFZyV0g0?=
 =?utf-8?B?UmRBUlZqakwzY0N5NjFpVjFWTkVFSTJJM0p2Q05Jb1FVekdSQjB0NnFWWFA3?=
 =?utf-8?B?VHBUelBaaEVwOW9VZS8wejAyWmluVjVZVlV1VnNwbngxQTZCK094b0Jjc0xO?=
 =?utf-8?B?c0syQlllT2pvS205YWJQN21XSWdJUTdZYTA0cjhhK3NpTnVlaERsWldEeExR?=
 =?utf-8?B?a25LWmVDWExWREdrUHZtVjBaSUlxc1lsQmNMSVBiSmxzWk8wbmVFUSt5Z1VL?=
 =?utf-8?B?TzFNTWtCTFJyQ05LVnRERUxLbmVuTjZQbFU3c3ZUU2Z1akVSZzVkWmJKc2R3?=
 =?utf-8?B?T0VxajB3QnBSTkpXL3dZZ0w0TkJXUFNmRlA3VFJEN3Ria1BGNWk5YnJSQTMr?=
 =?utf-8?B?WFEzZXlGbEx4bnRnWWtXenpTRWdaZ3FVUXlJUmROWWp5bmRsYVpZZW9uaEhR?=
 =?utf-8?B?cDZTQzJJcHFHd2dUNFI4bE9QRG5YNkpRbUJZMysxQ09nb3k5SURENGJSbDY4?=
 =?utf-8?B?MHRxaG0zVjQ5K3RGUkEzTUtQbUVZQk5ManpWNHdVL1RjMTd0NnAyNTU2R3Bw?=
 =?utf-8?B?MkNPb2xsZ2c3d0Nja1NzMngzeldMZ1QwZXRaRStxNTdUS1ZrbXZqREpjdFZ1?=
 =?utf-8?B?d2lzSUJXdkJRYVowbW40R1RiTUU0M1oxaU8zWE1QQkFXMUlCVUJhYTRldjhU?=
 =?utf-8?B?M3Z2aU5qNUlTL1g5bk9URXdyUUVKYkIyQ2VkdkxCUXRFbFNwKzFNV2dJWkV6?=
 =?utf-8?B?WjZKRCtXNjkzLzRZSmlrbk4raW50NS9Ec0k1MDhtZXQ4QnlNNnRRVEdKdCt6?=
 =?utf-8?B?Uk84WDEzYUUvclVyRCtQZlhsajNDS2NJaWs4V3RJV1k1MjJDT2JqdXY2a0pW?=
 =?utf-8?B?TGZ4WEU4Q3FsVmdUR1BtL1NrNFdKcWRJbVNBb0k4TEhkMUd0SG1IZW1KbUpx?=
 =?utf-8?B?KzlGZmF3NEFBQk00eHlkOEdLMjZqdVNBc0xNQzJtN1lRclMwbDg4UXpIc053?=
 =?utf-8?B?WVhWTWoxL0NWWUs5TkJiajlLRDJqS2lYYmtEY3J6N3c4T1lIRWFuNklUOWI3?=
 =?utf-8?B?clhsQlRLQmVJNk1abHovMktERkJDWWkyRFlrVXMyei8wTWFLcmwvN3JUdnVY?=
 =?utf-8?B?dTZBMnJvR0VZbXJHNzJPUWJmdHBHNnBha2NPRGpqbzViRnZQbTMrbjBKL2hV?=
 =?utf-8?B?Wnk3SGErRHpCTHZ4c1VleDhBNlZBN1MzWjhTam9FNUdrR2pYVzJSREphbnlp?=
 =?utf-8?B?a2V3UDZkNEhTZkh4TWVZRkl6UU1tZ1Vac1Q4bzNIRHcwcGZIV2dOOGR0QWxZ?=
 =?utf-8?B?ZnRmazhMOG9KbVlQV1h4MXByQTJWSkc5OTYwSlFQbmVPS3pldzZBWlB0RjRr?=
 =?utf-8?B?K0JPZ21nanpydXk0SHRBVGZHN0xzemxJQ24xbXhLWFJITlBpYk9EalhtSlBS?=
 =?utf-8?B?MytUOWg1WWhJd05MWlAzd1ZDYkwwMUJvZ3oveENNcGhmWUFhS2NHT2FZU25J?=
 =?utf-8?B?VHc3bW1oa2tRYkdhSkoyKzY2dVVYUTZqVFc4bC9PM2pLbEVSZTdhNHZqNitm?=
 =?utf-8?B?Umk5bDIzckxtd2Y4bmdYbEJKOGlvZVFBd0daS1ZlaktadXVFQkw0UGhteUVM?=
 =?utf-8?B?TldjRzkrLzFpMHVNbnN3RmFxTjM0U24remhoWS9TRG1JbzFhbE1mc040RjBY?=
 =?utf-8?B?VTk1NlUvcVU4YTdCMFpDL21CTHBDYXUzMEFsa3NMeUNSQjRvSU84WWV2SGpD?=
 =?utf-8?B?ZzFEcFZFOTdocERmQm42MktLMmRiY0gwT0JUMlVQaVdsYkgyKy91bkljZFB1?=
 =?utf-8?B?d21LYzM4RmVQemV2Unp0dHgzY2E1S1lDY3R0S0w5VGlCQnRYKzl3UlRiR1VM?=
 =?utf-8?B?Z0tZSnVBMGpNTWVKbGlvNGt3Z0ZXTnFJeGRzSDBZWXVldmZMUEpWb0MzMEtu?=
 =?utf-8?B?NWVJY3BrMXhMSVROdVpRdHA4WFRmekZBb1BYcWtwR1AxMXd2VHpsOWNpYkNp?=
 =?utf-8?B?a1g2WVIvUEZja1pTQkJZNDhXTU1XSWdEWndxaHZJc3NUT2kyMVpaTEtjVXJa?=
 =?utf-8?B?d2tCQXBPbld3SkpnU1Q3WjRYM2lZa0gvUTl6eDQrTEhHSWh5eEZXK3ZOd0lh?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fWoVwkxop9Jxdt/kZysjPlaKo16fnbKE3ze1BnBWbkUdLSLQUP30a+azpJfEVr8BWgnDkaPKRI5neX8XexQZOsluCazgH6xD1gStCKPIZwOjywSfLbmtUba4KZVyl2OBofmjLz4WMSRYUDrBEuWVYSuzK8itveYWwZ+VZRmhqqjz5u9L9g+uzKyd0HRLGjmJ3eyvA0qesK+wKDqIOkPHxzY+WAELxEp00Zae0rctFVwH58ARyfvw43iEMSl1r9g05J/SdP4FZGKHmO1OKwBAVYixzikkF1CtndL3BARR7VpoYRLC+nPDQR5mo2P0OwSKk0l6ByTy6caHW5X8Kuyf88kFE+vzCvX3ROHw3NYHkriT5ItUChQWBS5jTDW63ClDZ50mCi/ugtVWNhYO8Em0kF8cBvIordQnJlXLrxq0S58q4f4n3+iNsT503j7gYfg9DTdtoj+Bu4Q/jc8279l6SoTTEvTgysB/33AMuZZnwyhshToeOedzi2PbCfe769Lf25uOgYinI6bAWyruYFu2tRVjr3JEZYd8E22j968PxlNNPI6XRvgI78aU5njWd8dV4lfODqzEzLk3XvQNdr8YoDSkm4wOifSsDMSSMWqTCcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8868f20-420a-4229-4374-08ddcb8ce9ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 15:07:03.3475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3AcPCqC9X1IVNgB+hiH798YqhKjAw3y2hByjBLdrWU0iyjUZKUQ6kcVPrQR0yBBcGa6nz405KkHW0PFNqR5Z0iYwAUiBkwWI1rcOSQWeRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250129
X-Authority-Analysis: v=2.4 cv=ObmYDgTY c=1 sm=1 tr=0 ts=68839d9f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=w1FEf-arxsa2E4dfItQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12062
X-Proofpoint-GUID: puxLcztHPj0GPVANGAavU_vR99xyqzJ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEyOSBTYWx0ZWRfX7DdCD01JVP8Z
 /21XxXkrLxmwtzFZX4uVxdCxV9SODNKt6ep3+5jt4nRmJvmVSVop2ls1Qn+tIQE5C2JaE6hRp2s
 KAnorY03taq833c2El7uXgjjLKALe2K0Vyde0MNRuuZPaPxmu0cUbxHNvxIlU395RZicCOlo/9Q
 QcAjSpRu15IbAtZwTiutW9ZxnUOqu9TWyaNa06jYYRy9gRjJpr8pn8Q3Af9waR/2oleSrUIfQ2L
 lewvF7hiK7+hmd9RAEhMroSATZbjjaDP69ZIdmfMJAip9PoA5+lXE9eF+2NMR0Zo5wkjO8PCZso
 SK7/hctyJ7AGQAxAUe6GZ1KIeE35+T8N5jvBivdxzNzZa9hDt17lb2WE509G4svTNqn+1mre+ta
 +UMcadtmIurMiSu9WqZT6Skk1jjSrc1JpdMW4kJ6/NmfeQSTxnqU6Kn6POzYzoY/qWD4BdN+
X-Proofpoint-ORIG-GUID: puxLcztHPj0GPVANGAavU_vR99xyqzJ7

On Fri, Jul 25, 2025 at 04:48:09PM +0200, Jann Horn wrote:
> On Fri, Jul 25, 2025 at 3:49 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Fri, Jul 25, 2025 at 02:00:18PM +0200, Jann Horn wrote:
> > > An anon folio may outlive the VMAs it comes from, so it may also
> > > outlive its associated anon_vma.
> >
> > Yes, I will share some diagrams I did a while ago to outline this. They're
> > ASCII and make you want to cry! :)
> >
> > Hmm, if non-root, I wonder if we
>
> (looks like you stopped typing mid-sentence)

Yup,

>
> > > 2. Removing an anon folio mapping reduces the anon folio's mapcount
> > > before the VMA can go away.
> >
> > the anon folio's mapcount? You mean the VMA's? :P
>
> I mean folio_mapcount(folio), which reads folio->_mapcount and
> folio->_large_mapcount.

Yup sorry, brain fart.

>
> > > 4. If the anon-exclusive bit is set, the folio is only mapped in a
> > > single place (otherwise swapout+swapin could erroneously set
> > > RMAP_EXCLUSIVE, causing the swapped-in folio to be associated with the
> > > wrong anon_vma).
> >
> > I believe (David?) swapin can cause this not to be the case?
> >
> > > 5. When a VMA is associated with an anon_vma, it is always also
> > > associated with the corresponding root anon_vma (necessary because
> > > non-RMAP_EXCLUSIVE swapin falls back to associating the folio with the
> > > root anon_vma).
> >
> > OK but we know for sure the UAF is not on a root anon_vma so it's not some
> > weirdness with trying to access anon_vma->root
>
> Ah, right.
>
> > > 6. If two VMAs in the same process have the same ->anon_vma, their
> > > anonvma chains must be the same (otherwise VMA merging can break
> > > stuff).
> > >
> >
> > What do you mean the same?
> >
> > If you mean they both must have AVC's which ponit to the individual VMAs
> > and each point to the same anon_vma, yes.
>
> Yeah, that.
>
> > God simple isn't it? ;)
>
> Yeah, I prefer to think of this at the slightly higher abstraction
> layer of "which VMAs are tied to which anon_vmas via AVC" and "which
> VMAs use which anon_vmas as their primary anon_vma"; to me, AVCs being
> separate objects is a minor implementation detail caused by the kernel
> only using intrusive lists instead of the kinds of data structures
> that you'd use in almost any other environment.

To me (a simple man :) there's a many to many relationship so it makes
sense _on one level_ to have connecting AVC's.

I however feel like we can probably do better on the data structures here.

I alos think:

- The reuse logic can be improved
- The semantics or at least logic around logic can be improved


> (Like, you wouldn't need AVC objects if the references between VMAs
> and anon_vmas were formed with things like maple trees or xarrays, but
> I guess they wouldn't give you the interval tree semantics you want.)

Well, we'll see about that :)

>
> > I verified these numbers with drgn, interesting add a new child doesn't
> > increment refcount...
>
> Yeah - AFAIU a single reference is shared by all the VMAs that are
> tied to an anon_vma via AVC nodes, and a child anon_vma can't be
> associated with a VMA without its parent also being associated with
> the VMA...

You see this is also some of the complexity I dislike.

I think when you constrain yourself to the design currently existing, you
sort of necessarily need to add these things.

But a better thought out design might avoid them.

>
> > > > We're sort of relying on this
> > > >
> > > > a. being a UAF
> > > >
> > > > b. the thing we're UAF-ing not either corrupting this field or (if that
> > > >     memory is actually reused as an anon_vma - I'm not familiar with slab
> > > >     caches - so maybe it's quite likely - getting its refcount incremented.
> > >
> > > KASAN sees the memory read I'm doing with this atomic_read(), so in
> > > KASAN builds, if this is a UAF, it should trigger a KASAN splat
> > > (modulo KASAN limitations around when UAF can be detected). Basically,
> > > in KASAN builds, the actual explicit check I'm doing here is only
> > > relevant if the object has not yet been freed. That's why I wrote the
> > > comment "Part of the purpose of the atomic_read() is to make KASAN
> > > check that the anon_vma is still alive.".
> >
> > Hm, I'm confused, how can you detect a UAF if the object cannot yet be
> > freed? :P
> >
> > or would that be the case were it not an atomic_read()?
> >
> > I guess this permits this to be detected in a timely manner.
>
> If the anon_vma hasn't yet been freed, but its refcount is 0, then
> that's still a bug because we rely on the anon_vma to have a nonzero
> refcount as long as there are folios with a nonzero mapcount that are
> tied to it, and it is likely to allow UAF at a later point.

But how is this happening?

The only places where we might explicitly manipulate anon_vma->refcount
are:

- anon_vma_ctor() -> set to 0 on construction used by slab.
- folio_lock_anon_vma_read() / put_anon_vma() - both cases call
  __put_anon_vma() when 0 to free the anon_vma.

So how could we get to a refcount of 0 but the anon_vma still be hanging
around, except if it's freshly allocated?

It's surely only UAF?

