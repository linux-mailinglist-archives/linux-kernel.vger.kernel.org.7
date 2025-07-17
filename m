Return-Path: <linux-kernel+bounces-735904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB758B09506
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2011AA5805
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD892FA65B;
	Thu, 17 Jul 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="loxtWY9x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j5yxv1gk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414082C3271
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780863; cv=fail; b=bQ5oBC1czLGjUpmG4s9/6S1XZdyNhoovT5KJlxfGAbk0e2KvwqQR7C5ybnVwTjqB4YAoJM014OjgMP/0q7tyk3/8VSUb7GaPhg3Zk5igVN4Tr5w8ttSLwkxSQ/dA8JVvXeZ3IKYVvzu0pEsNJqpp8LgZXtujA8h9IXGespXHG9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780863; c=relaxed/simple;
	bh=5kKM5iamN1vyF3npjEKjcEwoqlIbfAbcb1jG+TmvTqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jBdVbw75c2zCFUakhqsxdr/LFEMTRje+TgkzOfR7/+Ipnk0VIi+jvp8uO1Dkr1BC7H3JRHfsKN5k8CvycwZIEyBY22jbkQS5O/TqKyse6uitI89Xv4gr5z1hSadaRx9R61IcC8Tp2Yl+OZ2UpllBVjS7HxEAgkeRFhdexiYXly8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=loxtWY9x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j5yxv1gk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJXoVZ019115;
	Thu, 17 Jul 2025 19:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5kKM5iamN1vyF3npjE
	KjcEwoqlIbfAbcb1jG+TmvTqs=; b=loxtWY9xAqdBdeDzah8oA7OthBY0GtoBOC
	rjpJBjHAsXO3XIc8QR4t/c02gnA6hUN1NB+BZ6p8E3oFGIP34m0KFr/ep04zGgtz
	F/8stYDClBjWNFs70tFqoqZmrjzaNoHjHmljGs/srfE2R2Gc0s0aNGEqTSnLHUcY
	Yy7mMR0fgjrIeQ7MKKtkS5e8CzSyPDC/tWiEJ+3HV4KGPf5efm+5Rnkh1quK6Q+j
	e5XehaVOl5SsYJn3RR9dJ66+LTONVpD6KV+5/BKjOIkFDtncFsaQjJrcKlzjJ92P
	jfB/Kg3DDb0+AaBWglbmTMEyWuSAQeq0jubWvg3+nuXaSFE/aQMg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4usfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 19:34:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HIYqpT040461;
	Thu, 17 Jul 2025 19:33:58 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d7msr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 19:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZNnGQ7vdyipy1bQcjMzfYEdX0L64cFKexj7z02ClQojM39yBsQRWhkp14asU9mGnzNadO/rnPtOHloCIHRLeS948K7ekRfZtwBVclep+vHs5mkfxvgQHsPlQNpjk5Gx2KYIfWUBC2zaNdov350BbOQ8anXdw25mPFQk0IthcWpLlVXmBM4XHbz8eepcm5mWv7mQGMlD3eZz2ZhTLPg9XLAsxK5zcLToswcVUwc4SteTcBQXG7w/zyCw6MeKH5/zciY5VTcvYUZRCy8IAu9eflv2TwT7GaJZXjgxke3eVsx9c+rhaAXYy1HuWGeTjrCnfsw9OksvIJJaaBB6NQrTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kKM5iamN1vyF3npjEKjcEwoqlIbfAbcb1jG+TmvTqs=;
 b=RQK9kfDjgiXWY8n4CUbiu4uZ2vyqO2SeVC2xOuh6LoxZ6k+KB/A7eAkoO2+sWzA5KT/onq5xdnvwryYVDRrf+chbLvydreG6S9zksgFj+gGOtOEnLvwvm+sMfSwdv6mtKacaNTe977UW/E4OELL5Esri3GU0KaxfMDBnoWeBSDnNXt2FG5pgh3Sk46S3wndfLBEFX0m+Kbswje3W1lGDNX/SImUNTLf1oiOKTFa8x83MpyyocgH78iv5+0syGEgAoypEJzo5yrqFBgGvwBWoAY+cxETH7k5S3dcDjju/UxwvUbXKY0vvHR54R8hjPjIdkQsRgHaznAyNFwpiinyv+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kKM5iamN1vyF3npjEKjcEwoqlIbfAbcb1jG+TmvTqs=;
 b=j5yxv1gkDf8zGOeUnfzliCh5OgxmhWUuO9Y57+1zlVdIA1jWmkgHGIwdqiIFhNq0Ka0Oq/yvsszeVeWB2W8HxNGEt/gr1iWVlo41Rc1XSAhszuZB3JeFNljM8gzMmGUKVGvl+6m9aYqBRy3m3aAfzMgvnHQtg3hcFMEZufH5D8A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5140.namprd10.prod.outlook.com (2603:10b6:208:320::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 19:33:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 19:33:56 +0000
Date: Thu, 17 Jul 2025 20:33:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Antonio Quartulli <antonio@mandelbit.com>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
Message-ID: <6f6279d5-802a-40b4-a0c7-e8d316ec4cbc@lucifer.local>
References: <20250716171112.3666150-1-ziy@nvidia.com>
 <a479057f-5401-44ea-b3a8-dfd82b826721@lucifer.local>
 <31D32C5B-6719-4E3D-880A-666044C4A48B@nvidia.com>
 <5464ABD7-C4C9-4BEF-9E5E-21F5A18C42D9@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5464ABD7-C4C9-4BEF-9E5E-21F5A18C42D9@nvidia.com>
X-ClientProxiedBy: LO6P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b14dc5b-7bca-4036-4ccd-08ddc568dede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rtugqgAgwb+oCFELSbQn5h65bFAEkrJ12USNHYOD2YS/tQfRUuv/VXw+0LT+?=
 =?us-ascii?Q?uw+suqmEx75jzv+rbKxl2P/NjHTRMw5HhxSfrLupphSGmaoK7Gzob3cneLHj?=
 =?us-ascii?Q?xz6rZCD4/CIvx94yJA55VQ3ekVHgBceP67ylCblw+gsZ8l0HYm8sXgZpu+6y?=
 =?us-ascii?Q?5DoqwdtzZUt5Atbi8HiKo3p93+EyDULwDEl+eR/NJuvKotKq4OKBIwsbXsY2?=
 =?us-ascii?Q?/dEMFoSaZOgCP83SJDBNAB/goDUUJJtHVn065Z+cq/PEEujzjZq5TIOIVJu4?=
 =?us-ascii?Q?uC3imNywJDIVfa+IVk3SG9pN4cy4lj7AJGeaIsFyykSQkKftLa2hlN+XSpDR?=
 =?us-ascii?Q?nzmTLBisxzmd5M8U2t20v7GxSqcRYAVdDeXyFv4Z6hi+QiwrEasrrYW798Tm?=
 =?us-ascii?Q?WlgpUmk5/WhaowQy31JlOH2u42SvrAYCeEpaneJX/Fy8mF78bw6mI5m5aaf0?=
 =?us-ascii?Q?3CCxktK2bf5CGpSBmt40r1RqBYUkL0E1AeAvNjjBP+EQAXHyXYGAdK5+gAK0?=
 =?us-ascii?Q?A0RfM63TZ9agTg6QgEfTtYMxyaJL+NrlbdDUrm+RTvwztg8sZdGCtHHsQf5v?=
 =?us-ascii?Q?TCw/MjemSGeQL3GVmHHTJGAmUht0fL3BuqN/lRhnfSeG12170mxQVZIliaPn?=
 =?us-ascii?Q?shthjONKyfBflijm9DJU6nc54ElzdKN+dz3tIBb4UUWhdMU3mDorQE4WfuY6?=
 =?us-ascii?Q?c6rtBEDAZkV61x+YgRhX9ADRIPyo1ekTzci5oj0YfZEY1dAa9ygEb9Y+3QMr?=
 =?us-ascii?Q?9gjfnxoBGkvF/MKLZdTotFCzMxXN2Md6oqcWHnBJic5z+/xRwMCntSrbG90Z?=
 =?us-ascii?Q?kuslq+RbKO4xpB/0ej9VfLZo1F7bPg3kxKCNqslD8j7F+KYYZR7eBYUeA0vt?=
 =?us-ascii?Q?EYoYWVhs+Ia5OwwCs+G4twuQVTp2sFoFyYeT9gUXEkVbM5mju9Hug2kg/REs?=
 =?us-ascii?Q?AH5OybPKlyfgxMbdbY3TAwBBrQfjRs4bA23cCozBmNa3nqm+lySkX4FnLcWs?=
 =?us-ascii?Q?KqeOZIRnTztGScYuf/iyN2mkCHvacca6whZ1Jh3WAUtv8mwhyJPGEvGe77oy?=
 =?us-ascii?Q?A488xCDYcSc12UG273kYLarJdYYDxKQGuKP90JdcpFzG2+KVgQ2n5sEvw2zt?=
 =?us-ascii?Q?B0/ORC2PxQ8WnZ/IBKAMkw4PFnyHb1J3hyhkNDdjYoOcnaNhYNwHHiy/DQdT?=
 =?us-ascii?Q?Zi2DYaLXpOOfD6SeuAYDpkQihmKpSu/sPakcXi9peu+6Nt1YDhJV33xfdMlu?=
 =?us-ascii?Q?6uRRrUmqA8DJyWZyFicUn9e1LXYHc+y3440PQJ92AuEUw2GKrb0Xh4ZNIQcv?=
 =?us-ascii?Q?eHSQkvrdhUnOhsq6h9kgJBNUT01esSKIm7/HcRuuTYxy14Kf+JONmL2HXeAf?=
 =?us-ascii?Q?FJTHdVdxAhr/BHcZmZ+RIBQHpAvugrIBPJhE44jJ+HQeYWAp3O+Od51xKQy+?=
 =?us-ascii?Q?XFFBWrsT/ac=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kIw9RJl+XWMHKYI6/uKuhAD0h/tdH9nRDcMTwPi0hASORqQrgmIkIaZ+l85s?=
 =?us-ascii?Q?Z/nscojZJfS/DmdwfKxkbOfrPIxFoTPpxVU/dFYG0UihbzjW8+GdcE2r9jqB?=
 =?us-ascii?Q?BLZVtJhkgBA9sYAtTTGj2C7fheVwpJBV1ZiEbzPPni3n8Aa9omJH9zoaPRkD?=
 =?us-ascii?Q?X++1btZboxwFh4sFycu1cN2CVSkPKWgmhqRJ2yKJkEbJIQLbwIUFqtOm1q22?=
 =?us-ascii?Q?ayhk7kTp93Ei7UrKHR+PKPiRzuZXcbOgjSQA0vjFI6TajnTcLrXJNkNnfK4V?=
 =?us-ascii?Q?rGAGp2NOrXoscW929EUHJUrQhnAyXNKobyU6NI5TIPiMQG16jzQRCCkE7Ent?=
 =?us-ascii?Q?219xT2bb1U4Kb5WvvrxBONbTTDU7LbRi98grhTEtlS1LfLMA3snu0TbEK/DW?=
 =?us-ascii?Q?u8Xr1BSuM2diKuFqHAI3iiZLPIKaPxP8ST49wshAblx74aonyjjd4gwBMifC?=
 =?us-ascii?Q?EWXHjRjiTc+RPuMlpdIR9yYzkUGA/7DhcKSWm0pVzgi8qhz8FRShVWKECXhx?=
 =?us-ascii?Q?IOxNfFVKDwuychwH3oeMO5evUSzw/8lUiKc4JNEz2kgX32dBknGL/2vIXaKw?=
 =?us-ascii?Q?5JlU2Uo5YYErWHrHfBQQ0qOjOTIsM4Ugy1ADlZ7MeVfREBj+IRPI5N7E0hOd?=
 =?us-ascii?Q?53WrOowQA6I1jJ2B9k+31xz/2mDIC97REfy2XBd6iQjOmUXu0+qwX4yQ9qL1?=
 =?us-ascii?Q?Y7s7ruPPl5YwYT1aX6TtMOXclzxMKOie2Sacv/mfB6FjA6Kt2WRRPM73duiF?=
 =?us-ascii?Q?wTdLOZTM1PTNNmcuTIldfvPEoEu++1WVCP949qdOeJd1xOWt614k6fGpRNsj?=
 =?us-ascii?Q?sZsCbnhCf6vbxvlpeJCUiKAin2v21Rhl8VciESaSB0s5XDIaM5jPAvQIXGwg?=
 =?us-ascii?Q?n/BNKxMiTBYcf2uWHfGqb034yESSogLoatHh/rxvYMU+svJFj7da4FYHk4RD?=
 =?us-ascii?Q?wMyYSqFkXeqdaq9Z48ALvLGCH5ZSibUjQWgzXL1Ic3paBGm5RxNtPD6bIbfd?=
 =?us-ascii?Q?k6QyU8uG9jLv3NA8MDorRJCVWvSnP+isA6Dxr0z1u8+S9g2KGsbnELbrH3v3?=
 =?us-ascii?Q?+uGhmpAv5pHSW32ZTUgAndcvXSggnmg2vdrR7vWY9ANqB8yTukuqazvLdtHi?=
 =?us-ascii?Q?fXKNNSE5VdVGdhQw5s5QCc+36b6hWFK0XG+iWee+NboQkYeMTacQ935Kvnuw?=
 =?us-ascii?Q?/jiH0aYFNhgAo0znsEcbb1gR9sf/NTg4aj8S//TXcFVmBIFpXHMgPMcEUaQn?=
 =?us-ascii?Q?bTVnfkw+OBQc3xwx9EDWsT6RnLxUjbIJ86seaSXPr7kb4KToFZRRwZ3YWXVP?=
 =?us-ascii?Q?vuVOOP3tErGoYfUxfIrwn+lnpdoNl3xA8tDFC6PJBFW8K33GcMM1mJPogTjR?=
 =?us-ascii?Q?H++86HwBil9wxkHVkL6zI+i8y4Mrvs18vdjbnuy8SIzCXRWjehXYX+a6NeSv?=
 =?us-ascii?Q?FsLsztYerwS7+XCRH1WuyYTorObpTU5prWnOHBOvV5NUhDOBuAteojg2i1YV?=
 =?us-ascii?Q?lUBtnGNlz9Yh9cXgnio4ztYFZY3IF5FZWy5ORYgXJbegO/B1XUTAutaDNDdX?=
 =?us-ascii?Q?A2s74T8WW8Ns0QJj5uDaJbwunJmemxu0cPv9h3tGs/a64gaXNnMcmkh1GfQy?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lN26JesmUOD1VwjGdlMJXNpAYAb7Gao58I6IDuTkiDiwfxylII3kksAjwAFWCcMQJGyux+z8LkhJZZZCikOo8D/5Eh4h7sgzo06TPPdq8UxVYPXsCiBR9qNth78iEaWOXrZsOFjtAxcro4fe8wIEYtWQF/wxzDzBoSCGKIDK7EKKvwf7hBmfYC1PXROFfXhDiIkpbW/Qvk9QE7gWcr2c2mmCE4VH9fT1NSDAHkAA0a3MlXVl/Vv0Iz8zbuh2+8TwRrpERqAAsaClW0BOZUCnS4JZSZxkjq2Ofp//vvC1MYC4GUqba1GvtHAkxoIvnK8vX8r+DGzgKfQhg6nQf+jv1BFRhWll5M6IuyRdNu6CPEWcNhlYllxNAgjTEkZ4/uG5Ota0pbOCrlsvl32B4UBZ5/2hWNsnR85uuHAoaRbi+gVoUt6/YydtBlo8byoGbfdGuuvYE7Xf+X2Gb4djKqp/OfDgwBUGZN8k3Jii+lqq5kQh3Rk0isrciUQyE4lwqpxcthWTooYYV8PKET2cG/hb8OmI41a/7ja+4ng0sR83PmBwnSabEt6A8J98Wn0hch80IzhIxj5shm4i3XtyyGi7zKfqzveKHOljpANIz4SEwaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b14dc5b-7bca-4036-4ccd-08ddc568dede
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:33:56.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXK9WhBTTnugCjbGiTT6+Gui03RzJQfjqPy7kuffnsM5XxpiUC/1z8Em5jmuZdY9F6MzgTav7RTjX1K1cxbwjOU6oSZ5PVY/vk3+VbMdjBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170173
X-Proofpoint-ORIG-GUID: PKbnKoTqsZXEDMOOwMQ-8dk8L84Y_Y0m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3MyBTYWx0ZWRfX/jerVf67S5eA ODEkWzilzovMa1gP4v311hbNgC1wSYG5EjMOzhr/HVaRGpys6VHNgcqMRkk5ys/TzkNsYBNGOv+ yidoXKXN/wYI1qWT13oHvT4kiUochiXgsmvlbcsD4G3VcpTz+e6CqMdSaJk43ETBYFtppmBfI0k
 HcbAyKbZRZM0Tn1Ht6FhTH6PIqmRs+6EIrWx19oC9BkC80/9Ls4WBoaQX2kB0w08dnCiqz8nFS3 ZOk0Ud24/DP9be56wJ4ZPyQjPLAGaqkHkdVloWA8KJiX0uMotKIPd/v8Ffee8CqAGmgrCur/1NF 7fc0rQnA7D8p1KzVRNqaR8Wifk18PXqaiDSsFw+Dv9f8lp1pXEnLAzdDiS//DTA0MohOG8Kwtf2
 GaUIYzWHx3MZYXwXEyX99ISBMiDh0FByAYcVgaxL9dlk/MuKF2fjCoI5BzG5JWfIz6Ia+pDt
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=68795028 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=4vA7rrgGAFFNbZ5MZBwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: PKbnKoTqsZXEDMOOwMQ-8dk8L84Y_Y0m

On Thu, Jul 17, 2025 at 11:45:13AM -0400, Zi Yan wrote:
>
> >>
> >> Since we no longer need to make new_folio->index >= end work for anon
> >> folios, can we drop the end = -1 in the if (is_anon) { ... } branch?
> >
> > Sure.
>
> A second thought on this one. If I remove end = -1, can static analysis
> tools understand that end is not used when a folio is anonymous?
> Probably, I can initialize end to -1 and remove end = -1 in is_anon
> branch.

I don't think we should be concering ourselves with this generally
speaking.

But doesn't David's suggested changes preclude this anyway? As you'd only
be referencing end if mapping is set? But then that'd rely on !anon...

Perhaps you can just move figuring out what end is to the if (mapping)
block...

But as Dan alluded I think (hope :P) humans read this stuff in the end
before reporting :)

So if you add a comment very clearly stating that end won't be used if
!mapping then that alone would do I think.

But I see Dan's replying here anyway so will leave to his expertise/your
discretion.

>
> Best Regards,
> Yan, Zi

