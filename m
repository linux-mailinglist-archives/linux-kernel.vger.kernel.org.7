Return-Path: <linux-kernel+bounces-818492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E82CFB59277
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0790F3B6E03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB59283FFB;
	Tue, 16 Sep 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qb1zoL54";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OCEb1g82"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCAD1E47B7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015629; cv=fail; b=mplBianvMKOJZn9R0PtLzrwwXmE4/wA+XlDDq4tJdWw7pLgctyJY1YggkZqhOD7XH6D9n4+zAZ3IkMGVSzllvqEQUsNzfTXABlK71kfw6orx5bdTookRN0lSoDpXyWjUuI4qTFAisb0vWfpeoq8CTmKiWa4sQQaPR0mCOEiT+QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015629; c=relaxed/simple;
	bh=grTtanfhrg1DhuQJDlP/WuZu6vtBbrd9b0YXl/OQU8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J7h95Go+aTUPJKKjMs7k3tSg4Kat3xOu6zSCp5qmZrhBW6wj7qeEa0qFE29i3xJN7hMxJIdx5tWK7JRZKvPeF9hNr2jKe70LV5Ml360S5XXTdtgpcZ4TkS6EXg/pshM0HwJmhj6p3pKfs6p14/DNAxPmDY23FDAEhIuYhOffH6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qb1zoL54; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OCEb1g82; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G1gRhu011398;
	Tue, 16 Sep 2025 09:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Q6qplYIREKKYrTmRoc
	cQZi01PkWXimD8Sq/AhVcWJr4=; b=qb1zoL54VNtJYxNIAc5ngvYQ+pgB2uxqrH
	2IuHG4bOPB4JpY2rjuucBzGQM1SSt5IuKa/rHSoS/MLs6DBdj71Oz/Q5eg8bHyKY
	DpxVbd2wh1YuI3L0Dv/5DtrndkwzQm7BuPDsHRwKDuRmNnKkQT4JlEQJhbeetJWS
	PklR+I88fm5btU/JnDoYt5F/6nyzXSAIOYwLmPxfzc2/Y+qWP0x8dshsgf/LdT0c
	XqUnJ53WVaPN7IE4jpLKdaLaGc1naszI6Tzc9fFdd98SvrzVrDSXvSKQjDmfm0SY
	kQUXv0fCKdlaQOAf6VUl2f0/8bdZ60ArEslipkSuYk1XKYHS6HGQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950gbm73v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 09:39:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9cY2V033651;
	Tue, 16 Sep 2025 09:39:59 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2c4uan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 09:39:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU+m9V6SajwHGAfBt6Qqlc3Xsg4ZYKl+mogMZJrQPP6NAcZ/N09T89qH0pF/PnJk4D08K7N92w2CXPn39dMHUPgfw4Ywfi2XsTXLzNxZUSwl5JtyRVROr8pLCFrNHMZDB+SLtHpxJ0Pzwu+DgDmVueZfUEvOGfw0WwRR01aciJQ3iZj53iqRI6vTuXexbRWPUZHOtkqV6nqNBMfO982TxBfA3hONqpO5fD4QNuJt+CIvkUiPrrGxNt/F1ZvJ+g9q1peIkkLT5WEZnsv0lHZqAU+YvmcUHowXjbzd5wM1zXsY31NYVsEMNw4nOAJw/SoPMS8eOzDrwalyeXOWPlOBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6qplYIREKKYrTmRoccQZi01PkWXimD8Sq/AhVcWJr4=;
 b=KxDH/jmACltmdHA0TTnsh1/W7aWBMzFTE+7gfSzJI+uK8c9D4D+GlDTxjG8WNmKAe1TJZrYPNDyQGeCQVQZRKz+PfRd2HYfOfSJFzNLHwjNxvvKzGoBJVsjpsA3sM76GOpVxuJr/qgPwt55DYyO9/bf5gPrHwqhhGUOMp0RFnkZORgj9BplcTm6qhAECJECIAP4No+uyvQ4NVCJBIcesxNL9yd1iyEK/O8iMbMbLWEiYmkmuf+TRffWN1n4cT6X50TVNcEnWHWulmmoeQQjGKyxc32NifwmKq/IoUOlVC1El2ivd7GGo+YW8r2Lcv1ZANSivliToM/nsktH60al3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6qplYIREKKYrTmRoccQZi01PkWXimD8Sq/AhVcWJr4=;
 b=OCEb1g82cY70BCp2msQgBCmguKCPdT+pvictIqok1fO0tdXpO7ntdg9nGRlEneWn3TRYUY/aQ+1VxTSiF0/r/463J/bfXU1+jlU09xR32WTJYlkzQKBgGqcrd9yiY54pvARPnW6EVcNkbPG9qViKmN8CXH1/2DHmcNsz18ZssHQ=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH7PR10MB6532.namprd10.prod.outlook.com (2603:10b6:510:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Tue, 16 Sep
 2025 09:39:56 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 09:39:55 +0000
Date: Tue, 16 Sep 2025 10:39:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
        akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier
 in khugepaged_scan_mm_slot()
Message-ID: <2466c068-ccd7-41a1-bef7-6f3fefc6ff55@lucifer.local>
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-2-lance.yang@linux.dev>
 <bc86d5f7-5b23-14fb-0365-b47f5a6f13c9@google.com>
 <a0ec4014-384b-4c04-bf0b-777c989eabcb@linux.dev>
 <ol447ofo44vwtyfwg3zrdtcdlkfzzmx4rre6qhyotmwvecnec4@usa3nonuk2sn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ol447ofo44vwtyfwg3zrdtcdlkfzzmx4rre6qhyotmwvecnec4@usa3nonuk2sn>
X-ClientProxiedBy: LO2P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::21) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH7PR10MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 467649bb-7b5b-45f8-2856-08ddf504fe8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yeBRpCeIpncdzwTeTjVa8xC1dOLhQQEBZ30FGEL9Tdwo3iysfIi/OmSPQPp0?=
 =?us-ascii?Q?qxXgk3j/Fn9WvBzj9jdJo48J88YCJaXklr7pG8OXhVwsuEuPa0+tHcHmyXJk?=
 =?us-ascii?Q?BqXF5JYEnWCKc/K0229Dg6UWV60aqR7R9cDS6KAPmAb5DeuYBrclUDvxiW1C?=
 =?us-ascii?Q?QH1oee/YlZQfZPcYGDbRqBeQRNDKU0yCOmD9uKZgbs/tL4GemgTh9yAkRMic?=
 =?us-ascii?Q?dXMMJWjUyN5UzAauvVuz1LCcdc8jvpKUroRgNq7hkTsYbQ3rGnCVpGDHA/RJ?=
 =?us-ascii?Q?EHJmtNBrSDS3FxuhaYcLjJiPSA+j1qbhnQBsuvzoLWThRcXmZdoUWdtJrt8N?=
 =?us-ascii?Q?sABQqq2QO1sVwmpip+V5oIBPRMmvKlPnU9BY9bLaU98uw6PsBuCD+ViqL3gW?=
 =?us-ascii?Q?q6vsqCwgYWHN7EkER0u5ojH4dqm/0XGjhUq1GLQD6h2W16xA3zkXH+WGCVpS?=
 =?us-ascii?Q?JLbPDW3r/S6yl16GGGRHCV7BCoiwmqaHkbrjLItvA0z3rwJvVPN/cJqjHUCc?=
 =?us-ascii?Q?TY/Rw3fZgGGt5bFzk9WRQUfpO9DWrBqDGdIfPw2uYXqTVz7Ipj/ykxnSumLX?=
 =?us-ascii?Q?7v8lJRx/Ue7r1Cix1CrR+XgHGo8Pi6FzfVPZtWtitDczhwWgliGMUFvryHoE?=
 =?us-ascii?Q?XNZxEA+1hsTNVR9Zp/tuXOuTFUS6C9IsNRbk7MHKiEeAmIxccSdkaa+qWMNY?=
 =?us-ascii?Q?TnMi0/s/zFUurMQcd87xvxMOBtmhaxFCsywH8eCjGiCy9Vh9sjvHFI6wO12c?=
 =?us-ascii?Q?s5H/YhV7S1HzK7MdrhyPvMniT1uZiFZf7Zd+Gk4tfSljw/HHg7NUllxqY2ql?=
 =?us-ascii?Q?HFqU7Bpsv+qY99blTrHGX5yzf2FJyhTOsf5AUTkYQo6YJJKkexcaE20q26Wo?=
 =?us-ascii?Q?P3yiakn4dHj7gmYFzVo1zfFtbyBwm7yxlBpSf7M8kJCIWLcAFTlAc1PY19s6?=
 =?us-ascii?Q?XKrH3AzvGYT90VPcvu0oZgESvkfQRin7OGSNkfhPJ3+qQ81jQ8DJrhM7OqLw?=
 =?us-ascii?Q?wpGWGEyEbuTF42XrBy6hfG4kZYsYztvsS+XJyV1Kq8Ldj6rPea0XutQnqpez?=
 =?us-ascii?Q?cirb++841iX1Q9cenamKWh6JdHPHqkK1xAbcUG2mqR1W/ERXNcZv6iKSCUY2?=
 =?us-ascii?Q?SFb6gXslVLT8GPIV1zBThSoFhwKm4Xf4c1uwx8gati7c4GG+B48+AcVGdi2m?=
 =?us-ascii?Q?Tb6AGx4cabdKalyk1cc20QXWDhzgkRDDy2Md38JhyLlxxis7XRHF0B7XT+ib?=
 =?us-ascii?Q?xrU3Gc4/HpKs2mJ+CSeUrSdz/Q6+MnB7kOExk3Jjkoxb3pU1TdL1bH8IF/Up?=
 =?us-ascii?Q?IkVUtv8QJyblgQ3j1wF5bYIZlQ2Mht5qc1b+UgHKnq8UM6UWujfNF1uk3Ykp?=
 =?us-ascii?Q?o+mBBK66OJ2uvC89k93EHw2i6b4nyqYUYTqnH9PAm3yumvmkbiBRAyAEsYU9?=
 =?us-ascii?Q?VEvTWvsQG0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zoAdQgGd62JrkDXAJG9ZTIEqylE3VKM0inftSzz+x+N1TbE7BYfiSk5F0EEh?=
 =?us-ascii?Q?gKkHmDRuytBthK1LibV9I9XpUy/Y5c0oj5suAuQxP9EJOH7gB6Xiz77cnEkv?=
 =?us-ascii?Q?g/pYNcrFL25Z3qeA0Dkeody+8AkPXYNRrZk29wfkhDwRKfCwnSkcrxF4y0pn?=
 =?us-ascii?Q?NOI1U4Gu3E/lKZU02BVaibCMEYHS+DDFtyshgk7iOYQglQAd5uBv/EPzAHsi?=
 =?us-ascii?Q?E/ZfKNWgi6ZBPXlQF6NUWLGBm86nuUYBnQrnUea0JZ2yS9c5xLKbpcNxkI72?=
 =?us-ascii?Q?YJMaQ5kUm3jgiNxFmI7W3i6bC3N2Nzr6/rgLwvV44SF48ePs8iEFCH4/u5KO?=
 =?us-ascii?Q?hA1cqF2s7HljhOI2IqKkjMWt2appt3NkZj+fWBggO7uP9l9RWmLYSkVugLsv?=
 =?us-ascii?Q?t/DUWbJRdNzX0uErnPf2hXZYmWyoL85P2308jNFbrmMgzKdK4CFP6/amfJnl?=
 =?us-ascii?Q?ujQHkP3eXyZy9dIiIgniF3iDWuIYuvMdT4+nj4pbmqG0SeZrozeJFwwvYhxX?=
 =?us-ascii?Q?HQoZIH74xYWq13o2d6wnZLmH1JUSbVKM8KC1cB2n8M50ViMX0Kj1Y/yvrELc?=
 =?us-ascii?Q?qUeQ1xbnXsE7+Hc0GfiFdxuNZyxWK7PFu/kvns0ptt1ikgy7vvJ9nTA5LPN1?=
 =?us-ascii?Q?oKPiuqm25C2wZAMsfGMP49mLhDHYvHr2REwtWWx3ojfOGp4I7zhb8GRWQzYk?=
 =?us-ascii?Q?QlnRAkPU/RmB3Ig7eXbNDDXwZ5BtVo7afp88Iij6gRNbqjluU16IWZoq6Yo0?=
 =?us-ascii?Q?7HinNyvG3VSHYnRT1DdHmD1NMJoYHLAv+Y2jqdcKobvuOKUlMY06eNpDDr9M?=
 =?us-ascii?Q?m2mcUBsa+dtwt2omSOLDwm4AJwzWXHnEkZZtocVE/Jnu8D1l6iOjGXPNopH5?=
 =?us-ascii?Q?Uqw/5Cu1bwnNzXOzXRUwuRSAWyF2mHATZBn97xDhrobLGzwfsT2PhLHSCOzq?=
 =?us-ascii?Q?Ubl2I4uq8UKZMYop5qx8V2j54WTVNe/U1c/CGvY9rLeMNNLgDTIk4BlioJP4?=
 =?us-ascii?Q?aVryjPk19MDfUz9UkIW4jgLz+8d3qkP2XBJ9ckeKZO8eG3cHFpUoAUNviDfe?=
 =?us-ascii?Q?rFMg3kR0B64rND7+ub1wJWCfVRoCbgAMk33crsetg7hesFsYcRzir3TpIvKI?=
 =?us-ascii?Q?LUMDZvvRrAkcmpTJ9hPOkKvhDieq6tkMF+Utj+R05XTc8H0MNsRj5OhBNVUw?=
 =?us-ascii?Q?QgButDbQDjxUZFDmz9CjHgHlO3C4kE3RC2KaOQl1ozHDuHqkLjL1pMdBw1aH?=
 =?us-ascii?Q?gSuUi1OE0nlKQc4Dq9UyRmNyqG+7mhJr55QHxfEYXxaO1tSWW4jdrnT8jA/p?=
 =?us-ascii?Q?qUHNRw89qoU/QuWkmpliumApvo0RJIng6iNqZelzBrQtdGxqRpCn/jymzdnj?=
 =?us-ascii?Q?fvT5ZktIIyI3VHDjl9Ki9NPIfgU7lvqM5r2ClIMTPIzdJHthkCBXhVbqWP8S?=
 =?us-ascii?Q?6cmNA13C8Dv1wVXEKKLCLJ5II7IYAcwigzZB/PvA0jbI+2wKE4mfd9J0cZOA?=
 =?us-ascii?Q?M6w2O4jiUfimDzuEnhgJk8Bm2LeeKqzJEwPRXaFaodr5YSkFsZXrfMUeFPwm?=
 =?us-ascii?Q?KBw56mFUl5ErbcYD2faNOH4C8MA762QBZgQ7zYQ7y/4c+FQBvNXwDGXJqc6v?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3u5ZCd3YtUy/BqOlNQvGwJBAXscYuMuqnDp1F4N6Kjz4ZlnuQAE2HFF5+uF3A6OfS619+10/LwnuESc38jmM/NpzUIqqcNow6upfqzLp9ntIFVpbVLbUfYUeHAATYLC1V3km99ECRBQ1xyGSNzZYmiwak4nhDvtGBir/oOF25H2ooYprS7WVffpQmhnIoBH2gYIv4snZBosOvQct/U/jsgDscaLUN9E3Ve8GDvaoddmhRTkrzcU1QuR9aPvp6EwUdyZFjpGmrUIBM4aE2gadHV0MF2SVXW05Zm2VkvMDLGd3tCQcq8/Bz1i8KxmtI4RP6hXrLSvBawUYhIQmJtY4tpCoO8AZTR7Q5TUctwnvUNW8QV9afFRSe1OyQoq41CWKynZ7TfYcm8Sylj7NY4byPmGjKuM1bdOsaAea/PreCb+UJFBPIlijS3DinJ50wtkLmDEZLMAGJTQ6Z5afxJ4ZOHwGbTJLNO2iOk0WkIjuFhSVw48Vtb3pyibSjAUyZnVGWdGUuNCIjAl9fpQCDjOR419jTZGxvoPxM97mTLDmb+C59bF/WUWmB1ySQRAaXDUVc+lnDFpm90vPxAXxrvqQL5ntqEApjqNKGRgBJZcEHzk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467649bb-7b5b-45f8-2856-08ddf504fe8c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:39:55.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyj7OA6DmmBxubR3w0iqybJzNmh73N7WtZoqQPZ55+WwGEPD26rn8lyNggnAoVmeCd87bSEDaLpLkWHDQrH2hCzIzt6ixVYF+l1+PfViowg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6532
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=350 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160093
X-Proofpoint-GUID: hOhMz6FfFpZ7EWk69U3Lky4AQf7tleeA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNyBTYWx0ZWRfXwSnFEuzogJsJ
 9t5b7RWkTEk35dnguPog9xsCA3G9uIZ2RPPEi+EsxObOjSiMonqKtVQ02yn8J8XO1DlsYwJeliT
 kbv/uru+YZXlhnxCXuaAB5xi9sM27xuGkoQ+KKudeP9bhUS2wg2btQHvfldY7yfHbpNkrnavQai
 yTh/aXQTay/zYqYYnaamXJ2ZbF/hUCPVSjhNEis6f6ChE/VR3BeYEj9qSjHXA8YGXP1C1s55Wxo
 ErxDI6ka1MlcPLkAKPD2ADLasev8TsWrTJhuQ6m/lGaQr/0mW072A6EO/QAFYw8IedjpaWqMEuQ
 89vKzqbjbqnDfVZ5RRjFc29kKgzhd0c7cDJmpe0HJ4HYWNV3PHRaK7H1AEUAdCcD49jEkj6brob
 rH6WlIxr
