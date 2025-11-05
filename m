Return-Path: <linux-kernel+bounces-885690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4536C33B32
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5A618C1436
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9001A254E;
	Wed,  5 Nov 2025 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmBmYeRG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382B34D3BD;
	Wed,  5 Nov 2025 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307221; cv=fail; b=D7Dvahn9LeOsf1FdRfsG577rAR0n4dm7THB/ZBJaM1jy4FojMleRwWTzk/kKFaYqO59uBpkZXrOwFVJ4aPF+chbvbMApJhP7m5e1pGTVHgLTlhQIq2IvVuyZLTaO7Qt995X9/dh6E27TdBdBrOBdVkUux8M5+nXu/VtLkCzacKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307221; c=relaxed/simple;
	bh=a/RH7EJ++2aRQcUq3ekOet3Cx4YZSwca1K1aYRBPqNs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DYMQW9DDkDwlHNY+y101A0ADiOrd9sbx60yBBNGO/htVXaX3U/SvVkAeJ8vjgfCATppkLFDrE/E1ZHa8PGZf5woHBwBggrTZyVpv8y8L3RE/5EUD73xp5Rs6TwYMCJ+m2DCgVHc/3wCg72gfYYq4WPNyc9gMdq5xx2/DtjvSW3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmBmYeRG; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762307219; x=1793843219;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=a/RH7EJ++2aRQcUq3ekOet3Cx4YZSwca1K1aYRBPqNs=;
  b=CmBmYeRG0eJI+igaXir3n6KHEaAAZM39aAdJZH8K456dIlm2O50Usbso
   H3RdM17oM5DJP9zTg6GaIOFqlR1X1SxUBmG/cPjpBynCamRVamO078Hia
   lPkK5qYrQ0A9bu1BWOFY1DU0uM7zAb5UrIedwXfHL2Gcniavh3ZVm/suT
   YO/cQ2DAtj3SxquvWnjej+2SfT9YWACRtjbE+ehGj9H0gsCpbItQ5EWCt
   k7fvfL5jPFrRHtD9X0uLcsThQjnwKNPzrYga50QTz9fsGRbkELWeQ1lL8
   c8c+Zjj7FtzeapBz9oiAfgKv2s9l7SCVfUgXAL8UpemS9bRJMKKAmkN+V
   A==;
