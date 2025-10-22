Return-Path: <linux-kernel+bounces-864402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4564BFAB50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7583AA748
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0F2FDC4A;
	Wed, 22 Oct 2025 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l36DQrr0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D13B2F2608
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119707; cv=fail; b=sx+m53hWSQDRLO7jkPPoTFBKJqy4fD8Wi0ksEdS4d2C4AmQWruUMxHfEe9pjrewXbZOXt7esFQIsTFzk0ksYFxA4JJT7cTp5ZXUkritgTvC7NaNOtRhjUFLo72UuuCR6cgfdXuufZtHfu5jPTz6DtXTPMjrAyGqx/KBQO7WZcGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119707; c=relaxed/simple;
	bh=OhR3/xk+BIp0lHU0bAzwJdMGBF1wivLN0w/NYrb5eCs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PtT5wlL6YF5F/lo7gb9KpKHYTRyAeXXZST8eh5242vQKKhjL/qc2fC9amZg4+43hh5bLn3e6/TYYlAHEqxATBHzxIxSH9A6kE8A6pdOAtTlftXNTpWAfYniBU6aySwn4Y4p9i5MIb/onR13xnofMCfnlcY+lIbsvq4qvqISvDFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l36DQrr0; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761119706; x=1792655706;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OhR3/xk+BIp0lHU0bAzwJdMGBF1wivLN0w/NYrb5eCs=;
  b=l36DQrr0Cuy4vQyEg/deTSW0S7nXS5UPpjGELN3wVpcNTSXezLoF+4QU
   Hqvx3Ow2Hjbr7Xph3J6HfWaXxMKWoFsBisJ2eKv59LRujfq6W/N9ozxP+
   37Co0v/vdmUi2PdeJtWj+tyhnbFxfYZ4MW0z929PE0vRlyo5r2rxMTlAe
   aek1VGtaIoe+aJ/U1JpOkeoNzXN1BdRgmbL3k2lqpbW2OJ89lny2qtmi4
   iqeECusCYWMER910ZqfnfvB1YXEJwpKc0FdYQJuqdhQifJUznVbTWojyl
   PnfnIgWEXN0XKj/4oGOhri3FnOySF1xwbnxHm19dPQ+lEVdvUO4FlWJPL
   A==;
X-CSE-ConnectionGUID: wnNDzsi2TJ6auQpMwipSKQ==
X-CSE-MsgGUID: B/tJnbuvSnyb1cA+EOOLuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63355260"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="63355260"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 00:55:05 -0700
X-CSE-ConnectionGUID: wZ4/IyrCTHmVIwndW3yvew==
X-CSE-MsgGUID: 1PNdvA9aTGGeJu6qWA0INw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="184289783"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 00:55:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 00:55:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 00:55:04 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 00:55:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJWuANXUimvoQv9gV+V8aiXBam8MeVu7jk+3TfnWp0fng5wjaxFTU7UUPrNZtDRs0zHbO4FhjW3l/0TGLpwpoAMJepAwDuoQ4IVqDS78Yu/1RhU+SdRRTgeg68GNnsEyRpvm3J/haqnDvUTXp+XQQhT+507jm3n0y6Kb+QrzpiLTXj4IG+WtBbPLOviVzHOG9/m6lhqIwFfQ2sCYt2spHhh+YiLQpLsDIP7NuzJex0naHw9ONC9Ar7G7NurKtOxAsQ3dzeRkrpBoAIWbipSM8ZBlntwwky02cvy31KDrz97ICz16RZAQoOrw3ZlfQR0N0QVFWR+o0VEELXJF4A84zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlDDvuZ6SAxdQ67hIz+htgPtmZGJsWP1brFGvEDZxzk=;
 b=vXIctpoHGeEZh4xGWKoR3WEpHRlngqTCcYqQ+XiT4Hgshc8iZY2W9jKJVjDQJgW+RtKrTuof4gLeciYyzwn1in6tKwLShUYSn8KfcBuhU/oK7shc90qV9OCPDRArHUwJWgKVUV6W4oUTbNvCSt1yPPLTPSl0T+WyNuOas40O1m6CTlRmnIy0mm1L+9UW3yNQViJ4F4mypG2a09kqOQEakYGOFsH0ATQlHeN3MfgHXwAiD4ALzdzi3K2KjAuMm38ZSw6mdB6D3Nj5qMtq44las/WHmGagfS5XA5R8F2fl/80vb94W2Lx7vWHt4Ac+j3L5EVpE0bWryDOEQqk5Woqu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:55:01 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:55:01 +0000
