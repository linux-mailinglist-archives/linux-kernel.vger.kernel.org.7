Return-Path: <linux-kernel+bounces-865495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7455EBFD5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B4755823CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C426F29B;
	Wed, 22 Oct 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ej1V4T/1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5B26F467;
	Wed, 22 Oct 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150071; cv=fail; b=M6/ZorC4m8fH2tTt4lIPpFHdKAk7FT7RujCuAyEAqr5bK+iilMoNZskU1M59WeK0/e8T/m6DfwitWVhG5S23qdJIw7ZFuB7sF0VzqiVc6BNrKAxO7g+31FIr/8Kha7u621wRr9GCHmLAQxmDDQ6rSnj6MlucICEV1y0Ip6WJiBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150071; c=relaxed/simple;
	bh=JcymA/Q80gj4dWK15vAOnPj7t3NvaqZeLA/v5NlkQWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KXGcf7baOW3NZeUtyfdmLLVVz7SHue6KIRHoZd95T41uNHXiyMrZH2ANPF5ceYQIlpmvfnlcCazP6999JUfYkdbr/gLwjgnh30eEmd4jxOmyWszgGgHcTcbyiT8Uy8E1n0V6iCUz7sDfgOIgKHJeDN9QS7UAwbZPBhCHXUuA7zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ej1V4T/1; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761150070; x=1792686070;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JcymA/Q80gj4dWK15vAOnPj7t3NvaqZeLA/v5NlkQWU=;
  b=Ej1V4T/1lbP8U/GDWklQ1KfLA5VyGQXn7U+0tH7Ue7O4hHusujxV2Oyj
   ITLRRMSzydxRn9Rn5l+63oHgJrSAXnXhDDVIm2whxAzi2u8TMKN5Qt5Kh
   7Wu0kIkCpWQtIgGji+iYKOutrww02Wcoidh3FFUoLfBex0RkVrf3yQw9b
   0jXrkaSJY1qOaStip3yGHKNbylPOiHd3mrEzu3AnxscBqMGfIrJCjkOwL
   uujx/HR0jOauRg3WHHjgd9VWuyBhl/CuC4O7CAisvcLvlDg7NwxuTunYo
   IUFRr7oJZ0IJAq7jggcDXiEuaDgVZ9A4CkBNlh68FZk4e3HaDhrl01AuJ
   g==;
X-CSE-ConnectionGUID: ACPWOdXiSceZqRCAqLrj3w==
X-CSE-MsgGUID: JHIx/tkDSvmOYOuFj/2ndQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85928948"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="85928948"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 09:21:10 -0700
X-CSE-ConnectionGUID: I1H9aBK6R2myJlWRYhTX4w==
X-CSE-MsgGUID: qkOAL1FUTNGvpEkHMMIQPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183964724"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 09:21:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 09:21:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 09:21:08 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 09:21:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAB0jkVOs57I1UcKY88JLIRRENedOyB4+LjwPUlsOOO51ZWTSQSmun2leBdovQKQ4/XJKW3/XQowWO9PpImnpt1rQ9Wk04NieDHLBocxkTrHRL6OS3pmu8X9uxWZ7Q17PxtXXIvPD4/hTvX4ClGY5LQPNQ8fwxBEXwit75LbTPERkS1fCGSZQQTcu4jGhDewlYYm+vh+1lZlnmoYpf4jM2CVIXhl96mwJD8MGb5F4f65T6uvw9eh+XvQrvh8wc/+X+F0VqpouyFfk7jGKKd8u76BP51RXYEKR7l8u2lQ63Ngvn6vJCl3dYiwEoBxE++1L5gSE/3HPG2WX437Ib9wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45uvTp7RJ3Oi7t53zPxRS5CsO4KennLdBnofp/6Wclg=;
 b=G/Q1KTU6EH3q9zVnmKjw9JbnezaBoKMJJxVJtBv5mtmX5O92QyNe0UD6rhM+jkmcZiiDJIjqsNS8idvcgJtJQYvpP8xNAscBg0SXIxDxZCzJoESNrkEI9YGsyT71zQhmc2xFgj0DyK7YA2/g0NSVZjqB00PnOs0PpDagCh20iV/9jFw6o9EuT9iLxXM55Pf6VWGrS/eYy6Kuyi/uamWPLxkN0VT0G8bFVqKQj2uethfvsdPZGWZavOsbVowW6DWKMFT1GIvhKvmqz+WhYQjIBvULRaJCkj4gBYeAa+9Y1plUVpy4Y7iTUOW5eZZ6CZR5kWxPKQy1aB6j03e26jyyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 16:21:05 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:21:05 +0000
