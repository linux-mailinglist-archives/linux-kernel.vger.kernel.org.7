Return-Path: <linux-kernel+bounces-770393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB9B27A38
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E5CBA1C84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DDF2D1911;
	Fri, 15 Aug 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzTWyx6B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE952D2385
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243385; cv=fail; b=Jqtn9IoT/UG/J0C7KzymykSXLJPH11h9ztX5OxTTA/IE97/JCElyFCyVjkrVL9HjbxunetYdXXwOesik+hp7cgGVQKwFwQK+R45CwciFyV4ruibd9tqbA8zCRYO3rFI5ZthMHWdbGUuaGAXPK4hceU6TFZkkaH1DWrp6oSuitKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243385; c=relaxed/simple;
	bh=up3G4kJ8Ih/PETdQVynPqvb17RkKWhIm4DJ7C90eIX4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=oiCKlqtVFtatqg52JuRbuGxl0EdFyXOebWpaDB7Zd+6kZE2F4vXS26+BHOM3rDvx4OZG9/0/7fEhRg5B1Cf2F0WHGeGPUNX5ELAXWvauP2dmQ10gc98GbiYXlS//wJd15Tf6ujE/dPtrVbZF/Wh1AJLl+K/0itynmK99/wNznQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzTWyx6B; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755243383; x=1786779383;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=up3G4kJ8Ih/PETdQVynPqvb17RkKWhIm4DJ7C90eIX4=;
  b=CzTWyx6Bli3NEXdBEsy8xNMrwpe5orVkWvDvmTLjEIr02u3/k3uvulMX
   TbS7V3luxNs1rc2Onk3Ix6tiqS0l2KjWE3NmJSJAsTCdda4QSPW1KKJOb
   6KFxnZCUQ79HQgQBvy+9bAzNvtmwVC3hNee3nMU9uJMe4aaWQie8KvuBw
   v0bEslSw5QWMBPdRU6fNjGgO+hbNRFWpkNJg27f3cUL0V2CEbrFV/Ly6d
   EcjGfgFpZEVZXA2QuYHP0v4dWVJnZ5EuwOQi2akL+KoXACqdQxZgIamMJ
   eqyZCCqUJSylK5qTq4GeIlOTLZacrYk933Wi6XE2mnpt1D9XqxIdj9ObE
   w==;
