Return-Path: <linux-kernel+bounces-797604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023BAB41264
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7661B283DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F264222593;
	Wed,  3 Sep 2025 02:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gg94ARUF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA002AC17;
	Wed,  3 Sep 2025 02:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866829; cv=fail; b=Rzxhty1RE85nN5PPfjpCrUIHyJ/teCne+pdLZRNGJNnxWpbfcJS+CELUwrYN1R27PsEfHeCDB2tRKp1y4VWUYDpkPFmK82lIRUoattVwf2G1AL3LYo62mkNu3OVsiHOY4Iym/36CjAdanYpuGlI4BdvkHm/OYaX6HcLR7CKngc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866829; c=relaxed/simple;
	bh=nkKABi9+KOqgGOHmVuFD5wf0/iIOdztx5ufYeLuqOE8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uBw6FllBTWHA5u2faVvuVr8KCNLOhNvDuSfUEFj1zHalFCe0fjad6a2PzPftFf5uza5fmpdFuOQBo3NQ+2bOIv32v+Pil4VU6pwpq3cL3NGakDFhkWAKlVBlzA9HPw3luAQ4OyJR47NasTfXMl2KJ8BFM5r8CXBaoJZh97ioAAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gg94ARUF; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866828; x=1788402828;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nkKABi9+KOqgGOHmVuFD5wf0/iIOdztx5ufYeLuqOE8=;
  b=gg94ARUFEjyyG8u+k/qzf7dpyzsC0esarnulXcQeV9AoBS7NuvuS4/mp
   +OCjyQFZUX8bnpyl7FnBVJ1aOKLKgTiR9t8r6jT3iuRIHpszptyBl8hAh
   UWf5j7Oc5y62eI3A+Yf3TNXa4EcCNz52vrB9s1K79q+S371G1qktix4aK
   g0WG1k8PaKPAc8XsKEpSppcRBR/5+0mjN5ls8DEPH2FKteYze34eOlC91
   MtpuVL8w7lrIATqH8qyy+Lnuu+cUli58OCZqmRmMpDTbxTonsqhHODSdF
   lIaqfXRwKauv50lb+usNvmNqgIiPHE6gIaG3U+E6E5X7hA5z+129JYE3p
   w==;
X-CSE-ConnectionGUID: mo+bnS5RSz2rsJPssnw9Ug==
X-CSE-MsgGUID: qbSxinJhR6SWOCMQOoWrkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59238294"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59238294"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:33:48 -0700
X-CSE-ConnectionGUID: twRjA9SMRtqURHY13KlR5w==
X-CSE-MsgGUID: 8O0n34HjTpaaeC2A7cHR6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="208669585"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:33:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:33:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:33:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:33:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMIwWAza6p8bBu/MNKp99Xd5dhxJHSfzv4GZFZ9UqM3CKKiLNXDM41g/s+p/GOZHzFH2cGwxMenH1noE+Kgm4HYkIvUwI8p7W9ldBF5o/Q3eINKy0gzc6HyGRYLbbQnfUzNIX0JM3IVcJibhWoZtKRaKkjvT6iICCJIlp7+0vbMJrwjpv4zOJTQedrk/EtRC27pRBpXZWep99azBkWYXYMXMoVR2qnj6aVLrVmS4sFEHyLyF7ETursZSydyE3IPARr0GbWVhbNa69rrjXGrSeEaH6SlmibsPMKpiN2UB5VrgHP8b135ZcvYiifGtfojU4CKwp0G0V+oYRQzdPeEm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aAMpGWFDwx8m1ICLxjTSYbKnH71QZk0u0IKzZgsxXo=;
 b=G7JEKBqVOYj3oSXO3G/vhZkEu8lSQaUSgioVMPzIUQI7azXrQkX6PKpht6ans6TvmN2Yknv1gvzoEctzR4TpNKZfAMhFoXbk2HiaZToo+2gkyLzlyEUmokOa/6iegBwTDjR/vUJnNl6ujLlQI8oTnmYSVbieXK+rnjN14XRScbAGwOx8T2ePKvbteNRGx5q5hMwGu1lTl5cjVTXUSIFzJiy66rdUWHU+200fOHW1wJbSeew/3u+gjdc/Z8WNsSE40UTprXXkIkUlPuDoWXZ6rVMiMJ58Yux3wRzFpyjPq2hfVR1Nw+qBPGEno6BSgBc0dCoSiOnjbZGMDC95k69FrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:33:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:33:42 +0000