Date: Wed, 22 Oct 2025 09:21:03 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>
CC: Reinette Chatre <reinette.chatre@intel.com>,
	<linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aPkEb4CkJHZVDt0V@agluck-desk3>
References: <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
 <aO/CEuyaIyZ5L28d@e133380.arm.com>
 <dd5ba9e5-9809-4792-966a-e35368ab89f0@intel.com>
 <aPJP52jXJvRYAjjV@e133380.arm.com>
 <e788ca62-ec63-4552-978b-9569f369afd5@intel.com>
 <aPZaTk97RC6sg+uQ@e133380.arm.com>
 <aPZj1nDVEYmYytY9@agluck-desk3>
 <aPearyfcnpJJ/e06@e133380.arm.com>
 <aPf0OKwDZ4XbmVRB@agluck-desk3>
 <aPjxAIudLd16aU4Z@e133380.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPjxAIudLd16aU4Z@e133380.arm.com>
X-ClientProxiedBy: SJ0PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::24) To DS7PR11MB6077.namprd11.prod.outlook.com
 (2603:10b6:8:87::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6077:EE_|CY8PR11MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 5519fda7-fdf6-48e8-9d9a-08de11870037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2rmAfmR/xPPGU0quOstiQtlWCwUnrgWc0BqHAInCtVXx4ohKFLVRycxyv4n/?=
 =?us-ascii?Q?Vy+vtoLPeeMstqNoewm6Do2g23uXSAwuQ7BqksUqUUam6VxH05SrgPYWPWLm?=
 =?us-ascii?Q?gb71MTP0kqD8vkpZ8Ihb6ob1Vnnpp0IaTStVTcJkubSa6X37YatHgELBwdCY?=
 =?us-ascii?Q?RraVtL8nPoMIpeA+kDoanpu29KJoVUoQ6Yt7pGyeSwIeQ9LJXEuC2ycWjHHm?=
 =?us-ascii?Q?doO/12r0tNk/At9qkvG26zxGwMxJM3a3cBv+dryy/ze7VhqCYjITCOKz5TrW?=
 =?us-ascii?Q?Kd5Vrkmgb1a87NaxhOuo3mCz9KiIO7pRaAqybgx6MWKkLldYWmsRyMCfwH+4?=
 =?us-ascii?Q?XwgTV7y1eZFez9D/rbJ5jiXxOw68NbAjYt1XOD9GPEXRvmAV9FyymnRDXJG1?=
 =?us-ascii?Q?08GqrnpLRqCsndPi+yoNBRdg3uoxOjnSR/Ng8BVpTiJcr4oUUTIOPm4eydam?=
 =?us-ascii?Q?Ha+FpGNQ61WroSuigupMZS9mXgRCLJYeNu2Xk2hbLKHoJDpLlPcaFHMp4GX1?=
 =?us-ascii?Q?wWwZYOCFm7J0RaqBTHC2zqjxzfKJwUwCbemFgXPkVhQKH/IYHknCPnzh8tHE?=
 =?us-ascii?Q?QualHbTLwPJ2KQ3uq0A50VUUAPhB5hDOd+hXA7q/b4CiM5EocGVEfYpT98xG?=
 =?us-ascii?Q?uokBtxIYAcbm/DG+cck0d+WFXnaJNPBD4NjFtG/b1Z7Ha9ulLPCVF1YG4OQS?=
 =?us-ascii?Q?YQEJE7FMl/A3NY1lht+seX5im93gWYqQ3Ik82oN7bOdC9S4G8vsF8nlTOrWH?=
 =?us-ascii?Q?1BjybrKtutLsGjenvruhdhpK6opOgLhAUrLF9eCpG1rHy/Hm63m09ETvT1WY?=
 =?us-ascii?Q?ot0BAoYH6HBNQWkHRIYSx1UgtVCFDJW0blsLFh+12h0bg5LT8A/xER0RmodV?=
 =?us-ascii?Q?C/AnSUa5gmZaMJxEmgH2/mWf/ZR3K+JR0buKc7zzX8eQhejPiGQuHYXil1pR?=
 =?us-ascii?Q?oIw5zuWg0MRa0yVIuIBg5xPfdYKjVBM6tnV45xg/dvPj9iU+Q5EkxJoaPhif?=
 =?us-ascii?Q?vcZfCmvdMJ7MSI4wufmql8vctdwvehlasbILzzJy7yT0zr6DM4XCrNt926XU?=
 =?us-ascii?Q?vNztQmqlH9LSQDgUZSWdorwEfXFojfHYR9NgT7zf1UlOJBVApOk7RBz3aarx?=
 =?us-ascii?Q?kz+dnL6evc7nDul4wRFs3/wDHQkIjyi8B2rlJRkRep4eGua666SLNYrJ+jQq?=
 =?us-ascii?Q?R6Cr6rSTqpYOstE/zAkjc7UQ0+9KdzsJlznjoZxOFhxSCMzegLlXYyIhWoYq?=
 =?us-ascii?Q?0cAv2iV9JWdQsrcERQUCx9iypFEmSJYzy1vNl+qz8DRnS/7kmpivcFojO7dh?=
 =?us-ascii?Q?z0UzXlni/y0cZ2+oUzzHUP4RcjP6t1DlCv8F8Om3ZoXvTxs9Lgd62/jyZXTm?=
 =?us-ascii?Q?j7EQfAG3lGBGog7EkVpb/Z3F4Td6MDRFFFb3nSPLivpr6z5GwdX18yg1Q2qz?=
 =?us-ascii?Q?vPvb7WHfPYLQ/a1Fd5pgZ35g1H93+i+/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xBVSRDE0YtXc/Sy4lI3uRopomuL/gGvRZaIC2TdyPmJBe7DWeXakRSyFD7QO?=
 =?us-ascii?Q?pYiI/jzpWSsjRgW41whF4Qkz6o6Kvb6r1v6E4aBI/5zwb+2ZW3jemKIVXu6H?=
 =?us-ascii?Q?UPX7vgekMM1Vsi8l8JgS4mDSpiwU1rOq89XAqXKV4QCIZAMwBv/tWiJUw38O?=
 =?us-ascii?Q?WFKliCvtpNqMRiA+k+PUM8L9hsNfgVCdzSon/zBBRIyHKKz6p0V99HFVxBRf?=
 =?us-ascii?Q?rL2OYeCSGo+Se2qfUXa/RBkcKDgfopPv4VowRXtz82oKP7F9XkaqW2QSvM5S?=
 =?us-ascii?Q?vmqYzRIXA+VVE6pD2MGwL3sc34G/b6W5z33toxVWmoucMQNrI4d5/fkX5L9a?=
 =?us-ascii?Q?J03QzylXz3IOrjrXGQO2FKFdDjtcQX9sYFt+/G3AHY9ATjIoe0LiX0Np5RBW?=
 =?us-ascii?Q?LybCayviDoW5dkKye2NKmKFYok/auE9jzGI+sQqSr1GloTcTr3AUtfX1yJ/g?=
 =?us-ascii?Q?Zu1T9cBspbMny7WFQzE+8PQzh/9TVi9Ek6Czq9HG0YE/qZ1LvynJsVF1BJML?=
 =?us-ascii?Q?mbagiXuiiQOgDMRrLjx4PbgGH10WiURpucVPDUUo9GXeoc5koku38uNwhLcq?=
 =?us-ascii?Q?PBFgWYLapziB+fEl4gUEhDsFyTUmzgIcKfNntub1RQI1RbpruVyli5274MdK?=
 =?us-ascii?Q?Jkq1KH4h9FIE9BXdJfOiH0at4XFhvhQtAFbBcMB9EaHlDteN5sepTqlONBme?=
 =?us-ascii?Q?QkoxWrnt+YO2C6WysLScvfDFFKk8Mj6pkVQKnYgah0ig4q5BzRkWyJLXGUL4?=
 =?us-ascii?Q?1YTsBfqMNmCejndDjTN6rzy7RYZkA+aCRZ7ZW6aKYwzLFgBJuRuEUzANAtZf?=
 =?us-ascii?Q?leayBEyuRUpROm8I4tmKYVz5yKcj1mwQtHwTK0Qtqn4NThkjFe6E/qJY+1IW?=
 =?us-ascii?Q?WK2O8P51gNXzYK9FD4mwFDPo+DjWvp0go7wM1baOfu77JZKCZM+adPzabrBF?=
 =?us-ascii?Q?V17ND5f2qaEB4/2dqoJNbcGxRhJMGOdySRGpK3ETu2oSZR36vdt3nk39T6zy?=
 =?us-ascii?Q?0F6nmN4wG3hSc01a0/1hhPgspyfi58iQrQz9pLXQ3AJgXNXCBrcKjF5qgHtH?=
 =?us-ascii?Q?ZLxEr2HAOPKyMW4acYxTIkCwLdDMQ2yY5cXrPzeNvmd1MwStuPNZ7kQotWqh?=
 =?us-ascii?Q?FTSlyxxfLufaZ9NtLG7H27X6kClbI+FP2NGThLkGWrs69Q+ym/yPs/m+kjkZ?=
 =?us-ascii?Q?2MIp6Ywt00oTvkAii+uF6C3gHC+EDB1UiY5V/1+mLs85j4bQtoUbTDWGZr63?=
 =?us-ascii?Q?Yqfn+7WjTRHCTN9RbVvYpT/EwbS1SI5tSZL8uea6QoD/W5kjhRE3e51W6bnz?=
 =?us-ascii?Q?0D3FfEHx2+e8R8zGxtJSljdU4uAgzIDyH/TFbuph/Fc2X/NZ3/8Mu6dSD8Vu?=
 =?us-ascii?Q?Fz/1PfdtK9v2mtMG/ii0dqG/0GgB0FVs2AdcDD7zpkoyQfiI89AJ+uE6RgTS?=
 =?us-ascii?Q?w1FQmh658q2tc6URTUNqYGOs0qbnGSI63GczhIKt09YL64Fwuce0cnF4muK1?=
 =?us-ascii?Q?n+26waLtau+Jv3yTr91SrK4c4d2pLjNDxI7XE22DFa58wCf//YpPqgXCdgdW?=
 =?us-ascii?Q?n0db6elUvvVdH9OaWdTl/kKHVfMxL0Ceo3kt8hP2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5519fda7-fdf6-48e8-9d9a-08de11870037
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:21:05.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGELeGJvkdWrBbz7LDsFXwP8l9VrMwlAuNS/Dp0yPPYSjhcbEoV532zzJ811A+rz8U/ikdkm9ar2qHQoGzWavA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com

Hi Dave,

On Wed, Oct 22, 2025 at 03:58:08PM +0100, Dave Martin wrote:
> Hi Tony,
> 
> On Tue, Oct 21, 2025 at 01:59:36PM -0700, Luck, Tony wrote:
> > Hi Dave,
> > 
> > On Tue, Oct 21, 2025 at 03:37:35PM +0100, Dave Martin wrote:
> > > Hi Tony,
> > > 
> > > On Mon, Oct 20, 2025 at 09:31:18AM -0700, Luck, Tony wrote:
> 
> [...]
> 
> > > > Changes to the schemata file are currently "staged" and then applied.
> > > > There's some filesystem level error/sanity checking during the parsing
> > > > phase, but maybe for MB some parts can also be delayed, and re-ordered
> > > > when architecture code applies the changes.
> > > > 
> > > > E.g. while filesystem code could check min <= opt <= max. Architecture
> > > > code would be responsible to write the values to h/w in a sane manner
> > > > (assuming architecture cares about transient effects when things don't
> > > > conform to the ordering).
> > > > 
> > > > E.g. User requests moving from min,opt,max = 10,20,30 to 40,50,60
> > > > Regardless of the order those requests appeared in the write(2) syscall
> > > > architecture bumps max to 60, then opt to 50, and finally min to 40.
> > > 
> > > This could be sorted indeed be sorted out during staging, but I'm not
> > > sure that we can/should rely on it.
> > > 
> > > If we treat the data coming from a single write() as a transaction, and
> > > stage the whole thing before executing it, that's fine.  But I think
> > > this has to be viewed as an optimisation rather than guaranteed
> > > semantics.
> > > 
> > > 
> > > We told userspace that schemata is an S_IFREG regular file, so we have
> > > to accept a write() boundary anywhere in the stream.
> > > 
> > > (In fact, resctrl chokes if a write boundary occurs in the middle of a
> > > line.  In practice, stdio buffering and similar means that this issue
> > > turns out to be difficult to hit, except with shell scripts that try to
> > > emit a line piecemeal -- I have a partial fix for that knocking around,
> > > but this throws up other problems, so I gave up for the time being.)
> > 
> > Is this worth the pain and complexity? Maybe just document the reality
> > of the implementation since day 1 of resctrl that each write(2) must
> > contain one or more lines, each terminated with "\n".
> 
> <soapbox>
> 
> We could, in the same way that a vendor could wire a UART directly to
> the pins of a regular mains power plug.  They could stick a big label
> on it saying exactly how the pins should be hooked up to another low-
> voltage UART and not plugged into a mains power outlet... but you know
> what's going to happen.

The PDP 11/03 for undegraduate Comp Sci student use at my univeristy had allegedly
been student proofed against such things. Oral history said you could wire 240V
mains across input pins to get a 50 Hz clock. I didn't test this theory.

> The whole point of a file-like interface is that the user doesn't (or
> shouldn't) have to craft I/O directly at the syscall level.  If they
> have to do that, then the reasons for not relying on ioctl() or a
> binary protocol melt away (like that UART).
> 
> Because the easy, unsafe way of working with these files almost always
> works, people are almost certainly going to use it, even if we tell
> them not to (IMHO).
> 
> </soapbox>
> 
> 
> That said, for practical purposes, the interface is reliable enough
> (for now).  We probably shouldn't mess with it unless we can come up
> with something that is clearly better.
> 
> (I have some ideas, but I think it's off-topic, here.)

Agreed off-topic ... but fixing it seems hard. What if I do:

# echo -n "L3:0=" > schemata

and then my control program dies?

> > There are already so many ways that the schemata file does not behave
> > like a regular S_IFREG file. E.g. accepting a write to just update
> > one domain in a resource: # echo L3:2=0xff > schemata
> 
> That still feels basically file-like.  I can write something into a
> file, then something else can read what I wrote, interpret it in any
> way it likes, and write back something different for me to read.
> 
> In our case, it is as if after each write() the kernel magically reads
> and rewrites the file before userspace gets a chance to do anything
> else.  This doesn't work as a protocol between userspace processes, but
> the kernel can pull tricks that are not available to userspace -- so it
> can be made to work for user <-> kernel protocols (modulo the issues
> about write() boundaries etc.)
> 
> > So describe schemata in terms of writing "update commands" rather
> > than "Lines"?
> 
> That's reasonable.  In practice, each line written is a request to the
> kernel to do something, but it's already the case that the kernel
> doesn't necessarily do exactly what was asked for (due to rounding,
> etc.)
> 
> 
> Overall, I think the current state of play is that we need to consider
> the lines to be independent "commands", and execute them in the order
> given.
> 
> That's the model I've been assuming here.
> 
> 
> > > We also cannot currently rely on userspace closing the fd between
> > > "transactions".  We never told userspace to do that, previously.  We
> > > could make a new requirement, but it feels unexpected/unreasonable (?)
> > > 
> > > > > 
> > > > > "So, from now on, only write the things that you actually want to set."
> > > > > 
> > > > > Does that sound about right?
> > > > 
> > > > Users might still use their favorite editor on the schemata file and
> > > > so write everything, while only changing a subset. So if we don't go
> > > > for the full two-phase update I describe above this would be:
> > > > 
> > > >   "only *change* the things that you actually want to set".
> > 
> > I misremembered where the check for "did the user change the value"
> > happened. I thought it was during parsing, but it is actually in
> > resctrl_arch_update_domains() after all input parsing is complete
> > and resctrl is applying changes. So unless we change things to work
> > the way I hallucinated, then ordering does matter the way you
> > described.
> 
> Ah, right.
> 
> There would be different ways to do this, but yes, that was my
> understanding of how things work today.
> 
> > > 
> > > [...]
> > > 
> > > > -Tony
> > > 
> > > This works if the schemata file is output in the right order (and the
> > > user doesn't change the order):
> > > 
> > > # cat schemata
> > > MB:0=100;1=100
> > > # MB_HW:0=1024;1=1024
> > > 
> > > ->
> > > 
> > > # cat <<EOF >schemata
> > > MB:0=100;1=100
> > > MB_HW:0=512,1=512
> > > EOF
> > > 
> > > ... though it may still be inefficient, if the lines are not staged
> > > together.  The hardware memory bandwidth controls may get programmed
> > > twice, here -- though the final result is probably what was intended.
> > > 
> > > I'd still prefer that we tell people that they should be doing this:
> > > # cat <<EOF >schemata
> > > MB_HW:0=512,1=512
> > > EOF
> > > 
> > > ...if they are really tyring to set MB_HW and don't care about the
> > > effect on MB?
> > 
> > I'm starting to worry about this co-existence of old/new syntax for
> > Intel region aware. Life seems simple if there is only one MB_HW
> > connected to the legacy "MB". Updates to either will make both
> > appear with new values when the schemata is read. E.g.
> > 
> > # cat schemata
> > MB:0=100
> > #MB_HW=255
> > 
> > # echo MB:0=50 > schemata
> > 
> > # cat schemata
> > MB:0=50
> > #MB_HW=127
> > 
> > But Intel will have several MB_HW controls, one for each region.
> > [Schemata names TBD, but I'll just call them 0, 1, 2, 3 here]
> > 
> > # cat schemata
> > MB:0=100
> > #MB_HW0=255
> > #MB_HW1=255
> > #MB_HW2=255
> > #MB_HW3=255
> > 
> > If the user sets just one of the HW controls:
> > 
> > # echo MB_HW1=64
> > 
> > what should resctrl display for the legacy "MB:" line?
> >
> > -Tony
> 
> Erm, good question.  I hadn't though too carefully about the region-
> aware case.
> 
> I think it's reasonable to expect software that writes MB_HW<n>
> independently to pay attention only to these specific schemata when
> reading back -- a bit like accessing a C union.
> 
> # echo 'MB:0=100' >schemata
> # cat schemata
> ->
> 	MB:0=100
> 	# MB_HW:0=255
> 	# MB_HW0:0=255
> 	# MB_HW1:0=255
> 	# MB_HW2:0=255
> 	# MB_HW3:0=255
> 
> # echo 'MB:0=100' >schemata
> # cat schemata
> ->
> 	MB:0=50
> 	# MB_HW:0=128
> 	# MB_HW0:0=128
> 	# MB_HW1:0=128
> 	# MB_HW2:0=128
> 	# MB_HW3:0=128
> 
> # echo 'MB_HW:0=127' >schemata
> # cat schemata
> ->
> 	MB:0=50
> 	# MB_HW:0=127
> 	# MB_HW0:0=127
> 	# MB_HW1:0=127
> 	# MB_HW2:0=127
> 	# MB_HW3:0=127
> 
> # echo 'MB_HW1:0=64' >schemata
> # cat schemata
> ->
> 	MB:0=???
> 	# MB_HW:0=???
> 	# MB_HW0:0=127
> 	# MB_HW1:0=64
> 	# MB_HW2:0=127
> 	# MB_HW3:0=127
> 
> The rules for populating the ??? entries could be designed to be
> somewhat intuitive, or we could just do the easiest thing.
> 
> So, could we just pick one, fixed, region to read the MB_HW value from?
> Say, MB_HW0:
> 
> 	MB:0=50
> 	# MB_HW:0=127
> 	# MB_HW0:0=127
> 	# MB_HW1:0=64
> 	# MB_HW2:0=127
> 	# MB_HW3:0=127
> 
> Or take the average across all regions:
> 
> 	MB:0=44
> 	# MB_HW:0=111
> 	# MB_HW0:0=127
> 	# MB_HW1:0=64
> 	# MB_HW2:0=127
> 	# MB_HW3:0=127
> 
> The latter may be more costly or complex to implement, and I don't
> know whether it is really useful.  Software that knows about the
> MB_HW<n> entries also knows that once you have looked at these, MB_HW
> and MB tell you nothing else.
> 
> What do you think?
> 
> I'm wondering whether setting the MB_HW<n> independently may be quite a
> specialised use case, which not everyone will want/need to do, but
> that's an assumption on my part.

It's difficult to guess what users will want to do. But it is likely
the case that total available bandwidth to regions will be different
(local DDR > remote DDR > CXL). So while the system will boot up with
no throttling on any region, it may be useful to enforce more throttling
on access to the slower regions.

Rather than trying to make up some number to fill in the ?? for the MB:
line, another option would be to stop showing the legacy MB: line in schemata
as soon as the user shows they know about the direct HW access mode
by writing any of the HW lines.

Any sysadmin trying to mix and match legacy access with direct HW access
is going to run into problems very quickly. In the spirit of not giving
them the cable to connect mains to the UART, perhaps removing the
foot-gun from the table might be a good option?

> Cheers
> ---Dave

-Tony

