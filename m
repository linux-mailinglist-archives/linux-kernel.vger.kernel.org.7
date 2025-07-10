Return-Path: <linux-kernel+bounces-726206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1282DB0097B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C04C57B2FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C375E2F0050;
	Thu, 10 Jul 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TLZnVgrU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LKYbhAhQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F8275114
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166968; cv=fail; b=LQyVF3mjm2EwCqFP7DyMhDw6TYq+PN07F2q51Y6sT75GXHH11Kire2BuKpEklVNbOXyx92CHdJSSv2MIbrjeappBegxtuM1wlk8MLfzCrs7ORE6fyenPwNYm0YwDK9mKMR13w0AOrGqr/hV+gYWOV6vtYmJXo4+BwsSEjQZj/2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166968; c=relaxed/simple;
	bh=p8iDiVLNaRxCfPhEORieZE++SPbMFepTVtgQwU0Ix6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bYGA0QiLwWiHrwNwuPdbOeFpki7f75h60fL+P6i8N9UYNbD70POJ6AtkzO3gdkEJyus/CkMXYNJW7lBtLswYddNU6ovZbomB0fo+gUNiRpQEO9VMvzY1Aa9w6h2GvC5shene7r82Oda2T9ygQy4r+4h7Yk4LTzvUacxUDYjdCpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TLZnVgrU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LKYbhAhQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AGMWE7021850;
	Thu, 10 Jul 2025 17:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LoZmB1Pmy/k52y/VBF
	tZ024bQSc5gQw116ReciHRzkc=; b=TLZnVgrU+wPWv6hgzZ/YhlyBsGwwst3pdL
	XoAx6pIshYUvZ0IRpBvnpRl2rHenlxSrGEaV2K/qlAKAMIaZ2kfPPELaqM5CIkcU
	DrIU73eo53cdFEPR8qBY5AwEMfNfwEZ5uIQuhZxZOTLplbQ1N/mdAjNmxOTVZoL/
	X8MvtMdp4q2OLpPn1DZt9uiS/0dMMuYP1OBKW4XFTYJGG6gqQlPpnJAyBhua9CNr
	N6DROBPdEn71zR/LDAeTSwV6ZZL8bLyjsY4MXUXY8mgzCxPSVOj3Om2aBDwl1vlg
	E46wXPuCVSnvRwGPYStwdlmFmm+Fce0f8r9pOkOEpYyglyomAgag==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tgym02m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 17:02:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AG7o8d014068;
	Thu, 10 Jul 2025 17:02:15 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010057.outbound.protection.outlook.com [52.101.193.57])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcjg3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 17:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbE+N+NrQMJv8APrC1gV5hVZ4oV1bvRH59CBTQGNmD2euXdKKZ7k+WwTHi/KGoD4qjtd3qzhbbgn8lahUMPHTZTrKAgkfaNdoHSQnH+iZC0JBfkHlKDuP5uEBV12TrC8JERH6Kxj1mocxU1DqZslcLSe7fRhq6urVdipkSJcvPbsoAksvD1cqPsfzhDAHq4lSdYRelMm3UQBkx4NMwTRNF2BsSC7Xmj5jGadm1IjQy9TRaEe4j4wfTOlYbjIjzd5QQlkVbPCC+skjSvq+MsghVWMx933ZJYYzDsRspRb4bZYZic4TF5Xujo2eqmK76ZXL1dQ4Ga4OEobW3iwDT0LBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoZmB1Pmy/k52y/VBFtZ024bQSc5gQw116ReciHRzkc=;
 b=lLBEb55IFLyI6yfKIUTrL8YyvdkBBtJoBcU4jbIixD8fO5hFZzCOZO79A1/or3j0G5zkq4bEY2mQ42MnlKz+EvGxS9uVcPD6WbDKQLb//QBEHK865ndIU6fPibAJAlFCeb0pOalSWBPmUmanCKlU98Ox1kpWu19Mzf6WDLhXXCulY4znOTNLZWLGSpq6xRG0QO1v8+Ev04of77US2nVA/bVCSFhcHFYpj2tJiwCdPe7TcwYKtICun35GJX9OU0orNKVJUxG5481M8NXs51XsGzW+n0uHzKWPwUpN7i7xe0+9kYXodrsc1oua2yP1po2ZI5PFKi44FKSPApMN2EB6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoZmB1Pmy/k52y/VBFtZ024bQSc5gQw116ReciHRzkc=;
 b=LKYbhAhQWxFBJ8OPDqwI1PcKOujtaRzo9RCWp2Jomfqg9MmOBMFlNmNfVmF3JOD5QVi0xQQxFiFLob/yLMJN/cgFjz2J/tzHkjctnfaF/s2wjbF5gBTR0lmub9fj9eUWcE6NPdU85LuiWpWhoR7w+0RIJjvt/kCu5M2ozg2ukMY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6045.namprd10.prod.outlook.com (2603:10b6:930:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 17:02:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 17:02:11 +0000
Date: Thu, 10 Jul 2025 18:02:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: implement "memory.oops_if_bad_pte=1" boot option
Message-ID: <5242fca8-4a17-4ff8-a624-08778fc64f19@lucifer.local>
References: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
 <525a4060-2c8b-40c5-b4bd-b9c47de94f0f@lucifer.local>
 <72956765-39e0-445a-b381-6bbc54046544@p183>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72956765-39e0-445a-b381-6bbc54046544@p183>
X-ClientProxiedBy: LO2P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::31) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: b355faf6-9d38-41bf-17c1-08ddbfd3833d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vvdQTqp7/4rnpIwFEuTxvpZR9MGBg88YU/zgp06tq6hFnGn57LPvHJplnwve?=
 =?us-ascii?Q?ojdL44iTcaodgLotbgs2hNvqtr2Ku63hfqpRmpbh7T5Wh0ZvJAwE9t5mYzZF?=
 =?us-ascii?Q?RwAmJt9HUq4AtO04lNI8QVAagvi+EvBdEKXYeRN3Q5HaYeAcNv2gbp4Zdyf9?=
 =?us-ascii?Q?ltA9IUCa92p0FjY9J4T14j0xKNhHS5+jCdhIRM6Ny+/i6pxcupJjCpjK5nKl?=
 =?us-ascii?Q?n+p0NK2nCiiU8Ohoo9+Ov2wvfG1iRs7Gi48FlaEcN8DbjjiBrPVeM9cCi4yO?=
 =?us-ascii?Q?Di8LDbjPmajaKXTUjzzzfcunA74kHINXqoVHiGAwr9riOhvToR2dy5fk7lr9?=
 =?us-ascii?Q?pmNto9W36faWNqehUtuAQxH/11KCwG6p+SMK6sKMRFm7oNiS/sed/pBDeVV6?=
 =?us-ascii?Q?ZZUJJacMnXQIQZh90aaNtc6e8sIKHlNhdF6zsgneVmUrb7NdQG1IvyR/HPa2?=
 =?us-ascii?Q?obQ16/PiEGzbpyPSn6iIEIU5xYy+K2MW3kkABY6k15x8O6+rvUe/KLLnqQsH?=
 =?us-ascii?Q?9PL3VmmFxi2tfrOR+72+0myqyt6Z8lcqhmrvgxcKqiG4+u6W5RQOOK1xazeP?=
 =?us-ascii?Q?PMgJl9mvdVJh3Zj1XKjy7YX4buexuPCIDnOx5BAl8FCG/EGHwU4RmRM4rsuB?=
 =?us-ascii?Q?IjT6dl9ooc4Qmc/b+hJe6fGjzoNDOOQYXl0QGPV+ER2xzU3MdiC4OXwPIlkf?=
 =?us-ascii?Q?vilmb3y3QB2fyGvsmddc5nZsXBxuC/JCljmKftCiuGbW0mmO6zjznOUyrpmb?=
 =?us-ascii?Q?32xLTceiO2gzdkVjt3AuBdCBuGe6/SgpOPJfCzPAFUjPc93iOmV4FTgwQC1P?=
 =?us-ascii?Q?0/DLw4XyELDaSoGMv+CJ0x+hXVjbqZ49l3ORus0ey0jlyCrBuVS+bBaf2bgJ?=
 =?us-ascii?Q?iGIMY7PBsi6WJs+yknhQDrheLvQnBLuYwN+vVr1sts0uw/RTXCVlPOtXx+Yg?=
 =?us-ascii?Q?1aUDBEjkNK1wnuBQYRbKFXqgNSWAc7S85+OqsPGucXAmobBVyAk0H7PLn2qV?=
 =?us-ascii?Q?/4LvxbG0CU70DUj55DsyuQHCkamA+57wIK73Cw8wY6bRoRZZSVVOWi47S0Qw?=
 =?us-ascii?Q?DUUwrQf7yJ8oYYKoyvTWOFG7kXiRuRpeSdgzALgerqUbQ/ibgBFPnqRS+3sD?=
 =?us-ascii?Q?+AdXejnykWa62eRR6Y28aoFSZ2Ditiu8qTlPXIMzQyAoDgfumN08sC819EzM?=
 =?us-ascii?Q?gsSlBVPmQ0ZwICwUCnfxBRTQYYs0JGFYx93lCAbz0+snpdL1fsbhgZSTwf0J?=
 =?us-ascii?Q?sSrK9OCuTmjN4qgNBayjLR+cVw0aQzmaWp8LQ8Zs8F23dwE4Z5QKCqatzydD?=
 =?us-ascii?Q?e785Sm8Y6PJRGBP850jn6KwVk/ytK8v6BjS/hbX3gNCJ8+Vj+nBG3xNtpCL0?=
 =?us-ascii?Q?H4MeBkVXZmSG7sQJTdFm8xTHCdHaz8M8xnd4hPfOaNo9BhGg/Eba9uYyrp/F?=
 =?us-ascii?Q?fqRNoZF62ZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e6fapx/wxvPBi15O8VZEXSPCIJ/+cUM2KYhFhN2jewlmKguEzgyyFzenwp9H?=
 =?us-ascii?Q?vc6T3QHInTyEe8nJHM9x/bfh0HAtJa5QLSp2juj/2JVUJczKJIjWNSHMeskc?=
 =?us-ascii?Q?H1m/DJyGJ8nKlEV1h8rTml0UdfTcFUEzetBtDvDf/XmC9AwddBCrkuwMw/pD?=
 =?us-ascii?Q?8pR0ShbXIuKSFbMrtlE//x8S/kmtk3qtK0cZ0FXEbUbjAfJKFTPg7ImUFiPA?=
 =?us-ascii?Q?krtC1n7ERSYTyiXz6gSWag59oFo8nyFMcsiQHImNbdg/y76YJ6k3+RNJeSxC?=
 =?us-ascii?Q?UZreLwg4YZcT4N+2XUV7RFlLZHM7MVwinmlArGCYGcH8wwFq+2oVGIEO6wfB?=
 =?us-ascii?Q?5BGun+9Dakgv4/tz0xDQlyDKn5TjuqpJIroaL+KqaqGRzn0VC2obtuu6F1ef?=
 =?us-ascii?Q?9ezdhD1UckUa8+IkkzyLS08zA1XrlbMY4Si9ScZpztoDKx8lLUBjcC0NG1hg?=
 =?us-ascii?Q?5w/AIesleveFMBnCOfRaRlsGne+s36A1ZrS8vdIUgXJ31jBSs4G+w3YV/B8w?=
 =?us-ascii?Q?1hbDV7SGra/EilWFMVdyAdtr59VBgePcgtCx8VKo2w8IC46YdwApiamQnsQD?=
 =?us-ascii?Q?bl/f1FrsmC97EuvaCDpnchk6tOnu4/YzVSsV8h3GD6UBNwUdT2NmPiIf/V0V?=
 =?us-ascii?Q?7NfZL5whfPnLYw6FAv6h0MvYKtIArC1jwgP2zDBYKzL1HbR0En26I5XaGbCR?=
 =?us-ascii?Q?vFcpHMiuaBOSQFvrasycpyF+NsEWPtFpW3kRNGpmIiLo4n9eJpJDC4OsnHA8?=
 =?us-ascii?Q?hfjamztmpP1r3Xmd94vsxySeIMB4OmirdmrRe9M7MhluNDY9vlvgO7QZ2635?=
 =?us-ascii?Q?7ezTEKcOotRIQ+72XWoBa4PIbNhDpqpBQ4zd77BfaCFRmrdDT0lHcS0FhoZR?=
 =?us-ascii?Q?txaFdtXtdqhLfqrnNCq+Bfwk+q6FUPR5aZt+7Ypgkaz2gNo/DjdO3LlP5/Pf?=
 =?us-ascii?Q?3zP/lrdS6t9QcTVezpd0QWDxmNv+Z9iy9q0KSEFchmNpe35rG/QrWvhuXm40?=
 =?us-ascii?Q?l/T2S03FTuLXExZym+XbNBdOQpIQZT1USwtKb/NLUmbzMUODiSle2VjsDh89?=
 =?us-ascii?Q?djY0xZXFKxizyJrd6tZ+POL/IDi1dbadjRzG43lSjaCVVDlQeiNbZC+hXviz?=
 =?us-ascii?Q?M4eptLjJPo6pG1Exvyw/aXT1//Fz3i3RHvDe4Ycx5ZFouMrLAZVF58FP+jkZ?=
 =?us-ascii?Q?POcKiVzE7Bp4Pbz37MywQZ2m1Zf0WfiEwai7WpeakKtD5Vm0KkZaMokW1B0H?=
 =?us-ascii?Q?ehVYGhPz6zoc9F5owkRaINiIdlPeYZIqaGZj8q22HGD3tY/Q26sM1S24hwTk?=
 =?us-ascii?Q?WBSXaiOajWBjPbFLSEz9pdgKwxPdMGqQxnLObeUyHZWiEa02CPiVCruGH/5O?=
 =?us-ascii?Q?cpVyLrB51ns6MNPUt8nAIP3qzXV5kId6K44APJD6MXrgqaLwJecqakytVPaY?=
 =?us-ascii?Q?b9ryn9SatM0QoqSmIZyRSnprcBPfMSsAPpoWxt+qAz+RWo8R6GTUZh+F8PAw?=
 =?us-ascii?Q?t6LHeBIt6nadclIlmrlMSjJe0R26Ce5Z1k2ozVe9RNvVXc4Z8+9XBGLR5zUD?=
 =?us-ascii?Q?RZkJR+Uu2ZnWTXX6AbyanYAbpcn3/jYImeaZ7HZL3diJRUbSVFIH1IWhsV8X?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QnFwk+Iw8uY8KmUHewHu0LAvv7/UeUbvwNKOGLKvliNqVKlIdPz5OtQKMccRNUc9/odKlAK3y1+CsynZb88vyWEs8engfrFKkoF0c3C6cKlp+YuoH1UtYXcuD34cCf0wWRb1C0lu3J7Eqhf2cSRTai1oJI/CW/UIQ8i9kKUaB+7yxUnmq+8s8jW951YmAzybdIDTJ2E7nKNiWn+lbc5CvviEXCwHueOZl0941qjloMvVRvX/JDdGrODTYrvBDGKptqOEm8Lgu1vI2MpBd3JTG/IcRQt4Gprwgrr2mhonGlQx1c0Y03QDSBbXy3q3GxI6QbvnW5vCfhxeSukQvBLsDc2NEy9+HznHHffiNuRfFOWqijXDuwYE9lg9fQsfgPV+unmJonlu3GYHkMwa4woTbdPwTw1AOuCND4chWpzqQ+QjpKQBYKGnuEMJiKbtEd8oojiV1BhSQD6gfD5mrETJhKwksc/n9Br9zSuy7/jQZEQvctuks2KdwIOYj1MxG2xwy8qSr285voPKCiUrA56DzN7RwN5DEEbdmzMDrdlQQhgHCe/VNrAfjd+llfLCL1m2h+4+F+7bLcozmc+kCpgnqW1WDOMeJrz0A/b/6cRt7ww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b355faf6-9d38-41bf-17c1-08ddbfd3833d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:02:11.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkXKCf6yTy8cVM4Hw6SqYk6zgqWA7DRXRP3Fi8Zu01/UY7ishWFH8mjzTmtbg2UIdC4C931ncdXc5nuaNQEbMe9hexbxvtxgs5qdl096exM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507100144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE0NSBTYWx0ZWRfX1zDMospsHNFB f6xT/IrZ/YFB7NNhgS3lwnKWp2Wa6InJcjTDGGMWghqDv4H1EcshsPGW7WRiUb1NYtweVbKaPY7 TPv3BaZ6vzYFWcVb4nUHhTlpjgWhASLvF2PHjBQg9CZQ44SNiea8T3+lOynjve60SCR37xho5bW
 fqRfgZ0kmZTGUqHqOvRYoYGSaAiiCcYITf3okqmeVSsmh7aZEYXLbsSYe1qXxvIVP5hi1ARD1J1 fxwc62bnp5OzxlnU+iNgwpxg6v1yIdt5xWncmcFrvGzZNZQrji6qPNHHftUQOCwbv/a2Fj6im2l zjXnomuQFj0pIhp7q9BvNhFD/X2gKC2ezwHqTEFxIXLEIexjsqW69PcBmzzlDgbF1FJ54u1tOeW
 kxv7LJ33KNQ0Z1V26dp9fLypQkI8PHmVksLGilUp23rOSHHy+g46hoZVLFoBuGaFNzmligmh