Date: Wed, 22 Oct 2025 15:54:51 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A.
 Shutemov" <kas@kernel.org>, Kai Huang <kai.huang@intel.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Retrieve TDX module version
Message-ID: <aPiNy8Q3uPrlVlug@intel.com>
References: <20251001022309.277238-1-chao.gao@intel.com>
 <20251001022309.277238-2-chao.gao@intel.com>
 <934568ea-b9a0-4ea8-b62f-2edfd2e64f9f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <934568ea-b9a0-4ea8-b62f-2edfd2e64f9f@intel.com>
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DM4PR11MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9cbd69-b0af-48b8-1020-08de11404daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xSdbvqA5T5YXvx+MfKbq6kumlph7/Xl0X85SHeCvVzs7JRNUzDlwhyuwDhfR?=
 =?us-ascii?Q?KJ9W4VkKxc15Z6KfwRdKBDpBb5si1xeP/o+iFl7tqVfbINZuc78W4nwJtFOC?=
 =?us-ascii?Q?gOFOeUw0Lp+/oYDbtJmr+BQLa/66O7DxkjmBb9xe5LOFJOPSd4hIvlzp7uzC?=
 =?us-ascii?Q?s8O+z9vhKDJ5TcriJKfjHX1YVIM6kemEw74zsMQJf6qhV7aBgaTYDJjSmYmC?=
 =?us-ascii?Q?gVBXVha00cQEkzcXIBCKlKny18oXKWu6GgcWSXwIOkznPksF6hdMNfoAVnWb?=
 =?us-ascii?Q?0oynkrW3mmPcvg1mL0hWGHxoOLI58jO9XIvfgWcs+f0xK43i5zHsZHxHVZQN?=
 =?us-ascii?Q?gXG7zf1taWha84l4/cq5Lk09Jx+SbHoHlQmMT3qM0h2dJpsQiYPu7/XHl6k+?=
 =?us-ascii?Q?KD2MBMoufTmGVxp1jQjbVrO7yQS6D4oEj++XOJRfXQ8nbjOONSa/ch2RKJGG?=
 =?us-ascii?Q?mSWgUGoMj6FfqsbHs2MdrpoVcgqIYuLkHdQFg9SI9hfXJc3f6qrUgVMrNx8z?=
 =?us-ascii?Q?HH31Vsxw9VJ1B/NFyn/0QfjQ27kEB2oom6Hl818EGakuVskW7mzCaTLwTcxP?=
 =?us-ascii?Q?sa8h0HXiMLExeU4Vruh0eKglGjAzliA0YYM5NBhaVttBzG8Fh8kUTCr/9N8Q?=
 =?us-ascii?Q?PzYLm+Lb78tSg8eDc1Fh6HquQQJnB3Xb43MffI6RI9ebNJQhyycyKSJHspkz?=
 =?us-ascii?Q?QpFLvcg+vJv+QK9RlSAAy++jEwmIKgUQMzjIRccRTj2E2u1OprmhxN8Gp05C?=
 =?us-ascii?Q?2rGpRNTwe2ADgu0niVjfhUMdC5TTwnaGR3PysR0KPp3Blgt99Dl1Kbdep53q?=
 =?us-ascii?Q?it/CUszFlj6XIZ/XPuFe7hSYnZlmpRz/QdX5MCmTwABVXvfq1xgYY0fuI2wo?=
 =?us-ascii?Q?+nSp4oTwC0iX6HzN/CCX1WDH7mESFIaZXPcJXNt2xNAsCTpb0Fcm5vc1Ns1J?=
 =?us-ascii?Q?vh/SK1ogB7DYYBNmn6eDmvDPR0wrfSHcmz0ZijQrPSr63umfEwbQBDCuES0d?=
 =?us-ascii?Q?QBMkzEl7rojEN7tzHeVkPs4b3kJXpTRoYdS2YX0CXD1Kj6joGxbtlG/1sofV?=
 =?us-ascii?Q?XcFrkeYvqtd32UkE3c/DQHXumr0IORLSBEE/tEd+x4uEyZ6Qto5P//R3sd0f?=
 =?us-ascii?Q?dBG57EbsvyAmPmZvtXjj5BYlNjsDIw++xLm1awOpD5u/y2bKa+umEimkEqzz?=
 =?us-ascii?Q?WkHAw7MQ0X7Db0JElRf5pO1lj3AMSgungawV/Pst0VNTjOCp1jn15G5VV+OQ?=
 =?us-ascii?Q?ogiy3IIQ5//4XnAx1Emqv0uZsawXYkuJKz/QlRukWdaYMLJYk8CVWvpX8KAk?=
 =?us-ascii?Q?e8mnAPknIzrNZqZSAV1WDGRTGyekRVhYVHzVH+tgfR1UNAna8n02EVO918FZ?=
 =?us-ascii?Q?g+2nVpce+gMOukqXWtqi7OYwXAgRI2UgFsU0lXgKSQ0s7Y5JxdZcMI1ibb5s?=
 =?us-ascii?Q?R6bLBiskOVW49VBmBoNrfFTEEWVE6MR2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4k9ImtK0KzkpfkcDO9TGMHqAVbKUbA8c8l2zxprgVHckNNKU16nfTWQf81SK?=
 =?us-ascii?Q?zM4y5f4NOF78QSvYyJ1bnZFHnaBsuZ9hIpVhkosUl6K2nl+q5KnzLqGEWaaI?=
 =?us-ascii?Q?pnrHA3p1Kx9Qf/NkiNCPF8A4OdA+R6FbdYYE4ushTZal9UvS4VwfIFPm+MYh?=
 =?us-ascii?Q?22w4oigmtJYVgh21q4QnZMjdRI0GgsuXxqLAx5CV9fxtep35gqh8ggTxu5p0?=
 =?us-ascii?Q?mFNnjI52TzY2lwo7qk3B1GCS8wxkoJF4M/uPA5pT0svPnnXL1hHamG5vDJrM?=
 =?us-ascii?Q?aFemqhgSlyk4LzTLv9WL73mUt4MBphlfcHozq0nTko3/DKQljRNHkauk+AaU?=
 =?us-ascii?Q?FbzYrZy5TEVoC9UR4XYPEuMohurisvap0r28/xXCyyL1f9UYcLmdY8c6W4Fd?=
 =?us-ascii?Q?yA1Q3bD2Bw4WPB6YfbcfcSzvTuwBRHwUpghuQW0G+pcIsZLQBfJWY3YfZiib?=
 =?us-ascii?Q?GrWHUlgriGU3eX4DVZK+1qE6yy5v68snncRkhkcWT8AQ427mgdj6h5ZZhGh6?=
 =?us-ascii?Q?FjOXvYEqC0pOGohHj/LKvz8lm5bCKtSgV9kRxyTnWfOZjbNc5kr3QYfjRsE1?=
 =?us-ascii?Q?YmUk97KZ7JcfZjaMBeJoIUMLCkLF5yWLNfErt4pINGqFhcjKUVdqBDCUZSpk?=
 =?us-ascii?Q?Zy4u9tetfNzU/RWBDygfrAQbnl/wahvGnMF3HPDGaADrlo8hIA9VV/KrPwqt?=
 =?us-ascii?Q?PB7gHdzBW+kdSksLMEQLHFwBH4MOd729ZICmwNxYtMw7caYLRruQvTIDcHV3?=
 =?us-ascii?Q?dkMvdF4RLT5/PlC5lmW75Am6njgKkrDlgD5HkBpHOVsp35SmXonejrq+uP1q?=
 =?us-ascii?Q?RL/Cs9W1v4iJqiQcOA6v35ewLJP1F90Z1mjRoxfpDl27UGbGPmd8sX+0aCN5?=
 =?us-ascii?Q?my/zfS8oKqR9g4KSCAOpQWmsSaJNO5HXirzGLySrOnKV1IxOesO1qHcm90D4?=
 =?us-ascii?Q?njPGweqXuvda2DScRbNAhFuT+muS/TPu1ux74PI80hSFXnay1fXZ62IZ6iFQ?=
 =?us-ascii?Q?KTgfX8/g+YaIzxNnt5x/+66Tl2r43HxIicGzZ9N8Xq390lziufE2ny7vCDtF?=
 =?us-ascii?Q?t9UVoZkOjl7XOhRfwr6idj3x0l721LghOZ9o22awCBMJRALfEWnd8yt3ejmw?=
 =?us-ascii?Q?6axttm/FUhCt4CnvaDxxOd1aIif1mKd14eTa7tGPeiDWx3sth8s/wYm83mMn?=
 =?us-ascii?Q?T1y2cqbuxb8/VLQpe20jBhBvHwjxPjNaM/eEeJHGmgw/eslW885Vc56eBLlB?=
 =?us-ascii?Q?HulJf431s+hcpW5uv7f4X9C4r956oC9fgl404+BZnis7TBy3ofGPKOhYTBFU?=
 =?us-ascii?Q?4I8tU3Kq0BG5rKrKOsjPe2ZjYcuuzcJuhTKEvkm/04Z4BRiUxPXRBLYIOXAf?=
 =?us-ascii?Q?IVNPQZRM2rMuhyptVCtp89cepVnlxMQskD0MHTgX9REUuP+aFKzXubAxuS0d?=
 =?us-ascii?Q?Fma4r4BGOjtJ8afp7Ts/mRheIIbGtgl+9VD8xR89P3NZVd1WWCVJ9c2uYxwX?=
 =?us-ascii?Q?0Dfj4dMtFVGFk8s9+eX+KjVc2AV8VrBzNPhmjQv86hExUF5HHcuXyLMO4J6S?=
 =?us-ascii?Q?D6oYbyn0h5fZqtQ9KHvkaIvl2fIwX9tlwF/RUl09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9cbd69-b0af-48b8-1020-08de11404daa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:55:01.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHhEu61Gd3FYdP/waklPzQur1zOgiV9pCuC4YBR8RJCki1AucQzfN4zc9sCS/f8gvjfUfuj18rQCa3c16nTabA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8132
