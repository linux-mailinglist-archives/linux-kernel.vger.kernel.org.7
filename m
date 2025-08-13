Return-Path: <linux-kernel+bounces-766288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F35B244B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC692A331B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F662EA17F;
	Wed, 13 Aug 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CM5/NFDD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kw17G5vu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE192BE020
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075140; cv=fail; b=gXCjeQwsqmEFbNS0QDYLY0Wp0Nys6zM2fzo32m/vTE6D/Uzpb+0DvH6oI3xacyp+87ibUIplMjGWFTMY3tGqWNrlcOjknwtmG0vH6a4iI7jokdXakwtD0YKFMVvHvs31qC24ZMfbhrEk0RZovOgqYRhKVi5akMpCjSs5MZ1VZJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075140; c=relaxed/simple;
	bh=Q5JnnRPfTnMJvwg9XzYVeK0Dc3ay30pC8WRNRgPfXW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OG0+CIbBMr1jB4/Z127H03nlT800DvyLBfpTkGnmDk/KNX72aEQj4Jh4c+jO0u6wUT2JBPK5e9gdXf1k8TIeubnZiOZZqnGdd3UD3KFNlsEGZI5Xl0QqS+OeoSeAKkqIahL0S62pBLLUekVcgoAHJSrH64uomLMBEiLctD7nzrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CM5/NFDD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kw17G5vu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6u1ec025710;
	Wed, 13 Aug 2025 08:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GTy/R9zCqVqJI+iEA/
	/GhgySNQfQDQvTsI7TP6l7SeI=; b=CM5/NFDDyYF7WfI8rCClDHNcb5eyhcKTlv
	UwbPmNdAjVTpMBuJlco8cN8owFYwU16Dutkhogn2mObLYMio0QN4xyWrc0WVCCkA
	lWbT1R3vxU9TwStjzzej5bzJSS+P1KQNZQOIziUZhmLhaZZFH39EMihCvwG4QESx
	dIL5uMEM1QSUrtgfO1MiAFtlULo+175soFl+QGCnSaVipLb039V6jyKk3h52QbbX
	OUMIJvCXSXQzOoo3f89/CIfdUVClWgPdgdT5Fz9p628fsZ5UeJWdpxOSm0yO7uBv
	4wgV8fbcdahmYn4DbNmPHaViTwK3Py3Dtw4KV0uWyXUtOPbEYorA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf6xf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 08:52:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D7jbrT006485;
	Wed, 13 Aug 2025 08:52:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsax1tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 08:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtRdQkzdKiqoX8EpnpOOa04fcF+3oxVkNDM9PUKldM6YvS20xXLD6xt7hflkt6fbyanWrJLwdXEfNPw6reNjMKfo9muHnprVJwRLxkG1QvNCcDqi66ZmNmj/NnrAvjD0JPR7y0Okntyub+JDvt68DyilSsWqw2dqtltQTXOrNamotE7JakB0rAI4qGXtATLh1FuXC2vf+i0aqANcxrEeSHb4BFIDVtHOz5pJSv3IN4oQTF+RWq0970H015Wkd3fNpVVZTquuphNbu07sBPvnLl570zFdDuqtshCG7uUfROnmKZvc14UodaP5lURpHylqsazpF/dR6G3uRZP/YRxXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTy/R9zCqVqJI+iEA//GhgySNQfQDQvTsI7TP6l7SeI=;
 b=T24i51pDHgOTgRTdwLH1Fkl7mfwwh6oxxEf3PvMv82lDxuy5b9V39YS5WDo/8qnA9QRvs+dkIytVqDjXhgoSlkO0uh2f9Ti72RaeFfgglexc1Xu+tqmOboCjHDLIgNniGpg+E1yBx+d74ZlWb2TZRhD2jdsgBgcxq4F1gTie+xGAfIxgrMr96Rgp+4Um8ZWV4iFcsCXovKzjYm2DhG/vE2SD2NgZfXlJgych9Zevr2/Z2sLs73IheH+anhc9TvUFAPvZVrMcaAuckEMhr7Jsfg1nuBWg38dae1WA68fDlFZFrF7JO16ZzKN8MeATsp7TPDszQ0PN9vMwQDapMc9b+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTy/R9zCqVqJI+iEA//GhgySNQfQDQvTsI7TP6l7SeI=;
 b=kw17G5vu4TnSpmf1FqlU7Iz8FDAI2KpsGx0eP/xHJEoiRWP1JtKwvx2hJkP+LBT/AdC7Ks2oHoouJXon2vBEAPzMY/zvEtUSMdeOpOCQzBgR8QDYMk8Lo60NnZyItR5z5EB1VSnynVDTwTJxk78ZRF+rTE8ZLVmh5vLnQcY7bG8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7033.namprd10.prod.outlook.com (2603:10b6:510:276::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 08:52:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 08:52:04 +0000
Date: Wed, 13 Aug 2025 09:52:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 13/15] perf: Use scoped_guard() for mmap_mutex in
 perf_mmap()
