Return-Path: <linux-kernel+bounces-743051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53917B0F9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50626165A49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876E72206BB;
	Wed, 23 Jul 2025 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asxiudF5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13921FF58
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293845; cv=fail; b=eBmjybiqhzX3IJ3KI/VwakEDZrge5ZQq0TuqLIz9BZjqHjrL0/MGL1WJUvN61mOHOX6Fxt3OrF8nafAaYptkItILBRvteOI9rto1V/qzvGC4DsghULQ5h8LaakAT3GHq35vZha2PZDgaZhMqOI1u35vhr/a95l2R9+AHbkpxTQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293845; c=relaxed/simple;
	bh=F8x2O8VQX/3W0FKqcIzTu++mRQN/K2GLtfCyo5EReGI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NYM1OV4/vFJF7kmIJ1ze6M+0+/J6ggYiEsujQOvBeCUm6js0TxIPJpiEmdZ080ohUBbOG5joNmiN2okfRRZrIwO0vTxK4rBonsyn8ZJkIp1wQCl/TB1f+9TswS5BaWXrEa/ISPMcwkvA/9NLTqOWEZVq6C+5N/LdNiB5dR6KNXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asxiudF5; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753293844; x=1784829844;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=F8x2O8VQX/3W0FKqcIzTu++mRQN/K2GLtfCyo5EReGI=;
  b=asxiudF5lY7KBrN2Fn6L81E0mX6EwRe6Ld5hTvynfa0WDwmWeukVuAr5
   9T8/8OWxAr7S0OjTnZzuPrguJTiNQbKoQVsHF1rkWTqnUb+RzOiU9LAX6
   ZBHGfxkd/ypJGvN+6VOARi/wb7huSnWnwzP8WqvJM+pxcVL2D/5eqCMHA
   6+PzYafbl0YZhtIMIpyH/3tgum8GaDAee0bDFVWl1UnkWSu/vMwERNjT7
   Y/zXgMOU34QKNR6pKfY62BAZp9+lznleNnOSAau4WE8enqzSBgigMqjGO
   r2uTq9070AmFdc+qS+Jh+8+C3+2zjCc07l+JbJ1hrBB2Ju4HmKFqFX52X
   A==;
X-CSE-ConnectionGUID: fPFmJCWITEW4p6qwglGxdQ==
X-CSE-MsgGUID: cSaP4tSnQpOfAGYARTTDjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55701208"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="55701208"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 11:04:00 -0700
X-CSE-ConnectionGUID: amsjmIeZTvmqt3Lv5nU7tA==
X-CSE-MsgGUID: Xh03FLtRR8SK/XUiKJoETg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="160374063"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 11:04:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 11:03:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 11:03:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.73) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 11:03:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mR14p4Mpq/nJH2Ms/XCjMagCqXwuM+mNkrMLNQyWQi0fn2i68NmVxJSKL51jnF2iQFmPj52EIeZ0JhBMoylkKei257sirBv5hFAnSBcv3G0dDG7s2lHuyclxglFkZjSFFx7llJwsA/hj95lEB3wT3+Pg1+ZYVR608zvghAeKVrNUbqKx3BVB4e0y5b+jP6Y1MBMYfoM2zHFDmU66/n3ae3Z5FhoXj0MT4IaULq1zR+7GImfjyXeWCeXEaYlGGdn3NVg+CEjEh//rp2ls0d683hPCxZBE6mPTD9WPNPcjj0kXg64klRf6NYW+ma0GKG1D+GjNsIlp5O6WNn/ckdUS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsW65FY5tbPdlVgqjgbuVYxRbAX9Dkd2Kb5BN5u8Y4A=;
 b=wL0xmAGJSSmOkX7SlSNVDASMMmvUYQUMvwD34iU2q5xx8prU3WO1/av7CXCx1Um9HAEo2MjgkUIK1yNU1Cjypn90hkihclUW0KrMKGoBupqfFGwJAqo+LYNNGkZjg3eQvEfFh4ZZOZgOgJrjo52iJKflHn+jVEBqLqjs99QaJN87fGXT6Pw5TIYiODTbx70RC46wJytHPUkWpmrJmqmiww7eqyikMxZss7f+paX5bw1FR9roaRn7C8rwZaRZIgCD2ZH5kbqmyf16XEIaDpH72GzFPABLjqBxS2yWxzT8dKjZGIz0bO4HX4Irajv0xWGhIBwqTdHvyTDnZ8RNh6PiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 18:03:22 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 18:03:22 +0000
