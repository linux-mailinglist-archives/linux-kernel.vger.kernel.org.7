Return-Path: <linux-kernel+bounces-789055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CEAB3906E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2887C3676
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447281DF254;
	Thu, 28 Aug 2025 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iBGJeofV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s7BzUjOg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C34A00
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342878; cv=fail; b=Bqi8dhzDOkryjbHQ/hL1tl4w7hs+yBa0loBkViwSU4pLu3zpzZc7onHPpnB8NsyF/MrwgHcSAOTYqQxC9nyGGMcddgJUgf7URPvti9T6UHL3VSvHPcpipeY3KYLa8WYQglX5+Jftdgi/GjAZHLFVupK3XRrGLHtsG2EBKivBqzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342878; c=relaxed/simple;
	bh=hIuxHbY17pqHWw88ueiUIFawcIvjNmd/FDvwybj31x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CjyKJZ3q+soiELlmqfb0ZE5lUq/4SqY5LKG98a0y8PJpPD/S3ggOQvpIDW4pV7qbbnRzFWROAW4mmHRskCxwd9kCroCsxA43hsjWQRyR2lM/r9g7MknIPoDDUF9c21EoD216u59qIaD7M/WZoJdBHg5M4afkfafGMCunVd+er1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iBGJeofV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s7BzUjOg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLHKxx017481;
	Thu, 28 Aug 2025 01:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sS2K0YNgtzLtr97rO9
	EXI59jp6M7W9/07jEE8Xximik=; b=iBGJeofVXWP+gwjbgbpuCaJtjYtjUrAk3t
	39gopIb3sM1O6gv3k+ydJoT4Cc4j/9cNiI+1HyjMSRcq85DBB1ogz/0Z/M9UPmui
	wWlknqPVsoHXzPNLJYHRuovfLgxOE8xPSjM/9zRr/zW1gmDUXSUM/T3Fhp31OzEW
	Uia2fTJ6TQCT7emtxbW7mLCfkwi4SBUMJe892MP//smzTYGB9FhijEVLAfTOMkca
	25GyJk+iidonEVFy7TyUKtwfwF9lxIAuSORlWuE5Wr9jN8GyxBOIREY4WfpG8vDK
	dQ7/2JRusV5j4maGuT+bqDl8yVuL40vuyGszQ4qxqI99PWU89fyw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48eqnbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 01:00:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RM39jP005292;
	Thu, 28 Aug 2025 01:00:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8bh1bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 01:00:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wd2mP+y44u/pKHskIsgx6q6EELsVC4owWok6LB3xo+ZoqmoyCkLCJ5tPW31PEc15bDP3rMgnQF2O8+66OTJG4x4q/jM114AOaa1m9ngrzrY9Rk0fJavEr8KeXS9ECfAelZYWVKr8FSgPMRbeVwFq0C5qhgLZH6QX9mPBRGP1TfuXqul+0M5n+lqiqcWwVdzYO2ypbY8b+n2xmy6he6WfrQwrg7vac58uMzTK/PEL8m6oVnyxCJnQx6uT17WGrv614NQ0aulAtpg+HTNr/r8o4VY80+tMHaUHkcVOnWfol0sfpOfY21t0PD0r4EIurT/AbfNQXKG6wOkGE8HgpBILxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sS2K0YNgtzLtr97rO9EXI59jp6M7W9/07jEE8Xximik=;
 b=kzYHOmbpqAYom2Mlrid0AOAW7hfBK4yZc4fhuKMSYAZKMGt0WuaDrkpK6G0GmF9kXAIuA9ki4hqrAGbz3jf+IVVj/KZUQGT66hdi2bHJi2DQ5+oSgLFDbn5naQ/6oJz+2I6MviMAnjo09UChQIIek+P7z5oJ8mOg4c3DHoXyw6tKjZPz68mdTFffD4q78uL8pmMcTOL/rtNp7t/K/oVnbrip/wmtOjIRLvXCS/Qb/fDNDA6gYjZYYHbGVRu4PIhGr/7w0r+LKIt1f/fIYJgZ5VQ76Z1D3uygH1d92xCXL7HhwugwFxr9fUhyjGuCu4k6HdDtYoePssQgPaMw134tSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sS2K0YNgtzLtr97rO9EXI59jp6M7W9/07jEE8Xximik=;
 b=s7BzUjOgVFSscfYsKGEvispJn95/AnAVb98DAW9HRKXx8uHdt1cgi2eCdhGk04cm7lL7dZNVi/WWJu0MQlWgBGf/Qh+wIDk3woLZ4fDs5FCRVRazXmJRAL5/PH5z6cwnH5NEqprP5yGfoWxVA80eOvL9XKgGdLTIec0+1VWm1wg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB6750.namprd10.prod.outlook.com (2603:10b6:8:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 01:00:50 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 01:00:50 +0000
Date: Wed, 27 Aug 2025 21:00:47 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] tools: testing: Allow importing arch headers in
 shared.mk
