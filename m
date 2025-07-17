Return-Path: <linux-kernel+bounces-735833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A93B09448
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC0517C9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DEA30115E;
	Thu, 17 Jul 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tw4eDceS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720812135DD;
	Thu, 17 Jul 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777923; cv=fail; b=Qs2xafIBogHZ7Bi4VgN/tIgfo/95xZdOZcYv3F3ouuAgWntiZ1/qTiOh8iHTSCy6dgtpUAt/dEMELzBc8VlHfQ0lPmX6+h1UJbqUqvOs+oIUQUxJPDyUDD4juz90d4M0WYD6P6s7GeaKA/4pgO4h8yjKVJUujfHsDgOissco1AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777923; c=relaxed/simple;
	bh=R19JMuK3qa57pKZ0CiVtvyUoIvuOaqu1HjNKHYTSkuA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VBS2EAIoyoFzveT9TzQgBCCr/u2U3ldnwvruhaeQuMMC5W4j6FW35A9a4ULsq7tmIMyx9zY9sRy3Bp3H3X/4KZoXqieWMitjzIMvoWgqWISAponkGoajBIZlWHACXJSa9dRsEYHSp+htCqhg5TqzMaDQW9zJIdnfu9C+9zSOBLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tw4eDceS; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777921; x=1784313921;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R19JMuK3qa57pKZ0CiVtvyUoIvuOaqu1HjNKHYTSkuA=;
  b=Tw4eDceSeDPG2pNmpuh5Za0mp2HTeauxO8hl0Q+AUHGhotFmUjk5bHqH
   cRygH91HDoS2Kso7qeaVH2Dym3zJdrW12yraj35l/7vtesXkNVgLFmBrp
   Ya6m9PC9y+ubgWyHlM6kEcNOQM7Qa+HVWe3I4oGMBbAzjzQGgT1hCTqpF
   onN4STUL4ryPnYwCW0tTf2vrfdq4QLV/hMFFV78/S4T1kYADUX3CitKeD
   gtK0LhisXZgG1c5/6mkW6/+J/veyDiOUM1fS5FpNJkG104ft4urmukWzm
   LAqbPfFmyT1l8Qrwt6SLyym9m5z2ul+oUO/FunDQJLuIF3CR2ee44R8tj
   Q==;
