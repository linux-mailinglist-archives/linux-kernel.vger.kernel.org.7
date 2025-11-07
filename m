Return-Path: <linux-kernel+bounces-890166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD357C3F5E9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBB63B33A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A88302753;
	Fri,  7 Nov 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiGL9nua"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00322BE034
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510580; cv=fail; b=Sl1CYFW91UXo8lLS5Jzn2yBOGPAnm3oMuZO3eBkz2QiDvXZOzVmgS2wn2NtG9smmYSSk/PNVfKKafnk75OBh6YoMeKXbbprTMMVkIt5uZ3CgF8Rdehv3KQ1/KOG/lcN05CY2NFjlqSay0s3j+M8vAWWz4AezhHtelEivBNpBVw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510580; c=relaxed/simple;
	bh=vbNlKNYreHn+sTRTlj3eZ+e7nJt3Uq4nml2MUOcGygE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JwPvdYDUACWiatVoXRWQ0mU2qt9M9UYD3f8zGlB/kYsqOjn7NL9IPZV6bjGgViSfeR6FpW3gblkpAt8OUR8mtTw7kegTt8F70lAeTZqeIaKnH5ijdOAjEbfvszXW7xQU6vLp1d4RZC7MpeigZUFpS2QEcm98Ah4lSOgi7kWVAIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiGL9nua; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762510579; x=1794046579;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vbNlKNYreHn+sTRTlj3eZ+e7nJt3Uq4nml2MUOcGygE=;
  b=QiGL9nua/VMufp2zs79BK8SjMrY0uHOdrxLnry4lQFF1WNRbEL8rq3Vy
   v2O+FuwoFuiErWpuUR1efBzryvubHcESx02BO0pxqRCeX2yWDa7aM8qtZ
   Eb/P8qAR8ff8vXsaDVDeZ4eB5wBmiX7To40ISi7r1U08NSF3Bmwxmvsgy
   9E80mfsfCC2vm8ahTUxqdX0Tlqck+IizmjBvCOU0IMxrO8pPYuGIF3phh
   z+MXVVze9MgSDRMJ1FZlzZh0f4gElmOzBfBc3uQ5nhb2kNoZre9Do0uRs
   JmBL9kUKuD6BynvXDYRMGx44Dx11/lKij8y82cgq73NFIlGpXBNw9J3JF
   A==;
