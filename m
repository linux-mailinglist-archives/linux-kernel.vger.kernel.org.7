Return-Path: <linux-kernel+bounces-724729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F0CAFF646
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E7F1899E17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648626FA4F;
	Thu, 10 Jul 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qiOonKhU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nj3RLLoP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8C26B95A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109221; cv=fail; b=Jw94gL2nMUodFt3ASHqIDUuSsczB18qqUoRoz9bIaHwSF3yF/v7lkcrlI7i3HYnBkwwE1BDlOj+g+h382Nbu5wvjeloHVyKrkBXF8yYpsj7sh/mXO7XwGxXw0vDVagMmlNZUs4mTQZ84nxgs6mkzb3NZS4JmU0P2HC2gobOj9Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109221; c=relaxed/simple;
	bh=ikkcFqKCfHqbeoaUj3x2yxoxoj6Zf3V5ThgpYTwpDRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gaYdgMHVQ+rMbUvSIdnKtuhX9y3a7HdfVdQ7R7aoEpEX7ZS4UM2nGZGfqgQDoQTwddH0t1vbWwmy9frkgnbaXHPHhv+VCoPraF1BzsCq5A50pRXAaIunoutNergzMTa5WNvF45aRmQlHAAX67UqR67vrLNMiFYjebBX7GQM8L2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qiOonKhU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nj3RLLoP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569NwZdc010431;
	Thu, 10 Jul 2025 01:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1isr2Y1EHdAvpFTmBv7zi+TKlEKWkdQE6opsa3ysDr8=; b=
	qiOonKhUtXC1PBq+AhqDOK5oMh5QUOoqS2U9lOp33COc5OJDYDYlrEqpFB0QDQs4
	Z/jXdvItThLBZkSMkzZQVin+AekIHdlb/B9SllvZs0qfqFeEI292S0D+SfoAsvua
	HIUw/Ck/AODFw/sobfCi7m3suwyyslOlpuKMqDY0wmO3PBnlGFTFNDyWH9LMHiX4
	wEgOIVr66kRfDHLxP8UJqn9axtR4imQVU7087gZ/YOwl208IbIQ3U8rMebWAW/wJ
	meHCUNFYsGIWlOiDRkM06D8MdGLN3juybZVgQoiwBqGiujF10McE3XVFZQCaaQp1
	HzaLtUjaiGcJK0T7AmkHsg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t2hwg2me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 01:00:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56A057IF023666;
	Thu, 10 Jul 2025 01:00:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbvxne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 01:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkZJaktF7VCJ0JBQVWmpX3qLmTnKQ5XXNVV5cRUxxrmbfVNxUcJO3/RPgNEKZptEPRuAA0mbzKGaQ/ISFyo4iW+O4F0w3Aef0ZkyN3VIsb15dioU/FyRdr7YKf7l43fxe0SYs1ljZGoPNel3zjrJ2GAfVfogq+ZJlLM8XkNFQwKdUDYUDARKsYVCRvujuFkCuzgHIVQoq23EfzNgef3KHedkd2Nu+p2G3W19gWWTckYNlRY3UD5AtYLKzEFMAVF+a6GvsVk4lFMlt5zpEGtGRXKVcS7kQi8YUqb2anozZOtipIhr2dWy0/l6FI/d8EXdNjJVHAEUmdvEI1bnHpfqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1isr2Y1EHdAvpFTmBv7zi+TKlEKWkdQE6opsa3ysDr8=;
 b=wioxe13c1PnhqlNPMWUDpJi/VqRN+FtBptuDLOQYerfcWqxOB15DnyJ3Sog0bxfpHOm5b3vHKrnELcsq0ZT+9wHnHi4VHBdujl3q/F0Tc2ZMusbz4nX7CWnA84OXjz+pqmug8b53og2Lt0BNbssJXpovCpFKYnX7lDv6z5feH6OG/o5yqvN+G+Z77tC57Q8sjYxF4wVvMsSHbz43fDnO0AD31+olv6BVcC6NRVru03TBZUZr4a99pkWgpUoS8KziCXG40/LaJNzPyoYn5MF/5YuYufE94mO6bJtX+VN0e5SstFbFYI9Dwui/BW3CHGKRvsem/1OV0pDwu+j2aVpcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1isr2Y1EHdAvpFTmBv7zi+TKlEKWkdQE6opsa3ysDr8=;
 b=Nj3RLLoP2a52aDrCfcf13okg1Mxge+iqYWRJKTBwogG/Bwhu6hcLncTPuwdZWLhaE37UmQxd8oNLtuWG8WF8kBJ2D5UyV4X4mh4yfM3e2NX6Is/HuQ4KvMdZaQw26DvcZb6AF4TA9ux1oCo18NeEya0L/ZRMdZWrN+I3TmOtuDU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 00:59:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:57 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 13/14] mm: memory: support clearing page-extents