Message-ID: <67684870-bd46-43bf-9d3e-efa9f4074ad4@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.838047976@infradead.org>
 <a9085638-b560-43a6-861e-74e52b431783@lucifer.local>
 <20250813083244.GL4067720@noisy.programming.kicks-ass.net>
 <20250813084448.GB4068168@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813084448.GB4068168@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: AS4P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 228e9d37-37ed-481f-1d7d-08ddda46ad32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UB5Ei5411+2jSAcKmGzYACSde/YnAcBjPNh3hn7BU3Yzr1cb0mycoMaRoHpb?=
 =?us-ascii?Q?HMKTbdwizAJKbvVMmMTM61JdeTFT0jDLhtPPjeGpl4O5C1RHtM14mweRM14q?=
 =?us-ascii?Q?yF71jAZn6ZJFl4H1rlxT/CYEIrSYjRPm8/N2/4qfSq0uXASPhxRjTIkl/a+g?=
 =?us-ascii?Q?M6WgWM/GCS/xc98jAbtsgJww/EXuMkJBDltViA6S0m40/qSDdmLwNiPJfMWH?=
 =?us-ascii?Q?7M4N+W5mXP3JtDexsr5CssBVHYm0zbsYEYTbpK5Tb68f/2zqQJYTkTWWxQwf?=
 =?us-ascii?Q?8Jz5j9p2Ljl6dbYRE8r3kgISiCQvE+epKYKB/elayztOn5L+um1hCtITAU3t?=
 =?us-ascii?Q?0463a9cx3Wb1L54OJodS9fOAmcN8Rh115NKvOt8rn+DUUdLv1LTzBOg2hNom?=
 =?us-ascii?Q?6o5m/heJ2wFZ5Fn95hsEoaaW59+JaksE+0wEEDhDJLxbnlZ7WC89/uZXbm8j?=
 =?us-ascii?Q?pANcLKeHfHZmYkro1sQQsxeUzLVoKf0UIRj5E/cKtfxZkXq6UrLRcdY8Csbj?=
 =?us-ascii?Q?X9vRAm38Pt9GJqowxRc0QI2WXFuFj+olt6hLdGYf07hkEhwl9RK5uq68eCll?=
 =?us-ascii?Q?/zNj4rCozE33+EJ1YizMESmWpV1JnOj1O+4DmXKdqDDsyTHgmArkJqmejNP1?=
 =?us-ascii?Q?NpsiIUuHCt+Bab5OfDYcrHNOh3TqnK/TOR0ifm+8uklRAGc/ZqPbvE8uSW8C?=
 =?us-ascii?Q?ejz07cRUC6yxCLmvgpDYU+LENFRnyrfVST1XClGAp9pkDzDn3QjXgHbQ+ZMg?=
 =?us-ascii?Q?9xwJO9qaYnLAeZp7I3MCfictwot6OzpeCQFRzU/YR+3Ix1RJc7P/zJpEvspf?=
 =?us-ascii?Q?/HdEUNYcfXYF3JFGSdCOe9nbPIie9nj1+Lo9iufxH43oC56TxsXz0AjwkklV?=
 =?us-ascii?Q?x1idQsPfT/egfnfNoMV8hQl4rW1LsQrmwUFMVPD4r27cB0pj9K67F+7Umz9D?=
 =?us-ascii?Q?nqPW1f296fezrZ7CAUBmHF3Gcjrgg4G98T1ih0BKu4/bUPvLEIBA/TaeVu+c?=
 =?us-ascii?Q?9d1el3JeQUoVagtB84R6Kz8q1w/naS2YdnXxr4B3Rlqs7LHt7dMXG+XNr73k?=
 =?us-ascii?Q?MzrsrZt+/3EZRFPWOnY6a2Rg4EMDzi7Zt7egDXdK15H42tqM4avxbO2JYB3b?=
 =?us-ascii?Q?x1uLJv0lfSW48zURN2RJIGHW1hm9CIZwUvlTn/E4wQDhq1L71UVGIrQv9une?=
 =?us-ascii?Q?ausq5YQAKzDj/34MiZ80Py1J3eDrGr0aHoZ6yd4guWthSYNdBHSQhkSM1MHO?=
 =?us-ascii?Q?hUxatIrB9V2vTorurTSmj0chR0BdINt6LzKl8VDpvi4etxKN04424QvRTbsP?=
 =?us-ascii?Q?lVUv8kBQLJgxIFn9sY9yT5oN+zr5Ez6OldkhGUlliyntkEfgTC8OKyLiOCFk?=
 =?us-ascii?Q?0rlwe7ObvfilxSy/rRBywDLNzzy1fYJZKNif/0yRJMNtmwMVce5Nl48J1nlL?=
 =?us-ascii?Q?18sRr2k7pDU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lguun7Uaae6dPXuKt6BSmGknfQhaFxYcqoHq54UQkwyM9ikahOfKpmIhq8M7?=
 =?us-ascii?Q?bf0SwJUZoVej2kUxv0wQBhRjCYUuiaKF/lS4PfS0CCBbrLXigxZnZlrbBdkG?=
 =?us-ascii?Q?ZrFKGswdjjl0Dp5w7ICmYboYdeb3cpsQB70YerqLLmZKVCUit1UxWQIA6nNa?=
 =?us-ascii?Q?uk8qWZm3Rsafk3zZLRCwJRlqiYqG9kDTVbBbaDJ2dCeKj6U1qS0ua8sd4vX+?=
 =?us-ascii?Q?S13IqW3dD29GDonZw52OQK3iJMM/nYrOI5e54G8dDAvvQewfxGoVtkaEdq4u?=
 =?us-ascii?Q?QrDhzHhtsSaiowQY9/ir2YVcS4Z1v8OMN6Rie+pYYT/A0sWc9sSHpjg3KX5t?=
 =?us-ascii?Q?0GDdpUAKd4brFIk+K8tcmf8A6DoPZTPNY5a2ZOajnTGAw9TSbKDprr0s7Vrl?=
 =?us-ascii?Q?VPlF2KS6wBM32NKb6MXQHA8iftvrpEDhAG/5XqGM9i5k9S8/M0EXugX9ch9r?=
 =?us-ascii?Q?qoTQ72b22NgHbrq5Y2tWLCcea2gxshXEZLf8ruh5ixwWwRsvr5VGv97IvVvu?=
 =?us-ascii?Q?o/XTwqAxowAn+AkRppO95tKaucN2ueeoPW1AcxZuSUBtYpc90CPNnd49/6Vn?=
 =?us-ascii?Q?JFJyZtz2wlFSc5m4yrDyBdqir80AYzdae1Fvk+BowvfSPzGApkKA6FlDD5yd?=
 =?us-ascii?Q?n/oxU1hOQrjHCUuplscGIYc/na01yPpjGZgUzx2rfAYXrzImtoZ6BunFZKsc?=
 =?us-ascii?Q?MJTn0LjmUdIo05tRTGakre2zAx0WHRFMJ+8UqUs0BPH8DtpREgPOYDl2YIzF?=
 =?us-ascii?Q?BdgDdtYHzjDQVUBGpU95AhEyNRWKHYfEzW7kRF8Old5M6W19typF2OoJ0eum?=
 =?us-ascii?Q?9YoL+vX7CJqiOJwuavZun+ENZlJ5gzSG76cUF4I92aNyNWzAko73ksFqVtdT?=
 =?us-ascii?Q?IBbiMnsmikU7xC83o5jsObd1EtYmeSNGuR6wzlmkiRuKF/DrpjqoSO8iykA0?=
 =?us-ascii?Q?OwTuhLDPsC5HBXNF7OnOELzFoCsc1G1FWRoLj/rDy4akzj5Lm6t9NpmMPV7W?=
 =?us-ascii?Q?Pavf0QFeEc1OkEs8r+fcOdzfzO1+7o/P/OarJiep2EtoCf1BbHsM4PF1h3K9?=
 =?us-ascii?Q?nOHOGlwqMkK8fX655UTtxpJMJgM0OguXmwfp4IbDuLzJwjTelKbWd7V/qNj8?=
 =?us-ascii?Q?bz3le/me+COjgUs05sEGjW/fwG+OpktCt1WrNalm7BS5GzcAtg4GkbunUAI0?=
 =?us-ascii?Q?A/UEK2IEbnM6tMOciz59LrXepH1EWvZtSxV6o1G8aTtLAysc6VmrhoMIoLjs?=
 =?us-ascii?Q?1qzoGrarS0Gyi3bokaAt7VmOm7VcTYfsFG5ZIrEZZz0kImf5dVpnpNXjq8QP?=
 =?us-ascii?Q?M1hltpkIl5p2Ua9nij93GM9pX2qVQkZ4iCxdzMpqeOmumH7mDqA7hTVT3Z1i?=
 =?us-ascii?Q?DhfABwa7WRA6bDxcYsutBkK8xfyvVlutNxu/PiR1ZoD5CfIo6w3YAk4uIdXI?=
 =?us-ascii?Q?Y3l9UWyKsaGE9Ur3OvetoqSU5vz7pgvB+PcTvUtpb+0PAPdDbm6WsOgOtKvP?=
 =?us-ascii?Q?2pUooBxZZtumF9lLG8X1jBh+xT56HMOEvPET9aNhRH5AVHHiYVppi5ymHKj8?=
 =?us-ascii?Q?4bzwuCrE0tJJ+nLXhxi+WoN4c0wNbOEFTXWRUK9EChg+RVv+h5N80WMTwHeb?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	48mRbNGyXBPi2OgYJJr7fYNaqMLy+nht48tCn+nOpSivWdIObG0VR2gLOsh9U8B1cvowKjrTXKM40PmDpxj8Dj4dXQwLsnGvzxpQTEoYXReda7hoF3mB39LmKs5Xjsk1mfeQvGlEr/a2KHq1RNFWMo+6I+l9AaxqhsURX2mKEPallNAE175xySJrGyLVXqI8vjwtaa5mgIt/Xuk2u43HG0q71bO2I2xwwqqsTUmKO4X/SXnj0wsUnzE+kl4JA3iQnQ26YcW325Y7cKaitp2twYwDaY3cDVAPz0c0nEsAa3V4Fv9CK5TZxefWSjT6PDu2I6GSjOwDgJSRdrD5ZZD4iaHEO1GLDVFIFwstmr3lBb91vUOs2PdK/dxgMcNeLAyKP/B640repUx41xWW3swErfYmLPQMb/rbe1P8Ygd20rRn5ipvDoyrP2NwF22OGSCUsVfflRAUXRoW312mFL9j21n/etVmoDGPUSYUoXhPlZ/Unnmh6dtjFXJWFij8kKkFhL2KgkwWXsuh0j8KOqPfCz6DpuJ9pXG84Zx8Kj3GSIo8C24dWsrlBHjvvJPAtDJDzuxWcnTbnG9d/8abyVcgI5Vo9pPsZ693HRdAG8bOUtU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228e9d37-37ed-481f-1d7d-08ddda46ad32
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 08:52:04.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/KjJDw9hp/YGA/jRAP3OcEqenHtmwCvjO/IF2S+Ry7UHxttm7OWJx/s4Zw7ebgBhDPFvatMcxBRjV/vbvzaqOS+ltJy8SIswYgTX3R6mLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=770 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130085
X-Proofpoint-GUID: L_3ptqkrAIJ53dD1oc0fqE7sj0FqNQnh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA4NiBTYWx0ZWRfX2v0M5EtylnBG
 uZijNJHbk2BZX5NA76phmuEMQvu6L+amnYGOg8FCEw1OSR+DuBy/XmvDBCrtzTuyqd5z7H4kvdt
 Iw9VCKSDVZ175++Odcweybtm6FYjOZ4pg839d9JdbCNS5auaxpJQvpExgGE6w3r3cYGHFK5jl/0
 qTliis1G3P6W1GyAOwQb1OOyHqBtZv548hEL69eU7x2P+T4oFXKr6KPvrY3xyDUWmYI8UnMyd+1
 h6pV+cWyX+aLWdheDHMjZxuLoH2xJ+sl1l+1vaPAu9IsMl7Ac7ECvWEw0f287qr5xfSmOGCyQQ5
 06Th07JZgqI8HRriW2TiEzgBP1EQ0VEznfTsGQoRS8kWWPmrUxkCERqkiD8KQRHLMvdjv81qoz2
 hys1MVRHLyXQgkXgAEZxtTGoQN3/TlXdLiLkEo54r8JOvtXZ24fKLK12fBElSmBHwSelhc6J
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689c5238 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=b0FozNJ2kqB5w7Ik5jQA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: L_3ptqkrAIJ53dD1oc0fqE7sj0FqNQnh

