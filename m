Return-Path: <linux-kernel+bounces-773897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 077DFB2ABF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868AC1B6680E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7577183CC3;
	Mon, 18 Aug 2025 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SNqOyZJz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LqW89yZz"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD362309BE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528907; cv=fail; b=OI3Pn0jyULJdPu/grFs1uxAHue/ABNdvuclfMjbXIo1ipBdrZvCXyiCL2fduhMQrENXt67eh1FywUcZlRDz72y/fcjtNxQwNejlMC27XqYbS/QxtE51XAivYsNAxREv55MBaTaa2KJcK8yvm6schR9/T/LTMkDpQkCAWH3+LgYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528907; c=relaxed/simple;
	bh=FHwcAyUJx66hlzSjAzpK+nVCUMMf32lRAhjPf0lqnqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E+czVHbLwUVbX+P2DzSbRwYTawx4VXXYRgbGRylhTwnWjdvBC8nEL9vMF3x7otHBvxI1ywIt3Xep6EKBAc4sLe8otTHIGRPVt1O/3ZaZ6YNiWMk1X7aF3KmMepoXs6ocLRGYYYt8HUSKiRqcgHTGH67gqrixBYVBUiFp4Y6ofOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SNqOyZJz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LqW89yZz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEljaG007666;
	Mon, 18 Aug 2025 14:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HVvjP+KppK4ppcfuM/eJ50lpEs0SYlzMTJrZ+oKrmwA=; b=
	SNqOyZJzn2w4OzSvxjmL3e4bDsDMcy7fu6Aedt5/RSH8XlaUlTs0Z+e0HnkE79hF
	AJRakXGU8L6XUG50YBrpSkwxO7MNjCQy3pqflcV6pAu4nQNDu4EvUzY8F3zuHEEh
	FVqw3iJdQSx6avc/af1rYgHRsmINcUedF9oqg82kVa/26pBJns7/tg/e3slUgCgH
	mA1dtqL1kMiMxP41tcMP1gRyly1EHk2LVK93Q9yfMLmzT31o4pLQOwkT/zDg1Msp
	5Up2EMPFV3o6YAUslSQyer6l/9mCHTyqCPIQboc89sNyqZAfMzf2wrGgX3jmazUP
	oti1iZKdpJKvazSfSBD2tQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgs5ka8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 14:54:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IDLplI030994;
	Mon, 18 Aug 2025 14:54:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge8v8ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 14:54:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSByDGRALdhiLfm42LMkRdeYWicdRk1+Af8xr/fDuryoZHrtzkZtRUUJX5Q5SO9xL+hQPfDaRd9FzfpmY+p4ZE4LbmLDHDsKdx+ZZVLaPlxu5vJTyEtXEChivceFqabqc5NAmHkpa5WEvVi6xf2Rt3n3Is/Ea02RW8/l6aYOPbkhjT5+DMhtaVCBx3wl1z3yaeyYHSgXJjF9/4WnQW4qrVJSyKoOkm+n5jzicEJ2CLaDwO6T5VfAkn4MWm9ykgJLRmNSQNf9FgpIWTXqGQfzeE2Nn9db9xvF6p29wfAJ0qTG1PQFIsEAQoUGFm3qreydf+xmzEVOYfZYbC/w6vueZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVvjP+KppK4ppcfuM/eJ50lpEs0SYlzMTJrZ+oKrmwA=;
 b=e1smX8ugwYS5OoMMq7uxKnZIBOPt6oyAqh5eXLFxNt7kCTpxJjxumpQfH5+Avytzn22mQc28YYO3PLtmBD9MAZtqs6dXwXuCyHMkHUhV/SKh1D2GTNUNy9s1bjWni4NQBLb0hiJkT/tLJOdNcYDhdddPAGPsLVYAx6kNPs/Ium5njM0my/CK52k2F/pzyUL/ubNO+cPDkFh2sgbWxSGnQSL3N+fWffK55UYUFfRKOpn7yS55eqEygf8+vq2QeWSbGeNnBvXm4EyAjc7dLq+WNzx5FyyrPgQP4pnhhRQJ1s+NKTDDKbhBmYp+LHEbvh4RqBqJCc2JpoqyXdzxkHSHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVvjP+KppK4ppcfuM/eJ50lpEs0SYlzMTJrZ+oKrmwA=;
 b=LqW89yZzY7DvNPpYigcmIFSof1VQKQfzD1rGJYLOYobRGewjSPU0y0ribyVTTbNjQIHmMmDdz+eMy0yL9OfcKvdnojsMl88AaBXwzb6ksQciJgtvGHnM3n9eGewTJl4E0uYG5FP3jorJ6V9aumswFJJTYU8du4UskFHNvd5JPfI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by LV3PR10MB7722.namprd10.prod.outlook.com (2603:10b6:408:1bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 14:54:13 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 14:54:12 +0000
Date: Mon, 18 Aug 2025 10:54:08 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/6] Remove XA_ZERO from error recovery of
Message-ID: <pgt2ibp5p6ctchyytnftxrgdi4vfngirkwwnu2oiqnz7b3ir25@jenws5mtfe7o>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Charan Teja Kalla <quic_charante@quicinc.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
 <3970cd97-2e9e-403f-867a-3addfbe399dc@redhat.com>
 <ec37a541-0803-43b0-a0f6-aa3b632bcb97@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ec37a541-0803-43b0-a0f6-aa3b632bcb97@quicinc.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::20) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|LV3PR10MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 09795a72-274e-4d3c-ae47-08ddde671818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3ZQS29ISUVrQnU0bk94dU1meHgvUjAzdmdNRWNieWRYR1pXSmxpS2dRaW1B?=
 =?utf-8?B?bVI5Z291L0tCME9nL1luZHdLeDVpYnZmTDU4K3p5czhocFhYSnY1QkpqbXJK?=
 =?utf-8?B?YWNGMVY0b1JDQ0JTTzJWYWdHcGg5K0ZWcDFSUWZDZjZrYkRzUFRYN3MvTGcx?=
 =?utf-8?B?L1pVZTBHR3c2c1ZCZ0NBdXkrZ0hBMlJsbHNJcWlyQytzM0MxQ3A5dlByREJN?=
 =?utf-8?B?MVdZZGZWZVNhSkNkTGV3SjYyZ3BFU1p5LzN0aVFiK3VZQnhOeEk3bWMwTzZu?=
 =?utf-8?B?TENldFVtdG1Sci9McWFaY3R5V0svaWxUK0hvME9RMU4veWlwRTJNblFMeEVq?=
 =?utf-8?B?blRVWXpmZiszMTIreVRCRG4wcTM0MldDdjhuWGpNWEsvRHkzMnMrL0llcUg4?=
 =?utf-8?B?QUpkWldIakl3RXlES3paT2g1Q2dPM0t1MEJGenJEcFAxcElHVXlHcy9ReERV?=
 =?utf-8?B?SVdMR0Fobk5vK3NWYVlCSytkY3R2bllmQUY4cExFWGpXSU1zbTdibmxjMG82?=
 =?utf-8?B?Y1RWZnM5ZHd2Z2RvVUhGNmFHMmJEclNjN2l5T041eVpBemM1L0gyM3h2aFRE?=
 =?utf-8?B?OGhjVmYzR2cvNFZmKzAvWGVzbCsraEducUlZVFdCVjNiczhQVGM3eGNNTlJ4?=
 =?utf-8?B?TGhGU2g5djFRaElxcTM0RzNsUC83eklpM0t1QTNWeFVZTjhwLzRtaGlueThz?=
 =?utf-8?B?U0h1Vlk4WlgxeTZGUjhwZ25DTEFrK1hpUVc1UE4vRWx6UXgxNWZCR3dUTG9E?=
 =?utf-8?B?YllGWkYyeU9Cd29vTU5qYkdNUk1YN25Bbnh0algwWUpvanBNb1MxS0RJSFBB?=
 =?utf-8?B?T1g4MHlNZ3ZCMEJGWlBaM1cvRlVQZ1YxOEJ6bVJBRndoU2llenZMelE4MmVs?=
 =?utf-8?B?WEFlNU1Ealg0V3BlallrdWZYWGQ1ZDZnZUZmRmd5ZHhIVEdDcXpSZUhSeU90?=
 =?utf-8?B?MEx1RGlNTHNod2pyQXFhTzJjbU90WSt0RnBaTUpFaGdiS0NYZnhVWjR2TkhG?=
 =?utf-8?B?S1huSExEQTFPQzI4di8wbGltNjhGc0ZwWTRuUFFBNjRKL0FoOG5oZ1RWTytY?=
 =?utf-8?B?QSswdVk5cWJtUmsrU2l1WWF4Wk92K3hzOXFqTTFBdVhhVlBmWHcvWTlaSGlo?=
 =?utf-8?B?Wkg3VndJMzVDczhTeDBpclZxeTJCaUhRRzZ0WHo5bDFFVm1lbkg2M1FqN3VS?=
 =?utf-8?B?UDViUEF5K0pNQ04xTFhDTE5FZVZlTmNDckJYUk1yTjN6dW1IT1EyMmJnTjVB?=
 =?utf-8?B?cHBsUUgvN05RWlVPQnBlWkhldGo0T3ROeUpGd1NDc3FiMyt6Y0Ntclk2aGtl?=
 =?utf-8?B?U3h0RFRUU08vdDBpL2NRYVF4QWxBeFlHUlFtbTEwWUxDVTUwMHUrOTdaVFJU?=
 =?utf-8?B?Y2twZXc5MFUzU1hnSEt2d3BBeWlDSzlYaGFNckkwaEhIM3hOeVhDbmVYanJp?=
 =?utf-8?B?U0U2eDJEeG9sL3pRaXF2SXovM215YjZTT2dTMG15WWl4ZUlYakl3WVdBaDlj?=
 =?utf-8?B?bjMrOGtvdVhzK2RiUzhNSWV5K3o5REovalJEV1RBU2tGZE9qdTVHb0N2VUc0?=
 =?utf-8?B?Rm1KS1RibWFhRm00Tk1uOXd3Rk9zOE84R2JXM0NOYkQrcmh2N2NkU2hMZjk0?=
 =?utf-8?B?bGFETjBSd0RUcUExNWt0WXVTbzZvS2xYZ1hUUG9BNjVsVnU2WDJocnhFemdw?=
 =?utf-8?B?UkcwcEtvRWJ6aUcyUTN2NkFtaUZCVHo5R05QQW0xZ05BME9OSFZ4OEx0bk1r?=
 =?utf-8?B?dlBuekhvY2RBUEVHVFRHNEJnWktNKy93VG1TWWNEdjBJRXpPdXdGSm9wVTlP?=
 =?utf-8?Q?qKEL55+eMmBAhtscECC9d63d6KQugOPA3NNkk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXVUTkllbkprdEIyQzRyM1o3dWhDSDBJTXAwR1dpMlhQQ3Q3c2RFMzc3czg3?=
 =?utf-8?B?VU1YejhpdGlLNTB6ZDdpT1dWbCtGUGNVNHVuK1pRZmw4RmNCWU9Ba0k5cC9v?=
 =?utf-8?B?Nmk4aVFJSHltTlNLU2VwMDN6djI5NExCSi96NC9jMU1CeWRuVm9hQ0QrSHc4?=
 =?utf-8?B?WHJqSFlnbE9EODlsdWJQa0ZIaXUyQ050RFZLTU5hMFVqTjJzVkFQMjhUek9v?=
 =?utf-8?B?SU52NjBjczE4a1F5Q1BRQXUraWt6dEJYcXR4b01TUldNbTc2Q3FkZElJb2FT?=
 =?utf-8?B?TWR5dFl5OUtIY1J2djdyVTBOSXJReWdLdndKV3FlbGJrd2lod0VqQWpQQm0y?=
 =?utf-8?B?NVdBejcyV3loS1dxUUhtZU9sQno3bzBNcHZhOEV0UHJUUUJIeXpOMXhpMVNu?=
 =?utf-8?B?U21hSFRkZUpnOEExM3RFejNpVXBXeFdtMVptMDhOaUNkT1lHQVQ4SlJSbk1i?=
 =?utf-8?B?R0R2NngvTlg3aXNranRJWEFpNm1nUnU3NmVGMDBBOVZkNGpqMlFOUy8rUW5I?=
 =?utf-8?B?blZTaDArWWFQbnpMZTVCei9aT1Z6SHdtaGM1MVZnN1I3RHJCZUZuUkdyamhj?=
 =?utf-8?B?Ymx4c2QvNnplYURMdzJML09VN1FucVpKUm52eWpSMTJ1TlNmeldJSlFBRG5w?=
 =?utf-8?B?cENHRTg0SVBzYldIdWRCNjN2S0Z2UFBGVy9hRHlPM0hETnR0VVREd3U1Rkxl?=
 =?utf-8?B?TnhEeHdnK042b090eDdHak0yYlNRVThrUmpvMU91dEZOSUZrVkpMRXFzYlBs?=
 =?utf-8?B?WDNxNnRma1pIc1o1ZlA0RVgrYVVXRE00QXhERi9BRW9zS3J6c1ZFTFBSdVhk?=
 =?utf-8?B?K3NRcnpDU3JtSXJvRFZvUlFPdlRScWlYK0dSSzVnQWNYWmtjMVVuRVFGNWpm?=
 =?utf-8?B?QU1YVFpzMHhCcUlHWDhBM2ljQmFlUjlQeENMVm5ZVzhUK2F6N21oMG5RcDhp?=
 =?utf-8?B?RkRtcDh4SlNrWGliNEt0M2lYck5mYU9ORlFJVXdCeWFRRmVoZXNHU0UxNzZ0?=
 =?utf-8?B?VmFOS3g3dGd4aVhvNW0rRU4vTDlyOTlVbG5KZ1lSMVdGTzNjSzlRdWwvU29U?=
 =?utf-8?B?bGVwcXoyd2MxaVB5ZjIvM2dSaVRMbExENkF2ZzBjV0F6S1hlOFRGQ0pSOGxB?=
 =?utf-8?B?NzliMHhXeEdKUjZYUDZpVUNsWWFYNlFvelorSDlLVFUrTDJ6ck15Wkswd1BG?=
 =?utf-8?B?S3pNcXB2NmEyZkJzZFdLWVZGOWNyUm1GYTN1TUR5UTVpSGNITENUSG1rZlZh?=
 =?utf-8?B?ZE9GVzViYWdYd2U1SFE3RElkbWFNdnIxZmpUWFA4dTZvWUVOdnZLakE2ZDNZ?=
 =?utf-8?B?cFUvUlVmaFlSVXI2ZVk2UG1oWlEzWTdlMEJoT09NbDFEdmlBN21yWGlSdDN5?=
 =?utf-8?B?eXordzFNZ0hTSEJOQmlQRFRHVUdDYUtQVFBKMkVuK1VUZ0JVZ2wrT0ZLRFhj?=
 =?utf-8?B?KzFXVUIrY3A1NG1jai9FWDl1RkFKcmkzbCsvK2R1dXNVZmJseTBJWXJCbkdQ?=
 =?utf-8?B?Nys2L1I0a0tzOTdEa0Q2OW56ck9NbWFiOGQ0WnVHWkNVRTBXa3RMUnVjNHcy?=
 =?utf-8?B?ZWt6eG9xdFBlR0dHSnFBK21yYkxFbUs5TEhjbmtKQmNnbDhOVitNTnRQMmxo?=
 =?utf-8?B?bkZudG1uM0NYdmkvY0J5RGxpbWV4T0orYXVUaHlyTjN5TXBXTGhRTnllWVIz?=
 =?utf-8?B?UFRYRXQ3aTNlZU5kUysyVGI0ZUpkeTN4dFFma2o3MXlPWHpLZThobjZ5SjlK?=
 =?utf-8?B?UjNYazdQNEY4VExYQTZpbDhhellCVkxhZElUTXkxY2lNdE9Mc1d5K0pmZzFs?=
 =?utf-8?B?MTF1Z0FUNm96VUxzS0dOZmEwd01iV01ISlZQYm5KTG13aE0vYUdEUlFSTTdD?=
 =?utf-8?B?U093NTc3TjNLcGZCTVZDWVgvdGhPdmhGRmJzWlVEaTUxZUQ2L1RRUHJEalhB?=
 =?utf-8?B?NUNtTUNHNFd0YVRkTHZBaXN2VEZkYjdTYWVGZ0t2UVAyc2Rhc25STDlTN3NG?=
 =?utf-8?B?clYwWU5lTkpiWFE1RG5nYnVZZUg1VXVBSDJ5WnkzN1M3OUNFNkNiaGdvdUdN?=
 =?utf-8?B?Ukk2MWRCTUZXK3ZkdnVpTkR3MHFkekpWbk9rS0ZIK0ZiSXloYVJ3TDF1bklJ?=
 =?utf-8?Q?TX8FD85mlFn7D98h55v/7GCHI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hcGZwtFRsSS0vlHy3xxFVtdjLBO/0L6jQv/xFI5QEu9j5rP+ADvJSLzl+Jw170zb3k6mn+4KsWtPH2jiSSn6mhPdhCtYOULgWJAIPd6BARUTLHSdPHp1rVG1FtV3DchLIRmADCwR0o847DCPk1ixmQBD2gG3miWGk6m6DwAIavSl8i8XUJnZcdrb04/fa5IKIs7AWiVVtYAYoJCLD381jbPyZIoXXCScnMJ0SUX9RgTewWqy+wxuCtgs99UxDGZVl8rE80KwJY+eIcKlS2PNsB1zZg9Dw8bKnVvSiwoHorP9PcpSqsdJLOm7A36PIIOh081PM1pUunhirZZVdKvPstlcLZSB0u5rn+CvsXy+PIP5vro3yX1RPL9YDGv/D1nAxh3QZQK2YPYmj9d+M9ohg6JnSDHvUmhBqITupFEqLbfaAgEDdWsXU+fasb7Ih6N7L8yko9aKakIxxRMuSkAW/yXi/xMe33z38DoqClmMz0lNhFhlqFKEqgDvnxeh4f05Wx+oZnOjNIywmfytQ14MO/h/UrUBY0v5veczCMmLTbH48Rb60wSqR00y+zHcpb/Af0T3uT6gW53KeqdvVfopESTsdTHBRna0qOrsijEwyzc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09795a72-274e-4d3c-ae47-08ddde671818
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:54:12.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYz2+LoCWsyAGR/WgLqsb0Xx6KP+Nni0iu5c0Xu41AlVypbW72rR/wEXnDvxFTZI6hkGJFwneoGRZtJEfU01OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508180140
X-Authority-Analysis: v=2.4 cv=DLiP4zNb c=1 sm=1 tr=0 ts=68a33e98 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=COk6AnOGAAAA:8 a=BbHer7PX1xyIps8SuBcA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=TjNXssC_j7lpFel5tvFf:22 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0MCBTYWx0ZWRfX0R/AzO4ZnsJi
 oBnGCdWVG7fNq3bBXy+4+UyJRZjdABu3HvBxYkk4YDRpZs7ppJKBfQKrcbAsaysB0iPdg4ePk01
 o+9+pTUWVnKPGyJgwPZcU/Iclm2CVtP2rycg/+qw9Wi7+QriMz8PRWDj0rfrxmvvrndjW+lk61J
 4geEAvPswTDm3QyLUNYUpTG5ABxvBebDEdFNJxc6/JfxUAj8VnfNrdjOrbQO20jRFHNaX/VF7G2
 bpG3ppSZBZzn4SPRWQgtB3hUXwPfMXgxsm4uAqeCMIfG1KX6tTiMcDtf9Utj6jOulFXXRXoJabo
 ngxCayFElPymlC0g1/nLcEMo/X8/rNiM3Avcj3p8i7yTICS33lNiPlNGn0NGql1JzUCFfesujEF
 y33OHG9DxZh975ktAiIcU1F2NG5Zt4cqm3CWmYJ0G0r+dYP95KCPRBGu7UkHLKiBwGpTObB7
X-Proofpoint-ORIG-GUID: 3bLDckw4Z7QHp0zZeBygwKfp1CyB9Y7_
X-Proofpoint-GUID: 3bLDckw4Z7QHp0zZeBygwKfp1CyB9Y7_

* Charan Teja Kalla <quic_charante@quicinc.com> [250818 10:27]:
>=20
> On 8/18/2025 3:14 PM, David Hildenbrand wrote:
> >> Before you read on, please take a moment to acknowledge that David
> >> Hildenbrand asked for this, so I'm blaming mostly him =F0=9F=99=82
> >=20
>=20
> Just curious If we can go by the suggestion of mm unstable check just
> for the 6.12, as it is LTS.  I can't see this issue on branches earlier
> to it. As well this patchset is not getting applied cleanly on 6.12.

This was developed against mm-new to be applied and potentially
backported, but it's an RFC right now so it won't be applied anywhere.

I think you still should be checking the MMF_UNSTABLE in the swap path,
as David suggested as a hotfix [1].  Considering it's a single mm global
check before iterating, it should be checked regardless of what happens
with this RFC.

Thanks,
Liam

[1].  https://lore.kernel.org/linux-mm/9178bf98-2ea7-4ad8-ad43-cdcc02ab863d=
@redhat.com/