Date: Wed, 23 Jul 2025 11:05:08 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Francois Dugast <francois.dugast@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <balbirs@nvidia.com>,
	<airlied@gmail.com>, <apopple@nvidia.com>, <baohua@kernel.org>,
	<baolin.wang@linux.alibaba.com>, <dakr@kernel.org>, <david@redhat.com>,
	<donettom@linux.ibm.com>, <jane.chu@oracle.com>, <jglisse@redhat.com>,
	<kherbst@redhat.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lyude@redhat.com>, <peterx@redhat.com>, <ryan.roberts@arm.com>,
	<shuah@kernel.org>, <simona@ffwll.ch>, <wangkefeng.wang@huawei.com>,
	<willy@infradead.org>, <ziy@nvidia.com>
Subject: Re: [PATCH] mm/hmm: Do not fault in device private pages owned by
 the caller
Message-ID: <aIEkVEvNJwcegBF7@lstrano-desk.jf.intel.com>
References: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
 <20250722193445.1588348-1-francois.dugast@intel.com>
 <20250722130721.9169d564eeeb28807e18635a@linux-foundation.org>
 <aIEA-a5h3Zkx87EN@fdugast-desk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIEA-a5h3Zkx87EN@fdugast-desk>
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ0PR11MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: d27a9cbb-67c0-4414-3bf1-08ddca133640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzRITDRxZHRETGx3eWM4U2tWcHAwMG0vWlovSjhBMFJENVpWU052VlVlQmZ6?=
 =?utf-8?B?S0gxNDBYYkQ4VkZGSGRmUTFkQjI0L2FoUy9DdkFtdE4vWkErOFNjbkdhaW1a?=
 =?utf-8?B?ME1QZyswZ2RxbWplNnlQcTZsdm9aSUxQeUIrbk4ydWlDN2ZqTkdQbUw2SDI5?=
 =?utf-8?B?dys2azBJQzBYVnpQZ0E3UmhHblF3NGNKMnpwaTVoNHZSNE1OeGdOQUk1Mmoy?=
 =?utf-8?B?eTVHaHlTV0VaL1NGRXlxcVRDTkgzY3duQ0MrQ0s4ZytKWFZ4ekxYTkZMRTN5?=
 =?utf-8?B?RWd0RUNQbFZtZWR3ZDk2c2Nhdm1JR0tvZFRBWWk4Skt2YTFwTitXdzR6dEEy?=
 =?utf-8?B?Z1lscWN3MzRyYkN3a2hRWkpKNGFvZzkyNDA0WkFaRTRJV2ZZSTVlaGVXY2tC?=
 =?utf-8?B?dEx2UVUyNXlHLzlMTWphRktSWUZjZ0dXWFExY3QxNlc5ZzY1V1lFSS9IK2Yx?=
 =?utf-8?B?bjNFM1dGckQ0czBkOGJVcjdsL1A1NFQrZ3lTQ1VHOUtJemw1cm90MGtmdTZ6?=
 =?utf-8?B?Y0hlTHVWc2pabDY2VU5Pc0oxTGQ3ZDl0d3BKUHFUeTREWVNTajhrQ3lrbFVj?=
 =?utf-8?B?Q3pZY21acjF5dk1EYWZKa2NLKzArU1RkajRqUXJJRzdZeFpJVllNU09xM2Q0?=
 =?utf-8?B?eW11aTRYTjhkWi9NMVJPVFFMbXVOeWRtVkY3UWU4dVFYcS9adEtKcEU5VEpZ?=
 =?utf-8?B?NVFCMXRGUW0zR09wRUIxd1hjRmUxQlhMNEFsdlJsbGZQdldtS2lhRXZUVldN?=
 =?utf-8?B?NTd0SXoxV1JnOU0zS2V2QVZIdDNMVGV5b05yN05qRU93SUoxRlcrcXpNcHls?=
 =?utf-8?B?c3pFaEtycXlQczFhU21iT1VJQ0ZpYS9lVFE2MENHa2ZVQjMyeGxVY29YSS9J?=
 =?utf-8?B?enJETml0aXFCV1VuSDFnWCtrZElOdEJMYzZrOU0zdmxRbnB3N1BMUnlCeU5m?=
 =?utf-8?B?MCtra09XRnZuYVNIa2loOUdNMXlwN3YzY0RXd3UwUllBdTI4bENUK01rYmt4?=
 =?utf-8?B?RTYvSUU2bGgwc3E3dWE4RWduQ21DYjY5RTg2c0VpYndGa0VwUGF0ZzlGbVpU?=
 =?utf-8?B?UEh2WmhiM0NldGFRMXJWRW0rYWpsQ2wwdDJLK3FnRDlyZGd5ZWJMaGYrYVVu?=
 =?utf-8?B?bWJ0SURrZCtOc0M4bUk2WUxibTlDemlJcjF2c1RUY3orTG5uYmNRRmQybkg5?=
 =?utf-8?B?NWtFeVZGSWMyZmdIT0k5MFFmMGhhNExsb0lCSXFweCtJUlFlSjNROW5xNHZk?=
 =?utf-8?B?R3ZxbFJKOVBiL2orMHFiRzJsR2U2cXhERy8xNGIya1ZXQkRtNy9OL1FzY1o4?=
 =?utf-8?B?SnJIZi9lcXQvZ0ttd1JWWWJGbWlXWHFZcHB0NzVTTm9ONHNqYzYwQ1BoOGdV?=
 =?utf-8?B?cS9uNkNuRlRCK2IydVY0c29tRTU0NUNNZXd0V2htaWxDZDNhTzRlSTVZdVRw?=
 =?utf-8?B?WHNKeXYvR1pxVk0ydTl5bXpjcnY2T0o4eHRmNENjY3VkYU5CLy8vK3o1eU9Z?=
 =?utf-8?B?TE9BeUFqdjZaNjNwSXNvWUhjb3EzVzVOdVMwdnF2VkVJSW9NMmtoRkhOWUht?=
 =?utf-8?B?a24vbjNIdnNqSGgxdWhhR0dGUkJ0LzA1UEt2RUJIMEZpb01XR0ZDQlJvMWVH?=
 =?utf-8?B?MzZlcWhlNlVCY0E5cVVxOXhvdHo2Skx1c2ZKdmkyOThhci9CckxkdEpzQThQ?=
 =?utf-8?B?anlnZDZSbHNjNFF6cHNyTlpMc2huRFVjalVUWUJocjdlSDc2TUNXT2o2SjVF?=
 =?utf-8?B?ZFcveUh1bFhPTkdhTGNlUFJNYW50aUNCUXdldm5LNGtXTE1mN0o3LzNxNUN0?=
 =?utf-8?B?UExFZE51SjVFbUM2c3RLdllTMmhnSHhTNmhTWnFhYzdYdS9RTWFld00xR1VG?=
 =?utf-8?B?SCtocnFoNmJaZjZUenI2d3BPYUxGK3pCVEVSbkJKQU5pbnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDdNcmtKcWZrajhwVkxSS054SENEV25xellENDRnZTBRd3Y0WVYrKy9POUtN?=
 =?utf-8?B?T2h1U2ZuUFRYQklHM1RqZFUvOFFzU0p4S1ByOFl3bXhmcmt0MjJRRzh0WlNJ?=
 =?utf-8?B?emdhcXM1OVVzZk45WmwveE02bEc0KzhpRnZPMnJQQTVvUlNaSFFUQ0lycnZ0?=
 =?utf-8?B?ODU1N1BPK2lsTXpRekhyVG5DQ29xdUVQNEdBZUJpaXNoeFpRS1I5cjhUM3Q3?=
 =?utf-8?B?UnF3YlIweEVVYTEydmYyUEQ4a2dVNC9Ccys2K2dRc0ZRMCsyRG43dHA0dXpT?=
 =?utf-8?B?dHZoVzNvbWU1TzBRaHhYUlREbHFwK09ML0laLytWVmNMNWVTM2w5WHUrNFps?=
 =?utf-8?B?dytENllydkYyOWxCUkpTcnRSbXFnbWxUQUluOWZKQUNpbDZuQkllM1lja3U0?=
 =?utf-8?B?Vnl0WEdDMmVSbERFUktkMzRwcFFHR2JNczNERC9kNkFXTnRDTFFLdFk0cFFu?=
 =?utf-8?B?NnFaOGQwcURjZ1BCeWk4SllQTHNoeGJzY2kzdDlEaWZkZkNZTkJKRFl4NlU1?=
 =?utf-8?B?VVlsaGUycllvclVqdUt6K3ZCRENlTktmK0tjSHVHamJIbVdrWE5BdlMzaHFN?=
 =?utf-8?B?djlFcCtWd1lDSGJucHE0V3d2UEZyUkVhc0ViSDdhV2VnM3dkbGQ3WEg3Wkh3?=
 =?utf-8?B?ay9kZzErVW0wdG92Ums3WDNqSHpmRkpGcHV4a1QyVWVpT1lEWEJqY3MwOUhP?=
 =?utf-8?B?M1NWTEFTVGNzdjI5TW5PemdRQ280Nzc5WGF2cGhtWGxCV0QrUTMwY0w5d0Jt?=
 =?utf-8?B?N05tQ0c4a3llRm1qRE1MSHBuL3RiRlRuSVFOQXNqZW1XdVJJaWljZ0Uxc3NM?=
 =?utf-8?B?MnVJVXcrUmVSaDMrenFWSWRVSndnRHROeHowNHN3Q0lHYTM4SlBqK040dk5C?=
 =?utf-8?B?b2o2RzFFbnEyVFEyeTJsbmRCTWtSQzNTWml3alV1WURJdW43NFp0ZnFQSm84?=
 =?utf-8?B?NHhSblJxRmpqMUxLZDVhamZDTk40VkNNeWpuOE9uUHdUZ0VUWldDQ1hZMlJ1?=
 =?utf-8?B?QVN5WmtlT3RmUWJBSEJudUxwcTZTa1U4bnhlTWR3ZytySHRRQ0VMTWVHSUFu?=
 =?utf-8?B?NGZ4VHlsbWphcldSNWdWOFFQdVQ3aTUzN0ZJWUw4a1B3dWV2V2RCTFRZQWdy?=
 =?utf-8?B?UVBGbjNyQUNna2dJaENXUFdtL0sxMDVrU05HbDFDRGZBOWljV1NqYzlYNVVP?=
 =?utf-8?B?b0hJNDBYcTVMMWFVTTVWWlA4K252aklLVkthcE9YdXJiK0dLNG9XTjlXMDl3?=
 =?utf-8?B?eUdQSzQ2STJtdFdJQmZjcDBGVGtIQ05rdmtKSG55anlQOGlScVRxQVorRlRI?=
 =?utf-8?B?QVNIampRVnZ0TkFTWU81UitPcDFYS0lpRFNPL0Jndk9xSVliOEdZbmpWa1BR?=
 =?utf-8?B?MmxtZWc0ekJJRVhJRHFFb3RQaDZqdDVtSzR0dmNLcC9xY3hmVjVFTXJCQnhD?=
 =?utf-8?B?bVI1bXl4QTdGWEhlY3ZVL044VEZtKzAwL3hCckE1akJOT1o1N29vbXd1T0x4?=
 =?utf-8?B?WTQwWU9aU2wzeXJ6a1R5cVNURzlaTTh3STBpUjJHa05YeWtGVmt1WnlpZEtJ?=
 =?utf-8?B?eGtraDlDaGtnR2gzckdMSFZCbXFldmhoNWhXbFVhd3habXIrKzlkd3pKYkda?=
 =?utf-8?B?UnhDazB4bnI4MGtpMC9qdU5JdWJRRHVGY0E4NG1Qb25UR09PQnplNUNVK1Z3?=
 =?utf-8?B?RUZRVWJNell0NmNDRjBsTXpCSDNqSTMvWjJrZXEzMmdodVZEbkcvTTlKazI0?=
 =?utf-8?B?Tm1ONllOUXYwQVgrU1Q4bVkrRFhpeVl1OG1UQUVTV1dUTFllQ21nbExISURu?=
 =?utf-8?B?NXRXVTkySkpSRmhzdGtMK2RCVHVYUElqam1PWFZ5b1ZYS3doSndxNjlXRU1M?=
 =?utf-8?B?VEF3czN5ejI1ajN6MXplTHFZbHlRcENneldVQmh2eGd3MExEc25tTWJWMFUy?=
 =?utf-8?B?ck4yaXI3QjB0ZUlaTkZpVG5zY2ltZ0pFYThQbXFGVjVaWHJMYlc0TytJWHhM?=
 =?utf-8?B?Y3ZBU0c4MzBDK0tCRzJJaEZFRGtMeW1GdlBNajdndFJnb2QrSjJVOWtMekFK?=
 =?utf-8?B?Nm9NYXBtaC9kb2FUZlRyWk5TQmRtRHdjM2MwTDNxeG80MUIyZ1B4YXV3TTVO?=
 =?utf-8?B?cWtkSXQwSTRKU2lMQ1VxK3RubUtmNHA0cEZBR2VVOGxoK2wvRHdsTm5FSUlT?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d27a9cbb-67c0-4414-3bf1-08ddca133640
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:03:22.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3570ZIcP988gGzuFdwTwmWUlYQNB5liz45iwyatZncWpeIt3vGm2pvCb6LN6/NbbBJl+RbdGruj9V953mJWFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
X-OriginatorOrg: intel.com

