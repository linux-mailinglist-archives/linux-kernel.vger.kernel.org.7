Return-Path: <linux-kernel+bounces-780150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92AB2FE56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400A3A078F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4612701C3;
	Thu, 21 Aug 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IKZrm7G+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JsgLmYXy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC02701CC;
	Thu, 21 Aug 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789619; cv=fail; b=DDV6bXE196fDQ4Tlt5Inn6yT241YuOQdltIqttfqExHZ+ht7rNTwEkCjJ4Sj8+flim1OCL2Yj7m0zQLDeLKqKeEujIlgFsuFwDGBTBMFMTu5AJ9rNMEFY7aMY0+/xygyi3X3Prb+iA5Ibn29GibdK0QvIkr4cHjEOtaD6OPosfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789619; c=relaxed/simple;
	bh=gNQ9jbNC39djgZoGmGHxZMBCWG1EeOrTo/apVNVNj1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jD8aJCHDDOnGSUVt0xC1N7j+QwNdhragHx9XdW3XdAHTKwfmCr1lbFdWycgc8O79bROPT7IBT4ppAaGS74+ngEElFhrcPFQu3iFxtwHjQF+wN/tQAaFXDHeonyN1DNu8Ar9LPj3Na1sAKJTFVVmUHUfZf+qiPdVhcznbqiarX1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IKZrm7G+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JsgLmYXy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LEl0uY015118;
	Thu, 21 Aug 2025 15:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nK675TyHZwf9q7U78i
	DMLXqAzQIsfTUnPO4K02C2LPE=; b=IKZrm7G+cKEfGoCvHo33RDPxh1CPhRzpjE
	JZiEKWrnX6iu3Ph7/pcJwTXB/R917CSkRNkWzYfzNpfh95oD0B3v0NO4224STG1f
	4mTjbOUTah3yBqNvF63V2WaVWSV6anKLhUPd9/w3I1vGBNpcvRwpr9C5jHLVavU4
	k6BZZlhOU2ht9cMPrngbzJvjDM8yF1dYbebeWSHGoi1yZe/axDQqW/PSmm9OJrie
	Bes+sJcUNy2VfBgrMgyhoQOD6Nrb1zgH/vzJ+5DAF/YV0O18BlclURsatfnO7RhB
	XbdvrWt7HcyHMK8phtUKpBbc+L1c8/2Zh5+Fzi9TsUczjP0ij6ew==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0trusa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 15:19:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LER4Nb039180;
	Thu, 21 Aug 2025 15:19:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3s7ve9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 15:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH3SGvxtpJmYxAp0DNmzemvTbVS5eL04xU5Aq+gafcqEMKvFqsq6+igKfOATRaPy4dX9ldDnReDP2ZzCc33T/Wjlha1dPJKmrA23ejwNtRCZW6J4aQBVIP8XgNOSaQpMPn2b+5q9XGvObdSqOAvyiHu7P7ultE+mVyYOutcKZS1KwTqqULYoqJ8vzVragbQVAZaKQk76MpPGf6lWqW4DfSedmaGcXVIN5xixFAeT9JJ3zvm7LAJF+R+f0owxl129UlgRqVAl3GrDHLUM2ByqINchJJKu6H6VuzqBi4AU99QWYL3isaiCNLDxXMSBRXhuxiBKcRT85ZkQGWkszfFatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK675TyHZwf9q7U78iDMLXqAzQIsfTUnPO4K02C2LPE=;
 b=JJu/iC/XWY+5tETVUiQk94iCkZk/Rgh7fEZa6Sdrh5H4gUpc1rd2iUn6VMue/mos9fjNhyCb5mZDtdnDLjRe0UO/9VgKM06KhCVQHRv1sNjxjEqNPMjjZNJpQLJaeqaH/qS4asfxlAd7XxKFoC328l3QV8ijRcLS+d6ZT44JhBwlXU6CN5n2OZL79e9Pkgw2tM/E7UBm6dyW//NYiOmXV9d4AzpCyDpe4PL+99UV2yLT59MzDK5FxnTTGp5W++mO746qwimNF4MHxGe9rwWIxCvhtD9YAzRzJG7me+W8ZvTv2M8gfNUzekN6FIy6ZtIm9kwFLcgt0L/f0c64jMRWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK675TyHZwf9q7U78iDMLXqAzQIsfTUnPO4K02C2LPE=;
 b=JsgLmYXyb4bzEX8exdAhkkodLhEhmiVYpceD5rOJNZO0rOwtxZ/EvyDp8vZTiDBRrJ6tqr1ckBbYRNJw35YkPvYdlCKsRTYydJIB9hVPH9GS6GECpXl9oLdiQQLQMqjk03FDe2hj5MU07bQs4kdsfXAtn7ulf1PiEI3sMW9Y7AE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF8337777B9.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 15:19:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 15:19:10 +0000
