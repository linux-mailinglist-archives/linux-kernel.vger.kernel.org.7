Return-Path: <linux-kernel+bounces-721881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FD7AFCF13
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B641754A9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B0A2E11D7;
	Tue,  8 Jul 2025 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPXwHzaO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8372E0B7C;
	Tue,  8 Jul 2025 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988123; cv=fail; b=cIxLJHSUdc425vmDzBD+pl4mQZHeyuQiBpzolBpOrNodmaa6KaBmROnC65xsF4XLogIUbtJZId9U9ofbN1dBaz8GAMkkokjDkvtL+En9Re5udsMB35LvOi4AI+KJbx8TgAvAftX3UtcngJ8AcjZEsRyp1ue115W+J24P9gcOLiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988123; c=relaxed/simple;
	bh=2q3E5uGW4ADprPywoHBaTX2F3fQ3JCuIffLh4LI6clw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tNbx0FYv0bQ0tX70ndh/JcFh1yUFhbZrYpPuXcq0s5j6Rh9MhEcWVDI5R4t6BsRuFyqit2e10luCOWS9rnlyLpeUN55POaJ6wefte7fytJ97Y77spvWiyA4TTwYn/1GWahGyid6m9DV0qLtwXK/OouaKSFGu3dCT7iOEjvG1dQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPXwHzaO; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751988122; x=1783524122;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2q3E5uGW4ADprPywoHBaTX2F3fQ3JCuIffLh4LI6clw=;
  b=MPXwHzaOXGRnRHFK2im1SRXm6ly0lW5DaJIqMEBT3aYMcgKy6D11moOq
   /6T3yTuLr+X2tci89SbAJbFzu9llSRzBU4HftGLW8sKKLsWqhXNNUpXlu
   RgSvUISV0tnYOhKDdXi1xm9Vj90JVsvZ1i1hvwDyed3Dhm9w0lCGmSvAB
   DiNQeApHLLxPMx6c51kv7BlbHwmZXSD+ebgXENb/7FfXItF4Z2fQg7Dug
   LgU8IB1MCnydibaVJ4ZdU+uKcJIaRaRdPx/N2M4r8SLd45W2+DjVr8Ta2
   KrVBXXk7x17VEBOknSckjuyWlhrWwv7fvqRCGUd1N5jBFgXvuOQXPn6O+
   g==;
X-CSE-ConnectionGUID: 1+SDZ/a5TIaYFyv+Poj53g==
X-CSE-MsgGUID: cfUks5boSJSm9CPLTHE6WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54205492"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="54205492"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 08:22:01 -0700
X-CSE-ConnectionGUID: P74BeEodTOSER/8reQjIjA==
X-CSE-MsgGUID: p5pBLL40QkmsF5K3zc1KrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="156107508"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 08:21:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 08:21:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 08:21:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.78) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 08:21:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB1aJy13UUY51rfqdzdY/JOumHAEbUUBlozT6l9JqeQB7Y67N0HUz7RrIn2Wh2jLbPg0BLIVNdEpqI7AGtQhT+QkealYJsiPDoRvsKvTefPBv0OTHRTaDZJiyLgNsNoiuYwA5edNL/Pnvb4oN4BX8rndt9RzHLOaSiruHT/DKBGYHxy8aBAAn9HwFtmqEyc/s1opw8sgyvQi6glMbo0nuOL27RLde2K6MIYON6rSYHJLdUEtmhfJv1Q2pZlMj/rT1yBVEuFPX39yyJ1Ums/tZYbSSzw683QR6lfct5CnkEyp9/KRgjtc/3OuF8jzYkEYVYiRS49IMMmNUuFMkdZSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3KsNJoyYz72nTpyvG0Snt0GZ8uOILqdIUFqz80V2bA=;
 b=jTyh7ebnl4Y6BwJhVS3zaZCn9ScmWtzTHPJbYMzHjgdWKoOzXxn3ZTWUd++wMf4ti/F+ZgQv9UEP1KzT3GolwYZYvG43VCXplF3fEb6Iw9eqmbWSkln1NFDt7bqTzJ2J0zMX1PhxHZ2o/ZUlrSKHIjUIXCbS1Nn1GsXTpd9UWyNhzhANoQ2ssKCz5T6nL6Yj6sZoGaffOkpFUgnGBX3ljC1W02OshzaEPJEKY/I1ubHjvKrlBt3cijIaLH1/wHSpsLyMYFuQMmyO1qrWN2TcO/pcgtJrYYB9Wg2UebhWkROYfHw2/6NIto9esvrRY8zm1PzOZMWEGoPA4tbFYGGdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ5PPF56FDAD370.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::82a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.23; Tue, 8 Jul
 2025 15:21:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8901.018; Tue, 8 Jul 2025
 15:21:23 +0000
