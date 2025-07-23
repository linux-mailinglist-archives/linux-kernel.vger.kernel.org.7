Return-Path: <linux-kernel+bounces-741855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CBFB0E9DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9784E5D95
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0754A219319;
	Wed, 23 Jul 2025 04:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fdeM1G9K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oaLBe8Q1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C55223
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753246445; cv=fail; b=B6FzhglpP05TSs1/k1GKKGYc4nJTBzfBoupRJ6kQxHGYwazW/y6xY0YSZZJr+BaiYsygVe5RbRlXQFkTyMZNyidpdsYLXyGSH1leso6clu/NtXyk/nS3PHMBwzPorsMK7BL0fLAajujzmtq95BDuVKCYB00RvIofcHtYwhG4Dww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753246445; c=relaxed/simple;
	bh=UKLJ+/hZtEHoBlbeWUg/lta/TkIgawBybqlb55sz3Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QBUNzRfZEYwe9ClxCpI7BOUJDG+KoPzHNWtWnMMv1aJ33Ex7BHv6e04P8y9CELE1HH0kVnQKuktqhWwL52L/y8YwMTOKoY67UivpunWhAdSkt7UfFpHZH8Q6zID8U/9OGh2QMW6CAgtUkB0N9Cg2jD4oZGMGglnv9oYVGQksVrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fdeM1G9K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oaLBe8Q1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMQiq9030624;
	Wed, 23 Jul 2025 04:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=h7Jd/JfGgI2oHckDWV
	cvYjlmFrn0s6QDC2mixFtDp/8=; b=fdeM1G9KmfexxSA1E1/uumrNuxBoKTkNEd
	ZyMy0VyUVQXaAGI1tlbBze7QUUw0PLZbbWQ4cROT5VyzLCKlRntq814njvbS0lCu
	ZDfE5i31upVbKDME4nZTR5QYdkvf7Nqe+hFtnP3Lq9Wv++H5T7eeoSjcukn77zDg
	ufnzyEJGseYfIx9sGf4VEJocmCK6EvnbqSdzRkTC67BIeFoLBkiKm0cvNcRVq5wI
	xhNvu8wdLno0mdTVIvivPBFYg7jHSkBY0LkJOsya731sVQlVKME5otRgcO0C1Ijk
	+V7zaeFtuq5jHMCMmXbJNco1pbzl+X4MZDQLpM1R4/ZW+okd5bmA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2enhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 04:53:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56N3RlYK005737;
	Wed, 23 Jul 2025 04:53:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801ta4rnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 04:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb/Zv4JfRfyPVKchV0Ax4ZwQSfGf2a1gD7S4CF1s37rVcceMNrtSZO6uuE5noIgPQ3DdiiRRFUbXmX6p2fCs9l7Wt4bFTTk+ZpF2W8dk2XzQTzz7zZaDabqtSp4+9cy+A9e4GCGC46rvHKpZcTatr1fbXkmM3wbapuW6rYluoSK7+xgU7VD3lQsNfbc8mafgwXCbypBvEdM2DENx/wOYMoRpjIBS4INDvYXYt7AbmwyYrbeVZ37l1rRIk6DkV+yv2EpCPzRpWbecjGPRlZep55/eBJagFeekK1IgsWgMVRefBxfi3oGtjut1ss1Dr5phjsW8o6Quduc2Iu+fVMRQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7Jd/JfGgI2oHckDWVcvYjlmFrn0s6QDC2mixFtDp/8=;
 b=pRwos5Ru/Wu0KFUIAUQQaWaIzT+loGp4e3ZPy27mXceAStoNBM3yL9+Y+/aIS0SdHFpvvZRCTnDop0s1pMW2ojXmxk+7HOFYKE1XdMLPwH8a65ruvSxEUgdNjBXunbYyFQ2bkxMtJbmqgy2lruLJaOligOVDSbdhQa6jSve4kMx2cmNxlVwUEYlK232aTk4l7cTeH7QtT47CNPgNMBCsPi6NtQhys8GPXZdEp7+r1Xo9MHnyZ+ONLzamAw0WeC9ZeLwIBXb3Gg7R6QGdOtmYL2x8KUqHbjQVCnRHgkN0N+ueOZg4BpLnhE9UMkFcpBdEIlgbt1eGpVtePzRWa2B4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Jd/JfGgI2oHckDWVcvYjlmFrn0s6QDC2mixFtDp/8=;
 b=oaLBe8Q1hhk6z8b7hh5mfgnPf0+YfV8PlrxZQUDukXiGTL6+XkNk7kUK77SC7BdSKazEZ9d0bOqEbFK1NQ3ewyfILZ2y/vWjKOJLR94VAZcyuddJmPDUczdHoP5NAv2yEivCWJ7kcAWp6bEEARuEqjoqUnuCS9E6j/pIiR25YK4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8030.namprd10.prod.outlook.com (2603:10b6:8:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 04:53:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 04:53:28 +0000
Date: Wed, 23 Jul 2025 05:53:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add missing mm_slot.h file THP section
Message-ID: <685747e2-a8cb-4620-a0c0-5cd9048d69b8@lucifer.local>
References: <20250722171904.142306-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722171904.142306-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0326.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4222a1-f42f-4c29-6340-08ddc9a4ddb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xb7UoCXicBJMRlnQPXLFQQQvxCXKW58lF/eUAH9wOBK4KxVJKWXwwvyaxN/Z?=
 =?us-ascii?Q?/wqVeH7z1ivdq7cFUap9ImnXhyKLD3UZcetFkZDEgHuxi4nk7L+eYDZPI0OX?=
 =?us-ascii?Q?JLpMI4dGe91jm7wfqmOQKMb9gCviQF+vWDZvAnBS/WcfxEGWL8QgwhA4Unan?=
 =?us-ascii?Q?/11sT9ICcA3cYEREJUj6ngzoxX+7cZtlol3sbxDDWgYSNXQkC0Mq+FzR0wPg?=
 =?us-ascii?Q?/VA0DFMffaFUSClmiTtxmERyW98Tfme/eMluhV481oxDOkNmm0f4mofNlTQi?=
 =?us-ascii?Q?RxyyaPtvBAI8uyGSTk4d+ZYPUyq6Uk65mWBBhKA7dJ3ZOzBpWOLuwxmggVzs?=
 =?us-ascii?Q?LrQxnGBSmiaIJS8F/cmQAnF0YLM8ZWLprNDZwUAH+aJDaNexclBBhlI3MmO/?=
 =?us-ascii?Q?5j5MNwQRZoNWBODsfarXwxNhwbRVsG51qsHFJeS4rLHN5hPg59zmkmS/iEis?=
 =?us-ascii?Q?t3sRflyQ4Ks7/XME34O3BdKyr6DlWAy6EPTxP14zOtOJ9okoMH23afJkA9UC?=
 =?us-ascii?Q?5DSx1ubjD5Sp68F7nYvrJ7yc1m1QH2bNJ3uyCbghZvCJ2FyojeDoBEsxfpxP?=
 =?us-ascii?Q?x4sx2Ja6xFoVUujfd4fHNb20bnyVZOI1IDzSt00NaeT1UDZRC+f9fU3k5OST?=
 =?us-ascii?Q?6KlZt4uZVaW/7CRZAnKECJ1liYwXd4qJS//uf9U21W6Q9NCEyyGwBs33cx7/?=
 =?us-ascii?Q?B9xfwYOon83TXPe05R8sWBUaXFE2e+ufBZI/isqiA5aaR4OYWwXTd9cx2xXO?=
 =?us-ascii?Q?0MBz7JRQ47nlDr/q+9Aaa1ZB8/i5G/G29TJxTfibklMQOKOjYoQ/rj00cMnD?=
 =?us-ascii?Q?VCuUIro6vSJ/fAaGpH038Etc4v0qfAlZaQ9G+lLFURI2ELPd9pUotCBWXVHE?=
 =?us-ascii?Q?sdKpd1x+NwLZAN7hM8bIMsTEty8zVmewHHAvF+3mzXdxdfBl545NZPucxGtN?=
 =?us-ascii?Q?jsEUw7EbGunhvbeqJtR4ipGIWRtFd4ahlq3jd5ml7JHG13X0HhqmU+byoAm+?=
 =?us-ascii?Q?BJHLEiz8cs/4w4fqm/+HZfHZzC3UcRHclnm+PvKSMV9P4buIcR1Y61gzEfJF?=
 =?us-ascii?Q?36Ice23dGBsR8YjtIZCW1qd1V+o6YFRaicvglBn9oqD7BBY5Dho+tG3kRnN/?=
 =?us-ascii?Q?JpWq7xjbg5c/eKzzuMbdK4i0zOKMaD7oft+RsZQYG3LmIkivFSKAg67YA13a?=
 =?us-ascii?Q?G3QJWKaxbqawKL8fXl52NOXO6ukDUaSJkpfewbqcTi+ZMESygHjSue//ccA8?=
 =?us-ascii?Q?kvPEgWy6dTyRrBhKbw4pbe4X/2Uld6Kbm6dEniLtl+iqIEXUHtzwJPe+4Vu7?=
 =?us-ascii?Q?n4lS/BGbqPisOC9pyUg6GBSSFprRHYC1wMk9Md01R73zYADt8r6Kr6Lh7LRo?=
 =?us-ascii?Q?yK6LwOpE/ztprgVOE3mp+QDJRb+fI7zaSoVAIooPtIMrNJhf4v1Nmmh7S3nx?=
 =?us-ascii?Q?FEtjLTKt3MI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fOS5JhWaVD61pl8FXD0p8tcw/OBU3bLA+0od40IFONLchuE5RhjzBLaRbADZ?=
 =?us-ascii?Q?N3dqnDYCdqEfX9EDTeL9tbe6ojrPjXOY6DashSaTyT3rOKAIAgVNeh+oCPeP?=
 =?us-ascii?Q?CxhC4dB70cfRVH46cJVYtdhQZ4aE7tDTvKhcvKI+I1aq4j4iIYVEfA8OPVjK?=
 =?us-ascii?Q?R8wnB4jixB+ckd2Gd97PtT34WJWFYsYpu9+54dn0tWdy4snXcjCUaSOqGkkN?=
 =?us-ascii?Q?LvIVAPsUZDMQ0dSoc3DB+P/lJSU7PjkN2oaZm7fd8c/uXN8wDKNpEq84xn4o?=
 =?us-ascii?Q?KEJfjfIRA2RwibjScXKa4Ikyq3jH+IN/AmP9dwMBrVsTe1w4/yLMjfguHzxP?=
 =?us-ascii?Q?I5cc6IkUzLyS5wl8bfPJxqMEtzJpegH9fGIs7TTJ/yA1+3UTr2kR46zcPiKL?=
 =?us-ascii?Q?SX32betWq6KhkbMDyrtp1/yJrGSEWNCjjffULUYJzLO/6fiSk+apOAuJVEdU?=
 =?us-ascii?Q?OBSkKDttlLbmwSjbUszGG033+/Z/BG92JgcWqVpimoTzpvDUw/Y9v30eiDkn?=
 =?us-ascii?Q?L82S60d6996qHe4w051suVKqHXRzBqVG7ZD/qelKuSdVN2PdC32+3+8UOYY2?=
 =?us-ascii?Q?TnWRWn0cZMquc4lu/LxAS/z0gbkqRJuOwdNn7NwZOz0XyiqtCkLrhWiePrgH?=
 =?us-ascii?Q?8SRNfCuT0G+hXXA6/wtgn1vrjxTIFirn9tdJlGf2DxwebRVeXdpCf3wxoAD/?=
 =?us-ascii?Q?wNx/hGNUAuzc+9YSwZd/hGaOSjBRjZBgN7peDQbmf/OgI86VA28Wsla6tmDw?=
 =?us-ascii?Q?wv8C48kBrt88e8dHxkw5qda+FMaYuevYNGnOaFKC9boIB+1MyNG0wmeKpAEA?=
 =?us-ascii?Q?6kEnOJzM6viD/AMfENmks0pgLR25ohWoHbmpxcfSlEK/COquqrD6ZYASpqfD?=
 =?us-ascii?Q?WN1e9qvtEVQyuPLiTc5Sm4IkOArV8byczVcNKaYLPQtIxRKPLo1Td/8i1EIa?=
 =?us-ascii?Q?fGOTWDiET42cDNJRLU9P3G4DbJex7SyvmNp0Ss69l16CvZuomrkd/MSIFS0X?=
 =?us-ascii?Q?o2rchYtALaybpyEeT6HIYEz9E/MGUynTvneEEq99Fegc9okqAaIuoxJg2tLI?=
 =?us-ascii?Q?+uciCXddNRWbEIbmlYPa5Zw44dAC4PKQ49a9i03/PCM+wSu9fL07QyMrbpcH?=
 =?us-ascii?Q?w6C7Nkd9HqoH9BSRQ30hCcYZfaJyoE5//M05yuxwIv4Piewf8b0tA2rWxwpq?=
 =?us-ascii?Q?E9V4MTzKCbRA2Xc8e9LUXnoiQBOhA5AZGjYESfqhOZ7+jFjZs8wIdNcBDE0t?=
 =?us-ascii?Q?yIiZqjrxe1AwBRnD0gfMtUpu2QmQIGIq8AgA+bWwxArQ1hiKm4FEjjf5+/dZ?=
 =?us-ascii?Q?L5PlMcQ4FmSwBBysd9X3CqXoVNMu5lqxpMkegf42/fLvlZ/vC95UucYWhyKA?=
 =?us-ascii?Q?ILHNAzCPOuxPw7JU0JeEPwoyGi2Lg/SQytdWC6mFE4khKhfMJAWSX0FIKvsS?=
 =?us-ascii?Q?6nB0QKXr9lClaXuxaXF7S4rf7OTX8gYg9wKyHus9ua8y02Nh1sfzrjcgsQgg?=
 =?us-ascii?Q?/N1VQNyJbH03aPFI5miK0KVZshOYXlPbCzuAkzyg6GY06PsJCz7bwrwWXoV+?=
 =?us-ascii?Q?UMScavSQGhFhitGAzMlHzx1ejeSw/KJ6ejj9fVwheEh07nhTqTiFYCeJsvW6?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hfC0TSFQfAOu48Ug5IjJVjpKMzeocZ7R1hkPvJ5aUr3Yx2NxC6/Y++9m/EHkOKeo1Dq2ypT16aqWguabrs76aRFvxtTMG+6UdslqP/URr1kmd/5srBnurgn2teICJsKn/EcyiDY5jtFgEeCN+kldIo7oHGESTDDWYiCZm5JAMKf8tExyauAw4Cq2sZij0W56iTRRekA7NgXVVMyj494vCO0j9ASfplzrmyyw6JgBT4l0awVuOyOr1o5y7SwzJQnrS6f+VIDDvZanUsbReM2x4J3tdxHUZFtgCTwSk8s8rbvfWRQxgjyJCQ/JV8LLSgEXlLrt4ILPulKNP1VDGWzD6CCX3dp9PgxC9PUYQf4uTUvRXkAgJAG7mIsmUc3A4XicwpvtyV+x5JfZ9kspZsX2qW21m7cMHJ82mwkubbT7THibxz9gNHOnPQJW/T4t7Ah9c1YuU0x04npTO+iGaxZvTSKs6Jhi/yVwHWm5+R4VkMaTvkpB5y90h/mSrHBdHQeg6JJCY6RWwZalDSj4qretl5K5KYmlbfAYJToG6bpsfx8Y0oyTH9RPs/8XeBU111wQl9m89b9qCu/s54KCT9EMPkqAPNXu9bXdQZuBskcMDT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4222a1-f42f-4c29-6340-08ddc9a4ddb5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 04:53:28.8601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/Oxl3RPWCmaYpjEIsIybTKwgxY92V9CuR7MH9dIvggNYoU/9RMTi825QdeaItr8UMJRHLe0TCHGO8SVv2AoSxkQqdMpvSQ4ZmpobqE9zys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507230038
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=68806acd cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=XIY3FidbkUzYwpyLUu0A:9 a=CjuIK1q_8ugA:10
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: SKZfuNeLFcYD60h6LWTeMYC3qXSGqJzS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAzOCBTYWx0ZWRfXx/mohGPRqyqg
 3oyPm5UHbu+olbQLI8A6SFaTXclJOKlRwk2EVqzbYdDkQomIjxhAE6iOfSqjxy0xuYUmPc4Qj+D
 sBvx48621qPoe/VKyZh8946kA7hE2/PYvisS59BCUM7m5lVPJDbnxg8kMK294NiUMqoKfQWd8D7
 pjoo8Zyiy9288WrriCmnT2dolaqGrrwpha2Uwb0eUxWFeKJQeD5MYeqIS79JsvBF4v9hdhZSaPu
 c/SpxtfYOoB38tyIwxufBOocZLloAWHlDqG2dthL/P9ftaX0W+PZUKgUo7dRF3aw4G7fA/Qqj+t
 wE5OzZ9xpVrgKSQjRtmSWGIz6PPI5cMRpPIUo8yqeaVmdDKi+71LHvwzk4+80GhQuMzrLhESGXD
 F4y/WxLy0bB6u+RAKLsHdjmlUKxmLl3YXb62+YjTc/2JAG7Nqgksb6RVJnQ4tEf7yWZzNn01
X-Proofpoint-ORIG-GUID: SKZfuNeLFcYD60h6LWTeMYC3qXSGqJzS

Hi Andrew,

This file also contains shared logic with KSM, so we ought to put the file
in the KSM section also. I include a fix-patch to do this.

Thanks, Lorenzo

----8<----
From 5ce64eec3514cc7e30afcd9529f73486008f6770 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 23 Jul 2025 05:50:08 +0100
Subject: [PATCH] MAINTAINERS: also add mm_slot.h to KSM section

The mm_slot implementation is in fact common between THP and KSM so ought
to be included in both sections.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f83fb317f51..a77c6677bdbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15821,6 +15821,7 @@ F:	Documentation/mm/ksm.rst
 F:	include/linux/ksm.h
 F:	include/trace/events/ksm.h
 F:	mm/ksm.c
+F:	mm/mm_slot.h

 MEMORY MANAGEMENT - MEMORY POLICY AND MIGRATION
 M:	Andrew Morton <akpm@linux-foundation.org>
--
2.50.1

