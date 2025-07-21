Return-Path: <linux-kernel+bounces-739976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25E6B0CE21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0363D6C5872
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142E24676C;
	Mon, 21 Jul 2025 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRJ2DxOm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B01B87F2;
	Mon, 21 Jul 2025 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140511; cv=fail; b=nFmOTCtrzlkbsBYL9wFhqUqka3kBOWDOE0g8I1rPmQ618LdfxxT70XRnHUEnLOLmy03rKgff6EcTF96fYlT6z9XzfdyoTzlpaJ5oYPsm7dFn00YNXc6MSzyUlj3J0JsphwEkFQWGCDMpP3E9uTwFGDVB2zSX9zCYtRWcPuDssB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140511; c=relaxed/simple;
	bh=mOqKXbqS1UHmGMKN3oNy3FsU/hJtB87RxezJIgAvxnM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sK5wb0yrx68lpk7uGWoqaCTUQtU4YRB51D6lZwbCZ0h0cRf6sjSRMWFRf0USwXH8e2xIDxDAMn3Vuu5PhEJv6hE1tEHjc0yDbX5Xz4IgPDlWJftd0tU99mW3t9llATijcox6VZ3L9uuxUWHrDkAA7I360VGKWy7WUbG2v5McIeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRJ2DxOm; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753140510; x=1784676510;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mOqKXbqS1UHmGMKN3oNy3FsU/hJtB87RxezJIgAvxnM=;
  b=QRJ2DxOm4dHoEdh6VEcBtZoKqp6sC9XpIH/kfdBQl2zGLhjWEFoOFqwS
   AasScRKvjmKV2qpF0e8IGFw4zOFLT5Vm00f+QfjeZkzmFwVb6/GPGHKYV
   CrIRtMUM7hT8fOps/pchceb+FS7famSPEqR9lw8focrLzb+Jt6W1YDpVJ
   lnyUxtb68yaLwT6KllUXiTqFln5KFKLoYX8wGMrxOrwWdqWLuvBhy5Twe
   yXWTLscXV07dNAJZlO+yrGupuYZVJHwEe+Etk/m3Pq2e91jA0kTHp4Oi6
   2xK3ot5zmpKvzPSlQeMvzoJCpClFpven3N0/92IAxWyzZcGY0jdRC+30A
   w==;
