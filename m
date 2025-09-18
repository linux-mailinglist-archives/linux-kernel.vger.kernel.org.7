Return-Path: <linux-kernel+bounces-812035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9476AB53200
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F0916C7E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD65B320CAC;
	Thu, 11 Sep 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l97K1xLu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yWtCW0/O"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDE317712;
	Thu, 11 Sep 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593389; cv=fail; b=NnwpnPG2mGhWRRnLiSJoOf5s6+6Lc4WbFsYI9MebWweY7bTyd7UAjHH5HY00BG3tLOlhno3S2Jw7bTH785KTNRMkXiKCc48S8vacCqKtwNlCHZuZN//PE/uhtJF5SQVpiLKMDhj9lNPC+xe3u6Wdq28rYYYbfiHBKMRrT/f+RWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593389; c=relaxed/simple;
	bh=wjW3S29imfsSNg3wFBvB1glpXqYSSIijNCVnvY59fzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZGQHlhzmkSkBa9wsroUlgqs80PDkC9eA+rrd0bHQE+wLiQ5CpwqwJbMvhMDXFmBGiPUfpX0EBCuhN2L0Lzl6ATaHEBZWG6CivU2W2ZtxiQLbAr0ypzcpMq63zUg+L0PHrxVhxuKRisSxwv1PD2ZwhmyhYJmfwDjn19bv8cMgJP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l97K1xLu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yWtCW0/O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BCKxWJ017208;
	Thu, 11 Sep 2025 12:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iML4AueKDmQ/WAI6DgMZbZ6ZEtVPj+KoeC05hz/77vk=; b=
	l97K1xLu7E4yDHiFp3+cmOIRS7EjLufJVNaTjyMB5t+8BJKr757HcO4NhJpR862O
	Gcap78oVTvDjdczUg0cCxOdXAzCVVrCGvrv8CG9R6tSmAHm4NexUIgqIyOhvq30Y
	xTyb2NhA9dGfb5wubW33V408jjcZv/ehT4httbkxuk4UhrMYsGpaf/xThFcYYwSK
	ntPVdC2od7r8REHlWkFy0yk5yeKGNHTOewfQNU5TNBXqSL4PSneDYtbqoLdzO+KE
	LW8zo0kokcxQWKtZ74rjDPbF8ocLTxNk9B10mq3f42DvJM7ALx4sLDdP2cCV0FUr
	byXE3L2R6uZ9Jt6i+f+c2w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgx50g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 12:21:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAbKRs002816;
	Thu, 11 Sep 2025 12:21:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdjw88e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 12:21:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7gukaixZPETiJS5/7lH6aChQrNGPPKFc0B7Zwmo01LhnToQQtB2PfzB5wVP8LoFO0u+/nsr+et2cEVLI2KkWV1qn75n1HeryrrNCYpNg2jrWZkbE6+dKOLT61kgdbveewwtuQhN4KP86PHU6UZnQW6EXsVLOSBESofdrmgPF5q2rG9kFDHAVbBU62kAN3XbowBi39w0J8ELjPlym5Ojs/mK3u5TzEEeAuUk8k7pCkPjjo4aQf7dtYCkRvITX/Lw1xMGMEtErkBXOBOj6Trf3durZe4tWJGQzpFsqonTzaHRddJFRLv3iuSkio+5W3XH3sW6qugo7ykfZ/poWrSX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iML4AueKDmQ/WAI6DgMZbZ6ZEtVPj+KoeC05hz/77vk=;
 b=bFwbnB61jXef7jrpzWTM5ZCHYX1qOs8N/qymbR1uGkXfxfmdtO/OqniouW42XeTVIbDD2R4h93UdI/1Mgcz7U/TGD/OV0+pVyuLOQ8yMaMQOOEM7vyMVtsFtQwvbyVZJjO17mO/NLgxF4z0uzcPO4xngClrzPz0t9MawDzmik05AF7Ah/J0v2jdyThlRYhe8+H/XsTUjJDA7PFD/gM5ess9jBtELTrcsAn3Yc1kISREpR9e3zPOS8g34z40oTqVp+vdomtfzAwgOfnlyUKmWXV0gWxSjg0aSUIf0/1LLcIcIFcG9fhOL6ruK3yatgLigqqm0WZ69J2IDYFusZyVZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iML4AueKDmQ/WAI6DgMZbZ6ZEtVPj+KoeC05hz/77vk=;
 b=yWtCW0/OWk3UnoD9E71nJj1bo/khCuT+YaoKaoUGEMaME5hBrY7RRmEoVPTJAI8q7R2kZJyIxxvfdVPQRIbAIdutqnZZwrFam+dP9drOFB8vRgTXT6XZWf9y8pUjv/ctgJBLJVP2fXAhH4Gs49XN9PbacLlUeSuTWiHKagMaQyA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6548.namprd10.prod.outlook.com (2603:10b6:806:2ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 12:21:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 12:21:42 +0000
Date: Thu, 11 Sep 2025 13:21:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
        corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
        baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
        tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com,
        jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v10 06/13] khugepaged: add mTHP support
