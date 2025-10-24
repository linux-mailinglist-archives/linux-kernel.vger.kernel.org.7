Return-Path: <linux-kernel+bounces-868155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A97C047FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22923B9CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562BA239E9A;
	Fri, 24 Oct 2025 06:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9gohsrs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4872627
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287629; cv=fail; b=hxDGVSEtbm8q2yl1o/GKGQ87nwzrwunJvUzlQMhPFB9JMDPPqa/BuIwqyFXuDgJ5/Gw57PBowbP9u1MgwZKZu6R2hyvC4h5gk/N4BolofKD0dNZIQNphBRUhZvrST0EwZSLuf0s0VBpe3S0abuVyOSo+eb0GwzDVoyYty1v9Qcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287629; c=relaxed/simple;
	bh=Df2KVqeIWdQExW7F7sd+fFzMKpYJczpecCFrsXTIw9Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dmn60VuGvnlVuDvfW27Rhvv20HGmskaiBo9e6+aOlAoD8VLEQIP/2nU6sqM7B7906+vN8kLYnStv0usF0Hix4U9FkPL9Y0fwVYzpo4tVOso0whTjKd/0+I9JDw5byuf8Nv7llUPKQJW8+XWhf7xJptz5kkYcgtN2CG+bNI1seBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9gohsrs; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761287627; x=1792823627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Df2KVqeIWdQExW7F7sd+fFzMKpYJczpecCFrsXTIw9Y=;
  b=i9gohsrsxXYQjTBS67vXDi+ILnLdZFVrrCF9HBPI/ysjMnbVSAedJJUO
   7XyZT56clMIrr2+t1MpnbJJphqpO5IMsYRLA3cGRz+N0fgTr2ngS8WPBS
   90HtDPC3KYBEx34/xA1iwFZPG2DEu3SGbU+HVGN6u78Swrjra/2WH8ho+
   SbNdlMnnwnqgs4ZeQ1j62yBeJO4PnfXmCd8HYy1e+FMWybLP0CGYc3InP
   FiLPhWHAxMCnqj/OEG4xt7CCRUZIpVLjupH5zVGszj+H6o8pMMqpTW3JU
   mvz2XuLNxZAbyum8oWRA+Eg1mgls4eO9VjhLAgQXOzsfe6O6aWKeO1mVq
   w==;
X-CSE-ConnectionGUID: ft2lHkIRQD+UjCyYd9+ZZA==
X-CSE-MsgGUID: FfgDrSFuRdOW0vTq5IYlIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63503304"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="63503304"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:33:46 -0700
X-CSE-ConnectionGUID: 4E40/JchTWW0uUAaGTRMmQ==
X-CSE-MsgGUID: 0JtjRLJTQYu87kZ3Of/qvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="183581418"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:33:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:33:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 23:33:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:33:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7Sx+ML79mfadQqdQwiYG3qYo3FMyCysLtiewvUYy0U1Aq7NQDdEbFAoc7ZK4PhzTpTX6cX+M2W8zn48xqMMeMrQZLstbKAP6QQw1i2c1vC+0wvtYpmfQixBPHr+F8/aX+DPBQPJARUSK4EK1M/LldXu67EJeZZZ/WeO61MOTsnnI/bHNcLBiMDylSqhUL6tVVydHLoik7RZZ16cTMpZ9tBgmxoql7PuagMJvi9yYRbDII+W24VOPYDu0GVOr3Yq7Dms5Kp8FGGcZ5vPdRnXEGjmYTtM6/k/ced+aotJlkIBoLrfLvxaJL7QzjP83eQpQ+lto4iFyZhCz3o0RYj0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTeN1LPT/TL80OiQp3ftgsSvZYYyVDI3NHMhko0MZis=;
 b=ewgj0lF2eKdosKldmV45hux/srIeu4IihHVu8nN8dyAEoZQ+32JCRR/BesZnUZ73z55+OjIiGsP3RKUEJNztMI5lffITDbESfuCCw9oacmS+y20E1LPBRNfiZ3xSKlOi4at3FlXMvOMel2MvmrApftAyRA1oMITf7lzASI+AjLPsE/287B6I6Qkt0oH8vHUGga7vjjwpaNeLybjF8RAKKbZnMdKuXGXAnuJe0H8IOevmsJbMNszZQMzJYDZqy/IYZgWAU2xnV296i5owwc1Xml3XpremsAbxFvhh7aSj1oKjTUAY+Vzx4dB2Tm9rfiQR1I2fRvdO86/Tb+AJb1xqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:33:34 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:33:34 +0000
