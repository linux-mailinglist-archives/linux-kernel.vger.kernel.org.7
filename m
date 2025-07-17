Return-Path: <linux-kernel+bounces-735852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0BAB09470
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66DBA635F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A009213E6A;
	Thu, 17 Jul 2025 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2/y0EZX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA420A5EA;
	Thu, 17 Jul 2025 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778215; cv=fail; b=aIexJez02vntxN3Aa9RsEd91nI/DkOQLx9JbwY8g83xzYJjE7+J+jhDIBEB99UGT67An9ygw0UusAhJxwpGpbLbN3xFivvPqhj8R2J8tB2ZKkzkuBrMKHEKPbHDuAp+XqHlpQW5SEyneeIu9Z3Y2hliXimD/awirEyjBnQZL29s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778215; c=relaxed/simple;
	bh=6UNRIGDkDDR2eWEWieSKevjWFeChAgYUmpkvgSTRtq8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FfTLFuvhdiddEybmTevMEDC7YF6hYHdFrc0U3fTKrPRUi0vD7W4TfYj0/VYQ4cF8FPMKoSvMsFosB1zj3SxZPseklilx3tmbivbKjdSEo9RIKNopevp1/YT3YdKYbE20XJpLitd+dJOLdnYx1UxRF+hXsQUhwgh4fQmr4kuAlmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2/y0EZX; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752778214; x=1784314214;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6UNRIGDkDDR2eWEWieSKevjWFeChAgYUmpkvgSTRtq8=;
  b=N2/y0EZXz74uOPKwVOjfrmNtCxm4JTtZZkZGm2h2A8BKWq2XJl+uRhOw
   ypmnDsxvamho6YTFShgNbf2kFDFmmyP1cXn39lSnMiuCnf57SFyPAiEfx
   1NmfvbBFKPjp5IzAgikz1MXqHZo9oBgZtV4T/cXNIeoa/C6O+mo6Lq8yA
   Ndid8izSC60tigSlwIu6dkYIiUdcjIJ9Nz+oH5jhQF7XxW4kpL5rsXNle
   bZgBjmkNRFtr7gSB9G/sl85IY7ZwJQmGGrTcqJN3PAU1T64TcdxF81Kns
   46e5QitMi75gydbsL3B5bSNxriLxLSYdyIIPeIkC0KGFVcDL2RCPIyk6W
   Q==;
X-CSE-ConnectionGUID: 9m6y4ffRTzOC/rZpFUb9ZQ==
X-CSE-MsgGUID: u01IJlucQDmHyJ6ZdpDJ2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54926349"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54926349"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:50:13 -0700
X-CSE-ConnectionGUID: aUcHrnHNSAWH3P/6B6KLZw==
X-CSE-MsgGUID: MCj2S7ofRZWQfpwuZWTAVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157258343"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:50:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:50:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:50:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:50:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRJVckSe+60jVs87fIs/YIiGt30igueCKYMbD703H1SaDw69cor+YhCLLqfVFvnqRdwk6exstyjJ8dWJ8WTPMjaBFLzB2xC4jJaSvwHa/JqwuO4G6xpP9XpC1psjgPOg/pQwp0hS8ko8DgviCMJL7AStOgBk6gi1D6mobcczQWYcVX+jG3cg61okn8EihoKm++4Vscg4kNTHITzXON1FZbS/RZVWMd8MNywX+7Gty/4RFCdpy4n1u19LXWDAeKPK9Xh2Gpp2U8u4itnbWryUGMUdFaaAN0mCfr6XyQpIeZvCrJy7tbS0ePAsFOU8JRoiPnEra+soHWTTPjrIkwylrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=294X0diZcyLKwVp4BurN3J5gQoMUkXJpVzpqqn/7BJ4=;
 b=w1MjkyAXMXeva8cIrx5dDnoar4ZMFwYyHwuhuxISug21DPdgRjYxVP0CV0DBeI8O2nfeFou5171DvXcwyUIY+lMr6lOgZQbeK4NxyiVLZSt+4DosBCXURuTBcRKMb/9hXplymizDJFa+BsHSHxAO7FjCULKkRc76b4Bs/rdNBqhe1X0QTzigTKREqVV9M7V7w6B6fAELYqLfAt+ryzcRXALguR2SMwD9sX39iCo0IKfqLRzZgbWRRI/UC2EOzQ7On7v35dhXMBFIKPEanUs6g+u0952ZLDAjQmrQQUCarpNVkkquBbSsBsVQ+XOJkNqZ15gCmVJ93gMiNJOm6hDKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:49:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:49:41 +0000