Message-ID: <2046da27-1f4c-42f7-a403-082b6a97347c@lucifer.local>
References: <20250819134205.622806-1-npache@redhat.com>
 <20250819134205.622806-7-npache@redhat.com>
 <06d1b76f-039c-4d6f-a03d-9253b14b5e8f@lucifer.local>
 <CAA1CXcDPF5cHF8HEtc28AToyHpDeGLjgYD17X42U3ksiNAFvSQ@mail.gmail.com>
 <9df57e91-3909-4ec3-a039-3ca29f741775@lucifer.local>
 <CAA1CXcBZxk3BGu+i5=MWvQo+SPQYqHVrQswzhFQga6Y4McEbVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcBZxk3BGu+i5=MWvQo+SPQYqHVrQswzhFQga6Y4McEbVQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0600.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f55702f-feb8-4b8b-e1a7-08ddf12dc40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFhjZ3I2MVNmczBManlteGFlZ0JpRVJJMlNPVWNIWDNXWmRvSG43R2VvSUJ0?=
 =?utf-8?B?OWVJYkQ3YlFBTDJKOXNTQjBLU1NJQ3lFbHQ3cGRPZkJpSVdpZnZVeDgzWmpR?=
 =?utf-8?B?dEY4OHJKZW1LbEJPZEd5dlQ0ZEF2dHl0RzNyUnFEZERUM3ljMzNGUTBQTHNM?=
 =?utf-8?B?SVZYWTVRU2RLaGZzTkw4T25FR3BiN1YvSmhEbkNtRmNWa0hxaWI2UHVzcHBZ?=
 =?utf-8?B?MzlJa0sxUzhiazMyN1hDQjFGYzdoREV4Nkh3Tk5ib3RSVVdsZW5EaFdwZGlm?=
 =?utf-8?B?NkZibVpxbjdoYTA1R0JxdmJUZVRsQTUvZ2FTYXhmbXZvZFlKclo5VkxFbU5F?=
 =?utf-8?B?bHA0dCtJWmY3SGgzZ09XSWx1dU9qNktKRVZwWlZkMzJheUl4ODJhalZKQkhB?=
 =?utf-8?B?emhTZ3ZseUs3cytPVG0xZDZoOGxHclF5NVdsbkZ6NVR1d2lXQ3Vnd3RYUEx5?=
 =?utf-8?B?TENmaTBUenVnVmhTODlNc1R1ZG1keXVUakJXL0NnV09kSGVxUFZQcVB3SXps?=
 =?utf-8?B?QWtVUU4xMTBXTEFDeFRuSHh2aW1keldSZkZ6NnBINjQvdVpjTE5NRGNHd3JC?=
 =?utf-8?B?YU8yV0tsY3hmQ2ZJdGJ2ZWVRN3NCVlZNY1Z0TWFCMmc0eGNrcXE3RTVnMDlk?=
 =?utf-8?B?NndSZzViaFBYSVlWOE1FSldKbDdta0RVQTFzT2w3empwck8vRllpQU85Y1Z3?=
 =?utf-8?B?ZVhFSlJ2SHluQ0FuK1pUTVlUYXVtaS9FV0tZV2ZkRW1MK3RnQ2lGS3lmMldu?=
 =?utf-8?B?OWNpTzlBWmR3V2EzcUg2Q3FORGQ1NFZxL2EwRFRXUExJNCtmVnJNZ21sc2Zx?=
 =?utf-8?B?Z0thS0J0a0pNM1JsNEhMS2pCMkJzZEJNbVc1bDhNd3o1YzJ5bk1RQ2Y4U0xw?=
 =?utf-8?B?WVY2eXEza0dWL054NFJmUm4yc3dIM3VuM1FFYkQrV2FvaXY2NUhOWmpVcHNG?=
 =?utf-8?B?KytoZlVkcVh6QnpubnZqS0JPeWR0ek14Yjh3eE1lOFRhTFZyM3lOb2FONm1F?=
 =?utf-8?B?TUI2K0tUN0dHVUZUQVBsUmVBSjV4TFVhNVczNVUrWWlLcFNOUHQxQzdKZmM3?=
 =?utf-8?B?MCtyeXNZYkZKZ1BHYzUvRGhNZWl5VThKamd2ZVFVZC9TWURETi9nYW1HYmEr?=
 =?utf-8?B?OHloNGhzaGRJK0lUYjI5ZkdKMXlEU01MUmdGZWsvd3AwQUZKeSs5cnZ2ZytD?=
 =?utf-8?B?OUwzdUFEMGI0bUNteGNGMlBYazJOdkRieEFIMmhxSThmOWdaYldHRGlvWU4w?=
 =?utf-8?B?NHpHZ0JFSjFRMGZzVUlSQzVjRlowckZYSk1HZjNlOGEvemsrc0d4K0VXcFJT?=
 =?utf-8?B?TWpUSDN6cW9IdDZYNnVpcEZmcVpvSW1pdzFzQjBTMGMrTUVKNEpVQ0J5NS9o?=
 =?utf-8?B?Nys4L2RZT3RKSmdSYmpwR1FmVjRxT0JKQzVyWnFQeVBKaWt6WDBJZG02SUVa?=
 =?utf-8?B?WUlFeWtxMlFVTXFDVy80L2FPMk42M3Flc2NDN3R0S1QrVGppTkFLQXpIWnVK?=
 =?utf-8?B?YURkUWRyWWxrSWk4M2kwOWthencwRVYzcVc3TWdBbnpxNGVJSm02NjBhKy9o?=
 =?utf-8?B?WTM1QmUyZDE5azY2NCtteUgwSVhOYlJuODJ0MTJGTFhEM2xNamYzUnZkQmlI?=
 =?utf-8?B?STc3aEg0L1c4TUNsd1dsSW52WkErNWw0NFpSVml6dWl5WDdxNVpRdGlwMUlz?=
 =?utf-8?B?WXhKZE5FVFRaNkVVeHcwVkowVkdTc1B6NDB0NlVhTlN4TEV3c0E1Wk0vdUhi?=
 =?utf-8?B?eGV3VFFURXY0L25qUGFpK1RwaGIrTUJxUVF3MStTcmpiRTVneUh2aUwxMGYv?=
 =?utf-8?Q?/lqV8MogBEvVQmfdBCxXM4+x+pwGQt+z6zZ78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHZKS29KRHNMZzdFa09FZHJ1RUVacGQyM29BWUFFWWpSQ2hmOGZSNGdBdEdz?=
 =?utf-8?B?MWVGY053akxuREc2MThrT212NkgzN1lwbjFmell2Zzgwejl3NmpjaG1HTThF?=
 =?utf-8?B?NVZka2l5L3p4blJXVCt5bHFtbDM1Si9sRVBldU5LUFo5d2kvQUdaeEFDVEtz?=
 =?utf-8?B?bXVjSHFTUnQvaXRpQWRUOHpUdDIrdkwwbmltNURNUmI1QmM5czRUUXJhR2dv?=
 =?utf-8?B?OGs3THFRWnpUSGRTNGUxQmdaVU5OMVMvL1RuRzZMUytEWlltYjdjeTI3dk5H?=
 =?utf-8?B?VEpiRXNEMWlPeFNDTjlFOEFtOGRNSnNDcDcvUHV6YWlHcWV5cU12OXNOSkVB?=
 =?utf-8?B?Q25PcENobzEvTVVZWjNFSlJ1SGh1VDB2V3k4TnNSUlVUTjRNZU52TGZXWGR2?=
 =?utf-8?B?TFF3ZjZoTi93V21adHQvMitXbXJ1YlNEbkdndFdTTjIvZ2c4Zkd0dlIrelk1?=
 =?utf-8?B?U0Y0cGdmRVZlYU45UEdoTUNidjFxUlhGUnZvcnNDeGtvQXBxRGJsc2tVZUxH?=
 =?utf-8?B?VVNOYXRlWFdWSmQ2NHBDQitTRG1waFJEcC9hbVZvVVF5bWEyK0FzMG1GQlBE?=
 =?utf-8?B?SGVDSitvYlB6ZXh1R002WjNjZnErd3VLRHdhQmlIVDFBay8wYkRRLzdZUUlU?=
 =?utf-8?B?MERFK0pwalhvYjBlNjVTV0FnT25ZT0hQK005YjdpMXdoVENYSzEzV0xBV1Er?=
 =?utf-8?B?Y1BndjgzRzZOZXZaUWJWK01OTE5wdGxITGF5TWY5SUJ4MUwwaVI3UDdkYy9s?=
 =?utf-8?B?R0VpSGxrUzZncmxwUlk2Si9JbEIzTGVIcVZ4S2Q5azYzS24yM2thQnVURVJw?=
 =?utf-8?B?eGhNdVMxdVNqamYrdnluVTRrY3pSWS80U2ZFWXRaRHhhdFVLb1RjR3hNbk9p?=
 =?utf-8?B?NmhZSE9pdG9GV2taQ0dEUG5HU0J4bzZ2RzI3dnhqYTNzYXU0Q0d1SGhKT0pH?=
 =?utf-8?B?UzdOckh2VFNrOXc1emoxUGoyU3JRaWpQak9Bc1ZaSlVRMUdHWFAwS1JMSms2?=
 =?utf-8?B?VndTdDBGVkVydzFtemNSeEhrSS9aM0l1SDZYL1NZUEdDbWNwWWR3TkNlTVdY?=
 =?utf-8?B?c2hMa1U1M0NzVUxNdXZ0YnNkWTNvOG81Tit0V2h6aUdiVXYzSG1FSjBTajBz?=
 =?utf-8?B?R0R6M3hwRUZpbnVIZkdpUVJ0WnVvOC9RdHRKZUd0ZjUzdEk4K2daTklydEVh?=
 =?utf-8?B?aGJ3SHBYNXBPS0tuY0FmdUFWSzg2Rmk5ZlJJaXViUkFIYTduVzRicnR5VVBI?=
 =?utf-8?B?ZkkvNm5VNXpER1RCaU1hOUlrRUcyQ0RkZ3lLckFxU21OVXcrUGl3WVI4OVlU?=
 =?utf-8?B?UTZUbmN5TG8wZ2p6Q1hQckFQWW1XOTlhaVhkOEZUNVkrVjl6YjVlQzdHb2pz?=
 =?utf-8?B?UFpRRDY3TzcwbnJ2dWF4NERKczM4anMxVkhRa1JkcHBzcTlmZzdFL09TaU44?=
 =?utf-8?B?WGNBVHAxc21DaWpUYngvL0U1SzFEWm4xeXFsMFNveW52WjNrTGpSYks5b2My?=
 =?utf-8?B?UUZzU0xVWmRWSG01bFFFUmhaaCsrdjRpc2VIcHYxNTFEU1FIRzlkUFJGUkZK?=
 =?utf-8?B?YUdMN3JSaW1GeklVUGFIVVpIallWM3g4dytiZTJKcC8yTThQUGh1ek5RNVVl?=
 =?utf-8?B?VWhIMU5QUFd1ekxBWjVGcVhmR0ljbStZQ3lERnhHaWpzU2g0em4vd1k3NWs3?=
 =?utf-8?B?UXdsUE1XTFYySTdXTTZxeFU2SlU3cXcxWGJsbjd5a1BPMWYyUSs2VE1BbFFG?=
 =?utf-8?B?eUc5OFVPS05wMENwd0s0U2FaTEJRWTNZV09uNlRqQnpoNGVjK3RMVElyN0lv?=
 =?utf-8?B?WjJ5ZE5kQzR2OGxDOVd6MWxLbUZMaEQ2a25JODdSVmxydXpzQTJvVTdZNE5a?=
 =?utf-8?B?aklIMkFQaWw2aW9EWE9pYjdqZm15NmJuTU9FYVE0RGRXNTJRYWhJNkRtQUVZ?=
 =?utf-8?B?ZXo3WXVQNU1Pakc5QTR0YXVVN2RqaWN3RTR4aEpYaHZLdnNHZHZBMXp6L3dr?=
 =?utf-8?B?NWNGNUc5OTR5aHNzUjRSWHJSUm5TTGFZQzYwM1dWQmtDL0tFSHlSbFhSVWhB?=
 =?utf-8?B?eGViSE85S2Jnemo2SW03SEdQWFF0cEhxM3BnSUJKMjJGZUNnYzcxNGFQZjNk?=
 =?utf-8?B?aTBqWlR4ckdWdHJXeUZVY0d5R20yTG84MXJiKzZWY3UzTGZSaFlFZ3N5ODlE?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s6C2RlIoQuDahdsuyeXPj4SrQLYshTcAXIjpSlIfmOc/Q/CedsJeTW+dMuxUUYBiUzSIudmKbE87Se6OXXNgH4H5duXDzXECLT5LE8fk+4Szuk8UG6rIgdp9o2SPqjITFKLvrBArMzZppPNVEABPFBuLV1mAp+Jf8XxceY/l//IagiMgRuh9sgrFk08sxNL433OMNYYKm2hkPIBXEGo9e6Hyv696Yz5QD01aOsD319/ah71IpC7OdxiGMXnHvkShfUmUFnUsJH+B8DTKJsAj5mggeTUnp5iiWlVOpLAVFBgthMhsY4N7CNx7UAcXAMcoAk8xpYSALo5y/XFxHo3+cfwIwx2GtQNl5Xr5FQV5bOtFrN8IbbQKdrl4b+CAkGLmepdl4069IVOahMswc7Siz1hyrxpK3jSDhhfXhmAFR16/FHY6o8KXUSkXF5PvJSye3b8MLTL9QKyeoEGC2TKj5F0foeedheAL3vjIylqsuVf10VYpGqTTDEJXAVz/k3f/n48c7i4+YtVikAv8mrjJN4llYaiqsdWO3rw6L7luBypS0IuKPifHDqPUOpfloXpc/DGOG2NdiI6DXOLxzHKrheJvmY1oOEt8xBM1udUepww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f55702f-feb8-4b8b-e1a7-08ddf12dc40d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 12:21:42.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCbXkjbg+BXFlES/PcPzh2Lev9dmOsxoxaTzGDss29+lA1AKqvONJwvcEiF3Pfhuprhr3P/Tz5GqVmVROQuFcfU0gxw7kQ8vmFS2+ViCIvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110112
