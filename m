Return-Path: <linux-kernel+bounces-821362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619DB81117
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE04F173898
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09BA2F9C3E;
	Wed, 17 Sep 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R0Kba0Y6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dWL1hC45"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75AF2F3C3A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127362; cv=fail; b=s9vOLUpvVrC5s9+mBQ14mxOSXF0ZAf7rnFQ0QU7o2EWXLL9Vp2sQPhxOtv7eqgqd1URq1PL1Z/+Pw8QmzcpXZMm+ScILFoY8iREdVukfzjORDgOiPTxyR67n90w2qJqdms8z0EzI2Po3cdqu4FKeuZsqHSO8UtHwHTggtiMymr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127362; c=relaxed/simple;
	bh=bkD6AH0SbIs9h/1319jcsZD6Zfz6LWkbeZmqzZXGLP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZSjdh2qzM+4nyu5O+EnDOPGwQ04dyvySjxDP1X73wsIlRBgC5gZv1loHciR4TDnhplgfambkZVRteqGWX4yFOtQEIe40+6BYwHFLNFpfmmNCKXxBwkD5nvcov05jEB6CpWmLG1+X/ECvNwWN3zAv7P1TQ7Uf7li8SKPR3n5/HPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R0Kba0Y6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dWL1hC45; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIexf019087;
	Wed, 17 Sep 2025 16:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8gQVJn2m/YLKGXGlCZ
	exJEle+1AqU7FTZYSKCZWwcME=; b=R0Kba0Y6PtkYRbUa2hOZjf/xrhzrrk7Nd9
	5mFfsrIM2WF9d9oFP6Ll4/5vCjklpJnHUYMvJCWjVXbKAlem3DouyEX4H11Lm3FU
	b8srfT3akmpHvI3HlFEppO2330TeVzbyupGCcH8XA7RFqbUyrEK5xIVFZgLgPQmP
	04jon3IsFz0ZiZIVBgAB/nJRQB8ShMBg9Ywu/MHRBelH9sLoqoT7knOxEN8AZvln
	/MNbc+92ykxxbeINQW2AwXDWlS4bJrjSzmbdw1G8g/16MxCOCiU7n41mmB4jqP79
	2f3I0E26/fcbj9KgN5qk5/gIemKhngK4o3fHrV1ABVxJfek/Vnlw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9ss5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 16:41:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HGNtJX027235;
	Wed, 17 Sep 2025 16:41:23 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ma1cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 16:41:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywAYHnuNF2yO82AZa0TJyguoLJjIoEYArIor8U6mMTTfLQLuU2Ag5AFzL6nOmbr+0kd+pauSqODyUpkfDXX00K6CQy8ZyoAioZqqRCt5cMnPtVIT28JehQmcOMWYhd18WTigzCPwVmQdb97zLce06KytkTmP1CQgmj++daNqXBVT4n+YZD0vEVy3eoSzPyRxfrRsaJpSAIfHq1O+2Yhc24ssdcckWi1goQNRlPHS/NsltjmmA/hwVOOZV7pdFj5r32Xre7Wi+rHqo+HxCS1zpJdeL7HDS+Qc8y2GR7YY2jYVsUU3iZBjtRfQHYrR/euAGp0MCaSWFI9awTMhv0vkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gQVJn2m/YLKGXGlCZexJEle+1AqU7FTZYSKCZWwcME=;
 b=b4bRdUP7DXBjEMT3OwwqXO9rBgVSkJ61EdRaKGY3ULcpV0gnwJ2mgow98MUkILIwyfT0gab3HCNgfK3SazadauvyfL07baHVkSuEv+oRD5ZNsX3H6+7rgm777uvLwe5Qoyu30+5hIUPLy9Ku7er8LibYFgQcKU+wYvB8Y3UHPeQgCFieXt3bzFstzm94jLjThtjXmOWaR1FRCEzRH65lEWxkrybV0mfwgXISwHDyIiJrDMuA6lNRdSVnSpdVIGRPOSWmqzY4fPniIZQLOEnD2NZpWAx18QArXuw/Lb9/54EPzOzGC/Cc8C3vJc22LVlrmMIRQQ93brG8I44AK5curA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gQVJn2m/YLKGXGlCZexJEle+1AqU7FTZYSKCZWwcME=;
 b=dWL1hC45/VXCD+txZZc2FA0/9zMaBYmuhRo5jftdnwKEpond+KW3zfdKKBCqnCfAsGlf4to9WjQcQusZKNzMTXJZZV/ArKeU4jq9u/TbFJ5FjynJftn5V52+oycr5XDkC3LKmN44uUn1458bVc1SwThOpCW4U3OYZ1gYprMRqsc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 16:41:15 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 16:41:15 +0000
