Return-Path: <linux-kernel+bounces-753164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A73B17F67
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C14F7B561C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716652253A7;
	Fri,  1 Aug 2025 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xmq3UX5b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bSyOxU7c"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F0217F35
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040862; cv=fail; b=Q7OKHAK3hAAfW9apzqHWOeN96QGAyadiaq4q3/6ni6KEqjFEVZ0qvLEhMJARZM/4ONUqzaGRAZWgQ8Fm+ouxUPKbQgHnSs5jYs14wN7w9Nh4SwhiO3dMnbN0fsS2TFVQrGVnS+sfmBtiP9E2pp3rrBSb0vpVr/AgDPCtj5HcXTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040862; c=relaxed/simple;
	bh=IZVU1U1dk/OTiBG2TD40EEfP++jq+uF4AKO3ovAb2xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mLN/3tx/Q7tFmw8pP6FUsji5RVVJ6ZTOR06pd9mbWc4d6oJijEMZu7acRkhbDR5rUB2Uf/eq8wY8ebEuduFwPzS/O0rgiz+x12N6VcCQ2WRXnHzYkJcjUdW9Zx1FqB4+TxqTqqdJsejXzzJmDF7KEOKlWw5Dsgm8TCveFiZOPM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xmq3UX5b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bSyOxU7c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5717C4Rh004668;
	Fri, 1 Aug 2025 09:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6agWMEqPf3vTJbhFPm
	TknOSvau9LoHHwiu+CBkc2lmY=; b=Xmq3UX5b8QCOCAbk3+TbtDFqN6bIfgfSzm
	c+s7dDIQ1/CsX3qQtz1IofaVDNZXyxPLyb/an/ht6HDtLK5ySsFEM9MwDFsdj6B7
	3tPQf2B/CUpPU+jKudkvKYQvomB3f0Q0dQ0vdoXJFtr2M7Q2Lp69z0U39UzNuF/L
	qRt4HpH1qadrXJUAEQHAzv34wzCDigbTIGOqjqPRZ5eip4ZbfWs69vNKwjSBzShD
	HrKlsFUzCHB9fBxyuwAf+KO5fF3OW/lXByZvQzEb7DCv0/k0itfH5dEA94vDW5mh
	OuC4lDVKTJvNzal8udH+wEpGbgoxJxvMvkFt51hGowG1WGIM1NaA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q29x1uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 09:34:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5718o9Aj016818;
	Fri, 1 Aug 2025 09:33:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfkxbmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 09:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5XkGNdtYzqlgPSR3S79SVItwa7TCZ2mh+L1y3s47TG6TM/N1sDEluP9MdLak7rTaykBZtWdDmvfPpVIV/wSdCoBnTGCKAK/XarfwZ2PP8Sv0W//KzKgvR0BMnM/VBVM4ZUJk+dvrXYO3t1cGmdFU3JZL8dijFL3kyvocru0/Hs4P2Rqdpnib8ut8cgBMXqM+7NDKxQA60jVVkIV4CgHX53/1QaZxnUKB62EXmhSiNFdwJyl0Io+Q9kD9sAfJq2GVl/9mE+iaJuC4/RGrmcPVQuk9S9ZVGZyMQArOzvguZ+kt/wBGYpCxQY+wPaedLFx6DZuW01fdv9si+04OpV7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6agWMEqPf3vTJbhFPmTknOSvau9LoHHwiu+CBkc2lmY=;
 b=f8YJ154Q5KEfBI548tNUVAiZnoM8bNoVo20ta8iHW9TzDAw8RknNcMk1l5dMRztfplvwGOJ7/c+5kIDwGX+TevGte1i6d4dd3Ws5XF+ClDDuQRjLtmgH0LOxTC45EYjG0BNKCnr48YmyBhFWXNf6oW62yeivALP6voKTYpvM8cdL2sWtji3QyyLggkoB2j8HnebSlX26rZPRtrE4ebIsCp7jIPDMqwOiUHLx37hzpdldpr5isny3IF7TMBf0uvFfajIXgx4/K5hMBzrP6/yUA1B169feL05uJsO1dNWP4e0g15BNFF/V5KEw4zkYwvS+JpnPIflO10Yc39fbYSopSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6agWMEqPf3vTJbhFPmTknOSvau9LoHHwiu+CBkc2lmY=;
 b=bSyOxU7c6VH7cPXc9r3GXJC8XYjM7j/DkWulWp7pGIETL/LR0EiMOSuw5KTNdGqVuHYZTiMyn4zyfBvp/mkY3OCM51C5k/PZPT26wFCct5c5LCNcHH9Lx8n6sHTyIh8Ms1A7e62J8v45vP85sRpVpLWhgYU58NcmTyEL+WMpBEU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 09:33:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 09:33:45 +0000
