Return-Path: <linux-kernel+bounces-859528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7166BBEDE5F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C25B3A38C2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 05:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664FF217648;
	Sun, 19 Oct 2025 05:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxqeqdMe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D321B9F1
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 05:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760850695; cv=fail; b=XvWPA5UC6xR1TnW/+cb+3kUrCwhoiJ51REIlp5NtkSGF4KdwauVcrwDZ5UrnxpS0B/YxgVQyWaMsbDRmjwguIyssnbnOUYlocpzfeSDKb/VwnEyyP6NVNLwPV4CmqrgL07eLYAfEyczrOgv9p1e1baVcZpKHflWNgQTpLsaPY3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760850695; c=relaxed/simple;
	bh=8Tm24BID7V6WZV2xGJf0+CHsjK8rgQrFJVH+LMuESIU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=osw9V/r7zouSLqsDkgqVhTzS/pu+MdF7KsxBO7huyW4tk8+JHvs0pzuprxZt/wetFJ2SHRhk23qHj5BxBkp47WEuTvuhcguIFeEFtr6LsMT5fC+5fnNwYIDBk0tufwxIvDzjsgM/slhfAMMMoMlbPptu6voncE95libUIpmH+CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxqeqdMe; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760850692; x=1792386692;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8Tm24BID7V6WZV2xGJf0+CHsjK8rgQrFJVH+LMuESIU=;
  b=YxqeqdMefE+wZWe4P35o8Lp5dhcXxFPmwb2LLhCP+BHwNJz5mijeZa/P
   JloB0b2grd1pNtgsa64MqK8r5XqkpTxjf7BM23Of7XTiZiJKNluXFqKPH
   UewmOmmDg7AiBdGg8x0C8PFQBPGaLSfDFQwiNUQCb/CIVs9vtfOKYrs/G
   HyDT7s4W8TPoyNYwwjFk+H6NNCkhbZCto2kv7IDhf3jsnOLJcEi9NQ7hs
   VfWdbQKgLG/qc2+27qVBc66/Fw5RPvYSTY/17JE0B3iXtzsxTN90ycnFu
   5in+P6MInUrpN7sMQBPqF3ZN1SbLsKAo2UQbPmcAH37SeazAOt2eEomWX
   A==;
