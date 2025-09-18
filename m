Return-Path: <linux-kernel+bounces-789746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1632EB399DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861567C7BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128B130E0C8;
	Thu, 28 Aug 2025 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OHfSj70D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RVU8mt7I"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A230BBBD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376858; cv=fail; b=pPn1Cq8XVQkhynRBG1SURdhIjG4L6Zq7a+blELBR8vD96sFea/mNMo1SgsUY7vlczYUbsT+5mBuPGfM+me2nVxvk9TCXeEOgFH8UkKWP5lQc3qq5siYwjk7Rt0SEZFY/Yh7KmYAbOcVJ07NMfgkUxRHCrwVj1EGMzMME7KGfsXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376858; c=relaxed/simple;
	bh=XaPJEbxXfpI/i9pdLsQfpx0wtwRhYFsGTIz3R/uZozc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eP4IR5HjkRjWy4zIxHYOjw0oo3qxy95v4BgzyCnIi1j62QTXuyyxSfEddP8vs8lpuGqDFR9iR18f9AgQHFzygl0RtiefHEsYaasWR8YOnN4i2h3FqE87sOY/67C8+V7HbsK58OZtt9tUMvYo63g9vvkMt+dN8NLFtd8WxEzoIUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OHfSj70D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RVU8mt7I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8tl4A015495;
	Thu, 28 Aug 2025 10:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3NQ5Y7y28oB9C1XiL+
	g6MaJy2HY8Fa+/vV6B8hagWro=; b=OHfSj70DQOGoYIYvjDVq+1JSngZE2VLOIZ
	1MlJLDVfWrmfwhQay2xPqowJ8DXqPPdHZ8BjCZ6dDbKxbB+2VwsoVU6/nD90Ij8T
	rDNhDDkgsRtH6qLlX0FAvJOu25jea+u3ZjyXkG+a9U998dWH6z/uJmWxXe8hm3EM
	2M1jUIpbHrDYFM7YZxv5yCs4y00YpQGzYRJDkz26arsDKDf2nXPl3hvcRwyEiDza
	HwiGsqB98Khf4TmGiGvpPmyu9FZ8wghmX1poaK9YolJ1dPJVeqgbVRbdDhmI/gku
	A1GJcGCZMPuG7V0FqQrqz87dIhmSYBEFIW6d/FN8YVRhIvWNtBvg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt8bk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:27:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57S92s0I005206;
	Thu, 28 Aug 2025 10:27:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43buk1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 10:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+z9gNeRC+IZorzhB4wcAh9joW2mF6SVvUTlG2z3wtHKp9PUAQwWaCriiQ+AagJRcOFuk6vxgMOlegJXGRWnZp+qzUbcwKJFvZC92b2fuCPBSW7JtT78cFCjSR8y1KFyDiRUDXiKVC9HUUwydmTEdliyl4Y6txjaoakKZrfp9QGRUuBvQ9ph/+66v8BM2CRnPlBn8lqid3aiZo5hCm7QcbkPY7K119mbOUGC+vK+QQTiNXK0l1FoxPe7WmOMt+r04lkuhQrjZ/O9FrDXWvqXuBsmC1XXdlX9J0o5bHgsJB5Hr/0VbhCkcYBxf5eVB8LTPsvJHrlBpJVN2FnfQz7gbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NQ5Y7y28oB9C1XiL+g6MaJy2HY8Fa+/vV6B8hagWro=;
 b=xYiywcwv9KWy7/wBzdb5oZ1RqBNytNQD+tWJcfJZ2ahSPheedkNiFOfGl/Ltpfc7cq/oxJlG+49+Xpw8a/9RfbX0gfpAyR3XOnS0JHSPwCv5EgTmx7j9B9d4WVOQdDuGp5iiHxsou2S1p67Y0wx2pZrMpLJKQZ2I0ejvEl4ramJ0o2jvz5sde9/bN5l3xvJ2lUL1LKjaKmHEfXg6BB3aSA18Qrr4rXSX8imNTctDpB5y+6P4eQ5OuDzSaDVlIX+VAxr3FtHSusGK29JryT2XErLsM7hk3sYOxBH97XrOPxSU9buceU93H86TPkjM71janzYdluVUleoal3uVAjstgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NQ5Y7y28oB9C1XiL+g6MaJy2HY8Fa+/vV6B8hagWro=;
 b=RVU8mt7IDvAXCZIIfmlJFqVjgZCp4ixKaHKLiRNtDJuVpo100JySjsgsXUPMCmWkV+DdjNoMEbGEm/RHj/oh325pHZ5Wt4QD8WwJdsKJqtF7RSNteBJb6fC3n1qcPgNSVghdhhJV1aGvlAmWWcoR3KQybDCgCRgXnytuAP6EOmk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8544.namprd10.prod.outlook.com (2603:10b6:208:56d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 10:27:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 10:27:19 +0000
Date: Thu, 28 Aug 2025 11:27:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] tools: testing: Support EXTRA_CFLAGS in shared.mk
Message-ID: <1f2050c6-e0df-44cd-a241-6cbfd9ceb285@lucifer.local>
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
 <20250827-b4-vma-no-atomic-h-v1-3-5d3a94ae670f@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-b4-vma-no-atomic-h-v1-3-5d3a94ae670f@google.com>
