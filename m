Return-Path: <linux-kernel+bounces-739591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59249B0C843
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8264854558D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3EA2DEA79;
	Mon, 21 Jul 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bmoqvZ+n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gx0fdmIh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FF1F463A;
	Mon, 21 Jul 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113364; cv=fail; b=MK1PuWYfKDekrKIr0cLvEbcBpDGeGfS/m4PYiRGw5oTjnNa+EvRDiXc8GjF+dyNqyu9yQVR6bHTW2N+cH/EKVHrY3roSHsGbfien49/t+30krWRcBjLzo6HKJ3NIbI+Z6woG2gwmzg2OfxBp0dfQvzGQ2TAJsgPUIdO6jBZ7hNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113364; c=relaxed/simple;
	bh=0wBZxZMKfjk+6lFnc7u3hBkdzGAmXLQGU0jgMMmfsvU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i4GKstWxTWy8afrk16YrYACpcC62EiIb7y/lmcLN/OCNku86MxEei/JXSqE8OsbyiZ/yagFaa0LYjBEmGEVbdFIawKdDbIPqFindvMY5VA2IG4Ct/sQ1E8Ms2xAfRMlrws38A7EE/pg7u8gCv775Xv69qkUmbkpeu9sfDgnARGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bmoqvZ+n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gx0fdmIh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LFQfg9001349;
	Mon, 21 Jul 2025 15:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=PzWSjOitGOkqigaZ
	nB8DHST2xSoVGZuN+ovipyCYmtI=; b=bmoqvZ+nKNopVOjAeZ0aZxpmbcnA4q/k
	/UJv1DCTAazBQfGvgZuwgtivmtI9MegoiO3QAp/7cmBQsB33yehZ/KHFJVwn+nIr
	6NHSjXW3UrFdNXblT1+h2xF3HtNeCcrpqB09nLZONBqKSub4d+XdI2KTsrCVCWjv
	8zxK2A/2aBALLtOhalSH5VHddOVFrHyE9N2XnvsWf5yL7I+WFfVNL+57m3ZieDP1
	X4j50KFgbYnixGE/kMB0n5J04ao6P5+2nQP+ACDkc5RCaRzspD0gcNO1XTfrcdJg
	P9s7GIJFxK/RaYNVvLHUQ3MkrIMIzMUVwXd4wejQEVrMXubrUiXRmA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2b173-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 15:55:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56LEcm6a014408;
	Mon, 21 Jul 2025 15:55:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tegcxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 15:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3K0XKLL49QiLSFMFom9jbEDr1tF6//HAe7XDygPFbaXz5kkMgrwVOOkLAPfiwXYESkWE4rR1xr4bIzFOWBVA/DNJlj6+Hb9cVx50jnxcUGFfsSwrDZ2A00dpd7qg/y1RRbDAAM6qaWpVR0gyHp2E+uO0IQx+IMDjdqckFczD1B1ecfHu8wUZtQQd6B1rz0Ww9i0ynfieRQorYIDBS1iEJl3cKCL+909nnwV+tBzVTvMYpfDR3bU/ffjZbgS5iCeTIb97lxhwA2TJZZMzS2UtXFieH1IAXDh/81mVOOy4xE3ZPJ02/kIGiigPWMziEZprk5CHHQYv+OepQ0gYDs7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzWSjOitGOkqigaZnB8DHST2xSoVGZuN+ovipyCYmtI=;
 b=U63LZAJlJUuLqELd/9OeJCmQj5WeP2TaIP8SYmbPl/mA/3H3aBL8l4hrWBE/SBcGqsuFYQnPsCYIvWyqFJcpTwzR8NH3swMTCGWdhXCqBBzPoWLBLWTvkL6uYC/ntB63FthOYLlB/PFTa4PrjwKWwPnVLo0OB7N7LCyknjkH27NZR33++6sc+B8N+55F5qx8qtZNj+GhZzrPTUXWKwluWekYx1L1QLXXf0q/Fa/6zDLmpUWaJlfHRlkrYwlB0W7vS3Jdzos0zhpx3zFV67IRT7L5PGSQnJu4Bsqh5gJoQoOphKbAm6jMWeWFjegmJ8OMXRN0xC6pxEU7coEBBU/ZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzWSjOitGOkqigaZnB8DHST2xSoVGZuN+ovipyCYmtI=;
 b=gx0fdmIhs2yzVkMh7RkN0aJMcu9Li8QtIIRMENptWvN6GsX0IjHsLKNb+EB6tu+H/oVVG41JRq+ifVtVXLr5u574lwUaCf0Z0pB5nrw4UPZOy6aeyRXbfYMT0F8D5Y7wyz7K1NI6vTNXbRhEiSilDxPr5J9H3uBC4aMHS8xHtJ8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 15:55:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 15:55:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: update THP documentation to clarify sysfs "never" setting
