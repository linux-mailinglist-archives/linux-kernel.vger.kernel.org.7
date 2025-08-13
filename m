Return-Path: <linux-kernel+bounces-765949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA8B24075
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2511E17CE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4996B2BEC21;
	Wed, 13 Aug 2025 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mcv0SnN0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NGKRR+Go"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348A28C871
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063730; cv=fail; b=mOMN3a/AcFCySMTEnhKhu8To3qVhgpluujpeyo5RLkw7TqKlbfA2RauIVC4OMnVN9UEq9S+WdSiGZ9jeq0+a8bqCNiMgVbSEyW1NOb/p5zFhRzzz3neD5OcUL3vLk0bCiUGIqQWv7UmqA/iGnzMEdYSLdu2/GXX8PvKFGG4cvgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063730; c=relaxed/simple;
	bh=QlHumLbCjqYwOWx2tpR1C2stjfq+gSdS1fXSBG1S1OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uVFaLSosetsuNxkJnouH1AmoVBTJCf3GObj2PHs045W0Jq8ZTM89MbSK2g2M6YsEqD0yuEcSOreIZdC4+BuWL5yfVnb/0MhQgwXqP1OBCKjDeF0mPfbfK8x8p6vUtlyP6LFnj5lSPR4A1k15pyo1j0qzTE2GbVsOmpEVbWOiyvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mcv0SnN0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NGKRR+Go; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CLQrlE026944;
	Wed, 13 Aug 2025 05:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dDACcPXzV82INW1rzQ
	X9+6AqGdj3nTUFu1KnRg6Dvd0=; b=mcv0SnN03PaSjkRiiRBEZwoc2G4RpTQeIM
	4aSbrd+HKaT2EwR0Jqp3jJNgtFdAXPNq5lWmwvoCt0EkzIdHz4eR+v1S8VMyQeBX
	d4W/DZaHVABx01UtkePBb6wB/lqL/XJ4F96i8MZ06siFbSJoJPUyraonMzNLooEh
	gkYOLb6v2y3hmhlGI/99OrLg9U2cQnkvgVTg9yW2zXKOkIMrSMBgxrB5SZEl2dIb
	HFT30RUrIp3wO4xheKuP4DzSKopYqV39KxeCyqwZ1kUbuwXjvDMqJTDtjYb5olPh
	wJ0r6+kL2+xTLgbwxFsFjUJcncSqawJBrtr5q+nFjCZb7XjoXjQQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf6hgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:41:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D3YMkx009881;
	Wed, 13 Aug 2025 05:41:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsh7gj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEU5Ura2O9WibuQ7eiHAW9TvgNl514dqehiXmpnsQqKTBE+NMQT7ewfosDwNGb/f/UBhoGACfYkDiP1y241yQc99PMtlbpV8GZsskiiMdeKnozZDhMnbC7mCQO9uJDU9OX8v5ftqyCOfotbGeApp0/dK9g2nBWe0oKQSdhPE85i4jJduyxw5k4Y/699bkhhgMaZg4eVq9qdM48EfmmTZVDGKyyZqBEddjaa11LZJ15qUKxbguE9YFl20mNBmFA5MWjOmfU1zFqWsoUOA0OoWGYiIZosE3MZKb4JwZaXSpGk6Wd87TnQtfT9ifrdFngEYn9p4+mRW7IW+TIUL25+Szg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDACcPXzV82INW1rzQX9+6AqGdj3nTUFu1KnRg6Dvd0=;
 b=SsZm8rUdH0KtoiWV6AnCO3qvogRK6BqyGHIemqvN903x7GnsRfPU1YqwotQIDkUP1585zFxxgTG2b/43Ynvtu/YhEzkfBUwl/MYArv7OixWg0vbBx2mS05oyZ4M+UALZ9LoNMa9lmRzVOWMZqzACtKOLCmFpRGWnyscPoRVYL+atGRAXm9eS9JUTyk58ZlkI9ewalNNeHRzC0AOoWE2FJ6HO4aHW36hatx6mUEiAiGkiFjiNU2oUHDcIj1nJzXAIHLXDdgW0J4rXXUn4G5IazZFBF1jFzFIVhA/xTPjEem1taemcxMqAMAHl9x8bfitYN8qsBc8DIqTem7C8UdcLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDACcPXzV82INW1rzQX9+6AqGdj3nTUFu1KnRg6Dvd0=;
 b=NGKRR+GoGhP79sPqBrtPAU5VOR0/t0YCsa/LkXzqhNSCGRY1wU3O1J/QRaEXGkDcZXGOjr2R7USbFApGhKwOKT0zZW3UMhXyVGaWHEbngtBrrsEjHzY/GryMNs0xNaKbc1GRji2PQ0TFZXahmRSM+ItblikutAIx0sulq+ycEDw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 05:41:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 05:41:55 +0000