X-Proofpoint-ORIG-GUID: YHYQ2p60VgSElV0oY5A7aq4i62Xihjvh
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c2bee0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=20KFwNOVAAAA:8 a=1ixANU9LLFSxubNse7EA:9 a=NipKayHm-OzkSXiL:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gmshbCpD-_wA:10 cc=ntf awl=host:12084
X-Proofpoint-GUID: YHYQ2p60VgSElV0oY5A7aq4i62Xihjvh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX68LPsczx98WZ
 dTP/qm7RdNxTuj8EZY5vAj06AHBSOJueDVghAujSNCfuh8+mQO6WCfqmVEUyvwUSa3NKGjJvYS6
 oxY34kbj03MoxD7GAcwWSQnQcLK2dlhZquuRJxUFCphkocfnP3FFzMP+AEweuU7lJwVCrKL18Lo
 hNwI3ho7L92Jt1VQ9ZESBgimfeGBxvFKISUBPyoPiObWbB6abtL6lLovQq9vvYXzOCw1zFmEl+l
 GaP5JTH7fpIACaQAsVy2e2Jdzl0lDy2XQgAGiPFZef1GoFVqxW1JM2J81x4RMFsPp5ZE1CKOVYZ
 xFAiUx27yETHyx7yfaq6Gb1UpXSLI+6WVA5QKkbmSjDjJr63Qv/1gPKVKmwvWhOe3TrGbtDslcB
 GdrFdTcg97F+C6smmAiHSa6dFKnL2Q==

