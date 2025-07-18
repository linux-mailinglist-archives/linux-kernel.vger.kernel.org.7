Return-Path: <linux-kernel+bounces-737289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F00B0AA57
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DA91C482F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21722E5B11;
	Fri, 18 Jul 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OF6tJgxf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WvfZQgwc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2312E92A5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864591; cv=fail; b=eN1vmYrxT+InwQuglq6ot1QoLDZJf48P6siAlGS48khhlYq6SwNx67AV1lHxjSpNfmN7/9sjJRqD9U1DiZT6LB9flljOt+GPsUpqf8S7zWQQNwjzHIiUtfW5AFcul7LL+31+541oWbS0N6ZDN8BntVfIgYST+vLrR67LVyS6FtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864591; c=relaxed/simple;
	bh=8UvOvJpWpKI0ATPOMA4q/rWUQERj/g4pp9PQ3M4vIVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pT/wVWhPH7wUgvkCHn656Hx48s6S4AQHkSHrV1TU0aWuAcBUbxOrKCTeGNBLrHdn1S7yO8b5AK3cPQf00pwodGMlw/RKmsEpZBD+Q50KJAgNmVXvilXHUh2DmsMRfHFp2ePymwA/atjpQ4ea+5Zxs9YDNcu+ThRDGucBTvjkk4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OF6tJgxf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WvfZQgwc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHHkA3016291;
	Fri, 18 Jul 2025 18:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JPsTCUC+W2iqr/jEHu
	xIUOR8rAADiEQYMEl9WQmprB0=; b=OF6tJgxfth62oSPrT6tx0JLJUmp9231ARZ
	zyzwiBC0jurFps4gtmfBJ00/etVttl9rvTmz2auvvYa14gYeWIj9xMH3NpgzI2Dv
	+zRNoQ31rWtSnBTQUjoNsFNZkkbbpdYt+iWwKv6w+suIutQMc8ufECeW5FzIrAoO
	m6CNyLRhBnTcXwVFPtA6YY4Dt+c9MULWttsE7QHsVV2JoE24XrljMsNCIeOCaFwK
	z3QiNozV4L4U8PsLx4kqY1WizxRLQVpjE74PK5Hr/XsY7lzN1RXCT6+TELre0XwL
	MtYwQOG/EmGe9zUQFbeZ/RSu3HUkHbdzNm/oYT4VNvqZ5Hy+G3Gw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b5nsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 18:49:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IIh6wF029705;
	Fri, 18 Jul 2025 18:49:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5e3y32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 18:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=athfSMyh58vE3j2o+oY6UtpvjwPI1Jg5ppBWAJw+wrJT5tV+QLf84DNZpPqheg8O20g2gg6xAdztZqSwIxpaBGXQs5gOo00poQrVhy4OoduF/84frA3ctinr7lTO3jbemc2YD9mo71rHVewa+2w4pcV22O8jZUVjYNYVhWdTrvp/aGMyeIS0kxVZ6lw0xyikLyHM5EX7QkG7FwcZLDoumceENKGf2+/ASdd1NgnWxqDannuaH7u93RalO+fh2jmC1lJC1U0pVoszI/VkHS2Yt6E7JpNEWTaPdU4gA8L/Mm8o+HKw57tb8QJgAFaOgPBZVx/BmZ9tKZRO9a2MmImF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPsTCUC+W2iqr/jEHuxIUOR8rAADiEQYMEl9WQmprB0=;
 b=LbgfvPr9v/8YRZjYVVbll93so8k4RiXq9nbeBIQz3GSyr5YKlux7wIoXZKWzHv77Mt0cKD/W8B7YjRKd1wUetGNm3meQA3Bruznbbpz/Eml7B9nf9862+tHuUJW7OfBvHecTjIzR0UcNRCVvdWZcU/LUt+r9jPn+Xn2PxfWHcbfTkiuOQCrnB1ZqlcCRyF4AFMAuWSl64JRGmWuRMhmX6Ona4tyd9c8sqKB07iOc/coJ9Z98mmzjqUi84yDH55wib6M3AmAR4Mr+hBiwcyiXu8wFvj6xllpfLeDIDFHZ2Ua4iadWFVDzVF7+S+eKox0GiXSL2vFsFZiMS1W/HbynQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPsTCUC+W2iqr/jEHuxIUOR8rAADiEQYMEl9WQmprB0=;
 b=WvfZQgwcFCsCj1fWex71hbapWMQw9SO/pkUYK+tTLH1I9ZOGqX6/Tcl509zHPKGPxAEI9+G5ppv8sfM/FnVw8wGNuGHlrdqnZC9QpLLR76tKvzS7XPaat9oPpZV2D6+zjlpqcSWLxnMQzQ7XVpQU/jW30TQ0hHriW5CsAp3+aK0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB7981.namprd10.prod.outlook.com (2603:10b6:408:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 18:49:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 18:49:14 +0000
Date: Fri, 18 Jul 2025 19:49:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
        willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
        vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
        peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
        baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
        christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, hughd@google.com,
        yang@os.amperecomputing.com, ziy@nvidia.com
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
Message-ID: <5c993cf6-13c8-4420-bd78-706ea287fb28@lucifer.local>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718090244.21092-7-dev.jain@arm.com>
X-ClientProxiedBy: LO4P123CA0196.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a19da58-72dd-40ad-9383-08ddc62bcae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JesNYLOCpYu7p4dkZovP0+12ooz/taH1NhSsq+ZTu5mJYZInTmYi1BSZpGYi?=
 =?us-ascii?Q?q4dTAA0tyY0LbC6MBMq7ApWA5eMrSAox70wIg8/CU7+7MJZ1OPQ1LpY60U73?=
 =?us-ascii?Q?DRoYFOaGPcTzjbtzk7/21AiDvmfclB73eficYclmlRFiPnUwPpvoAYhC/0E9?=
 =?us-ascii?Q?aCevvt0Tvf7VS7krTw3R7hoUvcVsuBAr574e2PbtoB8KNJcyXif2GOuB7uxM?=
 =?us-ascii?Q?CHjIC1+MMGCyh6S1NpESxSbHRfmYyNYZ6n1M6/cGAGUny+oh7kES0p4JPFdq?=
 =?us-ascii?Q?JoTzr57u5DFs2K16sal2ohOQ/7tSnQNXxUDuGP7kXGODEQIpuMWeiYH76rpI?=
 =?us-ascii?Q?I5Bc33qZR5YhwpvPhIVO24aEUe6GZxR+c5kDrPtYVdkf7seOhlcktdhdOxoM?=
 =?us-ascii?Q?dsJfkbUZTA5rdW0ZFRyxM0VO3btNK9CCiwYCUGkUdWn5Prqqs7ZFYSBlgY3h?=
 =?us-ascii?Q?ttjVwMPrLXIQb3YvMmYvByMKmcuqu6hukRfiZsYvTryOcxNRSyD2MzvxqlpF?=
 =?us-ascii?Q?7/cseA5XfcTdVHL6EdiLG7TuKZ5hqknrU1b1mBSwXKmxafFWNQSvwmBFSHmP?=
 =?us-ascii?Q?sd7BQ8tJWjxaH2b94f235hDvMDbpXyABHsRo/CkLHMTE043mLTuh2E0rDujA?=
 =?us-ascii?Q?MORfB7Peotg876g7Nf6IjP42zoBE3l9CCBwQXFN7uFBZqvHTzCkNjQhbGFza?=
 =?us-ascii?Q?LE/Lng/6sV6i+K/StT1HSB8N30oJ0gVqFyCVf1YS+EZK9SguljGYEI+C0FC4?=
 =?us-ascii?Q?eN/COq/UeB5JMLAqZtu0oR+JptO2KT6QlvzYT1U3a3nn7hBFJky1jJjH/SpF?=
 =?us-ascii?Q?cPAg0GwJDLGpSkKfO8rgbcuq8fL65EF64jl8EvajkAU8KjZh6rnV1lLZBy5x?=
 =?us-ascii?Q?H2nxX+QHmKm2nixOMeZQwxmtVA3mA+mz01OWDiVy1OAnqBVWYBF/SP/65tkc?=
 =?us-ascii?Q?IV80PW2W4FAKjtteXeT+Zfpou2oiM4dAIEH5u1V1GiupTY2zTNUyLWh8hi1V?=
 =?us-ascii?Q?0lMK0vYUGnHA2C1HK7XwSoqPWqUMjUBxUBJyRprfJNCJKDBczKcxDhI27RQQ?=
 =?us-ascii?Q?QyAG+QWF5eT8xZgWHgSu0u95p6AsrWFVubHUC3KgFUOrCQleAXel+/x7jLM/?=
 =?us-ascii?Q?j2B5LGJwwPe6MzUdrS1EADbftcmP5AmWMXTB8PcVMD0Ie5dnNc/6Um7ynpmR?=
 =?us-ascii?Q?/zk8gsD5BBt86+aDm7NvIJHxnDy/e0woqv/bY9rm/87FFtbd+rZSuAOTkLT+?=
 =?us-ascii?Q?nnpGPVXMMtq37gPjsGlCc8QcJRnXfdA0Ot1ixZsYcyLzzvN0HXcAsBxPRM/m?=
 =?us-ascii?Q?MBgokZUBfSWRB3kaQjfng6ii7uwVdkfxFOHZBNy9G0QfgvdtWtAQ5Moz16HB?=
 =?us-ascii?Q?iCYuKeNB6Z+GvY1ZR78UfIZvAZ2C9MAkZhqs3M8OD33ryoy9g/EkDeNdFx3s?=
 =?us-ascii?Q?F9Xh419Lt6s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O63ickWYtNPNvHME4cBrIyhtYggP6HIvz6malS0cTSpZXJCKoh7y3QwMBXZ/?=
 =?us-ascii?Q?0anqHe8ib3irvG9YLZeKcxqlAQJVXQ3LSFmSLAEtQxJyrl583F5oLNoofuh4?=
 =?us-ascii?Q?NA68hQvZkZ55kyBP4Sgz6dLdEe/zxNzJHJxQnhtvsQFCU7C1/6DgSlahqakj?=
 =?us-ascii?Q?s70EudDW0JY1MLUm+e1a+5AkpHxl8QA8VEmsXCInHF0Yu6ED3eTqPwhJpjgF?=
 =?us-ascii?Q?A1lzwZRBDvPPwpuQADkwttFF+oGNFKZ83U2XfgenzXK47ZliiPyA1z34CTj0?=
 =?us-ascii?Q?EpcGBj4xadVFst1ZJW9JCGWuYehgw1NMgBdYRtD/wYDgJ3zbA94S8SUaUQtl?=
 =?us-ascii?Q?/q9rlI8qmeop5+bCbOvnF8AZCFbkBkCRIUCfUHHjXDDqKzYs8erWg0ijGFCZ?=
 =?us-ascii?Q?bHFww2fFhYbXCYgi+Sx6coe7y087wTSvn+J2igTcKZ5AHprJKkWQn3U0UIQe?=
 =?us-ascii?Q?JKZFT9fGB28TKd/e1iM1GXIWuVBCh4giC56LOkedoTNJppZJtbMpebYiZjrq?=
 =?us-ascii?Q?PBiOKDYz0NqmH8QU4xxfX6yF5oqV6xQmbIee6Dyo8lHC171Nw0hqXsXkhddf?=
 =?us-ascii?Q?NA6uvSTKjjEO9SJ6pRD0mLHod3kedtUOpxiiZgBzE4KrzYDMtV5StRZga6YD?=
 =?us-ascii?Q?c0gi0M3qeEXld6jzJf+C2t+F9EW23352X7QHjPMsTwabEmp4jYT3fuMqo2EA?=
 =?us-ascii?Q?bCRI/p0gO1obwl2t8uLOm4prtnH/z/BekWq83V4SWZELdlCjQPjB94c0OgWn?=
 =?us-ascii?Q?UTaB+oHrxr3ZmHqE/iat/klSB5xjCc6KEanso/oqLMNAVsr/IUsVqspg5qa5?=
 =?us-ascii?Q?HqgfVI3yXUgyL9ODWYxBIO6ISGBgbLzQBZrl3iM15AkdKtp7cvQYWUOqHKnC?=
 =?us-ascii?Q?TrZlhiBT8bm9HsA3UJvGhs8yni2CR9DrKcEXJkNuwiXuPlLGHsnTAIwqaxfP?=
 =?us-ascii?Q?mBNXcNP4+OB7QFgVBFGRd7I6N36X3rkhn1vSJohWQ+dMVjuk5WTWknklcmJL?=
 =?us-ascii?Q?P3GORm4M4DKZRu6+qdeLuwYRGgE7YAXDgabxjdFX1uJhMsMZA72a/cAJu/5m?=
 =?us-ascii?Q?5muxlA532oiqYqUXGCaJabUwDZWiL0tfRWc2xzeuJPcy48VhbZy2ILKItNpq?=
 =?us-ascii?Q?NbanTJCIzkWiYO45jz0oKRa6zj5fTfhWyIyzbMqxkh5rol5Qjtq2SyPdkKXq?=
 =?us-ascii?Q?4M5qIyF/1gcviBxZmIMOOzS/a2BRpJM6jbxs2RmTJs2RQ3gFdKV2ZUqTWVax?=
 =?us-ascii?Q?SLGGZzECxHJWsVLi+WCqNwxhmLfx4wV1b/BY94vtQuE0asYBrOEOU9tEXNYM?=
 =?us-ascii?Q?+iY1fZjeU6uFLwr//bCDOwwH8Wm5xoHjExhDCq4gUhSB4apkvMidKeZwc5y4?=
 =?us-ascii?Q?OAZP0hwLVV8BwnRa5WQaDO3XSldDff93epTtaA4mwRovN8u7IMh/R8Y0yARW?=
 =?us-ascii?Q?BGnjOVxbH+Ymrge+BuLovdDsUOCLREQNjtsjAKvQd8ZMPp4wTvtkt75eoAPu?=
 =?us-ascii?Q?vEdXfoj4e8dWPxaZIfX9dlczwGSc9Bk7cDD7hPd4JJ8lMrAVKfIKu7jqZy1R?=
 =?us-ascii?Q?40sYgbQ2Yh3B1Fl3ihwdR7thFByzBaJIJz0H0CHSzzG+yLTBkwIxApJtKT89?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	59mkKM6PZjjbeu0jdnF23eN3zlNngJGz5MdEBLKuAJPVgaEfXLJtUr3ayKA9mrA9qZNpzntk6ZgFqv4whm5skGTPP3s44FnfkUX9w97tn7IqmGNQ/rwZBWR9TO7gYjpS/tV+0Z1iYg8jOr67JFYcEG5es3W0/Gp0N/NxUfiPt64ZK9awRTtMJmGXebpEPA2FJBKyTc/dAXiQKp9BesBfgYagWBqqkt8/TeCKiUMdAS2WnlIQSLTnDSYi6iaDgQeCBuG0OJBW8Lfe7Ns76NzDW2BXnKtsPeXKlO89qh7TS3Wlf/y8x0yg7q2W1eA1fSgm3N4iaBz3fn5ShWB2iTCIsSuwYoKf9iTDRfuBjrFfkyg8oD/VmBB5bQaoQsCKzhXnEus/ufHuTonLRmH1FzDv4Y+H+5BsVoqV59Q3uNoN90+ka3aTM791yPRefd1uEYIE0vFrOCuP4eu1Lr2saFJynEPNEem3pHoZ80pHRv1kIBbTr9JJEmnjAqJlSC7cmGZBOnMuBdo2WvCaSBiMrFsym2BYPHXo8hVje/AVRTHmJbE4hYP/44GGCCcqBEEhMHdxvAUT2TMlJBTdEITtT2qlVb5h3ixohhmbx1/mdiwII2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a19da58-72dd-40ad-9383-08ddc62bcae1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:49:14.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7m9gX0hJNopJRKAhdNW7Y3z+5UhF4shR7PMVqIuk4vjgyXD23RNF8phZRe9+v1ZYie061jufJnXtLIkeY5AT5JeP5HOwu5P1JTxGtY7svg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE0OSBTYWx0ZWRfX7lk8RRBwfIFM Ays+NzxsJj/ZRmhHbfY74yszsi6h8o6BbObps4mn4Us5VL4lUxu8lmubu9X3MUMfZPlx3kmohTt 2nf7e8BLbaweKqnfvrbjTBqM7CX8x++RJ9I0DUdn76Yya1y6Ir5HulCD2Z2iX6RH85gll06gIg0
 5o1z2484fg5WQ0ZxtmjG3m32zPiGgN7YCdHae38jr9QvYxqujHUBWMDY421J2UQcXnHTMcecMht kyIyRvcDwwQF3PlDR9vbouTjM6+ZN5E7wETHNcKsBGCFHAbbMpTcCV0xgV1/rX4xsjhOOQDNV83 jNpv5fvBbZK/yOhI6djEKCvdavzsoOIjTVUDi9MbTt/bXKtgq7l7q9T/JZPqj8b4zG9xi0t3kQg
 RVwxcdKeTkRpzadBPdMq6zlYBrRL4YNzYndi+oGQ7M4sCaS8XZ9+oAAJms/C0xMM1fxvElf0
X-Proofpoint-GUID: n2iqlSaZR5Kc_q3xkDIHJYGqmnk16lVI
X-Proofpoint-ORIG-GUID: n2iqlSaZR5Kc_q3xkDIHJYGqmnk16lVI
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=687a9731 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=upjva8SAc8a8bJwibWUA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22

On Fri, Jul 18, 2025 at 02:32:43PM +0530, Dev Jain wrote:
> Use folio_pte_batch to batch process a large folio. Note that, PTE
> batching here will save a few function calls, and this strategy in certain
> cases (not this one) batches atomic operations in general, so we have
> a performance win for all arches. This patch paves the way for patch 7
> which will help us elide the TLBI per contig block on arm64.
>
> The correctness of this patch lies on the correctness of setting the
> new ptes based upon information only from the first pte of the batch
> (which may also have accumulated a/d bits via modify_prot_start_ptes()).
>
> Observe that the flag combination we pass to mprotect_folio_pte_batch()
> guarantees that the batch is uniform w.r.t the soft-dirty bit and the
> writable bit. Therefore, the only bits which may differ are the a/d bits.
> So we only need to worry about code which is concerned about the a/d bits
> of the PTEs.
>
> Setting extra a/d bits on the new ptes where previously they were not set,
> is fine - setting access bit when it was not set is not an incorrectness
> problem but will only possibly delay the reclaim of the page mapped by
> the pte (which is in fact intended because the kernel just operated on this
> region via mprotect()!). Setting dirty bit when it was not set is again
> not an incorrectness problem but will only possibly force an unnecessary
> writeback.
>
> So now we need to reason whether something can go wrong via
> can_change_pte_writable(). The pte_protnone, pte_needs_soft_dirty_wp,
> and userfaultfd_pte_wp cases are solved due to uniformity in the
> corresponding bits guaranteed by the flag combination. The ptes all
> belong to the same VMA (since callers guarantee that [start, end) will
> lie within the VMA) therefore the conditional based on the VMA is also
> safe to batch around.
>
> Since the dirty bit on the PTE really is just an indication that the folio
> got written to - even if the PTE is not actually dirty but one of the PTEs
> in the batch is, the wp-fault optimization can be made. Therefore, it is
> safe to batch around pte_dirty() in can_change_shared_pte_writable()
> (in fact this is better since without batching, it may happen that
> some ptes aren't changed to writable just because they are not dirty,
> even though the other ptes mapping the same large folio are dirty).
>
> To batch around the PageAnonExclusive case, we must check the corresponding
> condition for every single page. Therefore, from the large folio batch,
> we process sub batches of ptes mapping pages with the same
> PageAnonExclusive condition, and process that sub batch, then determine
> and process the next sub batch, and so on. Note that this does not cause
> any extra overhead; if suppose the size of the folio batch is 512, then
> the sub batch processing in total will take 512 iterations, which is the
> same as what we would have done before.
>
> For pte_needs_flush():
>
> ppc does not care about the a/d bits.
>
> For x86, PAGE_SAVED_DIRTY is ignored. We will flush only when a/d bits
> get cleared; since we can only have extra a/d bits due to batching,
> we will only have an extra flush, not a case where we elide a flush due
> to batching when we shouldn't have.
>

Thanks for great commit message!

> Signed-off-by: Dev Jain <dev.jain@arm.com>

This is looking MUCH better :) Thanks!