Message-ID: <16cf9877-cb47-4ac3-bd50-c24ee3522296@intel.com>
Date: Tue, 8 Jul 2025 08:21:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 30/32] fs/resctrl: Hide the BMEC related files when
 mbm_event mode is enabled
To: "Moger, Babu" <bmoger@amd.com>, <babu.moger@amd.com>, <corbet@lwn.net>,
	<tony.luck@intel.com>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <paulmck@kernel.org>, <thuth@redhat.com>,
	<ardb@kernel.org>, <gregkh@linuxfoundation.org>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<manali.shukla@amd.com>, <perry.yuan@amd.com>, <kai.huang@intel.com>,
	<peterz@infradead.org>, <xiaoyao.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <xin3.li@intel.com>, <gautham.shenoy@amd.com>,
	<xin@zytor.com>, <chang.seok.bae@intel.com>, <fenghuay@nvidia.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1749848714.git.babu.moger@amd.com>
 <4769751d1de7c4f66b1c7f3c5ea7eeeb49951363.1749848715.git.babu.moger@amd.com>
 <3c753f3c-e91b-4cfe-983d-efe8ff07b750@intel.com>
 <f85e467a-1d17-4f34-98e3-512679baad47@amd.com>
 <ff314427-1c03-4e26-be19-c5f5090f3d8a@intel.com>
 <471975cf-1094-42dd-a965-f536cf399d0a@amd.com>
 <d5c4d3e8-6d5f-4892-83b5-867ec8bfc97a@intel.com>
 <f8f434d0-1c44-4d76-9121-7c0acc7aa10a@amd.com>
 <2b49620c-f2b0-4994-8617-e436725d0cf6@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <2b49620c-f2b0-4994-8617-e436725d0cf6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0032.namprd21.prod.outlook.com
 (2603:10b6:302:1::45) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ5PPF56FDAD370:EE_