Message-ID: <913e2317-9865-4252-8d14-2314ff9413d1@intel.com>
Date: Tue, 2 Sep 2025 19:33:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 20/33] fs/resctrl: Introduce counter ID read, reset
 calls in mbm_event mode
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
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
 <c007d6e024e9c8c302b7996ad73bfad3312e13e4.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c007d6e024e9c8c302b7996ad73bfad3312e13e4.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:303:83::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 999c53b9-247b-4306-0e11-08ddea924c18
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGc0N0pmSHpvRFhEa2pjQUNvVFZ1YjhHQVRSVjFpTTFnQjB2ckhuSXZJL3BE?=
 =?utf-8?B?MTdtYm9NbHU2Q28wTzVxL1dka2hoZHFRb0tuM2wrdVNaZzQxR3pqdDFTdzhy?=
 =?utf-8?B?dE5TQjBuM2dMS1pncU1CTDhSWXZpWHUxelhrNGlDeVBLejFKQkM5U3NkT3lz?=
 =?utf-8?B?TTRoaVh3OVM5T3c1R0d0VzhSaUF4ejZuRlRhMDdTY2ZydzZSTjdGQVRhbjBx?=
 =?utf-8?B?ZS9aVHNleE5QSlR1c0hDeHgxVE9mUjJGcHBhcndneEFaemtlUmFmQUZJRkI4?=
 =?utf-8?B?SCtoVjk1R25HUXJobEVDSkp2cU0yaDNtTnYxakEyWllsZmVQZHh4UkFmQ3Er?=
 =?utf-8?B?MEFtZ0FOd0xNdi9sdVJOUUdvN1hYVWZITmtyemRDMlJRQmpiVCtRN1lWQjNz?=
 =?utf-8?B?ckhCRlpLaExIa3J3elEwQi9yK1NtbHJRVEdMSnQ0a1h2K1JXNjF0RG1zNkFh?=
 =?utf-8?B?WDg2Z0J6Q1NHRmh4bVRNODRyem9tcGlxSmpSOHZwWE0rRTBQSUVqQ0N3Y2xZ?=
 =?utf-8?B?U3dLVlFXYTc3VE40WVVVakNQbDVaRlNTeVZIa0cyL1NlSytYQTBwYm5lR21N?=
 =?utf-8?B?bUdwa281cTdtVHBzRXBWK3NYN09RdXNwVXBzK08xSlk4M3NNRkhWTzNBejNE?=
 =?utf-8?B?WWJiMElkbjZ1Z3F5ZlBtR0xNdW5tY1Y4ZCtTMEJLRGJ1bFpudVg2bFBOWlgv?=
 =?utf-8?B?bis2dzVzUUVFME83Y1hoWkd3N21oZUIyMXo5eGhJd1I2YXY4c0hEZCthbU1n?=
 =?utf-8?B?NlBha1NBSkVVRG9tN1ZMdGhibWtObmRDSklaa2cwZVZLeGErN1NKcDBWakIr?=
 =?utf-8?B?c0JKbElKL2ZQcHVxdS9KUjJNTzBCVWNLdExiMnZ4dmJNWWNLa2o4Tzh2OWNu?=
 =?utf-8?B?aWd6NkV6b3huOEI1M1pyOVhnUEptanliTTlreDU2cnBmbFRrV0hsR0IyVnda?=
 =?utf-8?B?bVNkT25FdUF2YUZ2ZmdVNStSSjg5VS94WjEwT05IUFhkZjZBU1g2djBtWU9Y?=
 =?utf-8?B?ZlRRNnBIdTQxcDJiSUNyNWFDYUpjZlIrUXlRbXBHdnQybDJTL3h4OXBOMWhL?=
 =?utf-8?B?Z1lmZ2hDazUrVjRYK1VxcGhpWUs2cjdVL2ZicUxCcy9Ob2gza0Vnd2QrVVc1?=
 =?utf-8?B?YWlHbEZoZzFMS2FPSnhFNnJCaUV1akNGYlQ4TEJlTHZKVWE1eHM3QUNtekpa?=
 =?utf-8?B?MzZNaW9JOVkrZENrVUxTbGhiNEZwUXd1ZG1TYm9mZ1V4RzM0ZGNUYjE0NnV5?=
 =?utf-8?B?eDNEU3NYNG9RQURzcUhhb0lyUXNwOGVmRU9iMWptMVE4bVQ2WitJOHd6bG1P?=
 =?utf-8?B?b2FuOU1neXZTNU9jUlo2Q1RxVXMyZ0JkNmdJK3k5Yk1SWHU3Vnl5UTdPbFEv?=
 =?utf-8?B?cFJDdXo2Q2JKeWIwQnQ2MGNYaXRDc3lJYTVXTDUxQnF0Ym9ybElaTjMvNDND?=
 =?utf-8?B?eXA3QTBQZHJqR0NHcG12dmdZVmcxQUd6SDcvN0FXb3N5bUJCR0FFQjhMd0hx?=
 =?utf-8?B?ditZZ0daY2NxS2NwVzY0WW5tcG9ZTTFSRFVnU2E4TVArTnVaWFE2WEFmTitO?=
 =?utf-8?B?RDc2WkRmdmhrVkxNZUVyT2NFaW9BTGF6NXpUdnArZlNyd1I3aGlHOUxDbE5J?=
 =?utf-8?B?ODYvc1N6K01RZzNBTWNUUTlIT29hb0M0SEduenljMm9lUlZxZEJhSC8rTHkr?=
 =?utf-8?B?d1RQdmlTb09oQW1iN2tTaDA4NUlMVTlpdUFFMThSYmNpdkY5VWlQOGNFMGVR?=
 =?utf-8?B?cjhrVGpPRlpOM3Z4aVFaMSt1b0Z5cUtnR1hINVRGQlJTS0s0cEIvN2ZYVTQ2?=
 =?utf-8?B?Rk9JbndPWHdieE5IMzNMNXhXMVNlbURXQnc1VEZmNnova0krM1VhUXZ5dWVm?=
 =?utf-8?B?N0E2RzNHT0U3bkw4QmJUNkJPRUtzWGkrYmZqSHEvSy8wVjZvK1d2WmY3dzVo?=
 =?utf-8?Q?5ZdheWiln0s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnRsMHFqeHB1c3FtSmdnQ1lGZmp3MjNPeTVmMkZ5SmtwclQzSGpXTi8rbytw?=
 =?utf-8?B?SWJ5UGdHS3RiWFlFK2lYR2ZRRkxlQmNYSVlqOUJ4eUhmYTFVQUdrdER3c1lq?=
 =?utf-8?B?S0IzZE5WMVNGMWUyL0tBQVNxbFRDaUtUZXBIcEo1WVZqVHlPR1FmOUN3cWNk?=
 =?utf-8?B?L3dtR2E5NjR1L0dkSHZoeFJ1WFdZSzVIcXhXSGdhbTl6SmpxTFgvUkFGN28x?=
 =?utf-8?B?SmtxakI2QW50bmVTejlKaC9Gd1dXZTQ1by9oMWxFVXV1c21hWlhsTGsxUGFW?=
 =?utf-8?B?Q1VrbkdYNHd0dVNKcERUeWhZNm16SFU3TjBlS3BQQncyV2RJWEI3eEROL0E5?=
 =?utf-8?B?dlBpWE9RK2tDWE12Rk11dk1sdzBFMjdwdUdHdzE5T3Evc0Nkc2VKY0RNSWVP?=
 =?utf-8?B?RHFNcWJhQzMwN2tEOWgxdjkxQ1BTMHY5L1pUWUhqMFVrQVpBYUVrOWlXampR?=
 =?utf-8?B?aS9RNnZqam9mY3ROdkd1L1UwbDUxeWZBV1M2RU0wQ0lCcU40enRMQmtrNkxD?=
 =?utf-8?B?WWMrT2pCTVl5ODhLWnBzNithTEVBT3ZkbVVTazFJVDdVZVl5K2M1OU1HR3Na?=
 =?utf-8?B?enEyK3FzT1BPYTVMNHJDbVArejZVQnlJa1ZwcHhyY0xiNHZ5cVFvYk4rMGlY?=
 =?utf-8?B?cnNIT0RMN0YzMmpsRFU3ZVF1Q1BrN2ZkWGRmYmZaZXFDcVdJUTdEMXU4WWIw?=
 =?utf-8?B?dVZETzBrbDRoYUdGKzNFenJxRERPbDk5NzVRbnRoaVZVV01lSnFKN0k3MlI0?=
 =?utf-8?B?T2E1TkNNMEVtVW1nazI5a0ZkQlpmNFdUTHRyNGdWamlSMUNEWXFTUTUxdStk?=
 =?utf-8?B?OHlPdU1kNFFBWDJWQzRuVnFxcER0UEVEdjVYQ01aQzNxNk85RkFrQ2FZUGli?=
 =?utf-8?B?K0VMWHZKQlFrUWJFMEIvb1Y1SEpXbGo1QnMxT3hDMStKS3kyTms0QzJZaVg4?=
 =?utf-8?B?WjBBSGx3Q3NuMkpGL0gzdlIxcFpMWTBIOWVuaVZadmplZ2NrbS8xV2YyOEN5?=
 =?utf-8?B?Z0F2aXczWURIbFFKTTJuNjR3SVZ3V0hmU0V5ZHdoSzg3bHltNDRITm1nMWR1?=
 =?utf-8?B?OHJQV3h6Qm1ML0FIVDJZclZSRGhVUFF0R0VOUnYrazM5Q2hKQmc3bllDSnB1?=
 =?utf-8?B?cEtvUDFZUTJJYkhVL3pxMVFqOHlpSzlkeDNMejB1bS9DYkwvRGN6RGw5UktQ?=
 =?utf-8?B?cTRGYTlLSkhQY2kxMWw3VVJuTmR2MHlMeTRYWkhYQTFiWVh6bi9oQVcwQVRV?=
 =?utf-8?B?bnczWi96THo3L1NEeENNTnd0NzJlVHNtMjhmT2QvZHpVdyt4L2VmWi95OEY0?=
 =?utf-8?B?cXJGam0vVVIwZnZidWx3UnlReDJTUW5UakdTNU5Cbk4xZWY1Mk5Da0xCN0p2?=
 =?utf-8?B?WVE5UDQwR0V4YmZFYXc5Y2pjanRFZWJKOE9GMm1IbHp0UmIveGtiTEVrWnpE?=
 =?utf-8?B?RUZOTm41WDhMcWRWMEdnWjNmSTQvZEJuZ0VYSWpjWWgrNXNYMlVUZnFVTyts?=
 =?utf-8?B?RFE1a1ZLZjBVRjVEZ3g5OTVZOHJnNmZIZG0zU2M1MDlCTFI3SE9Ma0ZOUXAr?=
 =?utf-8?B?Qk9hSzNDTGVpb1RJYXRHWHdiUU1xbWNtUTdGd2xrUEY1MFhaNkRMa0ZnR21j?=
 =?utf-8?B?b3RWSGZSVWgxYjNvSDJoMlQ1bUdKNDdTVDlWU0VIc0N6YXlCeG9ZWmVBTjZv?=
 =?utf-8?B?LzUwNm90QS9KZDczVVBEbW03dnZtRmU2dERQTjVIRnd0U2NiREZtWHAzU0lW?=
 =?utf-8?B?c0RHeXJqV25WakduSlRtNmFnVzlqN3g5VXhhNGE5VFZiWkZKcTJGQ0VnNmQ2?=
 =?utf-8?B?eElYMWEzQlpNcU5Ea2dnM1Q3UEQ2cW1jcHQyUUY0MStWZTdrL1dITSsxYkpR?=
 =?utf-8?B?ZExVQ2xtNUdVd2Rwa2pyM1RLa2JkTUpvcElERC92bVFNU2IxMHVaSElQSjla?=
 =?utf-8?B?VWh1em5xaVZ2TWVaNFhzZ0hOY1pwaXZDRnRXZURKNmpmdEUrcDl2Z1U0M21o?=
 =?utf-8?B?bHdOVVNnRzUxWFBFSmplT1d3eW41TlhkWTQ4OUxZbGc0UVNJZzR6RmtSV3lG?=
 =?utf-8?B?NW5sRVNPVDZxek1JLzN6ZktRTjJ2YTJiMUtrazV1ekJ4eUFLZkdWSElUSzdE?=
 =?utf-8?B?ZitORkpCN1lXcE5rZndDRW1PeGJXQlB4SGppeEJ6WVlkZzNSL1NwV2xsY1R3?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 999c53b9-247b-4306-0e11-08ddea924c18
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:33:42.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bH8HWUwYx0cTEOyJxT2z0wjRNEDrkpWsQpS3Y53bkcqmZGFhXJYir/7cJOMFXuLSfs4Q2EDgZ1YdwUhVMjiry8lqJhunzYQCNC/hhOiIbqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> When supported, "mbm_event" counter assignment mode allows users to assign
> a hardware counter to an RMID, event pair and monitor the bandwidth usage
> as long as it is assigned. The hardware continues to track the assigned
> counter until it is explicitly unassigned by the user.
> 
> Introduce the architecture calls resctrl_arch_cntr_read() and
> resctrl_arch_reset_cntr() to read and reset event counters when "mbm_event"
> mode is supported. Function names match existing resctrl_arch_rmid_read()
> and resctrl_arch_reset_rmid().
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