X-CSE-ConnectionGUID: imhhZ/H0RuqYrU/oBkvgQQ==
X-CSE-MsgGUID: 5i+zV48OTXG5hCrU/zT/lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55191998"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55191998"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:45:20 -0700
X-CSE-ConnectionGUID: fy0UNG6CQce7bKufaGiYTg==
X-CSE-MsgGUID: xR+ZPNDyT+ykPuQgUm5GAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158440471"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:45:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:45:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:45:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.89)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:45:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UODUaQo+K2Vo8NEyHAtlMmB81PepQcSajAaIZHll2nbFWXm/tJLoZKSLRUbqHgmJ0ziQqtqRn7QpZzqBvoXOVqN5BBYWfSV+ZowKJLOdqEYbkeg5YLwThaAglz5PmOKeSGjv8WZ86REPGp3m66GWlnICkuKGUaOeo2DsnASlzTksDFowgCdk/2xNN3GooR4XbzoWmyEybhXjosbrW6fCF0GcOQyqDshyMAUZ5XRbYTDa2CqP7zDqb+6nKi3Aadobl4jaCPG/Ryd40VqHhU8AnW1UwmDpjPfzxcCD8T0QrPqDzubu3VtoKl7WdTnZmd+L498rNky89wXRmWhrQNGOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfbpJaV+FYWk0ygwBf6U7+dxdqOnbq8byoGBjgTrhsc=;
 b=hhMucoEToF3D9c3X1rzMGQc4iwSoDpefJqx70zFllOvH5f6gRZFP+ilbIdX6gnlvOSn619fY0Zvy3UmI9pXTcRCeEodcAR8+rf7udWXfAFasRMHE9nuTd2/lNl9dKJX/EHfgWh5DJbp+3IkYG1gNA1Cr+CADtoPgoSTufDWcuqUTCRnzX7i7FO+5NMz5eXkRH0nXPNzy8Ovdxl/MyYaPWxoqZqzE+7KuzgsJeubWw4aQnws684GltwCSztDsrKE6W9l4uR+gW1XUHFHakRRS0hwJgJEhPe9B75zZp4E/yITT4IDDzjv5BI8uoNocRv6gAXTO6j8aAzU6TLHWZDB7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH8PR11MB9507.namprd11.prod.outlook.com (2603:10b6:610:2bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Thu, 17 Jul
 2025 18:44:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:44:42 +0000
Message-ID: <73d7c9ee-0574-4d54-996e-05caa2cc440f@intel.com>
Date: Thu, 17 Jul 2025 11:44:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 07/34] x86,fs/resctrl: Consolidate monitoring related
 data from rdt_resource
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
 <e8c63f228c30c45d82c72b679fcfab926cb26a8b.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e8c63f228c30c45d82c72b679fcfab926cb26a8b.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH8PR11MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 356baef7-560a-4254-9ada-08ddc561fdd9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1VPY0RDNU9iUjdZbkVzU0FZYTl2YVhTMWluQkVZYXBjaDVOeXJyYkgwaGJM?=
 =?utf-8?B?WTdpNkFFVDV1TW5pWSt1ejY4WG9rek5aUVc1dGI3dUFzYVJib3BpbUgrN3ZG?=
 =?utf-8?B?TU51RTQybEY1TDgwa0ZYbzIzZU1vZ2JXdXV6enpRSW9sNFJieUVDR0JiUFNu?=
 =?utf-8?B?cWx1a1p2VDN6VHZGM0dMOHpxY3RhcWdkSUZlWTF6WDFxS0lsMm42WWhlRDBT?=
 =?utf-8?B?cjRuSW9RMUEyZlp4YVBmR3FlSzJianBXZ0s3VW4vbHk3Z0FtWHNlNE1SZWkw?=
 =?utf-8?B?cHgxcWJKVk54Ry9QVDlBdUtHTXUwSUw2aSt3RWQ1bXNienR0RUVNcTE3NkJW?=
 =?utf-8?B?ZTlZM3hCSitueG41RU96bERjaksxTzFlbGt3bGlPVmR6cUVYSzFVT0djSXhu?=
 =?utf-8?B?bkFkc2VnakhXMSsreXJRbjI3a3pOWEhsbjZ4OE5CM1doSFFlOXNtaVBOYnVu?=
 =?utf-8?B?RXhsQ0dsTXNFUS9VQ2hUdnBPYmJVSUdZSENkWlJiNjFuT01jUlBRYWVQbFhN?=
 =?utf-8?B?WVROOUxvZE1yb1FJd01Udm4rdC9OZ2toZkpRRis0L0JHQmFQdkg0NnMydk9t?=
 =?utf-8?B?UDU0WGVVNTJsZm0vL05oSk8xYkZudVNRTXRScUdJcnFubEpPcEsyMkxVd0Vk?=
 =?utf-8?B?OG41aGpqb3BoREd6NHQzZzRNaWwxMG9EdWlEcXI5RGU4TVJQeGNobGxyOWN5?=
 =?utf-8?B?eThPQ1FVcEJkNmtvQXlXSWpEdmkzYzNnbnVHUUZJMHdOVTFLT0xWaHpoZ0Nh?=
 =?utf-8?B?ODQxY1ZGWUpzZHZGZ0E0N0d5WkNZL3hnWWpYSjNVNE9RYkVJcDJHWXlENnNv?=
 =?utf-8?B?dVk1RVZGR1FvZCtNZkhOR1VWTHRDRHl6ME1aNFFUYzJ4bG9sNHQ3YUt1TWxy?=
 =?utf-8?B?NEhua1luWnpkYmVrMU1uempDRkg0T0E0WEFURm1PdkdocU5MaFdJK1c4YWRu?=
 =?utf-8?B?VDJmSE5Ia2djak1LU2UyRFFLNGhNTkNQY21zWGM1R2s5aStmbm93ZkJSZjV6?=
 =?utf-8?B?MGZGbWVRb1hBQjdUZ1RXNjF4MWp2cHp5RjBaSlpWL0FtOVFVTHBjeUF2Zi9r?=
 =?utf-8?B?REpwMzVzMk9Uc09nZHFoREZwdWxESFBDK2tXU3VQQnd1eldkSmt1Yk5aMHZj?=
 =?utf-8?B?cWZtVG1CclhVMUp3V01DZmxJaUx1cHM5N08zNGM1SWpUNXVOblpUY01CWG9U?=
 =?utf-8?B?eUE5SFpCdDdjSitHeGtBRnRmZjdFSTExbER4YWpGWWp6c1VqUFUxVGRYL3pE?=
 =?utf-8?B?K0RnWGFzNENrVXZLUHBRQjZ2ZW9PVFlLUHdDdkUxcjlzUXZKOWFvbzBWMEw5?=
 =?utf-8?B?NFlUNmhBUFBPYnVaSTBnZ05FMXlsN1JOZHJzb0tVSEFmYnVEWXhkam04Q2lM?=
 =?utf-8?B?L3ZKK2lGc0ozeGd5Q2ZVVnJvRUhNN3FpbkdweVMxZWNKamlkYnlwem41Mk1E?=
 =?utf-8?B?QUN4bHZwRzdkVnV2cmlrbXZ4eEtoT2NRZThUbVdsMGJkVHNIZXdsZFp4ekIr?=
 =?utf-8?B?eUU0WVlyeHdWalNQTm1EZXl0VkpIL0hObEFJeUlteXBNcEdVczBCTU8ra2tY?=
 =?utf-8?B?NjBvU3BnNEtaV3dCZHBqQmxyWjZ6Q3pUVlIya1V1UDZodWRNT2R0emU5TmxJ?=
 =?utf-8?B?L09SbWtLZUVKL3pGekVNblNFMCtWeXNnOTdBNjlzRjg0bDU2bzNrYVRSSEhJ?=
 =?utf-8?B?LzRKS1Y4QW9KMG9VK093TFhBUnNuekJFU0JlT2RzT0EzcWV6S2tsQkM3QWc2?=
 =?utf-8?B?RkFVdCthM24yM0Y3THYwTlVZbHVGWnMrT2llZFN5NlBWVWJ0YnRYem9ZZFdy?=
 =?utf-8?B?Q296UGRmMDBoU3ZhYlExdmhHQUQ3VENQUC9ZeHZwY3ZPL1FhRXBDUXlka2JN?=
 =?utf-8?B?TEQwSVp1bUVoL241dlRkK056Sld1Ri9zZlM3QUl2M0hXSndOLytQTGU3eEF2?=
 =?utf-8?Q?JPHizKfoCWs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm1ybU5PK0JYZVJzdkNQQVVHenhzZVFmQnN2d1dyaDg2cnRvVDZxR1kzYlFn?=
 =?utf-8?B?VGRyZ05wTE9xc0VnOHZsTENZbUxpcDQ0YWZPOHlFR3ZFS0ltZllSc0l5Ny9S?=
 =?utf-8?B?K2pFZUJMdGcwb0s2T2c2ZGVYdi9aRWl0dDkzUGpCU0NXd3hGMC8xaUNXK3dw?=
 =?utf-8?B?bFZGZjZxVVYvN1lOTnBBVHdoR05KcmwweGwvK3BldGlrZWdLdFg3OXJUN1hl?=
 =?utf-8?B?b1NqeUd0Zmo2Tk9kb1RqeHh6eUVmWEtFQjBWWXdnb2pEdlRwenNpV200QW80?=
 =?utf-8?B?QlBOYWhQcFo5UFBPUEVLOWZES0M2RlF2Tm1rR0dReWFxS0pWWXE1dmh3TUV4?=
 =?utf-8?B?U0FRdWRxYXEzSkZMMzhHR205UFJXTWVQK0puTDl5VVZwR3ZLRVdnWjk3NEhU?=
 =?utf-8?B?YzFXb2lDNjk5Qzl3WWU3M3Y1VUhQRnd1WmtHekRaZTRmT0pOWlE0UzI4enV1?=
 =?utf-8?B?TkJnQ3VFbGpIR2NCUzhPbjA0blBVL0lvR0hhVDMybzRFUXExUFJvbS93QnZR?=
 =?utf-8?B?WUJBYWUybUtUcnhabkdZcS81eXROUXZzTDNYZk9HSGJpZjJLTklKczgvOFFl?=
 =?utf-8?B?SFg3KzNDK2RaQ21wa1B3azBubW9uVm5IZWVtVzJNUkxhUDY2WmFzcGJ6ZDhE?=
 =?utf-8?B?SFF4aXM3Qzh5UU1uWWt6eitLS2h1MUdiaDlGem54ckN1Z2tEb0cvUThrOXpQ?=
 =?utf-8?B?RzlOOXZUd081Qmkwb3BiMjViREZycmxpTDVOdFRxVFRhN3BHMFU1dTA0aWZt?=
 =?utf-8?B?cmFiVUZGbnc0ZlhpUTlObERKRmFuamZVVVIvdjBRSHN6aTc5dG9kYlQvYm80?=
 =?utf-8?B?UGlLSGJvcDQyNWZsR0w0R0h3dE1NT0ZTTnZlazV0a2swTVQ0bi9YeW5RTzBD?=
 =?utf-8?B?UkRneE5oUUpoTXBEOTZ0djQrL1B0NEhBYlNYTmsyejNicDRES21WQU1OanNL?=
 =?utf-8?B?RktXNjZOclRlczE2TTk5N2RVSVRlVEJ0SzF6K1pERVFObVZVVHJ3d3pPS1FJ?=
 =?utf-8?B?TlI1SmpURjcxVnhDSkppS2pqQndtUDNZZ1NONXV0dkxIR0tZMlBwb1VPbjMw?=
 =?utf-8?B?L1ZEaithMSt3UXZPbTN3d1V5bVdsK0pQY0VrWUJWUjVDaEFwbEFZdHkxVGhn?=
 =?utf-8?B?VklLSXdYSk45Z25sRVV2NFF3VkY3ZGpoQTNxNS95bDBtVnZzN0xqM2VjdVBC?=
 =?utf-8?B?YUZSME8yWlhmTks5eXNhQnl1MmM3UW1PQjFrWXI4MDAvaVQrcEdoais2YU9q?=
 =?utf-8?B?NSsrQ211VG9TM0E2ZjRCYkVaUGhZN1NBSFdqeFpZMnNNakpVbkhyRTg3ckpy?=
 =?utf-8?B?SlA4UVJEK3FTNlNlT1VCNTJpRjN0Mkc2SFJ3SDlJZEcxZkNiU280by9MalZt?=
 =?utf-8?B?d1kxb2s1V3luc1U3L2J3aXZ1RlRNZHhhc1htWXJzSTgydjJyTFM4d0NGZ2Nr?=
 =?utf-8?B?M24xTkV5TEJDY0tucUxaYnphMjYxNm1VU25HRVNCVENXQlNBNThjYjVXdTFC?=
 =?utf-8?B?bjRZcUtZWE44cmxneW1TVVk4ZDB3Nk9NNEFpcUVqbzJiaTFBNW1sbUdqaGhT?=
 =?utf-8?B?K1ozM1dTNUt2T3p2WnhMajFFYWJzVVYyQkpBeUFHZVE4UU9LM2hwTytZQmZD?=
 =?utf-8?B?c3U2aVFkVGNySGhEa1ViZHhpNVZMeWQvc3k1aVlsYkMxcnl1MG1SMFVMYXB3?=
 =?utf-8?B?Vk9VdGxsY0QzNmFzb1huMFhhdlhsTmJjQWNCMlhNOU5RRWVpRDBDdFhGTUYw?=
 =?utf-8?B?aUVOVHNaV3NrV0lYWndYN3lUblNxWnJzWVlHRysrNndvRnFXQ3NBTlROY3ZM?=
 =?utf-8?B?L2U0Uzk4d2lEVW1UWVFMdWFFbVUxZFJyOGpyTzZpMUViRzV2dmFkdzh4QVEr?=
 =?utf-8?B?QTBHZTdXU3dRWjR4UGZ1bzlFSTJTc2t1aXcxMm9EWVNpK0lsVTJqRkZwNlBL?=
 =?utf-8?B?Wko0LzZKVFlsSGROU0NjTDFuRHNuYTd4SnRNNFcyTjFvaHhaWEIzZ3NneE5U?=
 =?utf-8?B?VmVKeXNCMm8rT2NXeWVwWDI3SWEyME5UdEFRZEdjSzhFZnd0dVZaWEUzWkly?=
 =?utf-8?B?bmpydkVkZ1Fib2p3TFlRNmluSEQreGdzVmlWUDU2a2pXb0x5ek5FQlFnNC8y?=
 =?utf-8?B?SU1mZ1NJaFNiRy9TVDBrTlhjVWpwNVFjOE0raUU5cncrOUtCdGN4ZFdBbzE5?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 356baef7-560a-4254-9ada-08ddc561fdd9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:44:41.9485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWhB8IakfCqwYwAuejNMrpRQPnvCiRzkd4ZtLH1aIXk7AhtEs+R92nNTB7WdFsrrW/7twOMSTD/74v+EaPb3l692yIR/dJ04rWUF2rSCMUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9507
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> The cache allocation and memory bandwidth allocation feature properties
> are consolidated into struct resctrl_cache and struct resctrl_membw
> respectively.
> 
> In preparation for more monitoring properties that will clobber the
> existing resource struct more, re-organize the monitoring specific
> properties to also be in a separate structure.
> 
> Also switch "bandwidth sources" term to "memory transactions" to use
> consistent term within resctrl for related monitoring features.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


