Return-Path: <linux-kernel+bounces-789215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DB5B3924E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211CD207491
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941FC263C8E;
	Thu, 28 Aug 2025 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c6b2I8x6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y+U2sZDp"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A3248896
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756352636; cv=fail; b=Rd6xM3/famSF0abYnVyungG3eoOPihHWi4FyIIyWz0GPDd/xTVAkCL1v2dU2UG0gbegi4OEo9a2w77WYUPQyZfAUobAkxnnl9BiaS8zlclazHSQ3FAI7CwngpBUtWCQBqhhJb0Ju44dDepxyR6JTyXKDHZBtyh6HaQOJSsPIYhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756352636; c=relaxed/simple;
	bh=DGDA7kzL6RfmMhnk0aU/FGk7LFSY8aOIXd/2kVBWm1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HhidgbenpRa7/f7FyajiRFCrp7Q9bwwrW744u2UWLi11oqby9eGzNdNtbLQ/zPkFYb9ZaD+TNhWOQ7iUmMW2RsqrJVtO3SZCqbINNbcuenVh4lYWJrYpZi0/Ooz7Sk3xmyw6huvCdtkHDdRvhw0LZhLFp55Z2wsE2H9ocU+rG8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c6b2I8x6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y+U2sZDp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLH5uB015341;
	Thu, 28 Aug 2025 03:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=u86Fe2hPEseHh4yjyn
	Opf3SX9zFcIDgwPFVvh/9Brts=; b=c6b2I8x6qSixoKsYHCJdiM7V306RSGpZM4
	YJFISra28KnHmuBp7daEJsi2FIcjfWaPMm0ggB3akxtZagISs2u5gs/IlIYw83TI
	RjSPZtg4QxhojYdxMrVTToENNaoANdMmdYSVY+79ubfA2V5QznIhG2fgY0/UtpNi
	fWt5ysdzNtyU59LeMurzHQmNVIbu96YRhGerziUuj/HqsmTgTvFA04UuDpNoQXVj
	CsJbB+lrQAs7BZDzYWVzFe1O/0p6h7D+oVctMliIV0KPHfnqKSybPXEm3tHHR5Im
	iFL3AeIQ/Emh06CyNz6AWzFTiR/xVtJeuYXbk2kkMqaztcDOkm2g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e27sa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 03:43:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57S2UCsj005337;
	Thu, 28 Aug 2025 03:43:44 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8bmcbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 03:43:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyHe7gDu9BL7v8UYigLGdSIUkGZrlM7+9ZTHQy+jPOg4BvCfeowlWv+5oOksTVF03HsCCSRQLmfktlfbylEiVZPUeZEvO6+aHfk8RKo+Ow+ekPe/ElHyYOOZXQAAV2CDXfeZ49VcM0KDL2XNtCZPZ+0Q0j0laaLhltxWmQEg92I5ZMQY6L+gu4JmDX+yM4LXnN2sBxPnSsv4cCNmLsRzk+si04HgmPN9m6bRoGPaQsF9yuQBqO8KWsdkjZv45QVEHSyEfWMSyerAdUuU+6lpLYjGCGJ78a4pKAoxz0KIzgH6vBThlWygdUNK2/e3pW47e7uknkusVvc3eVAzV7O/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u86Fe2hPEseHh4yjynOpf3SX9zFcIDgwPFVvh/9Brts=;
 b=a22V3CuxXi5ils+It1c6aFFyn4d33QK2JAHftPNhgSpF+XC/hk8gODCNH2+2udcnfzitj9Rq7z5d84ldHG78bDt0YRN1gKjWls8OaPH01h9c0SYLAMcEvgYiipVIcZtYazGbs+yCyhuyQMJx3vOVQ+GLFqgnZT3EL976WYBNVw3eUUH0lJfvUiYgeHO/1zRaH8JGd3pdH5cjiYzbUgZ29gM1c0jS4WHYq0x4QYiWkeaVVakGNgTm3YJ5K8FGweZYinRAZ4K5C2Ie5rKiBH1VpjYDl9SV3yyArl2h5wbA8DYw2u+RdzwYcDmkq0sKv9MIF8Uzat3Y+xzB4Gu3cepUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u86Fe2hPEseHh4yjynOpf3SX9zFcIDgwPFVvh/9Brts=;
 b=y+U2sZDp2zV1Il1PLTaBUSnPylUFMKNdRkL90uzjBcE0q8pyXjuZgEiO4oaSfxw4TxwoBLRgWNtCqILQZzHMvoMLk9/BsrW6+z8s8HsoVl2dvOSjWXZXEOjWzDym0NXubNbxaG3bMOYiQbIQoILKtfn5g/cnP5iJhUyFmNwzbdc=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 03:43:42 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 03:43:42 +0000
