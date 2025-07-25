Return-Path: <linux-kernel+bounces-745737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB04B11DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D0CAC59C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732927586B;
	Fri, 25 Jul 2025 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d+K4e0GM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kNXu803/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D13AC39
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753443191; cv=fail; b=U+yKEI0VkXLoOe1N4+rJv+u1iEMxAFTXOFR/E+IFkoDiR+jz0CJdpG/Pcqf6kfays/ryJZKv+bcZAH2QqWBLSueMZbo+hCUkGbKP4yUipe+YjGc2qEzQnLi6DFtFPs/htnNtEajOvVXkLfZOIy1hlZUQ0BFT8xHjEhcA8pmwwkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753443191; c=relaxed/simple;
	bh=blcAg/HYwVxZngDT2yhVjdtP7cBBE+HtxGF3fxhthcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JOpsjFrn2nzAaqJa+DZ/RLsG+l9g4YcMzg7/+0ShNv4kHledEuAgBmQQoqP4j4koeOMXuQqLmNzMsNW2G+IthX3RLX/WRQhk/uhRSDpGJZmxNGvE0XLazrb9tYwAjt20izVH6SMsfCDltB+jXi7+mfYr7LZrlFtWUW++6P/i7Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d+K4e0GM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kNXu803/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P7fnfO015588;
	Fri, 25 Jul 2025 11:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Qka0ref8fxhtUeDSNT
	8uVn6CLy8zJqG4n/WvgHP8H+w=; b=d+K4e0GMrRXrNSRghOo//tQq/Ehx4cHTK8
	WELBa7imuhvMcrBFHr+vUTXk3oNz79TGrbcSBDJo6uBRj7FLBIPOPIq+WOhXh8rU
	4slraQRml9z9/CaOXzJqZyU541/+iuTA+jgdOCA+LjCYqzngzaDuHiuQ/LmuvzDV
	zcGmP0RJ/lCKw+zhpFFQdHQVPjIfvS6KpKZrLPRwoyqEQPUpDJDIPqn/hJn2QcVZ
	yXjOwa+9oKhBUwpEW7yKM1i2xEB0sVaR+6HiOm12LP6LQsfXpj3fJZaKjfeQ8cBJ
	+Ff5WTRYn4M0UkQzLpeLQD4tsm2I7/z7FhqL8ZFGlGFvFFPj4tGA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1h0u76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 11:32:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PATkX5005987;
	Fri, 25 Jul 2025 11:32:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tcy80h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 11:32:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PweumTTZlwN60Qu33W3pYAX3OwwNWh4uNka+D8y/IgB3rwXjw7XbJGeX0OkTiU6UJH7aWEM7HBrIKpj+hVfS0FotkQhkrQieffeyhXW5mJqqdLcDKs4daIRcOE12fl52f56NammCfP4S9wFH/BTUoL7ZofRuoE/f2sUxRYuaHpME784GMTKKtx0yTHyw0QICdi+FRmflt18SG3s8FoDLa+lyXrHfB49altZoskOuEC2dHVQkjCUKVrE+18nHjOaLwSrYmzBeXbWf0sEY75tmNKB1T7kU6f7eKDTVUjtB0/9AvMSnN4zf/lkNAlc9xVJtbmB+Wzy+wvNZOzgiPVAWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qka0ref8fxhtUeDSNT8uVn6CLy8zJqG4n/WvgHP8H+w=;
 b=IIJStSXePtUuP32wqaSuaALCq4XwUpEoWRlouFO/KT/xakNXdgRZF333+PxUX2pnsKNuGg5Y3irCBqMqMy+8zbJnpu0szCpar3/NgUhLC+4ITOyfb8XRMw0tg2aIJDJUc9RCLsCbTPDerGOvOCpr1ojSJbljbGEmL/UCq5wVb31Or3xoJXxhQIFJ7zUD47nrykrI/Oncf1aRhBNb03UraXBKuZZyyi7nF+F/AQ4DUIxJkcYg8GaDHMfnDGwm1DeZ/KzrNvhX09XQLaku49QlyLqT7MNF4Z4OsiFLH1LL6G7Ra0v5X8xuMlnGv78QcEZKo+xWMMWOpcmh9AmmI1hh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qka0ref8fxhtUeDSNT8uVn6CLy8zJqG4n/WvgHP8H+w=;
 b=kNXu803/gwdtOGto1ef1Erb/UGT5y2fqw+JrDtLnd4+rtU2yK++RRybuQIGf2D7q1oiRDgKe828M18flJIoDrrB/LsKNoJ6PcW7Iqy37RNb88NC3i5fFNM0Eynr0J3nHFTNrOeNdcub73x7VFEdIWiz4V+XJ998H5TW4bNvJvjI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5834.namprd10.prod.outlook.com (2603:10b6:a03:3ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 11:32:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 11:32:32 +0000
Date: Fri, 25 Jul 2025 12:32:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
Message-ID: <c3f04c75-a73b-48bb-b56e-7b18e57c2382@lucifer.local>
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
X-ClientProxiedBy: LO3P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 8671f13c-afb3-417e-6d60-08ddcb6ef1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yT4eAYyFSWEzTdGlKTF8CPqJjlxu6aF7FsowfN0okTlLwUgIJUD2Rl3OCKc8?=
 =?us-ascii?Q?MUmUHpCp/b/Ancl4cI0SQo3IdxPMoSrftQ73ZrqB0FS5wz7fmuk3bDjAcFdf?=
 =?us-ascii?Q?7d+FizzaFoet6QE9RgYzEHfL3CN/Y4xsAZF6iLl6F1jD46tY/jQcQ4mVYdyi?=
 =?us-ascii?Q?ImizKGlFZOd8pIZ2WXlOr4RRtnDt7Kn4Lw410ORa3djcC5VK1Li9PA4tq4YG?=
 =?us-ascii?Q?79HwGEq8U0a/YKAisHG8kbWBehEe5ObYkhG2H6+jVnTRjUXgOMGEo3v10eNN?=
 =?us-ascii?Q?lpTn0AKO5UsVZjh63/2Zkf3ZKtSDbRa0Po71hIu6UQhp4pitVo7B5uO+4XjC?=
 =?us-ascii?Q?OKlvu7iw4xbRAqorms0BzKhOZ8c+VlFf3gsgEIunMW1PMVxc7HU7op3mFuOI?=
 =?us-ascii?Q?+LSal8Kx8YPIWBxLi46jrwzZ8059iV1QQpnuO397ufzt1rIukL+TyBjvSQoj?=
 =?us-ascii?Q?JeyUgnWyIlpDOjoG1lWmmOlzapCNEcmWao5pveIM53Gj66dRIndV/r3ykcWh?=
 =?us-ascii?Q?CNSmFLukynOccTfhJ7NZUkI3cCMOrSlxx7y4Ueu3StRHLCB4qrmNMdG0t+/a?=
 =?us-ascii?Q?QiroAo1L7Fl0AmoFWYyuKfdBYcZOmn7m0eSkpDi3h30Tfka40WZ7rdOV/Awg?=
 =?us-ascii?Q?Jng+n/Pp4VQu6v2u7b91q4mUyPw6n44timZDEs6bYqP45tQx9bUCpU8mD5Nb?=
 =?us-ascii?Q?Wa7MaxXFz2QK7onFGnF+9Eu/GtNXMXwosirUxC6i63nwZl8uLPfBd+oJbTJL?=
 =?us-ascii?Q?9PXevamGAHJG395xJ/D9ftAuEcqD8Xt0EBvp3BUxH+S1hfeLhGkSCgaFi5FO?=
 =?us-ascii?Q?Zk4Fo/lT1gK6Sf1oJPq6qckr8UZqprkH2Hj5jeWbz6AFLJK7XnU486rbUlp6?=
 =?us-ascii?Q?Lwovborx2l5+xPvnGfbYKmR2HhIsICDM9lvDPdcc4CFXds8LiuFr30YeUK7d?=
 =?us-ascii?Q?FChM8QRKSa8AF9cs/sWzSpADDbJ+VqIkVTz1UkHPO59NxFnRO9qNoWo6k3LM?=
 =?us-ascii?Q?bTtuUAyr7cBGkpSTdayIcGhwfhNHw/DBdeDbgAtk1C6brYZ22UIV4hoeM9WX?=
 =?us-ascii?Q?EM+MSt6DGrLeMU2jlaB6kEOPtaNOORJZQLS4XYDQ+v1ZQZ/kVL8CCU2+18u9?=
 =?us-ascii?Q?fVVWJBK4lbi7kjM+26/7p2keXqL86R/vroNdIm//k7SjBZLe4fMnKywUAF/4?=
 =?us-ascii?Q?wHaMcaZ1VYLZ5qPVnnlG3v2vnMaet2cAYoujomLL4M8wDhr/oBFpb+PhFH/m?=
 =?us-ascii?Q?khX5iHPNeV6JSs5sQ8ndiUtg71xzlIU3s2WlViqmtkw5i53eb68y4Mih2ir8?=
 =?us-ascii?Q?vxepfVv+DH2MqRrlU8f1HCv1O80Va99v4zNVWJnWPiIsHvXxStpx5a9nF8AK?=
 =?us-ascii?Q?1X8rcQ0VE3D9eXqAo7BE2K/PQuGu+3Elw4y11Y8FjZH3EB2zSGmsQN0py7Mg?=
 =?us-ascii?Q?JUlO9dYVxbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9D6k0kGNpQ0ITIuSYUiXfHU8TvEWYMEO7U0rz5FirjEZIWWoMtB3ijBECQrU?=
 =?us-ascii?Q?AEemcv45/ZIsG/z3TrXYgLclXIajfRCQslsqv4mLg5Q8U4oTN3qwxlENy+9f?=
 =?us-ascii?Q?5eC/eP75xnZtsIBzjl11WZzF0BMWcwPznYV33esqrEplk3TQghx3elMT0TtG?=
 =?us-ascii?Q?C9Vqe9S2bTo5UaFDGnG8bwyBoDnCj2Y5F9fh1WB8X66SJ+EYdLZ4ItqvuG6G?=
 =?us-ascii?Q?LQdFQzrNGbI/sdHK7UJmcElYyq995NTnnwjMhxj9zMueW8Akkrl9br5bgBf8?=
 =?us-ascii?Q?pzMQMliWR9qHrQmXAoXqs8M1WfeEFIMZe4xjGAs5oSXl9lmGT6RoV4N35M4l?=
 =?us-ascii?Q?UFwAzssYmPkFYGZDHnfygKXGG6vo3k5WykdbyAqLYp3KhfBMG0EeJ8/c6c1I?=
 =?us-ascii?Q?S8g6bAY+d0WdwFLJxMglr9y4OPTv6hVQmdiYttj15Osw9QNT5e9BtUub5BpH?=
 =?us-ascii?Q?+ODkFbh8vHmZ6ER3aAVlwwAD1ueen8MkW1Rasc5OJXit2v4bG1R2AtqcVAiC?=
 =?us-ascii?Q?Sc1LQMyIvbcri0E9pISkMA8yRYXtLUmDYTi97g1DM0VZbwWu67oYrsdHJ1ze?=
 =?us-ascii?Q?I8NFOd1XVrwjQh4Tl/a7ve0Q43MGW0IDKvPhxSf0Y6n+zlJ8tlQfyyWuQ0M/?=
 =?us-ascii?Q?0lTDj8reX+SQScBdn0l+cXywBtZ2GBoqOfcFY5wib4mP+y550Lai8WXScm8c?=
 =?us-ascii?Q?1mzuh5k+EqMUhuBAOTATIebw2p3Cp/wXoYmE110BJFdIE90VD0BaVZuI29YM?=
 =?us-ascii?Q?3Hjoef1v26aYDgjkIbIcQKBJCTqn6nDnvnEs5q6kLawbkThEZ3FuAMY6stKx?=
 =?us-ascii?Q?qkpRMeAZm4odlb/+VhtEIix0sDxbwzAFABJDlEBbsDqXY5pvQmBw1K59mEo9?=
 =?us-ascii?Q?tevaM8/3T82MDWuxK4OuD7YRouUlKsKUEm5kJDbG75uZqmR3qw52rwF118TE?=
 =?us-ascii?Q?QCljbEcMvWGGo1zB/5vFVAXvNutfHKBDSth57lO8tFs5CtHqQIFjsQ6LDOAQ?=
 =?us-ascii?Q?j9eANgN6GgdgHfZzHNo/QO8o8ivPQn4Ji4TN18VCDzAquO72vTsRQl+/gNIX?=
 =?us-ascii?Q?o0645cZcjnoo3aERQPco/yQldTtc75MttndK5/DthlUifQEaD+E9QBZkFXtq?=
 =?us-ascii?Q?RnWJ+LATsmPyyiQR1G240jvvtw7IdUcuLkSD+Z4SsL4oyHbTGLa/COe0YuNJ?=
 =?us-ascii?Q?sDP1umy5kChITc/Zfeq71ayVAa2ulDobLcv4AHz3IrO2yRAkM8HmLwJrqfTJ?=
 =?us-ascii?Q?FLAaLZus8WgTRx4IJBdw81HsumNS4zSFjnY2l3tCtqVdgD+FX1I9In80R4Lh?=
 =?us-ascii?Q?3YQMziEeQE7PKI67FkUPyclB8m5tlNYzHhQIUhQRA8RytrBcH/JMSuuhtOe7?=
 =?us-ascii?Q?cUihBuBUo408fkgaeF50DrqcEJCeenMnsQ0obernHzhm4JMcKertw5bws9Qa?=
 =?us-ascii?Q?jQMf5TrVMhSFgs5QGG93Phi29TWTeqoeFCR3ex6UTzvsZKtYnp3Ul1d0xr8q?=
 =?us-ascii?Q?xZLEqHaAG6wK2nP6K+Beis/1DqCX0zWoQK2zAPm42HqhEB/PQZh0BixF94aG?=
 =?us-ascii?Q?IRpRwfasBvdb9eGJSmp2Jq1+cD/2CQjNTjkbr+O6ctSAnxHrTHrOoQ8I2A4g?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p8KYZ7wGQgJd4nmVVtpoXhsQ8ZERDpVpu9gENa7wLyXnle9KDzDw0EkKNfzHf1dStQ7yVXeot5zKX2fErwlJLpeE4oVE2YiSEXQPnRmBAVrD0N+33uEJQVcMe3IeZ0RH63/xwJJiFsgpXeThBoHDyElLRwhZIt1P8zYLW3LqlAlC16aUuF3G5j3GVMWf5srKkI0PKZrZT5yXJdk2/OQ6kz3t2zYkIok7GiDA3Jhsz3gEWa7e/HW8n/JmmK+7VQLjz5KM5MYaahAVz/GYVzZuLw3p2Yc87/VEO0sTnOzW7BCwr1CdpAOg4lsyq7Qaw++mZYWQo0rkMsn1qPGqdY3THg73HMklmMsa8yhrf68fkyFrjoJt59ETIHkTSLU1EYzy03FL7ZaJRERsPUtwxeW/yYDyFdope3Ch2dKHyM9PLT5VnRDEzl1DhY6/f+fxDMMsVsJTV3osS1567MgnnlCwGM9hmjyGW8mUgduCKs+m16CL7jkDPhv15KSFZXee9tYT442T4figqnUpHJFA7cwzVeMVD9v+ZVCVJNGJfU/JHjA41skmBKVxbHg9WNFUHHYd4mlWeKUEUiecCf6ljNT+Z4seaEyJDUA2IU80ySL4Fjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8671f13c-afb3-417e-6d60-08ddcb6ef1fb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:32:32.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8BBA0agcG4ZEfYp1/ncds13oh5/MChLIg9xVJVAzHkACx+L0S/gzhsDctis9vk+liZuC0cNZFc5hol3MBc6/L2kAC7ZaploLFLQk2K/4Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507250097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA5OCBTYWx0ZWRfX6IslOYRSwiSY
 oJGOwYV33YZ8N/cb7N1VYqjsKJwaBX+3PwBIdKj+9yts6W+/VB3vjGdz3Z+zD/8t5yRsKPhZlox
 tQK0wHwF09jG6An7JYGFjyVC57mVbllswLQkxcQ6dJW5Vx+l1EskISJyNR1YPhqSPPepqgT4ViH
 ngBpliUgMC5+mvVEnALn2aNCu5D9gjk3GTjlEchozt368B4fMQWuEwV8FvU/+VVSFWfWSOxOTgU
 sO8ZlLQlUQzPsS607B5u8sIcv2L26+WY4X+lVHsVZJFyLNyGFVXaW2CdTxx0DprscrjE/rhimlI
 pmFgwnKsul8yFb0gBVAFUT/7SOZYUxLGniLS2WCcGpkHT4f4eIqp+g3LF97cfLITDiYoxCbZQPL
 AUr1SnUBcE7NLP6kqjegdtksR4InsQ2xlK2HGSHKH5+bdt4gOayaZ/BzedfVXcMtFcXMDTxb
X-Proofpoint-GUID: QZ8nr0a1UhWeYcVQaOnhFucWuuX_pZq_
X-Authority-Analysis: v=2.4 cv=RIGzH5i+ c=1 sm=1 tr=0 ts=68836b54 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=MJuvnqD1UpqDlxNFd5QA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QZ8nr0a1UhWeYcVQaOnhFucWuuX_pZq_

On Thu, Jul 24, 2025 at 09:13:50PM +0200, Jann Horn wrote:
> If an anon page is mapped into userspace, its anon_vma must be alive,
> otherwise rmap walks can hit UAF.

This is extremely weird. I guess it's a UAF of vma->anon_vma

Because we:

put_anon_vma()
->__put_anon_vma()
->anon_vma_free() (also the root anon_vma... interestingly!)

But none of this obviously updates the vma to set vma->anon_vma to NULL.

So yeah god almighty. To get this, we must be dereffing vma->anon_vma
somewhere unexpected.

>
> There have been syzkaller reports a few months ago[1][2] of UAF in rmap

Will try to take a look when I get a chance.

> walks that seems to indicate that there can be pages with elevated mapcount
> whose anon_vma has already been freed, but I think we never figured out
> what the cause is; and syzkaller only hit these UAFs when memory pressure
> randomly caused reclaim to rmap-walk the affected pages, so it of course
> didn't manage to create a reproducer.

Fun.

Please hook me in (I mean you're going to anyway right :P) on this stuff,
as I'm looking to rework the anon_vma stuff so am naturally interested in
any and all rmap anon stuff.

For my sins ;)

Maybe I"ll dig into these syzkallers.

>
> Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous pages to
> hopefully catch such issues more reliably.

Good idea.

>
> Implementation note: I'm checking IS_ENABLED(CONFIG_DEBUG_VM) because,
> unlike the checks above, this one would otherwise be hard to write such
> that it completely compiles away in non-debug builds by itself, without
> looking extremely ugly.

David already addressed.

>
> [1] https://lore.kernel.org/r/67abaeaf.050a0220.110943.0041.GAE@google.com
> [2] https://lore.kernel.org/r/67a76f33.050a0220.3d72c.0028.GAE@google.com
>
> Signed-off-by: Jann Horn <jannh@google.com>

Nit below, and pending David's requests, but LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/rmap.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index c4f4903b1088..ba694c436f59 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -449,6 +449,19 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
>  	default:
>  		VM_WARN_ON_ONCE(true);
>  	}
> +
> +	/*
> +	 * Anon folios must have an associated live anon_vma as long as they're
> +	 * mapped into userspace.
> +	 * Part of the purpose of the atomic_read() is to make KASAN check that
> +	 * the anon_vma is still alive.
> +	 */
> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && PageAnonNotKsm(page)) {
> +		unsigned long mapping = (unsigned long)folio->mapping;
> +		struct anon_vma *anon_vma = (void *)(mapping - PAGE_MAPPING_ANON);
> +
> +		VM_WARN_ON_FOLIO(atomic_read(&anon_vma->refcount) == 0, folio);

Maybe stupid question, but wouldn't we pick this up with KASAN? Or would we
pick it up far too late I guess?

We're sort of relying on this

a. being a UAF

b. the thing we're UAF-ing not either corrupting this field or (if that
    memory is actually reused as an anon_vma - I'm not familiar with slab
    caches - so maybe it's quite likely - getting its refcount incremented.

Which is fine - because hey this is the only way we can get a hint that
this is happening, but I think we should describe what we're doing.

> +	}
>  }

David has made all the points about the code, yes I agree with him re:
folio helpers etc.

>
>  /*
>
> ---
> base-commit: 01a412d06bc5786eb4e44a6c8f0f4659bd4c9864
> change-id: 20250724-anonvma-uaf-debug-a9db0eb4177b
>
> --
> Jann Horn <jannh@google.com>
>

