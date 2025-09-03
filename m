Return-Path: <linux-kernel+bounces-799350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131BBB42A59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9B63B1206
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88183629B8;
	Wed,  3 Sep 2025 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bwHPFbIm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jxuMF07a"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2929D0E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929422; cv=fail; b=PTJo5iRgMWAmf1pqPBBmh30VDciUUKqjjZPiQUgxpyZDZ5EYpRvYKgVhwh4/Sd5bdF2EQjpAHJErLH7LpOuOBxEfGIxtk3ppnJCSVAkY/GtkTna3RUnpS2ED/OWI59Vt7XzA8xzEGFLj9kgo9prQAEvpioXp4nT3FX3HfqvOml4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929422; c=relaxed/simple;
	bh=ArHic2oqcCFwN9nUlp6FTLMTqkj9zXMDL9xSsdSfftA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rd5oDE9RVoB+Md8vXRSVEeva5cMnx8S7+17FB+HveGHylu7EryRReriWGe81TRkIVytBMFG9fRRIhgvKyTlV8PFkhYIvLT06rnAateEOVKT8QJOtyXOaWOXHwo4GHVeAaKTxG3MF29l7Oq9XSOdI8b4U1ZTAuDpLG9mHBss7xVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bwHPFbIm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jxuMF07a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583JtjRY012357;
	Wed, 3 Sep 2025 19:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cgeOPXbUseq43cVGip
	U9pk68sD9mQA2MuhAjVOicd3s=; b=bwHPFbImNt6WzeqvT4qZEEOI/rH3T9ECGq
	ktGTHO0JIlasIG19NoZPAqQ77M/UXgy4DdCeNokbRp7ufjSHC/LhwP9wAtV5wDxW
	MUpXDDT5bNa4i1lOl4dM22GM3Sd4naGzMjB0BFopeIjh6wF+Do+Hu2b3D6vAqoD7
	vHBwWooEfXxkMBH98IAR+cGmNfAef/Xrr2czqenL8aeP1JYn3rT1VmAnHJf0Z/GU
	pq0X4lXsqZEbhdQCR2O57qFCGMNQtwkUXPREYL8f3NhuIbZaksl5VlMXHF46Z95i
	QHL+3SiqM4pgb6lDeu85hiZ2NDFJTJN0Mpweb+OEzWQDg0oCMgNg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xv19g15u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 19:56:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583IxOA0031028;
	Wed, 3 Sep 2025 19:56:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqraud6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 19:56:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpMkcumuS/Ong5/9MSMJyWhqbSNqgd40c6uXwFcchhP8ZI9erL+QH2Gfv6yd0xRs+UNlvMqt7l0UWvcMoUISoY7Rmlmd+t/qMlkRmLXXz4mOTctsAfIkfYJl5KfvrYQRQYfT/MQAZhEAxGwnuZPj+orfLPAFNlrcLcx706vh0gI4tJRB6MkyFu4UXmNqJBeyYai8YQgfALhNJTakMC3ISh5xJbiRQ7N4gL6Dvmys87v1Sw9YTSWcwkFAxIqQxraUicOWwcwCabkzv1JO10sN93nIxnD9G+3I2brVYxoCOlzbhzqlHJ63mCdK/fYTNsMnpKaPljXT5uJzScWHMPJoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgeOPXbUseq43cVGipU9pk68sD9mQA2MuhAjVOicd3s=;
 b=VkQZBuwMX9+cHvQPecSuk9jS0VFMHtlwxX+CvfUsAEkYMgTqxYWclYYGiVhiKFDDyQjq6sBE2Wfn8fW1bVvFnQYtO7myZM6bsvb0PZvSfzzh2RC9t8kiM7B2vjunZ8POCODjxozIyPHVVaoURCC6qnxIGZg3Cn1YUCf4BUyuV/nAfcxH1nDnXw+p6B2CEAB6sgnKQmHX6B1RRyVf9qan+LiE+IGUvBz/6FaDCRiONJ72/wTtIQuKdHCkc6Kxs8MpVAW45wAbMcGDdPdd/JcMfG0HQsMgdzAumpJEtff36yEiVe7xcdl5XWpBwNyNl6FZgNaWMqRf2+Zyb3EorlAO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgeOPXbUseq43cVGipU9pk68sD9mQA2MuhAjVOicd3s=;
 b=jxuMF07ahY8eiDC6LobAdZLWMGbVrmv2lyLf/lC71g6g9rT5+Amm3bOqCqjWMcY73BORVO9bDpjkaH/q8j/8fq1c4j7AM9q8rE6RidOtc611XJSaKx/CyGAlDEjmW2gm/IA/aPKwpDvLDwj5Q0qR68L14NWJBZmQ3mCkwdeEYVs=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM6PR10MB4348.namprd10.prod.outlook.com (2603:10b6:5:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 19:56:08 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 19:56:08 +0000
Date: Wed, 3 Sep 2025 15:56:03 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 2/6] mm/mmap: Abstract vma clean up from exit_mmap()
Message-ID: <ft4brzgr6jitmyfs4jplbokpqoz2z2ejsudfrezuke2oqygbs5@b5i3zaxgxrta>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org, 
	Matthew Wilcox <willy@infradead.org>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
 <20250815191031.3769540-3-Liam.Howlett@oracle.com>
 <bdb27f25-d979-4dce-889e-a2fd17fc06a5@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb27f25-d979-4dce-889e-a2fd17fc06a5@lucifer.local>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM6PR10MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbd1c48-bff3-42eb-d8c5-08ddeb23ecb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tb/Lf1XdwvZRGuHxyogB41sbYeVSJaViPy6kx89k8hDDemWBsTA3Dam+H7xN?=
 =?us-ascii?Q?Z7KUxDmOpRtE1jn7QCjKh6GFG5u6s89WDEmr//1vVmgwCE13YGiowgg9zAJC?=
 =?us-ascii?Q?kwwlBM7H9I9cNlGXBVBdDFZ9aC5c6LQzQpWqQ8GrZHN5I9XZm3/XKcDgUnKm?=
 =?us-ascii?Q?gwhxk7A9N3rmQhKgcc/zlHN8cDUK2Uh3cgvGZQlGKS69+vHcYAy4vVJ+HZYj?=
 =?us-ascii?Q?jf2fPCGLb2PVC9/CkyAoRrrDoP3Br5xe6JpiXhk+7OLp7CpJKrvNa8RMoXDe?=
 =?us-ascii?Q?wZm5JFENyPBTwvYCPbGftuVMLc5PtzcwtYCFzzSxxBXJtAxnBWWi30POJxo9?=
 =?us-ascii?Q?mSwKA4QFapBhY5NTDgzNUWDVCeGZfOoaYm7LxETRfypzDRWtWf3nZlf/6N/X?=
 =?us-ascii?Q?s252NojkLSZdozOMYW+SPivFreRAaoYim38pdieFp4gtyQEG4nd9t+i8MkA1?=
 =?us-ascii?Q?NnX7913O+TOpBLofm+GI3Ls7TUF/JRb9uJBWqKGdvkwKOb5cR8YBmycuMSAm?=
 =?us-ascii?Q?Oa/WUct8Gg1C4RfBRjUqNRtx/HyjM+TTUV95Nr/E+q5Gxq5er6bjec4Uw19/?=
 =?us-ascii?Q?tuATY+GhG3XeWhA40NpVNssvrs/UmFNP9Eq9Zwrbg2h50+W0bxgliHzi0kCY?=
 =?us-ascii?Q?uBUshPrQ/nza7TRWZXtaWJHubQygR+FAwlPQC4Lq85PCtg6CgRED5l2Ol20z?=
 =?us-ascii?Q?dp/fHgOiiU+dpE/lkK6CYkmN2XpMVU6DEMeNkX3Gp6iNf+UfJ52jZhdKZLPp?=
 =?us-ascii?Q?6l8Z5LitSXyHPZdjrwJzL4P4sIOIW+fn/dueRI70zUBh3kxv7yjYq+VjM/ur?=
 =?us-ascii?Q?GGwLyzukgHTPZpyHtZVKr0SmeBzC2lSmHE07WF+rN5eVLVQPLZUZSUMAvJ04?=
 =?us-ascii?Q?IZfutRfAMJgnaUxEKtNEuIb+5i4R+wKpXVUziJ4AxWahGoe83ba3hXVVFE1Q?=
 =?us-ascii?Q?pUs2gWbZ9HLdx9f6sLOYZzYThL0yM5PsS17LnQXX44qCqx88rIsn24pm6H+T?=
 =?us-ascii?Q?t2woDE/ZTW+9O1Ccj10kxOrhJZWx4gcfn4+pxKdNXgWgigUHyRD0JqA/W2sy?=
 =?us-ascii?Q?JjTEKaq5fdzuBox99KS0NK3T1F/3ovnHBTIwnAu5pKMmlLyiKHzEUlXLge4E?=
 =?us-ascii?Q?fIrykHOTNd31rjCG27eZsYIZmY15EA43EXGpgtsGg54gn+u4rgyi02LMsBGo?=
 =?us-ascii?Q?r3xyLvPiR+32gDQX/0KNbxPAyxf8to9zX4dnOX+vlr0ePg2sRPpvmAxBJEf+?=
 =?us-ascii?Q?HlQWBxkibAbq8qRFWxYURbd2njKW2Vr+sI6xIChNS77I0hi6pDnl/iBu3HOE?=
 =?us-ascii?Q?+u5tCU5XVgoPsRYA5aSojOL0u892utBWCVXdspnS3cvWMu2n22YOA/mUDeE3?=
 =?us-ascii?Q?oqzjr3/3RWNYGQkgEVo4d/LwXmFdZEi6cJRDLnKm1h7WXVPWWT+Q8+ipqVyR?=
 =?us-ascii?Q?TVGUlJ6Q4Vw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QFtN+pLc6Wr/bKEKacf+1kzPFBsWzp/P59ly/YiUUOoIKsN0WbQ2AqB1UeBk?=
 =?us-ascii?Q?lMw4EK+dB1YoDi6dqMDPdmPm/myXjNW/n/aYLCJZld6dMKOuL5bqvk0yQYYj?=
 =?us-ascii?Q?A2Wp+nLBtIWl62Ty+2Gg+Z51tF/aJi5JTv8Pks+dNy3aVv+cBM8Dy/6540QI?=
 =?us-ascii?Q?B5CGwnM/xTg1prE97pTTnFzsavnpYOIjvJJa5a0ssiRszNIJwcNgrQ2GBIWG?=
 =?us-ascii?Q?1EdzeKZsveY72k+8EIuac+pBSOVQup8nYiCUQRWb/p0gbyUnkkDp988ASZ+Y?=
 =?us-ascii?Q?yBIpusDJCvpk4WzLK/XOEZA3EuejpXri9wEIU9M8uYQ+vClHYYxsZPBbbJKa?=
 =?us-ascii?Q?zFhYNAw58NjfNX0C9CZ/pd6TaDDtTdIdoBLjaGWlxV5JVqsTJIzt0pASxjl/?=
 =?us-ascii?Q?btvhnlBx7VblJMuXGKc9X41AdJMFZIENR8QBkSHkcEYZx5HkPj0hV9JLjLJu?=
 =?us-ascii?Q?jRdMDMsRHKSJvGD1ERc4c0eU2wWH+HuR34Oxe5s2seuXnmzHXq5HcgQSCNqn?=
 =?us-ascii?Q?tdExQmCvO+c7JAHnII6FvL83MVSh1Pl4nFxWLZqDqlWMkF6T3gWyJEZ4DDc4?=
 =?us-ascii?Q?rY/4cwOBPYjl/pcfuro5kl9dW3HCwRYCEcMRZjdR002NR0+V+jMOpVNqn0Eg?=
 =?us-ascii?Q?TwfwNGruxHRPV8VeO5ErtwNgphfimss/vmrXukRMGceELxhQc0FSckY53fYC?=
 =?us-ascii?Q?CP9LR5ZHghrN6+5GZRw3mHpqdMdG/A5utcDfOPN5OaZ+nk/7ojcCB9iPDAxv?=
 =?us-ascii?Q?TqFNUk11H77jJ+XuBwV20qPq3xamDkiSRtNKrMA6ZJQlQmqo9BL3lXGXmDCY?=
 =?us-ascii?Q?ZA2oJplzwZZZcCNHFkFiVkcSxi/kFBNu02db9DNnpWWk8Ka8+W9m/ie0198F?=
 =?us-ascii?Q?z8VUUuwhU1TXU+5P8sJ742q8FhzYEQKY81RU5EpnZKGBXJHBVvcZwxS7XQXx?=
 =?us-ascii?Q?O9BEtACzSQBThLPH7lWZSq5emiADguPdFnIqDBAjFOaTCTMzztuSimOlR9y2?=
 =?us-ascii?Q?2A2t9aaNzCrbNRuik6R1dES98UFjPC3RwuT3Af32QetZIrqXmbFC9hVNpXS+?=
 =?us-ascii?Q?z+mIo04aoHotHms+tfFtlAKlY+hfCK8SlxukTL54tPM0xeWL0Eyf+VutD0fF?=
 =?us-ascii?Q?YkRxaC/ixLAUEBtNajAlKpV0ItIndc3W+JTjsqNvzYBGKJVH3l7zsUeB/RSX?=
 =?us-ascii?Q?0UDVCiBfxfhKe9OIvbqK+On5L1xi233Ec6y+nZg/ROypfD9m2HFjyOnIXNFA?=
 =?us-ascii?Q?SYnr86ecg7qX45G9hB02fejXBBfoZTEuNbhRCsPehmaEQEst0GqNj+VFKe6T?=
 =?us-ascii?Q?N9GN3i5BCfAHGfnB+jsZDR6m+JXKz7s7muekOUwR5p4A9bze8Dmhrj5PUfxs?=
 =?us-ascii?Q?lgA0/74WaW8lmh5prGGmLxzcOLyEoh/WOegiVY+jyV2qHI/ClmS6h1IMOryN?=
 =?us-ascii?Q?UQxVbzHFUWNBeLRpisv7NrGV6H6Z7EgFpu4ARJFWyXAzyuGOCFLpnsekLj0b?=
 =?us-ascii?Q?bDS2cLmS9Xpd77RRiNoxQwezzQPA5G2AJ7YnpCXpJSVr8VVX1jt0cfqSaNUQ?=
 =?us-ascii?Q?nmezieuDyQ6SJJZUXzxt0FxctodzmlcaTfV4KSGd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z0bRBtmpyJDa6o2AG991f02Kbi1UsHmkYi+WLXJWR6ulKrgX6+dsiy+2SljGGua6BbPY3oscGHgYhnatnpP3ytkL/KPlOGvFBq3ESpACtTX1FU0CLRyogUSE0beRPGXXyzMQ5A+oxA+GmCcM/wtMcZyy+fGKHu8Xb2F2iiVc8FXcN1ajbZ7M6Ba3e3GL7fkeAwiY5YxCATIQcKEdSOMhjAgKu9SDgcvDdiR2umMmKDxXVVZ11q3XJDMHXbZFCZ6We+aL2qTr6aFPZ0aUS2SgdzjnrESvTg5L4bSEymHxEwZB5Omb+IFYtyx5Iv4IAy9YyuCeO8ux9Wo1kEkQ9xERuylHPneCftRiAX4XUxzq2vbhpT1mbN5ZpsJ8jEVuCPZI/HO77Col0vb4zAMSHAJcaqsWTNVERzI2qg2TH6F22UeTB1CQ+pFDJJ/y4bAJhvKuW7+tbMqY2nGfSamfl+QL2err7hGeAh/qFXEGE5mUWIS/ESySvwDS1CNx1UkLcY2AFMLIAlpGDtPHlP8rY58PnienZP5XRHvyv+PQwXdC4uHtE/ZGzaB0PF/Jlo6xZ/VrVXZG0jzP4B3Uq+aBQuLq5WsfOI+PnNc6tsPkNKdQhvo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbd1c48-bff3-42eb-d8c5-08ddeb23ecb1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 19:56:08.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeSLpoBebUx/XDLGeUUdhQpP1gLOiaONcUenihkKDkRrRZ6FrkeidpEMXCWXMai4WV9dnRU68lm/FUhhH64UUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030200
