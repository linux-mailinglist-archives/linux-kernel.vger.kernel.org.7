Return-Path: <linux-kernel+bounces-748724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3E6B14558
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D5217CA95
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD3A78F4E;
	Tue, 29 Jul 2025 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UedW6xuo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75778C91
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753748972; cv=fail; b=L7rJjcx5OrTxZT0mTZRwEPwOM0OPJClzC3r3V8RuvCuBuBrPAYAJ/GXGda84YD9nTtM37vicfY24Z8QLQU371RRolSZ/FqcJSFFn7LVSiD4/eFNICphZX2h5ABrbsNG6Ds59TN3q0OPxDqGNs2eP3C30Ld0OoBPpU8qzcyEGYFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753748972; c=relaxed/simple;
	bh=iuzH0rNFyfOB1U+BmlPhBnQUxqf2OIe2a78KC0vxSsU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=I7l3PISsLbE35ioJWbR5go4jRGu8fH4m2pZhh6amOVodlambdGY+3uUJCyFsyomo8KesUY10gF4lWIbAb5y4eeOJc86XGKcCHKfBZAylWgb7uwJfwKSFc8UZbYHBMQg27/GLnmQ7ZvvKG2DK8mkCtnBpUsGvlGGq85QhBgiN1kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UedW6xuo; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753748968; x=1785284968;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=iuzH0rNFyfOB1U+BmlPhBnQUxqf2OIe2a78KC0vxSsU=;
  b=UedW6xuoVukj0gU5J58ztLWk3pq7ceNEiqtuYM1Hm9VbDxtM7WUneQcG
   2GZBtrjKJ+gpLWOxjmfK6nPJfELtLlJhYt4zAG8WqoBpAFA3gFnms3Jg9
   THNsqTSE8FnSEIEK9t+gbINdvcCczRZpPjT9WFbKRXxd/Z09kur/+HReC
   aR/MQIuGEKUet8Eevov+9XRJPAuSOFblduyFVRJuI+YKQcI01r4Bn93TZ
   +VOX7W5CE8/krXA025eBOn2wgY5zgG61pudOy5bmmIKcZh50I+H3f1kr/
   b6TNR9fcJgu7PKrG7PT8H7D/+jchHobpFXof2iKSaA2XWVNENQqMLcAey
   g==;
X-CSE-ConnectionGUID: iSabcJYWTluKExs7itf6jQ==
X-CSE-MsgGUID: tml3Vt6mSqC0X0ylr0nM1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55889455"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="55889455"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 17:29:27 -0700
X-CSE-ConnectionGUID: 6kIA5WCPTSaRpDZ30dXYDQ==
X-CSE-MsgGUID: xcM5dBYPQK6kQu8VEDY44Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="166762663"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 17:29:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 17:29:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 17:29:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 17:29:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIipWBm+HvPTzPWXUwxq+z938Vfs98W47a43Cs1ZiqZLxi5NkbqE4DpHrg7xrBxfr+NCswP1eNN64MZ3MndrbIQh9OJ/d9qBBPR8OF5OwH4+dPONTCi+Ywc6Bi/wbQC7jB1kEgrCWKETskaqZMEeUV6Q+jWDrLfmB7T4da9NRIPDlZ1xJQ+nVQSqrWv3t3D49ppjPtc9+9GjvZI+XnFYslwgVSTTesl0eXRbraNdV33ZVI07mXHFZMrvbpoQz0NOzmFxPTjvm9sE/afam/WwGzKgHp+biR+cNCVTUYywlpoTX4I56Ty1lPv5ybCLAqhcyoXDO5gS2EmfStVWR47QLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXOZtbtJqXJ7BdFidglTAEsMs77fXto1W4VCtAQNa1w=;
 b=PB2wbKhQGSaQvW38ky+FsB4IJF0jUbXaX/Fsc8l0gsyKI7JYBVo3yFJ5u4ci6eOkl0ZwrCw+ULo7P8f2fdQWn0gOqNKSxXnLW27hnYhpHiFeTOsZ/srVrKHTcNv5aZZ5NH7E4KSiQhWmUOPxIEgCxFMz4XJukMayz71E/QxtADIXbocgZgIT1GpA+G67U0ecGumCDuTXdN/SyGGmB/VqX9edAbQgXpHq7dyOGswU3pcuIn7O+fNo7PP2f7UlUr1QfsYNzMvCpFGZtIDcgF4WqFum3jB+GvXqC50CxkVsiUy3i2ScfEC6buQqLWS55ZtxoJ5N1uqgYCMxOqhA59/iSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB8225.namprd11.prod.outlook.com (2603:10b6:8:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 00:28:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 00:28:55 +0000
Date: Tue, 29 Jul 2025 08:28:45 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chris Mason <clm@fb.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
	<vincent.guittot@linaro.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched/fair]  155213a2ae:  unixbench.throughput
 20.2% regression
Message-ID: <202507281046.e71b853a-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b35294c-c544-4ddc-dd6d-08ddce36e5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?QopKAI/MF12PUiZqEKdr8EBmDMR1zsE17huoK8MdboRC7nkr0gLe0jYVnM?=
 =?iso-8859-1?Q?KBnMBGw8/1SWE7jtIPQGW4FNJ732soRDPvDsV406GDc+4wKr1dwkMpf4hw?=
 =?iso-8859-1?Q?dkHOYryf7Pd8yAgRluH052nSn2CiCL7I2NQ8dFWV9g43Mytn9Y4EM9n8Bl?=
 =?iso-8859-1?Q?rlejc8MDf/eDqnBrv0vsOgpcnqO6aobA/aYKqRL15/vqKR2l2AoiqT9HPS?=
 =?iso-8859-1?Q?R0pVC3nYfb7+SXGg5wigi704j/Ab6NOST4LTYqfvPpbAy6Bbh6dXOOQp1T?=
 =?iso-8859-1?Q?3HU4VcHsw+WP6V0PHca2GIme+b+Kk517IDFzIe7E2DIqzEnkantzl6Vbs7?=
 =?iso-8859-1?Q?sR7KnlEvGU6M4d0fYrOECBG+GN+CVV3zhnVCt4r4Uw0Fn/V8iQRFYiQ5Fg?=
 =?iso-8859-1?Q?RYDrhG+BH5TmCWM4ldaj3LFe62C1gjvdWd5zDNAnIvCdunJGpOOqzEGP7J?=
 =?iso-8859-1?Q?O9M89iUD3crRwRT3NPQzoH2KQNrn40pQuDBKmFqBn59fD5E2crPOswdYj3?=
 =?iso-8859-1?Q?DE+lGJyoYBsDx0arwQkZXr1hR4Juz2XnI7VJjjcunOAUFCzcLEIRfOoxEt?=
 =?iso-8859-1?Q?lUKtSY4fkqb0Ti496HZ2/SqlsJeAKZlj68K9S3JoWZS2Z+UFn6P4KKg28U?=
 =?iso-8859-1?Q?1gZyk9NO7x3g8xHG8AtJ6K1bY8KpOf6BII/RoD4Xfe0d9ENd1BHXdKjlLj?=
 =?iso-8859-1?Q?p9kVSNBXGCERlRxhXYSR6SJi8Bn9ZS5fVAhrIU8gvDnQfesz13mB89C8AU?=
 =?iso-8859-1?Q?T2CB1L2AjMlRwKBldjRjMtvq2lr0H+O04ncuPHFJm1VF3aKTZ7F3wSPOWQ?=
 =?iso-8859-1?Q?JsJWWhRJU/IGnmrVBcv0mb7Qx8V578JBqiH4AKKkyA6k7Ro8iN8A7IyZZ9?=
 =?iso-8859-1?Q?tkAzE8Q/SWCRHJQKK7mip0BuyPhzhnxPeh/eZ+EgaAAocF8sN8bvC7CXp/?=
 =?iso-8859-1?Q?Hp89L2SI9TEoEpgIUkk4PZgkRv+bvpPjNhceTwcHKIyWSyhvFcJBQ9hb5N?=
 =?iso-8859-1?Q?D0uslNXflbNxi7QtJCpuIC7BHN/S245cpOrIK/EKvbZEkXYOByFsITZ75K?=
 =?iso-8859-1?Q?sz4k5o9zqstmeK1mCue/uZFR5wQJPSF2oNWY2bR+8QJ6rgVKAPeAdkh/y+?=
 =?iso-8859-1?Q?mWIAa69DIi/w+lljP2zEHhNkRqqTf8968r55dxhDaksmAKi70kFXApINvI?=
 =?iso-8859-1?Q?ds86smKxPtUIb4e8x1boe4YNI3rljHfYzsotjASG/htw3gCjC8QuBns0/e?=
 =?iso-8859-1?Q?F9Dza4FcD0PRlkgS5bKANQm0j2OENjHyKSg5mDKPIApK4ldp0qQlkZUmhS?=
 =?iso-8859-1?Q?2YhMxER8R1g+0OqUA3zZlJCmzFC4GAVvqmPfNps/fnZ2LtnBi9IUyOlKxh?=
 =?iso-8859-1?Q?Tmx9ZdQJjovss9+E7wS7bi6jyGvYbr4uqr5kiVhl/PucudLT/nRj+m4Ohd?=
 =?iso-8859-1?Q?bORCLsX1ABxdDEop?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ckz1mXCf4Rt9LoqsIbdZqz1A6Q96QNtrtqKftDKQC+/4taFyOX4FhUlocp?=
 =?iso-8859-1?Q?W01mbpAHO1mpDBahgnGxoQ+d7FD9boWdHhMjYZh/Q/jBfbWfuCurFqgyXI?=
 =?iso-8859-1?Q?ABs5OUWJyuNq0uBgwuG/m4TS2y3DdGkPY4ew+gQf3H8Syp5jBKv+k86jya?=
 =?iso-8859-1?Q?clPS8fS0JXDxcsFvR/ZBWnt7mr6yznkMLESMqy0dHb7TQCwtZe6yXXDUCJ?=
 =?iso-8859-1?Q?LknV31Ushb3CiAzFxvv81Yj90hCy76BpntbXizeu1mFEaNwyXH9D07N2bZ?=
 =?iso-8859-1?Q?OdfI24e4mHPOq4Yf870c0o/QmE3+wiw8V6bG9Q9M4Y70ul+FmZDLKRfJKL?=
 =?iso-8859-1?Q?eBEKiqLNXJyb6VMUcDxI4kxq0hSZekYwg+7vCRa/h/kGHPD7Pb9XcaSSAC?=
 =?iso-8859-1?Q?7OKi+IQAAlyhFu+EmU2PiaQS0aYBv4v3HpTNjsJCizQCB9ObUzkYe1P1ZV?=
 =?iso-8859-1?Q?BQ4Nturc+tavDmloJqJmGRMOZmvUe5c6yoh3k3cRTH+sndSqkkBtpuGS5b?=
 =?iso-8859-1?Q?t+l+6luZUs6ZvPcICH1P+7q9ckna1uFKq5p02a9HcYjnPz/sOsaicbo3Ww?=
 =?iso-8859-1?Q?u3jDc0Pqg0OxOweaYVTdHFoQfv/ezmYK/Znzr3b3KTmmztdhvgmChMvooa?=
 =?iso-8859-1?Q?jE4dA9xZCMX3Y9idXju3W4FrWl/0jCawJ6XCcxxONQ5IbC+NqNrhxU0Wip?=
 =?iso-8859-1?Q?Ot1z+U23QayxcRxN2lEHxGCbT3j5xfs1nRh7YGmeibg3KhZ4ag0U+6G3fw?=
 =?iso-8859-1?Q?AYEP9rCSlp3vPFMUkTrdx5BQCKDClBMRM6VDU8I2ftolGCf6rN4/QVFX91?=
 =?iso-8859-1?Q?Vo13El2wn5eihjrfbxPK9u/WqzF+u2HU2MNZ8e664G5BsjOOupOyIY69SI?=
 =?iso-8859-1?Q?YwcXgJuefh0idpMBZaXYr/urHcoiPONu6J/5S0gKznw88l/WxJldntCNfx?=
 =?iso-8859-1?Q?J4FTc/cnqrVZwI+4c1/hHHr2Sne+WJFbi4HxNVzg1qLP/1u3NwRoFykKxy?=
 =?iso-8859-1?Q?iN5uKWh6OzV/ziIFZcOVDk/T2tk/tJq+kdKSsSSTY4LKxaJ+WHYKerCCmu?=
 =?iso-8859-1?Q?BLdx5X7h5WbdrO4ZQxptODIwAC4EcNPFgoVtDreE2HPGCqBX1flOXLiXca?=
 =?iso-8859-1?Q?6e9B457SaGP+C2Mr9QBfjFpzJ4R5DGIl3jkyN8EvTWG02kwUJEapDlD5Yb?=
 =?iso-8859-1?Q?R9vrhotZvnBOCwm9/LvcdOIIknBxEQgVQEaz8TJ5azYpmioQezp/0+O8pa?=
 =?iso-8859-1?Q?2QG1HE/BzZN4yMFrzze3x0DHj1OM6C7zURgjjVD0VztgYzyU2G/GZf7NFn?=
 =?iso-8859-1?Q?oUKX3a8UJaTEB6Kf52tfQRihZPOPtLnkZboYYD7kYO8wfOdtmGd8f+Mif+?=
 =?iso-8859-1?Q?m1IAPJPEKJZns8nSKxE3D8mlF3ttC1FMcaZXfFee7D3zVmJt2Lxwwzkwa1?=
 =?iso-8859-1?Q?7Y8wNwkgCcD/OZ0TpO3XsP/s9vsgUlOdMfaEUkIwvSlo1ue9iKEI0Xw6EH?=
 =?iso-8859-1?Q?7rQwZ4EUhA8F/JlT4MSYVdTB3nUYuDOfgmu3l5tAwlJtnUhFc4G2w3Rxt7?=
 =?iso-8859-1?Q?7mJkDPH7t/wSllQ1g0XnlhqtOsdJ1fBacvLhPWTzrTC9ZBvzJ6EbYNE9WW?=
 =?iso-8859-1?Q?0532CBsxdwL4+Ud5KldfHSPvLTEafVy/QILq14J0QJCekxLfLboaO6RA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b35294c-c544-4ddc-dd6d-08ddce36e5b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 00:28:55.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jnkc90T/SSH4JYADRnig8Jteq2oaFZESPUj/Uv/801e9VoJcSYEkYuboodoy7ytzFX4MOH2tf8O7vJ6KLxm+xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8225
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 20.2% regression of unixbench.throughput on:


commit: 155213a2aed42c85361bf4f5c817f5cb68951c3b ("sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core


testcase: unixbench
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	nr_task: 100%
	test: shell16
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput  22.8% regression                                              |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory      |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | nr_task=100%                                                                                   |
|                  | runtime=300s                                                                                   |
|                  | test=shell1                                                                                    |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput  26.3% regression                                              |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory      |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | nr_task=100%                                                                                   |
|                  | runtime=300s                                                                                   |
|                  | test=shell8                                                                                    |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min  1.6% regression                                                     |
| test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | nr_task=100%                                                                                   |
|                  | runtime=300s                                                                                   |
|                  | test=custom                                                                                    |
+------------------+------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507281046.e71b853a-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250728/202507281046.e71b853a-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/shell16/unixbench

commit: 
  d398a68e8b ("# gpg: Signature made Wed 25 Jun 2025 12:55:36 AM CEST")
  155213a2ae ("sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails")

d398a68e8bcf430e 155213a2aed42c85361bf4f5c81 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1743092 ±  7%     -19.5%    1403053 ± 10%  numa-meminfo.node1.Shmem
     16565           +46.5%      24271        uptime.idle
 1.461e+10           +52.1%  2.221e+10        cpuidle..time
 1.677e+08 ±  3%     -21.2%  1.321e+08 ±  2%  cpuidle..usage
    129992            -9.9%     117159        meminfo.Mapped
   2737656           -11.1%    2433270        meminfo.Shmem
 5.275e+08           -20.5%  4.193e+08        numa-numastat.node0.local_node
 5.275e+08           -20.5%  4.193e+08        numa-numastat.node0.numa_hit
 5.245e+08           -20.4%  4.177e+08        numa-numastat.node1.local_node
 5.246e+08           -20.4%  4.177e+08        numa-numastat.node1.numa_hit
     36.39           +50.8%      54.87        vmstat.cpu.id
     52.82 ±  3%     +16.0%      61.29 ±  5%  vmstat.procs.r
    611743 ±  2%     -37.0%     385194        vmstat.system.cs
    495119           -38.1%     306537        vmstat.system.in
 5.275e+08           -20.5%  4.193e+08        numa-vmstat.node0.numa_hit
 5.275e+08           -20.5%  4.193e+08        numa-vmstat.node0.numa_local
    435783 ±  7%     -19.5%     350787 ± 10%  numa-vmstat.node1.nr_shmem
 5.246e+08           -20.4%  4.177e+08        numa-vmstat.node1.numa_hit
 5.245e+08           -20.4%  4.177e+08        numa-vmstat.node1.numa_local
      9398           -15.2%       7972        perf-c2c.DRAM.local
     29225           -33.3%      19484        perf-c2c.DRAM.remote
     21976           -35.0%      14294        perf-c2c.HITM.local
     15468 ±  2%     -34.1%      10191        perf-c2c.HITM.remote
     37445           -34.6%      24485        perf-c2c.HITM.total
     36.22           +18.5       54.74        mpstat.cpu.all.idle%
      0.00 ± 32%      +0.0        0.01 ±  5%  mpstat.cpu.all.iowait%
      1.24 ±  2%      -0.4        0.80        mpstat.cpu.all.irq%
      0.66            -0.2        0.49        mpstat.cpu.all.soft%
     52.24           -15.0       37.20        mpstat.cpu.all.sys%
      9.64            -2.9        6.76        mpstat.cpu.all.usr%
     70.44           -25.5%      52.47        mpstat.max_utilization_pct
     10050           -20.2%       8018        unixbench.throughput
  12079997           -17.4%    9977617 ±  2%  unixbench.time.involuntary_context_switches
    618017           -21.1%     487711        unixbench.time.major_page_faults
 1.245e+09           -20.4%  9.909e+08        unixbench.time.minor_page_faults
      3790           -26.1%       2801        unixbench.time.percent_of_cpu_this_job_got
     18727           -26.5%      13769        unixbench.time.system_time
      5248           -23.3%       4026        unixbench.time.user_time
 2.228e+08           -42.0%  1.293e+08        unixbench.time.voluntary_context_switches
   6353777           -20.2%    5072851        unixbench.workload
    903225            -8.6%     825615        proc-vmstat.nr_active_anon
   1597356            -4.8%    1521116        proc-vmstat.nr_file_pages
     49399            -3.4%      47698        proc-vmstat.nr_kernel_stack
     32506           -11.2%      28854        proc-vmstat.nr_mapped
     36270            -4.8%      34518        proc-vmstat.nr_page_table_pages
    684360           -11.1%     608318        proc-vmstat.nr_shmem
     28530            -1.4%      28121        proc-vmstat.nr_slab_reclaimable
     57039            -3.0%      55312        proc-vmstat.nr_slab_unreclaimable
    903225            -8.6%     825615        proc-vmstat.nr_zone_active_anon
 1.052e+09           -20.4%   8.37e+08        proc-vmstat.numa_hit
 1.052e+09           -20.4%  8.369e+08        proc-vmstat.numa_local
     68543            -1.3%      67625        proc-vmstat.numa_other
 1.092e+09           -20.8%  8.653e+08        proc-vmstat.pgalloc_normal
 1.255e+09           -20.2%  1.001e+09        proc-vmstat.pgfault
 1.091e+09           -20.8%  8.646e+08        proc-vmstat.pgfree
  62188682           -20.5%   49465596        proc-vmstat.pgreuse
     53492           -20.5%      42531        proc-vmstat.thp_fault_alloc
  22570890           -20.5%   17937730        proc-vmstat.unevictable_pgs_culled
      3.59           -18.2%       2.94        perf-stat.i.MPKI
 1.625e+10           -25.1%  1.217e+10        perf-stat.i.branch-instructions
      1.57            -0.2        1.40        perf-stat.i.branch-miss-rate%
 2.505e+08           -33.4%  1.668e+08        perf-stat.i.branch-misses
 2.894e+08           -38.9%  1.767e+08        perf-stat.i.cache-misses
 1.186e+09           -39.1%   7.22e+08        perf-stat.i.cache-references
    613742 ±  2%     -37.0%     386739        perf-stat.i.context-switches
      1.90            -4.3%       1.81        perf-stat.i.cpi
 1.523e+11           -28.5%   1.09e+11        perf-stat.i.cpu-cycles
    223407           -63.9%      80733        perf-stat.i.cpu-migrations
    535.12           +18.9%     636.17 ±  2%  perf-stat.i.cycles-between-cache-misses
  7.93e+10           -25.1%  5.942e+10        perf-stat.i.instructions
      0.54            +4.4%       0.56        perf-stat.i.ipc
    982.38           -21.2%     773.91        perf-stat.i.major-faults
     73.67           -24.7%      55.47        perf-stat.i.metric.K/sec
   1939561           -20.5%    1541837        perf-stat.i.minor-faults
   1940543           -20.5%    1542611        perf-stat.i.page-faults
      3.65           -18.5%       2.97        perf-stat.overall.MPKI
      1.54            -0.2        1.37        perf-stat.overall.branch-miss-rate%
      1.92            -4.5%       1.83        perf-stat.overall.cpi
    526.36           +17.1%     616.57        perf-stat.overall.cycles-between-cache-misses
      0.52            +4.8%       0.55        perf-stat.overall.ipc
   7895095            -5.8%    7441118        perf-stat.overall.path-length
 1.623e+10           -25.1%  1.215e+10        perf-stat.ps.branch-instructions
 2.502e+08           -33.4%  1.665e+08        perf-stat.ps.branch-misses
  2.89e+08           -39.0%  1.764e+08        perf-stat.ps.cache-misses
 1.184e+09           -39.1%  7.209e+08        perf-stat.ps.cache-references
    612904 ±  2%     -37.0%     386147        perf-stat.ps.context-switches
 1.521e+11           -28.5%  1.088e+11        perf-stat.ps.cpu-cycles
    223102           -63.9%      80621        perf-stat.ps.cpu-migrations
 7.919e+10           -25.1%  5.933e+10        perf-stat.ps.instructions
    981.09           -21.2%     772.65        perf-stat.ps.major-faults
   1936572           -20.5%    1539324        perf-stat.ps.minor-faults
   1937553           -20.5%    1540097        perf-stat.ps.page-faults
 5.016e+13           -24.8%  3.775e+13        perf-stat.total.instructions
  13132161           -28.7%    9359300        sched_debug.cfs_rq:/.avg_vruntime.avg
  15326712 ±  3%     -25.0%   11491862 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.max
  12556945           -28.9%    8923532        sched_debug.cfs_rq:/.avg_vruntime.min
      0.81 ±  5%     +13.2%       0.91 ±  5%  sched_debug.cfs_rq:/.h_nr_queued.avg
      5.30 ± 23%     +88.6%      10.00 ± 12%  sched_debug.cfs_rq:/.h_nr_queued.max
      0.98 ± 11%     +74.8%       1.70 ±  8%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.74 ±  4%     +11.5%       0.83 ±  4%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      4.71 ± 25%    +102.3%       9.53 ± 14%  sched_debug.cfs_rq:/.h_nr_runnable.max
      0.86 ± 13%     +83.6%       1.58 ±  9%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
     16.14 ±  4%     -13.6%      13.94 ±  2%  sched_debug.cfs_rq:/.load_avg.min
     84.33 ±  5%     +22.8%     103.54 ±  9%  sched_debug.cfs_rq:/.load_avg.stddev
  13132161           -28.7%    9359300        sched_debug.cfs_rq:/.min_vruntime.avg
  15326712 ±  3%     -25.0%   11491862 ±  7%  sched_debug.cfs_rq:/.min_vruntime.max
  12556946           -28.9%    8923532        sched_debug.cfs_rq:/.min_vruntime.min
      0.60 ±  5%     -26.4%       0.44 ±  2%  sched_debug.cfs_rq:/.nr_queued.avg
     17.75 ± 15%     +35.8%      24.11 ±  7%  sched_debug.cfs_rq:/.removed.load_avg.avg
    362.55 ± 11%     +41.9%     514.30 ± 14%  sched_debug.cfs_rq:/.removed.load_avg.max
     68.25 ± 11%     +36.9%      93.43 ±  7%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     74.47 ± 10%     +49.8%     111.56 ± 12%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     14.06 ± 19%     +49.5%      21.01 ± 12%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
    885.61           +13.6%       1006        sched_debug.cfs_rq:/.runnable_avg.avg
      1607 ±  3%     +36.7%       2197 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
    365.76 ±  2%     +25.9%     460.47 ±  5%  sched_debug.cfs_rq:/.runnable_avg.min
    259.26 ±  3%     +17.7%     305.09 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    247.16 ±  2%     -15.9%     207.96 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
     27.96 ±  9%     +55.7%      43.54 ±  5%  sched_debug.cfs_rq:/.util_est.avg
    253.62 ± 19%    +120.0%     558.02 ± 10%  sched_debug.cfs_rq:/.util_est.max
     50.33 ± 12%     +93.4%      97.32 ±  8%  sched_debug.cfs_rq:/.util_est.stddev
    170553 ±  3%     +85.7%     316634 ±  3%  sched_debug.cpu.avg_idle.avg
    387229 ±  5%     +98.0%     766874 ±  5%  sched_debug.cpu.avg_idle.max
     26436 ±  7%     +99.2%      52667 ± 28%  sched_debug.cpu.avg_idle.min
     72543 ±  4%    +104.5%     148373 ±  3%  sched_debug.cpu.avg_idle.stddev
   1258992 ±  3%     -39.0%     768365 ±  4%  sched_debug.cpu.curr->pid.avg
    500518          +170.7%    1355011        sched_debug.cpu.max_idle_balance_cost.avg
    523673 ±  4%    +185.0%    1492698        sched_debug.cpu.max_idle_balance_cost.max
      3207 ± 88%   +4294.6%     140956 ± 46%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.81 ±  5%     +12.7%       0.92 ±  6%  sched_debug.cpu.nr_running.avg
      5.36 ± 18%     +89.5%      10.17 ± 12%  sched_debug.cpu.nr_running.max
      0.98 ± 10%     +75.6%       1.72 ±  8%  sched_debug.cpu.nr_running.stddev
   2891583 ±  2%     -36.7%    1829676        sched_debug.cpu.nr_switches.avg
   2953034 ±  2%     -37.1%    1858327        sched_debug.cpu.nr_switches.max
   2814744 ±  2%     -36.8%    1780154        sched_debug.cpu.nr_switches.min
     26785 ±  6%     -50.3%      13321 ± 13%  sched_debug.cpu.nr_switches.stddev
     59229 ± 18%     -91.0%       5353 ±  8%  sched_debug.cpu.nr_uninterruptible.max
   -144639           -96.1%      -5702        sched_debug.cpu.nr_uninterruptible.min
     37096 ± 14%     -93.2%       2537 ±  5%  sched_debug.cpu.nr_uninterruptible.stddev
      0.01 ± 18%    +267.9%       0.03 ± 89%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.alloc_anon_folio
      0.01 ±  8%    +525.0%       0.03 ± 78%  perf-sched.sch_delay.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ±  7%     +58.9%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.01 ± 13%    +170.0%       0.04 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.do_close_on_exec.begin_new_exec.load_elf_binary.exec_binprm
      0.01 ± 12%     +71.9%       0.02 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.exec_binprm
      0.01 ± 27%    +129.6%       0.02 ± 43%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.01           +57.1%       0.01 ± 35%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.01 ± 15%    +107.7%       0.02 ± 32%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.01 ± 14%     +95.2%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      0.01 ± 16%    +230.0%       0.02 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.01 ± 15%     +75.0%       0.02 ± 29%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_shrink
      0.01 ± 17%     +56.8%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.01 ± 22%     +64.8%       0.02 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.03 ±126%     -80.7%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.anon_pipe_read.vfs_read.ksys_read
      0.01           +37.0%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  4%     +88.7%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ±  8%     +91.8%       0.02 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.02 ±122%    +274.3%       0.07 ± 60%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 16%     +97.7%       0.03 ± 22%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.01 ± 11%    +125.0%       0.02 ± 42%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.01 ± 26%     +77.6%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.02 ±126%    +168.0%       0.04 ± 70%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ± 15%     +92.3%       0.02 ± 25%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.01 ± 10%     +56.5%       0.02 ± 15%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.02 ±  8%     -20.6%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
      0.01 ±  6%     +31.5%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  4%     -12.9%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03           -16.1%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.25 ± 78%    +940.3%       2.63 ±149%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.alloc_anon_folio
      0.13 ± 40%    +395.2%       0.62 ±106%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.wp_page_copy
      0.01 ± 18%   +1886.4%       0.15 ±107%  perf-sched.sch_delay.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.10 ± 32%    +356.0%       0.47 ± 89%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.08 ± 24%    +258.2%       0.28 ± 24%  perf-sched.sch_delay.max.ms.__cond_resched.do_close_on_exec.begin_new_exec.load_elf_binary.exec_binprm
      0.20 ± 78%    +328.1%       0.85 ± 65%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_lookupat
      0.07 ± 36%    +456.5%       0.39 ±102%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__mmap_new_vma.__mmap_region.do_mmap
      0.07 ± 40%    +149.9%       0.18 ± 95%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.12 ± 44%    +129.2%       0.27 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.exec_binprm
      0.04 ± 46%    +329.1%       0.17 ± 31%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_binary
      0.07 ± 71%    +152.7%       0.18 ± 20%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
      0.04 ± 44%    +403.2%       0.19 ± 70%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.09 ± 41%    +272.9%       0.33 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.13 ± 31%    +205.2%       0.40 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.15 ± 59%   +1852.6%       2.92 ±134%  perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.12 ± 50%    +707.1%       0.94 ±101%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.09 ± 39%    +137.4%       0.21 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.06 ± 47%    +112.3%       0.13 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.__kernel_read.exec_binprm.bprm_execve
      0.11 ± 54%    +588.8%       0.74 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      0.07 ± 35%    +158.5%       0.17 ± 38%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
      0.05 ± 88%    +605.9%       0.36 ± 62%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.04 ± 94%    +218.3%       0.12 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_link
      0.13 ± 73%    +415.6%       0.65 ± 48%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.07 ± 76%    +140.3%       0.18 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.15 ±162%     -94.1%       0.01 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.anon_pipe_read.vfs_read.ksys_read
      0.37 ± 29%     +79.8%       0.66 ±  9%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.15 ± 34%    +407.2%       0.77 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.10 ± 63%    +438.3%       0.53 ± 46%  perf-sched.sch_delay.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.07 ± 31%  +19792.4%      14.82 ±219%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     12.60 ±202%    +436.8%      67.62 ± 74%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.13 ± 22%     +55.2%       0.20 ± 24%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.ret_from_fork.ret_from_fork_asm.[unknown]
      0.11 ± 40%     +83.7%       0.20 ± 23%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      0.28 ± 76%    +379.7%       1.34 ± 66%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.05 ± 58%   +1155.4%       0.62 ± 72%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.06 ± 51%    +785.5%       0.55 ± 43%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     28.85 ± 15%     +50.7%      43.47 ± 18%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      6.57 ±  4%     +11.9%       7.35 ±  4%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±  2%    +170.8%       0.06        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
    481.00 ±  6%     -20.4%     382.83 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
     43.00 ± 12%     -25.2%      32.17 ± 11%  perf-sched.wait_and_delay.count.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
    313.17 ±  5%     -17.1%     259.67 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      2016           +21.2%       2443 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    632.00            -8.8%     576.33 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      1490 ±  3%     -13.0%       1296 ±  6%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      7.78 ±  7%     +45.7%      11.33 ± 13%  perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      4.75 ± 21%    +512.5%      29.11 ± 27%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      4.73 ± 20%     +83.1%       8.67 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
     31.76 ± 16%     -24.7%      23.90 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      3.33 ± 13%     +42.4%       4.74 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlinkat
      3.22 ± 23%     +34.9%       4.34 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      3.72 ±  2%     +14.5%       4.25 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      2.99           +13.0%       3.37 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      3.25 ±  3%     +12.8%       3.67 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      2.99 ±  4%     +11.0%       3.32 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      2.78 ±  3%      +9.5%       3.05 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      3.08 ±  9%     +17.7%       3.63 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.do_brk_flags.__do_sys_brk
      2.52 ± 46%     +59.0%       4.01 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
     28.84 ± 15%     +50.1%      43.30 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      3.54 ±  2%     +12.8%       4.00 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
      6.56 ±  4%     +11.8%       7.34 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.21 ±  2%     +16.7%       3.75 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.02 ±  2%    +170.8%       0.06        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.39 ± 29%     +80.4%       0.71 ± 20%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      1.39 ±  2%     +21.2%       1.69 ±  2%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      3.78 ±  4%     +10.1%       4.16 ±  3%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.02 ±  8%     -20.6%       0.01 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
      5.22 ± 11%     +32.0%       6.89 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      5.93 ± 10%     +28.7%       7.63 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.step_into.link_path_walk
      5.23 ±  9%     +34.3%       7.03 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.__get_user_pages.get_user_pages_remote.get_arg_page.copy_strings
      6.67 ±  7%     +19.6%       7.98 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      5.72 ±  4%     +22.8%       7.03 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      6.52 ± 12%     +28.1%       8.35 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      5.42 ±  5%     +24.5%       6.74 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.do_close_on_exec.begin_new_exec.load_elf_binary.exec_binprm
      6.05 ± 10%     +34.3%       8.12 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_lookupat
      6.77 ± 14%     +36.2%       9.22 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_openat
      4.63 ± 20%     +43.0%       6.62 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlinkat
      4.80 ± 12%     +33.0%       6.38 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.vms_gather_munmap_vmas
      5.03 ± 11%     +23.9%       6.23 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.commit_merge.vma_expand
      4.67 ± 11%     +30.9%       6.12 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      6.39 ±  7%     +29.8%       8.29 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      4.39 ± 14%     +53.2%       6.73 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      7.06 ±  9%     +36.3%       9.62 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      6.48 ±  7%   +2586.0%     174.00 ±212%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.path_lookupat
      6.65 ±  8%     +35.1%       8.99 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      6.53 ± 15%     +33.4%       8.71 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      6.18 ±  3%     +65.1%      10.20 ± 47%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      6.44 ±  7%     +33.7%       8.60 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      6.00 ±  9%     +22.3%       7.33 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      5.43 ±  7%     +36.0%       7.38 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
      7.76 ±  7%     +45.0%      11.25 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      6.24 ±  4%     +35.2%       8.44 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      6.36 ±  9%     +26.3%       8.04 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      6.12 ± 11%     +64.1%      10.04 ± 36%  perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      4.75 ± 21%    +512.5%      29.11 ± 27%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      5.60 ± 13%     +24.3%       6.96 ± 15%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      5.92 ± 14%     +55.5%       9.21 ± 36%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare


***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/shell1/unixbench

commit: 
  d398a68e8b ("# gpg: Signature made Wed 25 Jun 2025 12:55:36 AM CEST")
  155213a2ae ("sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails")

d398a68e8bcf430e 155213a2aed42c85361bf4f5c81 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     17885           +39.2%      24889        uptime.idle
 1.606e+10           +42.7%  2.292e+10        cpuidle..time
 2.147e+08           -23.5%  1.643e+08        cpuidle..usage
   3284061           -11.1%    2918362 ±  2%  meminfo.Active
   3284061           -11.1%    2918362 ±  2%  meminfo.Active(anon)
   3777829           -10.0%    3398222        meminfo.Committed_AS
   2546265           -14.6%    2174932 ±  2%  meminfo.Shmem
 5.333e+08           -22.5%  4.133e+08        numa-numastat.node0.local_node
 5.333e+08           -22.5%  4.133e+08        numa-numastat.node0.numa_hit
 5.313e+08           -22.6%  4.112e+08        numa-numastat.node1.local_node
 5.314e+08           -22.6%  4.112e+08        numa-numastat.node1.numa_hit
 5.332e+08           -22.5%  4.133e+08        numa-vmstat.node0.numa_hit
 5.332e+08           -22.5%  4.133e+08        numa-vmstat.node0.numa_local
 5.313e+08           -22.6%  4.112e+08        numa-vmstat.node1.numa_hit
 5.312e+08           -22.6%  4.112e+08        numa-vmstat.node1.numa_local
     40.47           +41.7%      57.33        vmstat.cpu.id
     40.07           -16.9%      33.31 ±  3%  vmstat.procs.r
    653105           -33.5%     434076        vmstat.system.cs
    505545           -33.3%     337403        vmstat.system.in
      4094 ±  2%     -23.2%       3143 ±  2%  perf-c2c.DRAM.local
     27248           -28.9%      19371        perf-c2c.DRAM.remote
     24179           -29.2%      17107        perf-c2c.HITM.local
     17653           -26.8%      12928        perf-c2c.HITM.remote
     41833           -28.2%      30035        perf-c2c.HITM.total
     40.27           +16.9       57.19        mpstat.cpu.all.idle%
      0.00 ±  5%      +0.0        0.01 ±  8%  mpstat.cpu.all.iowait%
      1.37            -0.5        0.87        mpstat.cpu.all.irq%
      0.64            -0.2        0.48        mpstat.cpu.all.soft%
     49.02           -13.5       35.49        mpstat.cpu.all.sys%
      8.71            -2.7        5.96        mpstat.cpu.all.usr%
     64.63           -26.7%      47.38        mpstat.max_utilization_pct
     35048           -22.8%      27046        unixbench.score
    148604           -22.8%     114678        unixbench.throughput
  11422972           -24.9%    8573972        unixbench.time.involuntary_context_switches
    486973 ±  2%     -27.9%     351159        unixbench.time.major_page_faults
 1.278e+09           -22.6%  9.892e+08        unixbench.time.minor_page_faults
      3536           -24.0%       2686        unixbench.time.percent_of_cpu_this_job_got
     16992           -24.0%      12919        unixbench.time.system_time
      5309           -24.1%       4027        unixbench.time.user_time
 1.985e+08           -33.7%  1.315e+08        unixbench.time.voluntary_context_switches
  93620593           -22.8%   72304443        unixbench.workload
    821039           -11.1%     729659 ±  2%  proc-vmstat.nr_active_anon
   1543486            -5.9%    1452488        proc-vmstat.nr_file_pages
     31917           -10.5%      28561        proc-vmstat.nr_mapped
     15279            -5.0%      14511        proc-vmstat.nr_page_table_pages
    636492           -14.6%     543775 ±  2%  proc-vmstat.nr_shmem
    821039           -11.1%     729659 ±  2%  proc-vmstat.nr_zone_active_anon
 1.064e+09           -22.5%  8.245e+08        proc-vmstat.numa_hit
 1.064e+09           -22.5%  8.244e+08        proc-vmstat.numa_local
 1.092e+09           -22.5%  8.462e+08        proc-vmstat.pgalloc_normal
 1.281e+09           -22.5%  9.918e+08        proc-vmstat.pgfault
 1.092e+09           -22.5%  8.456e+08        proc-vmstat.pgfree
  62204942           -22.7%   48080529        proc-vmstat.pgreuse
     49220           -22.8%      38010        proc-vmstat.thp_fault_alloc
  20630248           -22.8%   15929133        proc-vmstat.unevictable_pgs_culled
      3.32           -13.5%       2.87        perf-stat.i.MPKI
 1.569e+10           -26.7%   1.15e+10        perf-stat.i.branch-instructions
      1.65            -0.1        1.51        perf-stat.i.branch-miss-rate%
 2.554e+08           -33.2%  1.706e+08        perf-stat.i.branch-misses
     21.21            +1.0       22.21        perf-stat.i.cache-miss-rate%
 2.564e+08           -36.9%  1.619e+08        perf-stat.i.cache-misses
 1.195e+09           -39.8%  7.199e+08        perf-stat.i.cache-references
    655825           -33.6%     435756        perf-stat.i.context-switches
 1.453e+11           -27.8%  1.049e+11        perf-stat.i.cpu-cycles
    165484           -50.7%      81565        perf-stat.i.cpu-migrations
    573.07           +13.7%     651.61        perf-stat.i.cycles-between-cache-misses
 7.614e+10           -26.8%  5.577e+10        perf-stat.i.instructions
      0.54            +1.4%       0.55        perf-stat.i.ipc
    771.89 ±  2%     -27.9%     556.73        perf-stat.i.major-faults
     74.86           -25.0%      56.11        perf-stat.i.metric.K/sec
   1985382           -22.6%    1537449        perf-stat.i.minor-faults
   1986154           -22.6%    1538006        perf-stat.i.page-faults
      3.37           -13.8%       2.90        perf-stat.overall.MPKI
      1.63            -0.1        1.48        perf-stat.overall.branch-miss-rate%
     21.45            +1.0       22.48        perf-stat.overall.cache-miss-rate%
    566.79           +14.3%     647.85        perf-stat.overall.cycles-between-cache-misses
      0.52            +1.5%       0.53        perf-stat.overall.ipc
    512996            -5.1%     486678        perf-stat.overall.path-length
 1.567e+10           -26.7%  1.148e+10        perf-stat.ps.branch-instructions
  2.55e+08           -33.2%  1.704e+08        perf-stat.ps.branch-misses
 2.559e+08           -36.9%  1.616e+08        perf-stat.ps.cache-misses
 1.193e+09           -39.8%  7.188e+08        perf-stat.ps.cache-references
    654796           -33.6%     435084        perf-stat.ps.context-switches
 1.451e+11           -27.8%  1.047e+11        perf-stat.ps.cpu-cycles
    165235           -50.7%      81443        perf-stat.ps.cpu-migrations
 7.603e+10           -26.8%  5.568e+10        perf-stat.ps.instructions
    770.81 ±  2%     -27.9%     555.87        perf-stat.ps.major-faults
   1982349           -22.6%    1535062        perf-stat.ps.minor-faults
   1983120           -22.6%    1535618        perf-stat.ps.page-faults
 4.803e+13           -26.7%  3.519e+13        perf-stat.total.instructions
  12400028           -24.2%    9405194        sched_debug.cfs_rq:/.avg_vruntime.avg
  13618254           -22.8%   10510414 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
  12127726           -24.4%    9171310        sched_debug.cfs_rq:/.avg_vruntime.min
      0.63 ±  2%     -20.0%       0.50 ±  7%  sched_debug.cfs_rq:/.h_nr_queued.avg
      2.20 ±  5%     +21.4%       2.67 ±  7%  sched_debug.cfs_rq:/.h_nr_queued.max
      0.58 ±  2%     +13.4%       0.66 ±  3%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.62 ±  2%     -20.6%       0.49 ±  7%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      2.12 ±  4%     +22.1%       2.59 ±  7%  sched_debug.cfs_rq:/.h_nr_runnable.max
      0.56 ±  2%     +12.9%       0.64 ±  3%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
   8139981 ± 22%     -36.3%    5185921 ± 25%  sched_debug.cfs_rq:/.left_deadline.max
   1215466 ± 19%     -41.7%     708295 ± 32%  sched_debug.cfs_rq:/.left_deadline.stddev
   8139899 ± 22%     -36.3%    5185855 ± 25%  sched_debug.cfs_rq:/.left_vruntime.max
   1215455 ± 19%     -41.7%     708286 ± 32%  sched_debug.cfs_rq:/.left_vruntime.stddev
     13.41 ±  4%     -24.6%      10.11 ±  3%  sched_debug.cfs_rq:/.load_avg.min
    174.00 ±  9%     +19.4%     207.75 ±  7%  sched_debug.cfs_rq:/.load_avg.stddev
  12400028           -24.2%    9405194        sched_debug.cfs_rq:/.min_vruntime.avg
  13618254           -22.8%   10510414 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
  12127726           -24.4%    9171310        sched_debug.cfs_rq:/.min_vruntime.min
      0.58 ±  2%     -27.2%       0.42 ±  6%  sched_debug.cfs_rq:/.nr_queued.avg
     34.18 ± 18%     +50.0%      51.29 ± 17%  sched_debug.cfs_rq:/.removed.load_avg.avg
    152.53 ± 12%     +29.9%     198.07 ± 10%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      7.67 ± 27%     +50.9%      11.56 ± 20%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
      7.63 ± 27%     +47.4%      11.25 ± 20%  sched_debug.cfs_rq:/.removed.util_avg.avg
   8139899 ± 22%     -36.3%    5185856 ± 25%  sched_debug.cfs_rq:/.right_vruntime.max
   1215455 ± 19%     -41.7%     708286 ± 32%  sched_debug.cfs_rq:/.right_vruntime.stddev
    646.44            -8.7%     589.99 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
    106.88 ± 10%     -28.9%      75.98 ± 16%  sched_debug.cfs_rq:/.runnable_avg.min
    653.86            -8.3%     599.55 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
    118.14 ±  9%     -21.0%      93.29 ± 13%  sched_debug.cfs_rq:/.util_avg.min
     94.09 ±  6%     -17.2%      77.93 ±  8%  sched_debug.cfs_rq:/.util_est.avg
    145955           +82.2%     265990 ±  3%  sched_debug.cpu.avg_idle.avg
    264026 ±  6%    +124.8%     593601 ±  3%  sched_debug.cpu.avg_idle.max
     32830 ±  9%    +106.8%      67896 ±  7%  sched_debug.cpu.avg_idle.min
     48879 ±  3%    +123.2%     109086 ±  4%  sched_debug.cpu.avg_idle.stddev
   1133713 ±  9%     -35.0%     737172 ±  7%  sched_debug.cpu.curr->pid.avg
    500274          +183.1%    1416170        sched_debug.cpu.max_idle_balance_cost.avg
    510990          +192.0%    1492181        sched_debug.cpu.max_idle_balance_cost.max
    500000          +167.2%    1335777        sched_debug.cpu.max_idle_balance_cost.min
      1562 ± 71%   +2956.4%      47752        sched_debug.cpu.max_idle_balance_cost.stddev
      0.63           -20.4%       0.50 ±  6%  sched_debug.cpu.nr_running.avg
      0.59 ±  3%     +13.2%       0.66 ±  3%  sched_debug.cpu.nr_running.stddev
   3068067           -33.2%    2048410        sched_debug.cpu.nr_switches.avg
   3141067           -33.8%    2079700        sched_debug.cpu.nr_switches.max
   2933953           -32.6%    1978371        sched_debug.cpu.nr_switches.min
     35990 ± 10%     -47.0%      19089 ± 21%  sched_debug.cpu.nr_switches.stddev
      0.70 ±  9%     +25.0%       0.88 ±  7%  sched_debug.cpu.nr_uninterruptible.avg
     14730 ± 34%     -77.1%       3372 ± 12%  sched_debug.cpu.nr_uninterruptible.max
    -26083           -86.0%      -3660        sched_debug.cpu.nr_uninterruptible.min
      8186 ± 19%     -79.9%       1643 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
      0.01 ± 16%     +87.8%       0.03 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pmd_alloc
      0.01 ± 12%     +86.6%       0.03 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.01 ± 29%     +83.5%       0.02 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
      0.01 ± 24%    +307.6%       0.05 ± 24%  perf-sched.sch_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
      0.02 ± 22%     +96.9%       0.03 ± 79%  perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      0.01 ± 68%     -85.9%       0.00 ±152%  perf-sched.sch_delay.avg.ms.__cond_resched.alloc_pages_bulk_noprof.__vmalloc_area_node.__vmalloc_node_range_noprof.__vmalloc_node_noprof
      0.01 ± 26%     +59.8%       0.02 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.04 ±141%     -87.3%       0.00 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      0.01 ± 11%     +37.9%       0.02 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.path_openat
      0.02 ± 28%    +106.1%       0.03 ± 35%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.01 ± 18%     +57.5%       0.02 ± 34%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.02 ± 67%     -63.6%       0.01 ± 49%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.01 ±  7%     +44.7%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.01 ± 28%    +134.0%       0.02 ± 33%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      0.01 ±  5%     +42.3%       0.02 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.01 ± 17%    +125.7%       0.03 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.01 ± 11%     -28.6%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.filemap_read.__kernel_read.load_elf_binary.exec_binprm
      0.02 ± 50%     +90.3%       0.03 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      0.03 ± 60%     -86.0%       0.00 ± 72%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
      0.01 ± 58%    +116.2%       0.01 ± 59%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.alloc_inode.new_inode.ramfs_get_inode
      0.01 ± 25%    +140.7%       0.02 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_shrink
      0.02 ± 31%     +93.1%       0.03 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc._install_special_mapping.map_vdso
      0.01           +95.8%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ± 12%     +70.0%       0.02 ± 22%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.02 ±  3%     +21.1%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ±  8%     +93.8%       0.03 ± 24%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ±  9%     -29.9%       0.01 ± 25%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.ret_from_fork.ret_from_fork_asm.[unknown]
      0.01 ± 25%     +85.1%       0.02 ± 27%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      0.01 ±  4%     +24.1%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.01 ±  7%     +80.8%       0.02 ± 19%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.01 ±  5%     +87.4%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.01 ±  6%     +54.1%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ±  7%     +51.5%       0.02 ± 10%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.04 ± 14%    +138.2%       0.10 ± 14%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.01 ±  4%     +22.2%       0.01 ±  2%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.01           +45.5%       0.02        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.01 ±  5%     +44.0%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.02 ±  9%     -18.5%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
      0.01 ±  6%     +44.9%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  5%     +22.8%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.03           -14.0%       0.03        perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.23 ± 55%    +212.5%       0.72 ± 65%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pmd_alloc
      0.08 ± 43%    +264.0%       0.29 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
      0.02 ±117%     -91.6%       0.00 ±152%  perf-sched.sch_delay.max.ms.__cond_resched.alloc_pages_bulk_noprof.__vmalloc_area_node.__vmalloc_node_range_noprof.__vmalloc_node_noprof
      0.08 ± 55%    +174.1%       0.21 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.create_elf_tables.load_elf_binary.exec_binprm
      0.13 ± 47%    +441.9%       0.70 ± 92%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
      0.30 ±105%     -83.7%       0.05 ±127%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.19 ± 53%    +124.7%       0.43 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.08 ± 79%    +223.7%       0.28 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      0.10 ± 39%    +110.6%       0.20 ± 22%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.__mmput.exec_mmap.begin_new_exec
      0.10 ± 76%     -95.4%       0.00 ± 74%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_pseudo.alloc_file_pseudo
      0.16 ± 42%    +150.8%       0.40 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc._install_special_mapping.map_vdso
      0.96 ± 22%    +124.7%       2.15 ±  8%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      1.10 ± 43%    +815.9%      10.10 ± 98%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.75 ± 22%    +132.9%       1.74 ±  8%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      3.73 ±  9%     +47.5%       5.50 ± 22%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.01 ±  3%     +33.8%       0.01 ±  3%  perf-sched.total_sch_delay.average.ms
      1.01           +17.2%       1.18        perf-sched.total_wait_and_delay.average.ms
   1881224           -13.7%    1623988        perf-sched.total_wait_and_delay.count.ms
      1.00           +17.0%       1.17        perf-sched.total_wait_time.average.ms
      3.31 ± 27%     -56.9%       1.43 ± 80%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.unlink_file_vma_batch_process.free_pgtables.exit_mmap
      2.76 ± 30%     +89.1%       5.22 ± 17%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.unlink_file_vma_batch_process.unlink_file_vma_batch_add.free_pgtables
     12.77 ± 11%     +48.5%      18.97 ± 21%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     15.74 ±  9%     +57.4%      24.77 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      6.30           +19.4%       7.52        perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.06           +54.2%       0.09        perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.59           +18.6%       0.70        perf-sched.wait_and_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±  3%    +199.0%       0.05        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      5.97           +10.6%       6.60        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.32           +11.3%      22.62 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.22           +27.0%       0.28        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.21           +23.7%       0.26        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.21           +20.4%       0.25        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.14           +27.2%       0.17        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.55 ±  2%     +26.1%       0.69 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.22 ±  2%     +17.6%       0.26 ±  2%  perf-sched.wait_and_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.31           +12.9%       8.25        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    124.00 ± 11%     -18.4%     101.17 ± 12%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
     15.33 ± 29%     -69.6%       4.67 ±100%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_noprof.__filemap_get_folio
    538.67 ±  5%     -20.1%     430.50 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
     77.83 ±  6%     -36.6%      49.33 ± 11%  perf-sched.wait_and_delay.count.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
    123.83 ±  5%     -15.5%     104.67 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
     36.50 ± 11%     -19.2%      29.50 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_mmap.dup_mm.constprop
    393.83           -21.5%     309.33 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
     89.67 ±  4%     -29.6%      63.17 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     44.17 ± 14%     -23.0%      34.00 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
     33.50 ±  7%     -29.4%      23.67 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
    194.67 ±  6%     -29.1%     138.00 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
      7.67 ± 24%     -76.1%       1.83 ± 96%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
     32.50 ± 15%     -33.3%      21.67 ± 14%  perf-sched.wait_and_delay.count.__cond_resched.put_files_struct.part.0.do_exit
     17.67 ± 16%     -39.6%      10.67 ± 49%  perf-sched.wait_and_delay.count.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      6.83 ± 25%     -56.1%       3.00 ± 33%  perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     30.33 ±  8%     -34.1%      20.00 ± 25%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      2840 ±  3%     -16.4%       2375 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     23.17 ± 13%     -38.1%      14.33 ± 56%  perf-sched.wait_and_delay.count.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
     31.00 ± 10%     -24.2%      23.50 ± 12%  perf-sched.wait_and_delay.count.__cond_resched.uprobe_start_dup_mmap.dup_mm.constprop.0
     85.67 ± 12%     -26.7%      62.83 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    800.50 ±  2%     -20.9%     633.50 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
     75790           -12.9%      65991        perf-sched.wait_and_delay.count.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
     97386            -9.5%      88127        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     78732            -9.4%      71366        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2316 ±  3%     -16.3%       1939        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     79417           -15.0%      67470        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
   1240653           -14.5%    1060844        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
     20806           -13.0%      18108        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     21677            -9.5%      19624        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     10823            -9.6%       9782        perf-sched.wait_and_delay.count.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     83583           -11.4%      74050        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     30.73 ±  3%     +11.1%      34.13 ±  3%  perf-sched.wait_and_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
     29.54           +16.8%      34.50 ±  6%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
     28.22 ±  2%     +11.4%      31.45 ±  4%  perf-sched.wait_and_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
     21.87 ± 53%     +64.4%      35.95 ±  8%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.dup_fd.copy_process.kernel_clone
     33.64 ±  2%     +14.9%      38.65 ±  3%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
     31.09 ±  5%     +14.2%      35.50        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
     30.01 ±  7%     +26.8%      38.05 ± 18%  perf-sched.wait_and_delay.max.ms.__cond_resched.pidfs_exit.release_task.wait_task_zombie.__do_wait
    112.62 ± 24%    +101.3%     226.66 ± 24%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      2.24 ± 42%     +81.7%       4.07 ± 10%  perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      3.51 ± 12%    +511.3%      21.48 ± 24%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      7.75 ± 17%     +26.8%       9.83 ± 17%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.57 ±128%     -94.3%       0.03 ±214%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.anon_pipe_write
      0.13 ±  5%     +34.8%       0.17 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.20 ±  7%     +41.3%       0.28 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.step_into.link_path_walk
      0.15 ±  2%     +17.5%       0.18 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.21 ± 11%     +42.3%       0.30 ± 21%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mprotect_fixup
      0.17 ±  5%     +44.0%       0.24 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      1.94 ± 97%     -98.0%       0.04 ±146%  perf-sched.wait_time.avg.ms.__cond_resched.alloc_pages_bulk_noprof.__vmalloc_area_node.__vmalloc_node_range_noprof.__vmalloc_node_noprof
      0.19 ±  3%     +22.1%       0.23 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.19 ±  2%     +20.2%       0.23 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.20 ±  3%     +27.2%       0.26 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.path_lookupat
      0.19           +17.3%       0.22 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.path_openat
      3.30 ± 28%     -50.9%       1.62 ± 59%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma_batch_process.free_pgtables.exit_mmap
      2.75 ± 30%     +89.3%       5.21 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma_batch_process.unlink_file_vma_batch_add.free_pgtables
      0.20 ±  4%     +27.1%       0.25 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.20           +18.4%       0.24 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.21 ± 20%    +156.4%       0.53 ± 47%  perf-sched.wait_time.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      0.20 ±  3%     +25.3%       0.25 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.20           +21.2%       0.25 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_lookupat
      0.19           +17.2%       0.23 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.20 ±  6%     +18.7%       0.23 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.17 ±  2%     +19.5%       0.20 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.01 ± 59%     -49.4%       0.01 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.__kernel_read.load_elf_binary.exec_binprm
     12.77 ± 11%     +48.5%      18.96 ± 21%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.20 ±  8%     +36.3%       0.28 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      0.18 ±  4%     +16.9%       0.21 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      0.18 ±  9%     +26.6%       0.23 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.18 ±  7%     +13.4%       0.21 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      0.17 ±  4%      +9.9%       0.19 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.02 ± 37%    +106.0%       0.05 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc._install_special_mapping.map_vdso
      0.20 ±  4%     +20.9%       0.24 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.21 ±  4%     +22.6%       0.26 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.__mmap_region.do_mmap
      0.05 ± 18%     +89.5%       0.10 ± 24%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     15.73 ±  9%     +57.4%      24.76 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      6.29           +19.4%       7.51        perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05           +47.2%       0.07        perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.19 ±  2%     +28.7%       0.25 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlinkat
      0.17           +13.4%       0.20 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.58           +18.9%       0.69        perf-sched.wait_time.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.21           +20.0%       0.25 ±  3%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      0.16 ± 61%    +131.0%       0.37 ± 48%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
      0.02 ±  3%    +199.0%       0.05        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      5.95           +10.5%       6.57        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.10           +38.8%       0.14 ±  2%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.21 ± 10%     +14.0%       0.23 ±  2%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
     20.31           +11.3%      22.61 ±  2%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.21           +27.4%       0.27        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      0.20           +22.4%       0.25        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      0.20           +20.7%       0.24        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.56 ± 17%     +88.1%       1.06 ± 19%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      0.13           +25.9%       0.16        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.02 ±  9%     -18.5%       0.01 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
      0.54 ±  2%     +25.7%       0.67 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.21 ±  2%     +17.3%       0.25 ±  2%  perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.30           +13.0%       8.25        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.61 ±116%     -94.7%       0.03 ±214%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.anon_pipe_write
      0.61 ± 28%     +83.3%       1.11 ± 25%  perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.47 ± 48%    +188.9%       1.35 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.step_into.link_path_walk
     30.71 ±  3%     +11.1%      34.13 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      0.52 ± 20%    +147.4%       1.29 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.part
      2.59 ± 79%     -98.5%       0.04 ±146%  perf-sched.wait_time.max.ms.__cond_resched.alloc_pages_bulk_noprof.__vmalloc_area_node.__vmalloc_node_range_noprof.__vmalloc_node_noprof
      0.64 ± 32%    +142.2%       1.54 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.51 ± 39%    +143.0%       1.25 ± 33%  perf-sched.wait_time.max.ms.__cond_resched.down_read.open_last_lookups.path_openat.do_filp_open
      0.71 ± 14%    +143.2%       1.74 ± 25%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_lookupat
      0.94 ± 25%    +105.3%       1.93 ± 62%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.path_openat
      0.28 ± 13%    +227.3%       0.91 ± 37%  perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.vma_modify
     29.53           +16.8%      34.50 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.77 ± 13%     +89.6%       1.45 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__lookup_slow.walk_component
      0.39 ± 19%    +242.7%       1.34 ± 58%  perf-sched.wait_time.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlinkat.do_syscall_64
      0.95 ± 19%     +65.1%       1.57 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      1.03 ± 28%     +89.8%       1.96 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.84 ± 24%    +141.8%       2.03 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     28.22 ±  2%     +11.4%      31.45 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      1.38 ± 75%    +195.9%       4.09 ± 51%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      0.62 ± 21%    +102.1%       1.25 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
     21.83 ± 53%     +64.6%      35.95 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.dup_fd.copy_process.kernel_clone
      0.94 ± 21%     +85.0%       1.74 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
     33.63 ±  2%     +14.9%      38.63 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
     31.08 ±  5%     +14.2%      35.50        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
     30.01 ±  7%     +18.6%      35.59 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.pidfs_exit.release_task.wait_task_zombie.__do_wait
    112.62 ± 24%    +101.3%     226.66 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.77 ± 26%    +134.3%       1.80 ± 18%  perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      3.51 ± 12%    +511.3%      21.48 ± 24%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     29.10 ±  4%    +599.0%     203.42 ±175%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      4.03 ± 16%     +39.6%       5.62 ± 20%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups



***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/shell8/unixbench

commit: 
  d398a68e8b ("# gpg: Signature made Wed 25 Jun 2025 12:55:36 AM CEST")
  155213a2ae ("sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails")

d398a68e8bcf430e 155213a2aed42c85361bf4f5c81 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3705           +23.0%       4556        uptime.idle
 1.465e+09 ±  3%     +57.6%  2.308e+09        cpuidle..time
  19898270 ±  2%     -26.1%   14706585        cpuidle..usage
      3.66 ± 67%      -2.8        0.86 ± 65%  perf-profile.children.cycles-pp.do_pte_missing
      1.48 ± 22%      -0.9        0.60 ± 91%  perf-profile.children.cycles-pp.folio_add_lru
      0.90 ± 47%      -0.6        0.27 ±109%  perf-profile.children.cycles-pp.ktime_get
     36.62 ±  3%     +55.4%      56.90        vmstat.cpu.id
    647041 ±  2%     -40.6%     384391        vmstat.system.cs
    518274 ±  2%     -40.6%     307868        vmstat.system.in
  54277783           -26.2%   40066728        numa-numastat.node0.local_node
  54323852           -26.2%   40108446        numa-numastat.node0.numa_hit
  54427776           -26.1%   40244226        numa-numastat.node1.local_node
  54459215           -26.1%   40270132        numa-numastat.node1.numa_hit
  54323931           -26.2%   40108973        numa-vmstat.node0.numa_hit
  54277862           -26.2%   40067255        numa-vmstat.node0.numa_local
  54459375           -26.1%   40270002        numa-vmstat.node1.numa_hit
  54427936           -26.1%   40244095        numa-vmstat.node1.numa_local
     35.06 ±  2%     +20.7       55.76        mpstat.cpu.all.idle%
      0.00 ± 35%      +0.0        0.00 ± 27%  mpstat.cpu.all.iowait%
      1.33 ±  3%      -0.5        0.82 ±  2%  mpstat.cpu.all.irq%
      0.63 ±  2%      -0.2        0.46        mpstat.cpu.all.soft%
     52.96           -16.7       36.29        mpstat.cpu.all.sys%
     10.02 ±  2%      -3.4        6.67        mpstat.cpu.all.usr%
     72.50           -30.2%      50.59        mpstat.max_utilization_pct
     34314           -26.3%      25295        unixbench.score
     20588           -26.3%      15177        unixbench.throughput
   1160275           -28.3%     831552 ±  2%  unixbench.time.involuntary_context_switches
     68375 ±  2%     -26.8%      50055 ±  2%  unixbench.time.major_page_faults
  1.29e+08           -26.0%   95464337        unixbench.time.minor_page_faults
      3958           -29.6%       2787        unixbench.time.percent_of_cpu_this_job_got
      1967           -29.7%       1382        unixbench.time.system_time
    539.02 ±  2%     -28.7%     384.13        unixbench.time.user_time
  23516099 ±  2%     -44.1%   13145541        unixbench.time.voluntary_context_switches
   1297095           -26.3%     956162        unixbench.workload
     34135            -1.6%      33590        proc-vmstat.nr_kernel_stack
     25098            -5.2%      23802 ±  2%  proc-vmstat.nr_page_table_pages
     51165            -2.9%      49698        proc-vmstat.nr_slab_unreclaimable
 1.088e+08           -26.1%   80379987        proc-vmstat.numa_hit
 1.087e+08           -26.1%   80312361        proc-vmstat.numa_local
 1.127e+08           -26.4%   82986926        proc-vmstat.pgalloc_normal
 1.298e+08           -25.9%   96177928        proc-vmstat.pgfault
 1.126e+08           -26.4%   82849202        proc-vmstat.pgfree
   6349867           -26.1%    4689477        proc-vmstat.pgreuse
      5517           -27.0%       4026        proc-vmstat.thp_fault_alloc
   2315822           -26.2%    1709750        proc-vmstat.unevictable_pgs_culled
      3.21           -16.1%       2.70        perf-stat.i.MPKI
 1.683e+10           -28.4%  1.205e+10        perf-stat.i.branch-instructions
      1.76            -0.1        1.66        perf-stat.i.branch-miss-rate%
 2.689e+08 ±  2%     -33.0%  1.802e+08        perf-stat.i.branch-misses
     23.71            -0.5       23.24        perf-stat.i.cache-miss-rate%
 2.751e+08 ±  3%     -40.2%  1.645e+08        perf-stat.i.cache-misses
 1.154e+09 ±  3%     -39.0%  7.041e+08        perf-stat.i.cache-references
    673615 ±  2%     -40.5%     400825        perf-stat.i.context-switches
      1.85            -3.2%       1.79        perf-stat.i.cpi
 1.569e+11           -30.8%  1.085e+11        perf-stat.i.cpu-cycles
    240728 ±  3%     -62.2%      90981        perf-stat.i.cpu-migrations
    621.04 ±  2%     +13.4%     704.10        perf-stat.i.cycles-between-cache-misses
 8.211e+10           -28.4%  5.877e+10        perf-stat.i.instructions
      0.57            +2.9%       0.59        perf-stat.i.ipc
      1069 ±  2%     -26.5%     786.01 ±  3%  perf-stat.i.major-faults
     76.01           -29.6%      53.50        perf-stat.i.metric.K/sec
   1977780           -25.7%    1468563        perf-stat.i.minor-faults
   1978850           -25.7%    1469349        perf-stat.i.page-faults
      3.35           -16.4%       2.80        perf-stat.overall.MPKI
      1.60            -0.1        1.50        perf-stat.overall.branch-miss-rate%
     23.85            -0.5       23.36        perf-stat.overall.cache-miss-rate%
      1.91            -3.4%       1.85        perf-stat.overall.cpi
    571.04 ±  2%     +15.6%     660.04        perf-stat.overall.cycles-between-cache-misses
      0.52            +3.5%       0.54        perf-stat.overall.ipc
   4018731            -2.6%    3914555        perf-stat.overall.path-length
 1.657e+10           -28.5%  1.185e+10        perf-stat.ps.branch-instructions
 2.646e+08 ±  2%     -33.0%  1.772e+08        perf-stat.ps.branch-misses
 2.707e+08 ±  3%     -40.2%  1.618e+08        perf-stat.ps.cache-misses
 1.135e+09 ±  3%     -39.0%  6.926e+08        perf-stat.ps.cache-references
    662770 ±  2%     -40.5%     394260        perf-stat.ps.context-switches
 1.545e+11           -30.9%  1.068e+11        perf-stat.ps.cpu-cycles
    236872 ±  3%     -62.2%      89529        perf-stat.ps.cpu-migrations
 8.081e+10           -28.5%   5.78e+10        perf-stat.ps.instructions
      1052 ±  2%     -26.6%     772.51 ±  3%  perf-stat.ps.major-faults
   1946303           -25.8%    1444355        perf-stat.ps.minor-faults
   1947355           -25.8%    1445127        perf-stat.ps.page-faults
 5.212e+12           -28.2%  3.743e+12        perf-stat.total.instructions
   1446322           -31.9%     985202        sched_debug.cfs_rq:/.avg_vruntime.avg
   1331589           -33.0%     891687        sched_debug.cfs_rq:/.avg_vruntime.min
      0.58 ± 19%     +79.1%       1.04 ± 36%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.55 ± 16%     +77.9%       0.98 ± 39%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
     40041 ± 49%     -61.8%      15309 ± 55%  sched_debug.cfs_rq:/.left_deadline.avg
   1419040 ±  5%     -41.8%     825189 ± 46%  sched_debug.cfs_rq:/.left_deadline.max
    225255 ± 25%     -51.1%     110055 ± 48%  sched_debug.cfs_rq:/.left_deadline.stddev
     40038 ± 49%     -61.8%      15308 ± 55%  sched_debug.cfs_rq:/.left_vruntime.avg
   1418965 ±  5%     -41.8%     825144 ± 46%  sched_debug.cfs_rq:/.left_vruntime.max
    225243 ± 25%     -51.1%     110049 ± 48%  sched_debug.cfs_rq:/.left_vruntime.stddev
   1446322           -31.9%     985202        sched_debug.cfs_rq:/.min_vruntime.avg
   1331589           -33.0%     891687        sched_debug.cfs_rq:/.min_vruntime.min
      0.45 ±  7%     -20.1%       0.36 ± 11%  sched_debug.cfs_rq:/.nr_queued.avg
     40038 ± 49%     -61.8%      15308 ± 55%  sched_debug.cfs_rq:/.right_vruntime.avg
   1418965 ±  5%     -41.8%     825144 ± 46%  sched_debug.cfs_rq:/.right_vruntime.max
    225243 ± 25%     -51.1%     110049 ± 48%  sched_debug.cfs_rq:/.right_vruntime.stddev
    316.07 ±  4%     -11.5%     279.72 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
     35.19 ± 10%     +38.1%      48.59 ±  7%  sched_debug.cfs_rq:/.util_est.avg
    381.67 ± 12%     +57.6%     601.42 ± 37%  sched_debug.cfs_rq:/.util_est.max
     82.50 ±  9%     +46.0%     120.45 ± 17%  sched_debug.cfs_rq:/.util_est.stddev
    396977 ±  2%     +53.4%     608768 ±  3%  sched_debug.cpu.avg_idle.avg
    689451 ± 15%    +143.0%    1675552 ±  3%  sched_debug.cpu.avg_idle.max
    147729 ±  4%    +131.0%     341197 ±  3%  sched_debug.cpu.avg_idle.stddev
    417028 ±  8%     -53.3%     194673 ± 16%  sched_debug.cpu.curr->pid.avg
    629369           -26.0%     465421        sched_debug.cpu.curr->pid.max
    294569 ±  4%     -22.9%     227025 ±  2%  sched_debug.cpu.curr->pid.stddev
    502128          +117.5%    1092091 ±  4%  sched_debug.cpu.max_idle_balance_cost.avg
    574484 ±  6%    +159.2%    1488876        sched_debug.cpu.max_idle_balance_cost.max
     11416 ± 54%   +2771.4%     327806 ±  6%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.58 ± 20%     +79.7%       1.05 ± 35%  sched_debug.cpu.nr_running.stddev
    315961 ±  2%     -40.3%     188594        sched_debug.cpu.nr_switches.avg
    341737 ±  3%     -40.8%     202449        sched_debug.cpu.nr_switches.max
    290036 ±  3%     -40.4%     172717 ±  2%  sched_debug.cpu.nr_switches.min
     10767 ± 13%     -56.2%       4715 ±  8%  sched_debug.cpu.nr_switches.stddev
     28958 ± 37%     -97.5%     731.50 ± 14%  sched_debug.cpu.nr_uninterruptible.max
    -32078           -97.8%    -713.50        sched_debug.cpu.nr_uninterruptible.min
     15562 ± 12%     -98.1%     289.97 ±  8%  sched_debug.cpu.nr_uninterruptible.stddev



***************************************************************************************************
lkp-ivb-2ep2: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-ivb-2ep2/custom/reaim

commit: 
  d398a68e8b ("# gpg: Signature made Wed 25 Jun 2025 12:55:36 AM CEST")
  155213a2ae ("sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails")

d398a68e8bcf430e 155213a2aed42c85361bf4f5c81 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2751768           +31.8%    3625521        cpuidle..usage
    244468           -12.5%     213910        meminfo.Shmem
     67870 ± 12%     -36.0%      43451 ± 25%  numa-meminfo.node0.Shmem
     16971 ± 12%     -36.0%      10862 ± 25%  numa-vmstat.node0.nr_shmem
     22456           +10.2%      24746        vmstat.system.cs
     29699            -2.7%      28893        vmstat.system.in
    235226            -3.6%     226719        proc-vmstat.nr_active_anon
     61160           -12.7%      53408        proc-vmstat.nr_shmem
    235226            -3.6%     226719        proc-vmstat.nr_zone_active_anon
  84634471            -1.0%   83794728        proc-vmstat.pgfault
      9.21            -4.1%       8.83        reaim.child_systime
    200345            -1.6%     197127        reaim.jobs_per_min
      4173            -1.6%       4106        reaim.jobs_per_min_child
    208063            -1.4%     205202        reaim.max_jobs_per_min
      1.37            +1.6%       1.39        reaim.parent_time
      1.57           +14.2%       1.79        reaim.std_dev_percent
      0.02           +12.6%       0.02        reaim.std_dev_time
    694428            +2.1%     708915        reaim.time.involuntary_context_switches
  83722920            -1.0%   82882640        reaim.time.minor_page_faults
      1790            -1.8%       1758        reaim.time.percent_of_cpu_this_job_got
    827.12            -5.0%     785.39        reaim.time.system_time
      4582            -1.4%       4516        reaim.time.user_time
   3416214            +3.8%    3544780        reaim.time.voluntary_context_switches
 3.984e+09            -1.0%  3.945e+09        perf-stat.i.branch-instructions
  93750720            -2.0%   91894628        perf-stat.i.branch-misses
  20761230            -4.4%   19838319        perf-stat.i.cache-misses
 5.361e+08            -1.9%  5.261e+08        perf-stat.i.cache-references
     22622           +10.3%      24942        perf-stat.i.context-switches
 5.542e+10            -1.6%  5.451e+10        perf-stat.i.cpu-cycles
      4805           -34.5%       3146        perf-stat.i.cpu-migrations
      2298            +2.7%       2360        perf-stat.i.cycles-between-cache-misses
     24.96            -2.6%      24.32        perf-stat.i.major-faults
      0.72            -3.6%       0.70        perf-stat.overall.MPKI
      2.35            -0.0        2.33        perf-stat.overall.branch-miss-rate%
      3.87            -0.1        3.77        perf-stat.overall.cache-miss-rate%
      2671            +2.9%       2748        perf-stat.overall.cycles-between-cache-misses
 3.976e+09            -1.1%  3.932e+09        perf-stat.ps.branch-instructions
  93531177            -2.1%   91575021        perf-stat.ps.branch-misses
  20704009            -4.5%   19772387        perf-stat.ps.cache-misses
 5.349e+08            -2.0%  5.244e+08        perf-stat.ps.cache-references
     22556           +10.2%      24861        perf-stat.ps.context-switches
  5.53e+10            -1.7%  5.434e+10        perf-stat.ps.cpu-cycles
      4791           -34.6%       3135        perf-stat.ps.cpu-migrations
     24.90            -2.6%      24.24        perf-stat.ps.major-faults
 8.705e+12            -1.2%  8.603e+12        perf-stat.total.instructions
      3637 ±182%    +405.5%      18389 ± 46%  sched_debug.cfs_rq:/.left_deadline.avg
    174600 ±182%    +404.2%     880249 ± 46%  sched_debug.cfs_rq:/.left_deadline.max
     24937 ±182%    +404.8%     125892 ± 46%  sched_debug.cfs_rq:/.left_deadline.stddev
      3637 ±182%    +405.6%      18389 ± 46%  sched_debug.cfs_rq:/.left_vruntime.avg
    174590 ±182%    +404.2%     880238 ± 46%  sched_debug.cfs_rq:/.left_vruntime.max
     24936 ±182%    +404.9%     125890 ± 46%  sched_debug.cfs_rq:/.left_vruntime.stddev
      0.53 ± 15%     -33.5%       0.36 ± 20%  sched_debug.cfs_rq:/.nr_queued.avg
      0.22 ±  4%     +20.8%       0.27 ±  6%  sched_debug.cfs_rq:/.nr_queued.stddev
      3637 ±182%    +405.6%      18389 ± 46%  sched_debug.cfs_rq:/.right_vruntime.avg
    174590 ±182%    +404.2%     880238 ± 46%  sched_debug.cfs_rq:/.right_vruntime.max
     24936 ±182%    +404.9%     125890 ± 46%  sched_debug.cfs_rq:/.right_vruntime.stddev
    490.14 ± 15%     -33.2%     327.41 ± 18%  sched_debug.cfs_rq:/.runnable_avg.avg
    479.36 ± 15%     -34.1%     315.71 ± 18%  sched_debug.cfs_rq:/.util_avg.avg
    252.52 ± 15%     -30.9%     174.46 ± 14%  sched_debug.cfs_rq:/.util_est.avg
    576228 ± 12%    +207.9%    1774075 ±  8%  sched_debug.cpu.avg_idle.avg
    857190 ±  7%    +195.1%    2529825 ±  2%  sched_debug.cpu.avg_idle.max
    239937 ± 20%    +270.6%     889275 ± 19%  sched_debug.cpu.avg_idle.min
    140065 ± 12%    +189.6%     405634 ± 18%  sched_debug.cpu.avg_idle.stddev
    500464          +173.2%    1367211        sched_debug.cpu.max_idle_balance_cost.avg
    520355 ±  3%    +184.5%    1480316        sched_debug.cpu.max_idle_balance_cost.max
    500000          +162.2%    1310892        sched_debug.cpu.max_idle_balance_cost.min
      2944 ± 77%   +1645.0%      51378 ±  8%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.59 ± 16%     -33.1%       0.39 ± 21%  sched_debug.cpu.nr_running.avg
     69757 ±  7%     +13.8%      79388        sched_debug.cpu.nr_switches.avg
     61961 ±  7%     +12.0%      69378 ±  3%  sched_debug.cpu.nr_switches.min
   -176.61           -34.1%    -116.39        sched_debug.cpu.nr_uninterruptible.min
      0.06 ± 41%     -93.8%       0.00 ± 75%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.__vm_munmap.elf_load.load_elf_interp
      0.02 ± 15%     +48.0%       0.03 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.09 ± 22%    +121.0%       0.21 ± 57%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      0.07 ± 36%    +203.4%       0.21 ± 55%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.shmem_unlink.vfs_unlink.do_unlinkat
      0.08 ± 25%     +57.0%       0.12 ± 30%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_lookupat
      0.07 ± 24%     +53.3%       0.11 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.06 ± 31%     +71.5%       0.11 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
      0.11 ± 81%     -81.1%       0.02 ±135%  perf-sched.sch_delay.avg.ms.__cond_resched.filemap_read.vfs_read.__x64_sys_pread64.do_syscall_64
      0.06 ± 27%     -57.9%       0.03 ± 73%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_shrink
      0.11 ± 65%     -78.4%       0.02 ±106%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.create_init_stack_vma.alloc_bprm
      0.07 ±105%    +199.5%       0.20 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_file_read_iter.vfs_read.ksys_read
      0.06 ±  4%     +64.5%       0.11 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.07 ± 60%    +243.3%       0.24 ± 51%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
      0.08 ± 19%     +76.8%       0.15 ± 31%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.06 ±  8%     +42.3%       0.08 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.03 ±105%    +245.9%       0.11 ± 83%  perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
      0.12           +13.4%       0.14 ±  2%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.07 ±  5%     +24.3%       0.08 ± 12%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.08 ±  8%     +44.9%       0.11 ± 11%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.12 ±  3%     +72.6%       0.20 ±  5%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.08 ± 32%    +118.6%       0.17 ± 45%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.11 ± 10%     +49.0%       0.16 ± 13%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.09 ±  9%     +46.2%       0.13 ± 16%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.14 ±  2%     +25.2%       0.18 ±  5%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.08 ±  2%     +52.0%       0.12 ±  3%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.03 ±  3%     +24.9%       0.04 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.56 ± 37%    +143.9%       1.37 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.11 ± 79%     -95.3%       0.01 ± 95%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.__vm_munmap.elf_load.load_elf_interp
      0.26 ± 44%     +78.5%       0.46 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.dput.shmem_unlink.vfs_unlink.do_unlinkat
      0.14 ± 67%     -77.8%       0.03 ±163%  perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.vfs_read.__x64_sys_pread64.do_syscall_64
      0.41 ± 79%     -79.2%       0.08 ±128%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.create_init_stack_vma.alloc_bprm
      0.14 ± 57%    +207.8%       0.43 ± 75%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
      3.10 ± 17%     +29.8%       4.03 ±  9%  perf-sched.sch_delay.max.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.16 ±100%    +228.4%       0.52 ± 75%  perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
      2.95 ± 15%     +45.7%       4.29 ±  9%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.32 ± 34%     +77.1%       4.10 ±  9%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1.53 ± 10%    +113.5%       3.26 ± 10%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      2.64 ± 16%     +67.3%       4.42 ± 14%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.44 ± 70%    +627.6%       3.21 ± 59%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.06           +21.6%       0.08        perf-sched.total_sch_delay.average.ms
     86668 ±  5%     -29.9%      60737 ±  3%  perf-sched.total_wait_and_delay.count.ms
      0.07 ±  5%     +67.1%       0.12 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      4.38 ± 12%     +21.1%       5.31 ±  7%  perf-sched.wait_and_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
     98.20           +12.8%     110.81 ±  4%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2.23 ± 32%    +164.1%       5.89 ± 40%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    406.17 ±  6%     +45.4%     590.41 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      6.14 ±  3%     +16.9%       7.18 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     63.33 ± 10%     -76.1%      15.17 ±104%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__do_sys_clone3
    923.33 ±  6%     -39.3%     560.83 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2523 ±  6%     -24.1%       1916 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      7777 ±  7%     -19.7%       6243 ±  3%  perf-sched.wait_and_delay.count.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
     23123 ±  5%     -33.5%      15384 ±  4%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     22845 ±  5%     -33.8%      15125 ±  4%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2354 ±  9%     -54.0%       1083 ±  8%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1815 ±  7%     -24.9%       1363        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     80.33 ±  3%     -29.7%      56.50 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
    172.50 ± 11%     -32.8%     116.00 ± 22%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
    115.33 ± 39%     -61.7%      44.17 ± 63%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      7429 ±  4%     -26.7%       5444 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    794.50 ±  2%     -14.6%     678.83 ±  3%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      6432 ±  5%     -25.0%       4821 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3434 ±  5%     -23.8%       2618 ±  3%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2107 ± 24%     -58.5%     874.28 ± 80%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2777 ±  3%     -25.6%       2067 ± 11%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.20 ± 16%     +63.0%       0.33 ± 21%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.03 ± 65%    +333.5%       0.12 ± 56%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.06 ± 32%     +61.4%       0.10 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.path_openat
      0.01 ± 11%     +91.9%       0.01 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      4.32 ± 12%     +21.5%       5.25 ±  7%  perf-sched.wait_time.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
     98.15           +12.8%     110.75 ±  4%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2.16 ± 33%    +168.4%       5.81 ± 41%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    406.08 ±  6%     +45.4%     590.28 ±  3%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
     15.07 ± 59%     -99.1%       0.14 ± 45%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.filename_create
      6.11 ±  3%     +16.8%       7.14 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.68 ± 35%     -51.1%       0.33 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.79 ± 90%     -72.2%       0.22 ± 47%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      2107 ± 24%     -58.5%     874.27 ± 80%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    837.53 ± 44%     -99.8%       1.88 ± 41%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.filename_create
      2777 ±  3%     -25.6%       2067 ± 11%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     70.14            -4.2       65.94        perf-profile.calltrace.cycles-pp.runloop.multiuser.main
     70.14            -4.2       65.95        perf-profile.calltrace.cycles-pp.main
     70.14            -4.2       65.95        perf-profile.calltrace.cycles-pp.multiuser.main
     66.74            -3.8       62.97        perf-profile.calltrace.cycles-pp.sieve.runloop.multiuser.main
      1.44 ±  6%      -0.3        1.09 ± 11%  perf-profile.calltrace.cycles-pp.getdents64
      1.44 ±  6%      -0.3        1.09 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      1.44 ±  6%      -0.3        1.09 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      1.44 ±  6%      -0.3        1.09 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
      1.43 ±  6%      -0.3        1.09 ± 11%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      1.67 ±  2%      -0.2        1.45 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.55 ±  8%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.page_test.runloop.multiuser.main
      1.58 ±  2%      -0.2        1.38 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      2.20 ±  5%      -0.2        2.01        perf-profile.calltrace.cycles-pp._Fork
      1.92 ±  5%      -0.2        1.74 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.92 ±  5%      -0.2        1.74        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.92 ±  5%      -0.2        1.76        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      1.92 ±  5%      -0.2        1.76        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.04            -0.2        0.89 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.02            -0.1        0.88 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.82 ±  2%      -0.1        0.71 ±  4%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.77 ±  4%      -0.0        0.72 ±  2%  perf-profile.calltrace.cycles-pp.brk
      0.59 ±  5%      -0.0        0.55 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.57 ±  5%      -0.0        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      1.02            -0.0        0.99        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.89 ±  3%      +0.0        0.94        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.60 ±  4%      +0.1        0.65        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      1.08 ±  2%      +0.1        1.15        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      1.11 ±  3%      +0.1        1.18        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      1.14 ±  3%      +0.1        1.21        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      1.21 ±  2%      +0.1        1.28        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      0.44 ± 44%      +0.1        0.56        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.44 ± 44%      +0.1        0.55        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.42 ± 44%      +0.1        0.54        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66 ±  2%      +0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
      0.70 ±  3%      +0.1        0.82        perf-profile.calltrace.cycles-pp.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.82 ±  3%      +0.1        0.94        perf-profile.calltrace.cycles-pp.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      2.49 ±  2%      +0.2        2.64        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      2.46 ±  2%      +0.2        2.62        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      2.50 ±  2%      +0.2        2.66        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1.74 ±  3%      +0.3        2.06        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.88 ±  3%      +0.3        2.21        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.17 ±  3%      +0.4        2.55        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.20 ±  3%      +0.4        2.57        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      2.29 ±  3%      +0.4        2.68        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.26 ±  5%      +0.4        1.72 ±  2%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      1.16 ±  8%      +0.5        1.65 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
      0.00            +0.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.00            +0.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.46 ±  5%      +0.5        2.00 ±  3%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      1.28 ±  7%      +0.5        1.82 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64
      1.34 ±  7%      +0.6        1.90 ±  7%  perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      1.43 ±  6%      +0.6        2.03 ±  7%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.75 ±  5%      +0.6        2.40 ±  2%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.17 ±141%      +0.7        0.88 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.17 ±141%      +0.7        0.88 ±  3%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.95 ± 22%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.95 ± 22%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.74            +1.8       10.53        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      9.00            +1.9       10.86        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      8.23            +1.9       10.10        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      8.99            +1.9       10.85        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      9.00            +1.9       10.86        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      8.16            +1.9       10.02        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      9.20            +1.9       11.09        perf-profile.calltrace.cycles-pp.common_startup_64
      6.34            +2.1        8.39        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      6.47 ±  5%      +2.2        8.72 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      6.46 ±  5%      +2.2        8.70 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     70.14            -4.2       65.94        perf-profile.children.cycles-pp.runloop
     70.14            -4.2       65.95        perf-profile.children.cycles-pp.multiuser
     70.17            -4.2       65.99        perf-profile.children.cycles-pp.main
     66.76            -3.8       62.99        perf-profile.children.cycles-pp.sieve
      0.44 ±  4%      -0.4        0.07 ±  8%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.56 ±  4%      -0.4        0.21 ±  5%  perf-profile.children.cycles-pp.__pick_next_task
      0.52 ±  4%      -0.3        0.18 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.44 ±  6%      -0.3        1.09 ± 11%  perf-profile.children.cycles-pp.getdents64
      0.48 ±  3%      -0.3        0.15 ± 10%  perf-profile.children.cycles-pp.sched_balance_rq
      1.14 ±  2%      -0.3        0.80 ±  2%  perf-profile.children.cycles-pp.__schedule
      0.78 ±  3%      -0.3        0.50 ±  2%  perf-profile.children.cycles-pp.schedule
      0.65 ±  4%      -0.2        0.44 ±  2%  perf-profile.children.cycles-pp.wait4
      0.30 ±  3%      -0.2        0.09 ± 13%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.28 ±  2%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.update_sd_lb_stats
      2.21 ±  5%      -0.2        2.02        perf-profile.children.cycles-pp._Fork
      2.71            -0.2        2.52 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.56            -0.2        2.38 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.22 ±  5%      -0.2        0.05 ± 46%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.60 ±  3%      -0.2        0.44 ±  2%  perf-profile.children.cycles-pp.kernel_wait4
      0.59 ±  3%      -0.2        0.43 ±  2%  perf-profile.children.cycles-pp.do_wait
      1.69            -0.1        1.57 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.71            -0.1        1.59 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.20 ±  3%      -0.1        0.10        perf-profile.children.cycles-pp.do_task_dead
      1.42            -0.1        1.34 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.36 ±  4%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.read
      0.67 ±  4%      -0.1        0.59 ±  5%  perf-profile.children.cycles-pp.write
      0.40 ±  6%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.78 ±  4%      -0.1        0.72 ±  2%  perf-profile.children.cycles-pp.brk
      0.60 ±  6%      -0.1        0.55 ±  2%  perf-profile.children.cycles-pp.page_test
      0.15 ±  3%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.schedule_timeout
      0.14 ±  3%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.__wait_for_common
      0.14 ±  3%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.wait_for_completion_state
      0.23 ± 10%      -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.14 ±  5%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.48 ±  6%      -0.0        0.44        perf-profile.children.cycles-pp.creat64
      0.32 ±  6%      -0.0        0.28 ±  5%  perf-profile.children.cycles-pp.__libc_fork
      0.14 ±  2%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.anon_pipe_read
      0.18 ± 11%      -0.0        0.13 ±  7%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.35 ±  8%      -0.0        0.31 ±  2%  perf-profile.children.cycles-pp.read_write_close
      0.33 ±  2%      -0.0        0.30 ±  3%  perf-profile.children.cycles-pp.vfs_read
      0.33 ±  2%      -0.0        0.30 ±  4%  perf-profile.children.cycles-pp.ksys_read
      0.38 ±  2%      -0.0        0.35 ±  3%  perf-profile.children.cycles-pp.__libc_sigaction
      0.13 ±  5%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.13 ±  5%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.10 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.10 ±  6%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.clockevents_program_event
      0.11 ±  6%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.sighandler
      0.15 ±  6%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.tcp_test
      0.14 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.unlink
      0.05 ±  8%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.kill_pid_info_type
      0.10 ±  4%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.10 ±  3%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__put_user_4
      0.10 ±  6%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.13 ±  5%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.__slab_free
      0.11 ±  4%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.09 ±  7%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.lru_add
      0.08 ±  4%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.pgd_alloc
      0.08 ±  5%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.vfs_open
      0.07 ±  5%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.do_dentry_open
      0.24 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.16 ±  5%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.sock_write_iter
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.worker_thread
      0.18 ±  2%      +0.0        0.20 ±  5%  perf-profile.children.cycles-pp.rmqueue
      0.08            +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.10 ±  8%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      0.08 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.33 ±  2%      +0.0        0.35 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.20 ±  3%      +0.0        0.22 ±  4%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.13 ±  3%      +0.0        0.15 ± 11%  perf-profile.children.cycles-pp.step_into
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.22 ±  4%      +0.0        0.24 ±  4%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.24 ±  4%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.12 ±  4%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.22 ±  6%      +0.0        0.24 ±  4%  perf-profile.children.cycles-pp.vma_merge_new_range
      0.06 ±  6%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__vmalloc_node_noprof
      0.06 ±  9%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.20 ±  6%      +0.0        0.23        perf-profile.children.cycles-pp.folio_add_lru
      0.17 ±  5%      +0.0        0.20 ±  8%  perf-profile.children.cycles-pp.__pte_alloc
      0.19 ±  5%      +0.0        0.22 ±  5%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.31 ±  3%      +0.0        0.34 ±  5%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.38 ±  4%      +0.0        0.41 ±  5%  perf-profile.children.cycles-pp.folios_put_refs
      0.30 ±  3%      +0.0        0.33 ±  4%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.39 ±  3%      +0.0        0.42 ±  4%  perf-profile.children.cycles-pp.kthread
      0.45 ±  3%      +0.0        0.49 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap
      0.43 ±  3%      +0.0        0.46 ±  3%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.45 ±  3%      +0.0        0.48 ±  3%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.24 ±  5%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.28 ±  2%      +0.0        0.32 ±  4%  perf-profile.children.cycles-pp.wake_up_new_task
      0.42 ±  3%      +0.0        0.45        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.42 ±  3%      +0.0        0.46        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.41 ±  5%      +0.0        0.45 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
      0.30 ±  6%      +0.0        0.34 ±  4%  perf-profile.children.cycles-pp.anon_vma_clone
      0.92 ±  2%      +0.0        0.96        perf-profile.children.cycles-pp.__x64_sys_openat
      0.36 ±  4%      +0.0        0.40 ±  3%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.18 ±  2%      +0.0        0.22 ±  4%  perf-profile.children.cycles-pp.schedule_tail
      0.44 ±  3%      +0.0        0.48 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.36 ±  2%      +0.0        0.40 ±  3%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.03 ±100%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.47 ±  3%      +0.0        0.52 ±  2%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.48 ±  4%      +0.0        0.53        perf-profile.children.cycles-pp.__x64_sys_creat
      0.39 ±  4%      +0.0        0.44 ±  5%  perf-profile.children.cycles-pp.do_brk_flags
      0.13 ±  2%      +0.1        0.18 ±  5%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.process_one_work
      0.96 ±  3%      +0.1        1.02        perf-profile.children.cycles-pp.zap_present_ptes
      0.48 ±  3%      +0.1        0.54 ±  2%  perf-profile.children.cycles-pp.copy_pte_range
      0.42 ±  2%      +0.1        0.48 ±  3%  perf-profile.children.cycles-pp.clear_page_erms
      0.43 ±  2%      +0.1        0.49 ±  4%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.91 ±  4%      +0.1        0.97        perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.60 ±  3%      +0.1        0.65 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.35 ±  4%      +0.1        0.41 ±  8%  perf-profile.children.cycles-pp.mm_init
      0.84 ±  2%      +0.1        0.90 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.66 ±  3%      +0.1        0.72        perf-profile.children.cycles-pp.free_pgtables
      0.64 ±  2%      +0.1        0.71 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.76            +0.1        1.83 ±  2%  perf-profile.children.cycles-pp.do_execveat_common
      0.62 ±  4%      +0.1        0.68 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      1.77 ±  2%      +0.1        1.84 ±  2%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.63 ±  3%      +0.1        0.70 ±  2%  perf-profile.children.cycles-pp.copy_p4d_range
      1.17 ±  2%      +0.1        1.24        perf-profile.children.cycles-pp.zap_pte_range
      1.16 ±  2%      +0.1        1.24        perf-profile.children.cycles-pp.__mmap_region
      0.65 ±  3%      +0.1        0.73 ±  3%  perf-profile.children.cycles-pp.copy_page_range
      0.83            +0.1        0.91 ±  2%  perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      1.20 ±  2%      +0.1        1.28        perf-profile.children.cycles-pp.zap_pmd_range
      0.63            +0.1        0.71 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      0.88            +0.1        0.96 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol
      1.36 ±  2%      +0.1        1.44        perf-profile.children.cycles-pp.do_mmap
      0.63            +0.1        0.72 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.25 ±  2%      +0.1        1.33        perf-profile.children.cycles-pp.unmap_page_range
      1.40 ±  3%      +0.1        1.49        perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.23 ±  2%      +0.1        1.32        perf-profile.children.cycles-pp.path_openat
      1.40 ±  2%      +0.1        1.48        perf-profile.children.cycles-pp.do_sys_openat2
      1.32 ±  2%      +0.1        1.41        perf-profile.children.cycles-pp.unmap_vmas
      0.63 ±  3%      +0.1        0.72 ±  3%  perf-profile.children.cycles-pp.wp_page_copy
      1.24 ±  2%      +0.1        1.34        perf-profile.children.cycles-pp.do_filp_open
      0.68 ±  3%      +0.1        0.78 ±  3%  perf-profile.children.cycles-pp.__do_sys_brk
      1.15            +0.1        1.26 ±  2%  perf-profile.children.cycles-pp.do_read_fault
      1.36            +0.1        1.47        perf-profile.children.cycles-pp.do_pte_missing
      1.10            +0.1        1.21        perf-profile.children.cycles-pp.filemap_map_pages
      1.56 ±  2%      +0.2        1.72 ±  2%  perf-profile.children.cycles-pp.dup_mmap
      2.46 ±  2%      +0.2        2.63        perf-profile.children.cycles-pp.exit_mmap
      2.51 ±  2%      +0.2        2.67        perf-profile.children.cycles-pp.exit_mm
      2.49 ±  2%      +0.2        2.65        perf-profile.children.cycles-pp.__mmput
      1.78 ±  2%      +0.2        2.00 ±  3%  perf-profile.children.cycles-pp.dup_mm
      2.80            +0.3        3.06 ±  2%  perf-profile.children.cycles-pp.kernel_clone
      3.21            +0.3        3.48        perf-profile.children.cycles-pp.__handle_mm_fault
      2.35 ±  2%      +0.3        2.62 ±  2%  perf-profile.children.cycles-pp.copy_process
      3.45            +0.3        3.72        perf-profile.children.cycles-pp.handle_mm_fault
      2.32 ±  2%      +0.3        2.62 ±  2%  perf-profile.children.cycles-pp.__do_sys_clone
      3.91            +0.3        4.22        perf-profile.children.cycles-pp.exc_page_fault
      3.87            +0.3        4.18        perf-profile.children.cycles-pp.do_user_addr_fault
      4.18            +0.3        4.50        perf-profile.children.cycles-pp.asm_exc_page_fault
      1.28 ±  7%      +0.5        1.77 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.67 ±  6%      +0.5        2.21 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
      1.36 ±  7%      +0.5        1.90 ±  7%  perf-profile.children.cycles-pp.scan_positives
      1.46 ±  7%      +0.6        2.04 ±  6%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      1.46 ±  7%      +0.6        2.04 ±  6%  perf-profile.children.cycles-pp.iterate_dir
      1.46 ±  7%      +0.6        2.04 ±  6%  perf-profile.children.cycles-pp.dcache_readdir
     15.98            +1.2       17.22        perf-profile.children.cycles-pp.do_syscall_64
     16.04            +1.2       17.27        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      8.94            +1.8       10.75        perf-profile.children.cycles-pp.cpuidle_idle_call
      9.00            +1.9       10.86        perf-profile.children.cycles-pp.start_secondary
      8.42            +1.9       10.30        perf-profile.children.cycles-pp.cpuidle_enter
      9.20            +1.9       11.09        perf-profile.children.cycles-pp.do_idle
      8.40            +1.9       10.29        perf-profile.children.cycles-pp.cpuidle_enter_state
      9.20            +1.9       11.09        perf-profile.children.cycles-pp.common_startup_64
      9.20            +1.9       11.09        perf-profile.children.cycles-pp.cpu_startup_entry
      6.49            +2.1        8.57        perf-profile.children.cycles-pp.intel_idle
     66.20            -3.7       62.46        perf-profile.self.cycles-pp.sieve
      0.18 ±  4%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.07 ± 12%      -0.0        0.04 ± 72%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.07 ±  9%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.15 ±  4%      +0.0        0.17 ±  5%  perf-profile.self.cycles-pp.zap_pte_range
      0.08 ± 10%      +0.0        0.10 ± 14%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.anon_vma_clone
      0.14 ±  6%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.58            +0.0        0.61        perf-profile.self.cycles-pp.zap_present_ptes
      0.15 ±  7%      +0.0        0.17 ±  5%  perf-profile.self.cycles-pp.do_syscall_64
      0.17 ±  6%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.__vma_start_write
      0.26            +0.0        0.29 ±  6%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.37 ±  2%      +0.0        0.41 ±  2%  perf-profile.self.cycles-pp.filemap_map_pages
      0.40 ±  3%      +0.0        0.45 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.39 ±  2%      +0.1        0.44 ±  2%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.41 ±  3%      +0.1        0.47 ±  3%  perf-profile.self.cycles-pp.clear_page_erms
      0.84 ±  2%      +0.1        0.90 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.65 ±  3%      +0.1        0.70        perf-profile.self.cycles-pp.__irqentry_text_end
      0.42 ±  3%      +0.1        0.48 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      1.26 ±  7%      +0.5        1.76 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      6.48            +2.1        8.57        perf-profile.self.cycles-pp.intel_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


