Return-Path: <linux-kernel+bounces-759245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F7CB1DAE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1431885099
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197D326A08D;
	Thu,  7 Aug 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qH9wkTvG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UhN7phJ+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81825EF87
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581204; cv=fail; b=hkRP8rDfyDtzi8IYYMUTZZxBGM0P9W2xC1/SPzr1rt6K/fdzaOgTIhWgntRAza5K9xrtIEBoWViXnyksMZKehBAiJaJ2x8RpVXcnhClaEdYv9RNgGS8yTdrt1mUe96CWRaOquJr3qA6LudvS+0sSmPh0lQHsuVCIskMjipPLaN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581204; c=relaxed/simple;
	bh=lgnU5ULWb5RPDo/S6/BXemy8ZwSmoFu0GRO7LJ2su1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HyBOptvAR/avATKk73h5NoBrcJp/MX1VTRq13BiZ2yIQfcWUxjTRwC/FcJyi3UmtbRYb6V40L/eME7ReMEdGUlN5jOfLkrwQ8vNqwFUAzFopOeIvPPnGEz6ERNzUpH37o/vesVZ09qXNXIGagng9W0sGz3G9M25yi07tvMpIrRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qH9wkTvG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UhN7phJ+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577F1hTr011028;
	Thu, 7 Aug 2025 15:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zUAC6r9sqT//Ms9ri5
	lXWph1hXsaBpoZIAPMnUTD0UQ=; b=qH9wkTvGZNTQQBBlUOXL9LKR/gZCp4iUv3
	l3fw+DW69NnrbXR3astpXIuF9EMnOkWp9bWmzeKwVdiXBr1y0PaZX3Lqv0gRA/92
	hyaVmfnar8isLd4R9cf72SF6OZSmn0SXldn8hW5oESurJnJDpE7MU+Lduk2SB5tT
	LhVIMGyjijAQiNpofzVUt2VsJm07NMGlMKp2c3icUq+uR5aYO2+uLDtqjYGpgiTE
	+7SXsSkC4F/w23HieC8PoPe0irTdTMpeiQH82P58T6905uFNIBWAFvm8+Fn4YFPp
	bC8KIKlCE5YisPtBo5cyo/qE9Eh5fWocp6wo6iPFnd7cwBb1V7Rw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvg4e0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 15:39:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577EovjB005661;
	Thu, 7 Aug 2025 15:39:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwym6q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 15:39:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf9nesc3PSLpsWXzviiPOpm5ss8dFnuJ9dSE+RSXCfK1Z3m6ZSDnkjh+LBiLsHyoefYDkFPH3H/u7xUpe2jIh/pmAYTgfCT3EXbg70ZIp8iUG95oKbG1rztmlIB2//aLEA3uyJcFuoow+7ZyFNEaigC5Er0WOxFR/GZVvTu3gbNjtPNbBcBmQWLn6FRY6j6m10ET0YdLIurkq1vcNXikRC3905pHCJv+5HdvzSp8gI2mTvtrtvcqAQOEz+B+yAEId+eLLgXSh2K2XSssNFChrF/dBimmydiyBuaPUot6ahBeQ7NmTuuLxtnyAReiR8KvtOiNrd4El4Nmdia7G3qrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUAC6r9sqT//Ms9ri5lXWph1hXsaBpoZIAPMnUTD0UQ=;
 b=ej3CxT9g0miNEaNaoaPvBGUzCea9tvFtlzQzR7kLzt0qzqMiJ6gw04BhHY1bat220w2msl/CJxZd0RP1laR8y3lD+vm2+ikuD1eD/gvl+rrGP8u8qeIKWNBBMnpUJxZ5cZFyW2sOt92py18fgxaBRHDkgx73TwAJeG4PhwzUlCBZBXvAQEUwqg3a/geWlnzOwk8MgZIdBFpm/mcQ/BsiwfJPXJJ6pPRsMo6YYgCobTv+b0Q0J7VI0oI4oA0HoSwFoZsAn0mmf3rACYPgXFHmLXgNe9jUcRZCjD6n0PkIOtDS/+eVmJ4daQtGpsTBQNnCLeybQS+O+r+I+q7GITxLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUAC6r9sqT//Ms9ri5lXWph1hXsaBpoZIAPMnUTD0UQ=;
 b=UhN7phJ+vngRe0eOdX1NSW9YtNBjWmT8n6yJhYaWRO3H6IQuylasWJADshDijXx92pIJz+ezcfMwSR7M555bSFZHs43ZfoOuiRBIjcCdqRUd6idHO1/Fo9nyEAWVLoTQWrMlGklyZVvGGiSQxcIGd7BhhIhp5GVuyRfCz7tTWf0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4316.namprd10.prod.outlook.com (2603:10b6:5:21d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 7 Aug
 2025 15:39:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 15:39:44 +0000
Date: Thu, 7 Aug 2025 16:39:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch 0/6] perf: Convert mmap() related reference counts to
 refcount_t
