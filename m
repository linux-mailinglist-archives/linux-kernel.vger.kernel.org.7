Return-Path: <linux-kernel+bounces-886425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D23DC358CE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8F044F54EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CB331327E;
	Wed,  5 Nov 2025 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkVN48PN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648143101C6;
	Wed,  5 Nov 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344151; cv=fail; b=kTutcaflaHdW7xMUj08KPgd/icH0X9iqB8jv9Njkf0WDGcgs3pkmflqKz7g+MjYnO99eXZrXwILhtQcI2NqunJl8QjvMz1cjmF5Ec3M7045sAxTW5oAo5ecfCAmy5DmFgktQsCBzBxJPoQ0U4koPrrrGRB7Qa0sqvCX6Wd+/U+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344151; c=relaxed/simple;
	bh=uFzDlajjndXb/Js2GDvwD0zKnKX9JhscO9Dmj7jp6js=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ozMZjkUgEKDpsqAc0vPn5InR/VjznzR6j3IlEZdkZI3y72bn1IA1bFuQxzKmfzeGkRp0+1JhzsOYO28NwF62F5zcdFor7LMOK9BCSntOYUGMCdfo4KYCcRgvyCHu4AkqdmicyU324XNXChHIW7ZUYBICRA9k6hQl/A9voePPLGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkVN48PN; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762344150; x=1793880150;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uFzDlajjndXb/Js2GDvwD0zKnKX9JhscO9Dmj7jp6js=;
  b=AkVN48PNX/xOeJLuf/4IVsxj4XLzDj/szXwFFfBQ8AUidav6p518rqKQ
   HK84mOnVDvRbuxhkJqCQ70/fNQKWcbqXM4G/c23UzaHtQoE5QmlWiG9VS
   6cNdd6XWbqjnvRO5D8Z3dSx6Pil2wjZxzMneBGtKYbgU3zpA0SxJ1ykN8
   LijHWioo+Fg6IG3oYVoo1KV+IyQ8nCzNi0KQsFVZSCqICT2IXrZlzsKmS
   0zLGl5P8vjZkSmzOPWJmVIX40XJ0sz3OsgmH7PQvwPHRW/JKZhEdgYQQJ
   Hx9q2nWo8tfRs/p/PhRI6x2ZsgJ7bp4M0k8wNfcQSlgWhETW6R/2C/ld1
   g==;
