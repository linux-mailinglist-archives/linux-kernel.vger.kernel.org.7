Return-Path: <linux-kernel+bounces-852952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE36BDA540
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87CD85074FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA59301001;
	Tue, 14 Oct 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dLRotRWW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qKGPipIq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69E2FFDF1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454848; cv=fail; b=n8w/sirv+rZfGKlm5JIeaP62+YzHl63B2pP2DttIO1O/Em9eOvavg6uY/fhZfu2heKy0xrVvIdk6CrpVm3JcQVXW6rYn4jmMsCceQToP+y5dvcGMG+xS4/FuuiRbXbp4zCGgb/L5/3fFNFWb+7YgGiaBbJDnfCq8skerNrNdGRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454848; c=relaxed/simple;
	bh=C6JBfQKJJql7Hd9bNQfqu4jIVTYRLHjx5lZ3QBp/4k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uIPqc3tn6UejZkcKLjIXWh3bCkcWAX9EA20cjkhIAYzhKbzNknozLLf1fSXMuvWIVaWzCrehZpWWvPCUUE4OtpBAb43aKSnh4Vv9zFAJqRqSjeL/bhh/gMYrNkBlFcp5dAMTJ7P26xMUfBmy3rkGhE2hZ3UwjNrHmKLQvkEV06A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dLRotRWW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qKGPipIq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEfBh4003173;
	Tue, 14 Oct 2025 15:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/pbLSXhypBcKoj4GgL
	9CSDisFFtLhXQvnzUOpQjP9Q8=; b=dLRotRWWYSBxi2PnnTTNRMV2Tsd+asWSzF
	5wLCiJMpq5kJYMXl0jUcJJZMcN8NkEaDJCY7p2msaPodAg0zAwIojKyyrhi2a8MM
	1PjpCqpxQzU2CvrCsBxFzOCaK190b0sOCnH/J1z7im6/XbeRIv2ObFQ3YGjrQyMf
	rHx4OOJv4/OUSB4iACplAXCBEYGkhL/CP8D+kjZOG1RZGgzdlqYR0i0M9n1EVk68
	AZugI8gpRD3CF96xSG/uG9oYppn7sRg9jiuq8OBFuZAwJLPwbVbNhsK4STYxtv03
	4YGGn7/lpSoiqjnRtG/cCEj3mFaD8dM0tmqZt6jkk6kCpPB9ZQsQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59ckqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 15:13:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EDbbwH018503;
	Tue, 14 Oct 2025 15:13:32 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8tshn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 15:13:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+k3fMxWsCdTBAPS51Dwk4JDw3N5ax35n144I/UVotQsJzShO1oC0s4jan10XuQzxRhYmTLVXizpLqRLEMKIFugdXdCxZK0z4OPCx5tntDHRe6vELgLqhAMCiwDw/eESFEFGv6okxvkwteA4xDLLN20Nfz1iNwV7GPYJaSX2Pf0yLN6PpZEs76Wu4jGQ0O15QWs7a0YigvNGYY8U8u0EwaSUp8o9CsX873kwnqcu51ExZAcVVcqgYnNarAaMMiBILFucXmAj6KQ58OWYJgvt/3Gqg/aYReS6VhtmiJ49puUMFafaa22QSHsnXKSotgSbqFcta4G6TWBgfJnNkV8Kqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pbLSXhypBcKoj4GgL9CSDisFFtLhXQvnzUOpQjP9Q8=;
 b=csYyMRrVBLTxGlrkztN1BBthXrZ6hiBK5DkWNVMZthhOfOZgkyAetk7IJGxDaY8WRwQA9RhWeAEDDt6jE4LoP3qo1vDd0wDH3rk46WGvxnBBnIUif+rSI5flpcnIB/rbKRhA/rMi8+PZnVpaH8DriBJFBXup6RdtymWCtkTaQoTo60ufkRqcMgZOhFi7exMr2l5fQp2/dKcbS/+/zLu8QEXg2ZE1mj23zmN9cFZxTOnfW4RDbf+0GFVsM0XFQkplCbodv+lR3CDHl32JhfQdjvUry/hyWGqzJPw0zh8/KaOm6x2AIRK8enGLlY6qh7ijf2yPQAfiOult21Iq1nqMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pbLSXhypBcKoj4GgL9CSDisFFtLhXQvnzUOpQjP9Q8=;
 b=qKGPipIqxWXgHW2KIuTloMCSPJ3XdwFxLp6Cx/QVdDpQZDjCblp5rNN8u4qbv4hs5qrNYSq+HnPfGqmMgJPOFsM6OwBFi/Mqv5xoyQta+dmTzpe2ZvD9onBkYrwinHL+gxEK1RMxr46Whj2/1uheDXFZdgoVGLE8ixlXyyqiaQs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 15:13:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 15:13:29 +0000
