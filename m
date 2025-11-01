Return-Path: <linux-kernel+bounces-881080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D75C275D1
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 03:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5113AE6A3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 02:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EABA23B615;
	Sat,  1 Nov 2025 02:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Di3/wKPz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A4EAC7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761963528; cv=fail; b=oAmJ4H3vh8+5/vtCOpplVSxAcboqXwl/mvzVtndPJkPoTnLdboUG8R8VQoPczCKakSwd/G46sRvHvbdFQ5Wx+YUAFpf1qKRXPeJH1RGwUkuLmjBxETemnDQon8nkXWagv5RfSVAuR2TofWZouwM9puQZMiWwZ3qbiIWkNZeWR6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761963528; c=relaxed/simple;
	bh=HNHTL35ciAn6/g9figgakCnqP6165Hfuicl24Bko34I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VaAFM9nV4X0Un7U6DAAdlGDQjnKGCE0lCWI0k137uLcYD07dXkTjLG8gYM+yB8zqsk4tsyoSZ3yvNOyIFFnx6MZH5ygqTqol0z3r9k3KHPVrfueNpQ+LzqjDsNUGJ1T2SkLKyLBKJkgEH8rjeRrARDWDSPNJChTB/D48oXM5D7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Di3/wKPz; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761963528; x=1793499528;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HNHTL35ciAn6/g9figgakCnqP6165Hfuicl24Bko34I=;
  b=Di3/wKPzj7O9Njo8AChxKBOQL5Ew170ayXXqhBQb8QQiAx0Umg2Fd6b0
   NGFTNywvKKfRPssNa/yDq1RlxCMz3QIO78REn1VVJc3auLBnzTXHuWT1t
   x+lIhr+J/qdblhXuy2V6/BWDWXHt1mpA2QsuCJPgkC3j5a3aLAAZ3shj5
   ZKEPoAh3wJ/2xd0ZY0aYP9eDDpjJM3JFut8vgT6oUvPpsorQTOTm1OOQp
   W+VX/qxsOHDrys3UhwqK926T6WbCerCSlKnwqba4D9bjSACvlbPwarZdk
   C+lFshqDDu8KhlMZi796WKOlhJjRVcAy3LECqKuKLKNwao49kViLdLvwt
   w==;
X-CSE-ConnectionGUID: DQpj30upRSe51ILTNfXbjw==
X-CSE-MsgGUID: HxDPavPuTi2KxurpYza2PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="74422735"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="74422735"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 19:18:47 -0700
X-CSE-ConnectionGUID: 2YsmTDXiTGOMdm5HrbA5XQ==
X-CSE-MsgGUID: B+DpJF6SRr+RYS4EhQw1pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="186253356"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 19:18:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 19:18:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 19:18:45 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 19:18:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXkfJXpMOVmzlEQ0oW2Zt3XEgrUf+DuG9L5vTl1V+e5j+ktxzN345FMAO41hDYHrSpI+9hktw62/oBfAZOGLXjRGmdt3YLBV4LZZ+9FJY6ivBDvY9kNhBzwnU2p4RYAJ7RZykQ5sJjO99NlckZrxl3RBU1eh3UJHcUKM3ElWmOqz+npVO7pEFI/Pqh3tLtZXYpXtVwrQgs/OwyA7R4rIp8KdgoUKGI61rSAUimlCDn+djl+ZjPGkHjhfpLiVbAJXzUKVVcAEm1+/+XCPz/TK6YnA7bM0YVieIn5NaCq54wQJvO/q/Drf1qt6wh4FeYxneySFQ8FEwKYvqJGlScqiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNHTL35ciAn6/g9figgakCnqP6165Hfuicl24Bko34I=;
 b=X2SUWKVRj7Z2kR//j27Ds1fVxC3mV8+mluWmJmNEHsTaVCeXAx7ZANX6vj/PtT0UNIlNUSsWfkiPn16iOXnD/K/0Xz5aMh+PP5Rg2F130wSnJaNHsaznmVjXHODWzcwIJH+Ol+9Tif4qQJb6ZbGiIF6EMhMgir+yJktBPAKgNwYJzCGvM63sgT1BvHemHj+zwy6YM3lVWTTvs/ipJBVLfOaNxuzfQHEp453yJ4qwFa+WzfdODbdW0IWIKFSDU3fZ8JigLqah3Xl5pYvGyN7lZ+MYKLJdN6Todk7a8KojCyjRIyjvmKaAAt6khlZI9UcC+8u6Ukaz9rSDE0HmZCQOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Sat, 1 Nov
 2025 02:18:43 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 02:18:43 +0000
