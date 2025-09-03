Return-Path: <linux-kernel+bounces-799353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 435CBB42A61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3C454E19D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E02E7BD5;
	Wed,  3 Sep 2025 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XJv7KNGk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wWffDFQK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAE1A9FBE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929506; cv=fail; b=nkr+YxVyv3WoxAbUMSwn4W/TsbNbspDtgFm/LUwbVxlkKZN6oI65rFQ4djTrA/5orhrT2JT199aDfJm1c33UDAJblgMMr1PzyGaGR8GNg/Lvukh5yRPiPfhR7w1G0qp+c2+1g1LUx8srgnkeJGzwz7m6BE0Ii/3H8ArvWGU/0O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929506; c=relaxed/simple;
	bh=u2C8J5P9LoYfFzpmmkPRVWVKRchEPlufCIaCQzmIRcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XA9tt0On6XDJO7n3t0SGlgrpjKKVGar3TV+20Q54V5yB4r5TGf2/92B4zFjqsnwyBTqUJakPr9LW6Bl2jNb+6wa4D2XtgLmUwA64AmF6GSutyFVqTz/iz9r0aXEwDrReeYtjFRPcu5WinHPZxYETHvxmzHgdz7ETeH1NatJG/bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XJv7KNGk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wWffDFQK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Jtx2j028620;
	Wed, 3 Sep 2025 19:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FdH/8uEOaHDdZSMONx
	NDq3MkLdjc7tUKKvd+xCVEG/g=; b=XJv7KNGkVJA7OS2zLkmWHaCwTM0j4oXVxv
	p87GHOczC4Wv1nB3rB740alUiFTQaSLUByt4d2I5JaolMG1uZymMX9xnjK8QlyI5
	0DnLwoUQ94eLD2WFkeA36Yj5jgk0RgH8ItQydEwTCJTuaAtQEZTG16cWLvzxQfXP
	0ecg03U6q6IeKpfzkoGbJwyC6bynLhPAylGnw750qr38P0pFWOuP5fc5OyPZH5Bk
	Ix9DQBTn7uR5tVqSqqw6/GF/iPp01LDU/8NSnhh7XJCew7qhnwCrBepjP74TIiQk
	xXhO1FJPLtzQuNIg83MdgE02oMjTzpwdq+spZPw68rQBdKZN+soA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9qamx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 19:57:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583IXnRE036227;
	Wed, 3 Sep 2025 19:57:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrar7qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 19:57:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPhspNycWJ+w6AZpJXN13O2i/LPj3M6dkPfafGFM3KjAGuk6MB3eoABrNGjmQ9QRpT0ih1SMLb/EAZ345p35DiNEXRPb6w62Yv07Fn+c5fab8EgU8mOHke/CVZ2SEMzoaZMKtgLGq7tBhHXmsqIKfq0BEK8sm9BiUkTcvUO8RQAJXSzyvasnlcmamuKf8F7vGvbjbNntGaPczeb8TERbpRyD16zAGlUxXMNoEP1o6z24WMVjyOcb5ni1VIhvQaqCJAL6n2RHtYIMqgyNNZ/ATOZDFvJh1NKGkTAfMJQNOA5N9Nv+Fr/fDjXp0PcaV2yJWwra6XoBqGXyyBEO5tOQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdH/8uEOaHDdZSMONxNDq3MkLdjc7tUKKvd+xCVEG/g=;
 b=jwr5JBS45uISmLvEzpTUykaNpam3sCFOzVKh6b2vWEiWVYi/AhdNrwFbzC6YPIU5j6XPsKshf0aX5gZ/SSFohM0itB8pjzbIDDqpROe6v/CAxGTu9Mj2bLT4V/KhIFBzWE0Fq8uyc0kHspH/jwNRUOdz++72rwlaOoGUvWb7szI/V9ihDraarmZDYalh50IvCx9P0BImUCNZXJESy0DY5uP8ANC1U6P6PVIM4ETM9PaLqRuhAmHPJWX9IL+wOTTsrgnwj47xAiduwiL3M2p19P0DzE818U3NiyvIR1wI+mQRXKTiWoAu/ymb95Ok7Da6sFSA+k1khynyxxwK8G+hyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdH/8uEOaHDdZSMONxNDq3MkLdjc7tUKKvd+xCVEG/g=;
 b=wWffDFQKu9QrIS3L9RFHVtA8t+NoslepIIBVVyMTZvrZJI/ZDzB64Vn5bJaXjoslgDoVpMnPP2Kndmo+b0lQuoxSsZ8rTjrksTp3lDei54OKIQJCnpQO1og/UNfrGULPxMWRElHtWIia0DuxZlHIN3LLxG4fZjsf1dq+HRqr52c=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM6PR10MB4348.namprd10.prod.outlook.com (2603:10b6:5:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 19:57:44 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 19:57:42 +0000
Date: Wed, 3 Sep 2025 15:57:37 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 3/6] mm/vma: Add limits to unmap_region() for vmas
Message-ID: <w43jgvlabgvxpq2jb3zv7zo64r4xbvmad7cf75l3keests7djf@lmqslvejyyk4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org, 
	Matthew Wilcox <willy@infradead.org>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
 <20250815191031.3769540-4-Liam.Howlett@oracle.com>
 <a32ea375-f093-4f8f-9270-fbe9f7977cc6@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32ea375-f093-4f8f-9270-fbe9f7977cc6@lucifer.local>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQBPR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM6PR10MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9541db-1bfd-4005-b5ed-08ddeb2424d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ftZNU7W1AYy2zImSu+nyq/I8Jc26pERYgGzZumfInbz1bjx6JNYG4dUJzOYe?=
 =?us-ascii?Q?EEvpXVT4kIv6gke4V6Jd1lKUBh7kxmK8UYCJnwrHm3TUK3I0lRczCpYdQ9pR?=
 =?us-ascii?Q?4d/21j5nnk5+PRJqZ9/Y1Q6rEoLBYIs8rzbuOngCKU14suFHSXXy25sNzZyz?=
 =?us-ascii?Q?EsZgYRqWZABL+A65kLneVCaZ9M5/Fybv9GM/8WNonawPTqdxPYdGnTta+ns5?=
 =?us-ascii?Q?fe1t85Rr5o5nDrPIqSMS83y4Q7AzRqL6gW8QMngc85AaNZw68OkPdBe8tnyH?=
 =?us-ascii?Q?EObMkTZZB0w5ea1Nti6/aDmpRw1U7oNmJv+Y2YnxShzXttEAT+a74YdmedDG?=
 =?us-ascii?Q?s4viNUjVxT3ckwDc14YEetyCz4zn33VJ71Ykg840L3LDLmGT1M5qHN20CsEK?=
 =?us-ascii?Q?Ltc04wFxQA/W12xtaKcvWI1R/rs3EwZxLt5vurml0QYgATeYPX37Q0G2SH6E?=
 =?us-ascii?Q?RLDc89YNSUWvqU3c+4fbBZXTpbW0VZVVxI9nBOY11qPbaA0IJmyRWiJrwik3?=
 =?us-ascii?Q?Hl5Xc/xWdriFm5rq5G5plzZHNIM57NgGNZk9qCQI6W/MY5aEUHjtNNWf/0Jz?=
 =?us-ascii?Q?XPaLM+okIq6wDwgz+r++LGDtqzvNOUzZdxjKHLJuI8kVuHCAkKnDafODEGgz?=
 =?us-ascii?Q?tjMx8+0piA5RNFvUPs+bHkqbQDBZWjCLXJjeczUo8pBXpD0A+HyaSQjV9oQB?=
 =?us-ascii?Q?koJ9cpAQ4V0Tz9bDL3pcBJpALJCTUFayV2IA/UfJrdIQtcTVReBmg0AsjvHr?=
 =?us-ascii?Q?3Nd0UFAM7U5Wi7fRrkBrnhWRVBfVRXFrUgvGThqJyFkxco0R25ki7C2D4Ln/?=
 =?us-ascii?Q?3PwRnzu8pDkZSptDiQIl9zTXc26qfN+sN1FUbLUCtxmAx6SwOAaAQ4xoE1hC?=
 =?us-ascii?Q?kfkHsr6hqb/Om83tDrgQpi6wZOizYyGcXoqKQYwinBusbzFaf85YnmnapvDg?=
 =?us-ascii?Q?SU6cr8I3Zs7N73Qt6+EjD3760/+Sf4gvFA46k4okOTE4FE2rccIFkY3fm7cP?=
 =?us-ascii?Q?GCKLNDnE1r9D3H3IiJkpyxwbe9scZgVMqufSIVyWH684s9tAMtLGkY2nX0DW?=
 =?us-ascii?Q?mqSuYqb6T9cj0XTKuWAnE2ZYIxpmMb5OLHIkqsn0f3kll7d/nW4AxyPqm7dX?=
 =?us-ascii?Q?NOmWktfcHc6fkkbrynkOjsNR+bJ9aLY2+ecVY2x5iAQEMXZd+kFPI4xiD9lS?=
 =?us-ascii?Q?AzWrUAjpX9f+tF63qnT9CFXNViEONVGn4gUUioposSeSD0fofd/YErh+glQZ?=
 =?us-ascii?Q?Gf2v3Q7/eb3PSz6Gp4zBQXhd9VYRj4L+n9r049CHyqc3uTJM9PJ7U5dor/cC?=
 =?us-ascii?Q?e9muKRs/OO75uU9aGIqywLwrX3XMYhkYeBpuNwFuOOM+FpacO4/BBiQN2RhT?=
 =?us-ascii?Q?NMcR4YjAeV6E8Rh5Tu3hQBduv6Y3i1mxGsd/OnKMkLmpt0GXDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b2SeSTST3krgsX8XO6FvE7UDnXm9k8ClzUxIPmkD7n3JT8YDs/TdCjwO1frB?=
 =?us-ascii?Q?PSskHOqYrOSfsx5vV1Gf416YuUVGcQSSPu4+E/QTJwPycQA8BrlR70e5wnlP?=
 =?us-ascii?Q?SCrCxguRar1mLW19u6u/JiwX33v61mM5s9IEwi0C9o80LCHokUpVIyriG6t7?=
 =?us-ascii?Q?IhrKuAvT3uxLJOG5UQh/rHljojGiWeatxU1AitEWV3hNeCQMxdqf4C1gjSf3?=
 =?us-ascii?Q?/jUf8DKW3ytKzqUooM4u+5e7v6yMRQqHbll+DLoH39XQZMKtB9d9bZWJLRNs?=
 =?us-ascii?Q?MXLCmSNzPjsuLLUqCs1IEqWqBpZCXLdp1uqG1h8YXgm1u3s543FKyxrYxzdS?=
 =?us-ascii?Q?eArwLl0ynnJvZ9NHL7ymVGkRJSUNluoO8paU2IVMyHMJdqgEQ4Rp6bk+pssC?=
 =?us-ascii?Q?emMBMRgSk54dNsVqvp4C5JPW3QYC9eTlcO9HklDipkcT92K+MaHEK9yLYNBN?=
 =?us-ascii?Q?1Z2wSDXhn/s9PhNcAVDVrUq9miSZ4OxHl7HhK3GsD9LdqVJmxGRNKJhi7msv?=
 =?us-ascii?Q?nHqEymuhcxc3mZTSVFLjeJv9+lyCgU6QbXhjAmRXBHysBmx+rcQ+Q8rtid5t?=
 =?us-ascii?Q?uFUiBNLp/srbbHxFoiu2kGTvbRaM6ZDG25MVqYvCqgm6Bi+za1UMmPqdLp4Y?=
 =?us-ascii?Q?uUOw7OuH7fPsVwhNUMU23xusfXYtKU2pgXxe/QmAqfEtcDfybe+yekaMQQ/B?=
 =?us-ascii?Q?le/LqTLifyWx0vkWBPldxyd7AorL1h7QDwc+6TyCnASAhuOwbIEFMWTJzKqs?=
 =?us-ascii?Q?hDI0PM02l34Sc1OaBSEyVCMsOCM47XSOdiOXiad+wLX7ozGZR6JvZrD9jJhJ?=
 =?us-ascii?Q?hgG1o849a8NnhjjRzafusgsNThDc7MzDk91irh1nCMOyC6T9kyHvnDJtfc2b?=
 =?us-ascii?Q?BPgn+y3esHABJvXX/P6ABGYFOVq/DmeYgMzXh6yezkucwB9gsErPYaV83iwc?=
 =?us-ascii?Q?aMEHdrWH2RpnPE7LG55wlHDegNK1jXNrU3wHQtDZEHgC193HZp86LdewA3hh?=
 =?us-ascii?Q?9dcjtZ3mfvfN7JQAiUK+tHI9+8mFsL7HU+36HbTEbDQ8JWihjAOyZ/Yfa4O/?=
 =?us-ascii?Q?PklKGHjPGutXXwNqvLT4V13piKgMQ6UYfiN1RBvAyuursLuWZD19ZAg6pVB1?=
 =?us-ascii?Q?MPTIqR1uiwQpoH2NIv2YS6xm5h1lpfurMP/Alvt8DiSKCcN2mS3hP4Fq6Zrl?=
 =?us-ascii?Q?xaQoHuEstSzfe9Xfnssz2QYbOUIme6p8bl5mCr2lsQknWPp0HKHiYILOIAxV?=
 =?us-ascii?Q?l2+8jBYUJdM0FHyfGO/iWI6CNklGQDKR58wwfOeHmYNFxM9Qp+/WwuyQ5gN5?=
 =?us-ascii?Q?NZssVpncBvx0pd0vjWsLPjnVAh3O32cNKQen3Wz6X0wSrrpTXU0aT4JHGG1w?=
 =?us-ascii?Q?d7oY8VnAAENTqGqVKjmlujRSG1HONk4Vv0of+g2Hl6jgc2vADDQeKuARsdnW?=
 =?us-ascii?Q?+GS/LtXcljFryXs/p3lPMDW+VpmSSDbGIbmjOMCAjBzQlAQ06kZZTCPdwucU?=
 =?us-ascii?Q?GKo0bbhVloOgJyBeXb0AsMwsga4dpr3SW4wUDx1pUr00s/lXPMDtPfPEB/uY?=
 =?us-ascii?Q?906EZ4/8slztiT1vL2iVd/FYCoXiy2XMr+gEUPNs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cu1dD73708r9qWbzUU8wGNVwYpg1WSxIWnY2wcbnWMXS43EbWqCypKQB1Cu4xCQEhbQLLsGeUcz0TXFvolW9KyXERkXTc3eRgtSAqHtpxq7YLHJhWFZSbPdpYZIa81/5GXZXIG7PDjmYiJKdtLVBCYJxayC9eF+xL2TImDzD6Qb107Q91Il2NSeKmQHPG14+rbg252kKvd50JadUbW36B7HUh7mjlqjyFTRmyNPgDrld6ViKiAApgNZtIZzrLQV7fDiPly/bBKdlzSGTHeeakdZ9pp1R6aV1DPmBnP9VB/hBAmHXIF94QfTBkIZy8JtgIVUmpOIVsuFVihW3yljefphHKoX+9XDKMF11zX/lIC3ziNlv5keFbWm/2Da2ahGXjoBtODXN5mqIrBEjkhUr4rjV9yliKk1iSBOb4431+6jNqHQ7fzEV5tM8dgV86PVyyv4sk5jKOlIcVL2kt/VLr/dBTqvFxt7mS9/tGW7fnUxmfRXwhmnc3z49U+X7B8KDAC4Qozoy9Cp9Cwx1vt1JLXl7bS13ulI3nGIDEG1GJIuEQ72v3c71UgfLfRGAsQS5c6TP+dfLgWEeGk0/R7Ob74dDlcPnb9WNR15+LSteqVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9541db-1bfd-4005-b5ed-08ddeb2424d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 19:57:42.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FH+2tmWM3edtsjMhhncOXPa80VHOTxivjWek3Xj5GxLhNfEZiuhu6DJyPp6XaFf1Aw6JQnAyFBjOds8jRLasiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=840 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030200
