Return-Path: <linux-kernel+bounces-730444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6ACB0449E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133CC1884A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3935C2586EF;
	Mon, 14 Jul 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XkJKe7k3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TzpWiQsG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1442258CF1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507943; cv=fail; b=GE7JQqnuLHydjtweyF6Qek3U6ienNXPA76Z8OqyHgG5CYQAUOtH2no79Cdm8EPPq858g97e1X5bGxBW5kG8txm7mmnh90TBzDAx2SagoREGHNq2g2+TthGeaVYi8Z6zLqp3UjgNL3M7HE8i8TdbgYi4c9sFDnlvHJJ3H7d+WUlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507943; c=relaxed/simple;
	bh=ORc66IYGKxvS4iBIM0D7nmsb8Ps8tE4WQDmI5emHvf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=USJrj7iDt2UDOPklbzonTBmQ49K+rSFF2w8Wt5whr2383//nSVoOQlZs+0rA5Rrlt+1OeVIRvfaZgGK6Wl+k5cu5mzKpbJmhXmxA9AORlcGatHymn8IKL7Tf4nAS5uwxisLiALPeLRWRbiMMRuX+Xte9tSFSgttsGl6IkGGYQLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XkJKe7k3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TzpWiQsG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5KA031151;
	Mon, 14 Jul 2025 15:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ORc66IYGKxvS4iBIM0
	D7nmsb8Ps8tE4WQDmI5emHvf8=; b=XkJKe7k3758p5SmILoQIksIkgUDCJO9n5f
	5fiR/aykXX2sUcS0fHNFP/wyj3GAY57Uc+d9aAFJgScrT+1Hq2SaTv0jdOhmefRu
	n+4b9t0Kx+i/dLfBq0ld2MjzQxmb5/PxExvyGO8+CTBe09N1Jqpqs/3XtoRy2jPE
	yKQGeygnRNaeyzTrzdjVHVigXx4DV6yv65GWDxYSAOFp8q2UZePSp0OCMB/gPacR
	dCHJxIkbUUupAFGI8v4hKtJ1Os/ah/qlwYZsm4uBquAPOPuOx6uTSW8Ah8anNgQc
	1nLjhGI53b8eR0Qpkdcxynt+znQdvpAeV4jpMr1uPNqRl6cqFIUg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0vfst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:45:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EFZC2L023785;
	Mon, 14 Jul 2025 15:45:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58p1n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiVm1veLH8hl7mYRsMFqKOktb1tHAK4OtRLpBWdJN8u8guHefgUKX6SFTL2h2FXPH2hfSKacmyIgVK/I3znpA68DjhlW60d16kKdw9t2btv+9tgMxGi5e+2R2HQryjGV3YBOQvdJ0zBSZaEx93sPHm2pjD2fWvcXVzBSFMTiV6rKCc6zg8joCkMO7LCtaI4+BGCzCFE2VBp3oAXwz0PuQTQQHmVU8UUyZDZi8O1WIA7Ir23sshkrjWA81Ar3N+PTfRNaIRKD/iTw+2f1Ub8uCqI3+8vVad/CI5wtK0E9Qdmrnw5AumceebEJMqm+gAKy8ER9ch8bsWQ7/53wtm1yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORc66IYGKxvS4iBIM0D7nmsb8Ps8tE4WQDmI5emHvf8=;
 b=cwxeBuWcceMC1dj4PBm89semlmLcCH4Sh6P6MI2j70PPTgTO8Ucd0lDhmTOioJPaO52FRYkqRikuy85/8MjJSnZqLpVt3KbmIsT1tHBFZWgXzZke17Ip844ZfToZsqNuQqEz1M+u1gATEiJokYKukSBSZ4SsUAKSk9cT+FAunIzI6WQyu+rFhcZ9p3W0stJ56dvORVBTZt6LEi6Gj8DqPSWHTemTmW/tELS4SjfPPS8chxiwJgJcfAtkGAg13YBMDQQst36goBtas7+Atr9st5ygjGjpzU0J8Qoo8cgOr40t20kuDi8+uaZSqBk3X9wr0QoPPegcU2yP5Ox9BQZyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORc66IYGKxvS4iBIM0D7nmsb8Ps8tE4WQDmI5emHvf8=;
 b=TzpWiQsGT9Unw3CN6+RqW9LSM7TaQCwSpGX/af8yviOi0XWkHHxW7cKp12sBVIoQGmwjNClEBCAgWj+2f8AaGVn04RGlf0IZHidMC8EA6vaBalR2AI89PH/59jMSQq6ES1bDU60NnJr3NXqwZ/QhzdRTLLEPU2r/tJQvRDb0LxE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.35; Mon, 14 Jul
 2025 15:45:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 15:45:23 +0000
