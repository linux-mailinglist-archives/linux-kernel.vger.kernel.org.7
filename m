Return-Path: <linux-kernel+bounces-874543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA87C168AF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303C91B275F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9934DB67;
	Tue, 28 Oct 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n87PCZUy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b3mSEZ4Q"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D434AAE3
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677542; cv=fail; b=iiZtoc/qImUvxR/KbHXTbDEOwrDqcUWJgGAU71cC90MuqoLw61l1inlU5PnTrH0ZLOiyD5vmMx8wuYmnNc6y9/RZJBk9J3vQLu5Yt+K/oi7Ycimepm/M/NA0iuDLjEOLMlD1BRViJH79Fkca1wRiRLYt6Hfub7uZMmu0r0jnTbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677542; c=relaxed/simple;
	bh=JT+/oOYpyq8SsRzuiae4g3fCj1jJqCHWAEtqeGZCOII=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=iu3cfrk1Nip9BT5KTbTvWQ6AUzeg1hVYvQheMCN8JHoJ2i8D/uva2KkqCihu+e5oGXefucC84CHJ1jOz999eljuFeeNykCHifPIiw7zMsWUpvGNhA0WDxsMbpfQoWMoadtlrEk2Yj9OsMyxD82ha+SLy0ZRJgb+dSkKmE8wf0oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n87PCZUy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b3mSEZ4Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SHK1EK021838;
	Tue, 28 Oct 2025 18:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JT+/oOYpyq8SsRzuia
	e4g3fCj1jJqCHWAEtqeGZCOII=; b=n87PCZUyikcY9yXF048xM5HwNNttfgaHpm
	Wzqblw22vkmEz8JMt51oBLRXmwaASu6YgSrk3CQ+6adsQiT/SGJaqeWXpPkpPQHy
	eZnpKushbXxNOU/+CTpxevUNsS3jYqnAzM93CGqzsW1mL59iSHbvXUqogAAcxDLY
	wGInLReP4j1OBTjf8Wy9RGqdwraiqLPv6BI/UheiSE5hwH1n5ruDWxr3fDnf2hKu
	aaV6kP3ZEXemGxbc1J5ZE2eC1tXRlQSVTgWodnNdqJZTRKMiwaE1P+0UynZ6/LEj
	LgXWEn8E2hXnKMyzsvVqoUIqoALmSIH9jfp/U6AMMbtW8U3Wc0ig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a23gvmbx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:51:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SIIQIh037422;
	Tue, 28 Oct 2025 18:51:48 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08mc1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayBe4DfGpXUWIIRfo+q2OsG5of3evlrxxz8cXOOvEvB6DFHC3f97ZsZ7IAhzHoT5GaNEhik+IHxxiLM501UHVFiMTnctQpHx2rTxK7KEraFkdPVxxXwCpQ3/MV21P0d4mnq2W2d2YJNHHzRx21rRySQhEaKmY8cMRUIGYnn42onFQPXnK/AsxKVSdWOcJp8hQpovAYGI16JjDDYT0Xe0p8+t+x/4hska8pYDQFboIUbIhxBShSPzkOVT72lgLIbT7IgufZZSlncSl1NmDpxb7MH2+4QamjQPK9I1Q+vTItthiB0EMYO0qGbNuJeaaKDNtasRqVAx4AeT4lWV20y5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT+/oOYpyq8SsRzuiae4g3fCj1jJqCHWAEtqeGZCOII=;
 b=lqBC3Awo9fvBr4MMdYpBR0QKR5NRB1FMusxHglgnBiEL1VHSWUkJasg4FneG7L7eV6x14Dc2eWQHLIJM60Uxw2iY9hIeffJvlBMFvNgHZ1yKsVmlKqjBNSPxgvej+2OjbtxQ2xKpf0ZZFZfmCnZGVQdFxomRDEUdbJGd2Mu7NPjo4cZ7bdjuRXYUk5wVxrgJTDC4rttq3rrp9gBeniM1quR15I1PZShq08d+DpoVGbywtzAQ/nPVHwpORrPW+lNQpMeo3deb1hFF96d+73SEv2MuJmQ6xyyx3E0qXlegVHIeoIMUH3R8lxOMQPRO99M1fpMwR3GdT3mFGBX+zK0SYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT+/oOYpyq8SsRzuiae4g3fCj1jJqCHWAEtqeGZCOII=;
 b=b3mSEZ4QazrhCiBy50qp/ALmj8Zaoa4Jnr8U8Sq3AErfYwBHzIXihc4jkI6lzF4HSFa67w9b6wksNUSQRugOWphP9wPPQLsz2Hvg2n9sEO+u4CWO4cHiXSyl2bLdhbzmwnLtgRUU+x4E9t6QZsXVHqHLavktBCC0mNXIgjlW2jg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB5940.namprd10.prod.outlook.com (2603:10b6:930:2b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 18:51:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 18:51:40 +0000
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027202109.678022-6-ankur.a.arora@oracle.com>
 <20251028135640.GBaQDLmHzCQDegBHd6@fat_crate.local>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        david@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 5/7] x86/clear_page: Introduce clear_pages()
