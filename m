Return-Path: <linux-kernel+bounces-770090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2964B27699
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045197AE442
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8B32BE02D;
	Fri, 15 Aug 2025 03:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXnlSkxm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3ED29A9C3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227666; cv=fail; b=cH0aA4/v6X76tbo1yZwFJ2gcagxDUSGh6DoAOuNjxRe5Pv4LctHQ1zcIii5yYTzZn8/tL2nXp+LLrd9F7Jesqfd7j0z5wuuakEljRFDb7HJwnmu8ghz69dZtWLMqe2PLXin3rp8xcDx2wB6k51IHjOvnex8JNZYd6HU1EMDxetM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227666; c=relaxed/simple;
	bh=glnKs454FA+hE47JlFSenhs4fbqLrPHcc0mMAc2Mi1U=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UCvZfZLIaNLnSkjllzB5TUPoZzyYzbOsDDNzzfKXoTt19ZL4FyH+GBZQBvQnVfou5cCDbYkzVtCEgm/p3JmbFkdivmv+pdUBPdnHGXOmWWCODibPsCg76aeLNSfZe9CNC6+BpQ3uKj3dTt8C9CTURuhJ+2sHjNCXTjF/8nQ9TMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXnlSkxm; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755227663; x=1786763663;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=glnKs454FA+hE47JlFSenhs4fbqLrPHcc0mMAc2Mi1U=;
  b=SXnlSkxmemlIadKxkVndb6qacpHnzudZ5AEzwdhXDqlmJYmRgNX72IIU
   KfQZw4LZStZXzzDmbbawP1UBTdxxRrekzWDj+eYMgQsegheJSC9/aa+fu
   JJc2ElvmnInm0lx/PeFRwxXQldbM0b8ycgm+DJfPVirJ9b+4oSFLhsllG
   92HOHmoJ1DWk0EMWKciV5hGl6T0kn/X24GfdCtts38q8bPd1iwPQzKu6d
   lqglMLm60t8eB8LRo8t76wS+mqSKXpSlI7vdOIT2++LITuD2XfyBJ3EuZ
   HDpM62egvfLUUzOwcZGNA8I+wnf3gn3ENhOo5Lj1ki6N0uhJvjXIkC1gH
   Q==;
X-CSE-ConnectionGUID: K6hX4oLZSSuFaNMhzI2jAg==
X-CSE-MsgGUID: CwSpkuWSScOzLrSBfIkMUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="56763312"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="56763312"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:14:22 -0700
X-CSE-ConnectionGUID: zBVKPgOmSOmo/vw/+jeLhw==
X-CSE-MsgGUID: tOC3VVz6TBGn6QGgxGKuGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167177636"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:14:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 20:14:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 20:14:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.66)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 20:14:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emur08V1BsGmsenr8V+oSJKVp9eWy6ofGP/bKMLho7c5ccok1Z3M6c9Ef7+OyfTNXe5TvevGKMC2uKjIEKeSMNSFC1PAOuaN6B8RPi3F4O2MVOVvp2budt1fOv/2dcJoBKuHKhxmlpa7g5zRsPmUugJ61suoVMnzKR74BpcSQ7xD/2HIG9B6V7wQSGWfnKoyEjdoJVTgWAc7KOm3rhStHqH+PIyq9wbYEKI4UOmZaLutiC8Uji80ynV0IeD+K+KNwxNqLpOlFsAs/Q2KaNnz6G9zG2AinP2Raj8U7oLW+UZXlIG4G9UJbLyVzBEgU4IqVm/AP8Win2t2MJNT2Ura0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DmQonujY2lrGgq3zoqjFhaKGdqotTB/cZ+WGOKEANo=;
 b=UpLP+0JA4t/iNukhiUOE/9uDZA0glkHYFKtyalwVFaxNjoupHygRvFCqEtUj9Hcvsy4DjO4qJmmVpNd58iYIXjCDrTnq+nuZT0hIt5+riBLf0WN9/DprAa2fDYewJ+9XqMeg1ESh0zKIQHYXWGHA4e8YxCGC9/IQIAipHav6yg8oOTysyh/e5YVzy0XY5hWWu3s1rtcfdnxQ+7fgBo/LE4+4PUHt2PqbcDlUsXRWRqq0WAR3xxcYswC3qc0Sd2ggQxL1o8dQSVBcvJFH5ciSGnXgObbmgZPfd+hf90bC4NYQr+8PuGdFCKA6b14Wz6oIJ5V1ROg6Xl+jUtggt/fw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN6PR11MB8170.namprd11.prod.outlook.com (2603:10b6:208:47c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 03:14:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 03:14:19 +0000
Date: Fri, 15 Aug 2025 11:14:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chris Mason <clm@fb.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
	<vincent.guittot@linaro.org>, <pan.deng@intel.com>, <yu.ma@intel.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/fair]  155213a2ae:  unixbench.throughput 23.2%
 regression