On Wed, Jul 23, 2025 at 05:34:17PM +0200, Francois Dugast wrote:
> On Tue, Jul 22, 2025 at 01:07:21PM -0700, Andrew Morton wrote:
> > On Tue, 22 Jul 2025 21:34:45 +0200 Francois Dugast <francois.dugast@intel.com> wrote:
> > 
> > > When the PMD swap entry is device private and owned by the caller,
> > > skip the range faulting and instead just set the correct HMM PFNs.
> > > This is similar to the logic for PTEs in hmm_vma_handle_pte().
> > 
> > Please always tell us why a patch does something, not only what it does.
> 
> Sure, let me improve this in the next version.
> 
> > 
> > > For now, each hmm_pfns[i] entry is populated as it is currently done
> > > in hmm_vma_handle_pmd() but this might not be necessary. A follow-up
> > > optimization could be to make use of the order and skip populating
> > > subsequent PFNs.
> > 
> > I infer from this paragraph that this patch is a performance
> > optimization?  Have its effects been measured?
> 
> Yes, this performance optimization would come from avoiding the loop
> over the range but it has neither been properly tested nor measured
> yet.
> 

This is also a functional change. Once THP device pages are enabled (for
performance), we will encounter device-private swap entries in PMDs. At
that point, the correct behavior is to populate HMM PFNs from the swap
entry when dev_private_owner matches; otherwise, trigger a fault if the
HMM range-walk input requests one, or skip it in the non-faulting case.

