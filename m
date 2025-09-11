Return-Path: <linux-kernel+bounces-812786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5FFB53CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 751567AA2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EEB262808;
	Thu, 11 Sep 2025 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AySFbRa3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="faEvj0L7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBD4315F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620770; cv=fail; b=XYmb7hS8oc3UFcc8W/ZglcAIiIca+bj9dHw4xNA17n8t4fDHt0cM+s0v2Vdnpnm5EJK9fUyY5FeqNi3Yq9lxoSalBGlgSU5tio+2iOEomVzCp51b2Qb9ZbkbgKHC1wsp93Z2SlMlgTABhP64sfo7bh42zNJs7PDBUW3fs/S45HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620770; c=relaxed/simple;
	bh=orio+/07vvcWgxjP7L4gOw55X5JhHOYQLPvsB3FaV+k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pNmPcqFt9sr0tCU1w3PqnmhlNKwO5hW6O4sQi0JL1ywwrHX2j6Hzf6zBGgO/jCnzEY7QNJ2et8x6NSjArdzSQgPmgwbGR+NCNACCAB43KkcO29vGUvd3FfycrvKS8ki/zAFrFM3VYTxnXVMmTMk+Y6hD3w3m+n5YYQfTR8jZ3Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AySFbRa3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=faEvj0L7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHBf4q025897;
	Thu, 11 Sep 2025 19:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KuClWkU4n5a/2MSkGZ2NhdwiyHJCGjrHGB/Nzc0/HUk=; b=
	AySFbRa3HaF83I4+DMzCXUMLpKDGSyQ24M568JfEobLivGWJIIiqRax/XDEHRARe
	qyNu40kuTHbiTMqfNg3TIjoMb9ChLPqekPHsjuaib4jZd0taGwL7VcAamgelcQ2V
	KHvrn47soF/Ss/s2ER2Lfl8ah0kRO41ovy/said035ZOR91j+785ntkYfmxNt9jk
	ue0eIIPfk+WIIbKf/vXiTQ8aBs2RNoelHKNtQIl/TEzXRhlTr8hxgK0TODVQCCtX
	d4tiVSID8+ASRKTy5zuR5fbQ123K9K6pIHB/iwdemfBWD3f3s8xTAZrzieuB+5Bd
	9hpNj2eqMMQpOQccBziFEw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226sy20n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 19:59:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BIYQMD026089;
	Thu, 11 Sep 2025 19:59:11 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcyar8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 19:59:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvXIXil82pyorK4cvpYqYDVoWP+ppiMFWsL3GM+C8DMJoxpU5PSsLkX2gM7A2pSb/EH5eJApTvRQhc/kjwLaDcYUVwaxJEMxx6ZV+mYfTbKIpVAgG0XTO1uupQ9N8QtWsngAfzRmWxclN/1FpgETxnHAYnA+ecdZwNmoq7oiJ9/AY2knPlHoPf0WL9CJI5g+bfZxeOXyj0P2xQXm4dXbm00OiTOdu8zk9loDIQ8mifg3wM8kkeF026EVUt43EoQO29i9egCHPpdMuobf9kCShucOcaYc61UumpLiJSF4tsu2BCRPb91ZfigajCooJoRs5T3jfvP9B+m91/YUBXECkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuClWkU4n5a/2MSkGZ2NhdwiyHJCGjrHGB/Nzc0/HUk=;
 b=CAOhD/i+beandYcbpJkeIEzDPwnwsWJA5c+LqPd7+0zI0UUZraRx0rJCV9xlPJHkSt9YyCE4vkcjgiW/7JvXlnSXOtzIs3FPH80mElDpT8o7Ky/qSbKF+Xt30QrgzVWwV63YBDQIn5ZdhXD5J/t2dLrPDKyzpdpYxXMOW4P7hBRtn+1tuHeZffMnHAf8U+nJaqIUWGua+/I5jzInKhhixhlGCZNqOyNQ8kj7bBfiTOi3fo1n47JhGFZbMEp6FXs2F4Mos1TFijt0ZAQ2NrxV40TRi7/fYHKt2+jrBsH4O4cfFoGsVsYzLGHuXm7unvt9FpTGjxTtZpAUeMcOvIozEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuClWkU4n5a/2MSkGZ2NhdwiyHJCGjrHGB/Nzc0/HUk=;
 b=faEvj0L7sEoiVdNbC1ZHLQavZ8GL/lx9pdHDVQYfRY0TwcqrnIwfAMh19B8z+P2wlu2ybylG+WZwr6AzeN6a7fWD1vW9A0uNTBtAfvvqSGKvPo/+F7JGf65cBkyU0gPXjHJ/kFeGA1yQUQIQ35bU/yRDmBuqvuZQaS3hptVt5zE=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 SA1PR10MB6566.namprd10.prod.outlook.com (2603:10b6:806:2bf::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 19:59:02 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 19:59:01 +0000
Message-ID: <16fd43b6-930a-4a33-980d-c493f88747b2@oracle.com>
Date: Thu, 11 Sep 2025 12:58:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/hugetlb: fix copy_hugetlb_page_range() to use
 ->pt_share_count
To: David Hildenbrand <david@redhat.com>, harry.yoo@oracle.com,
        osalvador@suse.de, liushixin2@huawei.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, jannh@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20250910192730.635688-1-jane.chu@oracle.com>
 <bfeb8af7-62d3-4dc6-903c-b6697c5ef795@redhat.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <bfeb8af7-62d3-4dc6-903c-b6697c5ef795@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::35) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|SA1PR10MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f4919b-6717-4e13-9b58-08ddf16da74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmI4SUZ2UU9ZNkhha0tNUWdoR2lobkFNb1UxZDBjUU5LSHRvdWpHMXJOMjFv?=
 =?utf-8?B?SUgxWDVSZzc0UnpTMTVLWXROWVF5dHBhbVo4WGZRaFhBUGw2T1o0cUozSi9i?=
 =?utf-8?B?NUcrYld6SUlkSmYrRWpRV2hMZmExTUxpOFpMek9FSkxoQWo5NUxOQm1acmdH?=
 =?utf-8?B?TUtoVnVsSmRFaDBab0x4WCtmZjVteFZWaUkxVys3bTl4MHdwNlhCOWFzS1kz?=
 =?utf-8?B?RGpjRjdjKy9vSHFZSkk0T0lkZ3RhUStqV0RQT0ZqVTFSTTRSbHJTTGZ2ZjVT?=
 =?utf-8?B?U3IvYUxGZk91TWlSSE9PN2RPU09BVXNyajZ4ckNuTEc4QXRscXE3K1pDRHVS?=
 =?utf-8?B?b2I1Q1V0R0lmczhQSmx2RkRtTVBueUVzTTZzdEFia3hHYjhOMW1sbXFQRjVQ?=
 =?utf-8?B?V2ZYaDd5ZC9rYVMxVmtQTTA0UjZnR2lBcnk0VW1BcTBwUm42WmoyZ0VLdHk5?=
 =?utf-8?B?NDRtMjNhWFg2ZUNScVptN3hmeWRTYk8wUkdTZmxEaEtEMWhvSHBuaHdmdEhj?=
 =?utf-8?B?bVpKR1MwTEV6Uk5XT1RZY3g4OElaL1ZLV1QrRFNWbXp3ZTVNbkxFT0RIUkF1?=
 =?utf-8?B?SUFHalQveGpsNGtzekpuZHFEKzN6WExRRHMzcmpoK1FCSVdqZmVaQlNkc3pG?=
 =?utf-8?B?Zi9Fa1FtUy9BRDZwWkdib2VlQ1ZiQWtESGdNRjVrME53WGNJRGE3UVk3b2Vq?=
 =?utf-8?B?UXdta3hBTVRSVngvYjA2NTJzZjIwVklIRjhIYUwzTHJvd0ErVmdtazdTcXd3?=
 =?utf-8?B?SXhrTFE1bTVWZE9XVVJ0NldrNEZuV3NobjJKWHIvYWZUTzhTUC9xS2NUSFg4?=
 =?utf-8?B?TXFhS1BGcXU1R0VQdUttalZJMFhFalFtck5RWTA5UnZibi92NENhaVppWGpj?=
 =?utf-8?B?WjNaekFuQUJrQ1QwQmJDLytUYTJwNjBsNFNxVlkvRzlmbTY4dHNjZnNCUmpE?=
 =?utf-8?B?TnNMUEZGb3FwYVorVUdRUnhQbnA4aEptRDJUMW9OREpWMG1iQWh1WlNGNmsv?=
 =?utf-8?B?U3hBVnAweTVyRllDSzl2a0VVaVFaVk5sRDlXNVZuVFVyMU1TeXJmN21SRC9y?=
 =?utf-8?B?Vmw2bFBHZXE5dGJNSmpPM2VsLytZRERTVTY0WHV0Z216OXVrUWR5VzFrSk5V?=
 =?utf-8?B?THpGNDdpNWZNTld0cnFDcmZpUURDamxvMkNOWFUrL0NuTDNqWDRBcE1JNjFZ?=
 =?utf-8?B?bjMzL2hJWk84NVNYOW1nR2tsd3Z2bldjc2ZRdFZZOUk3UDl1UmZXUDJZdldV?=
 =?utf-8?B?VWt3UHJ2aW8xK1hBVmpYZ3NIcDFadUh1My8vVytpekR2bkFCNS8rVFZlbVNj?=
 =?utf-8?B?cXVpTGVsNTQ0cDFPWkE1LytrYXNrMWllRkZ4ai8xWkdWek5XalZLM2pDU2Jx?=
 =?utf-8?B?MEtoeDNUWUNTc1FWL1U0d1ZRbGowWEZraTMwMWNVdG1kckE0TDRlM1JWTnlR?=
 =?utf-8?B?WTBuNHNyaUVmUGExODVMNWJSLzMvZW1jRkhUMldQQTVCcGM5UldUNmVDNXQ4?=
 =?utf-8?B?eDN3NFU1TU5PNXNqWnI1T1FhdC9VOFlOQ1k2b2tUSlY3emV1ZXdVUm53cFJZ?=
 =?utf-8?B?bTkxWkw4YlhuNC9UVlBPanRSazBJNGtnK2Voc1dodlVkRG41REk0MkswZnNa?=
 =?utf-8?B?c3lzeFpocUlPRXhpZDlFcjEveUdQZU9rNldzbVlNb0M4bzJvTDFUdUY2NnFN?=
 =?utf-8?B?UzVscjJHUk05SmNWalFhRXA0elI4WnFEcnNkUE51SVVwdnVuYUEyOWRMb1ZK?=
 =?utf-8?B?THdEVFVpQXd1ZmFheitFRnJvZkh4bTBySHNDRnhEaTlQLzRERjlxM0dvdW81?=
 =?utf-8?B?RVg2NmZadlkwMHdLK29CUHNvMTh3NVZGV3RRRDFmQlZNeWJQL1IwOHEyS3NO?=
 =?utf-8?B?MEpXcmxkVEQycjJiRnhwWm1FSWcxS2h3cFZzQ1hBc29CbVp2VXEyQ1V3KzNW?=
 =?utf-8?Q?tG+Lj/9VzyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDBoLzM0eGUrazZIdVdKTTIwM2JMS0pHajgxUGNzbWhBaDRKSmNLNFVnNkht?=
 =?utf-8?B?WnBoc0ZDSFBieVZJblAzTEZkcVpaalRTcy9NM3NUUUNmUkpWNjhqS1ptMkN4?=
 =?utf-8?B?aktBd3gzMUp3RVdhakxQbXZaaGxzSjhtWTVBOXZWdGUwclB4UjUrclIrQUtG?=
 =?utf-8?B?WjdkTUljQUcwVXE1YldmMEtVUm9yeUZGNCt1VXBTV2ExTG9jamtTMTFRVUEz?=
 =?utf-8?B?cW1GS25xQWI5OUdQK2tmM2pqVy92a3E2MEdibU5PWjhpT2lGbXlhelFCNnJB?=
 =?utf-8?B?Q0dOZ0Z3UHN3UHNNWXIvSWc4VzlhVFBsMXJXQmVMOXVZVDN0VkNabzl1bjdB?=
 =?utf-8?B?MTZUQTJ0cXZBWXFuY0xnMzdPblNxUkhMM0Z3aEdkNXJsenczWW9KaE1HMHNs?=
 =?utf-8?B?UXZBbHRJb25Yb0RJK3Rvamh6czE1VElza25mWWxqUU5BdXVlMDVzdDY2TXBI?=
 =?utf-8?B?ZEZrSlJ6dHZSRzVxNHowMEgxMWF2eVdZZVE4OCtSeWJ0NXhiRHNidEdUVXVv?=
 =?utf-8?B?T2hhNGN0MHgreVFOcXR5VUhwVXVacHpOUFBMcVNwUjMrQlpQU3Zib2dmQSt4?=
 =?utf-8?B?ZzZ2THJaRmc5bFVhSFVxcGNWZ3Q3UG00UVJFTGU0SmlOV3dNcEp5eGl6NnNB?=
 =?utf-8?B?U1lML0Q4RW9VOTE1Ym9RMnBoRCtUUkxrWmowQWhVVjFJM1VGMjk3ajg1R1N5?=
 =?utf-8?B?bVdYSjV5S0NyYjc5ak1OMEMvNWRVQi9pakVwTUpnS0J3a0FtNG5GYzB4eXZY?=
 =?utf-8?B?RHoxY2xRVS9HY3ljMWdFMFJKeWJtKzhWVktKVU5GUXk2RXp6MUo2OGF4QkEx?=
 =?utf-8?B?RnBVU0RzclNCN0dRM2JnTXhqb2FZNTY3bnRUbjQxR1BCcm04MDJ0Qk9nRGZt?=
 =?utf-8?B?elFtRmYwYW0vcEEvcFVDOXRIS0FlSG44cEVxMXhIeXJKdG84MUNwYnBaa3N4?=
 =?utf-8?B?dGZsRGJVSFZZNWxlZDI1NmNPbDJyZmZTUkNzVmlveUgyTHB5OUtBNXRNUGUv?=
 =?utf-8?B?S2dqNWswT09OSit5WW96eXVMMlBrY0xvSGxoOGF2RTFxR3g5dE5NaGg2S0NT?=
 =?utf-8?B?VnNhdTVpbXRUTmQ5cDM4aUo3ZGUrZUVzUmNuM2F2L1I3dFh3L1VGbUNLQkdN?=
 =?utf-8?B?RjZOazJHMmhmUmN5TUlFUzJiVitPa244YnRCRUNIVUJmM0VEY1ArVHQya2hV?=
 =?utf-8?B?ZE5rWUVuYUF4cUo5QThQRW90N3V6VW1ibkYxWFBYRzZ4VDZkM3VZajNuVU0y?=
 =?utf-8?B?RWU2blhONndIaXliVTR2THd4N09ZVmg0ckdaWG5BYzF3UjN1NEZHVmZTQkpp?=
 =?utf-8?B?ZUhCNzFUQTdRNHR6Ums1WVZ3RGVGeWdGNDdHYUY3RjZIaTNXTFI3b3M4Wmlm?=
 =?utf-8?B?NmhhZWhlTEsvb0hFcDZLVmtUckdPcXRJSHdHRUNXZ2ZXTllRT21TTHpSWnpB?=
 =?utf-8?B?bXREN2Z1T3JRbUJ3OEtZODJGcVQzYXVOOW1CYkpvSTZ1UWRqZGRVdm1rZ1lm?=
 =?utf-8?B?dTdhUU1Rcmx4YUVWTkJycjRzTjB2RVZGY1cyQUJHc3NCTmcyWldnK1BncDBL?=
 =?utf-8?B?MU5sOFNVU0k5T0dBVnIzTm96a2VIL1hDYVZLNkZ3eXBUTWZqa2haQ1NKbWQr?=
 =?utf-8?B?RUZWanZmWm1DRFNlN2wxc3F2aWptdE83cGpvb2FHVThldEFVRDRqbTVZVTRv?=
 =?utf-8?B?SkR2MXJNNmwzS2U3WktUVzZDbTdVMnpsUHowYjFVNUl5KzBmNE52WVY2WEs3?=
 =?utf-8?B?YisvRk9kdmlRUERZbWdnTVBpcU1ESm1iVjJaR1JTVU5LWHhSQmZsU3dzUHpi?=
 =?utf-8?B?OWN6dEtKdkZsS0g4cW9DaVRNQTlrdkU4NlIvWFE0dlZWMml0WVE2TisyVUlq?=
 =?utf-8?B?OTZHaUNMS2J4eW9PaDhaN0Q0cVZGUDRKMXJsV3ZxNE1UNWF3SDBNRzlBRHRr?=
 =?utf-8?B?c3hHUWlIK3ZnQWVIYXdnKyttM3JucEloaktRQWdETDd6c3p5YnFPaFdvYktR?=
 =?utf-8?B?U2JQZ1dLQS82c09ESHhYVUdFcUl4WXJpaXNzL05IRDhqb1BVcHozRFQyamE3?=
 =?utf-8?B?WU5ONEU1TmpRUlp0VWFrVW1tNzN1T25iUzk1OWNUTzFzVzE4MDNJNnFSOWFP?=
 =?utf-8?Q?BS2Hm0ltmOWVc5z3+pb2YhOO7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ffbWgLaA7AA67o/wlrlHTfWbfWj5PchyRhG8l2Ku4RKRiYdKsp9k4RvxYUU79Rp0JNP9JVQR+Rff8KFMXWakN0yBNpLIZcdMtQyMjJywAEuhGcflZMlWGka+sATyLRM6/NnI4hszX64zTDy69aaW/DvxCykx/MvfjN9HYhPRQz7AcCIWDPesg7eA1rIwSuI0dbtxiD2el3XRWXAt6yRJ836Ww/7sqE2JLvRnVOG5dbdf0RlU9b5xIjyQ1Objl0eAinG5Psi2Htr4NH0H0g0TREX73clSs7/qQJ3VZPPpi9+Vg44PAmThPY23Dj90Qo1EQLp7YG6M/Yq7LHcINeArtsLFiDuSUCOIsBHRCjLewe2ODFh2lPp5FpqkOs42tTs5ns8V3Di/CzzfZEbAmU5ePYNeqzKqvmxa2w2L4dhR1jFFxv/yXuse6CtsqGGXtX8+c9D4Jay+jZGgim+fWotnWbmBRg/QSJZqFJXY8OYrHxrjlHolAarkuHI7CKANBy7iQI3KnTB1yUdArtDTCjzI+GRD3kUr5jEP9xsqe2F9jPutB9FD7bpLtzjqPGghcRWhHF56Ff3bQFkmmp521JNUcDLBEKKFBjb78C7CCzLVhqU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f4919b-6717-4e13-9b58-08ddf16da74a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 19:59:01.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I03tRGymBE8J66Q+RD0mSi+RoriP4lLl3cKxUJJcSHmKC1j7q1f+gEpWjxJOTCj3ypoSJfHbFGdMmJxve+nlzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110179
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c32a0f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=KmZ8kAYGGGoBTHAPYZsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: xbwJJJCc2SDMfBDBtu54ojvRD7PSP6i1
X-Proofpoint-GUID: xbwJJJCc2SDMfBDBtu54ojvRD7PSP6i1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX5rIJ6tRKXgg4
 3agI4KwkdHm2Ph3G3Bi1levXF1cfPWE6WIiCQc/4Zuond39m0sUUfYp+WGzYsDqttTOlGW/PM4+
 yIGKaVGfBw/Sd3kk5Rd27lOXI2kmzodVtsibDDMK1pyRmQ+We+i0k7bZxh8hNHSJxMIRyH38la/
 atdPYKrwhYmOptexYtE3VjrGGPTt8ZushUPd1KpSgH972W1tKOThVxwDJ3s1BN7PatWcl8zDXwQ
 U/INMcI2hiJr7ZFSzOPfD6pAheR70jEo37RfNYcYRKX0fXrhSo/69SIvYv9Z5e2jS0TjVT6fPhA
 tDozf9tRW/SBuzJJ5x0hRKpJYT735mecHi79WuH3CI8dP5J/aY5cRCPRPbvbYsgkqEdN7n3mAXY
 tBeVBD6s4+e7P717sKgupYz2fz51Rw==



On 9/11/2025 1:17 AM, David Hildenbrand wrote:
[..]
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 753f99b4c718..8ca5b4f7805f 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -5594,18 +5594,13 @@ int copy_hugetlb_page_range(struct mm_struct 
>> *dst, struct mm_struct *src,
>>               break;
>>           }
>> -        /*
>> -         * If the pagetables are shared don't copy or take references.
>> -         *
>> -         * dst_pte == src_pte is the common case of src/dest sharing.
>> -         * However, src could have 'unshared' and dst shares with
>> -         * another vma. So page_count of ptep page is checked instead
>> -         * to reliably determine whether pte is shared.
>> -         */
> 
> I think you ignored my question to v1 regarding the change of comment.
> 

Sorry David, didn't mean disrespect, I missed your earlier comments.
I just replied.

Thanks,
-jane

