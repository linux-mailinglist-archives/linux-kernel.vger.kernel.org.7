Return-Path: <linux-kernel+bounces-789858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C9B39B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63E64670FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802022E888F;
	Thu, 28 Aug 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X2ka+N5Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xyPAyJP5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40B849C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380730; cv=fail; b=ZmOTy9Kqkzb1Q3v1M6FgAh/3ePEMFtERPVoz8BGsuOzcS/itphn/GDJp+qcSZJslsjBG2rhZqYFWUdCI8UF4qlniDmjY0w34y35NECQu7S5Q7jMm/LRfu9RYmHe/E68Yvpm7pJZMzlSwGTKWHMEn45tzmHQO114v0EJFe9jDV2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380730; c=relaxed/simple;
	bh=VqmhKMTv1ITrwKalGBjTYP25ozXxdakzefm13A1boEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FT+FzjM5REw3wW1m8M9RjO+why3ZCzKa01iBEfL7dzJ+3nD//q958UPi5H3wZoCAvfgHu3xw+E3YMzUQ9vlccv2/MtVYoyFM+WAcEP14aHNjqBmz/MYV1wFkNnyfcgPKePHB2fNQoDhd0NqsZfY/3gADUecZJT8E5twnAbBPiGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X2ka+N5Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xyPAyJP5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8u4Q9007800;
	Thu, 28 Aug 2025 11:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/Krl8sqQds8T4A6FDp+zuQmb76InddnvmHAGm27z4mw=; b=
	X2ka+N5ZjWjryt2H2y7Bw6H9GaQC/yZl2WJjE7dOOlYvkrNyFn1lg9TX6oOxZ6t1
	0DVxKmNx0r2Y7J5hF/rWwOSHdRc72u8wE0Pz4+kjRf1UDv1LHusLYCU+SeRNseP7
	We1OsjiSKU66P+ggjFJ52tm0DpktWxOIpoZ6/yjqTVDo89LQYM5EcpsycQ91gfoV
	pDm8g6k9w+jxybKWT4D5l37ZC7YRyV201CK+vqGzKuiz28dEYg7d+v78+b5le4O6
	v2hPPW/6N0PSGoJDTCDgunyZwJfMV4JjnfcbfUN7pbLEAzWnbzgB0mMkUtr/TJMQ
	oo8GNIfHv+PDchpvYLfKJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t8589-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 11:31:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAf7Er005167;
	Thu, 28 Aug 2025 11:31:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8c1165-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 11:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgNWDRYIzr0Ur/IUYwP2kmZAhZ+nBBHoSQo4oVbxGdMoeX3wlfb7dwzJ1VeI6zVlpYC9JC/Kgr4F4NcRJ49LIuNWwEBQIY8czJ/SqTi2j+CKsf01RuTZc8eJ+vmYDw33zbe008tqEpZeVWdUx4TedIVMXnuwE7h5elAkTpD6B5CojkSFWGtR5oHtHMwya8W9wVIGfDbH/ANaIhXS4wZPFFtteKjsxcFvG6IkkuWbPh6gS0TwPj0lqFuDQ42H3mIXKx/bGCwe0hf2yUVOVc1EHQSSfLb9Yjlv56hMtGOGrJz3xvGldoXORah89enLYa2CB/umZeR536WDXX2KC9GJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Krl8sqQds8T4A6FDp+zuQmb76InddnvmHAGm27z4mw=;
 b=kHaESqCFdHBxU+RqB5g2e8ncsXZ56rNJ+udfZ4i6T929gqjYAnoRkajGJkjruwR2lm8sWuJLn5I/5ylZTPjWrdnk8Q06Q9HLKq56HEXVxIk6sEceBXA6eUJvlsR25DlyqbBrmI/NFkCjRuBUxlIPA34cUA5cwDGUhivBFLrFuXwkBcQFlufj9iQAWPtO6aq74r32Srr0brjVN4W+fBspLL/FS3XECj7yTbT6RmeA0nnoEJEdiuHOUcXtWjVTA3ClvgI60tQj//khBaFM3cCFgGVzKYOilWWMC0WrKQ6U3NWheqnJxTM+hcMB6JDjGtxkpPT7nuCK1mTdu0UqfA8Ncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Krl8sqQds8T4A6FDp+zuQmb76InddnvmHAGm27z4mw=;
 b=xyPAyJP5oZhhgMLLoz/rzQ6D/aeL8qS4tnJuiKTTZrxeU7xJEi5tH7mqAzsQVKubYBqt4OKwccRZVYKGKEOU5AjASAqRqGwljWWf+fq+vXVZLTbCsLW8dS30+AA7aGIrryNRNc6dzZaob2plaVkaYR8IwSrdFGbp04e1+s3ADnQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB5679.namprd10.prod.outlook.com (2603:10b6:303:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 28 Aug
 2025 11:31:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:31:37 +0000
Date: Thu, 28 Aug 2025 12:31:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        android-mm <android-mm@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
Message-ID: <d3a9dbb6-b1f3-43f0-89ae-85c0aef16bdf@lucifer.local>
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
 <65dd5d54-87ab-49a8-8734-2201a0014feb@lucifer.local>
 <CA+EESO5zUO8x21u1KAG5U3Rghaxw8GFGZMhsbM3E2AyeHFYRMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EESO5zUO8x21u1KAG5U3Rghaxw8GFGZMhsbM3E2AyeHFYRMw@mail.gmail.com>
X-ClientProxiedBy: GV3P280CA0018.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::33) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c039624-03da-473f-2424-08dde626735b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmEvUkZxNXRGbzlUSjhjelRwVzZwVGdSb2pIbG9YVU15TkFiN1Z6M1lIdVZN?=
 =?utf-8?B?VHRkTVZoQlg4cWJNaG0wa2RpVkl1aG5LeGQ5aUZSS0h1QjlNSVUvN1F3aitu?=
 =?utf-8?B?N05vd04veFZSMWNrTWNDK0FoS2wxYmg4V1BTMG9JRk9iRkZMNXFWQ3IyMEdM?=
 =?utf-8?B?RmVUbG5OWCtHOW9SZVpWMmFGTUpEOFRUUEZIcDM1cVdxM3M4WXIvNGZoaGdp?=
 =?utf-8?B?N2dvTmNyRmk5RHdnUFllbFZyUmJNYnpMT2xvYlVoeEVraHZxanpKV1JjdEkz?=
 =?utf-8?B?eFRZV0JBZXRuOTZCV0p4VUN4djBvcjZKdEpmdWpya290WWFabEIvclhrSlI3?=
 =?utf-8?B?SFlmMTBWcnJrRFlxNXVoa0lMT2Z3ckJUbGR0eHVJZGlwb2tNcnR0UEdTY2Qy?=
 =?utf-8?B?bnJVdlBFYitRTlVnZEluQXRhZ1o1YmlIRXhJSmhjaVowZVIxTDUrd0hXY2Z2?=
 =?utf-8?B?aEx1dXRnNnUvdW96Szd4OG0wNURjNVhtY1FkRjJHWGhYOW0xWG5FR3d2aEhs?=
 =?utf-8?B?cHE4MUJzMzNBZ0xTckNyNlBLbnVFckk4eFRQbDFvc2VodTJCVDdTWWpVZ2dG?=
 =?utf-8?B?WmVwbHFucmhzR1A3Q3hIcXdkNkR2RFU0RGFXMVZiL0xsY0JSOURVVGdBajc3?=
 =?utf-8?B?Wm8wM3VlNmVuMWJuRVA1YWQrSG52eUNkUnYzNzBJTGd2SHpLYlFiUWJMcVl4?=
 =?utf-8?B?dDVFbzI5Vkk0c2RmUWZjS0lhZThCVlhEK3A4TnVIakVLRHlyamdFaTJVR1RE?=
 =?utf-8?B?M1ZjR0dNS0UzUVh5N3ljUENjZWI4U0Z4cGp3cnp1cHcxemEzNEtmamI2UDNt?=
 =?utf-8?B?bU9CNW9rQ0d0eU82czBiTWc0b3lCRXc5MDVFRlorbnVSQ0lrbWRHUEgvWE5w?=
 =?utf-8?B?ai9SUXhENFUvOU0xVmZ0QVVyVVU3QWxkTnpvVFJQMFh4d0VWcXdpWkU0ZmFO?=
 =?utf-8?B?dzJYei8zSWo3WjlCZmpxYmVpUWVxQ0JWVmY4Smh1VmkzakxJWmFXU3lJcmFR?=
 =?utf-8?B?TFN6ZkRySWg4Vzc4RnFHdUJxT2o3UWxrRU5PMkd3R2ZTMmk3OXl3dWtlWlpu?=
 =?utf-8?B?OUlvUGwzeDZQRURUeUo4WW0zOGk4UW5GMXI1ejdOdWhma1MvM2pjTkFiUnRu?=
 =?utf-8?B?V0l4eENYdXFMbHROeFgvYWpwSG85TkFTOWQyd20yVmFjaXNuRGJ5Rjh0WkhQ?=
 =?utf-8?B?SEF0OWlWVHB5czBnVE85UTFTbE9iRU9CQXlWV3N5aEhVK1dnS21Ockc0cWlN?=
 =?utf-8?B?VFphakdpcWg2V3lwT3ZadDVrbXQ2RUFwQURBMTZlRkxRNUY5QVdubktOV0Rp?=
 =?utf-8?B?c3ZMRUtmWm9xYWk4OFE0dmphdzRBdkNpSmE1YTBEcHptbzduSEEvczl5cUsv?=
 =?utf-8?B?YlVCUWtDVE1LZ1dZNnpidEorbEJnNWFmbFlQY1pFMzJXUkRwTW03WnJDa1Ry?=
 =?utf-8?B?a1N2ZkNaY0k1eXNuR00rNWlQM1Bsc2ZlRGtRb3RRSWNWZGlPM1gzM3JKaXdV?=
 =?utf-8?B?b0NDREtoYUpFblo3R2RibWRIZndDZ2hWczVTQlVaTjE2ay9XZ3RSay94MGxX?=
 =?utf-8?B?ZVhZOU5KOHBoMDRGeEY4WE1JYzBGdWZlNXN3WmlJbE54QXFUODUyYldSa0dI?=
 =?utf-8?B?MHpIZlZGOGJlbU5vRDZZYk1KT0VJZ0NNYnJ2M2pwNUhPcWI5UC93UXU1Qzgw?=
 =?utf-8?B?YW4zcFE5dTFBa1kyZUZUWkdSRlczK2g0djY0aGhCTWozSVB1eE1iYllVdXN5?=
 =?utf-8?B?Ny9peFdqMEVQTjl1aW4xbmFJdWZqTlZiZXdkQWR6MzZxSkVVSlhNVEpKTWdN?=
 =?utf-8?B?TFZJenowNDhOcWJMbzVDOUlqblhqT2E1VTVYVTBQaldWMktnRmtJejRMRlpu?=
 =?utf-8?B?WWJvS0tMT0ZHbVk2SFhTbDZZYmNaZEthUGVxSFYvVUxhOHRuY0RQcEt5VzN4?=
 =?utf-8?Q?LKWcqknNv6c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWNWODBFNE5qYzlGdnZzT1hhN0RMVk9HSy9KUXZDem5uODVsazZjVWdKVVlt?=
 =?utf-8?B?SmRSSUVaUFEydWNBREk1THBKT2llRkxUVXhkYkluVXZ5V1BKR1Q3dkhJNVVl?=
 =?utf-8?B?M2FZOXRUTTZhN2NpYXFCeWErQmhpZ1JBd3lTZXY2Qm9nWW1hRjd3czB3aTlo?=
 =?utf-8?B?K2xsSjdGcVhibU12VmlJYzg0MkZQazMxaTNOd250N3gxRHZmbnFHWU9FMUsr?=
 =?utf-8?B?c2lhbnJBbERpbGY2Nnc5MUVpdWxMdzk5blg1L01BVUlGdUJoemZVR25HaWNJ?=
 =?utf-8?B?NlAvbTlYT3NpU3llQVk5cmZCM3E5M0trUW9meEs2cWZ2TGdTeE1HVTdDc1JH?=
 =?utf-8?B?eUtzRHlmaVhuZGkvS09iN3Z2N3g4ZTBDZTVPY2RVazY1NXVSS0JQM3hua2FZ?=
 =?utf-8?B?bGQ4YjNyaWxxeHRVS21wMWpxQnQzM0NpUUdjNHpSVUQ4UTA1MUJhUWMySmky?=
 =?utf-8?B?RjdYK2p4cDJKbGsvQWhWK0x3UXBDdjBYWW5qNC83TmJZd3ZFYjJBUERyMExn?=
 =?utf-8?B?RXc3Q3ZodkZlYnZCa3RRUGxEU0lGbXVyTzlKOUNZWXlINTlHR3hJT05LQ2tG?=
 =?utf-8?B?YkNQa0JsYnVjazczbTk3S1E1YlFHYlEyTGc2UWhCekszcjlnRkp3YnFFVzlI?=
 =?utf-8?B?YjU4VS95NzVZaHl5ZWxuZG9HMFg4MHpYeG9BbW82cGlzT09XaGdNL1EzMWti?=
 =?utf-8?B?dlFqRElCUUNnZkNWaStaeGw5cnVOeUpXckI3R2h0QTRhMCtKOWhyNE1iS1o1?=
 =?utf-8?B?T3I2RnVIQk53d2VZVk10VXRHNTJMeWZlanZrT2Jjay9hRFR3QVAvVjQrTFRt?=
 =?utf-8?B?c0lnNllQS2hxSytTd0ZYSFJiQnY0N3pFbUtqWjR0dGJNNG9nYWVuODlkOTNU?=
 =?utf-8?B?b2NtT3B3NnNObWJNWFBCdGtnN2NFWHN1QzF1Yi9ZNzBpZWo0ZWFqYWtlNCs0?=
 =?utf-8?B?OHhNT252OE02TmY1bGQxc0dxRnJVSHVzMDZjcEhqa1o4bnprMnpYNUtYVDRU?=
 =?utf-8?B?bzdDYzdtQmZFQ1lWNzQzaUZQVm5JSHpWZXVBL01GWlVVaDMrSERacGFSUVEv?=
 =?utf-8?B?a2ZubGp5blgwL2c5ck5NUHNVeFNZZHdMNlF5emxBMVRqc2NLOC9FSFBEZi9z?=
 =?utf-8?B?MmFUSmdMNEJNYms1THl2VEVkRDY2dUFUa2psSHp3blpibmRKVkRzWWlDQ3or?=
 =?utf-8?B?Ky9DOXAvNTJzYVZuQVhqQ2VtbE1YdnlNaXkza3JKZ1c3bjdjZUUzT1UzdjBI?=
 =?utf-8?B?cU1pa3FYWXc1eDROL0FWSWVUaTdPNnJsT1BCL2s5UUNKN3RSUVRsWGplTmhr?=
 =?utf-8?B?ZUo0TkkwVXM0T29RV1VJRE5GanRINTJkUm8zMXV6a0JnYy9UVWlTbkQxRVdz?=
 =?utf-8?B?dUN1dk9WbEUvSUtGM3pnTVU4T2doMmxScWZNVGFIN0drWkdpdFRGSlpTNWdR?=
 =?utf-8?B?dTB4MW9NZlIvaXRHM1VTd2p3R2FvV2ZNQ2QwQW1kbGhXc3AzZFFOaTM0WER1?=
 =?utf-8?B?dTJHbTBHUGRBWGlhRmlnU1NhMFRKUFhycnZDSHVIYVZvcFZqV0tJRE9mYm1a?=
 =?utf-8?B?VFZ3bzNNaVUvcS92SkNPMWJRL3dIRFJPV1YzcGlwRFRpYnVhQWN5aE1Zc3Zw?=
 =?utf-8?B?VFQwNkx2aS9ra2YzWEo3aVN4T3JPRXBPa2s0TGl5dlZ2dklkNmYvQ2w5RVpt?=
 =?utf-8?B?emswOUtpZERWS1BMUFlrNm1IWWRoaFZRazhYSXFBVmhNL2ozUTFNZm11cDNr?=
 =?utf-8?B?dHEzTzhhQnE3SjlJVTJXSXIyQXEreDFsd1BZMWphWGZnVktOV0I0L0M0eXZN?=
 =?utf-8?B?dEcxc3AydUE1Y0tNakxib0dqOGh2dUVqbzh2K1d0V21NUW41Yk00cms0MW1F?=
 =?utf-8?B?YXRnWk1nb1gzSm1mZGROZTZsdW93c001MU9OYzh1djZTdFJtK2Z4c29SVS9y?=
 =?utf-8?B?d2RQY3ZzRitLOEQ0S29xVXZpV0pLQjhCY2hCNE5TWFpjcS9wangwYmhJaXV2?=
 =?utf-8?B?amxzL1F5MW5nT3MrVTlBckJOVkJDVHp2WHBXeG5NdEhjMkxrRUM2OGFGYjVD?=
 =?utf-8?B?OHQ2bEFwNUg5M3hSMFE5WkdrZERqL0VoZE5lSnVjZXkyUXpCV0lkUXV1NEJn?=
 =?utf-8?B?QXVrRjJSVXVFRkpXY0Zkck81a1V0YTIzaDdsZVFCdGJlR2JCTERzQlkwQkxM?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q19sHrhkZfOcySufrP8wcbwln9ft+Kac2QRkK+GzqmV0vgkQpNKPDM+ZjKxGnqkPO19qshTIINWszmWYfECPtSatPjzChDKZpnFEOt0nbZyKNtpjBpxQ+c3T/81s/IIRDo5pkW3bCN+Qboy125kSZF8SR/J7gcnJe4MNyoCcyNJ++qoSurB5GBuXfmZK9JBKxNfdqwr6OrGdlc9tSLBYVFqb858qX8OFYHyb3TPhvG12SDK5MCCDPDCLEl5SXr8fb6LS8wz1ojH+MlmcxnuUB8gF2pYkv+5t6Cg7bnRGyfSb+nH2P1R65n92OaHO0ZscasFJzeX3ymx2rWGauB0mOJINJvJmT0spmjghqHTKe5iFivMp+YE34r9P/9cniFyGMuqjEYWnjHBGiRKCuIPTZEaFgI25VQInkpYen8189TmQLy04JcuBhh3kSAIfLaOStyqndhBoxYgoutBxjPcQN1U7WbkqOgckIGJw63B2WPyyC5MwR9x/yEX+0Lbr4A93syoby2lFYfNK6T4Zp582SrF8KAUMNu4Y0WQYDEstex6OGqwR+q+KM3CLIXAr0PPML2NHkX+gjG7HoQkdqdVUQc1wkkMcWMf5WQotQYqP83M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c039624-03da-473f-2424-08dde626735b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:31:37.6879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V4wEFmSfbNSL5Mi58oVVlOLcohGirk7PxIt4IOuLmFc/zWzgQ5DVVGj/zrz0AFnIkdRv1AHVoZw8tW5/VPl36m37oAaS/qQMosnYip4EHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280096
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX9Dp9LhuUjWZm
 IQ64vWrWyOenLplG9PdaZZZjN0TugvH6EPZhP5NySuRAkN7hgi7ee6TYjHDUW5c8ECE6qqw2Opp
 Y/Z6XakbdaFQ6xY3pxChk8VqhEg/D6lx1f+o4coCKzv5D2sq+CX+VDrPfSpsVZThNILnsf1VDUb
 0vGiWPAvKJDXXUvkyCb1BayAZYsA91i/WyQSvArpcnvyPgleiwSPuUOs1zzbXKPQUdWtBAACXTH
 D8ZY951RpZcihUj7K8Dm+lxY65WESjgy6LzISYC1wk5N38JElHfta4E51GzCerOPCtl6ysRoHwP
 ZM+KTSFyZM1oXNz2wVLLIiOa3LzOUjHkSrqnuD9i3+lLXs6AbxMmeGM9q9yjPi9xlTfUwGXQqki
 i7QiphyiQ80WR//bnSUD50utzg7VCQ==