X-CSE-ConnectionGUID: UcARBynWSCGxHauIsAy4hA==
X-CSE-MsgGUID: 9az0hipsQJqBMsZk76KLLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="81819007"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="81819007"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 17:46:58 -0800
X-CSE-ConnectionGUID: 7PSCe8pnTpyIv1XlAjp0GQ==
X-CSE-MsgGUID: Rm289wO1SuerTwXrsdc+Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="191412490"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 17:46:55 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 17:46:51 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 17:46:51 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.23)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 17:46:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dASq88vqkfRjkok9p/1KmzqmgoGLc953UVGr/ofyKk4S0pzoHtEjU54CaIn0mgu7uRSq4N/X5GFedMRXlu5/06KmbCeQ4wOAecvp3C9ICCHt2oXsHD/3+ObtTcx6pk1jqIaG6DKjvBJ60cSnZ6UF0uNfDIVJM8927ucWbf+CC2Ac9iC9XgQAFgqsGeqGzoQR9mIw4aLKUk+4PEnRZMT87MjVwp/ahN54Z04lNj1tFEsFBKK63poqHcqB/sjHKLDjz+24bGttJmXes4ExKY/AUvKS60aB3lLj67T+5P6/cVyTj7j+1jrXK6b7ldEaiUN6NO8zky8HTCVSTjipLNeqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XO7hqKS2qg6+IQyIEJtTxFa6GpeCIHBYef37t5Ql/M=;
 b=plbgUWPmd1haHmRAHzQrdmzec94pHrqj81s1QLNEX8RbmEX3iRw6jC0ng0MsZCkrqioGcKkH/nbQZaO3NPe49nIaaMt8sMnSsGjdR2y3gEzb1e3/2qdA5esEgJ2FzgFj/1hzbi9mv30CExoDDRulsQW6N4v3RtALAz7V5NKFJ+Zt0w2PwLnmMbqlQLlFdlajMRdgZagd3NSDnuBdP8ppuj7cowpzybj2PWVR/az30eUY0n+vrI9LKrjYNBrdhvNvOpjjcFxZTkebtW1uw6dYrPeCmEH25iC4qUwJ0IIZVhZtPQqPOgahpZYSYAooxkLhewsKgqXAae+Ct7AZKiFRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by CH3PR11MB8314.namprd11.prod.outlook.com (2603:10b6:610:170::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 01:46:48 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 01:46:48 +0000
Date: Wed, 5 Nov 2025 09:46:38 +0800
From: Philip Li <philip.li@intel.com>
To: Lee Jones <lee@kernel.org>
CC: kernel test robot <lkp@intel.com>, Lukas Bulwahn <lbulwahn@redhat.com>,
	Samuel Kayode <samuel.kayode@savoirfairelinux.com>, <imx@lists.linux.dev>,
	<llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>, Frank Li
	<Frank.Li@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>, Sean Nyekjaer
	<sean@geanix.com>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in NXP PF1550 PMIC MFD
 DRIVER
Message-ID: <aQqsfl1d+9mh+w/R@rli9-mobl>
References: <20251029104228.95498-1-lukas.bulwahn@redhat.com>
 <202511011641.mVLMVN8V-lkp@intel.com>
 <20251103152321.GA8064@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103152321.GA8064@google.com>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|CH3PR11MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 90623a9a-91a4-4729-21f3-08de1c0d2ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0RuZEVTVGhYeXZhbmFDTFRZNGR4S0N5bmN3L0ZaNVNKN1d6aDZmVVpnYkky?=
 =?utf-8?B?SDZjUVkrM3RmcDd1TnczMmNhaVJ3Q2oyclN4SVFVcVNwTWxXZVZMOWJBTXBH?=
 =?utf-8?B?NmFXVmFZMWxrZUpENWNVY2k2dlZkMHBVbFJYeFZLVmZoMGRldkVtQzdvOUZI?=
 =?utf-8?B?YlRQNmxmUEw1UERXM0FJZHJvbGw3dVhzZnovakRZdHN3bi9sS1prbHZEcGRj?=
 =?utf-8?B?R0d2MHN6ZXk3bWNwdTZyWDJtbDlWSW5nd2RKR01IdjVHQUplSzBncTdFc1RL?=
 =?utf-8?B?ekl3dWxzZXcrWlJwMmE2aWdvanN1c1JvY05nZ1NXSWZxWmJVRkVnOSsyVGtF?=
 =?utf-8?B?MXI2a2lNNkkrWnVUYjBINHhPTkJGb2RSM0xtYUNkZThsZTR5YjVmUlZWYXFj?=
 =?utf-8?B?NG1RTHBtbW9CTmUyYzJMMWtndmhkQlVmS2U0YmFseEFaNjhyVGhUcDM1eTVE?=
 =?utf-8?B?eWhxelNCTGN3NUV4OEd1R3loY0VOUnNSaWprZTBLTkh2VVNqQXRTRVlrMXVS?=
 =?utf-8?B?UzMxUzZKZ2ljRTk4djhnMEhZZjc1UU1Gd2tnS2k1RVdCN1p0LzNxK1RDQmVo?=
 =?utf-8?B?VXJ6N3Yrd2QzMi9BYUhKOEdHbkZYajdsYzEvV3BqUjRUUFZnaUg3bTdQcXNy?=
 =?utf-8?B?M0lZZ2VFdHEyL3BDclNGQnVMYUNYOURibVBvS05uR0t4a25HS2wwSjRxVFM5?=
 =?utf-8?B?WHhWZUhZSWludGRCaGFyUlU5d2F0bXU1Z21nSmx6T0VlYzB2aU1YNnU2bDF5?=
 =?utf-8?B?SG4ydGw4ZVBDZ3ZkZFJmMGF6MStGYkhMUUtEMy9YUW9KTHJ5WlAyaXJyYnBt?=
 =?utf-8?B?V3I5OUlxQnRjTFQ0dkdRZll5YVNCMGp6SVNrYzdxM2FvUGRENVpaQWxVejFL?=
 =?utf-8?B?QTVzc1hMOVNlV1FrMjZDMk9nT1lFV1VCR1dHM0FJamJBbitvcm10ZDMrazND?=
 =?utf-8?B?S1B4cSt3aEFkdU5pdXN0T2dmdnRPQXM5bTZJckhPSis4V1JhaU51OU9mRlJq?=
 =?utf-8?B?anhSS0JSYlRFRHNwSDMwZndLZjNVVFpwYkJLUXRwRXlKVjdUakwxRFFZcklU?=
 =?utf-8?B?THFneFpCZUc2cDBVQUFXLzMzTk9hVnJRY2ptMXJtK095eW4wc29HNGVSMHdR?=
 =?utf-8?B?Rkt4K1lKOVVJY0N5K1NwVDdLVjlSemNZTjhlM09KbGVDMXVsR2FGbU0raFBs?=
 =?utf-8?B?T3dtbzJkU2lWTDd5LzNPdHRab3dwWnNqODZHU2JjK2JMSVRvaU5pSmJnVlgy?=
 =?utf-8?B?Q1k0d3ZTRTVTOUtkTklvWjJWUU41aG55UUlTUzE5V1d6a2JTa29KYk83V1Rq?=
 =?utf-8?B?TUdDL2xKaDIrcG9iVDZxM0loU2I2ZnRwdzBqVlRCUldxWlJCWllsdjFZVmds?=
 =?utf-8?B?T3JPTWpCWHhSMEVQbGphL012TnR0dDdhcUV2Y1hJbmlkWGJJZFNkNnZnWlFp?=
 =?utf-8?B?a0ozR25QMkVBK25YZ0ErQXFMODJ1Q0ZOd3JMUFdaUlNuUkNaYVE3MXRaQzZa?=
 =?utf-8?B?Rk9Pa0ozNWFjNzlxYU1uV0xrUk5pUmxWYnZMTmtLVDl4KzRqdXlwNCt2RWha?=
 =?utf-8?B?cjQ4YUJQY1pvNVUzaXh0Vy9pSjRTeGtBZWx3dlJaSk1CNEVoNHorOWdyc1o3?=
 =?utf-8?B?WVJUUVd1UUxFMENXaWxhcjBVOU9PQ1NGV2pSMk9FYW16TFo1MVcyMTVodDh3?=
 =?utf-8?B?T0dhcVZ6KzZlbGxYZjd4eVc0MUhNQm9PZGVkcVIxYVFqL01zRjlZMitJQ2Zo?=
 =?utf-8?B?UmtCUTYvNllteUFYSDcxYTAyVkQ3M3BqcnZZZDdBdlRkK1V3cVkvV3lGRVpS?=
 =?utf-8?B?S0lub3d2NXdBbG4rUVVFdlM4Yk0xR05UY1g0ZjlYRitYVHlaVkFqUUNST0Qw?=
 =?utf-8?B?OFdDRjNNeXJVTlBXVFpNcmRLZHpXdGczVUtaSkJKTFFpOXcwYVFDSmU4dGVQ?=
 =?utf-8?B?d1I2ZEVaMFhYUmt2RGpCczRMSzJzeXVZUFU3MW1PZ3h6WU16VHhKYTN0WGJW?=
 =?utf-8?B?bWNJMVY0ZFp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lSaVFlR0NORmNDTUU4NXFCYTVramQ5RlJlUW4xSVhSZFV6TWxWUElGM0hN?=
 =?utf-8?B?UVdUNEY0enRTcDZwZG1XcDd5V3hOY2R6aVJIeUhHSnFsVDhFZW5UYVVENEZO?=
 =?utf-8?B?bkZoN0RDMWtQVXR4UUt1MEZyL0t1dHAxbmpjeDVKUmpyZGsrc1Y1TGJZa3Z4?=
 =?utf-8?B?M2Y1QmhNdVBxQXBaUU1WV1Uvd25GVjUyZ1FKQWRuODQyOTFhS0gvVVNEZXNQ?=
 =?utf-8?B?OWhNcXN5MDVicmFYRG9KVTR3Vm52aTB5ZkVJQ2t1TU1lMmR6ZExqTEJmNVBh?=
 =?utf-8?B?TTZ2eERrbHVveFhuS1JkeFNGU09jbS80NWRKQ2Qwd3JIWjliczFFTXVDMUFG?=
 =?utf-8?B?L1grWlJGby9ZWjRVWXlQd29xdkR4eDJqamIyQ25YeVkxNHVXdFoyTWFEOTBF?=
 =?utf-8?B?eUw2b1J5bnpRWnNZTFNaNEprOXl4Q01HQUNPYXBFc0VYR0RJd3UrbklUeFdG?=
 =?utf-8?B?aVlDb2t4bGpHQnJiSXJCNk9nUk4vU2ttbFZibDJOSGRPcm9QelQxbHdBL0g4?=
 =?utf-8?B?SWtqZ3ArSGRUSmhPcXh3VkI0dmI3WUdtL1Q0Z0g4ZCthWHNGNEVOVlQzbUpy?=
 =?utf-8?B?OWN3TFMyYjZOeTROa3NFQUIvRDZVRCtQL2tTK20vb0lxS2V2Tis5ZjdGUmxB?=
 =?utf-8?B?dU9JV2w1S1hGbzZ3SGNhTUcvNXkyd1hORHNJUS9jVkpnSTJBMzhTQnoxZ2tQ?=
 =?utf-8?B?S09Xa3hVbWZhS0lZajZYOUR5YitXWTM3WDFuVEZBS1grMGxzRmtZMzdqalBi?=
 =?utf-8?B?bFlQUFRzMldvSnlMQkJEV2FwNXFZMnFRL0FsSFNBOXRTcCsyVmZCQVU1TXNp?=
 =?utf-8?B?NnhtMHRjYmR6Q0NkTkx2Zk9TSmtvY3d2SzVxRGtObEttcU1DQVVJbGZrK0h0?=
 =?utf-8?B?Ryt4bmowbHdnNEJYdXIrak45VGl2Y1dOa0x3b1NZSzlzeW05dTRNemtCdFpM?=
 =?utf-8?B?Q3FKbGdUbTBmWFFRWkpqN1I0TEp5WWFwQ3ZWejhXV0VCbGJwTlBNbklzRnhP?=
 =?utf-8?B?WkdTd0s0d3BoZ2VtWHl4VUlqVFBweDBTa3pibzZ5ejNTSWVpTTQzU3BkSlBG?=
 =?utf-8?B?TngrY0pEb21mZy8vbnNnOFYxbFBKcHFkdUpXNGRQbXk5LzFFeW5rbG52cXhI?=
 =?utf-8?B?M01pczE0bjVwUytuQ2poZnU3ZWxNdS8yNmZIZnVOWnZucnA4UHlMRXR5Y09B?=
 =?utf-8?B?VGxtaG1IYnNCTmRNTDVreVB3VndVeVAwRnBuUG9INmd1cmh1ajUzWUNRWEsv?=
 =?utf-8?B?MWtqMlFxYWRLQkppSGlXRldLdFVhVkFRU05sQUM5dHRVTGIrWWFUU051eXBq?=
 =?utf-8?B?dGlTRlZjYkVBcnRML29zczhSM2lhdmtPdHVTNGtDOEpGSEtEaG5mZzNvMWtG?=
 =?utf-8?B?Q2hIVjdyY1ZINldWd0prbER0cjlxUGZqOUVNSlVjcHZBRzFFbDZnbFk0Zmpp?=
 =?utf-8?B?Y090S2p5K3gxZmk2WkU5cWYzbXl4MFpMY1VlZlNaSUxzb2IxNmFzUUJHRzF3?=
 =?utf-8?B?UWZiYW9WTC9UZzBwSG5rbVMxb0JXQUVzRy9ETGVrclpjTEdmT3o3c3U4Visv?=
 =?utf-8?B?N2FMcnRHMHVGUVhCSE1GTUxGRWtSWDV3SjVCQWNIQnZWdGxkSUMvZ01kZFk1?=
 =?utf-8?B?Yi9jdzBnT1ZYNzU2L2lpUy92ZTQ1YVQvaSt6WUhYVERJalZJWnZsYUZJZnpQ?=
 =?utf-8?B?dFNGMUw2dll1REpzREJ3REFPd0V3QmVEdzhxWHJTQklKcWRHZ3JnK2c4Tlli?=
 =?utf-8?B?VXdjUnNvbktlOVVpUHBPWkx4RGc0Y09YOHQ4T29nc1NNc2h6elJXS1pVSG50?=
 =?utf-8?B?SXZUSVBiOUg1em1UYUJabmxEUFZrNWVQRHRkcjBZRTl2RS8yalV1QVl2WDk0?=
 =?utf-8?B?TFYwYVJsaVhEV3NjV1AzTWNDcVZYOVF6L3d0NlVFRGZSeW93cnZSQnZGaTBK?=
 =?utf-8?B?SEY2ZGpTRUFKNml1VEs5eElVUzJVcFIwUUlEd1dHTzRBQzRUTzAxZk5BWFJs?=
 =?utf-8?B?LzR1Q2NhcDF5WFh1YVlJV1UxdGs4Y3FiTk9SdUpqaklldUM4UU15VTMxU3hZ?=
 =?utf-8?B?cndCcHdpdkxjbW11a2szSXJlU05XV1J1N3ZXQ2hPVUxPNXh6enorT0MwM3Ro?=
 =?utf-8?Q?/SrV2lMHSoIEH5KTmzqhslbBj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90623a9a-91a4-4729-21f3-08de1c0d2ead
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 01:46:47.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abuZZueg3bTkcan9+dsCdFmg9ndO5ZFxeL6RdsAnh1lc1O5b+R4/FMlhFJuylGCEh3cYWityxg+s0ny8SrmnKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8314
X-OriginatorOrg: intel.com

On Mon, Nov 03, 2025 at 03:23:21PM +0000, Lee Jones wrote:
> On Sat, 01 Nov 2025, kernel test robot wrote:
> 
> > Hi Lukas,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on next-20251029]
> > [cannot apply to lee-leds/for-leds-next linus/master v6.18-rc3 v6.18-rc2 v6.18-rc1 v6.18-rc3]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Lukas-Bulwahn/MAINTAINERS-adjust-file-entry-in-NXP-PF1550-PMIC-MFD-DRIVER/20251029-184717
> > base:   next-20251029
> > patch link:    https://lore.kernel.org/r/20251029104228.95498-1-lukas.bulwahn%40redhat.com
> > patch subject: [PATCH] MAINTAINERS: adjust file entry in NXP PF1550 PMIC MFD DRIVER
> > config: powerpc-randconfig-002-20251101 (https://download.01.org/0day-ci/archive/20251101/202511011641.mVLMVN8V-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511011641.mVLMVN8V-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202511011641.mVLMVN8V-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_task'; recompile with -fPIC
> >    >>> defined in vmlinux.a(init/init_task.o)
> >    >>> referenced by head_85xx.S:222 (arch/powerpc/kernel/head_85xx.S:222)
> >    >>>               arch/powerpc/kernel/head_85xx.o:(.head.text+0x41a) in archive vmlinux.a
> > --
> > >> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'init_task'; recompile with -fPIC
> >    >>> defined in vmlinux.a(init/init_task.o)
> >    >>> referenced by head_85xx.S:223 (arch/powerpc/kernel/head_85xx.S:223)
> >    >>>               arch/powerpc/kernel/head_85xx.o:(.head.text+0x41e) in archive vmlinux.a
> > --
> > >> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_thread_union'; recompile with -fPIC
> >    >>> defined in ./arch/powerpc/kernel/vmlinux.lds:146
> >    >>> referenced by head_85xx.S:230 (arch/powerpc/kernel/head_85xx.S:230)
> >    >>>               arch/powerpc/kernel/head_85xx.o:(.head.text+0x42a) in archive vmlinux.a
> 
> What is all of this nonsense?

Sorry for the wrong report, I will further check to block such false positive.

> 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> -- 
> Lee Jones [李琼斯]
> 