X-CSE-ConnectionGUID: drwrBjl1RESnIEzM0042Vg==
X-CSE-MsgGUID: adba6SVrTqWxcpT3Xwq9Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72827789"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="72827789"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:28:29 -0700
X-CSE-ConnectionGUID: pyxKDaznQuO7OCWXlPrGzA==
X-CSE-MsgGUID: T/JurBewRxukG9dyt8DUWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="189961558"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:28:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:28:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:28:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:28:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gaog/17FqmqsDGOYUb2ROrwfgwxiZQ8vzNHh12WbTqotMwkW8L1SjKrA/9MtJJD/tRzm1cbuM69+V9yrqXgWO3WQ0gFBvTKQ3+selw6IcrObyJf3PPR8qmnzGOMmEw59kmtNiee3620zNxbEf4pHvVvMtla201DJYHHcDuEGPINLD3jfp4swdd3stwEglKj8wzemd5is36NrGAWRDoujWvIVwtjC9f4ecq2yLJezzQx78qo50P76mvIGk3dNnkVs/xjATh88NqjdiH0FdTq3DW4yX9dvwfbslhyo2GoFWTm8+uhYt7MeKz7sClBXqiZYagarx7buLPl8gsbm4dl8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usRfn7wohiaZ8J0GeT5QE4+W6cQ6yUxvO0w0nbtqe9g=;
 b=cVDKgyyZ+8AM9A3LosXOzEC177Eee0X60zCGyouT+d2ZhpM+fg7ppnkbCfjFZMNOdbual9YeeAWgOcY9sZC9vaVtkdCyClFuqXm1MWVNLx3QQ1xFkV1Q+PTCt075ZfESgqGjTxOaFIs0Q/Yy+TwF+BFEib8d+74lS8uXc/3wdE94DI7d17KlNcASPkTxjOdT0wtciHN94RKdOxfmWiKJ1Vs0qfL8ByGQg+lQsJ3O8UyWO+vtLSUCeRcYQ3w/NYQvUkJ+rquwWVL89qVNM7y4tMGECYfWZEMeYL9oKY26iEKtlaHdIiunVj5nkdHUHKsocPB+Gf29/hZcP8VfiNwYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6414.namprd11.prod.outlook.com (2603:10b6:930:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:28:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:28:25 +0000
Message-ID: <e6866fad-1d8f-4fca-baf7-6685e57370b0@intel.com>
Date: Mon, 21 Jul 2025 16:28:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/10] x86,fs/resctrl: Support L3 Smart Data Cache
 Injection Allocation Enforcement (SDCIAE)
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
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1752167718.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0353.namprd04.prod.outlook.com
 (2603:10b6:303:8a::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 1068994a-b1ba-4bd2-21ee-08ddc8ae4a27
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmVORjYwNHJ4S1VMbnhCcmxCb2RjK1BpTlhjbEp2bUNMOEZxMEhmdjBucjhu?=
 =?utf-8?B?anVoTWdld1VzZ3pPdWZMYUhPakdpcDNZNVY0cm9PTEFWdlVjUmsvSE9mMFdw?=
 =?utf-8?B?NGRBSHp3V0hnKzJJVWlJWTJ0eHc2cFRtcHNEQlc0TTN0bXpkQWJISTIza1VX?=
 =?utf-8?B?ek5BcXJ0enVIMmVCcVRZWUNWVjJ2RGF6ZmhNN042bi95WVZDNmRGaFJBZUZk?=
 =?utf-8?B?OUZUWVlEVXZPeld0OGFSc2Fhdlh2MjFQY3l4Z2NTRnBKWFRuYmNzQUtteXho?=
 =?utf-8?B?Ly95eXlpZmEzVHR1Yjg0VnV1L09FajdQUUlGL3k4c1gzcWl5czBJdlR0RTFF?=
 =?utf-8?B?dHc3UWEvWXpJSTJLVXVlN1RRZ2FYNkx5TkdFRmRrZXlYUUljWE9LbklwUXpr?=
 =?utf-8?B?M3hzSzcyMVAvNDNUU24wOEZvOEtVbTkzN1g5dDlMdE9Sa1R1SXQreXdsWG1B?=
 =?utf-8?B?YmFYcGxnV1FRSTF2TndLQTZEdnd4WDhJcVBJbG1Da0NPWW9sK2YzL3dLMThk?=
 =?utf-8?B?NndGRk9FR2NjMDNwZnNjZ0FKTk1SRnhuSnNlNUMrTHloUHE3b04wYkcwZE1T?=
 =?utf-8?B?QjlkRU0zZ0h1MXlCUDFFNWZ2cEJsTjFaTmpaWlU2Yy83RmlaeDZHUG1ESVRV?=
 =?utf-8?B?eVhucEo2eW9neVh0ZmdVZ3F0VUxSSjBSdHFTdndhajE1cU9zWlI3RUN0Yzhj?=
 =?utf-8?B?N2dva2o0b2lYWWpmdVdLSWhqSWQ2VndjUitrRXgxWi9OTzlYSDlta3Fra0xQ?=
 =?utf-8?B?aDRqcWg4bTI0TGRIdnY2citrNGdkeDhPSHNHK09qdzRUOTNab0c4ckt4Y0hh?=
 =?utf-8?B?TmJKY3RVVW4yRUx2SGR0NW91RDUvUDdqanFDYlJxSnV5UlB0RkI4T3ZkZ3Vh?=
 =?utf-8?B?WU9oMmh6RkVLUHpsOG5wS3dBOG5zUkdkdkZqU0t0d2xRSVZ0Wi9BaHRSLzRm?=
 =?utf-8?B?dHplUlVwSUJyWDVlQmd3Z2p6MFIrc0pDR0FUMktMeVdTV0xWMkNIeVdlS01E?=
 =?utf-8?B?cnpHRElZY1NWSGdGMkVuc1l6VDQ3bXQ4bzN6TitGUlFRdUdDOW5TcnpCUk1H?=
 =?utf-8?B?YWRKSmFPdXplZndCYWVUU0lwRzVCR3p5Q0V4THBFU1c4eXF6b1gxYk5MYWhu?=
 =?utf-8?B?VGlQUG8vU0owSjF2dE9MOVo1a3BTUU05OEZ1bjg5OEdzWjZUS2ZzOGNzbk16?=
 =?utf-8?B?MnYwTmRHRW5yTFNvdEM3Q0VjekdDd1lDdUUrdVo4dGJzcE5EaHE4UUJHRDB5?=
 =?utf-8?B?N244T2p6RndqdmxrYmI2bytsODJNOG0zcTBEK1hERU4xNDZoMVNFZll1QzMr?=
 =?utf-8?B?ejVPbndJSENXdG12Rk9NOUV1RFZWRjRsZXd6Qy9yTjJ4Q0tJQnFJYWZNTjRk?=
 =?utf-8?B?eVNLaWtwdE1DS0FMSDIvb3Nrenk2V1RBRVhEQnhLSUxtbjloOXYxNXliVHNC?=
 =?utf-8?B?M0w0OUFYK1ExZXNJUEVGSGFPWnpMZDZYSUV6UXVmTjF6ZlROUjNFbzRFNXZB?=
 =?utf-8?B?U3FEMXUycEg3ZW9NWFB3WEJYclBVbHkrZkRreWVHSHZQTEd2cklINGtuWG5L?=
 =?utf-8?B?Rzk3WFFRUU03U040bGlLYnVYb3hsTkwyc3FjZ1lBUnZTSzhGZS9Ua2RXTUQx?=
 =?utf-8?B?RnFwemNBOFVJZ3h4N1BCb0dnTEJkWUFSNVI1R1M0d0ljazFBODlJZUpEZjcv?=
 =?utf-8?B?RjNMUnhVUTJKeEZNb2hiaVF6NDljNVJHY05LUFczRlR2TWlkMjlna2dzOVRx?=
 =?utf-8?B?a1U4cHZRY3RaNEVqNjB1Tm9vUVZoUlJINjh4SFQwR3JBUnhOTHk1Sm43ZmdC?=
 =?utf-8?B?bGtjQWFMbkRmVlkvLzNteXlhUUNIM1RrRWRlQUdpM0JxVTN4bHNYSXhiZnZx?=
 =?utf-8?B?SlN2MTBJem1lZGNtUXhuVzBURmVlUTM2Ymx2aHRIMk1iNHBPejBVK2tIRjFH?=
 =?utf-8?Q?j7bmTYSf6bw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBjTzQ1Q052UEswNGduNXVXSkN4QnkzOUdVTW1UNzNsWnJ3WWcxRVZNRnRv?=
 =?utf-8?B?OG9DYVJ2eDlDVGVTbVNJa0ZpbG00WE1tNXpwbHlCcE9zTm1kaEVxemxON2h1?=
 =?utf-8?B?WDVEQXNVMmJwQlRIQjdmQ2J3bGNzSEprdmFNT2lkdFVqOXE3QUI5ZWpURVB3?=
 =?utf-8?B?SEpJT1Uva3FROXFOcTd1TzhNbkJVSU5vWC9uTmpYN2tTL2hnZWdCTHM3Q2RE?=
 =?utf-8?B?OXRmR3dJektoRjZ6L2RRc2V3MUhKYVh4N0NUWWpwK05TVWJaU3FLT3FKT1pG?=
 =?utf-8?B?d2htenpvR3dDU1N0N3VlYUFkQ3lsRG9HRGZlQ3I4bVQzdDN6d1MzMWlXYmY5?=
 =?utf-8?B?SHdrRnMxWjFoR0RqVkxtbUtVc2hra1A4bm5DUllnaFpuZnFBWGlacUc2eFlO?=
 =?utf-8?B?NG9kVFQ0c2pxalFIREo4Q1J3bnhPb2RQMk1hVW9rTm5vNWJRZG5Yak14Nm5D?=
 =?utf-8?B?VGQrZmdSSEh6K1dPTkJubVA5QkZsaElrbjlPNVhWcitDdy9Fc1B4cDd0ejFL?=
 =?utf-8?B?L1NnelJzYXp4RWk3ZkNJR0FIZXhYb2xQamV4SldOWmE3UFE0YWhUQ1BHK2gr?=
 =?utf-8?B?WUlacjZ5WlQrazFldFdVSUJrdW9nazEvaDROcHUzN2lGOVZHZHNTN2tmNzJT?=
 =?utf-8?B?ZXNxK3VxQm9wSkRXSlk5U3hpWjlmUGM2R2RGVXpFZ2M4d0Vmb0JaR1dteHdy?=
 =?utf-8?B?QlZMbVZrSTNDWmttMnhhOTY5RGVXRVRQdkgrUFFXWllvS2NCZzJIRE9lQnZU?=
 =?utf-8?B?ci9Ca3BoRE1JVjM2dTBnWVJ0NEJIbmVPZ2Y0djdYZHNzUWpGMU5Sd1M2T2pK?=
 =?utf-8?B?RUVlQTM2U0ZtNnJZcVVjQUFvcStRQk12M3ZaeGErL3FaS1ppU1B1aEJ0NWVs?=
 =?utf-8?B?enhndk5KLzZYdXVyM1J6ekU0OFdJdXVoUXVpa3N5VldTa1ZRQloybGRLbzBo?=
 =?utf-8?B?YzlVUTQ2eFp3NVB1bjNMeit2OEluSUZTMHlRQ0IwVGNVUFl5TGdRempZMEFJ?=
 =?utf-8?B?V2xCZWJ4RGtrenZZSU10WmFOOTNtMWZQYWExWHU0cmIvWnNCbDdCeXdlblFX?=
 =?utf-8?B?RGYzYi9KTWlEZExWTFYwUEYzd09IcTAzS0pXeUdxOFBtMEdNTXlHNlpKbXJF?=
 =?utf-8?B?S1MzRW5YTHZJODhJNGg3UGVxTCtQbzlSTHNHR2ROajJGSzg2cysyOXMxS1hE?=
 =?utf-8?B?cUJSR2o4RnNXaGF4RXNSYUFIalhhOWxXcGd6UVE4dFN0N0pkcUcwRGY3M04z?=
 =?utf-8?B?ZEw2dHNzQjNOUDdhZjhSUlVTZkE2K3hWYjJkeENxWFFCS3pFUzA3eWVtQzRK?=
 =?utf-8?B?bC9OTHNNNkpFb1E2ZTh3M2dqemdEZ3NXV1NyWjExcE1QMUd1V095RTAyaUJI?=
 =?utf-8?B?dUVQM2JWcE92YnkwdHBrQkxNTmpCSDVCNGlZQS9LdkFZOGRqSktZQ2lvTFpY?=
 =?utf-8?B?U1JYQXZXeWl5N0VnQzd1Z0g3MDJHRlJTbzJ2OFhxSUJVd2hBSkFsNGEzTlVi?=
 =?utf-8?B?bWlnRnZ3b0F6aXZvQUlUQ3VDTUJDZmRCSmNQVkJSeHY3SE1HRkNPMnRHK3Qv?=
 =?utf-8?B?dlJwa09LU01DVS9xMDc0NUtCV2Voblg5eERscDBVOXNvNGxQeVJ1OHYwVU4v?=
 =?utf-8?B?MGV5K3NnKzBpZWNleEZ3Slo5TnJtakhGSHk1My84RXR2ZjZJOUp2Y1VwaDhk?=
 =?utf-8?B?T2U2N2UwMjZrQlRYSS90MkdiYUlwWk9YczhWYTFVaW9pYlZIdExzZDFsOGxE?=
 =?utf-8?B?ZGFualZBRFFUeEVnZkh6ZFlLeXVCdzdpZDkxWW55d2M0UlRsVHpyVjU5UTAw?=
 =?utf-8?B?Nnl3UUV4bDI2SzhDbnJldlhPMTZJOVU2NGQ3Q0wyWWJ2eEMxcHlFRnF4K3Fh?=
 =?utf-8?B?TThBR3UrOVp5NTd3cHFOWWMxa1ZzS2pEOWZIT0FmNzE3eEp4QnhpTmhkVnZF?=
 =?utf-8?B?cDZLMDZNb0Y3QWxPZEpuYlBFRHVYWHQva09rTGgxbW9Ic2k0T2x4anRyZWtQ?=
 =?utf-8?B?dEJEVGU1MExKTUVRRmdUbzdCdnJEYVpKTW00R0NhWklLTk0xcUttbjQzVDlE?=
 =?utf-8?B?WGlyNzBDODZ0MG1CTHduL29JcVRaampGbjU3VVBvTTVHS2Fya29nemQ5SVFy?=
 =?utf-8?B?N3E3MXp2V3h5bVkwa0VHTThlYmFEcVFkaVNpSWF2dkRiQ0NxZDdBaWljV3BE?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1068994a-b1ba-4bd2-21ee-08ddc8ae4a27
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:28:25.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pkb38pptdkTjmBJa74jzp66qGjl1WWFLdBzG7011evw4OfBA2GaTJBVJFqmgOl1Am19b9oo/TCyignQmSnrtrIhwHUZ84awIFIeQKxHYqe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6414
X-OriginatorOrg: intel.com

Hi Babu,

On 7/10/25 10:16 AM, Babu Moger wrote:
> 
> This series adds the support for L3 Smart Data Cache Injection Allocation
> Enforcement (SDCIAE) to resctrl infrastructure. It is referred to as
> "io_alloc" in resctrl subsystem.
> 
> Upcoming AMD hardware implements Smart Data Cache Injection (SDCI).
> Smart Data Cache Injection (SDCI) is a mechanism that enables direct
> insertion of data from I/O devices into the L3 cache. By directly caching
> data from I/O devices rather than first storing the I/O data in DRAM, SDCI
> reduces demands on DRAM bandwidth and reduces latency to the processor
> consuming the I/O data.
> 
> The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software
> to control the portion of the L3 cache used for SDCI devices.
> 
> When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
> partitions identified by the highest-supported L3_MASK_n register, where n
> is the maximum supported CLOSID.

Even though this CLOSID use is unique to AMD this implementation makes it part
of resctrl fs's support of io_alloc. It is confusing to have architectural
specific features be handled by resctrl fs so I think it will be useful to
add a snippet here to help folks trying to decipher this work. Consider
for example a snippet like:

  Since CLOSIDs are managed by resctrl fs it is least invasive to make
  the "io_alloc is supported by maximum supported CLOSID" part of the
  initial resctrl fs support for io_alloc. Take care not to expose this
  use of CLOSID for io_alloc to user space so that this is not required from
  other architectures that may support io_alloc differently in the future.

> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE)
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> The feature requires linux support of TPH (TLP Processing Hints).
> The support is available in linux kernel after the commit
> 48d0fd2b903e3 ("PCI/TPH: Add TPH documentation")
> 
> The patches are based on top of commit (6.16.0-rc5)
> commit b4ec95e3bc3f ("Merge x86/microcode into tip/master")
> 
> # Linux Implementation
> 
> Feature adds following interface files when the resctrl "io_alloc" feature
> is supported on the resource:
> 
> /sys/fs/resctrl/info/L3/io_alloc: Report the feature status. Enable/disable the
> 				  feature by writing to the interface.
> 
> /sys/fs/resctrl/info/L3/io_alloc_cbm:  List the Capacity Bit Masks (CBMs) available
> 				       for I/O devices when io_alloc feature is enabled.
> 				       Configure the CBM by writing to the interface.
> 
> When CDP is enabled, these files will be created both in L3CODE and L3DATA.

