Return-Path: <linux-kernel+bounces-799778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF4B43027
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77EB7A5961
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD483255E26;
	Thu,  4 Sep 2025 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLjByPbw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52ED2571BA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954803; cv=fail; b=WeKyUJK4eMuBUMEQJ+jM7tcsltdo7gbaga8s16EZF3vAMdxp7SZe1m0lgp4+ufveBHRJnxmXVmVtDIxOupHOinCezlALngdxjDe0gP4hsvdwiVntyGNZYkZURorE9phgdOBZAYezfReuDbAs/nNgn2CqAl2v9sDT3pAhy9vU/uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954803; c=relaxed/simple;
	bh=5/+x8CB3lf7E04B7ub6V3E8jS+feb94WR42sP230tpU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jw+TKpgPHbmUxKUmtzgA48QZPxn0O8Ln3qyMqHFBwUpjDpAaTxy4TlomUd8pHJP/+fXRGm1OrFEEu59cFla/D+c8KfKWLej/9PYbk0iSWOkFdpFPUtETT4NFs1L8/NNc9F3mf70R9TYUDz5JfsCxLdyCNkACB9wwtuxkgWCdDmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLjByPbw; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756954802; x=1788490802;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=5/+x8CB3lf7E04B7ub6V3E8jS+feb94WR42sP230tpU=;
  b=KLjByPbwZPqysErw2a//Vv5CJhxzVKuEdVwiOJFJ+EkB9xEMjm8wxryJ
   ArEPemQfM7so8qZX7PgfW9BN2bft8RNnHTJShVJ55skTBNwt+durAfTDe
   lbqkxRzvpjTwWNYaJpYirIxODQgF0Wq87jm7JR+68JJ3cDh86ZjxchGwD
   u9vpedLeebsU4bsU00l5gjnB54HV0LGFD4HcyMubvhJFpD3jUQrogy1H0
   gPaapcnMslA+28UhI9og81ceRbJ57TsHAQv/uW0AaWB5xuA6LJcafWmr6
   8eL0MorTTnp+tYpEO66YrM7wA8d7PjmMLT6bif/mqliYSGGhBxxsTZtWT
   Q==;
X-CSE-ConnectionGUID: AuNYsxrnRbqI1Ikvn4Frjg==
X-CSE-MsgGUID: L3olVo/3S6isKitAE5ESXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70655913"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="70655913"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 20:00:00 -0700
X-CSE-ConnectionGUID: Y9ASOzJWSwqCPcIWr2nZnw==
X-CSE-MsgGUID: 257fgOVbRmKoP25Cx2q5Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="208954688"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 19:59:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 19:59:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 19:59:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.85)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 19:59:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4iOGGtIebqCLQOqMBn9zPvQ7F/aJ6hqRIZ3lzsFNHIXQnlZR91qV3S7Ub64si1p26J4+lY/WNqey+hbMoGdRU21tSW+fBu2gQtPnUjmt3gvMyCpMA7z11CDq9nqgiv3oFzwefERVfF4+cn3F3tJVYpj9M8NWzqirj0e7UMLMRVrfNGZtKIzEKPFJSHLqCF2l10/HQkoFMSH4AQ/BdpetyZepsiMa9veGDwqxjdoN9dVJmR5T0N2iuQzatHQQY2O8+XjXhQIsBGTSPvh7jRpiIhoTdQXsfKBlNa6DIGUWzd97Njcb2Bqv7NsgTwyNys4v635v34hxRXtC7GpMaPopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwHtWGMrkxduXvbDL1WPaw4Mmi5gmZK8xZLOX7Zi758=;
 b=b9Yt6RTPJqDZainRONjfUBbHkPGJJ9wj/JKYcxNl3QV4hiQpjOYOjKvAAk9q/INnYhELqETwizxNxe9L3EvLxCKCVmAgfcDuwyD7qKH0QED+fnW0Rjzuik7/zmhsdUjemzOABOhJhH7rtxztLgxyRrG40CwWWYyvII6OcFtKjBo5Ec1SiHPTYoi11giFCp6aX3nKXiKUvlRwI0VUD/y1IDMeh+qAgTBilFDQr78MNF2lqGJOqOg4sNXmf7X38oXqbdpX+Tqt+RVVAMQYRK1UjKklHZJU09oPZy7ptznYT6XJASYc5auFgJi3v+AxKVxuEBRNbpDTHPzzVe9E5/BxQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8740.namprd11.prod.outlook.com (2603:10b6:8:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 02:59:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 02:59:55 +0000
Date: Thu, 4 Sep 2025 10:59:45 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski
	<luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Nam Cao
	<namcao@linutronix.de>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<thomas.weissschuh@linutronix.de>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 3/3] vdso/datastore: Map zero page for unavailable data
