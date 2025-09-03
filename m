Return-Path: <linux-kernel+bounces-797638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A31EB412CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E5B3AC1E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3716C2C21E2;
	Wed,  3 Sep 2025 03:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbQg26gs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1C1C5496;
	Wed,  3 Sep 2025 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756869196; cv=fail; b=CwJpHLCpRp3EmnBgUtyKJc/a0DaT8V/qBSwo47Y5YUi5nCUwUoOOGKrdr3FSSmwoSgG36j1z1Hd47SUSiX7oIxz5k4uiJ+oHKZjnjo3HvL3tlVa4HeMbinchbn3HAovtxRA9X2e3odM/ZOwE4pzSi4ZD3BFLZEATInORwfbIEFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756869196; c=relaxed/simple;
	bh=JGFleP24A4IXmPl3/oo+khec88ncEKH8L53pgOpG28s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SRO9P2kJwnydHPMz7ZS2g4i5VK8HO3uPH0p/zJoWZAMfsentsAFSkmkdnoRBGGQVtOKHygFtL7vwJsaznn+tA0ZqcEcSuz5XYBuOYP0KyYmfd/BcyBclYceAFLUzrfJ5hYwxVdBTWzFd3Vwr0u9o5bLiqQdOPITtrcNwPCR6eAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbQg26gs; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756869195; x=1788405195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JGFleP24A4IXmPl3/oo+khec88ncEKH8L53pgOpG28s=;
  b=CbQg26gsWJxltcfdb9rjsfwgeJQDRsjJj7QzBXnBMU273pwPI5Cq9sLC
   jWHFt4faZGlJAH3+LQoRhtuDRjSU1lR2i2EXUNMYBqbu2tzBBuIPSwiG5
   mvqxhIDUI//0tKx/pUpkQmzid8bNEj6U+jvfO6QivoBewopNj0g+32M3a
   G7AwwWzyW9S1zrVUzpWhM9IQBcLY8/9LLfazd3dM3A3WQy0oomO21Bbbd
   fKnDuWU6w7YUup8lCqRCJKiJBsLPM8+JHi5IwjiUkWSCu2xu6CRh1Jujw
   KBYGajW2lWBzmxbnYjchIW2BC0k1E1vUe75+8n7jP3HmXyK/+569/IqP8
   Q==;
