Return-Path: <linux-kernel+bounces-825028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F70B8ABF7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015103AED0D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B076271464;
	Fri, 19 Sep 2025 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GOEIRsHC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W2D9iBWP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046A22F74F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302577; cv=fail; b=fSXLbPkvOZx6KsqltBqkl7vslSJKlrgto+cBOv903p2xUCnParzKzU2IQyphFaPBov2J17p+NeVeWzIAdIwBYbF83gM15N9+sVHF3ZEB6iTqiyNoIX/M0059ZnXVeJR6pG4v7/E89FAEWQvm4q9vbBimwL9GKuG1maS95E8yYfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302577; c=relaxed/simple;
	bh=o2n09AluAc81S5Sku4yadsbGzRDgjar6+a+lQblj32c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dzmfyo3jJ2xASRxJU1/ZJKBUYDegMZttD7aKgtK0kp3D1tXExYfpTUa1q4//sOdy4iZGIcsQ1z0h5zdOM1vT/q/ArkEIEv+mvMcF5QKGtzRUEm6e9W3Y7d7rydWYjiB5BsaqBykYwfxGyFIMlcBCRAE748BAl50LTVRUgf1efgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GOEIRsHC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W2D9iBWP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtoqg003362;
	Fri, 19 Sep 2025 17:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BfviX+4RS8TDVW+6NX
	NaS8Uc1Q1jwt8Xn5aavDAarJ4=; b=GOEIRsHCrYdTTED6ByiigachmEQt7Yj9hf
	Sbp70Ny0LtVeejYLbFctW3PxuDgahlM1zyCUtaf7lk2Rb3uAwdwcSLGhDleKs0n1
	jwz+dcFMU/mLc21kjqdWt8DWcQrAWu/lqJrZC+y9e+jMJpEAkUdUNbDEodM3CWKv
	sBEmGeuFwV05PtaiHltetrmd3lPOymmOJ50U7g0OLA/NrrqhoKrnevaUz6vhqsiw
	4l/o+JMNSzVm1kbc76qSLVSSqWFxTvWn4lUia+V7RjMDfOilE9SvEToNVtnmdtx1
	ERBTw/Pup5TytvSl3nQaBlGt8Z1FIeHHfBHLqE27kK67hKL8ooNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8nut8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:22:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JH7JNd033700;
	Fri, 19 Sep 2025 17:22:17 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2gpber-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdLojEvzbxbYsksujfdS3xncJWoUvjBcs5GJFzb7bAqA8kCS1pbWfZlHVlx4WdHOjQDi2VZ8IMJEu+ZjZmSvzQHRB3hiHE3CmwBFFKoB6ksbZ1proe403ZYbxjwUN4bDW70v9O8Hl3/gK5Ujzp89daBjFjbpkKSIn6ASmy3UpN2/sC+Q+r/ajDFarwKOF9G1pOFBIHQk44FlF0HKPNBsGNFMagBeMgQUKq5gt6mutVJEiDWzqArcgvjMkwMfWC7e0vEJ3YHrY7UExcFEEy2VzeT8cwdvheFd1AHSK0PQJHV5T9zSe2c4FJ3ZK47/6P1qFYNB7hYUZfWY7Z+rZSoVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfviX+4RS8TDVW+6NXNaS8Uc1Q1jwt8Xn5aavDAarJ4=;
 b=JFonWda8eoLDHkHFNnMAig5ZxeC5cTZJnEEBKjRZqAciY5fBZaNdv/WaxVBqGIjbv66qNdsnkT8ecXKk/iYgvxVg2LSY207knIElGkPzcOr+VmFXFNKgyXmGWK8K0iAofHoaA3Sl152hJRsnnZPpvAv35F73BczPSc4DEBtghCftLmYx1HguXkVSghez+57JhGWej/yqStw/PrpuDN481nZiQMMqc6ocrXZWBnxxAkWi1QRmtk1HVgtgAXwPBkL+1zezVRt9sc9Us56garlaAJHD53XTKlRVrJX1dfeFTN73AIL3reZRhSX4RzQJnU1+beB/E/+fdiwUF+250pVDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfviX+4RS8TDVW+6NXNaS8Uc1Q1jwt8Xn5aavDAarJ4=;
 b=W2D9iBWPpilsL64iKplCsA+pu1X+6i5bczNIl1z9fBvs0W5sDMuMMKrZlhjvctQHHREIp7s6OZ+NBxxY4tD6hJpGOCTHUX1DAZzkNS/ygjXB2l3dYvkWCyBS8hpN/Gdi23ce6pqMrhZ17F/vBRo6//6lJIvJ8XnQXn1g3lLs6/A=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB7611.namprd10.prod.outlook.com (2603:10b6:610:176::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 17:22:14 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9115.022; Fri, 19 Sep 2025
 17:22:14 +0000
