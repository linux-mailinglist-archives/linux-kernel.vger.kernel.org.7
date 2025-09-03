Return-Path: <linux-kernel+bounces-799202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF50B42863
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DD31BC4479
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9656E335BC9;
	Wed,  3 Sep 2025 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiCC+zI3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA933438A;
	Wed,  3 Sep 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922118; cv=fail; b=qhUPHesNc6TBQ+K5lzpTPjIID+A1ok22qibg5OH8ROBP3TY89tL9ryvjC/jcNPOWFv5zI2b7RY7aOaQTJW/AU6QFVgK9hEgareyNGTrl2Hp0C20ghM3YjsLOstcxZYqgtV1l4RbuDqLFh8I54BhIPmB2vJ1lCb2LR/uo9S1aXvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922118; c=relaxed/simple;
	bh=Aa3HgSNGqi7QDcEAM00mAIcV8bMiCHVN62+Q1ZVOPk4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D+Ms13K4VkMeCZ4EMLoCIjdeJtLP/ieEGQZ6I9naq8zfVLTB58xPPUE7joIzzQ6k4McfsslgEbjvbQIkiLvP5PxcNWHEswgTC+Eyii3hj+y4xdsmGPigvPj3n64H9FNFC9gZvQo0yeRc3NDXR/w74MnYUAwgog8rI4bsYcXneT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiCC+zI3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756922116; x=1788458116;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Aa3HgSNGqi7QDcEAM00mAIcV8bMiCHVN62+Q1ZVOPk4=;
  b=iiCC+zI3d0gXsGKe/JRhordsDJ6X/AhrzASifYy5ll+fnaROVYME2+dw
   lTbV3kXEG3bP0xkPu/pX2OnYaHvYdVk3nlBFl6rd1O7CV3IRLxLibVMII
   uvkZIhtJmJjFE/emwI3+EVQK9LCHlQAbI4PnQ5WRsHGK/UWn0cJx/B/Oy
   o+R32zXSCa2Xw7YsVGWPH7O1YGE7V8tprXPGpBouq930+/3TJkf7WfzrC
   tb1l1dLZyTZj+kUr0hCcrX3taHzZB/Jk7KvAg4viIQNaRkphut/0FYmXH
   tiezTsZGkNJ2/vLwkvYKXaJ6ZD2OavoQTOOBTjBXlCrMiPyrVyhQjnSIF
   Q==;
