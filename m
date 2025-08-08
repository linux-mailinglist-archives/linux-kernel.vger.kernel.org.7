Return-Path: <linux-kernel+bounces-760391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C0AB1EA96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BDC176EE1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04EE27E05F;
	Fri,  8 Aug 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XuFknpES";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LcxQlkgk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398619007D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664396; cv=fail; b=u+TJxhGqBnIe+2qF87Y34v8LCI2CvTOlJm74avG1XJepXtpVQCn8Hj3JJ3i84ZgeawMAm3TmBF9jSAhTJ+sC2t6rjzR73PvokbzBa4ZhTMuNqlx6DxJ7nifAgSeDttIhhDlTyycch5GDBy7vP0NdtIkX235tAdmfv/I7+xB8K1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664396; c=relaxed/simple;
	bh=FqTnyDCy0aitHB7aiK7LSPJ12O4cytpIi7v+mH+m3Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i5O87DlPrpP2m20uvb9oHMkdSStD8kgi+y1R84HuY+SRNBesxIY18rx6V9yhgq5E1FcJmETwLoh7qct4NQ/d55H8T4oG7V2KloBJ5g7pC8tcM27ABL5UkYy/sknyTq51YJkKrk72X3/vvja7LKPHGdnNBN/6tBJn/cVTgP2mc5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XuFknpES; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LcxQlkgk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DNPpJ028675;
	Fri, 8 Aug 2025 14:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Qu+M5KRPPtzdMJF//t
	AdHvkKC6YaE7z1ATl6HXsrIYw=; b=XuFknpES77lAY4iADDw3649UFlEYUJwVto
	1GKfpWMFfL7NfwaoDv1PbVyDSl9c7rkqlfprw3PEhKcx/ipCr9nAIBI4r2hgtPWf
	FbnJhJB+9161Fyk9BxbFCBu5WPBUcE95wqlFQ+GqQ9uc/D4+zNvgY2Kyp5XZN/mN
	OiAPX+28gDKrYe8gYSqO3NfLDvQ4WDHMa55wixZZSbitQYS/3472tzBfOX6iwax4
	czuOFfVq3zaBM2+yUlD3xkxNtLPGPb6dEK6yFgqIJD9QfQw4Ksb9QnXISHU2QAed
	78hiQG29R6+4nDSrgTUUve2FE3olpfFIDiePuQZ0NUsu20wjm4kg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd6hjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 14:46:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578EYu41010024;
	Fri, 8 Aug 2025 14:46:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwpu0yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 14:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLMeN/YkPm108D9m8Jw0ih1q1pVMLM1RcSJGI5eqAbRcdb7LNFEbUYU9PRzOSst54CN6yeF9k53qask1ddsM8z9XaCUzpG7yyll10BYh7UmZx9o3P4EwUZ7axni1GX/kGy2aHkEuQ8OEXk8L4tWQaY5mHY29CV+bz/h29msoFSvPintPpraEB0YTz5nmup5kJlVz67F1fcFvZ2tu0GhBVtczda8KpbIXD8xrhDWl3ya6gMB4YJdQXUSiXW7v2dWdllrGfs5VD6IsO9iyGSmj2dACDkMcfE8WX2YJi2kR5C8VsFm8g1AWJtMxzwx76D1wmk9RXQOfeW5ZptWGMbyipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu+M5KRPPtzdMJF//tAdHvkKC6YaE7z1ATl6HXsrIYw=;
 b=USrmWp2cSOICpcEYOZPR7Dy86MTf9O4gH8SNb6U7YSxNz+H/IENDTMMrEIiUsuti+0be3ZmGJtNAXlCYXxXsOYWXKDjfSLUpEOvq+uXVz1qwxwXSmhSAxph8gjQ4H1yyD6tClr8H6N2Q22Ax1VEiwramN3hHiMjHj4UNs4uvyP1+SGHAYY8YKD9Z38H/46fHzCOHG1UFVr9EZgEHkryOvjzDRJNQo5YSsp9VULznoDe8NmZNbBGWrYQqtB2Yy9fO2ytFZigbuOgml1trEAYHUpZ/PZqpajoNYSNoswVLmRmsYnBWvrFGObZnKXQAqdeYpD4cRO2MrFm3pe/SaStQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu+M5KRPPtzdMJF//tAdHvkKC6YaE7z1ATl6HXsrIYw=;
 b=LcxQlkgkLpvsTTLxZPVuN4f28Zik4XW2F/IsO8FAW7TvEAl9i7bdxqTjTb82EjJYBqDRZp9+n1Fnj2EoUhCCMqDDoTPe3uDciyHjaoCj5orWfsAynHYRvWSqD2Y58pPbWg243ffF2+LrH5G1F/NHiAs0gOB/ArvPia4EEfx7Fxw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 14:46:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 14:46:15 +0000
