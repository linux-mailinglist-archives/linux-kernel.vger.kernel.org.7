Return-Path: <linux-kernel+bounces-779450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7D4B2F43D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA6A6041FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EBA2EFD92;
	Thu, 21 Aug 2025 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C+ZoqJ3j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="USNn01//"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532621DF74F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769145; cv=fail; b=ZQiIbZ80O9qzpHoFlqhmBEPLLttTT0hWev95CI8vJ1gXhunwz9vhFPb629Vwr4KPHJVC1NKEpFlrTTWquwGteG7OGmNLhul9RuhG29UN4kdaV8hhtpyg87Kmh7nMVwRtnvmauO+2iHfr450uBsfhHlcAqdC10tLt5sCL+ZTXjvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769145; c=relaxed/simple;
	bh=QX7faeYYZAsE97FYoP9QV4j9JyDb03xw/fXFN69kkbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dByeTLCQgRTsNN3IaTxMfbXR/e9XEuNF2sZIt+6ckTXcExARgFmrz4thvBxD5j1idxj0L3t8ZEA7Ew3rJtb8hHZy+qmiIgs4oAzHGgr/oRHIEMijUw2I8GXC4Cqd8+ssYJHbynQWNRAYVr1db3RWTHgDwOKBU65wvqlndIbrYpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C+ZoqJ3j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=USNn01//; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L8lvqF021835;
	Thu, 21 Aug 2025 09:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+4t5u4dqyziEWnbDdb
	tfpmHCYp5feS0GZxauNNlqbwY=; b=C+ZoqJ3jzp+IFw4VCnreXbkBQwhNEqlt2R
	xYldRhQXOApTZP9LSqcazY1Xnn25xlroqGTV1WzrTFhlxK5o8ojxcTfhTcm5mMk1
	RJE7c6u+dYZ+RJDdGgFai6xq6EqR7icy53xvlSC8QWqdQC89GfH6TNueQuBJph5Y
	49fQmpvfkrDgTECZ/tecV8odsmillAx0JiHpSBoo6sViDTdQIznKlBQMMTZFG/q7
	r7XvdlLXp7nlFdxjwkljtVTAQc+qW0wn98+QMXf5o/dQT3oZ6Qfk382lHDV2KbdJ
	PPJfSs+mRy12IfHgoRyh+JRpghsUHTB57YW2WvkOnzqLfa3WLDXg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tsu2sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 09:33:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57L952uZ039701;
	Thu, 21 Aug 2025 09:33:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3rv5vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 09:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F++rEZPiOvFczSUXBzMsDSbjb6tciOnt7BA7mbS9vzTRWcTDtMsfK5cmE9VjDDXDUa+GuzJ909LjZjo5jhrP23UyHhaTNWIYn93zsUTlKQMjwkqETv0a2caLXlrxaZbkdIIQ2GcSDU7zR5l2jO7DfLSWwGh+VeX0o/lAKgux4g3rwIUcoMsDDDmpF4N9s90XEXdTI5MIo0ApaujDh01JhDvJZSxc5n/HDEAAfXSe0y6//DRorH7zU2G3EvPqctR0x6Mq6aGcgS+RN+wDCTWcXkoKP0R7LgGV+nPjslQvUkObmO6nReHJ7kr2yi5F3oliDPnhRYMAA0c3Q3tLeZEveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4t5u4dqyziEWnbDdbtfpmHCYp5feS0GZxauNNlqbwY=;
 b=fjOCDNkI+R6lP06agbBnAkLVTWVNrm/4L/onF6rqzEEMY/sK/eEngroT4yY3IiXb7Eh4MSVVHre49Glc15FcCOXl0i0DNP1TQYFjVubXicENgI1YoVDpF3mNP6IVmqgEB3ChTQQm17FHnEqOutbINet27CaNiX2KC121O/H+PjTNXy+aA/Aj24nZRWGfx2dHDLbEUKK2kHpACZ63db7bCsziApp7q5pPPi5nDCE6FVv5mj7sBVNxp3EsEW9JS2ib0FA6/KwoRUD5PxYubTIEk+ClxMCtvLEh40AwyxZ7Io08bZ9DMT8DTGvUc4QohneBG4iLJdW2/nPR+0k/1eTcPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4t5u4dqyziEWnbDdbtfpmHCYp5feS0GZxauNNlqbwY=;
 b=USNn01//lj+W3jJOhcHkNLbPN7tUmTTGOmeJOF7HqJytt970BChxxhiRKfZJp2zW0DI6wW1u9BUdOmvD4nHanYkw9xZf2KNwoCN1aawy/NcrWrftCMUorYerjwQJJOcEuWpSntvRJaTxupvpK78HsbLp9sEtuvs/RoSNrBFpUoY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4526.namprd10.prod.outlook.com (2603:10b6:a03:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 09:32:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 09:32:56 +0000
