Return-Path: <linux-kernel+bounces-802028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78334B44CE0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A79DA0776F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FEF2773CA;
	Fri,  5 Sep 2025 04:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjA91HcT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCE32727F9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 04:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047500; cv=fail; b=shCGn/rgPrzdQprBqByTIro23dskQ+2jHjdCmtS/emFAodG1aGa09uKgHGmUOOuDGves5ZfXAJTA0iugTUVx9LxphZ9hn6rRV0HtH9u6W5UkAMRXjIHHBZcXRcD1m4e7wFGUg+8srqFAIjCuodZduRoAV+IyYpHGOW+bCpc9pek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047500; c=relaxed/simple;
	bh=kegFDI4tWgqu234IM+pmJFJXA8Qb2hbASzeeen1KUPs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Byg61gZDkK3X31Ek2NcqUrBODJxXXuAUDGA/h6lkX9mbNbNP3Z6s5iOK1LVJRZDyDZkYhviA90eLT/83x5+vkT4EcHcUkA8URJ7fB3mDqIVxuhfoU/bmKYA2hPxwmnHL3TgWVxedpEtEvT1vfvy1A0V9A9Kt8r6GvPY9i6kBX04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjA91HcT; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757047497; x=1788583497;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kegFDI4tWgqu234IM+pmJFJXA8Qb2hbASzeeen1KUPs=;
  b=EjA91HcTacP7JAl36L9nCG3lxNJuVTcy+v6Quo/ljutI4I17gPz/Mu9U
   a7USOvnhkyTBkP/374zT7ucJqWtG9rZAeiIKCs/RYFotLNyJFeE8w3Yam
   ALxIl81/kA8i7Ka+b6EF35lawUONpvZzuzwrpQ3bD68H+elyuTxoxcXLr
   +gayCrwG/BvacdiSeiYzHHqAs0Yzi6H8p3kIPR6moT8tte7QEbMyk3Bj7
   lbhbTANOxYKfdtJHDo9jbqhrGKRT68XG5mNp5u25AkuZ+BdIVItZO1uqs
   MtpvS4Ah5FEXBe4EDsbg3cgUw63mN707+nUc3p3QFBTtWyfjs+VsNPrVc
   Q==;
X-CSE-ConnectionGUID: wlsTEeWRQmaDjKPUhLO1bA==
X-CSE-MsgGUID: RHbNOyqHSUq/PKIS9ZJvNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59543717"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="59543717"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 21:44:56 -0700
X-CSE-ConnectionGUID: gYiuHdu6Tf2rD7iqKzUmAw==
X-CSE-MsgGUID: 3FtwsJuxTq6qDmA2OaLgpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="171365330"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 21:44:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 21:44:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 21:44:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.87) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 21:44:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFlarPFVApgYqj1KYET2cwJTn26OuS0AWUG0W6tbjW7qD6Nv76bCXBub3qwcs7aQn680VLa0RBkQF+KhGw/b+XjFEL5rxhPdTzfZ9nAg2yYeu++SAy6SrwPe79l7mMm5s3PFh1HarM/mDK98DOWQIAnTKW87pJsGIqaLnBQo5+77rFWjI3xfMO+3zQcwQ3jKjqBOfuSvjA7tWWspl99WdEvR7xq6E4WPjwcZl32JtmyiYRL1WLuQMydutzr8G1Kt5qfkFTbblDFSSh3Jwz+Tp61cp/y2ED6rcLfw3k3dByMBoC3pmfeRWmlAxgVBTB1KXiynPwuIOzd5bTAFRajsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwALnbwZfR+Uxqws+0+zWheoqoDDlt4nvpTXtd9sTTY=;
 b=CiMEHb8ZNVSlTzYgfhyYEoRInq8ufgROGlpW6fCjTwnJuFmezrkF+VK/rbrULtCgqcxEq1R0BDmcJZiC03fU0K7+LVKHa01iPbIMZ3L9Xj0CCxmuOuTRpkBPOsGisce9gDeq3kRKZC7RHHBWMX2jO7EICEcLfXqYx8XCMmHp2qsKw7B0K7Gi/bczZ/lxtggbR6bZF3H94BFKJ3RTvjB9nCd/i2hcNbOzdfSN/vOSV4xvuYUKeP4WR2hl3oZbBqXQJaG3Eyf6rlHRM3BGwlv0Wb8cvjaQEKe5gNuYFIrtTW4BtHiaRR/PviQOQ/wmlBMYc1ofO8mfN0HAgd0qD5/kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7542.namprd11.prod.outlook.com (2603:10b6:510:28b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 04:44:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 04:44:51 +0000
Date: Fri, 5 Sep 2025 12:44:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: John Ogness <john.ogness@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Petr Mladek <pmladek@suse.com>, <oliver.sang@intel.com>
Subject: [linus:master] [printk]  c158834b22:
 WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]swapper_is_trying_to_acquire_lock:at:console_lock_spinning_enable_but_task_is_already_holding_lock:at:__report_bad_irq
