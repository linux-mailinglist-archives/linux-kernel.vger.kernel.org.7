Return-Path: <linux-kernel+bounces-739979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49BB0CE27
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9813BB152
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA4824676C;
	Mon, 21 Jul 2025 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVYwAaIR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70122459DD;
	Mon, 21 Jul 2025 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140558; cv=fail; b=POTfnpZ6JmFyFvsh2w/P5ZsR0613HxUHQEm3zGRKK8vzn0NDaMWtdPl5jcnz//IevOEZmbwlit18o+xIo+UR0C764E4ZV6BOP2xasYAD34i8/eZUJFyEPVYyERxMGqqCHKSYWdZsI50SWAsuOCEfZL8dtA9TBXg4NvUmpEDIA3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140558; c=relaxed/simple;
	bh=8QfDrUzuV2YvI+R1qAmcsjruUowlyovMY5PC5uPQ+WI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aRsmiCX38f5oL4N3NKTaLWC3YwJJ2xZRYI6kGexwRsNd+1Xl6Tquo6VZLCwPoKXDnl2q2nWicdxot+lzHdbqrcDmKMsT537JTv49iWC4FDLJ2Bsd7supGgjZxMyYBqrZsDjCJSIZhgaGDJJYrv5Dqtd6nS+685k8EKa3k+eINlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVYwAaIR; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753140557; x=1784676557;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8QfDrUzuV2YvI+R1qAmcsjruUowlyovMY5PC5uPQ+WI=;
  b=BVYwAaIR+y9wVcOwCiuhPnmInJ6ck/eYKZNSkjKkJZez4KFC+lHRAsNk
   Ma38kGK1Fd4LWicXRO64yNHMWDyp8KoOlFTKyILQdE3ofsjCq2cxl354G
   CMQ/rL7/TAMAjxK3Eq5wlxsLKJ7/5bCYZfIW9deqCqCAGZRj1dH7uI45O
   qExsMveHZP71QMdkE0EAAbuceZfdqsKXm7/gw31BTkidSGLwBgQBO+DiZ
   kYZQWCBh1ZkHn05ZAqfAFVBUKbJLYzjRHA5Y2R2eOy4Ju7L3e3OAqzalS
   BEs1dmy7DMEYCT/b789bCtv/mfGJkPUaAgX0X0FRla6M4RyfA3MYtv+JA
   g==;
