Return-Path: <linux-kernel+bounces-732783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB5B06C11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BD2500D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93D37261D;
	Wed, 16 Jul 2025 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oz41taY/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CF9cme+t"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D47262FD4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636025; cv=fail; b=kTcWatH49H6++WxAmu3vo/yImgm8O/2O3rHf/9Hi+17xyv0nnodhJAckcQ40/xjUVX6d2n66e2y+mLTA+X4PDKiWVqEGv/Srxs8sePa6SegekI5g7CYYjRgcvXATOwivRdvn8UWKGE2A9ri3/QVXCMcG7xUUMJb2otqRZyhm3Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636025; c=relaxed/simple;
	bh=XTf52yFBWf7ydGXK2RxVo51Zt9p8kxBK7hqWA0Arkak=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=UfS8hY8BHpf6wOatnsMiAjPFSX+/UlMLpWEY6ZW9wCo+mR/UnjXcmnmyhb78NA3x3c+YVahxmTZIiSfObC5Zm0s1PAudIaIx057D0pMdNPN1Y/cZKQwS5+90laDeiQR79zKUVNpGy276dpjjRzUHgNNTMXYEpa8A0aQDiOk5JwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oz41taY/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CF9cme+t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0fmsL009551;
	Wed, 16 Jul 2025 03:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xnIIy9Mf68XxYB4tnJ
	pMvvBr+u63ensjlVMcECvPtEI=; b=oz41taY/P9KR0GFsylAzjTGpy/k/n7kcT5
	I9entlxj/KrWkXGFDggT7M3l2orIdD74ODC40joPzv/reDvjDzQjwsJEbh6/HNkO
	pwzkZ/EgaJMW8ilJltAPMzDfyM/nOYPbys9cj30nH7yCBLD2A2OzBa/9DKSgyMO/
	npZyajBMDy4wDGbF8IPHacTTM6YeLCn5eVJPSsR66oxJ7vkb5zxcYdp4uipg4a6/
	FfC+0S+RQCk8c3/N1YVX/jZmTceCabiwBRQfAzlJ5sb/e1Q77lSD4jPgZKJ8U368
	3E6AJ7aM3HNh0ptf5KsU93g02h07GfkibxGVUtezv8TL0M9361pg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4r0av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 03:20:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56G10ikj029563;
	Wed, 16 Jul 2025 03:19:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5asahp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 03:19:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyEusSK2YjRO5RvxguYGCf8CsN1icc09OYxm6Ie+GebWxptJ2CK3duLZHtPNkVoysMqVuDS1R+cSWz4WT8dBCYHcxQwiQV0GsnCHri6MJVWOABXhWUX0++xv550EL/KtD1DTWcgdLAhu8s8O0sXhZw+oTcavLHLqRBwqxCi55Su0RFaRQUjCzrd4Y8fbqaZZGmKhp3RnPpGrQxHCqlH7ruLmw7pw71PeWDYiRsElLqgXpXMKnNhWAW52HYKvFFNfcdfnX3ujhliK+NJWGqWM1NiZPYAwGJ4htI6IIE9nWAdx1I8bQKk2HrjgHajr3rbTZCOA+jg/gL7zFlA/JulwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnIIy9Mf68XxYB4tnJpMvvBr+u63ensjlVMcECvPtEI=;
 b=C6MYrbFbzyYcDfUo4vnLoVODgJhCr42bkyI9abJzQSupELmIBgEzKIE7635mB6mXZ9L0m7JrzM83zEl1lkJAnpkC4yH+BhU0QrTF6dKDlZXbOhbfkQZtjtT44KGYfrKZrg2r0ZlTf5VkX7uHaPAmrqwkIcXjdqKoyeQQYAAhfdHf7I/MhBGO5HfERJmIShg3BvH+tmHbrcFNlLvqUxxq7JrEG9Xet+4pLPgXngVETj8es3mdR1el0PI/OXNkx7nn+vt+xXKlALrv6/YHj6gc3yrZ/CLh1ooqYUKuaV+QuSwjU+5gOBBvPoWGOXRTJ0FF6fUL9rYb+RpNUuDCsjeFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnIIy9Mf68XxYB4tnJpMvvBr+u63ensjlVMcECvPtEI=;
 b=CF9cme+tR/pnh0oSQIYqA9Pe3hiN1SY1pSLmSCUNrHsM5ayyIUmgUJxvg9ZSEKsHHbE85Fl88qpythz+bf+CCRrkPLhgNuABxyc4KqstEL0QkH5ngUAXnLQlJwwgYtaemjZcm2WFEg6hyOdIMYW6Aixa+bZEfwzJCme7TR0Ikx0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB4584.namprd10.prod.outlook.com (2603:10b6:510:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 03:19:55 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 03:19:55 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-14-ankur.a.arora@oracle.com>
 <d6413d17-c530-4553-9eca-dec8dce37e7e@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 13/14] mm: memory: support clearing page-extents
