Return-Path: <linux-kernel+bounces-751282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B2AB16735
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE9662341B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0FC218E9F;
	Wed, 30 Jul 2025 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0ExY8xe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F31FFC46;
	Wed, 30 Jul 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905265; cv=fail; b=b/OD7vyu/XUrX4N7lV2G4RZa8NchsLYWLJ4zalzG/dd0eW13zd+NVAVBMG1wYgVbml+VL78E3nnoxw8ys+DZ5ELEzxaIB7QmmiDlv7lMfqM1kn/eZf9BycwAFpftbVkIzonsDHdkGt70ofMUdJdHGb39WHvhKLCpsRUQY4BfTvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905265; c=relaxed/simple;
	bh=JbV1dg23tPPeIXv/MUZg7DsAVN//VWwUGTghv1KsAYs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JC29rp7Bk6jeTNEGKjDEXqLoldDINXJ4ilxvFiX7bU882O9LlILdBJA520ZHBwyvjSFmVnPfGXbtIhp7PKObfONXnYpoBpXerhvqLWWgjvrjIWcoNOuE9vt1Zf7QfLHcXZcuoc85+L+7o7sNIXsSPxrvVBYVxt7i3RLILYmpYSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0ExY8xe; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905264; x=1785441264;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JbV1dg23tPPeIXv/MUZg7DsAVN//VWwUGTghv1KsAYs=;
  b=I0ExY8xeRk/SqHfTebcSQGXuj5G8EdY6ajKSCSR8RSee8udcJw3j/XFC
   G9hboVmufPWYCm69WOzg9o1Kl3VnNe0uIPNRnlrGjILTTtXvTlfvdym2k
   3Wf2m75pbvvuRQOofW76Sp+cMmevRAZsviJMG5v1tF9rH4ib8qcmzdI80
   ys41scpBpsJcwq28PWqkP3vc6Osr9adYWc+6ZPaDpdVNyNiQBuC/6/6CG
   vEX0z1EWXQyXMaWUMQ4AXfTuz932B3XaDVdjkASYoYPqvCAyr6xHKoa0x
   splRm4bKviqyyx6BwWRAPHN7IEOKEIjQc6xE+VzY3ckXK/6hXwQx35UGt
   A==;
