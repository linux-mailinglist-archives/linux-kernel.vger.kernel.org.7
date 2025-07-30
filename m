Return-Path: <linux-kernel+bounces-750119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D4AB15780
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362AC17DFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96C153598;
	Wed, 30 Jul 2025 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2/gZacP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7C17BBF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753842032; cv=fail; b=h77feCP4PAq5jzelCFWNXqf1KDTchtdYgBcCSJQeIPwB/HhnulfxlEFYKsasiEOq896pVINmnXwhH3zrH8zgvjp27fE3NL6pA+w46d5w+0I0j4ubXkXyNA0sDmSE8xOQdQTkcjCPm11t5UtFz5WaeLX/fzq19z2IvMat6YunL+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753842032; c=relaxed/simple;
	bh=7SkmnxE4exAfjbzJuVzklWS3fWx865ToXACzHzx62Ck=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qILA31XFyhPVuaBeNP2Pit8l78PJEm6s9Aja9ztzbugt2t+z/zB7MrI2zxOB1g+FWFmMXxy94/DxoKZjS+Vhy8kU6T8mx0eaUlVYnC23LU6lqPiRWpZCPEkMY6H9Spgn+BGUdcMLiumSDE6+XfN6QSnZvyRuqAfXmt3588nkoWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2/gZacP; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753842029; x=1785378029;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=7SkmnxE4exAfjbzJuVzklWS3fWx865ToXACzHzx62Ck=;
  b=c2/gZacPIP9b/iCqahrSG2jd2alS6dTBb1dORcuS3QWDSECmbFuZvHqx
   bsIeSILd4tmBbXgEP/zVqXYe9PwIBpYGehN2bvt/nzjcmzkDEEkmaJMY/
   3VF9twIYyJ7ZVMFBFVIjA9CcEVQPn5vGKv0zwwINlrw2qnI+gB3BRVVc/
   3VaaOLoXTcc3gM/B65xJuTzK1JnRiZTzI+FeYcC5fuiAjfkdJ192r1xIG
   CJUfitRe3ueBz7emRcHA8WUc0+1hl5SyVR9uBmvUeeMftFLVo0RFAf2Xs
   7AuwdjAUEQLgm99D90d3qL6fUTqVW1LBYE3NOX6HuYiDZd7fhS6NoL0+Y
   Q==;
X-CSE-ConnectionGUID: dIE/Ox35TkepNIEP1++Gcg==
X-CSE-MsgGUID: kYFGGDU/S7aHIar8HD0SEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="78682699"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="78682699"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 19:20:28 -0700
X-CSE-ConnectionGUID: VfnZOw6jRnykGvwootLx5w==
X-CSE-MsgGUID: lU/lHFXLQH6jmDHXjV1cZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162122401"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 19:20:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 19:20:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 19:20:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 19:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1/94sch/8JU+sIIYV51XSOPlzpxCeeYQykNJrAbNlyRar0QS3T8fG5uymusYrxJ4YMtb5AtC5Pyx4NyqZXQSwb+Y6j3HORemdQh3uG+TTX+DwHka591jIdNbUaa/621XmgrwbA7URJvCkY5W+TcF/VBgWDf/Fi1F67nd3SkKrGwq+9tYUrxUa2Myn3AGRsONd0y3KuX1EmdZiCqjwPiamxq4XqHCyAK79yieCADiBXtKmxSo+gFd6cvIcd9vPH8XboW7/fn5yi/cMOzkXEXOZ5Vrz6fYJ1AbM692OSAd/89NEK2VunhX4mNCw9hn9/khG1DNsTDBZckPOb9muFbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l/wBHbJjEeOOpECJ56CjGpSBvxfZbMALlPhqM5N6zo=;
 b=QuO433Qfvof26RsCxtoEiROZ9cE3gdFKO3Tq4IEatLZgZj9muj1WAJYrccOOBBzZPDupViPUk07E2lQBOpWe8BbQjUqnZ7MlpgkMcnw2u1pXj3NqK216t1tt9qykYemCdOSDDZRO7q4Bt34iCxw4Dg73Cf1T87iYuYwhLH6ksNQMryUzCFvgNwraxBKZkB0RN1xWmiJBsErnlkF2GX9HtQK61dhsiQjmSPgYNmkuAaCLw/DuPxKqyrBLky871WtjTKvOrnSarBqGXDpyf6z3ogiTn/Sm9ob9zEO8sX+4i2EIOe6Pb57rm1H1zG3hqhaY4R2epE+0y1Gy9OoqgKfHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 30 Jul
 2025 02:19:41 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%3]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 02:19:35 +0000
