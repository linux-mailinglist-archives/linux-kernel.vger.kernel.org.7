Return-Path: <linux-kernel+bounces-731376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60509B05365
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56B63A747B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D830266B6C;
	Tue, 15 Jul 2025 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GO4rScha"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05ABEEA6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564996; cv=fail; b=ascvnCqC5HhvFAmzwySifsJcB6e4bW0VB10gUR3k/OHCq/URsB/HbLCWz6Cl0FPE6hfHuziMblS4HtvEDmyV2FVLKnCN/ONXyNZHl3++XSVPecFZfd7zAgxZfx4nW+VH5EYfYNz3F6SrcqW+7uF1QeZ7WTmela9ZoyfADwn9pUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564996; c=relaxed/simple;
	bh=TsallmiZKuvGg1GJlIR9An7Dh9SOYoBFnUG7PYWLpZQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=TnnC6v49GsqQwRKvLCvOGLi0AcWW5XGK3tpf63fVjm8Rc7kHdSXeVGMlYmOHUqG20yW4CCsn15BdghkeyaqXPVxIa+ItCIj9fF32QAbmeEgZG+GcnG42VLVVWGia5iuxqmFx8WlUa+xlSQP+fxvqESLvQJ/iWW6c7wiT5k/FvzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GO4rScha; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752564995; x=1784100995;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=TsallmiZKuvGg1GJlIR9An7Dh9SOYoBFnUG7PYWLpZQ=;
  b=GO4rSchacwtzg02Cg71OKN88D9lQjBWbY1bVCJ+KLGHzuKMDMuxPArdY
   XXGuhwPHT0K36Afj8unzFc2cVFk8voOEMNl2S73T6ZnNJIlaaXygpsOAp
   /WZJpA4v8I8786X+1n0guGGEKqagkwDqpfmzijzJAtakgp4OjQho3QAw3
   zL/6FtFYhANLx1murOZ4KoG2onRDRfc7UGqHuha0ojQUvQ80hiTKvTqKa
   CgsV5cCyD4u2fsHzOuuT9TEFyTdET1PqZ4wjnwUYHCxuDyAzXaOSkXWZY
   oI4ItYgGYzhxiSaiUHUKSzedCYmpQPVtPXIEn7kFT9VroLMWOfOn26MvL
   g==;
