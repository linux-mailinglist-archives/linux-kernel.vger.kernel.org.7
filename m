Return-Path: <linux-kernel+bounces-758207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED5FB1CC7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8526518882E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8602BCF5D;
	Wed,  6 Aug 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BldJL2NR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jOw3f9vJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497517A2FC;
	Wed,  6 Aug 2025 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508285; cv=fail; b=ncD9E+fj3p//+1jYsC4+EVd1s3UwmMFQ8HnsG4F0WN9ozTwfXa1yXTRU2qOGktu/96E40Z6z1vlzQWJXxPKJaJU/XtHxCJsvjITrG9FE0CmUFEDoiS2REEr/bBJMwPJ+On2YmJARIrd1mCIEuD+S7emZDTWBUGm4qm1MEOQ3rMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508285; c=relaxed/simple;
	bh=ZttYofjb+Hoy11LYB5UZPQgInj2ZqqjQbhEJ+wWw9+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tlq5q22c6IK9BYZcwJbV75OCq0Vb/GPOK0DtPDhJwlrDpIm1DTRhLI70nY1fanMJteId2TWil2B2Cp1+/H4KsKW2mCb1F+LHdDVkHp+CGFxL5jCsL5p+9fdu+w4XkJM0hwqpJ94uizSBylUN/Le7vTZjvZArM2DMblUr1vQC880=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BldJL2NR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jOw3f9vJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576GROYE025015;
	Wed, 6 Aug 2025 19:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kDJR+xAAqCp2LRbVGk
	1fO27goZy0Y2jhllubxF8nGeA=; b=BldJL2NR8MMPRVniVGAtrG0jwlBckSZhVu
	RBesCCyW8bcsWs8cPpdVxPXA4fNZ0spzsNVdbHNzflJTFbdaS+vhYCbgiYHH8UPf
	IIAQTC2cRDznP50XMdDCMszSfBriX/2drZtIEGVcnHFS2UfCvRUjTs6vHdjKhy2o
	oVBtiAl8ti5COmW6C/HJTLGPckDeUPIXlEGFjZ57SrnycSroPQaX39sE6sdPLKBn
	O2YbXnpW4Jf49ZLBiHsWcmHQCncDVUSo3EfQf6TjYfCVcfsoi3cZnpcBmMGn7r42
	6xAWoBUYdjeQ9+pvTbJvy4YZlfJRnBePiCcPmMZgaPH1UZE6uk6A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpve2hp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 19:24:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576ICO9b027366;
	Wed, 6 Aug 2025 19:24:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwnenbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 19:24:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O10HacTfOw/OC0HRTfol5Tntn3rb0pmXTEEW/MnUGKZ03hGh0LiXGcXYA4ghiAcJJzDYfBxwPSgYQonDxSKE2AO8YzXJj3k+DLRq4Qfdc8LiefmGvEmLcvG4Q4ZLCChYBEaRTn35xULFbuSqp2H9f7EmvUN2TJ5vRhpSZE7GObNXJECNpLIcqA+WkgMSF/9Ra7TviTntwQPeqKfG6OLHnJzDFsfMfsiSV1wcDz3aLPOvPi97qylpdH/DrjItZlBEiXvAzt9/n3H1fvmWUYmpEdPQh9zh6rQ6lysdVhWIlbdyNl+pgR0HQeeIJnEiQ/3jitrYfa+mJzjbO1L0gaLgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDJR+xAAqCp2LRbVGk1fO27goZy0Y2jhllubxF8nGeA=;
 b=P3IbkPssIzowYiggoV4ATCjn54YM0Eht2pFbcW/KYap0HSaWRh/a0EDm1LxsrYHsIYXp1lj5HBAbKw1QBINZSypydKsI8SFvDfE+qAEHrP7b9rFvGISuuPM9Lee/6Bb4pJP2Xl8pq7fUGBKq6gvD1gONp2TgWamL8x/ThnL3BsUOVG/MSMP9Y4yjWMNcR5nKVB/a52MHTupV5SZLIui7tBJK0WBybatqck7xLjazp8B4RuFAu4ws2LQPdeiMYp4pBxt2im2MNdfJHYtnjie/FNs9hCAK6OMwc5wfPwoC9BMx+psR+6VMNGCQsLVRj37oIZElI0PZX1kzbERTmTZmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDJR+xAAqCp2LRbVGk1fO27goZy0Y2jhllubxF8nGeA=;
 b=jOw3f9vJj4hE4K/K1wfgJBHYZ8lKHHnffPj+ntGsVYIHV44/Zk2Odr7VQDLURwmdVoe1HcTwFQ5UwsdTNJTYqSDTig3oTPP0TqohpNGfQicURgFk9wXL8Ko6CST1R1X3WJ9V80HqAKtIto5x2TdgHbDJKkK2FDbnHMJ6gqBt4xM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS7PR10MB4830.namprd10.prod.outlook.com (2603:10b6:5:3ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 19:24:15 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 19:24:14 +0000
Date: Wed, 6 Aug 2025 15:24:11 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrew Ballance <andrewjballance@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] Add Rust abstraction for Maple Trees
Message-ID: <jv5eujafxj7kkzq4evyl3dxaazthjaa4aqz4iwuh47snxbq62o@b3f5pk3wliay>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0441.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::23) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS7PR10MB4830:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ce142c-b5b8-47c9-6dce-08ddd51ed483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ba1eOrk/7SKeJ5ljoys/7yZAmFUNKcAtcLoi3M1vg4NzIBFFAzKhThPqWBRy?=
 =?us-ascii?Q?4FkTgjW+N5n9e8Iqj2yYPuPmMh/hHV4wK5dn3+nbRGYFc5Z5vrArSFeTggt8?=
 =?us-ascii?Q?e+Ndd5DfiiiBeHc8cShs0fIg5KQjAhiLcp7UNZNuMPD8ozYmPzsDNKUPsRAD?=
 =?us-ascii?Q?0XSvlBEdmuP49hGXZU4z9sC8CE0wv9oqm+0DVqdvSaJWXLt6u6iQon1liNkJ?=
 =?us-ascii?Q?O5rynUKifIZ/E8/sTQklzDUAx+ro8wzVu9P9A1gb3oa/VXmb5BSFuiRwRFSz?=
 =?us-ascii?Q?N1RCZdtt8C3v1lN+SjADttSdJmQlSu+2UOuxLwlYY08zVztrXVArOLUzQp3D?=
 =?us-ascii?Q?ERHagSeDFpWrJ0K0aDhULYaS+Urnex0Dk69amkabrbYrH1P7P3hQ7y2h7KIN?=
 =?us-ascii?Q?MaXcxttJE3mXH8ZgBedv9PCRfzAgb7CT7Dwxqe74cb9OeKlnjJ71qvQsdnv9?=
 =?us-ascii?Q?hKvdeGZUYdICSwkFSxrJ8j6i+Q/BOdYDKytGjE6x33HP8hhlU1Kq2YS591BV?=
 =?us-ascii?Q?xjOzrgjBIrH7u9Plm9mnyuLl0uoEAePJVcyynSh1IVt8o9kUDvEjPdKcO3gi?=
 =?us-ascii?Q?RhnxGIQAvU1MDwghisG/TnwRIH6r9kNaPx7OvOSq5aqRPyGdmloqCME243q8?=
 =?us-ascii?Q?ZRcNrjSM7ssuWVj1RvCJ68oUVT1zxROFccsVmYq2/+IbNgT+IszjK8evOZBQ?=
 =?us-ascii?Q?dtfcug0E4ba+f5TzmoFY1lresHYfBSfXoCMtCHoWsgpBtJdqRaggm4mdAYmF?=
 =?us-ascii?Q?ITERS0KxZHvJ2esthLh+qZrmbMJUaCdKIhqVYCPpoblVUbfJCfQb8cNTJeur?=
 =?us-ascii?Q?MmVPWKYAGiWyr9BO8y32W1Q0SnMYRgrnnOurVpvBPpQuvLZjUcZTOhKzYEUZ?=
 =?us-ascii?Q?zLEYVbjNwoYaz70Fv5wu+vK9YsXs3hg9XkbEeDpgfd7VVeTHy8Vw1L7dbUEw?=
 =?us-ascii?Q?c11qta/Stk4LwGZ4X0P2i6KdYUlYmTR3eI6jyqR3qX9e+sLCOAEvOHd5NCI+?=
 =?us-ascii?Q?riOAh++KjSWmVZEFyI9z05zp7U2J7w0xLPWy5pnLNXGhQS/2imMWV6C4bd+E?=
 =?us-ascii?Q?1A4eN7JGbm6gKaORLuCkcVLGoItdEioD5itYlbbCt8Fm4lkUPc9utLNXTTqz?=
 =?us-ascii?Q?ISDcJiarhbaLpsUC3/3QvEsxH1qZbRoYRqHbGfk7bKT2bNc3HWXsMGeBCK7i?=
 =?us-ascii?Q?BjFG4dAKDkNPsanmqJPGbdH5DyIInmE6dMTmAR0m7MsZ5QmW3mW8UKaTr4u9?=
 =?us-ascii?Q?Bvlzg9HsNAylWeT6MP7VfWio4tufBnpDyfS5ETKW3bByB8/6jc06pen0WIlI?=
 =?us-ascii?Q?HMf7IZi0BPIb+lSuJVO8JBiiT23gHeFFSbYzNhrhbIyAiLyeVx9H2DkllvPc?=
 =?us-ascii?Q?KdZfuRek5tKuMXetGYVPiqWpt14CWWlWAXr0oC0HKE25Ct/k46rJGqDqaU24?=
 =?us-ascii?Q?BspNFPQazqA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YORttJ8rAJ+t1asSV173gDdAWoBzGqIh0UGKjLUCXeiMRfR+TA7Ge4stM3Mm?=
 =?us-ascii?Q?8z9EKbd3euIssqb4WoWgHdtRVEzT+GOC2SLx4SnnGrSLRSK9ecbgG9hlvX1M?=
 =?us-ascii?Q?7N3mmudpUyLoZmXsUFt2Ci0K1TNzifoHP6ER5x4llCb5cNpY95xfRnKVdbS/?=
 =?us-ascii?Q?JPdH1A9NRz94O2PiLTezrTiXotE8lHLqpViJvBTqiPzY/AKeRsG3mt1EFN/e?=
 =?us-ascii?Q?Sq1txjRxSpiKoSVGfuVhTtXhBM+zE0cdoF+RUIbQwn0Ew0fJdoWJDLGtmGfj?=
 =?us-ascii?Q?OA5UhJ/3UtiyTvshBVKa5qa20IENt9WLdGA4dEB90mjKLEPNsum3J9WUVJpc?=
 =?us-ascii?Q?HUG4n//CapbtdZh+UAGQ4cetzo7OTH2ASVeIeN8kziT2om5tjmO5bdAPpO4/?=
 =?us-ascii?Q?wku6IyfVH8306G/pPgC8igI9X0p8Xem/V6ofU9Y4IVxyh/Prr3xGpVdQXhDY?=
 =?us-ascii?Q?Up7rq5glQpla3Eyt7h+1B0+V1rb72jZZogjWYrgdIG+u3S/eng+UmEdgX8xn?=
 =?us-ascii?Q?epFniPqc0R25F6l21QJ1Dq4pbyXr7bwZfV7/dqK4X+p+MYGz0y4PmmH9R0RW?=
 =?us-ascii?Q?tiPMMUAEBgYpPgGa62XT1cPK9hIdsX4JoTgvTb1BFW1INS0lwNQKcmFO0lnI?=
 =?us-ascii?Q?nDgASIZCMGOzXH84YFHN/x73GsgshqvsSMKLFloQjlgovaKIoKBB0ei1VdLB?=
 =?us-ascii?Q?I/V+f3w3TSPF/zCpBzuEvps80j6dyExFzhK1t+bOeHR5bkotlShpS5Rx+LB0?=
 =?us-ascii?Q?El0cSwiqjPS4dEzJVyiR3sPp70vVb2vnEOjXASwrZBM33OY8RgMFKJ8YbTbZ?=
 =?us-ascii?Q?NeUPPUYOTuTv0HWcQfcVeoisnAqciSuR4+BFToap8HQWC1tTOOyDvPRbpW9h?=
 =?us-ascii?Q?NtlH0OnqDasD+UZLmDQ33x7NS6jXmtPDY+au4arPLQfp9LKWpMPkjQXIZsIQ?=
 =?us-ascii?Q?MstwGNkJOVOFxg/IHvjp7VaddpPda2eDN7PH1TZE3WAnaDMUN4xFPp19Q0J7?=
 =?us-ascii?Q?gW6eVJusFSS6RU77gdsMHHT6p45y6MPdJfJnwtWKgWO66Bk/SZQnJeyW4aQX?=
 =?us-ascii?Q?i77FeIjCiZ8dQSc94AmYuy4KdwHoZRGvpRzQtgWAlMl6G15BI2IAk1btSsSR?=
 =?us-ascii?Q?HanGgobZ+tu1Txg039WtI1ffpdfjg7AdkRtyanniuOm218ffGNpvLyNLEiXA?=
 =?us-ascii?Q?dqMwArn8ABHiiEdbTpIyeoKodD+4wKblm84FO2LXrhNPRJzYpG+CEEyI8ugB?=
 =?us-ascii?Q?s2bfBbvGpq+8dv3JisRjwMZYv73tN/eqXvBf7xHMKIHW8N6oPoR88KEygloi?=
 =?us-ascii?Q?JA0k059ogk9+g3WZ+Dv3oHBje4MCO9/Xxwrozo3SJoFiBj+LuSI75FhC+NAf?=
 =?us-ascii?Q?kvtq6onHXwnoYlEmn6WYerMm5zyjfGB6+MbD86Wa5rOFevfihyWY+MKY1ia/?=
 =?us-ascii?Q?25D742PwfFmnZrSOwZc59S1bxe1HRTzPDUy69qc3lXeoRqVWKIFR2j/iCoji?=
 =?us-ascii?Q?n4oJGF+Ut7LpcBM/PgOhM052E6ne2mgfpc9KyRBP79BcIZ//hndRBktICyhF?=
 =?us-ascii?Q?hvKWqZH8YEsvBwNwvjK6xJwAXu9BpvxmypvOet2R?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w17p0WF/ioJX7GjFSBt0/IQ+cbzjuYkP1Yduacuan57P1TMUpmaYJqX0UnxG68evVV9fY5pahjlPu59uLv3K1/hLlBYnHMVz216ismuFqWtfMkhKi4TGZSrMl/PV2P8UzwCy/npPLN5GPkYW9mCRVbGwfGFZSss4/3L7ioT8VgHQOY3u4wLpj6mj10k91qDZyOrt+24wY+jabdMDuvYzC/VD4xbNPB5cOSw9/Rt3ljcQuCc7ScEtfEn75K7lSIu8K6h8zhTCuCWW5G4Dqv0JXM2TbFfelGi92nVJNI2L44ktpSaIfTibRr273qqj1ePfS7e9MeqAYq01XuJfkGMIXj/HLX7BXSkwxk6pL49XPc7YGigwpHtPg4fan3A7iTusgpLuDj2NxfS7X+cxKNUEGTLeEb88Xon9+vlFG5Kgb0EDw7SvAee1BGOz1CuEy/ijSict6cuPuPKckcWyoVgR9Z2tXebCioOGD8wPVkBPDnf0WQ4856H5nn0USOKSDvwc02XjI+DAPCaMAerkFs1vJ2rTmldRyCDX+CuXDgfM6zRIm3EcVdcPyEvt1BxGaYL939auwVwdOi+DJAJo5VyR5nh0jT0lBj7/IKEgDtnHawU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ce142c-b5b8-47c9-6dce-08ddd51ed483
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 19:24:14.8653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/gZvzLjcX5SubP4YAUsuKXVkNmNxmTPmoRIjQxwMAHBikQNc17f3OIXkRzrya5fwP4JwKbgFJ5JGWOyBz5eiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508060130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEzMCBTYWx0ZWRfXzfo+uh7cgfln
 F4+08yJ+BgbeHK+6IlxjOZT24hrxczYxJdQZ2ucRzycRioJNhuQybg/lW2GakW7DNEoP86etv8k
 Qflr5hSXi8KeVEmOmGh0CS/KCfBkgK1cMIdqyWFCkC2OVlkzsdWLhumn+vFc6FdBpPyuwOpPb+d
 sL2BM30o5CRwRGdnT0dr8W4hh1bIWWtlLDiOj9/h4sC1y9Kx6qMllP25tojDXBSmhxuQMmf+W4n
 4yjr8Gkui6HIv0yCQgXnJSwNanJ7a+STKQczfsy3NbJVba36hyGzRZSxhnzntOgzPyRdS5PgeT7
 pikXOwXGMW8TN/o622qSM03YxoaMu6GKVZwKV0PLE4GdJFFdGSYMAXCSyOk9EUUs3r3Nzl7Zd8n
 glTUZzlmhbC6Or3VgeZy7PC1XwsjApW4PYFi1+LVIKy9E1PJovfyWPlwPMB4h348szBXqP0A
