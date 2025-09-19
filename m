Return-Path: <linux-kernel+bounces-824008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D025FB87EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F22E4E85BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E523E33D;
	Fri, 19 Sep 2025 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5k+5iaT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D01B0F1E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758259919; cv=fail; b=GvQxuVMY4U3/6a50XIBem4Y7SjQxaFZOu2/wkq+HrgRNgPDHPv51+qmfvNOdgt+yCjC+0AlQDuDF0u93oZidFg7s2+nSDscyMqdi/B7+PbejZdRx4HuZKGbnPZlTgceTbG3Bu3QpwSILiYVMRlpH8XRtoo4559wAq8TWugZab+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758259919; c=relaxed/simple;
	bh=W/1rkzIrRZr9//ADqYVbYyDb3h4zmjK9Jxv8SRmArYQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jVoMfbQrteI5p4ZhfN9FO0iXsLwxMx4ltD/5cauiVh9bAWbYM9az6w3eNzbgEqiHF7yynfIDGqwWDP0pLUsQaa434yDm7LzcGPtIPTaF0xd1JCjOmG9glCGxE4pXMpnj0b9NZjI2biIY7TqSgnI14uwkfBM6G7wDkDYCCHG/g+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5k+5iaT; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758259916; x=1789795916;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W/1rkzIrRZr9//ADqYVbYyDb3h4zmjK9Jxv8SRmArYQ=;
  b=a5k+5iaTd5jBCtAHWGQnKxTRl3XhZHxD6CNUCtKyF3w9F2jnRvbz/aSF
   ZGW18SGOX5KsYqeioJQVYN6CSOEXisL++x9aacjZc0f/Md5LMo0kVBgZk
   /BDJwwAO0V/7rEmuQdkxfYaDHvyz8R2S5EpnZv2LhtW3rElT8aMtt8DLm
   X3L19mFTgZBfdKeYQwavKl1IdRH0J3ThR/2gC7+7++2CWzyTlxd1BNtkZ
   rb3CKfbC1vqW/el83bdxCVWNpi1g3EpmxrW4AUWe1Ew6LjFafrCDk7n/5
   36E7Sq6WK7FdsdK17+t0hdw7hcaDZLOzjupY5/WMywcfMuc+3eHpLXWIf
   g==;
