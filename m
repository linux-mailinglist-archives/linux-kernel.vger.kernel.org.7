Return-Path: <linux-kernel+bounces-797598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1044FB41259
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01015E4179
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69E1D63CD;
	Wed,  3 Sep 2025 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdbShLCw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5BBA4A;
	Wed,  3 Sep 2025 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866688; cv=fail; b=JWW+4+vQ/+uOJ6fZZ6BKZfRAeszLrn3pfPyo2qIT+4z0tKKKNCFzr5yUEcrXxgtrajfL32REOwruxJ7prbGPpscuGhxfZpTIp5+Ui+CMP7ROHAhpkqIucmSIl5pxBnP5du6OduQDDZRO/A1yQPgGB+y9tmpeRXOEfwyy2mjWH2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866688; c=relaxed/simple;
	bh=oamhDx2aq71RLOxZqm7F4vR/loMxhTEb9IUZCjcHg6o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VrEUNxvxuQyLYh3UBa7cBCzbVN2XargO42jqoCupu0Fph6zQNwAxc5y4bbq89YMuS0ImUi0lj6Wk7L8JQHdIiMj2JVcvlX01WYvhATsPuOsgx16z2S03btYezIdq2Cz6Oip7TkZvo4Fd2R0u8knk1FYh6zR/pXOWbQjUb4FDMec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdbShLCw; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866687; x=1788402687;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oamhDx2aq71RLOxZqm7F4vR/loMxhTEb9IUZCjcHg6o=;
  b=WdbShLCwRbqnomgRHiHbQEu5rYjqyjmxKBZ4YZaF/wyewT7xpgCbQwpX
   zY2z/XY4FZ+WLdaumV+wsWPpLjqyyit0+jcKtpcHbMdPD1vLEOBrsaug5
   Gi57X/k2v1b3giyKKpMRskCzN8rJr4mgZP95ITHXan+sx33dRrzvruK+5
   ZkcoWMrO1EBlxFH22UfKOnQLezsrl51xyNO0diHbAN5+NWEmcoqLj6Y/6
   el9EnYPLYhWH1aDDUSqOkRw7vWfIEgi3HUdTf0bPq5Od4SZqL+BeyLmF5
   jGfNoXRwZvshf9HConPnwynCaFEVKae1lvDCzDjVT8umlukFGI4rg5YnK
   w==;
X-CSE-ConnectionGUID: b514qruFSzuEE6fiQ50bqw==
X-CSE-MsgGUID: QpbPH2bkT3yY9Lev5YVY6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59107107"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="59107107"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:31:26 -0700
X-CSE-ConnectionGUID: z5qPqaodTmqXt5J5GQJVwA==
X-CSE-MsgGUID: v/39eKF3RE6Pj+4nBXj+ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171009332"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:31:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:31:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:31:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:31:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/o+gIqmOV4cv93jDyK4XCLP5PAw0AIQ6B9Ro8y++T3O4/W2sstaQWR/83S6X/09dcM0If5Uyc+XagpZfroxP4TN9C0nMxov8fKtKhOv7zkKq2L55e4qqVsYNGDpMnKT0BvVxF8/XNpDKfMMU/Qas3ddnxFRUpotyEaCjHGklSZTFRautv6gO5RoH7y6SwmJGli9bh2r+/sA5zb5T5upMU4uA/8JWeYazXRqyye5bGRu+6sekDPmkHfkzWAYOGsTiiihyttzGRi5jEBrxj7990oOPdUd0QPbZgC2bBU3nkCO8umuEdBwe+D7QiIWHuz3e114tr/LljfpjooDQ3eq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wN9UX6/H/4vg3TcsU2vJccykfLrzuJPYhxdAN1oMUeY=;
 b=lO+lGmhiJLBlIjc6dDtgMBqWHQJSQ64R41PINSlYrkelCKIOasoXbrcZXyTum4tvqrdpQUUUWzmq6EauOKFwHBCS1rRcSSe3vWWGQ2rx7iS7Htyo+YIPO2j/EtUdQfWChz1PuszqG5pvV9KAavLXvhRro7i0DvnVlweVEZ7Yc1P7aKLV+2enIbf4p7Jq9t15LyteL7mq1tsD5tRR5S56fZXItSFGcFe/oTAuN4spDaXsKFtGva0STielUeyC7lNJ3Zu2iOriG+CbfFKl67MlD6QKtjVnHSYc8lm2yy4dxfiJQIEN1d9yl7w+uNVrUZ+Ue5QVXxBx+cmq40WqyCI4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:31:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:31:19 +0000