Date: Mon, 14 Jul 2025 16:45:21 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
Message-ID: <d7959e95-c248-43f8-911f-628db9313a61@lucifer.local>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
 <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
 <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
 <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
 <nnm4cmygbeyzwxfwqduo5lq3d5cthuic5irof2l3tb5x43n2hz@mmjklktcfk2o>
 <184d7f4b-6ffd-4047-b245-aec32ebda9d6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184d7f4b-6ffd-4047-b245-aec32ebda9d6@redhat.com>
X-ClientProxiedBy: LO4P265CA0291.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: a3918d7a-659b-43e3-15e5-08ddc2ed7262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pXJG4eLAxoSzhRE9wOYdr3x5TtWWvLuZm8y5tPuNjQeZVszNl3Gz+M/KYdGT?=
 =?us-ascii?Q?2nsjAPAWi9+STLU1RJKYmozWQVyhmZ8KM6OFk5HuS7vbJB/0WrH+sOMyKRO3?=
 =?us-ascii?Q?JmKiIsigu96UA3SsZ0unU6xVVZ9idKoqlFzuPXwKNAMFDaV7dacxEFShtwGy?=
 =?us-ascii?Q?1uP8HcuVsTk89t+e5dIdmYp0/S4ZJgdP0Vy/Q24U7ZrOGLuYTL3ClFztcLEu?=
 =?us-ascii?Q?SA4jAC/tg2ykunJd82eDcFOLR1aQHSu5X7ZvsDkJYUA7dworInYNzncsiWsQ?=
 =?us-ascii?Q?1gT8OH71KTBEk29Sxtd7zvm4ZKyQUFevIRERo15o9K5L9K4Tq/gakSJlIWE2?=
 =?us-ascii?Q?BH1DAfNrOEFE8LHGHamEGP1Qa+OOJ4uHIhGQ03eCYwUbSbdELlUjnHIcP7nK?=
 =?us-ascii?Q?TrrOozJYoZPATfJ+twA9NWP22/5iUe2zeqZ2S5x2hMrVyrkR5GjNwznDpYZK?=
 =?us-ascii?Q?8Ch+YZpibz2UDdW8rvN/cR/HUZlewmJhRnARAhmQVduEOJjKSu+zFCqOK5SK?=
 =?us-ascii?Q?TX9yjH/w5ChXQVSPViOssppwxoNJ9J9copAS78fIFb/bPpig0Gr+pS65iRv+?=
 =?us-ascii?Q?8fEqhVg4H0uqb9YMQ80si2bKvFjp/zJ5/ivKqumzb+GcgLYH8zo3QyQUpsJC?=
 =?us-ascii?Q?+nZUdQIpj0KtHR5HoGrk5beVnJrNwYVvVWlCNxRX9VmSWqUTpbBrTn0j/9u5?=
 =?us-ascii?Q?IByNISsUOEGk39BfvI/zGJU8dQVnoB86L/R6IVYwRSj5YBdcLrpqmmvyRIjM?=
 =?us-ascii?Q?1nL6lYVzfHAOf+MGNqIGlUGszhXWVfQEYQSf7qYidx5LKcTrSqEZuxpHBtB/?=
 =?us-ascii?Q?wjq1H2Qz4ow4Nn4XGc02MPxld+SP7CHs6ot5xyoWNZRB+oHN11BslWas82hl?=
 =?us-ascii?Q?MHBkVLFsAyGP4AtS5AaA/QQOg32oy4ycu7ogbPcBpQj8rwuRH+D9NENFlXbC?=
 =?us-ascii?Q?kAiimGQHohTMunzZCZQE+OIJEGUU2bUNn1AUrXvjgwzXV/KyA3/bKWC9YU+M?=
 =?us-ascii?Q?g3H2xLTRdopg6XG+I1SSYXIqyL9nV+qXukZoMALLQjitW0JVV/8owssf7M+O?=
 =?us-ascii?Q?AMCw680ZDWvs+7pABP9tVsl2aLEHq32yzOQMhgt0rGK0Xkl1ZFahndOS6VvE?=
 =?us-ascii?Q?agL4S+L7vCuVBttLc4d09iQ9tTIJAXnOmrCdmhNeyG5/PTAxi5vLUf3DA8TT?=
 =?us-ascii?Q?AwN62fEOq9SSq49s2CAywlg+69zN+FkdJ1ObcSE1fiKVDgVcpwfdsH0qsGSY?=
 =?us-ascii?Q?zFfk7uxpLpgGLfEQbtqQyGLJIijVPfjFNx6ixQ0gCsqCBcbOHCnC1zBXIL0N?=
 =?us-ascii?Q?drKmqBVyh67LxIOMXWwAtqtUc6gpoB9rEVYUVpsjOdY5GF8fGiYKtLita+fK?=
 =?us-ascii?Q?DyntHWtu1BiApBwEKWZBh5q8ETmAzEDpwcuv8Bhqg55Pl4Ndqmb+QSijIZD4?=
 =?us-ascii?Q?qtz85dsECA8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1asHNJbr/ZaW42GY7RQykSgAPPwyy4Jf2evoYsWMDN2dziBPAa/QxHbmPKmQ?=
 =?us-ascii?Q?7CVtdrWFzChPWB3Y91EQKqZV47u/YyATm1aSwphlYmXKFljRrObxlrCLExIQ?=
 =?us-ascii?Q?LsW3GK2xWxfCXMHvHlrq7SCVr+SgJOZ/wWq4eA8CT4haYnu53/V1TWlS9uYq?=
 =?us-ascii?Q?EmCIP/6p5fCas0akwQpzk72IcKbFIa/8JIxgb86gjOhNor0NY7t/hxwZ9ft5?=
 =?us-ascii?Q?GeRpoItZ5mZtTIuris7M+5e4aWeIJtOSDLILezgF49FX5GD1Pqu0KSQG/G8V?=
 =?us-ascii?Q?iIlos5jS88LAOuffXtbhRZmFQbQWp+Lxd4zj6CJy1QNfL72JW6pfOj8qGKGE?=
 =?us-ascii?Q?yIk+lwdGktY/rsBqTW5UJOb4NXCAd0FiR4GsqNkhg/uFG4ARmUj5T7QCvZyY?=
 =?us-ascii?Q?glwjqAp1kkmBnfzR7ZE9NkfcRaU6T07xVkgR7UYprrus8o+FjlLZVY262aJf?=
 =?us-ascii?Q?0TUYmJvhCyr6yDeS5IDgbHxG9asgBu7zp+rwM6O1OKMrBNavkig9mHGioo1E?=
 =?us-ascii?Q?DOh1z7i+777QUwn3fMhFiEjLDp1OLRAUxntihddZ3IN8u2b91XhB/WpDfiTM?=
 =?us-ascii?Q?n6sw9W3zafwLnK7322GiJM0QNAyEMAgri4bpeMLlgQAqwmShiAcuhfkqtThp?=
 =?us-ascii?Q?SsXR5QN92yhjaxrsVe4Z4Z352sjBiKeLIhQsYADMTerhqOJ2D33B+i9EWo3g?=
 =?us-ascii?Q?ysNlgBm09pfvnAkK+u91ayBW89S1XcQ3Q2PIg8wexdqz8mbPlZT6ffBfP/Oa?=
 =?us-ascii?Q?sFqEnx2gV+9BIJDVlwD6ENQANYGOx4FKkjX2ryAsjhUvseFogMEPn1OUh234?=
 =?us-ascii?Q?yHv+VD+UmIgIrdnUbxbmcuzjSn7S5qtaBqnlFIquOrPdeWjiI8LOtxGWq1CI?=
 =?us-ascii?Q?pa3LlbsmV47xSKxfEOTbqjv5oWQPwcTlhRBFQhJkIhUfR6gYv4uw9+f8bi2A?=
 =?us-ascii?Q?XBKgEVknXV09dfkv4YufxXWmoSMrkpo6ju+ey05et/aDGJXvyFfAVIL1FRW/?=
 =?us-ascii?Q?/wcX1xWEnqNblt+IdDpomltGo3qJoXkbATZoKglsR6FfNLgPB9wki7Jd+q98?=
 =?us-ascii?Q?nYFOrguSq74vOM6YUWteyiHNqzRf1fcObk821RlKuIn7pBO+Y/lbDziQL000?=
 =?us-ascii?Q?JHKYcp/MP8GlH4DHkPzWD71zoBY1cB8/m+oyEFRK8rNHSJLMYwVTltNhzIP6?=
 =?us-ascii?Q?AiJ8cftIZb0u+xmGbYms/oCry1ykmyv7TF7pkwZGCCb3MSuPhp06Mrar7vaL?=
 =?us-ascii?Q?ScyPERn0Hp9inwkyJKNdnh90AAORTlrGyz2VMY5m/PBhmrYOtPx0YT1TTBk0?=
 =?us-ascii?Q?CagC+tzv51E3v2qYL47XncO7DIEwK/KiHKeW+il3+ljVnqUZwbaOMl+1Nh3R?=
 =?us-ascii?Q?0OZT3+CFp6Fwm6Beurt2VY1d1rLxA03B5J1jrWJYqUEadgtxXWsYwVn/F9b3?=
 =?us-ascii?Q?RmWudYPD3sdlTOiU3NUVH6Gus4+6dSQ8pR4RntlsrMowAGTBMFvHoU9EmjzU?=
 =?us-ascii?Q?kxwpmcFmvm5E9cyZ3o0UWyhC1mqEojiGlg8gOMXEMD/MWHHCq9rq5TycqsYO?=
 =?us-ascii?Q?EUwDFXKO5ZrvAxGgRcyq/oaDMeWXS33Z38gu40l1Bj17vRXht/njJXDvN0nL?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6KrfW3uiqIJC42noV7s1r44xSr/Tm98Ho8zRzWxw18aHIblZU4od2Q6kOcvtp3VE7lgfs+ovCCEK7HP6mpiV7NL9ZFUXrlNKunrAYWi3T7RB+sFki/4CjpfjEwRd3Lt8jQpfnaOrq2RSG7iLON2tUgK325/+Kn2Y9vk9Cwaa0x9miNjNhaJG0j3ISZNjEiFIQPbUHPCB4nAIZxm5aXxNpyz17pOM7tmb0LrlBLHV+vgzDbiEKJSJ+XT9wIIgzWEtqefPFx9sCkFazIjbwIa6TG/jONrvC/7Uza5oBO876kywzzyJVQreG3mq7+7mj2Ya260T3/jX4f3Wx0ymNcTJ8QnvxZisljJHcq8EaSUFOty1+h8cddbQwCPyQAV1occRz1Rv/Dr6YbdHCsxOGTsOmKWJKWaJ6S/JxDO5CJBthtWJkqFo0ts02cD6jYxacnmuj/PBfakezTlKpwZl5Boqk2LWZ7Hx4RfVYEHFZkKerxK+aumhEcP80iuaC6t5UQWYSYNvrigyCRC+YU46l71WlD0eo3efKgFmU06y9xgreejvH37mcIK56KvKnjK8yzLSyX2p/TArlcczbKW9y0iFuDA6kv7JxmBF+SzKJvaBhb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3918d7a-659b-43e3-15e5-08ddc2ed7262
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:45:23.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wa90vJYLchqH/XB/9rAT0BccjpyF9EUSnWipVkHR1SK78IMg3MLmDbchwBkFAi2n9eCZZa5FiCMVn+S9rxEz5/P2coEqgWudpR24VtJCTpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140094
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68752619 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=KfcmhW5Qj5yMyoE1JEUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: rKAq79DmSOBSQagzP72OvHB18eJmf3i5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5NCBTYWx0ZWRfX04P38fI+kbRV IAAndsOeY3alaowwKIGbZnYuSIKGem3AmH4nHuRMc/AW/MSNL0MUtECXuiEloxO0g2YWmqJLHN+ NqR2Fir6EjkZvUYuGREjIdAOZTktus5tkLxx7X+H5ulty/O83TMcBAY7Y5LZRpnnrQWpf0uoNT6
 fJW+qVdPGSN1i7U6MF3rNZFIjdP+4mqLSe2wtGLlgMdwzAfhZnZyFtSxzAAmvOwTewWO58gaGic xIhr6KeEn2lt4DniUqkVDejPXnMOtk4mPg1FO5cpc1RrXReZdlxcHlbtsYqmRlA2gJ/f7y7HSy7 wHNidbGqC+o1eI+YBnxja+303LYdIOLZhI/4pj0o1vE9d+YEM1DPAzI3xAhV0n/OtnDbnqkqWeZ
 8glToCrsdImgSvOwRh69QTO4EXxEE1Tu5iboahMm8Ldc+FOxLRW55GLQn1x/ps5ie7apmz5t
