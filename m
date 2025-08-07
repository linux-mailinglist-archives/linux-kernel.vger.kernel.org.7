Return-Path: <linux-kernel+bounces-759142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A39B1D915
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC693B1872
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABCF25744D;
	Thu,  7 Aug 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LGf5Q34c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tts08cMF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA713B58A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573430; cv=fail; b=lwiNnfuqr3Oxqf5dB/vI9BtnIDQ3E3rJIdz1ehxobYLc+O6OUXw+tzVJyCmYKUIakACW4xNvhX6DESiV0h89QnS2EO4rpfeDPHZoUK8+HNwBevNmcPNmEAuEe7GHzqtT52AtEf306MhPEPPSaqiOgoMlG0b1ThxFtNpSF9ikZrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573430; c=relaxed/simple;
	bh=YH2dyv1B5WcBfc0/5p9sQEiZvlfOz7CHFZH6/8vvWC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sAkQT4B7zHRz7QRl4qGUy4LPcg4z7DgZKkeXuReS5vYoYS5MPuLIs99OghfRWDUa+axa+v/T5JoTQMDzHoEPoTELZ/4U6swNC+FFbMec6gg6sFYUl4fBRIfKOAeJwUPafC2TCpEWYOrVrXrYLZ7P52oFU0k4GX4mGuXst+Af1Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LGf5Q34c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tts08cMF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777NHfi028535;
	Thu, 7 Aug 2025 13:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cY7t545g+W1ZA5yvM7
	tGmnU07DYamcBeJm4m9LGWhss=; b=LGf5Q34cBcZW+5c2X6M1NyHuyn+vtJ1bm7
	zU4RTnLC/l/YkvXiLWpfRwzJBCf5CqYnK6giGia6L3GOe3B++ZdsvtSXvL2ZdqWo
	6SrzGT1fqC0dLQhymtEIgpQsxwQstAX4YUQMnqjyuZoCRg5QszRWpGimg8slQNlU
	rdVQYkbwF9k4XfK5itE/iK4cePB/oj3SVSEHqwZgukQDklk0mkGUVNV8KJi5uexQ
	i5gCits2bF31+N45Omh5AwvL+ERf+skqDlie8/0/1LyfNrUhE1I9cbuLRpVifp7n
	O6EBG/8wRaqx/8o1/QX+dXDBG+PJoL/WgVF8+gwy/OnQhFnJsDcw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh41qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 13:30:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577CA4uj018431;
	Thu, 7 Aug 2025 13:30:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwsf01n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 13:30:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nxp3wfPhYt05hAgJIgh/KoU7PlX+ekmAKpcgWlX7bjUVtKxvuI9JH0To/SQY1rOpvKbp+pRd43yWSYDd+oJVb/CxgbWC0eG7cvNsjrB/MvqeTGXYeJHI0NzWARLOAlNmSZtoxy+BuYUhic7YrEC/9PI/jvZ73sRbtWht+2rZkJ90tQ9TV+zletPbSCwTXuFkQL9iEC0dGU2m6TJzoPpTiLMPaf1QNnzrUoNF51byQJ3+vGI54qkGL5r8qKb3hNdAgUA/i6fhMccZMq7nnNnS/pkVvpshfonMwFJNF0vLNqeDf5ZSmx1n9ej8DzEpVhJIZXT5O2grvw1RB+9OsPx/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cY7t545g+W1ZA5yvM7tGmnU07DYamcBeJm4m9LGWhss=;
 b=OHoA2Fcfgzi2DTwMMWzJ4Pmy2LnLIKTbyAk5J+oKyYq+wOg6prjR8uPEWIEGydSPa6TMvxVsrMswcWjAR7GqSqQInsXsjM2LvliWrSwOHGyJjI/cifrFlUDzgfGR4LmFWGbMPcTcjxqmLLYm4pQoGhpG41yrCq4OEVi6jJ1JWNfLRpaJEieMYVeCTIiLCfbA3Z8dO1VnBLYpdEr43/pC6rpTG8cbYPWpj29mc4sda+JxfwkX3FlAsaW9XwzHDEBI1MAVYSWxZhl5SY4I2vVHjwkBg8GStEGdibYcu5KuBmGtftMC6knlDHbEvsGu0vvNl/4m+po02A/uWkpN3o9J0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY7t545g+W1ZA5yvM7tGmnU07DYamcBeJm4m9LGWhss=;
 b=tts08cMFw6Rs9pnUDx5bNfPRWtrSO3rZ6oHbQ5bAGLkRJb1eAczjQELcx10OsfXS0kBgw57eXAbzuH59vh8aWWp5BrVU5Tm/UZIVyjgaXh42ZsaRnbdypNRVYvDk6DYmNmicGhE2c554zsE0yemTFTwwa+I6QvGfL6FhrhwBQWA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ1PR10MB5932.namprd10.prod.outlook.com (2603:10b6:a03:489::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 7 Aug
 2025 13:30:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 13:30:09 +0000
Date: Thu, 7 Aug 2025 14:30:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch 1/6] perf/core: Remove redundant condition for AUX buffer
 size
