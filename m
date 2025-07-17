Return-Path: <linux-kernel+bounces-735589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E6B0914F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FDC1652BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BBC2F85FE;
	Thu, 17 Jul 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TllVd4Gd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K/WyAGUT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC92F7CEC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768419; cv=fail; b=EsFNu9CX82GPB1iL7OPnmcJgnSmuXDME8HfcZk1n6cj0o1ZpmfiSi53puRHYd55bU5xj9X3LqpcIV1zwbU6uRfSEuZLBQXnpcB1fznNI6aHyk09MLR5quEv1F2twjKiJ9LgK/pqKPXyiNvEVCEykIDXojgy2FJTpTil8Nls90/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768419; c=relaxed/simple;
	bh=qFa29DcQNz4Qd/zB50aBow9rcl7lmtgMKGmwAkwPpnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R3YPV4oRus4OLo+vPpXs/59FK9dlRU7RprJweMl/JNujm5ypEf9JuKQxIdlJy3peDQdWLBJAKFOaGJDcDxaLJZEWnH4+CfXZGdW4aiSnr/Raoy58raMtgCNCz3/r2HcpHnmZ0TT6DK9s/U9vEdQBlgymLytNWfoKoKmnRLpbaZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TllVd4Gd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K/WyAGUT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HG3xAE025064;
	Thu, 17 Jul 2025 16:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=55EUiuswSNnsPKy778
	BXdWEOcOHG3EYuSWEb9CveUKA=; b=TllVd4GdT7HrvWWkU6PgI/E3Bnro9af8mO
	Tj8EVxBzbLNJflSz5h38+5dVs0V5x7GYxFzbzi2bp5peUMmonH9NDXisL9zZiJP5
	VoxVNbYEzDHoV1kpStT3SkWux1OlHoOk8NQduOghIM1bgzoLWsmmMUqNxU4xMDWr
	cS9KSPddEYXcmLvW5Oqq4W0b4Q/gs29k3Gv6uaBlrFmkicdzyWFrQcIiQDFCiOgK
	QKpQ5AXJTsqQxxdpX2pp2R8b+QwxsRGba2NOdMTwtDls8x0XDXBbLF9WmpSvSoi2
	LEh90oCYW399HQ8LUBOip/h0EeWQQZNTRZUfL5P5a5xJlSdailww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g3hev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:06:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFAe6G013753;
	Thu, 17 Jul 2025 16:06:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cekx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpEc9EjxNAMExkACvaBVCVkBCp2CmdfHtnIr1dyCx/EAYjRAV/yWwrXdEp/I22zXWNLBR4BgvBIrfldyie+PJsECh+KEewzKBNMHfdb5mWLECH19QjkVtqf7kfHL44sn1jMnsC/oW/+rQv6j3f+IK9kRBOzUsAcSzAb+V50YyGhIwemViWZs2iz3C5WaEE3Eh6/k8cbidPnB4hVByBy/yB1g4LYSLqrX0HXBNa53OovOWlNiZd8Im1p+glsSFrIW2M6xUqgkuK3LVg3sARC+8EVGK35d26VhVx+rMavBVN+9dWhZICIqOGQkZc7Qg0HTZfIpFT4YaXhmr9d+UfqcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55EUiuswSNnsPKy778BXdWEOcOHG3EYuSWEb9CveUKA=;
 b=KdxQp4C4tuMvvzg08PwlKzn3WcTzZ8aKapXhuYZtGN1+Cftp9upk+PtIKix1zB9JJyRR9tNzumlUBiLqj8PGB3uSxSm8xvkRzjoCDCR9NRhwIsBTTAL29oeIIESV0W9OZxP6Jy2y6qFJwOjN3Oa8U1NetkblLKwe0dKewwKlxym0ew2mvpcLnCQkNsFK9IeVkJgOLnk4uMIuiOqs4+/oc97vc8b5EyzsQbh/OssPTpaeaiA11DdaPXh3ktOSDo+ncmboxYYBiOQ01vsdtVGENpUTm9/ynhjVR6hBHPafrIjPQSW4PPCVxM4nt5ZPn3JOjkgqomF1em1EBN7YKYYyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55EUiuswSNnsPKy778BXdWEOcOHG3EYuSWEb9CveUKA=;
 b=K/WyAGUTzq6ZJCZRrz8WWBqAZ6xL+vO0hTYX4lipPZ3OnwiygT8qanGR/67z2CEw1oB8V0x2vXUdT3XGggtYaV1sjbVqRLxNIYV/wT3/ZI9f4xcKe+lX4svM33oL4KxiThvGbljrgpaQQA5s1mlcMNmhcws13aXbwGykwBDkY4Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4159.namprd10.prod.outlook.com (2603:10b6:208:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 16:06:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:06:36 +0000
Date: Thu, 17 Jul 2025 17:06:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hdanton@sina.com, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot
 (2)
Message-ID: <4c29e030-4ba8-48e3-96bb-015d43768db0@lucifer.local>
References: <20250717014623.2253-1-hdanton@sina.com>
 <68787417.a70a0220.693ce.0037.GAE@google.com>
 <8a2f1892-3184-4aaf-91ea-522e9ba2391b@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a2f1892-3184-4aaf-91ea-522e9ba2391b@lucifer.local>
X-ClientProxiedBy: LO4P123CA0212.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: d38affec-1721-4a0e-e994-08ddc54be828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5K0ViI+T8qm1jTdZv1W7okZ2D2fUqteZggRGDWlRZ3XkPgUl+iLSxQ6qMXS4?=
 =?us-ascii?Q?h60XLaztC+q8Y7Y/Cs/Ee495rB1kUJZJhCJyguxszY/RcRAD3yKguNxxxcqc?=
 =?us-ascii?Q?X9lmFvDil1YS8MU1aIQ8Dm3YhGpijltXMMEFTNZOndarIihd0ttdQipisph8?=
 =?us-ascii?Q?VCtu+pGC4i4tzYih26mVPFT3z2c8OGGpoQ+T2YuKRYVjvvSQqwD3RiGFFu9a?=
 =?us-ascii?Q?ovzLpC9OvMdYtydi+QCgr7ksnFeS09Am8WPNPxhUqsvGll9Wd1MRpGdTK6PN?=
 =?us-ascii?Q?MMj4LPG2JmkUwgKSXTpzP40ZQcD4R//lb/tsmXH1bpPChzfW2/cNMMnG3AgV?=
 =?us-ascii?Q?V3pdiHjUsGYQPfvtjwT0FQcEMmfVRK8vlqZQSt729tdzHUeq2a9jmLI52M4+?=
 =?us-ascii?Q?20l16329YgJ8z+IBC3Zjdu43nzSIvy+gp+bCpFYDWAlXBe1KskCDURi7zdgF?=
 =?us-ascii?Q?IHsYykvpKCVSjHi+xER8Ij9dlfo3DbMrikWzogZV7GpSmXfPflnjay6li9ZT?=
 =?us-ascii?Q?JAkJ/OhPDI3yaVVuXSpl4mxRG8Lrl3po8rT+Fq3GaeDs73td23NaqSZRgC3+?=
 =?us-ascii?Q?ptvAifltSVAwafMSgNBzc7enycPPsNwaHo1YdVjuM2rEQh/TQh3+Jok2pWtS?=
 =?us-ascii?Q?25kehdWXT/oXgRLS58WkNQDSIASjRcPpzH7hLi3fmN6aKR/GAiER0BuBQlN7?=
 =?us-ascii?Q?Qk6bAIQ1HWwogPyFKL1uyfcGm/3Pc5cvo0m11p48GprZEwuet2mI/B0+DjNa?=
 =?us-ascii?Q?+RAF/gjev+mPfAC05QWuvC+J1ViynS7mtk8GXWOpGcSt5ILzmrkfX2EHO14a?=
 =?us-ascii?Q?8EaOHb1aDmsQQdDwsBwMowKkmX6KCy3+52eQh0h2W3dH0GBbVc8+IfPyZya1?=
 =?us-ascii?Q?D+d3kn72JFV9vHus+TtbfnmyEl7WRJg7y8ZtzU4ny+FQaL6jIojL+9p2uD0c?=
 =?us-ascii?Q?oUvCN9jizi0un+L68nTX+flrfQtDx1CVWGPuW2syJ3elYLbwoTpncnO2RXzz?=
 =?us-ascii?Q?5SfNm2CY1VIGhcy/TPw8LsL1OfUX3zYwcUOanw25M7zFXLztoSgxakx4xc5k?=
 =?us-ascii?Q?Dpa4DSgIdEbAZ+rrdPIMNmxvPIeMxrAxIFYe9w7/B+k9hLGrSSEHTTQhajX0?=
 =?us-ascii?Q?lAQ3ir/AZaKG7Mb7LWJiU8E5i5FBOaqxR4zvR+/1u+UkNPl5j2RgWiAFgi8t?=
 =?us-ascii?Q?XOBkVhoCrM0eQUd3CZXCf8TvD1QCS+PY077MGp4/ckWN24btd9JLKTempJmB?=
 =?us-ascii?Q?u/QH6TmPqIXHtXWIvdMp1GQahJwmI0li89/72HLalOvNJXZ2TPKHk83P6em8?=
 =?us-ascii?Q?kLM5srIYzQs2/m3UKh55do7QtqzxHhokrLDaFfNf69oUKx/yKgou+Vxihif6?=
 =?us-ascii?Q?QBIVncNv5FBRm+/vfkZfPDmXes+1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FRHpgrGZiFRqvVkFCgh9I2F5tV/8Wu1uESzBLRX4xyojPP3t1WTe0lgvG+3T?=
 =?us-ascii?Q?S5IMri75D10hOb6jitJXH+2gm/sXdlhc0JFxPlilMyLPqvYO0HnDIS3Byku7?=
 =?us-ascii?Q?5HKGC81fpYrIv/x7CJWpDqRV2Soxi+5TnXnuI9/s826HhxcUR4FBUw90sp7+?=
 =?us-ascii?Q?fJUs21zPLGL1WBXjIHLorRPx0Grr+3RdDfYQSJHJnG8bYOi/H3Lrbpxkb+hv?=
 =?us-ascii?Q?hO9ndDkrV0IZjkj5zNvL2tKsb3rlhLId8liq8dr/lbePlz43WKwhzAgv8ZLu?=
 =?us-ascii?Q?lEbqGibLO9kWoLvKZ+eT4eCEb3NeKthDfM/AHU6wfgP6fXYHULerjkFXJFY1?=
 =?us-ascii?Q?0g8yhCHrO5NOPNXPmbTZXQIXYZrI8SW3P/ywmV15bsseJIbLe1ZRySqQ816N?=
 =?us-ascii?Q?7QWM7SzDr63pAzhGfKYiBN2Iwju9Q4rLNgd+hZwLsXhq4NrJYnPGJ5bXyPq+?=
 =?us-ascii?Q?wNrpC3Pdv1slMaK+W8SL+JncqBVAKyRWSWZt/5WgDyqhZLWEvPZaTXr9yOmM?=
 =?us-ascii?Q?W8Osjo3rc+80K0CLa9/AknU8r67KJYja1Nvw+WYsO82wSsAM3w1c3utfVK+q?=
 =?us-ascii?Q?8pvzN4R3c35PKqSu8nuGExBLhQqDLevgM06Jip5ABBjXBJHLDhmNn8p0li8w?=
 =?us-ascii?Q?gJlAMFJZ0E8swrtQeBA9mfSm6S7x1OXAxR7ZpcSJ6b4+JNckNZJwJZYlmM1s?=
 =?us-ascii?Q?634lBvXEUs/igXSAagYg69zsFaI62yH5kZxYvQJJ5NIWQy8hNN0hTuZ/QbWR?=
 =?us-ascii?Q?dZVVi2e4QtTxwj43d+oxvQhdHtr51+UQC/WCjxBabhrAF0dcz7z6r9rvTs/3?=
 =?us-ascii?Q?yer+v3g5RjlJWe4szKryn/5dIPTI9i205Hcx5gKQiLHChfE0bd20gzfp0f34?=
 =?us-ascii?Q?UGSSf2VkR/UlNj2PGWmskgFAmwm1J6EELqphbTPDsACCbgpYgxvzxwlk1gUx?=
 =?us-ascii?Q?274HctSdu/H3xhDYnA9fy57k84b1guHw/h8bjD7YrYWW7wbwZ5Vkvz2my0yy?=
 =?us-ascii?Q?v7ooJFhBpFxIvPCOUFvevgNWuimrvELCBQ2MePqlM5nbFcbJHlaFLKGiwYF2?=
 =?us-ascii?Q?7x9/lE3HUsKBx0j+Rgl3BT4OO1HXLnFLvzS94cgXoPydk63IEMLtUcOkOIB/?=
 =?us-ascii?Q?U7ZXUZDu2DiDEHQSqMzX94zV/jDZXkb69HBCa3Fg12NerC7jKApdDMcgLtLm?=
 =?us-ascii?Q?AC8A25wn2ojfRjmL1nS2ZiDSVjuOnBbdy3e3w8l++nc7bcdiXQCEs5BLBv+n?=
 =?us-ascii?Q?H6Vvb/errWXtmQ12xbMwbESxshNZnNzOeYNEVn8sAV8ANWbDDOqXvrUihBGJ?=
 =?us-ascii?Q?8hvjYhZPnj/iK1+tYB3Qq+8pZaQ39qdKDIdd8yXmHs70qfQE7HhToiUNxmUJ?=
 =?us-ascii?Q?E+9WMqp5KH7uKAFy6TCjqAMFz6v8qifUXocHQGxDOoRtrxSdXNeLKTMZMKNj?=
 =?us-ascii?Q?u2nD+O2OqwPcyNBbmKm6xS6urYHFzzXV/ICm3a++KvsT0TDw7f8ypVvH4xhI?=
 =?us-ascii?Q?hhHVCnigsSeAjiNxqr3aP+fD2ddbnzWcdy+pPL7VxBRwkSyh1kJux1csxxWa?=
 =?us-ascii?Q?Pp3XK+dhzBzGt7Vj211b3bxsSjSynDOJJo9jPpGtgznQW3XgCnGHYseR9f1N?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dAQxpvFtjXbQJ9AbWdxX8ZTTLOkHLhQPwNGRu9RCjoVVARWpl42jS2jYGljJCDhhINznVMk/xKnEPT7IHcz6GrK8OmvHmOEEBc7ZEvOlwjYuMn5OtRg4HrHWbdVWwLUqnTqtj6MGGFXU24+Fwl8W/B1nMVBb9KI/OaH39fe+q/WRH+B+aWQ2BRK0tFG8Kjw93uF8uFhblL+ldjm178e/aQ3N4hrXSGAOQxdZ/phao3ZOLKwaxTHx7tW4+5VizDHQiwDHy7espZYUT5xyhdzTvGJRFuat5Jf4AePa5Kb1DVHMWDDH6Ck4i/y+mQe22b4W43cv5aFyu8XzPqKWz3GB9Wjq7kxIxfBgXg0Kz9NGfxJovOAyO/FnhoT3PWiYnpZnA9LRYDreZ0asjK91f/ZNigjXTFrYXB70Yh33u1Rnu9pAnYlZO+7jh3s1uY3k/34YMmIZc9Huio/Q4r6t6g0IvUpHSMf8GPZ4aTIEKwtAHzpHamDjIHsoZH72r4FgckJomytp/QzMOUr/GT4t5nzBwK3foQ1mrarTv/j827Ui5VIts9y88QPsxgTx4SF0Jra2Nq59sEt/icpd+CtOOVtkniyiRgilKeOItL2I2i5+dX8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38affec-1721-4a0e-e994-08ddc54be828
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:06:36.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hNfwqPvTyrP9sdQSRAkUTqHnQwRR5aoGcFo7Xv6wQGZ+d5bMLTBsF9bNRlxQsivI1iaEO03rvZ2G723cLuq1Lq5pXM8dBWep4GtJHqaYcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170141
X-Proofpoint-ORIG-GUID: IIM0PZFJodN9wluOxjQWYRfhK8WFskZy
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=68791f90 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=LNfbdb5tA9VE9jBE5fkA:9 a=CjuIK1q_8ugA:10 a=DcSpbTIhAlouE1Uv7lRv:22 cc=ntf awl=host:12061
X-Proofpoint-GUID: IIM0PZFJodN9wluOxjQWYRfhK8WFskZy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE0MiBTYWx0ZWRfX8+MFcoaw46UU 4uuSnqf9ZD+K4+d9EL0n95r8KxScBPSmoYrGnVwg0cOqArKWrs9LB0cJ8N7XX3nGDy67C/MNJ66 Z2jzVvXBrR+6wg+3QSlAKpoXdsIXBgI/RKdYBjC/vc9Kv/F4SnJPs/NFkpvr6L2T2NXBjzC12MY
 bPoQ2n2ygKz5DcUywj8WJlfWaotFNhhf/5/NrKoPjQLnqSzMSKL0ggoSex26eWeSWSatnaGCM85 tKHpBKphUfUHyPvM4Lxft5e/FniwNoQhf2LcgoaLumz0jC2+U2QlkbRjo8y731D70vB5SHgNA9H 0B8u8a6dx9v7s+3/3ShN7WIwjbcm0Grv06bIDeAY1lvWFXqjeWMWQQ3fKJIKHYUXmOpmDpW50OX
 0E/85nYicf8KH74cSZoy4HvR0vVJp++rMtOqU6uaFjPze0Aswl/YM6pZ2rn4AdJHaGR1OX7X

OK on second thoughts, there is one additional thing we need to do on each
loop to avoid observing the same VMA, either the prior logic of checking
directly or a vma_next().

So this may be a consequence of that.

I will respin the series to make life easier...

On Thu, Jul 17, 2025 at 05:18:17AM +0100, Lorenzo Stoakes wrote:
> This looks to be unrelated to my patch and some issue with syzbot (it's doing
> weird injection stuff).
>
> As I said, I have tested the change with reproducer locally and it fixes the
> issue, and I have been able to reliably observe that (note, without any of the
> below stuff happening).
>
> Thanks
>
> On Wed, Jul 16, 2025 at 08:55:03PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > INFO: task hung in exit_mm
> >
> > INFO: task syz.0.16:6665 blocked for more than 143 seconds.
> >       Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0
> >       Blocked by coredump.
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:syz.0.16        state:D stack:26920 pid:6665  tgid:6665  ppid:6577   task_flags:0x40044c flags:0x00004004
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5314 [inline]
> >  __schedule+0x16fd/0x4cf0 kernel/sched/core.c:6697
> >  __schedule_loop kernel/sched/core.c:6775 [inline]
> >  schedule+0x165/0x360 kernel/sched/core.c:6790
> >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6847
> >  rwsem_down_read_slowpath+0x5fd/0x8f0 kernel/locking/rwsem.c:1088
> >  __down_read_common kernel/locking/rwsem.c:1263 [inline]
> >  __down_read kernel/locking/rwsem.c:1276 [inline]
> >  down_read+0x98/0x2e0 kernel/locking/rwsem.c:1541
> >  mmap_read_lock include/linux/mmap_lock.h:423 [inline]
> >  exit_mm+0xcc/0x2c0 kernel/exit.c:557
> >  do_exit+0x648/0x2300 kernel/exit.c:947
> >  do_group_exit+0x21c/0x2d0 kernel/exit.c:1100
> >  get_signal+0x1286/0x1340 kernel/signal.c:3034
> >  arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
> >  exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
> >  exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
> >  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
> >  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
> >  do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f524bb8e963
> > RSP: 002b:00007ffc99164708 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> > RAX: fffffffffffffffc RBX: 00007f524b5ff6c0 RCX: 00007f524bb8e963
> > RDX: 0000000000000000 RSI: 0000000000021000 RDI: 0000000000000000
> > RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
> > R10: 0000000000020022 R11: 0000000000000246 R12: 00007ffc99164860
> > R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
> >  </TASK>
> > INFO: task syz.1.17:6807 blocked for more than 144 seconds.
> >       Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0
> >       Blocked by coredump.
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:syz.1.17        state:D stack:26920 pid:6807  tgid:6807  ppid:6787   task_flags:0x40044c flags:0x00004004
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5314 [inline]
> >  __schedule+0x16fd/0x4cf0 kernel/sched/core.c:6697
> >  __schedule_loop kernel/sched/core.c:6775 [inline]
> >  schedule+0x165/0x360 kernel/sched/core.c:6790
> >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6847
> >  rwsem_down_read_slowpath+0x5fd/0x8f0 kernel/locking/rwsem.c:1088
> >  __down_read_common kernel/locking/rwsem.c:1263 [inline]
> >  __down_read kernel/locking/rwsem.c:1276 [inline]
> >  down_read+0x98/0x2e0 kernel/locking/rwsem.c:1541
> >  mmap_read_lock include/linux/mmap_lock.h:423 [inline]
> >  exit_mm+0xcc/0x2c0 kernel/exit.c:557
> >  do_exit+0x648/0x2300 kernel/exit.c:947
> >  do_group_exit+0x21c/0x2d0 kernel/exit.c:1100
> >  get_signal+0x1286/0x1340 kernel/signal.c:3034
> >  arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
> >  exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
> >  exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
> >  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
> >  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
> >  do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7efc6b58e963
> > RSP: 002b:00007ffe5b639e88 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> > RAX: fffffffffffffffc RBX: 00007efc6afff6c0 RCX: 00007efc6b58e963
> > RDX: 0000000000000000 RSI: 0000000000021000 RDI: 0000000000000000
> > RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
> > R10: 0000000000020022 R11: 0000000000000246 R12: 00007ffe5b639fe0
> > R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
> >  </TASK>
> >
> > Showing all locks held in the system:
> > 1 lock held by khungtaskd/31:
> >  #0: ffffffff8e13e2e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
> >  #0: ffffffff8e13e2e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
> >  #0: ffffffff8e13e2e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
> > 3 locks held by kworker/0:3/981:
> > 3 locks held by kworker/u8:9/3028:
> >  #0: ffff8880b8739f98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:606
> >  #1: ffff8880b8724008 (per_cpu_ptr(&psi_seq, cpu)){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:937
> >  #2: ffff8880b8725918 (&base->lock){-.-.}-{2:2}, at: lock_timer_base kernel/time/timer.c:1004 [inline]
> >  #2: ffff8880b8725918 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x1ae/0xf30 kernel/time/timer.c:1085
> > 2 locks held by getty/5607:
> >  #0: ffff88814df960a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
> >  #1: ffffc9000332e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
> > 1 lock held by syz.0.16/6665:
> >  #0: ffff8880242d4260 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
> >  #0: ffff8880242d4260 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> > 1 lock held by syz.0.16/6666:
> > 1 lock held by syz.1.17/6807:
> >  #0: ffff88807b8c57e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
> >  #0: ffff88807b8c57e0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> > 1 lock held by syz.1.17/6808:
> > 1 lock held by syz.2.18/6831:
> >  #0: ffff88807e36c260 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
> >  #0: ffff88807e36c260 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> > 1 lock held by syz.2.18/6832:
> > 1 lock held by syz.3.19/6858:
> >  #0: ffff88807b8c2ce0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
> >  #0: ffff88807b8c2ce0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> > 3 locks held by syz.3.19/6859:
> > 1 lock held by syz.4.20/6888:
> >  #0: ffff88801a476d60 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
> >  #0: ffff88801a476d60 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> > 1 lock held by syz.4.20/6889:
> > 1 lock held by syz.5.21/6925:
> >  #0: ffff88801a472220 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
> >  #0: ffff88801a472220 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> > 1 lock held by syz.5.21/6926:
> > 1 lock held by syz.6.22/6955:
> >  #0: ffff88807f93b7a0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
> >  #0: ffff88807f93b7a0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> > 1 lock held by syz.6.22/6956:
> > 1 lock held by syz.7.24/6990:
> >  #0: ffff88807c9ec260 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
> >  #0: ffff88807c9ec260 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> > 1 lock held by syz.7.24/6992:
> > 2 locks held by dhcpcd/6995:
> >  #0: ffff88805e42b808 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
> >  #0: ffff88805e42b808 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
> >  #0: ffff88805e42b808 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
> >  #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:311 [inline]
> >  #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2f6/0x730 kernel/rcu/tree_exp.h:967
> > 1 lock held by dhcpcd/6996:
> >  #0: ffff88805e42ca08 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
> >  #0: ffff88805e42ca08 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
> >  #0: ffff88805e42ca08 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
> > 1 lock held by dhcpcd/6997:
> >  #0: ffff888078933208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
> >  #0: ffff888078933208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
> >  #0: ffff888078933208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
> > 2 locks held by dhcpcd/6998:
> >  #0: ffff888078930208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
> >  #0: ffff888078930208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
> >  #0: ffff888078930208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
> >  #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:343 [inline]
> >  #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x3b9/0x730 kernel/rcu/tree_exp.h:967
> >
> > =============================================
> >
> > NMI backtrace for cpu 0
> > CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0 PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >  nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
> >  nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
> >  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
> >  check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
> >  watchdog+0xfee/0x1030 kernel/hung_task.c:491
> >  kthread+0x70e/0x8a0 kernel/kthread.c:463
> >  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> > Sending NMI from CPU 0 to CPUs 1:
> > NMI backtrace for cpu 1
> > CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0 PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> > Workqueue: events_unbound nsim_dev_trap_report_work
> > RIP: 0010:__this_cpu_preempt_check+0xe/0x20 lib/smp_processor_id.c:64
> > Code: 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 fe 48 c7 c7 00 65 e3 8b <e9> bd fe ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90
> > RSP: 0018:ffffc90000a08bc8 EFLAGS: 00000002
> > RAX: 0000000000000001 RBX: ffffffff822479bd RCX: da4b2af8b834fd00
> > RDX: ffff888029254d90 RSI: ffffffff8d994444 RDI: ffffffff8be36500
> > RBP: ffffc90000a08ed0 R08: 00000000c506ef33 R09: 00000000624b5ae2
> > R10: 000000000000000e R11: ffffffff81ac3010 R12: 0000000000000000
> > R13: ffffffff81a7e844 R14: ffff88801cecda00 R15: 0000000000000286
> > FS:  0000000000000000(0000) GS:ffff888125ce2000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055a7ec2b0660 CR3: 000000005fa88000 CR4: 00000000003526f0
> > Call Trace:
> >  <IRQ>
> >  lockdep_hardirqs_off+0x74/0x110 kernel/locking/lockdep.c:4514
> >  trace_hardirqs_off+0x12/0x40 kernel/trace/trace_preemptirq.c:104
> >  kasan_quarantine_put+0x3d/0x220 mm/kasan/quarantine.c:207
> >  kasan_slab_free include/linux/kasan.h:233 [inline]
> >  slab_free_hook mm/slub.c:2417 [inline]
> >  slab_free_after_rcu_debug+0x129/0x2a0 mm/slub.c:4730
> >  rcu_do_batch kernel/rcu/tree.c:2584 [inline]
> >  rcu_core+0xca5/0x1710 kernel/rcu/tree.c:2840
> >  handle_softirqs+0x286/0x870 kernel/softirq.c:579
> >  do_softirq+0xec/0x180 kernel/softirq.c:480
> >  </IRQ>
> >  <TASK>
> >  __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
> >  spin_unlock_bh include/linux/spinlock.h:396 [inline]
> >  nsim_dev_trap_report drivers/net/netdevsim/dev.c:833 [inline]
> >  nsim_dev_trap_report_work+0x7c7/0xb80 drivers/net/netdevsim/dev.c:864
> >  process_one_work kernel/workqueue.c:3239 [inline]
> >  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3322
> >  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3403
> >  kthread+0x70e/0x8a0 kernel/kthread.c:463
> >  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >
> >
> > Tested on:
> >
> > commit:         e8352908 Add linux-next specific files for 20250716
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1523c58c580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2594af20939db736
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ebfd0e44b5c11034e1eb
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=10776382580000
> >

