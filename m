Return-Path: <linux-kernel+bounces-748528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2705B14242
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1B23B7BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22DA277036;
	Mon, 28 Jul 2025 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjbArvR7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38898275AF7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729003; cv=fail; b=YWY9o5T0zTObTYIepAz13uXuYkqbX84qpEjavhmK1IhkPvi1SgAuvDI50uY0wxJpl7kj5/fveLTVBesRZbpabGEEN8ELChTUo62gSsP3Wn3RaAxtKrPNnO7iVVTH3C3mWVyfTM0eemfp+RDlMjqcpm+RanRx5E0qLNjW26z5K0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729003; c=relaxed/simple;
	bh=Ym7lzB5NdSmzIAejSTU1ciOu2oAGCgYyXBXUsuBrc0k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DtBD+4cNhEUHuW5nK2IdTWqj1WxtBeHjZfvZwn8fPoiZ5lcRbcO4BTBkv6EHJsHt6rLb707qe1hfuMdM7OJ4qXAGBMukB4QLgmo9Pzr5NLDqP2iQlLdFNF1OSpVAcDve5cnQcpiqmm/oyFAbUyMYo5Bi5rg6/sDsknmysO/h5Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjbArvR7; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753729002; x=1785265002;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ym7lzB5NdSmzIAejSTU1ciOu2oAGCgYyXBXUsuBrc0k=;
  b=HjbArvR7AvYi9qQFE726qtI/9J3Acc6+OHp9YJqudtnoFAboDY0swFjZ
   64S1fc1O7d5PPakT7Jp4tYh8MUluowwxNMhMuCWYJBU6IBV51Oo/mf5+R
   axaGUvjy1UIddapVWUDO9Ccw623p4Sxyv0o679uiy03iW1rkXIy7uxzeO
   /CTBlyEQe0rZTagJbnb1PjFaHfRb0nbqBz1xF3ASBN6xfgIusHrFBVGZf
   t2aEdj76fqRb8s8SrNHVg/BSEh72lAgsZObutEdKuejB8cCR97Kde2u6x
   rwbGDzm1ECBQsIQXvSTG+9wVzxkEks16GmEwIxHVr64ZWddgM07aXpXfk
   Q==;
