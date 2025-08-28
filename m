Return-Path: <linux-kernel+bounces-789627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333FCB39863
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DCD3B7A38
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92999283FD0;
	Thu, 28 Aug 2025 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZkZB3g7u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hoyadNB2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14DD27E05A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373757; cv=fail; b=C1WozOMli3xd8mSLJv+BLqS2HbDS9ukSjuFcDBvSXoo3xDgm6oA072I4UPDncjNA7JPo6TACfXLWYSDrdkXYqwdcuyc4FAxaRHEM4o2386Nv6Mc7LyZ0ouFq+v92dWyMqDxAMM/2lKWvjSy4AQ5X3NEIJrH8evqued/0LIIHJQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373757; c=relaxed/simple;
	bh=JDgWb28+JD5c/WTlZJUkGig6PXJk6EQsUN0Ne8YW7as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pL5rvf+rcfjppugSEKjaIIdMId0wYQVPQkg+L4ysiQ6KOXbuDwJ5K0uUZipGz35vW11a57MtJhwM8q5V2ieY8680iyei7TQ292mmJdhURbSsMT7T2TNHAAoFt4FF8VrWXoogUB8IogPmyEHZr25EAZqQymG21BGuclckYf3hh/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZkZB3g7u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hoyadNB2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8twGm015593;
	Thu, 28 Aug 2025 09:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GgPWbEpu8CHhhogbmq
	MzpTPD2evCSK47LVlVolWzQB8=; b=ZkZB3g7ud6AKX+AmLskhIfgltMtcdBkkXI
	OQkisQAxOr5nNZC/pqqpYge/wu3iHk0OHuitbE/hpN49XgEzX9GNumOwZF4FteOQ
	4Y0LcIaFHKcmvGZbxyXuZ7VOyJdCX8vqqmKD3UGEOnZ14iRtpBlgQt/vzJFDN8fg
	AawYIbgcBGcuQQU5BGPI9b78og1L6ozuD2frJGuSYk7Ogc0KlqB8gU7xAVbtDIP2
	UsTWFWCT8ZWMfl43Zi+XceeavZQ2p1gujMnEM7VL1YUTx/evRiycv9amVXmAskKY
	k3grl4b7BnJTMjCCXEbTNeA1DC015VYkpYhKX6RLYGuDcVl7jfxw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt88xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 09:35:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57S820fU019610;
	Thu, 28 Aug 2025 09:35:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43brq5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 09:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nn/K9a3IH1R9dfIZv13E0t8EtLaHmhZXKioB1PsFrZwjFtVBvjyBWD7SeYRpIjKsF8FWyYCClac1Qmix7QvSjv+kZ974PBWxEP5WSNOGqSJwdsxRyVWBxg5UY7py8idrQCa0Ofmb6O85Tym97C+por+q3NtTQw2EFBxRDJPzT2I7MudZn1TgGufofyqFg++mD2Tbd0daPLMW9n8DjbhwO8u/vptNxhVUFEaidXaYTQVpBJR+S7XCWrl4efL7IdIC0BVmINEGXo5qRwocPA1vD1dYrJ7nButWht3R7NZfYp5sFOiLvKZS6fp5iwQKVjNyD0XWDl00yOcYZcltPv79Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgPWbEpu8CHhhogbmqMzpTPD2evCSK47LVlVolWzQB8=;
 b=SyXy9Fu9Q8lUhPjsCoA/chqDuyBvKuh0XuTJf1QIv3ArVKZUx0kLrofn6l/wzrXak+02dMoU1RO8CwCzQoeEIyYmV2g5VWhvSMUu/rCXZjJh9f/LVM90hWUpirqMg3BTMNPfG8LcHIYPYv0RpOhYW7HXCLut7ukeppCgEQBVuG+fpUd8UUrzZ95/uH9KdcUDduJmsi2/A3ABMvd8amg0u2BTUBtKBwa5jPHWn7qveyOntxcPfmFSS07X/HjpZZmAvB/OtrXNN6oc1T+ehCfuXpvMWPQwSXqRyJOJe1fbXeHwiROXkt/qx+7JektG5MujUAX49r5EIaFTwhkxC/wLpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgPWbEpu8CHhhogbmqMzpTPD2evCSK47LVlVolWzQB8=;
 b=hoyadNB2fcAPlt0FMAGDx3MLSUS2uXuTU4U5ztycvbT30u5dJNiOY3pEF2SzPrYzFcm6nkqimcvWOqYtjWbhm/s+F19l6dIPTYA/q1jMwcBDnsDvXFXDlItI0sN7rpnnVXPLtIOZAnaijTixAU6amRUmbSFOKdVZScaP/GvfC+s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6115.namprd10.prod.outlook.com (2603:10b6:208:3ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 09:35:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 09:35:10 +0000
Date: Thu, 28 Aug 2025 10:35:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, shikemeng@huaweicloud.com, kasong@tencent.com,
        nphamcs@gmail.com, bhe@redhat.com, chrisl@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] huge_mm.h: disallow is_huge_zero_folio(NULL)
