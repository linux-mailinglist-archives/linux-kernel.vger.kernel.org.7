Return-Path: <linux-kernel+bounces-875132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A181FC18496
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560F83BCFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2C62F7AA9;
	Wed, 29 Oct 2025 05:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnTo/46h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00D2F658E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761715540; cv=fail; b=deXpZ7/mV6qLEgRa6UkX4K47dSh6P298DRSI7O+clFxhX4uoW2A11r/jQicwT8mtkaWZ/iwc1IpmE3dkf28K/aUdvZmOmZZPh10yCC8Rq1rsyV62dehO+3FJ2HL9lyG2kTNg8ucMHZHeScCov9dI5TLwAhaNkJHODrCzD21d/XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761715540; c=relaxed/simple;
	bh=VIjMJrDAY+VYPW6IQecPH+kZqLCNsAVhlP8RR+tEAGg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Z0PQaWr0cpynzveKA0cH7deLtRMe1/d9LNEDzujgtWxfCc/oAropj/c7u9anJCiBkrcAcCY2cOZa5qZHiY5UJg3f55EVJs0HCEGfNDoVIfRvELKLbzjpjqg3f+wnVOgouPCBgVrTwFw86C2sHhl97ufKeKEJFs8LqZSE3HT+cRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnTo/46h; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761715539; x=1793251539;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VIjMJrDAY+VYPW6IQecPH+kZqLCNsAVhlP8RR+tEAGg=;
  b=ZnTo/46hNFhmt45OF0lyfoBaWFrfdShBF4lrWGabGhzjDuBprU1c+LeY
   eDpwwHpQqt/w1obkF85anbBh/yxJHmnD3NGjEU3O3JGbNAPuIfgq9GiIA
   KXJFuowVbH+LOeZM746BuWJSARR2xOUW7OmGC9Ttkk52sKTUWI81B28Sd
   DGJ235dyuPTJ+A0jF4f5SoqVORXehzQ53lwkah5U5L0FJ5yMXKRYOdNak
   IhQ9fjQzOXyDl0vtRWcphAMOtel/c+3hV/Amzh/m2Q9RPLkM2PWalba86
   Ku1kePejMNTB4LAr8VoDBgTe1WGMS8EV29/WShKYtGs+p6HiE3XYZWJe1
   w==;
X-CSE-ConnectionGUID: cEwwV6otRf2+oKZ9RZHT7w==
X-CSE-MsgGUID: +wbX3u6lQJ6/CH9JcOLtrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74426045"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="74426045"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 22:25:39 -0700
X-CSE-ConnectionGUID: f4E0Dve3SQ2pugfwlE5/Gw==
X-CSE-MsgGUID: tVAAzmMqQVqiZ4rmCKo0UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="186014652"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 22:25:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 22:25:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 22:25:38 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 22:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eglBbNEDuDxQq4VEmfYsA3GwTtdmOp9GxmgS00QFUGY72wLf7Dzq5bvsRQYfJ340saNzKFlYo09HiWQVjMCI3bF7RhEH12Cw5dUJmQnPrEmyyxe8YafWvG8wdE+Wzi1wPdDpDi4jXzoOk6d8UCYRSuNSbYdC/giiJUnP6+JHbSv8YUTv0fJoXXp6hiAxreye9+y3MP9gIghLZ6WoyPzbIUvLVEpNqLMRS/D/n+Q4grSi2AVK2gnuH8ByW7ZCzFgt9tLi1jFRcNW8uZ1q/gM4aHjLrDW5863arDzKqzQJJI97cdh7CidZbXLPjp0ODdyzhb5IjzB6dUf+ubiV7stfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUIe0nMJLfg3wAGYlVP0F923EAXYJWnxK4yDE/Jgu3U=;
 b=fnUgBJkNSMFLD23n0KlK2UAhd3QaDgrrR24QSbxf67CjpiqCvl4q8uO9rOcM7ya/KhLlbpngZb4YFfcvdGTDd9yjAKzfB9DVO76NoeCb2zrKs+NX2TX3vcVP7tFaGlR0c/FlPqqvtTlyP+mk3gEiUv59fFwTEQ/y+aA8dhipFjPSfWeOHSPGVaeDjIfRWeorgq4CijCO5r8tw5uJ5RpP+TD2d0ALJdOG7rufB+8nvCuIZ8Hp9TBIXYmMfDQkiuvxQGaqo/D2gR/idVHv2GAl7sLg5w2viMLrD6UqcM6fBlpmyGgBYyhLWStPiQMwyGsFR1fpljvk7LG/OQS3TrEIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 05:25:36 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 05:25:36 +0000
