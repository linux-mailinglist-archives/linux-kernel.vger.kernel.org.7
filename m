Return-Path: <linux-kernel+bounces-788012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7917BB37EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CE27C6E35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B430BB88;
	Wed, 27 Aug 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VDPxkm+/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UN2qKdn2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66532C30F;
	Wed, 27 Aug 2025 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286762; cv=fail; b=LH5YzcnOscKo5YL/OpAVc7UtF/P+VODIa9RGaiJqgmW5fffG2Iocgthg/BfihAuJcQeTAj260whwWGvaSxx5llU/irJn9LFtCA7iOixpHzKaIdzRVEWMuiEWrdVDiFEeE5+/IgGusqLHxNgQXDfCuKqRy5/drP7esLhw7Kyi+lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286762; c=relaxed/simple;
	bh=ZjJ0phVbjmU3LKiviPKG0Nxsr1daifzteYwRLITGcEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FTec6MeJN3OeRWSPLL10RhsgSrag4zwqjI4Bb7uQJYwuEPXR9MvDA//LsmZctJIkcn6Wsee7Mcr4yyUIZUeAPI3YiFAxFMTXdE9aAyuCFBgU4y5V/dNGm8PktzMURLQjWPgBeDstkBi7jI1xgrThoeWq1x+UkYJ9QbaI79wI2yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VDPxkm+/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UN2qKdn2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7trCu024137;
	Wed, 27 Aug 2025 09:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ZjJ0phVbjmU3LKiviP
	KG0Nxsr1daifzteYwRLITGcEw=; b=VDPxkm+/Uao/2GXjPZA3KLz+nF6do2Tm1O
	x2ejtECQWNUFMlD9MYtia2Mb4jt8KPHgMzkKcyegnzAigzRHHaWmG6cXiCT3teCw
	DarEVrnwdyLTPBcqDjQ4GlFZg7tVGneL5FpxhxhSaJFzNIO9XqvbZCnFvhFzl2b/
	qeyeqM0z2TU+Agk9E7BkDMFf/bFuQnR1Fp7uZfo5s8Pw6CWEuNIr78puGq3a3mPy
	avhSbfBUgleow60+ufUWrBZAIQP16mnJs0h2kB3sSHHQeOmqqVmkHEWqmbKhfU0w
	Ic8H5eRWZaCCeMYHkNNbtAkj1KJCUbLuY9WK5usBO7sjCns1NwXA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t5xyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 09:25:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6v4uJ026730;
	Wed, 27 Aug 2025 09:25:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43adb84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 09:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rziPXM+5LTj/3YD03mZkTYtlrMpUr3pGUi3jFl+tqOl1ge85uqvA7wbg64WSPrh0Ws+cNK7VjuYx5sHPD1QXrUKqJN73bLrVPhEITcGJ+gBqr9vPgneTiR6hpNYThNuu4282MsI8tCNUoKVwWvumjnrRJAKt7OpFKusoXRnrIGomlKc9wzLg0liXZ0dDtRFaflg3dVIWQzmWwNMzPZhRGhfzHDyulKAeXv03hIzydH0WG9WTtyxGVBPr/bmL6ZDsAn5Xs+Zd1uXFdpkN3oUlZ6Vn0LVq660ojRXUXjYS2OB68Aqk1nU0HQVdZbaC7+5XZ2IYf2gTOEtDFuojf9wk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjJ0phVbjmU3LKiviPKG0Nxsr1daifzteYwRLITGcEw=;
 b=rAqbMw7zbi0DXxOOk1SzzKUexEsJOtOTuaInhgI4FzCxz/t/oDYDMmWyYczpXPgZtnYuywgtvci8KMmM5hpjM1lNW0TR3hnhggVCXF4uBdxSCXyxF8EUEYwxK46Q+CnzpPUY/YZYYlWovijw1Llk4CZ1D1qbFeP9xUPjcWlOUolYQP2tmIh9KJb4cvrj5sSwjCvGE3CPbXNJ/31BQc2xsMf71lfJkpkI2GLUUxEHFI8vLw7BXteK8XgHNvMK03+CpeqnpRrMyxjifgwBsceugdR4DHOzHvBC+b0JO9F5zBhY6ApGUpJ1Hb4NU0d9hYkNtZLaKQm/NFT18YV8rY+ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjJ0phVbjmU3LKiviPKG0Nxsr1daifzteYwRLITGcEw=;
 b=UN2qKdn2wfBd36eHr8o7aeibSQQodD4xDQCCs7uifcEFuHc5A/B2WgUcgt5QYBuTlO4bgjlsXwAYFRH9TAr9cvK/Fws1yH1hCfPAcjqJQvyQG8jl5+tNOZXG0W0HyQFCMdoYP0sVhJLTM2JGMPZiKFsitOdOWJ8+Cv24yvTEx7E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW5PR10MB5852.namprd10.prod.outlook.com (2603:10b6:303:19c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 27 Aug
 2025 09:25:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 09:25:29 +0000
Date: Wed, 27 Aug 2025 10:25:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/2] docs/mm: explain when and why rmap locks need to
 be taken during mremap()
