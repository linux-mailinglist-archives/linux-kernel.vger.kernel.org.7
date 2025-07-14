Return-Path: <linux-kernel+bounces-730432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE74B04478
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA811A614C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40964270ED7;
	Mon, 14 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OO9RFzeA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="laF9kH7l"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB4270EC3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507362; cv=fail; b=mqd2dFgNIstT4c6XAXlz8Sk86bqPKIH6YM+cCRyPq+S20XoQB/2k6kGtNsy1wkGxr/tS9eO28NrS1o5oEUZe2BQYktPzAuaNa7oGYtiwupEqZ6iOFD6c+kws0Mr4rD9kdPJsvcAwlaxiHwCqV7fEbu0Q5+sPUxA4t0Jmqgo9oIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507362; c=relaxed/simple;
	bh=aKX1gkMVOFd4ZCZMXla4M08kHzX6he9gUg/ZFPhEyCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B/Abl0ofcRLME4QxenjjVZV2pRfLxXD7tAywZ+CMRt4kZqBKZkHYhZkt8kLlgQ5NGOFbdiNy0Kna02O9AFD5GwcODtBtbDeRGeRIxcvNCSfKW4JhlGxd3abrscZ9zYyoGcP0qDRI2lbNLkOCNArtsk1iiWV1aZCae4FwgLPhTjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OO9RFzeA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=laF9kH7l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z4Bj004569;
	Mon, 14 Jul 2025 15:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LFIRQbGeGqrXzpfpWb
	dMajOIw/51mhqsFno4Ooav4tQ=; b=OO9RFzeA+F8BE5b0RmZH/xZ3x/fLbTTism
	D3Vs/vy4VXnXBsJypqDZVWR6v6Ehoh9VSnodm7A3HWwuAZW8Rl5Sf9kbbalquCua
	Lcyo2Lp1b4Y9N+9wzJcw/goStHY86LUKyhTUdNV5XLXC018YFMkkJy0ZFdEWwMZt
	YY2x1LYuROdNkQHQpriqjcBUmPl1bdIFmuMaxi/RlUGqmHontjEJ3EW/iNm17We4
	54gqHvHKmo8oZV93EbX5irkevVaZNX8F1g1mQF5lBF+v+e1icJFnECrGaRjvHYnc
	4IiehMI+CK+r+37CqEYMO8UN9ZDiI9a4DDvJvTuSAALyVlxAC54A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7vpkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:35:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EDOQWh013044;
	Mon, 14 Jul 2025 15:35:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue585uww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:35:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGsaxdDDOaQk23A3IKFyX7pZ0JtUZCEAeNJwUP8kibuAYTSOHP7t868w83JZ9Uh89IZSkBD0xYmSDujdyZS4xMVjjSDITwY5D7LJ5WEoiBAbhqk3+3obtFHbTLtUukfgxGRTO61LhxWd679GP3HrSNemtyDm/chlcpqal63JL9iJOL8TD88Hpjl172Dw8Wnf+gEaDRoFwEubXlokqgUV0Pfj1T+VAFyjQDCHbDih+vTYx+l6cXHNAu7rL2FAuD3dvgn1DZ8Dlhb60H2a5EsQuMuBsf9ROqYW1hoyitH9NtZU2n/BT9aD6qzMEs8bV+olGvY1GZdLyz/Vc+PKadEeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFIRQbGeGqrXzpfpWbdMajOIw/51mhqsFno4Ooav4tQ=;
 b=ctcZlyO5sSNU6Ou9MjVJzpiyFbQkiNB4WZKja9T2yiedSbK/Bm4My6knYbIkqjd5w+riJdESOTfiPyysrGh9AEMB4TT6swaMkkCzHa70U9qEEw9Ecslhnqc81yQVy2vJDFrq7GrcDix4JvvzaOvCZ08Wcdl05dNWeRJRMSxK0uB7DprDaJTzlyyHgECy/SpbYdd3/VQudXb4PH4suRUKkjvltgBbwCyjU/eDWRk1XcuDiTAc6i7NRtfoy5GAojL4SiNVUV+qnLE9iVubgn3wx6fEWcIf8TPwSk1+sjPRaTCI7RNjVz/T8V6266TsSsAhAzQcNpjVfoGHs8Tu7fOo2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFIRQbGeGqrXzpfpWbdMajOIw/51mhqsFno4Ooav4tQ=;
 b=laF9kH7lmzkK6vGUBJganMJmfUbs8bHJJMfZkooipW9KVKakPdyU9WlcUkmZTSH4RY4walOzfh0n/xxjBZLZFqEKCefS21/nGWJTvzuFvlWIxb8lpQbKIVyAEEPGo3nlOGU/ua9mfa9/EV9gUqSBzNwgoBWv04ExGgLpmuOjulk=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH4PR10MB8226.namprd10.prod.outlook.com (2603:10b6:610:1f6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:35:47 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Mon, 14 Jul 2025
 15:35:46 +0000
Date: Mon, 14 Jul 2025 11:35:44 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 4/5] mm/mseal: separate out and simplify VMA gap check
Message-ID: <mmqwb7m76ty6gmazw7db35rfow5vq66a72qa7rwjhnkh7o3j6t@2bk55s6jqb5f>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0340.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::8) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH4PR10MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b4c949-689b-4b45-07d2-08ddc2ec1a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P3PBhtfkuz843FIWlF+mzD8VdCg0V3ICBZjLVynFYZoNllwohSGDNx/n5g0J?=
 =?us-ascii?Q?7gPUg96ozJ2asOcxUdKbsiuacPdepY+ASmqHrRs6SKjFF0AtPkulHd8iTyp6?=
 =?us-ascii?Q?Les1RLoPcIzc+xkJx+sD1KzNlkWrOKRx5sNPgcPjjX8hthpexGFRnNGQUOq6?=
 =?us-ascii?Q?rZE1J5iJk4/Uif4lTFn2pftJmO3UzosOBnM6Oz8hi1p1F6gvUnZEBJh8+bZy?=
 =?us-ascii?Q?BN5oYAnt8Eo5REmkTpDFSshFRhU2Q2PS6IDs17JyIXpOtJiYDddrVmP6j3UO?=
 =?us-ascii?Q?7cLvEqUjGdQ/UVFkudL4BcR4g4w08gVF2VS1FMKJUbStASJ4+Pe0tvuRsRML?=
 =?us-ascii?Q?HZBzhfzmFJuaBxglp4nkfP69z+C9P/V0Spwq3ZIRrCtlVP+Cbb2nvrXqt7e0?=
 =?us-ascii?Q?JK+qnqTQiDpyDvVpTt/HTZ71HmrH1Ut4UnbJcWybixQFb50z/p0M2jXWLxSV?=
 =?us-ascii?Q?lc5qcoV8QqtE2ycpV8fRPlOtAhI8UcxcTJglBq3lgRhaHT5kSSPrd4e4DVIJ?=
 =?us-ascii?Q?4YnwpDMfGDN4dnVTNWrQ4oXhQlZDToXonsrUItJ+yTAbnCzi1Xye+bcOBH1J?=
 =?us-ascii?Q?/J+X7zPVfCmFOME6l3bPg5e6A2ggGqEzI/1zSDMFkcCGRS2VflE1+d7BC5cB?=
 =?us-ascii?Q?9fQhrDzEDPFrw6LNpioFA1SjL7vsrsTMZFhtEDFsDXVW7ktgvlaHMGvYA/T1?=
 =?us-ascii?Q?JX+SNlr+KQLavNYl+3n6uOGRPCBJnWekPrOWQcriYYUsyq1Ca3+yKa3p9+G9?=
 =?us-ascii?Q?oYe5Z7Kxhf5bEVUx/7DnvS5lFIwZL4KhTxqbqfy8OuQbe/lCHbmLcDXcnKAe?=
 =?us-ascii?Q?iF+RMA6ksk5If5eS4QSvq9b0/FIgPKmJWGMcRQwdRQz5jY9JbwwhwDpcMinB?=
 =?us-ascii?Q?mbKcdSbaZtiuJLageUcA53TlyDSdKw8JpcmJPwFXXKOB6r1FtxtdeNGrX9uU?=
 =?us-ascii?Q?3V82I8OtLVYSMu4yxHFmTplJgFlgCnSRF025+f8x46OGvcr6CLF3Wt8AVn1G?=
 =?us-ascii?Q?f0B78gwNEEt8ko22dIEMg81zk8/kGlR6/tScP/YxeQjCLzyk3CXpxc0usmSl?=
 =?us-ascii?Q?qu18EKv5N6HIe0VyR/as+B45LO4Nrdl8UfUKu8kmWzMdadSLWQ9ltPuJMCTi?=
 =?us-ascii?Q?YTJOGdk7PFjukX4bqND/vwYW1qG2jpC3XmQvSVTwuCPPhwJTNTQBtz4Nh/1o?=
 =?us-ascii?Q?RQ18nCyzGraFALKh/a4jEtvtyXlwTqD3gRdy2CsDR7B0k1axEsjNchZpJSim?=
 =?us-ascii?Q?hKyMoOyQ6i++SkTh2HvQ9ExPZIWa0Bn5g/2GJQJsPnBXutTjNJDfz5dl3HiU?=
 =?us-ascii?Q?3sH0iqkSviyOoDIPCICCONlwZiH+zsw14/vJ939uAe0keaitFvpYKN7FTMvF?=
 =?us-ascii?Q?Jfl0Cf/G9Oq6CqGU6zlsNT5yix/pJ84OVlqDNkjXFCJliyME9RrjZNBxKO7O?=
 =?us-ascii?Q?tvBfn9wXrbo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CblNunX7ToVsSTEikRi3od03uoeXelhBcu6AVielOyf2v9bHWT67DYaDtiLz?=
 =?us-ascii?Q?JOeQ+yswbMKK1UXTbSl/Fh56s/wQfLu2DRfYu7d+plYm6P0IgOiUaDVjEun7?=
 =?us-ascii?Q?AoqAA/tI/OGKfinp2QE6xRl7gMa7MP70T4snRbPfbUB1vjlDYKNiwvUgElmP?=
 =?us-ascii?Q?+5UwlDxByabMywNGKksgQaAGakZaY3ls6nSvqQLHF29r51dvilza8kFTsINy?=
 =?us-ascii?Q?knss2IqEcvBTMea32liQB/n0+jtORkS1rY++RU/Iw3E3AWh2D2vOeMQm6xIX?=
 =?us-ascii?Q?iLmiEjNomCjTkngE4suYXV9cxBJZLWoPvjagLFZH/LS+/gu7gOEnj3bBYI60?=
 =?us-ascii?Q?yxElBhQpMvo9uyTuOE7qunmlTcKnRemUsFBC9imidaT7iW0KNOSxGtDfGHG8?=
 =?us-ascii?Q?K5XM2L7n6+MX7VXBZxKLTbb4nEEYTA8XhnMJqiTDTOqHOT6C2cUulFi/VK5y?=
 =?us-ascii?Q?/SHBFDIiRa0+2uGsIlz7wdFjZ/Di/PPipYtLJYl0qI//5fmpLyvmVGzgCubf?=
 =?us-ascii?Q?e0w/5OcffPmhRmiq3vTN0kpkJfgzXZA3oB0xk72sEhZGgOM+IeSuZn8PzfAF?=
 =?us-ascii?Q?+/Rk6XY4m9BmUJiUto4pcaaxHsKI30eTbv8SZVpt9qL2ytecT4Ni1MmnE6rx?=
 =?us-ascii?Q?mDVZ4v9zkxt+BQSzRCi6S99dAZcQVvABt6XxrVUfxJZ83lpcmfw99cGoyiHt?=
 =?us-ascii?Q?D209jC7hMdDiU7dxVMZQHqZmcr+R7dt6Cb7nduSXo6DwSTH8FJW5dgp0K2TO?=
 =?us-ascii?Q?f7ozDeSyvfP5yA0FC0Kwo1EPHO6PWPn1PHQYYkNJ3JBvg6ww7NLVoz7CGkyH?=
 =?us-ascii?Q?kb5GXViO83JnOXi7ThKZ9E/BWxzgZGoWnISopQ6BG1d45WMteUVepqGMt54F?=
 =?us-ascii?Q?PFit1MmhytoSrJPzz05oS1xryxCZJLPc/XRddqz1RrqpLBgFpMwK8O5Ddpvx?=
 =?us-ascii?Q?E6qbRhQRLrrvEJTX/F7TDO+9vuwNHrbQOygo1YiYs1EXO5Rc897qH2ir/FD2?=
 =?us-ascii?Q?/eU4cX0tRD/tgncPtXB2uOWM2jqN8Q9WmJZk5+Q43W7MkIBr1CfKGInmlyn3?=
 =?us-ascii?Q?h28zp8TkWX633t+RQUwX93nDdL9aIGQokIV1Cs9EodCzmCdsxyYJ8lGTHgp4?=
 =?us-ascii?Q?fRaFbrL6Nt4f/Jxn0EUWdHfwvr7Iq3FtZojwUiiinSAkCVIbe/hPrI+MLhoO?=
 =?us-ascii?Q?+HyLZf8abXy8US2HO8JFVGh/6xrtKRStmBc/jcAYdnQ/Yy0HiwIxJVU71g2P?=
 =?us-ascii?Q?TVJIzWb4ouDVB/NpHo4z3oN/yLYHAioOQKNkvD9it7XH+xOzVTedJHJDAIUo?=
 =?us-ascii?Q?6Dy/cgyRZv2Hz7fyAgdcUAbDKKm6vYXppZ6bG7ApnOS2cvbLVvJCDSNvwwh6?=
 =?us-ascii?Q?3vsKJ7FYrAk7iuaoI6KtxiHVO1LHNSSHsBTCayv5+lMOeubTJ7zkYcxOWOVw?=
 =?us-ascii?Q?hQCZzw4Tn0PG7p66dduLzfXWGqqvkzRT3QYpApm4VP7BOtkvXO4DTiPQCdOF?=
 =?us-ascii?Q?MMMzJGaFy8aBFt0Eu8DwJ4CAd2O4Qg7Qxe+zGxSGMR/+YOi4q0lRRSLFA+qd?=
 =?us-ascii?Q?AKIR6+IVvmbjo0npRHJMjImFKUcyD5pC0XnQOcgv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JqbXFVKFoQ+WqnC8guUs7qFDZZWbn2opC01GYrqVtWAip4Vdv9o3Ptl363xRzZcRsd7iZBQ6PM7Hn2Y1n4Jhh1EJNqzIfXug9+E/jp0Tbn9jQZ5wwCvBd6D2wZyv39Kr4eH7f/KClIP8D0w5WCdakkOU6h2imHL563EkrDNoCO2fNMALn4DM9GpnqddXRKs9y8BoSkDTMFyXxpUMhAt/7l7XkuEtEi3gA3oduVJL84sbBmGtQiaCDdJlifZMGeT6tCeiu7w9qLYMEd+h40H7aObw8EF1QzjpDcNnbVxIB7lTWYfjtDga/8ATIUJnLhbZ5AS6/0zFOF1nZIQ/x1a1Uspeo8siEWN6x02G3DZpdJVRNfEExm3A8TO614enCsexYzBaN7iCaix9fD7LPdjORKdTwPIukirBKewYp2xBuxuJxPvQPjXHfChS0vfqT6R8/r2uyEbbTJGDvnVw3RJlAGvPLuLws19T+SRH+czLMF15W6qNz6Jn+ec8qY/kOmLoY7k6Z5xXWWgBLWBvNts/MpT09+UJTW1wDZSGkxKF6wj5DcAcFVrAhDjuNsMs3dJL9aQiDv9vO8HgVuoDyeV+/US+iV6YkD9sJCMEoS6tUx4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b4c949-689b-4b45-07d2-08ddc2ec1a68
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:35:46.8823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llIgsXkCO/xr3i5APFCAOt5ld9d6cvWhvAWagZhRFHQk08zlrpyNWrI+aiadENrxMcXl2lHJLVmzc9+41TxcUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140093
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=687523d5 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=S3Rs978eqoLIMsxYewgA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: 4evkz_zolwX6U1XltZaLjd4AMYINY3L4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX1MbV5vLBFZZ6 rnFhTw9ln3gxgHW2Vi51oJD2XWkyb+2aa9gUFROOncMYmNJElKpY50y6ZW1LP1Xbc3VRQLooRPt fyxMIl9ogJb/VWrZ2JbDhKPxMmrjGzz0mF71Q9NgSktewIhI56iYM6oMX90m4zyJ6/LyTW/itKW
 3JZhS98dvImKl9dtsxMi4qtJXNFIbdZV3z2z4wpRO6tAWZhIidsT/iq9DIetQXgKjuDXxry/uNZ 6XKjO+3f7FcRI7PktssJpWzjK+Rs2k5TuixV8ZpsOt+7nLr4G2V0PqGvRytiLebiZIhaWjZZYeC d7Y8viFTkUVSAiI2YGxrAAkdYi6gmipJY0lI+wEVb0P9cEpVvLXobVjIYfEA+zaXE0IK4hl0l9b
 0a+6HAHGxfWTt8h7mwUHIejr9cK8v/CND4C0WnOIQjqi4xIZcBPAfN43LL7SVVzrbRqALFen