Date: Thu, 21 Aug 2025 10:32:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: akpm@linux-foundation.org, andrealmeid@igalia.com, dave@stgolabs.net,
        dvhart@infradead.org, feng.han@honor.com, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, liulu.liu@honor.com,
        mhocko@suse.com, mingo@redhat.com, npache@redhat.com,
        peterz@infradead.org, rientjes@google.com, shakeel.butt@linux.dev,
        tglx@linutronix.de
Subject: Re: [PATCH v4 3/3] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite orders
Message-ID: <c2b5c573-c0a3-4063-9a79-d3b06a615fe2@lucifer.local>
References: <8e20a389-9733-4882-85a0-b244046b8b51@lucifer.local>
 <20250819151834.20414-1-zhongjinji@honor.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819151834.20414-1-zhongjinji@honor.com>
X-ClientProxiedBy: MM0P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2b495c-25b7-4b3c-a063-08dde095b60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qh38LBwakVGKu9L8xE3C+74BKkvlZizPAKeA27VZmym1zP5aHXq0lZuB/sWS?=
 =?us-ascii?Q?NWoJyP7QjVHoBPTphvbM3uW1A//WKN0TxdQG29q1xN3NvOitIlTuSr0DXjAs?=
 =?us-ascii?Q?LaxN2nj1NuSgiS3b1P6Z719V2o1UEOCYrUZm+ul4Dr+YlkTC4Qg5Ig5P6thW?=
 =?us-ascii?Q?LZVkpkOEh8tyaNPrHkZC3eGyDI7mkaVoJlvPi/RnQc5TnUSW6z83irACSvnk?=
 =?us-ascii?Q?UDEi6QXbRCYRXv4Y11iuWw5o/ZfR2wbZldBOrj1cNNK/JjUSAOwoBJ5KZ7if?=
 =?us-ascii?Q?Hi6dNqDTLanR5l0F5HclRE0DPhpwMqA28+Lju6bVmSnVVLe7JXgqIvzuYEJ0?=
 =?us-ascii?Q?7MR7og6+Sncsy94qTY0rZi1d8ywKLH8BNzVX5ikUMwMI6OmCoFsCc1/2qVCP?=
 =?us-ascii?Q?+CkRcWAfJ3CvU2HJ07CO7n+Adc/lOQn0l6yGqGz4X2VnWzzI458JtGfxOiC2?=
 =?us-ascii?Q?svIdzdpXESX31FIlXehya/a06t4l6hN5UMfD65dSwlC/6UxqL3LfFMHAABWr?=
 =?us-ascii?Q?SbbTiA/V/q52OzXHHsZd4/noeYlC3R9d/0R+UdKssx1s2al5AQ9zPHX2L2TQ?=
 =?us-ascii?Q?gt3XVM/pIiRI0x778jp7C+55cGvKqO5Fp5e1R9cCVBBqTbcRTa76bzLVVLmy?=
 =?us-ascii?Q?HIvAhoSH8rwXb+Vf6D1lNoSx/gIma/Xudf9gsrkURR7IUKEMKCU4wt0I6s7X?=
 =?us-ascii?Q?/JsIPmyXjo/lre6uXOegjEjHU2GXdHtXcCKOf2c0qnSaaOrNjGyUY8HGTeR3?=
 =?us-ascii?Q?ywiS4BcmLyoH4gY+QoiReOWpenM7cNIZXLU0iioAOIspvoeqeEHq/AWP3u8A?=
 =?us-ascii?Q?ThQ/G/e45nhJLt4p6mvuCNC8wIfZrd81Ril9lL0OP2rhZuftCMoyEFrnstTn?=
 =?us-ascii?Q?UFVMADI0II6BIpp7ST9zFkvu3e3rdY06qPj/tvSsJ942DdAzQyZX66nsOUWY?=
 =?us-ascii?Q?wvq4xp1tyasie1R0lBAM/Mt02cZelw4jGKZmjwXxImyWDjHYEKy1yZsNKyRL?=
 =?us-ascii?Q?nawOpUSeoiCR7qOZHhxpPT+P2osV4d7yuvDNbIRGnV3mCbqgPY484z7S7yP8?=
 =?us-ascii?Q?VjZXFuxVo+2cYgK8+Jh1XOEIkogguC9Cf8uD9OOe4BB4cXwBljuBk3VKEYiH?=
 =?us-ascii?Q?lR6HYTM4Yveb6IwX1sH1L+DcZp3FpWtHIM6Ug8BZ0hulEgUkHYyFpBRw+yiX?=
 =?us-ascii?Q?+BeTfU+h2ZPtcg7fRpYlhTyHWfYrV9aJYS9CtbGh+IzZ2TwDHjkXCN07eHHu?=
 =?us-ascii?Q?uySQQeFuCI+onh3FXhSzAo4hKf36RM5bkL4w58yizPz4ErmupdLrG+MK7Uz0?=
 =?us-ascii?Q?m5vZUr+MnwaH9kPaplEdV1X5m77j2PdHaVikfmP6RyWT34oMEy5dGBXkZZza?=
 =?us-ascii?Q?4YgNRbXDQKPHyZWUy8+d2EV82x2JsrjZIHcS/pwtSA2b7YhlbGoyymfYyTtM?=
 =?us-ascii?Q?CUTTjct9rpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9jrogwMLPot4zdKhGHLxa2nHkQXvrE4tZJriY/Us3bDdA4XjSuSTWTd47w3L?=
 =?us-ascii?Q?LKX5H/qQ5vKIx5f27Jkzhqn76YAzZ499q55NaqlArxqU4EjK2v+15bqyPSav?=
 =?us-ascii?Q?QpTk1MbMc5J7ZCraO3L0jMPusV4aCDlAJ8psWd9Rb5xTBtSgBR4U3JRP/VXv?=
 =?us-ascii?Q?hnQCiMmEAolC5DBif/qT2gEQhyrHs/R+tnAEU71gJ8H3bIgIjtRALSfD7QZu?=
 =?us-ascii?Q?MYewtOoNlWqNlRAcU4QPLT9M1ORaEGSmDWfG/VhvZeVVROl+MGjht0ouQH4R?=
 =?us-ascii?Q?YmiYTRmZU7bXuUhOX1Dmt6EaR0Ky8JAfQvDDDGCQtvsdki58vy3S43Dax2Ri?=
 =?us-ascii?Q?oRzTTGWn0M1AhptCadHsEryuX1Fj+uKXltIISbZsBuAPppsdgRFuX4skRzKa?=
 =?us-ascii?Q?xQVHc+/w+lsSbag2165kWplE2IVmKE9b1olY6mu0RpxUeGQXTOFCzh9vwIYx?=
 =?us-ascii?Q?5gP27Xd3htF8TXUR8iLo2qpYvY3HUjCjIriKfEsSzdicueY8DZlObZFV9VzC?=
 =?us-ascii?Q?D7lOwJBT69uqcV0vm59aTQXOOUoVvm2EfPMDu1YX/DujdwpHrbqTQApa9LjK?=
 =?us-ascii?Q?FLpzV8jH9tgH/YrIwbGD6TNFXjZ/ypGA2dOLQtoL6TdkZj23BhCCInnrewQF?=
 =?us-ascii?Q?BZ2lFP9m1s2YcVaYKwdOQIACg3f6xdYVPhIE5QvKJiz985SUr+l7MWU02aQB?=
 =?us-ascii?Q?ClDrpQhbbaUpwuHmtCrnqAX4pzu/94rOj5ngqP0n4UWLQSy0qrx1BLQZAA0W?=
 =?us-ascii?Q?O1Y3yKp3BXmbeSpAWrbmVhKiLA94fq5RiAh8/NnLiF6BBu3B/7xtzGXu8wIW?=
 =?us-ascii?Q?b3j7f9ZdyPuVll0M4Ht+3ioFPXaWVslw+fiZeQ40jKXevaZ1Bin1TYObb528?=
 =?us-ascii?Q?b0VcZXI/DNG9/fLtnbtCCk42IqlJN94FU7Jhk6t9x4/QppOxlleOxVQ1xnIk?=
 =?us-ascii?Q?SIturaZcoQkovh0LruP5t7o4xE8ANH+7rFEBb34rK9Ge/EftXb4uyEzLoPP8?=
 =?us-ascii?Q?NcNW9ctcFEjiSaqy2uWWabRKNiJYAZ5+dAutZ33/27Riz2tqOwaBdlghFTXX?=
 =?us-ascii?Q?yFPwIMuPeU3KkrgmRdjyQpeojmR8Ww0MAEDe/bXu4R/iQcsqzyttkw1suPEE?=
 =?us-ascii?Q?SepZ/vqIziDLqJdI6qBDMxMvSb1D+B4wDuoY9jPTGBwXlsl24o0ngOn5XWZy?=
 =?us-ascii?Q?D6AwAqnAsd0BjxmH+yO7KpYilT32NvveU2vsUFTdH4f4aaDdIJMiLyOuki/N?=
 =?us-ascii?Q?Df/LTlP4tqc8IBX5IUQSBn03MOmOEStVUlvgDlQrleWyMZryRbPSfhapewkK?=
 =?us-ascii?Q?lPkmlJprifNgldptgRIuKkYm2d7r8sKJZfG5ZgGb9vcn1poODnO4uvF8h7cY?=
 =?us-ascii?Q?KClsP+CIyjMsN/CCikOuUOQmX+F6QLvgsfkbhkCZYAWTU7OdTrXMi5lsgsh8?=
 =?us-ascii?Q?OzhdIFWp4LWxWSRSD4eXHIR6rnPHPj6kT4eQ6ogDGbsK03ih8/UZzBmo+RJZ?=
 =?us-ascii?Q?goqkJB3PCwYqu5RS7y57IiWB8HQdUraWl/ipDmxmbAWEg8dxMUy5woFKPJYl?=
 =?us-ascii?Q?a9sILPbizfxvkEh820SCSAXEPQdpHtmzse5RauPgXMSu8w/t5amZ0Ocsyjly?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9M8Ttquamigh1G28wfUHJERv1Qq7zUsrsqG2klioGxfEnj8W8i46qvF5SU/HCEDxe6/I1rLZawTJKynYZlAR1FVcGPtwhNk/+AwjNB/m1GhpzwJwvdUBdGFoIHlzic642N9E2FImz6Tj5v04fdwEEelpP60V/GuwMh3BbG0gntnnkEnkaqnCtgGHdGkHuplosJp9GcOeHUF7tCYXSYZKaJvCKYtUiWE2xjY6aedCtma6wPhOu9AJpIPOE6r5K9v14568w2m+xkKHUppWz9LJG2GFJOLeeVzK252j3eSj3jk+BGaW+DxRqkPFd3eqBi8+bhQVQdMhdVVyiWQYf5VMhBQN3uXwMfRTngfnEM9sJ7XGKY+VDR7mDH/R4xpXsGSl3p40VGt0P0lEHefMK5P7Q774MKyGXTFeo4wbFpKMQ0bFhlttaDVOMkm7tb7ITkH7MfRjKv1HhIvlBJNG6rxnnqPigyZgEepqLiTEJbPpdSZbZTWDedMYKeWxLeyrq0MEP3DJJtL6SLOjAs7mpymBV08bizuHZDhMKGRtZJIiIfLrVwF8Ky0oKA5aNZkwTeEA9i1fk8bhRw16E7GpSf7M9A3Ddzi/LJEnm0CYi/WXH3c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2b495c-25b7-4b3c-a063-08dde095b60d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 09:32:56.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmBMmUpiwnJQQq1KcfPVb13DUxeaTHdAKJQ2FaP2UieONQP7HC268h2BV+MQDGwx0qKKtJUEpTYF6nHgt3Jqa0H1qhJwPDYglpmqwPDvcGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210075
