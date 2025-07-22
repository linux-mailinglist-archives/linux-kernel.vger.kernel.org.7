Return-Path: <linux-kernel+bounces-740189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 400A5B0D131
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555643BC396
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10D428C5B3;
	Tue, 22 Jul 2025 05:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="REyE54Kr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mVLhgs+t"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B0728AAE3;
	Tue, 22 Jul 2025 05:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753161899; cv=fail; b=iSVaWOfBL2/swIlo/2tY5po2BFeilyenzqpI/WPTPlsk6+jWhUpT8aEM3zp4mPXGyb5jV59/RIx0oSZZjsOzGSDgzLo8ADC1fYyUDnY4Cmm5h9b8PHrC4AtFcXIyd3bUP06OZbORQfdt15ZqniUylfgkykYmgPHSR/qlCIJbv9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753161899; c=relaxed/simple;
	bh=IODyr/7HGOjvWvlxjwpoeCdngkPAacN7UdyDSz8FCe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XFpup4yawdxf/O8PV0LYkdLoj95yjSobRKlyi3ocim7iHy9jXpRvbQnvw4J8YQrsFlOrSfXdTXDafQDMXN5pEcD3lxYqXnFft0CGKoeJSfrl5I4+aR87eGdJ+4XRbo3OKiLzu2t9hxr0PgvC4MYioOjY6I8tYb7rU/2US7rA3eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=REyE54Kr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mVLhgs+t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M1CaCV020462;
	Tue, 22 Jul 2025 05:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fSll+XMQ/GGC6cjBFnOm4HcuTM7fDHStEiAL050gr9s=; b=
	REyE54Kr6E5WJUwXSqkcVojDOdEyA9G2sk0KtoRShRRBRPfM4/DMolxQBBv4QW3b
	+eqY6PzSh0jtjh3G3w6qcngi7+vA3EdmULLjoyuDZCUZQbzb8mfrKKOoracZ2R+H
	ISJWYddeoywgmkTbHqTJBSRyVVnGl0Usm269fEbGwqT0D3+/mb+LEO/xm8m4Fdsr
	DCzMunlJ5dH5+pTDCzz0RQ4yO+dVc2mJkvPapy2EZ8KWFXzRy/yGvz8r8emslw3+
	WPfOwv0gS1JE400vyqqtxRKeGfi2lh8zZ8UjF+6xFrWOp/AeeaddyEuZfkj9V3p/
	4K4ada/fB7x6VlV9WZPYUA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 480576m8tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 05:24:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56M49hPs005752;
	Tue, 22 Jul 2025 05:24:40 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013056.outbound.protection.outlook.com [52.101.44.56])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t8vdhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 05:24:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgyBc8fZe9cttxXqenadWZQsM6NRR97bWs6YCTkT0mkxEmNnZlp8iCfxPhbVPVw6vSHoYfO//AAHwtJfHkoTNYlrLoNRU5eqs10WpcugbI+Ht0gjKFLHkzSgnwL5hDYHb054bU3KVNWHS+tyC7FPCMMawae+aCmJGy/KIJCMePRIamIHuwGzgWQkt9N17/Yd5p/SpoVSti6IS+vsfPJNk1ou1C9lqcxw60wWA8fReZQ2JysdmS9KGwqBEUmNh81eE3dRNDFfBcI7i2Ni5LWWLyPawayrZT0EiavED+p0bT1lFObRrTWrHDHGuIzVxrnlasajKA1ftTKoOmVx+MWYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSll+XMQ/GGC6cjBFnOm4HcuTM7fDHStEiAL050gr9s=;
 b=gWZtT2R/2J7FykPu673g4w+DomjYlIvC6RvySl1+gWyFjHPE0llhuc5IUyqPb2LiOe/GB7jfsKs7/K9wemzW56e6BYIW30OnPf3kWTDxh3XnmLHbY3zLs9wBBaVrB0n1zaAHkRm2e7722mUzPqeGeKZX3nG22jG7UIQxi29IVSS+14KIjF4Nlb+RH1Df7f6AhWvHhKvFQk633uI4vinRRlOjbixzgrpA/Uzz9mcueRQj03MLkeRjx3ptssA8lqDuBIvP5GuafxGW4G0uVi6nX80mWxCxtmXNJtWBe+ZpdNrokx3QOy/NjNZj354Jr1reshVheHLd5n8ltdBpzsu9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSll+XMQ/GGC6cjBFnOm4HcuTM7fDHStEiAL050gr9s=;
 b=mVLhgs+tuz5He9eRIIOo7HcrLmaQUI+PrpBc2AUT8oe4/r0lqTWaauElaag3KwElFFkK4ly6IsWtC/FaTo5nqujfrQJjGJ1PsPG5mrRw5Wh5jiPqJMB1KM1p1bSOssb+YTJr4y0mVZonLS1jvbzOeUaKpCetdg8cdNKX/aIshRk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4765.namprd10.prod.outlook.com (2603:10b6:a03:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 05:24:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 05:24:38 +0000
Date: Tue, 22 Jul 2025 06:24:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: update THP documentation to clarify sysfs "never"
 setting
Message-ID: <08e3cf90-76f5-4a69-813d-94315943d37c@lucifer.local>
References: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
 <35df32ae-dc95-48e1-bdb1-90f17bfd4d5c@linux.alibaba.com>
 <CAGsJ_4yMLi_+yxJYebTbEALujcVmeqbfHh=ArkZRxMwE+OBWgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yMLi_+yxJYebTbEALujcVmeqbfHh=ArkZRxMwE+OBWgQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0405.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: bd782686-665a-4884-c63e-08ddc8e00d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlZud0dqb256OXZZOTZVVzVSN3lPWHFJdjNXNHdqdEVyc2VhUmZtTVU0M0Mz?=
 =?utf-8?B?RGdaelhDTTZwNWFqcUM2NWhod3REWThZQmx3bVl1d25xLzVMN3BrZ0liUm5V?=
 =?utf-8?B?bEhaVmJSME1GRjM4NFc3aDc4REFtTTZrdTNIUXZDQlQycmNOc0libmdhVVlF?=
 =?utf-8?B?d2xMaUZQemQwa1VPOWxkNkZ2T1JrTUw4RzhLSDhqVTNEVWhNT0lFb0lvYVpj?=
 =?utf-8?B?dEJNWmorcmE0Qnp2dEFZNk5SRDRKU3kxRDNxY0pvWTZvdFdpUCtyYiswTUNl?=
 =?utf-8?B?QisxTjgxcWpKa0VtK3pROXBvQzcxVFVsWmpEWHhMMmNjbWJIOThPSzZjQ2Yx?=
 =?utf-8?B?YzFFRTJmeUF6QUE5b0ZLVUpadXErak9YU1RhS3pmbksyaWhNMlg3S1UxY052?=
 =?utf-8?B?ajRDcDBSdmFtcGdyWDF3WjRMdXUwWEMxTmF5RUNTRzk3ZkJ3enFwTVM2eFA2?=
 =?utf-8?B?b1AxMS9WbWZZNkgyODZsOU9aSXAyRTl4b2RIdk5IeTZTcFpieXhJdW1Db0V6?=
 =?utf-8?B?SVNSeGM0L2k1b1dDcXBydklVQUczOEhiWGUvNWtwejIrVFoydjZ4Ulc4QzN4?=
 =?utf-8?B?MUpJUmhNdjVIMkpXRExPNk84YThKTm1XUXZMbTJhcUVYQnNDMmVodUxCTDFs?=
 =?utf-8?B?alB5N3o5ak9ZNE1JNlduenc1SkV5RWc4SlN2VTRrN01xY1prZHBCaGtQeTAv?=
 =?utf-8?B?ZFJvdFliaDIrRmZBdE4ycGxjMnhZQjVIcXo4QjdUbjZUQ2M2RHdVWXNkUVBO?=
 =?utf-8?B?MGZQR09DSWd5TUlpRlIzSzRucVJkcnY5Z0lqRWdKRW0rd09zMHRPaTY5emZa?=
 =?utf-8?B?WURlbHNlWFdGaWN0SEJHVlVFaDRMNVh3QjZEOXA0SjRsMXdwa0JPdjlwV0du?=
 =?utf-8?B?dTk2NjVwRHlvdnBWOWJpVG1vVWZlNEtyemhmN0hJa2kxMCtyYXJPY09GcGVI?=
 =?utf-8?B?TERqYVpkUDNkZmVuRjg4czBxV1BvNUYxUnpFdUVCWklQY2w5Ri9vb2VDNCtV?=
 =?utf-8?B?STdZcTBVVFJHSU1aa1ArTWg5NG8zODFBbTh3eFM1VnlLMWcyOWNxN1hSQ1lw?=
 =?utf-8?B?Nmp6cmxwWmNRYlljd0Qzam1sM0hGczZHUGVId24vWEloUmtoYXltWG9pZ2Er?=
 =?utf-8?B?T1JaNTdOcDJvTGxVYVVlNjhQdmRtS1FJOWxsM0RZdHFzOHBQemZFZFdPNVhM?=
 =?utf-8?B?VFl1R2NnTTdXdDFXNndYdFNvdUhncUJnMEs3ZG1DUWRPOUJsZ0dHMTY5M2xS?=
 =?utf-8?B?YU0zRnlDRnNEZkU4a011ZHBCRFZHRWpZaVRaQ250eHlpNWZYaTFlOG0yYnlk?=
 =?utf-8?B?aTl4NTNCQTVwM2dVT05lK3RzSzNmUUZFZk9zcHlybmlENEFZNmN5ZXYzWVRo?=
 =?utf-8?B?a0dRM1UxdHNpSHhBSDhOM2NNSG9RbFIwaXRwbGVGVHlOWlhBMjA3Y2FGZ1VM?=
 =?utf-8?B?U0IxR3YvWkdEVEhCRXR3TEZJTGVrWlVjd0Q1Yi9zL0hSSW00VkhkV3Jic2V6?=
 =?utf-8?B?SDFWU3NONG1qTThLZTBUR013ejcxajhMa09iNGpQNWpDUjB1WndJejRlaDIz?=
 =?utf-8?B?ZEdnelYyUFN3YlhOeGlaUVhTaTRRcjZRTjdGZmd2L2tNbkpSZmtLNytSZ0NH?=
 =?utf-8?B?U0UwOEExOWJTZ1Y0M1FVbXQ0Z0xxYW1NQWh4TDRGNHdVQWh6T2xnU3FuNnNF?=
 =?utf-8?B?UkhRZUo1ZVNzeUF5aVJOMENxR1hveVJGdDZTWFB5VnRReFZ5RGMrM2tOTzF6?=
 =?utf-8?B?d2k4bE5mcGZWRVVzbzQ3bTQ4UElHOXFEN2lhTDdSSnZHSEFXMjVGaXU2NUxn?=
 =?utf-8?B?MzZNQ3hSMWJSa1ZTdTV3QTY0Y290cStmd1k4OE85cjQ0TXF2WWhsSytVOElz?=
 =?utf-8?B?R3pua1UrelNlNmhiYWtlanJtMXpPWGFBOXJTYVNVOEJtOFcyc1VnQW9uSGxJ?=
 =?utf-8?Q?R/2F/f93zgQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGVQUmVEamtJZ0lIVlB1SE5mVHJRaG9iVDIxYmc5NHUwVzE3MHA4OEpYcDRB?=
 =?utf-8?B?R2t1SEZQc1JXWFFwRHhpVnQ0ZVlPN3liUC96Z25iNlpOcy9Ea0o4UDEvU20v?=
 =?utf-8?B?NmdmVExZK0t2N0xVejc3L2FoWEgyRW92WDVleXFQcElhcU5IMmtjWVc1cWo3?=
 =?utf-8?B?ak9ubW8wK085SmxRdXMvY2pHcFQzdnRKWmg1QkNTN3VUVkZoTmNpcGhLc2tS?=
 =?utf-8?B?Yk9YbW1uVFNiWVhnQVg5TDdhNFh5MmVCMzZHcUtNRnNmTTZiS3Z2ZklSRysy?=
 =?utf-8?B?Sm9HbXNIbmVpWk5RMnh2OHhseXNTRUFZc1Y0NGR0MmUzdW9HSTFBK3lheHdC?=
 =?utf-8?B?Q1J1UDdRbm1BTjNoUTBRVzdJZFA4WVF3dzZrR3Z4OGU1RFhRa0pBdG8rWWRM?=
 =?utf-8?B?ekcrb09LOU03MWd2N2RpZDBEZGtDSlJBM1YzNWdWN1NaRmt2Q2xPb3RYWVE0?=
 =?utf-8?B?azZtSEFoNTBXSGZRNllZWDZrWXh4ZFhiOFJGNlQyWHFwM3ROb0w0QXdsWGFz?=
 =?utf-8?B?Szd4ZG43UDFZVkYweWgwcVY5a2xoUXhlaVo0ZVJRbURPM2ZSNmh3cFZsUVE1?=
 =?utf-8?B?Y1F3VGtvTElwME1tNVI2VVhvL1hSaEU5MmVlT2h5SHJjU1ZhOThXUXJkeGlJ?=
 =?utf-8?B?eUtiL29KMGdkTHZRWm9INGpNeGVkc3VTa0F4RGdZc2w5YUJLaFdWbGhtQlBM?=
 =?utf-8?B?bk96RUZ5aGlEdnZSYmJOVVJCUmxGb3JLcnlZeHJsUFJjeHFsNFZLbEdsc0ts?=
 =?utf-8?B?VEo1MHVTYnN3WFg4SFdSbUM0aVVnMmloams2ck56K1ZPS3RUWC9uOHhFdWc0?=
 =?utf-8?B?WWFhZ0dlRDhCaGV4MmJtR3g4VXhYR0RxMG9EZFliL0EzUzBIMmk2RXRlWVNL?=
 =?utf-8?B?ODlXRVdTZVVXd2VaQUdJS1FKL0owb2diVkZWZ1hLdXp0bEdVNVVncVlKUGla?=
 =?utf-8?B?cnEyWGFFL2JVcXdITVN0Ullnam55a2kyUURuMmNwcjNzUExPRWppczdaazh4?=
 =?utf-8?B?cTVybjZ6SjZWWURRWWpCZHBnQllJMWJzNTVhQmp2TXk1eVRVWVZXaklRQzd0?=
 =?utf-8?B?UW9sa2o1T1pnUFR5QldWNURZMjhKekcyUHNRYWwveE5RY04rK3N3QmdGT1FJ?=
 =?utf-8?B?NTdKRkgycEVseFBGbDFyQVU5cGgyOHNXb0c0VjZqNVRIdHlONWwzOUhyeXZo?=
 =?utf-8?B?YnZ6T3Z2d2M1N3ZyMHNER1V0K1IrbnVnTmhnb2ZGcGl1cmN2enE4NGxoc3VQ?=
 =?utf-8?B?NVQ2SFVFSUZmRWRNSzE2L2N5VlFtUEZFWlA5aFEydjFEYjE0VjNac3VvNDhP?=
 =?utf-8?B?RStGODBOaFppai9ZNXU3Z2JxVHdCNW5ERk5IcUN5THZyYzFQMHA4Z1dRVWVE?=
 =?utf-8?B?b0E5RERPUU5FR0VtMS80d29UeDhKN1dONC9NNThZcU94aXNBWHhCYkJZeWxz?=
 =?utf-8?B?WXllSG1JU3ZLU1BzdmExekJ3NUhZZ0FmMHhTNmk1QWltQWFDeGZYOXdjNkZE?=
 =?utf-8?B?YXBHQVB4aFNJZGpHY1JESUhFRlVlSFRRdmNnVXBBc0Zaa2ZBWmRzNGhJWXVU?=
 =?utf-8?B?L1NLbHgwdmNCSXg2R05FSVJUNm0yU3k4cWp1NHpWcmpIa0lqMk9MQTdQazdF?=
 =?utf-8?B?ejJvTVJrV3pBdm1xZTJCUnNrdEVUWXZ4TmRCR01tc252RWFIc1ppYW9wZElS?=
 =?utf-8?B?bHAwZ09ZbWZOWHp3YUNidVZKazBkc0YzclRaTHJ2cTNWb2x4RTNqUHZDRDR6?=
 =?utf-8?B?NDdWYXlhZHdOejd4MGx0YXNlMmRCaW81ZFBIbEgzWGJzZFhvNWd1ZmU0SWoy?=
 =?utf-8?B?K0FUUlhGSTNZeEFpY3VNbnJNcCtZejBpK2VCMEttU2cvdDdESXJYcFphM2Vu?=
 =?utf-8?B?UjRNTkJQVkEwRkIvcEdOWklManJxZFR3dVRWUWdOSGJzZ3F0MFc3bXg0bjBR?=
 =?utf-8?B?ZW9CcExJL3Z6Y1VRTDc1YWYwenRhSjVpd0EycytCakFZTHhGaXVwcHljTmZZ?=
 =?utf-8?B?UlZOUWlISTVZOXdjcXR2Wk9lMEpaM0dTS2tEdVV1TDZIejljNE9VbnROMTNu?=
 =?utf-8?B?dGxHaEovL0k0MkxhUllkbWswODJnOXdzekZlMi9CZURHbTZwNkxJcjgyQTNH?=
 =?utf-8?B?dG9TRHFqYTkrb3lMMWpTNG9xTGF1eGUrOVRRWXN1K0QxYXhMUTlPZW1XaitF?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lduoKW9NHZtWCjlG48jla248F7d6SO7c0/5EzDUIx7hgHnGaQp/h6rB0ydp5cIPqp5KEKnXJ2TiDa3+XvblqT8gJoXPUdLPOZ1PBunOiDveWYZgAL0L18xDO8+//Lj6M8NhywR/mjJPbtVLo6ThO+FUpf983EmMlF2vRHeLiz3iJ3p9tgfWTcPaTDcWCf4H+Yd0isaTL/O80nZVw5m+/knSVNY8phsB6igpmplcg0OlpbqAT4uxqzBCNXo7CfWA1dvcOshDOW+Y3DQMUmWqo4TzEOzABpgtJjYctkZVDmeSmVDrof54BFP93/M++vRnojqtO3+vZTdNrJCRShSsgEn382RSJ3dqDoqceE6gewgBohb+zEcujdv3ItcKRTsBopXgXGyV4tjYH8AfUb0u1q1dnMHqu7c7gVpCDQxNy2fvbhzq3V93Wbt11O6+VTUjLXHAnxDa+N2Hz1yZiTg2bUMUI2ZHs9/6ZyXWr6+PVS58HUB3XkddE3lqL5j0OQ5HiCl3+mOxyNy4c1HNabWSCVgUQ0JHVMXFNb5zCBlvZtspxICbD4ytaXyf6hEtrs6mF4y3LhLoSIoXF1ToNJlvNX4ndobYwTXLhqjtlIyRCXZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd782686-665a-4884-c63e-08ddc8e00d73
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 05:24:38.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfMQZmjzB8KpjZQLLUQ9dJlMaxTkZB9T+HEhp/0q4w0Q9bd1HS2Ck5iiGFBhf8A2C1MhHxT7FyO8p1sI4TI5iStLIHdN+F9GVRdVpDQhks8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220042
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA0MSBTYWx0ZWRfX9xx20cFufxYO
 4rE90kWRGs5Pn/os/X0H6xkb6uRFe2hx9cB1ArqRYtvBIvHeR/JUGpIC5ZjVjAuINeuburJPFSr
 Krj8hqnorhFdxq3ciojeZGtpdDdWuRXQv/fAMim17EFXaanYGjYtQyl+drY7wWXrFSekljF5u9l
 vpDEJVWHgsalOSJNpUpsts5oCiIjmqLAWK5uYU4+Lm8Jh866AGXtSqWSnrsOePW1iss8JAY6Z1c
 9UN+zbPzmAALjI67N0btymnqwRu6Nk1gyJzKQ0T36OQ3sHWcZdVeKGJFNeyyRU9MYDtGKR9U7rM
 DwGwDBOUFfbgjeghg6rAd9C85B1tmXREwwHNBbSFnOTd7+8hd4zfqKihbZZH4TTXBGHC5CKpdIY
 HPzRW/ef/8Pb9Zbr4Bu7JwmxVmRc5RkJGpZrxkUfVbXLoOjuzlVi1tlGonB5Xm/EYAOTGIUl
X-Authority-Analysis: v=2.4 cv=doDbC0g4 c=1 sm=1 tr=0 ts=687f2099 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=yPCof4ZbAAAA:8 a=gMB-goX5PFDbr3Dt_sQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: b0ojUn9KJnbbpfJ-CwVfCf6F6QqVgIwl
X-Proofpoint-ORIG-GUID: b0ojUn9KJnbbpfJ-CwVfCf6F6QqVgIwl

On Tue, Jul 22, 2025 at 10:23:39AM +0800, Barry Song wrote:
> On Tue, Jul 22, 2025 at 9:30 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 2025/7/21 23:55, Lorenzo Stoakes wrote:
> > > Rather confusingly, setting all Transparent Huge Page sysfs settings to
> > > "never" does not in fact result in THP being globally disabled.
> > >
> > > Rather, it results in khugepaged being disabled, but one can still obtain
> > > THP pages using madvise(..., MADV_COLLAPSE).
> > >
> > > This is something that has remained poorly documented for some time, and it
> > > is likely the received wisdom of most users of THP that never does, in
> > > fact, mean never.
> > >
> > > It is therefore important to highlight, very clearly, that this is not the
> > > ase.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >   Documentation/admin-guide/mm/transhuge.rst | 11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> > > index dff8d5985f0f..182519197ef7 100644
> > > --- a/Documentation/admin-guide/mm/transhuge.rst
> > > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > > @@ -107,7 +107,7 @@ sysfs
> > >   Global THP controls
> > >   -------------------
> > >
> > > -Transparent Hugepage Support for anonymous memory can be entirely disabled
> > > +Transparent Hugepage Support for anonymous memory can be disabled
> > >   (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
> > >   regions (to avoid the risk of consuming more memory resources) or enabled
> > >   system wide. This can be achieved per-supported-THP-size with one of::
> > > @@ -119,6 +119,11 @@ system wide. This can be achieved per-supported-THP-size with one of::
> > >   where <size> is the hugepage size being addressed, the available sizes
> > >   for which vary by system.
> > >
> > > +.. note:: Setting "never" in all sysfs THP controls does **not** disable
> > > +          Transparent Huge Pages globally. This is because ``madvise(...,
> > > +          MADV_COLLAPSE)`` ignores these settings and collapses ranges to
> > > +          PMD-sized huge pages unconditionally.
> > > +
> > >   For example::
> > >
> > >       echo always >/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> > > @@ -187,7 +192,9 @@ madvise
> > >       behaviour.
> > >
> > >   never
> > > -     should be self-explanatory.
> > > +     should be self-explanatory. Note that ``madvise(...,
> > > +     MADV_COLLAPSE)`` can still cause transparent huge pages to be
> > > +     obtained even if this mode is specified everywhere.
> >
> > I hope this part of the explanation is also copy-pasted into the
> > 'Hugepages in tmpfs/shmem' section. Otherwise look good to me. Thanks.
>
> Apologies if this is a silly question, but regarding this patchset:
> https://lore.kernel.org/linux-mm/cover.1750815384.git.baolin.wang@linux.alibaba.com/
>
> It looks like the intention is to disable hugepages even for
> `MADV_COLLAPSE` when the user has set the policy to 'never'. However,
> based on Lorenzo's documentation update, it seems we still want to allow
> hugepages for `MADV_COLLAPSE` even if 'never' is set?
>
> Could you clarify what the intended behavior is? It seems we've decided
> to keep the existing behavior unchanged—am I understanding that
> correctly?

For now see [0], we have decided at this time that this series should not be
applied.

I again apologise sincerely to Baolin for this being such a back and forth
and him doing so much work here prior to this decision, but overall David
and I felt that _at this time_ we didn't want to risk breaking anybody by
changing this behaviour.

And so as I promised, this patch is my updating the documentation to
reflect the current (and I entirely agree - odd) reality of 'never means
never'.

Cheers, Lorenzo

[0]:https://lore.kernel.org/linux-mm/573eb43a-8536-4206-a7c6-d0daa1fd7e70@lucifer.local/

>
> Thanks
> Barry