Message-ID: <606fe227-8500-479f-a753-5cc7504c0c3c@lucifer.local>
References: <20250806195624.880096284@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806195624.880096284@linutronix.de>
X-ClientProxiedBy: LO2P265CA0473.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 624c7b3d-d5c7-4640-7049-08ddd5c8a1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xND/+467xBHFeKjRszPtrSPxQVDoRMX8/NHWB+gUV5QrtafuNCw5G+ieSRbu?=
 =?us-ascii?Q?+0c47SuRzNmLlzhxo02XaUZLuugsfVWayUHzSx6IrpSDsFPUtu7IC3T82Qol?=
 =?us-ascii?Q?So4YxU1EqcqePesz8073qQ/ZPgk8RHuWKWjjKmD6U6qPwXxVHBNtXpf4KBMV?=
 =?us-ascii?Q?5TVMLuCNAdpGJFBwOmdNb5MS82IQGeLBQDevawul+YQCfOi2uATfggtV+KIw?=
 =?us-ascii?Q?ur1LBh7+mAU+yGqmKMiKd85QR0YzquUiN8/deaXy3wzXzXwnoyaHKcupKDoW?=
 =?us-ascii?Q?dx5IDyZVEihiOsRvs0ASyjyZatd39z+vQyv9KGrbIwc0mK0VPz94oDRPsIbk?=
 =?us-ascii?Q?VG3YLvH6CQZiFqWTljT13K6TeGFcQj76pHGspF1HoFXGBGyzUAQD0VIXxC8w?=
 =?us-ascii?Q?ZIwYa8/ZjCWQIBA0DxregB8xkm+XklanMRD3mvlwKCdW/hC7QbeH3ZRlCUSv?=
 =?us-ascii?Q?Z+We9uGJnupeGhHLI03DxCSEaSsC4k90WgDSvRKbOpujLf0lVMneGXO7wDr7?=
 =?us-ascii?Q?H478vt9MEYATWeNCyB8eG4/uyIdXPtOlqrv+Xks033nxyNr9yX8+bzmi/5u0?=
 =?us-ascii?Q?myYGUtxRkYEjM0U84s/t8HhLeJ+fWEIbMktoRq3C+u7pGetB3E+WmGDQfC3J?=
 =?us-ascii?Q?9VQV6seE6/XWuyVaD38V1C4vQzvz13JES4F9UniNuDSZ2m0LPY55m2xXDhId?=
 =?us-ascii?Q?vcVZ5mTMf0nqRlaucqWsXtJeLg2ntH4Zw8ZvRayehs0l6xn6MFtyzUwKKpVJ?=
 =?us-ascii?Q?94tNU2U5KOGq+YFOWEtLeTffAJMyrz2dbkKZE9zfmUJYfuB4Mygja9G/bG9K?=
 =?us-ascii?Q?P9lhAGC0RtGFIrDRur2X/pb2P4nZVhXhjuIAjVWOkduE0k+xClc8D0cs+5TQ?=
 =?us-ascii?Q?8OEFrgC3VpMy/lkiac/YL7drJkLu1HOH/ZX2GhSU7uYi2Pz72LU7baWDATgr?=
 =?us-ascii?Q?Iv8JgdQRpbYfzzK/a8AdL5spLuCzcJhepVawDjIZp/qcsrd7JU1hjstxro66?=
 =?us-ascii?Q?uIJyEUHL/7Bz114j7fefH53Gv+nIFHLppF4jBZHDQz1KHg2ZALqm22BQ81Iv?=
 =?us-ascii?Q?yYq1E5pVs+JPWgKZGLs2SgvX1VqSDY+d1BmreGje4LGlnaUiRG8t3wwXOnQT?=
 =?us-ascii?Q?Aq/p7McLxWJxBclXJWIN13rb3ZUWrPpFZF+vdcxMB0s6cEYKv+2pJ/mu+jxB?=
 =?us-ascii?Q?99+jdQhct0saTnWRQyfFvMti0dNvGSO55WVGULGqoMS6L/7Iv9ANK0nbyCIS?=
 =?us-ascii?Q?/g7F3kex/7uuMqH68rjWJCGPBkbtfOxnTFN7ZE7wiT5kGWkryHc+3F5hHjxc?=
 =?us-ascii?Q?rs0esjCBcNTF0q5e3znYoxNOcm4h4jMDaoDfPLw5hheLTWjL7lJoA9qNN132?=
 =?us-ascii?Q?TyMVo67u764uspmpvrmDbe7fqNat1C5IY8k5U+UjEuYGviacA21E6o9RNO0H?=
 =?us-ascii?Q?CA+IDhj7oy4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1eckIlb51s3R75VkNHJCgW27vgk1ejm9qKhFw7gKndd4pUeYPSxHS02WKLwh?=
 =?us-ascii?Q?qSZFpQ6uzqUTdot4Ln5iZR5CYpHbO49EisvksqTO7ET1CUwA3PFdGOkqctKg?=
 =?us-ascii?Q?7umcq/6Kf+OLjnvmMFSyHcqmecU+Ey4+6EHdwlH191b6DfMAR9rFOUhbB09M?=
 =?us-ascii?Q?zlPEJ92AaRyWkGYsbjjOA529KBT1iUA3+AK9/MhG2Z4GqID2jRNbAATU5OP/?=
 =?us-ascii?Q?6AWneaqLaHzLlGD4eOQ3gMrBWd58sPtMb5B4MrqzsoN28qoD20ElCYtHcdqU?=
 =?us-ascii?Q?0DFXoyfdI7WzSj4tDnv5pNCj8dc3ReCZ501qVO25zxvRjM1ixj6wnoDvjJLd?=
 =?us-ascii?Q?Ucuau3GkEEJxRzEvR/axy/Dk2AVuWTXD7Dk6AwggYtA3X3BNO2/jESgceurc?=
 =?us-ascii?Q?eE42SElu2iYv9whH9EEvAkFDWzem3O9FA6Y+zdxO3BRjWOuQtuFiMh5QKPKE?=
 =?us-ascii?Q?dp8BCWimItepwbGLDbVyLEDTEqPJjjA3xhNC2jnsmW0cEkCGxrK/xd2Pnjjd?=
 =?us-ascii?Q?uSw+LbGjw9+3an5FVpZovM8wP2eOIuIqldyGs14pGUSp8wj+8ZutUg9B24B+?=
 =?us-ascii?Q?tWcX6WkiA+w+Lq3uvkJC6dLNjiGYk6zhLN5pDEJv0TAa/g7hEbgetD3P4VkI?=
 =?us-ascii?Q?nKsrFhtD0jBSQ3sPuBGP2tDlZAJAXb6odhs/KBISxiNYmVoLm+5CWd8WkCku?=
 =?us-ascii?Q?TBHnyn/TnQTn8PdEKkoFTCF4vPP4agLDDOJCjDqKEv3JNHnbTc0TAE5FnRzO?=
 =?us-ascii?Q?YDN6JvJZT8b1L4RTHN3BJDAROaxWQvRxWI8DFooT8JwQHV910dWm2jAlIvz1?=
 =?us-ascii?Q?ZQJdectQRT/4vKHMVsZOfibOicpGgOnUysaaN7XIYxbQ1594OkJEUwWZvUAq?=
 =?us-ascii?Q?AE/psJ4Rhhrj7KDrneCsOpbHcnww7xjgCVkhg+s7H5Qpot1/jJf0+hPBgKbh?=
 =?us-ascii?Q?BsBd2tC/W4lpaUV6wAgaI3ERow8z9NrruK+a5vcXLZZ9+1854yDr2lMB6bVj?=
 =?us-ascii?Q?vKvsBGZnWOUJKw4g7KwNjPGkfyW0tsqeUrshs1CkkN78cbPXsVnbnbnTsXXV?=
 =?us-ascii?Q?6CthxG4EuhV62S31I/rvpgY/HlpYydIGpoN7Nsv3sFdM4YnIsOkA35pKHcD8?=
 =?us-ascii?Q?fTvRy7+bvnQN1Cl1RAZfsR5wCqvQcMYVzII5ASR75zU4lkUSw1dXm4XSjCru?=
 =?us-ascii?Q?2iX5hjhu7eH2ORDARy44s9y5Y3u206utgiKFt1CBtplYfkwWymhLDt/fozOp?=
 =?us-ascii?Q?6MGOmR1kNQyTBRGV0RLq6eR/PPLR9dJ+KVEKVhxKKFHjD6vusNRSVGZSzNlH?=
 =?us-ascii?Q?VsjPMBdLS4iSnUmfuYDSf7fy3/9UjCOgNikYFtAWY9iqQMpsNyoKtr2VH/in?=
 =?us-ascii?Q?27qRRmxa5Vh08JQOXqdbnL6whl+KCB0+cYryR4pOndVDzo9jLkeReYsZ2lFr?=
 =?us-ascii?Q?o0FqTG7HxL39W8NhRZBRzyU7Xgfn2WtRzQRBJ0pDn7PdNd8gr5JZdxVl9s90?=
 =?us-ascii?Q?ZDnrK0h/qPZwlaQqDeodItWCRnvdz0/EDOirnZDhlm9pjpHy/vpEsxKX4D15?=
 =?us-ascii?Q?E9ypD4HPJnvaTg1112E+tDw/HO2vlUhdb7Uh2f1TVIu9+XhIc8JEw6BgjJ/W?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jn20sKSpQV7jfE363pPt4Xp4WK+c+mI2KH2ceWK4B50jLUbpv478nEcZTOPkHuu20kMK4NJUKNzOFwLMFMIY+qPhwyaOyEDS1fK1V7LXcIv7pPxuKpAOEpL8oZEw6e2oXXFRRu7iImwOlnYeq4UvXwd2LOBkkKCoHp9Gy3+uxT0GwEOzgvjqBzUmsdySfaUwNaQz6hONTJeKx84TMZP/4aDZiAvIAjezpDx/gax+Hn083GxfhOVZpmCVirGa3iFJjBFKsvpu4zlT2JExCXD5qMNRBoa2DxIZ4iZnz8VolIoNcuIf/GmKD+mG6wIIQqP8diT0SXbkU9kqnJj8XVYFZUdG6G90bhH1ySZ2gqXtCsfTD8v5Xv6voRfdStW1pizstaC7MjyKmy1s6+y0P62oOj5kCLurwL9aGd0zNesAHCMlUP26WcJFWQRrZRyBOWroh4NqCVrwuogJuonGMn8lu1TDVpWe9yDU675Y1SmcFXjZi2YVmwIxRdP/GxEnqTqzmpvjU8zZWTKeojBrE9WKCqmbiCI1Tdjszmq5uePyjXPkEv7oKxOpBT6vzr9KvilIBcFooW8LgJiHbXKRu5qwFf/vQWUlrocpj7ev87ZlsM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624c7b3d-d5c7-4640-7049-08ddd5c8a1e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 15:39:44.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hubFqHDnmKl3r0iGC2GF3eNlSgXLWyuRZh3GihEsX1Nujbl0HqXhQ2S/piIVxrm/hM5OLrsp/AK+T+9fMlC5KAKENbipvE2Se+ep1FKOsTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070127