Date: Wed, 13 Aug 2025 06:41:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 05/15] perf: Merge consecutive conditionals in
 perf_mmap()
Message-ID: <f51fa4b7-58b2-4e0b-9e6d-0d5bb032b0c4@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104018.900078502@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104018.900078502@infradead.org>
X-ClientProxiedBy: AM0PR02CA0035.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::48) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a365bb-ad82-4895-8bde-08ddda2c1d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4JpFv9Vn/VZt9F+d9wPH3HrN+Zc+IW27yGrs+pF8QzKZ3I1lEmqyOtvIxh8j?=
 =?us-ascii?Q?FWs39fmTvpeQ9lYnU7TtAV1/XndbdHkgpNtJ0keJYfovWXQc5mhyl2xXbjhW?=
 =?us-ascii?Q?xHq1yFqW1WuapZEXa4GpB5Fo1UA37FU2akNza9Z4T1URpoilQ0AJrQdGiK3x?=
 =?us-ascii?Q?E0y1uPBEubxMx89dJ+v2dmxmF45EitscOkJ9Hp1Il4R0W65c2DITVJ4fcMIC?=
 =?us-ascii?Q?gfETJJ5+ZUVSCE6WwuF6j40OuI6ifsXxPHaOu9Fve17QqII/JTUaxW4z/iMc?=
 =?us-ascii?Q?pJRXYjKFGVCKpaUA+Fg7sCjvpPJihe782MqY9D5rkSZ1OOdVF8cghjrU2klI?=
 =?us-ascii?Q?jcM8zjSapF7jnCKBDHT8CAbEGSRpIKqob8NidjHY6VPLwH9WUoNiSCQYUSE/?=
 =?us-ascii?Q?GDeOXdfSIRpEuHu0+AB8RHFxY8VVeRxykVI/E6kKqA6P1uAOaBZ50/wm8FXX?=
 =?us-ascii?Q?TbYmzJrgtScapGiKmC/Tx1fHZZmBsJSS6UmGhI6+jsMXLbHh7mfhaQQFSNSA?=
 =?us-ascii?Q?Pe7ybJYsa97zAeliZoWTSQbguf+aPfp5UmKZuDeW9Do/MXorsdMCv+yZ21UN?=
 =?us-ascii?Q?/mOPU15nHOtiow/Y/myX9asQN9RrRUKBchaqbs46NuQWyWsT6cBiJ6q7M5F/?=
 =?us-ascii?Q?Rvyo5nwU4suh8LkkY6hxcYEM37AvyT6/NUg+ANpH2pa4UJJ0kjICh8WpPOKy?=
 =?us-ascii?Q?cQ6lBaCG8BMaH2JV8ohB6dGUy5bB2YkdnkAHUPTk1mlCHGz4mCJWjxZDhLXz?=
 =?us-ascii?Q?jzKVpWRb3cStYet7xIZeUQ1DdVSn9PZi7H0dpGrxSduV0S7ZRb/l7EBd6xcQ?=
 =?us-ascii?Q?FW4ejWth8xl3vnFMuh/3Ucow+WoQ5bKNJMQEqs9ju3bP9mbMzIsGlnsm6q/j?=
 =?us-ascii?Q?yx3UDDMCGvpz/Dyw4OpRiQaA0hY8Yzetq5/L4AYgYMfKQm6r9yKVT8stBPeM?=
 =?us-ascii?Q?L7swFgdUECKYqTimwlFpWGNUlOcI8JqUURFnfAEFBipRGsIVLIo/oTeo6xSP?=
 =?us-ascii?Q?Y7Vqol7F5RmcIdy2CPUGwcsOxDAVLxFR2pLoqrMoe0TA6nXi5cFBtaLD6t6K?=
 =?us-ascii?Q?duoLZwSJ+kzoGLrnMnTdCUwSIc5fLoJnF0izZU4bgS79eYxF+KpDQzJiZ2pr?=
 =?us-ascii?Q?ir9yz6QNT0k8ncd3jI+VhCYe94MnfxqZp3KEZrx9WnqHJVZ/+MhJby+xxHOB?=
 =?us-ascii?Q?NEY0AIdmcXW1rp60P2WFx7d80+iyjU7kLFC86Xc7RyxIx4/z1Hr7uotP34Nh?=
 =?us-ascii?Q?XlZL5c9KmObsvWs0e27loBFxbGLgk9fi7hopwK8KP8Wnw/1vkccsTqlU+vyO?=
 =?us-ascii?Q?o8wdUELnbFPZ+pZHvTuJwPAynqz6UqAagwp+8Aizh+naEzUF96I/D5+E/MYH?=
 =?us-ascii?Q?EAS5T5fMpq4DCQEIVzMHZiiEwXm4aiAjzTJhR3y/63P3EIwwfXUsTpFG6roD?=
 =?us-ascii?Q?W7DJEB16Z4U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iqm9iChXHVFSfAGjQR9p9cnwyY3FprEQY9bqqTyksIV1+PklRL6e3RspQbbd?=
 =?us-ascii?Q?v2I18Ce/NLZ8rE/FWF32eU8F5r8VKh2oNP7NI2KCAyc/7tvOjj81gIllFR9W?=
 =?us-ascii?Q?Wre2hY+RUpwWZEKDtO3CCNHFCV5ULfi8anXMXOSlROP1qu0L0rJRHwx9qzOs?=
 =?us-ascii?Q?5wti6zxF09VhvJQZW+010m9UUGQmTX952V6KvL0dTroby4eW+7BCurYgup5W?=
 =?us-ascii?Q?pdbGH0PzyIEUeTb1IXORWzjg30LOkFg/FahyXOFqGLDiNViVwr1e83TcdO8O?=
 =?us-ascii?Q?3ikGvL+2A6/BIkyxkTUpA44khm91/vf3QBPY3wJwASCp8/SK3cH3t68rMYMT?=
 =?us-ascii?Q?HmL7/24z5bombCv4QBRa90QI9SPKdAYJHTBQxZwQc8TWmKyllU2ZmGfaAkuo?=
 =?us-ascii?Q?FEFoH7udCVh6rF0abeWVw5hbgiIbM/k2mHYvqb9V2GPUF0Mv9RIQX9wsyl/Z?=
 =?us-ascii?Q?gdYwc5tVlVpi7gPKWHr0/M8FlW6c40mNSLD0aQpX8ymEdE+cxmMHeCJnncrK?=
 =?us-ascii?Q?BKRsndAU9Rnw42mwE0+eyt8FjeSiTUxEL6HaMttVqolKTPGsUEcEzPttL7ke?=
 =?us-ascii?Q?/hD7VqnNNaqEFQUlj5BZ/5jcslou48u4G1xh5+EpduO6hOiVdLMo9NepaTuI?=
 =?us-ascii?Q?F+h7de+yuK6nIz+pYNyKb6A6lo3W/0KgVaqWwtvftzBcnoSaUuO9gRDIbmk1?=
 =?us-ascii?Q?skpR21lUN4YGillFBQtnwCAa+ohZmuaS6rt4CfCrHKYEs//Mqsl6GvqiOvzm?=
 =?us-ascii?Q?ol5KzxSrRYIYBOHSoddbD8SfITKBB9mp0SWmpk2wLLyAvgJw76x4CqElofJ7?=
 =?us-ascii?Q?ZXkE4FhPfiVJ8OkeLMhfNSdvJxkUdUdDkeUQpUBNljPcQZXvF3QWPeRijOgX?=
 =?us-ascii?Q?2UVdoBCo2Bjt+nJ64NUZjGvoNSDl5NLZjMy8byGJp0e5cw80tljk6TAfRiGp?=
 =?us-ascii?Q?gM9+Gr25LNHQFw2yyLBVStFosxQmIl3oEtr3+Z9ErZpYPFZPCBVQC/Jmj93P?=
 =?us-ascii?Q?qFgO7vF3aYKZpg9ynpWxLILuFOm80sgahivjauHbmyGogSdX5rLGW3tN7Hr2?=
 =?us-ascii?Q?NzfD2dvV6IMy6Ep7Y7mfaJsJaUpfFZaSLwEyNbPv/SmjVfrTuHy5wQsYxSHz?=
 =?us-ascii?Q?1k2eX/FszjZJ/fLWEgQeDAoPfbZ1R4tfDp6AEW6awWfzob3v1Tl2D/AkZtWj?=
 =?us-ascii?Q?F0uorSADITD1ebILj+SbizEZjh0Z/X7Sp67v1BVlUfoVrwmaocymtIJ/IzyC?=
 =?us-ascii?Q?mzVa/JdFhtjVCJIqKUBl+0kajdID/QoKgpPyXat3HDnQgH9IamdIBawBgdFv?=
 =?us-ascii?Q?gXGfh9EhSoxYpJFGPD+gfuBtRyiDuSftEleHBPqZ01BZAl+owC124saFuBxR?=
 =?us-ascii?Q?BfP9wn9/95PKZXGQWzOZKpWodLFUyDPac7bo4d0uGu1IpPlfJECos5wtgOmN?=
 =?us-ascii?Q?m8qf5UqrSYrhifD00ActZGpAyfJLcvH2j8i5GDSX8kSI4F2iVlhibxqJe3tO?=
 =?us-ascii?Q?223vpILzap/xUgU+b8EqR3+Tj91DC/E5NhBBgU1+zMim7xBingCRhN6eMtV9?=
 =?us-ascii?Q?lftzIztCZ7oTpfdIaip0gwAlt3idaVGPAUCpks33OO7g+buSf8r6RtbTNKN+?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TEBvNNGbw/fX4FqllCN0zUOZ1ypI2RbHUfLf9RjXsk+ffw2v5ugmv3MFypoS66UKvJsy7w404wSTCKtFkKwSkeTJ8sL7wGt02KQ2ooVoxXcoGZWn1u0ep/qMaaKQsSRSSzHv93+DBQReBw/qKr27BPyEIEgfr6BEwuAZEOtMqF5/hgaOMdhfs7qJ29TVk+z9xyddy7L5a4Knh0uh9VkM3GH4Wrmo7e0HHS5bCMXnuHnFGdy17QE4YneyuIawvRetbeQNDcsZ4RcF+9vhHvwjnOxTttsq39mulUDSLoBbi2NebCzBhy/1ps5vKiVJlPPQhJGgMc9TzZeQ2fML3UaDden62OzCMljDSiljB8TqvEnEKHdykdUwY+FxltQj5/Dm2NrZkiqBadFnDbmNYMDUJvAor6vKwgwEkFUAf9bMgRdkd4lovc0jGAeT9S/x3GnZg0Lr1rYL3do8g9GFHnTQ0SD1OZ+DUhXnbIhhdas+HLZgaBCrPQ8jLVF67V9tXO8BotPHhi+yzuXQLlOIBzCcTCykqaBPWEzUynzNZ+KO6wkFbT9oi+YMIuFTjSmD2tnntuPD/XCCzqC03vqbJ+FBB20PF2Mg4wl4CA/fo4MWfGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a365bb-ad82-4895-8bde-08ddda2c1d07
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:41:55.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9E+PH30uZsyUfxvyCED9PDPlZijd63ewhrCcduOuYmtz7gYC/YhRpfvNMhAt4TB9pUeLAJUoU/8yQup2ED8zxOGi4RDVcCqxlWLNE9N3Kwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130053
X-Proofpoint-GUID: 0dvATT_spLiyBq3xt851QD_Dr_co88Ei
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA1MyBTYWx0ZWRfX4Ptb1QLHoO2N
 I7jA/316XNxH4KsdMFtgMZxB/KA9ilKn54prrEuzHtvP8u1b53Hs0odC6J8jaGrxuTFHL6DCY9z
 FWL9BVPDmg8bahUmqfM9kIgOmhw1sOOi9JKoTWWVHzUXic1HHRol9y9g35BjnjnA80EoyCPHtK8
 3hjLxmUOFiBANfKfhlgqp987b8mnwhokLg+7ZqwLes5XhI/bGqyyIVIAuSrk8WhGurrXdRfAizn
 Hl4KLrP9vCzjqv9LtS9r43aWWzmVDvcDvU7ZCSlcr5LjVUNkQee+Isd7pyal6l6CnRSwU5O1M/l
 WdHGblQ6xpsZSNhRKZBH1mSN6JW2FHLdKWwqkr7wBXmsC1BScEjTPFZyD2Q7P3/5dq6w2ZC9YcV
 cwVbryx0ST9ApQxeYKkmh1DdQfEHsnlPSqrYa4i/O+S5NiU5cBVE1lXB/qxCSesxvXPxlddP
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689c25a7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=1w3ZlxjseI6EK8p87TUA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: 0dvATT_spLiyBq3xt851QD_Dr_co88Ei