Message-ID: <202509041007.5c891a1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250901-vdso-mlockall-v2-3-68f5a6f03345@linutronix.de>
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b26373c-5484-4dab-73ac-08ddeb5f202f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wiFy89Ne1t3kW+b118tAjfhR4//s1RQw+iMYap5BpaVBgYZAoBu+yMulPe92?=
 =?us-ascii?Q?OmHQz2aHs0+aMZsr1YgeBbyIy/3pvVeQrTpxbAlEHqRi+8xsQSsi97yhjuDn?=
 =?us-ascii?Q?g/C+fZjGpkGE286AVQzBk5h6tnR+ousaJRN/1615cydxV6DoLa74QVMMG+P7?=
 =?us-ascii?Q?ISMXZEchyAwbO0rpLgaqGo4mA4TXdNPUWuw8bogs96Tunvtow/tMaosZapdr?=
 =?us-ascii?Q?J/N5XxK6/giFdPx62/9GiaK641rzMOgzirLcDDHowPmOfVZQOJqpzcLgB9rh?=
 =?us-ascii?Q?ESJBy9rwEM2hM6rECUD/6Dxl26ZPAZlDJA3g5i4DeAbAi6cYMp/WOgLBsSk1?=
 =?us-ascii?Q?uYIGzG788AwsikIVAFYGUXvLtsq0InPLF87qTVJFhiNwAE8oo0FgNOQifYdT?=
 =?us-ascii?Q?5xUTJ/eg1zWDiLWCCTO30jJicW6uxS3gmJXeGfXzhEUBfy8Ebtryu2JBoODv?=
 =?us-ascii?Q?79uE1y4PRzgAl5IY96W3O1xMvzTX6ETWYQ0Tr1Ig6O49qcWtEZztWHjl/tRb?=
 =?us-ascii?Q?rzsI4sPReFUO8bArwgvEWmFmJi4KpXhpVi4akdVpcKyC2oknA92B/u/6BqK1?=
 =?us-ascii?Q?8CKsm1YQRwxp1SlxgHK4AMOK/0m4hh+c4jLfBjM7E3L8nYMkwJfo7A0i9WkH?=
 =?us-ascii?Q?K3ENEqa5r7pgHvE9sNYp70TFshpW/NkFCxfOw/DprQk4CTSXq26y+QLTo13p?=
 =?us-ascii?Q?zBQ6/fm5ZiR9FBu8Fz6Zayezdrf1Wrr6nTEeFZ9xQHrO9/EC7dyrL/esZtQ8?=
 =?us-ascii?Q?LdD3Vd1ZQG9mbfr/s2OciuKMTUszQkDd4dlGzKD/Khp6sjjSqFn8TCAFoEu5?=
 =?us-ascii?Q?I52skUH86iyH1qzMm/aO+iD508eBm30rF3J4GnNy2XdToKI/Z+9X1isDe4eN?=
 =?us-ascii?Q?wwJg7esXQcmrpj2CwnLhkUITyR/JXonGXP41YHlzpBUpDk/Z8s3uLjxFtd55?=
 =?us-ascii?Q?hmtHTZNmxFttf6ue8MARl9bW4levLq8JmR27ncJPwAEDQ+dxJdKHkBMdzxWB?=
 =?us-ascii?Q?/q0G6wQ5mh411CFxI/o6qN2Afx2iAR0p0Z0Zri9+nv/LhjHYQCODh+vrnRFT?=
 =?us-ascii?Q?T2vsArVkucAiJ8YngrSGSNGPUzatHAejkFeePsR3ILBF5JD4LIaVFMtIH6+3?=
 =?us-ascii?Q?nws56xp+3yN19vaEvxhV8N0nOeBs4+0EN88Kvjqpca8VGTelyBmgHRs4C0Yy?=
 =?us-ascii?Q?KzhEkiE9/SXAWnZ0AU1BL1S/YvNH3TD8xLqW1m2djvhZO9ZdnIJr7gelCPae?=
 =?us-ascii?Q?qjmjeROW7E+qiCaEavZGwIvU/fK9KAMYYoVK6CQC5cq4GsLrtG6rBma9/jLE?=
 =?us-ascii?Q?QeNFosTXmOxYJSk5WCvOJidy24kUt7L6nQQM0994Al4S5SdMPCLyPCwngZl0?=
 =?us-ascii?Q?q1EssLLcYMh997385/4dyw9CNeJL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jabRcQz6itluo+IDZ5YrUCK30zTQi7yGZByI8+Z2tEiHlfPN9c9UbCxmciQq?=
 =?us-ascii?Q?+FdShcK8qCrvdhVM2mpheOjKblOJiq5URnuXhV6znrjiAUVFnu2ZrIgLQ4U+?=
 =?us-ascii?Q?In7tYykXcdahqU7ozV+5tCgFYNyTl3sm1qMdM7g3pSGsrLMbqKMgAGoQcrZK?=
 =?us-ascii?Q?6BlV9rIXtA2MpBWpWP5e8Hh+VWAA46r1dtMili/DFHykwG9Fz3JA/ZqkCXuS?=
 =?us-ascii?Q?ekb2fT/ZpBTUCrkIbwFySV5s+kTA+uCkOMR7dEtTUSdu9xJzWfYBdEbWiO6R?=
 =?us-ascii?Q?1yznvYItlrvvmqCPVpH4byxASI4eoY+1VXcvvZMjKBgrqFh2pqnwkIAmJj+D?=
 =?us-ascii?Q?5nfbgoa6EAmq6whoKCK5g1JlnbISldLQLZJESBqLWePQpk/6EAdZHP2xlNhn?=
 =?us-ascii?Q?WglrsWFLplsTmjjXVNJYh9QgSBFILfXyJ2sB092qFOuG36zkavmPSOrmdOPO?=
 =?us-ascii?Q?pdx/rAHc/vKWuIap9b38BYryLy4PWYkIk+ONVAv9pRlyjgiGOpsY1xHXwNvG?=
 =?us-ascii?Q?e1yaR69259B4wFNSl09F4EGxU5KbOWv49VpoEePWSGC+Y9BLMES39HtdVM70?=
 =?us-ascii?Q?UG38TXWBJuYKsRLZlGsaXJ/jBHnMXHFb6Kr1kprDmfk6pHZugWmoU91JE8MA?=
 =?us-ascii?Q?pY7CuWchYC00bY1BiWqFMOnVOdXgOQgZwXgVeFyWp9I4T43Zdzg+6QB2lfg0?=
 =?us-ascii?Q?pJXzFW5hPFKy04zlrHWZabBO4qtWLo2X6CH0B/j1zplV/L3jqibZwKb4YTmM?=
 =?us-ascii?Q?KWoSGAJp2iDlTTQH3uj/oM3+pDBFtrlwDApBIBWBmFQMqqnZD03uzcKbdZuK?=
 =?us-ascii?Q?h5qIkrZ8TcwtGWaPkOkE0v4QE/1Vnj+hBsADtM+ZfiYzVvcnLeF+XPciG/Sy?=
 =?us-ascii?Q?say9VrykcBTldHyxNs63rrdwIJz4421MtcpWtiyDEIxD8Ru2/ZIUzWb0LRfJ?=
 =?us-ascii?Q?P6qMbIONt2klKINShp/gjJY9BOqHqXI4XMJR3TQNnEV9Bu6Ni/Xc1rKiWEbO?=
 =?us-ascii?Q?iopm2f4uDp53HJ54v8eDq6ty/Ma4aUcWXYh3BcYNo9i06ayNglFEpVuKGkW1?=
 =?us-ascii?Q?1PU4YbDcdI3DWgD1d4WylzF1Yknhvh8gSd0CT7JXvVm0kYPxu6QY4btaBd+U?=
 =?us-ascii?Q?l5J6xgZdwVkpLqeZ9E55tKG8zjrlwzp0HgracZMPQsAqypDPv5NUInbfkiGY?=
 =?us-ascii?Q?aeKjM2ozK6fE2XWzGP9zzNahGQbIRyIJS24BIPN+DTB7MFUnvT6OzchlkcSt?=
 =?us-ascii?Q?nfXEyVNR3HTknPDOkOdvFBeMhA4I1H0IqfSdntUC8jy0l0ebis/cRIcYll9R?=
 =?us-ascii?Q?yqMeNlgPCHBjssaLnkbi/R/+fbXTC+lLnRXty5ox/fuYl/FJcTMvy/u9DyMk?=
 =?us-ascii?Q?CLgmW/AeVbgTfPFyWxmuFr6UBiM/y11Y1Df11LB4LrgHr1KUkGOh34qmxY2s?=
 =?us-ascii?Q?l4yoFDeR7uYhYONsax/WEw+lBcBWj7PvK7qzt8/d4tMGeZOL0mrjL/uAxzLA?=
 =?us-ascii?Q?6bgIfGIJg/mbQ3mUZTLBStSC7WYfeXwqx/9IB04myWNEOH6x4C7SjBgQBbej?=
 =?us-ascii?Q?OtqjD+VsCDAxJr/Z5y1RoAdiUQc+EcoUQZohj8OV41qff30tLgC6uzF1nrSh?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b26373c-5484-4dab-73ac-08ddeb5f202f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 02:59:55.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2d37EAPcFA4ck1Px4C7ytCzzEex0miU9y+XFTbAa4sIZmTqJ4AGuoDCiQf+lXISNs1ADlO2356BOAOjF+m68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8740
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_include/linux/rmap.h:#__folio_rmap_sanity_checks" on:

commit: a2efb5881ffebbc0d9dda8a9751e1d7867d97407 ("[PATCH v2 3/3] vdso/datastore: Map zero page for unavailable data")
url: https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/vdso-datastore-Explicitly-prevent-remote-access-to-timens-vvar-page/20250901-204507
patch link: https://lore.kernel.org/all/20250901-vdso-mlockall-v2-3-68f5a6f03345@linutronix.de/
patch subject: [PATCH v2 3/3] vdso/datastore: Map zero page for unavailable data

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: trivial



config: x86_64-randconfig-004-20250902
compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------------------+------------+------------+
|                                                                                      | c6b2010c61 | a2efb5881f |
+--------------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                       | 10         | 0          |
| WARNING:at_include/linux/rmap.h:#__folio_rmap_sanity_checks                          | 0          | 10         |
| RIP:__folio_rmap_sanity_checks                                                       | 0          | 10         |
| WARNING:at_mm/memory.c:#vm_normal_page                                               | 0          | 10         |
| RIP:vm_normal_page                                                                   | 0          | 10         |
+--------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509041007.5c891a1-lkp@intel.com


[  356.804073][  T816] ------------[ cut here ]------------
[ 356.804496][ T816] WARNING: CPU: 0 PID: 816 at include/linux/rmap.h:414 __folio_rmap_sanity_checks+0xa9/0x2ef 
[  356.805346][  T816] Modules linked in: rcutorture torture mousedev tiny_power_button button drm fuse drm_panel_orientation_quirks firmware_class
[  356.806436][  T816] CPU: 0 UID: 0 PID: 816 Comm: watchdog Not tainted 6.17.0-rc1-00003-ga2efb5881ffe #1 PREEMPT(lazy)
[  356.807235][  T816] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 356.808073][ T816] RIP: __folio_rmap_sanity_checks+0xa9/0x2ef 
[ 356.808648][ T816] Code: 75 43 4c 89 e7 48 c7 c6 6c 3e 99 aa e8 26 12 fe ff b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 60 14 2b ab e8 20 78 f6 ff 90 <0f> 0b 90 b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 30 14 2b ab
All code
========
   0:	75 43                	jne    0x45
   2:	4c 89 e7             	mov    %r12,%rdi
   5:	48 c7 c6 6c 3e 99 aa 	mov    $0xffffffffaa993e6c,%rsi
   c:	e8 26 12 fe ff       	call   0xfffffffffffe1237
  11:	b9 01 00 00 00       	mov    $0x1,%ecx
  16:	31 d2                	xor    %edx,%edx
  18:	be 01 00 00 00       	mov    $0x1,%esi
  1d:	48 c7 c7 60 14 2b ab 	mov    $0xffffffffab2b1460,%rdi
  24:	e8 20 78 f6 ff       	call   0xfffffffffff67849
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	b9 01 00 00 00       	mov    $0x1,%ecx
  32:	31 d2                	xor    %edx,%edx
  34:	be 01 00 00 00       	mov    $0x1,%esi
  39:	48 c7 c7 30 14 2b ab 	mov    $0xffffffffab2b1430,%rdi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	b9 01 00 00 00       	mov    $0x1,%ecx
   8:	31 d2                	xor    %edx,%edx
   a:	be 01 00 00 00       	mov    $0x1,%esi
   f:	48 c7 c7 30 14 2b ab 	mov    $0xffffffffab2b1430,%rdi