Message-ID: <zef56rw4gqlj4ct4cdx4eohnmtvi772bal5yemw56rgtd6x6sm@5sireezjvfjo>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Brendan Jackman <jackmanb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
 <20250827-b4-vma-no-atomic-h-v1-1-5d3a94ae670f@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-b4-vma-no-atomic-h-v1-1-5d3a94ae670f@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0282.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::28) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 50de5aba-241c-4f55-d84e-08dde5ce546b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yl8MBCumSWMkTw3pL4IvcArxtwpmb9cSy5qqy0yzTXn7ex4QhsCT87rUWuZN?=
 =?us-ascii?Q?FLPgp+b1VIWRmawPO03P2JMuaE/4IGhQbUzL5iIamMSJr6cHHYetUNfegs/n?=
 =?us-ascii?Q?ICRfRvnrck5yeIpM606ObAEkT+exbEON4cDKKJtyEesyjOUh/HNVJcJBAt7s?=
 =?us-ascii?Q?sHwS29oEUa6f0eK3pIkJ2xgulFSGbf0IcN6KJQORdqmKcosun4YsrBpa4tPO?=
 =?us-ascii?Q?DpAG8lhkG6dQ2Ljp5SJgj14VnQ9gyp1gyv9+9lG1zXthxjMDNk0EHT2sh+K3?=
 =?us-ascii?Q?1VIXh77b8m6tY7sdvGeMjyl5yVK6Yd1xgypu+j89Wii21DPn3OI+taeJYY8a?=
 =?us-ascii?Q?UaXVNLHOwB+kflnR/N3njrJ1+g5PrW/qMjR4eKIcjHoFzekKiPkjFh54CZRr?=
 =?us-ascii?Q?JvRGkv5/lE1XMeli/mtFmSjKqC9qc1GryCcywrqqbpcitNQZpIJdR4wJOfIS?=
 =?us-ascii?Q?1MDIYq94EhEaOWRpl7s/+7OFNfdXWGWmMOBNGBs38pc8gYYKSMEgx8g/sc+0?=
 =?us-ascii?Q?/J7Ikifjzmx9Pp0dc4A7VChmgyo0HD1cpwK7ACp2zwfDJIAuEyJ7UIU9MJR1?=
 =?us-ascii?Q?DQpw5Br5xKmLQAp2tID9YXTHjIJCfChmPP0hqJABxsL7RdmI5oj/LFzFazBJ?=
 =?us-ascii?Q?5vqTl/UrAqVyHmxI1TR5Fc2MAT9POhW/mrtf55d9RhGYbWJcu9b6pOmBAsIS?=
 =?us-ascii?Q?OuwgHW0mJ3t72Wpf5Y0NERubtf7ICujmkinVMiGKVYZMd+aQ+EVZPlkGw3TU?=
 =?us-ascii?Q?6rVqfRTnNpG72VaFlG/3oqAXt0RMokx1c9cyhPH/xTrUcYSx1Ez60l4sQxO1?=
 =?us-ascii?Q?HBU1QtDedmhgz8OI3ErqRbwemaBLtghE8o19OhQhquCqPxb5vBd4S13P0hqx?=
 =?us-ascii?Q?WVqWtv1xzOKzVC4thQuvKb3XCAK2LIpZju85Ki8hYovUj7uM/xXh2QaLTBBb?=
 =?us-ascii?Q?L0e+cLfQvbyqLZFjYzsK0a4QZ4m7T9evWOTh/DP+Mkh1pwQ3i83hJIgyox0/?=
 =?us-ascii?Q?W8Fk/dfSm01YDg0lS9tSp8cna8w7NbZ6DSW4ulxasv9wdB7SZKPwHRUdQM74?=
 =?us-ascii?Q?kvVjcKeyM98GD+6xQMm+/WTvX6QlUFtz8ZcawQmMPCj8yrOgY6yQRbMO1WSz?=
 =?us-ascii?Q?RWgHVkWvYDo7Mx7MBx8VOBN0c4UtVPa0WJbbywzQFuLrWPG4Ksn2HdfSGIwy?=
 =?us-ascii?Q?n9bEKlESqyFigCuavc67dDVoQQIvuUOU7Z2TSCMOaZT8dVK0Go6iWuxbJf+T?=
 =?us-ascii?Q?6ukaSKVjBTLXfpGIzxkDwUs9bEfOgk0V9uh/nAcneheP7SZ5ORIkFByqQAOA?=
 =?us-ascii?Q?1NG6MoIrlE3IKEVK3p8PgtOpApSrN782lFLYl4Va+SdtT8Gy46tXFk5uW+5O?=
 =?us-ascii?Q?s0HtOiheXzGHUj+TUohB+JxzLiiPNXtIDukb6/AdlSQ7TNsM+WVRfe5WuksT?=
 =?us-ascii?Q?hha30IR8NaY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rG2/mM+WZ65PtREEFJ8/XEWqNRMBXNd2sdMNKpXxQmL/Y9/3zQn/GKk9JX+a?=
 =?us-ascii?Q?1bOO8UOJICPsVt99v7b5/h01SUhKRsPgqNLmlDYElhKL+j6tWwRO4FbSFtBj?=
 =?us-ascii?Q?Zmcr/8MBNGEW2K4hXVQ05rmPOnnTonGq86lDh77MUqy2Ekil28d8VfsOSPvQ?=
 =?us-ascii?Q?/ciihp2+bTw5tbKgoviIqcpo2ZosSLDuUmzrp0NUYwc6FL+jQm4Ob9pTuoGu?=
 =?us-ascii?Q?53MDs2AYZBCgNYX8xTn1tJHOszIYlKChhf1PKOjxasgEXc6/HbN7TyGBmmSU?=
 =?us-ascii?Q?g2A2afzt+IRbUiWA/GQ4cX0iAooFd2nTPfoppRVW/dv2uFHoiGL4evW7Cpx2?=
 =?us-ascii?Q?w9A8xhDC6SB2XQAK6IOI64HPWgdGZvL8CyORv19qJU15RKukowDDDd2zcx6Q?=
 =?us-ascii?Q?uF58QcGzusTFUkjZUCg59x9G/7feXafGQfHPQX/PkUC83WnLZUZXgzdzEWis?=
 =?us-ascii?Q?/ojYNSSTkJbcCkzyrzh5Epfy/v+AAvjlaKGWVRUoPoCwfBKRK0gsOC47EL1T?=
 =?us-ascii?Q?owIG/P6QtmnnLiDrmXq2RL8NTjn+Im5ZyVgTjEq274QQLJcHc5b6luNZrDlj?=
 =?us-ascii?Q?zfn0e0f/i9V/fRv4e9yZ7UFKHKmP72c3ojzXDL0OppAf39+QPuXYqUZIy4Qq?=
 =?us-ascii?Q?Gm/9WhO0Y44iHSyAKAzStyMZEtEiyUnrQDMPjgoN8ZeHEI8b2vyNblrDUUbP?=
 =?us-ascii?Q?WvL7M6ndFraVOpuPUALscs8mNOOSVStLaV+Spe6FumG9N+UA6xTYpTjjm8gW?=
 =?us-ascii?Q?g3J6EGgGWCnmObkb28ntIobjjxF4W4FeaUs75+Bb3HSIR5Puhp7US3DSh0Fk?=
 =?us-ascii?Q?2cn5hX23KNabe6FNT6mp+1BZ+TZN53FcXNDrt/KOM2s7IKvk6wTEHFzjUwdA?=
 =?us-ascii?Q?ZCW3DnVu/fZg+250iKAoVDQrfGFQxeal6ECj+X7f6ezm5UnjBx4ulXpqTehd?=
 =?us-ascii?Q?+0b+5Efmu41lMCZcDvslmDpGsPuIBWSfnqhyqxIokAaQ57Azs72vPrVEr/p4?=
 =?us-ascii?Q?4WKg74uRbuluxzGNEIVXX2DXeOy/IYr51My18FefkG2aYTawDIH584UIEpXq?=
 =?us-ascii?Q?4kQ/T4g9w9nwcS9Mi4/LzVEEfY4W49nUb2gwfYQA/F5nhjKZN0RApX2tSTuY?=
 =?us-ascii?Q?LSd5096bE2Ky8NTbprcGwDOY60T8ZvFydL3L2yDF3iSOMs7fQld66ghGrgq1?=
 =?us-ascii?Q?Zeq/B/BUtHf4bIpmQlm1YGmnPQj8WuqQx4VULW5k8+etF+XZhaUDlqJOube1?=
 =?us-ascii?Q?SDtzTFnh+CnJd0wh/oZxSWNcAvExEara9qNF+uhcozqvUfaiJh8nS5rw4D5k?=
 =?us-ascii?Q?0Xn8QCdlChHkAzcNyOfD/4qMziWGAAV4RVf4tdyi3RnIpqb34EK7QWSTdQQA?=
 =?us-ascii?Q?QYhqF9Si8V0evSrvARsWsGhDKwDckNs7p1BxLZ9+HL/nA2EAq8yzN//zmUaZ?=
 =?us-ascii?Q?NDAv7M3k+bXjQlIxOY3f6wvKSGnJf2AQqlvHJO6crAF67cxiWfu0rOTeRN0n?=
 =?us-ascii?Q?QQQrqPmsaUsAxlHj6Tl0WEQMoWow3fgY924LRq1XjWHNQFWJaY5ZV2UblCiO?=
 =?us-ascii?Q?mUKcTXYIJSsxR3+VF+vSJNF9CEU9yJAKYxY9iPKTVPrgFlZ/gts43UXI7upq?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eqk3eN771xzblFUUlgWSNkTgBivWUGhcnzPoLdX8e2oqNGKA1ypiIk6dGE1ZQflL1y9TjKeuv8n2pZlFocWt/X8guC5K99DdknN3Qw98C/t+hnjcZDXqGHAfIIEVrUdK7/4emcOov1JR0g/6hnguuv3dJ1T9aAUEKll4G5FlEZ0fYBr+el1FA3btYL+ApgDpuBMe80V5m4+gB+K+j88ybqrwvrOEE1MvteyTBHWZoX9s1PuEbrVEDvL882V0abqV/v8DBUjy8PiMQbe/DpxjLrxyGY6vYbqJF2rJOsIXtY4ogrqBeXiAxjzfn+N59BHiyQ8IVeACDA2tNxJdcwJEKQI+TkGtWIFr5YvBzrCERIDN8qdol+Kc1A+FeKOSeB0uWwUBNE+60wReXGzvWYLXewMODmlk1zqFTxXAaoSyhlsOymvxIFoijyiwXPPdXD9YmB8+ra7gmM1Roe/pUCURFRzu+DRCswLxk+Ck88mPKKySl+HDdzuJcsNJV70LvOwHRS36UouSvh6+jokuQQxl9jgJhMThMATET/lb1wZVQl+MMiJpMuOD+jZBzg79H3mHRinWMrM5O8PtriPPz4w+mM21+Iq5IYKL0OgLD06A3Lw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50de5aba-241c-4f55-d84e-08dde5ce546b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 01:00:49.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3HUDxfAb5niIcLVwkhlQusSkymArkzH7TOs77QBQxxDHBnZH5U5J7VOqCZOmZo4eGx6bxeRoygwikJQsV5opA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280006