On Mon, Sep 08, 2025 at 04:29:51PM -0600, Nico Pache wrote:
> On Fri, Sep 5, 2025 at 4:15 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > You've not responded to a ton of comments, I'm guesing I should assume in
> > those cases you're acking the comments implicitly? :) Do let me know.

> Yes! If they are obvious nits, then implicit ack.

OK that's fine, thanks!

>
> Sorry I wrote my response over a couple of days while making changes
> based on the review and trying to figure out a solution to the "creep"
> issue, and forgot to thoroughly review all the comments before sending
> this out. I'll make sure to go through it again.

Thanks!

> >
> > On Tue, Sep 02, 2025 at 02:12:38PM -0600, Nico Pache wrote:
> > > On Wed, Aug 20, 2025 at 12:30 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Tue, Aug 19, 2025 at 07:41:58AM -0600, Nico Pache wrote:
> > > > > Introduce the ability for khugepaged to collapse to different mTHP sizes.
> > > > > While scanning PMD ranges for potential collapse candidates, keep track
> > > > > of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
> > > > > represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. If
> > > > > mTHPs are enabled we remove the restriction of max_ptes_none during the
> > > > > scan phase so we don't bailout early and miss potential mTHP candidates.
> > > > >
> > > > > A new function collapse_scan_bitmap is used to perform binary recursion on
> > > > > the bitmap and determine the best eligible order for the collapse.
> > > > > A stack struct is used instead of traditional recursion. max_ptes_none
> > > > > will be scaled by the attempted collapse order to determine how "full" an
> > > > > order must be before being considered for collapse.
> > > > >
> > > > > Once we determine what mTHP sizes fits best in that PMD range a collapse
> > > > > is attempted. A minimum collapse order of 2 is used as this is the lowest
> > > > > order supported by anon memory.
> > > > >
> > > > > For orders configured with "always", we perform greedy collapsing
> > > > > to that order without considering bit density.
> > > > >
> > > > > If a mTHP collapse is attempted, but contains swapped out, or shared
> > > > > pages, we don't perform the collapse. This is because adding new entries
> > > > > can lead to new none pages, and these may lead to constant promotion into
> > > > > a higher order (m)THP. A similar issue can occur with "max_ptes_none >
> > > > > HPAGE_PMD_NR/2" due to the fact that a collapse will introduce at least 2x
> > > > > the number of pages, and on a future scan will satisfy the promotion
> > > > > condition once again.
> > > > >
> > > > > For non-PMD collapse we must leave the anon VMA write locked until after
> > > > > we collapse the mTHP-- in the PMD case all the pages are isolated, but in
> > > > > the non-PMD case this is not true, and we must keep the lock to prevent
> > > > > changes to the VMA from occurring.
> > > > >
> > > > > Currently madv_collapse is not supported and will only attempt PMD
> > > > > collapse.
> > > >
> > > > Yes I think this has to remain the case unfortunately as we override
> > > > sysfs-specified orders for MADV_COLLAPSE and there's no sensible way to
> > > > determine what order we ought to be using.
> > > >
> > > > >
> > > > > Signed-off-by: Nico Pache <npache@redhat.com>
> > > >
> > > > You've gone from small incremental changes to a huge one here... for the
> > > > sake of reviewer sanity at least, any chance of breaking this up?
> > > I had this as two patches (one for the bitmap and one for implementing
> > > it), but I was asked to squash them :/
> >
> > Yeah it makes sense to combine those two, but maybe there's a better way of
> > splitting things out.

> I'll give it a shot but most of this patch belongs together in my eyes.

OK, let's see what's most sensible.

> >
> > > >
> > > > > ---
> > > > >  include/linux/khugepaged.h |   4 +
> > > > >  mm/khugepaged.c            | 236 +++++++++++++++++++++++++++++--------
> > > > >  2 files changed, 188 insertions(+), 52 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > > > > index eb1946a70cff..d12cdb9ef3ba 100644
> > > > > --- a/include/linux/khugepaged.h
> > > > > +++ b/include/linux/khugepaged.h
> > > > > @@ -1,6 +1,10 @@
> > > > >  /* SPDX-License-Identifier: GPL-2.0 */
> > > > >  #ifndef _LINUX_KHUGEPAGED_H
> > > > >  #define _LINUX_KHUGEPAGED_H
> > > > > +#define KHUGEPAGED_MIN_MTHP_ORDER    2
> > > >
> > > > I guess this makes sense as by definition 2 pages is least it could
> > > > possibly be.
> > > Order, so 4 pages, 16kB mTHP
> >
> > Right, misread that! :) sorry. I guess then in fact there is no such thing
> > as an order-1 mTHP? I did wonder how useful that'd be so makes more sense
> Anon memory does not support order 1 THPs, im not sure if there are
> any plans do so either.

Yeah right, this was me being dumb!