X-CSE-ConnectionGUID: InZmy+5SSBqEnLPMxGk/rA==
X-CSE-MsgGUID: HUfHx4o+RMy03A3dkitjbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59102949"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="59102949"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 10:55:15 -0700
X-CSE-ConnectionGUID: me6T6y0XRaC06gFU7/y8pw==
X-CSE-MsgGUID: tCE6BRMpScSXL0PPqK8rTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="195312481"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 10:55:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 10:55:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 10:55:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.80) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 10:55:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWw2VHq7VcY4bM/oBA/qTgUOIwe5Hgm/7/EkejrLdvcPktXkKDZX/bY7b2lJ/v8K5AWuFLoPXRdAu0UjkuKeHRlQKGWyMsaLFsyaAnSDa0Hzneem6GIW/u2uESszEU8mWO0bfypPR4+d4GLIzeEyXKm5fO1LUDuwu6rK15iwwvOvY/BZ+VynYPmqrCd4g4n5H3DF0j6f2WVjZ7GaHAY+aSDNGVjQXHOq8YGbAXmBUs67t59plgXs28pJWBYe+rOtjGHr4Ug9K8XQ7/uo5ExjnEXHI521136yUn2mR98SJUEEHCr6KTHalMTWEk+bv3Y2gqjVCdJMwtZ7glWio4RpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBeHvTTExwQ3vCLbrwOeojWweNatRbJyeucnDK83d8k=;
 b=qf/L4JFOzuBKXydKbRSbt6cLQs8FRbraNombEIG+WD5Lap4j8AWNJbbZn4UCgWX+h0heMx5yS6D5XxE70MwgGD4oxD3fCDrhrcTC8seKYSpRuJqCL3zAVAGAk0W3Rh/BPUZh2Mm+X0ZkApvBU0RY05l4WNZCONt00lEksnIBA9act/k2nReOKTePX+/Q5NdNiHU59HeXfsAUvEHlzsOrE47ULmrPTRBzpgbxYT+OlTm1ulCRVRWFWSxRRvR/LN3X/wsfdj/lXDMYVX1SbNLj7K/d8HNwiE8wTpEzqxPrNGz/3t1L9zx3uNslOIVBxmyGFmh4re+G7m8gVpQ7Bbtf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5792.namprd11.prod.outlook.com (2603:10b6:a03:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 17:55:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:55:07 +0000
Message-ID: <c6c1df22-e3df-4acd-a93a-f2972cac9793@intel.com>
Date: Wed, 3 Sep 2025 10:55:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 25/33] fs/resctrl: Provide interface to update the
 event configurations
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <4d497589d3bb5389565676512c2116e5cfa6df7c.1755224735.git.babu.moger@amd.com>
 <c5f97d82-bb87-47e8-bbf0-e9dfca332313@intel.com>
 <dfc629d3-08d8-4443-9a8d-61e4612dfbd6@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <dfc629d3-08d8-4443-9a8d-61e4612dfbd6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 4923883d-70d1-4aff-b67c-08ddeb130493
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWlyUUVZNVZGZ1YzUHFQYy9kTE5QVkFPSE9VNWhGdEdCRGdSeHRBb1NXVkE4?=
 =?utf-8?B?US9VUTdwTzAvQWN0eHh1dGd5aUJidEI2bXpPdDl5bk85b2ZxZk45UUNhaFhT?=
 =?utf-8?B?Nm82K29TM040Z3lnN09DS0cyczJqdyt3cmkzYnVyWXIyNVpaOFo2WDNkSm00?=
 =?utf-8?B?YXk0b2N6NHB6enpSVEg2N1ZPWTdkTFY0SXNBK3NQcUZqREZjMmRadGlaVDlR?=
 =?utf-8?B?bFZhRzNvOEw4eEZBUDFBcCtDZG1ZYU1ISnhXR1kyMjRwb2ZhdnZOZmdMaTRy?=
 =?utf-8?B?QUNIU2xURDR0eUNaa3NNR1Q1YVZzdGQwSjFuNXVQM01XUy9LbVBMZDY3MzhT?=
 =?utf-8?B?WktFUERBZHhXeTRVcm82K1AwcER5VzhTZEtEY05UMTRMMUhIZWREaXM1NUVL?=
 =?utf-8?B?S0ZlRmVQMEw3UXZnUURSMlRPeHNpemVpYlpDYTlPd3pydE52REs3RkFqaDNL?=
 =?utf-8?B?N1p2alRWQnZPOXlUNVJtS1psNk83THlWRGRpYzA4Yi9Jb1U0YTF0dWdIMHlx?=
 =?utf-8?B?UHRTNTRkTmZRZUJkYjlLOHAzUlNCQXc2ZkpvNUtMNWNGV1VYeGpaaVlwc1NB?=
 =?utf-8?B?U2ppcEhpaWNqaVltdlhuTkdjdXNUUnRSblV1Z1MzVUROWnZGUUdQc3BBYVA5?=
 =?utf-8?B?d1FjTXJNaXl0SmpxdFAvQmFqdHhXV0lxUzliTW9rMFVhWjFsVVQ2ZmtHVjNj?=
 =?utf-8?B?NFVYcFFkai9rMjJqdVRRaG9ic1ppNUo0Z2Z6dXA5RTdKRlpBTkwwR3k3RHR0?=
 =?utf-8?B?ODVjREtack00bmpWZTZlbUFoTzZIdG9valhDVmNJSUVRZkcvOVpuQzl4VTZG?=
 =?utf-8?B?aDJ4L3V4STcvTWhoN3RnRVlvd0E2N3F3TGw0RWdLWlIyWm80S0Q0dTQyOGFp?=
 =?utf-8?B?WW81clJNNHM0d3Y5bk42TStlRTJIVEdPTzNqUkFsM2RBNEZmaTdUZUM0Zm0x?=
 =?utf-8?B?elhXSGNZYTlXdWZCdWdjLzJ2bDlyay9uVjZYMVZnVnkvM3h2ZE9Rb29MbDI4?=
 =?utf-8?B?Z2luME04M1JpcWM0dkNtejhPZzlOckhTMDNLcWV0NkZsbmRrWUF0UCtNMW83?=
 =?utf-8?B?RWFYNk5Zd3FxUE1NblE0Sk5kaUszN2pVb3czSGVPS3NkY2tGeC8xVHJMV0hM?=
 =?utf-8?B?c2JiVCtJYUt1VTlXMjIyZVpPbGRQR3BTRXp2ZG1FVlpGbjJUSUYrSHNwMk8x?=
 =?utf-8?B?T3hMZHRvL3MyT29BZGFBYmVoU2lmQWszNjJaQ0FWTVBSUmgvY1BNb1FFdFZG?=
 =?utf-8?B?SHp2a0RpRDNNVmxWS0xHRHNOZ0w1T1h6MWhDMVZNdHlyVHE3Z2JXNWVkZlJG?=
 =?utf-8?B?eW91N05pSkZxSXk5V3F5a0JORUJmUjRzV20xUkFKZTE0NHVzbStsYTIxUk1N?=
 =?utf-8?B?RUVGU29qTUVxdTQ0SWZCQjBrMGYvdU9FQnNiN1dtTkJ4eVVHOFFZeEZLaDZS?=
 =?utf-8?B?encxOUpua2RoQWQ0T2JaT2xYZTNwdE9qdUtYM0ZQMTRWdjY3Y01hR0x1MDRl?=
 =?utf-8?B?VkZSUFlYam1PWnlKMWZES2J2anpzUEh2REt5ZkZMODRJaGJQbW5yTjZKSGRp?=
 =?utf-8?B?ZmxWNzdNc3dwVk5IY2lRcFN1Y09CY1BDMmxUTWw0aEo2VGMyTUJJOEtrRGF4?=
 =?utf-8?B?QURJS3ZOUlNaOGh5cHBqNmJkWFk3clNTWExwWHRPQW80dW5yUVRhcFZ0QUg2?=
 =?utf-8?B?ZFl3U0NHamdSc1hvc2N3ZWVjeG9vbUJSd0VEMDdidWpKbEZYcWxZUmx4Rzdl?=
 =?utf-8?B?UzluVlVRaERpa00wUFAwU1ozSGF0NkFGa3pTbGJWSDgxUFFjM3BLcUtHcmFz?=
 =?utf-8?B?Y1pFLzBjNGtMMHA3am9kMGNXLzVqOHpTa0l1cDNDNGxUOVpHQlZvcVVkQ3VW?=
 =?utf-8?B?dHRSU0hneCtuMEJqbzZzMTBWckpETEQxQWZSWkxCdkhzdmdaT1M5Q1EwZTRt?=
 =?utf-8?Q?jO7ivadUC/0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2pjckFPQ2wrcW94SzFoZ1VlSnlFTDB2Sm1TbjgzVzQ5ZmM3YUJ0RHRvSXA2?=
 =?utf-8?B?UXVpTzZJdDhmS1RSN1lKTVAxQk94dUFOTnI4ejNlSHVWVTNiWWFYQXpoN09N?=
 =?utf-8?B?TlFjbEcrUXcySnVsVnI5UGtqclJmY25WS0xKdjhoRFRSZDRVUFZETTVOSC9r?=
 =?utf-8?B?YzFuKzNPOHBwMEJlbU56MnU5QmQ3ak9kMlR0UUxRelRQNGdmREoxRWFVdmhQ?=
 =?utf-8?B?TmMyNWRNQ25FaHAvSmdDd1ZqQTVNUTFkZ0JVMlpkd3JJUkEwaitaUGttNjcr?=
 =?utf-8?B?YXZURytHL2w1R1p1UzFMTlJ2Z3NLRDRlSnNaYWJKUHpyeHJWQjZxQk1YWjlG?=
 =?utf-8?B?ZFRDSXhZdzQxMDdhU1BDczdXSGNXK3J4bC9NWlJwZG94K1lnU2NxWWpFWjlJ?=
 =?utf-8?B?YWw2WEM2dStLZjVCaEZPMzU1RjEwcEN2aUNYbk13bVE0MnJZaHNHbVRhMjEy?=
 =?utf-8?B?T1NFSkQrWkwwZWRoc3pUN1hHU01hV0xHWThBdjA0OUxNSHNYR0w2Qk9rYjN4?=
 =?utf-8?B?MXdteno2QTgxWmtPUGM0RkdBSHAzSmxlN3hMRlpPVjFGTmpMNHljWDBLKzJH?=
 =?utf-8?B?QnFDd1BOUmY0bkg0U3pSZEtrTUFaVm84U2czeGNVRzVlb2JFYUhhZFNFeGRK?=
 =?utf-8?B?T09CdGc0azJZT0FUbHM3cW5vdTN2bG95SUo1Wm5EbDROWXN3YW5EYUltd1Jr?=
 =?utf-8?B?aDBUMzB2NXQ0a0luaFZ0dnBtM2ozZW5BbXVvbVY2SlRQemswbThTMFBXUTdE?=
 =?utf-8?B?bjV0Y0JHZGkvYTdlZ3dSZ1pCVGpVd1N2L1RPcjArazdwS2ZOdHJRMmlpZUpK?=
 =?utf-8?B?dWFWeU1zZ2g4aTJLTUdReEJ0VXVnTnVxMmpaSGpTNlo3d1pkTGlsRGZKSzU5?=
 =?utf-8?B?YnJadmxCN3VuRVhZcjBCQzRIcTI0MkVRZEoreXZtdHZ5TncvQjkvcHNxKzBX?=
 =?utf-8?B?akFEdG8wU3pxQnRiRkdZcGRiS0d2SWJNclEvbU01b2czRDU5bWNyZ3F3NWlF?=
 =?utf-8?B?QXlvZXNnYU4yWlNhbHNtYXVRQkV4My80L0VELzFLMWtNc0tMZk50NHMzYTVB?=
 =?utf-8?B?ZVJFT0paOE14WVBBUHFiVzRTSUFOWXNQVWdhNzQrSnMvWEp0K2FpZUx3Tkpn?=
 =?utf-8?B?YzRjekZUb3RpRFgvaitiL2QrRHQxOFI3dmtWUHQrQ1lIbTRyRG03MXFaTC83?=
 =?utf-8?B?UTEzeTFDOWNwYmcyVWN3NkxFRlRLUUp4TnAwaDE4eHJqYjB5b25jdUljZlIy?=
 =?utf-8?B?Um9PSXVKZ0lMRG9KcC9JTWYrN0g4TFRwVmpxYVpvQnhpWmVET0NmYlV0WTVj?=
 =?utf-8?B?N2loSUQwZ1RraWpFNExlcXkrS1ZCR1QweXNyKzBvYk05QmFFTG9jemd1N3dY?=
 =?utf-8?B?N3pnY3RoZU4xZGdMbDYweS9QMHIwUUphVndCNU5nejJyMFBSVU1VYVlndTc4?=
 =?utf-8?B?czlPeXlMVTNuaGgrVnhmbDV6OGtUK0JISC9FQXIxNHNmN0dWaWJ3OUpHTWlY?=
 =?utf-8?B?VnpJN0JIMHRJSU5IMFBmVGh1TlZwVHliVGJXZWR4Mm4vUFBXMDZEbHRNOUpJ?=
 =?utf-8?B?bFF2WmdZdVZEM1NqYlhpRDkrYW5YbFg5UTh5QU1xSkhEQ0xmQ0VBU1BwTHE3?=
 =?utf-8?B?VEh3Q0hVMXR3RGRJaWFiTXZ3SkYyTS9uZzJvTlJja1k1aGNsWE5jb2YvYmRW?=
 =?utf-8?B?NDhIVWN1T010UDNVOEVvTmJYa2dNUUM4c3RTQkd5aWo2UUZYaVJLNUxQanVN?=
 =?utf-8?B?ZWhnbUZIb1FQa2N6L1ZSUDV5blpRSVRiWWdicmVBT3FkTXRwZW11cmVKQ0hm?=
 =?utf-8?B?Q1IxdGQvdlBncmM5RjdiUS9Vcmt2T2R1U0pRaVNSWEJlTVM4T2p2QlhZNjZV?=
 =?utf-8?B?QnNOMElGRGFIcDBYcEhRRE5jQzJWRTc4ZmJpaU55aEZTRTVhdXpnaHRqVExo?=
 =?utf-8?B?QTFsejQzbkYvbmtLNTJUU3ZmZHptbE5vRmRBZ2kyYjZnVXRNUHhGNDhnMjhU?=
 =?utf-8?B?cWZPanhIbVNwcy9iWlR5MGlmYjViUVF4VENNclpxTDRLYlZhUVR5UVBScHJI?=
 =?utf-8?B?MnJZQXBTYTNKaVkvaFNWTVdxc3dNMHRKbDNxSlczMi9udXVaNk55bTJvZmty?=
 =?utf-8?B?ZHhkWTRpa2EzR01seTJyYnphTzlYNVEzTkZoRDdCWEp1TFQyV0Fxekhua0Rn?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4923883d-70d1-4aff-b67c-08ddeb130493
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:55:07.1580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9qgPrUXYeuOrisnAakM3WmESESdP6pqQ9CTgGbMoCSRcGJnNSIRj3L1P3tUqxgtYulGaDRpgGwLZg8kmG3jcjH6SbahxAdBR64yJRVEOOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5792
X-OriginatorOrg: intel.com