Date: Fri, 19 Sep 2025 13:22:01 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Nikita Kalyazin <kalyazin@amazon.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <oybstepupgh2s5lpwwk7scryem4mgk2t7wmkr5zhj7cz4da3bp@aylj2x6sgtap>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, James Houghton <jthoughton@google.com>, 
	Michal Hocko <mhocko@suse.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Ujwal Kundur <ujwal.kundur@gmail.com>
References: <CAJuCfpHN6vpDx+UNPEzJgZ_qD9USTJZ_+yZzQg2BpF_aRpufYw@mail.gmail.com>
 <982f4f94-f0bf-45dd-9003-081b76e57027@lucifer.local>
 <cda7c46b-c474-48f4-b703-e2f988470f3b@amazon.com>
 <aGVu1Isy-R9RszxW@kernel.org>
 <aGWMsfbayEco0j4R@x1.local>
 <aGbCbW7hUf3a2do2@kernel.org>
 <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com>
 <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <aMnAscxj_h42wOAC@x1.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMnAscxj_h42wOAC@x1.local>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQBPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 762e6043-0c40-4446-83dc-08ddf7a1133c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ToK7frXPwBexg00l0Jaa6vXBY75weneVtiJ6Iyr7F2lJ8Ze+UK6oO4fJP90Q?=
 =?us-ascii?Q?yevwoymN53WW85erf5jpDZLG57rhNKBSZB6ADGTa01lPq9l8w8eLzrBVgyNx?=
 =?us-ascii?Q?oIFigCsx8ruF7SqnJfVw5q9XUHjFkgWjuHviWcZ0NAGofirDSTItkUX0rfp+?=
 =?us-ascii?Q?isge9YyKJAJwC7VDIEbNqQSgCxY3NavpkaKYbk40ppcvygrpb31tFm8c9NH6?=
 =?us-ascii?Q?gO+ryjFcX8Tpz0Og40kzTXuEQLZvzgS3cdQ+PQSjsZALD0jPccAcgV9de1GT?=
 =?us-ascii?Q?xzpzogEK3PtQ58b80s6mdvt9uqgyS4P4UP0OTmPOgm+HrM7dKh5QgcnN9LEW?=
 =?us-ascii?Q?BPTbU4Kz1dv6JCUX6CWCxBbJZRoMzHz++mjY1ro8A6eMCfAIzK/DPeL9GPiC?=
 =?us-ascii?Q?TPYw6NM5xU3SkUT7TZLCQDOFMD7q/rv+0aZB+90r36F5/HDFBW/yXzcwhiLp?=
 =?us-ascii?Q?N9nBiEySnMqHAhPKPbGRYKFf+mDNZFeOLrjWdvuKeBNIzMWx66jQxlLaqwXL?=
 =?us-ascii?Q?Rekd7FwVdJ03CGel0iD2+hVuIMa0bjF2SftiqdxogrjbluguQrYUNertF2hh?=
 =?us-ascii?Q?RtzAl5OSadfVCIDTl0M66+4wUAfDWhKQVqiVdGDV1Tq35GPyE4Xc7P8HGbBc?=
 =?us-ascii?Q?trKm1HkAryAXobWTxYc7xjPnWgrDIbUjuOy362CSFFWlqhAPToCW85UOjG2p?=
 =?us-ascii?Q?govOHOOX7ix7/508Z1zAc3ioU3Z08g43mIUvA6gZ7GsY6OQXttBTWwaMHIoN?=
 =?us-ascii?Q?fKjKPehvg0W3Yft9TRqw1PMlJRtK9ZUECUc9CIh8KEmBLdENZWmua4C1SzuQ?=
 =?us-ascii?Q?bm+xzlOSo7DuOl0Mzmr30kQPL94Pxht1sivvXrn+jrP0KB6b5Vuj9jdmLMFA?=
 =?us-ascii?Q?kLw/aNbLW/ezNiF5xEv1UawIMNWuhaHmPRlxDO7m97ItVj35h2TCg8fGZoIy?=
 =?us-ascii?Q?rzUbm7uwcmz3GpZmtvOY6QDFiJlIypmLzzYKXt/rtnvMachRx6Nn7zB61Qhk?=
 =?us-ascii?Q?I/WhgnKcJ2n2LXQ/W42SR6/bhRLPDZGA+PxHhKL1zhZBJGTlx16S22zkV7oO?=
 =?us-ascii?Q?pHO/Gtlt+R0qkVp8HwkmDQIF/6xdXdr/tXwbXC8RakZJfIcA8omOT5nAT2xi?=
 =?us-ascii?Q?ubbiKolP08z8DdRQ1ay2igrSQvTjj8vtc5ViJlRRQy0ptkNDdOyeB6jvBzuy?=
 =?us-ascii?Q?B2zfimVeB/wPjYWOrFsVz97jG8hZx/DyCqc7fYxcuO++ckbYvgXsSVMCOACh?=
 =?us-ascii?Q?Hl7MLUcRbhOXQDuBUt3vXoiJZMgUHt58XfMuAhKdn3w2KXHPz/+zYWltYvu0?=
 =?us-ascii?Q?+72LIlhhKlLtRjc27hOTnG2N/0VVSebuFhEPq04LwEd5lDnakN6L4ipWscM4?=
 =?us-ascii?Q?IiIJEOQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/+rAqzw4nRbT0ahJI2mtUIO8JVAPH0RrB9QSGWsDT/MCxKcp8Ri0vySjyZwF?=
 =?us-ascii?Q?s0++nANC3xHEQpb9g5eZRAJS+oSZ9OO1BA4yGwp4OPlqWlqh3+kuwOAsbMIK?=
 =?us-ascii?Q?Ac/YyO0QAZ2VV8OaH0JGcJhiYk2bJ0ODqYstlP6miBUn/X/55z5SML2T5YeF?=
 =?us-ascii?Q?oi6FKlHtTgLZxeDSOt+KYSZkFlNMiuiyZGWeEc2eYSFUHonIeesTlFdBjyw3?=
 =?us-ascii?Q?X7Kb5Y5AasvRzcko4Hv8fdj49v00PiF9cWhzHOlC2LP0w0X3Q9tvdPUevsfr?=
 =?us-ascii?Q?vNCBaawbsH2JM2HFFhVsno5dcBOeqghrXkMAxKl6NnzZ9CmEE8vmaQfPdrAf?=
 =?us-ascii?Q?mUO2VVR4i6P7lOothiupVMkN/FCWjLpn8+fwlAKlDUqXy5dOjbw6ByzBjabq?=
 =?us-ascii?Q?o3Rcsm+/AicBah6DFF/5xfmP0ka42SIrUv+SBm9t3TI8rKPmkH+XEWc2wwDJ?=
 =?us-ascii?Q?OzmCuOvziB80AqU0i9J1vnexQwHvLzQ7YP+9alBLIgLKZg6iHw5b6LeHGzVV?=
 =?us-ascii?Q?iL2S/iMpGQibflF72BYQs+95QDccEOmlsEZpd27Ut7C0W31Rtm/zUim9Jsxw?=
 =?us-ascii?Q?ETH4fldpl6B9twOf7dnvUvzIn8HGbVOEtiqBpXFgC5Khi27yksIenDpGsYQT?=
 =?us-ascii?Q?DEPvARzJmki83ZcfIiZjWgCyH+6nRPKRCQefxWO1ZAZpqF71nJsK0r5fYIg0?=
 =?us-ascii?Q?LIfdml2w0tUSd7KW4uTeZsMg4+cCBgagaTBX3555fsSuxRkkVNP5VWkC1Ojv?=
 =?us-ascii?Q?OrEguhAyQgkdZ1FIMX5QZ2vj9XOa+oHITad9Aphggs/2kfn7n0jWnPj/2z9a?=
 =?us-ascii?Q?ySJJ2R7cKC8TYyrOKQh8TnvGLsorDQcXBj2b2bV/mMboy6FnEsHQGVLFxPJ2?=
 =?us-ascii?Q?c8RGBtJ+BpYpGsV8ZDg8FbQlUh3wQuEye2EgiQZvhzkRUcpYWXGcvl8hPcn6?=
 =?us-ascii?Q?nFfzEKa2kjOppXZrFLhJiMc0VO/Zz2yd+YFn5vn+ktMVjw5hU+e9zz67GBjr?=
 =?us-ascii?Q?RJahLlO3eicRhbb/WvruMhIzdGxrGKVZjb3L7DAQ0MUZAIuBTcG4eHxs48oM?=
 =?us-ascii?Q?/7VRtXw7MvQLthXYPrJAYtasLYusKkj1tRnn3l45EhCZJ0JG/X9joUVGaR//?=
 =?us-ascii?Q?0KTHEWZyvX391196hSYRUd6JzwLEIz/Cyo6NsS9py2UW90Ulb46qmWiWVMPz?=
 =?us-ascii?Q?RpIMFRFrUqpwzhMdUqTVqfp5FwqflS7XxouBpHdcHKpwZyCfax9D+uAFjyrG?=
 =?us-ascii?Q?q2OoNXK/3u7EgTkovfZdN3eBhpC3Ejuvu14sDOSMQ1SqNTcHs0QA0w8lj9h6?=
 =?us-ascii?Q?S+bj+v+MPDVpVM1MbhQZedEYMqQzcp3t0hPpLIfIWHLPBQ1P5Oa8SpVYv+A0?=
 =?us-ascii?Q?7BXF4VaciEv2Pgd+L39GKlShyPzoVsKKSbuydVJ6Lvr5Ast+cKydSxRGgi5V?=
 =?us-ascii?Q?Lv7XjR5G/ZHFqT+5ypHdMaNdkZfg5Io7AVMFRqjyji3dvQaNuTq0RQNZ75mg?=
 =?us-ascii?Q?wg0vyzXikScZd+LuDnS+NOT4UqWn5RNaii9Zj+WCmL6PuX/K0W11Z+Bb9E/Q?=
 =?us-ascii?Q?CGV7uiyNomMbm2vpLXC0zfTa1Fdw6UXv+gsQfL8N?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BodnZL9zsaSKym629qtmnRE9cXf7SiAThpeZwDf2fAS74GyitwWhFQiPaZqtfzk8fsI3Djcudm7mvYMPgIkiafYsBSSDJOOpdrCuFys6jY0JiQyyhCRI0/wg5j8J9sldzCvICv1SWkYq1g/hW0Sy5S/U4vnU2VrR1z7aO32b70nHeL51zAcKQB3A2W+KNA4fRjL4Mqw26tRGXgvv93t4YeYs/ovAfu6pCT09SHqNhFsvJ0c5ZxsG57IgPwMjJAgt6bxdIgEZrMkmycl9JPHULTqqlcylZ0HP3mHeTa3vJaxi6cQkgHgbyvg2ovs3ld8d/9xFOA/PRXPvAcw2DlmpcIKb62NjDUc1z54uC6MHjSu717fVzAMGHI6dUnkO5TjnjogRN0Uqw5Ja27YlHNKDnrWJ/msYNawWZFCQd5KjkXUeabblsxT48bcrY13nBpy/YzywsbZc/WX2kRqIEF++4moawpbSCmaZg13Ekn7CsXubk2g23QLCwPmUqYXxYpdt8rH6ROMI7bZHx8HvMPqOQsjjXAbGeH6W9VesMI8c/+nhPIJeH3XOZ17yCrbfdJZ+zrdVcr2TdIYTRtU4kyDyyuIdUDcDys5wnroFPb2aihc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762e6043-0c40-4446-83dc-08ddf7a1133c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 17:22:14.3105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cF1m50jpjUHkwXZgsWTJaR7UEAr3GIo74Ory1U9YpAWUZJoMgSbLx1QdvytMz5ERU/q9HTpKPshGy3giOP6Gpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190162
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cd914a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8
 a=20KFwNOVAAAA:8 a=8DstSWihVa5M2P4fkQsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: wqagGW2qhbn484YKLzVodNrrs48kU63P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4DpZ1sj1V7aO
 a5OnEeCrNlP6r8D7MWRSEUWqE3HLiEnuPWAda1eLgsxqNN4dXjYrmWfO/rnhW/dMWb6umDrjbM3
 UlnfU1tIqrgOdRbGkv3VhjAapA/1+pXGpgM776MfRYvGmTAPPN1Pala3ilNi4me5ngqFN0b1BEX
 lfTIZibtga3G3Nf0TDGGZVHqwRtG9OMt+oErrtGVycF36nYxhcAs84mUosPAK8ezknteGPpUJfS
 XilxShXd0r4pW0I8kFo8PvGQIx4jedafR7VJPvKcHRgzGeIBeoLPD8G3Jy6Ph+odYB0+KJQ49m1
 UmwxWEkLmmWOvqyzDdL70MHQTp9p9RDUOmTsm83dYvqg7o35Z5fFtpfLJd+GEzQkDA12FIT3QqL
 CiSV6oIs