> >
> > > >
> > > > > +#define KHUGEPAGED_MIN_MTHP_NR       (1 << KHUGEPAGED_MIN_MTHP_ORDER)
> > > >
> > > > Surely KHUGEPAGED_MIN_NR_MTHP_PTES would be more meaningful?
> > > Sure!
> >
> > Thanks!
> >
> > > >
> > > > > +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER))
> > > >
> > > > This is confusing - size of what?
> > > We need it like this due to ppc64 (and maybe others?), it used to be
> > > based on PMD_ORDER, but some arches fail to compile due to the PMD
> > > size only being known at boot time.
> >
> > That really sucks. Do please put this context in a comment though (see
> > below for more discussion on this).
> Ok, will do. although with my most recent changes we might just be
> able to get rid of this all together.
> >
> > >
> > > This compiles to 9 on arches that have 512 ptes.
> > > so 1 << (9 - 2) == 128
> >
> > What I'm saying is - what is this expressed in? There's no information on
> > that here.

> In my next implementation its probably going to be gone, but what it
> indicates is the bitmap size (128), where each bit equals a range of 4
> pages. 128 *4 = 512.

OK thanks. Let's see what the new implementation is like.

> > > >
> > > > > +     DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> > > >
> > > > Same comment as above obviously. But also this is kind of horrible, why are
> > > > we putting a copy of this entire bitmap on the stack every time we declare
> > > > a cc?
> > > The temp one is used as a scratch pad, Baolin also finds this useful
> > > in his file mTHP collapse useful for another use as well.
> >
> > Saying 'scratch pad' is really just saying 'temporary' using different
> > words :) this isn't hugely helpful.

> When doing the "recursion", there is no easy way to read the bitmap
> between bits N0-N1, so we must manipulate it to extract that data;
> however, we still want to preserve the original state of the bitmap.
> The temp_bitmap is used to do these bit manipulations while not
> destroying the original state. I will see if there's a better way to
> read arbitrary ranges of the bitmap so we dont need to have two
> copies, but IIRC there is not-- I might have to expand the bitmap API
> to include this.

It at the very least needs a better name.

> >
> > If we _need_ this we should give this a better name, and I also don't know
> > why we need this on the stack for all collapse_control users. Can't you
> > just have your 'scratch pad' local to the function that needs it or passed
> > as a pointer?
> If I cant find a solution to the problem above I will look into moving
> it to the local stack.

Yeah, maybe not necessary after I realised that in fact we don't put cc on the
stack... :)

It does definitely need a better name, however...

> >
> > I'm sure it'd be useful to somebody to stick various temporary things in
> > vm_area_struct for instance, but it'd be hugely egregious to do so...

> The reason I didnt see this as a huge issue, is there is only one
> global CC that is reused for all khugepaged runs. It's a one time
> allocation and does not scale.

Yeah, see below, I realised cc isn't on the stack so. Fine :)

> >
> > >
> > > In general khugepaged always uses the same CC, so it doesn't not
> > > having to constantly allocate this.
> >
> > You're putting a LOT of data on the stack, and kernel stacks are very
> > delicate, I'm quite concerned about this.
> >
> > BEFORE:
> >
> > struct collapse_control {
> >         bool                       is_khugepaged;        /*     0     1 */
> >
> >         /* XXX 3 bytes hole, try to pack */
> >
> >         u32                        node_load[64];        /*     4   256 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         /* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
> >         nodemask_t                 alloc_nmask;          /*   264     8 */
> >
> >         /* size: 272, cachelines: 5, members: 3 */
> >         /* sum members: 265, holes: 2, sum holes: 7 */
> >         /* last cacheline: 16 bytes */
> > };
> >
> > 272 bytes.
> >
> > AFTER:
> >
> > struct collapse_control {
> >         bool                       is_khugepaged;        /*     0     1 */
> >
> >         /* XXX 3 bytes hole, try to pack */
> >
> >         u32                        node_load[64];        /*     4   256 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         /* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
> >         nodemask_t                 alloc_nmask;          /*   264     8 */
> >         long unsigned int          mthp_bitmap[2];       /*   272    16 */
> >         long unsigned int          mthp_bitmap_temp[2];  /*   288    16 */
> >         struct scan_bit_state      mthp_bitmap_stack[128]; /*   304   512 */
> >
> >         /* size: 816, cachelines: 13, members: 6 */
> >         /* sum members: 809, holes: 2, sum holes: 7 */
> >         /* last cacheline: 48 bytes */
> > };
> >
> > 816 bytes.
> >
> > So you're roughly tripling the size of this struct and making this a thing
> > in all callstacks that reference collapse_control.
> >
> > Kernel stack is a _super_ finite resource.
> >
> > I mean I can't really review your stack implementation thing until you've
> > added a comment to help me understand what you are doing there (sorry but
> > it's just too fiddly for me to first principles it), but I wonder if we
> > truly need to be doing this?
> >
> > I wonder if we can just put this into somewhere allocated...

OK hang on... HANG ON :) have I been dumb here?

Sorry... this isn't on the stack is it?

It just looks like, from the function signatures _that it should be_... or at
least as per how we usually implement xxx_control structs.

OK that's really good. So you can ignore this bit... Probably we're fine with
the size being larger.

I see we kmalloc() a cc in madvise_collapse() (fine) or have it static in
khugepaged_collapse_control.

So ok. Never mind :)

