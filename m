Return-Path: <linux-kernel+bounces-737306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E56B0AA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095FAAA54DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5D62E7BB5;
	Fri, 18 Jul 2025 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z6MzblQB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oc9IO0Sb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7111BD9CE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865842; cv=fail; b=jS2glDPLgn+p2H1k+qATowasQ76exa4kyUKiWw9CsIG4OzIpEoalI+9o1Vyj+/lXP9Y5mD43U1kayixWuH8clMtfZXyna+jYqpkf37EJwAp4lj5RuW0b9iwRlTVXXNcMd8Jyx2gjxmSHdudMQXK7RxV7C6pxntNdfJx2i6QExEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865842; c=relaxed/simple;
	bh=lJlgANGE1fw5xhDWa3ImqUGJFT3Gq8UiWecLskw10NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W37K0XSxRaDxYbLVb0EwCqGozq0HNyDY7+PofKyLIDLf9LH3RvZyBtzbDglXxJHUl9KF1PTsUl2+BMD6SUAVkiqF2pE/D789cjo8OB1bwbo3thfTp2hTg2YFbgNs6CqcjWk8q8teXhsGaGMouDVpLzWUjuVdTKPgBsNBS/Y1HAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z6MzblQB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oc9IO0Sb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHIGqg017782;
	Fri, 18 Jul 2025 19:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1U+cBmPcUVD+hUuhJI
	+QryX8PxQ45z8GcSdAOuIfYa0=; b=Z6MzblQBNDHFGI2f6MGHtBZHIuruMd5ALm
	WBNgu1UzqRyELKKNbC80RoH0LAOBVcr4Q2syaGp25/y7u6nGEMDlWOity7O/k3si
	JlTpSLqD+UPC7lCYR2AvoqS8o2WhxIs52Y5X45eJcyxDqATd0r7c1XbXbLUBfj6d
	rTxcirVPjJV0zHnfPhohhMXea6L26FD9LUOyZq5bq7BxZ7JL71EDWM3rp3rRrJQr
	+tWS6kpS+wzsxAWSyit1d5UoiLNO8ENpjf9zzH19MINQjtx7i91kM+nvyP64/j05
	+RmWQxJ+1pY2VNbr1KV4FCsyI58OlRwlzCv1D5TDuMYCStMamhFg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b5pnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 19:10:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IIBJSx030314;
	Fri, 18 Jul 2025 19:10:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5echf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 19:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apBpQKRAwWbj+f3wTQwTUrC3Qx35hBHh4q89IMgR+8zBWNx1Vnsj5fgan6gItS3uHEJReCyxF+Nhn6ptPYFm8bcwP9RTbwhx7vcFqLuUKnUFngA/Uehmf5NPQElJCrc9FE3gMIhlC2olEGV1MBui5BqT+Kdxq63UnAfb/BCH7xv3KD6PFkM14ku6TZk3M/yMoZEJ3y+qwGz7iW2h2P2d+0JlDyJhxzgFUcnqKq9Hd1fJGasU3Ls0fr7rs+g8Ki8exQtlcB2w/yBRvdVvI05rYDROZLTaAfXgVSAPuL1VC4tAp0hWtQdyoDa9g/9g1LsUGNVlz7fgG+CzHO+wggelBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U+cBmPcUVD+hUuhJI+QryX8PxQ45z8GcSdAOuIfYa0=;
 b=iOrddxcDEbrtnGz5NAKjdA9bJWLYd/MVodkik6+PHCa3/o8K1OFlPl86epKvtkkpeVjZEStoeiBP3qvDvGw5VxbowCHnxsziT4by3afrKaos7h+wh6O4G1hkK3nMg2H56t1uLt6W+TxOfirv2vuRdO6xt2j5I7YFR33S5yBmMt1PWu+vXtMgOYLI1PP2TSyQhdUJahJaYh8tHq62q7Cb9LYSDjix4Oef7Yck9pMoZHFWFSVF8IlSxXJXipWqAmNpbbvyBYMTGbdzXoZr5ogumDX93BMVFZu7fBz4RBkxrsAtw/0TQbKwCEhFQWGjfHyePcozTdQz+jmlhJXjkdPdqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U+cBmPcUVD+hUuhJI+QryX8PxQ45z8GcSdAOuIfYa0=;
 b=Oc9IO0SbQ+ohLqsDDpYm08SH4XdwQ/N9KgMv24rUtldd1K5xiiJuPegA30p7cv2i5Y/HHDIiDMpri+ZGrWUFEfLdxO2Itr//oqQ7/jGlsMcP3786MD5TIx5gb4b67o9ZDoSTNpCxin0ubUl4W5sL2FG1AkBccRBaIyE1n+euhe4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5684.namprd10.prod.outlook.com (2603:10b6:510:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.41; Fri, 18 Jul
 2025 19:10:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 19:10:16 +0000