Date: Fri, 24 Oct 2025 14:33:23 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: Dave Hansen <dave.hansen@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Kai Huang <kai.huang@intel.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Retrieve TDX module version
Message-ID: <aPsds5SCmmoG4IJO@intel.com>
References: <20251001022309.277238-1-chao.gao@intel.com>
 <20251001022309.277238-2-chao.gao@intel.com>
 <934568ea-b9a0-4ea8-b62f-2edfd2e64f9f@intel.com>
 <aPiNy8Q3uPrlVlug@intel.com>
 <nfos7qsdendp45avmlpbftmekckewwvbb6romybh2dnbvomfee@a5lqto3xkeak>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <nfos7qsdendp45avmlpbftmekckewwvbb6romybh2dnbvomfee@a5lqto3xkeak>
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c8548d-b048-4365-8eb2-08de12c741cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hhTEjLtQA4tlp+xfMgZacL3GnyVWZbm3IcaHBFLcn/+6W1yyOX+lJCJ8Iled?=
 =?us-ascii?Q?OlZmNRqcQZq2g3Z7t1Gyr07F6dwYpwfnDf028KBm76wTLdvgU8QIcQ4YoVdx?=
 =?us-ascii?Q?v6E4xdZeRkyWPxKjosENTCYIqwXM9qGQ/RXpcOWwTnwYIUocnlIYq6BGIo4b?=
 =?us-ascii?Q?3gC9CY4YrbKeCK1rUJZs4ZcYCmdKKRbdJFqBGnaUdjGgxF780SbjS/nuli3U?=
 =?us-ascii?Q?Eii0hLCiO4Fm5ofoNKfEPryyW4xKyvAPhNrt9d31uOFHaMSmmw97yBClW/19?=
 =?us-ascii?Q?DyLEIqDJWZ6BlnSuj333tPJg5WBJ5xTlSwkn5835Qogo3RvGvC9+DYPS9fNN?=
 =?us-ascii?Q?OiNpzrzrwXd0mPvlBg3RvVQSq1zraOBdYKq0CfDDw4sldt/lSMTAvuGYlhiU?=
 =?us-ascii?Q?pr42cUsTqURAgpSmBDrrOOfHzB9lxYimONMiS3FtILeFy8DI6AVWLfUcRMhS?=
 =?us-ascii?Q?nl8BO0vfn7CH/NzfBj8mh/PIPk06zPrm9NM9LDK/Qguj9yqLfIMt+I8BAvBX?=
 =?us-ascii?Q?LnITSU1voMUFTzWsH6Zxe2xYUtohIfrHVBKbd8psA3jUNER8vRgE0o9QG1Oz?=
 =?us-ascii?Q?jzgmttOok9P+y/xN36DMGdrjTDFfT2MmBylQoUucKXGeBUCQaUC7RxDhSyO/?=
 =?us-ascii?Q?dOYnhLeAh6LHawMcOtqiKqQhMQXpe+x5L1gdJoByPTcoiCmrfGAqb+y/InwS?=
 =?us-ascii?Q?68pzsFAVjB4z7OeVLt2+dy2ccFjg7VWKnAdNx0/s4JLiXexV38uZmSlvxxUq?=
 =?us-ascii?Q?jGT8onWXEFcrYFSR6RA5JuJGlwrsKH6Z5f9QKYl8IqaBK2Pcq5LBqdWiHVGr?=
 =?us-ascii?Q?BTVWoVtuqkPSbv6HlAa2xQ27JdD+aaD67bB1dw+AVENySRajzzBJ961RMvwv?=
 =?us-ascii?Q?b6u28Y2N3u/gj/5+6U2MzXb48SrGtBdKoTl6QmqJhUlEbYm1dxJnpclOG3Hl?=
 =?us-ascii?Q?Yvl/neK/CdazS6R+lcByII9WpV5izy2+3oM7JEI6m8XUFioxZzm6BdZAdtct?=
 =?us-ascii?Q?p176mbosiGaD2J/zwLnmvoHKBn0Bh9WF1EuH7pkfS/+ZCJ3U3RXzrWpwF4Lp?=
 =?us-ascii?Q?wV4SaTcvAZZf62gTKHqUhvjjwGt9t4Rso121vvbL7VweQA5bR13qQI0NXxXB?=
 =?us-ascii?Q?SwhMFUOyH1F35mQHJw3m4tzvw9sowyWFP4UsyjftV6th2RA3TqEsgAUhOudC?=
 =?us-ascii?Q?T9yOHVrjrfLoTczna8FnuQ5SSMjI7lzGzkHoDzYiBvCYuDaPZt9g2OTHRVc0?=
 =?us-ascii?Q?TMviMe6HzOq4beNDu2YbGdOs4p/7lA1votEaZe4hVIfsOAip2dZDt+LNHcUq?=
 =?us-ascii?Q?73bzyBJcCBXY944lwvqzxZIc29fsLUgO4gfOyjBOqx+G07bRImhDD/BH9H4P?=
 =?us-ascii?Q?sgw1RCiMqSko4gcnBDYLgldZM5eRUDxMkO7BskDA8Q77y+1UgIUYkCUnO5P8?=
 =?us-ascii?Q?1TUt3qsPTIOqRp+xycUcrD4bhtVO+L++?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?07T8VLv2ZH7Bn/rLx3iBzpYRZlRkMl3n7dE8ruJn+ps2ojRDYQxVL7R4WDzx?=
 =?us-ascii?Q?zNE/TV7B5RyjXxbzQpLOUljgiGd0w0Al52uBVWJHKe+ErHtn08IOivNzWycj?=
 =?us-ascii?Q?UOBLNjmu51q/G3G3KP+T65KKF/MQ3ENNs9w17mr/SKIidLPVb5GGrYw1UlAc?=
 =?us-ascii?Q?VHfw/Jb+fqr4EUksiEP+bhKVKBT2kw6x9/KSkIX9AGYbp2IFRfiD+Gtrwbjq?=
 =?us-ascii?Q?NXA1+4KdO17wsqh8iPWVeOA4L4j0fRtfFQnz/li/UlH+WcneGivfX3d8udyn?=
 =?us-ascii?Q?v6WiXukkvQOxHJG/FOM+E53k7r2H8xcFAAlkn2zbt3y6B1hlrhKjevW0GZJU?=
 =?us-ascii?Q?mOBql5dgIrqDEmYqEQarf+L+Z7q6/B0y73mEobKoBWWCCLrKlbkRtOO6zVbY?=
 =?us-ascii?Q?146Glq2RqMQCajRt338l8JLoX8HN/1WderNsd9a/sDUzOqVucgF7iPB3t8tJ?=
 =?us-ascii?Q?XjG8wvQSKyLfIa3FjgflDvBPvFE3HgMZOrGNuUuvISkBdF9LRzXD0RnTgjph?=
 =?us-ascii?Q?u4TBG2a2BemU+1IvS8SeWyc0eD05nDGec7mHQQ1537Yl7mnfFntA9tviSGHa?=
 =?us-ascii?Q?u71Xs6sUIYt/rlzO2mltp2KhWRQsGhe9XdlFvWgWJHBkVghAl1mwHsP1O61/?=
 =?us-ascii?Q?Xi29RvDxfHoqZGxPqltssFUm+VrRQVd2pGAx+6EW6ujbGgMWGgX5ApiimmCw?=
 =?us-ascii?Q?ZKlHjo3SF7tdatyKWO6FUrdRLk79Hhq72KwI2ibF6j+ewLbvRjjAzEJMO70u?=
 =?us-ascii?Q?QSYtLlMM3QYzv4l/KIs4XqnKAHalVzVeG/SwGyUhg6DFrCIieBsNzs/194f9?=
 =?us-ascii?Q?UmlUKtn+NcfiS5XAZU7Y1jOSb1wbbqCe/BUFtaoFIIEZbJi1EuWE4UJvuR0z?=
 =?us-ascii?Q?octJbMe03xQQ98DfbdILTWuiJ6PeC1nfwgyIXfunpNqF+BosIBBHP1bcRdd8?=
 =?us-ascii?Q?odkxQ3ngnvLR3dUf2vNVEClcD8KrxJUOkqHc/DYTMTwm1bt9dxj4u2mh9ihm?=
 =?us-ascii?Q?mvzSIssmrHTKwM2Gr4AjS6S6lMXW9NNIAiQRfRzP8UkBa0PR6PZFsAljmOOj?=
 =?us-ascii?Q?TDZrO3t7X72MJqDbW6euHy6FzGulp2yKoqav4Zpz4yrfjmEYmzKe3Mz4ialu?=
 =?us-ascii?Q?IvSgi4JLT5rrMAj4TdHObSZG3Ifx82X9C4d6slxE4HWFkfUDa+VBTQAVsSKw?=
 =?us-ascii?Q?u8Opgtu9nZtDbc5ThgM4dGnvfZZ/8oKRZx1/h86FNmpctaIJiU4B0JQyQjFG?=
 =?us-ascii?Q?SRiP7F0dahGaeSbom5wp+hH7kWBqpxprn5OdIibdwGxB2tatfH32fw+9gpFa?=
 =?us-ascii?Q?VC4tz7qdhveD2E1myezITRvjGPmGjIuUsKAnjdksUe9FHG9JQWcxMvJBe6fA?=
 =?us-ascii?Q?QMIANCQau80AI4vmg3YWAIRFb2n0iKBiv4zL6UO/VVTPp9qMM3Vb/0+2qNfn?=
 =?us-ascii?Q?0/hoMiLqGeIGttkdOcrfzvsvUcJLf8aMEGcR7QFTDpl6y2/o/9m4mQ8WZSgG?=
 =?us-ascii?Q?+FpZRMnU4ZebtloKPOoW4FLfAec3OTqXipq+Y0xiIK+3pjDn5tMQESjT86G+?=
 =?us-ascii?Q?eya4fCCZ8AGgf/9C4aKAonCqgu6QKa2Bz0ryQTBG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c8548d-b048-4365-8eb2-08de12c741cb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 06:33:34.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDLdzWbaoDkrOURVZO4RUGynrLJsFMWB7DvXc0T/dnQDDaFimUrCpw59GVk8EXcSGhNGc+LFPC8m6wd49rtSzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