X-CSE-ConnectionGUID: Fyb8bLkXTGCo4Rm3MpWHsQ==
X-CSE-MsgGUID: i+hvHDHLSyiR3XC0D8sgcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57478581"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57478581"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 00:36:16 -0700
X-CSE-ConnectionGUID: L2KqwqH7QXi5DUNIjrMSDA==
X-CSE-MsgGUID: pfHQMgIrR0qBhz9eCxMy4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="204142335"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 00:36:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 00:36:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 00:36:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.69)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 00:36:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6A84iGNd9VDknnFJgzgq3U77slwVZodmiNO1mjm8yaYqhYSe47q67TpiCsgDkcgKyux5vQr45NFHsD57BK72nOEwywNKpUErUhFjjgv7I5eDtBOeZ3JZ3tReX7ktn0H9+Cl2qMu8BFAUsLiyg8L0s2gdsi5VrIv98KRz+EHxoqE5v/m6FEXhyyCvI31gV4A2QyuoaaYmC6ICmKIwiFhf6qXv7PBuf7laefcLe4lh00YkpMrZJ9+uDGtnqnXAmbXE9VMmOjgPXCXaFXcTKRbycMeWqvg+4onZsyisITNx4C/JkH1FvkUrRUzgYOrbmZX/SGpRyiPSZ+zXEcRyCh3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p7upnogcU+ReYyfN58Z0czb/V906lFDtWCzDN+qUuM=;
 b=tVqZcFPdMXNuBcGglvPzMM7W8bALFgT0LxmFT0Ex9az+ZLyGh+Qb9BQ/QIjpFLzkmYmQ1vavS/kooXDa2xTB8nZqvvPSPZEYoEcD2MDQFfgkbFy3O3CQoqU5GERzsKwCJNPxXg3keJNVk0ck0nU73ltGKCsmTy5XY4Ur0ht3rPLFEKf/z/vf9/i6BgHg6LlJum/iZf/0k2kv2KXvw+NKnVOPnz9pazxb7JMt6M/B7BzKY9O9UF4uVb5rT7JWxIjMadAvP4qym2MLjdVXW3GxAvHWKHUjEY7piQMKvOI1z01Unin7NDrzb08qvssISHS0h3wtGs0cKCghWtAVKTySZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8749.namprd11.prod.outlook.com (2603:10b6:610:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 07:36:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 07:36:09 +0000
Date: Fri, 15 Aug 2025 15:36:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, <oliver.sang@intel.com>
Subject: [linus:master] [llist]  375700bab5:  will-it-scale.per_thread_ops
 2.6% regression
Message-ID: <202508150803.d5387224-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 43991e2a-b1f8-4832-b103-08dddbce6677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?AsPo/zt8MIxyOlOOSFUMUMk5Szis7c2USUQdAjCn9M6Zjm5LuyNTLbE9ND?=
 =?iso-8859-1?Q?wLp5iClN+DC4+ImEe/rt3Vw1sdOJoLPtGu5fkB4vJrsEQBdoei3R9x+fSA?=
 =?iso-8859-1?Q?LpdttGuO+k9CVhsxABItZmxXkJMesS+4rR6Ch42BT/aqk+YOHc3fLizsjd?=
 =?iso-8859-1?Q?8A0tACWyEkPIiRG+UvUQjqBu+yHmQ+dGWrB2p9cxXP32x07c1az5sqtzW9?=
 =?iso-8859-1?Q?+V1HOUWp6DFA3RCYyAZxEY/x6k3+GhjWxDPoeEJxe5f+RJG1nPQIIvY7Dl?=
 =?iso-8859-1?Q?Wt19L3nY61Gp8hQJdUuv/IbA9rprRdAaeZYx+yK9RGmCmlvZP8dnlFVD7N?=
 =?iso-8859-1?Q?U9hKpixWIuVqrx+/37ARjXDsQaO4yoA58HdxlDaE+OGraSuwbJ7IEy+bBa?=
 =?iso-8859-1?Q?K2CnnSJy6u6OTXNeBOzlnhq8N+0vxgEATfEEt+rn9zkUD3ebA74pnfT8l5?=
 =?iso-8859-1?Q?7kOaURrcZh0gIM91QE4Uhg2bbfSbIu0+cerR5DS7257Atk1b7D/JpMyopH?=
 =?iso-8859-1?Q?GkL1WUaiOqzxis5AlbDfoWzoYTKVABLnEmBi/xLtQsA8sO0Q5FY5ZZlB4n?=
 =?iso-8859-1?Q?QT0MmqL2zxCFk+9D9MOTpS+hZbZmigAHED3I0VW0Cvfe5x2g6KWSwZrIzA?=
 =?iso-8859-1?Q?a6sdcmMCjT5/9CxWxQ0vSLv6nDumWo/il1ypV0A0UYRRU0U07pd14FUifb?=
 =?iso-8859-1?Q?OUDxORGUVpx9Wpy3iuYgl362KG+VJbPy7RmTdoakctaWPZ/tMDNmejLpdy?=
 =?iso-8859-1?Q?8ZKwJMVgWwEkr/qTm0B4QvtEf8vIcF06kiArkDqUODw5VWyzSf3P1b67HR?=
 =?iso-8859-1?Q?FaYriqbWC/eZ3PEKceCQMEJ1jgRnH5SKSbOwRIjhFs/wXzZb36qukwDxpX?=
 =?iso-8859-1?Q?M+Z5ILMAY/hI5g1qU23CrQvK69wkIo2kuRE3OfxoNYm27Fzhk5PZ3K5uRv?=
 =?iso-8859-1?Q?TlZahoxCg7oRaiWUmRm2i+DFOsdR7IQz28ROZocsUa0xJdA/RxYRH0zpL4?=
 =?iso-8859-1?Q?Odb3GvGrYSNb/+tbAtAPBfbwWxABdYdxlnTXq16VXiXLHDZQIVWPaESwYG?=
 =?iso-8859-1?Q?EAt0oIhE73zzlBwkyY8Wgt9yuGkxX/M6OD+DwH6RsiZXOjxD8Dhdr/LqTE?=
 =?iso-8859-1?Q?pzSDRvw1wZzjca2nW6cBrYjubWEGSTIcm4z9t9c793v2MMZvEuiTmei1N7?=
 =?iso-8859-1?Q?SDzI0IRTcOjAYD8fhooXXw4BAVnJtzbMMw2jpxnDnW37USxDJdgY1ruNmu?=
 =?iso-8859-1?Q?9z/3diXgkoC9ImWVwRY0ArrMZh+DZHDdoTrqE/++FvEhw4PaTzpYt7Dyiz?=
 =?iso-8859-1?Q?2vOPFT/yjLvMHV2eoWczibUUAFwJRHnsg4dVWYro5tWV+9njpAxPextzGV?=
 =?iso-8859-1?Q?3Sssn4gIwmqBIoekiuepCuX8Zk9Yx5PlXI5ksfNKDrbA75HGpMe0ObCKDC?=
 =?iso-8859-1?Q?lHD/ZhRZF9fB7K9M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OtmQKciAi4pE8Q7zI/mAQc2Dr+bnVasHvsWgLtDBpxLsUBG7WuO9DFTOhd?=
 =?iso-8859-1?Q?T6haNz6btgRS0mvtpdpGLgii4TzpW2ffkHGI9IG3S3pgpDYgHHqA84jMLI?=
 =?iso-8859-1?Q?hgnOJNlIVmWQRwKEjmseWDEbjI3RG+rpn+mBI36SAATsHourFwIkEdpOyT?=
 =?iso-8859-1?Q?MtYgxnUhetby8vr0eSlCq3NV78n37mAq9dDdVTaRUKD3SKuFVY4pWY2HQ0?=
 =?iso-8859-1?Q?cjwJfagyWEdknftIalufLYcsZFCr3OpOAoQ+6hnm5mWmGP06NwE5NFhv75?=
 =?iso-8859-1?Q?1fsQyeVKz0yx2BsP10hBahreboFf/81rOdt+/LIJVxwmPX2OVYN6e0f+G0?=
 =?iso-8859-1?Q?fGxbpi3cFR0yXjOEU4v4HPaf4YmZXw5549zC1FLTSMhrIgrT76A1g3hqp5?=
 =?iso-8859-1?Q?wM3M1MihMgdBuzQ6ydZyRYsc/waAuja46eq1JZEkLuo1+7OYkIYm2P4e/f?=
 =?iso-8859-1?Q?T6sWKqlMRU/NKfyUrAjPnDnr1n1lCKa3+WbqrHNdSWuOQo4+43vMpBIYoK?=
 =?iso-8859-1?Q?83hrFmILq9n9glPXGUYhOFyj59PiVCIOH0K/+sotiGQGqPb/1HlClxnFh7?=
 =?iso-8859-1?Q?rP63qwdJJh1Wi+sv9SWWut+7jYz7rE7BGTe+MWAVVu+EQYFArW5Hsw/I15?=
 =?iso-8859-1?Q?0vk8rYipukvTYtkXHoY67ehq5CyUQ1qPcnz0iZEPcTbk0ZlTB4CBlrvuJ9?=
 =?iso-8859-1?Q?SXXwL9ms2B4J6K+Tr3xS/iT5LIlj7ngjU+ZYWBr2Xko3q7z0r7gM5RHsiW?=
 =?iso-8859-1?Q?T4aDpDpTU9+Z7JerfgM4jAzDxSUvrXhujfOk63WUUjVf/5NzH/H+uSrpP6?=
 =?iso-8859-1?Q?t/lvDpLi0N97BAJuoGZNvelBxRt1xTS/jTSU8CU2lA9U8AZFSiMFJvCbFj?=
 =?iso-8859-1?Q?syXkhBT0Y+E+VwpOg1QLZK7muLReZjZq7DVGtuyrI4xwyPB1QdrC1SXJg2?=
 =?iso-8859-1?Q?C+dP5ruDOnjezB2QkF7ZEzIZjyu/9ltWL2r84JHUzIyGaErTpGesaJth2d?=
 =?iso-8859-1?Q?FP5DCGH9YCi2IomEvRHTZfrw/NPhIWTT+ym+Tj/sXZsXnbxO7ZNLmiPLAT?=
 =?iso-8859-1?Q?+EcoEiUUbsAApQa6EpXzeejPTJFUuO+1is/EyG+2bWdIVs24sLK5zcn31j?=
 =?iso-8859-1?Q?hMiotBj/nYoyG8wg6e/m3Q9nZ3Y+N5if/SkY8pa007TEVNZTeTXef9WZXA?=
 =?iso-8859-1?Q?vogc+uQuc9QyvOFDdVeJJSaQqHedTVHVhqF3R+TivwdgAxxr3WXbLfoCKy?=
 =?iso-8859-1?Q?ZeJaLK7UCgOi1ZziXXN6XQ3UjdO97jWrf+WGHcuh7ag+sSh4qgbuNFp1Ao?=
 =?iso-8859-1?Q?BuOnD9Em4YbAVgBuvghvkKqQ9aBYDNZEI7OiO6Ww3HYwZAvIzMO7npxqa6?=
 =?iso-8859-1?Q?cPhFaQlR+wdPdUil+LaW2eTZcWns1rx/vIAsnmYX0Ar70dElpP/F50P/wu?=
 =?iso-8859-1?Q?ZQrviB9Go+3vwNKwi0yCwd6AOH+tBRkIESt6ZLna7BEnaysIrk/834W0QU?=
 =?iso-8859-1?Q?tYreztT9BJUjATkO9UC7LcnxgbjnEOCGYXvUrChCwZePxsxZFRKGbBx3Vj?=
 =?iso-8859-1?Q?AcuxkuGiXd+sYOGobkcbhIk8Uo7CSCZrHZpUkJ52MLRdLXU2Ubh0pM+pYe?=
 =?iso-8859-1?Q?du/47bDbb44oz1J0bH5MXDyginzS/DgSn+BDNWx2MryUVeqL9H3jWmKg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43991e2a-b1f8-4832-b103-08dddbce6677
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 07:36:08.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpFF12ntaBtGNAgpy+02ObNHgmm/C4DgVmOIXbIz1cAjYI2UC8NOmCku0A+cdVi+zr2IWk2KWJCak5uqpU9TPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8749
X-OriginatorOrg: intel.com



Hello,


kernel test robot noticed a 2.6% regression of will-it-scale.per_thread_ops on:


commit: 375700bab5b150e876e42d894a9a7470881f8a61 ("llist: make llist_add_batch() a static inline")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on      linus/master 8742b2d8935f476449ef37e263bc4da3295c7b58]
[still regression on linux-next/master 2674d1eadaa2fd3a918dfcdb6d0bb49efe8a8bb9]

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 176G memory
parameters:

	nr_task: 100%
	mode: thread
	test: tlb_flush3
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508150803.d5387224-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250815/202508150803.d5387224-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-csl-2sp10/tlb_flush3/will-it-scale

