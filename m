Return-Path: <linux-kernel+bounces-736244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 168BAB09A67
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5097AA30F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FCD1C863B;
	Fri, 18 Jul 2025 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMrPiHs+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760F312B94;
	Fri, 18 Jul 2025 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752811369; cv=fail; b=U41pKmPLA+dazxFVe34Geg4nDhMA+Y1NDnR2FDLHw7YEDJ4lIFXF1InMoUU3LFRt0L8PTHHYhn//52eN3mq+ogNmHv0qHRrC4EzGin/s8WlfhEc/QL4K0qmv13MIMzcC3hHRoJWV5V2Z0QWrCpRxJ7VBTQ/w3mJ8zATvHYpmT3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752811369; c=relaxed/simple;
	bh=fx19BwIwFhRfZVOdJnFUISMvhGG3LrKGlAIopFPgdx0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U7bejXeJM8n59R3FbICg91wcdAYh1kPup6/ODtjorfFv9todv69Y6fepK2ANSualWW2BdKbNA9QqpcwUYpLnUmtp7Q+ahgkGeSxorqH7Ig3Fi76tinEonVRLy8THiHR5nWtmyN32RNmWK8EE/Trh+bLgnbgdl7umZiFpwJAPgmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMrPiHs+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752811368; x=1784347368;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fx19BwIwFhRfZVOdJnFUISMvhGG3LrKGlAIopFPgdx0=;
  b=cMrPiHs+RrGxwHiuXsOWswZ2eT//TMFCE1mDhafNvTRVebqPhUDHoS8E
   YSKmv/VySqrgNAyMxTQkE4XtMIsgS6odLnA+jsiddZAx0srf9w7V1M7Dj
   aUqS/i41digiyPEQoyZBZPNDXaz0SHumHQD6Gr5/3PYHRvJQAOpZ3vWHs
   QQvDBRJiQzvp02PXiKvMy8jechA1/c5bHQy1U0N4rplzKF3NipaXwROMT
   L8cSw6d++56pQk0O5GoaSeLzEMKFuaOcXGxLjGUa9vtG19ENdTYMEFDn8
   jkje7prp8D/2hSuGdEjeWhoHbYyvej1aN+EPYF6OVQ9ZFKR0oi+3GtZdS
   w==;
X-CSE-ConnectionGUID: ljPu9msPQVqaHwndTC//eg==
X-CSE-MsgGUID: 1mKtDr/0TCauscMu3aagjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66549042"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="66549042"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 21:02:47 -0700
X-CSE-ConnectionGUID: 4G0MVfP+Sk6geVT9ZE2X3w==
X-CSE-MsgGUID: 0OytAlAURwOXcAZ+BwIZQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188915134"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 21:02:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 21:02:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 21:02:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Jul 2025 21:02:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAdCx8TqdQF15y5VRS9PHDiDLp5r4b+F4jOe4lK7pnCcR4YOGEmJg3HWW0dvuNIQtrPnNQ+ASAr3FCVQXVTpmHy+WVtnSynzbfql1cLVcpONY7NYUKKeTMDYT8OpvIaIoouwPDeQ/kC7uCsLSiWZHajqAb5GN+LSg1IzMdxHlEclGfNI7Iebsh+JALVvR69gW14d6eozD7BIJFBmngHvRTL1P3N4JA7fsXSia/xFM/AcGrOuoBbvjNDhT6nS0CwfKUlzYJLQveVtXdR/48j8Lc4CN4hlSL5bDxtSKUi6MtOmrG3hb3BrCg5UF0+EtOjiENppQGMUHmUBgPC4REKFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqnN6o2C5uLeiQUoT1MWfbSxf3Oow+Lk/ACrDjcCteI=;
 b=wZolp4HKMiYDcEb8dadH5J43tRG5z8BRIN+PaD0pMpsb8jvMS12WLk1TNk5Y2hJ9sgZF3ray+cCCpnmf/YQ7/42Vep/71d6l/W8lKYC3wz7idKbGF/arhXzUPZ1jfc5fyFbV8KtTH0fXhEpapKVFXsori5YBnV0i/94Uv0iv33jY6hw0nLOnuJ2WfdkPeGH1Fx7bF23SeGAFAEOatHMci7dnMA8CpiIYtwc61pCT3JQ0v1Qterz+FZGC9YH9knMf/3GpNmWWnaRlY0WWzi1Tqz0XnB5JLSFv7KmGIl7CNm9XxdLKIuvD22SxSkDUuBUXP1dTFVgkMJDo3asNbp5O2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 18 Jul
 2025 04:02:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 04:02:38 +0000
