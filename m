Return-Path: <linux-kernel+bounces-731301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8ADB0526B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7837AB94D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6DEACD;
	Tue, 15 Jul 2025 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GilHhqwr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13210EC2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563348; cv=fail; b=XuOgOzo0sLhbdU/TOizvgVh9BPGTKXJsaslPwJxl5AipN39Wg3JhXRSMuSbsXhBfsLava2/4UfdWCXqv/DlD9Kl3Es1+QEqtvhXt2paJDlujxBdIjYZq0J5D/iJ0KVifcZsC7K8SiW+Sbmof5eCztnHLR36mtxZgfRxhUwGnrJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563348; c=relaxed/simple;
	bh=/1V0zXKQmUkpw/K7GYhanByJJx0AsYETkAZOmyXocNo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s3Pnov6+CD+y24XF1v7jqFisi0Pa2+LaDBJd7QRNuZifnyinY/537H5Ck2EIl6X4RSs+fPSYsGM4O9zvwQAvd4D4+ryrM9rDko3ZpmzexXslmWYd9rb3VvDzOyeaVCZTVMxGHp5yJPip6t36o4uYRUAPHRtnatpALKOXiSH74Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GilHhqwr; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752563344; x=1784099344;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/1V0zXKQmUkpw/K7GYhanByJJx0AsYETkAZOmyXocNo=;
  b=GilHhqwr+GXgUrtRW7cBtU1tU2WB8Z8E9lGxV5SEEXnGXcABN+PkANj0
   /qS1b1wZX3yhUz7WeOHUEiAXogOU+eQVR2yTuC8bCRwlCYejIk9z/KITT
   +hX4NJCjHQjx+fYelu94h3+YrtpN0Tpia+V6H8bZMMgPDD8kc/QJUzt7j
   FXq6LSVZgsboa+zyU9TV+ZcF9HB8iCdN6k0eZhfAO8xCI+ODTfKPX88Pb
   8lejLl1YM5D4IxLdQJiwYf5hB5iurQChS3sl6PlCPkStIVP1Ufo0Xm+cc
   LjmFILQMeWqfVDIz/3r91lsgtryWXbWVQnkGHRsdd/awuizwYiAR+mgxf
   g==;
X-CSE-ConnectionGUID: H5BPbwOURJe0k1qVC/wVhw==
X-CSE-MsgGUID: j4no1EXHRhqhzqqdVAX7Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54916471"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54916471"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:09:04 -0700
X-CSE-ConnectionGUID: s3xh9E9hSMCJWn1XLxer+Q==
X-CSE-MsgGUID: cdomam5eRU6zC7bPqo21XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157240187"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:09:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 00:09:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 00:09:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.88) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 00:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqDa8pkJYkk6vc0y0Mlcg5yXZaHIM86QN+r0QEN7rx70yh9xFTX7IjnvOam1TJPGH/gSfci8UVTvqe14HEV9RgiF4ZIiiZFCSoQipzUNILKgDifA6Mmz8i8MunsIsSteLUhLPfplxflvfGjMu0FGLS3ZQmVwgapuiHv2lj7XLzAl+dox1i/o2a5D3PALmmH8x3KldffotwpFxtwHPMUEl2b6EXqmLKhNNsprzmTDqIznLQgtqPgFep0bRuFf7Cmt1KWclkzRo9sNJpcLSU8pMnO3o0stBKzKessKu0h167eu7CE+07GdygvsE+Xm24eBabXfTydETEnMC4iN43nDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd9hFSgUS0ifEJI5c5lkJjPqsGNWYZsHyZ7LVS91V0o=;
 b=yMUDONohtxjlE8zIrS9SCD3Zmym888IzYIAW65ieGtYB0QC/0Rh17NbmsZhs7UzNNzVqtmrME3+0xVHdlT6obWeVaNSf13yr0+085GM9yEqMfNH5PNQlN7g781ywn8Ongtojd7O3OhQR1q2k++By71cKvJrnPTpO9F8I3KFW1RDyEIxiuF8jw5W3GUuICaET0MBlqeQCjsNbW5w9Z4fJFSLIFDHO99GDznwjFecAKYxZBsGpfAdVKOPQYNfKaprG10iGbyv6Cb8qbVQwY5hcWeBBk1ff86YaPDSXvY07uKw8OGQb3Iwb2aPqOo71AJe9+kbugI1KxVyM+7d1lZ/PKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 07:08:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 07:08:30 +0000
Date: Tue, 15 Jul 2025 15:08:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chris Mason <clm@fb.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <peterz@infradead.org>,
	<vincent.guittot@linaro.org>, Chris Mason <clm@fb.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle
 balance fails