Date: Thu, 21 Aug 2025 16:19:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
        peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
        tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com,
        jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
Message-ID: <0d9c6088-536b-4d7a-8f75-9be5f0faa86f@lucifer.local>
References: <20250819134205.622806-1-npache@redhat.com>
 <e971c7e0-70f0-4ce0-b288-4b581e8c15d3@lucifer.local>
 <38b37195-28c8-4471-bd06-951083118efd@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b37195-28c8-4471-bd06-951083118efd@arm.com>
X-ClientProxiedBy: MM0P280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF8337777B9:EE_
X-MS-Office365-Filtering-Correlation-Id: 858a2186-2851-41c7-3ca6-08dde0c6146b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FuwT855XL39RGBwHX0OPc+xm7Yi+OoUdoqZptAj8Wy/gvyrdt6npA6febYzz?=
 =?us-ascii?Q?3GsSinsaw33rEvWeU9n7rTG3faKnSAmNeb5mkIdcYjL35MeZHbWFCdkOn7AW?=
 =?us-ascii?Q?ZhAtwhf6/Mf7LXHIKPUGXqO28xCV64J5GI3XEXVlbY3Zn+sPKzz7AOgPEI7D?=
 =?us-ascii?Q?gqjEMWs9pSuhP76DouBqrHPlAGIQzHGgBYb7NhYt5ShC4f7OZoLYmQ7S/nP0?=
 =?us-ascii?Q?jclgAe3gvmh67lDUwB7zHL+LPkgz4F47NRa6o/JPuSvxfvzoL0zUQneE77QO?=
 =?us-ascii?Q?rTQp9AhffoOONz+Nb9IuJSCsr/+3EvQg9vm81NdSaYt1nRRER0Gzn2TKu9l6?=
 =?us-ascii?Q?pv7EThl37+NA5f90mNfLNobhGi24QcluvV97k9bmtFPt2HSQw4JzTWyOApux?=
 =?us-ascii?Q?DP3N1VvaLUSkXpvlfimczzQTdq/KabKt9MiqTcAL645vUDzXrv7Dpo6LITD+?=
 =?us-ascii?Q?Gtqi0bStCj1s5OPTkVKtmF95GHBOaABZcrLqlXL5660wDLgPJX9Q15elrY17?=
 =?us-ascii?Q?85twqaa4wrxLeGXPkwbbbx/15ozg+zYwHwjR4ffA3r5LNF086jtmESLX4VlQ?=
 =?us-ascii?Q?gbtmCN5rek/H0NqzBnPjvcMIL2hYqSj/8wkute1F2EugnIdKdyhQ1eFMdTgw?=
 =?us-ascii?Q?cld/PjMT76/hDjV2i9B9P4hUb/adjppg0SDllQPhBhADGsXPV/QcKXyczCB5?=
 =?us-ascii?Q?zsbQRBUBonkDDylD5kdCTK1k9gQ8qOdWIKAqEuXpCasGucLKrOcreaqEZUQw?=
 =?us-ascii?Q?WI/hzd4smpXK/4FK5pt/TAGQv+7sdKBSBf8TOW97/qpGUMck06IjyPPdH1jy?=
 =?us-ascii?Q?J6M0Fp9pIstR65fBos1R+SbhXgvLSbp/M1HgVF1kx6a2FtV7I7wgcJkHUSa5?=
 =?us-ascii?Q?s83YSNpkkPoRjKwpo4ZtOfB3jGDzn4ywF1lyhVbELp9W3uzubjZxXDBDIvAA?=
 =?us-ascii?Q?MQWAnn/waBNUYMN8G8JQ13B3iL5Ahkgf4tL9bGOwkKhPrr9peS4FuYiHs/Xa?=
 =?us-ascii?Q?uWm6BKsITt2ZY+/wTfpLAfvSmJ9oT4S7SKUwCbEwx2C3xfyxdkg3pXCRi3t9?=
 =?us-ascii?Q?3saNGGAgCS2A023LeiCupRL0KTMk7API74Nh9htrnhRAgWxVu7RxCXjBcciQ?=
 =?us-ascii?Q?qzB0tc5eipos8YFoUdmkZdJirQu+/8ryIAheIrgtzQsvxi0yhkkWO5ad6G2E?=
 =?us-ascii?Q?BYVyrRPqXA0aGHf9jdur7lPjA41M0/4uNkGbHC89ki7VH6z0wt26P5JxPah1?=
 =?us-ascii?Q?hl1SOGMh6OzA/vLiq95hP9/C707/4dG8wNzzRvk4fW6QOCnCsoA8vdaD27lu?=
 =?us-ascii?Q?V8URuXHJtffvV9Uq27T6VYyXlmOYAaju9MCi7GE2xaIqVXVM1GQfuvfAIb7t?=
 =?us-ascii?Q?RCnIynHwSjlyM5xGMEgElSw7UXBAZoaTqhavJwbkZj/QbASucAQ3Hxs/L5ze?=
 =?us-ascii?Q?d3jm8xBQBEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jwTEgGnlTYkHPn7u0ArHp2uHgZu2iIvgt1HcQQZ+WXDwnn0RBXkrghvocuB6?=
 =?us-ascii?Q?JTT4KvTYan7ZqiWkV5b0ccXUdtxdPk4yqb9VaiC8Y9hPa9icEwdPQ3jqi2F6?=
 =?us-ascii?Q?MkWJ46DqZkv4EetkHFDZKpCdSmpSFmFoJEXkM0I5FIv/PJ8tajJwjEIjKs9K?=
 =?us-ascii?Q?O/yzWm95HsxUYdIMXdsE3T3Tc7deVnCkH2ZsIo/U4BcBJuCVvq/52MF8nk5R?=
 =?us-ascii?Q?h/8aJZTBkFY7ooEvEXJ4Ma/uXmlKZB532mpbKuaIv6Ow/l8rzhyjwoZ7qqyi?=
 =?us-ascii?Q?UTOV2JqTDKMvcN37bOVDjxurUGSuQbKVuNMxw0PbjMP/GS3GYbF4QElrURHp?=
 =?us-ascii?Q?g7vye48/GkqHQmBMuIQtkvgz+iwSmkTzgSpCvVUSch57joh37fDEz9jkP6U4?=
 =?us-ascii?Q?UTemaRcWlzrespDB/Wh/UBADPOVLKqKK68Ip5WHtAgCLnQ8cn1o4DwRN3K6K?=
 =?us-ascii?Q?Zpu8hsq+K84D94YfMrq4k1p0VeiF4K5cIHI6JRdZbgz77Wmlb3oUCv39f69t?=
 =?us-ascii?Q?44jy+Ljk2QD8OhhhQ6IzHX8x7QW2xdgaAQqkuSdmJLEwKqggxXpPl+eEqknF?=
 =?us-ascii?Q?jYyCg0Vsc0dWiuVrH5HJGWrM2OuclNJpJoFr3hENQhPOMWQ/8+YNoFCs9XTp?=
 =?us-ascii?Q?B3GvOnoVN/er/QjU4Sz3x+H7DwAseB3hN4H8PsQ5JnKpqIbbrNb3+ZhYL4vL?=
 =?us-ascii?Q?cIIqNv8z/zPMppMZ1FKy8ru8/zBsJTLogXbVlHObLPf6NF0y0dSTwn7szTq3?=
 =?us-ascii?Q?Q7Vduv7mMXIACYi4LPq3nGSVEfdTxoElVI1yCNUifTf7dGw82JVo9qM1TbZM?=
 =?us-ascii?Q?pmVdUmX99iOfDuBZzoH5YzKNhpHWHal3uiTzcxKLnhDpSXV61qZ2xZoOC2x6?=
 =?us-ascii?Q?0UlogLlUYLj947TgqOkOINtDW4pGyP+toDx0LzZqQR1Jg9grghwXKKREvTMN?=
 =?us-ascii?Q?1pXYdpi7f67pZUhvy+gld2NZjbrx/hIqqssN2ZN8Y+BKPqcjM596G2h0rH3o?=
 =?us-ascii?Q?IzN41iA1t7mdqB8CyXr2cccXbv+f15HaVsYl9lS8cofDNnzsa8CXuCXX7b3g?=
 =?us-ascii?Q?qeujoADpuoIYmnOlITRJYeKutmnJYMwEu9IjHDMHxCp+qkYstheKLEaBadiQ?=
 =?us-ascii?Q?8O7FnRD/kcle9OhiSXLNl4aWPVX08lv6nhcbAYLYkN1+b/iJMq5q0Qsnwjfc?=
 =?us-ascii?Q?hijlz2qWYK9LHDHJ5lRTJzueKaDhxbDPSq2P2bqfWiRcMmCXFDEe7V+PdaL3?=
 =?us-ascii?Q?7s84HoP+2nM2c8AfFlbEDLhsyOnatk3yw0pAoRiIj6xWj5KmI/iNrVvNo+di?=
 =?us-ascii?Q?3j8wrTdvGDZ1uCQS1IUsoC7Ix+MxLXQN+pkJDXbH0VjSgkaLdwV00C4a1Pvo?=
 =?us-ascii?Q?YZYLt0MKzneVWLiZhYyX3WRIOhtTWkt/YORC/CFvq0ScNe1W9EWwIiTiv5+D?=
 =?us-ascii?Q?yQ7toaBceNVAfjPWlRVYulIlLuWXIXpWhy9jEJzBSLRCOcDxh/4dWny9cvTf?=
 =?us-ascii?Q?ZrkzGUOyKr1rXlBVJFlvovC2p04i4+zv8S92nQK7t9KYus1B7i6PXNasXxHu?=
 =?us-ascii?Q?BFrlQevCLi6DKmG4RVh5L63vSvYM8MepAGIYev3+mL+E0G/P0MyOrZSzzjVf?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L70gGpPDqchX0U87cVBSIlEY66vbZUAWUj/I4f6U0WbZhxI3zvneZaGTSIDfj1+SOPhkJg8nFDOLHJj9eDDNJ9lTqs0/UqWtn60KRG9a8eLggV62cs1eI0TG4n0K308QHk+XUZgy7ZW/IkK+lcTa6wUlG6FpblmDTtJ3PzmXdzv/wKo2qJxHC/SDj5YwhK1LJ209RVGKI/ufkdC61KQ0YQVeEXgotbGKKtbZyiiynsP71/Se7oQWFacZbeqdI4D1DZ59UZa33w7LnMB+SrD+Kneu1SHsnBp1uBu7Xc+dtOSd2fkpzWgQh5/n0iAsVH4pszHUEeZWozuTt4yP8neluKEBnidlnwLm+jQGtLUaUPyCKLvWJhnSoZ6vkI0MEnqdBAryuvyYy0v383HLPzS6cmTJx5TFfNnV/WPEETCzgFaXaj9Is+2LdJBFtxKLVLu30U2su+7qYY3tvk76nFsAlqa4wziyQ4eweEdWkdw/1jh+x8EqUqhxBBxest6/CE2Zt9+tneqkal9zo8V4L3TS/azxeDJQkXElZ/TZH+n5BDTELhPAXp8L5VdiDhV4JHB7mvsYF0SORme4HnvyHtpr7yBwdTWyONF5iekyPFfi6eA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858a2186-2851-41c7-3ca6-08dde0c6146b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:19:10.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rj4VgUMPFFrahTg2Zxe3tMhXZASDvCuQJN92QlRMk5P35j7iIdeX6uH2VqoNlsjEIE1aSOyD7gbb/B7qW421QZ4glT/9v28bwDE5S1Tpbuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8337777B9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210124