Date: Wed, 27 Aug 2025 23:43:39 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        "open list:MEMORY MAPPING" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/mremap: fix regression in vrm->new_addr check
Message-ID: <xpxoxn25fzhahdyvjp2vgmcnek6oot2hhvb5niz3tw7au46eno@cixyid6ywf27>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Carlos Llamas <cmllamas@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	"open list:MEMORY MAPPING" <linux-mm@kvack.org>
References: <20250828032653.521314-1-cmllamas@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828032653.521314-1-cmllamas@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a87d5b2-f6cb-4b94-c53b-08dde5e51507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TMtJmj5dxZkflpnjCCdV4d7r+cxP13GL+E1QwZhDmhiFpaYQMwy9eZ7OEsvH?=
 =?us-ascii?Q?D1pivdTewNc6NJn2rq6/aTLhHoe77Ynq6NpdsTPARMBq6FPSH6PJzoqYCs+U?=
 =?us-ascii?Q?Dbu2KZ3lNlSQo3mCURi0ILpvfLHpy7H24WyfK53ITz89cwMpFsOwzMFhQURx?=
 =?us-ascii?Q?VKKoSugox1qCR9cTNPti4w0seiGnz9bM7DMEyqXqgUW7IZ7H1X76XL/V5Cyw?=
 =?us-ascii?Q?mifotS7kGT4xxE/3k+TjHPsy8tz4zXRj8jsblzUTdbbLWPLMMH2ZzMcWvSsP?=
 =?us-ascii?Q?dnmCnwwEsFOaOwNcIM9nkvHtsxBl/QWX4+2BoLxRizcwz/uLfjeVBtfqjZoU?=
 =?us-ascii?Q?rIXtKfKr8pnoAJacnyHHNcI+3jD5OXNkF+T6N1UieHgtN1uXMBmP+YslWSIf?=
 =?us-ascii?Q?unsS30IReKnQF4RF/PVkdm9+kSHchKo4ADaN85Ht17aAKNx0I4TJMJORY/vz?=
 =?us-ascii?Q?BsQWdGBCktPR7l8uWCwCZCHcWWGPshs1X699XiMmM7s4EKX+/GHKj+1VDNXy?=
 =?us-ascii?Q?pcWUyvJAn3sIVY11SoXPSt6Ym/Gcyyrgjob9iMhijAAjso4VY2xphVLREN/+?=
 =?us-ascii?Q?kthW7AW75JmXY0S2dBB3/bX/x6E6YCCk0E30dXAlWWqGE1SzGW1/HR5XE+Ge?=
 =?us-ascii?Q?IzNCcJ3lTXTR07ilUAY8Ky6FBVu1iGMO0tJQB9kdvjdW4e4bBiEwRGtT2SYY?=
 =?us-ascii?Q?CS4io+q4W/587+RcUJeWVrobLd9bhYByuKNpJxSdU3WOqQKs0WtuM/law2ch?=
 =?us-ascii?Q?nbMf5dloMongMBppNyeZBTgbmLRysAvM2ic+lDcf8xRdgv75x5F+IuXADuR/?=
 =?us-ascii?Q?loSQdP6xS0lNddtzSnqaAVgOtaqME2+9aPNJ+E9LDKgnF3llc4Y0Q7t2Wpap?=
 =?us-ascii?Q?gwLHXm0yybhS0+hmOwKYz3CRErBnO6bYpa77TDVjgqnxNPMdYVatBxDAnVqL?=
 =?us-ascii?Q?UhHfAuxtMuQOAOlDdsIjzhTHXVx/1kU4hEn97/NTVdCnhrrJo0Jb8bbMX1JO?=
 =?us-ascii?Q?IMpGWTExWijesjf5OSk17QOjQ6qBN7LLLt4TYGB+/XPZ1aTlnfEjWbefhyk2?=
 =?us-ascii?Q?GOuIzvyl9vNxlI/o2bu7WPfe766FDvVd8ackPn0ezzAbs0LnywHijJwDc/ol?=
 =?us-ascii?Q?4/xCpEuzk4Bxa6GCHr5v2kXeZgaC1IOJ4otv7j6j14UVKpXM69suJuxVCIpN?=
 =?us-ascii?Q?UoVdlmXdvMyEe9Bhrs05uQ9tW9kcfWHfDj8v44HZhOs1h5hEo0nU8YUeIEty?=
 =?us-ascii?Q?W70KjvjbdhrQcH54ZBIy+axV1Q2c7B2VecLDTasAgIh9+uuX0Nb+xZSJWkmm?=
 =?us-ascii?Q?v7l+i1e7j/+qLH7xxdbiNWnkUhe5e5SyEkrbce+OzEZAq4nm01hdUZCpjHdX?=
 =?us-ascii?Q?+7P1VvnjgRMGwXz1kFlts9eHsPhx/lQoG8ka1A1/SIoq0j8g7NCox1vkOnZC?=
 =?us-ascii?Q?LtC+mP5QCXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F2xlfVYoQjp2tUhdPR2B9IzaK3VpAEJzyi6flXMZmAmiIMskym1YylG0vM2R?=
 =?us-ascii?Q?qpxUZN0XE5YJzOxtCKPUQShztjMYiLjdpmM5OGtYaFF9ioK/c/OQ2YK5qe8j?=
 =?us-ascii?Q?j9CSJiov9LgaqcJM2cnPjbQNV7u3WEPjmiAFihNM5TVrf49sSPUhleLep/tZ?=
 =?us-ascii?Q?fhjXXYsMXy+VDx+c4LVdnUD1ucwkc2PxYDLeKFIcZpjuU0XkM7vcBa5lf/Ne?=
 =?us-ascii?Q?R8UfCBtyOA9lPPycdwx4zDbdmFtfYc3Davdklve/M0+YxN0/x5klLm6QNWCt?=
 =?us-ascii?Q?2aKFT9j7mPqYoiBIqyurdh653u7QXo4nPz/2EZZta+Cj3tnOOl7VM6nDDUMp?=
 =?us-ascii?Q?2mILUZismwZLK0Fzr5KfMwRaLFuIG9IdZ7Ls3Og9rh3sDKDb3Wp8CrP5OLzS?=
 =?us-ascii?Q?vQXlRcOVVaJwj0Ui48I9lB88bYinyu2MC156REgMVB+aSmKJ4Pp2dfr/ApPU?=
 =?us-ascii?Q?Jh+rWPCsArelvQwb2vijg8FE6IxvNXW/UFFLoSiznAYZq04mMmFQvMop/RwJ?=
 =?us-ascii?Q?RQAOps9mijhDsWH/VD2HhJvufhDM8oCO3Q0MZRiPEKzaEH9j0p8d9jKCqwCv?=
 =?us-ascii?Q?nzE7nm0fj5nkvMHgy/8GGSglbQO5/RwYqhXmyeMosIC09+B9EXnFOjdaF5KK?=
 =?us-ascii?Q?JDADuEIe8fhBVf3GtHb3jiN+dsj1A/jLGBqqPSS+yVjW3cvOdymQ8JQv03wU?=
 =?us-ascii?Q?24y3TTr10OgDvmYPzqHtxRrsEOm0+bOZYEG63CqpNqkY3txo+Ra2CmE43awb?=
 =?us-ascii?Q?rYqvR4L2WML6ISngfVyygi+2uVpHl6OoQtgtG5VDO4daVKT+UKu2Ly1n/N9L?=
 =?us-ascii?Q?c9INqxostcFxXpHYxHp2fKgn+2mqUVBHDvoRh2RBR9R4OEAIgLNQCF3LdNRY?=
 =?us-ascii?Q?fqle6RQHnc3Uf70jnUvfpE5zvWAAoJ0E/UQqd+RzNRIZDFlV5hgncNpyj2HI?=
 =?us-ascii?Q?YsY/iNa502B7NAHTcc4BVjbjUBKk1RDRPlU1brlmOhckQsUSy3tongmoa3Fe?=
 =?us-ascii?Q?dRcSKKF1wpz47z7zDG9P1VfExLKGkNHHvhdd+XbvOb+6bRPUV061vnvTQYUt?=
 =?us-ascii?Q?mEP4iBOoWTEeBjJ3ICwS3q6FapImK08GDoZn5jdu/X7Yg6JQbl/MMbl2Yp6H?=
 =?us-ascii?Q?bPFgz9qJluZfWujhpBYnRCBWJ5q2y10/3Y/qnamPagYn++1MiIHqjEtFEMFB?=
 =?us-ascii?Q?1HSShsuRJXZapNAUVBLni32uLwn2vlcZaLJoe1T8Zp2ROFD+FsHYYU9Emzvn?=
 =?us-ascii?Q?eib3yXInoFxcIY0CG8JTW3TF8jI2vFQd7ThHoGuzXogjuTswycfjvfn9g/OX?=
 =?us-ascii?Q?NV+8L0eKm1I/Jn3Y5M4w6ed2rrq0R9Xr5ghILAXLS1cu7DGVz/r2W9dlFJWr?=
 =?us-ascii?Q?9xCsq/rWA/F/f+JH0e2PuXT+f0FGpuLNorJ7Idskh0tTbBylCDd8z3YWW3AC?=
 =?us-ascii?Q?/VuwxztGne7PcGancwfuyNQ8i5ehYmvL9d0hcjQn/bnZSak2gTXwAsgYy2vJ?=
 =?us-ascii?Q?DarSIJ+4thQ+WM88iMPXm/JUeI+XXZGgu9iRzeg52+TIYWdcMQMVhb7P/MEm?=
 =?us-ascii?Q?jDXN/hFapfpOYdUZr88vBU632zaPV1G4TiJxrZHKcSs71WCURMkuiKdREDtC?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wd3TCqCgEGcckV2fR2xQpU/Y91LczxVijTUEUr3mnMn4k91JixGNEdam8S9/Ee1KDMbkqUb3xgxRNaTcBpqq3/k9v9o/JN9/ML5cvxgjGTz4NVbSElBJe/Y5L3oPc4J6lSooQwFsFXKbeuzhktWj0ppLb6MlIoZzEdxAT7jNREZJCiIjYbRTvMMYLL8y99oaIErVccQTKRe97NVGAIMEGizKLTb7XxKd0R1oam6jfqOgmNN5vYfiEYM44pyAuI7smikAshpNUAf+/0Zb9M2Bf5ETxEXrAXUeCfeVUNRsFjZTaW0S4Cq2ER0IxN88xGrgyro1GK2zlaEakC6D2yFwYbaTAqQA3zODznPm4D+iK7J5BADNj5rInsKVjLxerT0Z0HmAL16PknTGDLg00yEUsQKUsMkNkrzgLYA5fP2vIPG8yet5e/nMcIy9CwvvrpVNnW4RdtZKEpixZLa6ibYoaiEyyfkY+OFHyI5E9JuCkFd/5jbDaZ5CF/nRg3nu61PYWTsK9CgKs0zf487OEfPfX9oAmwBV/pVV7fFJqH+Z5+j3x+XhnlgXWil/iEe1UUT50MvoSDx5x4K7e2zabw6oRHhne+4d/RpGAc1sZKvCcvM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a87d5b2-f6cb-4b94-c53b-08dde5e51507
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 03:43:42.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIw1HWAlvsxhsLPAlCeBN88QIrIUTE8rzXmnvtlni0L9KstAyd1g6HzfQyNKJUbittGujOheALrxc+xJvbAnuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280028
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX9U9XTCyiQJmm
 2T2pd8/q3m4pw+rUe9+4oMK8KyVzGCx9YWYduGAV+YiCS0SbKE1y75+Wd68KxepgWiJJ2Xo//IS
 7L4ys45pAEwOFKiLw3NyFIvQhvY2IYPkrK9cen03ZECjrmM/WiPBBwShxOZCG1daD11tlw9WZnc
 vQH1GcmPqvlN0LQ1hkxeA4BBSOm6gAs7dIXMJ7LkUpSXJ4eQ+uioPYHKCnFsI6DNVAjnoc5YODe
 vcyJY5FvtdNM/RwmU9AMOjniuLcDrooJ1rSfB++2q4sjdfmpkPK8SHLWLdX8vMjAv5QFLdoSgCF
 zJJp9LVXSrQQ5zlQh176eZKEl0fIoQ4+jYGp/rZ9cQFDivFFc2YCf0ieUYeUq6q3E7orKkzlg0R
 dd6BQx1NnWbiVsirmcIVmC+7lfDIUg==
