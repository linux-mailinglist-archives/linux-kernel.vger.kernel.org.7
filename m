Return-Path: <linux-kernel+bounces-736245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D60B09A69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAB61C218FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612EC1CB518;
	Fri, 18 Jul 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UN7eJP31"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9261A0BE1;
	Fri, 18 Jul 2025 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752811408; cv=fail; b=EsUNzP1m6jIS/L28TFu1c3zqfYp3FG6mm6PLWkZD22FzkmKoMujIJ+IrlPwu6xyYlYVHMHiC3fmHiaUzMqwbHqFzcLE/xOW8SF0IdYmQyybLAJN7XMLBMilfN5t/K1Ni1cmAC9Gml9p1k++/L+TC7za93Kv5m9z0+iMvS0RkOIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752811408; c=relaxed/simple;
	bh=wCsVSdqamzy+ruWKax+uibUIVhOy4sxilHcRHHmZefY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6XX+87lKmSS0o3V9QL4kRj8RybJ/okWK6GSAOfL5mAp+RcMbXOeB3dqD6RU7f/8dw/I2MD7CL4gS2imocEvv1O2TbY0Q/onKXQO/BHhnBaG92nRpqQfQR3el0sT0pgE0g4JZV/iGk4felnaxgKzqiSv/vpQKDelkWe0LlHuHx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UN7eJP31; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752811407; x=1784347407;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wCsVSdqamzy+ruWKax+uibUIVhOy4sxilHcRHHmZefY=;
  b=UN7eJP31vsVG188peYfEge4KDtNBMKFupi5swpCJ0YLHphG10i1MECNb
   F42RoFTrseUCJk90brCFrP3/bGyoByfCRWWU4Jnyc1RPwwUZOVd33fm4l
   0zr5JTOSKPO/342LbfCwAVorQxZSW++f+FuuFluvkqZgz/+G1YLj/eYMN
   AUmzKrEpLrPiiaTQaj2EO1oVlAb4QTUc+B5uL4C5IqAhWFZWBlMl+zITE
   zXwPA2TaYL9eG8rod3NAWI193LB/TV48p5uxZJ9bRZRz3S7tdmTF4D3ch
   1tG9QqyGqtWyEPSUR99i5t3tH4FfuH7jRYEaR4MYfAKKyResnNCPT1g6+
   w==;
X-CSE-ConnectionGUID: hM0arnHZRmapgHsOGdUXGA==
X-CSE-MsgGUID: CMlB+Z+1QYuSZhBQjHq+hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="57713762"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="57713762"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 21:03:26 -0700
X-CSE-ConnectionGUID: DIuztqihRwax2HQ/aYFaAg==
X-CSE-MsgGUID: S9naCQ2WQUuMhhOeBNxSvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="157351265"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 21:03:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 21:03:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 21:03:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 21:03:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiBRn/KBxJ/WlocWICDlLeOzIfZ6OtpWg7K3ECGfwYybRVPzkoJaSzxVckZeAagk6JZ2ZxfaF4tTvSUk7upcMsCFy+rfIb8VnkHDcDc3f9wUiuk7MUbAaWAUge5O2V040ziRLBdgun66dFIWdESha9qAwBrvIVAZpnNak+zP2Qd2fX8JpP9QeHayuR2pvMefwOSnqQk07LRXyo15m6FUnAh34tFu9GZOf8w4/3HUEmheH7VHt09uLUqtrZYDOehXTsYfoRq9UOeNfnq4F3t8dqDz+X3aANsp+r3K6jDar7Ew3WIDTIGg9AVxD8gojwT/XE/uElnXAR9YNAzs/0BhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmWxV9XmntwIECJ2VbgxTO8VfiPpBub+DabqA7S2B+I=;
 b=sDqLocuEXgE3d7+Yedy07ouplfXQKlfnzulPdeIlwbyVZfi5KwnAIMDOMLf4mq4hAopU8BhKcKkGnysa3iUQR9l0dh5/WCHjrUvQ0zk/uGfkipGlbyyikdcE0sFDdk4LFQAQtTd3ayx76ZvxO3W/6MIQ4vU+MfUyE8AJaw4l4DMcrM3z0B6gDzcFlP1IrRw2CdkNJ1DJmFM05Djjy6Lav/cYxJhgwXZsFNnsB4N+rSfP6mzS/qsDB0lTKGVuxoKcExB6zDDSqFbvPNWgO1rFW6aXg7BlUARw3BpXdZnoBK62xnVKQZpnvZvkgKjHOiZUi5A7Y9AtNiFrb1f8pbsYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 18 Jul
 2025 04:03:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 04:03:05 +0000
