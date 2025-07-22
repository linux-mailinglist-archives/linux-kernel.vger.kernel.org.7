Return-Path: <linux-kernel+bounces-741078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB88B0DFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7BC17433C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6020E2EAB9D;
	Tue, 22 Jul 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMhl5y/f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E22E9EAF;
	Tue, 22 Jul 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196227; cv=fail; b=pxjwtlI7yrSe3NYKloi1QHfZI6W8sL9oCKDr3DgV2mP1YoALEtIB2H40zL70/67Lu6Sq+D1VxekMBZO1twHKU/SSjNwkuSUOtDlNAAa0K21S9FjVSPSJNulBLzOHLwnR3lumqUi/tlR6ht7B0aNU5sdel4jSB4agE0+Im4CS9wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196227; c=relaxed/simple;
	bh=E/SzaqCrZlfFuPEhryq9nA5MUSat+iy9mID93pauP/g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eH8C+vEGmbk3uQDqZqbgZqrmnMDQIO5aD/U0F1puUds+TNgWhnCeJi7vvGY+pXJqbPDoFrGr+IzZHtTs5IrF9eg/aDKU17HTurp/n8Epm/OrSQ44S/Y0+lrdORAILMKonDBpPvwX8x+T/0KW72voMHIXKghGtUSc1eXmqniSHak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMhl5y/f; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753196226; x=1784732226;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E/SzaqCrZlfFuPEhryq9nA5MUSat+iy9mID93pauP/g=;
  b=nMhl5y/fkIbjp0SK6tac9otkxBxK+EElqHYLU9Nv411uYsBgc0IskG+O
   PdT8fFty9+GXigbA8PfjFpIytJv7xN2WVkzn5zhLqSstoVgp1Y3RNf27H
   l4bZ1Nk6x6aQgRI5HQzpX7/5E4Fl9c+35ODWfdA+EkumvyGnS9+kl4+qg
   lIbRellcizmF7huVKY39w3+ajxKmQ1NThNqrQSe/LNW9Q6UK3ewx5HrWM
   dNLGMB2eLAzofzT8mIjlv3AOsUE+P+RjWM9VvwSNCKbEISHZpUcJeG1eM
   m67GNGofMwtT28iVUGLRpE8dPseYFBCDypwuiC3WUNXQulPSQLU7FBpXh
   A==;
