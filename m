Return-Path: <linux-kernel+bounces-745460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB2B11A46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E9B1CE18D5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500EB239E64;
	Fri, 25 Jul 2025 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pqyPaR4K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fS2qxFlf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D81FC3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433627; cv=fail; b=jpIDUpvc9SpR9AzUdW4BaVI/oPD4bsKMrYwNHJ7TnK6vp3pifUUlq+gk1KyaylTV+FcbMs3e8OjV+DX2SJjVQ4VTLjgpuVPOS1k9AlYldflJ6bPcjtK8JJkGESsvZFn4EdX7bap2qKROKy/DoJl1o2LEJfGhrQmk3uwpXvaX0qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433627; c=relaxed/simple;
	bh=MxYphO4IeJz/6Z6HmWiKdPacn43r4bXrltm1pAe+Zco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hZUXyJgI6jmjkwhyZ4GzhGj93/kWY2HvMzi0nEESuMYKY+QU4CmyWYcJ36zgQWgMrseDba97Hucv5yVoDWMfJd9ucGOC60EHNiNgy4aZv9QgkLoHgONYr3erK1O1TryVH90VoCk6aezjJ7A3AOB3J7OBolU7YGI6HR9zAic2pck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pqyPaR4K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fS2qxFlf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P7fvDS024930;
	Fri, 25 Jul 2025 08:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Xgul0CpU/SfoblGx9e
	WxnEEH1KsH3ISNrZvwdhJQWCg=; b=pqyPaR4KHMEKSdtVAgdKyLRIZEac98j9tx
	oLVNX/not5WeCZQh1gKigySfipvuqxHxD/LVR+s04YxoMdC6jLsMmjBQVifD0PVx
	UXT9Nqpk4pC4Tfu6JfpV4Zej7wnVfRKE7Uar/SFNEXL0mL8ZH6Pn2dq5KnWTpMbb
	X+KnUM5rUMSomMg7kT33D9cbbcaSRG1Y6y4oGHGNOoJZ2O8zA0UKOzoySIPypQOJ
	yJjctrnY3QvOrk96lnbFfHz5nuaML0+wF6yViYr/jtCVMcVuInCOAfkmII330c54
	ToVbvW0a+bpDe9zBrUs0PKI+pf6CVwJBIAlM/LTxmMKA29W2XF9Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1jgnv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 08:53:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8THr4014457;
	Fri, 25 Jul 2025 08:53:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tk63f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 08:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sS4En7Qb3LRz5cmbnyzC7fgdGSL1KUpBS6PMj4ufaynNMUSvkylZAAsEvqhTp8zvzah7goHxP57I4aVUChEHmq8qBpfWaEzK7IDAIuvwDqaDAOa2roSgpfnzaVukIenP7M5BWub/3E5py27AvYSlFtNdRx7uidUUsMJEYSiUoMEgi80lyOu8a2VruDv/MRA7AmRYuG2lQ7cdk0rfvofG4CVrikuPIyEu2w52d55FSCtBQAjVhuIgK7Ji3Vdy4QUiUoIOKvpDEwBE9UwZu6Wpg7eEHymgAaTGDxbhRu7E8oabr8jxXkmGYekjorsITfJEvVX//4NyWLp1+jnze0SEFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgul0CpU/SfoblGx9eWxnEEH1KsH3ISNrZvwdhJQWCg=;
 b=H6lksWX7R8W0OGIBABdc6X8Hw2h0RqXbST5VVD9ELW+HK7SfmbULKFBAmxlHQ6jfhGP//YH0YcD5SeAAOiRAPnVGm/phN6QWNRRvBJ8AeUUpaWQ1RHQ+Vgbvxdaj2Nb185L9L9RucfMIs7ziH1XLjI5sXySE2VLDz+QcGiSuNLjAy9u5BYGBwcnuhH3xMnUJ+ros5I0gpQD5ZsMMIgoFTwxoTigM9wSexsnWS7XS2DqXl3qldfL/DBECCRV7xHIFcf6PqdzHO4/u8ePNXmEcAeEGoP9apmVPudHMApVijzQ21yrTUjfajkJsDqwOHRpfk67MZtMTcPc5BJIviWbHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xgul0CpU/SfoblGx9eWxnEEH1KsH3ISNrZvwdhJQWCg=;
 b=fS2qxFlfojWV92wZ7yU1WJb6Ys4VQcCfK9/Nq1fXfGTmdRgtm+C2A2UmbD7+EBp8YT+zOxnCnQgbH6PGzsXhXGGgRXnu4aqyK+MLjAYYMVqvrZofgoFXRaY9xfJVj/uRobm7qfdIBmAN31jBSx+nGYt2fYcy/m9tBh52wcR4CpY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7494.namprd10.prod.outlook.com (2603:10b6:610:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 08:53:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 08:53:22 +0000
Date: Fri, 25 Jul 2025 09:53:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
Message-ID: <507a09cf-291c-4886-92e7-9d9cc294a247@lucifer.local>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <4f66d89a-631a-43eb-b4f9-c9a0b44caaae@redhat.com>
 <692f9624-e440-4cf2-8202-861c679ddb73@lucifer.local>
 <0ad414a1-9a57-4050-a7b6-fdea08aebbd1@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad414a1-9a57-4050-a7b6-fdea08aebbd1@redhat.com>
X-ClientProxiedBy: LO4P123CA0509.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 25007b92-0d8e-4720-caf6-08ddcb58b5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7YbMwASUHTXr0+9aSAnAZa3smVNtKL7J1yHCW8IgyWjhNvN3Q9UwXOX+Ii9J?=
 =?us-ascii?Q?QCgq7m9x8YUYYdF6RTkYQJlXaV69k1t+bRs65YOKPSou2Gr4UI4GFeGa6eG8?=
 =?us-ascii?Q?WKnMOwanZJL9DmXaK0eY2Afrf5FJn2FL1ajTxP27J9oaeQ3PPHM1tFa9+yQ6?=
 =?us-ascii?Q?t5NQeEn4BQtZr0IvFuXnfgvVCsF5odJkqsGvZN9MESXvuLLxozHdpdj7YmVi?=
 =?us-ascii?Q?i+w/shxrmQm4m+EDebyShEPq1fzXFW9CFVuW/czEH7WrkKXmUNCV84gHmj9z?=
 =?us-ascii?Q?ZDl3EQV5VYsV0q+hANzcPZIUEsjvE/N/w5kTpyNtgMQemirGXM1nJiKEkLdn?=
 =?us-ascii?Q?7TMH3ZUJBmaKpOKAfGc8jV3andM2SEqRNMgl0BWuW+BFZdDmLmcarl+re+PV?=
 =?us-ascii?Q?Cc3Wm//4ixh2FK6BXQr6P3HvZ6JQorMjjDpTHCLHMrWzsBNvBh0J7s8P4p93?=
 =?us-ascii?Q?cQ7XbUqRuqutRZm/owZvc4rkOQLJ/GLerzV5GigUrJOfo4L1uY3LFTqna74R?=
 =?us-ascii?Q?qpngqdukg3sMu4aegnskgUqNDY6qREK1D2iRBGlSvVWQRds2WWCfQRHw/t5C?=
 =?us-ascii?Q?pvfQFanFHtlcivablAiPPYovvYqCt+9EBGxxX/5DZ5/MlRKVpZaZaDQLRoHC?=
 =?us-ascii?Q?Ko1fNWFZ4/bQJkM8pF0op3fg3FVFGxQkfrJwpA9xS/z5IAOzbfEUnEvoPhQy?=
 =?us-ascii?Q?Dv5dMRcIj9rxRH8RxgEtI1hpSLzp8tgBf7KaIK8cAj5hTK4XYMeb2V19AHwm?=
 =?us-ascii?Q?3FgBRVv9JyfZ1iDaDKgUOK7tXexDn8rgnyW3XCSs9IJeH4YQwkRnz7rviXuV?=
 =?us-ascii?Q?8AhHEEflkiDrdhBJFlZlS5mMC7wUm1QglR9hoaltKRhcuYj9wjwXv2/u49nz?=
 =?us-ascii?Q?81V/95xRa2ZXt1BzGsmMEgn48ji3AIjmFkr2Ab09CpcTuRGZESP16FwtxTtW?=
 =?us-ascii?Q?HATVqPcOjp9M19R6iX3IKjoBEWAjs3hrvc4WYkfyiV8gneIL6O8T4uPX+yZn?=
 =?us-ascii?Q?vZjXC4iY6ZMTPCWNuXNsOuofW64evxqQAjott3WNPHMRhn4s6oq1lvSa0mZR?=
 =?us-ascii?Q?ztawCBMW6kQrfVaFfk6ybEVTSQ5D4Kz783q7Bf4whQW9J3bIQWuuwX06v/Rp?=
 =?us-ascii?Q?nZsikt6Gj2JphyC2mUY8SrNDSfD9m6hNm5TV06VV5c5H0+HzrrQutxB79nNj?=
 =?us-ascii?Q?JHpZnX+mFnbErb9kz6khiqxijv/x7I2Ol7bf9zEMaRjLZRYm50R1j2qK441z?=
 =?us-ascii?Q?O5B5e/HfzAn9aNUje3I0GVMFbxMUDmwGYKQXVnq3TjIOr+ZsddnHTITBtvye?=
 =?us-ascii?Q?FwaliqnluV9QKk3RNrCgXC/5IP6AK5UNi2j7LQWNMZDNKFbHmjiWxxyD6Xpc?=
 =?us-ascii?Q?hIu6Ch7zcY583h4PKjfIpFdeQP6HslMUFBxYcEkvHfgx5DqvUAuOW9RNzy9A?=
 =?us-ascii?Q?l7TfKgilNjA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J3bRtFiIl4KSw1Tfw6riXM0hS5j1Ln9JAC/hCULDPucu2WTfJwnx1L+Addpm?=
 =?us-ascii?Q?5so30PkWbsGMkRuzWkmxPPg8GSWJe0A+NjLZ3T4CGcu0ISn0PPb4mrwkhnvW?=
 =?us-ascii?Q?Y3dDuux7d2twavZKKZHzvakCQ/QVL3Xb/aayhVXnMkzn41NwoComDo/xgqP3?=
 =?us-ascii?Q?jbGIEMaSywbfY3mI5U3+LUmZYUZNTv0afqrOh3d922m8kpk7e1SBY9RAA++0?=
 =?us-ascii?Q?cKYMt7KVQQRSchwpFml27EAo6MRPTq67kEI8NcUeqlExgP+muRUD93bYzRZI?=
 =?us-ascii?Q?VgMh3AvpyaYOZcOGZMbOwdf5NaLSs1Bl1M3Tb3OxAJ3B8aZR6RdS+BiDbUZG?=
 =?us-ascii?Q?Qr8oFgImfR05tLZszi8b1LG2e/o8UwrBgD74VoJ0A99h9mQBL81xPKTLdHVw?=
 =?us-ascii?Q?QqauWa9cCj3mzat73xjudD0PBmrRjwVJl/+x1/HQ4dc08/PKgFsUd20NpyL8?=
 =?us-ascii?Q?IA4y/gilsESerzDnY/NOZZxuWcVCY12TVgeulxUs2ZoRbqZRqIMASkVfpetH?=
 =?us-ascii?Q?UhZsQnutnQhmI6wYCEhRcyJDZ+pdHTJtzAegcXMT94krViUDaHKE5XzsBwx6?=
 =?us-ascii?Q?Tkb9vytoDXugwO9KLJBi0qAgBATZPM66/Rbb8p6+qAM83i1VNZsSVSkJKco+?=
 =?us-ascii?Q?K6os7ctv2uL8BvGGCS/JFFo2GIwCm30x02qMFl2A1kaatlVoh1PtHAX4ntMM?=
 =?us-ascii?Q?9ZgSvF0o19iiuOhGL1SSIlXRMauxIqHHNWD94ZBtfDf60DcET67rAzzKpUiL?=
 =?us-ascii?Q?3GebTrVs6TSAUUlckZuTJ/vq2nFTq5HhFzYC562KCmfZwhLxcm62jGGJiMuk?=
 =?us-ascii?Q?bhqHFXYkRsXrwwRY1Xu4lEQIcZSp+ZrEN4S6iWC7sLDtjRoU6ORJvpYKZjBs?=
 =?us-ascii?Q?+fpE8bzLv6pJx4LuTN0V14P8HnES54aQvk8YE4GuKwvHXINK45mVRUDcDX6B?=
 =?us-ascii?Q?QiYFj80T6l3zBIs2kFmuPka5A1Dx0fzteMcPPH0Rtkcfc8oWZDhHVsRKB4Si?=
 =?us-ascii?Q?XjSVAPQtatwMbVbLzpLmSTRTjfNlx6jOsKoXx5JuZutFAAdCWuFp2Dmcl8lT?=
 =?us-ascii?Q?M8mAvjws8S4TyZXkJrs2rFBVsWNcSaRUtq4FFXoDb25OO8wHI4lOfh9/UBK3?=
 =?us-ascii?Q?fOh4g1AZJCaK12NmKPFv0wAf9bdhgjXSIl8J5oAb+aT3YIt3OG5ZW2pw2GRI?=
 =?us-ascii?Q?753NeU4CvogYLujXOq8wMQGEwH52OFgaj0zdA7Gm85ItNTnuuIU1uX0kK5R5?=
 =?us-ascii?Q?PnljSMeepCN7yR+S2GDUXiEDbebTpJd9W4VGwxl4FYle8SapXNaqF5+fCWiV?=
 =?us-ascii?Q?pq8KJM5Z/WwoDZtGCtum/6hJ/dHGDmc7ATdyb96Nz7pS0Hj/k1eUyAKF8q3E?=
 =?us-ascii?Q?GI4esGksZ4QtDhxYNNFLEf2eMcj4OIQn0o0hHl0Cl5usPxzbtGNnaxfeiQdi?=
 =?us-ascii?Q?L3bNLMvp2oEZOQHuY/aY2JFpeVOWN2SjCuOCWT9PJ7jfGxt2ItaOiBTEaNR5?=
 =?us-ascii?Q?jRYGsyfKzSB4nM4smDQCG9EHa6XClenTG/himvfiYdcnzROT+4G+Xjyo5eh8?=
 =?us-ascii?Q?YPLkH/Nq/zwIpL2BYuHluhjaGve5MNzbAfkvMAeS+Lqds7hR0MVikLwkyWpv?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ud4YEmgPsEbajQCAK24fhZlPNVONQXUJhhuXf8wT1Ebe4HpmGsVkFdpE+ytiIIgaMY1Eb4A+l+fK4l7v87Sg+XyZ6JkCnZ9uktL+79QHWeQ7wQio7eHSfBWVqHaxs2QKA2AW7aDk1Cfn3jI915Qap81yIVe3PS7KhQ/p+cf2ovbts1EH+LiD2iLNbKzkYJiyHLH20FRaZ0ahbDTjblFg80xa0Oojl2/xvCeJCc/W5JxmyZ4YXCuSNmDexYuUuHjHT5wgZ+osJMLduByCmkzZ0fYD/TkGD5UPUVmOBxCnysktyNHnbrcUACeJvg+qymc5GaQTnso0R/y0cgI6f/24rXUpa7nBL2hHJV1xBaDkBl6wnHi+ZLrVinpaRQ2iNhVbomeFqycG8AZmwAZUyH/JS+HlK8T4ro3rnpPfmfNtuqfnKIIYK14sqM6LeGFqeW31KnNUUWpzQ51yaptojSLZlHzM3BVgxl+rl2W9pCV/PGA6hrLFPd+d18lEdK8ux6au865iffbvnOx99Q2Nk+3KmaFz3g4w/I+FJKe3PJQMVOrmzf4EyS4FwZ07mpXu5A6KzIjeAWRFPJkrdY85qISUqBaxauNrOGEknctBK9qoeNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25007b92-0d8e-4720-caf6-08ddcb58b5f2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 08:53:22.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OqfKoy0EM2aqgwCXMFBeclrK+9EZI9iAs9C3gTrMSHeUxAZxoPvmpmrQpqelbFYbwPL7SiUP6Dc8ncEGAAbUsuNys/5ZpVwOzRDG0Zkbps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=832 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3NCBTYWx0ZWRfX9gXC1aZin+4A
 9M1vmQiQTtnw5naWAiRswoVUyOsQra9TzsuG0YOO1nQaeeLlwlhcRuzoW6RwQEwTdmpzfEFBJ50
 uoAPSIg8HLhi+0+12pnn0jXVcSXySRAGNjkNJmcttWhVYW7I2VZcMnJEx6mTweQ4lLEznpkrw2L
 j6uwQOPd/vVAUvRGkgvfDNxK+t59JWEb346NsenMyAwKcKn4AThH2Lq90gla/qoIP9SJfiMxy0P
 y1N7Uxf9pLb18ksd6sRRzvZQ3d0m+69yCR8yMhXbG2E1pSwI1FdPfu3OfAOuU34nugN1FoenCih
 CzojpvwWcfg53O6Ca3g7E4ITxy9FEwvOoy238E1ZaWVE/e6UYl6Px1HSffdYX94qUoAP3dezXJ8
 rg+Sg9O5LrWhP7bS76IBRCnqrt34Eb89ZmZYvnIHS01xpJ7w/c9vx03SJeVScJIiHxK9ggUg
X-Authority-Analysis: v=2.4 cv=W+s4VQWk c=1 sm=1 tr=0 ts=68834608 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=pIDhemRFg_0R4HTPZikA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: irpRyWUJt3rZ4a9Pa50c3l43CIz4N7HV
X-Proofpoint-GUID: irpRyWUJt3rZ4a9Pa50c3l43CIz4N7HV

On Fri, Jul 25, 2025 at 09:38:14AM +0200, David Hildenbrand wrote:
> > >> ... assuming we have:
> > >
> > > 1. A MAP_PRIVATE R/O file-backed mapping.
> > > 2. The mapping is mseal()'d.
> > >
> > > We only really have anon folios in there with things like (a) uprobe (b)
> > > debugger access (c) similarly weird FOLL_FORCE stuff.
> > >
> > > Now, most executables/libraries are mapped that way. If someone would rely
> > > on MADV_DONTNEED to zap pages in there (to free up memory), that would get
> > > rejected.
> >
> > Right, yes.
> >
> > This is odd behaviour to me. But I guess this is what Jeff meant by 'detecting
> > this' in android.
>
> It's rather weird usage of MADV_DONTNEED, but maybe, for some R/O buffers
> ...

Yeah, curious if anybody is actually doing this.

> > >
> > > Checking for anon_vma in addition, ad mentioned in the other thread, would
> > > be a "cheap" check to rule out that there are currently anon vmas in there.
> > >
> > > Well, not 100% reliable, because MADV_DONTNEED can race with page faults ...
> >
> > But hang on, it's read-only so we shouldn't get racing faults... right?
>
> You mean, ones that populate anon folios.

Right, but these are the only ones we care about right? file-backed mappings
won't change vma->anon_vma.

Changes to that field from NULL use mmap read lock and... page_table_lock :P
fun.

>
> Well, there is long-term pinning that can break COW and other weird stuff
> like FOLL_FORCE. Most of the latter probably holds the mmap lock in write
> mode. Probably.

Well GUP uses read lock.

FOLL_FORCE won't override anything as we have this check in check_vma_flags():

	if (write) {
		if (!vma_anon &&
		    !writable_file_mapping_allowed(vma, gup_flags))
			return -EFAULT;

		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
			if (!(gup_flags & FOLL_FORCE))
				return -EFAULT;
			/*
			 * We used to let the write,force case do COW in a
			 * VM_MAYWRITE VM_SHARED !VM_WRITE vma, so ptrace could
			 * set a breakpoint in a read-only mapping of an
			 * executable, without corrupting the file (yet only
			 * when that file had been opened for writing!).
			 * Anon pages in shared mappings are surprising: now
			 * just reject it.
			 */
			if (!is_cow_mapping(vm_flags))
				return -EFAULT;
		}
	}

With:

static inline bool is_cow_mapping(vm_flags_t flags)
{
	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
}

So - we explicitly disallow FOLL_FORCE write override for CoW file-backed
mappings.

Obviously if FOLL_FORCE is not set, then we're ALSO not allowed to get past a
FOLL_WRITE and !VM_WRITE situation.

>
> >
> > Hmm maybe I'll soften on this anon_vma idea then. Maybe it is a 'cheap fix' to
> > rule out the _usual_ cases.
>
> Yeah, something to evaluate.

I'm thinking more and more we're probably actually safe with !vma->anon_vma ||
!(vma->vm_flags & VM_MAYWRITE).

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