X-Proofpoint-ORIG-GUID: CUjFeLxIifya7ZuJvfPGKMFf60ulBAG7
X-Proofpoint-GUID: CUjFeLxIifya7ZuJvfPGKMFf60ulBAG7
X-Authority-Analysis: v=2.4 cv=QORoRhLL c=1 sm=1 tr=0 ts=6894c8c3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=nSLcMuwPj4R4G31i1eMA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEyNiBTYWx0ZWRfX4+O29DAGgYyx
 k9K1CRlGERhU8pmq31bcIfHK/TL0VdpNVdeY5LUEj8V8RayDvzBdO7pQ9nKyvJuZi1ms9BjT0nL
 YzpwXTLqY9JnItHH6HYbez2OlER3LC6/EGVusArSx+MTrllp2+3pcPJ2JREAu84BxAOz4vfVYko
 GdRZ8U1VUczRWVhkOX8bGAHywllsUzYIeiN6BP/VlaifdRXapOuaIQH10O6amCGN2MRG6USGtRg
 Sy0QpGiUDnZVHyaed1EB1EjBbWtVgSpicL1ydhjj1ZJn4++Xuzl8QdnuitL0UvO6WSCyBatFxKR
 u6a6WR7n1MBV+FHTsy9uz7KDjYRREvp61h8r1r8JcF/KxTO09pa3p+HZEi3vfboZQqNlgkCiS3C
 rSFRxn52vbntPEUuKEWhQbzZmYai6ucPiZQjr/wUk2yldXZnMLpZdHgBerqQgaSk9wafEx6R