[  356.810186][  T816] RSP: 0000:ffff888134027ac0 EFLAGS: 00010202
[  356.810645][  T816] RAX: 0000000000000047 RBX: 0000000000000001 RCX: 0000000000000001
[  356.811230][  T816] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffab2b1460
[  356.811812][  T816] RBP: ffff888134027af0 R08: 0000000000000000 R09: 0000000098376116
[  356.812426][  T816] R10: ffffffffab039418 R11: 6e776f5f65676170 R12: ffffea0008d4e800
[  356.812956][  T816] R13: ffffea0008d4e800 R14: 00000000002353a0 R15: 0000000000000001
[  356.813474][  T816] FS:  0000000000000000(0000) GS:0000000000000000(0063) knlGS:00000000f7f5d180
[  356.814114][  T816] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  356.814536][  T816] CR2: 00000000f69bf000 CR3: 000000013380e000 CR4: 00000000000406b0
[  356.815051][  T816] Call Trace:
[  356.815271][  T816]  <TASK>
[ 356.815472][ T816] folio_add_file_rmap_ptes (mm/rmap.c:1256 mm/rmap.c:1620 mm/rmap.c:1642) 
[ 356.815828][ T816] set_pte_range (mm/memory.c:5313) 
[ 356.816166][ T816] finish_fault (mm/memory.c:5438) 
[ 356.816458][ T816] ? mmap_read_trylock (include/linux/mmap_lock.h:42 include/linux/mmap_lock.h:473) 
[ 356.816779][ T816] do_read_fault (mm/memory.c:5578) 
[ 356.817083][ T816] do_pte_missing (mm/memory.c:5707 mm/memory.c:4234) 
[ 356.817405][ T816] handle_pte_fault (mm/memory.c:6052) 
[ 356.817800][ T816] __handle_mm_fault (mm/memory.c:6196) 
[ 356.818061][ T816] handle_mm_fault (mm/memory.c:6375) 
[ 356.818306][ T816] faultin_page (mm/gup.c:1146) 
[ 356.818539][ T816] __get_user_pages (mm/gup.c:1448) 
[ 356.818788][ T816] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:445 (discriminator 3)) 
[ 356.819052][ T816] populate_vma_page_range (mm/gup.c:1880 (discriminator 4)) 
[ 356.819336][ T816] __mm_populate (mm/gup.c:1984) 
[ 356.819571][ T816] __do_sys_mlockall (mm/mlock.c:771) 
[ 356.819824][ T816] __ia32_sys_mlockall (mm/mlock.c:745) 
[ 356.820108][ T816] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-004-20250902/./arch/x86/include/generated/asm/syscalls_32.h:153) 
[ 356.820361][ T816] do_int80_emulation (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:172) 
[ 356.820799][ T816] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[  356.821214][  T816] RIP: 0023:0xf7f64579
[ 356.833927][ T816] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 0f 1f 40 00 cd 80 <5d> 5a 59 c3 90 90 90 90 2e 8d b4 26 00 00 00 00 8d b4 26 00 00 00
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	0f 1f 40 00          	nopl   0x0(%rax)
  28:	cd 80                	int    $0x80
  2a:*	5d                   	pop    %rbp		<-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	2e 8d b4 26 00 00 00 	cs lea 0x0(%rsi,%riz,1),%esi
  39:	00 
  3a:	8d                   	.byte 0x8d
  3b:	b4 26                	mov    $0x26,%ah
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	2e 8d b4 26 00 00 00 	cs lea 0x0(%rsi,%riz,1),%esi
   f:	00 
  10:	8d                   	.byte 0x8d
  11:	b4 26                	mov    $0x26,%ah
  13:	00 00                	add    %al,(%rax)
	...
