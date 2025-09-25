Return-Path: <linux-kernel+bounces-831756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0792B9D7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1241BC0FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B012E6CDD;
	Thu, 25 Sep 2025 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Do/ciT71"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B0033E7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758779226; cv=fail; b=t/B0PAfjy6gqGl8nWVHlq+WG0anLJnp2KSyGF1qCBCXy33bmSp6mDPfTpVsCnSDWlQiNUxz/pHWZoomZERO89oMFuVv8FcVDU2/mjoJ77yz8w0OK4nyzlQXiGPjt8I353UaGNuGZV6RerVi6Plz4dUQrKJN4AhCs9bcJwjivo44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758779226; c=relaxed/simple;
	bh=rGpg4IvpDxqFz/yGRgFW2B8cosStANerzqOpb6NqBFw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=vB3gqZcFnfcS1a5ELwpe4TGY7LuHdyHH5M1C7kHaUVUaR9oo4DrSEGvkT5FT0xVUWTZqsdjQecPFztFQgJLqzyAY61rB9M0RG+BFmRwg/Qntv81L+vzAIhl5DhlPnP8ZKIFkVa10I3/ctZA1j/7sg440vBU9QrrDM/5k775U7ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Do/ciT71; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758779224; x=1790315224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rGpg4IvpDxqFz/yGRgFW2B8cosStANerzqOpb6NqBFw=;
  b=Do/ciT71kGx4gc/Dim7kr+vgZ6rwjyR4yyrQeCcGZch4hlh+2s0AevjJ
   kSwZLyYB0gNzw3pm4SrYaRcsW0heZ54L/QroLqyCUQ1xirvNrcwkekC5E
   ftzyKdlFxR7Ac6tyMtwvsZHOVEWaEZnivApzSUbwmPQMhIlP5PwTrJUv9
   Sgnm2CqWgQn86g9+RdV5odsH8idyGKH5cpvs+hCfSWITNjynCS9T/qdbl
   PAGBCUz4MCqOv9+F3ZEGo/7nWEhtBvmr4iqFq3XiCwvztt1TUm8JXmctl
   VRJdEcKqrYa9jlRWJQZ3Siv+CFJUf4jwVlEIEjs/dCrqTNf8LuKzJfD9k
   w==;