On Tue, Aug 12, 2025 at 12:39:03PM +0200, Peter Zijlstra wrote:
>   if (cond) {
>     A;
>   } else {
>     B;
>   }
>
>   if (cond) {
>     C;
>   } else {
>     D;
>   }
>
> into:
>
>   if (cond) {
>     A;
>     C;
>   } else {
>     B;
>     D;
>   }
>
> Notably the conditions are not identical in form, but are equivalent.

Good to point out.

>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Seems logical and reduces complexity, so LGTM and:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/core.c |   41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7064,6 +7064,25 @@ static int perf_mmap(struct file *file,
>  		if (vma->vm_flags & VM_WRITE)
>  			flags |= RING_BUFFER_WRITABLE;
>
> +		rb = rb_alloc(nr_pages,
> +			      event->attr.watermark ? event->attr.wakeup_watermark : 0,
> +			      event->cpu, flags);
> +
> +		if (!rb) {
> +			ret = -ENOMEM;
> +			goto unlock;
> +		}
> +
> +		atomic_set(&rb->mmap_count, 1);
> +		rb->mmap_user = get_current_user();
> +		rb->mmap_locked = extra;
> +
> +		ring_buffer_attach(event, rb);
> +
> +		perf_event_update_time(event);
> +		perf_event_init_userpage(event);
> +		perf_event_update_userpage(event);
> +		ret = 0;
>  	} else {
>  		/*
>  		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> @@ -7120,29 +7139,7 @@ static int perf_mmap(struct file *file,
>
>  		if (vma->vm_flags & VM_WRITE)
>  			flags |= RING_BUFFER_WRITABLE;
> -	}
>
> -	if (!rb) {
> -		rb = rb_alloc(nr_pages,
> -			      event->attr.watermark ? event->attr.wakeup_watermark : 0,
> -			      event->cpu, flags);
> -
> -		if (!rb) {
> -			ret = -ENOMEM;
> -			goto unlock;
> -		}
> -
> -		atomic_set(&rb->mmap_count, 1);
> -		rb->mmap_user = get_current_user();
> -		rb->mmap_locked = extra;
> -
> -		ring_buffer_attach(event, rb);
> -
> -		perf_event_update_time(event);
> -		perf_event_init_userpage(event);
> -		perf_event_update_userpage(event);
> -		ret = 0;
> -	} else {
>  		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
>  				   event->attr.aux_watermark, flags);
>  		if (!ret) {
>
>

