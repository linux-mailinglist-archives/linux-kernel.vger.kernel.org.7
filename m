Return-Path: <linux-kernel+bounces-740130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D347B0D05D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF86C541685
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E147228BAB0;
	Tue, 22 Jul 2025 03:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nypJbM+w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E128EEDE;
	Tue, 22 Jul 2025 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155054; cv=fail; b=Aiy+7zz3m8MqG/J+V3IdxBpg4/l2hfea89nnH5HsLmFBw6DxlVR8TpvFdVXIawpR31FrSt7ybDWwD+Qb8NFzvh01IfROK//7VsOoZiK9VsHX5qGOY+UMSx2G4+5b+GjK+W+gPOKAtMwybc6+wkNlBk2pKxneejDpSGPoAMTmO0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155054; c=relaxed/simple;
	bh=RfOBNo5kLfwyGkpf6fF6wV3ifU7Z6PSX1JWU9328sXo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mjt2uwPrbuNzsHAKjdXhrhVu6lx8dImaqSSXU6hWKLKAZ97Vp3zUm+rXKf+Xbdw4mfjy+9u82UEC/npI17BDujRn0jQqlHU7qwgIADgokRKQEtlY4E8nPUqVrR1sJxNTGPPVS0ZO1ZGAE/Z3HuxaTc2SPNJRbz1XA091ckJCcGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nypJbM+w; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155052; x=1784691052;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RfOBNo5kLfwyGkpf6fF6wV3ifU7Z6PSX1JWU9328sXo=;
  b=nypJbM+w5qm/EgY2+N4+E2AfRpF4GI3e1gYPiNc/yiAyxBh2vRQiEIS9
   +agqvWVSOp5cOHsHCSKKYlDWqhIPvxKOAAW8btEpJsTclPoED/+bqgGbq
   ha3Qw/70Co3iFXPBZ/VwFlmFI8H3TjZQvxz86yMOloy1Ds5q32CtGMeND
   ytDRuFo9oLBDKGw7L7Xjg4WsRL1HZG7mEfS5eui/W5UZMtntp8GiLirph
   h0qfb1Ekjo5UGdznt4K7c+ixRWDkYfdQPZbTpKcxd7d2qqqVAas3Z+U1O
   IcBobHuwW5Wn0FhTo+t9ElIjhmKZVvy26gEWEKRnbjJjQ12gGVtm4Cbff
   g==;
X-CSE-ConnectionGUID: JuSTzgHDTiKyjAVYmOzFSw==
X-CSE-MsgGUID: Z44U7Gg1QD+ZvgLLNJooMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55269357"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="55269357"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:30:50 -0700
X-CSE-ConnectionGUID: 2DZA7QCIQD+F1gsymRo+4w==
X-CSE-MsgGUID: rC5MnEuDR0WF4jvUkUpftQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="163250559"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:30:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 20:30:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 20:30:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.50)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 20:30:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJCRstzJ9mx4AET4MBiW1uoJ3o5TqwIR8cp/pHdz0g5rdj3IVH123RNE9hh17rVaL5HDmHFa4OPvPqlGF2DbNp3XVwcfadoCSOnBJfVeJqpk+8QjbKkdXIP/ncM+tRYZxMTjFWQwlsGnHzJ2yoH+q6G+d9xkL/lPzveOoyuryyxbR6CqJWZmi2hfgJOHsPrP6qyatIflNM6O1sNYx/IQZISTgSoGcUsg5v1wSg/YpA1YBkz9tffqzNFhuXok3Z4oDF7zeC8xlVNI2fXlO0x6kcjiCeoKFHgv+qCSocYGq9UuSaiVilC8Ea05o4kPHA2OUpDkBHQG9dxnJ/zMJ2JDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7n/LSQyCwvpCevWD5CVkDmgtqYMiK6l8z7cKPYwJHU=;
 b=E/WOObkGVxrEhmBx5t5ceukXgR9fUC5jxJ2QS+eimSShFfpVVDp1SJE0S7QZTjYwoY0fuKVwZEBNlUkAQeWGczY4kmhdhkHuRkKwu+T80jafwGSLqTzFCzKfobl/NPWfknOzxa6GJFeGDG5ojqFEHu1DhotMu8YYKhBHe73pCVeX3qtUbgboMIgYx1LPGpjLfmwJwAkZ9MhAZVwTK4p5VCTPXhFN94zO7OBgK5Ok5uZhjtMVCkKvt34zyUfDgiouiprp2Ex8sJsbXVtxETMtO229d6kkFdBgA4bA/+r7foqw2iszMvm1oHMNZle7dTGws2zsVLj8Gl0yDiQU+jztUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 03:30:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 03:30:45 +0000