X-Proofpoint-GUID: wqagGW2qhbn484YKLzVodNrrs48kU63P

* Peter Xu <peterx@redhat.com> [250916 15:56]:

...

First, thanks for replying.  Sorry I missed it.

> > 
> > Can you explore moving hugetlb_mfill_atomic_pte and
> > shmem_mfill_atomic_pte into mm/userfaultfd.c and generalizing them to
> > use the same code?
> > 
> > That is, split the similar blocks into functions and reduce duplication.
> > 
> > These are under the UFFD config option and are pretty similar.  This
> > will also limit the bleeding of mfill_atomic_mode out of uffd.
> 
> These are different problems to solve.
> 
> I did propose a refactoring of hugetlbfs in general years ago.  I didn't
> finish that.  It's not only because it's a huge amount of work that almost
> nobody likes to review (even if everybody likes to see landing), also that
> since we decided to not add more complexity into hugetlbfs code like HGM
> there's also less point on refactoring.
> 
> I hope we can be on the same page to understand the problem we want to
> solve here.  The problem is we want to support userfaultfd on guest-memfd.
> Your suggestion could be helpful, but IMHO it's orthogonal to the current
> problem.  It's also not a dependency.  If it is, you should see code
> duplications introduced in this series, which might not be needed after a
> cleanup.  It's not like that.
> 
> This series simply resolves a totally different problem.  The order on
> solving this problem or cleaning things elsewhere (or we decide to not do
> it at all) are not deterministic, IMHO.

