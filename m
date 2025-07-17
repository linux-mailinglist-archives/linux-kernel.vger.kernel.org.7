Return-Path: <linux-kernel+bounces-735836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFFCB0944A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CC01C481DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E59302063;
	Thu, 17 Jul 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIfbBjIs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5AE213E89;
	Thu, 17 Jul 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777924; cv=fail; b=nEUbwl8ZUlSlHsm2teRMcZchpUW5XjK/Ht/mBQfceoSfGd4v0mkD5h20SctUO9Ze931JZ9ZAXN1V76Nx0oIiJsJaiNtcUHgVMtPF/cUS+xkkMz6CTZs8hilKj1pitOmv8slM/7kap8fQ+PZeN/dyfJLJ5MgWC7Sk0bvSNBB+fp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777924; c=relaxed/simple;
	bh=H73szXXCyvowu5wY6ynRN2FL3jbJPi+5cKQACOOHcFs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H5HBStyt99nEGP8hQB/5kJpRaxcmQAgnGaPQUB8gNV4YhXhTbGvHhxBLiDfsOfB93B5znKWHYRo21L048+g+GB3TVoaJSMXdzS5qqcQdw4TRIw9MYWQCHg3Nw7k/C5hY//nBNC8q/nQvwhWUP2aijAYBZbv3ehMpqIKLmn5ltiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIfbBjIs; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777923; x=1784313923;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H73szXXCyvowu5wY6ynRN2FL3jbJPi+5cKQACOOHcFs=;
  b=AIfbBjIsS3MT8G5qd8vClimLi4ArqoTLL48W/Gt6AFNSsnq0l5ZRPGue
   HKUmvZn1ymKV3rDh6UvcE5ZoWNenFHuguVDHASot/0YKhFt/PUfUf0UQQ
   A33+Le57yj/A0zjGEYHmhubWpDsIBRPzFUv/yE++xT2+DIhGy06PReUpH
   KtYxf4fKnLVgUDrDB+PCQ9oV5omgGXJQMgjK733PRRjp25pOjc4KG6nv/
   5ANOv/BKXGPtAbe6yoMSN2h8A4DzncE0UB8KhjRnfFoXW/icDa86TOYLz
   HA8Vn7ienL7Tc8VQCUNRHN+shMhRPhStWBF+fOVbXk/Hg9qXxz1j4LFmF
   g==;