Message-ID: <202507150846.538fc133-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626144017.1510594-2-clm@fb.com>
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cd09aa-b093-44d8-d311-08ddc36e6704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4GuUHIayGorH5WnS4VbOelx5sE0oEy8kW2qcddslGiZa2oCQ4CH0lYU3RZ?=
 =?iso-8859-1?Q?ewrKYTtm3BEtGstVhJOPG8I73IV3XOHpQNk/i3QC7m5NE9VVAQNgealjhr?=
 =?iso-8859-1?Q?fvakEeysAQTj5sY6VTuLtWyN0WwgHstfYzmJJgD+h/pxKpdJg+HDjlaR9h?=
 =?iso-8859-1?Q?uHHtzHSXVR1HSfkleMILqlGV+uLczD7xTf8Sy+WMkNvAfzA48Blyg4y2Tc?=
 =?iso-8859-1?Q?I5aGx+8cGR+alQjP/UPJhRkT+55eLKpbo5WyIxemiP3sxV0ogps7hZHsbg?=
 =?iso-8859-1?Q?zwK539DPgTiiyLGJk0JC7sTrWX7MO5drBJFOdQVzLGJ5GuDgdsQgMtVBI0?=
 =?iso-8859-1?Q?nDurIJAFYe+LrJZQkbAipPaj4UnedJCjhSoOp9RSyYjKNjq99ZbugH2lcv?=
 =?iso-8859-1?Q?9r/OIckX59jC/X2AjvABM5L8QVo93CJArZ5DB94CUw4y20xBo/4hzv56Ki?=
 =?iso-8859-1?Q?4J4y7z8viONMx8p9Arc/YeLIP90MLI2its3zG6sAhaakmisyGwn4DrN+W5?=
 =?iso-8859-1?Q?gZWE6ACv0amdKwrLjYf/0qqTovQJGfn/QG4xBAR3I6Ve7cdHCFWC2eauna?=
 =?iso-8859-1?Q?fk6egEA6LIfGnUqzp+LAzDCt8zjEVZsp+P1uQ3Y8UU2aiToGA3zEdBtFjQ?=
 =?iso-8859-1?Q?Yq3SMJ7MypVIWW30UvIbyyVAyrJma3lVPhBIu5feEDokxigox+oaY//LYQ?=
 =?iso-8859-1?Q?7TQCmHfqpYgzAWuLa9fWVs103zNM/+CwlioIQat2++qyX5N3AbWqcJEXfd?=
 =?iso-8859-1?Q?oTh06YafR/AUJQvhvTD8E+kcimYYWLhs/yG3BqUrHFWocGC5zGpVW/oUVR?=
 =?iso-8859-1?Q?FMJHiTXfZc5feHak2ViEJHGGgTpr/730SO7AJQ+3XQRwrnJwu88mdqRkf9?=
 =?iso-8859-1?Q?52/AsPnaSKnpYvCgjocvi7raKUeHTscDGWvwzLiObeCLSCujB8rNR36WxN?=
 =?iso-8859-1?Q?DK0tFe4INzDqvCuaZUgxmDl+bg9cWRFjdQkdpqkEoDDY5TgGeIehNEMf6L?=
 =?iso-8859-1?Q?BsVkNl/phyJO4yE0a29RJAmYXwfXl0kG0E83F49p53mv8IIbqLj5Ms5P1/?=
 =?iso-8859-1?Q?1d83B3YRy6oCJiX8sPMOsdkzrYr5q7cAArN+NBkmpmT5ZY0pXPSgrZ0K6x?=
 =?iso-8859-1?Q?b5ZZGNFKB/INSKBsVmOh/kcDVNNdrcaDx4gZJIpEF2O88mMMKeLDfoMmq+?=
 =?iso-8859-1?Q?5SVjjF7zDW7kQHGQBYNVcmhVs1KoGMJIKo4nsBePoKIdLNleIUiU0rDexM?=
 =?iso-8859-1?Q?/y+RxRgX7sUpMWKPROVV5vVmUZjia5e4X6Y4qKX0vpxf6dPg3wGIVlf4f3?=
 =?iso-8859-1?Q?9HSP02wj3bZ6yvA+mnZhYvGoe0xDbuUS2lCs9dIX3WhJiJi30+JK53Qs+u?=
 =?iso-8859-1?Q?li55go0I6sQLBtsZLm8bSQNHQQ/NA3l80i/8iyDLYmRjfGyPyrIvVQtwuL?=
 =?iso-8859-1?Q?7K+IL+FJkZ3r/A7/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WRK7dCRkcTsEMjJAInmIe8hyNYOa1S1zLQVNXGfU3rsJ7FEUutVketzCb+?=
 =?iso-8859-1?Q?g+Rv7uP+kxUfI6Fp/Uspkb08d/24dZ5BlCE8XfEYXgu4ZBMsyQt6+4ped1?=
 =?iso-8859-1?Q?nQdKon83vm8dUYmMnUgvvwBqVnoV9AldNp+AM9rwlAr+GE0CloIYak6xxz?=
 =?iso-8859-1?Q?4EYiUqJ1a6M0pY/TYcKEDWocK4cIewElfWyWLtZlg/ljuyEwwXLFbpW+KW?=
 =?iso-8859-1?Q?zlkxZZ2ljoBCYSb7d8QPX/+lsdUHdlLQOZVrxxbVGZzveuR4YkhwLbBwtz?=
 =?iso-8859-1?Q?V77PbuvhGUU1WsmP3AV9SwQmYpSnSg6TLV0xjlnQSvNhlJZ9tdmer0YaeG?=
 =?iso-8859-1?Q?8msLt6CGKCQIUcyzoxqM4KxumfdgVW1JRev6r/pJ8wWiZyO1vm3LXOaXBB?=
 =?iso-8859-1?Q?M9259e18dqfILpq5wiI4V/WuencK633ywU9QPbtEGgGV9Szeiapa+adn1b?=
 =?iso-8859-1?Q?ci5tOtg5RDrCtwPqTUHd69cohFexy/hbnEoJtSv7tHNlfwntnIdw10VJAX?=
 =?iso-8859-1?Q?RXFkoXuiLceESgMKomjRtZAo3tCyxxbvsp6OFIt2PxifcrPacEW7pxgZ6a?=
 =?iso-8859-1?Q?axdRKh1joQZ9lHy2dgwvUZhqUMHIyH/CLEvCZnxkYkTya5NyX/r7Vt54Av?=
 =?iso-8859-1?Q?sQ8Pt9aE0Iaya+kxYwqowZzqpgT2pMdksMhVtHIL51ulVNWtA0aZLZ+4V7?=
 =?iso-8859-1?Q?+6JVwq6PU0jD1ftEKvCaprUFMii/8hnlD4uopDMGkGNqWN5C1k+sQLas0V?=
 =?iso-8859-1?Q?wlGNkYoBeCp6Pxm4CktvymeP+HPZTzvWGqBFdLSjD/sGJLDddj+kPG2+j7?=
 =?iso-8859-1?Q?jL5WV2R8+W8yjjO9IT8LGBxQsJDx/56L77wA4qo9tcQZSIo4YoDVE+ik0H?=
 =?iso-8859-1?Q?I5nRXAxftFWrQIu+A7jyKUPVsrDcEygK8K2G5epjb+DP29+ZhXKsGMGBu2?=
 =?iso-8859-1?Q?GvxCMEypwnrv3Zsm6LkB4dql1ItHM0yowP2UNW06xsIP1ff4xVLtVy0aNJ?=
 =?iso-8859-1?Q?sqTPzRZFsSzEQEr6TbTzcQn2LJEsFG1mtThisZ922DJBSMfXF8g6lB5kcB?=
 =?iso-8859-1?Q?iLJxANeyqOM4BDN3bQKPzQhGYVlDUIVZllJ8UJsA4PBIn/1MU5adD+Oj6+?=
 =?iso-8859-1?Q?TvV9bkpP13a8+0P2C6PM2OJ10eV+F3523XMVLZdkfjydCc3WTe9CxcyDXd?=
 =?iso-8859-1?Q?MW3KFj49GtMcZnHfTksswHkzQGj6AMR844FhHkX5ttVgfgQ3buBRe0wfhX?=
 =?iso-8859-1?Q?yDEiqlF28LyW51EYetXRiFOsxejRFiSVI5E92lL0taVzNC5/cCbuXjOFI8?=
 =?iso-8859-1?Q?izwA8xHGQIywkxgqK1CHlTkTMkJP0IWMs/88PkE33Q8vNqAwXxDQ1vjCX1?=
 =?iso-8859-1?Q?76uAZNIG31v1xmWejBAf/zo9cM0q5Lfi+GW/gxfh6Rg+peuiEGXmSDvtJV?=
 =?iso-8859-1?Q?i8vC2sjldXir0rv9al0TlEqDPtnDzGuORC77xB76EuzR+Y6FTrB9zu2y3e?=
 =?iso-8859-1?Q?CQ7JTjSHEG46xBgndYb084fp+MJfGO5JIUkzwv+Mk1vlyfvjT/2yD5dsVR?=
 =?iso-8859-1?Q?qaLvTRM/mzPYoEhBNbXLLmuf5VWaUWikTs8Bnl5aajO780wb/MKhgjMMPZ?=
 =?iso-8859-1?Q?Jg5lIRFd/QsFnPol/qCrtQWK24/uUILVnHKb5I4NxyFsoVJhRp5LULNw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cd09aa-b093-44d8-d311-08ddc36e6704
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 07:08:30.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2vE4MxkoNeRSd7hwohdclR5lowpDu6QsY0TA/fM4iJXEisziEzgwmFE0BB9Dt+q6PRKVA6m6hNBa/fh5VCJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5934
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 22.9% regression of unixbench.throughput on:


commit: ac34cb39e8aea9915ec2f4e08c979eb2ed1d7561 ("[PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails")
url: https://github.com/intel-lab-lkp/linux/commits/Chris-Mason/sched-fair-bump-sd-max_newidle_lb_cost-when-newidle-balance-fails/20250626-224805
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 5bc34be478d09c4d16009e665e020ad0fcd0deea
patch link: https://lore.kernel.org/all/20250626144017.1510594-2-clm@fb.com/
patch subject: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails

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

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput  20.3% regression                                         |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_task=100%                                                                              |
|                  | runtime=300s                                                                              |
|                  | test=shell16                                                                              |
+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput  26.2% regression                                         |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_task=100%                                                                              |
|                  | runtime=300s                                                                              |
|                  | test=shell8                                                                               |
+------------------+-------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507150846.538fc133-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250715/202507150846.538fc133-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/shell1/unixbench

commit: 
  5bc34be478 ("sched/core: Reorganize cgroup bandwidth control interface file writes")
  ac34cb39e8 ("sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails")