X-Proofpoint-GUID: ql41UOZINeEjBbH0HsG-ooQbxIQEPQGy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfX9rSPtv+Y/nUu
 AhBbkJm7v7KZ8PTIRsNWbfeGfXMIiihrWzMN80GRVH7bu9r45nkWhIGxOqNEwWRi7mvv/rW58I2
 Tl9LhUpIWht0qEk3FfRh80qHNwZr6gKWF+kS/p4uRQdJ5suv1hjY+m0LjmSnbXFxQqQhzQUm54c
 Hj/VNM6N+WK7Ebn4riq8q20Jbib5AYdNN0olIA8RejyltB2MAk05nhKGbP2bcu0h0FUVFZ8NJAj
 vnNNiue9YQQrp/TbKYcld2XzlnfEcSGu6OZTFkBBv2p3NNunsoeM3+x4c5DtRneKLN8pDVaeoQ+
 UeENycl/Hhw7IArUmABeNKbuBaf+hROP2RUAY/9J5qHnd00Rl0lcjrL7/pKkFELKQpOuDrny4Ar
 HWfITffma40BdLPMOK8tZUmh1WNtgg==
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68afaa4a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=LPyVwdBBitfx6ZMO_kcA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068
X-Proofpoint-ORIG-GUID: ql41UOZINeEjBbH0HsG-ooQbxIQEPQGy

