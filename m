Return-Path: <linux-kernel+bounces-724726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E18AFF641
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66551C47595
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC3F26B2AD;
	Thu, 10 Jul 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cm1ivgJN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rszvem72"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6917266F0D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109217; cv=fail; b=n+ysamo3cTluX5jJEVzDtYxuc78FrYkH/TbOEgMm2PIiPIISGhakHRDc0CcuAQlMX6++dpaZKfGbLY4rx0ZSYiU9bBpv0muEAexY5MFCBc8MdIrOaZ/knDml/sG0hm/XMf6oakb9dCKleR/KP6GEQulpsO9N/w3X9I/T4wl9AdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109217; c=relaxed/simple;
	bh=ghY3UfVL9wZwUr3S46XouWlTAtxyyP1nKgn2JIhOvBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IzDQIcsO98kboc3zUeaqEnOmfRmYMrMhQEtKeHYTD1BXuDzicDoaPVf/arcx3xbkmzM/yvQ/PtUMKTwCycuGm+bnDkiXoDY/jf/pA32EPsGWdvCWppS7xFKrHXH2FEiWqP9pXENVdDVq+wYwF19Q2Tp2wW3MiHDt2f0TL0m/Z5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cm1ivgJN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rszvem72; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569NJ0E3013830;
	Thu, 10 Jul 2025 00:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6F8We7Jh5eEhiBzLRs9JGL1d1+COXf+4HC6sAYVl7XY=; b=
	Cm1ivgJNaEj7ulm2xhc0dyyzEJt7LaWCiFPobr3cD1zWdhZZ/ca50+VJUmFnkjYp
	1yGQOh/14xNhPIne+QZBeXaO/6sfngXYRY+PZddu9yxPWpbOn7C1M0Y43VrAB96b
	FLpf2o2S0PnFTpd47Z0GMWXa7GqpVeRGpreW5NCGidYUOvrVRAAYPRWo/h2uelLY
	qc1OtIOHY4XxuTUdGKcEFt1HYakZFTmKi2ypmBS/Tx5dzTK6uvFtexi14cBNDRHj
	3d9a75cm3jtekB6IqnBaF1V2NZbYicaCqybK2LRhR/HbhFvB70paDRrtftUQ1VKD
	x19+eNIzcfhIcocqCYbmcQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t1y103ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569N4JMa027228;
	Thu, 10 Jul 2025 00:59:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbms49-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho9g5TLRtcFwCvrnTNQFXzCM5w5xm246iH4g3Z3eaikhnQB6d5UZHeO/dTN6RmPzGzr2ITJaesfyoxcGBWACGKPdqVHZNLyNn4QDTcqp4ljzvbax8x1P44xrsN4sCSv8BoDQD/dZePZWQYUJE7MGWxPeF4VrQNJ5Sy+ekSctlISKJfsSAS+ET6UVx96aNyHAggeyKlK7wHzQX3FbIBN0V8RhieuzvnfQpuiIe8ETZgmN1644iALUXwX8VfqxhWYeg9CRu4h0fI9MZqRKfwlpkGXxomyf9R2ZloYDhjHrEf+gfUezOLqTkEnvYKAn9QqP7LNi3FFoumEfWKdlo5lqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F8We7Jh5eEhiBzLRs9JGL1d1+COXf+4HC6sAYVl7XY=;
 b=O30yIZonEzmyscp8KETvLWf90lM2AWkrVmxAgUNlVHDh0uQXBFJyptK5w2u8yfnBj9RJwhWgmJS1pcT3Lr8m7wuBvbytxKWZKBixxc7mcCJvR7Mn5vI7FxKnymaKiWJ9sVqcUqCs9YiSprK4LXfsWTLm9WdXHrCxMpCxcbIYoT7LpiYwDEjWl378R//Y/NwRvuelQWL/ZMOvqc4JDZ1IBhWZhln0Wz9BsMKjnA830zzNUH8US3FlTsnOyLzrUndtUIsWeCylC7aCOrBs1xIqeJCw4VH0+klWiOiTpXa9DR73OjRxxziJHlZS17HDVvU7nsaDuejqNCKfZrrr4179Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F8We7Jh5eEhiBzLRs9JGL1d1+COXf+4HC6sAYVl7XY=;
 b=rszvem72x2ROHaeX/7fC4WQmydUn5F91EjGj9K8mfoOq4jjcrpWRLPzuF3Zq+SEXsRNG6BsxBkqFdUt0gZt/vxuu/u/Q62UC4tcsyqPzZABKZ0GE4lYZDIlVZQsPr9fgbutJxuJ6ARc6Bt42FUVWdZmEvs0K3Eu6CBu0seUXqrQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 00:59:51 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:51 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 11/14] x86/clear_page: Introduce clear_pages()