> > > > >
> > > > >  static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
> > > > >                             int referenced, int unmapped,
> > > > > -                           struct collapse_control *cc)
> > > > > +                           struct collapse_control *cc, bool *mmap_locked,
> > > > > +                           unsigned int order, unsigned long offset)
> > > > >  {
> > > > >       LIST_HEAD(compound_pagelist);
> > > > >       pmd_t *pmd, _pmd;
> > > > > -     pte_t *pte;
> > > > > +     pte_t *pte = NULL, mthp_pte;
> > > > >       pgtable_t pgtable;
> > > > >       struct folio *folio;
> > > > >       spinlock_t *pmd_ptl, *pte_ptl;
> > > > >       int result = SCAN_FAIL;
> > > > >       struct vm_area_struct *vma;
> > > > >       struct mmu_notifier_range range;
> > > > > +     unsigned long _address = address + offset * PAGE_SIZE;
> > > >
> > > > This name is really horrible. please name it sensibly.
> > > >
> > > > It feels like address ought to be consistently the base of the THP or mTHP
> > > > we wish to collapse, and if we need something PMD aligned for some reason
> > > > we should rename _that_ to e.g. pmd_address.
> > > >
> > > > Orrr it could be mthp_address...
> > > >
> > > > Perhaps we could just figure that out here and pass only the
> > > > address... aligning to PMD boundary shouldn't be hard/costly.
> > > >
> > > > But it may indicate we need further refactorisation so we don't need to
> > > > paper over cracks + pass around a PMD address to do things when that may
> > > > not be where the (m)THP range begins.
> > > Ok i'll rename them, but we still need to know the PMD address as we
> > > rely on it for a few key operations.
> > > Can we leave _address and rename address to pmd_address?
> >
> > No, we absolutely cannot leave _address as '_address', that's terrible and
> > I'm just not going to live with that.
> >
> > I know it's trivial, but it's just such a horrid naming convention.

> Ok Ill rename it to something else!

Thanks!

> >
> > > >
> > > > >
> > > > >       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> > > > >
> > > > > @@ -1155,16 +1170,20 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
> > > > >        * The allocation can take potentially a long time if it involves
> > > > >        * sync compaction, and we do not need to hold the mmap_lock during
> > > > >        * that. We will recheck the vma after taking it again in write mode.
> > > > > +      * If collapsing mTHPs we may have already released the read_lock.
> > > > >        */
> > > > > -     mmap_read_unlock(mm);
> > > > > +     if (*mmap_locked) {
> > > > > +             mmap_read_unlock(mm);
> > > > > +             *mmap_locked = false;
> > > > > +     }
> > > > >
> > > > > -     result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> > > > > +     result = alloc_charge_folio(&folio, mm, cc, order);
> > > > >       if (result != SCAN_SUCCEED)
> > > > >               goto out_nolock;
> > > > >
> > > > >       mmap_read_lock(mm);
> > > > > -     result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
> > > > > -                                      BIT(HPAGE_PMD_ORDER));
> > > > > +     *mmap_locked = true;
> > > > > +     result = hugepage_vma_revalidate(mm, address, true, &vma, cc, BIT(order));
> > > >
> > > > I mean this is kind of going back to previous commits, but it's really ugly
> > > > to pass a BIT(xxx) here, is that really necessary? Can't we just pass in
> > > > the order?
> > > Yes and no... currently we only ever pass the bit of the current order
> > > so we could get away with it, but to generalize it we want the ability
> > > to pass a bitmap of the available orders. Like in the case of future
> > > madvise_collapse support, we would need to pass a bitmap of possible
> > > orders.
> >
> > Can we just change that when we need it?

> Sure, it was more so that I generalized it for madv_collapse and
> khugepaged, but then we dropped madv_collapse support, and I never
> undid the change.

Thanks, I think best to undo it until we need it.

> >
> > 'Future proofing' for an possible future implementation detail is just not
> > how we should implement things.
> >
> > Right now we don't do that, so let's just pass the order. If in future we
> > want to change it we can.

> ack

Thanks!

> > > >
> > > > >       if (pte) {
> > > > > -             result = __collapse_huge_page_isolate(vma, address, pte, cc,
> > > > > -                                                   &compound_pagelist,
> > > > > -                                                   HPAGE_PMD_ORDER);
> > > > > +             result = __collapse_huge_page_isolate(vma, _address, pte, cc,
> > > > > +                                                   &compound_pagelist, order);
> > > > >               spin_unlock(pte_ptl);
> > > > >       } else {
> > > > >               result = SCAN_PMD_NULL;
> > > > >       }
> > > > >
> > > > >       if (unlikely(result != SCAN_SUCCEED)) {
> > > > > -             if (pte)
> > > > > -                     pte_unmap(pte);
> > > >
> > > > Why are we removing this?
> >
> > You're missing some of the comments, I'm guesing for most of the smaller
> > stuff you're just implicitly acking them but this one was a question :)

> Ah, for some of your reviews you comment, then later when you see
> another piece you say something like "ah ok this is why", for a lot of
> these cases I might have skipped replying because it seems that you
> figured it out.

Sure it's fine, I'm just sort of trying to draw your attention to stuff that
needs some discussion :)

There's a lot here so it's easy to lose track from both sides (I may very well
be repeating myself, apologies if so!)

> For this one we moved the pte_unmap further down, because if not, we
> could be prematurely unmapping a PTE, which is later referenced during
> the mTHP collapse, which was not the case when we only did PMD
> collapse.

Ack!

> >
> > > >
> > > > >               spin_lock(pmd_ptl);
> > > > >               BUG_ON(!pmd_none(*pmd));
> > > > >               /*
> > > > > @@ -1255,17 +1272,17 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
> > > > >       }
> > > > >
> > > > >       /*
> > > > > -      * All pages are isolated and locked so anon_vma rmap
> > > > > -      * can't run anymore.
> > > > > +      * For PMD collapse all pages are isolated and locked so anon_vma
> > > > > +      * rmap can't run anymore
> > > > >        */
> > > > > -     anon_vma_unlock_write(vma->anon_vma);
> > > > > +     if (order == HPAGE_PMD_ORDER)
> > > > > +             anon_vma_unlock_write(vma->anon_vma);
> > > >
> > > > Hmm this is introducing a horrible new way for things to go wrong. And
> > > > there's now a whole host of terrible error paths that can go wrong very
> > > > easily around rmap locks and yeah, no way we cannot do it this way.
> > > >
> > > > rmap locks are VERY sensitive and the ordering of the locking matters a
> > > > great deal (see top of mm/rmap.c). So we have to be SO careful here.
> > > >
> > > > I suggest you simply have a boolean 'anon_vma_locked' or something like
> > > > this, and get rid of these horrible additional code paths and the second
> > > > order == HPAGE_PMD_ORDER check.
> > > >
> > > > We'll track whether or not the lock is held and thereby needs releasing
> > > > that way instead.
> >
> > You've not responded to this suggestion re: refactoring here.
> I think if anything this refactoring adds complexity... we simply

I don't really think it does.

We have an open-coded condition that you just have to happen to know when
reading the code determines whether a lock is held or released.

Or, we could just have a boolean that explicitly encodes this.

> postpone the unlock we normally do, to later if its mTHP collapse,
> because we havent fully isolated all the pages (like we do in the PMD
> case).
> We arent doing anything extremely different other than hold the
> already held lock for a little longer. We would still need these order
> == HPAGE_PMD_ORDER checks, but just be flipping a flag that says its
> locked, essentially adding more complexity for the same outcome.

Yeah, I don't agree sorry.

I really do not like this, we should have the boolean.

