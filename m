Return-Path: <linux-kernel+bounces-735451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB49B08F82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF75E3ABB2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7B829ACCC;
	Thu, 17 Jul 2025 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EScokMhG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CIFfYHnm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347E2F7D02
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762699; cv=fail; b=hyaUNHgmpugUsbGAPX83jD/UOF0P5ZchU1W3LNWD/wFM+iM5xEWMzRvX3rpsHfbdJ2wFIlcdyl0zb1VWFcjxtqj31ev9+bBYzM5Epdu7rQs+iAts6rdh4Tz6bWcK45F68twMX2LmDHFCSWLPf3odii8PU0UQduYVLaew/gp8H3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762699; c=relaxed/simple;
	bh=QJ3LYHSo/8MgyRVO0IwUaZgKt3ceibkzd8PIipFLpxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PUwGwYo30ZzBeaHo6wKeFbpxTbUnVq8eO58Yq2jCgWjfG6rkKB/x1TwxOyiewemb8XU7IUXt14mqAMHazXNtwsgJSR3V126pbmM7gfQ3H6eD+l0QHL7sJV+IEvwG84/HA6TBEQ3q0wjX6+AO3g8+QZ9B2rs0wgJQy0gq41j0lWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EScokMhG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CIFfYHnm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7fp0v020705;
	Thu, 17 Jul 2025 14:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=CUacXsHZb8456d0z3N
	ELuE85Fn4fkra1vwfB+g1oh8c=; b=EScokMhG0J/IVbyYaPRK5Z82BbNO7dd+IW
	01YiBBC8I17uMn/uE0WKTsyr8KDNbIHaoMWWlafKmFrUB0361gRa5RrWGKn81dL4
	/FS3LG5MzV5o4wwLwpMClpvdxhQp1A9RKUM8anZ9uC+gIO4uM5DvF3B7dJJggeD2
	kLP6owKOGBKVuyItWyJ7OHLx8ayVmyf3qrhJaxk0DCkMjzf+dpdnRL3mw3+kxEgj
	mGDnMXcaVERGzacgbuGvoHS0WCdTszIk5h8WlXmg1CWWZlub8r2Va3CSABCkZNIC
	eeKDoBwL8ItybicHsEwfFKe04ANePSzsM/iemjVyml7xf42qMJcA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4u3px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:31:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HDWmZw029634;
	Thu, 17 Jul 2025 14:31:11 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cgvas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:31:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgV9PiwZZMe/zSXnt6fetunwYlTcRGOuxtB9QMloKk/gOTU+EJnapp9g6oWxaARta/vhKyimHvGi0WKm7v1cthBjClgVqhcW+3TCa7rxS18/FGa2+XQEHDF9TUOFpGO+YhLm7I6mXh5dVKZ2nfwCsCCMbRhWBXNbJZCdNyIML4rG/cFRD1Qazq7HcCC3QlSPy9c8AgQDTWZnVHR9G4OBVDpEn5PvgXpnOe2QsPeTimld2z2VVeZdSOj2tZB3LZ9gWlSprlftZyUXM+ns1XosWIKDdn+ChGeE/ZPCnNn+TU00ONUBiF7gnVcRhgK/Qqj6QMoAOJs7CBy5Elm35ZQEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUacXsHZb8456d0z3NELuE85Fn4fkra1vwfB+g1oh8c=;
 b=sXBpYN5t8VVluyRwYP2OAdkIwpxcdCzlAc0GZi0DM8F9lWSSQRcnVY+LbegZdUFjbgCsAoRJqMb6pOJnIdR3B1CAi+rMtf4IhiPwOhrmYwl4WGa4eCQ6L5EzB1yoT2r+tBWu6Aw1aXdLjDGK2CsXVeTk0kAxIWk0uESjhb1fc2HZHyQrHgiSgRPhT83myg17W1vOq/xXAK8l23jBCWSOLwUxnt2q1y3m2m5gh9ghVPB5rTiT87FMYk8VQzdaXXV7dxUXxtOmCn31TQ9Je+j12SFePgI5rQl8Ph+FVNcFmmbHpsCroIv66K476AxmHNGRxsaA0wIvbwbleykK10REBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUacXsHZb8456d0z3NELuE85Fn4fkra1vwfB+g1oh8c=;
 b=CIFfYHnmDiDlehOeUpZ6FyYvC+gzgqTvNENdUG6ixVSSoLGuAycgHErPAEO7W9WgfrALPq30W5ZvkBlpVMpAzZ0u2Jdkg5MyPCKgVw3dzHbFvaYdskBUGfDCMbVtDeUE6ysneSzhttAV7i/0bBoF0wpvTirUDKsaj493GERa9+I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5105.namprd10.prod.outlook.com (2603:10b6:208:325::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 14:31:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 14:31:06 +0000
Date: Thu, 17 Jul 2025 15:31:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/huge_memory: use folio_expected_ref_count() to
 calculate ref_count.
Message-ID: <1c125a8e-650d-46fd-aff5-0cbf81cd8474@lucifer.local>
References: <20250714171823.3626213-1-ziy@nvidia.com>
 <20250714171823.3626213-3-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714171823.3626213-3-ziy@nvidia.com>
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: f446060c-43c8-4b5a-2f5e-08ddc53e9077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cjDttnYj39aSMjJHO942d18U0TymdRJHBnnvoGbYbTx3ZHzqRKbzgqp1JTzf?=
 =?us-ascii?Q?ttapWQkOJ10svfkVPcAsniUwHDCXZmF4CCs7/WKB0dVTUEFl6fp3TegrxD7R?=
 =?us-ascii?Q?OF/p0O1ngXvBO4oxJdMpte5NgLnBoMKwWKK8iQ4iu73fFB4vJM+VAqCduYDu?=
 =?us-ascii?Q?WAZCUCJGtYaTly/frDKFlBdnG3elxOPOJyh3lHEH4dpgv9eUiWOaV4/6DAqn?=
 =?us-ascii?Q?vxnjNNdJXICYIlnvnGWvqmN1/+4l6AOOq02JoKcBmH5tiAB2+msRM2NwA+HZ?=
 =?us-ascii?Q?6wR+CnFornbvtk5osnaeq2KOrxtNE4CbKStppHct9BbsSh/gb2FeWMr8HwB/?=
 =?us-ascii?Q?bH+SjFOCb22/s1zgkM/+11DKl/DtyDhEzu1mDm5rhhC2QJ22qoiVHptc5KvT?=
 =?us-ascii?Q?L1hLM9sy2TM/IXtQsdgBNNPdh1/tH6rbxsaAD47DWvbMcQ0dZ3+AgkCsaTOU?=
 =?us-ascii?Q?KPw/D/V5jAdaprsEgTKyuPO64g65y4d6IhUjbKWN9NqC1R8oHmJEj6UO+OHw?=
 =?us-ascii?Q?/4T/oben/s/EudDn1bIQnbZisVGIQbUeq2yqC/f3W97037yzihpH5++T+jY6?=
 =?us-ascii?Q?KQy6Ey3tMbc1vJ0lurHjNXNvPsU39Ds1qtPxx7AZrtPPV8UWWxAxk4Bpy2wK?=
 =?us-ascii?Q?uwnu2nNkUbPgzHOt9TK1dwxYdirTxJGSOpFl0fYV0E3CdbBy0fdt5XOEPqwV?=
 =?us-ascii?Q?ik+vm3SyGXXmHeOD2kLeULoFZ0y6+rHf4Jl3PGPGmvybyjU16uwd1F0drRlC?=
 =?us-ascii?Q?Lo+VMiG/pjJZ1Eo9hLoVYNbw9FOYs3/zC0qzAbh9rrCr2Hy1fsTj3e/4x9zm?=
 =?us-ascii?Q?jwAZ5PfmCJVPUfoOnyYv8RmBGfU5nvJMwJBpg1hUet8oLBFDKizUuhp8wrSU?=
 =?us-ascii?Q?MlNkC6kqWo9w1+m3Z4TW6mmUwgpglxzY3UN1RwqDc5G9/A59A/UQ06tuO9x6?=
 =?us-ascii?Q?mE8lMbjoDRcz32fYT7ntO8zzyP6PSC/wQl1q4eezABwZZzoRjNg49edLg2id?=
 =?us-ascii?Q?qV1QmyDhYqrjVVxgFukXtbh3trBT+1CUV9grDKh78VpvxOdPS0PQtqRQGD7t?=
 =?us-ascii?Q?jmUYK7cqw3FD4L2fefAqCENn6wBLmXvyjF7fo4OEbUjpaF+lb/YHgaGNvssY?=
 =?us-ascii?Q?kUJwjqfyFzkBOwxk8T5ysUDdMSUG9PXPUb0kOGSf9678aZXsU5tsKGuYWD9m?=
 =?us-ascii?Q?FGwBQLdzQGRU3QSgQnEFd6Xx9MOLugdV4UqH7OYZU0Im/ngwHNrv4DejSeuP?=
 =?us-ascii?Q?MU4ebyX0fCeSAkQIQ7vyqg44cTFewlZ7SNLI0mdcQa36BzukGpanBOxNEQ2F?=
 =?us-ascii?Q?hkwvUspxioCxftNiaSMmXwBxkFzduBWmSQpvytCJYr9E8NaLOfxcqycZq5da?=
 =?us-ascii?Q?M6wOlhoem8MtJi9BXN49NuoKq6LiLfxh+MQCW6KsPtDh1J3wzv3LdBtRRQTp?=
 =?us-ascii?Q?FDihvuCaL9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ws+XWNzZ30Pq1T7fufqmGJ7ODzBxgDT0/Hm3oTIV6IjlcDtwlDWgN5JMqig1?=
 =?us-ascii?Q?BpezUcMklNMboEY8+oPKrvJrBeOKgc/ndvPDoiQdoeSH5Mr75SBI1cP7Z7/J?=
 =?us-ascii?Q?xX+y3CtoErvXcRROgjdVC/7XWXwAyMexd2zNfO+n6jF+Z6oEpri59ReFAnal?=
 =?us-ascii?Q?3QC74BRKx+TXc3V1rbIIGC6Q2tWnBUhJToHPuczyfhlA2KZiGywDEiCz4hqb?=
 =?us-ascii?Q?B8uYbAv8UAvyEBJbzDTxNaxD2vIZozR9H7albiLPYN7f6PgVGZyGP/Xs5MSB?=
 =?us-ascii?Q?y0tY6nAU3IQVzmnqIrQC0N4JXLHLoEde5DuK3Mk8RAAN7N+9zzDEDh09we1A?=
 =?us-ascii?Q?lI6/w8U+jXWIGajZSit3eXt2xCOZy7XsXT3IZE96d3xdMifxT81SJMRbbsoY?=
 =?us-ascii?Q?OQS5nnYI0MJu6oOhrel9m/cdiPo+IabfciqnBhtEcUqS9bQL0gVy3/S+Dzvs?=
 =?us-ascii?Q?HOcidRDIfkWv+XZNxzs8iR+Ji4SivZfU5FIrRZqw3LvzwDdd2eHzA6RTVWdl?=
 =?us-ascii?Q?4pIfXyRKOOKct10/KJFGAqUQ8naB8rC3z+nsR72J0YbDy33txHuk391J90P9?=
 =?us-ascii?Q?Yi/KPwHOyqxO+WrnwyZV1r1hb8rA8UHg1zVqOd1tjbUVbKBWCdaNiaZ9IA/d?=
 =?us-ascii?Q?rx/k5rm0Sij0Wt+HGgcwqVRaaAd0B3fr/ctQBuhPF4N52NEIv+KhwtAVXx3V?=
 =?us-ascii?Q?8+ar2eSEl56VNQy7eoG8BTZwR4zX504p1/Pu+jkccS5yhZRLRAwT/l+TH8NO?=
 =?us-ascii?Q?n/46C6FuZHnG+V+T1p20YzAPk4PeTLlHXjfocgpvzyQW2ViHD2ydBnuGoOoz?=
 =?us-ascii?Q?MnF/lCvO6AdRXpSyCBD7DdqNsLxnepmir058AWABONgQ9kwiX+5p/N3qtuQl?=
 =?us-ascii?Q?ydXDMNCOADsedvRKZ5n0LmbGV3xVahrgdJZ7b/3PNTmX3T58qO8uCOk2jrtG?=
 =?us-ascii?Q?i1/IxPqt11xMvo6vN0lUbG7TboA3Se3+TneZSHes50YVK7Znn+LqycSHwJOu?=
 =?us-ascii?Q?JTdSJzIJu+aEc4zlcDGe9OE31Vd9sBji3frn0XINx0u+dN30VoHFq4u58VTA?=
 =?us-ascii?Q?oR5PeMzuuaSPFN7tv0xZ6EWAjHmsgNE2tFppP+1TXrkjSt2/LE91QhkrUNuz?=
 =?us-ascii?Q?mvMF1GOnUlJioRY0swBBqgjHz40lrL7lXuARmmJv7J5VguYYbD6PjfKmo8LV?=
 =?us-ascii?Q?Whgg0Ial0nySEInz+Y+3kpLHD0p/jZp5sLsg3BeF88GWQv1dpy9dCnt8SKeh?=
 =?us-ascii?Q?/0x5Eo+d4TYMKBtpJKI5cFvdWidkiUP92O1j6D6WfJxCeG1t5HHh5EAgw/FW?=
 =?us-ascii?Q?i3CcNeceiCSgNtjkTBMTbPbLvS6Q2mez77YEN7iMd/ZBUBwTN8UQ7n+vRoID?=
 =?us-ascii?Q?3JqFmNR1tZXFQWVCT0C6ZIKA+KPirQW7qO4BRTc6LxS/JHc91NJBsLLna5/X?=
 =?us-ascii?Q?wzs1j+lRl98BK+/xcZHdrdQ1ZUAEnAHrtIE2S+kNoqR7krmH5BDUtG4kf0+I?=
 =?us-ascii?Q?ZmQ/fHBZ4D1hDSz0xhguGOmDpSBDFmu/pd51aumgR0mr92D+oNhQt34xmosI?=
 =?us-ascii?Q?ldAow11bZN1RNNgGQJkQtnuAML0g1bQfW9loT0D3+E0lPESNzNneohBQu9Jc?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TErtJL0HIJzvHimpR6vt6vQV5BU9I3quFKc87DAx8JS9cm0S0ZRGmf7/8LDZF7xhinJ25BOecqTLwvVvmCeiszChlRCd6+SgwRgQTos6606snvr5ngGFN5OW7aWyn8WxaE3Ww4QV0jVIAn1DNAL2lQAd/pKAQV/8y+Lh9Vv2RAgkhzuoyD5bBzHcaJJYJgGxMtQpb15nVp0HD7PNwYUGIAVYVO+jSPmzUaPqetVob/W17XoRVIBbYcKk5JZHFYgFJSb0cp3mDZbqzi+Sys3SSUloC34Zg7oyyeZylEGq7dVzNb3dTC7CovRKXSIOwtiZljbzoetvyXzYGroPTxHB2hGoXjcXyuo3GQB5YUHmzNNKnfqclkc3ksMEi8v+vB2qajRY6ahKfYSPrWXeaS8qyx5Bb06Ih7Fj9V7SmcLiT9TvxptkdiwOZHy7nT5C6jVQ48NXdb8hNOkLVpCrSZtMWGlMq451lu1DD3ddsKtQPbWBc+Dukz8wBoguYn2/Vb0rwc3qCghu9J34CdiskydJhyCEnmsThOfWKElnjPQcLnYzsQ4D4NT4wAAvn0A6qC/FItuDTBp3erHpAV7OpOQASdXZ3ZjJAnKC+BfBxFDhZbE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f446060c-43c8-4b5a-2f5e-08ddc53e9077
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 14:31:05.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEwjDNgqi0Di4J2AOHBTtD4gdNl2nIMPgCzAfvyre/Xqm6JFzsbEKaKJNlJicXXc55vLHxVFfGcsyDbqBpe5UOOhl904njYGGG/wfmvqrSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170127
X-Proofpoint-ORIG-GUID: wi4Hh74-KfYNsFn3D6Q8RGgICV6B7PsT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyOCBTYWx0ZWRfXwYr4LCOfA47O qyIfu6ODW4B5R7dkRbk9lprZWhusGBzTqH+Z3H0qDcCPGcncvon/mUoq/s3vP+xmZntV6HAc6/c YhhFYjVPm7uk70uHpoKE19qixIChpdgMsCHyiYBcPTKeuknkz23gtBLq2/w36hmVyucuwa4czB/
 ccxgCRXJ6HnyyEB1bs1clZ2PSPjCmuEFqth4b/tG+R1PhCjS5X0S1inx6Y0x11f3/rrH/9NzZUg 8v6onXjcGE4yTjFtW5yxPrwhoKe0fErFDbxVw+Zui7ce5q9eqv7/kkHWj6zTgEtBKiPQUtp/tZx xokMwzyFEbudPCrgi20VjZM6bgizRituwKEdIlwISjFFbThGEFklPjEoY/GP8cDAC9K3Zacoj6b
 zsiNxAtfTeFhMYftRzCyF+1tgySXFfT3tTgeeB86E2jdoHpq9MTrpBjkErT6Pv6nW32UnWrG
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=68790934 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=zkuwDM6TRwHOCsmCC_4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: wi4Hh74-KfYNsFn3D6Q8RGgICV6B7PsT

On Mon, Jul 14, 2025 at 01:18:23PM -0400, Zi Yan wrote:
> Instead of open coding the ref_count calculation, use
> folio_expected_ref_count().

You really should put something here about why it is that the open-coded
value and the value returned from folio_expected_ref_count() would be
expected to be the same. See comment below inline with code.

>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Balbir Singh <balbirs@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Ah haha you're literally addresing some of my code review here from the
last patch :) I love it when that happens :P

