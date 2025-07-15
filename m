Return-Path: <linux-kernel+bounces-731944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9FEB05E06
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D7A5655DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C0F2E3AFD;
	Tue, 15 Jul 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FvjEJC3h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g1+1ME3J"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27D2EBBA8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586696; cv=fail; b=o2quOU0cNP0Alr8fNL4SEI2sRucUHO/+RtlLK5zeuSG4PR/nPE7Do4n52bFZQiOpGvhwHx4c7gQaMWWX2chhLYhuWpWbq7DZ0ZUWCzaR8rHqa5pM6OlMpE1KdeqPHrXHHNqeYAm3vfwd/IHFpVOJ/oNyygBji+5GRdBsuhQr7C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586696; c=relaxed/simple;
	bh=yGsfgTPvmLKlWzROFXAS/MKM0ZxRIpFtlDIPOAeuY7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VmcZHBUZvMZlm/nsmAbcxrO1dY3mx/2UJTrVVAyfAv5D3F42nKkjHMnG2/yLHFteWHbuYd6+cnTQBAS5ePQ259pdWTQ0NUXiG2W+B22s1XknBgLX5BMvZ4JWIb3404EKRf6x5KzWmpY9HB51jwSXF1C1bhRGSrJBBRfInIxOFzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FvjEJC3h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g1+1ME3J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZDJs009117;
	Tue, 15 Jul 2025 13:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dJsLJ6ikCycbkWoBBk1u0Fj2sLfpNGZ0KppuFQOXo9Q=; b=
	FvjEJC3h87jqAup247Wl/X6BRHcr7EdvcE4P/8bkTxchFvWwSSVFX7JbQamC9XDk
	mnhn7PBCmOcrg8VwRawWbNTvIyoRW4jHLne24vPXPxDrMjhhRZRF5c5l7ayNwIjz
	mQX/zTaUYIPWYOVwaT2jp8VYAagvWhoEgrZflG9oTJcZZT4qSwCSCveQGL7jjO/J
	MZ29oGhly4dP5xRNZ7eJZUV6CFxn4/j71FORcHShck8zyOL8V7AD1GSzCA0N+Vzj
	6N1hL6fog5rpgBOXRBIwxftaJTYR7n0t4UOxScSsvlUEago8sfxurkG6pfhHRj86
	fEDUEk+SD+YAl+tkBj41Ng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4pkwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:38:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FD82ZJ039715;
	Tue, 15 Jul 2025 13:37:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a0cn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:37:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPwgYN0aHpUSlodMIPPqyj+Xrw2YaCKy8AzALv6rJ2rE7za6ccSFnfakR8ijjPpqsF1jGIq+O8RWytgfbqRFg+16gVF0JlTFW5jPEckgnJfhZjhL/oE/1f1g6ogRV83vXY0aAi4W+xlk98jhG2GvuHR8D3u4PMi/dKYItj9spQOsKA+ExrRXi/XflNZ/KNSqFfrVXKkmv9gowszqg+XI98grAHEVnC32+GRewEWekxSwlexd67M6T5miMMgNiLAvBqn+lezGxXc+h2XBEEI7HpMVpyU7uu4UjAe8GjjjB6BGHSAO/B2PUDESyzjRXvD/MWL1Z1/dtAtC9fvX4ex1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJsLJ6ikCycbkWoBBk1u0Fj2sLfpNGZ0KppuFQOXo9Q=;
 b=eEF7CuwQ/icRbI20eaWECrCjjnFA9FHacEiNa5dXf06JZGj45pUs+mjlo3ihrKdnTOCqmKGcevRpFTjvesF0t8rbjY0g3ygva1dAWWUJYQ22iktShthcsntAhdvL+AzSdUrbRKgvVjGSRBIEjkNIoq/l0fHl3+kJ25nNn9gi38NWmErMuaShFWvtvE0f1jAUUxSJaXxz7b1ZvZiS7FP4bdGAADl82u4hXB1yODRfX/7VKinxFSwpFZSWVgfI7+x8O7Rot3CC9VG297SbJph4AurCh2EIrLyIyRiesxzxe0zakue09y5wrYVXpFuynsMdDmZGbthym4ru97bbd4cYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJsLJ6ikCycbkWoBBk1u0Fj2sLfpNGZ0KppuFQOXo9Q=;
 b=g1+1ME3J6MSxnV/Y9XHRRVJ7DHPNXzFvp2mHr5EX/6vwDAVvWbemJUOUaQFPELH82Cb5R1ApfG+9aH1fOVR5eF69UK3GPSCV4BV+DpUO/QQD27XmKhsucWkgvlCrobYf5szM/Dn1J4Fe+wtxPAAQJi04UCmvDACrMI+N3yBqmvA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF0316BCB78.namprd10.prod.outlook.com (2603:10b6:f:fc00::d04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 13:37:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 13:37:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 4/5] mm/mseal: Simplify and rename VMA gap check
