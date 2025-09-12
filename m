Return-Path: <linux-kernel+bounces-813051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53445B5401F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9411C86A99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF51A2387;
	Fri, 12 Sep 2025 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSI9GyJV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757019CC02
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642635; cv=fail; b=PSzSrM6zO3MLkB6tHEWbxpJDUeZA/zhQyy5jc6IACx+4fvREBHkIoSrOVy5gJANpNR4dWnAz+Sz050DbsSSDY9Qezw5gH6nGXTzA5RS8eaqVaDtA4Tjlp3v+taN3kfHUv0FMLuhUdS7S4+We6E3Ax8H0h6nZH8mLD9QeZFp1lEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642635; c=relaxed/simple;
	bh=dc+zDbrQS9wq/L+JYXHrgvqHgE6n5OXSBWc5zI9ZK0w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uXSjgBhsNNVnUOyDV4/0x+MFx9L1H8+fO25XNMbgXfyMuGbnKaKVEm9Yza8G45cNBhqEvb6OfdNu7110TUfgp+xz2tDEuT8m/19q2WbvJ7fLtkGY3ziGI22iARwaER+IhpFq0APGNfBARF/nCKaSkGUe/wU245fFQxPzz2P2Tuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSI9GyJV; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757642633; x=1789178633;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dc+zDbrQS9wq/L+JYXHrgvqHgE6n5OXSBWc5zI9ZK0w=;
  b=QSI9GyJVECcCeuASvYeFuz7Pw4jz0IYQRbGS0Jk8ElyS2kbQoZIlM2rx
   19t/qVwmncW6s/sg9ShAiTUVPGube+UQwU4W7LlWhjcMU+LtkxHdYp335
   lrkR4Ok8600VY7sBdf4zTFczUsM0Ydrb+Rs4ERGn08RP6sI7f9RJOCVjW
   +u4SDAThtdgPRlirauwVmvoL+qsNBhLiuxiJQX/tqA2dHwZ3KzoBpLdR+
   5aBCn8HOAKkI9VTv85+oMKzOQYZMkiTyhOEU1eYywt47xvJh4CO6beymb
   aOw3NvSDB0zm2CaZhWQPdT+DNUCA138ol8HCfK30VE5pexR3OyphmeAGb
   g==;
X-CSE-ConnectionGUID: 5HlbrshrQFK1nX8x78ewpg==
X-CSE-MsgGUID: FsDN9/dSQ423z7B38tJmYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59843629"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="59843629"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 19:03:52 -0700
X-CSE-ConnectionGUID: dHGwrTHzQ3yNq/GnJLhUDA==
X-CSE-MsgGUID: NHhfNXIJQzSAPmYZHYSrew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="173920458"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 19:03:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 19:03:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 19:03:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 19:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdZ+0wWtm/3CM6bn2SFkaMCjt4rym17+SxlPOlu0C1/y5drtAK5N9OBvjcE7pYO/AOUBjem9ipiDnSCaEO3vi4wsLfszKcuLF9bBzK37ekswVAo1KuyE1QdInQeNwOzaiT7a0JqbHInMDkJwVwBlv4qLPJ1KAyeEcNba9sLmddtCOlkRuwh9RQ6IfUkli0XzN6FkLf6+LIx8T9qPbUBztJVyHWt9jVh6qLGXTT6HG4pnVByCqNiN8I4tCnxT311RUrm/n+1bARXEuYq/0tj6UJHLnjgIG2ipsPy1UhuNPvewu5eO3jm6H34akQJk7t/VpCRWYkPH89P0SZDyeonZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l1IoBByZHFuzHY79jIRo/0HjLe7n4egVBxRft3eTxY=;
 b=pfJY4CS1r8FHE/VWD9X4FEZr/UiE0fSbcLVjiUjO50zcwcGD2YGS5ErU9SRMgOr1/YPV+utz6gCqplZMIV8+UUcfpGNVGQZ0a3eBC4yTDNtJzIeU2a6DiE3uFd7Q0BxU9GMRlDl9eeWWZyYLfPUTeWEAzuBgdTsaK1Udx7Ubn2EpBbJPdBB/E/MHOcuHLPBQD2Xhh95g1CVm3FYYkw9ARWvM1IA0GWtiTf0dyI9B/xgBy9Z08Vgsdc6OqBN/UhUr5v8Cel6BqZjtpaU9oBt9k/fpusr33qqoB4bqMhAWkv0wUoxTn0GG7im4cUL6hpn4f0O4PYuK+gZqPEvBW7weRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 02:03:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 02:03:48 +0000
