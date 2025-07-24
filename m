Return-Path: <linux-kernel+bounces-744126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96252B10841
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66ED3189E35F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDE026A1BB;
	Thu, 24 Jul 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UAFCenet";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XqamrD5w"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8126A0DD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354590; cv=fail; b=YdcPrqnrVuyM0/3bIbRGTZ4oN28BGpyHFINeopIQNH7Io3KaYoslSRF9yff1xMMLve3plcs4BhYlLEFFo6b/TEFQbK4uW5+gLjE8v92L7igTg18ofEf9JSEK+RfuUg7T4Lmn5S8Pp4Sel/P06QH/tJ8JkdjHVux823zhypuvq2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354590; c=relaxed/simple;
	bh=fY75tMV4KKfwk5187Lz1vDLQt+tEMmzPgqG+ax7RMO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h8P73E6kRYxcIMclTwzorG9gVR5plXS4GuXCNNQnHC/HQUMT68dWJpDCnZ90oyeXa/+cj3ip0unFU1jet4CooHfC0O1cVHHNHZoc4VQLWp1tZsHz8HCu9BkrINoeQkGg4Xw/crIxZbcs40IA/mttq6QZJ4w/bIzwW3POK0x4vP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UAFCenet; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XqamrD5w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6trLB002709;
	Thu, 24 Jul 2025 10:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fY75tMV4KKfwk5187L
	z1vDLQt+tEMmzPgqG+ax7RMO8=; b=UAFCenetSPCZRB7pmBFofErwdUj4GfJhI+
	B7DlDZB77qWw6/w9oBERa+fda3oxU8Ca2oZfeXv27zQdAr3J6eILWVfK03lmrQCC
	8xyAlkiI7oOWHWI07tMyCGGE9fDkOOP420u9WWMIpoXzQfO1eT41kl7JGIA7U/3U
	v6JZNYrnPm1yC5h00VdwnbW3o3u1ZEOUI7vrWGPkVcTTwOpZyg78WUFXVRFyKLKO
	PnUhtzDqEh3/Jc8vpGNGts8uW58aSOi/5TxdcSz70y4QlbktJzT45ZtAZzT83N4m
	/jnj3l1TfyJcbKcy38s9UPiWPpOMuEzMrbQxWWv0WeRQnr6nUHBA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057r1g8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 10:56:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9ibXe011342;
	Thu, 24 Jul 2025 10:56:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tbp1u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 10:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqMSVyvpDAHlByuHqhXDxGSOyXCt+kx+UwkFyL7mlqG0XMMDJDdAm9jUjGBI60oRhiWzX0ZGSAQCXLAgN34bDA+K3aTHICN6huKeuB8636FkFodiMk5/yidWz0KIQbyNQum5u/B6BnGJxn1GMAt+wW/zqsJqPiwkvvVNur1b53yhInkXGj3Ss/YLgIwWSbVV5sRrBeBESXvh1HpCn6uLgKZfcc1RVXThHZzUto79G5GfZmZzOqPOT6quf8BRe92uuygVjNk6QOcGj9SuEmwWWW4YYDEC9MquoRuiB1hHz7mpvA5ZcCfj7p47xOGimFWYH3ycXFA2RKM2mMehLFfb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY75tMV4KKfwk5187Lz1vDLQt+tEMmzPgqG+ax7RMO8=;
 b=VWnJ2v0/MhVqYHxT46jRdjIMaLVboqxOoovp893kmQafKczi9VATrPk71Bv9o1wvencsMMX8txKsKOY6zs7Xn/lWWNN7dzo4fSfSXc0wPJvi2OgqctV0hJs2zC5K1adE+ViLCd0HM24cj/5WALaKBgt/Z6spwOpKu2OoupAPJ10vtFAW69liQ8xxW+GQXZzopIlD8QQk/f2nopHHDriUKtZPEz1Zb/Li+d1xWDArguZh+vDwUCmJE69Y9a3Ryh5FzJ3Zg3XycYCVWt+LZYwAjhx69oVStbFs+CV34809Ju/fGzwetmC8odEMG2bwJkVpuLyKFVezZFgU2puR4N9eXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY75tMV4KKfwk5187Lz1vDLQt+tEMmzPgqG+ax7RMO8=;
 b=XqamrD5wpAh1ELd53UFX8KMoLBQ6tkDGi3f0DN4JbOWnXME5TZ60cQId/CT80BCZToz58thKB1sUkejOZ1Ve0I+Z5ju9mfGyiPhQtLxJAuRjEwmkDQNlvDa/cQvrLQDGEYe6FLzbuM4GsVEUQW5LX+7wrz450jEt4w6sok5I/8E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6278.namprd10.prod.outlook.com (2603:10b6:8:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.29; Thu, 24 Jul 2025 10:56:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 10:56:11 +0000
Date: Thu, 24 Jul 2025 11:56:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v1] mm/gup: remove (VM_)BUG_ONs
Message-ID: <55fdc47f-5a14-43d4-814b-7defd1101050@lucifer.local>
References: <3dfbbd63-697d-42aa-8906-539d74df9123@nvidia.com>
 <44af8f5a-2d94-498b-a3e0-31f5dde74538@redhat.com>
 <20250606184212.GB63308@ziepe.ca>
 <f2d8febc-cf95-44dc-9f01-b28151fe1282@lucifer.local>
 <e5e88da7-d7c5-4a10-9318-76c1e38dd0a6@lucifer.local>
 <20250607134214.GA158671@ziepe.ca>
 <04f52d21-baeb-4286-99eb-99edead514b8@lucifer.local>
 <8ce6c104-d2fb-4fed-a108-224a6113c227@nvidia.com>
 <b387a3c6-1bf9-434f-a255-6e92269e6ba5@suse.cz>
 <c5be8d13-59ea-43e9-9b89-69dbfafd4a9c@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5be8d13-59ea-43e9-9b89-69dbfafd4a9c@suse.cz>
