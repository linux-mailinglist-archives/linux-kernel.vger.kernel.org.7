Return-Path: <linux-kernel+bounces-724725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F99DAFF63F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D2656523B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD0269CE8;
	Thu, 10 Jul 2025 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l7AxLon2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UD/eMiPR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D526463B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109216; cv=fail; b=gLqYqT4CyUXaKKRkEbv0j/l5IYUnne8I85uWRd9j87a6RgRW3uXArNr64p4Th+4RSulBri3Cb7k0rXufjTHSAYHT7FqWFx62yiaBrTfBgq+KFIlaj/OvRWUGcmMt6KaEewFUIouWe5D7Uooq/ov3VpXlCY963vZi/YCD9cL62z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109216; c=relaxed/simple;
	bh=3oooZ8SM1yOSJWZGDJ9IuroQMoMnoE0X5DNllDwNy1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MgOtebSit0vtDChXgOqOVrHMAT6gC/NyddoG4cVXRkz8+evOp6bZNBsWtdKOOT550xqk4L6aGTHI4O2w5aAL7pl2E5xvWjoBy8OIxEfenxj3p/nh4HKeHsxag6Vx3oZFB7pvjSwFZiaIUYMmp4ujQ+O7LLg9S8JY5DY7cbTr7pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l7AxLon2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UD/eMiPR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0HDqD019555;
	Thu, 10 Jul 2025 00:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BHfRDonrFd3Ok0P5ZvAEJqc1ZZl5CXYpmETngmoZ/iY=; b=
	l7AxLon2J+MW1o6A+955Yt4QmhUODpvP7bwZzHES/e7aawTe2sVFh4RHzUYZ7m/e
	9zHUPFysSUT4iFWYiKr8o76pvBzcmgq71oOoriIx2k/TjwR0PlBQnDw8iczkk6yk
	2+wUs172W5qcKnWvQKFo/mVDCIYTFT84Q6IcnK7uomBqF44RmXFIBJ1ZGeDZ7Jwv
	OTj/3WIzWEX513PbbwT65y6R8kPxiscXoimlD8WJRaFpf+hK+hbTSDyaEVOBXONR
	NsJNA4Mx4hEJFIcMMbmp+QKqTvxcDElL8DYDRQp0SztYp/2pXsG0sf29e6EYJT37
	s3H9l6bu7mQf7vKYRHu/SA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t2u581p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569N4JMZ027228;
	Thu, 10 Jul 2025 00:59:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbms49-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZvHhtksxAGJ50xtpuMbGaqIipsixX1s11+ceiVY/geum1t3tWxMWg7jpdMm6KCyT5wMwhmutcSRDBxKrmvnm/uZGfNPs6xAgdnT+HOtWPdOFgGUPM2l4X0o4d2GSMW72jz8VDF9J3akivQ3B2QxaKPfb0ifhtwlL98211SVUVdjU0W46qFp1t6Q9lSKK2VIQdDnTA+1s1sz8sPxGkuQtUTK72edZ6gfdcsXtFYC7VkXZYWaIjYGf2mbaN9QvFv16lxD023GbN+Yu+Jt4QLLURf71hy6TK8Uqfrvr++A0Gxioy9+N2F08Ye/jpSWHQ77cARKjNjbxsNgKPPqEvpB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHfRDonrFd3Ok0P5ZvAEJqc1ZZl5CXYpmETngmoZ/iY=;
 b=PybFvgl2PlxJh0IwV4GLlcKZvhZTizyDofa6s56zQOUgMLwYlT1XHJWNPGybDFcN7Wjz0UkJ/PqeI/Q9uI0MoqQkaYbsLxp0Xixjne3jMAIMQn3oU7fx/j227TirI4anoWgrZ9hj6XjYuR7L5CSwBrOOSvgjQQeq+cUbtKy5ie5GIhwLWeAbvHnckKliRQzzBe+F3wfeKT/CqtnzvCwWEWergy5EJmOQ0smc49heZLtFWJrUdAxR2Ag0v68QtxWHiwNcBuvoPqLgvUZLT3oJ+UrSEtBo0WTZBsTpi6oD98WnxvZmmAwV7E5MhH6a8OnQCnsWPLC8/ha9WsU1q/FUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHfRDonrFd3Ok0P5ZvAEJqc1ZZl5CXYpmETngmoZ/iY=;
 b=UD/eMiPRZ2tZoMX5ec4SLCify7JceUDEJGPJF0h6VX2al1vwPk7abutTHGLfenM+VZuzglBvgEXul5m37Xf57gyfJOzBtarCstubszJM3Sw6r5gR/5CFpJphcMPEKgIU82+rFYQ+H9+v5nAiCP+Y1rnzHgEb7qDUlKO2GTXAuZM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 00:59:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:50 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 10/14] x86/mm: Simplify clear_page_*