X-OriginatorOrg: intel.com

On Wed, Oct 01, 2025 at 08:15:46AM -0700, Dave Hansen wrote:
>On 9/30/25 19:22, Chao Gao wrote:
>> +	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000003, &val)))
>> +		sysinfo_version->minor_version = val;
>> +	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000004, &val)))
>> +		sysinfo_version->major_version = val;
>> +	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000005, &val)))
>> +		sysinfo_version->update_version = val;
>
>Heh, how long does this take in practice to get 6 bytes of data out of
>the module?

~8us. And the whole metadata reading process (i.e., get_tdx_sys_info()) takes
~113us.

>When is the point that we move  over to TDH.SYS.RDALL?

TDH.SYS.RDALL takes ~16us.

I'm uncertain whether the saved CPU time of ~100us justifies implementing
TDH.SYS.RDALL.

TDH.SYS.RDALL returns all metadata as a list of arrays, requiring the kernel to
parse this structure and iterate through all fields.

One advantage of TDH.SYS.RDALL is that it eliminates the need to check field
existence before reading, since it simply dumps all available fields rather
than targeting specific ones. For example, TDH.SYS.RDALL removes the need for
the tdx_supports_ABC() check:

	in the DPAMT series:

	+	if (!ret && tdx_supports_dynamic_pamt(&tdx_sysinfo) &&
	+	    !(ret = read_sys_metadata_field(0x9100000100000013, &val)))
	+		sysinfo_tdmr->pamt_page_bitmap_entry_bits = val;

	in the TDX Module update series:

	+	if (tdx_supports_runtime_update(&tdx_sysinfo) &&
	+	    !(ret = read_sys_metadata_field(0x8900000100000000, &val)))
	+		sysinfo_handoff->module_hv = val;