Date: Thu, 18 Sep 2025 01:41:04 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: alexjlzheng@gmail.com
Cc: mingo@redhat.com, tglx@linutronix.de, jroedel@suse.de,
        linux@armlinux.org.uk, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
        david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        urezki@gmail.com, arnd@arndb.de, vincenzo.frascino@arm.com,
        geert@linux-m68k.org, thuth@redhat.com, kas@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org,
        Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH] mm: introduce ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC to sync
 kernel mapping conditionally
Message-ID: <aMrkoBhIcP37YgyS@hyeyoo>
References: <20250917154829.2191671-1-alexjlzheng@tencent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917154829.2191671-1-alexjlzheng@tencent.com>
X-ClientProxiedBy: SE2P216CA0076.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB4752:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ea085d-2976-4f85-837d-08ddf60904d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tOnHpxJzJQkXtlNALLvaF2/2EKF9ps00fvJ+mkb8WCdtgd+sALHeIpS8oFX6?=
 =?us-ascii?Q?rXYAHY2gOn/gu9SsYsUUuJ5RQpkbSpxL7cHo0+qcOGe6ykr5KMxWLPOTKq6g?=
 =?us-ascii?Q?tp404Ih5FHB2wJ9Te07ehaxDJJ9Oc0tXnY79x2nSou44q6xyXED6Dtlrelpm?=
 =?us-ascii?Q?faiTGFqSwKsQ9PBpyEKJ0OU393yvrzqhdlmSXXt93XhO6flgdmz3vXSQW0ut?=
 =?us-ascii?Q?eKdwMTOhXJ5NopTxOyEWuuXjPBY9ZEnt47SzC+21kiaLrZg4dLqMtx6f7Zjd?=
 =?us-ascii?Q?N0EGAPw9lJo2wdmeEWecoSqhW9nE5sEyHxvPR0swOXY/IX23qZLlbejVSbnK?=
 =?us-ascii?Q?iTpn9ETL8OGjV52g2Ku6H4D8HKFPK1DEfsMf9YE4q1zaaiKIb37jlhQP0qu5?=
 =?us-ascii?Q?1KW0P+O3XX2DDE3Oeghg/7CM7lcu3gZeOT6szPq3D9Yl0NVrd79hW5SUPYLJ?=
 =?us-ascii?Q?S2Dj7CxR+h8yel/kSkC6eDajldyhACFrJIKhFeCv07/+N2gVycLr+KDFaG0x?=
 =?us-ascii?Q?6fKVetH/BidL9j+LfeCDhQ4gjHHpbO17AUkaOXsGpccPUljm8/jlGzQW9IFU?=
 =?us-ascii?Q?lqPsJuRoEbKmx5iiZRAijX1tkZZya/z7JJJkNXMpv2dWzH2Wqu2sUjaA/Ped?=
 =?us-ascii?Q?c/AM1QdSO9IeuNmvdX79kl96OhtzBiYlH2JEW5Mr/ajQWIBecr8bfGXtYlMm?=
 =?us-ascii?Q?VmM74h9+kF/aNhYbEBmT3rf+86wtP6aZYV349DyLgmKCpD6wtf/TNWFcfzF+?=
 =?us-ascii?Q?Wasauv9Ip/8cfsQvD7sJ6ayWzZIba2XqQWDb8q2FlmWWNxiIdI7UMg3WnZae?=
 =?us-ascii?Q?9tcg8az6H1RaxhYohvOIY3D70yPUzofviTbb6HJavBYE760FsHSiUVRG8WDA?=
 =?us-ascii?Q?K8T5SvgC5Cpy3lqcK8DWJAbUin5S+vD5JKSC2qvVnjUsDhJkzzjzla36TQKM?=
 =?us-ascii?Q?WHcoJ6ueYoThLr9/WHeknnhTAaiLQc7rmQ0CZ+LSsHgKU14BpJDImzI6AidG?=
 =?us-ascii?Q?avs+ePz+GNKatZGDfrVvm//jm26Cx6eaBaXYgvPmnhePJ11ftm1/1/nq/2Yv?=
 =?us-ascii?Q?J8SkhvMim84gaxA3ILlx9aVlm5HajiQgdQ5+EGWMB08AJ1kTNcQX7ccsV+Zm?=
 =?us-ascii?Q?0x9M84q9ASpuf40adI2oEP6X+2zQOJFJROK392djotcZ3gJiNB/AXV3p/qAD?=
 =?us-ascii?Q?AHhdL9lkMhM0fRtnwD5dqkSjcDgipuhMi0FahvLhR/R/jnN7i8WBIp/JSXT6?=
 =?us-ascii?Q?zRGoxKZxuOdqy6GOPPWdSX4TMzwDo73Hu/Ygwm3FIQGT/nw9YJj6gCJNE8kA?=
 =?us-ascii?Q?UzlTKqzOx0zadRbay97vCwywE6UGPuiK8yKsEsY4bAtTKQZKdepDgRtK9M7G?=
 =?us-ascii?Q?2dNfN4lsIyuD6zB+AR44bZ106L1xlCgyYTxiM2CMSsv0n8YBBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?230lhMBuAwQbv/p6ckkniH+VXkeSzBlYiwluJeGtGBFRU9gU50UH7Ns4d9G6?=
 =?us-ascii?Q?ifMhgcqm08KD/h9Wq0YMJAfclOgdo6ujSSg1AB8nZLCH5n8YwvYR2YYbRHJ/?=
 =?us-ascii?Q?jLzkqF/oHKDViCDV8Cte+zaPoojVg7p5UkbAwClzZmZ4czRpPVk/Va5LLxBC?=
 =?us-ascii?Q?jC+GTQitGdeizP5s02ouG0S7BAuMPY8s7Yi583Eyt1SmK9O92IyBmcPwTFtW?=
 =?us-ascii?Q?UG1PcwcACH93Iv3Sn/+812RKGc9mnsa90poyXetF3njwpD4RjPnWGkHN6kak?=
 =?us-ascii?Q?Cbi707Qlwz1GwJSlGT3b2PjVgkuJQ8urVW+taHvJzpI1V/UCfhftgyXIN0Rt?=
 =?us-ascii?Q?Q/z2UfRRiIvr+Bz7BLznniOrK5wYRqNS9oudGcwoYsLHnKJ8IIDu1vqdDyjv?=
 =?us-ascii?Q?UzBLzvkCvmK5c1iblTCkVL44fedWg2gHFRzz8/S8bWQkSpUO81YJjuPhd6cM?=
 =?us-ascii?Q?9dD3eApAAT3F7Bh1JXn7ouIMdE9sPSohfA4mn9n1xq5iaQ4vBJXKCENgFSuU?=
 =?us-ascii?Q?7MfyEDvuxqJpdCpd+tnTJPE8ZmRNix6qEzsatvBhSBdcJCycaD6lITWBrtW7?=
 =?us-ascii?Q?A3TSYOdibJzpHD0f8hpSnHEuZxW6vv10MaAEm+TZiKEPsMjMWEioPzhpB0Wh?=
 =?us-ascii?Q?B1/0ZVM0qhFF72gXNYVpoaUaLQaeIZGQLyG5ZHu/gYBBdp0Ukc4L2SPWLoiV?=
 =?us-ascii?Q?/AK5KllsaxqrC098HhYl7VgH4rkEnlUGyZ7TpTJiUL2WmQw2hErnn8UdVocn?=
 =?us-ascii?Q?KClpSwbL4pjH6HHksAlm238GGbH9zck1szoBMW3ZOXmlgfMLH2+P/3vZmEpM?=
 =?us-ascii?Q?bz1l5pmi3YIvedzcsKZhwc/ZkFaQy6iyGaU38F+tsdRuIkbbpCZOR1u4aEbE?=
 =?us-ascii?Q?AmkZ9V0gzWJ4IZMyGN7SWbHVd83dX4PqAAM30FkwuMCSmb+EvlfxObpGpRWO?=
 =?us-ascii?Q?G5/GlhJYeu1auW1e5ZtjDwCyc1C99ZvT/C/k/7Tw5+xbkyavHVsIXdVmDYxu?=
 =?us-ascii?Q?Q3FOge1zooU63y/f6zopXMrdifeHthNiYT9ohRcYxWLmK5XeiwjLb4yKTajS?=
 =?us-ascii?Q?y3iKxlpsPDMi0g8Buy405uk+1PpMXL6FiifBRZRssytklEKChjgWPzkSHV5Y?=
 =?us-ascii?Q?45xSqf39MFZUGEtSipcUgU6tXO8neEvRbFB6DAE7VdoqqT983Njzvwq66nN4?=
 =?us-ascii?Q?94JxI0azqbxvMKQBwZLdfeIGtsxnoCGlL6TnP3GqO9oT6XN75F0L2Nk7MYQN?=
 =?us-ascii?Q?OahZsJ5ooGaQC9DoXLRjHbXyuynUqabo88munaJCfTRUppRVSHD4mWxWwfpK?=
 =?us-ascii?Q?jANoGaQRHUHz/mVSHgnoqXZk/l26+yDrd3Glqa6i1C1jU27DFW/c9I6c4LIV?=
 =?us-ascii?Q?sDBw1id0j0EX3q+HhOFSwJlNG9XFHqIiBNk5yFmgGp0ZWksPjpscHUnbIahK?=
 =?us-ascii?Q?JueYXDSZjHWV+g0N4iLOikCjta1WkgpFU/a7TqsDz9LAp/ACj+vu+pckSHyc?=
 =?us-ascii?Q?Pf9bDL8jwyZdgHEuypP1xXS4+nZG8Wg+hihu8d95A0zBnpFC/vAHAbhpujMK?=
 =?us-ascii?Q?JwqAajyNbHSYweAPLvpMswkZvqH9tjRTbTtsskJH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BfG01FuEuEGl33uLkCbrL4AU/g+MTtxuzko7d1jV21V2CDkBm3sHU+b7l1VVyKTE5pIDiRDv6R4v/8215E+4f19xQZsaGGIueK0SRg1hpELd0Q1qhX8dqeJtkp8TwmSGwbrJqTNQzSxp9t2JhsPbDQyGVgDYoggiBB7aepAvVWzVVE1r7NK//2mriQUepvxHLWN80Qm408gGryowi8J4Hc6DK7ri2kRlBh8tA/IlLGRtgP3xOSLfCUI6DWzHSXcryrNxWDPobaeNsuIssDDmr8vf5ufxDIwQLZfk4AD6+DmoV39pnKUGd33WmXKZ8GrcH8+Ax4XYJfvlak3meAHzQmCW30eoL9OEiUyOmCAbOjHZV/JRrdvVibnqC/9naC8zovtvUAzaRCNCj+XU3YPeGGbmKZ7PFXKLlJkrvyhTIoe0hhV6sT1hIJ3hRhNwsnjw0jCTcSPnm2UxVDs18JsLbCRxo4duMV+jL1kNdDVmmuwzbBPoe3lL08o2sYAB5pkjCKnePQrR/clQhhDj1GpISbBtBprBCw6vcrFngGtbwQf3ExhZW/BghbJ7WWZHapUXySuU9me0+2oFlVkivtu+YudiZeCcR4ijDBuaEOEhEJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ea085d-2976-4f85-837d-08ddf60904d0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:41:15.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNSVvxCBpapcp1Ks0LGKDN78U1JKQu62SitQ93EsvoGa3R/9jRubWSI0BvG+pS95wB9ekWRBizQow1piigFBWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170163
