Return-Path: <linux-kernel+bounces-797964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D9B417BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D697C39A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015C2EB5B2;
	Wed,  3 Sep 2025 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9pSm0fM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459952DFA24
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886539; cv=fail; b=k+EyhhfsRi/nyXqHoBvgnEOasoihRePejh96Tpqim7RomCZXWh+ivJ5BsthsgD0Ohhh4pmV/dyMBH54vT/HshCUSj/iPt7eSpCjVJrtpQEORPBi3hLv/bq34s5PYXtHqnA4y9K7gV5V0XcBvvscapz0kromidBxna9mRG264MM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886539; c=relaxed/simple;
	bh=9B1ddp+anePZwqtW3NW3e2ySfKhUVI90VrqRxQudl0Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d/jzMLaETW/wPk1fzvUV+OQLfH3Te2nNuvC9mZlCoqviXzYqL+0s1mzKZrNp9pce3Ps220fuCkqZ77j8xtwqxsbwFwjsJ4rqF/8tk9QMefw6JUw0jL/wwVQ9BFGdnofMkkYb7/V3KjUpuY5Tf288iVLjUYpjUnbUtfvvaF6u5uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9pSm0fM; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756886537; x=1788422537;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9B1ddp+anePZwqtW3NW3e2ySfKhUVI90VrqRxQudl0Q=;
  b=m9pSm0fMhfftppjznm+fsCr3PIs2XMSA8TYJd6t7j//06nLokOOJc+rW
   1qtWqKHjhBOoaVX15g3Rj5oZS1gzKaamcPOdy78CzNTrHqNmqZ0BCzAF3
   ijqoU4KID+8FqtwMICRyw3DFtQpYPLzS4Gdtmt4hvvpwaH4pRLj1GOn78
   LteWp74G1fdt27B8O9btL3m2AZ70xKr/i/ljkxcBLqNwXP1t1BfAGYzt1
   LyllgpJzchooB2WyUHRn0blUbuRtc+d++VzfUujWOPhTw+/6VRVdHO0jy
   sp9YDYieEt1qTEoxq7nUX6Bg2DPtEIJTfENa+BoJZFWAtoMglwVEZcyfb
   w==;
X-CSE-ConnectionGUID: /fOI7/+JR6eicIf1DOgkmg==
X-CSE-MsgGUID: qavpGpo3TuO0vzHgGepfAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58407356"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58407356"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:02:17 -0700
X-CSE-ConnectionGUID: 4XdahBm8QFKsCG2AWzwQOg==
X-CSE-MsgGUID: lvzT5hqUQRe5oM6w6jW4Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="175888655"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:02:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 01:02:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 01:02:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 01:02:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChLMuzWr0Bk3ZxNc6zL20dADp3QRL3sd6+Px6woLBj73J/2XAPh3qTAbXYy0Xw+W8gMNdq6sVHf3mbd7aYff4JSGL2k65PBAAJh+wwucXu80BB6TvX/ZG/E0y9bnlTM7ztV8KDbjcYncw29rMey1wDiEIWxJoQTX8GhsSeDXbEmQw2ZnlthJwsaFYrdldzJ+gA3bmUtHzycezNzA69MFGncMth4SDHwAVLvjey1FQwyvD0rRADsphz4VEeJqnofli3aG51VLV2dd0Of6C+ul6F1E5PlchJfX7B6ieMQeqtmYn+UOZh7gE1qfrhT54KMM+JxJN3XdV1aL+pqjPag/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5hWlatILVKcln97GyXEOXRlq4ofCO4iTLpAYmh84uI=;
 b=zLm1hgcdEr32O8EqwNSRKpxwICo1pUj5YOQpRW5D7pfooskpBIhTYs76UVkrzPOmUNvNT/kxF5pAidyB8zgvOqBeAhgRqTxFbjQsd9NU197DR38noaQIc53u9zLRT6uSpFH9ik/AsvEkG56jykMlNpPImBgCxkYcx81ToCyUg6r97dfRJLj2ArTpyYSpRvRL9Q0Psa/7fPYnfewMDzdQM0iq0imGVtUGC2eEAyVFpQK5dZQi5iXQ8rvVaf+I0+7a6/G2qwtsE4f60jT3UD/an6f0wHcahVhLrnrWf2RLiCpO9AxQngg6XSZjiIRYSrZS7ZfVPYnEwFVoLV0uyyk7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7826.namprd11.prod.outlook.com (2603:10b6:930:76::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 08:02:08 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 08:02:08 +0000
Date: Wed, 3 Sep 2025 16:01:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Adam Li <adamli@os.amperecomputing.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <vschneid@redhat.com>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <cl@linux.com>, <patches@amperecomputing.com>, Adam Li
	<adamli@os.amperecomputing.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH RESEND 2/2] tick/nohz: Trigger warning when CPU in wrong
 NOHZ idle state
