Return-Path: <linux-kernel+bounces-822844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1ADB84C78
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7BC1C8133B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4B302CD1;
	Thu, 18 Sep 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TDAGv6i4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fVnjzX0m"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C319E7F7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201570; cv=fail; b=rQ12tYKnunqt3hAhrL2OA0feISi/sVZwzWUocjRwr8Mt+8vz6sr1Cs96no0W9rXllviPekmwEg7Qkf3Ron7gHT/0dR4Iw+TI4RSnVN+IDUpAq4Sz8lzYLBFdgQMwoyI+gHwukF5L/ptxdyZfOfsMeWkawchUjAgUL3xtXABDmmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201570; c=relaxed/simple;
	bh=hk0cmpZdwtBA4Syd8/5+4brGMwG3WVkil0e0/jOlcdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V83AxICNrjUfE1rpWB3cbr2sj3dE/FEMJU+VurGqYcgfcuPmTe75YKsZ3M0FReeUYAT6pXQaqpZf1qImMmwydPShRu1Dw1E9OnA5ujJHK5yBw6cH8l2CQA9iHkzFNHRr+Xa9m0e2haE8jLtH/g/fgAgGcPRChx21XTLBbgD/zSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TDAGv6i4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fVnjzX0m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7fut6021226;
	Thu, 18 Sep 2025 13:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=q/h5YQ7u/tcS3vV/CJ
	Pz/UsJST/GQ7iAfIEOGDr/yLk=; b=TDAGv6i4RSfqWdaqvsu3QyQyjZkVF07pIF
	5GBrYNrLPI43mDjGUE2+yNzJ5RURHaX/CAdAoh1HTixV42ae+HRn/yMmM+fcJnK7
	05JBSgbByaEomf6bMSwV+GGkpFiIFbVWrO0DahnXz8qoWDlZa+M//+OAVI7uFN5M
	zkN/jrP93iMGmUONbg4uZeS66d0cp7eiHV6w0ChirxYw3/1ll/3aLY6n7uSXzFpv
	BTUKHzvmla3dZI2A7Dbx+enn3zaXkYoax+QP0fPxfUfc0ErcXRKYW7bUCeULMYrk
	y3x/hNAE5u5u1FW29w6q6vo09TxPcJ0j+lfZ23NfgKhsRd2RIJ4g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9uftf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:14:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58ICrcFw027252;
	Thu, 18 Sep 2025 13:13:56 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ncymq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHljBEkIJLNaurmMu8fzOkzENdyDGebS9dUfigfzy53aLnEhuQo5wIUHJpS2BN+PXFwa3hqgnSfxqI2ViysiNzJ11Quw249NFtblLN+KoNiopXWJnrsZG4CWmZ/bIoCvhcdjIStRrAvuXpt4DmPgMc07n/YFF/9MG52o/hRE29WwuTr9lbE28KGjF0YBsby+pCjTROmyblZELWSfw980QlPaqFVjHKrpzvtviUnXIshIkLr2fPNamXSNHhPnjLP/oJfRSX9q7+CeEVDw4vUIt+jCA7MyMiySvDwFJMmr1lgcv5ylJdmRo5B1EflITY8Dt+Yt//Re/koh/chtq6Z6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/h5YQ7u/tcS3vV/CJPz/UsJST/GQ7iAfIEOGDr/yLk=;
 b=uePD5HD6BpqOWWKXg7Nli8LnPHCTN0eqTpqOIVLdAZUk27mW0T+9PT6N/UFyvfUoe9eRXzdjKtyEzofxeARcJcXUFO9PjFN/NltdpESGJjPGOm1nMxEiHORH8UAQSms2B/SPIvJ7NaTR/P8twap3Rl62h2QjKxFwWbMlBf2nzILDCTiCeOa1HLR6LzwQtq6FJVt0UOKCThffixNmR7qIgEWPz494ALGKZCe/0pQ3WS/2ml7yOIGOtkkwUs9AuifcDULcfvGIJWwUKjAlvZKfT+C3cHqonV2HZO9ApOEt4kZVt60M1pcxwGa2JjG5j56FNrXSELngXidBU19fN9oUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/h5YQ7u/tcS3vV/CJPz/UsJST/GQ7iAfIEOGDr/yLk=;
 b=fVnjzX0mF7lLFF3c2CssngejyKC32u6KVaFq9SyEfVVNglhgZteV8w4FC66mYLOShvaA0PO9fJTOQlCGRO75vS/6Kw3zwhrNd1y2gEQ/NBREZRfDEWktHODe/zXWA+57gobQtBaoJ2O8dr0aGpArk0lJDFokC04ez/6divIVoo4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7127.namprd10.prod.outlook.com (2603:10b6:8:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 13:13:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 13:13:51 +0000
Date: Thu, 18 Sep 2025 14:13:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 1/2] mm/fault: Try to map the entire file folio in
 finish_fault()
