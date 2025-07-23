Return-Path: <linux-kernel+bounces-742827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D53B0F720
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7547A4BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBBA1F3B8A;
	Wed, 23 Jul 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aisYrwet"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802A01F12E0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284892; cv=fail; b=jyChHfg9cadjBQp4RUlVi6j+k2VETXb+n7DnXXV3WEb44lzFz3/FB//dNYlwiR4KGM0Pwt30L5T4w1kHd1NFjeGvkBVe3QE17KextQAFxB+UQNH27N5f4bO5PPMQs4zkHsPJ3Lpa2shJKD4wpGlzlJ4mxNGgASJmA3p/YIMmrvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284892; c=relaxed/simple;
	bh=5+vzoHRKgbCxo9fKpIqtX4dLimRLLM+LhOZrcKV/TOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ll7Pep/jtljaaW/n7JbVOIy/7iodZpaUKhibauygVyFN5s8j3xp4EyEW87NbSU1Ngi97nfDObPIT0ar6T6FHa5aJ69r3qJytgIv2sRjN61iBA9xqRuiHSUy6LsMARKk1zs2iBxSvw97x6SygQh+u0xJ14v71jeCHC2Tw54DnoZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aisYrwet; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753284891; x=1784820891;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5+vzoHRKgbCxo9fKpIqtX4dLimRLLM+LhOZrcKV/TOw=;
  b=aisYrwetYrjoZPo2Nszdn7mp/Dc7sT/oPOVd/W9JBCKIcKFlLFbhh2GL
   5Q0w00wZxowIJx8ECa/DW3Po/9vv8JGyek6P1fY3zjCO6UtKfG2f7N+ok
   CRRaXoqS0z2dLAvqfvoNAWWXcPYpLFc82OgwuwB1+nQt/dO6WnPRpdPbB
   +CPxZYqt3717L8/cMuEWBt4dxi4zmrBTXeYWnLawC1AKwX2BD4cfSINbF
   AYK0uNmOq13DdpMz3pbThMJqETqY5QoAMsYF649kOwMjZoQrhyiS9wgfd
   hl3Kr0ospyUSv0ugIs5+bBkoUfsuiW5V5aDY+4YLZXt19FfglcDHHagim
   g==;
X-CSE-ConnectionGUID: opj49Q6eS8qHSAPpczEaqg==
X-CSE-MsgGUID: NU9DE35SQtmM+TW3fiSKGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43192169"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="43192169"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:34:42 -0700
X-CSE-ConnectionGUID: qW5TJB96TJyaH8ySCSkqMA==
X-CSE-MsgGUID: HegO8uqvSKyi5H1RxWxQUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="165215081"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:34:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:34:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 08:34:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.78)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:34:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUVtMzebJ5RRdghPtBYd4wv4yPQgoz/DbaxwfCsFEsovTOtWNL/2fw+rPzbt26fdmIF1HECTbC8G6PC89jf0yaEssKq/yGvxK2LX10tL4EHxgwL2/AZ4/48tjf8YpwNnLusy2lMs6/hc4TNmrZ5gVRZztlO1FD04ANdC8itQ1m8T3qb/uWyLp9ffV5BLgGNBQU1BP+bZ0zEpEVmgREDkwhPq+aDLip5VWPCOjkLty6Yw9aYX3rfVzN1mpqei+3z978WXSeZ3g3p+EP9138ezdBYaHjB+kgn1q146H73Ou1GrNfWBae1Ytfzo1HNO/VVXEOiJjhiYD92TLhICcNUvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy7efqJNc4DZ6Dmg4sr5U0FjakRJkck+/y9goId02GU=;
 b=ukJvlYPHApz1PbLNlZAx2bbj1IYGsF5TmOgQzenCYYkJv2cWV7eT6mh3X3UL9uV9C65Y05jObsqmJVhRwxlxTsDAGVDtE5MfQzaCOfZCBpA5UkONdisBzP0duhrGRYG+1Gx0ZGPphaTvI/SU3RLie2e0AFAZA3nkocQGij5tH3CtgkJ3XJtf/9NG0Gk62x3OtlnGpHDWHfrEOPvCVJpbBohB3NNEUWV4M/2k0VfMrYI83f/jAbQohLtEv0KnAbJsYvkCh5/qviG4YYHt2s2pRZgPK06Rfjztv7hHrwf8xipMnqtXEAyZZH4pO8q6suVcwLDphrRlwxoy8qQntPPNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by IA0PR11MB7402.namprd11.prod.outlook.com (2603:10b6:208:432::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 15:34:30 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::5461:fa8c:58b8:e10d]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::5461:fa8c:58b8:e10d%3]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 15:34:30 +0000
