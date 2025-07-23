Return-Path: <linux-kernel+bounces-742177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43393B0EE52
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065E11C26A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666DC1DE2B5;
	Wed, 23 Jul 2025 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e+p6ztKP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T0Uz+SAn"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4A285CBC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262632; cv=fail; b=ZtbGacu8EbaH9mqAS9a3CuaK3MiFO7b+1UupRw8LxULcwW0Vt6fTTub1hGgiG1HMB3Nn28LdJTMV+Cgp2lb5FD0WpzbbjqD2O65JymuhJEzWsiF2+/JVGGay6OF1pBJiexiURc7jXNCAEv7+W8mrGzzAzBUa9VXqRiztt+Ngjqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262632; c=relaxed/simple;
	bh=cKRVUI2pFb0llK7xs+iUssuIVTXRQhqSs1nvwe3Dcvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RU8GRzQJDWJfL+4cEDldz9k6Cmt4dpx80zpFrwufgI9MHoZ67yUQRsyCnVMC5QxmbPFspACrpr/Z3zs6eXymiPG7J6UVlA9hz8B7+A4ApASsi3VAr4h1tGHbr0H+DRyWxD0Unpa0MGu6eutAYBlpx31n4R/7fqzMGkX26B12r5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e+p6ztKP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T0Uz+SAn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8MuaF015269;
	Wed, 23 Jul 2025 09:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cKRVUI2pFb0llK7xs+iUssuIVTXRQhqSs1nvwe3Dcvc=; b=
	e+p6ztKP+MJiewhZu3u/KEbm9UEID18eg6Rt/EmFZokYypr+iTTIzPLnseBVBW9t
	HFhFHPXpNHLUSZSeoBfTOJMCQjWen7VHy21GugzRzor2zwnQzHZPvHKrKLyGHB3b
	WvCbOo/wcPtl5G9l9tBQAMq1LRUK8uOuZxLnMQ8CqQeX9azqI/P0JLqQJ71lqeCq
	1kGwfV06YoTBZ88osmQaa+CqWkjx9vRWx+3G0SbXjzhxP/+/N841334QWNLnXaJh
	/+Ddws/kewgK4nf8r/NmFR17EtC2HpVjaMnzkhi5PNiEk0rRcwJ3bDmaK4VrOOWh
	JyjCK+bPNObUOX0xxWwuwQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 482cwhsnsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 09:23:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56N7lUoi011336;
	Wed, 23 Jul 2025 09:23:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tabfm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 09:23:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbh9y9rvURn4Fnk9vTWmeImQ1OZSiM90nIcVC60iVuXCVqgBPtR0p0Yx+WVybfpoei/3AAD66nLbc5HrKu34t1BspwNrSiQoNJtrs86yK8E+sXfioDqpSrNJdfugcyJF+o9IHUgtAMUtY2oUMODztgfAVX/U8kT6IRCv17LCjl5gWkQ1NWWrpMo4L+Zar20HgRajwxcjtGXmIYFD99q92K3RY0YEY/k13B3139CkbsQESlmNUYic2qAk5aLt6mhmjx76rSVQ/ynjQKYZQo3tIGlub9Ud2l/jeAy6cC+a3yIrPhZOdLwzSJpnEkyiPb3WI2y764TGZfc8BP7Fa+MphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKRVUI2pFb0llK7xs+iUssuIVTXRQhqSs1nvwe3Dcvc=;
 b=luXCX8Tg+GlovWcCjBt4rSjf5NTYUePpbO3pNAwSafSIlzZcsk0DAQAIzmgXohoNRQkFErDVqnNJKDxfbVPU4Xhwn/J5fHFBDQeWm1cCFJbwg4UsIJxYu4nZWlkajc5Iv05+v3MRC78Ocilh/gcuVwpTbTQ3UKjHuEYU5T8KUKpmyDCPqLoUeL4x7XH0QuOyGVu3YCNgNjW15I3OEpQ/lNTBJLF8a/iJeunZu4TBloyl+/nItEexJrGWuwO7GNoNkrYGy3RwcziC/EGL2wZ0XYKEK7j3ZKQjIq3ZjtQrv3XaLW1WOPNk2BDekDz2tI8I/xSnagmxIQKpUFV+/qUQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKRVUI2pFb0llK7xs+iUssuIVTXRQhqSs1nvwe3Dcvc=;
 b=T0Uz+SAn5HX5QRcA8Ggbw3iZLy0pxID2unf226/wQjfz57KxIyRLQSMihM6f97Io0E5b3/ye+vwFk7V54MEUvypjg4cOnUYwnyr1ljcE/e3auu5TyM9DY6jiG0efID2riBwNfu9fGFnERl9ZUZenDwzmLbVf0P3GICLkGPEOYAU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6017.namprd10.prod.outlook.com (2603:10b6:208:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 09:23:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 09:23:18 +0000
Date: Wed, 23 Jul 2025 10:23:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Xuanye Liu <liuqiye2025@163.com>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add stack trace when bad rss-counter state is
 detected
Message-ID: <144a30d4-8250-43d3-8524-a0011f6c62be@lucifer.local>
References: <20250723072350.1742071-1-liuqiye2025@163.com>
 <202507230031.52B5C2B53@keescook>
 <c7a32d87-efbd-47bd-9a18-9eb51e441a7f@163.com>
 <119c3422-0bb1-4806-b81c-ccf1c7aeba4d@redhat.com>
 <8dd1e8f6-f96d-4d36-ac2a-c258ac842f75@redhat.com>
 <5cdd3e44-3e3c-4697-905a-ecc61093f7bc@163.com>
 <fb5426c1-c94b-4e79-b09a-fb6b8b1ce03b@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb5426c1-c94b-4e79-b09a-fb6b8b1ce03b@suse.cz>
X-ClientProxiedBy: LO4P123CA0067.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 094b5dda-87ee-448b-35e2-08ddc9ca8f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnN0NGRwU1JCNFBhWno5bW1WekZrS1kycEFXVENkSHVlL0l5Y01aV1F6NkFL?=
 =?utf-8?B?YnpQa1lLVFVmTVJ1L0taOStnRXdjU3NMWlRFOWUzK1pJQkhzbEw0RE1DdHJx?=
 =?utf-8?B?eDBUR3NmV3FwMEZNRTZ4bHpsU0sranpRTFZ1Rk9kRm0wdkYyZWxWUUJCV25J?=
 =?utf-8?B?aWIvUlJhOVpYdjBkL0V6aDFZT3oyOTNiVHhicDNwUXc4d29uOTl6TTNqak9R?=
 =?utf-8?B?c0NUL3BJR01BeGVqb1N3bm5LVUdmMnZqc3dkME1lTjlDRGFHM3REN1lhOG5i?=
 =?utf-8?B?ajdSdlZkcWdlRVRaVGtVNkhnalhURHN2dmtqRG5XSkEyeEUyaGZicjg4UnZq?=
 =?utf-8?B?VTZadEliV3VOdXRSeHk5U1I1V05mUktvck1BL0dnQU52aE5mdkc5ajhjdXcy?=
 =?utf-8?B?SzNraHA4VEpTclN2S2NhbVRiUnJjZVJYbHNaNDVuQlRWdlg3ajZ1ZUdtTWRm?=
 =?utf-8?B?U0tnZDBuU3BvYnZKWjVCbVo0dk5Tb0hUUDdSQkdnTkhLc3RmRDd0czZTcTdi?=
 =?utf-8?B?V0d6a3BRTUF1OVNKSE9UcENoZlRyRlRCNVNyKy9IT3ZPejcydG01STd1WHFM?=
 =?utf-8?B?SVNOK0Z6a1R4L0NraDVGT29pQkpSeGs5WjRKaW5xN2NOdWdlMW1RYkE5QmRP?=
 =?utf-8?B?NSt6QytkaUg2RnlNV1RPUlpWYkluTnBhazRMV1Exa1NCeFVoZE5CZ1lKTEN0?=
 =?utf-8?B?UVFYMG5aUHVNd3RydmF2YmNNMWJsT0ZHYTh3a1N4VG8ya3VxMFVSRXl3Rk1E?=
 =?utf-8?B?OWRnUGJjcjlHSTQ2TnhNanBMM2tIRFJkQjVETXY4NVkvNWpwSDhTSDRHTkZq?=
 =?utf-8?B?NnhPMkFFM3dZUjM5eFlCOStVNEoyWmNIYldRN29zMUYzQVoyVjUyalFJSVk0?=
 =?utf-8?B?TnRtb09nU0R4bEFSS1BzejczaW52TW9NY3lNS3Bkc0ZtL3dmbHQ4RHJkT1gy?=
 =?utf-8?B?SndDekVSc0xRc0M2UWN4K3AvUjFhaXpkZFhMbk55WWZaZU0zS0pWdlp1Y1VR?=
 =?utf-8?B?c3p2QllaZmlrckoveG41WlFPVkhGLzFLMlN6RisvNjZCVjNRR1BJWXlETEdk?=
 =?utf-8?B?YVJycTJjM24yV0RndDVyS29UanpEbzNzUlVIanl4T0hZc2hWekQ3QkhWZ1VN?=
 =?utf-8?B?U0Myc1YrVXdaR0tqbHpzbWVTVSsyZEdQZkJqUGJiR25QeEZkSEMyeVNIeFFR?=
 =?utf-8?B?SmtuUDJHSlNhWmw3NHpyM1Y5NERtTW1YY3Y2NnZ3QVM1VWhZa1ZTYzdJbU00?=
 =?utf-8?B?K1ZEN0doOXB2cXlnTFVMVjg3RGJNUmpYTkhNSVRRZ0Jkb1JQdlY3bnlSdm1P?=
 =?utf-8?B?bGx2WWl6SkpzU004U09mVnVudHZMOENKeFNKRnFoNWlLMnlKSzh1aHdRNElr?=
 =?utf-8?B?Y0U2NmF3cTgwRFVNL3VLM1BBOGpybGlvRWY2MlVTSXhGZHNwWkRIRGdVNUJC?=
 =?utf-8?B?SDhrT3pUQ2FkZE1sczZhNk9LNXF4d0FGWnJYVGIwT1FpNVdMa1pYUzBCd2hF?=
 =?utf-8?B?YldEMXNEYmxjajIzZDNMY0tYd0x0VE9TV1R4WEVucmxZM2lIcWg3YTYwdTZ3?=
 =?utf-8?B?R09aRXl3cUxKWjI3czFJdmE2dU1qZzBDUkdKSTNlR0lmbUV0cGVvT1FHNmtl?=
 =?utf-8?B?MXh5Z01lYlZWckliSUJOU2YzRmY0SVNyZkZLRG5ZY2swcGVCcmI5K2VGUXpM?=
 =?utf-8?B?VGE5Y2xRRmw3WmFTZlUwUjlFRlZ5eFlyb1NneFdoOFpPZU1jU24wVG5xa0c5?=
 =?utf-8?B?KzdZR0lqQnR1blVWNGlwY0ZxbjVyejhBKzJtd3F6RnpFdjhtakZETEkvdTIx?=
 =?utf-8?B?V1p4THZqLzFianJSRm9xY1gxelJBczNqMGMvdzJzSXArU3M5VjBBTjJZOWhE?=
 =?utf-8?B?Sm5IQ1N5cnJLekdCVlArd21BK1IxTWczZVJUaGFZVXFFSnpwZ2V4T0xNeEhk?=
 =?utf-8?Q?a1Cby14gZTg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXNlSUE1U0xqQUIraUlFR2NGNFRzcTRrVUFMVGZTSURZWmpGaGhXc0c0MzZa?=
 =?utf-8?B?ZXZRQ0xOcHBvNGxIQXV0MmFZQnJIK0R1S2pSTjEvcHhjZWl0a3Z0dTFBSWIx?=
 =?utf-8?B?YzkyUUE2QWkza0FSendCR093NUFpRFkveUN4dzR5NkZOemdyYTQwcXNJb2Na?=
 =?utf-8?B?MktPT3hHc0hrc21UMlI2T0pqa1RRL3BZY0E4M3VVRzdhcytqdG5rWFRFUnBK?=
 =?utf-8?B?Vm9nTms1T3o5bGMzQ1pDTGllcXd1ZFU3OWRSdGU3bzFKY1AyaHN3aEZUaUNp?=
 =?utf-8?B?dHUvLzU0MytZdW9la0hZNzkvc240ckpvMlhoL3V1L3JhclA1d3ZzVTh3Yzg5?=
 =?utf-8?B?bkxJbkhuRisyVTJRMVRMYjd4dEVGc3lNYXBwTFh0M2ZmQjdEcjArQUZ4VTI1?=
 =?utf-8?B?RExkRjZ2SGxoY2FjeXVsZDFPWUE2amgrS1pSeUR0Z2wwaHBWNjBOUTZmYUlt?=
 =?utf-8?B?UFRZMThZd3djUXlIUUhmMEYyZE5hdWxWTlhjSU9Pa3Fka3c2TkM5bTE5M2Ra?=
 =?utf-8?B?akl5UEsvK2NTcC91RytVenJ2Sm8yeFE3cmpaZU5Ha29LYXBuK1Rra0RDaFhZ?=
 =?utf-8?B?YThreGJTTnZxWU1ZMUxab1JtRVg4eGdXZWJDemJJeTJWY2ZFTkhrQ2JiUUV1?=
 =?utf-8?B?ZlVzSjdJQXEwV2xEWnh1U2ZHUGhxMFNHWjRPN1drdWlZYXkzNFZiZFp6aG1l?=
 =?utf-8?B?UE41V3dRVkk0ZW03UUhTM1hveVRtdEFSL2ExOGRLU2dOMC9taEJxMWw2ZEda?=
 =?utf-8?B?M21VZ0lKdHJMazcvUnBvUlNPWmtrSEYrZ0tYSlF0MENDWlJhYnVUc0kxV0VN?=
 =?utf-8?B?QzQ5NktJeEZnRm5Xb2w5UWFKcHc2WGk3TXBqVEt2MWxkYXp6ZE1wVnJveTQy?=
 =?utf-8?B?eHUrTVk3bWNqdVdhSHpSYk1lN0k3ODR5b002UGo5ak0wNUhRQ2YyOGNJbkFO?=
 =?utf-8?B?Q3BEdnRkZkxBbVlrRGt3blNTUlpJNkh6S1llTlNZcStxc3ZzZ3lkK2IydUpT?=
 =?utf-8?B?NTkvRFVaeVhFQWhzRVpzY0J1VTBIYjI1ZCtuMGRrcGJwWFBhZEJMYXV1Qms1?=
 =?utf-8?B?ZEpienBuM3ozNmRhL1h0c1B2cGhHRno5SWV3OXUrdUxhazhSRkNpc3o5T3V4?=
 =?utf-8?B?K29BMVJRV291S2wzdVAybWJFQ0dHaVU5N1U0NWw0T1BWRW00SmZQNDRVUzZC?=
 =?utf-8?B?by80UHhRYVdZTXo3VUQ3M0JFODJrK0syZ1N1VUxzOEozSDhaL2M1RmtPelB0?=
 =?utf-8?B?L3JLWm5sNTh3K0NvbC9qMGtJeXljc1I2c2dGNW11NVdJTWNpM3VqVndGM0h5?=
 =?utf-8?B?Z05OeXJoTmJCYUdLcFpWaU0wNU9IUGhwRDl6OHR5bWkvLzRjVmN5aGNoNGpu?=
 =?utf-8?B?QzdyN1UvZjVzUmpoNE1rZCs4bnh0M1l1WXdBNU9wMVdtLzR4RTFVeHpTa1Zy?=
 =?utf-8?B?M05zOXhiREpKRGdyK09XWHBkSUVsQ0JBdlMyY3NxbWtQZGFkaWIwazlqWXNi?=
 =?utf-8?B?bk8wMjJZZUJ0bzIrOHBVQTVvNHhpVVIycmpZVm5rMG5oMTJlaEszcC9XRS9Z?=
 =?utf-8?B?UngrL3EyNEtmNERPeDI2NEVINTVYcHhWU2NaVVZQR3NpQmdaY29jK1g4UUVo?=
 =?utf-8?B?MDVUOHFFTGxqb21vQ2NEM2pvMlIrbXExY3FiY0xOSmlCUUNxVGMzQVZuN1BY?=
 =?utf-8?B?d0RRNFRBUUFKc3REcWh0TUthVHQxZVEyeWJtQjIyeGVwWk9xVjRaS2RUdlo4?=
 =?utf-8?B?djgyamtyV1owczVrak5GeGFKaU5CYkNpNnhoUHRRamRMVVJEOTBmejZsNTVD?=
 =?utf-8?B?WTZqQW9HNzl6Ykt0VEZScUhaWmdjZzJMeW14OE5kK2tUa3FjekZGL1YrWXRC?=
 =?utf-8?B?eTZsbkZvczdCK1p1UVBRRmRaWUNVN0FXZkk4eHZ6Sm5tS2pSY2RrRjlSSExD?=
 =?utf-8?B?MXRmSFpvSzN1SzBPMWhQdm9rUnpJd3pMQjN2cTIwa2hOcDFxYkdhcldkMTVo?=
 =?utf-8?B?bzZTUlZWY0NlT3ZBM0tiU0dVSy9EM0tUN0s1OXFWUG9JcDJMUWxGR04rQ0U4?=
 =?utf-8?B?N2VrYW5XelFFVlJwbUM5WGh2RFZIY0tqVGd0eTZGZjdEUUZpRHBycU4vQlBx?=
 =?utf-8?B?dVBLRm1oaWVkUldERXkwdk9rVWxZZm1KaW9GU0U2cE1OUUZCNHBiaEUwWk1h?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qoXfi63a//in2o6Mdp8B2/lu2N+k3FSPJ2molg4iIM9KBnGsJTnQWmpCeCqteTs96/B26EeSuNiq7U9Zh8ePp0CraG4T+tVSFHRZiqd4XRmglxKiHag9e2Vxfakr6+yfFBhopKNtQsjMyCxwOW5d3ot5KlUlksWBoe2sFoJ5Cit0TxrJaOciyU+hjKf+0gxTrnGwPleFi4sQMbDBpg5EFdXUc6cOrebuKhX2Ea1l3Ce6uZwB72g0SIuodq+/vdQ/9tiabLvdwauDx7nIjxWdVJzMPYAy9LCXag4YYCuvLBbcAmTbNfIm+cbZUW/lkINE2/gfUzT0HLfKplZT1i1FIJZm7FAy7m3wufauanTOf2Wwi+XjBED+QSuki5NazVMn+ICJhr0bGKFrbdSagVdyUHrokAwhd4HR18MMXlvh8438f/xXlmI8NsaBmMeEYG3wLDLomk0SozLBqHFYRwFrjjKJjehVAhdx7T/zaFNIszzZhKVy3qbIhvvcb1GcxANXPjtcq0cOZBFQiNEzLrA3Gud6GTSZ+vKozaG63n89MOa48YjgbNbGsjZFSOyBP6/mqntqHtl/wKVI3cRlEnRgz3wGyWVq/kJGYlch46uA6os=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094b5dda-87ee-448b-35e2-08ddc9ca8f86
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 09:23:18.5580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06kNB0zNPUhHZpYt1sXzNab+hDaMveuzPGwnkYf1XEASaBOIsENNBZ9L+z3AAX8QLGkKLzUjV60kjNDlM338391HBatOe7dQHZRogwH9tTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507230079
X-Proofpoint-GUID: -t1xzCD9eSzd6F3ZAEgIAwSZdkP8bHMB
X-Proofpoint-ORIG-GUID: -t1xzCD9eSzd6F3ZAEgIAwSZdkP8bHMB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA3OCBTYWx0ZWRfX6fj8lZodLJXL
 0y3Y9jUxo9q8BgxvC+U0YHO/vmcu5p9pHDTPeHLLgWot9Lo8rCjDP8OEVOIYe+UpjqBku6Qi5A6
 Bl5j+NodP3Wkyl0J5lP2cuNHVk3LqqweBrGGQWrzIE8GCfLmQEGo16hl8+Axi3jD7Zy9do+yzsq
 bKgSZwcZjxW6i6yVJxZm9kQm/IA0OrEfSpiF5fJuOBfByXTN25pwNhemWPhluYtSDvHdkWStugb
 IMyqPWt/zv4H1vbQvTDmZoLJrXEPyv2bCxsEFwyXuUZMpKctOaMlEAECI+3fdAsQ8yh23RHya9u
 TjQ6UcK1zwMmkhFK/z7IulR7Zj70KPjiIfv5jshyfPs8K0UefzD34a7IXaGvOSVq5YWjnmucb6N
 tWw1K+9m1wQPqYAeCvIPPfn/KvgZAvTZYlPyClEeqVObRfjwyjh60nllLGjBLqr9fylZNhLK
X-Authority-Analysis: v=2.4 cv=IPoCChvG c=1 sm=1 tr=0 ts=6880aa0c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=xH-5eg9lCkU4znwj824A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Wed, Jul 23, 2025 at 11:17:16AM +0200, Vlastimil Babka wrote:
> On 7/23/25 11:10, Xuanye Liu wrote:
> >
> > 在 2025/7/23 16:42, David Hildenbrand 写道:
> >> On 23.07.25 10:05, David Hildenbrand wrote:
> >>> On 23.07.25 09:45, Xuanye Liu wrote:
> >>>>
> >>>> 在 2025/7/23 15:31, Kees Cook 写道:
> >>>>> On Wed, Jul 23, 2025 at 03:23:49PM +0800, Xuanye Liu wrote:
> >>>>>> The check_mm() function verifies the correctness of rss counters in
> >>>>>> struct mm_struct. Currently, it only prints an alert when a bad
> >>>>>> rss-counter state is detected, but lacks sufficient context for
> >>>>>> debugging.
> >>>>>>
> >>>>>> This patch adds a dump_stack() call to provide a stack trace when
> >>>>>> the rss-counter state is invalid. This helps developers identify
> >>>>>> where the corrupted mm_struct is being checked and trace the
> >>>>>> underlying cause of the inconsistency.
> >>>>> Why not just convert the pr_alert to a WARN?
> >>>> Good idea! I'll gather more feedback from others and then update to v2.
> >>>
> >>> Makes sense to me.
> >>
> >> After discussion this with Lorenzo off-list, isn't the stack completely misleading/useless in that case?
> >>
> >> Whatever caused the RSS counter mismatch (e.g., unmapped the wrong pages, missed to unmap pages) quite possibly happened in different context, way way earlier.
> >>
> >> Why would you think the stack trace would be of any value when destroying an MM (__mmdrop)?
> >>
> >> Having that said, I really hate these "pr_*("BUG: ...") with passion. Probably we'd want to invoke the panic_on_warn machinery, because something unexpected happened.
> >>
> > The stack trace dumped here may indeed not reflect the root cause ——
> > the actual error could have occurred much earlier, for example during a
> > failed or missing page map/unmap operation.
> > The current stack (e.g., in __mmdrop() or exit_mmap()) is merely part
> > of the cleanup phase.
> >
> > Given that, how should we go about identifying the root cause when such an issue occurs?
> >
> > Is there any existing way to trace it more effectively, or could we introduce a new mechanism
> > to monitor and detect these inconsistencies earlier?
> >
> > Let’s brainstorm possible solutions together.
>
> Excellent idea! How about we introduce a function that walks the whole page
> tables and checks the numbers of individual pte types against the rss
> counters. And if we invoke it before and after every single pte update, we
> can pinpoint much sooner the moment it went wrong and the stack that lead to it?

:)))))))

Haha well, I think this might be one of those reductio ad absurdum arguments :P

Yes the point is we can't figure out where this happened in any sane way if the
root cause doesn't have sufficient checks.