X-OriginatorOrg: intel.com

>I don't hate it. Seems more scalable than current approach.
>
>See some comments below.
>
>> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
>> index 128e6ffba736..fa9bb6d47a87 100644
>> --- a/arch/x86/virt/vmx/tdx/tdx.c
>> +++ b/arch/x86/virt/vmx/tdx/tdx.c
>> @@ -226,22 +226,23 @@ static int build_tdx_memlist(struct list_head *tmb_list)
>> 	return ret;
>>  }
>>  
>> -static int read_sys_metadata_field(u64 field_id, u64 *data)
>> +static int read_sys_metadata_field(u64 *field_id, void *ptr)
>
>Keeping the same name for completely different functionality?

how about read_sys_metadata_fields() or read_sys_metadata_all()?

>
>>  {
>> 	struct tdx_module_args args = {};
>> 	int ret;
>>  
>> 	/*
>> -	 * TDH.SYS.RD -- reads one global metadata field
>> -	 *  - RDX (in): the field to read
>> -	 *  - R8 (out): the field data
>> +	 * TDH.SYS.RDALL -- reads all global metadata fields
>> +	 *  - RDX (in): the physical address of the buffer to store
>> +	 *  - R8 (in/out): the initial field ID to read (in) and
>> +	 *		   the next field ID to read (out).
>> 	 */
>> -	args.rdx = field_id;
>> -	ret = seamcall_prerr_ret(TDH_SYS_RD, &args);
>> +	args.rdx = __pa(ptr);
>
>Maybe take virtual address (unsigned long) of the buffer as an argument
>to the function. And use virt_to_phys() here.
>
>This way there's no need in cast on caller side.

Sure. Will do.

>
>> +	args.r8  = *field_id;
>> +	ret = seamcall_prerr_ret(TDH_SYS_RDALL, &args);
>> 	if (ret)
>> 		return ret;
>> -
>> -	*data = args.r8;
>> +	*field_id = args.r8;
>>  
>> 	return 0;
>
>Hm. Isn't it buggy?
>
>Caller expects to see field_id == -1 to exit loop, but you never set it
>in case of an error. It will result in endless loop if error happens not on
>the first iteration.

The caller checks the return value and bails out if there was an error.

>
>Drop the branch and always return ret.

Setting field_id to -1 on error appears unnecessary since callers must check
the return value anyway. And, even if args.r8 were copied to field_id
on error, this wouldn't guarantee that field_id would be set to -1, as
SEAMCALLs may encounter #GP/#UD exceptions where r8 remains unchanged.

Given this, I prefer to leave field_id as an undefined value on error, and
callers should not read/use it when an error occurs.

What do you think?