X-Proofpoint-GUID: 2GjJjC55pcp8-utCD_lDiY9uLA-mdnYd
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b89dbc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=BvtdNyCXY5Kc3aJ2HrUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX/1RK/+y8O8mo
 tVXp5c2cAEJdiOsRv/qoYfXL20utVTlqVwi/d+gh7l9Bqv1MDZY7ybWhc8fSRdlyCU18RH6AAGD
 KnBaHS2mD0zzQRs3PB52v2uADMF/SmxWBSJcM14oDpUms/poQkbAxnZQ769JkEiE1jhW7CAuV+r
 rxirWPCtWpFKbHuCZeZkNU/pTf9KfFCO24hVLC2lwbcXGb2Y+iZU/2wAJ5s9t15ciyKsx42WiB2
 S8HHhwGpNUHZsXqz/X/T0yNvHL1R5k66B9yqmyFVIm25SPSrEGhF9WiMiiXXDnwYTatP0RkAhM6
 fAGB1Hongvwxk5WJT/VpfmSLpJyETfXtG4+ZyBERPGa7/+1mQPLnpY2SwiVjTGXASIqq6wlI0At
 e8kMBZ/K
X-Proofpoint-ORIG-GUID: 2GjJjC55pcp8-utCD_lDiY9uLA-mdnYd

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250819 14:48]:
> On Fri, Aug 15, 2025 at 03:10:28PM -0400, Liam R. Howlett wrote:
> > Add a limit to the vma search instead of using the start and end of the
> > one passed in.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/vma.c | 6 ++++--
> >  mm/vma.h | 1 +
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 3b12c7579831b..fd270345c25d3 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -474,6 +474,7 @@ void remove_vma(struct vm_area_struct *vma)
> >   * Called with the mm semaphore held.
> >   */
> >  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> > +		unsigned long vma_min, unsigned long vma_max,
> >  		struct vm_area_struct *prev, struct vm_area_struct *next)
> 
> Luckily we will be getting rid of this as soon as I complete the mmap_prepare +
> friends series (_actively_ working on this right now).
> 
> Anyway, this is getting quickly horrid, since this is only in vma.c, we could
> make this static and pass through map to reduce some of the horror?
> 
> We actually can hand it vmi (and thus &vmi->mas via map, so we could implement
> it as:
> 
> void unmap_region(struct mmap_state *map, struct vm_area_struct *vma,
> 		  unsigned long min, unsigned long max);
> 

Ah... I could do this on top of the last patch.. that might be more
clear?

> >  {
> >  	struct mm_struct *mm = vma->vm_mm;
> > @@ -481,7 +482,7 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> >
> >  	tlb_gather_mmu(&tlb, mm);
> >  	update_hiwater_rss(mm);
> > -	unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_end,
> > +	unmap_vmas(&tlb, mas, vma, vma_min, vma_max, vma_max,
> >  		   /* mm_wr_locked = */ true);
> >  	mas_set(mas, vma->vm_end);
> >  	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
> > @@ -2417,7 +2418,8 @@ static int __mmap_new_file_vma(struct mmap_state *map,
> >
> >  		vma_iter_set(vmi, vma->vm_end);
> >  		/* Undo any partial mapping done by a device driver. */
> > -		unmap_region(&vmi->mas, vma, map->prev, map->next);
> > +		unmap_region(&vmi->mas, vma, vma->vm_start, vma->vm_end,
> > +			     map->prev, map->next);
> >
> >  		return error;
> >  	}
> > diff --git a/mm/vma.h b/mm/vma.h
> > index b123a9cdedb0d..336dae295853e 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -281,6 +281,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
> >  void remove_vma(struct vm_area_struct *vma);
> >
> >  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> > +		unsigned long min, unsigned long max,
> >  		struct vm_area_struct *prev, struct vm_area_struct *next);
> >
> >  /* We are about to modify the VMA's flags. */
> > --
> > 2.47.2
> >

