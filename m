Return-Path: <linux-kernel+bounces-765933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F0DB24038
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA5D1B66B49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4B2BE7BC;
	Wed, 13 Aug 2025 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rob5UEzl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dn/ABywF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45341C6B4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063247; cv=fail; b=MqioNubaukGzdEjEijYb2Z8kCvP+MtNjQikc+JWUZV0os2GQlhoS6tw4KlhZECJQOdpvM7S4kpdC5PGHCesmEbA6V1A42EHHPpx+nWEZvQcqz4nXmIES6LO09UJ3bWJXYlB5IU59PaNkAL4BOETKJJxa4YcJiATloAQvUmPOwBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063247; c=relaxed/simple;
	bh=ppSMjbgiYow43QBHKrY+o5YIv3UL/GYaXd6Eo9fS5V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hNrueuAkSm1AFq3x/UpNXrsK81ek5BZGpr5Os6IL+xPW0mmuVoBE/AF6cq83IfqAqSAdMJIzLbaq0U5ZISfrS+Szw/sFE3R0a929RsejLLXuuO9WWkCPiAF28cFjyYu/ho56GUKoGSNKn0320hYJ2V9V+jMkvSv82lX2Kz46bQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rob5UEzl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dn/ABywF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CLR81q011551;
	Wed, 13 Aug 2025 05:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lkep23D5kTfrWFYq3P
	D0Nw9S7kbUZ7YVLP1vpntEc9Q=; b=rob5UEzl8h3ngPuBWBh2ZI6b7sSbfMY1pP
	ZKZIn0I9ds/m0ld6axuEUYUzIYf5A1cafeS9OCbbtZnUqHAAYeRMtr5Q3EzEEKKR
	Ocf5KeROeRDhRtkI+B7HnPQxq6criVTLvlldKp37Y1hY8IfXADHue5o8N0OnwVOV
	Srhigvtaiz+3aD0k+tCbq1nrUOXwd047WpvRnUghFqDRcjpv/Qzu3j611r3H3ZUe
	FlqmgR30s2X9CtCCVClVoWMkrpbBDTjaoe8fuHe0Bf6T9Q070EwpCI0ViTB3D1fA
	IDe/H0Juf6QJj5Zp0W1gga0xKjD3xFWVt+AunPtYBHfDG7oUJibA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwxbqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:28:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D544LD009671;
	Wed, 13 Aug 2025 05:28:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsh75ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:28:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8OHR2XQ0QNdoBASa/7iT3Wo03nyFli2woRK9q0l/HJAlzAw/91o9getI3LthwbMnV/4TMTIUegrFOFYpZ/AofSBUg4zecmErEiONdFUEL5mMXoef6JAda2bmUe8yYYgsC8wMX8/R106hgK+IESAv5ZJ97Z9beDAc0+mbUmINrGIlk5RgqEhU24nS8B/N8pn86H6rNoyfQPz86mXU9bGcwE9pLUxyKMnzJhF4RILPhzxZZDb+EIM6Hq2qZdjKR435DTH6Rw+tUKSDVBYiUDEqVYYnuc07fSXA9mcOTTWO4TUIFqbR5RFOAPpzjls/j1PGOg5xmym2r8kNsXvtdZq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkep23D5kTfrWFYq3PD0Nw9S7kbUZ7YVLP1vpntEc9Q=;
 b=ycbhbd7bm2uY+CZJlxbfLJzCKIyY+NAzRoxrCZs6Gci3CeeAQ+kzt5CrTRXbEqFNTFFTIp1oPwHyiYg2VLU4flrT5pkWwBWPw0AhNIYN+q2uKoL3h7nmLdgGvq+U3gSGBrtlKe786DRdeBmmytocP2IO7+Owm38kwtEnmTN1sQqKQV++oTOmqiiMymlO83tDdbg5xaME+siQAy1qZU+zdAPQkfic4L/Qv5HcGn8J41NnnzcrSvbJDpiL+V8vVuQle6zWsHWnfEkosHkkCQzNDx4OESpxNUZ4TdHATTstj6NTBz5Uy33o742i0sdTWRA0Ixrs8lsEW6lEJa2DmFjvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkep23D5kTfrWFYq3PD0Nw9S7kbUZ7YVLP1vpntEc9Q=;
 b=Dn/ABywFZmAmq5P8kH521w48/pIjtKmQbuNWNBPIbnkJm9lbqfe/z27/N0cDsW8MoWTMuTzHqcHFYKXhcwHtkHgyAodHYua9DwEcbA8PRzkFYaifEjfYnLxkFd6LMsonqsArFXnJLn1o876KOUBXrhJr2rcO0fiDYIJZvlG2Juk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6797.namprd10.prod.outlook.com (2603:10b6:8:13d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 05:28:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 05:28:14 +0000
Date: Wed, 13 Aug 2025 06:28:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 04/15] perf: Move perf_mmap_calc_limits() into both rb
 and aux branches