Message-ID: <202508150416.d7153a48-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN6PR11MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f44d657-0c13-402b-bf52-08dddba9d290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?fyRNI68+5K2Oy3VX0nmKUWzvC6oENxlX8NDNUCCa04ITCbRhDSHATxFVUF?=
 =?iso-8859-1?Q?gPfOWdr9ltCUQQOfV2Q+CYXqcKE0dN+KwocJv3/sBQUs1W405P3c4n2KEz?=
 =?iso-8859-1?Q?LySOr/oWXpsZsXC6wPe7usqX14kvxKQyAyr8lNg4reIthgMCWaltGK+e6v?=
 =?iso-8859-1?Q?ZdJSI4XTboT3rNJe7IDm1tTy423BJhPER9VEUq2CtvoHzoskfR8iDUMBZH?=
 =?iso-8859-1?Q?5W6VqvwN2Jtxp6igpLBgkESp5M1NUQRA86VU8t4Ho7nK7mGploa6yMlbY3?=
 =?iso-8859-1?Q?W+/ksYYIoLKop+n5ys9LK4EBjy1vbb7FSWCtA5YVxlAv5ws9xwbJw6F6Qz?=
 =?iso-8859-1?Q?s9/El5tK+AGXuj5Tq6IdE/hI93Cx4tpV6QBmTxgM/pCizfZ+Xq67Q/GaPz?=
 =?iso-8859-1?Q?gseP28BIGQTgaDR9vpsE46UuUDGeiklbOBYQKyPRNaHUn0/F5q9oCFzrxu?=
 =?iso-8859-1?Q?OzJvfhTij+ZvYxRuhz5lxRuKkEd0Sg8Bvbngz/LZHKah83jL3reiB91Z19?=
 =?iso-8859-1?Q?UBCc9RNgq1pxBa0anKFWCcLsi6juRtk11GDkXqRLV9vgpkTk9jaOWZBHps?=
 =?iso-8859-1?Q?3jfyjAlV4ilLC4iMqxTLAOslvhNCfA3mVXH8XYdvC8EvrDqVP0QyTaHyF4?=
 =?iso-8859-1?Q?IzyBbEQ58YDK6pLQ6GplZgVMbTKo8hFkjOGaNP6c2U6xsfWrxgxP1OGgLx?=
 =?iso-8859-1?Q?wPtHnAXr42LRf6h7bv5wW3p2nc80GOu37+g3x/hNtm634oSazQgGB1nIXA?=
 =?iso-8859-1?Q?W8BjUL6SYESNduftsp+U4AI0rOElPY5EzwbLkMF6q6DVmrNGbBR4SPYCT4?=
 =?iso-8859-1?Q?5lqWXXEMyUJt2utWnCUbyHZavN4ncoosnz28HmttFQIxjuHIuGHQwFShs8?=
 =?iso-8859-1?Q?Er/1oF2Qo2Vu1AI1KMRLam/wE2SfWHE9ImWNZK3A9krB61NiqX4oVJG1zo?=
 =?iso-8859-1?Q?TpDA2hn7ujtakleVfAhgxOrpS64PMea8UF+6gup0l2vKuZZcQ/HV3cPGP4?=
 =?iso-8859-1?Q?BUG+nIiMZARQqFUbOaGA4du48g2INzA3lK4dkZSKwSL4Olaor3+2/Mz5TG?=
 =?iso-8859-1?Q?wf36EZdB0C7C4SaaAbUYiZw0k+tpemOgXOkd5m6nJ17JiEYAzV/fPirfqo?=
 =?iso-8859-1?Q?2pXEqGx/xnrX+TNntuUEeHK4ybhQGfJ4DWzG1g8zhLs2jnLAkbWYBxDKHl?=
 =?iso-8859-1?Q?SSEkBBYiDfqiijlPKJPXkKdIn3D4osGL8y49S5A4nSp4xeFTmHbHTD+WC8?=
 =?iso-8859-1?Q?ELflU/gmUKlca4sfmehOpOglwo4aTbJQ72lEh8aBRD5pgT/HPHxySZUoES?=
 =?iso-8859-1?Q?r5JioNFAwMQR3NInNdmr5prvN3XGQmf87FrnBzWtwI4NWlC//DJxmTXk9i?=
 =?iso-8859-1?Q?cCa0tCbQfGzO5GeMsPzoumyz8jpgnRAe78e/oVLZJQgrXDBNEaWmZKPyXN?=
 =?iso-8859-1?Q?4DRhKnO73azka3cw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SWmK/2860FZlhb82SCkxjk6UVW7mghnm4i/6L2mzPVBBO/o//2FYho0qkz?=
 =?iso-8859-1?Q?X51uZka2HNXiunno3mwWxU/5o+jktHVOVdglT5JTCHABzxl4uYoHVvxu4A?=
 =?iso-8859-1?Q?Xut5uHEPG0v/6UUz1OfqMi3E3CAdnjIMENh4czdtQFU/0R6pWYOHuOtyOa?=
 =?iso-8859-1?Q?bZgqw/VW6tRCBO3bnqpjkfl+U9HeUJ/mEe0zTrRDgofuvgcTg3+ptuGQtK?=
 =?iso-8859-1?Q?9vq7RSBgpht9JhRm+4Z+hdASr/wjfRr/0P0b7ycS2CF79LI/t+56ihVY1n?=
 =?iso-8859-1?Q?dkKp7P3le28pNbUUbPk+xzRmjRl1uKKZfNYea6OVn++vBNspwpPGDEHyUz?=
 =?iso-8859-1?Q?okyR+0jJi8EXgmsCj8NDYUmq9bpLwmiQHNxht9IHQIh4demTdK3grrDVqh?=
 =?iso-8859-1?Q?AdX5qOtbr5Qmtb0ZCICaWvQWDzWGlxx5WTyCroyEzu5yVUZxLpUiNaC6ZB?=
 =?iso-8859-1?Q?YXBO402fDOWNuSQMXKHjy6ATIMS2N94nu1OmHik4U68Ap8yqmkQn4n1JgV?=
 =?iso-8859-1?Q?KsPEfZkzZlSulLe/N/VsUkMlz/eXo7ymLDUZ1Q0+LN3pmYjhSL6WPJuZ0/?=
 =?iso-8859-1?Q?OvEYL1QkvzNwMlzz/5O1XfJg2F4tjIK26s0m18BXp+jjnV3Jss8LgAa/eJ?=
 =?iso-8859-1?Q?5wQhLDdC7TrEzQNIPG1bpNNm7QGDZq7BSdtjWkFRpapqCxy13M+yUKCfc9?=
 =?iso-8859-1?Q?F6HERkrms7rp+DEgTWqtRvKE0iKatBNtXE51ZlpY4Lm0YaGCW/RKrJxmXa?=
 =?iso-8859-1?Q?vDSDIUJ1gnSQ4OCbD8/o8GNzeeWEXEpwDOeRdW4oYb5+4Ek82+uQwFItNt?=
 =?iso-8859-1?Q?5qSfsQPsiM+tp/DIZ9NUpigAkk2gkDOf2CB+WQqCxnafJMfq5yANpUenAo?=
 =?iso-8859-1?Q?BZzDEpNhrdpsWRhkvfzNXC0iCzNgYBDRYM2KDlClW1SMprEoooVYGopXHm?=
 =?iso-8859-1?Q?d4SBYq+oms8+ba0VsbAk4SOd7Aax6ruxubqetMeYuLtCrlFsR6RR0uQbag?=
 =?iso-8859-1?Q?CnaLLv6gA4IiOQ1uOYO0w79phUsV1eFVwCc5OWCZPo2EnHUUyjT6devfVl?=
 =?iso-8859-1?Q?2G69JajApSqBKHp8Mf0/TASCvF2gNomVtyqEbquUcmok57+DhxIigly5EM?=
 =?iso-8859-1?Q?WLrB+89+WAB4JY29eSXLDuwBZJ67aOgeCNYRwz1oknARtHQKUewaQNhQSJ?=
 =?iso-8859-1?Q?DAIEs/Wh2BFW1zssvnoX81PRjXObkpXflSrbWKSq2JyRx1tV88X5BEufLQ?=
 =?iso-8859-1?Q?AkhfUwo9ZPBUqhXkOSo0R2xfoY6Id0pBCjFZ23SoDWEyO3PaehgtnDHrzC?=
 =?iso-8859-1?Q?ASvDFICnrZ0B2Rr3DFITzsp8TsACG86y/A3O0HTqGLS1p5w9Fs4CzDrQ/K?=
 =?iso-8859-1?Q?PTwq2oOCNYb53NL0vY13+GTl2p6Ss2Tq+Qyr/Iu1aloDRmIHZmW4YCa2vy?=
 =?iso-8859-1?Q?LmcSi6UaHkvTyL7HflpLG3lNStGbuG+tqj81i6vyQTJBAQlCw2nt3QL2P4?=
 =?iso-8859-1?Q?gi1LY287//YFN8YYUXpanC8ZNAZNj8P/1GnqweYcQNViFzTsmfIHXXTqmv?=
 =?iso-8859-1?Q?8XesN3GiBLKCtM2hPJKHzfJfjs3s51yZWwxZkUxkTRBa2VG0E/2GXJfkk8?=
 =?iso-8859-1?Q?wK9oDFcB0dqV2mwrogTLBWB6uoz6b3Qf5WbQXpyJRH3BEAMvsoz/hDkg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f44d657-0c13-402b-bf52-08dddba9d290
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:14:18.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfr+eLJHTETDx3u3hi9aYflutkSub4iKsytBb4g53RNIg95Rp3IMTKsR86qcSFSAmOwP4J9SQ6N9a3XV2Tyceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8170
X-OriginatorOrg: intel.com



