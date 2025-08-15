Return-Path: <linux-kernel+bounces-771154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E43ACB283A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AA71D03B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9292F308F33;
	Fri, 15 Aug 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nzuCU+zx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="He1bheEJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D412C21C8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274300; cv=fail; b=FqLu+iAgHmSuCY27Tpxycl7ITjSwWn/uQQTV0G4mvdVrRS5P+As1fu94bdpK5SlLCfQDs1/kofl2j0yzkS9rWrJ/yQuIjbJL7yXbJIi+Dyles1q9yakQQCLaCdbOPHpGR2DKKLgJaJCHT4euYh2jeVOlSAT9XeI+T6XpdM05mAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274300; c=relaxed/simple;
	bh=0n76Ey1ktebauRUxlH5dsktVhqfu3Lei0pkjyXaHgsA=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r8RWf8ZSGcjDuvCqEU47I6Pt8hbtfAcBEBpdWLh37b+nA0tb0iMVSD8fwq8ljIem+a3RpwvXvzCbc5EN9ihTSXOUhVr+Un1BzjMKOWw0eNSPW7BUvJCetkg+1AfUE7LgIcNNTGXd2ObRzlmX1z1CsbpmkFFYmrPKBBq1obIzrPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nzuCU+zx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=He1bheEJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FDN4Ct009183;
	Fri, 15 Aug 2025 16:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2gZ7ng1JUbawsLsOMC
	buV6oBBq+WJ91TK80+go6y6ZI=; b=nzuCU+zxAw6OgdUbW2w0pCdo9ZfeTls1AY
	Su1AyPHqWrQS2nBPHNpEY3ag9RK8ERaK2D6njkTPqIHi3c8yjRwDpcP1BTWFX7C5
	91+M2M8iZ4o6F6ClLetau4VyOFuwu3b2alhdxLbdBEUvllBY+FEozKaE01kzDRHj
	m/vqk5Z67OxQYwuriipqL7ZjJFPKBcFvbMr539STH/EkpNbAwr6ndk66HY1WCvQi
	yZZjGCkV1ZpHuIGWL7TVUJUfFu20Q4E8eHX5DdN0M8FAnqZjHGO83/Mw8PCDkef5
	pTfRhbqQYXXy2K6Q6uk4KvtWpMmjTonKyYcIAg2+a1nkjLd+Omxw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcfcc05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 16:06:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FFXcf9017385;
	Fri, 15 Aug 2025 16:06:04 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvse4hrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 16:06:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njnE560N+kunBGHrMGV1Hb4UIuBSDZSlXQ7hfiGvTd8E4xqJOJUXuwD1VU05uiNXUFo6Go9WcdMvsCKBu4SsGPUBhJplKi6lEJCJPDG0bg+5yrL/WCI2TbWlPbKafNTtx1UYR4gpmFC/XpjbtJn35/xREVUaxPSYIPX5KNX3HxTorjahGel/XmvcVNizF78Y7gms/K9G1rOClp/YtkO3HhUMEN3tSD4ZvBkVJ2b8XfQaVKEp8xNyQgXF0MPiV3lFzvxTuYqQcbeYaNHB9BcOKu2pviPD8OOOTCRSwKYtlXS7JJ82xikJEa2UemjMbZFQbEH5bBm3v9SGxuK1eim4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gZ7ng1JUbawsLsOMCbuV6oBBq+WJ91TK80+go6y6ZI=;
 b=x/Ka+Yl0oHi2DbwPguFMvvKS099jqkj0W9IBE0d562ywozchuxijJG3bUYMxj+AgFOtik6OkKGXguUMK1yhWuZDlru/TpIf5/IO8RWew04EuOFoiyGO3hlfj0I8T0rt3TDV8wd3KymjgmPFKrWXSKtdT8iP6gsgLI5b4OFhsvq+Y5JUfWiOIHIvyYuedRgswwet4b/DnhH6XIcipshEZOiOObwKA9+9M7P17Rs1u/kCWSl9oVLkhIhjeD5G7rBuxX+swgfmQmwhG7NQajQwhwhemyzsuMfe8/sEbXDhHlrr1ddITiA9Jz52VGRY9zUplWjim+U4bC0taGNR+yaUTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gZ7ng1JUbawsLsOMCbuV6oBBq+WJ91TK80+go6y6ZI=;
 b=He1bheEJOTMLiPA9ITVgBH2yFRDaRMCowVif7H0Gjz92fhsSjLJfu3Hkjs39auy6OnMeqhyLVX823FmStNOXLHx8ozJ741bVdtGOK6ZqUnojRZPCfMHCN3KyC6WLx4Z6K9ID3VhnOodfVCvO/SjDJyYEkKAyLqM9UjztJwtNwXw=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB6076.namprd10.prod.outlook.com (2603:10b6:208:3ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 16:06:00 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 16:06:00 +0000
Date: Fri, 15 Aug 2025 12:05:44 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: zhongjinji@honor.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@suse.com, rientjes@google.com, shakeel.butt@linux.dev,
        npache@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        dave@stgolabs.net, andrealmeid@igalia.com, liulu.liu@honor.com,
        feng.han@honor.com
Subject: Re: [PATCH v4 3/3] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite orders
Message-ID: <tnuqbtlwvxem6l26vhdg2dfxuefdyd5a4xth6wjyhm3ea3uwcp@kvimpn576u25>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	zhongjinji@honor.com, linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com, 
	rientjes@google.com, shakeel.butt@linux.dev, npache@redhat.com, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, 
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com, liulu.liu@honor.com, 
	feng.han@honor.com
References: <20250814135555.17493-1-zhongjinji@honor.com>
 <20250814135555.17493-4-zhongjinji@honor.com>
 <26larxehoe3a627s4fxsqghriwctays4opm4hhme3uk7ybjc5r@pmwh4s4yv7lm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26larxehoe3a627s4fxsqghriwctays4opm4hhme3uk7ybjc5r@pmwh4s4yv7lm>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4P288CA0063.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::28) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbaedf4-10ea-4e2e-9c68-08dddc15a095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i+AJ7S2wzUy4NAxyiXXcgINpqWxLG2bPofBjtLXgFE74s60CQf37BG8EJuTP?=
 =?us-ascii?Q?IK9bVlF2Wpr0HH1vUf/fJF2YjxfpcOdHSlGG6LkE9wZB6ovVYZe72mUeHwzV?=
 =?us-ascii?Q?zjag3rxYImbkR9MBRLkc7SCw2KlHacKQUpctI/P5/dCl+k1oz2170Iqjb8V/?=
 =?us-ascii?Q?KXjMKHu5jFJpaPfLF9rMDcAtgC9V2tQ8Q6BUq9cK3EMROUeczAXK156+Fa1Z?=
 =?us-ascii?Q?POa15ifUWf+09BvdBOkKlPPDyUvGKAWmp/uVsy7ll7r26n+DgCb53uG9G5BK?=
 =?us-ascii?Q?7NP0hrUKwyo67XPPsbGOtN7i8qE4SztuW7fowyNY40Uk2S3E0bHyyknjYqEX?=
 =?us-ascii?Q?mkzoatls+nz6AytqMsoI73vjJdxAYHFyllJFV06nAd6pmMAcd3PhojJHVtNK?=
 =?us-ascii?Q?3qnlkHLeyq6c/oH/MZgdgVsz6+OG7GwWq1/6vO3blc+eL/cBEKiQDR+yoiQl?=
 =?us-ascii?Q?IixEvVjzhDVMXctODSQ6VfgEJFO7H1hCPLE54WATptZWsgz4btAE1H9kPJT1?=
 =?us-ascii?Q?s3EhydlhYvt5sHMYSpen+mXgLasTsK0TBiJKm59dh/jrIklz8MmRUaTym+Hs?=
 =?us-ascii?Q?biOOE7jljJIgxSM97wDfzsi3TXulSjkI2OYpl9sg9atbIL7wkRB/Y4QA0w47?=
 =?us-ascii?Q?fhTgLYvfJnFsQDPdvo8xhpl98iOdCzGahgXeaa1Dw+wGWEzSCBP79dXsluoi?=
 =?us-ascii?Q?9l98yn8hhUu9PCeSwyGAYdhP/4cw8FfSTblMz6pGQ624hO2KcHzq62DGjWeH?=
 =?us-ascii?Q?9SZBap4S2Z3FCW4Lmpt1Z29a0UP/uD1IADIqFMuYJQDCwzTTNsM9ovwkZ6kE?=
 =?us-ascii?Q?l3F7Stqy9UXA+NEdg+wK5MTzCMZpTR+ouStkXxeFBfPAR9GSelwG1pLAUq10?=
 =?us-ascii?Q?Jgw2fi4fkN2Je8o0uHPaIY3R7jXcGs+gql9zUPDUrp4lNCI6TCykurWanj34?=
 =?us-ascii?Q?w0+rJgfhHcpoFZhClL38EycDB/0veuc2JtqsgvLCfJRc4v8AZZ+ORV/sVKtI?=
 =?us-ascii?Q?7obe7ZnROwx688LtPYrrCLNzLFNUM8Wi+2Aw0223Tspok2nLSPcK+GjFi4GB?=
 =?us-ascii?Q?fkSDI6ghPgakzsHcMrJQMdVHL3OiTd4iSjCVuBuNpU2EKjofqWFx0mNFgWKj?=
 =?us-ascii?Q?AtXXfFIfSpejeG5OFqXEmICz5SQAp87QGCNmAm8fp1vnz5yqm6vyDsrqWeHS?=
 =?us-ascii?Q?yiAiu9yL/L5m6JiciI0myi/ajzJkorsv6qTl7N6qD5+AuKMZ4lU9N3jeP6NQ?=
 =?us-ascii?Q?ItUSqIVpMFbXeMap6g5qb0DxM27f3+qquXlxfFXr8N3qFMASnmm1UY+QsXW3?=
 =?us-ascii?Q?Z+HRuphRznw5Z+gwUXdfWMLsB6+cQMuzsx0xjOfZ8qAcN75Ja91Uewi2rDkY?=
 =?us-ascii?Q?7FZPpqrwprStJV02Aq4zLKhP+nyUzbXOKSg9/Xw+4O7OcfgIkzOwGl3gXklD?=
 =?us-ascii?Q?C4VXo+zhfzDATY3A4QOn/xrLueWoq0uLxYVFJ3rkj7qauV1uGamXzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fMsdzA9rjRBBBGZl2l2aVjrMqlHQyQ3sE+MqPaLDJlsMyoGln101JwViTSgz?=
 =?us-ascii?Q?TktK5va9cAmlng0vibGUhZr718110kcPK62GVOFF+BoIsJWRkJMKztWfq0LJ?=
 =?us-ascii?Q?vxpNX/LX6VAkNvvFGOmAxSa50UHYGCqRVMWg4aPqZO8VKVnn6dfNNlCQrz8t?=
 =?us-ascii?Q?Hj1vLrRhvY5jPbzs1p7uHxHWcivfZ8MUouwtpTA14s1XtvhqUhpAKJc6iciH?=
 =?us-ascii?Q?tU33TuI5Km0Sz+dKbMZopktbsP87hy0cELrqPAfMUAH5I1RC8p8PSCVIpYvn?=
 =?us-ascii?Q?yLoYFQmbnjDna1am1NDwGCWutf98Bw6SAryRXwekEwhyv84oKQAMk/PH0K1m?=
 =?us-ascii?Q?7nrUC7pOhyfoTjgOLkKdJuZmKJEDQS+zuQAti02amjFwJ2lM5qWymug/jaTG?=
 =?us-ascii?Q?vO/+9LJQKzaegEzpHEYBidDQnK3owBSciPC7qY4t9Ar1vIGTjNUEAhH3w7ts?=
 =?us-ascii?Q?lmgPxhitd7roKare857VF509P7R4P0NFAczh6sQi9GzFFAvdgiHT3Xj9tkEv?=
 =?us-ascii?Q?k9+fvA8iwI7ebPrX4VBpcssM4CAg4VU5nJC/s7q4U9RvMfZTVLj54v4rusHY?=
 =?us-ascii?Q?KuHHd7SEVL2fa+auILFroilD8F61cPYnU/g9HyJ3TFGpQUlRNTrDaF+GP+iD?=
 =?us-ascii?Q?aOnht43muii+0cOG34ClO0YCEWE00zzqlW/QPrQeUGemykP5kO05dDDpYTJ0?=
 =?us-ascii?Q?5Ceb91ZzNHfFcfN9a0sJRd/1nBX/ejvINWy+Q82NjZ+o7dqEc+BZ9dPWAdIn?=
 =?us-ascii?Q?KJH34Ai5uD6YxE9Osb0SXihiWWCIrPzvLi0uxjBzloawPRvy0POyCgcTKKhI?=
 =?us-ascii?Q?/JCF7gFiWYpby/XPrZfwPjetrfjNEtY0rfPDnRphYl2tc2i0gSAWKFDi/Ze6?=
 =?us-ascii?Q?Bsv5svLcFwXbEcTLXTcO97bMEwamGTxT0j4QUI/7hBy0hY30Xd3gBO+15uyZ?=
 =?us-ascii?Q?lqIFcp+SKvy9YM2hfdjquqcm7PzVY8pkVW8dhDmlW2FiX2DF7YHPAMalbJ4k?=
 =?us-ascii?Q?QZ3muOBrgOd1pyhHryOcTklIEf4+drNCz3K4zXl6IT6ySOYu9l1mAozdJMK9?=
 =?us-ascii?Q?3GJU4vKB5sMeevkBXAjR3z86ooICbFn88B/8AZfmK6n51AWb3yaXnSzrb4bE?=
 =?us-ascii?Q?QJ0NE4beDd2Q7oyej85LJr/shJ00uo4g9T6qOgL9KJo+KEsaSP9ohhUP4lGs?=
 =?us-ascii?Q?A65xQ+2gK23cxWfcVLlK1o7e6j/kIKs1NRsZ9egtTmzFtPkqm2lM2MK5E046?=
 =?us-ascii?Q?5sP985l8hpFOL2y/W8vfHe4zzuTIUw5mzq+aOe+yrBJm5rlGg+WQl7UdtsS6?=
 =?us-ascii?Q?mPvlR3c/ITa1ZhmSAqjZcfWtbf10kgWRTqtsm5LXdQZ2aXikj9Tc7zhODoAG?=
 =?us-ascii?Q?kbrwpZrdK0VGJObFwgtmtbW6FabFrgQ7vWBlMXD95F1hfNIE3YPboOWw77lx?=
 =?us-ascii?Q?70TMO1yIc65F8wl8fGrNYrX5zWosVZm0jaPCLmyMnvnd5d426Y2pORWF+c28?=
 =?us-ascii?Q?72/D09t9wQYJ/IlXtTdEg0tGiwt1xWJLi3A02j0OwPFccjrZmmVCQTyzqxaT?=
 =?us-ascii?Q?oG2oHAVO+YAMFoHlkud8YKmEbgEspO/nZX3RWEp551jFXGAZhPuclkKHdHiL?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NdssfOU798sKBnsDrggpOhJUPEWnlRpS0u13LSBYlGJGHXcWL3gpFhIlxfD7nt557BZWbMGUTDzngGhKCKKidEhPI7zjhku7mXMow3wBHomTFZAvdhrjHVxqjItbkt7I26fTpgYY9OhgXWxhzaBfT5wtET7HHW5vT9GNO8lF+IWSPcb1aeuciDsqihAPr9Azrb5l+OBHqrVq7rOYfUoAt1vNczcbGg2P8+b/CSK8p0MMW88samz49hYCB4pa1CsipIFcCEa/TGC93uc9nHXhUdEBpfFwe406Qw8uEXW6UelZVpWr7Err/TXOnpXxJNKbkfzEksbSSlUen+kgg5mzFs848aTZYukIxZ1uJMYCK9rI0Y4ZoR1JQXdtIXZbXNsm18iqzFI6wtfKRrYJrX/YvyiSrr8IBiIkhF0u2D6w6nk0exT8hq8dN+dng4dzlkSjRWQ/hJBf0mGxwXJXYoge9jsCKSbFqti1/KoJASYi5yWF9Rxcv66VqD3WRht5UCJLy6nptdR7nzZfsvksr0Lru4x8nUM9az17Rm6nI9eFMDaTqwwOXWYfc/jVnxukyfYkVDlFuRTnLZfgQzKHvcKo93eB9VM1dp4yRi5AKTSDl14=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbaedf4-10ea-4e2e-9c68-08dddc15a095
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:06:00.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOGyvZNLNnQbAJh+9tbUBA/5SBmpEpX8x8XlOpopXsGKWQpo45clVm8QRN4NWDzlynO4mrUhbvfLh/JbZgpPRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508150132
X-Proofpoint-GUID: w-ZFSSJLi-22qYNCG3vRhcv38SYIHO_B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDEzMyBTYWx0ZWRfX1bUvfyxlPU6U
 cok9T/uKoe/AVUXGhxNjx0zdVu0ZddwwHpujxS9Of0+HQx8osOqh/7g+HsDd6pyZ68H9Ejw+y9Z
 7LWfuFTUzb4ZywwrwZ+TXe9ASMI5tN2n5SVMucTTOYdMUVcEKhRKIpWGT+ftSYCR0Cjbc4FbKsQ
 dHilH5np/duLtvCSgQpyTprmz5C6Vxu6U1z8Zof3wtuJvSAY6StvbfTgVMv+JfmFoVa9HDigJk4
 50p+TBFSCWswU3FlzmU8+5UhaF+BsZ2FFrteYQcbwCdBBkXVLHrunnp3BGVodvAOD2iIuAAuf6b
 1ae9o48g+Nfu8GtTUqiJQEgq3638o3zcAyK1+wV3RpDvLLPzTta9T7eUxmqwlhTHQmPhIIr/+Vb
 MpxZSdNbEkMOfc2lBbQf3ORWbi2zVcsDv9G7X2eg5aZuxP+eELHOrMb9xLX61t3p6FMF8tkO
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689f5aed b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CvlTB2HrAAAA:8
 a=ZsEY0Lvu8KfwinP7TggA:9 a=CjuIK1q_8ugA:10 a=67QrwF-mucXG56UA-v15:22