Date: Mon, 21 Jul 2025 16:55:30 +0100
Message-ID: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0252.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fc363a-0c2a-4f8c-ee1d-08ddc86f063f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FhHIX0tnItYOlM7TGmWY9OA57YRk6ByXdQGLH55WGLrevgsBqP24YSJSCuoU?=
 =?us-ascii?Q?1bxwshdjCOfLGBM5VS6+sbualI+bxErIb90WU+pNBWluI9DL1NIrS95R0INN?=
 =?us-ascii?Q?R7B8hfa/2oY3bgJ4JqisMUpVeD5kuzIOeLrU5j55f/n4A7DiQ8HPFelSu3Fk?=
 =?us-ascii?Q?o5vaZ/pb/5tyZieKYpr9UHGMs/nqsoWozPBvMwqS38upG/85vzOe4IH0inbd?=
 =?us-ascii?Q?LDqqFY5JcgAO7/drbtA7m4sSUV9qgtrB/YaxIa/xvOaNh7kd7xfoY48epBuY?=
 =?us-ascii?Q?u4qIjRrzddn8+Tbr7+KVFB+c0KXyWowQb45mn8efSy4KUS0VeiiQa0h1hIOe?=
 =?us-ascii?Q?LUKL2rRbDlnScHY70r0lNkYCnn1fMMuFwBnWiyV/uCz62Zi5nz2ZVvqWX1wc?=
 =?us-ascii?Q?KqvExl8AjK7N09yLxmtqI5tUatJsKa44mDCRHRxxAVvQJETBlVTLzNetc5E4?=
 =?us-ascii?Q?iHD/djNPCiqr6vG8wJPqe7bEq0z3thYQZnfGjVZAnw21HuX9TLfhpq22ZPoq?=
 =?us-ascii?Q?Dh0diUqTORI02kgiKZ1NeRz18fBe2eCzFh/gmU2v73uxSvhG/ZoaCKiog1k/?=
 =?us-ascii?Q?aB4HiGZybL3zOQoFhczNG5ePODhc6A3NaB8HkbPywIvGKj9PDhvfJb+s7GH+?=
 =?us-ascii?Q?l7iwRdz6I/gqPmjoJNdfW72cwQn+DQbX1FXr88/wef/Fmc8d3fBJ/LVS6kZK?=
 =?us-ascii?Q?VKOjfoUKg+FAKpjsq2fLOwuEtFw/n+C3eCl2pwnQRA/LSfclrfvE1/baa2Cx?=
 =?us-ascii?Q?TQQNu6iLP4CK8A0zjuUyvKX3DLg3VQwxNLAzuovWIWZl0Xa4PHaC0sVhZGB6?=
 =?us-ascii?Q?tJuVcfyoiK8/jMtugFOQ60ijnnutSc2CIxvpZhm86DgyCQev4z+uOCP+QAtB?=
 =?us-ascii?Q?7hD6LMXtpJLCMxM2FxN6XAG/4BB2SCXs7ewp9VpcSeTOaiO+8JvtMjT0atVK?=
 =?us-ascii?Q?x3N0CAgRjeqM2Stxki2pvg3al40bbEpGgEfIpR9VHG923U22uDhJtNhuEdUC?=
 =?us-ascii?Q?MOTKu/aVNf5sWrD4Mt7qxIZUQbPubtLxOxx6gAIZucs6TVA+1xjUcMur/7Wh?=
 =?us-ascii?Q?ukpUEGvfcExyVhd91cSOrCT4IqpTi/Fu8533W1ZF/zXzxQNiDxSnw9GzDaut?=
 =?us-ascii?Q?Kb+jwo/0RBCMtdUTL9X+8qLYo59RCGs5yDZvPvv4Qt9XUhugHys8n2nDEbLi?=
 =?us-ascii?Q?O44pbt43yGYpcubT/mYR9SQ6oUUVUcstkDSi3QqCbIXgccKt1rSnu5fb4yrO?=
 =?us-ascii?Q?i5mPDgHddf0kYXmsuFH3eYDC1U+70sSUT3tl+2IfXlYb/Csl4v3LEjh7ZBTh?=
 =?us-ascii?Q?zruPs6NXUr3+M05D7q+eBGQaXz/McAWEABkrY6ERpa/2cj1Icy///NE4EFTd?=
 =?us-ascii?Q?ZHAebkzOtN41a2hqpCQJdE+XGhm2HUxcPFkmN3UfJJJdb3lQ7fhoyH3wiJbY?=
 =?us-ascii?Q?T0vCZ5cbbCo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TMipC9yhDUfUmGxpK7WRPSm6zTLJSiXmMBu7y9G4dBNmhwaAG6hYKHBV8g/K?=
 =?us-ascii?Q?HpKbFxcWnhwN0rrTwpUw06MEYzSgYxB7y68K6bbf3/Vi8bNhxNQK1wbBpxuv?=
 =?us-ascii?Q?4C2XP1yS4eXBvW5OOuuyKhiO6qEPzyrdZkv6YClaZK+QwI3PCWqmi/k1+1Nj?=
 =?us-ascii?Q?UfpToOYbq9KiYZyH3DcS88MORroRmk/BX0lL3snH4Yb/ryF5NciuQMhXKu3B?=
 =?us-ascii?Q?2QjJBqK6v/s56vl0ewlPRvQkMACaWwnDkOgnF541etQsdPhDvxSPANDBL4j5?=
 =?us-ascii?Q?14xoklWUz46vUomZWYr8MsdlNdTGwLegrSBV5TzjB90ckjYWSfHs8GxsjDNh?=
 =?us-ascii?Q?rB/RHV70T4MXWcNCwyg6Me8tFl+q8IA9V8Obt+4L5i+KejqJyXbGMCqekj/p?=
 =?us-ascii?Q?ZNMMB+EAawXkSAV3eb4dwXZzaqRa4e6ocEzu8rCDUxSqH4z7TutGoOP1hxQp?=
 =?us-ascii?Q?wPHyWwvDzHO45KEwvNOaCvq89BbBKVp5vnwlcptgSiQ2ZBtX26nDTtPafG+x?=
 =?us-ascii?Q?+6L/dX/6NCqlgWKmTNkIkbJdNZmA82ZOSukVu1YplzEJSubFmq5KzP1Pt7FO?=
 =?us-ascii?Q?SfLsQOvV7DjxnedWf3GXMQWTIP+d1d71skahBWQBtKqd7X1rZqL5DsRlpJwn?=
 =?us-ascii?Q?ZI7y2oGPfI0su/TzmYlNQAVPO/DkSy7wpRM40kKiHTDTFtW2A+CoRD+Kddla?=
 =?us-ascii?Q?bfBb0Tfg9OEMbk7EAWXgOmTCJOeC/6tscGtf1R0/VBHKFKu0HUhNl9SWyL44?=
 =?us-ascii?Q?xe1PJmT/LX1raZoMPMubwiLsvLPxldkoyRNlgjNID5krMKAP0zAQUGqQYUgg?=
 =?us-ascii?Q?GaINoJfwc5OAHFbHmWa3kE52A+nrxctR0HtYYQvqWsUMZ37r6B/1QIF2IiQ3?=
 =?us-ascii?Q?0iJ8Ic30svm75EbykGGR+CgxIcJSpHh3vj7sUaO6l9Bk2KY3hkLI1zcVJuEW?=
 =?us-ascii?Q?zV3PPLYWny2VT7CoOFFbkbe0W7H+m69DmKYJkujneLN4Q+VV7wZ9hqKLn3zH?=
 =?us-ascii?Q?0FQJhnp3jbJB45c1z+LjGNI/qDLoDhB2LrJx/HL6+cMg6MAijCYcRMgDaBQb?=
 =?us-ascii?Q?SzT3hCtfriJpS69Kgqd627q2p+VSPlsbIXcPdUhDSo99dqiAeLYG0xJI6oQi?=
 =?us-ascii?Q?pMHETRPnaWjsWw+IPOdv+KLo3H1exstu547/FwEuoWWaS9ZXazpYWAO/tgSS?=
 =?us-ascii?Q?46jqg8lyvMeOFUzDc103qNGyANt9e1rSAJnEOrEF63w/EDcCxG87khhAYdrv?=
 =?us-ascii?Q?6eCADO4D8RtKBMQkhm19qqNfW+a3wmX4EmCPXWR1Fq2aayJu7V25ZcEYBGHh?=
 =?us-ascii?Q?NgF8QZ+1pgc6UHM9CIWDYpBd7mBDOtr8CrQDOFvRvZQHqPieub3HxFTWJJ2v?=
 =?us-ascii?Q?qEW5NJtLE4kilDn/ItYEGWOOkxdtompKr3e6FJGbqUau0mi2S9NK6QENsEni?=
 =?us-ascii?Q?HxAnFKURjvoPqSDQ6+ZZcTmBp9RbT3ck1EHRrMCbApBxeRRgM7MIyN8HX/0J?=
 =?us-ascii?Q?qiG+naMoDwghrCBNEmu7xeQgW8aVX2PRtihgN/k3IVfB9zOFBbmdcgqkHGK5?=
 =?us-ascii?Q?D7LovZz1Pib2Z8fC42ztnfn5vNjsDFk8ejyzZ7uxu3XtC6EH5u8d5DgRAMjV?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jaUjKJA8EVshKdq6KAdZDBR2Dg2dzEL5/M0q5s23Quf6Q9iil6ULtVueJuKBfv8LGZEVVKV+LepGl9UpDDkOu4XvEiSjDD83JKgAw63v+wtNbaRApaZrWRv5LHhWUCme+fPRn3RMcFA2dCjBghR3BOYb5h/y1sh/OGVYp7Kf4GkHJVcMTp+oKtslYTwsqt8EdlR8rXSnLJ0ItsJusxWz71pfxUu7A5VBCo0nD16LzjXcwg/xzISj0nmiXt/Tq4O6oeW6MhWv40U+jqplUy1O5mRq54GJIkHYadbfmVXi+3UwtUUD24gft+jhQFYZ/UYKy9rfpNb9a85h8ObQaTSGYqJFeLbFrYuMzo0GYqmdi5moBfcL3Ux2ALN2FyiWHd8B0v0col/yyJ6D+ZqJzugE7l/6lkvuu826esDLTgzgHsh8au6kGQZ4G1kdP1Ugnigq4hbL09gj+No8Up7AWhBgAH1TDKNP54lz604Q6Qr9nespqRQTTUWVzyCEBv2nxF2X9Y45YH8AGJj3eupE13EwrQWsn3y92UwxYJEJanyL9w+OvofIbXUarWDuZufnaDC5KLImT8hB+9Q7Kst2hVOZhAIchhQwJWBnpV8EbvHumkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fc363a-0c2a-4f8c-ee1d-08ddc86f063f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 15:55:32.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99ywIggmXvogFPYsG7lbEYzIpL4uvnL19P6j2zH+r+dbZ7exe88jg2gnoAeXNB+YyQEjAS2b8rUkPTgam+4BYU/CRloBz7u5IxTk/yd/B28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507210141
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687e62f8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=rrLPHTsVA-u7oERAJKUA:9 cc=ntf awl=host:12061
X-Proofpoint-GUID: EWLvNWCxMzQVBlXE9QaRX0BBJiHIplG5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE0MiBTYWx0ZWRfX/i9aYyHGoRTP
 wFkG+bO+UaC1rEP9NlCyE6szrRgRZ6uENpv2cRV6Tdu3kHPlyb2+t8L26OvK2x+a0/tDoRiCx/p
 YFrB61cRZWRNrXh00Cubg5F69LK0WFMNm+srJDjCv14BPrhl+8cdoDHu/k9V3INzVfJw8YK62ZG
 jKLaFIIQaC1iAckJnBEjcePbmTpqbM1JO95jt7o8IlPKrxHUydhBvMeo/0Sk5CrtDCKzes4QYch
 GfANXTdchakZs6jbqarXUBrWXqxIFSARGx204wlh2ihKr6mO/J6NyXASJe/6afDSEoTjuZl1gQc
 7eDYyMNXeGkSwUSGx8zCdyUaDmV/iVUjrvf30g4JzsMtllO+wQOtpWF1naE2NnVyUN2/9xVqWGo
 3/YNLvYGLR2RGtfKw8LMRs/krIGnwylcKWrIfa2/JNGOypE5No2OEAHuNeS6Ii+KUAej6YGE
