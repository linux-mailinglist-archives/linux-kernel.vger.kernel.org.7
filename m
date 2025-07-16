Return-Path: <linux-kernel+bounces-732985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7608B06E76
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B338D3A2572
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF3F2253E0;
	Wed, 16 Jul 2025 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIhvPa3J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2F218858
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649472; cv=fail; b=go650tdTYpRzuhG6zNU7DlMZOzpHTTO8EyLDRTRelKXeMUjJVphNKuz1V/swbr7iKhtTFk9Hps9OGK1ot5HYUdYDLY9wjCiof/VhQ0prVDbfcG+nF8YlZ7Du/x9qYpE3I/N3zTC9ZC6SVVJg6SdjTXgIse21dS67eunpLxlNmgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649472; c=relaxed/simple;
	bh=C5GWAmH836rzaDSfM3SQHtTqiVYWLBQr/WQogrzlDrg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lYLD7uOgzstm98Z3s7RmCb9NztFhLMNvv7/DcRjj6t8nKBh7YSaJ9uu+yK1w+3hz62pNdkK0J6SDuLrmQiDHroD2fFcDZ+cAv0UmNyQxRKXvh4WAzUYVWfCeC/zpK2kxner2A/8akrTFfUQPdli8CgHHfJzlN+7Yn4E2QlQppzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIhvPa3J; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752649470; x=1784185470;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C5GWAmH836rzaDSfM3SQHtTqiVYWLBQr/WQogrzlDrg=;
  b=LIhvPa3JZVTZUDn4ZgOPSLbOPoq5FP9NNVaBCJ3EEh2e6eY2muY9s1Tz
   Bc/kDu2VVrz+buq4V8R/iI4OlpdLSNR1C8rJY8Q9qnTZeDbOcNFwMoWFB
   ERz+SX79roYgJ9N2a3XuLoK7rtJyuIdMeACJK+Y+czRxc2qnoKm2yqHqY
   +0KN2rB5qGc/QO+3ohFOvC3ppuGJWEetzn2x7X5/WOLYikRw1Ej3GeadU
   v4ksSf/PHUMYU/Z/2YoVng6cmvI89ZEFp12PStvWCm90FSqk9uTO7NjE2
   juu8OcPz5qlWZ/OddCPvrUEKS8HT9G3ohNYKWHVHcAKJ05OS9crMGmzgl
   A==;
X-CSE-ConnectionGUID: chLiJwvER96ifqAkmgVl8A==
X-CSE-MsgGUID: IEwt8RIKSiC1WsYbbUQK7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54823164"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54823164"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:04:29 -0700
X-CSE-ConnectionGUID: yw8aW2yzTGedY7/Lp6t9Iw==
X-CSE-MsgGUID: svh9vgc3S8qe+D72XDLLCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161742917"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:04:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 00:04:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 00:04:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 00:04:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjbDy5Kr2QLOtVvhPl8HwWoDCHJl/q7qQ9qent9A9fwV/84Czw3QdgUDgacPv70EGGrHrQoOcGgaJx253ccfZHK/M/3vAU3Ws0ws48JJUDfdHlwRSpHu8LbHy3XmQMDEE46M0pNkJk9Jq3jmWCjHBJfmo2nTMJQtnfquDFoPFgTBzoUCmxsJcRV8AsSoJ8jdTScI+lk3VfZvI+76uN6IkrTt/0CFZ9G+ed0vsP7dnjz9r4b/7xUDZ3Bz3erGVTAI3kuzxe4IGxFcKtl4nzmL7WnImz//uRxN/p47wzYXQJyQa6k7oyDdkigoUldeFOZ5mkiFNF64v9mGSPWShbYQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhpyA8RPOLNzpLboGBKKhv+DF1sd5uDvIPsRsq1z6ko=;
 b=L3+GligikVAxXt0UmqMxBDBiFPRiSn+69pOKK7Byh/DZ6t59iq6jfHjUIbhmA1XEMxwZKjesubHW4Fetww9GMONXGcOkU6bGrAI/pW5X69+RTF28m6CgcrRito8CtPzkcUcknWkcO41p0XecTrRNjMyJDscRd1t4ayIIFpxD9guFBWrhPUv/kOCImsqdacp3TcrTd/CL29VYeab0jGS+rkfGVTJYn8yYo0JXaVxgOAQGlQ7xDf+rchx3kxaQv+Ol3YmBOXnLTWvxoqcVEX3O6D5m8sosaTDlCEMecboekodabrtJrX8GDggu+Wos1oqtD6wi09ZJR36OKdFjJgbFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.36; Wed, 16 Jul 2025 07:04:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Wed, 16 Jul 2025
 07:04:25 +0000
