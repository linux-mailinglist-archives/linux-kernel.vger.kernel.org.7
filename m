Return-Path: <linux-kernel+bounces-751301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E77D6B16770
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B54188E55A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81784213E89;
	Wed, 30 Jul 2025 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2Yw7OON"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB11F1537;
	Wed, 30 Jul 2025 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906275; cv=fail; b=T79i+oYGGMBu2KcKP1KEMiYa1EZNmaGMyphdxuaCdwCgr/r4O8OlNsPlgaePkE386QYkS3WaGR0E4Vmx7+HAaYbxE4PKFFmUv8Nf4Dz3FhF2Rz8MXbS4z91X1sQGuY3894LqovFegGGJwJ/Zg82t/Vfmush3RAXPR14RS6QRPco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906275; c=relaxed/simple;
	bh=4SeWNhxJOmmmRKy/giP55IwD5bQUKqA5W8QRC8jUc4U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=izhXCbMWGBGQlrdHDOAdRO/GSr7z0dy2HAQ6UEjrN0tkMj1EniZkVjliEepItb5EtQ8inuT3Hdrz9uvuLhP96Jeq3MHzG6qGi5kuzSHN1ahOr9M6yrMXEtdbhyCbbCwCBCc8kPUsZ9Z2t6ub0+woGkaHz2/x/f48BPPE79LhldQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2Yw7OON; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753906274; x=1785442274;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4SeWNhxJOmmmRKy/giP55IwD5bQUKqA5W8QRC8jUc4U=;
  b=I2Yw7OONI3IOlJmhqVXPAwKM4rYh4Ue1f4+UhGNf/nHn9L8/pkTaNfDz
   Z8K6p1JTkZNeFgeZUZ2fQNGmMd5WCAX62aF+A7QDJzBFbliBxItL/Fs1E
   ElvRg5C4bQalLv6Zxb0tBFsppCuhdfDpXTUjzv0545VoRxw8yaE3ka87w
   Kabr28SPa40wH0u/XaoAKMpmzUBTUU+XYD7yIj2+tMdIwnsr87HMsxlmN
   5/s2LoEE2hQLbny/vVq4Cr4yPsF+JVe2zIDl4ipjhc89ChbsleludG8XJ
   Z4VLRst0BzEXwXtC4J5aYw9oILwd1y4BRJUFn3QF5pt018nNfONObeRIV
   w==;
X-CSE-ConnectionGUID: 9lgbbZ0+RxajENfwbDAkZw==
X-CSE-MsgGUID: pSKyfDXTTTekQ5tvx2b7hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67300442"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67300442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:11:13 -0700
X-CSE-ConnectionGUID: YcWJzBTGQtCNWF3QilauNQ==
X-CSE-MsgGUID: 3ino4fhaR56UHZNnEHiCkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163864474"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:11:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:11:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:11:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.82) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QL1tmRh4xl/kCj3Di/visESLH15vOugrkju+sLtFHPmsWqCLDewHBI25/V8wnkQfOxdbFApbriE25Vy5UCkGMSOlwhvpsbr2eJt7jLazPMUYYtALRemgWwr+bvQi9exB93ri5eOE+0nvXXk8TZ8mxAK4wVVHX6zkGNGB5BvMw3MBSkNqwI5YK6YuYt0108rKq4H6xk8VbnvHjpaF/lygDYcQVMhFyWtk4sSoWM1IgprM3RDv/FgRIQy9WIqDttDhl81S96YDoZNiXcxSe/DsoQOuFEdPrD1LTFIdwKUKM6IeIIheewkYMLwLkW0040oT/ahR2PmWY/DjwnLC3DXSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSxhogbK7MStKtgg95JxucSg5gW1nVuwUQXCz2yphrw=;
 b=ImjSw8GMmQjy4oR+AiEIVrBW9FupnmkK7B+kBenVXwFcMQkd8pnm7qZPe1Bg8iibVp6Y31onXu0sFOD8FxhAtg//FgbZQzyCxyySSUxehzWISTvxkI6QnRE9jSD2oRckFCczylBet3Dy0ya4BcxfI7qOPPIEoMRmqXnSqgesflG4qw30zDgkLs06M7+w9b0lcmL27t9CoQohssJva9/Th1D+ECZEBopG0amOU0sNQ/UckZIV22QkABpx8i3T6QAVCDOMqYnezAoTTpCwz2qOqJEJyPMmZ9qWUZ7Ixyg0hlT1GdQeu3MiCB+YtCgR1MLH20NdPqZmccusYEYPDyg6ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 20:10:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:10:39 +0000
