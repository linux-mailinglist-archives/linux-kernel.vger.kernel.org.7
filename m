Return-Path: <linux-kernel+bounces-761783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9555B1FE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1DA1897EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445C246787;
	Mon, 11 Aug 2025 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PWmvW0Ah";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vgb2kk/I"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405682E3718
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754888259; cv=fail; b=PrTDLkNssdSJzklUHDvEJiFRyAEvpmGhTRUo1ypF/ahf0c91zWiJpchS/nI8NnxwFIfQoco9cKvc/jwC25dCvRnw0onEZqucaRsQqGH5mSCUjZVfijg+P5O3R99Knru6+N0B755JjqogZmxmiFAlR7dKXrHH/Dqdn3Jvwxqs8mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754888259; c=relaxed/simple;
	bh=/rCSqTvpU2IOt57OaJN8O/jxpW/f95BgILRiZfSarYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YlSxz3zXmMERyUU37vjdGYDNmmqIN9BoEu7BfQT5wJ2Iy/Nu6VCQG0cAtMn2YGLoD4oLeqoMk0jxMhP983r/OM6OKeKNp9wv9CKHx0rZNX/K3MHOHg5qXMqEVbks9kWOAskTBsDcsmPvkrp5kb23WhyyGp6iYT03K2lngJqlwfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PWmvW0Ah; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vgb2kk/I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B3NlVT000737;
	Mon, 11 Aug 2025 04:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/rCSqTvpU2IOt57OaJN8O/jxpW/f95BgILRiZfSarYo=; b=
	PWmvW0Ahch8KQXHZ2mrRWyw/E4GJKEzdyn82K8cUk4wdMYbhX/ZRNEy/u6tGR6S6
	/31KgMUrhOfIHTug8qN5nLpkEkRGnfFbBw6rXOEG71UE+Sr/TnH8cePTOx5wJiNv
	9OYZqPS/2EWrZbOpUtcgrGGoppj7ihTczbPrGzjiIAv/oFLDia2pTYRphF4E7YlQ
	m3u/JbvsTTko0W8BVQCW0LSVQsLW9uSaOPbR65Ll4TXv/vpQSH4gNelZRlfcHti4
	bf3aOJUBW+9mW2nEYfV4YsXalTvYhxMnLv26JL1qj4q/Bpk9zoXEQY5t+WgiPHBB
	lxLB5m4t5rWyyQXKnMxauA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf1pad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 04:57:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B4BSxA017397;
	Mon, 11 Aug 2025 04:57:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs85p9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 04:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCTAYLPOnoc6Fu23y+NNutjoljMdHUP2GdSraGo4GnkJxSyZB9p/khVWao4jI57s3T+oL5A/E4JgROVTgVbrtkHLODPTegpICCnKoU2f0Ysazq6q/SqOXJZdF2Tswv5xTnOI5II+N/cnJ2LC48NV5XR/P8bRhuwk4WVxCt+gHCVmfsGoCV/W/VniCOZUjeGBeG+XgT6Xww59EZL3SPvabTNP+cVBKxE7acuU6NYduich/RC133IDMJsMRzkvAt4rdABSZpeeRNqF+2J6fn7+0VCdcM7mby7eWVs9KVaDt39XRJy4Yauk8dTMOcybYpxhMWGlXlcAxqTGdKJK5O3S9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rCSqTvpU2IOt57OaJN8O/jxpW/f95BgILRiZfSarYo=;
 b=oEkShB8MagKSz3l02+bGuSPH4Ri6m98minvWiGD1mE5UEJ7JdClWv8QRMHvheSLzZU6tP5BU5ZMscrfclxlWAHwYFJILJq78Ze65X0PSLmbyqypaJImYum87ysWJilBChg5384QePdNPsJrHh/+TanjO7yLCTEEXJBzajan+bFUJAuKqTq8CxpK/R7XRA9tceRKjVIgUpYmednCX7enFXajb7ujwK2Kp7+r9fDSshDHO/S1pZhJXwrZ8HDb6aNqqsCcLrXNEPDKTTdo2L2cX6KJwxj989lQA4LQA9fNpUFM4gjt552FSdo8DXrJITsB5VI5yDuDrx5jNWI2FnQhB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rCSqTvpU2IOt57OaJN8O/jxpW/f95BgILRiZfSarYo=;
 b=Vgb2kk/IWFeJW1rn9kOYgNV1Fu0vQRsonq8yJDHUSTmlvX56oTep4sgHBPrqW/XiQfvQmq8A4637yYAQwS0ge1LIGQWHzPkIr9gAP5sDRkivhi+vkP+qJkzYPKNuoI8WisJP0jpqMYx3eHJ4QkQdEfk4ksS/j/xngd8mN//ErSw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 04:57:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 04:57:16 +0000