X-Authority-Analysis: v=2.4 cv=ApPu3P9P c=1 sm=1 tr=0 ts=6893abe5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8
 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=HY7ov4HR9PiwK2o3vIUA:9 a=CjuIK1q_8ugA:10
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: htfCTriQmRdYjp4Vd8bn3-vkhQruVaWf
X-Proofpoint-GUID: htfCTriQmRdYjp4Vd8bn3-vkhQruVaWf

* Alice Ryhl <aliceryhl@google.com> [250726 09:23]:

Alice, Danilo, and others..

Sorry for the delay, I've been off for a few weeks.

I'm just digging my way out of the emails now, so I'll have a look at
this shortly.

Thanks,
Liam

> This will be used in the Tyr driver [1] to allocate from the GPU's VA
> space that is not owned by userspace, but by the kernel, for kernel GPU
> mappings.
> 
> Danilo tells me that in nouveau, the maple tree is used for keeping
> track of "VM regions" on top of GPUVM, and that he will most likely end
> up doing the same in the Rust Nova driver as well.
> 
> These abstractions intentionally do not expose any way to make use of
> external locking. You are required to use the internal spinlock. For
> now, we do not support loads that only utilize rcu for protection.
> 
> This contains some parts taken from Andrew Ballance's RFC [2] from
> April. However, it has also been reworked significantly compared to that
> RFC taking the use-cases in Tyr into account.
> 
> [1]: https://lore.kernel.org/r/20250627-tyr-v1-1-cb5f4c6ced46@collabora.com
> [2]: https://lore.kernel.org/r/20250405060154.1550858-1-andrewjballance@gmail.com
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (3):
>       rust: maple_tree: add MapleTree
>       rust: maple_tree: add MapleTree::lock() and load()
>       rust: maple_tree: add MapleTreeAlloc
> 
>  MAINTAINERS               |   2 +
>  rust/helpers/helpers.c    |   1 +
>  rust/helpers/maple_tree.c |  14 ++
>  rust/kernel/lib.rs        |   1 +
>  rust/kernel/maple_tree.rs | 538 ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 556 insertions(+)
> ---
> base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
> change-id: 20250726-maple-tree-1af0803ac524
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

