Return-Path: <linux-kernel+bounces-870213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1849FC0A323
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 06:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3E43B0CEA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222A21E51EB;
	Sun, 26 Oct 2025 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkv59bo3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA1288D6
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761457792; cv=fail; b=VqCbRh4w+RxN4QB2cObPxrJNnXsgZOjSA6yf/A7Yi4/GWKR2YuiQIKSZbnAehkiksJ7X+hPrlR6ll2w0UK94iHrqzuEjBrryvOS6KMdndejLynjoodyWbJcT7GvjGU2SAK65PMQilLZ2Q7bmE8ge4AV9GiHLdubxOXpJ+UF8Z1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761457792; c=relaxed/simple;
	bh=D0nUUFOuG+X13jukJVpKmdGXDc0ImpEvj4esLQzCSMU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=mwLhmhRZsCNfGyT+GQ7NOozgowmChp2VYnbnWwL5F3R4KwswL0taDjLMwLIhHRdOGJ6hmGyfLY544UyrZ9ueREtfDkqJD/Mo7bxBMP9NS/xN8T0mvHFcAnP/ZK2CcSEoGnQ1O11Hk6CEY+4+guqjm/0+W2N3NvZtmtSTzHZuhcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkv59bo3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761457791; x=1792993791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D0nUUFOuG+X13jukJVpKmdGXDc0ImpEvj4esLQzCSMU=;
  b=kkv59bo3Y3N8AKBVG8sfUBHtqh6+BmOtVOWW0u+OkgEshgm6INqeFbU6
   Lm8/Wj5CsLLb4NyJg9b3oiwy/yzGiY5NKl9l1ZvCotWz8CbDud631Q55x
   z84RCTSHwZT1R6yO+KHND6Ffr8s7rH8SUm+QN+6EWgbMr5LPcb+F2D2pr
   RpS/xedtPfK3wNoO8GC/rE27F9Fumfgsy6pfw/2ZsiRM60Kom/GhyROfm
   L4HQXUVwRQ57fBPV+B+rwwKU9IdOicf8LtG/o2Fr0O1rUqycPWodHIzo0
   j+/kJTFBmPTmx2SNY6eLyH2bjv2PXQYSW5mY9PZmqtaBACLY6z2YG7fXS
   g==;
X-CSE-ConnectionGUID: +5lmYAr9SdWH3spTypP0kA==
X-CSE-MsgGUID: fom2bdNjRHWvUca2hIUJUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63610813"
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="63610813"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 22:49:50 -0700
X-CSE-ConnectionGUID: 8Rb8SLBZRAiPu3P48GgeTQ==
X-CSE-MsgGUID: gHuAzCBtRhar8u8wa9thug==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 22:49:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 25 Oct 2025 22:49:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 25 Oct 2025 22:49:49 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 25 Oct 2025 22:49:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZPFOQ0SKvHNq16VyairVRhlkNmzR85Wp1uRYKVMdHjrX3WiIvhC5u73PLUpLE5NJofdCWFYFX3NVlNrHaI1PxUGT+S8NEEAlQJ8lukShqnv4Cy/8mfDUzr14kgg3Hxx1t0mNn4PYiw1efYB1vwhTmwDb9x8d1wnOHcj6EZxKBhDka7fm/kgbOJOx2L3hs/prj26TctpKgGRNj+QU9OEdJPSzRzKDmYS+oqvf83SgW+f0bLlJxL1+Ive1euGPT4iojOkpHI7tlJmpclJ0NxXSuSeImLwZ54h1To3uFQZCfeL76melzAQGcHN6hJOev7YMNivbDct5U8McyjIXC5pMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z15lUe+04BBA9m08BhSO/pUvOWyvpo3UT2TAZZJtBck=;
 b=RJB2e94KKNuOuv3pg8+kcLQH/xV5jO3L5sfIYImvPIUTEmoVIsRCwooMHCa1IDH8hcoVw/8/OH9fBzpb/MZw2i0igD+KgUOORVcSw0na4Xo910heKx+Zr805F0/di/b4UTVtDjLHloMzAya/LNFUrvK3Ijbv5yjM21aLPjGveVulgoTKpPl9vXTZnMBPqcw2SKzsLwZUtznteszsp7f2VmC9/uiPILXm9+JJxbMQGPF4JGFAtWVUxM7/vQ8y4/4ZqxHcGeCJ5kwEBn1oqOMp0y/EBaL8EpuDCOkYNsoHr8d6QGoOLa0UAYZJRMzTxVhLJwBLanlsW/3Vpk264UyF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sun, 26 Oct
 2025 05:49:47 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9253.011; Sun, 26 Oct 2025
 05:49:47 +0000