It’s harmless to merge this patch before THP device pages are enabled,
since with the current code base we never find device-private swap
entries in PMDs.

I'd include something like the above explanation in the patch commit
message, or in code comments if needed.

Matt

> > 
> > > --- a/mm/hmm.c
> > > +++ b/mm/hmm.c
> > > @@ -355,6 +355,31 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
> > >  	}
> > >  
> > >  	if (!pmd_present(pmd)) {
> > > +		swp_entry_t entry = pmd_to_swp_entry(pmd);
> > > +
> > > +		/*
> > > +		 * Don't fault in device private pages owned by the caller,
> > > +		 * just report the PFNs.
> > > +		 */
> > 
> > Similarly, this tells us "what" it does, which is fairly obvious from
> > the code itself.  What is not obvious from the code is the "why".
> 
> Indeed, will fix.
> 
> > 
> > > +		if (is_device_private_entry(entry) &&
> > > +		    pfn_swap_entry_folio(entry)->pgmap->owner ==
> > > +		    range->dev_private_owner) {
> > > +			unsigned long cpu_flags = HMM_PFN_VALID |
> > > +				hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
> > > +			unsigned long pfn = swp_offset_pfn(entry);
> > > +			unsigned long i;
> > > +
> > > +			if (is_writable_device_private_entry(entry))
> > > +				cpu_flags |= HMM_PFN_WRITE;
> > > +
> > > +			for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> > > +				hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
> > > +				hmm_pfns[i] |= pfn | cpu_flags;
> > > +			}
> > > +
> > > +			return 0;
> > > +		}
> > > +
> > >  		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
> > >  			return -EFAULT;
> > >  		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
> > 

