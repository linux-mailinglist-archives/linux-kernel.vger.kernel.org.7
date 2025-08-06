Return-Path: <linux-kernel+bounces-757447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB135B1C239
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167D7168D54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7CE2877FD;
	Wed,  6 Aug 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNJL9m4Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D46C22156C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469364; cv=fail; b=QFrB7bFym6hbabX+PzH/eJ8dhjx/S38ZtYo4uComZT8uTtLCJK6jiwBzZEg5YRw/nSXDs2em6b/y6imDwwlb7sC4htpMYglqU99oeExRPygu0wM7A07S3ICJ1g7xpj834w1kci6CoHP8GvhG2yL98uGkqYFjwvf9PBgvjUjkvvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469364; c=relaxed/simple;
	bh=YG2VRs7svyvbwYJUJXXZSPDq25zS1Gx+dTyCa2sNLd4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CKtkksMzGrHATb8UXPZYmyI2Z9KKJjeFRxG1yTkrcES61UmBYPennf41vHLkCwWvxATmBs+Avu1/ZLckCj4MB/gY3/eC/i/JFCKUplqIxc1PKMAibJiF5R9mpqbKXVgd2J5UwftC4LScbrbTDCPW1hOwut6DspZAzFtxpiGh9DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNJL9m4Q; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754469364; x=1786005364;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YG2VRs7svyvbwYJUJXXZSPDq25zS1Gx+dTyCa2sNLd4=;
  b=nNJL9m4Ql0yAyaycBXhjVx8Jg5wPb06ZbjEZgluTuh78pfsyZ41IHnys
   qERw+YEQnkr53kbL5lHoQNPJ/avlDDGj4IN9r9sulZUfdkuuulL0POXKc
   ZTBDwXOD4f8+lmvhYJf8/tMMY8FV09au9rJMcE59BbZ6oDGaV3zQGSNNV
   5B7Nd7WywfbMK5UsXWAma3NjFON2kzprkERO44onCvk9ij7Rqq7YO9FvZ
   oRc7RVVJ4yjvaKYwBw6XJOWOcElywhPwklCfMKugIDYCn9Ub0075Mgtl1
   WtfeYgi0+neP0CaAHZFXF00H+fAHsdTPV8WhUgylSnel4oOirsIM5KJMV
   g==;
