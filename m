Return-Path: <linux-kernel+bounces-765502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21425B23938
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172F9562AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BA72FE591;
	Tue, 12 Aug 2025 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mmQ7Gkbe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cnfwejom"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761DF2FE583
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027717; cv=fail; b=b2+8XSgnmwUTCrjYeEhbBVD8Q5yiiODwzREvnZnc7Ipbx+n9yPOL8ATm3+bgYsC9HjJNW0uhyLcHGsLGtxoaHWyT4fesc5g/uekEhf52RKR3mJTgyLwzrZ5Lp0eMy2k4aKLUBeyCO1aK0QRes2auYMmj07FLs7kpnfoHYQrIR6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027717; c=relaxed/simple;
	bh=i1PxiOonNWUZ7a/S2mkafB5SeB0eS0X8n8HimYuV6GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M9AnN2LIuQBsQp4Oz0GExOEFcFvmriqOWA+2MHCL8H9fbpnVEwyXQMKtjCW4dQLC/8RhpzvbvK019ESejJHz9l2Swhc29pa2/oMCJkRSKWotCP+1+jN2UZ/eyMXPuGKO+GEUstiTzIRbrjrm/uCCWSx7ehYm2XQZBY6F5R0rUaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mmQ7Gkbe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cnfwejom; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CJC9tv025688;
	Tue, 12 Aug 2025 19:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+uNzEzThcXXY6Wq34N
	2v+LUzKnPtH+pRuxKANuaf6D8=; b=mmQ7GkbePIbHT481baKvOhb4yxqxWrBvvB
	RSDPXSUP1qmMlmYeoSDmaS3tyV5xlUa4nEM6fYBGht9lTRMQ8rSJwIKLDgYHGzoq
	ARbS8ohsgvU9guWlg4SfhAT6A2F+oTP87J5xRHXaN8KOnMZJDI2IcfOZk7jVj2e8
	ggfa91WBVKnyEFfoVlzybLnpcOmXwUR/Nc1Lbj2LIu035GJYJ1OlF0DbIHkCuHvL
	cM9Oq/J14JyqCKITsce/JcEvfFNv8bnfh9z4vF0Jd/DEmbkhIn0jbKlrZn0mpnLK
	uCPbcSo+JlKuwed5z6wpWv2WP54i73vcnaYrGLMdwJjOLaAFogvA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8edgy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 19:41:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CIYrWJ017397;
	Tue, 12 Aug 2025 19:41:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsadu6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 19:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0fu3wL7InZgitAl6ZkQQ7mGK9xXtHNLNnTvtC7QKJCShfLUVQK8t2JWc3J9M4/zeBHb/nNAouejn3DsGipQqvEk3hWhkPt9iY35LEP5dJfrBc6dIQoyeA43yvoFTrCGIA4ObjWTydmq+uWLiReDQ+8MugltUd9KdxrRIwdGGomFBt6e7jUX9B+AGmtSsIknZi1KdjJGRhNhBosVtY07zOdxcm/Hmfke3CUrGbuK+k6dZIohUCqCB7j8lHw1C1o1w4ePVoAxQkgZlXGYHBGv6UBlyWZcFeTezrwFX76ybKnXPspAun0Ke8bGVY5DxHhEUmif8qdlReLIlwKo5QKWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uNzEzThcXXY6Wq34N2v+LUzKnPtH+pRuxKANuaf6D8=;
 b=WBnBys18Jv7TQqSGvVRlAf9cxuJHGqwQ7ZNSMW487ArgAXUw8B4u6XgK0GqdxQGkFMEhkyz9qdl/khu913el+Kd1H/rEFIGx3nkd+L2OWzQ2V72suMQeK4dZCGiolExfIg5n4z0E2iwSPXLeEGUCkflzd1a4Bi8ILvC3xcrHKMAyvy8ocNAJlwLugWjqCQLyAqPj7MBIn/RIzuI79wB5nfHPY4qGbZkNQ1Sy+fSzIwlhYju7UzNxKS1F2XVQojp6rd3rm8j+ooi0c0TgdgWudDtfCvMYo6W+bgy36bG78Zj44e0LPkBixtXTBLvlPWztqFcZgkqxZAxcY5Rv8cgv5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uNzEzThcXXY6Wq34N2v+LUzKnPtH+pRuxKANuaf6D8=;
 b=Cnfwejom5/+4/ogHtVZRM7nRj7CVq3cIzOhbQNi0IB1/SgB/ubeG+xbFPZxlLYd8wjilRAVKJIkKyF4qhVwRUc6ders9xPilQmzgrl0BdLW6mc7oKoZ71jlNvG6E1A2jiUvkSXylTi/0v8rLjMUsCOcbDGveF9Mj0Sm0ZX9by5A=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BLAPR10MB5108.namprd10.prod.outlook.com (2603:10b6:208:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 19:41:38 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 19:41:38 +0000
Date: Tue, 12 Aug 2025 15:41:35 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 1/3] testing/radix-tree/maple: Hack around kfree_rcu
 not existing