Some nits below, but I've gone through this carefully and can't find
anything that seems obviously wrong here, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/mprotect.c | 125 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 113 insertions(+), 12 deletions(-)
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index a1c7d8a4648d..2ddd37b2f462 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -106,7 +106,7 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  }
>
>  static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
> -				    pte_t pte, int max_nr_ptes)
> +				    pte_t pte, int max_nr_ptes, fpb_t flags)
>  {
>  	/* No underlying folio, so cannot batch */
>  	if (!folio)
> @@ -115,7 +115,7 @@ static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
>  	if (!folio_test_large(folio))
>  		return 1;
>
> -	return folio_pte_batch(folio, ptep, pte, max_nr_ptes);
> +	return folio_pte_batch_flags(folio, NULL, ptep, &pte, max_nr_ptes, flags);
>  }
>
>  static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
> @@ -177,6 +177,102 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>  	return ret;
>  }
>
> +/* Set nr_ptes number of ptes, starting from idx */
> +static void prot_commit_flush_ptes(struct vm_area_struct *vma, unsigned long addr,
> +		pte_t *ptep, pte_t oldpte, pte_t ptent, int nr_ptes,
> +		int idx, bool set_write, struct mmu_gather *tlb)
> +{
> +	/*
> +	 * Advance the position in the batch by idx; note that if idx > 0,
> +	 * then the nr_ptes passed here is <= batch size - idx.
> +	 */
> +	addr += idx * PAGE_SIZE;
> +	ptep += idx;
> +	oldpte = pte_advance_pfn(oldpte, idx);
> +	ptent = pte_advance_pfn(ptent, idx);
> +
> +	if (set_write)
> +		ptent = pte_mkwrite(ptent, vma);
> +
> +	modify_prot_commit_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes);
> +	if (pte_needs_flush(oldpte, ptent))
> +		tlb_flush_pte_range(tlb, addr, nr_ptes * PAGE_SIZE);
> +}
> +
> +/*
> + * Get max length of consecutive ptes pointing to PageAnonExclusive() pages or
> + * !PageAnonExclusive() pages, starting from start_idx. Caller must enforce
> + * that the ptes point to consecutive pages of the same anon large folio.
> + */
> +static int page_anon_exclusive_sub_batch(int start_idx, int max_len,
> +		struct page *first_page, bool expected_anon_exclusive)
> +{
> +	int idx;

Nit but:

	int end = start_idx + max_len;

	for (idx = start_idx + 1; idx < end; idx++) {

Would be a little neater here.

> +
> +	for (idx = start_idx + 1; idx < start_idx + max_len; ++idx) {

Nitty again but the below might be a little clearer?

	struct page *page = &firstpage[idx];

	if (expected_anon_exclusive != PageAnonExclusive(page))


> +		if (expected_anon_exclusive != PageAnonExclusive(first_page + idx))
> +			break;
> +	}
> +	return idx - start_idx;
> +}
> +
> +/*
> + * This function is a result of trying our very best to retain the
> + * "avoid the write-fault handler" optimization. In can_change_pte_writable(),
> + * if the vma is a private vma, and we cannot determine whether to change
> + * the pte to writable just from the vma and the pte, we then need to look
> + * at the actual page pointed to by the pte. Unfortunately, if we have a
> + * batch of ptes pointing to consecutive pages of the same anon large folio,
> + * the anon-exclusivity (or the negation) of the first page does not guarantee
> + * the anon-exclusivity (or the negation) of the other pages corresponding to
> + * the pte batch; hence in this case it is incorrect to decide to change or
> + * not change the ptes to writable just by using information from the first
> + * pte of the batch. Therefore, we must individually check all pages and
> + * retrieve sub-batches.
> + */

Nice comment thanks.

> +static void commit_anon_folio_batch(struct vm_area_struct *vma,
> +		struct folio *folio, unsigned long addr, pte_t *ptep,
> +		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
> +{
> +	struct page *first_page = folio_page(folio, 0);
> +	bool expected_anon_exclusive;
> +	int sub_batch_idx = 0;
> +	int len;
> +
> +	while (nr_ptes) {

I'd prefer this to be:

	int i;

	...

	for (i = 0; i < nr_ptes; i += len, sub_batch_idx += len) {

> +		expected_anon_exclusive = PageAnonExclusive(first_page + sub_batch_idx);

Nit but would prefer:

		struct page *page = &first_page[sub_batch_idx];

		expected_anon_exclusive = PageAnonExclusive(page);

> +		len = page_anon_exclusive_sub_batch(sub_batch_idx, nr_ptes,
> +					first_page, expected_anon_exclusive);
> +		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, len,
> +				       sub_batch_idx, expected_anon_exclusive, tlb);
> +		sub_batch_idx += len;
> +		nr_ptes -= len;
> +	}
> +}
> +
> +static void set_write_prot_commit_flush_ptes(struct vm_area_struct *vma,
> +		struct folio *folio, unsigned long addr, pte_t *ptep,
> +		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
> +{
> +	bool set_write;
> +
> +	if (vma->vm_flags & VM_SHARED) {
> +		set_write = can_change_shared_pte_writable(vma, ptent);
> +		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
> +				       /* idx = */ 0, set_write, tlb);
> +		return;
> +	}
> +
> +	set_write = maybe_change_pte_writable(vma, ptent) &&
> +		    (folio && folio_test_anon(folio));
> +	if (!set_write) {
> +		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
> +				       /* idx = */ 0, set_write, tlb);
> +		return;
> +	}
> +	commit_anon_folio_batch(vma, folio, addr, ptep, oldpte, ptent, nr_ptes, tlb);
> +}
> +
>  static long change_pte_range(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
>  		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
> @@ -206,8 +302,9 @@ static long change_pte_range(struct mmu_gather *tlb,
>  		nr_ptes = 1;
>  		oldpte = ptep_get(pte);
>  		if (pte_present(oldpte)) {
> +			const fpb_t flags = FPB_RESPECT_SOFT_DIRTY | FPB_RESPECT_WRITE;
>  			int max_nr_ptes = (end - addr) >> PAGE_SHIFT;
> -			struct folio *folio;
> +			struct folio *folio = NULL;
>  			pte_t ptent;
>
>  			/*
> @@ -221,11 +318,16 @@ static long change_pte_range(struct mmu_gather *tlb,
>
>  					/* determine batch to skip */
>  					nr_ptes = mprotect_folio_pte_batch(folio,
> -						  pte, oldpte, max_nr_ptes);
> +						  pte, oldpte, max_nr_ptes, /* flags = */ 0);
>  					continue;
>  				}
>  			}
>
> +			if (!folio)
> +				folio = vm_normal_folio(vma, addr, oldpte);
> +
> +			nr_ptes = mprotect_folio_pte_batch(folio, pte, oldpte, max_nr_ptes, flags);
> +
>  			oldpte = modify_prot_start_ptes(vma, addr, pte, nr_ptes);
>  			ptent = pte_modify(oldpte, newprot);
>
> @@ -248,14 +350,13 @@ static long change_pte_range(struct mmu_gather *tlb,
>  			 * COW or special handling is required.
>  			 */
>  			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
> -			    !pte_write(ptent) &&
> -			    can_change_pte_writable(vma, addr, ptent))
> -				ptent = pte_mkwrite(ptent, vma);
> -
> -			modify_prot_commit_ptes(vma, addr, pte, oldpte, ptent, nr_ptes);
> -			if (pte_needs_flush(oldpte, ptent))
> -				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
> -			pages++;
> +			     !pte_write(ptent))
> +				set_write_prot_commit_flush_ptes(vma, folio,
> +				addr, pte, oldpte, ptent, nr_ptes, tlb);
> +			else
> +				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
> +					nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);
> +			pages += nr_ptes;
>  		} else if (is_swap_pte(oldpte)) {
>  			swp_entry_t entry = pte_to_swp_entry(oldpte);
>  			pte_t newpte;
> --
> 2.30.2
>