X-CSE-ConnectionGUID: WGGURap3TX+LbAC/9Vnjkw==
X-CSE-MsgGUID: HHP6Wz1qQHypX9987BC8zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69782588"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69782588"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:13:12 -0700
X-CSE-ConnectionGUID: 31WQ81YUSzShslBxjc07GQ==
X-CSE-MsgGUID: 3+a2/sqRQjKTMvyQOhKANQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="170727436"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:13:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 20:13:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 20:13:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 20:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DongAoE5CcIpcZzXtmKjGMxae48CO0VoZuhHk+WaqFavpi/NQIXQ89oj2t8PRXDuktQtsDORpvaRQkg/RJjG//1zTOO5imMNaCu8deQ5qrSdHpK8TJtw1n4EyMQttngZgzFzd33H0OXO+n7ZhE5V0t8Dpm0YLpvvww5+VkbhH6hwx3RpAbjicGLP1QWReg7+226S4zCYzzJpaimQzcgqJax3F9cAoMA3EbMa0gX3nL8tHdqXoOIkBpRgJ1gqcWNheYhLlmj8tij60nSYO0cdvAWHXDI2tb1QKUm/B/WLwXEEm54lsfcf1pukPssksJS4ueV/UI5WwtcY94y6kmkPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yraoqu/1CATUc1vIPJdfGQSfZBdLaTOzID3mUpRhW4c=;
 b=W3Zxx4PvWN5Hu0EHrH5FXxZZ9zB6mY6+mOqHTDW1OmWpODBxpBvMldUE7XRjHOoodNvFm0xN37eR2hN/v0Foliy0Amke64rI2jOkv8gmGN3T0w5Fi65bBJ93LuPWb3+CRKWC8CzK04BMklcwIDXB38NHF9yU0qyEeoEakZpkIhcjYsUm+ZV/dtpGiU4D0bWenr5VK0veO7AJuBXbZt5AROstvitcv6PEvDKUQ41H4Pn1ro25qZLrQ6NW7L9/UT8wMvtY3gkQ6isIPOF7yYLgu2oPlHhkASvE2hMX0lX7m7Jn6iqKBfllU0wet+DpwAnYCiGUCt/+ghJFCxvIA3DBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA4PR11MB9131.namprd11.prod.outlook.com (2603:10b6:208:55c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 3 Sep
 2025 03:13:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 03:13:06 +0000
Message-ID: <58cde22c-21f4-4b82-8f64-495fefe522e3@intel.com>
Date: Tue, 2 Sep 2025 20:13:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 32/33] x86/resctrl: Configure mbm_event mode if
 supported
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
 <d134276ad684e324dcecef489db6eea5dfdb8f9d.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d134276ad684e324dcecef489db6eea5dfdb8f9d.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:303:8e::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA4PR11MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a0ceca-597b-421d-fb6d-08ddea97cd98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0pGU1Z0TFpHYXlLUVY4L3UyN1lEYVpKV2U5VUxtQ3VjcHRuUVBNNkZPamFa?=
 =?utf-8?B?cEFreFk5cEVmUitmZnU4UE0wTzkxL3ZtaEFVczBxNmZUV3puSmNOMEM0ZGZT?=
 =?utf-8?B?cmFwTHowVW0zVHdUa3NYRVpnYW05aFNUdHEraVJZckNnV2xteS9BMld2emh1?=
 =?utf-8?B?VWRJMjZRWE9wNlZ2ckRwSmxFZ0J2dWt5dDNtbjl6OXhReVdqd2Nja2E3dGhW?=
 =?utf-8?B?cFJzUHNTcHY4MG0zNTgvV0xQNlViS081QlhJUG9McVdweCs2WVFuOGR1dXF2?=
 =?utf-8?B?a2JUTDh1Y3BSWTBPbzFVaUYzNHRTQy8vYitxeTl4U0hUZDRqeExQQVl0WnRx?=
 =?utf-8?B?dUc0aDFhRmRCelI4NmtKR2huWlNjay94RTlubTdka3JKMUE4OGlyODhpR09C?=
 =?utf-8?B?Z0x3Q2t4TW9TT3NZU3JoQnZOeDdOS2hDN1RoeDM5eThiT0Z0d0J3RlNyUVpU?=
 =?utf-8?B?Ky9pK2ZlRDdobHJoYkVYUEo3Vzg4ckoydnlBUVZHNURoUWs2TkZoaFRDV05V?=
 =?utf-8?B?N0FlaDU3UHJ0RmVMN1FSa3ZsbjBlYTczSERSY3NMeDFNK3hXRzh4TDZJWmls?=
 =?utf-8?B?blpVMGVCRWxYcmdWRzdjUzZyaEIya2dyMTI1ZFZ1OHBqSG9KK0k3WTNkMmp2?=
 =?utf-8?B?a01VS1BiWmRBcy9WVm9LQTNZbER5cTJ5OTlCVUpScFNxK1JDTzNIQzVDSG5z?=
 =?utf-8?B?Z1JPQ2NMdTBIV0k4cTQvTkY2N04vT3g0VThsaGtONHdLMzhYQWFCZ284Sno3?=
 =?utf-8?B?UU5tTTFvVlkxSkI3ZnBvWXY0dmtIeXBXbkJES3R2WnJRVDVKVk5RNVFLQWJZ?=
 =?utf-8?B?dlRnejFTZzhqZFBBMUlvTzhhVFlJbTZ4aXA0SU56L0hML21IVlduWkxJTTBK?=
 =?utf-8?B?eDhsdlArNmFHRnF0Q2txNGQzc05NTFVYWDdoNWxDSVVGVHdrTDdEVzJSdGVo?=
 =?utf-8?B?TXJQUzJJSU5XQXpDbml5Q21qZzg4WWFDT0F2a05XUHZ6ekZ6MnRKZ25QTkhO?=
 =?utf-8?B?M0sreWkyQVhwR2N3N1JPT3NkMFZwNmJQZmpmNUxnQWgxeEIxU0lYY2NhRTF6?=
 =?utf-8?B?cStvRGxuYkdYWlducTdLMThUR3BZRC9KNi8rREV2Kzh1cDdYVEpVTGdyQUww?=
 =?utf-8?B?cFgyZzgzSW94R1BRM2crOVRQM051K29SM1h6OWRGT1pKUVpnUTNaNXJhUzVq?=
 =?utf-8?B?MkNxVkVUNWVUMEU5Ym9TbXVrM3lXMlBaaUtKMFhHaWpaVHU3MGlna1gxVkVa?=
 =?utf-8?B?VUpVOGxpOWMvYkU3ODlVWUNaSUZvMVVaeGdyaXc5L0FBZk9ySTBuVDNuZzhU?=
 =?utf-8?B?NXdhd2tLcTBsRElTUGNZMjZZMllNaTVFQ1RQZEJlY0xCVDJyS011L2dGVUhT?=
 =?utf-8?B?cVFNQ082TFNQZTlYcTNUQUJuU3h5eTh6aE45R093V0lSVENIaWwzZVdwUkVz?=
 =?utf-8?B?T3ZSRTBtVy8xcU1PeUZKK0N5bSs2cEFCNmppNkJsTkNxRTdXWHAzU1VSSDRk?=
 =?utf-8?B?MmNGTG5GblJQbmpNY2dRbis5RDZ6MC82NHdaZnRwSDNObWNaeHZ3Q1pCZUpX?=
 =?utf-8?B?RmExR29sVG5iR0Z5Y3B4bXIxQzRsV05MWTNvbVlBQjNKQ2E4SUdqVTJlQk9I?=
 =?utf-8?B?L3hSM2xCYndWRHpzZmVFQUgxZ2pVWE9pRmYrN0xxQk03VjBkMXYwM0JJMXdn?=
 =?utf-8?B?ZDVySlJDUm9DY0M4d09WaWtXbEIvN3NOR3RSVHJEV245aGpqZnJYQ0hBTmZ3?=
 =?utf-8?B?NGJYa0lsUVJuZ096UmVQWUJLcUVlN25xTGJibnlscHdRMTBoOVVrN2tZZ2cz?=
 =?utf-8?B?VEduWkZ0dFlrU0lzQ2diNUkvZDdJeXNES3J3QmRGbVR4Zmlqb2VvOXJQMU1N?=
 =?utf-8?B?WFBrWG9ObXYxYzhhNkF5MWtQL3hsczFIR2o3NGxzWjZZZ3B0QTNWNjN0RjdB?=
 =?utf-8?Q?8B2KW/wHGRw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnYxSE9MWWRJa1hrazhGR01MQ3oyeTFpNlNOc1pJOGxBTjlhZmNTQ1dDa2tR?=
 =?utf-8?B?bytHelZwaG0ybXg2RFdtdURWUnpFWEVxY09BVFdFZUV0L0R6aVIxdlB4akF1?=
 =?utf-8?B?RlhVYnFlSms2OTNXN2RlemM3QUxQOEc2TWVac2VQcUl2RXpkUzg5S281UlRW?=
 =?utf-8?B?V1hvS2RsTUZ2eVZJenBUN1NPZy9JUTJ3eEtZYjl2NXJwUjMwU2lRUXBhb3pD?=
 =?utf-8?B?amNCVWdtdDNjNkJya3JCRFZ3SzdpOWw2QWd0TW1ucUwvQ3h5WHZtdWp4cEVx?=
 =?utf-8?B?QnhJWGNNaXlrOW9ZcFFrS3VDNGJVY1BGL0xGWFdOakFXTkRPZ0tCMENpSjBC?=
 =?utf-8?B?SGI0R1l5QVZFNVR1MktNdFRzWlhsNk9rVXdYMDBwU2l6VGxRWkVMN1E5T1Rs?=
 =?utf-8?B?bk1vdVdqWTVLa2dCeEROczdrU2NrZDc0U28rVmVocVlLb1RhR0d6SStlT1Nw?=
 =?utf-8?B?NlJaSW9HeVJ5YjJuUlhwZ3lNaHpaRkV5cit1NE12NWFPdnltcG10Um9nUE9O?=
 =?utf-8?B?cnVwMVlqcDM4MGk1TTVqeU1tQWUwZk9RbmoxeVRndkE1SElxN1VLbVY4UXdO?=
 =?utf-8?B?UlZBRUtBMVhTTU8zak1rRjJOOEcwMjR6UGJFTHppU1hiSVFBUS9GdTR5K0ps?=
 =?utf-8?B?NkRoNVZnWkRDNGpYKzBKbUhjcHdadnFWUHg3N2NuQU4rOGtmWUVoWTlJRVhE?=
 =?utf-8?B?OGthTVJSZmRFVVdNdWR2aVh5MXB2RStSL0ljWXVGK0VLYlZPc2xLR0JHNHh1?=
 =?utf-8?B?Y2NoZWt1UDdCcVFkby8vbGREYktuNURHQTdRUGkvY2tYdGN5OEZaeTNQdWVk?=
 =?utf-8?B?QTFBa0MxYWJFdVRzWTBmb2h6cWUzVHJpSGhHaHczam5NSGFCTHVoVW8zK3pV?=
 =?utf-8?B?MjIycVhWNHJWVWR6bWZkUUw4Nmxsdmh6SkJGVnprdURkNEZYOWNaTnVpVmlS?=
 =?utf-8?B?WVllNHhTN0VoVGhQTE9NV1BBVG5BMFBqZ242S0N2MDY5d1d0dW9BNnJkM0ps?=
 =?utf-8?B?WExTNTljOEl1QURSdU1aL1hXV3N4Rjh5cDF3eXhsVWY3bUZKQTluNDg3Qkhq?=
 =?utf-8?B?WlFGVmF1dy9nSkk0enQ5VnhxaFBwSy9Bc3kwOEJLWFZZVEgxVlBOL2tWdy9Y?=
 =?utf-8?B?U29Udk5nU2FsZGFoMTFwdkIrL2I2Q1Nwc2JtT01mSmdTTnZwV2hRR2ZCOGow?=
 =?utf-8?B?azhGMGtrRmtSakViWjV1MDFhc1ptc2Y2L2xUUHV5SjFQRWREeitSSUkxM1Fz?=
 =?utf-8?B?L0p0clF2U2ZncGwrSlVtTVVvTnQvMnJhL2k3SDVnTW5HV3FiazZGYWxUK0xz?=
 =?utf-8?B?bENmVytHdVc5RjdXRThNa05yb2phRklVU2ZPc2Yydk0rM1ZlLzNESEJDbHVX?=
 =?utf-8?B?cDFOSm5iUG5hQU91MEoydlRvdkFIalFXdXV6YmVWZ0YzUGQvNkdZeUdSWmda?=
 =?utf-8?B?RlVRVUNXcjI0Ym9JWmgxQlFqdnlTME14U2RmR1ZrNXhCd2hsVzRSdGMxcWg2?=
 =?utf-8?B?VTZVNHdaU3dTbDE0ckZiazZidU8reEtzMmUxNmxpeEo3Q1FMUXNVNkdKdjRH?=
 =?utf-8?B?T213ZWxqKzd2Z0RXNFk5WXZrNUdMdnk0U2krdXhTa1d4QjlNSmZjVXVWU2ds?=
 =?utf-8?B?bUFNa1hwR0lCWnJ1MDBLOUZQclJLVE1MbGVDV1Faek1DMmdZQ09qS0dFM3g0?=
 =?utf-8?B?a1ZSMHV0Q3c0c1JCRkxHem5EV1JGV21nb01SbTBkSnFjVGhZYnduekFlQXhn?=
 =?utf-8?B?Vmx5d1RoZGVSUk10eHJWanVmSFFQVFI2TnF2NUw1NWgzaHBoVHdYVitlajVz?=
 =?utf-8?B?bUd6bXJJU3FDWUhxenVNWVJLUWMraXFncTBQd1NvUGR6Uk5ZT0JrSFNWWng3?=
 =?utf-8?B?OU11M0cvcVRvNzUvbmRhN3I5ZmM4QThUTVZKbnRPMGplUDg0b0FBNjFib2pp?=
 =?utf-8?B?SkxzUVpNU0pZbSs3UXorZW1vblN5NmxEcm91bC9wUjVWVjJjZEk4UFRsMldG?=
 =?utf-8?B?ZUpRWHd5RWx5NjlYNEJ2eVB3MzdXR20wREEyWjdxMlF2ZzFjbElVZ3VHS2ZR?=
 =?utf-8?B?eEt1Rk1CZElwS1JqWTZTem5VbjNJa3JDNDgwNExqaDBZL3VzaXp4MGkvdGQz?=
 =?utf-8?B?YTRVMU9BYzdhWkVCNFNITU1ubGhTRFZ3ZVFhS0s2WWlEaFJRc2YzSEdIU3VG?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a0ceca-597b-421d-fb6d-08ddea97cd98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 03:13:06.8070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyW/GNiXr6UuvrmN6HbY/rKYB/xMD5/+6bvEb5Xppc7O0fCBx/xR8dDTBTIFEsCVuz9UYpzmbmmukkPiHGYVAej3oLHW/6X2OtouEKyqREQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9131
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> Configure mbm_event mode on AMD platforms. On AMD platforms, it is
> recommended to use the mbm_event mode, if supported, to prevent the
> hardware from resetting counters between reads. This can result in
> misleading values or display "Unavailable" if no counter is assigned
> to the event.
> 
> Enable mbm_event mode, known as ABMC (Assignable Bandwidth Monitoring
> Counters) on AMD, by default if the system supports it.
> 
> Update ABMC across all logical processors within the resctrl domain to
> ensure proper functionality.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