commit: 
  5ef2dccfcc ("delayacct: remove redundant code and adjust indentation")
  375700bab5 ("llist: make llist_add_batch() a static inline")

5ef2dccfcca8d864 375700bab5b150e876e42d894a9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    118225 ±  2%      -6.0%     111161        perf-c2c.HITM.total
 1.926e+08            -2.5%  1.878e+08        proc-vmstat.pgfault
     14579            -2.2%      14264        vmstat.system.cs
    579287            -2.6%     564220        will-it-scale.192.threads
      1.98            -2.9%       1.92        will-it-scale.192.threads_idle
      3016            -2.6%       2938        will-it-scale.per_thread_ops
    579287            -2.6%     564220        will-it-scale.workload
      0.33 ± 19%     +34.2%       0.44 ±  6%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.79 ±  9%     -44.9%       2.64 ± 67%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     28.30 ±  3%      +9.9%      31.10 ±  4%  perf-sched.total_wait_and_delay.average.ms
     71544 ±  2%     -12.6%      62531 ±  3%  perf-sched.total_wait_and_delay.count.ms
     28.21 ±  3%      +9.9%      31.00 ±  4%  perf-sched.total_wait_time.average.ms
     47.56 ±115%    +220.4%     152.39 ± 11%  perf-sched.wait_and_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      3197 ±  5%     -13.6%       2761 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4324 ± 16%     -28.8%       3079 ±  2%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.30 ± 73%     -73.6%       0.08 ±109%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
     47.48 ±115%    +220.3%     152.08 ± 11%  perf-sched.wait_time.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      9.36            +4.5%       9.77        perf-stat.i.MPKI
 1.427e+10            -4.5%  1.362e+10        perf-stat.i.branch-instructions
      0.97            +0.0        1.02        perf-stat.i.branch-miss-rate%
     34.20            +0.7       34.87        perf-stat.i.cache-miss-rate%
 1.753e+09            -1.5%  1.727e+09        perf-stat.i.cache-references
     14678            -2.6%      14293        perf-stat.i.context-switches
      9.07            +3.8%       9.42        perf-stat.i.cpi
    556.91 ±  2%      -4.6%     531.43        perf-stat.i.cpu-migrations
 6.398e+10            -4.0%  6.145e+10        perf-stat.i.instructions
      6.62            -2.8%       6.44        perf-stat.i.metric.K/sec
    635521            -2.7%     618322        perf-stat.i.minor-faults
    635521            -2.7%     618322        perf-stat.i.page-faults
     27.27           -27.3        0.00        perf-profile.calltrace.cycles-pp.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu
     26.31           -26.3        0.00        perf-profile.calltrace.cycles-pp.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range
     12.12           -12.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
     11.53           -11.5        0.00        perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask
     11.39           -11.4        0.00        perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond
     11.36           -11.4        0.00        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.llist_add_batch
     13.84            -0.3       13.54        perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function
     48.02            +0.2       48.21        perf-profile.calltrace.cycles-pp.unmap_page_range.zap_page_range_single.madvise_vma_behavior.madvise_do_behavior.do_madvise
     47.88            +0.2       48.07        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior
     47.89            +0.2       48.08        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.zap_page_range_single.madvise_vma_behavior.madvise_do_behavior
      4.21            +5.9       10.09        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range
      4.19            +5.9       10.08        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu
      8.00           +11.0       18.97        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond
      8.02           +11.0       19.03        perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask
      8.11           +11.1       19.25        perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
     54.16           -54.2        0.00        perf-profile.children.cycles-pp.llist_add_batch
     21.03            -0.5       20.54        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
     20.82            -0.5       20.37        perf-profile.children.cycles-pp.__sysvec_call_function
     21.06            -0.4       20.62        perf-profile.children.cycles-pp.sysvec_call_function
     22.05            -0.4       21.64        perf-profile.children.cycles-pp.asm_sysvec_call_function
     14.88            -0.4       14.52        perf-profile.children.cycles-pp.llist_reverse_order
      0.49 ±  3%      -0.1        0.41 ±  8%  perf-profile.children.cycles-pp.common_startup_64
      0.49 ±  3%      -0.1        0.41 ±  8%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.49 ±  3%      -0.1        0.41 ±  8%  perf-profile.children.cycles-pp.do_idle
      0.49 ±  4%      -0.1        0.41 ±  8%  perf-profile.children.cycles-pp.start_secondary
      0.42 ±  3%      -0.1        0.35 ±  8%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.40 ±  3%      -0.1        0.34 ±  7%  perf-profile.children.cycles-pp.cpuidle_enter
      0.40 ±  3%      -0.1        0.34 ±  7%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.23 ±  4%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.intel_idle
      0.48 ±  2%      -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.21            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.22 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.40 ±  2%      -0.0        0.36 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.29 ±  5%      -0.0        0.26 ±  5%  perf-profile.children.cycles-pp.madvise_lock
      0.22 ±  2%      -0.0        0.18        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.52 ±  2%      -0.0        0.48 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.44 ±  3%      -0.0        0.41 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.32 ±  2%      -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.44 ±  2%      -0.0        0.41 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.12 ±  3%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.24            +0.0        0.26        perf-profile.children.cycles-pp.next_uptodate_folio
      0.49            +0.0        0.53 ±  2%  perf-profile.children.cycles-pp.should_flush_tlb
     48.07            +0.2       48.25        perf-profile.children.cycles-pp.unmap_page_range
     47.94            +0.2       48.12        perf-profile.children.cycles-pp.zap_pmd_range
     47.93            +0.2       48.12        perf-profile.children.cycles-pp.zap_pte_range
     41.92           -41.9        0.00        perf-profile.self.cycles-pp.llist_add_batch
     14.87            -0.4       14.51        perf-profile.self.cycles-pp.llist_reverse_order
      0.23 ±  4%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.intel_idle
      0.18 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.next_uptodate_folio
      0.14 ±  2%      +0.0        0.16        perf-profile.self.cycles-pp.filemap_map_pages
      0.36 ±  2%      +0.0        0.40 ±  3%  perf-profile.self.cycles-pp.should_flush_tlb
     29.83           +42.5       72.37        perf-profile.self.cycles-pp.smp_call_function_many_cond




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


