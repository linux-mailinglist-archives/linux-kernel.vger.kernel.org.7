Return-Path: <linux-kernel+bounces-745887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B3FB12013
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2721687E5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA482356CF;
	Fri, 25 Jul 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gnrIvy63";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FGNcLNle"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027A1C5D59
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453491; cv=fail; b=l0Jgbq1zri4XqnVRMSlKQJJDWmOhURl086+fSmzvPrcHOIogTrzedKTQxftpxTgluYX5DMuyYjRTtgKXOw7pvpjNbGoEtl1kaLcCKG7kh7HSh8xoZksP8SScWAHlBopSwDLRc2E2P+BN/yKOATSRp7PCpJXFV2LPohBnwBSrZIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453491; c=relaxed/simple;
	bh=5VoF8veo9HgKznnavE5yPBnc1o6jXlQAY3JZZaLSZfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lQ4P3DtgsQScHISDzMv3OtPhgPXbRnqb3W56xWrT8DPjSdaG0Y0wP+1LffjKFv+TP6ZRqDmgB9yKRVLxQaxzPcWY5DHyjhU5+NbwvzmJ4E2SlYUI8jJzd4B2oNPIEN/C+q0PwCBiPLwvrQhc/RduP8/blkwrW/HZmZsaZ+5+/WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gnrIvy63; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FGNcLNle; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PEIxfD022699;
	Fri, 25 Jul 2025 14:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gleuBi38Xtu0HHcyZF
	H6YdzMKUovV+/jiL0G7aHgOlE=; b=gnrIvy63IeFGUuoqhtxZ7btdcFgSV/laAt
	MKqJhHs6XtNDsomW8d4ktp0Z4emmHql9vkK13bGv0gIpBuq9DV2+GsEDmJSw/IBS
	aQTl5PTM8ISylfnrRVrqd0ftv2OYLP4dEZURZ6Yud6xrSXPWdtftG0CszaW8wGGb
	jN+au2x/sSc5A7Cs2ehJo4fmojiSh4DbNFgj+RtGbAMLC7kDEwois3/l9PibaxS/
	vwfiM3CHi6fK84c43laIn5SHAVL/sDfZCUnxoBsihltR57bGgWi1qjll9dS/SD6s
	ruWcoeIOuop1IWwOTjugP2vKMPSTkiobB935v39d+H/tGqQT67kQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k95qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 14:23:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PD9hn6011318;
	Fri, 25 Jul 2025 14:23:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801td3cva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 14:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNDn0P8UpTmqliyScDJq9F3nwj2u3mUMcTAYt/XM0OUvqZE0K8RhDCBrza3HjKuwM/o3SDrIgJV9jZpeNSCWdBBlxgVjTPceOWFXoQj5SSeukpvWoz+wh7eG6p7PouJDT9XKbvwV9/3rfkNc/jqsITAuff7pml9cQ+hAcZrZPTdI5tW1iIFZGWcYaeQj4BwpcFVfszAiOrE1b/++pTU7l6sMhdggPpBjOdvS4Axah5MV6us88rrAY6S4X7wSYl023eaKP7rf6Ptpl7z/cJkX6QznghXx3WhtLGO4FUyoPF01ktpIwnDD/4duAVMdAtw4OkKoiJ7e+h6YuuedIM4VCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gleuBi38Xtu0HHcyZFH6YdzMKUovV+/jiL0G7aHgOlE=;
 b=tHjdDCHOBtaGHW31hvteOWllYLWK0hrtNAiJPDHXfMxDMxjEWqeDJKraSByPYKeJuMeeJgwctGY7Xi8lZ+IhYOuizODTYAson042Geak/LjejQqnL0YLrDhxfIQZ+o6AIQtw6YfJnJPqn08J0+suReadJWIEPJv4B8wB9SDMWTiNKT3uBZkYWcEjfMS/0WeQ+lrrxxuaQDRtC/171I5gek7XXlf7uhqM+bj/N6/VmGgzz68K4q7Z+4U55t92ak6RMbBhR42DE/c5WqgapP8cJvWa5a02jMBx+YaxBOEeoaJwrLpzFLh7jkmM74uQw76ys3EfnGSoSDW5iU2XwhdGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gleuBi38Xtu0HHcyZFH6YdzMKUovV+/jiL0G7aHgOlE=;
 b=FGNcLNlezbxQQ187Wt5C4x6LuAbw6xsO0JY/Oq39weVztyv1jDdGGjGeI87jAvtDDndv7JW7OGug4m/kHqk1HW0+ZG/YJ/ZqajZRAsj1COQ39Ivi6pQqP2rsZTC0TN4+mzvOdqV/o5OsG7jRVILdHjMArjzodiESTCgX92vE80g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5136.namprd10.prod.outlook.com (2603:10b6:5:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 14:23:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 14:23:42 +0000
Date: Fri, 25 Jul 2025 15:23:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove io-mapping
Message-ID: <f9cf2e9c-6ff3-4a0f-a6d8-226f37f2bfa0@lucifer.local>
References: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>
 <87y0sd8lpv.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0sd8lpv.fsf@trenco.lwn.net>
X-ClientProxiedBy: LO4P123CA0623.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: fa156f04-cde3-4378-d1d7-08ddcb86db20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bgvae7Eg0fQF428G4nfl5pHBZ47Dk6QZfLyOEFXwiSHEDSr/qAq0+0csizCN?=
 =?us-ascii?Q?ofQL5bfCZqKfpdV13WWydM/7Cq0yyZRqKCU5FRqcVEr4Cw7geS1FXHm/EHmy?=
 =?us-ascii?Q?EmTSqS5KUwWwxldSjEaYskXnvlQ0fLqq1dEtLRYYDzciaZ3EYJApj/nV772Z?=
 =?us-ascii?Q?gwxi7ZcB4+/qIzkPyOmtOg+Nr74loHgK9FbypIbatKzOK1//DHM9DClJAFvy?=
 =?us-ascii?Q?Rfv4dIkJer7FP/UshXL8OEHDj8riDlql4xNTGIxTCUyBy5AO1uJjdnF8XnIz?=
 =?us-ascii?Q?i4jWroBhpFa8RcW+UrBGxzGYdpSIrC5CBAn7hAaMKBKAx0x28ieOLT2B6M3f?=
 =?us-ascii?Q?6WTJpvJ4vykuov52NoPqPZVl4sA201vOeoq3N8WQJLHQaKLlohFAbnrAQBG2?=
 =?us-ascii?Q?zoPh+vVxHm0DxZIgw14vEZJUz3ofpFl8Cv6mWsp2ViBqvFV0hmuR0FoNnQIw?=
 =?us-ascii?Q?Do7xJnPpstwZ8U4hxAz139xIgybitbJWHz/J57MRNXI0xwIRNf5kQiE2jKSk?=
 =?us-ascii?Q?qsxK80oXCZzd2HeeqW6RDlHF3vAbB2t7zYmPkJAevobOnhpQXOTqThomQod+?=
 =?us-ascii?Q?vGTdNq4mMtHLz0lyKzGIxhSVARFxO0fpweorcU7tkt3undyV6uU5t/iNoM0k?=
 =?us-ascii?Q?YJpDbmoJg3O4u8mNvk0e/XT3x2rHRbzSB+Nq553LOgzEJwUhvrSYQt4+K6s7?=
 =?us-ascii?Q?MrQcm1vpcUgfa8svRaijdaX6behZpLvUVP3D+I19uO3NVoJIj04wPloccbZX?=
 =?us-ascii?Q?RniOToVbGCb3W+iJA9t/Mr3n856dBhFWFhK4kIhY0IZgGYU79XkU5iBA2aXa?=
 =?us-ascii?Q?a6JKZA2Y/uBvUgQzmmo8kU3xXK/Va8OXKK2covBJVQxaFlPk1OLETJc0uUVR?=
 =?us-ascii?Q?9pLM5QpdADf7XOpUeOPCB+IExuABFWi/BOPzwzsPbFwLdc1pLEv3ks6jjWK3?=
 =?us-ascii?Q?wycoJgW6YasXktq50jaKUvFoUJnTAGBb0Fj56KCpPe1v18CEGPSnGijyzW7h?=
 =?us-ascii?Q?/79fqdiXslMUh/ZrL/Ou1DLRQI8g5sHRqS4+QOcY/iiSZYVHsXfsVtl12qD+?=
 =?us-ascii?Q?rcBQPxNmOYCFz+tluv0C/vGjr3Qq2R26HxiASyNZyqTgWk/rLyn3zsCQBZuQ?=
 =?us-ascii?Q?StHxQuSSImv0B9hrT/q33d5mxY5QDF/IFzdNCY+ul2iQmN/Jjwi2hGNTiMkJ?=
 =?us-ascii?Q?46vyX7bZ0EV3C46L5QsjbENIVYfYkknXXV8oJQuA+e8kvJFcWAzcSA+G+luH?=
 =?us-ascii?Q?GHxPd5TnWHUtvDNIGaif9ZC9MF/9kFRfG1jR9hWB1r28ivVuGyTkwpI0p/bQ?=
 =?us-ascii?Q?upjhlcQbtE45cuLewVKTaJyABfHJBfKPIb3H2eP5T6Rez34QamNhtgljmIsL?=
 =?us-ascii?Q?tq7aVrrAxLYVAR43J6r7cDHjsdtk1mAZrfLiEZF/hfjSBZ2Zl0d0ylr4d7sT?=
 =?us-ascii?Q?YyOeieS4Xo4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cUnBf32gYHYME1pmwgqv7HlRQwhtgbXE3kctwmgZ0MfHR8i71jeGenQwuXN6?=
 =?us-ascii?Q?Hr6ZOph/Xjhq8vxi34TdUjemvJnK+GZQBH1pPAwi24or04//y9SDIhzphwA1?=
 =?us-ascii?Q?ByUmlSpb9becvAC8PL1YYHjXWf7cKRyYoAP7SMYZpuA2iVwX+azs485Fp823?=
 =?us-ascii?Q?acTYWe0o7qD8CZQhwqGAtjwkZ8HH+dMd8BO65Sg/WHzlDgzVp+rlGArlrIQn?=
 =?us-ascii?Q?pKZs5+IqcdrL3Sg+957yImAPoBDeZtbFqIq12qOi58ORUE2pgI6zWFDYzkMP?=
 =?us-ascii?Q?wg2+pRsXrK9cH/1UGxdljfFCDojl0HnD3K+yC1FDjT4SMz+bWsZCksT9SEwG?=
 =?us-ascii?Q?atybCZjwEwjzZU3TBWn71GfjPvJi6+s9ZGHUm4NpiQC9989tNycbSJniNbmW?=
 =?us-ascii?Q?H9UlK5rzqdOscRlMyALuvTweWX/sw7Hj7RK6wKgSalxV/FyR+KLn+1lS1LLo?=
 =?us-ascii?Q?W5zQ0CqRnPYo3cK1hYv7W2UucwNNIhXPvMFVLZXPKU36PxQFm9EZPw9bUi+a?=
 =?us-ascii?Q?17BwJLXH6r8nZafYxqTGeJ49rwB0W3fgkfn0Dnx5oAFSVFTgw/t58NzGATQL?=
 =?us-ascii?Q?c1gQzMuERLCfDFyONAfEphNozY0VNIjKapDaLDyGYd8d+kIKT21/J2hiwtfM?=
 =?us-ascii?Q?iDMANLsl7fmtOSmefAoytjjKLU6bk35wnTliB0yTHBnqdy0j/SYcULikMst8?=
 =?us-ascii?Q?2OC3u4VVQqAId5PolNA+kvLZ9OzNeEVCDbESRlNYHbtN/Utpjf+gtkoAGUKk?=
 =?us-ascii?Q?4pymrX5Tc92aSDD3NkmU8fPlSGydQVVzbZoEq8MiNgrZl+ByB0/Txev0T412?=
 =?us-ascii?Q?8sFRlDIDHFTfaevOv0dPq7xVUkbaXH5gtVKM0+J9UQq8WdBMjWB7VYm9Mdyo?=
 =?us-ascii?Q?wj1iah1iUfRJhg+W30dnqjAWozMYze0/ISPtEt3D9nH63AFq5a8yA5z4dO1g?=
 =?us-ascii?Q?lf0DQLr/5hAYGxoPyiAb30HPVoEdGy1XCULrDoAbioUA5xNBSSNlH6hEPGpR?=
 =?us-ascii?Q?2UEIRPZcOykq9K+bbPDFAU/hL3nlMBOpSji1KR0UDBPLl3QIiAyAUNiWf1jJ?=
 =?us-ascii?Q?JaCP5RToOKG2M0zfan7jCcM+Xb6OjYadLa4E2rKoX/kErNDfkcmYSL7bvTh9?=
 =?us-ascii?Q?CmuLHM7+qCzjv40sK39q4zBscKnS9hF0WabpffMFuEoa8sBvTru8FmrjLaih?=
 =?us-ascii?Q?AzDb3nmSRpK0ZfkMAJ2TbXQj9v9tuAIlP3KPfzlUurLxyoMioJIPWTlJh5m+?=
 =?us-ascii?Q?op7dCjz3EaBO5hswAWdrPDn2UdCxpqvfezwFGiFXMGyhvOEQ5saaoW+F3o+5?=
 =?us-ascii?Q?ZtqIyb8gkjxUfFtBZNqdyG+kl0AmdlY8S/Bm7f8PYpjKof5t8WEIZb8PiH6a?=
 =?us-ascii?Q?JsoC7Cbu4yhTgXADaffk1Sk73jL85uUGl8l0VqlBKsZ6OutYNpfaBXqdUGKh?=
 =?us-ascii?Q?oYZoL3ZkK748xUQiSfz6G0bN8YRcY+jR4LTpSyrXuI1ufPZM4Kl4qaXxrTm1?=
 =?us-ascii?Q?6XTy5uzELGn1ZDpitdak0fSKOXHi2a06H6LcSVMPtshmHJvzla+wG3B8rlLf?=
 =?us-ascii?Q?pfFKsa+Vs3dm46X+IOi2u0ZiI473RUoNM7wCQ/fYGDqQhmXPxE1ygYSfcteW?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5EDur0CgL00tZPrz2hO4Ng/v6TahdmP8Rrz7VTW19pZA6gYAh9jNiPkAvcSNN6uE82YOdnkieGjxZcpVqDZp+zddVO2wsZO3VDEhekf8M40noEf2Vd+22MeqHVFddyzsrphRotMKi3yPJVStMIEL1PpJxSHBEFR5ZmlrU9GzsW2qQ+RoqLjQUEc4c1f3xoTFpmRqcwFy5kL62HX9o/crIqfAODWp6LVyTo2DbDE77SpL1DNmq70wnTG3nQY0hnXiErwadJIDS0LSTRfOVBxcgVlaybfU7k3bLYgidggijLGrsjudOul3F8N9L7//CpoaDzG32kMA0CjHMiqBOs/oepXDv1FwXaiLM8n+gXaQ1TNvjEMrcVfn1+udHrmlqAKjLu67lUKX6oyGmlL+H9rTTkPBtVOoLyHAbK0oKqCmmHscbfC5o4Zii0HC51Yp1KqsPUsGR/cO0vjnuQxGpPJmXxZNv9y7ddasNF5wnAg4nWQhvpolwGachTlel24iQ49G85Jgw09wFld7mdLZAjevCod/16611LaazUCubnu2rYUu1jcfjAuhHfe2Rc3+1lyAUGkl2ybzF9vW8DWm3CP8ERH5IU+qJgmIY/0YBkUgyew=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa156f04-cde3-4378-d1d7-08ddcb86db20
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 14:23:41.9488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3SYk6dH9jtgmJlxSOjnIISb8BdPzgSlUj9XEHsSgRWl1CPasdrg0g/4sHimwHuO04mS/CGBlRye9Ls/U6u1Q0nj4XAYTRbTG4UzVlwG70Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=913 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507250123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEyMyBTYWx0ZWRfXy9P93OBlPXIp
 j/rzm2efOzUTjp1u1thSKnbQV3be8/pI+x0Y8Ho6c3FwA2CbzeKLDMOx+jFAN1oW3N6lVaN7u6W
 8Pc6uTaj14yuXHLEYJOuansU7ioCmPCIGu9vjvVZp83wHCmWDwxwxIx3n3rdyue/EFgzQlZcEsa
 UqO43bOpVhcxZj/QDjjhThwKX+WDtDD26bBx4asZtcQMwzZT1LcPxqaCtMCiQwb4aPTQxrPZ5DV
 nd813CDGwqjf6eZx5YHAnGAoxbA1p3peM7mtb4DNLHVm7Jx2I/jW9xlkA6/F4+iLuUlDq3leTV4
 V1A2JN2j5beh5B7netR8hIW2HrgBrM7qlWDLCRkKDUfz9IVnttH0hM6Y7/q0crcAGrsE1QGRRMV
 ShkIq+oed+Se8Or11t++EYiAWcs1h9UZsRMbKwnwB3ZAJ7dUXYXetzWdLS7SZ+BoJgqvx6uV
X-Proofpoint-ORIG-GUID: lBGI4iUWnQd7DSmXzGTxLwPG0hAeHiDu
X-Proofpoint-GUID: lBGI4iUWnQd7DSmXzGTxLwPG0hAeHiDu
X-Authority-Analysis: v=2.4 cv=JIQ7s9Kb c=1 sm=1 tr=0 ts=68839372 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=fq4X66aJWinw8JynJ64A:9 a=CjuIK1q_8ugA:10

On Thu, Jul 24, 2025 at 12:53:00PM -0600, Jonathan Corbet wrote:
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:
>
> > This is dead code, which was used from commit b739f125e4eb ("i915: use
> > io_mapping_map_user") but reverted a month later by commit
> > 0e4fe0c9f2f9 ("Revert "i915: use io_mapping_map_user"") back in 2021.
> >
> > Since then nobody has used it, so remove it.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/io-mapping.h | 231 -------------------------------------
> >  mm/Kconfig                 |   4 -
> >  mm/Makefile                |   1 -
> >  mm/io-mapping.c            |  30 -----
> >  4 files changed, 266 deletions(-)
> >  delete mode 100644 include/linux/io-mapping.h
> >  delete mode 100644 mm/io-mapping.c
>
> [...]
>
> > -/*
> > - * The io_mapping mechanism provides an abstraction for mapping
> > - * individual pages from an io device to the CPU in an efficient fashion.
> > - *
> > - * See Documentation/driver-api/io-mapping.rst
> > - */
> 				      ^
> 				      |
> You'll want to get rid of that file --+ too
>
> jon

Thanks for this, but it turns out we aren't getting rid of the header at
all (doh!) just io_mapping_map_user()... It's been a long week :)

Cheers, Lorenzo

