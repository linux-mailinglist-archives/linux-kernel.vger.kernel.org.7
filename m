Return-Path: <linux-kernel+bounces-730280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62E1B0424A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EC61A64A00
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720FE259C9F;
	Mon, 14 Jul 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m64IgGDa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B3TPJ483"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7332239581
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505005; cv=fail; b=Qq6Q2r4jjw8fSM2OEcXqrSAEuZwbhe0kASY6rJWQm53fZ/3Q1rjjAsLRtdAVQ7+efpPDcdx2tM86teQas7Le6CD02sgs5UutnzJ++Z2p1n29Eww8UNWEsqlzS4iww9Hc/jrpsGXF0w5CcVvcZM4nBIak/b+Pvj9HMdTDEYqJAOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505005; c=relaxed/simple;
	bh=pjJB0cJnjpGfoZ187tUP7pZvY/+KTZJZRCF+chbPZ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ece23F5K0F0EWVC0pG4r0p/t5okCzZLjrzvBzT/UAyxKDR3YkXv8pYN/DEFcI9PIww4+eA2LgS0ZNrHvjkoWdnt/5FrzGN8z82vuQADXsjIzsXBqg4bGKM/7zqUt3f61o9vquiiDoVsY7bmWEqhkGaAb9IessEhZ+d+36AyM0HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m64IgGDa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B3TPJ483; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z3HA018923;
	Mon, 14 Jul 2025 14:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KXHQCR01phCyPtTR0M
	rC5Un0owPqwUD7AdKpPMYz6ag=; b=m64IgGDaESzz0E/PZQPJvEajWPfi7K40Sk
	NxaZkclKyfGfIggG0pPeiOVQpsVxDJVFY5uLKgVp8FBKSxu9BIsFZxS6VoYLq4pA
	GqwMormbwFMXZeJGza63zdM85Q6RkckereplE2+WGq6Mxazwa8RexHQkqzIjP4E8
	WeMKBtTUA5q+q0xZGwAMNNusKm+uZKNLLE1i90pILw1g04BbT9Uno4Dr5CzQMkL6
	P2pJdnomCVkg8icpi5yD0AhOCdOxClwrezAzrh32gKGWO96Aji3y59Il5BfCT89J
	e1A4WJm8ZCT+CUHGUEJjIzE0xXZx6bMuy305sFjKxhjuN34FxZvQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1avcm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:56:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EEEMfI011665;
	Mon, 14 Jul 2025 14:56:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58mh8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuub86Ds9n00B8Lqt2rKAh/Q2aopffNjD/cYfrqY/AZ6RvInwaHBdTxx7dloZlbvL3NoSnPUQy4TYpfS57O/AoJX/vYgi0pgi2qujVZknWm2xqsuzuScC9qT4q088asg1sNUzF6mnzYpBqPRJuHYNmlnsRYd+aw1dD//xDhpP9CGkzjutDjUGV+QvIinoUXsPrM0XcePWpAT0kB+it5KM5ShNAamw4fWgGJ3KSrtNu3DArdPtEoUdwKJ8Js4N4LvEyPi82/F5YQhcnBTJd1tJ/BHpOFSsCTMYXZwS4Zx+Mc87Yvv3S3ZC33mCvGujH0AdOEHkKYVEwwIeiWM/uE0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXHQCR01phCyPtTR0MrC5Un0owPqwUD7AdKpPMYz6ag=;
 b=DeBtQGNTCwr7rsFrBe+lEvOgXhMuqkP85zLCNdN45qhONvVZ6itgiPj2A/hSZLBNV+b3nBfCFNIyVsQ5sR+JeoY6lDXgzcvhDgcrdHNd5xpvEbRjFEBKVr7YMdZnAve/EWrOkJNqZne5Ujn0bryQC+tsyX7MqtePDBrHh3+VZt2KqgiEk7SVfAA5Hxg7YKblGOtgJzzpq3VQuKgTlvhMUJ3cYYRHB2V1vajgCVMWKvA122H2cjCkQx/W2yG+EIyxvcXLb0VVaYQCHLGK7+N1vXygSrt4o6h7PK+5sXo0LO4i9TXGHNZg/NdFEBYFtPelzzP/SoaM95Jxy0YwoHEbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXHQCR01phCyPtTR0MrC5Un0owPqwUD7AdKpPMYz6ag=;
 b=B3TPJ483YCnLlYfaUGgGJOrYowXcX/sdXnrNdi4UQxN6qbSgQKWtpRtQEhL89+Qd6ZbbAZpcFtxelxQKtMxTue27vJYxa7fZ6+QATGhqXUEh/1gl6gWFcSOjqEdzmDN68nNpeFDyjNDiFyKLLWGVA5gfHY7pem/bkZ89y7wXuPU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7575.namprd10.prod.outlook.com (2603:10b6:610:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 14:56:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 14:56:26 +0000
Date: Mon, 14 Jul 2025 15:56:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
Message-ID: <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
 <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
X-ClientProxiedBy: LO4P265CA0312.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b38fcdd-729a-4fb8-044d-08ddc2e69bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uUUgoWRiiKa+g38xk1CIoYw4H4sWd+ZIOLAjOWRm9BjUeThW6W5KImyE839h?=
 =?us-ascii?Q?1TTC0kuwnSGEGYdZznCM2Z+GT+/NPIt2Ei6ZxeWeY3rvEDjIvSkjmmwp9M2Q?=
 =?us-ascii?Q?DD4j4ZXUHj51ZzSAPbQHPUDeQIKjdmfo/CZRJOqLJDdB47n+dk2fViwcFEW+?=
 =?us-ascii?Q?zlpdn2eUKj/+D+ELa4KKxiiDynGzL0HlAKpZL3Alr4XjEO47HEmUkGrLX0My?=
 =?us-ascii?Q?b3l6fMcLybFf55BS9WzpNBt7Bo/L+y1XFgaKby/XC93Kpe3ypdGbdPFdAiN8?=
 =?us-ascii?Q?8+7+eA8xlkAQJBe1Je/TSDLBlCsKN4/vvWT2Z5aaEKuttqLVEXs1ukCAZRUT?=
 =?us-ascii?Q?fBUnrzxwAkkUYG91ftveAVRpJPyskzvXY8SAAsbO/jtqLigO92APLDJMaGep?=
 =?us-ascii?Q?Ko0vCo6b/X9lEuh/5o/rmDHHPGws/pWLJEKFXf0vnTVtglzPyFY17yMdcwLS?=
 =?us-ascii?Q?a9Iuy8VNqU9MQ+CBnwBvzOvvzoUaJSHKw5Ev0o1yx8CnuRttJlvlc33bRk0X?=
 =?us-ascii?Q?LDVxweKrOEJV94wben2GuQ4rzd8kOx865VzPP5z1wCkdjFzUho9WXRhYRC+G?=
 =?us-ascii?Q?V4bDNt0gjVa9CKytwRF2kB8+5WVJNgCAbRlSnE+aQrjzqHeF3dv8EnkvtR2P?=
 =?us-ascii?Q?BfvZOyjnt+7LPKGU40z4WvnWyCuhfm5tGtULWtLShxtjgV6SqNaYNIXnXQ/z?=
 =?us-ascii?Q?uOlNtFKndtGubMq/dWLMBbgUPsJ4FlKzHZon453NCdenlW/hg9Sgv9RB2NUw?=
 =?us-ascii?Q?BjxW6rDGNbNWlUJSHFypfatvA0m5F2j4vzgB2rgzmWVqS0mbwG1E4qoUL4Ee?=
 =?us-ascii?Q?S7ItLG9YRdrl7xqsoWPay3aV+6qeysyjunsZNcLO0/WLPleyIvHcpsg0TUjn?=
 =?us-ascii?Q?oNGcp0CqHuJVhuFkaoh1MYJSLCS1+h37OkH94R3GgUCnu5GNf2nsric1ajkq?=
 =?us-ascii?Q?Tm9xGPlcFKavv8W+R1Hhu9UfAMMPvO+fa0UmEFCyMYrGmAYTTqiD7GqKEkOm?=
 =?us-ascii?Q?qtCAN0as346Q8frtdBxUIGQaMzumEKQ0wTPIEaAjl7Zno9N97iANOGmRfqAN?=
 =?us-ascii?Q?xljzf74+ilJTrJltgnWjtTxjI3hGE+TZPsWOjm7TdYj+jtpvV2WTkYCq3Ipf?=
 =?us-ascii?Q?cme613hij0ksABtkavxuZYshhm/+ph8Jr9TxSrzbiokO24Ov7qJ94cBtY2qe?=
 =?us-ascii?Q?eT7K6k1yv4/ZcKXO6O5Q7FYiabdkEyEJv5lr1omTIR47Crhhbc3mW10EKoSi?=
 =?us-ascii?Q?69PEptZF9I5mcsIdmdcjpr3mAyuIWZ1f3cvKwazZSCBcsSzwasneJBdu9FxY?=
 =?us-ascii?Q?GCJlNtbUCq1Yb8ux07Gyx7lKV4d8Gk3MNXGCJxTLSGHcjEAlOZbInjEiiTrE?=
 =?us-ascii?Q?CDUfdhcnxKjPnQRLrfJSEeIOcLQQzaGkWN7jD8sk3zaEjOI9a0VnXtJpNAGu?=
 =?us-ascii?Q?76MIjB3G1Ds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f3Y6djqLAudXhESELbIBv3PZBnWb+FNbkmjssrfe0iKMawuPpyXKQF2nycY8?=
 =?us-ascii?Q?wbikKb9pSFQzzvj+VsRYTtQgoBTK6s1SUTkxxdN0Th5jQYRNoIS8gcyYERtM?=
 =?us-ascii?Q?wkp3hcXskBylAHsO8jLzG3WwAClDDaFTBqi+dADsPR2oN5bu28XIOSlR2px1?=
 =?us-ascii?Q?DBNi8ZZbFu3eZ7FvBU9jaH/vpykbDlISXlrB10Q8UoIdQcIyh0DnmnV3BHDw?=
 =?us-ascii?Q?Up9gGV7Gm6ZsJC68kcoZb+mU6a3WnuPIbOU7wuLZq+rBjh1VtWTrCEWF2oan?=
 =?us-ascii?Q?a8GYpgU/oqtwip7/dhKTYl9x3CrHHLd86+0ZCPtQ7rT5jpV35Dk7gaMG6tFI?=
 =?us-ascii?Q?Qq5n3huoTaq63HcnYUcdV7JpSbOuEt+ujdRfX9JcAyqx1P8x8mHL6Dof0EOT?=
 =?us-ascii?Q?yPzsV5z69QU/ZyK9ZVcXzI+P9kI/ZBayE0cXD8prOW272gU3U75tgcbS4gWZ?=
 =?us-ascii?Q?TGmGlCJwYP+AqitKJOyKFmfS9oLbwsaOYXWBvZGcHcwzHHl7TJ3LPCdC2rC/?=
 =?us-ascii?Q?AkMYkkUynox1M92SL8TLIoA2TsiPTyzkQaoVVfH0IIXPM5W02BNF9da+oh9w?=
 =?us-ascii?Q?/LYix7WcGM7ahd006VMzdvCCIRoL1Ezpcexw7rD/P3WpVQHzxAhYW3KGLif8?=
 =?us-ascii?Q?UfTVT9rBtwF2DrcJnQ8TO+RyaEMcP0J/tTtKaZrVhc1inIHqImoG3yD40dtA?=
 =?us-ascii?Q?w16iUtbv8QVb83jgsMeO1MIZSkU036XiO1C0NO5skhfQVku249qGGg7DQaBG?=
 =?us-ascii?Q?0EbtGMPBGcrW/KnNdjFkm9HIEj26IgiUstTR6ixJ0Rvvl+99sPcIB6q/h6Zg?=
 =?us-ascii?Q?n7msDJqlii7puzoE0gObv4if7nIas9OxGdMfGvlmybf9Yc5NEU1c/liigMWy?=
 =?us-ascii?Q?5d5zuq2xhIFP3rvdyp+o68EimwWR9VONkC2wmQCha+40pHnjgo0RIxnHOUa4?=
 =?us-ascii?Q?54ZrL/f8hFvdCSMu25gw+ZO5cBCwY4FzrY/G+P4rcE5OfcQxuaCLL6Zs6dyj?=
 =?us-ascii?Q?zphGDj12BxYfx2gj2Su+YN5G+fdni8SWu4SWJT902gj4HFmg9YRo8cT8y0UK?=
 =?us-ascii?Q?ALEmXWW91chzTZZnmy/5T7QC+JJE/XhyU0eOIgtkUsaKeXRHAwSdJc77+Yg9?=
 =?us-ascii?Q?KYqT4BhLrspwyj8MsujeJkkcEbArmSqa/V5oPsP5/qxajno6OQzOf2UIfzFQ?=
 =?us-ascii?Q?Ow9WrfBKQcuKlpE9EozShAIyPC/lClNxVwcZqjRb1k5NjVcEAT3O/68ICc+o?=
 =?us-ascii?Q?08VUPJvLiHTgnoLQcDQon18NlPXWJm9o4RC7DJ024zcnF2433BqFNUn/nLb8?=
 =?us-ascii?Q?3jdBueqMfTHSdRTeq+lyXk4fY/4i1N6wZ8RGpvo5jh9FTGQx21UqTX9wTEyL?=
 =?us-ascii?Q?Bto9chAX0luKsaPDdtUFQV8BNnkNxwsWYrwP3CFDEM7VXe4Ajgywt1EnsmLb?=
 =?us-ascii?Q?QrznH04GGEcSKAexiWVfdfB1btLgGmPU3bdHXF2IEcHn9K4hqZ72emxVGMn/?=
 =?us-ascii?Q?SESLeGAjnImpW++3RBJ+68/qGXs+EGW5sUfw7cMMZNkfD2ym4l55dzJlHJO9?=
 =?us-ascii?Q?Mtq9AFel2zQUg4Y2AWxZ7QZzTxMiZ6rE0P/7SscFUn1BaY3NSGffJKMvwJEd?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kIDyFIlHZGB7FqtvuSyD24tPmRdju6TbZ8fwcQJE7CYFfGiyLt1g4oe9isq3BK8RwKbiqWr4x+pl5eSc24k4UOJbkNRT0VPJx1zNPmilV6zfH8VXSLFOD7uoiM8EjKe5U31Ia8s1ucZqyvxux8n/IpdZsffCUKsbvWBaxECvVoY9tTEhoqk5WzhDT+2AdaKeQgfCVj1Nf0JFdcmVlPCy2NVYnBjjJS9m4eE7eVTXac/h1iRlvPFlMHf87GFyQhKqNzmiPDb4hFXgJkwhVmyLVVFvmEcb0+053E91iFN+JDcPDQ4S59hLxwDhVhQchY4/HQZyEvM7gnwHgJ0Q7MnebcI/PEnQMnPetGSFBdFznbc7By2XWKpSUUL6/ovOx2ZpCFoXAq+0YPWhesM0RfdK2pSNgz2UXwvp8QNx2GHFwGaXKnwJ/2S48892g7suNKbaJGCi/rLqY6R2bJ9GSbRqCtRa7g8CXPzh66ZyeWjRrITZVsEmVbAB0yj9DVsYVrNBApYgneDYD9/2ykyJL2UIid2e2PVYWBLRNA0JmEx4YG9a2FEVCSwL6LiAab05BCR1HTV5kTIjCTl6b5CQfMyV3+vg7Px00rLQZRly/PXJn+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b38fcdd-729a-4fb8-044d-08ddc2e69bad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:56:26.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1zA7+eACFAIKym+m+hccjkW+yNnqjAcBBOkfWSJCxr6raz2YOH0bTj2zGb+DTwnIlP6vz5gjzV/3SHJqkw49CcFT01sjemhppDRgimrKGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4OCBTYWx0ZWRfX+lEPYmfSni5K t815QAZfKMCR55ebME4/78wBj3SsxnPA2uiVhi1cWJNqkW1bWtLuaQeMt5usLIVc6QJatpJ6JRB v8KzSlr9gYVmDJHGrCRnzWw20F4t6QEZYuqFbRjl9sJAfVNTg9+rZDBC4/2DQi08/GGX1a6NKK6
 MrPcSNiVX9BgxPpfuPVJkE1xnVBefWm92epNDoL/syGgt2wjFRyFGn50FPTMRr2iCopgesKg0Wv fBKXw7Gs9+dCy3uHqlEwP7xWFBuT35LJ1NJR3JaLtaaXOMVqC2T36vT/cIceirQBUIrn+pXim+Y UF/4FjA+LXwhpT7ONTsvlaTShSeTMlC7LPOw/L4vkP5WNlOPe6r6g2u7YUJWpAqbGzrZQ1R/fvp
 xhAtNOQraiRIH77OUyO+NFRcdoRvKLiDGluHVJc6UU+5IGhIO4AK5npMIoEUgBkfQ7u9cgg6
X-Proofpoint-GUID: petnFQRkbEsItImaSzrFOpiQUXew6Zuq
X-Proofpoint-ORIG-GUID: petnFQRkbEsItImaSzrFOpiQUXew6Zuq
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68751a9e b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pmaEux0szGPc1yli6m0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062

On Mon, Jul 14, 2025 at 04:37:30PM +0200, David Hildenbrand wrote:
> On 14.07.25 15:00, Lorenzo Stoakes wrote:
> > The madvise() logic is inexplicably performed in mm/mseal.c - this ought to
> > be located in mm/madvise.c.
> >
> > Additionally can_modify_vma_madv() is inconsistently named and, in
> > combination with is_ro_anon(), is very confusing logic.
> >
> > Put a static function in mm/madvise.c instead - can_madvise_modify() - that
> > spells out exactly what's happening. Also explicitly check for an anon VMA.
> >
> > Additionally add commentary to explain what's going on.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   mm/madvise.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >   mm/mseal.c   | 49 -----------------------------------------
> >   mm/vma.h     |  7 ------
> >   3 files changed, 61 insertions(+), 57 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 9de9b7c797c6..75757ba418a8 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -19,6 +19,7 @@
> >   #include <linux/sched.h>
> >   #include <linux/sched/mm.h>
> >   #include <linux/mm_inline.h>
> > +#include <linux/mmu_context.h>
> >   #include <linux/string.h>
> >   #include <linux/uio.h>
> >   #include <linux/ksm.h>
> > @@ -1256,6 +1257,65 @@ static long madvise_guard_remove(struct madvise_behavior *madv_behavior)
> >   			       &guard_remove_walk_ops, NULL);
> >   }
> >
> > +#ifdef CONFIG_64BIT
>
> It's consistent with mm/Makefile etc. but having a simple
>
> config MSEAL
> 	def_bool y if 64BIT
>
> or sth like that would surely clean that up further.

