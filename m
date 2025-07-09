Return-Path: <linux-kernel+bounces-722601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DB0AFDCBF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8207B46FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF00145B3F;
	Wed,  9 Jul 2025 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMaT9qsQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B084A2B;
	Wed,  9 Jul 2025 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752023142; cv=fail; b=GXHi8vcnxooVeIeXVS3URPK1jDM2oHxuQfwXh4Nmr/7qTY5kX0xBm+8a4gZnzcO4yhF57dmmwAWPpCfZ1G8Y61IUHwvfmeeALKqaz0DL6Zk+H0PM3gXS1MLUrhbxucvCT3d3yttd8wPr0zFwMT5WeEssVZdEOuEO9HI4vJEGLfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752023142; c=relaxed/simple;
	bh=TPnd35M6TWfPHNzlb4uCFnL+7A0vHVHUyRvobuhENvU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nZVbuSSQQzSPc+aKdQADaTCTKca9aWki7KGNaqTEPWQJvUPpGKdVSBYcpKTZI+jGGULTrJlIsrrFVvg0BErTq5ZjGJeowFwk8B/SrHH7452oJZSqydYr54MKP+bkAOtmbbMLjk5pndBWDEyYRBuAi2OkWw6KB/2MmJrC9gCHdYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMaT9qsQ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752023140; x=1783559140;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=TPnd35M6TWfPHNzlb4uCFnL+7A0vHVHUyRvobuhENvU=;
  b=dMaT9qsQgU4kYbC9p4OzIN/pQKC1tRNzeK5jsOFWsr1kVVFlB1lXQ1Kr
   efLP2aSBHRi+6qxIV6pc3785Gg4cYLDERCO23kZ1/Scr4tzhWNkxUE2V1
   t/vN4x+IYh2jm8CxnI9O1gEUBwX4YwFoKWPLykcGmhuNnGIhymsOHYANV
   NVBio1KfPLAh//mqASZJr7xaVh0GRR65E2aZ5/hOfN+2Mu+laM/2KfoVW
   jD/dfWqUaFNyPQcz1tzqgyP4PQyBIQMkMMNtWr4DJYIQ4fcCHZt7JgghR
   mnDQjZoT1bypeWwL4mXxb5QxF1wTPhFIGOM6OQZMB9YhC27AMa3Ml4tek
   Q==;
X-CSE-ConnectionGUID: vBnnmqu7TPW1WfL/lKD/xg==
X-CSE-MsgGUID: RDuN0Ls5QzeewfTh7uyCHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54404043"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="gz'50?scan'50,208,50";a="54404043"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:05:39 -0700
X-CSE-ConnectionGUID: H2zmc9FwQ+uXtOyT20LVTg==
X-CSE-MsgGUID: iGrf+FumT8CCl5cgLKWqpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="gz'50?scan'50,208,50";a="186603036"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:05:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:05:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 18:05:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.82)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:05:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGZciSWRgZQFFmBLwU4VuWNVXpWaC2sxTLkHjGmGLcIUcVPIqOaQPkpZnpBTyPMLxzYN3lK5qOzWFtL2QFDdN4xsPHAUTPVgSdtDGq3okUe6aqpAJqAz1ATZ7M2Y8ZoZZJoVaxjrni6+g4Wf7i2QgDaS7vNSYXLvkEmdsP3EqUL9nMlu/pwy7Oq5E0l3enAjtn9sC4mc1BHnWtNqb3+QlIgKZrYLlSwL/CLvBWYpwv8+ed3TKmQ3z1crt+58KXnNchlE6rfQgXyFgGgjozwKGT5RpL5hfJFzE2KYa2sXCqXVTObhcGhi7S5J9vlBN9PIpwj17BHkqYtoyuJMBQpvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGVeSgjcgZDM38qumCzjvYeiFJk2RIg1N4VlGZL3XfU=;
 b=rTWl0bcFed91tEHJatX+Cf9iYraSrVOxVCAmB1ds2k3Do07Cv8ATHIEaS8WszZaoD6BVbCsrkhrvMAwHI+X9ci20m2OEI6sbtNQAimMiOFX7KnUSRKdo6bPMaib6AtKrLWHbN7TFk/pkFVSPMjx+6cTRvjqINy/c97/M90dIxITdBsX5RsHSzemZzGKpGUf4n7xuGNRz650gX83s5cqmUKMipFjdJniS8kGninAUejqlyGop2MrL/1ueZfVPDritEnNSIS+Cr7Ii04BNrSKj7GBoTSMWVnq5rHnPuVvoaN/hhbZsDj/oxJYMJEMmqacsDJzaQA2elSV2Fo4d/IXBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by MW4PR11MB6911.namprd11.prod.outlook.com (2603:10b6:303:22d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Wed, 9 Jul
 2025 01:05:34 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%6]) with mapi id 15.20.8901.021; Wed, 9 Jul 2025
 01:05:34 +0000
Date: Wed, 9 Jul 2025 09:05:25 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>, Phillip Lougher
	<phillip@squashfs.org.uk>, Chanho Min <chanho.min@lge.com>
CC: <oe-kbuild-all@lists.linux.dev>, <kernel-janitors@vger.kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Linux Memory Management List
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] squashfs: Fix incorrect argument to sizeof in
 kmalloc_array call
Message-ID: <aG3AVf8fbqHzk+OD@rli9-mobl>
Content-Type: multipart/mixed; boundary="aUNe/9Ocym7+K5h0"
Content-Disposition: inline
In-Reply-To: <20250708142604.1891156-1-colin.i.king@gmail.com>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|MW4PR11MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 225fb25e-91b2-424d-3d74-08ddbe84b4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|4053099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tsmJGNWR5iJzPsg/LB2hU77JZOUPulou60GbKUgXANO2V8cjE/X8tAY4LZBd?=
 =?us-ascii?Q?I9pPcRCSbDo+WpUN4QP/JGeqDq/0hREviO2Y+0yVgsFZq1K3wiZ2Qq7JT3Yo?=
 =?us-ascii?Q?iQDRjq6hbvyMmjgY5bOtw/BfHYjI0XLeY6CMyx7OuJeb32XP/CPGT/VB8X1N?=
 =?us-ascii?Q?2kJz9RnB9IbaPeOV9rpJ1jVhNjtCLWxGS9dET5U8WG4hLRjTfj9sSD5NKCX6?=
 =?us-ascii?Q?1bnVyZMvU9QjxVbdP2GvpEr5p/3p+DfADVKr9nW2VqrwWLcsMrE350j0B2Lq?=
 =?us-ascii?Q?zgQPgxPWtWtI0OR53vGOfuF3nKWrwvunYeerATHwE6GJSNpsHXAwc8jstcsm?=
 =?us-ascii?Q?f/hRsidlcR4kxfwtwMWQI77MubC+YU/TkButPIsZ2BycPr1HlB1dP3TkePt6?=
 =?us-ascii?Q?A+bfBvomG9mPV9T/WlarNz6YD06zDUhELB+PTGZrAcZBKwFlCASZzgDz5pMU?=
 =?us-ascii?Q?8Iuopmb3xzS6YABdkIdG5X11z8Zb65Ym6bJ5XYI+hNlE2UKtzrdM6mRAauhI?=
 =?us-ascii?Q?dwiE+ZKIby1nIsoAR9+zAhJmaOsuiZb7J+DguIu+waWkMJ+Ax4/7dmxNeGi0?=
 =?us-ascii?Q?MqrcHl5gHwY0cyRYP/6OSMfGkvdARUCnnYuthuE6XwvR0aVDUgXpNjES+aqN?=
 =?us-ascii?Q?T24GoF+oxS26W9BPiOpascKdtK/YwkpRbCRi/OF7+DigJum08P7BY+dBmD09?=
 =?us-ascii?Q?x/c898fwpADaftAWL+P9ZipvWE8PYaYNWoMY4ULb8VcT96yz+wfUVmrfAt37?=
 =?us-ascii?Q?s5XUxZG/fOpSVoncALxco+ITJ6sbNbAXX3u0kfbFoRIVSmsSrvKTwYtlvAsr?=
 =?us-ascii?Q?UTBA6O6F44Yx1dP0PMz+l3fR3RekIstgzo6XTTxt/rrPpLgOdGMPKeZ0xh0N?=
 =?us-ascii?Q?flWeEOzWDmUsGhyncG+3e7PLPtfa+VssF9fWsiuDWNxAg/H6oTxkxeBqUxut?=
 =?us-ascii?Q?z5oq8Kj4qFQXtuQk2F9OULtnEnjyyao29wmCG0vxxPhKK+WbFzJEanymPCDu?=
 =?us-ascii?Q?YmpnYASSAwcuc1HFHA6qfGrw/1RFv34dWY36mHIJprqn68cJigu83R+D9zj0?=
 =?us-ascii?Q?76dK54cRBmz8uek9aIcRR2lfV51NDxR8qrMFIYJQGCQ4N3OY8eNdZKwuudYs?=
 =?us-ascii?Q?bJLo8icVdOCibtJm9FTUUg2s2fuASbHaTT/6rpKwroHEYiUkno4dMU6/cB2p?=
 =?us-ascii?Q?DsZXd56O1gHOkXT4CSeBcnC2alXdTYPqXPj7f19o1V1MOJse6wG1EgMdViiJ?=
 =?us-ascii?Q?5kyGUwCy36OcinwIgtANCf46EhYlN7ivbHaalGTal3P1S7Be7295tEyVmSEm?=
 =?us-ascii?Q?LDbqrcINym35KL3hK5MOvqOO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xMqgT2xQUEOYouI3A2ci2gsPDUikp2TyqtS38DviT0/6pIiWriFEThsDnwIU?=
 =?us-ascii?Q?sbL3Mvx67n3SSdYVxGLq4q6oaXY1ixEu/XonQNrvchrYbzHjoAbiyOpXOzoI?=
 =?us-ascii?Q?Nzan9yqxyjl2wSBREzuRV0QWSxIbw5PBWSReOXk3GJff6yoBiYjBl40iX8cy?=
 =?us-ascii?Q?L+z0a5yvMsvnAe4hU2B1sBaqv2PkgJpBrNQ3OPPL0CETO/R9/qOI25yeG78B?=
 =?us-ascii?Q?k8sLwAQfi7O/UHVunnKsF49mfGHAstrp5PcZ9g+nyY49RpLokyfO0UB/QUiW?=
 =?us-ascii?Q?KqlSlifVETwSpUnNF2jdbDM9SG80uxQh1B4ZuWmzoHCNb2en0nuUFUGemRSJ?=
 =?us-ascii?Q?3xFUhGKGvTE5yQJcdyHMi7ubbwcub7XAZfoarMnOU6oAYqDSKy84FrklNHaN?=
 =?us-ascii?Q?sJfG7tWWqAz6owiMhaRyB4dsfd/wv/LYLvPHXBW6i1A7g9JG5Vr+FV5sbCyU?=
 =?us-ascii?Q?l6Ljc1tUy62/RXDkL2F1brh+lweNKK7ONKuDSPZjzIbJ9904p+rYVuw9KLl/?=
 =?us-ascii?Q?0baRRRkB045tV+6qNMN4qIqe3OxmY7zOebdWIlFbj9LpFCYXainHJql7+NHs?=
 =?us-ascii?Q?6FBopCQZC7JXlBOLlzWOiM/EjypwzSgAmec+8JElEJNBoO7Aml8Vv2erOzdw?=
 =?us-ascii?Q?FtO7P0mCIP/NH1iUpK7kA62KMmZ6ef8InI0XnN6adjd6EnWezL7kXODrgXxf?=
 =?us-ascii?Q?xHWW6GTt4agAGE8lxw5vUI6UekaakNjACNGwo8/m5GwgrsvD3MmWlW1oMp3W?=
 =?us-ascii?Q?TzAdf09vi6wsrG/a7jWTAZi6ziy3xLN0YJi+JWi6nl3gaLzLNtqTdkeV6klr?=
 =?us-ascii?Q?/l9Y+9LDhJxxBYRiX7Ewhdk/GmLZfI4hvwshqMqB2zxR7WM5roqH5skFhf0K?=
 =?us-ascii?Q?k2C1GzmGG5eEXJ+c5zVBGwVp8en46WPy4hdRKxP2wuTSbqHPXj2CXubpA6Ri?=
 =?us-ascii?Q?ei8VKM9j9lWthriom+zDqD9G5qHCOHT4dVnxktgGH+PkdIaTwHZkslbtHyth?=
 =?us-ascii?Q?eqrM8nX4ol7LZTPtFc4rWeCu1RMT2wALK2eJ64nofAhxxw0Dpju8Ql9r5IGF?=
 =?us-ascii?Q?6aLVuhDdFdReMSc04BOOSUJNuWq+Wm7Yjw9UZ7MoDF1EcdlwK7CHpfNBKGUl?=
 =?us-ascii?Q?GP0sr4POzjRvTphgZXMz1Ln9UkepkTPbnhvMNler57ShxwcCE7U87UpwzyNc?=
 =?us-ascii?Q?pChfePPx9uVcrOV1X4lMiswBnw0uQb7YaKJmCDqKa7T2wFlREBYXyPA6TgFI?=
 =?us-ascii?Q?KnxausvyuEglpoYStVOa6LI25PpCBbTwCbv9O08iiQnnT7OwieErWlpc4Is8?=
 =?us-ascii?Q?doVsl8EDcxKQhnuGXoSVPxEXqaVTKMPD0pbMqIXUeLPPq1+YACb1fvwwoJfU?=
 =?us-ascii?Q?5aYxUKnJ2i+aRk7GktgO2VT+xTP+NdLo1gj+MC8makY5PBvlIp9Vmfj7TUGC?=
 =?us-ascii?Q?6KEIjZCgoNWlS+KlBttwlQiHhDWDw5eYQoZQ5OG6SMwL54GdI9J/OKdL0Cv5?=
 =?us-ascii?Q?J+qhBIb8tlYYPxmmS/JtrcsX0JF0AtU24+eO1hbsFpoYT8/nbV2f6z23pdhf?=
 =?us-ascii?Q?mcYHE4vbCOvN5Flsg0IyAig60fy9HI/N9GHLHwWh8/gg5yGVjdgGmi4NWl41?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 225fb25e-91b2-424d-3d74-08ddbe84b4f7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:05:34.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPcrkX5C2dH4ohW4b7+rm3Rt237UbE6bFFCM7hlaNlHDLamc4rq53YZHRysNTwGWGmmkKYn/w9ahPIME3vmbdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6911
X-OriginatorOrg: intel.com

