Return-Path: <linux-kernel+bounces-759933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24865B1E49C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF78581F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD7124E4A8;
	Fri,  8 Aug 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/Llcb80"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFA20E328
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642747; cv=fail; b=dK8iL0IRRbIEg3A0EFdAfINQUJQDYqEZcaP8zsWW0lv6J7HWb8aQQC+GAJK1xEyT0j/jWHCuD6HzqM4X6k4DW8vIOq/jpXqrJSx8al0bp9zPobKWbpILTafLcp8ytchcSZQgI9yM1GLF5TMCF5nuszBejlJg7HmQqHnUO3AZgKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642747; c=relaxed/simple;
	bh=NdaXYcbjH0p5yAObG9Rrh0L18ng2uYmjjKZIv7a9Jhg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=AJcprz4JKp3Pn+E1SZ+R3Wg/cuEy542EVuGAkYVVZUib9gqCZe5tCDLlKwYcl3k5KtyGlN66z0TitmQ3ctgrNgIGT+nZsMKMVnS655JoW2rRoyE4RMI0vGT/NoHAY2zwKzEh7JaKN1iZG6ny9SNIzthfF/JfrPmALrhMaAgxw9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/Llcb80; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754642747; x=1786178747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NdaXYcbjH0p5yAObG9Rrh0L18ng2uYmjjKZIv7a9Jhg=;
  b=Z/Llcb80oHlr8PzbwOfDyny2+tTCNw2yDv9K83YgC/lSb7EgmPqICvQ9
   OwHi3eiFPXr/CY9/dTTjLZcwGwCALXoja4yZzi4OMLniv29iglpHyDby1
   xXKNXNGO0Xk5Cm72toqLIoIl7na3u4Xy7IgoIwUrDonl2goPNcYPgkGHC
   ZeAGbFmpxvc8TBOgOr5X3oE8h4KEKombNklWzFhQnvK8qzqa+V+DrxnZD
   E00EzEIi3sQaljfFxF5U7ijKfNplTc3Wmqq+tRCZRfyXynJeH40TrrGNG
   KykI+rzvAndbrTySErGp2bV4W3wEu7Nt01+jpF9beWwhn9AZuLRH2Xy6S
   g==;
X-CSE-ConnectionGUID: B4NTvEtiTkiEleUZgTQfaw==
X-CSE-MsgGUID: Il3pRD8vQ0u6s6xzXsOlEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="79545371"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="79545371"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 01:45:46 -0700
X-CSE-ConnectionGUID: bSNedXszS0iGxZagk6iYqQ==
X-CSE-MsgGUID: 80MZkGbqQPKsuKqF5K3kfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165664680"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 01:45:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 01:45:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 01:45:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.41)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 01:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS1nNV1D/i+tHRMDcp97RVeyWfyBznMS+QXVJKyhAqgaMTQiCGwksQmYi6GjPd7RnhdqlmznPu98Y+3HU1xwnUVQnc6Ai+cRJkaoeqyMo/PLMv4156XGJoU45iE9DecDsiK4Qsyz3Bxeia6l7c7HVqngX2OGKQT4KT/tBPA7H8x7hH+ABsla6r2qn1pMsLhC6MC3rqnWqLsb7lUQ5kLYZvbetZkylr/rf1wye6afPkAUsg04MsnY5913cyoQL4s92rlEQLGCc28qvPbKkOfbAReKJVX/l3ia4EIDlk/FgBK9J8C2vlKlBmoh6BUAcwXFMuhmEq/ay+gw6hoarfDvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imWnHra0svNW1aMgYf8t37K9bSPETg6G1ZMrVQNnagc=;
 b=vB4N0nUJ04BN/BbUZcMHbtJHRC/MycnORt2Yxr67OcyXQ7p0LxZCkSfs7hSvHEPdR5IsTZqdTbqDGepaos/Q4CkJ+XJ/edcn/8X+7uVFFyZyP5GQ01dMx/ejlnOQIZRO1K50Ia3F6UEcfexzHRCayvMXvFq4Ka7IMPllNoNshiRX48N4C1VbJBiLdEoyPDT41YSrY3AyG3+pzu/2nctlJFtC7KaKekl1i6IX5sxVywV2VukGh9C//Ii+ZoU6t8b/67XWWz11CEamrh4UWR4aL0vSQnyoSjhHz/zsl8iiD9Y8ApQeGJzqalYKaU6DBSiFWaGO+pffYXqCWx5vkPyE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5324.namprd11.prod.outlook.com (2603:10b6:408:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 08:45:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 08:45:42 +0000