X-CSE-ConnectionGUID: 6kRSJ9I9Te2hAMY2eTZiGQ==
X-CSE-MsgGUID: VFlB89q7QS6A+pnIBAyc0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62917340"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62917340"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 22:11:31 -0700
X-CSE-ConnectionGUID: CwEthPnbSFysv63A2jFoOA==
X-CSE-MsgGUID: kRdAVhQzTs+AfTZW6HfINQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 22:11:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 18 Oct 2025 22:11:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 18 Oct 2025 22:11:30 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 18 Oct 2025 22:11:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QF5g8xwGnklIrrrhiXT1y07CkdQuxC3peWADFvJmx1cvF6cv7vyxO1AMXLSz/LkBEsj1ogOD3xvzV4eyWXlUroZWt1KlZy6jDjrQeCqW6EeIVg/jO3WjSMwlUV/sHtJk/pSxo6KVesiGCB3ssCkamPRnCBBYdGgOPP6xK7mpQu58mBbkv5VwTeijTo+Z/ui5gZsFbo9UjGt7RT7oRFkC1JYkEYbWwqO9Dw7VilCoJvmmK9niTbuq3Ih3siqUkTSwXDxi6D3aoYqT9zueDXMZ4hLuP4cHQZNz1AWT8jDbvSm5WS09facd8J+IKa48lMFxMs8x6YqiCAMuBHwxhqSZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIC5pDzd3GqLidk2O12CJufTV8VbRMkeG/tRmMiYvV4=;
 b=wK2mNbC3bREd9qVVQ8c8lBhSdmmgVjkdRV9ypwlIpNFxuzb0bmqun3SxqYS6dy8ggQlNagf0DvqR94cYJhljwZ79aq+zmgxmx97rsb9ppsgefPZ4EVRMXMiW9Xyyj4G/O3RYGUMe65Wt+ZBjq3pJSp6zkdRJkEHZXATwRWcWJ1rIiidy/gpNqlWZDTR/nHEZJWlico/WPH2fPflC9gl+Kj1vFRhgHdv1PdGSZvnf7olui4E0cVFscZWrXl/OsFEODo2BNh1RnEGG/06bWhvv6qrtysOPkE02oRVv3Xf8p6wgOYJHlSkxTEtOip1wIm3VpOHIRubGI+DY/BrR1p8vVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by PH3PPFEC5C0F28D.namprd11.prod.outlook.com (2603:10b6:518:1::d5c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sun, 19 Oct
 2025 05:11:22 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 05:11:22 +0000
Date: Sun, 19 Oct 2025 13:11:12 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Borislav Petkov <bp@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, X86 ML <x86@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: [PATCH] objtool/klp: Add the debian-based package name of xxhash
 to the hint
Message-ID: <aPRy8LuQra4b7d4T@rli9-mobl>
References: <20251017194732.7713-1-bp@kernel.org>
 <aPRyCq55erNhA8CI@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPRyCq55erNhA8CI@rli9-mobl>
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|PH3PPFEC5C0F28D:EE_
X-MS-Office365-Filtering-Correlation-Id: 7341fd75-9270-40bc-864a-08de0ecdf20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W2oCSb6lrFBMm5GwQRN5NeyJt6EjRLBIkGi6Jv9+3F1XgFZHColfP5lbzSik?=
 =?us-ascii?Q?k1xoXfHJa/GDEE+f/Cdfv304FTHCTphXrXr5K0JdNUX2DelpNnlO1p6ahqiA?=
 =?us-ascii?Q?lo0BybEBi/xdbMlYFGekezDMd3jRP6ETqQlr2G9Cz+9HZ+5HSm3/49EUnVP/?=
 =?us-ascii?Q?XbgfrjfHt+EVyHAxX6EozUo4XZA0r+o3D01G28y7jm44nqd7+vXfoCrOIb8q?=
 =?us-ascii?Q?AkEtzhMveh+zdsOMRvusb8elSAtZnxtkWIgmcQxupTgc/BPgp8GNNN5R0mpe?=
 =?us-ascii?Q?RvEU9ATtYjpYSdl8b/ECFZNUIMMEOR32yFScfzct/tKuCGKHeziyZX14ahhF?=
 =?us-ascii?Q?UP8FvMLhUr2Tnkx9BuOKwTzW0xmZuemmo+HMa4Ujnayei2G8lnueL23L9Nho?=
 =?us-ascii?Q?Ek8O9G/C1Ca2xOBWW3/ifCGw4FD9p7iu58EnUtdEt8BxqCENqCD9PjQvXBNb?=
 =?us-ascii?Q?juZqqNN912AotCH94f+JyiyDODoXlx703xzJ+pz0VwdrS3iKXolEU9OIAQlD?=
 =?us-ascii?Q?fjiu0a/J1AIDwUXFPZF/T48dJOqf9ax9i3ChaEQJIv8SK5teJiAOW/96rzih?=
 =?us-ascii?Q?7OpL3qDsnV5/GTj/1PtNP55QztyVep8YLr615oleePeKCnv5j2bXZ94IJyCF?=
 =?us-ascii?Q?LZGG3+cbJ07608dN1uU0VIdidgniQvkuxBz4isjGao+mvrFwgJMeDdDQwTDo?=
 =?us-ascii?Q?Nr0F89gaJ+W4x2fXcNZwc4LENQbDx3GFWz8CqUokLPap1nui1iY4VsuYfLGm?=
 =?us-ascii?Q?sFKE/QnRljGdnxY36LI6BNpU9rjWEcBYuU4qg0H4oWUTd0hSgRPleGY3j8EZ?=
 =?us-ascii?Q?//wx0f+G4xGkqgK6O77BOOwndLC0DKtzBq/vU/j3MTeDxE88dSJuX49BXlRM?=
 =?us-ascii?Q?+ZqZ/HM46vYXJ8RxaVMpxr7s/XzdpKG1rIUM9V1rhl0aBA09+uY4WKhDhNDv?=
 =?us-ascii?Q?ppcKyCYgni4X2fxRuIEugX2K6agmAxX6hTNs4g8oyLYkqXGXRkvENdrLsgVY?=
 =?us-ascii?Q?0XnkuWyEFARozFioQPLXfzUOme8LegugB18GXCzATjTFIOhtpWPH3pVZPP0K?=
 =?us-ascii?Q?e4rd+GHhAmlnR+xHfZz9s7r4svKnZ15IHYqo7j0bmHx4wpystyfox1FdaN7R?=
 =?us-ascii?Q?H8ZCli6FyZ9y35daePjrkg6yJrzXu7KdH6QOkWgkMXV3KAu3omHouF/b+SR8?=
 =?us-ascii?Q?VrFqaNC5oX2pA8wCUxDtfTzuxi3AWOBxHtpJ/nuQyEfLL6EkViR7VdA5AfEr?=
 =?us-ascii?Q?EuP2owwZ7J0HxvWhJg1IQE15mffI94eON8RWAsDyU6DUJw/MBvy5WqDbS04P?=
 =?us-ascii?Q?3Cwc/nPFjGD0GeIkHwNmhpk44aY+1+ajcHtD8mlFmIc7H6UYTIapbjWmyo+d?=
 =?us-ascii?Q?BGzaQoYOtcJzAGZvswWOHatpG8DDUnUi34satRuvd8XrQ0GB4urmT2SOqth5?=
 =?us-ascii?Q?fB9iJx2gSeAIzhsT5EOR4RwkHYU1EGBKSQ4dhGzJVhpgvLAv6ua9lQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9l65r/2mMBdreM6SJ+LO3UQFbqDyQru/HvKgl9ky6N1oF7rYXTD67bfZ2QpU?=
 =?us-ascii?Q?AYs8OZxs1c/pCi+dmICzmpemiu6EtyrigK3rJa1G4MQJUOgxAjPhRP/Sbk4f?=
 =?us-ascii?Q?f8hxLLOB1biecuRueoy2qJUbIsijPghx7/LjU9QIQWFWV6bJLoDDhCkxtEgu?=
 =?us-ascii?Q?ojBP+WCUOgMbNkdPs7aJDOEnySsw/folCmGCh/8dPEquMl5Av//Gz+Spybro?=
 =?us-ascii?Q?V5UvesLKQ4GF+LX4p7u8pEd8j7msdX4YOBHAEjqPKQ13tCPcniie42lpW8UR?=
 =?us-ascii?Q?5LoPijHQl087dRNtxla4igOTQTPBxtHFZNERQe9q11V5dmhPSpKNHf1sGfJ7?=
 =?us-ascii?Q?J7yhQs8BScqlIyOqrMZJo+ZzodId6gaZVLXL+Ba4rW/llLQ3fFmfUaSHqNas?=
 =?us-ascii?Q?05glbYqqISoKfnV7+nZxax8r8/SkZ16jzshAYO3O1k4AfLqsYVk/xJ1QXFoJ?=
 =?us-ascii?Q?U3KKIceCP19g13XFb/G2hpE1/JfElXrRFi9ElLy8Z46aa8pALZluqwBNbyr6?=
 =?us-ascii?Q?kqkAkW+HY+is3LnfRqS1ROKOz8p3AIib/Xv3+kLb8tLS3KN4bmvT3Only1yh?=
 =?us-ascii?Q?Sz+w2p2WgUiGbFqvI5pNIe01xl97vbhpEC0lPA1VCwL49dTv7OoEYA27ymU/?=
 =?us-ascii?Q?1bHrxs/0kp/eAQI4ojXufqttNtJ9zAca2SuQy94d57TJ1QdnHxngUivWpc49?=
 =?us-ascii?Q?j0Cf0c1T2b2u5xLb++9i6P5sO8jbRNgW7h7ro57++DDCmgpXqkda6jUzRLGo?=
 =?us-ascii?Q?jGuxFRfkszTMQaZZMeemPO0DFBpQIQc+Z6WxEd7Kj+7x3db8icIm9vmY5t96?=
 =?us-ascii?Q?amxKr0iCEOoU347707cunawzUdYbe/B+VLbqMCTUmZ7YVXiQC5aId1kM1aqI?=
 =?us-ascii?Q?ExQYQMRPnHJj2wc+97uXfHgxXgSyKj81ySRvco37vUY3wuHXeu1E8KOX8ReC?=
 =?us-ascii?Q?p8hLl4zhwD1UUiszXtzNx3Ng3lXxRW6dhrH4x80PuBK+OhkZ7Bq1faz5d59I?=
 =?us-ascii?Q?Ex0IFT7xuyeoePAbJv0ymr2hZFVG5fcGyyRtR7owc34X8D142t1hjQ+X5LPG?=
 =?us-ascii?Q?l/rLavSao6j+nEGf/Da4P7MnRBS3LpPj7enGmpJmwnK5I0YtLL/xXV3D0Y0e?=
 =?us-ascii?Q?UuUlMHklTJ1As67tEuoJX8TU7ML1UFUZBg0DHkIaUhcI5LyNr9MJgw2oGLpS?=
 =?us-ascii?Q?8hyWHNFlqyiFeqRwnZmrOiqcQirbyljzOaNWKaoZQqcQUTGfHgIvuNucfWSJ?=
 =?us-ascii?Q?zfW4uV2KAw9PdZ6S9oCULlImh0x2DnsYbODW2VfO+VTlma4v6hT6g1SJYRsT?=
 =?us-ascii?Q?Bpk4y6KbmoUCSgqwmm16AmkbAvoD+FM7J98iW+4M5f0HVBGqBocLjKOF+t3N?=
 =?us-ascii?Q?dZRV2o0z0ZB6zporz0wg4KiDJCiVWdR7vMZB9kD/PHyx/+tvFjwRwMsDF1Bj?=
 =?us-ascii?Q?683CVkJVN0Dr97o2yHwJLJCUT5ok5HaFQ0dxGEIwirhzshVR76e2lJVTTWE5?=
 =?us-ascii?Q?uOpfrb6JYfoUBZk6a9Y3Mj/wfvPrHPRMt6HdK2z0Xr9cgvpxWxNpDqqVgaBx?=
 =?us-ascii?Q?j1SQHGZPeGFlfwioG87in5vJXaj1HC4rXdBe6ix7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7341fd75-9270-40bc-864a-08de0ecdf20a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 05:11:22.7577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JciDk1CKknDrDT1o6ezqBo3j7RT6w6cGA/9xlg97qU0x53XUuc2UClF/3mLoTsVlrKW+i9sEK0Hb5vzoocpIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFEC5C0F28D
X-OriginatorOrg: intel.com

On Sun, Oct 19, 2025 at 01:07:22PM +0800, kernel test robot wrote:
> Hi Borislav,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on next-20251017]
> [cannot apply to linus/master v6.18-rc1 v6.17 v6.17-rc7 v6.18-rc1]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Borislav-Petkov/objtool-klp-Add-the-debian-based-package-name-of-xxhash-to-the-hint/20251018-091553
> base:   next-20251017
> patch link:    https://lore.kernel.org/r/20251017194732.7713-1-bp%40kernel.org
> patch subject: [PATCH] objtool/klp: Add the debian-based package name of xxhash to the hint
> :::::: branch date: 25 hours ago
> :::::: commit date: 25 hours ago
> config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251019/202510190931.1SovbysA-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510190931.1SovbysA-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202510190931.1SovbysA-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Sorry, kindly ignore this report. which is a false positve.

> 
> >> error: objtool: --checksum not supported; install xxhash-devel/libxxhash-dev and recompile
> --
>    drivers/message/fusion/mptsas.c: In function 'mptsas_issue_tm':
>    drivers/message/fusion/mptsas.c:4791:26: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
>     4791 |         unsigned long    timeleft;
>          |                          ^~~~~~~~
> >> error: objtool: --checksum not supported; install xxhash-devel/libxxhash-dev and recompile
> --
>    mptsas.c: In function 'mptsas_issue_tm':
>    mptsas.c:4791:26: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
>     4791 |         unsigned long    timeleft;
>          |                          ^~~~~~~~
> >> error: objtool: --checksum not supported; install xxhash-devel/libxxhash-dev and recompile
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
> 

