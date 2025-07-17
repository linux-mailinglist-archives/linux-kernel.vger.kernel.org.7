Return-Path: <linux-kernel+bounces-735761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 250A4B0937D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204DF1C48136
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5B42FF461;
	Thu, 17 Jul 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kd0E32Qi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tNjumEGI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C932FEE34
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752774009; cv=fail; b=P9cjUynkvq7MW2x29PFlrkgBYINdzd+C01NxGLJn2aYEYHamMPU3YOh/XZC+2CdbJEa04cDSj9ksmDCwhpitF3dV9dl7mmbzU77OFZNOZs5CHF5URXp1HDN5ZIYXjJGMgRXksIRLsC55M9xI2ogXJAT8HMe+2KTZDLC3SVJrn+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752774009; c=relaxed/simple;
	bh=u+uj67WPrTzz/TF35xM43sOHnRGAduL4YTAANCU+Gvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iu8uAIlM+a/btAMVR1EkxlGOdiU0MKvLJbYnr/x+amreIw6iQpnXYC79mE4atKjg9JIWJgqH38BPQFyyfPPtA4IaKD9I32EOaS5JvxD+VAznGGRTWmCAoM1+THyUzcIMzg5F8x2f5SsikS1e/vGE/qHoGd0r1qRGbD5v1NdpSAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kd0E32Qi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tNjumEGI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0ivM018938;
	Thu, 17 Jul 2025 17:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=p3kCRFgrzfghwAas2z6crjQATuiUc/eOKjS1DDx0AOY=; b=
	kd0E32QipX8CWBFi1RmapJY7phK9G7gUcLdUsumtsz7uWpM4pexwMfGG96rteS8I
	URn0xIyIHwRnvHJ0/SADCyZXfZe6/qnzCYaYXPe4Vttbrz94HOXCuEf3eF6Bca7C
	dTGONlwe+68zvlLPtDZ6kIumXB1ZQgeh31OV6bI2tU4YKG1vLMS4rJB23GYYcoPf
	tbrYhU2SNeHYxJSEBFzrYXwT8AGvTkI24rkcecH7UW92O0ZXFoFAoEgPbwLX+VQr
	EFjvgnf+JQ65rkZbab3iUN0c+qkUtXTfSmT6tGhgf8t0IgwbyDpPzxKfkaoX7XmF
	dbW7oOMMODUtyvwzcLye4w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx83vf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 17:39:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGoqCe029677;
	Thu, 17 Jul 2025 17:39:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d0608-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 17:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILyx6sKGkOJg3dtVNyxa2hgpJky8Jf+429SFy//iZ8PP4OiV9mw0SaBQhPNFRDf0qxguEQmNCxFTM+DjY2gXWW7sq61+GBsVH1J85ULlKvh5fPEa48g4nbQSLTxv8BMUKChTtH7m02oKWKWpB7xZz9IYXyT1XPF+jtSH3N4io+pXaJ0ALvgRDjcFejGwsQghLvEwO8DIMQ66edjCx/eelr+3v+41PTfvTyWYXkLIHp1fXPenNWISLhInur0FcPbYDLzhWlj1J2zi+mGYp/WtpknT7uWyihhPjz+dEKfVhTLrG2Rbwv5M5XnT53qNVkzPY5VbY6K2/n4dYoBY0AZkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3kCRFgrzfghwAas2z6crjQATuiUc/eOKjS1DDx0AOY=;
 b=jogS6luHOteIzuTsmZOchSyP0haDhZQ6qmiubcv4Mu1DavP+kHE+gbyALCo5EvjCGlExsDbZbGnczNtUQneffJixpKq8/Dk0wYT3hQ5zt6DI2LpI8N0RyHR/Ha9+d1TaEI9FDN2zQdlLTRmw+9brJ3OGoPEOR3LscOccU7ddoQrmPWPFXj8iaYg27xHQrgq+Tj81XoaK2gYeXem/Aenp7EohWsfnssjx0/ez0naSCghjWU/Jyk8elfYVdTYp4QbuKeVDZBnxaOP2KNtCBsKzc8jRwe5RBivhKEYScb4jncRJx8Em1uZMuirwDXnok98J2vI9n1WngVFijglhcavhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3kCRFgrzfghwAas2z6crjQATuiUc/eOKjS1DDx0AOY=;
 b=tNjumEGIcCWfKmaG5p61PrMVK3UPLdI8sTTTL6M2WBekVRx7bEXFlFDVF3EV5J7URHZndCEx0PO5UHrmvpjUFKrxPx32HroZJBcNZyENzUwC6qB+9Xw6uGaLO7WSbYznl7om90t/zJXxSl8tKwGTC/wwuNMCsLACtFyd149T/Ho=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6802.namprd10.prod.outlook.com (2603:10b6:930:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 17:39:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 17:39:45 +0000
Date: Thu, 17 Jul 2025 18:39:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Balbir Singh <balbirs@nvidia.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] __folio_split() clean up.
Message-ID: <9e862d09-9c83-40fc-b546-666f67bb493f@lucifer.local>
References: <20250714171823.3626213-1-ziy@nvidia.com>
 <1cb14f22-bb17-4997-bfb3-6f1d1f984d3c@lucifer.local>
 <8A30F788-2ED9-4F27-867B-BD97D23BB329@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8A30F788-2ED9-4F27-867B-BD97D23BB329@nvidia.com>
