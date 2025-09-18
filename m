Return-Path: <linux-kernel+bounces-789902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD6B39C60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D0E7B5A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47FB30FC01;
	Thu, 28 Aug 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EyWtyXNf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ln/DqD6H"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167C30F7FF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382978; cv=fail; b=H5AGowLGN73Mp1XMeFV7VqouEX8hhA+9F7iJem9ulBCgsOHT+eYpUI9/5SRNr6GUEc8f0VaqhcqfsFrzlYyzqGq2OzpWTJ+32oXWsG+agvrGDRfLtKb/orlzmcCdsZLi/hAYf9vlGeDmlL61ncuW2bnSn6o2WLmNrGj9uvfPEXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382978; c=relaxed/simple;
	bh=XPUd7TyEakMaJ1R2nBw6iBM2V4562f7gmNCS6HMo/K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q2JXD36S3qviv8UnFRBCAjROvw4J6bWQFN2LB5PX1Ooq2BCYaIPReMdgvwtbqw0dqE/hRGr3DZSm09CgQOlT/cXcEgqyGCSTS8z3ahTI3jYuUVTf7bpbaxMZQusDQBCLjTpJF/b5PGIQJ9eJGBPPAQ2U14mVyJs5fvCHPhkGE/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EyWtyXNf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ln/DqD6H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8tmlQ021613;
	Thu, 28 Aug 2025 12:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kkLDpO2J5Fog1JxFqF
	Xl26TbhBCJ7rmBSpP6Y/uE/Oo=; b=EyWtyXNf+aFr1Rv6I5b5ZL8aEPxNexfTUM
	T7PeGFDC4hRxCUVkPqglXvhXJNYS3NrcOvNr9zWiAgjL7ZwBz7y8khR1j1yO/89U
	rv6ybdRRH4Y40K/cSxu9GdRV+R9deHFKXi2pzB2UjO6CXupbI5y+9x7h+x2iG6as
	MP0wiX+kEayWd/aoapkXuA+2HbF/f8k+gDLzWVdO8mF/LW7QSCD8E+4/xuLPGVXM
	z3UxkYhmcMQWQJtuM5jojFk8KGI7JaxuNHIbBbCKHOPPx4Wa40DkQ07hxm6eXnh1
	ZuuxcrnHPZWqG60otQzD2q4wb+1xKXnxlT6gCnos8/MRpP9Fysug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e28f5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 12:09:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SC2Tsx014788;
	Thu, 28 Aug 2025 12:09:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bt4ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 12:09:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uu8vJZWljuEG2Sp2nDRkfMO+pHV5yziu8fldj105h+iJ1Hyk976uMyWm2SXNLkN+FEUN/s1YLg5eNhPdCNwPQK5R7c4qGIhuZt0qxzKzwEmQdPmlhajNub6pZ/9qqNhg80f7mNj7XErapetmHnBwB2Mw4V5ptiSlQZ4vs1hGGpigYv3ZjokNlUTdl+alAWMaGATN8eyXksBq5CvZXLKApnRwOkAkWRG+P8IZbNTYfbXxFo1dFwQxSUAMgkhjBGm/8CMJKeWYUGwzM7N1eVt3TZLIfqQiONxA4056ovBYnw7S0/Xb5Im7ReYrvOk+Dm7xECaIYF0370s89hxiddvZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkLDpO2J5Fog1JxFqFXl26TbhBCJ7rmBSpP6Y/uE/Oo=;
 b=kQO5++dVemnW+tCobDEum3K9vDvpp3KbeoBY0N24HPAmm5bN4xGzYHS99/756ilqSqz2BCFe0XnutQ1KWC1vxLqmX4elXt3U7MWO1r1VIYOQIHXceMeBMZSG1QjCilgwVLQWeahnx8hmxHAFE8dsbHyy89i57EFyMSehuAQEcC3eEOLm/L5ijmolcGbBVrMNBIDWOr35DpBIuLUIN+PLs9QXynAB7KQ6VJFYuKQTBEH712GpERkzJ3E4hUFtdYOJu3uVd76KyPyG8kYDKYE6RbSfmPieBP3VSFDuTYacYHFRPMLOHjAy+rHZ9ArcqwDc5nHUxQZCde4MGx0XB2LusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkLDpO2J5Fog1JxFqFXl26TbhBCJ7rmBSpP6Y/uE/Oo=;
 b=ln/DqD6H+KzQrsbHRTWY6O/Uu2wmXmRrV8rAGDymZvJ5N6VYcOVjIO3vyVNidRUvx5uJmVkcj8T/e53RPIV+m110Ohlxg/wkJouyHVE+UK8P3mkt1vCq7VsvBuTMw0aL1eUZ2kD5NHrAJTEPAotbumR2jxwe2xe1ywObxvqwXZM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB6217.namprd10.prod.outlook.com (2603:10b6:208:3a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Thu, 28 Aug
 2025 12:09:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 12:09:15 +0000
Date: Thu, 28 Aug 2025 13:09:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Max Kellermann <max.kellermann@ionos.com>, david@redhat.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add `const` to lots of pointer parameters
Message-ID: <74a33635-3348-4e70-8cdb-16307f839b79@lucifer.local>
References: <20250827192233.447920-1-max.kellermann@ionos.com>
 <20250827144832.87d2f1692fe61325628710f4@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827144832.87d2f1692fe61325628710f4@linux-foundation.org>
X-ClientProxiedBy: GVYP280CA0045.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e99550-e60e-4619-87ef-08dde62bb4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Z57hBASaU65Z2Qp5YrrMVXMMNg0bmic4V+atDEmaLvbHhOfTqEYTB7BPPNz?=
 =?us-ascii?Q?CvMB8eMJE56OlzNXStx6s1iKX5nCUdZUsVMku1jyntCqfkzE8MEDLYMuUrlE?=
 =?us-ascii?Q?miQyfcWLFZylU0iCnvC5by7OTQ84+BpxmbW8HtAJcRKBmHOlC9gYJpWL5w0N?=
 =?us-ascii?Q?jVP+fM8s9O0HzagNpJH1/7U0WS5gOkNmr+Ngs6sDdWt+EMVy433dt9NsNfBG?=
 =?us-ascii?Q?0Jq1rCqQqavboP8LC641sX9m2SGWBnqXKbV3wUFVhgl4OKHt4dV5mPYxJS4d?=
 =?us-ascii?Q?AID+OeDHX1krq7cOwbh0g1QUaANd6SW8tE4WwWrfkwOQsi0vkntG05Mpc56r?=
 =?us-ascii?Q?P9vr96WUK3nvV/o2V/Awpwe+wZlmPWiYNcMbd4Rm8a4LE9Jpftt5HYKUBBez?=
 =?us-ascii?Q?WBkkl78UcM/QT9C0WdEeiOpiXjox3AxvcI/6nq+rIv4hgzvSbuGKm2y3PHjz?=
 =?us-ascii?Q?4MbkLRI8OAa7w7qXyuCTVis+jCu7v2RMVmYYVnn2BFILe8z/s7P+PjKRLSDY?=
 =?us-ascii?Q?SPIH1vZQeHPB9428eyyDpDWde5GjktJ/oTIS4nZL2MTn1C8WQ2S0dR5DagHA?=
 =?us-ascii?Q?YU7xoDiQRGe9h+9KXYufFVzqn7mpbcuyN5IO80HcMm40AgssJOSvq5o2zLJP?=
 =?us-ascii?Q?j2qvWHqKoezs6rOkIDDsDJUG+7h8ReBQnQaA87i94DdIWNP++4GeZWZvuwCL?=
 =?us-ascii?Q?JFKjMw1uHoerC6URW2Fh4Erj9muc9IOBixfHsdjHs6ZsjuKzdUisQkw/UvXX?=
 =?us-ascii?Q?IdKK7LualLhv8TGqvAZK8M2AfGEmjOufYYrD5a9iLOVP2K1faY5XbdgqEX/m?=
 =?us-ascii?Q?Dtn82fOTyhDhgRRcqKek0g0BJsefR156V3nrOU733Z9u2wwnc+agGYKRlZzO?=
 =?us-ascii?Q?z/GAJJHLAWAfcoDYX7lDmUS7sY9Gl7EfRBuG93lq8gEYlcDGWOEWsKH1TYPx?=
 =?us-ascii?Q?qb71lytzb+8505rZI2hPsZyV513Bl5n/NVIHI17l2+UhsOReyC5XDLrWbSQL?=
 =?us-ascii?Q?bOfiebmZHebQjd2cZqXXi/KMsOyLsNArou9qamu96VS8vEnU118x04aTX73c?=
 =?us-ascii?Q?4zlxrqk0YgZHLPWLZ8IYp4ekUM8a9JjY4S3nYfPeLILiPfMh7cbor77Iscjw?=
 =?us-ascii?Q?tDXQzlzBGl9peLIQTXjGbAUvA9FTDp4yiFiRFFhVq+ZsaRHY7NmdhU38CL3B?=
 =?us-ascii?Q?1VZlzsDSgByb5CPB97MZk2kN+axySubimt3zqd+HHg1EsiKNTfZ1FADtkr0x?=
 =?us-ascii?Q?tm8uyyD4FjClhK23sqJIU8V9s6uH5oijM1o/FhR4bv3XJBbxUYrpGoArYKPr?=
 =?us-ascii?Q?bWiX0R23HJcpJfKHRM6SAVE27cQVqUbjOsngZJAl+bZctXRBqQKW/Ril1Ln9?=
 =?us-ascii?Q?I4PhrfjNIillG1usxR/A3OVHsROfvYpp/0bKrOaZHcO4b4ui5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2dtBYv4slsEvVNqKalNaoucYHdj1yUtGEy4Yn7zGQsdyF+olHeYdKCuZ5BRx?=
 =?us-ascii?Q?Z9du23otE7HvfF5yeteMfih5xRrhQPK+IFwVyRg9GQe1aW0hGrwww6yb3d+B?=
 =?us-ascii?Q?zTOqhsD63WuDIMlTjNcFYN0w9cbSicNlGRAQu0lIlt8dJhQKA89ZMJJzSDBr?=
 =?us-ascii?Q?4qvogGosXh8zbRobOAilGgfATEwKCPrtU+EAN9MxvAQBUpXjEilRVbI8gZFc?=
 =?us-ascii?Q?2M6KtnzLw2yw/KgvuRyfqRvDowesaW6tuMbwEDuzeR+ba/V83LuFHVcY83y0?=
 =?us-ascii?Q?AJfdKsyV0VGk0S2MiIL1lLtRwCEP0YyKMBg6x8jf+YT0de3LT6pvbNqqgh/v?=
 =?us-ascii?Q?ISOzw+eA6fcq1q8ktNXojyBfajkx2STrBQWFMunQprdxl1sqcP1YThZ5XAvJ?=
 =?us-ascii?Q?YIQer2fW0uMcOIvXo1x9+8PgS2r99YMKrq5p+LJMOecEsxDtmIBa/eKSp1uK?=
 =?us-ascii?Q?JU4ZI/GLDZlbmRJBYElal4cwvJYVFf7r8ZuOxOfuAo38/2KPQCwDWvn+BE/z?=
 =?us-ascii?Q?cuzHK27dgVlcU2+q2MU7l6TfmrwY/09/ZHcGPVwnS51EA4iE+zF6rt4OgeRQ?=
 =?us-ascii?Q?maTlDvIh5CiFJ2lDWE4igTUuYTW/FuMRsbBoQWLLcrjM0SlMBqlqK/9lyPH3?=
 =?us-ascii?Q?8gCbNKRizfh02Q8C4+VLiHke+LaFL9vRZzToPz8EShFWlxVaA8nD9wTOBB2g?=
 =?us-ascii?Q?CpXNA4AVGSlb/NJOVznvQwcJ0CIYvcrUFJOso5Qgp4XdzfhufY6PcRjFXTCd?=
 =?us-ascii?Q?e173GsfXCSy5otV+q8k2tRFa/Grj4ZownJQDTppSzY86Cm/E+cwXtQHUZZtp?=
 =?us-ascii?Q?wuaMUgY8dqvyvoLwuZDArdJIRXohcYQEHiJW1Ue+CL2h6J3n+nYtNTH0mcLK?=
 =?us-ascii?Q?NJR8fDApA2GswJixxErCuL5eU8U+yJEIuvHnLaUiG6Jwmz4hFDF+GaOm5fv0?=
 =?us-ascii?Q?6Vgn3O0Vy4GcfjlcnBhCsjzEgzueSDAGJFmWgXCPZFtEaj3m7POLzYlMANdZ?=
 =?us-ascii?Q?G/cnea+4n0FCJVk54d6Z06Euw9r2+8+w+9uSRldG0qpcms7ne2Sig2eBMWIg?=
 =?us-ascii?Q?7Fb9IBmUpHR5sw5TAP1mXgn+KYJhpvyqaEJ9jAQBe8vNnabHtNt5bQkxCNpg?=
 =?us-ascii?Q?rTZ2RE5PziMRxlkpGHF76VgpTXgh+dbVnIqvbA7ESajAw7brDekKVI83o1Cq?=
 =?us-ascii?Q?twdExQusEBpyNR2cfEW/VcJAlnhTtWOY8ZNSQ5gT8etEDSmqMddToCVfwIOm?=
 =?us-ascii?Q?naJnCTe3tdbKQEf7BrqDaEcrdbdKnxENdg3FiaJ/06/pqHa6tc2OTrvRbnIs?=
 =?us-ascii?Q?MW0khLV+hvxNPX6T0qvbW77NTegW9CNvvLwLD0PAe7v8YVZRsLtryPteC2/u?=
 =?us-ascii?Q?Z9f20etDThh2+yr0dQz+2LgGuU0p3iZKGMdxa3jeFwjm6ljZ11nNEkRM3+Yd?=
 =?us-ascii?Q?Nhwn0a7Rx2rTK1Kqw1sTb6p4LENKhXTCIXAxMWzVu86qmXtsMGqocu2gegUF?=
 =?us-ascii?Q?TtRjwfBeACY/TmShVQD0fCjEPJ2w3Btb4gxHttGbSYgjBCnqRc+qsyuYS6Vq?=
 =?us-ascii?Q?+mu+M9zkqZMlPXuiKMVk2bRY6Ph0Sj4pp7FRw0z4HBeL//eZl/Re5cT9NhKL?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XoeWcDpK2A8eZ6vN9CLGOZaR6Wr220gJGOC2YR1DyFcU8jy/ufgNROluzrmbRCoHfts06+HPNUFswf6wWIKFEvtDPSPNbQQLm/MkI87RwKfSd7dJyWwr9B/2gLwylAp6s7KDSsaXkHD9H5UY1h68Irne8pLgCSgAdQS/Cd0LPAno33j2LRq8yU/8WPeNxFee7yyV7lJZlyDbyI4BzPtOz6cZYLwX3HHEgWXbVXcsw6dxp3FlM7xo7Zkw2k8yyVDIsv5OoXihzwJSof1D57+kGA9df06Ijx6wr4y5OCb+usqbf438XeBZtqiGueVv698PFI6utdGHl4kKoDGCHBvDIS3MRm2L/sxHvabqTVIeRd9JKzmMYTvTnnWhsixXYUI4Oq2Bac/P9DO2hKOcikGj/qWitCeprwFx9tVt9kCwtoY0JfgQYpdI7xynmrudGOSivVX0vvKw6Yqn6dgiP2J85K1RfEJRXm39sBb3QJdT+gcI5QOUsO4MeL3rHESc2jtiWb7YFR0RTGDR5UqRyU+9SzPXgZGBXYYpZdGznSO91BB8SFS7AWon1O2KFl+Y8022OYZop9qmcGWv4hmE6sqpakp9ftMyQ/1g8rX8kbYadyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e99550-e60e-4619-87ef-08dde62bb4e9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:09:15.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XO62JEk8KLNxI5ArVZ6SjLe1jAm8F1IEDGg/cZ0wVmy/ukIg7dMoW8ZiLtOnOCJtVAHdTqqlSgFrQNycfr6dLNTxXTnvZwyRaq2V0/gMdWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX0UgA0A0bDMHE
 uL3Y3QanRu1U3iXQ0fBpDK2lL1fJLzc+EwLLbwnwGn9u87Gy/rlcza2tMliDb49H/Eh+Sia8aLi
 lH2aWcvVOeRRdt+zwytBSsj/6K69Ydhr7xG8mj+bj1k1K4PMZaHh80oqdjuvQ0ayBQMc+GANFJc
 m8Rgh8Dt+/IlIWKUWYEIKnQ22ssnvzazSspVoMOW+Y+zbHmM3r4+ZYUmIBg2K7zEiT0OBh8rxUJ
 TxQWXkVnyDdGjyei1oAC9xrhj7TQwu8m9O05HPSKT/uUu7+Ebpp5R/Zm4645ezbsHNa5SKZeZHp
 rU+MhVHNTx/CLVJMm/0ujpCA7Oqpl0cX4I7hmx1ARWqIHqzI4ZaWaKvnwlGdpYoz2rZverjKPeD
 tYubvHm0N7DJGdRACqjCU6mSRQIf4g==
X-Proofpoint-ORIG-GUID: J7J0i3pX8mKfH2jI1G5vFKwpSUTIWKcl
X-Proofpoint-GUID: J7J0i3pX8mKfH2jI1G5vFKwpSUTIWKcl
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68b046f2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=-5_ipbWy7f3QC6ut6rwA:9
 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22 cc=ntf awl=host:13602

On Wed, Aug 27, 2025 at 02:48:32PM -0700, Andrew Morton wrote:
> On Wed, 27 Aug 2025 21:22:33 +0200 Max Kellermann <max.kellermann@ionos.com> wrote:
>
> > For improved const-correctness.
>
> OK...
>
> >
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -537,7 +537,7 @@ struct address_space {
> >  /*
> >   * Returns true if any of the pages in the mapping are marked with the tag.
> >   */
> > -static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
> > +static inline bool mapping_tagged(const struct address_space *mapping, xa_mark_t tag)
> >  {
> >  	return xa_marked(&mapping->i_pages, tag);
> >  }
>
> I'd actually be in favor of making all incoming args const (C should
> have made this the default).
>
> Because modifying an incoming arg is just obnoxious.  That value should
> be viewed as part of the calling environment and should not be altered.
>
> Try modifying a lengthy function and wanting to get at an incoming arg
> only to find that something in the preceding 100 lines has gone and
> messed with it.  Or forget to check fr this and get a nasty surprise when
> testing.
>
> Not that I'm suggesting that someone go in and make this change.
>
> On the other hand, it would be neat if gcc had an option to warn when
> someone does this.  I bet it would be simple to add.

This would break half the world, I've tried making parameters const, then
finding basically every helper function doesn't function correctly with it
+ having to give up without needing to change half the code base.

It's kind of a dominoes thing at this point.

Broadly I'm in agreement that 'const by default' is good, but there's quite
a big price to pay for this in terms of changes needed for really quite
dubious gains.

I think perhaps 'const if we can moving forward' is better.

Also note that C 'const' is _extremely_ weak. So it's more of a 'readonly
kinda'.