On Wed, Aug 06, 2025 at 10:12:52PM +0200, Thomas Gleixner wrote:
> The recently fixed reference count leaks could have been detected by using
> refcount_t and refcount_t would have mitigated the potential overflow at
> least.
>
> It turned out that converting the code as is does not work as the
> allocation code ends up doing a refcount_inc() for the first allocation,
> which causes refcount_t sanity checks to emit a UAF warning.
>
> The reason is that the code is sharing functionality at the wrong level and
> ends up being overly complicated for no reason. That's what inevitable led
> to the refcount leak problems.
>
> Address this by splitting the ringbuffer and the AUX buffer mapping and
> allocation parts out into seperate functions, which handle the reference
> counts in a sane way.
>
> That not only simplifies the code and makes it halfways comprehensible, but
> also allows to convert the mmap() related reference counts to refcount_t.
>
> It survives lightweight testing with perf and passes the perf/mmap
> selftest.
>
> The series applies on top of Linus tree and is also available from git:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git perf/refcounts
>
> Thanks,
>
> 	tglx
> ---
>  include/linux/perf_event.h  |    2
>  kernel/events/core.c        |  361 ++++++++++++++++++++++----------------------
>  kernel/events/internal.h    |    4
>  kernel/events/ring_buffer.c |    2
>  4 files changed, 185 insertions(+), 184 deletions(-)

Found what appear to be a couple of bugs in 4/6, will pause review until
addressed as it seems that one patch fundamentally relies on the former,
etc. etc. and fixes will likely shuffle.

Will resume checks on respin/you indicate that my review has a mistake in it :)

Cheers, Lorenzo

