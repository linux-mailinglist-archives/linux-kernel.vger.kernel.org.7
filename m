Return-Path: <linux-kernel+bounces-730399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1648B0441B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0014A3B35A2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B53264A61;
	Mon, 14 Jul 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JdUiHQKV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cdTnHB+r"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F4258CF1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506888; cv=fail; b=PgefDRQvtZpmTF5z7U5DGLZrRHR+oH+krZEqJVNCOFz/aTb+Ia2hpw/81JTFLjuCuEek2LjY3a71JM78Gw7q1kRX3heYugmbDwIZ6HhLU970kV5ijwtTKj2HzkrXIQbEMMm+qNXgsqg2zRTI4IqlUTEB9xuFq+6viEEV6VebcFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506888; c=relaxed/simple;
	bh=fIoYzLEcEdkFwkPgywU7gYzDiu2mKtHQxLzUYwrOUgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LvnikS5jD7BDCjO11msfu3q10Za8BzMxqh3A35Hw0cLbG9WUsTiXf7fNu9k+slXQarXLnSsRvFKNAaXMNeM3W614JH8zyXNq+1ZRMWim7+crK0gFbUtcoMLshaF8mEGJ1wl1DmD3mFbF3uH1CM1tyasqOX26YLemgacNTExwLjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JdUiHQKV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cdTnHB+r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5MT031165;
	Mon, 14 Jul 2025 15:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=K5LpSHEBEI6FLB8669
	WCOaXmonYBLBgGViE4iZC2wNg=; b=JdUiHQKVoJ/wdUqrDgKjV1ePMYf/+eYlPk
	AUjYbz5NVOOtGe/u5MWtrf9EtLG10Z2+4quUjfCAWJtYqvE74w5PigBCHrz/HXv1
	od2ZkRp+2YOwmo0aDqWynNqzEpLD90Im8P3xQ8qAH/RKb9GmrdIZTNTmO4igTe2I
	PeSnHbvn3ZxnTRuch4gzrIex7snLDR9iirWqBegyEsVGKTS8J/R2DLVKhCMYTNY8
	/9EZkk1ui6uO1Kg79LBUgIYSUm5gT8G35XZgcWafYt6rN0MaXKBPW9igNtNSh/uu
	sixUkDAyhyG1UN1ZuvA36PEdfYaWPwpuYY+W6vU1QKW+Bxts3amA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0veky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:27:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EExt8J023982;
	Mon, 14 Jul 2025 15:27:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58nj74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FreaYMskPQaToMRqNtvVb6ZMggiP4KQ2uSu9Z7/6JyTdguOWCPFBHcYmR9ikhLhnLXvpb5l0SudBxjPtDleKrvE15FokDi/fecXmJG1AFtTgh4hhCIX55z9w0IomRqzWkreU0AYvD4CPlK/p/c2QIarH9fjFoG2miGD74cMAAh5XJFxPgIyrLirvklyzBd2PXrzECWyZSpp8TMmQobGcXTjwZUsNqWk/LFqTlyP7A0PRfC5JSuSmDs2m8y/PTkEGzDMZ2vSG9uoyTCczL6rBYhBQhmBpja3/f7R0dWJ4n9n2u61QdNo+7b/36Z8Lzxx+8Uej/FN4b3n0/2/jdA36/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5LpSHEBEI6FLB8669WCOaXmonYBLBgGViE4iZC2wNg=;
 b=zHMKnREK2RKAzy5vDxvD+XWwHV/GiINbV5DUT/lc3lNGPfCyXRqcs+oI1I+0Um3TNAeMMDbPqE+mZmfrw/l6biABYdVayOAuyOTr8Vh0Pc4WQURz2xzEkvBFJNuloh9YEhJKqcg8wIq+KADsy3aG8aWOBrSUxuUgVxgFRF3Z2N98ykapPspeSztvxarW/+nf8ImK/w3dVHyl06qbwzqA37ztQ+fmhsx6L6t4yeDako6RN3bC6N1fqKYLqNAj2fsJ0QWD/fhkkVZFiP7wM4sc3scdulCMpJY57aW2+/oaVE51HjPq1EHHl6b+eNmhmCn5dEQtsw5xaAcApWaqLPjifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5LpSHEBEI6FLB8669WCOaXmonYBLBgGViE4iZC2wNg=;
 b=cdTnHB+rNAcKojEyT4LlNiPvcmzTuaVdRv+Za7nBYncdo5/TewLG5jHVmIiBV4ACDkUiM4MBVbdQbfYO0tkWj13HzHkJIb9nQDgGR2ggW2oKdGEyGE5N/F1OyKMUzEy5FWhSWrYyviSrkky94WeBnR7mGxuUpFMZU7FJqEELAoY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6391.namprd10.prod.outlook.com (2603:10b6:806:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 15:27:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 15:27:50 +0000
Date: Mon, 14 Jul 2025 16:27:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
Message-ID: <00bb2d76-4d52-40ec-ac75-546311b8ddcb@lucifer.local>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
 <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
 <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
 <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
 <c57a0048-17dd-445b-8d92-4c8cc6f47d17@lucifer.local>
 <0c78bc9b-8aae-47ba-9679-423d862591df@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c78bc9b-8aae-47ba-9679-423d862591df@redhat.com>
X-ClientProxiedBy: LO4P265CA0117.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e10b79c-8698-43b8-7ab3-08ddc2eafe92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MBxGQ9tvXYde6qWKfU/y2KSbXaVZI5Q3Kk+h0TexuB8l7IscUgihTGcgp1of?=
 =?us-ascii?Q?s6TbpJM1XHHz5MDatFnmpKHVc/BWfNIyBHJos3dClquVL718nkfk/uvsRWmA?=
 =?us-ascii?Q?tCRWR22hlCc0pzauBELKu08X7vbYw5iZBWo2ZTAAZtvBLxOMUlvsxRavGPJv?=
 =?us-ascii?Q?gGqplLvpFGiHHYHs9q25GzIkdI2uPtIUKaLCNDWBkptO/11ofiTScfzVtDJO?=
 =?us-ascii?Q?Wk4UgPZQfQx6knqCwDyN6X3+76wV6vzzQln1HgGUwkwUbgCDs8uL641FhY+N?=
 =?us-ascii?Q?5jt0nvq6rgYDjVtmRV7PdpZHGxiWgmkmWgMLHVFaUjfjOz49+4mU4sJWc9aq?=
 =?us-ascii?Q?qFwZcelQyvIHM4L9lFXlBmLnjORxrpxS10FkDF+EPARbHemvpQXSw5xKqF36?=
 =?us-ascii?Q?WuHIFSaUV8iumOYsxZP8fQ9AbgkqYB8nO/ds8IBai9E19Ee9PQuN7h7Nqyyg?=
 =?us-ascii?Q?d3iXnkK7buLfWrFZEUcoLgh/yv5F8AzBBlsN1suQ34wuXiro1abe3BtcfeK9?=
 =?us-ascii?Q?SrvxfUA4kVmcXeV2XaS8qdU8QccRJkyArjDUkTM7ba7Tgp3VHoFX9OODjb3k?=
 =?us-ascii?Q?uCotDCZFPsGab+hS2g76E8MUXqBpJe9Lzd4yuLO95VfCosjzRu7DSjGvVEJJ?=
 =?us-ascii?Q?NIOOe01IRxz9Wio0pORNxx6+aEyVu7S19CwFP2DdXwX6/D4S2TXQXbfFnFNN?=
 =?us-ascii?Q?7RW/knntwhqvTAwPhCbenlTwyv76ZjyuX/k3Pz04zyxcT0WWxaoCh+qj2kvu?=
 =?us-ascii?Q?WXVoDasNFjavYcAJJKQYaifPL1q+d8GxZAeUKlDER2jzxV//rnHpZUp/3nN9?=
 =?us-ascii?Q?UVGdq2PYXar5FwMx0Rz68+zRBgYk6OEIssdUMFfIEsBRpGesppRFiXCWeZws?=
 =?us-ascii?Q?KuC+xkxBI2ibZXk109Rt23Tw2e+x2gg9M6oHcsO9RjrwD/4gQTc1hf7x5IqG?=
 =?us-ascii?Q?IllG/z0wDsoBtlqJl/acEnmYrbVYd9kBaZZT8BXCe75IZmRR8L4eSd9jNdGp?=
 =?us-ascii?Q?CwvrJAcofWehAXVGiu+EYsU1rgx9AWL7LIFb4NFTekSnjR8Vbv0Z6RWIsSl6?=
 =?us-ascii?Q?Z7ZMVkjcMmb+N2HWmoJWcN20cmN9uqbI6v8kUTqLRjlWqIJgBxbsYPLDHEEH?=
 =?us-ascii?Q?JqwGUD7W51CueHI9dVwEPoGxtOS3ESmMtFQY1+yL8c/cowgID+mo5mng7oID?=
 =?us-ascii?Q?+wvgJdxm+nNaO62/jhlWnKcNE3NVJ85MN+iJ1mhGLcebXrVQ7Rs0sNq7IKL4?=
 =?us-ascii?Q?d1PoJ+G94/DrZ+gzauVjqKGyh1413pSvYlB9PS4htvTycFRgE46ih7bs1UqU?=
 =?us-ascii?Q?DmLReZ3USM7ICxEmlz38XheZAvoG4PFzkCFNHYSTrA9mEz1tDJTgVj4sdLH4?=
 =?us-ascii?Q?9wPBwndhLYnDn62EkGdXI2jqJnYFgnY7gZ00N3rUxOISoTz9t96yx2Fl9mMa?=
 =?us-ascii?Q?YXKkyqWxDEE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Aya77Sq58xnCakqaFs0+TuLv1zhhIIMhUP8LVJr6DhUyhzCnB8e9wnEdjdzu?=
 =?us-ascii?Q?9t7GYfvH0anV45AvVwwUHNThUpTr3v38FOHEgXS937LzBRkJSJJdraFn5Q4h?=
 =?us-ascii?Q?+Dt2F1mCnM0j3DWkJXP6kBfFAT5DcwB4cVdKR659V0gS5XQ5GGUVnBtMsojn?=
 =?us-ascii?Q?aPzZJqXSainRrFnoBjJq4J2N6f6wpbPsJ6VnAGDwKXm28kjjljhFiFwKXKXk?=
 =?us-ascii?Q?wMYDNacjRoObQB/WEpncfzz5S21yfiIXbLsKPxfPcDOmat0v9fFeYHt0UVnv?=
 =?us-ascii?Q?YAFFnytrhO5M70pHu0cW1aB6l+r2obHZCZUXUSuyyw7c0/P1OwWl04RHjCZz?=
 =?us-ascii?Q?FIz1nHBhtHhGUzcWJcKcLkJUUFw6/ipvttVjRseY88s4/yHSosi6PDPB3sbl?=
 =?us-ascii?Q?Rzbx788KtRlP7sUVnSrfaSPY3i8xtId+CP2QjxLf3+b+3+Sv1tGwmFoSheRu?=
 =?us-ascii?Q?uJrPbaAtzcyibd8Hp6vWCLdx6pJbjbNYfDW/g8OQTtM5230ovnuNZmm/0Ncn?=
 =?us-ascii?Q?BPH1xA/Ng4sqYuwKpKwack5uIYaj9Vcr7z2hnaHE+zOxnGXuVz27eFzvn2Yi?=
 =?us-ascii?Q?lt9pwblzN+DWvrQv78gZMpPv2q4tdtT03UjV0u3IiPFcp6YRybVfTcPKfXe1?=
 =?us-ascii?Q?B6OJpJQbiiixdVq5sS8ofKcTHj8ooFKPuqNQVNrya1We7P9cbK7jhVprm9z9?=
 =?us-ascii?Q?L/O+4DEFSdEHOaXjgT+25/2ePlrdN01Ok2o70Ec9YPqhAYXCi32qZ8z5a05x?=
 =?us-ascii?Q?4FRTwOwi+AlkgTDgtEc070nOn/jvHx1TyzTHmJBMgqyTLjzORXY4xSBY+4Ug?=
 =?us-ascii?Q?UyWsjC8Bf+1qHdLA0owonnWECSm8l5lzPLUsXHGsGFQ1vYYvBhaUEzOKov9c?=
 =?us-ascii?Q?tsuuP4my1IzDD5WLnlq1krnNgcC0aJp8o4mijMa7okYOEQXHykROdvszEuiK?=
 =?us-ascii?Q?3DnsNE5DRops67INwOrRiP+7U954UexPzYCm8m9YiopOuGhxiYxe50NsxHg5?=
 =?us-ascii?Q?EBOXTD6tASIrmuwdljj3yAPEt6RrVkjN8NiFjNud4Zl86QbwZX4e9+jLJV/V?=
 =?us-ascii?Q?Nf8INeX0BysSbsTqvGBFz/HXvRXTejK+a1/+tOm2UelBHJarx65s99oI65Ky?=
 =?us-ascii?Q?4RJde1aLiegErtZxe8obM7vM2e/PtUJzJOGUz/XEYKDyETjqEdvgBRBWn+gG?=
 =?us-ascii?Q?/jvRPPOoGf+E0W7aK/Bfs7J7tNA78wjrdg0e0CyqOm+4L2NIy4a7/7YFTSlY?=
 =?us-ascii?Q?6shYhuNcCNwU32ZEou/yuQxWgv95nvvLEpjWbHB0uFw1rxy49uNc+d3Zfkpl?=
 =?us-ascii?Q?KphSk9P8+bz0OSyoHDALVzWKErjH5bCwtyHeCggJetMogXWxgRBWA9YdRVBN?=
 =?us-ascii?Q?T7bmYwu5lF31diAMjm07gOkO0sYpeOlB2cy+wKTQylaeWu9BLuWpEV0fPTkg?=
 =?us-ascii?Q?spsMUPi+a6FCT3h3ELJ4v52mz5388uHoj3F3G+Adb1JfhKkzUXGuUomqnGAh?=
 =?us-ascii?Q?CcYFT2dSECaywZffPDr7r6PoTkkTlxljQH4HYERHjpSPYJpNJluSy0xRDiM7?=
 =?us-ascii?Q?0gRpGJmHp+JDwQVm0723c/ixrAwqv3OyU9mRbhUMAjAqR2hlLw6lPsK1e5JJ?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M4fOgq9EOJpuyGxHpyA/mhfwd173y8WfIIK4Su89k0EL015jE5rkfKnW1HXwEHHhj98pRPBfDYexouLz4tKNO0/T6udn2u8Io6UCULGp9wulMEGB4dLtuqM0/1xu/0HNSVGOEGQbfpxq6a+Filza9lXeq7LSBkNn/jgpEVblGzyUiabSsIDz5tCGgUKDqpwKnQJsLSpbnPuKd4oOGsj5xI0xRSfAhGEU6yrmgQiH8q23MtJtKxt8McE4cGH3GDAeMnSyqfdjdzYFKX/01zurwXDQVesSIdGrwPu8nFqVEH2J2Tky0LK9OPzRWskZx7wAJZd0Hh1fI8w/F7HmmPeG5RXdiKHr1d+GbQSUobNhO7l0zR3cfwKj5/dOX54F0NMkFcyo0wUlEPKwKOjdANQ8qX8KQMolLC7Ra8pXy1QPFVxxrNWqvGoozC9YaRSnymWSQKG3Hfn9m6qen9rQ4zDFSkFPEQlbkoZNhxqhDqKD3g/B6XfbX/URe6gshRADnNCBWQaCQIYyN7TUyY0mwPTrI/PmY6rDrOkTR2Vx7reDb7B8ZhyvgJU5VCLhcqL7/7g4E5Na8wWBC1tvbCL/4wHlP6YyN/gQQfP4HtO7GDBQzy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e10b79c-8698-43b8-7ab3-08ddc2eafe92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:27:50.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0cVHHRu46E036cjPEePEq/zIowqqfufgVDQdLJiCQ4nlRYA59pyYK9ve+NIx3rP46TZhW7ycH1daichtcVcmSf4KeL9+b5CUdG0SkBGLgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140092
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=687521fa b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=ygrBNI6jmQCIpRAbGLQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 0dzaDtCZnByijyQ181QHF2AEOxmW8Ziz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MiBTYWx0ZWRfXxRSQp8YLSYZi ryebtmaw1+D9HUJqh12rgv/JmNcwXVbpQc2BN5d2Vy6n/EqFPSaa8MYZ/QZmxABg09wObO7igJV cRlUFDdKq4VUp6UFnFd3OOjurYUoQZNs+5pnkNMVpiDKayaSQ3QzTnbbbezVGGpCfWwiHD5O+fP
 XeBmLJ0Z7jbnO55EvXIcdfYWXvyzLv7y7XiD/GwE5lc76WCfvQeDaSc1g86XiIzCxq+56eML+GK VynHV2j+dEv95FQKGFMOSVS2DdV+kRY/s4VCMDD9a6jp10kgc2HJYMtYmgcCQZmTp2Mweh3N8NO S5zhP+6cbk7FP3enY2/s/3Vq01O6HwamdwAMqctlIV/HHA8/IWG7NmHqDjYGHJWP0SBvvyI6X7K
 WrL6ZO/gnRJLo7uxjg5OtILIZ+zHDwskZycO9Yq4S4mBJ69Gi8ZfMGH5aoIwDvn8e52jafkw
X-Proofpoint-GUID: 0dzaDtCZnByijyQ181QHF2AEOxmW8Ziz

On Mon, Jul 14, 2025 at 05:24:14PM +0200, David Hildenbrand wrote:
> On 14.07.25 17:18, Lorenzo Stoakes wrote:
> > On Mon, Jul 14, 2025 at 05:03:03PM +0200, David Hildenbrand wrote:
> > > > > or sth like that would surely clean that up further.
> > > >
> > > > Well, I plan to make this not a thing soon so I'd rather not.
> > > >
> > > > The intent is to make _all_ VMA flags work on 32-bit kernels. I have done some
> > > > preparatory work and next cycle intend to do more on this.
> > > >
> > > > So I'd rather avoid any config changes on this until I've given this a shot.
> > >
> > > Sure, if that is in sight.
> >
> > Yes :)
> >
> > > > > > + * only do so via an appropriate madvise() call.
> > > > > > + */
> > > > > > +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> > > > > > +{
> > > > > > +	struct vm_area_struct *vma = madv_behavior->vma;
> > > > > > +
> > > > > > +	/* If the operation won't discard, we're good. */
> > > > > > +	if (!is_discard(madv_behavior->behavior))
> > > > > > +		return true;
> > > > >
> > > > >
> > > > > Conceptually, I would do this first and then handle all the discard cases /
> > > > > exceptions.
> > > >
> > > > Hm I'm confused :P we do do this first? I think the idea with this is we can
> > > > very cheaply ignore any MADV_ that isn't applicable.
> > > >
> > > > Did you mean to put this comment under line below?
> > > >
> > > > I mean it's not exactly a perf hotspot so don't mind moving them around.
> > >
> > > I was thinking of this (start with sealed, then go into details about
> > > discards):
> > >
> > > /* If the VMA isn't sealed, we're all good. */
> > > if (can_modify_vma(vma))
> > > 	return true;
> > >
> > > /* In a sealed VMA, we only care about discard operations. */
> > > if (!is_discard(madv_behavior->behavior))
> > > 	return true;
> > >
> > > /* But discards of file-backed mappings are fine. */
> > > if (!vma_is_anonymous(vma))
> > > 	return true;
> >
> > Right yeah.
> >
> > >
> > > ...
> > >
> > >
> > > But now I wonder, why is it okay to discard anon pages in a MAP_PRIVATE file
> > > mapping?
> >
> > I'm duplicating existing logic here (well updating from the vma->vm_file check
> > and a seemingly pointless !vma->vm_file && vma->vm_flags & VM_SHARED check), but
> > this is a good point...
>
> Yeah, not blaming you, just scratching my head :)
>
> >
> > For the purposes of the refactoring I guess best to keep the logic ostensibly
> > the same given the 'no functional change intended', but we do need to fix this
> > yes.
>
>
> Likely a fix should be pulled in early? Not sure ... but it sure sounds
> broken.

Once this lands in mm-new I can send a fix (like litearlly tomorrow if it lands
:P). I just don't think a functional change belongs as part of a refactoring.

I worry that we'll get catch-22 caught on the (numerous) problems with the mseal
implementation and thus not provide a foundation upon which to fix them...

>
> --
> Cheers,
>
> David / dhildenb
>