Date: Wed, 29 Oct 2025 13:25:27 +0800
From: kernel test robot <lkp@intel.com>
To: Janne Grunau <j@jannau.net>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Johannes
 Berg" <johannes.berg@intel.com>, David Heidelberg <david@ixit.cz>, "Rob
 Herring (Arm)" <robh@kernel.org>
Subject: arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400
 (altr,tse-msgdma-1.0): Unevaluated properties are not allowed
 ('altr,enable-hash', 'altr,enable-sup-addr' were unexpected)
Message-ID: <aQGlR6rnayR/d0TT@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|DS7PR11MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2025b9-6354-4bc4-4409-08de16ab9667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s5AHww7dSK66H3AxAk/AHrRW8coskcwxoPdqfdIWxrDqf5UCOt2f8puLPyWo?=
 =?us-ascii?Q?yElCsCLOOOruUBb8gIvcyLpB+hPwT1ZIXmgDOaS/SblFUfJUqkR7LnYj0Szs?=
 =?us-ascii?Q?21l8gkRm+u+ZfOYO1fNzL9NR5rj5HmAe3pmCzNO2hof0HjtK6whgHv072PXT?=
 =?us-ascii?Q?PLao67QG0b70bkqA2Qqx+TfYqIIIAT/CW7gaJU5JXq5WdPR31v7DZvux50H+?=
 =?us-ascii?Q?x6Ti4AOuSxrUq+2B+80Nqdz1LtAX6+m44Abey5GIcFIC58xdTNhT/CdfNBGA?=
 =?us-ascii?Q?+IAG9zRhuXnVd4aadnqi/yr3EznWqzbr51Q8ksEWRvC7bNFogBLCfCqtsPep?=
 =?us-ascii?Q?e+lZStjdDUjpLSQVI270tPtUXq57DwkVLjpGgXUaC80zHbGmuCB+FSyiRPP+?=
 =?us-ascii?Q?0ELUvHdDRuMl+z8nMNM5LlST1wk6sCocfoKyK1msxB7KxgGfJAoaC0zk8CGO?=
 =?us-ascii?Q?SxHNSWH5w/5cMHEnSI6ikVW/EUxCeqqeYysSJirXUe2qG9DdXDC38neU5tIR?=
 =?us-ascii?Q?eK9gA3TQ2kIVjl+L9PVVOoNAXkQzmW7eWnGj0FYUD1k7qCS/qwcbkI8c5Ebn?=
 =?us-ascii?Q?ry/7axlhSGhUrTG97kJs/pISIDvtTjlWEkjAYnILm3h8lAVEtJegeDKrntl3?=
 =?us-ascii?Q?UEGVWhrVFDyThlpubJatpH5jCBMJx/FMdSob61uFGTWQjPmBKSm1Ixelu+ki?=
 =?us-ascii?Q?s447q0WAzhi9LjysL8ZMcU4nfiQ1GKq9lU6tkxyRGfjiRO981/jwqj3b/zBG?=
 =?us-ascii?Q?b/zgDp+y6gsV0BkEEKdXEqUweiStrQnN/Vi9t4zbG2BcSU4iHdJIZyPrGj7I?=
 =?us-ascii?Q?n/6BJMYzZqJS0Ev5l6N/uU1cKziAnryZL6XQBL69rNdTivSrcpBNswN+G+Ol?=
 =?us-ascii?Q?vDMLMmyWxPXKuHQiNngBvrhvnfwjJuZhVyDQg6n5uvvEeM58vWSZonFXZyjd?=
 =?us-ascii?Q?ak5HvkaHUM3TDV7MDYmaxucXwszQVYM/yd8MIzjVgIrIK/Z4pZ/0JKkdlBLG?=
 =?us-ascii?Q?PVqvAqU5ZWn97NmQ7S6/Vq4UHBlN2Tuf3ur1K8+2qrQLCA0V5AjnNPonukv0?=
 =?us-ascii?Q?fgVFwYy1rsOaYQB2jahxgcbpfROiwSs9S8mmko6jta/yhvmfJUen8U6yPoFz?=
 =?us-ascii?Q?xVpQ8GRp0wLKRfzNfGy81whnDRYLsOJUqHFfHiF1oXprWXkNKdMBzDsNNl1B?=
 =?us-ascii?Q?PBncZIfDIHMgMXZ2sOjKwNfpUWFtpVX6Ob9Fck/h4iLphjgarVssS6WuHSja?=
 =?us-ascii?Q?sKkpzCTXpvHHS/gaKias95/PR5TuCs9pCrrviy1Wvjp6ZIX6EfqkSO/aN5Jf?=
 =?us-ascii?Q?Q/ul2fGrHnzOCoOvVU+J0fair8o6B6pIY+q1n+onVCSj3/tJA5iCYpDSMv8P?=
 =?us-ascii?Q?XZATW8bJ7qCKvpkCSZBh55mETicgqEHraNc8aIz6ANhOEodgUgg6sAU9P6Gs?=
 =?us-ascii?Q?CDyr8m/1yxayRhVuLXIpzc9MD62mdYvWvSkrYTnEXmm3C0tdI2+v3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wcRSwBCp/yx7xpkbkB/B1xowXUQbUApptxLeLMDxUjY2JrtC2ss4Y1AfKDd2?=
 =?us-ascii?Q?+OgvsLzi8iAawSP0Tbb5oU9FG6luk9LngOHW0dRzEhLztq4lTwKz9i05KCko?=
 =?us-ascii?Q?l0T8aB56HYjrkn5X6auCRoDwf3nRM7bL/ti3Bn+T+gkwsejnYQUWDTjgZ8++?=
 =?us-ascii?Q?NpLN6ibulk6NQgWv+gMVNv2CgT2kdZDYoArJjs34ae3bikQbmC8o9wMk/XTM?=
 =?us-ascii?Q?W4wO1kPyi0YJe+hHrJHMQc5NUndyg+VlQ6g/yHQRQ3iE87XgRYhcmKQkBTul?=
 =?us-ascii?Q?OHcypBJDAWraHQHBlKIGhKJHxQtZm9u2UA6K/lzLUgZG4AWaWNI2P3lLC03M?=
 =?us-ascii?Q?oDT63fiBiwq8xN80wyx/H5XpYXvu+iLl1cS04VVqbugK3X3sR4POubci+UAb?=
 =?us-ascii?Q?OPpB5LcRlZh0MQLECwSTUV3Ys/rPdoztISGetzldd2kv47vPazQx5T8NzceE?=
 =?us-ascii?Q?twSLyd6xDbYRT3WvBZnqJ+vSwMrgh779sHgWQkT734NJ5dDstdxx/+V2RWCV?=
 =?us-ascii?Q?WpPwEiZQgV1pt8yVw6QhHTD8+lpaCNaHnjxtR+6P/7aAmw0jQytGWM2i9Rn/?=
 =?us-ascii?Q?H+Zl1nLgIUUHebLRMsumyEv4Tzej4h88Vl4OTZPN2qecBHZk4q6YhLjmwGwB?=
 =?us-ascii?Q?ci0cb35/2tQSQHU0tBiJ868e+IkwqUbGF5jLFnTYb0COSVQfFq3psct3mezi?=
 =?us-ascii?Q?XWbPDymj2MzOLEL/nWDY3kNynT/cdMepkR7+bIk+u0r30G3QPt0ycf7OPBft?=
 =?us-ascii?Q?GTkn4UmAdhAuxBdED6kcHX2y0yIH4R71xup19PIdfyt+dRGd5HS4msbTL95T?=
 =?us-ascii?Q?oFOuYPehLh5fpj0PXRbpguQCzCHTkgBdnDOIiLUsHRI7WD46JmtVp5dsXwOB?=
 =?us-ascii?Q?jcBOC9f3cOVWUNjNtApYFN005mpBfjU1vh4IcB3hsU0HfA3h0rx0rrtWF5O5?=
 =?us-ascii?Q?sIpMWTYJ/BoN3mqDzlYJn6MFygFBflfdnO9Uz0xaaK6wT3lLXDC3bQ958YZp?=
 =?us-ascii?Q?u1OpTjkhVakdzGetEuIUAMP8UEokzs5zJAeuOdIFZdTyRnc40VS89Xz1lSGu?=
 =?us-ascii?Q?Mu9NwhCSg2OEfiGjbQAzw4bRj+mvhOLNPc1v5jHRbVuO5VFcpcRue6S7fsk7?=
 =?us-ascii?Q?ar1F47FuUmrSnl0rwYtWHLya7nC7sRcj0+4efIJmx884mVjf1LU80ua5/833?=
 =?us-ascii?Q?4mOAvslhw1RC+CH4dWIJ4sgEJG0700UimjuYLs7x8i3Aj5Nz2FUL2k2MygBV?=
 =?us-ascii?Q?FkkHyYs/tf5QLj4pZ6LeBbjLUXhuippDxb+yUmPmAOfuljX9VCSc/iBZ4tce?=
 =?us-ascii?Q?Tfn1amM3l0Ih8+Z9GKKxh/jzspUe2uKc0hLo2ThOqeANG0OxA+tWU+TMz9eU?=
 =?us-ascii?Q?4wCYBj/BQjFkjdkNCxtGtZ0AbvR6TI9tt0qZeSFn1KtUHlsCPR4AJUJftnli?=
 =?us-ascii?Q?6tG3Sw0kEFBSZY7E02qNP16BGk7VEaTpmq6mO7W540ZxEKfKBjKpU6ee8i9Q?=
 =?us-ascii?Q?3junGcJoyi9aCl7aY5JHHZgZ8Wle/iEnw/14U4+OD9Td1fQjJpQtqb1aTsqB?=
 =?us-ascii?Q?KmLaH4gLTMEzFESjLKWtguUX2bHcJGuS/2stAensY1827qR0LnuSQPVAgbA8?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2025b9-6354-4bc4-4409-08de16ab9667
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 05:25:35.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJVI1qVbyKGBo2Mwpu3W//fsq3HrchjxU5nsR/YowMZqsBkp4oscOr8nAkBmnAV6+Xv+jO8eyKeVvaLx5Jxmww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
commit: dede36400714b34bdaf79be2c84f540f07102554 dt-bindings: net: Add network-class schema for mac-address properties
date:   6 months ago
:::::: branch date: 2 hours ago
:::::: commit date: 6 months ago
config: nios2-randconfig-2052-20251024 (https://download.01.org/0day-ci/archive/20251029/202510290401.r1CJJm05-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
dtschema version: 2025.9.dev12+gd6be03029
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510290401.r1CJJm05-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510290401.r1CJJm05-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   	from schema $id: http://devicetree.org/schemas/serial/8250.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/sysid@18001528: failed to match any schema with compatible: ['altr,sysid-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): reg-names:2: 'tx_csr' was expected
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): reg-names:3: 's1' was expected
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): reg-names: ['control_port', 'rx_csr', 'rx_desc', 'rx_resp', 'tx_csr', 'tx_desc'] is too long
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): compatible: ['altr,tse-msgdma-1.0', 'altr,tse-1.0'] is too long
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): Unevaluated properties are not allowed ('altr,enable-hash', 'altr,enable-sup-addr' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/clock@0: failed to match any schema with compatible: ['altr,pll-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/clock@1: failed to match any schema with compatible: ['altr,pll-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/timer@18001440: failed to match any schema with compatible: ['altr,timer-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/gpio@180014d0: failed to match any schema with compatible: ['altr,pio-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/gpio@180014c0: failed to match any schema with compatible: ['altr,pio-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/timer@880: failed to match any schema with compatible: ['altr,timer-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: leds (gpio-leds): 'fpga0', 'fpga1', 'fpga2', 'fpga3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