Message-ID: <8fe920fc-83e5-4892-9457-45da6ed23a09@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104018.781244099@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104018.781244099@infradead.org>
X-ClientProxiedBy: AM4PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:205:1::49) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 6189586b-f264-4b91-feb5-08ddda2a3332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BgtyB3GOil1t1o0rDKaAjA/yoh5zGFq63vyHya9kQoOznMUhDNbmkso+mHyF?=
 =?us-ascii?Q?pai2Zqzax3g5Y1gA8lfpwdUQIP6ftdBzGGxzqzkYeoFqUYU2a5O5O74AUxBZ?=
 =?us-ascii?Q?NT014WE+XtEYHwNgFxbN12xC8Otq4Ew1jrsHgToHCr8VTsHZmpaWSg17c7x0?=
 =?us-ascii?Q?XavKYNfPNPZMAHMupokgthXBMeKgsbgzhcC1wWkUzpngO1UE+uDQ31x9Eric?=
 =?us-ascii?Q?7ER1C8p7e8Rs0C3BCz424+a+QHI7pYX73+CozMErf2EgvTUwY+wHWBCTohPb?=
 =?us-ascii?Q?TiwjrVsBLIAPCdc+mNtJpmmkVrs+eLXaCkBlFBzysQY3VNKdfYvS3L9+6N+u?=
 =?us-ascii?Q?AG7qpjqU87/oNJpvdxqQjECvNd3RF29IlLCy6ZjwGS/7Lq9hBz9EE50N9njt?=
 =?us-ascii?Q?WsuZhdfOgG6DM28dft2IfkVFgB6MQoB7HU+ruyxfy2sYHg6thH0onZzuqaNI?=
 =?us-ascii?Q?BBt6/sFGj6Ds7RHlrxsK7ZFJw4C0Im9WEBLxYW61g49oo/ewHiWCqMoYD6NN?=
 =?us-ascii?Q?C6q+IhU38ZMBIj2UQLGvpIH2jlcYxK44yfekvopFoNKjYutrMAJFX6ZFvwbH?=
 =?us-ascii?Q?OjqFHSWyp8kq0dV7Uwutn+6GTJd2zu45Q1KHX0+s+LLbcqI1X4kcXp8t6122?=
 =?us-ascii?Q?IyUjSlTkfCx0E90p0NnPGPAdM3rYlZqUjkIGU9Ph9QjhwUH+Atcjh/oitzWr?=
 =?us-ascii?Q?wAFiXj3XQhtuCLASbdb7HUWWAi3q85bGtxhr4APiVpwUFRvDZY11SJsfAFJ9?=
 =?us-ascii?Q?dB2VeeRofsF1PM1XT3S4nI5qW6VAvzvXaG16QQ7YUAigZ6iapnkcPNNn+l/h?=
 =?us-ascii?Q?Pa2lCU42vHETq/RFN8HcMGsS+XdzhVkm6YrDqSebSA/Su7K4jQRhbldhiZdZ?=
 =?us-ascii?Q?dPJLwVqgRMMJjo4F/kDOYAkD+vd93bhMSPCvu7WLtr/F2+nt1J7RDxue7ysW?=
 =?us-ascii?Q?3GjZfbuUCd7bqClh3Ilxb8fEIzS6FzStth92Mts/xjaqAvm78o2K8a1MwbgQ?=
 =?us-ascii?Q?aqa3LMD8rbWzw+yQelwLsRS/AVtwDfoVAq8yNL/6IV8kvjCjhfNg46hBSJpe?=
 =?us-ascii?Q?X6sj6qV1wsOVLZz/tlu8DEzU6gxByy0m5ImcUhQIGrIZRDhRbCTrhyBHriaj?=
 =?us-ascii?Q?Km7CJA31cR3tiBY+bC7vU9eew/p8UrCV3X8KohY5J50/r/x/OiUjtMhgleDD?=
 =?us-ascii?Q?uWnOhy8+LzkWcx9dO9ZZghvyu3D6kefbNKiLzF8ABamcp4VK5nhzz7Pxf4kS?=
 =?us-ascii?Q?h4u5tGd/R35SC9/pihcyT75XXVN+0+qR8e2g5ZNQ4y2dQ8J9RlX6eOX1mllv?=
 =?us-ascii?Q?p1duUkl+b2zuBlZB3DFRWIH6fnnvmo52TFbpn1NzTpNkG0DWuDa4CZp1GTea?=
 =?us-ascii?Q?YARchh9GwOplaVrwbJmMK3JluY6rWyaLJ9m3Q4ewBzBmXwrQutAYPGT2PvFF?=
 =?us-ascii?Q?lXVSbwa5uq4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3bf90+BGZQCzu37kTDpFURd3XtK0mg0TI07PteiZuudkQMHOZdEl00Fps/CQ?=
 =?us-ascii?Q?FdO6K9IqYie5c384nMK5VUDO5JwdApBnOeo8EzIoopSVG6AKNvIou7IOYyhX?=
 =?us-ascii?Q?q/kx/vXpYCwllCiQVgvAbTge41m2+BaKbemxWYV94j5oXx/+1tDJ0+HtvjM6?=
 =?us-ascii?Q?fxpies6jbVi1kSG8l97hos+fLiquZnKZM43N6kB9amZiPOOd7MVcHW/zmW1X?=
 =?us-ascii?Q?RlUMv+TKAfVLWWtKVnNu4TkNcfNt+e/8oSjtliQbAGsSGwtWTZTx3L4x0bWe?=
 =?us-ascii?Q?YE2eylprVO1KRfTmMgMiQnf3ZISxWPD7Poa7ool55AgPu+8AluYldie1WGFN?=
 =?us-ascii?Q?v14xTUz8HyREYWuXsylOE+TQdd+JdUqU+PzMZ1QmjW7KhrB786xIlWE47fni?=
 =?us-ascii?Q?UzFhj47xjFy+aYZaWveD0l0NJnHTZT8nPaaXvl7nE6OxReo+vorNaq5m806u?=
 =?us-ascii?Q?RzOU8aD0lGlcY23IvJKTkEhzwWQPH20lF5P9JqjQbE5qsemqRTR1cgONRCDC?=
 =?us-ascii?Q?5/DzeRQIa8j7MDJyVk0Xqnp6zSOU86yKrvBGTj9BukwJWXMcvpbRQKkv+SOa?=
 =?us-ascii?Q?zH9MPBDjg0GS9Spuk2aF6gXztYx2S0sq8/SxgWsox9Tz/SQRVhiGFXvOwQhj?=
 =?us-ascii?Q?mvqHL6ribwJq2DwXcejVZ5ltGfb29Q4xDGLT6/Fj91+v/a/K9wf/ZPBGvJ61?=
 =?us-ascii?Q?NzJALiwisddznhA08PjdMRizE6iaHlmPB5pMHQIlDrksfa+Elk1c68e1Euxp?=
 =?us-ascii?Q?R2c7wUSPaViOupfN07fo25UMlT/jAJq8VWI332MYboALGRRudYfApwkKCznH?=
 =?us-ascii?Q?WpI5P1xESFC0kB3A13jT/gOXMOkdSv6dq9GJ2hNv73Ift4BRq+4Ztz/RA3bf?=
 =?us-ascii?Q?fAIbW6fVm2O8k6k10Z791v5Kl690euTvJfuGa97l/1BT6IIWwxwKlpZ09NFc?=
 =?us-ascii?Q?EEYcebAJFkUsLGQBjbNAhFuScvbVFkSFe02Mhtu5aZvk7AC1geRygOnlfVnI?=
 =?us-ascii?Q?ulaD16EoGNGny/KQU5x42s6dD18YbeAFwnnoFHH2YgkLxBG6IgF0ZLtgCGPA?=
 =?us-ascii?Q?VnEKafKe/oAw1EoYn+jhXcsJdHAKSpzrTZGo+5R4+DdPPY2fiFOHP7AplLox?=
 =?us-ascii?Q?vxjxcJntiz/66JXAlMrtklEJWUcaQNlR8LtzBD76SYxc4+vkdp1jAZUpTWnv?=
 =?us-ascii?Q?x3mA5nKfTDx1KEZTv00RzE1h2z4NWUI7jQyYH9P3C+IgnEM9lMy+7axFcDnc?=
 =?us-ascii?Q?yX7nw8mWHKmssMAKnGK8nxOApVd7Himm6MQOFy1MLACjdf/UJFJ1iFgdhAIP?=
 =?us-ascii?Q?NewJXcn3dpvl8zMkoY7nJ4l7agTt0Y2TkZdPfZ8n6of/qnxJpmg8FR+j9+b1?=
 =?us-ascii?Q?j9+DQXYl4kzJBQ3fWw6WDHl4a2rW0kvfGsMDYrwfWaAWx1+6g9CvURWEKiMv?=
 =?us-ascii?Q?eOHmoCUHH4mCQNPAazh7dPTSuGNTbh2e+sGuvsTQNPLYCzcuZIcISPCiUJkC?=
 =?us-ascii?Q?lNbwFkMj6qVFDoRzuM6pX+iOc/Z+Oq0T2aT5kqYXAxdjM/QEFerK9PJc51UQ?=
 =?us-ascii?Q?2H2WmHtu8kOx8Rrj9paNknq7vcQfupzGgVT89p/C7Di9xzcSvChzyCDJRLcO?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZGl+x/tuoEKwhwxa2bCHojTLv3XV+InPF6yH4HMHAc4qUqH6pjSZEkkE1DfkRr9T5M8FnxVabO07tiiMpijhJTHZvuFo7ZE/nKyD72f94cu9UUgabMCaNBTivBfMprmsteT7VNfvRrhvg8U8s1IsBvgw1bDfRzuZ3J+VBfAP+tip4NFyZV5vBw2lM1PEYFLfa44G5BaCCA7r3A/l5lbnDAWlz95cjNxhqG8ikBYUg90EIjSAz0ZFSH221GkW4tgBQ00f60Ux9D147UD1KRzkwWBpv88LV525RpObWpW54Hi4scHDooCdO7mL2k1NCiwL8RR4JFe2ZgQm5GRKpN7wNVVVvI8cG52GuIV46wA+OS30rK/LoyePTi7oO06AkS+tkMuUBagvcYNLht6d3dLJY91/1cX3Gs+qhCrkkS4roZskbxk+08L3Z+KkwrQtwU0Bv0EK65pSz1E2bxj/jPrmTODDfQjZxWsskkvHfYLTDN3tPIbrsLP3jR71TVn5JpUR0mdzJcKr+eJkgLs9kgK4zp/d614DXBJYuQPzmV9g10kQ6b1/k9BW6Smrhy2j7NfD5kJ1SQTQLW2oyXIBJmVQv87A7CmHISMA4/lFR0ggEGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6189586b-f264-4b91-feb5-08ddda2a3332
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:28:14.0533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0soTvsoyuH0eYLXy7/1OUdpjyxHZh9TfjIHftnjh5mcU8lje/4QKrc7q760NEwvzh3ToWNVEsBelVMvFIMFkRwLW25XeU1rGSXrEi4FCR5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130050
X-Proofpoint-GUID: EF5yRGjBtoG_7QG3Ti06IsCRYtgClC4O
X-Proofpoint-ORIG-GUID: EF5yRGjBtoG_7QG3Ti06IsCRYtgClC4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA1MCBTYWx0ZWRfX8mc7ultNdLV9
 AJcgUuwjtdcvr4eABZCclishsahX4O2PDxx+THI47LFgkw7H7orIDeseU2NmqZ9wla7zDqNfWz2
 JF8V3VYbchiE/rYB8V3i0KtUauuz6Ll9zDMADQYG53idDohThqdufHuu1xkYr6LrrURoL2IJEv6
 NR5WLypQh2H9nXRRR6j4WJYZ8oZegARFkqWQqrWIlN1NhF7xdsCcVUO4Q9aHbckyAJzejt5XcmG
 b+ERYadeS4oy3GUsfWl5h/vWtKy6d8mykeimFMXfooISFaez30ZZhPHaBUrGU08U4FY4+hVvAKG
 MXDJtBD2mlrZSFZEuPAHDRplUhdV6BJ+gLtHqKyWGtyXRCinfl3X/OBMWpUVByXToDPatCoIzTX
 vWn5ZzixOBWgMN8omooDucXlfl5AOFMVcnYxTKbmVQ+vkO3iBUDG71BsKq3LvsJQicDmCa7o
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689c2271 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=0xyo9UMQO8LqW-1oHhoA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:12069