I find it very difficult to see what abstraction of functions are needed
with the code in the current state. I feel like we are exposing an
interface that we cannot see what we need.

> 
> > 
> > 
> > 
> > If you look at what the code does in userfaultfd.c, you can see that
> > some refactoring is necessary for other reasons:
> > 
> > mfill_atomic() calls mfill_atomic_hugetlb(), or it enters a while
> > (src_addr < src_start + len) to call mfill_atomic_pte().. which might
> > call shmem_mfill_atomic_pte() in mm/shmem.c
> > 
> > mfill_atomic_hugetlb() calls, in a while (src_addr < src_start + len)
> > loop and calls hugetlb_mfill_atomic_pte() in mm/hugetlb.c
> 
> Again, IMHO this still falls into hugetlbfs refactoring category.  I would
> sincerely request that we put that as a separate topic to discuss, because
> it's huge and community resources are limited on both developments and
> reviews.
> 
> Shmem is already almost sharing code with anonymous, after all these two
> memory types are the only ones that support userfaultfd besides hugetlbfs.
> 
> > 
> > The shmem call already depends on the vma flags.. which it still does in
> > your patch 4 here.  So you've replaced this:
> > 
> > if (!(dst_vma->vm_flags & VM_SHARED)) {
> > ...
> > } else {
> >         shmem_mfill_atomic_pte()
> > }
> > 
> > With...
> > 
> > if (!(dst_vma->vm_flags & VM_SHARED)) {
> > ...
> > } else {
> > ...
> >         uffd_ops->uffd_copy()
> > }
> 
> I'm not 100% sure I get this comment.  It's intentional to depend on vma
> flags here for shmem.  See Andrea's commit:
> 
> commit 5b51072e97d587186c2f5390c8c9c1fb7e179505
> Author: Andrea Arcangeli <aarcange@redhat.com>
> Date:   Fri Nov 30 14:09:28 2018 -0800
> 
>     userfaultfd: shmem: allocate anonymous memory for MAP_PRIVATE shmem
> 
> Are you suggesting we should merge it somehow?  I'd appreciate some
> concrete example here if so.