Message-ID: <e10bfec5-dfbf-4008-aedb-c47f6596e712@intel.com>
Date: Thu, 17 Jul 2025 21:02:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 32/34] fs/resctrl: Disable BMEC event configuration
 when mbm_event mode is enabled
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
 <6aee8abeef1bdc5b88f8c3142a702a9d683f5f66.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <6aee8abeef1bdc5b88f8c3142a702a9d683f5f66.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c223d74-7f27-4ccc-1c68-08ddc5afef53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c295RDZtTHVqcjVTRFM2SytzR0tMMzBHR3QzS1l4TGtjaWpDcVR1MDNpS3g3?=
 =?utf-8?B?L3lZdlFBNTZiNGpsV3BvY242cTFNLzJWNjU0ZFFkOVVhQWRtY1hlZmxhUnZB?=
 =?utf-8?B?VDRxSCt6Zm5oK0xkV2JmdlZoNkx4clhuUmZOWnFZNFYyK3JJZzB5REROWlZW?=
 =?utf-8?B?UDExcnhuL3hlM3hhNUN6QWJzakhkVS82eXZhdlRDanhBQjJ2cXR5V2dHbUlK?=
 =?utf-8?B?TDlYeHRFeC9pdk9Sc2Y1SGNHRUxHNEJBaEFtOXN3MnBiK0hXTVJzNHMzbDdY?=
 =?utf-8?B?ajUyUUJLSGpHRkJFNTdUc3ZLZE1Tc1dZejhpN3BOa1J1TjlQTlZCaTFPOElM?=
 =?utf-8?B?eDFqa1QvcTdNcDBCcytGRGY4a0QwWUxtb0hXYjVacTI2NjZJK0FPV211T0ZH?=
 =?utf-8?B?VWZ3N1BaQ29RbitZMjJ5MzBIMElpc2R4d21Bd0pGWG9qQmJ1Ris5QWhuLzBq?=
 =?utf-8?B?NUZ4Vld3OHJiVnVML1FhOFBEcHlVZUhYV2xJY3lsSDcvNlljMmhQQnJLTWdp?=
 =?utf-8?B?czViQXJJWWdBeFRhNEZzSnZFZ3BmKzIwNVh2VUpucDEzejNoSVZSTm9LU25Y?=
 =?utf-8?B?ZEkwcUlNWW4xNVdVY1d5WnF6bjRHRkFrTEJoNXZyWW5YT3hqR2ppeEl6ZWRt?=
 =?utf-8?B?dmJQUWJSYlN0TG83T3o3Y1JTOFpuYUlaRmYrbTZ5dHhEWHo2K0NrNng1VW1w?=
 =?utf-8?B?ZlNvbUdBaFlYa3FSeFJPTmxRaUh0VmhsaDFhWFp0UkFNV2NlTVNoZXpvYllq?=
 =?utf-8?B?ZTJjMmh3c1BkNjM0Nm9lajBnUC80QzM0dGtpaTQrcXZXWUhyTVVaOG5mZ0Vi?=
 =?utf-8?B?ZFdwdjliSUxVeEdsWlY0MDRXaXpud3VBdnlWMEN4MVFCYjdhWWp6OUdIRThy?=
 =?utf-8?B?SW9QTnJvNGM1azFUM3JsOTZNenhld01sSS9HOTF4bkZyUElSbjYyRms5SUx3?=
 =?utf-8?B?VUNRSjAxWVRORzcwdjdCUExBb2JoaVNpT0xyZVBUTFpLZU1DNUxDZFBuMlYr?=
 =?utf-8?B?eStXQ0xzS0orMkNCN0NvREhKajgxWm8yWW93TzVwd3J4cnZHLzMvV29WdjhL?=
 =?utf-8?B?cDU1TjEwcjJEVjRSbFYxaWU0UW5hSUEvUDBGY3lVSGFQSGFIUzd1K0FYajJj?=
 =?utf-8?B?WmJBT2d5V0VDa092bDNVS2tpaDhiMWRXN2R1QlZ6TG13T2xScHV5ZUVrYWww?=
 =?utf-8?B?OTlKSHZvQSs1SjlLSDFubld4UXRrWEl6RExpdU1TYWNPMFhiV0tQQ29MZ1Nr?=
 =?utf-8?B?Y1gvdCtWVUtHSzNDeGxTM0hlMm5UVHc2Q3kxNkhFQk1pUTJrcHI3TTJnVlNn?=
 =?utf-8?B?UGpvN0I4N3BhY1ZLVy84USt5OUpOaHo5Qkd6bVo0cWJXakc0emRjWGVSUTMz?=
 =?utf-8?B?Qnl1YUF5cmhLSTltVjFKY0duc1IwTFN6RzZFUUh3MWZXcXVzSU8yblE0UEg4?=
 =?utf-8?B?WG4wSkREbXBsTTF5aGY4aTVtalc0c1F5VEtUSm04UXV6cnhHZVM0YmVCQjJ4?=
 =?utf-8?B?OGtsOW1yMGxERWtBS1p5V2RlOGtHV0Q3b0lKUFJReUV3VVhXYnpzMnlCOXRY?=
 =?utf-8?B?Q0UxbzdPNFlIYi9KbWdwdXRPT2xNd1gyb2dORklldG10YWNPRGhrYjB0UDZF?=
 =?utf-8?B?eFA1SWRLa3pycjNiOFhCSGRqM3NnZFVPUkVMVG43Z2dOL2N3Qjg5Z0tRZlBk?=
 =?utf-8?B?amtaWmVGOHFrUjFId3U5QkpWd1dQbTlpQk1lenh5T3dXUkxjV3hndlVWeFdD?=
 =?utf-8?B?MDFveUNVZHNGY3BqMDlXWjlxemVsdTZJdW44OGd0OUcwWlJqbldNVThVRjli?=
 =?utf-8?B?VXlVYURnNG01RDB0TnpsODVGamovQ2ovckdJVDRPQnNkTC94ZkREeU5aRVF3?=
 =?utf-8?B?bzRvZnFlZWtZYkZ3dUFUTEpadlBwLy9uRXR1ZDVJM3JLV3hpY2RqWDJOb3Fn?=
 =?utf-8?Q?uUgNQ9dm+nc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHRERlljRWZ6YjhpV01RUzRsUHg2MXB2WGkycVhsY1JQcVlyREt6cEJYd0w4?=
 =?utf-8?B?MW44MURQc3lnNjN5d01ZWUlqb0FTM3R3ejlkMzVOaC9mUUxwZ3F6aWE2UlhG?=
 =?utf-8?B?amcvYS9zU2ZHcmp1Mi8xOC9MelZlUCtnWTBTanpkSFppMGZuUWxuRUFTYkJ1?=
 =?utf-8?B?eTZSczZ4em00VGQ1TXRQQU5WSHA3b2U4OTNDVlFhNGo5UkVqYkRFRVFDUWtp?=
 =?utf-8?B?SnNWbTZLalNGUFFxNzF2eGIzdVVRTE5EMXhyYmxFdTY2bUxQaWUyOWlyd3BN?=
 =?utf-8?B?NGhsbGNORDR5OHA1c0hKRW9pci85b0ZxS2tNQTF6TENwUHEvSHV0K1FRL0sv?=
 =?utf-8?B?ODRUWFJrL1J2UC9JRjkvRzIzK2RabDhNVDVCaUErZlZYQjRUSk1yWEg0RFJ0?=
 =?utf-8?B?Q3ViMnlGMXRFWXNreUgzSDFaL3NiTm5LcUlXYzI2TkJCakxKbHZyMUluejIx?=
 =?utf-8?B?eEZiNTRTYUFYemdmamNidThISlVEcHdpVW44dmpSZVBHSzZoUHRtTEl4cllp?=
 =?utf-8?B?bFIzS04yTlYrbGNySEJKUXE0QmF1VjJLdDhMTlErSzRNbHE0WWM1a3hZU2xj?=
 =?utf-8?B?MytEMTdrU0gyVEdpb2QwWHhWeVpzeEQ3dHcyWlk3aXZ5K3ZEOXpzcDF3NEJt?=
 =?utf-8?B?QW1SbWE3aUNDeTlONWh3L0hkbTgrZXlGY240MkYydkFONGdaakZRSmtJbkhY?=
 =?utf-8?B?K2pMNldVSjZtY095dzlYOEJwSUxHUWxhWGhuNTc3SmY0a00yVUp6U1RJT2ho?=
 =?utf-8?B?cGZUa3BraGJ4QU5jaVd4TFk0WFpUdmJqTUlNa2t2Vm9DMEc2Qm9sNjQvaEdB?=
 =?utf-8?B?eGVjVkU0YUhHQUNxcUVEd3h2dmRJMzNyb1JuZElicUZ6Z3pndDErWE9PWFFD?=
 =?utf-8?B?ZENldE1FcE9nQ0tPUWdlL2pPQS8zaVFKWTFJekZDZ0VicW5TTnFrbExWMWhk?=
 =?utf-8?B?Uk90ZDNhUExBUTJOSFY2N3k2REF0SEhYY1dKOVh4NUdWRkYrdXFNSnRTVWRs?=
 =?utf-8?B?WGJqdkc5TW1FRVVVSDA2WVdwNzR0a205S0N3eXVOcG5qTkY4RHYyRTlScTIv?=
 =?utf-8?B?dGhIUVdXL013S0s5TlRBTmNwVURMRmMwS1M3ejgvSzVMZGRSQXYzWWxiVFNG?=
 =?utf-8?B?Rit2Wld5Vk1qaDh0cGM0RUFqZWRCVGVXZ05VNUV6MUVpazBNcVd5OTRobDlK?=
 =?utf-8?B?c3JYMWtjMFpvSGdTVlM0UlRUMHJtc3pqZ0xpUVBvZWluVjd5bllPZlIyTlVV?=
 =?utf-8?B?S2x0MjR4T2gvOXF3NUZhNzhNaXVoNTgwUEN3RFVvbkR1bkZNQTYwM1MvYnJp?=
 =?utf-8?B?Y0dqTnZaWGpSZlBERkJHQUE4Tzd5QzRzVWJEYTVqMlpJVnBLbGE1bnRrZnU2?=
 =?utf-8?B?WHg2MzhFNi93SXJBeWdMcWg5aExOR2c1VHVTM2xlcFkxaUFxay9pMUhjTE02?=
 =?utf-8?B?N1g5N1JzM05DMk94N1hqaTB4WTZpbC9tYmV4SEd2ZHU3ZGpEc3VMMHRyMEdk?=
 =?utf-8?B?TVNZeS9ld0dxL0ljMnhFUUZsS0RZWHFqdjhmTitxVHVZRHczODdCZjB5TlI4?=
 =?utf-8?B?TmtTdHU0UUUvKzRjTTViczJoSGpvNFVxTFI1VGlMOE1DME9sYzBZVDE1bWxs?=
 =?utf-8?B?OWpBQ0RtdmlHUDJ5dDJpS2ptVThkak5tV0Fiek1lMW5ZaU0zSDZWb3dhTDVC?=
 =?utf-8?B?VkVjdHE2dFZtSGgwVHN1aFE0Y0JSVWIyLzFGbG1OV3ZQM0Fva2x4YkNpUGR3?=
 =?utf-8?B?eURHU1pqbmw5dW1ZWkNKNUdGN3QrdGdqNEhvb3BveVZMMjJEYzIyLzVVaHVl?=
 =?utf-8?B?NU9yREtUT2swQzNyak5kK3NyVFBscE80TC9rZXJvL3ZiandOVE8yVU9XNzlv?=
 =?utf-8?B?Y3R6c2Q2OEtEcjV3cG5xR3J6aDIySkF0ODNhajdSQXgzQkN6OFlFMG9pZlY4?=
 =?utf-8?B?WXRFeVRjMnh2YmIrMEFMT2VPdDhQQTZWUjVUUHNMdDRTZVR6emFtUmI1VitS?=
 =?utf-8?B?UFUydmVqNW1FV2VhVE9iR2pBa0xseFFmSUlKYkxHU1E3UTJDakZLZGVCNUd2?=
 =?utf-8?B?N2RVZzl0UDRkSWVkVXZMamw2SGk0cVgrRkUxWGhsKzlSTTRYTnRhSU9sb0pR?=
 =?utf-8?B?UGNXWGZSU3hqejNibkdtL1E5L0VrNjBOQ0RxZVVlK0lUWElsNjIwOEhxYklP?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c223d74-7f27-4ccc-1c68-08ddc5afef53
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 04:02:38.3940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oS/ENHWGZn1sUcSsIua53A1pPPEZiJo9ZIrNfgeSf13Gp17zyddJjzlyr/7BY5ayMCv3gBY3VNzQhIPauccO+LidU5k0M+jks9TVKmOluuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
>  
> +/*
> + * resctrl_bmec_files_show() — Controls the visibility of BMEC-related resctrl
> + * files. When @show is true, the files are displayed; when false, the files
> + * are hidden.
> + */
> +static void resctrl_bmec_files_show(struct rdt_resource *r, bool show)

