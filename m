Return-Path: <linux-kernel+bounces-898693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509DC55C88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4C43AD89F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF426D4D4;
	Thu, 13 Nov 2025 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKoJZqjq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4724E4A1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010927; cv=fail; b=vFAVQTVz5guiHVJtf49RdmjCtiNReU4Zzd7A2bbQDiGb/0E0MgkjGvPiWulRF6QN0gBm0zwoPJmFmytTyYX4D3LzluTbOwQbX4j/pXyEMri7VWlleush0KLhlrRjvq2IuWDGcySYmwO64860j8FgRNq11fpJwusx9BqmO0cxDjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010927; c=relaxed/simple;
	bh=0SG4O/sfXxbirKQjj7hI+b1g9V0vPGssxR7se5VI8O0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UFIvNLNaeumTE937orb14ru9e1EPUe+xVAGvBHxqzIIBKNRn2SjULVKqW/IWU9sKMeNjoREoKH+KkO79QR+p8O1aR3NL5L1Cc2NLxURxAxbmnjbjOlYv6kNUdxvlQ3Sc7dx4fYg5wAGTk+e28N5p5oY5EqFYKYS3K+C/uooiB6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKoJZqjq; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763010926; x=1794546926;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=0SG4O/sfXxbirKQjj7hI+b1g9V0vPGssxR7se5VI8O0=;
  b=SKoJZqjq26YO0K2mDiN6uSRqa7ougkDkQs5HI4U7kJ4tiENyfr1wMSpM
   avB5pFP/2e5a7fOLyantf/aG+gk2InXeoDZDllDsID+qRIdsRc85VTpzn
   Sb22bb0uHdGAEEFvB1lzum/yWUUnkxUwZXqiSv2wzL7ioCOLM74RTUnHT
   KPfn5T/S4tKhK3VG1EC7VPi9qc6l7gtS6PCGWMnn5vawHVa3yM8OMv3X6
   MXIV8vaeTFk98hJ7ZxNz0SReapPMRtTTYFpATEtNSYS6yxf6fJx6V2Nlg
   vj88RHKSS79MDNz2+my1y+cyrRsIKZAn/lywgT0OG/eba5Fw57RJh+UB3
   A==;
X-CSE-ConnectionGUID: ULpbc96RT66OJh6YU7GFXg==
X-CSE-MsgGUID: +kNZiS52Ti2Tvu0TGcu1Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="65116403"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="65116403"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 21:15:25 -0800
X-CSE-ConnectionGUID: q9Ujmb1HSAaR26ioBdTICA==
X-CSE-MsgGUID: YDG/8ra6QA+AHAx9obUIqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="212791643"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 21:15:24 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 21:15:23 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 21:15:23 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 21:15:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voojIG5gltElVDEro5PaiPklQXiwSQjNtJmFi888YF9k885UEP+zemcaoAvVAtFb/oxq/gv3guOkJDv1NZmZCI1BAZikV/Kfbrd0hYPQoLJO4jra6F8bEyLW4V7fJ6Uw/GcBz+9VN0rNBCKXK5SvcLdbJUykx2hX5dbDhCGSqgHUuDN65bMc9K4eh1Cjop4Fuk1pKmFfbI6gooSvh7PwT3ZImemaj3I48eOblHgp/rNQw5Wej4GIN6TXwm2NUCC/S7Jm7ymXu75OT4Gunhb/qew1eAr0Zug1E7XlmCb9lgzUhuZX9m3C+/WfucwPPQaK8Tp7W2uAjIn8eDqxp3LzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NjoFENeVmUoazMt+04V5xizEwt2LLWOytQmtG4e7zo=;
 b=IL2+pAf9GYUahP0humVdJd5qbmFTfo7Te6EHblfqGqTh4vSjOCdBbr4jncU90w5yKVVMvOn5luArtqBqVudDNGBj+ekUdzXPfK0ZR/qYR/gIzf5kSrKZyQ78LDeWMTcxGSRYDO/v05ynQKGgE+dcgxSmgG7tc4Wbkgz0E/6e9pTuZVEq4gAjh/bT8dJXIj/JivnixxiuqBAaFdHTZK1KxRuplCQZCCej45gh24pVKb55Co6+keTu8bFIwmyxB8+Oy8mtxD3rg+7S6tdeBQqVtOfOpaQdUSgtsZ//HzSK9zndsg67tMElnw5V4qeAEYpZ5p1c+lfe2NvUaOQyGyRCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by IA3PR11MB9225.namprd11.prod.outlook.com (2603:10b6:208:570::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 05:15:16 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 05:15:16 +0000