Date: Sun, 26 Oct 2025 13:49:40 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: file_stressor.c:5:10: fatal error: fcntl.h: No such file or directory
Message-ID: <aP22dARKJEKgj3Ne@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|DS7PR11MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6734d671-1ea4-4625-0000-08de145378d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5FShS4uTBx1kBg4AjmoJl+x8LbQnTxhiY3jQ1nxgTtwZP//Tc0ZrYaexD9yI?=
 =?us-ascii?Q?SGpqhBQgl+rZgWuAer1ABUQW1QaVg8SLDnOpPcdD4dsmEoyXczT8uSVoF2VQ?=
 =?us-ascii?Q?LYPDuf30+Jq81EehFUoYoUYCNYuRAyzZNV3DhGtiJatbDLqJrLYpLuydLW+C?=
 =?us-ascii?Q?FE7H785JydJBMBw45lD4k5U2xvYuZjGV6orgib34nB5G5e3EgukQS30ei5a2?=
 =?us-ascii?Q?Dd7L9IsRlCMBvKSzXLjEiCAyvahirzNimTAYvozEBqIOe83U0ftTfg/tZgav?=
 =?us-ascii?Q?bDKXD3fuifktnvnvJ1Rb25u+E9GtEGnWKj4WOHBzTmmthQWh2fJ72OiDZ/Yz?=
 =?us-ascii?Q?EEuaOjUm7RaFWR6Z1sAOwSoy6KLlF9Sq4157GkynpraEGapQhbkEFiq0EpDY?=
 =?us-ascii?Q?ukDCO+lkn/JzIUt84ieXupsWbDufoZ/6nvGjeLsyYo5+WSYKGb0I68JOy5x0?=
 =?us-ascii?Q?BAiGcO7bO6TbKC6zriZpZdr/Ugr87KZgBbPmW647Tom6qLRLXYzn/WPt5o6u?=
 =?us-ascii?Q?2DnwhniHXDoTY8nE+dMz/X8jwrJw4xR4nWO1vqNJmeLlar/TJy2nUvapVXuN?=
 =?us-ascii?Q?abfXH2uDZgkeyyW45TQeDxW+BejhRmhfhfQWTP0tCGsUMxZguBTwbpxxSMi7?=
 =?us-ascii?Q?WP1wkhP/ApfzcB+wQEEyrdjnwGgnSBIEv/XN0h6qynZE8hikmRC6hGHaNM5J?=
 =?us-ascii?Q?WWM1oqNW4Z6T6lILTPZEpljxhlQjydBlSwfRk1hMwKimBn8fudu4inA8zJhY?=
 =?us-ascii?Q?a8KTyLqlMji29ZMwVi3L1Eezzx9FLlMNtoNKBg97pmF3VhCMztYjnrG/GdnV?=
 =?us-ascii?Q?pFDNoYmygg/aSnwkDu30jCnl5Aq0XXfbEjfQNUC6iQrsQzfmWz44+Z12EKXO?=
 =?us-ascii?Q?8DOriSwei16VXq2C3iu4sK+ztCW5z7IAnCTbwjjLP5/Du5pcEPjMH2G3pki/?=
 =?us-ascii?Q?9EVc41yr/zxZeOe8X0s+ftC6/ajjFmGpLdcswNaxRsABveRjmtmiW5f0Tngk?=
 =?us-ascii?Q?GCKUimHlIRZtzqZ9Q/RbhFdmK4RmOA8WCrUL7BOGnVvpmpdm0wFtfTskRmCo?=
 =?us-ascii?Q?cBDMygv18D9r+ERNPfXcnPYg7PpjsuxIiHf5CadvipgmWK5YsD6tkvB3yqWl?=
 =?us-ascii?Q?coFC5E8eMXXzDtKsDNSMErXSladhpY60g8cP+XS7cENAhoTHJlH8TdHZGbPl?=
 =?us-ascii?Q?Dk20IgCW9vp0gvKJAomYqttQm/8H7AYudMGbyIXoXWV2wkbEQpZWrxUczAxl?=
 =?us-ascii?Q?fhG6jf5d02IaVSu4P6h/W/x4HX51edh3VxMXo3MvxHU8Q9WKFg26AAeF93a3?=
 =?us-ascii?Q?MLXcOemaDg5bTaCGY0lCfUphXX9R/MoGcyQpeoO+HvY5w3fumc8j8XTbFEkR?=
 =?us-ascii?Q?wOltflkEOaru3s0+JUfRrl3dRk2IpEuLfwLAYGmV2exVcGlrUAAPW8Qzt0zo?=
 =?us-ascii?Q?4Dt3ngHXBEESm4LJgI8OXA7zATMnR1h4K+nDRP1f+y42Nkg1BaC/Cw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GnhdXZU+1O0tXP4g06z6fX7Q5HOBXPczsgcBOwwkXb2ufxmbaC9mhUwwwlCh?=
 =?us-ascii?Q?N5Dxxx7UpDgGoSd9m9JQFt47hD6Gt/8G22xck1u/qFr5OBPnsWNXyTGm12xR?=
 =?us-ascii?Q?fC4fSeNi7nhGMiK/DVliw/t6JI8W6Vuf0qOxmlmFJBn8qjtWsAlSA7cm10yC?=
 =?us-ascii?Q?DEE3CjJ0wCezPw34u+yWGXUvbZADzz40jRUzlnt/fsxYt5MfbbVjKlH/OEjn?=
 =?us-ascii?Q?umGa967plS3EHmmSBTlY0T5/YvLLpFe1w6jiMjZEFuMfuQh634X/4FAu+JqA?=
 =?us-ascii?Q?3ROI/qJe0LOsA5pE1+lE9OEK/rAQUPl5P+Y1gLAzefw1dJxA/KkQUtGosfUk?=
 =?us-ascii?Q?VL5mBlPEVzYQxnne7Pmb2ThiXPT4zgcUiI+5s+6FAlY8/VYh+hzJhx5JAXvB?=
 =?us-ascii?Q?V9HxZEx4KDExHdrAs0xX/g7zzhy8jt3VnCvXSCMv6I3mon2Rrz4ElDlNmkp/?=
 =?us-ascii?Q?JnWWMcjnelflp10RxqiZoqCrgYsQCbSFoUfOxAMbL+YTC+ISMh+D9y0Ll4qf?=
 =?us-ascii?Q?tjRtRxK2eZ+YI4gUQEu3+4wRXw0bU5HUQqmY2xO7jZFPVUsevOQvEIzEfdfz?=
 =?us-ascii?Q?h2JSoN4XHOSqDWeu8zfdcSgvAZwwZYTqH8/e1xyfBNANcfCkI77iCdZ5ak/S?=
 =?us-ascii?Q?Q5UW2HaK5wSB52OAQtmwPcYh72K3YoL/orFAoTnlmzkHeV3TKRaNFiOAmFxW?=
 =?us-ascii?Q?/aRipfMKPCV2UDqmJhzWQ7EP8z0my87TyF14aGEYe9XwVWko3F1qtv59Jrst?=
 =?us-ascii?Q?s5dOZBhVb7TcUA6+W2Iz5NLFZhWq9i+Ybr1nC+aVWU6mSg7ufuZmFciHbG9S?=
 =?us-ascii?Q?sAKBR0jv0tJIGXsvKqPtgAmpNX1vxhJ6445/tUGrnfcXG1Ut/WF7um0pf6rs?=
 =?us-ascii?Q?Z9CO+NIE9wE9YKKwyBtgLZpOgp2iTBYm/igpkYO/egq/+p2BcBvaO3ir54AA?=
 =?us-ascii?Q?cQKEW9DLIp13N5x6ugIIgmiS9ZTb7EG9id8NtOwFpuXOH5BUv0RAaxxY7MW0?=
 =?us-ascii?Q?iEzdDYMDXycVnT3NC0ZwWS/MlMYSHiGyYvJoTmmTus/f+APfDoickh5NzHPA?=
 =?us-ascii?Q?gqg60gE+Vsa2YNNPxVyICavnZ8hKNlp0gLM1alb8OYUQWo4AiJEhbgqe9XEh?=
 =?us-ascii?Q?3qJt3CIal+Bvsi5mWuqHwn2VTlAn4Sk0h1f+nLy2nrpCVC4VrspHc87U0ujN?=
 =?us-ascii?Q?6XrHiZsb8HlQsBen+CmNASVMGngW036NGtKUACt01eAGhPoDljcAnyaSaoRt?=
 =?us-ascii?Q?v35cPocogA0cjWHZ72UfwBNZf4oEWoy43VH8Z4WOdTVsupwJ3efAZ1759H+V?=
 =?us-ascii?Q?I5CmqaFss1APOJbJ3TxyrXkorBZrgXSP1MCkVOckOgUvOqXaPrtgWH0aBYw6?=
 =?us-ascii?Q?Dfocwr7OP1fJVDCXG89ZELo9xOY5K0mjeUpO0pTP+Fgfj2Mv8bgMMa1PXkmE?=
 =?us-ascii?Q?q6rn0/C1fqlzw0b3fLbOrmxZx3+iSxZlFfu4Ybj8xQXEqBhiBwOdbdlbtfiy?=
 =?us-ascii?Q?FQZhmfwTfZLMX9jdgxuZ9wEzTLnMdf5VptHKeE/VjYzWiQwKb5H9myr+A0bd?=
 =?us-ascii?Q?IFJf8A2OGXIsXjO9ahY/YUnDiY4u+kmvX4u9/fDz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6734d671-1ea4-4625-0000-08de145378d1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 05:49:47.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3Gngky+Qwby9daVDD01uT4wVXi1kapbDkzXHhH+w8Iz/kW0sMp7RCIflKKgtk9vHbKWSFewLANqI4VYYYPk9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9bb956508c9d94935bedba4f13901fb2b7468e91
commit: aab154a442f9ba2a08fc130dbc8d178a33e10345 selftests: add file SLAB_TYPESAFE_BY_RCU recycling stressor
date:   12 months ago
:::::: branch date: 3 hours ago
:::::: commit date: 12 months ago
config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251026/202510260349.tkX3fc9v-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510260349.tkX3fc9v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510260349.tkX3fc9v-lkp@intel.com/

All errors (new ones prefixed by >>):

>> file_stressor.c:5:10: fatal error: fcntl.h: No such file or directory
       5 | #include <fcntl.h>
         |          ^~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


