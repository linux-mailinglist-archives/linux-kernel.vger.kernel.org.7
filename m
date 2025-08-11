Return-Path: <linux-kernel+bounces-762574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF10B2088E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D8C42693F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C385E1E8320;
	Mon, 11 Aug 2025 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KA6ik3D9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yfyZ5vbr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C0F9C1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914524; cv=fail; b=Bwx/Wjnjo2pe49PcsWC21r2zHSJ1QW2K9XpHeyG5/JsMcvqErHCY1AgGUzkVjGsUnsrvgB5MSVLbLWvwxkIDza8i/d5V03Kz+7a14dYCd4Rb7ESFO36WaJD6K+1nqA/Oqqby8PtK0ExIkOHA4TvSu1j7tPg+81fCht2ydnmYNTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914524; c=relaxed/simple;
	bh=wuUuSB1ASkap9bTNeaLWf+HvOnfBdGAp3Pf7TQkY1wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IYkO2kuaJ+n4BOyP/FQ1ewYml2baDXKsbOnesa8O/O2crMrvZ35cDTJfqqaBCu0OXQdEBHjfQR+vBuSuKhHDHiCwAXLMkgMEY1saBDbtgY0fe4590Z/tMoEFwWTH8RJQTSe28Ore2xbQvGMXbKOKVIvglM2AJSvGraICzXL1rSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KA6ik3D9; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yfyZ5vbr reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uAJ4023535;
	Mon, 11 Aug 2025 12:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=U9S0jDknHR2g3q2/wT2idkr0TJWtCaSgv18k2B1zbk8=; b=
	KA6ik3D9Me+H1uiDeFdKM/1/GnBBd7SfOzyY1E9Q/shV9FNcOqWF4I7m8sFY8V7s
	NwqRj9w7KKKNrZOhSRrxButu2dcakAIJv08Oi3jC7nsHqt3OeD90mCQ3+TVgiSXP
	ALn6XvPa3UtIP6am6i/MwmYhGpzWhxy6VQbqMXLA4imqcSQ92BjfYSUldVq9DlHk
	adiROgv7FIus2jmQ/EOAixWgnpUZiDXiYId5HTTlgtifVciNyA65i5/L8mbxsUPQ
	HzmN5ayhtN58glP+Xl2jesKlYMtWo2AcGYFcOoLYR0a/YPuOKaRPLCQyfQz0dz0S
	MvO0jq+FYKU9XIo1gQ35Rw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwt8qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:14:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BB1MXq030104;
	Mon, 11 Aug 2025 12:14:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8jafu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZR1vPFJwm/DTI2Pd8vPm94D+qcpccqdZTbFo/fbH9lklmvzMrFYYaer28/S4fsdI7YLCwF3xl27cA8UAh8rdHUbGsWOKs8WrtO1d8MglPfwTR3d2N0B6CNcQK3JV/HTd+i/mN/mHKdcVjVmLEKG7McsyDPWuln72IBnX1t7mWWjInuNqTwsZYpygLuis6jY5IMBPFAtuZdgOs4jRSJAhJnj1JVNUBcFD2Ksm/8GJordMUOfzl6q3bMiSyZqTeIzucPg9O+ykBVT9dz1ggHGXEpmF/XCU6ycJ7zgEjD2kz4wXYoZA4rk/WeQDX27IIGJO51cNr/bHF+8+SiWhEOpJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jllzJc/gO48I98szsWB28TJ7LPZ0duY6DoCerd6OXHA=;
 b=WjzxR5x/KsuliR10PjILxSwUVivVtE/YdxMjD+YeyxC4GMpTPIGOxylYpjHAZPvTQ1Jmyt/z8KdcAi6PAI/rFHP8F3oc00rW5AUnmbFdZ6kE3jqXS6uSkvprNJMbFUlVxooQD8didCUvn+KFuoHxRCRUYLAWfjyjHeA1opYPlGBHZFsZSpIHhsFl/B38nhPOsSwGlT8S2/MrVt9zZARhgSv/+1KPhnwVorpIvFy8ySjhoLcErfrmNGc7W/U+GAqvBmx4o+92chlDvwtvgL/O2PHYKA7i7H8pwBJrmIrCbTre8F0KLguYqr5gEDLK0zBj+qkUvC/eA031PuvhdFN6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jllzJc/gO48I98szsWB28TJ7LPZ0duY6DoCerd6OXHA=;
 b=yfyZ5vbrpa2fzvk9OnPhktUZERHgh+k7Af6sjiNqyDpMRbRFLgrYRND9rc9HFzeT+2x0Q7a7XBA+J9wIQNdIvQauTC/e+XZjk6kp4ToAL7WJrgU4+QwyT+bDaSaOVjxUO1tjFFB+h9bZOJbbpg7wbs1ul82GwbflbriLJBCfayU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6155.namprd10.prod.outlook.com (2603:10b6:510:1f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:14:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:14:35 +0000
Date: Mon, 11 Aug 2025 13:14:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff
 path
Message-ID: <fec5ad61-7caf-4076-ba81-7b454ec7018d@lucifer.local>
References: <20250808092156.1918973-1-quic_charante@quicinc.com>
 <dedf7436-9afa-47f6-b676-88f2dd8b638b@redhat.com>
 <f008107a-2741-476d-9e32-ae9fc0f81838@redhat.com>
 <29e080fd-5f9a-4760-876a-a6ccef33129f@quicinc.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29e080fd-5f9a-4760-876a-a6ccef33129f@quicinc.com>
X-ClientProxiedBy: MM0P280CA0050.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::9)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f0c320-8ef1-4635-a986-08ddd8d0a29d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?qb8t5YNg+ROSiO74+EKtgN4yKYVwvbvmtW0RbSvU1IUF4aBTE7ySFQcN2C?=
 =?iso-8859-1?Q?rNQ4LYHs1BNaKiTqA8Xgy88ccnRFBazQkHNZ23UiRrwGB3RUXTsqSfD0Dr?=
 =?iso-8859-1?Q?1m/tQHwKrqa1V+/eKXCpTCIWQLTbS2Im8/H1xbBUpEndJHvxYgggD1FKg4?=
 =?iso-8859-1?Q?083OC1SkKCJyoMmDe6rqQJEC9G61qfSt/IslRnDdxPvFWwBr+fzUlhHcS7?=
 =?iso-8859-1?Q?Q3323UnaGSyDjDwaT1LOZ2MEqBNyFspmAV8wxV15rFvOHUZ7qeVEiY0Rgn?=
 =?iso-8859-1?Q?R7RQCt9MGSx6E4uyXkY14eOkn3tPcEZCzgq8Tqh5J+6GLYF2SqpaVilseF?=
 =?iso-8859-1?Q?HVFSYNwuIh/TZs1FoE/JrExK5rM+l8eYR4HwucaumnMfdakBEicJBs4Afh?=
 =?iso-8859-1?Q?jbhP4v8MwIAwiiyUNMAZ5Neo60yemTbMHSx5n/fKvhVrophZZKubR5o1mp?=
 =?iso-8859-1?Q?9hjUKgfjiaEgr19MtCHTLm+47/eK5GIm9V3IuM2h4NzT/7Q+47oNYT7+Fo?=
 =?iso-8859-1?Q?4mdAf8ABGA4y1d7j8RAsY4teAOUxSYQFNla5NScWeIrZoFa+JCg5R4Ba/W?=
 =?iso-8859-1?Q?pk8j3VKeZbEUNNl+U9HeY/LPY4xyuYWdH/loFkJJ0TbL9AWT/rm4CwzuDC?=
 =?iso-8859-1?Q?NtP++3ihznx6CeEWqgz6yvP1o/+lpDoz7LGpEbbCEn6JP9T/acnqgJaWLP?=
 =?iso-8859-1?Q?gVaSZXJ4L0MRx317eVyJ1/CABkg2nRO9PQhgN2dRge6CfibxT2cSzaskQS?=
 =?iso-8859-1?Q?vz6Ypt1bQk8rk25AnQWxa5L6pvK1o+wMBRFUhD2/OVYGq4Ajp0d9wBk9oO?=
 =?iso-8859-1?Q?q9vAgs7F5CmyaIfjYVGWEf7tOe/LiALf0BKHkZmhk9AeCSxo3j5qziR2AV?=
 =?iso-8859-1?Q?1gF3WhR5SSyy4KDQ6Pec4zk/qJW3YOKmc3fwQEpv4VjBL4NBhMgw9rAB8b?=
 =?iso-8859-1?Q?KkwEtwOOekizPq4wACzEXNzulOP+YJW5zDiUbPjYTiqutKZGybYVEGlazL?=
 =?iso-8859-1?Q?IRl6QLtURtU3nqDd4BiKdrXC16Ev+V08itLj/Pnr10afeo66JBFdwYvARQ?=
 =?iso-8859-1?Q?EvSXuxe0yw5QCXGI4bBhyZcUrHZwD9IjyeEdzXfEmY+pjnfy2eZsWNKhAQ?=
 =?iso-8859-1?Q?t9fQYkqsevFN3sbZtUd/wvcY1olzlLiAGJTCLfxVR6vXArD4UQv0BQILU5?=
 =?iso-8859-1?Q?uXLcRhO3bDvGC0zfy8PRw9b2ckyt2PxR2kjXA4pXpn1u1BrtxK7Z47kQmI?=
 =?iso-8859-1?Q?n90B5VjoW1EGmwZHsuLhf4mK+ebXUzhNOsdcpvurN+oVQwI7j0YEE32u4i?=
 =?iso-8859-1?Q?CzqAk9TaG76i2Xi8pfD7Ln/Optrt0MzSSmkK/wcAHBoD8zJXuHIbDI0h/M?=
 =?iso-8859-1?Q?XgpOcO4XfImY0CjaUAvdcb0DSCsiAGYFlUbRCemKPHyF3stEiGIU37dwZa?=
 =?iso-8859-1?Q?2dCylnn4lIHflGMfPbHZWERtbd6Mxeuih8q9TkWUms0janeYlJd4Lx0VJt?=
 =?iso-8859-1?Q?o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?wo5hm7QweseZGXS99ATkvvEDeffY38uQuh8NygbTEb4XRsMv22cuQqTPBM?=
 =?iso-8859-1?Q?shUuVKyQaXKPZk/r3yvzlKg09v/R7GZ84dhqwjrGhuh0vjmSGOM+lit1/T?=
 =?iso-8859-1?Q?jUnPs5wRpA6e4rNwhQGToYialcK8sYANE6LiMVX5EtY35qkPbEYm/bCSJl?=
 =?iso-8859-1?Q?bLkmxCMh+uvKLc6tudtiUw2JAyHxn9kx1zgKNGlStGShLvhIg7wkQyVQcP?=
 =?iso-8859-1?Q?mPkK7ZAlzKas63l/22gVYctF9s474MqDhoMCNgCW/f4JriA2DZkV3VJGjA?=
 =?iso-8859-1?Q?jyZv7YWRi08ecuuNOcFpsCS/4LJVoltfJp8KdKKneWZnhUSK43oTMu1slP?=
 =?iso-8859-1?Q?YkbDqUumgBurpHbCqr/SY0mDxJ8WyRZXwh0G6MnilgG3nxS5QajCEjB5EK?=
 =?iso-8859-1?Q?2kIWDz0EJ9CYsP4HRqqMgUAXxrZWgw9m26Q2pF/Bz1yrgxMXN/mTHJccvr?=
 =?iso-8859-1?Q?2uxglbrBDVo1Hi9ympP0OO6hoSb1wBdDnjWPXzYla5TeOER3DFMWdPTjvk?=
 =?iso-8859-1?Q?mZ4kYS/W3BB/w8AYAJmCPjH52CKcV73flyqq2A+rBVG1ni+l7Edqn0MXLu?=
 =?iso-8859-1?Q?8wdlaDUfVqaUHNt3X4FONc8n1Fnr71U49OZ1grI4KJcMfBtT3SS1dDTzbs?=
 =?iso-8859-1?Q?r55PvoGUbtz8U0iO8kkYFO6q4I+uUC7oKsUBqJj7PnwaOo/ckVoxEc+/F2?=
 =?iso-8859-1?Q?WFe0FC6obfnMz8V50tQnqUeLr9oCuE1z7P+4zUw82Lds8O44AcxjVrOUPw?=
 =?iso-8859-1?Q?B4Yv9bwSdc/XajIApzi/1RaE5cXKDONDc3h53VXj3gtYSFx3Wa/x58QOVf?=
 =?iso-8859-1?Q?5xmH3NnN6U5kuNDErG7xzv9Fga0ojFBzOq7oNfBlTRvxzzkSCkh6cq8ygT?=
 =?iso-8859-1?Q?cIxmtibi2jFs21CKaagR8X1ZChTv++nIy2P9fPXH9k0xZ/6b5KcvTAfAMb?=
 =?iso-8859-1?Q?S5EPJvoNb3qt2oEe9VWh23ePPz26Nh0vz3/3Lj3rYQL69DM2JwRvhVU1U2?=
 =?iso-8859-1?Q?7lyKX2w4paHdqvLgazMdii3sayF+arxxiO9psORW6Gyf/5BZehKGUPEhGM?=
 =?iso-8859-1?Q?MZts8XvmnRZq9ZeFiTxFCo+IovzT59kxwdjRBjy+w0RTjrqHDDkZBySh4p?=
 =?iso-8859-1?Q?zGGBWObhv8d/lqH3adU6r7PttMC/u7eerAvuT4QG0W7MxsT80bj76aIsD1?=
 =?iso-8859-1?Q?jW2WsQbsN4IbfSTj9BgmdtC0TcafvQZvedOTOb2+N3QHiLDj37SWO0rqfV?=
 =?iso-8859-1?Q?H+tXwoWiCCFZmtSnzsq/3TJ5fJkq77+JHjnG3XjeJfnyq+/b/AD5QNz9uV?=
 =?iso-8859-1?Q?qCl0YxZaQtsHHmLcTy8w8RLraXQOeH7TMNKmVkcNCR4XxSKxAZwy2gCGxz?=
 =?iso-8859-1?Q?sFUBPeWw32wpDnObtVcd4fGOuwtKX7tND8UCWF8awthNMxNwyFvOMIqecN?=
 =?iso-8859-1?Q?lswonD7t7TceEdwKckpatUIe2ZlxYtysJR/WrzWt5s4Hc9+QKInJnD4O2a?=
 =?iso-8859-1?Q?BaWcj197ZSNcr+R3Rf+cMI5eYWqGe9WUxBowRSHS0eaeFRJ8XrZGEKjZnc?=
 =?iso-8859-1?Q?zfP+GFuxA8HE5Q1/5Sbx7HXvHf1KazZ5T9y7qoeqlGaAqFXfzryqAaEVW6?=
 =?iso-8859-1?Q?08LydVTRCakQuXgJp4BMM+6Z5Vcm0n0Pc5hxQAlYdE/KySTgkcvsu5Pg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yd8/RbPO22QlFyPe15hl1lYmtnvJEf0al2ABOA8QJzGn7yFQIcIdznBonPVXr6znOinJQ4gI0tjmDAZ2qrISUHDKC8FAozdZ3ChdpGbo3YIyMvu2tXzvTgXdwRWlaRaIFcui7XqLz5i3/GsEXu0oZN9mjZiMA9ySd2Lc8QH78ud6uMRHKvZYS4nwgTXLGnJFY/uXjo77ei3GnpiTu6CN143LMd97725GdCn25DVN72IquhyAmjtqn0T70Tzy2jKZgjkjYrXVtqHkgnUcrG5uIfEp7q2zFkMYYFuJ/twzkH/0BY9lR+55ZjdZ2wMcmv0UW4vN02ir58i5FQIFvaB9fpwjCLLm0TNOTkTl9fVxqOj3R8MSFCfd5wFrJiR7ayXHvkWcZb1rvAF4swNMhWhUJnFOn7IAKSVizsNgtnTYZNJtjVWrzSMuRdXREBOf9V0yIjkkTK4GJ1RCe13YnWACy2QQKcztT8Kkoi01O7gEkf5z2C7uGkzLUkyqgZSXmaU40A15FoHi/NXnZbqg3DGKShBfdDuqmkKmGS9Es7hZvD0r0lnsgMqLcPeGH0JRaawCoScxqoXNdcjp4QpqVZSYWtM4gH4QESxk565c7XtxaZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f0c320-8ef1-4635-a986-08ddd8d0a29d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:14:35.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH8Ovp+NWqJYIm8smTbozekLH2VPmli/kFjrSHmf1V1HvV2CPjk860r8/slltP5nGPGBVlnKr0WVBuaIRNUOmd5b7/9fuH/29P2mP4Dz10c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110080
