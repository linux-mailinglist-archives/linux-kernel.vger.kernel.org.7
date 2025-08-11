Return-Path: <linux-kernel+bounces-762665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B0AB2097A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269D63AE75A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF32D8398;
	Mon, 11 Aug 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dfWCCKv5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k2/fpU+l"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B550A2D8360
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917122; cv=fail; b=X82dU3EhkFMm4bkLJmHuEG66jOMpNN5Ha1cEkO/tisnhON6u3DaY7o89iguKlvkj4CLjU4vARki2GgZU16/tibxBBbjeRnvgelBB83a0V7Q5VfIit3fuc0oAyEiyqRldQDkmYgLWtLQn8A1lxLSYWGjtjwCYtOyaVwj+xMFQm9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917122; c=relaxed/simple;
	bh=LPd6BcJnpnP456d4hjC5bHy6xTeoOmn6v6+g4ehCAog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CT6IwRYT3RhEn6KzNb2HrsSpHpCtlJt2Q1/qwASPjpipgKceZcUCUMNbMf7byWPk27n/+mAC5+QUd9UjZUu6GOvy5soo3aipER6PnNNV1yRu/xNhBtZPn475PdlgpvceIeJl+jeZ56bWw6+xet613ITI31ufW8l80kS1goXQf2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dfWCCKv5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k2/fpU+l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uDaZ028660;
	Mon, 11 Aug 2025 12:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aS8i9OPgy8ssnVnC9P
	AVOVeAgmFzAi5PkjN1Q5yS0u8=; b=dfWCCKv5o3Vu8VczIC0nb8lE0luKIFWVDV
	ZJPM4U5zQcYQD2rTYzRxc7dkr4b0X+6tc0ZxzND443v+jnwX1z4DrBxQBojD9OVP
	NbrHLNEg4ZQsGUJxcXek3VZdoGnaJJ4O4pl8UawX0K0HQPhSXZH2ISxld5y8OB5W
	fjrGYyRuCjFFP6nH0boqZYzoHkuAcs8HvI9o9y3EwmcXjcDXNF6B1ishqx19XD38
	+XntAGEwxn0AlfeWm5ZDNfdQSrCnt328XeP1x/TDU/9zw2cwVhXxuiBptd94aKDJ
	ipBwMlYQ+omCM3anYxTNZTCb3+5Z5r5gwZu9bTyK0TwzXxu0wDVA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv2ekq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:58:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BB4vk8006363;
	Mon, 11 Aug 2025 12:58:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8cb40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Us4sMKPlHEHGC5EpCNztDvVJs6RykU7js4CHCo09rDSoyKlnYLKFfbss8D5bPubt+BqP/HT8xsRbYFvItVswI0FT71GOfNKH1LNqKE0B6dCbdR3qIAKGTBt4KG7ka8JEGl76ly97OJxMwt9ZDrMJCHoaRp4pknyOCRzQr0N+zLWQqNIr/1TKLLV4nTSr5Gsk4HJL6WQcQ03Wgo5wXNvOk4LkKi2vPv1jR1vDyev3vnU987TV6cocOG8zQQ4BGJdKTY0Ntb7D4RiuTdypTH25CGOJ6LQf1tyXMcVWRrjJDu8dLZuDAdWrFGJL/8xHHCnPEjndHOa7j0e4GTziFPg5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS8i9OPgy8ssnVnC9PAVOVeAgmFzAi5PkjN1Q5yS0u8=;
 b=PXL1nzPejtGqDwbvNfRaolhijnXLSbMThZXOOAcOug4DQ9pwsBESrV+MRi77KvdLs8NySzwRGWYjFWI46rQHfPogMAskOtF6vevndkarpma9v4DJ9xpIEgGD7Mg8aatSH7MEQaM8q6swRm9VPft6TV1aIm2KID3GWu0yN/DPg1OzFnG6bX+lIXvgaw84IXe5jcw3sfybfnh7cqAm6R2XAuiFDry88++DoC5JHwb2GXF1xvFh/PHyERjVkoKiPk14dr6pJywBbne8MCaQWW+JU3wGzxlrgpWbJOq6+qx+SiBjxyqgHZBg7kKeLEa3JDwezSJGVeMUxWZ7OfkR3pACDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS8i9OPgy8ssnVnC9PAVOVeAgmFzAi5PkjN1Q5yS0u8=;
 b=k2/fpU+ltKPjTGMeDOnXnsyXmYMPNwKttHTIowtI7YXyEgvUhg+c0Fs5GBCHm1u9dUPAfu/2rGOH5DtrmP3HCD4193gSm4rrmWJHQxDplWgOKX47IIQVT4yYZ5F8WH8HouCkB+JXSobir71kkl6FC7lCBwmPhexO+NbZphf7SBc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6246.namprd10.prod.outlook.com (2603:10b6:8:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:58:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:58:27 +0000
Date: Mon, 11 Aug 2025 13:58:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 RESEND 3/6] perf/core: Split out VM accounting
Message-ID: <3be7fd83-e209-49ec-8d81-ba6a60d4da94@lucifer.local>
References: <20250811123458.050061356@linutronix.de>
 <20250811123609.603671567@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811123609.603671567@linutronix.de>
