Return-Path: <linux-kernel+bounces-773175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3831DB29C61
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB903B1610
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6725B2F39AD;
	Mon, 18 Aug 2025 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fl7awJAf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A1278173
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506151; cv=fail; b=o+xqsP542sIPNY30u0uGVXteYkV7WgvHpjTgrrWHcsYKdJyHoHWVxwDuQuAHrYFs7t/W5byrjI4iCU1OLX5+SXIdmV8QGSwXbAK34Y4elpMKzCVljZurd1OcNH6C4X2kUl9ktsou8VqmxQd5U9fsZSvJ8DspN6FnRNskSlld7oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506151; c=relaxed/simple;
	bh=2CCNJQNsB3PeZupwVuPDEMw5gHDCGxdtoZ83hAqyZUQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lQHyxSsQCZTUsE281ZsX3bjrO2aITQav5hqUoR36KCXOOknyjsaBq6rEUi3AobxLLRJ3djqGrGmtf91xKqvFVdalTdue+ozMjhNdW7/O1Abo4froN46Tr37hMAosct+GQjLIpa7A3z7ZjpIbQldsla5diyyfnDlNe+LnR0k3bAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fl7awJAf; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755506150; x=1787042150;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2CCNJQNsB3PeZupwVuPDEMw5gHDCGxdtoZ83hAqyZUQ=;
  b=fl7awJAf3CW0RNe41kdxTVB2yNuCmAH9xIefUD/DuYAgn1Yieb1xK/KC
   052krepjFz2YAtCajZoNQPLQIiwGY7GUO7XE9xg0SR3Q3ftahx5NMB3td
   dzR+iA9z3wqAj+njZZ5FyYOGrkivORJ4hqri4nyp+2eIB6cqdR3wzsxKX
   f1DdKYcvUXUj++OoOUfBp0K2M2wChEgWZOvdy2hA1/SIJLtu/xuDCFuDw
   sed2Ha0Or2DMjjbEmGqo34l+B83HHqUg2U59osGrXCFekKIS3Wz4qmP6f
   UoZS2fYSmvLkqrnOM7FlKXqld6ftUr500hdjZ8KiFpP7uEUI9rTEd+abM
   g==;
