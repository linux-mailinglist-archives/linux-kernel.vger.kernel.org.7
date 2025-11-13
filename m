Return-Path: <linux-kernel+bounces-898692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE4C55C85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418503ADED4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131F219067C;
	Thu, 13 Nov 2025 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmoyoW1R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BBF30748E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010906; cv=fail; b=u7/Jyksy4JvXK3nNYYw3mGg4dVlHwIeZU156WoOyzdrwXj4o5JYijXNr0WWpnlnXAlrpEye/vp59eQeVTFTlJee4jtKy1dFu76Qn9pQTLE3XDSPaAWwoV1yy3gwK8C7xmkFrmTsU0HoDjnWN23+yDp3so6tdzp8NWbbgh7Nkb7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010906; c=relaxed/simple;
	bh=OaSqo9CwkfT4Gb66T4ps1RTcw8qMijzQ92vYtim7BN4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NYS2evmIoNIJYjf8LE++ZaQVknrCjyUTElV7JH5Pu8SHpwt/Kn/7JUv99VGKt6WYWM8GcqvOR2hEr/KV7f8gJSmDFREZZYwIFJ4TJexI9Lq/5zJqiA1mRx/GJLwzbq+ryfXYsVno/dcJPw9NeUIFpphOh1e77UZeRHmYK+U9cto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmoyoW1R; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763010904; x=1794546904;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=OaSqo9CwkfT4Gb66T4ps1RTcw8qMijzQ92vYtim7BN4=;
  b=ZmoyoW1RTgmO8XH0fInmk7mU/m33XZwvhh7hUGqbCsLkBouPpiri5qx2
   kvBcr+HnG8JLzGRJ2wFxGBDLPhuyNEEGpDHI1KdgVPDUxVn+e+9BD9z60
   P8FfWaHXiV5rFJJokhOmEHkRVUyYrFFZK8sSIu2Cs9hld7E8UQGtEHqsQ
   Xim6GIIQbf/usCzaXg6kyRLYYR2Zb20vj4lL4kosSAbdpwlDDI0oKgH/j
   hvrUBNHkyPyg3odIBo9NZNevNF40LHCzyOnSGXefr+9ounAdzt8rdklJM
   lfOOuNnkjdxuIt02nNTYfzLlBc7ZkLIvTxjF3W5BxUYuy8rrv6UITR0dl
   w==;
