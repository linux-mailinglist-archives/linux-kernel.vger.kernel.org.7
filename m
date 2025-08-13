Return-Path: <linux-kernel+bounces-766077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8733B241FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405511AA2648
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16192D8376;
	Wed, 13 Aug 2025 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OI4xtjVz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AUn6b+9v"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A023D7CF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068027; cv=fail; b=Evo82aW+dup8IbMWUaoATGGd7tbgvCNT/iaHSxAn0YybJsCkSlku3VfMFpnWyLKyU1Tg4EZZanlGZVM9M+faKNot+brda1HEkAyupsLNo+lZDQK1SVf15vvXuyUGdq5Av+RBCh1iH/be8Ta4cBnHJ0LkfH2txXI6Y/5Le+iLayg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068027; c=relaxed/simple;
	bh=Vyuhai/Rx8WkMRD/lfO/0nqJ0xcaxa9fXRELmxrOioo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZIGdOe/x+nTe/HLj8Jsv6D9SIbuV74Dr4Gxm2H8eRlZ7FO/20j2Un7jt6sewP0VLqcCr5m1WeaprtzZATtRQZxq9EHfTUo2Gb2qdOMiZrn6UZWjV36luxuIB/9OqrDlUIKPRIwOelxt4/k5Ok2Sfn7TlFKuK4QIh+aZLKplaKjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OI4xtjVz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AUn6b+9v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5u2qL025270;
	Wed, 13 Aug 2025 06:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7L4CK8nir9mhTiEDgA
	SLUehE8k0Pu3g1LPwJanCdcG8=; b=OI4xtjVz1Sq3DqJnBr5CW2066C3d+QcEq0
	Qyja3B2B+ZDAGS7NxtCDkNMpzWYqRCVjYB0XqCiz4MvAo/qrViriCSMVWwTBJt8L
	5UqD5MFKyUQKHffZWSYv0zVy7LBbhO6oD4e5PNOeOl44/ekDrBdXKdPxsYXwtqC7
	RpWHc8EU4ucX/ToU6oVYTgV1fSxUJg10pfJTp1HpkZKfApZ/DnEkIQ5MKKH/rDNl
	1oQJ6FxYsPwK6AA+1xCqTdohEdz3gj00Cc6IXzA1hldKynKY8N/Xf/ABP51xeawr
	vzgxk6EnQR6XoTvOvt0WPOet3PKlZaBK7I/te6tsy9lzxDyPQY+Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv6gte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:53:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6qk0f006413;
	Wed, 13 Aug 2025 06:53:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsat1c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:53:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGLWUWaTj4nnOUZYZ4vJ8jrhSJb+Yo9fu1UQl5t4+aA410t+5UWGbgogdo2xqmf4bFgPP8IRcYbkYR/8QatIEcyw6cDXNIkUP9vPTTHG9aF3PMaXyGdoKPL9LQcZb4APH6k4EHzFOaP9AC/kDzygRiyRGqI5EkDU84NU6YBGehLUNLxu6qB/9kC7QSzMNqN+kZDMyUNjEVOTRLW4Ec5eSr3L/ALImvagChpX5niyLCUg9gkk70M8tJZnipp6DohEIjWfIZOVYC5f3m12MXwK5J/iz7pPAMuzRcI8zCw7S2Ma/1BphI7wIrQu+2K2LAKRgr+GGjqVpUJhlkEXOMFOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L4CK8nir9mhTiEDgASLUehE8k0Pu3g1LPwJanCdcG8=;
 b=mJSU3rA6lfnwdUmnjV+cERit/aE46tXKGB3C3PgP+UfsXbnGszG0Ud+xeODI9jR+rBg9WMscpLM1wD0FbLCbnoY4gYhWE/+91Vl0FgW8Yy3gCZkjG2W8+w008HFSRZkNHF2r/uWicGcQwVlT7D80tUJfRdMmS9yCoh1onbd94G1pLWGIaNaOWO3XgVRgejACMJFuYsWQAdAh7Wlt/vZmvgjIPpYKzcPM8oI01OvnrhR8Eu1MJnGKmPvYo09pfvhPLs4d8woXjwwwDl9yx9lp5uyk+uZCFozEFbwUMLEgc/jDS0cRlP0uAfugBEjiY+rTwb7i6bUcbvtei6lQqBMK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L4CK8nir9mhTiEDgASLUehE8k0Pu3g1LPwJanCdcG8=;
 b=AUn6b+9vAa05+9v7uid1bwq+omLxawPWdxFmz/ON1K4CiWPYjQtNTyMJ6gHcxoWb3aEbQOiExZIuGXRK8uge/uDh+4egcyYeL8lywCe29n7PhwPk62UeSNwrMTDhJzA1nY2Sm53FyDEWuqWjHJTDy/VD42eT5mQ/bK/8ufucfzk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6213.namprd10.prod.outlook.com (2603:10b6:930:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 06:53:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 06:53:22 +0000
Date: Wed, 13 Aug 2025 07:53:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 14/15] perf: Identify the 0->1 transition for
 event::mmap_count
