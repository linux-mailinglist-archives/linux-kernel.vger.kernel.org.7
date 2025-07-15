Return-Path: <linux-kernel+bounces-731589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A28B056E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62671C239D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C572D5420;
	Tue, 15 Jul 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="alUGKhL8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CLNsUmU1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130728D836
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572620; cv=fail; b=nh71CA5/ii/uEV3nCXScOAgQOoAfg6yXvihy2M8saHvxjyZhQQgtDrGDDSG/u/BbbljPKsarAs7zZ5gMPuv4hI5D8C1OHZe7SAwjqM/RnGQY7qR2ROBYbh9q4fhH9wf00g3hx82LZqQRYZzJI8qimqi/pnSUu12Aj586U2fc8qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572620; c=relaxed/simple;
	bh=dSRjr3a+a/HDCARQUnv/oKXkNuczwv7PXY9G58Jp/cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S5zGh4aQyBde9Yy5zWBpCHzRpzl0rylbzceVdwCoWboO3X1cGuYHNyI6KgYQevrFxO7FqXm2GW3XJ5BfOZRD61gBBsosV8B6HaNchZQ9r0pv+iuNT1QstfknXmq9geiiT0x6mdwZDNqWASlIj0dUYGDUSMppeStn2I7sKQwMR3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=alUGKhL8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CLNsUmU1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9YoWs020345;
	Tue, 15 Jul 2025 09:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LOopeRF032sJP+T+9y
	AxAYjEBkPpi/XEvGGUhbbbTJY=; b=alUGKhL8bIYmPPi5HCeoe0nsoSpahyzhfc
	DyYBKPQY+M28x09sH55mbjnJDWxEnXs/Qo+YveqwZLBpRndWvGtRiUlYt7SlQCRX
	w02bMuq4ayjsP8Wjra8uY1UpcXy6sQZ+K8ETJWCxGuGt5ibz+VoBjez3902WW2VT
	mJ67JSL1wvyjjkD81YNwam2U8XpqeSyynd4cQnjGbqRFKjtXXraWdXY2i9HcVQ0A
	RgIbkritg4uTFVyhq/yFkCVoxPnkh58NljjN8iCT0HZnX1xIdQHexuVfU8EfoAfT
	h3pS72V0CKQggeb2BpF5zixiOfQlA7VY0L7X1ePeBy4r4HfNMhqA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf6qtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 09:43:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7cERd023929;
	Tue, 15 Jul 2025 09:43:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59r0nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 09:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+i+cOn6v73KTRHAMCRbxKkJZIxx8NHi/JZeji2duzjzJ5yvA6t0DuaEAnPahGIK29iv8c2WrxcoxKF4OxH6Em2aNf4wO4Hfg2nSY19kWzoMxM8C7n3MvpvsfUadlHXlB4tJzSsruV57v8+RQRW/P6NPtK0FA+oLPnEx8zPYAHiQNBrZgDhoCU4hOVIczl35BxXUmrqRHgEoYPmiGf2pu4eRgptZEI5ckD01wJCJWov3uy+obRqbpLuRmFaPNfVhd8uQx2NXng4Xe5k/V36Y0bVz389tCEOOgmEbtv7n7xy4R+GW1vKqu6K0MjSUdtHjTkgPhCpSy8heebi5f49Irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOopeRF032sJP+T+9yAxAYjEBkPpi/XEvGGUhbbbTJY=;
 b=a2g1NA82e96MCRa3LpNPeRH6XV6DavA/Kx474a/KJAqvh+aL1WPR5pOSa+IwVOhurz3OR1NUdHAcj/fGCm/mxq5juQOxQ+dem0t1bicfz4SG6cm+EKr6NEqtIhK/G5eQhOJOUjT7vkHb2GjP6VdfsX+ZX6QdO0dJejZFvzuPD5PYjX/i3pfnwdqTt0F6farEVtOfB+M2bIvhHjC+fbaK1MdDOtBuduVwp2bCaBiySyK6GY3BLVvPsMDZsURfAuZoirzrUZ/YR4uzfqlT2kqUu+lGq2JhAX/9+aeNNeAsG1WrbhXsmTRzdHfcU3OQRoKw4BlT4U8KlChNqxpaPzuZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOopeRF032sJP+T+9yAxAYjEBkPpi/XEvGGUhbbbTJY=;
 b=CLNsUmU1HfTXbq+uqPrBu3/3c00aNwUevKqQX2bj2MYuRaaUJqTnUy7Md2umOCSU2z7uYnDOgjKWgkQGOhSqdb7p7esN6FswTwgrLoqyhDpPd27ETQ8e6DHwQtuaufIbKBGyO+q3q4k9KwrqrO27OGKE0FF3GFtopydFJvADzv8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB7553.namprd10.prod.outlook.com (2603:10b6:806:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 09:43:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 09:43:13 +0000
Date: Tue, 15 Jul 2025 10:43:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] khugepaged: Optimize collapse_pte_mapped_thp()
 for large folios by PTE batching