Message-ID: <c6ee95b9-5fb2-4664-8c84-34a8283459ba@lucifer.local>
References: <20250826065848.346066-1-harry.yoo@oracle.com>
 <87v7mabl9g.fsf@trenco.lwn.net>
 <f64483ac-31d1-4f80-8fb0-fcf15867c6c5@lucifer.local>
 <aK2C-Wuv7c_yIOJ0@hyeyoo>
 <88b41934-2c3c-46a5-a86c-0c798fb7d2d4@lucifer.local>
 <aK6xRqeOgocTr8kk@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK6xRqeOgocTr8kk@hyeyoo>
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW5PR10MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: fe837590-e4ce-4027-845e-08dde54ba9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X1fB3UAjmqqZUtykKLPxk8WHrwUyHZiO1sJZD16k80oY8N80PV6RVbnSxez+?=
 =?us-ascii?Q?08iUjzOgHnwky/ndVc7bdqjgTBDtXMYCUC/dPvvrNBz8vdXWMk8mJJrodS6Y?=
 =?us-ascii?Q?SMaGQp5l20PNvpeF0k3hDxO+dLxJBzPNPsOG3CN65lbOSVujyjI35Nlp9zKy?=
 =?us-ascii?Q?mKtS9zGZDjwVrgrmdyD0uezmqo9MgISqFrqSkNBN+6bYVNVNBjwMN2no5tbc?=
 =?us-ascii?Q?f2b6Wc3Vattu6YHsVDQcWpRFpolwTm7aNCfhkm8l/zQDcZ+2ZMJXojynJ3ni?=
 =?us-ascii?Q?BFxZb8III3knoQ+UFP4Yhx6HnFguRKYUWxGY4lek6Pv/C4XcABuRmfcymk/0?=
 =?us-ascii?Q?fRscOlMvFDEBQP9PXhhpGecDLYT3kwSL01Cq3HuhTZ8dxOve59hfhDuHiTkP?=
 =?us-ascii?Q?a6W5OlioVxCC22oOrLeXVzrGAFZrqRUedhlkvutdp7JEGsEqkVp5TJSxitky?=
 =?us-ascii?Q?YgZMNXkKqo24Caod7Txd9G/sCb120bSCqf4f7laHpPUP/dgomaQMicX1kfTN?=
 =?us-ascii?Q?kVmnWKr4isBf7pDcodTU1Gnopk4UHxWVgTWhkgM5A1sAUPy0Q67EfRc41xxS?=
 =?us-ascii?Q?wRnAucYCX7BqhQUNJGBxWMOOjwsDAeMIQtkWZdHuA8QlWcsdE8iRuVczwn+N?=
 =?us-ascii?Q?Lq1c5ly3hm2E2T1Ex2tmFo/TGPRuId2LrwovV5KZgZjvj4lY6M5NsuLH8bDk?=
 =?us-ascii?Q?S3xW1vQbHmIVlrFF5YHKp+pkdJV/qy2cs+OnmQNiXY6Q0WDh5GIiq2cNA+k6?=
 =?us-ascii?Q?P/LUqeORgHH0c42rkKIaMPD9IAd2AImaHkEqbJWAc8OGd+n0/XtycZkUFlSg?=
 =?us-ascii?Q?knC1K8+t0YFgbHs+w/1+UFN70ZPhlt+rHcuBpAnU4HAYpytGguKSab5Dhh20?=
 =?us-ascii?Q?t0cAZYEU7bUmho4Io69pNiB61M6FJjUbnuK46Sqds2Q0u04gXTWq4wXA10gS?=
 =?us-ascii?Q?JAQjfjdIl7VRqD3PCMltpqZGZ3wXWS2erjE3M6wuFLR0uuUTDqdIYPc3XKVG?=
 =?us-ascii?Q?5po0T44T1WVsgFk+DXa8HavFJzBt2swB562bfo7kczwQBTiHcqRvMKOGrbab?=
 =?us-ascii?Q?NCU2bwEwDK59mHBkznKI0SbPSJy2Ts+xj0kKi4NE8vIAQvsa68/81YZLdgy3?=
 =?us-ascii?Q?E8RE2+MX4s33krc0DTkbEaSk2QWmT/Y4vBeBSWjXlUQo4SeCAGqhYyaZ8e86?=
 =?us-ascii?Q?XRq8Xylrb4T4+D5ijXA3vPlWiUO7CEZJzoM6+S9E+DyFcuLS97G9VzHIjHxg?=
 =?us-ascii?Q?Fj69ToMKbp2mFt3w1q0dFQ8B6YTuv0Okq1JHezxmRLYZEoOW0t93TYdu3Mqf?=
 =?us-ascii?Q?i//ZCkU/EAA2YfQ65+ML/ZGx3xTqiAlAFUasaWD4QH2TG9vogOcePE+cRsl9?=
 =?us-ascii?Q?TWTQpUu0ImogzTrmMNtZjCplKfvdZqAGL2Vd4EAa6kKrDTw9QI/i9nRovCSQ?=
 =?us-ascii?Q?6qsrLryAaO8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BDNAF6WHjVP1j8bu4ZE1ZtnkkqQU83jP6dIvyf0raPHNESCXs7EfZ/TgKjv3?=
 =?us-ascii?Q?3hkIG5hvM6BMQ2KQHPueKbZwLKQu1/aFBt/kOtB6KOODnb8B6q/hlE35Nuqe?=
 =?us-ascii?Q?O+lQdL/nFjeVVpZ0PeoHlBadTwKNqWg64AdlZG9eTu3Uis+gyIKoR+Jajt92?=
 =?us-ascii?Q?k/7+r37Sc5GIF/EVPzn0/9gSMvwJdZBhFbiF+KcWK/HOQhhu2sdO71TsLf2p?=
 =?us-ascii?Q?ZlZ91odHZpNa0A+yQzGOMQkpfmmHMSS/+NUgxkDCvFQV4+GE+n0cCqUFdUyM?=
 =?us-ascii?Q?XFiEckR6jUi2MbTcvBeHZ7T4Ly8/xAbN0RI615IVqKs6okkPc1dDzojRcXMd?=
 =?us-ascii?Q?4tvlYZ4ZsmEvLeLhs+5gcXY/+FGVRXWeBc1Gsrn/CgimOOl4zlMhrYXVXpVS?=
 =?us-ascii?Q?6XbPptGWsHO85a91vLAGq00uFm8LkycOc1yUaO4RBMfz90cFERDFbYAZewC/?=
 =?us-ascii?Q?eAzLZeD/G94AK2iXxGN4B0Wlvw2TlUB43SS2+5CGebryuDtHi/5xmQkyGDbu?=
 =?us-ascii?Q?XUN94p60YnrRdMqkhsHmLz/KQ2QHrC3hX950ajwFOO7DgZWJx/YfSr511uVK?=
 =?us-ascii?Q?tlxl3pHBvVmRXvgchR9u/TXahrSfR6a5xhMH5TZ8HMGunBgz2eEJnTNYuBn7?=
 =?us-ascii?Q?fn3YW792HfH8vOS64CScboN123P2b1Bg5scZwQVRQsCoD2WtzIc19tOu0eqX?=
 =?us-ascii?Q?jbS0JqNDiuG2e01T43K9C9jcsCgFJ0THK9hLQBBtOuemqX/5wzflXGol6NCS?=
 =?us-ascii?Q?5bKb30EFf5O8LeAiPMXQmtok2dgF/cSFQOL6OmSK8UgKyxggFAY9Qds3RDvE?=
 =?us-ascii?Q?KlA+cJbwb35sqLdhCYGQJo1dQ03L2mIHetIgTtfIqhKvBaY3/3EfG+Ep7vMJ?=
 =?us-ascii?Q?p+pPa5uS0Bo+Ek+FjgVAT/PnmwTaAayglrBKnF6unle6rbPtCAQQ84hS4W/u?=
 =?us-ascii?Q?WQ6i/2UyF5m42n9mZO2RBvvNQH03kn7YL4HIlhHjI2sgp+H/X9tjhTxx2y+A?=
 =?us-ascii?Q?9wIqkhAMmkt/Oy2NzTc1Yb9Fe2M7EOIuKoceD2ZqfTD0XzeFCtPXNV5STbs/?=
 =?us-ascii?Q?ut22GCq5S+W/5Yy5rkosoCbUpKAJpg56vCXxrRztVR/fW4OKO+I25UO8rCEK?=
 =?us-ascii?Q?V+E/cCl7NW/NlapUDjg6DCH8Tzne+/uACGU0wkFL1CzJ5ILcLiNod9fyOTJ9?=
 =?us-ascii?Q?gI8nLA+64CGj6dRS9hKzoLtWF87GxOWTiirT3jI70kRXjxwiXcyius+7DgDa?=
 =?us-ascii?Q?O9UOh2bL0RCuNrxiwqd7Alkv3jETHGarFB22muWj4S2IFQOPWYICfuN8yuqh?=
 =?us-ascii?Q?HalxxNf7yxRJB682+T60k9RrePCsxmOR6lfUvLzNpK3Ed+TmRjVTauQ2jRMA?=
 =?us-ascii?Q?dM985elN65II+JoxxAvQn95cicRH282MmAvwnCmGCpcb9A3TVxv1AzpCcJs4?=
 =?us-ascii?Q?2R0G16LPHqkvTan5poEAWqJUKu7DjC0A/Wkoy0APEc257/huVVXPHE/nozZ9?=
 =?us-ascii?Q?uC4UmzLIb0FVVw9pip5PRxEc4eggp9Gh9LcJI31qLzK2RTbk2mV4kAAWMwnO?=
 =?us-ascii?Q?z3OcarlqabxyXZ5Jt+gYtGL+8q9yFX6roiA1qEcndWzy+VGPD1WoYKuPZk2d?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F8T4J69Gd9/DMr96xbWhrEYi+ZBWP+uAKqPx4XpQMzOA8vERbljYC5bRkYUd3ZqaItYojJMTytnfGoZ85QnkXV2OD0TZsOlfn0Kz+4JYZ2SLUbmE30FLLhSIMU5G7XLZbBJKZS/NGrd2mS+M5tkq7e4d29WbbC+MI3RlCGhpsAgADwmWjPbJ4A0c9jf6qL0mCt9QKRGDogmL9QyhuG+/B80hxbLGh0R2auLUeCJ6o5vb/sOgorJa8DQQen+ejHtHd5vpZeiQLE8GH/rfzkIXGWzA06yjR4vk3Dw0YcxZI6KwRgDWG0JpK6+BxCkAYcD18denvy6WspwwE2vjOjjCsAFPD6FFZPEJS3NyqI3XgnLkI95IE3uKao7T9I6sSNqNOdj6/Uu6tKbc4zptgYBrSI6w2WVNkrS9LPAJmTs1+KdOsbsa3HzauGepF2ZUP9UxD7URuaS06On74Q/JoGP89jyvFX6xL9tu7dpyjIjeZiGJdjrGo7b1hN86R9WgSsfvjmhbHdzrTy68xjmnchDpYMXB4uF6RM0s/jOJ8sB1enN97Z1snUGnPWOh67rSMklA3fqs9ULtsUEFPdBf8HKfbRdfzQ4s5jQTX79inRbXpOk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe837590-e4ce-4027-845e-08dde54ba9fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 09:25:29.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aszr5c+6m6ZMJ132VSuPYjL1sAlqpEd3h+pCFu1Uk5Gs+tQ587n4qpdRBRb7ZiIflZxR8PtqpLQOpzVCmvW+z0DldfpThK1qN9lxMbmCCco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=912 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX3AQA11nS+bkJ
 ECi39jBQx5QS1N68D0zfAEnA/q8odqEcfGxiZQbdemGZJbPpAGIkwPvcvcbQsUth3bqXZW3szp/
 kJIwrJXW7UdkxjcWiv+VJKq+rJvaIbPKMUWsw4sHal9qClyZuc1F2XlGoZ3EUV28ApPNYB+KLYX
 HwQad8dtvAYGJhSbZoSo9s5HGbKRVUZPr4gZNMD85dCSMcMGr6rBXeUGkXyK3NzFNxKXyOOjQ8f
 fmH2MC3OOKtYSvGEF6LW5l5x8mdhhedGX8cr3mCGOMfOU4ublIJaBygG5gH7qXfLBLi7DSedA2E
 R8X7t7yg4H/mMC/Hacm8+CKeTTqUEXYsJbwFKbiYWc00bxGqSAw1Qp9s/Adc9xIwoosoprcd1qn
 l17fu+8J