X-Proofpoint-ORIG-GUID: nWKQtBL22MhLgHYKalbASDJQaBVayTdk
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68b03e27 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_VA424SBVhlCOtmieS8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-GUID: nWKQtBL22MhLgHYKalbASDJQaBVayTdk

On Tue, Aug 26, 2025 at 03:23:28PM -0700, Lokesh Gidra wrote:
> On Tue, Aug 26, 2025 at 8:52 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Fri, Aug 22, 2025 at 10:29:52AM -0700, Lokesh Gidra wrote:
> > > Hi all,
> > >
> > > Currently, some callers of rmap_walk() conditionally avoid try-locking
> > > non-ksm anon folios. This necessitates serialization through anon_vma
> > > write-lock elsewhere when folio->mapping and/or folio->index (fields
> > > involved in rmap_walk()) are to be updated. This hurts scalability due
> > > to coarse granularity of the lock. For instance, when multiple threads
> > > invoke userfaultfd’s MOVE ioctl simultaneously to move distinct pages
> > > from the same src VMA, they all contend for the corresponding
> > > anon_vma’s lock. Field traces for arm64 android devices reveal over

Hmm, I started by responding below but now have a vague thought of:

What if we find a way to somehow detect this scenario, and mark the
anon_vma in some way to indicate that a folio lock should be tried?