X-CSE-ConnectionGUID: 8+5HvgKmR8qShIGmJITNgQ==
X-CSE-MsgGUID: EvTfBVhLQKKyKCaSTuUjIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="81671561"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="81671561"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:54:20 -0700
X-CSE-ConnectionGUID: drBRhTzmQh6At/pUQEopCQ==
X-CSE-MsgGUID: NX6AQxi4TSeukxl8ceuLBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163419855"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:54:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:54:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 12:54:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.61)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VN7GgAOrtHiprTTcHehgfHOqVPKApX0z6yOd0wlgK1+Kh9CTnFtGf0dDbHhjnMcUIyS++S4jQrS4RRLaVoxSnOGRlVXIbNI/+pF8jcQeywho/MpjlExB6Q8UQ90U+FxsqOjWNAxgs32nLnW/6quuI/QmQt0e0ky7GpgHWZ3hfKGVMnHX8Tv3lvPiv7dwLnI8DDSp36Isk8adKdpXA2uKafN1JjqyZwHdn60skmPtuDFOo1R4NUmGR1lJdvJteGzXUIAQ70d7cxVzgn32dnkNrKNSk0KZYw70sCE2OdXdkMAGc201fftL16oiqWmf+v4E6v2/pnj9n6z5V+9Azj7gmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMFvjDbQGxC+dPtpVtdQ6l0v/5B5UqcT395ESxmlCuE=;
 b=rgrLfA3oMOD7EF5VA/Mj1npEKiEcoLUtX7V5eAilwNIawqD0ZijO3zTzwXFTIs8voMo5oEB+Q1mqr7WjbKQgZr4T5SRHFrIcEoWAtDpzp9Zy2PGYTqvDLdvkE/e3191m5JIcUad+uYwhk8Vk5oGAnHuTN+KZQb2PcuP5fO49DK0WYr+0jhK4iFzDoeKEHsRrbV6alGoAAdYAhzO6tJ2nVtRAIOUX99hDZVLLncPdmGF91KXDCKa3Oq7qYuWmdakeqcTYNWoNth14qKtF1mMU3QhT/+xG3LFSIDqp3D7KPdHh5sOVG6SQUYVXCjrkDl5ikihHIhQQaSAgsg8KATgDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL4PR11MB8824.namprd11.prod.outlook.com (2603:10b6:208:5a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 19:53:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 19:53:46 +0000
Message-ID: <a65263be-523f-48a7-9473-4f4db1b458f7@intel.com>
Date: Wed, 30 Jul 2025 12:53:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 18/34] fs/resctrl: Add the functionality to unassign
 MBM events
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <8289b3fcfabe6d820620429646b18660e7cf9ffa.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <8289b3fcfabe6d820620429646b18660e7cf9ffa.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0328.namprd04.prod.outlook.com
 (2603:10b6:303:82::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL4PR11MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: f6002594-3abb-4b00-9012-08ddcfa2cb84
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHNsVk9VK0QvYnFMRlVUNzFhajhpUTIxeWw4c0hPZEtOUDdvYWhXOTg2aUp5?=
 =?utf-8?B?RFZJT2dPYThocjNjTS9DUGFvYXF1cHJPV0VTdExJeDcvNGlzWDhXWkNvanl4?=
 =?utf-8?B?VWFwU1ZvZzl5WXFWNU9EYnIvT1NPMzZieldySlgyOTYvSVAyRURnWi83V1E3?=
 =?utf-8?B?MjBwN0hWcXczck1YK3UxQ1BDRm1GMFozWm1HTk1oai9ldlVKWWVycE1IemJT?=
 =?utf-8?B?T0syd3plbTh2VmlMWnBrRVZBVEVUVms4S3d5cVRzT2k5Z2dBVlpWNzVTQnVa?=
 =?utf-8?B?cWtsL2o0OU9qMk0rS0J6dHI2V2ZjV3pRS3d3Nnppa1QwVURMZ2ZrSFFyWEcv?=
 =?utf-8?B?d2ttTHIwcWNwWWNrZ1ZhaVRQY0ZLb1JZUkhPRG1qelVDWFltK2ovZnRodW5k?=
 =?utf-8?B?emxEOHBobFI3bHFMblNJeEN5Zk1aY1N6eXZjT3ZVQkpESVhoMFV4OEdzSHNU?=
 =?utf-8?B?akxDSmpKVDFWbmlDdmVYS25wejNZMEt2TzJLd0hqTUpGRTNaQ05KNGNlSFF4?=
 =?utf-8?B?MXNxUTVoMm1NR1RkNmgrd0luUzdQQlZ5M21VUlJtNXVCYlUxR2NTS2pQY2xm?=
 =?utf-8?B?TWFGZ1I5Mk1NYUJmOW9FS3JvMFB3MWI2dWxSazBZanJJd2xVZVRoalpuZ05u?=
 =?utf-8?B?ZHI4c3hzK1dZS0x2dDlWcFA5TDJqWDMwZy9JL3N1anFWRXpXc1V5WHl5TFEv?=
 =?utf-8?B?NjcwWGdhVG5nKytpbVpXQTExbmJQQlRhVkw5NGFyOE5FWnRVVVFoaFRmR25X?=
 =?utf-8?B?SXpha0tnVm84WGJqa0FkSlZ1UHZPWWhHSGJURCs4RUpTYU1CWCtVVDBNbGFi?=
 =?utf-8?B?aEhpRVo0S1dudnRFc2lEcExlN2E2Q1VuS1U0VkFZY0UrTVRlN2ZXcUVLZ051?=
 =?utf-8?B?NFVZTFpySU1CSnIzUHhwTUJ3ZEU1QlkzbTNxSnZDb1lDQ1BUd04zRmhMWC9B?=
 =?utf-8?B?YzlBVkcvWXVoR2h5OUlzam0xdkVnN2dHTnUvZDhnTHY5VXNHWGF2d1ZnVy9u?=
 =?utf-8?B?N2hSaFJYejgra0V4Sk9BdTY5SEpsT1ZGSjA5L1pndDN2U0thaXFjREd0c2t2?=
 =?utf-8?B?SFZRRW9mdlBkVE1GYVZGKy9adDBqQU5hOFB2blRvQlVndlF6Q2g2WXRvMHhC?=
 =?utf-8?B?Kzc5T3orVEpyU3hhTHRuTCtKN0VnelNrU0lEWW5uVUhOb2IvTDErQ1ZwNFVh?=
 =?utf-8?B?OVduNFU4M29aL3RLMmNYVDdnV3ZUcE9QeGZuZEpLNUFRZElXZHNCKzQvRndO?=
 =?utf-8?B?OCtWbERwYVJJWWNKb2JvNlk0WS9aTjg1ci9ETGxOY0JKallHZVhoVGlkMWRn?=
 =?utf-8?B?TzdGZnMzZ1Jpa1VOL3REV2wzS3FocnNlY283azNEMDVwMUg4U2RuR1NZU1Bl?=
 =?utf-8?B?QVpJOGh2d2pXcmtzaDNRbUI1Tk9QaHJvRG15ZlJwV1FuQ21RMzVudmVlWlk5?=
 =?utf-8?B?Y0NVRWZENlpyMyt1R3BlTTRJSTBaeDdCMmNueFJZMjkwMitNYXd5LzNaVzdu?=
 =?utf-8?B?L0ZiT1ZJU1dUQW9IVWFXK3c3TkJRNlVuUHV1K0pEOTZkRloxYml2RCsreE9u?=
 =?utf-8?B?YUVrTlQ4T2JBWGZIZUY0ZkJod2hQMDMwaENQV3BvQWc3Qjc4TEJCUCtYSzhJ?=
 =?utf-8?B?QXVCNHFTUGVWbm9SQkFIRFJMMWZ0bEo1ODdMOEIrR1JUUnBmc1pFRTl6c28v?=
 =?utf-8?B?cXN2YnZOdzdyWVlEekZPenlMZmx5RStmdzJKTGlLUDJmVkQ4UnYrZEhxdmd6?=
 =?utf-8?B?clozRS9FanR0UFBMRWh4R2lWTVE5dHNsenF2RjVQazJyeXFPYVY3SzlUQ1d5?=
 =?utf-8?B?Y1FqMDJ6RHRicXRSeWlKSFVWUy9rZmdmT3VlbzlKZXdMaHl0RHZ4TzQ5MTEz?=
 =?utf-8?B?NTQ0SGFOU3Zyb2N6YjUzRTM1RU14LzlKMVk5MEdtRmV5dFMydjJwYldpb1oy?=
 =?utf-8?Q?3rEj7luDy8s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTNteFVKMWd6QXVJWUpEWGxFU1orKzlYcHBnWEdNdHRvMlZuN29JZG1kSFR2?=
 =?utf-8?B?WVRVREdLM0F0Ykg3VkdKaksyWTlmVVRzNTVTa2JaVVIyTFM0M2Rxbk40QWZQ?=
 =?utf-8?B?YW5ZYWNwWmtzc255NWdoVVFZRlZNMWRjd2VGWmdGWjdzZEN2dm9uOUZBbUFF?=
 =?utf-8?B?OGVuU2ZaeGUxNWl6M2p4OGJNOFM3dEU2NmlCNlE2NUJFZnAvNDNrSlBFZTlU?=
 =?utf-8?B?cHZyVXpvdkN5aUp4bHpZelJERkZzSG1SSmRnY1pCRC92SkhmZU41aG9iT0dD?=
 =?utf-8?B?Tjg4aUZ1QzlkNmc4ejNCM2U5TlJIL3BBRjQwOVIxV2JPYWRXRkdLa2tJalFr?=
 =?utf-8?B?QTBRNWVJcEhOZ3UxbE1MakpxcVk1RWVtaS9aSGYzSnMxdlhNYmNoc1BKVU9T?=
 =?utf-8?B?LzZDc1p5Q3ZiMGowV2szbnpmNUJkRFFQZHR0R1RFUUUwalAwRjBoTHdRSFd3?=
 =?utf-8?B?NlpjNDJDMlUxdElES0hXYWdNcUFVMmlrT2JpM095a3o1bmRZQ0dGUzBYcXIw?=
 =?utf-8?B?UmlmMDlwME95YnJKU2w2d2dyQ0M2Wk5QZGc3UU9rYURmTGN0UFFqZE0yVVdj?=
 =?utf-8?B?ekx5QUZ4Q05qYjFXbWlJODBUd1BCWW1YdzNrN1Rnb2lDUWFiZ2lpNXhiQVhF?=
 =?utf-8?B?R0l1Sitzb3F5Z01uWTNUWk5VOWZNM2g0eG4wZWYrOUVwaHNXUUtUVVpQRjBs?=
 =?utf-8?B?aDc3MVhEd0VPRzRrM0RzRGI1b0ZKV29HYVdhV3ppV04yZldEczRFV2lTYTVx?=
 =?utf-8?B?V0hkemQvWVZzVm9MTDBMMkh4NU1WMUFJZy9UK0F6MDl0SGFrL2krS29waXlt?=
 =?utf-8?B?ODdYT0JTaEJEc2ZPR25keUh0TFVTRXdvYS92dkJsU3FrT2pVWiswN251OVVH?=
 =?utf-8?B?aTN6aE9xMGxCVVNWajVVRnBOUlNVNjFtUlAvaWJieXdIS01IaUVlcUtRYmlz?=
 =?utf-8?B?d2VHbTdQajZDQVpoMkF2czlibytSMERrY3A2UStybTUyaCtBeVdCUVQvSVNZ?=
 =?utf-8?B?b3l5MHZqNDFMZEYrVzV4dVBoWkpHMi9xaTJnVnp0cVZkSVJES3dkcTZtbExM?=
 =?utf-8?B?blhFRmtyd3RqZ2NST3JOOXhRbld3eHlYMWw5NDZ5NmdXcGViaWFHY3lPaVlI?=
 =?utf-8?B?Qkc0MXl1aDZBYm52NFRIZThVb3lRV1N3bTJ2d2tqQWRhSmcreTFzK29YcHlt?=
 =?utf-8?B?SjNQVTEvMStYZEZUSnYyc1BrYlBiZVRTSzcrUkV1YnkzSGd2dXN6NVIzejBn?=
 =?utf-8?B?MTREejVxZE5NM2Q1RW5jMkNQbWc2K3E4VXY5NEduZUFSeGh4cG1wbVVOZE9E?=
 =?utf-8?B?OXpMM3NXc3BtdUwvVlBBcnEwNEM5ekZRRmNzdTlkc0wrWk01c3lQSktsL2JG?=
 =?utf-8?B?TmpKbXg1bmRKaWdOYW5aR0ZxZzkrWFBLYkFMOVN1TEVFRUZSRm4wcmcweDdF?=
 =?utf-8?B?dVVVeHF1UU94d0FsUjR4RXJnT3l1WXdtVWl6cC9GbjVtNVVlZ3Vtc1VzNmxt?=
 =?utf-8?B?eXNGSUdPbUpiZjRoUktVR0pDT2xNaGg2L0pucFovQnZoR3FGeG5maGhiRTlF?=
 =?utf-8?B?MHVhazJZVXI0MmZjZXFVY0x1K3VmZ2ZlNWRjaFh6TlAwVzdKS3haUmgyTVgy?=
 =?utf-8?B?ZFJNKzJxMFEvWVRTQjVkdkQyeFUwaFhWSnZKa1lxaDV4ZUpvdUlLMHcyWVdB?=
 =?utf-8?B?NEFIYXduQzBhTklRV0FkTGpCVWFiRDdHRVl6Y1FCZWUyVnBVUDZGcll5d2xa?=
 =?utf-8?B?dXZaQVI3NHZQd0FVUzBUQzBRa3VZVG9RcUhCM2pWNkt4ak5mYVlXclBRUHZa?=
 =?utf-8?B?MEJmSWZvNnVsaWZCcExtZFdDVm9vdGRBVnNnQmNVOE9oZkRyVGcrOVdnc3VH?=
 =?utf-8?B?RlVjK0ZCYmNuc1lXYjFaYlZTUGtnT3FMc2dhZ2xFVnJiczN0dXR5Vm1QSzl5?=
 =?utf-8?B?cXFHMVhjZFp4SzVoYk9nREl5Q0ZrOURmN0dLSXRGalJBeXdpbEcrWGNUTCth?=
 =?utf-8?B?elBvQUtLYVBTNW9HanBvM0d4amM3Vkk0N1J4ZEtRdUJUUGV5ZjZLTU1sTVhh?=
 =?utf-8?B?UVFYVGNTalBJVXhuYy9ob2dTNE5Vc0lEelE1eHI4MFphK2sxYlIvVExkREx2?=
 =?utf-8?B?aUVJempISVB3L2lsNnVlR1pNRkFaTFZIY0JqZ216NGF6TXF0eWlFQ1B6VnZy?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6002594-3abb-4b00-9012-08ddcfa2cb84
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:53:46.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDXt+kMgPg6gswWkR0q9/uarzx0AUvJzp0LKeFfupZ5S2U0i+AcKRboNDMOiGsny+3RFUuw2conzaGj8CFIR/oR/5c2Zly+QbmT4YoppbdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8824
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
> counters that can be assigned to RMID, event pairs and monitor bandwidth
> usage as long as it is assigned. If all the counters are in use, the
> kernel logs the error message "Unable to allocate counter in domain" in

Needs an update to match new message.

> /sys/fs/resctrl/info/last_cmd_status when a new assignment is requested.
> 
> To make space for a new assignment, users must unassign an already
> assigned counter and retry the assignment again.
> 
> Add the functionality to unassign and free the counters in the domain.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---


...


> ---
>  fs/resctrl/internal.h |  2 ++
>  fs/resctrl/monitor.c  | 46 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index 419423bdabdc..216588842444 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -389,6 +389,8 @@ int resctrl_find_cleanest_closid(void);
>  
>  int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>  			       struct mon_evt *mevt);
> +void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
> +				  struct mon_evt *mevt);
>  

Similar comment as previous patch. Please try to keep all monitoring code in
monitor.c. The caller rdtgroup_unassign_cntrs() can move to monitor.c and it
can instead be made available via internal.h


>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);

Reinette