X-Proofpoint-GUID: 4evkz_zolwX6U1XltZaLjd4AMYINY3L4

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250714 09:08]:
> The check_mm_seal() function is doing something general - checking whether
> a range contains only VMAs (or rather that it does NOT contain any unmapped
> regions).
> 
> Generalise this and put the logic in mm/vma.c - introducing
> range_contains_unmapped(). Additionally we can simplify the logic, we are
> simply checking whether the last vma->vm_end has either a VMA starting
> after it or ends before the end parameter.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

I do fear that people will find this function and try and use it
internally, it may make our jobs of avoiding this being expanded more
annoying.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mseal.c | 38 +++-----------------------------------
>  mm/vma.c   | 18 ++++++++++++++++++
>  mm/vma.h   |  3 +++
>  3 files changed, 24 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/mseal.c b/mm/mseal.c
> index adbcc65e9660..8e4c605af700 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -37,34 +37,6 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return ret;
>  }
> 
> -/*
> - * Check for do_mseal:
> - * 1> start is part of a valid vma.
> - * 2> end is part of a valid vma.
> - * 3> No gap (unallocated address) between start and end.
> - * 4> map is sealable.
> - */
> -static int check_mm_seal(unsigned long start, unsigned long end)
> -{
> -	struct vm_area_struct *vma;
> -	unsigned long nstart = start;
> -	VMA_ITERATOR(vmi, current->mm, start);
> -
> -	/* going through each vma to check. */
> -	for_each_vma_range(vmi, vma, end) {
> -		if (vma->vm_start > nstart)
> -			/* unallocated memory found. */
> -			return -ENOMEM;
> -
> -		if (vma->vm_end >= end)
> -			return 0;
> -
> -		nstart = vma->vm_end;
> -	}
> -
> -	return -ENOMEM;
> -}
> -
>  /*
>   * Apply sealing.
>   */
> @@ -184,14 +156,10 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
>  	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
> 
> -	/*
> -	 * First pass, this helps to avoid
> -	 * partial sealing in case of error in input address range,
> -	 * e.g. ENOMEM error.
> -	 */
> -	ret = check_mm_seal(start, end);
> -	if (ret)
> +	if (range_contains_unmapped(mm, start, end)) {
> +		ret = -ENOMEM;
>  		goto out;
> +	}
> 
>  	/*
>  	 * Second pass, this should success, unless there are errors
> diff --git a/mm/vma.c b/mm/vma.c
> index b3d880652359..b57545568ae6 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -3203,3 +3203,21 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
> 
>  	return 0;
>  }
> +
> +/* Does the [start, end) range contain any unmapped memory? */
> +bool range_contains_unmapped(struct mm_struct *mm,
> +		unsigned long start, unsigned long end)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long prev_end = start;
> +	VMA_ITERATOR(vmi, current->mm, start);
> +
> +	for_each_vma_range(vmi, vma, end) {
> +		if (vma->vm_start > prev_end)
> +			return true;
> +
> +		prev_end = vma->vm_end;
> +	}
> +
> +	return prev_end < end;
> +}
> diff --git a/mm/vma.h b/mm/vma.h
> index d17f560cf53d..bfe9a04e6018 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -598,4 +598,7 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
>  int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
>  #endif
> 
> +bool range_contains_unmapped(struct mm_struct *mm,
> +		unsigned long start, unsigned long end);
> +
>  #endif	/* __MM_VMA_H */
> --
> 2.50.1

