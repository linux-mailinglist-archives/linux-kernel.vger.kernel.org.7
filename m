Return-Path: <linux-kernel+bounces-782454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7503AB32090
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2168B1D24C56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A583043DC;
	Fri, 22 Aug 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqDmB8XK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79131F463C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880371; cv=fail; b=sOGlv20YMDMzvkJDJfF2e4XrFA+8ymcwN3dBEzsHo+rg9qSlPoKYpCoGCI6Z4basCw8k190qWGMMm2/WzgkFjaRydb8McQM/5eU9IXyDB6imGW6O+6Yar/KzUiAdxknlTLJAiSikng6rmrOqFbsVFTWybMNDh8aLBd9hnS4jgVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880371; c=relaxed/simple;
	bh=PvNB//KivFIv70H2LCCXYiuctmc1NIRh2KnqHd4EEbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h81ObGmgp0I/9faibP5aPIyNpXqMiioURHdQNb/cVQhRMwsngvG6ABiXBiEEk6utADpHezPH3i36DYGPxJNQ3SFzBSfD+bl9/JYdm7OdsPsYbOQV9Iw9rYerz7gGRqor5kSJb1VxldX+8XDL3lItfvBfVgIm/CpzRsZdaErosnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqDmB8XK; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755880370; x=1787416370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PvNB//KivFIv70H2LCCXYiuctmc1NIRh2KnqHd4EEbM=;
  b=QqDmB8XKP0PTMetU5Nta8BL4JRs3H/14/VfI63KPD6PGXx84vIe0c+pn
   oW49q/wBDDLOoap7g6Tk7IKPrlqa1JxaMwylvaYyVH5tfXCjNSy3gbXLp
   C9ak1Rh4IPuo1znk2NFVILVXPkh02OWgbCimoq1QWbPokFevoRJxMdd8z
   j35KW25WtNVbsi+c3aEL83XVoRmO5Mgg5TDCk46xKBQ7lyrzwwN9ttxtF
   gakfE/+Y7rN0lhNHmN/EncGyuUthNslvtxFPCLAuA0bD5poXz6IfXj3bT
   ceSCi3RU7pTCBgiLkk0KSqxROpTEZ7K4T4GzmGxli6V6vy3ZxiLEUp8tI
   g==;
X-CSE-ConnectionGUID: o6yn0WvFQ+G63Gg/wDMHkw==
X-CSE-MsgGUID: copZAaC/Qaif9SUft8tKaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57210075"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="57210075"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 09:32:49 -0700
X-CSE-ConnectionGUID: PYB118exRtu2edqKr8k5CA==
X-CSE-MsgGUID: V8keqEr5SKm/qogIbxt8tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168255352"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 09:32:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 09:32:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 09:32:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 09:32:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B16rldZBaCZN3OSdcd98PALLjhShrsa1NvuXCWajHPV8zCuyovTO7rYuk4+UVWAlxbyVmXJ2hohA74Bgbk/hZQlSsRuDrgCddjp976bPEbx177GlqvzOAgchC79UCAZrC7O6grIM97ns6gWXAZnm+RBgygwj4sEwu25RnOQwpXCQADvbVGCB6vAWKFNbvEzMdy/FtHrZ/XXrSXF3xc1Uwawn3eupkukGZssueTjPSLKLrqzOe1fPbXraB5id5+WdPLkylVNw01krQSxFpR3QmEGuy+M1SBUnZZFV2ofBRbHWiQBHjo9Ky+p+8ZmUBpIw/MYR0I0E+cLTH7YCbdu/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvNB//KivFIv70H2LCCXYiuctmc1NIRh2KnqHd4EEbM=;
 b=l2KUS3qJEpEhbAcOQMDHb+X2VHRp/JqCttq+Jdna0H1HPA4pVLWMbzbnD0idPnrTFvvMCY2IMeara+DeX30U0/b1vX89YZPi7Iz6vNO1liX3/GgcuYdhNDk5PtUEMyVhB0L5hPb94xZMji98O+YK5dCmAkzlcNbHV2dn0jPL1wcCm4XXjmVQBixfVWFfIHr+vZzjuuSCW0ThYSUdLFzmlLHBXMZ7MsRg+TxZMePU4VohSBouTcZbSFGbVCzXbUv/2D6FnTI7sysHiJcZmIEZVGuL+dC8kne0boqcN1rqQBaSU0i5im824wIgxLwdgPchV07drxN/ORwWByecuQHWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB8151.namprd11.prod.outlook.com (2603:10b6:208:44d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 16:32:46 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 16:32:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "debug@rivosinc.com" <debug@rivosinc.com>, "mingo@kernel.org"
	<mingo@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de"
	<bp@alien8.de>, "Mehta, Sohil" <sohil.mehta@intel.com>, "oleg@redhat.com"
	<oleg@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 0/5] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER)
 in .regset_get() paths
