Return-Path: <linux-kernel+bounces-749375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE53FB14D88
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09687189F8F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C4928ECC4;
	Tue, 29 Jul 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kXPeWx1W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GroDXPVH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B07230BC9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791423; cv=fail; b=K7kFQLzt+zjmK9KXBcHOPkDSlAzfH/jxpsc8snV74pu6d3iUtxEI4pehs/1Z7MYDirHAUn+7AZ0D6tKajF3CAWjBdkHv+7v5BbrjWq/+A225fN7SDTIffTLNlgs8UuXEIZAW1d++n3/d2q0A36kBf+CBJWa9ujsxZ0fdkwaleyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791423; c=relaxed/simple;
	bh=llruhqAjirWtxx/bXBO8A/h5+dDPzWv9opNs4O8Lujw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dVFOpVWwgjSkDrzzwteT8+EIhclP7JZ0ZbthqR3rgEFiV81B6WtG2wSrVTKhN6KKWNAhfJ2J8FrlV+3QfHwAUK+Csi41YA1kHvcSda0ROBla0u6uS/CYR4ZuCCHTRh7/Pmw3Eo6sbsb7MamGId+8j7f+DEX504psjNfX6E7mgZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kXPeWx1W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GroDXPVH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7g0Ts011039;
	Tue, 29 Jul 2025 12:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Sojv2f5I0DSIVoPsPS
	n8GTvH2vJgNH1Mo62wnj6i3Rc=; b=kXPeWx1WwkxMxOZnPZ6LE7H++lAQJ9CqbY
	ThJby/uouBN2uGzgdcu40pojQAdGxpDwaOBCvjTYCyNpGOwlfgzSwOBo03fg6GAm
	hBLFIviL0KWUGoFv9Xe6QQTTwUA29cL/fqGVm/ZEHzxR/05ZjHJKM1XgpD0yFGFr
	3oD8V32UH3w/A4N8jGsNW6H3KVoD6efn9SBdO1j3i2+HlaIBznjpM9My0fehKA+y
	HlAKpRsSJnF5ungYgwkGly2ToCNdN/kpkoX5QCSZtj9gvAFsf8KsIyggFejHOM/V
	8CwY9qd64a+B1cNPWAiUa0KkDvR793wEXLh9wStzdwPB5mkFwUIw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q72yjq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 12:16:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TBVJnV016723;
	Tue, 29 Jul 2025 12:16:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfg44h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 12:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjphWbT2I04gWoIv5E57AwwLqTjLHmtDkpJYCqD0rW4shKB38JNtQdG7j4HcfqQGyUZWtr03zP1q7glap+HGcPw0JxVNNovEK1wuQ2Bc0SOQJN548/86TkD6FN3At+UfqW1g19ux/VBo1lqgdvstOMcKnf5ev5Q+UXhLgmcohNQ8kwpaa7nHgn2Z1bPXG+4rGxtB+P2/VfQ9eWIF8+ZHs7JO12bmbSHJHj2HXdapOuPj8ZkXFAdcs5PynStJV/6lQ0r34shHKa8ykwJIwp+chB2U3HBHcH4muZWt9w/U5u2/ZuT5eNnVk2JCy91HloqreCt8rWpK2jqTKrt1nmEHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sojv2f5I0DSIVoPsPSn8GTvH2vJgNH1Mo62wnj6i3Rc=;
 b=rpghtkNfiXyJOr+jf+Eodb2Bz2JDRhQP4LR4nX73z3bD4kGqmP97h+MZJin1ZwIDUAXjYW5j288WZsRKR0WyVNqCQpTKJgtHsM9jEYtqA1wYwO1uqDOeNXNThol4J9se6581K/uCC2vU/tE8H4yhJFuxSERi1YDk0zwVOLgRSv4ta42hQX1pQ/bruJ902uJ5VNUWE0bIDKeFHylt0Tj3M+/m618+vGkmygSnIcVxAsHTy8jfF8+N4bv1inUV72ixEierpW0oG3GSEPPB5VMnwEkqa/Ss32r9sTeI1x9iutfSykqywyDuzeAdntaydXewtStB5Q84E7NRg41qICy9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sojv2f5I0DSIVoPsPSn8GTvH2vJgNH1Mo62wnj6i3Rc=;
 b=GroDXPVHgCFjchhyWJ4Ta95lMaC9+2i7twQs8/WXH/v9eZ6jTIjkcIlXVsblREcx9zcUVWR5+3GXbwmNCKqrhTtOier5FCnF1kk1XWN2NXMb2p9r7HmILMHMl5x14Ug/wzwpHAzQ0AATVIt+zlvK2cwHQItBlUMTM6WW0vBQ36Y=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPFF6B8E3753.namprd10.prod.outlook.com (2603:10b6:f:fc00::c59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Tue, 29 Jul
 2025 12:16:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 12:16:43 +0000
Date: Tue, 29 Jul 2025 21:16:35 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm: correct type for vmalloc vm_flags fields
Message-ID: <aIi7o7hjC87H8SLM@hyeyoo>
References: <20250729114906.55347-1-lorenzo.stoakes@oracle.com>
 <aIi6Sok2KmkCaXNn@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIi6Sok2KmkCaXNn@hyeyoo>
X-ClientProxiedBy: SEWP216CA0009.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPFF6B8E3753:EE_
X-MS-Office365-Filtering-Correlation-Id: 950c9901-4639-410c-8783-08ddce99c771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/8LzbmmNLL9GnGNrDXiRg7PaRZAS9+BVekWTz/kJcc7qTIyB2/+8opaoJ+jm?=
 =?us-ascii?Q?Q7Dew0BeXrI/JwIgNUbuIZdiIq63kY3SKJWifzb9T2j62n1bFBF6nxb9bAfW?=
 =?us-ascii?Q?yN8w6dVqhDyTRQOoPZxUZZPU4ZPAMEi5qlqbXdm5yClFUdWFalkrECTdxrDw?=
 =?us-ascii?Q?Uiqz0fcPHn69BRB6nQ8cXkGvv5IQcEJpylvAADgiIjIlpEo53y/0FP/r7U+V?=
 =?us-ascii?Q?WcJWbIVH3pzqqsbFsWGGB52NeLwQcvr5pzzbOOHjCDYaGH+tDdm9aiP6/YkG?=
 =?us-ascii?Q?7yCqKyruXvBUEKLBOCOmNLMYo0iQhsqVRP22VVtJQbeqC5Ij8fl5GziQRzUi?=
 =?us-ascii?Q?hRcL3h1rRbhfJzT5kQlXLW5qLltkaIy71vDpllGpkU6pHIBvm4rbVgbRdki1?=
 =?us-ascii?Q?n6lS3UVSt+zw2YMhutVKWk7Y5ZG6yM8sjuGq3h1EDY3RWTGThZij5mZHLiug?=
 =?us-ascii?Q?Znk5Yx9pjp6XtFGVajtFP+h09HxzGAQvNSt2p2YIe9dbyS75i7pWWI7krXsf?=
 =?us-ascii?Q?8O2q5BkCR59g+LrvWdOHGYmLafQVGcY/On6krntbGVYpsX8HsPqsAnhgHJBB?=
 =?us-ascii?Q?C46c8ksOwiujx6el6v/hOfIdOlSF7jEENtoUZhtxfZtEGCJX+BvNWFk2+5Sy?=
 =?us-ascii?Q?4TSHFR4g/hWDYVkyTq4kb4Dtn/apz0a01c2lWCHVZc+yWeywJs1hc44mFQll?=
 =?us-ascii?Q?6GQPYvFoifzcmhHBKBF5YAFaIl2buro7bxD5wwZCUhnLDeATOqIlAAmFOBLs?=
 =?us-ascii?Q?aoIeMi1+1MBvJWAC5nkBWRIZs9QCM/IbBswZ4zEtEUO3e2WYEFcXwD1ORXIv?=
 =?us-ascii?Q?NGbrOURyM4hvvuuel3wMA0ukak/s3kQ9U290Mpr90VmMVlzIyhcXggyXC9Yf?=
 =?us-ascii?Q?VoXUf4ll8KgM5mIu185h6/OskDCrkSF9OaaWBKH4DgkpiTAlnGsNDB3RGIkm?=
 =?us-ascii?Q?E4e/guVKvYy2KeFqPE9xRk90ZN/JcfwXjZ0K4BXofSsyZY3itRS0kHz0aYv7?=
 =?us-ascii?Q?NtkdSwELpXCJjYwrigev/Vuv74t3RTo+2OI696ne+oHCy8MUS7HiXXRTNCZR?=
 =?us-ascii?Q?n2P9EP5p911qAME/5gaYySB5KLBjFX5388p1gKRGgNUFi2qAnV0cOU41i+ii?=
 =?us-ascii?Q?Fpf9OOw8vdjA3LAe34ohC6xBCEMpOtfPDQ13lxWS9oWZEMR3IQi6nfw7w3sA?=
 =?us-ascii?Q?Le9AWmRpR2AYBDdswh/IyB/gd84h4ynZnbLbyT3O0flWyKfg7154tKz2L+7K?=
 =?us-ascii?Q?R2+8To6do+Jz6886wyLkzQilfzZuL/qRCM4CBnBEiSjBEq+Lc/WG/DaL69fO?=
 =?us-ascii?Q?Mz7xEbeFBEnBUMmTrhsem3boWZJXVVCOh1mO+AFvUr9tpYw2diY51JjJsic8?=
 =?us-ascii?Q?MOBcpOWyp/G8Otvu+ZCM/UNNd1woiQAxOXKoetWksL/eGJcC11yGWwe/jTBU?=
 =?us-ascii?Q?asAglB9glVo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lcRCTQ87eRHvMsqPaZJWv+Fuui7CGL5wZWmVZAPJ412s5XFZdFLES0M1H3MC?=
 =?us-ascii?Q?sQYRWMuxfCtC+2TxAo70cS8YU9Ev6XFBpjBG/BaSh0xDvVvpi1X7l8a+I6P0?=
 =?us-ascii?Q?2SnuPRsZATyITOsMaCoTB7UDiebAqyT1Ec7vHFdGVT1vKclUwX/zoPc6gPgL?=
 =?us-ascii?Q?J+2mxIDZlK0fAstgM9oXz/YlBNWPvBU2GVIa1KAb/kq/0ZtK+xSJ59Yea/Fx?=
 =?us-ascii?Q?3Zx2eWlAXMyG1FOBEZxbXMsuL4fdCheFPxgNdxS8GYSW5SLIsRFUN7+FbMjR?=
 =?us-ascii?Q?bKu0+h/0fJCZyPpPQHCI/ZtcY7GmAKczKojYtA3ltSkeKHL8p8CVxLlAi4OY?=
 =?us-ascii?Q?wTL4bQxY2Vih0OFCi4yOfNbHbkBJa7fQNNTbS6JNd9pI+N6j1QJoyfxAX1qo?=
 =?us-ascii?Q?aaVawkYqMc4SUiu55GWo2lVkMaQt1igIXK1w7lJT6W6V0sN6cn25fyrwMt/d?=
 =?us-ascii?Q?Y6M13axE8EZmQC6EgkiUNo44/xvlrJmGx5YZ3JpRWutl7OYDmo7QmmPVOUEi?=
 =?us-ascii?Q?MmxoZe6PtrCDKWdM1zdFW1LDHIfKwB7rlTAq3F+3yV8jIoHTyEpmMPAyYWpI?=
 =?us-ascii?Q?RY5/nklF1mWDlB3VUIkyw+hRUcvx8XGcJFJo4h4lQRVFCxnHtTqw3EQBqrR7?=
 =?us-ascii?Q?+//D19yeWCLFPIFgF9p+Qplpm1cWGuwCrHvzXkggu2fwUF1g8aEgJj4vzvm/?=
 =?us-ascii?Q?tW3zRBDxvitvpJeeY5EZ6DjQjjoFV+aIE/+5uPregHl84i771vXtFtxAvQg4?=
 =?us-ascii?Q?4PpZSpf37h/ztRleEMNZEvh2qGqt0rpTH6p0P9O4bWCBIwVX8MW9XgFjBUu6?=
 =?us-ascii?Q?JCsuzkH1uqIWgC0ehOcpMURg9VpQmFu1zzsa4V43aW+ZEcs6ea6mKfG4+47y?=
 =?us-ascii?Q?55qOKg0uDSQX0qRylwz1m+imbUz6OMVPJzHYs/F80Ly7XqK53UzLr1Su55/e?=
 =?us-ascii?Q?TOVuGbGLeBgQ0AdiNx4v8cxzXXy80n42s6pbkNsXSBmfpQMm04Mw7sMH7KSh?=
 =?us-ascii?Q?eEST26MGPSB5vuMEYkukawFO1XSq07kwn4aKJhTfNIZtCVF/pRJmxwZ5bnAf?=
 =?us-ascii?Q?/okclMecYC26wuw1xNY+qmXb0NNXuRl0mgunN+THCr97wQes0roVNgjVeTKi?=
 =?us-ascii?Q?AH9LcjYzzyb8zIBaS8Xs1z0iTJdTZaMHRKaLdQb/H/marWatqD/Flo2kMa0e?=
 =?us-ascii?Q?wEAHol86L3s3/2Cl7cBrFscEs3TO1ZiLmxY9Qh6VqrKARxelUFxUM4G9g2gZ?=
 =?us-ascii?Q?TzwEUcr9yi08vbxeCCXsHSgp/qkfur5eX9X+BvXMKWo597zA1pHXdu2Qcg38?=
 =?us-ascii?Q?30CFzVmBebc4zhJYAebG7y1SR3RjJABViGeGWD8/K66MWiaVVj/xQuDdKcP6?=
 =?us-ascii?Q?w2DLQoXo0ej13VTbhw435zdt/dPdwV4c3azxG9ssdEigkvPcwriQQ4GL4Kna?=
 =?us-ascii?Q?p8QGp19HJiiyze6NXEHTv4lnkH2F7hK85wGU8n9x0yf102n6uJeRKiZw25uN?=
 =?us-ascii?Q?PMTBsSgTwB1Qs5IwUjV5UfNFF0gkm0/tIHFY7y+iVG6rgMgyOsxynUUn1PyY?=
 =?us-ascii?Q?m+GcHZrQ5JIyT08intmHqVsHnM4wKh94t/xQ+w8e?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J6pg85gNNuUv0mfC3Xb9jQNOQIoP83tQ52MQQwTqK34nsf5/qjkK7CX+bX/2BbsImw6/A1FoHTUTLlccUnHAvFyxWGu4HuxY+7d/+FmY4T4/bQauVxMTEB8e/KWtjoX19Gs8/Y0IQcS8Zdvs52kVtmXT50xfAEJknpaZ+R3r77UB+7nAsqC8JVpYROlc9SuBPeKJV8j7U1QfZ2yKIJ1hCh6iHr4p0fa+f4M4WsFRzAFCmV8k5AOQZqIw/XnrMpR+QS05yOv9fb0If9j7FrmmE+PI7hftJTH1HuqOVey7V0PdRkw+hBfol+38h1/e+E+1r0onHMtMexY5q0KsrEwySYevVPOp/cWyi8PZi1u0/uJiVnbryBqERhyfg8mJZu/CBRqAn0fDTnNmoavTO9zMYuf+VNvnzNlisVcOrg3sLkk6uFMiKF5vBFoVcY1LNoZb+YzGsdPEI5fPq9Wan4bO5g42CTSoa0dFnjn5UPv7PkALD1Z+kYjIVD8IWYL0ABvXE+HgdQxCp0ZIARbQuCXERK4K5tqeIQdxeBgYnx+sf+0o/+rgRvFBkpPnIcrxFt7rE11FMeSACU+EOif2n2ledNS9SFLEE+RXP78wPlcdQIc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950c9901-4639-410c-8783-08ddce99c771
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 12:16:43.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: je24T6zKeCqLZflZMNtgnXYxKCEkv6o9ESLabXfidyGMWvX5WC9Edz0X9G0sS+kkjW7ya2FJVrkURcCFPlI89Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF6B8E3753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290095
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA5NiBTYWx0ZWRfX4U3xM4+bBxJs
 mcY+ulnrFC8WnnXhDtGyUOp1Z0ZWzgkPsLxSrAOGvoGY8VEr8KY8QGfqrVKHChZPQvHn5BXwW1T
 cWVYtY+emKb8t/A6tVto9vrLdYwOAD8vKPyrn1ZkUs8KrJLq6OrLOGhw82bNajymTG0QwW4sZv4
 L6DYFuUd6lbE9rp8BUhSJgT9/m9hpJjO482XORvANLhcv0ufsLRYrSGkClKyh5/CMNY6mBPmeZk
 h09/CiNukxe0/XFDFSpMdn2bBQQZVTFAGBgIzBVX8tV53d+Uo2YcTiJCFZah+Ak8SByZDNZnlPp
 Nbr+o4fLSkn6kCZSQJy0EAAYTRlsGVpUuLcMtZJmcvfjEETnch++8XACzg20o/AJmdaqmy3ztC/
 k7nGPQy0OmGjattAiHMalHtL0NqjJ7qk6gduZZ7dQJqdNvWbTI7i2jKeOS1F9PXXsWG9Cay9
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=6888bbae b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=MI3zwZtf8Q0nbIKdKNAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: E3A7R9h9p8UUfFHhW87kUzrZkVEErUUX
X-Proofpoint-ORIG-GUID: E3A7R9h9p8UUfFHhW87kUzrZkVEErUUX

On Tue, Jul 29, 2025 at 09:10:50PM +0900, Harry Yoo wrote:
> On Tue, Jul 29, 2025 at 12:49:06PM +0100, Lorenzo Stoakes wrote:
> > Several functions refer to the unfortunately named 'vm_flags' field when
> > referencing vmalloc flags, which happens to be the precise same name used
> > for VMA flags.
> > 
> > As a result these were erroneously changed to use the vm_flags_t type
> > (which currently is a typedef equivalent to unsigned long).
> > 
> > Currently this has no impact, but in future when vm_flags_t changes this
> > will result in issues, so change the type to unsigned long to account for
> > this.
> > 
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reported-by: Harry Yoo <harry.yoo@oracle.com>
> > Closes: https://lore.kernel.org/all/aIgSpAnU8EaIcqd9@hyeyoo/
> > ---
> 
> I see one more thing in patch 3 of the series:
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8fcf59ba39db..248d96349fd0 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -720,7 +720,7 @@ void mark_rodata_ro(void)
> 
>  static void __init declare_vma(struct vm_struct *vma,
>  			       void *va_start, void *va_end,
> -			       unsigned long vm_flags)
> +			       vm_flags_t vm_flags)
>  {
>  	phys_addr_t pa_start = __pa_symbol(va_start);
>  	unsigned long size = va_end - va_start;
> 
> 
> With that, all looks good.

I mean, the hunk above is from patch 3 and it should be reverted too.

> "struct vm_struct *vma" makes it even more confusing by the way...
> 
> -- 
> Cheers,
> Harry / Hyeonggon
> 
> >  mm/execmem.c  | 8 ++++----
> >  mm/internal.h | 2 +-
> >  mm/nommu.c    | 2 +-
> >  3 files changed, 6 insertions(+), 6 deletions(-)