X-MS-Office365-Filtering-Correlation-Id: e83fda2f-13ab-4a38-d7fb-08ddbe3318e0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVNCTXRCM2crMWVjaGp3bE9JMml2eXdrR0hVbEh3SVA4RWNPTGRQMUZZVGRy?=
 =?utf-8?B?YkdjTkllenFhT1M5SG1MV2VDeGx0WTlKRjlXMGpMVDUxVHB5eWZHb0dxN1do?=
 =?utf-8?B?TnVNbkluNVlRL2YzdW4wOWlKa2ZHS2FFVFByVlhJTURVcE1PN25vSythRkRZ?=
 =?utf-8?B?UFArMittU3V3UWFyMUxSZnpBM2YrWEVkcGozcTZrcEZNMGVlWU5PeTZIMTJr?=
 =?utf-8?B?OU15dm1LMGFXV3g0TDN1dFpLbVJiZDRwRWdib0xIbUpUNTU2akw1MXN3ekY4?=
 =?utf-8?B?ZDZ2L09JMksyYTQ4YkNWQUxRa0R4bnlCT2YwYjVUZXU2RmZBNUF0d2ZvN0h2?=
 =?utf-8?B?NmlNbmFSdDFkRGpNMW1qZ05BdEZrUzRsUCtRaVEza2QrZ1Y0emlDOUhUY2s0?=
 =?utf-8?B?ckJMOHVndTZyWVhBUkM2M3Vwc2k0alBZemtMYUg1UUdNZ2ZPUXJCUVNpTzlw?=
 =?utf-8?B?K2VhS2Nub0FTSnlENUp5cU5LUXJzdmxYS2pjZk5SKzZaVlJKVkZ5eXNYeWUz?=
 =?utf-8?B?eWNXQ040K3VCdGhNejdVUGhxQmVlT1FGUVV3QThDOW5kN0s2RXZMa214SWt0?=
 =?utf-8?B?dDVNeitLWkpxMHlCdHhTN3dXS2J4R0ZVMElwSUE5dkVTRGMyb2wyZytVcnVJ?=
 =?utf-8?B?M2dieUN4WHJ0RnBUdFkxSEd2OXdRUENlc1JTRnNvYVN2TWtBWDAyelo5OGNZ?=
 =?utf-8?B?eFBOaWpTY1ltTjN0T3ZIYzNsMDZCMkxheFpxWUlacnhFS0xDdHlDNEIxeXVk?=
 =?utf-8?B?Z05WcmNoSHBqUm1TczRKUzBYbkhROUxSaUsxZitQUXFrcDdVTzdGalNxcURJ?=
 =?utf-8?B?NjFMOEVmdmczYkZJUXN6UjVyN3VQZ3MzbjJ6djY1VjVYZlk4RjlBdk0veDZF?=
 =?utf-8?B?TktKck9XZk9VVmdSM2pVaUFBTkt2M1FvRkgrL0ZIZlRkWnpVYWxDN254dURk?=
 =?utf-8?B?M0pJeUFJRTBoczVRUXJSTExNdHEvWXBRejE4VytVcWFTclE2cGtLS1duYmgx?=
 =?utf-8?B?WEtMdVd4bHd4RHE5M2s5enZja29kYXFuWkFGdlhDOTl4bkZuTkR4dEtlb3lE?=
 =?utf-8?B?S3NoQmJCd3NGR2ljK0xLK3RPNlBoUlJ3bFpPaWtuSU1pSkJmZGZyaVZXZWJF?=
 =?utf-8?B?QldvQUp3VG5CWExCeE9ZQ2Y3Z0RvN3MrUXhpbHdYQW9YTFZhMEllU04rZmt1?=
 =?utf-8?B?RE5UV0hkWCtXSVBVSzA2bElKYnVHMlRqeXpwc1l6a0llTjhIM2ZteUo2Qmoy?=
 =?utf-8?B?TVNuZm5iZlM3NmhZTFpaNUQxMzdoQU9OczR6anJMU1JaMk1mM24vU0lucXc3?=
 =?utf-8?B?RE5lYzBYVStvMDdwcUNNQitjeHp5dkJmS1lkcy8zQzZZT2NrS2FPUlBzT0Fl?=
 =?utf-8?B?U1RzSzk5V0RjN3NCR1JuOW1SU3dzbzBXNmxmNnVrR25GbUkxcnJDZmxsTk9s?=
 =?utf-8?B?a1JVaUszSnVpWWZEelRBcnplek5Dd21wUC9aMkZ4RjZLcHpRd2VtalgvdFkw?=
 =?utf-8?B?aW9hK3c3dEUxaG1PUmRjYU1PTHhFNHNoRmlwT0k3NGVZdmUyd1ZXcmVDZExK?=
 =?utf-8?B?RUlhNXJ2Wjh2cTA0SjU1eXRGNXUvMzVVMHAxa3cvYUtiamxNaGpVQkRyTnMx?=
 =?utf-8?B?M3Ayc3JBT040UkxOSGR1ZmU4eldvRDJRbFdKZUsvam1tbWJYQnlsblZyZGdu?=
 =?utf-8?B?THBKRXhyb29iV3QzbFdNa09paldGRnJDQ25ObUVIMFJ6cGs2SDRpQWdBa0NN?=
 =?utf-8?B?c1V4b2xIbG9rMnk4Y0VrelJQaWxSeVA2djUxbEdPWUlHakF6YVlBTHh2dEJq?=
 =?utf-8?B?SnNvMnRUK2ZmYkpvbHlBNWsrdHVxMEV2RW1CcFFkUTVneDRXTStxNGtwRmlF?=
 =?utf-8?B?QVBpbTBWSlRyMXdSbUVCQ1ovZ0kzNFd3MjlqRG90QlJUUnFRdDVEK2k2QkNX?=
 =?utf-8?B?RWQ5TktXTlUzMXpRSGRSRWhVQ2d5aE5uZUxYaVFCTWNGSmtZTHMrNm0vQ0pC?=
 =?utf-8?B?NnpoMjc4UkV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0w3OEYrN1NaUXNOSDRZM2lVMkVBVnlhWDVZS0lRVWRVc05ZQzFrUGNQWno0?=
 =?utf-8?B?SXpHZUxEOEEwZng0Y3ArdHRBN0s5a1pnQ09aODdjQlBmVDg1WnpvN2VOZnRQ?=
 =?utf-8?B?MkNvQVRjODlGSE1abEdBZ3hFU1pKT1YzV3hkVXc3VTRzeDg0OXgxUWhqUHlx?=
 =?utf-8?B?QW81MVIveUFaRDNaTkt6OUJTeEpmN05nMjYxdUgzbXl2RlpEaEVEWDNUS2hl?=
 =?utf-8?B?aGRqWW1LS3BhQTk2VjQrbDJkVnpwcUVBNkFBd0J5NU5ucUJIdUxIeFBFRWwz?=
 =?utf-8?B?R2l4bUNpRzJSME5lc1JRSlVKejJXcnJaMjRmL09ieWdjd1k0Z0tGemowbmRW?=
 =?utf-8?B?UVBGcUdXTjBRYkpQN2hUTXQ3TTg4MGtrVSt5YXVFT1YrWS80clBpQ0JsY2hz?=
 =?utf-8?B?cXNGN05ud09YQ2p2NURyTGI2OEtDVzVKS3ozMVBLdVUzeDFoa0QrMjJ0dHhB?=
 =?utf-8?B?cXVIbVp5UkgwWmhacGowakdQSGIyQlkrU1UrVmZiN1V3SWZ1b01NNXpieUEy?=
 =?utf-8?B?OWpwemQ4YUtPOTM5SjcxQ24xZWxnbUJMMVVDV0FUQkRsSHRvZDE0V25RWm9K?=
 =?utf-8?B?NHlyQ253SXJwc1RLbXptZXRFQnV3ZFkyYXRxNEJ3TktaZ2t2RkNLNXZNNVl3?=
 =?utf-8?B?MTdaVUx0dlFFK0lHZFFacTE5REcyQWtVNTl4bDZ3YWVzcnBFUzljZ0ZsVUEz?=
 =?utf-8?B?aHo1ais5VllQZXJ5TlhlNGpUb2E2cmtONnl6K1VzN1g5WmZIYldicm1ubG9p?=
 =?utf-8?B?b21XUW1qZGVZL1I2WXZueFR1UmNyVFo5L0pzTzUwRTdxNkJHbXZxcXZOTWVN?=
 =?utf-8?B?d0szZWhUai8veFU5NTN0azJScE9hQjNoK1NMV3FsNjBXS1ErcW9CMlRrbksv?=
 =?utf-8?B?RjdjWmVxMlhUT0FTdzllVmFiNzNpQjFJZHhlLzkwSmtIUmV0bktoZ0I3RUcy?=
 =?utf-8?B?bnFLcGZZa2NIQkFDOGdSNXc1TXMrN1BYTzBVWm5TZ3pCQlFMQXlERE1HVFhz?=
 =?utf-8?B?MXlCeERIdXEzaG9QVGVuSTFGTnEzR09tL0txUkU2bHM4K0h6bHlPVnJCZVpE?=
 =?utf-8?B?aDVuUFlpVzZoTUZTZkk4SkV5TmpxYzNvSllWMzBwaTRCTXNzUkNPWXhhKzRx?=
 =?utf-8?B?MXFzVFdGc09EQkNnQzFnR0VlY25KekhSaUhORHV1dk1yMTRDc0hOTHNsaFBj?=
 =?utf-8?B?M1Z6U256UXFMd1duV1IrSEkvVU9wYlhxQk4wdFVGbWtQY0ppL1VQcWVSOVFx?=
 =?utf-8?B?SjgwQXh0YTBKV2wvN2p0eXFvOTVZckZzVXEyd2RnQTJ4b2g2aTlicENsSVNN?=
 =?utf-8?B?Zk03ZmtmWHNBNkdDNTc1S3UrdlU4WTZwbmphZ29HYUNSRlkrZUR4bW5yKzhF?=
 =?utf-8?B?YllyWk4yZ0lOV2NLUy9Iczh1QzdjZFA3N1NYK1UzdGFjWjhPdnJDV2NUNmNH?=
 =?utf-8?B?SU1aTTRUMTVUMXdQbGdZWW1abTlJK1FzYmpJTUZDSzhrMlM2MVEweWlmZDUw?=
 =?utf-8?B?eitYalQvSzZkQkhWem12SHBJbVpaczRiOHVQZGd6V3MrdWRlK1JiQ3p2bWh3?=
 =?utf-8?B?OTFvbTZpbUNqR0dackR4Ukx2WGk4SU1Hakdrdmc2VmxiNDJIM2xpRTlUSHI1?=
 =?utf-8?B?UHJMWTEvOTNiYVQzNEttam8wSEZUL2tTSmlsUTRhcXp5Zmx5Zk1oclpVbnZZ?=
 =?utf-8?B?T01kS25kZzQ2ODhSckdxWHBzUDY2ZmRKbUN4R3VrbGFHSUh6c3AxMHp4WkJW?=
 =?utf-8?B?NUlUeWd2MytKbHFkVDJhU2FsclZxV3NZb0tOUDZjUUpQaGY1MHJlNXNmU0tZ?=
 =?utf-8?B?OTVYNUttdktKWXZieGhMT0tHM3padVRqb0NNc1hrVHhGWVBJTFdYS21GZlVP?=
 =?utf-8?B?WEFGQVBLUm5tT1hKbi9mdUJHNDRLWUFpM1NPUlFDYWVtZ2dDRU9oa2RHazYr?=
 =?utf-8?B?Y3QvSU5uOWxIdUg0NkVVQ05QM3BkY1lCVDA4MkU3QUp6eVdOMFBmTWloVFg3?=
 =?utf-8?B?T3puSGJ3VTZPQ3FGcDMxOHpHR1dWTWdaUFQxVFRnWEZtNmthNEZnMFluRW5m?=
 =?utf-8?B?NEkvYjNLNGVXSFdzMVFZWW4yWW5VUDNlNHF2S3d1WGM4QTNYNE5GanhHMUFp?=
 =?utf-8?B?S3FaMWtrbm1HTGp4NVpLNFQ1OWNLWU0raTg2eDBQUUhibFdRODQreDFOMEtO?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e83fda2f-13ab-4a38-d7fb-08ddbe3318e0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 15:21:22.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drH2zVspSU+WZW54C7vbanvGGue9Z6ZKFcJZpQS0UbYhOoCLHB+UkHX/UNkFbavfRcjEHiVALx74bA+6vzsSobBHyMjX9GTUJFu0cRj3WCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF56FDAD370
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 6:27 AM, Moger, Babu wrote:
> On 7/7/2025 5:35 PM, Moger, Babu wrote:
>> On 7/3/25 11:21, Reinette Chatre wrote:
>>> On 7/2/25 12:04 PM, Moger, Babu wrote:
>>>> On 7/2/25 12:21, Reinette Chatre wrote:
>>>>> On 7/2/25 9:42 AM, Moger, Babu wrote:
>>>>>> On 6/25/25 18:39, Reinette Chatre wrote:
>>>>>>> On 6/13/25 2:05 PM, Babu Moger wrote:
>>>>>>>> BMEC (Bandwidth Monitoring Event Configuration) and mbm_event mode do not
>>>>>>>> work simultaneously.
>>>>>>>
>>>>>>> Could you please elaborate why they do not work simultaneously?
>>>>>>
>>>>>> Changed the changelog.
>>>>>>
>>>>>> When mbm_event counter assignment mode is enabled, events are configured
>>>>>> through the "event_filter" files under
>>>>>> /sys/fs/resctrl/info/L3_MON/event_configs/.
>>>>>>
>>>>>> The default monitoring mode and with BMEC (Bandwidth Monitoring Event
>>>>>> Configuration) support, events are configured using the files
>>>>>> mbm_total_bytes_config or mbm_local_bytes_config in
>>>>>> /sys/fs/resctrl/info/L3_MON/.
>>>>>
>>>>> A reasonable question here may be why not just keep using the existing
>>>>> (BMEC supporting) event configuration files for event configuration? Why
>>>>> are new event configuration files needed?
>>>>
>>>> New interface that enables users to read and write memory transaction
>>>> events using human-readable strings, simplifying configuration and
>>>> improving usability.
>>>
>>> I find the "simplifying configuration and improving usability" a bit vague
>>> for a changelog. The cover letter already claims that ABMC and BMEC are
>>> incompatible and links to some email discussions. I think it will be helpful
>>> to summarize here why ABMC and BMEC are considered incompatible and then use
>>> that as motivation to hide BMEC. The motivation in this changelog is to
>>> "avoid confusion" but the motivation is stronger than that.
>>>
>>
>> Changed the changelog. How does this look?
>>
>> "The default monitoring mode and with BMEC (Bandwidth Monitoring Event
>> Configuration) support, events are configured using the files
>> mbm_total_bytes_config or mbm_local_bytes_config in
>> /sys/fs/resctrl/info/L3_MON/.
>>
>> When the mbm_event counter assignment mode is enabled, event configuration
>> is handled via the event_filter files under
>> /sys/fs/resctrl/info/L3_MON/event_configs/. This mode allows users to read
>> and write memory transaction events using human-readable strings, making
>> the interface easier to use and more intuitive. Going forward, this
>> mechanism can support assigning multiple counters to RMID, event pairs and
>> may be extended to allow flexible, user-defined event names.
>>
>> Given these changes, hide the BMEC-related files when the mbm_event
>> counter assignment mode is enabled. Also, update the mon_features display
>> accordingly."
>>
> 
> Here is another update.
> 
> fs/resctrl: Hide the BMEC related files when mbm_event mode is enabled
> 
> The default monitoring mode and with BMEC (Bandwidth Monitoring Event
> Configuration) support, events are configured using the files
> mbm_total_bytes_config or mbm_local_bytes_config in
> /sys/fs/resctrl/info/L3_MON/.
> 
> When the mbm_event counter assignment mode is enabled, event configuration is handled via the event_filter files under
> /sys/fs/resctrl/info/L3_MON/event_configs/. This mode enables users to
> configure memory transaction events using human-readable strings, providing a more intuitive and user-friendly interface. In the future, this mechanism could be extended to support assigning multiple counters to RMID-event pairs, as well as customizable, user-defined event names. Also, the presence of BMEC-related configuration files may cause confusion when the mbm_event counter assignment mode is enabled.
> 
> To address this, these files are now hidden when the mode is active.
> Additionally, the mon_features display has been updated to reflect this
> change.

