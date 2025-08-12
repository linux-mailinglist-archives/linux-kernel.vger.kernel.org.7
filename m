Return-Path: <linux-kernel+bounces-764647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA07B2258D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114B71B66B44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC42ECE99;
	Tue, 12 Aug 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ltgYzrUt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JjoqYMWW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A32E9EC2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996932; cv=fail; b=oIaTJCXCR3Dj+IT+hT9eF02+eZ7Bmb9e3gScIoXDDzYYMqYTtlPfmNaeEoFDvvd9XNPJ7Tqu4mqvI7ysJOnrCFdwYwi2jHIYrQIEXvAl6mmnX72+Wp/qrr3wPHXIyoWmL6T0eiv2cXaFrCPnjhMTsHCauq5jBs9rl0wCye9Hi+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996932; c=relaxed/simple;
	bh=9tQ8YuzNSQowrB+O/Y0vG6lbmMxEh6zlhuPrlQ+ylIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qqjE1zihLB6LFlZlKj6+fepAovPb8/Jncs5gZoW4+FZnIRdnOYqGr9wmp4vNh0FriJF37iTzbfC93CneSX9o6CSEjBUoqZtHgjbU9kG3bRtz8pDUqgCyHu0DtqxhJJcYUu+92PBBgWbhD0A860rUtFCgRJzYsyqF8cCiVY4C/5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ltgYzrUt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JjoqYMWW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C7beec007070;
	Tue, 12 Aug 2025 11:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jcNGoMWqHLToFygBJ4
	zzaOV6gn8eEE9hjUm6NTScAk0=; b=ltgYzrUtX/wh8yMYZTgqCobkbPwAktG6Pk
	IXVcyar8PFFVz1FjQ5Q8V1NEtPsx3yzNgt6Egm+wX1M6AXdCgkSbl0LAhPr1GqBq
	5q+o88vT9OGJYtL7+Kpiu0S1fbKgoHbFEW50rdh44npMyJlE0PHqgNDSZXI3l3VX
	W/XACvEVreXcQfuZL7HGcAxsHzyv+rIUzna4OB3bp7HtevoEd8m5vBg4EhXTySeg
	O64R/WBG4QmFNJz3o6i1dduGH7PqEAZB1RrfypufhM896RORxpAtnEWSrzJfKb5g
	T1+P6CLcru3zrw7Fpgr2cIGDccWyZw9NMZuUVn5ILPU6tADSEV2Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4cf4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 11:08:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57C9rs5Q009928;
	Tue, 12 Aug 2025 11:08:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsg48s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 11:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO/xGT8+XY9GGsGta8yd/+d7iqGEhIYgjw4SCBfCUaD52Z+brxsI4yAMXE+oJ6kSEXGtlqUQ2t2ahfPjfXn+xaHmHxVfj7Hb8+j7Yx61I+Dwe7q5jOkmlcYqGzeHkxTG7L2yAKoDC+nEaFUmRlnBvSQiiuAqA7taUhW9VfEZVQwbphY7AnJ/+PCZWBj/o6161DMEtJwPeSJqVeVH54/vlkkr1+WyniN5buHljaIoz5RxkpTx1Lxoi9GcL4iS9xhYLwZlQvIuk6ZQEAe9bjQgF4oA1Nv1aw4wrjxlq9S6GbkEpxczI18OTysMtm+/nhY93rMAU14/3I8nVScTIUAsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcNGoMWqHLToFygBJ4zzaOV6gn8eEE9hjUm6NTScAk0=;
 b=bcXDxIqNrv5WvNZcD00vR4tlkoqu71tUvOz8oCekTcGnaC+qupo+frxSN8WxSsmykW4hVsDQwC0xYvdYktKHkA68UZoER0LsSOOmw8HM2H1YEQwryIg/e0eVlTzuHon4BRZ63zj3VCFZhmrnSxkiJ3u3CkBhGEOccAFml9YTWpGiol6Es5SEaG3WcUg+vfUpB3LZe+BulzK6mzDFDAPwU3+NOetnF5Sl5EH6gmmnjwlAayfv0V/P4K7HssQ9DnkzK6Cxc5pMdZUuHvrZr3Vs7fUyHxaHfl794kti+7PBe6gEJ1vrUjDUkgQ60MK0Paz6jkmwVwepLZEqlR7yH2tmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcNGoMWqHLToFygBJ4zzaOV6gn8eEE9hjUm6NTScAk0=;
 b=JjoqYMWW1imHCc7B8aM+imigNVVIRuyqxQSvkdU4K/j8WqlP+kTDCeYxmBkgKXE5vhCzEh1CPOev3+/CKJyPh6lbxjZCEyRXSq30/rCWn2DJCPhWpyFjCo1mjGLP3MFsAzAp7lCnv4rtgxrGhiQ+K2iTZWEqjDK+c7fD7/epH5Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 11:08:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 11:08:35 +0000