X-Proofpoint-GUID: rCIls6hUeXls1oujOXo4JJlZiUFIXY1c
X-Proofpoint-ORIG-GUID: rCIls6hUeXls1oujOXo4JJlZiUFIXY1c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE5OCBTYWx0ZWRfX47ZufARKd+iK
 hSvI2tMQV6fJtvyzuvFWtLOHSNXJ3irT6ugHYL0qnrMuvcIvkjgKyz108hdTDRQoPBJJHuj4hx7
 7eSTIkItPIxzIt8VF2MyR4Kyxfg5hDWeeesf3IsKu87cMzDtNYwBQNZW6rSI1WdF/hWHU03EpuA
 +b7NnWpxl9J/b0b8Ts7BqkUJqIQBQL3J1wposMe2ojIpD9sSgzgfeczRbTa6Vq9kb79o1ZYCjaO
 3K8Wl6odqhCHu4W3OP4CZWn7lZsyr1nAspZYqwPgoY+vnUuR3XALCsJyiQMMu1baFcvSqJGAG+S
 PHe7NE3jopLTxVoS0J0aJfEHj0sU8XztE8WYl0j19SZH03jCdVdkLPD4ptvxvtJV/Dxr0COiHtF
 ceZJ323QlP5xn6FOB08ffK3iX//UAg==
