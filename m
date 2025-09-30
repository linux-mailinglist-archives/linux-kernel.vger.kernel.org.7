Return-Path: <linux-kernel+bounces-838117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FBABAE7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2621924EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F8328314B;
	Tue, 30 Sep 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o/+WhBFY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fCaLoVuQ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822841E3769
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759261953; cv=fail; b=YdQZ1UJfjs/rkRgGzWxkBWTcfmEyeq4TAInkM7oNVKzhjA1r0PuTea9cDBDs/pN9V8VGrf1TzAhIhg+ktS0w+ZIlHT8+eoUbyii/UwEH2qMS1YCyQYTYGpUog3KbMGxWkVY3mk4KkKQKOJjJX3JrX9kcZVMebs6nT9dljFoYfoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759261953; c=relaxed/simple;
	bh=299dxdVU5BteYtO2KnpaK1Z0mOxQqKHpPLrXCETfk/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCfyi3NnPibJa4JCmYJIVVHX3dpMAu7zLQ+torvCS2kUfD9E9hCcoURkgBpgC8muJrqk6vvFa/OTqomCqZq1eqmmWWhLTwhjqEN5GuhrlADOHZGLlGygQGXfPwR4NRL154QoXD1gbSc6aH5lidICP8+aHBTF1Mov3ZZ7Yr4y86g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o/+WhBFY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fCaLoVuQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UHdsLB008718;
	Tue, 30 Sep 2025 19:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=b0JV7imh5KclhtWMOs
	Z3IuHNFDCRtzysd0aHC/+AW+w=; b=o/+WhBFYdVcbLaWhbuy0xMCLOLugWLffFr
	A57XZFe5CmpzctmjPahnKdVeuE+B2WwVFA2jV7+hCd7DkaVtQ7ZbTCpB5fBbeqH9
	J2Pnbv7M5d5D3aeDYV19ujs21suoGCdzOzD5I0WCCJitCPfC7JEjUAAWKhLms/JJ
	geAcSH/wHtnpW0FU8VdyDQ1XNmuUIQPrlWpemFdH4zi5X1Ev7VNbssE7AE1Fl8+B
	CPTMnstOEH+c2sKh7WahjSnjSFBY4eSEBATbualaJugVP5MUXzijUtX0aJNuTiOj
	0dgDtEI2CiYKovs3BjVFeO9l5C4/CxpUTd61LxuIUi6JU5D3i4CQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gksx886y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 19:51:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UIjCSi036820;
	Tue, 30 Sep 2025 19:51:37 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c8jrv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 19:51:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kv1TxaWbatMhW5UnDFfLugM4NpiuAnuzRXIR6e0le0zPeldU9enIl60h7fDyLDsyX1w5rJHWftbA5tK7zIWaLFCvEKRl7h/18vI0gpYhid6WMYI4ILdNhvz1MA6HZiIbKSbcL0YDumFfpCUt27NZLPy3Fcdsert65QrF7yD7hHZJhZOqlCHIqSZA1hVoWl9L+JYH6WoujgYsALnzOqfjzKwDiDcjSDrzndl+Pqja9ND6gdqJjIyVd7nqKxorEmPviqKENLpCWmgmESS/Q32xYAE5NzM5QNKXYNTw0lUkMMp9W9MqpzrnxeBGO1UChFHC46pXVVxb5L1NXCX24ve0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0JV7imh5KclhtWMOsZ3IuHNFDCRtzysd0aHC/+AW+w=;
 b=aY/0OXxGnpKyiORKSrrn3n264LaWJLZcH7y7lRUQGPKzwPICWejC/wIItjr2ncIov2MUB67v+QqHiywkG/q3q77/81Wpib0mDp4TQEgRqd9Jg2DdKjeH9X/7iRNhs+38Z//S65xWCgqc15OiI73VynBgHDA51wUFCqQSAvIYc1TElbGEq+idmTAwylP+voBjCHxg/ch6icSFX5LLeevQ3Whyh0njOghYumzxCO4c/rhkoMtK2SHEf7L9nfIMJCRIBqAwfgwvv6bqmA+tOYCUsOOTJlhjiwZ/+lcy5IAqnHXGW92EPlLIRNYXI5k1o1exMYNy1PtCmW5NvFTGcoPnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0JV7imh5KclhtWMOsZ3IuHNFDCRtzysd0aHC/+AW+w=;
 b=fCaLoVuQwAB3GZ6rJ75tuQ2o6uzLL/F2ec1J8NkVHbY0xjYbuohWYR/+da5tAx3hy0vwtyEehrcYlzW6Vgwu2fAAk4RDmFoeDwkcR7jX8Uzn9qCfonGNhn1a7s3H1t0YmL35Z0YBs1P+3EEY+DZZAr1Ff+wXqKNQtSZ6ee/rzxU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 19:51:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 19:51:31 +0000