> >
> > I'm really not a fan of us arbitrarily messing with rmap locks like this,
> > and we should very carefully keep track of whether we have/have not
> > released them.
> Its important to note, the code was already doing this, as I stated
> above, we simply hold it for longer because we haven't isolated all
> the pages.
> >
> > Again rmap locking is a dangerous area, I've got personal experience of
> > this (see top of mm/rmap.c for an indication of complexity here as well as
> > https://kernel.org/doc/html/latest/mm/process_addrs.html).
> >
> > > >
> > > > Also, and very importantly - are you 100% sure you can't possibly have a
> > > > deadlock or issue beyond this point if you don't release the rmap lock?
> > > I double checked, this was added as a fix to an issue Hugh reported.
> >
> > > The gap between these callers is rather small, and I see no way that
> > > it could skip the lock/unlock cycle.
> >
> > We're going to need more than this to be confident, you need to clearly
> > justify why we won't encounter issues this way.
>
> // WE ARE HOLDING THE LOCK ALREADY
> if (order == HPAGE_PMD_ORDER) //ONLY RELEASE IF ITS PMD
>         anon_vma_unlock_write(vma->anon_vma);
>
>     result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
>                        vma, _address, pte_ptl,
>                        order, &compound_pagelist);
>     if (unlikely(result != SCAN_SUCCEED))
>         goto out_unlock_anon_vma; //LETS RELEASE THE LOCK IF WE FAIL
>
> if (order == HPAGE_PMD_ORDER) {
>       ...
>      // NO EXIT PATHS
>     } else { /* mTHP collapse */
>         ...
>        // NO EXIT PATHS
>     }
>
>     folio = NULL;
>
>     result = SCAN_SUCCEED;
> out_unlock_anon_vma:
>     if (order != HPAGE_PMD_ORDER)
>         anon_vma_unlock_write(vma->anon_vma); //RELEASE IF IT WASN'T
> RELEASED EARLIER

Thanks for this, but I think this only makes my point re: a booelan: now you
have to just realise at each point in the code that the open-coded condition is
what determines whether the lock is held or not.

A boolean that does this is a _lot_ clearer.

>
> Not sure if this is the verification you are looking for, but I really
> dont see how this could go wrong, or how this is any different than
> what the khugepaged code is already doing in a number of places.

Existing khugepaged code is not a good guideline for future development :) the
code is not always entirely delightful there or in huge_memory.c either...

> >
> > > >
> > > > > +             update_mmu_cache_range(NULL, vma, _address, pte, (1 << order));
> > > > > +
> > > > > +             smp_wmb(); /* make pte visible before pmd */
> > > >
> > > > Can you give some detail as to why this will work here and why it is
> > > > necessary?
> >
> > > Other parts of the kernel do it when setting ptes before updating the
> > > PMD. I'm not sure if it's necessary, but better safe than sorry.
> >
> > Unfortunately this is a _totally_ unacceptable justification. We can't put
> > in barriers based on 'better safe than sorry'. You need to analysis this
> > and determine whether or not it's necessary.
> >
> > So the comment in pmd_install() seems to give an indication:
> >
> >         if (likely(pmd_none(*pmd))) {   /* Has another populated it ? */
> >                 mm_inc_nr_ptes(mm);
> >                 /*
> >                  * Ensure all pte setup (eg. pte page lock and page clearing) are
> >                  * visible before the pte is made visible to other CPUs by being
> >                  * put into page tables.
> >                  *
> >                  * The other side of the story is the pointer chasing in the page
> >                  * table walking code (when walking the page table without locking;
> >                  * ie. most of the time). Fortunately, these data accesses consist
> >                  * of a chain of data-dependent loads, meaning most CPUs (alpha
> >                  * being the notable exception) will already guarantee loads are
> >                  * seen in-order. See the alpha page table accessors for the
> >                  * smp_rmb() barriers in page table walking code.
> >                  */
> >                 smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
> >                 pmd_populate(mm, pmd, *pte);
> >                 *pte = NULL;
> >         }
>
> So this seems to indicate we do need it for some rare edge
> cases/arches, and that's why it exists in other callers too.

Yup, so let's be explicit and say something like 'see pmd_install()' or
something.

Open-coded 'just have to know' stuff is just something we want to avoid in
general.

> >
> > > >
> > > > > +             pmd_populate(mm, pmd, pmd_pgtable(_pmd));
> > > >
> > > > If we're updating PTE entriess why do we need to assign the PMD entry?
> >
> > > We removed the PMD entry for GUP_fast reasons, then we reinstall the
> > > PMD entry after the mTHP is in place. Same as for PMD collapse.
> >
> > OK a comment to this effect would be useful.
> Ok ill add a small comment. feel free to take a look at the failure
> handling around __collapse_huge_page_isolate to see another example of
> this. We remove the pmd (pmdp_collapse_flush), then if the isolation
> fails, we repopulate the original PMD. In the mTHP case, because we
> are not installing a new PMD, we still remove the PMD (for gup-fast
> reasons), modify the PTE entries within that PMD, then reinstall the
> original PMD. This prevent GUP-fast from accessing these PTEs/PMD mid
> change.

Thanks. We need this kind of context in the code.

> >
> > > >
> > > > > +             spin_unlock(pmd_ptl);
> > > > > +     }
> > > >
> > > > This deeply, badly needs to be refactored into something that both shares
> > > > code and separates out these two operations.
> > > >
> > > > This function is disgustingly long as it is, and that's not your fault, but
> > > > let's try to make things better as we go.
> > > >
> > > > >
> > > > >       folio = NULL;
> > > > >
> > > > >       result = SCAN_SUCCEED;
> > > > > +out_unlock_anon_vma:
> > > > > +     if (order != HPAGE_PMD_ORDER)
> > > > > +             anon_vma_unlock_write(vma->anon_vma);
> > > >
> > > > Obviously again as above, we need to simplify this and get rid of this
> > > > whole bit.
> > > >
> > > > >  out_up_write:
> > > > > +     if (pte)
> > > > > +             pte_unmap(pte);
> > > >
> > > > OK I guess you moved this from above down here? Is this a valid place to do this?
> > > Yes if not we were potentially unmapping a pte early.
> > > >
> > > > >       mmap_write_unlock(mm);
> > > > >  out_nolock:
> > > > > +     *mmap_locked = false;
> > > >
> > > > This is kind of horrible, we now have pretty mad logic around who sets
> > > > mmap_locked and where.
> > > >
> > > > Can we just do this at the call sites so we avoid that?
> > > >
> > > > I mean anything we do with this is hideous, but that'd be less confusing It
> > > > hink.
> > > >
> > > > >       if (folio)
> > > > >               folio_put(folio);
> > > > >       trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
> > > > >       return result;
> > > > >  }
> > > > >
> > > > > +/* Recursive function to consume the bitmap */
> > > >
> > > > Err... please don't? Kernel stack is a seriously finite resource, we do not
> > > > want recursion at all.
> > > >
> > > > But I'm not actually seeing any recursion here? Am I missing something?
> > > >
> >
> > Yup this was before I realised it was an iterative implementation :)
> >
> > Though we are putting load on the stack anyway...