Date: Wed,  9 Jul 2025 17:59:23 -0700
Message-Id: <20250710005926.1159009-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 52618dc8-b6ca-436c-9496-08ddbf4d1343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U9Qz+OCxDpVef4IivzwNpP03QQJRB+CX2R5j9NFwJtovyzN5L698u4R6FdSI?=
 =?us-ascii?Q?USd2fuvuCcmBbrZu4BLE0lU52qtgbJsKVeHCb+7hZcEJsSKfjUD3aXpvDssn?=
 =?us-ascii?Q?AE9kgAIxepxnkkDoF5l12uOFL4ibk5kkxAAj7fZcYM5hOustGII/77of3XXU?=
 =?us-ascii?Q?RDhkNImL3AHAz2m+Rn8IoAKiJ5E7SitkVhDetk/hgi9+lRQFqlytzOiE36vL?=
 =?us-ascii?Q?OMz2fp9JwTC2iVQX2nT5YU6MXnn+UzdRhGN1iyyrRqCnYqXsxq73yHAIshAy?=
 =?us-ascii?Q?dKj6+sL8h8WHtPIqua86paDFX6KcNwRQ/wD6KOcChjDW1uKjm3Q5GEv/D0t7?=
 =?us-ascii?Q?izo1EUal6Zm7ULCHstJh577bIcjQus2ez2piFc/zotgMQK1SuGysjR94j8sT?=
 =?us-ascii?Q?uZrTZQ+i0o7uDXEnfNpFCP74oogZiRs1vUIVE87C4WgCmmQHVNQvx+xtUNO1?=
 =?us-ascii?Q?TTSKC7qn389Ny8EjzVgYZHdiMzb+4V4L/rPDSPNwcB9O6Hk72pDHvlus+dyT?=
 =?us-ascii?Q?WG0qIJGLa/tUimJWsQm27Ut7hI6julpdDIYxz2ZiTJlaOYhlI/sgDzwsr0LF?=
 =?us-ascii?Q?aYJ05RuQD/phBZYUqXIidlnSftz8WJsVu7/9ALJfL9uYOz7W+g6GdSFHm5ub?=
 =?us-ascii?Q?2+9I9u6Pl1iZML6MN1Kz8EW8otFClgpFnsx55ppbEH3jf/EQBJBb9Qt6x1c+?=
 =?us-ascii?Q?FnOPyrLnhNAhKFlznxmSkRI43RO/8Dd5wkoDx6T6GZw7ri+km1Q60DoLCVO0?=
 =?us-ascii?Q?MDfS5AhreI4NPugowmTeiCYOOBCe8OwwplzreKXuLxxAUOjg6r0eD0n1Pv68?=
 =?us-ascii?Q?xTak6MfWeFnuxnbFHCM5Sk5q2eB4gx1+iS1A30uZuKnxOr1/Ca0SRgGlJEJy?=
 =?us-ascii?Q?/mN0/Fr4YI4RJytOfNGiBez7pzBol2Z+timMxmuRLtkVXs/2ggYa8RbhhkUw?=
 =?us-ascii?Q?yUv6BCTCNIRtAAadiMkUp1W035DfAt72YV7oxuYXLuN1RPdsAS+rzy+9vGyu?=
 =?us-ascii?Q?01uy2O1/SV/Vo9XLe/YR/mUXwJkiIxopk9a3jH0GxyeqYU0rjHxYg7DG3Jio?=
 =?us-ascii?Q?vnbYTV1azQ25Rp1ySQ8h5at/YKgZTyOcWhXa8qJIbTelO0Tw716McbX6zERN?=
 =?us-ascii?Q?or73kgbEdAVRZJ8hCkU777HpJH/h3i9XX7ev5xDS8SvXwcOdrlRzVVY3VAiT?=
 =?us-ascii?Q?VfJiyDjVqqNMf8RKb+PxrW7esHXQuttl+KD9qeNRldw78OoVN4WQPCtKiNCF?=
 =?us-ascii?Q?Yt5/qSYpaTVyYgCEOAED86UzIKSOkxRFbX/n7KI55Q3dOuF7+ikXI76BuiqA?=
 =?us-ascii?Q?DaSmi3FO+k1S0UL0mUDedJu887SmpJeJnt2TnG5hEY3uNPyaIUVQdetX1X6j?=
 =?us-ascii?Q?LHeYaFtveLqqE481I4ibPWM5cCKV34je4xqvLdGYJ85wzubaAdD3wUN5L4Xy?=
 =?us-ascii?Q?8CL2j7/hKmg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPbKB2xOkPg/PkAmY8MRAIeZukOzMOjZUor0S6OlRMeQqqqi/nirYIitn1T8?=
 =?us-ascii?Q?4vK0tuI32NyIOYgS+gVGI1VYtzUtQON7p9iZRQZ6fB80R3EUuc9T7Mvi6Jok?=
 =?us-ascii?Q?PbLB82pqshnFNXnpjxw5XIQvPJpO6EQmvVg0zhFXL7G1iclZUW0d5OiSP79e?=
 =?us-ascii?Q?8uExdXwE3EuCy9GbBmjVbsliuzE+yaC1B67JsTlEYi7Uf1glydkmToW/DECo?=
 =?us-ascii?Q?ve+71revIuiq+2WnWd40EGGvft2gLFPwtH5hvEsE4515OsbjRCWWt7P558V7?=
 =?us-ascii?Q?gmTA3Pk98PtnJ1NWZYAutZ8q1gqx0HJ8BdOb7Q5jaM5RJzh0tDAtr+O66v4b?=
 =?us-ascii?Q?xfoPin6yOn5xPf+IzVeSopzpQbxYJFb7vORR1tm6aYFsQwbx2VdWDPi5inUT?=
 =?us-ascii?Q?V3aoPCAxeWAh7p7dEA4BYSLtMcicj8XyKza1EUKRahMRz3ISsjSp1UwE4GqF?=
 =?us-ascii?Q?raHIVYyidu+QeOUqLbIj/lmSmSH2UGHslK7/b69yWc1JHF4qo3748NLzCQUK?=
 =?us-ascii?Q?mbqrKLQgBVgMdkE2bhTa0aDhAMMX2hRr2FV1huEKTDjMWdOWdkI2bAAVv3Qn?=
 =?us-ascii?Q?Sj7TG/n9lKSt7PmkpEQ4AGjQMJOaupweQ3b4hRMGvUjTKZlCR70eayNdHAIC?=
 =?us-ascii?Q?dSp0JHTWQWSeMfmIuBghqZT8ihQU0EvHQ4E5oYJFOBRZFkOZ7OBpQyJS4WvI?=
 =?us-ascii?Q?21JbT01mSCVzlcvz7uHT4Pu+0Mtfe5gPNtGXd7Pmd3xrdnvqfRKl4I0orv1u?=
 =?us-ascii?Q?pmWeENFn4wuTAzkxcnwBn5CJC/O+rm8ycaBl2vxOKbmckhm1nRCdWdXkugjv?=
 =?us-ascii?Q?KWhmL5zLWw4qPRbTG9wO1JCgWk8rcgC92xW/56dVUDCOVkkG0xrhVSaEHyX/?=
 =?us-ascii?Q?qR2KrsWH+gQ06R7NnxLMOssgAy58Lcrk6Rfc+PeFM49eoRyw/6/2B8M0LX2s?=
 =?us-ascii?Q?FKha3xhXqdEfgpyI0YFu7uH50PJyVm912oMvcY31qnMtgVBQzMC7EGp0qiPv?=
 =?us-ascii?Q?lgK4jfUWWBfvcYx86q0/BqacOJK7Gy5p+klD6gtfBo1pzfG6+2LkTDgpwvMC?=
 =?us-ascii?Q?L8H+xPlo4CCORLlIkPza8JrNJSQ2iudpJTVWm5ehPt5SpCjQX7oxddaPo9vi?=
 =?us-ascii?Q?kFnmtSEppxnuxJBlgLrB+aIOQkxXvSqtOpJQUfFlfS2cApLSMZ2en2Y7g2wb?=
 =?us-ascii?Q?5m9FfMOjd4+DdBlkrP7deaRcezKbuqAevb/un/FTmt0fnChVpo/kMQ6cMb2B?=
 =?us-ascii?Q?tfJZlooS6u4RDyk6rr5mGttiJoe/j5mKk2363C2lBci6ZQP1F5S3WX6mU908?=
 =?us-ascii?Q?kBHtBdw2zknTzFqxxFJL+ywNtcF9IqjPJf+xVqBiwbKUpDCs9YYYRozZQHl9?=
 =?us-ascii?Q?5uK4ljQfC+YLKBahmVgs20Y6yne0J5eMrXtRQXRg8kKyIhioQKtgUvaFSHep?=
 =?us-ascii?Q?nTa7opjUuz2N5/Uk+Je4k+hPdFjBimLdhA7UjeH+Fga8T/yxcJS/da+sAPUB?=
 =?us-ascii?Q?Tz/Z2tMsEfApjDSyJ5ZdyFcOLNDrOLz3MA8lyUyaCJyhXA4XGZmO8+yv45ev?=
 =?us-ascii?Q?4e69e0dcSFf/3KoUbKtYorbmF3ePsp2Elp0OtqL4EewwFxeiAbunY8lIxXiW?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pFk54Ys1n7QWRPpubJL1Wn+H2VGX5YR2kt/i94RitIJeg4+qKaJhkd4dl4jEnHt4VfHrvwIMMnAurk0N1HmuyXDZILc9+A8ktMGuu0yv5S/6MfkKBisoTZk6rMJixtmnppkM5OyYA7yrSwI3M6cVEaHw3QjvqLAKHcyUsz2fx0gtsxNh1ectWyROtyFJ+y45Z25MtFSJOslr+F6VFSLKRlF7K3KHyyq286MOq+3tQves4Hn2jVLRdkPERsqod0XbLuomUgcfTBDoSEuVoS8y5jPsJxbKtyb/Y7ydsa5/k3D2WpdQ/CTvQZq1hNHb+sX9oYpfc5uMkVKiFGQT4Ph+tX7GsEuZwKDjQXWYDBRH3M8MkSRNodeX8t65eqAbMaddSZqHgh/222uKxDFV2LLAQdnwoCo9b8IsLKN1c04B2TQAkZxFogxOQOnJAhX16+Zdm5/+tdHVI9OMxAEyG7/xipHv5jHAG7Nz8ukMAGuDe9pAJgTR9VaG1/OqycymA5pA1nz6jCjduE7shb24eGxXEDx7GakbFIJb9nbXETiQRPCGkDgdqfjt8XY91ueV/FxbNYofkd/O9rn6tVZAOYbLtC+//JrbTbdzxr36iiCek54=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52618dc8-b6ca-436c-9496-08ddbf4d1343
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:51.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsKmWNDQfphWw6po96qxHjnnzX6Rp520VoJJdPRsKFIMeIVzYXKV6xdTsHjYIBP9BxKnGZ+9HbslClFHEKiBT+AQY40KA42Br1tBCMWNSu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Proofpoint-ORIG-GUID: RItuxc2isEBk2xvAdcL8xr_JkmkITGUj
X-Authority-Analysis: v=2.4 cv=UqtjN/wB c=1 sm=1 tr=0 ts=686f108a b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Y0x-23rrHKlNlQ5AJ3cA:9 cc=ntf awl=host:12057
X-Proofpoint-GUID: RItuxc2isEBk2xvAdcL8xr_JkmkITGUj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfX4LjkedkFD/Ml YJsgVRhF1BP2B5DYR1izTryZ2HNWBj+L3rPy1J46BWHvpJvl1XeaABMyTrKtypqbFMQhe2cjuBV vZZM0RwtHwojsbalhWBnzQPcfT/l0hriy0nR7TnMlRMl1Vv3gvwO33qHCrzxZKABzIkAWbPShSo
 r4KDx0fN0bTXMwHN70QMBg1aD1bfEjPvnZdjccWFldpPU5O3rah1IYTzm82YTZFdBOF1wsyj54W Fwwd6gaGRAcE9k2S/BO8HrlsvdWAZjjSEYoQmnba6iyNFQWTm6Q9zDsdHvQKOuVyKmjCYjfl9Uk TsmlHUhDmUbdIjyqqeWWH5Y61iSEIQ3PxSA0mW2I4g1d9dsC67Ige0UMiqYoBHgvHgv7GSI7KX5
 3Pwg0ap1BO4DoFcu2f7NIiKIKPO2d9ltGJeoPW3NiaWPzZrxt+3q9D4cGkAsLYJZZIZfxX52