Date: Wed, 16 Jul 2025 15:04:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, I Hsin Cheng
	<richard120310@gmail.com>, Yury Norov <yury.norov@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, James Clark
	<james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, Kan Liang
	<kan.liang@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	Namhyung Kim <namhyung@kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [tools headers]  fc92099902:
 kernel-selftests.sgx.make.fail
Message-ID: <202507160826.b36aa80d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eaf2d89-b56a-4357-9e4b-08ddc436ff6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2+NOWLItDGMhlU+a8otGie6MrJofz1EySzVoCvmFnHjQP0lDO3glQOMJ74Wt?=
 =?us-ascii?Q?MRFNNIxIFhStrPx7uxZchD1kprAK1ex1guPxSu8MUdO6NUTFdzerhaYwLet/?=
 =?us-ascii?Q?+ztRnd0fTTQx8kK18J4HbpxBa+MycnVRODutMY2t9/nSEr/1wRAtxe3FvhTo?=
 =?us-ascii?Q?DdNpjeJMxiGoV6LBhTLZA6NDhXE+WazNR/kLKeAvTs68QQcQEseNXdQaXMhB?=
 =?us-ascii?Q?Qw/bJfS5uxrhMaB6+UwRvYjsyKTMReXUNPTUl+qzOiFupXqG2eGFMoJN6/d6?=
 =?us-ascii?Q?M7OtJl2r6lFjldSyfmd4QWFxL+kaKM8pyjKpI1/nnR8B2fqF35fapryvwuUY?=
 =?us-ascii?Q?kB6llxKcKAZS3xYmPmnHI7ydnbJHCEXfGMcCnLXNiiwBiZfyCJYHmUVJkvjN?=
 =?us-ascii?Q?Tm8RtLzZmuvvstH0HzfXa7g0FcINr+/3lgbc89gFcazd4GvSg9aIMc6ZyVhQ?=
 =?us-ascii?Q?huvBzWfSiiLDXjA1kI30PPx894+nuaX1rjdCkev6qVdgBedX3KV8Mmtlzwca?=
 =?us-ascii?Q?kyA+zaStaowPUDXPFwMJDIDD31J0x4iSbsh6Um+wK9pN7QCT3FI1o9BG8PIQ?=
 =?us-ascii?Q?+F2GxS9J4JrO81qr8IMfAHDApB2mR+ZaHJIsKqhphT47tn8uynINrt1U/K6Z?=
 =?us-ascii?Q?BX1bvf5Dc3VI8z1LnWcYs0wV0t1feyo8ngHUCoAilUxyCcDDPkK1GUkGpykm?=
 =?us-ascii?Q?kTytHCYHsXKbIXJSeGUxA/vdOoWXP0bQrbybZ12xRbVma9HRn87DGZNPKsFj?=
 =?us-ascii?Q?TFK10TmkwqPge+c5QWbKv/MRl1mr/BJ57SaStc787EyaYSDrUdAE8CHBd2vU?=
 =?us-ascii?Q?QZAzfC4pJSMRxf9CGaIRbiumyjRbX752ow9KyHN81+DPpKbba9gq3zHPHiJV?=
 =?us-ascii?Q?oN7kYCnZEikpuPVP7XCzvlxEFgYygsglQcXF+OyIH2BZkRZmAMU1Ty7Wka+u?=
 =?us-ascii?Q?WDeEEPzIh87SdyNtgvB0jbe+VKRUfYAZJCJfg8InTWFeGT5spt+Adni/d0c4?=
 =?us-ascii?Q?9tbcmrjmyCnK+phBnhs5Og/YjoQRHE8OQA7UdjgsMPd0ucouggHLpqblxhBl?=
 =?us-ascii?Q?OkTBLBTtR7sh80OSzrSFwwm5uoOFskhNy2VBlc+qaau8ErjEi/b0lRX+eCpR?=
 =?us-ascii?Q?1QDrm9yS/ECQJGicDH6NK+Am1vsx1ULOIAUmTf2jrMTTVYmDxOQ8OOpQV8cJ?=
 =?us-ascii?Q?gde+SHko0uE1iWQa/52B8kVD/I9+3pzX7wQYg08xImzLNBjO7E9aYaK4/yvH?=
 =?us-ascii?Q?rbwyvi4/D3Rx3DQArksPa8UanrbeGHJWOk5emtWB0iN2EZ//Ky548p7cV38y?=
 =?us-ascii?Q?eClalfRH9Ns+DbthMe4867AkFHL8hgx07jtweeVhrxTeSpOt2EiaVKJZ0j6q?=
 =?us-ascii?Q?NleSI2V/wYeBsBR2bAXG5qTNvcs5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YR4xgXxPqK89FixWPjHKBslJaOoor9sOtSe0qlX+ERXJomc6Mz2Gbun7MUPf?=
 =?us-ascii?Q?7Q89g655HoKB9HFo/Hx7tEUXJzGLb8XLXO7WNXXhqYhci8AyM57OOVBnopRI?=
 =?us-ascii?Q?b+UoqbJylhwEbP2StMh+uXxudllMRtBnPAu/YXXnaUNr5Qd8mjBIWn4aTrqb?=
 =?us-ascii?Q?yeqQoXvGn5Oxd7mXdUSGMnwgh/r9eLR4HeqqJdN1rSpo+bR0yHe1fipj6o9D?=
 =?us-ascii?Q?fbURkD/Hv0Kbkh7yRJI9UdPLLydGaZnqzEiC26PD3fjK87kjEZBsigTsrJKb?=
 =?us-ascii?Q?Y9rfkvGhnyul9TkrcnHOp9N2bso7oOO1M4+F4G2GWYJL+/1g+1To7Eb53H/s?=
 =?us-ascii?Q?w20oW3jPH5XBtewz6NfJj2ni780cTLTnleUBmJ4mFQCleACMWuIAyAhBlo08?=
 =?us-ascii?Q?LPg7IaY/T7upo1U8b4lsTjvRKeyji6qC15SUybLIQMbzxjuRLcawcwtmHKBz?=
 =?us-ascii?Q?uCJCGblMJztIMx0yRXyxoIvR/l/b7mL5aTKlZAhyyaT0SRzg+ObMNAL69c3/?=
 =?us-ascii?Q?wnqrkB0Dp83Z1Feo37VjqBHmWhQAjzr0xEckMpzVJA9AHwTqF1U3b5IAPR0w?=
 =?us-ascii?Q?Wt87vuvXyha7p0GKzHf0w9DHBVvyh+UUaJcTuqQYyUjAgwL0Q+6PfV28CIgh?=
 =?us-ascii?Q?bbNmKBagUwb5m3w8jdoDwuCXDc3zjxA01cwkNkdK8blYp9bIrGM3ZzZP6P8/?=
 =?us-ascii?Q?c+I2cWyD/qc0bknWmG6am809T1FEhsFFi9C5yJu6cMNWwu3y6uBCs6MP73Lb?=
 =?us-ascii?Q?WCpy7DUuwEsbi9TLvlD0opZ/0UnJfDpGy4HaQ5MNMB/Qm+2COBecbP70I7gG?=
 =?us-ascii?Q?zy+fyNBvPHdPOZ8YsLKOIV6h6Xh/uxwIbcJCmti2xAOqpy6hI8C8qrVUn4SV?=
 =?us-ascii?Q?yJu2xGC7OL2UGGwm6GkCDogTZ5afaM0NhXFXjyVryLh8r6ZQrFoOdL3HOEMD?=
 =?us-ascii?Q?5OVuo6b1+Ps5kNm2bx0/FXjTtqKmgfXlRGZdK/O+RLaoPf/U9ns86nk7VpOQ?=
 =?us-ascii?Q?8PaGEz1DBCuHI88ZBvm2xgr2cE3ull3jhKMec+8wshDp8PAv79uYKihH3Jlt?=
 =?us-ascii?Q?ZTCUQBS+bCqPRw/Zl5lJDZV2FmFG9KBiibbAvIud2EkBVG1RwgtAyjwhfAAT?=
 =?us-ascii?Q?jOqOt7H6PqpqkBJqig5GVqz29gFNlNFHCIDzL8bXkfq4RALQUdxZ+jhVgvU5?=
 =?us-ascii?Q?M4jWj3QbR/Nf8ebdvEkVRJCl1dpiADosXk/Qo6nXiSnPr9W2+lyyRkhCXiBQ?=
 =?us-ascii?Q?FEoN7yBqttIP4T1o1oEZZ69nT0iHr8JDfeOhkW0PbjPbqxAM8TLLjobyjS1Q?=
 =?us-ascii?Q?V43O2mU3hbW7SCXoQp60Srge5eILPOSgK0xTeFDUW/AUlftIGaO0XazyPOc0?=
 =?us-ascii?Q?wVPQ78i9ZPOYOUgKaK8oxyYWaG5zPtlkRo55qY8cy+vA6x8tGzQf14e+vdeq?=
 =?us-ascii?Q?kNKp6VdY7Eic09gxkShC4d7L2DGXsveahCp9Ms9mI5qtIdqMlxmBCzEMsWMF?=
 =?us-ascii?Q?wli6BXK7Tabrsbd2QmN/El5YQPi1iljvhawF+kPX8eh3rTzlaVNWZcQ1/5Hm?=
 =?us-ascii?Q?NI8Q745ZMopY7Wd1zVdZ93YVY9qTFr9fYN+0XnXtteM/6fvRL8GxG1eTewew?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaf2d89-b56a-4357-9e4b-08ddc436ff6d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:04:25.2623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mR6SRoODwWfEMm5VYnNTndGzK7XIjzx7wv4cFlLxjsFOLCfLWLrfk/+1yiNsK0JTFDKpNwhr+Y3upqQPe68Olw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5970
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.sgx.make.fail" on:

commit: fc92099902fbf21000554678a47654b029c15a4d ("tools headers: Synchronize linux/bits.h with the kernel sources")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      3f31a806a62e44f7498e2d17719c03f816553f11]
[test failed on linux-next/master a62b7a37e6fcf4a675b1548e7c168b96ec836442]
[test failed on fix commit        70b9c0c11e55167b9552ef395bc00f4920299177]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
with following parameters:

	group: sgx



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507160826.b36aa80d-lkp@intel.com

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d
2025-07-13 03:43:58 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2025-07-13 03:43:58 make -j224 TARGETS=sgx
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/sgx'
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/../../../tools/include -fPIC -D_GNU_SOURCE=  -c main.c -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/sgx/main.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/../../../tools/include -fPIC -D_GNU_SOURCE=  -c load.c -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/sgx/load.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/../../../tools/include -fPIC -D_GNU_SOURCE=  -c sigstruct.c -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/sgx/sigstruct.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/../../../tools/include -fPIC -D_GNU_SOURCE=  -c call.S -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/sgx/call.o
gcc -Wall -Werror -g -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/../../../tools/include -fPIC -D_GNU_SOURCE=  -c sign_key.S -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/sgx/sign_key.o
gcc -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE -fno-stack-protector -mrdrnd -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/../../../tools/include test_encl.c test_encl_bootstrap.S -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/sgx/test_encl.elf -Wl,-T,test_encl.lds,--build-id=none
In file included from main.c:21:
../kselftest_harness.h:754: error: "is_signed_type" redefined [-Werror]
  754 | #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
      | 
In file included from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/../../../tools/include/linux/bits.h:34,
                 from ../../../../arch/x86/include/asm/sgx.h:10,
                 from defines.h:19,
                 from main.c:20:
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/../../../tools/include/linux/overflow.h:31: note: this is the location of the previous definition
   31 | #define is_signed_type(type)       (((type)(-1)) < (type)1)
      | 
/usr/bin/ld: warning: /tmp/ccPKj3Bo.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
cc1: all warnings being treated as errors
make[1]: *** [Makefile:36: /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/sgx/main.o] Error 1
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-fc92099902fbf21000554678a47654b029c15a4d/tools/testing/selftests/sgx'
make: *** [Makefile:207: all] Error 2



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250716/202507160826.b36aa80d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


