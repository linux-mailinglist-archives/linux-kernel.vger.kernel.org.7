Return-Path: <linux-kernel+bounces-773072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23133B29B21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639EC18A5E73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250EB28640D;
	Mon, 18 Aug 2025 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPy3CypP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261022615
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503160; cv=fail; b=U3eNoBZMeD5k4yXsjDW5t3anIzCEDb0vHJV8tdWEBujRpHqSlODPOYeY9sR1I8nyIs8yYe3GnZYn1VHXvIqONwYQIPAemvbBrdAPtEgFGtbp+C0ZH1cQfyRnvSVdwIv/YRO5IZ5OWtg89xg8TDSc1T0eSjhl1co0aXVKnkVrPDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503160; c=relaxed/simple;
	bh=XNMMVTY6ALFoCq/QO8HLS43sdvWhpaMJNBQuW/qtSxc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A230pxYSfS5IpkeZxDhwWP7peU9UCZQ2/wsFaGse/Gdysb5/g9XUiSGSOy9zG9w/MmsY+2bjdnWMfVZkybw4MTI5XIpVPjaKwWyifdFnCRVvoJWiW9m5GK94hERAO21TmPwxRI3SfEvtlME/aj3U/cM5bu/uPqwC4jHGbr2XWJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPy3CypP; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755503158; x=1787039158;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XNMMVTY6ALFoCq/QO8HLS43sdvWhpaMJNBQuW/qtSxc=;
  b=FPy3CypPOEam/I/Zj94kJIevVmLlsG0T6IxIKpQCtdoLC/FX0U3bOuVH
   ISkqD2b/8NbzLLUAhnKsDv5ErVYqSMWdNWyZ+jUmMH/8nxGXEiWRBkgAK
   HKpAOJFMgoD7InULRwgJZaTTisNUDfgem6hiBgTQSzXIZFnKI7KDl9Tuw
   ZugDyCh4ScsIE/Yfqxz5niFVHN5JzxQW9sXN45mBX/BClQobjzoXO5mTO
   +nBSy3SOI7SfHDORnZvkNcbMldB2sLn70BAIm62wPkIluh5E815CsSvLB
   aMlV2Y4ciT8kF8mgCMYptwA27tDd4Wk5ckYuCnyMae4hnCD9J0vbH4C+i
   w==;
X-CSE-ConnectionGUID: MeYN3mMzTvuDw00a827luQ==
X-CSE-MsgGUID: 9WMwApfTQ22BtSZl+HTt9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57795406"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57795406"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 00:45:58 -0700
X-CSE-ConnectionGUID: zYh3JsjIS9KTgh8rSU7YJA==
X-CSE-MsgGUID: AXAUcZLJQjSgkykaSgIWvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166740987"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 00:45:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 00:45:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 00:45:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.63)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 00:45:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWsdTDODF3Ov1Jp03h6+JpzfB0U4l5tla358NFTk0Ut1BfZlvwTnMmeXfTCoH8DB6qiSmfhUuRboXO8xSvluoMPn/8hcmMxbVwc3Q9IMhChq1C3wT8SHarV9GD15NpNMMOOW7XIoRZCnWTERdRMYQDZyn+HScVVgmIzVwfk3WHkRxqfR3bJNEYtE39t970W/vt9BQHLfMAn1WcqVj3Dl2d1sjYGW6+QY0bCFu2IHoBc3ZTjG5cqiirsk++K++UnbRatk62xzPYsJWa6R4kLPs7v6NvbxCJWD0PaxwlikoQe8bWLsPbe34DeonBUXQl7a7BCrVej7JGDLuOnxhcRZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOPgP355uLMBc8SUqvgf9DZhB13Anug9bMtHza5vMMg=;
 b=aaMV/m2HnlcNX+rMXJD4jROfWevPfGVHYw3yr+pyXMqcO/DSYF1AfX24y41bfcAFdxHWODLA2OcPX0tALkw+B4turOiW4HUqSYPoU6wKzNbrnVzL7n5/Rd4dCMCwZciV8j3QGW7CL2ribof+axL8z5ow1vskijAevJcvopNEuiWRkdew3GSGc/CTFeGHuQNhcdGwMa4jmSeSnChK+9WyLRO3+sJ+CZJpqEyYa8rRF1RupgaxMPNtpjyplicnrl41pwrA021frIDRlravxnhLCXjqdt1mWZVhrUD6YrYmeZv3fyrz4ABdBTmdZwMOyOdswOx8h3cr+U6Qq8+ru+BVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 07:45:55 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 07:45:54 +0000