Date: Tue, 15 Jul 2025 14:37:41 +0100
Message-ID: <8efef79c46553a9b8924878c1f4363998c1f49ed.1752586090.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
References: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0410.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF0316BCB78:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1ffded-b953-42a9-8c47-08ddc3a4ceb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KDr+S0LI6zjkxQYTcfiYkSY/FbsJdlzztzL9wf33D9/h/MGBNZqmcv0So/ce?=
 =?us-ascii?Q?LA+8LCUr64BjyNzxNrjMUPDgnBfjFWLQa9ea8TM2R5yFRLE9rh7VJ3Hxf19T?=
 =?us-ascii?Q?ITIB7kAzWFPVjbBAmbIboIcqHxfF0zNNN+pYG59Q+8OIPemmsxwHbuob0H+Y?=
 =?us-ascii?Q?+OKgcrtkvadJ2HA0Ukv4mykC+vsFUg/rVPLKe5xeS7aaGHEDzLPf4sqBY0nu?=
 =?us-ascii?Q?uoW1pspfW/8mQiQ60mbMSVM0xAgiwqzVsRo0k3HwAv4Pfs4zOXaIx1VbbcQu?=
 =?us-ascii?Q?uJjGQAF18U45IQjNFwKjn4i8oDn5V5zW6ONEKtcdcE+fgWvbmy3ybfqdnCti?=
 =?us-ascii?Q?rLwosoV/meU6kEc9j/Q4auzbG1z6MCgoatwC2kMkplkRgnfuQwkbLWkW0VqY?=
 =?us-ascii?Q?/HgGZ4GC39F0nd7+pcRw14ykuhfi3FlCgzNL1z3exR5whQNWDl5kYAGGBW8t?=
 =?us-ascii?Q?Ee/sm1o9l/GJLnq/9kktK5PUxE7lSfCjS7w3Kq6jiAq3h36kyj1neh2WAPyv?=
 =?us-ascii?Q?T+LPwmY2h0KH4mzBI/HBYwT0T2XKRSqEAHUPlwwhPZL5qGN5sHNWu+bA+nCE?=
 =?us-ascii?Q?8hrXv+Bjc8sKdSkeEAxH53sNKIYcnIEo1lRt6B0Z5T5uZrkKzJK/8AMn1O73?=
 =?us-ascii?Q?n0TWHUqtz9azgXjIPd/evmmFmrc3dm7EE/b2ouE5h99jSFCaLrnE/WlkKxKt?=
 =?us-ascii?Q?8o8y1E41bs1SD2PfT4LjnU2uPQgQb0xE6J4Znrhp1SKLr/kEpqKkuBftSdd5?=
 =?us-ascii?Q?BtS1K99F7IiMmA+6osKZ7vkesCAwrV88s6zLChdRG7c6kWASCc4Yef5rA7DQ?=
 =?us-ascii?Q?yfgTpBBjK1ahrY56KG7Jn//EVlv9y98Gpd5iG/y7aXr/lry/Z4UgPtq8Ap+Z?=
 =?us-ascii?Q?2HpNW3uylCDOb4zvAeUjzINRo2RQmcnmQ1zQZgT/4ovy3MH3Du50bcSqqJL2?=
 =?us-ascii?Q?uPFFXgtfmjRFR2/B3B+vGVJTmc5xJPe3IshmP+eTiwB7AxeIqrrCMHe8vZnr?=
 =?us-ascii?Q?INgGL/6RyfizkPb9mp8VWfvECsInAbshHZwf/ffRvPAnxb+ZKa5cSvxzeCSQ?=
 =?us-ascii?Q?vylrdw+JtDACvqChihrfwbI5a9Pkj2xxX8qbWbYfxeLfBrJMp1wpeXpKRbnd?=
 =?us-ascii?Q?atxmq7G1AQXiauEnPG4tjRYji4zqr4od/f/3gN0gIe9hO/YJPR0Y8VFmjBLe?=
 =?us-ascii?Q?vF003rnwO8ARf6fRmaWUcwauEfMKV2Pcxm2ac1C8uXjjAch8ldHF/LvcAbYv?=
 =?us-ascii?Q?gWc5IN2tgbF2H39oT6w/R/sj0z2TLDXHW7tGNFmDf0m5xOXuGK/RchbciFOy?=
 =?us-ascii?Q?JKA7BbazDsE1Kp+RanxQaec3+0MFdysZN9XeGKTD+x2M7PnqWAZDoPFsGkKo?=
 =?us-ascii?Q?NMTGgzcG7GDENMVU4NTYS5/LdLpjTJrfT7yRvNg49ofEnvDZTC0oCHt4dX6M?=
 =?us-ascii?Q?FaFKK5wdm+U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I7tB2rzpn3YzV7T2pk6NM7+7y5ZXAUJgbBswYj4OtnYWnFiZP9treLXPRlva?=
 =?us-ascii?Q?6QtBLu24YI/Hm0WqTt/8v00zFH+L5jycoL3Hjv1nNnpzzIhC3KDgwfDaEoue?=
 =?us-ascii?Q?uyeKbk8iY5nfS83L009a1Ddvw01hglW2JkhOUU/tbkXEq9UqqbOyUwvmgAmV?=
 =?us-ascii?Q?tdxrf/F5NOlGvmnmchSZF8XRim8C66OsAYAjKyHGQ6rPuXjlL9xKlO0e7fpt?=
 =?us-ascii?Q?avuxOqzu0nNzzYRu7LKhLI6Xb1duoCj4TpFDK8y2fevErAgb6w3OHu0jwjPc?=
 =?us-ascii?Q?RWluwnvcZv0YHofhdjVEjKuVJ8P+gT8Y7SZDY4LHzU+H+/OVg1azo5qDC+yW?=
 =?us-ascii?Q?qT0wcmg/1HSfNzDCU32Cl12WeLDOE94rIluYXyDvmkH491brN8jZ/8ODReCY?=
 =?us-ascii?Q?B7xXbBvG1KgxzMStNmb/1TlCai+wbD8RO8TJLIOjDmJi0Apteiouk86y+1jH?=
 =?us-ascii?Q?+rF1FFrKp+mo0Q9Fg70GL/dbV3Aco8sjGJSclNI0+s/KixezAd6NZmfZ+Dpm?=
 =?us-ascii?Q?kArGvdPuoT8Dwpc2hGcOJljJASBNt4UeSuCfk1PpzbuNoPSLXpS04FARllPc?=
 =?us-ascii?Q?WbtSJZVivQvO+xeL+ZmvnFBeCqS3hXvEcfmmvLM+091uRdL5wTFJsGFroXI6?=
 =?us-ascii?Q?B/ehD7Ms4QmAKYrKpVM2JMCPgqd7rpKu18U+VkENbwCveI03WarAHHrtefhj?=
 =?us-ascii?Q?XRa9wF0aKpTTcDUUOIz27wtMSqzOuH7sc8jv1HEAI2T/iUXpV37Gne18zVWC?=
 =?us-ascii?Q?+Rtcjnnd4ecxg0DbBZXEGOColmbNifstUpJx5iilpZKO5tStyBxdPRvvUv3R?=
 =?us-ascii?Q?nqy7K67LyvylZrsDxsYHP0sXddSzgiwCrTy0ckm1Aiu7Yc1iTkoC7Ubtn8YK?=
 =?us-ascii?Q?eT4eeltAW7dYLQB0dqr3A696KrqpAJJdNmaGmq8khsjOdTbL7A1pknT2UuTc?=
 =?us-ascii?Q?0s1BVshxDjQnF7CBlt2q7U165nUB6JElhE/VnzwWF5T9AqsZlPu4hiLMDTHc?=
 =?us-ascii?Q?+XHoNKqTPLZR7pvIgZ3ULfnKAJd6SpeEgJ13WGOgkQ6ZmvBqcWK9pTsxmAYR?=
 =?us-ascii?Q?72dtKzucxSgIwGixTuWufTU6X7So3tuWhDHKJGC8HEl8pFWt/APDGXBlZDi1?=
 =?us-ascii?Q?ulpdrgLcv2cD79SJhAQ4Qg85ph8rfRCMwONn8H/4nAx91ws+102NY9vVJ8zX?=
 =?us-ascii?Q?mDdhFN/tXRklpXNAqOEmPt3HzJKlPo167cMv7udv9oTVXrOHlpRF7f1P4udN?=
 =?us-ascii?Q?Plz40TTefnUszRfCFcSl65qp6YT2SsXQnDz357D/YvOFjet4VeBzPVr8Sekm?=
 =?us-ascii?Q?TcYtCnOtlA9eXBJg0Ry0GFZZ2u6hpQJ6cAx4GI6fmOAXccp5gI5k0bTWJYoc?=
 =?us-ascii?Q?bjVsQiA/51Zl1GD79x2T16y0RlfTiGgmN0hi0xdcYa00v30R2ouoM+/fRwJs?=
 =?us-ascii?Q?WfTtoKb74xlP0oSmvoMOgFWYdVD2fwQDbk6OTPpXFMSxZRYUSjz3WoTHlTnt?=
 =?us-ascii?Q?/QAFIunAKMMQNHcjoIwZa8Mfzz6RBiCZjNkhOdRoQL9PZ+L+rI16ZM84UXcG?=
 =?us-ascii?Q?XstTW4ZZvhGOdAoZaUclPtfscbukH+Qncky2tTL4FCmXf774jUTb5rP9lL/Z?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V/ScpiTP1DTricqWGBaowFAhSapjjl2ir+LyW78xePPbCeLCb9rXC9FQOWEDVjX8GriLBXWkKhnh3w9cVAvehJC6Zn7lG5TsVu/ti0YjBM76jzMn5V+JSd8NeuRq+56qXns88jbXDNzIF+Zt47taiLa9QzV2xswQOpby8UZrRsYcE/IiTlkd8VonBHUMbYf2Non4JrEiUScD76pUcpWpt4Z1vbMtl8BbRwrIs5oSiRUBRCQcQKLJc4BWaNMbpxKe0jpQFZ1f3yfoopjQkcU1PZjn0Chi5NCB+txHZ7cMzK4FziNhQpsVkS908+rclCMJgQ2qHqvz32keEYvnc5cG7esjAOpW5qR1MLGWa6QCD8UE5PvVYRx6fS8bMxuYqJ2dl1uOiJU6uCena4XZ7+rAedaZYkZl55V5b489isKZMKYtOLVW9EKx32/4cNAbttgKcbF/eWCSRra4eADAmh05Z4+xkKmgMrpgfYlAEte5odQx48mNX81+2j7X1rurbO9NxPS5AMpgHb22KeH6ESxci9UchGMtT6ltatTswMOOSqwMhvrnvKOeMejkL+BU8yUlpjmvoKYGUG6i7h+oWB2e7V6HzCQWCpBa5+R+RvHc+WE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1ffded-b953-42a9-8c47-08ddc3a4ceb2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:37:56.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3P7+RKkGrhoRh7UFKFIJnsto3q2JPh2pLMgqQLs5iNGvccoLZ1yiRQqUDRwIu/8E8CTKp8IaklG6soV+SOEbTXHZ/R45bz1bYssnVzln4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0316BCB78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150124