X-ClientProxiedBy: LO4P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5949ea-4fa3-403b-b46f-08ddcaa0b3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vhBfkZE5BrVNAj0qH2BWBkKkjCViOlXXy/SLVpHC6G1Md3XMuytasw2pSkOm?=
 =?us-ascii?Q?LpRSd7NOk6FZXIosA60tz8cFl9g1++FGwSlYGtxNUW89lj4kgBQcqarSl6K/?=
 =?us-ascii?Q?aAG3+TPcizh3yD1w6REKFH6KuCehRiAzn102oTDaw2dzbMGbkCe73mWJBfa5?=
 =?us-ascii?Q?M/3fFvqiqXcNP/LR3ZOLvKRcc/LM0+BHnHcSvk9hfDoX1M8AWspPhlYorp+X?=
 =?us-ascii?Q?EaAmNayeDhJlt3Qb9gFoybDI28GG17V2XXzE2QvVYsmO7S+2ZOPJvgwqISMU?=
 =?us-ascii?Q?aa6BeDJ6mU+dKNwQA0D861gstd7OeD+zJjvmCkcHSKZEckAhrHKD7mmynBAe?=
 =?us-ascii?Q?U6FhNHQzdOnZK0rSsXD+zqilMau/LA2jGRffHxtaEB17ZiKafHVFRTh1KpCv?=
 =?us-ascii?Q?D+gzotIw8t/NbgcMOHcv7TNUzTZ0oaiEB2IMUcIM+a3IAW6/zR2ATaBWn1RF?=
 =?us-ascii?Q?C9zCiRPiyfpksWJnhzeLzBJABiSDLPSjYWxHlLO40t1w+xtFUPJrlSWY2yJw?=
 =?us-ascii?Q?ibUnMYcz+iZbs0QFSHAaNGnPY2GQOvSVfZXIz240KqNSXYVJ+Db/bEMiw79V?=
 =?us-ascii?Q?dn072WcjCuvQynmQgPjN283MBkZUWlmfQRXherJ92ZXt5XnkZqGkSNzuxksZ?=
 =?us-ascii?Q?944ax9tz8yLs/9GbySDujCJ5wlaCV65tXuyKAy2GxgrylQF+nymd4z8UL5f1?=
 =?us-ascii?Q?ZKqSjD3uSkIvvy91t1g8+KPS5LuEanWe7+QluMfDPU+yVO6QODhD5hXo4e8J?=
 =?us-ascii?Q?9lIr49BiBJEE8di1MeO3z1DckKo96Si1faOb1D7FfBd2fVnr2Me9CCLveilG?=
 =?us-ascii?Q?bOgpLPPU5w7uCFB6jRCj/UM5YIxhLpUmM35ywYgwKfc7ARSXx4+2Y2bNbbrY?=
 =?us-ascii?Q?gveOA3fcmSElQIo0ph7uP6RG5SFFkyQhbssIHmyznUdOG5BEdV6m35SnHZrz?=
 =?us-ascii?Q?idINrHTgrFSnHqIm5MFXqNsOljByEyJOxNXTCZHEVBjphUlw+bKRJCkC6UJ2?=
 =?us-ascii?Q?NEXEs38Rsfod0Fsbb937gF5KyrzUgY+Y8NDs0ctPlEqcqCR0BzPMKT68aFEJ?=
 =?us-ascii?Q?EgyDdYsP/a6WuILVlCE1udfthZOp7L9MBhZkegSe3I+ig93UlP1AZQsHJaBn?=
 =?us-ascii?Q?GRTx6xtjsgF7w/ZHwbLCpGfKbPXgaO5bNCmXtOynXoE4/xS5BA/tAhe7hTzv?=
 =?us-ascii?Q?vGTebtD1mZTYAc7SnEMB4pzHqeGwzC31N71CTiGqiTEpXXTFogZRn2B9jQQO?=
 =?us-ascii?Q?4QO1jYyaOPUkJ/apri+7dId4zwopWtpM1SlLvJqHQWrTcSbMZcSoqEBUBcRM?=
 =?us-ascii?Q?viEgao37Jlu11qAg13iFq4UC0ccROmwwb2zzQ+0LMInxR3RrUIM+hSSZvyam?=
 =?us-ascii?Q?5G5Wph20pqFu5MDsdyUSqF2f50YtOUlKZUOwLa5BR+fwrYmpFOY7HkLh//7p?=
 =?us-ascii?Q?dcM6IaL34N8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kTSERjDObCdDvzMmHAMpbRGIcBv7YFf/pGpq56RLu8fftzMyMXQuPFP3WWpL?=
 =?us-ascii?Q?sav8xE7O+qTZUlWWhg02eijVLRkVe9p1b+fZhYZftxviKUXXGkXNcCbB9Y+O?=
 =?us-ascii?Q?73D+p3sqyGs6x8qyt6d1mgdrXy1yaWnlcizMCGZ2gFUa00jrGWb+dLixVq2G?=
 =?us-ascii?Q?/RpmoEZxQk3QaGyp5p82ehJtDgWn2VZXRBFp6dRfx+iK2nQ8aU4lOK8/G483?=
 =?us-ascii?Q?GvYR10EAZBYia5OtM/vun2O0r+1ZTwhZhegfLJUXH9XXu+hkdBLE7irjzt5n?=
 =?us-ascii?Q?IFeGyM15IKDpZQ3CvnT7qi5TE6mkUMAoQcXrgLFsCSyye4TfAde8aM2gAHlM?=
 =?us-ascii?Q?txC08gBiGSJ+0No6Pca+E2zPSgBDsSueZXUUkWnXkhp1nlP601aOvx0QDaOd?=
 =?us-ascii?Q?KHHymrwWTvDuwd5ieOTbAiLDqaC9ymARB5nY1sj/XPgrK7b2oiTuT17bYnqL?=
 =?us-ascii?Q?VCLIRJQ/XCqRn9Mx27elC/2Ajsqi8arIKbrLjStvjmrKVHPlh8GKHt1+WjAA?=
 =?us-ascii?Q?onk2CQmOMteS5UM4eESvEChXcaA1TVsRC4WNblYPXiMxrRAM1bqWFh1/q8Xi?=
 =?us-ascii?Q?Bz5qsovO7Cwx1SamqcNGmgqg5zrc4HTdT7hjGc+YLSpyxSNalZseg9XrPhRb?=
 =?us-ascii?Q?nIopH4KSA5Olf9qGiC7LaCPuQw+H3J41tYMjR+2uU9I5G84njggeeysu3YUf?=
 =?us-ascii?Q?AxPRNOSeXDJYHMAX/nektpRRJFrE9E5gMqec5dJ6nYaru24hzwVsXL00HbgK?=
 =?us-ascii?Q?W/p2iZH0WpXlSEOWtHQmC8R6UMjuQri6PptTfJt/B7tIHbJ+XxiG1OqLxih3?=
 =?us-ascii?Q?hM7vzddbu3LeX4BC++uP2NTjRKeJZKLgov5RKy66XnvLcd8SRHlyKUVUzfpH?=
 =?us-ascii?Q?vPdjaSFLH+CbrAWB7Ni+JQ418jf0tKn0JMZhfUZgVpOtdYAzS7TQMs3MK4Td?=
 =?us-ascii?Q?JAbXqDWmzyc8f2oYWYk+TGrn/C8o9rtID/MZWOIs3So1R6RGFTQqMDq4IM2U?=
 =?us-ascii?Q?QtqblfTMgCwsWpXluAY8WrR0Zc2EfSfLOoJ/nzelvnSk4exQ45ft5dDuhCHT?=
 =?us-ascii?Q?KnL99yKauB5Gy+Gn4azO9NHpQw1P8cptK2GwolqHm5imAFcrE86ve0muvCDK?=
 =?us-ascii?Q?aLdhVXtyEL0+B15Wb2ZK6hn86uw//LhdCCx9IYXeil1IlOcnNIWfsEGKOdgx?=
 =?us-ascii?Q?9Th+OAt6XmIDQlN/Fz7v8bMnG66H/EJXmd5Ptcjpgr3DzQnHd6sOrciY9vNI?=
 =?us-ascii?Q?1u8XB76Eq2Gk6SXw34ftMYivgOe0ybtpgWuQI4ca+zNoZVKfu2uWw3zjtqZI?=
 =?us-ascii?Q?6utLzOq156HwqCdl2KqeFw9jIIDJJ95dMzFMuPzYNVRQ8MRARoojHdDjfQNl?=
 =?us-ascii?Q?b9UCRKIHmwg+JYQilMeQV67hJd3nILatXaYVWN97YYRW2GsnZMeZ93Zz+uHx?=
 =?us-ascii?Q?tnq+CtE1QsJnTGLahyHbSCgq7M1JQ+3Wc7vJd0duvlY02PCT0yfqgUOf3N+2?=
 =?us-ascii?Q?TVtomTrF0J28d1M+jZFF9bDsv4qvNq4VbLAeDqjjyCrIWgtGUytZmyrXC5Hf?=
 =?us-ascii?Q?/hizCCbifj2jgbDafqyN3NU6/7Z7FyXir4yYygdnG1Jysx0iraK4w6YJQOnV?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KGcNmntg25JMOzAwSmshL9RYQhnh3HkAumTOjTdNHWa46d9JHQfAcfFpLQh03m1thHlNg5J6uV9NlZzDjAQ4hIFkpeRVvjiKria/lwWQKLaD5yRH53CUyDBpFdBFMGgRzRCwQj0Q4IdjK+DWWeiSscOuZnaxB/dS0yN63RBtYFBEtWEMpgdL/5qkOxBrFR4OJYCgm5Y083ybHX9Nj2K75IwcU1sOI5HBkDm6HNDS88TujGmkDcfNh0X0C9c42G1j4S0x7CrgOGEOEbQlW4XVYwFstbixZImtRc6an8Uuzu9ah6lL3yHPlPsQpCnfn+/N7JObfIjLToWtCsRm61P9haz0zJesCSZnm6o9l+i5eIBGrBv3bJ9hF206pbyjHDujpuA/Kl9fgFrmE3CaGY62twQDLhW6M3PEI4PbAsqzWs2eIR5aTqV5XFoPik/xt0yb+XuOha77FwJ+DiZDLXhMRvMH0XBI4umhBOP83MO5eVSv08FOrm7ANBUdwqJkiL0Y32QEJmXq1e6qg5dNYDE1AAe7uEAecfv9hnj3RjVl4IycmdE2ZSfZvchG4V6UmElqMSrhAvTD16HjhM7AoWOayr1bb/4FWDfhD6CjcRUsW3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5949ea-4fa3-403b-b46f-08ddcaa0b3d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:56:11.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gb+OGnb9bZ646FcaNG2jzMGzAl8piJdoEXdFlGmk2QPKKwBnG114J5UVe/rG5UoUgjrLHfPmorfp9Dy4jf9jctFso+Jg5zr6jiLuUiisijk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=929 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507240081
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=6882114f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=1W-cKhw0_BP0kWbbf4wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: a0saPAZWitGplZ1kHvoG5W4Cm5EPBj32
X-Proofpoint-GUID: a0saPAZWitGplZ1kHvoG5W4Cm5EPBj32
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA4MiBTYWx0ZWRfX9DP1kWJgF005
 EoGI9AUFbuGay1CjM/KCofGpTEPnteHEhhmARCmMS2LVmDwxe9QpawnY5x9buFaSzLjkL/bhsjn
 1TMQ40YsEd37Cuoo2d/e1mBm/tpV+ShOpNkBd5ewi9xNXbobTlTuuWxEjXOmJ9Qnzbtg5fRovwB
 GqQ2h73g2zWjTYUW6JByCIA1b6JEEZOOjqFJ1+n7DWQRTcm+YwphEZZag5TN2J9k9nDBfM/SqIZ
 KM4HjouSmvMupTujYb6JSkthzraKxSnH4CGnoIeyv++K7Idj7+DNIQGmEanAiMoSg4vD47RWvCS
 WY6HoHvzDTfzDjH7ogN1dsFF7MkxeYc2KYHf9llTi1SaKrkwp4oJGlOjLATsnCaLmpQdWuqBPSo
 unHtrUCe8p2yw5wFmkBVP3KHzSc8Bv7UlweobzAXbNpu8MVdcM8oMI+Wq2WPpwtgRbcCTBAf

On Thu, Jul 24, 2025 at 12:54:26PM +0200, Vlastimil Babka wrote:
> On 6/9/25 11:57, Vlastimil Babka wrote:
> > On 6/7/25 8:00 PM, John Hubbard wrote:
> >> On 6/7/25 6:53 AM, Lorenzo Stoakes wrote:
> >> The worst part is that if you go to reproduce a problem, you don't
> >> see the next warning in the logs!! This is devastating, especially if
> >> the site makes it hard to ask for a system reboot. (If you have
> >> ~20,000 nodes in the cluster, a reboot is not a small affair.)
> >
> > Assuming you know how to reproduce the problem... I wonder if it would
> > help if there was a way (sysctl?) to re-arm all the _ONCE warnings. It
> > shouldn't be that hard hopefully?
>
> Oh hey it already exists, since 2017
>
> echo 1 > /sys/kernel/debug/clear_warn_once

Ohhh! Nice!