X-CSE-ConnectionGUID: BDPcq2AYQHC3cM0ssYoQVw==
X-CSE-MsgGUID: vMHprWrLRX6qgHP3Qs38Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="80894558"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="80894558"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 07:57:05 -0700
X-CSE-ConnectionGUID: V8kfqrFCRFi4TxRsrc3hVA==
X-CSE-MsgGUID: FwSm8csOSFWKNfqZWbJdJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="158834732"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 07:57:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 07:57:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 07:57:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 07:57:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv7tj/5JxpU9Qr4fGAfNClcoUDrK4IEGS8Jk6CfUltxorwUr6xCPCJJ/H3KmtiHW59M6EpG4EXpjUqzt9cU+GWbtkp9jG2xDRjCm9XiLlrSDz7W6HxctaOMA/6AMt9LDuWC5WK1IdNIToIEYseo5ILo7wrv7DgX8LtAgRB8JO9QcQY7Zu50DdRmS9BfKlwoRzOEseFmxiewtE5R7hQ41Epri3A4maCWfayP/9EhlLryTY3aLdUS60dEcjm88+/wmsOc83bNDG36HD5yAxM6hyHVg93Aw9OMu51s4C1ASyOhngcfcl6iDk2psxfpBMOE2jr1KJ9Yy0aTz+v5gi0+oaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IihCeK09l4Ys0rschryvpV6cS6i4yFF9Jelmrz90OR4=;
 b=WxHrtI5Z5GLTexND9Z9pkVUIKL+wEx/F2VSOovoJTEcArXI4o2RVFwvgamVR5H5SfyX5TaeOzCU2NwqKEVygEDsdttRMCwlK69MbTU7v/pfAZLxTNMIWsxlMlYD6iVuLnpW0dInjWDqPHjen/ML+AVJ6LyXZe28ApU/HgPi6hs+cCzvYuKYUcCkHi4/a4I78AWCksajMYhoUs2X/t3CdQXXaIj1X5+542rcn2jjzvEVfXOESAt6/BJVkt99Jlw1PwnnU+4BqZzp91fShUrtIkqqMoGDx+i1eNGA0YJAE6JvKRj8u6ynWi1s2KCGk5QNBJGASm5nJ81nIYOk4qxOX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7763.namprd11.prod.outlook.com (2603:10b6:610:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 22 Jul
 2025 14:56:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 14:56:31 +0000
Message-ID: <0770f2db-2def-4cca-8e20-9bb864a46511@intel.com>
Date: Tue, 22 Jul 2025 07:56:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 21/34] x86/resctrl: Refactor resctrl_arch_rmid_read()
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
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
 <7cab88ccc3e0e173271c9b12fce22785bbde9239.1752013061.git.babu.moger@amd.com>
 <d240b37c-e00e-4b6f-a0c2-267041aaf9de@intel.com>
 <cd5bc14a-8b96-40ac-bd5f-7ecedd1d3464@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cd5bc14a-8b96-40ac-bd5f-7ecedd1d3464@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 73508509-581c-49bf-7fd6-08ddc92ff189
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEYxYlZNN2JtNjF6cVl1L2JpcEJYSGEzRWFlcDRZNjRteDQ3d3hlMFRKTTFP?=
 =?utf-8?B?YlV3S2VBTldYamk3enpTVXBqQ2U1aXU0Z2JFUlovNFBNZldKRjRpRXdNWjls?=
 =?utf-8?B?eXlnWVJuclEwNWRFTHJ2NytXd1pzd1l4WWVFbG81UDkwblRZK1JJSWZFVG9z?=
 =?utf-8?B?bDNCM3NyamRVMmY0TUQ3OWRTVkhtRUlyVFFKNHlwTHRaa0UzVlVodWx3ZDBw?=
 =?utf-8?B?RWRFMDYxQzdCU3NVL3VPeEd2VlZ3N2RzMDRkbG85NWFPbDJEeExpZTlhWVBj?=
 =?utf-8?B?UzhhYjA5dEhGQlJMWmJISTBWelJ3Y0JpenRLLzAweUZvUzJlRDVleHczQkhk?=
 =?utf-8?B?aVlBb2NUYTJYVjFSbU5yZEFJbDZlYlVtU3BZZmpZR0VNS2Z0ZXFUbHZ2V3V2?=
 =?utf-8?B?cWwwbGpZaEhtdEZJcXR3bkxiU2NrSHl3dU1HcnAxcmxnMjdpZy90dkFTeUg1?=
 =?utf-8?B?akozSFJBdDhmVEZZczZNUEd1aE05dGx0QzNyem9tajVocnBZb3U2cmJKNVIz?=
 =?utf-8?B?UlVidFQ0L3kvT2FwOWxyc1FNVUJPU1Y4V09jR0Q0elB5TnVoM2UyYU9tQ1dG?=
 =?utf-8?B?UU0zVG91dFJTU2tNLzZRM2l5YUg3MW96b3RIZC9wYkVJVHZVZ0ZLOWxaN0ta?=
 =?utf-8?B?M3RTUzAvM0FtOE9uQVcwVERSSzM4NG1raFZNWXFmbVBnN3VkS2VOZXdCMG1P?=
 =?utf-8?B?K2Q3RzltRmpCRnpFTlczZDhNZGJQNG5Vcmp0a2dwemJPZnFaQUhPYlU5YXBC?=
 =?utf-8?B?eW54OEJXelVPNVhZNkZDMGtqUytLcCtVcUROTkJGd1pSdFFra3hsbldNSThJ?=
 =?utf-8?B?VEZMWlN5Z2Y5aG5lakxQdjJKUlQ3Y0dWZUVIQjZXRS9XRWZaVktGYlUrT0ww?=
 =?utf-8?B?TzJEMXliMXN2YVhMSFQ2T2g1Q21UUDZoSldzbzIyMWtyZGxIaXVIeXA3UDlw?=
 =?utf-8?B?L0M5ZkpOK2ExRTM0dzZjR3RrWEYrbTZQQ3FsVVExTUMyOEEvYkZqSHkwYVdv?=
 =?utf-8?B?b21OMzZPQ2dxclZiVDBJNXBqSCtDdFlnd2QwaE90SklzZTRhL2RTQk9rc0E3?=
 =?utf-8?B?eTRvTHliM3gwTWFYdUhyL09CVy83UkdIRG5qZUp4OUlhcEVJUEFRN0ErTGpQ?=
 =?utf-8?B?VUJyOUdIRTVLd01uTjlVRWdSVThZaXQ3OGl0TGVIb3VuTnVzcW1IMGpQL3hP?=
 =?utf-8?B?YlJza2p6K0gxbFFpMU1pS04veXFuRlkyRDA4d01takpOcWd4Qm50QUFwNm1D?=
 =?utf-8?B?SUR2REwxdFJCcVpkTlRCcUJydXBSVmUyMzBTcXJRNFd1bk5QR01wUmhLUmRL?=
 =?utf-8?B?Y0tqUjhOU3hhU0dBWld5Yms3blIwRmVvMHk0NDNsbjdxYjVuaE8rTXUzNmF2?=
 =?utf-8?B?U2kxUEVDenpTK29vaUhIaStNRllJVDk1aTVtU01vUDB6NDdSSVl5V0tJNFJG?=
 =?utf-8?B?SXYyUHIvcmV2ZFRWZGdGeFlad3NTa3dabDhkanBGSVd1N1hYZXhQQkJ0Wkhm?=
 =?utf-8?B?TnhyVFdmSjJYc1dWckR6WEQ4MGQ1d2g1S2ZSZGRaVmdHS1JkTGUvbGVZNWVy?=
 =?utf-8?B?anJvSUdXcjcxdXRnYmk0YzNqS1pLQmsrL2p6VkN4cksxcitnVkJXbE5hZmpB?=
 =?utf-8?B?RnF5TC9JazIxanp4WVRVaW11ZkMwT3hoaW0zcXZPc3UvWVNXZ1BTY25TNzQr?=
 =?utf-8?B?QkJqTFNzNkVhWjEwYTk4bmQrc2Z4aXNONFowUzhXb1pvS1NCNG1TK0ZQaTlz?=
 =?utf-8?B?VEphcUEwdGdkRjlhbnB4OHVvOUEwNXVhVHdyYXkzMFdDRTFFOHVTNEtwTFFL?=
 =?utf-8?B?aU5qcy9RQm9tSFZqaHNPRm8zbHB1UXRFL2hQU3JBWGxqZkVlRktJczRud0pE?=
 =?utf-8?B?MG5FWEJHdTJ4R3NlMUs4N1RsY2VWbFQ0elVxZGdTcHh6MjVYaTNIUmNyZ2tw?=
 =?utf-8?Q?88npbI0wXRk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THYyZmhBWXVxUjVqSGU3L0pvMGptWXVkMHpldjVOLzJpdnpyNG96SkJRMmo3?=
 =?utf-8?B?MjhITzZGWmJNUWhpYTd2dXd1MHhCZFdqL2U1WFR6YWtLRTEwWUphaUhuUlJ0?=
 =?utf-8?B?NmdvbE04RVdMaTNNMnZacGpXL0NZeXFVMDJDQWJWRmVOZHlDZDdETVl6SS9u?=
 =?utf-8?B?WFBWQXNGeVFvU0R3SXlkZXF5NWFZQ3drZktNTjRDNzRxZGZpNEY5cTF4OFRB?=
 =?utf-8?B?ZmVYYXpmcjJhNWw4UWg5cUZ6c1FXdWVHUU1xNU1HdWdEU0xCaEh1eTJpdnlJ?=
 =?utf-8?B?aURPcitvNXBScDQ5eUlmTlJnZTE2aHYweFpNb2UxUzJjQVYrU3pLc05GSGdW?=
 =?utf-8?B?ZzA3bm9BYlREaHFIUjlWK1hLT0V1aG9neWk0MnRFaWsyMjlKeGV1YlMxVjFH?=
 =?utf-8?B?YmdlZG9JZGZKbmlTejhYanNaaU1rUmNKcWJJS0RKTHFZYVVla2JIc3FmeUt3?=
 =?utf-8?B?UWdYS0g1SDhkWjBjWTUrZGsxRW0wUW5QS0kvSFp4ei9UdTM5UFVhZTlIdFlB?=
 =?utf-8?B?ODYxTmdDbU5vWXBxRWViSzh6Qm9zbmlITy9nZWJIZFdLSW1BR2R6K2hwb3Ja?=
 =?utf-8?B?dEJYdm9aZnQ0L1RFQUVJbHhUZURxcmUzbWhFVFdsZ1dTNFYxajhtallyTGdm?=
 =?utf-8?B?SEh6eHdvZXl2QUNnbXBSVDl1TmQyZUpxN0Q3ak5ETnlCdDREZnhnTm05Z1Bz?=
 =?utf-8?B?T1E3WFFpSlExT0pmV0hjSlg1SlpOWDNMeEZIbTBnQk5IOFcxWXBYS0toVzl5?=
 =?utf-8?B?T0IzRFc3RjhEY0tlSmtUUlRobGNkUHl5ZlVRbVdCUU12cml0aFNaWUNjcU5O?=
 =?utf-8?B?SndnWmFUWktxcTY2Y1VxbUxWc1RCWGFzZXVsdWFoTWlYaS8yUUlReVBHUXo4?=
 =?utf-8?B?cXNrK0FNYWQ2S2xZMjl6Y25jSnhMZWFqM2h2REhTUk1GbWR1ZjREUm9raGg1?=
 =?utf-8?B?Rng2RzNlV3ZwZlBXYU9MZStveHRPRnJCWVlqbTRsV2s3Rm5zOTlLQmFzanhQ?=
 =?utf-8?B?TEY4c1BJblAveVk1V3gwYlBrQ1RBUUVCOXVCREY3cWlXQ2Qyci85YjVuZGdU?=
 =?utf-8?B?cHdxcEtJSU9MWGFzODRKUC9TRHl5dFdnczhWTGExblZQM2hsM2w0eEpFSE9E?=
 =?utf-8?B?SE1panV5OEs0cGNtV0pDRVpHWE9SSGNPTzVTQTFEcTdQV1pYODIxSlh6WG5S?=
 =?utf-8?B?R0p3TitQYWdxVjlxT3N3M0JOZjIybE56enhPWFJ0UHNzSXRONHk3RXlpbjY3?=
 =?utf-8?B?bk9qV0tCREYxaS8zNUovMVVHdWtiNXBMNjZhVDhPbzZpUmYyeVRWWnMwb1BL?=
 =?utf-8?B?cFNLY283YjdNNGt6S3pBNncrTEEwZlVVZUp1dklaRmZzSDRkU1lQRUFndDZq?=
 =?utf-8?B?MTBBeTF3VDVlMWpOeUNVb3VQVjNIbEI1RHk0RG9sSSthRU9lRlVvdU5XaW5X?=
 =?utf-8?B?YjNQeVVBV1lDTzBHaFlPRUdlTGtBa2tSYlRkNEJOOVlEYlBNQUJjVzkwRzYv?=
 =?utf-8?B?YmZNMWtwMXBwYVJ0UkJGM3YvMjdjNWM4WkNYWDNUalRTZFI4NStxb0wwUVN4?=
 =?utf-8?B?WUdUT1lMWEFzY1FGYUJMVmxkamFIdVYvaDFxQkNXOEJuK2lTdHZvZWpVWTFI?=
 =?utf-8?B?ZHNKQlo5YmZPYVVKOHgzQjdUdEo1NjhkbGpMdmMzMTdFQ0JWbDRrRVlvS2cx?=
 =?utf-8?B?cWdIN1Y1bHMzK0NRMjlBK1BCdEdhVitkZXVWSEVPcTd1S29IVjlMY0IvcTZV?=
 =?utf-8?B?QWl5cEZIM28wS05kUjdIdVhDeCtDaUVONVJYMjgyd1k0YmRxbFZyUDdqeEZX?=
 =?utf-8?B?UkVBWWxNWHdiT0JOWDZMaXd1K0sxT3Rya2tER3pQMjRwR1BuTysyK2JiRHo2?=
 =?utf-8?B?WWVBdVRtTTBWV2ppMlJ1cUFjektBK3ZRVXhTSDlzZzhSbEJJQmFOa0x3b0lP?=
 =?utf-8?B?TG5ieGZQNkF5cW5OSHF1WmZzU1NFOFNSNkdlZHFvUElxYlIvUUI1QmExa2E5?=
 =?utf-8?B?TytMZG9TSm1tdWRuZ2dIR3hyYm14T0lPTmhBOXhFWmlSVGk1NGs0dUN4R3J2?=
 =?utf-8?B?SndRbXFxcElpY3NWcDQrUGVPaEpIZGpLU3I2OFFHOWYvYmhRRHNZdnBSV3ZK?=
 =?utf-8?B?bjdPclVtMmFpOWR0Y1JoOVcvbS9oNTZSMXFwNXBlemRkMzlpNmJhSXFERjNZ?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73508509-581c-49bf-7fd6-08ddc92ff189
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 14:56:31.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7YxrBvL1PyG4nQIFzhq8oEXeC5loycOAIvGf5epmVdMaFqAKOCEvsAcbVLKwgkrfvr1fYFxP8KVuOd26kO0u/zfsOhIur/xHpU+Zlz6AOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7763
X-OriginatorOrg: intel.com