Date: Fri, 1 Aug 2025 18:33:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: yangshiguang1011@163.com
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm:slub:avoid wake up kswapd in set_track_prepare
Message-ID: <aIyJzh2-0YLydvlB@hyeyoo>
References: <20250801065121.876793-1-yangshiguang1011@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801065121.876793-1-yangshiguang1011@163.com>
X-ClientProxiedBy: SEWP216CA0050.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e547e56-7eb3-4606-3969-08ddd0de826e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PD0gpCaXNW35QjBD1bSAzoqHqRAiA7yYtR1xlFZh9zbW6Fw/6bKGgltrzy3b?=
 =?us-ascii?Q?BbH+keSmBkVmKc/YQiGl0Evc+91u5uxuuCdDCeUMDubDm4Vy7z25E2VkFzph?=
 =?us-ascii?Q?56/g2OARr0TlpMtnfxDKOz9g+bFmXny2zX8CLarF4vGsWEpECqbVtuyaUBX5?=
 =?us-ascii?Q?npKWWhQnxX8L1YShcR7HlBrhHsRa9tH0CRRtq2byjw5IFdD5dLHKiIzi+Tle?=
 =?us-ascii?Q?ETNqEvS/sFaNFimZAVsSoFZZ0myMxiBQaoqC9RYtLU41+wAddH7/Sr3XYHLU?=
 =?us-ascii?Q?gWfCuaVbEvutynj4nv0uKv8k4TjIibi/Wj1M5dcBCHnoLEy9y1nInlFj4lNv?=
 =?us-ascii?Q?V7oBVfyNfvvIANC/lnuZ8q+iP5yNUTbv+9Uwq+R9Lkv07MDycntpXhwx6S3H?=
 =?us-ascii?Q?kqjaiDGsTh4cvN/uj3mim2HQ4ObjBftQHiMwIUoY4zPH7QBuu8kDxHYu+xiZ?=
 =?us-ascii?Q?TUm/BMjut02pMqKdFXLEm9NOYQulj00Pfxj+z1Kmzuo2IJ332d3ZDbxmDvfj?=
 =?us-ascii?Q?cxgWHjfhYm4DXdnEoWc10NlnCAE3S8vSD+8QLysPnkVGaOJPFzCRgzEfOnzy?=
 =?us-ascii?Q?d1jdtm/eCUmVELdJX3gGPVonshwJY+K3BXTz65HSn9Dshh5qWQnxdDGtm/1Y?=
 =?us-ascii?Q?wCt9TOXJM+0piLdJcA8tIzdmfJrvhjnKrvJxYSCT0Xfzzt0iUWJFkYIkTxr5?=
 =?us-ascii?Q?JDF8LNhwVZXM4z4KSRfysqOnQJucymuz1WuOeQMsLSdLSXHcwCTC4iN8xkDF?=
 =?us-ascii?Q?rDpdYllJtjveq8sV1kFgL1Izn4jVMfkmpmpV0g5hR0tqC1VpSj5JscTfCC5v?=
 =?us-ascii?Q?6Q94Oey+1CzOtsTepymrP4izbnmgIP2lfDw/jC00TRpJpsJll5SknkgOsB/F?=
 =?us-ascii?Q?duNYb7BDSA+h3ufFjL3ODotKMvak+Adsz9HHXkn4LfKX07+aK8M/w/yZXzU3?=
 =?us-ascii?Q?5IBCKerhoC4iCoL7p22SmYXaqpxVwz73SXCTUsuDXpCFCIY+I0EVGG+zLEgz?=
 =?us-ascii?Q?1/Y65F9BcUzsGpdvdHFvpyyFcQm+R7tiqEywOh5365OA2gVBa/5NEK5tQ5kd?=
 =?us-ascii?Q?SMTYa7MjEZRRDWapVmUSIKf6vkf+IEXqZ/byyTE3MC3kcaxhbOz5uzBmFdwL?=
 =?us-ascii?Q?xygJa/QZyyn/ckYB8CTDMpH0b8T+KvYT0BL0iAkysQtrc7teoywuJMm4sfeJ?=
 =?us-ascii?Q?bRhXQXoIcyMhLD4dVSkoP2ZlGIpxIFHPLL4eA7vgH8+RrlS72nmVvJO7lRu9?=
 =?us-ascii?Q?CcmdOG8BBMRcc5oEBXrBnncVpvQzUwRuIbCTqiBn1beOMbdYn4KMkALpI2PE?=
 =?us-ascii?Q?dJHPLnko+/yf4y+GxwGp7HSHAUSu9aTQjMrxSK3ELyDVEn9UJCg++A/h7lmI?=
 =?us-ascii?Q?EYYo+lmaxQdYtW5ZeXDfnj18eud9eqc3eoH2I8xt2ZAH65fjyFSvNm+l8hnG?=
 =?us-ascii?Q?SUxcgH0kj2g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BiTFysI7oz2b3w3/fcgllb0myspdzhdXLohsHGtcc7RIpJQA7Xr5xqE8JVhq?=
 =?us-ascii?Q?ExojXXGvhplwQD8I/yaeJtJ/YlrahplBlyhaMUiiEybu1Glci/Sj0AJDKHY4?=
 =?us-ascii?Q?7gsc9sQe67MXxEsywvgIXjzUGFM5SRIcu/ofN8KwUBnyRsE0inQWZ3aOLbEn?=
 =?us-ascii?Q?CKL08SI8rLiT2n5D2xXTiy6JgjCNxKtSSfc3N+5C3dpyU4QtNgb7W2M3Mu1m?=
 =?us-ascii?Q?g9f3CFl7x5KsRLITudnRf26QgKYlFJ2vGK0Skj8Iz3qnJS6jZjg+kKBEdXmp?=
 =?us-ascii?Q?XFnZPnBiOwPvwfwv/8TQfv9T7B2PAiVK32Lt95LgYQIFNnxWc6hEfbVeshNI?=
 =?us-ascii?Q?7vMGm5TzKgzescVPCuFm8sjv87af1g1LuaeCZrrvXyqGJ7vkpkGkmeFoLTfW?=
 =?us-ascii?Q?C6eAVeTjaBZHX1E4WmuTtwToTuNcdQ90SxgZMXGRwjEL+ElDgSBhMNELu1B4?=
 =?us-ascii?Q?nxEX8liHBg18S8i/DbA9xXsLWf4E+bFx/USwsKXj2li6USF9kOJGqcaeNrkV?=
 =?us-ascii?Q?I1wrZxjYoIaYCq+8njgm5dC/kq93zkDrZdHZpvlZHh7W4FZFw+NJD6tia1fy?=
 =?us-ascii?Q?9YZdmXbRbQRYT6civXevJF4F8K0s8Nsr/kSYl/x/2+ZUfAMeziyHX35EOHta?=
 =?us-ascii?Q?Krba27yITbNdupgPLRnq4eLaq1t3jTKRiVPcvm4/kLDHQD9OfZWMJMI5JFvr?=
 =?us-ascii?Q?pQ+I4pzA5A6bc5aNMdYbRAUY+uqR/X/nSla2QdLue/AFDqXjaNdzzO3zioHh?=
 =?us-ascii?Q?TVWi5IyFYd/bxZ/+sLdjbXMOrUx1uYinYMuEzLxnaY9HUtgLurCWtxWpTieI?=
 =?us-ascii?Q?gByGJAyRrsB4O7Eg6ReOA7KPQVrkr+thMgiRpI6DtR2DAVTSHerlMuuYqgt0?=
 =?us-ascii?Q?eF2jetDXE/5IOzG/zzcO7dXRJu4k41DCmNHxVD1loGUOscOC0f39v4iG7VE9?=
 =?us-ascii?Q?1FIFV8hL8DH9DUgNfYCB44IHNOEx6XjoLhlXynhVeX3Um0x+9DnhRUY1AiRm?=
 =?us-ascii?Q?w2bR6bDjVfYrEVQtEeKSg+hW7JU0c0ZWmokTaKCS6uURWZVdHdLdsggVJxHw?=
 =?us-ascii?Q?AcaAFg2KTvDrFmg1ypWf6RAfnoc5tlUM39/SNqFnkbnmSNdG+VOxS7myErER?=
 =?us-ascii?Q?8CKUDnkkIHZ0WE2xxSgr8kjAFk1DYTAhKvRr4uw1SdWs3NCeq+VW8CYCpSXM?=
 =?us-ascii?Q?TOM3ziaHbtp82Ajfj530TRMX2LbeoWvWrxCUGOrDxo/3WEp5cCg3iU4iNY2r?=
 =?us-ascii?Q?5IkIWaLZmtPhDpkFld2JSf9hpMtamYUbb0HcKDCNPVseuylYNXw4hUElQRop?=
 =?us-ascii?Q?a6Qdu2dAjqGnPYbdqfDp0P2IWdSQo/V1/538t97vl7VO/LPvtXboOywifUZw?=
 =?us-ascii?Q?44eMzmQrsLu0JNpPPlY+OfzOKJtoDufx1NHJ6ZGwz5euEw9v1yl6wmB9pW7t?=
 =?us-ascii?Q?n/fSgY7zMcWQnhh7M4OgPCvpjdz0IN+Xcfhelp4ZYW0wu2o+NC/DWcutApwS?=
 =?us-ascii?Q?dNd/MARjxQT7s+NJDWhIdGevSNuUTlvVqcAbFYvH17p8dVVuY1HKv/q3KqI+?=
 =?us-ascii?Q?MTbjcSrrYo4PMMl8tSeGoGuB0veCdxI25nezkr2K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IgaTRroMSotR+eZswLZcYSlUjx69Yhm5id5R8eDc1d2HqLMPTD+HQcKdnfT6L5hp5uf2CA2bF93F37YHgc8irnee2Qsg74FJe4WTHBBdYUWjAs4WveAeXnZDMx1FI684F4dz9vO15CuIjIaSGrKPOuN9RuXs10WEV+Y7mv/D98vVD0jlThq5LOIJ9//nyZrxqdMpIh1xtHOtbW26wmuriQ9y/3bAHBJy7p4faMpD8UpTjZcv3+EQ9cyWYzBpByUPnmKJ7hSyIguUZkk4RevtGbevsVp9cxSqBoIJby275oIFql+bJFsuurImlrFWwrUq/yxs8tUpnUzC5PkHw1UUoLRKa/j5KQMBgG6p8BO8qA0cff3ydjszqY0sgbSM5Q+h8rZBqpIsRERv+r6ntu2+noXakCrBmlUj1WEr2iSolqj45exr3IuEryJOW5nqcXLM93x0Hmtnsfh9NYPQK4hYp9qMKBAvxPj0Jh5MDQBaSk3akiVE9rrR8wn1jTV4T8DqycELnvUKu2ntygpWSrs7f7DviOxKRAyM4eFxGUbXtINyZ1E/iOA6QdKhK/c5BvKI7IClsGUPRXMyi8CZGrJbD8/Or52bVCtB2M9flM1Xfw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e547e56-7eb3-4606-3969-08ddd0de826e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 09:33:45.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zJAzeFhSA8kSqHmLM1jPskkkQhrMYn9bw1WarI8II0tx8rnevqoNzVto8Jg9oFvXu6Mc+Mww53ED952qMZUTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=916 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508010070
