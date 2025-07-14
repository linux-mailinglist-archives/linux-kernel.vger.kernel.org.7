Return-Path: <linux-kernel+bounces-730418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF171B0443B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1A31673A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F82B26057C;
	Mon, 14 Jul 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iuE3ZKGx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="plAQoPUP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143D25F78D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507215; cv=fail; b=ShDZV4M1SXOchd8KU3yeYW/gCdXmSaH9dQbvVW+Swejyot9UCWEeEDzzwkn4CCWjbomFHEj6Do/Tchx3ItCkL/xN8ptIue6vP5WvN5miaU5bazdNbu+RyLnASPaDcdf/BZrveJESyjsIkrsFlcGT0VMQDbkaNkfWlRp1HC9Et0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507215; c=relaxed/simple;
	bh=vrr3t0wRYwrsf8qmnNfyMCTOt7aqjeGifWOLUIaDiyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MULxc52VOOcxKLR25zZf5lVHLXSkWTNnOiXf3w2+i7D5dmpPtVUzURbFWfmxgoeaFmqFfzWrQDWkYnfkRFCEJfwCLLEKye2ZsBeR8L1Ev4p89kIlmRKLCY6/p0STMr7EOEjTkdE77GWFHaU8GizDKT32nq9EiCg8lce9BPtKoJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iuE3ZKGx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=plAQoPUP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z3Ru004520;
	Mon, 14 Jul 2025 15:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IexG4ef4+obo9XnsrW
	E2j434gpjsxfVVay8+4bYUvwQ=; b=iuE3ZKGxKRUUVHJHtNkQGOhfIj+QOR+WlV
	vhs/2q/IP59muTM6YX8JuvpP+jkBs3CrBMWMeljI1wwO2rVwygOs8VODDJ9Nx7tC
	MhuDkBxbpPsqOXp8vgo/cGVK4q5uweLj9KZuf7Hin1Q23asRxfjnakljwJ6NX01s
	2g7T8p6ZC2RoIxJw/B3YwTWkVV6e66cu4g9q1sHifO1y0xbv8HmFX7l3YEoS8EtJ
	MpM/v0KUVsBSnRFx59DO1GtCMtFXMAFw5IpyPevBlLpoEht3VWn8iJOd6R1YsxIg
	syR2a3GgYYKVB+ZtVnKBUBMH1/X3NNJW2VwH3qyWm+NmRnjQgLHg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7vpe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:33:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EFTOC2029743;
	Mon, 14 Jul 2025 15:33:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58durd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHGBGpUnz1GUigUzqfmWLq1zRvD5VkYZJpsPokB5dDi7V4tQg6gwzQyyxH7eO9gk9wrd1V9bGtJjIRmwb4KwjAebXs9Cj7hRxIgyZS5qj73LSvNG3kkVRfoZW7Sikupb5+iXao2085DnAgFhloEBT9oaMAiulYZS56QK4Q2iA86DEZhvJiuDS6eIn/OhSVycubTXoGRemCqbKzh1zl6/pgdVt2AwB3tgp0M+YikVXxXTr+irFRPlQqpkCXez8WGLVa6E662R0qjFHAqlac1bkOh8cK9m3SNZ1AGE+LzKdx3aCSj4GOqybL+KMesdKY7P1grIH6NPuYoy/bc91M53KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IexG4ef4+obo9XnsrWE2j434gpjsxfVVay8+4bYUvwQ=;
 b=LIqfD/5QElGu76cmjJhMgFxrB6kmDi177uBBum2FHvfTCFGkMyj+h0BCuSykHlYjF5T0kSu6QZ0dYisgici2hw9J35FOsDGvJM0pH+yPr/ZbFYlCJJH+D+lZcR3jtPsq/YGrSa+ir5aizw/Xnr5eS9SMZYJVUWJWGaEJWmmNIwcgL8m38OgzJXB/1/4BFHTN4wup7hGdyZV8HGJXK7rSD6KEguDURPFQCW0wQQgPpy/lSWx6C+yRBTXS2RdOiqjswVs4qeYetl+bquD1SEcIgkoVHLX/WiT9R8C6MY3cSIM2xydaVnYeRSzQc7tjX+hjT3kfUARfEOqwg89yK9ENFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IexG4ef4+obo9XnsrWE2j434gpjsxfVVay8+4bYUvwQ=;
 b=plAQoPUPRhmJGdvYu4sc/T5PtdLNuMPxDtt6UW1NtJXkxa2mDEI7M6GyW+QpAYLik+828DwJMzzgJRDzYCsvXxDK/ALofu3RXHqNwgS8ZpjoS0lTLPsWj8bmmN0g8SBX0mpM8OtZrK9TgxjVb1JDQtQooBm0uuwN2mglUV8XEyg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB7350.namprd10.prod.outlook.com (2603:10b6:208:40e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:33:15 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Mon, 14 Jul 2025
 15:33:15 +0000
Date: Mon, 14 Jul 2025 11:33:12 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
Message-ID: <lfv6evnii2vaaz7kbe76ir5iof4ckdlavd4bewndv7lrf2e5ac@4cr3p3fvhe5z>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e88f54-1893-4377-fe7e-08ddc2ebc039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q7NsSAcX7maiW9vy1mtLvCRHadyhp2VOWj976W/jnHAq9usWoQlT5Jw8UtKe?=
 =?us-ascii?Q?eqHSSOr8UFnHMNpVi22YOzbRvb2LCPBqjdhYYA0nqxw3BUsZel4Fkp7bH2RJ?=
 =?us-ascii?Q?UdOoeFahhp0Q1v/yeQqOfr8SzRw29mrFFHYRK41tN0lOHMZXaGgPiggcwITN?=
 =?us-ascii?Q?jFz8LYI9fSwMJ00Znr/rG4DARsiMB4MAgPqw336m03thw8HBXw0pYcKgZ9sf?=
 =?us-ascii?Q?ENhVT7SfGD9MAYV7UnmhnD0h/LYPz8G1zzW+CzZPbKimonfYWy7e72OpP2O+?=
 =?us-ascii?Q?lugnNAlqy/h52pJNx6Y1fYc/jWGJhRgJgrkqhwvrcCPb8eOvcZP2ucCF+aqj?=
 =?us-ascii?Q?1laiwjthb9cixJKqyGWntakNcVTmYp6Jo4ERLWkJQcy+rxQFt+NEzp6FAXGc?=
 =?us-ascii?Q?W97T8Pp7pHVDZY+X0H/dU+BDt5B9+34NgL9+KmnDCmka5Os1zYbAM3DQ1KlN?=
 =?us-ascii?Q?OhD/SAsQmTK39xYCI5aE1jQ9Yu5Q+/uBOkR3kC+JH5M4x5fADrjoKxC7zDbO?=
 =?us-ascii?Q?GUjIjqOBgrCiqiATTVWAzS1KRQ5eghXrL//LGstBcKWjYHkd7dpmpo/L0oGi?=
 =?us-ascii?Q?rTGUUs9QqE3qJZnmWBA2C7aMKqn3KfotPPNV35rkmNKJxOgFZsW32j1iC3Nb?=
 =?us-ascii?Q?6PTMwV1BdyoJ6K2YyZigrVulODTzluwA/Nn4tFXN1v0+ihb5vI40TjYefxd3?=
 =?us-ascii?Q?5bshdZqq3GEBQfBhkVsebe60nwOFmBqaGvBpq8q0uwo6cv78SDTBpXSLhrcb?=
 =?us-ascii?Q?OzTt85rvEfMb9soXurYHnv2NMfDRAOjV2O6k/hLRFHZYxxXNhNuMolbZQ4G7?=
 =?us-ascii?Q?ROWGMHoqJBZMxLrLRi7CK8NWeoqQ8tsS8PNFMumhB2A/B5430tibLCitMkao?=
 =?us-ascii?Q?Fbl8DSU5A3Bs3/CvToSIM+7mWUQ7nmq/5dLYzwVnJryD8yxgYJNyzuoUZUjt?=
 =?us-ascii?Q?iaq5F/XN3Up14QS7s3sVhs+KpJc9ImSB5imzrixoEXTvIc4UWdgbSsNu4hrJ?=
 =?us-ascii?Q?g3D8Mm3ed3ubSJL7ND7h06RvA1OYFZNcW9cITfr5fvzFofxLLi6ed1g3tdDf?=
 =?us-ascii?Q?expP4N2gPAeUdTBTO3Xna5v6V0Bt394iuJoB33CY4Gk7fvK6W5UhstHtOZMA?=
 =?us-ascii?Q?8daTj2+F53u4BkzQ0dyL03pmWd/Ot6EK7YE0hHaKMj0q6E4lQ0dn9MZi/jsS?=
 =?us-ascii?Q?rDWlTSz71rHVFCG0E8O1dxeIWGjHSleBisQyTTHnSlwXYxdEdLfGYz0Ys7Lh?=
 =?us-ascii?Q?ZYTnfMH03eKoek9UkFt1Qm30YURCkcHpG/nvJcyw61MekSjLC04INmSxKQvg?=
 =?us-ascii?Q?9NZ2mKNwt+B5g3i2V13hSjrlufzhV2lKqEh82Tp0vWXGQmdCDw15uOxaa4rm?=
 =?us-ascii?Q?eYZjHzmUJt/CI0sF+/vQhXwWi/+sRWyJ5cxXnTJByqt1UZioefPAxgBRGP3a?=
 =?us-ascii?Q?H7RUwXf/Aow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AfxEG7v6/Ih0rm9cO4MIQUFpu1bXALEz0stlCCWM24VvNRX0tZ5UbZvMYIZP?=
 =?us-ascii?Q?22YrYjoRjZsu5/h7M+lvHCRNLOEo8N6XAED6cKRJJhct2xRgWXLuK+j1TaNZ?=
 =?us-ascii?Q?8QAVgxdszogtpGzLi/a+Mv7gYq/rjPc15ZIPqGkc2DK57Hj+hSgFtq1NMkMg?=
 =?us-ascii?Q?PWHleXZe+PWyKcBDTTCO909CT0DtRVaoja/wNquRwTTBV83uYJ1XGPDbQAk1?=
 =?us-ascii?Q?kitifgMSpp39cPiqyg89B6TL2DG8M12NxSFZkdEKM2hZDW0NA3CBuA/Fued7?=
 =?us-ascii?Q?OTWFWaI0hybfxLEw6P99PbdrWlvrYGRVb8H+UX6WT39AInyg2x1wRFzKqWj1?=
 =?us-ascii?Q?pIEcdeUV8qidJPaUOFaZg2CtdLznQiEWxwg4gGk4tqKweLxJiyq2mDiPiciM?=
 =?us-ascii?Q?jIUXRfITtlrf/OIWbVDGlz0hibaSpzBfY8FVv3uiRJlwJ12VWZnBB5knx5/W?=
 =?us-ascii?Q?w04ZwGETENULSkjchofBRcUWxMBdS3Ava5F6ILwnIDFLYg7tQ2D1zhmfmn3p?=
 =?us-ascii?Q?FbpC0Ul7p7lcYHDaCfO6vDF/IfKul6rIjsjp6qdQQ9MZMOEtgcdgQ0KZj5O7?=
 =?us-ascii?Q?IGB8CudMCL+IHb3GfALgHWX7XtN5WyIkcrI+E7IVb6BMpjZQztOiACs1uhAz?=
 =?us-ascii?Q?aNZF57Vr/8m0/T+378eJ+qcQDRZf84jmC9mUEGZREj1UEhrgdXgrAFgJIwCO?=
 =?us-ascii?Q?0ZNtCGR9jf+eh6bUj+7udQbyODKMWBVWmFAqRgDP0B3TGgt+NSlpmRCMoI3v?=
 =?us-ascii?Q?wWQ7ESyed9ER+V1r8ShhULGI0mLEAz4eeaWx4U9lX4pT04honQPt17TvkDwh?=
 =?us-ascii?Q?yCgHOWjg8jJUpWydRx9XUYfeNCM5Oa9mgSzCvosdnzBRETmVlgwRSmQUbfE/?=
 =?us-ascii?Q?sikUAoew5OZoLxejXqw3h+8RxNp2sZQrtxU1W7dPQvFFq827tbApfyb9M3QQ?=
 =?us-ascii?Q?Yzg9f8kSW1716lMEPMe/fhgIa1yNVd27pudzuWf3ZpLJ2oSGUxMP3W8OtYbs?=
 =?us-ascii?Q?6wzYEMRIQbUvr3nNN1OKCRxCc4QdIkCazWktKIIIR3pAqetk+TENQN5zlN80?=
 =?us-ascii?Q?eibknEoMRD+B8vY18mPwHjsFzDtYeKehnZx58S2tkuokjhjBKB2RSHnvNAJB?=
 =?us-ascii?Q?HzckhBa165df4HHLRKRF1V2bLkIsoU9wnX/SvRhBc4RM6phUPCgVFJrmmfOZ?=
 =?us-ascii?Q?8fJUu33Z57fL743KLp1l270DflknKq9S9F9fjeNoSu4xx2uod6+c8OdmpeTW?=
 =?us-ascii?Q?PpNtzD26DtS4EUqOMAuAGdFPwR5giYou/rwM82nAJIc6JDgXZZV+n+lIfRUT?=
 =?us-ascii?Q?sVqj4JvCxTne+Ny5CPAUt+QOLnYFdrNACHFOly9XfPWUjGDv+lFmRbZk31pe?=
 =?us-ascii?Q?sqt7ZFGbeCGlxzNAAqW55X13i+rqmDF43Ktq/o+cdBWhI2jrPYMfAEe5WhRX?=
 =?us-ascii?Q?ZrCIu5rXX95ApU8xAIwia7qgggphlo3LaweEi/eAV52O7Dopc+yqwewMRO4h?=
 =?us-ascii?Q?LPldwMoEImDFvpDaRW+lrH/udMI/iU/LW/u6ue8Un6QovthRyZZxJ+u8KeQ2?=
 =?us-ascii?Q?TLOncZ0Cp03iyZfV7HrwuR3maGhhXBPo8ZbpfZwXfNjIIOVlAZxli5/aIiWf?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M7kmz3bX4reEBCNPfFHX1+C0LJthwnwxBAV0wHE8uN8gd+4+k88LMgyx21jTfhO0k58h8FHiEUE/CEkgrBpWj8oMTfxbBDLD+MR4kbBFn3DbGzt8lwc9hrFWFu1CDitUYfkkQlkdvE0GIWspze4kdLImAU5BjrGsDU55XWlAqnZ7S7WvPXkpsRpekPxn/n97mkBfOVVx92Tp887RyZQN3x/P1xde3dimHE04RCUBOI/pfgO1dhmnhprpvz7LiX+rkRuM77YKG7qjBUVINM+F9a5g1pcPcyj0WY2l9laVdMDZ+0Nih6l0CBbdaa2mWkFGZnTLv/iTrb950k5jJ5jZURE7BhLuwCH+FQedfjeQb0Yz1eqKOxYNA4YDqNaN6IB7lVBlm48aAP01RNE5gV3mVq7kJ5u50jdnj5BZ0uebmbEjY3XQPz/Yho7ILLF1Dx1BgNmyEWPXYuPsaT27Xg3NGf4DQjhb7VKqO9EKPYzG5xkeVJk7fRWKpe3O+iAuEib5Q3vMfwkIXPBydTJvTYYN9qeRoDlkkfaUvX/7n1X7+X1jr1cpMXRTaVIC/LYeRsDqAf273tbBe5cYHwzzO5xJRbYANHqo9FbHdTIAtHzDaB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e88f54-1893-4377-fe7e-08ddc2ebc039
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:33:15.5992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wa2KTND7cyIB7g46Y2yGEQx89xr5GF1e0+UaSnUf4ucqKnRMmFVGLjh/7DB8DW43oTmNzpHBVrkmzZAlotyH2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140092
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68752341 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=zRSKGZRoFNQuBlcPHh0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: uI6T_DORGVf4Mjcub8QSExFOlQvMbCOz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX7/b307g8MWqw Ivs8VEdGf+5UTW9LeCm8kHFuHsqjLcXAuWgO1uF7Q04bpqJ7XvC/9fJhGc3siwoJAOUco9D4HyK vlVprISj/uTnkdmEgBDyjDQu6QvCfnYpIgwnizRQV/JpiRIcO/HbJ8/xk7fBXqSmTgrIG1aT+5i
 YO6woiAahzs0MJLl74Kn3JYeoW/0K3R3XzrU5IwDMItsqhDNLPhxXFKvsccAZ0lLNbN3MK4vrtC MkWYUHOHYQdfbNIXCLqr04NFyibMjkbPmKFOR3C9PTqwXoJ9udfFjLmoHgai2FAyQaryIqg+8Gw N7AeTcmzO7aRLSLKWtKIjFsniJ0g7m4IRTpqfn0UYPKfaE/TJkCPtIEXQ17CtXxaYJ7Tf6ISAet
 NZQt8WUms2K6eutgpCWUplqDU7BxMaMFgW7Bmkwdq0Rs+VPP3tK6eV7y7Og4s/C/6gbas6gV
X-Proofpoint-GUID: uI6T_DORGVf4Mjcub8QSExFOlQvMbCOz

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250714 09:08]:
> The madvise() logic is inexplicably performed in mm/mseal.c - this ought to
> be located in mm/madvise.c.
> 
> Additionally can_modify_vma_madv() is inconsistently named and, in
> combination with is_ro_anon(), is very confusing logic.
> 
> Put a static function in mm/madvise.c instead - can_madvise_modify() - that
> spells out exactly what's happening. Also explicitly check for an anon VMA.
> 
> Additionally add commentary to explain what's going on.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/madvise.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  mm/mseal.c   | 49 -----------------------------------------
>  mm/vma.h     |  7 ------
>  3 files changed, 61 insertions(+), 57 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 9de9b7c797c6..75757ba418a8 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -19,6 +19,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/mm.h>
>  #include <linux/mm_inline.h>
> +#include <linux/mmu_context.h>
>  #include <linux/string.h>
>  #include <linux/uio.h>
>  #include <linux/ksm.h>
> @@ -1256,6 +1257,65 @@ static long madvise_guard_remove(struct madvise_behavior *madv_behavior)
>  			       &guard_remove_walk_ops, NULL);
>  }
> 
> +#ifdef CONFIG_64BIT
> +/* Does the madvise operation result in discarding of mapped data? */
> +static bool is_discard(int behavior)
> +{
> +	switch (behavior) {
> +	case MADV_FREE:
> +	case MADV_DONTNEED:
> +	case MADV_DONTNEED_LOCKED:
> +	case MADV_REMOVE:
> +	case MADV_DONTFORK:
> +	case MADV_WIPEONFORK:
> +	case MADV_GUARD_INSTALL:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * We are restricted from madvise()'ing mseal()'d VMAs only in very particular
> + * circumstances - discarding of data from read-only anonymous SEALED mappings.
> + *
> + * This is because users cannot trivally discard data from these VMAs, and may
> + * only do so via an appropriate madvise() call.
> + */
> +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> +{
> +	struct vm_area_struct *vma = madv_behavior->vma;
> +
> +	/* If the operation won't discard, we're good. */
> +	if (!is_discard(madv_behavior->behavior))
> +		return true;
> +
> +	/* If the VMA isn't sealed we're also good. */
> +	if (can_modify_vma(vma))
> +		return true;
> +
> +	/* File-backed mappings don't lose data on discard. */
> +	if (!vma_is_anonymous(vma))
> +		return true;
> +
> +	/*
> +	 * If the VMA is writable and the architecture permits write access,
> +	 * then discarding is fine.
> +	 */
> +	if ((vma->vm_flags & VM_WRITE) &&
> +	    arch_vma_access_permitted(vma, /* write= */ true,
> +			/* execute= */ false, /* foreign= */ false))
> +		return true;
> +
> +	return false;
> +}
> +#else
> +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> +{
> +	return true;
> +}
> +#endif
> +
>  /*
>   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
>   * will handle splitting a vm area into separate areas, each area with its own
> @@ -1269,7 +1329,7 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
>  	struct madvise_behavior_range *range = &madv_behavior->range;
>  	int error;
> 
> -	if (unlikely(!can_modify_vma_madv(madv_behavior->vma, behavior)))
> +	if (unlikely(!can_madvise_modify(madv_behavior)))
>  		return -EPERM;
> 
>  	switch (behavior) {
> diff --git a/mm/mseal.c b/mm/mseal.c
> index c27197ac04e8..1308e88ab184 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -11,7 +11,6 @@
>  #include <linux/mman.h>
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
> -#include <linux/mmu_context.h>
>  #include <linux/syscalls.h>
>  #include <linux/sched.h>
>  #include "internal.h"
> @@ -21,54 +20,6 @@ static inline void set_vma_sealed(struct vm_area_struct *vma)
>  	vm_flags_set(vma, VM_SEALED);
>  }
> 
> -static bool is_madv_discard(int behavior)
> -{
> -	switch (behavior) {
> -	case MADV_FREE:
> -	case MADV_DONTNEED:
> -	case MADV_DONTNEED_LOCKED:
> -	case MADV_REMOVE:
> -	case MADV_DONTFORK:
> -	case MADV_WIPEONFORK:
> -	case MADV_GUARD_INSTALL:
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -static bool is_ro_anon(struct vm_area_struct *vma)
> -{
> -	/* check anonymous mapping. */
> -	if (vma->vm_file || vma->vm_flags & VM_SHARED)
> -		return false;
> -
> -	/*
> -	 * check for non-writable:
> -	 * PROT=RO or PKRU is not writeable.
> -	 */
> -	if (!(vma->vm_flags & VM_WRITE) ||
> -		!arch_vma_access_permitted(vma, true, false, false))
> -		return true;
> -
> -	return false;
> -}
> -
> -/*
> - * Check if a vma is allowed to be modified by madvise.
> - */
> -bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
> -{
> -	if (!is_madv_discard(behavior))
> -		return true;
> -
> -	if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
> -		return false;
> -
> -	/* Allow by default. */
> -	return true;
> -}
> -
>  static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		struct vm_area_struct **prev, unsigned long start,
>  		unsigned long end, vm_flags_t newflags)
> diff --git a/mm/vma.h b/mm/vma.h
> index cf6e3a6371b6..6515045ba342 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -578,8 +578,6 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
>  	return true;
>  }
> 
> -bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
> -
>  #else
> 
>  static inline bool can_modify_vma(struct vm_area_struct *vma)
> @@ -587,11 +585,6 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
>  	return true;
>  }
> 
> -static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
> -{
> -	return true;
> -}
> -
>  #endif
> 
>  #if defined(CONFIG_STACK_GROWSUP)
> --
> 2.50.1