Date: Tue, 12 Aug 2025 12:08:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 RESEND 4/6] perf/core: Split out AUX buffer allocation
Message-ID: <180cb0c2-0164-4c8d-947b-a86be2a2912e@lucifer.local>
References: <20250811123458.050061356@linutronix.de>
 <20250811123609.667172352@linutronix.de>
 <b606c5fc-2463-492d-b978-e8cf4dab01c7@lucifer.local>
 <20250812100613.GH4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812100613.GH4067720@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: GV2PEPF00006630.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3c6) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b4e89a-5175-4e30-5452-08ddd990945e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kRk0QUShDZyorBYjwfbFY9OB+VssRzr4iCChbKjFmOxlLOpv1lfuzExFULeA?=
 =?us-ascii?Q?Efw/JCpUBPynGKpMqmblhpeOHhCjI9DMPfU1YjtO6tU1Gk/agVdN4qKI1uVA?=
 =?us-ascii?Q?5d9MdRinhmb71ocUhZY4ZAUIpuBGL1KWtlPWXqrcfurDhoIViArTRVjp/02B?=
 =?us-ascii?Q?5tJz6EyzsLtG5Xqwit2vaqv6S+SE+QpXBdc6ZihNfWlxatjs3jPtcTnmPG4/?=
 =?us-ascii?Q?CBKgbzJ7PAGzKJHylOxzaCH4C0zUcG2u0uPQpjUSKjtaURlH9tGdwfxoc68Y?=
 =?us-ascii?Q?sUF74Q8fIv0QSTcT2vyMRXTUiQ6TJ6gN3WkrgS415YCvK54aCU+MAOX5StNc?=
 =?us-ascii?Q?6CWHWCNzTeS4ZEuWWBwZb5qVsjmEtLkb9I+8ZX/wRQNguJxBwqxGBlZuBG0y?=
 =?us-ascii?Q?+0+OuNDm9lI3hXefKCm0G1FtHuf264B3S0RZ5u4FC7hWawPyK9dZFSdjwor4?=
 =?us-ascii?Q?Fwt49DkkTlaZtiBWu5UaRUxUd+7Y2LIS7YelLIfZmd/Z6Vv7Y1a75xrGyRre?=
 =?us-ascii?Q?Hjczh5gPB1g32F7YUbTA24K4jbBp6sU28rjmpP+z4t0NNPoRObsMhaLx9WVv?=
 =?us-ascii?Q?TJwrh19Z0WU5/dmZPbjvdsG+nbmyV4VmT88r9AQ81ItXKIzBqT7giAHNVrPQ?=
 =?us-ascii?Q?qXZ3ozi4aNEsSzhRoMwmSO8QLeC/ZhdrbbjbHTbVdoG8lDp6HNLxYy1qVmMI?=
 =?us-ascii?Q?j3WSLjsWAXhGv5Y0jnPAaRTduvDaUaaU5C/QJnMUzrCZ3o6KJ+s1JpGhjcac?=
 =?us-ascii?Q?EJ10d4B73wtYfkqBcrB8AkbvmG1aQK4ljy3jyM02EZPJoVdrx4DJpbD8bYyF?=
 =?us-ascii?Q?IqNYBoibj6vS/mMW8LtDStNUPqEGjpm/DsZ/1NpqP6fbZ8gkUlcmwSIthMDb?=
 =?us-ascii?Q?ugxEng6I54Gb+55NAxsJgbOKjDTH2JepKvD0h7RYAggoF/TyNHtNoEbA3VI9?=
 =?us-ascii?Q?m8ufnvDjYW0qt/st4MYb+57t5glkTUbKPJgtxoSJsVM+5JvC4PfswlSvxTGY?=
 =?us-ascii?Q?CuiHwfLR6Wpf18izYNpicfETXkcSbmnlzcRS9J+Q8q3P9LkNiuU7j52G2uN7?=
 =?us-ascii?Q?NURCoZF9WQ+bNLfURExZznbdn168AphgJHWmP8HF2KjxsEiAKJf26GvsZy05?=
 =?us-ascii?Q?QVKOqSe72uoyfaKT5cYO8FNa0/Cx+IZCJoJQ8tIaFnt79m/6dgy2fRez8IB9?=
 =?us-ascii?Q?FTTqmWzPaqgnfaLn4rhXzwpQnUH+BhEPVgAo8VF+k3yL/3mI4EBjAEHagMw2?=
 =?us-ascii?Q?1FdKoIV3Pm9dbsQ156ShnvR6HF6dMaFfZrlOexr9l8sy4L+18+4Qm9VytFWB?=
 =?us-ascii?Q?6B5RkfnPqPYL50HnubzVB95qAv2pKrs/TMMyYTFhquAfAV/0pP+g87jTbkDP?=
 =?us-ascii?Q?HNf2+USH1/1epv4x1pGzsKx4omIfXNhmw0sv3JMTd8keIkRJvj9DUSezHKHN?=
 =?us-ascii?Q?ECg8TWf0a1A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iVmllTZwOLgvRxFmR9kGvwF+Z27/OMnqfVUfJ66Su2+nfEb6Bjcv+LdYt5SA?=
 =?us-ascii?Q?jZUZ3nlvTcsY1NUyZ5GRv1g5Ta5e8evXLzyMIH65FaY3CmCOoco1y+s9I0iM?=
 =?us-ascii?Q?IncJTEm1nf3+ChHqzqJ6CzQ6CL7YQJhIFKB/5HUvNvc4o0VIT0eli8Y9tTwI?=
 =?us-ascii?Q?uFUY9SvxJx8G+Erc/EJQOvSuZSR5J+qleDATwv99HCdPjcK4FC57LUoZcM3B?=
 =?us-ascii?Q?Vj8J6kflpJQcHGWTnhn1/iF/WyVme+76HNP+UuJTRpW5DI2QhQQ2xpe1HftO?=
 =?us-ascii?Q?PdNAqPJ9AkWj/6fiQhLh0X5LRF6eZza4l8cOTjPyg3mOPPSGiMeR40PAOkAj?=
 =?us-ascii?Q?bHRS7mS23Z7S3HSdVR2Ysj7NWc2tdNFleOaD/zLnSmwxNHZUHfMnd3Dpxllv?=
 =?us-ascii?Q?INPCWYPLpVQIQy1hIf9tA5depgTLxkW5hRKUBtIByZiZajJFYulyC97/WJcX?=
 =?us-ascii?Q?jktWe+K47XmrO3RNPyTEZZwWJO4OZobYYwRWlG4KlyfmSDThgTRYVhKnTPKd?=
 =?us-ascii?Q?sl62KMrga66HpZr2eae1CYnstrk3S9bBBFtjDiu+tkClUCoRk/kiOYBI6u0U?=
 =?us-ascii?Q?ouuDwwanX58Q5FlGlkSrqbDTOCpgw/h3ef0IuxYFjKKDpXZOmyqG+8zc2UFM?=
 =?us-ascii?Q?Dx29N1TfOOdncRSjTQMoKe3bA22jJFx2Pj0GR3WfoBWYvmFnUXypELG+GKGP?=
 =?us-ascii?Q?TdN7xvli6CK5tD5ybIEFPMlE0BylG+xTbOT0O8gJUKiKfsEq86N+4Z/kbocz?=
 =?us-ascii?Q?lffQ2AnC86plqpUkN2NLTZaeQ/GZf20+oyPAfLctBKqukGvqqaVD1Ss03d3m?=
 =?us-ascii?Q?e30FKyUG4JqK6sriw+nt3kdjgb195B2AFClweIm9OKIeujN9uqmmiHVO5wj6?=
 =?us-ascii?Q?ATXr2j9p61vDAREjjBwAL1i6uK0CcvnZ0ukDE4prOFVv6u1eN7FvymfZq+w4?=
 =?us-ascii?Q?A8GleUvEVds2l63FjVGFK4pJAS1G26GP4EekSBCNC18s9wHJfhVMt+DtoMOi?=
 =?us-ascii?Q?EPeoGavz/akMObyNww5c3MF5aOvrAuUlG1u5PrY/7ZVOzDZwmDjt/fN7ug8B?=
 =?us-ascii?Q?xk7eavTd0ydrYpOKNtOA5MJqI0oQwmzxFCQqO9cvfMmBbi9OM2T0H4SQB+xE?=
 =?us-ascii?Q?R7ph1/cKATLnzzDvAYeu7QTYl2vrp+YwRGcCww/M+CGisID6SCgt8CPTAsvm?=
 =?us-ascii?Q?xGTwULM5BKQeihEDH8eetifiEodNM0e1xHN0LEJjC5bZYaxb8V3aXi1cAcb2?=
 =?us-ascii?Q?X+RP0sPDg+I+t8KkYharGQ2OaKbr7b764wRhoASqlUhc+IeHRwQ9RHct+yGl?=
 =?us-ascii?Q?2zSHK0HUp8+Togy0PmoFbTdSrA4neESdSuL5Mze2eIyiYDh+npCdwwP/btd7?=
 =?us-ascii?Q?9fiCybvl4hmUWkaJG5Ih8ekxf/b3L7uLt2z3lMMRKXm5YICbK22Xp588Lo5Z?=
 =?us-ascii?Q?LesRPGTT8gFvIVcAP2XSTknVi5LEevWuL6UE80nGwPSs87ijBLB8X27RZpB1?=
 =?us-ascii?Q?OWRZ4uOuRAF3lBFqPj5exwznXkXRLMKi1qXWXDEYvMsNuj4yRK4HfYfXy0Kd?=
 =?us-ascii?Q?/BmkO06prKEQYwvVVcv6YMUJp35fP8rP0A736P6oq55iOR1UOjkJc4lG2rDC?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aFzZtn+/hUBJKPhUnPY6tALnHhaEJXZM9i7THvM3zuBlDBZ9IvzW8VgArJbA+Oh7vxMo0RrQ8qFSflogWp0XmIT931txRJrm8IEUSfV+34/i0dshwW17j6TIOP2hDyT5AsScqg8PHoJURmUE5hoS2cOOGYNFWezJIe7Ih7zvQ7xRpgWL0fyz/IfrywWZltM1KvcB5NdmsSI4TgowK7HAGURbF4Q0QMWpq+YY4IUESj8JIk/qTxaaMTjCOe571AB+VW+VhT+urN/jvXvqgnKkjFKeU1XRyFE6TqG8xC0/gednkxtAXCvbEhqlleVcRHOMoYqWgBVHIPSPg3LalEiwBKbEHy4VJ29JghO9wEJhWFnW5Nsvgr87UilYFCUmR3vV5OwNNjO9Y7JfuC52rNAh2nzv6pNSmc1qbkowEe49hC/iB5wVgEsaCOhIuh+Xx8seiaNi0sO+HfhYo17n3WBbjZcyxmgYYipgZj6gjD+BiTe0tENuDq/46Ea6/ebdhW0RoAxiaUBYR6sXKk+MOZRnRLh3aD2MJftcZ7PUCpAYZ4guigPQNXn/rNGDqnTAOrqWy+OhNYMwY5A17GlGLWfs81S5GJ47hDbzhJK0BuR8i6g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b4e89a-5175-4e30-5452-08ddd990945e
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 11:08:35.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgJy66nguuuN148ZF72MSz8UIjNU8vCGcHIENJq104z5hm5XOSGrZW8t8z2VAOlp9NASJHu2LwqzPYISw2hMQON6uvKzYeZH6wQaMDV1YBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEwNyBTYWx0ZWRfXxjfjSHz584SU
 emA6IElgavYVPXwoRKP4QRaFZiN7OUCj4EjU+VL0JogC+d1CKNQLmJmTFGteEe+ZjPHyV+aCUEE
 oEpfLJ8VL8F3WvCK5tNTNV4p00zNVX0H9YCxzw2fG2iDszVeqfymeG1lGVEsFLb5/QICxmjg16D
 GiOJ9uMsAF2W50uu5J0yowxwTrs2Voiv2wxr6/kKhQagnaNpcW5Sh4nRixJ5Tq+JwMq6Ea5LB/y
 t9Cx3DK8LQfFtnIgp6a3bAxt6vW46OsXcZOMLlGtBgeHFAsseLtkGWnnt330Xum/Q4TsJwM44eq
 8WdiGeS7476yOS8sHHAThW1/YqHmnidUynmReOu/oAn6yUm89s56HxDwd+yjAj/FYD45qU9CYIn
 6ZaUMQ00tGevVgUAiFiCMZmzA4Tkv4zkC+HkiIA7a+YkoQd2PdRkfpP/XWzJVeGiWqhac7bx
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689b20b7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=N0P8pPV35ky1C8rZeyAA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: pG6zQBwjiMDilIhf8ioJgAKbjg1Jj0zY
X-Proofpoint-ORIG-GUID: pG6zQBwjiMDilIhf8ioJgAKbjg1Jj0zY

