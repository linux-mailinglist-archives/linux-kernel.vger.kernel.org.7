Return-Path: <linux-kernel+bounces-850055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB040BD1B97
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B0C1898297
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C89D2E0923;
	Mon, 13 Oct 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E87t/XqG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kyTOrpNr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E93E2F56
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760338862; cv=fail; b=crN9UYpKdBOYMLR/UYA5UwRi3S0qY/RaG8J9kOnbDmAgZz9ySjAG5PtNo0C7CaIUTo1ODC7+Hv7Vfvp1gRy0AnC4jCUTUKT9sApX4Ei7Mvof+3kWyezgn2qAS7pxrXftqaogRPuj40pp0kjql3D/eA0hbRIBo3G3eZbDCjxBx6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760338862; c=relaxed/simple;
	bh=ipSIYREsp1ZBriMbWruJw9A0PYd5dwxmiOi3RewmVlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JTzuFKGjPtvahZ8/4rDvK17q52a8YMhWHG0UmpdU4GTBy2tcE3QqLvJgNpT1rYz850Hr3eKUKr8VTmo65d/eUwCr+hrs3AF3kz/kE/mHtcXGI5RSUh29bzt9lSqlU0R8kWgs5xUpJt4ox5TZM3/4jFUr7dU0bk273AZOlPTb2xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E87t/XqG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kyTOrpNr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CNNFqM016342;
	Mon, 13 Oct 2025 07:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JPfCrAIBQNVfboAvhj
	nK99gRLVmiXiMCwbBJE482Qbo=; b=E87t/XqGLxUMiTtwEH88Z/h+sRQoacbfJJ
	M6+vGLzET7Zx2F1VebUm3tDr2QKfPFTqlLzjvuwPL1LVKqgnf6f/4odQ4U0IyM5h
	ITGG6X5hAqWjEGgEJCydfppRXqEDCXUC5C2xgXBjFEeNCAv2iWBzsH5rxhOKTjO+
	ahNjZtiX9PJVDDojyHPf8A7F9GucGWeQ3Yfz/TZ7LVDaWy7fmOJ6gu8uzgiNuA+y
	vMA+T/wmflUyRFwjVJJ8/fSLrGH3yIcYdy0YmegCGG0hBofimhGKbkNnAo7Bp4lA
	l0EkrqZoYW6J0Nl20bsFykFWtrndtqcIrVZ+p+FixJfs8Vwtx1Pg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdnc1mrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 07:00:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59D3wQx1018001;
	Mon, 13 Oct 2025 07:00:27 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp6wwjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 07:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGoichS1A2jtE9PA6qJWkQAB8sGVQmojcI6XPOoNuSneNUqZTBVtrFX9240on80qoIcc3johxPGwaZcgxYnlwUvjL4YoKH+Zp0U/9On7SzyFqnG4qIQi5s3caC4elZbNIin5qFQcWqDVKTRfZOe5Vw+Ilx+enFB2Z6NvXFzBOowmbNFmYnrVzJpYUxa8SzzMZnEZz2wJFkjqtMrSDt9WlcGmFk2vfAKvLCoAAL0B8OO1yyVIHaEeWEHTq8Zh/cPz7PwQimv95XpsDw8R/CtDN87Z6pw4tQHyT0B9KdgnxvXZZ50WrLPXDKLoUCAjgjksZ1xwBiL0TG2IEZ2lW0cEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPfCrAIBQNVfboAvhjnK99gRLVmiXiMCwbBJE482Qbo=;
 b=wLaK95WjDq1StMYAZb+vEcvdzeCu4rML0BZGID5zuCLqBo50CZqsNzWsKs+R6G8cB3CD6vWmDWH0Yug/QDtpvEiFjzVMx0cHBsonhnj0EEFPcLOXWErw4BuFGZa5S8jsFC4509LR9oaSgTC9fsTHyOsbZJ8f0aEeaIB4b8mHXGhOMygUUiPsXYW3qm/Wg3SzQn9bfBQzIYcU7cyxIyQJmc7eAh5+WxWF+fdxUE09a3Rsl67iGRhcm2Drx85NSUFTzpn1p9GqOhPBnRJubCYCs0546Cg/XbaVn0CpMlQ6UWY9XtoreHMwiW6uLrX0GJsLV8B5tp84Fe+gS5ywqflH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPfCrAIBQNVfboAvhjnK99gRLVmiXiMCwbBJE482Qbo=;
 b=kyTOrpNr0eDzxB8rc3NSl7NiygknmEis3LY/98VA1r+C4X3B55mEhPPbtSeyZnyx6HQ7dnwR1wu2e/pFjF5KbnVwxrJBUGMAy4/3II4uXrb60Kr8bAEyk6z2RbblbSUHirHcfQ5KTYkm4O8+8aCq6tTQfFKWKCeZMvttjLvdn/c=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB5736.namprd10.prod.outlook.com (2603:10b6:806:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 07:00:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:00:24 +0000
Date: Mon, 13 Oct 2025 16:00:15 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: ranxiaokai627@163.com, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn
Subject: Re: [PATCH] slab: Fix using this_cpu_ptr() in preemptible context
Message-ID: <aOyjfyCSgoIj_c_H@hyeyoo>
References: <20250930083402.782927-1-ranxiaokai627@163.com>
 <f72deca7-4344-4adc-88e3-35a4a1d9a30b@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f72deca7-4344-4adc-88e3-35a4a1d9a30b@suse.cz>
X-ClientProxiedBy: SL2P216CA0115.KORP216.PROD.OUTLOOK.COM (2603:1096:101::12)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 76eed5a1-ffa6-4192-c1db-08de0a262e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?akKxRoszr3QaCtlKTvc50Szyc9Ivkx5avScsMocoTHgqJZDTIcwOrjIAJzoc?=
 =?us-ascii?Q?6IiajwXwcp0dUbNiR6QFMLFCVChsAgawwgkUOzVX3NUfWSFoXDIz9e8MtOgj?=
 =?us-ascii?Q?UErOutO7fKkx5FoGnUdh85xxnmuMGwXM5Gmpq6XAkDi5gjJ15D9JNqjZB9Hd?=
 =?us-ascii?Q?vn1HTEcvr78IpRto/xzYxiVvsPGwI3EvkHGyidO1lL6v0XqF2M/fVekSqgM2?=
 =?us-ascii?Q?/+e9QvXhlCsFy9vKIKV5BvYVEzs/1sPsDdthnVHw96jZrAj4qHP109CbC2LZ?=
 =?us-ascii?Q?aQMstSHNjT03cLV/QrKpD/rUaRaPGEn8PtiZiaokZdjmhzsKgv+rcFjT4XCn?=
 =?us-ascii?Q?6+yV6LOrCrdy0AcnrRsuRgdkgz7ggOQwAWPRkQf/bFrdS6C3VTRKJMTipSw0?=
 =?us-ascii?Q?eE0uABzMMBuXoLc6sKWm3upWarvhISrqIhGaOe4xJgcCLliCfVIILubkLCj2?=
 =?us-ascii?Q?itc7czZZJAWu29Er7xGfe53XS8PsdCupqfAw9XtyWE3oSj7GwtiWbfSp5KsG?=
 =?us-ascii?Q?WzngMVUCKL+EMi9m3Zfd+NzJUqDGsrk150rPbBh5pEhAy+B5Y9uAXWvln4ww?=
 =?us-ascii?Q?w69WWAF2aQg9ldf9zVESEMwaJOP71XYZuzL23ifxdtroOWh6Tk1yAQu1AJSY?=
 =?us-ascii?Q?mPzSl5pGHfsf10W9PPh/6Bos5V3UHolgq9OfXDaA2qVGVBsebL3mzF7tVR5u?=
 =?us-ascii?Q?vR1rbp5DMUhKQPd4mdPc1jQCeoPIQt1IpLddP0e3ZfHJI3TEFzxg+wRXPOvu?=
 =?us-ascii?Q?PINFODyQyitgIJ1WqDnouhfDUkrVk9JrgGlfNp8EbCvOdvgBQH4ct1eoNEF5?=
 =?us-ascii?Q?ppBXqKIJmkl+0JoWVNWagCxQ1nFA5WX/dCDZA+M3oiB5gJfVr/ZIIgWCo7TK?=
 =?us-ascii?Q?pu7kxIgK2Lbepq6X24F9Kg6RKplD++iF58q8yrNjZLIn4+S7oRe9O2mBQssJ?=
 =?us-ascii?Q?TGGFKCa2JyuwESZZoIv4ifD9vucj+lefB1WqguVXaLMtqn+q7phvHWyodFJR?=
 =?us-ascii?Q?VLrzKHqZTMy+RZyDrcY1fwOtVzZTp9dcM6r4RNym0+OLEqR/hvcOSxPs/Dnz?=
 =?us-ascii?Q?SoGT6x65oz8YW8UcTNyGC8P3boPn7uknFpU2Sb7hd92n7xj9WPNbufvWHymM?=
 =?us-ascii?Q?vfE0J+O2ZwQ0CQDAJ4pdPDYwzJQ+wJRtbkHDpAMB74e0XXjGe1pAP7WxE/aw?=
 =?us-ascii?Q?giofIViJsXNZhj/KRvEenpWvRwyEm1KNCa/w4h8PruzEZ49mEw3zYpEgRX+I?=
 =?us-ascii?Q?ydx0fKVwKwumsIockxAfxaaefn4wM0Cp2J1gxTCCSJqBY7O8uhKSBueAifUD?=
 =?us-ascii?Q?y/zLKfxb4T5u6yAPfFJvvsL1eGhyKZ57ZRrnvv8e6IVVIwQstDzoxtPSRICX?=
 =?us-ascii?Q?RKRZF1266ZigkcnZhigNoYS55qq+TYQQ/VM2kwNUkwpq+WbI16VpfvcSl1vd?=
 =?us-ascii?Q?JhS61ITFyEXatqQ2wsXdgh7f4z+BbXf7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DxSHy3+Oqw9UlsT+ut7BywQJSqqMggWsxxc0cxuNo4HvnjtyaK/+G0AA7Dnb?=
 =?us-ascii?Q?YlTbE3OQs/TH9XNvtdW19HCGyq6/rXxfCSwDU876heCKhhXf/WBYugSO1K6G?=
 =?us-ascii?Q?GPauQODF2mEbXFAigWzRl6cS7Dxs+K7yV3mzgMxeZhEX9jHK77rgLGiJE4IT?=
 =?us-ascii?Q?jZMJ1cbqeynXdZ9T0I4pRzeRERkQNspqqFNv/tTcUNiIMvSony2MfgfyMjF5?=
 =?us-ascii?Q?JUrciZZP8s2DvZioimsIawj/FVChOYl/FKojL7W2tCCYZPqaifnHz8D6YHQA?=
 =?us-ascii?Q?Tsg2NJoZDYrtjSfl3TAMrouxDCiDxLAsHIlNroHjvdkyu4yFFoCbJy/mdNbV?=
 =?us-ascii?Q?hL7Z6yg8/0a6EW+mVsWSUnZOXfN93mX3rNLuV6rp5bAHzVLDIhW0mXOWDGCk?=
 =?us-ascii?Q?ezkfPr0I6MIt0sJY3jeQndQH8QpFs+55k7X7zukn/rY24vCueznfXQ44dMd9?=
 =?us-ascii?Q?G1Vu7k+jbeELCDW/aH5OrTqc/W3x2eSHa1H31hbEDre32KdlMWFdBVXd38uC?=
 =?us-ascii?Q?EVat1y6HGHwktKd9GDGI8J/X1ZUIwOGr7sOJ4wVWsJtIzBT7pddbd6VlLfyt?=
 =?us-ascii?Q?qgTCSGhWvk+K1WKJNrPq5L04dwSTQHliZuCHFXJ7528gGUSi6QBFUO2EEwMO?=
 =?us-ascii?Q?8O8OoczlH12gfDtD7T5oVJwlDL8jRlhzBbCsziT7P4LxjuW95ruPPc6FLbf+?=
 =?us-ascii?Q?7SXPnUsL8nuV9UOynDBw/xbj30ZRvEONVqEsD7ME3zvaNk8+7IIm7ow7tuco?=
 =?us-ascii?Q?CJrevinHp5nC5HSYz9O64Tm3E0C0UaIsesM3QWz62mviObCe0s08tjRM5Wqx?=
 =?us-ascii?Q?BRDiYnsZsYV8vyXBbItaQWoz0DRYVoQobHLnfM1QqfyAHuIAe2d353vm2/kq?=
 =?us-ascii?Q?0zKOYNSuvQxlcCi3mTx6d17TqWUbZHWKXitdLfJJFHQPu/A1r7fbOo1n8QPG?=
 =?us-ascii?Q?M9aHZtkMndRgmwPfCDDxV+82DaJ/u+yFAgyRCGDtLApsiOfkvw+VLP4eA9wg?=
 =?us-ascii?Q?0HL9pR41Mgr7qRdO5EMy4PxEdElCelZEjv894QobuTnSkR9pwfBKAtEWRTTk?=
 =?us-ascii?Q?R54ndS5Qy2kNlURJ0GfFiRsAgo7j2TmZOnbXhaTudDjXupc+x2BUpu3PNieR?=
 =?us-ascii?Q?7FybhE/HynFhvnHMFHfw10yWRSelR6GzyA7/O8BZ2RuuuZY9bwe3oyIiXmL5?=
 =?us-ascii?Q?UaAIB7ZJ6vI0vf5V8cCVf22KwumgOsuf1mWL1mcyErSbu53mhi2h8NxkzCs1?=
 =?us-ascii?Q?7QVzjlwY72T1C5F7KaBS9/kYzDugvxUAPTOOtpvboKrb9dHrHp3EtML8sLoY?=
 =?us-ascii?Q?EwD+umuhkUyI4u3UYyJvcd21JS1wAI8VrBaFFGJFt214+BbXhLB90Llc8P/a?=
 =?us-ascii?Q?MJctzrv2M89+9oiWXH6WF/nN9REhTg/JxiQ8gxAbUh2z3UqW/shc9OsIYmhf?=
 =?us-ascii?Q?Rx5Y/oQC52nEo/KkjWLP9E4IGwYYV79pbqAUC9+FPCBinBBJpZxQmENd5Ajv?=
 =?us-ascii?Q?Ov+72o/4aaXLj5WNpEnaqYHrPYsIvE0Ap5V/mdraLNnMW90hXAqSn/92rvL/?=
 =?us-ascii?Q?QicCF/YocpmGwA612vZ1OtBXdndaBrXq0NZCW5fA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vU4iH1mbWZkq/DZKcz16BdM7xpqk3s4vnZBDKK6I2dqGnv/syQwTcq05oOB2dRukQPNywvzJYBmjwoKqA4XJtmwkCuOdTSPrckPYTBnArrvmQsSkLT1Ewr0PkfqCV6PR5iG7QfCoukMiPF92tD6k0pVc79NkpftYESQXehV+7azuxQdt98Ae5NAiPTrp066tpvtvjv3nQDtb7PRzPQkf39nptcCQjLxhGBlyg9tXnfdnsImHLIMfa9Q0WKnDwSUaEkCOyA+iHvw9YQYhwxZmQpaMV9fSLm9dklbAqnzj/8yD0H+5dNXdROfsBVhdT+En3YHupgnWu/3b/7rPcUvpKs6IUSJsxp+7LvjFySX6cS/cHFE65V3quXgNlXwin5pG6dJ3yd9ba8DwXsAXIQCd2Ifn0AXTB8Ds8NaNakCAlVM6gAOuW1jnFAE9ZwtMFfw3KMC6bFtWXKnM41L+DGt3MWwp9IA7mNyTVDc3302TzPF82P6R+s/EU9RbpXwr7F3BJ0BKRIybBwwR/z9f/Og6nPKrcoK/lw8qgoSp4OEirFJ4DfduQWprx+8rz2Pn3iCKcTEkiCv0QuIZfXCNuE9UPXf+2aFt69KOcpq/zHqD5YM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eed5a1-ffa6-4192-c1db-08de0a262e7d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:00:24.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8+4taT4WHiB84KRjJMETxOa3s1dbS9My8KyLm1XcH78FJJG6dy47d3iBI+9aKczCnIQtMvvPMOEwN9cncsNsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510130033
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfX5AJ/8NJD9bHP
 NkwC7uEX7SFM7OJum4chDYcCTVSP2wJF3Jfetbh/drUizg8CdRzMhMxz0jcr0NmAroYfePZEq0y
 vsXNCo+7GwCZ5ni3r6ntP/KHjbR7WXhO8yCZh+aL2lFjbVW/8ae97bfMKeS2V0sK1Rgo1DPtt2Z
 3GtrQn4qdxbGspM7jF7DX5X+unP6QCPV8BVeelgugMmX7IbhwCNAC9iocqcwMLbmWlAmWKzVrCa
 mOOu5a4XEyrFW8oe7EsuOapMDAnGb8IMy0CZo776rhOfdYDEX5FVh1HpydJOCIMbe6ROI/MBmkK
 iFzSfBV3QrMU1QezEK8LAY0Zpa5SMaedB+pBD/FyQ/yxlxIxHu0N1K16AxXbMj4f8gw1X8oxEzv
 p/RDrJhr4z3kG2UeYlBtaBJr9nJm8A==
X-Proofpoint-GUID: HIfkbkT3SEnKdg6UPCm3f2adb7SD3n8o
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68eca38c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8
 a=1RTuLK3dAAAA:8 a=yPCof4ZbAAAA:8 a=lzzSMUpr7EZP2YqA5tcA:9 a=CjuIK1q_8ugA:10
 a=kRpfLKi8w9umh8uBmg1i:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: HIfkbkT3SEnKdg6UPCm3f2adb7SD3n8o

On Fri, Oct 03, 2025 at 09:49:57AM +0200, Vlastimil Babka wrote:
> On 9/30/25 10:34, ranxiaokai627@163.com wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > 
> > defer_free() maybe called in preemptible context, this will
> > trigger the below warning message:
> > 
> > BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> > caller is defer_free+0x1b/0x60
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0xac/0xc0
> >  check_preemption_disabled+0xbe/0xe0
> >  defer_free+0x1b/0x60
> >  kfree_nolock+0x1eb/0x2b0
> >  alloc_slab_obj_exts+0x356/0x390
> >  __alloc_tagging_slab_alloc_hook+0xa0/0x300
> >  __kmalloc_cache_noprof+0x1c4/0x5c0
> >  __set_page_owner+0x10d/0x1c0
> >  post_alloc_hook+0x84/0xf0
> >  get_page_from_freelist+0x73b/0x1380
> >  __alloc_frozen_pages_noprof+0x110/0x2c0
> >  alloc_pages_mpol+0x44/0x140
> >  alloc_slab_page+0xac/0x150
> >  allocate_slab+0x78/0x3a0
> >  ___slab_alloc+0x76b/0xed0
> >  __slab_alloc.constprop.0+0x5a/0xb0
> >  __kmalloc_noprof+0x3dc/0x6d0
> >  __list_lru_init+0x6c/0x210
> >  alloc_super+0x3b6/0x470
> >  sget_fc+0x5f/0x3a0
> >  get_tree_nodev+0x27/0x90
> >  vfs_get_tree+0x26/0xc0
> >  vfs_kern_mount.part.0+0xb6/0x140
> >  kern_mount+0x24/0x40
> >  init_pipe_fs+0x4f/0x70
> >  do_one_initcall+0x62/0x2e0
> >  kernel_init_freeable+0x25b/0x4b0
> >  kernel_init+0x1a/0x1c0
> >  ret_from_fork+0x290/0x2e0
> >  ret_from_fork_asm+0x11/0x20
> > </TASK>
> > 
> > Replace this_cpu_ptr with raw_cpu_ptr to eliminate
> > the above warning message.
> > 
> > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> Since the slab PR was merged, we should fix this ideally before rc1 so I
> updated the code myself per the discussion and added to slab/for-next
> 
> Thanks!
> 
> ----8<----
> From d6306a3d5577769b179ae4e448fd144e2b0f7717 Mon Sep 17 00:00:00 2001
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Date: Tue, 30 Sep 2025 08:34:02 +0000
> Subject: [PATCH] slab: Fix using this_cpu_ptr() in preemptible context
> 
> defer_free() maybe called in preemptible context, this will trigger the
> below warning message:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> caller is defer_free+0x1b/0x60
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xac/0xc0
>  check_preemption_disabled+0xbe/0xe0
>  defer_free+0x1b/0x60
>  kfree_nolock+0x1eb/0x2b0
>  alloc_slab_obj_exts+0x356/0x390
>  __alloc_tagging_slab_alloc_hook+0xa0/0x300
>  __kmalloc_cache_noprof+0x1c4/0x5c0
>  __set_page_owner+0x10d/0x1c0
>  post_alloc_hook+0x84/0xf0
>  get_page_from_freelist+0x73b/0x1380
>  __alloc_frozen_pages_noprof+0x110/0x2c0
>  alloc_pages_mpol+0x44/0x140
>  alloc_slab_page+0xac/0x150
>  allocate_slab+0x78/0x3a0
>  ___slab_alloc+0x76b/0xed0
>  __slab_alloc.constprop.0+0x5a/0xb0
>  __kmalloc_noprof+0x3dc/0x6d0
>  __list_lru_init+0x6c/0x210
>  alloc_super+0x3b6/0x470
>  sget_fc+0x5f/0x3a0
>  get_tree_nodev+0x27/0x90
>  vfs_get_tree+0x26/0xc0
>  vfs_kern_mount.part.0+0xb6/0x140
>  kern_mount+0x24/0x40
>  init_pipe_fs+0x4f/0x70
>  do_one_initcall+0x62/0x2e0
>  kernel_init_freeable+0x25b/0x4b0
>  kernel_init+0x1a/0x1c0
>  ret_from_fork+0x290/0x2e0
>  ret_from_fork_asm+0x11/0x20
> </TASK>
> 
> Disable preemption in defer_free() and also defer_deactivate_slab() to
> make it safe.
> 
> [vbabka@suse.cz: disable preemption instead of using raw_cpu_ptr() per
>  the discussion ]
> Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Link: https://lore.kernel.org/r/20250930083402.782927-1-ranxiaokai627@163.com
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