X-Proofpoint-ORIG-GUID: cwSNNFoSxtBXH8FeeOtomvDgBhuZTQRF
X-Proofpoint-GUID: cwSNNFoSxtBXH8FeeOtomvDgBhuZTQRF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX35ss3K2c1Z4d
 onbePRtOZuQbrUkfGLKb+1y6w0sLe7qx7XCTaGzZkPBQfnXLRle1IyO1jWdKDbqNg4DJuerA/CK
 ttAvbt+4l/oT6OdkN85R0KlVC4pQNfCQQGWytzwbalFNlRXLA3hH1ENag/79xfglPdexRxWEhE9
 PDzC2KDPG5vt6luvPGMwX/NOY8E303eiuJ4qYXpUIu5ejFQe2zEpz9GqC8gnewWqOpIGSIH2+PW
 GEgsfNkRwG7GNIgfguNsVRZjTopbGrKvhNL7B86rq/DHX1QWK6LJE/gArx/VZGlenowEJoNPPNT
 KzoD7hXv2YZxWEGqt4z4Q3JCxeD1gf8ZKE/vc0C1c1QKPgvyFuvAa4TcbNCZXDwUjyAphOjic57
 3Pda9yPxLt1EsmeFrWrCtN0Y2oub2w==
X-Authority-Analysis: v=2.4 cv=Qp4HHVyd c=1 sm=1 tr=0 ts=68a738f9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=20KFwNOVAAAA:8 a=WLh-jg5eFhSaglR6q2oA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22

