Return-Path: <linux-kernel+bounces-735849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD86B09464
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572AC5A5352
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67002FEE09;
	Thu, 17 Jul 2025 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KO9lDTRZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969872FE39F;
	Thu, 17 Jul 2025 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778068; cv=fail; b=YasQtwg2mHKul6/U/hCYfweHlnRN4pvgyUbvJdXvNnrgNX+xwBXXOnUWoHu4oOP8mmLiSnPdIRoGPu/h/UAJfzG+4+/HTGRAdNC6p2ndhY/iSOqu1Lqjxw7uHeOG3XTtqkPIuyMkWy/eyxkMVTaaNqjsFL77fnW9KD4M6CZz1Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778068; c=relaxed/simple;
	bh=6tI92Ct9jHy4HgtC59Syy2tTFHm/2irEUdjqXUFUHXY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RDMjoB1Tv7MMiyX5V7hUEBHsvoADPm1+QwS9vGfIHfyz0FxLwT/a9vFx1Ii07iVmKIKzpQS8p8n2odxyku+V3a5fp0rJsBDBeiwoTclUNgwnTavcWXsKLvoCuSJyOjTzTj4tFQu64mSF8DF3M6ma8FSfBKrs18aeJMEHlMofen8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KO9lDTRZ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752778067; x=1784314067;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6tI92Ct9jHy4HgtC59Syy2tTFHm/2irEUdjqXUFUHXY=;
  b=KO9lDTRZhE1n3fAbH0GDoaQ2PkXvAewjCQHNwoHRepqnPCh7gJpDFSol
   IFYttQ2UWLJABXW6lq9k31RUDQ59l5LceW2ZmQfLwEftJP6/AVSooGE28
   /jKKlIRSJzMsGhyo5hd1qUwKmx4L2yYgjy6rFe9LIk4AeYPy3PLRORvTL
   9KHeh04MQyEZsIerUlQXZ3vqx3QVF1/kF5zrH1nQoRIEOc/m7Pprpa5eh
   SD4z2Zq4OVSgjVDxRkz+J9FtofRcplND3xA9s8N3Ar46jrm60sWw2mvAe
   Y8K1QTGGyZqCKrR/wd486ykWMoziPGIT7vDsNrv15155JJkoxC3ZEDO7t
   w==;
X-CSE-ConnectionGUID: 4JHW0dcxRZeA1wFl3FTaDg==
X-CSE-MsgGUID: 9w9FA5y9QAm2JUrJrCC10w==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54946891"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54946891"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:47 -0700
X-CSE-ConnectionGUID: W6cEkSUyQhqDW47oT24Mow==
X-CSE-MsgGUID: ybV2zrPhQYydNHFVnbBdzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="188852645"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:47:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:47:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.58)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Jul 2025 11:47:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpDMIcyH1vw10JwKrZ7rcjQ3rt4kLez9TzbAeGYELhRBLWWIUTpqjUzbMmc852DWtWP1oi3HCnOA2j/T/gMmoIipVQXIWfB2Bd7avq4v5VriHD6POrx14xRqYu5GfySisJNJCuwrlLdtR34bVhqJxewPDegPMJgSlMIyPIVG4aFDVVu78M4EhHea/Q8dCmD4yG5pCGta+gPk/L5EnJDayfV9vm8WBDelq11DhOlKhiMTVn7BgBrxWcV6jttDAcGtdzXd09rMOPXH+vOCleTHcjXK+JtEmtViRIdCoP9rGPbyj5R3vcBy+AHv9n9JkPoARj0iKncazG983+G6BCSy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skkamI0f5+GsZG++U4T4DqxU+xXb/Voc+yl5nED1dIU=;
 b=tcjYmHDncnLqhnP7Ltav/rglzsiwvRZrebbgk+4sUh4Fj/cp7XSDRNlLG9iwZnwTYWNZq9MbfFOS8uFpH+teL206IOMm/615Pa4wwF957hJgGtmEMBc88vsWIXgp+TzGZQjlu3myD/rn2pGDz4Lm4wjHAk6ea1cnOUXMxnIFvK6MU+14rIQfLVNPRPYMhpUJEhJ15dtVWtpezFla60bH8i3UygRtFCQpyynNNhUK7kdjMckJ7egOksmVUuAqUa5bwS1F/7SueFE/jASdEMsJDl6OjKUR9q2bHZGH5U1rl0eWOIY7gPrVvu7Xs+8Py3IhxCP+BFfjj1/xWJAi+3bOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:47:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:47:39 +0000