X-CSE-ConnectionGUID: bagAhCzPR6SF0FviqR3r6Q==
X-CSE-MsgGUID: o5eeg3DFR36G+EGp9YPo4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57797182"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57797182"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 01:35:49 -0700
X-CSE-ConnectionGUID: 3gIbKb1kRJilDiuSoly1HQ==
X-CSE-MsgGUID: KSWvY1xkS8iIIMfLSciIfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171760147"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 01:35:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:35:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 01:35:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.73)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:35:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qv+Ifq63IFz1BOqiufkOsiqlC+jRtGINVYZLjmJpbDbIL5Qd/asSCVz4/r4tSwgLyvA1GG7ElXD9e+nb+32S315vTbu+vEW6QNqXjNSU6Sjg9qBQ23ZGeOT15Nc+J3IvixYkrvQ8E6d6EADmzBi6d9qwfRRIIK3ACdL1sLN1cXHhyhRYQMjNXE333rjmkB1X+sFiZDrNnF4yHlYCLBQnw1yKSUfCMrVPEk7reJcRvffsanVHelt63eMwNuOQE27BS+XxdP5G/wbg6+Ueiub1x20RlY/VuypPQMccKjK7kQVU/eRCukSruyNNbrOuArCcni8bCOS9x277m43DDj4nfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvXdyXpTNXYesXbGUhSKF1Jn0r780awClMwsfuf6Dac=;
 b=JrQUFuOpWRnorjcVP7k+wK2Rd3Ramk9W3clBpWa20f1ovu8DADf4PDTA8JOBOc1epI8rvZVTKKIsJtGt6Cgxf6ZulURZ9oJSswc9YLfYlPfXeduu4BK52eAdukqmuMeDucxrgbrj0CYPgzpT5PPy3+zkFUr1r1xE2i8toXmsVmQoIX+gnWCWf1JLPEYxJCCyucyLrNBQKix4Mmn+rAMyBtiDhSUdm7png6/AxKF8b/9vj3/OtIcncTh+9ZWamUu5BFiwmYVRy/0EpS8LPClL+8S9tp0u127xHi3SKaAh3/ghjnE0c6rcf/ngyr2q2wTzlmlcMCLS1mNI8rMO7ISwjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by MW4PR11MB6762.namprd11.prod.outlook.com (2603:10b6:303:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Mon, 18 Aug
 2025 08:35:40 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 08:35:40 +0000
Date: Mon, 18 Aug 2025 16:35:31 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <colinmitchell@google.com>,
	<abusse@amazon.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Enable staging when available
Message-ID: <aKLl010zQ1dFn/bk@intel.com>
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250813172649.15474-7-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250813172649.15474-7-chang.seok.bae@intel.com>
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|MW4PR11MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 532c0427-7be0-4a4f-4fc0-08ddde32369f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u670hxPZ20YKJOhL1e34nCMiYeYmi2zsdm1oadSd+mzZf4FBZMrM63mOruul?=
 =?us-ascii?Q?QHvwuRfaVsdRkXXxvkWwKtK/DWaJ2BT8SXkHCHnKp0DDkjOMk8BMd/W1ZhuJ?=
 =?us-ascii?Q?VzR3O+OZOQF9HgG+osIviLP4VcgK1W8lZQf4cfm3vl49OOjkrd4WWb1FZ/kJ?=
 =?us-ascii?Q?MdiMwEqjrqgAGhVXLrxOnJ2rDVvybHhrTEqrvZa8SsgGr/XILq7+MXuzr9sq?=
 =?us-ascii?Q?QXmN2uF28KvsL+Cap6aCoQ77KPMZWORX0q7FZEKew0FCBRG61Zrfy9a7vgmC?=
 =?us-ascii?Q?3w1TQ7Aa6gqIcKFUwuvP4JjJuPjV1dezZ4UOTJL+m9zH1uuORyynJDqhITCx?=
 =?us-ascii?Q?ZmWMnXKYeTkW49eOmDfdzXzpuOWLZP0x8jpaTphLgRfvlf0R4Pxz72lABoZ/?=
 =?us-ascii?Q?8PWCs+lGEiuk8QC7+BCt7QbWjTD1XQhCi7AqzIcbVnnUSPxIcItWSq7oiW02?=
 =?us-ascii?Q?bGY6kMYH7CgZuWbw5xBViNjv4eYAnY47AigzRg5VZdIfXctwbQMxo5FhX4Cy?=
 =?us-ascii?Q?AhAqgzPQ14qc02gCB3JdOimJo5yX8mWNmPco/NZyCcAKaL29nyeKqY6C5JtT?=
 =?us-ascii?Q?RSDb8ZH/CfiJh66QJbqH3CcyGiWhEprmxGZbGsgMfysfHG+BJB6Dahzlf2wL?=
 =?us-ascii?Q?2bOInSvBWqg/Nl9Ny87HrSWq4IRsFi04zpyeJSfe0n73t8kZjUgJE2II3h7q?=
 =?us-ascii?Q?O6IWVSmQ457LQMVAgHWrG6jZaZ85NhnnnQHphHRsm9NewYof+H8YcNFqYhW5?=
 =?us-ascii?Q?iyH3XhiIGVfTtZz7MZH3BgUZ1u8Ht3d5WHfuWB9StNuHDfhj9qpuXdFW6+7g?=
 =?us-ascii?Q?L69LMn6IAppClF2gjlWVmC549M4fzZEAcNpMV967m55qPewkTZokMrSlTni1?=
 =?us-ascii?Q?88DPQR4oXqFf0mEcNsRrmo/wEoV5fa0ms409KjIcecnZSEEWMXjGPP86yKt7?=
 =?us-ascii?Q?zJxliKA9HuTCp/IHBkb/bs1ueZC2tveHdF5/q/9X6YELuzTNywCU/H0X5Uhn?=
 =?us-ascii?Q?VTLU9tkd0ktzRXXRUNm991tynY+ZGZVWwC+wlq/+CwAO4X+hOZjDagNetTOw?=
 =?us-ascii?Q?XH7ZH0RK89iGB4B47DryC7FdNBVR1YiWEtJ4rIaF//8EYGAu6NCscTwk4c1c?=
 =?us-ascii?Q?bqR2VWPagLgl3Up0sx5nWCkyAmrZhdvWVFxuy5H9xsxtYyQV1z165Iq/IXoV?=
 =?us-ascii?Q?fjFFo1IhFblCifJ5Ri0sHEGZwCjbIeHzrW+XWv6+h8mRKdSUKwRIREMlDtlq?=
 =?us-ascii?Q?TB4hx2kqP/SYyRRJNfOYpVCLxOG5OQIxTFuM+ZvYPMgUMha6Ea0ZUVPAmZg/?=
 =?us-ascii?Q?4CfZWT+2yM7LcSEceXhA0ndX8Baw9c6W89U7u83pz0Fq1ErwXZFsDARQDy9Y?=
 =?us-ascii?Q?5z0s97cNPlvODqT9XcTTKkR6aLxEyTNmtOBn/PnIGShF7ihFpRaUJ4EU39uz?=
 =?us-ascii?Q?ZSZU8TMIPv0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wV/I7Zg69IUTPhYeotegoDnk0F10/m64tubjWbsbhcAk5X93PGyUTaBmCc3E?=
 =?us-ascii?Q?i/ZkWxdOWKqUGFIv9rR8D/B6j2fvO4y4BS9QYE8CxCc8TqSvwvuT38yFHiDT?=
 =?us-ascii?Q?nLnD7qoskRn3ujEgP51bGRmVYFcA4/tROjAOGLjnhTSHFujKD9PcN5mmprkH?=
 =?us-ascii?Q?d187bi8B7RLt1fH5PEfopJ4cJDHBhzrOTWUA8jcLWaDyb2QGHPAwPRTyrXxo?=
 =?us-ascii?Q?Oj58VKYTlbWFbbeRjc+jKXT/ho8+nb7JQRDzOV1PaUZreFy0shnLu824S6wI?=
 =?us-ascii?Q?RJh9iI9N+/Tlnf9xEYdwjHEsC73VL116wgPihBi9njQzag/cm0sWyHFNm8sm?=
 =?us-ascii?Q?qRbO72DHU7JPvEo0gr/TGvJJ2gRRN8rjrYj5yTIzRN1aM2jLLv/zHKCHPz2B?=
 =?us-ascii?Q?f2fZhUpJBJvWjTWAJTTv+cCVeSnXO8ThmqDjByC7WeVX4g32p2Nvi6ZHL3xh?=
 =?us-ascii?Q?qIjSk9j5TAfI/yaXtuXknvIDb/i/HORg/M+XFUbVufJBzin9M0r7ktVApNBn?=
 =?us-ascii?Q?5j/hrq/sAtErrMWXdkUulL4qeHYnruzYsLbNFEGpb9VyC8dls67td+RTm+r5?=
 =?us-ascii?Q?VitA5+KvUiMDit1+7Vn2qacCEDVfWBlVnMpRzOcGdNiTcaQsJFCMbV5O+pcQ?=
 =?us-ascii?Q?FwQxBFF85pQp1qdEuMmz9C1jLBzwUjNDQd+J+5nBWJc8FpxRdQmhGClDrevt?=
 =?us-ascii?Q?JuMoWhzG4cJQrjBNYATzbPsoiquNwoxHdOhKOOBqn91dlJxvuwYCj8p/2FxC?=
 =?us-ascii?Q?biS/OGlDPILsFDQjFjgMmpn+GLRyskIHByHUK8Wbg8SBCuimwVSRGswx6aqp?=
 =?us-ascii?Q?Mo+WhVgpbMeGhhtozaogZPm2uHlApedjKxKRB6yWmjXSZEy6D5Te//ZhyybB?=
 =?us-ascii?Q?cY5YYmGYXmFc+8h3we5wpmT0mzgINp1F8x4PlFNFsYK7h/NJdWO62WScoNvx?=
 =?us-ascii?Q?+qhCyw4RMoeAkCqhgCxUg5zgunhAE1JnT5RTQxk+8WZwP+6yaiWLOXsmeMB+?=
 =?us-ascii?Q?t9OT2wbwfgXGIAagxfEME3va4wuUA1f7M8mPdp2FTiRS+HswI4kp1MnRQTJs?=
 =?us-ascii?Q?wIAYX96dvimqNKzB5cM83fsfWzAFKvwWtcUIoA5492YHNaQ1ZsaTzWyURbsu?=
 =?us-ascii?Q?33UYegVhfGjy7AABbKf13l7mOMbpk9RiAAG3juP9qOZvO88oa0FIMvE7XWhN?=
 =?us-ascii?Q?GjIW/q+euKtbDXENyBjhEBCUFSXYfH22681U5h3Q3PY5r+TWtEtT2Ima3WQW?=
 =?us-ascii?Q?S47/TjKJ2I9VGeX7fjdv7Zp0FWHwoCnrRzikJXR1w/2lypoOqL31XrinzkVK?=
 =?us-ascii?Q?QcvDw3mdOI02/hf88SvnQU2ezFr7VbltwLrcb4LWbwhMdtieEdIcUN9GUrRN?=
 =?us-ascii?Q?jnub+1BOealx8wuau6WLaU+U8QvzggW6AjQ/DbCEbKWKrIpl4s6H7cqwSCWt?=
 =?us-ascii?Q?gbpBDALfaMXzqJog2iDtFpzJyxYTa0ac0whaPh+CZgbdSr4L/HExU9mJByhC?=
 =?us-ascii?Q?ax5ycSyWTUV5xd8uNJyyfvWndB7Sqb53js7V2+mYOfZ6EFpQIzsgHxzlOecY?=
 =?us-ascii?Q?ui0S4V1lwEl7kN+ybhp4ovRvEQyr8joNt8xu0GPF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 532c0427-7be0-4a4f-4fc0-08ddde32369f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:35:40.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EJ4Vz3KC3eXMDx1bDlkqfCB4VH77Zvit5UHLBZWBmhd/LFyzNNN//7cmfFMBdJ/XN/ARVt8C99tqHgrPRyXTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6762
X-OriginatorOrg: intel.com

On Wed, Aug 13, 2025 at 10:26:49AM -0700, Chang S. Bae wrote:
>With the staging code being ready, check for staging availability by
>reading these following MSRs:
>
>  * IA32_ARCH_CAPABILITIES (bit 16) for the presence of
>    IA32_MCU_ENUMERATION
>
>  * IA32_MCU_ENUMERATION (bit 4) for the staging feature availability.
>
>When available, enable it by setting the feature bit.
>
>Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
>Tested-by: Anselm Busse <abusse@amazon.de>

Reviewed-by: Chao Gao <chao.gao@intel.com>

<snip>

>+static __init bool staging_available(void)
>+{
>+	u64 val;
>+
>+	val = x86_read_arch_cap_msr();
>+	if (!(val & ARCH_CAP_MCU_ENUM))
>+		return false;
>+
>+	rdmsrl(MSR_IA32_MCU_ENUMERATION, val);

nit: s/rdmsrl/rdmsrq

rdmsrl has been renamed to rdmsrq.

>+	return !!(val & MCU_STAGING);
>+}
>+