X-CSE-ConnectionGUID: osXqu1ebQQqgW6ELeWKwfQ==
X-CSE-MsgGUID: z85MOdH1TeGJemkJ8uPo0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54481157"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54481157"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:36:34 -0700
X-CSE-ConnectionGUID: rwFLeeJJRZuWIBVxmgHyaQ==
X-CSE-MsgGUID: HdEy8D97SIemkKPE9n0iuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="188158742"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:36:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 00:36:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 00:36:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.57)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 00:36:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC0+L3vMP8mGFZDXSUwq9MIiW5tKneVDeYUA6E2OSIafXVZt3ynrHcr6ySnX1XEGjypEfO7Kgw1rYvmR9akX2iTkijNk8Fhv5oREDj+HT6tidxrlBbZIbeyjutuUA3a+brGwXMmet6Y7zNGxAMk38CO4S4O1fqBilMesGI4iE0cruIKt9CZb+f/ymgoJ7EXBUu4LyimBUw+arx3h3x1HKrFNC1IUNwzvwCiHuNu0BM6nca9Pib6otmHwocHjcmkXOy1w0Xk7XoSulax5C9xnK4F5uCDRE0jBptCJ1F9SIPnOXaOGbmVJTwVTkk63tDhrm4dC9e3Woq1YUg1GHUtIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvkCTGixHB9ukYgiKRBEnDMgBl4rTEIqcP1HOB8EEDU=;
 b=V5CQZeugbgd1HxkJ4yP2jZ8x+pMAsZUN5WfEMNQHZGs6VDj331MiMcFiX89/i7Xq373bNimselDcSq0w+ZrD8KbeRbNmotmus7TAJziT7PitNB9NcAMNQaw1BMtbTpwAGDWot/9i5GjqxjJIOctj1EL2o298FCR0kGrMhm5xNE00aZeE/XY0jWGHPjEPUlZjNwDwYZHaGaPhzmHi/TLYK3OENOi3uJOY0iS/cAtsJc00eTSebOUGPHjczkTXQWGHR3zBTfkquXgvWITyC9Ro3F6ClMS92Yc+EYaNuSmMpZBBVuYraye8AGZXw8XkbZbuqP0/80dFafT5hJKp/VjM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6948.namprd11.prod.outlook.com (2603:10b6:806:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 15 Jul
 2025 07:36:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 07:36:22 +0000
Date: Tue, 15 Jul 2025 15:36:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
	<oliver.sang@intel.com>
Subject: [linus:master] [selftests/futex]  0ecb4232fc:
 kernel-selftests.futex/functional.make.fail
Message-ID: <202507150858.bedaf012-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: cb01d7e7-65e7-4bca-ff4e-08ddc3724b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nzh1Ylk1ZXA1YWxNeHFrSW5KK1NwZW9SUnR2NUpYaXZDak9YZDh6TUI5NXRz?=
 =?utf-8?B?N0E5cDdZNlBQcFJBZytCd2VycTNEZ3dITVROcnBORzBSb0pYVzZZVlVod2Vt?=
 =?utf-8?B?SWl3Tmd0SzI5c1UrMzIzRUx5Q01tSzFQZE1ER2dEb2YwdW45VmJmYnFuazNa?=
 =?utf-8?B?WlZQL1dtTkxkd2Z5S3VJZk5RVFRqSUpSdS84VkJpTFp0QXFiQlJhWFBwazR2?=
 =?utf-8?B?Zkx2elRrM3grSU9HY3NsdmlHSFQvU0hjV010YWVUV2Z4VGtTUVpEckFRbXVj?=
 =?utf-8?B?ODN0ODF6b1ZJeTFxa1BqRlRzSTRWWG9tRnoyR1VsMVFGQzVFSm1Td0xqQ1lP?=
 =?utf-8?B?Mnc3MDMxQXlPOVl4bk8xa3NNMDh2b29VdWQ3emhPVGRlOC9qMU5YaGRRTDhU?=
 =?utf-8?B?U0RJZWZLT2hBeHA0bWQxNkZtSkRZa1NlalR1ZisxajZ6WnVoQ0hEa3huZ2R5?=
 =?utf-8?B?TXNPdmtzdnJ6WWNsdWlpT0hVbDM5VEZoN3lVZ2FLKytKSDVNbzBIcER6ZnNR?=
 =?utf-8?B?QTIxNkJQU2dpd1hXUWF1RXc4ZG1QYkFTaHNJUTNQQ3BGYjBCOFRtMkwrazFy?=
 =?utf-8?B?WEowZWhEdE80NFcyaHhOeFBIR2pENWM2aHRPa2gyNndDbHZndXFQWlE4QkNt?=
 =?utf-8?B?aDFBNUp4MzZLbU9ubWhCdG9kYnFCMktVMVlhMGNMajRBdnlMcDkrdGswc0hH?=
 =?utf-8?B?ME1ab0VsQjB5T2Z1TEdweUJIekdrVmhyTGVFdlJCek12enh6NnJ5Sjl6cHIv?=
 =?utf-8?B?d2tPN3ZnWjI0eXFOSVpTZzI2RUVIcmE4dDZZd0lZcTVqVlgyOXFUS2lSaVJm?=
 =?utf-8?B?UUp4Y2RmOVlIM3RrOGY3a285V0hkZ3FPVXUvR3JiL0FmK1B2a0pTSkNEYnpw?=
 =?utf-8?B?WlpIalNGM3EzaTVNSkhqelo1TnByL0tYcUNaYUc3SkliRWVISWd3VkRqek1K?=
 =?utf-8?B?WjUrU3RFbnZ1UkVXQUwvNEhDSmpPUllDOGorNENySFV1djU0YmZWWkFuMXBt?=
 =?utf-8?B?TERMWjhadStidWFMa0FoeWl3cVhwZHZ1L3dYdlorcFVHa3NtU1Y2MVcwTVBR?=
 =?utf-8?B?ZFRVNVFFRXBSNWlqaEZJcU1Sd1praVdjK0R6eStKaEdsbmNIWVEvUHd0MUkz?=
 =?utf-8?B?TDVodjk3a0V6cmRYRTJCWGpzY3g2eDRNREJabWUxMnNqK1BzaWNwbWdIeUVx?=
 =?utf-8?B?UE8wZ1Y2NGczd0JNdFp0ckN3a1UvUnlZQ1AxbGRNZEd5aWlJV2laK0hKSUN4?=
 =?utf-8?B?bFFnSFgyL0FhaExSQlk2WXE4OFovK0I5QTJBL0Q0Q1FJTzRsejJERXVhSHhE?=
 =?utf-8?B?Z1NGREdGc3NiZCtZQ1U3clZSUUVONEhxbmJWTnRsU2wvd0NDdkVScmQzUTFP?=
 =?utf-8?B?aGFleGsvNHFCS0tEU1NFdVoxVGQ0bU1NVWdCWHZCbU5xUk5qV3RIZS9nOXQ1?=
 =?utf-8?B?MzQ3djdZUGtGdmhGcll3Nm1FOTN0L2w0dWpPajUwMVdvakEvV2VaaE90NjA3?=
 =?utf-8?B?N3BFWmhJRkRoOU5PZ0huKzJiN1JtczREQzU5emJTdFFENHhpTDdaNDc5UFlX?=
 =?utf-8?B?cWFmNm1CWjlGTTlSck9EQk5aTk85Ykp2bCtjNEJYYURpSDdScWtsU05rN2l1?=
 =?utf-8?B?QUZTNWFOeDZNV2hjZ2R5T0FwOWZQbGVnL0Q1TlpTSlUwbDZTVndkNWc3ZFVI?=
 =?utf-8?B?M05nay9ZS1Bya0VSbEpRSDFMM3p5c1dIeEVMRFpGOWZ1eGlhT25KQ1k1Vk1o?=
 =?utf-8?B?YzVUb3pwNzJBVHduSHB5VDdRRHJnUEphYk9JOGhtbVRNRDI0SkVVS1FCakow?=
 =?utf-8?B?RE02MW9tZnFJL2hkd3ZlS25KTzZmS08xSEU0Y2FPQjZKVU13QzYxNU1mSkxS?=
 =?utf-8?Q?MtqWVYhk0KYDY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJYQm0wVng4MzlVOUtxbnd5YzZMdXU4YjFaaHlJNGVGVUFtaDZOd1JITVhz?=
 =?utf-8?B?amJDd2FzUHhCWEFPcDVmMXorTWViTWIraTFMcVJsd1cremdETmZnQ0RzWHQy?=
 =?utf-8?B?RzhPR3JvU3poRkN3YmpwN1VKdnZHSXE0OEY3cDJuZEtOeDJuZ1pycWJpcFBQ?=
 =?utf-8?B?N2dkL1hoWFMrTGk0L1FxWjhPaUtHRS95bXlxUStzTElVRVo4c0tFTy83eWcz?=
 =?utf-8?B?ZFV2K1JKWFNRUi9rQ2hpMm9wMVltd085ODU3UXZudWJYcXdmMXpPUngvR3pV?=
 =?utf-8?B?b0cycGNuV3kvTlREWitQcTduaHZrTzBLWm1LWXZ5ZlFneEtORitwcE4zcTJa?=
 =?utf-8?B?ajV2cGowRjNrdUt2MDdoVkl5M0JIUFVjRmJwZVQwbmhvRXl0aWpOVkFxNG9K?=
 =?utf-8?B?YVNyaTBEMjc5d1RkVDF3anJZcTl2Q3o0dTRJVWZBODNIUVBpS0Fyc0YyRUlW?=
 =?utf-8?B?WTI0VzlnUzQzYW8rSk9hR2JhSC81cHhtOHloYkJINTVReUZsNzZPMG41Rk5Y?=
 =?utf-8?B?T1lBWGhUY0srOXJqYlZ5T0FJenpxVkw5YmVBcXRKT3JqOXJFOTQySXJ5dTRM?=
 =?utf-8?B?MnR2SlJHVFJaa0pUelUybFJNenRNQlNYT1BnV0hjWlNGV0xQcC9OQTF6TFNz?=
 =?utf-8?B?bHMwUU9uYUIrTWdQY045T2E5QVVhRkhmWVk0VmsxakNXa21Fem9HRFo0RGtX?=
 =?utf-8?B?dWJ5TDJ4aXN3L3dxNE82L0lKY1JZT0JYVzVOc3ZqTE9iMFNZMHd2eWxkSVBG?=
 =?utf-8?B?Q1dQSm1SbXhkbE1WVEJERWVVdTRqV3IyQW1QYVRDVGZ0ZzZQTnNrdE9TRjV5?=
 =?utf-8?B?OWh1c1N5Sk91ZXRjcjc1WnVDZWxaTHpMVGFVbmhLRlZrVkdCQzZoQjIxMVRH?=
 =?utf-8?B?L3FvM08rUk1ZL2pUamRoWEdhRXlqeFdqaWZvY2lmUXJIMlZ1Q0NySU5rTEhU?=
 =?utf-8?B?dGZKcDgyaStVaVZOYm9oZ3BGaVVpYktGUWIwb2UvNTMvSDBweW9ua0k3anQ4?=
 =?utf-8?B?bGJMdXhSWGN4dkpWLzdoWmhyOE02YmFrRjQ2Wko4aTlQbVdIQUF0UHRuVWRl?=
 =?utf-8?B?K0t2S1BQeVY1VUNoenhqMVkyNXFDN0VTOXl1bktmNFk2aTV5SExTeDdjVmc1?=
 =?utf-8?B?RWdBT2UzWlhmRmR6NnNDRit4U0ZnK3g3Tk90ZFY5bU9DaEg0QnFhMW5xdk43?=
 =?utf-8?B?bWpyTWVRRnhUbUk4RmJHc0FFay9aRG5ZTTB6R2YzakJVYkZ4Ti9NRGo3TXpT?=
 =?utf-8?B?K084R1BIU0VWN1lISVpiRHRCU012UTAyem9lUy9XekdobTdCYnY0MmE0ZXV5?=
 =?utf-8?B?NDMxTm53Q1ZGVlNWa2pxSzVUYWxtY2lTbVlXcE90ZWltN1lzRVRHaWg1R0RF?=
 =?utf-8?B?aW84cmpZWU9uQUtxVThlUXlHSkJyMThMK0huR1NwTE5QTW1SZHRJWUd3QWpn?=
 =?utf-8?B?S21JQ2QySEM3R2tuZlNrem9nTjRHZWk2SnkrL0MzMUxrNUtOTHJBZFVWR2cx?=
 =?utf-8?B?MlhlakRmMGpucWFDbmQ5WnhsRndpTnhPOUR6dG1heWM2eng0YXloZ3BxS3dh?=
 =?utf-8?B?M3R6UFFIZnNZM0Q2UU9ZZTdOMFVpcTRXTzJweFAyZE9JcHpVbkdnaU81eFM4?=
 =?utf-8?B?NXJqcDUreUZvZVdBUitPWEc5TE5rZzVBeHc2aGcxSndvN0VzbnZWdnVQaTJt?=
 =?utf-8?B?d0RmSW9MK3VWc0lVeDR3VTh6NWJMTUFtcGt3NkZwRjZtcmlSdFhXRHB0Vm1n?=
 =?utf-8?B?R3ZXcERSeHZZWmYrSHpVQ1psdXIyT082Y3F4TWRYbXNyMk1CRlB0NFlsaENH?=
 =?utf-8?B?ZW9sSndSNlhSVU56TEtGZWEzK29iMjNzZTJNUElJZkVxU0JsNFpZZDBMOHg4?=
 =?utf-8?B?Rmc5cm9sakt3cTVTQWxXN1lPUEZybmVFVTd0QTdzV203QXJiV1ROZjRpaVNy?=
 =?utf-8?B?blNtdkNNT0xjTVpqN0NoVDEzb3BXVDBmdHpPTUVIb1AwcU9sRUdRL0dmQ2Ry?=
 =?utf-8?B?U1F4YmpEbUZoYmZZVi9MSlpvS3gyWTZHU1BTZ0JHQ2xiWDlmN1pqbzdhYUJo?=
 =?utf-8?B?N0xXSGhrMGJuRG5EM1plTkJDNEV3VDNvSHJLTlY2enZ1dEtuTFdqcnhZY2hu?=
 =?utf-8?B?c1djNGIzSkNqZTV3cnp0WUxMTjE5Qmx6NnFWbVhpRVZzTmUrSkJNK3dGalhx?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb01d7e7-65e7-4bca-ff4e-08ddc3724b70
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 07:36:22.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LK7EeUQu3NXc4FI+IjwP4z64fq0xx6y5iKaRH1ADhvEfqTZ+ATbVgCsYYPVFLR+/Lv74cn58nyQqNmnDjLeog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6948
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.futex/functional.make.fail" on:

commit: 0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d ("selftests/futex: Set the home_node in futex_numa_mpol")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      bc9ff192a6c940d9a26e21a0a82f2667067aaf5f]
[test failed on linux-next/master b551c4e2a98a177a06148cf16505643cd2108386]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
with following parameters:

	group: futex



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507150858.bedaf012-lkp@intel.com

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d
2025-07-10 23:09:01 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2025-07-10 23:09:01 make -j36 TARGETS=futex/functional
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional'
  CC       futex_wait_timeout
  CC       futex_wait_wouldblock
  CC       futex_requeue_pi
  CC       futex_requeue_pi_mismatched_ops
  CC       futex_wait_uninitialized_heap
  CC       futex_requeue_pi_signal_restart
  CC       futex_wait_private_mapped_file
  CC       futex_wait
  CC       futex_requeue
  CC       futex_priv_hash
  CC       futex_numa_mpol
  CC       futex_waitv
  CC       futex_numa
