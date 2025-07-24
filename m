Return-Path: <linux-kernel+bounces-743921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E49CB10578
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2081CC4BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07969238171;
	Thu, 24 Jul 2025 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XamdC4NG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YKE9gucV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2801149C51
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348571; cv=fail; b=tjrm6Kj0xcvNTCOlky6JojIQJLGsHxbsT95sQViO+qx94CXbII7fVKMP3U/ZfDv/t1CowK8kdzwZaottFL4b0UiI2siy0lk95EeK1hwj4+AdAwfb5jauZRwAA+acNEWnUDPwb5pN8tEz4yWzm9+UhIxH+tT+WlD2fQTo8qniiIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348571; c=relaxed/simple;
	bh=vpyxS/0WV90+b7aueQh6xTdB42Dy/rxVLOwx7M9+0gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uFrKtWiINofzT1yf3LzZgixaZYlzjcm3Xuda2g6I0JRyRpJ/jsbsgeq2YUgiHSWyOKswLBQUDkovevJv6NHxnahJif8PEPYthxyQ89e+zl0ypak9DIvqQss+RFx0oxeuz8UKXgKJatiKH2iqhwhlSe+jxweiGrEYmqNzwxpHo+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XamdC4NG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YKE9gucV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6trvZ005882;
	Thu, 24 Jul 2025 09:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vpyxS/0WV90+b7aueQ
	h6xTdB42Dy/rxVLOwx7M9+0gw=; b=XamdC4NGbkZz1jeGT7IFiIbA5BNePeAAlc
	GfTKoTfOU87xlHvdr4y7QYsFKVYqoNwU0BN4D7k33aslxL6vA3IXS0urwsKxfQut
	swL7cAPSXL6+ikuCdWeXxI+jfiJxWZCTlAjP8Tij1ItRM/wjSgt3PJ4gVmnzaB/i
	ZNUYL1JmGwBZawfCRNcUM9RghT2lYjt+pOg7lyheQxaBzC9IabBbAnUivZXY1t6i
	LJPn//YxRsaOnLkwXFekyD0XD2pRQQnRe6+60RUdt2cT0y8l5UeqH6N6JB8ERvfF
	zv3Ko7XVlwlEb+i+9WR6QGPxKEgKZEN/MHcceMPYcYWbrgrLJDCA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx98cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 09:15:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56O96WD3005775;
	Thu, 24 Jul 2025 09:15:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tbmfqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 09:15:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9gPx0eO9TOZh1S3qemmxBa4j1FGm1rSNmE8zFQSeLbctIttpd4qPHBZH3MGGinckSNwvDzlp5iKe0iYf2Bk788OCbgf45TnqCFAtYK2tZpdwoMqBLsrS9Q3cou6VRvt4sH9ZfFpLEjS90PCfuUaYZ0FWwySLiAQdfAVx0n83Tl0gEeC+kq7LvmCc+hp/jh0HVqKx8G7NBfYukDWz+pfVLAIvMxLyQK7CTJGhD3jJ2+3FnJS+5+68++suUzfhYdMSBqdesfNgtheytsdDtqhr/EHSkpogokdJvtq+2ZYCJ2WA6c5g1UdLp564cTVg6G9sU4jCIPZzzJveWkWyr/LaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpyxS/0WV90+b7aueQh6xTdB42Dy/rxVLOwx7M9+0gw=;
 b=F1tZTFS2E9v58IZeABUFoa4d/9eEvBjL6OXMWf96tryUiAej6tT8zF8HpbhAxV3AjF8r9iq+vgnpUIN5Bj/hIqWNxzFb3myzeIMZGxa9dvezFN21O/wQhFuSiLvYCCijp3bdS8hW64k8rxFsgKG23vHIEXpL3iXzzv2w54Hh/RwkTzvLIZflYBqFUZRTVWdcOSwqNSR5TbfnkUbSTa/9oK8QEWhhL1nRaI8xZv17l4CsZLA6/rdobrOKh1nzj7jghQwT5joHnsS61BVkVyyLf/q5A2KndM0z49q+udlAaoid2otAoUr9sXB55/K4fxBj5m+iyn5LZ7BzcWU9lv3uHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpyxS/0WV90+b7aueQh6xTdB42Dy/rxVLOwx7M9+0gw=;
 b=YKE9gucVm5aj4yzlxxqb2yq5cbE9ROZGcs+e+F1s+uq4/3ljiMg6lzT9oriUWIXGazRgkCi7WbB+SNhZMlEmBB1132mv6Y8qRa4ynvOp2km9FShfXM2LTCAp4IF9X6nn/zSuz7o3he/jXyxz9NPo/N75o6O3B0+vfukIgdw1t+A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6695.namprd10.prod.outlook.com (2603:10b6:8:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 24 Jul
 2025 09:15:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 09:15:11 +0000
Date: Thu, 24 Jul 2025 10:15:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Huan Yang <link@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] introduce PGTY_mgt_entry page_type
Message-ID: <764c48ad-8869-4f69-898e-0a1c58684f7d@lucifer.local>
References: <20250724084441.380404-1-link@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724084441.380404-1-link@vivo.com>
X-ClientProxiedBy: LO4P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf0025d-fb4c-4db0-afa1-08ddca92977d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+pNBbl3sP8xBHTMOCc2zD7NPqI95CbxnQg0sC51OrTfV/nPs8TIVDUmG2F2?=
 =?us-ascii?Q?HGdI47CP0GEbcz3H2ie0LGvDrFoZud7FoRs7hf/epec7hU6cngy3ziu4r2tG?=
 =?us-ascii?Q?ZWpkcGt7b7MLYin4xlOEdhurSETLzsjc1fTCoe9av88ABq5UHpnmHRoy9PvF?=
 =?us-ascii?Q?qgLQIdQWxd8AAAA3oQpoyJXyRiFUsLMXm7XZD7AeOcxtJaZdDstjErVUFaks?=
 =?us-ascii?Q?S8bU2X+Nr+fshPiXtHvtWPvNthfz6xnnJFGwTLwGG2kY42nbTobXnXHIMbJN?=
 =?us-ascii?Q?NPF1xDx3tLISMqvp2I0075kbwpHcSjhY+P3/ihDmy5vl9jRmduRIBhkYx6gB?=
 =?us-ascii?Q?5dkzcjqqzW5iPQH1oNF+QhrvYx+ga3wU2NS/Q/GnIP1ysBpfssalkFrk/YVQ?=
 =?us-ascii?Q?TFaTo3mv0Dc/4QoZKlW08+glvnPRi0zCkgzAKxFb4Y8dIMqqAkzTXpJsJa9t?=
 =?us-ascii?Q?0H1cfILyeIvFiOwi4f7g3SPRQhLvnoGfTH0NwbK2ufMuJFaEbelqPm3AH1OH?=
 =?us-ascii?Q?3SkdDw5BWzu3WHEfFs8/QW0K8WJKrD4nJbFrFLP3WZvJJnxtCfr9TYAsMBMY?=
 =?us-ascii?Q?ZneVcTiG0WYlfFQ69PzerFx2emoBH9KTLQ7XpLpoaO8vP8jsWBQe3rxIiXh6?=
 =?us-ascii?Q?PIocIOPxM9WvrsDfkX2dPHgOqRXMYTkMiUZZyCqsrwi6mtyKCxyHiHhDVSyR?=
 =?us-ascii?Q?mSjZWWRami0QCSVIrgTFOg666wgXJuUOUbdyEOp2SEsdssTR9idZsrTYDerv?=
 =?us-ascii?Q?3ZaixgNMz+LBJU77OaBOFTzWcEOJfyi4KX57MNopUVYvRNRhnbK0A/cvtMpQ?=
 =?us-ascii?Q?ZSPcQsk+hEex0370T++e5/4ZoNYv3bTf7n87B+ByKW+CNnyg8IMFom7zggpp?=
 =?us-ascii?Q?WMRoj41Z8w/ZeI5hk4NNa2kMd0/hDRO8I1Zi1WctjdT7hiZj9dXQoUWYrhyN?=
 =?us-ascii?Q?z+NPE+HqoBkt2iRFawqDrvmfyEHeGYhUmDUT6L/6wWdDdsAdEBv5fnOKQXss?=
 =?us-ascii?Q?wCDS04Il1WE3uGLAQKLT2FRyOmOoz3SYE1IV1fSRbey5c4RvYawvY6wG5iIp?=
 =?us-ascii?Q?6joRQzR+5BJWOZyGC/KjQIvzEfx5gWLhRtY13gSO6FbiKPQvmtWzYFLhl0/D?=
 =?us-ascii?Q?yCQ03qXL7WM5zYZ83IK5+UmbKSW3bI3ox94UaP+eniAC31gx2/lNVidcS/L9?=
 =?us-ascii?Q?Q6zyCWMoLVPmj9m++A7vrAAk8lO4q6eZfWpfPqS7+h6MPrEQovIR+aUJOdRb?=
 =?us-ascii?Q?Ww+sThkN1xU0bcvzWMlNR0jGOh4Mzo/TvhBYUkwO2kkLw92IZjTeJ+GhQKZp?=
 =?us-ascii?Q?KPgim8zKqTKWmbJdVmG+e0POxJjaVG5na8O1Gb+DSVGLTBaI1sJRLHZkqKAe?=
 =?us-ascii?Q?u10efpfRGNRbmCLEk2qoojtszLm2/W2OnpWWFrhwkzZegXSMDMQ9z6O7lsUA?=
 =?us-ascii?Q?fEKIOSFqw8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HF2Mlo9y/h+rOuCCBAO3cu9SakN8poNVugIgd1GD7Lgj1oIz7KEU6Xcff5LT?=
 =?us-ascii?Q?/gDCfUllYqkPY51g8oLWT96WTEq/K/fa6s/XonpmTvpKrn95cY0RgJoSKNfQ?=
 =?us-ascii?Q?3Xk64QRaR0qBiTB5ineciiu0hlYs3HEdoL/Yxko5px5E64nt0lgu3SGEwnHg?=
 =?us-ascii?Q?v2fGQYMH7TlBFiEHNLdJw/I6+Saed3VJJxDmnyQCgnu2ddqcQFwJ6rpge5TB?=
 =?us-ascii?Q?CZmKz1bYHanpGOdA6tnP2WJin6Wf3yoHWJ0sN5P52zbhls4AsLvCGJ6qir3u?=
 =?us-ascii?Q?d5IBTvETm9ZDGlH3S2nYdx3Dno9MoHTcXf2vxgtGcKLzTIpjKfiUEcG3j8OP?=
 =?us-ascii?Q?ROd2U6Wubj548fR93cHZrxDFqf+JmtodGQ9/UyswwlXnzoMY6R1my5LHFTh3?=
 =?us-ascii?Q?qVTwvz0DHyTBNID6MQAoiyZb8WxfWsLVs0gRaIPEZHb23BlIk/Vm2MWI1g2C?=
 =?us-ascii?Q?gOfcrO4QgiIUMPAFgNVj9D/g00dpfFP8XgEOXo/kqzxQZ9ci8nGUgRD6Tcvm?=
 =?us-ascii?Q?vBZIodCVnNNhbzsHkbpbNiWtJxPRz4AAMbA41ACFbxdYMmFw88KQIp+RZ+df?=
 =?us-ascii?Q?cUvZ/frPNjVwtKSRQaw/Q7g/p5jGZ2pE072hX0dGL7hPqG3dhcGW0jNQEKoF?=
 =?us-ascii?Q?SfAnQSDWR75LHAeQ/oe7su0HQy3TsXNTJoNxb665Voo2qqeauU2a304uky8h?=
 =?us-ascii?Q?eEg2ufZGVGhZMQk6H6Ep4vvUHzE2MZZUN4j4QZDqppLEZxYG384h40s+GQzg?=
 =?us-ascii?Q?rUaNjbODWImShFpSkXFN8A1VwYZq2+BUjqqOJ3t9wrw5MRv42hfFcSokdL9T?=
 =?us-ascii?Q?PeE9dm50ek8ABp/FJ/NjROif4zBuBc12jk81DeJgBC7fNOuFRNwOGwfdoGhk?=
 =?us-ascii?Q?VFRTgavwIkfHPyaVOE35cu+F4aDOSpexcinpFNUOzWE2hUAB+IwzEjjQJMMJ?=
 =?us-ascii?Q?b06EhKh8+Vhu5AXHg10PaPZWBxztdk8gnFobWffgXSSz1mI8FQ9qyH4sX4iX?=
 =?us-ascii?Q?QNiIez53e9NKDIBCWCDZiBCG3wsgx2jCK+Gfwl3aL8XWONd/4guXpbWhfn7v?=
 =?us-ascii?Q?8sPmt6jEibblaJUTEOXC2IfRdcSekwKpdc8PsaggCsADHywxVJnqGK1YpCCy?=
 =?us-ascii?Q?BAebXk3NAwhWK35eoXEz/7G42vNrqoZSYL1F+c4Al2I9LuyQWwcISGw6dUAH?=
 =?us-ascii?Q?6sF5vaqUGgDebe5R9/9KpfLqshJnB+UXp9Qcrk3BlqR50M3iYoi3DPWcC9rG?=
 =?us-ascii?Q?chICL+FVr0ewAXTzq4V6b3YSeM/ue66sLQRr1XH1+DZ6Px7bHNtdMNCqGLpf?=
 =?us-ascii?Q?YuTt1Fysrem5dzLMsxrbbD4v9vlX9fBQYE9r8NXINennYh3Nl5fBC9Zmepk+?=
 =?us-ascii?Q?vM6VTubD7mbCO85Qa9PkPGv68n2P48EVahv0U1kFonhNhMP9KHpQP63XAIZO?=
 =?us-ascii?Q?TeEriLQld4eea7g0X389V/zSLnXSrImRKXiNUxe0l3mE+T3tRPqMiQmQYgFE?=
 =?us-ascii?Q?I8OzG9lwPKP4tOXCT0Qyg5JNXE/IPEKK+HC81wmfKN5FkcnDBDaxAi55t5bV?=
 =?us-ascii?Q?uxxKlhuUOlMRxtP965LbLnC7W+4qaxlttQA0lF5ZYfe4zaootrBJ5UGicOwT?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0vaXs+Y6AE1bxmtiDLOpJsZiIgXBxtHzPLNMbRF5EK+ysT2ghuwPFaxiRW/RXdO4zeIOH5h6/H7vZCY+IKpFmGz57YyLpSW2SZwKe7xgMZmgjSce19+w58zrKWKqlOQS7RMpaisvD8gtW72FFwUatdw8EvIcknwpd97TbLCZyUQ1TxgqSQFxttfB9/nazAx/f5b0FFDwPBMM7RbItVXWCoYgK1lwFVV3B6DBYkabhcPaI4kcqJ7YCk8e2S4kaTi6kB64yTQSHARwQmWYbJJoodDxv5XqAV62smEToY6+FK7x9O3UM30N9M4GF0alVX5PELcKuDbKqRsYFAe3YcGSoG8Z2bNnFGWoM9LHIiy56oakBAN/yYiZ9+DxEYWLxA1s0PWiJf25u/Htq3qABJyNmjeoY4AxPz7m/3EJjE1PlPbJ1a2e15qmV73uRsinJ1lIhWWq5y46U3IZBQ4YPlTBtCQJMuYrKOAuztaQFEtnkRPiyz/RhpY9Ugkw5ixX0b3v690Npcb42glC02O5YxvRov1Oks1XMsjuI6enM3D1/gxH5RSUqEmap0Wm+dGuf5doqRqcVFMJSE/1hYcSqI2zMat6pudTd1P3s1NmYYhGBg4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf0025d-fb4c-4db0-afa1-08ddca92977d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:15:11.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4No0JR0NRjrJmynz5GxNOjirqsmqCzXOkHejRCZBGV93lN9hcHXgS9ap7nXi9hbtAKrSWdbHB1a3mmhiEIuIuAqV1rmphwbWoRPwCE7Ep9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507240067
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA2NyBTYWx0ZWRfX29g67vNokVyb
 wa+4LSUUsqe/AkE6D7r+03XBAJmVkL4zZOxNuw7pnZnnpkkDWkIRMzgxY6+CGcyPWlyGmr97e9Z
 Y6ItOYOmGHuEKWG/glnovztlOzcwByWimTEJvaoahD7pOz4pMTfHeln/wOEvWynJWgJJooPSrY6
 Hn92tl56+ITeViLTSImYwmGcHPB2BhkoyKbhCUFRbJ5Fd8f/vyotRFNyMVKPRmZmn/PgOs7mLrT
 MegsHb5aU1ZmfKlDSV/C4IsTu2chkUpLNXGO0t/8oBkojMSnabO1Eb6EMq1MQokIV2MFzLTopAW
 wcCY0h+LwlPMgpTEbTENetJULVECI9ZfQP9XN1Xld5EQQ1JzqodUn8MuRjZp6wowFKBJt13+bZo
 Z9CPPErgq6k+TfjsJa0n+/5mtDrtIKZ8nb06JCcycz+hvQoSwvt2KnUdkZt8GI6RLo+Qj9zb