X-Authority-Analysis: v=2.4 cv=QIloRhLL c=1 sm=1 tr=0 ts=68c9306f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=bZAQ2lgTys9LIOPXVXoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: hOhMz6FfFpZ7EWk69U3Lky4AQf7tleeA

On Tue, Sep 16, 2025 at 10:29:11AM +0100, Kiryl Shutsemau wrote:
> On Tue, Sep 16, 2025 at 02:21:26PM +0800, Lance Yang wrote:
> > Users of mlock() expect low and predictable latency. THP collapse is a
> > heavy operation that introduces exactly the kind of unpredictable delays
> > they want to avoid. It has to unmap PTEs, copy data from the small folios
> > to a new THP, and then remap the THP back to the PMD ;)
>
> Generally, we allow minor page faults into mlocked VMAs and avoid major.
> This is minor page fault territory in my view.

Hm, but we won't be causing minor faults via reclaim right, since they're
not on any LRU?

>
> Also it is very similar to what compaction does and we allow compaction
> of mlocked VMA by default, unless sysctl vm.compact_unevictable_allowed
> is set to zero.

This is a much stronger point.

I think we are sometimes too vague as to what mlock() means in
totality. But given that we default allow compaction it seems sensible to
keep this behaviour the same.

Unless you have a specific situation where this is problematic Lance?

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Cheers, Lorenzo