5bc34be478d09c4d ac34cb39e8aea9915ec2f4e08c9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     17957           +38.8%      24925        uptime.idle
 1.611e+10           +42.4%  2.294e+10        cpuidle..time
 2.162e+08           -23.9%  1.645e+08        cpuidle..usage
 5.364e+08           -22.9%  4.134e+08        numa-numastat.node0.local_node
 5.365e+08           -22.9%  4.134e+08        numa-numastat.node0.numa_hit
 5.321e+08           -22.5%  4.123e+08        numa-numastat.node1.local_node
 5.322e+08           -22.5%  4.124e+08        numa-numastat.node1.numa_hit
     40.56           +41.4%      57.37        vmstat.cpu.id
     39.90           -18.3%      32.60 ±  2%  vmstat.procs.r
    656646           -33.9%     434227        vmstat.system.cs
    507937           -33.5%     337601        vmstat.system.in
   3297469           -12.5%    2885290        meminfo.Active
   3297469           -12.5%    2885290        meminfo.Active(anon)
   3783682           -11.1%    3363144        meminfo.Committed_AS
    126051           -11.5%     111597        meminfo.Mapped
   2552513           -16.2%    2139559        meminfo.Shmem
      4145           -23.5%       3170        perf-c2c.DRAM.local
     27214           -28.6%      19429        perf-c2c.DRAM.remote
     24159           -28.8%      17197        perf-c2c.HITM.local
     17694           -26.7%      12972        perf-c2c.HITM.remote
     41854           -27.9%      30169        perf-c2c.HITM.total
   1433827 ± 13%     -29.7%    1008553 ± 19%  numa-meminfo.node0.Active
   1433827 ± 13%     -29.7%    1008553 ± 19%  numa-meminfo.node0.Active(anon)
   1021730 ± 13%     -22.2%     794603 ± 18%  numa-meminfo.node0.Shmem
   1234989 ±124%    +101.0%    2482483 ± 61%  numa-meminfo.node0.Unevictable
    178184 ± 52%     +99.6%     355743 ± 23%  numa-meminfo.node1.AnonHugePages
     84396 ± 39%     -42.8%      48315 ± 66%  numa-meminfo.node1.Mapped
     40.37           +16.9       57.24        mpstat.cpu.all.idle%
      0.00 ±  9%      +0.0        0.01 ±  6%  mpstat.cpu.all.iowait%
      1.38            -0.5        0.88        mpstat.cpu.all.irq%
      0.63            -0.2        0.48        mpstat.cpu.all.soft%
     48.87           -13.4       35.42        mpstat.cpu.all.sys%
      8.74            -2.8        5.97        mpstat.cpu.all.usr%
     64.36           -26.3%      47.43        mpstat.max_utilization_pct
     35159           -22.9%      27105        unixbench.score
    149076           -22.9%     114925        unixbench.throughput
  11331167           -24.6%    8538458        unixbench.time.involuntary_context_switches
    490074           -27.8%     354007        unixbench.time.major_page_faults
 1.283e+09           -22.7%  9.909e+08        unixbench.time.minor_page_faults
      3528           -23.9%       2683        unixbench.time.percent_of_cpu_this_job_got
     16912           -23.8%      12883        unixbench.time.system_time
      5340           -24.3%       4044        unixbench.time.user_time
 1.994e+08           -34.0%  1.316e+08        unixbench.time.voluntary_context_switches
  94067103           -23.0%   72441376        unixbench.workload
    358475 ± 13%     -29.7%     252168 ± 19%  numa-vmstat.node0.nr_active_anon
    255426 ± 13%     -22.2%     198657 ± 18%  numa-vmstat.node0.nr_shmem
    308748 ±124%    +101.0%     620615 ± 61%  numa-vmstat.node0.nr_unevictable
    358475 ± 13%     -29.7%     252168 ± 19%  numa-vmstat.node0.nr_zone_active_anon
    308748 ±124%    +101.0%     620615 ± 61%  numa-vmstat.node0.nr_zone_unevictable
 5.364e+08           -22.9%  4.134e+08        numa-vmstat.node0.numa_hit
 5.364e+08           -22.9%  4.134e+08        numa-vmstat.node0.numa_local
     86.96 ± 52%     +99.8%     173.71 ± 23%  numa-vmstat.node1.nr_anon_transparent_hugepages
     20975 ± 39%     -44.2%      11702 ± 69%  numa-vmstat.node1.nr_mapped
 5.321e+08           -22.5%  4.124e+08        numa-vmstat.node1.numa_hit
  5.32e+08           -22.5%  4.123e+08        numa-vmstat.node1.numa_local
    824471           -12.5%     721377        proc-vmstat.nr_active_anon
   1544907            -6.7%    1441463        proc-vmstat.nr_file_pages
     31890           -12.0%      28063        proc-vmstat.nr_mapped
     15586            -6.0%      14654        proc-vmstat.nr_page_table_pages
    638158           -16.2%     534927        proc-vmstat.nr_shmem
     27700            -2.7%      26944        proc-vmstat.nr_slab_reclaimable
     46384            -1.3%      45766        proc-vmstat.nr_slab_unreclaimable
    824471           -12.5%     721377        proc-vmstat.nr_zone_active_anon
 1.069e+09           -22.7%  8.258e+08        proc-vmstat.numa_hit
 1.068e+09           -22.7%  8.257e+08        proc-vmstat.numa_local
 1.097e+09           -22.7%  8.475e+08        proc-vmstat.pgalloc_normal
 1.285e+09           -22.7%  9.935e+08        proc-vmstat.pgfault
 1.096e+09           -22.7%  8.469e+08        proc-vmstat.pgfree
  62443782           -22.9%   48142857        proc-vmstat.pgreuse
     49314           -22.7%      38119        proc-vmstat.thp_fault_alloc
  20703487           -23.0%   15951229        proc-vmstat.unevictable_pgs_culled
      3.31           -13.5%       2.87        perf-stat.i.MPKI
 1.573e+10           -26.9%  1.151e+10        perf-stat.i.branch-instructions
      1.65            -0.1        1.51        perf-stat.i.branch-miss-rate%
  2.56e+08           -33.3%  1.708e+08        perf-stat.i.branch-misses
     21.13            +1.0       22.10        perf-stat.i.cache-miss-rate%
 2.564e+08           -37.0%  1.616e+08        perf-stat.i.cache-misses
   1.2e+09           -39.8%  7.221e+08        perf-stat.i.cache-references
    659355           -33.9%     436041        perf-stat.i.context-switches
      1.88            -1.1%       1.85        perf-stat.i.cpi
 1.451e+11           -27.8%  1.048e+11        perf-stat.i.cpu-cycles
    166359           -50.8%      81842        perf-stat.i.cpu-migrations
    572.23           +14.0%     652.16        perf-stat.i.cycles-between-cache-misses
 7.632e+10           -26.9%   5.58e+10        perf-stat.i.instructions
    776.76           -27.7%     561.23        perf-stat.i.major-faults
     75.15           -25.2%      56.20        perf-stat.i.metric.K/sec
   1992430           -22.7%    1540174        perf-stat.i.minor-faults
   1993207           -22.7%    1540736        perf-stat.i.page-faults
      3.36           -13.8%       2.90        perf-stat.overall.MPKI
      1.63            -0.1        1.48        perf-stat.overall.branch-miss-rate%
     21.36            +1.0       22.38        perf-stat.overall.cache-miss-rate%
      1.90            -1.2%       1.88        perf-stat.overall.cpi
    565.86           +14.6%     648.44        perf-stat.overall.cycles-between-cache-misses
    511627            -5.0%     486061        perf-stat.overall.path-length
 1.571e+10           -26.9%  1.149e+10        perf-stat.ps.branch-instructions
 2.557e+08           -33.3%  1.705e+08        perf-stat.ps.branch-misses
  2.56e+08           -37.0%  1.613e+08        perf-stat.ps.cache-misses
 1.198e+09           -39.8%   7.21e+08        perf-stat.ps.cache-references
    658326           -33.9%     435320        perf-stat.ps.context-switches
 1.448e+11           -27.8%  1.046e+11        perf-stat.ps.cpu-cycles
    166110           -50.8%      81714        perf-stat.ps.cpu-migrations
 7.621e+10           -26.9%  5.571e+10        perf-stat.ps.instructions
    775.68           -27.8%     560.36        perf-stat.ps.major-faults
   1989394           -22.7%    1537634        perf-stat.ps.minor-faults
   1990170           -22.7%    1538194        perf-stat.ps.page-faults
 4.813e+13           -26.8%  3.521e+13        perf-stat.total.instructions
  12366538           -24.1%    9391151        sched_debug.cfs_rq:/.avg_vruntime.avg
  13881097           -25.9%   10292721 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.max
  12094177           -24.3%    9151437        sched_debug.cfs_rq:/.avg_vruntime.min
      0.61 ±  4%     -19.8%       0.49 ±  6%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.59 ±  3%     +11.0%       0.66 ±  4%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.60 ±  4%     -20.7%       0.47 ±  5%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.57 ±  3%      +9.8%       0.63 ±  4%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
    285550 ± 26%     -49.0%     145513 ± 43%  sched_debug.cfs_rq:/.left_deadline.avg
   9795386 ± 16%     -40.2%    5855585 ± 35%  sched_debug.cfs_rq:/.left_deadline.max
   1571799 ± 18%     -43.3%     890472 ± 38%  sched_debug.cfs_rq:/.left_deadline.stddev
    285548 ± 26%     -49.0%     145511 ± 43%  sched_debug.cfs_rq:/.left_vruntime.avg
   9795302 ± 16%     -40.2%    5855509 ± 35%  sched_debug.cfs_rq:/.left_vruntime.max
   1571785 ± 18%     -43.3%     890461 ± 38%  sched_debug.cfs_rq:/.left_vruntime.stddev
     13.95 ±  3%     -26.3%      10.29 ±  3%  sched_debug.cfs_rq:/.load_avg.min
  12366538           -24.1%    9391151        sched_debug.cfs_rq:/.min_vruntime.avg
  13881097           -25.9%   10292721 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
  12094177           -24.3%    9151438        sched_debug.cfs_rq:/.min_vruntime.min
      0.56 ±  3%     -26.4%       0.41 ±  4%  sched_debug.cfs_rq:/.nr_queued.avg
     33.15 ± 15%     +46.7%      48.63 ± 24%  sched_debug.cfs_rq:/.removed.load_avg.avg
    149.93 ±  9%     +24.8%     187.17 ± 14%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    285548 ± 26%     -49.0%     145511 ± 43%  sched_debug.cfs_rq:/.right_vruntime.avg
   9795302 ± 16%     -40.2%    5855509 ± 35%  sched_debug.cfs_rq:/.right_vruntime.max
   1571785 ± 18%     -43.3%     890461 ± 38%  sched_debug.cfs_rq:/.right_vruntime.stddev
      1520 ±  5%      -9.4%       1378 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
      1524 ±  4%      -9.8%       1375 ±  3%  sched_debug.cfs_rq:/.util_avg.max
     89.85 ±  5%     -19.7%      72.13 ±  6%  sched_debug.cfs_rq:/.util_est.avg
    151069           +75.1%     264508 ±  3%  sched_debug.cpu.avg_idle.avg
    305891 ±  7%     +93.0%     590328 ±  9%  sched_debug.cpu.avg_idle.max
     33491 ± 12%     +96.0%      65650 ± 14%  sched_debug.cpu.avg_idle.min
     53210 ±  4%    +102.6%     107782 ±  7%  sched_debug.cpu.avg_idle.stddev
   1051570 ±  7%     -30.7%     728706 ±  8%  sched_debug.cpu.curr->pid.avg
    500485          +182.2%    1412208        sched_debug.cpu.max_idle_balance_cost.avg
    516654          +188.9%    1492616        sched_debug.cpu.max_idle_balance_cost.max
    500000          +166.3%    1331544        sched_debug.cpu.max_idle_balance_cost.min
      2516 ± 29%   +1714.3%      45656 ±  5%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.60 ±  3%     -19.8%       0.48 ±  5%  sched_debug.cpu.nr_running.avg
      0.59 ±  2%     +12.1%       0.66 ±  5%  sched_debug.cpu.nr_running.stddev
   3086131           -33.6%    2048649        sched_debug.cpu.nr_switches.avg
   3157114           -34.1%    2079849        sched_debug.cpu.nr_switches.max
   2903213           -31.5%    1988842        sched_debug.cpu.nr_switches.min
     42830 ± 15%     -59.8%      17196 ± 16%  sched_debug.cpu.nr_switches.stddev
      0.74 ±  5%     +15.5%       0.85 ±  3%  sched_debug.cpu.nr_uninterruptible.avg
     13734 ± 28%     -74.1%       3553 ± 11%  sched_debug.cpu.nr_uninterruptible.max
    -26136           -85.3%      -3833        sched_debug.cpu.nr_uninterruptible.min
      8461 ± 24%     -79.9%       1701 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
      0.01 ± 12%     +66.2%       0.02 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.wp_page_copy
      0.01 ± 32%    +224.1%       0.04 ± 46%  perf-sched.sch_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
      0.01 ±  7%     +86.7%       0.03 ± 27%  perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      0.02 ± 48%    +184.5%       0.05 ± 39%  perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      0.01 ± 20%     +48.4%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      0.01 ± 45%    +244.6%       0.05 ± 43%  perf-sched.sch_delay.avg.ms.__cond_resched.do_close_on_exec.begin_new_exec.load_elf_binary.exec_binprm
      0.01 ± 11%     +46.9%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.path_openat
      0.02 ± 28%     +90.0%       0.03 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.01 ± 22%     +47.7%       0.02 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.01 ± 22%    +135.1%       0.03 ± 24%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.exec_binprm
      0.02 ± 56%    +233.7%       0.05 ± 39%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 20%    +122.8%       0.03 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_binary
      0.01 ± 16%     +93.4%       0.02 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.01 ±  7%     +22.2%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.01 ± 27%    +127.0%       0.02 ± 37%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.01 ± 30%     +88.2%       0.03 ± 24%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      0.01 ± 24%     +79.7%       0.02 ± 27%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc._install_special_mapping.map_vdso
      0.05 ±125%     -89.1%       0.01 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      0.01 ± 21%     -74.4%       0.00 ±145%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.uprobe_clear_state.__mmput.exit_mm
      0.01 ± 43%    +184.3%       0.04 ± 49%  perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
      0.01           +97.9%       0.02 ±  2%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ±  6%    +151.4%       0.03 ± 59%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.02 ±  2%     +18.9%       0.02 ±  4%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 10%     +42.4%       0.02 ± 14%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ±  9%     +73.3%       0.02 ± 23%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      0.01 ±  4%     +26.2%       0.02 ±  4%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.01 ± 13%     +68.8%       0.02 ±  2%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.02 ±  5%     +72.6%       0.03 ±  2%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.01 ± 12%     +45.8%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ±  6%     +42.6%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.04 ± 21%    +106.5%       0.07 ±  8%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.04 ± 15%    +120.5%       0.10 ± 15%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.01 ±  3%     +24.6%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.01 ±  3%     +50.8%       0.02 ±  2%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.01 ±  5%     +31.4%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.02 ±  7%     -18.2%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
      0.01 ± 10%     +40.2%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  6%     +29.9%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01           -12.5%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ±  3%     -16.9%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.11 ± 52%    +316.2%       0.47 ± 74%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pud_alloc
      0.12 ± 41%     +85.8%       0.22 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      0.10 ± 58%    +298.3%       0.42 ± 65%  perf-sched.sch_delay.max.ms.__cond_resched.do_close_on_exec.begin_new_exec.load_elf_binary.exec_binprm
      0.07 ± 80%    +633.0%       0.50 ± 90%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_file_vma_batch_process.unlink_file_vma_batch_add.free_pgtables
      0.11 ± 44%    +108.8%       0.22 ± 39%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.11 ± 34%    +478.5%       0.65 ± 64%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.exec_binprm
      0.09 ± 65%    +286.6%       0.34 ± 69%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.12 ± 24%    +313.1%       0.49 ± 54%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_binary
      0.10 ± 32%    +185.2%       0.29 ± 57%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc._install_special_mapping.map_vdso
      0.09 ± 27%    +142.0%       0.23 ± 25%  perf-sched.sch_delay.max.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.15 ±147%     -95.7%       0.01 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      0.01 ± 20%     -75.0%       0.00 ±145%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.uprobe_clear_state.__mmput.exit_mm
      0.15 ± 50%    +388.7%       0.71 ± 68%  perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
      0.40 ± 27%   +1421.1%       6.14 ±174%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.07 ± 30%    +303.5%       0.27 ± 45%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.11 ± 44%    +107.0%       0.24 ± 31%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      0.97 ± 36%    +177.9%       2.69 ± 54%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.85 ± 41%     +92.2%       1.63 ± 24%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.15 ±108%     -80.7%       0.03 ± 99%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.36 ± 41%    +123.0%       0.80 ± 40%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.05 ± 28%     -34.7%       0.03 ± 27%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
      0.01 ±  3%     +38.5%       0.02        perf-sched.total_sch_delay.average.ms
      1.01           +18.4%       1.19        perf-sched.total_wait_and_delay.average.ms
   1887109           -14.5%    1613345        perf-sched.total_wait_and_delay.count.ms
      1.00           +18.1%       1.18        perf-sched.total_wait_time.average.ms
     13.85 ± 15%     +37.4%      19.02 ± 17%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      6.31           +17.3%       7.41        perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.06           +57.6%       0.09        perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.59           +16.4%       0.69        perf-sched.wait_and_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±  2%    +191.4%       0.05        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      5.95           +11.0%       6.61        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.94 ±  4%     +12.3%      22.39        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.22           +28.1%       0.29        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.21           +24.9%       0.27        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.21           +20.4%       0.25        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.14           +27.0%       0.17        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.54 ±  2%     +28.7%       0.70        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.22 ±  3%     +22.0%       0.27 ±  3%  perf-sched.wait_and_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.32           +13.4%       8.30        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    126.17 ±  8%     -19.8%     101.17 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
     10.50 ± 25%     -54.0%       4.83 ± 73%  perf-sched.wait_and_delay.count.__cond_resched.__kmalloc_node_noprof.__vmalloc_area_node.__vmalloc_node_range_noprof.__vmalloc_node_noprof
    537.33 ±  2%     -22.5%     416.33        perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
     43.00 ±  6%     -29.8%      30.17 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
     80.50 ±  7%     -32.1%      54.67 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
    126.33 ± 10%     -21.4%      99.33 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
     46.83 ±  9%     -18.9%      38.00 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
    369.17 ±  5%     -18.6%     300.50 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
     62.83 ±  9%     -26.3%      46.33 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
     91.17 ±  5%     -26.1%      67.33 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     45.50 ± 16%     -31.9%      31.00 ± 21%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
     67.50 ± 15%     -26.9%      49.33 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
    183.83 ±  5%     -28.6%     131.33 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
      7.67 ± 16%     -52.2%       3.67 ± 51%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
     93.50 ±  9%     -30.3%      65.17 ± 45%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
     32.33 ± 13%     -36.1%      20.67 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.pidfs_exit.release_task.wait_task_zombie.__do_wait
     28.67 ± 11%     -31.4%      19.67 ± 22%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      2932 ±  2%     -15.8%       2468 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     43706           -10.1%      39295        perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    797.83           -20.7%     633.00 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
     75849           -12.9%      66072        perf-sched.wait_and_delay.count.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
     97605           -10.0%      87867        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     79047           -10.0%      71173        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2304 ±  3%     -14.0%       1980 ±  2%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     79568           -16.4%      66556        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
   1246136           -15.5%    1052691        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
     21025           -14.7%      17931        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     21731           -10.0%      19563        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     10842           -10.0%       9757        perf-sched.wait_and_delay.count.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     83415           -11.7%      73668        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     19.70 ± 71%     +75.6%      34.61 ±  6%  perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pgd_alloc
     34.37 ±  5%     +14.7%      39.42 ±  3%  perf-sched.wait_and_delay.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
     31.04           +10.8%      34.38 ±  4%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
     28.30 ±  4%     +14.1%      32.30 ±  3%  perf-sched.wait_and_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
     22.54 ± 49%     +59.0%      35.84 ±  6%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.dup_fd.copy_process.kernel_clone
      2.25 ± 30%     +67.7%       3.77 ±  9%  perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     29.76 ±  8%     +14.9%      34.19 ±  5%  perf-sched.wait_and_delay.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mm.constprop.0
     23.02 ± 45%     +57.0%      36.15 ± 25%  perf-sched.wait_and_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     30.95 ±  2%     +27.9%      39.60 ± 24%  perf-sched.wait_and_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      4.42 ± 19%    +393.4%      21.82 ± 11%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     28.27 ±  4%     +23.0%      34.76 ±  3%  perf-sched.wait_and_delay.max.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.08 ± 11%     +48.0%       0.12 ± 25%  perf-sched.wait_time.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
      0.15 ±  5%     +13.9%       0.17 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.16 ±  9%     +41.4%       0.23 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      0.13 ± 22%     +50.8%       0.19 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.change_pmd_range.isra.0.change_pud_range
      0.18 ±  4%     +24.8%       0.22 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.08 ± 38%     +99.8%       0.16 ± 30%  perf-sched.wait_time.avg.ms.__cond_resched.do_close_on_exec.begin_new_exec.load_elf_binary.exec_binprm
      0.18 ±  4%     +20.1%       0.22 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.20 ±  2%     +22.5%       0.25 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.path_lookupat
      0.18           +19.3%       0.22 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.path_openat
      0.12 ±  9%     +15.3%       0.14 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
      0.20 ±  2%     +25.7%       0.25 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.02 ± 42%    +126.9%       0.04 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.exec_binprm
      0.19           +22.8%       0.24 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.20 ±  4%     +28.6%       0.25 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.21 ±  2%     +24.4%       0.26 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_lookupat
      0.19           +16.6%       0.22 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.19 ±  5%     +22.7%       0.24 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.21 ±  6%     +19.4%       0.25 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
      0.17           +22.6%       0.21 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.03 ± 33%     +85.9%       0.06 ± 29%  perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.__kernel_read.exec_binprm.bprm_execve
      0.13 ± 15%     +82.8%       0.24 ± 32%  perf-sched.wait_time.avg.ms.__cond_resched.folio_zero_user.vma_alloc_anon_folio_pmd.__do_huge_pmd_anonymous_page.__handle_mm_fault
     13.84 ± 15%     +37.4%      19.02 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.20 ±  5%     +23.4%       0.25 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      0.17 ±  5%     +20.6%       0.20 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.21 ±  3%     +15.2%       0.24 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.01 ± 86%    +437.8%       0.07 ± 86%  perf-sched.wait_time.avg.ms.__cond_resched.move_page_tables.relocate_vma_down.setup_arg_pages.load_elf_binary
      0.20 ±  3%     +35.3%       0.27 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
      6.30           +17.3%       7.40        perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05           +50.9%       0.07        perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.20 ±  2%     +23.0%       0.24 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.17 ±  3%     +20.3%       0.20 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.58           +16.7%       0.68        perf-sched.wait_time.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.21           +21.0%       0.25 ±  2%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      0.02 ±  2%    +191.4%       0.05        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      5.93           +11.0%       6.59        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.03 ± 24%     +58.0%       0.05 ± 17%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      0.10           +41.0%       0.14        perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.20 ±  6%     +21.9%       0.24 ±  7%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.34 ± 14%     +23.2%       0.41 ± 10%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     19.93 ±  4%     +12.3%      22.38        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.21           +28.2%       0.27        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.20           +23.3%       0.25        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.20           +20.5%       0.24        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.49 ± 11%     +90.1%       0.92 ± 22%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      0.13           +26.6%       0.16        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.02 ±  7%     -18.2%       0.01 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
      0.53 ±  2%     +28.5%       0.68        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.20 ±  3%     +21.7%       0.25 ±  3%  perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.31           +13.4%       8.29        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     21.31 ± 55%     +61.9%      34.52 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pgd_alloc
      0.49 ± 33%    +124.6%       1.11 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.39 ±  5%    +194.0%       1.15 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
      0.49 ± 14%    +104.7%       1.00 ± 39%  perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.step_into.link_path_walk
      0.65 ± 50%    +126.5%       1.47 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      0.68 ± 22%     +98.3%       1.36 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
     34.34 ±  5%     +14.7%      39.40 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.57 ± 12%     +95.3%       1.11 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      0.42 ± 20%    +112.7%       0.89 ± 25%  perf-sched.wait_time.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.74 ± 17%    +136.4%       1.76 ± 27%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_lookupat
     30.86           +10.2%      34.02 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.30 ± 16%    +144.0%       0.72 ± 43%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_file_vma_batch_process.free_pgtables.vms_clear_ptes
      0.66 ± 39%    +116.2%       1.42 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.38 ± 20%    +165.9%       1.01 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
      1.03 ± 36%     +68.8%       1.75 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.81 ± 13%     +94.0%       1.56 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.73 ± 23%     +99.7%       1.46 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.path_lookupat
      0.47 ± 30%    +116.2%       1.02 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
     28.29 ±  4%     +14.2%      32.30 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.40 ± 10%    +120.5%       0.88 ± 36%  perf-sched.wait_time.max.ms.__cond_resched.filemap_read.__kernel_read.exec_binprm.bprm_execve
      0.34 ± 33%    +235.3%       1.15 ± 45%  perf-sched.wait_time.max.ms.__cond_resched.folio_zero_user.vma_alloc_anon_folio_pmd.__do_huge_pmd_anonymous_page.__handle_mm_fault
      0.84 ± 28%     +62.4%       1.36 ± 26%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
     22.53 ± 49%     +59.1%      35.84 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.dup_fd.copy_process.kernel_clone
      0.41 ± 32%    +143.3%       1.00 ± 31%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
      0.68 ± 19%     +54.1%       1.05 ± 18%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      1.07 ± 22%     +62.2%       1.74 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.28 ± 34%    +115.8%       0.61 ± 45%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.do_brk_flags.__do_sys_brk
      0.30 ± 16%     +47.3%       0.45 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      0.39 ± 11%    +224.5%       1.27 ± 47%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
      1.62 ± 21%     +48.0%       2.39 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.77 ±  8%    +108.5%       1.60 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      1.12 ± 36%     +66.4%       1.86 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
     29.76 ±  8%     +14.5%      34.08 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mm.constprop.0
     26.81 ±  9%     +18.7%      31.82 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     30.95 ±  2%     +14.1%      35.32 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.74 ± 23%    +101.0%       1.49 ± 12%  perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      4.42 ± 19%    +393.4%      21.82 ± 11%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     29.59 ±  3%     +13.2%      33.51 ±  4%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.49 ± 43%     -45.9%       0.27 ± 57%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
     33.37 ±  4%     +18.7%      39.60 ±  7%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      0.05 ± 28%     -34.7%       0.03 ± 27%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
     28.26 ±  4%     +22.9%      34.73 ±  3%  perf-sched.wait_time.max.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe


***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/shell16/unixbench

commit: 
  5bc34be478 ("sched/core: Reorganize cgroup bandwidth control interface file writes")
  ac34cb39e8 ("sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails")

5bc34be478d09c4d ac34cb39e8aea9915ec2f4e08c9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2730104           -10.6%    2439597        meminfo.Shmem
     16614           +45.5%      24179        uptime.idle
 1.463e+10           +51.2%  2.213e+10        cpuidle..time
 1.678e+08 ±  3%     -21.0%  1.325e+08 ±  2%  cpuidle..usage
   3594064 ± 35%     -41.5%    2101847 ± 76%  numa-meminfo.node0.FilePages
   1177451 ± 12%     -21.5%     924840 ± 11%  numa-meminfo.node0.Shmem
 5.265e+08           -20.5%  4.187e+08        numa-numastat.node0.local_node
 5.265e+08           -20.5%  4.187e+08        numa-numastat.node0.numa_hit
 5.234e+08           -20.4%  4.167e+08        numa-numastat.node1.local_node
 5.235e+08           -20.4%  4.168e+08        numa-numastat.node1.numa_hit
     36.44           +50.4%      54.81        vmstat.cpu.id
     53.69 ±  3%     +15.4%      61.93 ±  3%  vmstat.procs.r
    611600 ±  2%     -36.8%     386273        vmstat.system.cs
    494859 ±  2%     -37.8%     307602        vmstat.system.in
      9369           -15.3%       7939        perf-c2c.DRAM.local
     29442           -33.9%      19455        perf-c2c.DRAM.remote
     22092           -34.9%      14380        perf-c2c.HITM.local
     15664           -34.4%      10278        perf-c2c.HITM.remote
     37756           -34.7%      24658        perf-c2c.HITM.total
    898526 ± 35%     -41.5%     525463 ± 76%  numa-vmstat.node0.nr_file_pages
    294369 ± 12%     -21.5%     231222 ± 11%  numa-vmstat.node0.nr_shmem
 5.265e+08           -20.5%  4.187e+08        numa-vmstat.node0.numa_hit
 5.265e+08           -20.5%  4.187e+08        numa-vmstat.node0.numa_local
 5.235e+08           -20.4%  4.168e+08        numa-vmstat.node1.numa_hit
 5.234e+08           -20.4%  4.167e+08        numa-vmstat.node1.numa_local
     36.28           +18.4       54.67        mpstat.cpu.all.idle%
      0.00 ± 19%      +0.0        0.01 ±  4%  mpstat.cpu.all.iowait%
      1.24 ±  2%      -0.4        0.80        mpstat.cpu.all.irq%
      0.65            -0.2        0.49        mpstat.cpu.all.soft%
     52.22           -15.0       37.26 ±  2%  mpstat.cpu.all.sys%
      9.62            -2.8        6.77        mpstat.cpu.all.usr%
     70.32           -25.8%      52.19        mpstat.max_utilization_pct
     10028           -20.3%       7993        unixbench.throughput
  12013870           -17.7%    9885824 ±  2%  unixbench.time.involuntary_context_switches
    620003           -21.1%     489302 ±  2%  unixbench.time.major_page_faults
 1.242e+09           -20.4%  9.891e+08        unixbench.time.minor_page_faults
      3788           -25.9%       2806        unixbench.time.percent_of_cpu_this_job_got
     18741           -26.6%      13750 ±  2%  unixbench.time.system_time
      5225           -23.2%       4014        unixbench.time.user_time
 2.227e+08           -42.0%  1.292e+08        unixbench.time.voluntary_context_switches
   6341093           -20.2%    5058834        unixbench.workload
    902694            -8.2%     828505        proc-vmstat.nr_active_anon
   1593764            -4.6%    1520712        proc-vmstat.nr_file_pages
     49655            -3.6%      47878        proc-vmstat.nr_kernel_stack
     31705 ±  2%      -8.6%      28967        proc-vmstat.nr_mapped
     36671            -5.2%      34746        proc-vmstat.nr_page_table_pages
    682470           -10.6%     609854        proc-vmstat.nr_shmem
     28442            -1.2%      28094        proc-vmstat.nr_slab_reclaimable
     57057            -3.2%      55224        proc-vmstat.nr_slab_unreclaimable
    902694            -8.2%     828505        proc-vmstat.nr_zone_active_anon
     12021 ± 90%    +166.4%      32030 ± 23%  proc-vmstat.numa_hint_faults_local
  1.05e+09           -20.4%  8.355e+08        proc-vmstat.numa_hit
  1.05e+09           -20.4%  8.354e+08        proc-vmstat.numa_local
     68540            -1.2%      67690        proc-vmstat.numa_other
  1.09e+09           -20.8%  8.639e+08        proc-vmstat.pgalloc_normal
 1.252e+09           -20.2%  9.994e+08        proc-vmstat.pgfault
 1.089e+09           -20.8%  8.631e+08        proc-vmstat.pgfree
  62037106           -20.4%   49362493        proc-vmstat.pgreuse
     53371           -20.2%      42580        proc-vmstat.thp_fault_alloc
  22516441           -20.5%   17901785        proc-vmstat.unevictable_pgs_culled
      3.59           -17.9%       2.95        perf-stat.i.MPKI
 1.623e+10           -24.9%  1.219e+10        perf-stat.i.branch-instructions
      1.57            -0.2        1.40        perf-stat.i.branch-miss-rate%
 2.498e+08           -33.0%  1.673e+08        perf-stat.i.branch-misses
 2.892e+08           -38.7%  1.774e+08        perf-stat.i.cache-misses
 1.186e+09           -39.0%  7.234e+08        perf-stat.i.cache-references
    613708 ±  2%     -36.8%     387765        perf-stat.i.context-switches
      1.90            -4.6%       1.81        perf-stat.i.cpi
 1.523e+11           -28.3%  1.091e+11        perf-stat.i.cpu-cycles
    222994           -63.6%      81240 ±  2%  perf-stat.i.cpu-migrations
    535.59           +15.9%     620.57        perf-stat.i.cycles-between-cache-misses
 7.918e+10           -24.8%  5.951e+10        perf-stat.i.instructions
      0.54            +4.6%       0.56        perf-stat.i.ipc
    985.60           -21.0%     778.65 ±  2%  perf-stat.i.major-faults
     73.54           -24.5%      55.54        perf-stat.i.metric.K/sec
   1935828           -20.3%    1543350        perf-stat.i.minor-faults
   1936814           -20.3%    1544128        perf-stat.i.page-faults
      3.65           -18.4%       2.98        perf-stat.overall.MPKI
      1.54            -0.2        1.37        perf-stat.overall.branch-miss-rate%
      1.92            -4.7%       1.83        perf-stat.overall.cpi
    526.44           +16.8%     614.96        perf-stat.overall.cycles-between-cache-misses
      0.52            +4.9%       0.55        perf-stat.overall.ipc
   7901309            -5.7%    7454189        perf-stat.overall.path-length
  1.62e+10           -24.9%  1.217e+10        perf-stat.ps.branch-instructions
 2.494e+08           -33.0%   1.67e+08        perf-stat.ps.branch-misses
 2.888e+08           -38.7%  1.771e+08        perf-stat.ps.cache-misses
 1.185e+09           -39.0%  7.223e+08        perf-stat.ps.cache-references
    612790 ±  2%     -36.8%     387169        perf-stat.ps.context-switches
  1.52e+11           -28.3%  1.089e+11        perf-stat.ps.cpu-cycles
    222664           -63.6%      81128 ±  2%  perf-stat.ps.cpu-migrations
 7.906e+10           -24.8%  5.942e+10        perf-stat.ps.instructions
    984.18           -21.0%     777.37 ±  2%  perf-stat.ps.major-faults
   1932667           -20.3%    1540796        perf-stat.ps.minor-faults
   1933651           -20.3%    1541574        perf-stat.ps.page-faults
  5.01e+13           -24.7%  3.771e+13        perf-stat.total.instructions
  13122731           -28.7%    9355433        sched_debug.cfs_rq:/.avg_vruntime.avg
  15409189 ±  2%     -25.8%   11433341        sched_debug.cfs_rq:/.avg_vruntime.max
  12592550           -29.2%    8913985        sched_debug.cfs_rq:/.avg_vruntime.min
      5.14 ± 16%     +54.0%       7.91 ± 15%  sched_debug.cfs_rq:/.h_nr_queued.max
      0.94 ±  9%     +56.5%       1.46 ± 11%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      4.58 ± 17%     +64.2%       7.52 ± 17%  sched_debug.cfs_rq:/.h_nr_runnable.max
      0.83 ±  8%     +62.3%       1.35 ± 12%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
     21218 ± 18%     -35.7%      13650 ± 10%  sched_debug.cfs_rq:/.load.avg
    627984 ± 25%     -42.7%     359859 ± 13%  sched_debug.cfs_rq:/.load.max
     16.98 ±  2%     -18.1%      13.91 ±  3%  sched_debug.cfs_rq:/.load_avg.min
  13122731           -28.7%    9355433        sched_debug.cfs_rq:/.min_vruntime.avg
  15409189 ±  2%     -25.8%   11433341        sched_debug.cfs_rq:/.min_vruntime.max
  12592550           -29.2%    8913985        sched_debug.cfs_rq:/.min_vruntime.min
      0.60 ±  2%     -26.9%       0.44 ±  6%  sched_debug.cfs_rq:/.nr_queued.avg
    879.57           +13.7%     999.66 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      1573 ±  2%     +35.8%       2136 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
    255.02 ±  3%     +18.1%     301.21 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    243.04 ±  3%     -14.0%     209.05        sched_debug.cfs_rq:/.util_avg.stddev
     29.82 ±  7%     +32.6%      39.52 ± 13%  sched_debug.cfs_rq:/.util_est.avg
    262.67 ±  8%     +72.5%     452.98 ± 16%  sched_debug.cfs_rq:/.util_est.max
     51.96 ±  7%     +61.0%      83.65 ± 11%  sched_debug.cfs_rq:/.util_est.stddev
    170679 ±  2%     +88.6%     321939 ±  2%  sched_debug.cpu.avg_idle.avg
    375875 ±  5%    +110.8%     792298 ±  3%  sched_debug.cpu.avg_idle.max
     27824 ± 14%    +111.3%      58800 ±  5%  sched_debug.cpu.avg_idle.min
     70934 ±  5%    +115.4%     152820 ±  2%  sched_debug.cpu.avg_idle.stddev
   1225277 ±  2%     -34.5%     802812 ±  9%  sched_debug.cpu.curr->pid.avg
    500271          +171.7%    1359127        sched_debug.cpu.max_idle_balance_cost.avg
    513437          +190.7%    1492784        sched_debug.cpu.max_idle_balance_cost.max
      1752 ± 41%   +7584.0%     134642 ± 47%  sched_debug.cpu.max_idle_balance_cost.stddev
      5.64 ± 14%     +49.5%       8.42 ± 19%  sched_debug.cpu.nr_running.max
      0.99 ±  9%     +53.5%       1.53 ± 13%  sched_debug.cpu.nr_running.stddev
   2889232 ±  2%     -36.7%    1829756        sched_debug.cpu.nr_switches.avg
   2943872 ±  2%     -36.8%    1859463        sched_debug.cpu.nr_switches.max
   2793423 ±  2%     -36.2%    1781992        sched_debug.cpu.nr_switches.min
     28235 ±  7%     -51.8%      13616 ±  6%  sched_debug.cpu.nr_switches.stddev
     50800 ± 18%     -88.4%       5891 ± 15%  sched_debug.cpu.nr_uninterruptible.max
    -96771           -93.5%      -6330        sched_debug.cpu.nr_uninterruptible.min
     32796 ± 12%     -92.2%       2565 ± 12%  sched_debug.cpu.nr_uninterruptible.stddev
      0.01 ± 14%    +211.1%       0.02 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.alloc_anon_folio
      0.01 ±  9%     +47.3%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.01 ± 23%    +104.8%       0.02 ± 33%  perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.01 ± 13%     +71.2%       0.02 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.do_close_on_exec.begin_new_exec.load_elf_binary.exec_binprm
      0.01 ±  9%     +67.4%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.path_openat
      0.01 ±  4%    +588.7%       0.06 ±166%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.01 ± 14%    +107.7%       0.01 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.01 ± 21%     +64.1%       0.02 ± 22%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.exec_binprm
      0.01 ± 19%     +91.8%       0.02 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
      0.01 ± 57%     -61.3%       0.00 ± 22%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.simple_unlink.vfs_unlink.do_unlinkat
      0.01 ±  6%     +56.8%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.01 ± 10%    +124.4%       0.02 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      0.01 ± 16%     +82.2%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.01 ±  4%     +32.7%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  8%     +84.0%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ±  5%     +50.0%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.01 ± 26%    +155.8%       0.02 ± 18%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      0.01 ±  8%    +108.8%       0.03 ± 34%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.01 ±  7%     +84.2%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.01 ± 22%    +381.2%       0.04 ± 90%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01          +109.5%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.01 ± 21%     +38.2%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.02 ± 18%     +38.5%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.00 ± 21%     +78.9%       0.01 ± 26%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__mmap_new_vma
      0.01 ± 18%     +65.1%       0.02 ± 17%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.01 ±  4%     -12.9%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ±  3%     -19.5%       0.03 ±  2%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.14 ± 36%     +69.3%       0.24 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pmd_alloc
      0.14 ± 68%    +754.0%       1.18 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.alloc_anon_folio
      0.17 ± 46%    +350.2%       0.76 ± 51%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.wp_page_copy
      0.16 ± 31%    +176.8%       0.46 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.09 ± 37%    +296.4%       0.37 ± 46%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.06 ± 32%    +811.7%       0.56 ± 57%  perf-sched.sch_delay.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.07 ± 24%    +137.0%       0.16 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.do_close_on_exec.begin_new_exec.load_elf_binary.exec_binprm
      0.13 ± 59%    +817.1%       1.24 ± 56%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_openat
      0.13 ± 13%   +9995.6%      12.72 ±212%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.07 ± 40%    +669.3%       0.50 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.07 ± 67%    +176.5%       0.21 ± 35%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.map_vdso.load_elf_binary.exec_binprm
      0.10 ± 26%    +125.2%       0.23 ± 26%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
      0.18 ± 41%   +4953.1%       8.97 ±146%  perf-sched.sch_delay.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.23 ± 52%    +333.0%       0.99 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.10 ± 25%    +108.5%       0.22 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.06 ± 53%    +914.3%       0.58 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      0.04 ± 30%    +476.7%       0.24 ±129%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      0.07 ± 49%    +182.2%       0.18 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_shrink
      0.10 ± 37%    +480.3%       0.57 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.09 ± 53%    +130.5%       0.20 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc._install_special_mapping.map_vdso
      0.18 ± 38%    +189.6%       0.52 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.07 ± 46%    +290.1%       0.28 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.03 ±111%   +1015.2%       0.37 ±101%  perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
      0.08 ± 41%    +249.3%       0.26 ± 28%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      0.17 ± 42%    +346.9%       0.77 ± 27%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.26 ± 30%    +490.9%       1.54 ± 18%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.08 ± 48%    +638.6%       0.61 ± 67%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.06 ± 74%    +523.0%       0.38 ± 64%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.16 ± 55%    +289.8%       0.63 ± 82%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.24 ± 68%    +124.3%       0.53 ± 27%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__mmap_new_vma
      1962 ±  9%     +52.1%       2986 ± 26%  perf-sched.total_wait_and_delay.max.ms
      1962 ±  9%     +52.1%       2986 ± 26%  perf-sched.total_wait_time.max.ms
      6.10 ±  3%     +16.5%       7.11 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±  2%    +172.7%       0.06        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2.86 ±  3%     +16.5%       3.33 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
    457.67 ±  5%     -13.3%     397.00 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
     31.00 ± 12%     -36.6%      19.67 ± 19%  perf-sched.wait_and_delay.count.__cond_resched.pidfs_exit.release_task.wait_task_zombie.__do_wait
      2114 ±  5%     +18.8%       2512 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1443 ±  2%     -11.9%       1272 ±  2%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     73.43 ± 13%     -49.8%      36.86 ± 72%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
      8.47 ±  9%     +34.4%      11.39 ±  8%  perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      5.00 ± 13%    +512.7%      30.62 ± 20%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1962 ±  9%     +52.1%       2986 ± 26%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.08 ±207%    +356.6%       0.36 ± 70%  perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
      3.33 ±  6%     +10.2%       3.67 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      3.90 ±  6%      +9.7%       4.27 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      6.09 ±  3%     +16.5%       7.10 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.12 ±  3%     +16.5%       3.63 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.02 ±  2%    +172.7%       0.06        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1.47 ±  3%     +13.9%       1.67        perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      2.94 ± 19%     +53.8%       4.52 ±  9%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      2.84 ±  3%     +16.1%       3.30 ±  3%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      6.50 ±  5%     +25.4%       8.15 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_lookupat
      6.15 ±  8%     +30.1%       8.00 ± 18%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
      7.61 ±  6%    +106.6%      15.72 ± 87%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      5.59 ± 13%     +38.8%       7.75 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
     73.42 ± 13%     -48.7%      37.66 ± 68%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
      6.55 ±  5%     +14.5%       7.50 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      8.46 ±  9%     +34.3%      11.36 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      5.00 ± 13%    +512.7%      30.62 ± 20%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     18.28 ±130%    +313.9%      75.66 ± 16%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      1962 ±  9%     +52.1%       2986 ± 26%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm



***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/shell8/unixbench

commit: 
  5bc34be478 ("sched/core: Reorganize cgroup bandwidth control interface file writes")
  ac34cb39e8 ("sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails")

5bc34be478d09c4d ac34cb39e8aea9915ec2f4e08c9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     22.83 ± 60%    +140.9%      55.00 ± 56%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3708           +24.7%       4625 ±  2%  uptime.idle
 1.461e+09 ±  2%     +56.0%  2.279e+09 ±  2%  cpuidle..time
  19339144 ±  3%     -26.4%   14234823 ±  3%  cpuidle..usage
     36.38           +53.9%      56.00        vmstat.cpu.id
    631990 ±  2%     -40.3%     377172 ±  2%  vmstat.system.cs
    507992 ±  2%     -40.5%     302370        vmstat.system.in
  54790263           -26.6%   40229835        numa-numastat.node0.local_node
  54813627           -26.6%   40257329        numa-numastat.node0.numa_hit
  54280109           -25.6%   40400612        numa-numastat.node1.local_node
  54337234           -25.6%   40440402        numa-numastat.node1.numa_hit
  54813360           -26.6%   40257724        numa-vmstat.node0.numa_hit
  54789997           -26.6%   40230231        numa-vmstat.node0.numa_local
  54337173           -25.6%   40439842        numa-vmstat.node1.numa_hit
  54280054           -25.6%   40400056        numa-vmstat.node1.numa_local
     34.50           +20.2       54.74        mpstat.cpu.all.idle%
      0.00 ± 43%      +0.0        0.00 ± 20%  mpstat.cpu.all.iowait%
      1.30 ±  2%      -0.5        0.81        mpstat.cpu.all.irq%
      0.62            -0.2        0.46        mpstat.cpu.all.soft%
     53.55           -16.2       37.32 ±  2%  mpstat.cpu.all.sys%
     10.03            -3.4        6.67        mpstat.cpu.all.usr%
     72.84           -28.5%      52.04 ±  3%  mpstat.max_utilization_pct
     24992            -4.7%      23818        proc-vmstat.nr_page_table_pages
     50622            -2.0%      49590        proc-vmstat.nr_slab_unreclaimable
 1.092e+08           -26.1%   80699262        proc-vmstat.numa_hit
 1.091e+08           -26.1%   80631976        proc-vmstat.numa_local
  1.13e+08           -26.3%   83331586        proc-vmstat.pgalloc_normal
 1.302e+08           -25.8%   96571708        proc-vmstat.pgfault
 1.129e+08           -26.3%   83193858        proc-vmstat.pgfree
   6371181           -26.1%    4708130        proc-vmstat.pgreuse
      5521 ±  2%     -25.3%       4122        proc-vmstat.thp_fault_alloc
   2323235           -26.1%    1716008        proc-vmstat.unevictable_pgs_culled
     34426           -26.2%      25392        unixbench.score
     20655           -26.2%      15235        unixbench.throughput
   1172933           -26.4%     863436 ±  4%  unixbench.time.involuntary_context_switches
     68518           -25.7%      50886 ±  2%  unixbench.time.major_page_faults
 1.295e+08           -26.0%   95855227        unixbench.time.minor_page_faults
      3974           -28.2%       2852 ±  2%  unixbench.time.percent_of_cpu_this_job_got
      1994           -28.5%       1426 ±  3%  unixbench.time.system_time
    538.91           -29.3%     381.20        unixbench.time.user_time
  23209907           -44.1%   12967611        unixbench.time.voluntary_context_switches
   1301317           -26.2%     959835        unixbench.workload
      3.20           -15.9%       2.69        perf-stat.i.MPKI
 1.691e+10           -28.2%  1.214e+10        perf-stat.i.branch-instructions
      1.75            -0.1        1.62 ±  2%  perf-stat.i.branch-miss-rate%
 2.685e+08           -33.5%  1.786e+08        perf-stat.i.branch-misses
     23.70            -0.4       23.28        perf-stat.i.cache-miss-rate%
 2.751e+08           -39.9%  1.654e+08        perf-stat.i.cache-misses
 1.154e+09           -38.8%  7.061e+08        perf-stat.i.cache-references
    662789 ±  2%     -40.6%     393867 ±  2%  perf-stat.i.context-switches
      1.86            -2.2%       1.82        perf-stat.i.cpi
 1.585e+11           -30.1%  1.108e+11 ±  2%  perf-stat.i.cpu-cycles
    238322           -63.0%      88291 ±  3%  perf-stat.i.cpu-migrations
    625.36           +15.2%     720.11 ±  2%  perf-stat.i.cycles-between-cache-misses
  8.25e+10           -28.2%  5.924e+10        perf-stat.i.instructions
      1074           -25.5%     800.25 ±  2%  perf-stat.i.major-faults
     76.11           -29.7%      53.52        perf-stat.i.metric.K/sec
   1989387           -25.8%    1476846        perf-stat.i.minor-faults
   1990462           -25.8%    1477646        perf-stat.i.page-faults
    479.50 ± 44%     +39.7%     669.77        perf-stat.overall.cycles-between-cache-misses
      0.43 ± 44%     +23.1%       0.53        perf-stat.overall.ipc
      0.47 ±154%      +1.2        1.65 ± 35%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.20 ± 83%      +2.1        3.26 ± 41%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.34 ± 80%      +2.4        3.72 ± 34%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.34 ± 80%      +2.6        3.92 ± 27%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      1.34 ± 80%      +3.1        4.42 ± 33%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.20 ± 83%      +3.3        4.50 ± 75%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.05 ±223%      +0.7        0.74 ± 75%  perf-profile.children.cycles-pp.try_to_wake_up
      0.40 ± 98%      +0.7        1.14 ± 54%  perf-profile.children.cycles-pp.elf_load
      0.25 ±101%      +0.9        1.11 ± 54%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.00            +0.9        0.88 ± 98%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.04 ±223%      +1.0        1.06 ±109%  perf-profile.children.cycles-pp.do_anonymous_page
      0.37 ± 91%      +1.0        1.41 ± 41%  perf-profile.children.cycles-pp.wp_page_copy
      0.00            +1.1        1.06 ±110%  perf-profile.children.cycles-pp.clockevents_program_event
      0.28 ±126%      +1.2        1.44 ± 39%  perf-profile.children.cycles-pp.ktime_get
      0.60 ±110%      +1.3        1.91 ± 25%  perf-profile.children.cycles-pp.zap_present_ptes
      0.36 ±116%      +1.3        1.67 ± 81%  perf-profile.children.cycles-pp.lookup_fast
      0.60 ±111%      +1.5        2.07 ± 25%  perf-profile.children.cycles-pp.walk_component
      0.77 ± 88%      +2.2        3.01 ± 33%  perf-profile.children.cycles-pp.link_path_walk
      1.53 ± 74%      +4.2        5.74 ± 58%  perf-profile.children.cycles-pp.__handle_mm_fault
      1.92 ± 74%      +4.5        6.46 ± 40%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.58 ± 74%      +4.6        6.13 ± 52%  perf-profile.children.cycles-pp.handle_mm_fault
      1.92 ± 74%      +4.6        6.51 ± 39%  perf-profile.children.cycles-pp.exc_page_fault
      1.96 ± 75%      +5.3        7.22 ± 39%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.04 ±223%      +0.6        0.69 ± 48%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.31 ±141%      +0.7        1.02 ± 25%  perf-profile.self.cycles-pp.zap_present_ptes
      0.12 ±150%      +1.2        1.29 ± 45%  perf-profile.self.cycles-pp.ktime_get
      0.84 ± 98%      +1.3        2.10 ± 17%  perf-profile.self.cycles-pp._raw_spin_lock
   1458020           -31.4%     999894 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
   1335243           -31.5%     914846 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.61 ± 23%     +49.0%       0.91 ± 34%  sched_debug.cfs_rq:/.h_nr_queued.stddev
   1428441 ±  6%     -44.3%     795691 ± 44%  sched_debug.cfs_rq:/.left_deadline.max
    198879 ± 18%     -38.9%     121555 ± 48%  sched_debug.cfs_rq:/.left_deadline.stddev
   1428352 ±  6%     -44.3%     795639 ± 44%  sched_debug.cfs_rq:/.left_vruntime.max
    198866 ± 18%     -38.9%     121547 ± 48%  sched_debug.cfs_rq:/.left_vruntime.stddev
   1458020           -31.4%     999894 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
   1335243           -31.5%     914846 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
   1428352 ±  6%     -44.3%     795639 ± 44%  sched_debug.cfs_rq:/.right_vruntime.max
    198866 ± 18%     -38.9%     121547 ± 48%  sched_debug.cfs_rq:/.right_vruntime.stddev
    142.08 ± 23%     +42.8%     202.83 ± 14%  sched_debug.cfs_rq:/.runnable_avg.min
    147.33 ± 21%     +41.8%     208.92 ±  6%  sched_debug.cfs_rq:/.util_avg.min
    322.73 ±  9%     -17.1%     267.44 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
    388303 ±  2%     +51.7%     589066 ±  4%  sched_debug.cpu.avg_idle.avg
    661789 ± 11%    +152.6%    1672006 ±  3%  sched_debug.cpu.avg_idle.max
    151173 ±  6%    +114.9%     324892 ±  8%  sched_debug.cpu.avg_idle.stddev
    392290 ± 10%     -44.0%     219613 ± 21%  sched_debug.cpu.curr->pid.avg
    631181           -26.0%     467219        sched_debug.cpu.curr->pid.max
    302713 ±  2%     -24.8%     227699 ±  2%  sched_debug.cpu.curr->pid.stddev
    501647          +103.6%    1021336 ±  5%  sched_debug.cpu.max_idle_balance_cost.avg
    575980 ± 10%    +158.5%    1488876        sched_debug.cpu.max_idle_balance_cost.max
     10437 ± 76%   +3252.4%     349893 ±  5%  sched_debug.cpu.max_idle_balance_cost.stddev
    310053 ±  2%     -40.3%     185018        sched_debug.cpu.nr_switches.avg
    336326           -40.1%     201480 ±  4%  sched_debug.cpu.nr_switches.max
    284218 ±  2%     -39.7%     171324 ±  2%  sched_debug.cpu.nr_switches.min
     11002 ±  8%     -58.5%       4569 ± 14%  sched_debug.cpu.nr_switches.stddev
     28877 ± 23%     -97.4%     755.50 ± 20%  sched_debug.cpu.nr_uninterruptible.max
    -36786           -98.4%    -578.42        sched_debug.cpu.nr_uninterruptible.min
     17077 ± 10%     -98.4%     268.08 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