Date: Fri, 8 Aug 2025 15:46:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.17 2/3] mm/mremap: catch invalid multi VMA moves earlier
Message-ID: <c938f48b-d1c3-4c5e-b68c-7788075a2485@lucifer.local>
References: <cover.1754218667.git.lorenzo.stoakes@oracle.com>
 <2b5aad5681573be85b5b8fac61399af6fb6b68b6.1754218667.git.lorenzo.stoakes@oracle.com>
 <571c0a24-6bdf-47cd-b336-efff34f48010@suse.cz>
 <52bd8c18-9299-4a91-aec7-670038d90f62@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52bd8c18-9299-4a91-aec7-670038d90f62@lucifer.local>
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f0ee76-9007-4729-3b5a-08ddd68a53da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IYzZy1u4SajbTYbSGPES+SK9ZU3nTyQKUgnrvKcZRhgFpom0Ko1145NCOrJV?=
 =?us-ascii?Q?ICP0hwPupRnEyPlg3DIkbHtfmIt+E3EyrFcKkOsZjK3yFMVfJY3a5zEul8Cg?=
 =?us-ascii?Q?HBxGIndkh4Auctn/Gal3TqTnS43fu//YqFGqbqtIJPEMSuLi7mWlOZnwNxzG?=
 =?us-ascii?Q?hDdRQ8kUDholQZasKbTrCO3cv/tzoxVEM9xVMB0/V26OE6y/A1uLU6wLgP3X?=
 =?us-ascii?Q?zbZbWLTdPtZEqNupf1llLa3+v+1RXIIg/f88VE6b8Wd9QQ1pYEifHhfbDFmr?=
 =?us-ascii?Q?pMaNB5m9dG3QlVfop/mlGdpiuCip4TRu5CBwimSLZ8i2+l9/xVMdKqQQNK36?=
 =?us-ascii?Q?Jv5dmtvtFgyFdXl3HbruS1qSBySlk1yz3pKD2B98mXf3P6z9dJ0uULJ2DAMF?=
 =?us-ascii?Q?qwE71gW6XuqBLvRxsGAqLMuyo2bdimmnoMWFwRzegjWpxbtQWvpcfqiDSeqf?=
 =?us-ascii?Q?iJoe9FTRP8r+xldpRtROhMumhecuJbPbU9TJnrex0OWVdg4oX572DgXOAUIQ?=
 =?us-ascii?Q?SL9x98YQGpTKj/BKxbYYVO9Em3ZbXXcmCqfLRozGGsNoxQLPNhtsCBCDL6A9?=
 =?us-ascii?Q?hRxOBEJSaTLrlcTErXK9YpEtd45ljQCeW67F35qm3DnIlsWdVj/t7eDgqQCC?=
 =?us-ascii?Q?lWGNmrAFZR6Mcri3vbfD4tdXGV9pLr11mr8Pbs8Fjo1J897oae0mU9ITzghV?=
 =?us-ascii?Q?TAy/rxONid7LSCr882DDlzgr/reCb2epBsnVmGRUwb95vwY0zACwWlCxgjUE?=
 =?us-ascii?Q?lwzLI4NDKZpUtCv56A6tvR8IA1idNcj+v0dbXY2EEEra1nxBHz/eyNm2zBlh?=
 =?us-ascii?Q?I+Xa5X3pHh3BA5tQh5bNw1YrxkVQVl/niBRIgPBtOBDR3qe2JSsBMQHFO760?=
 =?us-ascii?Q?jgWE4KOR7qHVCBiPNAbJZartZE66lDDumUxgMobI9+IEcG9nhcHlbzvTGbQo?=
 =?us-ascii?Q?cj8fxptBOd101hCNJVO83q8ght2P/PG09b7E/LHjxZMlb/1fAtsY6/cXWFex?=
 =?us-ascii?Q?jgO40jeoOC2ccnofPvxR/arfUlpIVVM/QwPuCz27LzB+tVfz9ArthgEQAlsq?=
 =?us-ascii?Q?tVpwHpdP3QMfdCIAb+1hHsKp5byu+jBFL0wdFaIE6fmFYZyUn6Lr7Ed1YFqS?=
 =?us-ascii?Q?ET54eycJPwSyIr3dGJvGPCpCSzATGHz0l2Su8UVSy1hJnLxywWKBM7j6/pE6?=
 =?us-ascii?Q?75lZgny8tQd6z1uYXh3j/7v+55HLd89kQAvkcgAPOjE2J4RN7yFzIdGpcf+W?=
 =?us-ascii?Q?h4D3UXau5Ffmv6HM2XLcVA2GojiTOKVnDacU6wJEvW7keVK3VU/AslmVX3gv?=
 =?us-ascii?Q?DNxyArqxEGzRKMuv5jCxaMQjOjIr2afe6TOpmyBnZ5gqjphlmnjdOrPiQGmY?=
 =?us-ascii?Q?GCSXrPcmASFc+DGo0ssxctVeJFctxBMus1zM3YmgPvX0yTEBVESOO3vdjx0T?=
 =?us-ascii?Q?QDQJ3K4KGpA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yMVAsU5tJ/tBCwAe4H56zld/Z31HS4EMK7e+nxSjBeJcl3UcgwoJfhV+I68Z?=
 =?us-ascii?Q?6Bf1T/6h/n0Zf1jOw3tXYWcRsfYOeQ4YLcGhAN3ZK6khqpvzgeS7Uxs64VMU?=
 =?us-ascii?Q?b1YooiWtnOA7KOVVJmE9R0nMcw1TawyUpSUDvUdxOqiUjYOXesz5tNmwzb+p?=
 =?us-ascii?Q?ZicsvO5QQI+sYfD1bSNcFLKvpJQ9RYr+PTr3MWj06UHpyoYtlLnbsu3Ih3KF?=
 =?us-ascii?Q?AV72vpcfbiq8z9wS2ZlWCl5DX/pjKS3Vzn1GHSbBH1pFigZb68laihoZqSLI?=
 =?us-ascii?Q?aPnpgwf1s1AwBys97QNhPmKBYJqH3xwfchVR2z9Luh6BYkyc3oqZCJAQG8pq?=
 =?us-ascii?Q?Z9kXnl79EzS+REDVLWa+CXkZzqGOrtZ+QFbaE/VPOKQd5BXGfB9qzDgCh7WL?=
 =?us-ascii?Q?ntU6tSFhkUZ3QFVaOOxXxkleFQPz5djqxrQSZhC/QvwRApVm7q917J1H7yDG?=
 =?us-ascii?Q?uaCPLhkEkoC+u7s9bM+ZqqbLUZhNvu91vSeq2EqJUY+wB/vkznxU+l6Tcs8r?=
 =?us-ascii?Q?cDrx3Qxz6+MnJ9mi6To9Xntb4GWW5ERzflPsvdRg+HlGuOckHBv64V3znDn8?=
 =?us-ascii?Q?4xhc67tRhQUaqHBGHLJ529z3OdKPOjGZD0LNFDskJH4sLUo38rgsox6VJYOv?=
 =?us-ascii?Q?cP+WjCquadHZIkyYwxaFvCVOk80be19/HhQmu++7ZI4emxz/1cmV9RkhqwfJ?=
 =?us-ascii?Q?zc8apxIGbWCWVHMcHP0XXZWUKzpGdvHzqKr+VTZvUQ7dIsAJ1QuHeli13Exg?=
 =?us-ascii?Q?fK40DBSvrAzuZOuYLXIOApyGNzPHttmbcpFMpSqN7ok0tRsnG07bQU/adFGU?=
 =?us-ascii?Q?FWTRaDUK8C3CAQr53lszfXGRtKlPIOMnitFE//gFGMBR8jTTKkjh4jPMurqE?=
 =?us-ascii?Q?5dv6R1pr0XSS/GGorPjYA5of0LFRfnadEKUKZ1z+UTfugU4wYlojfGS1S3bf?=
 =?us-ascii?Q?D7LyDmy92JAArD4zu4gpEDz7iCzhMENZVWvgpIF15j5e2fNjyIr16zp3Ra4e?=
 =?us-ascii?Q?O2VFosSaLrRgTaZT63FvOZU7u5SFfIYmfdYXkjfy2XM7BbEKeLkHAdDVyjs7?=
 =?us-ascii?Q?L7CYrr2rr4NFBZhH6NmxyuHFSgoYF+K5j8mpwp89rXpFn/lr99zgsYZg7ibt?=
 =?us-ascii?Q?VFyZks1RpEnT33yYdcLUF4NwHSVn6IKsK4GrVG2pkCOSJZJmqgrsChhgkGdr?=
 =?us-ascii?Q?bvG6Nm7Vst2iCMpLldyHiqhY8K0mrZ1WpRm0Am+foUEIyvgxV65oDiMzcfm/?=
 =?us-ascii?Q?DOEArgzrs/gU9wJte8ry6J2NW5P/S2TANShByU5tB7DM70S7vydoWF9LOFtq?=
 =?us-ascii?Q?u65cM8hrZU2s2l3/VuVnCNVp2pWuAlUTeMSfyeauW6uya5WXVK37lMrqpph4?=
 =?us-ascii?Q?PrrcCNMFsKSYWqshrRxafm/2ZF6BMm+iwzY4CHppJORtgZIdQsd+otB7iK9k?=
 =?us-ascii?Q?/8IW1MSg1qrnZ/0s7F38DmQUqwOZU0QWOAv+EmpzkH3yuIkpFIgI8G9mSl3u?=
 =?us-ascii?Q?qoDAmjM/7rKcc+ZnE3oPLONG6MQ+wgqz/VXPsjhakNva3uh2OasRausA4DZf?=
 =?us-ascii?Q?1rxh/AXc8+VJJPLLjmsq2Lk22dsGcjzjuWzF0z1YiHgRgWeo5E/cbY/aOZ5F?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1m+Fdkf2501779Xw/SYBy5aYKljlXPhN2lgVH1YCkg5/j9ICeLbemeCbwYO0INZJkvDDw2UMq2j6x9W4m0ITAAU9WORbfR5d372V2fC62hh4Gj7BhbTxgCVtFGxXs3EAcV1di+c4YMjz3lRdEpC3nF8ae9aqL/KOcbU6CkPj3IJVkWufhtDjGhdhn2ELSAJDZU2NV8zwBop6lQ5wvoftNd2Hp0nZAmX+eWlITS6bw2PSjiRWNBVrAaktzRp3naFoexkHVL5ERdrFyzX3r64m160Bclb0qpsYA50fFXfyfojReOHdGRdxSlj9uKBJxMIeVjGKWq9jZOvJuKj6Ym6p12hR/IrSfyLog/VWrySp8fGw6oS/vhH1TzzGQoBhRk8p/Go2VLYPHfa4vd0mZR0MYDw2ozU7mRLyz+zTqOTwaijzZu8wg2htroB0BMJt/yrVScQk7OwjQsy/wL7rTL491ZwH13hYP9KG2yZ3zQkJ368raGxak4D/mbo+l4NYOheoHWbX0uhBZO13I6f5PLthEtsi4BH+c+mCgs4kXz9M5JHW/MsaYt9glPTVNuavc+m2bQ4okET6MOYeNrsZr39dVDHphDnrAPLSGcvXvIinelE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f0ee76-9007-4729-3b5a-08ddd68a53da
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 14:46:15.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UGsI99e7J7TDIWVZ6fevgGASTk1ezVSo0ZV28laR2bJi7lSK+Ddq0gH1cJRJFSZYhfL6BydkuoNoYOBJgVl89mGxcMokGZ4ej/UWgg/ue4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080119
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=68960dbd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=6JWAElMpae5xf6a-faYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ZT0PMU8105EFxESWWjUIyLV3u1IRoFeD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyMCBTYWx0ZWRfX4/3irGhT3MxH
 ySCnoyk2i+fqMZSdnO1qWVtRFx2ZWmw2ObYsJnButgaOZKga+rO24DszaRmARNc/kiumIQylDag
 Ys7VMs78VBfb4MzKXnwnq8snWkfOUDz9fyviTr6R5NOaK1wXn4BKuQvVSZ7HhY988AI1rCU3lOD
 xCwIY9eNP8W73n39P35vnAcpMsiZiDEub6mNB+IkGmGmqWD/JrpyBerHDxgiLCIcCdA7al7vtZk
 2ydGFgGg5pX72+ToxIyEZjHGBieWT58SPhTYev1mowtp0CKqeWxcvBoVVdhuk/EX/Ca6C9IfTqr
 vqqHcRBFPgYDMTYl2jfxZoW2qNzQ6qKNHwxmUeTnXGD2//q1oHw7s2wbulpKkGGgkaF2COj0oiV
 BlJLdKVA84KYZtGC0hVRCOgBQH0rQ3+w55t5yhN/izUGy0gK2e18pEoHoBN5i1qQDSYpAdix