What I am saying is that the containing function, mfill_atomic_pte(),
should be absorbed into each memory type's ->uffd_copy(), at least
partially.

Shouldn't each memory type do all the necessary checks in ->uffd_copy()?

To put it another way, no shared memory vma will enter the if()
statement, so why are we checking if they need to?

So if the default uffd_copy() does the if (!shared) stuff, you can just
call uffd_ops->uffd_copy() with out any check there, right?

> 
> > 
> > So, really, what needs to happen first is userfaultfd needs to be
> > sorted.
> > 
> > There's no point of creating a vm_ops_uffd if it will just serve as
> > replacing the call locations of the functions like this, as it has done
> > nothing to simplify the logic.
> 
> I had a vague feeling that you may not have understood the goal of this
> series.  I thought we were on the same page there.  It could be partly my
> fault if that's not obvious, I can try to be more explicit in the cover
> letter next if I'm going to repost.

I certainly feel like I've lost the overall goal during the
conversations sometimes, thanks for pointing that out.

I keep thinking this is about memory type modularization, I think the
cover letter subject keeps getting in my way.

> 
> Please consider supporting guest-memfd as the goal, vm_ops_uffd is to allow
> all changes to happen in guest-memfd.c.  Without it, it can't happen.
> That's the whole point so far.
> 