X-Proofpoint-ORIG-GUID: hZixtTP-bxUxks5JwK7dL1CrVs-TzRaA
X-Proofpoint-GUID: hZixtTP-bxUxks5JwK7dL1CrVs-TzRaA
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68afd071 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=fXXt281fCQGETp4qtdwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068

* Carlos Llamas <cmllamas@google.com> [250827 23:27]:
> Commit 3215eaceca87 ("mm/mremap: refactor initial parameter sanity
> checks") moved the sanity check for vrm->new_addr from mremap_to() to
> check_mremap_params().
> 
> However, this caused a regression as vrm->new_addr is now checked even
> when MREMAP_FIXED and MREMAP_DONTUNMAP flags are not specified. In this
> case, vrm->new_addr can be garbage and create unexpected failures.
> 
> Fix this by moving the new_addr check after the vrm_implies_new_addr()
> guard. This ensures that the new_addr is only checked when the user has
> specified one explicitly.
> 
> Fixes: 3215eaceca87 ("mm/mremap: refactor initial parameter sanity checks")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

I assume this showed up with clang?

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mremap.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e618a706aff5..692acb0f9ea2 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1771,18 +1771,17 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
>  	 * for DOS-emu "duplicate shm area" thing. But
>  	 * a zero new-len is nonsensical.
>  	 */
> -	if (!vrm->new_len)
> -		return -EINVAL;
> -
> -	/* Is the new length or address silly? */
> -	if (vrm->new_len > TASK_SIZE ||
> -	    vrm->new_addr > TASK_SIZE - vrm->new_len)
> +	if (!vrm->new_len || vrm->new_len > TASK_SIZE)
>  		return -EINVAL;
>  
>  	/* Remainder of checks are for cases with specific new_addr. */
>  	if (!vrm_implies_new_addr(vrm))
>  		return 0;
>  
> +	/* Is the new address silly? */
> +	if (vrm->new_addr > TASK_SIZE - vrm->new_len)
> +		return -EINVAL;
> +
>  	/* The new address must be page-aligned. */
>  	if (offset_in_page(vrm->new_addr))
>  		return -EINVAL;
> -- 
> 2.51.0.268.g9569e192d0-goog
> 