X-Proofpoint-ORIG-GUID: w-ZFSSJLi-22qYNCG3vRhcv38SYIHO_B

* Liam R. Howlett <Liam.Howlett@oracle.com> [250815 10:41]:
> * zhongjinji@honor.com <zhongjinji@honor.com> [250814 09:56]:
> > From: zhongjinji <zhongjinji@honor.com>
...

> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 7ae4001e47c1..602d6836098a 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -517,7 +517,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
> >  {
> >  	struct vm_area_struct *vma;
> >  	bool ret = true;
> > -	VMA_ITERATOR(vmi, mm, 0);
> > +	VMA_ITERATOR(vmi, mm, ULONG_MAX);
> >  
> >  	/*
> >  	 * Tell all users of get_user/copy_from_user etc... that the content
> > @@ -527,7 +527,12 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
> >  	 */
> >  	set_bit(MMF_UNSTABLE, &mm->flags);
> >  
> > -	for_each_vma(vmi, vma) {
> > +	/*
> > +	 * When two tasks unmap the same vma at the same time, they may contend for the
> > +	 * pte spinlock. To avoid traversing the same vma as exit_mmap unmap, traverse
> > +	 * the vma maple tree in reverse order.
> > +	 */
> > +	for_each_vma_reverse(vmi, vma) {
> 
> How is this possible?  Both need the same lock..?  What part of
> exit_mmap() will race here?

I see, exit_mmap() and the oom both use unmap_page_range() under the
mmap read lock, so they can race but since they'll contend on the pte
lock it doesn't really matter.

This is so rare, I don't think this is worth fixing.

Thanks,
Liam

