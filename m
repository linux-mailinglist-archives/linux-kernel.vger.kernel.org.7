Return-Path: <linux-kernel+bounces-751287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D39B16746
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA78D3A7F40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B181FFC55;
	Wed, 30 Jul 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7h0A9hT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5B21B195;
	Wed, 30 Jul 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905642; cv=fail; b=MD4c8ptxcRQuFNobzVaOySnyKS5MAZjIQ9HZj6Af2V2tVsaQgVUlVPyInKZmzrx9LqeadLPi0k4vCW/DWpYtkJeoO6fnT9JMtjX0Kf+7v4NbkUmojahkFUDoEMAtYr7GnJi0WdK8FVBMKc82WHIe6uogRXwLgN8zEhkgLIGjm4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905642; c=relaxed/simple;
	bh=sSke/oNED4Ysrr2sdP/PABMWjtTWOypwEoAE/znogZI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DvUVrdIv0mia/EpxS10yziraJLBX5ref1apdFAp68eoQTjIKhDnge31IjNeWqGtNYiXXUbo2BEIMqljShRo1jsGeU9AWxNuKLSRl1EhlkIUpgg5Lzn5TyDU8wvb3hBoIHHamwW3Y4r8ESRb25pLu3oOdwAu0QJRgXQm5a3haSs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7h0A9hT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905640; x=1785441640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sSke/oNED4Ysrr2sdP/PABMWjtTWOypwEoAE/znogZI=;
  b=i7h0A9hTslXcPXw2izhr0PwT9F9yJv+Y/eGAz4XbgY8zYWYMwQAB0g2N
   bkoZMrkOs4n+FFyGOy8Aipn1EYVmeoV2B86qgt/sykHwePP7TXuQQzsjt
   RJmoWIDSoS6fpt9dM9qoHDNVefvz8szYiXL3wrLCxNRkAEt1LnxeX6qCe
   ST9Q+w4VDTsDDMXH9JvThaIwedKEd4hI0Y3axMjRf2MxLjqeATPojVuRu
   4yDq2qtfaKUVJovtF4Mw9VeSxLm06VGr9D34tMjet829VBM21VVIR2HQ+
   Rn6RQMNihL6nMXGJq9rBwm1nuFiC6kRpeuU0LpXCOx/Fu6HUK+Rg+kxn1
   w==;