X-CSE-ConnectionGUID: XB/Fduz8TraaAVNRnJLoTg==
X-CSE-MsgGUID: lisYr/SvRWqYrCNo/2vl9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60302078"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="60302078"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 22:47:04 -0700
X-CSE-ConnectionGUID: wAUkDeFTQqCvL+txhnx+gw==
X-CSE-MsgGUID: XxH0/Ik5SReEcJfw1/unRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="177634296"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 22:47:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 22:47:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 22:47:03 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 22:47:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxr4XSZcTeEyd5Jag5hKY7QCVWRMZVrAwyH40M+6hNM9qwIMB34oCw3C7ioEhw/0iKh+Zh2XwLUku9rOx7y5/ETtXV8pBQnCy17THayAw04nYMuGsKmo0tylYEn/7Xw+P5Ijb0ZCEiTbnHtJ4SxqzhrxcEWgtf9TlexF5uElHQGYwNmWU0++kYg9j4UGVZalgMsaYon9ir99yOPqAnzM2dG6np0MlJJ8aD3wSq6Y3EMXa6zo9UUqbeafRAyyoFoqR0hZZlbolDoTW2jEqMYI5V+qSKIFOjjCMI93F19svtaBiiHm4ktSuHS26Fh/Sk4C9pq5ckVVP/SEZZLtjfJedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0g+9HigZKRb4ooMqPr2X1+zYAaSFdge7KwGRuKWddw=;
 b=PiW9zWT5COGtMfB7cBghFijY9Q+dyAEmHtbZF7jwQKIv8VFAlCoIYfZarjXlEzxzlok+WqTn62ch38eWGb9SdtlzSOrrd3KcN82jPe4bmZwKzNQvC2AJw+qgy3FNyDrnYVNhqXKqvVD9LNtXiiFZ6mkDthRRgWha506R+g/v0tFze4tW+fZGad1RY3GXjm2rWZC5wo0Zn/pEkebHTtCo877xIWMVtBb7NS+kcZK5lAF9gjJjHljvyjqnT5koPwMHMTlDdkzQOdEyu8kl8oARca3IvoS0Ao7Cq7R+AbxSkOLxWuzsmDmbFqMQQUHrjtXFVjPRFDgdUNmWOqRzcJUrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6217.namprd11.prod.outlook.com (2603:10b6:208:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 05:46:54 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 05:46:54 +0000
Date: Thu, 25 Sep 2025 13:46:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [ipc]  74b24a582e:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN
Message-ID: <202509241632.3a1187a5-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TP0P295CA0029.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::9)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 249241e0-cfc4-4022-d7f2-08ddfbf6eea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tHgmhxgG5J/hRDDlZ5lTizfBnRnXWWV1DRbb4ZWRzqsb0yg6r8DitUNi6aVw?=
 =?us-ascii?Q?QoDvWO2M+CZ4lJcS+DA1SxE3i6tuiu+im+pYMBuCscfAhQnB6Pp1faC1RY+7?=
 =?us-ascii?Q?es/J3ZOpq7Xe5srH8cedkKFysdSwV15jV0NMH9Icr8MveU6T/ZX4+9CjvEpN?=
 =?us-ascii?Q?9wjEVqhqdnZKn4U7C81T9KbvLlJkQxYpEel1PHzSAUBI2c+zhbCjErxsS49Y?=
 =?us-ascii?Q?YmPr8I7E6WARmdbpj4pqH126lyt9P8pVZ19f0mYp00FIwJkcGL8hWptfrSi9?=
 =?us-ascii?Q?2qsmW+VlHHhalSUg5zGtEmP7HRKfs3666jONFftz20hThSd2xbZ5DNNhbbzk?=
 =?us-ascii?Q?3YsJS21Hv2EOufDaRPwqrtQd4j3uIL2Z1Kfi8EbJWOzGEMxmG5PJ6pUfteZ1?=
 =?us-ascii?Q?1swWOv4CHwdAK8P4rVD0xU/r5xhc92LYcUcKkdtugho1y5Vm7qQKoHku1a+o?=
 =?us-ascii?Q?Hwp67wvZ/XO16yWaAShEM83NQfegUb9uSf6EghX+jVtGXiIE1HgbLojk2Yzd?=
 =?us-ascii?Q?C7IFZuujtYRWmOJJyepqm+QdA+rUH0cHySb/18DihBpksmG5X/fZ/tjp/qLf?=
 =?us-ascii?Q?kuDn2m2kSwAEUyND1UMMRtLukvDUamLJxe06APprBdZ4wpPgkBkr95so8xAu?=
 =?us-ascii?Q?2QAwBfuMtDcN4hjd6b9opLXwHvNJwZuBe4RRx9r4dUo5EmjuH7e1Q4F+KHKg?=
 =?us-ascii?Q?Xm42VWGEzlgUUXPbDAjBW+qcpgdbF/37w+d3oRDFgFz57qjMIMPFhs0JVABA?=
 =?us-ascii?Q?l4H02reyDI7XpNtUdznN2OYkiHBfRjbtqSwScAKV1pUn59xTQc2r8nVHcS3C?=
 =?us-ascii?Q?hOrQlocSK0zww/Tckqq61jTv+s6hDBmc/ouyFUHOSlastTPJdFzRgWUv+LXJ?=
 =?us-ascii?Q?sPG4t5yaUs0U511lPbTB/WYejdyoN57sfCTWGSdjjqh7fy0qquiSYvAQzrCo?=
 =?us-ascii?Q?Hi5E4bixZ8lgKiXZwSbW6Uy3VxbeIfObSvtYIL2B+jsRtn9KBSjKSRJS7GIM?=
 =?us-ascii?Q?x70ruXmNAyfTbvXJmhLC49+Kgq6YoMWzygxbgPapfzlbpbUtpTeNUUuz4POT?=
 =?us-ascii?Q?NdoAokfgH57t16T31Gt8ZA3Pt+r48n8RF44Fe7B1HBywDl3lWUBH6cjqKEo2?=
 =?us-ascii?Q?jIjvcBxHnAK2B5PCcdRkgfjHrZLzIZdR0qYH+a7OB7eZyiLvJ7IL8XVJAgjg?=
 =?us-ascii?Q?jr6Rs0sD2dWkJlflJ2lFLtDVnef4a0sHl0b4WmkhFs6Qz5WnkQLmqoOt59Yo?=
 =?us-ascii?Q?276Ojh7qS3SLtsPCuA4JpvMu4DBz8XcwkXN0eIKnERUXGQdtyiNZsqac17zh?=
 =?us-ascii?Q?FA8qFJvdSvN8dh4MlJUHJD8rYPDfb0OOvoYLP2K06GLkWwCWDyVdmjvqYYDV?=
 =?us-ascii?Q?/ymvfanIiffXYVr6GFklncZjbLDI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fLE2fNZBLvE5l5daxlDTcYUHTLnaKlZ7oc/FUVgppD2ywhmrL48DH7ZRXoTk?=
 =?us-ascii?Q?NP9ioETl00BqsBeAmramn3wXBeEI3xrJhk867b0ARGhtlStgy2xcQcHJhJXM?=
 =?us-ascii?Q?uv9SilUSBbIzAnCyVGo5dVOBAb7TNHWkSAGs2z4rdAph3V+YNdc5KCjB0Tua?=
 =?us-ascii?Q?83+VqYwBb+v7KaduyENLQ49zVgBfKSt965NBNO6x3YuKULaQHdCYsGB1Q1S7?=
 =?us-ascii?Q?ABHkxFmbfpOoXzQgE9rnuYEUc58pQHmEX7+SkGWc+6i8N+2907QvGVYv8x+m?=
 =?us-ascii?Q?1uwnvwEGdo+4ifd0CIrtr8jG6sGEBja6SHyRZgVKV/VHe3Ay2W9gQuYAiPzU?=
 =?us-ascii?Q?0JB6gYUM0x76EUbeaKiLSKvefEQ4xT/r0OH1z1pwQySi6DwAr1PygzWxyJSg?=
 =?us-ascii?Q?g6cHDbSWlY5ce+dCUVgiKhUsT+l736WpnBcrtHwPRDw4NGjKI+1YWEB+0Nlc?=
 =?us-ascii?Q?o6wimhi3DV6qaZKdfdWpR97yNNRmoJVeVm4XOUp6qJsZNZ6oIZmBl0j7PwTm?=
 =?us-ascii?Q?SgYN1JvQ/vJQ37C/WP3a4majyN3sRRN35y8Sid89C0MZox4Hba+qXkVTjHyx?=
 =?us-ascii?Q?4kxMHLjy3OtsutWoTI4uxJYGWJFNbAs/7y1VCtIRVjbisu1PLseNpFgXsb3X?=
 =?us-ascii?Q?2jFuo3AHBmIIzl+1mG7J/+A6Iai98JD/k/6hO9QWNKeMgwp12JJn6gachLft?=
 =?us-ascii?Q?9gugHwus+FR0FRkHyEUKP+XTZ3ZuOyuNtqB0wA6E3yPmjpwx6dMs8dBgnOfe?=
 =?us-ascii?Q?vsbNuaRnfCnvsEx8YxkTt1HBR0AJ4lcFwQghXPtMHZ1WEmcu811slPE57gu4?=
 =?us-ascii?Q?qc3ZpODMS2dIdUYuVV3S5YVwgJzyK6WU9uZrbfZJK+iTsGp2UHLzKmONyOoQ?=
 =?us-ascii?Q?I6tlP96oxcb8t7C2lv7AkB6CkeqXMJwplhdqxs5WvWA6D7A8DdRUKpACEmRI?=
 =?us-ascii?Q?oYC3nmoOIIytfFGuq3o3DAt6EGN75s5OGzR7r54lYWlx7TOoNQR16nted9sa?=
 =?us-ascii?Q?iAjZIZ7KsqaF76eHODUZENhvkn7n1u/pGZjewZJ9e03KQnVWhxcDCoDx0lRK?=
 =?us-ascii?Q?Z3iBKK+RyExabjtddgHqlL/DOV+Epm9ct+mNuAJmhb3mjaZ1R9OjMJA7FlhN?=
 =?us-ascii?Q?L/7rYac5H4g/cXtkNum0o/A0BmpZGzvPiS6VSU7+oBSv9N2gO7ec948Cyig/?=
 =?us-ascii?Q?KpST3WHXo4iPlh0mRBs5Feejlrxo8DP848dPyB36Lbz+7g8iNjgBBpAfKiIU?=
 =?us-ascii?Q?SYuyDVJ8qvfI08B6CE+ZBuYqPP4npbDY+hGX1xYUbFRtzVIw+BYa+3j/gKDj?=
 =?us-ascii?Q?2tk0+uQrDDlzxWe+wI23QgeUqDHP61I05LVnY6JzqrfDxIdj95aYdymJXE73?=
 =?us-ascii?Q?N1YNZVypA52rs847lY8mO8wJegbB3AOsAOxPvBZT2ew/NTWAJnZzmCTIivII?=
 =?us-ascii?Q?Xzfv4SHBl/Rl2jaldl6ey7Wk7AgQwxxBaFkl7Sjws4On4SGoMCIFto54PmS8?=
 =?us-ascii?Q?F3lnmiIRRjh7rpuP4j6fREQFOXkAIXYqaaU49ZifCCv9OC4j8HOH9pyexNfj?=
 =?us-ascii?Q?LlRaHMxeYebW0uDerza1PanqX040rEcE5RecRcJ+9S6alGLiiAObCmdBDpv8?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 249241e0-cfc4-4022-d7f2-08ddfbf6eea1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 05:46:54.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CI5mB6KxuT0gpfHnORh1KjVd7+qjkD/CV/XaxEnZjUtCMi5uW/YaBx0mgSewH72+lt312+DqMhhm7Cmw9S1YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6217
