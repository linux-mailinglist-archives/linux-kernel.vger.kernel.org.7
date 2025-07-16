Return-Path: <linux-kernel+bounces-733153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC3B070E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB5F189BA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E92EF671;
	Wed, 16 Jul 2025 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxvTMohh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0C2EF9D8
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655866; cv=fail; b=Dz4e53nVbcJCdLTIFcUvr83AN/8DbaZjDM859P9C3XLW901fkuFT79z+AuiHj3aDf5vy8yi8k/4t6Uxt338RlGktg3PZURsy3X1krIWXY4BinquxGkHB9FYRqMEItzV3jmstyJYtIUv/tLxz8ypL0tocy8AUWWRfLJCWUzK+2jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655866; c=relaxed/simple;
	bh=kDbgxa5tTqjNbrWq847vUlYoRB/kp8fC4bFTXxIeaOw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JXjVlggkXZFFG82hU5jHWaFyTdSfZQj8wMPEmpdsb/cygZ0r8XoZaz4tYPh5rPISTMNQjrxDL3Er0us4PHmmsdyd/LFv/qDMn0fY4pfed5uqfB1fgb34IycVhAQfZRL533bC8XNJqttJfG0VYRYXqMQDzmEzgplJ2Ojj9jHajGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxvTMohh; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752655864; x=1784191864;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kDbgxa5tTqjNbrWq847vUlYoRB/kp8fC4bFTXxIeaOw=;
  b=nxvTMohhP1W/wVUViidN+XVqk87/budYL+LcYf3oKmuUW9cAr1gObK+f
   0OLDO7pqb4gZtIWcbIP/EwNLCgNJcExA2F1Psy5UHF2OagJuV6w+MSAwp
   X6Yj3blu1wmNoME14k6hMFuW6ArPIZNfiXypaM1ANfmF9hJx5QQGLOYmG
   LFahRnHezYQn+vdg1mn1CER5mIiSsRFgQAMmDCMOA9YM8Mcb+d2dE/I0q
   YtlyOgdOCIG4WIrMRWPXhzF+nIVJOjoFt9j12oWpKKSITv8YGFOXq8mpo
   C/uV0WAnK4B3NIiEWOfsQ59Zp5pjn+fLDn3tAYioY4lyuBpiAPlTpIkhS
   w==;
X-CSE-ConnectionGUID: OFoYH28XR7y+wT8Qy7b5sw==
X-CSE-MsgGUID: VMYhcDTYScqKgSUGhUC2Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58662476"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58662476"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 01:50:56 -0700
X-CSE-ConnectionGUID: x5feNW7dSqaFzBemhVvbtQ==
X-CSE-MsgGUID: ZlyLS2acRG+lAzXmVCylLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157548000"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 01:50:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 01:50:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 01:50:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 16 Jul 2025 01:50:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXp91ZCASzAHaV2Xj/dJfopPv63XqEJ5UoHQYDU/ezZk2AZ2ZKlkclMbnesZDtwyjy0RTsu28Fi9t9bgx27gd8Z0J0dXWqGMapli1xnMB/goakxzVjZ/hJMZ5BowKllh+sPgWtZ0khY5aoV3NPq6pvkwpLXtogwvP7L8vK0TMvRfpe1TyFL20MhmstcQTuB1d7lJChtg1ghS+hUeUJ7CvxUACZXawRm8uqTVc+GVhDACveDl0/RiYEm4NmVzDNwqCV/mdKRmdR50OYEn0/wFdBoWoGruaruroBV2Ub6kgV9u7CvJT/v1HsiM6uB7cRr5vj1XWpev2fMMQy2GS5KNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYww1NmNHAlC9cRKOQbX8+DrG2HnIhN02L4K995MCe8=;
 b=Dh4vd7OUp2E9eh/oUvvhvLjCLT9/7jviw8NLbX6JF13eSv4zEJ5ziSuBNQktQKfdU6srrl+U0g7XUxMWQlJUMDRLFmVox4dMDndD65QZQG7mhjKKvHQHn0m7qJRyyIFNLJ857qwJkJYuQvO57mhAIZVHfVEVD2YyDJde1i29JycSfQL5w52Hp3n0hYn5WQYR/W+fIIqfMeUsTjtLUuziTrG+uYuwcH8XzLSkB5sOoW3jf3y+mrc/udqTPXX9CmsUNq8Oy09gtJQl1Tk+eYXvrWQAnZAbiMAdQRUsh3GRPxeMCYQ7am7HJrqvM1/CIz6F99NK05zZwRWUbZi96lBv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB8248.namprd11.prod.outlook.com (2603:10b6:208:447::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 08:50:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Wed, 16 Jul 2025
 08:50:50 +0000
Date: Wed, 16 Jul 2025 16:50:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zecheng Li <zecheng@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Xu Liu
	<xliuprof@google.com>, Blake Jones <blakejones@google.com>, Namhyung Kim
	<namhyung@kernel.org>, Josh Don <joshdon@google.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Zecheng Li <zecheng@google.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/3] sched/fair: Allocate both cfs_rq and sched_entity
 with per-cpu
