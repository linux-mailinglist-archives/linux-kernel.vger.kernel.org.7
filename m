Return-Path: <linux-kernel+bounces-740198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E063EB0D146
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610D41AA0F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8519DF5F;
	Tue, 22 Jul 2025 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XPQi2KkP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N+A8qHa2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019DF1DF990;
	Tue, 22 Jul 2025 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753162476; cv=fail; b=rAsPUgF7Ij/bCVkUNBzJT1CFDnYVhCGkDQDaLx1iO2cwbowZZjFDllpUwM8C5HM0QkOxJgmaTnlzHtyEsW1i3eP9PmCqgn9dwOms+UP4NVkZhCqz82B2tyTWYWPPlpZPg8RMZid9zA4ZhYfqVHoZxjfOabJrPC/7wnuQLILl/MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753162476; c=relaxed/simple;
	bh=jLm0s52QepZ3mj33p8tLhi8f5wU686VB4YwFJQwclSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=orqtFZzvwZ4KwHAOb9nZzKUeQITjorXTFYC7txzFxLy1ANRwG3R9Iptfz/D7Q4oWypqqQx72glc6zDgMd8qSE6QfJLpCG9N4VF5nBT7dUnB8nUo6S+E7Z7xPpZKeyQMsP7oPmMklkyJ6zy3SAe4wd6mrST1i+l5WCTT5FEkYYE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XPQi2KkP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N+A8qHa2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TBI0006861;
	Tue, 22 Jul 2025 05:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=deQOS4SaEB46MkWotZ
	q47JCA8+2GJ7EaRVQNCKoPuow=; b=XPQi2KkPNFljWzEGqNKp2hivwgVOUION45
	qtqCLNziJilOz16yDnFrUGLsAlMgdbqi/VFi2ESfESO7PlIXMsR81nMFhvYndnJM
	WZCpAAuDMhR3LBWIPU3EDNd+L4kJvUXlijXnV03QhUJj/2Sd736XEPskdS7Lm9qq
	5g/GGMD18XpA2Ilryhvmx5TR2YR7RR0/w6m1BMwI53nMHB5W3EjqVV+UrwnPoWCf
	QYDo8LSHcKcmvjzjMoBx6EYvtzQBMzhAIgk2pMkCYIxe4wfC+3UqJQ9njIGBXdAf
	mAtmCIa5YPS3ITHT8DSW21nXkTJUq2hepzyPl36P2hAdYnzr/FeA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2ca4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 05:34:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56M55xFf005773;
	Tue, 22 Jul 2025 05:34:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t8vn6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 05:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzeWxSkeDN64g38kNUcvukMo3i2l0Ijrt2hUZE1FwvAu+loEJ6cK3P4O1xbUSdN6aPj8y7Rngxd1B6wz4GesFOlx35GWxXhqchWjSY5weIsDNZg0g2V+X/yZM8zBrErJ8idFkE36q+/pLHb9HOd8wWovVut7l1rORkFRIgY9YlwLIJ7joQTg+gwgPpZKN3o/8abMrWbHhre0Wm5VYxupbDFCdCrEnzJKnPdQsEp8O/40iP/ywsNIDJB5HIoOzi+XxApuCJasHbfHkxCmX9v3m9Ao2NN9P1M7RT1Jm/nx/zoTSNq3MflqdJDyK2Ou4paFjJ92Hs6EXp9Od/bqmbfWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deQOS4SaEB46MkWotZq47JCA8+2GJ7EaRVQNCKoPuow=;
 b=oguASplOrf+cRhiTXVFXs3a8WwHabrxvsbNuW0W9vme50+FQzzDkuJmmATT2x8Goab+177ud5/AbgkeYL+mAmyEZdctyUHuLrps8budilawITSaAt5GDADF0YJxXJgb9rfa2R6dEOWgtKbOHHpGJcWEtSAdTb7vZNx/mhiCSZXIDEHAmbHT3672qDu2mymUYR5KMP5g+45ODabWvwbc8rCjD/F0KiAn3EZGF1nWrEUgw8TkBWNQUKfuuM8ptYOz3/SJSYqPwfNoZIRE0HfFtvkXbCMQEkYXhdgfKAs/aNSq8x21ENMJu3CDT+9lCfduCcgCO4a+uoQSohP7NDvCuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deQOS4SaEB46MkWotZq47JCA8+2GJ7EaRVQNCKoPuow=;
 b=N+A8qHa2EUtlmiRGMa+wXIHAX0i5cBDH5Nwzig8RfpAqo2WIpjeUe0T9kpgA6xjMgA4L3wEY+H51peA3BxhALr/VMcew7NiQeU0deHskKoRqBAvB8MEjo5U/QGjT9DeSZ4H+uE2eczqobauDYR4HK0d3eMoLpDmTjjBhkpFpTBo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA0PR10MB6426.namprd10.prod.outlook.com (2603:10b6:806:2c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 05:34:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 05:34:11 +0000
Date: Tue, 22 Jul 2025 06:34:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: update THP documentation to clarify sysfs "never"
 setting
Message-ID: <d54d1dfb-f06d-4979-983b-73998f05867e@lucifer.local>
References: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P265CA0509.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA0PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f86af4d-2432-4748-6734-08ddc8e162de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wx6zdqOtip2YB4OQvrwYo6yqtxoL2jk6DPxjtRj/PtzeOjIkdaq76G/aZ4uz?=
 =?us-ascii?Q?I5LPBHjknV+2mLAruK7CD+l0e91JWkdXQ29x1VXTcfZkHprMt4PLfFrUxsLj?=
 =?us-ascii?Q?GD+Bss9AXPKWG0j+RJK3/Wvv02+4XMHe36CH9vzwve1NSzFWiAqjA8aT8WOP?=
 =?us-ascii?Q?+cfGMkcAZtoKz2yQIRMLxh74GxzKGHGgccbOpA8zQundIEUqkgX7zjlGDrWQ?=
 =?us-ascii?Q?jazaVT4DnTPXYQrkToO8gt6i3qovsZb10DJjDTI+tOpT03N1djNI14AyWcdW?=
 =?us-ascii?Q?lacC/S6J1d8HdTDpwj6OGI9t/02JzqOFBqyAT4samVO9NsSZAKj7zpFw9daR?=
 =?us-ascii?Q?SYR6CPixIsQBP536HqU9KoTnca2EeKv36HdrSVqhM60TldxrYhje2NeByi2q?=
 =?us-ascii?Q?P4+Te0udqQUDrRozHcoRg9jV4v9lvVeO4c631j8cWKVldwgzT983bcv4Uxz0?=
 =?us-ascii?Q?2qA15rbw53rMMAb1A0EoKCAPQzQRYPsjStbKJbt8c8f5NoxZ34XwKsZdo83C?=
 =?us-ascii?Q?vVs1ONOwncgbeDoEQhs52fxnB2RQcChU7sX9ecE2KYxPayviaRbfhApq1QiP?=
 =?us-ascii?Q?wnnWT3dsBg5SINk5wIBlDfd9rTQGKSBPl9z67kHEfwzBv14sPCxV/YoI9OY/?=
 =?us-ascii?Q?xItHeF4Zy9UDBvbDpMqc0eXL4/VnaEE+BD7dkbcTTA1E2kUoTixxJ1jpbR0G?=
 =?us-ascii?Q?HSmssE+BkOWKoZ/Q5ceaxR3fh5FHnENtKbFOdJCv2ZoAC50b38uM9NljEhx1?=
 =?us-ascii?Q?ZRV7kFLMtag2fe7MskHKdts3daAEcTt3QVflntCPHFNDFhk3AcTzEdeyycs0?=
 =?us-ascii?Q?D1Isdei9wJVnexTL3qyGEM6+Z5n6Q3yxJ/plohDdFtFOL1U6QbRlZ087tARV?=
 =?us-ascii?Q?sbhdbpJg+5E3M1UFQ5XqHoZV6zT2nFL1HEP0RS/AefWLZLaWb++ZdpoaWpZH?=
 =?us-ascii?Q?4d+XcPF/+hRWAPM9fpXuYCgS6h/Ki4fRGXD6EdylEuDIa8bcN3HvJiC2QGq0?=
 =?us-ascii?Q?9DeV0IaM9KTadVhoN0y2QS/8tiKZvJRi+sruAmNSb/I85PVy4pTcdPDv7hVr?=
 =?us-ascii?Q?/XhkYwXyE9VAsMk/GquHcLA9FxRtC2De/NxkV+2iFab5pUK/M2Z3/kDGxdeN?=
 =?us-ascii?Q?27PpsVTVwnGPK106d2dCG9ht1vtGZ+/tUTxSTQYojuPPskqrDd4sfcM4FJAd?=
 =?us-ascii?Q?5Z7+4GlAszyBzAjHSz+LLAJhiaMCRRUGadAjM4MA9aIpghjbRXr9IPGEM10O?=
 =?us-ascii?Q?icQPVU8KKJb9DBFM/iX16/enmo//ubjTlugDh2BiEdmU4bT4kKGPfryN6xfX?=
 =?us-ascii?Q?OenP383eWtHQRrx/2oBPpSf0+spCbNmHb9CHzQvM94iLV9u9F3KExSHnRHsz?=
 =?us-ascii?Q?J4xWrFzzUDKWsCMagiVKiqAzFPEM1sComaIQYbfE9s1LDbCzWLf6hfI3Cz4e?=
 =?us-ascii?Q?k9ppMWpcJW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZAOga4WVet1zv7YRdq9FUjLT9kE0cknliSuceO49DlhY9S8TLZ2eApkpvQ+7?=
 =?us-ascii?Q?NrNNfDVsYlfOSmzIde/wqy+hbPCHKuza+LddI+wdOdtomG0uWm9GbkuFcs8T?=
 =?us-ascii?Q?ZjhasePsT1KLCt42uYov6dbl3PMSSo0O8ps48mtPjUCi+YSV3xssvN5n/Ags?=
 =?us-ascii?Q?Acbl2jpfy+7qvBEUwxEumMd88U6Sk0WLJKOsxLY+LgXlPVYzWyeyfj4/8wCj?=
 =?us-ascii?Q?RzV4yPieIeBqn7UWKttwPOwa6uM/ROrEQipbXgvdDdDyz/FqJBUci2JZeLWI?=
 =?us-ascii?Q?cYUUwW6Qtsk/zh5NzCLGtHmR6BqSA+TzsmCmd48uENodHQLGMDMho60Czhni?=
 =?us-ascii?Q?Lshnjd8JQLDSXO5u3xcc1aJ+W0bmfwohKwb6yBlqApjdjjNgfagyqtEv1VzK?=
 =?us-ascii?Q?yDGJlsnJyDVVHpLbAs8u9GVRv6gPkfo/EMHAthyjUKkyVMvFz+APTwZ1i9+H?=
 =?us-ascii?Q?7GGcxfcKzeUIJ6yZ3fuKBiqp/OY9IkiC9EPeF0DeUdzVoAwlEJbL2dz6Rxay?=
 =?us-ascii?Q?/QnOf4Q+O8YsPpI+qdtTU69Q4zx9gfXTewmAP+8SGtVEod79XHfCjn04VW4J?=
 =?us-ascii?Q?7xhCDSN30r6+LrDKfBRMhoTS1LNxT12RQYB24EcIJgSJG6Ej+j1i4pd7D9R0?=
 =?us-ascii?Q?wqhapkjYs+D7Voaba326UyfDBVJT/sxC0Ws5e/wO89P3H+/ve0qrju/ZcZY3?=
 =?us-ascii?Q?gp4kHZHCbBH5gJX3oyYEVewxA5CLA/L4f/mXjBelV+cXbX/cv3ic0ZueBMB9?=
 =?us-ascii?Q?BfXfnovFvUfjdVJ7NIlR/rBKOCr4rUoRBt1BdJ1/G18GMn5lqodIqcqN5bmy?=
 =?us-ascii?Q?1yN5Sc1FG+KoSHNwfJYJmJH0M9+L8rz4+1Fy8EgFJI+5y1QBMEhlBetoNiSO?=
 =?us-ascii?Q?GGrPismUG3AdCW88UmJj1ga/55mJcrrUqxOOaQcdHFwBayaIca0sY4lLfxL1?=
 =?us-ascii?Q?/+qDPwgUG252q7NxxYDNAnWL97Kt2BCFkkj26feUoPKIrWt1Q1eUE2kD07I2?=
 =?us-ascii?Q?oTTydnvUOiftq/Qvq0WXSkb7Nzzg0NAblLY8uWqJEk/bqEdbKzA41xgmAwGz?=
 =?us-ascii?Q?HYrGTlmbRGtMOpIE360BqtFx6CalDwDZdq4c1a+35w2uM+hODQdAmauRwchY?=
 =?us-ascii?Q?t3Dhz7PQQLebosow+9KTHJMN9FMak9Gtf9EV3JADcTQX7ciUcQrPIGiqeOsd?=
 =?us-ascii?Q?xuAyuBMQ++VBTxbPDjyDyi8f5ueF6xCGqBgQSQxti9Vz7Pp/sbUCXQ2ihZo5?=
 =?us-ascii?Q?a2A+O6w/9y/hvNe0nBqFZjwvS/XcL5wdIxK9Lc5zA8uEG3+qQBirDR1lERQW?=
 =?us-ascii?Q?QpLfDtIcfKry86lcnbwHY6pXCarhJLzkXQmOtmOgKh3FTf2rPvJKKxP7Yqki?=
 =?us-ascii?Q?yNtUICeF+HhhQiviLmw/acumn2RPWjQZlcvilJb5bV/9JjbSyyAK0ff93c0N?=
 =?us-ascii?Q?21NywSN8QtNe3PW7Ya6q2iWwGFpywzrSUPPc/cSbgKqAy4ht0U8pYGVDbfAb?=
 =?us-ascii?Q?94no9plG4Az08soVt1pXxVI4L1WBN2++yg1it6ASZjosXzpPORkF6g5Y1C45?=
 =?us-ascii?Q?izxKKioP4ugCV2NGVAC1KRLoIycqCCARX/6pjWjj8rLHmxCPLyS0LwROO3OH?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dZW48/DneDGoJK5PCBy+OTB/3wcKvpYXwkH/eXU0s8s7VzTlcFYDDxcUO2zgBU8kbafAi5KhWJRPvkCe3E/CKhvLMGlF1jlmad+Rd9tUEgKd0f52+DSv+vLt+K23wyW1jgbwTaFeReKX6REtUVOX23Xt6WW21d+S9tQobQP3oG9f/B6oJ8O6o7ufyrNb8NUji9VJTZBd7srusqMemsorNuqAH6cN4RLtLoyK7F8uFNc+p+uYe1dxkKr+Yt4/OL/73tX+wnxZUb/t2252hJYaViYja9TRro4xx4ddp5uGzBDOCfa2W7g82/hDlIStPHL9NellA8DFIpjBf9k2N8t6tDnjotPRpztgDKKdsKwTmI+5cyu5k7HCG4vq5sUnSG0nOWsKkORZHApbbKrbZ/XODGBvHzfvlF0Q/75UsdAiU2BnylZbufp2PQVdeDm66Dx9Yida7RWnkzrFYf8dYpjm45KKGcThprtcwp03G+wW4+oZdf3PeuZcl1mwaLqKSCShd6U7PeuLgdhcs51AHhanEV5CwZc2Vjc61pavCqI/8hYK1Z6sx0dSFJOieCHGGWoBhBxV7HS8kYbVsCgfDbb/JQVbQJ/w0Qc9/xeDdOfanMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f86af4d-2432-4748-6734-08ddc8e162de
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 05:34:10.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbAcpwXc+GLAYOLCJ7b4WBVzFY8PptnPrcQ+I+tW6hx64nntNocrBELy7zHwTcB+mEwRljQGL+durLqU/i7O6fGBp+OjUZ9QG4AdSaowois=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220043
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687f22d8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=EHzQ89n7m7yOI5Nl3u0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: UbnMypLzsQ4qPWXtrsBcedpDVCyqxEdY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA0MyBTYWx0ZWRfX4RnO+tMowvTB
 LxSYTh9Muj/4AOUIRFZwlY5GxnH4UF+wxi8j3pVP0//RYFiGUkOj4qOFYNe3LmpYc+QjLp8mWTi
 Nwxl1ImAuP0R/vzixQ8CtktDw4jokEiZJDSX8K/+hlJYocA+kiDkZn44opgwIV62x9V/MXuEyuA
 SJzPmOMjafUwrQt2stSgg5pzPcRaa2QHMo+KfKNCWCpwo4p1+Glwr65WavBbwpiAbiqCl4sW8VJ
 quEKWhBjGBAESMw17AIzpBP6iX8APrRmFTbSB/jS5dTTmTqSp/FoC31OubNzhDhgG5fFOAXenDq
 F606B3rRrcf6T/AjsKyuQOdhOnwSpmEu/NT9UDlLPLStKafh2IEHjZuqRYQSu6RO9zBmkkppZd6
 OuchIvThahikdFp7WnBqL2qOwT1wrKDjzI3ss++kI72dTsb+rtnBqZ1Z/O3YszaYqFF9sfrJ
X-Proofpoint-ORIG-GUID: UbnMypLzsQ4qPWXtrsBcedpDVCyqxEdY

Hi Andrew,

Could you apply this fix-patch? It adds the caveat regarding MADV_COLLAPSE in a
couple other places whwere the sysfs 'never' mode is mentioned.

Thanks, Lorenzo

----8<----
From 7c0bdda6a633bc38e7d5a3b0acf2cef7bdc961af Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 22 Jul 2025 06:32:18 +0100
Subject: [PATCH] docs: update admin guide transhuge page to mention
 MADV_COLLAPSE everywhere

We previously missed a couple places where the 'never' mode was described,
put the caveat regarding MADV_COLLAPSE in these locations also.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 182519197ef7..370fba113460 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -385,7 +385,9 @@ always
     Attempt to allocate huge pages every time we need a new page;

 never
-    Do not allocate huge pages;
+    Do not allocate huge pages. Note that ``madvise(..., MADV_COLLAPSE)``
+    can still cause transparent huge pages to be obtained even if this mode
+    is specified everywhere;

 within_size
     Only allocate huge page if it will be fully within i_size.
@@ -441,7 +443,9 @@ inherit
     have enabled="inherit" and all other hugepage sizes have enabled="never";

 never
-    Do not allocate <size> huge pages;
+    Do not allocate <size> huge pages. Note that ``madvise(...,
+    MADV_COLLAPSE)`` can still cause transparent huge pages to be obtained
+    even if this mode is specified everywhere;

 within_size
     Only allocate <size> huge page if it will be fully within i_size.
--
2.50.1