X-Proofpoint-ORIG-GUID: fF0kan0gLyE1VRARu8Yi0MMdk3w8Im5G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3MCBTYWx0ZWRfX7HIc3q1vNnMS
 gA7BsMKMkc4Dkyh/DSndEzcV6jjbZ2WwYSvD6Y4VpN/Qe7O3M4aPbumuflrvTLNAtgGmptvCA86
 HRHLQ7i39fzzdwVJ8cTn8I95LNpKmR5nIudhW591r31xaLitqzB0IOd4CfqauHfeaiwK6kgkXtp
 QbHLRGs1J1VxterCk87BMs+9DGouIVOVyfz2k7jDFKgon0Wax6vsv15asElZNVF+4T9pd5eCnM4
 3P4u+A+/gTjFdKefzh/B466UBRgLuprxFi+KCu81QGeniwOqpqoOwWnq/3FL7HrUg4IqqeiJ7Bn
 exoCSPJJfL6fAKZv9VB+5IOnN24SFeRR6ILPs0c0RQVia39FU4KP6mjMzywUO/jOffX6396nmSJ
 aLeHHZ8d1VmJkf6MzUiISROHV51Qz/y1Iik+Pxf42f9DfRatx7tFy+OzK1k8tIdck05+qGzf
X-Authority-Analysis: v=2.4 cv=FvIF/3rq c=1 sm=1 tr=0 ts=688c8a08 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=Byx-y9mGAAAA:8 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=iqgLsMefjjMb8ZqFiU8A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: fF0kan0gLyE1VRARu8Yi0MMdk3w8Im5G