X-Proofpoint-GUID: x_wGkJyIsL0EVNIXLSffj-9vo1ICmQB8
X-Proofpoint-ORIG-GUID: x_wGkJyIsL0EVNIXLSffj-9vo1ICmQB8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4MCBTYWx0ZWRfX60BWJQBogkrg
 sXoa5kY2P7opLjydDZLTXZ2BC3xIaWEzf2ZZ0gJLVkunjO1Gz38Wy5mPOuDazbFyukSG+zB6GOa
 YvV776MY9+XTtEVsrj/5oMz0vsDmQBfPPBlqNSK/4AGQz+eKMDTC67htLiZJ3kMXMZ58e1Al3Di
 tRTcvDaNsEhzjhJd+okqMYvLhRUSGi0crQM/6PkCayHk+CoxKsW9b9xMIk1q08afXJV9UgdcKw2
 FdtsS2MVSruu2fHrSbq/eufDVb04qpTG1RwvHhbTdiaQK5zFzPLQrirNsNwJBzPkwkPJXSOOXye
 k5SkCVbqzjElIhxO1jHPQwRZhif13X02EURoH6zfDW29LLQFJsj9xagRnM7BxKTMhAFEMrTXoKV
 +ZwcO3HuHMWkL/xt6KiNIsy5pDXKbfknxb1TwvEWdMxQ5J9Vztwfe0mnQm3JRyRnM11igSiR
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=6899deb5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8
 a=GTvNZ9e-H4pwXEqbZT8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10