X-Proofpoint-GUID: rKAq79DmSOBSQagzP72OvHB18eJmf3i5

On Mon, Jul 14, 2025 at 05:41:45PM +0200, David Hildenbrand wrote:
> On 14.07.25 17:31, Pedro Falcato wrote:
> > On Mon, Jul 14, 2025 at 05:03:03PM +0200, David Hildenbrand wrote:
> > > [...]
> > >
> > > But now I wonder, why is it okay to discard anon pages in a MAP_PRIVATE file
> > > mapping?
> >
> > IIRC this was originally suggested by Linus, on one of the versions introducing
> > mseal. But the gist is that discarding pages is okay if you could already zero
> > them manually, using e.g memset. Hence the writeability checks.
>
> What you can do is
>
> a) mmap(PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, ...)
>
> b) modify content (write, whatever)
>
> c) mprotect(PROT_READ)
>
> d) mseal()
>
> But then still do
>
> madvise(MADV_DONTNEED)
>
> to discard.
>
>
> There is no writability anymore.

Well, you can mprotect() writable it again :)

>
> (Just a note that, with hugetlb, it is fairly common to mmap(MAP_PRIVATE)
> empty files and only work with anonymous pages.)

This just makes me think that we should be checking VM_MAYWRITE anyway which
squares this circle.

Otherwise you can do 'workarounds' with mprotect() generally.

It's really only meaningful for a MAP_PRIVATE file-backed mapping of a read-only
file.

>
> --
> Cheers,
>
> David / dhildenb
>

