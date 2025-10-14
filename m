Return-Path: <linux-kernel+bounces-852138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F2BD8413
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06B618A3535
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC3D2E03F0;
	Tue, 14 Oct 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IUUu9II+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BF8axNKM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599B027FD52
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431602; cv=fail; b=j+tLYfs7BJQLit5yc/oWYLyocOQIWGFKZdvV71aZD6fhsfWRmz/U9K8vZF+LOYQhKL1x1+cMCWQQ3fJoV2w7FA4tSmhDTOdzufQY92N2q2I9K742h2jhvW7pOkacZYX3OSrSh60yFryQ2rPDB3xRaZVDgNH1MdUpK1eA9OXUlwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431602; c=relaxed/simple;
	bh=wPZm4bqCOPPDWlTTl+pIowr3RmPM/bq8VCUb9C3WQ9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LwQCDUIiEQOJzzdztk2e2mh9u2020D9QJQcpcFO9xgUZe5vvQt/HxCMKXT1y0ozsb0lff3LC7MwSecbLRn1AWUTrHyxKMAwpNuILkjpqofRGSEGCzECiTyrCRvb0sAZd+rKXJKBzytPDpj2Ws7jiaZ9kZJwhGx7aBUOkUwDCISY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IUUu9II+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BF8axNKM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E6Cmxc001497;
	Tue, 14 Oct 2025 08:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4x+PplJpogQ5qIloTj
	dnmcyLVQCaX+NB4rsubEM1Nk8=; b=IUUu9II+tqP6Y9H8IXyayn9WWSAgcFWn/H
	YMMGSlbZIe+fFhuDnL1ZXz8bTVFpPuA+hVupqhFEnN0KVnjpk+F5fxRHW+T7w+qB
	bQd04KEZFaTauCFFoZ6ZQGLG4YMg+SJtBpMg0E84ZEsFeaAviWkBOLG+TeENDRXI
	uOwxkYrve8nTdEdl9/ceJxYb2Gn5cjazv6XXj37FPpd1bzzIUmQIMIOihsXE1GtK
	fS27e6lNhQcNzWNM8GCFY/IixVBuoMHrLKWFkNn0GNoV4SrHRXd/TbcQWEpsr2D9
	b6kAwsr4oAyIDWb+2RSyCeO1HWuZ5sNK1a0z1O10gLZhvJRBWJCQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47kth7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 08:46:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59E8aDhP018017;
	Tue, 14 Oct 2025 08:46:24 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8dvdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 08:46:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVzr06nyORNc6ADR+GywCwbyGgUkaoqA9D0Lk83dEzSeY4QiKjPHkl4obSu/f1gCVoLYTDgNwMWEDG3JhHIzq3v9JV2JIPdVQWuFDA4d14uaWjBhrrc9qfiZdVhcfnsoDz3yoUkWM+N1fdvfXujMmvqN77qMeyWLXjWtL1fGLR0g3S7s+YyxZbPDlYJB5urWScMB4d/frneJ6U0ckq78fhSQPUv1tqayq+9SxFcQE3j1IfDaZOGKIzg5FxaoOXCLyWFmoB/pVb0gXOZiLKwwtWCB2HGC+9xtaEEFHtioYpwJT6/wu5+9OJm2Yz+DQGE1z/IwxGQeUrJYpUYBw5GDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x+PplJpogQ5qIloTjdnmcyLVQCaX+NB4rsubEM1Nk8=;
 b=VbeTDG5zvTUrRKR0JGMLxgopZD3tuxfUx5fh6yO9E1LDEGWWgX9GkYHygHsQtrXIchXSwxcciS9QLdhsjzPWxYXycQX5dwuw7Y4vKAPVQXk/Eiggf0EE7iM6ZeDUI9b3whowwlKqIcqDiN5OeZ36lWJdeOatna70AupPUBm0rt4S01ueZocGVdON2T2XDvtc3O8KXZER0pulOgzFOywaFEqFVWOsIJEJe3qpnwo/GYH8qRPi9XnNUlioh4jTEvQHfX5UBGIuOYPqlZ3eDGpGq+ncWlgJwsmvCwGSuciLEu6Fw7xpcUOQOP9Dz0dcJf/sNPku0/2EaxGyCr1HWw/dRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x+PplJpogQ5qIloTjdnmcyLVQCaX+NB4rsubEM1Nk8=;
 b=BF8axNKMQAKlyiK7lD108Pf9zLOX2kUqv3DmUMxB70Dg9sLowVDxVDyUuLCCVuRLxKQ81u++6eQ4rEYpopyf88BcAbz3jMgR541sB14iOOZ6qUefPL83HzJtRgd3uT/1xJAw+2jCb9OyYAmJWcIpTKHj41xrCDr+DJDiD5kT8DY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO1PR10MB4434.namprd10.prod.outlook.com (2603:10b6:303:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 08:46:21 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 08:46:15 +0000
Date: Tue, 14 Oct 2025 17:46:09 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] slab: fix clearing freelist in free_deferred_objects()
Message-ID: <aO4N0Up_g8JvJj9x@hyeyoo>
References: <20251014-fix-freelist-v1-1-e402301f276d@suse.cz>
 <1dbe9c35-9ce7-47b5-ae32-f406bdff58fd@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dbe9c35-9ce7-47b5-ae32-f406bdff58fd@suse.cz>
