Return-Path: <linux-kernel+bounces-743102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07838B0FA99
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A131C25745
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC10204F73;
	Wed, 23 Jul 2025 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WksN4vu5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HKvJythv"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B537F9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297288; cv=fail; b=My38XbSKU6xp1csRVgdT7Lvjfkn9cMg7vJPRPIQwAzWGCojobix50q24njVWwNaYycoPRC3rqfIT+wcmejTr6UxhMWBkgVVkpKFTww3s/vKRkGoha9m1feFgZ0pCjzz7hDv0gQNrmC9HCm0KA5dMWrLe8yeBleezr9/2kO12dRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297288; c=relaxed/simple;
	bh=MZCmdsNBgnI8rbBBaLtQ5hTPu69UV5Q8nJBnwGofLWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jIM5fbFJQzwF9K/97wEBGiB0aRdGlVpafnq/b23lHnrfgX9C09Je3jiHH395AW3lxDlIni7dYtz4h0J3/XnCAGJu/GPdZRZWcT/mMTAACnfvauR8hU0huNNXlCCKA66tja19xiudRr1hzbS680upSZTuYaofVGqcJ6b+/GxheqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WksN4vu5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HKvJythv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHtw2s013301;
	Wed, 23 Jul 2025 19:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MZCmdsNBgnI8rbBBaLtQ5hTPu69UV5Q8nJBnwGofLWc=; b=
	WksN4vu5ibbv1Mm7+OjG3o+0D5yjI5ihCNUl9xsEguUgE0AkDx0YeFnIHDGq779y
	j44OcmdLdfJbNtx5sjUxo6XaHtR7BFIgn+x1XRMIfGeLocduCn7h5x0m4B8I6TK0
	4aPTocEJlsOysGc5HZtFX6RqkqLeb+uUmeN6J8seIYP6wVbYVfI2OhKEe908V4ox
	nStmpTqn+fqt3RZOpQxAd5VriM2/AIV/WmWzNmlavGMVNVXFT0FkWvjgD+xLI7cN
	xZaxjhWCD2CVMZuV4sgmiND/Ri5perM7zrzWdEnR6+oClYowHxM2b4qqSnSWx8aY
	Lp4KlebpjqHryJ3hAuQVzw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056eg64v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 19:01:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHg6rm037682;
	Wed, 23 Jul 2025 19:01:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tb099f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 19:01:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEL5b6kjmw9W6sDKiSXrMV+JUoKfXwdj5JEmE8Bb+4OaAKZCX6nPQkbPUwzjwov9Omkaz7eLQFZIloojF7JAPcScBhKEijyEERm/4QIzSqmoBxvNHpYwWcSd8cBT/cOWRyx+JJR0i/zyFEdVbQv599Orfha9fNFwWKhOpalS6izjKZjgkXiJxbiNFNzXTRM9LSaSMJn9fVt8BB7v6wDrAuozGV+J68ghNpeIyIoqmL0lgKq4yIUQk76w+dAAwzx7zQu5WmgIb1pHVPW4564uqU0EFyh30SjPhsNBu/r76QUuWsXXRz4DF/PmsDTbabBVihNUhKWaQuG5/YLIJh6/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZCmdsNBgnI8rbBBaLtQ5hTPu69UV5Q8nJBnwGofLWc=;
 b=Pibf0XXttxJDiAPGp2sCpVTLFkb1VpMBC/PAghboBiYbwCyiIlUs/jL86Pi2vO8VLP8F02rwMGUOAOrDemRzlsajOQ7Sm1SvNlZ++Pabyqf1y6jH+Rf5UFupQ7y1XUxd26KccJaR3j4jRzRHwjhp4n49CJ5ld5eFePVFCArVAeX7TTDNxH+ENol1dnmO+0WEVV5AEx7IqCPEKdduIT/mwhlQaD1jT0r3fm+9OOSN0U6ptGYYw7eqdY7Hxp/wqGFDou2k1yuuysX00Act4AKQQ6De8K+dr/rQYD6MDl/CPH1gEnpLmo5BtZLbF672A4y7wXdZSkxuWeVs+CiInXLlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZCmdsNBgnI8rbBBaLtQ5hTPu69UV5Q8nJBnwGofLWc=;
 b=HKvJythvJLHCMA4cE4ME3Gq4GlLHTpOVkla597mbIZcmE5aYR7l8cbn2nl/QEmyEE/pSBxT9VHljNtk/miNPDgsFGPIWqiILopnYq3zc7xmGdVZLw2cjyPdLjaRaquAp0FuQXsz5JQ+6hnGEAtBDAiUux54vT+cKwllaekJ35Co=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8060.namprd10.prod.outlook.com (2603:10b6:408:288::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Wed, 23 Jul
 2025 19:01:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 19:01:10 +0000
Date: Wed, 23 Jul 2025 20:01:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
Message-ID: <e419e15c-7bfc-4fc2-9089-e271a3b0576e@lucifer.local>
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz>
 <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <CAJuCfpG5VeW5+GdceeRCLDgX4CuFm2xQUG6UAAoLwF7oW8aU_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG5VeW5+GdceeRCLDgX4CuFm2xQUG6UAAoLwF7oW8aU_g@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: e454999b-83dd-42d2-df0f-08ddca1b49b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzJMWEhWV1ZLSkExY1V4NnAyblNncFJ1MytlcTBPSHVtZEZzYTl3SkpubmJ2?=
 =?utf-8?B?TEdmVWFieGtXMzl2eG94T2p0ZzJPSUhhVHZhaG9BdTViZ0tLNm1xSEVjc0hS?=
 =?utf-8?B?cHZLa2xlaTQyT3FTV3l6MUZycVZlcTFlMGJJc2NPdWE0S0xiZzByeFhvRkg2?=
 =?utf-8?B?Uk13UEZ6aVRLRWNkVnlUMUFzVVcrZ01oVWJaTGFUWkF3TjJrZlY4VEQxQXZu?=
 =?utf-8?B?bVZ4eHhKamtqNmkzb2k2UHpzV2ROVHFHaG1XdVo2NTBIRUhCd2NkcmMvSjNU?=
 =?utf-8?B?WU9sQzJkeDdlT3F4Z3FYWWJteGtSeTIxOU5DUzhKOUR0N0tmTjhObE1Fdmtm?=
 =?utf-8?B?ZGI5VmVNQlEwNVErLzFOZk9XZXM0Wk02SWI4UzJvTUxwaUZPZ29xRng2T2VM?=
 =?utf-8?B?UUU4Rk50Uk41M1prOVFRc2h3dHFkV3BiMzY4R29KbGZ5bW16MnNpRmhvTXJE?=
 =?utf-8?B?MjUvWjk5Y2d3bGplV09ScVdIaysxYndVaEdCTVBFK0d2Z3NUNVFpdVNtT0V5?=
 =?utf-8?B?eXZXNjRrdU9ZdVdtMDdzL1h5cnVNTVBnU2dmMER2MURyTG1VRXJDMkRGT2JK?=
 =?utf-8?B?V1l1ZkRuYldJNCswYVh1L3ZmSkQ4NTVZTTFEZWxRaXVXcUdzRGhET2wyYkJy?=
 =?utf-8?B?MkNrTGVTNWZwT3V5VUJkRC9wMVVxUnQzS3M3M0h1Ym9jNUJNRENLZmliOEo3?=
 =?utf-8?B?VStleUw3NVI2YUpHNDVGeXFLYW5BMXZaK3k1T081VitvZmFmZlhOV1RGRjFr?=
 =?utf-8?B?V3hzTWNRMjRPMFduWk50Tis0Z0ZRVGxBOWZ6dTJJenJtcm9jVSsvYnNzdWhS?=
 =?utf-8?B?eFlRQnpsbXFSS1UrcERzSkNXRjlQRGRnYk1NbDN5L2RhT1ZCVTBCMXpHcFBp?=
 =?utf-8?B?YjBqcmdQWFhXV3pSYlFVVWwwUDZDcXdXU3NVenBRZzdicFFZeVBNQlIvMVR1?=
 =?utf-8?B?RzJpdGZSYTVqcTQ2akowbndOMWwwZ254bzZvZlZ0Njc5L3BnUGtkb0hiOUtL?=
 =?utf-8?B?Z09Tdk5lMUhGQ2R4U1FVNmduNElscEgyWDhoYStvRFZiMERTMjJ0RTV4Z0NV?=
 =?utf-8?B?SGhRWWh3bDlvY21VV2JPamtTTmpqTmVNdUpFWjF6eDNxOUdPcWF2WGcrb3VR?=
 =?utf-8?B?K0xScEZxMFlBcmE1NUJzZ216STNMTUMrTGN5R29MNVNyTlNPRDNkU3B0VEg2?=
 =?utf-8?B?bm0wbXlEc2RCTldjdFhGdWtNWmhZWWFKNFhKUFpwem9DUFlieDVLdFVtUjA1?=
 =?utf-8?B?bjZwNUpTQzZNZkNoS3V3TFJEMWRsN1FGUmlVaGM0Z2NxS0NTRlJBSG1DQ0Ri?=
 =?utf-8?B?SGtBd0RmbUVJdHhvWVhyeDZIYkUwL3g5ZEYxRE1vSVZIc0JsMi9WVlZBKzN0?=
 =?utf-8?B?RDgwWjdLZUhxbmN4OUpPWEVTNS9aWnlGbDQxUmVoUDRMaGZVM3dMeFlsRW91?=
 =?utf-8?B?dmVIdTBHNW9vZktaemxRbmc3OGhqKzV2S0tJWVQyQU1senJrdTdTb1AzVG11?=
 =?utf-8?B?dm4zbG5WMjUxWmNQTWdOZm9oY25yR3FuNEhDRElPcTQrMWNOeGpqM20yUFd6?=
 =?utf-8?B?c09pTngwSVlQNEhuU0lkTGE2akJxLzQ2djMwZElscE4ySEk4QURKVHJUUzFs?=
 =?utf-8?B?ZUx2Si9ENk9QZkFvNThGZUdVc1hIcnN2Ujl4VlVDVHJnT0JTeDlBTE5RcTBs?=
 =?utf-8?B?c3Fwb3ArODJrTHF0dm50cFg4dW9NVHByUWV6S3hCNW1JY3l1bjRQSERwZWhW?=
 =?utf-8?B?ZjZEV0hZWGlia2Jrc2RBVTh4NXorWGR2SFUwaTgwZHhMUUc1c1VTQmo0dGhp?=
 =?utf-8?B?cDRYbm5jMnJWMjFSQmlZWHNNK3FNZkZtaXhwb1l5VXdtTFRXOHJiTXA5cWVQ?=
 =?utf-8?B?OXlMRTQ1bTZNamROdHRNTTVoRTVrYUV1cWkyU1FZZWxPb21hbjdLRXlGYUhj?=
 =?utf-8?Q?zixaMBwpM+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGtmZWFCSHZ3WmxwWmZ1M0U3ZUNZRTZkQy9kQmxtaWhvY3NoWGIwSGZhZzFJ?=
 =?utf-8?B?UHhPZzFoV01iM0JHcDk1U1gxZ0RXelpqbWlNT3gwRitJaWVPUThsRERyakRy?=
 =?utf-8?B?Qk9rbWwrWVpqVFdjczdtWm5Tb3puOWw3aTh2YlZOOFNUMU5OeExYNEVPWitS?=
 =?utf-8?B?aW01R1NRMnEwRmEwaEljVFU1dzJ0QWJ4bmx4R2FaQ1J4YkdQQzhFek9pZzE5?=
 =?utf-8?B?R0dTT0RPYnQ0OFdKaFR5M05OblZydnMvVklwZVlHN2FyaXpVUzFKUCt5TDJE?=
 =?utf-8?B?eGVHYnRpZzVWa2p2ei9YRzRkQnBiRVFZRDhBQllxTURaVVVwMHZJRytRS1NV?=
 =?utf-8?B?eWRWOTNUTTdrWTNrTTBXTmpxQ1Zza2VUSHZnencxVXIrSFM1NzRMSXFXMnVW?=
 =?utf-8?B?L2xKQ3hkVHJZUkkrYWFhcEM2cUxjWExGYzRQRHpLUTJaTkFPSk43YmJQdHZI?=
 =?utf-8?B?SXFidFlSczV2UjJ4cXBiYU9RdmpPcmtiYzhBaDJrOENnQTQ1cjJ1SUU2dHBr?=
 =?utf-8?B?a3RwaHRPbHhJdHFSWkFzbUFObGRzMVhESDFkaEJzUUNBSGVBekZBc2c5eVNS?=
 =?utf-8?B?bmoxNCtXY1NULzZiRGhmdVdVVWtsL1JVZ1p4NWZJaENla2s3TTQxZHBoZ0h1?=
 =?utf-8?B?K00vWis0Y1RCRWdOZGZrSEdxNS9DQlRDendMTlMvOFBINkNQRzUremxacVp0?=
 =?utf-8?B?bkl6cWNwQlp5TWxTemJZbnlJQjV5dEhQNjE3K1RUOFV5MU8vQmRIeUlCQWY0?=
 =?utf-8?B?TGgyMVcvODNYL0Fsdk9aVEU5S1dMRUwvOFRrY05hYy9qZTQ3RVNyM2NnZC9M?=
 =?utf-8?B?QWhLVXM5MlA5YXdzSzlBdm8yaU1ZVDZGREJDYnpvVlE2SEFRclhuMmVDUGs2?=
 =?utf-8?B?QnB4bExDenFjdlhZNERNVFVyVEtucG1IU2tkYWpTcUhhL1IrQmE0RjJMQ2dI?=
 =?utf-8?B?SVRHL29JaFlUcDZsdDB4YUtULzROYy9QZTVEUUwveE5FWW0veWdzQnROWHE3?=
 =?utf-8?B?aFFSYVlVM2RldDUweUx5YU0wZ1drbk9Cb2E4K2RQVjFPMVBKc3MybmV3ZVpU?=
 =?utf-8?B?L3N6RVhzbVNSTzl3YWRGK0ZuSmpnWEVoSzloRFc2ZFUzSFowMElxN1BsdWJu?=
 =?utf-8?B?YlNIMXY0TmhydFZJRnAyQ1E5L1h1Zjd3WlM2cDZ4bWRtbkR0aENoTG5ndE9E?=
 =?utf-8?B?bDdpWjRUQjU4UmtKSXNZRDZpRHVZZGNWRXVPZ2EyZHJSWkkwbGdkR3JLVTBI?=
 =?utf-8?B?OTNHUkVWTVYzOGJOdXI2Ty9HbkVwYWEzYjNvSjFCZTRHUVhGdFNYWWxISEZq?=
 =?utf-8?B?eGxnZC8vZmJTRm5HdFJRcFhNT2FHZ20wRUFZN2FDRXc4ODNqY0lNRWtMS1Zw?=
 =?utf-8?B?eEZpaWZqS3l4Vmk1enkwbGt3Vm9RdXRFbGNYbWNuQjhSMzBxSXFSbXBsUzAy?=
 =?utf-8?B?QVRzNU5CUVFpanh5SklIR3JjYzQzTmxiQWdqWTVyMVNpaFgrcnRuQU4yZGR4?=
 =?utf-8?B?M0t4M3dORHJuTWJMaHhDL0FCZzJPT3JZTXZMdS8yY3JtYW5MKzBTWWdvL3l1?=
 =?utf-8?B?THVnSWM4b1NtMmZmdDFOUC9kOEpjTjNSOEVyd2RxZHBya1Noa2N0ZFhhMnFq?=
 =?utf-8?B?cGhpRjV3SkY2eWs5cW9pS0ljcUdVUVVzbVJmeEZrMnNBU09TVjNLTW5hOU03?=
 =?utf-8?B?eS9FZDVZdUdYcFpSY0NHaXZxc1FZQlRVQ3F2c0NZQVRaYSsrV0FOb0YxNUkw?=
 =?utf-8?B?RWRDZW93V2NETFFYWEkxVDJFZmhBWXJObGdhU0tTSjhoWDZkRDl2TTg1UXUy?=
 =?utf-8?B?WFZ5eFVmQ2p6dzlCUWRrR2FhMWNLcXI4Wi9uQkY1c01KZCt3bU1rdTNuR09P?=
 =?utf-8?B?cTQ3SXZYdlVRZStuYzlzbU1SWGVXQjZySXBacll1RmpYRzVpdTBUWmprdE5s?=
 =?utf-8?B?RmlwbkJFdHErdm9ma0JGNFpzTTlWaTNzRG4zcmlZK29LOGhyWTBDdnpYMDVl?=
 =?utf-8?B?NDE0Q3lrQ0xKUHhkclBHYkViWW1uNlVkTlRKalpUeFB3RE9sUmhYWTY4VDl6?=
 =?utf-8?B?cU0xV1B2dnlxQkdWK1ZLTmxBdWpteGd5NVZaK2RyN0NEYXVnaG55Yzg0UWF0?=
 =?utf-8?B?bnFBajJJa3BBa08xM1QwLzZqQmN2RWhVb2N6a1U0M0doTFRITjgrWTViTEg0?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wXxwlWfvVlMHou7mDzSmi+n9rTJk5qjEsOvDqFXATUUyCE8+vq124ABrxEcj8fu+dj6XXraSUmEmazfcLBdFEXy+Ikc3UCMYW9mi/uNoxafFhCXaBETMx5ledAWabx9nhb3acuadho+2KnAlgQaBagzBxB49uLvMr1xiVZrV8wG3keg5gjaj9eqaOnD6l2BFdveSngNBPR8IQj75nck0zX5seiNkJUL0T3WaV06MOyWnNUom5AWqH6wy0m6oHCEQF8HDlH6Fw9LRujivamUSaGV67fuGT6kiISDRjCyll0DX8KGqtW10OxXXjOlZeGuQfYW5cZXTASZewqP0ILjtPfpEgr+RCqIsuNT+c32aBTjRGnl+42DFFjKpjPs0OrWw0hNLIEjguduvZN1ZXT+bbOCfm6XTHFcGgF5oHtWFzgyCTTLHpSnFlxWhx5LhSnzxRcTwrZDL8hXLSwgS1OwCFsLe2yFxjrWVZ110IODIuFiIRGHmygAqV4PHPxSbJeDjx/8Tf+4pZLCixA0g6Mk/g4WLIPbJDDtxamGx/mbOv4I2hEBJJDP0L5KieENflXpJw0drhqn1ryTCk7t5SJfP3xuFB0iFYV/31mYw/JQFJl8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e454999b-83dd-42d2-df0f-08ddca1b49b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 19:01:10.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+ewyLn7mlbdqeVDg59dcrLiWGhp28lLp5UkYVaU6OwlLDLW2GQyCF2+rXbCuJg/qEoV0opt//WzwQizd77DJJJ+tTBDzPVfPnC9GWxeGdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230161
X-Proofpoint-ORIG-GUID: CdJZnUVuPss47H_K2FUXq4JZlHq54TJU
X-Proofpoint-GUID: CdJZnUVuPss47H_K2FUXq4JZlHq54TJU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2MSBTYWx0ZWRfXwUQgB3mR0nVJ
 +BxXPeYPMJ0QhOALyjvcNjraKELQCl40zKgtmb6YZk4pymZCv4CfoN+a70kQSZjSpN4iYzulT/m
 i3dDYVp8oyShqxO+4jHwHrrR23VEdeH0rBo1Oqj6RuNVa8lG469AIdAVL8vo+jvh6J6qwGBILyU
 oQtdyBlFlfwexhyV+783jEuAhxjLXwalrCxv6hoBSZRo+fWRfvCbNab9Cx6FJFFHRpQst8d8HNO
 oFEc3h0N0CTqNSVncIid+br1PR1+fvSqjk9z0n0lrmDs3ssOTTlvYg9KSbcLb9bUOKJAyq6PSnI
 LCH9qHaik3CbExbdg1I6kc/xDInsJNbr3yihm3eGyUfsLkGglUesW5cMQpO9zKtR1qSA7/OS3hM
 AIWEeSX8t+YOjp/h6gzGZbL+nxmcAbDQzgJZAw+UvVY0/ES07VlqkjRK32699xC2ET0vDZyH
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=6881317b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=1XWaLZrsAAAA:8 a=ejgKNRFy14GAjhRzECQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12062

On Wed, Jul 23, 2025 at 10:55:06AM -0700, Suren Baghdasaryan wrote:
> On Wed, Jul 23, 2025 at 10:50 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Wed, Jul 23, 2025 at 7:32 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > On 7/23/25 18:26, Jann Horn wrote:
> > > > There's a racy UAF in `vma_refcount_put()` when called on the
> > > > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is used
> > > > without sufficient protection against concurrent object reuse:
> > >
> > > Oof.
>
> Thanks for analyzing this Jann. Yeah, I missed the fact that
> vma_refcount_put() uses vma->vm_mm.
>
> > >
> > > > I'm not sure what the right fix is; I guess one approach would be to
> > > > have a special version of vma_refcount_put() for cases where the VMA
> > > > has been recycled by another MM that grabs an extra reference to the
> > > > MM? But then dropping a reference to the MM afterwards might be a bit
> > > > annoying and might require something like mmdrop_async()...
> > >
> > > Would we need mmdrop_async()? Isn't this the case for mmget_not_zero() and
> > > mmput_async()?
> >
> > Now I'm not sure anymore if either of those approaches would work,
> > because they rely on the task that's removing the VMA to wait until we
> > do __refcount_dec_and_test() before deleting the MM... but I don't
> > think we have any such guarantee...
>
> This is tricky. Let me look into it some more before suggesting any fixes.

Thanks Suren! :)

I feel the strong desire to document this seqnum approach as it is
intricate, so will find some time to do that for my own benefit at least.

The fact VMAs can be recycled like this at any time makes me super nervous,
so I wonder if we could find ways to, at least in a debug mode (perhaps
even in a CONFIG_DEBUG_VM_MAPLE_TREE-style 'we are fine with this being
very very slow sort of way), pick up on potentially super weird
small-race-window style issues like this.

Because it feels like debugging them 'in the wild' might be really horrid.

Or maybe it's even possible to shuffle things around and do some testing in
userland via the VMA userland tests... possibly pipe dream though given the
mechanisms that would need to be put there.

It's sort of hard now to separate VMA locks from VMA operations in general,
so that's something I need to think about anyway.

But I'm almost certainly going to document this in an 'internal' portion of
the process addrs doc page we have, at least to teach myself the deeper
internals...

Cheers, Lorenzo