Well, I plan to make this not a thing soon so I'd rather not.

The intent is to make _all_ VMA flags work on 32-bit kernels. I have done some
preparatory work and next cycle intend to do more on this.

So I'd rather avoid any config changes on this until I've given this a shot.

>
> > +/* Does the madvise operation result in discarding of mapped data? */
> > +static bool is_discard(int behavior)
> > +{
> > +	switch (behavior) {
> > +	case MADV_FREE:
> > +	case MADV_DONTNEED:
> > +	case MADV_DONTNEED_LOCKED:
> > +	case MADV_REMOVE:
> > +	case MADV_DONTFORK:
> > +	case MADV_WIPEONFORK:
> > +	case MADV_GUARD_INSTALL:
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * We are restricted from madvise()'ing mseal()'d VMAs only in very particular
> > + * circumstances - discarding of data from read-only anonymous SEALED mappings.
> > + *
> > + * This is because users cannot trivally discard data from these VMAs, and may
>
> s/trivally/trivially/

Ack thanks - Andrew can you fixup? Can send a fix-patch otherwise.

>
> > + * only do so via an appropriate madvise() call.
> > + */
> > +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> > +{
> > +	struct vm_area_struct *vma = madv_behavior->vma;
> > +
> > +	/* If the operation won't discard, we're good. */
> > +	if (!is_discard(madv_behavior->behavior))
> > +		return true;
>
>
> Conceptually, I would do this first and then handle all the discard cases /
> exceptions.

Hm I'm confused :P we do do this first? I think the idea with this is we can
very cheaply ignore any MADV_ that isn't applicable.

Did you mean to put this comment under line below?

I mean it's not exactly a perf hotspot so don't mind moving them around.

>
> > +
> > +	/* If the VMA isn't sealed we're also good. */
> > +	if (can_modify_vma(vma))
> > +		return true;
> > +> +	/* File-backed mappings don't lose data on discard. */
> > +	if (!vma_is_anonymous(vma))
> > +		return true;
> > +
> > +	/*
> > +	 * If the VMA is writable and the architecture permits write access,
> > +	 * then discarding is fine.
> > +	 */
> > +	if ((vma->vm_flags & VM_WRITE) &&
> > +	    arch_vma_access_permitted(vma, /* write= */ true,
> > +			/* execute= */ false, /* foreign= */ false))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +#else
> > +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> > +{
> > +	return true;
> > +}
> > +#endif
> > +
> >   /*
>
> LGTM

Cheers!

>
> --
> Cheers,
>
> David / dhildenb
>