X-Proofpoint-ORIG-GUID: qI_YrX4uvg807SGt35pebMz3WId29vds
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7U1mxwZMQXZH
 yXHOz4h1C9wM9mVxKHF+WBUdn0MpXpEi7aDDCcopse7CMarQLJJzsyp5oLMUIS6pwU71/927+B6
 lfjq+lpmjgk7c4dyqNdPAi/sdSV3y7UVGbsXI87BpAFNW4pYLihf59J0GeI3VPUfOqMZI7izVuP
 GT8NY1ANehsWIh3Ir9glwtK6fAVyvhrMXSy0pvXldEMQKGirJx/YlLtxsL5l3Gp9DPPnuW137fk
 9KGWxzFV6ETnR7LrddHfOoTDAXqRp3b1Pu43+j+dBZB/f4JJKqp43Xecss/qzqg6JtD0GJ5CDR9
 u0zVNBOT3Pw/s/+u9kgUbxNAebOx7DLVdSLKEf09ktbjukA0QjGKYTm7Qm8kKi7H952xbVUgMpt
 UrVlC9CzdjlCpsWs2kbcsbR59aMvGg==
X-Proofpoint-GUID: qI_YrX4uvg807SGt35pebMz3WId29vds
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cae4b4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=GvQkQWPkAAAA:8
 a=2aeQa92CUK-n9qrS0UAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083