X-CSE-ConnectionGUID: huYzjc1CRf6e9n4zTeC72Q==
X-CSE-MsgGUID: nvvxOPJlTeuQB++jOYQp3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64338810"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="64338810"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:02:30 -0800
X-CSE-ConnectionGUID: XwkSTZaGQX2XofhhSylmYQ==
X-CSE-MsgGUID: zL4+9AKOSwuX6LjHqLmNzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="192513391"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:02:29 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 04:02:28 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 04:02:28 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 04:02:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vR2cUf0SLi6GCxbmbexjH3rX1md9csQW1pJ0Kh1zzCRN68F0BE7lKXigKg0ddEut4drNDwQAGI8zWqzEqnP0XPgdE/RqyViAVmIwhqvxlvXcfoD2e/sJo+c1fLJad9fL2+SdarbqxwI6EIO9bIVIr8HIQALZnIk9bO+r73dQ+ZCwKKXNZu82W9e73VaE5TwDRkW4k13wHs6UW8LKfkbDo5GVFgAKescnwSB08RGF3o3QgEVjm0gwxNgPRc49zKzzLFfq8iC86JiRRmw8BC3PVsLhDFR3xsC71gi53My3SXjmLmNky7SjA8Ta5QFE/WMhNYVIGWw/EzvvCBiiqylimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUSvVBOwazhPviqdsWC45a56k78OIr/23+ZgP7z6jIY=;
 b=XWpucrV+1jDk8V7E6H3TY5Teyj0UrAlBgGyO7FLi+M7GUGTkNIWVK6a18k5pycoc82pZswlWNjdN/CjbzFw2hica9Jd7g6mC18LIkDCBQuKZK5DTluDIhF61GIRC/uGs0ioSKqErAG1pDT9PysgOFbPqd/CHr/sxnqRTJgRFS/IQaunZuqYTqUydGorxJQtOd5iaOaUYTl93jtqGACZRR1UZI6M+9tzMN2QatEwqaNMG06O02VBd/MCJe79g+JMau92mNQWkEH9YK4MKCrJQiyrVE53H5HrzBDHS1Lm2AJkhbd4Z0ue90t6PCYiqSYS8ecsqIZZjExoXnj2CgmY1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by MN6PR11MB8104.namprd11.prod.outlook.com (2603:10b6:208:46c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 12:02:26 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 12:02:26 +0000
Date: Wed, 5 Nov 2025 20:02:16 +0800
From: Philip Li <philip.li@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: kernel test robot <lkp@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <aQs8yKAtagFQUUPo@rli9-mobl>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <202511050706.NIxJwZER-lkp@intel.com>
 <aQrgMldkQIS7VTtV@smile.fi.intel.com>
 <aQsBRFPwz0RJ/u9S@rli9-mobl>
 <aQsg0h_U2joioetO@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQsg0h_U2joioetO@smile.fi.intel.com>
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|MN6PR11MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b57f9e-66a6-4ae8-c257-08de1c632f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X8SsChvoS3jZZaTjRyyCB3G2C8I7F2nP0BlcI2EyKRPZGvztKZ94Kq+vesBi?=
 =?us-ascii?Q?8oo677p/OeMZXIT1CyJUO2cYysORiXKPiTfQEL9gssAkGrhxl3MlRhpoSOju?=
 =?us-ascii?Q?P6l5y/lWdmY8gYwI2jk7Hrspi61g2tspnNkaczw3dMde3AdV2pR24xoe+CAf?=
 =?us-ascii?Q?/K218hprF9ATyxgHEzbOujhYbDwMuPpAgbadJjJmqiMFb3X/xfUGNLVB4eam?=
 =?us-ascii?Q?poHswK8NlcJHdD4+g7EyRNUUxGKNahBZK2N2G8PPMY9eD5rK3uJp5a8bh5Zh?=
 =?us-ascii?Q?tkLkY0n3dybJoxoOtP9+o6Wl3srXp4EyQOG2SE8ksnKnxwTV41BsUrS+FIJ3?=
 =?us-ascii?Q?QWgk2IM0sjeH0OKe00F4NaRuvAbj0Mlvb3IQVF49G2Z7VUyEBltz2brCz3tU?=
 =?us-ascii?Q?a8XwR3ga+N8wMp5cQyHf4L/BvLEL4RTiXtRiWdjqIyK6+juoyhAOFl6b5gXM?=
 =?us-ascii?Q?TqQhRePBjp0pM+htytgDLaDC+Lt1FAZmC2kVzFYMauopnYa3j+h4MirGmN/o?=
 =?us-ascii?Q?BfDR0CTLDu1W3pzvE3AKl7Sbg/9Xu/mVQWPi1qaG05dRSezAV5DCFtP+V8Bz?=
 =?us-ascii?Q?9Bm6URBIyS/v9rxrmbBTZuA2+4E6R7XQhrj2+E5+AbPKsifS9JK/ezzJfo+y?=
 =?us-ascii?Q?dOtQeHUd8o7IqOMGy/ZnNyCNljVRKRMzggkK0bzJ9H3k7oO+yaXviYAF36lh?=
 =?us-ascii?Q?b6mGYr52ToQ6PkVeb4rxOtUzpGRna33E1b78uEA9noRzjNKg6sbBSdRD7QHX?=
 =?us-ascii?Q?s3E1id6yV44/BLKAMTFGUjM2I1Plq6iTDt2ny5oyG2WrLEkkw8MaHisoGIs4?=
 =?us-ascii?Q?66n/dzbzssQlTrZLk8GnEYhjL4PsRWw3EpCIRwKX9EdRcKo7nJfvAx3IDPL4?=
 =?us-ascii?Q?5LvIXdF0fJVhX39E87AaoYyv4KBbGmIdhXDttWnYUzTBE94vy3W15tLZAz1t?=
 =?us-ascii?Q?mqtYNKJw5vN6w0nkgMjpEtQKPsAOqSHrBQA8GDp0PITL+BbpRL3l8aDBnh5D?=
 =?us-ascii?Q?XViFyxn9UOG1ReA4SKw/7xC362syUHFyr5qFZTII6MwudUYfaqPGzeDJd2er?=
 =?us-ascii?Q?vKR6o/F/NBXqhHGqTWuBrNM6xMMH16/87W5kFDN3CyXzkbQd+fGaSCNr0p/x?=
 =?us-ascii?Q?/eJKreLEJva08PxFWpKwPEaRSgiMKv+kxf8fTN6nWMCxVU9tE+bcRXrJ4Jxe?=
 =?us-ascii?Q?lL4IABtiatRfnlBuh3ErqH2UQSVAJ9iFMReMvlxqyA3uEiQNbbDMgZ5w0yaA?=
 =?us-ascii?Q?H6nfSzcts9T4cN4c1+2GiDWP2hVZe/7QcgoO5+fwpm5E1Fl6dmJDdSwBTEAU?=
 =?us-ascii?Q?oSZXohG6tqF4IiEuuH05xc/5XcdpfYGHeeSbH9aVARgwPwMS0SlLuYweANjO?=
 =?us-ascii?Q?+mlsXmVWj2aQJpISy06w4WKIFzjDJz9yKQgCd4tqhKwk9vQRhNu318uFduq7?=
 =?us-ascii?Q?zkxAsfGxSXmAOaJp6R9tNxHlNVtTjlzj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rvip4C/R+Q9l8GMAFPYifEeaH/+esY1Jq6G2AHuWv2Lb1qPAlabMsttkYjdN?=
 =?us-ascii?Q?PSiE6T/gNCYuWL56/ca0D6xWT7SYcYmjMlyYX7LDtB8xA+vhWqaoI+pwXK24?=
 =?us-ascii?Q?+P1szR6mj0WwR9Zh44wER1DLwBZwnc9Q8CGFVa87kDJNOZYV/nd6ayC9ZfUT?=
 =?us-ascii?Q?UDj5orj4gy3es7Y1CJAbCfHHyXfg54P01cUpFDXWdUR5bnvbcKxXbR6D6tF/?=
 =?us-ascii?Q?U7TS7eeGSbMKPnY0fHTY8mvhQS9XKnkkhrEcgRu/2isI0kZ5qLASuCSkYYaz?=
 =?us-ascii?Q?D0dI1e2oU2QiqIOGDV/erLFSiiJUHWGmBZPueIHatmZEy5kgZ+nC+oz53GFb?=
 =?us-ascii?Q?VennCYkT6Kyycf+AJOwsipV8EO4Zm3rjFogWz6nnUNNF3YOuVOmoENOAbomC?=
 =?us-ascii?Q?u0Jo56N6ZlHNlzvYjKscMKFpC+Hik7fOHqVitsoegBLRHkWjI0yxh8Xe8ECj?=
 =?us-ascii?Q?83XL7Bh5o+sbIks3A1yLfKkhq6cBV93G54X0TUbT7cd1xLnPiP1dBA+0ohPN?=
 =?us-ascii?Q?t+/FndQ7k9dSZKMeJ1vZX6lGS4ajjpxaKUiSASu74CYaEZikOrjMxZA8rIHc?=
 =?us-ascii?Q?1e5vkja2S21RBLrwU+cgPhK0aJLMhU4yBSLOSVAs+5Rw2MC/Qpt1HXAObls7?=
 =?us-ascii?Q?W/nd2kJhsc/xGbYhmecQ/NOcNTsmAiza+RR31i63kb5sTk6xuXeRgHO4oH/e?=
 =?us-ascii?Q?UDa5mcDehPokgKKGjMI/xNMtjlvnnieBY0o/FNwl2j9WY3aHn2ESeYZaerqw?=
 =?us-ascii?Q?318+AqvMlee6NPrb/bvoM9Kmm9is9rx8WbwTHKqIrvV1lgUqsnO21WycLcCy?=
 =?us-ascii?Q?kfNxQvkVREF+ZpFkYXNiX1SWT7XHfXkNNugJJpWqfcBVvKnDOOlsdZJdnO+1?=
 =?us-ascii?Q?ES8w5k19fJzzhmsEZkJtrnADXo6fqYDpVgaIUfB+SGpiz6/aAve0eRLFMNSc?=
 =?us-ascii?Q?M0OhNHRgxEM7+d5yjixXAkoJAIuN/EAeZ0wxGtdni6q1npwXVe9z+OJmnGLD?=
 =?us-ascii?Q?TGaf8NUAWoE6PqU5+I6xjXN9GafvJZXlwzDBDgOBXvav7qDjEP46oZaS3Ydu?=
 =?us-ascii?Q?PIchD06E0TGqVofeLIJQAoOW8TrHq8pCYynYNhjrqcp17sXsdmZuj6qm7hMC?=
 =?us-ascii?Q?4xLk+wckYVABabDwjTc6hDMY2W5vSNeyRF1nhK4Umrsctwz+kky0aOWedafG?=
 =?us-ascii?Q?Y+QVtrzvVjWl+Y4Wn33J97J3zBD7ktHs3vqLnZLL7upnAsUodUoXDF659pqE?=
 =?us-ascii?Q?mXqE9YaLVuUmAH4vA7VVxRMSxWcNXdMGMSOB/+QKgI3KZZw/15Fh2wfseacu?=
 =?us-ascii?Q?oPEv+C+LMjXsf9gHo4M7aR9NwjafBIedbJmXxu4D1xf7zOlns4W9oZGTgvwO?=
 =?us-ascii?Q?wPKuZk1M49B8bKZ/TdgfAa1AQa8WygYJ7x/PMMbfqwu6tqI4lRABBWKO/+sc?=
 =?us-ascii?Q?zBQ7FolxRgPdk3GgXru5gw2t5SQeQNv91HzL2FJ0XGDtu/yosqktr87oRXUH?=
 =?us-ascii?Q?YqXn4kOptpf6h+6xp+seacNjoMieZpuU+k2s8eWNh1rk5pzeevvgpcUpgGZ7?=
 =?us-ascii?Q?SPzh/Rknroaul+xoeaq+d40SnfqfuhT9dQc6j+iU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b57f9e-66a6-4ae8-c257-08de1c632f6f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 12:02:25.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08hC7+Cw13rHRg7jxOF7PBua+Tf647NL5L5KYSEBtRCgzTv3JBu28d1U2p04Km4+omH7aLCkEb/uVMd8Wg042g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8104
X-OriginatorOrg: intel.com

On Wed, Nov 05, 2025 at 12:02:58PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 05, 2025 at 03:48:20PM +0800, Philip Li wrote:
> > On Wed, Nov 05, 2025 at 07:27:14AM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 05, 2025 at 07:14:58AM +0800, kernel test robot wrote:
> > > > 
> > > > kernel test robot noticed the following build warnings:
> > > 
> > > So do these...
> > 
> > Got it, thanks for the info, I will update the bot to ignore the further
> > reports on this commit. Sorry for the false positive.
> 
> No, they are not false positives, they are legit and good to have. Just that
> the root cause is not this commit.

Thanks Andy, got it. I will add comments clearly to be part of bot configuration.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