Message-ID: <erokvcuas3jqy3t4j2kjui47os4kph46swl5pjcrj5kd6lazlp@2epxbn57v6y4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>
References: <20250812162124.59417-1-pfalcato@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812162124.59417-1-pfalcato@suse.de>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0418.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BLAPR10MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 708a2f5a-4540-4c9e-0a13-08ddd9d840e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cKazqFSYmooam6ihCmKyFP5ra3ww+RQzjDn1ZXTUX/9d60ehYVwfUAtViSLr?=
 =?us-ascii?Q?tUmZZumhoxxMP3LI+o/GF9wPncsBBd2RTkIv5YnJwt4MUy90Wp/bpGpPicpX?=
 =?us-ascii?Q?ZAna0zAZ5qAS4r/bzmd98qFg5KqRZlu3TXv6SSUETjSpX+5PB9aw39/gycMT?=
 =?us-ascii?Q?Z0nyyCmYt6KtQhLI5cMMInQoQ/ZdLOxmtHjuvL86WyqSTvJrtDMsBifweAdW?=
 =?us-ascii?Q?vJDi/b9R8xM33civ+Vb59FAomfMHJxfUL8ip/pLWytwhezawB91pKgqEWiNU?=
 =?us-ascii?Q?QQxP3hMGbbP6gRg1zySUGkPqz9u7qf6qWBeWpc565JNubcSEWRnUAU/QahTV?=
 =?us-ascii?Q?9P0OCBMupGCZM9CtjAmD8etGIV1/zzmvf+ouMuaWgMfu/7XDgb8ViFUZfadN?=
 =?us-ascii?Q?IdvenA2vlYooBSLhT4U3wsrxni0jE0K65WJ1qlHX/Xb2jDNwrd/JzB+YnugQ?=
 =?us-ascii?Q?KMpqZsltVcoS7zdus/3t9HbSt+U0rOHpw7d9TxVtqlkHbCBeePwCOjPPzIyH?=
 =?us-ascii?Q?y6LksehyD5o0WKjN/FOpOfvI1WUsbGDlTURfkG7oub56y3/3E1OIA3b4sPEn?=
 =?us-ascii?Q?uGVVIJwqSFx6pSrUdRkT6Pe1V3VsarWvZ/zQElP3TnljJqivcha+H+2w8ew5?=
 =?us-ascii?Q?am9LeAdjxZOA3u0KuY2Soz8vwiVRnMX0qp2j9Tv+QC4mPmyEdoHZbazoU9eq?=
 =?us-ascii?Q?T5ZfKkPYsVBq/0UvSEnxwxe83VDv3qpg8oPOVlUFhx+drQZlcJnBfZkcD9rF?=
 =?us-ascii?Q?hDEeuVcsUl86EauJbjqrG7tsc0bYx3sUW4i5PKvf0qYt+c+CKdDbtEBtvemG?=
 =?us-ascii?Q?0s7IOT1qMzT+gxb0iwk8HP+S39moDKH1n5/CXkDhaDfFmMJOcdnkf0xKlUez?=
 =?us-ascii?Q?bsma+H407WuO9ehQy15F/bQU6UAiYLNLgV8PEWKWuIvHV9OmV9clFJgYqoGe?=
 =?us-ascii?Q?kgNvtaIPlX4U8QAW0iiFbOZvhEj6Z6OVuCglhFQ6hKtSNRwYN6588DsPGxLE?=
 =?us-ascii?Q?3UbU5FTIAIH7MWj9gmwDmmg1xDzpgwwE4V18n7bxpQue0stk+86Jj7afJLBy?=
 =?us-ascii?Q?BkEJtI66RDbg3vWz3aM+39snD4vGij2dvqK/YabfBPIgRrrc6T2SoDnZHZI1?=
 =?us-ascii?Q?hBYxPkmMZckKiE6FFLVMkai7eYhSJMY5v4RJewIIZ1EFsn/JpK/AKmg4JaM4?=
 =?us-ascii?Q?rSV/9fiKn2UquRoKZVD0H6oBFRHYAB2p82fGHP3DGdh9CJXHCWLjka/yPFiN?=
 =?us-ascii?Q?rKdZV2A59XQElL86T57SvPIaEx855C5/3t/RvlTAzLdw/pOujJK7468ABTuK?=
 =?us-ascii?Q?xrElqihvccaFsAeHcEgI3R3VS8aE6rvYTalqiO3v/S1e1FLkoye7jKiTKXF0?=
 =?us-ascii?Q?BempviA20XZSbpdSnFOWBxaYufw1h/PeB0Gd2sXOODM4Ytq1Rzz9vy3gRzJ1?=
 =?us-ascii?Q?m07NFPziVXk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MmPH/GBFEemUJ5lo08ekXpRPHaPB8FpM5t2lo6LQGfidGkRZyTmroV3Y1cez?=
 =?us-ascii?Q?+Up8ZEvwuMvSFqWDrk9rlDuDCRvcjAZ5yYVxFWfJCUaN2JmuSwtrbR9aAG/x?=
 =?us-ascii?Q?EIB8evtc9+a+L7MaQINaWXmiwcqX1dOogYgdO1ZC2y3Wi4X3JWp7k3OfnIUl?=
 =?us-ascii?Q?Y1fWkuZ3k4tg4m8FMIvF1gCa5zyy6pvOxWxFf1c9+9sfhkXitTubIbCYLoy+?=
 =?us-ascii?Q?FzY+B19gfWlotqZmx2TL4cNMLUDbXTTFD5Nhw5TgxxncuyUS9j8aD75fdSxa?=
 =?us-ascii?Q?UZ5rPS5QrIvzqbZ7mtcvD67x3PvZ1qXkhh4JwI/KxAbS4UVFsxI04agFnUEy?=
 =?us-ascii?Q?XPqhccxJYG2wGFq+mwhflsGsZ6kevrIrFhpTA0BVCrBoPU0tVh7+BBeyOWUL?=
 =?us-ascii?Q?4qBrPNzCpbOWFrIjrwvwmgpQM9gyuORn+tpXlcpNrpqCj1ZWItjweQXi7GOa?=
 =?us-ascii?Q?TB8gMFilKuhdfRrtrSwHP/2ETYeP7uy16uOQ9MygW/dXqt1Rvu8KD6UbxYOd?=
 =?us-ascii?Q?PPH2wxW5i5czPIolR2RPIMpHC5JfDwb3MweeqwyBezjrlsi+1dgsFxgn1elD?=
 =?us-ascii?Q?N+s6WcxwPKmUn/6xOTjaFUdYURWk8RBCPhXozK62K3uTWWgeWpbh7EQ053Hk?=
 =?us-ascii?Q?+fuVyJp1vCJ7mc/3jOmu4ipMFgyUBHN5NxxiorQWtYsDQwAvlz6SVPsq4Msv?=
 =?us-ascii?Q?eRjgt5NXuPc+oN8agG9YYD8UGynWoLstgOZjyRbHHEnb1D5H3UsfRAgL7P7z?=
 =?us-ascii?Q?CFKqdvbb7ZYMGBM7mXA5tSWmkokpZ8DXvymZXef73iBwpivK3MtB2hSVBjBY?=
 =?us-ascii?Q?Lyfowr6flSqGCS+v70GnXN1dHN9/SNLUsxARAZKyaF8xXmSOosFMQ8HVeCX1?=
 =?us-ascii?Q?jtkeiaXiLZN8ZXjXxT10pLMLlQQDka0avZsOgFclZZx5AFqL2SbrDhmomDdt?=
 =?us-ascii?Q?E0dr+F6EfciV3mHK1+CdahhwMIND7+BpXLHk6M2ljnwVm/2xQFhIT9SSFyKl?=
 =?us-ascii?Q?BIYg+FMkuV1TBOytrqYCuqLJoNcAklwzg4NxdsIryHLamw3LpsdfyOy/TGbb?=
 =?us-ascii?Q?dLugRTlqtHvMQ42X6L4eTBQIMIyrmjBfZAxQHZYHj3DYYxjwOCXquXrUtEtt?=
 =?us-ascii?Q?VuzTYzPuIcIE/oG2fgeoYPxbyDmeg2Hqf3DU+kljDzD3Aij14Of2T163U6Ip?=
 =?us-ascii?Q?qEaJXvZ1ep5jrH8n2qELxT9LEO7IoLStVGSjhV481xBmaabHzRDAqq8NgiYT?=
 =?us-ascii?Q?M1V8pGedSt9zhwIXoALW5o8JUBuzH+pJT1ze7dk/yFRUyM5b08qZGp/AMFAc?=
 =?us-ascii?Q?8WMk8X5YTiKgNuqUP7eZ5L9yobi5YxdBjoR3mXqPjVAdgitG5TIbmBvB2fss?=
 =?us-ascii?Q?Yy+yahDYIoHGeOV1vzbICOoxfu3v9SSUrOU/3DXjuAbpK2628AiK0iGSqC15?=
 =?us-ascii?Q?rQea74cinD+ecaTlPUvtYXMrw0c2s5aXpFico0XgURL6mlshz+QV9Tsx6DmK?=
 =?us-ascii?Q?FCrCvRuY5QaXNOXkX7FI8BNMmdjvHfq0JZvA3g7Xjav/hWZP7oO8gaslGYEO?=
 =?us-ascii?Q?WvZiM5uZnLGDs/H6ygaUY0AJ+DzPuxC1bHG7GvMbNUroidecr4d7yG/DDgy2?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+fL5KEMjc30mp7tzcnLpjXDGOuefXrubdm2nSxQ9EGkZ0IvWoYwWF93+osig2oV1jSedxQfGIhn6pJbefXO/30Xd1mkFcSZIepV/k4SdC4Ih0MJ174AKtKybXb8WsyGjKr02QbG3n3Pjhzitpg+fC1hrT+kiGiRv3GrY5LPLJvSxPMogy4EhiB4PafOOsxWc6VDDB0uVO7OLvOE23kbMjMCfaL1+BpqM7ynAv2tRliEPabx/o1cBTY5cOWH8DV8KzD/vetzPiXaXMg8c5LOTfz4ZpE/Wvk0Nk9Z+12ndYDcldZ8GCuv5XxTcsfj6xWNNlao0IdWvfsRmkpV3MnCu7QQlPF3k7ibJoHULxDQ2TifsEutyLWJrj3s+tcbY+0sIlUKjQOcAUZm0hF7BuliBPEMbWGvNv3C7ls7PbT/1OiSrZnjir3WTlYmomwYWM4yltEhdWHsCK0Cq/ntQsdBKVk5laZ4zgO6zqEZWCGWTt/59VUPJ3RVxbseDIbQDj/f/NfX9yiVV9DWrBtr0BpXb6UCVfp2s1MtYsj7NchOS1t1OOFe3WDnZ89XZSP2IB9I6rxBPbEcIZT0Hv72u+uKPOetkRdDCf6+tdhPhtJOYuvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708a2f5a-4540-4c9e-0a13-08ddd9d840e5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:41:38.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Qtzs8twC2PE50WiVzZ1razBmgx6AfSXn2kmmC0laPnUrCEzOxStRsiPHicg+wvUmp8RyZ4lklsxhmCDb0qTog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120189
