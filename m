Return-Path: <linux-kernel+bounces-736238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2362B09A58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12758564649
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E21CBEB9;
	Fri, 18 Jul 2025 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgXtqYuf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F431C84DD;
	Fri, 18 Jul 2025 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810988; cv=fail; b=lG4Cuz6oLqp6WXqX8J+guK0iBFEwv6mrGMNeHOmd0GcLFIVlaoRc5M+DH/fxpsk6ce30lTEmyZF388SDZDhrA+TnNWv0Oo9prjzaRZwsDQKxHGtxzjohglySRMlJ23dBfSJWLweKzHjftZ3pSHxPC5WWKvRnOmqTwS8aJckfPuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810988; c=relaxed/simple;
	bh=ZzzDta5ELgo3hMKxUfyDzAabqnhBLAZEvaYf8iieyHE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWBZYdQUiFK9v+9iSulKp9gnjkHgoleVdAflibgXbTjOk5Argi9W0frFkcbjHxMdOpRs3oAJe/6ynEg8xoJBjbO5Sg03/hS1bxnteBJYR3huPcGqj0TST855Rt4qznWECG/CCsynH98PjzUtzbjHVErv/zqwVmJ4LHaqVLJyz6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgXtqYuf; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752810986; x=1784346986;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZzzDta5ELgo3hMKxUfyDzAabqnhBLAZEvaYf8iieyHE=;
  b=AgXtqYufXUH6gl2XKE2HSyY3dslhMPImwX9mG4djYyEhCEClk9xcYrYW
   JQ80irF9o6rCEJydX+tKRavnj9me2ADRhd41wm8WHq8s6fUGYhL+2zNh0
   6/23qTVUwP1hC4VeeEI+kYweZcQgYZTP66Ic+DRjSFievxqDI6z8qWJ/T
   F7MiHbI+dJaq8n3uE4l7809FIbiZbpWbpUFYwzroRSZccv99N0wRzb2S5
   kSiAnznID/TX0BySPmik3N8PDdSYSzjD/k9RVzZvrBAuNi8jBgIEuGOV3
   C0KjyAJDLvXosMNYkGpsinaAivTUBRhoFelm00pzb3UT81P8LuqH5t/Rj
   w==;
X-CSE-ConnectionGUID: Ii6t/4QgT82TIWvg0KG1Mw==
X-CSE-MsgGUID: p6vZeSpSSxG+t50api6UVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54314633"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="54314633"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:56:25 -0700
X-CSE-ConnectionGUID: 085PHLSwRh+ggxWkX9i0SQ==
X-CSE-MsgGUID: oVollMj7T6CbkN3F1ZIOvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="157636022"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:56:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:56:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:56:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:56:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CluTXEkomlYaKWweU1XR1YNr9OtqVS9WZE+94DvwHMeEAYpewaR6HR/jlTTNOwEK5geqIeGcPKbhJ9tRa42Nxo3eomcJzD0pI2CzEWclYrkDa9KlBzdgYC5tjSlXDPGU/PTwdRcAkVMxY6PTnIeuhFZWVp1RpI8j9EGDg8rbTP8UevAooIkusazXaMlQiZoHe9pq30d3ySKAgwG3NY5BYE+COUAHkWqBAjVvqvIqMMzJvuhrSeQUS2YlU/TzY3wm5kjq3l63FqnApnax27pJK6N6oYsLpWevx2cCe2gIPQzIf1/v/RB6F+Uq5hfuoO2ySfKvEE4wdRYUVUrpG/sC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnd+gZZeywpwmpZZ8ilSrx+o4zTYsaUU8foXR3CSSLE=;
 b=t2ldD5akIiJTgvaEO+WEv5Ky0BUi3BDfNKcVkiWebhkailaWYLqVNExfTUK2M504PyDAC2G+v7xX+wW07jmjQ0Ts7S6nDVFSrR2CM3PTRzaSYy/DGXI5E0GxNskLfQgeWtIPNVBsxHzn0q4dPPTz2XBcbZjKYyxIbLiwD+F0xkhhtfuYMe83g6tnyv6eMiGiOtLM7HjIBmUcOe3EV2UVuwvKucqjaQmT1kh7WvQ0d9UzQduGcQa4WEwvXr42VcpBi2LbC7fEtD759cYln7V+eXWQqWIR708RjPjAFx3CeKYx86ldw3opFM/2J84N5UAgT3cRLXoxKevNCNzYuoweNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 18 Jul
 2025 03:55:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:55:52 +0000
