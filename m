Return-Path: <linux-kernel+bounces-740938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A3DB0DBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA231889A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28052EA477;
	Tue, 22 Jul 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="drfTqe+b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kh3QF5GM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291B22CBE9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192462; cv=fail; b=jntE+UIKUN9eXZeRnGzsL/mrsns8Ny+BmuBiFLm3gDox3Yz6jCICVK+ViXGzer14Sx/Mgdjzx6RtXQchD/BxPjIlYemXsbiJkmFjeJDjcW/XfN40pMPSYbAEI4nvuTQ9mlRtY3uzlrP/KejMPLpN9UcZi6CWa3+RHR80TtWIGSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192462; c=relaxed/simple;
	bh=N1Dhhke2n5XsPJP+jOWeGgVeRz2fxahP+dPQpawff+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RAxI3GYdGEHpiBb4kTHq+oolzOnnoXjDK7y4Pt8GUCG+Jnc3Xrpc0i/OJxwR1yuiXSjhdv9Rf4uP30QHt5TQkTTNPEG9pPMgsXvFpoARln9N+s4mnSKxgkhEOTN90rrFfIILaPl0kvE3IwKbsLbrWZ6S6P09G8K/R6kKqBDLx+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=drfTqe+b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kh3QF5GM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TC5J006872;
	Tue, 22 Jul 2025 13:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=g62j/1oLS6sslb8N7K
	4QRTz/7ZxZzH4uSyeuV3/Q48Y=; b=drfTqe+bXLRFzPzq3xbljP8FOeVH5tkEXB
	8LiWgFUNRtd15Hkks2Gnk/NNxIixFsBIFAGob26MYbjX5C9mvXICff/Er/0jEQrF
	pxoz16Pu4EeIkxTrvrXzY0Q6pA1ykaHdRoLsGpfb3K5QbETXq8yS/hEwvnGGStmU
	6/MMiNKnibLRohTl17Mq3vrZSDpQSOvUJhvR5FQmWGed4waN2bm7Qu27puf8BNa4
	LmxduTmtsQhoaCuOmTPEVr1tcgr2ySIgwCpGQ6oAPlLSvqWFxrBMHZmQEpClF+3F
	EgDnw2LjkOYxBKf7uUcaHtbB1GTaRD0dvnXd30T723WCE6G+HyrA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2d7f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 13:54:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MCXuBc005743;
	Tue, 22 Jul 2025 13:54:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t9bsbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 13:54:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doLHM0HQzLw0f3xwc2TFoSMbxcvHYgD9+cu9qKtZGz5azaNaJNzz/9YjZ50Pw5o74KquFcrbef+tJqFkVCAL/pIBX1qI+Vc1mOZz7YXAa7wppFbf7+tGkHLeyzcV8D5rUHhukFx3Vn7zR+dZ15GrTpoEwqXHTGDWiKS/9QSYTsKb4bMEeFCYiuyBeGgiHkrhxAjHWKy/KIL/plRs5yd/2Hph7dBoTz//2YoHiGfoC4OEudt1h5MFF2jDXTMTVF/mWBDsxwJOphRO94/ofcP67Xqv/zTojCjYvIuufblYhBOSMmBNqXuMmGjJdb72/jrEfylV/p15xTA/Z/ONIHjhuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g62j/1oLS6sslb8N7K4QRTz/7ZxZzH4uSyeuV3/Q48Y=;
 b=TSMsqLMmcoFAd8xnKJ1LnwgwWPV/c7A3WXwwEZ1ElayjnRTObEvuLLf7kDSUJ3YIHHI+4+R3UPU/IHGMBIjkIe+Zp/izcvkDcyWPWU66tCtncM0OFl2O/cdXfxpBKBhVEHhhCim7TVEwXmebqIWwgsyPpWfgqp7tNkh8nonF5JU4M5H0OhSj0sekwiw53q68EiTABIveD3kzsmPNsZN5qX1jPMYkeg5VFAe/bxx5ri/azeewcDh3KI+rCc+kHadTwaz6GDvyIk9fsJk38DdDpPYxfFD6iSx36B/mHBnk24MGyseXRGUhANoQuh8FX6w43Z2kGsWSzqj+8ftariCRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g62j/1oLS6sslb8N7K4QRTz/7ZxZzH4uSyeuV3/Q48Y=;
 b=Kh3QF5GM/cf4VSSIbKPde+rwGI55D1+4+fzqa7CRdgc7zDLvu1Dp+O2ATGJckSjW44zIFuc9GNnS2myP/2vK/huVksa+bZl03xSMXenVj4TmdObtx8aTFmBNr/H2ZM03FJ4DViMjL7FaeYDFlyuALgoPDEU9RSOFhkz67wKY4KI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7561.namprd10.prod.outlook.com (2603:10b6:610:178::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 13:53:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 13:53:43 +0000
Date: Tue, 22 Jul 2025 14:53:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] MAINTAINERS: add further core files to mm core
 section