The "void" return is unexpected since many of the calls can fail. It looks to me
that this is indeed intentional since there is no BMEC feature checking, but instead
the existence of the resctrl files are implicitly used as feature check. Doing so enables
this code to be called on any system whether BMEC is supported or not and thus a failure
should not be considered an actual failure. If this is the case, then it is subtle so please
add this information to the function's comments. If this is not the case, could you
please explain the void return?

> +{
> +	struct kernfs_node *kn_config, *l3_mon_kn;
> +	char name[32];
> +
> +	sprintf(name, "%s_MON", r->name);
> +	l3_mon_kn = kernfs_find_and_get(kn_info, name);
> +	if (!l3_mon_kn)
> +		return;
> +
> +	kn_config = kernfs_find_and_get(l3_mon_kn, "mbm_total_bytes_config");
> +	if (kn_config) {
> +		kernfs_show(kn_config, show);
> +		kernfs_put(kn_config);
> +	}
> +
> +	kn_config = kernfs_find_and_get(l3_mon_kn, "mbm_local_bytes_config");
> +	if (kn_config) {
> +		kernfs_show(kn_config, show);
> +		kernfs_put(kn_config);
> +	}
> +
> +	kernfs_put(l3_mon_kn);
> +}
> +
>  static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
>  					struct seq_file *s, void *v)
>  {
> @@ -2659,6 +2690,12 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>  			ret = resctrl_mkdir_event_configs(r, kn_subdir);
>  			if (ret)
>  				return ret;
> +			/*
> +			 * Hide BMEC related files if mbm_event mode
> +			 * is enabled.
> +			 */
> +			if (resctrl_arch_mbm_cntr_assign_enabled(r))
> +				resctrl_bmec_files_show(r, false);

Looks like the kernfs_find_and_get(kn_info, name) in resctrl_bmec_files_show()
can be avoided by providing the kn as parameter. I think you may be doing it like
this because of how resctrl_bmec_files_show() is used in resctrl_mbm_assign_mode_write()
in the next patch. I think the kn can still be provided as parameter but 
resctrl_mbm_assign_mode_write() will set it to NULL and only then does 
resctrl_bmec_files_show() need to figure it out itself.

>  		}
>  	}
>  

Reinette

