Return-Path: <linux-kernel+bounces-749391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28599B14DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E5B7ACB6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958E8290092;
	Tue, 29 Jul 2025 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ip1YW916";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MJCoxeoe"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB8231A4D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792356; cv=fail; b=mUrVGlzZa730CkL4iBwl4dZP2e26E6SXmnlyTNq08nkg7T8zhw4xGRcM1/4Zrym9MoK4LZGYU/Br9QPa6X4v4yGSx7OEw1g2e7BoWWbnEk1m3Vu69adzJGMpqL24SXFwrGZyGSjZdNFrpw9SWrPKjn9fviUBIbj5NEBO7a57Jr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792356; c=relaxed/simple;
	bh=YXiZnHm9cGflLkAiwPwsdjlPiQezRar8INrvxtbCV2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lldLFAcW6JGEJn56qoRaxdWIsHHZm4NjdJGBScqRY8A4gtuuTQxTPyWAVgl8fg3aLUfE6tbw8fLEZOpxYGReVaUltoenUqp+16aWUqLnf+esEc5p9JhMZY5vjSKBYvX6PiBQBUJfc84SzMyJJ5Jdg/6wsPWB8nN4yBGBsemsT+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ip1YW916; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MJCoxeoe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7g3iY030706;
	Tue, 29 Jul 2025 12:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EtfSiNyUh6VFrY78mW
	HjiOvsrhoRG+n4Jvf6Yy/PR/w=; b=Ip1YW916iSsnxiOMUxKaiYM7k4cV3+Uj48
	6z38pgb3dgK6lNBnFlY6wiEqmgGKS608yHBfx9BzmiqmNFGufaWy+tswqvgOklVd
	ijCCo4M+S9L7+j3jK9ECUaC3OSC79x51g6gUJbC7L1+euTSwxDiHURLq00kM6j2Z
	5tNUSgOrdh2oCbUf9Pujy3boRt8m/m9RT/ZSmK+VGPs0/UJf01Rl/eV5beIV+cs6
	uTlAp68TxN11dprxaY/agk7UrAsH4LWXpbFkby0xoGS7jxKorDr2JTwlxgULbMeB
	YbVWbkS52F+sTZnqbrXenl1uM+Mujaz3Cg4v+1qR7pcFyg0EaRhA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2dyqp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 12:32:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TAbs7f038437;
	Tue, 29 Jul 2025 12:32:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf9kf5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 12:32:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+ZDSmmoR/yC5ym4Dpv7WVdBuP4Txk2lxGPHOGCw+/VydQvUi8/nTBuU137yzkT1VXgQG+54hsGPWxmuQiQ8wK5eGT02lDiJgvkD6bqhrciTpVTTypGnfIR3D7vmSP2lEZ040EP5AYj4exmL/gKdwmThm+6E3/SrM3UZuwo0x7to7SF5fOC0EEi5uhgD7xo99e+R1zV38iCM0JMDmhTd5x3x8t2tTaVRI1N9lda0TXmN4beC/K+LQ7976xd4hgBAZEr4WLs0U+e3KxoOLvoW8g2vLRHqP/xb95RT6ceI9eruFfrghefOmSZmMPqk6BvzZ0+zN6VAPJPE9jQkzRK5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtfSiNyUh6VFrY78mWHjiOvsrhoRG+n4Jvf6Yy/PR/w=;
 b=RwiVqOK9ctX4Nr7JE9Aj/w1NaLUybe7QMExM2u0/Cb9IZ3iI/IXkHNE5nWUkA1d18DAT608UvCSRRbECcxLsSzEvEI4lBtaYuSg2Zx37oLAGj/IohTSL4KSLnmmW0uB83RplQ4DN7NEcFZAS3cfeWpiOZi/Euok0ArQtYfb/Rk4GuJ6YdMXjWeaOh41TCoFxQVYHKcqU70lirIqinNimm0EO2iPGlh7jhik18m92mIoy7gkYuYfH4p/SnB1QrMtMnh4gHGuNh0/1T+S5fydUblv9UXp4jRDSZQfmK4TfKY4tmuwS7AT3nnkP+XjbFBNfDRU6o/4bKPoMmJmpIa0q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtfSiNyUh6VFrY78mWHjiOvsrhoRG+n4Jvf6Yy/PR/w=;
 b=MJCoxeoeapjjtPX6jbT5guAQV4jwbLKDEZ4DPTAEbIN18ggbisv8rcY5ceEy3SnVyWWSUNBtg9PX7qH+rofjYSBa2Babw913/OtR/xGQ1KA/UeKSyE/g7ua2Ui7fqGJ4T2G/OMsH9tleJKnkgj8SRXdfj8nxATG2CzNojKpomg4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4930.namprd10.prod.outlook.com (2603:10b6:208:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 12:32:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 12:32:14 +0000
Date: Tue, 29 Jul 2025 13:32:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm: correct type for vmalloc vm_flags fields
Message-ID: <3c223f62-4aca-4b7d-82e6-a1fbf758de26@lucifer.local>
References: <20250729114906.55347-1-lorenzo.stoakes@oracle.com>
 <aIi6Sok2KmkCaXNn@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIi6Sok2KmkCaXNn@hyeyoo>
X-ClientProxiedBy: MM0P280CA0118.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::8)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: dabfe054-e47e-4ade-66b2-08ddce9bf2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oEz76ZfwT+a76WnSkhRKju1ltFQnshCMYjLU/vSZ4M4EWoSF58hOmGVXW3cr?=
 =?us-ascii?Q?I8X8VOev9SuhZddpagPxYwJBLPxJoh2DyXlAj6eTF2FugTLsjBWmFLu348lh?=
 =?us-ascii?Q?BLo6Qy/R4kmaYHOsZWCOkD1PjmcuGOI8Jh6hxEatmy+5SVeeUjZZ6gUTnXmL?=
 =?us-ascii?Q?PorxA+QGFLvd5UHszibtEZ+CBM0A7N5pY9klYH7TKY6LhLXWdoBCnuy3As8+?=
 =?us-ascii?Q?0Z4rOr35wddX/YM7bYlar6z3Fm3SOQvg5W/czbBnTkq9xOtiT+1JmwnMDXj4?=
 =?us-ascii?Q?uuSlNML0Tz+y8QcomknWUDk2ZqozG9++bjUQke6l3NkgnckiZebqMRXW8qyz?=
 =?us-ascii?Q?XEZAHvafhm2/ktvyjUGJQYNY1pCzXBHJsaH+JugdPK75ePWFI9JNW7qBbCVS?=
 =?us-ascii?Q?r2JgPDVkOKFYTlKTqHLHGa+GHcZlNpDtQR+CHBR4EnjtOArSdlyrUQ/vr4VZ?=
 =?us-ascii?Q?OnkIAobN62mjoFNh6ZliwKR+TqZpr0H3CNnOkYcRJzBmwdFjfKCdjYD0Uooa?=
 =?us-ascii?Q?MFx1+ptiHCeY8ok6Tv+jSgnzI5TntDaNzHcoEmhdyxHuTGuvSjKc9WMY34/W?=
 =?us-ascii?Q?6wQmEfP54U9dEonsZED5msUqEX5wYLFGnUuQnkR3Hm10lOWEmy5uCP+sK986?=
 =?us-ascii?Q?5ydCqh/NKqDVDWgwaf5Ydz2Vtjnm09yuBF/ATUIgs5nlCbPwqB6whSPnh9dn?=
 =?us-ascii?Q?bAvtLAqWwAGBVuTVbIPkrRMEymuj2ct5a2n1a3q81Nzcc0tY+Lf2s4Iq6u4a?=
 =?us-ascii?Q?D2JxNAm4k9VsvdJclvJa1vA2R5FlxIU8HqPIQ0RP/rb+JVpJDD8XTwBDpnt1?=
 =?us-ascii?Q?VS5gpmfFHT70w9CCyQUdIdEqAmJEwpn47jPwWVCLoy7/VJszlMhJATtJLgKu?=
 =?us-ascii?Q?WF+9ieCNQ/sUsJRRL5SA60SbHb5caKdaGpYkwU40XgvYCuwJuKFXIJwEzp54?=
 =?us-ascii?Q?qqDAVp7ZdIs8bz8QnfBH33tl14j7IOBlz434IwwzHxLWr9aQdoji6QizpWo3?=
 =?us-ascii?Q?aLr0R0IlRGLnG41CZZcyydoiBAxNVPlw/T8St4s9fsGuXctgJJpNEu2XD3lh?=
 =?us-ascii?Q?xrYHzbuFf1vOLqK0/xuQsdaq/WUz4ltMy1FvUR7g7rY7F3k+7c6dM2YIRV5N?=
 =?us-ascii?Q?IOFdGsDi9EyrasHqiQ3g0FPw/QdlV8+5ajtFj2mtZcuo5j2PdpltCkCrVFbo?=
 =?us-ascii?Q?LmjrxF+D5DMvqXgBNO+aQ14pdbKwh8mh91qEtfvBiAdIJvqtJye0gqWy3KBa?=
 =?us-ascii?Q?0RsH2neutYG3H9hdQTHMNnGfk9SGRmm/CRIOXqWHJ5lVdbkNSFI24L5KA46A?=
 =?us-ascii?Q?nPESK5Qo/6VF9TkIWd1ZOojHMRi/oItfQcf6JXYCJ06SotQW6DIiwWMDZtsK?=
 =?us-ascii?Q?dRb31ERmnmkBPnbU6sUpbkOPdWxs4kURwc2EsAbDHRJp1PlXPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4yKrr1+Zv0b8zQf+HY0YNkIFhQYibGL+bly7GwKMoN7gCFgsv/YGIeXIKC97?=
 =?us-ascii?Q?8Wa6kDOwGEliQ/gYIREBWsMhDSfOp4hmtX5lDNK2CRx3Vdpe+VQXUiK/Me5B?=
 =?us-ascii?Q?0e2+ZvJuSEYvmqs1Md5MX4NDp8GXejOAtahPIorCUnYlJ73Q604obvmHopJ3?=
 =?us-ascii?Q?jOhwOLPVAmW7QeVEcwFrqD5P3teRwbvJMtfqOZZILxQxAn0/3P56Vje/Fc0i?=
 =?us-ascii?Q?zZoxodo8Zcid4hXcW2S66E+0IDYTtjFpuToGOwKkiKWrP0ML64fu8u5CbMtF?=
 =?us-ascii?Q?TNlPQMvvUlef124XIhvMAj4vWYlkxKiEvZRsCBKi6nC7FCKZJU5Oj+vMjRHn?=
 =?us-ascii?Q?mvdN5+aCRII0iZiAL53B0CBBDB8pW2ZYBhNNmulp4jKaARumfUdRc6dpznoa?=
 =?us-ascii?Q?vYwGxOuQs86rZvS5zWanp/nhAe8M2aMH5wLqNqIN2FW7FJRyUdZZJq14DaPK?=
 =?us-ascii?Q?CUwB6mfHtf8hCacWi2f/9wy6AY8jg3C7Pg8+vi18aPk/TAm207v9MMTyDuEb?=
 =?us-ascii?Q?SyDGIwlkU0ohQ0BlevshXa4EQMEabTWN6COlQEyUv5YTUApvzdyOWrH8smm0?=
 =?us-ascii?Q?PdWm9JBOBqEhLOALa/5gkShf/SeHNy9Bp7Io+AEkNt+DPoztipQRSjf5M+M7?=
 =?us-ascii?Q?e36YwPd9ybmZWRs+rv2gCx3d1/m+fh0wUOjEQtuU3Ao8MJ1WDDx/sGZ8ftUp?=
 =?us-ascii?Q?MtUy5YHQNz66uyVqD1/IPy/nMijvnQaqtTrNYI8KGvZyzzIzdyR814NOaHPH?=
 =?us-ascii?Q?NGHn27tv7cepWFPlR+vRfF3e6PjRa5fOx8pPXeM1CGUWOim1BwJvAqNrTQRJ?=
 =?us-ascii?Q?fRq41b/GZT250inu44tJTC+ljwclSa0wWk5EzqYS09tUavpXH/JUj/FZ2IQs?=
 =?us-ascii?Q?jLBnJwIebAzOJd2QA/ykwamFRFcpa0YNiqrMIInI86bhKFqmKad1NyR92qqO?=
 =?us-ascii?Q?r+HiCamsO33741PUoP/JoZpIUY6BdGdyTtiWr4EgsrZhk5/Kxku+9tQx/rrv?=
 =?us-ascii?Q?5myynPCoDiNEpgTpCGL5BXgpfoQuSDBe5cFanpYMu8nHI49qI/46h/zCgAlv?=
 =?us-ascii?Q?DSxrKGBG60qXxb4eowfb2qsDGMBlQN9N0AEUeaB0jdtfEmI3Jd/PITRquoGU?=
 =?us-ascii?Q?OhKBAW3LIZTrLdax4HQXguW+XmxeFwKYhFV88vx+yCTb+VB64ktokcvaIVtQ?=
 =?us-ascii?Q?TwB+pDe5Lb/MxZfPHMt2fukiNIom4MA5wGdfm8BDjBQZiMMDI1whyd7Uihc3?=
 =?us-ascii?Q?fg2I1QYb2Ns6MQ6+V5f/OFtUEEqRmku10BLwFXXHmdD+dcpwopO4PZGzFHUf?=
 =?us-ascii?Q?ZWb3AejJ+yWX+Tf/UPHDijKci6tz6GSsARZ5FiRVzxaDfOExfZXxVjSztzfz?=
 =?us-ascii?Q?+8HkxiBcCObaDfBAmbk60iRKSCEULpe/N+OyUlkEcG3LdNquVgzaroPYtRaw?=
 =?us-ascii?Q?Ug8EfqsX9cLlPtDP0RVHuIUSDuEBMoRPDOx51nBkv+om6rHoQ2VxG4UXFPK2?=
 =?us-ascii?Q?ZcN1L4iPGavYdx2w4/6DiH1qAw04QAntcBmT40mAki1ebIShLoCCZlkcAXGI?=
 =?us-ascii?Q?plY3mvt8y7P6r/x+coRF4RuLNA52+l0OEpHQHPBK7M9N9YPOpsLfeCqvcCCc?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kLAkECY1hCxDkWW0bVcOEurmGifubad6cvP0S98FmCxqx8gL4bcK9uFg/jXtYTd18K4YTO71UpQPd6SwgTr4CVfzyel3Zbk0oWgbSO97s3AvNVV/fPxrfchur8VZmwY3E3nVKh1OqcFYacVeGjBwHeqB9GyUlt5tjPZar2udjMuOJr050CA1tnaBlZ7QP1Bg3wBzwooIvaCnsZwK0J+SY55xaSKDuLRJdlLKPzPG78tIAcDFgEtSdXXdEhUwsNEpirV7NlJGPq2OC7voGKWYTTdcc5+oYx0PNjK67BBw2R9yXbRYZqzOnvBCVGTLx5JwTV0L5vbJVjhXf9C3lXbQVpDg6eJyM/H1vV1+7refC14XA2mHqHNMcoCf4skIUHkgaWLqJ4ewDWYYgpWiRtTmk50jeBD51vFGyVDVQ6ADBWPT+i7v/CxSpFTPg24K6CQR+xSPDwBIbtwOmA2KZ6ei42Dygjtp5rsGvspcSWZjltKjUZcHxAeZrbIuxmgDZDwzm0OM0036zY+ayVvjjo++PR4jT7QP0QYDGsPWbWlnDoTtJ48NU/9CnMjGUnp1L6i4u/Tz71iW/BYnMAfDZuK3KuwKXSw3Wa8rOnQxHGXBs64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabfe054-e47e-4ade-66b2-08ddce9bf2c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 12:32:14.5302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rO+6vXLCfAALYobq1tmmJyB9yT3acLAtxpfdOJ4Unxait3zS8QagJG50DXPGqtJftM4ztONChHisV007SjN4Z4R26GeUhN2LTm0egYav7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=908 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507290097