Message-ID: <9dacc7fa-45c3-40cc-a634-9609c08038e9@lucifer.local>
References: <20250806195624.880096284@linutronix.de>
 <20250806200617.258754928@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806200617.258754928@linutronix.de>
X-ClientProxiedBy: LNXP265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ1PR10MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f4ee7d-ec9d-45c1-4c8e-08ddd5b6878c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oAgkbWI42+YLvOtQ8K8Aygl+MKaOtXwsj4GiMIp/2DTHfTR9Lb7ISx1vWOqo?=
 =?us-ascii?Q?SVOIRccBq9VH27AOOG4zoOYRXA/ug4pe1f6a6rLQXWxUNkZjyjaZyMk6BCqJ?=
 =?us-ascii?Q?HdnINFHJQUJvI2XWjlM8HOp3Xb3rBnScpw7s5QoOt5NmDDyAKv0VULdpEVUf?=
 =?us-ascii?Q?jc+S/VCxr7IC4QYf9DR+K+xLRNwwQ8Xszj+W+ejoQwOg5ix1Vljo+vg81qvH?=
 =?us-ascii?Q?xJG3PwHxkqIuzlKQ8+aibvBh30vV9RermWSssKhAuDcArXFww1KZXlyE/hU1?=
 =?us-ascii?Q?nY5G0JYx5w0/MTa+wClaboBv3f+2y8xgXLO4ufrChrSFX6qKFmSApd2jA9T7?=
 =?us-ascii?Q?39SZp4vlxlPggrj13cjYevXH2PmuNFproxWZS9LlWHAl2cMx5HtpFCYukOnb?=
 =?us-ascii?Q?tCfD0uDaHJZ+PI04m7+P1Wm+WG3keUpQeedpHOlUrPcLFXUWYoCFrjg2DnkD?=
 =?us-ascii?Q?IypstxJp0Uduc7W/Ah+UYx13Wak5XFKJzNQnPUX3/r/ktPzXUIk6CCw0BEnr?=
 =?us-ascii?Q?9tJJMAdi/Ggh2nG73/bH9Z4KDR+2Zp7jHwyyVCBJVzaWuBrj3M4a97Dg/K80?=
 =?us-ascii?Q?7NYywdcPC5JmCjCHfQWIq4npBrX+MVI7bRsYDyzXO5AKTp9sziPloF0I5ppV?=
 =?us-ascii?Q?sZpKxDyFyTk08H6yNXd4HKQdGaD5nU97pgRstcqQHM1SMDTwpDzi2/1xsd0c?=
 =?us-ascii?Q?vm3COvysfTrvkpqgZkMG3ruNXH9JsomBmPkhciVMBVaovDiRjhxd6uEwS7AD?=
 =?us-ascii?Q?c+HS6chjRS0hJy1WIRBB7qyyT9wd9D0opkzj+mednTmmrgUZoH1+6xamt8G4?=
 =?us-ascii?Q?lOE31aRP3eoBy/7vZnwYynJTHbEsiAR7qFJ4hux4aAe8SvdwxpmUup8iUQ3S?=
 =?us-ascii?Q?gCbJNl84iloEPUgueTS6pgiOgN6TN38zHxdSJ92HPulIoOD5pcd6budMaVga?=
 =?us-ascii?Q?+Obqhfa1SmZvTuDLjCdzl0ZUqitvyyvfA05RrSwwxp7FWHzhJWIaAJKTJGfz?=
 =?us-ascii?Q?GIdghmuSk8yDTed7q5c9BJzCRoaw6q5CoxKH0fveZizO9OZxfooa7/pLdvSO?=
 =?us-ascii?Q?DCM5aOGANybhPM0J2EEWaxbeJPg8l6l+lwtziTAm+AbOSbjuEDUhjMJXI5Gr?=
 =?us-ascii?Q?RYecSBrHEbeA54iEeUvD1B9fjAdXi0aCHcoXxiUpwwbAy1UoeSlKLwedy5g9?=
 =?us-ascii?Q?77ECfOKmojr/3wUrtUdk+64oRrSH4TPkAURgiXRZ4NJHvlEyqQEGMVjAB/a8?=
 =?us-ascii?Q?NAqlMu7LZZuP1OdPsl9tTiUj3QofA0OX0qSMeqpIJbACa5yJsfZC59Jjh0bp?=
 =?us-ascii?Q?RWcVkTMb+pDd6uaUMP/AJUxBCouIIAA4gLLFUSEnaaMls7QRU6oDt2+YYIAF?=
 =?us-ascii?Q?p8E/en1Lb+Tu2QvibRwRUX5F3ktJciTdRjQvJ0np+eEL42U1re8LAi+HkxEi?=
 =?us-ascii?Q?sTJs6NeHjKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HH3Ce3IKep9pNPoI0wfUQNzCpAElIDXJHNvuqBYoOCo5sB1Cn0+5ywZYSMOj?=
 =?us-ascii?Q?WYab0gYHD/oxGeSx0f+cjrO2emaLoKpnd5j7zmsgxTkcezYsNMx/7TirfpG7?=
 =?us-ascii?Q?dEiLRZ1YPo9N8quYgvSjKe2I+pJVZ02CiurxPc0AxlkjOdWvGQTkqQSBuxis?=
 =?us-ascii?Q?TFcaUTcvso79FyXIx6jByHIJ4vNlezP6BKSSRHc2B0PJa6Ys5hQw+C4C7YBy?=
 =?us-ascii?Q?xQrvKozsKAgaIq9bh5ZOVWVYEYc4Y+p1CSbHkN3rosSfGV4b2k9iYoY6Tzto?=
 =?us-ascii?Q?SJvEIiQRuR/7+u8C3XQF10ExSu+N6CVaZxG5O/lArkHm1h9il9vNthMg4ITB?=
 =?us-ascii?Q?+Tw/2hAAKPQjChi+cFb1uFE9pUMaPRGR68E6IjbLEwZUwREfaHsNH6TZjApB?=
 =?us-ascii?Q?LmAhHEuLoKogfl5UTui2SZT+eoIFhvTllwTF9FZpyVQ1mZeNh3hjKTbSXpyn?=
 =?us-ascii?Q?UldzyDhN4FnCvdzx0pRFTxtpmm6fz/hQpbyfIq/OhiZyC5yCMhtEgbUJ2YZC?=
 =?us-ascii?Q?BTnsyS+xdFrilO3z/+8XVT7VnAxmnIdDkQICuSvh1YjpNSIUVjtvyO8HGQWv?=
 =?us-ascii?Q?HsrRKUGvrtfBapyxRPMI5M+FWXz89VLkIOH4GCs1xrS4WZADQNb1WMAF4UOL?=
 =?us-ascii?Q?WbEPRU/3gOX7lhtrVFZDN97QQwnUYNy67QyFezS8/NHnmswNGnjYVHARKkye?=
 =?us-ascii?Q?WxmyhTOhe+y6YOUdF9kKTvHQrghYk6egJ0eLshrNdLAN1aq2oXmoLiU3KLvR?=
 =?us-ascii?Q?si3FpRjNIUPWKQ3/B6YfThv3z543PD02I4aNl75U72D8kZGo69G+5FUOkFID?=
 =?us-ascii?Q?9mbLb7uT57pKuWhI4p4jEyyNx8KnB3asDWBLdDjf7iBvP7HyyKn6lyPwY0ij?=
 =?us-ascii?Q?TWPVyA7gzYMQW6LzZuIW55kpv1f+tQ7BQuf52bd0EONEmSTz1HBgy4l7pY1h?=
 =?us-ascii?Q?edd7MG23uTUud2xX6NWJuGgTtBd807yCCWVpCVQwwGDPOko6Z3rXsolkxnAT?=
 =?us-ascii?Q?ANvyVH8RDeVbH/PPbdx5dDSFyzupq99yygqc6RPJN2C2GXsnn1D3Ei7+Tn3k?=
 =?us-ascii?Q?9G/+O2EUHJbD0TBYBv7TkCaMJFSddbRb9MyX++KCirIczIp7Yk1zCs1Minmh?=
 =?us-ascii?Q?9q4T/bc09HI/DdkKNAhYcrlp/KEYHXkHC7j9xZJHYDcRcqnh0v9459w7eLnn?=
 =?us-ascii?Q?OKabH55pFPWwafl3Sezm5pYYJNeMAGcIJHEMnoWTvCSzzmYQT3aIQlkOninX?=
 =?us-ascii?Q?7MeLHdODmTPEsMLv7ZesnQ9r0TIuhOXM4cU69Uty1z9/7+b5NO7g9PrvI0SM?=
 =?us-ascii?Q?u+xOCgUrlIwQg2/g3CJEbs1FVDqi4QGR1ndVNTFTAcPvyT9Go22Tzvigjcf1?=
 =?us-ascii?Q?+Uh3Qxwv73JTafoPWG2Gnn8+SYZE6i7yAUpar8rPIc2wxeRvJ+SU7v3DnE+B?=
 =?us-ascii?Q?af+/731P7eHSi87qwYFnWMWfD4h1JmIAo+pMJ/79ifjNew5620M6e732c5KO?=
 =?us-ascii?Q?TxfNS00Zd4l6PU00PreumXI0HuEfYqofRkSfcYFMcdPRScL761UumSkJA41S?=
 =?us-ascii?Q?rj3KO8KybeUMLdFTu1z1kQtgM2VWrjlsngGO524sDl+9UBX82yKLcVOB1x5C?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YWnHv2mhHBTSJsTZHjUqiQ+QrBJpvXdLm0H3XUK5Fcn20tnmdak2FuJ4GxGvv+3x7XXC4jh50sbpER/T36/BfGgGLMAPsf6Acon1G8TDNsjsMnoBdsiGk7Z/7tuVIgKxTTbPpHyL9lW9Ahbnaha3rnMxy/2RTNp8EgLvMj0KudzGJt9CVX3AK1OgDohfL5UQGm4Kjsz5Kwq/fVlBNtfqTfprlrC8J8AJba+gdvIFsHv4n8RiqtlZsIXJ2wB8ayadtWOlv3Wi4y5ClDi7LUBoc840pp6UFNPU4qPMLtDUWt+Muq/d1lqtndEi05bCHMsZsP8k8ETZKJ+pVLtu5xo2lny+POPUUxhp8al1190bSsgra5RY4mP4u/jq68+1RkTtx4N6Q6d2DYXW5IKQf4lXksD+GzYe3EjhHgJc5na3sZAeHA5Q2vGeyiKOu1cFs9lfGfPc83Sqez8D4DxZniqJnicmv0iHyAQtC8FlJGkHxzUOnC1ZUYd6wixlPs6dGzhOf9mWOIrjXYLtRmr4ZIx9RUdKFulsqH124Zd4BBIW5aHEwsx0c0CKxn6DQazJPb29rbydtKTqIf+pLL3QgBtYvLDtrd/OBnbdx550GQujoB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f4ee7d-ec9d-45c1-4c8e-08ddd5b6878c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 13:30:09.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/9gIyEYj8ToVpezUPSs2sPIBSDY5UCP/kSsMK2B71nzSwPzbrFrSogrxubVt1P3Cdqiitayzj33uhq02Tu5LiAFJ6CzYoBGvXFPcrBg8Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEwOCBTYWx0ZWRfXyYZ0K4o4la9G
 WHRR5S76cpXKtN0DzwD0bjcOdinbPqSUTiUEvMMnvDNVVv8OE08TjqNog4NvhEdM2hvvNAD04QK
 ZUNONeMD+How3Rsq6dz+qFVWBO3sRyIEpGfzKxclbh7x3iCCVc5vPcnvo+3ETu4za2bhdYdemwq
 IB55CNzLDx9Ns8ZfWjoVfW9g5oMYNI3nFpvRW+rA4BdDw6GPEVN+/y6z9RQqbPsPgNbBAKDpGXM
 CMolroPGyj5Z9EN6yXPLTto156DFQaKtojBIFu43jxsL52a7+/pPdV2iffiCdk62xmrdYE0/hK+
 mq5sOpq0RJluBLNctAo0tkO0J/FitC2BbcJGlW28J1bZB/NHXS537O3DVu3BKvomXls8ptbQkxF
 KEfbe1MLpl8qfNnefxMm4h0F29tBPipRsbnS9P07ihyy7Tni/vHDM05+w0aT6x3sCz7Qa0+2