--aUNe/9Ocym7+K5h0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Colin,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20250708]
[cannot apply to linus/master v6.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Colin-Ian-King/squashfs-Fix-incorrect-argument-to-sizeof-in-kmalloc_array-call/20250708-223017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250708142604.1891156-1-colin.i.king%40gmail.com
patch subject: [PATCH] squashfs: Fix incorrect argument to sizeof in kmalloc_array call
:::::: branch date: 10 hours ago
:::::: commit date: 10 hours ago
config: mips-randconfig-r071-20250709 (attached as .config)
compiler: mips64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (attached as reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507090822.QI1bMiUV-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/percpu.h:5,
                    from include/linux/percpu_counter.h:14,
                    from include/linux/mm_types.h:21,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:16,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:14,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from fs/squashfs/block.c:16:
   fs/squashfs/block.c: In function 'squashfs_bio_read_cached':
>> fs/squashfs/block.c:92:12: error: 'folio' undeclared (first use in this function)
       sizeof(*folio), GFP_KERNEL | __GFP_ZERO);
               ^~~~~
   include/linux/alloc_tag.h:239:9: note: in definition of macro 'alloc_hooks_tag'
     typeof(_do_alloc) _res;      \
            ^~~~~~~~~
   include/linux/slab.h:950:30: note: in expansion of macro 'alloc_hooks'
    #define kmalloc_array(...)   alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
                                 ^~~~~~~~~~~
   fs/squashfs/block.c:91:32: note: in expansion of macro 'kmalloc_array'
     struct folio **cache_folios = kmalloc_array(page_count,
                                   ^~~~~~~~~~~~~
   fs/squashfs/block.c:92:12: note: each undeclared identifier is reported only once for each function it appears in
       sizeof(*folio), GFP_KERNEL | __GFP_ZERO);
               ^~~~~
   include/linux/alloc_tag.h:239:9: note: in definition of macro 'alloc_hooks_tag'
     typeof(_do_alloc) _res;      \
            ^~~~~~~~~
   include/linux/slab.h:950:30: note: in expansion of macro 'alloc_hooks'
    #define kmalloc_array(...)   alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
                                 ^~~~~~~~~~~
   fs/squashfs/block.c:91:32: note: in expansion of macro 'kmalloc_array'
     struct folio **cache_folios = kmalloc_array(page_count,
                                   ^~~~~~~~~~~~~
>> include/linux/alloc_tag.h:251:1: warning: initialization of 'struct folio **' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    ({         \
    ^
   include/linux/slab.h:950:30: note: in expansion of macro 'alloc_hooks'
    #define kmalloc_array(...)   alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
                                 ^~~~~~~~~~~
   fs/squashfs/block.c:91:32: note: in expansion of macro 'kmalloc_array'
     struct folio **cache_folios = kmalloc_array(page_count,
                                   ^~~~~~~~~~~~~
--
   In file included from include/linux/percpu.h:5,
                    from include/linux/percpu_counter.h:14,
                    from include/linux/mm_types.h:21,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:16,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:14,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from block.c:16:
   block.c: In function 'squashfs_bio_read_cached':
   block.c:92:12: error: 'folio' undeclared (first use in this function)
       sizeof(*folio), GFP_KERNEL | __GFP_ZERO);
               ^~~~~
   include/linux/alloc_tag.h:239:9: note: in definition of macro 'alloc_hooks_tag'
     typeof(_do_alloc) _res;      \
            ^~~~~~~~~
   include/linux/slab.h:950:30: note: in expansion of macro 'alloc_hooks'
    #define kmalloc_array(...)   alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
                                 ^~~~~~~~~~~
   block.c:91:32: note: in expansion of macro 'kmalloc_array'
     struct folio **cache_folios = kmalloc_array(page_count,
                                   ^~~~~~~~~~~~~
   block.c:92:12: note: each undeclared identifier is reported only once for each function it appears in
       sizeof(*folio), GFP_KERNEL | __GFP_ZERO);
               ^~~~~
   include/linux/alloc_tag.h:239:9: note: in definition of macro 'alloc_hooks_tag'
     typeof(_do_alloc) _res;      \
            ^~~~~~~~~
   include/linux/slab.h:950:30: note: in expansion of macro 'alloc_hooks'
    #define kmalloc_array(...)   alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
                                 ^~~~~~~~~~~
   block.c:91:32: note: in expansion of macro 'kmalloc_array'
     struct folio **cache_folios = kmalloc_array(page_count,
                                   ^~~~~~~~~~~~~
>> include/linux/alloc_tag.h:251:1: warning: initialization of 'struct folio **' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    ({         \
    ^
   include/linux/slab.h:950:30: note: in expansion of macro 'alloc_hooks'
    #define kmalloc_array(...)   alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
                                 ^~~~~~~~~~~
   block.c:91:32: note: in expansion of macro 'kmalloc_array'
     struct folio **cache_folios = kmalloc_array(page_count,
                                   ^~~~~~~~~~~~~


vim +/folio +92 fs/squashfs/block.c

93e72b3c612adc Philippe Liard          2020-06-01   78  
e994f5b677ee01 Vincent Whitchurch      2023-05-17   79  static int squashfs_bio_read_cached(struct bio *fullbio,
e994f5b677ee01 Vincent Whitchurch      2023-05-17   80  		struct address_space *cache_mapping, u64 index, int length,
e994f5b677ee01 Vincent Whitchurch      2023-05-17   81  		u64 read_start, u64 read_end, int page_count)
e994f5b677ee01 Vincent Whitchurch      2023-05-17   82  {
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12   83) 	struct folio *head_to_cache = NULL, *tail_to_cache = NULL;
e994f5b677ee01 Vincent Whitchurch      2023-05-17   84  	struct block_device *bdev = fullbio->bi_bdev;
e994f5b677ee01 Vincent Whitchurch      2023-05-17   85  	int start_idx = 0, end_idx = 0;
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12   86) 	struct folio_iter fi;;
e994f5b677ee01 Vincent Whitchurch      2023-05-17   87  	struct bio *bio = NULL;
e994f5b677ee01 Vincent Whitchurch      2023-05-17   88  	int idx = 0;
e994f5b677ee01 Vincent Whitchurch      2023-05-17   89  	int err = 0;
2e227ff5e2729b Chanho Min              2025-05-21   90  #ifdef CONFIG_SQUASHFS_COMP_CACHE_FULL
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12   91) 	struct folio **cache_folios = kmalloc_array(page_count,
45eb6ae283427f Colin Ian King          2025-07-08  @92  			sizeof(*folio), GFP_KERNEL | __GFP_ZERO);
2e227ff5e2729b Chanho Min              2025-05-21   93  #endif
e994f5b677ee01 Vincent Whitchurch      2023-05-17   94  
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12   95) 	bio_for_each_folio_all(fi, fullbio) {
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12   96) 		struct folio *folio = fi.folio;
e994f5b677ee01 Vincent Whitchurch      2023-05-17   97  
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12   98) 		if (folio->mapping == cache_mapping) {
e994f5b677ee01 Vincent Whitchurch      2023-05-17   99  			idx++;
e994f5b677ee01 Vincent Whitchurch      2023-05-17  100  			continue;
e994f5b677ee01 Vincent Whitchurch      2023-05-17  101  		}
e994f5b677ee01 Vincent Whitchurch      2023-05-17  102  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  103  		/*
e994f5b677ee01 Vincent Whitchurch      2023-05-17  104  		 * We only use this when the device block size is the same as
e994f5b677ee01 Vincent Whitchurch      2023-05-17  105  		 * the page size, so read_start and read_end cover full pages.
e994f5b677ee01 Vincent Whitchurch      2023-05-17  106  		 *
e994f5b677ee01 Vincent Whitchurch      2023-05-17  107  		 * Compare these to the original required index and length to
e994f5b677ee01 Vincent Whitchurch      2023-05-17  108  		 * only cache pages which were requested partially, since these
e994f5b677ee01 Vincent Whitchurch      2023-05-17  109  		 * are the ones which are likely to be needed when reading
e994f5b677ee01 Vincent Whitchurch      2023-05-17  110  		 * adjacent blocks.
e994f5b677ee01 Vincent Whitchurch      2023-05-17  111  		 */
e994f5b677ee01 Vincent Whitchurch      2023-05-17  112  		if (idx == 0 && index != read_start)
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12  113) 			head_to_cache = folio;
e994f5b677ee01 Vincent Whitchurch      2023-05-17  114  		else if (idx == page_count - 1 && index + length != read_end)
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12  115) 			tail_to_cache = folio;
2e227ff5e2729b Chanho Min              2025-05-21  116  #ifdef CONFIG_SQUASHFS_COMP_CACHE_FULL
2e227ff5e2729b Chanho Min              2025-05-21  117  		/* Cache all pages in the BIO for repeated reads */
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12  118) 		else if (cache_folios)
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12  119) 			cache_folios[idx] = folio;
2e227ff5e2729b Chanho Min              2025-05-21  120  #endif
e994f5b677ee01 Vincent Whitchurch      2023-05-17  121  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  122  		if (!bio || idx != end_idx) {
e994f5b677ee01 Vincent Whitchurch      2023-05-17  123  			struct bio *new = bio_alloc_clone(bdev, fullbio,
e994f5b677ee01 Vincent Whitchurch      2023-05-17  124  							  GFP_NOIO, &fs_bio_set);
e994f5b677ee01 Vincent Whitchurch      2023-05-17  125  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  126  			if (bio) {
e994f5b677ee01 Vincent Whitchurch      2023-05-17  127  				bio_trim(bio, start_idx * PAGE_SECTORS,
e994f5b677ee01 Vincent Whitchurch      2023-05-17  128  					 (end_idx - start_idx) * PAGE_SECTORS);
e994f5b677ee01 Vincent Whitchurch      2023-05-17  129  				bio_chain(bio, new);
e994f5b677ee01 Vincent Whitchurch      2023-05-17  130  				submit_bio(bio);
e994f5b677ee01 Vincent Whitchurch      2023-05-17  131  			}
e994f5b677ee01 Vincent Whitchurch      2023-05-17  132  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  133  			bio = new;
e994f5b677ee01 Vincent Whitchurch      2023-05-17  134  			start_idx = idx;
e994f5b677ee01 Vincent Whitchurch      2023-05-17  135  		}
e994f5b677ee01 Vincent Whitchurch      2023-05-17  136  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  137  		idx++;
e994f5b677ee01 Vincent Whitchurch      2023-05-17  138  		end_idx = idx;
e994f5b677ee01 Vincent Whitchurch      2023-05-17  139  	}
e994f5b677ee01 Vincent Whitchurch      2023-05-17  140  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  141  	if (bio) {
e994f5b677ee01 Vincent Whitchurch      2023-05-17  142  		bio_trim(bio, start_idx * PAGE_SECTORS,
e994f5b677ee01 Vincent Whitchurch      2023-05-17  143  			 (end_idx - start_idx) * PAGE_SECTORS);
e994f5b677ee01 Vincent Whitchurch      2023-05-17  144  		err = submit_bio_wait(bio);
e994f5b677ee01 Vincent Whitchurch      2023-05-17  145  		bio_put(bio);
e994f5b677ee01 Vincent Whitchurch      2023-05-17  146  	}
e994f5b677ee01 Vincent Whitchurch      2023-05-17  147  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  148  	if (err)
e994f5b677ee01 Vincent Whitchurch      2023-05-17  149  		return err;
e994f5b677ee01 Vincent Whitchurch      2023-05-17  150  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  151  	if (head_to_cache) {
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12  152) 		int ret = filemap_add_folio(cache_mapping, head_to_cache,
e994f5b677ee01 Vincent Whitchurch      2023-05-17  153  						read_start >> PAGE_SHIFT,
e994f5b677ee01 Vincent Whitchurch      2023-05-17  154  						GFP_NOIO);
e994f5b677ee01 Vincent Whitchurch      2023-05-17  155  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  156  		if (!ret) {
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12  157) 			folio_mark_uptodate(head_to_cache);
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12  158) 			folio_unlock(head_to_cache);
e994f5b677ee01 Vincent Whitchurch      2023-05-17  159  		}
e994f5b677ee01 Vincent Whitchurch      2023-05-17  160  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  161  	}
e994f5b677ee01 Vincent Whitchurch      2023-05-17  162  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  163  	if (tail_to_cache) {
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12  164) 		int ret = filemap_add_folio(cache_mapping, tail_to_cache,
e994f5b677ee01 Vincent Whitchurch      2023-05-17  165  						(read_end >> PAGE_SHIFT) - 1,
e994f5b677ee01 Vincent Whitchurch      2023-05-17  166  						GFP_NOIO);
e994f5b677ee01 Vincent Whitchurch      2023-05-17  167  
e994f5b677ee01 Vincent Whitchurch      2023-05-17  168  		if (!ret) {
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12  169) 			folio_mark_uptodate(tail_to_cache);
193770db0106b0 Matthew Wilcox (Oracle  2025-06-12  170) 			folio_unlock(tail_to_cache);
e994f5b677ee01 Vincent Whitchurch      2023-05-17  171  		}
e994f5b677ee01 Vincent Whitchurch      2023-05-17  172  	}
e994f5b677ee01 Vincent Whitchurch      2023-05-17  173  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--aUNe/9Ocym7+K5h0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICEGvbWgAAy5jb25maWcAlDxbc9s4r+/7Kzztw9md2W4TJ3Gzc8YPlETZrCVRISlf8qJxE7fN
bC49ifNt++8PQN1IirLzPeymJkAQBEEQAEG9/+39iLzunx62+7ub7f39r9G33ePuebvf3Y6+3t3v
/ncU8VHG1YhGTP0FyMnd4+vPjw93P15Gk79OJ3+dfHi+uRgtds+Pu/tR+PT49e7bK3S/e3r87f1v
Ic9iNivDsFxSIRnPSkXXavoOu0/OP9wjrQ/fbm5Gv8/C8I/R5V8Xf528M3oxWQJg+qtpmnWUppcn
FycnLW5CslkLapuJ1CSyoiMBTQ3a+Gxyctq0JxGiBnHUoUKTH9UAtEOJQqpwqDlJlmkfhrMhMi1n
XPGSFyovVBkIvqBZxwOgzIFlRGNZwjLaA2W8zAWPWULLOCuJUsKaQUiyspC0XFCaA4mSAxsJ2XQ4
OZlz6Ntwd3rW8sfEVbniYtHhBgVLIsVSWioSQCfJhQIorPT70Uzrzf3oZbd//dGtPcuYKmm2LIkA
fljK1PRs3E6BpzkyrqhEOu9HdfuKCsHF6O5l9Pi0R4rthHhIkobVd+8svkpJEmU0zskSpy0ympSz
a5Z30zAhAUDGflBynRI/ZH091IMPAc79gGupInPmBr/m9F245voQAvJ+CL6+9kjXmkWf4vkhgjgR
D8mIxqRIlFYDY22a5jmXKiMpnb77/fHpcfdHiyA3cslyY+vXDfg3VEm/HVWJ2EpEVDgvrwpaUA9j
oeBSlilNudjgriHhvNFk0PvRy+uXl18v+91Dp8kzmlHBQr0tYMcFxlY0QXLOV34IjWMaKgaLT+K4
TIlc+PFSNhNEoYZ7wSz7jGSGwOHcVHVsiXhKWGa3SZb6kMo5o4KIcL4ZGDtndreYi5BGpZoLSiKW
zfzdIhoUs1jq1dk93o6evjpC7uw4DxeSF0C0Wr+Ie0hqC7RETSBJ0gdrInRJMyU9wJTLssgjokxT
yjM8mEolSLiwZuFCShYltFEUdfewe37x6Ypi4aLkGQVlUB0xMNXza9TUVC9eq6nQmANzPGKhR1Or
XvW4bZ+qNS6SZKiLYXDYbF4KKrXghCEUn7hBMdelXNAVHBvT0/FFt2S96VoGjQZ5XH5m7XkAPy3J
tJwjXr12tkGph7E7tseUoDTNVWXqTUE0gAzE7TVQDcKSJ0WmiNh4BFbjGKdi3Snk0KfXzOz1k+Ec
9kDIhcVANee8+Ki2L/+M9iC80RZm+LLf7l9G25ubp9fH/d3jN0dpoENJQj1spYjtKEsmlANGrfbM
Brec3iMWIXOxKo7JUuOagwQyQuMWUjCO0Fv5JSqZd+XeMNmOCM6ESZ5oS9eTmwiLkfTsK5B/CbD+
QlmN8KOka9hTxtLprtJCyygIAZvKLGXgPsSGSVBgnqUmVFuODqRtXofg0PO0m03t/C0qRaSn5VlL
G8HPBBon6hvSA8AZSQV7r7NDBqSSCJ2FQcKksmExycBJnU7O+41lQkk8HXeTQ1DA4XD36o8eiYcB
6sDglFveSzxayjQwhYfNES/QBwVNxm0TaI33qqWtS+0mWVT/mD50ZJs2vQV8G2sxB17QhD50Him6
n2DR5ixW09NPZjuqOFpTAz427RLL1AKO84iuPWM1B1ZtXNBSN6ZV3nzf3b7e755HX3fb/evz7sW0
rwUEQ2mupegVh6e3E1IAX6fjSyvSYGmesBBc+RhUB057Xszm03cfVncPP+7vbu72H75C8Lj//vz0
+u379KJ14yDEOT3B44gIQTagEkUWmYcyUAagVCCKGc91cBInpv90FEEmJCh58LnEwLLrNgMOc2Ok
nMxoZcypMBWpQoRZLbkoo02W8kh6FgP8xNCwofqnNhpFVpuNlmIFW556qATJoh7Q5bRcCaZoQMJF
D6LX3xBZ1whhEhzsxqxjwkTp7RXGENuSLFqxSM2tjaTMDh6eq5HStAxZ5BFczmx5uXARDcQhNTwC
cfm883pZwGZfOwuWQzSrDo4Z0SULvT5/BQcSeLT1JJ0yGfYatetqmHgIVmQOlkmaTBUK4nCf3mBk
ktmokgoHt7MILBoCaSuXc9iZ6Mgpx9Ww1ooUijtKJqgV8qMegpB0UCYMLdG/SQq6UvmEGLB1mhIN
R6UAG45IAehGox3EjKQ1Ind+n1u/63C5mQfn6KFpK+5rrA5Jy70xgDQNvBrfSQF8C1gtcJdSPFss
o8TBCUzZNcUh0HmHPynJ7MFcNAn/8IynHbIkghUh6ETCQQ/BCSkpJksyJw4ENC7yOcnAXReD7XAc
L2kyfffv9vnRjKjdwBl+g9kMqXZoqwPXcms3ElXB56o3ItQ+ls9eQnDPUNWN8WZUYcxb9uK2GPiu
optmH3DJ1r1gpTovzWSUseo0ibUDblAtIHBzfpZm+EpzbnIh2SwjiZn/0wyYDTqmNBvkHMyXkVtk
hvYyXhbC8rxJtGSSNvM3ZgZEAjggmSmuRZiaG1jSK0P/CGx0cOJUX5YLpLxJLZPTtIFjl8SYavOl
fhoci5pWTdTu0g2ndSPmFZcp9OBh45rUieB89/z16flh+3izG9H/7B4hCCDgfYQYBkAMaborBnmv
u/JGip2WYC7UkrtWbG07Zcfmz92NjlBunrcv300/qom2UlQnMAaxkwxb03CAzyGSDYadIW0Xn5l+
Cv7qRxwpLHiXwbDUXINgujRj7SKk25vvd487GOh+d2On4k36derOcl4QTBJQr3Tj3fFEzccXQ5BP
f3shgTmoHyNMzz+t10OwydkATBMOeUASf6ChhRPREPeKE2V2Ngz+0gPdP5Pr62FoLXk4MP0zSwiE
31fD/RPOs5nk2Zn/7LRwxjQ+jjTxZ2m1pGCrKr83pknkLBxgg27ogTlksLNoFvGBoQWB7bgY7g7h
XaLoAlxR/yEjZwz8qLGfsxr46RDw8gDw7OQQcGBMFmwURBNiPpRyqjGOIkg4rdNDCAlTKqGyEAep
gO3k0r+wNUrAZoNEMlYOMKGXR63P/x7cfgvBFYOlCy4GZBWSJSvSkoeKgoshvVF1QmckxOCQCDM4
3JAUukQKQ+e0MW3J7tv25tcIbws+FHP2Ef/GTP0xCp62z7eG/TaJgoRIdNZaRxmGI36zuwcubp92
L4//sx/9+/T8z+jfu/33kUYFi739cr+77cgB5+USLS9jhguBpGBuNOFt2hOY+QiM9fiBdgiiMQqN
YUoBBx/e8N9saAo8FwsrWWTBM3Y6+fv83G+HbdQ1S+J85tcNG7Oahmd5bLSkOMD4ZzIriBgPc47u
NPFlrKt16s6x5hTGnGcFE+Bezwv/wTdwYn6+Pv80vgg8recnnsZPvsZLt3F9enLSb7s8OzFvN/on
sJvWmbvBe3u8g7kMBIFNG9lRWxXd8RSTMBCfgGOGLo3pM+roRhAzfUKX0HJuZhWkCO2W6hDF/JLn
TgXvgkpZ5DkXCu9N8N7L2KMQ3WPiPeRzKqiZKAdCXbc5V3lS6NjdxMgcRqw+ELLykOhrZoP5vEBT
VsJpw4iVgkdIZSxroC88NulbZHwIFjVHWvMC9FklQYNt5Ad4HVGB4pty1N1kDutmDLciOYYJOp/g
oCanlZdf5Q3LTwfB00/tZYPl81nSwX5n41Kc+u20gTFgyQ0Mv+UxMSYHMSbnx/hAjLFnDU34hasA
DWBybPGvcafY6455T0tMh8Hjw+CLw+DJMFiL5jD4wNiNWA6AjbFXlCxKLiIqmqum7iLHY7o6KvaO
xDZzVEUExPolkwR28XJ64V2Cs3EAhqyNQHwok3MfCo54hIqF8gYq8CMWVoBtQnGzY/pYDsCX107w
u//1Y2fuPs2kRyU1Z73oa0nANgHZ80tPF6244OuTqCRRJKiU05OfXbkTGuvqYgivHfTKTk/buqXa
F9KGwzX/OCEHgG2oPLmgMVW6PMKANMdVVOBdQxI4BOO8bxuxGxh8gBX9xsqc9Qml4DSYmZC60T0W
ZTp0+ByD61SVWb/gxExgyXMSx57FqCXnRu/QUuap29hrMItbUAh49aaruSS4f0rjcAG4oeB1isCy
dbgyLeaAoUScVJL+kkaMsn6rYGvm2dljfZ+8HAb5aOHp7syYSBbV59VJH4A6P730b0BwlKw8m+1c
HIS2IhpafUO+fnguTycDO9+SbbX5EqKAGfAaaseli4I7f8Z3Opkq7neXYJuZKf0el7YmOkIwOmZC
36FMx9Ya6CycnBOBN9hhc1PmqnbVF/+kJDfve+fX5dgf/QPk3B+AAwRc6UHQQNiOI10M9hpf+M7+
aqST6S9ncJtln+SIwMPDqqW5niIt2/rMBdZuDHnNOmc4BAwFkXNtRR2MpkTOh4CJVx4bv+estF0a
LJNRDMNn6968WkVekjwHxxY4B/hwvgiT6kOYJh6EHBZez/ZFWLkKUQtPvQw1CADDa1ygcyDbZxLD
OeNhSJ3Uhp061udxmxeAOCeintNJKhIuqqKDHiyfVfWu+l5FTs9s8wURcZnHGaxILGlX//T6Mnr6
gQ7Uy+j3PGR/jvIwDRn5c0TBM/pzpP+nwj+6FAEglZFgWN7qCWjTwlGQFPZgKbLKdAIrGVYXHEAg
6+nppR+hKp7sCL0FDckZxWFvnq4pO/CF27rNxsD26jhrRH7miwdqYHZmOMV1FUMKeh7orAHEcgua
bJqVyZ/+3T2PHraP22+7h93jvuG7Wwk97TkLwGnUiWO8kZLMCkXrXSxR6z3gGtJrMK60m1VPS5lQ
mvdbarvd3ZSkWtc0zFfDlurLZR1NdogOgRVZUF305yXgIOu7b/9IYWLlp1ZXIIMVFVjjykJGM9XY
rwHXxB4LlX22KVMeUX9N4OCSWTsRbQesWFLd3DXLjcFM1T9t+wOghcXPu/973T3e/Bq93GzvrYo8
5LQfGWBLOeNLXWxfVlveB+4XerZgvJAYjH81RmP+kZBxv/xfdML1kGT5X3Rp1eftXTjYfGDMb7C9
PQCms4BYCD2gHL0++pQtFEsGJD10AW/h+OThQ2ylYFaGWRi+SfsVoJtqVzFmoZgzazXyq6uRo9vn
u/9U96YdkUpKyiJct5U5+KERxN6GMIgA88EEnxOdzK6R/Vd5iJrn+oHHGzBB8BEpzz6t12/FvVwc
xQxEmErwB8hSHsVl6dqY/CBaSiNG8KbpGD0XsZyvBnE5HI5jcNePc3kF9uAtFMHfy+HkEZucHaUp
z8LJ+RvkLi/y5fj05DhemL5h0JwScRxLHaek6EyQ8XG2NN7p+Pw44vEx8zUZ//zpQ2tc5yYjUlv+
tvcVF+zKT9/Im/WPk3Zfs9v7nX24sMhNb2OLtgwJiSLTT7CAKc0K19K1QEW5yV116YVZgoaHUdSa
E8e5riaOlLzzG6BiTr+ao9nSO3ubGeHlTkESdk3cgvrF0lsUqNMOis00flvL0ZRVbJ9vvt/tdzdY
dfHhdvcDWPA6d214jfUddp6iB9JFWRZn1Q2IV7s+YyosIQH1XXDpUpoqFwlTnmVYqBdimb3jUmJo
1wRvAd4QGNwhCQasoT8OfCgHtHBvZ6pWQZUXkKVG3qYKfJi4ihMyk/0ISPfQDGrMOecLB4hXQfAb
lqfghefhDSYwtIpWubY+ggZiTRa6VIUbDqNHD2e8YvGmqU7sIyAP0LksMp1OjDwo+vRlGaodrV6l
OXOUKfqh9RtDV2aCgnDg5K+ixXoF4axkLp5Vr9WVUWF/X7uuCq1o2pF+J/dOu6ygEJquN/ouStDY
ea2i+60IOONYh5oTIbt3nh6kOrw7gNtxI2mI6AdAeAHmFFvXkKHdoeePek1Dxc3KQbe9I2hBsEyc
Z76AJYEIHd8HOeyiulqPu+yKRY0DCgdd5+6Dz4HHOO5mPfoQp9lSGXiceIPa3jb4FihPozJd6FJx
hwxobC38nIYsthIHPCoSKrVhwYQO1gIfhHrmQNdgtiAM1i8HFemlunBj6d6wNTjWu/pmaaUjHAQ9
gGsYPL26DIeHrpGeGCJiolza2xBLFLBCtzxfBO4WbWGnkwPASdWzi6BNkr4w2iXr6Tk51jVBA6Sw
8ndiMe7DGF9M+ijVu5TzvrY1AZjiecRXWSXEhGzwEVDnlSSwrUp8uLCqq3c6n6SSdXVF5z7O6a1i
/RRclNbzBF2VoItDq5S0L21R2Y7KYtX1C2UmfPtnqHra1GF99LdJqMrBCPnyw5fty+529E+VUfzx
/PT1rk4VtLwiWn3P6OGyHUOjNS/2q1qLrkL0wEjWdPHhDHoqLHNe0xxohLVTKEj4T/DcKCyJ4bjU
WS7tmKRYx3HyW69q9Yh71RADs5hiqbXpbtRGxkrq6aZ+hslFqG4zMcd7CKvIjmFIETafoBgqZm8w
me8EqYGoGMJy2hxA86UBl2oLXw8UkzpoA8/pXTSrVqeVqcGlOwAWa6/wpYvEE6t9zYLvu/A6wj+k
dh/BXKj59N3Hly93jx8fnm5BM7/sjPchSrAUFgIOkqhcYCn5IPuyeouZgA9punlB/cTN/NmU8WE6
E5fYBC/aN0YrTKd5QTnYDLD23Abi25dAznovIBHGwisvcsKCfjvWX83gOPa8rdGnNEwY79GiPvga
zKanGV/WKWWXryNsFVgp8bqpTP1hriEAxvWuD/3V3BZiyL0vAyycXDDuMqL3cBn7YyJEQI3gOfHv
Oi1z/WUTMEyh2OTe58D59nl/h4ZmpH79MMv0wewrVhmvaIn5PytaI2DNsw7HnxNg6yMYXMZ+jIZC
CiFph2ExoIhgBzunJLS6Ns0y4tJPE59oR0wuhiLNFKKaNURwgbc3vrgWDOzQ5eQgXwUQgVOSdkNZ
53KUHuyN9dPe4cGhEEMCb/oWmU8iC8wd+gA0Zr5m/DDI5NLPRXOJeGTdB5a9u5VwtNLcMmYFSGXK
5jyJwL+JKNjmkFRWofreCO/e5BqqnV7BhqvulzELUX/8pzPoHXixCajvazkNPIivzFw2/CybDd17
9tl9oMPiqttv+DjNcJ1kZlSrgdJUW1nm4G/gqdwLFTDQ0N9kiTSSvovqUIYhbmex8nfttbeOFwSA
9deP8hwPv7qAyi2/7C7o9OLQn7ub1z1Wg+vvYY30I6S9lToLWBanCp3HIb+vw9A3P8ZoNUSGguW2
ia8A+CbVlwoDL7VOFLQLNsRplf/bPTw9/zKycEZerLMNK+ILzq9l+8arRW3aejdZLjyc42dlMBCB
gKt6vX6//TLa3t8/3Wz3T8/9/JxMCuOoXSzj+psPEGUoO6mj336nVMxoE6w4MOyKHzKoA1PLDlrw
OQQvNHN3gokaFOFi6N0xcqwFcQCsLz3RmgycgxWH5aIRm37i592YA/JrJz4v4jip41JNjDhZkyYI
FgvPwtUVTE6QO9Nv5KWbW9IfFcPXi/ZGr7+q1H7dwwgXcejQ2wbmAt9tV4UWzXKeOjGxoOimMm+S
x/PZpFDnI8tGextKYV7pEpY8JrpWsitSzecbqU1DqfoFmgvpy0s3gbIOkOH01d2n5yd/T7o8XcnM
h6X+fI/hSvfhMIkV2fgVzIufVs9NPfx60UH4Zu5Lf3ODZ8kGXNJcv16ODZuK35yrxsjdD+TUlTJo
cHWVfEJBf8zSWfObavDD+jaU0awfH/ssH8CAdWLkbzQr1Rlrlb229KrMMmI1mb5DATru1KoaFeJh
Iu0nvC1SIbT8qpxt7yXGUqfo48xsMfMY9sNmKnRZIRoQI3CHLVd/F6/RMyDKeeK0tizl+BQM038k
sbZiHJUhCMw8dQiehUt8u0FSS/MwAaqVOfZFn4ko6iRn5whWTXXB44FO7vSq5Up1Mj1m8L+lqRhY
Mff/nH1Zk9s4su77+RUV5+HGTMTpae6iHvqBIimJXdyKoCSWXxhqW+2pmCqXo1w+0/PvLxLgAoAJ
sO7tiLYt5EfsSyKRC9+F2JGRXN+vd9Hnz7cfP+6K129PdN9ThC8JGIuh26Xu2+lNS3syzrkrBqK8
Trf/ffosPqWJ+2UdCy8C4wMH6Hdl8F4sifriDOm0Oo4j0TMD16VSf3NF8DibnsLq+JfP17cvd3+8
PX35yq5J8wvZ0+ehrnfVQt3p1GV0qtMte3eSnVXwKXtM8xplMOmVtS1qefGOafzui+5XEwR8p2A3
gJbOiiiXBPaUaWZ12WdNwe4loyMwbnX39Pby7+vb7e759frl9iaY3V16riAoMHhjEtsSEvDOgxHZ
BiTOSLp3TKULrgznL9gjDu8rLEOBzLzoDN5epl6ZkaP8BjueL72ipk9TTvUgG5kmtdofI3gQ7J5F
BnKcBEwyhNOUVGEg4erPdRbR6cHI6blJyfIz2MaGb+lxU1SoZg4DRfwplkO568UXdXGxt5hTWyme
GZv0UES1+rvPnHjOYkgj4ivekFYUouxo/Lh5WKTRj/voXAh8E3uL5ArVdIbtxTkBpH1axunS58ae
DQEYTPP3Z3ZdYNLz6tSi+5tmcU86qF/YPiXx+UxnhomugDXsc9z6d9fafVTj6sGM1mE7V1F1bSox
TceM0N2F/ujzGjeSB/2dS5rh1YCK5n3W1aDnkhq0leOkwHNgijfpLtNYc7eF68DCTi8R6kyxAOXq
ExFv0EOSVkFypKfSBU0cDT4cV3rBlpQxRrUJiSDvcDOcpYMBOWGezcD78vvb6zPzQSEcZxk4yPjz
Ss+q+u31/fXz67M6F5jWDzyjVnGF305mFNPyBL66UaFD3f+/KqSWVK/Upz3avmP1EajmGnGUTcvg
KOr65tJq5jl3PtGX5ybC2HvYculQE2nnO1TVAZ4nhvNAO61HhSq6e53NoJwyQ6sgEAeoKDaaDz+v
z59fX17o1X+YJ1+W00oPmotKu8eyAt+PdYF2LXd8evv6dlVzEUvSABbH0zTFp74GH0Xz5l4SIv8C
C3JgcOXEor3HCSQDsxaMctp1C0IhOpeiP9jpAxVQZNDfr28/VPUpih48lbBrPn5RY6gmLnrmHVHj
dIRiRPkk+o5CMYN0Ut6XhHQ2r7cWbkUjAeG0AasXjesxwLLX1YYb8reR5sVuxrU1P8Eoe4eZZyAf
NBoPE23CDtGa5CvdSs9ZZhuJoBbS2nH82ACefoB22ivIOblLofbt+u3HM3Nhf5df/yPLZGEA83t6
RBN5puxE/4zl6/vt7v2f1/e7p293P15fbnefrz9o7qdddvfH8+vnf0H9vr/d/ry9vd2+/OOO3G53
kAml84z+IU6tfYu6+N2LzrzgF93h5oRMpjf0EsgT5nOP7BP8OCaFWqY8byrU4HAYTS4uB5eBEWln
MSrdWn9tquLX/TP4Rvr8z6fvS51mNvP3mdyxv6dJGis8H6TDlVLh9Ybv4SWIOV6T1LdGIt3cLvIN
bKTs6J1icMqCe7kbgflHgYe0KtIWdTgMEOAbdxFdJ8wrY2/LlVWojpHqLRua2Uiaoza8as1NYNwX
vftomsC6u0gUJ/YjhTKvmNu/kTyovcvLONK4ogFahR3PQIl2hHufmH2+6ufb4CLr+3dBsR6E5Rx1
ZZICZVLS+xjtBOh0eDkgaqVBZlgY5gKJKbMSJ3pAmbYMowW0xPdlW0mx+FE4IFeKiwhA1PNIr+KG
vT2P2kW3T35MzN3EBfq35z9/+Ux5vevTt9sX2MkGNhdf4vCAtM8jcpTn55Q8PJ3Tu162f9Rh6LxV
G1zEx9px7xUT0AXEC/PA0/c0V24nRaZHkNbx0YsCEHNw8fGizg+cs2RVahPJKQj/3bdVG+X82UQS
JHNq2kSEa3f9Zjuhwl/AAeIUsvoIl1g9/fjXL9W3X2IYQJ34inVzFR/cebvdMfWskl7EC0FRbE5t
f/OE14nVycCPyKhM5EIhRfVtBxtUmQJlweXw5GGW8CmjP7EGsMkFnYgjUUFOpZ7LGXGmzXPEOB0c
Uwf9BADjWdbC8aS8/vtXyqBcn59vz6yb7v7kexi/TD0vRosVk6Sg0ix3nUAAOyFluTAqbSi4GdJ5
hRthAwtmBsG70QqkiJpzqlO/mgrLY5AUuI7O69iUGw5UYcBwDx28zGMkYm4GTdhdHMn8iILg1kvm
IjPVy/gSe94H4D97vwIruhUAAdcEsYGpY6i267Zlsi9WMtuTNQRdPZ1+A2UQkAr5lsZZ4QgCyc1a
yw3rmTcKxFwr1eUioCLWOGGcCkuJRlVkghzqrDLNIThswVRR3c/47kevSiXquXpeZHTnj0r0ay4o
yw8rPdbQTZBEenaAgcrTmV79S7pgXdzX04Qc/U7ai+OmePrxGdmp4A8p+sy8VWXkvirl+DUIkbP9
or7XB7CDrxykAQswOBQxt1n4ZLdrzWcPCIZLxVaUK5bEMT0zvzIvcT+/f399e0c6K41jdA+h6fT6
0R+josgMB5WIpef1Om59OTHUYB+JsoxYu0YaO/W5H8eaDsnd/+F/O+Ar4O6FP8ShPCODyRvuA7jm
nV4DpiLWM/4vdXSqRl1PQzLTN/JAtATmJfolM8LJpYa5ofHxokGCXcWZKUrIDmNU+L1i9T9f1ykI
dtOeaI4JlkvH3ij2qMieix7khQSyiEvObDIIaK6pbCgXVqS7IaabY6k0UBeRnl5GwiE/pbQ0pcsn
2Ye+gn15hjdhaRYcH+u0UV4tj7sippxN4GPuXZJWjCc4PB7J3lJGBndOlPWsmeeVqbRqD2pvrepX
W6SDRQLNBZOaUCpo3IBCtFhATy8h+SNOuq92v0sJ4+4mpklvVBXY9TBP9nCGFUrth4iA2Cs05frA
CvBFSQDnPILEYVBelrTXBn3m8kSbTn8gmX/i157pE/jNDEnAS4YSbE4DOQpDKdHkMAESKUmhU1Nt
yaGHMwFK2ZUeREtgEgNeww/gNLr+MmiuN0b+7b+/3Og14f323xIZiSrC0pkaDDMEeexBHatQ8x00
uIR4aHLdmdO0XjXmWww/ZQ7qxcGXNDt6J3z6wTzs3v1x+3z9+eN2B7wwKJG/vt1loG7BPwEXhMwN
7yJrnaAoTsAxUH3fxskZ61Uw3MsqyEZSiR1yPeFzVdLaZ60aHwVgS7oj0/k9a4zQ9H6PhnM7s/CZ
4CJRrIGQPKpEoe0TcWr3oiDNoSBColN7RM9yqXUTUyc8KY8nTFoSekDSs4C4+dlyknnLiBLf8bs+
qasWTZSf4kUCvMcLHZSciuIR9jW0OU1d4E/DdJru69ix8FWdxWTrOsSzcG+k7ErbE4J3IeXV84qc
wFSc7q1ZrDELJwWd233aNAsNJQmgavrOT43pkR5nsWYr4V4lqoyywpqLNUPAadzU2HyM6oRsQ8uJ
cuGpLSO5s7UsV01xrDllHPSWUnwfIeyONvhUXqSzErdWJ47usYgD18c8PCXEDkJHCLhFj0Ta15QR
rd1F8BciydJAq6nsepLsU2GOVXVKD/VM1rsoW1C3wPaLQTUPjvB0sEAWly2qERo7w7nJOf20BtH1
gsvn6XSSOd5cuzlR8Kg6JBZRF4QbfwHeunEXIKld5y2Ts6Ttw+2xTok0AAM1TW1LvZWPjL3cDGzt
q2tWotGFvjgLouf329v1jrkon1+LX//9DfSW7l7Yq9zd38CjxtPb7ccdzeLvkvICWJhHMDw1JpCF
ME/SKNfnOio1N5x7elBCuIatg07DqKDs+K4pMmXDmpKPl9HZ0yg7F7dKLiiPSTZKQxezAYhgICfo
JUVZwnxMCQuToQa7NSlRgSSF9CDA0sYjVh0EVq2hPsxZ3t3f6PH8r/+5e79+v/3PXZz8Qsf979gh
TFAXSMeGE1vshCWYotj0yUGQOs+2d4LC8AiMj4s+KUFtUFQxZel5dThIKrwslUBY7Ghw/jF3Anv6
hW74oYwLU+9CRoJAbG5Nep7t6F8IAYIeyz45Oampp7xmcbpSLWVI8+rCfBLi5wqbCPjJjk1F8dxD
3+0Qg8VClswzM314mwTrZvy+nIC+Ab3eoAWwOW8pWUIafj6PRM1zDqd6qE/Q3ahGOc9QrvStN0ke
AFwbsUkPGT1S9XFlxh5KcD51YL3QoLFZmqZ3trv17v62p/vehf7/d2HDmDUDQGktU7WPRvstUya8
mG/ff75r96OsrEVDf/azz9NE5BJYGsSyTgvwMqBSuFH+PUgBFEoRgRngPZcPTGoYz6Ao9jRqh/1Q
6gIKxSSFi6YYsVOi9DWJTpgMX4GRmF6qy777DXzAmjGPv22CUIb8Xj0q112enp5p8nIwWS/rntv4
l/fpI3POPXf3mEI5YuG0EVJr3w9DLWUr9tFMa+932I49AR5a2/It9FsgbbAXaAHh2AH+cZzXZGPb
2MhMmISpDCVZE4Q+0q78ntZd7POJktZbXXyoCaMRy0t05nsoTZCy2zgKPDtAm0ZpoWdjvtonCJ/s
WJuK0HVcNFsgua65Ufq3L6HobuP6+Gygtw7bwffVCUPKM+nrS0MTzMCsWBkBUGHc7bgWqRlZppdW
s6fOva4+6qgAYPJhbyVo02t6AtXa4EwzrIuczV+mYoaXYnReHqo82WfkiAa3W2TUVpfoEq30MmFb
BTAvxkqdSt1aIUeegfHztqhTtNuyBxI4xvkG1i0e+i3Tq1gZ1MLp2+oUH5XZpuK6ljdvsctENd1j
sIW2iwu0O4o22GiC1gkYMObOjF0WP3J3HGS/OOjgOJHE+pBAzynUmTGjDVqp/5FT48eojiTGqOI+
mygjq9ysJMCZdF0XRWp2sOEtq0U5m6imt2uiZqmcdPQEJODx3ABhZoC4RHwAwEjzQ1Z/YEsReXla
GNZFaHV9VdLuV7s7Sja21y2PZp6u6SgJwq1A1M+bLM1hH9yd2hZ1WjDg2tgJhLqp2TBxEp2mrO2G
vtntSlIg+64MKiJbFLvw1Jh4Vu5b/RmCSKnE1O2snrdB7VY4KTYB/RDt1yK23U3ozl2w+Lygx+Cy
Nuxc3aVpLTuCE4jgrSbBvRfMoLExSgZxHYOZ5eqw3Hft71u1apSBP+XM/uXI5rxKb2sS+I69Fdq8
HNCuduhw1+pTqAQ6sb+0lavjfehvvGXmzX1o+WuTgHVPU7VgvAcnnmTpxiFJtHFCa2jlgkdPoq0V
uPioXygTYsNsXo4d9LxhKXW563VIf3HCyjrkGEWUxInZDvyO4B62BsQDcYLtYuazoytA5hAlbBwH
242HOVZErhTwTUoehEFKnklzZtvA0OXavBku8LVDw8gbgayUw159mUWOjj8b7mGxAwYubBUZYE3r
246ln3FNkXmKhh5LUvqApdHRw+X0jFhgPu0YaW+5Su40hR2JlZLuJIN4UZyc/Avb1mZvO2r2rrVI
8RYp0bIQX1KMYVe94/XtC5NgZr9Wd6oYSW4C+wl/yg+sPJlem4HDkQSpkJ5nO4VxUABNdEFazmmD
rJRmoNaCJhXcd4aSXdTEGk5loNdQn2U9K3ozoUSi0VfgTT+VXmbMnd/JxOqeeCfOhjxRkQ5uaiex
BzYGk0gEE3hwgco/r2/Xz++3t+XbVit69zpLkSro7MtT7k4hjxR7g3M7ArA0NeQDpRwvE3GXlYkk
swRnTNuwr9tH0YKeu0bTJXJHA785fqDQaEVjyr0J3yRgVSa4WBu0ut+ers9LdRzOnnIFhVhyuMQJ
oSO/BU2JgucjwTxDmhYj0g5834r6M+W7It3VScTvQfcNe7iVihcdDIgEcecV04u0pIzPDieWTX9i
5lceRm3A2WuRThC01jzUjc7pjACM6OWJdtoZclvvC42ertQVuPd5qXKauMQChM4jd6XPm9YJw043
zJXOaEIE0b3EDjXyHWm02sDfaOJACzC6lOpjhjKcUtuGSLQveC51h0kfRASTUOg+p/fRjbPBZS/S
JMPUtQYAmO/NyqSD3dm3X+A7imZrlz3oIHLjIYeo2NHzILc04vMRpVXrHgB6rdgBgEn/VIxJ5X6A
6BV5RUDfxqd10KnVqMoNTYo6VxebTIIY26STic3kaRfVDzOs+TyTFZYU0nhurGcy71r2cgTAHRLO
tA2IIzGIHMexlthDIXF5Go6nHYhdkdbpo9GPI0CMW9S5DX3zEK5tPyTbZ5rwOQMip6dThiukjHnE
cdmZS4ntICMb8w5HD5Nd2iSR5lFtQOltGMa1zHnA31sWp3vB8S0R2NTSfLJ2OBUdhEpTQDJk0Neo
ST/UzkQWJtSiRs3WdY39WVC+crXGlP3V15Ues3Q1sHouN3lGzMp9nnbmFtNfacd8smSHLKb8V4Pk
xjygmPcryql8smVVfSWPullcKFjWxcoiO6e702pPVRfjCUEnrrGMLN+lEUhKSIbrVY7LjW5ha1Wh
pwhE4zFBROMGzcPyyOSS2tw9DNBHMW49qbDQypAUcdvkXBC7HJiSqzMkUYM92E1PC3A5EbWRQN2W
puFX77ogB5Uql8r0LU4YW848AEF96fdw5ULyqBvuBE2oT14bzqa6Vt5yB9VM/RdZDXo2tFdyScoF
qcAK9YNr0lmswSig8cPfYHRZJuB4MGUGNM2eB/4SySRbZEro2YBLUoCa1aiAg9Eu4HgwqQ7LeoIc
p9rj2Q43gHuQzAN4p7HAKmvKWXbdOnDIcNeaYdBOFDHXfId135QBvdVyz5bIx/Q7RRudpmgmVxvT
/0WfukOC0x+LKFaSM6LwIUPqPK4jTPL5JCT2ceNL8WJHmu5dZPr2sXw40T7An7qEXFgJuoYOEMZ6
LysNJHq4ZGUqKoGJ1GGHk4ljblJtxnw0NTm33A1M94h0U+u6n2rHw7pppGkkvQuYNA70nM8fwX1S
nEeiUsmYvkwBkwxBaWopzeGaGLQuSzUXUZsP+o696IFtkbDDOMyPbcP3KyGxOHXj3av4+fz+9P35
9hctFQpiRtbI3YuNa7Pj0i2aaZ6n9KqJ7yW8hIXyAgIocK2XgZ63sedawaLuIMXf+p6tI/wliZxH
UlbCQWAorkkP6odJqvl0kX2Rd3Gd4y6pjX0s1iJqG7lNg9s9kHHJwxrlhwqcvL6oiTUz8J3mzSRW
BCdemmE9Zp1/TCR+YZ533CPWH+ACbPCl8LeX1x/vz/+5u738cfvy5fbl7tcB9Qu9xoOThb8v5g3j
tLXdx/d0Pbnd4swOI3Zdps+ZXiycUGMJOtAN1swj4r4qDUVwi2ktXW8by6iwCaisFJt40ZlOOkyM
wqclyQ4lcyfJDowXDZHk0TmVJ45AxWx6FUhUJJlGHM6QI/evqWdapGdHzZ576tIPinHbOGgupXwe
H470Zqtz28QhBBcVsLOpwOU4nIbfywYa5Ri1mgeAqGr8fgvE3z95m9BSe+leP+dB49tALBbbkEDO
69jRPPoClTj6ZurlZYyaxXQdgWmxqhoqw9rA14gMOHkTaHS7GPkMUUMNn3f4BYrxFlURJZm+7cCC
akaoWmhksVSdGIYRNTdLtmdBiFpNUXT71q7LutS3XBHsSjRuaqORkTHASd+QJstQBhpI926n1rFp
862rEV8x+qezo/GXSanEjR1PI9Zl9GNf0GNP23skK9o0VuukMXDlpMJ19rg3h5mOS+cZ/VQG9Ark
XPSda+asAcFFu7taY5QIEEz6jwJ6zfWOQiCOFLPW1iIuhb6nuBBLT87rrWFhNrGsRDeEqKCs7rfr
MzAav5ICOJTrl+t3xv8uA72yWc7teDWj30YVoRfm6Vmhev8nZ7iGzAUmRs0Y4d4E6p5k6pzid36U
29OyXerUOqGXbSAtj22WNBg7ycc9p4AZN5hzq6zAbogKK13bJwowjPrDnUF2qkxKaCXSMBcVPcq6
aXBP1XmgBdrkgU9ME0M7QEK130uvvnV2V1x/wNyJJ4dDWLxgZhEzhBMvUbcCDME4VuEFdUobGS45
wyKvDhArts72dH/XyOYAqG79MrXZup5G/ssMeY4apU/+8RDOXPd4ABguPdH5weGFaJ/NRio9L6JE
UZQRMR23O6L3QyX0D6SaWHKBrphDqBD1uQCj90ei0+YZUP3DCmBHT+NFLiIka3eRZKQFiacWBEr5
ozpL9FcBgTp2rjz3RmKHLCXzMyWsteVdQlmLI7+vhSxtFQTinizqxF8ZTL0LCGQeSRgdsz95Drk/
lXWqe30V3Iv0Z9N8AR8j8OShH+dB61hIoXcF+vd+0XDt2ynQ+Nu8gQ6OkEbuTwv7XctgA/We/qER
/dfgrHlj9Xmu79bRLdJ6NfI6DD2bMnyaHX94TNrJExkSVWPbIdk4FdjlA/4V6/tvwqD+CxhCuqQo
J4xEY1uDWkvD5YWTtZcXTr4Hpzha+oVeQPp9ptECgHn6IYBx1fGHX9UzgHisUjYqKxdbF9x1HM/Q
9jYzb6ZVo7M3BKrhzXyk9uRBnzsYvBgq16Rwdt/TA19xaCWjqvgexn8VYHRY1Jh6gd1++lgjgwAE
u6sZe/KhBkbD2BLdfQ5o9IoVeNqtnMR2mJHActQJADcvklX47YIDDCR6iBpaZNJXADJjcIvW2eir
Xfb7vkJWLDk4lucZlx28MBuJfZQY6q5/iB6prGIrEOOIg9U1ifFLKqODSqqJGhip8OxM/72xDHsX
eokV97ZO0TmDLQGutY5tsWNev3EAyrb1rePZWHTRgQPddRiYY2pRJi06Su7AQ4F8YPF7r9q2znCE
gnYkiehfzDuEDvWJ9uhi2BV6UfeH4RyaLznCWwKmIgeDIfPO06dj1IrhorS4FtH/FUNgmTGowSMT
j+KlDnWeBk6HPQtOC1hllIZrKx5efQaQR3oXLMbAHfKJnTyWET21xStg9eefzAPH+9vT16+LJhZY
Zx9FHxT0h/SQxtXj6X4te7Gdk5+fbt/kqJqQBTy6IUXVtRg9rR7isIzF0IQxv+VzH6DjPINIUvfQ
aY2c0UBiGtHi4Ag0vexEAKlPEUBizubA4Ggxqeq2pjWGuADL+rZ1b/thSDOGgGlcb5pZB3LRzzcW
77M+PlIOkcVZKdP2UjX34JOczQrSRgU4Lb97f6UFQliC2931yxcWCOH6zIv98Q8xdseyNlNl+Pvd
0n/eQOBRZcWxyUp4IsXw8NY3Bp6Xv4B/4UVIBC5Wmas09/VQmajAd0uBrnuTmSC6JzMRQIcac1Y3
QcBGTLA+m9IvW182/h4pu8IOQ2wTGAHxYxhv/c7CPk6iEPSTTzUmhJtBWytwsM/ThxPdqHdNdsJv
LBPuMX3A1M1G+qg/jYzLvePikpURMN6dcH5gQi31whVEEdeOS6xQfuNfUImoe6BSsQbMNxyi8Ssw
Iqs4zasW6+c6g8iRR+PXzAAQ+9jIYY8g1dBeJdMRytNlt1A+at9hhfKQS8Yii7zb7XGnBVOPaN5z
plXBJWsHnI9RUbj4S0Xh8QCm1QaCMltz65FAGmmbgNHG2xEwgWt/AON8AON/ABOYFxHHfKQ+KyD2
+q9/cp53rkNJueRCI5UcYZpIRDO5Xi+qJM4HyqlXMRFxN+Zpv0sbytv2u4MX4+8+UycVnfk4oQAH
fyQTEeZpSBErE5UifHOLALFaU9+80ikiwFXjRYTGWEmGfABjHkOAnFZz2Zj5BUCcNPcVARNqohBK
EFyEI0E+UNBq94YP63V50AiHRUzSrXZe+IGuaZh7oTXU1jyvWEiED5Rky6t28MX0fnu++/707fP7
2zP2hjkt6eixbaLM3Or4mDbN4zlLcWu6iVF5LDsWINpc6XWh9bQj5Ql4bL7HRT1TE5qq0/nRmVoQ
lWVVrmYVp0nU0Grh8oCJqUzLc9qsFZnm90ewRlorMy2KrCW7U4O/Skw3jrTIymw1t4wyYmuY34Ff
WO9XAOyzVKMbNKHSS7Ze+yJt02q9SA5bn0PkVDYZSdeBbXb4QEvp7bjJ1ptaVFWD9chkdI2tOa4z
e/vydG1v/zKtyJS2BUT+5iq0zkbjwneGbALHvLMwCP4wPENCe+V0BcjKIc7fzVdbZJt5N3BeFKzV
RevfSIRs13PZmltEIeHKvs16d61Fm224Oozb0MzQM4iZW4UxCtZaFNqbtRaFdvgByFp1KWS9utu1
rqOQ9Ym5Xa2LuzqlQt9eyyVw1fkyanDrVjy2++jUJCfu3aCJOGLgMdBb4TkGo5lVjM4Kfaqx3p5s
uvZ3keObc2FO51YK0li+jnT2+EXILls4LkOkKBEBs15JVMDjkN2+3X5cf3yEWzKFFJqatR/UmFdR
TRjRTWtlMs9As6RAyNA8CSbgyn45Z/jB/LYrN6m5YPMmMGdo3nJm3AfL3a6seAH40SYHHy16/9Ec
Pzptwo9muHKnn4HRR4GHjwKPHwRqolSqODcyL4Hmk0aRTgCYu7f5dHDMV6G5zh/tV++Dk04TjmWJ
++Cq8D64X3jxRxuSfnCyeyvDMAN3a+NVrgF0yuFiWeS4caz1XgNYsN5pDLa+dVLYZkWKPMHWRx5g
7ofqtvHN7N4IC9enJYOZOaAB5n5g72At/dAobJyPtLRT8hrjIWtOc+TizcyKzPfMpe7LElPVx0PV
x2c7tCzcrAuB2g6umaBAQR1Fo56LIc0TSUCubDYi0jwWpI7itMhanfnRjAPXuDG90qy0po0aUO7p
fz9udI5pUKxtwdP//xM+WmG7B1uPlZvygFrZEga7EM+8nAbUR/I6rh0EDFXUa7f4EbaybQwwZwXW
Zn1WJWmu8e88wozWKVNeRX3ebNBg4PAmApqi/1ESWPSfOmqPQ7A+33ZGRLVXlHLHT7LmYYjEOdWA
v7hrnjy5PbPiF39K7M+YS0ZGHh745RqADbEUNoAlMm/mVjcqPxQ8ruPL9fv325c7Vq+Ftzr23YZu
Vn1RyCoZjGKwqOV0vUmtQF++AysorcEBbyvNZQeiZFAQ10jjuSNdkxHthOgOxGCMy2H5p9oONPsI
RyzNcaUx5Xr0i/406tBzf79ag1xOvkT1bjGFUmYTotEv5Aic3xlmWK+qkInkfQt/WbalTMFJ82Q0
I1RrdWiiMoP5U2cJ5uR1AKm6QCxZNaCVaPklWXyQyQ6jRRKzmTnHi/pNOuiBt8twgTDHGTzsjQBt
NG6+MHdhQDaYLgYnp+Un29ks2lTUcagzQ+UAvSY4p4N3IgNZExZ7IOLHIiOaREscACriK8tea9jK
PZvmluaaPAajgGMZjM9NK1lnr8o3lljjcp9TNV6ZBpfSSxUTid4mi/lGoiLyE4eeVJU8KhKIKSkv
pgLJKsM8ICWo1tEzwQBZ4bgGkGkPoWdk313QSKic/khi2Qs4S9b7JZzJOiEwRxAvNO3FRraA+0fX
vokO7tOh4i2uvcwQHWx2PdHu90vtXZ6sefNlRNC8NVOLGgKepZSz0ZUL4dX28XEx1QoSuzbO6PHd
Mmldx1N9wE1CaC3fMPnrYKm3v75fv31Z8hNRUqqsyb7LA88KFz2UEE/RmpIOhwvdBhKUy7GWuyWk
o+E3+E4ALlvcTslsSB3iASt7B9A08poBAK7ptSW2dRY7ob2sKZ3QW3VCC+auSt9yXm6fLPtc4aJY
ZCOcbeeAJvtk5o4S2l67uJxRyLGN+9S8o689XjPQ0nOEfJa6W89ddFlehxtfI4idRh/iM2jPWKBv
5FA/fBALcH+2ykCR3AmXjnfk7bGoDc1uSy8seo319zBfCG1AGChTdAy0gCVvbWc5ux6KLsRCujEq
j1mgsHI0cbv1RBdRyHyblN+Na5/eJezAW25I4A52i0a4Eha1rdSriF03DJcLqM5IhQZK5LsuPU88
azmHiqpr1ZAroyfCZbNYc89Pb+8/r8/q5UlZV4cDPXpVzXVl/oJbO23jKTNxqpW2c8t/hBHAfSmi
NWVVZSnJ7Y+fX78+fft69/P96fnp/emmDhyUBw7kxVmg/XRWMj/3LNwfvU/tBG3Ziz3akti//Ptp
8E8wm4NMqMEGn51jUZeJGYykhDheKM3ymaYwsAu6erU4Jg8jSWU+F9+SQ4YXuvSwOfQW0lSxC8jz
9X9v0uyheQ7mKce0wZzCTAACfglekC+hdyxM0VxGhFLPigQwWkzkEOgSwnZ1nwbaCjmY23MRwfW2
sU9dS0ewtcVp4sDJGCwCnYjwrQ4vmftMQgnaKoWphZk8yBB7Iy41eZIIYi1we0kHiaSoSQ2jkvTh
lJYxhER40VH4o/cllvjzAXSq6xzj6nnI3hfpJ90npMs3TxwcgCgXIu50/fpONyNs85ziXdPb9+lw
anR+yRUU7lN/ACUb15ZiBQkUz8YGRQII62ROL2zL8fE8gYQdtTJiq/3YxcR+IsLebDQfbx0PY3Zm
RLvpZN5TJLn22see/mMPDSAjIQJH+zEaJVNG+MgwHFsbi5UO2udYcgySEbQOXdbvo3I09TPPObLT
u7kfIVoJ6ARpu1rnRnmIBN/afX3W+W3mGFhccVTj8WA4JCEBFoAeIsTjfQEBaDvcKzYH7Dc23av3
yzyBEDr7A0bx3Y1PloQxRhqP2Lqoy57ER41F2gRp6QF8aqM2xcSJI+qQ+3ZIimUFKMGxUMImsCI0
GZ3F/EIb6WI6DCBw9gHTrNU49ByBx+wY2K5pTRwJve6i43dsT8YdJNsVUYo0mKbXaYflmIF8FbZ0
U65wF7IcB8m3DdHt6vfYM81begw1tuOg+w1EnA8C3Gf/gIBw2Yd0WZu8jZ2th+7cnLTRuitWcRr7
aRG1RVYeJ9g6AtKD4IrW9tHBBpJjm1YrQ2DjwggesqsyQoDXnBLwmntOiJRBb3A2/Q+rOZA0Kr8i
JLA0F3wJZG8NPcAQQairhKx1uQS49gbrPk5xkW7iFLEDWUrooMuA0oIAlXbJCF0nBoGr8cslYlAZ
iITYbnQt2aJrkMtO0GvGvLm73rnxLayP4tq1HGQqtXHgo7xaWxPHDQPTzlY0G7qZu8tM6enSoTtb
XgT4PWEGGDkTSkaKo6n4BlNoYy1NAFyfcQZodPUEwFqDNNJAAbBWSY0WpwAwbeyUjPYZWHZ7GoKH
b36MZJqBdRxu3ACdv0DyHNPaL9uYX8Iz0lbNsmZl3NJtBWkLEDYbX3GPrFIlA2uBSCuM50kvncg+
BISthXTcoKGNtb0kkatRKBshVRz3dbh6FjJp99a0KOs0zvq4PrVpUS8ryahJVhR6snB9LSRH9hNo
SF7y2PEuhbgyB8s1TUi4UjlBgG0blIAv5SiptWZ5EwMPtml7PMLUgKijviEBtkHGTY00NUnzNqLX
ntS3khhYSYTVJnXvPi7TIQpsvN+judZk61jRDvmojBzXxTogK0l9avqsJrWJ784a13ewfZ4SAvQA
oITQCtAjYCDNUYiNBdfE9yysAJIHIb11YFuN41vYRBgIc8FysJeRCXKtjcaV0AShNyTH1F+MB9wg
EoeBIFVhCXFDW8faUgbNJJQATsh3sf4auDB0RDhrpbEiE0COtTHeZjjEx0unLEiIsKlA8TwPZ8DC
IEQ6said0EfGF9J1+C3OeNV0NIy8DwVg51xR+5aDp2+xezqkY7eIot5u8VOxqB82W9f50CoZsFj2
DyHv9eWWnxWe4mpBReSZ7VjbHXK+TSTzWqqLYBN4ranqdZdSvh892h98j/xuW6FGQ3+EkbZOklij
RDqxnUlEuU6jVA0402GQUK4VaB8aDQr2LM9B5QuU5ruBzgWvAPKCRKPzPKJOcbLVaQKLGAfVlxwR
XVJvMOEbTU9tH5lSjIA3biB9qJM+5XTUkXLr1qfzIUdn7KVYFc2I+oQLWcdy6iAPvypk14rOvabk
Y2sjmxlNxg5Dmuz+hSZ7eHKMZfK4CdwAkWUlRUpvsMhBmBbx8Fi6JDi2hTIEQHKN10GKCC4OdsSQ
gsTepjBQMLEIp+1c7OZK4qMfdF0PPvUqhEtidEf3oRtgLSRtSzYaw7QJs4+BkzVjmNI8vQJj+l7C
ldV2wiS0UblFlJBNaNyDGWKDC7vpOIQ6f4sC42eZhCoA6Lpl/zGOETlKabqLMoKkTnwbe2MZCJTn
bdO4xU6JNt6YHm/aYxH7yE7RFpR3xzdZoJjvzwxivqRTiGeZrkQAwOU5QNHYDQkQ3zY9d51b27GR
jr6E7mbjIsJ5IIR2ghO2WoKTYC1gJFP1GABlLDgFdmpVPr4E5pQ5aZGrDCcFJd5MuuKPyLsFp6Qo
iWvGoBcg8D1S2BZE+dOKx5n8IBK8/w0JYEDSZqTNYrKksYfTPUJgzqHBB6b0qjtS0yJtDmkJkeyH
sIg9M5/oC/KbNTdghGv86c6V2EenvO0P1ZlWNq37S0ZwTSbsi32UNfQ8ihrs+ot9AFomXB9VCo03
IPVZotCP1ReQ4EGf/WGo5qJ6Az1Jz/smfRDGeFFEWgA/k5mmBrexEL5lfuMHIlp/CPm0Qg+Lwgi5
d43kIUaFCULqNGrMiFMZmhsy+bQ2VjVr7i9VlRhBSTUqzOhaxANUGPNg/h0xyOx35f32L3AG+vZy
lW37RU8NGEZwpLT8nBGjuM7u6J7ielZnKsKMk/3HoLXYvb1ev3x+fUELGbpiMGQxdhdYzZRkFUI0
k2SoqLY2rDrt7a/rD9qYH+9vP1+Yb1pDpdsMtP6Npa3nx/UZry8/fn77ahoGHUSY3PHK+mAAul+b
lyIzI9dOyvKcJVlE2/X17WrsGxbliXbPQqlMgUAgKGN9GMy1+pafg2g3G2s1bn+jpRBldKcddFAP
fPh5faZzAp+iQxlajLhFNeZdY/KZiqEGjBB6WElRwjhMyWV1iR6rk8SxTkQeiLnfVVXbp2W0y1Ps
DjnBqzotmUdiyM9C8iOPZI/JE+cCG+axua+bdMxnsAS8XN8///PL69e7+u32/vRye/35fnd4pX34
7VWePFNecx5wJi4m45RhwgLIogGQqn075afdhX3nAxgfxYh7uTsP3st/yZv8ksBVnpE40xIBwtsf
KeuXtXGk8bCYp2V1riibSDnDS4Kr70wYV48p0nLv2MBbGvsCzMSsYGvqDM7DIjOZG6iInTFlO5Ky
Mqku5hp8yrIG9BfN1cw7bUtHYYo5h4EnMWPGMFRdtwIkxdYJrBVQu7WbAsRg6zgSFduVMrmll2ca
qTHSEjYi+5b2n2Wv1GUIYrhWE9tea1SyMuo8KJMZA+rUZkRddp5lhWvLnVm/mkGUo6U7nRnTlH4b
2CulUba1W8lnDBhvzode1GkPdRCkyIzkpmxrmI2jKXFcYVEXiCMizh1uB+OslAFucrWLdHDkql/E
rnPQ72VVFzWt/tsWrGVXOoCxJ0YIV2bWbqdg1Hvodru1/RRwKxDK3UBIH/OsHcMTm2GDHfHKxOW+
wrSNG+nNp2gdUtrrGMpzroPOzlEHGkz81xaIu3LQT4FFzb3TJra9tvuOYZiqtq30ExE4RmM2o1Xo
ygxhlpYrRyILx7i6F7EAOeZ8knNUtinlS7SjMSHSWAtKd3Efu6GnB9A1rCUyneAw1fds7Dt6XofQ
svdZW8cr8yE9NZWxpdluY+mLAc1XgttjXaJ9qm8dqLDazt5I1xK5aaOhZ2zHUGempmS7WnpgdQbO
ik5EeNFwbdsMcje7jaEJ3HpQSx4lqyZAuNkY6VsTvYji4yfj7Enrjs7elWM7izcWHP+afCAWwcbQ
mxAr3dOPFE3vi1bjrL7tuq2hec05zfP+APuKvnIQTMFEZ25OPgRYRsAVYRvLXXTSxAUc6oTtISJ7
Md6jbW3hoPhu3jGZ0wr9KmBR+MzURBNAuqhh71mM23x/6iNesvTENPp3Mp9PRW5iyQjZ9XVFSEav
+YK6DtlJP+gSL+IsOlaUDRLQc1UkCL4CKCRpaHWbvshq3EWHgFHtteehj5D6QrJYHwZjtdU52WCI
tfqIoANd4H1cYFJyCVaLTpc4RQxixcKT/fnz22eI03T3hUshFt6Nin2iiG4gZTCUF3S2ITFuw63n
RxIvTdNZ0DtanSjBO4BhirrBreJZzvTO2J9IhMbE4gAIdgyRYSlXK3b/TDzmcYKZugKCdo6/tcQH
WpY62vIrzYRoSx2WNiipSoXHxHNyz9WqhgKGXsMVF1ESsfO3G0vNd5D84FYVIyBw5GpyQc8izfYX
2YOvjvudu9XEUWIQ5sWPu/fVgg6U9YdgYaQ/oIFMWQtjG65+8gwbEuXQSSIB6euidnTe1Rm5o7Vt
TLMQIp/Qy6MJcswCj26AWq/HA8b3uwVGQGQPJHCUOcQ5H7mxYVgXoai/Mycqiw90Cz1/s1mkMpcO
i55i6aiK40zeukhmG6Rgmmp7WKq/XaSGW0utYxsoSudjqsZxyEjWOIxn5FEcqEXwuFlI+9NPHbgt
qeWBiIckKY+y7VJ9CU3a4ua4QKwL1S2VuBlOKkhyhq0XorZqnOhbrjJgNM12lMnT3IfqUmNJsoL9
nKxEMWcELhjSVT7zNkGnaPNzQgFXODb9l2sX0xFTTggfVRNhtPvHkM5+Z5FpDJFo9Yu1+UQn0glX
YYl2nU/5IDWCt5g7eCuZQlq2xdPnt9fb8+3z+9vrt6fPP+64NxN4XHz78ypJ+Ce2iQKmHh7fyj6e
0eKYDbK+bmLMDQKfVsy5lDKalIuOCtel+1VL4kh7RE5OZeRP8+Ikdjp4VLEtH5vY3DWLqAPJUzbK
Nii4cJHryX246Nd8ywKdb1zdqhrofuBrstbN6KX3mCmVO49BUrEpPtF0EYRnkGfkF0aM/vC/5Laz
cZFFmBeur24T/L6qMHjc0dGCleLJau0QxOLcpozQJnc8NcdL4dsa77kjGbWz58Rwu93IxbC0cJEm
OeyZ05bVFPz4SEv94oUan5PDVkDvVHnNXg9XUAyDvUIOEDk2IqtTnGxdTzev6Y3KCRYMKU/EpuH9
MUoioipUysMcg0MZ2P4M5xsTIDP2RLdw6JBbuW8h94eRsjh0RoJy7LAnM1KbdmNZw2xZpExHjrWH
MqqNvdKQ4mSY+Yw8BjYfVVxMd6zxY1S3f0o0SB9mzD7r0qQ/V3kbHbAOmpHMRxFTjivJqUgFQ70Z
A+pbTHvLiKJs6CEMpMkqEYsQ1YifMcJ9cUlLfHcb4pTat3wfLzYq6V+YUyIBMi0X7PuLu/EtTCFT
wCj3v5myvEYKtOVlciYuuEth9Nk1bmX4+b1uHWQ7GAclQRzxhFYoNkbZR/+XsStrjhtH0n9FMQ87
L7vRvI8HP4BXFSxeJliskl8YDls9rVjZcljyTHt//SJBsgiAiaId4W4X8sPBBJAAEpmJ2nd93zfS
oggtcQ4stUmnrOSnTkP/gjeaE9rYWXkF8TUucNFOgE1MiH6FoDh4pbBrcHDZr4J8zJ5fgwQoo8AZ
zY9iEykIA7xpy6lvp3HCXc0QH1RB+THqwK1gQpghxuaIm9P9IgIfHRSCFvmhgRYFXmysOQqC3Yqj
KDY3HY6muwXEsrOOQnIsJfCgRvPUuA46O9CjuA660fYQ3J33i4gcvIWzTkXdL6r0UPbdVklRjPMk
bW3ezzit9T0bb0sbRT46E4BiWm+Ea97ewOsDF5dhWxXESmsTanh3SsKkJDY9ASahCg7ak9KwEuyW
E10MDmky6PQxN0VekmADF88Gpz4Nhb4Xr2FiAxPFXrHLi0OOe4rpyLbCH+nQcKyt8JOUhjuxZByS
0143doQ44NZ7+0Nl37e+OaVHlnY53Iv0Pa0fsOEFr6xHOGNAp2NwCNZAtzclV/UPmh3UQHvZ7dhC
d2KcFLrofAQKPlO7PrBN8wlo8V5rAscz7AC6/oNjGx7kkVHVYAjZoBQVhP5tqQnVOabOY07Vkt3e
AxSzd1F+FYWGByMlVMqP9btFzdqwmx/GygM/eFuGTppOqknTQLjOveoEduCzOznhTjI6tj3vlQlK
qQR/0kcuTBzKx6Ey6Hkl6Kl2LExZIkF0v0+ZFNmWkRQ5nmFREsRwT+KBG7IduHt7fFD6OO7OFkeA
pkXSQAuNNNXTXqfdyodvewTNdtHlX1KpGT7Vd1CFhwbSgjer1Mj0Upx00r0V916SAsKtYEgMnnbS
6RoQ2AdfPeMwiqZw0havkiQ0wcLmd1c1x2pbQDtMPcGRlXyjwX9nedpk/Ji/JlJ+vJoCkQqK3CJO
ej9c82CWDrDbgxvD7Jr9l5K9ztHsMqRL/ds1dGkglS6nV5Wh1YzUD83tUsFHrpWyS5SmfjB8zqVq
b5Qq2DvQNGdatrzGfewoaHDqPr/Hmzi9e0P1RhzpxT9muNyAzuxzyGQimx+/XYhjjx96gW54LRt6
+jQ0PerCByzNO0pKvZNE4th3pGYV7U0rDu0ma2MT8UzrpKkz/ZvXPimbpp3DNK9zLR0NViJiOqBm
53mqHZQgpW56eMhcGpmQ2tJ6uSDiP+9ef37//vLjTfbxEOaxAtvhi9hczMh3nKAAqd9j6sdrIRCI
uOkU4xzR3mPoOtiGQDT90kLgjjhW74mBNI0DgltmrICD7RANJWH0EOKinaTinXng2x78tCMwhudE
JlplWDGBiryXMitk5V5QubdyDkvm8xPe8VJ0xjM9ybphJKe+YXmZp8pgWl0hF93v26/vagDzuetI
lXfXyow9TGpSNoexH7B+niBgSN3DbBqw0jRwRzKIh79TK8s6c33L01W7pYAjtlKM7AWqsmfJONAs
B+ktG+BM7GpE4OFSdMj8ysCXxxevfPr28++7l++gbZfuWadyBq+cruV+IenQjTnvRvVaYAKQbNgq
4RXEpH6vaC2Oh/Uhl5ZVUXyVVw7/q36LoBTnmq8iWiKBBwG0tFSO7bakXO93rk8YbNkgDcLPL9/e
frw8Pz/+kJik9QSCkYex6oc730Tf/fn0/Pb44/HL3adXzh24uoZ/v939sxCEu69y5n8uufUi14+b
RstkyMY2HUY5MyVezImwGqfb5ApJ0wKwS8kgPtAJI2MahrkhyoiKXKCv2bvA08msVKtm1wgG5jKh
t/v2oH0IP2452kq0pkMeLJ2PwkaOardSsmqaWBStZ6hIWTbKYFO7T+rRT98+Pz0/f/rxCzEnnORY
3xP1yaXpQ2HNVe/XJm/vn1+eXriI+PwCz4r89933Hy+fH19fX/jA+8Sb8vXpb81xciotZa5rCD6y
AHwXDYi5kkvXIduhUrHW9VA10UQXO8ekL8aqveijj6+0oefqfSMW4MiztnX1OQk828e29RLAwXKW
g+tYhKaOix0fZtBATpl8EzMlnzJiu96mlUPrhGz6KK0yfowJDaF1V0Doo4vy7/Wv6OAuY1egLuAZ
IYEfRfIQVeDrQiEXsRX24Jxh5NdEd3XGQLIXbTobkgPL27JrJuyIG0BFhheDJ0TSR2g05yvVD7aV
8+QAu2+YJyErwzjefss9s2w5BtQ8FcgldmQFwJxcRgH/wmCD550ETwDjydvJAtdiofqYlUrROYiB
Nq3rh9a3vW1tkOxjM2loQwu9X5npZyeSg8ouqXFsYaVBOn4PIAHw27oVgFrFLLP04k6x4KUhDzPp
kzLRkPkT2uGGK+nF8RfJJG8z0In1+O3mxEJvF2W6j80gFxsAghDfYiMgfPSdjZl+H0XbISe4oAYf
lwiRebnojyxyLIRPV55IfHr6yoXcvx8hrMbd57+evm8649RmgWe5NrL6TCQ9crVS5bb4dSH9Y4J8
fuEYLmXBMAVtAYjT0HeOTP6i2yVMlpBZd/f28xvf9WnFwjkC7kLtOUjwYvCo4aeNxNPr50e+h/j2
+PLz9e6vx+fv2/JmcaVaOM3ix3dCQ9zt+eN68LWg2a1JfWShO990Lzsec6ukvn19/PH06fnp/x7n
9evLo5SynRgZi61TEqNRyhSEv1l1ZkKwEacglQPFKFtJD7eD9Hajpc0dGB2SL5++v6Efc2B2oJur
KNtFJbt2QjzVQgM3lfrz9e3lK6/9rh+m4bHZRQr8mHvaLYZMLFLLQiXABuTcLALrGxXEZaRsaS3R
aM/79oLTqigSEa2t3kCH6aIZrMrk1PMYfjWowBi15ECSCq13rMDIP0HFZawOw63ZVZDtmluhxBRX
aJfSteyuMLbxUvqW5Rt8UDbA8IaKQsA+VHZmJ7xPPLw9gs4Hhbw7Vui9bdlGjnZ8jbilkplQjDq2
bzB1VmBgUr8L42cLO3Jsg5XtFojac25gvmG8T9TQ0NOcyomG6SCIsbncOIpCAzEnfhiY6hREU84T
ibW3gWTyJXUsBz9EqjDPFCRYhfkb2KKZRATeFNbr5eX59e4N9lv/fnx++X737fE/d3/+ePn2xnMi
Cpzt6Xt6w/LHp+9/gTfBqoSeG0javOtPXT4e87Ld6lvWn+R0yShrS/IgabmPpCtTyW3pmHleGFlL
LFk9fU3guRxJEdGSTihaW1LnpZxcw8MAE/GdpSV3TUHL/J2/cnsi8FbVhxy000wziF31xFPDxwRi
O+L31jIEu9CQ6EVJ2FH6NlrnwCrpPqmCOA8ppfDd8mA79nZw76IinFyCWDawYDkEQ8o008mFYdcS
p+Af4HNqsFiHkIi0PQ2uyZ4666plHeb/5ANveb5U1hqu2Pntwgp/VhUvQapK7MTGLJH0m2sqk+zz
IfW+YvM4VdFZR84qkvOFpkjSWPCPPnTNCe6KIOTIO+vvP8WfLRSuizSoJf6o3z+BTTriFTFZCr37
x0++t/qHTE5Lmtf9ON0gUBGCedpLT3P18Yvg4ufnJwjDp3O/EKprNHimgpsrKXX37GUfjtYlt7Js
SDbycZ2NBe2qM5FN7EUfTMJhzFoQFaPy/IhMx/ov6Wh2EAbnNWeB/GADUjI/88vKQwzBpybniqE3
JPDcFrw2lt6kH7P0dgHHrKKj0K/tw3YBEAM3R2EHuFkAN3OEr0BjR7h7wKgsPebZdaovyvyXH3ev
v17fHr/yZebTVz51//xT2+xD3qbIDMERRclia7JBLDJhp6rptCoEB9wLbeo+ZlyKGuuuSEkX3hlG
wH3Dl2WinGyl2tTi7qtkp7ThID8RKFK4nJJlMqRNDtPGVhvc1BWMiIKZ4S4qK/0sBsxt0InlYzlk
5uZcUYscNiOFdcxvQflIbBJq2LIKAMQKMFL1F6fVXmfm0YhcCMuV9pjL5Cy283K5Y8yeXr8/f/p1
1/Lz/7N0Gr0CR5L044Pl8rOQFYRE7/8ZA6OD77K4rC4Na++CZCc2fuRnw7Gv/NYf6971/ThQB9oM
PTUj4RW/72v5oLcCkiYfk4Kf9B4iPtLeWybMkYKRuxPGmQnRZ57rGPP3R374qRLXPtGDZTmjExnY
IMADB59P1ViXmDraAC5LBy8yTxII/BeFNn4PISFLmpHxPnP93ka3Xiu0yOmF1uM9r5zvm5yEWIba
OfABwmMXD1ZoOV5GnYC4lllITbn4ZBlRh90VArMUY7foqvEoeusm3bVlG3wUYDvkNkK1UFsRtKQQ
J4yWMW5fgiBp7HroGJUQSngDAyLId5rEQZGNXQ4YsE6P1lnXTcl3FPl7Pr9qlE0LpLXC+GOKQt6T
jG9IxvdZ7AY+H3tHF0Vl4KMM713zI7Rp5ghQzwdZlVvb0yQK7wIXtwdeYbNXaM8sH53c97Q+LNuR
+8yKw0zWj0ijNScZsLTs73lJR9f2gvMOjn/EMbMjBx3F/CTFd95TPDa+NNpxiHOl5EejxHL9DwZn
YhV58Pzw9rznKHb2XM+KsFZV5FATEYw98908yEkUBwHesIrUPb2MVUkKyw/PuY+pI1c4GErWZWR5
0bFUXYZkzHmgjG/1x3pwLd/eEzIaHvVgldDNIOI1iuXGRgeDAlG1hzgoNjjHoOjAd3CVI44OQgfz
BzSC850vCiPLxPcVFFs2fkG3opuSVvkFBi38sz7xZQSzkJMydJTlYqA3PeFstVFJIqPAxTbGUUyY
qfBVq3f8KBx9t0cXEf5fwho4mw7DxbYKy/VqC+1zg9sLzqmOPGSUr9VdFfDVGHdYwNHOrkCT0BH+
6BaKjZ3c321s7BpejJXQTZ00Y5dwAZwZoiOt4MXMkf/Pj+yhMDiLoBkCN+4+oL71WzgLcr5eWJDN
c0LSOoblGsP7Tl6gkVWQVvU1cV1Qid4uPktCD33BcAsts9jy0AEntdUtiEHsr6DMDrLfq5JjOY/Q
LYgECQnZbdaRGDaDKui3+zBw31sXC90aKKhqr2UAucYi2AXeOrFtxw3ny+99T1PwgWUaKTm9b0bP
PQ+FbYgIvGKFhX75gQuzzmaXvbE6oZnlhkOYnU2y/Arz3N4u898tNLB60QSU/7TnwoGv9awPw9+B
4B0tQ6J4MDQfLMxIevEDn9zfPj8IKJzafBc2g2idAnIq4XGZ7lQ+TAu7g39CTzpYBPkmMLSKY0Ez
y0Y363nWGtq+ubXaQk5VRdHtOHuoSQsPQcGm1vVRFvYZGL/x5p3Z0UWnSt+CxZ3lRD1fSdHPnBGe
W/U5LisEoj3Y+BZJ4mMcjucPl4NhOz/tzJrLeHACLywSG30VEMF3QeD5aMtWCCx7cbxT8bw47szC
K3zosy6wd8T7mWY57I/ZeGaOZ5qEfEvU5lxUXNrW8v3UCXHLAU3xslUbb7T8oDNYKIruZg2ilfx4
+vKvrWYRGt3U+UjTOnBQ04EJxedoLy6aQs3vVpC7hkH0aFJfwiAyif/lOJVedd5aMQXj55AMd4ME
OnUk540Iv+sRuJ5/Tx84hpt8CeIbB18JlsGgfemj2HYSvakrOXYMvq4aLDAyVwWdLqk6xuemBrYu
n0BRMi5W4KpqMD+QaTSyPmsvEOrgkI9J5FuDOxZnY3Prc4nqNGUI53/b164XbMRAR7J8bFkUOMgu
4UpEH8sFzHUzxeWlprWnIEQpL9jSCTS25LiSS6LjenqiCMY3TxKF1B9pDYq8NHA5R23L0bL2DTvS
hMzGlcHm2zQ69uYkAgtvVhLdrkS3K5aBvPPKNnU91zz4OYYPC9s3TVSgF61nb/Yy8IhWHfi8h3Rr
PBxk0nJCBW1mO2yzlE4eP3w3wEUJKHHM1DC6XAzU7UKsZAwc06QHATNbUeolSCSDCa4QhFnNxB2u
LiDn9PF96NimrYAAVcesjXxP03orpKkQ/UJQvOvXLpch80g3y78JLaDtYN4OA+5DdVsqA4RLhd/B
tPQCi0hTJXzO4W6PW3hJ63s+AXi33mxn7O7Jrpk32iXtzDByTEbNNUAmH9pb1DRXPEXMq69+EXPz
i8YsNYQaXgCGGM+CXB9yMAj4iiSCNYS6h1gIK4uUugYX8wACSs6PyAMd1GrmROztSyCLNyzvaUfN
d/cwW9PBfDFYXVhxc7gBayhu5jKtkAw1cRHCokvbw2m7hAnt5my6gWSFaCji6y6R64eKzctCAr27
HWCKWBnhOJLYkwnTPQJaqofK2gVRUb71dz/0WO4ub8Eg6kbu6TAIjlTdw4YrpX1j+9MP+S39Vkkr
8yUl53fRmULaz4D+qL8xKHfj9MrMoTBvFKs0M4vInmY3Zh8/rfqhbQxbukCMSyCcdl1fN09gGT9o
XHQmz8mGWIwyAlGBwKs1e2rYvO6FKc344US7e7YYSBRgonA32SjMz/ZJ18BFIs/rIhnTsmXg1IIy
hNP5rDSRiMEZHEpthO+riXxI8B7kpHbosDsgToGHE8EUTDL946nMzpbA7ErbwE7BVMe5irQzhNKC
C7ED3JgS6juOk3XARowrKNdIokk1Hi695xvmGLCnKbOCsiPOhzk4pjxkeGqVg0amqYyMTbqGZOyY
55hpMTRZbLa1Uqchitv4QpdUpDUY7MKuhh8d8brUwKc8QQQmeFD6cDbeEqZceClT+AqlnJT/LWhZ
dtPz8iohbdoHXiLZELhEO+RJSdUs7IHhZQEBLQsIclkyq8Cejx7qMa8zSrBFbMoPNlAF+L7+Uj60
yLuOi0X5rQxod4PCp+SNnexawT7pWqWCAUPDkh6OKjsqfphFiwTbEeCEeNpccqZHJdT0kPGnz//7
/PSvv97u/usObKdmh/uNMTBcV6UlYWwZA9KoBVrpFRY/Ejo96nUgEBXji+uhkK/wRXo/uL71YdBL
nJZ4zHtgoSr2JpDYZ43jVWracDg4nusQT01e4hOoqfxo7QZxcbACrY0V8y37vpBVs5A+7WH0ljcQ
hMLxsdvHa3+qzJQfhrki7vvM8TFuqhC4lvyFkT5Gkew7sZKuwb6RSkG+4BuVFTO9uZadsd3dipoe
EizlAb0S9dDbUuEZhHO0sHYLUoiS4JOs2EAJ3Bj/2BsR0VaQHqZEKnrwHSssMYm7gpIssK0QL4Av
55e0xnf3UjW5dpG/vPp9e+ouTRHG+rjEEEeYJQ7Ny7fXl+fHuy/zmWxyEtgKguxUVUI3yRr5fSMl
GYyiT1XN3kUWTu+aM3vnSOb5RUeqPDkV8H7cDEK/eaeV17nZHBol/hX/PYrLdi470et2CTEc+G7E
kDstT73jeGjbNp4UymEpTYXF4JzEwHZ8Ha5M+zEFg1eT2rTaJIy5/DLMkkjzNPYjNb0j54rKtzyQ
+H6KeqSl8ENue+pFTBL5Aa0aLAcYmJMj7FuqntqtFDm/nS3PAEjOHmpS8ZO0iI6CxbgA0BJlh+/O
5hgscn1dk44F0xs55F3SsFyQ0eAZAEr7ciwIPJnaNPenVi14eQ5LT1qK1muEwiaeDQQsCHVrew26
FK+UMTP+/WTnfyO4O4BP5vcEBNfyDyd4ARk7rIqPucZPUXsEpqghC4EgWZvhB9FY1MSqb8mgJ7HA
U5PmyF4nO/BlqzKJNL9rrw+aqj156JWsaBAfKRWpnYu3HMyO2f8Ix2TZGeqapozRjMC77CKUCd+W
f8whQIvKU4NSTbTK+FrcxKaU4sd3UW6DnVXFOOaHDlmPdqQZFm7piO7VIbJtc0zpmPAf0waYjykm
+b1giKqSt7tXBGwoudCeQCo93y1BR2xbcdotQ0fMZVx5AJgbcaYqZRy1545PkDE3RQed6cbbaJ5v
TPg4uV+75po0S7N3kdTJ4OVxIqZ4W1UqYhrJxMmpukr/YNkfkPvu+PL6BivfEn9p82AQlLKRKpA4
P31r+AqWHVNFD3JN5BxnplPmAmnLvsAt61eM6VAuIdqcGF5Gqf6fsStpbh1H0n/F0aeqiOlpkRIp
6jAHiqQktrmZoBa/C8PlUrk8ZVsvbL/oevPrBwlwAcBMyCfZyI/YkUgAuQxu5IgAKwMgP4ncvoJK
iWiCgBLxtUmyiMO+I8yJYQBkgHWqryusp4l4P5yIeSBVCzvqsy8+yvGYpK6zfbJJQUwwKdLsZJK8
S+fLVRAdXC28nErLD65hWS+pt4RBODR1Bz/EPTMAZFRYorF76Cm/LjOjRtEdMn937I4spQv/Ss8A
wn2lGP4jfrkFNNAWxw6qLGJ8KW3YLlLFuy6xXTNVyOhTd8dcD8alZDKcWvHtpM+iod/P8iRnTar7
uuzTpkJH597h9fL+k30+P/6F+e3qvt0XLNxwwT6BuDCKs0TGxbAJu2RDyqSEq7yOn4YYn7t8t2bs
mKqXWkVyFFTF3Baw4qCtHdGHVGmei50GRgiXdxsZgl45+gN5XcPprODV4GPWWRbH/WkKzmxjZ+lF
h8V85norXCaQiDolrlIl+cgXIOpXYSA7c7O2Ue7P3QBL9YJp75jhBjRiPZs5C8dZTD5LMoefiOcz
VPtWIMTVw8yohUh0J7nJawpLTv4C/chfEVFZZO3LdZg17d2euBAXIL5verO0DR26JRDbAat1l06F
BxYY3VBb1hvi6C2QRA9pY+VZhp9TPRGzQ9jZI996aLSfkTpHP/KxW5KRuppUPfBUXcc+MdDNAsZk
TB9k7FDvZGTVpfbRjKdj4KMB/wbyapJjH/mtCRvVQFnQ4jBy3AWbqaGNBWGM0WU2ah27/szPD5it
cQ8IVAMs2RVgFDEdACQEjwGQkVhoQEHIc5KYNCcuXlM1baIQPL1PatVkkbdy6JmIRZkdCUtUp2xY
+d7fk8/KBtfrF8SUzZ1NNndWp8l3HcnVa2rwaWFz/NvL89tfvzi/3vATxU29Xd90d28/3n7nCPb9
/Pj88HIDR66Oud/8AscyUI3a5r8am9QaFDLy6cQQycq+YhnV7MQnGNViCMc2yb1Io2WwJoeEi6Ht
+r5JjGknI3aSPAN4KhYCaaC6S5N1scZxZ1PWlVaEbcS4HTlz/CVQFrbNJ2O4eXn4+FM4p2ou749/
GnuvdA/ZDeVEfpHsuC73lb7R66XCNfsMf4oQfR5VnD3Oe3EGCmren5+epiU1XGbYGlcvKqGlL3Y0
WMnFjl2Jn1U0YN5gtwMaZMcPYM06CRtzTnT08QkKp0eqjoxGCaMmPaTNPfEhyrp7YpxsQj4ghoMV
0b/P3z8ffns5f9x8yk4eF2hx/pQeh8Fb8R/PTze/wFh8Prw/nT/N1Tn0OLiXh5d9ohHSBfeU93Xk
Chx4XOviKgTv9QVRQtPcExR5qZgceO0GZQP2/PrAJWVKwoR7ZsbSNViwYpd5dQPHlbUS84En8N1j
4QdOMKVI4Vl1jM8Td1FTsnvsVgGonNKUu0jPp0vs37v+8f75OPuHnqslniWnFgd+1JhMBU65ee6V
x5TFBl+kRbOBcjdMr4pIh8ths1mCYDgH0WtYH/DLGlA4gapM2Ev/lQx7qcb56Ajheu19S5geoWmg
JeU3zInrCDgFRsTKjrKuI34uIwLldJiYmXoGCGC5wLKXlPYYY9dtCsg3Qid2lN19HnioelePEC6O
1AsIhdBFip/kykl875ijsRZHiIiph31eRM185gTUmgFIH6/LTGZeNF+6U0LKMsfFvpAEF+2cjobG
/esgJw7wprlW0SbwtFg9KmHmU5S5j04/QbOOkkAE6Mf5wmnwwHD9DL2bu7fTCjF+5NMDjnWETc4H
F5kQNV8CDp7uaEH9xnQvwNNnLtKpSc4P6+h8qw9zwwMcApgj06KGiHhorzEPM9kaqLG7mHlhhvRa
zFdyMOwQVWrnRjA4/JDxE01fTLMXnAJpiEhH+gzSF0j+In2J41f4YvdXjj/NqF5pdnTjGC5gbKdw
WKCLAGmwYDNIy/jMdh1sKeVRtVx5xoYCKu/yiUgdAhBIr24MMZu7c5QPSIq8DrSvQVdzv61Nz1WE
zj+gDBeNk070pemaaEj18vDJD0av9lZEecnwNjguHsF0BBg2BCqFCoqpbDCB127CPM1sbJvjlgsX
m458PS2QdBE1GVllza2zbEJsHi2CBt9VgGLfkjjAW6Gfstx3CSfvIxddEPFd+9GsvEjoB00+3XK5
NqIuwXqQvBOxQiD04OkKxHzjMejf7ou7vOqn3OXtn/xIYUy4qXDE8pVLBSjtp+XBCahIp/1Yp1vL
IXzYk/NTTAQU7bcnlrWbJm/DLCRu54dhJeNraYj2IGRbC4x0ejXupfYMkmo1vzJyYbNyat7RV3oR
YCzMcfdKw1T8VhARKvsZKd/8rZhDE1BavEOz94VvHyw6XNgwBPZDAB/jMA7nhGnlMP3CGLQwLBN/
0/C/DKfAI7fJ7cNLRwQe9iqhpm3FTN/dJpCsLIvttTmbVZG7uFIWmNu5VzD8mHStyrTPtqHhJ/sk
4vT2YGesrDgQUYF7zrsuCL9yCtPgKPClSAUj7qtDvzsPkMZdEn6aR4g/XxFxYgfI0nftuZy2RixC
cxEv5zN0v6YDrw3L4eqErZvYcVZXOJKwVrFPkJR6ih7lvrkXa8xIqgul8Q07v31c3u3iTm8sgO/a
0dyxl84Y3Cba2xDmwrKrDYmIxgOLd1HPspw9TQNNjqnESy8HTM1XwIFoUmzTQlX25GmdTYR4+CyS
jOnUcqO4h4YIeSHvmS2nqH0m9YhDnoqvV3CJGMNY4QwqPKUt+e064itvDaHsUP0oqCPwvkC33eWp
LHScE2GLBWRyd4mP9hrJ7RboKBkkiMQgdiTwEZ3HUSu7r08UfgZSnuYv1FG+nZNF9Jzc4T2/vopy
rag82kyqOxLTbJ2E+wYUjIneGCAnGpJXbUUWkYN/A4rIGRkh0uUnRrapWFebbghRenUKSRqYj5FE
sWU5gd9uq8gOcmfWXpcYZyYWDY5Ic/rzXqmIzyaq0wcIPS5ijzDL6GlplhZiko/rv0s7Gau/S5bC
vz27HlNp+YZ53N7JlHF4m9t2x8h5wanRHV6UMFfYwXpq822uvAaMBI2ZHicrvZ8Jm7YywGwH4KRd
h4w4bwn/vFSH17y/WciEmiMN+kbT+I5IrlXBramjhGQyGTnpRdh2OzW/+rG2Ww4bUTR1ai7CX7bN
hIeOLdEVksetS2wDg8+XPISI9JNwoCJ3ETdg1Mo6ilRFG1V+rG12/H8uwx2S0aROpxnq5F0qS7IN
VJdp9QXKLgkrNsXDS4bQTjA39eEb8cqSEN6OVVxkDklvj6/3zNBoVVuF/8PntzyupfWduqKBFINJ
mySh9ThsULUYkCbaaVzPHHJSdOekTnQbFtFOdQXfqUprcSMFME8K3Cn2AcIgTMhdiKnH98vH5Y/P
m93P7+f3fx5unn6cPz61IM1D3Cc7tK/ftk7uNa/3XULLt8BtlojIGQMtAhfkqfm/OYuGVPlMKmZI
+g1Crf+PO1sEFlgenlSkErKgA+cpi/qxQIaqQ0m99mHMzOpGnFWFzPHbaErjhFmAEQqg3bXL2cxC
jdPSXUi6WXOOyMI132MjS8ULaGGJFXC3D4UDTV5KhdED11tgiR5SFUjmsiQ6+TrIrfzNUiwKp9pV
WE9opgFjcl3uhe2nSTI4jZraJqews0PGqF2mifI1Z0JbaWAqXz/5iv74fBBhPAy9i/Dx8fxyfr+8
nj+1k1QYp3xuuHoUNQMsM3h7eLk8iSg3z0/Pnw8v8LLPSzCzWwaOr+Vl+07NuSf/9vzP35/fz4+f
ImodWkaznDuKPWWXYGp298kTjwd6za6V23knAwr/kVj28+3zz/PHs1arVaC/H4gU3ECNzE4UVpw/
/3N5/0tU8Of/nd//6yZ9/X7+/eHt8QwKuUiHeKu5NoBfzaHHYxNHlQ/ELJNxkpAVAubOG90umv/f
htvccf3FbbtRHso62jr2/flCf9PuSGDJu5itCTPxAbGMDSPznuLN8QO9ClkSVvUA6FyeTJoz2jmb
WUoK6VNhgKBq9RrAIXJfBJiiqAbwJxWuojjwFgukm+owCJbYW0hHZ34MDs4nowY+XMGpm1kSSyrm
qW+2ffrOcVQD7j6ZxY4brNB0eMacZC/S8XzmcwdpoKCgfrx7QOfMZFLU4NJTTwfPMplqO9CnZxBS
dDFJ30eO72A144Ql4WO4R1Qx/3Y5w9Rwc5CV+KYADhCLRpHPBEEGA1OtMCA1TnPsXUrQjNCcgzBU
lk1dYi/gPWIILzQRpLJyi2UJVougv2bJE+JDIV8e0nUNer1onw01Fs7D4rba3VtxYR3tsFtVuKQS
3dd551Bvr8BQpT1EuxSXo8FC0GbO0kV0niLGkzVcV0GfbhRJYlula/0/RClUJBcgAqZtyjDeLD9c
L11VNUMkbrL9bTLJzFSW16n8AIfJc4ImxdBxSsq6JVFXtHLfxM89vflMp4aGZtrf7Sqj0ae1VVpR
QeP4xE2G/PGng+gbeA6zY/Iky0Lwpmq19CkzLuOeSofwb8j29SaMrlUnrHN/8ZUu2YX8bBtliqV4
nwI2s1Wo2uDIyaKjx7Te7UMfy/XlMtgUCfVreDutz3+c388gMvzOZZMnPagc5JFGhLMrILIqcIzL
295zwNcK07PbsRi3CMvyW352Il48lAbLK+4iwme3AuxV0/CjgILim66nieo9rddOw3In36A0TIUZ
L6qI1NNCtBgkz6FKTz0H21d0yGJBf06YPiigde4EqMKZgoniKFnOfKKYpmJ+sLheEuSyQl1jqiDm
zuAUWxGFJcWSimahougXehV1n+B7hIIR+glZcqLM2A0oC6/CtkmeFldRnJmtfP9qEyyveupEcPOK
oe6B1axOKfxu9RAUQLkra2IzFTVlzswNQs4QszjF9ZCVUibvpBio4JtTcH38hgcXe8NqtoIdN6FX
iYvb4iigQzRHl+8hwnnKIVoSxeV55UpPn/YSN+mJC0idST9a72o5c3HRVAyn8IdBbKiw7sP0Nsza
hs4BZKCl47TxAb/j7jGUJNXRW59cigqg3YYNMS8kyp+7fmAx8+gzuy0L4vKoA0T322Jv6RcO2dXE
/tTRC2btEdJmrKczuglKVJhr03+X8p3Djw5zQq/HhOJaRgaKMq/VYT6hQGagru8JitH8dajvuoTG
TcKSRnh9ta+pNT9E6TbioNHCKeRwCDfGuCw5kHEFn4FMTxVBphkrkPeZ9fMVsRN2VK9dw5ba4CbR
HapunJmuKCAvJ9+ezm/PjzfsEn1MNTp6d77RdjB+U3pVpZIOCkyQ59mycD3cKMPE+V8pajmzFUVE
LFJhJ4eKE6ejAjSqQ49pon0n8I83e1ivo8vhNgHLIGIvBRfp9yyS0MnQTiR6Eee8Of8FxWqnBmXb
gstECFOy2ZHzSUE3LnVtYqAI5SwN5S+pHUZH+V9CLa/yQUCtvpQXoTemoUjVMRP1hXpxXvmFXuUo
PJaaicLtRTVU4Hyl7wPH/0JPBM7yquQOKMIc20R9oY0c9aU2rr4wQhz1lZ6Yf2UWBp4Z7Y46bGtL
U1m93UupPJC/vlyeONP43tkcfKhPrV+BK/shRCPqdPHAQJUL9fh1i4rLSVS0q2SLqw0hcSlC//5Q
NqjJhgKqUl5wtCOFYtA5ITc7scpoeTdvSH9kQjKTyiRXz1oyygh90ZJu0gMt6UrFEVZGm2pLy7Gs
rHbb0qanr6DY1p0t3JYaJBOJK05OUGR+rAojfsRt2ijCVQiExtfYY3RxfIpBX7X/3i0dWzNVnDOz
N9TAGta4OpbUdhcUsn3iTmSXhODeANy6tISOkDppQKWHkhSVm5YUXLlamoc5v8IyOqQgHBDBIcTR
epuDCIMsxk6z7BDtiQPuKSvA3eft8Vt99WJC6qehqN2RVWkB3o4I+YVdfrzD/aMpmoojoqZHK1Oq
ulyjbwX0mbI/T1ognfMyG6K3lLFghIu0OLflchT6jTQg4b/8EAT3Y47rOhbkpmnyesYnPw1JT9WC
n8lpgDC18W0tOmYWah3b+hT8SYKoWTZNaYGJ0PZ2upe2O0YjhFaoJYdB/ZSGSLsaCwDuspbWvuzM
XdqmiSyozm7LfgPC6qiN1yeoUVVHOcWfZBgF2/CemK1JfGXWiW36FKLnGj7n+bye4PT64lu6pHGG
N3fJHQIQUhmSPiUDJq+I+5iw7nqcfOjpeAerghm+L3LMYZkLBcI0wmsq4jvwZuKPL5JKv8yIRnaR
y6ojLtz0RnSWAW1ur1C5sGedpLIm/4YHV7ItbNf1V5RfAeTNnjB66VR2Sz6w9iwaYnonw6DR+xs0
BbTvQvD7T09N8fbJuTcyM6sTqUYO/kfAZSaEXmisvTnaFVAjO8xyMAJDEdsTssIUOR0kdGStmlcR
uvvpPpm3gQ/ENF0mjnXo33ktPD2UUbZopsLbwfA5rJ1kjG1/0I8I02xdaqFVYPnmu317II6TQnhu
c/4VPo+Em0+aDmNsEjvS8DbMizdqFPKdbw77QX3kjSUzF9FKwAMtDam5aAQxGGlEbz9E0Tl35fs4
C7cJ776C/6BOU2XHCqVGtS1VmYEozbkBP6z0KLQYYQcQVhE4saJtjqo4omsquTz/nDB44fwrjJml
KwSHy+M7SxFgnwS2ViQAji3k56KRnIdGlkoIDNkI7chATKyUi8573aG7TBr9WwsJeXt+O7/zI74g
3lQPT2fh+emGKarY2vegm75twjXECqpC/Hg6QYq9D986J9h4YqnZO/+/UlW9nUKZW3VM1CdLNW1h
aNbUaaRN1SkmC7/hikc6tAoZa3Z1ud9ivk7LjYSbPIflxM4kx780yGrJm97HvBF2qCOqJYkjwySz
KXegIZ2vThqQVtAZh5zQxu6imZCun/mSo/MeqO0Bv5ERy23yvXRedX69fJ6/v18eEVPTJC+bZOKl
akhtI8NRlbGzHap9W5ufQ2VZhMuYg4vssBTy5FgUPi5gsHQFI7ldPaV3SwZpv+yX768fT0iXVJyr
aSa3kACyCRaQQhILRWtdpojJu4VNnKZAgkkdvPGP1deqKd2+8Jb+wn5+fJ5fb8q3m+jP5++/3nyA
18g/OGuIDd347v6SXVBHF3JAorA4EJd1HUA8aoRsX+PcrvegDttbWmwI7+eDf3QM1CuuI/WVDfn+
HRgd3gy5umz7qkQwirFOc5eFSo0RqlQZ0xDU5Mz5gWFYUZb4suhA4L+/t62w4So3vFqgtY+nrVKP
WCtHSCkpfiE10NmmnjCb9fvl4ffHyyvVY/Ad6jWuDzaEfS/tBk7Vvzbv5/PH4wMfqLvLe3pHFQIH
vLgKcT58t0+jqLPXw++O+JeuNTrQtaqIuvzx43+fPz9+TOrY5YGRpXeA54/nl+fHyxv1JQ6QLiv/
Oz/Zel48oeNMVFJXaHsn2con71O1+PtvqrjuTuwu31rvzApT07V/2Z1mLnJP3oS4kz1/nmWV1j+e
X8An58D+MHfo4DdfNJEnQPTKjDgzfT13JfPBjn27b9hkQagvUij/7URtctvnG3BIHASEVFBs6jDa
4OwCABVEPzrWxK06IAbn0rx79tWkbxRknk9eAHoTRayZ48fHKsoX3swMQyM64u7Hwwtf8STLkAei
krGWuvyWpwku/IB7NCLstdx2udDSErbREsDW+C2IoGZZhFliC5roZn4q24U1uFTdG5YCAlOHeUXz
bQnJmw1rc8K6VkIqfhIOWSPubMIG37V75I6msjwGhAVgIx6jgrErjQFGuzYdyw1TBh13nSPZHhEH
kX1b4/E+FJk+5uI/Ed1abGTTR0gpZ12+//l0oRmq8qoIrlKo1zH9IbApK2oRIeXpFe19NxzKrIF7
CNt6HfBzK15Fp6oU36RtVe+JkMt7cWluERIEabzXjuhdB54vDmlynPT+IQ3/dbyAw2XBXKhhOOaN
VdaxZSPyOfHd9G26j3WfY9RhvL4kh0sHh/lNfHl9eNbtDODZh69mOT2ne0cvCuMfS2k6SYgcJgK1
kospFVd8lxYBqRpKrVSc1KOcz4mk3rSW9TQCyyP4176GrGikLlDindC/Soo86NuyHN8UhKIsl0KQ
r015VOu9XtTC6wRXndsqOrjXRsbMQxcYiFGXh2uK14zka4Vj5ej7sVEBk22j80kyhqFotI6gTACd
Tl+0uDM+KyrrPczOF292U1hXTbV2/R2ssD7a1Mnd4KJD/nuzvfCV+nZRrwE6UrstD12MtrYs4gRE
DMWThgKChVHWnK4GrtYAMMlYeCDIEGZBKIMQ2YeMpYekt2nqax4jh1K+rrrbeDAK7JHUEhT+476A
k6+/11CD4mMUpVfBfCiDtA3n8zYnajAZOemlXvNMohL6hhclcf+EoitqKuroQaCIN5jmdHJqImHA
KA8qf3/CEU36OcOGScLbMI5EUE7iUUVgNixcLVCrow5gxg7ukvPw5Cy8JeZ8fUTM555ilDGmL5f+
aj4hVE3hOXqolY7Si4zSsYetOXUTrJZz/HTeQVjueajD2Y4OLor06EZcZC5rLc68fCpOCIG+u4Tg
p/0NvuP1AJ4x8QzTOG3mkvrioH2U5EQsuv8n7dqa29aR9F9JzdNu1UwN75eHeaBISmJMijRBKYpf
WD6JJ3FVbGcTZ3ayv37RAEihwQblU/Nks7uF+6W7AfQHkZJsPOGq3nWWXJtTuQGX+2ljeZUBzg9w
h8P1lpzOAUSqLZ2+vNI9Hmy1FhuM5ZVfkSUQea7obW0yHVf3nQ2kTzpzt03uWXtOirSWdwbT4b+l
+HIVaygzrtKHE/8YJU60dqww08Z8Q4kakfMQXcU21OaNxgdgt/YAkHbkqTMXvIH30yCO01cIHmUx
FRZx5b9bhqm7gSmIbjItXN+pWAz2t1nEw7VgH9SzXkvhOX/6pVH/S/nFEmv5PTytL8W++6ZoL+h9
6ESkAC6y4lz7OoSdIpiRAyYyI1+uCq6+hioCmQpE67GnEsWLH0Tx+g9ULjox9hapxN5aKpxLlZUv
A7Z3nBPfiD4zrYxN5nnai3z+HTiLb1xyRTOi3GyanO82EtWczKhykkSBnj9RVDMTjSOzmpcuz4jR
mfkufdTGJ3NfONQLasnRQn8Igh6bYHuuWZJGXralaLiwGh0VVcyoQVXCh+AKFh4ABqzxAaSL4N+c
Hc/LzJkqqZZRpAmgKtycWZEan2YXSyI9kG7O+fsbF6FMNrnv+QigNYsDffYpAi7IREQNCcQowmkl
QeghQhqGrjxeRgCwgk6UWHL08jIYSNr3OefjPESEyNMrwPIMoC31/IDkk5h0bLhJfFcrMhA2mdLQ
/uOIV9CxoKGa+0VWcKNo14A9UA842G4R0LicwNA7jn9LpBX9p1FKPXjPithJXZS9IIQLSoIorhfg
9GPbkxpgpfR0FyxKFeUML4qMDDxSTQdG6qKyealnfCdGUr7lZR1nBTG1/HBG5KDIYfDNNT0RpCPr
s7oWy6Se0kXAtj9wOwCnGUfJaGyxsfFMTGMkjimaUvNGMHxDNEko04UzUg9t2jGCNBXfKf5Oz/p3
GpgbbSXe8/ORvnaiamXDgegqkyulWVh4dqFz5zlnk60xYdMq0A4Nbq1KXNGwJbop+7o6LDJV3DyH
R5muSnYiQux0TCqyFHbgXYeo5eFU1m1X8vk/lLmBS6oiUNvKpYxuuli7cp9zcz83q7uvkoAMMLQ/
xxjZpTpk3jL3mSnvrRipV805tvcvnJrenrs1fupbuXWXu8lKcyi4Ajt/yPmGR00v4AQxqrwgJfST
OsFL6WeAkkc/SgQvguPZea7ttZFk0i8KBc8joVkFK9C1JqB4ekQYIBhwYuDJCALHmlsakRE9mrzz
PQxuB6TAo1Z84ISRttQAIcXDb3aAAVBC5Fi7VZcL43jMjme76GG8c+USYBGAkwDGV3iLwCE7xgaA
z4WXD7FneX0MrzEsM6nLcr4toqoLkhkTUvHERa7dx761JNe3+2bc8JXa2LNnn9uydpNEle+hHfvh
NnJCjI50t/Nqa6tJRCE7Wz/e29jFAHTIUikm1pSxaYsleLP0YgAblMsVR0exZUXzNiFrGYemK+1c
6W8XK7zVk1XkTuJSdZyYODroRA2YLeiKlHCdBOLhrEl4NqDeiZ8wJ6Rmq+JHLos8TYMRZJ6pGy5o
rm6kTjQ3XdAERPeSijU4RfXd0rIoSYHYqB5mpng2TNSQUjIlM/ED4idJZHnZLRCZu9RzInrecv5Q
50EYUIsnMPkscgI0607byF2se4o3xeg39l9FzswQcn82yq4mAbB40/+cfC8FLFF9A9fFtkTAbZMe
mVB/PgO9YNsfL8+v78rnz4Zt1ZfctKtLIiftF+os+Pu3x38+GiVPfKycZ4EXamN43+SBF6LUL8nI
w4j77/efeB0gNt316MduiAy4OA5QNOTrick8vz48PX6CyMACBEfPouUbGf+z48uG7krNhjpjY7cf
WXlgeB2VrPKuVTzSS1RGCXI/wbfpGRI05B/Ic5bopjtP39XdBfIbp6No2GGT3SoHwrRf7+/cVPMg
dw2LHUczaVhe+M6IfyRphp9OElnZVxnlH+PsAOk2vI0c3xJgA9qv6ivQJHY2+HQkQ8apYR3TrXzx
uSi1INpLzTMps6qHnamvGFxb0Wzl012SntGoM4eTukb5eQJZgvjP+cvT08szvkZJCeiTszqc1KCS
zzvZkAn4QE2kYbOErOMcqVyEQrwMcBSMGvHkTSPWTYXRSqplxAVUTvsjfXN2mYTh9MMFpXmUo3Hi
qeGoIoa/bWX1Q99Bfhs/DL1+3LMlrdYjwiqiTgidCBn5oR85+DvB34Hn4u8gMr6RkyAMU68X0CkL
qkHwDYKDyxV5QY8bMivS2E8NN5l0ORQWKBUwyGx7NuSRRCu++TBKF4HhL8wYn1Xwb8PzFMYR7aLh
DFxVwzXE7Rjc22Gcmp4iDwfhujB8B/l0kiAyPEdJ4lDFAqMh1n9bdO0A7ar/umBB4NEazmSfr/SE
G5FxskQfYb1XkCIyuHXk+ViWG6WhSzm4gBF6uhuaExJ9NHO7E2J8mYQEExY/STEUuDIdSHShQQxN
J/G4posVZU4Ow9g1aTHycitapHumpV44dcyMFXBNg4IF8/Ovp6ff6v6duZginmBuH7+Z61BzShI3
0TOehOQvfjz8z6+H50+/Z7CC/+O8d0XB/t7V9fSSRr6oFS/w7l9ffvy9ePz5+uPxj1+AqYCgEiQ6
uvES1/I7eTvw6/3Ph7/VXOzh87v65eX7u//i+f73u3/O5fqplQtd9im2gRW4DngxPZWBE+vzrdk2
nuOgFbQ54aMXRQkwhU8sY6L222gRFW66lfUnKzr31noHoT3py+8fLz8/vXx/4Fmb+qU4DHbwRgEk
1ydIhm9fnCNbIjlmxblnXrrCDEibbdPskEopv03VdLdQKbfnjHncXMXnhRPNPEec6fj4qzv6jq7Q
K4KprSk1QDhvxHEh5Vcddr7nONTMXnaH1M8e7r+9ftU0pIn64/Vdf//68K55eX58xb23LYMAI9pL
Er2wg0fQccmzKMXy9PKSWWtMvbSyrL+eHj8/vv7WhtmlXI3nu7QbttgPpCeSa1lGLPk9+Ecc+jUb
53mOGYL8wvMdj6r3fmCevinIbzxcFA0Nlf1w1H/GqhgdYcK3hzp/0TYqSCZf2B/5mHh6uP/568fD
0wM3cX/xtjaWNJhpgeUQUfCixWwN4nBBWk7zEN9c2zSVmm30AYpk0wdjnOnFaObCtzl3FNWahO/5
hjinWG9VCCbqmE3L8v24ObQORofS6XZDC0kZJd+eW5bEjr11ZgG6cjfNOdKGDNhSVd4EfAF1aKph
l+gcbJVwDl+pIrFS4WuPiEW2oS6BUmW8owK9ZHLRq1kTFexMLIeKY8sHC1FmFeelBXPopIFzNWkh
NN2mmCOiWqeYngBMB2xx6dTLzTcxL+vHL19fqc30fTEypPZlxRHOivR5V8NdhgwTXCzAdw4Dr7dg
qUuq3ILl48sRikYfbAlmSqfFYt/TS7/Zu3EQ4m9jweAUOvo/16TdRMcs4ASs7nOK71G2D2dETmiI
RlFI+813nZd1Dnk3VrJ4YzqOfk3wlkV8Pc9qHVltcgWwmistbmLj6BaFoLi60cEp3ABMUC3fs8z1
XKp08oTnyJdDH5/wdL0TWg4JptLUjR/6VNvVQ++n2mji36FjnIj2W8+NKPSY+sRHYqAD8HG9IAiQ
Fqwomqfg0GYCx0nLo+0GPiapTZ1z+K9dQzhwLGpkxxvPcyxpscp1fd1JyL8DVA423Pi+S18TGo+n
ium9N5Pwwnsho0VryJkf6Kq/IOCbhrOvjI+UMKK6S3ASrQ6CoN+MAUKMk+WkIPTpAXJkoZtYMM5P
+aG23EWSLF9rjVPZ1Hx6ouYEWuSQMaklS98wJCV2lglY0HNOdeSSa8kdHyHedItVLet4CZbvhO6/
PD+8yjtdpAq6TfhweU+vijdJGlNeCsHQNakbJ03RCl/zFd/HlznFFc0m2x1IomnMXBjYGsl2fCtB
l/FyP6T2ZPFb+l7jlN8am7j1OA3cfZOHSeBbGcZMMZhYn1DMvvHRqSKmLxzjmGvz8HF92yOnORzI
8UqGXqxV4mPWZPuM/2Ghj5R0cgTJsfXr2+vj928P/zYf9YPL+2hYJFNq+m+Uuv/p2+MzMUJnXYXg
C4Hhx+OXL2Dg/w2AG58/3397eX7AJ2f7XsW1oy+Ww9vTvj92wyRA39wR40KGRETJXZG2ymqSQ7Xb
DwAMZyuiRFomM1QNRDeD0smeub0qDiHvn7/8+sb///7y81HAey40NaECBGPXMrymXE8COVa+v7xy
bfKRuHcfopnLvz28hBeML3X0zUvwbQYWgCvBI8EhJQdd4gMHp+NSZ+nAcX3DFxr6rvlr16EnVVcr
X4EinFMvJF0dRgORjcc78lVrOzh8dx3ac4J/Ih2FPx5+glpPLvibjusVDR0JQmpfjeuntBuq8/AJ
KXybK7egGbe3i3rPtzgKcLTo+E6B/RmdQykFe5bzTbbTbISJYjgmJiq2pvIO+g25sWp0nC+/jfvg
kmZUhlP5HkRv103X14zr3WFHqZINCyPjHpigWK1nxaZtZ2D6mneWFV3oLDfCri8ZW6wqir5uPUoR
o/pDGNAd1HlOhPapuy7j1g0dk38xRC825DMg8C7tSOanfvgPU9tBwmrwv/z78Qm8SvLuxU9502CR
4P7MLRdf3/57VnioAcGWkYbCNA+rIutFoJjxpJ+8bFzDjOuM0EzT/NrCbQgH68P9lsQ5ZWcC7JKd
U4vqzhmepnjDt+7/4t+h8VqA50utg6D1+g721p/q0K8dmxsj+5BGLkbPvtIJKuLcz5dvAMlw9UaJ
x1K0cXjM9QzrXtAsYItXMpK6xMPTdzh4sayaYm90Mq4nlDi6zGw/5l6amFdNqwYCUPZNKyNqUHO4
5qMwcpGpK2m2zU4yqRuxQ8Mtfv0KG3yjzY9TXPIsceBaBrY/BcViMgm/uEcOHmC5SaiVQlIifAqZ
Rngvo1pfm0w4jq/UGvvbd5++Pn6fQDg0Naa/haug6I1vPW4ry7mthAQc24pcB/tbGa8471BEyvci
YnNmSXN6v8q1yxyS6CwRDmY5XuJVgf4uc98iBfdY3yB28vZ8Q7TETai9JO/qQhSevuvHAohkAx1A
sdUlPfPnU99fgj9PTazu2vP0lkQAc0KMhuX52OZl3Q6Kgc+pmw7eftP2EHTmhOXA+64oLSE2xTVp
EDZxgJWABsCLAlpCiAT+MzaUNsugEe2yMI00dnPkVbQ9aJ5RNhJhFNo6SL2cgBrwDWRTHaxhrAdr
LwqQmdIyvtnxIKIoS7BEoiCT5WbOUa2uXZbfjMbj9HmgAvAc/1Ax2HDMUeBlrmNB+1P8YW8BpFL8
M3MtJ2ZSQER8CWgVT0mIZzNrAlT4QkpC3e5cETQhVRHTDOqgYPtsUMGSDS9Z1tkJn0kCULOp1hpK
IuvsPqyI3Cy2ZcTmC/BgAUJVAvLmzYqEGKysy/rzWo/BK4U1tkRK4vuVHxaUMSnFSGAFyZoj0K3k
IoPAWW7QS5FrYJVKSiz2R7bp9h/t8dUmWVjxuaxng4aXclZcZsUW8W3WBFYAlpSEXDnWJSz4QJIv
Q3mvCVS8HqspTDB+1j4G/xg3SxPnvOzk4RAkEJO8plUjKbSKGIRFxl19XGtTAPO5wraEO1RzA3az
a3x4VvQGmQIO//q1Je0t6FJsqPaBE8tfkBIKy2gCIL0GjDrJXUEylTE9Nh1uLmky8mnBfv3xU8Ro
u2iSgKrcQ7zG/ceLBqIRQZupxkKyL9oqZ0y3BSEATTtQliBIzWsJyJlJsAPXlEqYtPQZEBdZwD5r
vDw7jEOfHVheQuhzZJtydlb17T4TCM7W5AE8ohsOvme5CS5KKQP8T+2wJgfhuHh1aP+eaE0YZsm4
Lxo+/+jxOIuNO9fLLvmO2SGrW9qnZfxmtUWxnL/ePmpanHdvFRPFBdm3FXf+idmy85hVoQYFAOEc
gg4DFmqpTmHseM3oeJ9i3Agg5/UaSbRlSIdyEk7wXtDQYuo8LX99YOv9cGCemDuFBe1MpANx3Vg2
0PvNLGGUkqrIsrKTF+N6G+M5pzCn2r6X4ccIJrVc6LyxJ8FPNCnGt40+M5t15mb1iY6rDlIippNA
SF5tGK70cbWuPhXwnMY+q6XY9dk/57o+riax24brr9V6JaYATmK1uJZ3/ZFbpF5in3By81htErkP
XRWJ3ySy2gz7CqwCMN3W6gXA3Fz9PrTrM0mq1+OpP3vOlXyVaM9tbmuSEmzHj0MQybkqB/GF14op
7aQr81TKrA5IEc+MZ8wrcRwsaqoumAjv6VrJunPGx8RBjDXy6bIuAw1izlpgrpa56fzrAmbuWAIi
c69uLlzgvAV9dW2aAk7ZNYGjBUx2zoVdSwGm4qqAWChyPmydkTbUkGBh8YNMQgWt9gptQ9iCcKOx
KO21mlx/SzFNSPmapIy55oKtuNrDwhGxKiEMwnKlLgrf6DZw3DekBIPFvhgIEZu9cBFYXVBkgcXm
3pddmQ0WM2eWhX1cKLPbshna8XQlaRDfMzHr3pCuvXendkuc6Hy93diuqaqxHOyKkcQ5hga2iig4
trXM+iSL43TrQFZlD8EXrwxSGRGhPPjruvMl6KhUISwXx3RJsXeszlksyifu6iaPpYu3Sq8ub1pc
B7ndF/mbEr1oB92KJXERh+EJBXlDAw8fu9K+YCvfa9GNp6oo7SrMhIMHC92bJFebaaru2ho+y6xN
7tkr8WYpe4vNUqtFvzjk9yszC96XQgQN13cdaLQ1S3MWDa6LSk/E2oSVN3lAGWvXkwIx6Y6zjw4T
KJvQ96/LrwzoBWj36qBRXvy12kus3jQYO48+LgIhGc91dRtsojC4ttK9jz23HD9Ud6SECHfL/4cz
AavCCWAEVbcyi6W7+qYsm03Gp1ZjCf+6FF2rnZQU4N4wTN4gt5qxOkCjPHuaWXpxV83aCgQOzzN0
8FkVdcnzfV/mtKetGDB4hyI3OXJH8U8TKVVx+oxN1/+z588/Xh4/a8f2h6Jvq2LcVIcC0Fs77dAP
83ToQeNXMmAs+8df/ngEbIa/fv1f9c+/nj/L//5iz4+PuHo7Q2zOgTNkOS9XOjaHU1E1GsbaphZ4
OmPXlBr1UIx5nVXNpaycshkG7XcDCjnebkUKRLPJDPng+sj0HygyK/NjXw0fBToo8esi08LUQTkR
4XCCUv9Gn/ISoUmss4/tcZg7sL7//fLr9d3w+/uDdvlCFxWHw+OpK4zcJnZ7qMpxqE90RuNx3LQt
gKmf9P5A2eptAb+UuBPl9sgsC4cUAz9Om7cDrdgqGXAGHU59RquVUkic0FbXJK5lNcuMJXnpQ0qp
ENqicngUyDYD48QbeSqWYF1T05Y947O+HNl2rUyTR7oEhMS1Ck6C61UUkd/jkD5kVSITjJ+o4Zpg
lXPtCnSrK5UFq+9qYmd2tX8OsBIfivZKHaUxtL3SXtJ8KPPrkkKVv1b+3gbqpNiTGno1nUlwvY4q
utm11NjhxPjI2HUWmGkpBOCiV1OSMJztejUn3WTRk0jKWFAwb9IrrxVIxhu4NmRu2766XaYlX/h+
ePf64/6TuIi4hAI2INenjVnoAsNeu2yoKONOUC9b+ETn6vtKQmM3VERiAtpXX26Jwl7yMk9vJzLT
oJH5x3goRSj38dAWaOkCnsIcs9yd0ST2xw1OVdFlGFW9CTRm5eXUTXqQYHwi4gTZpoR4+GZSrQ0r
uiRv6B3roeK70FkcopnvHpbAsM0RggXu4hQHx1Zk5gb0vbnjeXGTA2hNY/rBl+8oFrDtHd8Nu+7S
FqxqNQUBvgSUC0bGYHUF8CroRhUnKdQ8GtZWPJ/g/x9KAxtao8NuSDY3EuJL+3UhUZSW8T2K1vCR
MIHWNgvm7fEw0MDsLQZkh28burHgMR3opytzbabAl3lxUNAUrippAADfvKmiePsBTTb+OdtnZFq6
wEKXvDwjwNAzU2iUh3fSvNBG9imD68880S2DONFMB4HgpApMtAtlwqwos+JCrMtdlnOLserFyGgv
nPI8eKOuoyrCeM6GAV0Bmxhdyyo+p3L65sskNSnTRHtyEX/UYS8U4ZIyKo2vJ4c4gVnwwJ5KsJLK
tFgr2vtNgc4c4FvKkCvg2GzyLN9ruFHvOVGv33u6VO/JEgHVLBAIDtlQsaHK0UpxFjmRHbHbMs/g
zeZSbxRwoqBSzinN3P4IB0qHyUSi85XSi+Yy+Bnjw5i2jaVAee7KvmrKw0DHRpjLVG7HE5fcak14
qGpZ+UsNt55RZUGARkVjSIktB//EWB/8kxQ1+LEQHy/5Dd09MpGMb3/Kg1C1h2UJ4ZANXomQzPqu
JYl9XVKVqu/ohWzi37GBXjWFQNVCM9oqcjxsIVZg/4Hp1rGcMbJLlsTbYztkBL3sBcI5r3tRHXaE
ADHJZp4xp2a6bGN5ZycTjQ33loasH9BMm+VXRv4kUnMbQDxCXEGAnYUPLTcmuVnEl+csz6l2nEWh
cu3/l/Zky23jyv6KK09zqpIZy7Ed51b5ASIhiSNu5uLthaWxlVg1seWy7DPJ+frT3SBILA0l996X
OOpuYkdvaDTwJiQxArwflHODIED/hO5EsixAMnMDTJ3tlplIU3xYFGkZKlHf5FFXTGl8UqjTGpDb
Ipce9xmZIsuFy6JqZlYpGtZNadCKki0uSSUNqpp1Q6kEGySqbkqcNb4ZyBqaG+cjBQRJmYCKmeNT
GbloYGHxXcmLxuIusQtIFICeCDS2nRjoxrp7GL3wUtOjTTCXuIe5qvU2GD4nQFASKWxTSestlItZ
1nSXXFytwhi3qaiAqLF4v2ibIjjL0GHFU0cFL2TzXSYVTFJIVlFJ+IRis6iKds4fBhIRxuxVSUC9
LGBiU3Hj1NIn0r17sNxrEhdd3Za4/AzJocC4ay3TlsBhFcCR/z1gKEcPDu0rWMtW2SN0j9A0iGRV
FdUoGZj2GMTDm5iGJdoPhRqW+ENVZH/ElzHpnp7qmdTFZ4y+sWf5zyJNAiGkt/AFu1jaeNb1W1+3
g69bXcst6j9movlDXuO/ecO3bqak93jBqYbvLMilS4K/Y6mkK4gRWYq5PD/++InDJwU+F17L5vzd
Zrc9Ozv5/GHyjiNsm9mZzdRUtZwDBRbSx87mgQp2ejxNoE0qtCf4ZXp73V2rm6VeCSH1xCDSE6lt
kH3DrKIdd+u3++3BF2746XkTU4ATYEmJaG0Yxn03qQPEoQdbDtTJonJQ0SJJ40oa0m0pq9ysynGs
N1np/eREkEJ42p0CJ+hWYbODKryjlogqWmgOUneLdi6bdGrP7ADkdin90SrQeMbkD/iwvJM6IlkI
nW9kZvS3AHk+l+P06hbGIdYtZh6xJEEa4tCLsKEBKPIZ8raGp+SZutioDYUaOnRqMIVczV5D+kIP
PfgVCHs5pMwamdiAB1xvQjANUGR1m2Wisqy0/mtvLQ2Y/abCQLbHUFY0hqZP2h8oC247bjFXmNcG
UPiDhVJ6Dv+Tqp2GXoVWbclgi4DKmvNS3iQqq6QI2kAmYZ3ccv4/k2QmLou2UlbNUAY0NbRqokpk
5hpRv5WOGUvjnKxHZI3hK6kvWlEvzM81RCmiWtiP7joLrXwsTKMGsljilEK/83kq/Xo1nhygP0Gj
Bqk8XS5VtCgSjGxWxNMb4LStGRo9EBJc04H+JUVcM2R6nXv14GdK3Zm1acpQuItzQDhmp48u2M+u
+UCFsT7HWnXxx3TIjGfNuPKYBstsKuNYMkuim1Vijj6JvsdUwEdDy/X9MQPvzoEZWMpKD+nA9sDQ
EZnHiTAkXpE5nHNROoCL/PrYY+MAPA01otJlWi/40M7AJ1xjXCa0R9gBdikzdpi98opmMTZZYYGR
UTUM3NqJZd1Ybyyo34PatcxqkBw3YJCfTw6Pjg8Nb64i1JyT9/hqmrwuArfrepIS6mF62mNnjvnc
g4GxWFGrCgqrjtONnYlVv5XgsjjeHiNEVoVTioa4no8B7nt4NWafGjkQGa5Lv4RxASBT3FfMbVIy
bQMoMIBMsIUjEhYBuk14H7RJGGAHFo16odZvhWE+eUMEbLdbKn75E3S3SEAYGkZmWls/9IK2zIxR
t0/rwVLpwFLhNHuT5JOZmsbGfLLy51m4s0CScoeIyxzpkJwEaj87+WSZLBaOzQDqkExCBZ8e2cNp
YD4GMcd7GsMl+XBIToMFfw6O8eeP3LOgNomZ8Nv5+CiEMR/KsBvzyeslmOe4wjruLNT6dnJk51Z1
kYEX6VJ0G0YJlzbJrH5iD58GO13U4I88ONi50Pxp/Clf3ice/DlUzYQ/DbVIeMe6RRJq7bJIzrrK
rZygXEACIjMRoSgVuTtziAAW1yRcMOFIkDeyrQp7GAhTFaCkiJzB3FRJmiYRV+FcyHRvhfNKyqXb
QUSA5poC2w2OHdHkbcL7oKyRgFbvaUHTVsukXtj96t05JiTCe5FNklqqU5snuCO48/miu7owrXrr
YFc9KbS+e3vBPE3bZ0zpZ7hV+uhE41dXyYtW1o1veoD6Xyd1gxopEKJjNHDa0JfE+TYq9DjFqtox
m5sAldRC/eA+6JrSONXpnfFeYegYRwujR8bCdKMAaRcvwLKVldDG7ajU65DMOJM1XShvqiQQU0ue
IwpeTK8ENG1WVFFAr9OURNKVpMFxGp6mywtFalgE3rmthsz4DuSyuSoqTvsbSPDgxvoWj3wjGj20
gtUj3/sKSAsRW2dCLgZmKNAPSkPKgGsxw0v8Scx2iuzp4irHdOe8UTZQwnZ2LQu9WXIMlnAUyQE4
ns5wn5pthh8wWeqEsIyqLomvwS4wsfmc0oih3mjVBag6GXF8RYPZMRTxbvO4+vD09R1HtAB7sasX
YuJW5BIcnfCZ0TnaEzZzt0t5/m73sDI1SCQgWwL0emDInKcJSUhVVRRuo0VZViKpgyOT1GKaym7R
4B9LZb/kAmp0a8fdLYwYdVhL5+++rZ7u8V2e9/jP/fafp/c/Vo8r+LW6f948vd+tvqyhwM39+83z
+v1fz1/eKa66XL88rb8dPKxe7teUoXDkriqCbP24fflxsHnaYBb+zX9W9uNAYJJTLo1oST4u84gv
wTDrTh2Y6vabR++aYgYyzSYYQ8fYyqld0+3b0/3u4O5hffc3NNuMY4QNS0eGddFWLJdaiCqWOfBV
ZBRRUVqz5yGNtrFhSW5LVKTlOJ5fDv5WY3y/el0d7F5f3u4we5yZMxUE0lCv4fht5zg+yPzxrTpM
/pvY4/MrtRjuCOAoIA3aqAn7Iw0adE5x7oqRApgrjDWoDCZ/HPEjbB5FXZm2c+CnFnroSHgVDq8B
utJfl31dVMo3Yp4botxEX5haFi8/nl+3B3fbl/XB9uXgYf3tmV7dsohhoc5Fmbhl9OAjH25ZsQbQ
JwVOycEYwmWUlAvzSNxB+J8Q++KAPmmV+80AGEs4GNheD4MtEaHGL8vSp16aUZ+6BPQ++aSwvsSc
KbeH+x/k6FV9dIAl/bWOkRWC/vCKs25X2yxAUdtHsqymJz8hmQJ+kYlqyTIRfo2qA8W3v75t7j78
vf5xcEdUX19Wzw8/vAVc1cIbithfHKA5VrPo0+fJZ7Amirb0tk0no4iBMUUBkKkTtFYEuxMAgutS
Hp2cTD5b2VcDnVM8nt6Zu9s8P1hxy8Nm85sOsI6OALw5rBIuXlzPTVpczSyrxkEw+W11t0QmwZzj
U0YMNHXDpxEwCDhPh54yJ/5BQWf0N/wViK/Syu2i4dkxB9PpopiaQA/HQeClnzVH6nrW+unr68OH
Z5A+65d/Izfv0ZRh93F7v2YmE135TZt5LYsWYMGJo0MfMfVXaWR7Zwcof+LVr9Yp88kCSuJvFfcE
aXUVLrPk2nbd+Ms1X4D2eEOvr5j3zH5h/NRFRhA3B7+t3l4fMK363ep1fQ9l0D7CnPf/bF4fDla7
3fZuQyjUDP61ZzvNk3piPpDjzMDQVGYTBPIV9ug5GySukTJPLv0FKS8YqISGJEjuNwGPey/ZFfr/
GqVemds9rHfvMSPzevcK/8F5yETkD+I0FUt5NOWGKAs8x6qHAYV2eJRAcvhLKov9nZzFJ8x6zhIY
OUqAxHmXtADJYuvtRj0VyibzgGCHcWAwuTjwR6ZVdfZRc509bAzj86aFr7tclSfma6x6m+He84DX
pCeZ7/kFp1SpjFW0O/jt7scdCKeDl/U9aPgrfKyTlPzdv7x5B/qPRww/QrBZ7c/KVZVvH3Hv7zb2
q9mDMAgf42jmxIYx9Miz4yNmKviT5RG54OSCH+Wsu2n0QCVQh+HdPh48vT3+tX45+KpejuX7J/Ia
76JUbFZ6PQbVFLMf562v3SCm3yzeyBFu7zYjkqjxlU1EeMA/k6aRmD+tUjbkHiw6xYrqRlsqp8e/
Tkwn5kd76Yu6Op+4GnY8Ozs8nByeDVJR55gPzQVNRgsyZ/e8uluD1f26fvkC/zOfuOHQjPUBxv1s
sL/E3d36G1YC3DUalTzYAeLb1y0YdQ+PKmldVLYHvz1unmmDjfz7//C5L9A5cS3qmyyT6B8lnyrm
SzGXjYEu22naU9XtFAn9eFl8p/ALyRfVnN3m65PKE284KfqiVTwaiotoSdZ/74s2/IkuBQ0r/u/8
3Ttjp/1Cray1wkWeJbmAVVdCQ5rZ+fBW4l8vq5cfBy/bt9fNk6m5VSKJT7vSSHmuIaOtY/ioklyK
qqOwOzMAUugY9aERwO8vZVUbLgWKG4T+oyzII1jvs4qyKplGoUWTytxB61yomMdIHUuM27WoYjPN
e4mXaMCIzKbQCrNz6H0RqVMlhlhHWXkdLebk3K3kMHS9TfctOIKavSZTr00jhjNzeng0m7IopYXU
hkbv0yit7hdIeNRgzA0luDLXIaMbjzh8HF0c6KNWOcG2RS7oMsF+zi+lRby/pH0d3lsCqwb1CE4V
GlHBOodG4VsDJosOrZzx+wh07sTM6AGgidWIqGsmh3Eys2FJ03aWSYgKivnz1FIpI/vXJ6s+y1SI
+ns2t8KJt+x1L8s/WODNeiPlSY8C1WSIQLKhKtjOhmOUHMqZ/nDChPY6ksF9boux5EcTypUM+g7T
DtKCeDjfPtCOtN/AA3K0XCHXtwh2f3fXZ6cejLLqlD6tqDIO1iyAw3EIcwX0UMxS6BdcJXV06UEp
R0YfiGRjptGfHowWgJEiRo8A4EdaA2zd07PgxywcB9aXAnQoIawoejAy4q4u0sKaLhOKh7VnARTU
uAdlbsxpZHiZ4AeF0zV4S1mY8enELi9Fqm4n8WCclhx2tCnnrkVViRs3ElbUdRElKmqSCIxdnRZ4
/mdGTQq6IW1ePlQg++LPCOus29QIj83Zz3E0YjxqFCWd0LqSHXEijquuUVc6GKEeDwdy/TshxmTT
YV6UCgpNXEg7n/GoFsimLYm4MF2eIx5v7iF6VuhcTj+jssKIrabC2iuZxiCKRgOLccBFrum7zBpP
xEY0nuqez/rL6u3bK74K9br5+rZ92x08qlOy1ct6Berff9b/Y2gYdFB7K7usj/o89TA1ugUU1jSZ
TDSGTOO14nnA6rSKCkTD20SCyxyNJCJN5jnGC5+fjd/SAsE8q8HbXnp5sU52rVHPU7XxjcVftpmo
l10xm9EZpsEp0sLyC+LvQWJxbU9vu0YY/BTftAH5bqiLWZmouO5BI57OYmN1YEawCp1wTXXjhJVo
vnUZ1wb709C5bPBuQjGLBZP9H79RZ4gqNnggmBV5M9znezShtUN09v3Mg5g8jUCn3yfW0T0BP32f
cH4FwmHqw7Qv2/5KgEqeI4a/1YgkGAveHX/nIwF0e/gATcJODr9P9hRft/nk6HvgNQGiAK47Of0e
ePqsbwAXMlhj+rvCXBYyw1k3pQ6txViWRcPBcPdgWH0mTT9CDYwzs1PqlZgCm9+NxfRPMeccLOnV
RefmofNMQHeJkTlSL9I4+eivvx5ZBZHpPiSYVrF5+mriWhcp6nyCUrqIKQOOHuAkx9wepeagw1mz
tskJ+vyyeXr9W70B+LjemXEQRhQUyF91Tz0QJUX4SOBbUNzc4xxS6BTdpI67xDxCVmH1YETOUzCA
0+EI9lOQ4qJNZHN+PK6kusZYU6+EgYKSUPWtjGUqrMCH+CYXoLwF4+UtfGffWaxvsinGweBdW6CS
5vIJjuyormGBeF9RWjepFRzv8PnOlu3j8+bb+sPr5rF3dKjDkTsFf/FjBFVhvVtqWC8ksUH29lpY
m8opHoF4jcDvwkETBk18JapZ18AOp6MKPQVsSI/90XGgVkJy7hqDppJxG8k4UIJWhkHxcLuwl/jW
ElcGTV2mppZWigUuS9KPENNNmxmLTUWOV32jtI2NtTOPQbJGVVJacgf5Wwddz8+NWyoYy1jCtGGa
yCz0NpOIKbRK1GxmIkDLCm+uwmY0pbPqXq2uiOOiy0QTGWari6G2dUWe3rhlqBDJKymWqDgNaZUM
1/gvrVxa53P0zm7uNM+K13+9ff2KJ4LJE4b4PK6fzLeXMzFP6Oqw9Q7hCBwimWROYWcgA8eBM+lq
4LFsEpm+h7XX55pUq6tOjamzCvFGTVIrAro8t2cXDSUFlirpQ6RsL2HhjO3ofw2l4e9uUeRF24cH
oeuUKY/oVH81g7ULVelLvKIJSveygKeGysV+KFYMXL90yl1azY+ne2cH8Ut5My1Exd3NQTT8t0ny
Fq9bNqLGg4FFEo23ewcDpZ3WIjf7Q4D9Qx3pT/pV/EvrklZwvn79Z/uCknakMr37LN6MPLS/GpgK
yDl53ci8TgKPhqnlhISk9HPiOG2n/sXqEeoF/JmVF1ehxyoJXRZJXeT808pjyzrlLTbHuxeGoBWm
wEHcffYzOMVeo36pLlpOTg8PDwOUQ1TjbBYsDXOZAG82L1n2I0Mpbjw20IPtbMYsBQZ97pk2TYaq
VsUzepvQjRQPkOGLMSgCfoFU3RPek4DPJlebdlC5htM4UG6TfEnR/Nadwl7eUORsi2qbIWqiBfoI
CCUxlzNmvnK/vPSZ8GVGj7oyE3qZ+TNxialxMWdxU7HZJAeqylMCAFjOZ6mYe03oDy4xtNdF9bIQ
K63ZNU8dxoQ0M2Cb7ED5yCgiloazD3sNZAYlW0M3AzqUdM4PO5rYZDP2kNQL55HZ3uMC9AfF9nn3
/iDd3v399qwk9mL19NXM7SHwGWDMOGA5mCwwJiZs5bg4FJKM97axFJ1i1qDQQpeVbGCBFdwKpMHD
uGGHFKyLOPaCmveUZ4wDIrsFPr8AQoTfUmAiXqEKFBccdwMsTjMlLq7R4VhJ23GIjKFTjbEyq+wd
ZnUDCPSl+zdUkkyhYO0aW8En2JibSIcSM8V4cgM2RWZH16njUIx2G8Xdb7vnzRNGwEGjH99e198x
pmT9evf7778bQSKUqIvKneMqHXMomfdrLoeEXZxZjiVgR9x9gd7XtpHX0tuKmOvMvjLeb9GB3Ony
1ZXCgQQsrvBmTZApUGo6r0Jqo+NgU+kjSg+Ax7z1+eTEBZPRVPfYUxerWGJvQBPJ530kdGKu6I69
ihIQBamowIaWrS7tyB2Snjo4EKIp0CKuU2n2cfwWZxsdl1oe1vZA4PN7eE+nc2XlOBVhj2MdzYLf
R3WsKrgSScO5TbVn53+xmj3TsrogEbDXz2F1Cg0mWB9dm9dSxrBZ1VHgHlm8VNI1wJKD1yrcWUzc
hLL2Vg9YBv028mQ2JaRLrNiA3iUyHqW4PgxW0DqsL3h/A+OnopbjeaH5RzUHX+qWoYcZkGDfxyYO
NuWyq+JKnd3wRrf7SVqQc/0XaibSubF7kABTlI7tt3EoXMh2H+Tm0cTEy+uSoTnki4D/9Wl9WLSe
ahvvrWyq9iKcaYKmg65hdnPiTJiotbBSzNkT7LHmi96rUFWBYcU2L4oGL9moedIv0BgcR+XMbApj
sPOiVN0xukhaxazNlb9jPxa6Uy54Gu0udLN9qAIUh85Iu4bpxhgchwQzoNEMcnk5iSLqP1SlGAoG
NYfc5E7dqtbIyaSCXHrIdtUDwWjPKcVpZEUn4aCC2dnVVwn6gNyOG0X1Xoz6yrT7vfK0O9stqCf0
0y26o4neB8qb6hXtz+B4PMFN3x6Pr1vp8D2oLZisxMxyNMpfq8reMGHqMnQgUrnCzVEanl/24gqW
9r6SizoHc1zuIyFD8yfF9Iu2X5j8zXBaeXUONs6i8JekRgzGkL88QBcBsQhrS42tk7/VwvlpxUZt
ktAiBwYm8AK5+s4WTQMVbDKN56/Cq0qD86IfIUoKd7/pBUS7qXZXcWj721gMsHP2+Wgm3eTNoi+d
aRjdonfrVoWr/a1ygpoljtxm71myudHHYMdHpxyoRaR0Lu2m9HHXlOog/mmroEdLrz/MtAyGXEi0
G00zSXkuNWTKJyYSy7QRVnpK2pIJuY4xT2wfrjNKvku2pbXIQOHhV1MvCGHBOA+rkKKD4bu8yy/K
YowhRY4X9kzfIj+0VkhvBTGvCgxchRKT0feBfI0Yngfbte7yenJ6cnLotWEQ407zzfPGZr17RSUb
bdpo++/1y+rr2uzfss1D2Tl6LWRfIttxkdhp0LmoZ+0IXkaFEb7V/xrbA7+1VwsPhUSFHk1+gIgW
j1SqlnK9CfbmsKKCtSQqqYJBzg+/Hx8aLkqi4JyHFWx8knIAx9WLsf+hriHDgKXlFtGD2GnbN0VK
/37bvRonxqPaZsG928zGhfB4e0duce/aA5lFlNMar90WEY0gP8zKgpomaiHUbFfsev4LoP3HZyzS
AgA=

--aUNe/9Ocym7+K5h0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

reproduce (this is a W=1 build):
        git clone https://github.com/intel/lkp-tests.git ~/lkp-tests
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch akpm-mm mm-everything
        git checkout akpm-mm/mm-everything
        b4 shazam https://lore.kernel.org/r/20250708142604.1891156-1-colin.i.king@gmail.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-8.5.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-8.5.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/squashfs/

--aUNe/9Ocym7+K5h0--