Message-ID: <da6bd1ed-3c35-4f5d-b667-a21a47585fb0@lucifer.local>
References: <0de24b30-70ad-498f-9eac-01596c8713df@redhat.com>
 <20250828084820.570118-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828084820.570118-1-max.kellermann@ionos.com>
X-ClientProxiedBy: GV3PEPF00007A86.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::618) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 2898cf4d-f036-42d1-0f36-08dde6162e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KSQZGMAPyl3wOHbSRIsaMBFkLcXFZAtEIqObuxJSh5QfNyle1HOHv6R4kjOn?=
 =?us-ascii?Q?k571qihDD6KztRqSrSsTTDFRcwfagBoUv5iHet66jsvbx+4q+WXfuG8Lbkq0?=
 =?us-ascii?Q?q+SBbDC8q8r8hEDM1DuF+gZxF5wfN03/Guv43eyy0/t6r8BJftkMQ3NiBbRV?=
 =?us-ascii?Q?VPxFFzrW2tKBmhDHDhALf2TE2PBYB4LThxYY011G8pz6+Q6CS6qMmraTOknz?=
 =?us-ascii?Q?VtRJ3UeKO7nbEBaGWEICYk7JQh5Q0e9x2HYkATdmikP5Ug/f5pF85OoRe9RI?=
 =?us-ascii?Q?T385VamBrkxcsAfGFSSTPfaFYoXvSiYRKuqgQXX8NAIRPL0fTy0gIYeAzYlr?=
 =?us-ascii?Q?mGCStOYXF7fxv30dNK8/DI+kv+4MW9sc0ZC9NHVTjWoK6MfZwDs0Aq8l6XM+?=
 =?us-ascii?Q?sf0TjBKmmKSFrVFJtFjSgE+neiNL+fhPzIBZloX1GB92BGBaEn9F77fdvm50?=
 =?us-ascii?Q?akp2BLOCsHl/5P1TnLkBR2kACu8INkclpeH1NYPEsvEavZ4u7MzBSZ3uREmy?=
 =?us-ascii?Q?hvL2BFnqInz4xkGm72ScGEnSoxQwoTvcnCLj76BH90KsSXF/0q0usjouDCpl?=
 =?us-ascii?Q?OAdKoUFB6TiLb8zgGkm65v5OpWnirCm9EafVTbOb1vwoZqSPUsYj8+Yt4sOv?=
 =?us-ascii?Q?obeYV/Z7XpEegFTiScgDtkRYAZp6/yLpFkw8lTYhSjH2qq5Tr40VoSvPIcdb?=
 =?us-ascii?Q?YeAIthvzlBp9XBI/EYlG+BGoDLC49uBmJt2mApk6fjLOC7QysGaCGpucgnKY?=
 =?us-ascii?Q?Uqo7jukgNtgoOKd1TXDDz16pu8Fq/DD/jOKsZtz4X02V2KKi6jWLWFiFrKVy?=
 =?us-ascii?Q?27oeoHdTYVGTOEtREdpccx0U8ZuIwRtLGcT7FjguV23302nnyp2QRB/NwfBL?=
 =?us-ascii?Q?kFv4eT75FWv8kxAVJdt8eKr8NsaSUOMQtwtAS+oVLjw1lFnRSYPtLDzhHo57?=
 =?us-ascii?Q?fMKbKcmPn+ZmWiqDQ923tvYeEs+xDI6CvLgLV/jVoJ1If3LFo+R6EH9k9EqR?=
 =?us-ascii?Q?vifHon/AWtt89mHRTkYoLNN6Hw8tb0o1bVrjeuagovKjdNgsQCs9InrDTnlh?=
 =?us-ascii?Q?PJP4h8Ro6qEogRlzMYC4DqZpza7qhYW12GvumI8UHq9q9F4gg9pJ03cvABL4?=
 =?us-ascii?Q?HwFMCeIOQJ4P6++J7GrUf6YCh6XqT+UTsMjHc+3F2xeoIy9z3kyu9RxkZ/f8?=
 =?us-ascii?Q?RlpTK/Z7+Zq8uJSrn1VSwWLUBSr63YBw1aPrjw3tFTidBsiXAbRFmPm+5emf?=
 =?us-ascii?Q?cpHSQ7UEpCylW+2RBIJ2FOtJf8bwpx8sc2LW2gFREYk/Jj8bmURZFRUSbfz2?=
 =?us-ascii?Q?9akOeSHX7zd1gDSHEIT1nPJFpQ+Oxo8VC1gz+kSrpNRaH7lMrZDeDNrpfaG9?=
 =?us-ascii?Q?NN68b4XepAcRBeLg+UwQsGdF2O4mUcqxwC8rogFoyx9XNSG06puuv3igj30d?=
 =?us-ascii?Q?yDc8FMfHU+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yUt90S7MkI4XzSi2EBHOHwyWcx7Gk+1JKp4s3qhXtOI+uQk1r0sIhl8FNoNI?=
 =?us-ascii?Q?VZOhmwJegmAykEFdobZoV0+wU//fexcM8hLz/ckfuoVupMtEniCMBzBWOvW+?=
 =?us-ascii?Q?9OWVpU8SYnhb2uG3HGhzJgZIR5wbRHsDhq59LJjOdSbbRsa1E+0cYTJPn4OW?=
 =?us-ascii?Q?bfeWn9rTGG8mZ8VKRs91K/eYYsTUu771ILaS0IZ+hV9KqDBP2sr/rF8rqddK?=
 =?us-ascii?Q?2y4cDjTAr6XlZiNpG2JOde5g6/YbDe0vuHqUinfOwrsYO6L57MohNb5Wyq3p?=
 =?us-ascii?Q?JIr5249VGFDSqeN7i5XY5+l3WobgXXjfLRmpDf1oUJ5liTDz+pLDgAVZvr44?=
 =?us-ascii?Q?A6V6cvY2du8pCsbT1TlYTIGSOv+/Ce+MjSqSEQ0lHv8UTRlZsYImJy2C8X3l?=
 =?us-ascii?Q?YJqJnpjyB+S0gaoRc4M2VCe12GwtYnAAJNMfaO1Z6PfZbZDUZ7Tegg60blkv?=
 =?us-ascii?Q?LTScbM19k3V46KIM4QZuMwNSxoqz9pQDvezxBVZlogM++4yvVAvMasARdXS5?=
 =?us-ascii?Q?EozlxiT81b3PdYZrPd0fl1D6+5RFyw6RToIXQpekVse1rKDb3cN4YR7PyR1o?=
 =?us-ascii?Q?b5Jy7gAE3F692Ihos4r8J123FLdprfjFGnSf2rqXnGVcfLyuvbKQkk90JdC5?=
 =?us-ascii?Q?fJt4yyqmQS8BrAGDvdauEOLKaTtNDdGbInFGRdzRt+5bdr8zfZD0rKxYmkWo?=
 =?us-ascii?Q?fbu2zm08iDWylD+uSQqqA39/wb2uhJARZ5WeuYHR7B40ufZtUZpUE8o1+gZX?=
 =?us-ascii?Q?USZyF4H70RVl4hwBP8AoKr/SjsiDbl2Xr29UA4OAdkiDYEgmyXmCirvhnWVd?=
 =?us-ascii?Q?ko7mgG+VGVLQRIb21kXEiOiTJ/qzW2/zEmnc9Jy/ig/EFQUeddpKEj8mOhF9?=
 =?us-ascii?Q?68LKSD7TP9Zld65oGf0DVdJYkBfQq6lb8BdrocQRkjj0bMq0+rV1d7dGMkLT?=
 =?us-ascii?Q?nmpk0NlBo0pOcUJ04UvKnKj0SmnLiehkWV+yMr9m2IgaYXrWXvg7iIf/slC2?=
 =?us-ascii?Q?g0kIrfO05RB2U4AUEF/NpYcQKxEy+ChmZay5dzepR3ClzMt7QLmLPQrAf0Ph?=
 =?us-ascii?Q?iNCDlsBv9cEU3f7ZVfk59p1wfOzceInwivwfO7PHxHWmkBz2f9UFdE3CvuL5?=
 =?us-ascii?Q?deCWjnUPr/6YraibGWE8uIsrc4PrMVEi0Cw/ZGWurcw+3P9GHspeXC7tyLTL?=
 =?us-ascii?Q?szLMfPv/0dAPpO3OPN/fJCDgWaIN7hh9zSZgLu6aFF78rV/84jpxofWPYDUy?=
 =?us-ascii?Q?ymzTAR06t1Vhcr2KeBDIKwbK/O8AB5T+G8h4WUyioR3JvWXs9nhzyhtNMk6D?=
 =?us-ascii?Q?cbF7cvSHWxKmh+20l3VvMHgirRRWXF6Ui3Q282Waz8rshWXlJs97pVws4rqH?=
 =?us-ascii?Q?8Gd/7OpW72aOwnA+RhmhTUd334ButoFQKyC2uKYUaiWiA+2GZhcKuvnbNeIG?=
 =?us-ascii?Q?QXnWlUOYO9aWT/6Kf50RbGRNkv0OT39fysmVaOvkHoTUbCr3Ij+JVps0/1Yn?=
 =?us-ascii?Q?PVFRr/jcBveoVONEsXpf0LfZyGNJpIhhgkTA9bOCod0vOJrmHVkrB+xua5tq?=
 =?us-ascii?Q?XGnn6V4lmj4a9uvLopBGhE59op1GMbSK0ntyPPa533oEtqf3IpSCyhhZ5GDu?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GdMeLLO6oFtT9/7mCGduq36OxeUhGJpfAaubG6q2ro0piGgfsci8mJgcYDxfbqiVoNDe32DoCpx4L38V0kuLhVnwxNboYHFUJ6QgDdIzffoWJy04fkQzpa4apGwa7Xvikj2WkWcHfjJ+YWR8kHRMXRbS0UvE6/ujfscJ9dQTVryyYF+rOOS06fjIex5av6G373Nm1NAtvk+dv0uWQgORpa+ltb/+KvrFcYUhFFuxLODC7xTdmWQ/4h6fuCVuB2F/M///HOL6S/nIZB/YjoLoqqdrYF6WRDxGRUF5XZ9QnWJaWkFcfpKVu2Bz1GEzXDsUQ31KTPoIy92vKVN5HR0HlmuN+HSiuRtzhknpS8IocQ7gffhiZ/jPDIdAgTjZGuVMyFF20dfKQowWVluT4dEyIDTu9yiXtXp/JrLkJF4v9rPHCrSTfmIYwPhGjYT2O179Otg0xmy/E7max6WNgcSxrTxOyyNBVx/2M2g0cPuI8pKLthdanzGdPWvRzarEl13n5FuDvlnH776ukHHcktrXAgX6JMBRUGNOLI2iffMUV81i69hUrOX593R8brUuyxsDFwqo1uQ2DPdX1Ncxs021olT70md2wbc85q79u5ih42o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2898cf4d-f036-42d1-0f36-08dde6162e7e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:35:10.0823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOwLKBLulvJMR6aqmfx7OlZLpdrMDA5qEDRr/EUJYUpoPwxK1G2aLRRdKQajnnrHG/ZiirWRhTp9d0RLbkSoprokM9AEaUAsZ99Y2bA6jcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280079