While iterating through the array list adds some complexity, this is a one-time
cost. Once the loop structure is in place, adding new fields only requires
inserting a "switch-case" clause within the loop.

Please see the draft code below. If TDH.SYS.RDALL is the right direction, I can
refine the code and submit a formal patch series.

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 128e6ffba736..fa9bb6d47a87 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -226,22 +226,23 @@ static int build_tdx_memlist(struct list_head *tmb_list)
	return ret;
 }
 
-static int read_sys_metadata_field(u64 field_id, u64 *data)
+static int read_sys_metadata_field(u64 *field_id, void *ptr)
 {
	struct tdx_module_args args = {};
	int ret;
 
	/*
-	 * TDH.SYS.RD -- reads one global metadata field
-	 *  - RDX (in): the field to read
-	 *  - R8 (out): the field data
+	 * TDH.SYS.RDALL -- reads all global metadata fields
+	 *  - RDX (in): the physical address of the buffer to store
+	 *  - R8 (in/out): the initial field ID to read (in) and
+	 *		   the next field ID to read (out).
	 */
-	args.rdx = field_id;
-	ret = seamcall_prerr_ret(TDH_SYS_RD, &args);
+	args.rdx = __pa(ptr);
+	args.r8  = *field_id;
+	ret = seamcall_prerr_ret(TDH_SYS_RDALL, &args);
	if (ret)
		return ret;
-
-	*data = args.r8;
+	*field_id = args.r8;
 
	return 0;
 }
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 1965adb63f1f..44d92047073e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -42,6 +42,7 @@
 #define TDH_SYS_RD			34
 #define TDH_SYS_LP_INIT			35
 #define TDH_SYS_TDMR_INIT		36