X-CSE-ConnectionGUID: XDlhOjh9RfGpRuA/mJ0B7w==
X-CSE-MsgGUID: jRjFIPSmSOiSKCoLzhGkwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55920112"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="55920112"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:00:34 -0700
X-CSE-ConnectionGUID: VsseLZIpSj6bvLaUdU4XCw==
X-CSE-MsgGUID: mkRQ5FCKSzCxjFpRNExIVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162356015"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:00:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:00:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:00:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jcu4XJIir4IqaPa8JlnbSeHzv4EqzdOCf0A2eS1ZDHkXcI8BE+wbYOiVcWCRINFqkbNK9Up6PDKVyrktUG9VPqXqh90s1PiHgMt73zP+moghvH2dWmiZB7Sk57ekZwac8irct26AzIDGDiA4fcepCgjyXCfR8GSkxP41QXgkRwrEPvNo/0uet8m1iKkxIVkwzrEAoBOK5W9T56odBKNN2w5MfkYfA1BbMbqAU0cU1eyOzP0UvKpPldT2TU0wUYCvTlggugjYtUAhdWhOHBEuOC9PNkKDcLjF+hq9yZPdlMaaz/prECW27F3YgJSd9LLCM69I/UX9rWoI1Krs31B+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orXxgxzfGrQw9LNCz0V0mi+c7bXRwHKuGaGDJIXhhvE=;
 b=bWxJP8jkyu4J58jsY93pFnwC4SyXwYg7F0vag54vl5bQ8QQtVMMOE0Z3DLZYumm8/biFcPMknueW4SMlnlb3dwHXJU/7pZNFD7qti7FZyNWiLWqgi7r1pD7M7OAgpU1/O0MUCpRjYqMybvOexTahm+MMChfAlTxmSZn1L8cqDA/cMvGJoFBH8Ja7RYDF26b5/gahlK8k6NdqUgtUF+JG8aivKOB6gWH9dhA+gIzv4pao/DmhOa5vTk5kFpsC6fTvnJ2tfUou4VROQjRqSoWxy5bsBt7nvxiuLWZG1CJwvDi+c/9BihnJ2O3tvSUVS+qCVgKrYz1+ASF24GYAdsWelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4852.namprd11.prod.outlook.com (2603:10b6:303:9f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Wed, 30 Jul
 2025 19:59:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 19:59:49 +0000
Message-ID: <d1ced272-a72c-46dc-9966-5d3a9e28103c@intel.com>
Date: Wed, 30 Jul 2025 12:59:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 21/34] x86/resctrl: Refactor resctrl_arch_rmid_read()
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
 <451c774e1865d53664f5eac612570f753679024d.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <451c774e1865d53664f5eac612570f753679024d.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:303:8c::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: 067470ea-82e5-44fc-59c3-08ddcfa3a3f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTc4V1ZqbncxZHJYdlYwSWllS2l5SVc2WjFOK2NkblpyNml2cGplZFVDbEFU?=
 =?utf-8?B?YStuWnl5Vm8xdnY2TzNHR2t0MnFpZDUxZGttdkhuM0xSVDlrNDZkVUhXdnZW?=
 =?utf-8?B?d3V0endGMWNLUnVueFN1ck96NFVRU2xjcml1WkNaS25NcUhTQTczLytNOENZ?=
 =?utf-8?B?ejFEekJxSi9ZMkd3MGF0VkJ5TlhWcDZlNnpaSmhjRFlRVE5JRmVyMUFWRjRx?=
 =?utf-8?B?VllwU0JELzR0eEhSbWdadHFEbk96SGhBUEs2ZUIxUHFGcjBnaFFVdkE0dEFv?=
 =?utf-8?B?cVFnYkZNeTZyWWV3elp3YnVqRlRVcXk2dUYrNlBTRFUzNFZQQnVrSm9HbWhp?=
 =?utf-8?B?SldWb29iaFlYbW9xRU5rdCtaRlBPU1lsanF6YXdiZmtnOXcxaUk3alJPcGZV?=
 =?utf-8?B?elRiK0J1ZFRvL2lIOURkM2FWblNHVU4wNTZFbUU5M0JyamNiTjZJc2E0MDdS?=
 =?utf-8?B?OUpPMEJFY3FhVHVIU2d0N2MwV0pGaDRXbG9uc1dJazF5SEVCaksrZEZ5cHFB?=
 =?utf-8?B?bm1ybnJtS2dDRm82bDVOOVF0VGF2UlFWVjk1UHI4SVdWYk9ud0xNeldxZEp3?=
 =?utf-8?B?QmVlbDlnd0tSREYzU3plV2E5WFRJVGJnV0RBTUVqYVFvbG8wZ1RLWTlzM1JS?=
 =?utf-8?B?ZWNZN0l5RTZpNVFqY050QkwvVmd1MHVJZnhVNHQ4cTdQcWZoVkZNdGtrUGQ0?=
 =?utf-8?B?R1oyWllsMGxSZ0J0bTFmQXBWSlIvL3k0MlF0M05QTmNvUHpOenlIUGtEdFBp?=
 =?utf-8?B?QUQ5bFY1MTB4eXVLaDA1RDRYVTJveUgybXF0M3N2cWh2UHdmUkZ4VmNyajN5?=
 =?utf-8?B?N2FrVTdVbkloKzBnczJDQlE1K2VleTZWaHVhcjF6MVRPUUZDc0VJNlVlNHV5?=
 =?utf-8?B?SjVnTTkzbGdNeGlXUkNHemg3Z0V6OHQ4L2tUWTRmbk9zeFRJenVyc3JubkxD?=
 =?utf-8?B?U2JIbHhSTzQ3anpTblNYZU43UGs0TkNHZFVEcDQrWDlWUUdVZno2RFNRTzcz?=
 =?utf-8?B?azdZVWFjU2dwN2xTcWpZN2doRHNqZmZjNUhsbGhFNTloUjVKd3U0a3gwWHZV?=
 =?utf-8?B?ZW1TM3hvYUQwTG50WENmdzJyRGZjcHBrYkJwZ2tVWUtEbnNiZXRoNkRHdCtE?=
 =?utf-8?B?VkJ2V25GS3hXUUhoNkJBWjZKOTgyak1EV09SaWd4YmpzbVFnd2IyOXlpdEtG?=
 =?utf-8?B?SDVMMWZtRlhYWEJpQjlIQWQ0Q0NoTEdPZHI5QW9weFpXb2YxRS9Dbng5cFNP?=
 =?utf-8?B?Y3FPZjRPUGdqbDhtNnFwUU83YzVRT1FJaGcrS0dLYXFGd09GY2xaK1RMdU9C?=
 =?utf-8?B?R1AwQ0tSR3RERmgvZjhBbUFQZVNkcXlkbmN6VUkvV0F3NW83VzJkdFJLc2VM?=
 =?utf-8?B?eEpPOS9FNmRzbHZaSEJWNjRMc1ZyUWRiRWlmVGJGMStUYkpIS2FoUnJGU3h1?=
 =?utf-8?B?YXNVek9reWhDdHkrUElON3hqMkd4R2lCU3lyTGxJM3dYR3BFTytRQnZLUGhP?=
 =?utf-8?B?NEZQWkp0c1VwUE9qeHA5LytNUytwOGZOQ20wQ3g2bXZlTi9qcEQ5TFNVcWJJ?=
 =?utf-8?B?ZjFrUTBMRjZSM0svUno3V2t5VnN2Z2hET29EdmtQYWhlbndxR0g2dkQrbGMx?=
 =?utf-8?B?ZjE2Vk1DRUFtQk1OcjRQUWlTODF1TU9uOHBIWk9NOG9KdXJ3eG5qS1pVaDlv?=
 =?utf-8?B?bVR4NzFiOXhzTWR4djVvSHlUM3VHTG82LzJGUk9IMUhOenlpR21MZnFLcFZS?=
 =?utf-8?B?L2NzVTAwNUxDQVpIQlZjL1o5dFBlb0RFZHNtNGVIS09lbmhibm9ubkpFYTh0?=
 =?utf-8?B?UmtlalJiTE9QV2pUK3JSSEdHazBweU5ZRDAwbWplOTQ1MnZzL2wrWDVCMHpL?=
 =?utf-8?B?MVlObjF3V3EycWsyRGdBWXZ5UDlldERnQVFuYjF3NTNrbEg0RGRBeDZySk9Z?=
 =?utf-8?Q?XVByulBzOfw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGxiY1c3dHdXMWRqQ2FPNndzck5UcFV4NkhrODJVRnU2bDBEVVlRcHBKcnRD?=
 =?utf-8?B?SkxCZHBucm4rSkRheUU0eEtsRXNiTnhmNFZteVV6Y3NvRlpIZFA2bnAxZmJF?=
 =?utf-8?B?Mi8wS1c4TWJlV2poY1pEZXAxdzNGa1FBVnQrM2lFRytGTEFTWjlZZUk2Z2Uv?=
 =?utf-8?B?MlpaTUxULzhIQUVqY2pCRCt0VFZLSGtMaWpJRUtCZ25nNE9zUmJXWHJPNi9a?=
 =?utf-8?B?TXNHQmdCNHZkLzMzVXZXK2JsOGRqTTFyTzhYSk9hVkZLbDgraFpvZS9ZMTdq?=
 =?utf-8?B?NmlSeHcweDB6VWRQUXlrZk14dW5SRlFraW0zc3NsVk1ReHNEZ0NGeGJsaFds?=
 =?utf-8?B?d3YwNlBTWFRkUFRFaDI2dTA5ZlA5dmVDc2pGbml4WE5iaC85YjBJM3dZUzhU?=
 =?utf-8?B?OEhCT1FQNk5yT09XVFk2ckNRMm5Vb2dtbnZhMnBpZlFvcjJvbExVQ3RvKzhm?=
 =?utf-8?B?Z1pwWWgwOVVIRkRENFZUemZjZ2IySTdGempWUndPQXNBVHI0dk91MitVS2g0?=
 =?utf-8?B?c3hoM0Z6TWxQVUpXUU8yZGgvVWpOQ3hYdCtVM09wTGRCOHJ0SGJUVUpUTVNz?=
 =?utf-8?B?ZEJSeFNFRXZXWk5uQ0JVREZtM0dEc1V0dFg1Q2pka08zUWtuZzFYSWRWbUxk?=
 =?utf-8?B?Wm9MbmdWQzUrZ1ROUFpXeXlKMzVUckNpUktPNmNyNFFLQUdjTE1aVjBQMTFa?=
 =?utf-8?B?Z3dxZnBRam9XVktYK2tlcnlsWWpMeldkQ2M3dklJUURXY2NaN0NVK1R0ODQx?=
 =?utf-8?B?SWlCMXl4TitJdjIyNG9FNVhTQkgrUFFTd3N6S0xwMUd0SkR5bDFsNllBVFBx?=
 =?utf-8?B?MGRlWW4wLzJzdC84S1FVZWVPOG1GblliRm9NMmxwcCs2bHNUb1ozZHVPdW9k?=
 =?utf-8?B?UW1yejZwaWhkTDRuM0lqa1AxbFpkSldMbW9GcnFFdHBxYitKaDN6SDVkQ2pj?=
 =?utf-8?B?RHRwR1hibDVvc2N5dzBEZzBaaHVkVjVVL21CV2hZTUtVTnBMREpvSkt1OC9r?=
 =?utf-8?B?a04wOGRWd282ckZpNUQ3RGk5UE5kZEpFQjZKMHg0OXlqdUdRcEZINFQzUkdh?=
 =?utf-8?B?QnpCVUdkWjlvQjA0cTArZUp6UTdKaEttTXpTZlJJN056eHFlYUNCQ2F3RDF4?=
 =?utf-8?B?SXRsbit3bCtvUGMxUDZia21RRmN3UWV0TURHTFV0NHRHYUlhc1BUZFYwY25l?=
 =?utf-8?B?Y1RsRzBKNU1NbHpLVUhicjRTbDJDVWc2YlRtVkhNUzJLN0JrT2E3c2pta0Fs?=
 =?utf-8?B?Y2xvRm91NWJ5d1hpSDFSbFN3bVcyWTNSUUxSU0loU093TFpmMEZqRWNMR3hU?=
 =?utf-8?B?RUZad2hMQnBUN1ZETWU3My9ZcnVCNTBaK25LeUx6NEZFc3U3SHZKdTQ1QXJh?=
 =?utf-8?B?amdLclBSb051SUFpc3I5NW5LOWNJQmg2WGJ4RXhwdDJoWVJQWFJjUExvUXRu?=
 =?utf-8?B?aDJwMlZobGZCK25raHZUbkQxSHJmL0Y4OVIxVmM0OVd4cjJHMzdzUUNrT0tl?=
 =?utf-8?B?RXh1dE5NcEpMODdSL1hEdHhCQkJZMnkxSkl3MHhUc0RML0RjL0pXNU9Qa0F3?=
 =?utf-8?B?N2NaYXo4dTdIeE1QTGFlTjY1RGdjV1NGYnpVaU0zbHBXajRaNUZXNmFqUEFs?=
 =?utf-8?B?NXJJYkoxZlR6WGFVNG1MbXNlZlExTWh3MVJmbFJLRnRkbGt3NjBaNjY4amN0?=
 =?utf-8?B?Y1lIVXlPbkRRenFNbVUrOS9HcXpDM3EwMkZFTWhCd1FtT0R5emdEa2hVaFNq?=
 =?utf-8?B?S294STNVaS95ZHB5bTgwWFpyZkRTdjQzKzBPekR0QU5rZDNEbTMzVUdPbjFU?=
 =?utf-8?B?VXNVaG52R2ZzaVVJejEyemlqeFI1N0U5bW5nMFpDcS94NnhKVXZHenFrVnND?=
 =?utf-8?B?Yk1BSDkxaVpocGZFUnFMUzhXTDZ4U0VhYlNJeUhIcU1KN2tpR3dobHhYUDdQ?=
 =?utf-8?B?TDVlZ3cvRythNjR1dlBwcTF5b2hIUUxhMFlFZFZZSHFMMUp2WTRjcmJJNlFx?=
 =?utf-8?B?MzFXTHk3bHNGM2dnSU90b3QxWWY3ZDlpbGVXTW1jaG1hR0VmZWo4R1kxcXIv?=
 =?utf-8?B?Qm1oV0NrM3Y0MWVHR2lTNDNjbnhIUjZ3MWt6UlFpbjYvZzM2NEFITUtrZVVq?=
 =?utf-8?B?TEdaWmJBYzRrVmtuZG91dU52YVZUZmpmOTU2dTJSRTRLZzNVZm1UZTIyb3hL?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 067470ea-82e5-44fc-59c3-08ddcfa3a3f5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:59:49.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RE3JkKrBD/Elh6uvr9/RA3y9LBCsuD/IAkQmfO67AyqXO18NX6kEOYwFZ/d7EljTZeA3RdEjx4eAi0mNsYqZPibMpPOHw5GogBjhOVpHYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4852
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> resctrl_arch_rmid_read() adjusts the value obtained from MSR_IA32_QM_CTR to
> account for the overflow for MBM events and apply counter scaling for all
> the events. This logic is common to both reading an RMID and reading a
> hardware counter directly.
> 
> Refactor the hardware value adjustment logic into get_corrected_val() to
> prepare for support of reading a hardware counter.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

