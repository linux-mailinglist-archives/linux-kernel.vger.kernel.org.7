Return-Path: <linux-kernel+bounces-751266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338D4B16714
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC5C7B25DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B2282C60;
	Wed, 30 Jul 2025 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igJjFDQX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA6342AA4;
	Wed, 30 Jul 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753904907; cv=fail; b=WOUFuPNTT8sG0HIcoG1toB2o0wjJdxxT8mLR/ztQKtC7daioQCWASJTtl43adv6oL0i6tVhtLbXP6OwAAHV/56aJeaD8fQfKwccs+qdnrXB8OwC2drjM+V58EGSaQZ4S5xu2AxjxBxb8LkjTyNPBh6vNwHV7JvBW2BZc7Jr3ZLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753904907; c=relaxed/simple;
	bh=3rNzTicE/DW84FYHs4Tc2IY5To7Trixnn5Z+XddyWts=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kn8Q6BzXFACREqmGv43pVR1BSvKYz2GJOAi8TzWb3Y/ExXce2Y2HP84WDw8VnvW0iHaPd5NDjRpE99YstT5IJINrjkZ30McfzG8mlyWxBcP/H97HikcmYdI3ImsvtZjc2xwy396XxzfEIvxIlSKon01FXFCSD8JJNZ1NMrMqHFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igJjFDQX; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753904905; x=1785440905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3rNzTicE/DW84FYHs4Tc2IY5To7Trixnn5Z+XddyWts=;
  b=igJjFDQXKBb6LAO7Sa3rgn1CBL0zYcUByOA+wfGItCtoyMDWOvBe7lWv
   ezTU1zF153TbH3iAEPgD6IY7MlooL3EVg5raIJ6Ix5ISTxrKXNvAviDJo
   5ullntbEZRCHQkStzhTCGuPW4eCNqufq6fTYk3xAxBs8deCEWjq3FD1Ka
   FLf+x/J4EC6kuUQjJbUWBbopHtHSmiFFFsb1ewlgRHhfw09pV5PWxsEvb
   Lb8Nk4De2mG1ev195l+n1fS/OqgRI9NFTm/E1yXO7xNGLHO+ga3ZLYrPE
   X3njqiSHmFe+uRcJaF2pYK3o4isCkAI/nowoTKjKJOGsGoMqFXiSZi7hR
   Q==;
X-CSE-ConnectionGUID: aRg4qtgcQkeZ6CYRHNDgTg==
X-CSE-MsgGUID: jg2ceApcSsKDXSmAH5Mqyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56150249"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56150249"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:48:18 -0700
X-CSE-ConnectionGUID: Ytb7r/anSjKnB8yPnDRqHg==
X-CSE-MsgGUID: SAW7zByHR524Nm9PHZlUsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162334834"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:48:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:48:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 12:48:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.75)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhqdGUaf6/efsWDPz6SaTdVgt3Az+ZwdzAlgB+L8sq6cqRHQv71rxCyQU8BhDhXbYVyMDEA+JeZ8I/tqaB+zPe877lzCjhJ2XM7sV6leQqTYFcFONuXHoJTdwuuRm6Do4sn17RLN8R3ZvOSld3a+gHaDKZVbps3slIz7pZoGHlaI7fCC8wyYK6Q5yGs5Zx8lNuYIhw0OCIftECam0eG/FMZ80Q1noUAFpD9OmQ/wujB7IpMg0FDJ83Qr5OvjvhMaGo8nRdtNZF7eT03D6JfCQkjLNuFeox2qYvmtgX/rDtBISQZ38PBfczTrEC6U//VjJySdyiJi1nK2SCXkRn7eQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TbkzSa6UoMx7kPvSmoVTA/P3Nr75rPBMUs2o4hR6FM=;
 b=ydF2GfhLHlAhq7dxifz/rHD83Dvc5fLv3qid15mxgTkmj+5nXyfnRbZqS+zuQ2KexMXjru0leBNU7cTuub1e/y+r/zYGK9duP6uADz7zSxMw+kvMssuDhktOK/zSiDkcBlnrPu7W26HSQHT2TrBX5LKNsD+VOViTW6OdYUzX4eN78YPceaKdnn6ESTq72vR7dLtNCxjk6dwMIH/zqaKnm+Qt9Cxzs6D4WzEMhej8EUMYBaNJ4AX2lOCWUdYDPCdvD7i8KywGobTeIyKNb1dFp9VX0FnG335PNZahfcx1Ic8sZDooA2CNH3byGh2+eB+P+7AGDehp1+3CXct7zBTEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:47:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 19:47:53 +0000