X-CSE-ConnectionGUID: JxrgDqy3RJuZlPuPONLt0w==
X-CSE-MsgGUID: YJSAKB+JS4GADYLLy3ACug==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56856889"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56856889"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 01:36:03 -0700
X-CSE-ConnectionGUID: OzMnQ3p5RWSSZK6lBj5L3w==
X-CSE-MsgGUID: 64S0SdZVSq2IoyyL/9jWRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164250013"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 01:36:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 01:36:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 01:36:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.81) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 01:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIZzyFeym04GFBsqRFKIywT06BAX/830Q0tbRJakFPNpQCsl6IokjM2sWGuZwsIpLDZpttCr81Fkm191sg27FFMHEaU47YJlCnlZKWoT4FqRxftx1cG64pbff3j+EeiJPZoxILIu9tR//z00Si3hqBsvAo76gfDiWq+h1DL8D0IiOtIZ00ZjaJvzUil4OpjPyy14HG1GCt4kJCMAucSC457untotPSrhxpyP4U9jX3NGQ/0u2vnDdIAId7ocDxjME+BSeWlmLKHfiUiYvvhpG0rnDl9mXa/TcUaIdsOFoBG9zOQaIk3bBgnVrFnYEAA20VWcCq3fyTtGzVWJEBntRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Lybup78dsGtI8xHDVvmLXcrPSaeTt8G6pY9E53SmzA=;
 b=yIr2L7X8nw2vccI9aqdxn7J296HB1S/DgXteotx+3NZTugNCr/vc2W2rFQvTRSloOemmnRwfo7zPEOeYWHQ6+P2oo/OIZ0b8GicK+Mjy6PiTO8nHk8gtMW6YrFm/vYBhcLw4lw/5bG42AP0uIr1u/IrskN1uySkzoyPD4XqBUnVkMMBLZ0RKGAeN6ytbBk+D6n8ckBeCuSG1nKMB48DhNVqG3FGbGtsNEFPKg6LNW0fc0Fl/Y6Z1oHycx0VbSfubMNDBrv5T5saZXXqdky6LrkEnCEpJm/Gvj0OzuI/u1YCiissIg+zMYmgEGs6x4c6Ki3N+eEhBwYA0B18T1h3EUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8482.namprd11.prod.outlook.com (2603:10b6:408:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 08:35:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 08:35:59 +0000
Date: Wed, 6 Aug 2025 16:35:48 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Peter Zijlstra <peterz@infradead.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, <linux-mm@kvack.org>,
	<ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: Re: [tip:locking/futex] [futex]  56180dd20c:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c
Message-ID: <aJMT5DsFlOL6V+Nv@xsang-OptiPlex-9020>
References: <87a54usty4.ffs@tglx>
 <aINKAQt3qcj2s38N@xsang-OptiPlex-9020>
 <87seikp94v.ffs@tglx>
 <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020>
 <87wm7ro3r7.ffs@tglx>
 <aIrJipeLsGUM92+R@xsang-OptiPlex-9020>
 <87cy9gilo8.ffs@tglx>
 <874iusihka.ffs@tglx>
 <aJML8dcu4vu4rbMR@xsang-OptiPlex-9020>
 <87qzxoeuav.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87qzxoeuav.ffs@tglx>
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c1a82d-7c28-482e-7bd7-08ddd4c444e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YbUxdHGtRjC1eNAiJT0izwEuGkBzKVzpG1/fYoF585D9LzDjKc6gsZDwt2OM?=
 =?us-ascii?Q?NhHESdBH/iQPehUgHKjQUZcZ9Ugxua3+ovRy4YxceKOmgh+o3j4Y8SKTq0dU?=
 =?us-ascii?Q?Rxg+bciuNNNJmmyk+4iDiJoSZxtOlSGW2HmHMAXzqCHE04izmvHarVaa+y1h?=
 =?us-ascii?Q?kS0dYqDDbcfFVwModtbz4/9vVJ4jrt8lyAhSk7DO7NsJGRFBaZ4NkUJAlme4?=
 =?us-ascii?Q?RRsz+TGURV59poMc4DYUNWPBTgMN1KBqpt3eQ7kdoUhXnUVdEIqseNZ/6xeR?=
 =?us-ascii?Q?HBY6haDD8HBnOhKdePk9nZaupGqnVAyZaIEuBDdMxlhmUUw5ppzyl9KgEzpA?=
 =?us-ascii?Q?SN9ZwxGBBsYJwnFVYP0Bp/dKodf/XvDTUwMYgA0bIiWrynG/jTs58QoTBfQ4?=
 =?us-ascii?Q?JF3+vh/cqG7iXTUdE/VlTz8bozBEFdnke5F/BOvt3aPwq2ZkaKVCt0N+dHAu?=
 =?us-ascii?Q?cidY6dSwQmM08ZEZogINfh4pkTnNAWN0EF5gajoQtI5KTo+ZJwpuJ2yNLsiw?=
 =?us-ascii?Q?wr3/mDtKOKLhxdLTZ0R77u2QjiYDr6BU/X+ev8mjsrhI+h8Hsz1z0YwpCZD5?=
 =?us-ascii?Q?aYuE8SRXifNHGzT7vv+S5sQJRzqmNShQGzufKa90bCf0TCv+NfUhFCVfe1uz?=
 =?us-ascii?Q?7dVQXimsEsG9taaes3iDuDtDUo5rWUshmEvqYkFQDRPoPU5ELRvatNgmanMT?=
 =?us-ascii?Q?xRx0WYz61i4OXH/VWjH98OAuyN70yQ5GLKiqPFq54nBsEbGhsa5vC0vzwIOx?=
 =?us-ascii?Q?6hs2d9JKX4MdfV7nJSbTOugJRBpmOntr7eIfDXymCbsILYfy2XQqYRrYrgY8?=
 =?us-ascii?Q?ZSuMUvd+RxwoadA1itGgpDChYfXM8mpLAOOgItN1T6gY7wKpN8wZbqKKSsUL?=
 =?us-ascii?Q?yxDAK6JPd6Rh7ZnyGZ6Q76p9yi9YKzNHy8R9wTd3Q5k8mO7F3p09V59XOrnC?=
 =?us-ascii?Q?tmoMF+s0y/fnqq6jkREXTHjEtTIEmVZSqxFWJorTcjLd6fnyOy0IYlIpBwzk?=
 =?us-ascii?Q?OpKTgIrLy5mQ4Lg8LB3x6SHHK+OJHVtYtnpKZ1FXAJ4QB+7i7sBNtdAmewXq?=
 =?us-ascii?Q?urfIV/Cuat355/tZ1okZRNqBQ9bTqJIG4o29ByZ3MkxZkn2e8A+ErwYIcETl?=
 =?us-ascii?Q?iCzRQK55MHSjh86jKXsNaUnKjmCeFM4Gpvt+gU7jk18lroV/UTljXCkYkspR?=
 =?us-ascii?Q?E3JdJa8vdXN6LFh4ezsbRMPmMxON2i2s5ey8/7RmL4dOHZ4OCBlLElEJidkU?=
 =?us-ascii?Q?uyxqytWv6ZPsXSyqoOxuPGMQueFhtjZ9+ZnLZsheT/ldv+s5/TN7F/yXB4Pq?=
 =?us-ascii?Q?vqZa7oXWQeyf3rbE6i61o76Vgl5zm978/bjuC+ehtq5buHOqvxmr4OQQZPSv?=
 =?us-ascii?Q?8MtoZaCl0VsJECfTEkAwd8eTcgMY3ddOLTYRNXoBXNUue5CgquWEmv+IaH8b?=
 =?us-ascii?Q?bZAOygxUT3E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4BbPy3P4pi9W0s3OCuEONEy+gNs5DvmGqH7Jbd9ujaYo5oK3tUabVsxvWQYQ?=
 =?us-ascii?Q?zPnjGQhv1csXP5fOUTc0NrBicHje3AZsp3sEOoCOUvJ08FBUtw5l1uAD/lzC?=
 =?us-ascii?Q?19Z8at6WjzQmnEfkLVivVzIuINK8YDbHQ4RxgoAEvdvs+mBDQ984iWa0Ue5i?=
 =?us-ascii?Q?h1S3tZxia/yEZhIL+NTt/r9Vg9+F4y5bavepJZ93KFjBkYoqt7I5r7GAWQpB?=
 =?us-ascii?Q?XDwWCUm9IiCas3HSe0enUEFmYo9+wBmjUJvb2n91lNdxBYGkgIxiDg/a1l3o?=
 =?us-ascii?Q?nr/hQqEF/ISp0Ud/IutYJWrm6TdSru7ECHRJYrLF9t6/9EA0p8QQh7vMsu/d?=
 =?us-ascii?Q?8ngckceYBAdoqpTOVblAPWCnKO37/yL5hUHltYwk2nzLgRNvJp+qVR5AeD17?=
 =?us-ascii?Q?jKTYyr4oldWuZiOZ8y0A8aMWxnO5cTzClYZYMyQlz1FaU5OhjACcmEftnciz?=
 =?us-ascii?Q?QVo7yZ+FpyxdIQ57ZkFKTin+eApbx++BIuk2Xu8Y+A6MYKISrkk8WZJDrdCs?=
 =?us-ascii?Q?hEityioKBftlb279ewDS56DZp/Eytwp97SKQtUHme9AfnXP1fQkyJ1WkQXb6?=
 =?us-ascii?Q?Q1KnfAOAtXBMEhoh0Blxo+VvT/jlhF5UfTn6kHMdSPEPkTe1Tik04c/cykiJ?=
 =?us-ascii?Q?ctR1G95oi0cJEtUs9WGfNRFy7eBF0by9Idv3dB0IHtt2AhO0Rzxdd0Vh2OqL?=
 =?us-ascii?Q?0lE1+NwY4J6RePQ6UVjfqS0H4fOtAR/EovTsCjop4NSZvzhZ42rDMWCIT2/l?=
 =?us-ascii?Q?yFBNRNCrogFoBGISaPuOx03MAG3xnMCFDPieT+VJN6P3jAUsEZKo2xvCwzxR?=
 =?us-ascii?Q?JDqXBgGj0LSdsAGBOm03dfHUIDldQf2Eyq7/G791RFjKgzoWwZtX0kRyMjI1?=
 =?us-ascii?Q?UbH3s9ojdGyWe2IUAO+UGHzJlvfk+3Nm2wRIBbVF/CQ9y6FM11dWndyJUwQK?=
 =?us-ascii?Q?qTbt8H0FeBbsVA/5dItkUb2KcxxAYTttzHY/7U0OE0hMC5Og312UVP0kSKmu?=
 =?us-ascii?Q?01ScsVBQJw+2TWorZnG9OYlbgPLKif73a5YxBlye3lKwQWywzPsuOoh4CMGz?=
 =?us-ascii?Q?cpG2+3ZUiF9/1bkjRX1q+QymYd0bkiv52thuGCUvJilxh6LLYmUv0b7Plm+f?=
 =?us-ascii?Q?nGGPQhaHTV/86Esg9v2eTkm9+8GERKMOSj/AmzkHBY8Ly5iQU44pYSvLzHwN?=
 =?us-ascii?Q?UIehUIl7VKJs9rkehU+ze05VfzNF8fnN+7Yza6bv9m+vEersiWoqpCDX4Iqe?=
 =?us-ascii?Q?uEhd5CHWYTyH8oYm3k3+5GT35UT/Cvsttf1KNLmOgq5hVPPIVYc2gpCXRB7S?=
 =?us-ascii?Q?LEmKN5T0d6nrX21atFbBAyhwN8hRfZa9wKLp3Dw2mjgCh6luemRMhPbmqDC6?=
 =?us-ascii?Q?UGe6sSdS61OZxWAUl5RNg/vV/5aRnClzKE3SyyY059o4/LKaYzbRD9hguTHb?=
 =?us-ascii?Q?crWLhDxcUa1wEmOMvMvzl/cWL48ZW0tgjDQf+VuOlD9L4vxERcnJyNOgujvt?=
 =?us-ascii?Q?etKrlXV/zj/oEANcVDQ2WVVTVa4i6leRKA+3PrDdzKxOihrIP1O2088zpX+f?=
 =?us-ascii?Q?UYghKyajdPXmpIawvdXx6Yj66FHFwBy9TFRTgn/WRxbeSCw4kYMjWUvbRPEl?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c1a82d-7c28-482e-7bd7-08ddd4c444e0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 08:35:59.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vf7rQGEsKW5mi5mBCv7OkTMtiBOcA4LqOWXoH/VBS/arjjbvSMpnXyi7xcg7F1vinlzRXEexkimjuRYlJdiGIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8482
X-OriginatorOrg: intel.com

On Wed, Aug 06, 2025 at 10:19:36AM +0200, Thomas Gleixner wrote:
> Oliver!
> 
> On Wed, Aug 06 2025 at 16:01, Oliver Sang wrote:
> > On Thu, Jul 31, 2025 at 04:03:01PM +0200, Thomas Gleixner wrote:
> >> On Thu, Jul 31 2025 at 14:34, Thomas Gleixner wrote:
> >> > Either you make the timeout longer or try the following on the kernel
> >> > command line instead of 'ftrace_dump_on_cpu':
> >> 
> >>   instead of 'ftrace_dump_ooops'
> >
> > sorry for late, I just took several-day off.
> 
> I hope you had a good time!
> 
> > attached dmesg FYI.
> 
> Thanks for doing this. Now the buffer is too short and as nothing stops
> the tracer the interesting stuff goes out of sight.
> 
> Can you please apply the patch below and try again?

got it!

just want to confirm, still use below params or need some modification?

trace_event=preemptirq:preempt_disable,preemptirq:preempt_enable ftrace_dump_on_oops=orig_cpu trace_buf_size=100K panic_on_warn=1


> 
> Thanks,
> 
>         tglx
> ---
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5850,6 +5850,8 @@ void preempt_count_sub(int val)
>  	/*
>  	 * Underflow?
>  	 */
> +	if (val > preempt_count())
> +		tracing_off();
>  	if (DEBUG_LOCKS_WARN_ON(val > preempt_count()))
>  		return;
>  	/*