X-CSE-ConnectionGUID: hJ7XCgHyQviWz7l5oG2ZdA==
X-CSE-MsgGUID: 4Gd6rZtbSA+wtulwUWYs7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55192015"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55192015"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:45:20 -0700
X-CSE-ConnectionGUID: dsJsr5NWRxSlKULGhtHzDg==
X-CSE-MsgGUID: D8Wp4LkdRTKPW0O/HQ5G+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158440476"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:45:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:45:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:45:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:45:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9lJJglQAvrJlA1lHFPKjNb6N6hHZAkHFybw/ddJ6SdjFHzO6zo2PCqeUFKW/FNh+M0WMoTNNp2oPRJLRUSUm4LK3yk+KCVkkcHIfVFKpbh3+Iu7lnNQMcs4XL5zDwgCKscJ6SmV5RyhT2072czPyLl25w1E2FxQcWLX3VCTl3PpZEIxIA7ddTsEehcANZUyeWBtilKPqYmWeg0Fbyta78zuiNasDyfcIRlnd0BqOZvJI8PCXi6TiIk0Vsk8BzUudCFLHO4IGl35jz0nsJasr4caMelibKF8yvinxZD58oIByQ5O+MFzQhF5gLUP9GWSCPzC4hQXPgqYr9TLuifuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhfmphOcoTk7z0GPwltuAKkoyMFY90ts9pTGf+l36yo=;
 b=LBTA/Jy5FU7iITnaZ2wajbVLiJnlR19JZ4Dwbm6CSaDHLqqtRKXs2FjObjMGlxCO4BTxteW/4JVOpHq/+/Orn3G31rY0EhvDAWj6GNKJpaHHCouFiKs1aArcHb4qN5u9gU5HWVgmzikMLSy1UdK+rhtrVtVYRq538GxgW97BO1pf3ZxbUdFTy3r0rQZpzEMut+l4eftDFr95Wojcmk2RNxVAMkHi5OxtKIFZCREWp5PDDZOPvrGMjS9hO+f17CfPE4vEhfPqzY8XmNJV0Zo0Os8g3bOmVUZ1ZyOpdn8QJtnOoxNmig7RU6VSEPiVeEcwfYno3RxPVjre8r5WZhQBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH8PR11MB9507.namprd11.prod.outlook.com (2603:10b6:610:2bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Thu, 17 Jul
 2025 18:44:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:44:26 +0000
Message-ID: <5c96741c-25ad-4c4f-bcba-b5905d7bf200@intel.com>
Date: Thu, 17 Jul 2025 11:44:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 06/34] x86/resctrl: Add ABMC feature in the command
 line options
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
 <00cd603997e3ee6a389f83aef066fe7313b1abaf.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <00cd603997e3ee6a389f83aef066fe7313b1abaf.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:907::16)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH8PR11MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a04b6f0-efb5-47a7-cecd-08ddc561f4b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE9hMWpaRVd0WWwzL1pBTHU0WHQvZ1dvMkxGeEV1bm85dStENUw2UVJoZzNr?=
 =?utf-8?B?NldqNG4wTW9VZDNCbWVRaElNbHBYTUVoY2NQcjNxUWpFazYxb25NR1FwOGdn?=
 =?utf-8?B?ems5NmtZd3dkVEp3THRPMzRuRUlCVDd5VmtkRjJlcGNBQTAzOUM5NU5SMTJm?=
 =?utf-8?B?NGkxbUhyN1k2ZlBFR0FNbEpVNzIwYWtPUEVxVi9XLzJIVmJmWVpYRVoyOHRS?=
 =?utf-8?B?SVlQMFBlTllNenJwNHZMeHY1dzVzenAzTnJQWU1oWSt6U2prSDJEZUNWc3FX?=
 =?utf-8?B?aWtBaVgzc0NCZGxERUdrWnBSTTg4V0hkR1ZYVUl2MHE3dm5iSjdvZ3p2OHVC?=
 =?utf-8?B?WUdyQ3JhS2kzREhabWhMQkt0U1ZHdkNUTTAyOFVBcDNlalk0TmFqdnlYR2NC?=
 =?utf-8?B?VVZCcjUvUWJ2aUhqei9WR1lPLytqS08yajZLWEZCb0pkMklxZkIveDd2RDZu?=
 =?utf-8?B?MFl1OHlHc1V5QlJDOUs0VXozS1BMQU9LN1ZlUEU1KzBHdWZmRTlIZXJGWFc5?=
 =?utf-8?B?bkNsZDJWdXh2RnNmaUl3cDEwdHI2Y0x4bTZSeVozT1JwTjdDbzhrYWhOb0g2?=
 =?utf-8?B?QU5mb1kxV0tITEJsZTRsaVB3U3ZDRWpFbk9scTJ1RERMYi9CSk0zZkpmZUVn?=
 =?utf-8?B?QXJEWEhwT3ZUdFFHR3cwZ2lwNTNCTVFYNTVySnlZZy80ODh4MUdqT0tDSW9w?=
 =?utf-8?B?V0ZzOWZIZXpBY2c0ZW92MnNlTnlaWUR4QXRYYUQvMS9PdGpVbnhDQ09ya1Jy?=
 =?utf-8?B?UXVpdGdMU2MwaGRLWm1yUzdvTUtHSlprMU84OGIycnVPQkdKRXRJWEZKNkd2?=
 =?utf-8?B?OFlKVGE0NC84YmFKUFVUM0kxK3U3bFZlTmwxOUlKVUhuUGJiSDBTdGpjVDFI?=
 =?utf-8?B?OXVrSG1rTmxTbHRwWllYSEZ2OVM5empjRnlIdzhzL2lnMFNDZnNucm1vaUVh?=
 =?utf-8?B?WGRHUTFGSzlsWnZnQzdBMzJaSTR2Ti80Wjh2QmJVRnFnemovRGd4RTk4aW9U?=
 =?utf-8?B?bEJtOWc3M0xNeFNVOHBJRm9KT3NUKzg5QXg5YkVqYkgvUmZtK2FSVTNYRVNk?=
 =?utf-8?B?ZWpLM0Uzb2h6RE52UDVVNHdYaWZiVGUrN1N2OHpMSk9XMVpDeisrbkxyVEUy?=
 =?utf-8?B?T2ZscDkwTDZwTEw4c2xrNXJKckFXM2ZFU2taQWVEcHB1M1NZbDBUdXNQVE1E?=
 =?utf-8?B?R0szalhaWmhKdksxeU1kZmxwYW9TZVFpSVpRekNuTE50VDZteWhoYUFBd0dG?=
 =?utf-8?B?NGY3UEhLRUhzN3p0QnFVVEpuSnk3eWdCbC9LTVphQWozNWVjYzlIbmRDa1ZN?=
 =?utf-8?B?NlJ3bER2VHRQSUsxK3FzUGtQUEp6R2dHNmNQMHF1UmVtL1NnRVhVK1dKQUJw?=
 =?utf-8?B?aFV1Z3NCSUFFOGxSeVdSL2pqa2IyU0wvQXorMGpIbGJhY3l3QlE4Q1ZobEo0?=
 =?utf-8?B?TmFodWZQeWRTMGlGYjVrSEV6clNsZ2VjZ3Y4WHMySlRxbXpBSFdyelN0eFpT?=
 =?utf-8?B?NzBWdjduaEdjVUNnc1dVcHp4R25PeW1wSGpFa1FxakFlV1FHNm5URzlFSlBD?=
 =?utf-8?B?UXE2US9TcHYrb05UVVlINUN6eUI2RG53WmpiOGRGMUJGYzVpOFN3T01FRzF3?=
 =?utf-8?B?MU40TjhxcGgrQkRjaGFMYlZpN0d0NC9PTVI3K0xaQkh3M25kYU1vUEx3R1hO?=
 =?utf-8?B?a2ZhMldNNkNJVEJ0K1dCdndqS0pMNnZUZGlHZXRaN2dVaUxCb2x4Vmk3QTY4?=
 =?utf-8?B?VHVvcVF1NG1SeU9qZVV4Q2NjMzNKdVpETTYvenQ5TmhwekxqbkQwYzU0MlFh?=
 =?utf-8?B?SmlpdXhtVkVrMFlOQSt1dVRGaGtHRGMrWnppbzVqVk1VR1lDRExoblRJU3JJ?=
 =?utf-8?B?ZjhBSXpGVUw5UGpJanpFWTJBVG44WTJiWWJGU3h0dVBZcXh2WmdMNjMyVC8v?=
 =?utf-8?Q?GDRN9v7j/rs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHhUMGs1b1FnRENRL2ZaS09ZY3krQnRBWE1IdmZKNlpKcFNGajJmenZKSGU5?=
 =?utf-8?B?RERIZFpHc2VTUmpOUWNWWHdITnQvVTVERWVnOEVNOVFwek9SMjZBbXp0YTFP?=
 =?utf-8?B?UC9OVzN1Ym9vY3BlSUJzbTY2eWYvdUV1emZLV3lKNitQKy9qeFEvSktRNTVQ?=
 =?utf-8?B?NHFtOWdkanNiYjBWUnovV05zN1FmRitvT3RQY1JSMHlkSExtOU5QbndSMFd6?=
 =?utf-8?B?OXFXMXArQlQzVUNaU2ZIVjJYL2JhenBsKzJJTWhhNFlKWjN2Y05ZT21EMHF4?=
 =?utf-8?B?RDFlUWVpbml6UG5QWktxN1o5Q2pZN1VpMDE2V0VFZ1M5VkFLNytJL0xqTVgz?=
 =?utf-8?B?S2FXdVZvekp1WkMvaThobjBJdkRGL2lwMnpUd05EYVpTbGxGb0s1S2Rpc3RI?=
 =?utf-8?B?UWE1RzZvSFcwZXRtQkV3Q1hvUSswdUdySDdpamlDOG1LY2YwOFdwM1NDWGNN?=
 =?utf-8?B?MG12TDBKUXVkWVNibjFDbzZVUUVnUXhZT1FmaFdFQy9maTNsU2VORXFIcU02?=
 =?utf-8?B?TnlZUmhnRXhOcjVZL2tRVFJWVU9pLzBpK1UyQ3liak1FVHo2cEZYU0tDQm1T?=
 =?utf-8?B?ZjJYYTg4NEJhMVRzY2U1R0MySC9IYXN3eE8vUm5NYW5uY2dlY2xqUTc3OFBj?=
 =?utf-8?B?T0dJTW1KUnllcHRnaUdSbm1kREpHbnJGdFJpa0JIbVRyenhmRGhrU2VZMndr?=
 =?utf-8?B?UUFBZUJ6cmVJQTNEOWt0TGNxT0ttTHpUUXFJMFlTbnF6ckxVanR4WEZlZ3hy?=
 =?utf-8?B?RG1hVzNZK0kvd1Y5UWJaVU8va1hqdjlTTnpld2lYY29vQ1pvYk5JOEhqTzlv?=
 =?utf-8?B?MEYrTU43ek1QSElEQ3FHUXFyNzIzRVQ1VWlBMjJHVnhFVkVZazhZYXl1YUlh?=
 =?utf-8?B?bThXUTFpVEFyOUxxTzFMeDJiNStzK3QxNlNja25UVk1OZ2dkMHJEMHl5R1ds?=
 =?utf-8?B?ajMvUFdocEtqVDZ5UlkwU3IxVEo1VTRuSWpsbVREYWRqNWhTTmtxQUtDaGM0?=
 =?utf-8?B?Q1BCS24wYkFOMmVTM2VZS1J6dU1IRTViOGdWRFNaUURRbER3VjNLc1BxVnVi?=
 =?utf-8?B?b0lRbFR6QzlQSmZaaDFzdmdBcXBZR0V4eGl5VVZoMDFJOC9UUncvbWFTMUpn?=
 =?utf-8?B?TkIwSytZTFZxN0o4bXp6MG5YWUk0QjkzYjBlRzBvcjNuTzkwK0VZdk90QW8z?=
 =?utf-8?B?bktRN09uMU9PQklNaVlWQ0JJU0s5M1dCS05aVGluamplb1pNQ00zT2QwejJX?=
 =?utf-8?B?L0JBU1IvU0FaRklucDlWdnZtOG5sSlpia1hPazVlR2kxVWNKcDZCMjdiSWc5?=
 =?utf-8?B?cFdsbk1DQ1grb3VDTXJPT3pkUy9QOGRvTnBFUHRrUkJINmRrNGlqZG5WaEtj?=
 =?utf-8?B?U1dpRk9aaGFtTWlpT21MUjI4MEVETStrd1ovRXRLQVRiL1kydTNuYUMwL2Jo?=
 =?utf-8?B?a0NVNFRXa0N5VDVLL0o5VXBJMm9hdmttQUEwbnI1Mm0zelZtTlRPNHBzNHF1?=
 =?utf-8?B?LzZZYk9taWd6MzBYYUE0MzB2Si9PaVNqTld1a3FncXZITUZOWmhHa2VZZmJ5?=
 =?utf-8?B?Rm1rVVZnK3E2SVJNQjNFWlZsTmQ3UjUybTVQaWpKN0hLWEZDRWdwZE9qR2wy?=
 =?utf-8?B?dWJleVFZRGFDbklON3U4THVVTnc3VEVSaTRWL1pOZWNkL01HMUV6VzZFblVv?=
 =?utf-8?B?QWhRWURwbzZ1TjVtamNYancwd2Z1Yk1TNktpNjgxSkliOXJ1dnVKUGZNQVZV?=
 =?utf-8?B?cXoyQzVsTE5OT1paQnB4SHVTUzgzK24xU0RtQkdEWWNoamdzU2o5ZldqRlNj?=
 =?utf-8?B?UDVqQmZtSjVLS3pTQmxSN1I2Vm9XaUJPQzI2OUVGeEV1QjV6QjZYdk9YNnZO?=
 =?utf-8?B?SXdnM09NYXZsUVViQmlVWHJWTlBTZENLVDVROW1lRjdsZktYajUwb1hBSkox?=
 =?utf-8?B?YlJ3YU03dFlnQ2JPR1o1bTJiMisxS1c3Rms5SjUva0hnb1h2bUZDbmdYUS9Z?=
 =?utf-8?B?Sm92SEZMN29SK1VjWWZvT0FZR25GZ3B2d0NlRGVCeFJaREZaVXVmejNNYk9Q?=
 =?utf-8?B?aEFma1Bsb21CVVRJUXZuNVlYblBuUWY4NG9LaDV0UjE0ckhyS014THdWU1Ay?=
 =?utf-8?B?ZkFCa0NUTHZOUVlOTDlsbVhHZVRtOVhGMEN5eWNTcnZrSjRyWW1FdDF4ZDNu?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a04b6f0-efb5-47a7-cecd-08ddc561f4b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:44:26.6084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzWebRwS2ufmfmKjGv6TKwPHJ2jn0KU0YaejQqhrwN99idNrtYvo3KNR4AWW3bPLolCieoItynTX5UuICCVL5F9Lg7qCA1dCDo+4rRn9h/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9507
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> Add a kernel command-line parameter to enable or disable the exposure of
> the ABMC (Assignable Bandwidth Monitoring Counters) hardware feature to
> resctrl.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