Date: Wed,  9 Jul 2025 17:59:25 -0700
Message-Id: <20250710005926.1159009-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:303:6a::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4cad7a-f4a4-4697-3a2b-08ddbf4d16ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R6yEeZsEm5EfP6fnOhrzdPY0u2ljCPZT5gqa4QKRi6W+a6MmuTD4lYP2A1wD?=
 =?us-ascii?Q?+XvtK0H9YZ4yMHxP39YL+BPQ1GY+tWvEBKSdPTPAQ41fWJHx+rvaTE5/oSyF?=
 =?us-ascii?Q?7egdPjjaq3s/l4hY+xOHL9F3jlPxvElOTjQOivLmp+xpjczWzQCBv0z9YlI2?=
 =?us-ascii?Q?dz8njNiYjmeOHt9Su0o/ovDRQ87jceS7Af2LJbkzaH6Lj1N+v8Wgzq0O0JL8?=
 =?us-ascii?Q?TpQhpUphI49bLQCYv+ffu0HIGaEwPHHvMLTZ3kWb46aITtbQS5I2HvljRu5d?=
 =?us-ascii?Q?bunWRXx9kbggZErVpJxMODox9FE7jgORYGPq9A/c/KR0EqeV/dzmuQyreYFG?=
 =?us-ascii?Q?uIoVq2LfZfGqceSluYBzjngyCNVwLbrT0nSjTlaAGZ2dhMXYVVxqRaG/CUzT?=
 =?us-ascii?Q?HT+QTv5CW+D9NxrvnYUTvkdT5oWnT18aE3Bd495BVqj+cJXCCtyUsk2DblFz?=
 =?us-ascii?Q?7rkhxmi6nYxT8IEh9otvSbQE39b6By+bMCppLpTtzQIREDKdKJ6VhQAG8v3f?=
 =?us-ascii?Q?KFNbKUORoowd7WPHhtQ/z9Pjmul8V2zCaiuGtKc15wrHo1LxHlLLujQTt6p5?=
 =?us-ascii?Q?NrOH/9zMUzZTEei4w9exfCHAMBAPJinLtZh5GI1ZfStygnbaXaWydqEWL3hf?=
 =?us-ascii?Q?EjQGaCmaI5V/Q7uw8PYqNdgx7QxgUii0T8A0eAyipTkjdC34gugrlcARWOb8?=
 =?us-ascii?Q?DBpcJyOBGUzhtUXv6pms41GtQJo/663iKGdDODTaR0/QAICGkgvQg27hQMuO?=
 =?us-ascii?Q?C5YfYy0Ls3xxBeLyG0AKrc7jGIyZE0D78RBPEFsHwiFPg9TRODJKcnPNMe2O?=
 =?us-ascii?Q?Q8YROKM8efX5hWXSOOhRW1LoQYCDoK/+m6Woc7ViQwWcI/R6N1EP4KqPlwif?=
 =?us-ascii?Q?H7zu+g+equGnU0+s/EvIFuOWv1G9/kGvfMphrdu+TPyiCubUznq2twZ6R4IN?=
 =?us-ascii?Q?11WppjGM5ATAdFRfUlkkBFoMzIeDTG6Hwyf+7KS1WcM0qt4RMiwrUKcRJQNF?=
 =?us-ascii?Q?l/UT4UeKIGmSKJFYi/bdpboOw7SN/Mmxl6j4kESdVsy1gNwJvqUplKxu4FhC?=
 =?us-ascii?Q?ixb8ymFDShr8NLBqmL1oS2gQLzDZQY2sRRWuAGiE+6/NLu+F56/h6C5KxspR?=
 =?us-ascii?Q?Vz7oaS+pPzzZ4yftx0yp39R1NOaVWL7w1/SallxMvrcRfj9XjnPJ8fr7v0WR?=
 =?us-ascii?Q?jk7rtp1ZkAotXHxxYagW3BBhQFDZ8piC9dXyZh2gn3nOGbd40cmx5xmu70ES?=
 =?us-ascii?Q?wuhwzD3m2YtxYpwtN7v+k8bN4JnK4Obabr/RvGO1ZZhWeyou4nnjFWt8yyuW?=
 =?us-ascii?Q?SmH1HSiwsny3JDmQvqrU5Zk4u/wRnCTglTGQxeDp1ybakfUyjgF0tL5ehK+W?=
 =?us-ascii?Q?4bVnMaZrqST13fdK0peKjji//psP+Tthz6cBQr30Hacg7cXWDzepmrfgGA/e?=
 =?us-ascii?Q?h1xPH+caiSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YcvpMUCfPHQv9EwQzICgwzFdxIplV6yNhBcDwj2W+9vY+GyfI6nUQbuLK7qL?=
 =?us-ascii?Q?Ya4HMUmGGY0/lVGH7jS+ke+GH5Xoob5t6T1vj0fUSRku72cM/dhgJnqcT4av?=
 =?us-ascii?Q?GbbGaUZGYQvNPXT1syT31ruZuw7k8L2VSbP0gvWXFzAaGfPr/n2hQ+qbUgG/?=
 =?us-ascii?Q?c058HEft83VODh5dOwD4vVImfUQwdi8nF2Kh13+XhbdlkCdOCeICmTaUQYa8?=
 =?us-ascii?Q?wQAZnZEx3RKTCsJQSWw+nIEBUhYQnibhAMxPlbI4nZlN07bBH2XrGe09sE5z?=
 =?us-ascii?Q?fMJiJMyIdaO5FGD0KvSwhJcbEEUSHBCKSODjMHlS1MoFb6s53GQXxFkTDpUp?=
 =?us-ascii?Q?R3YmfC0zbNORn0NZ09P+nuY2C/GvYyPFy5KGrRaNawgcB+TOR7shF9W4Mb53?=
 =?us-ascii?Q?d8ElqFxWYpvjA71zEi5tlq1oRginbUwGqKbh/qZf8jndHT23wzjYQ4AEATJy?=
 =?us-ascii?Q?jd4dP2KxA1yf53S3Llq9IavTWCX5iILrE+yptWx7qczeq9R1RvA4u1op/W4t?=
 =?us-ascii?Q?c6L3Ba1XsIdeByYydCvfvVC8b8fEnx4QnmKFNNpxVjJBKZJOIoDk3PX6Ly5Z?=
 =?us-ascii?Q?ZuN7llHr5yXxMw375okdJ9SSKVcpOD+wd4jXyle1diNyzzhtOImC6DnShPvN?=
 =?us-ascii?Q?+tOwqz3nJa+23ueA82dXxeYgFbkbILtGRBDf+fYccVeTEQlwDjyUSNEWQLcB?=
 =?us-ascii?Q?m9M52DMo6xWEZOVQRbcAL34/71SD/NN27AiACUuxvKEURUj/bPYEjJcTxlqW?=
 =?us-ascii?Q?fDq/G1AqYqluhnglnEA5og2y+jBXagq/ruHP5b0OVFSJQnWg3UxfM3im38tF?=
 =?us-ascii?Q?9zRs4iBGum64AKrQC199D8pk0pp0jpX8NEvr0TcMJtrfW0wOkY1AaVU8PxwN?=
 =?us-ascii?Q?HbGJgxVILmC2MmchsPK0Xa3jGI1QMd+57/sA1qxS/2ztrwyPkLiMCSNirTv3?=
 =?us-ascii?Q?Jo342PodIfmIzNE/WEUmFiGTWuGrP34+HkqBAKSm2DpxHkx5TDz371WmHJzK?=
 =?us-ascii?Q?vxRJZKtXIdkENL8ojz2KoYlP3mzSJwMiajSWfPZW31TIgQuw4mQEFKhsPYwq?=
 =?us-ascii?Q?Lmy0SZMfuvMFUWtvK82xi9qh+29niieoEUIAM9AgxV4tEOlZzVmGaunCDZSy?=
 =?us-ascii?Q?D4v2l2LWb+sZyoQwwgap8+YatCNaoh7Nx7X2cMTXl6MvsdcKASx6VDXI9P2x?=
 =?us-ascii?Q?6/W964P9RbUhQ/9ddjk5OeuNbgOkD9biB5b3QwMjwgZsbS5ZMM8q59Z6L5pe?=
 =?us-ascii?Q?giZ5Ddg0+zhERljv4aNJYDdPzwuJ8KZoPzYbGkCllQ7y3WnVeknh21km91/R?=
 =?us-ascii?Q?UGOA9UZxw+X6H7Sx6MO/WxXnBJ5qDsDpmRDP99nTd4utFVV42wljcWRfPkcb?=
 =?us-ascii?Q?Rek6t7ZlcUkHViC8gfBfdIlEpkP5UukNqaYI8knSe2oGAfEBuJCNUqTznpeQ?=
 =?us-ascii?Q?JjgXuPpO9fd9ztyB8CF/arrMHWXrw3UWguiALJ6PvX2+ZKMQc24WrWwnRxV0?=
 =?us-ascii?Q?vhFkob/42InBsOhB+KPW/uoB3K90QKg1YbzqmU78Ytk+ih8Lzi4wqs3Wnlg7?=
 =?us-ascii?Q?PURgMc6zyytPPEHErXbMPg2mAHCXcMwAlcBU1OoaggsUCvFu+wThmvB/ozk8?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hh/ScSjWP2DyUFEN7bdYmYn8U2uZsEOezgWZckYOn2Hg1/OgIe9XjKHOdH8mqcBkkOaNMkrIzjGd9fzgWN27yB3hE6LR/+9w0WlfdplvYiVXeAWy3ZfXGxQV36rlU1blr5HERHEKHOp149Aww0nkUmuxP0Fof4OZpZg01IhxtGNCrCVAMbMvnJPcCUALIhILGNwS+460KHizlF8HLxxLw3wvrjeLBDQPPb74y3WnPPS3GLulsif+YBzBOu3t0cFGceEeZ21eiNVoF/Odkc24DAJ9oi3AeARit8kqcKiTxkqGCz79K3GYVF2gEDVebi5jXVlTkjz9I2YGB98pLkI48DfIdUeM0MloWQYnfJ/ydSR1B2wLEAopwO9NptAXiyjTUcIK2s//OArkgjja7x5BKUYR5XFAfiFFhQEteN83lFE6bl1yswTyjSS7zvzXA8fCdwfQEkJG30ESIXRzviMwwuXQIX206GFPipVpjx/lmQqpDzzmnhoOQR6VZXonjZGqivz+FKfOejmlSdI9WqcI0aAc0HG1DZpQpm5BOkGVhMf1mwwgMrpIc2i/7iX+33Lm/LyccX4+28Or9kqtZYmjnpIOmRf7HFUsFTKVI3LOsgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4cad7a-f4a4-4697-3a2b-08ddbf4d16ed
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:57.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPqoHNpaUEAGMUFJQng3xoozQEAIezuFCjHsbjdG+kjXoCMzUZkan+A9eVwpw6XTvOA6nmBQQSPeGXufYyerV9MFP/7eDnVp+PQRnBxn690=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfXykU9HHgHsTwe ewY8qRgMjoC6rRTIUEnDQUKGTlmfCmmABgie68JqJlxUOOliMmjsPOuSBwyud6SIO+N6fXQvW5U qghxh7G9yfhRviscIagVaaIfB7b/Rev18eczHvVlijNTfMCUhx1k6GMM3Gu7CpAV3n4tZY/CbPA
 bdW7sT/WQRi9+TTWPTf3tgeZpRmANM0ZorHR97T5QdPObQmgVTpMPRJXalxyYSgNcYLD3a0Birr D+ma/uRYYExkcpYAeYjz8LoHf17EXNcda3csZEWEnjxTP66FBoNwPW0ctebw8f42ZBII9GyTVVu ZXk00+5XWGsFihX2fmBqAw+zbaVUVLNd/GKFmdtUMYNVH9etBawAoCZfsSY9bxHFhwjxTYXUZYo
 NH8DGF1jf79PBoLvJ7PPJ14h/wSzECA949i0ZZNjOuClFEpD8FvPOo9aMqAR9oXl888EGE4N