Date: Fri, 12 Sep 2025 10:03:39 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [peterz-queue:sched/hrtick] [entry,hrtimer,x86] ebf33ab570:
 BUG:soft_lockup-CPU##stuck_for#s![pthread_mutex1_:#]
Message-ID: <aMN/e2MHdJaaGT6z@xsang-OptiPlex-9020>
References: <202509081329.81f1ed82-lkp@intel.com>
 <20250911073304.GN4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250911073304.GN4067720@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a515856-d1bf-46ad-ca1b-08ddf1a09c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5IjJGYi7lRpihyeynuuhPXQpIvEvnLvDp4zkxrp/zdOv4M7r+75a75TnnlcY?=
 =?us-ascii?Q?ffy5PhfNzyAL92HndHgRtYU65qtg+rF3Q1P/XFKSuQANObceI5sXW90xEUOq?=
 =?us-ascii?Q?G/PIsxz+Uj5aGmouofDkCA84Uoj09IIdKstbpvjB2Zk90j0sqKUHNUS//PKw?=
 =?us-ascii?Q?1ikSGgsEZn2LW0UcniSTBMlvQmyHQQ4MIUBLOHDsnk6zome4/cFiPx23MkLP?=
 =?us-ascii?Q?zT41721lf+nWbCyzHp08s3MSTss2BIUZcQkyXjvkxnLpY/0N9QntCEmDX/rT?=
 =?us-ascii?Q?63CV44qo1bxEeQi5sMN7v6z1aDqiiORzTupDU6PJjiyK7L0FCJkNukJfqBWI?=
 =?us-ascii?Q?ZXgvPiBfiD5TEAh7YgRsfZZyTTaaQFInf4wezVepeAS10+P42qblFxa4oEzE?=
 =?us-ascii?Q?KcfrjkJNOtxXV4hnRidRybORVv5y3pfOCwMqkN1LVo9GfDzIf1/WyhlsYhw0?=
 =?us-ascii?Q?j+ZXgaEu/+EgibTWuC1LBBn1eojUSy6xA7Lc1oFbMEJCh75UJ0xAxWflFjMW?=
 =?us-ascii?Q?nPudzt+kAV77aF+C66kSPjbh8KQ/I8oQoKGX5lHUqLuC3XoPMW+I3kAp4M/i?=
 =?us-ascii?Q?ZLoRsioqWF6/TjTKn3KtPuGJUP+IFL/k5lKRykrwAi8l1z6slt6HbRe3o0s7?=
 =?us-ascii?Q?CJerFA7d/9kIJUTAQWWIbskFKgSve7n90js5EhJZtSLl9RFJgeEShwhmWIkz?=
 =?us-ascii?Q?MPI6uAgPmOlVefb1d3UV3ruMe++gn3q7brOpO3XOWMoSfSHXs2wK7cB1tIKM?=
 =?us-ascii?Q?aFFby4IKW4wv/F8LpUDz8B4YUi64yd/z+9LkcrlfncgkjwIXjg43ZeeNzOsL?=
 =?us-ascii?Q?8I60uxmYUD7Ht4HL1Au961Rq/PCco8/L7q6Ok8nrkpFJzgTZ9Hxy5U+XkAVY?=
 =?us-ascii?Q?Zw0kG3Gp6O+FjcKirMygG+gy7GUjBXroN5dC3Plv8p/btSdSyO+D28BuiY/j?=
 =?us-ascii?Q?qv+m7R86QWiKske4XQC15CBSDRw293tEHdESoAhLabLd54PwCjH7BDNJvHM+?=
 =?us-ascii?Q?Yh9qgK91qyfZmhf5o+mr01gvRktrYABKF/VYhe/cmWWvzy54AtrMvPuR01QR?=
 =?us-ascii?Q?3YUqgibWBJjo8lVpjc3OvyOMd3ZjP6Ivf2pwWDdncpH1YMqlg+MGjhbaatUo?=
 =?us-ascii?Q?XUaoVOJ05VJiK7fobtOo/nLtgoop6J1AFlZV2pSMC5Gl81W3d8w9nTrthUdk?=
 =?us-ascii?Q?HmwNFs2lDIMMUYmH+rb9BLWJW2RDGvJG0RqWMXa6N2ZcwHbLpZYhm+mnaonQ?=
 =?us-ascii?Q?BvT+07S7r06aY5yiii9VQwvYNeE6IM2G8u6/ooOFDYrpyQt1ETuAtG7YUSxa?=
 =?us-ascii?Q?JMsjS3vOu8YQvsiGwjortI7cra5w2Lrn/j2vdf86xBsjXX20VKq5W+mM9XFv?=
 =?us-ascii?Q?PbgpNDgoVIChWvUcpRkzE/GnSEpB4x0EZ+ZnKFIPRxgt7PbR321AfbX3HMT+?=
 =?us-ascii?Q?UsxOQlZBY4M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aAFIOghHzqff8oizl4OBU3FiuXhgHAw1f1aS+orSUWvnOBK8UjZMMmPck+wo?=
 =?us-ascii?Q?6tBIQhH3lv2dkCEG/u7pmqdB4sNxnB/b38gErQCInTmFoL3PSk/TWSADaM1S?=
 =?us-ascii?Q?+mlrrqmTwn8521SHgoCAsgzJtEwN2Yw2atX+wz2KPPoY6rO5SKxoNDBVkF3L?=
 =?us-ascii?Q?HzOQJtdt9TsRPQ8mqNb6OChEWHbCQKOB4myqW0LqN93a8vZGoJWQSC7FGUKB?=
 =?us-ascii?Q?GVdtc1qcOD4jrdwNalbeIfmpw9FhW/uy4d7aFisDd0oXgcGmBNTZcrGZNQ8/?=
 =?us-ascii?Q?0gN7qYgbLCJccRxFqr0ny9ko1LiqHrlQPsFuElGu+sVPurlrEsatY4IJ9/g5?=
 =?us-ascii?Q?/vMLXIEWSzJo8WFjE4Tm3bgYFiS8MmjkxGPfsMHnBP6JGEQm5tqWCw4JhNq4?=
 =?us-ascii?Q?2Dtz8V9OR7PMWYGH5uUIg8MpZpj/TCKV/xa5TRgseuVH03ErYvYuWVaa20eo?=
 =?us-ascii?Q?Y69TxDDXKZdWXdy2Ci1fRZcuYmoz115i/jXi3vuk13gFgf47L4/qVV1A0AuL?=
 =?us-ascii?Q?JvV/LkTh/vMU6TxUGKRx5/iWYeQLe/suB8b5vUjCNBshqj7vyK01oND1vrPC?=
 =?us-ascii?Q?Ngv0p7LgE/GiLtTI1KVL8RbJ8iEjvV2tZO/8GAsZMujMgnvUxpLlVZYOBolk?=
 =?us-ascii?Q?Vin8CHIJBcMHZUK0RnLErVBNLq2BwPlfxqj9KNBDxXT8u8kz8ZkpKmYdjSDB?=
 =?us-ascii?Q?73GnQQLH320qFpR5ABs7WJy4Gq8tpykJd2YPEENqxkPknlXcskK+9cd5rpqB?=
 =?us-ascii?Q?4BaRhR9GMUe0sX0HPCX8Ws25mew0f6+gbxkwBWFIbP/dXvSV2geSLagxLkBn?=
 =?us-ascii?Q?2HqmKvkeTFSuXCKGuniVt3wKpcqFN8ZWxjgocOd+OfE9BZL1gwPDRacWXiD+?=
 =?us-ascii?Q?F0KDN2Il7lzLOKzvMAYPxWTr1jmTKAMf9cqYd5kwnA/yQ+4z6DprxDVOInSd?=
 =?us-ascii?Q?1DWt6urTgqDMdMm/HdCp1g4r6V4BZSUN1Q7wExr+IJYK0DgJ4Ms1ylbrniZx?=
 =?us-ascii?Q?h7dFiLp9mLERX3HPoNEFK6rbkgUkluZe8ehuN4iissQZ9V9bptD8rkthLw/p?=
 =?us-ascii?Q?taGRmITL4sPp1TMrO5uxSiudOv7dP6N+tM8ZtpYhmZKl8TsuQ3VeoOGjGXxB?=
 =?us-ascii?Q?oguyuUAVYinVD+kh2q0HV5u9p8/jX0WBNFlLgaSaz2k9U1sHrVAoNLZlUVHs?=
 =?us-ascii?Q?Cm+4UtRaXVC+TPAnpslJU4iumt4AyNofvZ2J8DGUuJmYNqiM44MOG5Yc9ojJ?=
 =?us-ascii?Q?RZKuJJRcR1MjJOKut0X/95+RSnvporLaz4WsDkMfprFuDOV9vVmRd3hCVpM8?=
 =?us-ascii?Q?M2CXsMnzHuU41idSLg75vH9cVpYhszhmt3DOqJbX2f6kVlXjPely2N0k+GRD?=
 =?us-ascii?Q?r8QgGp2lnKQwZ8Nnf9RWDFhSs9x6+f2+Eql2ffbbDlu8nZi+Zqe2DMmDs2VN?=
 =?us-ascii?Q?x+vXXZE+dtFua60MANqlA1XM/VPoe64in0tHg1px7EN1NKOmleNuW00Ihexi?=
 =?us-ascii?Q?L9mgk0Ho/kLnCvWGfX+kozCspnR4sUu+A1D4jpGWh3/lFOhqFQrE1fMdPCMK?=
 =?us-ascii?Q?tS7pJQl32rv3B5TO2+oq5lgJU3q1HgJl+CiuKnmS4TFiHV8/dKsrj774u+bh?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a515856-d1bf-46ad-ca1b-08ddf1a09c5b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 02:03:47.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bp6BYRVbrVQDWmPZcRPaCLSsOTJEcg87YaDujtX/wj2dRWclRPV1tkfluBBXOIRuVFDw5KldZJz/3p5bdAG4wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com

hi, Peter Zijlstra,

On Thu, Sep 11, 2025 at 09:33:04AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 08, 2025 at 01:24:54PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![pthread_mutex1_:#]" on:
> > 
> > commit: ebf33ab5707c7c9ea25e3c03540b1329ad9aff1d ("entry,hrtimer,x86: Push reprogramming timers into the interrupt return path")
> > https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/hrtick
> > 
> > in testcase: will-it-scale
> > version: will-it-scale-x86_64-75f66e4-1_20250906
> > with following parameters:
> > 
> > 	nr_task: 100%
> > 	mode: thread
> > 	test: pthread_mutex1
> > 	cpufreq_governor: performance
> > 
> > 
> > 
> > config: x86_64-rhel-9.4
> > compiler: gcc-13
> > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> 
> Is this the same issue again as last time? Eg. disabling all the perf
> monitors makes it go?

yes, if disabling all monitors, the issue disappeared.