In-reply-to: <d6413d17-c530-4553-9eca-dec8dce37e7e@redhat.com>
Date: Tue, 15 Jul 2025 20:19:53 -0700
Message-ID: <878qkohleu.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:303:83::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: 6642e35f-f3d7-4cdf-5a18-08ddc417a2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Il2t0OuEPZdxDm+8Op/M03Nc32vR8t6a0wHG0IaECCp43ffcgauWmInSmoEu?=
 =?us-ascii?Q?wjmn5BIqc+mZLWeQellVT4MQqWWIzAACY6eDkpYg6cDmUeZjyXyDJJQEIIvq?=
 =?us-ascii?Q?ViklrfJxsjcUkLGX66MW8bh7OwJfhq1s2uJU9iOW3D3pJKadwf9FwZhyrRhr?=
 =?us-ascii?Q?uDh71w5syYoKeHPeJDqHOIOkgpjzmo48a+jmQzxcNi1J0A9z3N2EATdxTBWm?=
 =?us-ascii?Q?n0aZrh1kh9SeubUM/ItUKBdHR+ITpdJMlNEW/rEhxjgA7gpqeqZct9bH47Gu?=
 =?us-ascii?Q?3cECd5d1sGyOSjc2q69sNkG7zIKTVG+ZoaYuiYjORjdpbfBLM0RLr+5vUb3k?=
 =?us-ascii?Q?8j0wDcsQsu3kfb/be272sK9MWL/a+DeCMuHUkCA+r8akf8M5xHTQ7+rAARAY?=
 =?us-ascii?Q?r0aZanYlUz4dQD2YFC1QYRi9vDP9FVrCvogcPv0CCaFtMEqmFN6Iud/K1HPi?=
 =?us-ascii?Q?N7sk5tHYBdR0IVUfO+8T65rBL5ZeuzE1l0qDE2gmdPUkZipqNOdkJo8jhLCb?=
 =?us-ascii?Q?nAkMyscKp2yXKLI6wjhckjn7e1PC2sPGr6+xvbuRw7AXGnPwtJd1DBsUIPUQ?=
 =?us-ascii?Q?qhKlg+dZBWdhJn92fhIvW+c7zmF5s8CiuAX010x9qVGGzmCM8V3SQhofeUpS?=
 =?us-ascii?Q?OjH4mGGAkHN8bAIr7CIw24e6T7zHsj8kvYenmnzlMqBXe5a+wxOajlEY0k9c?=
 =?us-ascii?Q?rcDzzCSx/KqZOl1sxMcWkRtqjhcSVr15SOdLlNTfB9AtNDfDvZAUu6KoMQSj?=
 =?us-ascii?Q?uIaaaAK5ESLtM19lnfQhgTDo1y43OYIBEVBJBJjmHgHZZLGESZ/mKNecNsz2?=
 =?us-ascii?Q?sbRg0tRTz7hfVCSnUTK2wui/7p+PJqDHo6fiBxvGYwl2ubUBIGsixK5YlVp0?=
 =?us-ascii?Q?eQbLNucssYUMnQckxROQH98TN4dIjeORI8U+MZfKM3BVQeVXrshqZO2b4Iyg?=
 =?us-ascii?Q?azri3FqWc6bwNu2xp9gXci+EyZ3J+Yj8UDt1gJF3wSS7rM6T3PzhP9tE4clv?=
 =?us-ascii?Q?75qNe+Kmjw5UKPRiUKLIw3uVEen0kKUcju8OuPnqCPLGrQBiKqd2bh5XQ205?=
 =?us-ascii?Q?QElw31+K+gjXgZPQ9PiZIr7CwI9srSbl236FUIsBRaszixn2kNpAxcb0XTq6?=
 =?us-ascii?Q?O4OcLoP+2OuNMhn8a6hmMDTuggctyR5nwttKU3cjy6C2Edh7RgMllsW+I1Gh?=
 =?us-ascii?Q?mTSS5R6Gq03dMKefF/E12dIzuOAN71fO7AjCZY5/HK2wp96rBx2fM94eaZtd?=
 =?us-ascii?Q?rZhcmcmf3AD3eZ4zJP8aso4gMY/pJ6Yj6J+hTyLClWlhRb4SuCYVeoP0IBlJ?=
 =?us-ascii?Q?OCSnYrEyTdVWzlw5MAN0Pyk/UoYTwjFs5QJD24JhB62UR713kW3n+DPzl7Kt?=
 =?us-ascii?Q?r/dBKFeVhsvy6yvqSk/71000M6o3JM4A6uNy3+fc4FumIlo6Nkp+lyKK0amS?=
 =?us-ascii?Q?oh5M+MpWxyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+TBMcWelalBZ7R73EkWjaLW4lSPgdpYQU8fchJE4tcyhwO5MsxcqwxJ1EFN?=
 =?us-ascii?Q?UItN9dTAJXhUJanYyxlkux4Gr5Sof9rYlhPdCzBJAdgcGzo1AOpvZnPsn42f?=
 =?us-ascii?Q?RJUyuwlxpvcmx2lTpyvOdCj7qFoKi+OO4+5KHxr2MVw0rjMBMnRDnsfiM5ee?=
 =?us-ascii?Q?wezcy6t2I3/OlKqqyXWbFMGy1HHZdbBZg4B5tq1heg/9uxXg/Z0rBYjVqyWn?=
 =?us-ascii?Q?CBXQgnT4ly7RDVXvIampxzFu1z4tiGy4+t9CevHeoKDixoWGm4lSXOFgayzL?=
 =?us-ascii?Q?vwg0iwp5nHhvkwXz3CNTiuVnkcMbdrEFCmjDv9dM2nAUMEnu5ifh8VumSmoz?=
 =?us-ascii?Q?56X35jJJ1FJ1TWj366j8XHkIXibmVgnYKDEUMCR6ecxdsMLcapHjrI9Bke+I?=
 =?us-ascii?Q?eK4r61z1egh2Q0XSP4Avw/CMnvjDqkR2raG1SpUN3vHVNPOYcCN0G8oes3U/?=
 =?us-ascii?Q?27e3fnl23i+BSDlMPayb7DYMLsS27buwvWNiocb3MSA55j8tBWb15tPnXjYB?=
 =?us-ascii?Q?i7xuKjBIh+HJ5xrq9PTl4TR00Vjt/YUy6HfZUEb9b0MjxuqB0TtK8D7NYUOz?=
 =?us-ascii?Q?+0+yUDPFEYsTI6EiNlIeTeRnNevsj1DERi3BPGOkEKAqpoNilgqrWKb6eoRI?=
 =?us-ascii?Q?Z0erZkPbNBV8wZbClVkseUwBN8eNjBqAuoRZPMHAX0UvTWt8rqztNM1gxolI?=
 =?us-ascii?Q?AN4W88K+y/feIRLFrsw/pqAFdCZXJk2K/qHOPqswEOneSqfyUuhIy5LI1pfZ?=
 =?us-ascii?Q?gj/It5tLansZxaj/xBIumiNqZb6hMU+eaE4zSRL/yCSCtZu1iZM0KAQ+GP+i?=
 =?us-ascii?Q?Sp7sDG67tlj15iHqTUx3EmXwXEkIE+DQ+8gOufLPO5n55c2lnPIMY+WKU+Wr?=
 =?us-ascii?Q?vfLSl/adag5mAiMZuCEHmI9TUnT8ilsW6BgUnL9582vByle/mBylclyYaeFZ?=
 =?us-ascii?Q?HYwS/8GBQdE0+uEyWP9a14KpYRq62+0UZ9QyGeZwxGlSq83f01lG2JTZq50B?=
 =?us-ascii?Q?DZKyzi86LnjzHzjWHuI1KrBt9tzG9yOAMO3lmpGUxQPiplePzW/P5RO3P5xo?=
 =?us-ascii?Q?cH9IdNvrEW3xxBd1nrvzvxZ+5P+3L32qPuh8xIgJbCGD+kPhEIr9PKD0WgVA?=
 =?us-ascii?Q?Kd1AQVMjihgkNUxC6oR+51kVxg5YKF6rLlSN3g/BmsyHfuQM0rXHFgKxWkcF?=
 =?us-ascii?Q?YP+hx6P2wD+qQeiXLtotLXg9vXz39bGiuhjT9s1+2n/MhNEJzKoQn3/JXN39?=
 =?us-ascii?Q?HiRvaTMAVAqWF9/jhwM+PYV4crHsv+lGPDxr7jIuBvB5cpp6rG6tUVqRiBBl?=
 =?us-ascii?Q?qSJBzNDzVq4msClz2xjx3seaWQO/H1BjXoSLwe1zM6hBQehd/idasUxuU/cq?=
 =?us-ascii?Q?F4TT1uoz4Tdye0b2rijjQ977SF0VD+L+/wsshZ658GxWUGwirWExoUmGjCbG?=
 =?us-ascii?Q?EIY14S+FTS43Q/2GKmcw60LLFGG1YjTqjnGGouyz/z31V1mLUMh4LeeHvdOJ?=
 =?us-ascii?Q?eFTsQSnZBZw+HnR630yUY3V+3HcwGRGPwsdmbu0bwIrD+jV0ato+aaTfqRNu?=
 =?us-ascii?Q?CRp59GLF7w2Wox9Crz0UF3tN/I672GhmBvJVyrRujHwcsYAzz/6YHPsejNZn?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2QoetY6Nq/HJuweHheuE3ZARX+YVZGlA8PLlw5yiIndMOXZA0BkQJl+FTnYgnHKDu9KACJiAqlJSagexEmgHlWzGNiUCtNiHfMMrBJ0OUXDSYxcKPvhuiaOLWwuCwNGSSqUKckLIP9/uno3L/+nfOkG2uIoCbFqo+zIT9wU53WRAjvEgWvOGCJLdVACfxteedazGduPfhvhNy4nFyPv/SJYt9GcijMDZnE2l+ILmRuotRwchenFAdEoYFsL6W+GTNeUq1mZkG2Un/s+gJ14wUSL4lCHHG7hu8FdzJtqrgixtlQitTJvzim9Cv3tX+WRi/+8i0XYYK9yG0emhVRtObee8E4uiw/OeEFuHlNOrx65+1PpKRiaBrhTrxcAO4Fz7YyMiuYphhmc1mbHUuZ6VS1OlHuwLkHTQ6HQBJk7ie4Grqu0Ae28z46Sbh72sPNz+e1sp5/iqL4qi5Rp/+Ticu5K4QxPLAjl7h0LaNB2KEih0YaCcUoPnqMauIyMmJBiWI9GhC0W2U6hhKMkpSA750WpmVSmItvBGJhWi4YrC18Zf045/oCH2WA16kUOOFn6Mxw4wR5eDass6vZrC9lutsBXOMOJuIZuZJiWzLUPYZNY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6642e35f-f3d7-4cdf-5a18-08ddc417a2d3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 03:19:55.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUKwrcQqnQmnpjTQHuHSxtL3EylVriurO6Iz+iJdWtFudI/ObQ3udy9DKAx8EKiRhgnmaszzOCOFCGyVs5HbgdsmAhiGpEi77tK66envgJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507160027