X-Proofpoint-ORIG-GUID: XyE1O3xzqQxS-UTn9n6yRfU-4D32BoDX
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68aecf0d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=4AVGJx0W_eEmTjD94moA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: XyE1O3xzqQxS-UTn9n6yRfU-4D32BoDX

On Wed, Aug 27, 2025 at 04:18:30PM +0900, Harry Yoo wrote:
> On Tue, Aug 26, 2025 at 10:58:58AM +0100, Lorenzo Stoakes wrote:
> > On Tue, Aug 26, 2025 at 06:48:41PM +0900, Harry Yoo wrote:
> > > > Yeah sorry Jon on latter bit, I did mean to get to that but workload
> > > > been... well you can see on lore :P
> > > >
> > > > I have a real backlog even more than usual right now too due to daring to take a
> > > > day off on a national holiday here in the UK :))
> > > >
> > > > Harry - more than happy for you to do the above as part of this series or
> > > > separately, will sling you some tags accordingly.
> > >
> > > Okay, I'll do as a part of the series (process_addrs.rst and memory-model.rst).
> >
> > Can you please though make sure the formatting is all good? That doc really
> > needs the function names to stand out, so that's key.
> >
> > I _think_ Jon fixed it so that should work fine but do check first!
>
> vma_start_write() works well, but it doens't process
> anon_vma_[try]lock_read() properly. (only characters after [try] stand out)

Hm strange, maybe keep what exists for now.

Jon - any thoughts? I can't remember what we decided for getting formatting even
without kerneldocs etc.?

Cheers, Lorenzo