X-Proofpoint-ORIG-GUID: EWLvNWCxMzQVBlXE9QaRX0BBJiHIplG5

Rather confusingly, setting all Transparent Huge Page sysfs settings to
"never" does not in fact result in THP being globally disabled.

Rather, it results in khugepaged being disabled, but one can still obtain
THP pages using madvise(..., MADV_COLLAPSE).

This is something that has remained poorly documented for some time, and it
is likely the received wisdom of most users of THP that never does, in
fact, mean never.

It is therefore important to highlight, very clearly, that this is not the
ase.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index dff8d5985f0f..182519197ef7 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -107,7 +107,7 @@ sysfs
 Global THP controls
 -------------------
 
-Transparent Hugepage Support for anonymous memory can be entirely disabled
+Transparent Hugepage Support for anonymous memory can be disabled
 (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
 regions (to avoid the risk of consuming more memory resources) or enabled
 system wide. This can be achieved per-supported-THP-size with one of::
@@ -119,6 +119,11 @@ system wide. This can be achieved per-supported-THP-size with one of::
 where <size> is the hugepage size being addressed, the available sizes
 for which vary by system.
 
+.. note:: Setting "never" in all sysfs THP controls does **not** disable
+          Transparent Huge Pages globally. This is because ``madvise(...,
+          MADV_COLLAPSE)`` ignores these settings and collapses ranges to
+          PMD-sized huge pages unconditionally.
+
 For example::
 
 	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
@@ -187,7 +192,9 @@ madvise
 	behaviour.
 
 never
-	should be self-explanatory.
+	should be self-explanatory. Note that ``madvise(...,
+	MADV_COLLAPSE)`` can still cause transparent huge pages to be
+	obtained even if this mode is specified everywhere.
 
 By default kernel tries to use huge, PMD-mappable zero page on read
 page fault to anonymous mapping. It's possible to disable huge zero
-- 
2.50.1