Date: Tue, 30 Sep 2025 15:51:12 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, peterz@infradead.org,
        bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        tglx@linutronix.de, akpm@linux-foundation.org, david@redhat.com,
        derkling@google.com, junaids@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, reijiw@google.com, rientjes@google.com,
        rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
        Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH 00/21] mm: ASI direct map management
Message-ID: <aNw0sNehEQTWVI29@char.us.oracle.com>
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-ClientProxiedBy: PH0PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:5::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN4PR10MB5559:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a1ed50-3ef5-4d14-de25-08de005ac0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v9E4JSFQsX0Dnd/+E1I3uqpVpx6hKgb78jYJrOyCisY6YT/xfqIkH31sqqNZ?=
 =?us-ascii?Q?KJZpPKD9NaJ2OxevmcRCy9gPw8Vn5f4Qkmq7VnwweCNGhnUgCuc+d7Atqfkd?=
 =?us-ascii?Q?OtnrJEuVDLd4ZO7CViv5+m4UPHBVCv1D2LGpqYLd78LLI0O0tjYyad86yr16?=
 =?us-ascii?Q?7bGS04csaPBNv38Rxq/JkBYYmyDOGzg4M1MRMUCXXHrPSRPlyW9BY1eqUFBs?=
 =?us-ascii?Q?CqnXm+NC33tKYp19y8dRc6RUSkpt5Ounh4L/iNuV008eMF+TtGBGoEx9nVCH?=
 =?us-ascii?Q?8dWTkEG0W8rCM6ldSV4ENwZOHj+ENy3KGNrjB3kHealEv3/IGFef67X3Hw2V?=
 =?us-ascii?Q?I0E56lWMM263dJqKhj3HYASNVZvBzVa5O8eKC78e3YPLGGX3GYh0H1n1mwXu?=
 =?us-ascii?Q?FmEZBu2kp6llGA38WKicwGVpiyZQf1FjwuB9E/aXkXH0bWOoxhdWkyFjYVnc?=
 =?us-ascii?Q?nC7RqcxfMhRLUBe9Z7cnZmvbHizqx+FhKmGJX2gkLUQZF+juSXvmDgJAaj31?=
 =?us-ascii?Q?WDMHDqIp+fkQo00MURg0ENKAaZUqbCGvCA6YAQvTwUiuM10rKwjuzC50n6M7?=
 =?us-ascii?Q?xBV91ooEHis2pOpaRbPE4FdmjIsi/NrjjMqYc1bizYbYrnhgTidyAuEdlqtL?=
 =?us-ascii?Q?JI0Z7V0+RJc95q4q06TIr+SuPbZQ1AX2YiBmPgwISwRTA/2b6MzRuyYNlh2U?=
 =?us-ascii?Q?HAx+Ms6K+0qyNtajNm7YX+QkEtHgq1eTiDdU9u8rQ8RlTLtzByi/iNZuE/3n?=
 =?us-ascii?Q?jygoieT2Y95Iyra2qqul6xk9wHWQrjdp6OOt14xE8ns0o4QGrsoy5I7dMofy?=
 =?us-ascii?Q?I/suenEvwhxL3Ls0mndHIld11e89Qjj98q1k3hEeVaDRAlrZl69+1FOBY0Ud?=
 =?us-ascii?Q?TY4p+eR/XsLLNUxl+fNB02KFQ4NrUkqhD6TrKmPdkom/sSv2ttx6NMoAEJeL?=
 =?us-ascii?Q?dNCzWbuZXbGAoKpBwEXQJeNGQxvoC1MHvOPRNWtuhYjA0mPSOD3+Cd85h/dn?=
 =?us-ascii?Q?9zWtg8kRxd0p7IlR+vBBhBXufRjDsG1rD6/qtDDSmYo/fi5JNDY/bF4JIBiG?=
 =?us-ascii?Q?WXlpEE3IoVsHRAepoKnttrkMnSRIiKpobDEKZj1SCFomFgoRuVvdJdd0iIWt?=
 =?us-ascii?Q?wdtmppOiFbhMOEdPH61J8URq2cjEZ5svdZ7hnEJ+SDJVX7LtugYyitzT/lBX?=
 =?us-ascii?Q?jschtCZGTSH5VUYGYc7yVTuBw9PIC1iUMWHc+vRYqQySfPJj0GuQAA9CpJ4/?=
 =?us-ascii?Q?vgEwWIPwP8z59qR1PgnbynQxa4KWJPGkv4Rh7dY/H28W6jkjWcqBh62avdcq?=
 =?us-ascii?Q?PqwkCXlGTrxe8hbEwab7rTSHpb146Dou7MJfSBBn++MejDFpG0KbhszAorOa?=
 =?us-ascii?Q?kmgyBJKLutPW/JdmCU3BUAQeO0Ft8qdOItXeefc+Bue2ylcL20y1b4+jt7nZ?=
 =?us-ascii?Q?hV3EPpctNuQz9irV6ZQ+jpRqDTmepvXQi0bacCJau2cHRuEFCFqofg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lgx8L8hZZlQrVlHeD4BCZJX4dz37pE+bl8Fo63cbznol3fvscC9IjnmwDXAS?=
 =?us-ascii?Q?MtxxLfUCEmT04Q4xuJpXmYZqUTYq7MUkQNmWQ3Phu9SIyYytRr1Zp3x7xhS/?=
 =?us-ascii?Q?suKwW3FG+hXO2L+cctLU7J+Nlrzblurnngq0IL+ysgwllwXbZrd5mZxkMCw4?=
 =?us-ascii?Q?7lNMQton00i+aXD8LWBw2YY5wqpjDKBJa/dMAnydqgw4i/DTzpELU+mSxVCK?=
 =?us-ascii?Q?94dSk7mFIo5WdELVn7h2M8tZlY/6rHiC4NDqrGZFfkT7LYKtxh4uQblIjzpz?=
 =?us-ascii?Q?ltEXNG0YPrwGd35Hp2Smn1er8XRJCfh3DfIwzgosT8XhiQ9GCY4IpdHw3elP?=
 =?us-ascii?Q?GOfLezMwRZ3C0vCGAGThDTobX6I21yPByCajKoIfyMxlCwnfOBjEKpa89OFH?=
 =?us-ascii?Q?nC/Nybx5LBhBvIAm3KDDIpYiVxQNGIvSIzQIeEih1ZIln2M87osFwpsWK2P5?=
 =?us-ascii?Q?vdkDmFnLqJNqLwLdM7UmOP/iYczw9Q1apiMmCZRYtuaiI72LolyI77/Bhqch?=
 =?us-ascii?Q?KhVxwnwTBtzCxwAS8bFupGgiZy4fTrBTv5saljxAh8EwTOI7o2PK0jEwnclo?=
 =?us-ascii?Q?AVoWzE4/FdfhQIZS/hDXBWrIr9g/lNAFOH9CgC/W1H5/IX74SSIP1LTQZS97?=
 =?us-ascii?Q?0KsxFUe06WJrL5RAeTKJCYBwZox2q7218sUTfdHKQTQGJ/sVg1gIzdP1FXzr?=
 =?us-ascii?Q?/bMu/sqg7knhiyojqG88FkDn7Le1KDAIrdEUkjXnq5Kb4W7PUvDBqFuHdyw8?=
 =?us-ascii?Q?HlqQD78nIuQl0ot6KNdxrNmYdetrbbZ55vltTG81XecPkFkZ1FCNddBysbv9?=
 =?us-ascii?Q?hnDABToxlYCvHxHrsGQYucPF4YRDcXx449Q2u+RALOfsQaojvuFVLbi2kCTD?=
 =?us-ascii?Q?FPav+a5/qBvt1XamqQEcG8GuLAcYFPJeq2zjnwwWOHwjqyYtiXFz1FW+z3W5?=
 =?us-ascii?Q?LnKPNi85jha19cV4hWtrh/W1QD6k9yZ5oIXMPArZ8vXK7Mwwc7RCC4/fHvLT?=
 =?us-ascii?Q?qiejjFGp+a3QfWtITVA2IMijuHhgAJJ7VqQ8AJZPDw6VlTRrQ9VKv/7nrzb4?=
 =?us-ascii?Q?WX6EdEt0MsUz6TGUNLXkvPLxZn9WoSSe4ZqY5aaKFBvGEs7Q8jI++B6FWThR?=
 =?us-ascii?Q?IvS0GsczfPQYafzObsbw7UsYTRTs7yCY4F5mS3oLfxFFOnHyfrzKiFrE14jb?=
 =?us-ascii?Q?V0ruehm/fnMsKCkckgalJXE/+r6kSYmHeE50qjjiGWi22dQ2VYyqXYmC1ZDa?=
 =?us-ascii?Q?wRT45ZiarzjrPyotIuEr8Xzj2isNIALLDektmBL9z6Z5NpyV7+PVcHRcj+5Z?=
 =?us-ascii?Q?uNyvWLXO4GNsE1RDCREPP2upYUoahVHDibYpAxd1tsZ55QVHbFBxfFyu7ZQh?=
 =?us-ascii?Q?8bLgDtYHJlFQdrg2B5KtKCDWaxSIMXYm/0a8oBkuVslB56BK/IoU/oF61V5L?=
 =?us-ascii?Q?yQbSx+dYMvW/EiO98lGXxnd0AdWB8SxSg/0E9JbB15dTa5WVFA9D+Ok3LB+8?=
 =?us-ascii?Q?ijiPqtfRaNjKkWZ71RIlR2rjFhwfIH4ZYlK0O/Wy6Wq0Qs/UTWa0iinHAjRV?=
 =?us-ascii?Q?6O0zQ21zsSLV1xzA4Bm+XJMGxrEmtcYtix7RuRe3CdxX3q4MdqNMBBbJpcfG?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uLcALFaRDDRGqdzU1wOnAw625Kwb5gnirKu214zr1VcMZeccVQMEpD4FuPiSo6HaU7D11L5O6u5BzFjVzS2pEWmog4rqCS+KFl3HjIDZvI+YmEs3G7uve8OXWAtfDtixZM2cO75GLJRiI4oMYqiirjfigBdSCXwk3yCZNJh9FqtBL64bNniyr0L/90pqjnByjNKHv30xhIOcKFeVdS1fgw3qLLUAJ9t9h0498yvOumZRWS9RkB4FzmOZP50LZ7RRu0w39bWPdw351hlGlQ6IVkEK+KNXq0vdPbOTC/L6gDROyDEZr8WhjLxD6CA56hs2bhU1paTjKxql4kKB8241CdiNJ7cYPnItfIgtEw/ANPXM98Z1+QSr3J/uDOydnkuPslF2yg9uAUXpDWsjkmb/NY7HAoVKOny4bwR7UET+MrONtqtkj0yvYSuU5113O3PbkyWyg1yQ3wlGzYbRtu6V28kMjkSnuKBEQbtwG4hyTdd1PYlY6YCf9LqR7RwH2m+yy7DLkAV219qQGF5BhpIjbzM5hwh9UzDyf+2stJ9l3IFIKlq+LlZrh23rSeBHdSBqzJtD+PCMHMGq927KRhyNFvU3DU1agBVAx65VOQ0Gm7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a1ed50-3ef5-4d14-de25-08de005ac0e9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 19:51:31.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFdfM49HZ3c5jY1lW8hZUHtRzmYwS6xNRySk8I4j62ngoMlDW4qAQKleTg7XZbwEjOfRKkUfUXbIS6CX0CpRrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=807 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300180