Message-ID: <4cf77c42-3e13-4191-bd27-6ae62ce90318@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.956479989@infradead.org>
 <20250812111522.GI4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812111522.GI4067720@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: AS4P192CA0017.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: fb43dfe3-26e9-48ac-ab19-08ddda3617f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WN2fn46IfRQrShi3Xh6G2kv9BunwQrOxgHB+ZWeUGB5Ynq3ctoqwcEWCCrcN?=
 =?us-ascii?Q?en3vmOEHmPqpnnzE1E2UoUY2zlJPhpj02l/CLl1uiAqE7t8b1wbBp9RD6XIQ?=
 =?us-ascii?Q?nVkJIIB+hzfcSpJwqGdfr7+g/PaI052jQJTnwI2x+w/0x3h4jGSr6ethpLlX?=
 =?us-ascii?Q?foTLMYAjbqGIdsPoX7dn7hRdicKK1S2IqiyS9nNxpqAunij+uVG6b3I5eTXh?=
 =?us-ascii?Q?jf62miM/VoFhOyQANYVq2LGIZVJIHluYQpomp8S0YGTvf8maHiFcQvGShpQ9?=
 =?us-ascii?Q?PaIGkl34M7LY4/auBm3Gwt4/p6gryPT9xQ2xY2/DGm6JLehnBm8TPT+f3XCq?=
 =?us-ascii?Q?UnkYS8GVPrLSGHfiCMYAs+QhLwZuWOScbBrXPDxTdOGrCxZ3qxSe+RkOiL/y?=
 =?us-ascii?Q?fV0xYsUx/RkGHUdViSyIdQRWtmP624P3HLJ2qvLaPLfcPM8eprMCtJdI1pnn?=
 =?us-ascii?Q?yURbH1B4PbUL58XMFUuQBl7PyAyq49V0fzWjgk2G/a6w0q0fSUhgXjvoa8N0?=
 =?us-ascii?Q?EM39iyhsT4b8D2wsZEzW1Dd8J4r1JsSRSlOd+AHiv7BHpf0UlIbVUJiXbX4h?=
 =?us-ascii?Q?nN+wyohLpNraOkxbCjfKLFgV0lb0f7RA8/Fol+zgeuCejCDN4H0oCwXhDfdt?=
 =?us-ascii?Q?1elWV8TmuTzsK9xuiyYH3G+Cm1uZEO3sbGHCP+lyol4UabdgjEXVWfI6qmS1?=
 =?us-ascii?Q?WXz94UEH1pCJNwRJq4T38dYEC2koWnvTf3xBzMTCLPl0FoTTBXqb4qBzMBl0?=
 =?us-ascii?Q?3qPbTs+PCIv9DwQVNEXuqLtVaditXx8N3mjSkt7zAUM6w0l51/iCeN1I5SCL?=
 =?us-ascii?Q?g3jd+oVtQItLn/on3xhR5L7n3A8aljwSX6eLFvo1Sf4xqDS3hfowVyWQybpD?=
 =?us-ascii?Q?I8sz1zhlACfwwMh6C0WHpxCbBpd/URdgYvNkkZLxmYeFJ3g+9GOmfn1QyXWM?=
 =?us-ascii?Q?yhYZF8A9JHU5cGYPShjsQoRbSL6LVap3924wqWt1eWdpbjy6szBoK9M1lcXy?=
 =?us-ascii?Q?SUmyuIukBuK6LkLyYxRSW6dkOu4NELXHew6q7gCrk0B4eSdw8//EhLMDOSPJ?=
 =?us-ascii?Q?cX2mjoEozKxlmVGUjwax+lOZEOf/jocqths+LRCXdnns6g7pFtLCMJ1Co/O8?=
 =?us-ascii?Q?nA6k5DuolwItrRG1TfMWY7ULzDZsVn1ROde/8Ojotz/IJvAnrVtSTZJ6B3qb?=
 =?us-ascii?Q?WMjdooNOo22uXfFJ4N0QjMSF08Un0EPYI9pKL4VujepFy9dVv2nPCNi4lcGF?=
 =?us-ascii?Q?A89mmgEFH+xYIHEqGSB4BReaoPQwGlmUQp8QQKeQaLTxuLxl7vmNApbylBvT?=
 =?us-ascii?Q?vydd24cqET0+utFtpYQ7lI7RTHc1Zg241fnWfvI8TJ5QzBhnhMgRnujdeZNA?=
 =?us-ascii?Q?p6MRNHs2Df4BvTIoFJHpi3meaJyN/qpaSoKz30n5hSYfi9GO6daeNggANMQi?=
 =?us-ascii?Q?yUfu3oeGb+E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3wp+CY7Xd4HPC6k+42hnRSJ/A07B/Me/KQIxPJuYeIQsazsAxXgDKPr7Lpl?=
 =?us-ascii?Q?QEA95Ixi6VNNXes0dxjwdRNbFlUJFTH95c5IKJQYVM/dUDSGcfYf5okCKbI8?=
 =?us-ascii?Q?jhNzLU+2G2gH2YDdP4rObQJEMd9K3RGk+RvBO2F51j+eHQDMUiHzTsecClsc?=
 =?us-ascii?Q?8FaZRacR9MvPq2Zhi6cq2FAYYMYVCidq/XnkGV5MyjkPuGKl+rt14RRjynbm?=
 =?us-ascii?Q?HhjDtwH7Xw23KvwJR9sfOXepfLpt76jAnLz+CUXECBoAntlftnIaweJIFh4X?=
 =?us-ascii?Q?FxyM0CHXA+7VGW98mgj7zsxAsydvcSnoNGA9CEOZEW3Qk/eQFi65JpkHjkVO?=
 =?us-ascii?Q?XrFmno6CuRV+EYVjvaM6ZFfkm9HrpJCkfsoUrptL3ojdyGkZwb+j1ufQNdkI?=
 =?us-ascii?Q?mwBK6VMVxa5aaBHZQe/3uBOIa/b45Dw7tgK9Drw/D5dPXwIYDaD66bsDSML6?=
 =?us-ascii?Q?Pz9FB3Hadhk3JCmsM9xojHv0X6YI03mO/W1q37IYcebCKPDUbRhw2YFExqxe?=
 =?us-ascii?Q?/NeYnD+rcXmYIidGHWjCmwCkb5H9T0W6RBtPUGBFoGcqwFnxWfZY+gfNmcP3?=
 =?us-ascii?Q?58AdFOBh94vQvQZqR5DWf06qPFeI3+q6QPsCc4zeFlt+kRT+56ZycOmWSOHj?=
 =?us-ascii?Q?9KuLlPRTPOvtyKII4QlAWavZ6gbU0hXHPZpNECF7NTgBP1NQLKXVHyQpiYHU?=
 =?us-ascii?Q?RsYTvvV+8eoQrf1W6kh6NAVRBqlnZEH1GOn8jWXu8LXji/CFy+QrnCD4WFOl?=
 =?us-ascii?Q?gLh3NJgGVIgANF5Wb7JB7WSqXSLP36yuRbN1Mf5dkTolwSA7elphZEGa4oxE?=
 =?us-ascii?Q?FlVVwfFm3lGcOv64+7cftCC4KXzt5AT1xIw7MDVWCN25itWADLzWQCH4bDHL?=
 =?us-ascii?Q?pGfmQLeDQhCaNoARZuP3iBxOlhAWJd9WBXWdcE03grQ0A+nb9EqNGEwk7I0z?=
 =?us-ascii?Q?vj6ljpO7C1KsPhJz97KPQ4mHWHVFy0Bv4j6wCw+7neOETkbEO/bICA+FYGq8?=
 =?us-ascii?Q?Xvlsm+ZNeVzAeHqGeLYTJQf1m+hFHAqV4nir5sHai6g4CD3OcGtZV1obYraz?=
 =?us-ascii?Q?VQ3Rz4U6HOxOJ+1FMTLMH72uvP2MCRYLYc1Zc3kEmfhJKI8Ubddhh7L+jHlu?=
 =?us-ascii?Q?lkQCZxLXogYDP+J5kpVKmsWQN3yCw40eLJG1dNGQT95eULdySfPv95moZK1v?=
 =?us-ascii?Q?dbYmpCHF38U9l+skBodeh2n+CxyXqtkJfutfB5+GvxOsnYX172ho7EITvrXx?=
 =?us-ascii?Q?mCWW09+G1Iij/s9U1uRbXjikIpZQ60nbreqfxAq0pqy3hs9qV6oYozkHRHh2?=
 =?us-ascii?Q?6zZRzkVB30PI8b5NfQciaxAYOWNi7gbsYe2p2Fsj4AFIshZcmR1mAJE/e0D0?=
 =?us-ascii?Q?MkCQR/2sAjdjsPmIiBsf89bwtUviVXlj/cGaCwYeKUQ7kL5sQtQzaslHlMhl?=
 =?us-ascii?Q?Njm42ikT399C3XTVZXBSgBsWCV183Z3NxmjRKSIxUsuNGDMxOYl3W4IpPPUo?=
 =?us-ascii?Q?hx5zshs5eoDHCcJsRhslfiszjV+wz5hLt3b7TlSpBmxFgtSRWrd9+8OEOGrT?=
 =?us-ascii?Q?LJh6gEP63I9MOCQLwKgCRdTCmgz5hywS83XXFtSafyzbay5+vEbcixrqdHpi?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	phJu0gDzO8c2Yh+ynAxmcCwqq00oPnJNaImOlPy7SrfbjaDo4YyaNmndUdBNtiIY6sBQXqZMXf28sHHAHFqu3LwilnWBJudkZxinfWkBMA1qXrtLRzKIfADtXSGqXqhgm/amJuGNrW9S4FnvSnQ2n7Hsv0YZ7OgB19aoM9nhptfJvrwCYh97NYeCtZ0FzQVmbMlmNk5Pu4VjIx1l6T5Nhk2N49ZKUuRT8QFYbH5CC+ufsi3O6FTHPp3uJSX9g/8Oz+M+76mZ0T7PSvF1Mew52uTJmqO2zkmcjn+3neCByzwZnu2nOK0kgdPzUsEzc2XqOjUe/lhf0xiWpM3zsWW76VkqW7c4pz2fbpgr09V7PhPeCr3yeJiVufOHa6tnkJUm3Nz9r1qtYESGf2mCfrHiSHBscuK1umZbFr9SGQVMxcK/LYkIqQ0/vivAwRdOr+MCWjr1QCLGvvcVOFkZ6IINyP/6d7zHyo9CDV2wP23KVNfwRkQbSbsShviccUAU0iUnRDYJehpW8qkmNuaeYA8mUQ0oad5SxXr+Ybah+X2jE+0x7aYyDIcREMYF+QkSvkKp+UL9AFXATdUc0/1nQ7Y9byXr84aKkIokL+eyYOWnOTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb43dfe3-26e9-48ac-ab19-08ddda3617f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:53:22.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pNMFHi/BpwbsI2xfSO54guCgUrAMbzCYcbmUTsCOLRID9FxUzBWuPGqpWgu0RdA3eNtGdKhW+6NOMlfP7Ev7grETS+Ix25Gboj7uMbkGKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130065