Message-ID: <202509031529.464ff656-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250821042707.62993-3-adamli@os.amperecomputing.com>
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 86246050-fb1c-43be-38f5-08ddeac02e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1G8DkTz8uvWxaSiEXkZhpCX+BFVDUdyGq0DyUvYrFHAmjE+aK4EPgtLjaHgO?=
 =?us-ascii?Q?hImCE/lrLB9UYhxLVIzATXxIAkXaLnZ93XhIHNXYiLDVstP45Ug5BQ8cUfg9?=
 =?us-ascii?Q?dzap1RG+GufrjxxM0Zkai9/lSgmVACINJ9/DsfwZLoEsftvMpFDp7KCp9VGt?=
 =?us-ascii?Q?H+o/u+kqsfBGb4MIHs2tX4t1Gn4zDqlgEZZLCzl0aeVZBzw1TNU5vyBjEGeQ?=
 =?us-ascii?Q?vTW9cZwASyvdzsNEaBszVq9osiChFq/1XxnKD/8gMMZ8p+qbc2vhPrF53fKW?=
 =?us-ascii?Q?rHyrzwu3BtMOTzD34I0vaoIVASPqx7NZPxM+87jiJ1EiQ8OUp4Amjifdhfje?=
 =?us-ascii?Q?+49LUVYSYsP2iL0yBgle9CUWKzjAcvSa8NxyPdcByHaQYYvIpDsES02io6j8?=
 =?us-ascii?Q?I91zn2JUBC+J0a9nX9Y0x5YAv9bxc6uZprkubowkhPA36y4+QG9dqFy5xS0X?=
 =?us-ascii?Q?4PMCWCO7yOhBOF4nFXQz5+JqEUt5A+q4kpqw6glvlT7p1FpCopEKJCzRu9VH?=
 =?us-ascii?Q?kq7g6o9jbZU0F2oB5D7i2+n9zGo8lXqLy1twYE0CIG6brjmpnF/7YXnChuON?=
 =?us-ascii?Q?xhzjljd4WuoRvYL1kF4ULg6NjLDXdq+THhPDPKSQGPjuTgXKlYF3c8ba2HWL?=
 =?us-ascii?Q?IUUer+ogdqX1Yj3DNl9S0fNH+FrVFjB7VrES8yFsAna9TZ+UnbsQJdNqZSh9?=
 =?us-ascii?Q?mf9cspDMh/j4n8Sn0W9YsUniq/GaxmX+uBXWhsTEZeaSNqeCbB1jsJa8wlOG?=
 =?us-ascii?Q?N8YjDIbOG5ci0BagDyznfEutA9HW+eF6XowmVMPqa+fs6MHpd67lVhokX4bi?=
 =?us-ascii?Q?ZKul0LkVHkhviC616vwG2VSLMYBtWv3BhsbVZVqRM78jBTztgu5Ux2HszunT?=
 =?us-ascii?Q?LT3YG9ODNiqyB/pDKdjrMg0aGhhEK2ehZj78PZFPeiB+XVw+ff+pknRSk13M?=
 =?us-ascii?Q?DUQtIT8Xzq01YHiZnwrVF8f9yYzFUeaz2IqFcMCfDYmAguHniL1cEFfnt9rG?=
 =?us-ascii?Q?muK1n82t0ofhj9cQdoCPA0fEJJE4hsUJBrc78mWrSFpSLPca6SXU+y9pcQ3C?=
 =?us-ascii?Q?jchcgTEi/OVo+1pnZpnXeK9hQU9Sr6D+5d/sLu/vN8v8nMVkksRD/TUZnYeP?=
 =?us-ascii?Q?HlXEqx5OVTORNTnIErLmtQY9Fps6OSPoa+//gxLf6FzkDSdZy5t80hFdpWtL?=
 =?us-ascii?Q?xz3AzYt7AgSomlVq9eXdSJebcJu/irH0GhKyx/ejDg3Y2e/ZH8QJziotS6ov?=
 =?us-ascii?Q?XCQBOIyQ5JSjiHU1UZ6mDpgEJ9BN3sakRTpDkUjVrhelpHnvKwfPLx3utOkU?=
 =?us-ascii?Q?gOdYkWoFUML7kGCdxOd/bKHunvejDcAWdbjSS3ypKpwfMOT2i3IsxBvEpko7?=
 =?us-ascii?Q?4HfERnLd7YwbY+TxgRMSjatsGWRz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vi+aI4fKrEzCkatDl1C3D/Gu/elxGGSnvzN1LqZV05JAYRyrH0hy9KsXxxrv?=
 =?us-ascii?Q?Uj+1+6AsDItqrJ2SEFlSClrHM3Y1muLnnpA1eSlCxhaHSOGbshtz4C5shb28?=
 =?us-ascii?Q?KoGLsPcWyhsKqtppyEfgBFGElHV2yYKoq+rQCz0VWsk4ATexEf1jb4iCJ71g?=
 =?us-ascii?Q?3Pi+s7ylKLgOOMDfpNQ0iKXmIV13zQKlh25A0zigRBVNQi36E1Z78enlB8iW?=
 =?us-ascii?Q?iCXg/hlVKkstwfisky+BJfZIGBJrEcd0qK6YdOxWXaPEnQ+Pv2p6IF1DzKcD?=
 =?us-ascii?Q?NbPyz158qr0QJP8iSugwlCJjG+O9VjE6kNUgQ3GhvMSvT8jRiD9idR6GvJtl?=
 =?us-ascii?Q?+UeDSTtzVvPq6j/oSrhhwyyAULPZTTjno4iGCC2FR2hVo2RdO33J9sM4I0W+?=
 =?us-ascii?Q?movmrOKF/DUuKKjsTnPp024nPN73+2iZmyoJ+MQM6hsFgkko4oeCnJrzjD5f?=
 =?us-ascii?Q?IolQy4QjFNPzRCFA/2cMsT+SE4+c3yV/I+aqT9YtYaKvB50Rg8PYFryVqvaX?=
 =?us-ascii?Q?AqTvWhHcVhs0jpzXH4crIDFoxCd+Pw6pNHgKaUingwQDFbaNik8H1bQLqcCT?=
 =?us-ascii?Q?ujwOZEM00apfOK2WUHGDjsWGq567mVojT3Xq2FLOotWcjH8gWx/ft979gfOZ?=
 =?us-ascii?Q?mC4xyPUT82LEEULKZszwM9uQXL0XPu+n1FUEEXsdsiqEOO2NukwDkiCmjZfg?=
 =?us-ascii?Q?3BJqLLDE9T8gF5BgJRpk+Fx2aK23tljxdRXM5bgG6969WZ8idU+sjQ3JSGjh?=
 =?us-ascii?Q?OTkP6NEMLrwPqK+lsCN9lYsL0dBQI0LyGn3Bdk52J9VquZe9ywp3+a1VZz8C?=
 =?us-ascii?Q?HluebaDGLcHS0QueZyVA4oyQSATB3GAtaqxfm85E8aQkjq0h114+3+Au96Wc?=
 =?us-ascii?Q?kLqFQrrxoY1QkUsa55U6qnsxrbrBbjamsxvggl3NABEk9GP9mdPpaCIkyh3D?=
 =?us-ascii?Q?uXdUI9nnG8j1tg0qq4oc3qaLYBB10NCS3yLm6fQLs3sNELLH8bD6ahXcP1aH?=
 =?us-ascii?Q?S8MkXYQ8Nx8ImoRjJvyMdQMZLuQdwJ3rC0aYTX5/5sZZMgm4FIo7jMbBtK4s?=
 =?us-ascii?Q?00+nkPJ/V23KLDIZzG8nJfpdQHEh9p8+oKrIkrHRaQaWTfyZLcp8JqC2mBdF?=
 =?us-ascii?Q?PpSK+bx04A4oqVpoE40uOs4R6Z25UxPwRa7Uk+B8TfQU/ryCj4JMbNDEeV7D?=
 =?us-ascii?Q?P2D2w6ehm6kIfAw2U+kCeEpRNg9L3LZKzZRZZScSSMeppXEDAcDP9UcDJEoe?=
 =?us-ascii?Q?VRDG+db/KLeEUe6qcBA5PusDzIfXBR5+wDxLCUwKoGuNEJTOpuc85PVbLfiG?=
 =?us-ascii?Q?Ammq7PuB6WwGlZLTYyqC3TJ/hk5SF8wfw6HGX3XF3roqZZ7XJLZ8z4Mn7Cnf?=
 =?us-ascii?Q?mw29yxIuNhtLuLZLqO6lPIQr2FffUGMehV6aFCyoVp5Eq/13giSvZfPmzGDF?=
 =?us-ascii?Q?8yCOfuTcYHIFeVAnPrNYpHfKSStxjn1v4IkAn88IC3gRs5rFlMKcdIRH4mTz?=
 =?us-ascii?Q?LGpt2ldDQgfTAxtkKweUrDc5jILK5OKLaTkqfVa5est/akgSAwdIi3RdeWlC?=
 =?us-ascii?Q?+skgmnDPetBI93kHect/xmAhNrZDL39EZJbu7JWDGvQnvRo6ybYfId2suDdH?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86246050-fb1c-43be-38f5-08ddeac02e03
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:02:08.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHoiaJyjE3pxqpISLkAdpVf2Ya6jzNCSjikJhswZdty82oDV97GL1THkuYl1Cf4MKpSFVu7O9Ast8mGr6/YufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7826
X-OriginatorOrg: intel.com



