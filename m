Return-Path: <linux-kernel+bounces-883582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC91AC2DCC1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E65004EBED8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461601FDE31;
	Mon,  3 Nov 2025 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDEHZ9Ri"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7C347DD;
	Mon,  3 Nov 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196770; cv=fail; b=pRicBduDEAM3NeOQKuYZvIURig9dZRm3ZhYsoeubyCGmEFl6gs4pTXd6PXDy5Gz1QP4IYmu3tO6gu3Wr1iqHYiO8UUPgt/0pPjJj131XGJ6Vb/lglYr17eQi6c2HCnsyZQkexpaj+DZ+5kRmNdwHoZl21/8Hai5n5sY7NWPaFxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196770; c=relaxed/simple;
	bh=G6tYPOeaXncrOTvVSjYPKtjdXNzOLMGzIGLCwHfD964=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jqsGynOCBEEskqPOOfJS+CFe+ho6prGuhBUwUsmPN5K+fnEXPNh9p7CAr6Z2F4JJx6r+xh+4BY71t5VjWeVMrJno9JIMd/U6TsonJxBbyugoUyPQQl1Zf0m9Vp4tFa/WqvmoSKhbovKKPA4JpUvYibpfJUHF7fOOh0oyyZ9USfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDEHZ9Ri; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762196769; x=1793732769;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G6tYPOeaXncrOTvVSjYPKtjdXNzOLMGzIGLCwHfD964=;
  b=hDEHZ9RiHFm/5r54oY4O7O8/uMBXQKyrf4BzJ0v3GTx8GS7nIZc9lCs+
   llQEw44aKFq8QpU8yOcgvo29ELp0WWpPkCWj0aAEiPNYzlsgocyHZ0z3I
   k3Z25XDYFOsqIjqW28tesmqfQsMkB+Ryiw07Gv/b2i6O9Drt1ZHwNSir6
   SGV9Dd+DQu3Q3OYns2Afiv0AcWYHxNIrF4HPw4lcBaKZYFNytB2ORHJMs
   ukAAzxBnLGNG6xSv9w7puy5R7UdNtX+aPL+jP3+vVQvQCNeYtyseLKGYC
   bWItfXnaqB2nCtmZgRmfpe72QTlMYkVBJTy5GIQZVYFfTIKJTwa2oT4fW
   w==;