Thread-Topic: [PATCH v2 0/5] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER)
 in .regset_get() paths
Thread-Index: AQHcE3q31HuRziJTPEK2T8WL/8xAvrRu3dGA
Date: Fri, 22 Aug 2025 16:32:46 +0000
Message-ID: <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
References: <20250822153603.GA27103@redhat.com>
In-Reply-To: <20250822153603.GA27103@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB8151:EE_
x-ms-office365-filtering-correlation-id: 78710690-e78c-42fd-bc77-08dde19986a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?M0x5SDlJd0lMUjUwdVhhVDJtRTE0YzU2L1JxbTAvc214TzZWZUFHczB4KzNE?=
 =?utf-8?B?Q2ZkNXZBYXE0NUcyK01WVHM4ZURtbm1lcHQvWkFkN3c5TzlpYWIwUVlCblBT?=
 =?utf-8?B?YU5qVk8yVk41OHl0RE12YWJvbWpVUGxUWU5kREZhSHpIYis3YjJicTZaWjJW?=
 =?utf-8?B?RVo4Q0E5REN1NFlEMldYRjVRZW5wTGp2WlpYc1l5cFZ2RlU3cENtYWh4ek5S?=
 =?utf-8?B?UUF4bnEvbzVvMkJZcE5rbjcvNi8rVmtNNXhSYUlSUzFucTBsTytDK09QeU1O?=
 =?utf-8?B?L1Q5WDd6YUUxMExWU3Q4dGhOYmtlWkNXYXRTSEFtaUZBMW9UYWhQc3RLazBG?=
 =?utf-8?B?TmRsNHZ6NVZnWkpTZEs3c2FDUWRvSUxBdWJZQm1RZEhrTHZseENjdGtBWWtZ?=
 =?utf-8?B?Rko4K0JFNzJJdW16cUxZOVdrZVFjZFY4K05FSEYyaitCTGZxVFErRUtvUlpp?=
 =?utf-8?B?ZUQ3NXVJSVRaZGZvaHB2aDhCZ3RuQ0tBTEE2TnAwNlFxRWVFMDVudHFQd2Fs?=
 =?utf-8?B?T1BNTklKZkFjRWRkakM0aFFKY3diR0t4M2RvaFArSnZEYlg0dS9OeENMR0FP?=
 =?utf-8?B?VlVVNTdWS3dYL2p1Z1djNm9rMVM0cWQ1S1p6K0Ivd0J4djI2ZVU5M0NnZTBY?=
 =?utf-8?B?QzRUUmEvcG9XanN0Zjk3cWpVUU1NbmhXSGdOVVUwRUk0UG5QSlRQUHZUdGIv?=
 =?utf-8?B?VHY0ajBYQlJKQVpjcXhpYzhZS01SMzNQb2g1QXRCM3NMSXlWOG1IQWVaOGpL?=
 =?utf-8?B?SlhocCtYSG5nWnV0T3hyOXZtbHZoaTlsNXZ0ZU5xeXgvN005L2pBVWplT0g2?=
 =?utf-8?B?UEJGWkFTbEVjaUlIR2V6OFhzRnhHUU5raUhnK1RUbkhSbm9XNFRybnl1bDlp?=
 =?utf-8?B?aEhuL1g1ZWFZZHpybklmQTA2ZzFPZERQUmdzY2ZsQk5iRDFINDFKRVVldis0?=
 =?utf-8?B?UXlSQUlldDFNdWYrSGhiMmF5ZW1lWFBoM1RVVEZQc2VuK2U5TWwwa3NGNXl2?=
 =?utf-8?B?UkVNNlAzd2NlQlFabWk5Z2xweWNBRjRINjRvZ1BFdHFWK3FMM0RNNk4zeUNp?=
 =?utf-8?B?YmVCeGNzdkVNZVRoQWx6ZE1TRjNNalZQNDlCYU1mbFhFN0lkKytXdG4wZlBD?=
 =?utf-8?B?VFFuQU4wVytHZ2tXTEZyTkJoLzJOUGhYT3h2SVBoTXpGQ0Q1NmJmc2c5YmRr?=
 =?utf-8?B?cjVzbUZzOFVXdkRENlZJbmtHVERZa21VZTlYNDBlN2ZBWXp4Sk1Ga1pMeVJX?=
 =?utf-8?B?NGE4cmhuWC90TWhobVZmRkRySlhHdmRHWVF3Yk82Q2xkcSt5T3VkM010bkh2?=
 =?utf-8?B?Zi9Xa3QrRHhQZGM1ZXlaRll6dzB6Ump0QlVRL2NHYXVjYzN3cVZlVk82VWU2?=
 =?utf-8?B?NTNFTTJZanhVNGpJK21vbVhVYXhnOEtUOGJldnNGNWhtbjgraDl5bHJGL090?=
 =?utf-8?B?YzFsS0F3d0hPS0EwanBEc0tnc21vSWVOajFrVmp0UDRIZVpiZ2h6VWNSRWxH?=
 =?utf-8?B?RUxyb1pUbERtN2hOY2s4Tk1ieFYyekxZQTlHdCtKWHp0ZTFtR0J4TklkcG9l?=
 =?utf-8?B?eHJreUlDUjdqeGlsY3N2NWZJb1R6eFJWUDlqWlVPTkE4RVBRK21qdDFTakMr?=
 =?utf-8?B?MmV4QWlYRkI1aE5KOG8wSkxTUGZjOEREcTFFSG1Kcm5mbXRIWks4NnAzVUdj?=
 =?utf-8?B?UjB4Y2tScUo2MUtkUk9sNmxhbnFvMlJoRFo3eC9ZOW5CaHpicGFDdTBOM1l6?=
 =?utf-8?B?Z0NMd21wMlIxcjNST2FTVjVURlU1WFV3aThFMGREWFhSeEtLRzl3b3hYNWVk?=
 =?utf-8?B?UERPTVhVUzFpcDVoSGNIWTVpODNNTG5xdGR5VkxOYlZGNnBPeUY4d1NDRVhX?=
 =?utf-8?B?NHU0OGdmeDgrSFR5OU15Rmt1SXU2VUQ2K0kwQmQ0QzBUdGkwS3ZtQlN1d0sz?=
 =?utf-8?B?SEhQNkhIVmoycU5pK3l0NFRESGZVbURkUjVUVUlpTHp5NGEvRWp6Q3V3Qzl2?=
 =?utf-8?Q?Qoq1MJ2uU3w/Jh0VllgWDxaq8w1ons=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1Y2dlJ6WGZCNUQyakRrVEJoOUgwdzFydWtPTnBhMHMyc1AzUHRiNkNOQzlU?=
 =?utf-8?B?NG9WYWdKRE1CVVJKRVN6TTY2Tlk5TjFpRjlydDNaOXNOcXZLbWQyMXVsU2Fy?=
 =?utf-8?B?VXB2V3IxaEIrb2VCYlBWUWpzL3NXdFphVjRNNk9sQ0NiNWs5a01nbjBYYmQ4?=
 =?utf-8?B?OExYTUhQbXNTUGs2K01lUHJQOUxBN3V1RE8rMElsVFBEYnRMcythWUhaeVBE?=
 =?utf-8?B?ZnJDVzU4bjQxTG9NWitDdFVrU2JmUWVraDJSdGhZaFhNcXpaR1J4RjhjMlpM?=
 =?utf-8?B?R21wamx5QmFhY1BVaW0rMll2UWdxWmpRaWhJRVYvUXE5TTBHTFVBTlRSdEFq?=
 =?utf-8?B?TmlITE42Q1RGNEpLZzJqemh2ZUJkdnVITm5zQUg0VE9DMzFUZnlGVy9CV3lt?=
 =?utf-8?B?bHpKU2pnUTBGUGpmby9QNTNNZXJTSnpaMHVvQ2NCTDFKU09DRGJMYjNrd09o?=
 =?utf-8?B?K1QzMzRvb3FLVkhOeDdzbXlWTlZOTE1qVmh0RHVEVG5QS0FvTWVCcElFVXV0?=
 =?utf-8?B?eGNMSjZXa1hGeFJScktZN2U2T0pSVkQ4OTBndm9lNG1RV1hlN1dWSEw0L2J3?=
 =?utf-8?B?dHVNYnBUaEl4RHVxem9wQmFpN3R3aXpFNGpoV0h0YklXaS9YVXRmMndKSGMx?=
 =?utf-8?B?Zm9tZS94a0pGYzRyaFVuVWxhd0dFbjlYSkE5cG5QUHJsbzVuenltZGRpRi9B?=
 =?utf-8?B?UzFQZkUrR1hXdi81aDYrbVNCekNhejNqd1F5Z0VmOGRCZUhPOGt1QkpYbHJQ?=
 =?utf-8?B?NHAzR1dqeW5mWENmMEt0N3dFdE1RYk90TXpzNFZCZ1pOUXpHRkVBNVpSMEEz?=
 =?utf-8?B?eUdKVGFmKzJ6b0FBMENZeXBxNlpaUnNTMFU4Vlo3RkwyYjU2a1pUejYvNkU2?=
 =?utf-8?B?RENZUmRmUy9ETUVhRytYMElnQklrcU5CajFiNkpmT1d1WXhwQSs1akQ3TTFy?=
 =?utf-8?B?US9SdlNBVldYVXErdmViTjVsOEF1amNLek9RVkJQMUFWOEFtaFdyaHlML21W?=
 =?utf-8?B?M2RnUXlzdFZpV2ZoSlVrZmpDMG9ZNEpXWWdHLzNpMjdHaVl1a0hEUEVSeUJR?=
 =?utf-8?B?L2Fwb0ZVR0dRVEJMclQ1cVVRZlJ6eDZYdDVmQTF6b1hENnVraklQQytnWDN5?=
 =?utf-8?B?TTU2eWRnTzd5UnJMNFk4aDR1UVdSaWFRWllHSW81U0hYZm1BTHVOSzF2U0hL?=
 =?utf-8?B?UmpxcjhXVENmaHdrSHhoZjBBdjZLa0Q0ZnlvckFJY3JyazVZQWlZaUM3RU9I?=
 =?utf-8?B?cWkwcWR3SWwwZHRIV2pCOUtwMTRIczQ1Q002U015SHp6QnI1QVVwK21zZnhZ?=
 =?utf-8?B?VXlvS3VPYWRna3Rnb2NwNXd0azBnZDNHcWtneVh2NllnSEd4MGQ5S2FGdnla?=
 =?utf-8?B?bUhobmE0dm84ZXBaekxUa1RTMXFkR09ZZEdzM01XcHlNbk12VHo2NWdWUGZs?=
 =?utf-8?B?cmFZRmVlaWtlQ1Jnem4rczg5Ui9tMGlENVd0UFlPSUpVYzh0V3dFTGQzejhT?=
 =?utf-8?B?YmVuRXJRSEVUNlZ2YS9jcnUrMnc4N09zMy9qZGtBdHk1bi9OMU1ydVJ3d3lD?=
 =?utf-8?B?cTZzcVhnckRyQ3FnbGNkL2RZQkVGSE5qMGVmVmNjL3NGWFdZMFJsMWwySkpa?=
 =?utf-8?B?QndDOGV3cUVySVQ2dVN4RWEvZHBQZng2N0xxbTBlS1VpVE83dGxIRmEyMllY?=
 =?utf-8?B?SWtybTJ0WjlwTmJnY3RaUWJZVFJDbjFKOGRlem83Ry9qWU1VRjhTK0ZNSXVG?=
 =?utf-8?B?TnlGZFNncWFwQlJMbUhSUlAzakx0NzFZU1ROTkJqRk9Hdlo0LzZ5NWFOdDJY?=
 =?utf-8?B?dzZyM1hBMEV2QnI1UFgxQ21lZmppUWhYZ0dpRWVvY1hPRVZ6UjE3dUc1Y05P?=
 =?utf-8?B?Y0JKTklnVnIzQ0NEbStydFFmMEJ2cWVPaDFRUCt6emhQelBiU2MzSUtZYXlW?=
 =?utf-8?B?a1dHcTlHaWRIbG1ERlRlQ0pJUDdhZjJaOFl1cWZRNk1vNUhXT3czSkJvQzdO?=
 =?utf-8?B?TldkTFI1RFhXOVc1TytLNVpSanVMMnU2VEdOYzlqSFlhdjg4Z2w2bjNCdlRi?=
 =?utf-8?B?MDQvTVlBeGd4bWs5SWlSRGltVFpWcmJBbWVhZVdIZFpJREl3OXBuYytlVWVO?=
 =?utf-8?B?cG9ER0VYMEdsRzd4U3RFa2xNaHl1RVZwazBkKzVZQVlOakZ5NG9GYklCdDdk?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBCC323A2DB6BA4A82732054C7E03603@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78710690-e78c-42fd-bc77-08dde19986a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 16:32:46.0897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qieqZe2m1XnzNi+Ed+f9O3u3MZMFEwmruDr0TxjIOI/YFIzFmX/lfUf3s3DEn78XxJh1C2ohuvAXLgUgHy0Lfj26sA+vo1drN1s2OBCxnCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8151
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA4LTIyIGF0IDE3OjM2ICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiBQRl9VU0VSX1dPUktFUiB0aHJlYWRzIGRvbid0IHJlYWxseSBkaWZmZXIgZnJvbSBQRl9LVEhS
RUFEIHRocmVhZHMNCj4gYXQgbGVhc3QgaW4gdGhhdCB0aGV5IG5ldmVyIHJldHVybiB0byB1c2Vy
bW9kZSBhbmQgbmV2ZXIgdXNlIHRoZWlyDQo+IEZQVSBzdGF0ZS4NCj4gDQo+IEhvd2V2ZXIsIHB0
cmFjZSBvciBjb3JlZHVtcCBwYXRocyBjYW4gYWNjZXNzIHRoZWlyIEZQVSBzdGF0ZSBhbmQgdGhp
cw0KPiBpcyB0aGUgb25seSByZWFzb24gd2h5IHg4Nl90YXNrX2ZwdShQRl9VU0VSX1dPUktFUikg
bmVlZHMgdG8gd29yayBhbmQNCj4gYW5kIGRpc2NyaW1pbmF0ZSBQRl9VU0VSX1dPUktFUiBmcm9t
IFBGX0tUSFJFQUQuIFVubGlrZSBhbGwgb3RoZXIgeDg2DQo+IEZQVSBjb2RlIHBhdGhzIHdoaWNo
IGRvIG5vdCBkaXN0aW5ndWlzaCB0aGVtLg0KPiANCj4gT1RPSCwgYXJjaC94ODYva2VybmVsL2Zw
dS9yZWdzZXQuYyBkb2Vzbid0IHJlYWxseSBuZWVkICJzdHJ1Y3QgZnB1ICoiLA0KPiB0aGUgLnJl
Z3NldF9nZXQoKSBmdW5jdGlvbnMgYWN0dWFsbHkgbmVlZCBhICJzdHJ1Y3QgZnBzdGF0ZSAqIi4g
SWYgdGhlDQo+IHRhcmdldCB0YXNrIGlzIFBGX1VTRVJfV09SS0VSLCB0aGV5IGNhbiBzYWZlbHkg
dXNlICZpbml0X2Zwc3RhdGUuIFNvDQo+IHRoaXMgc2VyaWVzIGFkZHMgdGhlIG5ldyBzaW1wbGUg
aGVscGVyDQoNClBLUlUgYWZmZWN0cyBrZXJuZWwgYWNjZXNzZXMgdG8gdXNlcnNwYWNlLiBpbyB0
aHJlYWRzIGFuZCB2aG9zdCBhY2Nlc3MNCnVzZXJzcGFjZS4gU28gd2h5IGRvbid0IHdlIHdhbnQg
UEtSVSBzdGF0ZSB0byBiZSBpbmhlcml0ZWQgZm9yIHVzZXIgd29ya2Vycz8gSQ0KZ3Vlc3MgaXQg
aXMgbm90IHRvZGF5LCBidXQgdG8gbWUsIGNvbmNlcHR1YWxseSB3ZSBtYXliZSBkb24ndCB3YW50
IGEgc3BlY2lhbA0KY2FzZSBmb3IgdGhlbT8gU28gcmF0aGVyIHRoYW4gYWRkIG1vcmUgc3BlY2lh
bCBoYW5kbGluZywgY291bGQgd2UgYWN0dWFsbHkganVzdA0KcmVtb3ZlIHNwZWNpYWwgaGFuZGxp
bmcgdG8gbWFrZSBpdCBjb25zaXN0ZW50Pw0KDQpCdXQgYWdhaW4sIHdoYXQgZXhhY3RseSBpcyB0
aGUgcHJvYmxlbSBoZXJlPyBJcyB0aGVyZSBhIGNyYXNoIG9yIHNvbWV0aGluZyBmb3INCnVzZXIg
d29ya2Vycz8NCg0KDQo=