X-CSE-ConnectionGUID: Dli1JZEQQkuZBQ/QOLFpEA==
X-CSE-MsgGUID: 4q1uje0qQSymt/7zKqem4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="71281924"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="71281924"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 22:31:55 -0700
X-CSE-ConnectionGUID: aA2UIbXfRt20iYd8LDMqcw==
X-CSE-MsgGUID: lxbEd1lIRuyglSxRuQoiiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="176550322"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 22:31:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 22:31:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 22:31:53 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.34)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 22:31:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WO5W/fcYwXYT2VtqwEMIufUCT0o6DhAL1NzGGLf9wsJfFQwlgSNdRXH4hHw8ZtjZSXsd4gvffv71Pcrc+GDcy3MOth1s7V+2IynDSGB1AzUPjKEhbTB+P4UT7BFTZPa6/nITrOAbMnoeKNS9nWHUqLOLaiUit82dle5/M8dn88MlkB7uhh7c1XlICeJkmQroSsy+aHAAAmPf2tUvl7mIFwB3jNd439SMbwdn2srCW7f1+q6Bw6hFUyxDIExS5qyutzDBfCeB0qvSMydvpSizxw905a47Ju+Zlj3N4prAm1uJb/5pCBNKrWDibf3BX+lGqvJpMfpkHXwh6ri2xxTDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WeB7QjDUJZg5QK8mfuhszcY1iBioh6cvBdUpo/q5yg=;
 b=s1bwGKRIPtgAAwx7sYg/SVxUGRGkwOjEdAnwG6o5c2JvTVDY8BasMJOJzdzGz+8W512bkiCWMmnNpcr1KhtQAelVN2jNxPoY2qFtcheBy8Z9QMAiukJPQFisOwuGy16FjawrzTXpnoSO5HH1TxAL9dyegFAmeo8QvLEn91yFgTCGfoX/8Hwxu21fxJZ01tYAi6QWNDMWla2am7nAzGBLPmMIYCpiJ+MQPo9oAMSSubqeuAni3EOpRAp/Pl/1UjYJpYRUtO9CPiAQ7TeSSrKsD03s0cPleYkc0kfa+r2+BCqvEW/5V4UvqYpeKa48fS85E8kkxtBMk4zi7vYcn297Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ1PR11MB6299.namprd11.prod.outlook.com (2603:10b6:a03:456::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Fri, 19 Sep
 2025 05:31:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 05:31:50 +0000
Date: Fri, 19 Sep 2025 13:31:42 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [peterz-queue:sched/hrtick] [entry,hrtimer,x86] ebf33ab570:
 BUG:soft_lockup-CPU##stuck_for#s![pthread_mutex1_:#]
Message-ID: <aMzqvnTA9dFRQRtd@xsang-OptiPlex-9020>
References: <202509081329.81f1ed82-lkp@intel.com>
 <20250911073304.GN4067720@noisy.programming.kicks-ass.net>
 <aMN/e2MHdJaaGT6z@xsang-OptiPlex-9020>
 <20250918074536.GE3289052@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250918074536.GE3289052@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ1PR11MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 6150c360-9f2a-4c88-2a94-08ddf73dd567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aVQ6yXwhWXfe4UZZlVNS9oJYBon06lTsU5qamHAb1XQIn8uv8nQwlf2uncRG?=
 =?us-ascii?Q?mstYBdRbrbwl5qE7rGO3wnI+FVzrZWdvOXaK3StJjE4DSq4vO2mBqwqImSGP?=
 =?us-ascii?Q?5fwalG560oqCYqPrHh3eUO7UlC9wMj37JRqSkNjyU8GD0TZ65h7RkniGj+tv?=
 =?us-ascii?Q?2fwcv/dCJGlASWLplBdqzAhY3C1l78wn+IgHfftRH3asewQUl1IHazxU8nz5?=
 =?us-ascii?Q?ldhA54pmsn8R0biLzulv+UaCoAFlKe7BIIWyev9vChQQqeyspWvo2gqcdyYx?=
 =?us-ascii?Q?+7lMAbKRzt41S52JB10BALxNMfQDaceU0yB2Tb39P7JhbQ2BXzY4l3dkdH1d?=
 =?us-ascii?Q?u/l0ZISCONxjw1j4SZH5Uc7m5Z8os4ZcgzNX7P1HsXhoLST5T4Ab6tt9tge5?=
 =?us-ascii?Q?navFy98D+OtzJhG1x3yhRoj2dD8eGi5yy9qjDo0M59e7iVPgl6faEBLFTMfr?=
 =?us-ascii?Q?5h89JbTA3ZEDQwn0GBr1EixETTEBV7A40W+3evTO0EOTD9VtRJhjq/ABkKWs?=
 =?us-ascii?Q?s6e5vc9hKpItV77xIVuUClio4nTs4st7qM9S/ZQJbq9DCojjPNJdaw4QWoZW?=
 =?us-ascii?Q?nubdpL/S0TiISMPO3VZ2LtWSCqrFiyCDyNYeTPDgfDryH6juzCpIg/EzT09y?=
 =?us-ascii?Q?9ihZcYh5J/Eo8xcIhhR2MM1epeqNHmw7E+0fDSz/ZLEYwaPAGfg2Nu1pjcLO?=
 =?us-ascii?Q?oGsXKE5ZnhwpB3D+yUlD5aunrRUhVAVIacQn1+xn8AEhIoWtYKMvR4v67Yms?=
 =?us-ascii?Q?NresmWIGi6BhnAKI+C0+BjnsDKNtyA+mIqCGDpbn7EgtVv006wM2X8tBtdBZ?=
 =?us-ascii?Q?SlSJdB/nBoRo3VCT3AcUYItqJNir+sVWx0tbd2gzJ3eCivhUhmTgfyhF1EUJ?=
 =?us-ascii?Q?bX95ksCIEtkSrr7MEYhR2me6qzq1aT4HuIFy9gUIbazhbzykxJlMomcfqnQo?=
 =?us-ascii?Q?IMsAUawjYmJbAiqKTtemBVryQDo13SOdAUtTZGbO7QfyO/E60/TuJ9w/GHde?=
 =?us-ascii?Q?RB1ksQ4toWDkVhpiYq3+QVmsoecIFmZdYR7KI52xpU8JKcfacYacqCcMUL/f?=
 =?us-ascii?Q?ErXs2aA77wvjsFlOPExaO8ZIlVW7dD/fzu0TqhGTJ8e1kWxTXZwcloDZavGm?=
 =?us-ascii?Q?Zi1przWqwBydh0Vo4ys40n69Gzy9veqSrQPyTveyGw4ZiE4oUhXJMrwsvARz?=
 =?us-ascii?Q?Tn88PrC+sdmB7cs47D6ACWl5Rp8qsmKdtuKWFkBSurmkWC6C6277OYognRh4?=
 =?us-ascii?Q?ySDOpdrtTQYwEdZB+5eG0v7RrxQG3Yf9TUVHlpC21jb3Qz0iAyJHlEr/c8zk?=
 =?us-ascii?Q?D5znyfaMsDF2CnUeVMRS1cw0LSeanY5GGkIKLNWlmpqfWMfxn2UIl3y81nSK?=
 =?us-ascii?Q?JROF51VuvXOiZkNAXtjujRPtcsr8i4smIeJ+LQP17jCgq+lFX7SoJr8I61aK?=
 =?us-ascii?Q?zTBsP+UvcZk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ylEpbdvaCycdvHHq2WL1kFtMqkW8dzRdj2Il39Irp2LJq9x3BEl1FwHsh4Pl?=
 =?us-ascii?Q?H/ZJ9D4IwsYy46CBIH0+YmQe3XgvRq1EPJRGcBPSOwd+YKbdBvyB5GV8VJ7A?=
 =?us-ascii?Q?tmTVEouNMZkfyUggfMh4L15sQepIsz0BkEPnVlrf2+356lRP5jT/uczTmcIu?=
 =?us-ascii?Q?wiRswhc9UVvSdTWxrnwnynOngIFaXUiVYO/v25p4prbKO2wHoIzkR6NyxEJu?=
 =?us-ascii?Q?H+5wh0vKLLqJpQfQZRyi7WB5rS5K6xTMZehNHhPghPtDOWB68MoR1IMcfxwO?=
 =?us-ascii?Q?SJ9nDB9qGO0rvLPd753GMRpsCgMmOPTQqyfZcl+qiUyoODaCRJ4w20UKCM40?=
 =?us-ascii?Q?l6jC/F3ZVmyxAUe5Jnsnv5s6P3+oxefYFvVis5elZUf8j1wK7TDGuvcdTiwP?=
 =?us-ascii?Q?00qh+IjiZwkbLp3ai0pOoRiAHWz/V1Y7JoyUSGHcrsfi50sv13f98BmomCfp?=
 =?us-ascii?Q?4992qd210WQhthah3XkpPILZqC1DBolv31lgRRk+bSRiPsDDzWK5HwHtGsVO?=
 =?us-ascii?Q?L9JEK715E1GzXComqg1kgzXALifmbJaUHUM41p2bZ+VZ1Z3xYwI7IZQlHus3?=
 =?us-ascii?Q?aXG1Hl/ilaJ5jaAy3M+JvkuLBOs7rFSsvfgMmfyQswT3u4WLhplCuhrmHUP/?=
 =?us-ascii?Q?hIatn/WqTF9Utf2yTqD0RVUnV1DvGm652OIiCGUU4ZOaXx96QI9k/YFYNkdN?=
 =?us-ascii?Q?oLJ9Oel/QLeqd5d2+knuK5W4r6BGRsaGolNi8lD4BZxnQn0rfVoM5GEXG+8c?=
 =?us-ascii?Q?+0RVibm1JpQRZDV7G2qyxkGIiw3UhLb13QcLdDy01KRen0BlNUQ9lyjp7NKD?=
 =?us-ascii?Q?W2Fhf6B6FDkRO0Aw8+oKcSsmiwoDU4N4MQfvklzb61SWk1Hf5zG4NT6PfBFk?=
 =?us-ascii?Q?OLmr61vNZQ7FsA97Qm3+yWdLdfTSdIsGUrfspfKLs1Od/AxqBIF0kwOONmLR?=
 =?us-ascii?Q?/+4JpCqG3a6Rn8Ly3/0y+32tQZEZoDYFLy1XBSSmy0ohfEu/wQneTcnveBzG?=
 =?us-ascii?Q?6th21dEZr7A8kpe3ONO85j2eX0ZCBLjDNaWDehIS/pbnvVowlGTu6xCVsCWx?=
 =?us-ascii?Q?nRYMd3MZF/a7FgoWkxa0+usyJjMx08Tf6QVDL7LbZYbjjkj1R6cGJE4qGbxq?=
 =?us-ascii?Q?rorui+IOjYvd1fdklS1z3SxTmaepeag2c1dunFPrLpIzTpMOCOJSQhg0+iod?=
 =?us-ascii?Q?l9qkiOXH0V4GOBbhXrQuKcdsd3pmoAgm/bnoetHRCkMpLYxLPlnSBkhxrsvD?=
 =?us-ascii?Q?5dNQXgrdN20HNfhXWD9rZyjjmK3JXSvl2Xaq7AhFzN8GwWJFle4zscX/wNkq?=
 =?us-ascii?Q?mul3Tct16HDBZrT2ELIAbFqPV80d3ggx8VG+t4VP5X0OTFTdqlR/Ua1nguqt?=
 =?us-ascii?Q?oJtevil/ICzuaukbDzCbN1sFGhsEyEQy5N6EOEfijhbtdmryrugD1KwGdHfy?=
 =?us-ascii?Q?EilzJCfw1Csco3xzvVQWdj+lJNG0IcDWX/pTPySdUAPi7PC5vHaLeIn7G2Le?=
 =?us-ascii?Q?PWVzJ+s918qpUKVJadPy8eXUJXVWNnz0TdUalKWD+aqiERh9bWnR3UGbWZAQ?=
 =?us-ascii?Q?7Bji+cOfMnSLyh8FL60RoYj96JX90pQlaoSUuWMCOo9hnLSPkb8G8qjPTzoC?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6150c360-9f2a-4c88-2a94-08ddf73dd567
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 05:31:50.3111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dr6BBas7bDlcbSDv5cBq2VL0yJBxVUQICfoeIAJQMdwQXpilLrdwXo7NyXquq05I7ckareyo9rNVMFkHuGOIlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6299
X-OriginatorOrg: intel.com

hi, Peter Zijlstra,

On Thu, Sep 18, 2025 at 09:45:36AM +0200, Peter Zijlstra wrote:
> On Fri, Sep 12, 2025 at 10:03:39AM +0800, Oliver Sang wrote:
> > hi, Peter Zijlstra,
> > 
> > On Thu, Sep 11, 2025 at 09:33:04AM +0200, Peter Zijlstra wrote:
> > > On Mon, Sep 08, 2025 at 01:24:54PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![pthread_mutex1_:#]" on:
> > > > 
> > > > commit: ebf33ab5707c7c9ea25e3c03540b1329ad9aff1d ("entry,hrtimer,x86: Push reprogramming timers into the interrupt return path")
> > > > https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/hrtick
> > > > 
> > > > in testcase: will-it-scale
> > > > version: will-it-scale-x86_64-75f66e4-1_20250906
> > > > with following parameters:
> > > > 
> > > > 	nr_task: 100%
> > > > 	mode: thread
> > > > 	test: pthread_mutex1
> > > > 	cpufreq_governor: performance
> > > > 
> > > > 
> > > > 
> > > > config: x86_64-rhel-9.4
> > > > compiler: gcc-13
> > > > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > > > 
> > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > > 
> > > 
> > > Is this the same issue again as last time? Eg. disabling all the perf
> > > monitors makes it go?
> > 
> > yes, if disabling all monitors, the issue disappeared.
> 
> Could you try the below? I can't convince myself it can make a
> difference, but while rebasing the patches I noted that we set the TIF
> flag while holding cpu_base->lock, and clear after dropping it.

FYI.

it actually makes things a little worse. we capture serial output through ipmi
for this server, by this patch, it seems it crashes earlier then we cannot
get any information from ipmi this time. seems the machine just auto-reboot
while running tests.

> 
> Still, its all on the local CPU with IRQs disabled, so it should not
> matter.
> 
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1989,8 +1989,8 @@ void _hrtimer_rearm(void)
>  		now = hrtimer_update_base(cpu_base);
>  		expires_next = hrtimer_update_next_event(cpu_base);
>  		__hrtimer_rearm(cpu_base, now, expires_next);
> +		clear_thread_flag(TIF_HRTIMER_REARM);
>  	}
> -	clear_thread_flag(TIF_HRTIMER_REARM);
>  }
>  #endif /* TIF_HRTIMER_REARM */
>  #endif /* !CONFIG_HIGH_RES_TIMERS */
> 
> 
> Anyway, I'll go post these patches, maybe someone else spots the fail.
> I'll be sure to make a note this patch has issues.
> 
> Thanks!

