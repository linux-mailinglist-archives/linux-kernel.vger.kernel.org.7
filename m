Return-Path: <linux-kernel+bounces-735835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABDCB09449
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4559170BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E9A302044;
	Thu, 17 Jul 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMotcj7v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA627301146;
	Thu, 17 Jul 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777923; cv=fail; b=dZut2r0suVKiiHqlBe/bUyIxShNT+5Q8P7fUtoDlWEETwqz8Q10hMNlO1dQ+UhdFDiDShnlJGuvBp93UEHW8O+pkfgYTjiAl39Sg5v/6AztLz96c9chRdSag8aXpv8z2N8GvLsTDzT6OkktwKoPsPtc3AtpQG+Y46w5sAo2X8aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777923; c=relaxed/simple;
	bh=a3UFIJqelF3lgBRXwxRzTRHR5Nti4mhLwx/tn+vyrok=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AqC0OGgM96p5diBYczCYs1RLtNHxyTVVRpHP5N+f1G0O3vAja3A337LGTwwk8fR+cHC7WzJ2WVBLm2iiXldKrYrbckz6/oUP1P+PVKRDQ9a9+XlahUND5QzNkgw7gU1c9D2NkoArKUDXKcQQu3Y6qHKb3KLv+5+cbHi0tm4IGqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMotcj7v; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777922; x=1784313922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a3UFIJqelF3lgBRXwxRzTRHR5Nti4mhLwx/tn+vyrok=;
  b=RMotcj7vnH3aB2TfRgmFoQ/IuqiouTm6I38KrgV2JkJlcgF7QgsPn32Z
   S+Yh6eca15lf2jA60G2IeLbwoFjNYGjXobjI3odtCBQghTXGJvrn7OCmX
   HabKOBBZHOZTBz9W8AG6JtkBfvP7JXR0Cl9AWOnd4z2pW8mQ2n3yMUlB0
   8YWY6ACQE9QNCAtdAnk1BJNoKiu+IAwx4rYxd1wlTACmmOMBOTZ1K+Fnb
   qF/2CYwn6GgDBGRzHUnxdjcogwKr7nlYbFXeyDRwVbNJLrNLfqb2X5OG2
   gU8FfkbLI5VPybmTisLRrkTIfQzrUHtap0hbf7cAlF/+XguT+gcam5qry
   g==;