X-Proofpoint-GUID: 03h-ttHJpQtVxkyvp4PV1JA0fFaoN2h2
X-Proofpoint-ORIG-GUID: 03h-ttHJpQtVxkyvp4PV1JA0fFaoN2h2
X-Authority-Analysis: v=2.4 cv=GqFC+l1C c=1 sm=1 tr=0 ts=686ff218 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=WIS7JU5awbCjlAP0JUoA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062

OK I wasn't clear enough I guess - NAK.

This is not upstreamable, nor anything like it.

On Thu, Jul 10, 2025 at 07:57:00PM +0300, Alexey Dobriyan wrote:
> On Thu, Jul 10, 2025 at 05:16:52PM +0100, Lorenzo Stoakes wrote:
> > Sorry but no - this seems to me to just be a hack. And it also appears to
> > violate the rules on BUG_ON() (see [0]) so this is just a no.
> >
> > [0]:https://lore.kernel.org/linux-mm/CAHk-=wjO1xL_ZRKUG_SJuh6sPTQ-6Lem3a3pGoo26CXEsx_w0g@mail.gmail.com/
> >
> > On Wed, Jul 09, 2025 at 09:10:59PM +0300, Alexey Dobriyan wrote:
> > > Implement
> > >
> > > 	memory.oops_if_bad_pte=1
> >
> > This is a totally new paradigm afaict - introducing an oops based on user
> > input, I really don't think that's sensible.
> >
> > Unless kernel.panic_on_oops is set this won't necessarily cause anything to
> > halt. Really you want a panic_on_bad_pte here, but that would be way way
> > too specific.
> >
> > So it seems like a hack just so you can get a vmcore?
> >
> > You seem to be using BUG_ON() to _maybe_ cause a panic, maybe not, but by
> > doing this you're inferring that there's unrecoverable system instability,
> > which isf clearly not the case.
> >
> > All of the bad PTE handling seems to be intended to be recoverable and
> > handled by calling code.
> >
> > Additionally we have uses like zap_present_folio_ptes() which use it to
> > output PTE state in the instance of an invalid mapcount value - I don't
> > think oopsing there would really be what you wanted right?
> >
> > >
> > > boot option which oopses the machine instead of dreadful
> > >
> > > 	BUG: Bad page map in process
> > >
> > > message.
> >
> > I'm not sure what's so dreadful about it?
>
> Because the root cause is unknown, happened at unknown time, dmesg
> rotated away and nobody bothered to coredump the machine because it
> didn't oops!
>
> > And why an oops is better?
>
> I apologize for stating the obvious but the less time between the bug
> and coredump collection the better.
>
> > > This is intended
> > > for people who want to panic at the slightest provocation and
> > > for people who ruled out hardware problems which in turn means that
> > > delaying vmcore collection is counter-productive.
> >
> > Seems to be a specific edge case.
>
> Yes, but the option is not enabled by default and costs 2 instructions
> on the coldest code path, so...
>
> > > Linux doesn't (never?) panicked on PTE corruption and even implemented
> > > ratelimited version of the message meaning it can go for minutes and
> > > even hours without anyone noticing which is exactly the opposite of what
> > > should be done to facilitate debugging.
> >
> > But are there real situations you can cite where this has been problematic?
> >
> > >
> > > Not enabled by default.
> >
> > Yeah, obviously.
> >
> > >
> > > Not advertised.
> >
> > Umm why? Seems like you just want to add this for your own very specific
> > purpose?
>
> Sort of, I don't want to patch and unpatch things every time.
>
> > > +/*
> > > + * Oops instead of printing "Bad page map in process" message and
> > > + * trying to continue.
> > > + */
> > > +static bool oops_if_bad_pte __ro_after_init = false;
> > > +module_param(oops_if_bad_pte, bool, 0444);
> > > +
> > >  /*
> > >   * This function is called to print an error when a bad pte
> > >   * is found. For example, we might have a PFN-mapped pte in
> > > @@ -490,6 +498,13 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
> > >  static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> > >  			  pte_t pte, struct page *page)
> > >  {
> > > +	/*
> > > +	 * This line is a formality to collect vmcore ASAP. Real bug
> > > +	 * (hardware or software) happened earlier, current registers and
> > > +	 * backtrace aren't interesting.
> > > +	 */
> > > +	BUG_ON(oops_if_bad_pte);
> >
> > Except that it won't without panic_on_oops?
>
> Yes, I'll update the comment. it is supposed to be used with
> panic_on_oops=1 for maximum effect.
>
> > I mean we can't just go around putting arbitrary BUG_ON()'s like this for
> > cases we want data on.
>
> Yes, we can!
>
> > And far worse here - this is a print_xxx() function, and you're making it
> > oops? That's really bad.
>
> It's fine because, it is conditional BUG_ON.
>
> > Note that other page table levels can be 'bad' as well, see pgd_bad() et
> > al. - none of these will be caught.
>
> Sure, I didn't think much about spreading this option to other places.
> It can be spread independently.
>
> > Overall I suspect there's one single case you're worried about, that really
> > you want to put a WARN_ON_ONCE() against - then you can panic_on_warn and
> > get what you want.
>
> Ehh, no. WARN is for home users who can maybe photo the oops and fish it
> out of dmesg and make bug report -- so that system survives until their
> data are flushed to disk.
>
> I suspect users are very bifurcated: some want to panic always, some
> want to panic during QA but not in the field, and then there are users
> whose only hope is cellphone camera.
>
> > If you can make an argument in favour of this that's convincing then that
> > would be a potentially upstreamable patch, but this one isn't, in my view.

