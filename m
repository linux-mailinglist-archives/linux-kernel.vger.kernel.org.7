Return-Path: <linux-kernel+bounces-743542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2885DB0FFED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F760172831
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BA51FDA9E;
	Thu, 24 Jul 2025 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SNn0SXJM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CCCbvCYU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67D41F5858
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753334689; cv=fail; b=ZunitCcGhV9Fd0Nu8a1E7KfSMqgyvVsWd63JUiqOzM6wWnJkG5401bEyF2B3SPqB6kikGBx7nePyrYwvRl5nBX6StVkzL+lhyZhHolXSOIn4YuTPOKKZKSo06gALR5cj+v9BQDUiCczPiw0KiORaq9ACj5edUinTRU6IFtrcWzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753334689; c=relaxed/simple;
	bh=QZaiesagg8S2T7YiqtY6peembCvG17nzdvfktKaTZb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BFoJteaouNQ7Igd4tJUu64h3fiZTue6fhc43BcByG3Yfh2bv7UFYNEtipnSnNGY9Ced2akExyJCkujaThIc8LFQcs5j57hpmGgG9zfsJl4YNIDRo9rA71xiTsBgDdXjqDMgyK8KBVlh1VvfMdVSlmlqVEQxWCxmnGE0BAAgj498=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SNn0SXJM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CCCbvCYU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NLQp10002523;
	Thu, 24 Jul 2025 05:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QZaiesagg8S2T7YiqtY6peembCvG17nzdvfktKaTZb0=; b=
	SNn0SXJMYq6RswGxv5N/5bL1BScENrFMMuFTTU54C+8Jr7vEM6Pp78A0t559oTm5
	erES2OXc6cYRZLK+4jEtGNnzrYSHpH/lKshA2VuYooBd0eBr+CYCfCTprg1SuIri
	Pa2Her3TN5DLtYgXHhAFyLEh6djPG1SNeuFZ8pXFC6QjTry7PHt2/dY4p9N8vHCF
	MiMotv5iaS26jqd8ooe3ZNgoNNal+B5vct0WiwEE99+1e0uMF4M+KgIUIExZWmkV
	ba9nH7rVGBButIOmlzIKQubg8mzTpRK4wwT0qXu/9yBm8qMwBsJ+5isgWzakinUw
	5uBju3u+1NHDaw0vjBcFTQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx8wwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 05:24:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56O2j9Jp031482;
	Thu, 24 Jul 2025 05:24:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801thrc1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 05:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcRRSUB4VfXGWlK2BOJ5bjl+l+axqWxuynPLS8zSB33fVs8EZTS9pF9G8v7TN7e90a7E21r/Z/Pm/HRtqMJtIxfe2o5EJuOnUQfs65c4jwlBbZB3N0eR/isV5PkkyLzCOQ4Dz//f1/sUDZ9KHNmyKGNr2S6JZ5QcP9rIgh43dkU1qT+U+dQcIWWo2LY4Y3Bpwz6+lGuJf1O5l8/qLCPT3XZ4cyGa7KFai1jIV12mON/K5Zj1N+eHmpx1RajcfgTO+aJjjcLhagG/Ca11I1JNjYlHXPGizQ47lbc4UHoSiyVi0AluyCGxfgwVRkKpz1c7P5CxEpWuuBZw0aI+V2yD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZaiesagg8S2T7YiqtY6peembCvG17nzdvfktKaTZb0=;
 b=wOiugeoom5n1nX5JxrkDWHZm2G2vWPrBugMCQmdPWiJyi4G+K/8bOkZ9iRNJj9WSdHT3T1U0jJMqR2MCpLoIrAyLbInoDzqpfxSRPYw/2iIMibV4xFOQXD+aKMS40Oy1BEqwSmzyef9prw2ZzfrBK7+Z33hEa8FlK4AD4JtBwxrn2M6RJDiWtpPPsG7iFBd/fxEm3jPYKZ169wm0t6aQ+I7LATpS5uAO1rNiokT0gNv5IMn3GcwlKZjALeGlmdMJbObz0gtWTI/vJpa8GZXS0hBhbzpjbNzYL+5C1/VmvWS/QKvAKuKDt/Bg2LixPAzL81JTnK/pif1dEQk1/egpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZaiesagg8S2T7YiqtY6peembCvG17nzdvfktKaTZb0=;
 b=CCCbvCYUjoD2haVSShIJmsAm99kzxoZ8FoXFy6jIa4A1AIX+PVvHE6c5+rZyfV6dzlxoQZpGrAhLDq430isno63wacwxiXdF9H2zF6Ma5dwL6AJFdeSdhgQO9nNqEDrAN9rEQqhG22XRRMUz3QMTPvk7H/dK65jpmXawqGJrZGI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 05:24:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 05:24:11 +0000