X-Proofpoint-GUID: i8QmVhz0Z0vHmkXNAKzzilNHbFT8_aB8
X-Proofpoint-ORIG-GUID: i8QmVhz0Z0vHmkXNAKzzilNHbFT8_aB8
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=689b98f5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wcJrYnJmcS420O6A8-sA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE4OSBTYWx0ZWRfXysnU/tRmnk6r
 fsZxxhVCQi5PpD9Fb2lbzI1nQwrUPV+KJDXLh/7U00hxsBA/xOLhFW1gLS0WoHBf/2sHDWYd1Ql
 q2YKMzEC88UR789r3msatm+VCtv2a3xViO8yjUbbBnz8QkjF6oOzxcVZ7PCbuUk4f0JEtYHVqk+
 ZVo3thJQFjb6rtr23EYxSl5XKY5o/3uemInLkQELC0apw3meDF1vGTg7ryd/jnwFZdKzRTFhM7m
 3TapxLuUnwQ+LBGDhkMElRAMMGVYAG5lCI1nyd5bUiRPfb23MbKx54wFoKn8CoJjF31nVLBjm7S
 qKjE+CDemerGgzZuOVv3uRHmr0A7e4C6V1kuMTzcKKspPDRDlse3Ka2Eglfng8CjbbRCHVkatnP
 M8REtQ/45G5/1qQQRxJENAvoskACQhJKXLqs8onKNqmjdPAP7a3O+s1LhoQE2iZpj2aho8Za

