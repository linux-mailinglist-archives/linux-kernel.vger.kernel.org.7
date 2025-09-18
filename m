Return-Path: <linux-kernel+bounces-822748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91863B84947
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 007157A5B61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591472FBDF5;
	Thu, 18 Sep 2025 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fTALjnrd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i1VnkxY6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5434BA28
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198480; cv=fail; b=Mte0Ezo8lOqRBTm4kMlr+jmVP4pV7Y1I2PZfwf0t7ZItZC2uCwVrFl9m+ySGTWncCtUJfKYYNHtfknChxK5ycxrrEvTf+rLkIHgygiiytZIBVezrluvglUKzos1F+47Kttp0ZNWDS9Fkid/YWa+QStEw+tuceDLvwLpBBkjSpIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198480; c=relaxed/simple;
	bh=cvIWsQGfCdG2vOF+L5f7JCHAtImctzFnrTvr7FVdyVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MmUCxptY/mTSaevRb51JlNWhG8OswPTL6SXTgsxqwHULhUEvUHYCAUcnMBiZ8KqY/LTzfGkeJ8Ziubf07jRmYOPWynHtpr+3vQ5Bej+S446QRslRFOAQEd1Xg88S70K87n08zP1NHs4WO4cjklhKVSCCF+gsUcXP1tXQuDumxRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fTALjnrd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i1VnkxY6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7ftid008949;
	Thu, 18 Sep 2025 12:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1b+xXgTt0/WpLM7/YB
	9AP+xxQ9vH+o42/IQrfQA9o1E=; b=fTALjnrdCGdsgf7j/Vdh7bnz8t2sgCaw1i
	JxM8ZdiWCESP3NvzhiDMNMWbg3tj9nRr/ak0BsHady9sfKsjjyG6VIgZpD5VaOA6
	5B+AQLJzJA8LQh3gSvQrcOkKINm+hWhveTP7EnKSbGAtqDdN1IUbgiPQIYriwfrI
	VmfU8AR17aHzqHR4qzV/yChdNJpo3yDneIEPgSW8ah0CS1gyvULalBVn0Urci/Bx
	1RSHkfiVSoYe7nzQ9e8AZWAirKTQIB1ux1Lk1MC8q3iEpOrj5L/IEeU3SPYXQk9B
	WbSxf9fD/B6FNffPuUHNPdpMlZWZHYKRZhG2TQ3h/3zNdHK2FE2Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbuc1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 12:27:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IA1AuJ028777;
	Thu, 18 Sep 2025 12:27:35 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2f1vgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 12:27:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJHP5UBktqQ8zLI7jeo4DF8npF1bEhp/KlY/irVoBzq+t38QJDYgGgV51qj69H8hI0FydkwjengK6+G3ye82eYEnCT+0ppBQB9JdZ4hgYlKnZWXJQBX2lKJ/CshzPtAdYhG4mpITVePkqNsFk/mAhMo07gmJY6t6XjNF6bAbdK05E4RHkzo21r+EazSN68qWeatHEJJ18LwKZ42/ySdeY/LkPQ6v5fAMDaw133hIIDXeOtB3NMZWHYHTDQb/JkeHc9U0YeWKByXACqHNpbe7mtjF0pPx34RPDIWx/4QnXsKT5ECwOSwctTIxH6jWXPSvl2rxMr6tHB8zZtV1PsnDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b+xXgTt0/WpLM7/YB9AP+xxQ9vH+o42/IQrfQA9o1E=;
 b=rvp52D4u0mRzSUdoB3xORnIO3oz9TjMoAJS4k2w1i6idyohuUmnSP7DGPp3LPBgySRvOrGacFJp4iRSYx7FR131h7SjLYNNcZjBKIwa1aq1MwwuoR3y69nDwbJ1pUZbbCOFfR+ysXmOHSe0VeH+Wx7hL2IGyBxLA4d861BkDqBR33DXDkZvCOuZnUf8+1RkEbTTv6QRIGu6rpqEtRKdb93g9d1kvPyiXE9XKnKXBi4j9c9s0b7/fZzBea+3VQVAZgCirUebUOTd2V09PBmrYRGU5LZglpF119zJmPHKBwJfoALqLwBBxLWasSujA5qRdQsSh0iWMk0hyACYUDZFSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b+xXgTt0/WpLM7/YB9AP+xxQ9vH+o42/IQrfQA9o1E=;
 b=i1VnkxY60scQ93AwxRp+5bbhb//Rh8iRRy8xiT/KrVldQiDznkyZM2EP746vx7IHPUN6cZo4PR7YKUVb3vbALVhtJRaSKG/4uF3KldQp24dJ9GhutuY6XOo2+JVBBdUezowWaQ5iolSwxCYfWHp0RgHnI+zPR4ynE3mu2uKJepU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7192.namprd10.prod.outlook.com (2603:10b6:8:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 12:27:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 12:27:32 +0000