Message-ID: <e525707b-9d62-49d0-9258-19ea936f6d52@intel.com>
Date: Thu, 17 Jul 2025 11:49:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 16/34] x86,fs/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1752013061.git.babu.moger@amd.com>
 <f68d591f2471953e082ce03fef18c309a002bfb4.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f68d591f2471953e082ce03fef18c309a002bfb4.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:303:87::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 544f8aa3-1c1f-4c7f-ba16-08ddc562b01e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzFnTnpoTDZJYXdsVVp6TEp5RUtXOWhNMVZCeUFkR0RYRnhXR3V0d3l4V2l2?=
 =?utf-8?B?dXpQZjZoc3VOMk5IU3JsQW5nZlJaMTBQemdpSU1EZmpHUGxqcnBsVVZSR3VE?=
 =?utf-8?B?UlcwaUdjU3A1Z2pVODU4Wi9ldndtZCtQaTdvdW5tUlpQZXl3MWdMYU5QNS9N?=
 =?utf-8?B?aVUrdmprUlAvVzl4L0N2QUF6Sk5RR0ZDQklnbCtSN1NLMUs1eEUwTzBNNFZM?=
 =?utf-8?B?czNqZCtlZEVIZm15SXNjclZJbG5mbm1TK1pEeXowVUpSVVlId3BBRVY3VnBl?=
 =?utf-8?B?OVExWnQ2MDJGSUJIb3IveksxNWp3a1UwNjhBSGErTXBlRVJYc1g1MEJVVXox?=
 =?utf-8?B?aytyQUNtZ2dVckdpem43eTA4ZzBWR29xRi9CWjBNa3lBOTAvTCtob0RiOTRl?=
 =?utf-8?B?UktZOHJIajJuZmxOSWxlOXZ6UHZpWWswQkR0MC9YcXFobm1sYnFKYURiMGZR?=
 =?utf-8?B?clcxelRqaWMrUzdwZ0YzQXJaTG5acXNMbVFQRnh0L0VSblh6b1YwNHpOWHZK?=
 =?utf-8?B?ZE5DUlIzb3BOQjhMb2NFcGM2MW9sTzRIenRMWHJnUG4ycE1ENnVGOC8vY3Zz?=
 =?utf-8?B?U2tvemR4UEVEVWZ2NlJIcXM2d2J1dGpRdktQOWxkSFRYc1I1TDdSQ0h1NHp4?=
 =?utf-8?B?Z2FhdU4wUG5ldk1TSEdnc2xYNFJ2aldFekgyTTJKN2FmZ2JvdXhQSytrMUU0?=
 =?utf-8?B?YkJRaHFmVXlkeVR0elBIRVV0YjNCU2Fpam1RL2dJUTdFMVpVUnR5dDVVMHNx?=
 =?utf-8?B?Nm1YUEkvVGtQRVVoNWU4c242aVJNZTl3YWRQSloyTVUrR0k3aG02dUJpQmVx?=
 =?utf-8?B?OWtmY2Y4MVAyeHdIZjlyRTFFV1ZPMzgvSnNnVHJOcDJtSWcybU9qM2tybFF2?=
 =?utf-8?B?WGY2QVBQbFI1a1dWSTVzWDdzbjZvbmtWOEFLOURJbDVrdHNvSFIzNGgyVzVx?=
 =?utf-8?B?MlpQeUdGUkF5SWxZNmtqVm8zbHlzb2ZjSFVndW1QVU42VW93bVF5WFZrdTNy?=
 =?utf-8?B?SUVJT2RaOUZmeGwxQmNwVkxheWVmd1RkS2lPb29iaVp1UVZoeHR0ZDJ0cFpV?=
 =?utf-8?B?Z0pPNzN4RUZJRTVaNTc0eEIxUjY3YkNjUWI1VmdiZnJ1VUZObEszRjVPMmp5?=
 =?utf-8?B?dUpxNEVwZHUxMWZRbHNrVUVuUUE5RlVDTW92VjdrMFByQzh3RVFuMVptMFZF?=
 =?utf-8?B?TVJabUF4MVJNcjg4Z0U1cDRtYkw5NGUrQ1Bpc25kMHo0MmYwa3B6K1NsM0la?=
 =?utf-8?B?T1NzMUtiaHpEa3lwSmhMU0hlVjMvY3pLRGhtanYvb01wMXFLaERIWGQ4Yk9t?=
 =?utf-8?B?Nm95eWQ2VkZIcXV5SkJiSERvY01ab1BvTGd2YXVPeFpRNlBqYWVHMU1TQk5K?=
 =?utf-8?B?UG9nQlRJaWpFOVR2WXpqMmc2V2FRd1g5V3hNVHBGMnl4ZlF6MFBCT3VpclVS?=
 =?utf-8?B?blBXYjQ3UlQyWldFMHZ5YnkyNHVxZWNTMUJKaTA1Z3V5aXhKMXUzbGtad05q?=
 =?utf-8?B?Skpva2k3cm5KNHVEbDAvUWduc2gzVjJSc1BiRHpyZkcvQUdYK1I2RDhjSEpB?=
 =?utf-8?B?R1V6SytuNlBvSkF4MTAwNFZSZ01IN0ZRZzI4R1BWY0ZsSktrNnBSSzR4dWNy?=
 =?utf-8?B?NldDWWl3KytzY1psMXdGNEU4YjFCSEUvSnlIQlRMMXlkZ0FEZ2hFN0NYVEFq?=
 =?utf-8?B?d21LZjVGaSs5U0JHSlNIUVdVcVFmMHdJbTlRbktkNlpIQ3ZIWEdiK0k1a3hq?=
 =?utf-8?B?d2k5SlRBSHBWUExudkFIYXhMK2ViUTQzY2FQK2lXUDRERC9lcDNUWTJYSm8w?=
 =?utf-8?B?ZEI0TVRTRWF3NzBIWnRHUmwycU1PTHloM1N1ZTEwalBSNUtHLzlrRWJSMW9Z?=
 =?utf-8?B?R3Jnc1J6bXBVRDRVT1FhblZWVVp1dVMzUFJ6ODVvNFZjTkpzbE1FNDRFaWtH?=
 =?utf-8?Q?1DeoYk1ipfk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVNlTWJnbGFhemw0ZVlNbVVKTVBJU2Z0NmttQnU0RUN1TU9XM3pMR2tMM1RP?=
 =?utf-8?B?U1Rxb21xN09ZZDZZRUt4Ni90SkdoTmVDRUphbFhVNVVweFFURFlLdzFUS2xn?=
 =?utf-8?B?OWpZNUZLS2w1WWxpUHRiMmtaTU9KQnRTT2MwUUc4NTZtMWhVRGdNRVovbDFZ?=
 =?utf-8?B?L2I3Q0NlK0lIOU9vOUJ2a25LZFF1MHYrRGNhc1R1ODZBVG5KVmRQYU5QZytl?=
 =?utf-8?B?dS92d2NsS0dPZjZsaFNSRFhoT1MrYU53VkhMOHZwV3IxaVZ1U05jZC9rQnlx?=
 =?utf-8?B?UVdFN3YxWWJwQzJPeElaMlJOZ2FmN0lYbHJFNzZ4WjQrNVliRjNDNjZ0Vktu?=
 =?utf-8?B?Vk9OQzZBNXJIdUhjU3BaTWNBZ2dQWFVNQTRrZ2N3UUY1SVJJSTF4NTdRenFk?=
 =?utf-8?B?cW5MY0tTdTV2THNDdml6VzBWZDNkaldTTmFaWTJ5cDNSMFdKTWR5MktLUU9D?=
 =?utf-8?B?eGkxY0ZvaVp3Ry95ZDdBTDJBVkxHMTF5cU94Tlp6MmU1aEVIWlNyb0tYNG5F?=
 =?utf-8?B?bzZHNisxZlByemUyZDNCOXlhMHBlYzFyS0tFMGk2Umw1K3ZmQ2h5WVRnZHNz?=
 =?utf-8?B?SEdrQVNORVFhdWNUMnRxbjBoQmN5bDJiNDg5M1c4eU9nempudGJEbU85di91?=
 =?utf-8?B?Q3p6QWIyL1JROS9SZGRiUHhORnZOaDAvK3kxQVdKZURZWG50TUlwdS9ZQmFX?=
 =?utf-8?B?U3JUZ1Q1bTArNWR4Y2dmVzB3WTlpYlphTENtOWFEUk02YTBKZjgwaCtOL1hF?=
 =?utf-8?B?Qms4TUxUQlMycUtiNHI3blAyS1cyYkRZdjRYOFNFN3l6b3dHN2FUKzI2aVJQ?=
 =?utf-8?B?QWk1SHlid3IyVmk1QmxZTkJVbm9naFdIMUE4RHFYTE1SVGJnWjI3bUIvM2lM?=
 =?utf-8?B?OXlaWkVIMDhlNmYvTkE5Smp0WG5WMWFtTmxlZENrQXhLOXV2Q2dvM1BWbHUv?=
 =?utf-8?B?aUY4cnNCZkt4ZDU4bTlDa2ZNYXcvTHlTdzJHTGRZci8wS2dMdVBuc3ZTSUwz?=
 =?utf-8?B?OSszUS94UHd2UU5Idy9abXdtbnJtOHJrWmdYYlRKZmNKL0xNVWhvSzd6eU5p?=
 =?utf-8?B?ckcvQzBSTUdPTUpQT2lML2dTQlJMTEZFU0RDTmhFbmMyeGNCcytLQTk5MGJr?=
 =?utf-8?B?RjJxN292UmtyWmI1R0ptaVMwbjlHVkF2RWxxRFNKcGpSUHY2blhNM1ExVHB5?=
 =?utf-8?B?ZjZJTWVlVktONTAwSzhoK2EwaDZDc2tVWVFCcjErYStxckpFZWVXUWN5L2hm?=
 =?utf-8?B?L0hBT1Ivd3YrUUlranIyZHVMVE5yamh3bzhBZGk4Smd0ZUVqK3JRMnlkbTly?=
 =?utf-8?B?NDZsOHQ4ZFZSNGJXRi9MeCs0WjRuYVJ4bmwyc2dSQ3VUT00wcFFKeVp5a2x0?=
 =?utf-8?B?YnpiaFlPZU81cGkwc0FCVm5DcFU4Qzd4VVR6ZDc5TWZkRy9SOUNyYWpYN25p?=
 =?utf-8?B?VG1jZW5nd1c5cXk2N2Y2SE4yazh5V0ZWS251ZWFKbGJoT0s4QVRPZ3BmUmZN?=
 =?utf-8?B?djFScTV3bG5pSXZYVitiMTErcVJ0MjZJK2ZycjBDeTFiNUZVdE9MYndBTm9J?=
 =?utf-8?B?aThiUjA2dG5CNGZiVzNDMTBzS3RTWjRmNjJRUzdsMHZ2RFpSb1NFTmlTaitM?=
 =?utf-8?B?WDRqcnpxL1pkeXhwVG1aOGZEd3M5WHNnS3N2SUFxM1VFU3VXa01OQU56SHZm?=
 =?utf-8?B?NTh3NTlBc3dIS1QvWTRwclUzSVc5eDVDY2xkRWd6QzRJRjMvVjJtakZ1U0ov?=
 =?utf-8?B?ejZmbUJDUWFPZUg2dTJ0L1oydTdLa0ZJM2tCVFY4ejBSbXR3Mk5GMzJYOUhu?=
 =?utf-8?B?ZThlUXRKUTlPWkoxcW9vMmFOOEg2bVlsTzBuN2IxWTNNcUFCKzNLMnBkRFN3?=
 =?utf-8?B?cWNVd2o1ZUtWWmpOajA2ODlVcHFzN0VWQVFZU20vTllDRy9JQzUwSDJGRkpJ?=
 =?utf-8?B?SGVjWVBjSTFXN0ZlS2UvNWlwOGxxRFlmQ1FDT2hDcGtJRERTOUc3OHNSUHVa?=
 =?utf-8?B?T1lQTGlTVGFPM0JxZkczc1ZMZnFLTXVSRUlHQU1Ia2lOM3phY3lZcnVaWkFP?=
 =?utf-8?B?YWNITFovSkJSU2tGYmpZa2xDclVzbTRhWFBkZEVLRDV3WnJOTTF3dTFqZXRI?=
 =?utf-8?B?K1QrVmZYSzNqWjgwK2tmTFpiNDlybWRYMVVGaHozUXdjbk1qOStxZVdIekg5?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 544f8aa3-1c1f-4c7f-ba16-08ddc562b01e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:49:40.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm6caU3S87IRU35II4M018Tr03+zbsHzCgqsqC2bLvcGWaP27A/awoJLIBAt2jSd8ahI+roIRyihtw06Jr1Ugw5hbZAkjNw77BOaD2s5coc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> The ABMC feature allows users to assign a hardware counter to an RMID,