X-CSE-ConnectionGUID: EqYtMISpTF+X+oZxDbcnpw==
X-CSE-MsgGUID: +06mh30bTM+eD5mZC+KVPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="78539662"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="78539662"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 11:56:40 -0700
X-CSE-ConnectionGUID: qnUiaW4NSFCtRxnpJNMMrQ==
X-CSE-MsgGUID: mZvQOQqWSx+2wE7n/ERfcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="193333830"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 11:56:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 11:56:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 11:56:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 11:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reygKNoGbXmrqnc2pc+91JvjHiAQXiNZPAReQAm+KFF3Rfqw/85lASqRyi5kTm8+eKlmFtQ0BaQCjfsm81KoEakYBoQZpzb6RUEle7sGSjqSIvI/ZnE4ms1a4k5grFnrpz5pAiOnXbDmNSkyHS4jSDmH2qOzr7cSzDZtPG7YgR7R3LSs5PX5E/gQSJbSXrHRYEcIBPwyhffQaX+jQKFRfdT/CS1Mu0UZOMAD3OaK1UU000UKSQEcEO0k3XNO0y84hca1khWLJwHxqEpJLR/a7cHEatu7f+lT5z4ISegyMHCqNfBGdPcKe89r91qHRVdOLB+wo369+Otr8xMgRB14jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr0vx82UI7XbemK4ybOJHfRpVGwCCNL1vc+cwSSWcD8=;
 b=hIxdEIDBds8kzV8kZCNoxVuSEyive4FPfqtLFg1wzardh2vyhxuWXMIfNjoT/arZuJJJ4NcNmC7SFSAeVT8OzhybQlHrkTUMGB7+whsE2oDk6Rk6SfKe4MsntxtaIY47YC5APaWsSf3Jboak2vZPsyHxEJtv8gsYD6R9h/EU4waiUno8Sv8ThUPujYNAmpALPNBCFiOZOv11bnECkLdw68Fa2Gyk/Ui/Rf54as2qDP5bsVm544ZPHc215dbCye8Uc+FkFrTnHJDgbYUTcEs2J2i+A9X0UJs5YmjjLkZBao9vVkHzH2GQ5ULN708hYiPmAIIs1si5+CBCt3wlCbrwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA3PR11MB7582.namprd11.prod.outlook.com (2603:10b6:806:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Mon, 28 Jul
 2025 18:56:20 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 18:56:19 +0000
Message-ID: <a1044e00-8e61-4de5-b22a-3878920e471a@intel.com>
Date: Mon, 28 Jul 2025 11:56:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/intel: Fix always false range check in x86_vfm model
 matching
Content-Language: en-US
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <darwi@linutronix.de>, <peterz@infradead.org>,
	<ravi.bangoria@amd.com>
CC: <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250728180923.160966-1-suchitkarunakaran@gmail.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250728180923.160966-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA3PR11MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1d9bf6-ab77-4f43-76e6-08ddce087065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVBvR2RhaEpKMTh5SzVjejNLL2JBbXhRVjFaQ29EQytvV0N0MStlbTQ5dUo4?=
 =?utf-8?B?VS9JMnJEeW1CRWsvL0I0dXhCS3BqWnBxY2g1V1NWUUIzdUl2NitGQW1nQjY4?=
 =?utf-8?B?b3haVnZ3VDN2Rm9UeVVBbjd6UFozSFlvVVQzZit6ZHc2Q0NWRnlnT3o4SVk3?=
 =?utf-8?B?YnFxMmRwa0Ivd3RadTQ5eGgvSDhIKzFia0Z3ZlErWGErbndvTFc4UlkxVjJP?=
 =?utf-8?B?SVNqM0dPWmVtTmFpejNJWmlNMUZ6czlHUWtDR0NCTXpzajhlaUFpcWVXSnV4?=
 =?utf-8?B?NklDZEovVit4TDU2Tkp5eGdMd3RwZFFhQmg0UzQ5R2N0cXBDQmFyRTJrTGlH?=
 =?utf-8?B?L25BNTBkTEE2SU1IWUtQTy9jTzErb3Z6ek1SMTZseWdGVjYxTmxkNGdlY1B4?=
 =?utf-8?B?cVpyY3hqb244N0hiUERhSzNKWm5CWjNEYzhhRE1hby9iZkFGdUttWjBZUFdR?=
 =?utf-8?B?RURIWWYzbWMrd0FWcE84ZXlUNzQwK1g1RDNIVENHWUZEdGVLU3lZR0VwT2xx?=
 =?utf-8?B?ejFnVEFIR2psQURtclg4OHdnVmN4b3g5cUExS3liMndZQ0o3bmtvbXNCT0tk?=
 =?utf-8?B?ZmpSamswaXhUMURHNDJ1QkQ3ZDR4WDl1RnJXTUNrbXVpWDNYUFRkNDRWcFJ4?=
 =?utf-8?B?eXBwTnkvRmtRVnZIc0JHUmFmZE5YdWR2TVV2NEVuTm14THNTV1JzYXhhS2Nx?=
 =?utf-8?B?Qm9tZUZCS2d1M3EvSUVaQU45cWFaQ3ZhVUVXWTZqckU2QnVmdjhjd2dNS2JW?=
 =?utf-8?B?QlUwQlFnVjhIUnJRamkzNUprWW96RjQxbjRVL2crbERWNlBUVVMvZWQwd1Qr?=
 =?utf-8?B?V1lKa1I1dFNKL1VPY2hCRmpsNG1aZmsyZXVwcEEzQlpIMDVYbFNiWHNJdE9u?=
 =?utf-8?B?d0NSK1Z4TGx3RnlyYS9BU0RYMDUzQjlmellVVDJmNnRKQ1VHQjZtbFJSb1Bh?=
 =?utf-8?B?Z3c5YmlnL2krT29BOGRTUHVSdERGemNsUzJha2NEMit2Qm8vb0pkU0lYUWJD?=
 =?utf-8?B?azF4V0pYNFd2N2FZbWpXTDZqM0hsWmhLbHZsWEliOXBncWx2QXo1MGRnRU95?=
 =?utf-8?B?Z2x4ZnBTc240dkVmNndTRGRFY3dJVFlPWVRUdXkvWi9QMEpPUlZPbExwQmcw?=
 =?utf-8?B?bXhsbkN0bGEyemdHTnN0d0J5QWVGWXRQSENrRGFNamlXVDNSa3VGendpYUtr?=
 =?utf-8?B?eUlQb0ZqUytMaGRXTktPWmVKNHQ3VWU4N0hOTzF5cEFWcG9LNnlKVXIzaXVt?=
 =?utf-8?B?MkFaU1F3RkZkRXV0RUdndDRrTDdjTW90ZlhpTHpUMjlpeFk3K1RNU1czM1J0?=
 =?utf-8?B?TTZHSUNxd3R2U1V4QytuZWpLVmZjLzMvVjNSREVZQW83TFRIMDdtT0VGTzFh?=
 =?utf-8?B?MGxkMTB2VzhYaGhqdHpOc2oxK1QwdjlxOXk3N0NFbDEvOUUrczZlS1pCVVAz?=
 =?utf-8?B?Wnkwb0o0cXRKMC92VUU5dldiNVN1RWhEcnFlcUFpNkZIbGhoZVI2S1hobnd3?=
 =?utf-8?B?L1hKbWNXSE9LV2prM1BKNU11ZksveGtwM0ZPYklmNWxsOXRmTS9lM3kvcXpX?=
 =?utf-8?B?aTN1dVFxQkluRk1XaDY4TlZIZFI1Z1Q0eDdOdGJsSFo5Vk5zZzMwMFRVWmlk?=
 =?utf-8?B?TXlEU3ZpOG1CdnhwQ2I1VUR0bmNtOC9zZ3kyTXF4NEk1ZUJ5MHhiUXNieUVY?=
 =?utf-8?B?T0dYTkZxTHM4eDZqQk9BOG1IM1lYR09yMmtraW9IWW5BMUdtWm5sbEtRK1Fn?=
 =?utf-8?B?YlkrMjk2OUZYZ1JtaDU1YlBSZmJFWnljaTlNdE1zQUwybDdWVDFKaWFtVG5v?=
 =?utf-8?B?YnU2OEZUTGFZVXNWS2FQMGx5enJlUXU0OWFkelVMSTBuMmtmMEMzcWdZOEVh?=
 =?utf-8?B?MmtlQnJlZS9VaWpFZDBqUSsyYUZISGJSTDU4WTZTcVdpaUN3SEpscjVDSmFv?=
 =?utf-8?Q?Gcr4k8Alhc0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnpKSWFtaUw4NDhoekRmUkV5MjhpdkU5YzN6U3c4U3FvbnF0YXlkTUhyMmhF?=
 =?utf-8?B?S3BQVTk4Z1MxMkZ1ald2WUxCbW9HYXpuM1Q1WjJPdlY1ZDZiSUFDeDA3aml4?=
 =?utf-8?B?QVdvM3dLQWtObmJTcWMvb3U4MHFKR1FEY0EwTE5oVGdOVzZ5T3lLYnVGY0NY?=
 =?utf-8?B?ZWVxYnFKdjFYZStyTzJBclVoMGNXY0MwOGpoUGJGbFJhQ0U2UGdoaTlYWjZq?=
 =?utf-8?B?S3BWVFg5QWpSZ0NVaERzNTFJSEl6VGpDYWFKR1ZMSlB5SU8wZ2UwQlBlcEVU?=
 =?utf-8?B?MTRzdjE0K1R0ajJveVplNVBVZnY1RzYvWmIwU3NnZUtWdVNhM2VaKzlNcXpR?=
 =?utf-8?B?dTdybFFjWE5UZzF6cDFwU3B4cFFZc2l6aDE0NEFnYkhmY3pQbXMxRk9adXl3?=
 =?utf-8?B?U0s0eEZnZHRXNmJwZ3hjTnpxdzhrT1o5YmoxWnlBMTgveDR3cWRHWWM2ekM5?=
 =?utf-8?B?Mi8zcXlKZDhnOXp0b2orRURQZklCcHY4TUpMeFI1YjNBQkhsNCtZSGFjQ2kv?=
 =?utf-8?B?UjQzSlkzUmx1VHc1UGhnVnI0cmJVc2JucXNuS25LcEpXSlUwTWNyS2M1ckNn?=
 =?utf-8?B?allsRnY1RFBDUkdHdTZXM3BqNE5sSElvc1FtMmVoMFQzMGJ6b2pCbkFDbU1F?=
 =?utf-8?B?UjcwNUxnaUpNRS9HRVZXRmtQT1dqbVNFU2JoclRYZTJWT1pycGRLUEJuKzBx?=
 =?utf-8?B?OHpCOWZEaXd3MUJCTHJHN1N1YmZNVFpFQzRIdlZPK1ltaXhYVCsrdFZKSk5x?=
 =?utf-8?B?SklDemtEWEdvMG9kRUE1bjJycnY5L3p4U09uSjVQNkhTOHpjbGZsQ0t1ejNC?=
 =?utf-8?B?MS8xRnBYU0xaWFpLM2FxdzhkSU1HMzhlSDZITXpFOXZNcktFK1NnaW12ZFVX?=
 =?utf-8?B?bmhKckVzbzZwMndrZ3lrUEYyUGxyM0R6UWpzN2NOMHJ5T2JqQStjVXk3dk1W?=
 =?utf-8?B?WXZybE4wUXkwcUE2aXVPMndJMWs0VGhwQ28rOUpFSVgySXFyU0NHR2I2TFUw?=
 =?utf-8?B?TlBtbndHOWVEWkMzNEdDZWNRblJiSWNBb2R0d25abFpPSUN5TE5ub1FJeEE3?=
 =?utf-8?B?VVkxZUJaS2ZBcHEzZXhuejJyTXFRQmVpZC8rd2xiZVlSdUtEOVY4THQvTkt4?=
 =?utf-8?B?Q1NET3hmT2I5TDhCbEpBVkNXQmFSSytrQUdpUWZ3RVRhbXl0blFTYVZFNXNr?=
 =?utf-8?B?VHFtZnV4eHhYcXczN1Y3UXJYd1lCU1NNTjNrRm5NSlI5MHRmWVRsVWR3VnhS?=
 =?utf-8?B?Q0xPL0QzUTY2elFwUTJaK1hvVHo4ejQwZUFzRkwvVUdrZndRZU9kaklUem5n?=
 =?utf-8?B?UmlFazlEdE5GaGQ3U0MvRFBBV21yOGpoaEtHd09BeHBrOVFSaG9nR1FCZWlv?=
 =?utf-8?B?cEc4RlBxdWV1Ni9LZ3ppVnlmUDE4Q3lLQ29OTHNNeFRYem9SUXlSM3UxeWlj?=
 =?utf-8?B?ckQ5c1pubVBhVklRVkRkU3hQRTZXRHYrYk11WXRERDh0YmRWL1NLSmhuZFZY?=
 =?utf-8?B?bVJVZTNOdHVjQVFkMUNIV3lOa0FTRmV0MWVzOERwMSt1bUJaOTZIMGFiYlVI?=
 =?utf-8?B?REdJUHNmQ0h0Y3UzNUZPQndrMzFyVWxvTW02Wm9IempES2RDaS9naCtRV0pZ?=
 =?utf-8?B?cnVJcHlHNUh3M3FqMzljVmdOOGZNQ2pRSTBBMmlMMTZLRGpHcFJrcjdFaFRL?=
 =?utf-8?B?Vmt3S05CcEc1MW00QjYzaHFuTjZ5S25OaVlDR1RqcGk3QXRUNHlQSHllbVk4?=
 =?utf-8?B?Y1EzdlIydTM1VmkzQ1NsQ0VyWU05T21BOWU4Y051THMwcW9WU01xQVRpZERQ?=
 =?utf-8?B?aEw2eWlFZUwwdnRiYjNpcjFnSDYrUUhaWmY0MjVMOWhwUFl0SFM0aVFGODN5?=
 =?utf-8?B?OWJRMS9IckxSZkRVYnhsRk96dElSZzZua2RadTJoR0hpYXNkS0IveVplY205?=
 =?utf-8?B?NXFsT2NzR3NaQzlheEhWcFZhOU03YVpuN2hFTG52YlB0OWx1eVBkdjBVb3ZP?=
 =?utf-8?B?bENreXRkMUt3bVhPc2o5YXU2SEJEaXVuV21obndSRDliNlRrV0pJM0JVYTV5?=
 =?utf-8?B?ak1Nek5nVDhQcThXdTE5TXBmdE95alRhZndyRnJxTWZlT29wNURwTVZ5OFNa?=
 =?utf-8?Q?cGTvTHGi24lKFia27YswYlf5V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1d9bf6-ab77-4f43-76e6-08ddce087065
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 18:56:19.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqAwF/vIRrPycqf/ScpBwwbzo6NNt73m0eWs3A3RWjZcv0KXX8ATlgRtWJPO7gN2L13Y37ZSL+pwXiucXv3DiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7582
X-OriginatorOrg: intel.com

On 7/28/2025 11:09 AM, Suchit Karunakaran wrote:
> Fix a logic bug in early_init_intel() where a conditional range check:
>     (c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE)
> was always false due to (PRESCOTT) being numerically greater than the
> upper bound (WILLAMETTE). This triggers: -Werror=logical-op: 
> logical ‘and’ of mutually exclusive tests is always false
> The fix corrects the constant ordering to ensure the range is valid:
>     (c->x86_vfm >= INTEL_P4_WILLAMETTE && c->x86_vfm <= INTEL_P4_PRESCOTT)
> 

Thank you for reporting this issue!

This is indeed a bug, but the resolution proposed here seems incorrect.

> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 076eaa41b8c8..3ec1555cbdc3 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>  	if (c->x86_power & (1 << 8)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> -	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
> +	} else if ((c->x86_vfm >= INTEL_P4_WILLAMETTE && c->x86_vfm <= INTEL_P4_PRESCOTT) ||
>  		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  	}

See commit fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural
constant_tsc model checks")

The original check that this replaced is:

	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
		(c->x86 == 0x6 && c->x86_model >= 0x0e))
		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);

The first check is supposed to cover all P4 models starting with model 3
(INTEL_P4_PRESCOTT). In order to set an upper bound for Family 15, the
check should cover all models until model 6 (INTEL_P4_CEDARMILL) which
is the last model released in that family.

The error that I made was to use an incorrect upper bound. The actual
fix should be this:

s/INTEL_P4_WILLAMETTE/INTEL_P4_CEDARMILL

> @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>         if (c->x86_power & (1 << 8)) {
>                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>                 set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> -       } else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
> +       } else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||
>                    (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
>                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>         }

Also, please add a
Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural
constant_tsc model checks")

Thanks,
Sohil