X-CSE-ConnectionGUID: 2WktOZVHTbe9nQcQpooP5w==
X-CSE-MsgGUID: pU85huThQbaRzUlRc9e3HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72827884"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="72827884"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:29:15 -0700
X-CSE-ConnectionGUID: 2bDV+kUuS/+9/zdGBhGLPg==
X-CSE-MsgGUID: ZXG9XKLUT5q+nKi/+Z9VIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="189961785"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:29:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:29:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:29:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.78) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:29:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1oVpVfLH6RaeMs6kobHtORO16lXMbLOXZK4x5mV+wF26c3jvy5ZLZN+gtYNi5k4LhqQTWaGWKc6rplQmJgkvq9irnIlTFBICVynTB81i9Hm/EmI3Yb+422x9lGkEQys39Djz1R+P9cM+tAETsXsS9Z+1qT5iXHsTQ6ypt5i5TtcNNmB6phdY+S/6aAWFL06JF2Ku6KsWcBpTJagvAXJRGdrbTix2izFr0zvHObky9sgpv077uBUt1ub5kATmQKlHoRkDM4/hEVBgM3RI7bkkfDFXJg6GwSBzmWgt1NOmtbSjKXaDEIy31riwJoi4ynl5WTzYWd/MCu4UgaWG3jk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7kj1mebS07Ub5OxaQn6i0TacAJ/lHEPbSxmdMGxgbs=;
 b=ofX4Pr5n7O3sD2lGRFwo/hW7TCG6S9pO/lnr7UohEsIEGfBCFLq9uhOyQI+w74MjXPvH68c4mi5H22105VFjK4eMxfdJUjF6YgzIMe9rATa5Ni5DBEnRk/mxBZuDnUODBayYEn0FqWouuZYiBTQ0GZrMsiP4I/atSQDdz7QXGbD76ZkmoQngWDDyozF5Y6T7fZCyiz2VdRl+lbFo8g76XAdlIfa8KSXu/MzTiJ+XXfD3lkCb5MMnOJeXFWO3LRg1sT3Ygqxissi/zaK4Wur2GHSDBXip0zqnVPeD54DBD8cNGDxKE0XOg6JiZTCJ7ELZ3OAyGA1Q5r4NYZ4DQw087Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7255.namprd11.prod.outlook.com (2603:10b6:8:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:28:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:28:44 +0000
Message-ID: <aa696d1d-2146-40f9-85d4-0f1d153aab81@intel.com>
Date: Mon, 21 Jul 2025 16:28:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/10] x86/cpufeatures: Add support for L3 Smart Data
 Cache Injection Allocation Enforcement
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1752167718.git.babu.moger@amd.com>
 <e1ea4ad34a7ca4bca7fd03b96c961bb59bd43f9f.1752167718.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e1ea4ad34a7ca4bca7fd03b96c961bb59bd43f9f.1752167718.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0344.namprd04.prod.outlook.com
 (2603:10b6:303:8a::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: aff253a8-dc76-47dd-9d46-08ddc8ae557f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm1KK1NwQmxSQnhjQkxhNFVXaU1RSm9Lc2ordWkrNkJsSHBUN0JOTFFxTjla?=
 =?utf-8?B?cXRPYnR3WjBBcFNTVzEycElCRXU3MzZ0SFJ1WWdNRmdSZDI2V1NnWlFrR1Iy?=
 =?utf-8?B?TldMY1E1T2FDbG5jVkVYTUEyZWI3OWtreVlNMFczZDI5VHhuaDlYaHZHL3Jv?=
 =?utf-8?B?K29XTUppOW9DeUhCTmRUUUZxYmpkZUN6Y2hkQ0h0bFI1M2FZQmszaCtSellI?=
 =?utf-8?B?Mi82a3Z2amk3VzVSTFVCbVdHNUNMSWp6dkRvM3RxeWEzWFQwZnBaRGh3MTVG?=
 =?utf-8?B?TUVIOVRFWjAyN1lzKzVVa0VZZE1yS3JMMmhnSHBZcExQV3NNbnZCTlA1bUZo?=
 =?utf-8?B?NTZHM2JWM1FHK1BnMGxpZXFzUFZUQURKeW5TWlpvTWg1NElVaTZzREtsRE9u?=
 =?utf-8?B?ZGt3aHVXVEpYSThCN1I2ZHVTdkxyK1VTWGxVWWhicDdSWGx4V0FrOWYxSUZ5?=
 =?utf-8?B?bCtRRzBFcHJOMU5NOHFudjV6Rnhqb1FGSmN6WXFDazZlcFlERDF0MHVzemtJ?=
 =?utf-8?B?NE4vZ0NRbkpWU1E5RmlvZ3kyTm4xTGU1ZExUSERHVlZ5SEpnbEpXK2ljWCtB?=
 =?utf-8?B?RldEWktFeWE0ZHNyNldnY3poOXhPTHNqOEx2RlgwZVQxVWRad0doSFA4RjB6?=
 =?utf-8?B?aFczeFVqWWFSckFiT3hSOVlGK1dHWm5NYnFEeVdaRENLR3ErZDJpRWhuSlk0?=
 =?utf-8?B?R1Z6elIrTnRjOEJFT2F3VmJJZU1scC9uQ2hFMWxxVS91ZVdhbUpyL1ZQT3kv?=
 =?utf-8?B?TmlLeXc0OVQxeWptelc2eTFpbGR3eldUVXU0QXFNODY5WXNldkRNdkczQWcx?=
 =?utf-8?B?RWJaODI1SnN3VEl3WjBWdmpqN01EdjZUOGF5VW80K3FVY1k2RG9IMTZ5UzNV?=
 =?utf-8?B?MnFkS00vajJ1RmpqOWNHZEFyZFUrTk1RNGdjUXdyNklWYU43SEI0aHpybTc0?=
 =?utf-8?B?eGRGOTBhejBia0krN1pnSnJ1SzNTaXY1WUM0Y0MxakNFdXZOTVBmZFFYZGJm?=
 =?utf-8?B?d25nTVBoc255bVhWQ1NTSTJNdDNLcW52R1Y5TzhWa0VUemUySzRGT3dGbXJE?=
 =?utf-8?B?SEFzNlVjQWptbVVVL2FEc0h2QnZYRFplZ1I5T1NrM0FYWkh5UkhoQ1lTZkF5?=
 =?utf-8?B?THl0Nmx3VVdTZUVqOHpwUHk1eGNma3A3Si9sN0w2UEVnSlJ6UzdGQXIzWTY0?=
 =?utf-8?B?R3lpZm4za0ZRNFdFQVpJSloxT2NFQ3VwdzI0d2kzTjNYMnBpenRJYlhLNkNo?=
 =?utf-8?B?bUE1RytVR2FRQnpHZG9Pb0VCS3hHYzlRZXhCMExpMUpqMExWSk16bnViVW1w?=
 =?utf-8?B?YVdCem1BWlJvL0lMUWpqVFdHcHExRnpCTkxUT0lna3plWlN6WVh2bWZTUUdJ?=
 =?utf-8?B?dTFNN1FTcFJOMzdxeVYyOEE2NEpuT2RJQVRsVG5sOHZDMWI5OUpFa1JqQzYz?=
 =?utf-8?B?Yy9LVVU5cVl3ZlRuWHVYeXQ2YXNZMkVWU3N6NTd5N1VQV0ZydUdTYzlsTWtw?=
 =?utf-8?B?VzdBYU9hMHBGdzRQUExKNHN0bDhjWUtkelUrV2tXVDBocWJtSnRWZ3dwc213?=
 =?utf-8?B?SXFMcEFxRU5QM3N1ZDlKd3FZNnRNeUpocWNMVG94WW1HdVpUN2xBRTgrWURp?=
 =?utf-8?B?SHhMNWpjbXZwTDRoYmszdWh3MzF3Y1RaaGNhajFqVGlPamV6SENHakxVeVln?=
 =?utf-8?B?UlBjbFBzNHp5UkpHRUM1QWxWdVhPcTVzMitJc3Q1aHVXejc5bEZmNEtxckJs?=
 =?utf-8?B?NU4zUEdMVDJsa2tocmZnQmhEVVVIaVdCWk5WV3U4amUwcUpHMFNVWGlLMlFj?=
 =?utf-8?B?ajdxTWxhVjU4R1lpVUpiYUdLUjAzZFRoQXVvZFdaUkpCOHhDNW1rT1lBZ0xh?=
 =?utf-8?B?ZzduTWFldktjSi85Z1laYjlDa0IzZ1dQcEZacjF3dVl0UHV3Sng4cW9FdU42?=
 =?utf-8?Q?U/+VGvquSfk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OElJWmNiRm1mU2FhYnFGSG91N1doUFdEczNMSmdOUFp3YWNWOGExNWZyUXA4?=
 =?utf-8?B?eko2N21VUnB6SzZ6QW1VbkVVNXYxNjFwLzBhcGYzOTZoNGxFeWw4YlFiNDJm?=
 =?utf-8?B?ZW1HWjIxN2Fmcmg0Y0pJbFVnVDNaOHVDcGlPclJNZXJFMFNPb0NkaWxScEF2?=
 =?utf-8?B?OEx4eFVqYXZoTkNMdDVuR29pbDlHb2tBcGlyVURHajlPdGZXcDhINmlDVGxY?=
 =?utf-8?B?d05RMHhTYVp0MXhOclZwQm1uc1MvUHBrQXZiMTNFR0p5bjBuOU5qSWozbUo2?=
 =?utf-8?B?VVp3MzV2Q3JOTW5BRnRiRlk0WVRIQklCWHc5dUhDRFhCNnBIS0NscWdGUGFl?=
 =?utf-8?B?bkdpNCtvdFF3eEg4MUh6WHVtN1hrblVRcVJ5cC8zZVNmNEpleXlZcnhlaWZq?=
 =?utf-8?B?NjlGSXRWSlZpeU9vSlB0dTFPV2h0bWR2d1RyY0lIMUpnMHExdXd4TUcrSTZW?=
 =?utf-8?B?OWVaTDZEMVFYc1VZL1BPcW9ybFVMYlhOVmxneVFqVGFTWm13OW9wT2V3cEJM?=
 =?utf-8?B?L0pJR1d1d0h1Wm5xR3pnN1ZkQXBGc0pHb1VubG5iRjJrQUQwOFRDK2NuNlBq?=
 =?utf-8?B?NDAxSGw2THlWcWpFdDZKalVJTnJweXFZNWpsZ1BmUzlHUjNvUGh0cjBHRTBK?=
 =?utf-8?B?V2lRR3o0cVhGL1ZTdnJvb1d6YnIwNUp0ekFrbGd3RjdUMGFydFJrTnRFY2ho?=
 =?utf-8?B?T0RQTEZ6WldYelMyQU5qUldYZU96NFdwL1g4UWxBTzRlVEtXZE9rdm9ZdnZm?=
 =?utf-8?B?MHY1YXBGMFlLQitBQWc3VmFwK20wUzZpQVU0MDRvY3R4b0tyUUZRVVJjbXQ5?=
 =?utf-8?B?NmM2KzJoT3Vxd1N1cnYwRmdxV01zL3BUcVd4RlBhbGwzc2RzVi93S0VDaEp3?=
 =?utf-8?B?L0ltZUxUc2pxZ2wrbmk2R3M5OU5WSTRPTXlzdGUzaVF0d1IrbDBmZ3BJTlh4?=
 =?utf-8?B?R1FlaitLVkRoUko5TWZqRGZodzVWZkRyOUxVd2ZFbHF6bWticzA1ZzRSNklr?=
 =?utf-8?B?S1krWXBFRnQxaTg4ZmJOVjViNjQ4QldxK1hrdzEzS29Eelp0SG1VS3dqYVB4?=
 =?utf-8?B?K0swV0ltOUlIclFBc3ZRaHBjTGxHVDNkVzJqMS91Rkd0SG1obDI0aU1VN1R3?=
 =?utf-8?B?eEVEMFVoL2d1Vkt6YUNjVnBBK2s3U3h4ZmFZakI1TEQvTGhjSDdXNU03a2Jm?=
 =?utf-8?B?MFg4WmNHSWxYdnpYczBtUnpCdkJyNFdlTXRiVHVMWGp4VW01TUh1aGNrcytU?=
 =?utf-8?B?YlhrSEJuclo2anNPcW9DMHpRU014Z3NwVzJubE9jM21IUnJtL1dkTGQ4N2lB?=
 =?utf-8?B?WGdFb3J0RG1oWjAvdWd0aXVoUkErQTVkT2pDTFBIZ0ppdE94TTFpTTM0TXJE?=
 =?utf-8?B?UHVvdEExRTZLbXQzSnlhdjNIOGw3UXlISU1sdW9DZjJzS3k1b21sSmR5RGd0?=
 =?utf-8?B?OWpNbC9RSjZLRnFkUUMvMEpHZThVVDlyK3lvSzZHOXlRK3dVK3ozaTVac092?=
 =?utf-8?B?OS9rb0RQNDlQVk0yakV1SmZCUU83WnBVaTUxQ3NnNmpFQ1pHVFlvbEd3eVJm?=
 =?utf-8?B?NlNVMUFKUG9qa01mYkNsVWhVcFQ5WWNDSU9FakgxRDY5bmVuTTR1Z0NXaHJy?=
 =?utf-8?B?NHZLQm5vOVhjT1pBdXdEeTk0U3dQL0Jlb0xVZ2lDRVhrQ29EaWZqdEovZVhD?=
 =?utf-8?B?bDhjbzMwM0pvZW5ra2hUS3VoTDNFdy9ud0pJM2JocG13aXdRajV0VjAvZVJv?=
 =?utf-8?B?aGVKL2lWcGhqbWdHOG91UFZ2dWU2SWtWRFBXSVJUcGZhNm53ZG43d0c0aVF6?=
 =?utf-8?B?cWlUZ0JaL1FIaklOZEs0eE56eEFYWGVPYnRGejM1V29GTXYvbnFyRkNtQ2dQ?=
 =?utf-8?B?Wm1wK2NRK0hTUVVkWjVuM3hPNFJWOU9YSEZ2Y3dza1ZwOE1nZG1qNmVyeTNV?=
 =?utf-8?B?eEVPSVFqdHVVUUdFbXpreHFtR3EyVDZrTTIzTGNCejZUcFZoa2R1c3NhbU1s?=
 =?utf-8?B?ZWNYLzNwRTZNZHZpZUpnc2JqYWtwRXlpY2hiVGxjWW8yc0g1b0VkQnE5WG1q?=
 =?utf-8?B?c01TZzBCNTFTdFgwL091M0xNcyszU0RIQlNuOE5WcGgzeDR3ZHE5UzhXaHE3?=
 =?utf-8?B?Vk96YWtHMHdZU2ZrcTlLY1Q2Z0Fjb3lzVjJ1SVNjckw0eU1oK1MwdjJSd05M?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aff253a8-dc76-47dd-9d46-08ddc8ae557f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:28:44.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ms4tllSYq86fi9iS81/p6FYkc5zRdSM/YROdZ7mpHDB9wWz0vkGGhK2o8htMbPGEAh8cXTI8ZiGPQ9hUE4fVvR6OQgQyhzCLdbGiryXmbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7255
X-OriginatorOrg: intel.com

Hi Babu,

On 7/10/25 10:16 AM, Babu Moger wrote:
> Smart Data Cache Injection (SDCI) is a mechanism that enables direct
> insertion of data from I/O devices into the L3 cache. By directly caching
> data from I/O devices rather than first storing the I/O data in DRAM,
> SDCI reduces demands on DRAM bandwidth and reduces latency to the processor
> consuming the I/O data.
> 
> The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software
> to control the portion of the L3 cache used for SDCI.
> 
> When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
> partitions identified by the highest-supported L3_MASK_n register, where n
> is the maximum supported CLOSID.
> 
> Add CPUID feature bit that can be used to configure SDCIAE.
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE)
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