X-Proofpoint-ORIG-GUID: oyQwHWy0gAo-qgTopSbSV3NP1U1NXfRA
X-Proofpoint-GUID: oyQwHWy0gAo-qgTopSbSV3NP1U1NXfRA
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68b022d6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=yPCof4ZbAAAA:8
 a=IPzSgeYvqR1nT-VwbOEA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfXxYqtsl0GAy50
 RESwmLR6RdNOMQzzXTnw4eBXFu+TrhQwYNy3hRRudfxfWncN92Ra5GsQ7eUTKPul9wG2iY/GkB5
 1ycpe5l5JeB4KmYOJQ7hKkQCVfuAnJMY2ug5+7hSoRDBWW8uutn3LlvdwNfGxeQR52zYnXJ4TWN
 BRt1DECcTbHUeJfOx/cnD/Jxh+Wbf1eEdN8iD87/dUZr3PRGbraYerOU5xQpFSKARHvSqYIdtv+
 2LBAHPk5ZUwHj2i1pY73g6qwmzShyKF4HQvHnIDxXojN6dbr0W/hdGSCNGXlINPgmrViBcrv17F
 tY9bJP0hvILP6l4ZchmZ7LFsGsT1CzqgFuwyGJ6AykthgBItSOnhxJHp/AkDGIXuXRbgRNd/Dqs
 Oh9ycnBd