Date: Sat, 1 Nov 2025 10:18:30 +0800
From: Chao Gao <chao.gao@intel.com>
To: Vishal Annapurve <vannapurve@google.com>
CC: Sagi Shahar <sagis@google.com>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<reinette.chatre@intel.com>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<dan.j.williams@intel.com>, <yilun.xu@linux.intel.com>, <paulmck@kernel.org>,
	<nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Message-ID: <aQVt9hk0d4u1IU7S@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
 <CAAhR5DF74PhX_YpMebbqnZOJom-sR=1s7xbhrk5WCTS8jn7U7Q@mail.gmail.com>
 <CAGtprH9UTqC-wmOhfjr2qNk2X-BDJokmLYjET=Zm+Zu+QHZ6Dw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGtprH9UTqC-wmOhfjr2qNk2X-BDJokmLYjET=Zm+Zu+QHZ6Dw@mail.gmail.com>
X-ClientProxiedBy: KL1PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::9) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CY5PR11MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ef5cca-d633-4a31-1127-08de18ecfaa1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iVP/ckClO1Dt6G5rVDMJz0mAt2fUjcrH9BJcUeTl26iRptgVfpXYiiwnhM8X?=
 =?us-ascii?Q?G00O21IwV8Mt8bXaxCQjaO6LPFzjwdw1oUHy+v/Hh5viy1zwuEI6BwC+khcN?=
 =?us-ascii?Q?h0+wZuJi4c3bHTxQoEjdXfFrfEa1Rbc7b4I74zXbVnZZYfN4ctocyf2mTE01?=
 =?us-ascii?Q?eavF6IBmmZw/ZfGn5OYw4fhFLRcI3Ls4h9Oq6KjLskEbBSGsMlQo5rIq8VQg?=
 =?us-ascii?Q?a7Jp9dmct3X+ot7MFVBpbd+qsZg1aWaDpc5eUncurFUqiFoPoyMsjrBfBOWc?=
 =?us-ascii?Q?T1wT2+Pe0hFZVrjh3pbncqimH9xN7v/Ey5ZFPC1KVSTxR80geoHBkNtOWE5k?=
 =?us-ascii?Q?CjbmnYs9n7Lv51A2KfBKs3hkC4hDVhhOraLcuB+hTK9Ias31aMHeEpW6cOpZ?=
 =?us-ascii?Q?68IvXTzt3YQBSPkkFhOtZM4R2A8bag3Y4ShP4nRgc2ZGyiTvNeoX8TkSYCaf?=
 =?us-ascii?Q?hl/sLc60bJVSNgtCHoK3cwZ2jkLQ1BjoNF9G9/RrHwoEiY0+dWtLpPHuTzwF?=
 =?us-ascii?Q?Iikh/8S+rIedg0AXQBQS+jSeyIaHdQNU0u1fhWbQNKHqGpqJRD4Sl2fh3sle?=
 =?us-ascii?Q?iGZzRx91PctqTzuQVvY55MCOaOFW0gNoy/JJzaPHqYT1KNEVbaEHuD74TIvY?=
 =?us-ascii?Q?abR4chAZ0Zrr4Va/JjFijes+AoM2roo2YLd5L7hA7mr78uaPrNNzI/7Bqz38?=
 =?us-ascii?Q?FMKJhRwb92YrjRZ4ZHs6Cp5s3euHnZwwLNh4Z4xcYOAQZ+7u5KN89IRaehQh?=
 =?us-ascii?Q?/fZwlHZvbBv2Fv5NhpqJgkh47s+YFObb6btkn3SFHSgWt5q4TIDa0CyvOQpr?=
 =?us-ascii?Q?P24YdSxZwz8RgHiEAXZq27ko5njYFWeuXOMbbOEU+0Uqwif0op4vwkfBPpWy?=
 =?us-ascii?Q?xIX52aqgoES4oD62sdzecyx2AA1AeSTvSQJg6vZuu+9deKfTtZ2qE63RkI9E?=
 =?us-ascii?Q?5YKv3xuh8VjD4VCrI847u8TwTbnF7lMUaf2t+TFHEzFb7vyIwnm97BepvRsB?=
 =?us-ascii?Q?1TY5aMpzcITb0HzOiFh6DswKNz8u1aftJ6Ugxx0xxxlI/rRMpNjbfeMB2Mgc?=
 =?us-ascii?Q?LHm6ZF/mPXNZP7o90gSas2+XlkjyiV8kAkUV4DI78X16IdCxxPqlTOwWgvIk?=
 =?us-ascii?Q?IQGjXnOI5Zd+CTFvOVVLmVNxflxrZI4H9/nDmXQfmNZ5+kpB8kIQXLUC56MB?=
 =?us-ascii?Q?f2jJ3Q2pxdV086kWNdYOGVFRK46xiWmynmREhelwvYRctjK7732E9YoLsSgA?=
 =?us-ascii?Q?MZ6ixr6uVZIZvRkWZmyzCxg0emeo0LrdfABpi0jS6x5VJUJVttj8hVjvUVFx?=
 =?us-ascii?Q?UeOF7tBspPIA0EZOqrEye+8Rxhz/Vhlf65cPWUoXUdouYO0tAMSQvMGM2qWW?=
 =?us-ascii?Q?V92xKmOK3vawvIO0Fx48DSDz1Yqphs2V9BVRwx3WQuLKh7X3PQOvfphTGT8T?=
 =?us-ascii?Q?VbgH6CYpn6613VSQu6wLwoYZ8kgMCog5tCMi5u6wZb8N3zzVKvjH/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfNo49v8xGQFLcVIiG8AAokRlWIIMXxzfteX2wrEsT+82pCl/SIGX10/DLN/?=
 =?us-ascii?Q?3B+DQGVSXLO30L0YNQITWmHTEs/ygNUlFMUaorQGtIWVq/6ToWtngaXBBxgD?=
 =?us-ascii?Q?QHyW+UVyUAF58F8fVhOSblz00W/k3C3JOakqVgi928tsZu3Y8j2PiHBUtmR5?=
 =?us-ascii?Q?XUBPVNM7RSRandft75eH8BM4vnTXT11k4a89A9ROD8tYkiZJqD0d5cZmqhdA?=
 =?us-ascii?Q?Pgd2YARQ8RWPiEehnaJgjfo5Ldon9361sD9f6Y5knrpumIsuXJ1n7aCYT8y9?=
 =?us-ascii?Q?cV5jT31MdE3s0yJk0Qj0AuWwRe0W4wIiGJw9tGeMyoBwu8w/yTkEJ4UAOkMp?=
 =?us-ascii?Q?xxmnxN+cFF7RJCCkrxvPNTiudZXUxnoBU7uSMKlzYxGLsYXuOIe3kXRNgIzp?=
 =?us-ascii?Q?+eTV/63cpj5eP1ODAFdrMucPfi6xnvASmYlRe5mboIKlN0mS92jcuyiui7XA?=
 =?us-ascii?Q?Fbzit7R1dFWVZFo6iXwAC2sMQHPSMFxojQtAS4GydI1G6S06/GZEVkZi4jL3?=
 =?us-ascii?Q?PMLBjYtrWLTfRLZzzSmzr3/hOKxjvQ8VlH6ZIjSnNj6Q7wowdhIXECyj/ogU?=
 =?us-ascii?Q?f2RPJBlI2vGjwqidScLQ7xmybCz4CNLi9urwSQ2nOnEq0OMYzEqerac+M7cz?=
 =?us-ascii?Q?Xfsns5GTfGYlJjX63W74gnQCP3uXzP6EKYEEDAVgTcFoAHF8h6EvRs3l6pGe?=
 =?us-ascii?Q?tBdm4NOQ1Wti0pUXRp9lQ7kq+ibV1rXzjSsvuf4bPilnNfXxNTTRIwpj9cHC?=
 =?us-ascii?Q?u+gkfFls4Mb6RtnQ3hn3/NMLGZ9fyNM9X8dVDnPdK0x2+Mo9iuWkdFYjH5Dj?=
 =?us-ascii?Q?rL5mphI49NmgzkqkzXa35ib0A8hxPom42Y6foupWkZMkWhhkHEm3uW5bfFzl?=
 =?us-ascii?Q?Olh2yk6whA+1wmK84dNhjNUKRDiuzpCA6PZNiD8rmT0E6hQZLFbTXx8HkAke?=
 =?us-ascii?Q?K90f5DTmIc/Vi9qbo8HmrRMMdsv5auAEMuLgM2Af7f5s+ZtNVbBmvu7WvvAg?=
 =?us-ascii?Q?zdZj00LAqX1HiNxcsiCoaux7M7R1pVCS/KtsUBe3HIxhtwIlJA2IJPeQuM+y?=
 =?us-ascii?Q?IctqEvaJzEbeS9IvgX8JMySbN+HZg31PHYvhk6kXT/dSUrhXMlWnaD7pQh+x?=
 =?us-ascii?Q?U/lnOI3v38qXcNem0t6B1rPt4WmGEcFfVQZyRzzCOVfA11zatYYJNmTHo9WV?=
 =?us-ascii?Q?SxYNyaNWsnmIinQJ3NgqM6NXidfIJM/foBytLFX1VRkwrMIpK2ed6zdMTq1b?=
 =?us-ascii?Q?b4uRCuzGgLPmHMRj8aXbcQbX323+OQRFCOJ2apCY14GmYEDl+oHkxXWQy7Mt?=
 =?us-ascii?Q?e6Xen6ITVEj8vdo1XfA26GRsdm2UVvrytZLvfJxqRTNrrXm35ZNE8KG8Z9D8?=
 =?us-ascii?Q?ZURnZY92JYK8YX5RRIJYYit4FfDXD1/4iDML/AqVNmi9bb5ASquBi7WGphWW?=
 =?us-ascii?Q?YIPzjbgHusB4y1lJtxNzPM7rE5PMCbq8BPlFWX/R9tf13PK3yNDXaW8R7qaQ?=
 =?us-ascii?Q?BBjjf/DkeWum+oTo5qLZU+clj/oP0HrMsmsKakQtgB8sV+NZGwwGxBlVI1LZ?=
 =?us-ascii?Q?QPgm26BaSZ+OvhyWL9L655l19wBHsFuUf+fh7opx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ef5cca-d633-4a31-1127-08de18ecfaa1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 02:18:43.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHfwkNZaulGP+h7ufV/dAGpmMasrk42TrDwpWai2e74vcyTcDDCgbTTlJXZj9irdT+UgxnR1liu3NYXJ6bEMZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com

>> > == Base commit ==
>> >
>> > This series is based on:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/commit/?h=tdx&id=9332e088937f
>>
>> Can you clarify which patches are needed from this tree? Is it just
>> "coco/tdx-host: Introduce a "tdx_host" device" or is this series also
>> depends on other patches?
>>
>> More specifically, does this series depend on "Move VMXON/VMXOFF
>> handling from KVM to CPU lifecycle"?
>>
>
>Hi Chao,
>
>Is this non-RFC series dependent on RFC patches?
>
>What's the intended order of upstreaming the features and dependencies
>being discussed here?

Features are expected to be merged in this order:
1. Move VMXON out of KVM
2. tdx-host device
3. TDX Module version exposure, i.e., https://lore.kernel.org/linux-coco/20251001022309.277238-1-chao.gao@intel.com/
4. TDX Module runtime update

