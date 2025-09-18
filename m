Return-Path: <linux-kernel+bounces-822728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0ACB8488B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED7FC7AD298
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F1D18BBB9;
	Thu, 18 Sep 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HeWE0nEO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HSJ5KYa2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1472918BBAE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197795; cv=fail; b=oe4U9U+bOoFwci5Abaz43DmYUc/EbqdMesYO/eEtkR+B0/bSq8YCJ8NPoZx5eGVLaUqfshvXK7sdOAz5zL4gxl2JXqTcB8dvsVmmSzoW0iFs9O8lPNuq0vZlRQpmZGULQ3m80uR2wgG4+7giuEHGCTyNL4/4KZRKFdKDjtsSPMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197795; c=relaxed/simple;
	bh=XZYdmIaAUUtz1IoLxezJ6cp4C6Vk3Y2FwzvZ+wFfL1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GGpzyDX67VnlAb9Bd8xFCPJtpdd/EXX9dhupXazg/I9a21Fn+aZ3OI60RazHLJiedbrKO8a9Le++48LucPFhizSBFDzqtOAVFaEXNCqyGT3eLzufCrNDZ+9NhdiqqoVu2T11wA97YBAybh30PXsKQCD972dff3qUI/VhgW4vOEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HeWE0nEO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HSJ5KYa2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7ft3F002485;
	Thu, 18 Sep 2025 12:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=i+eNXrqaFfZGS4tKTh
	qQgRLt99ORlctF0q5AFyWQt6c=; b=HeWE0nEOseCjJqDCCeypteBpsmmaL9SMQD
	VCoePgso/fbI3dTF/25M8eWqy8X7w6EsbB8ta6oFq/b9Y/XEN0SCRqG/+RE7G7vf
	0jkzr8ebCEkgRCs6cwwlVWEABWtn7LdX+k2e6LLBDQfgL/S9x4h+o7JdZDD5dUYw
	DXxvhbMrg9JmcDAVCvrPuXMOr6UCTKUuHhY/BXTRzGa33IiEocfP4P+Y1CLX+Bpe
	L2r1CrQPWUs7ulTm1D0LjteLbjAJIT14Lhj6tJrISn2UMXxTxpRSgM6o61B+cTVR
	L8ROci4FW5HNEBoDOqeiOHTqXAHcK/4aevmJkwGfBWi2Ncy9Dbvg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx939j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 12:16:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IATwLd035087;
	Thu, 18 Sep 2025 12:16:09 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2nbdqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 12:16:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hK6ndNHNPZX1kQu4F+/11F/0dEhGxWJIyzAJeftWIt0G3EU53RzvuQqjkw9HgW2ldCTmOMELUXR/jvOB6z3SLnTCeb2pkQyXqpLbfhZAqzXcEoulY9drZRcReiqQoBBYCI1jkRpbkX+lqxI3OxTTb1awfw3X3dsL8rDLcxq7eyE40LbQ1UuvmtBn3nFh42IeIHAo9HXSIwqgSIRyJ1XteKqu2MYWNbJ7KiUPJS5i9ldWTpdWEAoqF7Q0q2spwwQA0RPnv/LywXESkd9AyYkPL5qLIHpgXkockAwAzeGwtikO8Z4rGjvM6L4vHjcroTqqstfClmMl87BcOEJxk8LXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+eNXrqaFfZGS4tKThqQgRLt99ORlctF0q5AFyWQt6c=;
 b=fOW3xVI1FHhhpDnT7Otc9+P8/ufiLPJm9GFQeMWA3bdfRC4aqMCqgtxkQbKBfHfLg7SOFyBXzJoW+iz2i32EoQM1tz7Z3ojWIeH3qVOUjCXRdcKnhClq2jJFI2R+MmtreYz/2udlityBXjp+zKQ9AS0Ajfu7hnoJ0VjnfPrwhx6radov5N8pSNnm0rLbTctG3ZaAfOBOyDNKcRM53xJDCAadrfHNJriQyLeiN+ZNJZZQTuJj5Qw13xymQtMP48XgfsJ77RJYYUAuEEcBnStGCQcexyo9TO61G7vi9AXHSDNu+24x1rptIqN466zo+sdnK556bk0AoHcp8445EL4EFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+eNXrqaFfZGS4tKThqQgRLt99ORlctF0q5AFyWQt6c=;
 b=HSJ5KYa25y8FHtw+88ctosr9bQipoXQSXxZ8giGilOiKR4ic3n1vzizgzEUuwgHOLPCnjPhr49ZfAUgKrYg1lCOGpjYyxOCakj7rqmGvCZzKV38WL06K0rn/wFPxi+MZpCGXa69bqPz6FkeETTxOEilSavLZcapYZjBM8miFMN0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7472.namprd10.prod.outlook.com (2603:10b6:208:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 12:16:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 12:16:05 +0000
Date: Thu, 18 Sep 2025 13:16:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mm/khugepaged: Do not fail collapse_pte_mapped_thp()
 on SCAN_PMD_NULL
Message-ID: <1a93bd0c-d673-475e-a28b-0a6d0d2e865b@lucifer.local>
References: <v5ivpub6z2n2uyemlnxgbilzs52ep4lrary7lm7o6axxoneb75@yfacfl5rkzeh>
 <ecac1e7f-1709-4348-b8ff-fa1c0f087548@lucifer.local>
 <l6yjv4b2xvcwgpq5q3esyat56jdfj7flcokbqptsxlzgesrwe2@sxxzcp477ldi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l6yjv4b2xvcwgpq5q3esyat56jdfj7flcokbqptsxlzgesrwe2@sxxzcp477ldi>
X-ClientProxiedBy: LO6P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 19919494-48de-4c3a-845a-08ddf6ad2441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w6Cfjp678ZYFmEooN429I3Hw/HUUdrVKRUAB9fkOsjPsluaelCqmj0DoWeXw?=
 =?us-ascii?Q?/dOlhSpGTCNrTWOeyujUer/nJspt10JtCb8XkQe9SSDEhG2L/TSMpHQNSvSD?=
 =?us-ascii?Q?FBiWaEsZBISl90QiDUGYfwtgb/IPr3T/2PS+C6wCZ1GEP0e1+bauVR+jMcLg?=
 =?us-ascii?Q?RPoH48gkt318Vzr2XeGT8VMENeG5RO63F/Y7q0EDV1VVOS+wwRVGuMmRAiUD?=
 =?us-ascii?Q?7s4tS7kvB1aCPYeQFn62pSHy3JB7R7igWX2eZFp2iOkFA8Fn73UeMqwtINEl?=
 =?us-ascii?Q?ogTgtzRdhPfDr2dbu4Pt/rHaeD6xMza0Za8KzCYpQBNazA6cztxe8fi4lvZ3?=
 =?us-ascii?Q?ZZkekuEJUxeyn+XJioHsdhV91Ms8ER+RMAWGxarxYcO0kZOoyps3tooZqDqx?=
 =?us-ascii?Q?RzBpbVlLMSLPrDJdzJ4l1kBX6wUS3g+JdzgyrgK/2sf0eeaAlP8Ldd+pvEwM?=
 =?us-ascii?Q?6m8k5K2kTUliTCDoUilNGH1/FubgrPHdAfK3A0IFxFevR5X2fA3MY9I4CIlQ?=
 =?us-ascii?Q?DBnckFn6uQ7JleJjTD/a7AP/+6TyHWHY0DWJ3kfxh87SZfiZZWEJeta1hCBp?=
 =?us-ascii?Q?r030K3QjQzisbxKxoeUcUQtVVxuRuuFm4jNhuTaNI5JGjiE5ZbMvA/xWCRdv?=
 =?us-ascii?Q?JKC/DrLS9NM6Dzqq98CL3k3YjL0ONIgFm9m6bQpRfhsWhc7NtDKbxvxIohzs?=
 =?us-ascii?Q?qv/+/uCd+LEhqEVhfXoOcfqW1V/I49gZaL2ePluByi0nPNDuCewUSvHprBjV?=
 =?us-ascii?Q?uASnjk5X+hlpDgMZAFHaZPrLpZpLF8eeofiTmDFgncQzumsLc4ifzxZz4epp?=
 =?us-ascii?Q?fGP0bVN6S++wKJKhcSOcp5Ml8JGOfn+fPd4AoOoJqfVi6VHW+mAuY81cUYYC?=
 =?us-ascii?Q?l283e2tMP8OZF8ewpH0Qudc2LdswXxGPg9IBkhwsg4QOcpZrgUlwIrw0w/nj?=
 =?us-ascii?Q?vL7G8vKKPgSWxKB/+P/Hh5OAN5gU2C14jSRaVgLdhl9Nb9p2pK7KUGCMJXn6?=
 =?us-ascii?Q?kzIn4lR4FDhNw9cQutTqH5A0kfbfuVM1k60mtdUpZV/NnyE6HoiYZ0G4Cch0?=
 =?us-ascii?Q?8c/FUGt1+vxsMlbCY0NS/JAUuRJkbA/CkjJ3gRSTrdc/PDOAiBjlErOod6h6?=
 =?us-ascii?Q?0hxDbpSAntyPLeshZ2rbVbMYQJNuRrOmFaIFfzeV1y9XIcxmJ6RXkAo1Mn+J?=
 =?us-ascii?Q?Tf8+z7mDbvkMliwNqoovjAu55p4wr3Y663cIJ8sDINjnnNvIbxzuvxjGYIuO?=
 =?us-ascii?Q?sw4ywTn/DkHsLhKWWup0FHrjXVwATcy/kFWFJWpB8x8Yyw9quA1RSko/Ln0Z?=
 =?us-ascii?Q?1+HUwr3voz9tcf5ozhxO2YxNjIFp91QHMix7OiWayMCaS/s+SDJjyak54B6C?=
 =?us-ascii?Q?oYIkvDiwzGH7J0yq761h3QPImC+YLSptaAqf5FaRtiIQ/hqgA4HU7LDtXEGZ?=
 =?us-ascii?Q?nh7Gg45a+o8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TE93/L/a7W761GVZRIeZDl3dXQpRCJGpIZ2cG37Yn1A1vEnRvm5hI/RTnDnU?=
 =?us-ascii?Q?HoNuR//eUJySljgtheAmY+Nrk1MF/SJP/QPZOiRKndj8QgiD9eNybaFrIE3Y?=
 =?us-ascii?Q?W4JlPe1G0Xfs+BNCwW2dYql31thYtEcVTt+0SmVpJkf7qU/nttq3sYXvmQSw?=
 =?us-ascii?Q?v/coDIyVDh6jlVbGqN9UoxnK10ZczJYKIl/xoJ9t7eU3ZAbTdRHlFyXt8Lz1?=
 =?us-ascii?Q?pigZ1I/hjM6Tg1a9J8DJrwOPmYHyr2l5ctCvcUWOKJqvSZ6HX5wq+SIwrraR?=
 =?us-ascii?Q?YLKjeahG9fkCszi3lgs2wLjwmUd/NS+4/QBzm4SgbW1AJv8SyRPS1u1+tl3b?=
 =?us-ascii?Q?NSyBU4zE1E5m8waudHYdiTcLKoSJDWMGX6l9g3+iuUPV1UwHp7mFj4OZ1oL/?=
 =?us-ascii?Q?Dp+rvlzrsnlIB3tU5TJobcCEd5IDEcE2EP0GSnDaN3Ro1uewcSrPYfHTNcm3?=
 =?us-ascii?Q?+tfRretP90LfC3+uCodRBmjpUw0Z0Rj+gaWVHdAXWFBtdYfInVAA/ZUKd3ql?=
 =?us-ascii?Q?t8wQXzF8pPuwl3qX6f2+AeUwboifuV8lfeL987iXiBbl8ZCeQvPAQmEnPNE8?=
 =?us-ascii?Q?SoKmuirKnUet/D7PDG0Spc5GLYhobi2xIMSY/jHOFNVpjybETsiKpmP0Q89O?=
 =?us-ascii?Q?jf0NyR8Urwu/zZi5zGaaqFqzbdPrR+vdg/UcG3Ifm/g89Xmi6NxejWK44JOJ?=
 =?us-ascii?Q?93ynFKit9RK12hs3chRJ/YY7Cw1yqkZGIF2a/PAIf0jJ5238Z2sMVAzNsRfv?=
 =?us-ascii?Q?ziQ9XoCTcDuOhNx/DGAOw8gMCX07lshHMTYFOkey6W4hHKpa2Pt6UfUupGMM?=
 =?us-ascii?Q?91iWPVvowK//RwFa7Rr7zCn2Y1hvbph1qnwpS5nZ5BUxqPQYh1zU6odCJ1g2?=
 =?us-ascii?Q?sWWtf9CPN6V3G7AoQqAvJvGgnvzpZ39kK9lxOM4+xyLbQF0Ks2Ijd5D7PmIU?=
 =?us-ascii?Q?VA8xUYda0ZJ8jkyQ4HIKfGJrDyezcttpxSJNcUiBcoB1POfZ0rbMuKuPc50I?=
 =?us-ascii?Q?Se7Lp5Qzk67igkkgNUAZlXdedFeuhdc3Ig64MGNWSIeaH0cXh2taA4YQYP/R?=
 =?us-ascii?Q?M1+BjcbW14xDmICh0JmuTYB1z9z7X3ZZrOL4no2Zp+Qc+vFWhV56xvKfzU3U?=
 =?us-ascii?Q?n+OpDdvi/fSVGq9829QjeRSekXd5Ivad+bsSiSCFajqWtXZBpcxqL0I43QsN?=
 =?us-ascii?Q?7furCYTnlV/GijWv311vN9X/hslwsCAdJzr1WiIHxVWwepcQtY+NW0wLPcXP?=
 =?us-ascii?Q?H4blsc7txt0YQLBeSurzr8X7jE0DHX3npFm9bZ9w74E2WgNIDetbI2mVog9i?=
 =?us-ascii?Q?Z7rwo7Vex/jNvFoTbwWrJSwMpNImkXLaKk027s0CvKeAsvn5OSGyuKqg96bm?=
 =?us-ascii?Q?1LPo6u5mDk/Pd3RLRP5WE2nXWFmskNDn6b/RloIVttaWGkxhhYuA3m/HEDGP?=
 =?us-ascii?Q?ONl0aytJuv2yJ0ju6EWDzxHdtE2N6ZWXK8xEKfAr4IlSgvyqc9gY0NdD9Lh6?=
 =?us-ascii?Q?lXG7hSnjKeydx6fUhSOVoDyuRuWh+S/t9IcD94nVCvTZ1fLWUW+eCN6dq/Of?=
 =?us-ascii?Q?E+k9c4Pr5eL7MBCw8gSO4rlFNTQP897J+A/sbcpUp8JzZSB5rUQzbQrBiPOG?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NKcX1+MRq1dQu6zwDriCAZyv8KycPZn4MpA/MArf7tO4vUkd/3E8F5oct8oCQeC8KO1R7Uu0Mi0cdAqfFSumUdAtJ25sff2gJfu+Vzt4IQztdOwEnX1/Eb6m5qxj9clYkNjDNCw6ceqaCOMHHMXxciUyvKd3vmkfUQlbNu3olYyCc0bRtEmzBBSNaDHmNYR82AF8UzKvnmC+hiXERJ9mQikNBIm+H32PAeN4jCMaygoy58eQ0yTMI7R/l/8ZW2IHqfWR3p63Fkeg6bGqxwwFLqHif7/92PKgHnOSKhWJHhT3pPJ0WEQ5fZKaJRqnZV2PVuai74+OVLzpxCFyYSLwd9U+RWRINjMk3G+bpuUWCNQt0uDyXRAHyL0a1XaWfeW/uxRonYUCCk7SdVmOKH0nLUllk6NXqNyhJEgI6Vk7jnA+EDEEGSFk09MFmIdhgY506hhKnn5O4jzxuolCd46ho5om0wBtxEkQkJmKsdgNEPXlZ8PQwfMDRifL3/WVnfRnUeDoH86hn7SxIGmZ+hON28Qnjg6StU0q2+PJhxawOnxCFeVcWuOXitgu0bNhhXH0/+CdrlOW751m1MivArfTVGjOYz1mqb9HHrHIfxyRnVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19919494-48de-4c3a-845a-08ddf6ad2441
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:16:05.5253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTkvtAQPouRxrhZcQ225DBxgyI4IYZmypJ+F2SC+HByLQwE6Waz0AsS1EACwUtBvtL4Ia2U6WLyxICuLkMbZpAenEjRYl09Ckd9hlzxUSNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180114
X-Proofpoint-ORIG-GUID: _93DMKJzytv2NCka6HKUWz6VLYbs-IGl
X-Proofpoint-GUID: _93DMKJzytv2NCka6HKUWz6VLYbs-IGl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/aeM8BSTdhVH
 uupdFSmWh1VIvK4Tbn/30c4OFmrnnI9chwGw3f44TNa9T3yPB+KiIcSZmPj1bu76V61MmR3jHBy
 V90QO+G1gvzcum5TmcBLF97EX3cny+alu+mzO+BMuM8cPW7JnwHZffCVJIGV1KC4WXLXBkL+/nj
 XwS4BDYUOeSDAcycjjERSp5wGquKFcgYeC2dnAfZ7w9I4LeTv1KpcVwi/KQhrTKzRqvx1jWujWX
 OK1reHSItsw825N1v3a4Dhgz6qx2IJnOsFY537+fzQy+1fp+JdcVNV25h4XHalgoxxJHzLUxBxC
 dk7Z1ZXKIy9ht2kfhZOU5ZHCa8hluSRO2GfjBFHpX40M2Zcrw9NwNEW6qNEp3RXyAdUhFfAAtpU
 PF3rZFKsVSv6oITX20txAY4pVzGq0w==
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cbf80a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Lcc6Uk6zI2PP63mDEroA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614

Sorry mutt hid this reply from me...

On Wed, Sep 17, 2025 at 11:43:08AM +0100, Kiryl Shutsemau wrote:
> On Tue, Sep 16, 2025 at 10:54:12AM +0100, Lorenzo Stoakes wrote:
> > There was a v1 with tags, you've not propagated any of them? Did you feel
> > the change was enough to remove them?
>
> I moved code around and was not comfortable to carry tags over.

Ack.

>
> > Anyway, LGTM so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > > ---
> > >
> > > v2:
> > >  - Modify set_huge_pmd() instead of introducing install_huge_pmd();
> > >
> > > ---
> > >  mm/khugepaged.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index b486c1d19b2d..986718599355 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -1472,15 +1472,32 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
> > >  static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
> > >  			pmd_t *pmdp, struct folio *folio, struct page *page)
> > >  {
> > > +	struct mm_struct *mm = vma->vm_mm;
> > >  	struct vm_fault vmf = {
> > >  		.vma = vma,
> > >  		.address = addr,
> > >  		.flags = 0,
> > > -		.pmd = pmdp,
> > >  	};
> > > +	pgd_t *pgdp;
> > > +	p4d_t *p4dp;
> > > +	pud_t *pudp;
> > >
> > >  	mmap_assert_locked(vma->vm_mm);
> >
> > NIT: you have mm as a local var should use here too. Not a big deal though
> > obviously...
>
> Do you want v3 for this?

No, this is not a big deal.