I'd like you to improve the commit message, but that's a nit so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

See below for some analysis of the folio_expected_ref_count().

> ---
>  mm/huge_memory.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a7ee731f974f..31b5c4e61a57 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3735,6 +3735,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>  		struct address_space *swap_cache = NULL;
>  		struct lruvec *lruvec;
> +		int expected_refs;
>
>  		if (folio_order(folio) > 1 &&
>  		    !list_empty(&folio->_deferred_list)) {
> @@ -3805,11 +3806,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		     new_folio = next) {
>  			next = folio_next(new_folio);
>
> -			folio_ref_unfreeze(
> -				new_folio,
> -				1 + ((mapping || swap_cache) ?
> -					     folio_nr_pages(new_folio) :
> -					     0));
> +			expected_refs = folio_expected_ref_count(new_folio) + 1;


So digging in:

static inline int folio_expected_ref_count(const struct folio *folio)
{
	const int order = folio_order(folio);
	int ref_count = 0;

	...

	if (folio_test_anon(folio)) {
		/* One reference per page from the swapcache. */
		ref_count += folio_test_swapcache(folio) << order;
	} else {
		/* One reference per page from the pagecache. */
		ref_count += !!folio->mapping << order;

^---- these are covered off by (mapping || swap_cache) ? folio_nr_pages(folio)

		/* One reference from PG_private. */
		ref_count += folio_test_private(folio);

This one is trickier.

OK so looking through the logic, the can_split_folio() function will
already assert that the only pins you have are the swapcache/page cache
ones on the 'origin' folio (the mapcount bit used in the freeze doesn't matter
as you're dealing with split, not-yet-mapped 'sub'-folios).

So this precludes an elevated refcount from PG_private, therefore this will
naturally be 0.

	}

	/* One reference per page table mapping. */
	return ref_count + folio_mapcount(folio);

folio_mapcount() will be zero for these split folios, until remapped.

}

You add the + 1 to account for the folio pin of course.

TL;DR - this is correct AFAICT.


> +			folio_ref_unfreeze(new_folio, expected_refs);
>
>  			lru_add_split_folio(folio, new_folio, lruvec, list);
>
> @@ -3839,8 +3837,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  		 * Otherwise, a parallel folio_try_get() can grab origin_folio
>  		 * and its caller can see stale page cache entries.
>  		 */
> -		folio_ref_unfreeze(folio, 1 +
> -			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
> +		expected_refs = folio_expected_ref_count(folio) + 1;
> +		folio_ref_unfreeze(folio, expected_refs);
>
>  		unlock_page_lruvec(lruvec);
>
> --
> 2.47.2
>

