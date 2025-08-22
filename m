Return-Path: <linux-kernel+bounces-782294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C8B31E75
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A686189ACED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D32ECE8B;
	Fri, 22 Aug 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QvR2Z09U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f/AYiWCr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D023D7D2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876010; cv=fail; b=ILZ7g39XgALXfwTkX+K0O7ir629BUAWZu8rSBB8YOx//asddTlEfjTJprEd2puJVU1qfqLPKCRDkX8QgsgufgLkVOoyFa6zUk23DzQPoYlqep5bR+gl0/MlAfvEC/J28chN99Ne2QgmzGsH3ksgi9+7DUd/fJpyjpV5/h0x/xF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876010; c=relaxed/simple;
	bh=bHkUfuZjl1XL0aMAqOUD2c2pzOogD7vmjPPI5O1xQcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N4ZPBU1/UNIBvi4aFibUL87WL1sCFIDVpNy77xNjPW7S6ibiQqwjwz8CazGE0jIUOGJ3Nb3xG9v31nhn6w6fqGyEKKD69G/xB65cBIaD1vbZljecdpw+krVeqP6gzQES/qNcmieHebopnMsyejri9+KPYP7BcJd5xxJ1++IC8aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QvR2Z09U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f/AYiWCr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MFE9JO018240;
	Fri, 22 Aug 2025 15:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cjWKfHthLZfCdIuEPabRAFqHttdp+yVhL/8AT1h/lTE=; b=
	QvR2Z09Uw8pT1GQxs0XRr0TlEofTulICFJSxR3sZas8CgXFuYe4qcGFzUOMXqY6F
	Qr8pk/y+NDLoYJECr0uNjMEAI6GBNf01a+s3XdeUEesjp2Jp5iZEY6I54aVX4o0J
	Q12n8jtRlWiHa/YXKWh31ezdU2cBWzMc+VgnqeiORZIULtJTvgTyRHsoSUVRc8dX
	66/ZudUHKmBKJ9YxYhWNmkLFCGNGq+zpi67Ps6KQjMhQtU+Ki20pPXZea2V5mivW
	dnHShfpDRQreBYpbWj1OuyAalNm4mklrs4APuQ2PJJVMIv8MedJfA9cvrBQiZzyj
	gSdZwCOmMUPh+gfnJ1Eb+g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0ttnf6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 15:19:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57ME13Gk030454;
	Fri, 22 Aug 2025 15:19:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3wt6hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 15:19:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQWDku1H/PEyERGgzpggRinLgax/TMLgD7wE71EjaH8Gxh2Yr5jAlcu/oF+Os/hkpLE6j636ejG99ZvzzTltkEjLQ86h1aiDtqNzlvf9Y/2TMb9HAVfJdl5dVxxTWakxyDaEXk1jyZHk5GMKJ+zuwlUq0TqXor17vIbHuqlq9X+cY+HpX/MMSm627XcF4zHvDdNbNQL3THG9HYs/eB9MRjZpj4zhP3Lh/3M9FH+2lytcMbFD7FUgyT0ogb/uKB3QLH2hcNDTN5TLk4NTHQMotzEHA/3uPgiTw1YV+kYEW5y/gyRNrMstiiYGx3NAGZPoBMlDPsCNok8/IGt3Pk2W4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjWKfHthLZfCdIuEPabRAFqHttdp+yVhL/8AT1h/lTE=;
 b=MfPKLK3HVVT2V/BOD4Tiwkl5CErA26q7ZMVxsMlaNvM2kYsyryGa4QfZ6Rd5ZAHg+K8V2gbBXYIBSQQBmnoUwP6SewykRlrQnZMtqMNfyYt9nDdbbJR4JKXztodDdVbs26ipNS9eA3zTfJSxjmaBKk4QOeVW7KZ7SOLe7wTagXGljjLSNjBLX/zXBByTQ1Om6WXjsw5/tAJcBWmA4f8cD+GbK1+h9gehwQfZM3Z/skkxxH4NGO9e+uho8LccLwO6YoR3xyzCOMv2dErviLVbXChxYJKUL83Pn6no/Fn8h91pfk9t2HHcP4BZcTZa1OmE6x6iJOv2dH3cd/MktWlF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjWKfHthLZfCdIuEPabRAFqHttdp+yVhL/8AT1h/lTE=;
 b=f/AYiWCro6MqRzMfo9MG3kj9d1h/H8wIAGGFIAHlgAe2E2tvEZ9fMecvM77zDNWGj7eVOKh7zlVqbWA1BqDGOWNNmqa1NvKDJxVVhJRpMedWYIvb6MKrh3WA38cFa8OzfdEjNTtq8H0KJPFo/sj0MeSboPdJHXi6a18qwUMHyrg=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM3PPF311374B40.namprd10.prod.outlook.com (2603:10b6:f:fc00::c17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 15:19:36 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 15:19:36 +0000
Message-ID: <fd39be50-90ab-4b25-ac1e-10930aa52b5f@oracle.com>
Date: Fri, 22 Aug 2025 11:19:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: add missing hugetlb_lock in
 __unmap_hugepage_range()
To: Jeongjun Park <aha310510@gmail.com>, muchun.song@linux.dev,
        osalvador@suse.de, david@redhat.com, akpm@linux-foundation.org
Cc: leitao@debian.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com
References: <20250822055857.1142454-1-aha310510@gmail.com>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20250822055857.1142454-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:510:33d::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM3PPF311374B40:EE_
X-MS-Office365-Filtering-Correlation-Id: 456ae28b-3c87-4b49-3fe9-08dde18f4e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU1IWHhnQWhqWS9YQ0RHNkQ1ZnlOT1I5dlhhR29GVGsvNXJFMCtPeGlDckcv?=
 =?utf-8?B?SWpGbzN4RG9adjFPZlluSC9NNE44aGtEM3BjZEVaWmpDaEgxclhGcmh6eXlq?=
 =?utf-8?B?emRTbFVyN1dJcVhPdjh1ZkNYRWdQaVdFTjhTZXMrdGpsSEp4b3NPYWtxMVNR?=
 =?utf-8?B?aDFKMDhKeG14bWFjdGVTZXg3eS9xU2M1QTVmd3RKbG1zaUJqRGkrdzh1c01l?=
 =?utf-8?B?dzRzN1dBekp0L0tNV1duVVJadE80ejdrVy9PSWxwcjM4N0tVU25MbUpWaWRz?=
 =?utf-8?B?bUVtY0ZPUHNQdnpUZ0JJRzdjbGJRRWpmZ2xnUTFNZzdKaE56VTRoWGhMUWtk?=
 =?utf-8?B?NmRJU2F5R0kxdlNjRGhUckFERHBxNGhpZHNNNStxV3U1MWNDbmxyNUxFbThQ?=
 =?utf-8?B?cHpJc2ljSEN2ZE9rSm5lK3Y2NEF0VGZqQ2t0MkFvemZFcjBiaCs0TnlFbytk?=
 =?utf-8?B?NnZPbnVrR2NPLzY2d3BDSnJaclVCTW1RU1JrZ1VkR3pwUVR6a1R3dzNCbnNR?=
 =?utf-8?B?aTBRMTBTeGM4bS9lbUgxRzdxUnAxeXBLd0xnc1pRWU1wbEJxVjVIZGRselUw?=
 =?utf-8?B?SlcxeWY2amFvUDQxOVNabzQrbkg3OTI0dmMvVHRiMGlMNTJCU2syZmkyanM1?=
 =?utf-8?B?VXd3RUh2M1I3SmdxS21jQ0g5dTl2YVptaUlvV2FnVW5PRmNMM1dIVXRRVTBy?=
 =?utf-8?B?ekMwQWtJdkZEVkh6S1QvN0FSOUUxdkp6YUZVYXFGZFN2dUZISlF6eW1KU0dE?=
 =?utf-8?B?MXN0VVcweEFMcVBtMGNWMDA0VEk2cGJpSVpFYTRYZjBPZE5kUUlqTEViVXZS?=
 =?utf-8?B?ZFViUUtMKytZamhwbmJHd3p4alNJa3NTYU1haE1nR3lxaWlNZE1ZcGRFQnZx?=
 =?utf-8?B?dXEvQkJzeXd2U2g1RFAycXJWMk1hbnR6RFgyK3JhWGg2aVRqRmdVak9Ga1dn?=
 =?utf-8?B?WXgxaE9QZVFGc3VxVjdtOGtFYndHd2RFdkFtK3ZDUUNabTNRditXT0ZpN2R2?=
 =?utf-8?B?U095ZXMrYktNV20xMmlEbmlDWkdhcWFra0dQTExuQkJ1ZUw1Q0Qvd1drV3VY?=
 =?utf-8?B?QjlYSlowQTVxbDZUWHFZNXFhMmIyUGNMYXR6dDFESW9DTEVUTU0rTTJERFhX?=
 =?utf-8?B?elpZbVJ5bWNrV2l1K2NkQmxkVmJINFBQMU9Qb1BJNWZ5Q1pTRU5SSkhKdFlr?=
 =?utf-8?B?dEdkYU1hc3dqS0t0a1FxOWhPUmV5K2FIR1ZobEc2QXpxTE9vbjdQb1Mxd1pa?=
 =?utf-8?B?ZGVKS242eG8vVWV6ejhnZFNLNWwyU0piRU8vV2E0Y0JWb3R6dEcrblN4L21R?=
 =?utf-8?B?VUQ3dHBJK3Zld0lFMXdieVl4TUJ3QTZzT1FDQ0tKV2hLUHFZVVN0MnV1RWRP?=
 =?utf-8?B?RDFCTEhEVXBrL1p5MTVaaUdCMW1vSE03WVR4elF1dEpRUlJKWlQxeFBHMXZH?=
 =?utf-8?B?WTR5V0RIZE5BR2xNU2FDY2E5Y1Y5dEFsSG04TWIyVExkckxNamFIWUM5bnZq?=
 =?utf-8?B?a0VOZnptZGRmMzVJeTI2T2JwNTlGL3ZpM0NQMTRnMEdHRXAxZy8xby9RNEhp?=
 =?utf-8?B?SUxzL3ZJWUI5RjJPVzJuejE4UFhuU2JFRjdJRzlESDVFRjYxVFNhR09BYmIy?=
 =?utf-8?B?RVkxYUJkVjhyYUlVd2dzTmJoMzN6bGVFRGUwKzVkdW92YjBIQlppVzk3S1dl?=
 =?utf-8?B?TXcyeGVzQm1TMEFsbUtNa3p0VmQwYUpYRUlpQXV4QXpZajFIQW9ScUQ1c0dt?=
 =?utf-8?B?NmptOTZCcVhIbE40cHFnaWZQVXpGQ1JvT1J3OEZkUlphcmFSTVdEVTBUVGFD?=
 =?utf-8?Q?2cjCuQfEhR6fZGpA6yNsUPWVOy7Fn1bTOVHWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUFwR0NnZGxjNjB4UVhKdFRUZWFaalBHTjIrQ1loVTUyb21UMnNjWlJYTXJp?=
 =?utf-8?B?L3hKU3JDK1JBczhudU1QR0NQUjJiNVpDMVoyWDVFN0FYYUk0UVVML2N5NThs?=
 =?utf-8?B?a2luSkx5djF4Y21vQXA0UHZJMWZ3NmZEYjNDMkRvWFQxT0RCVE51WXF3YlNT?=
 =?utf-8?B?TEE2UHowY0xPOUswcnczT2dxY2E3a0tQdGltdFhKb04xbkMrNXptbGdvNG1i?=
 =?utf-8?B?QWtjd0svRFc4czYwa1V1QnVITnlKdWxCZGozcTE1SlJucnNZOVdnRllEcXRu?=
 =?utf-8?B?a2pYbFJTczZ5SnVhYWRKZ2Z6VWNwWlNsV1pNYnIrOFJEM2VrNDVxdllSaWNM?=
 =?utf-8?B?dlpPYngwNTY4aWhQNWQ2dUZSSlZYTGxHUlI4SFR1ZzNOcTBra2ZMV3BacURY?=
 =?utf-8?B?dTdRd3ZZeUZZN0tYaUxMVG5PcjJDbkpsR3RqQjQ0UEhkZFBaRE5jL0tOSjcr?=
 =?utf-8?B?OEkxUnU4ejdzR21tVEtLbVlZNVVXR2ZoQWRQSitQd3BvQkMvR2pac1NZVW9B?=
 =?utf-8?B?eEtmK3dzZmpHQkZWbXd6SnFxUktSU2VXbjl0VEJuREtnS1V6WldPc2k1RGc3?=
 =?utf-8?B?bzFaaTM3UStZYUovZUE4Qm1EUUtxQVlzemg4QVBRdnRNL3dXZ0JUQnJmU1pD?=
 =?utf-8?B?Y3IvUFJSSFF2K2dkbG95aGZnY1NrcTJFSFA5bDNsMTgzRFQ4MzM0b3UrSHZT?=
 =?utf-8?B?MXZ4Z1hVcHdoWFQ5WU9jZm1ZS1IwalNQaGFnY2dQUUJnNEd5ZzVlZjk0clF2?=
 =?utf-8?B?WjVlNnJkbEl2QWt2aS9GMU5mQzhWczFReml5WHp6eWdzeGF5STJJd2wwYzVa?=
 =?utf-8?B?VmJrdzFidEZsWlp5SmxYaEYvSWV0dC9aVk9oUndoc2RQcm1BdWhGUzJNM0NJ?=
 =?utf-8?B?dDRscW8rS3FZbWcwamZCTDlOdDdLMzVhdWpXREVwbWF2VHVCaFYyL05ySDZ0?=
 =?utf-8?B?cDMwMWRsUjBMTlQzTVl0NE5YWTFZZlMvZXRoSFB1eHRLT2FoNE10WFZBa1Fv?=
 =?utf-8?B?Mk9UVkxRd1dEa1I0QW13WmtjRVpJOUdCM1F2SXVhZGY0UnZXaXVMNVZnZThC?=
 =?utf-8?B?Z0dzV29PUW45dmUzdEVXTUlwZWVlcDBSeXpEV1B6bmJIYk8zOHZlTGJzZmUx?=
 =?utf-8?B?L3ZqWHliVW5XQzB4WHExbkJZRVZ5dFBZVEdWVzY4UDFORFZnS09zbHZKQ0dh?=
 =?utf-8?B?R0tUSGdFSGpZOG1JNitDTHVLUDhQb21mRDFVcGJkc3RRTkhjbHhWemNaaHdZ?=
 =?utf-8?B?NWQ2cGxtbFlwV3I4djJqUUpiM1lIaWEvUmRlRHpvck90bFF1TEUvWW9FR1hK?=
 =?utf-8?B?ZXh1VTgyNGRLajlCc0VLQktpZHNOcFBadXZRVjQ0ZE5td2ZOYXl4ZjdVWGxy?=
 =?utf-8?B?S0UvbHpmeDE4Ry9DTDMxYlRQdUZiaWRiN290d0wyeHE1N3NVaFlHMUlucWl2?=
 =?utf-8?B?Z0V6K0dSYktVWGpRR1NXY1ZpYlF1cGFZc0ZLNVFqNExmVHVjR21Gb2tpM1FE?=
 =?utf-8?B?ekpVVzR2NWNFVmlUU01jVkgzT044b1BNUmRaOElKcEZaYlpFakpCV2ZvTDEr?=
 =?utf-8?B?NVhLTnY4YXZyM2hoNHRRLzVCa25GVVcxaXlvL21aYmg4UGpWMklnSzh5Zkdo?=
 =?utf-8?B?QTJLWFJraHgyYi9TMzdxVUJ0V0IvdDFJL1o0d1ppRS83TzdFZENEa1MvM0NQ?=
 =?utf-8?B?WmcrcDNSVkdscGxmZEw5RFg3M3JoVithSU94WmxHajFEeGhiVnZlYTBwOHIr?=
 =?utf-8?B?T21DUi91azN1NzcvR1V6ZVAxempRNVM2SEREUUxNMCt6UUh6OFBRd2JaOUF2?=
 =?utf-8?B?VXZMOGlFekw0NURtQSsxa0ZaRThkUnVBYituQUE1NmNEeUZOTmZXeTZ5eCsx?=
 =?utf-8?B?OHpNbnRLZjhZaWZ2cTlDanJJY0U5YWczYVJHazZlSU1yLzdUZDY4N09Wc1pS?=
 =?utf-8?B?VG83akpJNkp0ZFVOS0FXVFB2cjQwdjVCM0lSTlpvNGxFTmxsQjVnNEt2MWd0?=
 =?utf-8?B?eWJrbktoL01KQ1d1bGtzdjEyODRKOWVYLytXOGI3OE1DcTE4c3FQSE9TSktF?=
 =?utf-8?B?TjVUVWNjM3A0OUN5aVJWbGxISHdPRzNLaGtsU0R6dy9Bd0xBNlN4UXkwRHRK?=
 =?utf-8?B?c3VvcFhNcFVKakU1K0t5eVRHaXhOc2M4YWlKUHZDN2kxNldIeVBHOVE1Z1N2?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KIE2ZEHik25js9hJxGMYPBYFZ4dn9CTtSUlJhLjXERmFhh2S1VXrQAeeOrUZ3Su9oTXvxDwrAz5T6LJN0xX2WeugGyLc6qet4WW30OGaUPneuHRizmLZpnBx2nmq/2VoYmn2KJQOYKGBa3dRx+XhbEzQj0ppzkPRQFiFHv++6mF3j7RyKs4XobIB0R0io0wjmyj8xzj0rHHebZoNqg5XTk/pL9W/mDe/9Ol4ydK8kjbyxYipgkhMeuYBEwpcc5lyuWnFWSKdrpNYDOtRIEy5419dP2hGjzWMYPxTU5dtHDhMkDKYsmJUKKdcMSyvr4Not+qyxcrtbvVGhnY90dKjSfQpGFeKb87h3+AYUiMtFFQqMY203LkoTmUg/0GwSb04Ml6ffMo1Pp5eSYA3I3qhXTa5fF55doOBHdKsjw0Fjglf1NdOVLffuZ0/3Hwtk5VVOMyW6RpMIbDQBut3bccUOU1ow4fOwX1/tcNyf1lBDuKiJS4M8+FQpOPp7ADgV7g/GLBY2GQCqJ+ofks1BCG3KphYIdtFFW0990PVzU80RFRScN3Oj7vZPxRHwzXuaY/pZ54vz1+SMWTPrEVMH6E7ReOZzOtJeqcMtW33fGAABIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456ae28b-3c87-4b49-3fe9-08dde18f4e11
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:19:36.4789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4nCHBOE9ariXuVA6Kyde2+HkAokOMDw3KxAMmvo+XZ7W2U4dz+kzvWY7R0PMWN3PwQkfIsygdNcziOqZfRWgEzOwtGICu1WY/APyyPthp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF311374B40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508220138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX54hldbk1crdm
 wXagmVc8zzAYc8rUmTvC6unZdJV66TEW8agDtp93ifrVQW8dHMPkUj4gm1hPZVyexEPjCFu5wTY
 FXlNt5QRlBm3E3opYnZsWZEowejS6SJT3s/gMdmwW94HJf/RnflfukXSwLHRop/c1Lks+qYFX3v
 O+P0ARbVEiGndWmB2Kt+Dt/myqgjgnT65CI60rOqMxrF8Lpj9lQuWru3JAZx6T6v7jmwBlL+2wj
 UjvMhaIL8k5jtPwqrbEt7qRIQd5AkWIQRDIk8D5C62nU2muBx9NViz2nHZ86gyNISmNB55F5f22
 1n0sV+ZsAUAujAJYW41LxeKBmL9YaBWlXirgLQfDECY4j1dQWCUDhp2UuSnd7zHG3VhDSVsQSyq
 2ZFDEuyjQ9JEh8lDmMMaqn/1b7KPCkp1/XQTd9Vki2eA0AoVMBs=
X-Proofpoint-GUID: ZXFL3XDzP6r3AT1SslZPL5q6wfiA4o_7
X-Proofpoint-ORIG-GUID: ZXFL3XDzP6r3AT1SslZPL5q6wfiA4o_7
X-Authority-Analysis: v=2.4 cv=V94kEeni c=1 sm=1 tr=0 ts=68a88a8c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=yPCof4ZbAAAA:8
 a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=0LbV0lCiqCXDZIPF0vEA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 cc=ntf awl=host:13600

On 8/22/25 1:58 AM, Jeongjun Park wrote:
> When restoring a reservation for an anonymous page, we need to check to
> freeing a surplus. However, __unmap_hugepage_range() causes data race
> because it reads h->surplus_huge_pages without the protection of
> hugetlb_lock.
> 
> Therefore, we need to add missing hugetlb_lock.
> 

Makes sense as alloc_surplus_hugetlb_folio() takes the hugetlb_lock when 
reading the hstate.

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

> Reported-by: syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=417aeb05fd190f3a6da9
> Fixes: df7a6d1f6405 ("mm/hugetlb: restore the reservation if needed")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>   mm/hugetlb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 753f99b4c718..e8d95a314df2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5951,6 +5951,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   		 * If there we are freeing a surplus, do not set the restore
>   		 * reservation bit.
>   		 */
> +		spin_lock_irq(&hugetlb_lock);
> +
>   		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
>   		    folio_test_anon(folio)) {
>   			folio_set_hugetlb_restore_reserve(folio);
> @@ -5958,6 +5960,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   			adjust_reservation = true;
>   		}
>   
> +		spin_unlock_irq(&hugetlb_lock);
>   		spin_unlock(ptl);
>   
>   		/*
> --
> 