> Ill see if I can shrink this load!

Thanks!

Things are less problematic with cc not on the stack (my mistake that, sorry),
but obviously anything that could help reduce the stack usage here is good
anyway.

> >
> > > > > +static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
> > > > > +                     int referenced, int unmapped, struct collapse_control *cc,
> > > > > +                     bool *mmap_locked, unsigned long enabled_orders)
> > > >
> > > > This is a complicated and confusing function, it requires a comment
> > > > describing how it works.
> > > Ok will do!
> >
> > This is _VERY_ key - I need this I think to be able to sanely review this
> > code.
> ack, im also simplifying it a bit in the next iteration.

Thanks, much appreciated :)

I do wonder if this could be separate, but perhaps not.

> > > > >  static int collapse_scan_pmd(struct mm_struct *mm,
> > > > >                            struct vm_area_struct *vma,
> > > > >                            unsigned long address, bool *mmap_locked,
> > > > > @@ -1307,31 +1406,60 @@ static int collapse_scan_pmd(struct mm_struct *mm,
> > > > >  {
> > > > >       pmd_t *pmd;
> > > > >       pte_t *pte, *_pte;
> > > > > +     int i;
> > > > >       int result = SCAN_FAIL, referenced = 0;
> > > > >       int none_or_zero = 0, shared = 0;
> > > > >       struct page *page = NULL;
> > > > >       struct folio *folio = NULL;
> > > > >       unsigned long _address;
> > > > > +     unsigned long enabled_orders;
> > > > >       spinlock_t *ptl;
> > > > >       int node = NUMA_NO_NODE, unmapped = 0;
> > > > > +     bool is_pmd_only;
> > > > >       bool writable = false;
> > > > > -
> > > > > +     int chunk_none_count = 0;
> > > > > +     int scaled_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER);
> > > > > +     unsigned long tva_flags = cc->is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
> > > > >       VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> > > > >
> > > > >       result = find_pmd_or_thp_or_none(mm, address, &pmd);
> > > > >       if (result != SCAN_SUCCEED)
> > > > >               goto out;
> > > > >
> > > > > +     bitmap_zero(cc->mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> > > > > +     bitmap_zero(cc->mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> > > >
> > > > Having this 'temp' thing on the stack for everyone is just horrid.
> > > As I mention above this serves a very good purpose, and is also
> > > expanded in another series by Baolin to serve another similar purpose
> > > too.
> >
> > Yeah, I'm not hugely convinced :) responded there.
> >
> > I can probably give more useful feedback on this once the big comment is
> > added!

> Ok! hopefully I find a solution so I can remove the temp one.

Thanks!

Again sorry to separate this out (+ force more review back-and-forth), it's just
the only way I can sensibly review this I think!

> > > > > +
> > > > > +             _pte = pte + i;
> > > > > +             _address = address + i * PAGE_SIZE;
> > > > >               pte_t pteval = ptep_get(_pte);
> > > > >               if (is_swap_pte(pteval)) {
> > > > >                       ++unmapped;
> > > > > @@ -1354,10 +1482,11 @@ static int collapse_scan_pmd(struct mm_struct *mm,
> > > > >                       }
> > > > >               }
> > > > >               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> > > > > +                     ++chunk_none_count;
> > > > >                       ++none_or_zero;
> > > > >                       if (!userfaultfd_armed(vma) &&
> > > > > -                         (!cc->is_khugepaged ||
> > > > > -                          none_or_zero <= khugepaged_max_ptes_none)) {
> > > > > +                         (!cc->is_khugepaged || !is_pmd_only ||
> > > > > +                             none_or_zero <= khugepaged_max_ptes_none)) {
> > > > >                               continue;
> > > > >                       } else {
> > > > >                               result = SCAN_EXCEED_NONE_PTE;
> > > > > @@ -1453,6 +1582,7 @@ static int collapse_scan_pmd(struct mm_struct *mm,
> > > > >                                                                    address)))
> > > > >                       referenced++;
> > > > >       }
> > > > > +
> > > > >       if (!writable) {
> > > > >               result = SCAN_PAGE_RO;
> > > > >       } else if (cc->is_khugepaged &&
> > > > > @@ -1465,10 +1595,12 @@ static int collapse_scan_pmd(struct mm_struct *mm,
> > > > >  out_unmap:
> > > > >       pte_unmap_unlock(pte, ptl);
> > > > >       if (result == SCAN_SUCCEED) {
> > > > > -             result = collapse_huge_page(mm, address, referenced,
> > > > > -                                         unmapped, cc);
> > > > > -             /* collapse_huge_page will return with the mmap_lock released */
> > > > > -             *mmap_locked = false;
> > > > > +             result = collapse_scan_bitmap(mm, address, referenced, unmapped, cc,
> > > > > +                                           mmap_locked, enabled_orders);
> > > > > +             if (result > 0)
> > > > > +                     result = SCAN_SUCCEED;
> > > > > +             else
> > > > > +                     result = SCAN_FAIL;
> > > >
> > > > We're reusing result as both an enum value and as a storage for unmber
> > > > colapsed PTE entries?
> > > >
> > > > Can we just use a new local variable? Thanks
> >
> > Again you've skipped a ton of review comments here. You need to respond to
> > everything.
> Hmm we could, although it would serve no purpose in my eyes...
> nr_collapsed = collapse_scan_bitmap()
> if(nr_collapsed > 0)
>     result = SCAN_SUCCEED.
>
> To me that is basically the same thing with extra steps. But maybe its
> better for a code readiblity standpoint.

Code readability is a very good purpose to serve, unless we discover perf issues
that suggest we should behave otherwise, this should be our _primary_ aim in my
view.

Even more so the case in THP code which is, often, well let's just say 'not
beautiful' :)

Thanks for responding so thoroughly, we'll get this over the line I promise!

Cheers, Lorenzo