Date: Wed,  9 Jul 2025 17:59:22 -0700
Message-Id: <20250710005926.1159009-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:303:2b::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bfb25c-9009-4913-812f-08ddbf4d1276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIHcGaEJzgiKsSsDSGwRERgrecTCYNXz5wlPpDTGl1/d0UFhQnQkY/j6x3uV?=
 =?us-ascii?Q?D9FgQcXXlHo4wnDK1CZt3nhuy+cd0+nYwtA1nwkw2FywM2JE9uP6o/VMz2E8?=
 =?us-ascii?Q?MQk0/5Ol1mt6TYFcsA6gRvDvRoyxXFZTsgTMC5PwlgB5CT3+7IwZj6q+OEJo?=
 =?us-ascii?Q?LI4J2y/jWSuCF2NH63Y2HkFXb0v17V243EMfM5haO1xACGGvaPkyCI3fJLGO?=
 =?us-ascii?Q?C3J91B2ypCrNfDx1TMw9ps/cLAjwvX8S4U5Zs6tydxPGGeEbhnLYgJD77iiX?=
 =?us-ascii?Q?1zu616DmF4XSvl5O8xD2aAcqkPqCTNpixwBcCAwMVhR5UK9vr+BiDYHjxxNR?=
 =?us-ascii?Q?QHTuOMlzVVoRvrdNUO5zmoLmfmLqx6S0nyBtZw7mk4maLR7ks1eO1aBhRqR7?=
 =?us-ascii?Q?Eocp3zhQo4d3scHcxEiTiEAD7ccw9aQUtSMKNqr8G2nLUM0O/mcJUrUjshVt?=
 =?us-ascii?Q?BP/Lx6UzIqm129YNJDMY7kf2DJIb3nHM7EtZZ1DXO05h5M5jkysOaABlzLje?=
 =?us-ascii?Q?qGxIUnsdW1gsIVEjtwjNl7Y6wOW+ImKOaW2aHcZcCOU29NQgAKzqelISjKHv?=
 =?us-ascii?Q?Lk8uHQvreXdtK2yRrDguIpW5UC0irMXWresBte1xek1e6j6ZGCYJGdq4Cmo3?=
 =?us-ascii?Q?hOY8L8jitjUslSHiaur927VOGAcWYBlV5JMDWjbkqZT9qWS2MPprOp1LFH+M?=
 =?us-ascii?Q?2sUjDwfUDgkrZ7NqVXKZNfGlgN3IsfKwiBRfRqCtnn8GxtMMDO1K/0y7xcje?=
 =?us-ascii?Q?hn3l82EVKUtkntew46PP5F/QUJOz6NEFA0MSv4booR7JKg0QEgV+ASmEdCZ0?=
 =?us-ascii?Q?r8s2jCmZDg3mvG2zeTeo6TyYCFo2fHM7+axr4/dGHEW4bWwWlIj9LPReyfVc?=
 =?us-ascii?Q?20nCPaAoFctiGsrJxxF+m0+ALhZb6JP+DozqFmQPOSoq8bqViWu7SzkWoglL?=
 =?us-ascii?Q?iev/7vbSJ0u34fXSqZrcuefl4+5YzA+xmbH/rvgBHOzsKYs7Xlgj0J7ElSpb?=
 =?us-ascii?Q?IPb1aTGlo5PiFlzeb/NnFWBBWCo6ZPVLpC/Qc/4DHZnbRVKlvsHYGq0WH32A?=
 =?us-ascii?Q?BAQATL6dERke2OeXLVc7GHHNABRHcXQ5KGfwqVhsGbTkal7XEcvFQhdCrk9a?=
 =?us-ascii?Q?HnOtWQfRgVGZblCOhIPQzx8qQv31eUybRMu80ZPSLL81S0bGk23uIt9H4M4u?=
 =?us-ascii?Q?8AQbrV7NRWtT/8OwW+XSReby92KOOIMrKNTWFtjuj/54jSUUNMMjLq6GTRiQ?=
 =?us-ascii?Q?Jl+At/9/FDHXikfScFaSlrteeIbcVY1yMvRJ5eq3hijjnjKOkHn+7acWL0Mh?=
 =?us-ascii?Q?AmzUmEaQP4OIs+jk7cKUaMdAcG7dP5kHLV9czXibl/hRBAM4fD4B4X7V/+br?=
 =?us-ascii?Q?804BSQDa1pHR141zA6x8xZvFqD2tX3CsO11xcOPt0EdcZg4JCwf9qKRSjDQK?=
 =?us-ascii?Q?llz5uAlAbN0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EqB15RR2JsQnimPA3HD64pUUkPfOx0bhrw53StaixjRjgyjD80jBvPJL/Wc9?=
 =?us-ascii?Q?ygNJYqIRHI4ogoPGvoKJUGDCo4MFTaFeNG07H0TxFjvm79fTzRS7V2QsXRrz?=
 =?us-ascii?Q?owvpUZLJxf6XtSATxnji7cOw69l/3VNYkw8NzkFeRkbrPcfNx14tmi3yUFmZ?=
 =?us-ascii?Q?4Ftka+Cc+Kw+GXc7RK0yoogTVTvXuB5GIukBENRXLJfCLj2L3B1sk3Fymxwz?=
 =?us-ascii?Q?vP153fRA6IFnU84YmyQyh0I5mgUkgqZmAQoZGp4v0MQ2dUcrYjoPi4GkDtMB?=
 =?us-ascii?Q?ItGnJ6Ky4jT/jk+xyQK9v/nCzk4gqe9LVUXbAfuq7QUmSuIkMoNjtsagbxcC?=
 =?us-ascii?Q?XBCiPA9gnHYe/MArvZ7vOSW6CoxFJZ3aLvCVSnetk2v4GMteuFvOg8wF892t?=
 =?us-ascii?Q?Xf1ePA4/LXrtAbf/JZh9VA4/GR8a+vj7RvHxmmENNWdZCBJjPZCbWAf190pf?=
 =?us-ascii?Q?ps1nydYRd3th6hVTiciSYBa/iYH34PPFtITuWipPQdaMDaVwpBvPMjCOf2EX?=
 =?us-ascii?Q?hk0jghZMowcVlXWEBn9Kr5r6+EbBHNIxw7owhEhCW8Kl726kgRRHUKJZlNp+?=
 =?us-ascii?Q?pbzFXDBrokfyjraBoZUarfDMk91bHGLkvUo9/hE9eg29fUTeV6u8nb11ofUb?=
 =?us-ascii?Q?Ney4gxxuf5ACe+IY9y1jkLZosdPDTmEQGT8LZu6Jx9u2u/8AyeFkhX4zxODx?=
 =?us-ascii?Q?3+6eBbFL4qEC08ecKNDOjD4MdiZed1vaWjDSKWzBfmuj2NLVRSMYsJN+bI5G?=
 =?us-ascii?Q?oFBoZ+ZCXHeIuc+MkcyB6Lp5QzJ8QDV98SZEMrk48hgex6yG5qGRiQNhNe3M?=
 =?us-ascii?Q?kzKUHkxWljQ8phy78DhuLaCGxtbhHTN2swV/7kHUFutwt1+WfQWjkTxeDsZv?=
 =?us-ascii?Q?LZfpPNu8KLg3oPLxZVRR6khNAEO0TJGwEkA6hoVjQtMLEa20HpuTWFirZ862?=
 =?us-ascii?Q?RiKyOFopp2MXWZdqhL5EqnHx2R8x+aCeTkLuuR30pptUNbZMPWa14pKmpaed?=
 =?us-ascii?Q?gMLXK+v/5Gk6nqLeNK1h09a4EwtT5bAosJ1htrCvyvmJK7P4W+JJWmz8as63?=
 =?us-ascii?Q?40nz+VzmuXMwtQcjeTxtGBtOy9A38lffw3fpFPziVqBi7vq2RIL1t3gsN6wy?=
 =?us-ascii?Q?yH06oPiC0qswm42xKSf7U9D0ZHVLNhq1tP23BfzU2D/8XhLDJuD1/wwJH2en?=
 =?us-ascii?Q?7ztm7nZayOOX6bWiKKHhka1rsvGINnAWEIPiFYIsHgx9NU/wufFHpJxzAJIX?=
 =?us-ascii?Q?vouElRR6E4o/bR9S5bRWA+fBAfy3n+di6K5G8ZlFOiwzGSMPl/i4rRRjHD1H?=
 =?us-ascii?Q?kbwjvxXpdfDiDErRjMkuRLA8aNjOwPKvk4J/7aeNp+6Ft2lFFa0DQcG6PNcj?=
 =?us-ascii?Q?I1QBoA8cSbQFL58tY3jVeZfCnfhejx2Bw/U8mg2KEU2qh/gfE7+LzQHRCxm8?=
 =?us-ascii?Q?ZZGBzr8xi8GyvwLqBNpzfIkXMYs+gAb6oeEYyWC+8RctqJ8JljDp1MBj4UiZ?=
 =?us-ascii?Q?7NKeX9GiXzcaVYP7dBJBFbtlDBq/q3vRJuoDBqArSH15cQA7tUwU7QAan3Vy?=
 =?us-ascii?Q?PQGVskLN75tXAWDyg9FgZfsen16ClzTap0ONiSb1IzO5JEDaCu7YO2c/6v6z?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6qx7DfLyXao6Ecu+SV5LnJqX9VEilPsZYCcBdT9M4uoewxbHoFlc22JOzjw/SNzeLs4+hsUiNWgDrhvviWb5gEMg9IuMIDu6X19W8hVb2XTegaqrMqSce6m50nCSk7aSsY3pkChx7oibfmwGuE/xETrYKK/hjaOPlKpumLF75k91Rbz7E6WF05nDX39Obo8Xl9YSpo0cMaA5ARuGa7gQpsontPC/UXLtEEjJ2uqWAiHKyvq/LIr+pXqY3bM3FKt8/bu0rKDELpFTDYJfYXGo5k9TuiPPxMaRVNrnwju5SJiewLGIH+FfqTiphybbAXUgAZR0U7HxsdH3ppjaHfsZg6BiVwkLhOzvRmbCvnsYC43xzM/Z/RtdTnEfkpX5MbEeBFnArH93i3wwMMyVfdDIUmbbNSfu7rKDVqu0+XdolXyB4TfBzCMJYVBuKodppdD1EQQylk6Lhe8Ml6EFac4mvR4PzoO9IJMCakakzXUBupMs66yh4wMEGZrm12MAFN5vl7njKWsLNlzUeanyjQwHFIRIydB0eND23eq5SOzzra5s5b0Zu9xObFZDyD+Na1m/omHtpdJ4YmED2/AQpUesFBXB9mPPmwNWZQ0xyLMKYf0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bfb25c-9009-4913-812f-08ddbf4d1276
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:50.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrsmqZ3NabttyDoA1TtuYTqsirsRsIQLBjZI3GR35zHjmAQe34BJBzEXYTOAGTQ+n9iPmTg8DaRsMCNR3St8ZDPAzwAJaRDW7hPP+3l+ymg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Proofpoint-GUID: maD1mH4cHMZIDiLmFvp5e5cC040xnS3g
X-Proofpoint-ORIG-GUID: maD1mH4cHMZIDiLmFvp5e5cC040xnS3g
X-Authority-Analysis: v=2.4 cv=Av3u3P9P c=1 sm=1 tr=0 ts=686f1089 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=3VxSRnZmKhVynjaijvUA:9 cc=ntf awl=host:12057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfX/IEIhL71hlTQ VCXawX5KG1FAe4E8kTtavIvn8J6I05UsQT0sRh6oezttChgZQW1wV+BSWneoYCFkZQGxATmU6Ca IHuHcAZwhjEUXEtdM3XLgEwGK95gCCY47ZjzWSCE8HGVnjfWc/xxI3YuiOTieZWD3LzlOayhD/9
 XCHuUWt2ySpg9orrP8zt2BaTlU5DII/dc7wgqGlXQOlxOxqceOGXIRfXlaa63X8UzguQ9cwEdsZ zrJkt0BpX0snVjc9hEM1IotUZu1hv93TWTSWh/XdE8su0ltDVa3SypVxmAS6ZVXgnT1WYm83JJt n2KLvW9rz5dGYOvXeYKlPL05qHwAQ6Tu7dfdFWnJaIK/X1I2tinU/Hxiq/llgoJ/B2T3joJ5zra
 0QoZHtx+gwHOB7q8xxjTcI7BNgWOfxeVviI7cQ59BkTBbPYFVSPcc11u8J4KiVQJfZLWZKFm