X-OriginatorOrg: intel.com



Hello,


we reported
"[brauner-github:namespace-6.18.file_handles] [ipc]  c8e087bf68: BUG:kernel_NULL_pointer_dereference,address"
in
https://lore.kernel.org/all/202509231700.dff6cd4d-lkp@intel.com/

now we noticed this commit is in linux-next/master and found similar issues
in our tests. so report again FYI.


kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN" on:

commit: 74b24a582e1ff3960f0454f57afc2bcdbc52562e ("ipc: support ns lookup")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

config: x86_64-randconfig-007-20250922
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | 7c60593985 | 74b24a582e |
+----------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                   | 12         | 0          |
| boot_failures                                                                    | 0          | 12         |
| Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN | 0          | 12         |
| KASAN:null-ptr-deref_in_range[#-#]                                               | 0          | 12         |
| RIP:__ns_tree_add_raw                                                            | 0          | 12         |
| Kernel_panic-not_syncing:Fatal_exception                                         | 0          | 12         |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509241632.3a1187a5-lkp@intel.com


[    2.135918][    T1] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN
[    2.137777][    T1] KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
[    2.137777][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc4-00022-g74b24a582e1f #1 PREEMPT  38d15ed75bef35c8d0bf70c9ae8ec80a13adc51c
[ 2.137777][ T1] RIP: 0010:__ns_tree_add_raw (kbuild/src/consumer/kernel/nstree.c:95) 
[ 2.137777][ T1] Code: 45 d0 4c 8d 70 08 4c 89 f0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 f7 e8 ec 09 5e 00 4d 8b 36 49 83 c6 10 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 1c 04 00 00 41 8b 1e 4d 8d b4 24 90 00
All code
========
   0:	45 d0 4c 8d 70       	rex.RB rorb $1,0x70(%r13,%rcx,4)
   5:	08 4c 89 f0          	or     %cl,-0x10(%rcx,%rcx,4)
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	4c 89 f7             	mov    %r14,%rdi
  17:	e8 ec 09 5e 00       	call   0x5e0a08
  1c:	4d 8b 36             	mov    (%r14),%r14
  1f:	49 83 c6 10          	add    $0x10,%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
  2a:*	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax		<-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 1c 04 00 00    	jne    0x453
  37:	41 8b 1e             	mov    (%r14),%ebx
  3a:	4d                   	rex.WRB
  3b:	8d                   	.byte 0x8d
  3c:	b4 24                	mov    $0x24,%ah
  3e:	90                   	nop
	...

Code starting with the faulting instruction
===========================================
   0:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
   5:	84 c0                	test   %al,%al
   7:	0f 85 1c 04 00 00    	jne    0x429
   d:	41 8b 1e             	mov    (%r14),%ebx
  10:	4d                   	rex.WRB
  11:	8d                   	.byte 0x8d
  12:	b4 24                	mov    $0x24,%ah
  14:	90                   	nop
	...
[    2.137777][    T1] RSP: 0000:ffffc9000001f9f8 EFLAGS: 00010202
[    2.137777][    T1] RAX: 0000000000000002 RBX: ffffffff85927a58 RCX: 0000000000000000
[    2.137777][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    2.137777][    T1] RBP: ffffc9000001fa78 R08: 0000000000000000 R09: 0000000000000000
[    2.137777][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff85927a40
[    2.137777][    T1] R13: dffffc0000000000 R14: 0000000000000010 R15: 1ffffffff0bf3eac
[    2.137777][    T1] FS:  0000000000000000(0000) GS:ffff888428598000(0000) knlGS:0000000000000000
[    2.137777][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.137777][    T1] CR2: ffff88843ffff000 CR3: 00000000058b7000 CR4: 00000000000406b0
[    2.137777][    T1] Call Trace:
[    2.137777][    T1]  <TASK>
[ 2.137777][ T1] ? ipc_ns_init (kbuild/src/consumer/ipc/shm.c:153) 
[ 2.137777][ T1] ? __cfi_ipc_ns_init (kbuild/src/consumer/ipc/shm.c:150) 
[ 2.137777][ T1] ipc_ns_init (kbuild/src/consumer/ipc/shm.c:153) 
[ 2.137777][ T1] do_one_initcall (kbuild/src/consumer/init/main.c:1269) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250924/202509241632.3a1187a5-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