X-Authority-Analysis: v=2.4 cv=BI6zrEQG c=1 sm=1 tr=0 ts=686f1090 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ikw_7Nr-yr50B0xR4lgA:9
X-Proofpoint-GUID: AS_8F3hhv_C8grmbKTSYuGsoj2Pd0Ur8
X-Proofpoint-ORIG-GUID: AS_8F3hhv_C8grmbKTSYuGsoj2Pd0Ur8

folio_zero_user() is constrained to clear in a page-at-a-time
fashion because it supports CONFIG_HIGHMEM which means that kernel
mappings for pages in a folio are not guaranteed to be contiguous.

We don't have this problem when running under configurations with
CONFIG_CLEAR_PAGE_EXTENT (implies !CONFIG_HIGHMEM), so zero in 
longer page-extents.
This is expected to be faster because the processor can now optimize
the clearing based on the knowledge of the extent.

However, clearing in larger chunks can have two other problems:

 - cache locality when clearing small folios (< MAX_ORDER_NR_PAGES)
   (larger folios don't have any expectation of cache locality).

 - preemption latency when clearing large folios.

Handle the first by splitting the clearing in three parts: the
faulting page and its immediate locality, its left and right
regions; the local neighbourhood is cleared last.

The second problem is relevant only when running under cooperative
preemption models. Limit the worst case preemption latency by clearing
in architecture specified ARCH_CLEAR_PAGE_EXTENT units.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index b0cda5aab398..c52806270375 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7034,6 +7034,7 @@ static inline int process_huge_page(
 	return 0;
 }
 
+#ifndef CONFIG_CLEAR_PAGE_EXTENT
 static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
 				unsigned int nr_pages)
 {
@@ -7058,7 +7059,10 @@ static int clear_subpage(unsigned long addr, int idx, void *arg)
 /**
  * folio_zero_user - Zero a folio which will be mapped to userspace.
  * @folio: The folio to zero.
- * @addr_hint: The address will be accessed or the base address if uncelar.
+ * @addr_hint: The address accessed by the user or the base address.
+ *
+ * folio_zero_user() uses clear_gigantic_page() or process_huge_page() to
+ * do page-at-a-time zeroing because it needs to handle CONFIG_HIGHMEM.
  */
 void folio_zero_user(struct folio *folio, unsigned long addr_hint)
 {
@@ -7070,6 +7074,86 @@ void folio_zero_user(struct folio *folio, unsigned long addr_hint)
 		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
 }
 
+#else /* CONFIG_CLEAR_PAGE_EXTENT */
+
+static void clear_pages_resched(void *addr, int npages)
+{
+	int i, remaining;
+
+	if (preempt_model_preemptible()) {
+		clear_pages(addr, npages);
+		goto out;
+	}
+
+	for (i = 0; i < npages/ARCH_CLEAR_PAGE_EXTENT; i++) {
+		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SIZE,
+			    ARCH_CLEAR_PAGE_EXTENT);
+		cond_resched();
+	}
+
+	remaining = npages % ARCH_CLEAR_PAGE_EXTENT;
+
+	if (remaining)
+		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SHIFT,
+			    remaining);
+out:
+	cond_resched();
+}
+
+/*
+ * folio_zero_user - Zero a folio which will be mapped to userspace.
+ * @folio: The folio to zero.
+ * @addr_hint: The address accessed by the user or the base address.
+ *
+ * Uses architectural support for clear_pages() to zero page extents
+ * instead of clearing page-at-a-time.
+ *
+ * Clearing of small folios (< MAX_ORDER_NR_PAGES) is split in three parts:
+ * pages in the immediate locality of the faulting page, and its left, right
+ * regions; the local neighbourhood cleared last in order to keep cache
+ * lines of the target region hot.
+ *
+ * For larger folios we assume that there is no expectation of cache locality
+ * and just do a straight zero.
+ */
+void folio_zero_user(struct folio *folio, unsigned long addr_hint)
+{
+	unsigned long base_addr = ALIGN_DOWN(addr_hint, folio_size(folio));
+	const long fault_idx = (addr_hint - base_addr) / PAGE_SIZE;
+	const struct range pg = DEFINE_RANGE(0, folio_nr_pages(folio) - 1);
+	const int width = 2; /* number of pages cleared last on either side */
+	struct range r[3];
+	int i;
+
+	if (folio_nr_pages(folio) > MAX_ORDER_NR_PAGES) {
+		clear_pages_resched(page_address(folio_page(folio, 0)), folio_nr_pages(folio));
+		return;
+	}
+
+	/*
+	 * Faulting page and its immediate neighbourhood. Cleared at the end to
+	 * ensure it sticks around in the cache.
+	 */
+	r[2] = DEFINE_RANGE(clamp_t(s64, fault_idx - width, pg.start, pg.end),
+			    clamp_t(s64, fault_idx + width, pg.start, pg.end));
+
+	/* Region to the left of the fault */
+	r[1] = DEFINE_RANGE(pg.start,
+			    clamp_t(s64, r[2].start-1, pg.start-1, r[2].start));
+
+	/* Region to the right of the fault: always valid for the common fault_idx=0 case. */
+	r[0] = DEFINE_RANGE(clamp_t(s64, r[2].end+1, r[2].end, pg.end+1),
+			    pg.end);
+
+	for (i = 0; i <= 2; i++) {
+		int npages = range_len(&r[i]);
+
+		if (npages > 0)
+			clear_pages_resched(page_address(folio_page(folio, r[i].start)), npages);
+	}
+}
+#endif /* CONFIG_CLEAR_PAGE_EXTENT */
+
 static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
 				   unsigned long addr_hint,
 				   struct vm_area_struct *vma,
-- 
2.43.5