In-reply-to: <20251028135640.GBaQDLmHzCQDegBHd6@fat_crate.local>
Date: Tue, 28 Oct 2025 11:51:39 -0700
Message-ID: <874iriq2pw.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0cb080-2415-4f1a-11a3-08de165307e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kqy4xmvNJaini4ih9VMrQUSliL3LIITMqyibTJ/pbJV+DJafKKPlhHSorcl6?=
 =?us-ascii?Q?rAk2K/cj/YHgYO2vCcdvmIrDSpDTE+6UCpM/gRA1AUIIoWwFqpiYPaGv94gp?=
 =?us-ascii?Q?y/raQ44QZBD7iuiyCkt6UoYKQvuZdiFf+Y3lAwBQVbhJHonHuUGF5L7jfWm9?=
 =?us-ascii?Q?ttwTd8V6ID8I/2SIWkBNJzXN2Ck8IUZnJ/bB0poiAkY/vDsr/xEFcPVh9JJt?=
 =?us-ascii?Q?bYnB9T2Tf5CpeNVffks3RXQEfqttKdvhrHufIJWNqmp8xZXraLlGaPd1N5gX?=
 =?us-ascii?Q?AEodAtYMJeWfHcsHKVZaR6dklwsDGBobI0ZWhUmsekEl4gXGRPhhLZEPua73?=
 =?us-ascii?Q?dGP70sTd1NxdyAWCb1B7Q8Lb4Spr215PDmkkFjO73LnSJHx78GiDQ4NX2cL4?=
 =?us-ascii?Q?wadnh0uW9rO+zDbrjofojga/rJj//kXjaA2/ySB9X6H6PHTzxq7qGiTUHbVd?=
 =?us-ascii?Q?kGWtHSV2VyD6gob8Y26JSI45cbTsiYQH8e6y/V6V1XQ8qTgC2iSUMNLbnTqj?=
 =?us-ascii?Q?We/7LtybVw7tDEcjl0dbprb+BWfAes7TD1lg9d6uwEiivQ9oHkEeSSHDL9e1?=
 =?us-ascii?Q?F0n+jvHRBjA23nI2j+VFh8cS7Pa5AmJReGY7BFHjtndUTbNnLgEpS68+48bO?=
 =?us-ascii?Q?L+8HFYifQ//e6idHTT0/XqSTTUJw9yBUMq7Sy67lLl/oimti1rTVzfkS6X4B?=
 =?us-ascii?Q?aUNeQ4CncF3/OlLxUBwwHZCtBf8/VR7CpiDLJTP3cyQee6/kSToX64ABNV6r?=
 =?us-ascii?Q?kSiRg2Qlvqm88tJ2C9IseJiQEDe87REX5VDWEs2fQJ0Rtvz6lHCkzRa+KpyM?=
 =?us-ascii?Q?CJfZsxo4xTITVlxXf016Xd1x6qgpd9cmdNmNf3gcgf2aSHM2+SS77CXRUbaV?=
 =?us-ascii?Q?CRvKvOiGy5iUaFcPTQet8944atqX3MfGAr+xECxXGiD0LbTZDjqeWRbK37qm?=
 =?us-ascii?Q?VwgCle79aOV4FRJcw2+mHX7zbV5/Wf+J2McTjMzD45b7aSvI1G7ZICB5gKVQ?=
 =?us-ascii?Q?c1mHOqU4UYXFVaOwmk/QUWyuwb5sM2z2J3nxizoG//6ViMSZNy94C2XDorHe?=
 =?us-ascii?Q?AM6Ug+sy5E8AnzdeSBHYY20yJ/FsXUvkPd9TxxvSNcp+muwJrl/RbXJuYxpb?=
 =?us-ascii?Q?0RGTYxRPNV3T9ilm64iFe9LMHxyOIvyuhyzWWl1fF4bUr4JP/8pAfuuVYaFl?=
 =?us-ascii?Q?YqicsArL9IXEmLIY1ZcXm+DM+1IbRNthvDcA5uIGprHv5UZ0qGgOF0/RNZ6h?=
 =?us-ascii?Q?tQ1X4F5S6sKj/uHrlvXSZyVx8zp+rAT3w+hIaSGnT3XYBD5gY1d9XwFdpn8H?=
 =?us-ascii?Q?13CShF8iJzBuVHmCYnOmF5PQfM3+ydPKQYq3se7bmssT8k+V+2PpcFw3Xa9F?=
 =?us-ascii?Q?y3Z1FC6Y163CpokF/SGbfdWuHqx3F+qJbHoF79K5hGn1o6cuA92AbeYEJQY8?=
 =?us-ascii?Q?tko9fWNtwvZQ2Mk5FNLfIxIkKUPymXQu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jmO1mg7c8RLzuvYL/2YAWOllnHFyuI9BhqkM/BREgh22LjYDEn2BAggLWmQP?=
 =?us-ascii?Q?ZKP4Kx8wxrdCkePf/BVqO3wh/beKnDP2K5knt8PNHGzPOTPtX3QDBNrSsPna?=
 =?us-ascii?Q?bSBwRQuyvUhSn9NTP+fVGrUa+/hf2uXWvyR6laj9Bd7DYkNMi1JZ8FsZvWZO?=
 =?us-ascii?Q?QibRQz+en2+J12vYxf9HsQWAd1i5ciVyeKegonu7ijd22LYeevDxm0OBaYrP?=
 =?us-ascii?Q?7qjDpB8qpM8cma72nQlGlty94LnQlcud4/JdljwiN43GiJlzVUN/bCPb9YiJ?=
 =?us-ascii?Q?PESarFNrFcZY9/e3vTDtmuLdyOObLE0OTAt4F3Rtup2FyQKKTKrSwUnTM2y7?=
 =?us-ascii?Q?C0nkgtbQjC/yDZZkZ4CDKicNMpWl6TNKF59DulIkaBz1oD4X1VhQTnJ1llld?=
 =?us-ascii?Q?uqexvf55npBhVqamaXl3mwgB+2jmmZRqL9Br/DoYp+B4ipXU170WR9U4QZV0?=
 =?us-ascii?Q?Z7+Fv2wfs9+5ak6wmfAV7cIpmUz91xbOE4sYITHalUko53W9uo+mmUnyEmbb?=
 =?us-ascii?Q?zT9BOfrzO4Zk9YypAC9TLQ+QgVaeIv4SciWixyhUv+hs3q0NPBFnIEp464dF?=
 =?us-ascii?Q?fbxhijTKmfdCdVdxLI9jA9CPqVYZf8csdH3e2Mm0VtD5vdrGBBVcWqhVeuuY?=
 =?us-ascii?Q?0Wg9kpvxEBygkj5ugxulz4/MNfqFwS6IfyMdfjHaosmXs1IMukZ9g8KmWrte?=
 =?us-ascii?Q?/xv5h85CqYznw8nkFSqFMlblSedDkTiLRiTYhIclRkMZ9/bQGVMHPQN0nW3L?=
 =?us-ascii?Q?KQo+hrXWaMr1oG6Wu6WAi8xL3KvHvIFh34m8kKQjPpKHG7ILwzMA7o2yuMj9?=
 =?us-ascii?Q?Ikn0oEQ/Uskyl0VAU42rfJ92U/2QPFUYRhcE3Rh4RwXsVAXaqIz9lqPM4UuQ?=
 =?us-ascii?Q?vYr5jOI7c1i8g3ca0JnDAu/cUYDqNTJCjdtPsAzTOdT6qCdLI0nYwvDGcTpy?=
 =?us-ascii?Q?DEXJjxUL08jVH1b30Qh69PdXCeCABJyJT3MjWAysQbEcte9eU7s41Qq9QuNW?=
 =?us-ascii?Q?uZg6R0QpawM9ivbREdVI0ymvBfLp2jOigx3cTVtP/VSlPh21NWuaSGB9WrPa?=
 =?us-ascii?Q?xDBEaWXRVs4YblyzTFQjXfuC647aDeqNYPACS5xsXQwopK0PRqJdl/lzIZl6?=
 =?us-ascii?Q?kLhrN1IJMVPUhtbkR4gN7oKSaFcUnzcAEfiMyc0rdJeaQgPW3au4cbmxeHok?=
 =?us-ascii?Q?0vXS60KEG0OxCPNOJRFzULobrUDMuM1G7B3UW3mC7hOk1zFAJdJHQlCTDoNM?=
 =?us-ascii?Q?F7ups30lQxUCm7xfpjSWGyQZ1RVUe8OUddcBMuQRpA0RQ4N8R/p+bN40mUId?=
 =?us-ascii?Q?MFv1Wo/EYH6E2Kbo0mNTNOkZ7Swmv45zmvHtN3dlC9QLoreByb3Vx7M3Hm8S?=
 =?us-ascii?Q?FwiEOBKIIjKmKhiaGQ2TtazTAEccB7qNKf+t+wrupjFjz+UbGnqGgjW3MSdt?=
 =?us-ascii?Q?BECRP2QWIboXbVBSyPN5/uaIU2ZaOhux1MS4Ig0LE/htv3sHEXDLiiBvaXmR?=
 =?us-ascii?Q?ipjKZ/pxzUKpE1rVG0un8bvPSDs9dhSaUzJbQ55AmWErOBfLLnQeyuAIDxXG?=
 =?us-ascii?Q?/8mSg1PudShQoFeGSyjhm8jf5YByP0ZYVNyVsmP75AoD0+Qiz22tFLv9DCh8?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fY5B23n/opXSfO2NGFmnb4im3OQF8d36HW3DcyAh+hZPukRtg9X09A3ZvfKHuevl1P1QY9tRxWom667MeU2ZVo/T7FxqTBOL0c21yvowDwPbwizw/qTpirtMi2oLAjUg9cz8bPirmgFTdK4i8qARHeAnVlSC2FAnhN4v0NoLt1I6is2+O0hUrgi3nV19al2W5Uwwz6LJCkF2oWfNEPWqKjMhZstdxkPvuG9NDQoZhWvHxgpgoHsO/6WJ+yUN41DYbh5OjhOZIUunM+h7ye8sSpEbw6nFS8BkAd0zcNxvPKV3sxZwxoSR7+HO4QTIpaKMvOhEJ4CdJFTnH39D8HLxAyRGVNh1TqteMbbM4p+ELK6tJzFOJ8hAlR10l/DHy2dWStxDjRUdwmNv9wnL7ju30cjWjnmKkA0PPlbiQrsr3g8/7kt8gsPWPploFH1dp+AmaYvszAJ98/ZGDhQvaspjllNkhOFyDmc3zygSvBEWOK4Hhm0fbS7kOV/OMeQx7VkYtiogpp5CxT7GTGLKHLp+4elJFxuCkSgDUfZgXfUL1KKd4oQlc83rXCUTIcgPhGoJZ7/mSet9F8jXEONeLN2gnpjBla8FuOkZ3nkSNPfMswY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0cb080-2415-4f1a-11a3-08de165307e1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 18:51:40.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKJ9bRvo4onlXW2Vqq/cK9zk7rMJ3fZWPy5rJZdRf+6GVKd4FN7uTNipmXt8quuBzkAnT30TvmjLucFkDYT1rovaVtho51DQNDipskXQRt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280159