nit: the subject needs a whitespace between subsystems and the header.
"mm: slub: avoid waking up kswapd in set_track_prepare()"?

On Fri, Aug 01, 2025 at 02:51:21PM +0800, yangshiguang1011@163.com wrote:
> From: yangshiguang <yangshiguang1011@163.com>
> 
> set_track_prepare() can incur lock recursion.
> The issue is that it is called from hrtimer_start_range_ns
> holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
> CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
> and try to hold the per_cpu(hrtimer_bases)[n].lock.
> 
> So avoid waking up kswapd.The oops looks something like:
> 
> BUG: spinlock recursion on CPU#3, swapper/3/0
>  lock: 0xffffff8a4bf29c80, .magic: dead4ead, .owner: swapper/3/0, .owner_cpu: 3
> Hardware name: Qualcomm Technologies, Inc. Popsicle based on SM8850 (DT)
> Call trace:
> spin_bug+0x0
> _raw_spin_lock_irqsave+0x80
> hrtimer_try_to_cancel+0x94
> task_contending+0x10c
> enqueue_dl_entity+0x2a4
> dl_server_start+0x74
> enqueue_task_fair+0x568
> enqueue_task+0xac
> do_activate_task+0x14c
> ttwu_do_activate+0xcc
> try_to_wake_up+0x6c8
> default_wake_function+0x20
> autoremove_wake_function+0x1c
> __wake_up+0xac
> wakeup_kswapd+0x19c
> wake_all_kswapds+0x78
> __alloc_pages_slowpath+0x1ac
> __alloc_pages_noprof+0x298
> stack_depot_save_flags+0x6b0
> stack_depot_save+0x14
> set_track_prepare+0x5c
> ___slab_alloc+0xccc
> __kmalloc_cache_noprof+0x470
> __set_page_owner+0x2bc
> post_alloc_hook[jt]+0x1b8
> prep_new_page+0x28
> get_page_from_freelist+0x1edc
> __alloc_pages_noprof+0x13c
> alloc_slab_page+0x244
> allocate_slab+0x7c
> ___slab_alloc+0x8e8
> kmem_cache_alloc_noprof+0x450
> debug_objects_fill_pool+0x22c
> debug_object_activate+0x40
> enqueue_hrtimer[jt]+0xdc
> hrtimer_start_range_ns+0x5f8
> ...

So some allocations can't even use __GFP_KSWAPD_RECLAIM (e.g., eb799279fb1
("debugobjects: Don't wake up kswapd from fill_pool()")) and
stack_depot_save() does not respect that.

> Signed-off-by: yangshiguang <yangshiguang1011@163.com>
> ---

In general,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Let's add Fixes: 5cf909c553e9 ("mm/slub: use stackdepot to save stack
trace in objects") and potentially Cc: stable@vger.kernel.org too?
(It's hard to imagine use both configs in production, though)

>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index cf7c6032d5fd..14e3bac0c6ad 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -969,7 +969,7 @@ static noinline depot_stack_handle_t set_track_prepare(void)
>  	unsigned int nr_entries;
>  
>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> -	handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> +	handle = stack_depot_save(entries, nr_entries, __GFP_NOWARN);

In the future, perhaps it might be better to propagate gfp flags to
set_track_prepare() and pass it to stack_depot_save()? That's what KASAN
does.

-- 
Cheers,
Harry / Hyeonggon