...

> 
> While I was absent, Nikita sent a version that is based on the library
> code.  That uses direct function calls:
> 
> https://lore.kernel.org/all/20250915161815.40729-3-kalyazin@amazon.com/
> 
> I think it's great we have the other sample of implementing this.
> 
> I believe Nikita has no strong opinion how this will land at last, whatever
> way the community prefers.  I prefer this solution I sent.
> 
> Do you have a preference, when explicitly there's the other one to compare?

I like this better.

> 
> > 
> > > Said that, I still prefer this against
> > > hard-code and/or use CONFIG_GUESTMEM in userfaultfd code.
> > 
> > It also does nothing with regards to the CONFIG_USERFAULTFD in other
> > areas.  My hope is that you could pull out the common code and make the
> > CONFIG_ sections smaller.
> > 
> > And, by the way, it isn't the fact that we're going to copy something
> > (or mfill_atomic it, I guess?) but the fact that we're handing out the
> > pointer for something else to do that.  Please handle this manipulation
> > in the core mm code without handing out pointers to folios, or page
> > tables.
> 
> Is "return pointers to folios" also an issue now in the API?  Are you
> NACKing uffd_get_folio() API that this series proposed?

No, I don't think I see the problem with what I'm proposing.

I'd rather find a middle ground.  I was thinking it best to have the
part needing folio pointer to be in the mm while the rest remains in the
guestmem implementation.

The other thread seems to imply that it would all have to be pulled in,
and that seems undesirable as well.

It is just that we have had this sort of interface before and it has
gone poorly for us.  I know there's other ways to do what you are doing
here in regards to ->fault(), but that's the most flexible and hardest
to validate way of doing it.  If we can avoid exposing it in this way,
I'd rather do that.

> 
> > 
> > You could do this with the address being passed in and figure out the
> > type, or even a function pointer that you specifically pass in an enum
> > of the type (I think this is what Lorenzo was suggesting somewhere),
> > maybe with multiple flags for actions and fallback (MFILL|ZERO for
> > example).
> 
> I didn't quickly get it.  I appreciate if there's some more elaborations.

What I was thinking was the same sort of thing that happens on the
ioctl today, but with a memory type, and only for the callback that
needs the folio.

But again, I'm sure I'm missing something and I'm sorry to drag this
out..

And sorry if I upset you, I feel like we're talking past each other and
causing a lot of stress.

Thanks,
Liam