Performance when clearing with string instructions (x86-64-stosq and
similar) can vary significantly based on the chunk-size used.

  $ perf bench mem memset -k 4KB -s 4GB -f x86-64-stosq
  # Running 'mem/memset' benchmark:
  # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
  # Copying 4GB bytes ...

      13.748208 GB/sec

  $ perf bench mem memset -k 2MB -s 4GB -f x86-64-stosq
  # Running 'mem/memset' benchmark:
  # function 'x86-64-stosq' (movsq-based memset() in
  # arch/x86/lib/memset_64.S)
  # Copying 4GB bytes ...

      15.067900 GB/sec

  $ perf bench mem memset -k 1GB -s 4GB -f x86-64-stosq
  # Running 'mem/memset' benchmark:
  # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
  # Copying 4GB bytes ...

      38.104311 GB/sec

(Both on AMD Milan.)

With a change in chunk-size of 4KB to 1GB, we see the performance go
from 13.7 GB/sec to 38.1 GB/sec. For a chunk-size of 2MB the change isn't
quite as drastic but it is worth adding a clear_page() variant that can
handle contiguous page-extents.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page_32.h | 15 +++++++++++----
 arch/x86/include/asm/page_64.h | 24 ++++++++++++++++--------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index a8ff43bb9652..561f416b61e5 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -18,16 +18,23 @@ extern unsigned long __phys_addr(unsigned long);
 #include <linux/string.h>
 
 /*
- * clear_page() - clear kernel page.
- * @page: address of kernel page
+ * clear_pages() - clear kernel page range.
+ * @addr: start address of page range
+ * @npages: number of pages
  *
+ * Assumes that (@addr, +@npages) references a kernel region.
  * Does absolutely no exception handling.
  */