X-CSE-ConnectionGUID: XwuUGwWVReeqVafjkoqeSQ==
X-CSE-MsgGUID: LVvRxeYwQuSSaS6+PxMstA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55034012"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55034012"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:45:19 -0700
X-CSE-ConnectionGUID: 4ga0iYqBTnOiv116eKaqoQ==
X-CSE-MsgGUID: 4lTK8AJYSTKudl7VWlpjWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157672100"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:45:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:45:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:45:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.81) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:45:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4zIsDqEWYza6J68brvAtC2cbY8ASrns1NRCGTr8Yr34N1hqCea2v0Bqx9wVGWMng8+Rcj5TWcaZSL7qQ2nzrZBaro178KFVfqSo23IyUOkVQdji2ibSd+WmyR2urNDGwLFMlIvnY7DKha24quQ1R2aBbbOOr3jjtX0tlAkRyts+9P+anl/u/AACahhovby5yLJ1bDvuJwO9nueS8fNg0OtlvonOaLawzOIgxwrFMqpnegJgHH2hWuVeVGsSytjZ5ntVFC3QLsRME6O+5LvB34uNQUc362aPWhuTE9H33ow7dFhaiB3NMpR/EEVpBCqDSFNaMdxkpJI6+u/XMTEadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3UFIJqelF3lgBRXwxRzTRHR5Nti4mhLwx/tn+vyrok=;
 b=fqsjnXTWKvovY5NX4530d1IK1DfZzNPAIvfWyZ99okX2UUkmmQoEDVc8aWvFyl0DgImNaksEyGlpfbEikWICpPaZGJ/vQZmzKuAXpqFFGFrT9Iu+k7sWDYXU5lKor6sDkOda1f8ffZNj5d8p6BSS8tIcJlmghVQJ6VRgE6lDMH3ktXQMICFXWWu0QzttfQw755FcTLvoA+x5QRec9i6dJY/tzf5tG/qqx9r57K9JJxt/es3mR/S3HQZwBKTVs2TavHM/r7DPRRXmoR6NgpeKmThJ0Z2Wjg+KL5Cdjkqr6Hz56TMsIpR/3PJ5Fywm8ayWNHuvhTetpIebbOK/lG0/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS4PPFC77662F02.namprd11.prod.outlook.com (2603:10b6:f:fc02::4c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:44:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:44:03 +0000
Message-ID: <9f7c1746-cbfb-48ec-ae34-155be9644fba@intel.com>
Date: Thu, 17 Jul 2025 11:43:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/34] x86,fs/resctrl: Consolidate monitor event
 descriptions
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
 <7d999eb2e9435282339b1e6b39cfc5347664eadf.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <7d999eb2e9435282339b1e6b39cfc5347664eadf.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS4PPFC77662F02:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc441a3-ff24-45f6-48d7-08ddc561e6bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWZLdWFzVy84emVBWGxtUVl2OC85eDNZQWdtYSthNXBubkZUSTlpSnZIdmx1?=
 =?utf-8?B?dENqTkhIQzRqdE52Vk9iQzgvNjBSalFsQjVib3hMVTBBNXZ3Z0xHZ3o5TVZI?=
 =?utf-8?B?dUZoMGloMXI0Qjd6Ujl0N2Q5c1NWRjBqbzZZWWwrcWJZUFhBajZHcnIyM1JN?=
 =?utf-8?B?T2Zqd0U1ZFArQ3NDYlNKQVloQndnWW9XYTl0alZMRG1ETTFjRGdhblRXVGpM?=
 =?utf-8?B?SmE5dmNJTmpFOWdrSU5QTXBJU1QzeUNDSlhJZnV2VEV1ckk3SXBzaWt6TzZN?=
 =?utf-8?B?L2ozVVdVUTNyMlh4c0lsOG8zV05TTFNrdldSd3EzSmhDZXByclF4emI3YXIy?=
 =?utf-8?B?anBDZHd4OTZNZU9HelZTRVRCMFpKR2ZrbnpTR2I0SGlzTXA4QnRoZkFSUStV?=
 =?utf-8?B?YmRVaVJrZjlwc0J1c2xmd2p2UGFLQlV1dDA5WjdyZkhHckRhaTJKcFo1MVI4?=
 =?utf-8?B?MlpoL0tQWi9aSVhnQklJckhnWlY1UXRVTzZ5emJHb2diZnJyQnJJeTFyc0lo?=
 =?utf-8?B?bDNMcWVpdjdEK3VQMWlIRWxSVkNqczkzYTdWRXg0QXhRNEI0bWxTRWxhRVk2?=
 =?utf-8?B?ZGo1dyt3eGlmN2lEMkc5aVJvT0o0Z1o3L2tBZ2x4RGxyNzduM0dSVUhKWWRs?=
 =?utf-8?B?NGhZYUVaaHZONVRvTHNnMEhwOVpUV0ZoekNzSUZhMktsQTJIUFRWS1lPQzdU?=
 =?utf-8?B?dzVVNDVRdlBKRC9iUjB6RUJ3ZDN6ZUpReWZQWGkyZ2pIaW5STE9Wdk1Qa0Jm?=
 =?utf-8?B?ak44MUZKYjlmUnREcFUvVDBmV2h1MHNHaGtyWS9tK1VNNy9MMFNkREJBT1FW?=
 =?utf-8?B?YjNuRWJERnR1TUZWWWdURTllU2FTQ1l4ZUhPU2JidTAwaW84WUFDY2lxQzNF?=
 =?utf-8?B?cktXUjlOV2FQM2dUVWFCekhrLzR1dUFhNWY4SjNVWUpKSUNrZWtvZ3E0eHk4?=
 =?utf-8?B?V20zZGJDL2hGdERMYnFCRXI2dDNRMndBOFNvSk10dmRUamNjbDhYVko2Qi9h?=
 =?utf-8?B?MTRPMTB4ODVYMjJPNEliMTVoNkFiaEtaMlp4bStiTFN2ZEtuY2pUZGdqbTNG?=
 =?utf-8?B?ak9VaDJ4cFlaRE10dVhKVmhhdHJ1Tno0MTRtVjlHVnFVeEZKL0ExRTlLSjA0?=
 =?utf-8?B?TWYyNDB6cUdOcTdHTzVXZFQ3cGxZNThtMHB4NnNoajJhQ24ya2hsOHJkTU9G?=
 =?utf-8?B?OWw0NGZNTXFBYktjU003NnNHYUhCUHczS0d3cC9KeHVDUngxMjFab1ZGU0E2?=
 =?utf-8?B?MnlwRTh5c04zTE9rL0Y0ZHNMaVorZlBncW5BRkI5T1grZjRyOTdPaml4UXpJ?=
 =?utf-8?B?RWtEYmtUT0ZTRE5sWGdhbG1kQVBTTTVtQ1lvUmVhQzhHaytHZi9EL0syVmRP?=
 =?utf-8?B?bHdhNFdndkYwSEU4SEMveFhmN29GUUdMRlI4Ykoyb1BmVHR3N2FheGhxWHdY?=
 =?utf-8?B?T0FBR2MxTjFuQlc0MCs2QkZvU211ZkluOEhXMTRweTA5b3BVYTFYbWJHWXhu?=
 =?utf-8?B?OG8xTld1amlFNFp6aWJUcUR1eWQ2T29ndjVpY2xIZ1I3dnJnQlZNeTBZUG5Q?=
 =?utf-8?B?eE45eEtNMjJEYXNFREFCY1Nkc3Z0MEpNNlhxdzJsQ2YzWTFMUCtJNHZDS21C?=
 =?utf-8?B?V3EzbEtlaWE4VTI3UXBqb0xCKzVDeEg2L0ozT3AvZG1XSlNZeWhDeW40WEgv?=
 =?utf-8?B?MHRpcXJhUU42RzlOcG9odmV3NkMza2xxWE1pc2Y4SjBwQ3RrdGNxSE1SbmQ5?=
 =?utf-8?B?TDhabHB0ai9RdE03SUU5VGVsbHkxT2J4TUUvNGVJZzVLZ0JqeTVJZENQMHFr?=
 =?utf-8?B?OVY0MlFNaHVnSSs3am92RklEekpiVkhDa2tsaGhFUWp0LzE3bXNwWm5oei9P?=
 =?utf-8?B?V3N5TVd5OEc3YVRRQis1Yjlwcmh5T3VkTnZWZlc3OHh4SGZJK1lVd0FPbGp6?=
 =?utf-8?Q?5TGoCOfQrQ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlNnREwxWC92SHRQSTJpY2V4MkU4eVUzcDFSdjM1L1pUWm9hMjNoUWJpZERh?=
 =?utf-8?B?Rkg5U0NnaUtiVXZ6OVA0T1cxV204OHhYaEdPd3NBaU01YXkvalZCMlJkUEhz?=
 =?utf-8?B?ekNuMnVrM1VxaVA3NWliKy9adUt6WWhUNEU2VU9UbFFIbjdsNytEd01YNHJO?=
 =?utf-8?B?TWNJdXN5bGt1MmtsSCtuNTNXMytNN1Mza3Y0cGpRSjRuQmZjNy9RUGo1a2Zl?=
 =?utf-8?B?V0UrRXhTVDBEYjVweSszRVZlMXQ2Si9LZXpKeEpDc3YzYUk1M2JodlZCZnov?=
 =?utf-8?B?bkl4aUVSOFJuSHNuYlFvNkZ2OCs1UkcyVW5DRDVyM1dTV0FQcG1jb05zcUkx?=
 =?utf-8?B?MmVtQ3l4N3MzNGE3NkVwVmtlcnJldnRCRTVWdkNKblE5SCt1NURSRmR2SWNs?=
 =?utf-8?B?aGN6aUpaU1k3dEdsL21RRlVWV1FmWFBHK1M5bEpxb1I3cFVNdnMyemF5UWJF?=
 =?utf-8?B?a2FMaE5GdjllVWwxSURaVlRNWDVUNjBoeHpjNkw5ckNNYTFycUxURTJ6WFdX?=
 =?utf-8?B?clhZMTRaRUdlNW1FRDZ0M0xwZ1lpaFQrWGdGNkNLL0ZaOUhscUk0elBtSkVz?=
 =?utf-8?B?TGsxQm02Q3VxeHdoSyt4L0xjZUlrZXV2ZzhkNGk3a1dwbVpVU3RmcG8xYTRa?=
 =?utf-8?B?NkQyZlcvNTQwSUQvQ0gyQUx6cGJtNlhiUjVSMk1OTk9ZM3hlZTBaN3ZBLzRW?=
 =?utf-8?B?aXFDUWpvVmlyYXVmeHRhYVpYbWhKdUFwMGRqdWlWaHlLMHZ0KytFL2NoQWJQ?=
 =?utf-8?B?eEpidHBrWlBlZUZhN2ZxNlZPL243eUdmeU04cTkxamYydzcrU09hYll3dVZ2?=
 =?utf-8?B?TDZOVWo1SGd1eEJEYjVhTWxFK21IZTcrMm1tbGxvQVJDR29uZVUwWEpnMzZi?=
 =?utf-8?B?akUwYlFEMTlJeUhkWDZGeG9UcnpkZkxWb0Y1dUxTUGprckpWU0hma2dKYytX?=
 =?utf-8?B?N3BFWnBjL1A0bEc4VkU0akZydWJ4SnFRS2o5ek82eWwzeHpFSG1xY0htbW00?=
 =?utf-8?B?SmYvays4ditieEtReENxcGF2MEF6TXdVYjFUQThNVjUweCtmNTJwUWRJczFU?=
 =?utf-8?B?Qm16ODVBN0hUVkluU1YwejJvZ3B2SEVpVmVGZjBTZDBQN3IwaTV4b3dtVHBp?=
 =?utf-8?B?bTdrZVhjRWNGYndmV2tab2IrTXJybzhQajlQQUpvNnoyVHpiZlZyc0NxeWRO?=
 =?utf-8?B?eWFEclMzWFIvUnlHQitoT2dqbzdCUXNIbDI1UWdUQnZhektMbmw2N3B1UU9r?=
 =?utf-8?B?Yk1DU1dWK0lEc0ZDa1FQVEljU3FHQ0U1TU9BbEgxd2kxbHA5dEpVY0F2aTRu?=
 =?utf-8?B?VEl2eU5iYVArT2lPMmF4Rm5uNTI0dXVmTnJjMm5DZ3ZGTEpGUkNlcFNseDUz?=
 =?utf-8?B?aGpIOWhtVW5TQ0pMQ2xGaG8zV3dna0hHUE90K0tYNE11RUR4bmM1SmV3OUM3?=
 =?utf-8?B?WWFGanBudGtCVEZSVThTMWFtUWJ6bUpJdU96R2xxYjF4YjgwOEk0RWZVSk1p?=
 =?utf-8?B?elIxQUw2M3E4L00xT0RKRnJ0cjRoVnd5REJLcE4yYUlxU2tZVGFFZGJZTjVB?=
 =?utf-8?B?R0hTaEdobHhWSFlhWC9CdXh3NmhrdVd6a0ZGdVRWakExaG9FbnNpZTYxTWg0?=
 =?utf-8?B?dXhxUWpTVWZ0azdtUGR2SUN1YXlLT0xXMXVMcG9oNExiM2VmTWF1bnVpTGVy?=
 =?utf-8?B?am5mNldhYlhJcmdYZWVxaEJaS3NTZ3RYd2NXUmVxMWFLSzh6cW1qWm4xWFBr?=
 =?utf-8?B?aEI2cVdSYXRLTWcycGFIN3Y5dDN6cEx6NTJIeW8rRkRoWG9zNkM5c25Jblor?=
 =?utf-8?B?bVF3Mm9jczJPWkpxbjh1MWdkY1o3dEhpT1d2R1ZlV2VWY1VLbEtVRlkzMWlr?=
 =?utf-8?B?YUJuTk9BaHhFeGVtWGpyV1dZV2FYb29tcHVVT0gvcktNSDNqcEtST2s2WnNQ?=
 =?utf-8?B?SGVCQ25hYTNHWWNKNnhHRElVRWVxKyt0L0c1NUIyZVJGLzNLenFwdlhlSVpz?=
 =?utf-8?B?ajNMbEpZSW90cUhlMi8xazNaVHlkNmwxOTlHVE9tbW1PZ0VaZHN1bVo1V3F6?=
 =?utf-8?B?MFJzT2pNRzRBTERCbFk0UllGbU1pQmkvNy9jTDVPa0x3bjBLcHVmM2ZwQlZh?=
 =?utf-8?B?SXpLS1dETnJPU0VOTXJtNzBFRWJoWEVmZEduYUc1NGpETm9XeDIraGVQc28v?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc441a3-ff24-45f6-48d7-08ddc561e6bd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:44:03.1563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfngf6MVPCUdQEi5pHzbsFIT2TwA70rk7gibgQ4JDjKETVoEvjZmviM2VskY4bb9vl8eTOch8w5H+NPKdIJxsVb/7zJQygQmx2saRD1r+pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC77662F02
X-OriginatorOrg: intel.com

Hi Babu,

Could you please replace the first four patches by most
recent available from Tony [1] that have a couple of RB tags?

Thank you

Reinette

[1] https://lore.kernel.org/lkml/20250711235341.113933-1-tony.luck@intel.com/