X-CSE-ConnectionGUID: Gkd9oK50ThiK/8gwzS0nSw==
X-CSE-MsgGUID: T2AkB+0LRTSqvhVG9DZ63g==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="67936697"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="67936697"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 11:06:09 -0800
X-CSE-ConnectionGUID: mjdktDlEQoiizAh1AroFOg==
X-CSE-MsgGUID: iLUgdilMTGGQHEFc4D3CdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="191293701"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 11:06:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 11:06:07 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 11:06:07 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 11:06:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHkYFmXoBS4Fib913eh+gLXHDv+IUVOE2TINxFQrftyrxiN/c34jG5SIr8t9+JIfymyEPDPQiJPjYRJIjhabpmGfWRgJIdvIYo5yCz6FJZOrnjp62TruLvNzokZvYAtBOpjxobO9JKfMduuU5eptawr4L/zv5Tgd4M4f9I0fO6chKttohxPdq1nGLPzYPmR8ogin0e3mNiw8UfQUYSdPz7x5S+XvKkl36GvHqM0sNV1M2rkKdNDIS1RNekT7ScjfEqQFJx1IzKfJzyRBt5QrmuszM4a7gaHtqkPov1hIySSjP9y37PFWDSK5TCHG0uQMM7cB2prDEJDpJNPQASX/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oF9aAf6RQFHPRqVGennLbMuSgeXsR/BgWFhiOroRaUg=;
 b=fqLS2YFV8jPq1umMvymC7hcrgqpNKHt7oi8Lg2jlYW0a5YtXodn6asmnAQZhKpiOtWI2hycSsG9xam53ggw+1OgPaO3tnSCl7EhNpI/UVw5CeLwQZ9yMUUtAIoqAQXeFEpuMXUHpZ7A0bGgriZaXKS4K3kzfRhpjGImpe2qLDbBbmy5/E1/awEVjE0skXcZ6F7hcelTx3+uGvlQ6Pma8xlhhUittYrIYxJoa0HCyQ9fAI7yE/K8/NigL4eEW7L2d07rRq6cSuJMqmTSQ063LMDDNWksK+bCIbhuebyUpgdFcYkXxxQLTFZJtswv1OliCuYjR0X8whLQPPE5HoxBV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7626.namprd11.prod.outlook.com (2603:10b6:806:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 19:05:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:05:59 +0000
Message-ID: <43506b9c-5ad7-4871-8a24-11e71380321d@intel.com>
Date: Mon, 3 Nov 2025 11:05:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/10] fs/resctrl: Add user interface to
 enable/disable io_alloc feature
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <feng.tang@linux.alibaba.com>
References: <cover.1761844489.git.babu.moger@amd.com>
 <deb3a4f19d6e138a502b136034fb88ad8b8c9c75.1761844489.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <deb3a4f19d6e138a502b136034fb88ad8b8c9c75.1761844489.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: ed269274-b1ba-4e07-b306-08de1b0c066d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHFpZ3c3c0hlVzgzNW9UQ2tmeGJxRHZBajROajhmK1VPVitJZi9KRkduTkM1?=
 =?utf-8?B?Q2FpUWFxZUozeE0xcDVYbm9BcUhBR0dJK1QvdmYzYk5iUExpeW1ieWRML0g2?=
 =?utf-8?B?aEJBWk9wMDBrTVlWa0s2bUpxZ2hoNW1FZ1NJVkhZYUFxbGFpN1ByOTNKOFZz?=
 =?utf-8?B?Z1VaQWxaMm5hZGNyL09KbXg2T1RNZXRuYWxNeWpWS3VHajNzZ09UaDhtWGpW?=
 =?utf-8?B?WlliWXBLckRFNzZpV3p3Y2kvZUYzVVFSSkZCankxenY5cThuc3lobDhkUjdK?=
 =?utf-8?B?d2JFTUI5K0lYWm9uU1lPNFN6c1hpMHIzTGdybUQ0eHIrTERmdDBOWEpOZ1ly?=
 =?utf-8?B?UGM4QklQb1M5R01ESlhFN3FFTTRsOFQzdENXQWlVR2NsRGV5T2JOc3Qyb0VH?=
 =?utf-8?B?SitVYjVmZkRMOFlqZ1FmK1Y1RG1WU1E3clloNEhkUzFSZENNQjlXVVY1QWZm?=
 =?utf-8?B?MUhvL293bEJpU0FwcFlFMTZwbUFVYjFnNEozKytMN3UxWFRyN1BBbzE3U3JJ?=
 =?utf-8?B?UW5CTDRtWEh4aDRlcVRNL0RDaitqeGE0QWZXeW41TTVoUC9lV3JYZHF0T3FI?=
 =?utf-8?B?bW5md2xKdmJaL3RPMERrbTN1OEc0TWE1Z2FtNE40cmVodnBNYmg1cG5tck5p?=
 =?utf-8?B?STh0VHp5aWpuK2Zrbjg3dW5wckpadGdsLzIwUk5IZ0o2VGl4Sjl5WWY2M3JR?=
 =?utf-8?B?RXY3Sm03aVhIMVhjb0RoYVZJaXdyUkVDRzJ5VWFMQVREVGdyeDdKNzF5ekda?=
 =?utf-8?B?Qi9rUFk2dm56Z1B3MnVMWDI3UjBrK3ZGNVVYMlpFaHVUQTlBclZVdis5WVY1?=
 =?utf-8?B?NStPb2xzSUVrc1N5dzU2RFdRTkJvdUpIS1c4VnRleWd0QTd2UHFCQ3R5L2ZQ?=
 =?utf-8?B?RUd6TzA4enFNTzR5ZGVEUHZ5U0NkRDJDTVB0dDdlRGhEMHJZTFNtTFFLWDZH?=
 =?utf-8?B?TFJ1SXptUmxoVXdIczdDaWJqSUxqSzM2aVR2REtMUGFQWGdhZ25zSVpoVWpr?=
 =?utf-8?B?SmRyRlRnWDVHTlRmd25Pa1lKcy83clFMUmtvSHRSWjQ5bTlzZyswdjZWYmZ3?=
 =?utf-8?B?Zy9hMjlFUGtxbFovM2xtdzBDa1JzN0tBR0xSWWl4R3MyQzZUSjhxRWpvSmdZ?=
 =?utf-8?B?WlN5eFhaaWRXL2J6c25QTHpKejZvaVN3Sktqd09SNGpXTU9ES1Zib2swUjZl?=
 =?utf-8?B?QWZtSGwrWVAwSGxJaWtlZFkzRUxpaS9jblBxQ1FVb0FTZ0dRcXE5YlpNMWo0?=
 =?utf-8?B?SjNuMis2VmNpbUEzUHZZbngveDU4RkJpazRtaXlLZUlkbG8zRnZKRDhobFZ3?=
 =?utf-8?B?TzdxcTJTRUFQS1lueGRIRENIM1dJek5LNlZlYmpUYzBpNjNEL1FOREJzMXZ3?=
 =?utf-8?B?WVNjZ1hTa1JsR2U2NFAyaFIxajVOM0FsWUFCMlFZSno1citRTE9PYUN2OWpq?=
 =?utf-8?B?d1QvclRYZTkrTDZSTTRDM0crUk4zL0hMNCtIR2RGd3Zva1M3cENGMm5zMndQ?=
 =?utf-8?B?ZXpOMnlOY1g5Q1hiQTdLSmpNK2xPQkwxUlQ0aVJtc0pTWmgzaG85YTFMQlJY?=
 =?utf-8?B?U2lTOWhoMHdwV0cwYjRGd0pUWi9WUHRZcEhBRzBacmhvWWtMRHIzVXF1QzJw?=
 =?utf-8?B?b25EUWVXZDBXY2JRNFlVVjNWOXZFNjRuNk9MdlJNU3dyRzZGRVpwckYyVkZM?=
 =?utf-8?B?RkVmNnN2K2h1QXFWc2NBbEVZR2pnZkwzL0luQzhwTnkyZnBiZ0JWOGtFUG8y?=
 =?utf-8?B?UiswdlVDU3A0czZMbjZNZlAycURsRkErblJlL3BHK3QvMzNpbWErOUFBMWZS?=
 =?utf-8?B?Q1Z5UENxR3cxaWV1bkZIU2pTU0R3UEJMYktkb0lPN1NpZUV5ZXVoTzRabVQ0?=
 =?utf-8?B?ampDeEFXanJoRys3ZWVvcGhqZW85c2dRcURCRkJ3dzJmMWNLVlA1MVArQjA4?=
 =?utf-8?Q?eLO+whsRTz20l84VVNQmJHeAoJJWe578?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cllrUlEvV2RXYkJqSmxGOG9BLy8yMUw2Q2d0RmlPQmNMaDhqL2RZdDdENHRM?=
 =?utf-8?B?TDlTQ3NOL21GNnZaVTRJdVhCaEJOUDBiYmhsLytPdVRQQVNSVlNQR0IxWGpK?=
 =?utf-8?B?YlV2azh4VWtpcmJ0emFQWVlBUnR5SUw5NVI5RFVYMTNsRGpqNmNGSTRoVGdV?=
 =?utf-8?B?bUFEOVQ4VE5NQzQrNE02b1NFTUdZQTBOYzBtdElVRnRWN0NRUmdPV29HbEFP?=
 =?utf-8?B?UTgwcUVmL0lTRmxZYVRsS1p1U2lBQ0UrTHZRNGJQWHltLzBuR1kxb0crQjgx?=
 =?utf-8?B?cUpicldXb0VHdUhzYlpjelNxMGpGK3BGb1A3RWlCUG1BeWQvajJHTDZqK2J2?=
 =?utf-8?B?WHoyT0EvcmJ3UnFJUGVvT0dJeUY4bHhyVkxmYU9qMDZLSTBwQndqcnVIM1VJ?=
 =?utf-8?B?OUNkU3l1SmpPV3pYNkZrbzBHOHZFd1V4NjREelBoT1BURUlna0t3RFMrbGc5?=
 =?utf-8?B?anlyem5DWnFsN2NhTFFRd05mL05oN0dvV1VRUUl2T2FBSDVNbmpqKzUwVUNK?=
 =?utf-8?B?ZjVXd2ZaS2hWUWl6YmdiTjFaYUVYcG84L2xRTkpFVVV6N2UxRCtRQk9adENZ?=
 =?utf-8?B?TGpycmdkajV6WDk1T0hkR3k1cFBQOElUL2xwWWdjZklzZ0lsZ3AvSmNaL1Uy?=
 =?utf-8?B?TVNGcWJjYitQOUJ3WEFTOVkyc1RQblhDVml3QlZRK2NiWlFMeXBibjluSUhK?=
 =?utf-8?B?RnJ2aUNCdytWNkl3S1pxUjh5RVd2dHRCYXNSWHRtbHh6RU9iNTg2YjVaNUFa?=
 =?utf-8?B?c0prVXUvakx5VkNYWUtCbzBpNnUvdDF5ajBiWE93RjVSUitnU0ttUW9vTGU4?=
 =?utf-8?B?bFNwVWFnUFI5UzhFR3p4bytsYVFEZjRoZnQ0ejd0Yk85aVBnaGtFUXhnQnNB?=
 =?utf-8?B?Z1hYWGF6U2V4aWFncW8yUS9ma2pCendIcHNxOEFPZjczZDV4amhDVzNpektG?=
 =?utf-8?B?Q3laSE8vMnhFQnlFZWdOQzN0RlB0ampoSmJwbEYvT293aTBJSG5pTUpjdW1G?=
 =?utf-8?B?YTlHN1UrTmowVFhLVFlPQUkrZWh2OFJGV0o5cnVoYXhraHJEMXlHbnlEb3VJ?=
 =?utf-8?B?c1RDZ0xBSDhqK1JwbEc3bXFCUlg2OGh5ZlZPeXkyL05acndpRUpjSkQ4U293?=
 =?utf-8?B?RW4vZkhULzZPbXY1dG9iV1RCY2thanJpTUg1NDBLM21ibXJhWTRWWEdQYnRo?=
 =?utf-8?B?bkVEMTIwbUlkWWVFeUxyZ09OZ2hsV2c3WHRVdTJqT0w5TWtMSWlVZ3d1ZTRj?=
 =?utf-8?B?R0lhN043bmpLdzcrNWxoNzUyaFdRVC9SNjN6RVBPVHB4am9pc1RRcE41QmYx?=
 =?utf-8?B?ZW9nM2o2NVAxSHJoYmFKYkxZdUordHloRWc2c21MK0oxbEpibysvZmhWR0ZW?=
 =?utf-8?B?VzNJbzJIcTEzaittODJPdi91Z2RvQlQrSks2aTBrL201UHlrcUVES2NCVjdk?=
 =?utf-8?B?TEROZm9IcVo5eHV3dHIxN2RqeS9rVDR1M3dWeitmaXN5TEpud1FibmJVckRr?=
 =?utf-8?B?RXdWSlM4T0l5cnRzcXRBMUZUZEYwY2VDWTRwend4Z2tjTXJYcUkvU0Yya21L?=
 =?utf-8?B?aFZ4VnMwN3VQcHo5VGE5cHNqUEs1NGp3bnJVUlBjVUM4bjhCU3ZOdjJNRWVZ?=
 =?utf-8?B?LzNNVWNmZ05sOUZ5VVRqVFpxZ2ZMVnE4UDdSalZxOHZrL25uSlJjSDdTR3Bz?=
 =?utf-8?B?YlByUGhSUEpnSEV2YUNqMU0rTXlYVWpjYmJuT2xQUUszVGhPYVpZaHd6RXR5?=
 =?utf-8?B?UE1SNStVZmViQjF0YllKd2pVRzhDUk9TOVV1WjhOMzJhaDBZTnhzK3ZxSVoy?=
 =?utf-8?B?b2NDSTRsTmR4ZUo4ekxSNGpkYWFjNXk0dnA4NWFKUCtRL21QRDRsR2pOWEVT?=
 =?utf-8?B?dytNRmRNL0R6Y3Jsd0g5UUYvVXVPc0paT3pYbmN4cE1PaU45Um9sOTBqOUlh?=
 =?utf-8?B?SFF3SG5Ma25vMmhTZzJQRWh2RjV3N0w1dDZ6RkhpK1d2bXJuRUxVbTNwbXVo?=
 =?utf-8?B?L1c4VUpkdnE1RUlQTEdmK0Z6enIvRWRkbW9mSks5ZmwyOTEvemx0NnBiU1VI?=
 =?utf-8?B?MzJBY0FrWmZRRTJ1ckFQcTlCYTU3cmZlN0IwVHJERlhqa3ZZYTZZZyszYnV2?=
 =?utf-8?B?a3J2dUZjc1BOazV0VEhCRGZyRGYwODM2V3lxa3NBRGRVZTBia0tHQjJwdFMx?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed269274-b1ba-4e07-b306-08de1b0c066d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 19:05:59.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QBDKWGQyIIoW6kCTabR+KQUWfhKVtjkUXT48tFyycke/8NWwXxz9BBC0WxwmAcPpg5nAA/t8oBd2wrVsGhov6Rig4GnR5AOg9sicYmeC+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7626