Date: Tue, 14 Oct 2025 16:13:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <yang@os.amperecomputing.com>,
        "Christoph Lameter (Ampere)" <cl@gentwo.org>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Yin Fengwei <fengwei_yin@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -v2 1/2] mm: add spurious fault fixing support for huge
 pmd
Message-ID: <e32bd132-4f55-44ec-b9f0-a9e13aa6c5a0@lucifer.local>
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-2-ying.huang@linux.alibaba.com>
 <4c453dcc-2837-4f1a-905b-3462270f5e31@lucifer.local>
 <2861a35d-4f8e-4ee1-bd11-b915580c9ce3@redhat.com>
 <86bb70dd-2602-48f3-a683-5ec62b37fd46@lucifer.local>
 <313d2c86-d13e-4f79-b977-81a43d685cf6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313d2c86-d13e-4f79-b977-81a43d685cf6@redhat.com>
X-ClientProxiedBy: LO6P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d6b164-b2a8-4fc1-d4e8-08de0b343b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x7qPXzXZLHaU44uixCx/NoDTLmlliP9il9Pcw89yEnUjGRMzz5qOBcJm/5qe?=
 =?us-ascii?Q?ziTey3dZelngSdslibS5BWSH4BLmM01epnQiDkQ9uV2+SQhJ7Cz9Dv43Yp01?=
 =?us-ascii?Q?G2edYd2RStp+UaFmZy9PH84fCK52OgSl5G7jSY1VLvFrYtSExS9x5wgqvlww?=
 =?us-ascii?Q?hMcxkrg5islGDVr7nvltTrpF08LQFz0lNdeyQO7f7W6ZHQoZT3QWgIc60VU2?=
 =?us-ascii?Q?RxkFbmOasMODgGdpMCEy/mlcU4EcvKBseXuobtcyF4u7bPZPxqAffAFRvlWo?=
 =?us-ascii?Q?iSZ8cf5wPOVEMUq+8HmYrl7y7EeC0DveYsYU5HK3w7Pv6qhKcUOC0aEgdOIi?=
 =?us-ascii?Q?Sa3uqCqzqnkZyfuR4tHw3HddeojHn+QdszNVZCijoxvLWhrt7g/Zagerziw/?=
 =?us-ascii?Q?Ijv7CJigpB5kTS62binTmacreemlabNtFQ+eNf19Eh3wnp0HFWUu0K2Prsml?=
 =?us-ascii?Q?DaytPiI0luz5svUv11VythA7t0vRGKyWGU53fq0870c/fVz3m1xzZIx+P9wc?=
 =?us-ascii?Q?yqt4POGafjZTNL0oAarV2lFxpMbOr6Y7MQ9w87ZJzNMNFyv3lGf8yrL+NYgz?=
 =?us-ascii?Q?b5XgJUN+6VBNnSxUbIJ653RZ6cmHH9HOzS8biF42sv9CWy0Dvp5tlyWIHQMu?=
 =?us-ascii?Q?QvtVVU+qZ4h5WVibj8T2HDW7sxrVvKQzle4EVaFOD8UZ3hQF99dIz6/4loK6?=
 =?us-ascii?Q?NrgFwCHIJlRFKbnF6E3PV2+w68oVN9DR4x92h0k1nLfyBR3KD/sRZhaAftQT?=
 =?us-ascii?Q?c5GqX/YPcGPwjo3Dmb2zgKO6fEn6Z4piRGZD/cuq+wzfU1FQ4p82abZRsfNe?=
 =?us-ascii?Q?8Yv8JWUiGBdqVXbcdBVbPD3kljXeakc31RFzPghwWnagF9x18hKaM2j2Pb8u?=
 =?us-ascii?Q?bipZ8ydQQnsrAcOLdEY4XePMCbtZTtJPmyV681LnB0tiZTPsa3Y8C4eR3l+a?=
 =?us-ascii?Q?DU1qRYbRdjwzsRQvcSqnYLSZ1Qmz9Pfv3dGEF5rEGCqw2teYiImS7DBGBs4z?=
 =?us-ascii?Q?PP48lENtkEk+s6q2zgq3Y/h/yglWm3FJCOOvU2OMjIyksnA2Unm8jzLASffD?=
 =?us-ascii?Q?jME+2FaGJDWLjFO3kIX9/tJsG2sxkZhUxmuASheM0HT1x2libNAeTcQE5HBn?=
 =?us-ascii?Q?E61OqiPdoMoIV9WQd6D+o+CrBoC9IvznQdkLXiFDwjJErseZSLlwcQiCaXi1?=
 =?us-ascii?Q?A31/EYLVO7HFUeyjuURnJI1XRcIj5bdIXAuIjYtmmTcNNlrjpg2jqQYDRbP2?=
 =?us-ascii?Q?YTG+jRZREaRxThgTRm53aOITsYFuBrzf9o/b6priH71nKWxGJ6fTNVMWjgEK?=
 =?us-ascii?Q?35JoVj7ds6Xy0frwXOsZd9fNZmTg4khDS1MzXWerxssvA8ix2goohiSy+Yzl?=
 =?us-ascii?Q?GW+LoKKCHBGW+Zgra3+JFT20f/Na/LjpHyGxABdaOL9nvIn8+cDULORCP2NY?=
 =?us-ascii?Q?z3JNkrZrlDi+p6brhGxbxCmzxsSvvosq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o7O+Ft/xhpW3pQOfNGV6pcfG2uBi914IuxeVRBbzAb6N/0K4oKueWC14G8Wv?=
 =?us-ascii?Q?YqPz5d3qDEjLaW6BKsZT7I6JRHcbnxVhh5JUP8aferzat/520B7ult2Zic9n?=
 =?us-ascii?Q?13AfVq3iQX43lo/n9/h7MMufHazDQyQi9jXrLBKmbM34Pq/4oyCzuUgy/V1m?=
 =?us-ascii?Q?wYg+2DN7SMG+TE6r72VtsdUeuNq2RhJwdO4scdAz12G5rLlYtOJdRWFAdVl7?=
 =?us-ascii?Q?eSHI+o8PT2Oxrw4NkkxtecjIAyqtJkjSzUyhAeEos8TrLURmljrvRlwXF4G+?=
 =?us-ascii?Q?U7h5ILur1ZoLVXq/bk6CyhV7bldAseXTKFeeuZpM19KX94DprO69oHDTo7IE?=
 =?us-ascii?Q?3e6c35Bux7P5I7YUaAwml1CRo2B/ZIeJnaTAsgMchiGfuTNCO23IA8kRT7JM?=
 =?us-ascii?Q?r9/zqElxP7iqWWnH7YCUvtnyXhMZbTrkVyPDVsnw40b/iJIQFA7EDvx13q3U?=
 =?us-ascii?Q?nDYM3w2POyDz49pmblfo3jrv/yM0PDSHpOq75xoIPFyD5AMCqR0qmO9AqiKg?=
 =?us-ascii?Q?D+QlvBPFmoRLYH2DjEDvpgS6iF/3L3s+SKMQYIpevcI1WFOnsvuoa0hLYUjV?=
 =?us-ascii?Q?dYWIc5561jG8pvQQv2wZkU9QFaqivBrrOQmJeJUpTe/U946T5DSbNM7CapcJ?=
 =?us-ascii?Q?rpyuLw9+waM6jU1KG5usP940S7Wr8XUDXHb/zmWsPNjhh/71NThgfOTzcka8?=
 =?us-ascii?Q?D2tyH+VvwoM5YCUug60yKWXNiliKjh2loGYBOEU7AFhMwc3dfb8lHrq6Mmpr?=
 =?us-ascii?Q?x/LYSprmO73tZBsPU67sJCuEsXLWR7agOJqj9+Grzu6VRd0ryh9Vj14dFHfe?=
 =?us-ascii?Q?DdOtEndIlPKFV1ziMKwmNQr/KB8rCBKA8kOcUlkPfKqyFAcEAr/FcCKfeGdQ?=
 =?us-ascii?Q?2Y0rD5r5HxoJb3BAIIfB5MWZpMfmexefl4mutmn+VovUnWosJx70TvhBBdYT?=
 =?us-ascii?Q?r/cuJ+uT+0pCKspqxXB1BRQaxObcC/esXyoHlZkQNhNUosB1ZZSyrey217hd?=
 =?us-ascii?Q?iJqDMSRWCZYq/q38SSRT+7aDvfUoLFIVike3QePjRke3qXvWYpXXzaTN81Hh?=
 =?us-ascii?Q?RsySGYAyFlnrK5gsr625wn9oDcZKfRp2BsM+ga6tWB3qusoUS7yV7Y0zwGBp?=
 =?us-ascii?Q?2x33lAdcX99vPkdsNzowcfr2KeyZoY8icFnZgBdf7UcUfv58psUOHZVVlX2I?=
 =?us-ascii?Q?jagED+3bTEBFQBYXm4CH4LahymTLoJdsTvJMAdBQ9/CM39Fc8J+jU6ZccaQm?=
 =?us-ascii?Q?RK19RvPsJu1dgl5q00V5KIZUMtJtp2DYhhbja9WEcVNtcPwZCuzpSGXVxrQI?=
 =?us-ascii?Q?ZuMngnQcROn/vFQKHlfOMa4pdHoeffThdm8RjLbepvB8is1EJgQM2yGztqgW?=
 =?us-ascii?Q?6oWcvV5sFyAYZ45eu9nAhQZJpBTYXiXEqtIsoMoj2tphWuf6gMI6EJKMy1zj?=
 =?us-ascii?Q?MDg5d9cFnnqFdNX125NpToFOZaDEoRMNAUEckcB1nlS5vcCOlb2lWZ+eUUqD?=
 =?us-ascii?Q?ofyk2NoyW2N+Z5sb3Qxgwsx2zS4/oPjk1YOEGBShQq1wtaj7KOkJMfHM9vaP?=
 =?us-ascii?Q?C2wxIZMUsPG4LqdrbY0Xhyk+Dgbz2Y222gljCVzRPa/7lHgqIRbbk3Kl8x+g?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a8uQ+bS8reVyP0bO41jwW1ZkEA4QS5xcMk1q8XCur/HlaD4pWx87aeb4VluV1SAm5Cq1SMFSY81iltmsFtY4E90Rz1wymgvUS7lw31JE8f838M5NRsK0hfUgC0uva9SAm9lwtZUGekuIIfZn6HAST9TMVuCHBdCCT1hj7k++FXs28+asziX0afk12y9YgCrRkSBu7/0mfSRhriUeODY3sYPH29ws6LNvYkaOBLnXfjKduOxVlmMIYKkOFyhM4y+gqO93Oi4/A8qa7NSCeKQtI1OBGk/BA6rPFWCmHRQAqQIuqulk8/DYLPDRIeHl6O3NZaYC33+OyBlfDZ4Xa0dM4h5TE127VuiDVK/RkhqLbxE98EP+GZ8pFAiuno3a7MxpDllqJOPu3Jb8c1M/1i05HknkoBvC2OhNANzuNGFtpHDCiszgHFOXFf/XclMJ4IULXSq7qIL4KrXTZ7Q9ENmcnDDWDB9pGZRt2P6aiqdTQoG6Jy/nkxSxNMrOO/jJJgh+K96iX6cuTLdvcRKVWAC6f1LpslEeHGSpB71iyEfgYQ6lpEb3FIDWNZUWWmzqVMntjzvISVpcSSTgyA79EXJR/bljvcKtjUe6RZxMiDoHSQs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d6b164-b2a8-4fc1-d4e8-08de0b343b51
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:13:29.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKgSrVFUnPqO5Jq/34r64UZiG4Szw/NS0z3+oJEmdvvvr+ltfhW/nUhyjNxIcJtSpf4pTHHxNdDQpFHnMQI7HfoszFpHZ9hlYuOpj3hi5dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX4jZYvPovdu1k
 LpzggY4KfWD/PTIw4yvDQ39TViwbAcSyxANvIuS56H6ublvALJpwWFphCzD9eYbflk6pM3DGtNn
 +HwVazi+L0Ph291O//VM/65MbfAnhvojbPwvjAOUYj5+pqjHuoRqqHt5QfQjuKy6HQrjO7Paw0C
 pLCsVhjrVBDWHMDJNJugWeAEQBBhlHRK60qmbRiCXpUe8R8ipCv1T7Vh8ABqw0Rg6qq/ZJNOZxu
 UkXFePCJIgXOk3HGCl4KplD9DcEcwuz8AjvTjI0yaguCABvu8fwyaYUi0bpHEDvZR7tJ/R7g60b
 KZ8sEa4SSTK3csBKhpZpZjbLjEvpNDBH3P5HlvQuvowYFd5xpt1MleRJ5/tRS6hWx5Fkzk87/Xr
 ZbdtmjxhUxmL0B1QWNSZIlHJdbomjQ==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68ee689d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qcr7M65vsjBNF2sp0bkA:9 a=CjuIK1q_8ugA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: ZRJ5mmKzERPk3ypAB1hqBeCEYKNXGPWf