Date: Mon, 11 Aug 2025 05:57:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Dev Jain <dev.jain@arm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
Message-ID: <47ce3db2-38ad-4a6b-917a-c6300fc39543@lucifer.local>
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <CAGsJ_4zuEcgg7U0yCMu6ayKqRPACtvuzUsC9vUxBk2PgMzaf_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zuEcgg7U0yCMu6ayKqRPACtvuzUsC9vUxBk2PgMzaf_Q@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0032.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::6)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c35734e-5dd5-4120-c19e-08ddd8938afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGpUMWg3YnRLcUVmSHFCUjV4a09Gb3A4Zy81dHpQUFBaNHhGSjlkODNOR2pr?=
 =?utf-8?B?cnhPK2hkSDVtdFBtVm5IYURScm92SW9wRVh1eWU2VnJveGk0R1lPdFlhdzJo?=
 =?utf-8?B?T3pINDRKM3dkOTZ3YnFDcXhib2NsMG9aKzBtZU1yQlFaSG1kK3ROdER5bjg5?=
 =?utf-8?B?MVI3SkxpT056TmV0UHdNaVJ4Q0NHQU1OK05DMG1jNXQ0aTZLamdhcktSS3NI?=
 =?utf-8?B?Q3BrSFpHdENLeUU4UGZ4TFIxalZLbWY3dTI2R20vaW5CWTFHV2RwaDdQaHdj?=
 =?utf-8?B?MjZzdHMva3JrRk8wTTRHVjhjM1BkcktsMUp2Z210YXlVTVoxYnVRb1lLSUs2?=
 =?utf-8?B?bUNQaU1EM0tUYjQ0ck1hejMwOEZDU3VZUDJpVW96YWNNZzBVOHArZ0lrM1Bw?=
 =?utf-8?B?SnA0ODFWTTFuVkJxVmtLZk1IczU4UXhRbXpiR2pXV21adzZ6M1N6ODdoYmp0?=
 =?utf-8?B?TUZLbFpuMjhNZW9HZWdzYWNkbFBPZFBBZW5nM0t2bjl6dXQyODY3Rmh6bks4?=
 =?utf-8?B?RTgzYU5Jc2RXSmNpenpYWFhVMlY0cXlxWVpHLzF5b2R3MmFaNFF0UlVOeTlq?=
 =?utf-8?B?bEpDSTcvRjE5NWlWZFUzOFk4SnRWMFcwSzEzOTlGUy8vZVNjQ2JCSExFR2Fq?=
 =?utf-8?B?NkphQ1VHUzlhVmdJYm9vWTRDMWprY2QvcXAwYnc3S1lOTUFsM1IzTXB4Sllv?=
 =?utf-8?B?c0E0OWt3ZjkyY3o1THNSYThpYVdNN2tkZVJsRzFhVDQ1c255WFN2eTl3TUR2?=
 =?utf-8?B?K21iZ1ZzTEdDcVZwVmsxZVg0aWwxMzl4RUhJMUwzc05nKzdiK0htZ29rS1VP?=
 =?utf-8?B?ejhiVDUvZFZ6cHhlUGl2YTFQa3poTFZwazBLMnh4WXFIbDFIRzhjNmFML0tx?=
 =?utf-8?B?WEdGSUdkRGwxS1Z5N1J3ODdjQjBaTW1KS0pJczBRNVpqSGFEUVdSbTJqcHA5?=
 =?utf-8?B?dFo3VWNVQkxqNkphNkk3dTBESHQ1V0Qrb3hLZm1yMzNpN1Fxb3FGb3IvUU9B?=
 =?utf-8?B?UTgzVklUNXlCK2hVOEpOQ0lBRHpuU1FMZUxLVzFIcGgyaHBZT2hISDErSDNJ?=
 =?utf-8?B?WWQ0S0xFSWN0Q1d0cnUyaTkrZno5TVlkZ2NxMlQzb2F4d0MvS2NUTzZLcHp1?=
 =?utf-8?B?cm1QRzJ0SHh4R2RsQi8yU25YU1h0S3JkTTVtZ1lrbzNUbk82MnNkdnpJZmFI?=
 =?utf-8?B?Q3IrVE83aGlxKzdZeFAzY1BkRzFGY1h1REJTV2Zra0FmeUx5cXFsa0tXUmV2?=
 =?utf-8?B?dnRpMXdLRlZMalN3WVYrdHZ3c1EyNjFVcTlVeURVSHdWcWY0dkdEd0lWUnZ3?=
 =?utf-8?B?ZE5QTXROKzJyd1dqQ1hHTVRZL2dYNjJ5bkdWd1hwVi8zbjFZaFRFZXNtKzMv?=
 =?utf-8?B?M2RRSVF4TEV1cldZQWlIVmNTbjd3aXFjd1ZPNVFjSFhMMXJiL2ljYVlpWjBY?=
 =?utf-8?B?amk0UzMzY2tZY2VvNTZaWnZxV2dob2RCZGRmZ2dYamFYckFWbkRMcG52eWUz?=
 =?utf-8?B?Zno5eUxkN1BjalpTQ1F5ZnlYVnVEcnUvTEJLbHhVUDRrM0FQNlpwbWV1VnVp?=
 =?utf-8?B?ZTN6d0l5RVlCaEhlLzJGT2gzRnFmZi9qdDR0eVhla3ZVVDJTTFhQU3hDUmtF?=
 =?utf-8?B?eXljblJOTlU0RjFYcWM4L1A0WWNrRVZEeitOSGlQamhWRjIvaTlqNUlvRThZ?=
 =?utf-8?B?VzIzQzRGUk9tTEJYMGtQUjkrWHR0NmpNaEJpdVp4N0d1TVY0dHhEUHBlZFpZ?=
 =?utf-8?B?bVhqTTdPOWpHSmtFZUxLQWJDQ1UySnIzUWJRWElVNWhhc2VuTmJaRVlQa2to?=
 =?utf-8?B?T1IyenRGZGVWcGV2QVR6MjdENXVjNWlzMzZ5elVBVU1UdVJpMGYzU0QxQjV0?=
 =?utf-8?B?Y2VHYlgyUU5BNEc4bFJJQ3hGbHlNTkVMRkNlNmdYRW9iM3NtVW1EQ3pBN0lT?=
 =?utf-8?Q?kLzrnRdbTUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzkvbnFWbXdKdFB1dXNIMzFza0tySWRpSGxveWZQRHZ2L2IxWlRzZTM0cmMr?=
 =?utf-8?B?S0JraTdDS25hRVVZdFFGakhvMCtYNzBjM2ZGWEVTdllwODFIeEp3WDlPY1Yx?=
 =?utf-8?B?L1R5ZXFLVW9BRGthbk42dDhkaE5QUHlCVFhLaXRQQ3FJMy8zNEg0Z3pRSUlZ?=
 =?utf-8?B?TkRQUGZ5RHlOWmVlUHF0L3Y5d20zWWZ1WDBRQ29tYnRva2RmcUR4N0tuMXNU?=
 =?utf-8?B?b0V6dDJ1QUZvbHhRaGxuM3M4ZVZYMkZvZW8xeklvL3M3QkRHZS9ZNW85TG9n?=
 =?utf-8?B?a0pFRFIzR0N3VWxmaHEwZ1BLTlkyOXI1OFR4eE5yUjBsMm4reGU4VmJoTE11?=
 =?utf-8?B?ZXNGbFZVWEpzY2JGS1d3MFdma0IxUEwxanNjREx0eWhwMm1NemdkcXNWeEFi?=
 =?utf-8?B?SjVNckFTRE9pdGZZRFJYQ0tuL3VldndDTFNsODFmRTZEQXVtYm9tWVlXVjNU?=
 =?utf-8?B?TEI1dzNFcnNlcTVqR3pFUlFFK2xHNVlqSE4rVEZ6b2krU1c0MzJ3NXpKd1Vv?=
 =?utf-8?B?UXVtSVVUS2Npd0F4Skx4Rno1ZGRadmpUWm1NekNGUHE2V2w4ZjBobkNBQzdT?=
 =?utf-8?B?NDA0M1dSb1pNVmhiRTBFMGFxQ2FxWnVwVUVmdEgya3VKVHREZWQ2Z1BRUzF4?=
 =?utf-8?B?K0xqbEFPL213cjBoWFl2NXdLeEJYdllHLzZHOXJwQXNVWHhMdTI1OTI1d2Jz?=
 =?utf-8?B?MmpTMUhGZGd2YlJPYlQ0U2F2b0NSTkR1ZURzRnovSW1sMHdCU0lvL1Z6ZmhR?=
 =?utf-8?B?L3lNOTB3Wnk1aStjdytWYVJ0YVVrUDlnMUZ1Qjk3cU4yTG9DRVJQRW9FZXly?=
 =?utf-8?B?Yk9peGcwdHlybXJ5T1k2TkJXVmUvUmZHN0w3elZqUXRydDJuL0ZtSHJ1dkFx?=
 =?utf-8?B?YlhJZENtQ3c1dkN5eVk5Umc0SjJ5K1RmOUtWekZJQnVMT2lDUmNRNjVEU1RV?=
 =?utf-8?B?dExyQkMxeWRsU1NjVmV0eUJ5YnBWYVlqZWJxSGlENjIySnJkMkYrbnpZTEw1?=
 =?utf-8?B?YkEyLzk0T1RhaGpLRUtIejlaTDJXU0FkZXdLVnRoVXNtTGNsdm9rNlVVZy8w?=
 =?utf-8?B?R1YrTzc5akU2MWltN1ZKL3RMNno0VW94bU5XOG01K09raC9oWTVPdm9uN2g1?=
 =?utf-8?B?dS96UVlPNEEzZ1RObFFWL0R3OGZxN0hOeE14amFyWEZpUGFickR2K3ZvdVoz?=
 =?utf-8?B?RTIxSGMyLzJDSkdFeGhLWTlOWWRDdDgxNHptcHEveEt1bzl0U3BzRDBhUXFu?=
 =?utf-8?B?bEtqb3pqTzZMZVl2SDhoeHRFTXVvN01FRjdKUFhlbDROK1AveXRuQ1lSL2NG?=
 =?utf-8?B?RDU3SjF4Q3VnSUp4L1VMa2FjeUk1VUJrZEJGZ2hTSW91MGtOdTBsN3pVTDg5?=
 =?utf-8?B?WmpJdFEzOEdpL1dPR0V1WGF2c0JCalF1NzY1ajU5NXZCL2dGV01zdXpzcjNL?=
 =?utf-8?B?R2E2dXJvOVBndWV1cm5nMzd1Q3ZGd2hqMDFYYnZZaDI2YU5rYjRPdlpjM2ZT?=
 =?utf-8?B?MlRFd1dOdG9hanVhZy8xa1RXUG82bFZiSk5OdnIxK3ErN0czZXJ6eTFtZ0cx?=
 =?utf-8?B?TGp3L0VVSnVFK052S2lvN2dKS0FYK1ordHptUjI1UWFMREV1YkxPbWh5aFd1?=
 =?utf-8?B?UmRXNURxUVhrR0h5VVpvemlYMlI2NU40OXBGaWpEV3lCb1hxazhyZXV6bHZU?=
 =?utf-8?B?bk0xVUlWMEwvRmpBNTl6UlViZ0VSL0ZtOUF6WEkxQms1T250SnhIZnFVVmR5?=
 =?utf-8?B?ODdKa0RqdmZFY2dkMUJIZDJNQ2JGM05hYkNTKzVKOWxOdkw0VTYvVUJCUFlU?=
 =?utf-8?B?alVGRFM3WHRqaTg2ZXdGNklZTU5veGF4cDJ2SUkxVSt5RlRHc05sa28xTWlJ?=
 =?utf-8?B?UEJ6WWg1MDhXS1YwSUhoQmoybm04MUNCQjFmcGdBdWhwMXUwUG0yVHQ5clpv?=
 =?utf-8?B?amg5SVZWUFQrcjU0MlRiZE50VkIyYnk0QVJqRmNtY2k4RHVxMUtkTmFMc0Ny?=
 =?utf-8?B?cE1DWUV5SThGYmdvRjVIL1NLREFiR0xyeUQwQWwxeGFCWnJrRFduaUlCait4?=
 =?utf-8?B?NmwySXhzZVczTkZVdGVjVXZ0a0FHeUlhdWM3RzQzbk5ZUzc0Z0ptT3dieVdD?=
 =?utf-8?B?dWpKNHl4UjMrbVZQNmwyeHlDK1phajRJTkpVYlBpVlQ0WUdwNHBGSjVqZk5s?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6NpGW5DrRWwfHtvEwXV31nNXQgblnnOEULrW6UNr2U5GCWqzndOPs4aNXwVSk2XTFIuS3hHRJ4SZXllUdeyicopsBfokjZPp+cYnU72FvCKa6r25X7pp1LhtHVzjABmTvZyDrGzXASehl2Iy/fVEbeeZhj8AGG6Hab1wFgFsNd0wjTb/zgRzRR3o75Ce6SIcDtAHu1XHmSbNizPXytI4hkjkarhJ9wxNWo+jqN+ZlXds0sTa9RvvdO8FF5voJWtkTF8IHcz+7eZGoXWy7jia60nBBdi4wNumyR4QGtr3lv2xueLy0lFkm+xTj95sUY131SlMom86y7P6qe+vhNDakSKbUDg/DLm3zXpZImxbApLXaFzpvgIOjoEti+U7AhTYPG5sxZGIGZdxQM15Vwr54b3K9f+HCtsZYZSFBGqR6UPdiFUuA3HboRkACE90fIQlUe48dYL9PmQsOLMFBOA5o9qRAdpyMEgVQLJwk3FCRjd+P/pt73Vzm9Mq4AeRTup8padov1qyMMVwaLYmTW2wG4Z2PweN7os3K0bngb+jL/QGcb0r3tVzZRNhiM50Z+iq7h2IUQ5EonMFv2lwJcwzlFUqaOc2VDIbZ+706LUR1o4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c35734e-5dd5-4120-c19e-08ddd8938afd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 04:57:16.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6yGcfmoYDy0zO/BIAGr/p5uLA1rvaFhmUPp+0H1U8VmW95hMFi3pPnY1O4/E3t1Qoa72grIq+36yAWnGD/D/6t6xXfbz8a99PZpi4TUR7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110030