Message-ID: <202507161052.ed3213f4-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701210230.2985885-4-zecheng@google.com>
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eaf5cdf-0260-48fe-7ef4-08ddc445dd2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?3U3sdnh7TaYYlt9iHsEch3NLQU66WWtsPIc1Ontja0R+Eu/SXhOg4yJnxd?=
 =?iso-8859-1?Q?g8NjiXfrwcYdoSQ49sOpjKwRVV1V/1iuGCz92R774bVWOPPdMnhGuuIF9i?=
 =?iso-8859-1?Q?SfnaCqWLVbCQLSezEcsO5In2mPO2JIxO9peiR1VeuWhSRndeHiRvNuvNgI?=
 =?iso-8859-1?Q?XrcFf/4wEq9w+EDpzoK9jyO/VJGFWXzw/fpNSafFKytXsS6X8dVPJpFXIM?=
 =?iso-8859-1?Q?PYAG5vb21p9a/P3yjLP74UzIjvgU6MsIEzNOKagQTwgbcYeonNzr7i0qj/?=
 =?iso-8859-1?Q?7J05FGemSm1tYEdrB33oCCRNZJTJt1WxCnR4cfWP9Jgyb0PYNNbaHc7gzX?=
 =?iso-8859-1?Q?M4CULN1R+iQm6vYyWVfEZjAozFR5QwqJ6NWhc534CzKyvmbFuN5+ogpy0A?=
 =?iso-8859-1?Q?Pi9l753U9ZqKjqwz0taA8twoTks5sWuRVI2jwlRlXCf6QGTymIcoLdgwVO?=
 =?iso-8859-1?Q?jLK6ashqtoHO1dxk4epVchdnJ0AYkAvgNv0gvpD3UfNDfcMJ8kSzEZtlnW?=
 =?iso-8859-1?Q?w03d15fBBvp0yV7lRroEkJMim1yrhkgV+EfO0GdSBHat35fObZayDsRfGN?=
 =?iso-8859-1?Q?SvE+YZyA6TlAEI6etPAL5YOIDG/8eGnbmKulFlaSCjrjFoMwGOWPhXR29g?=
 =?iso-8859-1?Q?XwIiWhzyAcSKHtNuMrnhzTHs0ozthBK+aW+HsqnQ/EF760nd60SuU1RzF3?=
 =?iso-8859-1?Q?8za4Txicogo8jJrRHZRaoAyACkFye4Pe7wuPnzA9Xz/oslUCSMohunkTEZ?=
 =?iso-8859-1?Q?AuNwLIF/cgW9i/9T0Fa5Asm7FTHWKlp66OBkIyoLadzNJ0gKCDXn916aab?=
 =?iso-8859-1?Q?nDQC9LGmdpr2SBx8UESIxGh2I51SmlcTFVlwU29fW/xGY1edzTqdw4abuw?=
 =?iso-8859-1?Q?hKOwrlE8AGNUupdeOrGtW+nK0VAVPh2mIOAsxUjTZz6oFOxybIDXb8ha3U?=
 =?iso-8859-1?Q?ibXN4HU64mPhUdk5zLrevpHC0vJkhYZ2gmhWOhQUFgI+ak9z1FlWW4nEFA?=
 =?iso-8859-1?Q?vYA3bBsBi56rlQFLqi/sXk1EDuOxuYYNY+Lbz4twXV9BKERACoS6d4YOwb?=
 =?iso-8859-1?Q?YA5nYrBZQd5kVm9586txn0gURflMY0k458onWMQ0tzoafXDUsbCodOGpY5?=
 =?iso-8859-1?Q?TKk7pIUDWVh4boS6XrmSpkfk5zt4P46AjosYZQ86biqaVOEeih21nLDvz9?=
 =?iso-8859-1?Q?2TvtkRUYvEdxsmhJ0rr2vCTAUwd8YglNQRhFyjxO+hBtfFFdCzsnFuxd2D?=
 =?iso-8859-1?Q?FdjcqbiBypTamKRtkshe+i5h5/kc7EYKvp6W8MgW2yg9hCejckEZ2Q7G8Y?=
 =?iso-8859-1?Q?13A5A57jmdgz6/mNiIuEJPwNEDfJobF2hPZbzxhaZrpueMYuj7YczzZDUe?=
 =?iso-8859-1?Q?244mg6aN614NHQuzerCBFYKO2pCjlRwQzrzRBFFXG87I0j5tVNw33CAVTQ?=
 =?iso-8859-1?Q?lzmWbNr6/g9lqNFl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BEuKxrvjM1+GXULS+srDn68iMQu2hyNsjO8lj28i8/XrHRwBVJ5jB7006h?=
 =?iso-8859-1?Q?aCuwgoP5IAvFN5R4AUcoVzHo39J3RD8hkUhHpCB/oyRhQJsCWyOdgUg+Jj?=
 =?iso-8859-1?Q?uvUYzG0Q/EEvVjrkBlcE/S4ZHHHsxtDvRgJz2hsnBSP7zxlQtGPo5HqfZq?=
 =?iso-8859-1?Q?A/YL5zwArNHOPJTQWvaDnPp4YpvrpXgcnKeBRUiXuac7IYnHMeZuwF1PYe?=
 =?iso-8859-1?Q?8M6zfAe7Qu9U5tr8TnSfyeWNexR7lOC9XpLYP8mSrXNq/w6setMHF3Y9wO?=
 =?iso-8859-1?Q?Qx0YXi2O9XsF2lc5EECWdmk6lfCmuya9XtZWMdY1VTXfxdCACw1AEhx1Ur?=
 =?iso-8859-1?Q?fZfkQ2rWfQ4KW98aH6v3V4XwlevCiD2EG5CbvZzygSaRsZIGnjCRAjSbtN?=
 =?iso-8859-1?Q?8J1Ld4xo8j/cYVwBm8D850A4spKQqqhDHoT7qrrEz8It5rWVHXbFGzP8OJ?=
 =?iso-8859-1?Q?dMtwv8lGzGuI40E+HjWS95t5M5oC+Egw5T1+bDX8zIPaCOS+iRt+qxIdeO?=
 =?iso-8859-1?Q?9W9WConGcXInHFtNU4u3NJwtyzNpfPI7KGfK52w+hROeinrXGdieSiEXs4?=
 =?iso-8859-1?Q?eVEy+t3fettIVU7lMvC+UizqF0VRvK4x9+8AObO6u5+FuJwY0MqQJg1GJm?=
 =?iso-8859-1?Q?4pI/9Iq+hu6tN1TXImikvt/fjMGdl+GAuK0+8EPEew69pg8WPUaCd3sORO?=
 =?iso-8859-1?Q?v3BT58xN5pcrtaNsLS10Juxm/LoeXbjdix74Ae2mSpNV9KGO62jsF6xB1X?=
 =?iso-8859-1?Q?emwjuMUmC9MOLdxEYdrhZeWqEfUVGRyQhIJ8pdrHhxq7zBuqyErHXjAP0J?=
 =?iso-8859-1?Q?v0XQamp5bnoTOI40uPqM/KjJciXH4LEeZLfgwY5t1BVApkmsg7jJjO4Qvi?=
 =?iso-8859-1?Q?QBbNT/rNAV8UkB62BJq4W4eAFm0s1KJvrLrYVwPNu2PK8aAzbaGzjUZCPo?=
 =?iso-8859-1?Q?QRVcmPdL9BRWZgsSLN3thsc4N7KuD7B9CJHz5/AsmP6gySR2qOQI/ajqUm?=
 =?iso-8859-1?Q?fXBRTz3XOMe9VHdHtGCC88ZLSoDVVPiA+PKBB+7AvM77LjSfkCxLuk0K9z?=
 =?iso-8859-1?Q?D37a75+3edq05D3dbAF9t9+ZCAJDHJnkuV/qtkOjT3mmbHH0LSmPXCI65K?=
 =?iso-8859-1?Q?SOoxSCBZgbXEQ+15mMIwy349EQGun4FAKXORgalmH64XBc3Z2xYrp/MGLj?=
 =?iso-8859-1?Q?7pjW3/sQ9UHxlpEgHg9BH0UotJwQ4bj6eOnprrCUkhjbu22kg/L/WdQMa1?=
 =?iso-8859-1?Q?WLNicTcvrYvBteluvb5xsR3VjhaaC2gaRGj4Gnpt9jfkMBMo2MupIk7ZXu?=
 =?iso-8859-1?Q?ppkEeu1xTfefcFCkXVCPtjMKQD71iK2uStinXUH4d8TBbJyO7iX7e9Bzey?=
 =?iso-8859-1?Q?z7CKPr52o79YXWIf0CcVjF9CGSL0x1bzECoKpm3tSo8Fdjmf6QGUD36eVW?=
 =?iso-8859-1?Q?ymUG5DJXCGDtDjPIAvRYoH1IFiPeT+JHUfvNoK3hgPrPTEmZRMBahQm+Oe?=
 =?iso-8859-1?Q?borBMMm0evidTrYBZYQUW6UuQrkN8iHKJ4CkNMIW8uquISeoc/uejgiUnm?=
 =?iso-8859-1?Q?rdcCgLuhvY6JLSB6IXXP+f/7AVmLcIVF/6yYgnztXKzDYwDlz3F0658qY6?=
 =?iso-8859-1?Q?z0+TaJbi/MSRYqMU+EC557B0X5xfvhyVxW/kR/MSf63aK8R7a629kLoA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaf5cdf-0260-48fe-7ef4-08ddc445dd2a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 08:50:50.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idjhizdBSl42RNkpOMywxOyjkGH1A3e5DBBH7ZaWYU6BJ7EIRasyJOqU0P25dg9vt07EetGeD/UKmftMJKQ6rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8248
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 8.8% improvement of stress-ng.session.ops_per_sec on:


commit: ac215b990e70e247344522e1736fd878cb3c25b6 ("[PATCH v3 3/3] sched/fair: Allocate both cfs_rq and sched_entity with per-cpu")
url: https://github.com/intel-lab-lkp/linux/commits/Zecheng-Li/sched-fair-Co-locate-cfs_rq-and-sched_entity/20250702-050528
patch link: https://lore.kernel.org/all/20250701210230.2985885-4-zecheng@google.com/
patch subject: [PATCH v3 3/3] sched/fair: Allocate both cfs_rq and sched_entity with per-cpu

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: session
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250716/202507161052.ed3213f4-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp3/session/stress-ng/60s

commit: 
  10d69ea6ba ("sched/fair: Remove task_group->se pointer array")
  ac215b990e ("sched/fair: Allocate both cfs_rq and sched_entity with per-cpu")

10d69ea6ba7641d0 ac215b990e70e247344522e1736 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.00 ± 33%      -0.0        0.00        mpstat.cpu.all.iowait%
      4.46            -1.9        2.60        mpstat.cpu.all.soft%
    119077           -40.8%      70550        numa-vmstat.node0.nr_slab_unreclaimable
    108930 ±  2%     -47.0%      57734        numa-vmstat.node1.nr_slab_unreclaimable
    182080            +6.2%     193357        vmstat.system.cs
    523378            +2.8%     538219        vmstat.system.in
    492392 ±  2%     +13.0%     556325 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.min
    492392 ±  2%     +13.0%     556325 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
    138.58 ±  5%      -7.4%     128.29 ±  2%  sched_debug.cfs_rq:/.util_est.stddev
    472216           -40.6%     280726        numa-meminfo.node0.SUnreclaim
    574944 ±  4%     -37.1%     361520 ±  7%  numa-meminfo.node0.Slab
    432134 ±  2%     -46.3%     231873 ±  2%  numa-meminfo.node1.SUnreclaim
    479462 ±  5%     -37.2%     301105 ±  9%  numa-meminfo.node1.Slab
  10287656           -10.7%    9189229        meminfo.Memused
    135165          +249.4%     472245 ±  2%  meminfo.Percpu
    904298           -43.4%     512235        meminfo.SUnreclaim
   1054350           -37.2%     662242        meminfo.Slab
  10568312           -11.6%    9345843        meminfo.max_used_kB
   1207478            +8.7%    1312849        stress-ng.session.ops
     20155            +8.8%      21919        stress-ng.session.ops_per_sec
 1.019e+08 ±  2%      +6.9%   1.09e+08        stress-ng.time.minor_page_faults
     16524            +2.1%      16869        stress-ng.time.percent_of_cpu_this_job_got
      9893            +2.1%      10097        stress-ng.time.system_time
   4781984            +7.2%    5125238        stress-ng.time.voluntary_context_switches
    481639            +2.6%     494200        proc-vmstat.nr_active_anon
   1169838            +1.0%    1181222        proc-vmstat.nr_file_pages
     41310            +2.1%      42196        proc-vmstat.nr_kernel_stack
    279620            +4.1%     291007        proc-vmstat.nr_shmem
    226450           -43.4%     128195        proc-vmstat.nr_slab_unreclaimable
    481639            +2.6%     494200        proc-vmstat.nr_zone_active_anon
  89251914 ±  3%      +7.3%   95746015 ±  3%  proc-vmstat.numa_hit
  87248173 ±  3%      +7.5%   93770181 ±  3%  proc-vmstat.numa_local
 1.169e+08 ±  2%     -15.8%   98422922 ±  3%  proc-vmstat.pgalloc_normal
 1.024e+08 ±  2%      +6.9%  1.095e+08        proc-vmstat.pgfault
 1.161e+08 ±  2%     -16.0%   97515011 ±  3%  proc-vmstat.pgfree
      0.73            +0.0        0.76        perf-stat.i.branch-miss-rate%
 1.795e+08            +5.7%  1.897e+08        perf-stat.i.branch-misses
     39.65            -2.8       36.83        perf-stat.i.cache-miss-rate%
 1.485e+09            +7.2%  1.592e+09        perf-stat.i.cache-references
    188846            +7.1%     202265        perf-stat.i.context-switches
      4.35            -1.1%       4.30        perf-stat.i.cpi
     50615            +8.6%      54987        perf-stat.i.cpu-migrations
     18.17            +8.4%      19.69        perf-stat.i.metric.K/sec
   1682096 ±  2%      +6.7%    1795278        perf-stat.i.minor-faults
   1682116 ±  2%      +6.7%    1795306        perf-stat.i.page-faults
      0.71            +0.0        0.74        perf-stat.overall.branch-miss-rate%
     39.60            -2.9       36.74        perf-stat.overall.cache-miss-rate%
      4.38            -1.1%       4.33        perf-stat.overall.cpi
      0.23            +1.1%       0.23        perf-stat.overall.ipc
  1.75e+08            +5.6%  1.847e+08        perf-stat.ps.branch-misses
 1.454e+09            +6.9%  1.555e+09        perf-stat.ps.cache-references
    184886            +6.9%     197661        perf-stat.ps.context-switches
     49237            +8.5%      53411        perf-stat.ps.cpu-migrations
   1646954 ±  2%      +6.5%    1754401        perf-stat.ps.minor-faults
   1646973 ±  2%      +6.5%    1754428        perf-stat.ps.page-faults
      0.14 ± 12%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_node_noprof.alloc_fair_sched_group.sched_create_group.sched_autogroup_create_attach
      1.86 ± 55%     -95.6%       0.08 ± 56%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      0.07 ±115%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_noprof.alloc_fair_sched_group.sched_create_group.sched_autogroup_create_attach
      0.03 ± 30%     -89.1%       0.00 ± 30%  perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.02 ± 43%     -69.1%       0.01 ± 33%  perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      0.47 ±  8%     -16.7%       0.39 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.27 ± 47%     -69.6%       0.08 ± 97%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.26 ± 27%     -40.1%       0.15 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      0.27 ± 16%     -43.3%       0.15 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      0.23 ± 10%     -26.2%       0.17 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.03 ± 41%     -86.7%       0.00 ± 32%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.04 ± 69%     -93.6%       0.00 ± 62%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma_batch_process.unlink_file_vma_batch_add.free_pgtables
      0.56 ± 49%     -75.3%       0.14 ± 39%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
      0.25 ±  7%     -21.0%       0.19 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      0.43 ± 44%     -86.3%       0.06 ± 55%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.dup_mm
      0.01 ± 76%  +13586.7%       1.03 ± 72%  perf-sched.sch_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.09 ± 44%     -76.0%       0.02 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.39 ± 52%     -75.9%       0.10 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.09 ± 21%     -30.0%       0.06 ± 20%  perf-sched.sch_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.02 ±  4%     -47.3%       0.01        perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.20           -12.8%       0.17 ±  3%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.22 ± 26%     -52.3%       0.10 ± 29%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.02 ± 12%     -55.8%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      0.07 ± 10%     -24.5%       0.05 ± 14%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      0.07 ±  6%     -22.6%       0.05 ± 13%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_fork
      0.01 ± 20%     -57.3%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      0.10 ± 18%     -27.5%       0.07 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.44 ±  4%     -20.2%       0.35 ±  2%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      8.47 ± 85%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_node_noprof.alloc_fair_sched_group.sched_create_group.sched_autogroup_create_attach
     10.95 ± 57%     -95.9%       0.45 ± 59%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      0.34 ±160%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_noprof.alloc_fair_sched_group.sched_create_group.sched_autogroup_create_attach
     17.30 ± 16%     -86.0%       2.42 ± 65%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      8.99 ± 57%     -81.2%       1.69 ± 22%  perf-sched.sch_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
     36.94 ± 97%     -90.9%       3.35 ±  9%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.67 ± 47%     -75.4%       0.16 ±148%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
     26.40 ± 89%     -69.8%       7.96 ± 67%  perf-sched.sch_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
     36.26 ± 33%     -70.8%      10.58 ±109%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
     10.02 ± 42%     -86.2%       1.38 ±  6%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
     11.63 ± 51%     -92.3%       0.89 ± 39%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_file_vma_batch_process.unlink_file_vma_batch_add.free_pgtables
     13.19 ± 50%     -88.0%       1.58 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
      9.58 ± 68%     -91.3%       0.83 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.dup_mm
      0.01 ± 83%  +17570.0%       1.47 ± 76%  perf-sched.sch_delay.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
     13.57 ± 16%     -89.9%       1.37 ± 65%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     13.09 ± 35%     -80.8%       2.51 ± 59%  perf-sched.sch_delay.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     23.68 ± 15%     -82.9%       4.05 ± 33%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      3.16 ± 15%     +26.9%       4.01 ±  7%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      4.74 ±147%    +499.9%      28.44 ± 59%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pcpu_alloc_noprof
     22.00 ± 24%     -86.8%       2.90 ± 43%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
     19.90 ±  9%     -85.2%       2.95 ± 29%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
     26.25 ± 10%     -75.7%       6.37 ± 12%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     29.41 ± 22%     -78.6%       6.29 ± 19%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.13 ±  3%     -14.3%       0.11 ±  3%  perf-sched.total_sch_delay.average.ms
    554.44 ± 80%     -84.6%      85.42 ± 13%  perf-sched.total_sch_delay.max.ms
      2379 ± 19%     +49.8%       3565 ± 24%  perf-sched.total_wait_and_delay.max.ms
      2379 ± 19%     +49.8%       3564 ± 24%  perf-sched.total_wait_time.max.ms
      0.08 ± 30%     -87.6%       0.01 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      4.97 ±  2%      -8.4%       4.56        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      0.04 ±  4%     -46.9%       0.02 ±  3%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.10 ±  4%     -33.6%       0.06 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      0.08 ± 10%     -35.0%       0.05        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      5676 ±  2%     -10.9%       5057        perf-sched.wait_and_delay.count.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      5076           -11.4%       4498 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      1072 ± 15%     -57.1%     460.33 ± 13%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4236 ±  8%     +29.2%       5471 ± 10%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    102.00 ± 29%     +39.7%     142.50 ± 15%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      2.17 ±223%  +2.1e+05%       4619 ± 12%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.pcpu_alloc_noprof
     11630 ±  5%     -12.4%      10192 ±  7%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
     24971 ±  4%      -9.2%      22682 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
     22567 ±  2%      -9.3%      20475 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
     37.53 ± 12%     -84.8%       5.69 ± 48%  perf-sched.wait_and_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      7.92 ±223%    +839.2%      74.40 ± 30%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pcpu_alloc_noprof
     45.50 ± 23%     -86.0%       6.35 ± 35%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
     39.97 ±  9%     -83.3%       6.69 ± 22%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      4.05 ± 50%     -77.4%       0.92 ± 64%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_node_noprof.__get_vm_area_node.__vmalloc_node_range_noprof.__vmalloc_node_noprof
      0.01 ± 42%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_node_noprof.alloc_fair_sched_group.sched_create_group.sched_autogroup_create_attach
      0.05 ± 29%     -86.9%       0.01 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.04 ± 30%     -73.8%       0.01 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      0.05 ± 34%     -85.3%       0.01 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.07 ± 50%     -89.2%       0.01 ± 27%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma_batch_process.unlink_file_vma_batch_add.free_pgtables
      2.74 ± 49%     +78.9%       4.90 ± 24%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_dup_build.constprop.0
      1.52 ± 12%     +32.6%       2.02 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
      1.29 ±  9%     -21.5%       1.01 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
      3.12 ±  4%      +9.4%       3.41 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
      0.02 ±  4%     -48.1%       0.01 ±  4%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.55 ± 19%     -38.1%       0.34 ± 41%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.08 ±  4%     -28.8%       0.06 ±  4%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      0.06 ±  9%     -29.7%       0.04        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
     34.86 ± 44%     -80.5%       6.80 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_node_noprof.__get_vm_area_node.__vmalloc_node_range_noprof.__vmalloc_node_noprof
      3.98 ± 62%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_node_noprof.alloc_fair_sched_group.sched_create_group.sched_autogroup_create_attach
     23.75 ± 25%     -81.5%       4.40 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
     12.62 ± 54%     -83.7%       2.06 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
     12.65 ± 29%     -74.1%       3.27 ± 36%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
     14.23 ± 33%     -85.1%       2.12 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_file_vma_batch_process.unlink_file_vma_batch_add.free_pgtables
     26.52 ± 54%     -58.3%      11.06 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
     21.46 ± 31%     -79.3%       4.44 ± 50%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
     36.27 ± 38%     -61.4%      14.00 ± 27%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
     43.85 ± 20%     -52.4%      20.88 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mm.constprop.0
      1.21 ± 30%     -65.9%       0.41 ± 86%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.ret_from_fork.ret_from_fork_asm.[unknown]
      3.06 ± 38%    +816.6%      28.04 ± 89%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     11.39 ± 63%    +393.7%      56.25 ± 18%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pcpu_alloc_noprof
     26.67 ± 14%     -83.3%       4.45 ± 13%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
     24.94 ± 26%     -82.1%       4.48 ±  5%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


