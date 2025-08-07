Return-Path: <linux-kernel+bounces-759459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54310B1DDC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2EA18C0B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9092222BA;
	Thu,  7 Aug 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hKneHAbA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KDZPH17S"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCBD5695
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597501; cv=fail; b=BgtA+RurxF18HqLafT+ngP25j8K/B+2O4VvsI934pvYmepJMY7piNR8vvbqpiIU6c7D/5DSqLWCpcruanWwv+iMZ4EvT1D4ekVJLK4hWclysMPYYe8wJBrK2lKqMjsAuOmCiykKqXUNSQFQ9y4DBT+koawDbkxDqQexDblqqJkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597501; c=relaxed/simple;
	bh=VXPu97GWdXEvwG7LGJqcvpJtNXv6OBoO3piI6zCV+OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TGLB7GHogfHyCqdodhrrRDb1t+2502LbwR2K0daX+xQk/jAgiwvSj1uVEV9vflCZCt9rHLE9aY9Qgxp31G6eAnG9jh+XrwGpea/V0dAXZpWuvUqMh6fX0fgE1xjv9sOmtGN87j+e8UXYaIrgND8MXLErMjdyCVXGyaK+HutvtIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hKneHAbA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KDZPH17S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577JfuHa010799;
	Thu, 7 Aug 2025 20:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XSg3U337LIBQX3smSC
	iKy9dYtikHVD4isO4TbsBjcV0=; b=hKneHAbAX5liCcGFUpbnjM4C4GnFBC4/x/
	rqr8c+6VT/Y/nxgcOLgMWPR7MmMfSKDdNqLkl2LOX+4LbG4StnxrwjCo5YoCefjW
	AF2rNJirauOf8rPCd6pp271fHyepO/pMSOtTjCb36RmYgg3DDSlNMzcyRKls43H6
	fRQY6+8f6qULKbrm4ItGf0RCeAqXHQBYQuHIFcA1BfQheptZYl/icy0+v164emMT
	8FXRYuPmFpogdkgm9f+EdKxuR1ihntkWZIumJjTJv23IA665pxSeZ8rIL4dOpTBl
	pCAqJUQzgpUqSxJj3Zpa+e3lfSbjV93lGDsbxErg2IHFq5HcYvgw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh4xkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 20:11:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577J75Yh018382;
	Thu, 7 Aug 2025 20:11:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwsx97e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 20:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htqsrgJNjPL2hFm5UR7lLEK4JmESiV2IFOWx+ULr43eoXJEnDd3yRA05Zo3OtSSF415LCGNvmOgihZy5rVa71bzWxFoKDnUO1GzwJZzS7KirUPCl1BAygyYKyu5/QG+LQxR3juldEyB4448UBADJJspnry1zNOf5sQFxh7FP24gNWDemAHmxAdZ/1uSOwYlFZQUQXCp4imDSK+cmYzSJGsGft++Z98Da1p8Q8ig04GYoAGMRkxdfbJ/EiNRqq4osITnFsUOxZL4wVlbh4DSn+NcyAF/i6dH5NXaQbGdPh6iVxL+6xQajz2qXCRx5evGhdn9jmnkqVhjVE28WVD2uSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSg3U337LIBQX3smSCiKy9dYtikHVD4isO4TbsBjcV0=;
 b=ypFowAgAHe7+J6PGy2iYvefiS8zEWNkoMraMnp92ULHrvlnOd4vjXmT1uo/4eOi0ZTG76WbUSIBriQL3t6q83NPXvqHpq9t1mQUcTAfvmrSLxdSP2utUSh79jWK5hmDwrfIBAsSowl9pHvAtvAZS2g8z2CHfLc+kKJaswG+UZuAzqIZ2Ocm58DG5I81iiIOg0rngZQrQmWd/An8IJmiVYDWtPEiFCs2Ed6baNaObe8yGmvh2IZl/o/kEmKwwAWCXJQziBI4EClAj6QrCmDRH4o8/jtFwbSTfH8Dlx//TAk3HxGzqQtEBKfWWQu+r43BYAp29zr63d06MAvx5mUEkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSg3U337LIBQX3smSCiKy9dYtikHVD4isO4TbsBjcV0=;
 b=KDZPH17SPJzjZMIfXptMhcmv/Mef5bPJhsh6rUfHAWisYtc+9pcUirtsbXfFU1jWDiCDyj4fs3Sc7hanjED+b4VXDm9fhVM6rmxuskMsurNtKYb8JYi2piW02hncxe2R/ugRze6K8Gf5blKRitcHmXhm3YI9LH2yxuKggxSSl0I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6300.namprd10.prod.outlook.com (2603:10b6:303:1ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 7 Aug
 2025 20:11:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 20:11:16 +0000
Date: Thu, 7 Aug 2025 21:11:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Barry Song <baohua@kernel.org>,
        Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
Message-ID: <adf7603e-418b-4f84-b49a-9e784fa7efb3@lucifer.local>
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <158e6422-fc82-4d6c-a442-2ebe956a66da@redhat.com>
 <3fc75720-8da7-4f6c-bdce-1e1280b8e28f@lucifer.local>
 <ee3d7b32-af47-42b7-bd27-0675c065d736@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee3d7b32-af47-42b7-bd27-0675c065d736@redhat.com>
X-ClientProxiedBy: AS4P190CA0055.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 1110818d-7b19-49ad-f299-08ddd5ee90ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d0KqfazrKfJ1tGFFXTQT9MQbJJUI9WsPSScF3JQukGIWLyF0FqPIHqB/9wdB?=
 =?us-ascii?Q?MN3cxUZs1SO2TDpE2fgv25PvXnj5H9ROCSxOpR0mLFz5jYUS2eFsW/nArjtp?=
 =?us-ascii?Q?nbDhT9fphLmexVN95L3by6qKtQtIr3Nmc4VMlLUXOOwInMBTnEW3wBX9oStC?=
 =?us-ascii?Q?KSsBjPk3pG7n1TdwHnEMAkj0/29GEXnBfjJZqBUR8ua8odC+QlpaK/K0TZlA?=
 =?us-ascii?Q?LEQvzPw/XtS0e+WgZBnxboKulL3OQFWi71VvY7X5n9/XoH+zys1r2/W3ctHr?=
 =?us-ascii?Q?NA0uQDqA1SBl0BDuRE9hWvchVt47SGVBE7u6LzXwv8/LDtmg1fnnk3G4UwyT?=
 =?us-ascii?Q?WhJ0l2+cTE2o8f+t9ej+VnVPmAm+ejFalm1/uYfJItu8iUuN8FTM4gf6xnhR?=
 =?us-ascii?Q?fe0hZFTlasc7ZYhpUmfENYguYjNm2etifC9EBHa95cC3kc7GB49cKyXli9m9?=
 =?us-ascii?Q?GPnsQl21AVxFeU/xgb2M7dffCPWSv16F1QPb/j5GiBlI+tfED+B3GwHJkTCX?=
 =?us-ascii?Q?P0WsPMox7g/xSl4v4ygY7ryLLir4mMzIjXhAbpWJT7YkQCm3nODkJbqrwxb/?=
 =?us-ascii?Q?IBlkwM9KdPUzsCDtKrckguM/U6jfGxXaKjOW9TUDgWl3KcXo26XcSVKernjN?=
 =?us-ascii?Q?Ad5qpC8wbzHPUMcLE81CI9TzWy0WUkXIHb1ulpNsjTnEP2fWhMwSfTffUGxE?=
 =?us-ascii?Q?sUZcDqOOuPb94scDMohh9pimdy18y7aM5Gr5kRXFlBG0HHMgy1D9OfM+xmM8?=
 =?us-ascii?Q?Fc42xiTc8lhx+g8xHTiiyxZYGPuWSCR4T+rzTGOKwYiWvKiBeOuWsX8W//XK?=
 =?us-ascii?Q?js4ac9n/UqPYQ05yiOXGaItEBYKm0s1m7dzBz7RrU3GEpPU5ZXHTa0ORCsxp?=
 =?us-ascii?Q?viMHR97yH9Uzcqa1gyN485JhjbUv8iLS4s12l382E3x+GHdAKGuH5UDu6BSw?=
 =?us-ascii?Q?+OYYi5URpHxacvhW9540UAZzPmAzVd8PQ7vCPiyUBaX7Lys34/XLAkgJUt/t?=
 =?us-ascii?Q?6MvfdT34AHmm/GpfFLtaq4eCZtFShq1lYU9vLTVZaGXIdsrLaYzC6KRQ0/2V?=
 =?us-ascii?Q?ikyFcx8FwoS73YqNxRb5DJiAFb7m3Xa1MjeRbC/HXsDYIuP/5v1LHgIp+lDW?=
 =?us-ascii?Q?T8WahBmy8THXA5pDYzz3+n1BRolrYnRKiQLg1RKrzdi4K7TguQ8cBOSdC4Y6?=
 =?us-ascii?Q?/0SmmIfYFq97Vc2jG7Ps7uoaPiqwdnmXwEvRn/97lw/ILemBpWK6/y1RdqxE?=
 =?us-ascii?Q?9SnABf9uE/OTEa6kDT+izE50Qso7HK9r56JBGXpwY2xCshxQmEfpoRbI/arj?=
 =?us-ascii?Q?cx46BaBqkqTs0ush/Umk2OjoVx2AUO3o4i0V/TpEvmYCwNMqanneAlBphZyK?=
 =?us-ascii?Q?fU0IunmGwx/rmxmi8SvfzfpjReufG23fL2iOYemjnXdMnlUjAYcmuJCpdk1t?=
 =?us-ascii?Q?le323M6rmiU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PshcZq4u90TMvwFuRomDDUkD35v2iVFwbV2LnJbc2TIp3x/YOW8k5xRZpRD3?=
 =?us-ascii?Q?5X43RAq/5/SYgZgaWwTQ49lHTqgdhu10v7P2KKAyFB1e4nrzjBqnbiQbcxGT?=
 =?us-ascii?Q?EV4/lON8kRU0rFdm5F5BZq0NrFG2wvSDGM5TZ0Y15dMyJZYSWAVtgFOI37BE?=
 =?us-ascii?Q?ZLD2D3HKj2TVYRZ6eON4iYCrAKWdliVZVHYJ/muwWtVRqBytMl0Ea/qASXHN?=
 =?us-ascii?Q?43gd9veSF0muZYszQZ1pk4KvEQYmR8LKtOfAu7ZM3QiQlEdm67uPGwhaBs1b?=
 =?us-ascii?Q?rGVK0lafit3Y0tAif9rCuQKR3VM1ocDX28e/myZc14QDVWwjk+kSAt7PORIk?=
 =?us-ascii?Q?vZQfxh4Qt+LG5DIh8iNCDvLbtFtwXGXO6RhftCPw4XUamtZe8oVbI+izphfI?=
 =?us-ascii?Q?KiJ5YyMU+FGK2MsCdSczabllM0CnLZQT067jdfT7bTQDvoP+WQ9Z9Ego6/LX?=
 =?us-ascii?Q?MHdl2yKTAv9Zd4iZf8aKLLlr6eA+lHWaervWuNC8hjZOwOReV6aUdB5WM4Yd?=
 =?us-ascii?Q?Gvewligfu6Er7lkApdaeaaIWPC/QxR5G+F0d7z+qcsJNta6Q/AAl9j8srZh0?=
 =?us-ascii?Q?f3r6iv802IFEQjRmOSg9dRWHZeCP2EFIrPZaU4RZdYLgdBRQlGYQ2jMPNWla?=
 =?us-ascii?Q?ut61+D0mkb5qEMrHiWEohAhCx+TSv8LGy+OKslwt6ZogZQUCCdNkkrSFBWJt?=
 =?us-ascii?Q?pOU5h3oJVQOFmr87T2uh+cgbAalQWjzGqGheiBWxnwknbalRI3Axc9eHoplZ?=
 =?us-ascii?Q?4dJlUMKBTgJeVIPZYWpVjJFv3CCnvRS/RTq08Vg5WgjkURJf+LIcMynAZWgd?=
 =?us-ascii?Q?WLrHmlTsnTL1TrDoTHIkErf0M6C9h3cw2S1HRsGl3xcWzFlnkouXih/hqApk?=
 =?us-ascii?Q?i+DIrxKiV8XDV4VMPrPXVysUYR9GiNUIRD3CBzCM7Q5Hjc9SaBQvz5NDNpps?=
 =?us-ascii?Q?hJjJ5uSZpJsRHBWGaEk0V44uK44S9m1AwzGbUcktHm8juvpbenBHJubEFnav?=
 =?us-ascii?Q?WMVbyGwnnRRnwcO4xpbebkMlihptjon1SKeQC9yjzNrobWVyjiWigB/+He53?=
 =?us-ascii?Q?Fmx5t3JAKRUUcP5eJvANcCF1QKtWihAa1riIfm7X7ta9hEWf5YASfC91NgXA?=
 =?us-ascii?Q?zHIeAvxVnGVluIhmmWoraqrBAAErztkR8KbmILkIMn9qvgzEflJos1ZFwh0O?=
 =?us-ascii?Q?RVxNEOA7SUxzNiagPvC/J33+GGJrWy2EYqjUVr5e5hNGE5TKE2SHU7zLKybw?=
 =?us-ascii?Q?p/wPkKVFMs9kzhR3onOVY3rQTzwphpDyL5LXXbXmXcH2YdvHlq+sULcodAXx?=
 =?us-ascii?Q?ZKqC7Wx4X3SBCysIbm/DhGebYa/scPDssOGmAew8hBQrpJMhqXZVDH+s6ttm?=
 =?us-ascii?Q?NuYmRJK48vH2MpKMgFBdxM0fD+6umZUnRtdAnFO2YtF2C+4de10gBSGpl+rR?=
 =?us-ascii?Q?/q8uFYrijLv0dnKOuJt1fnFdiDYGiOQGBlbTj/MyjJvL+PiSUdCCUZZih4fN?=
 =?us-ascii?Q?a/W4OGkbRonf1uR6dkrcmtNVGh1uK6zy0CjAgL4RApvQJaVuRWdAU6tgXwIr?=
 =?us-ascii?Q?NTaFyoWeTKq0qYI0gCPyE3fxgpSEcdUpf/3xUAbfO/PPCX1y9C8nBi/T/Rt8?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SnUsq7ROSidfPgKYgMk6ItBGQnGuJC8P8gQSn2Hlouauw2wtccvUIRnT/LS+s+ToAOsSoXl/MEajo7okpVj2b+Dbf5LbmBUUUWuTLeAmH6/zawz5aLGPVQl25Fg8JNGH7IFthBIoDUSeRjyW7LCKB5NoqIzLLo+VDDKn5e4EBzwOBWKmLQFquNMbUewps4M4xdHZJvM8rUfyjsgsiPLMde5qG0YhsSzcKitwgmA3sOziRUIKjH7K6cv9d1T8sbCqRvjfq4RKIwSf6J8PILjq4F9l9GjPttD83h373xO2J5OmwYi7CEwJ/hWHl6bqjIpUlvtrZaWHcusB7Q3aWwKz+Y5OURW9HNqvbx9KsOq4JecNiWVBtbejaFGtZLyuh/HwBLZKFV5W/R5dGTCeXkE5NHnDJguLk+kRN50NxbFQyxLb3LrNEHiUkycFSWKrSlR0s7ajgOrlnHHcXqw51oz2sGmhYxDIK+mepylTnqbcQTvGNqdeWfsBO5LQRxUOM/jNXc9BIMyzDLDEZUXiz3Rvd+HDO3qCPZ6sgEGKPY1tbS+faAjJnh6p5pVwu2P8ncezeCXCCmIeXwU9BEi7WIRZMg4JtAlZJudMGZmO8LiTo5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1110818d-7b19-49ad-f299-08ddd5ee90ab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:11:16.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygVpyR+muGsAgZTXE3fI/kXM8wjUpSnUKZsTYKv71Vw/H9HoP432m7Njc18kMNVmm0xGqPCZLGGWMUNJlk4sAIW8DrgWoKUeFnFOtK6sX+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDE2NiBTYWx0ZWRfXzcV+SP2QRhpC
 s9mlXvUd5GouC/RML3yTzVfrRcsmZ2rVlHT5GJQL6K5G1HTGu/b+PskvC8XHjye2wCsjfqkKWy2
 bx3is+vPNcqnMZ6bJ1bce+Y4VfqAqlPUqaK9HFIntFlZfjfp1Cb2cuPZPG+TfmLhiWhMwvY14P3
 suLj+Q4hHK00CDDbuZwt/3Ix2+34icHyaATP7ssAINcOAgXOuz6t8mTBIYW8OBOExH3VNdk4E5K
 PcI4FPOv2Ub5S+yf04iu+Tg4iJSfJTYM17ceUfiHJB9bqrOphxyvv0f7TJsv1je0IqdXrRLqUtb
 6B/tsZ/Yiq7Mm0/EWBr9ztT/AAUO4eVQCLuGVwDu4lM+YgbVh/C0IEMcM6DrVoy+4Sj5mMlEcfS
 X/I2N5Sny29W1pBFVJxFiDkGJxI/W5c7EQ5voMxJr3Qy3Tbn//qW1J0vkgiXJIB1m9b8b9qG
X-Proofpoint-ORIG-GUID: O6zgrHlHINxdSv5nj6FmuTGeCZ4HtDoX
X-Proofpoint-GUID: O6zgrHlHINxdSv5nj6FmuTGeCZ4HtDoX
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=68950869 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=ujTU9CBXGe7SlgIoRt4A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070

On Thu, Aug 07, 2025 at 09:41:24PM +0200, David Hildenbrand wrote:
> On 07.08.25 21:20, Lorenzo Stoakes wrote:
> > +cc Ryan for ContPTE stuff.
> >
> > On Thu, Aug 07, 2025 at 09:10:52PM +0200, David Hildenbrand wrote:
> > > Acked-by: David Hildenbrand <david@redhat.com>
> >
> > Thanks!
> >
> > >
> > > Wondering whether we could then just use the patch hint instead of going via
> > > the folio.
> > >
> > > IOW,
> > >
> > > return pte_batch_hint(ptep, pte);
> >
> > Wouldn't that break the A/D stuff? Also this doesn't mean that the PTE won't
> > have some conflicting flags potentially. The check is empirical:
> >
> > static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
> > {
> > 	if (!pte_valid_cont(pte))
> > 		return 1;
> >
> > 	return CONT_PTES - (((unsigned long)ptep >> 3) & (CONT_PTES - 1));
> > }
> >
> > So it's 'the most number of PTEs that _might_ coalesce'.
>
> No. If the bit is set, all PTEs in the aligned range (e.g., 64 KiB block)
> are coalesced. It's literally the bit telling the hardware that it can
> coalesce in that range because all PTEs are alike.

Sigh. So this is just yet another a horribly named function then. I was pretty
certain somebody explained it to me this way, but it's another reminder to never
trust anything you're told and to check everything...

My understanding of the word 'hint' does not align with what this function
does... perhaps there's some deeper meaning I'm missing...?

>
> The function tells you exactly how many PTEs you can batch from the given
> PTEP in that 64 KiB block.
>
> That's also why folio_pte_batch_flags() just jumps over that.

It would still be the case if it were the maximum it _could_ be if you could
ascertain if it _was_. But of course we don't, indeed.

>
> All you have to do is limit it by the maximum number.
>
> So likely you would have to do here
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 677a4d744df9c..58f9cf52eb6bd 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -174,16 +174,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
>  static int mremap_folio_pte_batch(struct vm_area_struct *vma, unsigned long
> addr,
>                 pte_t *ptep, pte_t pte, int max_nr)
>  {
> -       struct folio *folio;
> -
> -       if (max_nr == 1)
> -               return 1;
> -
> -       folio = vm_normal_folio(vma, addr, pte);
> -       if (!folio || !folio_test_large(folio))
> -               return 1;
> -
> -       return folio_pte_batch(folio, ptep, pte, max_nr);
> +       return min_t(unsigned int, max_nr, pte_batch_hint(ptep, pte));
>  }

Right except you're ignoring A/D bits no? Or what's the point of
folio_pte_batch()?

Why don't they matter here? I thought they did?

>
>  static int move_ptes(struct pagetable_move_control *pmc,
>
>
> And make sure that the compiler realizes that max_nr >= 1 and optimized away
> the min_t on !arm64.
>
> >
> > (note that a bit grossly we'll call it _again_ in folio_pte_batch_flags()).
> >
> > I suppose we could not even bother with checking if same folio and _just_
> check> if PTEs have consecutive PFNs, which is not very likely if different
> folio
> > but... could that break something?
> >
> > It seems the 'magic' is in set_ptes() on arm64 where it'll know to do the 'right
> > thing' for a contPTE batch (I may be missing something - please correct me if so
> > Dev/Ryan).
> >
> > So actually do we even really care that much about folio?
>
> I don't think so. Not in this case here where we don't use the folio for
> anything else.

I mean my suggestion is that we don't actually then really need the folio
at all, it's very unlkely we'll get contiguous PFNs. So we could have a
version of folio_pte_batch_flags() that doesn't need the folio...

Anyway strikes me all this should be stuff we look at after the hotfix,
better to get this landed so the regression is resolved.

>
>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

