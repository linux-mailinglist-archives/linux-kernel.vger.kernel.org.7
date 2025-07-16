Return-Path: <linux-kernel+bounces-733032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1437EB06F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20653A686A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8504428CF73;
	Wed, 16 Jul 2025 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vt9v2Eto"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278128C00D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651682; cv=fail; b=ec14t21MEpTq6Hmhb5RduKDlDTrZxdWgtnn9Iewss8V0jkTN81WSUHi8vbKiW3oMXxubG7KNTZymHupinnc4x3ECaMfkowLymBCJTOBDip6qs5deUSrEQWg2yg9GN7w4USlTac6ldr3uCoI4n+HLx8Urb9HYU3FauAj4tB1aE3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651682; c=relaxed/simple;
	bh=Lqco0LBCJJ9MXUZzwhf3rQIXeODPxKS2iLmKFgO2LkY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P3U/kmwNOBFS0fpcitGu6gHl6v9EtUvDkI9t6Z7tj8Q0JSI9QaWtyyczucMFsETga6Av9kvSgdRwZVPo+5oLFp4kPj3eHV3Dw/4gjMI8twZXuhEwOKxeFTInmuARTT+4cx5ZRhQwQ9MN2klAKLehRNwpJAhqiO1HqpEAwr8PDt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vt9v2Eto; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752651681; x=1784187681;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Lqco0LBCJJ9MXUZzwhf3rQIXeODPxKS2iLmKFgO2LkY=;
  b=Vt9v2EtooFRhAU5oiH7feXjBty/Mxyr7apWz9e6K4+JNxkHQa2JxmtA7
   rdPcV3BO0d6HvMSTXV14bQxq10xSyEI5RFMb5Dp0qyC8jsjU8gK21D7QZ
   apBkqW2S+iizNGpRMU5TYZ3muBa2acvl8lb3/VQYm1iB5zrVUEaeghHnV
   JGU49drHtp5uGww8ZAFzgVunsSb7EMctKG+ngmF+rk4kEPlxhDvIOR2K2
   0DqD6F5HbDJtISBbavctkPF5dzEgzBiZPEEwWZXAXvQbzwW2tINVl9t8+
   dvgNisQsc2glGtT9ah0PVjv2IPcw/Oi89Eua3Kw/olqft393GFn+bElXt
   A==;
X-CSE-ConnectionGUID: b6HAfrSzS5ypsAexg5M0CQ==
X-CSE-MsgGUID: 55KW0L3VSU+QDKYhXygtYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58701373"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58701373"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:40:58 -0700
X-CSE-ConnectionGUID: EOqc6jMdRhCd9X70EeSgXw==
X-CSE-MsgGUID: XEu/9Ff+T/+prYkLiNI9Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="158156595"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:40:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 00:40:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 00:40:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.73)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 00:40:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vao7JQo6mC3j0wAbKsFjgxKIcFv+0o8s+8SpmuOLic0xS5lgSKqW1sZQoXG0YRY44KTsEM9pisBB6UYvExkEcOzTy/4otyyG+jro0LmZy3eL3IxCfPuPSmwGMwY8KaVVr086UUrHw/FV9ZRdLhm2aNNb+TpC4d0koaKCfKhlGJYKh+am1Vv2NFUZBFTrVJ+cL6Q9/kBJoRjMNf4Sx2iqgDWCq5o5BQiniL0U11M7w8CjPaBkOTb1mdQEoCxFiRECmT2gTY37UtbCIzUpwT8F1vGFb2sowA+xSIXL6J/l8MeyFUK+VcOtb02EFV9CYWxijYe2dnsN9kGRS9nR2WO2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWhR9YeKjKEo23Nov5cRXujRxjONQnhhVpuM8284o+I=;
 b=ADmQ2F5Sok7DXu8QJvYEgbPwH8xEMT6tq6lOrWbmtyltHVTxkXqsGzNcOCwZQPTAWMf58L4fBJfuH6DHvDtKNm6H8u0cGGl1b051QL9X6WdAr/e76gE671004sh3if3NDngJ+KcoYiNZbFROybIuK57Gue2dS507eg3Gq5dfz1DLuy1YhaMUQkYbbWDwGQf0rIZIFeQHX/8rNtI+E0bizxUQJw4SVfepImFACmgR/v5z/KKaY/tF0O8naPUozfxn7l6o9G/SIdJCxyqT/pe7RHQRilzUmsRm87D1j0Kezm1axUdPVT1WW4UdZDyR6lfucWlvFLkxEBAURWOViiUSCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:40:43 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%3]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:40:43 +0000