X-Proofpoint-ORIG-GUID: sNYA9us3Fh7y7FFrxeSFa9X2dufQBFqs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAyNyBTYWx0ZWRfX3BOuwlSEFV5c yF0KwyHB4N7uS1IASwyqx7EkZ3zfJ1fiHV0gLAQMcJgN+ITnBB7I4jhkTHT+Mv+k2vhvcnAXjV6 mZx4YqTDJjLsYJBkINem7K/JphJ6GbNuBEM+aXs90uxt+iFPOvewjnVIP3QDHBunUWznSzWMfQ0
 /MbeiyjYiJFTF8iVDdEcoMqOt7WY9bMIXcreLElGFJGMN/tH7op8QvwYJPcN/wPOG+cKcXgtCwU 2Xmq/8jUW8FdoOePQPPhMBHgwCNUzJWbZYg76PmZkmpefJno8wrfG7uFGztYSptBA4b/3gOBxBW FTBg6CodDIwSwYtToDLW2YZyAuKqE9ec9bnPnuSi3NDsqOPfjT9hQT68RK8HlYjG18Mo6C/WauH
 FVAba1+TsTjv0EZqvKL0tDrTN6+ETQLybrXXArCTBUl9KuvbZVsu8t+st0Tguw8XWZcpq8cx
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=68771a60 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=fx7QZ4k6BEcpXh221ZMA:9
X-Proofpoint-GUID: sNYA9us3Fh7y7FFrxeSFa9X2dufQBFqs