X-CSE-ConnectionGUID: Icfnd9dCQWKgQ85ixpITSw==
X-CSE-MsgGUID: GxxBxQGjSbqTfgJ+hEzxvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="68498026"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="68498026"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 02:16:16 -0800
X-CSE-ConnectionGUID: ivCD3T9jQPOj6dblJRsjcg==
X-CSE-MsgGUID: gmW7paTKQP2sUwIeEGC8rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="211448447"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 02:16:16 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 02:16:15 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 02:16:15 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 02:16:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUAHYgUNg28XggN5/nZjbAqtqeUt5gGsBYS8xNbmDzgguGwbW5vZphSnjh72hpt7GHrb7AoeX5K6ck3o6WtPrRs3Cq2mqb0j7z2i2vFoBlvIzYGeqEPA4Xqc3rl72AtM0wLz7wGDpH7+WiM/b3tpBDh8chGNGXHW2dDjt7cPB04tYrWK2hFNwHz7EKKKY87QVk+C15H1Ip7JnVBbcyg74bHDvqIAnnKsfZgaS4+QpqnCzQNawdIdgFyirnvinBOiSDpGshTWyo6ZObE0GTHltvlgeZ/tDAn6u2NlumvPwbNhi56h7f/QjkFAJG81B+58Hy9KUxC5gi4PWtxzK0xrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ckrl3A2J/q25wzZyHur4BDs/M/gz+VZH1NEtkvV0Qc4=;
 b=IRqFdWBs0Tl1TxEXnQoaZ5N0QDfzY+I7u2XPcN/z/Kmjcfts/+XDyTd3DbwTcYLKBsqCTA6vHV1Yr4QZUd/iWGiQAgZtui05tYHvI3fGVY4cdS70AbWMTgNdJxzo6cAMHCzd2fb8NtGSiEV9Ks+HiJ+hSd/ZWtiJ8jdCa2ogaG2731MgQ9WCN4+9ZnbHJIEfEbn5QERfe7ZVls0Msk3DnhDaPiVwDv3UIeMJqaw3q9q0JBcI7vnl3lMYqCactIXCsanUZnzdPSwB1Z4KvkqHRX/EKRPlHTXRt5luVr6h5yU7wiTwOsc7xQpvzLWNbB7k3l0cyU6liIlRLICPize78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by BL4PR11MB8824.namprd11.prod.outlook.com (2603:10b6:208:5a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 10:16:12 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Fri, 7 Nov 2025
 10:16:12 +0000
Date: Fri, 7 Nov 2025 18:16:03 +0800
From: Philip Li <philip.li@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "Chen, Yu C" <yu.c.chen@intel.com>, kernel test robot
	<oliver.sang@intel.com>, Fernand Sieber <sieberf@amazon.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <aubrey.li@linux.intel.com>
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <aQ3G44fqJG378pM1@rli9-mobl>
References: <202510211205.1e0f5223-lkp@intel.com>
 <20251021110449.GO3245006@noisy.programming.kicks-ass.net>
 <20251027125453.GY4067720@noisy.programming.kicks-ass.net>
 <3b30e40b-f1fb-4145-b4d9-a9279b9602d8@intel.com>
 <20251027135516.GA3419281@noisy.programming.kicks-ass.net>
 <20251027140718.GT1386988@noisy.programming.kicks-ass.net>
 <20251027140959.GU1386988@noisy.programming.kicks-ass.net>
 <e9f705f3-3a8f-4952-b5d5-e36f4fa1515d@intel.com>
 <20251105110026.GI988547@noisy.programming.kicks-ass.net>
 <aQs9yFQloF9aFCbA@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQs9yFQloF9aFCbA@rli9-mobl>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|BL4PR11MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8ed30e-2959-47eb-5f87-08de1de6ad6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oxDJV54cTr0GVl6D9Kjwce+VA6jLvzYwkLXNWLSDvjnN96SU7/UnReM4x9gp?=
 =?us-ascii?Q?wYBP2zpl6UMKtsdCZJnmLXAk5OmjcMMDhXlInCsGQQT5ARBI2Wcbi5SB00oU?=
 =?us-ascii?Q?PPqal1NTLpOdRVvKP+158wRQ656eAQYfusw4Y94kEJ2UyCJ8JgzIe0alyt2o?=
 =?us-ascii?Q?sbAO6oT6BzRMujV8bXpWMPuP6yn8ev5fxT6CM7juQ/TvTTC/RvOEI2nBTys2?=
 =?us-ascii?Q?f+rvqBLpMf8IRpEX3FEHRRaEKXj1BzsAcWylM9dozJLX5cZZWZwPQpq9g5eL?=
 =?us-ascii?Q?mY7nEcGXQovwbhQI/8AwfXS8O5E3od55YkMKRHLHJJF6sm1Hrk+XCOPGgDQK?=
 =?us-ascii?Q?DKvooCd3h99P7MFIzzPU/VQ5y93rEO08fJomGZ/+SRkRKP3ihDIWGiRb5Om0?=
 =?us-ascii?Q?wZ4whrRbEd4w4MCmiYORP5VDGPLeD4/NDboVf8XnL87DeQlnXR7XoWlXGtn5?=
 =?us-ascii?Q?3CHtiglyhxdiehXoucHFOw+hFCJxbN+ya/ILH1tHRKB+K8ZSuYb7I0Gm1Jbi?=
 =?us-ascii?Q?53Tdq++zJDRGX7vzS2y8ll7B/KGIZNzEEsu4ri4v6emGPhJhRp+6E+QrSCkg?=
 =?us-ascii?Q?q+eRkBznS4uyKGF/Cd8VKT8xfPKEuYahtvh1yLu6ieXxtu3uQz1hgC8WFp/3?=
 =?us-ascii?Q?F8ag52OyR30wdoNHl1g6UXDtR8cZllItNEEMJqGT19AlQirfgmlvPAobtXUu?=
 =?us-ascii?Q?4X8PHSnikKQKGlEdVnhrXgWSDeH0/JfXvtu+4hV82yzGOkCBxQUS32tzS1jV?=
 =?us-ascii?Q?BN9M0atHKnWTd++pI0toIsrVmedAQPT9/tG3s9ihER5JqFVV09XbrkIGcVDl?=
 =?us-ascii?Q?2rBFuEG0GkiOVgLrLEsOAuJs7e2pE2AU0Zz3Df32rYZNLPVU2sOR2N/2h/GS?=
 =?us-ascii?Q?2AmWuFApSUn+gHNlV6ROd4isz2Uzbrx31Kk/Z9KkdI4oLv/ZpsIvfBO3nVVm?=
 =?us-ascii?Q?e3BGbWsfyDwPPEHZGPDm6GHNjfvBzKazBZKdsiFtpFMlJx3nd0oIe9fGI/7+?=
 =?us-ascii?Q?Eu2Qhbr6IowYfjKCpHLTESwqy7ABU8kySi4pRZs5L/cG22yPNtbqcgN5WsOX?=
 =?us-ascii?Q?ElZicEG9XqFcqH23w7Fj4tNdftC7zjikB50Gauok/cDlL0oyxrFmnGcMxDeB?=
 =?us-ascii?Q?EvfEXRfWWdTY1aU6iK1CWbLc/sO+2c8qIMTAaM1Z6QWsIS3mBfyNyTrPZo5V?=
 =?us-ascii?Q?dut08FM4wej7LuYJO+8O0fj8sMKMRtpUc8psj/nr5GtXqzwCzqLQUKlhavJw?=
 =?us-ascii?Q?ziWKPAnMB/1caD5aq6tZdBAnu/6IzMXXO59Zc9ox147LqEm8XFzMNTeBrcYF?=
 =?us-ascii?Q?XBDb8gN+4lvJWAhMuTHYUd1MwQgf3wxM6IWFE8GBB4sQQNbD3Ijo1swhHVEq?=
 =?us-ascii?Q?iQggwx8TZDwla8UyR54ASqJdiY6j+CcTWaqe+aCkoSwg5Fiz3ijdSA3ntc/e?=
 =?us-ascii?Q?sIC67Q6Xyg9jthbKoiHB4aaJtGhPX4mJKY+Op0VpIQ4+RexP6kGgIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HmAZnYfY7oyo2t1FWcV9gMx4HG32BIHCbzsFR8Nz2bhy/z/LiZAhBwWr3wNm?=
 =?us-ascii?Q?lwnH/msGf44v4TQF8wmj4wOMCM1D+EUO1FVGUmO0kGl/Bq7BxAfSuoe+Kt1D?=
 =?us-ascii?Q?zgOIPCd6VeyDNwNMaCsM0LlqvH5MLjCTN8rQUVQpU/bd77BeVfGV/mLWkL0e?=
 =?us-ascii?Q?lbNjbFrc/COsrPckTU8xGqAkK1K5PhonSYl9YfzwGIeb53Lb6gLKajInax2C?=
 =?us-ascii?Q?H2yet8/Kk1mOvcPGA/IMk6F90BRw5BLE/Nf07ICNQ4eDYFHJ0VzFOc8Q2KZL?=
 =?us-ascii?Q?QSo6miMSz8H8yya2mC+jBhN7lp4rvS7BOZ71ZaOC33pJpvyFYpL4BZKOgQHU?=
 =?us-ascii?Q?DdbMPupTQDRRnFdAaCoQsrjM3ChiVmI7imCYpHMenjkOWrn+fsfyZhwgcEO9?=
 =?us-ascii?Q?9jx/+wLuCSD3rogvJD24RuH6bjvLIW/5dnYGSmsa9nBQLOvJRW2GbHkrcXPD?=
 =?us-ascii?Q?Zwr+Bf/XKoFzz7TgTXSk768Qjq7aEdue7tBjNSZnug0Wgfe/hjDLTKfkOWzf?=
 =?us-ascii?Q?npioM3EVlS7AvDnwDzg8Iw7jxb7Dj1c0X2Y47LupwLp9msMcMp5agR+1CAve?=
 =?us-ascii?Q?M85h4HY6NlBRSwV1qlnLgEjD5TUA92qtcP8wuAiHG9iF/riVeM9bnOCG7chg?=
 =?us-ascii?Q?8PshkNb+EFQv7FDbP2uGlrfeA07wQiUdUD+WxoBzSk5XXXtyf/teFhYTsplc?=
 =?us-ascii?Q?GNGlgoONRtw1kwqA2fkhFsEmcYHdssMRKt4kLo8F8biY3EHyZETKATccXrei?=
 =?us-ascii?Q?dPsUm0HSotKlLa2iUmNeq08qPXo5syE6yOFGApeeI7R0tyDMXLZZp8Wt18ls?=
 =?us-ascii?Q?31cFoT+0wcrOq4o5tZisUaRIamooCbqMM/cjANhAkSt2LUyIDJS3FHGE6cpq?=
 =?us-ascii?Q?vlDcae0LrH+gCz3r8MKKL3mTzPR00t4b6bdh0uzCHDyK6DFE6YZAMpIQYJGQ?=
 =?us-ascii?Q?6Dbttz8MrlpxrHHJMH5lxOZfNT49v6UBCB2choQByPjfbjmXtJH3wiDmmXeZ?=
 =?us-ascii?Q?XEyNDpYBjZTN/SYUto3Ukzgv1rWVB9QyIGqau2j1dnuQUbLj6aElfHN+HxrX?=
 =?us-ascii?Q?+YdWLeFR4Zims8ACvNCp4wmqXxBUuXzVJQVZiqNNMo6ZYSDsNNk01InxPa8q?=
 =?us-ascii?Q?ubLhEzxPZmpHO0drc0UgW4ci8RHc282IT5Nkqyp1qzovi/bFe92sKT+kZF/m?=
 =?us-ascii?Q?XS4yfXpEF6j4ILaLMm6ERFjm1e9055bO3fIUTeNIBdmKzqaPxzMYPNobaCdw?=
 =?us-ascii?Q?vV/ewYIa745B50bAgOG7jSN3dtvuqO6+AV7vanh6gnSrB/ZRlEiIsKWuLQD1?=
 =?us-ascii?Q?j0UUzwOGgI06whbVHXuZ1J4ShkZmHzy11kECXjiIqUnmLhoTn3awd2Zzvgjy?=
 =?us-ascii?Q?/OCHdc8OqwQxnVcYvuAdhnmo5UR/Dq5oDmagsbr9r+yLpa8tsDHk9rUJiA42?=
 =?us-ascii?Q?vRZaymf0TC4UObwTWhtp4WOtrPCCP/yebzzgAch5hUz9Cpk6qLPlRkc2yAme?=
 =?us-ascii?Q?eF+aXdtsaheflF+ZVmbDNTHBcREBVFUZDnAcbWMsxgMnEikHMV/2d/iLSOiP?=
 =?us-ascii?Q?Vv67jsEbg2Lh+/ECEExM6SuAwAA6X0aovml5e44Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8ed30e-2959-47eb-5f87-08de1de6ad6a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:16:12.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kELjVv+q6s1Jk/+CmCtuWUPJvbLcy2VESe6VbguZQtd6sxURfxt+jetgui6mO2TghO2cL7ooGLg0F2zqHSzaJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8824
X-OriginatorOrg: intel.com

On Wed, Nov 05, 2025 at 08:06:32PM +0800, Philip Li wrote:
> On Wed, Nov 05, 2025 at 12:00:26PM +0100, Peter Zijlstra wrote:
> > On Tue, Oct 28, 2025 at 10:30:08AM +0800, Chen, Yu C wrote:
> > > On 10/27/2025 10:09 PM, Peter Zijlstra wrote:
> > > > On Mon, Oct 27, 2025 at 03:07:18PM +0100, Peter Zijlstra wrote:
> > > > > On Mon, Oct 27, 2025 at 02:55:16PM +0100, Peter Zijlstra wrote:
> > > > > 
> > > > > > > May I know if you are using the kernel config 0day attached?
> > > > > > > I found that the config 0day attached
> > > > > > > (https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-lkp@intel.com/config-6.18.0-rc1-00001-g79104becf42b)
> > > > > > > has
> > > > > > > CONFIG_IA32_EMULATION=y
> > > > > > > CONFIG_IA32_EMULATION_DEFAULT_DISABLED=y
> > > > > 
> > > > > Yep, deleting that entry makes it all work.
> > > > 
> > > > 'work' might be over stating, it boots and starts trinity, which then
> > > > promptly (as in a handful of seconds) triggers OOM and dies. Not
> > > > actually reproducing the NULL deref I was looking for.
> > > 
> > > Change the following line in job-script
> > > export memory='16G'
> > > to
> > > export memory='64G'
> > > ?
> > 
> > Yes, that seems to help.
> > 
> > > I had a try and can reproduce the NULL except at first run:
> > 
> > Took me two runs, but yes, I can see it now.
> > 
> > Anyway, this is two bugs in the robot, can we please fix all this to not
> > happen again?
> 
> Got it, I will dig into the detail to understand the difference of local
> reproduce and internal cluster run. The image, kconfig, and memory
> are exactly the same for actual robot run and provided reproduce instruction,
> since the attachment is reproduced from the job execution. I didn't find the
> cause quickly, and i will be back to this asap and provide update.
> 
> > 
> >  - .config has 32bit disabled while robot provides 32bit images. Clearly
> >    the actual robot runs 64bit images and the reproduction should
> >    provide those too.

Some update that this one is resolved, the cluster run has set ia32_emulation=on
in kernel cmdline, which is missed to set in the reproduce step.

> > 
> >  - job description is inaccurate in the amount of memory required.

Got it, the cluster run with 16G has 40% rate (in about 20 runs), now i
have increased the memory to 32G so it will reduce the OOM chance in local
reproduction.

> > 
> > The reproduction steps must exactly match what the real robot runs, not
> > something else.

Sorry for wrong reproduce steps, we should be more careful to make it consistent.

And thanks again to Peter and Yu.

> > 