Message-ID: <b9761907-6c22-40de-96bf-eddf5c4a6b61@intel.com>
Date: Thu, 17 Jul 2025 11:47:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 15/34] fs/resctrl: Introduce event configuration field
 in struct mon_evt
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
 <f87053b76713a05fa4b5459dbd3af6af83d47c49.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f87053b76713a05fa4b5459dbd3af6af83d47c49.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: b56119fd-2c4c-46de-af25-08ddc5626758
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1h2aS9jUkR5b2xyQmVWZ0xvV2N3ZSszcVpBSDh1UmEzMTlZWWhkbHJSQkNJ?=
 =?utf-8?B?SHVSSzRDeitIaFhyakplUHJ1Y29wc1I1K2ZJZTU2VC9GM3dhT1hGZ25CSHAv?=
 =?utf-8?B?elFkNm1wbHpqem5hcXllYit5Zlk2MlNndlVuSkpFeUFEaHRqaXJ5RUhYWWIw?=
 =?utf-8?B?eExHTW5Xc1hZUEpvdmNjNlN6UUxiZ2s0U3ZSSmYvMkFKRVkvb0tkaXdVZTNK?=
 =?utf-8?B?cjVGcWtGaVcvRzU1SHFFNWYvdUlYZkk1YzdOT0RyYjREbll0cERxemgwNVdU?=
 =?utf-8?B?QzM0aFRJbmtkaTh3VXVvK2NwWTFxNmowOWhsSUxnaytqb1J0OVV0OFNYTUFs?=
 =?utf-8?B?UnVsaFYyRnBxN1RZTXZ2aWRnaGlGckZORWNjb2V5dHlzL2dscmxOanRjT2oz?=
 =?utf-8?B?SEYyQXBJcS9pdGpucm9ubzRGZzR0RTQ2eUx2UERDMDFyK2hhdWZ3VkxobjRT?=
 =?utf-8?B?RlRQZ0FzdXRnRytCWUlVQVBiYjdIUVcrRzdZbE1TdC9aWmhaaUdOZHhDMnI1?=
 =?utf-8?B?OGJtWFdSd2JQYzMzMlVNKzJHMmRyME94OEQ4YnBRZzZxaThSWUFDTk9KT25l?=
 =?utf-8?B?ZlQyS3ZNb3dGdHgzRnk0YmhaUzhEWFJjcWxOQmNtOG9YZG5ocW9qUzN3ZjZY?=
 =?utf-8?B?cXY1N1pWRFpCVEZUTVU0YVUxZWFNdW5OZVdGeVJiM1gwcXpYUVJNUm5EREc1?=
 =?utf-8?B?bkpXbU1TM2l2VktQQmt0Rm1VV0M2MVFVZVlDc0luRU56UGN6ODhFZ2IxL2hS?=
 =?utf-8?B?cDJYelQvSDdBSTNQQkFldEs2MEU0M0pHN0REZFprQlk5NkxTeTZTUElxTVhm?=
 =?utf-8?B?UkZETGtVakVncDBDWTluajlaZHJmejBzRXRBZWNkbG5yTzA0K1RjYTF4Sm83?=
 =?utf-8?B?cmVJT3pvQUkrbGZJbGZGaHFCMmpZVTJzYWtDdGtrMFlNaFNKaEdiU2pTYzB5?=
 =?utf-8?B?MldoZlZ6V08yMDFJT2txU1JOVHRPV2JHcjBtNGVleXZ3Z1kwejVtdjJKS1VY?=
 =?utf-8?B?T1ZJRTZvdlk5ZG9iWjFCMWNsL0N0d0R6L1J5UnNoYjFoTFY4YmNoVmFlOUo4?=
 =?utf-8?B?aHk0VGd3bGU5OGg0SW5HTTlLZEk4L2RPc1Y5OWkxSFlqNW5Gc2FmbTg4bXNS?=
 =?utf-8?B?RVRrVW90MnVzRFZkMzIrQXV2U09mYVlLM082cXVwaE9qWEY5clY5cFdXSlZR?=
 =?utf-8?B?U1NOaUxqaWtGWjZJbmxYbnp6K3RYSjJ6azgxeDMzVytETnFoSGRicFhVZlcy?=
 =?utf-8?B?Zmx1RC81WHBMU3UvV240QnFmWldpVXVzSHpod2RhdzhKQUQwb1VvSUplU3VQ?=
 =?utf-8?B?UURGTitwTytlbGVIYXJhV2tEZmQ3N25lUGlleDhSbFdrVVVnWldESERSL2Rw?=
 =?utf-8?B?eUNQekVVY1V6Wk93OFA0TGx3Z0pYdlpMODRqdGlueU5qVkQvdkhmQTVMa0F2?=
 =?utf-8?B?R0R4bDU1Z0FHMVRCY1V3N0dldDlBbHd2VUtwTHVjRmlEVFVsY2o0MGt0Y1Nz?=
 =?utf-8?B?NVF0aEU3ZmZvQXRoYTBkTjYrK0M3TDBEQzhQUHM5U3hySU0rZEFHRUdYN3Zu?=
 =?utf-8?B?MjE4TjdKZ3RRY1Rxc0tuTnJyaUxaSFpWc1prQVhVNTcwQ0lISHlXVHZoRDJ5?=
 =?utf-8?B?UnR3UjVVeWZpaXFyR0R3ZUZuRWNXdmcwdXpqUDVBSTNqT25pSFVnVGdMaHFq?=
 =?utf-8?B?dWp0czJJTVNEMTZxSUVML0gyL1JLTVB2akJnM0VKOEZPSDBjQVVNNngrTFVz?=
 =?utf-8?B?TElBMFFMQU9vM3hMN01UWDNzbUdNSWg0cXNhamJmQ00xbDJydXArelljeEx6?=
 =?utf-8?B?d2NYL0w0N0lsQTUzZGlUM2lzTFVnMDlXUW8yQ0RNekFZU1B2ZVhKRk9LWUli?=
 =?utf-8?B?eWcreGYyNkwwMXpWaWdOUlU0V0FUNmNmYTEwUDBrc2k2dGVKdERIZ21qdE1r?=
 =?utf-8?Q?J9nHew9rru8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhHVHg4QlJhY2lyRmRMTi9jOEQ1U2VJTE1nVWV1QnRYcHJwVzR1SjR6MWNQ?=
 =?utf-8?B?RlY2aExXOFZValM3SGgxamIybnA0N3JYV2FtQXZjWE1Ia2NuL0RRL3VHV0xQ?=
 =?utf-8?B?Rkh2NkJkMHlMTHBOUUNYQ0pnUTBsODhrWE9xQTR5dnBvcThLS2MrWWpvZVNp?=
 =?utf-8?B?WGJjMHUwVE5abFpNaHVSRGlyN3JCTk5SNjhDbi94VWlWOVZuNzVKbjk2TVRJ?=
 =?utf-8?B?ZXJzOS9hMHE2d0NYTTV1Qzd6ZVhtUHQ2MUlCNU1SOGJ1b1pvcTZrcktiT2wx?=
 =?utf-8?B?YzYyV3RWVXdQZjl3WHR5Tk5DWXdUamoxUzFCeTdFQ2FqUEw2TGFhVStuOERG?=
 =?utf-8?B?RDFzN3UzS3IrN0VwczZaWEM0YWNqVXFOSFhBTVpKTXpadGdEamJMM2t5Nm1r?=
 =?utf-8?B?ZGsycGJBSklULy80NVZ1MVVxSXJqUEZ4ZzVQZjhEUmc1dGpFTFFIZjY1K0Jv?=
 =?utf-8?B?WjNIWlk1T3BVYTl1dW1PcVQ1eDRETHFyUiswdEdnZ1d0ZnZKYlEyNitVa2Js?=
 =?utf-8?B?aFNjZXlucE43bURVRGRWVjlHS0hBVWFDdFB2L3E4UnV4aDRYOXJlcWRJQjJS?=
 =?utf-8?B?UDJWcTdIY250cHlYNkNFR2k1ZG5xbzYrajgzSnNmYjRxdUJhNFBTMm9sUC80?=
 =?utf-8?B?RHFvbU1wTTg5QzE5Z0R1Z3Q4YXBBdkdrdUJRZWFrdFVxRGc2RXkrbDlHajJt?=
 =?utf-8?B?V3ZjQXZDWDB4R0MrRUVtNU9kN2JtWFBXaWlIVG1ka2ZYb3ExeXNCTSswQkpz?=
 =?utf-8?B?SVkwQk02ZldmMGpla2d1VGtrQWhyVk9GMnFZK0RMRmdBWkVFVVNORXBVQUpS?=
 =?utf-8?B?MFdDeHZjbEpFL0RNYmhNNWVOdjdQVDNlc1M1UndQTzV5SlZQQlZyc3pzUHMw?=
 =?utf-8?B?MW53Q1R3T0VUYWNlMXpla3hsVzZLVTl1eTlLT1FMREhrajFhNG9iZkwybkNC?=
 =?utf-8?B?QnQ4aUU0VGFmbEJETklaWVpGV1NBMTRmQ1lnRkxWM1hBbGxlTGRqU3RRa2ph?=
 =?utf-8?B?Sk8rUURuUmhjaXY5bklKSEJiZmNxTzVDeEllaXJQcEFTOFNEeVljVVoxMFVR?=
 =?utf-8?B?cmtqS0lTOC9VREZ2b2RzSHViN1ZQQUVOUXdMd2Zra1ZMMDRZY3E1ZDF1aUdR?=
 =?utf-8?B?Wmtwc1BnYVpWZDNNVjA3S1o1UmhaVWxjaEZnQWFtZ29tOEhyQ2lSTXpZUk9u?=
 =?utf-8?B?azdYR2RBOTFBUjZweXJ3ZnBkcEgwVXJrb05XV0xQakkxRE5PZ2xZMU5hcWh1?=
 =?utf-8?B?bE0vUHlNVEI0ZUNRNE1ya0FiWDEzelk2a0NUMGhEb2lGT0RnZVJsZjYveUNW?=
 =?utf-8?B?TkFrVkRCUzlPQk9kcEFFcDhOVTFVK09wSU1lMERsRlNYeDJWWHR0UzJnQVk1?=
 =?utf-8?B?VTRka3J6SGFDQlZqeUZYalhZM2ZYZkp2bjMvdG04WDNZejF4TUROOE9jOGZt?=
 =?utf-8?B?VzhsT1ZRYzF1S1lJNlF0R3NVR0JrNjR5Ukl1eGE2d1pRVnIwWjhKcGhnZkJj?=
 =?utf-8?B?dUx5Qm9sTm9MUjd1VU4xSk1ERkV1eEJTN1phc3QvdTZQTGRVeTlTR0dSMFFm?=
 =?utf-8?B?OWNITlZIWmdocWVTRDU4MFUwTlRlYmM0dFBvUlNCdUQ1ams2VitEblBzYzJC?=
 =?utf-8?B?am1EVDVwL091SnhMR3BxVzhtWVdYM1FXNGlsaEVXaEU0N1AyMU5Rb2pYeTVM?=
 =?utf-8?B?amg5Nm92UVF1OWV0TjN6OWhCMHNzUDluS1JqdzM1LzZIcEJSNG1xRm5kc0dD?=
 =?utf-8?B?REhRZ0ZTNC83QU8yZ3ZLTklxRUc3ZFNwVk5ZMzhDTklrd29STVhINmZibWNn?=
 =?utf-8?B?a0Z0eml2emVXb1dTUFljY1hlRFhRcGl2VFFtNTlmQUtHc0pHdS9PWWZuN1Bz?=
 =?utf-8?B?Si9ZNWVjZkZ4eWJhdy9MN0RKVExhbkFNU3JPSi9MZGgyMnF0alNPUWUrS3RW?=
 =?utf-8?B?d3VhMWtrQnlQem5YTmNoWm9kRzZuVVJBcFRhMjBvYXVCdGZaT0wxS0x6b1RK?=
 =?utf-8?B?WGExMzZSVG51eElZRkFZSU11WU15YmdQcVBaMHhtMzRXUlJaTy9QRUNuS0hF?=
 =?utf-8?B?SGNKZFk5QnJpTmR5dWZZTndUM1k3SDNYSjFtZ0ZSWDREZVE1bkx5RytnSWpw?=
 =?utf-8?B?SXgrSHZtNmhncGhLT2Fhd21xNGtWdDVZSGVqL1lsNW84UFVVejlzZ2V4QWdw?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b56119fd-2c4c-46de-af25-08ddc5626758
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:47:38.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8WjnbdPeze5sUgHkvqumiuNO3sPy7eahBGRiTRvrfzX2yvseRbW41TWHhsHG+fRNBavNnrts05OjJyFZ3oKGwbRAUmrfTpMX6EVxnYNaqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> When supported, mbm_event counter assignment mode allows the user to
> configure events to track specific types of memory transactions.
> 
> Introduce the evt_cfg field in struct mon_evt to define the type of memory
> transactions tracked by a monitoring event. Also add a helper function to
> get the evt_cfg value.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