On Mon, Aug 11, 2025 at 03:13:14PM +0530, Charan Teja Kalla wrote:
> Thanks David, for the reply!!
> On 8/8/2025 5:34 PM, David Hildenbrand wrote:
> >>         if (mpnt) {
> >>             mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
> >>             mas_store(&vmi.mas, XA_ZERO_ENTRY);
> >>             /* Avoid OOM iterating a broken tree */
> >>             set_bit(MMF_OOM_SKIP, &mm->flags);
> >>         }
> >>         /*
> >>          * The mm_struct is going to exit, but the locks will be dropped
> >>          * first.  Set the mm_struct as unstable is advisable as it is
> >>          * not fully initialised.
> >>          */
> >>         set_bit(MMF_UNSTABLE, &mm->flags);
> >>     }
> >>
> >> Shouldn't we just remove anything from the tree here that was not copied
> >> immediately?
> >
> > Another fix would be to just check MMF_UNSTABLE in unuse_mm(). But
> > having these MMF_UNSTABLE checks all over the place feels a bit like
> > whack-a-mole.
> >
> Seems MMF_UNSTABLE is the expectation per the commit,
> 64c37e134b12("kernel: be more careful about dup_mmap() failures and
> uprobe registering"). Excerpt(s) from the commit message:

This really is whack-a-mole yeah.

>
> This patch sets the MMF_OOM_SKIP to avoid the iteration of the vmas on
> the oom side (even though this is extremely unlikely to be selected as
> an oom victim in the race window), and __sets MMF_UNSTABLE to avoid
> other potential users from using a partially initialised mm_struct.
>

But... maybe this is better for the _hotfix_ version as a nicer way of
doing this.

> When registering vmas for uprobe, skip the vmas in an mm that is marked
> unstable.  Modifying a vma in an unstable mm may cause issues if the mm
> isn't fully initialised.__
>
> > Is there anything preventing us from just leaving a proper tree that
> > reflects reality in place before we drop the write lock?
>
> When you mean proper tree, is this about the your previous question? --
> Shouldn't we just remove anything from the tree here that was not copied
> immediately?

Commit d24062914837 (" fork: use __mt_dup() to duplicate maple tree in
dup_mmap()") did this for efficiency, so it'd be a regression to do this.

See
https://lore.kernel.org/linux-mm/20231016032226.59199-1-zhangpeng.00@bytedance.com/

>
> Anyway, would request Liam/Lorenzo to comment on this.

Hi! :)

Really want Liam's input on this too, as he looked at this previously and
was, I believe, at least potentially going to take a look around this whole
logic.

Fork is sadly an area in which things become horrible quick...

Cheers, Lorenzo