Hi Babu,

On 9/3/25 10:38 AM, Moger, Babu wrote:
> On 9/2/25 21:41, Reinette Chatre wrote:
>> On 8/14/25 7:25 PM, Babu Moger wrote:

>>> +
>>> +ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
>>> +			   loff_t off)
>>> +{
>>> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>>> +	struct rdt_resource *r;
>>> +	u32 evt_cfg = 0;
>>> +	int ret = 0;
>>> +
>>> +	/* Valid input requires a trailing newline */
>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>> +		return -EINVAL;
>>> +
>>> +	buf[nbytes - 1] = '\0';
>>> +
>>> +	cpus_read_lock();
>>> +	mutex_lock(&rdtgroup_mutex);
>>> +
>>> +	rdt_last_cmd_clear();
>>> +
>>> +	r = resctrl_arch_get_resource(mevt->rid);
>>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>>> +		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
>>> +		ret = -EINVAL;
>>> +		goto out_unlock;
>>> +	}
>>> +
>>> +	ret = resctrl_parse_mem_transactions(buf, &evt_cfg);
>>> +	if (!ret && mevt->evt_cfg != evt_cfg) {
>>
>> ... is evt_cfg of 0 (a) a valid value (that will not cause hardware to fault) and
>> (b) a reasonable value to allow? 
>>
> 
> The value evt_cfg = 0 is valid and permitted for both ABMC and BMEC. I
> have confirmed here through verification and testing. In that case, the
> event counter will not be monitoring anything.

Thank you for checking.

I do not know what a use case for this would be but I also do not see why kernel
should prevent user space from doing this. Looks like event_filter_show() will then
just print a '\n' that is expected. Are counters expected to always return 0 in this
case or will they return an error? I am not clear on what qualifies as "invalid counter
configuration" for ABMC that results in RMID_VAL_ERROR.

Reinette 