Date: Wed, 23 Jul 2025 17:34:17 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <balbirs@nvidia.com>, <airlied@gmail.com>, <apopple@nvidia.com>,
	<baohua@kernel.org>, <baolin.wang@linux.alibaba.com>, <dakr@kernel.org>,
	<david@redhat.com>, <donettom@linux.ibm.com>, <jane.chu@oracle.com>,
	<jglisse@redhat.com>, <kherbst@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <lyude@redhat.com>, <matthew.brost@intel.com>,
	<peterx@redhat.com>, <ryan.roberts@arm.com>, <shuah@kernel.org>,
	<simona@ffwll.ch>, <wangkefeng.wang@huawei.com>, <willy@infradead.org>,
	<ziy@nvidia.com>
Subject: Re: [PATCH] mm/hmm: Do not fault in device private pages owned by
 the caller
Message-ID: <aIEA-a5h3Zkx87EN@fdugast-desk>
References: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
 <20250722193445.1588348-1-francois.dugast@intel.com>
 <20250722130721.9169d564eeeb28807e18635a@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250722130721.9169d564eeeb28807e18635a@linux-foundation.org>
Organization: Intel Corporation
X-ClientProxiedBy: DB8PR06CA0059.eurprd06.prod.outlook.com
 (2603:10a6:10:120::33) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|IA0PR11MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1edcf0-b154-46c3-1431-08ddc9fe6a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pN8jQ68UiNE6xXgHpQsr+C+4UdF921C9Y+n4BQwE1kZGqboJfMmUCYhx0gae?=
 =?us-ascii?Q?pTsOD3umpKol2y9nZl04PUvzIpynsp3nwppff6pESSt3lRqf4xr0W99COgHj?=
 =?us-ascii?Q?hbjqiZHGoxw56DZCiyqAi4+mH6yufrLQ/KQ6Mn39oh25ZlGAytZs+BSPbYnM?=
 =?us-ascii?Q?Zw0bScNoTKj3U1xJK9ZnwzxoDrNWUb71uCXkvu8iTsWrDmA4oSE9kx5k3gZw?=
 =?us-ascii?Q?ImkBgJKAvuqrgJ/aFFCmpPC5bCSususPuKvlMlvY8GRufrZnUIBMEpG5xjPx?=
 =?us-ascii?Q?LroEWfgcxI1RnikHOU4WPHKhFaR5GEEexSgegCCvNDuRLJ1PSZX5f1c4K8yv?=
 =?us-ascii?Q?x1/iaO4Fln6p8LgqQ+wOHM05PMR/IZCVW7cfDAu+pkIEZffJCQSJ7FsGxSVh?=
 =?us-ascii?Q?LxKG21xIKO87uOnBKlWNUDO1w4eM0aGEH9O5XuOvTMmXfWVLudyGCjjAr634?=
 =?us-ascii?Q?T5zynPphwRxx+LVyHtOkAyYqgePDe4RAny9gbu0sWee9CIQDZRms1cnmgroT?=
 =?us-ascii?Q?FNYgYTN+ghNEPpIkm8DCLMNDABI2rt1ilT5fnad/FegwoWuQ3N3Uz3yC94if?=
 =?us-ascii?Q?zSMMDGNSiRqn0/nNOY14SRMsocIy9YA/7Wen5KwqoU//FCYTq8ef2d9+IatO?=
 =?us-ascii?Q?+gVKZMu7CZ4h5ru1ceP/oVEUOdChcx+OVsp6CNbEUQd7uvOEf+bKjucoJlXn?=
 =?us-ascii?Q?yHWv3zZ+xV0M5u9XQAWVKvnecl0ssT9tn9h9kg68AFRHx6dWWrtxLi2w3t9/?=
 =?us-ascii?Q?d1gLf/8zgsk2zORrZfIUBJtKTzPExjbKRag/+Sq0hDMimluG8pMSGufUHu8i?=
 =?us-ascii?Q?uZL70q8D8XttUOxpzpsxUfdNgMxxOlpRiAj11S7wyuF9rFV/QAqn9L1W5e+F?=
 =?us-ascii?Q?xHrNUroXwUzJtyfTYDK8JI8qjr0dtWE1atU6wrtIejlccyggI1M+K05i1SYU?=
 =?us-ascii?Q?ngGHZ2mgcpBKh0sGgFCdWUvmd0pZR6OfC3tKBtHbIvi6VzEvZy9fqkmsGGD8?=
 =?us-ascii?Q?xmEn/YW/g7V5fhBCil5o35rQI3714ft3eOPKTQZ9ckVQTanukS8B17KcK81w?=
 =?us-ascii?Q?oTtbZBYz8KyvYwNaPjiClmxUPrpJRYX7LYfBvJcBTlST0O7forZltm13CIHK?=
 =?us-ascii?Q?38f1PkBRl1471ChZcVnI40U+UJlzJkklYoyjFQMiY0AWQ5LVsVgiAgLapm+l?=
 =?us-ascii?Q?0Id7X5sw/ipFX6IrBywN350p0a2oEqhOC8QT1jf6dlA3QHfYG27PSRRsQqEx?=
 =?us-ascii?Q?ktvtrygsaT+slrP0oLoVD5qhCvNpSJtLz0291Ua4xavPsksf299FpT+whriZ?=
 =?us-ascii?Q?gS0S2qL7bpQVx/0Pj8fC5uclKbnLTfTN9HYZvPhodLoEyHpzVrA7CMOYUSvv?=
 =?us-ascii?Q?W3whZyrK1/QHYqTS3/5D/M24VcU9tZxCxBvVh734/b+sUfkr4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7828.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+CeZfGbwXKckSpPSM0cbu0i9Kl4uTfIx7hSYP5z3r0IaiCMX6CSwsTRHqIyY?=
 =?us-ascii?Q?Z12BK6dyO5xLFfzGHASx0AAyNQ41OSyDMBWdiYPkaG6d7gughWC0oWKUzKnI?=
 =?us-ascii?Q?S9gn6WLeD6ZRqSy5sHl6TO34GLDFeNkVzB4GORkRNliqZtB+MWQEULEAmMri?=
 =?us-ascii?Q?gQYXVWNRZ2u5bslj/x6O5bIAQiXCC6nwBk0/5kmf3ZjaOUE23YEhAvX0XG68?=
 =?us-ascii?Q?SrcDoII5DwF4R9Vvyinpj8p4B7JPhMEwwowB//hyzAmrYPJZQk3he7ohcG6O?=
 =?us-ascii?Q?DLvhw4/FIuhcyWOJd8qvc2SfEtt0bQMRJG/8ph8LHYFdMGexpHKwWifbbFR5?=
 =?us-ascii?Q?2ryC9rbDUq2/8UP7zJ3Y4noHGTUuS3HRl5hQzP4NpXL2ZX20txqmf7q+EL5n?=
 =?us-ascii?Q?peZCYSRYQ0DjDUoExPWaO+0J2tF8dKlR6JGUyL+lhthEUMQJftZgYg8pFruo?=
 =?us-ascii?Q?WA0wtldGMwykeeIWdHxOhovEF8C11uGsBFueMsUAx+4dtd9V8jqVNzMDtZxh?=
 =?us-ascii?Q?LB5bmNVir0j8zsJL96Gkr7YAm+tf9vw3JKoi5CiHRnQtz02KeH9ggZSLjO/T?=
 =?us-ascii?Q?TTPB8VBmPy1+Cm8LGJ5pGUVwwxKL7e8TB0+XHTPS8NE6ioFeyy0Fljm/7dQP?=
 =?us-ascii?Q?PrN7A7YZ9u7SqlAM/mnPhIuBoo48ySppa9xXW4bzuWM8onoFAQtDWIStvXcW?=
 =?us-ascii?Q?8WeUrviJmBmuth5DiNBvzdpx4+y0OJaOJ6LAxCJt6YpB8zE2+Jlkzk7N1L1m?=
 =?us-ascii?Q?/Y+deoEccY62/VfTnYqIGU5A6xAZ5n/5iUTVp7pqgiY9I4ohUu4f/+12sfHr?=
 =?us-ascii?Q?NIy42etsWtchJty+cHzzzvbQQHC9nGA0L4v0FQ8ktiCNdtDK9UTt/HleLsfO?=
 =?us-ascii?Q?GAlQJ6EGQLkD8+fj6c4mVy8oLhZzn2OMFfzNZS4RNVO8b5X70VRz06mMSC4H?=
 =?us-ascii?Q?3uEuvB0hdK4GK6HlGZbz9DY051i61DOLdOP/kWjKceBVFUcO4hTjKRCtdTk6?=
 =?us-ascii?Q?wGw2ESPvhEK/E28RJmN8cgaGfyzthKffzeSfl3CLZbWAiGiZ7o2mu0UYe5jz?=
 =?us-ascii?Q?KmiLMOV6I0LUuEIPrbhPRAYWVSVglR8lm641OQnEUXJfmuFrePjI7BAwm0Xi?=
 =?us-ascii?Q?ZU4yNone4xQ67fTi2U9DwOgoQ+VQCutTu9nMS0FsqziB/MXal5TP9R0MZ1dL?=
 =?us-ascii?Q?ZTl5g2QP/D0lyL7ro9Fdzd/3ZnF32339O8ah0ang+JJM93ExJ0+piaKP//vL?=
 =?us-ascii?Q?yWIXc0UWcU/LFjVgncz6b2UTCxt2jAkrPkXKOfKbl5fbH3OWzf2aV058qZS9?=
 =?us-ascii?Q?8xfQ/QC8z5su05ou04Fs15+6jz93Q14Cn+DN4yfvMMu27hgVJfTwaAUX/XXZ?=
 =?us-ascii?Q?CAkOdd+Eiv/zfy/rzDyS1/p84onPSt6lTNDsgxKl/AEHu0xDvXeZSqPiI0CC?=
 =?us-ascii?Q?/0r+EfGxqcNTzvHb+EW0ObKnU5BMtvZp9AjhhUypk482E86CPhxKVtj1V1jw?=
 =?us-ascii?Q?L0T2vQFitWs9tAPya4PP/a+FZP8a7KWn9EeKu1mgY8gIOLQm0GdntRMa+M8c?=
 =?us-ascii?Q?MxJ8AKN8zDCeGMS5IcKygBzoBW7Of6CkKwoPJNHI+ul5VD4qELt7HkIlXuVt?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1edcf0-b154-46c3-1431-08ddc9fe6a68
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:34:30.3407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6IQdlUksf+npsq8ZNndU3IQ4gycX2me+iwoW/M23Bl+JXwAdIG5fPSoC9N00EM3CFSzDrnihvXoR3T1ErnFV7y0l1Tea2wf4/Iq5j81pdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7402
X-OriginatorOrg: intel.com