X-Proofpoint-ORIG-GUID: J6sJQaVO4_9Rq4szTI5f9PI69XaUDqe7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyNCBTYWx0ZWRfX4UwhoE+xfZNC uXiXKPjGmlWeRRJyxI8ULbDwPPoszkSRdrKtK7+NNKScVTMcff7pVVii8cmYFVVgQjYGhJNKfJ4 lk+Iwj4+X0pc57u7BIaM2L6SnmOFImG0gEX2H7aHgi/DJn1LhJ5nhIA1XKhNURIt289h5tZpn/Z
 PWBoYeBHaX1wxI4N9KBeLFpo4f/iSD78UGgZQVyOoBfqMw+g5+Z9I5Xya8Z2/AaT06VkpA5SWFK b2uSlTon1esoDBrvzJYko1BK+gy/gMHqhecVlzdpy5sIxsvSNkGfJNcI73XY5dkESyWxKNJdWZC irQF4lS3Sk0XWmaNOiVH6IBTsybHpQxw/5FbaOijalsIaFmhw5x923H6Es4zK3F/0qPbN/scdRA
 pmyLBeQvDCCYk1yUS/+PV/IjiT8ITbZVTXqf8TGr9YzvQ2uIbDnQxx3YuT9HNQ1IRnbteydZ
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=687659b8 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=qMmrSB22KtVtcMM35qUA:9 cc=ntf awl=host:13600
X-Proofpoint-GUID: J6sJQaVO4_9Rq4szTI5f9PI69XaUDqe7