X-ClientProxiedBy: MM0P280CA0110.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ae2ed5-15ba-4244-ca0a-08ddd8d6c3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uIqxAVLU4ntT4CMb/LTVQD3vbrchFjj1qNiFqsUg+xx/Fe7o2PbDWmdHDnOf?=
 =?us-ascii?Q?s4wFjzpb/V16ISwoOlB24lLF1RbjQTRjiF1BHsBZdK9mzKRR5z9kqfEW/y/S?=
 =?us-ascii?Q?YGi2zzhaqIJVte5O07mnHzBgaHGbKBJqJ0irDXkR/5QpW064aHYYCbn7sz1t?=
 =?us-ascii?Q?YqY8zCy9//IIMzXUI1NI6u/wwhg4/g7mOsuZu1X8v76+si16CtHNLEAnRuMv?=
 =?us-ascii?Q?xFQ8b5caPTXWAZCRWqwRM9hD3h7hNEzIkJwAd6Y3bAwjqslTjQPD1LtO/k/a?=
 =?us-ascii?Q?qT97gSC3lekcsclEXqMu1/Fk0uhX0Jjf8V7nVuUuCBcaMM9Rv8CZC/OlBTXd?=
 =?us-ascii?Q?1UMsmn2tFIIxTy0/XWAOXRQo+rVxQubv/u7lsXu3JLRY1GYvysNuYZbYEpwt?=
 =?us-ascii?Q?AokSKwvtpMX3TgSxgsAUpUelnGWy2WULP+j9hxEt5Dx5VgjxGi57GNw+Ovjr?=
 =?us-ascii?Q?qXOQjkDTiAUHv0h44gSUIH7n9LyR1V/tMnOcCmfPAYVUbPgVF8PeQHKuIuQK?=
 =?us-ascii?Q?4K3ZWzOP1scJ5vcBv54Az6vePgp9dvixu2GhIrXm3Gm1Nb2tOttVGC65uPlq?=
 =?us-ascii?Q?/1ws1fgsnAu4WWIef8RvQuIexj3NVz1u7iltS7qiqppBSqI9+MkId2Xepx+q?=
 =?us-ascii?Q?qP2hEzG7aLkYnalC0mmNk2bYAaEOnoEHVpB9o/joHTQsqWnjP1AFOLFlyc0r?=
 =?us-ascii?Q?JNdNNAp07LmTWMc6RWwxv5y65/CuYITOlh1RaKF6eMC6j2l6tjwyM1dsLn2/?=
 =?us-ascii?Q?6f3j/53ATF6SQ1RQI3HRG78bpGAK7HQ7ZXSSS0LTEB9iQA3WG86pcmOcGyPS?=
 =?us-ascii?Q?LHOteM0PTtrlMhFDbho5WjoDkMg+3GPPZbArS2hlaipv4QAx9HxZh1r+G+d4?=
 =?us-ascii?Q?CQHbUQMYqGUGIGbQjwLnOdNvS8Tn4YvgZ8z/771VLQkxA11Ouaw5AxfRFZeL?=
 =?us-ascii?Q?t0QfJjGZ52OisGHID4ffTbWzZo/B3vfqF6R5zWfixiokKNcpFrMiGa1Vmw3f?=
 =?us-ascii?Q?A2cMnET8lTh7ztjO5sqEyoTfoVMwDGnbzYUUQJcs8bMrcr6QGS0FfrHUuA+O?=
 =?us-ascii?Q?oHb8TQjcUStNURUpmbrbWH5QXs9ED/rjoxj5DOGFyR5WNXloJAoFL1/eft5x?=
 =?us-ascii?Q?+E3gTAqIpVm8apwPC0TEiz/Qk7g23Feow+XhUsVVAeN9K6DlVKD8cKicamLn?=
 =?us-ascii?Q?0GiYPGFgDNqV24kvjoJ3MnwO2p8KxRP+lUIJZPh7j934MDjtQcRVZpskz2cw?=
 =?us-ascii?Q?H5IAeXryqZ3YI2y1vlBB1AYcoitv3K859CvPZPVsURJbafsahg4ca65fscwO?=
 =?us-ascii?Q?kjbjTAoG0Oos+rws3pALhZUBsvcMQzG3soHHGGGz4dne0iY49QfFG6wYKZF6?=
 =?us-ascii?Q?zEeb2TMDqeiq12lrOREfkhcNJVhbXOR4ihB247sOwocpjChOM/RPCu/W2UK/?=
 =?us-ascii?Q?LOBOm1isZ+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H4C26988Tkts05CbjIpR4zCHrysOVZfLimszK4TGGoREiHh5rdJswZ/XR8Z+?=
 =?us-ascii?Q?gPdBLUdswadnAfFizImI+8NXQDJJuuzNlbqtupMEHculEzwMTMPC9vCbBOUk?=
 =?us-ascii?Q?uiBrvFHa8AyYNJImAegGF9SZ/LEx6+8DrMFfxG0lzM0TTOKmhmFwjunNkTw0?=
 =?us-ascii?Q?AdLMWrY2bbPBZM31+KBOXUPUEdI4zXGB/nVyhEejJX2WK7LVCw702j0KGmMt?=
 =?us-ascii?Q?/U8Jocr1CFfIZ/GS/IzXyRO37a5HbdcrjGCROsyyS4sGjdfBL0oXPVAOLCwr?=
 =?us-ascii?Q?/cSXuy1PVbJ/lEK/3bBSaFJcOuwtvr9HqTRviA8kd2a6anSipQezqJx3htWM?=
 =?us-ascii?Q?GEK+seOWUMe3FchD2lBPlvZnp7s8u1MKFuDyVEf0qZM86ub/ItfuIO/vgz6C?=
 =?us-ascii?Q?zH4FB/4SbyIO/0u2+X1dsHULvZNIuVYkyJz7eQR/pzYVxrhQ1UuGcL72fOA/?=
 =?us-ascii?Q?Bb82mvGunup+Ma8D3125ekBblJRPGdpMJVAm8CinO/XBX2fhIdMNfbN+nJsX?=
 =?us-ascii?Q?KV4qiF7JMZsUBRwcqb0zBMkYbkCSE/GYsGR2kVycIgA8f3xAPdTFGaX1cZdq?=
 =?us-ascii?Q?DRHVmQiEHZLEC72VQxQtZCoIMOIGhXyraCe5jblEupXITtxBBEzGvLfpmJHW?=
 =?us-ascii?Q?AArXuqhDOKaOPGbJn+FeJt5I0IfZRAV4jS3pHgbcVJAekGJj29o9g8KZWaCp?=
 =?us-ascii?Q?aexSbV0xAaQBmuDxzLjdfHboe+ZBZ7PfUadNMz1+WLL8B0AiICmUwqvDGnOA?=
 =?us-ascii?Q?O4nHVFNwV55YNGi1P9QADxjIOaYyn7vip9i1muj+/f7w9qwr5XGh/hWKHFG5?=
 =?us-ascii?Q?O7hFoZZB8GQz/IEu4O7zMjgwuuTGdZ5hKJZGSOetA8ZuKnxkuOKJsuHCpYcd?=
 =?us-ascii?Q?zKnVm15yTaOT1ZuxwSKLOrMg4ErW2r37y7e5ekMvkGPasFOAGIQYIPAWQZmc?=
 =?us-ascii?Q?T1qwSYvW8nq8KW1RTrlMcrvf8IizWd92MN0V5fDDLy8xOqTdP5CngXg/O77P?=
 =?us-ascii?Q?bHSxKapB0JQBAjrViemCgoA0t+Q8UUZ5G5p3hEnuiZ0D833gbZ0EPT0NHRMm?=
 =?us-ascii?Q?pf/QVi330JLHsGBpKkgBUruKctSekjXBnQWWSz/+CSPCbXIUnItD0iAbbBhg?=
 =?us-ascii?Q?PLypPrjL5O5nDSS6/m/zEE9fMo2y6cEoatneKpRaMUnRX1dgcSnlqRST6B2q?=
 =?us-ascii?Q?hnT2BCGObrZsMM3RlOZnwzE2lJdpRI1RDbIf++KDrHfYQoTcAZmFITqq7qsR?=
 =?us-ascii?Q?feiJ8mjnsGwlf2wgoD1rWYPiNdXVUtcgdTZCEbDypayW2b7iminJabcCb9ZI?=
 =?us-ascii?Q?sV2wuUyxa4cYM6rwwIrrBSWAfIHX7pCk7PwbtDaAIGfMaJTnvhPSqPhi9V3x?=
 =?us-ascii?Q?tu63Pd4o7UvkjDYRBmHqnT1p18S0ZkUzLNBMgihDqpZd37uzsgIO17FG6CCV?=
 =?us-ascii?Q?NIM2OAXNRZ/j8xftJ0MCPTWFh//xIw6PqIyoal7ZZThTf/i7RSzKwBashXHg?=
 =?us-ascii?Q?yKMna7gSFIiVh7rkkiovYxhF57TQKAHIfVw6pyLDyriJAoNw9r23E4t0Lion?=
 =?us-ascii?Q?8koApBYZbwGyJQo3ex7HDCDpW/ZXX+cqDUnIWiaWfnkAP19w25iJT6f2mRKl?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	274NKK8j6aw/fD9YhF065ahK3sJQDI82HNGNPCkV38Zw6bHIRPyzg/y3N6Qz2s/eWC2aIvdCNuLyLGcZTrKZ6/vnAr414Xf0TpNYcfZdkNvyPiV08lK480FSKINaJm6pmCOSGE/8mQs1vsCGmYnzBH57zt4tqnlPfOzgjnVzPT+XmudDtRxDNp372FGcybxc2h7hRg9sD5qFVGLiQ7oOXHX0kFdwzOQnb9+7QIY9mFNE+ccjA1BfJ6ulCcWmVRBwPe+r6KyXWArGvwR08EcwGGvzVczQABnjy2G147NdDJxjkzKTJr6F+se5B+Gv1bv7SCYdalug7cuvX+Q3OW3OUBvOcBLNkho8ZY0VkwqjGiQSpw8Ojy69Vqa28UZnVqPUGA5suvMdV+MirPTnqMl0+7HAfhBnRcXk7I1uT2C6s9laHj300YEEQ5qipvlrS1r6R7V3CaK+YkqATww8uQCC9ooDQ5E4dryKnmMP5fIxU2MB8qgRmRNlpv/PrsXI0TCpLbmihqLBdUu8nLuOoCRkMmPB2lEA9zgATwn/wk7nrIMU6c08n85BwiAC5i0EfGNi6+I8omp4UZsmnC+Ki0OGdkeV4LWfwbnSrlvAYntF+D4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ae2ed5-15ba-4244-ca0a-08ddd8d6c3ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:58:27.4595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dC4YAKsWhmx1Sat/V5aH4aTVUGlGKitbHm5quPT0SKltibq/LE9P9x/CllT00PUeoDYLljiA6T4AXwcioItJmcdlEP3HF66sWCNi9rD9Zjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110084