Date: Thu, 18 Sep 2025 13:27:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Zach O'Keefe <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mm/khugepaged: Do not fail collapse_pte_mapped_thp()
 on SCAN_PMD_NULL
Message-ID: <a4b053c7-6eb0-41fd-bea0-7231300199cb@lucifer.local>
References: <v5ivpub6z2n2uyemlnxgbilzs52ep4lrary7lm7o6axxoneb75@yfacfl5rkzeh>
 <ecac1e7f-1709-4348-b8ff-fa1c0f087548@lucifer.local>
 <CAAa6QmRaiKB2OOpZYjRx3EAQ+d8_G=MsVmV=9cc_MmHOYsikow@mail.gmail.com>
 <j5pf6l745hp4r56fndlshzcjpyi3nttgywouowhmfiewx6p56j@b64l6tmupykt>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j5pf6l745hp4r56fndlshzcjpyi3nttgywouowhmfiewx6p56j@b64l6tmupykt>
X-ClientProxiedBy: LO4P123CA0313.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2f05d2-a34e-4406-6aef-08ddf6aebd89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qiPNJbsILOfE+2hT+8z1KdksHvyqw/iKXud4ATikQ9kdApDiuYCpC8w8uat9?=
 =?us-ascii?Q?U3bNC5ok08mZO1XnNdasX1b4uoYMVCzxDwiPopOXYkPxvu0we+jvLrhZvwE0?=
 =?us-ascii?Q?3c5ieqn2Z/joFOoMhqACMcHLqZr2Dbn+zlkFkMsDX30l/bttHZVlgMNGjRXG?=
 =?us-ascii?Q?3VEVJA1SvI3SbaTqFQV4CBSqoWAxSNM/Q5y00z6RlL9ZZOsafFuTVSrnC5Hw?=
 =?us-ascii?Q?yJ4VQisa2cxChoQ6zC76xRdMMhwDQ2sPuzI3FjcU5ooJIIJHriss6EFUwawL?=
 =?us-ascii?Q?utF6TWn3J8dqYgXRtYicX/01MLly/puw+zpHz43Q53KoMwHmMrsc4tePEJ2E?=
 =?us-ascii?Q?0PHlmoGnHOpaIPRS6argROqQq6TUyAIQou5NPniYVRjW3nPNZ7tpndQ30GwI?=
 =?us-ascii?Q?u46mxMYIYtAeN9IKXEW1k6G8uySMEcmgOEXd6py/R1UElgOz8bPpZ6rtRCuw?=
 =?us-ascii?Q?hEkag3X1e/V5HnIRk913oyZjqD2hGA40Urs48dQdC67mzH162UNoTyBiAC0N?=
 =?us-ascii?Q?CTAvGeo7O/W/XvurxnHpK2PPS7flyuPksHD9hP+zWzmcINFFTTMEo2ZqaLuR?=
 =?us-ascii?Q?pQD4x9pAMpzKXiFjSWCjQudmsugxE3voBILhg4KKCKG9T3a5l7bB7gt0xmY4?=
 =?us-ascii?Q?UC8+NVb0XY0WORa4S1F2s9l1P7ymHPUeVPpGQqHARWViUd0qrrPVYM3IfFvA?=
 =?us-ascii?Q?cDsGlai8HNgsxVLVMD+ne7E+zotdXcQjyi/lzASlKGUwNmW8M7jTPJr/NaN+?=
 =?us-ascii?Q?5GXJJ7iufLhG3UN39phNcFCOv9ehJktv7zBqP8u2aSj0eWjdl5XMw6c9OIGQ?=
 =?us-ascii?Q?O0fLSTp8+kpXeJymbyXq/skH/UExj4kKmjV1ShPmad2FQW/+QahEXa/ln2qo?=
 =?us-ascii?Q?kch5BXfWUwPVBP5leNg2mfm4CZ8/sclR/eajg3pzLc5hccxcruHNEuJ95YFu?=
 =?us-ascii?Q?9MXMp2qBdykGHB6YdoJbfEzVanNq/bGziIwwpoiS786iyygbLQqWP/HUYpvq?=
 =?us-ascii?Q?3nuiEB24wGBd/ZyQEq+J4h/NF76a5J9Ng7rmfNFZOibkytUR2vU1D81SEhLA?=
 =?us-ascii?Q?KCmmPgzVijptUI9LWtGBL2UgzMxrnze3BxdVfKNT/6EihPZe3OPVz1L2fLR8?=
 =?us-ascii?Q?pYLv5Mb4PYdOlHgL09lcLJsDejPBa7F5NJrnmisK6q+BhSnBZWBixNpwW1pC?=
 =?us-ascii?Q?W/OgywXOpbK/213aGNWsQik7mpJapk6pElCwdHaBXh2TeL+Jk1zFl8PT1GJ+?=
 =?us-ascii?Q?YyMrTSrYyAklezYipJKI7BHuNwQIt/wER7ynLeAD7tMSbNtSDGRGjEP8/Zow?=
 =?us-ascii?Q?umwkDIxZDsnVzwAl3D/X6VNZssliDrV50stR8WNUQoCbbpY49cYYjlkefOew?=
 =?us-ascii?Q?b/CsHYZgoj5yuJyK7FT1gssweyhBfAmfsl0OmnpOQ+XymcvYoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQbrftSmnkW7jHMijSKJfLRpcnyHXcqA2hMuS1jOc6NdQ5qxC58pDmgblvfP?=
 =?us-ascii?Q?tt1ufHwojGKOQAS97uhK1EDHxQqoELCdJbN2XN55uIQMmiEEE04sHML2SLun?=
 =?us-ascii?Q?EdJmPG60ID+Lk/vMRHeqkjjOSNNOIlA7sstgHajtaXdnl78lGzqXFhV56I2C?=
 =?us-ascii?Q?palSZqhJ5RVBAL8lwVYU9LaOB+MPDW3kVc49R4OjmZlTFn5u8rpyu7ogIH05?=
 =?us-ascii?Q?3Bgn3rGd6QMCcBfZPrihzXuj+lxFoZU/go4zLOrWqr+HiSIo+X8UtyUk/bHD?=
 =?us-ascii?Q?8wztt35h76P06iv+NK/7OU+cmc38i/yIWD2YvzlYtvPmKD04JRBwu/0bMctO?=
 =?us-ascii?Q?cNwPnhx0NOWHMgQddHRjfV+5sGzH3j3pEp1AL8mW8+j50ZrSi2O2Os/rl0Pn?=
 =?us-ascii?Q?nEP+suEi0cXz0yiRqsWW+jHaKdP9pFLmMBkc+v75hCTp8r5+y9ZBXQeZXF53?=
 =?us-ascii?Q?Q5Dv0L46H+Mi/ugfmoOb4++EajBtpQnSt/MA7x5CR9ta0NxdPh8WeIxhI1xg?=
 =?us-ascii?Q?stpSPiMGd1FfYm64/7yF639wkKygJAqAq0+Uz8tSufDBEHQW6MffijZc1hgv?=
 =?us-ascii?Q?+5189aIdUvxH4sFP1h9ErR9/bcMEsmDixAt/LklERcldjXVviAIAYbAmCnVr?=
 =?us-ascii?Q?0Ns++MxyE5cppGe04+KoLusC32+/86iY0GJ/wnFbK3l/O/0iLBUi5EcXV61f?=
 =?us-ascii?Q?X2meOGX29oFP8+dB8hQg+H+vDmnrlMOH0MmeA8oINWZJQV2A8JmvI9UlKf8P?=
 =?us-ascii?Q?EqyHyyNJxAd2FR6TKfjacCn31pTjuj0fTo0ixpxzuZmzL3tAUGp3zlTwOLhU?=
 =?us-ascii?Q?B4ubVN03aA1FU8rBgF5Jt2rNpdd1PqrDAXyj8tk4zZD4mP5A3nq0YTmrOGIX?=
 =?us-ascii?Q?SUGllGjmqX5m5E+KYF80FmhtY0d0m1ryW5EOWd5jBYWzeZKGPrBolZ1Z5lOP?=
 =?us-ascii?Q?jxzNYXha7OTLOzXCGefq2oQ3r6F2ubdLI7QV+gTue5nVVBQxBfAoU9IbhUXq?=
 =?us-ascii?Q?vD+P9ZSDBC+m5cRpgLkoue3wMmVTLpLPyK739kg/YeryFBtlA3bGt6u22kF8?=
 =?us-ascii?Q?X+IFEA9vx4DhTf+fU5ZxZhRh2qN9FHs+DUlqZP0wmXjzD5Wf0DwAugCgUEJf?=
 =?us-ascii?Q?hPF7IpQZyXECj90elbRpDCFdbvew++LINU0NhUhb2DrusYLEqwlVjYyLNuYr?=
 =?us-ascii?Q?DteYs+GMrxhWHxVc37QFj1oJfVIg+/4uGAeOdDsS/DZJXh2QJyZ3APFSOBri?=
 =?us-ascii?Q?pOSc04mGWz7kBabnijTmQYbprN3t7spNVQin2KztAyOEYzyBeKnjoRHdFQx3?=
 =?us-ascii?Q?9baLnsp4HFDX5/56MvqoY73azMV1COoLCfzAxmy82timAmXMq0S6WJDXcsie?=
 =?us-ascii?Q?a+6TT4AMLJTFIc1h8Nau6b/BUlL0qRRMIrT2Cde8QcWsOYPT3LdkZ+UzKIGw?=
 =?us-ascii?Q?InMTlIpvhFdhtONblVKBTVVfzMGO+shc/JhaTK0AVxPWXfCM9jCzMh8HqboU?=
 =?us-ascii?Q?Ap7dRqSVvCRAJi5qkU+HcvUqwu/mS2lvxVe5aC067CB/7dZijMKUU2w6Ks8n?=
 =?us-ascii?Q?1OCVQEqS+WL5g8/LzuKktU+vpc3HAeUT+3plQi7mVQHcgRxtBX2TkwdStL5I?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SAAT9eeuyjconwL6mD/2Z4WLWAb0NwwGMD23GCyofiG29vi/duM0Mku36onC3AxfV7YHwwm0mfTTDRUj+Xi5J8+LxOO+PwDJ+KDzK0+FRsYy5bTQoM4ncEzBKPOK/QWM0ZNssCwz9nQluTg75VbGMZhORQdBdxT/3MioQnBZj1NELNool+ef6+VaBEIPYyQG9HyTgIGbqYgSA2WV/1XuaWkm5/sV0HyHGAezgvSO6IvIl46yUu+W8/WEJbSclQi/ov+zlvfRzN/j20xSL2b9QE+tyvWG4SuBRF25YmwikPKbecy6pRaRwl2jwq6isZhTK9M7zPy28hhB9SsSNFcDuYBLT5AfRitXspzWlLhctqVY9zVpm7XJjQ9QC89Numj7H9yyxktRdz7627t2S+lBskoIFU2JoDvpDfrAvIzSR4DTtRXCjlqCKx5oTFecTCF3W9pNaC97y52JjLp13uR5zyNl5efKIAPpCy6YoRV5Jb/qH0uD+lW4lvc5tIs37zjy6xBF2+0bx2k/nXZVJun84gT2dIOzFvjFlSusFF1l/QMebW1GNnAojWwx9XQo4SNhIcyJwsPGF9uTV3vQBiMxjZFETI5us5VpaQmCqo28GbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2f05d2-a34e-4406-6aef-08ddf6aebd89
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:27:32.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fWm5+yE+GmpJipz+IAygSsIwadh7N/uVdm29v52XzT0Gxr23k0kkIhhRVx3pIwD1+7Li9Au7a0ZdyzJcCXcw6PMeFci4cHU8T2RQ/QEZuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6bQbzG+TgF3s
 c1hvjPvOVqcSPPdZlqI9yMY398ye3A7cw8WsbqkBocNETn91v+3DOEOZ0NwP0YSDhs54i4HwzCT
 BsxfgyaD7l2v+Nsj+8pW7YIFudbdC9fZJ8RgvoIDMNojZquXwQ3nTCefR1LmJfC+KTdScACPJCu
 ATcVtkVgwRxUZI2phjkP3YVxUQbu1a2/nG4DX3Zr8vRtJdiY2uR5eBicuXardPVbRfLyUzBoqS8
 zRkd6oCAP2HmcaUUp7EbRflBURlOLIcwv4Evo2C44kk4/aA0TUDzwV3T4bShEAa7dzdBW1TaeJX
 I+tEINgZI0ZoA1aP1/PaaexwEDUFuTQ9gmqnpbmlDAQX/p825nDIWZRK1XXfe0dlnK9pyNK2KmV
 qtrD4x7X
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cbfab7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=uFO3qpeRqfdXc_mWwhcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: vml8ddwtmoY9XtmFOQfn78BR0vExJP0F
X-Proofpoint-ORIG-GUID: vml8ddwtmoY9XtmFOQfn78BR0vExJP0F