clear_page_rep() and clear_page_erms() are wrappers around "REP; STOS"
variations. Inlining gets rid of an unnecessary CALL/RET (which isn't
free when using RETHUNK speculative execution mitigations.)
Fixup and rename clear_page_orig() to adapt to the changed calling
convention.

And, add a comment from Dave Hansen detailing various clearing mechanisms
used in clear_page().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page_32.h |  6 +++++
 arch/x86/include/asm/page_64.h | 42 ++++++++++++++++++++++++++--------
 arch/x86/lib/clear_page_64.S   | 39 +++++++------------------------
 3 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index 0c623706cb7e..a8ff43bb9652 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -17,6 +17,12 @@ extern unsigned long __phys_addr(unsigned long);
 
 #include <linux/string.h>
 
+/*
+ * clear_page() - clear kernel page.
+ * @page: address of kernel page
+ *
+ * Does absolutely no exception handling.
+ */
 static inline void clear_page(void *page)
 {
 	memset(page, 0, PAGE_SIZE);
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 015d23f3e01f..28b9adbc5f00 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -40,23 +40,45 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 
 #define __phys_reloc_hide(x)	(x)
 
-void clear_page_orig(void *page);
-void clear_page_rep(void *page);
-void clear_page_erms(void *page);
+void memzero_page_aligned_unrolled(void *addr, u64 len);
 
+/*
+ * clear_page() - clear kernel page.
+ * @page: address of kernel page
+ *
+ * Switch between three implementations of page clearing based on CPU
+ * capabilities:
+ *
+ *  - memzero_page_aligned_unrolled(): the oldest, slowest and universally
+ *    supported method. Zeroes via 8-byte MOV instructions unrolled 8x
+ *    to write a 64-byte cacheline in each loop iteration..
+ *
+ *  - "rep stosq": really old CPUs had crummy REP implementations.
+ *    Vendor CPU setup code sets 'REP_GOOD' on CPUs where REP can be
+ *    trusted. The instruction writes 8-byte per REP iteration but
+ *    CPUs can internally batch these together and do larger writes.
+ *
+ *  - "rep stosb": CPUs that enumerate 'ERMS' have an improved STOS
+ *    implementation that is less picky about alignment and where
+ *    STOSB (1-byte at a time) is actually faster than STOSQ (8-bytes
+ *    at a time.)
+ *
+ * Does absolutely no exception handling.
+ */
 static inline void clear_page(void *page)
 {
+	u64 len = PAGE_SIZE;
 	/*
 	 * Clean up KMSAN metadata for the page being cleared. The assembly call
 	 * below clobbers @page, so we perform unpoisoning before it.
 	 */
-	kmsan_unpoison_memory(page, PAGE_SIZE);
-	alternative_call_2(clear_page_orig,
-			   clear_page_rep, X86_FEATURE_REP_GOOD,
-			   clear_page_erms, X86_FEATURE_ERMS,
-			   "=D" (page),
-			   "D" (page),
-			   "cc", "memory", "rax", "rcx");
+	kmsan_unpoison_memory(page, len);
+	asm volatile(ALTERNATIVE_2("call memzero_page_aligned_unrolled",
+				   "shrq $3, %%rcx; rep stosq", X86_FEATURE_REP_GOOD,
+				   "rep stosb", X86_FEATURE_ERMS)
+			: "+c" (len), "+D" (page), ASM_CALL_CONSTRAINT
+			: "a" (0)
+			: "cc", "memory");
 }
 
 void copy_page(void *to, void *from);
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index a508e4a8c66a..27debe0c018c 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -6,30 +6,15 @@
 #include <asm/asm.h>
 
 /*
- * Most CPUs support enhanced REP MOVSB/STOSB instructions. It is
- * recommended to use this when possible and we do use them by default.
- * If enhanced REP MOVSB/STOSB is not available, try to use fast string.
- * Otherwise, use original.
+ * Zero page aligned region.
+ * %rdi	- dest
+ * %rcx	- length
  */
-
-/*
- * Zero a page.
- * %rdi	- page
- */
-SYM_TYPED_FUNC_START(clear_page_rep)
-	movl $4096/8,%ecx
-	xorl %eax,%eax
-	rep stosq
-	RET
-SYM_FUNC_END(clear_page_rep)
-EXPORT_SYMBOL_GPL(clear_page_rep)
-
-SYM_TYPED_FUNC_START(clear_page_orig)
-	xorl   %eax,%eax
-	movl   $4096/64,%ecx
+SYM_TYPED_FUNC_START(memzero_page_aligned_unrolled)
+	shrq   $6, %rcx
 	.p2align 4
 .Lloop:
-	decl	%ecx
+	decq	%rcx
 #define PUT(x) movq %rax,x*8(%rdi)
 	movq %rax,(%rdi)
 	PUT(1)
@@ -43,16 +28,8 @@ SYM_TYPED_FUNC_START(clear_page_orig)
 	jnz	.Lloop
 	nop
 	RET
-SYM_FUNC_END(clear_page_orig)
-EXPORT_SYMBOL_GPL(clear_page_orig)
-
-SYM_TYPED_FUNC_START(clear_page_erms)
-	movl $4096,%ecx
-	xorl %eax,%eax
-	rep stosb
-	RET
-SYM_FUNC_END(clear_page_erms)
-EXPORT_SYMBOL_GPL(clear_page_erms)
+SYM_FUNC_END(memzero_page_aligned_unrolled)
+EXPORT_SYMBOL_GPL(memzero_page_aligned_unrolled)
 
 /*
  * Default clear user-space.
-- 
2.43.5