On Tue, Aug 12, 2025 at 12:39:02PM +0200, Peter Zijlstra wrote:
>   if (cond) {
>     A;
>   } else {
>     B;
>   }
>   C;
>
> into
>
>   if (cond) {
>     A;
>     C;
>   } else {
>     B;
>     C;
>   }
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Seems sensible enough, guessing trade off on duplication vs. complexity of
having to keep track of 'C' being in place for both and I assume makes
later refactorings easier :)

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/core.c |   26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7054,6 +7054,16 @@ static int perf_mmap(struct file *file,
>  			ring_buffer_attach(event, NULL);
>  		}
>
> +		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> +			ret = -EPERM;
> +			goto unlock;
> +		}
> +
> +		WARN_ON(!rb && event->rb);
> +
> +		if (vma->vm_flags & VM_WRITE)
> +			flags |= RING_BUFFER_WRITABLE;
> +
>  	} else {
>  		/*
>  		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> @@ -7100,17 +7110,17 @@ static int perf_mmap(struct file *file,
>  			ret = 0;
>  			goto unlock;
>  		}
> -	}
>
> -	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> -		ret = -EPERM;
> -		goto unlock;
> -	}
> +		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> +			ret = -EPERM;
> +			goto unlock;
> +		}
>
> -	WARN_ON(!rb && event->rb);
> +		WARN_ON(!rb && event->rb);
>
> -	if (vma->vm_flags & VM_WRITE)
> -		flags |= RING_BUFFER_WRITABLE;
> +		if (vma->vm_flags & VM_WRITE)
> +			flags |= RING_BUFFER_WRITABLE;
> +	}
>
>  	if (!rb) {
>  		rb = rb_alloc(nr_pages,
>
>