Message-ID: <962c9c49-8603-4a57-ba07-36e395eb48a5@lucifer.local>
References: <20250918112157.410172-1-kirill@shutemov.name>
 <20250918112157.410172-2-kirill@shutemov.name>
 <6e6f596a-1817-45d6-b674-04e8aefde6d4@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6f596a-1817-45d6-b674-04e8aefde6d4@redhat.com>
X-ClientProxiedBy: LO4P123CA0552.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 9436c7dd-4cfa-460f-1217-08ddf6b53629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hHkuLsbAZQEG5RxvLvxA2mUlArMkgamHsR6PiT9DcWqUAnt+RM4j8lcYtXJb?=
 =?us-ascii?Q?xZRApYNYJxQzDjpA/Wo2Yoyr9GfmYjYeKZYTXe+OWV93lCwuLTWRi1Rpfc/g?=
 =?us-ascii?Q?6AxEDMqT4pm6eKj499nuLGMTQlwNjjgFwe+UwblvQxbdELDmpK/5e4RDTIFg?=
 =?us-ascii?Q?9J+DJSis+vFutuMpPYHeqWvemagnfByQjbh6Xl0jptnZnlFQQiut64azZMMN?=
 =?us-ascii?Q?YuxGArvZfY25JX8S4MduaDtpd5pmk6cY5xH0vVOF+juL8JzemqqNIqQDBXTM?=
 =?us-ascii?Q?txVkKrf2pWoVWmeQgW7slunww42ff9PzlCTxRFHQN5FcfD3udFoBvtx+W82Q?=
 =?us-ascii?Q?b1o9TnMlrxCQdtxAUolZC3R0ZVNHZMa964CGe49qAzY8OlXxgXSvZHXR0R+P?=
 =?us-ascii?Q?iBR0ocgbVRVH6FKtItgM78FPvs/rQhGkyjf4sHqUDbHGAQ6/nG7NCGMX8lJ7?=
 =?us-ascii?Q?8oTHqUeJnLD2OLY7Z+ynK564EQuOtAPKPi6u+H45pRNOjYkU2LHtHflkbgyU?=
 =?us-ascii?Q?KHTwQuGmur3MuGyCWI5DyksdFpcvbybD3SA/ur1UtptdTxs+G9cQhMqlNJKK?=
 =?us-ascii?Q?URZufSkgl9KWJtO2htFTDrEYhtxIeSs3cLlXvCOREGJBNkpWixOAubU1gD7P?=
 =?us-ascii?Q?ClB5hTwlJnTOVVeVT3M6fkGu0JqaUyBdhas3/Hkcq7xo14T7GCnHC5rVwWNA?=
 =?us-ascii?Q?zDgEYjNoWFRzGQ+GP6rWXmSl9mXMrraUU6sgg3tBrqQZghz9W+9iiXEtcIdu?=
 =?us-ascii?Q?ZVECAWccoBUPa9SocBsOOKWC1FjxujFgfmV/ftGgMoVlx4B8+lNkrkThMYHC?=
 =?us-ascii?Q?A9Wmt7pxA0EUh9Kik8FtQqtuEbqF29Fu41RPDZ9c/56Mc4J1CCH++ZUzXCX0?=
 =?us-ascii?Q?EFhglB3sZ8teo2A6CDIYWmUietOReD20uRKBSP2gpkKMm805EpO8KDc5/EE5?=
 =?us-ascii?Q?HmTmCi0EwzY6bkqrX/OfzeUqdgNqk3NexWBHlBx6swqLLHwGo8sEpK72+AhB?=
 =?us-ascii?Q?wMA2cx+ffIR+TiyrQq925gKiPiNtNS6/hYZ+3AuTBFx00OUhZA2TaS6PyY8t?=
 =?us-ascii?Q?GTuU72MsMx45c51bNbztGlDjMkaxDR2mu9wUMz3OmG0xmYImXRb2VbmudBfC?=
 =?us-ascii?Q?MIOpFKHi6xUyqUibTepzXX1fzVs9/49qymrPQ01SysfmXTCMpGiZh3GToCmd?=
 =?us-ascii?Q?uIfWUOCcOIhlHytqKlO6SrbJ5f9OfMwa4oIqixM8VeeoSi1v+958MSutxYOA?=
 =?us-ascii?Q?yOVBS9doI6VYLHQ58ViH8TdwvVZ9ztCfNuGWqeXou2jZKg49XoSGKI7E5jiO?=
 =?us-ascii?Q?pCOLBX9xn8qBTPH3TYhbhN7AI8AEMUBdHTDrpwJY5Fz9HqRHUH3C22GPL1Nu?=
 =?us-ascii?Q?Yduwii1b2f/uKxmV4JL1UybHJU1z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8DdLMu1ZTagssueNtFlnmkKX4bYtxMGDX0n5v8zsK2QBfMrunoekO0rhK9pF?=
 =?us-ascii?Q?Wm9nnd47m/c3mc9bLZkEsB4ye7UBurOp5fgIy+5Lfi1BzmYZ68RMNe1jTTwl?=
 =?us-ascii?Q?cKc2lxrCYAfAodg1Rf8FacIaXhDUD4ThHT9JpFFWzr4FP+JXAQ5z5+TVCitR?=
 =?us-ascii?Q?3HM6MoVhArFfDMGIFeGJkhTurOK9KMohRHNJnyg0VeqJNA0j/q8Cwrm65AOJ?=
 =?us-ascii?Q?WPK+oEq30n4A0+Te0oH/p2sP3qfmkP6XXiZ7AhEguxVNnqZcXl/kzpjTBlnl?=
 =?us-ascii?Q?0yow/j9kD2T8j0T8RW9rAYzwJdmpcAdJ3cLGxQk6ebv2SenTCxrhKFfYs59a?=
 =?us-ascii?Q?mE/6pog6M/0iy+JjLNWgOvdMSeDUYTFev1ec7GoTE7fBNfcyVl1TEBBcmBrw?=
 =?us-ascii?Q?pC3R6mksdHptY/S3ynn1qLn0+XUmFNng1WG9H+NWBn9egZjLbddiPz+pNqW5?=
 =?us-ascii?Q?kExbGNZUq/T0JaaDSZ9ZCHvnlhGAiZbc6l2cSehtowgATP1PtpKE/pWlBCas?=
 =?us-ascii?Q?2k5cD0G4JPv2qBLpVrKvXZCD5LVPSjzc3wc3TNuZRIAM8xtaU3Y+geRkShzy?=
 =?us-ascii?Q?boo54hrcyt76h4Jxc7X1e2QGePM69FN9u6VqD9EfaJYQieFgjoK+rYvn3VzI?=
 =?us-ascii?Q?Q4H4ZMlrbFdJH6OO1/B5LL/xtu6+UBmxtcBXeJM/gVKMEVfOorA7Z6YOab+y?=
 =?us-ascii?Q?TRr1zCf6zSjfCpJrBlcGRNCtn6KXDaBq/kTFq58MPTJiY1eDPi/ScHJy3pi/?=
 =?us-ascii?Q?RDFFttc7gqtD8JD79NEopI1SioCAu9p9mVJhhXijWmQ3TjdjMw1S61WGAIT7?=
 =?us-ascii?Q?MzfKnGjlosAodot25MxJBv43VPb6AJNfkzElO45144xif9SABhYBDZlljnYH?=
 =?us-ascii?Q?IQy+zHid491Ggkky3hVE+Fu+WIXMqUfD+LjeZyTY7SWVPKVMvnAOhTzeAY30?=
 =?us-ascii?Q?C05NCf8ATO6GYhGTGB9VWfgVzGbOd3NGRja8TzKRPfWW+qRPw8pI+7thAUFm?=
 =?us-ascii?Q?TVGxERXVD6CuECiE2eh4Os4i9b3P+LOwCGX5dyWePA2Uwr2Gug4bEBA1J3Wh?=
 =?us-ascii?Q?XHv4En7TyvuKhnAutBK8ghiAPaa0ed8Dad7P5l4vZq9m2Q7hdLTgicLk/hlc?=
 =?us-ascii?Q?AM+AbJ688EyJS3FVHhURNNHuvf55+5iIwOlfN0FAlVylYmK4M78w6U6YYKXp?=
 =?us-ascii?Q?EwAWYcCKkwHhls1gzrcHKC6NYbfiEiZ7CqP7iu9fnp9ZZunVKUf065GI4/Ct?=
 =?us-ascii?Q?7ZaJNyMEfc7eT0ttoa+YfXnCIkJxS58KEL3FdBKP/Lyf3dPOf9AIGgcBHzdV?=
 =?us-ascii?Q?lnFdpvwTXHtGOGk+A7mBhRqsN0+x9exDSDtBI3PsrxpUrHjnd6/6jyfL3IYg?=
 =?us-ascii?Q?/CyJsrnLHR+G/KtbGEESdeNmXxFTIn75K86nossvoGtCF0q4tBwTE8nFzW/R?=
 =?us-ascii?Q?pDFYjfTOKClH9a56PWiEKvxP3+8fPMVvnlWGKs5mRJ5r/rhofKL+JgFSaPUa?=
 =?us-ascii?Q?cIPo36/HQVIJWaSc3OEBh2gGieTGYtWYGBmWTkQA+MenyLvHXisFbzs+Cm5s?=
 =?us-ascii?Q?sCm83AsYfWOVYfNTJIgxBThJ1OArdbQURuosTV7xuJAoYrs31AiDnNc2lu+O?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2XpGH+KekDSbnsLJ4ifein9qsSVGy8Iy9pSTT6jNNCOeMuLWz3nQk8h1MvcbB9z3EQl7U1bFcFsitLAZjPmiW0jq4NbB0Df4C9ZfN/hq5udOs701rndgvtz46ZQInl9oFgqpFml3fuYvlTKsalcJ1PeyCBKeS00stkfkdwEnPFPgLbLByIgJeBhXYgI78MDoCzn27N9K3xlOrm09QQbW9L1JSCao7zMlvdGZaHF9nopd8Llp3wuXsyxUIs4riRpbNTHrle7QT28vlq0qXAYX8mKrzt3fBHu0n6y/QFl08cS2JAytBy+/j+eQuWap1afms++to+Jv1u8YkuLTWjcuFPBypKudLhk8gQArU/uk4+8Cr5ptuYV4H5VX6c+TjhUh039VCm7nUxejBdtiyKdFUpPnhuq0+Z4Gd3jp9ZhtGyVql6ch/Mx9W9LI18S36KoIWpNMk0atyWBxMOdYjO4kGyqwHrfA3uClcV+v4OKgyST42SxNrXMj35zhVZ+VZcgYdBwE0L+olzBN8JtESPN+2a4VsfwKsHanNPytKDcm7t8NEWdtBYlPA1rQ7jo+7uw+1H3nDlMx3vqvkdrPEz+vEun/96aZ50Qx3S6NccaNzoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9436c7dd-4cfa-460f-1217-08ddf6b53629
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:13:51.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IWihjtPN6NOs+clgqVVtm0GF8yT40b9ZixvqXT+2mzMhalvBo999AK0g+Fe37njG2i+DbEBrBw2o+EBbXFlEKe9JlJ9sk+9dJL6YtiGX/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180123
X-Proofpoint-ORIG-GUID: rYplyAPDFJLuHxJiLc0Owdrk-7PaL9zV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7yBJkHzBQd80
 uNHZR/QWEqS4+YoawV/WcExkeUGnZOu2mbUdLswa7oEiFU7DoYjogjlR3Zkszz0WHDqbuRMYaXz
 o0qVyv3xh/sYcMATgcipouoKPic//JHC5qJGtM7HD9ZdpdQ1lOcBXtahuKeOjXFxqxl3DEltIOt
 kw+2KL+R7kEeDi/isVJo3BmqA03mxrYIP6rg6UUTbXalKbms8VsAGC/Nz+23P8noUvkryhNMtXJ
 IMUKMFFbKsELL6s6lCTSgo9VAnX6rMIKVS+GX1MEehpQlnNxG3sNuKPy00CH8Wkquyic31b+A1U
 xmZQbHLdzbLm0wPLQ2i/d/ZGdsynn2fGSw+7DyiAKE6mpjwvM3zCIjeYABeM0SlIM+9vGLjvv6I
 wsn1f3JpWkdmfD2lylKaNx2K649ReA==