X-Proofpoint-GUID: McmEOWhEFYau2F1U5NkO-uq7imEwcwmD
X-Proofpoint-ORIG-GUID: McmEOWhEFYau2F1U5NkO-uq7imEwcwmD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4NCBTYWx0ZWRfXwidvTDYmENN5
 pbKtbyoozuVHREN5Q3kmvSOObKyB4kFOJqWQs6K7+PTnimPSBmSyWneBMNugoWxnz6iuf/ATpT2
 zVMIU6+/nAO6LN7/JlvD3mVootLVMEGKFqXBXlCAzPjoDBDoyBdosgxeyGqRnSXGxfcoYIXjmc8
 yQDvFH+Z6CvYjH5Ip3m7Hbi/IpgHOCv6UhVC+y0nL9ObFSEndDFPii8GimJo0NMbxiVZotHd470
 7f8HSpjXaq2cEBOjjKtZKQkgkjCIWDSUrJNqHFCm5o3yfYB7czqvj7oSZLn+tAhzMbO1T5uo1HK
 CcfMlfMYH67UoKTRGvqJZ1HyIw3qPzrNaAj8PgKoUSwf8DQyUm5QEO652RZSazFf39bdPIz9gzg
 gxTUMGD/DADDONcrm7ctiHKZxJ5AheyrT+UOuh1gi1I4bsitoxs2daLLZX35VdlO1WbOiF73
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=6899e8f8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=N6GD3cayLtycEJdWVpMA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600