X-ClientProxiedBy: SE2P216CA0076.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO1PR10MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 7611bd62-61df-4a34-c080-08de0afe2265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5pfDNOpNOLERlYivXALfv2DXntCLIzwyz6KHOB/u5MVri/SdcCIHn6WJtmQS?=
 =?us-ascii?Q?M8pe3YJLVi3pIgrMmc+02Wwc+SWTN1q+AN6z2FJ++LnkztqpQQ8FPPiV5K8b?=
 =?us-ascii?Q?ZkXbIKk6xiEJH+b16SMyPCgT5Fdm8P3iXnhxPf2UGynA4zVs/+oIJ9Q2l3f7?=
 =?us-ascii?Q?N6FK54OhKZ0BdC3OimQQYfTU2HBOtvLu6iSNZv+fiqAA4xHH8rpPiUHEid+x?=
 =?us-ascii?Q?Q6pFvBKrts563cTInxfIn6DPByViiJnBz4RpSfJAWaouspaF730pyLFL+7xF?=
 =?us-ascii?Q?QlFv6lxdAD9vbbVgNSBpYBvvnLjy8AGLUh0/QOxghaceQEnuJSwV9JK/8DG+?=
 =?us-ascii?Q?iGkl2UOdm/D4FbldvIue1Cp/upkO4TRN84mSy1wOqKJUQVnMy61C4adZlbDw?=
 =?us-ascii?Q?XqGpxNz9b4QxisjJC4Hcx6WONrUqYQa2Ia4Kg5ki4ZLbS7ug2K/GOPzx2xNu?=
 =?us-ascii?Q?bIdwJLhpwyLdTGEat34E4XiA5pRfgLYHKviSn27F2UEoea47Q/uLKyOtmiLd?=
 =?us-ascii?Q?jv3unvcvOOuiJkZi26ZkvF/Ii7eodPHMGqe8hykFMeHtp/4oVSAHLmaFSGRD?=
 =?us-ascii?Q?a5fbHFvSlAFssLWw7wgHRLRq31JKVWA6V+sjm0Ym71fsjtTqMP6wx3YAOu7+?=
 =?us-ascii?Q?6jt6dNLuzfMHB1l+Fejj8YpSdyF74UJmjaV0Dx58t4yLGJHy5CBCPgudQhQ6?=
 =?us-ascii?Q?iZ4vYDZVhtCDa9dwLwMttWQaIk+dLV38A2fNq9PEBAUXgHKTRR/MDNVAf86N?=
 =?us-ascii?Q?ySmemcyFWzv4EVKY7B1xXO4pyWUx/lrhfwyJCCB9M4TWAxAYl0Dxu4xjb9qU?=
 =?us-ascii?Q?Kja95Q582iL9NoCIXvCExbE0lQCp9sIifaESjgJRgyhGFZIeVkG9Pj1fOUDi?=
 =?us-ascii?Q?5uQBkQ5nwcTPmx2iCaaQIhQYh2nl/KfA/0OIUt5DwEkzKD87IsH+A3sZAMLp?=
 =?us-ascii?Q?9hM0pG7UV/6U40YBaCvn7V2r/TUBgORQnCug/AtbyRLpCrHXfqxuVvF7O8sT?=
 =?us-ascii?Q?8MrImsTVUKZ1I/L+bWNSCiaG8WBquSf/aEy73w9WOc1qgiqBgzNqwb43psUQ?=
 =?us-ascii?Q?OMHErpC6AkE0Y5Nf/YGSgdfqgIbvb8Cjge3fjLtrsjmDJqhJFCue6VCEJci1?=
 =?us-ascii?Q?DTfP8FLUwJC1GxPeeq437Xk0fz5N6PiCzpCld/ebtqpOAV5v5DV2hk4k3VxY?=
 =?us-ascii?Q?/fqJ0pctR6l5zv/kmVIMthhE7xuA9g5ImWupgcp5OP925AGLWHRIQkyBQcqU?=
 =?us-ascii?Q?ARw0L2R9Gg6NFC9+dVg/UxGGm0rjGGpCPxmH4X7WQ5Pmt1dOu6PnajG7SN5t?=
 =?us-ascii?Q?1qOC78WijFJzomnDxLyeeK43joCHlxCEKoOJxRJWhWKR2qG5aYSkrlq5a7aS?=
 =?us-ascii?Q?JQ/KkCg/WkEQj6GCn2JL+vj0/i0o6DLPfZNaAdCm6TI6Xj0mSPIP8j+SqGh9?=
 =?us-ascii?Q?R4FxRL30WBBdzErJsBW+3jkEJQPjvPUPKSGSSbYxhsTNdWtRZlqaAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kIHT8sDDdL68jWefKZodqkyU7oJfmv9ee/FI58H3rY3lMkvUCKpQC8pRbtc0?=
 =?us-ascii?Q?IPIftRkBeh945cHU/BBWXVhDmdBQXqhCA2eadZCvkWY/xxZwxJS810IuFLvR?=
 =?us-ascii?Q?zMVPPO9mdSy1VWPVqScweo8KbKl0dC+aJU9H+fvUP7+RBSigeTXyI5B588nO?=
 =?us-ascii?Q?Bl2zI7qu78Aw0OsPmzJKvwOifmdndI4vGxK0HCn8rns/WgoLa5RECrh7ORhc?=
 =?us-ascii?Q?n0r3dveSeQDG1ld4LHAvcXEox6Qlivm8+0RSqCKBIaZcDy3j4H6VMR76OVJd?=
 =?us-ascii?Q?W2RK/WieaoqivbMmiMZpFxm3YSimLLDqbNbWjce+MvYDb4g2J/Ic76x5TFjp?=
 =?us-ascii?Q?5AWs3IXs70F5YV7vLeMQ1thu6PkLxLn0lzerCs7Ah2dp2DXvfG0cacqjp7oF?=
 =?us-ascii?Q?CE9kF2SBhrWr0j5d2nmp/km3/amw+6HhdRPhuoDl0D8dApLDkUDvYDc7IQuc?=
 =?us-ascii?Q?i2gLkw0GF9is8Az5qs3gJeimEJRznB8Ma5jiff9nsl/IALpFLJ2Ls6ypyMGl?=
 =?us-ascii?Q?oKN7R2CKL60WZYXm/SlyVKRjvejlDHhjK+Kkp9/DI3EAONFl6gPI/5OrymMe?=
 =?us-ascii?Q?OdUG8SABHT3lglVqcnxPKDmrO7dZBbD+aEKQhJQcZXhUxX9pufSnxSeTh25t?=
 =?us-ascii?Q?1XB7RwLESHcPmDtQpASTPaLrurMZA2mmR7UQixmTigGu8pSfrXK4BruH8pGo?=
 =?us-ascii?Q?kzSAhv8jYgWaZWNj+MmWK3Fc+oSyOAKWyvj3YjBpdddJSi6q2ct6j1493u10?=
 =?us-ascii?Q?ICfXkvssk6U8Z/S3tVG8uijz7aGb8zTjpc4d/rBskxwsnQJd0CF77pfzFf8e?=
 =?us-ascii?Q?Y2Ji9n0g3My9y8xGCEECkXZuecgOndrPEIatT6Gpy09ukushOMyoPWeNbs2e?=
 =?us-ascii?Q?huyXLmbKPeRltp2cfSrIp7zjphAUEGlMeVZPDs+6iM+McvsC5Wd8g8adHekX?=
 =?us-ascii?Q?cEKi+ci45fFNLI3mwaxxMqa8LegEOTJYWiC4uq8MNL3lurGzi0VR23aJDxzD?=
 =?us-ascii?Q?Y+9FDTs575ExpTJqBaVcz1IRpaAjUdeY1477ocTgEijnpAdrwGHIOAEVnYgj?=
 =?us-ascii?Q?ydM1wPBaP/3catm5uBxgBFpr21bdLhEnjVFKo+gqrq2ehDO7Juph5j1EfjDZ?=
 =?us-ascii?Q?UTDv60/2m5qiqAYzQPSX94bB3JEeR/gWfeiorGades2noFnOBEduywPRoPLo?=
 =?us-ascii?Q?Ib+ZuPuW02tJT5Nppg1IYJDNBHbRAn0VOQ3uZJ4x92BlGzeN4DfL7hh9aUMU?=
 =?us-ascii?Q?wVGANjG3OPqyG6aooe9+5AzrjiNvcnXt3jPXoZqElY9d+6cHm1p3mSJCaxxF?=
 =?us-ascii?Q?VBwfzWEfGUsL0QX+mGe7vpPHm5A2LP1dVkkpe5itqjkgSP/1AbrVNArCmMa8?=
 =?us-ascii?Q?b9s+ptAf8vU6YlerY48fhKGdaacYyg2banRnvjODBxmv+eojH8VAeEVqzKKT?=
 =?us-ascii?Q?8bNDnZDbK74f/lxlYZeGO7ae7Ly7Azs0+g/zO5tA0vFfW28iY6vG1EdVNlaO?=
 =?us-ascii?Q?cLvXBTfy6BQQ7814T5LW7Yrwll3zT0m/sRp34smQNbLoQxP9T652u8j7bENT?=
 =?us-ascii?Q?KEbEIRuF+4Km/3DR4GGfmoMzdfi2bx194qTSkz9w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sC9yeDiEp9GWRgjQZLHp4iw1Y3Epr+TOgYeEkjg0IBnmcp4F6B3NAxRP0z28RKqYEFb/9xUS1WeJzkyIE7eGRxOgtKxQUl38W92+fvzSuxzyYkPWXTrpn18ub6tax4yaeIbJtMTk3MY3hyyd9+L6PRs6gLn4bCKrkXKvG0bUAAsYWZCnwNwlkrBf4aI43wQMjma7Vfh0vEuEFjla8k332A4FmVq9aI3eApqBDZgZam7S1RUaoSAZDdBLM7cVUsRIzwLuoI3/sckI2+uoqVng8MO0mUUr9xRqWN8xPTL4ICPp066IA2G5LItNpgiv26dbs0I0+ii+kRqVbX7WghDfjggauo0tciRADRcHXsK9v+r2R28B2mClA0W7Rm4UPJzfCBSDwfSLPgfPcThnaqTy5bvcH6KCqV0hyr4oEu03o/3SqmGgW6C2CQIsUfx2b9NeNrTHqEcSUq2GqueMbQgmZnEtUj9IubUyIC0+exh0deDVChLI7HgXLLlv3ZYVW+cpL14k7g/JFj+VtY58LYiHOXLK/45ckJkl8YaQvrHKLjYcb1qJ3yaosl8T/QOeKScFcawz1PKqxJgQpxVDACP+K7rrS9rxGVNIEx5ckCtaUxs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7611bd62-61df-4a34-c080-08de0afe2265
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 08:46:15.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcgYCAvRVXlveb/GDb8PIr8bemYS1aTrX94iCayGqnqVG0aO7a6ckT5fn/USOfLvy3/r0zNVXUwqVxfnggpXtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140068
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68ee0de0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=jkRcpMJECIUBJq1LIeUA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: qgfIkCnVXjZOIycoKsAzPhS7K0cmnTT2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfX75dRhRg3E29c
 yN22+jV0K7Etxr8EBqPaXJRVl6YMHDiDx/DGO3I7m6mlMswPTaAUPsuwiQz/psdJjro2n/UBP/O
 r15j5a9PAEqPJqt0GenstHzxORs/YPqJfFhCjamY+R2mMU6nKot7lOsPu/rY4g/DFuVwj5XpRv8
 PDwbjrj8NvgLwYwmV2H93F3BG2cGGmuPhk1dzgHSqsO6IT4nMZ6AeUOyOc6ayy5cVt5GvEr14Xg
 sMD4g2FqHEGZ4pseLtcfy7LVXu6ARP4W2NArjycfrg15YtLPLprzzaF/TXpPWel6rpf/prUM2v4
 STLjn0OkklVkX56Ci6kznNaLHg6iM4lzl/sLhBLu+BCzd/18Ea78GWkYf/k+h8z3XUqLtF+nrJA
 qUQbmcQgOjWOcHXK+khjJiURa0seGg==