On Wed, Aug 13, 2025 at 10:44:48AM +0200, Peter Zijlstra wrote:
> On Wed, Aug 13, 2025 at 10:32:44AM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 13, 2025 at 07:42:41AM +0100, Lorenzo Stoakes wrote:
> >
> > > > +	scoped_guard (mutex, &event->mmap_mutex) {
> > > > +		/*
> > > > +		 * This relies on __pmu_detach_event() taking mmap_mutex after marking
> > > > +		 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
> > > > +		 * will detach the rb created here.
> > > > +		 */
> > > > +		if (event->state <= PERF_EVENT_STATE_REVOKED) {
> > > > +			ret = -ENODEV;
> > > > +			break;
> > >
> > > I don't absolutely love this break-for-what-is-not-obviously-a-for-loop
> > > formulation (I know scoped_guard in practice _is_ a for loop, but obviously
> > > that's hidden by macro), but I guess hey it's C, and we have to do what we
> > > have to do :)
> >
> > Right, don't love it either, but the alternative was a goto and that's
> > arguably worse, so meh.
> >
> > > > +		}
> > > >
> > > > +		if (vma->vm_pgoff == 0)
> > > > +			ret = perf_mmap_rb(vma, event, nr_pages);
> > > > +		else
> > > > +			ret = perf_mmap_aux(vma, event, nr_pages);
> > > >  	}
> > > >
> > > >  	if (ret)
> > > >  		return ret;
> > > >
>
> Nah, I'm an idiot.. How's this?

Right yeah, you could just return instead of break :))