futex_numa_mpol.c: In function ‘main’:
futex_numa_mpol.c:213:31: warning: implicit declaration of function ‘numa_set_mempolicy_home_node’; did you mean ‘SYS_set_mempolicy_home_node’? [-Wimplicit-function-declaration]
  213 |                         ret = numa_set_mempolicy_home_node(futex_ptr, mem_size, i, 0);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                               SYS_set_mempolicy_home_node
/usr/bin/ld: /tmp/ccifp3lK.o: in function `main':
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional/futex_numa_mpol.c:213: undefined reference to `numa_set_mempolicy_home_node'
collect2: error: ld returned 1 exit status
make[1]: *** [../../lib.mk:221: /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional/futex_numa_mpol] Error 1
make[1]: *** Waiting for unfinished jobs....
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional'
make: *** [Makefile:207: all] Error 2
2025-07-10 23:09:02 make -j36 TARGETS=futex
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex'
  CC       futex_numa_mpol
futex_numa_mpol.c: In function ‘main’:
futex_numa_mpol.c:213:31: warning: implicit declaration of function ‘numa_set_mempolicy_home_node’; did you mean ‘SYS_set_mempolicy_home_node’? [-Wimplicit-function-declaration]
  213 |                         ret = numa_set_mempolicy_home_node(futex_ptr, mem_size, i, 0);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                               SYS_set_mempolicy_home_node