X-Proofpoint-ORIG-GUID: U-bhcKC5hHN63gPVxYW57lCy4nRPpYqx
X-Proofpoint-GUID: U-bhcKC5hHN63gPVxYW57lCy4nRPpYqx
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=6894aa65 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Nbx5DxAGqteFDgi-yIIA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070

On Wed, Aug 06, 2025 at 10:12:54PM +0200, Thomas Gleixner wrote:
> It is already checked whether the VMA size is the same as
> nr_pages * PAGE_SIZE, so later checking both:

Yeah I see near the start of perf_mmap();

	if (vma_size != PAGE_SIZE * nr_pages)
		return -EINVAL;

>
>       aux_size == vma_size && aux_size == nr_pages * PAGE_SIZE
>
> is redundant. Remove the vma_size check as nr_pages is what is actually
> used in the allocation function. That prepares for splitting out the buffer
> allocation into seperate functions, so that only nr_pages needs to be
> handed in.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

So this seems obviously correct:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7043,7 +7043,7 @@ static int perf_mmap(struct file *file,
>  		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
>  			goto aux_unlock;
>
> -		if (aux_size != vma_size || aux_size != nr_pages * PAGE_SIZE)
> +		if (aux_size != nr_pages * PAGE_SIZE)
>  			goto aux_unlock;
>
>  		/* already mapped with a different size */
>