Message-ID: <48df72bd-edcd-483f-8ad6-318a40b07f08@intel.com>
Date: Thu, 17 Jul 2025 20:55:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 25/34] fs/resctrl: Add definitions for MBM event
 configuration
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
 <4a08cb0b35f3f7aa759cad20cea0733f9480cb34.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <4a08cb0b35f3f7aa759cad20cea0733f9480cb34.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0335.namprd04.prod.outlook.com
 (2603:10b6:303:8a::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5aae4d-056b-445e-b558-08ddc5aefd71
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVQzSnhCVGEyWHdmZkJKNXpDdzl1ZzhseHRVK2UwaW5FcHR3Y0hOYVJKMkFv?=
 =?utf-8?B?QlZJMzFrWlhYVENuZUVXbTVLYXR0aUxkOG9MM3JPWStrVkpGQkZjcW10Z1ps?=
 =?utf-8?B?R2FWMmNScUV0TG4wM2Q5R0luZVJqU1QvQmU0WE1HR1k1eXcvcDB4OUZOZWUr?=
 =?utf-8?B?K1RvVzZsQnUyekc0OUNFR0RQelQ0Y2ROM2l2dXVZeUxaZm05QnFCdklGZTBE?=
 =?utf-8?B?dnpoU2hYV3Y1c3JxRG9jb3cwdVI5eGZaNWFMMUdFWkVtT2ZCTXpka2tvN1Rj?=
 =?utf-8?B?ai9YemZuU00raU5YaElBbGZMTnk4OEpMdVN1VFJjZHdRVkl1cmY3dUJRUFdB?=
 =?utf-8?B?NzlTbmRJeHdSQlhPbVA4SlJacTZZbzR6NnVqbXZCc3NSbnZ6NEtOR25ESVF3?=
 =?utf-8?B?cXFlSGhPWjQram1ZNC9KNyttVGQ3Z3Yya2toYm9qUFBFdG1kcGtUMWx5WVpG?=
 =?utf-8?B?aGloZjVIU2d1RmJOTTc0TWIrZEhtQkErd1EwbWQ5Wit0bFFCVFEvejRGSEZG?=
 =?utf-8?B?OXpWOGNHOXJhRnAwYTRQS3IzR0FIcjNSdUR0eFJOZjFLWlpzdjNadTRMZy9P?=
 =?utf-8?B?UFBTVnlQb2dXVndSWkhkUVR6NzA5dEVqY2pTUmJMTUpCb0F0N3ZsbG9OTzBx?=
 =?utf-8?B?aWhIVVBOOW1RbzErVStGajc1eHJDK2RiSkZlRSt6T21UY2E4V3U0d1ZnMitU?=
 =?utf-8?B?dXJzeDdubGZXYlBhbXhBaGY0Y1kwRjlJYlBTY3ppeGx5MktLTWozdTN3VHky?=
 =?utf-8?B?MXh5aDh5L2NNZyt3Wm1LZ3hzV3RJUk1ueWFCWnlBL3Jod0Q1ejFZRWtiUCtY?=
 =?utf-8?B?NFJwOVBScTE1dzRsWWxYOGRKT0h1L1AzZk9HRW45TThXUU5DK1UvUFdiZ2Rj?=
 =?utf-8?B?QmlZMHVMeHVQSXIvcFByVlBaTHNpdnFOQXkrS0pGRTVDdzNMdFBWYVNSaWVH?=
 =?utf-8?B?MDd4aDUrdUplekJDdlBNL0RiREhXRG5GdWZKWHN5dXhqRm83U2pWSFRqYkFv?=
 =?utf-8?B?Vk9yZjhhcjU1M0ZWbUhKdE9zZ1ZMSkhaQVNKRjFZY1N4SXRGZ2pXQTBjRW5G?=
 =?utf-8?B?K05VbWFsclRaeTYwbDJPZWpEZzFGMkVFd20rSTVLZFJFMDJlMlliZEh1ZGh0?=
 =?utf-8?B?aUtYaVVuaWM5MlU0VWxGcUpNUEZ0TjBQVGwzaG5Ea2pRYVo0R1RMKzNxaVZN?=
 =?utf-8?B?WmQzQUliYjZPRno2TlljdnM5eXdNcXFpZlZPQlB4RkJLR0t0anVlTUlJU3p5?=
 =?utf-8?B?YS9aRElNY0RRLzA4ejNXVWpiK0NTdDJwYzBRMkYwUmZ1NXkyNWlLWTNERXZZ?=
 =?utf-8?B?VlpZSkR6TC9iMjlkMVN4cmg5VTgzL2VJYUtSSkhwYUlnZGdWQ1BMc1pPWUNj?=
 =?utf-8?B?OTJiYzdyM0NHckphWDBuM2QrMkNLZG1LMGxWd1dxQnhEUWVRQ0xZL29kbDB2?=
 =?utf-8?B?UVNvN0tpa21CdkEzdElzR1dWSE9EVGFTNWx1SjkxSkFST08xQnVid3kyTlF3?=
 =?utf-8?B?WDhUdW1jNTFMNGIwNzBHbStleXhMY0NYcG5XdS9jd05PNW1QSTVFbUpidVRY?=
 =?utf-8?B?ZXFqK3dYVEpvZ0tubzlPNk5tU1lzeFUzRHNId3E2bUhlOUdqWEx5RkVERVB0?=
 =?utf-8?B?UUx1RURyekxtSkR4OWc4cFkyMDUxNUl3Sk5MMXBWU2FHNFo5UEVtdFUzZkQr?=
 =?utf-8?B?Mzc4OU5yT0dCMzdsWm9GVGhTN0x1UU1yQ01Bc3JleGdkMUk1YmpJSVJ5ZGJR?=
 =?utf-8?B?RGpaeDdjdGw5cU5DNXhlMTFFajA2TmdGSkMwNW82YWlVemwvbDlVTFlFaW85?=
 =?utf-8?B?RlNGSUhFenMxOWg4bllrVnNha0xRSENwZFpmMXpNODRnNkdnaFhSVzdmeS9R?=
 =?utf-8?B?MWhEQWRzMithZFBrRitwMEoxcU9nQTdNWWxNT2I4ODg0SVNWeU9HR2RMcTRB?=
 =?utf-8?Q?BuhScsdsemQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5DTmo3TzhrUmpiM3lFOC85V2t6S0xBVDA0NVd1Slk1NERua3cxc0N6OFZo?=
 =?utf-8?B?WjBTaTUwUVJBTzE0REZLUFpLUGVHNGZ4ZDdPUzFCeVQyRHNXYWlRQTMrVVFN?=
 =?utf-8?B?RVdxcjZtOU9TWXNIbzBYaHdkYWdGQWZNNXhKS3QvbXpFdlJSem41aW5nNWxO?=
 =?utf-8?B?bEJYU0ljcXJTN0xaNWd4SHNFamltU1ZxY2cyOVl2MWFWWHM0aWJFKzBXYlk2?=
 =?utf-8?B?ZDY4Z1VSanE1L0NMVlZucVRLZ0h2b0dhZzBJY2hpNy9QYnpiYmxrcFNpTTho?=
 =?utf-8?B?K0Rkblh3ZDRJN2dqZ0pUcXd1T2NQZnRSckhxaXkycUtud0R1Mk1wcEpDUmQz?=
 =?utf-8?B?RkNXMUQzOFZaZ2RicG9lVDdHd3ZTaEhNRnZtV0Y2YzE4MkFGUHdlaXFWZzRE?=
 =?utf-8?B?dEY5enpJV0Y2Sk5pNWRGZDExZ1FZRmZWTzZRRXYzY3FhM0ZKUFJLU0x5OVBP?=
 =?utf-8?B?WENEbUVJakdLVUI4eEZUOFpDdEJpejZUcTI1bzdINlZsQ2w0Z3pWK1NKK1g3?=
 =?utf-8?B?YTQ2SWNmSlRMNjhDelBsVDVMSzJXMHM5QVIxODVzZEg4NWhaZExmVzMyWlZa?=
 =?utf-8?B?bzV3Q0hveVh2bnlJYWhPNC9LcGlGK3VGV2tIa1JLVnJXZ2VzSDFYSVhaajF6?=
 =?utf-8?B?bEZYMy9GN0pXdG9DTlZlZCt2WWh1WVFBU200bEVOZ042ZUtnb1RUNTNWZ1Zq?=
 =?utf-8?B?NlRVbzhmaWJiSC84S0h0VnN6ODJQSjB3WmF1dk93N2VjWTNORUwrU3dTM2FJ?=
 =?utf-8?B?UVNiRUk3d1BHWExnRmFuMkZ4Y01kRzhYREpFY29yS2JtYkFEQmRGTTFsRkgw?=
 =?utf-8?B?UUtOdDNGOUNZbm8xTTlZN3VaMjR5ai9PeFdKMU5MdlJ2WWcxSHZpRkR1L3dM?=
 =?utf-8?B?T0ZVNTVDOTBFd3RIcTc1cTM4Z3N2d1hucUUyemlBby9JbENFYmNGWW04c2hK?=
 =?utf-8?B?U0ErZjQ2NGhDMTNDRzliQnRrQncwZ1d0akRQeWw0MFFRQi9pdHVOVWZ5MG5B?=
 =?utf-8?B?enlEZzBnVENldWNHMERRalA2emZhNnBmdVpLU3lYMkZEd3VGazBhMzN6a0dy?=
 =?utf-8?B?TnluU1ZQWTZYM3l3ZnpoaWJVZzZEZUFRd0tjVWp2eFpFK3puaU04UlhEeUth?=
 =?utf-8?B?R3R6K0R3NGFxUGFKRWljZ1d0allSMENUQkorVVhIWG1UNXJPNFhlL280eStK?=
 =?utf-8?B?U2VFTlNxK2xLVlM3NHVpQ1lOQlB5L2RxSUhxM0duZ21aZ2x5OXpIczUrcGpS?=
 =?utf-8?B?WlEyVzN5NEZhQmNTejJVbVk3MStmcE1jQ0M2MHJ0NVhMZ0tFSXBDSUpNNzhr?=
 =?utf-8?B?R2svMEJob012QkFZaFNtbHJ1YmljbHNMcTJLNmZGYU11L0s0TC9UamRsZG0x?=
 =?utf-8?B?Mjlad0NBNEpnRTVYbXdaaDV1azJjTkVnd2JMdUN1aWVDQzduS2JtcWpDb2FK?=
 =?utf-8?B?di9naTdHamlwUXp2Z0RoeFIzdGZKWG4zZGo3OG1aOFdxVERzSXFnUnFORkFv?=
 =?utf-8?B?U05Uc3BwMkdSdHp1eFk4bk83YkZGTmk1T0todHNSY0M4YlV4R2hISHQyUkJL?=
 =?utf-8?B?NG9ieEQzamJDYUdmTEZoUnZ6UmRnY1VFa3FaV1NPQzdNcGd4aHVHMkFpbnpE?=
 =?utf-8?B?Y1pVVm9vTkZBYjlWZ1AwNnVrNTBGb1BEcS9LRnowNytQTnhhQ0JpZTNTblRN?=
 =?utf-8?B?RDhDUnY4ckIvSWJuallXWWFxb0MvYldlK2w2aEwyaE1ieStoeG01Qmp4aDcv?=
 =?utf-8?B?REFkK3lIWVNmemJ5cUM2b1dCOGRMa3NlaytNb25rWFcrYzEwTVoyellCa3pJ?=
 =?utf-8?B?eFg4SXc4bDdybVV6RjVFZnZnMkVUWGFDdm9kQmwxSzU5cklMVDZZRDBnTmJ2?=
 =?utf-8?B?UDAreTQzcHNidFg0VEJUSXNISnlqaEpXMzZzdjIwWWNTY0hsYnBjdXFOYmE5?=
 =?utf-8?B?QkpuaU5vNFhlekhrR0JFdE5qNnc4VFdKdEUrRkc2UTRpWFJ1RDZaUFN2STl1?=
 =?utf-8?B?d1dPMjRCckpSdi90d3NZc3dsUm5KelQ4Ly9UOWtVYlMxVTFJUTIxejhsNHJi?=
 =?utf-8?B?WWNyc3M3TXlsdENrZlVRQWtmVFRaemNXZnRRSGNOTkw1dzNBMnZSVzNtVVNM?=
 =?utf-8?B?QTdGZkFRYnFMVUQwZjBUZWtoYmFXMWJBVzd4SzY2Sm4yb05qT29XT3h6eGNZ?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5aae4d-056b-445e-b558-08ddc5aefd71
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:55:52.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0kSXSiZ+V+nZ77uBWMMiFwiD7MNqeWGXcB6o0tXsVKBdoTrdDljvdHrEjOzlcLZsbF2nn7a5l3FzgN1eNbCAqy98Mo5rDaMep3/OTeq7wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> The "mbm_event" counter assignment mode allows the user to assign a
> hardware counter to an RMID, event pair and monitor the bandwidth as long
> as it is assigned. The user can specify the memory transaction(s) for the
> counter to track.
> 
> Add the definitions for supported memory transactions (e.g., read, write,
> etc.) the counter can be configured with.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  fs/resctrl/internal.h         | 11 +++++++++++
>  fs/resctrl/monitor.c          | 11 +++++++++++
>  include/linux/resctrl_types.h |  3 +++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index fb4fec4a4cdc..63526400e632 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -216,6 +216,17 @@ struct rdtgroup {
>  	struct pseudo_lock_region	*plr;
>  };
>  
> +/**
> + * struct mbm_transaction - Memory transaction an MBM event can be configured with.
> + * @name:	Name of memory transaction (read, write ...).
> + * @val:	The bit used to represent the memory transaction within an
> + *		event's configuration.

Please include something similar to the mon_evt::evt_cfg kernel-doc to help reader
know where bit values come from. For example, 

    * @val:	The bit (eg. READS_TO_LOCAL_MEM or READS_TO_REMOTE_MEM) used to represent
    *		the memory transaction within an event's configuration.

> + */
> +struct mbm_transaction {
> +	char	name[32];
> +	u32	val;
> +};
> +
>  /* rdtgroup.flags */
>  #define	RDT_DELETED		1
>  
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 35faca7ff3b1..1670163649e7 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -920,6 +920,17 @@ u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id evtid)
>  	return mon_event_all[evtid].evt_cfg;
>  }
>  
> +/* Decoded values for each type of memory transactions */

"transactions" -> "transaction."?

> +struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
> +	{"local_reads", READS_TO_LOCAL_MEM},
> +	{"remote_reads", READS_TO_REMOTE_MEM},
> +	{"local_non_temporal_writes", NON_TEMP_WRITE_TO_LOCAL_MEM},
> +	{"remote_non_temporal_writes", NON_TEMP_WRITE_TO_REMOTE_MEM},
> +	{"local_reads_slow_memory", READS_TO_LOCAL_S_MEM},
> +	{"remote_reads_slow_memory", READS_TO_REMOTE_S_MEM},
> +	{"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
> +};
> +
>  /**
>   * resctrl_mon_resource_init() - Initialise global monitoring structures.
>   *
> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
> index d98351663c2c..acfe07860b34 100644
> --- a/include/linux/resctrl_types.h
> +++ b/include/linux/resctrl_types.h
> @@ -34,6 +34,9 @@
>  /* Max event bits supported */
>  #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>  
> +/* Number of memory transactions that an MBM event can be configured with */
> +#define NUM_MBM_TRANSACTIONS		7
> +
>  /* Event IDs */
>  enum resctrl_event_id {
>  	/* Must match value of first event below */

Reinette