Date: Thu, 24 Jul 2025 06:24:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
Message-ID: <0e057095-e4c9-4869-b147-c48c9f66e500@lucifer.local>
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz>
 <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz>
 <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
 <28e1fc65-995c-4185-b5c2-7eb001312698@lucifer.local>
 <CAG48ez0KE9bfFJ+yAMPUAj=_hcNRfes3=nfQd7Rv95TSnHtUCg@mail.gmail.com>
 <CAG48ez0782x2dqa5LrK2cf9M0_Q=Gvo5tXsUFQDtyK00LpcvyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0782x2dqa5LrK2cf9M0_Q=Gvo5tXsUFQDtyK00LpcvyQ@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d25d5e-7649-4d03-e9d6-08ddca7252a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGVDRjJPakd4aXlmMVVCTHMxelJzTGZKb1R3NUxHMlNFRUtDMENldG5PNDZU?=
 =?utf-8?B?cW5lODBwOVlza3JtSmhYQ1I5STRuWWVadVNxaC9PaVJRbnkzT01vWWNUNG5p?=
 =?utf-8?B?bXdQVmd6RHZxRTNMVHFBcUM3RDFodzRNUVFxSDFSemlJaXREcVF6RERuWTFw?=
 =?utf-8?B?NHAvM2FVbXNzTHB3TC90ZzBUditlUXU4aGtacmdYRlZEUnA5MUpweEQ1L3Za?=
 =?utf-8?B?TnBDZG1tZy9kb3hwTWdidDRab2FTZHNneEZZd0dKTXlacjZvaVBDL1RaQkxS?=
 =?utf-8?B?NlJOajVxVTNqTXNzMGRDbmNRY1V2Y0hXOCtWZWFSR25ibDMxbmZPRHNmcm5P?=
 =?utf-8?B?Q01YUEJqOHRBOXJuamRnZkdVdEovbXhlQ1ZaWGlTbzNiVUwvVUpuemN6OWw5?=
 =?utf-8?B?dS9aTUVjRlFCUktOVXdNWGhOQUZpUnJsTU52RUZRZmQ0ak94S0VQeE0yMDZE?=
 =?utf-8?B?QTNsUklMdDk5TEFtcVh3Vk5yeGtST2NFelRvY1dXR3ZLUkl3SjJlQVZPR0g2?=
 =?utf-8?B?L2kydG84dlpyaEFrVlJEY2lOWjU2bjNQYVc5cWtVODdBTzJxM21qSHhFVEp5?=
 =?utf-8?B?WHl4MU5SZlBqaVp6S1B4RHdTN0xYcWoxM3ljL3Qrcm5rOVdUV2E1a0ZTSDJj?=
 =?utf-8?B?VVF0YklUenNPWnFXTmEwbFlTOXBXbi9Jc0FBVUt1OGFBSDlQS1hTRzZvdERi?=
 =?utf-8?B?WHRnbmN4d3JmaUZ3ajhYdkxxQTlOV0ZJRjV4cHFBU3ZYUWpyblVyOE5oUXVv?=
 =?utf-8?B?ZVd0dENaUWlTNHJwQzhWRFVkZERUN2ZES0t4RHdKNElybDlmMHJZb2poUWhz?=
 =?utf-8?B?OGl2bllvS1hxMlcvRXhMSzU4Z2Yra1FZMEJKcjlVcGpPRHp6dThIdElmdnFm?=
 =?utf-8?B?c0xqV3ZoVDIxL2prZUtORndyZlFXRGluZE5BWlp1dXZEa2grNzNJOU1pU3d2?=
 =?utf-8?B?aElhOE81cVlBMHFxRzVUWmZPbysyTlExU3YyTWI5elUyem0rNTk4Mjk0ZDlD?=
 =?utf-8?B?T09sVTY5Q0grQlFPeU9URXQvb3cvZGkwdDh6TlpGUDhGQzZ1TWd2Y1pCMFl4?=
 =?utf-8?B?MDMzNmt4cjJVSFdTQk1Sa1lkdEhvbVN0VzRlV1BENE1EQVpLWDU2eXc2M0hj?=
 =?utf-8?B?WFh0Tm5PUlVGWGUwcGkxMEpCRUMwbVBnWDY5RE1YVWJTQUNaZkROck5XZVRs?=
 =?utf-8?B?VzhCQ043bnNmaFRzTEU3U0lMMUZ4SkZDNTFRUGs4NDQ5ZDRROFE5bUxFY3Zu?=
 =?utf-8?B?Ukd1K0M2ZGJOQVEwL3hraXdQem0wNkp4aXRRZjFsa212WVBTWmJvVnhjNDE0?=
 =?utf-8?B?eHJNRUxYMmxPU1RvdDBXWFlEbktFSlgvd3lmRDdJQVdweVg1MG9va1c1b3By?=
 =?utf-8?B?diszbFp3US8rVVZqbkE4OWRlbDdvVTMxcG1lSU0vSk1iQ0s4Kzh6NUlvdmwx?=
 =?utf-8?B?MXpneWRaTDB2L2t1cHJmY3QreGFMU2lDTy9MSStLS3k1R2dtZFgwRXNIRWMv?=
 =?utf-8?B?b3Z1NjhoRVJZdlVQOG9JRVlBcmIxNEI0aUM5SkNHWHpYbzFQdVd3VjRmQVRt?=
 =?utf-8?B?ZHNtR09iRGRjVUZmT2lDNS9TQ2taTFhtN0liblY4K0h4WU5aazlLeGNWZkp0?=
 =?utf-8?B?VE9yR3Mwc0E3SjBWOVR4dG1uMmRlREpqL0dOUmVKTzJaTmRpYW5QdTVEMk1o?=
 =?utf-8?B?MHQ0M1dkYWZtRHpFNmtFV3BIS1YyN2xVTFJ6S05aMXVpQmxrcjFVZjBrY2R4?=
 =?utf-8?B?K2duQVVKa0dWSjR0WGpIYjVYTnZ1NkZTNDRJYkZxUkJGRU5sTnI2ZzJYNFZa?=
 =?utf-8?B?dXp2eVVGQytxeVJSTEsrV0tNRHcwY2dIVVZpb203RFZnZDRvSStxMUM3T3ZH?=
 =?utf-8?B?WGxNTzFIckRHMDlObXBjdXFFS295emVlVisrTVQ0NkZuVitvczJRaWdrN2hX?=
 =?utf-8?Q?ExUVfLM5NdU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXc3QmRIZFdpekRaQ0RiV2xSaUtPVE5sNkRKcVNPM0VvZ0J5ZWpBb25adFp4?=
 =?utf-8?B?MHhOOHFaa1c2UzkydzJTSGNNYzlSeVV4VDFCMUVqSWNoaFRySU5QQmVyWFcw?=
 =?utf-8?B?VWpWMy9yTjBOUytQVHl5VUVSVHREV2RRRW9SK0dKRnBpdlMxck94OXFlaUIz?=
 =?utf-8?B?QlVKWVRmSXVva0RCRXk5cGNDTmRTcjA4Q3FQN2FLNWRsYzhCNTg0K04yV21D?=
 =?utf-8?B?NENndm05UkRCbk9xeG5KeWZibnRsQmxvUnFobDJxR3N2TmRDUHY5UnliK2FN?=
 =?utf-8?B?NDExL2ZObjJFYk56TC9kUVltOUttN3BzSDRnZE1KQ0xncVF5Y3lCMlZsMEQw?=
 =?utf-8?B?OU5PWG9saE1lbXVXTGdDRTNRYkNhNXBKUCtBQzlOeW1RODlLT1grQ2lYckNu?=
 =?utf-8?B?UzNLYjQzQW9rVkV4cEN4MjU4UUNxQmJxdjRZY0QxUkZjTU9QUVJRd1Q5cVFv?=
 =?utf-8?B?M0FKcmh3NzJQVHAzRXFpK3ZReUVOV3V6eWNrNEcrR2VuQzFPcndEazgvdGR6?=
 =?utf-8?B?Z3Q2TmhjU0hqTFFXdWFIVVZDS0MvSTBMd2p5elRmajRVY1RQcWVBcWtvaWVo?=
 =?utf-8?B?TWZjZ1hVcThmaEVJeWpkR2pXTWVFVlgvVFJGQzFTc20vUlB5U1JHamFvTzRX?=
 =?utf-8?B?eGE5azV0UDJvM2h3eG9YUlVRdENQQUhTelRFZHEralcveSt2UGVmdENpMnBG?=
 =?utf-8?B?QVlWTGtSUGNGMnZtYWg3UWZXdWZPSStLa1gzekE0VDVNbkNkVDhHb1hoMitV?=
 =?utf-8?B?cTFoejI4dnBkVDJVbEs2RnlFbDB1Z1BQM1l3eW92MktRRWtDUUlPa0Q1T3ly?=
 =?utf-8?B?ZmZhTlpTc053Q0h0UXpSTjR1MmJjYU9RUTlYeW5WcElBbDFYWk96OTI5dTNC?=
 =?utf-8?B?RWhwS1h1V1ZBK1o5RVM1a25Pa1U2cisvMUllOHZlV2xHUnBtVmJwSzBaNzdY?=
 =?utf-8?B?ZDFBejBFMExOWERuZzNVMSsvaTlLcHNNWGRYUG9uK3pqVzRWSlBqbFVqTlQ1?=
 =?utf-8?B?N0UxeDExcEI5ejk4ZEY4TlM4ZDZmQytPOU5Hd2cyVDdFd252Vjl4WGltQllQ?=
 =?utf-8?B?WGtwakdPWXFWZExXVVZ3REE3c2t2blBhQVJwNjdSMnFMY1U2MmJTVEllcnJn?=
 =?utf-8?B?WjJBOHlGK0c1K1ZzWmdBckNibnhVcm9iWTdncVNWUmg1dEtKZHdIWE5yWmdt?=
 =?utf-8?B?YVpYK29KWjBWeWlxSWpBTUVvcS92MXUvMWlOTHZqYzlYbGZtSGYrWlV1b1px?=
 =?utf-8?B?UDVjNm1YbGY2M1pEVi85MUZVZ05HQ1NYeVFPaVYwTTFPY3Q0dlNFMk9Vb0cv?=
 =?utf-8?B?d2J4MXQxR1hJdGtZajN3U3k2QnpkbXpqeWo5azlzQXFrZEhIbENVSHVyc2h5?=
 =?utf-8?B?MFk0QUQ3SlRvVFkxYnNCZkIzUXdCQmJTOFp0RmRWelhyNzZVaWF2aWNHNlp3?=
 =?utf-8?B?MGZ1WFA0aUh5WnF1dnp3MExaRHlwemcrZ3JOSU03UjZWUTRXa0tlNi92cnlx?=
 =?utf-8?B?bExJY1hjdG9Hd0R0RmxRUEJMbmFiODJTdmJsZWh3QThsOE9HaFJPUzR2T2l3?=
 =?utf-8?B?Nm5pV2s2QTVLWjhYYVJ2a1BOb3pmeEcydW5FMUxHYUVlYngrRUFwa1lkRUtk?=
 =?utf-8?B?WDZXNWNYV3dvT0pZa2J3VDhwUmxnaWY5RDVuMlhCekJhdkorbHBhV0NpcHdK?=
 =?utf-8?B?bkc4NS85dy9VSmZQRlZhdmllRlNTc0tlVFp2VGxsNWVYazRpYy9QTitNSy9m?=
 =?utf-8?B?N2FZWmpXQ0xGVlZmcW16NzdhOWQxRzMxbkw1TTNGQnlsWHJCaW9ncTU1aTlH?=
 =?utf-8?B?Vno2ZW52VlFPbUhpczdhMU8vS0FWYkdMa1ZsM0FHYnArOWJndmRldUNJRC9U?=
 =?utf-8?B?UUZXM01nTThRQUFiM285RGVubDVDeExvVWV0QkNPOG5SbC81elVrZ2JVT0Rj?=
 =?utf-8?B?U1dRWFhKdWVOWEx3di9oTkpyQkJQd09rWTlQaGNIS1BkOTBDZDhmWXR0Vjd1?=
 =?utf-8?B?dXBoSW1TNjU1cmN3QUdGYTFwbkxLVWRXbGNMSkxiSHJBUGU5R0dmOHZUOXNE?=
 =?utf-8?B?b3BFYm4xdFlWUEdVMndFM1h5SVFvSWlxLzZiNlFoSkRINFdBQ0ZZcmtlRUpx?=
 =?utf-8?B?QndvZ2srUDlNYmkyMyttUmJyRmIxb1ZtRkxDZlRZOTRDRkNvNXJsOTBJdEJQ?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M1Iyam7yZ6Fyj+miOkMpAOli3p1kmj4Ix6570OADSV2MdYHNsiRbBuCdRd5I6P+a/zmisP+YizNFN4KqaQZTYbbILi0gtzS7VhzRwsc51rdaV1i7icXwf98sPDZK4lPaubBQSF5SIQha+AmM8CP95OFyaQq3JAtibLZDew/NzInOdOCRFyXfGf58L6KVlvDGbpw1tNu7agAuwroynT1P/u24PxQUbZWFoLOYbwfsD9b8l0VSOTfBGSbz8ydoO5TFWG6stvGwPxxeirvVjwBKkNJ0IdpoTQ67vwp/Q2nk7UCUOddiAhSD/s1gM4lEYHxEcZyd0IhqW8wMxqR14ybiHh28Jxma4zUEs0UYE7wyj5hbxt0fgiOIJcDfdXjnDCL+98Og38laRm8xLyycfLWGbidM5nx13vaqYFxcuaSqQEl/VQANtH/OZQVmldZ+1QL6cC6IlfjGJ+STo5d+FGVeGGSOY7X5WtlhHGwK7HgEnD9CdmBxPhep1+uIihCQcAhOEUg0cLeIHGQExwxq0OK0PUV/O43v3y/c8F9A7V3DZu0i0HM4Y658SPcWKez9AaA7z81akW94y0QTXxES7+u09B2SlVDfgCFlRkcCD0OoMBs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d25d5e-7649-4d03-e9d6-08ddca7252a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 05:24:11.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vb+gsRhwh13dXtWwJJ19ANO0KpzkN3P1UddWF0r6qRos/87iB1Rg+0ctvnAq8PORy0Q+7wpR1iGpiIl7oISy0ZpazGhIrrRSO8OwQJPeRI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=596 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240033
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAzMyBTYWx0ZWRfX64qlOvn2sYAC
 AyHJZ5TcwSp6fvXeYGVa8DGOyoqCdTxQn5TCtLPcMc9K85f56yGHS04XYnoOfAC5ZbZ3efdSDQ6
 DSwZVrJNaRKNnNyY9taSVpf/ps1yG1hEOdhRHAJynrDFSL+vKHmWGwH4Kt3C4Ag5YGr6jFvnQU/
 uaz4gDFB4B/hQwVfl65eV9dIoiRFTwWDRndyuvCtMzNfScB9/hFPTpclY9uGvmYncqjfBmLotab
 jTuPEEAmZyrdpCJB/3dBJos5PnsUtQj6cjTwIaOG04Ck1KdQlyuipH3NpGF4ZJPbg3pyMLSrUOy
 bOdVOprzyrbMs2wDL7pC9WgdD2d2eaY2RAzK59Idaqe5Kgk2DCw1gEerAeOx1a9frWswBJoKYMA
 gUdaVedYTN2EshqWrefRBOKBNwyR/SfN9TcEi0m/XwrBK29UodpLEyC2cCxMQ2NZtXYxomRR
X-Proofpoint-GUID: 2hDzerFUfVxfsNptVaMUCYO89OgSD-C9
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=6881c38e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=1XWaLZrsAAAA:8 a=56QpafP7TFTAxLFPCxcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: 2hDzerFUfVxfsNptVaMUCYO89OgSD-C9

On Wed, Jul 23, 2025 at 10:00:40PM +0200, Jann Horn wrote:
> On Wed, Jul 23, 2025 at 9:52 PM Jann Horn <jannh@google.com> wrote:
> > I'm not sure if I'm understanding you correctly; but yes,
> > __vma_enter_locked() waits for all the waiters to drop their
> > "refcounts". (It's not really a refcount, you can also think of it as
> > a sleepable read-write lock where the low bits are the number of
> > readers.)
>
> Sorry, that's not entirely true, since an attached VMA has a refcount
> elevated by one. It's kind of a refcount, and kind of forms part of a
> sleepable read-write lock, it's complicated.

And needs internal impl detail documentation IMO. Which I'll provide...

