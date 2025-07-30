Return-Path: <linux-kernel+bounces-750879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30801B16231
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C467161C33
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3988E2D8DDD;
	Wed, 30 Jul 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5ZroBMC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1C2D613
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884262; cv=fail; b=m6NGYG7XTk91B1gCha5Plpk1wBbkJyS+AnJaGuCE09BOhcGW5fJQJM70Jx6BIz+lAVef7/JOX302s3ev/8kuqCN3+uRBP76HzRKNkggThbopvaWwuJ2gM13MYP4QmCwuEjTU6idMKZldlL/ba1VAeZLIfHfLaJfZtQel9DnLSao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884262; c=relaxed/simple;
	bh=B0fHhgp9py2liLogGA1mvnfbBV/lT9d543/dMGC+jkQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iC47h32WTYYZdng96XjYGnzR8kY9XQLSlGsQqGYtITkNI0scq4DQh+0YrU+KeMNrJw0VGarTaz+FimHGd3ZT48fDE69W7CQ3LgSP0E9or27K3ywmuvFsLpzJyN4z/R4lTtyuem1gkxa+x97M5npVX4uwWi0gQlDVRGx9vcpyW/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5ZroBMC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753884260; x=1785420260;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=B0fHhgp9py2liLogGA1mvnfbBV/lT9d543/dMGC+jkQ=;
  b=N5ZroBMCkH+dplsh8nxUptPGzHLR9haWhWmZLsY5IQ24VxjQZ0aR3THT
   ilEn4/6NbgjzQb1U3XtQEBKhq956/u4W+fSh8F6uY/mMfYy0ZVepiZF2t
   VHzS8qEhPGjVbNMzOqr+2SboYDsnicw1xsA0oNfX4gEBLgQ/uXRpQU497
   6WHoT8oS99BAn4bYARLnz/a1RdOumaCe5WBRhPAWSxAC2hjDpemLK9Z16
   Y2t/EqV5ipQe0jYhZwtz0BQbmqUMYhKML91If4HSwwqA+GsClrrrtRNtF
   yrVrKjXiZpWqy2SVJmpzsO3wPkvAPyPAVkIFFA1RzVpMX80iQg+xUxvhc
   Q==;
X-CSE-ConnectionGUID: tlRy1ttdTPWvJdoLJNqCcA==
X-CSE-MsgGUID: DL3m6k71Q+6P/IXLVHmPIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="60000572"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="60000572"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:03:41 -0700
X-CSE-ConnectionGUID: Ob4yVsT4R8m28b290Gl6Ng==
X-CSE-MsgGUID: LvH6XUpbQqOJN8PlJWzXQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163779106"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:03:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 07:03:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 07:03:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 07:03:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smOSat+K74Z0CQouX8yLEPGM5jDJsLGwBKct+oeKrcc6PxsNuq1lVv8Xa8DofF9Ly2KGv4K+mNW8FmilVRcLy0yMPowMVrsAxodE/cicrdpfJDEi2KMbyqXo/9m5BiynqT6+OtpV5TmVu8NZRx5eUo9MLJtULHMuByM9UH7P5kl+RAo58iQydJoT4RhiV685XybalfXhnMlg2RIJU7XZweuWKrqNPoB3OKM/sa9fXhqiKgTaZCmBplLSj8TxDMiWvO1AhrhZyVk/2MEi89X56u2WCLQbrmYwEs6hZwv7YXSONPDbdvfL9BaxAog3+dCLIrIG49WHRpDitjDWy8s+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gnspwjrusStyCTDEseKgruLdDewF1XaqDYKKHr7cTM=;
 b=CMlX6n0qfZFga3iZNmrtzEW1NIahiO6BR1AexftR34t5JvuU/zGwMR97Wsx20OSJPv5SLoc+zbMLpRBifz/iTreoKHUW56cl0zE3e3iggiHcX84gsX2QE0v/ynTHO0/j+z1ZhP3ybvt7XnJBz6bpapWtoAU0Ae/xJz+cey8dVTyf24HQjvvlLgjw2vQs6za9e9Q7hje9MDeAwfWM81OfvgLbxEVRsJl4yomTIhzatXdZHPzL8nCDLGezUsOBhjaHkH/yi1HOvpqnaZYlm2yboGEhEcHXJu3Joa1alo+hHASj55kARapzHrwPGPP/VSUu4dwZ8UnlIN2Rn+Vr5USfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 14:03:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 14:03:35 +0000
Date: Wed, 30 Jul 2025 22:03:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/fair]  74eec63661:
 stress-ng.resched.ops_per_sec 21.9% improvement