Message-ID: <202509051142.70d9ca69-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: a39bad63-5ca7-4bcb-3974-08ddec36f32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T2VORBym0B4pkBcpCbw4Yj4VJHwE8KfZ/zCKIT4NQK+BVfbXeOaWN+J5TgWh?=
 =?us-ascii?Q?CDLTprfh6eCMWr8VWKrQUgUHOVOsvhfdxeWOzIOiimrD7b04ceKKdyeB43Ek?=
 =?us-ascii?Q?Tsw3qRSTwytrySPAB+BBuNv+Me9kJLQTct7nWyp5OtT6cHGUxAPv5j1y0GKO?=
 =?us-ascii?Q?M783TPbo5OsO47ymCB37LGlJ2qTqSH6ja0fLtgol+bJM5vKymMoekpZXiwuw?=
 =?us-ascii?Q?f5o4/q3dL58sc+RYv4Ognj6RmktXhUiYr7BJeG0m3ZZjzvmt28XUYwpDKD9x?=
 =?us-ascii?Q?lb+c2LobRADjNsnAE1NDaVV4JbGr2ADUQkBjdj/eIm9Nd3ICmKpaxPf6fE+6?=
 =?us-ascii?Q?iDqZO/Mdrt/0oFhvSSWZWiObo9fnCP/ONW4dL0b/I3kxaZ5oQWK+gbrceePa?=
 =?us-ascii?Q?jTbpeyGLJPtQXjFvd185W+nSw7omWrjwWdvXKC/oIvRlVImqyRq5wwgd1dlV?=
 =?us-ascii?Q?WNLgrEkB+CAgudkw/UDJ09iaD7MM6wOvmE0xeReutiYWyCfr+Kib0fZtCkc8?=
 =?us-ascii?Q?WurQ9VIc6CdREMiUscIrbbbgLgYxmUAsqZBWPMSsZdv2XQX22UmNjZdX+rrE?=
 =?us-ascii?Q?8H+TGJ9gRpg5Bzj+04H/rZhqy+uGeGKSrNkhpTNNpyAaVm9d34g5OD9V/kWQ?=
 =?us-ascii?Q?fGlQYJ7/WxCVO8BgbTlmXkyVw1+CRUKn/tYqEBsG2vG19R8dWCNmBgyq7/s/?=
 =?us-ascii?Q?aK0tS2BtqoJ/aU+M57py6DK64NH4Fbji6uR0/IeZofpGUrspHSIWMZkABg3f?=
 =?us-ascii?Q?ZHlDp9Wi8AEb7zIVJO5+glpC9dIIqeNo9+jISZUeF3OYW/aq8DYiS/+2r20v?=
 =?us-ascii?Q?OCPBRjUYAWGiRD4ZuEMNclnozBV9J9/8t5um/I2+4ZLxlblhlDoJivG9Gvpl?=
 =?us-ascii?Q?+Pr23iaQE3v8a8kaYAFcHnAS/ZJ34iwAzD9nfe0hSQ0TU32fQ2X6l0Rj48b7?=
 =?us-ascii?Q?ELlWljJ/He7mQav4gU54L6aCs5v5nsFV896iN164Ig4fg2Uh201SrMtgrNFV?=
 =?us-ascii?Q?6U6TTDsEbWZAlG4AfG6pqBDsOYiM1TiA/9OxnTZpX4allnvBvQ4OFK8rlDLE?=
 =?us-ascii?Q?2D3TqlBJHGP7KGWQTLCJVr7ezTYNWqs7WknEewXnbI6Gwd2Y/eSXEo+Y0uUL?=
 =?us-ascii?Q?N0GW5tAkMisHDYusCPFGOBkrHFAQ6uxCTF7K7JWoq/AnGkepIb/oLzSVN2rY?=
 =?us-ascii?Q?SaJO+vdLXxdyi/z9kCEatviLCUNTBwxeTFM6rtJwV707CD2yxC5bF5Syen9Z?=
 =?us-ascii?Q?1sMVeBEgc4PIk2Gy33AXoky4HR4IgACvOTdybYSld6i8YfRhlEVtWj75z/+2?=
 =?us-ascii?Q?1b65Nvb2QHiJNu/otdz1tn2R+pehaPg8GaebEjKBE5cvf2/lilon+b/1jdsG?=
 =?us-ascii?Q?AsB6HuC4GegcOkJ6A+Bjzuy6GzHs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?65UKu737/PZbJ1Cq2I4lc/VPC02FsN/A/qs0hnSVuu/3sXpINh7+UO2AU88P?=
 =?us-ascii?Q?cYf5Ntk5uT3kGsnJIs2t4gPpH5686G5lFM8cq5afykLCV46tAZKTCdpsPraa?=
 =?us-ascii?Q?xBWgD9Zur9cNttsxI9epEgfYQLV2msAlQtYIpEJGCUCxTgL5YAiQJOZoxVIf?=
 =?us-ascii?Q?tGo90okOSEzS98w6wNGxEwHFNS+pFXcU0E3hUYlRH7S5f40g8KfSYlcQiJUg?=
 =?us-ascii?Q?iupBXnMNOLSg/J2kmbQ5Xys7aUJnV/1AC8PyLIyF/EjxD5yBfot5NfXcc9xA?=
 =?us-ascii?Q?SEBoOoM5fTpTjG9e/z6hhrxKXyrCDmL9FscBk/UdY8Dq8FFCLdN+cMD4fbFI?=
 =?us-ascii?Q?okthRApXmzUp97EYSchw1afhCSewFt6QrV/hTGjrmZyATcNanI9m9qxqiH2H?=
 =?us-ascii?Q?dqHU+EpgMs42jST+5mF5CHoPVLVv0qX/41dsGRpvvKErTtV5Swb+M2ZVMSKK?=
 =?us-ascii?Q?ugEwxJw3TJETlI8EE2rc5I0nHP3f901/x4+m1W7Lv8/EgXN20N+ZHzwUgQmw?=
 =?us-ascii?Q?rXZ5hOPieWnohaNqzhdBHPp1nhqm4CjQe6Weapg/s2u5eX3Mps4M73Dfrm8L?=
 =?us-ascii?Q?vIDt2jItXYh59KxiFLCOI2jcWs0WtyNm8G+rIazs2bIr52KQQpiVvJF5VtpO?=
 =?us-ascii?Q?sgzmQT8uA47whMtF/zZuMtLXTit2faS+XZjpkpmR/snV5AXNdHC80AwEUdyl?=
 =?us-ascii?Q?Yo2C8wK/KJNud5PJ3g+Iauy9bHWJInRVL8or+qaSmN9BzKJwfHFe50aVbCiR?=
 =?us-ascii?Q?L54q9qm7oWnX+5zuwE1aWkvHPF4B1BIuKzjHGY5BMYwgu3YqN0UOTb8JCa+V?=
 =?us-ascii?Q?xbORnr7szCn/OZFxcSQd71HMcIlOWCFh97GmB0vX9EZU+7ttCdz0R0qt6WBW?=
 =?us-ascii?Q?oMU1Rg+ydIK3BuzboN7hB4yoXhhm9Y+LDJjCb8E8b7UsTOujqpWTyejnEvZ4?=
 =?us-ascii?Q?FTmVv5D8hm4Xk+nLzuGOq1dNZ1ec4y8gI/RuaoqbTSvx2hftoTo+z3ho34cp?=
 =?us-ascii?Q?Kv/EtZhufw2LVAPtjdud2rVmTNFiuB0pKzpAUaqQFH/FvGeiBvfJmky/urbz?=
 =?us-ascii?Q?S1W2BVyTOaaVx7kO7KIofxruZs1KVLtjCR4OdeIn7AThIQ2J8BmiyYEYabcr?=
 =?us-ascii?Q?l0G08Sg2IHkBeg97su0TeELWm7Lw4dVvVI1gZGbRdFCY3pQsGPLhUhPqrLqP?=
 =?us-ascii?Q?NpqQHVZYOGNf1kaR3olqMHA4SUJ7m0BqN/2lop6FLp2OaTpJjm6+sC0YoqQ3?=
 =?us-ascii?Q?wOIeSgCz4wucbRkaEzJ72p6szBwbiCMwU5tPJBcR636REFq9gRDbDx0cpqvo?=
 =?us-ascii?Q?psoBoONBJQBtrpujVC5gAKZSeN9DcR5Xj8StkjHuZ2U/BvyhW8Hso2d2KX+D?=
 =?us-ascii?Q?stB2dDyQ9VtX/ueCtIUxSC8UxcvATL7DRi5IqsqX76Vtw9ghVyYfUuHufSof?=
 =?us-ascii?Q?n3fin7O5c+Exb+BEodnPyYiSmw9WfGfjETGSny1lJOknk7A4GG3LWhVOpZxp?=
 =?us-ascii?Q?8OFhF3ZGcCfHY89Zlqu11kmkqkrW4sHjNO4oeCGz6JETzlZwy+q6BNAuoYud?=
 =?us-ascii?Q?sWlu4voOD8UCqMwL5x4kbj5QcnoxJITkTwxH5zUFcrPSqVi1cAgJUNWDMi1x?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a39bad63-5ca7-4bcb-3974-08ddec36f32e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 04:44:51.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rATLtlHaNGPT6bZOprP+54Q0ON/YMZDQbEubjvG/yjTMqbW1v5buk2IH2bY87CRRXkgl6UpW2I4H++69pNWmMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7542