Date: Mon, 18 Aug 2025 15:45:39 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <colinmitchell@google.com>,
	<abusse@amazon.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] x86/microcode: Introduce staging step to reduce
 late-loading time
Message-ID: <aKLaIxtuobcwOMb2@intel.com>
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250813172649.15474-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250813172649.15474-2-chang.seok.bae@intel.com>
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c7df86-f215-4110-2635-08ddde2b4312
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WF2nmYQsk5NttMMNuJ2NcrvjshXJJNxrZh2vPS7Zb6k9mxVH5ztTIdMieBYZ?=
 =?us-ascii?Q?t4FI6t/AVwLiuta0tL5KWFuwFPIWB0Ax0byLaPffpgm7gdgsBv8efcIQ2PIz?=
 =?us-ascii?Q?Ic/dwQTjNmYxUOL5V6hqTAmHAXymubOZKA1hg/PFahsyS40GGb/lZK9We+V/?=
 =?us-ascii?Q?uFcagB66x/a+uwZvtrgb8rhJNuWWCPk53CF+iuJuPgYU9yXNwX2Yho7q8NAf?=
 =?us-ascii?Q?6vSgYFo1KBMR1gAo8TmITbthHBQsLMuGdWOnyCAGkpAMyuY/brBA0BtjY8nt?=
 =?us-ascii?Q?8Xq+S+eonYF+lZ6JfOE7piU7TY8yeeCrGSfv2eWGSc9d2IodiXQKx8rXQ/vd?=
 =?us-ascii?Q?h5J16BYrZAk6csLOzosdZ0mr94llelmgRSOxA3Ah0ba+ktkNtnhJOQhrZWY8?=
 =?us-ascii?Q?wOTZBaGTRm7H26almpD9dtTLlVg8eqUtHEkLRkEJ5Fx/U7Zj00XbGfAFWuYW?=
 =?us-ascii?Q?kZY5lWdxYqaOXFtwdbhOYdn4lRDXo8maxKgyN1hsc/BVbE3bK03x8JzgQD2p?=
 =?us-ascii?Q?DkQ/t8K8o8uKpFDbFRl1MWVvKk5FO0dTOhsvFp7xuNI+c2I94d8OlrdVGQKp?=
 =?us-ascii?Q?oVcUbmmp6xMCpRc/Bg1/TraooEGi83A3wzpEtWO2pbvbqWGMqgQxnkVfTMYW?=
 =?us-ascii?Q?sEgDBb29qokWgXSFXEd3XRUsUgMg3PTA98LQSAVCXgafxjOicWl9y2+XY7WG?=
 =?us-ascii?Q?4+34MrWMNZnu8Z/4VDEa7kg5BqKCq9dQmwHgEhkGeBoqbCUeOeUgyDJRxG4Z?=
 =?us-ascii?Q?kkD6GfhFFY2TRHYKWfLRkpi8HGC/kSoiM7FJ5BUhOGN6jU6TxJb4Sw95TQGd?=
 =?us-ascii?Q?BNqVn6R80xMH+7g06DIkZCbFMvzy0q6s+5IBjNGZbOMx2DWOuON8hbN6DcE9?=
 =?us-ascii?Q?qMchqidHSIDNvqDzE4pXWcwn2PedPpIISN2MWZVxBIWy9TdLO0ZcXIFhv8jx?=
 =?us-ascii?Q?M4H1173RSLegxOzEBhYUYdw966d5fsOIvqJc1ao/PgZmXKgOKr5Zux5Uxn0B?=
 =?us-ascii?Q?1c6qe8HvvsdDreB0EUlxBfT/z7tnqXzf3K9nAz039zwVfw4xL0dYt0h5TB2Q?=
 =?us-ascii?Q?KGQcCOJWvrNrdIwdcUcLN9YX7Q5O7fwqMro+0R7iML1chVuaEzGm+nnS7juW?=
 =?us-ascii?Q?TDHXYL2VTEQaDW2a76bo0bo49c3nhOSmHAPnYGTYPPsaP1PF1NXDnnvcVhl+?=
 =?us-ascii?Q?tx7D15jUNcNw4Oh+iaLkeJ/M/fLjGFytH08sfrtHZ2K8XJmx3A/xnDsk1jlX?=
 =?us-ascii?Q?JorbLkNmv0U3rbFZ5ebcLSaFWT1fmshRAtsyynwFdNWYfmNzspgOVzYcBK8R?=
 =?us-ascii?Q?Fb58OjcExZLxa7cObLu+qd7iQuX8ETYjh4D2+Q0msu1Vvd6PEzXomd/quQ99?=
 =?us-ascii?Q?NgfUYp/3BNNBAjsguBZrER29nPnsB5U0MwTn5l1cqCZjmamOx1t1RnGaTbYl?=
 =?us-ascii?Q?NezTK3P1KU0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3AryYMIenwaTOOOuxaRiur9HKxb0e1YpWnL0JjhsmLzKVgIytv68lwB0qH/s?=
 =?us-ascii?Q?2vZYtABl/+hsj48H/+8g3+XmOQHQ67KhH3byAXTMoC7ctc0ZLXEDd5t1goIN?=
 =?us-ascii?Q?IAu+5fpRfWLd0w2/GgXl4MuJRnRrshDGqKi9gQ+H7p0fslrW+H9CD2mvSLEc?=
 =?us-ascii?Q?h5ok00O3P4KH6lwMWx5tkPZBGWF0m92lzOJ1aGNc96loLWcV4hu/WvAkNBsA?=
 =?us-ascii?Q?ESN4jO8mGmvWelX5dN3J9fFUxkYX5D0io8l8V2sVJSgBvqQopcSQ/ohpVVyV?=
 =?us-ascii?Q?WPcuz1dMgrPvr0YiK9tlDpn+Y5SHC72x0pzIBYX9poq8Xitp3uuYvQGSOW0F?=
 =?us-ascii?Q?zmEKIFwjOEvRxIHsuvHvTr7CC+MCWaCQ9B5jkE8pDxjXegCTNrfF7C/P1Qe9?=
 =?us-ascii?Q?fsUdMPfIkuHZRnKuWMQzZFOSzVBqfDQoWZ3lrlcyRi/hA68Cb5qBjPVSInoC?=
 =?us-ascii?Q?q9BXB6h1UwumRHQep95CNOikOfCccMJT3nRzk3oBGaMUVop/Ue3UwV671bx8?=
 =?us-ascii?Q?eousxRfGotA8wc/us3XegpGLx8Uro5E8U8ZsbmMPr/jlaRwIOxuu1bx/INAg?=
 =?us-ascii?Q?99fu+B/HxZ+Ro5m/BIi4YeW1N0BDIr4h3EAEb4WjaxdlimDndDMox1B9dizb?=
 =?us-ascii?Q?ehAjcjzmZQOHJf8WkNcCFnl9jt+Dwh266tmtbGbgyOqHVvtomxmzchnc35Gq?=
 =?us-ascii?Q?MyApRatE38SMb/ur5kTe6Y7jVM1J+oAUGtW49yIAHaBpQNOhzUBLVDVSRCai?=
 =?us-ascii?Q?xLQMS9myjrCQdhts5GzK6QDwCBuDdujfYdW4ieCJSl1lBlzui5y6vlYsB34N?=
 =?us-ascii?Q?Fcrbn+QwFw6669zA6a03PhjOMGUK658RbgOS2q50CSmtkS3Fe8JeQmdIcDyK?=
 =?us-ascii?Q?X2qBfTvIOpZOG5gxqnsWOAEdC6k+13enRkJkccllfbvKIGJ2mO/0eKee/lLC?=
 =?us-ascii?Q?HUrH25vKYBjrCG/2E77uFBNYRkREi8xl4BNAGt1ZQO691vhid5f8m34/bHwn?=
 =?us-ascii?Q?7FvqFLqraQQIXsEzGF3S8VpKmUx8Q2X+jNuYfd1m1OCQ1a8oSlPkOVn+bEed?=
 =?us-ascii?Q?VAuZIKsBTmW7o1xOrLChLtfUEr5xsf/6w62sQFBPovjSGIHNOK0+6Yd2vwQ0?=
 =?us-ascii?Q?Pkrz9RR/aCF4jymeSQoJbYsNjs/ZIlBFl8gIKH11Qo0kY0sVWRzKUpKkpRLg?=
 =?us-ascii?Q?qGbL6YbhVM5WkBN0yE+nogtaHtbOj8bkh+j0PhyXRzAdDB7Kmh+S30Df9cQC?=
 =?us-ascii?Q?9i5ZXzXjoSeU3b2hfrlDW04WeBWYNNQBA5MMP7rQa25Ty4yGgYH33fOeqXvZ?=
 =?us-ascii?Q?oFZKe2E+WGa06tdmo/aLJulW+Ty0pds+mUHiy8F1JT+dDWF3k+uS+ISa3PG4?=
 =?us-ascii?Q?fQd7Iy1934FwM7ZwVCRc61BI27safPXAJVB0gfGch2PCpYdhSZvk7GEpBqiP?=
 =?us-ascii?Q?F77IQamlF8GXlNQRaxn+vC1yFseskmhe8/3LByazClsypkHH0NLlcD5w7IJe?=
 =?us-ascii?Q?bkyMz39iHcfFx5i0R9Qg+vkR/ZKQQhZhw9hMpp9vkx0IEBeyX0luOaxjsJdc?=
 =?us-ascii?Q?skYQAvskom2WyockjOFksMHn8+BMUoLpEkoRTkuI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c7df86-f215-4110-2635-08ddde2b4312
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:45:54.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +h0V/aGZKHCCZ3bUiuaQzqGYTi108nO2a7YRs+gTFr9VmuIehUmyMk6FLHK/FAUY3VtubVy2AGYLej77VUwysg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com