Message-ID: <202507301510.d28b6de2-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f3c992-49b7-4fb6-dc55-08ddcf71dfa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?P86vtakrElf9ZiG+W/NlqhAV95wAW41tD2LWnAVmfdgaR1GBEIs1nXTZeU?=
 =?iso-8859-1?Q?3OVonvyaFuQmEi7gPVsBCz75l36ond588FDe+BedO36NDXaaXmOTYEEAXv?=
 =?iso-8859-1?Q?bc1jSreVZSYPBIUlaLIOivxTLpqp1wP3/kRNhlgOVIwfs7cXRhQ+c4kEMp?=
 =?iso-8859-1?Q?o0O+amXVdW7FFJHCwGo+oEGATR1yO1RnDuQ+xK7P6jJDOJFVGfqP0rSKK0?=
 =?iso-8859-1?Q?oyAmAo4PvR9EIy4cz7QFRtqpzZRPlFewVK1TCX5xA7GxmsXB6eJUpFKO0p?=
 =?iso-8859-1?Q?5jLpNCniFkBdx/nXx88vXO1utkVqdIC8yDz8TMLUI//y6iAGOUS+DQWx8k?=
 =?iso-8859-1?Q?dqRrxLb4xIyXweLLWPF7tuP976v24U+KjEFZMDfRuX++NPnLe7e9L3RExz?=
 =?iso-8859-1?Q?HuMPtGawSfbHhfVH+K8qIGqV7NkfRHhU2OL5Wn2qa3EzCsGWgTWgOWQZlq?=
 =?iso-8859-1?Q?kFYF55svHFt1MqutYxUMEuFsVx2dWq4Leo1r/G6XZhpy4EXIAhHRPXy+qY?=
 =?iso-8859-1?Q?vmudZ9RItE42jkWBJzPf6QE4x09KM0xkAuPrzL4niRGkhStCx3rLq0mM5v?=
 =?iso-8859-1?Q?CwuFwR69vUF4C9iN6lbRM3mtCKSLo61/kx2Dc66t8BsEO7TOpBQk2WAO3P?=
 =?iso-8859-1?Q?5LG6Re2Qzrjpg0NvcVKWIqoObI+yHOc/6Xr9e36+aBypu0kSDoIQ3nDOMg?=
 =?iso-8859-1?Q?k+2ClH8vBSeOaj16q2nNU6Iimqx+2BXU5azMlXDfRCx62A1s6p7fxE0WuJ?=
 =?iso-8859-1?Q?uTLE3aCEGOobZcxekwqoxBKUX3300Qiq13q1LDXvDH7Sk4/9Whb0YXpT+V?=
 =?iso-8859-1?Q?ox3nC4KOOiMrKGl1YMfCni2tmMj9E7NlE60WiO0tfqfOQ1t8U8EEVQJJWU?=
 =?iso-8859-1?Q?OEaZZXuK/21xyAKXQmZ3bSTaiVwrE5tgh746uQHvv7jPt9ooLcHiJc04kP?=
 =?iso-8859-1?Q?0c0u29DaWzGEVDCqUhNRhSyxcF6GNnQepdiNGh1FWlnIvEPKWjHzS72IP1?=
 =?iso-8859-1?Q?qx23moOCBDD78QxoUUvRQsZb3MpGJ8/ilE6uje79FE2tmg0TDANhJTxl9u?=
 =?iso-8859-1?Q?YBr5oQpuXpQHjtMjwTFc8OeNQRUMTuvzgYHjyl1iKrS3evtvF7DVInHyFP?=
 =?iso-8859-1?Q?HmaBwfAAUu9G+s3vjiiVsnDv3BGLzG/O9753/eETTSfCJP2rLCwAYW3L27?=
 =?iso-8859-1?Q?4aLBA5wy3Nuj0nddDOsR7pJ3RxfZMKoE2fz/ah/TohBTgfKnXVk4g2JppL?=
 =?iso-8859-1?Q?lXlQhmF7C3Z+eU5JLTtFcbpoc8ntZQ/uV0aDxticWm0//bXGjFzuDegSWI?=
 =?iso-8859-1?Q?pVdOLCcTZiWBJKFm57f6OpqydfrBAElDsRd058IE4rSHHplfU4XszxtWJS?=
 =?iso-8859-1?Q?1gWsUbzBNBJwj0c0lfvIYq7+bFqcIKSZ7X71PElTWU5zWR1tyDiIqlBniQ?=
 =?iso-8859-1?Q?r6lfhVVQLLpYcSYZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?818drm4U6nfhZBHUAuUYJw0tsJTe5ubZvnJUV42+Hwk/L7rY4xsTmpbQKc?=
 =?iso-8859-1?Q?tF+wFjA7RhomxMUTDSCdWV5sdw/1T0N6ZhRf8snyUpnE9KMiHWQ+Y8kYrD?=
 =?iso-8859-1?Q?PS9NmhhhnqKnZdzhFIdjEF/vOQsgFjMQAm+UU9E+MDAwwn3NhLl3ULxF5y?=
 =?iso-8859-1?Q?WzrGkxgkS3giG9apCM5DTy5w/4/FFosiwF6hKqKLzEtecKalrYw44vPVEC?=
 =?iso-8859-1?Q?q0gG+/REQvAzD941NDQes/b/5D80hwwCRNhHeTiNRuY+kt5ltQQIHzRPai?=
 =?iso-8859-1?Q?/XG+e818xMpb3WP4MOxoXPwgCwwV/0RsBIMc34wkXtLV2QNjxcOs8U8ecm?=
 =?iso-8859-1?Q?S3pLqCezWLXJ7/APpdyVxmTp672zCLwNLNi/90WY8EN2C9R+4oVT2Fl1zH?=
 =?iso-8859-1?Q?blaKw6IJPf0QxB1RZO2UlmXikobcwZJYhjCHH58TgmRh0ja3AyQbcSBd/q?=
 =?iso-8859-1?Q?fr5QLbfwPbCV01y/kWVkvbra6QDSTquKKUAvoeblbxfb6p8K3bkMLnbsFt?=
 =?iso-8859-1?Q?wFFhMpjX0DfYXD5ASvB1teLGwdIzZ5VRpTGKtvLKivx2NGcxut4rQlxsie?=
 =?iso-8859-1?Q?nx2+lBqV6d43W8wvqOHkfs3CyBkIBjf77b7KINaKwNSTCBoJItsmj5BQxa?=
 =?iso-8859-1?Q?dXuuNUYFx6IvPO5nuy8Knz78I1ztoW8PusJAwGzjQGFrH0IHWzC6XGwQzh?=
 =?iso-8859-1?Q?OuOp8spYfOxpniq/vN+7a2yTdZcLSMEbey9uY/AQTTACimHO8ZkqNudaQv?=
 =?iso-8859-1?Q?l5cWhUwWPd+UYs+BeskAtAowxF5KYJVI5z85oTWoOGy3w+9Gm0ZUENntU1?=
 =?iso-8859-1?Q?+efT0Ou3TLm0gLJUyxUnVIEdh/h7/oqllOnKF+scRqsTAcXsneFE9nRrpV?=
 =?iso-8859-1?Q?mHXM8Dlh8k9ZOndMlgkOJqR4PxJc8zXTa4vgY93bYTYp7RKK8O03o+HDM8?=
 =?iso-8859-1?Q?kB1DnoOMn1cgoTpO/cP4nNVffDYfX7RD/8/kqRBetepxRBz8EnFPTgWel+?=
 =?iso-8859-1?Q?lG8w/wCkr6iqOGgZEo+ramwsEcSTFyyKeo3UO/5zMzlr8phd9mm1JzOP5A?=
 =?iso-8859-1?Q?8/C/3dh+HEUpSMgpUJbJM1w2ABTpUWA+VEqstwwc4iWS1SJ8HZ4ZXVxk5s?=
 =?iso-8859-1?Q?kCROLLu4eqH52PwAMTgIXRdPaahmq2HZ2ob02CaXUhkCTb/MKdCHL3Nhmk?=
 =?iso-8859-1?Q?1p+u7S+e8bk1hrvFQzfM95aYG4tIYcMjdumgGac+ZE73/m1BgpNdA9J3Vx?=
 =?iso-8859-1?Q?75phGpIBypoQQCWZPymjqMZr48DKktmVz/teLzNYb5fCzYcH9KNgE9eIgj?=
 =?iso-8859-1?Q?+29aQyChTkNVck9KoqH87PBBtj2WMgzpIlPDVL0OnAnbLIn2ds3Cxr23QJ?=
 =?iso-8859-1?Q?qBv5RXN4OLuxfwunYd6fQvMLW3o1fRTWpNloCc9ivpZ+MkflN+X6kqxm6E?=
 =?iso-8859-1?Q?XPAuJICCBCeMivyCuhXyV4h7J6I6uVwhB/BVhzpVQRjFnsNUtk+AGBFDJY?=
 =?iso-8859-1?Q?SnFV3VQFPydlUp4uEgMw5MpXyCGvH3KXAEOxnv1wzpwtWPj/6fbAp1HSkd?=
 =?iso-8859-1?Q?dNPcrOfImJ9MP0hFJYgjcmW4zquvsMDausWyEPRGgV4XPPnyYoyqZbO67e?=
 =?iso-8859-1?Q?2rwb5uBJnP+ny52rU6ByLzxffm89+EWv3TQtiXUhMYsJ0293Dm/cC0qw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f3c992-49b7-4fb6-dc55-08ddcf71dfa2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:03:35.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuqE/Vq255ZGvDSyJfXxerT/5QW9PdsVBxrubB8gj59EVftkuHI+04VugcS4G77BtQhjoLehgwaafEzQTIez+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7965
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 21.9% improvement of stress-ng.resched.ops_per_sec on:


commit: 74eec63661d46a7153d04c2e0249eeb76cc76d44 ("sched/fair: Fix NO_RUN_TO_PARITY case")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: resched
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.resched.ops_per_sec 19.4% improvement                                   |
| test machine     | 256 threads 2 sockets Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz (Granite Rapids) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                                 |
|                  | nr_threads=100%                                                                              |
|                  | test=resched                                                                                 |
|                  | testtime=60s                                                                                 |
+------------------+----------------------------------------------------------------------------------------------+



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250730/202507301510.d28b6de2-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/resched/stress-ng/60s

commit: 
  9cdb4fe20c ("sched/fair: Use protect_slice() instead of direct comparison")
  74eec63661 ("sched/fair: Fix NO_RUN_TO_PARITY case")

9cdb4fe20cd239c8 74eec63661d46a7153d04c2e024 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    657860 ±  5%      -8.7%     600791 ±  8%  numa-vmstat.node1.nr_shmem
  56304616            -4.0%   54050182        proc-vmstat.pgfault
   4291733 ±  5%     -30.4%    2988917 ±  5%  vmstat.system.cs
    194589            -2.6%     189617        vmstat.system.in
 5.486e+08           +21.8%  6.683e+08        stress-ng.resched.ops
   9127953           +21.9%   11123088        stress-ng.resched.ops_per_sec
 2.679e+08 ±  4%     -30.7%  1.857e+08 ±  4%  stress-ng.time.involuntary_context_switches
  55765179            -4.0%   53509261        stress-ng.time.minor_page_faults
   2582880            -3.5%    2492302        stress-ng.time.voluntary_context_switches
     16.02 ± 27%     -44.7%       8.86 ± 43%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     15.94 ± 27%     -46.9%       8.47 ± 43%  sched_debug.cfs_rq:/.removed.util_avg.avg
   2070985 ±  4%     -30.3%    1444436 ±  4%  sched_debug.cpu.nr_switches.avg
   2857618 ±  4%     -28.6%    2040529 ±  5%  sched_debug.cpu.nr_switches.max
   1258474 ± 11%     -29.9%     882343 ± 17%  sched_debug.cpu.nr_switches.min
    290329 ± 13%     -27.7%     209861 ± 10%  sched_debug.cpu.nr_switches.stddev
 2.361e+10            +7.9%  2.547e+10        perf-stat.i.branch-instructions
      0.70            -0.1        0.56 ±  2%  perf-stat.i.branch-miss-rate%
 1.653e+08 ±  2%     -13.0%  1.438e+08 ±  3%  perf-stat.i.branch-misses
     26.05 ±  3%      +0.8       26.85        perf-stat.i.cache-miss-rate%
 5.035e+08            -4.1%   4.83e+08        perf-stat.i.cache-references
   4423027 ±  4%     -30.4%    3078097 ±  5%  perf-stat.i.context-switches
      1.81            -6.6%       1.69        perf-stat.i.cpi
 1.075e+11            +7.0%  1.151e+11        perf-stat.i.instructions
      0.55            +7.0%       0.59        perf-stat.i.ipc
     97.87 ±  3%     -22.6%      75.73 ±  3%  perf-stat.i.metric.K/sec
    921281            -4.0%     884842        perf-stat.i.minor-faults
    921282            -4.0%     884843        perf-stat.i.page-faults
      0.71            -0.1        0.57 ±  2%  perf-stat.overall.branch-miss-rate%
     25.66 ±  2%      +0.7       26.38        perf-stat.overall.cache-miss-rate%
      1.82            -6.7%       1.70        perf-stat.overall.cpi
      0.55            +7.1%       0.59        perf-stat.overall.ipc
 2.285e+10            +7.9%  2.465e+10        perf-stat.ps.branch-instructions
 1.623e+08           -12.7%  1.416e+08 ±  2%  perf-stat.ps.branch-misses
 4.891e+08            -4.3%  4.683e+08        perf-stat.ps.cache-references
   4295213 ±  4%     -30.4%    2989414 ±  4%  perf-stat.ps.context-switches
  1.04e+11            +7.0%  1.113e+11        perf-stat.ps.instructions
    894249            -4.1%     857833        perf-stat.ps.minor-faults
    894249            -4.1%     857833        perf-stat.ps.page-faults
 6.319e+12 ±  2%      +6.4%  6.722e+12        perf-stat.total.instructions
      3.77 ± 11%     +31.8%       4.96 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      1.87 ±  6%     +45.1%       2.71 ± 11%  perf-sched.sch_delay.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.66 ±  6%     +45.1%       3.86 ± 15%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.68 ±  7%    +168.2%       4.51 ± 18%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    505.64 ±  9%     +51.8%     767.47 ± 38%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
    523.59 ± 14%     +54.8%     810.36 ± 12%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
    469.18 ± 29%     +48.5%     696.94 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
    943.74 ± 16%     +33.4%       1258 ± 13%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.39 ± 65%   +4676.7%     114.26 ±167%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    366.34 ± 40%     +87.0%     685.05 ± 28%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      1.84 ±  5%     +54.3%       2.84 ±  8%  perf-sched.total_sch_delay.average.ms
      3.97 ±  5%     +53.8%       6.11 ±  8%  perf-sched.total_wait_and_delay.average.ms
   3525548 ±  7%     -36.2%    2247702 ±  9%  perf-sched.total_wait_and_delay.count.ms
      2.13 ±  5%     +53.5%       3.27 ±  8%  perf-sched.total_wait_time.average.ms
      9.04 ± 10%     +28.6%      11.62 ± 18%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      3.73 ±  6%     +45.0%       5.40 ± 11%  perf-sched.wait_and_delay.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.12 ±  9%     +28.2%       0.15 ± 10%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      6.63 ±  5%     +38.3%       9.17 ± 13%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.37 ±  7%    +167.8%       9.03 ± 18%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    585.45 ± 17%     -45.4%     319.80 ± 58%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
     99.52 ±  3%     +30.7%     130.08 ±  5%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     33.69 ±  3%     +25.5%      42.28 ±  6%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    218.67 ± 24%     -72.7%      59.67 ±141%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
      2355 ± 21%     -37.8%       1465 ± 47%  perf-sched.wait_and_delay.count.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      2053 ± 25%     -28.0%       1478 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      4693 ± 22%     -27.7%       3393 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
     90.67 ± 28%     -48.3%      46.83 ± 48%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
    265.67 ± 28%     -60.1%     106.00 ± 52%  perf-sched.wait_and_delay.count.__cond_resched.pidfs_exit.release_task.wait_task_zombie.__do_wait
     90.00 ± 58%     -65.0%      31.50 ± 28%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
   2944084 ±  5%     -35.1%    1910160 ±  6%  perf-sched.wait_and_delay.count.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     44206 ±  4%     -17.9%      36306 ±  6%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     41891 ±  5%     -19.7%      33635 ±  8%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1201 ± 21%     -37.7%     749.00 ± 47%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      1593 ± 18%     -30.1%       1114 ± 20%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
     49.33 ± 35%     -71.6%      14.00 ±105%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      5735 ±  5%     -27.0%       4188 ±  8%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      9719 ±  3%     -19.9%       7787 ±  7%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1053 ± 14%     +55.3%       1635 ± 11%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
    943.45 ± 29%     +50.1%       1416 ± 19%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
      2670 ± 17%     -31.3%       1834 ± 58%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      5.42 ±114%    +188.9%      15.65 ± 66%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pud_alloc
      5.27 ±  9%     +26.4%       6.66 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      1.86 ±  6%     +44.8%       2.69 ± 11%  perf-sched.wait_time.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.12 ±  6%     +26.9%       0.15 ±  7%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      3.97 ±  5%     +33.8%       5.31 ± 12%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.69 ±  6%    +167.3%       4.52 ± 18%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     99.46 ±  3%     +30.7%     129.97 ±  5%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     33.44 ±  2%     +25.7%      42.03 ±  6%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    505.64 ±  9%     +51.8%     767.47 ± 38%  perf-sched.wait_time.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
    529.48 ± 14%     +55.8%     825.09 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
    474.28 ± 29%     +51.7%     719.30 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm


***************************************************************************************************
lkp-gnr-2sp3: 256 threads 2 sockets Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz (Granite Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-gnr-2sp3/resched/stress-ng/60s

commit: 
  9cdb4fe20c ("sched/fair: Use protect_slice() instead of direct comparison")
  74eec63661 ("sched/fair: Fix NO_RUN_TO_PARITY case")

9cdb4fe20cd239c8 74eec63661d46a7153d04c2e024 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    131205            -1.6%     129093        proc-vmstat.nr_kernel_stack
  50210575           -27.4%   36454935        vmstat.system.cs
  29099100 ±  5%      -9.9%   26208327 ±  6%  numa-numastat.node1.local_node
  29243898 ±  4%     -10.0%   26315882 ±  6%  numa-numastat.node1.numa_hit
  29247768 ±  4%     -10.0%   26327272 ±  6%  numa-vmstat.node1.numa_hit
  29102971 ±  5%      -9.9%   26219716 ±  6%  numa-vmstat.node1.numa_local
   6184886           -27.4%    4488999        sched_debug.cpu.nr_switches.avg
   8275465           -31.6%    5661166 ±  3%  sched_debug.cpu.nr_switches.max
    847803 ±  5%     -48.2%     439340 ± 11%  sched_debug.cpu.nr_switches.stddev
 5.035e+09           +19.3%  6.007e+09        stress-ng.resched.ops
  84238772           +19.4%  1.005e+08        stress-ng.resched.ops_per_sec
  3.21e+09           -27.4%  2.329e+09        stress-ng.time.involuntary_context_switches
   2954260 ±  2%      -6.3%    2769524 ±  2%  stress-ng.time.voluntary_context_switches
      0.71 ±  2%     -14.4%       0.61 ±  5%  perf-stat.i.MPKI
 1.415e+11            +7.3%  1.518e+11        perf-stat.i.branch-instructions
      0.74            -0.2        0.57        perf-stat.i.branch-miss-rate%
 1.012e+09           -17.9%  8.305e+08        perf-stat.i.branch-misses
 4.705e+08 ±  2%      -8.9%  4.286e+08 ±  3%  perf-stat.i.cache-misses
  1.76e+09            -8.3%  1.614e+09 ±  3%  perf-stat.i.cache-references
  52473492           -27.3%   38171422        perf-stat.i.context-switches
      1.31            -6.7%       1.22        perf-stat.i.cpi
      1882 ±  2%     +11.0%       2089 ±  4%  perf-stat.i.cycles-between-cache-misses
 6.913e+11            +7.1%  7.405e+11        perf-stat.i.instructions
      0.77            +7.2%       0.83        perf-stat.i.ipc
    213.07           -26.4%     156.91        perf-stat.i.metric.K/sec
      0.68 ±  2%     -14.9%       0.58 ±  4%  perf-stat.overall.MPKI
      0.72            -0.2        0.55        perf-stat.overall.branch-miss-rate%
      1.30            -6.7%       1.21        perf-stat.overall.cpi
      1902 ±  2%      +9.8%       2088 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.77            +7.1%       0.83        perf-stat.overall.ipc
 1.362e+11            +7.3%  1.461e+11        perf-stat.ps.branch-instructions
  9.79e+08           -18.0%  8.027e+08        perf-stat.ps.branch-misses
 4.539e+08 ±  2%      -8.8%  4.138e+08 ±  3%  perf-stat.ps.cache-misses
 1.697e+09            -8.2%  1.557e+09 ±  3%  perf-stat.ps.cache-references
  50843231           -27.4%   36916488        perf-stat.ps.context-switches
 6.652e+11            +7.1%  7.127e+11        perf-stat.ps.instructions
 4.015e+13            +7.2%  4.306e+13        perf-stat.total.instructions
     52.63 ± 66%     -78.5%      11.34 ± 90%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
    190.78 ±212%     -99.5%       0.94 ±202%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.dup_fd.copy_process.kernel_clone
      0.08 ±198%   +1855.5%       1.62 ±108%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
     33.01 ± 20%     +43.3%      47.29 ± 13%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
    545.27 ±203%     -99.2%       4.17 ±205%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.dup_fd.copy_process.kernel_clone
      0.14 ±194%   +2255.1%       3.25 ±118%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
    494.31 ±108%     -88.5%      56.88 ±220%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.dup_mm
  12146131 ±  3%     -20.4%    9672813 ±  7%  perf-sched.total_wait_and_delay.count.ms
     80.75 ± 18%     +32.1%     106.67 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
    797.53 ±  7%      -7.9%     734.89 ±  6%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1718 ± 10%     -30.7%       1190 ± 22%  perf-sched.wait_and_delay.count.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
    379.17 ± 12%     -30.5%     263.33 ± 17%  perf-sched.wait_and_delay.count.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
    225.33 ± 10%     -34.2%     148.33 ± 19%  perf-sched.wait_and_delay.count.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
    128.00 ± 18%     -38.0%      79.33 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      1062 ± 12%     -33.6%     705.33 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_mmap.dup_mm.constprop
    905.83 ± 11%     -32.5%     611.17 ± 22%  perf-sched.wait_and_delay.count.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
    351.17 ± 11%     -31.6%     240.17 ± 31%  perf-sched.wait_and_delay.count.__cond_resched.down_write.unlink_file_vma_batch_process.unlink_file_vma_batch_add.free_pgtables
    265.67 ±  6%     -28.5%     190.00 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      2104 ± 14%     -28.9%       1495 ± 19%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
    491.17 ± 14%     -32.1%     333.67 ± 21%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
     81.50 ± 24%     -35.6%      52.50 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
     58.83 ± 14%     -53.5%      27.33 ± 17%  perf-sched.wait_and_delay.count.__cond_resched.pidfs_exit.release_task.wait_task_zombie.__do_wait
     53.83 ± 17%     -37.2%      33.83 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
    191.17 ± 11%     -32.1%     129.83 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.task_work_run.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
   2224411 ± 15%     -44.4%    1236485 ± 24%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     44.33 ± 22%     -50.4%      22.00 ± 36%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    545.17 ± 10%     -39.4%     330.33 ± 34%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
    984.33 ±  8%     -35.6%     633.50 ± 22%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      1161 ± 10%     -36.6%     736.17 ± 22%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      1055 ± 11%     -41.1%     621.67 ± 27%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      5864 ±  7%     -16.0%       4928 ± 10%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2189 ± 54%     -72.0%     612.59 ± 82%  perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
      4238 ±  9%     +21.4%       5146 ± 12%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.05 ±186%   +3266.3%       1.75 ± 95%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
     47.74 ± 16%     +24.4%      59.38 ±  6%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
    797.52 ±  7%      -7.9%     734.88 ±  6%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.12 ±191%   +2992.1%       3.77 ± 94%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
      1759 ± 18%     -35.5%       1134 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mm.constprop.0
    374.27 ± 19%     +60.8%     601.70 ± 19%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
    766.95 ±120%     -99.7%       1.99 ± 46%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     12.74            -2.4       10.38 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.95            -2.3       10.60 ±  2%  perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     22.85            -2.2       20.61        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     23.01            -2.2       20.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
     27.10            -1.8       25.27        perf-profile.calltrace.cycles-pp.__sched_yield
     18.99            -1.6       17.36        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      6.14            -1.4        4.78 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.__x64_sys_sched_yield
      6.40            -1.4        5.04        perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      3.66 ±  8%      -0.6        3.08 ±  9%  perf-profile.calltrace.cycles-pp.pick_task_fair.pick_next_task_fair.__pick_next_task.__schedule.schedule
      0.78 ±  3%      -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.__enqueue_entity.put_prev_entity.pick_next_task_fair.__pick_next_task.__schedule
      1.25            -0.5        0.74        perf-profile.calltrace.cycles-pp.pick_eevdf.pick_task_fair.pick_next_task_fair.__pick_next_task.__schedule
      1.72 ± 10%      -0.5        1.24 ±  4%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__pick_next_task.__schedule.schedule
      1.86            -0.5        1.38 ±  5%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      2.00            -0.5        1.53 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.48            -0.5        1.02 ±  4%  perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__pick_next_task.__schedule.schedule
      1.27            -0.3        0.97 ±  3%  perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.64 ±  2%      -0.3        0.35 ± 70%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      1.09 ±  3%      -0.3        0.81 ±  3%  perf-profile.calltrace.cycles-pp.__dequeue_entity.set_next_entity.pick_next_task_fair.__pick_next_task.__schedule
      1.00            -0.3        0.74 ±  3%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      1.02 ±  2%      -0.2        0.78 ±  6%  perf-profile.calltrace.cycles-pp.switch_fpu_return.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.84            -0.2        0.64 ±  3%  perf-profile.calltrace.cycles-pp.rseq_ip_fixup.__rseq_handle_notify_resume.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.82 ±  2%      -0.2        0.63 ±  6%  perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.63 ±  3%      -0.1        0.58 ±  5%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.85            +0.0        0.90 ±  4%  perf-profile.calltrace.cycles-pp.__radix_tree_lookup.find_task_by_vpid.find_get_task.do_sched_setscheduler.__x64_sys_sched_setscheduler
      0.52            +0.1        0.58        perf-profile.calltrace.cycles-pp.raw_spin_rq_lock_nested.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.89            +0.1        0.95        perf-profile.calltrace.cycles-pp.__dequeue_entity.set_next_entity.set_next_task_fair.__sched_setscheduler._sched_setscheduler
      0.65 ±  2%      +0.1        0.72 ±  2%  perf-profile.calltrace.cycles-pp.set_load_weight.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      0.71 ±  3%      +0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.task_rq_lock.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      0.52 ±  2%      +0.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.rt_mutex_adjust_pi.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      0.67 ±  2%      +0.1        0.74 ±  2%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entities.dequeue_task_fair.__sched_setscheduler._sched_setscheduler
      0.58 ±  3%      +0.1        0.67 ±  2%  perf-profile.calltrace.cycles-pp.idr_find.find_task_by_vpid.__x64_sys_sched_getscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.94            +0.1        2.04 ±  2%  perf-profile.calltrace.cycles-pp.find_task_by_vpid.find_get_task.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64
      0.65 ±  2%      +0.1        0.75        perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_entities.dequeue_task_fair.__sched_setscheduler
      0.71 ±  2%      +0.1        0.82        perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_entities.dequeue_task_fair.__sched_setscheduler._sched_setscheduler
      1.15            +0.1        1.26        perf-profile.calltrace.cycles-pp.find_task_by_vpid.__x64_sys_sched_getscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_getscheduler
      1.30            +0.1        1.43        perf-profile.calltrace.cycles-pp.__x64_sys_sched_getscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_getscheduler
      3.29 ±  2%      +0.1        3.42        perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_entities.dequeue_task_fair.__sched_setscheduler
      0.79            +0.1        0.92 ±  2%  perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.set_next_task_fair.__sched_setscheduler._sched_setscheduler
      0.44 ± 44%      +0.1        0.58        perf-profile.calltrace.cycles-pp.update_load_avg.put_prev_entity.put_prev_task_fair.__sched_setscheduler._sched_setscheduler
      2.32            +0.1        2.46 ±  2%  perf-profile.calltrace.cycles-pp.find_get_task.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.17 ±  2%      +0.2        1.33        perf-profile.calltrace.cycles-pp.put_prev_entity.put_prev_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      1.26            +0.2        1.43        perf-profile.calltrace.cycles-pp.put_prev_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      1.02            +0.2        1.20        perf-profile.calltrace.cycles-pp.reweight_entity.enqueue_task_fair.enqueue_task.__sched_setscheduler._sched_setscheduler
      1.92            +0.2        2.16        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_getscheduler
      0.34 ± 70%      +0.2        0.58        perf-profile.calltrace.cycles-pp.update_rq_clock.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      2.03            +0.3        2.29        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_getscheduler
      2.85            +0.3        3.11        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.enqueue_task.__sched_setscheduler._sched_setscheduler
      1.62            +0.3        1.91        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__sched_getscheduler
      1.94            +0.3        2.24        perf-profile.calltrace.cycles-pp.set_next_entity.set_next_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      4.79            +0.3        5.09        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.__sched_setscheduler._sched_setscheduler
      2.16            +0.3        2.51        perf-profile.calltrace.cycles-pp.set_next_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      1.92            +0.4        2.27 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__sched_setscheduler
      1.22 ±  4%      +0.4        1.58 ±  4%  perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_task_fair.enqueue_task.__sched_setscheduler._sched_setscheduler
      2.17            +0.4        2.56 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__sched_yield
      3.62            +0.4        4.04        perf-profile.calltrace.cycles-pp.update_curr.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      0.08 ±223%      +0.5        0.54        perf-profile.calltrace.cycles-pp.reweight_task_fair.set_load_weight.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_task_fair.enqueue_task.__sched_setscheduler._sched_setscheduler
      3.69            +0.5        4.20        perf-profile.calltrace.cycles-pp.__sched_getscheduler
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      4.86            +0.6        5.46        perf-profile.calltrace.cycles-pp.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.92            +0.7        6.62        perf-profile.calltrace.cycles-pp.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      6.40            +1.0        7.41        perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      6.53            +1.0        7.57        perf-profile.calltrace.cycles-pp.enqueue_task.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      3.01 ±  4%      +1.1        4.13 ±  6%  perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_entities.dequeue_task_fair.__sched_setscheduler._sched_setscheduler
      9.99            +1.7       11.70 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
     10.39            +1.7       12.12 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
     35.20 ±  2%      +2.8       38.03 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     35.36 ±  2%      +2.9       38.22 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     38.05 ±  2%      +3.3       41.38        perf-profile.calltrace.cycles-pp.__sched_setscheduler
     24.99            +3.8       28.83        perf-profile.calltrace.cycles-pp.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64
     25.54            +3.9       29.49        perf-profile.calltrace.cycles-pp._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe
     29.68            +4.1       33.83        perf-profile.calltrace.cycles-pp.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     29.73            +4.2       33.89        perf-profile.calltrace.cycles-pp.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     16.69 ±  4%      -3.5       13.19 ±  3%  perf-profile.children.cycles-pp.__schedule
     16.74 ±  4%      -3.5       13.26 ±  3%  perf-profile.children.cycles-pp.schedule
     28.34            -2.2       26.14        perf-profile.children.cycles-pp.__sched_yield
      8.29 ±  5%      -1.9        6.39 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      8.55 ±  5%      -1.9        6.66 ±  4%  perf-profile.children.cycles-pp.__pick_next_task
      6.53 ± 14%      -1.8        4.72 ± 15%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
     19.06            -1.6       17.43        perf-profile.children.cycles-pp.__x64_sys_sched_yield
      2.33 ±  3%      -0.7        1.64 ±  2%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.56 ±  4%      -0.6        0.94 ±  3%  perf-profile.children.cycles-pp.pick_eevdf
      3.78 ±  8%      -0.6        3.20 ±  9%  perf-profile.children.cycles-pp.pick_task_fair
      1.62 ±  3%      -0.5        1.17        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      3.09            -0.4        2.65        perf-profile.children.cycles-pp.put_prev_entity
      1.29 ±  5%      -0.4        0.91        perf-profile.children.cycles-pp.prepare_task_switch
      1.29 ±  2%      -0.4        0.93 ±  3%  perf-profile.children.cycles-pp.switch_fpu_return
      2.48 ±  2%      -0.3        2.15        perf-profile.children.cycles-pp.__dequeue_entity
      1.10 ±  3%      -0.3        0.79        perf-profile.children.cycles-pp.rseq_ip_fixup
      1.03 ±  2%      -0.3        0.74 ±  3%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      4.12            -0.3        3.84        perf-profile.children.cycles-pp.set_next_entity
      0.52 ±  4%      -0.3        0.26 ±  4%  perf-profile.children.cycles-pp.vruntime_eligible
      0.84 ±  3%      -0.2        0.59 ±  3%  perf-profile.children.cycles-pp.__switch_to
      2.53 ±  2%      -0.2        2.30        perf-profile.children.cycles-pp.__enqueue_entity
      0.82 ±  2%      -0.2        0.60 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
      0.72            -0.2        0.52 ±  4%  perf-profile.children.cycles-pp.os_xsave
      0.67 ±  3%      -0.2        0.48        perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.61 ±  3%      -0.2        0.44 ±  2%  perf-profile.children.cycles-pp.__get_user_8
      0.49 ±  3%      -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.31 ±  3%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__put_user_8
      0.29 ±  3%      -0.1        0.21        perf-profile.children.cycles-pp.___perf_sw_event
      0.28 ±  2%      -0.1        0.20 ±  5%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.42            -0.1        0.36 ± 14%  perf-profile.children.cycles-pp.vma_interval_tree_insert_after
      0.18 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.17 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.36            -0.0        0.32 ±  3%  perf-profile.children.cycles-pp.__rb_erase_color
      0.16 ±  5%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.mm_cid_get
      0.32 ±  3%      -0.0        0.28 ±  5%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.24 ±  4%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.kernel_wait4
      0.12 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.choose_new_asid
      0.26 ±  4%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.wait4
      0.19 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__do_wait
      0.24 ±  4%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.do_wait
      0.08 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__set_next_task_fair
      0.20 ±  5%      -0.0        0.18 ±  9%  perf-profile.children.cycles-pp.___slab_alloc
      0.09 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.do_perf_trace_sched_switch
      0.08 ±  6%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.mem_cgroup_handle_over_high
      0.09            -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.10 ±  3%      -0.0        0.08        perf-profile.children.cycles-pp.min_vruntime_cb_rotate
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.security_capable
      0.08            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.dequeue_task
      0.08 ±  4%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.capable
      0.09 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.14 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.pick_next_task
      0.13 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.security_task_setscheduler
      0.07 ± 10%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.check_class_changing
      0.12 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.dl_server_update
      0.18 ±  2%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.raw_spin_rq_unlock
      0.29 ±  2%      +0.0        0.31        perf-profile.children.cycles-pp.propagate_entity_load_avg
      0.14 ±  2%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.17 ±  2%      +0.0        0.20        perf-profile.children.cycles-pp.arch_scale_cpu_capacity
      0.32 ±  2%      +0.0        0.36 ±  2%  perf-profile.children.cycles-pp.dl_scaled_delta_exec
      0.52            +0.0        0.56        perf-profile.children.cycles-pp.reweight_task_fair
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__setscheduler_class
      1.80            +0.1        1.86        perf-profile.children.cycles-pp.__update_load_avg_se
      0.52 ±  5%      +0.1        0.58 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.65 ±  2%      +0.1        0.72 ±  2%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.75 ±  2%      +0.1        0.81 ±  2%  perf-profile.children.cycles-pp.task_rq_lock
      0.76 ±  3%      +0.1        0.82 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.43            +0.1        0.50        perf-profile.children.cycles-pp.avg_vruntime
      0.52 ±  2%      +0.1        0.58 ±  2%  perf-profile.children.cycles-pp.strnlen
      0.53            +0.1        0.60 ±  2%  perf-profile.children.cycles-pp.rt_mutex_adjust_pi
      0.68 ±  2%      +0.1        0.74 ±  2%  perf-profile.children.cycles-pp.set_load_weight
      0.48            +0.1        0.55        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.35            +0.1        1.42 ±  3%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.56 ±  4%      +0.1        0.64 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.66 ±  3%      +0.1        0.75 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      1.46            +0.1        1.55 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.65 ±  2%      +0.1        0.74 ±  2%  perf-profile.children.cycles-pp.update_entity_lag
      1.45 ±  2%      +0.1        1.55        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.96 ±  2%      +0.1        1.06 ±  2%  perf-profile.children.cycles-pp.do_perf_trace_sched_stat_runtime
      1.10 ±  4%      +0.1        1.22 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.75 ±  2%      +0.1        0.88 ±  2%  perf-profile.children.cycles-pp.place_entity
      1.36 ±  3%      +0.1        1.49 ±  3%  perf-profile.children.cycles-pp.idr_find
      1.34            +0.1        1.48        perf-profile.children.cycles-pp.__x64_sys_sched_getscheduler
      1.50            +0.1        1.64 ±  2%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      2.36            +0.1        2.51 ±  2%  perf-profile.children.cycles-pp.find_get_task
      1.12 ±  2%      +0.2        1.29        perf-profile.children.cycles-pp.__calc_delta
      1.30            +0.2        1.48        perf-profile.children.cycles-pp.put_prev_task_fair
      3.13            +0.2        3.35 ±  2%  perf-profile.children.cycles-pp.find_task_by_vpid
      5.22            +0.2        5.43        perf-profile.children.cycles-pp.update_load_avg
      1.28            +0.2        1.52        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.99            +0.3        3.25        perf-profile.children.cycles-pp.enqueue_entity
      4.89            +0.3        5.20        perf-profile.children.cycles-pp.dequeue_entity
      2.22            +0.4        2.57        perf-profile.children.cycles-pp.set_next_task_fair
      2.19            +0.4        2.57        perf-profile.children.cycles-pp.reweight_entity
      4.98            +0.6        5.59        perf-profile.children.cycles-pp.yield_task_fair
      3.39            +0.6        4.00 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      4.46            +0.7        5.12        perf-profile.children.cycles-pp.__sched_getscheduler
      5.99            +0.7        6.71        perf-profile.children.cycles-pp.do_sched_yield
      6.50            +1.0        7.52        perf-profile.children.cycles-pp.enqueue_task_fair
      6.62            +1.0        7.66        perf-profile.children.cycles-pp.enqueue_task
      4.71 ±  4%      +1.5        6.21 ±  6%  perf-profile.children.cycles-pp.update_cfs_group
     10.11            +1.7       11.83 ±  2%  perf-profile.children.cycles-pp.dequeue_entities
     10.49            +1.7       12.22 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
     25.60            +4.0       29.58        perf-profile.children.cycles-pp._sched_setscheduler
     29.76            +4.2       33.94        perf-profile.children.cycles-pp.do_sched_setscheduler
     29.80            +4.2       34.00        perf-profile.children.cycles-pp.__x64_sys_sched_setscheduler
     64.39            +7.1       71.45        perf-profile.children.cycles-pp.__sched_setscheduler
      2.17 ±  3%      -0.6        1.52 ±  3%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.10 ±  4%      -0.4        0.67 ±  3%  perf-profile.self.cycles-pp.pick_eevdf
      1.00 ±  6%      -0.3        0.71 ±  2%  perf-profile.self.cycles-pp.prepare_task_switch
      2.07 ±  2%      -0.3        1.79        perf-profile.self.cycles-pp.__dequeue_entity
      1.00 ±  2%      -0.3        0.73 ±  4%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      2.17 ±  3%      -0.3        1.91 ±  2%  perf-profile.self.cycles-pp.__schedule
      2.42 ±  3%      -0.2        2.18        perf-profile.self.cycles-pp.__enqueue_entity
      0.78 ±  2%      -0.2        0.55 ±  4%  perf-profile.self.cycles-pp.__switch_to
      0.44 ±  4%      -0.2        0.23 ±  3%  perf-profile.self.cycles-pp.vruntime_eligible
      0.70            -0.2        0.51 ±  4%  perf-profile.self.cycles-pp.os_xsave
      0.58 ±  3%      -0.2        0.42 ±  3%  perf-profile.self.cycles-pp.__get_user_8
      0.53 ±  4%      -0.2        0.38        perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.47 ±  3%      -0.1        0.34 ±  3%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.53 ±  4%      -0.1        0.44 ±  2%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.27 ±  3%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__put_user_8
      0.27 ±  2%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.25            -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.switch_fpu_return
      0.22 ±  2%      -0.1        0.16 ±  2%  perf-profile.self.cycles-pp.finish_task_switch
      0.16            -0.1        0.11 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.18 ±  2%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.16 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.31            -0.0        0.27 ±  3%  perf-profile.self.cycles-pp.__rb_erase_color
      0.32 ±  3%      -0.0        0.28 ±  5%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.12 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.rseq_ip_fixup
      0.13            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mm_cid_get
      0.16 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.reweight_task_fair
      0.46 ±  2%      -0.0        0.42 ±  2%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.07 ±  5%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__set_next_task_fair
      0.10 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.choose_new_asid
      0.07 ±  7%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.mem_cgroup_handle_over_high
      0.08 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.do_perf_trace_sched_switch
      0.16 ±  6%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.sched_getscheduler@plt
      0.07            -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.min_vruntime_cb_rotate
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.security_task_setscheduler
      0.06            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.dequeue_task
      0.09 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.dl_server_update
      0.07            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.put_prev_task_fair
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__x64_sys_sched_getscheduler
      0.05 ±  7%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__x64_sys_sched_setscheduler
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.13 ±  2%      +0.0        0.15        perf-profile.self.cycles-pp.raw_spin_rq_unlock
      0.08 ±  4%      +0.0        0.10        perf-profile.self.cycles-pp.enqueue_task
      0.20 ±  2%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.propagate_entity_load_avg
      0.12 ±  4%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.arch_scale_cpu_capacity
      0.28            +0.0        0.30 ±  4%  perf-profile.self.cycles-pp.yield_task_fair
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.15 ±  3%      +0.0        0.18 ±  5%  perf-profile.self.cycles-pp.set_load_weight
      0.23 ±  2%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.dl_scaled_delta_exec
      0.20 ±  3%      +0.0        0.23 ±  4%  perf-profile.self.cycles-pp.update_entity_lag
      0.19 ±  3%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.raw_spin_rq_lock_nested
      0.26 ±  3%      +0.0        0.30        perf-profile.self.cycles-pp.do_sched_yield
      0.47 ±  2%      +0.0        0.50 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.44 ±  2%      +0.0        0.47        perf-profile.self.cycles-pp.do_perf_trace_sched_stat_runtime
      0.44            +0.0        0.47 ±  3%  perf-profile.self.cycles-pp.css_rstat_updated
      0.20 ±  3%      +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.set_next_task_fair
      0.46 ±  2%      +0.0        0.50        perf-profile.self.cycles-pp.dequeue_entity
      0.30            +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      1.85            +0.0        1.90        perf-profile.self.cycles-pp.update_load_avg
      0.65 ±  3%      +0.0        0.69        perf-profile.self.cycles-pp.update_rq_clock_task
      0.38            +0.0        0.43 ±  2%  perf-profile.self.cycles-pp.find_get_task
      0.31 ±  2%      +0.0        0.36 ±  2%  perf-profile.self.cycles-pp.place_entity
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.security_task_getscheduler
      0.25            +0.1        0.30        perf-profile.self.cycles-pp.x64_sys_call
      0.33 ±  2%      +0.1        0.38        perf-profile.self.cycles-pp.do_sched_setscheduler
      0.50 ±  5%      +0.1        0.55 ±  3%  perf-profile.self.cycles-pp.native_sched_clock
      1.59            +0.1        1.64        perf-profile.self.cycles-pp.__update_load_avg_se
      0.39            +0.1        0.45        perf-profile.self.cycles-pp.avg_vruntime
      0.33            +0.1        0.39 ±  2%  perf-profile.self.cycles-pp._sched_setscheduler
      0.38            +0.1        0.45 ±  2%  perf-profile.self.cycles-pp.enqueue_entity
      0.48 ±  2%      +0.1        0.55 ±  2%  perf-profile.self.cycles-pp.strnlen
      0.43 ±  3%      +0.1        0.50 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.29            +0.1        1.36 ±  3%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.72            +0.1        0.82 ±  2%  perf-profile.self.cycles-pp.dequeue_entities
      1.27            +0.1        1.37        perf-profile.self.cycles-pp._raw_spin_lock
      0.38            +0.1        0.48        perf-profile.self.cycles-pp.set_next_entity
      1.32            +0.1        1.42 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.63            +0.1        0.74 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.65            +0.1        0.75 ±  3%  perf-profile.self.cycles-pp.enqueue_task_fair
      1.39            +0.1        1.51 ±  2%  perf-profile.self.cycles-pp.__sched_yield
      1.30 ±  4%      +0.1        1.43 ±  2%  perf-profile.self.cycles-pp.idr_find
      0.80            +0.2        0.96 ±  2%  perf-profile.self.cycles-pp.__sched_getscheduler
      0.88 ±  4%      +0.2        1.04        perf-profile.self.cycles-pp.reweight_entity
      0.92 ±  2%      +0.2        1.09        perf-profile.self.cycles-pp.__calc_delta
      1.25            +0.2        1.48        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.80            +0.3        2.06        perf-profile.self.cycles-pp.do_syscall_64
      2.29            +0.3        2.57        perf-profile.self.cycles-pp.__sched_setscheduler
      4.92            +0.3        5.24        perf-profile.self.cycles-pp.update_curr
      4.66 ±  4%      +1.5        6.16 ±  6%  perf-profile.self.cycles-pp.update_cfs_group





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


