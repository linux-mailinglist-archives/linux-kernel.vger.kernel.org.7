Return-Path: <linux-kernel+bounces-899741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A359CC58A48
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F687508964
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC16E358D3E;
	Thu, 13 Nov 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VcZIDrrd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C9GaZ08+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205E14A60F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049786; cv=fail; b=IYGf8Wv+hReeWTyyiZX78quxasP1nVuEI0elRvYZm+j4d55MasvYn78EwvjcJ/aSDtcxoeG1NJM5FkRSlTvgzaTUmgMb3YiLCCqQ2qSWVGuxEEndeWoj+IZpU4dlKuVdfWpzh6+bTBKbz+Qu6lDzQ5ar1hJ2QqmzKkDt6l3+VIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049786; c=relaxed/simple;
	bh=q+SVSffNjWEZpsoBwDjT7Hu5EJbzqIlqvMkL/69YD5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LAucgpDohohmPPUGEhR77370n1Kwqo6zl5rj7yIn4r58CVK1ZOgDh1gPyZQc23HaLbinffU+TP8vhCv5j7Yu0rhmxkvipctQ45j5IBXYWyteXipGrCgGIeumvQJJubtYqO/03t/jolYmkBuKXEc0Ra/TwY+JcAXoEp88OV1+RtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VcZIDrrd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C9GaZ08+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9xnO005893;
	Thu, 13 Nov 2025 16:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=q+SVSffNjWEZpsoBwD
	jT7Hu5EJbzqIlqvMkL/69YD5s=; b=VcZIDrrd5lCMTM8g8U11a+gTJ1MtHjRkgp
	wV3YI9sbOrA4ku/YqElMyBJKg32wUy1SQqenB8xbU9eO0ueDBZRGPYVOfcHANwhA
	6mgfk74CVuikJPT9RALGmwBier3yoONzAH1FBZVjTv3qDPOVBJBQktWM9CXTNUBh
	HUtsJKb/UxAjyo9QWsJrOCU14oS6r8ip0PVnVsdRNgs3hWwx/h6la6OI4vwz4+Wx
	/jb1YoWKljdfNKF0cGc4cco5is2ly81FXq4TIAYJpSPGJYK9GHqCv9KbevtJmW+O
	f/QVz9zmrXt+INdoWMLZraFu+0q+DSnDx/HO/na+GLkYMPmESbPA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyraa26b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:02:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEGTXd003143;
	Thu, 13 Nov 2025 16:02:22 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacu7t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:02:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laB1A5YZt5OZnGWpvyhcjqiQy65PPckXnxjXvrnoGtxWe21KlsScxulOyEbKWnYWfyAbxmtPeG8J4gci6GmRKCuCNfZNaLxG66jpQb2tIlbfT9pgxOiMMRqtI/yJAKPD4/gGNZ8ywBzY9oYcZq8Tw2v74XJM1/A3rAkmknIY/indyQJIr3vUwJwyfnONeoezr/K0KvTRxE8aGPjDBcnuqMceT+iV8Mt4dfh+vThp/k9rZisRenu2Lx+60ZkmN+bwuhUG+keiDfTHtuRkeJRNMsQYk74+J42rAb5uUkj0PXfc5lsmLpwVGmW4acmc2fhZHoCgCX+6qOOdpDsZ3z+tKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+SVSffNjWEZpsoBwDjT7Hu5EJbzqIlqvMkL/69YD5s=;
 b=O2uGMCXQvIJEV8yU8nlTLLWQlmV+tJNkvChFqHaIddSY8Ytw9mBb2zgk3TEeVxUg1CGoxwcXT86AcPZJlxDGX/qlWhHCjY2KK558gZc7MkekFFCvflHlpVyJh5uOfCJ6w4p92zys92czjnP0g1IzhwFbmAoCCEyU+O45N6+UUP2pYx49LVHqDZr9wZwmWK7uJPfsee733wkTBafT1tGRbk2/c5o/p7HIlysu8usdMTLRhqPxcKSICZxi1MRP1d2EL5y/oeXaaIdFZLYwjCT77QMGmIznwOqHKmTEdfvW6lwvm9N6koJ+dWHLop4Fds0nyDUGhbrohE1Q7jceZPihUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+SVSffNjWEZpsoBwDjT7Hu5EJbzqIlqvMkL/69YD5s=;
 b=C9GaZ08+m/dh4fTm9GskD5BY1gIMoutfcF/Icn+ISeedvEKSv55R4OR5E6c+czQXy5B0FIqTXpidA7UqjRZNF9M4p93ByZyyLlgUnHMPjuoJ2em9TjWATGW9IrNxRdJI2JbmhaYep0koP9remHsoPdk8SdbMVEtpmeqL3mOasuk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4266.namprd10.prod.outlook.com (2603:10b6:5:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 16:02:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:02:17 +0000
Date: Thu, 13 Nov 2025 16:02:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Francois Dugast <francois.dugast@intel.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>,
        Matthew Brost <matthew.brost@intel.com>
Subject: Re: [PATCH] mm/huge_memory.c: introduce split_unmapped_folio_to_order
Message-ID: <8ffcbd7a-511e-499b-919d-0c56ccc3c63b@lucifer.local>
References: <20251112044634.963360-1-balbirs@nvidia.com>
 <aRX62SR8NLps2NWH@fdugast-desk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRX62SR8NLps2NWH@fdugast-desk>
X-ClientProxiedBy: LO4P123CA0138.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0f51b5-c882-40f8-ffa7-08de22ce0503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2KPFOTJ28PratNQ+LCbEJw2pMt+j/vPBFVAX2Ej13OouEfafvbX4P+gaTkHC?=
 =?us-ascii?Q?rtHmQUGMhgZWbvYweY+R/BpIr4+hvuRyhITGSLt7oSEhk38LWbYoHBJB3frg?=
 =?us-ascii?Q?OEASfGtxdLU3I/w2Z7i9/0bdprtEsuJI+W9i1Up0axcCt4tDfFgrcYJUIp6R?=
 =?us-ascii?Q?sgCYwVc8eQPllyvAMRhiEOAidzHijxb7J6Fb8IQLlrqlbvcaspxKs5QNnpmc?=
 =?us-ascii?Q?YuyQA7gXiYalYQsQIpfnOzANsBs4SYOchJG6LA4FrbXfuCa6ln1zjID1FgeU?=
 =?us-ascii?Q?4j0l921Hokf6H5akhswW/rGy9eDpLlp8DNfwaeANeDCSANObatx6uk5H9Llv?=
 =?us-ascii?Q?YHh2aXrFJC0NpS8xSQL2kISm2N51lvnOGneCYB27O6ybDtIm3TgTQnmQo3EU?=
 =?us-ascii?Q?9OGlD/WQsdf1PveGqVN7+Bdn4yiZ+nRxkGpWjHbDkmPJZEEGlTKhjdyuBlqV?=
 =?us-ascii?Q?0nj6qbuznf6vXfHaZDdwQCexcKA+Ovn600fk3tR74e5wmTP/aM8OZxSIi39T?=
 =?us-ascii?Q?E5r4I9T/RFM/vIZ3/HHpNSnVX/icDXd0/0QCcOUWT1mJoGzUtp7iPJSIho5s?=
 =?us-ascii?Q?osmpgQpW2/+VV9VbffkD3SUBzkRrguyBLTTWh79sCbO6zwhhtiyLnDrYARmf?=
 =?us-ascii?Q?YMoI4HspnZ0qAUsvWgYpg4ZMAVbhLrpqdPSxGBo1PZGIn0uB9896Bs+MkyE5?=
 =?us-ascii?Q?sIAtpgWFBl2MXrTHwLM1Vx0aSN0ODDg/WYyKeHtLQ1CLPsVcKD3yEaMcsbf1?=
 =?us-ascii?Q?B57JnS7UIrqmDJ9mt5Z3RGOIX9k/Hv6rlU1ZEXHYw5gSzBGM/ObcddgQpRuT?=
 =?us-ascii?Q?Hq7RzP6Gj+3ec/FlgeP93t1Tpg1JtsSN0Vmq56efb03ZZoynXirgqHThxeCw?=
 =?us-ascii?Q?TBKqDmHeFBRorahma+CJuXVPY/4Hp0W++x5fV5BpmMGJKfsQpzZamLM7zaDK?=
 =?us-ascii?Q?5aRZRKke6WMJJ9eLsgboBmXT3ttL/Uj4PFan3DEKiC7VHsD6O59ifrZgPqM3?=
 =?us-ascii?Q?VIhRSHTTbhothDCMde/DIytzCFKFJhgDXvHaJwlF+FITBGo/QzszwDSdpYAN?=
 =?us-ascii?Q?hZYYfE9rNHBpOBXlrNaXptQiIfO+se0mU226wfqizIX0l8z/5CUc9/VnG7iR?=
 =?us-ascii?Q?dk2nF30Dxf26FU1+uRjaQ34llYRWrTtnlwhTV8Xgcs0+SZKylfBYTlmUNi1e?=
 =?us-ascii?Q?wkz6MbKUYtA2CRSfSdGaKCTGmpPs+cyRaR6AbosyIzTFmUC0SpOt3sLRhJf7?=
 =?us-ascii?Q?hZ8f4iiTVisCwRmlpGPeHB/7zCaAoNkZ34IBX4WF0O42AgVQSCCoB6/JULEC?=
 =?us-ascii?Q?Bg9NON6H+1VK+Yd4FJv86hCZdPcKgqanzlIxg72njfpe4sn+dcmSXYji1cDH?=
 =?us-ascii?Q?lpmoJ3l8mnb1XTVIWX1YXaYbljkElVPquxDa4ulKDIZrqSvvo9HTJqTWlODn?=
 =?us-ascii?Q?jgC533gyV4f0c3huIRHWaP+tiEtsvv/U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QzItvmgWcVTVr8O8A1a0AdiRe7NhJXFhq5r4se9JmUvMnUWLaDzXX/Kw75bd?=
 =?us-ascii?Q?/SkXARs3/T95tDGVQwIQPGQbG2uz7xR5CszYjJHbJQdQAM8wQoJeu+G9PhY8?=
 =?us-ascii?Q?L4xxNQ0QXQGR4uTsvMqQtuio5aMTW3E1KjWqjMtNkAWscvuVYRx5dOJha4P5?=
 =?us-ascii?Q?j3tMXmm8rqIBiAad8Spy0xrPi/Nq7K5kBhKKklbwgQB2FOJPjL1telfgv90y?=
 =?us-ascii?Q?CgtyhcouKtZQOQQAKybT1lDDvbE65ph8KqeOLzYj1914Xe3QWjts8HqDPK83?=
 =?us-ascii?Q?btIXz3Eb5NEqxfThM0u7IxhkEsuMjZ6L8iFaoDFJlPLt9ZLJbaZp1I+uFtkw?=
 =?us-ascii?Q?yEk2LZAquhlwXCRDk4a2Jj3PjGWjdKD/g06x6AIZhBBNia8qu4hnyBX5XFo8?=
 =?us-ascii?Q?Z+30LpxrxQgHe5RUmPZUaywvkkCr15ejhvB3DN6q6AAfYRyl1yPfzFfn/FNK?=
 =?us-ascii?Q?SS8UlkY7zDEKcYG3qcGbHGxgapR+krd1npWKsF6eoI7I9Tuvut5slfMGZE0j?=
 =?us-ascii?Q?PXhypi8h3KVr/4J0QxG8ATySr4v343ffO+iDhWAhMkCWdlCnTH6YqWpf1O1y?=
 =?us-ascii?Q?RpumzFX7/Biwuj6/nn032+iHz0ctJr1FlH9foBgbDAVfRmxBOzg9e/tKPY0j?=
 =?us-ascii?Q?YnHyNbe491Xgf1GKzWpJihYch8TYp4NdL8GPRj1W/hFwFxfy0/jq6gKBnyXX?=
 =?us-ascii?Q?JxUxhY7Cly45xGqgEJee5cQe4XFF5G+1qe4KEWtWS7dIJbvoqhxRLBnUlHLB?=
 =?us-ascii?Q?gwPgGXDdYdxXBN9ILbkzKNYHOuuR37YS1MOzu+7sWQWwIifbvQlrHSV7fpuE?=
 =?us-ascii?Q?Gl7lcze8ioPpwV4JzxoVHC/QSjjZ1k9brNaM9iiGK6yaTSJXQ8JJVpuM7NoO?=
 =?us-ascii?Q?cLsP6zXYUc4CHS5yWbf+MD2f7E9YEq5FKkYgycX0Y9gVwkl28F8KuAdtBAb/?=
 =?us-ascii?Q?8grUZhfD9vhCufduWDaiadVjMiINEzU/4C3Gj7+kQJhAgNmBWKjFPwZ33IOt?=
 =?us-ascii?Q?OPDpCEF4FaMNk6lJ0eqNiE5Plt3Z7EQTrkTBWe8hpav0CnOwTUD+zPUvfwSN?=
 =?us-ascii?Q?1UBij3jvuTcOJOcT/fO417buIvcT/UYTsAPw0G7flGTQiy+PZK58uv90MD9R?=
 =?us-ascii?Q?yyoAqaQH8J0BFvctPQ52rVdOI/KWCXGwQrpCJ+EUCXIY35JIeoFpH6AGwvte?=
 =?us-ascii?Q?+XgwSBNS7+XxwYEUxqXAidt0YipvTeLrXpH2Go3KdSAekdIZ5ZwKNT7sqXJJ?=
 =?us-ascii?Q?bnE4GJv1GULm6ETnbuC6xCYcTVGVPYuvvtklzV7LCryOK37xeU5tNZs8vAOQ?=
 =?us-ascii?Q?lfQkV1iqWvhkY8hpWrYekaKbHlbeJeS/TKi20/w3dXZj2lF3n7b7Sedb0Frs?=
 =?us-ascii?Q?JNRDyvm1rtEVIKWY0zabDsOP67frbuNxrcQj7C1qhu6y5n31FUTrA8mh7iwQ?=
 =?us-ascii?Q?RWUkXvMy8ZQg1kXrqAHUvbDXwvhg6Yif3q/SUX3aNupvkBB6m0rO4bV8BNc3?=
 =?us-ascii?Q?+lWvHbBrQYBFVixxLA1DFzsTaVSMlYj2x1PqJL4U4GOW6auaJPcaVV0UBgZ9?=
 =?us-ascii?Q?ewVt7i8/eh9dqqTMjL2x01SutMxEgdvLNzgCQhXxjlpBwfZ2X0wT4AgpF9lh?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YBId9IqyRXYB7YiVIbzctgmRAUuao+jWajFr2uwI1mYxKS9UcQamO1XruIZopEG03XwUDDEhuK6Aeqddkz+gkWGH026c0zFD1kB78knCym0DfppJVWr45bm2GmfZ1K83n2iG8PmrW6CJE+m0UEtgaTqdocamc3f7PXqr8H2Si+VjSHgL2kngeXnzCQLv0DVllghQmCRoJUsD9CIez27YMIIwN0H0v5iIXqwTLwrtmogeCxkkBYebHwZmgpLctU/UAs9YbQXWdodKMQ2ne+RU55/FkO3F7J1FLxEoAXU4Vk/s6xg4oIsh0avGRledakVRwFuo99bC0QMLZcW8Zcabm0K9C3tx+4QnqONdZGbexQDHmZsA5TLXd9qFhCnGoHd/0h02a3lUEp/hliJwUhWo+FjGHYMq9tjwmQpddptUlI0he7CCsF9tB6Fa8Ls1Sd8wDj0T1sBChZUq0WgMi/W8mC4Y6vTRE2LURIJAR+4rKbyZW/+5E/E+qomctSAC0gPYtpSuhsfzA10UVWuybR03Yl1u7nPTjgufc3R2lZKMRUo2cCohk9GEGcG99AAL0HKyo7uwzBTqrdqaDSrJ18iLjKgDGNowSfS2Ibmyz5zZSm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0f51b5-c882-40f8-ffa7-08de22ce0503
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:02:17.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVdy99VfStrWT2mavxcBhPAF5g0+fwPYoGHXGwfUlp3kxuPDHo69CKoQXay7Y7zlSGMSBLAwnPXsFlYTkItyhkHZ0sSkgX9D03hxzNpvJpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE1MSBTYWx0ZWRfX5p+FsA5ccG10
 3fbcP5LK3XuRoE7LmqCJAFwPkpdbl1nr0a3fvVySUYvy8HyDvAlVqeVKwMCMDe+xO6x3OXPa+9U
 pkZ13AeTOovI21O0DhaG7QInSeaYg4UJw5wIbGojaDounI6jBU6x3Slr8sdYErVdLiLFbtZqo95
 wu7tbkPV8KOvUdqowtYkBXUQ1zBYxX3k1aF1zg/PQyDCdiWg5up60C1qHbI519DaYXg8G5JwBDX
 aqDL8HaK8xiBGskMwvh9Sp+p6a+n1VMAI/+Y1d8oTLw8MwBrx1/TlhGWQ8Ng9Cl+47uLwfu9C0X
 XN0m7aVxxIdocDniu6cgEJBPCEwjRGL7MaD/MYw4c8EsMAUDaqnWnX0GY+yKMM+kvgD+desrrfk
 DntEq5foU270gkHTe+zOPS1gpTC3Fg==
X-Proofpoint-GUID: WvEwNXcHMngDw2oVeH-Oh3SNh6hiwA3t
X-Authority-Analysis: v=2.4 cv=ILgPywvG c=1 sm=1 tr=0 ts=69160110 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=m4Zi-tyCpbIv3iXf_lYA:9 a=CjuIK1q_8ugA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: WvEwNXcHMngDw2oVeH-Oh3SNh6hiwA3t

On Thu, Nov 13, 2025 at 04:36:01PM +0100, Francois Dugast wrote:
> Hi Balbir,
>
> On Wed, Nov 12, 2025 at 03:46:33PM +1100, Balbir Singh wrote:
> > Unmapped was added as a parameter to __folio_split() and related
> > call sites to support splitting of folios already in the midst
> > of a migration. This special case arose for device private folio
> > migration since during migration there could be a disconnect between
> > source and destination on the folio size.
> >
> > Introduce split_unmapped_folio_to_order() to handle this special case.
> > This in turn removes the special casing introduced by the unmapped
> > parameter in __folio_split().
>
> Such a helper would be needed in drm_pagemap_migrate_to_devmem when
> reallocating a device folio to smaller pages.
>
> Could we export it (EXPORT_SYMBOL)?

As a rule we don't export things from core mm. And certainly not to non-GPL
modules.

Unless David feels very differently or there's some enormously compelling
reason for it I'd really rather we didn't.

Cheers, Lorenzo