X-Proofpoint-GUID: 8fz3mGFsM2H9BOd6C7Gu7l-fSvPRRYep
X-Authority-Analysis: v=2.4 cv=S6eAAIsP c=1 sm=1 tr=0 ts=68a6e7e6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=CvlTB2HrAAAA:8 a=sij-3tNmjFWCw85rS8cA:9
 a=CjuIK1q_8ugA:10 a=67QrwF-mucXG56UA-v15:22
X-Proofpoint-ORIG-GUID: 8fz3mGFsM2H9BOd6C7Gu7l-fSvPRRYep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX8HyZSaCVPWcC
 pFHAZQ60aajFz+pVu2VscRtR6ozClVuanuUbCtc76m2ctKYeq9to6XlpchhTlqNWMt9fMLPPYA+
 lkmJD7+CH3qyroZPVsJP+jLEa0XMaBcDaXGVoaiyWDAvx6n1qv8kzQC7kwQdZxP0rc7K7v5fH7f
 9wi1kPxb/kYSACd/2XckU3GwNObJjdI71tqGXnS3OiOkknrSIp/YlgpuJwH7f4mgk4XU7bI01/l
 3Qi3+4mA84d6sF6kSMz9/8KgZ17KD955ywmZr1PhNwM5paSdnjOw7S55x8ZdvvNrEYoieDX5bcH
 NA8MbzrfQRu1BH8PfXKVO8tnuJEA3jujHwtYj9urH3z6Tkl6OC8ZpZwrpWRSo8bjb+1rXmue3FB
 v8n93pWyehj4w4LfvHsPf/tzR0SlCQ==