Hello,


we are not sure the purpose of this debug patch so not sure if below report
could supply any useful information. just report FYI. if low value, please
just kindly ignore. thanks


kernel test robot noticed "WARNING:at_kernel/time/tick-sched.c:#tick_nohz_i=
dle_stop_tick" on:

commit: d112a298a9368568686e1a399cc5073a02f60c2f ("[PATCH RESEND 2/2] tick/=
nohz: Trigger warning when CPU in wrong NOHZ idle state")
url: https://github.com/intel-lab-lkp/linux/commits/Adam-Li/tick-nohz-Fix-w=
rong-NOHZ-idle-CPU-state/20250821-122906
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 1b5f1454091e=
9e9fb5c944b3161acf4ec0894d0d
patch link: https://lore.kernel.org/all/20250821042707.62993-3-adamli@os.am=
perecomputing.com/
patch subject: [PATCH RESEND 2/2] tick/nohz: Trigger warning when CPU in wr=
ong NOHZ idle state

in testcase: cpu-hotplug
version:=20
with following parameters:


config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (=
Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509031529.464ff656-lkp@intel.co=
m


[   96.913433][    T0] ------------[ cut here ]------------
[   43.020727][  T307]
[   87.665815][    T0] Masked ExtINT on CPU#3
[   43.030461][  T307] (Reading database ... 16595 files and directories cu=
rrently installed.)
[   89.314224][  T252] smpboot: CPU 1 is now offline
[ 96.918719][ T0] WARNING: CPU: 0 PID: 0 at kernel/time/tick-sched.c:1231 t=
ick_nohz_idle_stop_tick (kernel/time/tick-sched.c:1231)=20
[   43.030468][  T307]
[   87.817541][  T649] smpboot: Booting Node 0 Processor 4 APIC 0x1
[   43.042435][  T307] Preparing to unpack .../ntpdate_1%3a4.2.8p15+dfsg-2~=
1.2.2+dfsg1-1+deb12u1_all.deb ...
[   90.352309][  T252] smpboot: CPU 2 is now offline
[   43.042441][  T307]
[   96.928830][    T0] Modules linked in: snd_hda_codec_hdmi snd_ctl_led sn=
d_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component btrfs in=
tel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequenc=
y_common blake2b_generic xor zstd_compress snd_soc_avs x86_pkg_temp_thermal=
 snd_soc_hda_codec snd_hda_ext_core intel_powerclamp raid6_pq snd_soc_core =
coretemp snd_compress i915 sd_mod snd_hda_intel sg snd_intel_dspcfg kvm_int=
el intel_gtt ipmi_devintf snd_intel_sdw_acpi ipmi_msghandler cec snd_hda_co=
dec drm_buddy kvm snd_hda_core ttm mei_wdt irqbypass snd_hwdep i2c_designwa=
re_platform ghash_clmulni_intel snd_pcm dell_wmi platform_profile ahci rapl=
 drm_display_helper i2c_designware_core mei_me dcdbas libahci dell_wmi_aio =
snd_timer dell_smbios intel_cstate drm_client_lib dell_smm_hwmon wmi_bmof d=
ell_wmi_descriptor sparse_keymap intel_lpss_pci snd drm_kms_helper i2c_i801=
 intel_lpss libata pcspkr intel_uncore mei idma64 soundcore i2c_smbus video=
 intel_pmc_core pmt_telemetry pmt_class wmi pinctrl_sunrisepoint
[   87.823787][    T0] Masked ExtINT on CPU#4
[   43.055242][  T307] Unpacking ntpdate (1:4.2.8p15+dfsg-2~1.2.2+dfsg1-1+d=
eb12u1) ...
[   91.391058][  T252] smpboot: CPU 3 is now offline
[   96.928957][    T0]  intel_pmc_ssram_telemetry intel_vsec acpi_pad binfm=
t_misc drm fuse loop dm_mod ip_tables
[   43.055248][  T307]
[   87.976451][  T649] smpboot: Booting Node 0 Processor 5 APIC 0x3
[   43.065976][  T307] Selecting previously unselected package ntpsec-ntpda=
te.
[   92.424836][  T252] smpboot: CPU 4 is now offline
[   97.028568][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G     =
     I         6.16.0-rc6-00089-gd112a298a936 #1 PREEMPT(voluntary)
[   43.065982][  T307]
[   87.982768][    T0] Masked ExtINT on CPU#5
[   43.076378][  T307] Preparing to unpack .../ntpsec-ntpdate_1.2.2+dfsg1-1=
+deb12u1_amd64.deb ...
[   97.041089][    T0] Tainted: [I]=3DFIRMWARE_WORKAROUND
[   93.454857][  T252] smpboot: CPU 5 is now offline
[   43.076384][  T307]
[   88.118542][  T649] smpboot: Booting Node 0 Processor 6 APIC 0x5
[   43.087987][  T307] Unpacking ntpsec-ntpdate (1.2.2+dfsg1-1+deb12u1) ...
[   94.507924][  T252] smpboot: CPU 6 is now offline
[   97.046019][    T0] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS =
1.2.0 12/22/2016
[   43.087993][  T307]
[   88.124813][    T0] Masked ExtINT on CPU#6
[   43.097723][  T307] Selecting previously unselected package python3-ntp.
[   95.537790][  T252] smpboot: CPU 7 is now offline
[ 97.054053][ T0] RIP: 0010:tick_nohz_idle_stop_tick (kernel/time/tick-sche=
d.c:1231)=20
[   43.097729][  T307]
[   88.268535][  T649] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   43.107761][  T307] Preparing to unpack .../python3-ntp_1.2.2+dfsg1-1+de=
b12u1_amd64.deb ...
[ 97.060194][ T0] Code: e0 5d f6 84 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 =
48 c1 ea 03 80 3c 02 00 0f 85 b7 00 00 00 41 f6 04 24 02 0f 84 63 ff ff ff =
<0f> 0b e9 5c ff ff ff 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	e0 5d                	loopne 0x5f
   2:	f6 84 48 b8 00 00 00 	testb  $0x0,0xb8(%rax,%rcx,2)
   9:	00=20
   a:	00 fc                	add    %bh,%ah
   c:	ff                   	(bad)
   d:	df 4c 89 e2          	fisttps -0x1e(%rcx,%rcx,4)
  11:	48 c1 ea 03          	shr    $0x3,%rdx
  15:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  19:	0f 85 b7 00 00 00    	jne    0xd6
  1f:	41 f6 04 24 02       	testb  $0x2,(%r12)
  24:	0f 84 63 ff ff ff    	je     0xffffffffffffff8d
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 5c ff ff ff       	jmp    0xffffffffffffff8d
  31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  38:	fc ff df=20
  3b:	48 89 da             	mov    %rbx,%rdx
  3e:	48                   	rex.W
  3f:	c1                   	.byte 0xc1

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	e9 5c ff ff ff       	jmp    0xffffffffffffff63
   7:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   e:	fc ff df=20
  11:	48 89 da             	mov    %rbx,%rdx
  14:	48                   	rex.W
  15:	c1                   	.byte 0xc1
[   95.560557][  T649] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   43.107767][  T307]
[   88.274805][    T0] Masked ExtINT on CPU#7
[   43.119061][  T307] Unpacking python3-ntp (1.2.2+dfsg1-1+deb12u1) ...
[   95.566801][    T0] Masked ExtINT on CPU#1
[   97.079531][    T0] RSP: 0018:ffffffff85207df0 EFLAGS: 00010002
[   43.119067][  T307]
[   89.314224][  T252] smpboot: CPU 1 is now offline
[   43.128509][  T307] Setting up python3-ntp (1.2.2+dfsg1-1+deb12u1) ...
[   95.591432][  T649] smpboot: Booting Node 0 Processor 2 APIC 0x4
[   97.085419][    T0] RAX: dffffc0000000000 RBX: ffff888796430c40 RCX: 000=
0000000000000
[   43.128515][  T307]
[   90.352309][  T252] smpboot: CPU 2 is now offline
[   43.138294][  T307] Setting up ntpdate (1:4.2.8p15+dfsg-2~1.2.2+dfsg1-1+=
deb12u1) ...
[   95.597695][    T0] Masked ExtINT on CPU#2
[   97.093208][    T0] RDX: 1ffff110f2c86188 RSI: 0000000000000008 RDI: fff=
fffff84f65de0
[   43.138300][  T307]
[   91.391058][  T252] smpboot: CPU 3 is now offline
[   43.149075][  T307] Setting up ntpsec-ntpdate (1.2.2+dfsg1-1+deb12u1) ..=
.
[   95.625417][  T649] smpboot: Booting Node 0 Processor 3 APIC 0x6
[   97.100997][    T0] RBP: ffff88880f074000 R08: 0000000000000000 R09: fff=
fed10219177b8
[   43.149081][  T307]
[   92.424836][  T252] smpboot: CPU 4 is now offline
[   43.158251][  T307] NO_NETWORK=3D
[   97.108775][    T0] R10: ffff88810c8bbdc7 R11: ffff888796430c70 R12: fff=
f888796430c40
[   95.631679][    T0] Masked ExtINT on CPU#3
[   43.158257][  T307]
[   93.454857][  T252] smpboot: CPU 5 is now offline
[   43.164205][  T307] CLOCK: time stepped by 32064468.825994
[   95.675523][  T649] smpboot: Booting Node 0 Processor 4 APIC 0x1
[   97.116551][    T0] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
000081dff1000
[   43.164212][  T307]
[   94.507924][  T252] smpboot: CPU 6 is now offline
[   43.172683][  T307] CLOCK: time changed from 2024-08-25 to 2025-08-31
[   97.124328][    T0] FS:  0000000000000000(0000) GS:ffff88880f074000(0000=
) knlGS:0000000000000000
[   95.681842][    T0] Masked ExtINT on CPU#4
[   43.172690][  T307]
[   95.537790][  T252] smpboot: CPU 7 is now offline
[   43.183164][  T307] 2025-08-31 20:23:30.162487 (+0000) +32064468.825994 =
+/- 0.000310 internal-lkp-server 192.168.1.200 s5 no-leap
[   95.721433][  T649] smpboot: Booting Node 0 Processor 5 APIC 0x3
[   97.133051][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.183170][  T307]
[   95.560557][  T649] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   43.221647][   T10] smpboot: CPU 6 is now offline
[   97.139448][    T0] CR2: 00007fe2bc1c1e90 CR3: 000000081aa72006 CR4: 000=
00000003726f0
[   95.727679][    T0] Masked ExtINT on CPU#5
[   44.252774][   T10] smpboot: CPU 7 is now offline
[   95.566801][    T0] Masked ExtINT on CPU#1
[   44.289262][  T649] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   97.147225][    T0] Call Trace:
[   95.761430][  T649] smpboot: Booting Node 0 Processor 6 APIC 0x5
[   44.301168][    T0] Masked ExtINT on CPU#1
[   95.591432][  T649] smpboot: Booting Node 0 Processor 2 APIC 0x4
[   44.323288][  T649] smpboot: Booting Node 0 Processor 2 APIC 0x4
[   97.150345][    T0]  <TASK>
[   44.329546][    T0] Masked ExtINT on CPU#2
[   95.767675][    T0] Masked ExtINT on CPU#6
[   95.597695][    T0] Masked ExtINT on CPU#2
[   44.357295][  T649] smpboot: Booting Node 0 Processor 3 APIC 0x6
[ 97.153121][ T0] cpuidle_idle_call (arch/x86/include/asm/current.h:25 incl=
ude/linux/sched/idle.h:33 include/linux/sched/idle.h:67 kernel/sched/idle.c=
:149 kernel/sched/idle.c:235)=20
[   95.808544][  T649] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   44.363568][    T0] Masked ExtINT on CPU#3
[   95.625417][  T649] smpboot: Booting Node 0 Processor 3 APIC 0x6
[   44.402300][  T649] smpboot: Booting Node 0 Processor 4 APIC 0x1
[ 97.157882][ T0] ? __pfx_cpuidle_idle_call (kernel/sched/idle.c:173)=20
[   95.814793][    T0] Masked ExtINT on CPU#7
[   44.408556][    T0] Masked ExtINT on CPU#4
[   95.631679][    T0] Masked ExtINT on CPU#3
[   44.445282][  T649] smpboot: Booting Node 0 Processor 5 APIC 0x3
[ 97.163158][ T0] ? tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync.c:60)=20
[   95.965121][  T252] smpboot: CPU 1 is now offline
[   44.451534][    T0] Masked ExtINT on CPU#5
[   95.675523][  T649] smpboot: Booting Node 0 Processor 4 APIC 0x1
[   44.491303][  T649] smpboot: Booting Node 0 Processor 6 APIC 0x5
[ 97.168350][ T0] do_idle (kernel/sched/idle.c:330)=20
[   96.109316][  T252] smpboot: CPU 2 is now offline
[   44.497553][    T0] Masked ExtINT on CPU#6
[   95.681842][    T0] Masked ExtINT on CPU#4
[   44.536391][  T649] smpboot: Booting Node 0 Processor 7 APIC 0x7
[ 97.172160][ T0] cpu_startup_entry (kernel/sched/idle.c:427 (discriminator=
 1))=20
[   96.244243][  T252] smpboot: CPU 3 is now offline
[   44.542639][    T0] Masked ExtINT on CPU#7
[   95.721433][  T649] smpboot: Booting Node 0 Processor 5 APIC 0x3
[   44.699078][   T10] smpboot: CPU 1 is now offline
[ 97.176746][ T0] rest_init (init/main.c:718)=20
[   96.397668][  T252] smpboot: CPU 4 is now offline


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250903/202509031529.464ff656-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