X-Proofpoint-GUID: rYplyAPDFJLuHxJiLc0Owdrk-7PaL9zV
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cc059d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8
 a=nRNfCKwT79iVDUcoIfQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083

On Thu, Sep 18, 2025 at 01:30:32PM +0200, David Hildenbrand wrote:
> On 18.09.25 13:21, kirill@shutemov.name wrote:
> > From: Kiryl Shutsemau <kas@kernel.org>
> >
> > The finish_fault() function uses per-page fault for file folios. This
> > only occurs for file folios smaller than PMD_SIZE.
> >
> > The comment suggests that this approach prevents RSS inflation.
> > However, it only prevents RSS accounting. The folio is still mapped to
> > the process, and the fact that it is mapped by a single PTE does not
> > affect memory pressure. Additionally, the kernel's ability to map
> > large folios as PMD if they are large enough does not support this
> > argument.
> >
> > When possible, map large folios in one shot. This reduces the number of
> > minor page faults and allows for TLB coalescing.
> >
> > Mapping large folios at once will allow the rmap code to mlock it on
> > add, as it will recognize that it is fully mapped and mlocking is safe.
> >
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > ---
> >   mm/memory.c | 9 ++-------
> >   1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 0ba4f6b71847..812a7d9f6531 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5386,13 +5386,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >   	nr_pages = folio_nr_pages(folio);
> > -	/*
> > -	 * Using per-page fault to maintain the uffd semantics, and same
> > -	 * approach also applies to non shmem/tmpfs faults to avoid
> > -	 * inflating the RSS of the process.
> > -	 */
> > -	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
> > -	    unlikely(needs_fallback)) {
> > +	/* Using per-page fault to maintain the uffd semantics */
> > +	if (unlikely(userfaultfd_armed(vma)) || unlikely(needs_fallback)) {
> >   		nr_pages = 1;
> >   	} else if (nr_pages > 1) {
> >   		pgoff_t idx = folio_page_idx(folio, page);
>
> I could have sworn that we recently discussed that.
>
> Ah yes, there it is
>
> https://lkml.kernel.org/r/a1c9ba0f-544d-4204-ad3b-60fe1be2ab32@linux.alibaba.com
>
> CCing Baolin as he wanted to look into this.
>
> --
> Cheers
>
> David / dhildenb
>

Yeah Baolin already did work here [0] so let's get his input first I think! :)

[0]:https://lore.kernel.org/linux-mm/440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com/