Message-ID: <17d1a9b7-e245-4791-b278-3e4b7fc1ce84@intel.com>
Date: Wed, 30 Jul 2025 12:47:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 05/34] x86/cpufeatures: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
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
 <e91505328b923e478d3d82141ecaf54ae4c06022.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e91505328b923e478d3d82141ecaf54ae4c06022.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0342.namprd04.prod.outlook.com
 (2603:10b6:303:8a::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b34472-bfc8-4f7d-a495-08ddcfa1f91b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDVwa21OckhSVlN6cm1NeFdrU2VJWkk2UzdTbitMUHFiajl1a1A3SjY5UXJX?=
 =?utf-8?B?MEJpcVRPbWliMS81c29NZUJ3L2J5MG03NVRFTWJUTXdPQTc4NnZ1MmtieVlj?=
 =?utf-8?B?RjdTZEpSVmt4cHZBOThFRmtBa3FHMk9PbFlCTjl1K2hoL01ZaTNQd2ZmNFZk?=
 =?utf-8?B?WFdUQ0FxRUxaaXRMMlUzMUx2ZFBWMXhJdUpHRE8xelJmUVF4eEtLSmIrbDVK?=
 =?utf-8?B?b1NtNmQ5RWJtRGxKbWtuLy95VlVvU0xZK2I1ZjFmUlBGQjlhaEsxWDFWUGJi?=
 =?utf-8?B?akljTnk0VTBwV2dzczdKQXppMWhKb0JqMGV1L0hCQ3dNZzdKdWxRWnE4MmR4?=
 =?utf-8?B?dThpRjFtZlEzdmxKaS8zZ253ZjlzcGxsTXVHb0FTczJDaWpxT1JYanlDTVNl?=
 =?utf-8?B?cGNlT3lNSUJXMk9XcWx5R0dmdGV3VUIwYmhBWVdUemw3eXIxdHFlbllnc3Vk?=
 =?utf-8?B?Q01TWWM2OGg4cjIxRnF0V2hUWDdZdkFieCtweEVIUGQ1Wm5jejFMSzdhdzhZ?=
 =?utf-8?B?bTNwSThmYXJhaDB4d25RNkZsSWN6ODljaC9HdDdHRSs5R0dZa3dIRVJoRGFO?=
 =?utf-8?B?Ny9ramNDUWFsOVNoZ0lFZ1RTeEJlb2YyY3dMVnNsSXJnV0J6NFA0VC9odUx4?=
 =?utf-8?B?ZlJsRlo4Q1E2eTFQaVdYeUk2cDJiajlTc0EvVW5kMHQ1RVVEeFEvSTVxY3JV?=
 =?utf-8?B?L2t3TkxCNnFYb1d6T1pjcmZLOXdXWndzM3piZ0NZWFM2WW03NGdTMlRGQU0r?=
 =?utf-8?B?MDFKU0RRaExLZldCeXk4cVF2dmJ4b3lhemtMYm5MeGVhcjBJWmlHRmFvcDVB?=
 =?utf-8?B?TWNOVi9Ra3d4NU5NQndTZnVVMXFMWjRTbi9YZlB2THgvV3pzRmhTdlQwVFln?=
 =?utf-8?B?bTM3TGRTK2hjb1ZRWVYxQW5MSndZV2ZVYk5hcklpVWhKOGZJZlpWb2JpQ0U1?=
 =?utf-8?B?TzdMQ1l5TG5sRk9QV2JWYnRPanRKMDJLb1NEckpqRGpFZjJkU0ZKQ2xlc1Zv?=
 =?utf-8?B?dUJJNUxlNk5LbTBwRG9ONXJpTHhOendUWXg2bmRPL2FJdlg3N3kzUGRrUks1?=
 =?utf-8?B?SzNYdG5UQ3NXUkIzV0hHNnM3RVZmZ0tKNmt5aE52OHEyb1FtNXhKNlB2cEFK?=
 =?utf-8?B?UEp5WjJ1a1BwcU1NVXZuUkZ6MDNsRTJTb2hIcXZndWtwYzV6aXBXdVNYYkJ2?=
 =?utf-8?B?V2dwMlNETXNvRmg4T2gzUytRMS9ZSjdXYUZ1c1JNN0RnNE8zdmsxMkVacjVP?=
 =?utf-8?B?TzU4N0pCZmdVL1NNbGR0MW4vV2tCWUxWNVJlTCt4enZIalF5SXY0UDZRVHF5?=
 =?utf-8?B?ZUNUclZHWjQ4alV3OVltVUpDeXhFdlFxa1JvdC9MWDk1Zmt3RklPL3hrSW5B?=
 =?utf-8?B?c1hFdFlnMExUOVk4bk4wdkZpTmY3aWt0M0F6Y3J2Nzc3dEcwZ29CdXJyWlo4?=
 =?utf-8?B?dXFKMHFMelF6MUE0RlRrcHkxK2U5ays0UkNiMTF4MFlrS2VtVkVCMWNCTWRv?=
 =?utf-8?B?cnQ0VmF3alBkNjhpajJZZEtiNkxxNkJFckZkSjhuUzhFQURsOWRWcG5MWXNG?=
 =?utf-8?B?TFBXK3V4Qnp2N1F0Y2ZzTlJEeEJpMSt5ZU5TQUJuQWdraHpUekRMMmZML3VX?=
 =?utf-8?B?RnBhZ3o0RmdXY0FOQk9XNFYzNG5CQUc3c2tWQTM2djBHTWY3UzZ6Ny9DeXM5?=
 =?utf-8?B?aGp5MTNGUGlZbUhLNUpwMmgzblpVdVdXcUV6NmdnSVVJL3VQRmhDRnpBcEh1?=
 =?utf-8?B?RFVRcE5OUHAzdTNraUdZZzAzMjJZOGhVc0JLTkVOU1E4RlhOaGlvbEN6S25a?=
 =?utf-8?B?aU5qeTdIRlpBZGw5S0h6UnEwVU5kN2MrTkl4UTZSeTVvWU1KYWlhWXZhUkJY?=
 =?utf-8?B?UXZhY2t1bUJqZnNmRkpWdVpYRDFhVzk0TVA3MEg1cXV4N1hxWHA0cHlnNUpQ?=
 =?utf-8?Q?YNrXrdFVpls=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkNwc01jdzVlTUxhSVFxMWg1enJpbjBxVkQ5M2g4cjVZdzR1UEdKYytzNUZr?=
 =?utf-8?B?R1ZqWlNBMVNpbTFPSXlsaFo2MFhiWjdMVXFhcjAwSTk0U2hadUs5SGlzYmJp?=
 =?utf-8?B?SmJ5NkV2Z3Z5c2xYc3BPNVVGSWMyRW5VN2VjOGI3QzJxK2dBNVVWaGxJL1dT?=
 =?utf-8?B?SHdPdFEwWjdVcGtoaW5kMXlGRlZqVTFjS0dtaEcwU2JSQlpZdlExcmg1dDR5?=
 =?utf-8?B?b1hRRloraDUwR0FrNk9kQWxsNVhobGtqVjJyOGFRQmJJZ1pScXVDdndQQTFE?=
 =?utf-8?B?RHlXNWdPSElUYzFPclhoMkdDeDR2dVdabGtBNy81VVh5SmVRZG9qcjkrS0Yz?=
 =?utf-8?B?QVpXallmTytGb29TbWVUdHdYT3dpSUdXOGhOOEpNOElLS2NGUXk4ZnhHM1Ri?=
 =?utf-8?B?WnZiWHJUSGNQNW1EakEyRGJpK0FmbDZtZ1ZoSVVMSUJmOFlMZmFYS283QlJZ?=
 =?utf-8?B?cWkxS0xOOTN6SUxieUJXTUV4Q1IvVEoweDl2QTYxYWp2c0M1M3crMC9LVXNN?=
 =?utf-8?B?Z0tsOVpBUlZuUmdUT2RoVitoTjRkOGxySlVTZms1UmJsQTlkcGw3eGEwbTRD?=
 =?utf-8?B?bFJXWHRkdEJUWldEdkRDWUNCZG56TGRFZ2x3dnYzK1ZHcUs0RVc5WG9ydEFS?=
 =?utf-8?B?S0lJdkRwTkdZVVYxbDNPRDk5bWdqTlMwYXlFMGFCVEtkWmJ0YU5HNzlTQ1Vr?=
 =?utf-8?B?aEpQZWpiS3IwSzV4enZsWmxVY3pwVlY2aDVRYzhLY2YySS9CcXY2S0lMUTVC?=
 =?utf-8?B?bDdWd2tyYzBTeldvbmpVMHk1TkpKYVVBN0UxbldtL3k3OG5BYnVXcFhnak5P?=
 =?utf-8?B?c1NaS21YVUhVQkJVT0FIdkZab21wV3pVQ0g2WXNUOFJIeG5La2FkeUl3WFIz?=
 =?utf-8?B?d00wZ3BRd2FBYitxd2MxRHFmSVI5djJNYjZSYm9yNHdZdjI0OVRiR01oaG1G?=
 =?utf-8?B?VVhodFFmai80UDljcVkxK29IU2ZOUzVMRC90eEtLY0lZekpKV2RySlgrcGpR?=
 =?utf-8?B?U1hLalhqMmd4c0svUWo2RTQwZEIvZE1BOFBGTWYyckZJR1RuZFNRa05DV24r?=
 =?utf-8?B?QXQxcjBGbmhKbWdHQ0pVWE1YRjFMS1ozWHA4SGFkNTA2c1BnbkNKZk1BcW9I?=
 =?utf-8?B?QmI0NmJTaVFjMy94Wm1qdm04SjhvT0wraXU0YWZzaVdkWWlwaDEzeFNTaEJm?=
 =?utf-8?B?UlVZZGhwUTcyQW8wRHRrQjFoTmtJaDJOK0pRZkt3clNSbGg0Vkk2QnVTL1Zz?=
 =?utf-8?B?UTZUQmhZQWdGbFRsV1A1ZWdJN1VVQS8zN1BXOUVLZHhFYWxtRW1Fb0RDNXJn?=
 =?utf-8?B?QzlNMGsrOVhDTy9DclY5YXA1NXd5RytXbEJlWGYwUjJiZ0IrMU1XOEJMMnAv?=
 =?utf-8?B?VFljcGtpQ3BqVHZyeTZ6V0ZmUGhTbEJCaThoSy9xdmIyRFpPL2RjVEJaOG5v?=
 =?utf-8?B?dXVsYm9SemdDTVhYYm1RRWhhcXJuVllwWE1SSEVYM0tKbm5DNlNFcXFodUlh?=
 =?utf-8?B?VE5vOTJOQzhPVjYxdzRsRUpOL0Vvc2FmVVNaQm1ieUNPc29scUpXRXBsdXZQ?=
 =?utf-8?B?ZWcxbHIxN3VlSVl3cW82TGRsVnFMVW45S1Y3R0w4UlBZMGIrc3VVUXo3akY5?=
 =?utf-8?B?YVUyZWlVVUdKMjE3akFSbTJ5Y1pMOEpYcElxc2h0Y3p3cldJZVUwQit2bnhN?=
 =?utf-8?B?ZWtZTTJ0MXdWTTVjelhycHZrSXllWVdvNHluS1c3UmVUOVJBSkVBZDVUQmpC?=
 =?utf-8?B?Zi9GeVFrSEZDcjB3eE1WM1Q3NWw2eTNWNmNhbVFIMlM5M2xLZUNBOEN2NGp3?=
 =?utf-8?B?OGgxRVFyUVREek9keE5BczdjbUxHMHZWK0UrZG8zdDgwK01vRXpLb28vQ1Zz?=
 =?utf-8?B?aGFvRnhqc2lRN3hBWmxycmpVSVVIaEQ2dWN4aC9WL2MzaCtQcVBpcFN5ejd0?=
 =?utf-8?B?MWJjVlBxVTZiY294aVNmL1hTZFpyQThTakIyZnBEUGtuakd3RWhRSlV2R3gw?=
 =?utf-8?B?OWdTa2tJQjV2K0E2RkhTcFpZLzRjM0hpOHphZkE0Tmk2dVMzVjB6SG16V2Ry?=
 =?utf-8?B?bXVTUEdQU1ovTTlMb3l5d0N2YlFZVElCcjNvRkc0NS9jbDB3dWlKekc0RDJB?=
 =?utf-8?B?Q0p3THJZRExES3RhZG5lU1pZcFpXdjRDNmV4MVNxZS96bnJGOCtYU0RXc2Qr?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b34472-bfc8-4f7d-a495-08ddcfa1f91b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:47:53.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Js95gYLUOJHk60Y5xK8Nqu76H+T2gbE7yrqRletc3Xi4p/B2FPZMsB8mHY8tMgMB1s5Zov+qm3OXdEtoZpl2CzeB7npOPBxpGvKC7dV8FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6422
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> Users can create as many monitor groups as RMIDs supported by the hardware.
> However, bandwidth monitoring feature on AMD system only guarantees that
> RMIDs currently assigned to a processor will be tracked by hardware. The
> counters of any other RMIDs which are no longer being tracked will be reset
> to zero. The MBM event counters return "Unavailable" for the RMIDs that are
> not tracked by hardware. So, there can be only limited number of groups
> that can give guaranteed monitoring numbers. With ever changing
> configurations there is no way to definitely know which of these groups are
> being tracked during a particular time. Users do not have the option to
> monitor a group or set of groups for a certain period of time without
> worrying about RMID being reset in between.
> 
> The ABMC feature allows users to assign a hardware counter to an RMID,
> event pair and monitor bandwidth usage as long as it is assigned. The
> hardware continues to track the assigned counter until it is explicitly
> unassigned by the user. There is no need to worry about counters being
> reset during this period. Additionally, the user can specify the type of
> memory transactions (e.g., reads, writes) for the counter to track.
> 
> Without ABMC enabled, monitoring will work in current mode without
> assignment option.
> 
> The Linux resctrl subsystem provides an interface that allows monitoring of
> up to two memory bandwidth events per group, selected from a combination of
> available total and local events. When ABMC is enabled, two events will be
> assigned to each group by default, in line with the current interface
> design. Users will also have the option to configure which types of memory
> transactions are counted by these events.
> 
> Due to the limited number of available counters (32), users may quickly
> exhaust the available counters. If the system runs out of assignable ABMC
> counters, the kernel will report an error. In such cases, users will need
> to unassign one or more active counters to free up counters for new
> assignments. resctrl will provide options to assign or unassign events
> through the group-specific interface file.
> 
> The feature is detected via CPUID_Fn80000020_EBX_x00 bit 5.
> Bits Description
> 5    ABMC (Assignable Bandwidth Monitoring Counters)
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