/usr/bin/ld: /tmp/ccT08B2V.o: in function `main':
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional/futex_numa_mpol.c:213: undefined reference to `numa_set_mempolicy_home_node'
collect2: error: ld returned 1 exit status
make[2]: *** [../../lib.mk:222: /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional/futex_numa_mpol] Error 1
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex'
2025-07-10 23:09:02 make -j36 TARGETS=futex install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex'
  CC       futex_numa_mpol
futex_numa_mpol.c: In function ‘main’:
futex_numa_mpol.c:213:31: warning: implicit declaration of function ‘numa_set_mempolicy_home_node’; did you mean ‘SYS_set_mempolicy_home_node’? [-Wimplicit-function-declaration]
  213 |                         ret = numa_set_mempolicy_home_node(futex_ptr, mem_size, i, 0);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                               SYS_set_mempolicy_home_node
/usr/bin/ld: /tmp/ccpPRT4b.o: in function `main':
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional/futex_numa_mpol.c:213: undefined reference to `numa_set_mempolicy_home_node'
collect2: error: ld returned 1 exit status
make[2]: *** [../../lib.mk:222: /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional/futex_numa_mpol] Error 1
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex'
mkdir -p /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/kselftest_install/kselftest
install -m 744 kselftest/module.sh /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/kselftest_install/kselftest/
install -m 744 kselftest/runner.sh /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/kselftest_install/kselftest/
install -m 744 kselftest/prefix.pl /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/kselftest_install/kselftest/
install -m 744 kselftest/ktap_helpers.sh /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/kselftest_install/kselftest/
install -m 744 kselftest/ksft.py /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/kselftest_install/kselftest/
install -m 744 run_kselftest.sh /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/kselftest_install/
rm -f /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/kselftest_install/kselftest-list.txt
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex'
  CC       futex_numa_mpol