On Mon, Aug 11, 2025 at 02:36:33PM +0200, Thomas Gleixner wrote:
> Similary to the mlock limit calculation the VM accounting is required for

NIT: Similary -> similarly

> both the ringbuffer and the AUX buffer allocations.
>
> To prepare for splitting them out into seperate functions, move the

NIT: seperate -> separate

> accounting into a helper function.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> ---
>  kernel/events/core.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6962,10 +6962,17 @@ static bool perf_mmap_calc_limits(struct
>  	return locked <= lock_limit || !perf_is_paranoid() || capable(CAP_IPC_LOCK);
>  }
>
> +static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long extra)
> +{
> +	struct user_struct *user = current_user();
> +
> +	atomic_long_add(user_extra, &user->locked_vm);
> +	atomic64_add(extra, &vma->vm_mm->pinned_vm);
> +}
> +
>  static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct perf_event *event = file->private_data;
> -	struct user_struct *user = current_user();
>  	unsigned long vma_size, nr_pages;
>  	long user_extra = 0, extra = 0;
>  	struct mutex *aux_mutex = NULL;
> @@ -7136,9 +7143,7 @@ static int perf_mmap(struct file *file,
>
>  unlock:
>  	if (!ret) {
> -		atomic_long_add(user_extra, &user->locked_vm);
> -		atomic64_add(extra, &vma->vm_mm->pinned_vm);
> -
> +		perf_mmap_account(vma, user_extra, extra);
>  		atomic_inc(&event->mmap_count);
>  	} else if (rb) {
>  		/* AUX allocation failed */
>
>
>