"will be" -> "are"

> 
> # Examples:
> 
> a. Check if io_alloc feature is available
> 	# mount -t resctrl resctrl /sys/fs/resctrl/
> 
> 	# cat /sys/fs/resctrl/info/L3/io_alloc
> 	disabled
> 
> b. Enable the io_alloc feature. 
> 
> 	# echo 1 > /sys/fs/resctrl/info/L3/io_alloc 
> 	# cat /sys/fs/resctrl/info/L3/io_alloc
> 	enabled
> 
> c. Check the CBM values for the io_alloc feature.
> 
> 	# cat /sys/fs/resctrl/info/L3/io_alloc_cbm 
> 	0=ffff;1=ffff
> 
> d. Change the CBM value for the domain 1:

"for the domain 1" -> "of domain 1"?

(nit: inconsistent use of "." vs. ":" in items)

> 	# echo 1=FF > /sys/fs/resctrl/info/L3/io_alloc_cbm
> 
> 	# cat /sys/fs/resctrl/info/L3/io_alloc_cbm 
> 	0=ffff;1=00ff
> 
> d. Disable io_alloc feature and exit.
> 
> 	# echo 0 > /sys/fs/resctrl/info/L3/io_alloc 
> 	# cat /sys/fs/resctrl/info/L3/io_alloc
> 	disabled
> 
> 	# umount /sys/fs/resctrl/
> 
> ---

Reinette