+#define TDH_SYS_RDALL			37
 #define TDH_MEM_TRACK			38
 #define TDH_PHYMEM_CACHE_WB		40
 #define TDH_PHYMEM_PAGE_WBINVD		41
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 3fdd5cbc21d8..f4b16367ef2f 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,121 +7,177 @@
  * Include this file to other C file instead.
  */
 
-static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
+struct md_field_id
 {
-	int ret = 0;
-	u64 val;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000003, &val)))
-		sysinfo_version->minor_version = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000004, &val)))
-		sysinfo_version->major_version = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000005, &val)))
-		sysinfo_version->update_version = val;
-
-	return ret;
-}
-
-static int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_features)
-{
-	int ret = 0;
-	u64 val;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x0A00000300000008, &val)))
-		sysinfo_features->tdx_features0 = val;
-
-	return ret;
-}
-
-static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
+	union {
+		struct {
+			u32 field_code;				// Bits 31:0
+			u32 element_size_code		: 2;	// Bits 33:32
+			u32 last_element_in_field	: 4;	// Bits 37:34
+			u32 last_field_in_sequence	: 9;	// Bits 46:38
+			u32 reserved_1			: 3;	// Bits 49:47
+			u32 inc_size			: 1;	// Bit 50
+			u32 write_mask_valid		: 1;	// Bit 51
+			u32 context_code		: 3;	// Bits 54:52
+			u32 reserved_2			: 1;	// Bit 55
+			u32 class_code			: 6;	// Bits 61:56
+			u32 reserved_3			: 1;	// Bit 62
+			u32 non_arch			: 1;	// Bit 63
+		};
+		u64 raw;
+	};
+};
+struct md_list_header
 {
-	int ret = 0;
-	u64 val;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000008, &val)))
-		sysinfo_tdmr->max_tdmrs = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000009, &val)))
-		sysinfo_tdmr->max_reserved_per_tdmr = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000010, &val)))
-		sysinfo_tdmr->pamt_4k_entry_size = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000011, &val)))
-		sysinfo_tdmr->pamt_2m_entry_size = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000012, &val)))
-		sysinfo_tdmr->pamt_1g_entry_size = val;
-
-	return ret;
-}
+	u16 list_buff_size;
+	u16 num_sequences;
+	u32 reserved;
+};
 