Date: Fri, 18 Jul 2025 20:10:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Antonio Quartulli <antonio@mandelbit.com>,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Balbir Singh <balbirs@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] mm/huge_memory: deduplicate code in
 __folio_split().
Message-ID: <9513cfc9-226a-4696-8dc9-4eda6033f47d@lucifer.local>
References: <20250718183720.4054515-1-ziy@nvidia.com>
 <20250718183720.4054515-4-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718183720.4054515-4-ziy@nvidia.com>
X-ClientProxiedBy: LO4P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 1975b793-d5e1-4169-875f-08ddc62ebab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f2cMOgg+rCrAlXm5ggX78QGJYwuFzBfaGaJzy/oqTKgFrR8xQ2ymsqwdlZdS?=
 =?us-ascii?Q?h+xWh89NQD3kQO483rj4eRcgr4pNFTm83miN7tNyOtROJex799vvbYgyns8v?=
 =?us-ascii?Q?8KgZwNwf7Gm35r2GRtK5oCP5CambPrCUnr1WMKDWiOTehzajKObYFrdqlblk?=
 =?us-ascii?Q?XmihArjDF9BDXu+6u7EBimt7GkZvvwSis1L+W5u23PaGlHnFojb3PIz4XM6j?=
 =?us-ascii?Q?T5Pgy/qW3piuxUxSn8xob5r3vQG9vpN4nF/oUbguUKpZO+3kfOdLrseT6z9j?=
 =?us-ascii?Q?3J2aBqFrmCnefe+ccHcylefcdoHZc7Lf5esp9ceTKiJlKSWmYXUoAs4NWYjS?=
 =?us-ascii?Q?K57pNMOn2792d6KsIzFfz7EAELYdMFgKRomjJdXZfAQSEw5+K2JhHA600gN+?=
 =?us-ascii?Q?XSkuoC4s9F8SF4nAszpV5lYJqPfgvvkFgRmUG/SYERCQrn3nHhSU9VOFmCi8?=
 =?us-ascii?Q?MW7DFfYNUnlrlvFP0lUX7//NNcNWSpbZ6kIqQPKup1Kr529bOD8pMNCzlNoW?=
 =?us-ascii?Q?5kRkbpdJSTc5ptq16xe/Ve9PJ6ZEpwSMqnVEBovZ1/ObyxWp4UysabLPicgQ?=
 =?us-ascii?Q?1OE33tBZrfbY3POBC2661WE226+RoMSjP9EbD7eeA9IMRAIQgPhuZ4zfy4+5?=
 =?us-ascii?Q?VF2cA3vwXsaJ8XP8VaCj70a8OBkIJ/FCr4LUmgODTX2lX9l3q9LoN7ES6UA6?=
 =?us-ascii?Q?doaVXNN5BnQKe2TVQLp2VCLXXYZ7Gz6YcrAmBnXKtGB+uLir5UavDsWmULNJ?=
 =?us-ascii?Q?AUGPC/obLclsLanjcgCOKYpaQ+IMDJ5zDlHCGp9+RCisLidAnC23giPeNnRq?=
 =?us-ascii?Q?eAnbTvbK8KYnzim+zzJ/qYPC+fhLt28lU9ieoLMJxp6NLQGqgDLpgqEiT6aM?=
 =?us-ascii?Q?jdv1Zxka1uTSlFbibzWYoQ/imbJprkI0MsPRvZkHpVUl0CzvJSioYg6yyjrW?=
 =?us-ascii?Q?OJflIvwct/6quGqKZtGa9iF7t3tzieXFZdHsdOCgLI/GrIdPP1BrsSRzQeqK?=
 =?us-ascii?Q?8Vktg93ghx0V3K+7GUzdZYZbx/nNi34vos4R9ei9yYf6kTbqUr/ceyttiMva?=
 =?us-ascii?Q?drCh3lyN+hHL6KMfzk4hss4sKK4z3fI7C/5ZJ0sAq05058DyjYEJwSRhXAd2?=
 =?us-ascii?Q?XGYDioKh68G+nI76U43DEzVnYUYdnTGKPqzJJ5RNQaVmk079LqABpDQmGm0l?=
 =?us-ascii?Q?dfqVDJV5pNMAlppBDgsk0FkDDEP6LwH9XzgHUTxIu3v3MdLB3kQlKM4YgmBY?=
 =?us-ascii?Q?MKOB2GL1BV46bW7Y4Ntd8te96jfAfR7KRqBNyDCD8gC7xo3KYllBoZRubtw6?=
 =?us-ascii?Q?YTfXbXcrijnzWgHP2osKaxERS8rH57CPnDi3vpluhsqLjVLB5bwbVpnSkWCK?=
 =?us-ascii?Q?0G6vPdhK57inwo1+DFtAiY83dVYQexLuKQPx79lzvfls35GwXHDG9szhcjvd?=
 =?us-ascii?Q?VujoBpm58Yc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s/sMBrgeo7KoF6tgGl0RSl3OWF0jOaLxnPwULLmWnvkbvbiQbEX0JfXfK/eR?=
 =?us-ascii?Q?bnMgR8bPXnWeCCBdeG7pn1Wx4ce4nzPDQCA8p5/fdPpz317MMEC/HJOGG9A6?=
 =?us-ascii?Q?WvpBEVD4iIxrMTFP6Y3yJqmuy2PoU6DFenBZuRq7oOw6QoxEdEokaWPGTecc?=
 =?us-ascii?Q?C5R0J7SxsxD6AbswZDgFJZn/qsDzP+PXfM5Jkgwl8kHKPE92QBca+wSHt2WH?=
 =?us-ascii?Q?+8+czqJc+qhriRL6NtE3yFx04NriE9ipiMrLAdE0a0bOOeq3hEQSNJgKh72R?=
 =?us-ascii?Q?FigPExlFdbXfSUWF7wkcckZZ2GZAqmll9B1no6QS5WwMT1GRXHrUPAwmtmVL?=
 =?us-ascii?Q?QJw2Dsrq9X/NdTa3F5ZWf3EVNNJWNX261YSrophb5w0K3gOu6K1YtyNPjkbG?=
 =?us-ascii?Q?IqXsUbfKsFX2X8Uy/NM9GFUX1CXb7zd209uerjzmpuIOs0+mQYBlpXXexo1H?=
 =?us-ascii?Q?c5WOmMGNWWUvrOrKkJel7Z7d56VMJvsPZvHFkTv60BLGEn7SR/tDUDC7QZLB?=
 =?us-ascii?Q?nKXbo6ENU0TpR0YsTtCbmS50cJ1zdO5ptp6Aw0pUoKVNkD902iLf93YNFcrW?=
 =?us-ascii?Q?TdWG57oksuXWdltdDgExrwjSaCp8EmqxFWjZ/YSvjvLXm0NFI2/IwHFd+c8t?=
 =?us-ascii?Q?TDGpttMrgPOVymJFlvgY09FceQleJQ1/zNmx+8kp7JZE8zjkxz0Xl5D/bMWL?=
 =?us-ascii?Q?RhdXp6azWjkNgiYsXpU/zGafScW3aUieXyTJHGtBvLIKod6VlgvisdwksLDA?=
 =?us-ascii?Q?gYRgWmnTbVSWwBtBxAlHLoCgBHW3yOHWmezEqB3rq4g7hUMl0tqF5puHeDnP?=
 =?us-ascii?Q?mzdmphazJ7BcgL6737iGchfv+JudcvUrjmuNTUkgXD8fwcPXSjiwpla9MJGD?=
 =?us-ascii?Q?kVzHa4dOM/Qj7VdNufjbbAse3A+q5ICCVDvgNiI5YFXYE0l+7+KAcX9oufwX?=
 =?us-ascii?Q?MuLzJ2YHKpAKMBFIHHzhluFKAIH6bfZn5WSGGhl+/QuloavZ99GQyRuu9cAJ?=
 =?us-ascii?Q?yw8gdp5vaY5WVIerPSxKWwlqueWY0a/3nCLlQpxqbqAONCUbLb3uFC8kKjPK?=
 =?us-ascii?Q?sNtUgpJkHekWFIFBGWh2j7NVIHLZ1uhcPujqfRoyb516tk76SyS7uaoKmTgF?=
 =?us-ascii?Q?IVmbIUcfPmHcOcnfFLBYX6+ykRSBX6utCPVCtm07RnZ6WHvSZ4ngCANXse1O?=
 =?us-ascii?Q?tIR2Edcod9g9muDXlV84xyHzqGqCkkj2eKbseQwZGwzp14lUjB81jsOMERB3?=
 =?us-ascii?Q?Qgh47C+5S3lCOQl8XWNS38E0V+NzJ0Fui4Skynn9G1M+aHt7zbcMUBEFCt05?=
 =?us-ascii?Q?thpepJ3H3+Rju6DBXBJoi2Y3FNpBEcO4+FEnN/+Nka5NWCx8Jj1cSUT/Is/Q?=
 =?us-ascii?Q?wD/tBc+wIhSYWXzzFWGxFGQTBwywvRFegfrfEZ+E/ht5g8XminHIrM7CzFn5?=
 =?us-ascii?Q?OAVQk/QiEc6fj1fMjlvDeVV8vAmtOyHwfPfthbWFi0slY7JoCBpvWc5KZx0F?=
 =?us-ascii?Q?6vsGgdmmr+ZK90Ky6ebsO1hmI31gzczCGeMtMA/JOzfmJk/Fa2nizK2VzbhL?=
 =?us-ascii?Q?tNIc2JVczQ4VT/I1zS8AyU5foqxbPs+D973jqLahvEej3yK4W3JUMdAPXu/n?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tfEPJNAV3qd+w9EwY4gc2OQVQoVTFb9jg1TYTAunxY8+0kt7OUNK4ieyaW+Gsv2ZXe87MCQUDCV2FumHy9Ftbr2w9H1Uc+/O0mr0pu55w+OgkWnk0LAY4uZ7SaQWPPuKEw0dNjuXUY5nNdUE6UWRYmOw9vACuWUpp34mK11K0ohSRiNp5Q1SBDn1NuQxMjjQ9A6CPmT9Y5AhCPTCKP+PRpJwf0L88/S5YdVtKkHy1eKy6/VfMCP4h2GQOJe3cl5Nd4/py/pnsB+OiUNW4Icms3Lri+oplc+APxPEJxtn/DwymvK9kUazWvDMCv2K1PvLQ6uxyghISeOOAOnlHy9bDU0L7ol1z8RsrRtjgBCY1Agjif0NY2xHiqbXjLbvj7TTfZqlJWy6WYPbV0tqPyUOmO6ahQNpliOkqgiTs1sHB6nFCyTwAypezdvcIH6Je5B4ZGGs2Dz7ttppuh1h33e2anGsVc23N/BAe/SAbT4Y1JA5iY51okiriDMtOFU5rH1ePZ8mAYb6HJtnxuwrBv1xClj1WGkfY5vdO83f4miW/ZUkagb+lGVJ4Zy+IpZZqJdeuZVRKYL1jQ96P06epF/kV8gHwD/c+MzTZflCbJhRDs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1975b793-d5e1-4169-875f-08ddc62ebab7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 19:10:16.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4DNknhx+gB56fygv/VdBk45wStZzCqdLx1Lk1haymSTIU18a6zkfdULVedmiaF3yevRIG8OlRJF2t2bMBmbjKNLudeSvgufnlOIK0+93Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507180152
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE1MSBTYWx0ZWRfX1U6krPEXAzTG HuPsizRcTkIW93ULIep2KvEBHrBSQIoK1eJwXKzUm+PTv7U7aqNtt53oo+1AM3sdx6XE2eYgQO6 4iTMufdeDyNfyvcfNxIHGQDJFkPJ6K4XfwjMOjVYbOIR7GrwYThFujL7xkTSPgvW5ciZIdQDPYu
 JFdWAcDd2nshoxVnNqPdqatBv3TnYPXJlsxA6F5yajn0K5gnEZ5sHC8Gd3hV3i1lkQ/+mu/39oD gvFihj8gqDezg1VmwxWC7Xi1qgfz5z+/gMrFR45XcjrwCceelmdR5kuoXO3vTu/sd8V6+hgwFon YtqdyoKfv9Hnp4dPY5JpSggij11YZPqYId2tA3ilXLO5W4LpcTgqRwaQ0cv22XGah2AOn6KG14L
 kZ5jbutoRA/Ezn9rTE93ahknUsjv4ioPV+gETRBTsDyA1ETwtUIxGbCJ1k8W0RVEESjkxQTo