On Tue, Jul 22, 2025 at 01:07:21PM -0700, Andrew Morton wrote:
> On Tue, 22 Jul 2025 21:34:45 +0200 Francois Dugast <francois.dugast@intel.com> wrote:
> 
> > When the PMD swap entry is device private and owned by the caller,
> > skip the range faulting and instead just set the correct HMM PFNs.
> > This is similar to the logic for PTEs in hmm_vma_handle_pte().
> 
> Please always tell us why a patch does something, not only what it does.

Sure, let me improve this in the next version.

> 
> > For now, each hmm_pfns[i] entry is populated as it is currently done
> > in hmm_vma_handle_pmd() but this might not be necessary. A follow-up
> > optimization could be to make use of the order and skip populating
> > subsequent PFNs.
> 
> I infer from this paragraph that this patch is a performance
> optimization?  Have its effects been measured?

Yes, this performance optimization would come from avoiding the loop
over the range but it has neither been properly tested nor measured
yet.

> 
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -355,6 +355,31 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
> >  	}
> >  
> >  	if (!pmd_present(pmd)) {
> > +		swp_entry_t entry = pmd_to_swp_entry(pmd);
> > +
> > +		/*
> > +		 * Don't fault in device private pages owned by the caller,
> > +		 * just report the PFNs.
> > +		 */
> 
> Similarly, this tells us "what" it does, which is fairly obvious from
> the code itself.  What is not obvious from the code is the "why".

Indeed, will fix.

> 
> > +		if (is_device_private_entry(entry) &&
> > +		    pfn_swap_entry_folio(entry)->pgmap->owner ==
> > +		    range->dev_private_owner) {
> > +			unsigned long cpu_flags = HMM_PFN_VALID |
> > +				hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
> > +			unsigned long pfn = swp_offset_pfn(entry);
> > +			unsigned long i;
> > +
> > +			if (is_writable_device_private_entry(entry))
> > +				cpu_flags |= HMM_PFN_WRITE;
> > +
> > +			for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> > +				hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
> > +				hmm_pfns[i] |= pfn | cpu_flags;
> > +			}
> > +
> > +			return 0;
> > +		}
> > +
> >  		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
> >  			return -EFAULT;
> >  		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
> 