On Tue, Aug 12, 2025 at 12:06:13PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 11, 2025 at 02:21:08PM +0100, Lorenzo Stoakes wrote:
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Well, there's still that problem below. That was a goto unlock and would
> pass through the perf_mmap_account() and atomic_inc(mmap_count), where
> now it does not.

Yep, you're right, damn it.

I managed to miss this one among all the rest, and I was looking very very
carefully bit-by-bit... goes to show just how horrible the code was in teh first
place.

>
> Arguably it should not do the perf_mmap_account(), but lets keep the
> code functionally equivalent for now.
>
> Anyway, I've re-done these two break-out patches in a more fine grained
> fashion and will post a new series in a few.

OK will take a look.

>
> > > ---
> > > V2: Fixup invers condition and add the dropped flags setup back - Lorenzo
> > >     Fixup subject line to match the content
> > > ---
> > >  kernel/events/core.c |  137 +++++++++++++++++++++++++++++----------------------
> > >  1 file changed, 78 insertions(+), 59 deletions(-)
> > >
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -6970,12 +6970,79 @@ static void perf_mmap_account(struct vm_
> > >  	atomic64_add(extra, &vma->vm_mm->pinned_vm);
> > >  }
> > >
> > > +static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
> > > +			 unsigned long nr_pages)
> > > +{
> > > +	long user_extra = nr_pages, extra = 0;
> > > +	struct perf_buffer *rb = event->rb;
> > > +	u64 aux_offset, aux_size;
> > > +	int ret, rb_flags = 0;
> > > +
> > > +	/*
> > > +	 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> > > +	 * mapped, all subsequent mappings should have the same size
> > > +	 * and offset. Must be above the normal perf buffer.
> > > +	 */
> > > +	aux_offset = READ_ONCE(rb->user_page->aux_offset);
> > > +	aux_size = READ_ONCE(rb->user_page->aux_size);
> > > +
> > > +	if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
> > > +		return -EINVAL;
> > > +
> > > +	if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
> > > +		return -EINVAL;
> > > +
> > > +	/* Already mapped with a different offset */
> > > +	if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
> > > +		return -EINVAL;
> > > +
> > > +	if (aux_size != nr_pages * PAGE_SIZE)
> > > +		return -EINVAL;
> > > +
> > > +	/* Already mapped with a different size */
> > > +	if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
> > > +		return -EINVAL;
> > > +
> > > +	if (!is_power_of_2(nr_pages))
> > > +		return -EINVAL;
> > > +
> > > +	/* If this succeeds, subsequent failures have to undo it */
> > > +	if (!atomic_inc_not_zero(&rb->mmap_count))
> > > +		return -EINVAL;
> > > +
> > > +	/* If mapped, attach to it */
> > > +	if (rb_has_aux(rb)) {
> > > +		atomic_inc(&rb->aux_mmap_count);
> > > +		return 0;
>
> here, the return 0 should've been a goto to...

Yeah... I think I had assumed we fixed this up somehow on the return but of
course we can't since we moved the perf_map_account() here (nor could we
differentiate return values).

But I think partly a product of the diff not showing that bit and, despite
checking line-by-line against old version I just about missed this one.

Yeah, this code, this refactor is very much needed!

>
> > > +	}
> > > +
> > > +	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> > > +		atomic_dec(&rb->mmap_count);
> > > +		return -EPERM;
> > > +	}
> > > +
> > > +	if (vma->vm_flags & VM_WRITE)
> > > +		rb_flags |= RING_BUFFER_WRITABLE;
> > > +
> > > +	ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> > > +			   event->attr.aux_watermark, rb_flags);
> > > +	if (ret) {
> > > +		atomic_dec(&rb->mmap_count);
> > > +		return ret;
> > > +	}
> > > +
> > > +	atomic_set(&rb->aux_mmap_count, 1);
> > > +	rb->aux_mmap_locked = extra;
>
> here:
>
> > > +	perf_mmap_account(vma, user_extra, extra);
> > > +	atomic_inc(&event->mmap_count);
> > > +	return 0;
> > > +}