-static int get_tdx_sys_info_td_ctrl(struct tdx_sys_info_td_ctrl *sysinfo_td_ctrl)
+struct md_sequence
 {
-	int ret = 0;
-	u64 val;
+	struct md_field_id sequence_header;
+	u64 element[0];
+};
+
+#define TDX_MD_ID_MINOR_VERSION			0x0800000100000003
+#define TDX_MD_ID_MAJOR_VERSION			0x0800000100000004
+#define TDX_MD_ID_UPDATE_VERSION		0x0800000100000005
+#define TDX_MD_ID_MODULE_HV			0x8900000100000000
+#define TDX_MD_ID_TDX_FEATURES0			0x0A00000300000008
+#define TDX_MD_ID_MAX_TDMRS			0x9100000100000008
+#define TDX_MD_ID_MAX_RESERVED_PER_TDMR		0x9100000100000009
+#define TDX_MD_ID_PAMT_4K_ENTRY_SIZE		0x9100000100000010
+#define TDX_MD_ID_PAMT_2M_ENTRY_SIZE		0x9100000100000011
+#define TDX_MD_ID_PAMT_1G_ENTRY_SIZE		0x9100000100000012
+#define TDX_MD_ID_TDR_BASE_SIZE			0x9800000100000000
+#define TDX_MD_ID_TDCS_BASE_SIZE		0x9800000100000100
+#define TDX_MD_ID_TDVPS_BASE_SIZE		0x9800000100000200
+#define TDX_MD_ID_ATTRIBUTES_FIXED0		0x1900000300000000
+#define TDX_MD_ID_ATTRIBUTES_FIXED1		0x1900000300000001
+#define TDX_MD_ID_XFAM_FIXED0			0x1900000300000002
+#define TDX_MD_ID_XFAM_FIXED1			0x1900000300000003
+#define TDX_MD_ID_NUM_CPUID_CONFIG		0x9900000100000004
+#define TDX_MD_ID_MAX_VCPUS_PER_TD		0x9900000100000008
+#define TDX_MD_ID_CPUID_CONFIG_LEAVES		0x9900000300000400
+#define TDX_MD_ID_CPUID_CONFIG_VALUES		0x9900000300000500
 
-	if (!ret && !(ret = read_sys_metadata_field(0x9800000100000000, &val)))
-		sysinfo_td_ctrl->tdr_base_size = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9800000100000100, &val)))
-		sysinfo_td_ctrl->tdcs_base_size = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9800000100000200, &val)))
-		sysinfo_td_ctrl->tdvps_base_size = val;
-
-	return ret;
-}
+/*
+ * Extract CLASS_CODE (bits 61:56), CONTEXT_CODE(bits 54:52),
+ * FIELD_CODE(bits 23:0) from metadata IDs. Other bits in metadata IDs
+ * cannot be used for comparison.
+ */
+#define TDX_MD_ID_MASK				0x3f70000000ffffff
 