X-ClientProxiedBy: LO2P265CA0278.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 50eb3433-1ab7-421d-6272-08ddc558eb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHd2TTF3WWd5TGswdFVxdDlGekg0QlBsekd4eW5FRTlhdlJpTlVWNUpHZVpI?=
 =?utf-8?B?WU5TSUxZb2Z2N2xsSU9ZLzUwbjNSMkpLcVowR0gvcERjUnp1NzNTemVjdzZi?=
 =?utf-8?B?ZUFsa0VXd0tnd0xEU2JKUzRUZGhQTW1rV3BMUllDWCtKTVcvZmY0QUNkdGlL?=
 =?utf-8?B?ZGNpZk9qMkFyVm9RSHk2eEdNbm5Ed01CYTMxMXpZMEs3M2FUOHlmZmJTblFM?=
 =?utf-8?B?bVFFL1hDcnRvWVEzM3hYZ2pta3hOZ0o1cmZuY1BIT0tkMEdLL3BnWTQwbFdU?=
 =?utf-8?B?M1BOaDFyVmZhd3lYdXh1SS9ndDI5N3c5NlZURms0ZzlEa2gvUlZJWnJCeVVw?=
 =?utf-8?B?YmFjNzlNY09mbURaelpkU0EwQjI5Z3ZnaSsvMWk4UXRGZlVLSjFwTk82SVB6?=
 =?utf-8?B?RDdiUGhrQlpaRzVoeDRXT3pNTmtyVFVuYmptQmc4TEppS1ptYSsxb1l0ckor?=
 =?utf-8?B?eG5aV2FycWFKVlRIMnh3Nk80MzJoVFFvUmh5UkNwQVFUZDlVN2t5VGJDcVVS?=
 =?utf-8?B?VEdCVnJLNFdmYkw1L0xoNG84QmZUbVptblZQVjJTTGp2RTRwZ0QrTjNPeDVa?=
 =?utf-8?B?LzZjdk85NjVEL2NsU2FycTJ5T2VpVlR5SWg0RGxjdDl3Q1VDOFI1WE5LNlNB?=
 =?utf-8?B?WlVlZjI4K1NhRHVYbzZFdzBUd01vSWFOdDlzdFJ6SmdiL1VQejhDWFhRWmRt?=
 =?utf-8?B?TUJXV0pnZ3RpUlFhc1d5V3hUYWlPZ3NhbHpJTjI5WEJlMUF3QkRhUmFYbThQ?=
 =?utf-8?B?SkZZWnY0SnZJOUxYZTYyUG9IUzVEc0hmaCsrdlllY2MwRHZ4RXdpLzcxQXps?=
 =?utf-8?B?OGw2YU92Skd6c0Y1UnRrNVc1SVMxaWFUZE5uZVY5L2dlUmczVGVEYmQ5Vm9T?=
 =?utf-8?B?Nkg4RHJXVnJLd01iQmd0Wm9CcUpnUjJiUHZuejhIRGlEdjgrTkxrbVhsdndM?=
 =?utf-8?B?UzdtZlFzU2FnMXU2Vmg4RVFMTytwVUxxZHVGamNheUFwQzhENE42U0NJRjR4?=
 =?utf-8?B?Zncva1B6VWhEUzBuMlZUWmxRWEo1UU1xV1RmV0hhSnYvY205eDJJKyt0ZTZK?=
 =?utf-8?B?T2p1QzRQbWFSV1ZoRm9lR05WZlc4MU94OXd4V2dKRFRyNGZWL2h0OWR2OExM?=
 =?utf-8?B?TGFHdGtlbk9FQlZnTjlGZUpiUmxZUXVacCs2OE5UN09qNDMxb0M2WmVsUVhx?=
 =?utf-8?B?anViSHp0Qnd4OUZPcnMxc3hJZGVnWW1PdjZBYWFEVmNFZ0NXaE1xSUVab2xl?=
 =?utf-8?B?RHlHSDMrT2VKZlFIS3NtVm1rTkZIdkhDU3RMb010YndYRlVFbFNEakd3STNp?=
 =?utf-8?B?azhrc1VoSkw3NExFUU5QUUxYdXZBUnNDdW5GQTRLZDN6Mm1iWGVlMXhVdE1N?=
 =?utf-8?B?U3RGWDJMRTBwdUIrVjg1Yk85clB5dWJmMjB1eFE0SXRoNFFId2hwTXJkbEFr?=
 =?utf-8?B?YVpiS1ovZDR4MS9DU3k2blhDOXJucEJSYmxZdGlPWTl3TUZjTHJ1K1NWQXY2?=
 =?utf-8?B?bTYrS3dGQzJNZUp0T0w2TDRMcWI2emhsMXRvWjhFbzFXZ2pxYkxyaHlwYi9X?=
 =?utf-8?B?eWF4M0N0b0FQbVlsY1Uzbnc4a2JOZU85eUFyMUNrWFp4cVdLamREWUV3WUtO?=
 =?utf-8?B?WFlRRVN4RENPMVJsaW9saHVraWFDY3Rjd3dDbkU5ZkpRL1QwUkJCMWRyckRG?=
 =?utf-8?B?M0YzMHBCU1FVOE9VQXMxOUJLcGhsZ3hSWnVONVJrdzdOS3pBeEVaVHppeTl1?=
 =?utf-8?B?OFRDVjZJNC9GWHJMbmlvTmp2ZDJFRHBKN09uejQvbFpFY3d6Zk9ocGFOMVRz?=
 =?utf-8?B?TUF5N0xaV280WmYrOXVKQzVUVVJmNmtrc3F6Z1JLVDhTSnpmeWphOUxtam9i?=
 =?utf-8?B?djhIenVZRjZUY3RTMXY0dXkwNG1CeXpzTjFhS096b1BlNDFhZTB6VDVkcjJR?=
 =?utf-8?Q?mwXdpgdbtvk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVBHUFI4NWhDK3ZTNkR0NE8yS2l5RnNwcHVNd1d1c0YrZFdVdW9oR1hWT3Na?=
 =?utf-8?B?R0ZyR0NsN2JZL01idlQ4SFQ5d3B2SDVoZUVhZEZOVzVEcEFNcFNtUklBa29l?=
 =?utf-8?B?dDh0RWZFMzBCeExJangxU01yWDhkcDZOazhPMXI4ZllQWHVQSW5CNjFwYzFh?=
 =?utf-8?B?MDY1R1dKelBOYlF6QTdnSkpGb0ZPVmlMQXFjT1NTdFYxb1lGUzJidldGTnVN?=
 =?utf-8?B?bHErZWdGSnI1M2YxcWpZMUI3cUNuR3h5U0xhdXFING80VE8rSjN6b3BMMGlM?=
 =?utf-8?B?SWQzTFBGdEdQWURDUkx0a1JIT3hXWEk5YnhlRjd3VXUzdGxHSEZlTS9IK1ZZ?=
 =?utf-8?B?eHZSelduVlRHK2dTMERFZEUyc3VDNmsvTU1WWHFERW1EZ0pwU1VSTFVMNkZH?=
 =?utf-8?B?dFRMVHNxMU5ieWdJdjlMbDRKRFFMRHdTWXEybTM2aHQwWThsS212TUR0NjVJ?=
 =?utf-8?B?U0svc2pZbmdrWGlteit6WnJML2p5cTdBRzViQXVYVk81dEozQXgwY3NjSXNp?=
 =?utf-8?B?S3NtUFcyYmZ0WTNDeCtxUno1a2FnbWhROWlBM1RLL1lWYnNEbVlCNzlVZkt0?=
 =?utf-8?B?UWQyL2R6aERwTlV1TnZka1hESDlNY1BJV3ZMczFSNWxQR2xkc2xWcm9WKzNh?=
 =?utf-8?B?Z0VTdHN1bkx3c3ZndTFzb1dqZ0NCQ3RZWU1XZ0RvL2phbUkwc1hNN1UzOUVB?=
 =?utf-8?B?S0VFV3NoaTBZbmtjNHF0bTBaY1NoWm82SEprOHJNei9Oc1pQQStSeUtzRDB5?=
 =?utf-8?B?aU1ZZW5ub1VTVXBBWDJ1ajBxUXUwWFJiekVxeWRzSWNTUE1Idk9sVFlvbFk3?=
 =?utf-8?B?QzVEaXozZWc4ZHRGWWhnK2JxUXh2ZDVQOXE5Qms1VXZPN0lGUnFCOUdFTFNP?=
 =?utf-8?B?VCtTN1VLdGlxQjdySDVXMHA5a3pwMlFFYnFWK0dvbHNsdTBNZVRjZ1ZRUU83?=
 =?utf-8?B?ekl0cjlrNzFGblJwY1JPcDRFSmZha09QL0FWTnU5djlDZzJDckFvWmNPODFX?=
 =?utf-8?B?cUVtek0yYkNOTmJnaWZQL1lIb21JekJUR0Z5dUNEMFYyTHc1bk8rVjN6YjRJ?=
 =?utf-8?B?dHYxZTVoYVFFeVU0eXB0RGFpNUxsRVcvUEtkSHdlc2hFeTJiU3FCaWVPcXRH?=
 =?utf-8?B?TXd2ZWFmb0QwWStJMkhseXR5NmdLamZZNnI3TDkxTkdlV2VOcms3Mmw0SkRC?=
 =?utf-8?B?cHZlejcrSVcxWVlpZ2xTdUM5dUhYaGxEcDVGN3MrdHNCWWhnWjUybUs3Sjdl?=
 =?utf-8?B?S2lUb3Y5ZVRpajhGWTVsUE5kZ3hXVHNSQ2xCM2tSY2p0UXdOSWJ2OXZYMTF3?=
 =?utf-8?B?a05QVnB1MGRWeGZkU1FzNmlMaFpxUUJPR1FKL2J3NkJ4YVp2eXEwUEFHc1Zo?=
 =?utf-8?B?Nnl6OU9LRWViZWVLdWNRS256Kyt1dU56Z2R0YVhFM3kveW1mbTIxb3dTWDNP?=
 =?utf-8?B?czhoNEJodkVNMlZFb1k3U21nTitUVXlraUFROVRpVXNVMmJsYVlScm9zWUdF?=
 =?utf-8?B?QkFSYndWNE5CbGZFazRYZEU1T3BwbzY2YmVCeXFYeWRvOGJQbDJXek83eElW?=
 =?utf-8?B?MXRrT1R0cHN5a0F6NmlGZXZGNUFSNHBIUWZ0aFZXaGpTbllvYkNtU3FleWZT?=
 =?utf-8?B?L25oSVVIVzhpVjJzczR5Y1lNVnRlQmc2ODZ3SWhGZU9uMmQ2NnlFTWQ2K3Ir?=
 =?utf-8?B?ZU5vNmFwK3h3YXBIOEVlcThOSTdKa0JQcjVzRUlzbWVNZkREUDRYcEVwUHVh?=
 =?utf-8?B?ZVhGSFA4WXdCQVdESEUxSW9LYmtqUTQ4SG1NcHMvNUZUUHVnWmx6SmVxaUha?=
 =?utf-8?B?ZUY0azltUm9sUnpkak82Zko2SVk1WlQ4ZmQ2TUlrd0FDQUc0RGlxUUVUb1Rx?=
 =?utf-8?B?NVQ4M05DRm1LUHg4NCtSdnZ0UTlSTTlJOFA1WHArOXA2dks1Y2FxcENxbDZm?=
 =?utf-8?B?Nkg3TTk0MjhOU0hNTmZ5aW5Wc0pSZlNXQVJmTXBITHpURWNnSndlU3lIc2No?=
 =?utf-8?B?ekp3NGM3TWNNOHMyd2VzZkF0VW5WU1lPRzlTZEVRdmtqYkIxdkhKRkEySTkx?=
 =?utf-8?B?YzJyb2c2TW9HMGZoTWpIeTZySnFIWHdsYzdHQzNLV0VKWFc5UTU0L1hqV29I?=
 =?utf-8?B?UHRmVWY3VmIwZ1o2WTJPTGgwWHhaQ21MRFh4amVLemovbHhrTzNXa3BtOVpi?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PRAKCC0AbX5MGRSIGQUH8fE2t7hZuKyjCDcGBkFfMSUNmG796wwEAw21GQxGF0hURo9LKlIa3QE808jiInwW1mcUo7RRp7fySpsw7QJwmh2FXuMa67npmRqmcTUHHlomD/9UwYhL5HuqcZU4ii56uvGxPcgFUBo6ZK+bP/whfVUADQSh74fK+F4Q2A5ITD+ymkU5/LEKuRBAkoPZ4w+PDo7nJV8nprNjk50xB9IzFf7R7/fqFFE7aaAagU2JvrL/k9r8F7hlYVU/XC5f9wyvXW7idjqF1pv/eC/iz7SPGpa8SrjT/+zHdQUY+LSTRpB4Liee5ITHklEnmhJWtsJnktc6rY0hz8RfsCyzTLyOsWUcbMUsZWSp89BvLHljK3eG6UGX4zLlslc6Zng2y0bOxSjmJVJbRxZtXWNPn1fi53OHO7OLDckbscSOj2IsUzQzVSN/FfOLd5c1y4D3lWYNLfyNO0Uwb2o8Msch4yok62mp4dxuGfH8vntmLd5lg6oe0qDFcsuqZBo/WwJmCF24KEiHLa2h62KekO3O6r+TnVkl9f5tEgrGZfY8V+dzH8VaTiVGT/qa1ygxc0fSFdiCV1AMbBbnzru8yTYqWxTufqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50eb3433-1ab7-421d-6272-08ddc558eb50
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 17:39:45.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPCBuOPhVPozJmO8ev8YwnX9G+795sXKN7MElTaTpqmH0R3W+KLsuRxyZGv6FtfRbpTOBTk00NkJMaury4aHAg4CeGstCFb7Q1M0aj3tknM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6802
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=987
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507170156
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68793564 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=zKy9mnI-QWGR7xId1l4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qafJnkAK2cu602N2qIehHGZPS_OjL7IG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1NiBTYWx0ZWRfX+X3pSQNULle6 fwfrGvxtbLoFMELvy7b+JRXgMDgzsFmsEjAx1rHsRnsSqOhKnxkF0DbFaXoEYPI+Q4VgD9GSZxa Cv23klwi3qL7+VxzzM6mnjHcwSHYfkHW+xBAUr1FIkL7dlgyL1tpn/5lltufKijy0WH3PrdvJ1C
 xxZIm7Fnmt7JaPSMsgiGNXYVQwQg9x9JXsh1+NgxTt+Sj6Ufmp/xcWvZ80qIDGMLP65C4b2b7+l B8emExUN4hsxmda5dWdX6pKVDI8B8nw5Zi6I1/oV2k4KYRYvkBOWdL2bMBxVGa+j6dz3c5hTfLE DCj6dXnHQpwf3nP5wpwd6ZSjZQh1de4ki5p5opBOAPwooV2QGjN6bZO89Z6eFoHdr5xhnwn9dEX
 5xkInIwJcf6Z/MaY08peEZeSKw1tVD1qrqqF89zDYiZ3z/DPP1CcTftSYR/6YDy05qC5hcmX
X-Proofpoint-GUID: qafJnkAK2cu602N2qIehHGZPS_OjL7IG

On Thu, Jul 17, 2025 at 11:54:36AM -0400, Zi Yan wrote:
> On 17 Jul 2025, at 8:40, Lorenzo Stoakes wrote:
>
> > Hm something has gone weird in mm-new with this.
> >
> > The patches are in the correct order, but the 2/2 patch, 'mm/huge_memory: use
> > folio_expected_ref_count() to calculate ref_count.' contains the cover letter
> > and has the suffix:
> >
> >     This patch (of 2):
> >
> >     Instead of open coding the ref_count calculation, use
> >     folio_expected_ref_count()
> >
> > But immediately prior to it is 1/2 - mm/huge_memory: move unrelated code
> > out of __split_unmapped_folio() but with no cover letter reference.
> >
> > Andrew - has quilt got confused here? :)
>
> Since I am going to send V3 (also include after-split page cache code patch),
> maybe Andrew can drop this series and
> “mm/huge_memory: refactor after-split (page) cache code”. Hopefully
> we can get everything right in V3.

Cool yeah simpler :)