Message-ID: <b82b860c-8ad9-409a-8668-e3db11b9f7a5@lucifer.local>
References: <20250625055806.82645-1-dev.jain@arm.com>
 <20250625055806.82645-3-dev.jain@arm.com>
 <71350398-b5d8-45b9-b05c-d2b63030f766@lucifer.local>
 <8109236a-9288-4935-8321-dbff361dc529@arm.com>
 <e9b027c8-9db9-4950-8d25-9984ae0a4de1@lucifer.local>
 <d58dc96a-4082-4a24-84cf-fed27b85763a@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d58dc96a-4082-4a24-84cf-fed27b85763a@arm.com>
X-ClientProxiedBy: LO3P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: aa785855-44d5-44ee-ea28-08ddc3840487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gyu5sqgo3hXDifJiqUSIipLfgcLEDSqKzANTfXU4iTCVBmilmA2IL4uQZz//?=
 =?us-ascii?Q?rWVi567lXRf84Ugy9AK3wAevE1C3hF2bk/MZq+B88hoyBQQYicEV6EV6bOwM?=
 =?us-ascii?Q?1+IngWC88JJKRnyvbPkMOi+1WEGnxwcUqcqEaF4wpWtSxt7aSU8YvtM0MuZW?=
 =?us-ascii?Q?Hbq1rkN8yhzvsOmP0eYeYAzHnPmTekxxJaUG+QhqYC6pDwoFzDLoBosOiHU6?=
 =?us-ascii?Q?PDBeLVxcWf/Sd9+aIeE2w9PX8j/m+mOClnnXr8M4E42B9fGBK8Y11wXHjhL2?=
 =?us-ascii?Q?qY5uxm+wpo8mVuVAnpb5iCXXPeXzuURD1r5ybsMYQ8C4sT5UBLMEuRAdB1JK?=
 =?us-ascii?Q?hAnI9nc8K966yeM2B0PuH0JZzQBYObVe25xjVwoN7jFThrJ46ibXgSogfZJ9?=
 =?us-ascii?Q?1wRlF2sSjyuRyrr16TjiuZPdEyQsyjX/HIfEI/3dlAZUMvkTqCHRRjnZ3qrE?=
 =?us-ascii?Q?265BjCiWaLHyheN0F/NnBRf66BkzzV2MCqTU2XB8IsErrf0Bd8QUYc+pneCj?=
 =?us-ascii?Q?8jjsNoQBrf07wq2rnPx9DM3hM8ze2ItXADhX5HmjY5a5y5Br4pKxk1W9IP2S?=
 =?us-ascii?Q?93YNnG5IrbD6eOZg6YKJ8lQCVPCirSfbXIpHV4/gBfolBvXIiewFwgADtqj3?=
 =?us-ascii?Q?519xT73dbMIBEmlPV3f2+gZE3qZe5T2ZIz4hyxLgpbitynBbWWts5sfXePMv?=
 =?us-ascii?Q?pqDqs9Ie+WjrExaHy1gmtJKvq+3c+lf3toGS9L7JMqjucSXR/EkIXuXFnJK0?=
 =?us-ascii?Q?Wc24n3wQel5W6K6bViapl2BEAvSuO5YTQ2ACtrofr6RHKheAxhsn/2PitDb1?=
 =?us-ascii?Q?FVH66Nljs6W/RxzlJThT+ubJ/Qs2fTLmXQ5RzsJITwrYaeQvViFSdvrLrkBr?=
 =?us-ascii?Q?IDatgBJ9Ctq3mV9t1PdFejMbmwrk9xuoC05yDWK20ILx8oN+HKa5+EuCmbHf?=
 =?us-ascii?Q?lmDLv+j5c3XgRgvbHE4dmBKQ7RDMzV3VINxMuV+nzLYEKoFGJtBds3a0EE4b?=
 =?us-ascii?Q?ufSEqhJitDwmW+jQ+dOyC4gZf2YnpsMJQ74SqFEPDGtWEaQEs+uoy21Ow7qh?=
 =?us-ascii?Q?hxFiwL3sEIzYN14mICc0QAOlxujCDsat7nx2hLOTLaQF8no9Lw4v43R5wnWZ?=
 =?us-ascii?Q?Hspq3Bx9C12rSto/9a8nD1dty8DLns59slpPm4sbAvgGPzSzCc6EoGhVXSWk?=
 =?us-ascii?Q?eKn6TXbEvPaHqA6WQ3kxw9h4kx9gEsYpQD2/iLCH3E2zqb+kQQWGHojsxp9B?=
 =?us-ascii?Q?lxBiEmS6NMXZxzXUN+C4RYx2fomOf9rjphxGJlx7BHcNsIvxe048icrsXUnx?=
 =?us-ascii?Q?6zKws1t80y2pqPRB0Qw/lL3zJzD7t6myzPxMYnJ/sPMwaMZAEYSfoNchLX4k?=
 =?us-ascii?Q?UDm4+dL+EkLB+CyYdqoQxx+5yybHDHrWRx506BEgYNzkU1M5hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pNPDoWy/w9+6hfpc1HZye03+/hL/ZVHNtTbktG+Ro6DgNMUJkGQIWg2AlYfA?=
 =?us-ascii?Q?zOqnVOFH+5MATumOF0HUBYp6uRnICWUG1odoxQJeREfWrkkAkvMycpcA2mHj?=
 =?us-ascii?Q?QJAFxjT5kbGxQVMQqeIrHUqV3gvU2pcartyPLOCsXTvr3VcsHd8B2G2vxyzj?=
 =?us-ascii?Q?5cPo1ddWEITxbNkOIFNF363kmgU0M82jNEMe40y1dbVzlx/Q89sd9S91lJF3?=
 =?us-ascii?Q?T4ejSFrkqHKs+kJsIIhfXAo4lrN0wbR7sOF7unNvFo0uyK9Ores1TlLqYlDp?=
 =?us-ascii?Q?MuvAgpyLUhakHKxealKkfUdqc1zvF5TWWyYS0ysf4xPfT/vh4YhmC8/fakQH?=
 =?us-ascii?Q?3DlWwTRKbre6kyRj0mGmhKzLf7mdTKItYurBf7adD6q2yC6BpQ7Nf53mW/cr?=
 =?us-ascii?Q?Mlv4fohajWx7B1AUSWd2Ie2fcQhTh51LC8owc8EUgVg7Tyx/0qSVaFlKOmns?=
 =?us-ascii?Q?BMMUxpIvEUSL+PF76HMplITXWu2+U6VjaU/PM0dkKy2Pwe2o+AqxuwHO7+uI?=
 =?us-ascii?Q?5s/cRcQjuVSOUpqMdJA6MZyl/Z+nPs7E6KvFWz1Z42tsEIPuPhcZVRHf1iBv?=
 =?us-ascii?Q?fPxozagMfcxeso7nEV7h8HbVDJBUdktnHjDUvtxK+kxhCZbn9J8tAlpost1Z?=
 =?us-ascii?Q?wwtlUpliOywgN6D+tYfqFRuVSc7AAwevXwpIwqEmFoPkdyT9Yz7b45W/M2mD?=
 =?us-ascii?Q?ZeJ95OYmSxHs1gXFQtd3q9zxcTYNpzBuHkQL5WYj6BEFLm0XTRXHj05ih2uE?=
 =?us-ascii?Q?1/c8fVEiKhJjvCK0bVAFu0h4PIQAc12uMMH9cZ8iuE3A440k8RsnXrNny109?=
 =?us-ascii?Q?I8nB9Sb8pTJ8PAYm5srmEwK8gvwjAfrrbek1hVxMB/lowyeD2xCxuoQNN1tu?=
 =?us-ascii?Q?VCuxRj6H1r3RGZjfdAZ+CroaSo0yOBPDA5lkvN1btiSFQCF5VDpVILzZobIM?=
 =?us-ascii?Q?xBmnuiuB9KmrQeIhPzPImqseItpT3hGY9zoip+lp7nOFUJXpXb5/YAZMwl31?=
 =?us-ascii?Q?0EL3wF2AI6VI5aYyp8jts29X8jZ9TZYA6j6zLcpTx/PZroKxFezd5llzquX4?=
 =?us-ascii?Q?t+U1stxRV7THjJ3USfs8MoH9GGuSvzbYM5iLQj2Rsr5ruUwcjWn0QgJXvpzY?=
 =?us-ascii?Q?Zth5jZqIwUlISTMaxCTCtMDQFvfl/X4iNzx+D7l7Wt9/sBMr7by/2F8jZaT1?=
 =?us-ascii?Q?0DIoRL+A/Jd5irHvToty6By2CU99QL9K+FgFguRJGgwFJEd4MzOlEJJ1cNBV?=
 =?us-ascii?Q?hd206byQWYGRezlHoDqbEl79IW7o6vWAQodmCrNguRjffw4gpUrKjujHeAKg?=
 =?us-ascii?Q?spfByJlzaCGbE1HKuhS5zeVQka0Yy1ymZSHaUjRGbH/HZcWHhMDH7fJ6nkYw?=
 =?us-ascii?Q?M3HEsTR+utNtqmAvWCyWsi+X5w9AHYgmfiqzagaWQ9qwmwv/K4hEGMFlX6MQ?=
 =?us-ascii?Q?GUehLGRy8RBOH8q9P41sGG/N4vOhSZNgH5OcrM9kEabWcUxdAZB8c99IuE98?=
 =?us-ascii?Q?cj90y/3xZKRa/VTQ3RUkhWQJpe627c4G3sxb/6Z0n7+p4sQsYbmkJbviC9Ug?=
 =?us-ascii?Q?pbNDJcs2ar7o9n0y4+bcpNKbyCkMRcoFhL4B0r/JvvXXQSBdKnQ2QYcMcuMK?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	svh76y4cjUgtfXZXtAoZjiyrWz51qBa5OzQRwMbul9Bcjvh84BCMraApwh9kVmMz597zROHjVmPIKbrkt/uB9S0yTqhtdxSri0XZp/BkTyZWA4zBK5Kc83WKfUstrhgJjb2O+pwt587Z14R8qFCdxNNYGKMO8T38tpQ3+1zVrxX6zctqBVf+Y/UOwOldhiRkr1hlB+aLoZv3UxKQ4yaBzu9dGQ2+89rqe+9sZSAf5GdVCRidsDdqPboPsCVhJR5eDSBXN5cQSU6YRFC4eBDYuGvN8niCMb9lxRPixQj592W5bn/kZZysMuTtMbHqQfKRH0g3qJHT4RHMIS++C/KalVfsr+PHKUygRyNbnFtVj9FspzzvwZoiZ+myw5pxuDC2j6YdVubMFiiB/yn9vRbD/l869qvFvWjkiriTKXG+XONVhIC5LzcF/oWwQ33ITy8TNhbBpWMyAGxik1/6lrpGrzjIhD4Gcwd6jHJHdHmVHIl9k/FvO+hbA4jgj3sXmc7ox+jldKBf5HRBLMY761GWLF9igO9QaEl8oTGhm197IQPLyhEFvN3S5wZlAqsBG9JKElUa03Ix0krUOZUv6MGPdcYaS3wp4JVbOgxZj1NCEYU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa785855-44d5-44ee-ea28-08ddc3840487
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:43:13.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcP2ufkPMGXtqW9DmiJPKdwekjWMp7a2ypzEF+pU0+fbeQ/f6hipKV86fw5lIBVMYAIBy5WbAB1miKkuWltwLOm+Xy40NPriALyi1cH24wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150088
X-Proofpoint-GUID: 6OO3YjWqKIs79KwZE8t4aJxBOePKH_GI
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=687622ba b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=Q-InONDA24bV5Mmoa9YA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 6OO3YjWqKIs79KwZE8t4aJxBOePKH_GI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4OCBTYWx0ZWRfX/akk8NT9DRG/ eOOc3cMM3jtgt6XHInzdiTqiHvQ11rc0AO3ObbBI+/3t4+C/gPXGc7Vv1mQjy5+jEamS4+NFMCI nimvhT4CmvOEFRfwJDi2mq8Z3Puxs7AaaBNbmfuWjjQVuTThZ6Vg1RaZ1XiNm/aiEis/Fi6jJ3k
 iJtnZSU7BumWIsT4bBGS8pcRjZnBnisE/W0mgtbMFwfWtsiGoPaEBvDorslmfn2VTabuCKZsibb Rp4jIR5Nhw5+HH/B/Peta6t1weRb2j/i+NzyDCujN4wykq1zcBG8lYBobn1v35Fcv0T+hU1An1+ mEPKRuQNseCNtFP4i1eDVUIc06PD0Z7iv2t7n86X+YnfAOs7IqOBDl5sedmTzqZ+hyvNF/IQo8X
 ScHCiA/K467i7nN8WqzK1prYt28j/knlKYFnvUOr0OQme0ak9wndCDOF5tfKY9pEg2Rs2HDS