X-Proofpoint-GUID: ytprlRBmVtQ7lLwDYRCgyuGnjFV3kQ4w
X-Proofpoint-ORIG-GUID: ytprlRBmVtQ7lLwDYRCgyuGnjFV3kQ4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA2NSBTYWx0ZWRfX05MLNXCxGmQy
 73SVbRGtZjbhkouwjA6EvPumRwNHoFjvr5GUrRgGiHa4JnqYw7yJ/t/qqvSDoTCPIbJvGduM8Ns
 6OIHyoUOCDQBh3k1siEdAPP+6JPKhkh3IhnybbwMaIx+RsRRep5vVu+5waaNRKxijDi1qc7nFXf
 nz4EcZusuAxzj3jv0F9umoufXiCKIqVKHFKzA55A6hn3GKqS7bG7WPxXB1+EkArDRPQpONhWcuA
 7I0e8PVN+K7AFdeCD2Z0D4GpCiKjjm8Ry8y198ly1j6GIEMVINvEgMelr3ZDTp1U0RioZ2ea7to
 eIqvIcEU9wZuClJzIkGp8M3tpo0dzNilIP0ttxb1a5E5YcuIG4s5gMjZ1b7uj3B0ldGfWuHLeFO
 B35ZP718yScw5vUjlh+KMLG8pUWS+iDRN/5ESNhnDuMbj0ujSlwHsU6NDjcWvAnZcZpGJ25+
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689c366b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=pBp4AGf5fzzQzsdKkWkA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:13600

