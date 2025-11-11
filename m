Return-Path: <linux-kernel+bounces-894777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCF9C4C162
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808D218C00F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704883446C9;
	Tue, 11 Nov 2025 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfYf+qtR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D52346FA7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845099; cv=fail; b=WC9IT0C85c6LS+BW3Ya+Ab6oOwXVqyNIUX8kcGm1XB1CUJ8XLCu9Sl07dUel7ebkPTkcbHEPH5wwAV8fDbMHyC73B5yKmKj3iF98TSg4+T3p9ag0BqV5djGr2KkGkAqAOAEi7vbL7Vj6jWTsJ/5DxdckhGIeqMEZRsJ0Xf9IFYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845099; c=relaxed/simple;
	bh=k/fe8aCNlvyR+3FXbYoxYc1VupnXHr/4os6P9RO1Y+I=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=L2W45Tu5v5bcaztDQ9nTWsqwuUkYr2k4WelnwXl0+enYzurmQ1BYaS/vz0shdocylrFqNGP39s9V4gY9oN19ZHH+p5/DLCxiMO5HAfBCEbKfuZO4+zb0TTrMzkVWyz34+//gsOxS6Ctces2FVwLkOYlZg+frO0NM/Ewq+dhyIYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfYf+qtR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762845097; x=1794381097;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=k/fe8aCNlvyR+3FXbYoxYc1VupnXHr/4os6P9RO1Y+I=;
  b=gfYf+qtRw86oacj1cPtq4/GTCtKPrnq2zPSZmtk/Mu2v/BykmaSfDPow
   mbDlcGpbbnmhzku139qIDbu+yy3qOFspnH363nFt6gLMtup8fiMzws8g6
   /dKAeKmI0C/8nDxBOOlraf0lnmYpbaXrU7U9IZ+OTD7xiPlPzW0eA6uXU
   B3nQRc4y2zjxiqqh0x46CBoyaJFl26vZFpjA9XFBsK1aHDVVM1+IgVX0m
   +hK4ENxRH6xIysCHgle9rKTnQXWVfCCvtCjFel5DtNDrydk0fgcG5m8Li
   +KB60Va+ZwjsH302TZhOZmDD9+AHQWQieM6tpEbQMaxwOzuunilKwZciL
   w==;