[  356.835490][  T816] RSP: 002b:00000000ff91bdbc EFLAGS: 00000296 ORIG_RAX: 0000000000000098
[  356.836193][  T816] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000000
[  356.836811][  T816] RDX: 000000005664ddf8 RSI: 0000000000000330 RDI: 000000005664eac4
[  356.837429][  T816] RBP: 00000000ff91c098 R08: 0000000000000000 R09: 0000000000000000
[  356.842378][  T816] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  356.843073][  T816] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  356.843785][  T816]  </TASK>
[  356.844134][  T816] irq event stamp: 4067
[ 356.844505][ T816] hardirqs last enabled at (4075): __up_console_sem (arch/x86/include/asm/irqflags.h:26 (discriminator 3) arch/x86/include/asm/irqflags.h:109 (discriminator 3) arch/x86/include/asm/irqflags.h:151 (discriminator 3) kernel/printk/printk.c:344 (discriminator 3)) 
[ 356.845309][ T816] hardirqs last disabled at (4082): __up_console_sem (kernel/printk/printk.c:342 (discriminator 3)) 
[ 356.846150][ T816] softirqs last enabled at (4064): handle_softirqs (kernel/softirq.c:426 kernel/softirq.c:607) 
[ 356.846879][ T816] softirqs last disabled at (4053): __do_softirq (kernel/softirq.c:614) 
[  356.847568][  T816] ---[ end trace 0000000000000000 ]---
[  OK  ] Started watchdog daemon.
[  OK  ] Reached target Graphical Interface.


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250904/202509041007.5c891a1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