Message-ID: <2e88d204-cca4-4df4-94f1-478150eff2cf@intel.com>
Date: Wed, 30 Jul 2025 13:10:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 30/34] fs/resctrl: Introduce the interface to modify
 assignments in a group
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
 <5c589b07428d3bce95616b0f69fc58883eb86360.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <5c589b07428d3bce95616b0f69fc58883eb86360.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:303:b8::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: cf499545-96eb-4d64-569b-08ddcfa526f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFdZZWIvQTVTanllQjY0eGZDU2JpZ0U0T0JFdGkvd1d1dXh1ZUk0OGgwK1Vq?=
 =?utf-8?B?blN3NGYxaVBvRlgxOC9rTGNBWGhJTmZ2THJwK0JQSzFaZDZxUHhOdDYycUZB?=
 =?utf-8?B?VUtGYUtNTWwxWElDYTBCRkZkU1hZV1I3OU40dkYyQmxUblhPQjFqRFFlb0dW?=
 =?utf-8?B?VENibkhuekZ0cVR3T2FlcEZNSWVrUjhFdHZqS1BmU1RUSnF4akgycFp4dGVu?=
 =?utf-8?B?U25pRnNKQzFuQW44WVZEU2tZMkJKWnk1ZzJxd1FYWTJxRzJER3BYYTcrb1dE?=
 =?utf-8?B?cVRhYVFFNnVyWGdmZk9wK25PRjRXL3RRRXFUcHM1OHVOZ25UZEFHQ3IvVkNh?=
 =?utf-8?B?dVdiVG1sc09CU1BWS0lMMTUxSTZPaytLM1VjNGhRT1hiam9RL1czaTVoUGhl?=
 =?utf-8?B?UzI5clRoKzh6Y3NLcy9QdjBKTS9EWlZjZ2xYR3VuT0VQOGJIaE4yY1lES2R5?=
 =?utf-8?B?RytpM3laSWo2ZEVIUFVEU0tPWVk1T1V4OTEvc1pJMlVMdkoxYVk1OWJ3YkJz?=
 =?utf-8?B?MXFzWktXRzVkc052RlVBeWU5RldEMkJSZHpBelJadnJNbEJLUXFFZTRhbzho?=
 =?utf-8?B?aVhnR00rbGZhVzdjM2ErN2NQbkJzb1l1UUxEZ1JrMUhhUUwzVXpIVzNubW1O?=
 =?utf-8?B?cUxUbUZDTUxsVzV0Ylo5UXhOZTZsK0s0MmpJRkVzek1uZnJ4T2ZwdWk4VkVv?=
 =?utf-8?B?Q2ZLS1hKZk9HSGVFYTUrOGw4QnRZR290azNJYWdESHNmaStzdGxPVWdEeFh4?=
 =?utf-8?B?eFVjTktVbTlGSnZhVTV0SW5NdkJHMXVKUEk3NmdhK0MyWUxCZnJZL1F0OVJi?=
 =?utf-8?B?SzYrUGdMaS9ncUFzUUY0Q2tKZDZrUUd1NFVIQ3Vsa08rT2NJMEQvK2pKeXpu?=
 =?utf-8?B?bkNtOVQwZkFseUswdkZya0lhWE1UK3NPa1RScGhUSkxoaHpzR1RrbndwQXMx?=
 =?utf-8?B?OWduQ1lTNXVIUGJGWnRuYitJbmppeFM4aUgrUzBqZXhhRXpXQXZNUHVYUkR0?=
 =?utf-8?B?TExFdGxqRWRud2dLU2J6bC9OTDl1b3NWVlFwc0RSZVkzUU5wZFJYTzNOWnNO?=
 =?utf-8?B?LytXcmxXR0hvYTBUMjBDZGZRSFd0dHMzT2cxemF6TXh3TXplR2l2WmJYUnpS?=
 =?utf-8?B?NVlPY3d4aXliNTMyMUhRWnpRNk9zS0hMOGtLK0tjeEhBZE84YlRZdldPakRZ?=
 =?utf-8?B?eWRqeWpBeUZMb3VmaTMrWUxrQkZtTDVhaG1vUDJ5TnEyQmtKMUlwTDFWVzlQ?=
 =?utf-8?B?MjBlMXlCWUhOYW9RcDg4Tlorb1hSbFZnd2toelN0VUNZbmdEM3MzREVLdEFS?=
 =?utf-8?B?enVWT0c0LzM4Qy9HS2N4emJpQzl2TExqSEVIaFNFTUNPU2phcG5YNUkzMXhq?=
 =?utf-8?B?SVRnNExLcE51Ym9CZW1TV1NveG9IRWNOVGRhSWlmY3RCMkRRWVJpNUxhWm5T?=
 =?utf-8?B?TGp1Y2Z0NXR3RlpWQ0UvMkcvUllObm53M3FkNFErZURDdkgvUjR3a1VGSGtK?=
 =?utf-8?B?SllkT2lsOGIwTFJtbitGa2dFMXRMWlo4dUdlRmZTWTFMMDhVZXpUYjVWZ05Q?=
 =?utf-8?B?ZytFZmNaQm9ILzdBdWFKT2FLT1RFUzlqZmlBWWpqTndCSkFMTFkxZG5KWkYw?=
 =?utf-8?B?RjY0M0hwbU0rTlZMbmJGRmxBbXFBUlN1M1lzbFB1WDlCNHBpbitndXdpR1Y0?=
 =?utf-8?B?YVdzeWlUTFV1MzM0WFA0V1I5QzBuZlJZdEhsdGViRUR5emFXNGlXYlNjaUV3?=
 =?utf-8?B?b29XUHJsVVY0NW1jS2tzNndybEJlWk40KzZhMjhEenRuWWR4QW04cFA2MlMz?=
 =?utf-8?B?T25nSlN0VkVvdllNQnBrVTBQeFZNYTdWcVp0UUYyUnNqbWF5VlR4OUU5ZStl?=
 =?utf-8?B?OUk3ZFM3S0hMbi8yRXo0b2J2bnRXaUxaT2FtQVhBRnVieng3VDRxVHI1cHlu?=
 =?utf-8?Q?0sp5x5Cr0pQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJlbmZrZ0hNY1NtcHpFa200VEdUbUo1eHEwU21Vb3FQNDE4MWczZVhRYWRu?=
 =?utf-8?B?NzB6NUpPcG5COHF4QWNRZHc2OUYrdExwbURyVUwrUndrdXJwenlDMTVZR3RX?=
 =?utf-8?B?T2l2MG14TjBUK3RZUm14Qm1ickJ5S01BWjZtUXhaSzFMTDNQSzVXMmltNmpp?=
 =?utf-8?B?K3dGajROWG1EY1RuQi9ILzJzT0tybEtFZnh2dGUxUzJ5Vm84cHpQbUFwbkJI?=
 =?utf-8?B?S3ZIc2MyOFpzTzhVcnBSM2l3dTZKTXYyeXdGTVFybVlsbXBUbjJBc04vaWN1?=
 =?utf-8?B?MFVhWFA1bURkVFRST1MycGdFNVRDUTJ0TXFwN0JRNmE1ZWVBMFJFWDNzWVhH?=
 =?utf-8?B?a0REeXFvSEtqbCtyS2NsMFlKb2taUDFXTFc1Z0JXTTVQN2RaSHJQaUthcktJ?=
 =?utf-8?B?WGRZdXEzL2s5ZTFxaFF6cE1NZXVwSTB4aFZ6UnFqVWdFRTVNWGsxVE1Bdno3?=
 =?utf-8?B?cU9tZVlvT29wcjJQYzM2M3NBaGVTd3pOejhrbTFlWXY2OXpBOFpodzg0Vmto?=
 =?utf-8?B?TEwxZ3c5NDJ5QjJ0T281MnVDVXVVR05uMitNYnlMVWRvVUR3ay9TdkFrNWtK?=
 =?utf-8?B?aVMxWGNXVXRKUzJxY2F3d1dRN1F4cm9CeWlTK0ZtV0pOYnJjSTNsYTFCUml6?=
 =?utf-8?B?cTFxckNtNzhxakRKMC9GbGFYdytuaWNpQVFER0N4NjEvdmpCenV6dEYvMWhn?=
 =?utf-8?B?OU1GOVhYbFliZzlvL0pFS0wwbDV1SzAybWdhb09lM2VNbTBNRGZ6Q0d2eDVB?=
 =?utf-8?B?Qk1uOURNdVJ2WHlhZUpGOEtkRFd0Z0llT0JDd2w1OXAzRml1WHVZdGtyZFl5?=
 =?utf-8?B?QmZmcHhTa2NmU3FIb0UvdzhVQjlkenRBNmloZU9RQzVENUtmek01WVdQQmlt?=
 =?utf-8?B?a3VPMlFFQkV1TlRCVUxCM1c2VXlUYkNwb3dXTkN6MlRLSWs2VWswbjJYMUsv?=
 =?utf-8?B?QTdXeFNUd3NEdUFoaVl5amFaWnY4NXd4aCs3VjJLSjFNYlB5S3hMbnJLbkVh?=
 =?utf-8?B?cko2K3MrbE4xbXFCUzJCSktMdFZwOUZhdFNHQTVGRERvS1Y2a3FTZnNxMEVk?=
 =?utf-8?B?WEhqSzREYWhwRGQyY3RFd293c29KWDJQS21mMEozcnpLd1kxZUs3SytCb2ZP?=
 =?utf-8?B?c2RNRGpxVDQyQ1JrbFZKZ3Roa2Y2aW9nNHBXSlFjM3hKMXpQRmd0NERmNCti?=
 =?utf-8?B?cTdpN0RJVGVxeXgzNzdoUXlZU0xqVWp5c0FEYVpBZ3dqMmdPVlM3YWxNQlFl?=
 =?utf-8?B?SmpYbXpPSm05aTRyM1hyc0phb2NsTjFxVGkzckZQdzBnNjd5bytGRU9KVXRB?=
 =?utf-8?B?ZlJwTitzcTcyTkV3QU5tM2JwYzhFcFFoblQvbHl4T0JtVktjQ2Y1SGVPdmFQ?=
 =?utf-8?B?NmJJbzlnc2w3Wk9TWVVKRVBXWU9tZHVqbENuWWJ1VENEaEJKdERjMUt3TjNk?=
 =?utf-8?B?enlOdEdac0c1KzVHOFNLU3pvRjViN0wwMlJSbjR3YkEySThjQlJjN1RaWTFa?=
 =?utf-8?B?V01hRE9zR1FsLy8raTZyazF5cWZWODdCZXNjSmR0L0duN3pKM3piOHR4YXRR?=
 =?utf-8?B?N01wcGFsbVRmSW92VU1HYy85cTdRVEZUQy9EeTlYZk5xRERtTnNpSkdadk5L?=
 =?utf-8?B?QVM2b3dhWFVCdXlnNFRxb0NrQmxtNGE1NkpUOVJ3UWxQTzJtL0VOSXhvc1d6?=
 =?utf-8?B?N1NWNXpKdXd4S0hIdTYvV0JNUVV6WURZRkpBaUM1S1B5R1IyKzRoUzRUek5W?=
 =?utf-8?B?NG1zSVdvMStGZXVSSjlaWFdBQXB4VVZxbzB0VTFyeFFHQWlSV3ZvNjJTL0Vm?=
 =?utf-8?B?NFFvc20xNkFiR2hqa21BeHpHZlhyZWJwdUI0Y2VYTjh6TUpld0NOSDNYdnhI?=
 =?utf-8?B?S09UbDFoelloc1MyTXNVdDMwYnVVNG15elZtdmtFU2xYSitxdGg3QU5KRFJP?=
 =?utf-8?B?RjNQVWlrVkFXRzRGUzRVdDNLbUZrYXR3Ymo0TUdNOUZQOTNmcVl6TWliZ0RV?=
 =?utf-8?B?dFUwdk1EUGp6ZUtYY3phVk9rRk92bFhTRFpJdFA0L09Gdlh3QW5VNCt1N2pr?=
 =?utf-8?B?V1VBZTJKajhIRGM5OGlwUTdQK3BxRHlOTXowbEMxMXVERzhHSkpHdmU3c2pV?=
 =?utf-8?B?Mm5nQUxoRFZTZ2s0SElYZXdUV0FTZ25XWWpsYnFER3JmNE4wSi9ialJhcm1v?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf499545-96eb-4d64-569b-08ddcfa526f8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:10:38.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yC82s2lXJoikXYafGtuoR12uN6evx7koybyTr7kyzP2tJqSe/BlvfxS5Y8k75hpZ0IdUP0kdLotqe5YIVe3XByPaRUKOTcOcb5VrwDbENOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> Enable the mbm_l3_assignments resctrl file to be used to modify counter