The check_mm_seal() function is doing something general - checking whether
a range contains only VMAs (or rather that it does NOT contain any unmapped
regions).

So rename this function to range_contains_unmapped().

Additionally simplify the logic, we are simply checking whether the last
vma->vm_end has either a VMA starting after it or ends before the end
parameter.

This check is rather dubious, so it is sensible to keep it local to
mm/mseal.c as at a later stage it may be removed, and we don't want any
other mm code to perform such a check.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/mseal.c | 56 ++++++++++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index adbcc65e9660..794d1043a706 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -37,34 +37,6 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return ret;
 }

-/*
- * Check for do_mseal:
- * 1> start is part of a valid vma.
- * 2> end is part of a valid vma.
- * 3> No gap (unallocated address) between start and end.
- * 4> map is sealable.
- */
-static int check_mm_seal(unsigned long start, unsigned long end)
-{
-	struct vm_area_struct *vma;
-	unsigned long nstart = start;
-	VMA_ITERATOR(vmi, current->mm, start);
-
-	/* going through each vma to check. */
-	for_each_vma_range(vmi, vma, end) {
-		if (vma->vm_start > nstart)
-			/* unallocated memory found. */
-			return -ENOMEM;
-
-		if (vma->vm_end >= end)
-			return 0;
-
-		nstart = vma->vm_end;
-	}
-
-	return -ENOMEM;
-}
-
 /*
  * Apply sealing.
  */
@@ -102,6 +74,24 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
 	return 0;
 }

+/* Does the [start, end) range contain any unmapped memory? */
+static bool range_contains_unmapped(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
+{
+	struct vm_area_struct *vma;
+	unsigned long prev_end = start;
+	VMA_ITERATOR(vmi, current->mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (vma->vm_start > prev_end)
+			return true;
+
+		prev_end = vma->vm_end;
+	}
+
+	return prev_end < end;
+}
+
 /*
  * mseal(2) seals the VM's meta data from
  * selected syscalls.
@@ -184,14 +174,10 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;

-	/*
-	 * First pass, this helps to avoid
-	 * partial sealing in case of error in input address range,
-	 * e.g. ENOMEM error.
-	 */
-	ret = check_mm_seal(start, end);
-	if (ret)
+	if (range_contains_unmapped(mm, start, end)) {
+		ret = -ENOMEM;
 		goto out;
+	}

 	/*
 	 * Second pass, this should success, unless there are errors
--
2.50.1