X-Proofpoint-GUID: JY-jpoAqnY1KJ-9fvs1rut1KiQdZoy8h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1OCBTYWx0ZWRfX4YXhpIjBDmIF
 O4Uyg0dvXgcRDD4ilUmq3byjLmhmpe3Qmm7ih7qEdDTKoBuIuFi6DrehDiRDT5ZRbRC+5d76GpX
 PJ8QBIfgecYpMffzBbkSCecAf2A/B0t0k7CVwGj7PC7FqrfVjwXbcdm8daiQSqekdgRBuGkDPa8
 x1mn5Cx61UZyZ/AwhWgxyOCfxjb95WNT2EOdf/5GuVCtvGHKRLAJnVw+WjyPa1biMmtNL5WfE31
 0K7GS7FHVdMCgPqTlS33JztkQrRS4DNeG5dWxDMXCqXmXUiDG+lJusbpfaV/3Wkccdys8RH+mhC
 PKDQlkvmcoMSV94NCHmytoR8qpOfWb5MfEV9IQoCo24Gcn0LA1NBLaSovhwDt9FfapV8/lQ6Jgb
 +l7k9F2eIeTsrLM7fBcwEXad1TzQ7A==
X-Authority-Analysis: v=2.4 cv=HsN72kTS c=1 sm=1 tr=0 ts=690110c5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=N5MSUnm-BLtD-S_oZroA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: JY-jpoAqnY1KJ-9fvs1rut1KiQdZoy8h