X-Proofpoint-GUID: PM3pQxipP3cRXlXoZcnNBEA318MhALeY
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=6881f9a4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=XzXpDewkjVZM1V_qIvIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: PM3pQxipP3cRXlXoZcnNBEA318MhALeY

NAK. This series is completely un-upstreamable in any form.

David has responded to you already, but to underline.

The lesson here is that you really ought to discuss things with people in
the subsystem you are changing in advance of spending a lot of time doing
work like this which you intend to upstream.

On Thu, Jul 24, 2025 at 04:44:28PM +0800, Huan Yang wrote:
> Summary
> ==
> This patchset reuses page_type to store migrate entry count during the
> period from migrate entry setup to removal, enabling accelerated VMA
> traversal when removing migrate entries, following a similar principle to
> early termination when folio is unmapped in try_to_migrate.
>
> In my self-constructed test scenario, the migration time can be reduced
> from over 150+ms to around 30+ms, achieving nearly a 70% performance
> improvement. Additionally, the flame graph shows that the proportion of
> remove_migration_ptes can be reduced from 80%+ to 60%+.

This sounds completely contrived. I don't even know if you have a use case
here.

>
> Notice: migrate entry specifically refers to migrate PTE entry, as large
> folio are not supported page type and 0 mapcount reuse.
>
> Principle
> ==
> When a page removes all PTEs in try_to_migrate and sets up a migrate PTE
> entry, we can determine whether the traversal of remaining VMAs can be
> terminated early by checking if mapcount is zero. This optimization
> helps improve performance during migration.
>
> However, when removing migrate PTE entries and setting up PTEs for the
> destination folio in remove_migration_ptes, there is no such information
> available to assist in deciding whether the traversal of remaining VMAs
> can be ended early. Therefore, it is necessary to traversal all VMAs
> associated with this folio.
>
> In reality, when a folio is fully unmapped and before all migrate PTE
> entries are removed, the mapcount will always be zero. Since page_type
> and mapcount share a union, and referring to folio_mapcount, we can
> reuse page_type to record the number of migrate PTE entries of the
> current folio in the system as long as it's not a large folio. This
> reuse does not affect calls to folio_mapcount, which will always return
> zero.

OK so - if you ever find yourself thinking this way, please stop. We are in
the midst of fundamentally changing how folios and pages work.

There is absolutely ZERO room for reusing arbitrary fields in this way. Any
series that attempts to do this will be rejected.

Again, I must say - if you had raised this ahead of time we could have
saved you some effort.

>
> Therefore, we can set the folio's page_type to PGTY_mgt_entry when
> try_to_migrate completes, the folio is already unmapped, and it's not a
> large folio. The remaining 24 bits can then be used to record the number
> of migrate PTE entries generated by try_to_migrate.

I mean there's so much wrong here. The future is large folios. Making some
fundamental change that relies on not-large folio is a mistake. 24
bits... I mean no.

>
> Then, in remove_migration_ptes, when the nr_mgt_entry count drops to
> zero, we can terminate the VMA traversal early.
>
> It's important to note that we need to initialize the folio's page_type
> to PGTY_mgt_entry and set the migrate entry count only while holding the
> rmap walk lock.This is because during the lock period, we can prevent
> new VMA fork (which would increase migrate entries) and VMA unmap
> (which would decrease migrate entries).

No, no no. NO.

You are not introducing new locking complexity for this.

I could go on, but there's no point.

This series is not upstreamable, NAK.

