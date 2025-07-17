Return-Path: <linux-kernel+bounces-735471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D104B08FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C237A3AE4F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D22F7D02;
	Thu, 17 Jul 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NSCznqsT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xlfW3B4A"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E882F7CEE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763618; cv=fail; b=jTQ0aRUN9Ln8SIE5i6bjsN+Vp/5yHnZfZSCFeMYZO8ginxfqf6t9ak4S6L5Qe02i1qHdrzNvMOyt9HK8p5ot2BwwCk3WUqXEdn4Ru5tMrhwQ0Iea/MKf2FsUVvmOIrFlXxLwQwAUMBqn207oL6AOpw8901igym4jddvXn800EGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763618; c=relaxed/simple;
	bh=y7L+ttuErBo/FYxHWWYPDq9enHFslHTjpIgA2sT/j1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OYC2w4LW1Ij9tLewJfb0ourAVlyVifD6Jp91TCL7bdS8m4qqc0SNfwMh86Qm/Iz4tFhrFOClvoJ/TTB+zg+kv1HTvRUQu7JNxBGJjii68QlEwQSE7LbmXYXXw5RJvsrJ5kvrgYJ5Bq/ZB7hujuZN+7CRVm+WBqiekxok2uVHgI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NSCznqsT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xlfW3B4A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HEfsbB027100;
	Thu, 17 Jul 2025 14:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ypMrdcyidLIYqGA6w3
	oYgYDTqpBHZPE8IxWSmziyC/I=; b=NSCznqsTR9HUyyOP/KivTJMnVmgDdQkiL4
	I/NcmT5AwC3qmkXrWxlSb4F34PBJ+NOMUk7RYG/CYKgUShvaq1ibUgF7ZtY17hR/
	2JXOAl8ToDxhp4WW6kpQq+o/JLJRzEKzmja2Zn3oxL7oNqJ4HhfUGbD/CeqqrmhI
	pBlk+f2A59PlKo3OXHYq3K31AaGYY68quQjzwU5cfgaRzxlXqH2RomksfqXd3xxX
	j27sOCBBz3Sumr3iJnzHvBjJ/ngvyNfy8BzgYg+i+zUFkZszxlZ6FqRDGXyrLrbV
	CHVVyMfGYeg2C53K9BhWVQY/K0mCZP8c8GpNwPDz1uQO7YEzyNFg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4u5gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:46:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HDl2Df013045;
	Thu, 17 Jul 2025 14:46:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cb4ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4G5rl2ADsbOJMlvfekHizcohuEGKg+oMlkNoRiHDrf8FPJru3uZWn3WwLZXUInFvljkV5jx805kTlqknoT65S28MWJAYhmGwGsN8BDme1pzHtRl3Qw7HbHluY9is2Yl4G9yB5xqF4o0SGXJ1sfIbwlyayloPHo/lD6k7mmU0SjbzsZfslqRtpI/YyDqlhjuDi1/tbAO6MwoBI5AT/+YpZrfDbbCiygj+cBv2zi9Ch6eA5QpiVE8FubOKjnzT9J70xDMVGTXt5c1zTnBc8/KQSZCQiI8LBBxpmY6Aladkikz47J2vo2oTR4lrKJFsMj3fpAYtQp2Vh+738cwitCUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypMrdcyidLIYqGA6w3oYgYDTqpBHZPE8IxWSmziyC/I=;
 b=Og+xgqHGuyr4sh6UmQGhn6UKZiTEsongSjOT+2brpyH5pBxWpTQiBeS/YoLQHYGaqmnhx/uoZDoS3hKiSFYyt5d9JtsowSC85nSkrd8LeG3b5bHt0Iit3Bnq4PRW+8JV80AD004SLcCFBBZm4P3jpOYzQjPCDF01hlwHHOjMCctip8Fn1hMRPAjRGa+NCQmSmdlAAAD8GEZ9DW0FWDNtsImtIH8Aqumi7Zr52IFajyBVhmrkgLo8prshLSELv8n3WdjajlK44IXSNEaPkzoZRrg295jFXau18xiZi3DystRpEMbppk60M6/mksjRNIR3H87hOh4+j8actwch4DIMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypMrdcyidLIYqGA6w3oYgYDTqpBHZPE8IxWSmziyC/I=;
 b=xlfW3B4AdfHbrhU2YCsJIcmPias7ah1vLGHFhMRWoHCz70UVbsXcty7MXHqbec8XFOzNlm9n149oPGyQoZnLuAw4JMtxYIjsqaudUh6nOUtVbYXLNzDjoS+yv2GeC3xPXIA70bjpHhLNTwy2DCFrbP9GWt6tEHTPOsT++L8Pj+g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7457.namprd10.prod.outlook.com (2603:10b6:610:159::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 14:46:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 14:46:24 +0000
Date: Thu, 17 Jul 2025 15:46:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Antonio Quartulli <antonio@mandelbit.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
Message-ID: <a479057f-5401-44ea-b3a8-dfd82b826721@lucifer.local>
References: <20250716171112.3666150-1-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716171112.3666150-1-ziy@nvidia.com>
X-ClientProxiedBy: LO4P265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c32f17a-ec1f-4d2f-7b71-08ddc540b3cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CtqNoa10HVx2Jgk8mA1xZvkHKVS+2qUpny5jDXu0XrRku011hyPmi0ATpZhl?=
 =?us-ascii?Q?oBtT5VjR1/a0BElQV41YQXkjuBacgtxADS3olfo2PwOk2Z4IfClWOY7y2blf?=
 =?us-ascii?Q?KK5VqQL8xmd12FcR5rnR+SRceriwvBdezsz56aKQBt3RzkzWn10bN1Gtl6eA?=
 =?us-ascii?Q?xFEAyxYmTrbeJrSvFRRPxuCj0S/wA5Oy63XNUH09fnmQskF0NlNC1OunnJDV?=
 =?us-ascii?Q?y5o6/774xNAf6MwarEWA0gFXKLPo2eZ2T7QxJY6GMo9hOshkLFLEsgfMFy6B?=
 =?us-ascii?Q?Xf6nsSwTojO61T+FNpcDlE0ebntCWxe48uuyUOkmIhVp0naZVdmFzk82Wy/i?=
 =?us-ascii?Q?qpxCl1p7GjGLeltW/IKKr0YilgEBBjWJeTD8BBr8wq9whS4wdNsIUsWNV5SN?=
 =?us-ascii?Q?Dx4QDmcY/q47pmicz9+lZceRDXWlt3aBFHB7KpUcxTssH4KbXGRCEE3YMQNE?=
 =?us-ascii?Q?kQc4nd6CT2BECmW/RQbNgtpkg71eNAj5mD8lcx4/g73bPjJTUz8ad5UZuMuP?=
 =?us-ascii?Q?uHK8nHzV9srNvJQBqRMGxbOKY5BA8JLfEj/O71P4W5T0UqqvliPGfsQLoqNk?=
 =?us-ascii?Q?VxkLPHIgjQAOTYulo/bWlpduhklXumRwIUp7p9o+CR17HS/LwnnKrFdtBczN?=
 =?us-ascii?Q?r7/j7hqhGORsH3HxLshMxk9yoFsk546bCWhZ3FO4SAAewWkog7vIBPU5puaq?=
 =?us-ascii?Q?bVCbHyef70PNgYa88rwHnOCh51rQujS0GchpH4xIoiafRZvyyCW4WeRgRfM4?=
 =?us-ascii?Q?nea8S7dKZi0ZfEiBxA9cH5AUQOFRsKgltY392oJ1f86bdELfqbvS2SGG/vq9?=
 =?us-ascii?Q?SvSI6IDLdrOw0kDmd5ZWk6T2pirWgZOjpbc0iqF5CXL9fzHkRzbaIzzC3N3U?=
 =?us-ascii?Q?nHha3o9jwxggqt9ndzoQ0evkY6zceHFBRVH8NNZR6uvGgu9BdiBhM8We5CzD?=
 =?us-ascii?Q?HryM79cLWNgU1eO4CDn56Se61xFqElxDqpXK/mp2vyNREVQrsWklu7xr91il?=
 =?us-ascii?Q?0XX5ZtJ20rydb79m8p0NHBvmEtOEV+Wrmzq2ikMR65QAblQITVDKFQktEWT1?=
 =?us-ascii?Q?HRZgS1mRQk+dFEwD351myXcND6fMkuKCqnlrWzXbn3+x3/XwKPXUKg37W/5F?=
 =?us-ascii?Q?nUc2qyy6ospoqGU7TofCoYH3gCxwFZgpD+tlZ42PfyYdENle34wHHhRdHl22?=
 =?us-ascii?Q?t0kGImHz/sNRbEeYDJxrvO6RrZpsI0sG5geu7UCAgsUSqrH3yREoAEe8WxvT?=
 =?us-ascii?Q?/F/z46OfwnSJwLRQbuS/jdmFSxR/eEc7V7dRA0KeTv6S6mvN/JKddvlpUvWR?=
 =?us-ascii?Q?9Ahh44y/IxMohWUwB4HK34qVon9+jWWfUWo8Q8iQeclasIDCI/dpMQZAGA6Z?=
 =?us-ascii?Q?TrvWuZa8FEOfURQpz/HiryKhoh0m0BVxnIi3hck+o7KAin3Fz/lztymfyFss?=
 =?us-ascii?Q?+5DAL9T+pKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GHSyJnN6ODw0KLCYClP8V71qRKnH//mI7WAWNTKTan2ArxqKo2pQ6o8BjLeC?=
 =?us-ascii?Q?c4vAGJlsSngW8oswIHGJfeL1ZluMzL6MVIXAoHDa72IlM37o4J9/qOAKusW6?=
 =?us-ascii?Q?givZmKaY3ttLIjNsiC/eXOUYYurRuKMMeW6G44ciRMqJ/lRuZO1PMxzFC1OY?=
 =?us-ascii?Q?agNL0CovFjt2hvqDA3+OLCFcC5yCvM1kTaOpYjGEHxZAqFeOv1snTztdjobt?=
 =?us-ascii?Q?rLj82fK6gqwE1a6wiOjMFgCLP4d/nXl4XxpbFDDAzwZn4EdfdLIuHWWiOALy?=
 =?us-ascii?Q?FMp3lPvb2CrkPw1BNZfT/fPQbRgC1reqiG3/1HPdxXL9IUuX0zfVnbIEnxcn?=
 =?us-ascii?Q?mDAFY5sO0QJ2tch/9Kj8vjNOd7XcP4zshAkqU/S0RJWihQ3Wni5Y5rhdBxfW?=
 =?us-ascii?Q?FbfSTdZeO4I4U7Ar/Xt+lTaJzT/wCW7fEv0oEpNZ3yZaXE+k+M9fhM28CIMU?=
 =?us-ascii?Q?6zZf/N13Wv2BVxAkGxcgRYTzFciy7InOVl/sf9u1YGlx1d935gtQDuabCqGO?=
 =?us-ascii?Q?cwUW8FdbzxMGQ1fOdMZ/08bPTAZfis8YccvM70GaVw04adUEavy1Gs0allQ9?=
 =?us-ascii?Q?o6Pd1WJEXO9aOInErSIheBIKv7GBnKG2M2qNwI9xDCyVjsfTRoc1rZW0Dt1G?=
 =?us-ascii?Q?UqzwBzRJ0u+07FAI+jPvYgz0P3EMwvtOD2G3Wo0TYs/OJvVo2StwfGfTaieD?=
 =?us-ascii?Q?JeCemgjEjvd8ixF2YqodZ38PXp6e/pC9ucZhAbXnHyISJPHl9iy6lrICesCu?=
 =?us-ascii?Q?rYU3HLTyYOKjQZNgliY3i4mF4QrUfO9ktG6PC9QJD2+FsKIyYeNjh8ULcbk2?=
 =?us-ascii?Q?b5TVTtKwtz0GFVfYK+PndXwKESEYC+7z7sLOB3jO+obLKcFzp8eviCOrf2dQ?=
 =?us-ascii?Q?iKqrNDjVC2dvCMmS/c3z4gZ9w1Ass7w4raV9JBv/IIZCkEO+JbrDmqrqpZYz?=
 =?us-ascii?Q?1XtLC0LSjyH6V0YAviSUyvpzKfLQovrtEADWyJOk+afcmsRvm8OdNF53NniI?=
 =?us-ascii?Q?Agc0aA56wvtFER4AUKqFV0ojWz4yorW3xSYnGlZjMW+ZxdJOuuvRpBQLoQFU?=
 =?us-ascii?Q?Bpgrw883XtRPFpdHv4+ut9HpGxLOMAYhMn8T9wdGP/Mw5dwRSZDQVmuOZ/c5?=
 =?us-ascii?Q?+GTWVTJTo6Nyxa+MO9t3uE64pX/lB7HbEQyREJCZD++XdyLyzo2e1hZcOsHh?=
 =?us-ascii?Q?YjmYF1uTd5KOt3m74oqrkB+hKaCwp7gw5CIdsgVaCPRoGL9xAuwLgOA5vQB+?=
 =?us-ascii?Q?msRWp9hR/VVd/skb7bSyG86a2BrqgZCWH3hW1rFrCxLzCwlFCc9EbcWgEcK9?=
 =?us-ascii?Q?BrBLGVSCfXXYcmJk0i9geuIpQY8n/d4Rf0bwK9ni7l4rljulOWUwB5+xqqwX?=
 =?us-ascii?Q?ffeoI1i1DD/9qRJoI2SpGtheNy8Fp9CN2BxiJKzANI5HO0QsYHgd66lFmAzc?=
 =?us-ascii?Q?QMLnKst0f+EPqcap65DIKPiyoP329NbMtrlfzI01P7jPcNgPcpXjg2FdWqDa?=
 =?us-ascii?Q?rlyFFZMQt0PER3mI6DV8dMWqa7Dr5uo0phdXhsGWK6lblm/ZUOOrGRpdgxQx?=
 =?us-ascii?Q?RpJRYcsH6gKKRZjvM5GMIzxuuBxtIT2ZQicljn4B7YYtVJqQ9vLnb1MoGFlp?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tz9GvbYF1b3WE8mGk+XofFki5iOGY8ddmHdPryL1G8nNugbIRzJF0hzU/SQnpSByW/dlCCoTClBx0die4032EKFLMLG9FEhU5b6slar2CbwzCl5G6x1e8dj847YicmyHhCeFOlQ7j11/ohuJZ6mMSr0XJjKcEWUkq+pzJK5nP9JUI68Ob6qzZhd6D7lHhBiOF1jJTrLGX3f5ClBS1Ft1cuBvvshfS9vW5QLqVJ7dwYG//dn3VZ4HLX46YeQtOF+I4Fszdj3oLohJ8mGn12ViGCSxbDCN7TGb3LxLStuI/x7EJBLU1HlPe3tvQzWK7nVozaCyFVwa+ReACvpCRoDPp8eiAvhDKH9sK/DGBUzjwIS3YvBhDOnUsuPjTMYsPMsoocqjxq7Ynkr2ZOl0oZ84aHwRyJT7iyBfTbKH7v/w1s6JiIgE4O8NzaqHzAvl/AE2s9FuHr89q0unAifzlYtOt2KREF5vvKYpHLzAUZYoa2UrXeo148Al+BBe8JcGNhugcby3GzIYLn/CCIzxjLdpCBTZToHuJx56MGDe6JQVOCzW2019Z9VDMvE0ppYsh3eTKsI/e5vnqmPJnuYuINZDNZJWx7Rw0sU73CnSXiEXhd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c32f17a-ec1f-4d2f-7b71-08ddc540b3cd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 14:46:24.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIs3QxFu9Ge/6XQtManMvL59VTF0Hp63O3JrPssujFwVP1EoWynNZk8Xq2+yeoyK9SPJVPBkWtXJ02D8rXHYmWaW85fHf10ab8NO44u6Bak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170129
X-Proofpoint-ORIG-GUID: Sbk4T5QeB6PsxpFa1FqECQK_4akVH6F5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEzMCBTYWx0ZWRfXzbXAQxY9bBp0 IpWpNpXbf2jeg04lR22vahfxHj7L+5gCS/hQvKtDuGmwlyTDNYusWsKV7P6eGNktLmcA+9+V5yR 7QAuq7qGPZL8d0eI1OlFCqm8acn1/4QtlNNwmMFC8hmeanSJG0qze0hVSQE+MEM9EsiHXPSqCav
 noIYGn9pwdlnEj/u9XHN4reY6xKKROtMN6crP2ruJCcEEY0MDwZtHs3fCnvYEAj9ee3BEJJrQlc CEi4E7TBtmVJ0wrestb5lQKVWX1LDtrIRpJJUPGFNEcmgq9nXuv7jcQs5U1htUBdh1oHc5LMZfH IVtIXlrB+DKD3PvcY57JyWOhSjVtjkApKYdyYKyJ/Yg3x96GKlFFmEy1lOuRCesLcpBXBUE8Nn0
 oo5h5z10myPeqkWi0RudsrAG7xm1dr2eRrMBC26GdwYI0r37L4FLaoolOIpY4jQztiMvETkz
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=68790cc3 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=R7-U5TooAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=F7BmVioxN7Ndg4eA_BMA:9 a=CjuIK1q_8ugA:10
 a=0qitgU11kHl69ATa7WPA:22 cc=ntf awl=host:12061
X-Proofpoint-GUID: Sbk4T5QeB6PsxpFa1FqECQK_4akVH6F5

On Wed, Jul 16, 2025 at 01:11:12PM -0400, Zi Yan wrote:
> Smatch/coverity checkers report NULL mapping referencing issues[1][2][3]
> every time the code is modified, because they do not understand that
> mapping cannot be NULL when a folio is in page cache in the code.
> Refactor the code to make it explicit.
>
> No functional change is intended.
>
> [1]https://lore.kernel.org/linux-mm/2afe3d59-aca5-40f7-82a3-a6d976fb0f4f@stanley.mountain/
> [2]https://lore.kernel.org/oe-kbuild/64b54034-f311-4e7d-b935-c16775dbb642@suswa.mountain/
> [3]https://lore.kernel.org/linux-mm/20250716145804.4836-1-antonio@mandelbit.com/
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

This is fantastic, thanks Zi! There's a nit below but I actually almost
_don't_ want you to address it :P

Therefore:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c | 43 ++++++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 31b5c4e61a57..fe17b0a157cd 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3804,6 +3804,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		 */
>  		for (new_folio = folio_next(folio); new_folio != next_folio;
>  		     new_folio = next) {
> +			unsigned long nr_pages = folio_nr_pages(new_folio);
> +
>  			next = folio_next(new_folio);
>
>  			expected_refs = folio_expected_ref_count(new_folio) + 1;
> @@ -3811,25 +3813,36 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>
>  			lru_add_split_folio(folio, new_folio, lruvec, list);
>
> -			/* Some pages can be beyond EOF: drop them from cache */
> -			if (new_folio->index >= end) {
> -				if (shmem_mapping(mapping))
> -					nr_shmem_dropped += folio_nr_pages(new_folio);
> -				else if (folio_test_clear_dirty(new_folio))
> -					folio_account_cleaned(
> -						new_folio,
> -						inode_to_wb(mapping->host));
> -				__filemap_remove_folio(new_folio, NULL);
> -				folio_put_refs(new_folio,
> -					       folio_nr_pages(new_folio));
> -			} else if (mapping) {
> -				__xa_store(&mapping->i_pages, new_folio->index,
> -					   new_folio, 0);
> -			} else if (swap_cache) {
> +			/*
> +			 * Anonymous folio with swap cache.
> +			 * NOTE: shmem in swap cache is not supported yet.

Nice added context!

> +			 */
> +			if (swap_cache) {
>  				__xa_store(&swap_cache->i_pages,
>  					   swap_cache_index(new_folio->swap),
>  					   new_folio, 0);
> +				continue;
> +			}
> +
> +			/* Anonymouse folio without swap cache */

I almost don't want to comment here because 'anony-mouse' is really cute :P
but yeah nit I think you have a trailing 'e' here that my cats would be
VERY interested in... ;)

> +			if (!mapping)
> +				continue;
> +
> +			/* Add the new folio to the page cache. */
> +			if (new_folio->index < end) {
> +				__xa_store(&mapping->i_pages, new_folio->index,
> +					   new_folio, 0);
> +				continue;
>  			}
> +
> +			/* Drop folio beyond EOF: ->index >= end */
> +			if (shmem_mapping(mapping))
> +				nr_shmem_dropped += nr_pages;
> +			else if (folio_test_clear_dirty(new_folio))
> +				folio_account_cleaned(
> +					new_folio, inode_to_wb(mapping->host));
> +			__filemap_remove_folio(new_folio, NULL);
> +			folio_put_refs(new_folio, nr_pages);
>  		}
>  		/*
>  		 * Unfreeze @folio only after all page cache entries, which
> --
> 2.47.2
>

Since we no longer need to make new_folio->index >= end work for anon
folios, can we drop the end = -1 in the if (is_anon) { ... } branch?