Hello,


we reported a "22.9% regression of unixbench.throughput" for this patch in
https://lore.kernel.org/all/202507150846.538fc133-lkp@intel.com/
where there are some discussions.

later we also reported
"[tip:sched/core] [sched/fair]  155213a2ae:  unixbench.throughput 20.2% regression"
in
https://lore.kernel.org/all/202507281046.e71b853a-lkp@intel.com/


since now the commit is in mainline, we rebuild the kernel and rerun the tests,
still observed similar regression. below full report is just FYI.



kernel test robot noticed a 23.2% regression of unixbench.throughput on:


commit: 155213a2aed42c85361bf4f5c817f5cb68951c3b ("sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on      linus/master 91325f31afc1026de28665cf1a7b6e157fa4d39d]
[still regression on linux-next/master 43c3c17f0c805882d1b48818b1085747a68c80ec]

testcase: unixbench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	nr_task: 100%
	test: shell1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput  20.2% regression                                              |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory      |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | nr_task=100%                                                                                   |
|                  | runtime=300s                                                                                   |
|                  | test=shell16                                                                                   |
+------------------+------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508150416.d7153a48-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250815/202508150416.d7153a48-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/shell1/unixbench

commit: 
  d398a68e8b ("# gpg: Signature made Wed 25 Jun 2025 12:55:36 AM CEST")
  155213a2ae ("sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails")

d398a68e8bcf430e 155213a2aed42c85361bf4f5c81 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     18057           +38.4%      24994        uptime.idle
 1.618e+10           +42.2%  2.301e+10        cpuidle..time
 2.174e+08           -24.2%  1.648e+08        cpuidle..usage
 5.362e+08           -22.9%  4.136e+08        numa-numastat.node0.local_node
 5.362e+08           -22.9%  4.137e+08        numa-numastat.node0.numa_hit
 5.346e+08           -23.1%  4.113e+08        numa-numastat.node1.local_node
 5.347e+08           -23.1%  4.114e+08        numa-numastat.node1.numa_hit
 5.362e+08           -22.9%  4.137e+08        numa-vmstat.node0.numa_hit
 5.362e+08           -22.9%  4.136e+08        numa-vmstat.node0.numa_local
 5.347e+08           -23.1%  4.114e+08        numa-vmstat.node1.numa_hit
 5.346e+08           -23.1%  4.113e+08        numa-vmstat.node1.numa_local
     40.66           +41.3%      57.45        vmstat.cpu.id
     40.10           -19.5%      32.29 ±  2%  vmstat.procs.r
    659071           -34.1%     434251        vmstat.system.cs
    509482           -33.7%     337630        vmstat.system.in
   3295320           -12.2%    2891915        meminfo.Active
   3295320           -12.2%    2891915        meminfo.Active(anon)
   3783500           -11.0%    3369031        meminfo.Committed_AS
    125011            -9.9%     112614        meminfo.Mapped
   2553901           -15.9%    2146565        meminfo.Shmem
      4083           -22.9%       3149 ±  2%  perf-c2c.DRAM.local
     27367           -29.1%      19400        perf-c2c.DRAM.remote
     24271           -29.5%      17112        perf-c2c.HITM.local
     17788           -27.0%      12977        perf-c2c.HITM.remote
     42060           -28.5%      30090        perf-c2c.HITM.total
     40.49           +16.8       57.33        mpstat.cpu.all.idle%
      0.00 ± 13%      +0.0        0.01 ±  6%  mpstat.cpu.all.iowait%
      1.38            -0.5        0.88        mpstat.cpu.all.irq%
      0.64            -0.2        0.48        mpstat.cpu.all.soft%
     48.73           -13.4       35.36        mpstat.cpu.all.sys%
      8.75            -2.8        5.95        mpstat.cpu.all.usr%
     64.51           -26.3%      47.52        mpstat.max_utilization_pct
     35252           -23.2%      27071        unixbench.score
    149472           -23.2%     114781        unixbench.throughput
  11359361           -25.1%    8509062        unixbench.time.involuntary_context_switches
    492298           -28.5%     351938        unixbench.time.major_page_faults
 1.285e+09           -23.0%  9.899e+08        unixbench.time.minor_page_faults
      3523           -23.9%       2680        unixbench.time.percent_of_cpu_this_job_got
     16859           -23.6%      12872        unixbench.time.system_time
      5365           -24.7%       4040        unixbench.time.user_time
 2.002e+08           -34.2%  1.317e+08        unixbench.time.voluntary_context_switches
  94257381           -23.2%   72358496        unixbench.workload
    823902           -12.3%     722967        proc-vmstat.nr_active_anon
   1545851            -6.6%    1443980        proc-vmstat.nr_file_pages
     31631           -10.5%      28297        proc-vmstat.nr_mapped
     15394            -5.8%      14500        proc-vmstat.nr_page_table_pages
    638468           -16.0%     536631        proc-vmstat.nr_shmem
     27655            -2.3%      27018        proc-vmstat.nr_slab_reclaimable
    823902           -12.3%     722967        proc-vmstat.nr_zone_active_anon
 1.071e+09           -23.0%   8.25e+08        proc-vmstat.numa_hit
 1.071e+09           -23.0%   8.25e+08        proc-vmstat.numa_local
 1.099e+09           -23.0%  8.468e+08        proc-vmstat.pgalloc_normal
 1.288e+09           -22.9%  9.926e+08        proc-vmstat.pgfault
 1.098e+09           -23.0%  8.461e+08        proc-vmstat.pgfree
  62587550           -23.1%   48116202        proc-vmstat.pgreuse
     49428           -23.0%      38063        proc-vmstat.thp_fault_alloc
  20756795           -23.2%   15940575        proc-vmstat.unevictable_pgs_culled
      3.33           -13.5%       2.88        perf-stat.i.MPKI
 1.575e+10           -27.1%  1.149e+10        perf-stat.i.branch-instructions
      1.65            -0.1        1.51        perf-stat.i.branch-miss-rate%
 2.567e+08           -33.5%  1.707e+08        perf-stat.i.branch-misses
     21.18            +1.0       22.16        perf-stat.i.cache-miss-rate%
 2.579e+08           -37.2%   1.62e+08        perf-stat.i.cache-misses
 1.203e+09           -40.0%  7.221e+08        perf-stat.i.cache-references
    662148           -34.1%     436202        perf-stat.i.context-switches
  1.45e+11           -27.8%  1.046e+11        perf-stat.i.cpu-cycles
    166946           -50.9%      81925        perf-stat.i.cpu-migrations
    569.16           +14.2%     649.85        perf-stat.i.cycles-between-cache-misses
 7.641e+10           -27.1%  5.572e+10        perf-stat.i.instructions
    779.92           -28.5%     557.65        perf-stat.i.major-faults
     75.31           -25.5%      56.13        perf-stat.i.metric.K/sec
   1995873           -23.0%    1537771        perf-stat.i.minor-faults
   1996653           -23.0%    1538329        perf-stat.i.page-faults
  12355125           -24.1%    9382753        sched_debug.cfs_rq:/.avg_vruntime.avg
  13763415           -22.4%   10676462 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
  12078685           -24.3%    9142172        sched_debug.cfs_rq:/.avg_vruntime.min
      0.62           -19.6%       0.50 ±  7%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.61           -19.8%       0.49 ±  7%  sched_debug.cfs_rq:/.h_nr_runnable.avg
    230870 ± 24%     -60.4%      91496 ± 34%  sched_debug.cfs_rq:/.left_deadline.avg
   9174117 ± 24%     -45.0%    5050038 ± 33%  sched_debug.cfs_rq:/.left_deadline.max
   1397837 ± 23%     -52.4%     665070 ± 32%  sched_debug.cfs_rq:/.left_deadline.stddev
    230867 ± 24%     -60.4%      91494 ± 34%  sched_debug.cfs_rq:/.left_vruntime.avg
   9174016 ± 24%     -45.0%    5049965 ± 33%  sched_debug.cfs_rq:/.left_vruntime.max
   1397823 ± 23%     -52.4%     665061 ± 32%  sched_debug.cfs_rq:/.left_vruntime.stddev
     13.42 ±  4%     -23.3%      10.29 ±  4%  sched_debug.cfs_rq:/.load_avg.min
  12355125           -24.1%    9382753        sched_debug.cfs_rq:/.min_vruntime.avg
  13763416           -22.4%   10676462 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
  12078685           -24.3%    9142172        sched_debug.cfs_rq:/.min_vruntime.min
      0.57 ±  2%     -25.9%       0.42 ±  6%  sched_debug.cfs_rq:/.nr_queued.avg
     35.10 ±  9%     +48.0%      51.95 ± 16%  sched_debug.cfs_rq:/.removed.load_avg.avg
    154.61 ±  9%     +26.5%     195.60 ± 10%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      7.96 ± 16%     +55.5%      12.38 ± 15%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     35.79 ± 16%     +32.5%      47.44 ± 12%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      7.93 ± 16%     +53.9%      12.20 ± 15%  sched_debug.cfs_rq:/.removed.util_avg.avg
     35.64 ± 16%     +31.4%      46.84 ± 12%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    230867 ± 24%     -60.4%      91494 ± 34%  sched_debug.cfs_rq:/.right_vruntime.avg
   9174016 ± 24%     -45.0%    5049965 ± 33%  sched_debug.cfs_rq:/.right_vruntime.max
   1397823 ± 23%     -52.4%     665061 ± 32%  sched_debug.cfs_rq:/.right_vruntime.stddev
    656.25           -10.1%     589.70        sched_debug.cfs_rq:/.runnable_avg.avg
      1528 ±  3%     -11.9%       1346 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    304.20 ±  2%     -10.5%     272.17 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
    663.08            -9.5%     600.37        sched_debug.cfs_rq:/.util_avg.avg
      1534 ±  3%     -12.1%       1348 ±  3%  sched_debug.cfs_rq:/.util_avg.max
    303.16 ±  2%     -11.5%     268.16 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
     93.11 ±  4%     -18.3%      76.09 ±  9%  sched_debug.cfs_rq:/.util_est.avg
    146283           +80.6%     264237 ±  4%  sched_debug.cpu.avg_idle.avg
    281116 ± 10%    +111.9%     595723 ±  8%  sched_debug.cpu.avg_idle.max
     33495 ±  5%     +99.3%      66743 ±  8%  sched_debug.cpu.avg_idle.min
     50344 ±  6%    +111.7%     106556 ±  7%  sched_debug.cpu.avg_idle.stddev
   1048307 ±  5%     -27.6%     758769 ±  8%  sched_debug.cpu.curr->pid.avg
    500299          +182.8%    1414703        sched_debug.cpu.max_idle_balance_cost.avg
    511283          +191.8%    1492141        sched_debug.cpu.max_idle_balance_cost.max
    500000          +166.5%    1332328        sched_debug.cpu.max_idle_balance_cost.min
      1646 ± 58%   +2697.0%      46046 ±  3%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.62           -20.1%       0.50 ±  7%  sched_debug.cpu.nr_running.avg
   3098449           -33.8%    2051309        sched_debug.cpu.nr_switches.avg
   3177594           -34.5%    2080856        sched_debug.cpu.nr_switches.max
   2935200           -32.6%    1978359        sched_debug.cpu.nr_switches.min
     40518 ± 10%     -55.6%      18003 ± 17%  sched_debug.cpu.nr_switches.stddev
     14553 ± 31%     -75.7%       3530 ± 13%  sched_debug.cpu.nr_uninterruptible.max
    -27410           -85.3%      -4041        sched_debug.cpu.nr_uninterruptible.min
      7820 ± 22%     -77.6%       1752 ± 13%  sched_debug.cpu.nr_uninterruptible.stddev
      0.01 ± 17%    +121.7%       0.03 ± 34%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.alloc_anon_folio
      0.01 ± 12%     +57.8%       0.02 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.path_openat
      0.01 ± 12%     +78.0%       0.02 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.01 ± 30%    +123.7%       0.03 ± 51%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.create_elf_tables.load_elf_binary.exec_binprm
      0.01 ± 23%    +140.9%       0.03 ± 33%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.map_vdso.load_elf_binary.exec_binprm
      0.01 ± 20%     +91.9%       0.02 ± 24%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.exec_binprm
      0.01 ± 11%     +37.5%       0.02 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.01 ± 20%    +108.0%       0.03 ± 51%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.02 ± 24%     -48.6%       0.01 ± 32%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      0.01 ± 25%     +63.9%       0.02 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.01           +92.5%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.02 ±  6%     +21.0%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 12%    +128.7%       0.03 ± 18%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.02 ±  9%     +76.3%       0.03 ±  9%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.01 ± 12%     +43.6%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.03 ± 13%    +127.8%       0.08 ± 11%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.04 ± 10%    +115.9%       0.09 ±  9%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.01 ±  3%     +26.5%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.01           +45.5%       0.02        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.01 ±  5%     +35.7%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.01 ±  9%     +43.8%       0.02 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  4%     +26.1%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01           -12.5%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 29%     +81.2%       0.01 ± 26%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.13 ± 32%    +343.1%       0.56 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pud_alloc
      0.11 ± 57%    +145.9%       0.28 ± 42%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.map_vdso.load_elf_binary.exec_binprm
      0.14 ± 40%    +291.5%       0.55 ± 79%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.exec_binprm
      0.13 ± 42%    +103.1%       0.26 ± 37%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
      0.10 ± 35%    +304.9%       0.42 ± 95%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.48 ± 51%     -71.1%       0.14 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      0.09 ± 41%     +95.2%       0.18 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc._install_special_mapping.map_vdso
      0.10 ± 58%    +126.4%       0.22 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.61 ± 67%    +155.7%       1.56 ± 35%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.95 ± 44%    +116.0%       2.05 ± 46%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.33 ± 30%    +239.9%       1.11 ± 52%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.41 ± 47%    +117.5%       0.90 ± 39%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.07 ± 64%    +218.4%       0.21 ± 51%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.01 ±  4%     +39.0%       0.01 ±  4%  perf-sched.total_sch_delay.average.ms
      1.01           +17.8%       1.19        perf-sched.total_wait_and_delay.average.ms
   1887641           -14.2%    1619613        perf-sched.total_wait_and_delay.count.ms
      1.00           +17.6%       1.17        perf-sched.total_wait_time.average.ms
     12.93 ± 14%     +55.6%      20.12 ± 20%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      6.25 ±  2%     +18.2%       7.39 ±  2%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.06           +55.8%       0.09        perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.58 ±  2%     +17.2%       0.68        perf-sched.wait_and_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02          +201.8%       0.05        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      5.96           +10.9%       6.60        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.82 ±  2%     +14.0%      22.58 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.22           +27.3%       0.28        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.21           +24.3%       0.26        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.21           +19.6%       0.25        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.13           +27.0%       0.17        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.54           +28.9%       0.70 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.21 ±  2%     +24.6%       0.27        perf-sched.wait_and_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.32           +13.1%       8.28        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    545.60 ±  4%     -23.4%     418.20 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
     76.10 ± 12%     -36.4%      48.40 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
    127.00 ±  9%     -17.7%     104.50 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
     52.40 ±  8%     -22.9%      40.40 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
    393.60 ±  6%     -21.5%     308.90 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
     89.50 ± 11%     -21.6%      70.20 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     48.40 ± 14%     -38.8%      29.60 ± 21%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
    182.10 ±  5%     -26.5%     133.80 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
      8.50 ± 30%     -56.5%       3.70 ± 68%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
     94.40 ±  8%     -19.2%      76.30 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
      2848 ±  2%     -17.3%       2356 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     43593            -9.7%      39383        perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    793.00 ±  5%     -18.6%     645.40 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
     75784           -13.0%      65905        perf-sched.wait_and_delay.count.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
     97572            -9.8%      87972        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     78999            -9.9%      71192        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2293 ±  2%     -16.8%       1908 ±  2%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    698.20 ±  2%     -11.3%     619.20 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
     79529           -15.7%      67030        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
   1247167           -15.2%    1058217        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
     20907           -13.1%      18162        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     21728            -9.8%      19592        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     10834            -9.8%       9771        perf-sched.wait_and_delay.count.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     83505           -11.5%      73868        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     30.52 ±  2%     +13.5%      34.63 ±  5%  perf-sched.wait_and_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      1.84 ± 39%    +117.7%       4.00 ± 27%  perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      3.62 ± 36%    +499.3%      21.69 ± 13%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.18 ± 10%     +29.3%       0.23 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.alloc_anon_folio
      0.12 ±  8%     +37.9%       0.17 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.20 ±  5%     +32.5%       0.26 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.step_into.link_path_walk
      0.15 ±  3%     +17.1%       0.17 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.17 ±  8%     +44.8%       0.24 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      0.47 ± 22%     +55.6%       0.73 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.18 ±  3%     +27.8%       0.23 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.18 ±  5%     +19.6%       0.22 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.20 ±  2%     +28.3%       0.26 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.path_lookupat
      0.19           +18.1%       0.22 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.path_openat
      0.20 ±  9%     +26.8%       0.25 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.20           +19.0%       0.24 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.17 ±  9%     +35.0%       0.23 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.lookup_open.isra
      0.20 ±  3%     +30.7%       0.26 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.21 ±  2%     +24.4%       0.26 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_lookupat
      0.19           +19.6%       0.23 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.19 ±  3%     +20.2%       0.23 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.22 ±  6%     +20.9%       0.26 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
      0.17           +23.3%       0.21 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.16 ± 41%     +96.8%       0.32 ± 58%  perf-sched.wait_time.avg.ms.__cond_resched.dput.walk_component.link_path_walk.path_openat
     12.93 ± 14%     +55.6%      20.12 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.18 ±  6%     +21.8%       0.21 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      0.17 ±  4%     +12.7%       0.19 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.21 ±  2%     +14.9%       0.24 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      6.24 ±  2%     +18.2%       7.38 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05           +48.2%       0.07 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.20 ±  3%     +25.4%       0.25 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.18 ±  2%     +15.6%       0.20 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.57 ±  2%     +17.5%       0.67        perf-sched.wait_time.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.21           +20.8%       0.25 ±  3%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      0.02          +201.8%       0.05        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      5.94           +10.8%       6.58        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.03 ± 29%    +125.6%       0.06 ± 28%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      0.10 ±  2%     +42.5%       0.14 ±  3%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.20 ±  5%     +23.5%       0.25 ±  9%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     19.81 ±  2%     +14.0%      22.58 ±  2%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.21           +27.6%       0.27        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.20           +23.0%       0.25        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.20           +20.1%       0.24        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.13           +26.1%       0.16        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.53           +28.5%       0.68 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.20 ±  2%     +24.4%       0.25 ±  2%  perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.31           +13.1%       8.27        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 41%  +47970.9%       2.64 ±298%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     28.81 ± 27%     +21.1%      34.91 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pmd_alloc
      0.49 ± 35%    +128.1%       1.12 ± 36%  perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.step_into.link_path_walk
      1.00 ± 21%     +72.1%       1.72 ± 36%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
     30.51 ±  2%     +13.4%      34.59 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      0.62 ± 39%    +136.9%       1.48 ± 47%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      0.48 ± 10%    +162.1%       1.27 ± 33%  perf-sched.wait_time.max.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      0.38 ± 22%    +179.1%       1.06 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.68 ± 16%    +133.6%       1.58 ± 22%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_lookupat
      0.78 ± 21%    +107.7%       1.63 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.25 ± 21%     +59.9%       0.40 ± 39%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.lookup_open.isra
      0.92 ± 13%    +124.4%       2.07 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.34 ±  9%     +92.7%       0.66 ± 26%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
      0.68 ± 31%     +86.5%       1.27 ± 26%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      0.38 ± 18%    +111.3%       0.79 ± 61%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
      1.01 ± 19%     +40.4%       1.42 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.35 ± 43%     +89.8%       0.66 ± 38%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.alloc_bprm
      1.12 ± 29%     +71.6%       1.92 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.77 ± 23%    +117.6%       1.68 ± 18%  perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      3.62 ± 36%    +499.3%      21.69 ± 13%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     32.45 ±  4%    +307.7%     132.32 ±218%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.06 ± 75%  +1.7e+05%     100.16 ±299%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open



***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/shell16/unixbench

commit: 
  d398a68e8b ("# gpg: Signature made Wed 25 Jun 2025 12:55:36 AM CEST")
  155213a2ae ("sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails")

d398a68e8bcf430e 155213a2aed42c85361bf4f5c81 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1743092 ±  7%     -19.5%    1403053 ± 10%  numa-meminfo.node1.Shmem
     16565           +46.5%      24271        uptime.idle
 1.461e+10           +52.1%  2.221e+10        cpuidle..time
 1.677e+08 ±  3%     -21.2%  1.321e+08 ±  2%  cpuidle..usage
    129992            -9.9%     117159        meminfo.Mapped
   2737656           -11.1%    2433270        meminfo.Shmem
 5.275e+08           -20.5%  4.193e+08        numa-numastat.node0.local_node
 5.275e+08           -20.5%  4.193e+08        numa-numastat.node0.numa_hit
 5.245e+08           -20.4%  4.177e+08        numa-numastat.node1.local_node
 5.246e+08           -20.4%  4.177e+08        numa-numastat.node1.numa_hit
     36.39           +50.8%      54.87        vmstat.cpu.id
     52.82 ±  3%     +16.0%      61.29 ±  5%  vmstat.procs.r
    611743 ±  2%     -37.0%     385194        vmstat.system.cs
    495119           -38.1%     306537        vmstat.system.in
 5.275e+08           -20.5%  4.193e+08        numa-vmstat.node0.numa_hit
 5.275e+08           -20.5%  4.193e+08        numa-vmstat.node0.numa_local
    435783 ±  7%     -19.5%     350787 ± 10%  numa-vmstat.node1.nr_shmem
 5.246e+08           -20.4%  4.177e+08        numa-vmstat.node1.numa_hit
 5.245e+08           -20.4%  4.177e+08        numa-vmstat.node1.numa_local
      9398           -15.2%       7972        perf-c2c.DRAM.local
     29225           -33.3%      19484        perf-c2c.DRAM.remote
     21976           -35.0%      14294        perf-c2c.HITM.local
     15468 ±  2%     -34.1%      10191        perf-c2c.HITM.remote
     37445           -34.6%      24485        perf-c2c.HITM.total
     36.22           +18.5       54.74        mpstat.cpu.all.idle%
      0.00 ± 32%      +0.0        0.01 ±  5%  mpstat.cpu.all.iowait%
      1.24 ±  2%      -0.4        0.80        mpstat.cpu.all.irq%
      0.66            -0.2        0.49        mpstat.cpu.all.soft%
     52.24           -15.0       37.20        mpstat.cpu.all.sys%
      9.64            -2.9        6.76        mpstat.cpu.all.usr%
     70.44           -25.5%      52.47        mpstat.max_utilization_pct
     10050           -20.2%       8018        unixbench.throughput
  12079997           -17.4%    9977617 ±  2%  unixbench.time.involuntary_context_switches
    618017           -21.1%     487711        unixbench.time.major_page_faults
 1.245e+09           -20.4%  9.909e+08        unixbench.time.minor_page_faults
      3790           -26.1%       2801        unixbench.time.percent_of_cpu_this_job_got
     18727           -26.5%      13769        unixbench.time.system_time
      5248           -23.3%       4026        unixbench.time.user_time
 2.228e+08           -42.0%  1.293e+08        unixbench.time.voluntary_context_switches
   6353777           -20.2%    5072851        unixbench.workload
    903225            -8.6%     825615        proc-vmstat.nr_active_anon
   1597356            -4.8%    1521116        proc-vmstat.nr_file_pages
     49399            -3.4%      47698        proc-vmstat.nr_kernel_stack
     32506           -11.2%      28854        proc-vmstat.nr_mapped
     36270            -4.8%      34518        proc-vmstat.nr_page_table_pages
    684360           -11.1%     608318        proc-vmstat.nr_shmem
     28530            -1.4%      28121        proc-vmstat.nr_slab_reclaimable
     57039            -3.0%      55312        proc-vmstat.nr_slab_unreclaimable
    903225            -8.6%     825615        proc-vmstat.nr_zone_active_anon
 1.052e+09           -20.4%   8.37e+08        proc-vmstat.numa_hit
 1.052e+09           -20.4%  8.369e+08        proc-vmstat.numa_local
     68543            -1.3%      67625        proc-vmstat.numa_other
 1.092e+09           -20.8%  8.653e+08        proc-vmstat.pgalloc_normal
 1.255e+09           -20.2%  1.001e+09        proc-vmstat.pgfault
 1.091e+09           -20.8%  8.646e+08        proc-vmstat.pgfree
  62188682           -20.5%   49465596        proc-vmstat.pgreuse
     53492           -20.5%      42531        proc-vmstat.thp_fault_alloc
  22570890           -20.5%   17937730        proc-vmstat.unevictable_pgs_culled
      3.59           -18.2%       2.94        perf-stat.i.MPKI
 1.625e+10           -25.1%  1.217e+10        perf-stat.i.branch-instructions
      1.57            -0.2        1.40        perf-stat.i.branch-miss-rate%
 2.505e+08           -33.4%  1.668e+08        perf-stat.i.branch-misses
 2.894e+08           -38.9%  1.767e+08        perf-stat.i.cache-misses
 1.186e+09           -39.1%   7.22e+08        perf-stat.i.cache-references
    613742 ±  2%     -37.0%     386739        perf-stat.i.context-switches
      1.90            -4.3%       1.81        perf-stat.i.cpi
 1.523e+11           -28.5%   1.09e+11        perf-stat.i.cpu-cycles
    223407           -63.9%      80733        perf-stat.i.cpu-migrations
    535.12           +18.9%     636.17 ±  2%  perf-stat.i.cycles-between-cache-misses
  7.93e+10           -25.1%  5.942e+10        perf-stat.i.instructions
      0.54            +4.4%       0.56        perf-stat.i.ipc
    982.38           -21.2%     773.91        perf-stat.i.major-faults
     73.67           -24.7%      55.47        perf-stat.i.metric.K/sec
   1939561           -20.5%    1541837        perf-stat.i.minor-faults
   1940543           -20.5%    1542611        perf-stat.i.page-faults
      3.65           -18.5%       2.97        perf-stat.overall.MPKI
      1.54            -0.2        1.37        perf-stat.overall.branch-miss-rate%
      1.92            -4.5%       1.83        perf-stat.overall.cpi
    526.36           +17.1%     616.57        perf-stat.overall.cycles-between-cache-misses
      0.52            +4.8%       0.55        perf-stat.overall.ipc
   7895095            -5.8%    7441118        perf-stat.overall.path-length
 1.623e+10           -25.1%  1.215e+10        perf-stat.ps.branch-instructions
 2.502e+08           -33.4%  1.665e+08        perf-stat.ps.branch-misses
  2.89e+08           -39.0%  1.764e+08        perf-stat.ps.cache-misses
 1.184e+09           -39.1%  7.209e+08        perf-stat.ps.cache-references
    612904 ±  2%     -37.0%     386147        perf-stat.ps.context-switches
 1.521e+11           -28.5%  1.088e+11        perf-stat.ps.cpu-cycles
    223102           -63.9%      80621        perf-stat.ps.cpu-migrations
 7.919e+10           -25.1%  5.933e+10        perf-stat.ps.instructions
    981.09           -21.2%     772.65        perf-stat.ps.major-faults
   1936572           -20.5%    1539324        perf-stat.ps.minor-faults
   1937553           -20.5%    1540097        perf-stat.ps.page-faults
 5.016e+13           -24.8%  3.775e+13        perf-stat.total.instructions
  13132161           -28.7%    9359300        sched_debug.cfs_rq:/.avg_vruntime.avg
  15326712 ±  3%     -25.0%   11491862 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.max
  12556945           -28.9%    8923532        sched_debug.cfs_rq:/.avg_vruntime.min
      0.81 ±  5%     +13.2%       0.91 ±  5%  sched_debug.cfs_rq:/.h_nr_queued.avg
      5.30 ± 23%     +88.6%      10.00 ± 12%  sched_debug.cfs_rq:/.h_nr_queued.max
      0.98 ± 11%     +74.8%       1.70 ±  8%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.74 ±  4%     +11.5%       0.83 ±  4%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      4.71 ± 25%    +102.3%       9.53 ± 14%  sched_debug.cfs_rq:/.h_nr_runnable.max
      0.86 ± 13%     +83.6%       1.58 ±  9%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
     16.14 ±  4%     -13.6%      13.94 ±  2%  sched_debug.cfs_rq:/.load_avg.min
     84.33 ±  5%     +22.8%     103.54 ±  9%  sched_debug.cfs_rq:/.load_avg.stddev
  13132161           -28.7%    9359300        sched_debug.cfs_rq:/.min_vruntime.avg
  15326712 ±  3%     -25.0%   11491862 ±  7%  sched_debug.cfs_rq:/.min_vruntime.max
  12556946           -28.9%    8923532        sched_debug.cfs_rq:/.min_vruntime.min
      0.60 ±  5%     -26.4%       0.44 ±  2%  sched_debug.cfs_rq:/.nr_queued.avg
     17.75 ± 15%     +35.8%      24.11 ±  7%  sched_debug.cfs_rq:/.removed.load_avg.avg
    362.55 ± 11%     +41.9%     514.30 ± 14%  sched_debug.cfs_rq:/.removed.load_avg.max
     68.25 ± 11%     +36.9%      93.43 ±  7%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     74.47 ± 10%     +49.8%     111.56 ± 12%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     14.06 ± 19%     +49.5%      21.01 ± 12%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
    885.61           +13.6%       1006        sched_debug.cfs_rq:/.runnable_avg.avg
      1607 ±  3%     +36.7%       2197 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
    365.76 ±  2%     +25.9%     460.47 ±  5%  sched_debug.cfs_rq:/.runnable_avg.min
    259.26 ±  3%     +17.7%     305.09 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    247.16 ±  2%     -15.9%     207.96 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
     27.96 ±  9%     +55.7%      43.54 ±  5%  sched_debug.cfs_rq:/.util_est.avg
    253.62 ± 19%    +120.0%     558.02 ± 10%  sched_debug.cfs_rq:/.util_est.max
     50.33 ± 12%     +93.4%      97.32 ±  8%  sched_debug.cfs_rq:/.util_est.stddev
    170553 ±  3%     +85.7%     316634 ±  3%  sched_debug.cpu.avg_idle.avg
    387229 ±  5%     +98.0%     766874 ±  5%  sched_debug.cpu.avg_idle.max
     26436 ±  7%     +99.2%      52667 ± 28%  sched_debug.cpu.avg_idle.min
     72543 ±  4%    +104.5%     148373 ±  3%  sched_debug.cpu.avg_idle.stddev
   1258992 ±  3%     -39.0%     768365 ±  4%  sched_debug.cpu.curr->pid.avg
    500518          +170.7%    1355011        sched_debug.cpu.max_idle_balance_cost.avg
    523673 ±  4%    +185.0%    1492698        sched_debug.cpu.max_idle_balance_cost.max
      3207 ± 88%   +4294.6%     140956 ± 46%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.81 ±  5%     +12.7%       0.92 ±  6%  sched_debug.cpu.nr_running.avg
      5.36 ± 18%     +89.5%      10.17 ± 12%  sched_debug.cpu.nr_running.max
      0.98 ± 10%     +75.6%       1.72 ±  8%  sched_debug.cpu.nr_running.stddev
   2891583 ±  2%     -36.7%    1829676        sched_debug.cpu.nr_switches.avg
   2953034 ±  2%     -37.1%    1858327        sched_debug.cpu.nr_switches.max
   2814744 ±  2%     -36.8%    1780154        sched_debug.cpu.nr_switches.min
     26785 ±  6%     -50.3%      13321 ± 13%  sched_debug.cpu.nr_switches.stddev
     59229 ± 18%     -91.0%       5353 ±  8%  sched_debug.cpu.nr_uninterruptible.max
   -144639           -96.1%      -5702        sched_debug.cpu.nr_uninterruptible.min
     37096 ± 14%     -93.2%       2537 ±  5%  sched_debug.cpu.nr_uninterruptible.stddev
      0.01 ± 18%    +267.9%       0.03 ± 89%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.alloc_anon_folio
      0.01 ±  8%    +525.0%       0.03 ± 78%  perf-sched.sch_delay.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ±  7%     +58.9%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.01 ± 13%    +170.0%       0.04 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.do_close_on_exec.begin_new_exec.load_elf_binary.exec_binprm
      0.01 ± 12%     +71.9%       0.02 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.exec_binprm
      0.01 ± 27%    +129.6%       0.02 ± 43%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.01           +57.1%       0.01 ± 35%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.01 ± 15%    +107.7%       0.02 ± 32%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.01 ± 14%     +95.2%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      0.01 ± 16%    +230.0%       0.02 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.01 ± 15%     +75.0%       0.02 ± 29%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_shrink
      0.01 ± 17%     +56.8%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.01 ± 22%     +64.8%       0.02 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.03 ±126%     -80.7%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.anon_pipe_read.vfs_read.ksys_read
      0.01           +37.0%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  4%     +88.7%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ±  8%     +91.8%       0.02 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.02 ±122%    +274.3%       0.07 ± 60%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 16%     +97.7%       0.03 ± 22%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.01 ± 11%    +125.0%       0.02 ± 42%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.01 ± 26%     +77.6%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.02 ±126%    +168.0%       0.04 ± 70%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ± 15%     +92.3%       0.02 ± 25%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.01 ± 10%     +56.5%       0.02 ± 15%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.02 ±  8%     -20.6%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
      0.01 ±  6%     +31.5%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  4%     -12.9%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03           -16.1%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.25 ± 78%    +940.3%       2.63 ±149%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.alloc_anon_folio
      0.13 ± 40%    +395.2%       0.62 ±106%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.wp_page_copy
      0.01 ± 18%   +1886.4%       0.15 ±107%  perf-sched.sch_delay.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.10 ± 32%    +356.0%       0.47 ± 89%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.08 ± 24%    +258.2%       0.28 ± 24%  perf-sched.sch_delay.max.ms.__cond_resched.do_close_on_exec.begin_new_exec.load_elf_binary.exec_binprm
      0.20 ± 78%    +328.1%       0.85 ± 65%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_lookupat
      0.07 ± 36%    +456.5%       0.39 ±102%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
      0.07 ± 40%    +149.9%       0.18 ± 95%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.12 ± 44%    +129.2%       0.27 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.exec_binprm
      0.04 ± 46%    +329.1%       0.17 ± 31%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_binary
      0.07 ± 71%    +152.7%       0.18 ± 20%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
      0.04 ± 44%    +403.2%       0.19 ± 70%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.09 ± 41%    +272.9%       0.33 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.13 ± 31%    +205.2%       0.40 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.15 ± 59%   +1852.6%       2.92 ±134%  perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.12 ± 50%    +707.1%       0.94 ±101%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.09 ± 39%    +137.4%       0.21 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.06 ± 47%    +112.3%       0.13 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.__kernel_read.exec_binprm.bprm_execve
      0.11 ± 54%    +588.8%       0.74 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      0.07 ± 35%    +158.5%       0.17 ± 38%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
      0.05 ± 88%    +605.9%       0.36 ± 62%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.04 ± 94%    +218.3%       0.12 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_link
      0.13 ± 73%    +415.6%       0.65 ± 48%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.07 ± 76%    +140.3%       0.18 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.15 ±162%     -94.1%       0.01 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.anon_pipe_read.vfs_read.ksys_read
      0.37 ± 29%     +79.8%       0.66 ±  9%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.15 ± 34%    +407.2%       0.77 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.10 ± 63%    +438.3%       0.53 ± 46%  perf-sched.sch_delay.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.07 ± 31%  +19792.4%      14.82 ±219%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     12.60 ±202%    +436.8%      67.62 ± 74%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.13 ± 22%     +55.2%       0.20 ± 24%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.ret_from_fork.ret_from_fork_asm.[unknown]
      0.11 ± 40%     +83.7%       0.20 ± 23%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      0.28 ± 76%    +379.7%       1.34 ± 66%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.05 ± 58%   +1155.4%       0.62 ± 72%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.06 ± 51%    +785.5%       0.55 ± 43%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     28.85 ± 15%     +50.7%      43.47 ± 18%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      6.57 ±  4%     +11.9%       7.35 ±  4%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±  2%    +170.8%       0.06        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
    481.00 ±  6%     -20.4%     382.83 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
     43.00 ± 12%     -25.2%      32.17 ± 11%  perf-sched.wait_and_delay.count.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
    313.17 ±  5%     -17.1%     259.67 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      2016           +21.2%       2443 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    632.00            -8.8%     576.33 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      1490 ±  3%     -13.0%       1296 ±  6%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      7.78 ±  7%     +45.7%      11.33 ± 13%  perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      4.75 ± 21%    +512.5%      29.11 ± 27%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      4.73 ± 20%     +83.1%       8.67 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
     31.76 ± 16%     -24.7%      23.90 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      3.33 ± 13%     +42.4%       4.74 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlinkat
      3.22 ± 23%     +34.9%       4.34 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      3.72 ±  2%     +14.5%       4.25 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      2.99           +13.0%       3.37 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      3.25 ±  3%     +12.8%       3.67 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      2.99 ±  4%     +11.0%       3.32 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      2.78 ±  3%      +9.5%       3.05 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      3.08 ±  9%     +17.7%       3.63 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.do_brk_flags.__do_sys_brk
      2.52 ± 46%     +59.0%       4.01 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
     28.84 ± 15%     +50.1%      43.30 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      3.54 ±  2%     +12.8%       4.00 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
      6.56 ±  4%     +11.8%       7.34 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.21 ±  2%     +16.7%       3.75 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.02 ±  2%    +170.8%       0.06        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.39 ± 29%     +80.4%       0.71 ± 20%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      1.39 ±  2%     +21.2%       1.69 ±  2%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      3.78 ±  4%     +10.1%       4.16 ±  3%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.02 ±  8%     -20.6%       0.01 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
      5.22 ± 11%     +32.0%       6.89 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      5.93 ± 10%     +28.7%       7.63 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.step_into.link_path_walk
      5.23 ±  9%     +34.3%       7.03 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.__get_user_pages.get_user_pages_remote.get_arg_page.copy_strings
      6.67 ±  7%     +19.6%       7.98 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      5.72 ±  4%     +22.8%       7.03 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      6.52 ± 12%     +28.1%       8.35 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      5.42 ±  5%     +24.5%       6.74 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.do_close_on_exec.begin_new_exec.load_elf_binary.exec_binprm
      6.05 ± 10%     +34.3%       8.12 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_lookupat
      6.77 ± 14%     +36.2%       9.22 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_openat
      4.63 ± 20%     +43.0%       6.62 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlinkat
      4.80 ± 12%     +33.0%       6.38 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.vms_gather_munmap_vmas
      5.03 ± 11%     +23.9%       6.23 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.commit_merge.vma_expand
      4.67 ± 11%     +30.9%       6.12 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      6.39 ±  7%     +29.8%       8.29 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      4.39 ± 14%     +53.2%       6.73 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      7.06 ±  9%     +36.3%       9.62 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      6.48 ±  7%   +2586.0%     174.00 ±212%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.path_lookupat
      6.65 ±  8%     +35.1%       8.99 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      6.53 ± 15%     +33.4%       8.71 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      6.18 ±  3%     +65.1%      10.20 ± 47%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      6.44 ±  7%     +33.7%       8.60 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      6.00 ±  9%     +22.3%       7.33 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      5.43 ±  7%     +36.0%       7.38 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
      7.76 ±  7%     +45.0%      11.25 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      6.24 ±  4%     +35.2%       8.44 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      6.36 ±  9%     +26.3%       8.04 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      6.12 ± 11%     +64.1%      10.04 ± 36%  perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      4.75 ± 21%    +512.5%      29.11 ± 27%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      5.60 ± 13%     +24.3%       6.96 ± 15%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      5.92 ± 14%     +55.5%       9.21 ± 36%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