X-Proofpoint-GUID: ZRJ5mmKzERPk3ypAB1hqBeCEYKNXGPWf

On Tue, Oct 14, 2025 at 04:58:44PM +0200, David Hildenbrand wrote:
> On 14.10.25 16:49, Lorenzo Stoakes wrote:
> > On Tue, Oct 14, 2025 at 04:38:05PM +0200, David Hildenbrand wrote:
> > >
> > > >
> > > > 		/* Skip spurious TLB flush for retried page fault */
> > > > 		if (vmf->flags & FAULT_FLAG_TRIED)
> > > > 			goto unlock;
> > > > 		/*
> > > > 		 * This is needed only for protection faults but the arch code
> > > > 		 * is not yet telling us if this is a protection fault or not.
> > > > 		 * This still avoids useless tlb flushes for .text page faults
> > > > 		 * with threads.
> > > > 		 */
> > > > 		if (vmf->flags & FAULT_FLAG_WRITE)
> > > > 			flush_tlb_fix_spurious_fault(vmf->vma, vmf->address,
> > > > 						     vmf->pte);
> > > >
> > > >
> > > > So I don't see why it's so egregious to have the equivalent here, or actually
> > > > ideally to abstract the code entirely.
> > >
> > > Let's definitely not duplicate such comments whereby one instance will end
> > > up bitrotting.
> >
> > We're duplicating the code in two places, how would that bitrot happen exactly?
>
> Often we adjust/fix comments to make scenarios/conditions clearer or extend
> them to cover some new conditions.
>
> So even without any code changes people will just ignore to update other
> comments.
>
> Code you can at least test with the hope to find inconsistencies.
>
> So copying rather large comments is usually never the answer :)
>
> Well, just like copying larger chunks of code, agreed.

This is a bit moot I don't think it's worth having a big debate about.

I'm one of the biggest proponents of de-duplicating things (comments
included) and have done so extensively as you know.

My _only_ point here is that it's hard to find the comment referenced and
it's _very_ likely it'll get moved later (in fact I feel like doing that
_right now_ as that function needs refactoring).

In that case the lesser evil is to copy a 4 line comment right?

But anyway, we both agree de-duplicating the code as a whole is the right
way forward and that solves the issue so let's go with that!

>
> --
> Cheers
>
> David / dhildenb
>
>

Cheers, Lorenzo