-static int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_td_conf)
+static void parse_md_sequence(struct md_sequence *sequence, struct tdx_sys_info *sysinfo)
 {
-	int ret = 0;
-	u64 val;
+	u32 num_elements = (sequence->sequence_header.last_element_in_field + 1) *
+			   (sequence->sequence_header.last_field_in_sequence + 1);
+	u64 base_id = sequence->sequence_header.raw & TDX_MD_ID_MASK;
+	u64 field_id;
+	u64 *data;
	int i, j;
 
-	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000000, &val)))
-		sysinfo_td_conf->attributes_fixed0 = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000001, &val)))
-		sysinfo_td_conf->attributes_fixed1 = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000002, &val)))
-		sysinfo_td_conf->xfam_fixed0 = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000003, &val)))
-		sysinfo_td_conf->xfam_fixed1 = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9900000100000004, &val)))
-		sysinfo_td_conf->num_cpuid_config = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9900000100000008, &val)))
-		sysinfo_td_conf->max_vcpus_per_td = val;
-	if (sysinfo_td_conf->num_cpuid_config > ARRAY_SIZE(sysinfo_td_conf->cpuid_config_leaves))
-		return -EINVAL;
-	for (i = 0; i < sysinfo_td_conf->num_cpuid_config; i++)
-		if (!ret && !(ret = read_sys_metadata_field(0x9900000300000400 + i, &val)))
-			sysinfo_td_conf->cpuid_config_leaves[i] = val;
-	if (sysinfo_td_conf->num_cpuid_config > ARRAY_SIZE(sysinfo_td_conf->cpuid_config_values))
-		return -EINVAL;
-	for (i = 0; i < sysinfo_td_conf->num_cpuid_config; i++)
-		for (j = 0; j < 2; j++)
-			if (!ret && !(ret = read_sys_metadata_field(0x9900000300000500 + i * 2 + j, &val)))
-				sysinfo_td_conf->cpuid_config_values[i][j] = val;
-
-	return ret;
+	pr_info("header 0x%016llx id 0x%016llx elements_in_field %d field %d\n", sequence->sequence_header.raw, base_id,
+		sequence->sequence_header.last_element_in_field + 1,
+		sequence->sequence_header.last_field_in_sequence + 1);
+
+	/* Iterate over all elements in the sequence */
+	for (i = 0; i < num_elements; i++) {
+		field_id = base_id + i;
+		data = sequence->element + i;
+
+		switch (field_id) {
+		#define READ_TDX_MD(name, field)			\
+			case (TDX_MD_ID_##name & TDX_MD_ID_MASK):	\
+				field = *data;				\
+				break;
+
+		READ_TDX_MD(MINOR_VERSION, sysinfo->version.minor_version);
+		READ_TDX_MD(MAJOR_VERSION, sysinfo->version.major_version);
+		READ_TDX_MD(UPDATE_VERSION, sysinfo->version.update_version);
+
+		READ_TDX_MD(MODULE_HV, sysinfo->handoff.module_hv);
+
+		READ_TDX_MD(TDX_FEATURES0, sysinfo->features.tdx_features0);
+
+		READ_TDX_MD(MAX_TDMRS, sysinfo->tdmr.max_tdmrs);
+		READ_TDX_MD(MAX_RESERVED_PER_TDMR, sysinfo->tdmr.max_reserved_per_tdmr);
+		READ_TDX_MD(PAMT_4K_ENTRY_SIZE, sysinfo->tdmr.pamt_4k_entry_size);
+		READ_TDX_MD(PAMT_2M_ENTRY_SIZE, sysinfo->tdmr.pamt_2m_entry_size);
+		READ_TDX_MD(PAMT_1G_ENTRY_SIZE, sysinfo->tdmr.pamt_1g_entry_size);
+
+		READ_TDX_MD(TDR_BASE_SIZE, sysinfo->td_ctrl.tdr_base_size);
+		READ_TDX_MD(TDCS_BASE_SIZE, sysinfo->td_ctrl.tdcs_base_size);
+		READ_TDX_MD(TDVPS_BASE_SIZE, sysinfo->td_ctrl.tdvps_base_size);
+
+		READ_TDX_MD(ATTRIBUTES_FIXED0, sysinfo->td_conf.attributes_fixed0);
+		READ_TDX_MD(ATTRIBUTES_FIXED1, sysinfo->td_conf.attributes_fixed1);
+		READ_TDX_MD(XFAM_FIXED0, sysinfo->td_conf.xfam_fixed0);
+		READ_TDX_MD(XFAM_FIXED1, sysinfo->td_conf.xfam_fixed1);
+		READ_TDX_MD(NUM_CPUID_CONFIG, sysinfo->td_conf.num_cpuid_config);
+		READ_TDX_MD(MAX_VCPUS_PER_TD, sysinfo->td_conf.max_vcpus_per_td);
+		#undef READ_TDX_MD
+
+		case TDX_MD_ID_CPUID_CONFIG_LEAVES & TDX_MD_ID_MASK:
+			for (j = 0; j < sysinfo->td_conf.num_cpuid_config; j++)
+				sysinfo->td_conf.cpuid_config_leaves[j] = data[j];
+			/* return as all elements in this sequence are handled */
+			return;
+		case TDX_MD_ID_CPUID_CONFIG_VALUES & TDX_MD_ID_MASK:
+			for (j = 0; j < sysinfo->td_conf.num_cpuid_config; j++) {
+				sysinfo->td_conf.cpuid_config_values[j][0] = data[2*j];
+				sysinfo->td_conf.cpuid_config_values[j][1] = data[2*j+1];
+			}
+			/* return as all elements in this sequence are handled */
+			return;
+		default:
+			break;
+		}
+	}
 }
 