Date: Wed, 16 Jul 2025 15:40:26 +0800
From: Philip Li <philip.li@intel.com>
To: Aaron Lu <ziqianlu@bytedance.com>
CC: kernel test robot <lkp@intel.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, "Chengming
 Zhou" <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Xi Wang
	<xii@google.com>, <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>, Chuyi Zhou <zhouchuyi@bytedance.com>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <aHdXam/+MRQp+MEf@rli9-mobl>
References: <20250715071658.267-4-ziqianlu@bytedance.com>
 <202507160730.0cXkgs0S-lkp@intel.com>
 <20250716065707.GA32@bytedance>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250716065707.GA32@bytedance>
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|CO1PR11MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b25393-28dc-4012-d264-08ddc43c11db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IpvsPnltrQT8ibe6TRWZlxsKDKPBrEsmMk7xVJ1lowdFzySw7zwndd5V57VJ?=
 =?us-ascii?Q?1vS0PLNAKqtvU5ktrQxHoIvrF1t4o+xlU8TqA3va94bEDbwOoA3nGf3E4tkr?=
 =?us-ascii?Q?jjLwmPPd8ZfTFDuBLeoI8vimQCzu+ZouXBkv6kFNSDQRaxXM6QRdpzrfGw5i?=
 =?us-ascii?Q?m6cUCFNPH7lP2GTcFYYumo9F/d4JmIiHpleDdhuR0OaxfcntAY5ZuwxkgtUF?=
 =?us-ascii?Q?CXpG5tdBwJ5ceRnUvSV0vqBVrKpBjCoqRgcf0f6QGgfByW7JjtQf/gcrkVlR?=
 =?us-ascii?Q?3e6I7QCs0U/3cXz2dtrpbRwQBZMK/F+eZjF9GtH/b4WYuVfAVShe4owLV7Tt?=
 =?us-ascii?Q?4tpZYr64pDSyeQIfChImT/nvzHbuenJ2e8TvasZpxcG3GsojCVG2OIc0oOTF?=
 =?us-ascii?Q?FM6cRXdM4vPpOvjXY/z0b0Jev8PTdxqT0Q28MZ7MrFa4hvJ5dgYnDN5NOE18?=
 =?us-ascii?Q?86JOe66MixsOwel857/LnVCtPCmdoYMCe+7hZ6hPI/dJFlqSmFluZLkOVEDK?=
 =?us-ascii?Q?BWmHSzKWgDBe056I9d4tGAW+Razu1alCWZTwmmgMCG7x6ngkdHtlpahrqZjD?=
 =?us-ascii?Q?gIcUZJzAfgYfsMNqreSg3DLrm64TgSSOxtp0WnJShFhfjChTWVo2z5AHalu/?=
 =?us-ascii?Q?4rStDtn3U+dSjGFa/Uk2q5hsay8XjRrpSGJEE6bfmiVoep4egC1aemgIht5w?=
 =?us-ascii?Q?Rf14yTxPG8JP2x1cO/wLkFt9NlEm/BBH3e6aCyc23sTCTJyZBK5lEU+18Zp6?=
 =?us-ascii?Q?N2qgZGJiY1wPN0f98kyiv1CFrQBeqQl0FyK4/THzKa0klLE/1wZ5od7BNIPo?=
 =?us-ascii?Q?RsWOhRQnq5ViuMYQ1lQ5B8eXMXwKnLj4hDp8hYlC5eQb+hXv4WjKzTKciY+V?=
 =?us-ascii?Q?+Hz8OeFzajvtI74iwSYfTKDqva6EYuo9uof5pWqmWKuJSNsPY3E2La1PhkTx?=
 =?us-ascii?Q?s3mSpFSUi2F5MCk8sACwy9i6AKF4SNKfcz1sfO+XHjmyCD365OIVqUhq1+NZ?=
 =?us-ascii?Q?6uQORhaCX5hfYyLL5j8VxpVutrhUcXF+JVxMQv4aASL1zbocDL51HTNfS5Pq?=
 =?us-ascii?Q?x4bGYm/lb4hmtTMVpPhEgnqdG38CIG1y/oqcNi4v30XolG25uXOWyc1FB3cl?=
 =?us-ascii?Q?Q7h3pC3GqFD77lFq9Kj+RTqWTwG4Oi8DfIH/rFmIlMPuHir2PU4r6Nm0JA48?=
 =?us-ascii?Q?GNQwu8JiJq4cn6BsZNPeH1kyVyQj9ordJ3XCKJpaTLr6308FZTmA/aAxaOIv?=
 =?us-ascii?Q?huk7jCFtBceyVTS88S9RG/jb/Rh/4mQfmvkjVPUhnotdSyx7VMQDqnrIYWC4?=
 =?us-ascii?Q?tKXf9Jf4b1LeBimnrtPcQbXFg2bAKzd8i6WnWdQKHEIu0pHwWoaKYZa0KYmk?=
 =?us-ascii?Q?+NI+j4JuVsghXAU3PpA0lEg774Yt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F/lHOEfUokN8Ut74lH72+HxMTfGZgfNgmbijdG/xn8z6OfsDcOZ6viYULwnv?=
 =?us-ascii?Q?z6pAFrP1hwTbugqm36b/d0MOdrVpiaY9UZ7ElVKhISUz0rFzsJvw6rBb8ijy?=
 =?us-ascii?Q?T68iwG6mF0tRGiQXRubOqzfXRXMfBQV/gk1oLPiGxtpbLXfh3CBZdQQjwdtI?=
 =?us-ascii?Q?zoUEmWLAGvfoO6EiPlONFo/FYU1qFyL06NkDO4X1xbfMQPTXq5tD2luqohGE?=
 =?us-ascii?Q?s8df1Ku9Pj5PhvJTVzE1NvO2TqmRexd3t1t7Ogp4gi22g+6eBhAyONEZISbE?=
 =?us-ascii?Q?sRJhYYUHFcA7CS2oem1Wp6tuEqKDMmFzsBz8GgD4Do9vtmzRQ6Ejv5uiVW3J?=
 =?us-ascii?Q?W29rtL1xkchvcR9rdahqU36duV+h7ZnSEkjNgONDMvjd7mgDpwm8Gl3Hws6r?=
 =?us-ascii?Q?34cLOFS6UrBt1D0I9i/K19xTkaSi2rg5ABj6KdqMCAr5vYaJHBAc5Nf/u49O?=
 =?us-ascii?Q?nPyzZUCEhw/FoI2osPZVlKBYD2bhvtFIB397K+3Jv0ZEQgp5RH5izGqn8XQn?=
 =?us-ascii?Q?bj/nWlN+Nrn/1Hrz/6uAFjy7n3H0j8weXSlf6jmAj7XN4FVaNjuBeg7srQwn?=
 =?us-ascii?Q?opS2+/HS9anfF6vzCSn+ugvw5o7Jz3hz+EknBdUyysrd8XLU8+VxVcVR8ljf?=
 =?us-ascii?Q?mlILHFDKbsMUbZXEbdMielxkOaVLvvvObqgorhexKBhsktO2wdUtb8lnynEt?=
 =?us-ascii?Q?nMKQas0AHX+e8qWRPl8ZJ9v6VFDxCON0ZfmHs76N2ZKxGPDs/9jdsrsqsaMn?=
 =?us-ascii?Q?zhzUHgqJ7oI9vKepeRXtBkzGc2oIEubU+ndL66khh9oxWB4ihw6eTh/575Ob?=
 =?us-ascii?Q?oYI9Mk28AQV+NXUjsF8fYqFY7h5eK219iOiff0d59Eg50XRWvw2l8hCyRmHv?=
 =?us-ascii?Q?r8weaa8+p1ogg8+v+TwZvg4I7FRoShMeQa4Gs6621p1wPxR34mI/gBujfk7Q?=
 =?us-ascii?Q?Xv7SgqKFKR/C9PbRWYTZCyvB34dNDsIV6lMq0GIO/P+VgpE/+FNsqMbtUTUN?=
 =?us-ascii?Q?O+dJ10cUKYxA11ZiVwDpiVhlSSfxpphygIW7vnhLjFHPsaWDtfXpjYbuHoCC?=
 =?us-ascii?Q?5H5SVNxIeou2GBWriHUNDAdQvjH+509qBRWIMlJWYCWjuH4pdgFeCIyxWXyp?=
 =?us-ascii?Q?8N6GbfFOFPFJ77jRQ7oldIam0a42cM/DfiNoH1ZxtXHKtj6F6avuxFZI0Pkp?=
 =?us-ascii?Q?2YjQ7nx+pw9KdoyMdj6t2Lz+GwiFBk+aVJO6PRm5cTrkuQi2wflxlr4iDB65?=
 =?us-ascii?Q?2ZNcnkxQx+ah7L158BbTwKQfymMOTWj1O0hg086AAp54jvWCJpuq9e5TZ31y?=
 =?us-ascii?Q?wA0feavy3He3HeIx6Y58jHl5DjE8pNE4n96IIIuluV250AmRF7sMR4TBASDP?=
 =?us-ascii?Q?Q7dGZ4nYYW0b7HUl5Du+Rpo99QOix41FHioaTdNDzY9VaILNnU70W1j+VGGu?=
 =?us-ascii?Q?BNRji3NcUAOgmDSG5J/ovN3Pk3pKRRzuL9Tpw/TJUfSgF6W26mD2WdZ10GBB?=
 =?us-ascii?Q?ZMxN4UQegRQSQFrIVWsL3fPRSFJe3f61co7k3SN9dOYRpEIZUqDRD718gCg/?=
 =?us-ascii?Q?tir6YewOQMOJF0X+BWJ8tSv25rjVm1gaeKJI4pvA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b25393-28dc-4012-d264-08ddc43c11db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:40:43.7652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YBDI8dSAvVNrsKd7dNFfD351KkZBnMW5VgAWq+GTv+uPBoJ2BxlNswcXZbqDueI7IR7TlCfw7EitktwYoLvZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com

