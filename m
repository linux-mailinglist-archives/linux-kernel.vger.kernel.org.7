Return-Path: <linux-kernel+bounces-857742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD1FBE7D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E9918995AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E37A2D8378;
	Fri, 17 Oct 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nu1btURA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NdS52IQ0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC4244EA1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693742; cv=fail; b=fR1SpZ+ZZ/konfev06WF1RWUjt0S0hHpilLkWOeZ6AxOLXXutatBgKILc37ZsWzbkYIejC0FGWyGb4YRiE9qxhMUsuf33rTlM+aoTrJl67vprUXKB9bahDCnz3Z1wuNHDm5wjRjCssywh77+M7j10dwzd0plSJz3iQz5tE+KUEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693742; c=relaxed/simple;
	bh=K79Y90S2k1yDCY8k6tVW/gLXtsgxvHWY2henfQ7Hm5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SgOQDGsi/lD5Eabb0JdHFJuzMhZd07xwY7H2UzuG2OOzzpetE06MSIT1BMj7kdraA1zLOcM5h2f/RPF0LK+TQKXlpw8i7O5T//HeGN2MpMdvGZxO6ppUicMwXj6Gsoiieb5L/+0ThvQpDMsxxEDp8Aqzpabe34ZDUwX9Eapoebc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nu1btURA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NdS52IQ0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7uJpY008838;
	Fri, 17 Oct 2025 09:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=K79Y90S2k1yDCY8k6t
	VW/gLXtsgxvHWY2henfQ7Hm5c=; b=Nu1btURAEEOy+DKh1H5tJtNsBLr0EX1TkF
	oRMdJTL7k0Mj9X4bhq3cObYC/1D2eOIJxKC9dOMXG9T4uAEuClxaomMRHjEDaAmq
	NR1lAj+eV/ug16oXboWHtnTEtKVL3O65qcsvO8Ct8jAQVFS/OfgkJw2kIihIIv4p
	sJIWqbhY9zZfK6Ojkl10He3/n/EXVcC8kRl5TyI1KgEDrn4CwCWePgdBW+GGeize
	kD6UXWEz8OsICo2rguxiN10mvTclghmt22g/S9tyrFD3rrsmRqSBJEovneuEqD8L
	/OqpCWXYM5phxvXYEZdNy/U/MA6ITiO7HURSGeCsoEq+nk0SAcGg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47th22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:35:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9RQmn024868;
	Fri, 17 Oct 2025 09:35:22 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcuug3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfkVD6Wh/U0/BqSQF5g6idFmwlI+RyljZ91OR1cRSz+hzxQ7lP+NABddxEApm2qXRy3EoDSz2i3PZ61RxFX35buJszqtKuFfvr0iKUG4WELPSV8AbTw89zpk4DRY7d5k7HoeO0YNbIhg296Ku1q9ODy3HLA05/WGQAyq22BHNMBz5WPfM5uvYQ/FsVdOBccIElIn8Rem9kbVYsufQyFY8ztOyI8KX+DlPoghQg0G/PmUhSj6t1pDOAngNTCjUum/p/PoJ1QnW/4DGVzD8rGg6rfZS13jXpdYiJ8AIvW3GWhBLn0Foj0VIUSMWJVhetsxzxKZRkjH/9bkCqNU6ZzwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K79Y90S2k1yDCY8k6tVW/gLXtsgxvHWY2henfQ7Hm5c=;
 b=fkdTE6vApQli/xu23GJjTNv8cJTlpZLv8Dz7nGSYygI/prNUV6Qv4pcifYCcG+k7paVnJXsFHdRmOtl2Lv+iYY1X3MRbak3f77YHJaXazN03WZGjsn5eZp93Gbj5XyXJKNpK/XWI2z5L5bvgHbS+VxPUNFnlDT/emNBc0ATe8LXn+HqpUeBB47yz5IU7rBoo00XQIifJ73iXLFoluDivVxmqDZzJqVI6uOzibaShojCu8JVp7VYo9NzCeRHru9WKAU4bcOPtc0KwLIWdjZRGxOV7EwZ6TxCp4IlllqQocKcg3C3DCiDwAuGMPP7p+R2SusF6ifibER5FrVrDl8kYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K79Y90S2k1yDCY8k6tVW/gLXtsgxvHWY2henfQ7Hm5c=;
 b=NdS52IQ0KjbFFhQTUIjff1aXugKoV547DJL3Z56YiNwm6fkoBidK77kmF7kJi8I9HN2OsUfSy5Wu16+yZXmNoHQz4gN1QCnOCwJ9fmuRnKN5BaowOsQ6x9SYoGo1Aq09diSJit1RSnSXMC1+qeVIFBnY0nOpf+9Mh/kgibhrL+o=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7036.namprd10.prod.outlook.com (2603:10b6:510:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:35:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 09:35:18 +0000
Date: Fri, 17 Oct 2025 10:35:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, Wei Yang <richard.weiyang@gmail.com>,
        Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: guard is_zero_pfn() calls with
 pte_present()
Message-ID: <43364274-ffb4-4a7b-9d99-3bc809fa7631@lucifer.local>
References: <20251016033643.10848-1-lance.yang@linux.dev>
 <17c4c5f9-6ac8-4914-838f-f511dfbf948f@arm.com>
 <20251017012724.4bo5oj2g6tdmp2fv@master>
 <1674efca-6d4e-4247-8b1c-b6816360d8bb@redhat.com>
 <ab918a83-edb2-4a19-821d-a96de9e097eb@linux.dev>
 <4a7a7fbb-e33e-4033-91e7-efce7915cf7f@redhat.com>
 <13b41a39-cdb1-4537-b4c8-940674c5875d@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b41a39-cdb1-4537-b4c8-940674c5875d@linux.dev>
X-ClientProxiedBy: LO2P265CA0229.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe2df03-0771-4a49-204a-08de0d607c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?udeZ53QwdxNYW40jgwnMa7Okwy33/SPC80zZUbtgDUPEcXmZlz5adbnjOAcn?=
 =?us-ascii?Q?gaygg9ya+lLHmPk5Se1CYAjtkV5neRiQ9k63sCikDrf++VvEpU7VFD8zme4e?=
 =?us-ascii?Q?+XGVj8YzZ0gj9LKjIMW3nswcPredtlUtOMOHDFEbZnrM4uOBAFxk4NFvbnLm?=
 =?us-ascii?Q?tlhOdTG4OwfWDS+GLLs0x65ty5r8GqQvMwdsI4GwvJ1cvu26qR5VCRWq6K0U?=
 =?us-ascii?Q?vBD0NjPVib6t039wXV9fO5k1h3UZ6gK3U0ywFvyAdCEq1IQeCa0gEbhZJbje?=
 =?us-ascii?Q?yIdU13i7hLZUufadhr4MYOCWRKBTScpl5jB9LGfhvtLQiC/0Ch4yTCvmSWF2?=
 =?us-ascii?Q?k0bvQn7sbhAtV2QHAgH7Kj+1fMtfU7h8d4hgcaieNLXKUVXEtgqr7ExSdG1f?=
 =?us-ascii?Q?WDhzxeYN1JNo+fm/y7slrXiOGevUzHaj1KD73QX4qdLdxN0o0g9Fqto4UyAZ?=
 =?us-ascii?Q?shRNn5JSCp6oHP2xHtT0k6rasqYF0vHw0e2bvfZi+Gc9pSFchfZ0DdElf1bC?=
 =?us-ascii?Q?McVpnRqU++mjIaeFah9j0OhAzyug+QSziPdfUc4AJfhGQcnwdQuNwVNo77jW?=
 =?us-ascii?Q?SOuOCpdX6AyDFhD7F7VOhmjekzV/ZUfOstBisPz4MbgG18WFp9ceISb3IpyX?=
 =?us-ascii?Q?dEb3qqDD2oahQuhVsFL5SKZYyyEtTHIlCNBZULLkJenk/A4eJJEen2eQ3HhF?=
 =?us-ascii?Q?0tfGxBJEazFbfV8WP/3GTiygwDeE3q1Ya6Jdnjm7nsg5OnTQbUgE9MO+wvQO?=
 =?us-ascii?Q?RY/zljvFpuUM2OhEGGnhRyZGCFNPGziLBwDjezFJOfD5jkwhf4u8naoIAEAP?=
 =?us-ascii?Q?vIiOAjqqzBmrpd02Wba96GTp92bWYZGPQ6QPvFJIYfKevdOaCWUdl85Ln09u?=
 =?us-ascii?Q?83sWyIBziSLYZqu3kgjeHVezBA1wwkKlkrjHUCfhFr7lfSiIsoNvXDiLB/a9?=
 =?us-ascii?Q?wfCK8PHQGH/JcLPtdVm2cSdzuUBtev3rhrgjmbcNl+EXZMHLqeJ4Y7FM/lGd?=
 =?us-ascii?Q?9/E6e5d1DiuPLkSFeUquZNVY1YMdQVPDq3hSsLzB6t0cxiRrjHuJdKAWcKZ2?=
 =?us-ascii?Q?49zk9qd7O1uWimx3DUBLrXA7yrUhFM6J3w69HnkiJwuYJE4zElObGxzX/1OT?=
 =?us-ascii?Q?Oig47WuEzmkOZQrWxvkwm1Ii5RsJG9ehDKuELUncG4QE4l8eTjxlDbRB01vl?=
 =?us-ascii?Q?eBXkCTNkOjTlke/jLXlyd+oZ8vSyTQDh32LHy9cJ4HgBHZh64f+jZ/Pa6ueH?=
 =?us-ascii?Q?UgBOphCsyCQpC3i2YrAkzBlITUy3Mqq3anARFC1HkHupFA1D60PwXx7wcBqm?=
 =?us-ascii?Q?VaJ0DIi+w2O3c9AmnrkbJTAg/20TZhut0xkv+IibUa7e3JpH8NyXOsqFrty8?=
 =?us-ascii?Q?eDffZFNdu1oZWO9mMCyReH1/gSfNUac956eqbgqlP+D/l7eR+fsIiAvcUygq?=
 =?us-ascii?Q?3LMK2OMVlCfA1O/NBLMPY0JFCmVq4N/3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YaHyEdaHSeYtsz+qtBQP33XoFCmAalcZUigLruubPZd5S8fCumtkpD1ctQjA?=
 =?us-ascii?Q?Kbk3Sc8sI9T5qtWV/nZikjeadSgWcNtk9eHx7YlT3x0YJwZeHaERxpTc4hAv?=
 =?us-ascii?Q?eNiMWgtd7J0mHvqHYBobt60ZSYbF+/P4bY9Dz80zpBrOGMwMmdzwbv0NuIIq?=
 =?us-ascii?Q?dMzl8YXkH9GvD3WlyjLRheJltWNl+WGyPZ8OstymPa2XACLhU160s1c4u/Hr?=
 =?us-ascii?Q?vvmVeQqz8FE9PZSp28LKzxSl4GjZq81jZb+McGof61+8TrCBLvigGkkmYyP1?=
 =?us-ascii?Q?aZeuCwM8AmD7jNE1vFW2mFjl41lGzGKNKe7am7QfquZICBiieq5xOiVvjn7A?=
 =?us-ascii?Q?4zx8kz/1PP5C7IcvmKQh77WUO6I+KMqdps4WbjpjiL/jwBTrEJWij0NDbgQn?=
 =?us-ascii?Q?0YZw9SF7eMZWgLCJPcwB7r4x7EasHnIM9suYDDTTUteUwCBK/Mueo5y0V9NQ?=
 =?us-ascii?Q?luXpR2WmYFH0y9nnL9scob7oj8nQ+9kjtQIkDYdKv37HP1lQ/sC5ZKAXs5E0?=
 =?us-ascii?Q?t4JWo1Y/sOZEiBZ4tWAB82M8Tx3SrTyUAdtFc6oW+vJAaDwigPzgxwYt4cBC?=
 =?us-ascii?Q?Iv6w4GGJYl+R08zxhMcIz0gbxJFo7gyen7S3A2IN8YHpV3l025d5JhOjl/+4?=
 =?us-ascii?Q?mDDch+BdCj0uuzBK0NkAzc/bnT5AbdnTnsBlrLMrEtPVegsgPUtojp2sTTEa?=
 =?us-ascii?Q?FHNAyphmcq5lXPf1exfjIg+7eafEAOCW/McjsubedML3kW/KVwmI6gODaQ5j?=
 =?us-ascii?Q?hejKgMtwYIhrE8EmcxYSjqlqmzq74evCLALW0OIxFj4AQJM/G0S88oqfDEcb?=
 =?us-ascii?Q?NvHRUMwfCJp3kHb/uNiCs6GI7Dzl+Puyl5+MFnU7gf0mL8HC51lfXZO3+uiy?=
 =?us-ascii?Q?CXALYeNJbIaYZ7BTyJmLAT2LQZDInUzQTJqKgNQQHgwBCqEI+045IB1Ja/A9?=
 =?us-ascii?Q?6nQB9tSr3ebnyLLvhF7PpExOKtCX9dZlwKzjZyIrDjvp+Nfgi8pm75DctM4B?=
 =?us-ascii?Q?mUSxAF4cI6ASiHcZh/1KKm4/0f4Rxcakn9NyVcu0eAcx6pYRQdEd6oxTJIvk?=
 =?us-ascii?Q?KjhelO0z04X7eWeaG6wm4pzbP6a0QMXzicFz7ZFpgWuhNiBF8nuqmPM6V3jQ?=
 =?us-ascii?Q?RWTmZ6cy1/9QWm+31Uq4YCO+8M6B9GzgYQhXIpDrhc+3HfEjeh1PlvHUKJXT?=
 =?us-ascii?Q?9j/ulvKwtvUOQ33hMaod4I5YWoSg0tJY9A4nxoXh9BGKbZVVpTOAFwhcG8qA?=
 =?us-ascii?Q?bzZfNdI9OQLj1Fpq/iYfup66fo0ZflE0Oq7EJm7VL/OZtEsa8gxcpcSeK7pH?=
 =?us-ascii?Q?Lni4X4fl6isNf0HtqLbOCBxxGo9wHlZUUJbRxeR/s4oO3YABCbSNJeDoPK+f?=
 =?us-ascii?Q?/gb1qitWU7t6Id4t3CUnNK5WI5a1/Dlvd7qWfAX7QAVHE/YdPO5zCfNNzzJl?=
 =?us-ascii?Q?r4dQBUg92AMlDmwBwmuwAIveiMo+1HfJdB6dXcnP1ZHTY0X9b5QycIAJ7/G4?=
 =?us-ascii?Q?W52DlfsIK8DfpqNx76JftwhCExpjp+fIeWxUBkShLqKRMvTan1swwXedgAVj?=
 =?us-ascii?Q?KRTXu4PjlNw2hj6g1wvc25n5XjCsYXPNvI81nAmLSk7jRWE6yXBWV50Na0qT?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DKH2Cy2Lk0SsWGxlioqTbvjwOCKKgiY43UrEhqupF5O68QNXI8jaNlNjKhi8ksmunRRMftAyG1W1OR9xJPyAjm9X8b0lm2kSXSFm6NaFx4dYqldH4iG4u4fABZ6stX9LKfHtys5mIywil0auijUkn2kpej85NEPB/l+l9B6iA3jAg9rxD/2NzjUSkZkDgZx0lAkopYEct65gZP1L+XqQFX8yJs0UpCqlbsRNNm1vmjs3yqWE+EhpgyOj4pHVWmyKZrP5yYRJH7itJTrysFOQem8cpzaQLpz4zuWFvqV+Ydkywrqyc3uEDfjT5UU1sNSnjVfswk4Sn05y8cN3BT5b1R8oKKJWUZYZUDGw66mC/WuxHh0YI9K5a5Af1m66DvuJzZuchAKX7uZIWPJxfy9uKRRlrcG515ejz0ALad1IUSlluavVSdMjDD0vIvznoDZOpsSest1Q0YAtInqfr7jBycSS0P71zDXA2KdNe1Tv9J3tqFl8p2MrJzPjQkJHE0I3HdMWEVqXxWUlsqvz6sQnln+krzsc1Z8a+9Z8ZyM3l776t3b2uefyyzuCeH3LRK52qWGJTAn2/wuYS9gOu6ySvg6XUvGqQL34X0BA3+TT4ZI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe2df03-0771-4a49-204a-08de0d607c07
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:35:18.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhB+gIuzypzkf43aCey0TPyKcuoNTO1T6U9INLP7cDJGiQrF3xJ7xa9dmD1tZhWyavLDBsVFfCIoW9afzXhI2+RYbxqkIb+TUTX9cgFYTfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=616 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170070
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68f20dda b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cLgezK3H8Ga14nr-32QA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: OtlL8HQYkf1WrxiFDWG_Z5n1P1bGZQ3y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfX64DQX7UyacEj
 7iAqp9Si3D8q1d1UDmGA9acYS1c3Tbb4AwEybvSN9bDVydm+79RCVfD4YcM3zixzXeHIsac+hlz
 TFYOXtgy0mqczLehPHKyAqpIFJZHU6AV2fLpnSmaQcKqT1262y7/iXrPgPh3Tv0Rc1qfjtioqL0
 UgzcELYZz5eo7El0RqydewScoc1uUqvFESm5YziQnBKZ6dSywo/TU2V+uxDr/snfQpVYOVqVs5D
 1b4ujZZ8vl+JEUx+w9uuEZ4TF9XNpvz6dzjdKi2YzBEWZG1bchjr+xXFUEDoXWS7KZFuSGXXw82
 LmacKggfomEbkk1SINZ0XN697Oa4U4Nt+R7fdw+qZ5P8v7+gzey1liZIgknB1+mOj4cDiLc6sxO
 3K4iSD8H+rlArkZfvMa+wzlapwiMDw==
X-Proofpoint-ORIG-GUID: OtlL8HQYkf1WrxiFDWG_Z5n1P1bGZQ3y

On Fri, Oct 17, 2025 at 04:47:20PM +0800, Lance Yang wrote:
> Sure. V2 on the way ;)

Will wait for that before review then :)