On Wed, Sep 17, 2025 at 11:52:34AM +0100, Kiryl Shutsemau wrote:
> On Tue, Sep 16, 2025 at 11:06:30AM -0700, Zach O'Keefe wrote:
> > So, since we are trying to aim for consistency here, I think we ought
> > to also support the anonymous case.
> >
> > I don't have a patch, but can spot at least two things we'd need to adjust:
> >
> > First, we are defeated by the check in __thp_vma_allowable_orders();
> >
> >         /*
> >          * THPeligible bit of smaps should show 1 for proper VMAs even
> >          * though anon_vma is not initialized yet.
> >          *
> >          * Allow page fault since anon_vma may be not initialized until
> >          * the first page fault.
> >          */
> >         if (!vma->anon_vma)
> >                 return (smaps || in_pf) ? orders : 0;
> >
> > I think we can probably just delete that check, but would need to confirm.
>
> Do you want MADV_COLLAPSE to work on VMAs that never got a page fault?
>
> I think it should be fine as long as we agree that MADV_COLLAPSE implies
> memory population. I think it should, but I want to be sure we are on
> the same page.

I'm definitely in favour of MADV_COLLAPSE not requiring pre-faulting like
that.

As long as nothing is assuming that an anon_vma already exists, which
surely is not possible as we ignore in smaps/pf case.

