Return-Path: <linux-kernel+bounces-862176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E53BF499C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F5D18C1E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838DB1FDE31;
	Tue, 21 Oct 2025 04:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eG3nMGpV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E6BE5E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761022058; cv=fail; b=aN2SUNAKw9SAq5E1Wb1UJ5B4JKbiYAKrEvdtNN7fa0ERwoNTfl4kL6n9+Wnn5+iREeKnJq36UH2cw1SeSLhmuqZKf5I1HI901a2BYvSF7xPd6oFVbfMe3tzMQYVZTPIBpPH5sYpsmT/jxMSc8HgooxAjrhhO10bIUUnmxSavtBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761022058; c=relaxed/simple;
	bh=/XOcNk4eLTJsTKBWl/0OwoQsFytJTOOx80YvWcpPwxY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OEj7tIaXYzFitDC35MgatgAsTNttPv1Lv8u5BEEV/cMrsmNxhwDFVKfgwIB6qzPLVYZlm11BUCxwFM3BTI2Xp35WIC10JaoF6OYmUHPrrNtHj3hKRL3BRuiXwrUENEF0pES3/oYzOHRnYFfMaADirKQvAyrNyM5kTGKzPFLDKoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eG3nMGpV; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761022056; x=1792558056;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=/XOcNk4eLTJsTKBWl/0OwoQsFytJTOOx80YvWcpPwxY=;
  b=eG3nMGpVopLNiL+FF1uwKdOWRAv6yCLEQgCGX9rq9d/4D1D/qeSBdGUe
   ql6zoJKoPQymVUv8hpfyoF6weBzygWh7gMCVlbvTYiPihWTF3u4XN2BCc
   6HF5UmUcDDJQ8JiOhsxjrT/n24uLWphIzgVva1JVfFZG7e1qPoSxueM3K
   ATU9LhboOHIcMt2TtiDxadf+zuyelxImzDaRxjK3FxR+Fz9Xsky2IObdN
   5w9a1Uj3LTXODvM7vILJWDio4BhsmTVyLv3ChVZGzhO7CvdS76vQC0v7T
   QOkXR8hRGyfLJSVKNRnA5r5YZ/28bDFX2ldwC4fLRein6Q88I9DJhjmBz
   A==;
X-CSE-ConnectionGUID: XxKlNRDqQ+uOlJV4dXWLLw==
X-CSE-MsgGUID: DWIjKvT/QPSnxuq57T7UcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74580990"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="74580990"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 21:47:36 -0700
X-CSE-ConnectionGUID: YWURcz4rQ3C9sIJSZ/15JA==
X-CSE-MsgGUID: GfGk0KYkSOShpfqFiygUaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="214128374"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 21:47:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 21:47:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 21:47:35 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 21:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dndGqWRmLYod7NTVEzlGN/mSZ8Zzbq2mX4W++QCk8D6tnr6SleX/H9y4pD1SXzxL2w1tQ44qOw4FKY5Wu/Ml9s1ogJyNh9C3P8t4hym9cSUGHYZ6pBeV2cwPojLLcGOw6o63S8I74dDSAZYsyznZQ4LDUcA6fFE2mI2fKky7DhSp8f0amVsWA59jdzFNxZWnarGPX8996qYNn4Km5+7oWf3yTT89lT82wPXW7d0cSTWJRVCIgf3o6ySbiJNimWaoVOeBjylOCpFS1jo2g5l9UUhnavN5Bqf0fgHwHeAiaMNm5+SHEHzwgNWcGXVtnD5C9Pa+ddXTPDZnCBaCo4L1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNyzq7PqhH7R58SbF12FTHK0CXN9OZDRVQt0AoRmoVg=;
 b=tp8VMuycPN3xX6FusWo+/iagxOL/TQr2qev7Hvmhl4LTToBjz0NGgtk5Tu03aAlQY6jm4Gaog4gUEhYjqKLvUAP3Q2z0iYW/IbnnlRPlpZ5G5TJv1DGDCQaeuYG5j/9xfDTv7NeQA2c0hbUqPvpKHSLbFW9gfxe9OeDY5fAsUu+WVJmvFCJ2380w104UxtLkdvvMQiVMgIFRYVCWsW00Oz8Eug398JhpXY93SaO7D6GPzAQyPL3wI14iR6GGWa9/F/7aiw04eCNzQr5Vjip4mF3VMt5mBZOs/ra1qLriKqlKsChQvCZU8XQAiH7z60MIRd+uY84C78jZeNPSElFTtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 04:47:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 04:47:27 +0000