On Tue, Aug 12, 2025 at 01:15:22PM +0200, Peter Zijlstra wrote:
>
> ljs noted that this Changelog was a tad terse, and he had a pending
> question here.
>
> On Tue, Aug 12, 2025 at 12:39:12PM +0200, Peter Zijlstra wrote:
> > Needed because refcount_inc() doesn't allow the 0->1 transition.
>
> Specifically, this is the case where we've created the RB, this means
> there was no RB, and as such there could not have been an mmap.
> Additionally we hold mmap_mutex to serialize everything.
>
> This must be the first.

Thanks, this is great!

And really good to separate this out as a really critical step prepping for
refcount_t change.

If we're being nitty it might be worth mentioning that we plan to move to
refcount_t and that considers inc from 0 to be evidence of a UAF, hence the
absolute requirement for this.

However, since we're clearly stating that this is the first instance of
this mmap_count being incremented, it's moot, as it's simply clearer to do
this anyway.

>
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> > ---
> >  kernel/events/core.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7033,7 +7033,7 @@ static int perf_mmap_rb(struct vm_area_s
> >  	perf_event_update_userpage(event);
> >
> >  	perf_mmap_account(vma, user_extra, extra);
> > -	atomic_inc(&event->mmap_count);
> > +	atomic_set(&event->mmap_count, 1);
> >
> >  	return 0;
> >  }
> >
> >