X-Proofpoint-GUID: fROm3LbSFOtG46rODBQ2-NorsEZpkG_s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDAzMCBTYWx0ZWRfX/L3dt29bNYZG
 vADeUe0AkOXAcehSWm/QvQ/bCbT1pGMELHEp0EZMQuTh6zhqbb0s5yRjmCo1NKh9R9QoqTeEq2c
 5EpYqZv1J0g/e945HEd2wLdX4u5YrCDgDj5sRKo+/iObej2GxhlxiluYC5XhMLAPJlYB9X//qdz
 4c6UtOac2eK4hjLWLzK+K/0lXa3CzVa9HymBl6G+cVrc17gzJPoYaFWdeUtZm6s5JF86QUkbRlB
 H+J5et2LE7N9ZIhiZZRn5a53U3cUpaPUCBod83bnykqol6/2d77qWLJifErXADr226tJicqdqmk
 VsJz0xnV3MKrtrIhYw/jXnki71MH3x46Fz8AGGC+5bp+JcOGgpn/AGcyg+Cspho/6FPtvF2RDqI
 mGwyIVL6Sgdey/HaSuiwKxFkfLVUWqRkqnWdZDWWmIJb2wyaZ8UM194XZVSzoBq+2NVLoT2F
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=68997830 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=DAnksgEPBVAUswvTaG8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fROm3LbSFOtG46rODBQ2-NorsEZpkG_s

On Mon, Aug 11, 2025 at 10:40:50AM +0800, Barry Song wrote:
> On Fri, Aug 8, 2025 at 2:59 AM Lorenzo Stoakes
> > The expectation by those discussing this from the start was that
> > vm_normal_folio() (invoked by mremap_folio_pte_batch()) would likely be the
> > culprit due to having to retrieve memory from the vmemmap (which mremap()
> > page table moves does not otherwise do, meaning this is inevitably cold
> > memory).
>
> If vm_normal_folio() is so expensive, does that mean it negates the
> benefits that commit f822a9a81a31 (“mm: optimize mremap() by PTE
> batching”) was originally intended to achieve through PTE batching?

Not for arm64 apparently. And the hint check introduces here should avoid
regressions even there when small folios are in place.

In similar series to these in other areas, it appears we need the folio
anyway so there is no additional overhead to deal with, in mremap() you'd
otherwise just be looking at page tables which makes so this egregious
here.

> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202508071609.4e743d7c-lkp@intel.com
> > Fixes: f822a9a81a31 ("mm: optimize mremap() by PTE batching")
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Barry Song <baohua@kernel.org>

Thanks!