David Hildenbrand <david@redhat.com> writes:

> On 10.07.25 02:59, Ankur Arora wrote:
>> folio_zero_user() is constrained to clear in a page-at-a-time
>> fashion because it supports CONFIG_HIGHMEM which means that kernel
>> mappings for pages in a folio are not guaranteed to be contiguous.
>> We don't have this problem when running under configurations with
>> CONFIG_CLEAR_PAGE_EXTENT (implies !CONFIG_HIGHMEM), so zero in
>> longer page-extents.
>> This is expected to be faster because the processor can now optimize
>> the clearing based on the knowledge of the extent.
>> However, clearing in larger chunks can have two other problems:
>>   - cache locality when clearing small folios (< MAX_ORDER_NR_PAGES)
>>     (larger folios don't have any expectation of cache locality).
>>   - preemption latency when clearing large folios.
>> Handle the first by splitting the clearing in three parts: the
>> faulting page and its immediate locality, its left and right
>> regions; the local neighbourhood is cleared last.
>> The second problem is relevant only when running under cooperative
>> preemption models. Limit the worst case preemption latency by clearing
>> in architecture specified ARCH_CLEAR_PAGE_EXTENT units.
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   mm/memory.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 85 insertions(+), 1 deletion(-)
>> diff --git a/mm/memory.c b/mm/memory.c
>> index b0cda5aab398..c52806270375 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -7034,6 +7034,7 @@ static inline int process_huge_page(
>>   	return 0;
>>   }
>>   +#ifndef CONFIG_CLEAR_PAGE_EXTENT
>>   static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
>>   				unsigned int nr_pages)
>>   {
>> @@ -7058,7 +7059,10 @@ static int clear_subpage(unsigned long addr, int idx, void *arg)
>>   /**
>>    * folio_zero_user - Zero a folio which will be mapped to userspace.
>>    * @folio: The folio to zero.
>> - * @addr_hint: The address will be accessed or the base address if uncelar.
>> + * @addr_hint: The address accessed by the user or the base address.
>> + *
>> + * folio_zero_user() uses clear_gigantic_page() or process_huge_page() to
>> + * do page-at-a-time zeroing because it needs to handle CONFIG_HIGHMEM.
>>    */
>>   void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>>   {
>> @@ -7070,6 +7074,86 @@ void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>>   		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
>>   }
>>   +#else /* CONFIG_CLEAR_PAGE_EXTENT */
>> +
>> +static void clear_pages_resched(void *addr, int npages)
>> +{
>> +	int i, remaining;
>> +
>> +	if (preempt_model_preemptible()) {
>> +		clear_pages(addr, npages);
>> +		goto out;
>> +	}
>> +
>> +	for (i = 0; i < npages/ARCH_CLEAR_PAGE_EXTENT; i++) {
>> +		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SIZE,
>> +			    ARCH_CLEAR_PAGE_EXTENT);
>> +		cond_resched();
>> +	}
>> +
>> +	remaining = npages % ARCH_CLEAR_PAGE_EXTENT;
>> +
>> +	if (remaining)
>> +		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SHIFT,
>> +			    remaining);
>> +out:
>> +	cond_resched();
>> +}
>> +
>> +/*
>> + * folio_zero_user - Zero a folio which will be mapped to userspace.
>> + * @folio: The folio to zero.
>> + * @addr_hint: The address accessed by the user or the base address.
>> + *
>> + * Uses architectural support for clear_pages() to zero page extents
>> + * instead of clearing page-at-a-time.
>> + *
>> + * Clearing of small folios (< MAX_ORDER_NR_PAGES) is split in three parts:
>> + * pages in the immediate locality of the faulting page, and its left, right
>> + * regions; the local neighbourhood cleared last in order to keep cache
>> + * lines of the target region hot.
>> + *
>> + * For larger folios we assume that there is no expectation of cache locality
>> + * and just do a straight zero.
>> + */
>> +void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>> +{
>> +	unsigned long base_addr = ALIGN_DOWN(addr_hint, folio_size(folio));
>> +	const long fault_idx = (addr_hint - base_addr) / PAGE_SIZE;
>> +	const struct range pg = DEFINE_RANGE(0, folio_nr_pages(folio) - 1);
>> +	const int width = 2; /* number of pages cleared last on either side */
>> +	struct range r[3];
>> +	int i;
>> +
>> +	if (folio_nr_pages(folio) > MAX_ORDER_NR_PAGES) {
>> +		clear_pages_resched(page_address(folio_page(folio, 0)), folio_nr_pages(folio));
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Faulting page and its immediate neighbourhood. Cleared at the end to
>> +	 * ensure it sticks around in the cache.
>> +	 */
>> +	r[2] = DEFINE_RANGE(clamp_t(s64, fault_idx - width, pg.start, pg.end),
>> +			    clamp_t(s64, fault_idx + width, pg.start, pg.end));
>> +
>> +	/* Region to the left of the fault */
>> +	r[1] = DEFINE_RANGE(pg.start,
>> +			    clamp_t(s64, r[2].start-1, pg.start-1, r[2].start));
>> +
>> +	/* Region to the right of the fault: always valid for the common fault_idx=0 case. */
>> +	r[0] = DEFINE_RANGE(clamp_t(s64, r[2].end+1, r[2].end, pg.end+1),
>> +			    pg.end);
>> +
>> +	for (i = 0; i <= 2; i++) {
>> +		int npages = range_len(&r[i]);
>> +
>> +		if (npages > 0)
>> +			clear_pages_resched(page_address(folio_page(folio, r[i].start)), npages);
>> +	}
>> +}
>> +#endif /* CONFIG_CLEAR_PAGE_EXTENT */
>> +
>>   static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
>>   				   unsigned long addr_hint,
>>   				   struct vm_area_struct *vma,
>
> So, folio_zero_user() is only compiled with THP | HUGETLB already.
>
> What we should probably do is scrap the whole new kconfig option and
> do something like this in here:

So, in principle I don't disagree and unifying both of these is cleaner
than introducing a whole new option.

However that still leaves this code having to contort around CONFIG_HIGHMEM
which is probably even less frequently used than THP | HUGETLB.

Maybe we should get rid of ARCH_HAS_CLEAR_PAGES completely and everyone
with !HIGHMEM either use a generic version of clear_pages() which loops
and calls clear_page() or some architectural override.

And, then we can do a similar transformation with copy_pages() (and
copy_user_large_folio()).

At that point, process_huge_page() is used only for !HIGHMEM configs
configs which likely have relatively small caches and so that leaves
it probably over-engineered.

The thing that gives me pause is that non-x86 might perform worse
when they switch away from the left-right zeroing approach in
process_huge_page() to a generic clear_pages().

So, maybe allowing architectures to opt in by having to define
ARCH_HAS_CLEAR_PAGES would allow doing this in a more measured fashion.

(There isn't much justification for the left-right zeroing in the
commit: c79b57e462b "mm: hugetlb: clear target sub-page last when
clearing huge page". Just that it performs better on a benchmark:
anon-w-seq.)


Thanks!

--
ankur