Message-ID: <798ba4db-3ac2-44a9-9e0d-e9cbb0dbff45@intel.com>
Date: Mon, 21 Jul 2025 20:30:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/10] fs/resctrl: Modify rdt_parse_data to pass mode
 and CLOSID
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
 <f52c579262bbbc8bda4dbbb7341ad7bf0add0379.1752167718.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f52c579262bbbc8bda4dbbb7341ad7bf0add0379.1752167718.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 824313bd-407d-4786-99aa-08ddc8d02481
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UysvOWpqMFdERXltMTk1T2JwVHZpc0hsY3BLaW1IUlFUcGU0ellJV0ZLbHB4?=
 =?utf-8?B?bnZBZFdmaXo5NjdtaUtGUWdqZlNjejlyYkY2Q2JiSVdSL29NSmpXM1NKYUIz?=
 =?utf-8?B?L0FLRi9xZnVUM281b0xlTnNOMHpUanR5c3FURklqNzJvMTBqS0hYVUNNaUFq?=
 =?utf-8?B?NlRwcFVzVTZuYUJ1U3lvQ25UM29neW9HMXZ6d0pKUmh1bVBlN2pmaVorTlk2?=
 =?utf-8?B?cFF5UThsTFFhcjlzRVg5YlpEVlQ5NVQ2MnplK1F2SzB4bS9iNGtsRzgraksy?=
 =?utf-8?B?NzlJcjdOanlmUFRSLzZ6cUdJc1haeG42RXVBNHAxWmJYck1YVmtSQTNJQThB?=
 =?utf-8?B?RFZlWWFmd1ZpZElLN2k0VUNnakY3UlFUU0VJa05MejBDcE9QTWJMNkJDNFA2?=
 =?utf-8?B?SnoxYU1JRkdTK1VjenVhbjliQUY4SXhRaHQzcGh3QU02OEVpc3ROam44eTFD?=
 =?utf-8?B?U0x6UW5FWEVXRENBVGlWYlBsMTRrNk5GODhJYktNeE5LUThvdTU3Uzc2VzZu?=
 =?utf-8?B?Qi9qVUlBd2hCczFNaStCVlFZVUFWYjMzVTVFUjVRZTdPZXQxQWloWFp1NTNt?=
 =?utf-8?B?ZmZHbENoUlNsUmUybVdoZHVacWl3cWUxdjY3UUhRN21yWFQxMWl6cC9TS01s?=
 =?utf-8?B?d1hJdXVhWk9UY0RNSCt3TVQvMWN1SmcxanlBSnBHc1lVeTVDSGxuY2dYdSty?=
 =?utf-8?B?MWoyRTVMdmN0bEl3TnpnMEd2UndCZ1RwdElYa3BnRDJSdGJndVplK0RVWjcx?=
 =?utf-8?B?N2NYUWVqR2dieUltdXBkKzVqTUJGeHFrL0JFQVoxMXlOdlNUSGhtZ0VtT2ty?=
 =?utf-8?B?bWhBc1lMTUVtMnFZbHltWi9yT2JvMXFJSVhjcEplZjZkZ2hRMko1blQ1Qy9y?=
 =?utf-8?B?VnA0SVp0NWFaTEFwSHB2N2tZdlNMWFUzS2pLT3NER01RWXVsMVNvUWpieDBT?=
 =?utf-8?B?LytnUk5vUjRTcEkwRzFJSHhzWGllRDQvYjVIS2VVT0VVbFFoZGkzMDZ0dVk5?=
 =?utf-8?B?Vmd0eEJ4VVJhT2RMblQ0NkVKa1dWZFVEaUJyOXJUQzRJcDVJUGJLRVBNQU1n?=
 =?utf-8?B?Y0ZyUG1HS3daUmhFUHIvTGVRb1lCL1d1S0xaSWhCV1E1bzh5bGJFMklqZSts?=
 =?utf-8?B?bEVpTUJ3S2tDQTN5bFBGSUZvRThIMWo1QUcrekZzZDFvZzdIRFB3VE9wVkxM?=
 =?utf-8?B?YThwVGp0Z3JhemtuSGxWTXhEcDFxTlVDQ015WFJlbk1VT2VBdzMwbnQ0b2Zj?=
 =?utf-8?B?Z3pkTUk2UGQxbmR4aWNMZG1TeGlNbllzbWUra0EzdHUyUk9iV2FRalUxTlZK?=
 =?utf-8?B?V09qSDIzMk9BZFFLcEdsWGNjaGg4YjVsRDhyeC8yc09KbEY1aTZWOVdIRXhT?=
 =?utf-8?B?aE8waFJIcHFLVnlSV0NZbVB0dVpyWFJLUHVXVWhHb0ZoS01GeWNUZVZ1Ny9L?=
 =?utf-8?B?SXN2QkNoS21BY0ZZRC9rNDZubkpibndId000djVSRTFnSldnT3U4QU00WnZV?=
 =?utf-8?B?TFk5bzRkc2JzNjVjejhEYmFoTWNFRkIvTnpRRUF3THRhMFNsWXQ1OU5HaCtm?=
 =?utf-8?B?a2l0eE9Hbm9FVnpEZlVMRmtkNHFpVzJCNFRwWkFnZzN6WGNUbHZCWExNN2Uw?=
 =?utf-8?B?U3VyOHgwalhKbVRnQkFGeDlEd3J1aVVLZXIwaXhQelkyRENOaHZEVUk3T2FW?=
 =?utf-8?B?ZEFUWjBPR0Z4MCtjeXBXK3Z3Yys3N01jTkhRZzB4NmN2MGQyaTMvRmQzUXly?=
 =?utf-8?B?YUlWeG1uZVJBMzZYNEVIcSt3UlRKMkE1NDUxS1JFamFlV2xlWFg2SHIwM3Fr?=
 =?utf-8?B?MjBJRkVUQmlFZlhIdlovTTRTZDhHQjl2aXRsTWZnT1VyQytveGJUYWMzYTdY?=
 =?utf-8?B?VEZTK05IenFTb2xoTXNLL1Bxakg4U0l5MHl5YnlYTkoyS201cVQ1WEhCSU0z?=
 =?utf-8?Q?/B5VxF5mh4s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWNOZmtSVncrc01PenV4bDk1MGZQbTJRelJDRC9MNExZUFNSQ1dRcGZjTm1t?=
 =?utf-8?B?THZGdHJ3TFREQ0V6VVdJWEl5REpPcmFuRERSN0ZqcXlDU3lHSHJVL1BjOURP?=
 =?utf-8?B?R1BYTUtEYXpXenFHN0hRaGVobVRuWC9pdHJKeE5kakxjQWxxNHQxcXo4OW82?=
 =?utf-8?B?amtOd3RIdlR3UURJbTVoQ0hHQ2xzcktjdWs5U05WUU9sL0QzemF0eDl4c0Fv?=
 =?utf-8?B?eVdUeXpFaEJMRUx3cCsyb3dOVEkyYTJOVGFNVlZXWVNzRjE5Vmx1SWg5OHQ2?=
 =?utf-8?B?NE5HOStLOVQvVUYwQU5ra2FyQmN3N2Jsclo5UTJSejlPTU5yL3QwVWJUcTBI?=
 =?utf-8?B?TlR1VnhVY3JkSkhjYVRLSk45V3B0djg5NG0xL3lwOUxVbDlpK2R5dUJCSld0?=
 =?utf-8?B?RXgrU29qZWVyczRhNTlMb2dvMjNzMm9lT2ZCdFhDaEZrMkZVT1RpaTlaS2NZ?=
 =?utf-8?B?aEJrMUFQMHp4b3RTclVoaHQ1ZTExMUV1RXVEWFpoT3pvZnVHRmRUY2lvOTlz?=
 =?utf-8?B?Zkt4VFNMak5oaTlqMTh0Q25uYnpOK05GNkRWYzMyc2tvS0lIaUNXZDN1L3Bn?=
 =?utf-8?B?Vjk1Y0hzQzVRSzlFZnhZWDdONWczYjNiYTUyYTVyTDVTbUlvd2hDR3Y0NSs3?=
 =?utf-8?B?N0wyclVZTHIwRG15YnE4MDB6RzBXeG9GMExkNDVIVXNyY05GNSs5bTBHd1BT?=
 =?utf-8?B?aVVkcHQ2bFMwMXkwZTBDRElMT2Z1QUFlTllPN2RXb20vb1oxcUFycUNIKzZU?=
 =?utf-8?B?UzFqa2hDbk1yNGZTZUMxN2RKYkxvMWJlMUk3b2dtZ05wVWtCV21rTjgraHpJ?=
 =?utf-8?B?OFplRnVMNGdWYTBkNUx1Zklwc3hQTkczSGJlRUovTzV0U2RCL2VGRkF3dTY2?=
 =?utf-8?B?QlpxR3duNEUzdzJSb1k0MlJ4QW9RUFpUTDB2VkRNR2pvaFFIUktjVk9yVkpl?=
 =?utf-8?B?dnNQVlFkQVJ5bXNTdGFJLzB2MFhaRUhyTm9JQ2VPTExSamhUTUprUEFRN25G?=
 =?utf-8?B?bzZFKzhoeCszL1lFUWo4OVp5RHBuTnd1Sms1V2NsL1dBWHNtaXJLM3UxQ2Vz?=
 =?utf-8?B?Qkt2em9TMUhkWmdJQVprTi9aSEx3TlZ3MlY3Zy9uZU5LYkVrWkplZXRFQ1JV?=
 =?utf-8?B?bjBsY05yVTR0RVFEeXhEdW5yRmF2RVpjc1djbWNUNU1mNWZsQ0EzMFZIcGhQ?=
 =?utf-8?B?a2lzUzZrN1pCdVpnNlRheEJKUEVhZjhvVFhPQ2pUb05VaWh5cHJwZTFlQVFW?=
 =?utf-8?B?U1cxa1hNK09EdS9uT0lYYlpOSCtoVEllV2grYUpDUUlwcitWdExpRUk2anJu?=
 =?utf-8?B?YjVTTHlyMHZRRnRuSThpY2xnT0FlU1ZNY3RNU1ovUDBDRDcwbjhlQ095WVh0?=
 =?utf-8?B?R1UvdTd1c0xTdnZhQ1hQUjVreGIwcEIvTzJwclliQkpwVzl6TDdrTTF5MjJn?=
 =?utf-8?B?aWtSQ1lkR1E4aGpVc2pKQlFWZDArTDdnbjMyMUwxQnZhSkRvUFBUSWNDdURB?=
 =?utf-8?B?bVJ1c1c1UUdlZktlWFczQ280YzVpeEtsbERMRHBSSW8veTNiSXdrVEF1OGVE?=
 =?utf-8?B?K2NaN29TaTU4c0JsYTJkdmszc1I3K3BuOEs1RHhsV3BjMnNNN0JCNVBRcjFr?=
 =?utf-8?B?cGowRlMrVEsvZTltRmM3V0dGbGRsTm5JR1RTNTVYQ29xRFJ6MW1PTjhKdm1S?=
 =?utf-8?B?ZW1kekphL2xiWEkyZHZyenJEdXYyVGdWcGhRcUF6dCt1bTVueVM0dCs0UThJ?=
 =?utf-8?B?aXYxZ2pUUEwwL3NZcEcxODFtMFNWczdkTUJJS25JMU9nRDBSdFRLYzdjT3k0?=
 =?utf-8?B?U3FXeVB2Wm8rVWtvMlRhcGtaY3RrU0p3VHNobVd1NnNyTHFCN2x1bjV6UUQ2?=
 =?utf-8?B?NUFOQ09HTGpOUXNydFZjRWFkSGtTR2xRcndmYTNmTHhjajJSZlI4YWRWKzY5?=
 =?utf-8?B?b2R1Q0NHMHRvbk9hUW9LdHRWK3MraG5XMW00cnJXU0ljUktLM1E4dmd1SHpF?=
 =?utf-8?B?MFFYeHcxSW9JRGhCWFF5bDlOQUEzZXBncUxCK2Q1bmZiOFdGYlQvb2psSzNm?=
 =?utf-8?B?VER2Zm80QU1PRnVJelBQS3F6b0RNUjJiKytJNjNKWDk1Z3RtUWJWQXpTVnpJ?=
 =?utf-8?B?Rk9LOGZwQko2a3p1Zmo5b04vV2lsMmZzY0F3RkNVb2lrVExmRjlUcmxnblZn?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 824313bd-407d-4786-99aa-08ddc8d02481
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:30:44.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiD/SlO8sG/a5JHWrfoqznDaXDc619pKQ4snZvZVfyEGsfmw34w1PhgK01SAc5HhsBZGVWXzfbgjniPOb4shN+tcF9dkRwG57eZZL9mTMYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
X-OriginatorOrg: intel.com