Date: Thu, 13 Nov 2025 13:15:07 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Chartre <alexandre.chartre@oracle.com>,
	<linux-kernel@vger.kernel.org>, <mingo@kernel.org>, <jpoimboe@kernel.org>,
	<peterz@infradead.org>
CC: <oe-kbuild-all@lists.linux.dev>, <alexandre.chartre@oracle.com>
Subject: Re: [PATCH v3 25/28] objtool: Improve naming of group alternatives
Message-ID: <aRVpW0NSPeEkkhu9@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112160315.2207947-26-alexandre.chartre@oracle.com>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
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
X-MS-Office365-Filtering-Correlation-Id: 1c151688-a037-4e63-2d0d-08de2273a180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uSiOugrWjHXZGFfDVVESWd1WoqGnYrGcFxi3AvmY60KhgHSrhQ6wp7O7rDzP?=
 =?us-ascii?Q?q8xeq/xsQGvDXUL4O8AIhpXgmpbD7mjf9O9fWTzl2EtKKHTyw+vluo76GMg1?=
 =?us-ascii?Q?U+qZXmpwHwPVJlUBHV0w7CDuwea0f8L6eG6vq8nygbFM5CbUCxyMjX8Pw/D4?=
 =?us-ascii?Q?s5WvGdnh1f+UaUleBJYCqi0ysBSM2hOCgKCN4ozky0EpO4AH7A8iPO4aiTz6?=
 =?us-ascii?Q?PeXpwPSTUTU1BbQalhBsMUyIWsOnnTt4OzKHxMzGDs08l46ChNmAg0q5FFJt?=
 =?us-ascii?Q?IMAbsjX+OzshjEGNlsmJFVXpDJWxMBEfm37qXLwsx/tmCyS20PL76WTwCCOQ?=
 =?us-ascii?Q?zFyX45sdAo9rBnu7AMDD+sge5X9JrZ96YI8uxejUf/VAf3pjsh/biQ7QgGV4?=
 =?us-ascii?Q?4VgcUshjCtUzqyyAkv2Zb5qQihsRmV3Lrwtor4CgF/OxNK3CRJay6AbkGdS/?=
 =?us-ascii?Q?OVu6e9/J22Eba+JTTJRB4FnKJOLqMK8K2ZSott32yegZYVsF6Syn688rBvmG?=
 =?us-ascii?Q?kqqysrIxQ++INeNzEW/blwLUywa452twNXM4NBN+XqavccGPs24fcfKHAiPH?=
 =?us-ascii?Q?cpfKY7BchHsGOG8ec9MsljZfuOKKzs8EcnHCijqdVv9sMSAkX8d0q7gG2f+U?=
 =?us-ascii?Q?zVxEdeHpObSDDSS8XTD6SWLiW/BOv6yGqB4UO6tZWRdZ+SRWTFFo7Q3FLKUc?=
 =?us-ascii?Q?4OLwhom7KbatesmiZ4rEOdGnHF2tVddJ733GXImcvDiWJPMceoi1YC9Ur2qx?=
 =?us-ascii?Q?dcopFhGab1lSGIZtrsD1RkArSAJbIbNOdkOh3xC08N1Va9GVN7O4aPM2lYRv?=
 =?us-ascii?Q?L+v0TBhZkFOFhJjCV3gAAuqYU9Kk4DrUWpX3cl4uyCh5XMM6uj6Dv5x40H1K?=
 =?us-ascii?Q?FbvHbkBLHjeiMQe/iMMi0WGgi66tlQ8nhhvvz8b6nV3+EM61QLfyqWZQbVvW?=
 =?us-ascii?Q?jmauAvmS4b8MPGcNMmmRxyQm0xdVC2cokytD1V9lcve4EY1eEzIyvi3ZARc6?=
 =?us-ascii?Q?/ZzgJCQ0ZXKETaaHEoNNoFcBNTOgw6B6CuEFNV98M5lTR5rEqQiNZyCegePN?=
 =?us-ascii?Q?czaFbUYJyBle/LfbHc8cUPe1Ac3rtyZKuyyYkeoDmrgTqWvj+GkxGKK/5UXF?=
 =?us-ascii?Q?92EMsx8c9qD1BwVmwttWKTnDXdJIWTfUpN94teYQEDvlqqf0v1rDL0bZbXZP?=
 =?us-ascii?Q?7W3gviUsI7+0aNlPI4OZn08kXKkP+rQbWU21SlG0vkTUCvTFrS0eRrULjwRx?=
 =?us-ascii?Q?m5jWBEadg/qPLkaXXX5Z8ZogAR3DguwBlr1cPUGVYKyimKTygQjml6isd2Wd?=
 =?us-ascii?Q?1dg21ggZRDvsFhbRajIe5BYsoUUCSC6GfMYN79LVuHb9hB6GLiPvNpkAThyP?=
 =?us-ascii?Q?kbUY29eyseOwm5mlSOBFxM/qQ68oJJHmxjveEzwmD6eixMAvLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kJPzuqGYcOyQqwuWPPAkOAQwvMpeA+aKE+PMoR6NfsdGYKWtevxuWXuqaaWI?=
 =?us-ascii?Q?weD2GjTtDpmQk8ON8r3Acs2x2J3zcy5oKVKerwnXuKgBO0FYQJbc117NEnse?=
 =?us-ascii?Q?tRz8EY2grtAsqslCPKDd4/O/Jjd2wQzhUiKfdQrtE4WxW3PLFSrTgihW5B4L?=
 =?us-ascii?Q?9/U1KnjlGY6a387f82TBkIxSKIa0YCMNLQv2tudCt6tJkttZRoOX3z0ImTFA?=
 =?us-ascii?Q?Dh6jCZfGVqyHPSsYuzrakHxwWKUQzVTqosIv2K7hh3ub3hBp0VaNxwfsuvcG?=
 =?us-ascii?Q?E2yVrKTSP61NhFCG0AoyY0onEHXGdGceLWSfvc8PTqYi/06pLAfxjKBpFsSW?=
 =?us-ascii?Q?VsSDtj5GLFTHaYbesjFiEbAezp5JKs8BJqoced3U15CMCaI+tFi4dKH439+S?=
 =?us-ascii?Q?sEimH6Pkq7hfDxoTSxpQiSwfM9MJLIwBuBXmGRyGR9vjkq73hsBsGMkdzQsF?=
 =?us-ascii?Q?SXI7hd7LkgvznjgpkKcBr7RC6AWd56sqXRCLssECBsRHULB0lDJ0vfN+Rmh3?=
 =?us-ascii?Q?MiS0c044320rmdIpEu02ZHGZFIJ0qJKn9To3eI9cgIatmxeCCv3VQRP85Dfm?=
 =?us-ascii?Q?gD4w14AF0oiWfI0/K0CROSZZk0VRWvRuglyLyit5upRw/dsByxt9x3kp2+Nv?=
 =?us-ascii?Q?wf62/Uimzoc/YNHZIP5Wi92i+F5FiNJ3A3QHEevJ32ld+wVKLfciuVxirNS1?=
 =?us-ascii?Q?v+hPXa/PkrfucxjedM44uCFESerWie8l3XePevnVgeeN7CwBWDqA3X3jEMCw?=
 =?us-ascii?Q?4cHTZMSmOfD/EksnlspC7cEM3hvKslIS3Sx6gKT/UpZ2+0Ar3o/J7DB2dJCO?=
 =?us-ascii?Q?ZdKXO4GQGimBzl1NIoBO5dHylm29ylATjMIHgeCCBt1eq0ZRFEa0cocsPf7W?=
 =?us-ascii?Q?5fm+Lc14djyY4NvXlrccPN/GQS6niURErhhDBCv71mifufREcH7y+SQa9LIi?=
 =?us-ascii?Q?o8fsiw7bYr8TYc6zmxLi9K92YndcAN+Sp0xztNEN6frcrlYm0CEh1XfZXpUD?=
 =?us-ascii?Q?c5E+NMCwGsBQNsL9iQMQOzykkgziNJFR0xnAJNLnApUIxGPXHLn8u77iy40/?=
 =?us-ascii?Q?Yc7yAUXJf6AmDfvdaI+J99pYUrRxaLClsgaAN9eUE/tQGRqYr4oQMijbH/+Y?=
 =?us-ascii?Q?BcS8mKfnbgsOIc838SgZUT0EECQfBDw5I2Xq3Y9Xy8XMDtb5VT2go95vrqK1?=
 =?us-ascii?Q?I0EddHuP9myZ2k/BvwanPXFbBbADfFiZhDZwbrByae9pjinjmM+BKHJYRJEu?=
 =?us-ascii?Q?IrQiarGPajmUL2mmkJm7wW/UrSKqmXlkFfpnPC8591vy1/MbdiagHVrQdsIz?=
 =?us-ascii?Q?GXTCJ7moL5gB/PLGr8b2Jdy8rCNku19RuK6IPmE1wfsl4xBLkqp+GoQ5a/0E?=
 =?us-ascii?Q?1PnBDl1wglgO0ZtmY0jqSEqHYqLU8LK/UoCi2TEQdQT9rj6ZUS09cEbG6VMy?=
 =?us-ascii?Q?FN3+fb1fOs/G6u1N7wY290tCk+bERDC6GNLFsvSHTze9fCE9M7yg7AdyVhHx?=
 =?us-ascii?Q?hN6m8fvekns3T/HOu9vSNqjV15YLxddNYzkGWhHyUj8WB2OTxqynvIhCLHDA?=
 =?us-ascii?Q?MKQNUG3l9hq+aOdSc3pKFgOjpmb2jWvIjh3h+TIq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c151688-a037-4e63-2d0d-08de2273a180
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:15:16.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifu2mjZUq5EYUQhJGEjIHFYOvr7TFqmVTrhw4NdO+iZJq/RSCvq03SQnXgH2kIuf5L9U2cnXSfZK8q/22QhlZg==
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
patch link:    https://lore.kernel.org/r/20251112160315.2207947-26-alexandre.chartre%40oracle.com
patch subject: [PATCH v3 25/28] objtool: Improve naming of group alternatives
:::::: branch date: 6 hours ago
:::::: commit date: 6 hours ago
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20251113/202511130627.2BQemoMP-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511130627.2BQemoMP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202511130627.2BQemoMP-lkp@intel.com/

All errors (new ones prefixed by >>):

   check.c: In function 'validate_insn':
   check.c:3656:29: error: 'trace' undeclared (first use in this function)
    3656 |                         if (trace) {
         |                             ^~~~~
   check.c:3656:29: note: each undeclared identifier is reported only once for each function it appears in
>> check.c:3657:44: error: implicit declaration of function 'disas_alt_name' [-Wimplicit-function-declaration]
    3657 |                                 alt_name = disas_alt_name(alt);
         |                                            ^~~~~~~~~~~~~~
>> check.c:3657:42: error: assignment to 'char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    3657 |                                 alt_name = disas_alt_name(alt);
         |                                          ^
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