Date: Wed, 30 Jul 2025 10:19:25 +0800
From: kernel test robot <lkp@intel.com>
To: chuguangqing <chuguangqing@inspur.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	chuguangqing <chuguangqing@inspur.com>
Subject: Re: [PATCH 1/1] gpu: drm: fix compilation errors in drm_vram_helper
Message-ID: <aImBLR7RBsWEFWNd@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250729060728.82402-1-chuguangqing@inspur.com>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3124698e-6596-4333-1817-08ddcf0f86a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vz7DPSQ2eqRvwMcRQS/mac70G5744utaax15JPgHdJwhhaqeh7dt9d0gyy9V?=
 =?us-ascii?Q?lOHL4hL+4h1dZVyag7PElf5a6/UGHdfB2Z2SssUtLSJFKrEx2N3VzaMnnXSm?=
 =?us-ascii?Q?04H95K1RDknt8xUQ+hrvtHQuj4Npvb9jcRbLA7VQv3qbOlioQHQ5qcLCsKp8?=
 =?us-ascii?Q?UPcjFWeNCSc1W/g5GXptHUFHjovCJyTomEep4ViJCpKGuLBPRNtG0p8vHyCg?=
 =?us-ascii?Q?Uv6eFJ2DMDrNXa5AbDrIrQDCGSmif3nvskesKI5hKjEKE7FNjLNggtFWrZLI?=
 =?us-ascii?Q?n2Fx5G38m8wK50JzP3PgmKhUsFDh3KjxwuDIpJQCFbHH21dtH5qwX4TQt4M8?=
 =?us-ascii?Q?UJNlaeyEir9LkBfK9pAv0iKVgRGL+m8mscCilHcx9aCtLmgiCkf4Mln2WTl3?=
 =?us-ascii?Q?6Rn80y55AEH0In1xfmQOePHLM0WWXIO5/RE919Dx4Ot90/Yof8TpqrZHSE/S?=
 =?us-ascii?Q?EqpulZre1ojMZBdXsYcQQRVifuEWwEhzmS5HCdIsfZptttThEDvBfez9eJQm?=
 =?us-ascii?Q?/IUzuQCu/vSrh3QH97KXTD0LR6nDArZ8ToJfRD5SjaEXm0sVZjGmpLSbqJ/w?=
 =?us-ascii?Q?PjswffZRtteTqzvSWVbM0vQWApaPX9gPOCY1tUzvu15KYk8cf5EGUjsopfnS?=
 =?us-ascii?Q?QbFm6wZ26VDaYXF+REeuR4N4/ndqicbCzPTlY/EtrJ2xzcHVe8OfIOWQqdTq?=
 =?us-ascii?Q?YJDhJIjtOyvBtVSp33mYePSF19AsPG9tgztsZARr1GnUYxTgejCGZEC81AhV?=
 =?us-ascii?Q?tMUpZ7LvJYQ2eyPnBgdP0sYE+hZ3lZRKnjak8y/dewPsrpNS8C7VIZOv8hRL?=
 =?us-ascii?Q?dTDwHgIkRbmtLAdGeEBi6TXiiK9TGKI3s372XTZRZ3tVx16QlNFvNOaspGiv?=
 =?us-ascii?Q?os1KKTUi78kJoFGQFuBKWH9luxIfJmoar79rAyHhP8bkmTXLdz2CV+D4nwSp?=
 =?us-ascii?Q?DyMutEe/v08yKA33mch5nJ6MA+nNyGBILE/JmF4Uz4t+zOBFV2h6fG/N3/El?=
 =?us-ascii?Q?RtKIIKTPFFVtzw06VEk9pJvo/pjAiqnQA81wuifauJLjeZco2K5AYJy3hxFD?=
 =?us-ascii?Q?ywd8adBGW4SSYBcw3Z2PIgWhtB+fatBfwhSzqhD1hz7CMgQgfEPwhtio2cne?=
 =?us-ascii?Q?LT0bwiDPXwClZ6CQzOsy9OZV3x3z0Bl5XgKwNTZAcIexMzfDCYTl5mbte2z7?=
 =?us-ascii?Q?NjX+NxYKjCU1lbhqex358gf/1tvCc5vROSCHWydllsNhhSAlv0GXr7igXpLF?=
 =?us-ascii?Q?c0aoNswZX0AFhVhDnB8nUjZu6NsuXwDXbfBAWsWLHPEazXl78+7vd2dFyLi1?=
 =?us-ascii?Q?Ll8ccHamhU33zIQLwNS6kgXdiHBdluEcUUuyYqE1LCiFYApxxxf2g/o3NeDe?=
 =?us-ascii?Q?B/gos2OQtL4JWrM3TmQo6kGlqwJo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bMRzDrk8g7oVNMm8OKfbRffhTbfVCRhoRMCoxBY4FJ9ErVC8Wv/WC1DPtGMW?=
 =?us-ascii?Q?lwgifO61JxIF8kfvHa2dh4202KpBaC6bWSh6UfBqZcmc19y6xZKrUXu/lgpT?=
 =?us-ascii?Q?mX2ONtzBzk1R4JtKYT224d+snJDv2cK1nNzK/G4LwWmdyWSqVbrCgLxZtWgd?=
 =?us-ascii?Q?3f7u2S1vtacSORirsaxQQcjbqzCYKHpxR4gyhy3Nq3DRT63J6UVaJjcxTM+g?=
 =?us-ascii?Q?hmbh/RtSHpfC2Pr6iTIYQBfJRivYArqDGrghYqq8WVahUIwefg57Lan5jW7y?=
 =?us-ascii?Q?eVDl6RtMMEXnQ9B77J8u6Y89HjHBhAJfeCdXQ8ayh8NwIlOGfzeY+1HjDYbC?=
 =?us-ascii?Q?hgYCcswa85FhArTXXH/ks/I17dcz5QHy2o+DOtNaN9cLba6PrnblTdh2Cn91?=
 =?us-ascii?Q?4l/CwY2jDJMXdVI52fyVi/QGKxulZwlrLFBCifz8ElaIYSENyAXQHvgfkBgc?=
 =?us-ascii?Q?nZnlPmkCzWmsjZ66TpFUHxj4MyLhqn7/q3yCaid97EAXZKn+hbSHRd1MhUFj?=
 =?us-ascii?Q?Nhew8aj8EPjdEBsSZ0/Z++s//xLSu3Mxk04WDVER6Ut7kKreZ4kae9+Rklo+?=
 =?us-ascii?Q?Pu1iygNbYr71Bez1nbUthmq19wXoS6h5aIiO1uSAAJbL24y53hpnu7djDF9E?=
 =?us-ascii?Q?UPxEp4cuHwD5cAojbUJQVCijm6C7aK2IbFZnPKa1Ngj8WUhfSnSO9wuVEhsA?=
 =?us-ascii?Q?gIWoIJGK7H3Z26MHhKYm+Hg7gsrhldtGkry4HYPNtJvhdHwL+Cxdf2vcUgW/?=
 =?us-ascii?Q?C04qgVKqEFJIh/7x95cRdw7qg8cVRjrdIUJudEIYnhRQ52T16UQ2qTVmJ+cI?=
 =?us-ascii?Q?9j7S2wvznkRe4Gjc6MQYwg287BlaB8x0Mfz2QrGTCPBWKEiltjCFwvNZV88U?=
 =?us-ascii?Q?wCf3cW3YqjQnBVaFcFRseS3YajKm2dPhAa8GPcD31yxuQ2XjY/4YAibmZN0F?=
 =?us-ascii?Q?bc0TSFhvRX8yBVjfaJaT0out7eg86C88lAk9vqIfbc2fxNTp9NYAOyjQ4k/T?=
 =?us-ascii?Q?IjQOWAkmHeOihKuEVZjV92Q8OPEcEss6XyzVJUThYM7cGMdHZDVyLzYqdiGz?=
 =?us-ascii?Q?d1xl2+nzVeBv6QVXOPyY+KmbQ34ih/IEaMEo2qO2uzF414VNsKKlJgDG99wM?=
 =?us-ascii?Q?OEVMs6iqZhg7HZjM3YO03+ldQqjoo/+Fjim4BGLNESb165Y9k1TmilCuICov?=
 =?us-ascii?Q?wIA48kw55exIijdZOsoB6XT8IpBjFWoAjOlXN3Nz0M20cmOMPFjv64fctnR5?=
 =?us-ascii?Q?MuAh5OsGcHydpj5bM5Sz/8J+gjzBVQZ8qyY2WfKvin2Q9aMx+Bu8DXWTZzq/?=
 =?us-ascii?Q?HDZsUQ3IN4s0lc2ZW8izMfXdOXfaNVlluiHlE/zyVkUXkT2TgJFfYRWXpyYR?=
 =?us-ascii?Q?80XLLU26OQKJiNUQKUbhhh5kCiu0Kz7A3WFnAha9V3CcRCTlF5948DCJn8TP?=
 =?us-ascii?Q?2gfylTyZyd9wqPFdNYVCYzoHn+A2ziERP6VdL5DQDEmobxZ/fo62PLbX5Vet?=
 =?us-ascii?Q?Kw8SEBpCPx+68OzwpMGz4WdweO9cMYCc2zzAj6Vso1nbHiT3eBLyGn9SlZ4o?=
 =?us-ascii?Q?FajTbKJUIOkKEsm/oEdZ8ZFKl8A2Fe6Bvqz3RQk7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3124698e-6596-4333-1817-08ddcf0f86a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 02:19:35.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwFJAwNHVG8OnoJxbwUeLTIsAVSa88BAB3zPRyPUGDf2YfK6HLp9IcGI6Td8kepxk6OwWriIKq8oCDLSjYZy1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com