-static inline void clear_page(void *page)
+static inline void clear_pages(void *addr, u64 npages)
 {
-	memset(page, 0, PAGE_SIZE);
+	for (u64 i = 0; i < npages; i++)
+		memset(addr + i * PAGE_SIZE, 0, PAGE_SIZE);
 }
 
+static inline void clear_page(void *addr)
+{
+	clear_pages(addr, 1);
+}
 static inline void copy_page(void *to, void *from)
 {
 	memcpy(to, from, PAGE_SIZE);
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 28b9adbc5f00..5625d616bd00 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -43,8 +43,11 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 void memzero_page_aligned_unrolled(void *addr, u64 len);
 
 /*
- * clear_page() - clear kernel page.
- * @page: address of kernel page
+ * clear_pages() - clear kernel page range.
+ * @addr: start address of page range
+ * @npages: number of pages
+ *
+ * Assumes that (@addr, +@npages) references a kernel region.
  *
  * Switch between three implementations of page clearing based on CPU
  * capabilities:
@@ -65,22 +68,27 @@ void memzero_page_aligned_unrolled(void *addr, u64 len);
  *
  * Does absolutely no exception handling.
  */
-static inline void clear_page(void *page)
+static inline void clear_pages(void *addr, u64 npages)
 {
-	u64 len = PAGE_SIZE;
+	u64 len = npages * PAGE_SIZE;
 	/*
-	 * Clean up KMSAN metadata for the page being cleared. The assembly call
-	 * below clobbers @page, so we perform unpoisoning before it.
+	 * Clean up KMSAN metadata for the pages being cleared. The assembly call
+	 * below clobbers @addr, so we perform unpoisoning before it.
 	 */
-	kmsan_unpoison_memory(page, len);
+	kmsan_unpoison_memory(addr, len);
 	asm volatile(ALTERNATIVE_2("call memzero_page_aligned_unrolled",
 				   "shrq $3, %%rcx; rep stosq", X86_FEATURE_REP_GOOD,
 				   "rep stosb", X86_FEATURE_ERMS)
-			: "+c" (len), "+D" (page), ASM_CALL_CONSTRAINT
+			: "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
 			: "a" (0)
 			: "cc", "memory");
 }
 
+static inline void clear_page(void *addr)
+{
+	clear_pages(addr, 1);
+}
+
 void copy_page(void *to, void *from);
 KCFI_REFERENCE(copy_page);
 
-- 
2.43.5