Please don't send this in reply to previous versions, just send as a
separate mail :) (yes email for dev sucks and there's a bunch of weird
nuances so totally understandable!)

Hopefully Andrew will pick this up regardless.

On Thu, Aug 28, 2025 at 10:48:20AM +0200, Max Kellermann wrote:
> Calling is_huge_zero_folio(NULL) should not be legal - it makes no
> sense, and a different (theoretical) implementation may dereference
> the pointer.  But currently, lacking any explicit documentation, this
> call is possible.
>
> But if somebody really passes NULL, the function should not return
> true - this isn't the huge zero folio after all!  However, if the
> `huge_zero_folio` hasn't been allocated yet, it's NULL, and
> is_huge_zero_folio(NULL) just happens to return true, which is a lie.
>
> This weird side effect prevented me from reproducing a kernel crash
> that occurred when the elements of a folio_batch were NULL - since
> folios_put_refs() skips huge zero folios, this sometimes causes a
> crash, but sometimes does not.  For debugging, it is better to reveal
> such bugs reliably and not hide them behind random preconditions like
> "has the huge zero folio already been created?"
>
> To improve detection of such bugs, David Hildenbrand suggested adding
> a VM_WARN_ON_ONCE().
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> v1->v2: using VM_WARN_ON_ONCE() instead of checking huge_zero_folio
> v2->v3: use "!" to check NULL; removed the #include

Putting the history in is great though thanks! :)

> ---
>  include/linux/huge_mm.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7748489fde1b..96ac47603d97 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -479,6 +479,8 @@ extern unsigned long huge_zero_pfn;
>
>  static inline bool is_huge_zero_folio(const struct folio *folio)
>  {
> +	VM_WARN_ON_ONCE(!folio);
> +
>  	return READ_ONCE(huge_zero_folio) == folio;
>  }
>
> --
> 2.47.2
>