I do not find a concrete motivation in this changelog. The terms "may cause
confusion" and "providing a more intuitive and user-friendly interface." are
vague and not something that I think provides a good motivation for disabling
an entire interface.

I aim to write a draft below that I hope will help make this changelog more
convincing. Please do improve it:


	fs/resctrl: Disable BMEC event configuration when mbm_event mode is enabled

	The BMEC (Bandwidth Monitoring Event Configuration) feature enables per-domain
	event configuration. With BMEC the MBM events are configured using 
	the mbm_total_bytes_config or mbm_local_bytes_config files in
	/sys/fs/resctrl/info/L3_MON/ and the per-domain event configuration
	affects all monitor resource groups.

	The mbm_event counter assignment mode enables counters to be assigned to
	RMID (i.e a monitor resource group), event pairs, with potentially unique
	event configurations associated	with every counter.

	There may be systems that support both BMEC and mbm_event counter assignment
	mode, but resctrl supporting both concurrently will present a conflicting
	interface to the user with both per-domain and per RMID, event configurations
	active at the same time.

	mbm_event counter assignment provides most flexibility to user space and
	aligns with Arm's counter support. On systems that support both, disable BMEC
	event configuration when mbm_event mode is enabled by hiding the
	the mbm_total_bytes_config or mbm_local_bytes_config files when mbm_event mode
	is enabled. Ensure mon_features always displays accurate information about
	monitor features.
	

Reinette