On Tue, Aug 19, 2025 at 11:18:34PM +0800, zhongjinji wrote:
> > On Thu, Aug 14, 2025 at 09:55:55PM +0800, zhongjinji@honor.com wrote:
> > > From: zhongjinji <zhongjinji@honor.com>
> > >
> > > When a process is OOM killed, if the OOM reaper and the thread running
> > > exit_mmap() execute at the same time, both will traverse the vma's maple
> > > tree along the same path. They may easily unmap the same vma, causing them
> > > to compete for the pte spinlock. This increases unnecessary load, causing
> > > the execution time of the OOM reaper and the thread running exit_mmap() to
> > > increase.
> >
> > You're not giving any numbers, and this seems pretty niche, you really
> > exiting that many processes with the reaper running at the exact same time
> > that this is an issue? Waiting on a spinlock also?
> >
> > This commit message is very unconvincing.
>
> This is the perf data: the first one is without this patch applied, and the
> second one is with this patch applied.  It is obvious that without this patch,
> the lock contention on the pte spinlock will be very intense.

>
> |--99.74%-- oom_reaper
> |    |--76.67%-- unmap_page_range
> |    |    |--33.70%-- __pte_offset_map_lock
> |    |    |    |--98.46%-- _raw_spin_lock
> |    |    |--27.61%-- free_swap_and_cache_nr
> |    |    |--16.40%-- folio_remove_rmap_ptes
> |    |    |--12.25%-- tlb_flush_mmu
> |    |--12.61%-- tlb_finish_mmu
>
>
> |--98.84%-- oom_reaper
> |    |--53.45%-- unmap_page_range
> |    |    |--24.29%-- [hit in function]
> |    |    |--48.06%-- folio_remove_rmap_ptes
> |    |    |--17.99%-- tlb_flush_mmu
> |    |    |--1.72%-- __pte_offset_map_lock
> |    |
> |    |--30.43%-- tlb_finish_mmu