> assignments of CTRL_MON and MON groups when the "mbm_event" counter
> assignment mode is enabled.
> 
> The assignment modifications are done in the following format:

(needs imperative)

> <Event>:<Domain id>=<Assignment state>
> 
> Event: A valid MBM event in the
>        /sys/fs/resctrl/info/L3_MON/event_configs directory.
> 
> Domain ID: A valid domain ID. When writing, '*' applies the changes
> 	   to all domains.
> 
> Assignment states:
> 
>     _ : Unassign a counter.
> 
>     e : Assign a counter exclusively.
> 
> Examples:
> 
> $ cd /sys/fs/resctrl
> $ cat /sys/fs/resctrl/mbm_L3_assignments
>   mbm_total_bytes:0=e;1=e
>   mbm_local_bytes:0=e;1=e
> 
> To unassign the counter associated with the mbm_total_bytes event on
> domain 0:
> 
> $ echo "mbm_total_bytes:0=_" > mbm_L3_assignments
> $ cat /sys/fs/resctrl/mbm_L3_assignments
>   mbm_total_bytes:0=_;1=e
>   mbm_local_bytes:0=e;1=e
> 
> To unassign the counter associated with the mbm_total_bytes event on
> all the domains:
> 
> $ echo "mbm_total_bytes:*=_" > mbm_L3_assignments
> $ cat /sys/fs/resctrl/mbm_L3_assignments
>   mbm_total_bytes:0=_;1=_
>   mbm_local_bytes:0=e;1=e
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst | 146 +++++++++++++++++++++++++-
>  fs/resctrl/internal.h                 |   3 +
>  fs/resctrl/monitor.c                  |  94 +++++++++++++++++
>  fs/resctrl/rdtgroup.c                 |  48 ++++++++-
>  4 files changed, 289 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 0b8ce942f112..0c8701103214 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -525,7 +525,8 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
>  	Event: A valid MBM event in the
>  	       /sys/fs/resctrl/info/L3_MON/event_configs directory.
>  
> -	Domain ID: A valid domain ID.
> +	Domain ID: A valid domain ID. When writing, '*' applies the changes
> +		   to all the domains.
>  
>  	Assignment states:
>  
> @@ -542,6 +543,34 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
>  	   mbm_total_bytes:0=e;1=e
>  	   mbm_local_bytes:0=e;1=e
>  
> +	Assignments can be modified by writing to the interface.
> +
> +	Example:
> +	To unassign the counter associated with the mbm_total_bytes event on domain 0:

The alignment is off when looking at the generated html. What seems to be intended is that
"Example" is some sort of heading but it ends up just being part of the sentence that follows
and thus not apply to other examples that follow.
It can also be "Examples" since there are more than one.

> +	::
> +
> +	 # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
> +	   mbm_total_bytes:0=_;1=e
> +	   mbm_local_bytes:0=e;1=e
> +
> +	To unassign the counter associated with the mbm_total_bytes event on all the domains:
> +	::
> +
> +	 # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
> +	   mbm_total_bytes:0=_;1=_
> +	   mbm_local_bytes:0=e;1=e
> +
> +	To assign a counter associated with the mbm_total_bytes event on all domains in
> +	exclusive mode:
> +	::
> +
> +	 # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
> +	   mbm_total_bytes:0=e;1=e
> +	   mbm_local_bytes:0=e;1=e
> +
>  Resource allocation rules
>  -------------------------
>  
> @@ -1577,6 +1606,121 @@ View the llc occupancy snapshot::
>    # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
>    11234000
>  
> +
> +Examples on working with mbm_assign_mode
> +========================================
> +
> +a. Check if MBM counter assignment mode is supported.
> +::
> +
> +  # mount -t resctrl resctrl /sys/fs/resctrl/
> +
> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +  [mbm_event]
> +  default
> +
> +The "mbm_event" mode is detected and enabled.
> +
> +b. Check how many assignable counters are supported.
> +::
> +
> +  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
> +  0=32;1=32
> +
> +c. Check how many assignable counters are available for assignment in each domain.
> +::
> +
> +  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
> +  0=30;1=30
> +
> +d. To list the default group's assign states.
> +::
> +
> +  # cat /sys/fs/resctrl/mbm_L3_assignments
> +  mbm_total_bytes:0=e;1=e
> +  mbm_local_bytes:0=e;1=e
> +
> +e.  To unassign the counter associated with the mbm_total_bytes event on domain 0.
> +::
> +
> +  # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
> +  # cat /sys/fs/resctrl/mbm_L3_assignments
> +  mbm_total_bytes:0=_;1=e
> +  mbm_local_bytes:0=e;1=e
> +
> +f. To unassign the counter associated with the mbm_total_bytes event on all domains.
> +::
> +
> +  # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
> +  # cat /sys/fs/resctrl/mbm_L3_assignment
> +  mbm_total_bytes:0=_;1=_
> +  mbm_local_bytes:0=e;1=e
> +
> +g. To assign a counter associated with the mbm_total_bytes event on all domains in
> +exclusive mode.
> +::
> +
> +  # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
> +  # cat /sys/fs/resctrl/mbm_L3_assignments
> +  mbm_total_bytes:0=e;1=e
> +  mbm_local_bytes:0=e;1=e
> +
> +h. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
> +no change in reading the events with the assignment.  If the event is unassigned when
> +reading, then the read will come back as "Unassigned".