X-ClientProxiedBy: GV3PEPF00007A8C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::61c) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f53f0d0-d582-4447-db1a-08dde61d77ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WFpxE94aIF59ZSju7AXN57PajKtFbxyfBkbf+vUBngZaKjKPI4r/ZHk5MuiY?=
 =?us-ascii?Q?awQ+VljS3hy9RSFWHF77O2WykYWXWzOuQJZxt6GPsCdWehfJBiOQjKMYe8ze?=
 =?us-ascii?Q?bHDtDHymVLMIRzEES92NUbt/+IsDmLt/e7FsAfIqXShMDgsASDTQsiMNBRGA?=
 =?us-ascii?Q?YYkg/V43FyH8ZPztOquaboXaiCOmdu5EF8afoPzT31ARwhRR7VyP2iwH5ps4?=
 =?us-ascii?Q?NZpWjiYs/RN5sv39Hn1LwTWmAGlhY+I3fNNMaCpGpnVi5o/pUIbB39tEznN3?=
 =?us-ascii?Q?gy0gWndHptplA9r8wlYh0En0jxsXvb+64JQuVfU3ffYl+6dFNkyq2AE7GhS2?=
 =?us-ascii?Q?dIaUddMrsQ7Xum1dFq2cW4XZZpfjNzUsan+Q3ym0NEfXq/Cj5BkFTptJ9/N8?=
 =?us-ascii?Q?YZGefmyC9U6ge1UVfI6O7uVuSfdXWxcqycnrapiJkozzch2rXGJclMhDsZGl?=
 =?us-ascii?Q?EV7A3KnIvlByVLLNT9owl6KMOOxgQZCKgCqaX8mCzULbxCXTjpT0i2s9l1sP?=
 =?us-ascii?Q?3lBvqZyrWXVpQYQWCuKqiTnVSpJdgXgW7/7OrxDmZbzdzGT/ELyuAHHBuXta?=
 =?us-ascii?Q?ZkGFcdaWijR3cngW+gdaNuQohjH6grQTd1xtIR9rNvGVy8KRc9bQU4mesjCi?=
 =?us-ascii?Q?CDoxPFCdBDvGs+NRpu/Tjwv6tkdoOFpD3LGQwhfATT/psc2SRxTwNnMHacxL?=
 =?us-ascii?Q?Bj3GXlwv9mDWpLstSAornHizh+yGddYU3eVhmqW62ydu5bVS9Cl9hGoowaG/?=
 =?us-ascii?Q?dGIOywEZU6HW2WyerqtUI8QTc6vIKcI//P6vmsrSm4JHvz+iTQl44CL2gVwy?=
 =?us-ascii?Q?f85ivFD0g2h/meaJLqBbBuhqIaEQ63c1Ve+xxN+YOKmRZMcdfRweyPw0NFPv?=
 =?us-ascii?Q?RlVIFuDXqQZsXGw/pEJe5NHW/tX9qJ/B4j23lNe30l6InwX/tM8ZCHixYKvi?=
 =?us-ascii?Q?WDPeWgLGxugADvqNoxEnqq279F5IBKZzCh+ygYncPykBI4vEE2xz7DSgsYWo?=
 =?us-ascii?Q?saJnGFXtE6rXxFoA1YvEFRgDcUpLmIc310ME7d1NCrYOKEzZOYY+kCIdHEzQ?=
 =?us-ascii?Q?cVcccz6tZ7znwh/bqkw1HWXFd0LuM3GFObussT0UjmIviHc7ODEXDPVwR9g7?=
 =?us-ascii?Q?r4jpOxTDtjiWwRjiIFrDNAbrLSvQzkYoNVhit4nQNQdXp0adNLlV0OqapgHi?=
 =?us-ascii?Q?lOeUbpgrLDtJ+wqCmosrUs4J6nLRuqlZ+ZTBDrzZsS60RISC8khxqO2ve3j0?=
 =?us-ascii?Q?PEGt19oJ9C0TTJP9eSNQogpAvBSmIgpEQHNCupRPcVhz8ry+UuP1w8mFNpCg?=
 =?us-ascii?Q?sM0EWTs8bsBzNegXQfNqyUdHYB3EgGOm+Qu36vldiYKG3K2lTozzGiycVzKI?=
 =?us-ascii?Q?IhlLlXX57yJVNG76CL1/KaL00VE13pEKx93kSm1K+spXS5UaE9BIsIIbKxq9?=
 =?us-ascii?Q?VRlPUXqSbSY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/96i0/VVTIOdyaWYB36oWI6Kun8E5ueTifMRqsbbH3+m/bUB0zNdVaO2RBVt?=
 =?us-ascii?Q?3TCu9eRHQE0KCDSGmlpE7TYGN+ZnlMPKhRJfKtNRlN2WDfJfAE2Kvd+dxadF?=
 =?us-ascii?Q?Rm4rJt3j02qft1nu9SURyINVRUkCQCk00yBPCrQ7sYJ6uubOiq98Xs5/S/pd?=
 =?us-ascii?Q?WHiYO8XGc5/RXGNCZuiuJuzZ3v26IsaqmfpmmI58zpYgnV5TLj+x1usmNwuz?=
 =?us-ascii?Q?5OcIIl8LlQDBU2hO6b3a4XflVY/OZgVYQ37LQy2oiFmDvQWkYII8Cz+nzT0O?=
 =?us-ascii?Q?ze2EMamZQUEWoa+GQi9LCl9tScJPPQLnakAS5JhnDKTfgKYraiITLtZbT32j?=
 =?us-ascii?Q?73cCjlaID/EtWZ9o4p0pMz80fLdA4o4lhlt8/4fHRAEm6mB4t09W3AerXJbK?=
 =?us-ascii?Q?eo6tevGVXWUIYS3BrzquONMBXH+VbDl/1YFZr1l7jEVDigjVGhie9GkddosD?=
 =?us-ascii?Q?GnvurI5bXs8Vp9zhRGOEBScLlV4Pdv+4eBoCt1tVQ6Y9O6/vk6bTxajb5Cp8?=
 =?us-ascii?Q?5tclEtvx6TAF8dwZgml0jo4/Dk+3bxGe8L0dG8OhmkwSx6qEndeXT3vFRDgj?=
 =?us-ascii?Q?JY0/W7vuG4BRpX2qWEPRwH+039NWyrgt9Ps5ig2IPq456jg8g7AFURbCzXm/?=
 =?us-ascii?Q?HGvjXyNl3aiU3ZVWHkTel/PEwf4lCWwaY9UCivnCUR9bD6BdJePoTaM7S660?=
 =?us-ascii?Q?nVja2Hxm46d3GzlwnJlALLWcSoc/uNXXm1g8a+rjQS+l5OcWeVas9Ui/semC?=
 =?us-ascii?Q?3FpDws+01bqWYj98etQB1z/DGr77cl2DdgrE8XR4wKjPBE6TNM+yyX2rlpTC?=
 =?us-ascii?Q?4z9YpLbBJgotUmf2Zf1hYH1UaITkWZgYLueABVoPQPGkyU/TSRaOJwLnAr2K?=
 =?us-ascii?Q?8i5tBK9tY+W7xhXJFbbcYFQhLUm7ejkT78nhjBheJtTX9MKoftIEhFYJA1lo?=
 =?us-ascii?Q?fv0c5P66gfbwr2yWBQIS+IUf90yTRV+V0r1bU6KItnFvMwOKhk0b1X6Mnxfk?=
 =?us-ascii?Q?V21bJyUmXUuqNxhSIQ9ALnBjlQiaKKZKHtZwLBVY3qXvjX1RtZVVtb57dLPW?=
 =?us-ascii?Q?bNcS4YY60Czgv+ieVW0uGQ3ozrqfj5QCbmIFWE0jig3tOCGoJMdO75rl5fV7?=
 =?us-ascii?Q?GeqFUJsG0NcJwjtDWybe5vmKTMEt7w5uS7UT9yjdJjctzeI0ZG9F3JXaOQ/0?=
 =?us-ascii?Q?DL4jSYg+bhehOxhcJ35LXytDwMRGYWPRq9lieU+xt5sukYJvj91wClg3PjGG?=
 =?us-ascii?Q?B7havjOUXVmSSUskT08ButY2JLfWeOTgbpP7lD0EohtOr6Cc2KVd2Cj2HM7d?=
 =?us-ascii?Q?7caTrVQ39zu3uWiTksIBLabX9NfeY4HI0B1vmjXBa9VJa91xAcBC1X3OGD9l?=
 =?us-ascii?Q?q5+rkQyyjlVyKJC2J181KEBQGQtGrcom2LbxRU/peDDbpvjLVeIR/GM0A4gM?=
 =?us-ascii?Q?+TO2ixUieOVR31AYWWZhFbafBomNiTieMJtVkzbmE6LSqFLEWTy74AxnJRXt?=
 =?us-ascii?Q?/wiIB7TIZi3xZp254o1EsoGvt+n9k48ebZ64rGmOCNq2AHiCbwbBwtKsnmE5?=
 =?us-ascii?Q?lEUENizMufq7CgD4uHPkQS82ScsJRq5R//GEX3Aa51ah3Tu4ayRgltUeAtuS?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GKpF6Hdp3LDDiKvTJTL5zhKCOBXTOoM/AgSsIzvx0P3Rsdt89AU6zqGLxmj3K/UzUjxtK/TLzoS898wjlmzmjTHZbU9zwZzh5LFiq/4OO8KLaP94P9CC1JIj9rmQqhvve6WW2CAsBCFTpi27AfNLXHArcfvA2LfNsfPRw9nqoOk+UfTSfAFmhCm6/MY8xuCPMmvzCK/V5Wa7oIs4m88XUTY9e8sq7oC/8Td0pk0aNNvrb6vnVilfneGhpatRT1GMYZBxt47VrMFnDPeK1oDE+G79vFTHRwNHWtIw67ds/JmDGSEsk5/64+ms+zAuWbe3JEqAsXm2Rs9/egls4p4WLFS/yL3I7qb46IigKCI4cxXuAsKYJMtKmz5NJWW0+ZFiI+od94Zm8WmkOwa2OvMC7tT5kARGXjwT2UnFGCQOWe8jSbEG9NDEItCkiCKwjtChr0Nv6uPC3B4NXxchByG4uh9DjbOfwRHVQE+EnAf49MALV1a0idMXhqcXhiXAiHrN+s9+uHa108mkFjJB3wKhcYFqFw6nWZ37TAb11k+q1HTORMIfZgg4QuOdNpDV9y7/21kaIpfwbWApS1OhO2gnWnWPD8INqHE5CCZ+vgeXqu4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f53f0d0-d582-4447-db1a-08dde61d77ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:27:19.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfrYMt/Ofi7WqbWakBpGTDCQ9SYN7EsQHCerUTOCsSICWzW7kmEYddPsPE+xO/p2ob7V53KGqYU62taHef7syfTTMa0HmDkv9PHi8Efen7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280087