-static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
+static void parse_md_list(struct md_list_header *list_header, struct tdx_sys_info *sysinfo)
 {
-	int ret = 0;
-	u64 val;
-
-	if (tdx_supports_runtime_update(&tdx_sysinfo) &&
-	    !(ret = read_sys_metadata_field(0x8900000100000000, &val)))
-		sysinfo_handoff->module_hv = val;
-
-	return ret;
+	struct md_sequence *sequence;
+	u32 num_elements;
+	int i = 0;
+
+	pr_info("header: buff_size %u, num_sequences %u\n",
+		list_header->list_buff_size,
+		list_header->num_sequences);
+
+	sequence = (struct md_sequence *)(list_header + 1);
+
+	while (i < list_header->num_sequences) {
+		num_elements = (sequence->sequence_header.last_element_in_field + 1) *
+			       (sequence->sequence_header.last_field_in_sequence + 1);
+		parse_md_sequence(sequence, sysinfo);
+		sequence = (struct md_sequence *)(&sequence->element[num_elements]);
+		i++;
+	}
 }
 
 static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
+	unsigned long buffer;
+	u64 field_id = -1;
	int ret = 0;
 
-	ret = ret ?: get_tdx_sys_info_version(&sysinfo->version);
-	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
-	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
-	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
-	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
-	ret = ret ?: get_tdx_sys_info_handoff(&sysinfo->handoff);
+	buffer = __get_free_page(GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	do {
+		ret = read_sys_metadata_field(&field_id, (void *)buffer);
+		if (ret)
+			break;
+		parse_md_list((void *)buffer, sysinfo);
+	} while (field_id != -1);
+
+	free_page(buffer);
+	if (ret)
+		pr_info("TDX sysinfo version read all failed: %d\n", ret);
 
	return ret;
 }