X-OriginatorOrg: intel.com



Hello,

as we understand, the possible_circular_locking_dependency_detected issue is
not caused by this commit, but has different Call Trace now.

we just make out report FYI what's the WARNING we observed and how it changes
in our tests.


97ea9bccfcbe4c97 c158834b223fbfab3a14855ac20
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:12           0%           6:12    dmesg.WARNING:possible_circular_locking_dependency_detected
          1:12          -8%            :12    dmesg.WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]perf_is_trying_to_acquire_lock:at:console_flush_all_but_task_is_already_holding_lock:at:__report_bad_irq
           :12          17%           2:12    dmesg.WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]perf_is_trying_to_acquire_lock:at:console_lock_spinning_enable_but_task_is_already_holding_lock:at:__report_bad_irq
          5:12         -42%            :12    dmesg.WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]swapper_is_trying_to_acquire_lock:at:console_flush_all_but_task_is_already_holding_lock:at:__report_bad_irq
           :12          33%           4:12    dmesg.WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]swapper_is_trying_to_acquire_lock:at:console_lock_spinning_enable_but_task_is_already_holding_lock:at:__report_bad_irq


below full report FYI.


kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected_kern:warn:[#]swapper_is_trying_to_acquire_lock:at:console_lock_spinning_enable_but_task_is_already_holding_lock:at:__report_bad_irq" on:

commit: c158834b223fbfab3a14855ac203b8d9cddbbefd ("printk: nbcon: Use nbcon consoles in console_flush_all()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master d69eb204c255c35abd9e8cb621484e8074c75eaa]
[test failed on linux-next/master 4ac65880ebca1b68495bd8704263b26c050ac010]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-01



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509051142.70d9ca69-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250905/202509051142.70d9ca69-lkp@intel.com


kern  :warn  : [  429.466465] ======================================================
kern  :warn  : [  429.466466] WARNING: possible circular locking dependency detected
kern  :warn  : [  429.466467] 6.11.0-rc4-00024-gc158834b223f #1 Not tainted
kern  :warn  : [  429.466469] ------------------------------------------------------
kern  :warn  : [  429.466470] swapper/17/0 is trying to acquire lock:
kern  :warn  : [  429.466472] ffffffff843933c0 (console_owner){-...}-{0:0}, at: console_lock_spinning_enable+0x5b/0x80
kern  :warn  : [  429.466480] 
                              but task is already holding lock:
kern  :warn  : [  429.466480] ffff8881014fe8c0 (&irq_desc_lock_class){-.-.}-{2:2}, at: __report_bad_irq+0x4f/0xe0
kern  :warn  : [  429.466487] 
                              which lock already depends on the new lock.

kern  :warn  : [  429.466487] 
                              the existing dependency chain (in reverse order) is:
kern  :warn  : [  429.466488] 
                              -> #2 (&irq_desc_lock_class){-.-.}-{2:2}:
kern  :warn  : [  429.466492]        __lock_acquire+0x760/0xf10
kern  :warn  : [  429.466495]        lock_acquire+0x148/0x3e0
kern  :warn  : [  429.466497]        _raw_spin_lock_irqsave+0x38/0x60
kern  :warn  : [  429.466500]        __irq_get_desc_lock+0x60/0xc0
kern  :warn  : [  429.466502]        __disable_irq_nosync+0x6a/0xf0
kern  :warn  : [  429.466505]        disable_hardirq+0xe/0x70
kern  :warn  : [  429.466507]        e1000_netpoll+0x10e/0x210
kern  :warn  : [  429.466511]        netpoll_poll_dev+0x162/0x210
kern  :warn  : [  429.466515]        __netpoll_send_skb+0x2a0/0x3c0
kern  :warn  : [  429.466518]        write_msg+0x11e/0x160 [netconsole]
kern  :warn  : [  429.466524]        console_flush_all+0x534/0x640
kern  :warn  : [  429.466526]        console_unlock+0x88/0x190
kern  :warn  : [  429.466528]        vprintk_emit+0x1aa/0x1e0
kern  :warn  : [  429.466530]        _printk+0xb3/0xe0
kern  :warn  : [  429.466534]        register_console+0x610/0x7e0
kern  :warn  : [  429.466536]        dns_resolver_preparse+0xfe/0x760 [dns_resolver]
kern  :warn  : [  429.466542]        do_one_initcall+0xc2/0x400
kern  :warn  : [  429.466545]        do_init_module+0x13a/0x3e0
kern  :warn  : [  429.466548]        init_module_from_file+0xcf/0x130
kern  :warn  : [  429.466551]        idempotent_init_module+0x1b7/0x480
kern  :warn  : [  429.466553]        __x64_sys_finit_module+0x78/0xd0
kern  :warn  : [  429.466555]        do_syscall_64+0x8c/0x170
kern  :warn  : [  429.466558]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
kern  :warn  : [  429.466562] 
                              -> #1 (target_list_lock){-...}-{2:2}:
kern  :warn  : [  429.466565]        __lock_acquire+0x760/0xf10
kern  :warn  : [  429.466567]        lock_acquire+0x148/0x3e0
kern  :warn  : [  429.466570]        _raw_spin_lock_irqsave+0x38/0x60
kern  :warn  : [  429.466572]        write_msg+0x5c/0x160 [netconsole]
kern  :warn  : [  429.466577]        console_flush_all+0x534/0x640
kern  :warn  : [  429.466579]        console_unlock+0x88/0x190
kern  :warn  : [  429.466581]        vprintk_emit+0x1aa/0x1e0
kern  :warn  : [  429.466583]        _printk+0xb3/0xe0
kern  :warn  : [  429.466586]        register_console+0x610/0x7e0
kern  :warn  : [  429.466588]        dns_resolver_preparse+0xfe/0x760 [dns_resolver]
kern  :warn  : [  429.466592]        do_one_initcall+0xc2/0x400
kern  :warn  : [  429.466595]        do_init_module+0x13a/0x3e0
kern  :warn  : [  429.466597]        init_module_from_file+0xcf/0x130
kern  :warn  : [  429.466599]        idempotent_init_module+0x1b7/0x480
kern  :warn  : [  429.466601]        __x64_sys_finit_module+0x78/0xd0
kern  :warn  : [  429.466604]        do_syscall_64+0x8c/0x170
kern  :warn  : [  429.466606]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
kern  :warn  : [  429.466609] 
                              -> #0 (console_owner){-...}-{0:0}:
kern  :warn  : [  429.466612]        check_prev_add+0x1b1/0x1270
kern  :warn  : [  429.466614]        validate_chain+0x69e/0x780
kern  :warn  : [  429.466616]        __lock_acquire+0x760/0xf10
kern  :warn  : [  429.466618]        lock_acquire+0x148/0x3e0
kern  :warn  : [  429.466621]        console_lock_spinning_enable+0x77/0x80
kern  :warn  : [  429.466623]        console_flush_all+0x3a8/0x640
kern  :warn  : [  429.466625]        console_unlock+0x88/0x190
kern  :warn  : [  429.466627]        vprintk_emit+0x1aa/0x1e0
kern  :warn  : [  429.466629]        _printk+0xb3/0xe0
kern  :warn  : [  429.466632]        __report_bad_irq+0xab/0xe0
kern  :warn  : [  429.466635]        note_interrupt+0x3e4/0x450
kern  :warn  : [  429.466637]        handle_irq_event+0xaf/0xc0
kern  :warn  : [  429.466639]        handle_fasteoi_irq+0xe2/0x3c0
kern  :warn  : [  429.466641]        __common_interrupt+0x50/0xf0
kern  :warn  : [  429.466643]        common_interrupt+0x7a/0xa0
kern  :warn  : [  429.466646]        asm_common_interrupt+0x22/0x40
kern  :warn  : [  429.466649]        cpuidle_enter_state+0xd2/0x320
kern  :warn  : [  429.466652]        cpuidle_enter+0x3c/0x60
kern  :warn  : [  429.466654]        cpuidle_idle_call+0x166/0x1e0
kern  :warn  : [  429.466657]        do_idle+0xbc/0x130
kern  :warn  : [  429.466660]        cpu_startup_entry+0x2f/0x40
kern  :warn  : [  429.466663]        start_secondary+0x1a4/0x1d0
kern  :warn  : [  429.466666]        common_startup_64+0x13e/0x141
kern  :warn  : [  429.466669] 
                              other info that might help us debug this:

kern  :warn  : [  429.466670] Chain exists of:
                                console_owner --> target_list_lock --> &irq_desc_lock_class

kern  :warn  : [  429.466674]  Possible unsafe locking scenario:

kern  :warn  : [  429.466675]        CPU0                    CPU1
kern  :warn  : [  429.466675]        ----                    ----
kern  :warn  : [  429.466676]   lock(&irq_desc_lock_class);
kern  :warn  : [  429.466678]                                lock(target_list_lock);
kern  :warn  : [  429.466680]                                lock(&irq_desc_lock_class);
kern  :warn  : [  429.466682]   lock(console_owner);
kern  :warn  : [  429.466683] 
                               *** DEADLOCK ***

kern  :warn  : [  429.466684] 3 locks held by swapper/17/0:
kern  :warn  : [  429.466685]  #0: ffff8881014fe8c0 (&irq_desc_lock_class){-.-.}-{2:2}, at: __report_bad_irq+0x4f/0xe0
kern  :warn  : [  429.466692]  #1: ffffffff84a93a20 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x171/0x1e0
kern  :warn  : [  429.466697]  #2: ffffffff84a93a90 (console_srcu){....}-{0:0}, at: console_flush_all+0x9d/0x640
kern  :warn  : [  429.466703] 
                              stack backtrace:
kern  :warn  : [  429.466704] CPU: 17 UID: 0 PID: 0 Comm: swapper/17 Not tainted 6.11.0-rc4-00024-gc158834b223f #1
kern  :warn  : [  429.466707] Hardware name: Intel Corporation CometLake Client Platform/CometLake S UDIMM (ERB/CRB), BIOS CMLSFWR1.R00.2212.D00.2104290922 04/29/2021
kern  :warn  : [  429.466708] Call Trace:
kern  :warn  : [  429.466710]  <IRQ>
kern  :warn  : [  429.466711]  dump_stack_lvl+0x62/0x90
kern  :warn  : [  429.466716]  check_noncircular+0x24d/0x290
kern  :warn  : [  429.466719]  ? __pfx_check_noncircular+0x10/0x10
kern  :warn  : [  429.466723]  ? jhash+0x1dc/0x250
kern  :warn  : [  429.466728]  ? __list_add_valid_or_report+0x33/0xc0
kern  :warn  : [  429.466732]  ? add_chain_block+0x2dc/0x300
kern  :warn  : [  429.466737]  check_prev_add+0x1b1/0x1270
kern  :warn  : [  429.466742]  validate_chain+0x69e/0x780
kern  :warn  : [  429.466747]  ? __pfx_validate_chain+0x10/0x10
kern  :warn  : [  429.466750]  ? mark_lock+0x8f/0x520
kern  :warn  : [  429.466754]  __lock_acquire+0x760/0xf10
kern  :warn  : [  429.466760]  lock_acquire+0x148/0x3e0
kern  :warn  : [  429.466763]  ? console_lock_spinning_enable+0x5b/0x80
kern  :warn  : [  429.466767]  ? __pfx_lock_acquire+0x10/0x10
kern  :warn  : [  429.466770]  ? do_raw_spin_lock+0x10f/0x1b0
kern  :warn  : [  429.466774]  ? __pfx_do_raw_spin_lock+0x10/0x10
kern  :warn  : [  429.466777]  ? console_lock_spinning_enable+0x54/0x80
kern  :warn  : [  429.466781]  console_lock_spinning_enable+0x77/0x80
kern  :warn  : [  429.466784]  ? console_lock_spinning_enable+0x5b/0x80
kern  :warn  : [  429.466786]  console_flush_all+0x3a8/0x640
kern  :warn  : [  429.466789]  ? console_flush_all+0x9d/0x640
kern  :warn  : [  429.466792]  ? __pfx_console_flush_all+0x10/0x10
kern  :warn  : [  429.466796]  ? __pfx_lock_acquire+0x10/0x10
kern  :warn  : [  429.466798]  ? __pfx_do_raw_spin_lock+0x10/0x10
kern  :warn  : [  429.466803]  console_unlock+0x88/0x190
kern  :warn  : [  429.466805]  ? __pfx_console_unlock+0x10/0x10
kern  :warn  : [  429.466808]  ? do_raw_spin_unlock+0x83/0xf0
kern  :warn  : [  429.466812]  ? __down_trylock_console_sem+0x82/0x90
kern  :warn  : [  429.466815]  ? vprintk_emit+0x171/0x1e0
kern  :warn  : [  429.466818]  vprintk_emit+0x1aa/0x1e0
kern  :warn  : [  429.466865]  _printk+0xb3/0xe0
kern  :warn  : [  429.466868]  ? __pfx__printk+0x10/0x10
kern  :warn  : [  429.466872]  ? common_startup_64+0x13e/0x141
kern  :warn  : [  429.466876]  ? irq_work_claim+0x1e/0x40
kern  :warn  : [  429.466896]  __report_bad_irq+0xab/0xe0
kern  :warn  : [  429.466900]  note_interrupt+0x3e4/0x450
kern  :warn  : [  429.466904]  handle_irq_event+0xaf/0xc0
kern  :warn  : [  429.466907]  handle_fasteoi_irq+0xe2/0x3c0
kern  :warn  : [  429.466911]  __common_interrupt+0x50/0xf0
kern  :warn  : [  429.466914]  common_interrupt+0x7a/0xa0
kern  :warn  : [  429.466917]  </IRQ>
kern  :warn  : [  429.466918]  <TASK>
kern  :warn  : [  429.466919]  asm_common_interrupt+0x22/0x40
kern  :warn  : [  429.466923] RIP: 0010:cpuidle_enter_state+0xd2/0x320
kern  :warn  : [  429.466926] Code: bf ff ff ff ff 49 89 c5 e8 1b 72 9d ff 31 ff e8 b4 89 8b fe 45 84 ff 0f 85 c6 01 00 00 e8 f6 6d 9d ff 84 c0 0f 84 ae 01 00 00 <45> 85 e4 0f 88 2d 01 00 00 4d 63 f4 4c 89 ef 4d 6b fe 68 49 01 ef
kern  :warn  : [  429.466928] RSP: 0018:ffff8881010bfda8 EFLAGS: 00000202
kern  :warn  : [  429.466931] RAX: 000000000066853b RBX: ffffe8ffffc82478 RCX: dffffc0000000000
kern  :warn  : [  429.466933] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff829457d5
kern  :warn  : [  429.466934] RBP: ffffffff84f2b840 R08: 0000000000000001 R09: 0000000000000001
kern  :warn  : [  429.466936] R10: ffffffff854630e7 R11: 0000000000000000 R12: 0000000000000003
kern  :warn  : [  429.466938] R13: 00000063f11b8143 R14: 0000000000000003 R15: 0000000000000000
kern  :warn  : [  429.466942]  ? cpuidle_enter_state+0x285/0x320
kern  :warn  : [  429.466945]  ? cpuidle_enter_state+0x285/0x320
kern  :warn  : [  429.466950]  cpuidle_enter+0x3c/0x60
kern  :warn  : [  429.466953]  cpuidle_idle_call+0x166/0x1e0
kern  :warn  : [  429.466957]  ? __pfx_cpuidle_idle_call+0x10/0x10
kern  :warn  : [  429.466960]  ? mark_held_locks+0x24/0x90
kern  :warn  : [  429.466963]  ? tsc_verify_tsc_adjust+0x77/0x170
kern  :warn  : [  429.466967]  do_idle+0xbc/0x130
kern  :warn  : [  429.466971]  cpu_startup_entry+0x2f/0x40
kern  :warn  : [  429.466974]  start_secondary+0x1a4/0x1d0
kern  :warn  : [  429.466978]  ? __pfx_start_secondary+0x10/0x10
kern  :warn  : [  429.466981]  ? startup_64_load_idt+0x93/0xc0
kern  :warn  : [  429.466985]  common_startup_64+0x13e/0x141
kern  :warn  : [  429.466992]  </TASK>


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