X-Proofpoint-GUID: 0UFf96VNTkhj6tHjmEeA07xGaEDvhmvr
X-Authority-Analysis: v=2.4 cv=N4Ik1m9B c=1 sm=1 tr=0 ts=68dc34ca cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pBOR-ozoAAAA:8
 a=lNWLER_mRVJqa8tFBSIA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: 0UFf96VNTkhj6tHjmEeA07xGaEDvhmvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MCBTYWx0ZWRfXyRNt+X9SZUWE
 22N5BK77+4VfvjbVoEg1/6PrRRIS/0tEcqkTcql4Zz9OnWsqpokP4Gm4CVJQjaSTOgM5MbA7qPI
 vMX++R6NudtQ/GhabAcwzy65s2kTDjccSq3SNuL4MfiiZenH5VMxe1lErKRQWdn7WKh4MT9XZmY
 reLXoBCw2QxfT45v/qCnHflRi/vS1FUwukxEcpZFnoZsjD3VrTnOArmIr/ZjBpl0klbMcEnovhr
 qTPMk9SmBCTM2Ze7kT6udUBi+echmyCQ9Ey/MEtfnnSMg9swjJWwpIpNx4hJLHSXfFJwNVHnm+a
 Fj2n2h82BRN1zaeIyinsOlFs0M1oohhyhGREEYPPQXR9IwBSRoS3+xLFMluoymG57uCV789RB1D
 p2rLz4rPu+BmCWV+Crs3CE/GlPwM6Q==

On Wed, Sep 24, 2025 at 02:59:35PM +0000, Brendan Jackman wrote:
> As per [0] I think ASI is ready to start merging. This is the first
> step. The scope of this series is: everything needed to set up the
> direct map in the restricted address spaces.

There looks to be a different approach taken by other folks to 
yank the guest pages from the hypervisor:

https://lore.kernel.org/kvm/20250912091708.17502-1-roypat@amazon.co.uk/

That looks to have a very similar end result with less changes?