Right yes thanks for providing this.

I'm still not convinced by this approach however, it feels like you're papering
over a crack for a problematic hack that needs to be solved at a different
level.

It feels like the whole waiting around thing is a hack to paper over something
and then we're introducing another hack to make that work in a specific
scenario.

I also am not clear (perhaps you answered it elsewhere) how you're encountering
this at a scale for it to be a meaningful issue?

Also not sure we should be changing core mm to support perf issues with using an
effectively-deprecated interface (cgroup v1)?

>
> > >
> > > When a process exits, exit_mmap() traverses the vma's maple tree from low to high
> > > address. To reduce the chance of unmapping the same vma simultaneously,
> > > the OOM reaper should traverse vma's tree from high to low address. This reduces
> > > lock contention when unmapping the same vma.
> >
> > Are they going to run through and do their work in exactly the same time,
> > or might one 'run past' the other and you still have an issue?
> >
> > Seems very vague and timing dependent and again, not convincing.
> >
> > >
> > > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > > ---
> > >  include/linux/mm.h | 3 +++
> > >  mm/oom_kill.c      | 9 +++++++--
> > >  2 files changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 0c44bb8ce544..b665ea3c30eb 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -923,6 +923,9 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
> > >  #define for_each_vma_range(__vmi, __vma, __end)				\
> > >  	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
> > >
> > > +#define for_each_vma_reverse(__vmi, __vma)					\
> > > +	while (((__vma) = vma_prev(&(__vmi))) != NULL)
> >
> > Please don't casually add an undocumented public VMA iterator hidden in a
> > patch doing something else :)
> >
> > Won't this skip the first VMA? Not sure this is really worth having as a
> > general thing anyway, it's not many people who want to do this in reverse.
>
> I got it. mas_find_rev() should be used instead of vma_prev().
>
> > > +
> > >  #ifdef CONFIG_SHMEM
> > >  /*
> > >   * The vma_is_shmem is not inline because it is used only by slow
> > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > index 7ae4001e47c1..602d6836098a 100644
> > > --- a/mm/oom_kill.c
> > > +++ b/mm/oom_kill.c
> > > @@ -517,7 +517,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
> > >  {
> > >  	struct vm_area_struct *vma;
> > >  	bool ret = true;
> > > -	VMA_ITERATOR(vmi, mm, 0);
> > > +	VMA_ITERATOR(vmi, mm, ULONG_MAX);
> > >
> > >  	/*
> > >  	 * Tell all users of get_user/copy_from_user etc... that the content
> > > @@ -527,7 +527,12 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
> > >  	 */
> > >  	set_bit(MMF_UNSTABLE, &mm->flags);
> > >
> > > -	for_each_vma(vmi, vma) {
> > > +	/*
> > > +	 * When two tasks unmap the same vma at the same time, they may contend for the
> > > +	 * pte spinlock. To avoid traversing the same vma as exit_mmap unmap, traverse
> > > +	 * the vma maple tree in reverse order.
> > > +	 */
> >
> > Except you won't necessarily avoid anything, as if one walker is faster
> > than the other they'll run ahead, plus of course they'll have a cross-over
> > where they share the same PTE anyway.
> >
> > I feel like maybe you've got a fairly specific situation that indicates an
> > issue elsewhere and you're maybe solving the wrong problem here?
> >
> > > +	for_each_vma_reverse(vmi, vma) {
> > >  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
> > >  			continue;
> > >
> > > --
> > > 2.17.1
> > >
> > >