X-Proofpoint-GUID: T8LoP9jpOeqB2_vhqMvC7SdrzqLaBq1J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA5NyBTYWx0ZWRfXxOIcXhquD/NT
 YUjT4FtMToUrMs0K38r+S/XSiN8qQhJ/bVRwRl8DaTBWXZ7SH/KTB5ofqYxJHCPjhnCFSZC9YC2
 +2m2LhLoV6NytxTyNvSKNXO21asaeOl+5t35RAkWr/Ts71OsF2nqxDNBKXrC4oQY5DFPANj1hOa
 5DAfdqtZ1s0hz3TA7BmGqFAcGRb50c4itWIK6uoZCa88Cx/Iu97tQFzqNBHe2CcNxA9aZfr0p2n
 CfrQV/cnovzXowEfqIkZy9eaX9u4tZCs6s6+DCRDpOGjVN04cpmRQ8rVr911M7EQtwf33xRSesI
 +iygR73rU7TjKtZrz0CTzQB0bKc8Lrd9LS3iVVj4zjoKPiqM9D22OX/NUmqVW9pgDb88ruf0upF
 4dP470qwtxE8JYxVS7bnVNGni7k3VlQUER9aumQEBpjfiCK1rnSVxeVLrED7TwgLxcVK6EEx
X-Proofpoint-ORIG-GUID: T8LoP9jpOeqB2_vhqMvC7SdrzqLaBq1J
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=6888bf51 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=cUd959i4TrWqWTkY-h4A:9
 a=CjuIK1q_8ugA:10

On Tue, Jul 29, 2025 at 09:10:50PM +0900, Harry Yoo wrote:
> I see one more thing in patch 3 of the series:

Can we please try to do this review closer to the series in future, and
ideally in one go. Doing things this way isn't helpful.

While you're right (this function is just awful, no wonder - struct
vm_struct vma...!), the vm_flags_t series is in NO WAY broken, since
vm_flags_t == unsigned long.

I expect there to be a few 'stragglers' of one kind or another, when I do
the next stage of the work _all such callers_ will be detected (as the
kernel will not compile otherwise).

Anyway of course we should fix this, the TL; DR is this isn't an urgent
fix.

I'll send a fix-patch.

>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8fcf59ba39db..248d96349fd0 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -720,7 +720,7 @@ void mark_rodata_ro(void)
>
>  static void __init declare_vma(struct vm_struct *vma,

^ this is beyond appalling.

Somebody from arm side should really fix this because this is just insane.

>  			       void *va_start, void *va_end,
> -			       unsigned long vm_flags)
> +			       vm_flags_t vm_flags)
>  {
>  	phys_addr_t pa_start = __pa_symbol(va_start);
>  	unsigned long size = va_end - va_start;