Message-ID: <33c605a6-2b89-4b40-ba80-ed2ca665ef5a@lucifer.local>
References: <20250616203844.566056-1-lorenzo.stoakes@oracle.com>
 <727b5e89-89d7-4abf-a93c-8d6f2cb2c438@redhat.com>
 <aFDm0YrbSAvXc5Wp@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFDm0YrbSAvXc5Wp@kernel.org>
X-ClientProxiedBy: LO4P123CA0681.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd02cee-a86d-4c58-271e-08ddc9272b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K7wk2ND/oIB3wJXGf5vqT+NXSlkgEq+r10tx48b8wan3DxR2o63Rg5EQA6Ap?=
 =?us-ascii?Q?ZrLEM0DZn7jBNs/bAC+EsIX2Tbi/KurCaQtH6i/NcUTnZibROa3SByMqL7uR?=
 =?us-ascii?Q?NYH4l0U8umnOsn5LYQS0GAz9eGviBaJ01ELOzJwhPbWoZEq1kDW6w81OJU9v?=
 =?us-ascii?Q?3UQ8wupdTQ8dfC3CL6F2Wg+DGcCbKqcULfrTJtQ27eApVRRkAXcGSaSFQlsb?=
 =?us-ascii?Q?44vqQslLyVT1/DyOHlJ64eiigsPzUJHQWZYrR8vElmNfLdvFaiRZ4R+BjtJi?=
 =?us-ascii?Q?xFB173CB9qrhklzgZDVlCMNRIW0YdyZnalzsVjUwGXgoPCEKAq+2iHSgGEq1?=
 =?us-ascii?Q?Jy4pspx5ae4xWWJ3/hx5RLxVqKEx8bFAiiUB9cvdnIcNvxpN2eKeSrZciltc?=
 =?us-ascii?Q?XlZa8lXOWti7mhzGe5Ob48bCiLebKRlLbBuRUK/M5VHlpaNJCASSrcN7Bk6v?=
 =?us-ascii?Q?CbdCt8XfotBfH2vk3EAlXMiYUE6LMAzoqfkDC7unvmCqwxvwgQR8ukqpeIQD?=
 =?us-ascii?Q?hngj8uuOSvFN3vqfN7goAZFuDVFoiGVSOaMJow3qh4671Ol7Xbf3of5AP5vW?=
 =?us-ascii?Q?W/RtsPS+qAMhDvIHe0AW04iZk1SukCbSnA4u8QzbAFsASbPCUdvXCu2fZQfz?=
 =?us-ascii?Q?Volo0+bV0MWdwRntYhs2eCI/+zCdUz6djnKYDWBFkSUms/AAVNDRlQMPbvus?=
 =?us-ascii?Q?qTIxV4Od3l74gQlTioYOzqyJu3yjUOD0E8i6/GmswtpsM0jmW7u4uCJgNnXl?=
 =?us-ascii?Q?tSYsZOjqILuLQWBZETxK/5if4na9Nhl6V3KanBlzUgQLWOFG+7Ycu78s75yz?=
 =?us-ascii?Q?kDn3Aeq6zVXNLELAFVZGe6sw8eN414bRCGtkG+jZLW0f3lx25vuuU8UEBD54?=
 =?us-ascii?Q?qoVkKvK/lXdToGiPHcfnHK25/ncs2MTcZvIxMvRKVSr9+a5eGDPdc8fJTvHL?=
 =?us-ascii?Q?/WItO6OTX3Xj6+3Pv53nh4KzV7pcX0DZWjXy2isP+q4VTv+4iFw60+WjCJeX?=
 =?us-ascii?Q?8mcmGQBiKt2zJ0pdxtfDXw9lVaQqwiu/yfqLZhmCf5RSCAF53RHZi/47teKM?=
 =?us-ascii?Q?uL/gQ2TA5GiTSkONzri9bo7piP/WK6jhonowjlmdxfPIGho//3+zlTtNz868?=
 =?us-ascii?Q?0bDr0imV0SSlKPGrhLotrojyLaxZzhU+gF3nm+1NweWb5Jh3dBCkGw/lMywT?=
 =?us-ascii?Q?FtbQAVffxt2mttGbuf6hCM8ahXQGSGuqR4LaAVnWI2P/yPy3PTeiJ7GgPLp1?=
 =?us-ascii?Q?YiMNXjhFiz0n6b1/iWEMeh7+O9c5HUKUDDzpaJnO4q11lnNRXldAz38PqboD?=
 =?us-ascii?Q?96QxStCnAVI/zvaBzX6yipdelZ40/1rilhpoL4ca8feBhwbALyUZi3iVlrTP?=
 =?us-ascii?Q?npuMKOcdpVP8sBudApgq2Qr46dqXcGde38neXor4yB9+bBv2Sygr0ufub3ve?=
 =?us-ascii?Q?p43ViSCs34M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eBool/uIPujTSM+FQYcdHbazXtARdOLk5Kv942i+kD7NtrXOoz1DTSHLvXyK?=
 =?us-ascii?Q?o9ws18VYvFVQgT6sH9pz8HW5CXQIyhrXu39MT/r6zJV+a5EJn+zOUYdBqm1+?=
 =?us-ascii?Q?jEhHSRse4mXJDGUAhx3ozfp9GvE/5CHKPL55AJC0lthA4oJMH0Z4XIybrI2l?=
 =?us-ascii?Q?6OSgEu2DYksic/QV51NuJ1pfg8lP2jWAU28VED7btknRZDnh84zBaLfcIHxa?=
 =?us-ascii?Q?PnGuiS2rcPLbJwFLGkMJum7ghkOImOQX7GUyv6bBC/n+N7mwu5c+Me5tmtQ3?=
 =?us-ascii?Q?wy+dLwIa4kqbNcvonaenvk1YizMu4yAl7GufzO6Nf3+HtYoMqGx2Qs3xIFY+?=
 =?us-ascii?Q?Fs7bW3kadzgkZSvtZIYrZsIG3odUCVYtmUOCA2s2LeVEkiqy0LhOLxEkVIKS?=
 =?us-ascii?Q?1cwKzjx1f667KJdFKF6k5LLEp92Uy+oSVT2ERcM1gniaqRpWa4IhPBdZesUR?=
 =?us-ascii?Q?SWYgO9CvggzLfumhIJRPfWLbVMofhjdPlzCTDPfiIxmikRY4B5j0NLDgvHht?=
 =?us-ascii?Q?JnkJ2T9/FhAZAiB95CvethoCEtcPp6hFqM4Zv231mKwP59+FT9nlfYgUmXVl?=
 =?us-ascii?Q?uvZC8YwYAutaCFy2UwKFheyuy2Sggi37NKdP9F1zrUGC5ZpzQ0TL8A2U+CKO?=
 =?us-ascii?Q?4YaoxLLXCmV12YbmQBEXNp1nHlfB0EniS4/DFWKd1Yt7kw7jgonBPIAb5i4o?=
 =?us-ascii?Q?JRp0+64OorVQnTR9xnkFxJXtZjUs0rbr65OqOIsuIJE4CVacF8M0ILx65mVy?=
 =?us-ascii?Q?5ceZF1r82z4U4eU/tRIp2iRL1F7iZsS5nIoWNeCk+47diWymKcgq03syboz/?=
 =?us-ascii?Q?AUGU7S2mM/6jNM9uCGl+O4EnJakjm8TxW8Anp4PdYv8yV1D1QCjZJEPY5Y9l?=
 =?us-ascii?Q?rPEsFjtjbiVnF6JKbbEumkk+I/Hny/VCRj8Be0uD4X992HUrU7hpTbnIp/rw?=
 =?us-ascii?Q?VQdb/DtXbmO4BIuMiDWtq430Y7VlIivzwudySgR3AUa4+o7rjpnKI7cC+4Sr?=
 =?us-ascii?Q?cqnxiCrheVFHfVJBlyWKJeE1Mee6QWm6ttLEf3Lmjatsu6J/WU6o3PibFzUz?=
 =?us-ascii?Q?uz66qNX/FTjyf1jYg7FmWKSYdngkm9N91WEGwMbs5JybL4A/2De7Gr5w55a6?=
 =?us-ascii?Q?gZS68dK8zVlVeLE8NThL4JmJsxSUWeEefF2Pc05xXntvbg4+prlcoyE+pejI?=
 =?us-ascii?Q?rTuv3Udz8EvOETCHEZlQz+gso3Vp3+hN5rwijPUOFDgPFmMBHDO1fTnC+1wW?=
 =?us-ascii?Q?2fDHIwe8g1ARPzgAzl7T32ggWBrZcunCF4QSnbgmD7l0of3Qi9ylHQb2ZtGq?=
 =?us-ascii?Q?UUfmI1ygImrq0uxVG6Bysn01tlr4XzGBKrF2CfEUS21B4J8Mj295DpUdvBhk?=
 =?us-ascii?Q?M6axT+MqdZPjNkM2JUnbDG46ZF/V+4er0QxW/VBT0iqPAuKtjPB/pQq5FQcu?=
 =?us-ascii?Q?9mJqib2fX8cIHw1XGc7lPB041w+G0UHXJhD4JYFSs3ctGH9LXZhN5jAoOnzZ?=
 =?us-ascii?Q?+6O2hczTvUJQ4owbCy8HCBe2NMsDb/MeqGUH/4PGtKm5BssiVyjZt4d50Cia?=
 =?us-ascii?Q?RXWta1qaVHaLvNUUchjkXHnrp9zl2UT4Ef8awAKQhs5kZfJ4tjM6fRl8rP8l?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E2W4Z8AdzmJck9GoV9ZrE8+n/9GYxYyjCi1NiAMHvm6FcEd602GLx62ZAKdzcRrxfdrgqdTVYkfYY8BcAbz7YqoFU9XSK7IhVUOS1SKbbFP5TLnTtFPaFpM9SZ+oO4rW9MEysfHx/n1qGPujal9QvGNwjO2o6ulOJzRmvYmni1rrMH00Ud0MrrMSRIh58qd3300LTuVbdkfaO5Ldjr7ghxyyyFTW6umkYil97+n3Ur8fp8qlYOTx1g8tlQDF6gRL4ltmXaYB0L+MbpkDf86BCCnSjONaNoZiYrcYrPT80sV7UCUhrOOlsZy7t7uUMLhvWFzqwbNhcqJ/+gA9g9sOGcU0l5iJe7TXerFUV+yLzXBUpM8sM4Y/ckanzueMxcEajV2iQS+IXwWSoD4OW/W4zaaQmDu6xpELe+t4NzU5w4U+861ShVMklXIBrs47nn2Eh50gdfRcLPws+C+ZYVzen80Yn1D1k66/EM/RgnV/EmBkfL3Uaq2rQJSd9xTC+X6znk7wEXineLCF4TBPwTu+oUe+wHbQVFnvdoH8rVzgOyzkTEWzS8Xyrgj3SWuk4TzsF0d4b85ecg25oa3UhSVtVwqZXFu62CEGxDi+1HWctcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd02cee-a86d-4c58-271e-08ddc9272b9a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 13:53:43.0190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqQ9IXV+/jI9zoGoF5Kwp3HjMWkjin65PVlap0N2ipxbzwn27uKdL4NOXtKIqZt9ZzGzTidqhG893bHsAjPMwCWbisoGhaSUvYL+enEScac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=800
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220114
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687f97fc cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=LVC-YzPUhquGcwqOwmsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: s2by4IGMfDVsKt_8fbFiM5TY7GNsg-_y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDExNCBTYWx0ZWRfXzWUxYk6rOYYZ
 lHaDwd+Db5Q2JXrWh477sCc84sYHcgQV4u+0zUhSGwz8eiIf7/JD/5woGGJn2AfydnJWnNlTfD+
 TmOmkaqNUcYCY5CH8ojOqHKoOUnIuatqyhGaF+VoFtkN5VVJIcOMNfZ3Dr/CVdBcGBeZ8H+w4i/
 H8gQUjXgIpWMkkvZtMvtQMIrNxRHVc9kdnbzVmMJBla5Xpil2fxyR4PtgOopYluJDAQqW6QQ+qY
 MZTqsyHaUODZPz870hOnNi7iSj+JU/PBBFmm5Xrbp/I4I40aGS58SU6Zu97qFSZaJbsvKtZTtKE
 GGjBFh8Zc4pgHFRS91oxEYVg3l9ix7gTqg/X7riO8XSA6DfeaWzaid+l3+uTOlIh9xS3UzYSeWW
 JYSQZpeRAXllc4N4it/NcO08MqZ7fW0BQWjv03R64CEEHRvrbvQiSkwoGVGPYadICOQSh86M
X-Proofpoint-ORIG-GUID: s2by4IGMfDVsKt_8fbFiM5TY7GNsg-_y

On Tue, Jun 17, 2025 at 06:53:53AM +0300, Mike Rapoport wrote:
>
> > > +F:	mm/io-mapping.c
>
> This is an interesting one. There are no in tree users of the only function
> it contains.

Hi Christoph,

Was going through and making sure mm files have places in MAINTAINERS and
came across this - I see you added this, but it doesn't appear to be being
used anywhere. Should it be removed or if not wonder where it ought to go?

We're contemplating an 'MM MISC' section where it could live potentially.

Cheers, Lorenzo