>+	/*
>+	 * Pre-load the microcode image into a staging device. This
>+	 * process is preemptible and does not require stopping CPUs.
>+	 * Successful staging simplifies the subsequent late-loading
>+	 * process, reducing rendezvous time.
>+	 *
>+	 * Even if the transfer fails, the update will proceed as usual.
>+	 */
>+	if (microcode_ops->use_staging)
>+		microcode_ops->stage_microcode();

->use_staging is not necessary. we can directly check if ->stage_microcode()
is NULL, or even add a stub function and then call ->stage_microcode()
unconditionally here. But since this pattern occurs only once in the series,
I don't have a strong preference.

If my review counts for anything,

Reviewed-by: Chao Gao <chao.gao@intel.com>

>+
> 	atomic_set(&late_cpus_in, num_online_cpus());
> 	atomic_set(&offline_in_nmi, 0);
> 	loops_per_usec = loops_per_jiffy / (TICK_NSEC / 1000);
>diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
>index 50a9702ae4e2..adf02ebbf7a3 100644
>--- a/arch/x86/kernel/cpu/microcode/internal.h
>+++ b/arch/x86/kernel/cpu/microcode/internal.h
>@@ -31,10 +31,12 @@ struct microcode_ops {
> 	 * See also the "Synchronization" section in microcode_core.c.
> 	 */
> 	enum ucode_state	(*apply_microcode)(int cpu);
>+	void			(*stage_microcode)(void);
> 	int			(*collect_cpu_info)(int cpu, struct cpu_signature *csig);
> 	void			(*finalize_late_load)(int result);
> 	unsigned int		nmi_safe	: 1,
>-				use_nmi		: 1;
>+				use_nmi		: 1,
>+				use_staging	: 1;
> };
> 
> struct early_load_data {
>-- 
>2.48.1
>

