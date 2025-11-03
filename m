Return-Path: <linux-kernel+bounces-883536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4005DC2DB76
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F25704E21C1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765EC26F29F;
	Mon,  3 Nov 2025 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K5c3U6LG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zV1UGfjS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4434D380
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195475; cv=fail; b=BQYfCOsklOLcnZuWcdNz68xBimZ/KG0vpZuXHu6WV8/e0H9ciAdKyja9iRzmrprt6J0gluzVZ26BOvT+gfrbC+hbDYCAdL1RhfeIBYrYk7qUrdk6uhHYH9OBFGP1xChHh6htawUmZvkx+jnpQ5jOZDuvO4m4bT7jQLZT7dacGRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195475; c=relaxed/simple;
	bh=8FpIVxKrLYizLiQHSrZ0afXCrIfLvEkvgC0EnSzJApU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MWoLHFxZ3QCJZHLLjAwAimwYhjtEH4hSNNufqd76/VqNN2BK6VykgVW3v8tIEX6ER0i2rGHlNRCs4WzI24tR0M0iQ+i+VrCtqe1TFegK8gHJVsicnsqVSokh5vr86wP/aNQVscH8N5QpHyqg7va/b+17sFP6G/70WIeWRf7thUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K5c3U6LG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zV1UGfjS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3IX2D6013361;
	Mon, 3 Nov 2025 18:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NWFe4LTuLjk9G2QhfG
	4Co44pDcOEPbVQSYvOkVZvXwc=; b=K5c3U6LGftUFLlUK91JbywTxZgmwiJabuK
	8pWDp0JpgV2J/h74iDnonRwGr23oA/xw5Njl+nJ9ufIPpKcJSRmZ7zVNeS1kk/af
	VS2Pu7POJ80CQG4Cfi+ilFIvUjX99sByYrJPjkRhWvf1D+zMsjrv/tt51ksO/Yc7
	y1Dd3kabgJOm13tZyt9hYU1d/pCNLsJPTk76gh1KpxkfnTSCbpiYI+YCREz/Lg1i
	H4IIMUs9IAm9HH49BQZTpN3G5AJ82lRQbWBIJWv2KSC5TwjprIZaJUwzKG+55G32
	6EicFL4nHd8MWYp7VufccO9OloQCDwkJaY8KJhe+IbA/ltGS2OVw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a71rhr0tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 18:43:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3H9aCF007341;
	Mon, 3 Nov 2025 18:43:43 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc2et6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 18:43:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBQhMRyaMlFLDUkzwDGh6CoFAjrD4PrzKuSlW6lSzM9ufDblx0Tu1ZzymKCpoXEnASgDkTc2WG03YiuHBEaKy6wehFHUEVzMh2vFZVAuxCAH0kDPnqRHiFkhNDoovp5L6hJrF9zpz82eMksRyyGSPDHFNuAI53pCqOxMXiqqiAxX78Oz1lYmQYfreAtfV7jPxixkappg+LNbDcF37bxegeX9Ic0wtsE4w78ig11PXpeoYBv+1MVVIwC2Jpse3sglu4/M2mHd/5bKa7uZNKQ7yku/vIBFO5HpJugeEui7OcPaKa8nmSUy8B2E7VnkBpRAMvvvtdczjrp/nyHQFLpXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWFe4LTuLjk9G2QhfG4Co44pDcOEPbVQSYvOkVZvXwc=;
 b=ySYnthZ2TJzHkG5XLDSPFjUVLGx/QeSiffyrm58fgtBeXFBpcyh15kZnnvbdG5fFXx97J2fb4syKKl4OG8+J86H9c3sjYS7S0ASXTHv4bnkUccDFXSIUPP0ikZ9OjzjYbECp5VsJdxT5J/LEf7AUQTUXeNnmblaR1IlNRX4A+FtwtBdQxs0bDnvIpMptN256k0Tx9CTPFhTAIyzn21wh62hSfm0TG3NTy0UzhpDoGh6BfESTr+iHyjRS7PpQE5YyRlU75uRjJ9ZAPaNC5RRSZCTVANJRxkYsPPwVxiTmp1N22EqVMPdxdXd2ZpKycYSnli4Hm7mGFqrbL3XjbkpMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWFe4LTuLjk9G2QhfG4Co44pDcOEPbVQSYvOkVZvXwc=;
 b=zV1UGfjS6QL4BslxCyuKl0fp1+ePiS4GXP7njiOJCd75H3/hr7cfyhumian9gN3dFHtQJ1jb8Z3jTHE4WuZFTT2bLepcsv798rMKaFZ4GdCECLjvUhCWDbIErcUvF9/zbpIfwm9/yG5ReDEm43AP70DFtU8ttei39Qec2aoUF44=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB5547.namprd10.prod.outlook.com (2603:10b6:510:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:43:27 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 18:43:27 +0000
Date: Mon, 3 Nov 2025 13:43:23 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <muchun.song@linux.dev>,
        Nikita Kalyazin <kalyazin@amazon.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
        Ujwal Kundur <ujwal.kundur@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Message-ID: <43lezmpxcs63qpgefapvjkrxmswmbloc4dba3i26pdxfoaycur@2bfofnrxlwjj>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Axel Rasmussen <axelrasmussen@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, James Houghton <jthoughton@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ujwal Kundur <ujwal.kundur@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Suren Baghdasaryan <surenb@google.com>, Andrea Arcangeli <aarcange@redhat.com>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
 <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQjULib7JriWnVTq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQjULib7JriWnVTq@kernel.org>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: YT4PR01CA0403.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c74600-2159-40b5-ed00-08de1b08e064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pvFTwi1522nUIjEBC41bGsGnB0Qou8XVzaVZCNP+uH2tKfENCEo6DHbEXrag?=
 =?us-ascii?Q?x1oYNq7V9uBC+y8JEew3ANGHhNFrdiwKIh/LF5ddrHcg3WR/D+bwL4WLSjro?=
 =?us-ascii?Q?ZB7JImlI7S0SGOFyzB6950RNXuIeF9e3R3sdSGzJrtz5KsMwVlQrz+kqTw3C?=
 =?us-ascii?Q?iZm+Uc5qb+KS50S6OkWHXKXirXQBklzaZ14olkdaNhkjwC9lyRaaCqrLeIk5?=
 =?us-ascii?Q?CxVMwoMMXjmccgXzWBbwE0zniwqkoOF30baITQdoSeHKR+igM9vqfFAgIF0A?=
 =?us-ascii?Q?aoEFVRpx+fhFmmkwNvVL8H0tHX0hyFKuRTZScNOzollrJyeLYKd+M6GfGn3C?=
 =?us-ascii?Q?LzJrUa2BC4CWTfg/mXJzDc/32YoWrVPyQ1hKJQldXUBuSH5oVGF8/rn9DYQv?=
 =?us-ascii?Q?P5U5XsMnRbBqIV8Okzvey0mo93utgPm+JIWxsf1g8TfZIUUjUsSty9/bDIX0?=
 =?us-ascii?Q?gUL11CBtJ1NfP0z+hP94KhjumB3m7R6KVidqX9GKTDove4fvgB/byP6gkrPp?=
 =?us-ascii?Q?fkDVG3PNYKSXomkyIdE+mqa/c0fPiYUMIRnHRyu/AaXEPF0QUJZfsVIUmpOa?=
 =?us-ascii?Q?nv33Z4UIRUgbaLxzxzfASg60hjr/2qYU4BCAfnLJFHyKdSyqAAVnm4v2wgPt?=
 =?us-ascii?Q?J7TBIFl8Zo0PPG/htD9nZ+PQ2XePn59jWismqQYGEqOmNrNoqIGHFmV8KV0P?=
 =?us-ascii?Q?i1bDVR4NI977XLiyPRQsl9PTjuJvFV0EMd9i1fH8rcfYmhSM9cWc8/fQbWfU?=
 =?us-ascii?Q?9uQL14tUkiwtxM+55wwfDekb4cUNq7kCycT5NykdI2TxFUq40CNercBtYVPj?=
 =?us-ascii?Q?B/KNHYZMu+ItuuOMRrpS0IlT42d6034holEmBM1paH96zLJvTSgWOhpQMZmd?=
 =?us-ascii?Q?jvqR1Mg6IgBogf8UNKNEN477nX0CLzHUumURXCQHdlRNN4Re0OBkFE8mjW0/?=
 =?us-ascii?Q?mgEP5hTdcODaCSAxuxJ1wbX6aYa9Y3ZzPPP7n4cFxvsq4vcPSy1mDxOO8w7o?=
 =?us-ascii?Q?11fAtpE/cfWsexuuceWJBatyRCfK+S+1byCgIcoKZi2HufAcvv9SY01WVF6o?=
 =?us-ascii?Q?qTbnD4j8XFSSUSZWNYJeVMSRIlyvlpcfRxBgbKv5W+8wS/gEpJ7oCt4oChLy?=
 =?us-ascii?Q?/t06hew+nc/y2/0QCbuoAp4AV0InxGJE7bs8XwfKlATKXnc9FAK6CRI6P+Ny?=
 =?us-ascii?Q?tVSb+tmomqK77WM/6HOvSonWAI3HQ/fBkh7XmvNKunPmEnpPSQ15LPvDpEVd?=
 =?us-ascii?Q?hgPjipqh5FZ4OiZQgF4keeDk/bncyur1sLeOSuj8dPJUGmHmaSnD0kia8LPA?=
 =?us-ascii?Q?Q4mGScoGn8SC5HhL+LqHfa2yQ5Ys5I99DWvQW92eBkwBnnHgJCDF3pRIVBwQ?=
 =?us-ascii?Q?kW65mgvMluzpMaUV7RbiTCv6gIbuMaxPdNWQX95FCtol7kDL6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tCUqmfrpKdUVvQOEP0G4QMLr2EisZRoDoOy1NAVR0ATA0riSAVjPZTifAhXn?=
 =?us-ascii?Q?NEOev74O9sygbNz76K/Ze13TAVAqXl2HREmBAdx3GrKZkYPKyow1N1yA3XrV?=
 =?us-ascii?Q?OEYgz5zGHVVQEMf/VU/ZBxSeTxm6mNIukH1RkgKsSbDIZ0+VuJvnxk7so3O4?=
 =?us-ascii?Q?UKdYBy4MzD/MjcteHKcMYUe14VUsESNdLNFpvWOuaZ/vKP1wJV1CpsraWQEq?=
 =?us-ascii?Q?u6ldbKgBrLZSwFidHO3JVLXg8iVflPdyJppBbhDHzbuyX4HIYp7J8gF/Ew4m?=
 =?us-ascii?Q?aQfPd+Wcpwyjcne8Kl6HwHyLQXALkCgUoDkkWr28D/Cqdu88NW5/QmDsMg5z?=
 =?us-ascii?Q?Q2CgVJ6KOfMcgledC/8MhkfWHx8i9e63a21X80PSH0bH0hVfWYcRUfpdj+Lp?=
 =?us-ascii?Q?X8eJht6HjkJoWrPo6lkdPsxXab8DQ4jt1R9Nn0rwC2PovtTjtUt0SyPk5bGW?=
 =?us-ascii?Q?T959rGFSzNZyOxKokmz45Tv0S6TKOneHUanrwclbziEon/qE8zVzQVonAxUz?=
 =?us-ascii?Q?8GFJgJ4B8ghOvn9Ko9FdWSARj9fVKe0R1TEkNbhANsN/nwsFwhGRhrq/sa+/?=
 =?us-ascii?Q?JVvheseO70UbAP4HlobcCQJYfF8wwwhiDsplDVX9YW+dEbAxgyD+D0Jzd2lE?=
 =?us-ascii?Q?Qrc3bP8j7P0UzEzZVRA8f/bIjsM8PbvgGU5X/Q2WN+SRLWFH/N/ZSWU+6HzC?=
 =?us-ascii?Q?rrCqu4UugwsF6w7ysFReLxB3SQ3wFg5mE1Q323ub+pzDpE0I2F3jSdb2eY3I?=
 =?us-ascii?Q?9tZ8zQegVsara17Qn/AZxnlroUu96aVER51lpWdjb2i2BDVonWiFZcxWtPvg?=
 =?us-ascii?Q?QcAE4YxOz9X5btDor0mfQDfU+zg558kyTmWFzNtPxoJ2bexyeP0kebbcMpTj?=
 =?us-ascii?Q?iYlhNmzo9UqiiRw/h2ih2Gzvp0ldi7y6zON2N6p/M0VGqSqeCh1SDoxqkacx?=
 =?us-ascii?Q?9E2J1M8ihhkniau+pVyl0G5W1LL41YdcS45DILbAAKTlUgjpKn2DzsS/cU6s?=
 =?us-ascii?Q?JN2HKxph+aYJOqRQV7HyE7y+mBUypceDnXR4/ch8fG24H08mmDUtOU0Cof9x?=
 =?us-ascii?Q?726hhSGLdsCuKaHlr6L4aBDryLAH+qr/s9hge9Rz1OtVwRclc0TfyKLQ9axl?=
 =?us-ascii?Q?rfwrYjjHLg8YwE2lNYZHIRbZOm5ples1tJTpmMvlPRUdikh0yZaQHeBe+teZ?=
 =?us-ascii?Q?TlDO2udktUpEtHCtMQI/rTfo305oS50ilR+5pmqjqXiE2sGujzB5vI/uRj+L?=
 =?us-ascii?Q?3LZR1hp+G6lT/TMOnpOSEa9Eub4YMNFbb/VR71SAQVD5JHubsOBKUDuJPkEO?=
 =?us-ascii?Q?qDk11AnQpRDqfjRPNrFycfrFvswE56xzv6jvcR5b/jyYXGgRuYsSbjYF9+7j?=
 =?us-ascii?Q?R+c5S6RFPYmP3PVb8/Cqu9RBprMCxLXTRwrAdfrenFSe7doC2t7vfl616E44?=
 =?us-ascii?Q?LcLyl4oWwUF2nrwUohlgrsHhS344KFnE+f4bPBq0O/OnsoMThhDkmll6TYc5?=
 =?us-ascii?Q?bS7QhKVYj6VfXxw4a8HjC66dhkD3YAb5a4VsY96ohhiFF1Uek6sDa8ojd4Xg?=
 =?us-ascii?Q?2eI0gnDXEnlEzaMf/8AvyoTPzLE6BjomW/9N5HyD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y47gKbEFFVB9xcz00fC7mAAbvCmlk7I1tIAgtlVNKWR8ySvHgu4aitiFjwfBb3pzIZ+GvhoCpEpmkMrJTxrPuXOs43z6PTtKWZIRocuBeuv14sCEjwK1tUEV3lNn2syQXSKC8Jr81AinPfJOf/5+8gwwn+JJNYIjbnlv02oEybLUeNe70CazMdc+hQsLnwArmz48rQ1m7fNivGGvJA18DGP541itTRccuqQd4iAnBWBOtXudmF+p4op0eIdbFUI7y2GAOPsUkwJqh+CHBiUSHyyqHgQCjVQ9hMJQZniYuUsSuLychv62b5g642hZuyhQ98uAkl+/jRJPEo9JXVENQpHD+xDdrytcL4U054JR0WAELdqBF44YFqbK3HgR97hskcOKqDf+tC98/V+ROTXKFbmbywboFf4pYnpAEk5U/hRfGoFzcQPlcZgliyYLf2IKC3yGsExINOMYcoJQtypBK55yqbX3QnlmFRxZbD1QjFnjCCpkAuuDGQiZEX9Ljrb5Wv/QU0n6KVIUADIB4M0E6Lxne0tKL+W2TqpburIYzoSW14r4BLd2S96ZqMS3brhIPfSaNvTvPpsQvd/9h+o68ABLU925JuawC88xTiG8Q+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c74600-2159-40b5-ed00-08de1b08e064
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:43:27.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcP/XYtf+0uj4MgUWBYc4rkRWBm/H1hdAYvJnHmzzZPVn2+8v8T7F5Gswdu/bNCDzkHP/BYoqScoVUf3BZPdBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511030168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE2NSBTYWx0ZWRfX1lOUGy1/pCZZ
 NHCatCOpCug5AC7Zr3Sfh2IaiHmhGPpzqLSBjM8giNAZgjPZZv60a77dsAM4bpnKOutyn4I6dCA
 yni41qw47Kkpsj2oGbb/7yKUOq+3lluJ23aKJZ11w/wr4d58fZhwY2q3lZtw6lPgQ2gs75hzEQD
 tWzGbpL3X7gFgiWPBWxu66G6X6DZFmq0UrDOpmDoIBNrbitctpxuI873zwDhVJ8xYo4JBB8xl2o
 00/APPDEEOCwOlrV6pXe5vM3tWdsG3iS8nEQzLXgUl2+TZ0ieTjr/TpOmfEBjSTothGJfPiKBDF
 UjS841OwLJVF4vSXZviMFL0SS5xbE9onESTDxLXQMTwXA2aEB9/ACl1Qi7XLRYjnPKli4WRDKmX
 I/0l6NgeVGCzKnF9bArYh6se9dHNd6s6MtjEBQCPwETgnTiA9gY=
X-Proofpoint-GUID: xFswHL_svJVdrStgUJgaoWQC4p83mXmh
X-Proofpoint-ORIG-GUID: xFswHL_svJVdrStgUJgaoWQC4p83mXmh
X-Authority-Analysis: v=2.4 cv=Wtom8Nfv c=1 sm=1 tr=0 ts=6908f7e0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=KOH09V4hbT4ynL-JawUA:9
 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12123

* Mike Rapoport <rppt@kernel.org> [251103 11:11]:
> Hi Liam,
> 
> On Thu, Oct 30, 2025 at 01:13:24PM -0400, Liam R. Howlett wrote:
> > * Peter Xu <peterx@redhat.com> [251021 12:28]:
> > 
> > ...
> > 
> > > Can you send some patches and show us the code, help everyone to support
> > > guest-memfd minor fault, please?
> > 
> > Patches are here:
> > 
> > https://git.infradead.org/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/modularized_mem
> 
> It's really cool you picked up the gauntlet and invested this effort into
> refactoring of uffd!

Thanks.

I have found that a few places really needed attention to avoid
expanding this code into more middleware.  The existing code has bundled
all operations through one loop and now ever operation needs to check
for special cases even when they cannot be triggered.

And that loop is duplicated for hugetlb, so if there is an issue then we
already have to fix the code in 2 places, and we also have to check
unnecessary error conditions for 3 out of 4 operations, in both loops.
This seems like the worst situation of both ideas - multiple call paths
and unnecessary checks in loops.

> 
> I agree that userfault code begs for cleanups after the sh^W stuff has been
> piling over and over, but ...
>  
> > This is actually modularized memory types.  That means there is no
> > hugetlb.h or shmem.h included in mm/userfaultfd.c code.
> > 
> > uffd_flag_t has been removed.  This was turning into a middleware and
> > it is not necessary.  Neither is supported_ioctls.
> > 
> > hugetlb now uses the same functions as every other memory type,
> > including anon memory.
> > 
> > Any memory type can change functionality without adding instructions or
> > flags or anything to some other code.
> > 
> > This code passes uffd-unit-test and uffd-wp-mremap (skipped the swap
> > tests).
> > 
> > guest-memfd can implement whatever it needs to (or use others
> > implementations), like shmem_uffd_ops here:
> > 
> > static const struct vm_uffd_ops shmem_uffd_ops = {
> >         .copy                   =       shmem_mfill_atomic_pte_copy,
> >         .zeropage               =       shmem_mfill_atomic_pte_zeropage,
> >         .cont                   =       shmem_mfill_atomic_pte_continue,
> >         .poison                 =       mfill_atomic_pte_poison,
> >         .writeprotect           =       uffd_writeprotect,
> >         .is_dst_valid           =       shmem_is_dst_valid,
> >         .increment              =       mfill_size,
> >         .failed_do_unlock       =       uffd_failed_do_unlock,
> >         .page_shift             =       uffd_page_shift,
> >         .complete_register      =       uffd_complete_register,
> > };   
> 
> ... I don't think it's the right level of abstraction to add as uffd_ops to
> vmap_ops.
>  
> As I see it, we have two levels where things are different: hugetlb vs
> others at the very core of mfill_atomic() and then how different pte-based
> types implement a single page operations, i.e copy/zeropage/continue.
> 
> So to separate hugetlb code from userfault we need something like 
> 
> 	->get_parent_pagetable()
> 	->pagesize()
> 	->mfill_atomic_page()
> 
> and apparently something like your complete_register() and maybe
> is_dst_valid().
> 
> But to provide hooks for shmem, anon and potentially guest_memfd() we
> should be looking at callbacks to get a folio to populate a PTE, either for
> copy or continue, and Peter's ->minor_get_folio() seems to me the right
> level of abstraction to expose at vm_uffd_ops.

This was entirely a clean up, nothing has been exported.

When adding the guest_memfd type, I want to export the smallest set of
these that we need.  I've come up with a few ways of doing that so far,
and that's why I was asking how to test the guest_memefd use case.

Both ideas involve splitting these ops into two: external and internal.
We can either tier the ops in each other or add both directly to the vma
struct.  I'm leaning towards embedding a second op into uffd_ops.

We can default to the common cases and allow the hugetlb code to set its
own (it could never be a module anyways..).  As in the example code I've
sent out, you can see we can fall back to defaults if !vma->vm_ops ||
!vma->vm_ops->userfaultfd for anon vmas.  We can use this same method.

The other thing about going this far was that, by the time I reached the
point of having the targed mfill_atomic operations modularized, it was
very close to being able to drop shmem.h and hugetlb.h from the code
entirely, so a few of these exist to completely decouple the code.

I'm not sure that it is necessary, but I was trying to show how to
completely modularize the memory types, specifically since I was asked
how.

> 
> I believe we can extract ->get_folio() and ->put_folio() from
> shmem_mfill_atomic_pte() and call them from mfill_atomic_pte_copy().
> 
> > Where guest-memfd needs to write the one function:
> > guest_memfd_pte_continue(), from what I understand.
> > 
> > Obviously some of the shmem_ functions would need to be added to a
> > header, or such.
> > 
> > And most of that can come from shmem_mfill_atomic_pte_continue(), from
> > what I understand.  This is about 40 lines of code, but may require
> > exposing some shmem functions to keep the code that compact.
> 
> This seems to me an overkill to implement MFILL_ATOMIC_CONTINUE for
> guest_memfd().
> I think it should be able to register a callback to provide a singe folio
> at a given file offset if that folio is in the guest_memfd's page cache.
> No reason for guest_memfd to start re-implementing locking, acquiring of
> PMD and updating the page table, even if it only needs to call functions
> from userfaultfd

There are certainly ways around this as well; a guest_memfd and shmem
function that passes the pointer to the core function comes to mind.
That would avoid the safety concerns about handing out the folio.

We could also have a single function pointer that is exported and only
used in shmem functions when !null or fall back to the default.

It's not unsolvable and it could built on the fact that this is less
middleware and more of an interface.

> 
> > So we don't need to expose getting a folio to a module, or decode any
> > special flags or whatever.  We just call the function that needs to be
> > called on the vma that is found.
> 
> Agree about exposing flags to a module and about limiting API to functions
> only.

Unfortunately, the middleware and flags will continue to grow.

Given the tone of the response I received on my clean up work after
being asked, I will not be continuing to work on this.

Regards,
Liam