> event pair and monitor bandwidth usage as long as it is assigned. The
> hardware continues to track the assigned counter until it is explicitly
> unassigned by the user.
> 
> Implement an architecture-specific handler to assign and unassign the
> counter. Configure counters by writing to the L3_QOS_ABMC_CFG MSR,
> specifying the counter ID, bandwidth source (RMID), and event
> configuration.

From above description it is not obvious to me how configuring a counter
is connected to assign/unassign/configure. How about something like:

  Implement an x86 architecture-specific handler to configure a counter. This
  architecture specific handler is called by resctrl fs when a counter
  is assigned or unassigned as well as when an already assigned counter's
  configuration should be updated. Configure counters by writing to the
  L3_QOS_ABMC_CFG MSR, specifying the counter ID, bandwidth source (RMID),
  and event configuration.

(please feel free to improve)

> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>     Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> +/*
> + * Send an IPI to the domain to assign the counter to RMID, event pair.
> + */
> +void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
> +			      u32 cntr_id, bool assign)
> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +	struct arch_mbm_state *am;
> +
> +	abmc_cfg.split.cfg_en = 1;
> +	abmc_cfg.split.cntr_en = assign ? 1 : 0;
> +	abmc_cfg.split.cntr_id = cntr_id;
> +	abmc_cfg.split.bw_src = rmid;
> +	if (assign)
> +		abmc_cfg.split.bw_type = resctrl_get_mon_evt_cfg(evtid);
> +
> +	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd, &abmc_cfg, 1);
> +
> +	/*
> +	 * The hardware counter is reset (because cfg_en == 1) so there is no
> +	 * need to record initial non-zero counts.
> +	 */
> +	if (assign) {

We learned from patch #14 that the counter is reset whenever cfg_en = 1. Since this
is always the case it is not clear to me why the architectural state is not always
reset to match what hardware does. Even more, looking how this function is later used in
resctrl_config_cntr(), the caller resctrl_config_cntr() always resets non-architectural
state, why not always reset architectural state here?


> +		am = get_arch_mbm_state(hw_dom, rmid, evtid);
> +		if (am)
> +			memset(am, 0, sizeof(*am));
> +	}
> +}

Reinette