(Oh how I hate how anon_vma works)

Though would this not also impact khugepaged?

thp_vma_allowable_order() called with TVA_KHUGEPAGED are in:

- khugepaged_enter_vma() - does't matter really, one VMA having anon_vma or
  not should be immaterial to adding the mm to khugepaged, not hugely
  likely _none_ would have anon_vma...

- khugepaged_scan_mm_slot() - well, we will require at least 1 PTE for this
  to succeed anyway right? We might waste some time though. But probably
  not much.  hpage_collapse_scan_pmd() -> collapse_huge_page() tries an
  anon VMA lock, but would have to have found PTEs to succeed...

So actually it is fine to just remove the check.

>
> I also brings a question on holes in the files on MADV_COLLAPSE. We
> might want to populate them too. But it means the logic between
> MADV_COLLAPSE and khugepaged will diverge. It requires larger
> refactoring.

I think all of THP requires a larger refactoring :) but interesting point.

>
> > And second, madvise_collapse() doesn't route SCAN_PMD_NULL to
> > collapse_pte_mapped_thp(). I think we just need to audit places where
> > we return this code, to make sure it's faithfully describing a
> > situation where we can go ahead and install a new pmd. As a hasty
> > check, the return codes in check_pmd_state() don't look to follow
> > that, with !present and pmd_bad() returning SCAN_PMD_NULL. Likewise,
> > there are many underlying failure reasons for
> > pte_offset_map_ro_nolock()=>___pte_offset_map() that aren't "no PMD
> > entry".
>
> Sounds like a plan :)

There being differences is kind of horrible. So yes indeed, one to look at
:)

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Cheers, Lorenzo

