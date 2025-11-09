Return-Path: <linux-kernel+bounces-891930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E92C43D74
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712D13AB8A6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61AE2EC09D;
	Sun,  9 Nov 2025 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GS1R1HhK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAA2EBB9C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691205; cv=fail; b=VvoDBVXHVVTw0wrHRodnq+0ZN2zQDBqezEi83JfQhpbZMln71U7Oi7D0eW3+Y7jmJwaAKhszctWgTQaWI1z/ZID89UwHfvgl5aN93U2KhX6uhVkt/trOuO6g8hXqmy/kUREkUC+K7YHBsmKwVcP8KQw6Jz5VGg3024x4uxgio+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691205; c=relaxed/simple;
	bh=MKTnv+hGGJkMBXHGgwWx+FkX3WL1UVlsEazmrc73LE8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jJbrSKp3xgcvIM+GPF7gSUhsIQ0XMBoGUxUKbmxUG9xAOILbzjwyfM6uMN7IEHI1sC0LIy2a/vIXIG5GeUnvPNd2boaCRGcIPufVkfgNuIjce/sHK6RVQvtkb0rcXoozs3oMgjt8C/JEi/x+mL8YWxryGg5ztM0XhpKogA5NgnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GS1R1HhK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762691204; x=1794227204;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MKTnv+hGGJkMBXHGgwWx+FkX3WL1UVlsEazmrc73LE8=;
  b=GS1R1HhKI6dMVsCs9wW7ZYaaxe44fPyqI2i1GRL+XPlM6jKASZYCCFoL
   EJwHdHFg8fWZLZmfj4mOZ0jbY68oDjTcZftN3P31NWNOBGweUDS3ijOGD
   SLTmJxNNu/azk8BiGqUWXTczLO2SOAm3FjkgRYqqDR720/iv8YqnSWq+I
   t4Q5sG2y9BAhNC9eqttrD3a3nA60GeOq0bEsYLvfF9wPnasRZBQLqwiH0
   HN1UGpGmbOOY/x8ejNngZdsfBuYrdpIPz7Dc6bwqcN3Toke23Jr6g030Y
   4LTFy7ayRF2fAgtNQEv4jBPmD0Y02xbWJOwTHOCqH+EJJITcJ1Tccrjqs
   w==;