While this example is for a single resource group the supporting text goes back
and forth between being specific to one resource group and describing what happens
when there are multiple resource groups (see (j)). If it is just one resource group then above is
fine, but for multiple there are much more involved with the "unassigned". Same as what
was mentioned during previous version.

> +::
> +
> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> +  779247936
> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> +  765207488
> +
> +i. Check the event configurations.
> +::
> +
> +  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
> +  local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_writes,
> +  local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all
> +
> +  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
> +  local_reads,local_non_temporal_writes,local_reads_slow_memory
> +
> +j. Change the event configuration for mbm_local_bytes.
> +::
> +
> +  # echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
> +  /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
> +
> +  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
> +  local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
> +
> +This will update all (across all domains of all monitor groups) counter assignments
> +associated with the mbm_local_bytes event.
> +
> +k. Now read the local event again. The first read may come back with "Unavailable"
> +status. The subsequent read of mbm_local_bytes will display the current value.
> +::
> +
> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> +  Unavailable
> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> +  314101
> +
> +l. Users have the option to go back to 'default' mbm_assign_mode if required. This can be
> +done using the following command. Note that switching the mbm_assign_mode may reset all
> +the MBM counters (and thus all MBM events) of all the resctrl groups.
> +::
> +
> +  # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +  mbm_event
> +  [default]
> +
> +m. Unmount the resctrl filesystem.
> +::
> +
> +  # umount /sys/fs/resctrl/
> +
>  Intel RDT Errata
>  ================
>  
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index e2e3fc0c5fab..1350fc273258 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -418,6 +418,9 @@ int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v
>  ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
>  			   loff_t off);
>  
> +int resctrl_parse_mbm_assignment(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +				 char *event, char *tok);
> +
>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>  
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index ebc049105949..1e4f8e3bedc6 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -1311,3 +1311,97 @@ void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
>  			rdtgroup_update_cntr_event(r, crgrp, mevt->evtid);
>  	}
>  }
> +
> +/*
> + * mbm_get_mon_event_by_name() - Return the mon_evt entry for the matching
> + * event name.
> + */
> +static struct mon_evt *mbm_get_mon_event_by_name(struct rdt_resource *r, char *name)
> +{
> +	struct mon_evt *mevt;
> +
> +	for_each_mon_event(mevt) {
> +		if (mevt->rid == r->rid && mevt->enabled &&
> +		    resctrl_is_mbm_event(mevt->evtid) &&
> +		    !strcmp(mevt->name, name))
> +			return mevt;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int rdtgroup_modify_assign_state(char *assign, struct rdt_mon_domain *d,
> +					struct rdtgroup *rdtgrp, struct mon_evt *mevt)
> +{
> +	int ret = 0;
> +
> +	if (!assign || strlen(assign) != 1)
> +		return -EINVAL;
> +
> +	switch (*assign) {
> +	case 'e':
> +		ret = rdtgroup_assign_cntr_event(d, rdtgrp, mevt);
> +		break;
> +	case '_':
> +		rdtgroup_unassign_cntr_event(d, rdtgrp, mevt);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +int resctrl_parse_mbm_assignment(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +				 char *event, char *tok)
> +{
> +	struct rdt_mon_domain *d;
> +	unsigned long dom_id = 0;
> +	char *dom_str, *id_str;
> +	struct mon_evt *mevt;
> +	int ret;
> +
> +	mevt = mbm_get_mon_event_by_name(r, event);
> +	if (!mevt) {
> +		rdt_last_cmd_printf("Invalid event %s\n", event);
> +		return  -ENOENT;

Extra space

> +	}
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +
> +	id_str = strsep(&dom_str, "=");
> +
> +	/* Check for domain id '*' which means all domains */
> +	if (id_str && *id_str == '*') {
> +		ret = rdtgroup_modify_assign_state(dom_str, NULL, rdtgrp, mevt);
> +		if (ret)
> +			rdt_last_cmd_printf("Assign operation '%s:*=%s' failed\n",
> +					    event, dom_str);
> +		return ret;
> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Verify if the dom_id is valid */
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
> +			ret = rdtgroup_modify_assign_state(dom_str, d, rdtgrp, mevt);
> +			if (ret) {
> +				rdt_last_cmd_printf("Assign operation '%s:%ld=%s' failed\n",
> +						    event, dom_id, dom_str);
> +				return ret;
> +			}
> +			goto next;
> +		}
> +	}
> +
> +	rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
> +	return -EINVAL;
> +}
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 47716e623a9c..2d2b91cd1f67 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1979,6 +1979,51 @@ static int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file
>  	return ret;
>  }
>  
> +static ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf,

Please move to monitor.c

Reinette