* Pedro Falcato <pfalcato@suse.de> [250812 12:21]:
> liburcu doesn't have kfree_rcu (or anything similar). Despite that, we
> can hack around it in a trivial fashion, by adding a wrapper.
> 
> This wrapper only works for maple_nodes, and not anything else (due to
> us not being able to know rcu_head offsets in any way), and thus we take
> advantage of the type checking to avoid future silent breakage.
> 
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
> v2:
>  - Move kfree_rcu hack to maple-shared.h, to fix userland VMA tests, per
>    Lorenzo

This is going to cause issues with sheaves that's probably going to go
through vlastimil's branch.

We're going to either get this to go through there with some
modification to avoid conflict, or we're going to hold off for now.


> 
>  tools/testing/shared/maple-shared.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
> index dc4d30f3860b..572cd2580123 100644
> --- a/tools/testing/shared/maple-shared.h
> +++ b/tools/testing/shared/maple-shared.h
> @@ -9,5 +9,20 @@
>  #include <stdlib.h>
>  #include <time.h>
>  #include "linux/init.h"
> +#include <linux/maple_tree.h>
> +
> +static inline void free_node(struct rcu_head *head)
> +{
> +	struct maple_node *node = container_of(head, struct maple_node, rcu);
> +
> +	free(node);
> +}
> +
> +static inline void kfree_rcu_node(struct maple_node *node)
> +{
> +	call_rcu(&node->rcu, free_node);
> +}
> +
> +#define kfree_rcu(ptr, memb) kfree_rcu_node(ptr)
>  
>  #endif /* __MAPLE_SHARED_H__ */
> -- 
> 2.50.1
> 