X-CSE-ConnectionGUID: RYca2Cb5Q2q1v24JJ0VTSg==
X-CSE-MsgGUID: C7VFPE2ISpGyvdi4IEVIMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82481466"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="82481466"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 21:15:03 -0800
X-CSE-ConnectionGUID: 9j499QfYQH6zVgcQk+78zg==
X-CSE-MsgGUID: IkHmg+5QRWmdUX/U6ZaDEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="193530660"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 21:15:04 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 21:15:02 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 21:15:02 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 21:15:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkB+eQrGT0j8fDo8JFeVZnQE7PVDLENkH7UcROp1CybnXKhbqTlzaLy/2Ml1tOhhO1/6peS2pKSbk6QVMzLJadOdIscK56TDNE4mDbmNxR4yyyHDyo2Ts0q3N1vK6SYGL0vksQnLMh4wY9A9LORH5CJ6h5GptP8HXQObWQYtU7wZh9kD28yNwayANnBlvoTdl27LDuReiHYY3gOQuIEFwC/3Xy1DYwXl2IsQB9d6AjYPv/F9uDYurmFVywbr/agasG9j+S60kxnc5e7J9gm6zRf7Gd2pGS54yYkkPG2r07vFgifxdFxRu+8gOW4Drte69TyyPE1ZYEE1uCKsRpaZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5A+cS9vFic9rS2hJNo+obHIuT/s1dl5G5DdS6fXw/I=;
 b=WIWXrHMOOX7CsRHwXQfmkU1WdkOsSm9aWDzmq9wWrnLT3bYJt+w/3TlXX+tEGrkqyom0F68NvwlP4TTECcd9ujYxxwhgF09pBnQNJIfZj+hvsRlIN7uR6oiePXz9vF2qvTUUOo3kOtzbGAGWeiRw5xzpznHkWtdYDbqHrs+gs6Wq5nbN9LErkIjLqouTo1xUo3SsWYW7z17vHIIumNm8Nzo30dZNU1pH5zGEii5ercdm4vPz0+W87YO4gytsrfVgDzzkrGG+hTws3eX9gWgkRZC/YsfREuP1Mqjse53tU2JVh5UW9d2oqjBowNBOdFyo/RQeVqb1wfCgB0w1kj6LDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by IA3PR11MB9225.namprd11.prod.outlook.com (2603:10b6:208:570::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 05:14:54 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 05:14:53 +0000
Date: Thu, 13 Nov 2025 13:14:44 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Chartre <alexandre.chartre@oracle.com>,
	<linux-kernel@vger.kernel.org>, <mingo@kernel.org>, <jpoimboe@kernel.org>,
	<peterz@infradead.org>
CC: <oe-kbuild-all@lists.linux.dev>, <alexandre.chartre@oracle.com>
Subject: Re: [PATCH v3 14/28] objtool: Improve tracing of alternative
 instructions
Message-ID: <aRVpRNZxs2ar/0tf@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112160315.2207947-15-alexandre.chartre@oracle.com>
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|IA3PR11MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: b4acc172-ad04-45df-7109-08de2273941e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IQm+2UmLN0kNVhU2ZUXG5O9QE3idqKp0A/l03CSKNoXJn6ogaOmHjIOPj90v?=
 =?us-ascii?Q?7g5oPJufn7m3FDAT4kEPWcq+p1Pus3gdkRjf2sdh/CY909wSXaQ17N+w7gh3?=
 =?us-ascii?Q?ZrdLX4kIhKO3Bo25WGZZcxAr8Sh8feojvYRABtoHwPMeLfIP7PkskYBHy2k2?=
 =?us-ascii?Q?GbWGsqY2W7jqhjLMlFwvATsq7WAmJdeXKpz2ObzKxbK4N1dZbQyU00EZ1deQ?=
 =?us-ascii?Q?RbDB/iOQRtUh9pU3SHJBD0HKCSW4Iwav2ZQHJeuDXBPHqxFBSdhDzHQo025+?=
 =?us-ascii?Q?PMhkjNN0VJetIAocAuCDdJmtLFr7er3wHTEcoNJRxQ3KXXKSFntOBPP/OfkI?=
 =?us-ascii?Q?lav6u5RAs2AsBrE6nqJMXxUPG5YQdiW827G7E2whMYltTtLKG0dcqigXK9Ax?=
 =?us-ascii?Q?nKjBrQPGH63vtS4ihI+zO0ZJtyAG5aBAWwRsogsCpx1yEGozfBEZ33q8t2d2?=
 =?us-ascii?Q?pwvIyVWu/f6nHl6EgeLykK/0pxnTrEuM10TZ0T7n+Xr6BwdlVrVT1MtprNfI?=
 =?us-ascii?Q?KUtL5dzI8oIdWm/QRbauDVdR062FTETekF7ivmgWQi5LjGcw+ZiH0qAnoWEM?=
 =?us-ascii?Q?E1EvMdLqcUz51XBLeZcf2ZBMMcBQ2eEasUz605EDUftFzkRau6xYLOBFyhYg?=
 =?us-ascii?Q?8SLtj+KrDXMhT2LyG5mhLFXdSzxvRO62sloP66SJu4Mdthy/2ENZuSbx0O0o?=
 =?us-ascii?Q?RSc85m2k83ROtOjwZ35SljNMVvd4phJJz9k6mSk3lyJtQa3QgWEx+eKbViT1?=
 =?us-ascii?Q?hPP7ztLwNZZFzueGsqg7BlRlSr5AJweTuHTzXAbMe2hEJmYPqh9ED3wCdpMX?=
 =?us-ascii?Q?G7GyZF6LjVjTDqA82WgnB5taHVETWGXvTsjLL3u6O6IVu5GlDH7tmzphWWwG?=
 =?us-ascii?Q?NJ0cQbPlTnVkMPiZsh+p7xyIHB6GkM90Zs2GOlyUCcGWZZSthwECJcT1MJ2J?=
 =?us-ascii?Q?QJKzs4/MNL1iXmoJ+hhjj7IRP+pqZhbEErlitCrrdCsLzEJVCFVB7+UD6vNl?=
 =?us-ascii?Q?w0NMkuFJp4AlReEZLMEIlqK9DDTMa4VVMjXzlJ4w/2KD2vBB/d+TvoHxWI0E?=
 =?us-ascii?Q?6AlVZcK4aHaCOR61tsQf2AnYTqTa4R/zoia/fCc8s4NO+KuiOdbywviwMl7v?=
 =?us-ascii?Q?G7jMNebNls/F7RnpRGT1OjnW+I9hnsKAYM2P1sgZeiFxMQCc3QeUsBcy9KNv?=
 =?us-ascii?Q?rKNeoBJLarIJWjavVjV4NXu5X4hwSb3FAdpIFI8W4xJZYKfbitHE0USR3MZl?=
 =?us-ascii?Q?pPRzezi3uQWH5v7vYsoSCfBLpkXISloCCXcaFCmWh6eNtsLjevi0FrDUpnHI?=
 =?us-ascii?Q?Nsp+FE9hG+PSqgKAndM62Vccxh5JURGSY4ISHl/OdxL9VU7i6gmFT9b5pyNv?=
 =?us-ascii?Q?4KjKrhWZ/zSaT/vSTin3Vw80jYMb49vcSztGMYUBRo0jutKEUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Hixbwtse7cKhbNzELp7rcGfNpnDtWx8ghM0cW+R2CIl6Axd1b7VBB3ghM86?=
 =?us-ascii?Q?R+59TyI9WE4QW6HoUlp5rexqzqHtg/WwXtx0iFtuV8zvR262JqInaMhHpqak?=
 =?us-ascii?Q?dh/QoIvkBcQuRfKJ0cqMritGuJ3FA9vyio7dNhqMc6NzNDFbgVNueu0yVxjW?=
 =?us-ascii?Q?SPnxaFPgwV36+6wv/QJZKoPd0KV4tpcXJytfda/RYoFCc7rYltaNvbiQAEWe?=
 =?us-ascii?Q?xNhbXn13KW3DZ/xGJ2Khux1l2yzubMRE0hUXS9Ac9Vt4uVLBomIMUdy+DaKs?=
 =?us-ascii?Q?GD+LVuulDmvhDYMjb3EGEnV98kVEshQZbk1a1trH8sBNg5wKc55/h8JBZyIA?=
 =?us-ascii?Q?ov1UWvgPnmmmK8OF/eQtZHbkH0kHcqEHzcyEMRcQH7wlTE5lvNI+utSX7eiK?=
 =?us-ascii?Q?za6xHyBpHWJg8W8GH0mhTOgAFDXfXiozot53xqBPsqLwZXKC2JDpwhun0J4N?=
 =?us-ascii?Q?2cylE/hkkKbDPurJ08chY30I8cMuSUcfzgr1i7o2n/ygSWr8GizlQtZplZyk?=
 =?us-ascii?Q?R14FeFXC7yzd235JYg0xsgTfMuEn5gxL84sgkY6gKH2mLupW6qjK6f5VxxPg?=
 =?us-ascii?Q?u8XWUvzeUfrZgk9KFVBYm2sPdocsxOE+4RfadzyxZp7lMXbT8+Xt0afdlDT/?=
 =?us-ascii?Q?ym9jXOHmacNDRIT8LMNSaH5RB3tgha7LCwKxKVzS6jAiKIxXNAC0nG4BqNXD?=
 =?us-ascii?Q?6dPzC1FRAOOXb5lehr5QC3qfwK601BG+xmbFzkiZyuPhHAYA2XftBqxQ4zB0?=
 =?us-ascii?Q?3wdhx+6nXPGZ2Rf2Rk4F2qjDBiBcvOM+MuYHxuXbv7cag/DwwSDFRfH3uYRw?=
 =?us-ascii?Q?U1wJOUDJNOcyO0KWKWcYToxi1dlprAp4MmE10s5/UYok45k/7g78Qb/cFSOI?=
 =?us-ascii?Q?zAEa85tGlFsXl1auGRlxDkLs7uZysVoMmcNh4r1vPHmr+e9Mnrw5bGWwicjN?=
 =?us-ascii?Q?3RfS38Lqe59oZ/21jk0NKc0qgQBmG23bKBba5V1V10RwuuWAbawnkhWWKXS3?=
 =?us-ascii?Q?dOIXcCoZI9s76IBMAAyfemXFxPSZzvjVcfQw7elETfWTWDm5AKz5Q0oqZ+F/?=
 =?us-ascii?Q?tdPIV+qYAWex26LGslBwO8/6CitEhUpqClt1Stke/E+Qc0AD2yrlUBG41Sx0?=
 =?us-ascii?Q?ju/A6k0ZEnR1mExBesHW57ts6iGhKwoxo3ozIyVaOH9I2WvmQRDu5p5ZfsaK?=
 =?us-ascii?Q?6ryl7+SvFFbR0e69njM0dtB/BXT2sJUkd5RPqAfj8DzG5gUZU0t/7x4RuPWg?=
 =?us-ascii?Q?BYQwmSFuEGJl70dSRlPe7912W6FBqYC6xag6NZlwQzwlpPpXEl6mI022DfVx?=
 =?us-ascii?Q?md55tHsiGMGpx6VmtVHc6vWraOqReaxFtQ7/w9x4LBtL5kdWdtLHvXmupAfx?=
 =?us-ascii?Q?ipHO9uwMW5VtXn0vpgX9/BE6pkIL+wq7p35GZy+cucxMIgf8MS5tWtyu5M9B?=
 =?us-ascii?Q?vcWSmJJ+IxHzyjJyz8YZzcKU4rpqZAGMCZbbqP5hbjx/SEolvepsN3/4H82A?=
 =?us-ascii?Q?4Fpy1m/sKBQlzkfYctLabxKVw22BJ0lj7Wh9Fy8a63l5y3tN1mwPJMquc7pz?=
 =?us-ascii?Q?QEAr6bM/J9bCW0JTrxymV+jvPOxW9YjER/SH21Xm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4acc172-ad04-45df-7109-08de2273941e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:14:53.8333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ec1OeR1XWrgKYeV/A7cnxK1IaTnldK44Pq/HzDzaxCs4yrzgGVzSDUCDhqRhP41XWEXvr+ojuMM8A504tJAosQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9225
X-OriginatorOrg: intel.com

Hi Alexandre,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc5]
[cannot apply to next-20251112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Chartre/objtool-Move-disassembly-functions-to-a-separated-file/20251113-013604
base:   linus/master
patch link:    https://lore.kernel.org/r/20251112160315.2207947-15-alexandre.chartre%40oracle.com
patch subject: [PATCH v3 14/28] objtool: Improve tracing of alternative instructions
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20251113/202511130458.4jK2ZjK0-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511130458.4jK2ZjK0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202511130458.4jK2ZjK0-lkp@intel.com/

All errors (new ones prefixed by >>):

   check.c: In function 'validate_insn':
>> check.c:3663:29: error: 'trace' undeclared (first use in this function)
    3663 |                         if (trace) {
         |                             ^~~~~
   check.c:3663:29: note: each undeclared identifier is reported only once for each function it appears in
   make[5]: *** [tools/build/Makefile.build:85: tools/objtool/check.o] Error 1
   make[5]: Target '__build' not remade because of errors.
   make[4]: *** [Makefile:87: tools/objtool/objtool-in.o] Error 2
   make[4]: Target 'all' not remade because of errors.
   make[3]: *** [Makefile:73: objtool] Error 2
   make[2]: *** [Makefile:1449: tools/objtool] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