Message-ID: <af0a7a35-2f6d-4c8c-990d-af809d9547bf@intel.com>
Date: Thu, 17 Jul 2025 21:03:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 33/34] fs/resctrl: Introduce the interface to switch
 between monitor modes
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
 <7869219493bb4cc5626da704c4f8f107fe7c8f69.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <7869219493bb4cc5626da704c4f8f107fe7c8f69.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:303:dc::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e6510e-2552-4194-9db5-08ddc5afff67
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUxBanRuY3E3aDNaOXg4Ri9rZnVxbUVUVG91L25yd2FRaXdWZWk5Wkt4RUFp?=
 =?utf-8?B?N0gxQll2ZGFMUWxlU0UzbW83Y0REeWp3QUhUaWFpRDdOTytuaHJTTHM3WFdi?=
 =?utf-8?B?RVVEWk9vdWFzMjFUa2tRSG12NlEyUUJTa290NDRPUHB1d3N0WFlUVlJoSm9H?=
 =?utf-8?B?WGp1S2hPL0RUYnluT0tKeElocXFQVkVpeGRFT2lsOHp6eTlNUXJKck03eFZT?=
 =?utf-8?B?Mzhua1lsN1VPRzhEb3BRU1BXdkNnU0ZVanRvcUc0ZFJTZjZtMVJVeFlXRTBT?=
 =?utf-8?B?alc5L3pZVFZ3WUcrVXdJMnpIZ042VzVTT3FwaFV6Y1EwdjhFNVlUcU12U2Zr?=
 =?utf-8?B?TDZYN1V0Sjcwc1BxVXdyRnVJRitnQTQ3OWVoVUVqQnZwZXZXZmJadDBGc3E4?=
 =?utf-8?B?cmhLUzBwTFFJY0dpaTJqS3paZU5ManYzZlMzNk1xb1c2T2tFcUd1Tmp0RDdn?=
 =?utf-8?B?d0pNc2YwMGJxRUhVZC9mUTVyZlFCM0IwUlJHTnlMY2pPTm9STk9HUjhHL3ln?=
 =?utf-8?B?Qmo4Vk1TMjdVY0dmeTFVMWtPc0MxdGJVRXZEeWk4TWVkS2VkQVllME1WZ05C?=
 =?utf-8?B?NTZ0TGpKVFdyOVByMncwdVBYcGZsd2RNZ2cvVktSMEtYanZKQTMxd3hZbFhr?=
 =?utf-8?B?Q0c3bFVzNXZ3T0Zyb2JxOVRIUFdVWnRDZCtDVkxKWjBKOWJ1VGJLUWJDMlFN?=
 =?utf-8?B?MXljbmtZMTNjUm1jYU9pVDl3NnBTaDl5SXJrVXY0cXJSYTgrd2gxb2NEUUV4?=
 =?utf-8?B?YjUxVHdXRDBXTlBEbmNqVi9YblNDRFZ0dXJQYk5nUnFBWXB5SkFydm9HNWRM?=
 =?utf-8?B?WHFLUEgyQ3FnMUlMTEdKdFVIVk4rRktqeU1JVHRRTjZOS2pkanJNbldzQnJp?=
 =?utf-8?B?OEpMSDcvbFBRRnR6SWJXVTlMQ1IrcE16Qi9yeVJsdFo2RWkrSkYyQ09ZdXhD?=
 =?utf-8?B?YTRpMU9SaUkrajdTOTFnbmdqODF4Y1kwMXRIWDRSSzFqcTVKUmpjaE5ybzZo?=
 =?utf-8?B?WHlwY0hONm9DdGwxWkFzdUIzTVoxSjhoRm8xMU9RRFZoU2pKai81cG1vRkFm?=
 =?utf-8?B?VGN4V3JFb1JHNXk2QnNzak1GMnVFVngrTythLzlITnRUb0kvMHMrVHkySWtX?=
 =?utf-8?B?UWZCVlFnV1JhWGJ6Y0U5czdoR2lCd0daN2d3MytuaHU5WmlLQVozcldWV01O?=
 =?utf-8?B?TG8ra3Jqc3pnd0s2N1dkRXltTnRyVjRodGNhczhxWklKbEdkeWVPWElOMHM2?=
 =?utf-8?B?dXNnYkpYOE1sTkprajZ0NmY5YlR4ZG1raERHSHl6QTRaOHdRMEExdndpKzNh?=
 =?utf-8?B?ZElGUWZmUHdwcmNpZVN5Z3d0SFJ6SVduOVgvWVlNSm1ad3h6R3lGaUNRVFE2?=
 =?utf-8?B?cDJSellIaU5GM0VrTGphL1dvUFVpd0I5YmFwdWZndzhMTDNTdFJidXNQN3N6?=
 =?utf-8?B?clUvVENlT0ZYRjJ2SEhINWxNSHJNYkRUdlY0dGxjdGlRVFdBRncrNjhsSFhq?=
 =?utf-8?B?aWRoNkhBUDN4S3NPZmVQOEFVMmp2eVZSajBkbVhoQ2IrVzdnQTgydUlsVXNG?=
 =?utf-8?B?amFHdGNVWmNEZG12cVpZckl1NGZaM1NGN1NLWjJaQytwSFh6dm1qZ3ZtN2My?=
 =?utf-8?B?MGg3WUl3aTM2YXRVWjlrVlZ2YmhCeEhQVTUzUVd0SGZuZGpVQVMrcnJpQlEr?=
 =?utf-8?B?WFo2MndidEVzbVZLcWpxQlVqb083eVJpU3krSzYxVStCR0RlZU51YmJ3eUlE?=
 =?utf-8?B?VjVQTE9CRWhhSzZrNC9nR2J4UC9NYTRBOFZSWHhEbFhMbkp3V0NIdDhLTUhZ?=
 =?utf-8?B?RDdGOUU2SWJZRTh4eGY2am14MDNCeVVVN3FhK3dOdllIMHBsTXZjR200RDZH?=
 =?utf-8?B?L20wQnJJeGN6YXdLTkU4emtBajFrNjNHNHZuYXY3Ulhrbmt5SmNrTVdRSC9n?=
 =?utf-8?Q?qVt9pnqYdY0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVQdXkwRjBydGF4cU55TGVzelcvdm9mZnpDNEdkQkk2NHQ4UTlhUW43YmJk?=
 =?utf-8?B?NTRXZkdjZGFhRUVjUzhLNjBjMHlWVFEvK2syQmp0V1FJYkQ4QTNIcnJFd1Jj?=
 =?utf-8?B?QnhUVEtwYXpadTJ2WXRCNVUyQ2UzUVJRNEx3RW5NUm43QVIrcXAwcG5lMGRB?=
 =?utf-8?B?U0ZZcUtvaCtCL0U0TTJpZHA1OEhBb2RXT0tBTmhkcXFHYVZlbFF3RkxlM3N3?=
 =?utf-8?B?Ny9va0lvZlB4ektYaU15WEYwTW9EUmFXWmVyYnF4M0dUOFhiRVFwNG9ZM3NN?=
 =?utf-8?B?TkZoWllpSzlYREpBV3dycU9DcXhWU1AwdDZwNlVyUGtMSUdkMlFTV1cwTzZK?=
 =?utf-8?B?SnRlWGwvMW50RmRMUjRzdHg1UkoybDlxdUZkQmlJbUdnL0w4Nkcwd1h0aXNQ?=
 =?utf-8?B?Z09oZ0p2blZRMmo3allzU3ZFNHZ0SUtKSS94YTNUVzhrRXZSbGgrb3N3M2U2?=
 =?utf-8?B?MW4vOTdQdERlbWV4Ky9jdlV0bEFPZExHWTVsRG5GOWNtYVFlNU1TWnlJYVNB?=
 =?utf-8?B?dWpNL3hyb0lod3dFdHZKVkxRMjkxUndDY2Z2bGRmYXJxVWQ2WnIveUZ3WVVB?=
 =?utf-8?B?cjEzRDJqU3dvNWd0N1lteWVxR0NMdWZhK3JQMUNtdW5pbW40NjdlQ1R3dlBS?=
 =?utf-8?B?dXdkS05FTDcvK2xEazJYYkhYV3JQeTlDVVI4L1J1dU53TWpDT0p4VE5zSUk4?=
 =?utf-8?B?aFNZaWhKUkVWdXo1ZVowMU5xVFZkQm5hcmJLdk43Zkd4MnpzSGF2TEFnZXhE?=
 =?utf-8?B?SjdHV1ArNFlTRStZTVJkVER5VzdDbmR0VHNiNGxCakNhUGFodW1KS2ZMVng1?=
 =?utf-8?B?RS9hY1ozRWVqdXBIbzlDanBmN1BFNFJ3T1Zwdkx4cUZEZFB5TkV3dzMveUho?=
 =?utf-8?B?dWE2MjRiTGJkWEE3ZVgyTjh6WWs2ejV2ODNaYmg1cFFOcHl1Szd3S08rQ2hX?=
 =?utf-8?B?K3A5WXYzL1ptOUJNalVoNUM5MDQ4U2ZoNzdIZGNsTk4xeXBNajBEVXIrWEMz?=
 =?utf-8?B?L1dWeGpjbjF3L21taS9iZUgreFFEcDIrRlB5dU5JQWc3U3Q5L3hzTzN5WHdM?=
 =?utf-8?B?dVJRWEQvY01yUC9SZFRJK0JHM2d2QTVMMjdrM2F5d2ZNTjJmVlhnMzFlUHBJ?=
 =?utf-8?B?Nm0vRC9Ocld4bkJ6MEduZ0lQWFdWZjdQL254SUhTWjBab093UjVzdWl3TjNl?=
 =?utf-8?B?d3RGNG5DVnNpZzdhQ2Q4QWQ2RlV2VnMwRjJzUDl4djlpY1lTZWJGTUpYY29v?=
 =?utf-8?B?UHd5ZDJGYk5QdnZYd1hTRHhjN2J6cFhucTAxL0ZWajRpVGRlbXpIQjRwUmJW?=
 =?utf-8?B?d29IQjlYRWhSanpxQktya3RxWThWYndQOVhqMUNyOTV3R2Y5N1pmRkJiOU16?=
 =?utf-8?B?RXFtblowTHBsNkxoVjhqMlQrUmczeWJPcThaYjUwZVA4Z1BrV296MG5lbU1M?=
 =?utf-8?B?T2V6cmQxdlhBWDV1UlRkTFl1eC8vY2kzRG5MOTUrc1lpRXlDQU9QTlVIaHF2?=
 =?utf-8?B?Y1V2ODRRcmIwOWVWQzdaNGswWXdFaWJJRkcwRHBsY1c1Ynh3cHk1MGdxV0po?=
 =?utf-8?B?RUZaNkhZajQwMHhyUko2K210L3cxQXVxNytLMlB6TDJaMGo0QWFaZmE4MWl4?=
 =?utf-8?B?dDVKclZKY01CUGRDQ0N3djFSSFRIZ21SZTJXRVV2cmcwRExQOTJVK08ydnpF?=
 =?utf-8?B?UktISkZFUEdNRVhvalpwditlUTFVMFRSclFGMFRNbnJ1T0NrZUVaYkJzMm5B?=
 =?utf-8?B?eDA0OGNHNlQ3SFFONjFFZXNER0oyaGgvVDZUS0tSL3pmR2ZXcWdhbm9rdkI3?=
 =?utf-8?B?QVUydlNOTWF6S0xRQll2UzF6YlVBOEhCVVBWVktnbmxuS01MNmQySFUvMEd0?=
 =?utf-8?B?RjJnZUtWSUJkcFVjeFVLdXI3WWVISGZVMHRLcWlhbzZOK2EzOVl1akozU1ZV?=
 =?utf-8?B?Y3JhMjNMYldOYk1DVDhkT0NPN2swQmllR005N1NORTZwQXV3WlRLZUNSNjRn?=
 =?utf-8?B?bHJURlY5L2ZRRDNhTnR2TDI2M2hkcHkvdm1XWCtSYnMvU0JLMk8rbjE1Ymx4?=
 =?utf-8?B?aE9QbmRtNzZpNnBJb1pVY1pZUkpCWlZoQVA4b3E3M29tSjFZc3lYQndiZVR6?=
 =?utf-8?B?QXZNaGN6NUxsMyszWm9reHBsWVZnVkkvOFlwZ05xYnpsNEtHc1JYWkR3YlpV?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e6510e-2552-4194-9db5-08ddc5afff67
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 04:03:05.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rv0DsW1PfDNIxOaChN//++4bTvGWsRBjA5E7nvqojrayuaRkaxPvEMuK9DbuoRRbJjsETKjiQZQMn5fcnPZDizoFRLh/gOMHe2BoefKCd2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> Resctrl subsystem can support two monitoring modes, "mbm_event" or
> "default". In mbm_event mode, monitoring event can only accumulate data
> while it is backed by a hardware counter. In "default" mode, resctrl
> assumes there is a hardware counter for each event within every CTRL_MON
> and MON group.
> 
> Introduce mbm_assign_mode resctrl file to switch between mbm_event and
> default modes.
> 
> Example:
> To list the MBM monitor modes supported:
> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> [mbm_event]
> default
> 
> To enable the "mbm_event" monitoring mode:

"monitoring mode" -> "counter assignment mode"?

> $ echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> To enable the "default" monitoring mode:
> $ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> MBM event counters are automatically reset as part of changing the mode.
> Clear both architectural and non-architectural event states to prevent
> overflow conditions during the next event read. Also clear assignable
> counter configuration on all the domains.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst | 22 +++++++-
>  fs/resctrl/internal.h                 |  2 +
>  fs/resctrl/monitor.c                  | 27 ++++++++++
>  fs/resctrl/rdtgroup.c                 | 72 ++++++++++++++++++++++++++-
>  4 files changed, 121 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 2b2acb55d8b1..b8a4dbe061ea 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -259,7 +259,8 @@ with the following files:
>  
>  "mbm_assign_mode":
>  	The supported counter assignment modes. The enclosed brackets indicate which mode
> -	is enabled.
> +	is enabled. The MBM events associated with counters may reset when "mbm_assign_mode"
> +	is changed.
>  	::
>  
>  	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> @@ -279,6 +280,15 @@ with the following files:
>  	of counters available is described in the "num_mbm_cntrs" file. Changing the
>  	mode may cause all counters on the resource to reset.
>  
> +	Moving to mbm_event counter assignment mode requires users to assign the counters
> +	to the events. Otherwise, the MBM event counters will return 'Unassigned' when read.
> +
> +	The mode is beneficial for AMD platforms that support more CTRL_MON
> +	and MON groups than available hardware counters. By default, this
> +	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
> +	Monitoring Counters) capability, ensuring counters remain assigned even
> +	when the corresponding RMID is not actively used by any processor.
> +
>  	"default":
>  
>  	In default mode, resctrl assumes there is a hardware counter for each
> @@ -288,6 +298,16 @@ with the following files:
>  	result in misleading values or display "Unavailable" if no counter is assigned
>  	to the event.
>  
> +	* To enable "mbm_event" monitoring mode:

"monitoring mode" -> "counter assignment mode"?

> +	  ::
> +
> +	    # echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +
> +	* To enable "default" monitoring mode:
> +	  ::
> +
> +	    # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +
>  "num_mbm_cntrs":
>  	The maximum number of counters (total of available and assigned counters) in
>  	each domain when the system supports mbm_event mode.

Reinette