Hi chuguangqing,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on drm-misc/drm-misc-next v6.16 next-20250729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/chuguangqing/gpu-drm-fix-compilation-errors-in-drm_vram_helper/20250729-141222
base:   linus/master
patch link:    https://lore.kernel.org/r/20250729060728.82402-1-chuguangqing%40inspur.com
patch subject: [PATCH 1/1] gpu: drm: fix compilation errors in drm_vram_helper
:::::: branch date: 16 hours ago
:::::: commit date: 16 hours ago
config: s390-randconfig-001-20250730 (https://download.01.org/0day-ci/archive/20250730/202507300646.kTchyjvh-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507300646.kTchyjvh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202507300646.kTchyjvh-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/gpu/drm/drm_gem_ttm_helper: 'drm_gem_ttm_print_info' exported twice. Previous export was in vmlinux
>> ERROR: modpost: drivers/gpu/drm/drm_gem_ttm_helper: 'drm_gem_ttm_vmap' exported twice. Previous export was in vmlinux
>> ERROR: modpost: drivers/gpu/drm/drm_gem_ttm_helper: 'drm_gem_ttm_vunmap' exported twice. Previous export was in vmlinux
>> ERROR: modpost: drivers/gpu/drm/drm_gem_ttm_helper: 'drm_gem_ttm_mmap' exported twice. Previous export was in vmlinux
>> ERROR: modpost: drivers/gpu/drm/drm_gem_ttm_helper: 'drm_gem_ttm_dumb_map_offset' exported twice. Previous export was in vmlinux

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