Date: Tue, 21 Oct 2025 12:47:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: XueBing Chen <chenxb_99091@126.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, XueBing Chen <chenxb_99091@126.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] lib/bsearch: add mutex protection for thread-safe binary
 search
Message-ID: <202510211047.d2cd27e5-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251016090640.6331-1-chenxb_99091@126.com>
X-ClientProxiedBy: KUZPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:d10:2a::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb5008e-3b46-46cc-888d-08de105cef64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X5sjVDzx73+SDJCEcPgbLIxsXJv/XncrtZ5zOOAjmak5qvI+8gSLiJ8L0Tld?=
 =?us-ascii?Q?x88a7+ewX8/lMVLY6SbvOEp+IA8TXrgg3f/MANJjSSs7oQKrsZmFPKjDOcEn?=
 =?us-ascii?Q?88nVuq/apw464DlSMB6UbzBD5bXVie9l8s9aBy5Z+R8EXoWNBD6iRzjqHlvl?=
 =?us-ascii?Q?SoUtpItrhM9EVvbe/5HV1ruxwJ1u1plNgE5OpMQTmYw5hOnxFFiSRlRJ/jU1?=
 =?us-ascii?Q?NkigmKb41+oMuAc6XinwIK/RGzLmTamI1J5V8S+ICupPHx+qim9vX3J8hKgt?=
 =?us-ascii?Q?0E6iZBCm8ezJX1Vqu+Btq8jTMQI8HPbsML4hGgZEESzkDaR4B+DA9Aviuisf?=
 =?us-ascii?Q?i0bpKP42Jd+AAExDw2XUwV1r0NWCTjojQOtEa7cGC1XpExXZwGAuo9bqHuqo?=
 =?us-ascii?Q?Zj+AN/lUJo1v42RxBRmfmUyUqYPgW5jXUUTHQ5k/zjpxgws5jAo7Ow19JRGo?=
 =?us-ascii?Q?jO2KbXI3BuRMD1nZMCfDyBQ9NrJhoq1EZq3gKTyWX+dpQlpx68dBZgpqWoyx?=
 =?us-ascii?Q?Z0q/U41q6Q5mCJYx8AIHkNgnXM8FmImi5CnkzSkG4xtgv9/OT0aIt5d62jBy?=
 =?us-ascii?Q?NW0oMdzq3tWTc3W0sVA1PYckk7sogHZL/uVcRrSXjSpaDBWWo1h7Y6vp2Ng/?=
 =?us-ascii?Q?iM1KLzmT9eFggDgGcEFaHHHQhGsMDmnaKdY0VrnkpZJm9s9Dmfuuosx+v0nG?=
 =?us-ascii?Q?CYbxCIlR0wOppruUkbvv7pQHBKDGynq9ONtNLC7/1QOwgzafe7aVlOxzppRi?=
 =?us-ascii?Q?z+bC8LUsnCe5oknyzqEqOSn0dC5/ibueSknUvITZF2liOD44VkyDEgNXNteC?=
 =?us-ascii?Q?5SMBFre8zeA9rnfhVCevGMIJ0/G58dM+w+epPJ/h9756Fpe8Sq+zFIGsexJu?=
 =?us-ascii?Q?Qbu8JYeLv1+Etr2gOK/H+LAdDgbYjOFPKpWXPlK6VuAQfnGuTlFrF/e6qm7a?=
 =?us-ascii?Q?0uDZ2x8mB1J4K1P0IKchwOUEONxjDoyyhL/2WVo/bW6yCeogdu6pnXtSHU/B?=
 =?us-ascii?Q?odusrEku8VNoYuhjUJGDBdRWgdDJfLif6MlenrSnuDm2IKNe74uZg+YkCW3U?=
 =?us-ascii?Q?Sni2c9P5D6OLO7FS4EexqQwE5OSEheDHT8J/mnISifS/L0hyQTMyBCZMsnig?=
 =?us-ascii?Q?Txp9+LLn5ynEgog+EcTECKvAaVI9e76trwdeHMjZoXEfwLnn+CU01ZOFxWfx?=
 =?us-ascii?Q?HIwkWujD0CTaohrx84TQdt0x08jbPBkF+JLwqmQGapkU5FzfIe96wtm6JCWR?=
 =?us-ascii?Q?LhSO/Vk2S+ni8sjbOXmxdNdAemW7HHbXCRTkOV7zob584IsvFOtPpjrzStxa?=
 =?us-ascii?Q?7k7oVJnQJB2XM6TA9DYCBuUYzYpukV6VSy5xYIUkZAFdZ+wSIOTqKbJxa2Ui?=
 =?us-ascii?Q?XLFQ9xP99fgs4Niq/nNTx3+HeF1rbQQPzKVLK6MKgNJsCOhtWjG6CnEw2xHk?=
 =?us-ascii?Q?XrJurCqvATE1XVXh69F1mYNHfCd7jvGRpvvP7AhUKo3X4nE8VLc5Jw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JBGwIRQmTA7RW/w2wWo2MSPGPiM4pzTkANvsVLOXN6nK7mWUky8EcAYXDQEm?=
 =?us-ascii?Q?nTQBGbtxbA4FtTrtH8t6khQO1lz/l6+tdUkT8lcbtM5PuVeZ8TM8ER0/ZZbO?=
 =?us-ascii?Q?hj4wpDE7fB0VAS3345YmFB93NzByWJ/tyaUmjjnQNtOeXi8OwqCp1tkKI/jl?=
 =?us-ascii?Q?K5f38UAQccgA+QdpAnhjykFktpYTXv6BPQisdOvwsuSn7ZfstdJRrcbSizTb?=
 =?us-ascii?Q?MC2XlgZtL4EF+W5i6MllagtGjg9D7/rlAIjSGJJiFdyF0SZ4eJssdztRwGX4?=
 =?us-ascii?Q?VlhTnikgtvCvEbHk6UQzh3tm6jFKtpog76ahUlOKJJtguC2ZBp1shtvY8hep?=
 =?us-ascii?Q?dYLgqg5DfXsXcsb7XHM5PCZrkNk1AFyQVgGG7ZzYU/ZqKfLRcVUr1EPNIDQ1?=
 =?us-ascii?Q?YoZTrZfuXIQczdJg7Be11T/gtRLc4AHFtk3/p2F/2fJgchyZa85hNrj3rzp+?=
 =?us-ascii?Q?Lh6a3qFbUr4xEtcn6WJUo0MMJDoDIbkNqma5Q+FwPjK4jgSKUc+CpiADtfr9?=
 =?us-ascii?Q?9Wyr42mOoPrPVICbhyCYJ9clHpFyZwT8/omTc5EgTxwEDxwCpqbIyioOu43r?=
 =?us-ascii?Q?Gg5ypIRLRGDgImHy8Cp3eRGfkMmq9es4C5xgmI4piVVWnUGTuCTkesFQ+iOe?=
 =?us-ascii?Q?YomzI1OW0HDaiIOtAu6lgbPc07jAhU2nSGH/OCYR1GxMA/socRRGzKajy3yC?=
 =?us-ascii?Q?6zw/TuLfpQZh2N8Cxp+ZHofwT7ACsaMVS4zHC7tRWCBCBlFFsXo0PlyrSsxa?=
 =?us-ascii?Q?SjWxL79T2CbZibHH3fpJJX2BAEV4ytS4ztCMxNxwOa9FLrrDxsX8yXkwIPsP?=
 =?us-ascii?Q?zwrCB38qwlhIo4OnPwA4VLtMK8PvBFfG9HOvQRc4mxKCkZCctwXvuqfckY20?=
 =?us-ascii?Q?OATC5YYXkhuY7+gRJPnitpoGjMwxGnDRSvqL/HpvRS3BYW1eOSOoRD6ygTE0?=
 =?us-ascii?Q?b819G7JI0yBKfC56+2ho50oBL6N91MjkVIRjVriZFcC85UbuxV3r3OxS/K+i?=
 =?us-ascii?Q?nAm4Cq+YE9nuWRqghkjujyT0cRtrX5onX03EolQ21ip9rfUEOBh+wGyLT+X1?=
 =?us-ascii?Q?VWqT389gqn/ZyIi8AeZfLOcTussso9a1ry/m0994jOUqIs0QBatL3Fkt4g/y?=
 =?us-ascii?Q?jT9cxWIc+lfcyxM7b94GPQDrxe2IvWVmGaVKHLM0v14c2KGzR9bCvVVBtp1L?=
 =?us-ascii?Q?eFPA++GHjy08R+UAINjANcoQyJLUXuFWAxrurtxg72xMhnE1BHiiGRDy+Xtk?=
 =?us-ascii?Q?cRjb6y/uG9N1fnFf1xxyIm5Tz3dTpY1RdBL2KDLj+MLAybm/GsNAS5z7gJOJ?=
 =?us-ascii?Q?W0R8rxSuF89Egerv2//iv6nV51zjPFwwJzNQcPsX5XTNp4qROoOPKlKD9v2h?=
 =?us-ascii?Q?DBQ7deuOtTgMuO6wV37DTEBB9aPuSrB7CtBTV6ByFTTPpRJXxyKnT3KHmic2?=
 =?us-ascii?Q?SBFR0jcwEXzZ1H2/5MuCFAWLc9UryR2XT+g+AtMSgpIgwjNYL+ElSzAIMaQ5?=
 =?us-ascii?Q?8zrZZ/QbIpcejv4ISLFWv+DK2JoLwYxQSANGzpOzD9nGSlUkINacWYbB8XxD?=
 =?us-ascii?Q?X4iUrstP5C0RRfy2FpNsxrj40khZlyiE/TdLw7OHFwjaVXdkXjTiPzGdyUo1?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb5008e-3b46-46cc-888d-08de105cef64
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 04:47:27.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAozNhYssI5uwIq8JaS6W/7bhEk+kWMjkYzKhX2ngZosWXJmMcYDVZKLylBx9cb+1DF9xfL/JiVZP5q1k5DxzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c" on:

commit: b10b12648a2241455e9fee86967327ba9553ec48 ("[PATCH] lib/bsearch: add mutex protection for thread-safe binary search")
url: https://github.com/intel-lab-lkp/linux/commits/XueBing-Chen/lib-bsearch-add-mutex-protection-for-thread-safe-binary-search/20251016-171911
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link: https://lore.kernel.org/all/20251016090640.6331-1-chenxb_99091@126.com/
patch subject: [PATCH] lib/bsearch: add mutex protection for thread-safe binary search

in testcase: boot

config: i386-randconfig-015-20251019
compiler: gcc-14
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510211047.d2cd27e5-lkp@intel.com


[   14.272996][   T98] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:575
[   14.275210][   T98] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 98, name: modprobe
[   14.275220][   T98] preempt_count: 0, expected: 0
Starting Load Kernel Modules...
[   14.275223][   T98] RCU nest depth: 1, expected: 0
[   14.275227][   T98] 1 lock held by modprobe/98:
[   14.275231][   T98]  #0: b2995db8 (rcu_read_lock){....}-{1:3}, at: check_modstruct_version (kernel/module/version.c:77)
[   14.291645][   T98] CPU: 1 UID: 0 PID: 98 Comm: modprobe Tainted: G                T   6.18.0-rc1-00043-gb10b12648a22 #1 PREEMPT(full)
[   14.291655][   T98] Tainted: [T]=RANDSTRUCT
[   14.291658][   T98] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   14.291660][   T98] Call Trace:
[   14.291663][   T98]  ? show_stack (arch/x86/kernel/dumpstack.c:319)
[   14.291676][   T98]  dump_stack_lvl (lib/dump_stack.c:122)
[   14.291687][   T98]  dump_stack (lib/dump_stack.c:130)
[   14.291692][   T98]  __might_resched.cold (kernel/sched/core.c:8926)
[   14.291706][   T98]  __might_sleep (kernel/sched/core.c:8855)
[   14.291713][   T98]  ? local_clock_noinstr (kernel/sched/clock.c:304 (discriminator 1))
[   14.291724][   T98]  __mutex_lock (include/linux/kernel.h:61 kernel/locking/mutex.c:575 kernel/locking/mutex.c:760)
[   14.291755][   T98]  mutex_lock_nested (kernel/locking/mutex.c:813)
[   14.291759][   T98]  ? bsearch (lib/bsearch.c:44)
[   14.291765][   T98]  bsearch (lib/bsearch.c:44)
[   14.291776][   T98]  find_exported_symbol_in_section (kernel/module/main.c:373)
[   14.291784][   T98]  ? unregister_module_notifier (kernel/module/main.c:358)
[   14.291792][   T98]  find_symbol (kernel/module/main.c:401 (discriminator 2))
[   14.291799][   T98]  ? lock_acquire (kernel/locking/lockdep.c:5872)
[   14.291807][   T98]  ? check_version (kernel/module/version.c:77)
[   14.291816][   T98]  check_modstruct_version (kernel/module/version.c:90)
[   14.291822][   T98]  ? check_version (kernel/module/version.c:77)
[   14.291837][   T98]  early_mod_check (kernel/module/main.c:3333 (discriminator 1))
[   14.291850][   T98]  load_module (kernel/module/main.c:3384)
[   14.291854][   T98]  ? kernel_read (fs/read_write.c:549)
[   14.291872][   T98]  ? init_module_from_file (kernel/module/main.c:3683)
[   14.291891][   T98]  init_module_from_file (kernel/module/main.c:3702)
[   14.291930][   T98]  __ia32_sys_finit_module (kernel/module/main.c:3713 kernel/module/main.c:3739 kernel/module/main.c:3723 kernel/module/main.c:3723)
[   14.291961][   T98]  ia32_sys_call (arch/x86/entry/syscall_32.c:50)
[   14.291968][   T98]  do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 (discriminator 1) arch/x86/entry/syscall_32.c:259 (discriminator 1))
[   14.291977][   T98]  entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[   14.291981][   T98] EIP: 0xa7f33092
[   14.291986][   T98] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   14.291989][   T98] EAX: ffffffda EBX: 00000003 ECX: 0042e214 EDX: 00000000
[   14.291992][   T98] ESI: 011d6ec0 EDI: 011d6de0 EBP: 00000000 ESP: afd3c788
[   14.291995][   T98] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200296
[   14.292023][   T98]
[   14.335982][   T98] =============================
[   14.335987][   T98] [ BUG: Invalid wait context ]
Startin[   14.335990][   T98] 6.18.0-rc1-00043-gb10b12648a22 #1 Tainted: G        W       T
[   14.335993][   T98] -----------------------------
[   14.335995][   T98] modprobe/98 is trying to lock:
[   14.335998][   T98] b2a23080 (cmp_mutex){+.+.}-{4:4}, at: bsearch (lib/bsearch.c:44)
[   14.367204][   T98] other info that might help us debug this:
[   14.367208][   T98] context-{5:5}
[   14.367211][   T98] 1 lock held by modprobe/98:
[   14.367214][   T98]  #0: b2995db8 (rcu_read_lock){....}-{1:3}, at: check_modstruct_version (kernel/module/version.c:77)
[   14.367233][   T98] stack backtrace:
[   14.373209][   T98] CPU: 1 UID: 0 PID: 98 Comm: modprobe Tainted: G        W       T   6.18.0-rc1-00043-gb10b12648a22 #1 PREEMPT(full)
[   14.373217][   T98] Tainted: [W]=WARN, [T]=RANDSTRUCT
[   14.373219][   T98] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   14.373221][   T98] Call Trace:
[   14.373225][   T98]  ? show_stack (arch/x86/kernel/dumpstack.c:319)
[   14.373237][   T98]  dump_stack_lvl (lib/dump_stack.c:122)
[   14.373244][   T98]  dump_stack (lib/dump_stack.c:130)
[   14.373248][   T98]  __lock_acquire (kernel/locking/lockdep.c:4832 kernel/locking/lockdep.c:4902 kernel/locking/lockdep.c:5187)
[   14.373255][   T98]  lock_acquire (include/trace/events/lock.h:24 (discriminator 1) kernel/locking/lockdep.c:5831 (discriminator 1))
[   14.373259][   T98]  ? bsearch (lib/bsearch.c:44)
[   14.373265][   T98]  ? dump_stack (lib/dump_stack.c:130)
[   14.373268][   T98]  ? __might_resched.cold (kernel/sched/core.c:8926)
[   14.373273][   T98]  lock_acquire (kernel/locking/lockdep.c:5872)
[   14.373277][   T98]  ? bsearch (lib/bsearch.c:44)
[   14.373281][   T98]  __mutex_lock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 include/trace/events/lock.h:95 kernel/locking/mutex.c:600 kernel/locking/mutex.c:760)
[   14.373286][   T98]  ? bsearch (lib/bsearch.c:44)
[   14.373293][   T98]  mutex_lock_nested (kernel/locking/mutex.c:813)
[   14.373296][   T98]  ? bsearch (lib/bsearch.c:44)
[   14.373299][   T98]  bsearch (lib/bsearch.c:44)
[   14.373303][   T98]  find_exported_symbol_in_section (kernel/module/main.c:373)
[   14.373310][   T98]  ? unregister_module_notifier (kernel/module/main.c:358)
[   14.373315][   T98]  find_symbol (kernel/module/main.c:401 (discriminator 2))
[   14.373319][   T98]  ? lock_acquire (kernel/locking/lockdep.c:5872)
[   14.373322][   T98]  ? check_version (kernel/module/version.c:77)
[   14.373326][   T98]  check_modstruct_version (kernel/module/version.c:90)
[   14.373330][   T98]  ? check_version (kernel/module/version.c:77)
[   14.373335][   T98]  early_mod_check (kernel/module/main.c:3333 (discriminator 1))
[   14.373339][   T98]  load_module (kernel/module/main.c:3384)
[   14.373343][   T98]  ? kernel_read (fs/read_write.c:549)
[   14.373350][   T98]  ? init_module_from_file (kernel/module/main.c:3683)
[   14.373355][   T98]  init_module_from_file (kernel/module/main.c:3702)
[   14.373364][   T98]  __ia32_sys_finit_module (kernel/module/main.c:3713 kernel/module/main.c:3739 kernel/module/main.c:3723 kernel/module/main.c:3723)
[   14.373372][   T98]  ia32_sys_call (arch/x86/entry/syscall_32.c:50)
[   14.373378][   T98]  do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 (discriminator 1) arch/x86/entry/syscall_32.c:259 (discriminator 1))
[   14.373382][   T98]  entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[   14.373386][   T98] EIP: 0xa7f33092
[   14.373390][   T98] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   14.373393][   T98] EAX: ffffffda EBX: 00000003 ECX: 0042e214 EDX: 00000000
[   14.373397][   T98] ESI: 011d6ec0 EDI: 011d6de0 EBP: 00000000 ESP: afd3c788
[   14.373400][   T98] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200296



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251021/202510211047.d2cd27e5-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