On Wed, Jul 16, 2025 at 02:57:07PM +0800, Aaron Lu wrote:
> On Wed, Jul 16, 2025 at 07:29:37AM +0800, kernel test robot wrote:
> > Hi Aaron,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on tip/sched/core]
> > [also build test WARNING on next-20250715]
> > [cannot apply to linus/master v6.16-rc6]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Lu/sched-fair-Add-related-data-structure-for-task-based-throttle/20250715-152307
> > base:   tip/sched/core
> > patch link:    https://lore.kernel.org/r/20250715071658.267-4-ziqianlu%40bytedance.com
> > patch subject: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
> > config: i386-buildonly-randconfig-006-20250716 (https://download.01.org/0day-ci/archive/20250716/202507160730.0cXkgs0S-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160730.0cXkgs0S-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202507160730.0cXkgs0S-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> kernel/sched/fair.c:5456:33: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
> >     5456 |                         cfs_rq->pelt_clock_throttled = 1;
> >          |                                                      ^ ~
> 
> Thanks for the report.
> 
> I don't think this will affect correctness since both cfs_rq's throttled
> and pelt_clock_throttled fields are used as true(not 0) or false(0). I
> used bitfield for them to save some space.
> 
> Change their types to either unsigned int or bool should cure this
> warning, I suppose bool looks more clear?
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index dbe52e18b93a0..434f816a56701 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -737,8 +737,8 @@ struct cfs_rq {
>  	u64			throttled_clock_pelt_time;
>  	u64			throttled_clock_self;
>  	u64			throttled_clock_self_time;
> -	int			throttled:1;
> -	int			pelt_clock_throttled:1;
> +	bool			throttled:1;
> +	bool			pelt_clock_throttled:1;
>  	int			throttle_count;
>  	struct list_head	throttled_list;
>  	struct list_head	throttled_csd_list;
> 
> Hi LKP,
> 
> I tried using clang-19 but couldn't reproduce this warning and I don't
> have clang-20 at hand. Can you please apply the above hunk on top of
> this series and see if that warning is gone? Thanks.

Got it, is it possible to give a try for the reproduce step [1], which can
download clang-20 to local dir? If it has issue, we will follow up to check
as early as possible.

[1] https://download.01.org/0day-ci/archive/20250716/202507160730.0cXkgs0S-lkp@intel.com/reproduce

> 
> Best regards,
> Aaron
> 
> >    kernel/sched/fair.c:5971:32: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
> >     5971 |                 cfs_rq->pelt_clock_throttled = 1;
> >          |                                              ^ ~
> >    kernel/sched/fair.c:6014:20: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
> >     6014 |         cfs_rq->throttled = 1;
> >          |                           ^ ~
> >    3 warnings generated.
> > 
> > 
> > vim +/int +5456 kernel/sched/fair.c
> > 
> >   5372	
> >   5373	static bool
> >   5374	dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >   5375	{
> >   5376		bool sleep = flags & DEQUEUE_SLEEP;
> >   5377		int action = UPDATE_TG;
> >   5378	
> >   5379		update_curr(cfs_rq);
> >   5380		clear_buddies(cfs_rq, se);
> >   5381	
> >   5382		if (flags & DEQUEUE_DELAYED) {
> >   5383			WARN_ON_ONCE(!se->sched_delayed);
> >   5384		} else {
> >   5385			bool delay = sleep;
> >   5386			/*
> >   5387			 * DELAY_DEQUEUE relies on spurious wakeups, special task
> >   5388			 * states must not suffer spurious wakeups, excempt them.
> >   5389			 */
> >   5390			if (flags & DEQUEUE_SPECIAL)
> >   5391				delay = false;
> >   5392	
> >   5393			WARN_ON_ONCE(delay && se->sched_delayed);
> >   5394	
> >   5395			if (sched_feat(DELAY_DEQUEUE) && delay &&
> >   5396			    !entity_eligible(cfs_rq, se)) {
> >   5397				update_load_avg(cfs_rq, se, 0);
> >   5398				set_delayed(se);
> >   5399				return false;
> >   5400			}
> >   5401		}
> >   5402	
> >   5403		if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
> >   5404			action |= DO_DETACH;
> >   5405	
> >   5406		/*
> >   5407		 * When dequeuing a sched_entity, we must:
> >   5408		 *   - Update loads to have both entity and cfs_rq synced with now.
> >   5409		 *   - For group_entity, update its runnable_weight to reflect the new
> >   5410		 *     h_nr_runnable of its group cfs_rq.
> >   5411		 *   - Subtract its previous weight from cfs_rq->load.weight.
> >   5412		 *   - For group entity, update its weight to reflect the new share
> >   5413		 *     of its group cfs_rq.
> >   5414		 */
> >   5415		update_load_avg(cfs_rq, se, action);
> >   5416		se_update_runnable(se);
> >   5417	
> >   5418		update_stats_dequeue_fair(cfs_rq, se, flags);
> >   5419	
> >   5420		update_entity_lag(cfs_rq, se);
> >   5421		if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
> >   5422			se->deadline -= se->vruntime;
> >   5423			se->rel_deadline = 1;
> >   5424		}
> >   5425	
> >   5426		if (se != cfs_rq->curr)
> >   5427			__dequeue_entity(cfs_rq, se);
> >   5428		se->on_rq = 0;
> >   5429		account_entity_dequeue(cfs_rq, se);
> >   5430	
> >   5431		/* return excess runtime on last dequeue */
> >   5432		return_cfs_rq_runtime(cfs_rq);
> >   5433	
> >   5434		update_cfs_group(se);
> >   5435	
> >   5436		/*
> >   5437		 * Now advance min_vruntime if @se was the entity holding it back,
> >   5438		 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
> >   5439		 * put back on, and if we advance min_vruntime, we'll be placed back
> >   5440		 * further than we started -- i.e. we'll be penalized.
> >   5441		 */
> >   5442		if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
> >   5443			update_min_vruntime(cfs_rq);
> >   5444	
> >   5445		if (flags & DEQUEUE_DELAYED)
> >   5446			finish_delayed_dequeue_entity(se);
> >   5447	
> >   5448		if (cfs_rq->nr_queued == 0) {
> >   5449			update_idle_cfs_rq_clock_pelt(cfs_rq);
> >   5450	#ifdef CONFIG_CFS_BANDWIDTH
> >   5451			if (throttled_hierarchy(cfs_rq)) {
> >   5452				struct rq *rq = rq_of(cfs_rq);
> >   5453	
> >   5454				list_del_leaf_cfs_rq(cfs_rq);
> >   5455				cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> > > 5456				cfs_rq->pelt_clock_throttled = 1;
> >   5457			}
> >   5458	#endif
> >   5459		}
> >   5460	
> >   5461		return true;
> >   5462	}
> >   5463	
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 

