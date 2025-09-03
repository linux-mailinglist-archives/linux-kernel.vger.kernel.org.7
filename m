Return-Path: <linux-kernel+bounces-798693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE06B42199
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDFD17469A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1C302CCD;
	Wed,  3 Sep 2025 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EFLW9LB3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MJvlW3jz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F6130498D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905996; cv=fail; b=OqdVCJm3keQ7OGwGzeQQFBAH9esFH3z14DIZaDChf3lE1VVsuWwuq3y7QXRxUYohK/5jnVCfurEu/2CpC2zIItwiJTHRuRGEDeStyXh84DgGX2YuYNyAo4yQegJZ/JXn1GV/bhAUXQ8fHTSoGSU21rrJ+6vgWq68BjLyongjHP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905996; c=relaxed/simple;
	bh=3+w/DPPjEcc3fxQj8dSPToK3lGF5vi5mLZw5yu8q+WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UCVL/J2IgtHZO57GJzmRlgZen5hB0taDefBHUZgNXBbstsAKSfV4Lj7iV5gHJc+KA3Hm9D9Tn/0S51HLzzByEGSc1+AFYA/he89hXyZpyeBRx4nTzgHdpc2Kj5kUyYXgIUZrbA/AFjjph3eYgH44DPRTG/lvfwB+hMhwo9AEPTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EFLW9LB3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MJvlW3jz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839NA7S009042;
	Wed, 3 Sep 2025 13:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3+w/DPPjEcc3fxQj8d
	SPToK3lGF5vi5mLZw5yu8q+WU=; b=EFLW9LB39Kd53dtBjlO2lk3hdO8tRzBwz7
	NWW6VlqqO/qN4kfwSGM9ubbPZZWObsxD6+3YmhJ6PqlEQ3aDyO+bQmetaUBGzAkD
	EvQYpUg7s9VSJ50iCTNCqbvAzuMF1cCqyMjDnyQRPs9OCmOLnDG9f8uAjvF2oitb
	Nm+zarVH5ukANXjGnLnjdGpXiOpb3tnb18sA7tfaI2aZ7IpzBt2h6Oj6jEC7rD0Y
	xG1cNlULmeLbw0rBs6E7I5MTBQjLG0yFGhhgViAvy7d66yIzNPpAalNIkPz00hHm
	hobIhJnpu9QGpD42Glq1hcUyA/3Ykf2Pol6f0RZWLXoE08KmHIVg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmneasc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 13:26:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583BafjB036219;
	Wed, 3 Sep 2025 13:26:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrab990-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 13:26:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI7YtSEspo+zYk6SSaDmRC0CCQK4SxDHuOvT/RTE8fv3h6N7fZFKNL4qFbylE2iWYPd5kX34mZVwG06IXnNSjvsTPhOAR1GdKmO7WWeCkCBVxuxWybZIL6mihjTB0PdcLpT6m/dNwunSLj14KSX2LnpKg7n1IJ0McqklHDotuzsaoCdXQvFJXAi2J2ozzIf+NY1eTK5yGgpo5+RIGf12aIjaWDDldtnodloisKjVJC8gXO6d5opZiGkgp4R2MW8EzYDx+Hnpziz6I8IooyISabJsi5/o8Cq9ku8G7pTg+w7t3wSPC8rCtwqhjepQ8tL9JYmRxHcYXIKdbmEMkputog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+w/DPPjEcc3fxQj8dSPToK3lGF5vi5mLZw5yu8q+WU=;
 b=PtU4okqlJgj3dKdQg/yVamGZsGth0JyHaheqIYTTKVDQGYIz43KbSfazSweAWkgVNGWpx/2gseDWBlryhHb6g2lLhg5ee8nKCL1u8JuRnFUD3/JvN0+6qIyqZZg00g1DcSHlIiiYdGtaFSJpE45A/IMso1wYV24HcZrXAF9i3a1UTwo4aPAwZAjrZxXbkR6hcZybsQh6an8rvZQr1njUGh49RxwQ1+TjBt8QqUDIRYmCJya1Gmlsb4NoKvtVWJkAftP8mhHNmkxy8Je/R5+Xlg1PHtPLPsqYkuY45PvWRkDnRoSAT6lZ/GYeAbGQ4lelws5IHxUH6RrctLtFcgEVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+w/DPPjEcc3fxQj8dSPToK3lGF5vi5mLZw5yu8q+WU=;
 b=MJvlW3jzPqvfhrvWALIch/mWzcK/qP8laAaaa1C51zsmJ1paQgB02TgsiZyaUL7gGfXnVn5Wl/XSrgDJ0Zc/Mr22U0zcUm4lIR00nmfN0ZO2eu0VseNtUQGRc3HdlbpTNgsmt3MT4uaIsBe6Vx/XPdv+vZ2Cpcxy+CvCQCt+Bjg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8103.namprd10.prod.outlook.com (2603:10b6:8:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 13:26:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 13:26:05 +0000
Date: Wed, 3 Sep 2025 14:26:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, kas@kernel.org,
        willy@infradead.org, hughd@google.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Drop all references of writable and SCAN_PAGE_RO
Message-ID: <e37bc789-cb53-4df5-8297-3be146d2b620@lucifer.local>
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903054635.19949-2-dev.jain@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903054635.19949-2-dev.jain@arm.com>
X-ClientProxiedBy: LO3P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: efbc4dcb-27aa-45bb-d9d4-08ddeaed6f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ydFtw/nNP46Aetpt189jhH8VlCgqBPGWL04rlNm207pRVRK6HAgjtfaK1sXt?=
 =?us-ascii?Q?tdO7Vz21FtZW17rs+4U03DzvCOVUBV4zboD4TWT9B8Lbk47ybJzckWy+QhdG?=
 =?us-ascii?Q?EzeVou5xwdkYMYHmAi19JPGQjzTEU6qerpzA4D5ejMDAY+4ELslhgZ2St1Uk?=
 =?us-ascii?Q?xy5i0Y2u56CN1aNsvedi9w2mlaMneykKKI115ARiOR4myD0mRmfg7jzMpoqV?=
 =?us-ascii?Q?72J/arlW8i5mK5eJOkZTVO+azsGGkpdY4vNt1m+jYI/RbmEAnxGMYSbF3unK?=
 =?us-ascii?Q?EIZgL3Bpi9RQ4n+gDCtIojzrcUs63Cw8PRfk+HTJlaAUw1a0QOvKs+c194aU?=
 =?us-ascii?Q?oEDAuUxkNHmbSBy3LtRRIc6myjoEjhrw9eFcKreAjAIfJ6NfxJaOqccMdUQK?=
 =?us-ascii?Q?/w8AQca/wRuj8dCnuOodogJX/EbBPTseENQxs6Q9wlsGG9qsOHLYL5+NYB+M?=
 =?us-ascii?Q?IdxHTqQJd7Y04RBgN7MiEgxWCqOnvLJe5+FsfkZ8WaId4pwZTL3KHFnSDCtB?=
 =?us-ascii?Q?E2Os1bVYngAMzhVP1Qxn7XAfr9bpr1zd+0Oeys2euC0gxq2irnCiy4NMp4vU?=
 =?us-ascii?Q?B0YwYiiULOhKdeEMrApvFo1fJNdV1H+GK6hsgvUh0kFunViCp6QFsli78dIz?=
 =?us-ascii?Q?jUOlP0mNDTgzYl4IV+++EMwazGWt2GbBEfsD9EMh7V9vm+VMWmbrfloWxodV?=
 =?us-ascii?Q?Tx86RW79Nk0HvAPDa1QHJifZprWeclAftPYLdaJXEENx3dt1stxS/tEFmrLd?=
 =?us-ascii?Q?G31CEevuA4lpxfEzyCvbuBbMu/P+/nJZTEmbLW6zbS29iM66pA9WWVlxGyRr?=
 =?us-ascii?Q?yl9m3soLCOpUpP6Mbloj5RB6lB8rL/zfU/yxY0s+WzRiYbD80apwgDYCzfZg?=
 =?us-ascii?Q?wSo5MSbKc84IESodgkdb60j/ognW+tg0tNNFSuyijz8mR+obuH3irwrLz3b0?=
 =?us-ascii?Q?mCPMHxrswNqJFI4AIojzw8Mj7Ayhcu+ghotyycVTK9bwbLa6uQYKWth6KrC8?=
 =?us-ascii?Q?4AcHbfDsbCepYqfUZ3xTJhsX+F1oQbKU64iY+8lqWL4Frlu/toYlqaH8fXly?=
 =?us-ascii?Q?IPQTB3ON2kFB5RGhtqXa1sU/Dhx1ON+UEt/VNjeZa7gv9bO/a4h7tKqu3cOb?=
 =?us-ascii?Q?z0muYn7gvDhT+Cj9N8JKMKIwOG8Y8GUFRFP6UHruMYMCiCUwGE/FjMicXLEG?=
 =?us-ascii?Q?kJb+Maodd9Vx3yFj1izn3vEVi1zRTTaXoC9IIdU8qxlDm8cMAKvVASxl2s4q?=
 =?us-ascii?Q?/hLcXI1/TkdIW4jQ+2tyHPp7a8Rchkxuc4Mi7NrMJAwx9CAUQouAfSk59w2Z?=
 =?us-ascii?Q?onjT5P/nUKt8AIxrFMlhjd1GSQXUjfRbg2pajqc8mhHlUAUb8DYao+k0KtcK?=
 =?us-ascii?Q?EijGXC0t028uTE49WfkyoM0hKYyfG4XR7XyKSZv/Q4kzKdOfI4brVbshahCG?=
 =?us-ascii?Q?ijvuJPn1MSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/1FbESZzII/LlU+VJZftPtweqNuFqUuvOaW73K0FTHeo8BC+5Frwf8qlPssp?=
 =?us-ascii?Q?PP5UKE3KV8VL6EDFfHD9tFjNi2UksM5kAR//3+slE2pHTGdD5hZx10DCVmL+?=
 =?us-ascii?Q?jXyzzFQ4J4pnVDLYiSbrNw8D9++bGGKp5u+he9RJyUGIf3yvFdxN2P+vQKdI?=
 =?us-ascii?Q?F3rRoIKuPf1xylJ3EKInKiqOq6gDV3W1ktdX2AXzTCqpa9nAnaw22KASGxsA?=
 =?us-ascii?Q?BAoVi3wvtoXkj8DeZUbXmO/fdGPC5STbnJCctNSM6jYloVbOO2TtiVUpMJK5?=
 =?us-ascii?Q?nkSt9ivK53q0KmwH6MkH3vYdnL304q3KfFitC1+WcqoLv9I4QCLsxNYvDRDl?=
 =?us-ascii?Q?5tZRimXCUgZKdJxRySKnIrrVYWCMFYVjWeqrcI3deO6ubjCnQb6oaUptMiSJ?=
 =?us-ascii?Q?hp7x0LX0GsGDXFEGU5oxnoQNGUB73nBZ0tSsU/J7LemjQqRLCkq8nKvH4X3L?=
 =?us-ascii?Q?hPcHulGRtdhfe+rRPwyzH9Xo3+HdFWlfa0JA6ZX+FBzQPahX56JN/XMwjlxE?=
 =?us-ascii?Q?ZEF1DMfLd3W3cFFRWUj/mCgSOJGl5lHP0gU3c5i7gGkAFPC654i5s35nYqG/?=
 =?us-ascii?Q?CV3T7r+GCEAuewWo5NC0n0d/6uFRyPtMtucJ7UvU8HFGrXV7sH8IGDZRPGOi?=
 =?us-ascii?Q?oGFr4LOVmMYyX0S8xhFj0jZox9kKkBlBdITSI+FItE3/+OX3GcW96iOLsSIl?=
 =?us-ascii?Q?nUVfDq3tJuvLUjpLs9sh3aYf7uh2zrK2aTAAu1k9udT96cEwwZybEZm7VVo2?=
 =?us-ascii?Q?BtyNe8Ap0B90EUlcBDOTZHmnGf1AiIdlDoCrpMRciVBNK2aisXQIZCFbYtvr?=
 =?us-ascii?Q?84e79kuO8CHAoRTERmLC2jQRPM/Iw48pgqmiTqgLqu39kiBd6WAGdXQFej66?=
 =?us-ascii?Q?9Sb3mTgVmNtXnfi7tW8ki2tO6FXATCRZOyJlpy9wuMVEqFY7C8BOCDxmGprq?=
 =?us-ascii?Q?+rzPf4IVFfTgTYGC/HEsYXacQEL02B8OMVs/80ol5JNGqFmwTE3A/Z+8eOXN?=
 =?us-ascii?Q?a9r3khupAPCbiWJ9YzmdgBPAOEnJaYsic/BkFq84MIaz7/lmh5tgqn/3ULHO?=
 =?us-ascii?Q?Nm14KlRl/+OVkDhLwQX40GA+oQ+bo10SOg4hw+FK2THdsGgWSg4Xij4noREk?=
 =?us-ascii?Q?Ps0onvvGI1qk9HKIsgQ8378BJN2Smx+0iIVOylIX4piqWnTBHhuRdSCIjVZF?=
 =?us-ascii?Q?MOt9zsLbW4eePhYiTVDc3iUTalqnOK9L4l2wkvi27fdcY4IrVxddmNjQiqF2?=
 =?us-ascii?Q?Sbr/oloyUUBuArFy4oPXc/wtDh9CYPyQQsVwV8HQwG+DqTYTLGTFtrha5ej0?=
 =?us-ascii?Q?bjI6bfEFjH9u8L33wsWYsIe83ybS2Pg6xqYBZi7CR+2HGKasQ9S0iJw/l5OI?=
 =?us-ascii?Q?wLUUDwrjD5fTpbvsH72XB4ylxoOkpdd2qkYR5RGKVRKAWcD2CRvN39w9UazR?=
 =?us-ascii?Q?i8ytxL6XXznvOvoNpIbnCCOlX4uCwqxCTh2/Z2/Mn2hPMwpnjyNQUWO/W479?=
 =?us-ascii?Q?MIwm2HmBmIkv7HJdWzEzrPYX+uumhhLcF444XxFpPPpIvLmRp6foeYDyvp0t?=
 =?us-ascii?Q?1ZIjkz78GtrQO25N2TfPZnG/HF+5Kf0e7GKmgWmdTcUk4BLnzk6IuQY8h/UG?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l4itdrQiKUyinqovM/PEwlLFWftwhaCW5amsXv29DF5ggfW5rkIVJMkbMk/p5x3jdtLLGPQppIdZ1XEThPzmsz6PFUGp8Jj+3TY8w6HMefo6rc1H9EOjpg06iDqV6P4ARFqiCiUMO70ZHo5KCIvHr64eN+1gTuQf97DeoXiMS67oAHjzLoP61QtfWMXDPtv3sQ6h4J0iWDmON2+s9rQ7PXgaMj236xi46WNPziXKCVIl/uW6aU/PU/Mi1884NzxgaP9S92PMYTv9aoqKdtg9iCG99lmAOTooj+Jj0ZhQh2zQhSEXN25vax19m5zYJqjjl1TEMWIIeTwZ0F7qIVdh8ZzlCFrhLjpNLYlli3IMFczyQjIxJJ6Ud2C+dn/blP8CNZgHi+hCH2WMfQWPJTsxZvd9xZnKFLNEbgug4Wo1x0SQqflnuKIWFb3Nb5yAWlFsSAm/pbgWHJYujbGH/hXiMPeTDQKddnWUdxG+a49/QfAhDJSMui/KEnpbcf9FwWRZ9cKK0J2TXbOk9NpAPx73H1nw9nqqVcwrvesM6yJ5YuRlRaqco9LRn+mvEwDgahOgsm+w6bjjVMrAU23tR/SW0Y72LN5s58dHb+ddo5OKrmo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbc4dcb-27aa-45bb-d9d4-08ddeaed6f9b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:26:05.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rxkwg164O6VAA4b1pFVPoyDoD/z73fFqj2g82pgqQIBfZN5t1vlenOiz7c09jglJIjaOMv+zoFFEMkIxGDenfc7UWbs9myh5DPlhIzCy1Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=829 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030135
X-Proofpoint-GUID: k4OzBQCGpmn33l4B0oLw6G07hjiFgrAN
X-Proofpoint-ORIG-GUID: k4OzBQCGpmn33l4B0oLw6G07hjiFgrAN
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b841f0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=R9vLcmxkAU607GsSxoEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX1WmyMVqGBe6d
 vN1tjdemG8o3SluwlA0dq5mYx/DR3jAxiT8wg3xp3zW8s2z2fspPHnZluKF94zimeRk9Bn+mVXJ
 88ye53WfwuPFEWnZnWeJAcGn4b2/Ub1MJhSBIwcDAzjx5+KHWxJ5rw8a96amHH35pAJ4f8vuGSJ
 EQeYwv6RQzkLoGdY/iBUrnsk5rrjjbqGt6Mb/toPvW+d/7h2pbu1dTQBT4eLlSsgRSVdw8LXyFb
 IdNIn/+HZRIUZ7lPtLoEku8xO1evIdkVqDBaxsXmtuVsWWD9TtuJMVFtflBCZn754tKnXNokmYN
 +buvakUu+nqQ94ZHy+oDru27mcol1ISrVEN4TLYDBsplmVgky2/GyAHr+GFSTPCDN/LdoIRET8M
 iNdc1Lgs

I know it's a small thing, and subjective, but really would prefer a cover
letter to a 2/2 replying to a 1/2 :P

But others may disagree, just a small trivial plea :>)

Cheers, Lorenzo