Hi Babu,

On 7/10/25 10:16 AM, Babu Moger wrote:
> The functions parse_cbm() and parse_bw() require mode and CLOSID to

No need to say "function" when using (). Also, drop parse_bw(), since it
does not validate CBMs.

> validate the Capacity Bit Mask (CBM). It is passed through struct

"passed through" -> "passed via"?

> rdtgroup in rdt_parse_data.

"rdt_parse_data" -> "struct rdt_parse_data"

> 
> This can be simplified by passing the mode and closid directly, instead of

closid -> CLOSID

> through the rdtgroup struct. Doing so also facilitates calling parse_cbm()
> to verify the CBM within the io_alloc feature, since io_alloc does not
> have rdtgroup context.

Above notes that "simplification" is the primary motivation but I do not think
this change qualifies as a "simplification". How about second paragraph changed
to something like:

	The io_alloc feature also uses CBMs to indicate which portions of
	cache are allocated for I/O traffic. The CBMs are provided by
	user space and need to be validated the same as CBMs provided for
	general (CPU) cache allocation. parse_cbm() cannot be used as-is
	since io_alloc does not have rdtgroup context.

	Pass the mode and CLOSID directly to parse_cbm() via struct rdt_parse_data
	instead of through the rdtgroup struct to facilitate calling parse_cbm() to
	verify the CBM of the io_alloc feature.