That'd be a lot less egregious than changing things fundamentally for
everyone.

> > > 30ms of uninterruptible sleep in the main UI thread, leading to janky
> > > user interactions.
> >
> > Can we clarify whether this is simply an example, or rather the entire
> > motivating reason for raising this issue?
> >
> When I started off I thought maybe there are other cases too, but it
> looks like as of now only uffd MOVE updates folio->mapping to a
> different root anon_vma.

Yup, I mean I looked into making mremap() do it, but it was insanely
difficult to make it work (sadly!) But indeed.

I think it's important to highlight that this is the use case.

I wonder if we can't do something specific to uffd then that would be less
potentially problematic for the rest of core.

Because I just don't really see this as upstreamable otherwise.

>
> > It's important, because it strikes me that this is a very specific use
> > case, and you're now suggesting changing core locking to suit it.
> >
> > While this is a discussion, and I'm glad you raised it, I think it's
> > important in these cases to really exhaustively examine all of the possible
> > consequences.
> >
> > OK so to clarify:
> >
> > - You want to traverse the rmap entirely without any rmap locks whatsoever
> >   for anon, relying solely on the folio lock to serialise, because
> >   otherwise rmap read locks here block other rmap write lock calls.
> >
> There is a misunderstanding. I'm suggesting locking *both* folio as
> well as anon_vma during rmap walk. To avoid any confusion, here are
> the simplifications in mm/rmap.c that I suggest:

OK. Well that's less extreme :)

But then, if we're taking both locks, how does this prevent contention on
the anon_vma lock?

Even so, this is adding a bunch of overhead.

>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 568198e9efc2..81c177b0cddf 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -547,7 +547,6 @@ struct anon_vma *folio_lock_anon_vma_read(const
> struct folio *folio,
>         struct anon_vma *root_anon_vma;
>         unsigned long anon_mapping;
>
> -retry:
>         rcu_read_lock();
>         anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
>         if ((anon_mapping & FOLIO_MAPPING_FLAGS) != FOLIO_MAPPING_ANON)
> @@ -558,17 +557,6 @@ struct anon_vma *folio_lock_anon_vma_read(const
> struct folio *folio,
>         anon_vma = (struct anon_vma *) (anon_mapping - FOLIO_MAPPING_ANON);
>         root_anon_vma = READ_ONCE(anon_vma->root);
>         if (down_read_trylock(&root_anon_vma->rwsem)) {
> -               /*
> -                * folio_move_anon_rmap() might have changed the anon_vma as we
> -                * might not hold the folio lock here.
> -                */
> -               if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
> -                            anon_mapping)) {
> -                       up_read(&root_anon_vma->rwsem);
> -                       rcu_read_unlock();
> -                       goto retry;
> -               }
> -
>                 /*
>                  * If the folio is still mapped, then this anon_vma is still
>                  * its anon_vma, and holding the mutex ensures that it will
> @@ -603,18 +591,6 @@ struct anon_vma *folio_lock_anon_vma_read(const
> struct folio *folio,
>         rcu_read_unlock();
>         anon_vma_lock_read(anon_vma);
>
> -       /*
> -        * folio_move_anon_rmap() might have changed the anon_vma as we might
> -        * not hold the folio lock here.
> -        */
> -       if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
> -                    anon_mapping)) {
> -               anon_vma_unlock_read(anon_vma);
> -               put_anon_vma(anon_vma);
> -               anon_vma = NULL;
> -               goto retry;
> -       }
> -
>         if (atomic_dec_and_test(&anon_vma->refcount)) {
>                 /*
>                  * Oops, we held the last refcount, release the lock
> @@ -1006,7 +982,7 @@ int folio_referenced(struct folio *folio, int is_locked,
>         if (!folio_raw_mapping(folio))
>                 return 0;
>
> -       if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
> +       if (!is_locked) {
>                 we_locked = folio_trylock(folio);
>                 if (!we_locked)
>                         return 1;

This is still a really big change, we're going to be contending the folio
lock potentially a LOT more, for the sake of a very specific and peculiar
uffd use case.

It's hard to justify. And any such justification would need _really
serious_ testing on very many arches/workloads to even come close to being
ok in my view.

This is a pretty huge ask + it's for a specific use case.

>
> > - You want to unconditionally folio lock all anon and kSM folios for at
> >   least folio_referenced().
> >
> Actually file and KSM folios are always locked today. The anon folios
> are conditionally left out. So my proposal actually standardizes this
> locking, which is an overall simplification.

Right yes sorry misspoke I meant to say anon.

This is a HUGE exception though, because that covers the majority of a
process's memory allocation.

>
> > In order to resolve a scalability issue specific to a uffd usecase?
> >
> With the requirement of locking anon_vma in write mode, uffd MOVE
> currently is unusable in practice due to poor scalability. The above
> change in mm/rmap.c allows us to make the following improvement to
> MOVE ioctl:
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 45e6290e2e8b..c4fc87d73ab7 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1192,7 +1192,6 @@ static int move_pages_pte(struct mm_struct *mm,
> pmd_t *dst_pmd, pmd_t *src_pmd,
>         pmd_t dummy_pmdval;
>         pmd_t dst_pmdval;
>         struct folio *src_folio = NULL;
> -       struct anon_vma *src_anon_vma = NULL;
>         struct mmu_notifier_range range;
>         int err = 0;
>
> @@ -1353,28 +1352,6 @@ static int move_pages_pte(struct mm_struct *mm,
> pmd_t *dst_pmd, pmd_t *src_pmd,
>                         goto retry;
>                 }
>
> -               if (!src_anon_vma) {
> -                       /*
> -                        * folio_referenced walks the anon_vma chain
> -                        * without the folio lock. Serialize against it with
> -                        * the anon_vma lock, the folio lock is not enough.
> -                        */
> -                       src_anon_vma = folio_get_anon_vma(src_folio);
> -                       if (!src_anon_vma) {
> -                               /* page was unmapped from under us */
> -                               err = -EAGAIN;
> -                               goto out;
> -                       }
> -                       if (!anon_vma_trylock_write(src_anon_vma)) {
> -                               pte_unmap(src_pte);
> -                               pte_unmap(dst_pte);
> -                               src_pte = dst_pte = NULL;
> -                               /* now we can block and wait */
> -                               anon_vma_lock_write(src_anon_vma);
> -                               goto retry;
> -                       }
> -               }
> -
>                 err = move_present_pte(mm,  dst_vma, src_vma,
>                                        dst_addr, src_addr, dst_pte, src_pte,
>                                        orig_dst_pte, orig_src_pte, dst_pmd,
> @@ -1445,10 +1422,6 @@ static int move_pages_pte(struct mm_struct *mm,
> pmd_t *dst_pmd, pmd_t *src_pmd,
>         }
>
>  out:
> -       if (src_anon_vma) {
> -               anon_vma_unlock_write(src_anon_vma);
> -               put_anon_vma(src_anon_vma);
> -       }
>         if (src_folio) {
>                 folio_unlock(src_folio);
>                 folio_put(src_folio);

Right, but again it's a niche use case, sorry. Changing how _the whole
system_ does rmap to suit a very specific use case isn't really a viable
approach.

>
>
> > Is this the case? Happy to be corrected if I've misinterpreted.
> >
> > I don't see how this could possibly work, unless I'm missing something
> > here, because:
> >
> > 1. When we lock anon_vma's it's at the root which covers all anon_vma's
> >    covering parent/children of forked processes.
> >
> > 2. We do "top down" operations that acquire the rmap lock on the assumption
> >    we have exclusive access to the rmapping that have nothing to do with
> >    the folio nor could we even know what the folio is at this point.
> >
> > 3. We manipulate higher level page tables on the basis that the rmap lock
> >    excludes other page table walkers.
> >
> > So this proposal seems to violate all of that?
> >
> > For instance, in many VMA operations we perform:
> >
> > anon_vma_interval_tree_pre_update_vma()
> >
> > and
> >
> > anon_vma_interval_tree_post_update_vma()
> >
> > Which removes _all_ R/B tree mappings.
> >
> > So you can now race with this (it of course doesn't care about folio lock)
> > and then get completely incorrect results?
> >
> > This seems fairly disasterous?
> >
> > In free_pgtables() also we call unlink_anon_vmas() which iterates through
> > the vma->anon_vma_chain and uses the anon lock to tear down higher order
> > page tables which you now might race with and that seems even more
> > disasterous...
> >
> >
> > >
> > > Among all rmap_walk() callers that don’t lock anon folios,
> > > folio_referenced() is the most critical (others are
> > > page_idle_clear_pte_refs(), damon_folio_young(), and
> > > damon_folio_mkold()). The relevant code in folio_referenced() is:
> > >
> > > if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
> > >         we_locked = folio_trylock(folio);
> > >         if (!we_locked)
> > >                 return 1;
> > > }
> > >
> > > It’s unclear why locking anon_vma exclusively (when updating
> > > folio->mapping, like in uffd MOVE) is beneficial over walking rmap
> > > with folio locked. It’s in the reclaim path, so should not be a
> > > critical path that necessitates some special treatment, unless I’m
> > > missing something.
> > > Therefore, I propose simplifying the locking mechanism by ensuring the
> > > folio is locked before calling rmap_walk(). This helps avoid locking
> > > anon_vma when updating folio->mapping, which, for instance, will help
> > > eliminate the uninterruptible sleep observed in the field traces
> > > mentioned earlier. Furthermore, it enables us to simplify the code in
> > > folio_lock_anon_vma_read() by removing the re-check to ensure that the
> > > field hasn’t changed under us.
> >
> >
> > I mean this is why I get confused here though, because you seem to be
> > saying 'don't take rmap lock at all' to referencing
> > folio_lock_anon_vma_read()?
> >
> > Perhaps I misinterpreted (forgive me if so) and indeed you meant this, but
> > then I don't see how you impact contention on the anon_vma lock by making
> > this change?
> >
> > I think in general - let's clarify what exactly you intend to do here, and
> > then we need to delineate what we need to confirm and test to have any
> > confidence in making such a change.
> >
> > anon_vma locks (and rmap locks) are very very sensitive in general and
> > we've had actual security issues come up due to race windows emerging from
> > inappropriate handling, not to mention that performance around this
> > obviously matters a great deal.
>
> I couldn't agree more. My changes seemed to simplify, otherwise I
> wouldn't have suggested this. And David's reply yesterday gives
> confidence that it wouldn't negatively affect performance either.

This isn't a simplification though, this is taking a new lock in a core mm
code path _for everyone_ for a specific UFFD use case. Everyone _but_ people
using this UFFD stuff will just pay an overhead.

Another aspect is you're now making it much more likely that taking the
lock will fail, since it's a trylock...

It really needs very deep analysis and justification for me to be any way
convinced this is ok.

It's hard to justify and I think any workable solution would need to know
this case applied.

A very simple but horrible thing could be to have a config flag to
enable/disable this. An even more really truly horrible thing would be a
prctl()... but let's not.

>
> Thanks,
> Lokesh
> >
> > So we must tread carefully here.
> >
> > Thanks, Lorenzo

I remain very very skeptical of this as-is. Of course always happy to be
convinced otherwise...