Hi Babu,

On 7/22/25 7:23 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> 
> On 7/17/25 22:51, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 7/8/25 3:17 PM, Babu Moger wrote:
>>> resctrl_arch_rmid_read() modifies the value obtained from MSR_IA32_QM_CTR
>>> to account for overflow. This adjustment is common to both
>>
>> The portion factored out does not just handle MBM overflow counts but also
>> handles counter scaling for *all* events, including cache occupancy.
> 
> Yes. Got it. thanks
> 
>>
>>> resctrl_arch_rmid_read() and resctrl_arch_cntr_read().
>>>
>>> To prepare for the implementation of resctrl_arch_cntr_read(), refactor
>>> this logic into a new function called mbm_corrected_val().
>>
>> This thus cannot be made specific to MBM. More accurate may be
>> get_corrected_val().
> 
> Sure.
> 
> Rephrased the changelog.
> 
> x86/resctrl: Refactor resctrl_arch_rmid_read()
> 
> resctrl_arch_rmid_read() modifies the value obtained from MSR_IA32_QM_CTR

"modifies" -> "adjusts"?

> to account for the overflow for MBM events and apply counter scaling for
> all the events. This logic is common to both resctrl_arch_rmid_read() and
> resctrl_arch_cntr_read().

This may not be obvious since resctrl_arch_cntr_read() does not exist at this
point in the series. Perhaps just make it a bit higher level, for example:
"This logic is common to both reading an RMID and reading a hardware counter
directly."

> 
> To prepare for the implementation of resctrl_arch_cntr_read(), refactor
> this logic into a new function called get_corrected_val().

No need for "function" when using (). Could be :
"Refactor the hardware value adjustment logic into get_corrected_val() to
prepare for support of reading a hardware counter."?

Reinette