(please feel free to improve)

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---



> ---
>  fs/resctrl/ctrlmondata.c | 29 +++++++++++++----------------
>  fs/resctrl/internal.h    |  6 ++++++
>  2 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index e78828b0408a..5c16557fb7a8 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -23,11 +23,6 @@
>  
>  #include "internal.h"
>  
> -struct rdt_parse_data {
> -	struct rdtgroup		*rdtgrp;
> -	char			*buf;
> -};
> -

This patch is only about replacing rdtgroup with mode and CLOSID, there is no
motivation for relocating the structure declaration. This looks to be a change
needed by following patch but is another change that becomes unnecessary if
the io_alloc code, specifically resctrl_io_alloc_cbm_write() and
resctrl_io_alloc_parse_line() from next patch, are moved to ctrlmondata.c.

...

> @@ -171,7 +167,7 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>  	 * Cannot set up more than one pseudo-locked region in a cache
>  	 * hierarchy.
>  	 */
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
> +	if (mode == RDT_MODE_PSEUDO_LOCKSETUP &&
>  	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
>  		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
>  		return -EINVAL;
> @@ -180,9 +176,9 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>  	if (!cbm_validate(data->buf, &cbm_val, r))
>  		return -EINVAL;
>  
> -	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
> -	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
> -	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
> +	if ((mode == RDT_MODE_EXCLUSIVE ||
> +	     mode == RDT_MODE_SHAREABLE) &&
> +	     rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {

Please fix alignment.

>  		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
>  		return -EINVAL;
>  	}

Reinette

