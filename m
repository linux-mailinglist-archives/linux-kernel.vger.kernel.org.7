Return-Path: <linux-kernel+bounces-806323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D7DB49514
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF971BC5B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36209226D0F;
	Mon,  8 Sep 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d/cIwnYe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BW57dQTq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9930F7EF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348367; cv=fail; b=S4gLNTG92c9+XIO7Sp9xkZ4mwZqh2mur5vlz3nrbw8zfh0pGL0o55ooOAohHLbyfF8RapvagV63eAfUXaxdog+dgjuyhqnMm7/CY+kK/VxzgBaUA664VvqoblcmweRWAc9xs6NZCyt36fqmtDaYHX5XAoD2DrKXchGAJ5A+Z86g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348367; c=relaxed/simple;
	bh=/Ns63rYOjAWgALnadTC02DrXQOj15qc9o3knfUtYUwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WrgjskEbiUWCDgInXjSwXKLvQa7wm2DDLsaRz5tlEvIWWsXNAeit6uLoh5rLaE5lGrS7G52dgTfTZxN+Ek671tQh000SqML3MP0d5z1r5ARIuEclLfbQfKLxNjnRPWc+UdmepUUgaVqAKtw9E+Gyy0JtCycAuiTIMtOlAdWmYu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d/cIwnYe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BW57dQTq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588FEcw1022677;
	Mon, 8 Sep 2025 16:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aR3NV5oU4I7jxTPT9D
	0vR9GnQfxo6jwCm10kk3pDgn4=; b=d/cIwnYeWYrcJ+gccIpPw3j4ksfVbnLWRR
	u1PiHmnd1y87o4W9kwxQuyAY76tkDyEmcQOYgJkYvsorzjxtUd6MZ25y8raNBEmb
	hi1C1upGcJn7Io2s7Z4XhrFSdJDnG3EmhGMKL3Cy6zgMzynB6LSb4Pze5RUWaal8
	RLSp3dUA5NvXsxdt9OxbllZ0986ni+/kk3BfLyW3CiAaDJcIcu0gECstbAS5hah2
	Qe/ae4GO4uB8HjlVZgrXtL7E0W/D4/UIQjHb/lBorSjLXtDoC1P5nFstgKT1nPBx
	xEsm1SwU53ttlxSMJUdCkO4sRBozHbxZpNEOeF8w3p4oaGEXN9lg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2r5b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 16:19:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588G1OiJ002966;
	Mon, 8 Sep 2025 16:19:06 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdexjcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 16:19:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuKcrd3EJotkaVZmxqRXkr+toAd10WpbBC6qxr3xwx2dxGM5o78LK0a8MrURo7osAK5llZh29ddIVEaZhDlM8jIHPXmt5YaZdndRQOk5vFGSTNt61Y9nEOOpDCCqzUTIikE4OmNYQyvIdiDn8anl32a3on/aAdKz5fwj/Oj64ZOMgEu6ndB50PLiZaH4170MVW/vxtwUHBewwSAKC9L96+JPqmTF5Tomtxp9OAakPIsXXlTGAvTzIQtRCS9CIWf76lFmhfytiT3EyNxrzQfpV76KoROuvgBYfHis5cS6xKKo0iPu30nRjS9faDb50yz3WyMWtM3zbgDEWhvY9sxh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR3NV5oU4I7jxTPT9D0vR9GnQfxo6jwCm10kk3pDgn4=;
 b=ahTPYWIix8OOtYUkJ9lyeASAjnlQ9BL3BZh7MLpDqc22fH2cE5dOIeKLb/bOhlfxaujGsPBVsdXxTN0gGdHU0jdOoam42RTUYozkMrX7l9Fh6Up/GebhJWaLqumF3Xut8lsfKcBuTPYiY8w6kHuJZw0fZU1RloiyRexQHLZoqfsUmBtuVMC0tCpXehJjG6Zzj0FEQzlY7EkZGEeHyaRHPKlr4dz11KhY/ULPRsMLTsWQp8r9So54VbBUxlqTjOjcRkncMXKwmM5D6+UvOfSFNeI9UuGuBw0p6YRP2AaIXEW9SFl5tqJHowgF4x/7DIa6mNJ6euR8wJaWouou10I5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aR3NV5oU4I7jxTPT9D0vR9GnQfxo6jwCm10kk3pDgn4=;
 b=BW57dQTqxb1drU7vFPloTw1jme+2IkfGsJzojm913jKApYk6xnToogyat5cuOh8+FhfVDgWnk51/jxrQlqawChxKjHu2+IjfeSBxgNSk/qvD28rMscCzN1Lf0cL+JfGDGRlgmat4k1eNkmgR87/IO61I7w40nqK+pus6uEut04E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7547.namprd10.prod.outlook.com (2603:10b6:208:493::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 16:18:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 16:18:20 +0000
Date: Mon, 8 Sep 2025 17:18:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, Liam.Howlett@oracle.com,
        baohua@kernel.org, baolin.wang@linux.alibaba.com, dev.jain@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, npache@redhat.com,
        ryan.roberts@arm.com, usamaarif642@gmail.com, ziy@nvidia.com
Subject: Re: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in
 deferred_split_scan()
Message-ID: <095395a6-7cc4-46f5-a74b-0c08cff55e23@lucifer.local>
References: <20250908090741.61519-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908090741.61519-1-lance.yang@linux.dev>
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a253c4-0d07-41fd-abc6-08ddeef353bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?luiFTjPgjsafbr7OpPUKzMyk5X9pHd9byuUyM4+EimIi6a6RppUu0VvV4LBQ?=
 =?us-ascii?Q?UfVBz95jcl5+ijJMMkoouT3NQaZWKbTYQL5hpW0ataa62Bd4/IC/ohB6ymKc?=
 =?us-ascii?Q?7CIfoNBIC5M8hcK5U3ygdDEEOomygMt2dID5T+tBVkWw7Y7BnMPdERM/kFKo?=
 =?us-ascii?Q?KiBQnxn5dmDRQBVrGdWTQpW8YWhaMWiQY2nBN07QoCY+C61a3gi2qa3iB6b0?=
 =?us-ascii?Q?U3cgHYuoAtWdKnibabWVyjVCSplWB3X52p/YGzEtvYQHQJKBpbMtqCBv7dMu?=
 =?us-ascii?Q?8yniQvhdzalNgJtPr2c8XF3lM2+pIJCwLrpSZrH2s/vLat+tRnlQHs/P2Zhi?=
 =?us-ascii?Q?h8KcuMug1618Ld7XqSw/W8fGR073hQomdbnD7rIsqpGa6OnKvDJygdi8DFZ9?=
 =?us-ascii?Q?fc1HfQ/YQOQgTNa3YbeX5Gl4nm3JdsrzcJD4GKM9F29PYJA183weaXwYBUe1?=
 =?us-ascii?Q?3VoG8fszCjNHQHi7979QSglPsEsES4HbPA4YXp0O7QRFubQnWkjiSxPu6Sx0?=
 =?us-ascii?Q?xoQ6W4g2AylhFpUqxBPDS+79MPvUelAf7/Yo3+inkPYf9uyw9l3QbQbG/kCM?=
 =?us-ascii?Q?V0VCLYnn5MI6fHlFodwpJx+5m7LFzNWMa/vBzVZJjXpZKomQZBfCZfPzxWDp?=
 =?us-ascii?Q?82z+wW4VxXcB9wQ+NV814HebnwKVIM0oBWFrJtrryeiLVG0K/s/KBMPE4LmI?=
 =?us-ascii?Q?6fWdLlN9aTw4gqqTVQbA79sDi3vBZUzx+L8TZkaqbGXnVd7mXxdHE9eikoiu?=
 =?us-ascii?Q?uO0TMPQLWh2+JYJRmXpbDSxbwSwtq9Nm28JlRlC04CZDZGlb78HoSLnbThwe?=
 =?us-ascii?Q?jGm4FylCiOwPahGfgC8cNJ3B7hI3zQUIlunLxPJdztO706QwwHxind+9ZhHQ?=
 =?us-ascii?Q?kdyM5yxdPSQOA7iylxcq3jT7Hyju67/MY9xSMkXD/I82CILfi7I/SsePnh4p?=
 =?us-ascii?Q?Dp/nQTPGxIXGXwfxXmE5J7z0Pm3sle+rncUF9yAkXPBO8X/doAVxhJ/gxZki?=
 =?us-ascii?Q?0Wceqo+L7Ych+81WrDO1AchL/1T4Sk1CZqWyGQfs/5dkcf4wiHbgmBkg3gG6?=
 =?us-ascii?Q?COZnSvRgz/9rTGbTUNI2WKZJaiqywIUgo3u1qt93pzgMjZNBKRISYaUwg+bh?=
 =?us-ascii?Q?97bluMYzWykAdM4vJg4LmdqOSpRTXRxCDGKWv5FWBefqieJ1Pg8IC9zGQfsU?=
 =?us-ascii?Q?RjkI40wSt8Z0E8l8vFoF51IVetQaX7LmTbUydjEGsDD4umQK5vOcejFJsqjH?=
 =?us-ascii?Q?J/lyTJILG5ecP+2GrUc/gTwukvK1pDD36sppDGBBYJYq9Ut45cPF4wUzqZO3?=
 =?us-ascii?Q?XVOO7F9xbqLpUkqEb4rdO4L3Ao8PSfzto1jPAK3RKgmTNzvjZL3izOl6gu9p?=
 =?us-ascii?Q?qK1AEqcidYPPbklUbe4jsavsTSc5mpmVLVpbyKujYvJ5nD0RXVaEAhJMtr7F?=
 =?us-ascii?Q?AjGhRK0sQdc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nBnE7Uya6dA0xRjpNwH+zLKJ7TJbsUeAZuXdeqDweMOtjCFkDT3GuHBkD4Iq?=
 =?us-ascii?Q?QxXD3glFcYg08YxIHu0KdqKxjVrPgEWCkQoXGlKPHWRKrKT/caDCW191/rbu?=
 =?us-ascii?Q?nqo1CDEiWN6IUc5q+eIjcDqSbZAF1VELFRRnGM9m5nJTeNpyRtXsKwxHne8m?=
 =?us-ascii?Q?a80KHSi3ySohT7IyFppRbZK6REyuThs04XxTat0oSn356TUp5uY6gapamgk+?=
 =?us-ascii?Q?YBu1gKWM/nr2ku/qgb0fAbx8bxa6vQWZVrHUOYjIOACmYUWJ1rOeslAdIF1v?=
 =?us-ascii?Q?Ye16CwWlAMY5bk5BFT0KEgGNPxGPv/UO1nMRZbqEGvAi38L65w3vtkCBU8Pn?=
 =?us-ascii?Q?yzCaUiOcM9qgJZeM6BojaOluSJ6EqzdsKZhPxvFqe3SN0iPRvtSAvI6Na37n?=
 =?us-ascii?Q?Dw77o51gYVPnXXG/kuH7EqEJLkAEUGMz1gFJ5byQAlfpXWRpCbpPLIX1w8rD?=
 =?us-ascii?Q?Y8abGq6YQn1TpkegKo55MjyIsNUEh3hdlpaHYb3hPKPBULYyTGtx03l0VeqY?=
 =?us-ascii?Q?dAYoC9ChWrF3veTEERIG4FgnY6VnI7JPWlBMiZXsxOF+l/LvWeVLu+NFPQ74?=
 =?us-ascii?Q?6j39JxT81JXJBQKlbihtJ3wwv2ZDP2xd+1oY4XbgtdBQZym9GOhgctV8jdfZ?=
 =?us-ascii?Q?Eu7oRXh+rb3hFFhSZIzBWHvJGybH/1GvE1sjCRF6ALhNTshRjutX/PPpKXmt?=
 =?us-ascii?Q?IpZOq1WenYAvLw8t0WPTAzcrUX/Y8sTM17RkMacpgBtkhAK4jj5lfeWLx/0i?=
 =?us-ascii?Q?yEpwMSE0zXyW9iILC00/yDDSvYOBhcDJmlcypZscntkgh3H4tZcmxdCVy5a6?=
 =?us-ascii?Q?J7e54YbLArA3SyhHjYPK01NJu3Oi0sklDzsZbVi8VNCI71mkx0KuRwja1EVm?=
 =?us-ascii?Q?/BlPwMDGqawPPsrzFE/407M3cyrMX9iOKxxfhew+vx1P60xYbj9iGFOYMxnm?=
 =?us-ascii?Q?5iQja5cQwC2QEUYjXoiYJ0KZTNigB8TIefke3k/UN6vjxEt+v0Pq8FrCxukk?=
 =?us-ascii?Q?UezqfrTDn8ib0IkDNM+LoPoF/V/8223t9X3RudBaJeKB9Dm91LlYGGM7eOtN?=
 =?us-ascii?Q?bbdJz0UT85oALUIJrJPGaw54tkbAUJeiMtQy7K3t+i4ELwCceawDxh3mTnGd?=
 =?us-ascii?Q?ox53/1WxNmDzi6Gf801ofzlh+cpLAEjmbnwynNYJwjCGbUUDX0CbILKokKLU?=
 =?us-ascii?Q?20etjs2CisnEEPs6Hx1OCbGB+fAsj2SXNGfN96CpsaMuTlQ3PieTu4HXyT8O?=
 =?us-ascii?Q?+5Sjn2oiBAyaMN7xTeyBxfbe35s1KHbZ8E6kR8bgSlLMsHYmV2bU46kYlpNv?=
 =?us-ascii?Q?qtHqz8683Wrgjk1kVKcr/c1NNnGBR7v8SHZfIEZKuV5juohBeGrjUiDC7lXl?=
 =?us-ascii?Q?OeU8q5kJWojiR9/IOR4+uUe65vDdoAe7au8P+Yt/madUjzSYirFHHJTZRwK1?=
 =?us-ascii?Q?5TfwbZZKEyXZ3JJs8BO7mKbGVLa0BQEWEUX4T0WSqvJ0P+TxaBZ9FV1t2r+q?=
 =?us-ascii?Q?dICUSFBhdX9z+eiDakJbYZQWpg6aoWJw0l5XX2QAJ1K3OwnWcpJh0BCjjSml?=
 =?us-ascii?Q?Fk22KXusvECZ7WZUkEzDBiQ0jnXSYY6AHj45fR7ty6P9RsT74aRQncRpDCv5?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e/p7DyGSaGTVSEo9AB6aQ6WsBfRCGrusxuenJ9+auQvDhATTGd1vVnXKx8IgAZLTSm1/XZj69nVywYGW8joMhBpQwG4lbXxKb3l3Y4xx6u30MYRYdP2VgnRofwUvfLdJPMewlbg4EPnK8AA+vHmasU1fyfb4HU1YFec72sulS7A/WRUNuleDUj3+slfIxRjpUX9eBGbbKnlBI+vMrCkxMq6ecFX8GcjG9FUdDlNkAJhlnOIxJOUETQcL35Ct+cfykUnnFRQ2lxyixay38s2a7uzBAC6rqKYxqfCDa7IIujswnhB677ksDglZBJPWaBHF37hsK2yVx39mwW2ppPT9auZYQ2CG4y1H4mAKO8sNqV/nEJrTjfbww9XIRwHJe8QAtKfntPiIEZztVR+kxdjS4fLHll/cfww3y2+1FVVAsJvLQYxNtge2TaMv5dkr1gO9QTy/BjJuVgpk32OxltRr2E9nk5eeqdkno5QDRP6BS7SmyRLEQCApWh/Zn1+92C9mi5OZqMb/Y4Nfmj/JLWGXEBynREdUNl4He0vMWfKSvB5j+SOxh1XiqqXdyLxGj/au6K7p+Rmuec737KrOMJX5EUsDlz8LU3+kkNXI4esuMGI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a253c4-0d07-41fd-abc6-08ddeef353bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:18:20.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYRnrnzjinz0pw0Td7TU2j+hmoQfNa/OJkSP4sSf/jnIdhvSrAMbT6tvxe5T9VdldYbE+GYwyYH6qOO13bSy6EqPDHkBpXroqDWJP8rjFtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080162
X-Proofpoint-GUID: GoS3zjX362W5xEYl7II66-f8dvN3OcMl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX3Wul0/fb1b/V
 ojCVcSblVosV6jas40IHtxCu7zxe+pOnexz4EQ7lobKgJ8aNdoBGUvvD8TJS37DQta3uWffDch5
 9g255d7l5yFMj+bxzJW1nRUzM6MUWsuoa1SlooH/BI5uAYGwseU1CYRjxqBR15/6GCU9hWLSQnd
 dmRy/4z2yas4Xjbdxy0j2lhZfncUapyRG9D9vBrhtRIAtWlTGqPLHnxDXGHmny7Q7JG6sbTMifn
 ri5Pg3viQ0nnx9YghTgaCxKGvFHp0KlejS3oIRWf4zyuuBBN/qA5RFn0d2vayBMnDNkcjheWJw9
 4q5r+sjaxSruoOrhPXDfaEmEQT2EmuMQkeac9VV8x0dc9acnvzPeLfUrHDfSzk7g4wQE8fGz5fE
 XGvWRC29LYiXRYUg89PnPnmUi8Rjow==
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68bf01fa b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=_BQ4_Lo-lzzBt1gQ13AA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: GoS3zjX362W5xEYl7II66-f8dvN3OcMl

On Mon, Sep 08, 2025 at 05:07:41PM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
> it does not make sense to try to detect whether it is underused, because
> try_to_map_unused_to_zeropage(), called while splitting the folio, will not
> actually replace any zeroed pages by the shared zeropage.
>

I see it's along this lovely code path: :)

deferred_split_scan()
(thp_underused() returns true)
-> split_folio()
-> split_folio_to_list()
-> split_huge_page_to_list_to_order()
-> __folio_split()
-> remap_page()
-> remove_migration_ptes()
-> remove_migration_pte()
-> try_to_map_unused_to_zeropage()
(oops mlock'd)

> Splitting the folio in that case does not make any sense, so let's not even
> scan to check if the folio is underused.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

Anyway this does make a lot of sense! So:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> v1 -> v2:
>  - Update subject and changelog (per David, thanks!)
>  - https://lore.kernel.org/linux-mm/20250908040713.42960-1-lance.yang@linux.dev
>
>  mm/huge_memory.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 77f0c3417973..6d99893c18e8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4183,6 +4183,13 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		bool underused = false;
>
>  		if (!folio_test_partially_mapped(folio)) {
> +			/*
> +			 * See try_to_map_unused_to_zeropage(): we cannot
> +			 * optimize zero-filled pages after splitting an
> +			 * mlocked folio.
> +			 */
> +			if (folio_test_mlocked(folio))
> +				goto next;
>  			underused = thp_underused(folio);
>  			if (!underused)
>  				goto next;
> --
> 2.49.0
>