X-Proofpoint-GUID: ZT0PMU8105EFxESWWjUIyLV3u1IRoFeD

On Fri, Aug 08, 2025 at 03:34:13PM +0100, Lorenzo Stoakes wrote:
> On Fri, Aug 08, 2025 at 04:19:09PM +0200, Vlastimil Babka wrote:
> > On 8/3/25 13:11, Lorenzo Stoakes wrote:
> [snip]
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/mremap.c | 20 ++++++++++++--------
> > >  1 file changed, 12 insertions(+), 8 deletions(-)
> [snip]
> > > @@ -1863,9 +1861,14 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
> > >  		vrm->new_addr = target_addr + offset;
> > >  		vrm->old_len = vrm->new_len = len;
> > >
> > > -		allowed = vma_multi_allowed(vma);
> > > -		if (seen_vma && !allowed)
> > > -			return -EFAULT;
> > > +		if (!vma_multi_allowed(vma)) {
> > > +			/* This is not the first VMA, abort immediately. */
> > > +			if (seen_vma)
> > > +				return -EFAULT;
> > > +			/* This is the first, but there are more, abort. */
> > > +			if (vma->vm_end < end)
> > > +				return -EFAULT;
> >
> > Hm there can just also be a gap, and we permit gaps at the end (unlike at
> > the start), right?
>
> I don't think we should allow a single VMA with gap, it's actually more
> correct to maintain existing behavour in this case.
>
> > So we might be denying a multi vma mremap for !vma_multi_allowed()
> > reasons even if it's a single vma and a gap.
>
> This is therfore a useful exercise in preventing us from permitting this
> case I think.
>
> >
> > AFAICS this is not regressing the behavior prior to d23cb648e365
> > ("mm/mremap: permit mremap() move of multiple VMAs") as such mremap() would
> > be denied anyway by the "/* We can't remap across vm area boundaries */"
> > check in check_prep_vma().
>
> Yup.
>
> And this code is _only_ called for MREMAP_FIXED. So nothing else is impacted.
>
> >
> > So the question is just if we want this odd corner case to behave like this,
> > and if yes then be more explicit about it perhaps.
>
> We definitely do IMO. There's no reason to change this behaviour.
>
> The end gap thing in multi was more a product of 'why not permit it' but
> now is more a case of 'it means we don't have to go check or fail
> partially'.
>
> So I think this is fine.
>
> >
> > > +		}
> > >
> > >  		res_vma = check_prep_vma(vrm);
> > >  		if (!res_vma)
> > > @@ -1874,7 +1877,8 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
> > >  			return res_vma;
> > >
> > >  		if (!seen_vma) {
> > > -			VM_WARN_ON_ONCE(allowed && res_vma != new_addr);
> > > +			VM_WARN_ON_ONCE(vma_multi_allowed(vma) &&
> > > +					res_vma != new_addr);
> > >  			res = res_vma;
> > >  		}
> > >
> >
>
> I can update the commit msg accordingly...

I have asked Andrew to update with a clear explanation of this (see [0]), and
made clear why I feel it's consistent for us to disallow this behaviour for
non-eligible VMAs while permitting it for eligible ones.

It means we can simply say 'for eligible pure moves, you may specify gaps
between or after VMAs spanning 1 or more VMAs'.

Cheers, Lorenzo

[0]: https://lore.kernel.org/linux-mm/df80b788-0546-4b78-a2fa-64d26e5a35b8@lucifer.local/