X-CSE-ConnectionGUID: 3CjbyfVdS6ipBeEotqHYjg==
X-CSE-MsgGUID: TqXO/jpTSHiIlxsDePQWuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="75457225"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="75457225"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 04:26:43 -0800
X-CSE-ConnectionGUID: PYNSOCANT4OY0FW06uilDw==
X-CSE-MsgGUID: TkmwpL5zTtSZ7oApv0NiEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="188189239"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 04:26:43 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 04:26:42 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 9 Nov 2025 04:26:42 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 04:26:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVCx9jHDiE5NF+Ks5LENY0PyY9HQEuWPJET53kgaMeqSw3+JzphNpe9jA98jcfWKl2UTZF//mMk+JtiLp2gy+mMgtu6yjPKmB3YxxEsjUOBOO2p8g3zjZZ6ldEENA7Q3/vitMWODHdEHCUktpUwzSOoaYe7RpJSoN1ntepznilP9HXgWxD18/EhheC1i0BihbIi861daiJsHxnFekVrRwG2j2/HXdahgPgnEoLB+R71bM+HmQud2vqU7T6hRAl+ZWHeyWohe4i826BEXKTcceBdPaCt0NYu/SltKgD2M0TXk2tyc25y4ol4ridNxu5rEtmHTDVLrubUKTo9KiYBiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rb6yIJxBrDSy2FR4jjDchcOyg6AyO+Y6H9vcA81eFQ=;
 b=f5IEoqR4fEleqvmBVKBGBUDThzG1SJk1vqiR2INHKYVT4KGN5JjvLncFH6uvIevJRTjnHfH3mfiaWXUw2tEXq71jArYvN5MUFb7QvmUiNlwkmzolRDhEMPjOPrhV2GlJp1sgoQy736fQbP27XiyLV2vIC5w7dEBTWDblB/cMlS4I2iGH8NDR7yweMDK3htJi7hRmIk7rYG8xjdAQT/ylIRePLDYXFKXGzgA25GNnalTU6VqSfc7/LVaPzq5fRyKokvaf2lms4C1tGPneQvujrrEsSoPY4zbtUBNO9uqNVi76nw1d7OaBKwl4xSaJ67I95OVdOc8/Xml2GKx3bq+AAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by CH3PR11MB8658.namprd11.prod.outlook.com (2603:10b6:610:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 12:26:35 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Sun, 9 Nov 2025
 12:26:34 +0000
Date: Sun, 9 Nov 2025 20:26:25 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: Forwarded: [PATCH] fs: fix inode use-after-free in chown_common
 delegation retry
Message-ID: <aRCIcSYkYLI4a3Pk@rli9-mobl>
References: <691059ff.a70a0220.22f260.00a6.GAE@google.com>
 <202511091815.6q5WUuzH-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202511091815.6q5WUuzH-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|CH3PR11MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f79788-f089-4b0c-92a7-08de1f8b3827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/J/04D7l+ZuuhRnPHa2hJadE9CcMmnIspkK3FGmQuIlf/wIDqKyetwUlAMZO?=
 =?us-ascii?Q?SG3Nk5LhhZIoUGJLkE/THraUXVPlpyc2SoFLW8RHm4JEAHCOW34jYAjspfId?=
 =?us-ascii?Q?osmYXtgDwtJNNZX+cGJPWLLuS7zGtORnopOKy59Y/X/UKNbeD4npY8xuxxzX?=
 =?us-ascii?Q?qnUKQbpJIMqub3gF+XmRvxNG8SJWCZaUJjyYx8TVxCfO8wHQhjsFDUiGvKQj?=
 =?us-ascii?Q?jbuI0XlQtwxKqApbm4KNIEC3HfoFG+0H/+gTYKuNBi348JQjZgY0lGdPiwtH?=
 =?us-ascii?Q?BmnzRadKiB2rWm/KLzAyTBVVIRq+K96vOLNLtnYIT6oIDmcdawV9kl382bLz?=
 =?us-ascii?Q?5I9F2Nufy8c+J1uNgRzr3c8iewelCzcOy3LOjVj5GW4Y9ossVj//N5ccDuAq?=
 =?us-ascii?Q?i6tM7r/Yj2XCzkg7TQ3PhNb/LyxSMBM7zNi+VEcvcZ1qAenTeOeRFMckZ+FF?=
 =?us-ascii?Q?AQ+lVz8H65k2K9PlByHmG7PeN+S9t/3Ut0IrAPG2RZvpS9iequ8K9LIvvPGY?=
 =?us-ascii?Q?wbrTX9ICxGmuxOR9T/x+PgDbTnr5kWiHeWP9v2hswxrWK7pPL6qiOk0H7cXu?=
 =?us-ascii?Q?iAjv69hpLvKo5noQ5PmWzFSPA+pRmOdsSjN92qkMp1nhfIbeKELCMmLHpqpO?=
 =?us-ascii?Q?uLeMPcJiWsAWn2bjEQaCkcQYl5ER8oCSZGDt7hm203WnoKuLFocO6BBNj9V6?=
 =?us-ascii?Q?Gy4MeY7BbCIxi93tkV3wmbSFYqHx5lCku3DbgEaqFc5kK3gjk+po7MsLfKct?=
 =?us-ascii?Q?/32L4mQjwTAomXP80QGNqIJTG2c88aW2xUT4zxJztSoVGqN0VfEo0i6OxI0x?=
 =?us-ascii?Q?H8deKnV1CYcaykc4pb/4DYtvWgzFJqQJU6xK3aRXY+6m5vXfg8DeOYexW/sp?=
 =?us-ascii?Q?xG38BRcuSTHQhIwmwpWz1L0K21F5rtOolFWOdl7gtWXBvVws1PIIpjLA0bug?=
 =?us-ascii?Q?6nJMyBAyokjCZc/ySzTdBTT3uRGLNxM424V7J2nLyXOcxCFdq5BcOd59dof+?=
 =?us-ascii?Q?n20RtJJ+DHM+j+sKE8vzK7VNsKEbYa9GtWP40m1S73yKg4R8WpKF8GxrLnDc?=
 =?us-ascii?Q?MHIddupL6qP5K3rWtgyW7ZZJs0rmPWudYIqmZ7ITVTLubJ8P/DiHoCL5XK34?=
 =?us-ascii?Q?c/k1RmMIjAifIdrgVett5YgfuHX415d7v3SBu5X/OxJmC0Q5hilSuwR4RIHP?=
 =?us-ascii?Q?xYr8mVd1lHaeYf2pRR0kErpT5uOAok3eJ/qJFiIb5Xm0t5JS1DageDUBUrPJ?=
 =?us-ascii?Q?NJtpoKHY1CSncszFz7s65gJnQxmawSobOWyI5KlWWvZHayTSJ4IUOWQEITLC?=
 =?us-ascii?Q?I75zdeVJe6qxPn6+NqllimrAChqANo/K+sG2PvMf68tTJkeu0llUjWyDCEbp?=
 =?us-ascii?Q?a8xuaCqLswU3eHE0gRjR0WLosAdqna9bygmMcubDec8BzRzFka0zLNVDqEZI?=
 =?us-ascii?Q?T0kErzpby5qkqdkLztY/UZvkla5iI6ZzSYYRsc99Nwrj955p+c2cYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gT1gvJ9MM7xJoQ3NX/pmQRGwo8h8fvEscOSFkvY9f1NSA7jFpSL0w2T3TXjq?=
 =?us-ascii?Q?eBQz8JgTASLOMRP7PdyzigMB3ZgMojqV2LxMG/QV3c6dm3LZA+mWE5tFCxnW?=
 =?us-ascii?Q?tvIYMd7H9R/46imy+apr0fIOnV5d64FMtYa71XQHK+jMKlI6n+++GnFGaDVP?=
 =?us-ascii?Q?6xkdZZaNO2R/fp7Smabux0j3CwbTvu4XzheMVVPBYJbsngH5eCP40OHhQNzY?=
 =?us-ascii?Q?CyXchVWjSwSlwkVcNY0BzyQNBGT6bjCytdFhW+G7vmfpg9zywjSKrxlpgfzB?=
 =?us-ascii?Q?ATYUpYJb+0A3QxFV3bumI4oU1ZDFvK8enZ5N7om5qEf2KqH9AM+qMX0B3Mrc?=
 =?us-ascii?Q?wgG+VNqClSO4aBIy41e0x78RaJUy1pxTcVWl1tt+Myt1ve6yuyagLCWY3iiE?=
 =?us-ascii?Q?PjWAEX5ZIKFv1rdKdpXJaBemsTiPLgmzEHcllC9R14xkpsp3/NdEqXpuY895?=
 =?us-ascii?Q?xn54udaTs1RXUzy5vEE16UxbCZ51/HlcZiy2bhS9blyb5YdJGHufz0MoQJcx?=
 =?us-ascii?Q?Q6qtrFw5kjRFZCP5nSThSqucFjcdS9b0f1VRTiVavPJUC/EmQqlyoZ2PirUf?=
 =?us-ascii?Q?nMbRGrIps+zj7X70a0VCTs25Po9iaMBDbwUO2aBat5G1W8fK9BsDRKlQZlnH?=
 =?us-ascii?Q?siaPPWXBs1hIPM9JucXCGfru+x91ejOlWJBRRXPBOck+HFBA7QuUC1yWACqS?=
 =?us-ascii?Q?rbc1/hkEHqUU5Esa66vUjmk8dDcR0Xi54v75stat45KwewH6mbVLayxHdNSX?=
 =?us-ascii?Q?Tm6dJJ5Wt1+zD/CWLhJoOxhNJz1cdxkrJlQL2AD3oyzMSK89A8Fy4OQNOCGo?=
 =?us-ascii?Q?7ANr4aUtRGBh81HtMGkeOI2dFseZY6PS0RA9DEyQ30dLv8CkZhayHODL0y7W?=
 =?us-ascii?Q?BwuN5xElquzfK1o62qPsEd8abeEDXD+PQfJst2BOIIHfluOfGpbW8kpNNpvh?=
 =?us-ascii?Q?QGvGaYV9qFAs8F0JCxFRF3caHTKsoifAoq/glBxjuX/P9zKh/5WV8H2n1GWF?=
 =?us-ascii?Q?AJwBwC/J1aVCyMQzEyic3yhf4qQkl4+xoCgtLysOaDFbwMta4lcQRzHihtwS?=
 =?us-ascii?Q?lBjo8QzptPafu8vo5VCwSfBOBbNOuuFEHwtpkoLPfCqvctq2z0aU/UJgrvHD?=
 =?us-ascii?Q?gZcD4U2YFASoqsgO7V9CQaT8xA00fVZ9FXKG6sJsV9bglAVYNl8X+tTvNg8w?=
 =?us-ascii?Q?Zc4CM3ky0izsf0WbEXiI4fUB5yFOhBjrXm2zB/3ayCWKH+wlFl7yVYLMgSUc?=
 =?us-ascii?Q?Jlq+6gY0TkGd66Ozi/r6iIwBkhJC2puoJEDc3P91GNyhsiG+ec30JtURJ17v?=
 =?us-ascii?Q?pB3t2yjIaaL+QEaVjRFjN1IutFiQDCwp6H4W6tCar0j1JrtI7RlSe563Kjb8?=
 =?us-ascii?Q?Y6Mgi0MO4dxTWIq/BgOCwFyD9R1iBEIOgbXHwEHWB4p0EV+N8RTBM1xmYISm?=
 =?us-ascii?Q?t9l64BYaLugJP0+wyqy0XF91twdnphqHoggXrCyHEWv0n/b6a8tyA+rkg9pV?=
 =?us-ascii?Q?NeMl//GSWLeogE/YSYsSC+3BkQkeQvdQVwBRXs1vDLyi+DUvOj7yfS3rQQv5?=
 =?us-ascii?Q?uVnOo+0y1xOQtHYjcVyqnenmMuwp/k9dRC4ed04N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f79788-f089-4b0c-92a7-08de1f8b3827
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 12:26:33.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76a7EcfeXpT+0YqATr72hA3JwFXROs5fPkk4EEhlgzax2tZYOZN3pc5kDB1vrTr8CegOoDVXqoUtV/Ma5Vx3Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8658
X-OriginatorOrg: intel.com

On Sun, Nov 09, 2025 at 07:05:11PM +0800, kernel test robot wrote:
> Hi syzbot,
> 
> kernel test robot noticed the following build warnings:

Sorry, kindly ignore this report.

> 
> [auto build test WARNING on brauner-vfs/vfs.all]
> [also build test WARNING on linus/master v6.18-rc4 next-20251107]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/syzbot/Forwarded-PATCH-fs-fix-inode-use-after-free-in-chown_common-delegation-retry/20251109-171000
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
> patch link:    https://lore.kernel.org/r/691059ff.a70a0220.22f260.00a6.GAE%40google.com
> patch subject: Forwarded: [PATCH] fs: fix inode use-after-free in chown_common delegation retry
> config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20251109/202511091815.6q5WUuzH-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project b9ea93cd5c37fb6d606502fd01208dd48330549d)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511091815.6q5WUuzH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511091815.6q5WUuzH-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/open.c:771:9: warning: format specifies type 'void *' but the argument has type 'long' [-Wformat]
>      769 |         printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
>          |                                                                              ~~
>          |                                                                              %ld
>      770 |                current->comm, inode, atomic_read(&inode->i_count),
>      771 |                atomic_long_read(&inode->i_rwsem.owner));
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/printk.h:512:60: note: expanded from macro 'printk'
>      512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>          |                                                     ~~~    ^~~~~~~~~~~
>    include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
>      484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                         ~~~~    ^~~~~~~~~~~
>    fs/open.c:785:31: warning: format specifies type 'void *' but the argument has type 'long' [-Wformat]
>      784 |         printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
>          |                                                                       ~~
>          |                                                                       %ld
>      785 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), current);
>          |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/printk.h:512:60: note: expanded from macro 'printk'
>      512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>          |                                                     ~~~    ^~~~~~~~~~~
>    include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
>      484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                         ~~~~    ^~~~~~~~~~~
>    fs/open.c:798:31: warning: format specifies type 'void *' but the argument has type 'long' [-Wformat]
>      797 |         printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
>          |                                                                          ~~
>          |                                                                          %ld
>      798 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), delegated_inode);
>          |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/printk.h:512:60: note: expanded from macro 'printk'
>      512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>          |                                                     ~~~    ^~~~~~~~~~~
>    include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
>      484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                         ~~~~    ^~~~~~~~~~~
>    fs/open.c:801:31: warning: format specifies type 'void *' but the argument has type 'long' [-Wformat]
>      800 |         printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
>          |                                                                         ~~
>          |                                                                         %ld
>      801 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner));
>          |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/printk.h:512:60: note: expanded from macro 'printk'
>      512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>          |                                                     ~~~    ^~~~~~~~~~~
>    include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
>      484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                         ~~~~    ^~~~~~~~~~~
>    4 warnings generated.
> 
> 
> vim +771 fs/open.c
> 
>    750	
>    751	int chown_common(const struct path *path, uid_t user, gid_t group)
>    752	{
>    753		struct mnt_idmap *idmap;
>    754		struct user_namespace *fs_userns;
>    755		struct inode *inode = path->dentry->d_inode;
>    756		struct inode *delegated_inode = NULL;
>    757		int error;
>    758		struct iattr newattrs;
>    759		kuid_t uid;
>    760		kgid_t gid;
>    761	
>    762		uid = make_kuid(current_user_ns(), user);
>    763		gid = make_kgid(current_user_ns(), group);
>    764	
>    765		idmap = mnt_idmap(path->mnt);
>    766		fs_userns = i_user_ns(inode);
>    767	
>    768	retry_deleg:
>    769		printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
>    770		       current->comm, inode, atomic_read(&inode->i_count),
>  > 771		       atomic_long_read(&inode->i_rwsem.owner));
>    772		newattrs.ia_vfsuid = INVALID_VFSUID;
>    773		newattrs.ia_vfsgid = INVALID_VFSGID;
>    774		newattrs.ia_valid =  ATTR_CTIME;
>    775		if ((user != (uid_t)-1) && !setattr_vfsuid(&newattrs, uid))
>    776			return -EINVAL;
>    777		if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
>    778			return -EINVAL;
>    779		printk("DEBUG: [%s] before inode_lock: inode=%p, i_count=%d\n",
>    780		       current->comm, inode, atomic_read(&inode->i_count));
>    781		error = inode_lock_killable(inode);
>    782		if (error)
>    783			return error;
>    784		printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
>    785		       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), current);
>    786		if (!S_ISDIR(inode->i_mode))
>    787			newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
>    788					     setattr_should_drop_sgid(idmap, inode);
>    789		/* Continue to send actual fs values, not the mount values. */
>    790		error = security_path_chown(
>    791			path,
>    792			from_vfsuid(idmap, fs_userns, newattrs.ia_vfsuid),
>    793			from_vfsgid(idmap, fs_userns, newattrs.ia_vfsgid));
>    794		if (!error)
>    795			error = notify_change(idmap, path->dentry, &newattrs,
>    796					      &delegated_inode);
>    797		printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
>    798		       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), delegated_inode);
>    799		inode_unlock(inode);
>    800		printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
>    801		       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner));
>    802		if (delegated_inode) {
>    803			printk("DEBUG: [%s] calling break_deleg_wait: inode=%p, i_count=%d, delegated_inode=%p\n",
>    804			       current->comm, inode, atomic_read(&inode->i_count), delegated_inode);
>    805			error = break_deleg_wait(&delegated_inode);
>    806			printk("DEBUG: [%s] after break_deleg_wait: inode=%p, i_count=%d, error=%d\n",
>    807			       current->comm, inode, atomic_read(&inode->i_count), error);
>    808			if (!error)
>    809				goto retry_deleg;
>    810		}
>    811		return error;
>    812	}
>    813	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