X-Authority-Analysis: v=2.4 cv=a/ow9VSF c=1 sm=1 tr=0 ts=68b89d5c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=bvKNSTKTtVtgJY7s9AgA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13602

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250819 14:38]:
> On Fri, Aug 15, 2025 at 03:10:27PM -0400, Liam R. Howlett wrote:
> > Create the new function tear_down_vmas() to remove a range of vmas.
> > exit_mmap() will be removing all the vmas.
> >
> > This is necessary for future patches.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> This function is pure and complete insanity, but this change looks
> good. Couple nits below.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> > ---
> >  mm/mmap.c | 37 ++++++++++++++++++++++++-------------
> >  1 file changed, 24 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index c4c315b480af7..0995a48b46d59 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1250,6 +1250,29 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
> >  }
> >  EXPORT_SYMBOL(vm_brk_flags);
> >
> > +static inline
> > +unsigned long tear_down_vmas(struct mm_struct *mm, struct vma_iterator *vmi,
> > +		struct vm_area_struct *vma, unsigned long max)
> > +{
> > +	unsigned long nr_accounted = 0;
> > +	int count = 0;
> > +
> > +	mmap_assert_write_locked(mm);
> > +	vma_iter_set(vmi, vma->vm_end);
> > +	do {
> > +		if (vma->vm_flags & VM_ACCOUNT)
> > +			nr_accounted += vma_pages(vma);
> > +		vma_mark_detached(vma);
> > +		remove_vma(vma);
> > +		count++;
> > +		cond_resched();
> > +		vma = vma_next(vmi);
> > +	} while (vma && vma->vm_end <= max);
> > +
> > +	BUG_ON(count != mm->map_count);
> 
> Can we make this a WARN_ON() or WARN_ON_ONCE() while we're at it?

Sure!

> 
> > +	return nr_accounted;
> > +}
> > +
> >  /* Release all mmaps. */
> >  void exit_mmap(struct mm_struct *mm)
> >  {
> > @@ -1257,7 +1280,6 @@ void exit_mmap(struct mm_struct *mm)
> >  	struct vm_area_struct *vma;
> >  	unsigned long nr_accounted = 0;
> 
> No need to initialise this to 0 any more.

There is a goto label below that skips calling the tear down, so this is
still needed.

Thanks,
Liam