On Wed, Sep 17, 2025 at 11:48:29PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> After commit 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD pages for
> vmalloc area"), we don't need to synchronize kernel mappings in the
> vmalloc area on x86_64.

Right.

> And commit 58a18fe95e83 ("x86/mm/64: Do not sync vmalloc/ioremap
> mappings") actually does this.

Right.

> But commit 6659d0279980 ("x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK
> and arch_sync_kernel_mappings()") breaks this.

Good point.

> This patch introduces ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC to avoid
> unnecessary kernel mappings synchronization of the vmalloc area.
> 
> Fixes: 6659d0279980 ("x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()")

The commit is getting backported to -stable kernels.

Do you think this can cause a visible performance regression from
user point of view, or it's just a nice optimization to have?
(and any data to support?)

> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  arch/arm/include/asm/page.h                 | 3 ++-
>  arch/x86/include/asm/pgtable-2level_types.h | 3 ++-
>  arch/x86/include/asm/pgtable-3level_types.h | 3 ++-
>  include/linux/pgtable.h                     | 4 ++++
>  mm/memory.c                                 | 2 +-
>  mm/vmalloc.c                                | 6 +++---
>  6 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0ba4f6b71847..cd2488043f8f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3170,7 +3170,7 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
>  			break;
>  	} while (pgd++, addr = next, addr != end);
>  
> -	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> +	if (mask & ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC)
>  		arch_sync_kernel_mappings(start, start + size);

But vmalloc is not the only user of apply_to_page_range()?

-- 
Cheers,
Harry / Hyeonggon

