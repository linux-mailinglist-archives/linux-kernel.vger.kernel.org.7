Return-Path: <linux-kernel+bounces-861058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2968EBF1AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CFA188FE46
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A3A31B81B;
	Mon, 20 Oct 2025 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pwsob+3q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RXSNFXS7"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD231AF21
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968584; cv=fail; b=kC1PcIdt4gZyvZr4glNKUqLjJ+58Z2dlmEW1mClP/VdC3Fmetgr9M/ouWmwqQ8Dqu5wsaaVA1+/ei4retrFLX9Ae7JTBnHRbEpOH29B9OAnU/rW2omSItMjyjtQ396h/AyRmDrN9bGauzPdLwkfiB6CJr6bxH7jWXKcAxHCyro8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968584; c=relaxed/simple;
	bh=YnjEHUAUAS0O1eXaxkwF61GO3SMwQx60qk6KphLyzMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XAvwLX7FA4l5rmL982hSbOY0AAJ3a7pyRK0tkQbQmmWTO8kbbQ4NNpSY95kRuveQ1FUb21JfnixaSCDa2AnXc0aJgpR39gfa1/vngbgsDiZZHuX1Tk97gCrw0Z0OOL3bFEb9lfzHC4OJhc8uFNE1pxORH2W2EG0tJ3tu80J84P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pwsob+3q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RXSNFXS7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8Rlsr013664;
	Mon, 20 Oct 2025 13:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dr39uaHfvFYe2jvgUe
	1QHmtIgzf1u/6FRJDZfgQrpXQ=; b=pwsob+3qrBGNNYT5PAi+5weQsluP8xMslZ
	KqaVKQQXzCmRrTFXP0nuAxfA/xS0Wivo1YREtu6lvLWkSixz/DCN4JjkMuRFab2D
	3vub+wn8PhehY8+KurG6v83L8xgYbKafJgFg15/zLHhRh9GeYSGym9MqLjnrO/8n
	EKWoMQO2VSYwZbe1ZU/dDFl2Gb6Kz5tzg2EhY/8jMgYqeKIX3RW1rhIkjubITTIs
	+TjIRcXV8obSG8X5vc1AMcaBCFIun2dVE7PYJ7B7PdwnlngsvL+VFyrQ+75WckNO
	IzeYMqAQ6JpzynxN2W+vauZueIwhtV3MAd/ItPm3eD1sZr3/pRkw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49w1vdh8g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 13:55:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBRvfp004351;
	Mon, 20 Oct 2025 13:55:57 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bay0ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 13:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nClyYgDujfKN4SSukrjjz4bMXOnbfhydUcFcPENO/TRY6kV9PcN0Uyq67NWnRbXZEf9qsJS7ApEFX2uCHTMDygqZ5q3VSztMdN3g1UTkkyeuAFYLfdxY3Ig7mso5Vu+cWGY9DFq8du092PEzL5Zu+nS0vymOlsdm2ctl2n9q5sS5ZCmZ4y2Rwk9dmp/ss/S3MdsvNKfpMBpfHwvDySdZHlRej69s9Rnmf3JPz4WQyq7w7d6gBD7Lh8dVR70A/CrS0s1lQFoI0l+WoDDpcIDbKl+Mxo2b7/2bXULZfMiJyIPtptxn3f/+dyhekybMlW09HvKT2PJGyQcJ8YyZBHBg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr39uaHfvFYe2jvgUe1QHmtIgzf1u/6FRJDZfgQrpXQ=;
 b=SQX+CWqYOprwKFFiiGjMHRUXx0UT04hGSwUa6+sWS59dAA9l7leWGhEk+GDmXHxHdEyxPTben0MtK0hnPNKGjEvbLCG1hl2HmgHYK5DInxVkYrgnUAL5UkyYbwG2BcuEDtNTmU3N76VOmTalpJLDvXpvLLKFjxvfvzM4k/HjrRCnPU93BAutH2K+S+lppYyBNjxRDbKPJSlGDG0Zh6MujSe1QeZOxBNUQgPkeScLkHhJLIg7l98bLlBMKFkrlYRG2XZ1shf6SwSSfhZVCm9YI8KbjD+BcbIgS0WJsdmSyStBc6xRGTXQOLqBBK6VIr7T5FSe50X0ZFIPVp7yC3MIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr39uaHfvFYe2jvgUe1QHmtIgzf1u/6FRJDZfgQrpXQ=;
 b=RXSNFXS7nRWdvE7j7Pzjid0r2mO+bmhWhzgEA1okg5S5PS9CTX3kDFzCoIawSC3lNDJtp3ORfYLm+OPnG+jK4/YgFfv4IbKVl61Nb8m2Pxnu7vn63J+iJm3mxoGbNuFX3qQvplEHW7ZaQmNpdlSfuoQaTwQTX/6AC7rj08h5++Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4962.namprd10.prod.outlook.com (2603:10b6:208:327::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:55:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 13:55:53 +0000
Date: Mon, 20 Oct 2025 14:55:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: guard is_zero_pfn() calls
 with pte_present()
Message-ID: <2caf088c-e321-428e-afce-b1c11f52bc3f@lucifer.local>
References: <20251017093847.36436-1-lance.yang@linux.dev>
 <699b143a-cca4-486c-a4ad-d0be561d4ab2@lucifer.local>
 <b5627e83-489c-4e16-910c-fe7e56912793@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5627e83-489c-4e16-910c-fe7e56912793@linux.dev>
X-ClientProxiedBy: LO4P123CA0539.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4962:EE_
X-MS-Office365-Filtering-Correlation-Id: 1832e850-5eb5-4c24-fea3-08de0fe06290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/GD4HSTWHaDHcajKPt4tSDe8ulR3U64J07ozXMJYNGUhwIpPP4KiCs84pQ7?=
 =?us-ascii?Q?T3qYf+/CIvS7Cvw/HT4WJWirvq4QUXwiJ6hTeHoZRjArJxIig6kRwBdvB11m?=
 =?us-ascii?Q?CI4LAK3e1qYg2VgAIAZUS+zQ7jzwPYG+dlUonIYKmStjG7RBwwI8Gu5VwLfG?=
 =?us-ascii?Q?SZfhAeVYYyZCUbhXf8dpzy3xRtU1VyPekmwBl+lVCa06W5Xzh1aw+4G/wtvA?=
 =?us-ascii?Q?7ZSuq6tiMgOMeRBryLIejKt1psy000XfNZ6HA7OBMk2IQ8v3iwyfgyY1an5t?=
 =?us-ascii?Q?VEtKHQYq2V51L+KKpsQCGhFSYLqFOTBP74q1dJ3W8DrWGbO3BqrJMCHYJ0U8?=
 =?us-ascii?Q?ztoA5704dr7xnlQhcZ9zjoXOBw78OcHqo05DZ9aBX4MCpIdBQVcKdItwHa05?=
 =?us-ascii?Q?7yjAwZWHhyaRg0oPFg4LvP///gFcWMIe60nVWayHueNeWLHZGI49JNOXwhNk?=
 =?us-ascii?Q?7VeviuPVVxihgcczESMHg4ckuAr45TuY6XaL/G76VpJbVQmo0kqQmoy6dKiz?=
 =?us-ascii?Q?940I9W7BbOEfuClLSQfaR43+t+Syu8RophIs5v4EZXHwIfxUj1k+/JZs6qbi?=
 =?us-ascii?Q?yCkG95VuPZh2Ub6DJCOe/WlBI1cb7RUCM2DA9mXCJLtCf5DKx/C4GMmJdD63?=
 =?us-ascii?Q?JROC+ue05/4giVnaZfHNLABou/5mKJBeqdiqvzOYugTfM2Bz3W57UGOvR/30?=
 =?us-ascii?Q?t9f86tJCwMztQduX09ihl7h8cdufpeyamHmoJnMfII/HFBOwOwagyyuWWk7N?=
 =?us-ascii?Q?bGLPPn8YdOLFWLY6IWdnKMqPXKtNeELuwSLhq79OLY1mg716Y2oozR/mL3xg?=
 =?us-ascii?Q?86mITt3LplRIWtYVEFQPDcy/QWModS4KJlhH7lSTw5A760efC6kt6dqROOn6?=
 =?us-ascii?Q?aM0bLZe1yST6mwioUBUlDu71dTiCWJENg2TlYRBHECkb19FpRAT2vap5Nee2?=
 =?us-ascii?Q?8zarHdeOXuFa+VhyEVrEB9miuLwzLaMyDy/ynZ7cPq2WeU0S7AqHAiJiGlqU?=
 =?us-ascii?Q?UZUi7CnYucroy/HgKVwruJlXzXMOMzd3iC9bGkgakbFyAydqFsO39lvsSLC2?=
 =?us-ascii?Q?/jwmRiM2Ingvs1DqLyuI1DtUjbArcH4X+rU3odClsr7pLbvLh7z8uN5i3RtN?=
 =?us-ascii?Q?2+u0XZ4NxjX00yJHx6mlmzFctQk6xGbrWg+n9oKs4QhsRyvfOIfHKXCxylFS?=
 =?us-ascii?Q?oGW6K551vzvPMxdT3vm8sFdu1Fg108TrGICG5PyQ6a8DTpeMshtxIHsxnsk9?=
 =?us-ascii?Q?0Gzx8KvjQ7soRClq0fKQiB0gd3hFEfqb4OPw6xj6R1HFscJXalp68ZwPiLUA?=
 =?us-ascii?Q?dIEE8HV5I5A78L8wjHM7NNIgbPw9ZKq53Yw/Ok6ZVM+jWbeQ3c7HGbvVhfu+?=
 =?us-ascii?Q?vovWVxsrltB6m6rkgQwHhVh0LmtrGflkM4JyxMItZS60aUuvqYbQKytUBkSq?=
 =?us-ascii?Q?YFZ9FdcmbyZqDgmXDEu9+PclqH+wwU/CXTY3wZVeiWuZkxgv749ZMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Surpvbul6Mb/TEJ+PZt97kZDtBUdgy/b+bzXXvucxpzo33eekWepVNZcf/G2?=
 =?us-ascii?Q?80yW/Krnb7omhSeXAwFqcCAexYB7cHSuB8tIxh5lWvUsGUznfBkXdNQ2ekpf?=
 =?us-ascii?Q?D/slbHeEhwVM2y/ucXXS2gQB/SDDF4CX8G7Rnl7e7hg2++qC8euEQkm3ugtn?=
 =?us-ascii?Q?DZpRua8q6fZlIuFuUKzMd+qsT1hSkc5NwjdRaq4M8tD3o1ueUMnyNieNDg3m?=
 =?us-ascii?Q?kAFGotQwsxAc6b1lfZRDOBRglnrtYB+j04AgvtCBGKBJE4LIh4qIT2ERXR/9?=
 =?us-ascii?Q?xm/f+hX89HliqxgeX9QHwPaVTDl9U2iLPfAWlZLmNecUY78wrIdRBvOr4Vls?=
 =?us-ascii?Q?/GQPU+K33cq9BMeAlVe+h+/aUBpVwf44usTal66IahZtt1U7cxLtG70C8CMO?=
 =?us-ascii?Q?nKshpwK7B5BV0HmwR1Vg1Mf+5tYCsu8lKXS46OOGvLDUOHr1bOfDh8FyqchL?=
 =?us-ascii?Q?mkO769CWPBoa4nf6nkiBNX34pgUjShiLywQwdXpx/dtudv0oZrxmv4XmRz/K?=
 =?us-ascii?Q?It8VFM9FGiKbowwliejBMLEZo5elFnO71l2oK7WJ9W7I9EofOdW+HQ7lYKV8?=
 =?us-ascii?Q?XgvOAHztgJ//p8aRW0mfadTu/AvmjS6pyUUksRSkAH7dvrGr65QvpoXzzGTB?=
 =?us-ascii?Q?vfctKL89VDGrhN2D24zW5UqBHzNHsGTSV4rMHLe5ljddSMZ9/uGz6AZaeL82?=
 =?us-ascii?Q?V1/cQnAAX074xJlICzU8DjP9kgmlSsdpkEIgMnyO+hXHDVcJf+xTjok6u9uW?=
 =?us-ascii?Q?bT5QLgJYAqmz5oL0AVIs4tUe2w9jzA9x1jnLME2uufLTMxsUM9nLIJIOeU2A?=
 =?us-ascii?Q?MQt6zCE4l0o5BNdD1uDKggn2VuxhDRXxreNyCq61MENuBugn5f/gZg5+ueLR?=
 =?us-ascii?Q?EGvXLZSDdeXu7jDn0qb4B5aLR5JzGp2tFjdUmQcxKwJJ+vIaswGXxwe877v6?=
 =?us-ascii?Q?fwaSCju6f5yPZiJdi+PfCyDydKySQXU3hih1MF5+2yhaThVfmozngIKNU+lW?=
 =?us-ascii?Q?YLq3oV26uH8XIx/LlE5umHLYrzB3hqAepnNetYQnCVi0GK4EdWjl8eNkQJq7?=
 =?us-ascii?Q?CLALCvhC6HjRB0nbN6nTGKUKYsFKrRKV+TLnFLOxOoQGzR+SO/Uis5ekkhaH?=
 =?us-ascii?Q?D51IX05i/Bpm4/LKKcNAJllSFta3iM5nEDqXqQ+0WKmNxBvLULoh1ThWjkcF?=
 =?us-ascii?Q?+XIxdEfSMNVMkl+y5rdGOxQ/7tttJRXc+BTfLyivoEkrbZqsYVP55KPC9J0N?=
 =?us-ascii?Q?Xlp6y+NoVWDFYMkYmeDtW4FQiCQER90enf6gVyssop2p1WpyJVH9bPPR0K2i?=
 =?us-ascii?Q?bHnghest9O7wLSuDkm3KRNFAp3M7NdFh3PsvGSGhkHuMQ0CuLvzKX2eb6Zyt?=
 =?us-ascii?Q?5CO4Vl25Dx6IuYo6vxMMts03xZYoIpAtL7ZueX6iE4yCMuXMy/CBnaSCBKp9?=
 =?us-ascii?Q?XHJ++I7Dxht105L2Q4bNwkXXxHao/+96nl54hLU+a76Y6dd/boRxay4rmsK3?=
 =?us-ascii?Q?+kGqRVAx4YUR6P/eldK3ErnGNjdZQU0H4V89IZvUDu3xZczu4SnHYQnoMBsG?=
 =?us-ascii?Q?pmJRXmAaA+xqrCalLH/2crOB949zKlKDjubJ3VGdToiCk4clcwRt99eDbbod?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	em1Zn8w1fc4giTZB5yZOhhTS2n16T2UsTx1dlg4G27AmCo3jashVbNGk0xZWTIi7PquHbjtwPvs1EUMFIjt5RqY0bTUGQcUoIe65YFr1uqGA2vJBCX/2vgAoy5GqWinFyHn5nMJy6alSgENY8Mf1OEv76b0dOM/iZZwpD9fk5tR92Wot9rpcwtq/nfMlq0uP7NRuqFVgQOm6MHdI78y7zzeOfOnwP+34Ilrpjscw1gribdc+0XKdVONfBy4ozphiD1ri1so1T+aHeB90Wn8M+Td9iTsqIwgMnK771DtvS5VxFRaM6V/eEaKNBOLplHcITk5WxVCS1iWNuREf1jIEgpG+3BUyLzm0Qiuob2SBnEms+1FM76TNJ+jrU5I6qNIs5FIGf7myJ8Pum6pi3aGnSsRFutoB8u4ncMvdJuW/RkQZqf9lmDD+Etv3Wfaj+au2luPuqODvi9oamCyIdj3aKyjiU4GwpTMVvLZItRwcApAdYR2oiWYIRhxE3glJSi8hBFdrFIOEFo5GRJTaxdD83JRbXbfzXzpeLug/0BQTwoVbiwayXNqfJqfCSJKRwDwO7scnsn0K5U0MSjH6N1z+gMvYhvdKlgErIvUhoE2Reu4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1832e850-5eb5-4c24-fea3-08de0fe06290
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:55:53.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3aryuDUrBSpXlfjs7Lx/NGTRSL92/Nm/RS670aC8zE8wzAvnt4j4MA25XPqw4oIsL1etbapU2p0WbMiyfzXNfSF/aX8LKCt1Ty9h1kmt2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510200115
X-Proofpoint-GUID: ivBrpvVgp8IpklfDANduICR0zbJSeONm
X-Proofpoint-ORIG-GUID: ivBrpvVgp8IpklfDANduICR0zbJSeONm
X-Authority-Analysis: v=2.4 cv=WaEBqkhX c=1 sm=1 tr=0 ts=68f63f6e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7CQSdrXTAAAA:8 a=SRrdq9N9AAAA:8
 a=pGLkceISAAAA:8 a=MQi6GXU3hh_4PA0ZLL4A:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDEwNSBTYWx0ZWRfX7+9LiNH9sqBF
 xxOHcPE1tfZF9FKOx65XMV9+PTPH7lgR4+YELTnOSeHjHm6VasT0M9+3EzfiQrGM+JeyCjG+THw
 rqzlG5mMj1qRAwMnIm2NyphJjg1H+n2F05TNjoLr3lIsQwdtBa7cr1md9xDUqHd66xdmUYAh3ew
 K3xuRtchNNONdwWKMYxbwXsLjMzjO1JeYxU5DCas7SxhkFI81s5fFQjIyToN1bsq4cNbJAfQJEb
 u6Va/UYeZcuZaOwhrmVW2Bnkm7+qrw6VqEgwuiEEX/17ZMwuJODdq8dbbK4zLBHmhBpDhFzMlNv
 f4gA2V4SMvvpFzyG36UrMQooX2tTx9dOemlo1+CyddCOawo6YduJPHxnaYW4u7YyzfSxzFs1ezP
 GgX3ibTDmCKTpNkdXt/bP65UOK1jSw==

On Sat, Oct 18, 2025 at 12:33:33AM +0800, Lance Yang wrote:
>
>
> On 2025/10/17 23:44, Lorenzo Stoakes wrote:
> > On Fri, Oct 17, 2025 at 05:38:47PM +0800, Lance Yang wrote:
> > > From: Lance Yang <lance.yang@linux.dev>
> > >
> > > A non-present entry, like a swap PTE, contains completely different data
> > > (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
> > > non-present entry, it will spit out a junk PFN.
> >
> > It feels like this somewhat contradicts points I've made on the original series
> > re the is_swap_pte() stuff. Sigh.
>
> My bad. I didn't get your point before ...

Don't worry, this is a problem that existed already and needs addressing, series
incoming :)

>
> And this patch is not intended to touch is_swap_pte() ...

Ack

>
> >
> > I guess that's _such a mess_ it's hard to avoid though.
> >
> > And I guess it's reasonable that !pte_present() means we can't expect a valid
> > PFN though.
>
> Yes, I think we expect a valid PFN must be under pte_present().

Yes

>
> >
> > >
> > > What if that junk PFN happens to match the zeropage's PFN by sheer
> > > chance? While really unlikely, this would be really bad if it did.
> > >
> > > So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
> > > in khugepaged.c are properly guarded by a pte_present() check.
> > >
> > > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Not sure I really suggested something that strictly contradicts points I
> > made... but I guess I did suggest guarding this stuff more carefully.
>
> Sorry, I didn't catch you again ... Will drop the Suggested-by tag.

Nah it's fine sorry, I think in general you are doing what I asked.

I'm going to address the is_swap_pte() stuff separately anyway :) have discussed
with David off-list a lot. Think I have a sensible plan...

>
> >
> > > Reviewed-by: Dev Jain <dev.jain@arm.com>
> > > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> > > Signed-off-by: Lance Yang <lance.yang@linux.dev>
> > > ---
> > > Applies against commit 0f22abd9096e in mm-new.
> > >
> > > v1 -> v2:
> > >   - Collect Reviewed-by from Dev, Wei and Baolin - thanks!
> > >   - Reduce a level of indentation (per Dev)
> > >   - https://lore.kernel.org/linux-mm/20251016033643.10848-1-lance.yang@linux.dev/
> > >
> > >   mm/khugepaged.c | 29 ++++++++++++++++-------------
> > >   1 file changed, 16 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index d635d821f611..648d9335de00 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -516,7 +516,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
> > >   		pte_t pteval = ptep_get(_pte);
> > >   		unsigned long pfn;
> > >
> > > -		if (pte_none(pteval))
> > > +		if (!pte_present(pteval))
> > >   			continue;
> > >   		pfn = pte_pfn(pteval);
> > >   		if (is_zero_pfn(pfn))
> > > @@ -690,17 +690,18 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
> > >   	     address += nr_ptes * PAGE_SIZE) {
> > >   		nr_ptes = 1;
> > >   		pteval = ptep_get(_pte);
> > > -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> > > +		if (pte_none(pteval) ||
> > > +		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
> > >   			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
> > > -			if (is_zero_pfn(pte_pfn(pteval))) {
> > > -				/*
> > > -				 * ptl mostly unnecessary.
> > > -				 */
> > > -				spin_lock(ptl);
> > > -				ptep_clear(vma->vm_mm, address, _pte);
> > > -				spin_unlock(ptl);
> > > -				ksm_might_unmap_zero_page(vma->vm_mm, pteval);
> > > -			}
> > > +			if (pte_none(pteval))
> > > +				continue;
> >
> > Yeah I'm not sure I really love this refactoring.
> >
> > Can be:
> >
> > 		if (!is_swap_pte(pteval)) {
> > 			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
> > 			if (!is_zero_pfn(pte_pfn(pteval)))
> > 				continue;
> >
> > 			...
> > 		}
> >
> > Doing pte_pfn() on a pte_none() PTE is fine.
> >
> > Obviously as theree's a lot of hate for is_swap_pte() you could also do:
> >
> > 		if (pte_none(pteval) || pte_present(pteval)) {
> > 			...
> > 		}
> >
> > Which literally open-codes !is_swap_pte().
> >
> > At the same time, this makes very clear that PTE none is OK.
>
> Emm, I'd prefer the new helper pte_none_or_zero() here:
>
> if (pte_none_or_zero(pteval)) {
> 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
> 	if (pte_none(pteval))
> 		continue;
> 	....
> }
> That looks really clean and simple for me ;)

Haha yeah sure that's better :)

>
> >
> > > +			/*
> > > +			 * ptl mostly unnecessary.
> > > +			 */
> > > +			spin_lock(ptl);
> > > +			ptep_clear(vma->vm_mm, address, _pte);
> > > +			spin_unlock(ptl);
> > > +			ksm_might_unmap_zero_page(vma->vm_mm, pteval);
> > >   		} else {
> > >   			struct page *src_page = pte_page(pteval);
> > >
> > > @@ -794,7 +795,8 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
> > >   		unsigned long src_addr = address + i * PAGE_SIZE;
> > >   		struct page *src_page;
> > >
> > > -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> > > +		if (pte_none(pteval) ||
> > > +		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
> > >   			clear_user_highpage(page, src_addr);
> > >   			continue;
> > >   		}
> > > @@ -1294,7 +1296,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> > >   				goto out_unmap;
> > >   			}
> > >   		}
> > > -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> > > +		if (pte_none(pteval) ||
> > > +		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
> > >   			++none_or_zero;
> > >   			if (!userfaultfd_armed(vma) &&
> > >   			    (!cc->is_khugepaged ||
> > > --
> > > 2.49.0
> > >
> >
> > I mean all of this seems super gross anyway. We're constantly open-coding the
> > same check over and over again.
> >
> > static inline bool pte_is_none_or_zero(pte_t pteval)
> > {
> > 	if (is_swap_pte(pteval))
> > 		return false;
> >
> > 	return is_zero_pfn(pte_pfn(pteval));
> > }
> >
> > Put somewhere in a relevant header file.
> >
> > Or again, if there's distaste at is_swap_pte(), and here maybe it's more valid
> > not to use it (given name of function).
> >
> > static inline bool pte_is_none_or_zero(pte_t pteval)
> > {
> > 	/* Non-present entries do not have a PFN to check. */
> > 	if (!pte_present(pteval))
> > 		return false;
> >
> > 	if (pte_none(pteval))
> > 		return true;
> >
> > 	return is_zero_pfn(pte_pfn(pteval));
> > }
>
> Yeah, I'll put pte_none_or_zero() in this file first.
>
> static inline bool pte_none_or_zero(pte_t pte)
> {
> 	if (pte_none(pte))
> 		return true;
> 	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
> }

Well I intended this to be in some general header file, but it's not obvious
actually where would make sense so feel free to put here as a static (no need
for inline).

>
> >
> > I think I'm going to do a series to addres the is_swap_pte() mess actually, as
> > this whole thing is very frustrating.
>
> Excellent! Looking forward to your series to clean that up ;)

Already started on it :)

>
> Thanks,
> Lance

Cheers, Lorenzo