Borislav Petkov <bp@alien8.de> writes:

> On Mon, Oct 27, 2025 at 01:21:07PM -0700, Ankur Arora wrote:
>> Also define ARCH_PAGE_CONTIG_NR to specify the maximum contiguous page
>> range that can be zeroed when running under cooperative preemption
>> models. This limits the worst case preemption latency.
>
> Please do not explain what the patch does in the commit message - that should
> be clear from the diff itself. Rather, concentrate on why this patch exists.

Ack.

>> +/*
>> + * When running under cooperatively scheduled preemption models limit the
>> + * maximum contiguous extent that can be cleared to pages worth 8MB.
>
> Why?

Will mention that the point is to minimize worst case preemption latency.

>> + *
>> + * With a clearing BW of ~10GBps, this should result in worst case scheduling
>
> This sounds like you have this bandwidth (please write it out - we have more
> than enough silly abbreviations) on *everything* x86 the kernel runs on. Which
> simply ain't true.
>
>> + * latency of ~1ms.
>> + */
>> +#define ARCH_PAGE_CONTIG_NR (8 << (20 - PAGE_SHIFT))
>
> And so this looks like some magic number which makes sense only on some
> uarches but most likely it doesn't on others.

The intent was to use a large enough value that enables uarchs which do
'REP; STOS' optimizations, but not too large so we end up with high
preemption latency.

> Why isn't this thing determined dynamically during boot or so, instead of
> hardcoding it this way and then having to change it again later when bandwidth
> increases?

I thought of doing that but given that the precise value doesn't matter
very much (and there's enough slack in it in either direction) it seemed
unnecessary to do at this point.

Also, I'm not sure that a boot determined value would really help given
that the 'REP; STOS' bandwidth could be high or low based on how
saturated the bus is.

Clearly some of this detail should have been in my commit message.

Let me add it there.

Thanks

--
ankur