On Tue, Jul 15, 2025 at 12:04:56PM +0530, Dev Jain wrote:
>
> On 26/06/25 10:17 am, Lorenzo Stoakes wrote:
> > On Thu, Jun 26, 2025 at 09:18:47AM +0530, Dev Jain wrote:
> > > On 25/06/25 6:41 pm, Lorenzo Stoakes wrote:
> > > > On Wed, Jun 25, 2025 at 11:28:05AM +0530, Dev Jain wrote:
> > > > > Use PTE batching to optimize collapse_pte_mapped_thp().
> > > > >
> > > > > On arm64, suppose khugepaged is scanning a pte-mapped 2MB THP for collapse.
> > > > > Then, calling ptep_clear() for every pte will cause a TLB flush for every
> > > > > contpte block. Instead, clear_full_ptes() does a
> > > > > contpte_try_unfold_partial() which will flush the TLB only for the (if any)
> > > > > starting and ending contpte block, if they partially overlap with the range
> > > > > khugepaged is looking at.
> > > > >
> > > > > For all arches, there should be a benefit due to batching atomic operations
> > > > > on mapcounts due to folio_remove_rmap_ptes().
> > > > >
> > > > > Note that we do not need to make a change to the check
> > > > > "if (folio_page(folio, i) != page)"; if i'th page of the folio is equal
> > > > > to the first page of our batch, then i + 1, .... i + nr_batch_ptes - 1
> > > > > pages of the folio will be equal to the corresponding pages of our
> > > > > batch mapping consecutive pages.
> > > > >
> > > > > No issues were observed with mm-selftests.
> > > > >
> > > > > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > > > > ---
> > > > >    mm/khugepaged.c | 38 ++++++++++++++++++++++++++------------
> > > > >    1 file changed, 26 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > > index 3944b112d452..4c8d33abfbd8 100644
> > > > > --- a/mm/khugepaged.c
> > > > > +++ b/mm/khugepaged.c
> > > > > @@ -1499,15 +1499,16 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
> > > > >    int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> > > > >    			    bool install_pmd)
> > > > >    {
> > > > > +	int nr_mapped_ptes = 0, nr_batch_ptes, result = SCAN_FAIL;
> > > > >    	struct mmu_notifier_range range;
> > > > >    	bool notified = false;
> > > > >    	unsigned long haddr = addr & HPAGE_PMD_MASK;
> > > > > +	unsigned long end = haddr + HPAGE_PMD_SIZE;
> > > > >    	struct vm_area_struct *vma = vma_lookup(mm, haddr);
> > > > >    	struct folio *folio;
> > > > >    	pte_t *start_pte, *pte;
> > > > >    	pmd_t *pmd, pgt_pmd;
> > > > >    	spinlock_t *pml = NULL, *ptl;
> > > > > -	int nr_ptes = 0, result = SCAN_FAIL;
> > > > >    	int i;
> > > > >
> > > > >    	mmap_assert_locked(mm);
> > > > > @@ -1621,11 +1622,17 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> > > > >    		goto abort;
> > > > >
> > > > >    	/* step 2: clear page table and adjust rmap */
> > > > > -	for (i = 0, addr = haddr, pte = start_pte;
> > > > > -	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
> > > > > +	for (i = 0, addr = haddr, pte = start_pte; i < HPAGE_PMD_NR;
> > > > > +	     i += nr_batch_ptes, addr += nr_batch_ptes * PAGE_SIZE,
> > > > > +	     pte += nr_batch_ptes) {
> > > > > +		const fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
> > > > > +		int max_nr_batch_ptes = (end - addr) >> PAGE_SHIFT;
> > > > > +		struct folio *mapped_folio;
> > > > >    		struct page *page;
> > > > >    		pte_t ptent = ptep_get(pte);
> > > > >
> > > > > +		nr_batch_ptes = 1;
> > > > > +
> > > > >    		if (pte_none(ptent))
> > > > >    			continue;
> > > > >    		/*
> > > > > @@ -1639,26 +1646,33 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> > > > >    			goto abort;
> > > > >    		}
> > > > >    		page = vm_normal_page(vma, addr, ptent);
> > > > > +		mapped_folio = page_folio(page);
> > > > > +
> > > > >    		if (folio_page(folio, i) != page)
> > > > >    			goto abort;
> > > > Isn't this asserting that folio == mapped_folio here? We're saying page is the
> > > > ith page of folio, so why do we need to look up mapped_folio?
> > > We need to check for all PTEs whether they map the right page or not. This may
> > > get disturbed due to mremap and stuff.
> > Right but I'm saying mapped_folio == folio right? You're literally asserting it
> > here? So there's no need to assign mapped_folio at all, just reference folio no?
> >
> > > > > +		mapped_folio = page_folio(page);
> > > > You're assigning this twice.
> > > Forgot to remove, thanks.
> > >
> > > > > +		nr_batch_ptes = folio_pte_batch(mapped_folio, addr, pte, ptent,
> > > > > +						max_nr_batch_ptes, flags,
> > > > > +						NULL, NULL, NULL);
> > > > > +
> > > > >    		/*
> > > > >    		 * Must clear entry, or a racing truncate may re-remove it.
> > > > >    		 * TLB flush can be left until pmdp_collapse_flush() does it.
> > > > >    		 * PTE dirty? Shmem page is already dirty; file is read-only.
> > > > >    		 */
> > > > > -		ptep_clear(mm, addr, pte);
> > > > > -		folio_remove_rmap_pte(folio, page, vma);
> > > > > -		nr_ptes++;
> > > > > +		clear_full_ptes(mm, addr, pte, nr_batch_ptes, /* full = */ false);
> > > > > +		folio_remove_rmap_ptes(folio, page, nr_batch_ptes, vma);
> > > > > +		nr_mapped_ptes += nr_batch_ptes;
> > > > >    	}
> > > > >
> > > > >    	if (!pml)
> > > > >    		spin_unlock(ptl);
> > > > >
> > > > >    	/* step 3: set proper refcount and mm_counters. */
> > > > > -	if (nr_ptes) {
> > > > > -		folio_ref_sub(folio, nr_ptes);
> > > > > -		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
> > > > > +	if (nr_mapped_ptes) {
> > > > > +		folio_ref_sub(folio, nr_mapped_ptes);
> > > > > +		add_mm_counter(mm, mm_counter_file(folio), -nr_mapped_ptes);
> > > > >    	}
> > > > >
> > > > >    	/* step 4: remove empty page table */
> > > > > @@ -1691,10 +1705,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> > > > >    			: SCAN_SUCCEED;
> > > > >    	goto drop_folio;
> > > > >    abort:
> > > > > -	if (nr_ptes) {
> > > > > +	if (nr_mapped_ptes) {
> > > > I know it's ironic coming from me :P but I'm not sure why we need to churn this
> > > > up by renaming?
> > > Because nr_ptes is an existing variable and I need a new variable to make
> > > the jump at the end of the PTE batch.
> > I thought you eliminated nr_ptes as a variable here? Where else is it used?
> >
> > Oh how this code needs refactoring...
>
> If we retain nr_ptes, then the two variables will be nr_ptes and nr_mapped_ptes,
> which is confusing since the former is plain and the latter has a _mapped_ thingy
> in it, so instead now we call them nr_batch_ptes and nr_mapped_ptes.
>

Sigh, this is still awful. But probably just existing awfulness. This whole
thing needs a tent thrown over it and fumigation... but again not your fault :)

I mean fine, this is fine then.

> >
> > > > >    		flush_tlb_mm(mm);
> > > > > -		folio_ref_sub(folio, nr_ptes);
> > > > > -		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
> > > > > +		folio_ref_sub(folio, nr_mapped_ptes);
> > > > > +		add_mm_counter(mm, mm_counter_file(folio), -nr_mapped_ptes);
> > > > >    	}
> > > > >    unlock:
> > > > >    	if (start_pte)
> > > > > --
> > > > > 2.30.2
> > > > >
> > > > V