Message-ID: <456bde6a-0c98-43cf-b719-ad2ee459da7b@intel.com>
Date: Tue, 2 Sep 2025 19:31:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 13/33] fs/resctrl: Introduce interface to display
 number of free MBM counters
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <1faeb40f2ad9170120ea9e676109c84f979a27ba.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1faeb40f2ad9170120ea9e676109c84f979a27ba.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:303:6b::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de80924-457c-41c5-7231-08ddea91f72e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnNoMW4vUXk5RnVlK3JISDVpVlhBVVZnMzNsajM4UTJUSysvaEVVQW5nV202?=
 =?utf-8?B?dVp6NVZLRXllVi9qcjdZVE0zalk4ZlJobHRRL1UrS3NXNTZTRHJnUlNuK29v?=
 =?utf-8?B?TVRFdDFHYTd0QkNJRkVYU3VKS09BeXNzbWtTOEpGd21ObUxQRk14NjB1cmFY?=
 =?utf-8?B?cjFsczRZejlBMnFuQ01iTDJtVThEVW5tV0sra2N0eWxuVVBwUjI3dHJjT1hH?=
 =?utf-8?B?RXpSc2hmMUZtNjJkZ0hrQWlHV01abzlibkgzMlpQOEovN1JMWUFLMFRsd2FZ?=
 =?utf-8?B?UEJvNGc3b21sOWxmNzJQZ0VDRUxRRWVjZVhIZDhQRVNLNlRCNkpBcGExUWpI?=
 =?utf-8?B?WE9RMGczcDBIM29HbmlwcmVHbnp3K0QvSDdHVnpjSG5FRWNGdW01Z0dOQmtB?=
 =?utf-8?B?VzJ5WkJJbWc2WUZwZjJBQUNZaEZ0cGpuYmx3V2hqR1p6aHpaYkxoNXh3bzZr?=
 =?utf-8?B?WUFpNnFzbk5BQWJaZFBvcGNHZUNSaDhuYmdKenJnNTh0a241SjBwK2YvS21L?=
 =?utf-8?B?bTR3aDFWSU8yeWJQeHhRVnBmTW9lNnhQQmZXdzF2cXBnM1BaT3J6SzJDU2Zk?=
 =?utf-8?B?dzNJK2c5RDVhKzl0U01oTHVtNDJVMWpLOHp6a09UTHV3cmowaHoxK1ZocGdQ?=
 =?utf-8?B?OEMwRE1EWFZwMTFtWnNoV0hIb1dlajNRTTd6NkJ0cS90TDZxRVQ2b0pIU3gw?=
 =?utf-8?B?Nm1uQmNhT0VLcjlJQUUxbGJFeDBqZVRZL1hzL2NpM0xUeVZuSWNxVnlvWUpu?=
 =?utf-8?B?Z2g4dEFNajVhalRkWUxCeDhsZmdFYytqNXV2bGZMS3psOTk5K1RWMXVVTm5H?=
 =?utf-8?B?YlBpWTBjaUo2UEQrdk4xMGVOSEw5L1FkRVRyRTBmZWdoZ2VZczE1Q29zWmUx?=
 =?utf-8?B?VE00UCsrRS94WVZCa2hIZ3hjTWY4YzlHOHFMQ3FqWnVVVXNJbkt6blMvUWUr?=
 =?utf-8?B?bzdrMGFib215RjJ1NHFIcExtV0pZeS9ZUTY4U2dlNVI2dHhTU2thalo1MFNZ?=
 =?utf-8?B?Y2h2N3RKYldZOTFkakNuRzhEeERXOHdXZTJMd1lGcVZ6Nk9nNmNoaDZWRUFu?=
 =?utf-8?B?Z0ZoandGd0twOUEvNjljS0xRaXRsSjBGN3BUbHNnRENRREJvTHNCZThKRm5P?=
 =?utf-8?B?Y0R4OWpNTjFOdDFtbmVTOHZCMUM1RHR5THphRzF3aFpHNFBzTG9weFE2cFBL?=
 =?utf-8?B?bzhkbGhFZnJtN252WkZ2QmtlaDVOeFZteDhxS0hTNmQwNHd6NWZXRlVxRlRs?=
 =?utf-8?B?Rzd1eHJhTEtXTVRNODA2NlZlTExoa0cwL0ZDNnkxdExjUlhHajRJeXFjYXc2?=
 =?utf-8?B?TUxpVjdqMGV6NDMxR1BmbVJNSXZLTzBBRG1LZUJrYWJSY3VrbjV3VkNLYkRQ?=
 =?utf-8?B?aHByYmtpUTUwSFVoVWErM0hxaEtzOGpMeXhMRUUzbzBvcVZKM1BxM3FqWEJa?=
 =?utf-8?B?aUJQWFhaUDVSWUYydE5ScXRsUjVIc2gyRWNKWUswNUo1SkNJL3NxRy9kNklG?=
 =?utf-8?B?cU41VEt5aERPM0VvNUYyNlgwTmdITjJwV3JxbmIvdUVoYUR6OUFlSVprZENR?=
 =?utf-8?B?aVBtSXpBSGZuQ0YwWnRQejUyaHBFZS8vUmowVkdSUlRFUTZ0U0VWMHhrVGFW?=
 =?utf-8?B?UEVlNTMzWTlYWGk5dy9tY1ZKNHFiRkZBZ21VeDBBYjhPVG12SWU4WXdqYkcw?=
 =?utf-8?B?ODN3UWRmZkFQdVNaVXdqOGMrbGNoMkxPWGl1SmQ3VGVFNlZjdjBRci9WR1Ny?=
 =?utf-8?B?OXhXaEIvVXl2dVpab2pkNS81QlQ4OCsvNHBIMjdCR2lzNTlkK3RsRXpUSGdG?=
 =?utf-8?B?OFZXMDRRZjB3ZytQZ01wSHZCSVdlMFNQb2x6QTl3dGE1UW5ESmd0TWVmVzhO?=
 =?utf-8?B?Z3YyM2VUQXRGMjdHZ2luK3hRV0NDSXVNV2xtSTRlQTY5NlNpZzFMZGpIaTE0?=
 =?utf-8?Q?rpGDvUVFZmY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlFkL2JtamkvUmJHbU82S1EvZ1BadU9Ma1hTc2pJRUl6YXFuRGtlc1hFa0lJ?=
 =?utf-8?B?MjNuSUUxWEcyREJ5T25ETXErVGMwMHk0WUVmV1hSbVlVRXNLbTJ0UkI0b3lE?=
 =?utf-8?B?RzhvVm1lc056Q3p6WW9OdmFjMVhWREVYVURkTUFkVk1ubmtIQy9WMWFLMmtm?=
 =?utf-8?B?bUlkOW02eDRldlNpMGlVbkk3aXdIRGk0eTNIS2ZUWktpbUgzWEVLbmMyaEky?=
 =?utf-8?B?MWJYQUJQaHJIbXFSL2hlb1NyTW9mYmgwdk0rZVRKZFNDZ09Zc1VMdG5DVDJG?=
 =?utf-8?B?T1ZhMmZlbm1JK0V4V0NIaktoU25kVFd1Mk9JQ2VuZms0d0RaK09RQzEyYThi?=
 =?utf-8?B?cSsxR21jVUdGVVVXc0Q1Vk02RCs5d3l2RGNSVVhmdUxCU3lUN2hpVlM5K3Jw?=
 =?utf-8?B?b1dBWVRDQURJVUxLT0RnRXNOSVcrSHpOa2tqVFh0aldCb0hHSndGbkw1WEhy?=
 =?utf-8?B?ejArZFhwRVlTbVpMc0FQSzRSMTZua1k2Z3Vja1ZQVVVOY1NWbXoyMk9ySURn?=
 =?utf-8?B?R2xmaGEwRXFWOS9NVGQrbUxSbWRvaFZoL1Y0dE5WTDA4N3ByUmQ2UGxyeElR?=
 =?utf-8?B?Q2dLUStON0Vhdi8zcFZBME1VWUd3ZzF1eVdlNTZ4dWloZ1dETENpYU92QlZj?=
 =?utf-8?B?enRwUFdPK3B0MGFtOHlBQS90cmhJSlk5cTNsYkd1aG92WWQ1dFVyTnFmRmVJ?=
 =?utf-8?B?SGNPL1Y5QzZJcHVIQkhKbDJ2Q2xxMGxNSDZpS0hVd1JYTE8rKzR6eHc5WDFj?=
 =?utf-8?B?cnpkUTB5SDgwdGlhSG1rMDdwNVJTcEE5c24rUHJiZG9xVnVuRWVHY2lYdEFt?=
 =?utf-8?B?K2IvV2RRNllTdmVaQnRZa2xaY3JoU25ma3hvNk1jTFBNNTBIUU40WmNDc2g1?=
 =?utf-8?B?SmJTZHNMMmJOc3duc1BkKzlVRlZ3Wm9PTzlscnZ5d29tVkM2ZGRGN3JFcmpF?=
 =?utf-8?B?L3BSeURLUlVxUFhpbWxxdGRGelFObDVkN0R6YXEwMjdEUTdPVDNGVEd2bTcw?=
 =?utf-8?B?TDJXOUhCWXpqZkkyS3JvNiszNEVkOW90UzNxTzgwdVBFaFpKbTlQTFNmbUZ6?=
 =?utf-8?B?SzJvaUpnVVJ1WUFTZkRZbG1GRkNaOUpRTE1hczArNU1OVVQrQ1VaVGJ0V3ha?=
 =?utf-8?B?Y1VKVzJSalVVOXp1NDZ6OXA2dHFPMGlPeVRPOSt3aDFlVUlFRFIza05PQi9D?=
 =?utf-8?B?L0NqY3pRb1dXR3pIeWF3Q29zMThwTGpCL2dvekpIRjJkS1JwMEhQREN6SVZ6?=
 =?utf-8?B?RXQ2bTRocXF2NVZXejllY2dDZllKeXE3djhXV3pxN1QvMkJIR2IxZTZ4QXRy?=
 =?utf-8?B?NERTOStTV2lhbTloNzBVSXZ4SDBOSFZDaTFtTnNmVEdDNnRKUnlreXZpcXYz?=
 =?utf-8?B?TjFrMEQ5TWVkR2RLMnB5THRaN2FsRnNBN1JVNkFWRzk0Rk54MVdHYWlyTlgz?=
 =?utf-8?B?a0h1WFlKd25PbDJDREl4OGFwOHNWaFFBV2N5dmJUM3Q1VEFuQzdSNWdjSEFN?=
 =?utf-8?B?OGFvNHRWRFVzY3ZtSGVJT201b0VkdEN1T0pxTFMxVFRPSjdUQmptQmZsUy9t?=
 =?utf-8?B?REQ1MSthcEpSS2pNdXBXZjdzOVp5cjBkOXAzU1J6M3FvNUhwTTJhVHhxNWVZ?=
 =?utf-8?B?VFF2ejBlMXJha0FORWNoaHpJMGhNbWhoSzNVVXRuT2RNK3V5Q3VnOXlCOHp0?=
 =?utf-8?B?YmkvR3VBNE0yczIwQTI1MlVLRjhxdnFBUFNlYzRiSXlDN0ZLTTEwc2xPd21m?=
 =?utf-8?B?Um43OVhWaFAyQWNuVzVZajUzbXZsYWFFY3kwemw4N291YXBpSm1xTmRJRm02?=
 =?utf-8?B?dXRLVmtaN0crc1VydjZyZzNYVUhoY0ZINExEdXVRZFlOWVdZTHorUlJyN3cr?=
 =?utf-8?B?eE1OcGFBQTVTVjZBeVlaU1FuN1dwNHJXQU9xajFpRzdkVHBtY0VFQmZYcVlh?=
 =?utf-8?B?cFdkQ2pHT2dDeFlwV0ZmNE80ak53NHBDMWtISlFzNmJMcnBzRjhid25xWEUy?=
 =?utf-8?B?R1RxRythVmkrejNRYXpJOS82VnpJY2hrcTh2cWNZeEw4Q3BtT0EyM3JtMDBV?=
 =?utf-8?B?UUtrUUkwVStrejUvWnFwMG16SkM3Zm1KaVFIUyt3MXJ0VXpBaWU0ZGl0NDM3?=
 =?utf-8?B?dDdIRUhkbkdEMEZmeCtZQjNPckdrWVhBOENvMWQ5bksweUttYmVMM2tmdVYz?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de80924-457c-41c5-7231-08ddea91f72e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:31:19.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phzd8LPJRsbqzCoEJXmrpayvIdAS3T31VMsfBuFnwTVgBkC5SbyKo+soDOVc4JhROTAI+j8yXUMb4+vJJsc10hhCj1TATEs4c1oRfqXyyts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> Introduce the "available_mbm_cntrs" resctrl file to display the number of
> counters available for assignment in each domain when "mbm_event" mode is
> enabled.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