X-Proofpoint-GUID: ba4o_f9IUCKV828TPofO3bsKeUugF0TF
X-Proofpoint-ORIG-GUID: ba4o_f9IUCKV828TPofO3bsKeUugF0TF
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=687a9c1d cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=XHAxevHCzzRxtU4hrsQA:9 a=CjuIK1q_8ugA:10

On Fri, Jul 18, 2025 at 02:37:17PM -0400, Zi Yan wrote:
> xas unlock, remap_page(), local_irq_enable() are moved out of if branches
> to deduplicate the code. While at it, add remap_flags to clean up
> remap_page() call site. nr_dropped is renamed to nr_shmem_dropped, as it
> becomes a variable at __folio_split() scope.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Sorry I thought I'd reviewed this.

Have looked through carefully and the logic looks correct to me, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c | 73 +++++++++++++++++++++++-------------------------
>  1 file changed, 35 insertions(+), 38 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e01359008b13..d36f7bdaeb38 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3595,6 +3595,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	struct anon_vma *anon_vma = NULL;
>  	int order = folio_order(folio);
>  	struct folio *new_folio, *next;
> +	int nr_shmem_dropped = 0;
> +	int remap_flags = 0;
>  	int extra_pins, ret;
>  	pgoff_t end;
>  	bool is_hzp;
> @@ -3718,15 +3720,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		 */
>  		xas_lock(&xas);
>  		xas_reset(&xas);
> -		if (xas_load(&xas) != folio)
> +		if (xas_load(&xas) != folio) {
> +			ret = -EAGAIN;
>  			goto fail;
> +		}
>  	}
>
>  	/* Prevent deferred_split_scan() touching ->_refcount */
>  	spin_lock(&ds_queue->split_queue_lock);
>  	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>  		struct address_space *swap_cache = NULL;
> -		int nr_dropped = 0;
>  		struct lruvec *lruvec;
>
>  		if (folio_order(folio) > 1 &&
> @@ -3798,7 +3801,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  			/* Some pages can be beyond EOF: drop them from cache */
>  			if (new_folio->index >= end) {
>  				if (shmem_mapping(mapping))
> -					nr_dropped += folio_nr_pages(new_folio);
> +					nr_shmem_dropped += folio_nr_pages(new_folio);
>  				else if (folio_test_clear_dirty(new_folio))
>  					folio_account_cleaned(
>  						new_folio,
> @@ -3828,47 +3831,41 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>
>  		if (swap_cache)
>  			xa_unlock(&swap_cache->i_pages);
> -		if (mapping)
> -			xas_unlock(&xas);
> +	} else {
> +		spin_unlock(&ds_queue->split_queue_lock);
> +		ret = -EAGAIN;
> +	}
> +fail:
> +	if (mapping)
> +		xas_unlock(&xas);
> +
> +	local_irq_enable();
>
> -		local_irq_enable();
> +	if (nr_shmem_dropped)
> +		shmem_uncharge(mapping->host, nr_shmem_dropped);
>
> -		if (nr_dropped)
> -			shmem_uncharge(mapping->host, nr_dropped);
> +	if (!ret && is_anon)
> +		remap_flags = RMP_USE_SHARED_ZEROPAGE;
> +	remap_page(folio, 1 << order, remap_flags);
>
> -		remap_page(folio, 1 << order,
> -			   !ret && folio_test_anon(folio) ?
> -				   RMP_USE_SHARED_ZEROPAGE :
> -				   0);
> +	/*
> +	 * Unlock all after-split folios except the one containing
> +	 * @lock_at page. If @folio is not split, it will be kept locked.
> +	 */
> +	for (new_folio = folio; new_folio != end_folio; new_folio = next) {
> +		next = folio_next(new_folio);
> +		if (new_folio == page_folio(lock_at))
> +			continue;
>
> +		folio_unlock(new_folio);
>  		/*
> -		 * Unlock all after-split folios except the one containing
> -		 * @lock_at page. If @folio is not split, it will be kept locked.
> +		 * Subpages may be freed if there wasn't any mapping
> +		 * like if add_to_swap() is running on a lru page that
> +		 * had its mapping zapped. And freeing these pages
> +		 * requires taking the lru_lock so we do the put_page
> +		 * of the tail pages after the split is complete.
>  		 */
> -		for (new_folio = folio; new_folio != end_folio;
> -		     new_folio = next) {
> -			next = folio_next(new_folio);
> -			if (new_folio == page_folio(lock_at))
> -				continue;
> -
> -			folio_unlock(new_folio);
> -			/*
> -			 * Subpages may be freed if there wasn't any mapping
> -			 * like if add_to_swap() is running on a lru page that
> -			 * had its mapping zapped. And freeing these pages
> -			 * requires taking the lru_lock so we do the put_page
> -			 * of the tail pages after the split is complete.
> -			 */
> -			free_folio_and_swap_cache(new_folio);
> -		}
> -	} else {
> -		spin_unlock(&ds_queue->split_queue_lock);
> -fail:
> -		if (mapping)
> -			xas_unlock(&xas);
> -		local_irq_enable();
> -		remap_page(folio, folio_nr_pages(folio), 0);
> -		ret = -EAGAIN;
> +		free_folio_and_swap_cache(new_folio);
>  	}
>
>  out_unlock:
> --
> 2.47.2
>