Date: Fri, 8 Aug 2025 16:45:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mike Rapoport <rppt@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, Shuah Khan
	<shuah@kernel.org>, <kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [kho]  b753522bed:
 INFO:trying_to_register_non-static_key
Message-ID: <202508081032.1450e413-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: 197a84d2-2546-40df-ed31-08ddd657f51a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TO6s2jY8+XjU1NsFx9ZCvlo64M/6ljn8iiOaHv7blIBCJ/5FclXQt8wv3De7?=
 =?us-ascii?Q?EM8nLQL/OLwkpyZqUr9f0qCDxQ92QaZs6owqCsft2mNqCxyIj5fTXuZOOOdP?=
 =?us-ascii?Q?nR/QRgAnMNWaUw476yXojdNV++xHRvdNqgFqpK/PtC7l0VvLTSOzooZJq4yW?=
 =?us-ascii?Q?plphRDU5zg+DGq5zl6OoG0hV/C1oNNc47QUpU48NkMbfVBjpdpQ4pUUBcoMo?=
 =?us-ascii?Q?nf7GdMKX4SXxMDDp/07tLZxMwx4PNI8g0HwHrub3An3BKZ+Q1xjbdIEtceW5?=
 =?us-ascii?Q?8/FtxsSS0Z1d6NLLibpQ6CsgTbo7U+N3CpR2EX3BK2Re3gS/ds8P+/IhFYU7?=
 =?us-ascii?Q?6vwDtkw8DEmbyiH79WNs7XrCHJiE/KG0SzhDfRTZo/jRqG5BwKk+8b4gcnnU?=
 =?us-ascii?Q?6tWHBMGSPefY4Al/Ot+1uz9WQg0fSQvptYIwuBAIB27/PYB5yNFCwXQWajgO?=
 =?us-ascii?Q?mq4HEWw+/g0qCZP1EWmcPFZD0Hx+dNafo4CECvAgUMsfpHsIoCF9c/Jaed1n?=
 =?us-ascii?Q?tiaQk0OCGz9d0KWxfKbrrP4iLMEiUuXpRfvJrnoK4UDRQQI+9Q58V7H/x0XY?=
 =?us-ascii?Q?KZu6ovwTB8bXIp9XkjmHAHnL6s8MCYf6f1laN7t6ZEaOvdP2ZxO0LHL2QZcB?=
 =?us-ascii?Q?fqpQa/gME8Z7xIVs1oAuuCa4byY1ac7y7Q3NMz4oZ/gkHI64Th9m5NCPt39A?=
 =?us-ascii?Q?WS93ZZOlT22GL17OEOJqLEAyVaOk8TOyWTHl7D+Z18rnbw15vgSgoYrf3rbE?=
 =?us-ascii?Q?eAKAlDhNA9dpHOHYPS4XtrfFIkJ4zBmrK+f8wvYt++IFZPOi6LThmJkgXME+?=
 =?us-ascii?Q?aBZBN7Dr4irtF3xEPy2PVK327/S2tdCxeSbY4zHLrOH638swlztJJBcFXA4w?=
 =?us-ascii?Q?Eyx6Gyk/AurgjWKXATf/1Cy/r3ExHEmt/5moo+eCZCh/yj4s9pKVlBlou0l0?=
 =?us-ascii?Q?qgp4ehcFX0H6BXycaRiozOLwgukionSPg3/iCPdMJxRjBN/KrY+mmqqrCIWs?=
 =?us-ascii?Q?JpmNEK+tl7c1A2kC4zabq5BlwvY57wCjAAV1hJDy6ZdjDbVl33KgFEcFPpal?=
 =?us-ascii?Q?6PiFdGwuPwU3hoh5iIPw5j74Pe0HotdwPJF5ft+nMxNzilwcJaXBJIMQNbIq?=
 =?us-ascii?Q?YbonsoKLUh6Gw5LXSTGpSP97R1U01+DSsa/SKKhLMERVJcbNu3Mwyw7w1O9b?=
 =?us-ascii?Q?7Zw07xaFDhU8vjiq56e53MEhDI88tS+xJJDSFPMBR6eVMDB33GbeXVEMDR0b?=
 =?us-ascii?Q?hvsgrN5NV8mXcRbCtVLGprFSj88Dp8uyhVL3f4PNN7Aj3AVN0h38Jv0e+xLT?=
 =?us-ascii?Q?mLeAc40LE5lhdrXQzQAPme5sndDSoLsUIjus9CAAbUvZ2GEUmxBIibP79KcK?=
 =?us-ascii?Q?ZyiSa/fHZPLSDYWvbyeNJLyURbgo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ae740CzQiHuE/igf+BaNCtrFCv5nB70fIUm3ieUMQGMGifQO5YyY6lNunyHK?=
 =?us-ascii?Q?zNfZjDfslNyWwS9YfB771UcfCe01OJFA3rbGUczklHOGAseLSTr9dmlZR84Z?=
 =?us-ascii?Q?o9jEGW9q1PIT93GSak24FnpoQsZNAnSNM3ISIr1fY3/oYOHIX0t/TQXx4rbC?=
 =?us-ascii?Q?IOka+dFmn0Q8Eo9HCJnXFYI8s7BaXHyENOyKDYiCoekjOPuyP8iKNsnwoffy?=
 =?us-ascii?Q?8MkjE4w8TWaYchGURdQfLhuzHJPkFURJTMX/2n8WnbMjrGhSDTUyFsbGvdgJ?=
 =?us-ascii?Q?Olag0syFK81tVdpLjWY5DtC04c1bqHvD4m+MNwhDWfyWbQScwJUmJTFgfKre?=
 =?us-ascii?Q?WNGqKELzF+YQaDZFh79L/d4Bwd0xgkKGNKNFULaFO0lsd8rWU4n+1fdqv3xW?=
 =?us-ascii?Q?dBQNvZ7hzGUbkNqQ88pqb4vcjZgHqd5D8DjxettXJvu8y8mPR9EHFZaSyONF?=
 =?us-ascii?Q?s/AcFNBmre5fIBhrNIGNhjL1H/XfnLfoWtMsuYpRqJ/O7vq3THizgMWZfBHV?=
 =?us-ascii?Q?D3g9E+IbFyDQEOVbouUfaevvDRpzYhs7hOV8oPyMUFalQ0ybUy2XJ0qG/7NM?=
 =?us-ascii?Q?7x3Xk8VkjMCGJP/GBQ3y9KPJoAjVrmPR0r3UHokbRH+Gq/zhqdZAWzTYqtRm?=
 =?us-ascii?Q?0bpgXQJ1p7ICwpT+KvVLvVGRLeleEacVC2AxHjDjVB3VgngIo4wMNJExcwro?=
 =?us-ascii?Q?7jCs3I56M5Uk2j6mAU+Xr3T9MCOm/wcLT66+Y2vPy1NC2tiI4pDALJKB3Nr8?=
 =?us-ascii?Q?Oik2tmM5uYeLFN2SQ3uXtcMOllTMzxZlfMJXD/vERkF+hLSS9J+jTuX/AV/d?=
 =?us-ascii?Q?rOtyp94lKnbv1jTp1fUtplcsMIVKQBUv+yrA/RoXFCcrq289LEurhZD71ecE?=
 =?us-ascii?Q?Y7+0Kx7dG0K/N+BepKRFmvr8ns44frh3X0gL9jtK0sUrMyuLrMgurRPHC7w/?=
 =?us-ascii?Q?izKYugC7AnP3kblGoqIynq5A+nS0/dvkTtcNAjyFApwHtwroLHxAxU3H9YKK?=
 =?us-ascii?Q?JAVLNTg96vIrMznHO5bfFQGcKJbrMh3Ko+FWWOieriGek3umJCXDH2zTGxGV?=
 =?us-ascii?Q?NjjbVP9lWJQAUru9SXLf9998KM+HpRijtNAMG73/gtDKWsqgMCTdLJYq/onO?=
 =?us-ascii?Q?H43g2+UGJKAoC9C1l/+W5PBtN+AeMiFt2JveBWEPht9lfCrARR0nlNPxJd3l?=
 =?us-ascii?Q?8g9Y3HHS8MnXB3m7Wm9W3z8J1bJrb9sah5SZ8Z4eeu5PnXMiqrHD81aikNmd?=
 =?us-ascii?Q?S8U/g1OmmYvK1apXdZerUxWkP6H+0dN86XGL8uVwiHDmCq3YFfLk4BQxYynG?=
 =?us-ascii?Q?7uBTYGs4c9Cd8yVCZXD9ew6UyCfadPz+IM2qHyiAPFi5SYYBPmzP1B5/wZLp?=
 =?us-ascii?Q?WrOn5sgY4eE3ZF+7i6HhcB23QTnCXiDTAV2Ki8Q0yHj1N65wvBT8kNfI0kjK?=
 =?us-ascii?Q?RAi3d+JgOeZlo1+5vHOD9Tq99FezOEoUAbSnCDYN67LJDbArFY8LC3GLpApl?=
 =?us-ascii?Q?gOtcXSruE2r6XHn5ahrUuwSTpUNRhlQd3n0Zv2oKBXvxJ4pe2Icvq2Z5LyIc?=
 =?us-ascii?Q?DB8VA6OyrS9EmSvB/HtQed4oosJCOsp4Y32UFjoTjm0cQAn+EN/T0F10jkzW?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 197a84d2-2546-40df-ed31-08ddd657f51a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 08:45:42.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/kLwyPqvsOvT1wOdckHXMERwTSrMvYD7OP8FIwFKnw0tQYdWfoo0ePgEsTbbplljP4a9zgnYkw+mcZCUaQ0mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5324
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "INFO:trying_to_register_non-static_key" on:

commit: b753522bed0b7e388a643f58d91bd81d8849ba43 ("kho: add test for kexec handover")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master cca7a0aae8958c9b1cd14116cb8b2f22ace2205e]
[test failed on linux-next/master b7d4e259682caccb51a25283655f2c8f02e32d23]

in testcase: boot

config: x86_64-randconfig-075-20250806
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508081032.1450e413-lkp@intel.com


[   59.011407][    T1] INFO: trying to register non-static key.
[   59.011783][    T1] The code is fine but needs lockdep annotation, or maybe
[   59.011783][    T1] you didn't initialize this object before use?
[   59.011783][    T1] turning off the locking correctness validator.
[   59.011783][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.16.0-rc5-00079-gb753522bed0b #1 PREEMPT(voluntary)
[   59.011783][    T1] Tainted: [T]=RANDSTRUCT
[   59.011783][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   59.011783][    T1] Call Trace:
[   59.011783][    T1]  <TASK>
[ 59.011783][ T1] dump_stack_lvl (lib/dump_stack.c:123) 
[ 59.011783][ T1] assign_lock_key (kernel/locking/lockdep.c:988) 
[ 59.011783][ T1] register_lock_class (kernel/locking/lockdep.c:?) 
[ 59.011783][ T1] __lock_acquire (kernel/locking/lockdep.c:?) 
[ 59.011783][ T1] lock_acquire (kernel/locking/lockdep.c:5871) 
[ 59.011783][ T1] ? xa_load_or_alloc (include/linux/xarray.h:699 kernel/kexec_handover.c:106) 
[ 59.011783][ T1] ? tracer_preempt_off (kernel/trace/trace_irqsoff.c:412) 
[ 59.011783][ T1] _raw_spin_lock (include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
[ 59.011783][ T1] ? xa_load_or_alloc (include/linux/xarray.h:699 kernel/kexec_handover.c:106) 
[ 59.011783][ T1] xa_load_or_alloc (include/linux/xarray.h:699 kernel/kexec_handover.c:106) 
[ 59.011783][ T1] __kho_preserve_order (kernel/kexec_handover.c:156) 
[ 59.011783][ T1] kho_test_init (lib/test_kho.c:84) 
[ 59.011783][ T1] ? __cfi_kho_test_init (lib/test_kho.c:271) 
[ 59.011783][ T1] do_one_initcall (init/main.c:1274) 
[ 59.011783][ T1] ? __cfi_kho_test_init (lib/test_kho.c:271) 
[ 59.011783][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 59.011783][ T1] ? kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68) 
[ 59.011783][ T1] ? __kasan_kmalloc (mm/kasan/common.c:398) 
[ 59.011783][ T1] ? tracer_hardirqs_off (kernel/trace/trace_irqsoff.c:412) 
[ 59.011783][ T1] ? do_initcalls (include/linux/slab.h:909 include/linux/slab.h:1039 init/main.c:1345) 
[ 59.011783][ T1] ? kernel_init_freeable (init/main.c:1588) 
[ 59.011783][ T1] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:452) 
[ 59.011783][ T1] ? tracer_hardirqs_off (kernel/trace/trace_irqsoff.c:412) 
[ 59.011783][ T1] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:452) 
[ 59.011783][ T1] ? irqentry_exit (kernel/entry/common.c:311) 
[ 59.011783][ T1] ? next_arg (lib/cmdline.c:273) 
[ 59.011783][ T1] ? parameq (kernel/params.c:91) 
[ 59.011783][ T1] ? parse_args (kernel/params.c:?) 
[ 59.011783][ T1] do_initcall_level (init/main.c:1335) 
[ 59.011783][ T1] do_initcalls (init/main.c:1349) 
[ 59.011783][ T1] kernel_init_freeable (init/main.c:1588) 
[ 59.011783][ T1] ? __cfi_kernel_init (init/main.c:1466) 
[ 59.011783][ T1] kernel_init (init/main.c:1476) 
[ 59.011783][ T1] ? __cfi_kernel_init (init/main.c:1466) 
[ 59.011783][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 59.011783][ T1] ? __cfi_kernel_init (init/main.c:1466) 
[ 59.011783][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[   59.011783][    T1]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250808/202508081032.1450e413-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