X-Proofpoint-ORIG-GUID: qNwpv5cgJv7HlNWaz8mwj4Ep6EMhBQ8f
X-Proofpoint-GUID: qNwpv5cgJv7HlNWaz8mwj4Ep6EMhBQ8f
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68b02f0c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=AyPo10ImaQ0gHBvsUA0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfX6AZQVg193hQw
 87Acmh0O/gPc59w9Ijt5FWaqWinQnPZohNMeVi5BkC92fku2Z8JYuoCwD6gPd7HXX7hGR2mlQ5w
 SbsW4HrVIlG7XLN1nBj+cb9CCPMJgAPnGi20fENglPNZlw08idYbdTNzyONzIuiDSkDsGoWP+Ff
 OdFE633cFDCZ6KhQtAhK9qkHvimDWp8G6S4DFagQUuSyQE6w/cGG54snVv8E1a4FLHK3wWtRvw+
 9Y6cvzPEjKubdRqUUsQDsSKGtU8WawpmXRLntNBiIriIv5EAEK4l1Q3S4NcDVDEsXpbNv0/YaeY
 YkRQdOfeFUKumYnBsPQKk5LiVZt//mWHUgwyE0YiKm/sp0AVHQ1RLTgkUHHVuFLs+WJgNcHbkFh
 2trii3ba

On Wed, Aug 27, 2025 at 11:04:43AM +0000, Brendan Jackman wrote:
> This allows the user to set cflags when building tests that use this
> shared build infrastructure.
>
> For example, it enables building with -Werror so that patch-check
> scripts will fail:
>
> 	make -C tools/testing/vma -j EXTRA_CFLAGS=-Werror
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Nice this is useful thanks!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/shared/shared.mk | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
> index 937aaa7623320da1085a8e0f43f6a728ddd3ab1c..5bcdf26c8a9d51ab2cbd264f2f8a7445d7c036e3 100644
> --- a/tools/testing/shared/shared.mk
> +++ b/tools/testing/shared/shared.mk
> @@ -4,6 +4,7 @@ include ../../scripts/Makefile.arch
>  CFLAGS += -I../shared -I. -I../../include -I../../arch/$(SRCARCH)/include \
>  	  -I../../../lib -g -Og -Wall \
>  	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
> +CFLAGS += $(EXTRA_CFLAGS)
>  LDFLAGS += -fsanitize=address -fsanitize=undefined
>  LDLIBS += -lpthread -lurcu
>  LIBS := slab.o find_bit.o bitmap.o hweight.o vsprintf.o
>
> --
> 2.50.1
>