X-CSE-ConnectionGUID: Pus4FRPiSuy0xKSNyt1kvw==
X-CSE-MsgGUID: qHYDRKolR1GhVVDTd7q+Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64110847"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="64110847"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 23:11:37 -0800
X-CSE-ConnectionGUID: yAUSwnKFRLyIprWnDS+ULw==
X-CSE-MsgGUID: /BKBAVb1Spa8VFesTDS3kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="193010531"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 23:11:36 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 23:11:35 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 23:11:35 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 23:11:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqDK9qPON10GfQTBDZNybW3eZdL6rzMpEGYbgEbTpsK6j1h9Y3V8PAqi39/2L4UsIp0vAEYdA849HhkNGpDo04FsKCABANOFAfAek10XUwNOGfF0pXYRsKS2T/+3z/0/W0e0S/8KbDSpPG5+HTTGFje0gRbCf4qL2wcKinAp0RMtNRrkefW7DVJmTpaba5E7zlclVdMhMtmh9IOuDcByOBQVse2l+GhaJY9kS5kWe8DOpM5lhGrnOYfgv/pT9voQqONrWNoQYiIn27/RHCXJjIODmPeWLumdtXXC6TfRAj+CotrKO0guySZPlMoD9huhuujZC+Q4aTCTpgTTyVIRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwvaPDoTCQO68Dox78LMHqMbV4a5z4zqcQMS4eGs88U=;
 b=iq04FbLTZfMRdmUFKGHY8sFRgQuiWbvl/b/gaBNVN7yTbAXqvo5eJPXm+S3g2i0QUBcfmRxSmtLlVdbzTv3FJ8e6hLTkhdCwOhfJ5FfAztsrNe9K88QIdrmu0vsY2HRk4bfk1T8B9/FWq2o4sY/rh4JEK23wsS1nYuASJXjhsuAs0KjO208xG9ffawnsfQzcTs86635JcBxfxRgfmMy6KKNWNqNU6f39GO5NomvK7BpTnMKrGphW3XPN60FoSOVOxWLu5FmXXl869lfT1MnK4b9DgoysgrA3/mo4ToLppXvHnlcuoIVHj2CEFEXFe4KiWY/50oU3yDRI8cz/2lHPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPFF2B8F6C64.namprd11.prod.outlook.com (2603:10b6:518:1::d60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:11:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:11:31 +0000
Date: Tue, 11 Nov 2025 15:11:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	<oliver.sang@intel.com>
Subject: [tip:core/rseq] [rseq]  9f6ffd4ceb:  stress-ng.timer.ops_per_sec
 5.5% improvement
Message-ID: <202511111524.d2e6b63d-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0138.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPFF2B8F6C64:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d72ceb4-8e17-4b06-f707-08de20f18a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Z/R5CN263Gsk+H3z+YNXpmYzPfx97GWUgxT6QCmocnk4aWhyg/R27MbMjV?=
 =?iso-8859-1?Q?juLbEIb2+woQEPn9unUkFLGbYuuZANrFQJCKg7X8B/YyZVU2XANEumY9EU?=
 =?iso-8859-1?Q?bhUm3reCMDdEc5te8ppRzw8QKSh7r9UQBl/lZ4dup1TgZIbWaWrzoyIkEL?=
 =?iso-8859-1?Q?rw7KsYoTCJNgC/gm6bqz5JDs74wzn9G8uKyxQlmrQYvamiT3sj1r0WpBWm?=
 =?iso-8859-1?Q?UISLL09sAd1u9IJFZGVpJpGoaXSMOFSLYyjPdB+siqeLPSiWd1ZccjZsY8?=
 =?iso-8859-1?Q?2rCpVarkLkJ5rBBq6Nm4Rj+WDZLRwDnY6jirLiPSr1WucTNez/J2RD3aGm?=
 =?iso-8859-1?Q?LQPnrJf/xUxZovpXP4O74bW3zryTiWjnvAzQ8k3sqipgwfvUFlrbkdHt9s?=
 =?iso-8859-1?Q?P835a0z6uLYFWx9OhVhBcLBVCuFFlAcoNrS1VLTbuOly4D1wE31LtltLkJ?=
 =?iso-8859-1?Q?IoAOFKa1CtyfxjF4VX62P8pOPni+7HwOrctydvyYcW0h5vlKk9s0/bMs+9?=
 =?iso-8859-1?Q?YfmCUw0f+g+q/JBxQuKCrnT8bKJSysk7USPDxsjQSMbIPpq4R9JMRMdD7Z?=
 =?iso-8859-1?Q?IkkbGnndPkXs+zNWgoRtssJx/wWFbFVJG/Yd66QTuL5yKnd9NQJtzuTAGW?=
 =?iso-8859-1?Q?dkwZaSu2QF0pydUWLWspdRpCjhrTAchO6hf/PSt8K1PKAHfY2r9q63FszX?=
 =?iso-8859-1?Q?oev/MB33Ooe5JXgT8IdFQ7AiKWs+qYT8iRfWh0DQwyDSKiMVNLXCVp2bVN?=
 =?iso-8859-1?Q?m1pQIDdAuS+8pCY55M6sXO6p1IPDdBQbDzYuEOhp9IV3TacsXybEpyeZp9?=
 =?iso-8859-1?Q?TVD4IoFhBjgtJIzebvcKjJ5KyauQG8Llkh9vOwmGzuppgbUQ/zVF22Thgf?=
 =?iso-8859-1?Q?Qt6U0kkOrnbf2Eu53fFUIaMJ7AXanTNvZU/YyztopE9lR0SXrlWcV7cwny?=
 =?iso-8859-1?Q?n/o21UNmZ9d2PaCOIKS0yj2fTue4+XcbBVe08NXQSW/zy7tXabG76XnIBN?=
 =?iso-8859-1?Q?3gFXPx8CI+ajHfEGXZxjA+YzjtIDmZmzBhOzgFZx1DfaZkgPqxVoKW9Xi+?=
 =?iso-8859-1?Q?KgXpJActlhxRCf4TryaaOTrdZBBCdbBxbvdu5bMlbkdlRG+7pvu2nxKw1m?=
 =?iso-8859-1?Q?zFGRRA5UuRsnVkipTwOhGW9YFz/2bJtjhin7itBZJSje8TFcrpj7l5caHw?=
 =?iso-8859-1?Q?vXyS1l/I5GxYjOMFOKz0D5nR/F1AxIcw7t014WpqJkAPIKnVYmmRyk5kRa?=
 =?iso-8859-1?Q?aAYJIMvCDQk45dW1DOS6C/gTsa2nai0eZ3/KRsAjeX7fYlwZdpTFvN23mX?=
 =?iso-8859-1?Q?xmU8lp1+YS6r02NgpFrnMPDA1I7mxAbLGMeZhYuSXeDgJ6zX5aRubDgeRb?=
 =?iso-8859-1?Q?C48pFNCj+/FatqRACmg7hki6wvq33/1SOz/GxRlJOKqiHo3kLk4XMagNXa?=
 =?iso-8859-1?Q?BqmlL19t0fRvyye1P+kqHWmxnqQQpO5RXiTJbFR7CrtA+5lo06Pv75XbQQ?=
 =?iso-8859-1?Q?tleL3z/Ot5dSwtgmt1ktGZImhgq8eTc2FvTRebG4uHew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NABwTDGDGg5qnu6BXf75+xCu2KoQJEF58Hqhv9CuZ6F7Yb6UoYwJtDtFtm?=
 =?iso-8859-1?Q?VS49L/XDsEQ0sBmahOvNFTurgS4Uef2MVOxJLteTniHiuO9eMxJE2gpjn0?=
 =?iso-8859-1?Q?hK0HUGsmE0u0Uy8AEYcfPheGf5xmNF2tHrGWazv9GeYPvvGQOQO0eMuGCi?=
 =?iso-8859-1?Q?By6NlyhuUKALo3P3q9ljzuFqVT5+PnbkVx6RyBtOrL+KlKZMYpzrF+YZHq?=
 =?iso-8859-1?Q?z/oDwA6yjAlViLfRPnTra0OoNmTiBX16iQXgXjumhX/YlUUpXVQ3VjdpLl?=
 =?iso-8859-1?Q?DN8O/5083wEbvsQbqcWP3z3L+dKFCGE0m+CyQe1FrlTkHqPKyyUzufWGaz?=
 =?iso-8859-1?Q?rAG7svW68d+g9VcBz7+JN+w627OEdR5hncOM+rK+534DK3xn6iKyODEZlM?=
 =?iso-8859-1?Q?Rz8Xjf6G4pjiSgtzdqLjcrwEkjwDJ3+QyPiiJdg2MsBPtXI2vM/yMKAAyp?=
 =?iso-8859-1?Q?KBEqzEeSKDIyBvpxmHDeeXKR8cuJB0bMiW7iSubmnd5oIigmspRHDCtcPU?=
 =?iso-8859-1?Q?Z+7zAgumx8GyxkY0Gnrc6APBFbebdFVfLiWLYoy0E/+AjZzjtK95w8vFVm?=
 =?iso-8859-1?Q?owrxhh53y/VRwuCvoO5MEKj5x7W+BWDbIPOb20SASOyDhKm+Y+MDps8FPi?=
 =?iso-8859-1?Q?nMTI4XW/bNOVWCwwZSTrniXbAq7mRMl7f2PElJAcZOgl93TCuBZjNJ0i/p?=
 =?iso-8859-1?Q?Rz5w2/Ufk1Sxi3q4kNWDCvHW4fqVmH6qkRvy3qPAd31ohcp4fC60OltfIK?=
 =?iso-8859-1?Q?ai9lAdlEoRSHpLiXo8EyGN6p400AoH2xaqR5IDE378lSjqtDrR+Sh7O/vL?=
 =?iso-8859-1?Q?glJp8Ps1R34B2VsWWv9XItPUnQXmQYViJiWkf/eLKn3Hq4HWqFh77NYnWz?=
 =?iso-8859-1?Q?YHietp8D58lcGYrpZ5S3F/7afu6Fou/JydzsjOVmTCxI6B2fFFRlGRfkLt?=
 =?iso-8859-1?Q?CUwxmb1rvReGb2U8LJCk7XZ6HQ4OTZoUMQUWe1MYAkvgujcW4QtVD0JkD9?=
 =?iso-8859-1?Q?G0UZbMe2/i1nWVsJ3lz3sJB4+fzaX6PlLeVZB+e0771k1W/tJ2z0x8ot9g?=
 =?iso-8859-1?Q?R7XJQCQqScidJG6u6e4HIEm/drg2WxIRS/xRUCnbja+bXpVE1EiXdHrI6z?=
 =?iso-8859-1?Q?6nYklzTO2m1HuzEDkoD8egh9Kr86HC/5TevvciHhjn4lzmF0i9ErRTFLvf?=
 =?iso-8859-1?Q?t1B3Bss2waZjdV4PVkLDW12IvKf12Ho5Na35rt3DUFu8MO6pU2JXhPyZxV?=
 =?iso-8859-1?Q?+0DV3HWOxKo4K02BEJ7pZZER6MX6Zrx8rdBdnb1h9AhGeMVr6j4up/xodP?=
 =?iso-8859-1?Q?nQpACniSNI/0iVJh0SntUSRcFKcZduWlTTyy+R16x6P2ERKH1PYQKoY4SU?=
 =?iso-8859-1?Q?Vi6CCnO+N0USJPBLfiB841DmdP7NZO294DOgBqbkFbexvcZYB5Umk5Ic/w?=
 =?iso-8859-1?Q?zwSZJwOstByhi27aKvtzQkjOYTOCu9NCntUgH9h6WLsirjNLFkBmgjOwEc?=
 =?iso-8859-1?Q?44pfozXJ6qxDlcANXsb6RrswSINlnkGv7UGiazUnR550mgLY1nX6KTPIRP?=
 =?iso-8859-1?Q?qAK7OquERUBjd4JUwC01/jcSZiL9SNk7e/NYcd5DgBLGfwwEjxK+ennjOl?=
 =?iso-8859-1?Q?d2tsblsGpJxS8lmFXVC12HxNPQd/BXqAbqjKLhZmVi1jMCz9ZhPk34Lw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d72ceb4-8e17-4b06-f707-08de20f18a8a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:11:31.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhelYacDpAY9b8fZeYLHx0/jOM1vN3MKZ+C0PNSzOsXeJKQU83aolyWrXIY3H67t7yZf1j/78OYTbvtd9HYV1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF2B8F6C64
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 5.5% improvement of stress-ng.timer.ops_per_sec on:


commit: 9f6ffd4cebda86841700775de3213f22bb0ea22d ("rseq: Separate the signal delivery path")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git core/rseq


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: timer
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251111/202511111524.d2e6b63d-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp3/timer/stress-ng/60s

commit: 
  0f085b4188 ("rseq: Provide and use rseq_set_ids()")
  9f6ffd4ceb ("rseq: Separate the signal delivery path")

0f085b41880e3140 9f6ffd4cebda86841700775de32 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    147208 ±  3%     +15.8%     170452 ±  4%  meminfo.Mapped
     50.63           +34.3       84.92        mpstat.cpu.all.sys%
     36.46           -34.8        1.67 ± 13%  mpstat.cpu.all.usr%
     14932 ± 35%     +67.9%      25072 ± 15%  numa-vmstat.node0.nr_slab_reclaimable
     22290 ± 24%     -45.5%      12149 ± 32%  numa-vmstat.node1.nr_slab_reclaimable
     10.17 ± 44%    +375.4%      48.33 ±  9%  perf-c2c.DRAM.local
    162.67 ± 31%    +558.7%       1071 ± 12%  perf-c2c.DRAM.remote
    141.00 ± 29%    +578.6%     956.83 ± 12%  perf-c2c.HITM.local
    154.50 ± 32%    +476.2%     890.17 ± 13%  perf-c2c.HITM.remote
     37215 ±  3%     +15.2%      42879 ±  5%  proc-vmstat.nr_mapped
     66948            +8.7%      72780        proc-vmstat.nr_shmem
    818668            +2.7%     840430        proc-vmstat.numa_hit
    620609            +3.5%     642526        proc-vmstat.numa_local
     59728 ± 35%     +67.9%     100287 ± 15%  numa-meminfo.node0.KReclaimable
     59728 ± 35%     +67.9%     100287 ± 15%  numa-meminfo.node0.SReclaimable
    304140 ±  8%     +16.4%     353946 ±  7%  numa-meminfo.node0.Slab
     89141 ± 24%     -45.5%      48551 ± 32%  numa-meminfo.node1.KReclaimable
     89141 ± 24%     -45.5%      48551 ± 32%  numa-meminfo.node1.SReclaimable
     47698 ±  2%     +16.6%      55634        stress-ng.time.involuntary_context_switches
      5931           +67.8%       9952        stress-ng.time.system_time
      4259           -95.8%     179.67 ± 14%  stress-ng.time.user_time
 5.054e+09            +5.5%  5.335e+09        stress-ng.timer.ops
  84269084            +5.5%   88943393        stress-ng.timer.ops_per_sec
      0.05 ±  4%     -14.9%       0.04 ±  2%  perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      0.05 ±  4%     -14.9%       0.04 ±  2%  perf-sched.total_sch_delay.average.ms
    159.90 ±  2%     -15.6%     135.02        perf-sched.total_wait_and_delay.average.ms
      7663 ±  2%     +18.3%       9069 ±  2%  perf-sched.total_wait_and_delay.count.ms
    159.86 ±  2%     -15.6%     134.98        perf-sched.total_wait_time.average.ms
    159.90 ±  2%     -15.6%     135.02        perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      7663 ±  2%     +18.3%       9069 ±  2%  perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
    159.86 ±  2%     -15.6%     134.98        perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
  6.55e+10            +3.2%  6.757e+10        perf-stat.i.branch-instructions
  92397918            +6.4%   98318472 ±  2%  perf-stat.i.branch-misses
   6980157            +3.0%    7189854        perf-stat.i.cache-references
      1977 ±  2%     +12.2%       2219        perf-stat.i.context-switches
      1.76            -2.6%       1.71        perf-stat.i.cpi
    301.54            -2.7%     293.44        perf-stat.i.cpu-migrations
 3.435e+11            +2.6%  3.526e+11        perf-stat.i.instructions
      0.57            +2.7%       0.58        perf-stat.i.ipc
      1.76            -2.6%       1.71        perf-stat.overall.cpi
      0.57            +2.7%       0.58        perf-stat.overall.ipc
 6.443e+10            +3.2%  6.647e+10        perf-stat.ps.branch-instructions
  90890135            +6.4%   96717754 ±  2%  perf-stat.ps.branch-misses
   6864424            +3.0%    7069354        perf-stat.ps.cache-references
      1945 ±  2%     +12.2%       2183        perf-stat.ps.context-switches
    296.64            -2.7%     288.77        perf-stat.ps.cpu-migrations
 3.379e+11            +2.7%  3.469e+11        perf-stat.ps.instructions
 2.077e+13            +2.7%  2.133e+13        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