X-OriginatorOrg: intel.com

Hi Babu,

On 10/30/25 10:15 AM, Babu Moger wrote:

...

> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 108995640ca5..89e856e6892c 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -152,6 +152,29 @@ related to allocation:
>  			"not supported":
>  			      Support not available for this resource.
>  
> +		The feature can be modified by writing to the interface, for example:
> +
> +		To enable:
> +			# echo 1 > /sys/fs/resctrl/info/L3/io_alloc
> +
> +		To disable:
> +			# echo 0 > /sys/fs/resctrl/info/L3/io_alloc
> +

Above examples are missing the '::' that will format them as fixed width text blocks
used for these shell examples.

> +		The underlying implementation may reduce resources available to
> +		general (CPU) cache allocation. See architecture specific notes
> +		below. Depending on usage requirements the feature can be enabled
> +		or disabled.
> +
> +		On AMD systems, io_alloc feature is supported by the L3 Smart
> +		Data Cache Injection Allocation Enforcement (SDCIAE). The CLOSID for
> +		io_alloc is the highest CLOSID supported by the resource. When
> +		io_alloc is enabled, the highest CLOSID is dedicated to io_alloc and
> +		no longer available for general (CPU) cache allocation. When CDP is
> +		enabled, io_alloc routes I/O traffic using the highest CLOSID allocated
> +		for the instruction cache (CDP_CODE), making this CLOSID no longer
> +		available for general (CPU) cache allocation for both the CDP_CODE
> +		and CDP_DATA resources.
> +
>  Memory bandwidth(MB) subdirectory contains the following files
>  with respect to allocation:
>  

With the doc formatting fixed:
| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