futex_numa_mpol.c: In function ‘main’:
futex_numa_mpol.c:213:31: warning: implicit declaration of function ‘numa_set_mempolicy_home_node’; did you mean ‘SYS_set_mempolicy_home_node’? [-Wimplicit-function-declaration]
  213 |                         ret = numa_set_mempolicy_home_node(futex_ptr, mem_size, i, 0);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                               SYS_set_mempolicy_home_node
/usr/bin/ld: /tmp/ccLRFTsP.o: in function `main':
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional/futex_numa_mpol.c:213: undefined reference to `numa_set_mempolicy_home_node'
collect2: error: ld returned 1 exit status
make[2]: *** [../../lib.mk:222: /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional/futex_numa_mpol] Error 1
mkdir -p /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/kselftest_install/futex
install -t /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/kselftest_install/futex run.sh  
make[2]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex'
make[2]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.
  CC       futex_numa_mpol
futex_numa_mpol.c: In function ‘main’:
futex_numa_mpol.c:213:31: warning: implicit declaration of function ‘numa_set_mempolicy_home_node’; did you mean ‘SYS_set_mempolicy_home_node’? [-Wimplicit-function-declaration]
  213 |                         ret = numa_set_mempolicy_home_node(futex_ptr, mem_size, i, 0);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                               SYS_set_mempolicy_home_node
/usr/bin/ld: /tmp/cco6y6tU.o: in function `main':
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional/futex_numa_mpol.c:213: undefined reference to `numa_set_mempolicy_home_node'
collect2: error: ld returned 1 exit status
make[2]: *** [../../lib.mk:222: /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional/futex_numa_mpol] Error 1
make[2]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex/functional'
make[1]: *** [../lib.mk:175: install] Error 2
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-0ecb4232fc65e659ca7020f8bb2e0fc347acfb7d/tools/testing/selftests/futex'
make: *** [Makefile:272: install] Error 2



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250715/202507150858.bedaf012-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