On Thu, Aug 21, 2025 at 08:43:18PM +0530, Dev Jain wrote:
>
> On 21/08/25 8:31 pm, Lorenzo Stoakes wrote:
> > OK so I noticed in patch 13/13 (!) where you change the documentation that you
> > essentially state that the whole method used to determine the ratio of PTEs to
> > collapse to mTHP is broken:
> >
> > 	khugepaged uses max_ptes_none scaled to the order of the enabled
> > 	mTHP size to determine collapses. When using mTHPs it's recommended
> > 	to set max_ptes_none low-- ideally less than HPAGE_PMD_NR / 2 (255
> > 	on 4k page size). This will prevent undesired "creep" behavior that
> > 	leads to continuously collapsing to the largest mTHP size; when we
> > 	collapse, we are bringing in new non-zero pages that will, on a
> > 	subsequent scan, cause the max_ptes_none check of the +1 order to
> > 	always be satisfied. By limiting this to less than half the current
> > 	order, we make sure we don't cause this feedback
> > 	loop. max_ptes_shared and max_ptes_swap have no effect when
> > 	collapsing to a mTHP, and mTHP collapse will fail on shared or
> > 	swapped out pages.
> >
> > This seems to me to suggest that using
> > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none as some means
> > of establishing a 'ratio' to do this calculation is fundamentally flawed.
> >
> > So surely we ought to introduce a new sysfs tunable for this? Perhaps
> >
> > /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_max_ptes_none_ratio
> >
> > Or something like this?
> >
> > It's already questionable that we are taking a value that is expressed
> > essentially in terms of PTE entries per PMD and then use it implicitly to
> > determine the ratio for mTHP, but to then say 'oh but the default value is
> > known-broken' is just a blocker for the series in my opinion.
> >
> > This really has to be done a different way I think.
> >
> > Cheers, Lorenzo
>
> FWIW this was my version of the documentation patch:
> https://lore.kernel.org/all/20250211111326.14295-18-dev.jain@arm.com/
>
> The discussion about the creep problem started here:
> https://lore.kernel.org/all/7098654a-776d-413b-8aca-28f811620df7@arm.com/
>
> and the discussion continuing here:
> https://lore.kernel.org/all/37375ace-5601-4d6c-9dac-d1c8268698e9@redhat.com/
>
> ending with a summary I gave here:
> https://lore.kernel.org/all/8114d47b-b383-4d6e-ab65-a0e88b99c873@arm.com/
>
> This should help you with the context.
>
>

Thanks and I"ll have a look, but this series is unmergeable with a broken
default in
/sys/kernel/mm/transparent_hugepage/khugepaged/mthp_max_ptes_none_ratio
sorry.

We need to have a new tunable as far as I can tell. I also find the use of
this PMD-specific value as an arbitrary way of expressing a ratio pretty
gross.

Thanks, Lorenzo