* Brendan Jackman <jackmanb@google.com> [250827 07:04]:
> There is an arch/ tree under tools. This contains some useful stuff, to
> make that available, import the necessary Make helper file and then add
> it to the -I flags.
> 
> There still aren't that many headers so also just smush all of them into
> SHARED_DEPS instead of starting to do any header dependency hocus pocus.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Thanks Brendan

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  tools/testing/shared/shared.mk | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
> index 923ee2492256b693c5cf16cc014d9d2410be5457..937aaa7623320da1085a8e0f43f6a728ddd3ab1c 100644
> --- a/tools/testing/shared/shared.mk
> +++ b/tools/testing/shared/shared.mk
> @@ -1,6 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> +include ../../scripts/Makefile.arch
>  
> -CFLAGS += -I../shared -I. -I../../include -I../../../lib -g -Og -Wall \
> +CFLAGS += -I../shared -I. -I../../include -I../../arch/$(SRCARCH)/include \
> +	  -I../../../lib -g -Og -Wall \
>  	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
>  LDFLAGS += -fsanitize=address -fsanitize=undefined
>  LDLIBS += -lpthread -lurcu
> @@ -11,6 +13,7 @@ SHARED_DEPS = Makefile ../shared/shared.mk ../shared/*.h generated/map-shift.h \
>  	generated/bit-length.h generated/autoconf.h \
>  	../../include/linux/*.h \
>  	../../include/asm/*.h \
> +	../../arch/$(SRCARCH)/include/asm/*.h \
>  	../../../include/linux/xarray.h \
>  	../../../include/linux/maple_tree.h \
>  	../../../include/linux/radix-tree.h \
> 
> -- 
> 2.50.1
> 