X-Proofpoint-ORIG-GUID: qgfIkCnVXjZOIycoKsAzPhS7K0cmnTT2

On Tue, Oct 14, 2025 at 10:44:51AM +0200, Vlastimil Babka wrote:
> On 10/14/25 10:40, Vlastimil Babka wrote:
> > defer_free() links pending objects using the slab's freelist offset
> > which is fine as they are not free yet. free_deferred_objects() then
> > clears this pointer to avoid confusing the debugging consistency checks
> > that may be enabled for the cache.
> > 
> > However, with CONFIG_SLAB_FREELIST_HARDENED, even the NULL pointer needs
> > to be encoded appropriately using set_freepointer(), otherwise it's
> > decoded as something else and triggers the consistency checks, as found
> > by the kernel test robot.
> > 
> > Use set_freepointer() to prevent the issue.
> > 
> > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202510101652.7921fdc6-lkp@intel.com
> > Acked-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> > will be added to slab/for-next-fixes and sent later this week
> > ---
> >  mm/slub.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index b1f15598fbfd..64c17afc375b 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -6443,15 +6443,16 @@ static void free_deferred_objects(struct irq_work *work)
> >  		slab = virt_to_slab(x);
> >  		s = slab->slab_cache;
> >  
> > +
> 
> extra newline moved...
> 
> > +		/* Point 'x' back to the beginning of allocated object */
> > +		x -= s->offset;
> 
> ... here. noticed and fixed up locally after sending...

LGTM,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Thanks for fixing it!

> >  		/*
> >  		 * We used freepointer in 'x' to link 'x' into df->objects.
> >  		 * Clear it to NULL to avoid false positive detection
> >  		 * of "Freepointer corruption".
> >  		 */
> > -		*(void **)x = NULL;
> > +		set_freepointer(s, x, NULL);
> >  
> > -		/* Point 'x' back to the beginning of allocated object */
> > -		x -= s->offset;
> >  		__slab_free(s, slab, x, x, 1, _THIS_IP_);
> >  	}

-- 
Cheers,
Harry / Hyeonggon

