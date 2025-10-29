Return-Path: <linux-kernel+bounces-876766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D58AFC1C432
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39F035681C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4D33B6E5;
	Wed, 29 Oct 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ti2H0XK1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38A272E45
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756383; cv=fail; b=Dk1AMy2NCX8ERhuYav8fNstar7iYCWqQ6xefxvRZkccDGQjseCDwgOTv0O6sXHWayOps2Vr+KxMZ2q2pUsd6TOvPIK4Wp3NCd2zDtFwjlKfKJpLctCVpWyIHfuwmJaGyyFmVRFAVHKqvJLxqsxD0V9cmvbcU9LmvjFPCqOUSRz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756383; c=relaxed/simple;
	bh=qA5CSLsiPPb8wNBR6G4xAkfDTxLgXDrXZx3ru+kFzHE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KC/JQrAHw6QZOeZbzjhWeUggG+RG48tKmaYnkUokX9Qd6UiOonBtYQqAFQ6H2ISExt0zXy5PN8v6nSUvHEoy1m2xSilfRC99zrM0Cs1c4YV0tsNo1n4Avr5lp4IAmR8qtUWpKpMaw1C4/21Za6r0ylYl/GObHGK3kBdLgMlvO2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ti2H0XK1; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761756382; x=1793292382;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qA5CSLsiPPb8wNBR6G4xAkfDTxLgXDrXZx3ru+kFzHE=;
  b=Ti2H0XK1/aCcCLptdgZmWokhBO5HmgLBYmXZh9A5GPVVr+ZpfbfP/ccI
   zVm25hrPhQbt3EbHP67pAbwcZBg084TTjslh9+3aYhZAP0BsyIkhkxgug
   GNeNSjmZvK+v4ZVm93dImG5j9vN/H+lPK7DAh0l2jeUHj20e4tJDg8PO2
   kczlWLnR4y1aoBZ02NSnzZNZ/0HpYgXbN3sC80ZcRlW+6Hz4LUIqSGXLt
   9bDf/r2yFydcZWs08ZMsm00Bjhtj+FC9tz/qMxnUvUAe/l4og5VsRNuJY
   +QTsp0aEgihP3oDdQrW31QCgOJ7M2+dTL8OtOFh38VnzvYRDLbQZI1Ws8
   Q==;
X-CSE-ConnectionGUID: bYzN7F2RSCGhhxA+lV2Mhg==
X-CSE-MsgGUID: xFPJNCdYSF6NPsTQkCIoMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81514523"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="81514523"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:46:21 -0700
X-CSE-ConnectionGUID: L9B6dIYERqKSJ/WC25iQfw==
X-CSE-MsgGUID: DKMYbaPnQ2OvsGJmBygAlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="216577484"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:46:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 09:46:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 09:46:20 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.25)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 09:46:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8vZukhKehdbQw9PWkTyIe0H3cxoT7o8B053n7j1dmfiAFWj5O32lQb0XgtPD5KHgAQLAMHLhDqe8aeQ/fZEpTjL41FWISU0WvDqsfjcLhtgPwU4sRzIsOzl1fmmTlnJoI/3OI5zKrNmISFqLZZACBTkII7MfDx2l/2Ho4KhrB/g7me0FvEaGOo2t7gWdD7Xql6khev/79tKC6u48P2gHhd8ucp9pBW8JHecdJG1EIjN4DKpg1Nd4tItznQr2ZidSq/2R2bsUVAvsGUFge64Ie9KUr9FQJinWq+H6S8jc20PEW+HTrVJEcHUrqm2NCDVbNKjerL+LFpG0+LsqFxRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fngpc6+10BUnELYQ3/H71Hik8Qac9rVMDT6AGi5bYzE=;
 b=Lf1fJOvisEqNEVexS4zU12ZJb5vsCQ+8KxItdpVgzVJZBclCDsMlEJVhciW6jzWofm7Kfv8t8VL58cGsgg3g9c5SpDLTSEGcNA7S6miGIIRbl9uO3UWzEfHv86usRpbDoJzyaED+/FKjSd/rIGbfNquQfuEhvYegF67V6GerJPemsLqxvn2pB474dZqaGPy8Le7+SxNxLHmPUZ1Ut82PMMro5RMF71iaakuZiH0nq38HFzSoF7vQDzVWnuE1f8PHCunjWGil5ehzutObbXqx/2Vyr1W/8vw1i3jKEgAZP5EiE4me7VNrq0vHjq4tblXNmTKbmB5ljIQuOAvaNtyvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB8456.namprd11.prod.outlook.com (2603:10b6:510:2fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 16:46:18 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 16:46:18 +0000
Date: Wed, 29 Oct 2025 09:46:15 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	<intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <jiangshanlai@gmail.com>,
	<simona.vetter@ffwll.ch>, <pstanner@redhat.com>, <dakr@kernel.org>
Subject: Re: [RFC PATCH 1/3] workqueue: Add an interface to taint workqueue
 lockdep with reclaim
Message-ID: <aQJE170PEFatwXCG@lstrano-desk.jf.intel.com>
References: <20251021213952.746900-1-matthew.brost@intel.com>
 <20251021213952.746900-2-matthew.brost@intel.com>
 <2e1e9d6f-4f9e-49f7-90f0-6759c260701f@amd.com>
 <aQEkq7DYy5/AaJ4R@lstrano-desk.jf.intel.com>
 <aQIthmQmKfztyaQZ@slm.duckdns.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQIthmQmKfztyaQZ@slm.duckdns.org>
X-ClientProxiedBy: SJ0PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 3112a4c3-e586-4b43-3887-08de170aaecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnhaOHc5UzErZVF5VUw3TzlYdWRKSUlhNkFjZVFYb0RIR3k1ZFhZa1JXZWNG?=
 =?utf-8?B?OERsUU8zNkpNT1JseHREeUw0R1k5RFA2ZEl2UTR1S3JIWEpvSnVvRlVBRWc4?=
 =?utf-8?B?amF2bGdpQ3RqeDUyakNsb0NIZVFjUHdlWE9HMGVKV2pZR2JjUlJrTFFSeGdU?=
 =?utf-8?B?VVBsU1BWMS9kVitNdkZ5LzdtQ0tub3ZsVXdTVHRaK25QZ3JsdXlPMndxcWNW?=
 =?utf-8?B?UXBES1JjTzhhNHhMeWYveTlGWm1UTnYyL2I1QmxsZHdxQ3FwLzBpWjA2SnlR?=
 =?utf-8?B?eWc3LzlvVGxrdjB0WE50S1hNbEFKRUVqQm1UWTlFcCtocEs1RnhmR0VZbTJu?=
 =?utf-8?B?b1cvT0JEdmxEQlBaKzhTZDJFWXRZWnhoWU9icXBvVHBWdnFnbllFbFJ3VVRh?=
 =?utf-8?B?YW9aZm8xdy9HTEZoNUFEc0MzSXQxN3lQUXYycnJuN3VMbmJUcm1KMjBQTWht?=
 =?utf-8?B?QlFVMGhVZDZYMDNHbGdDS1BINitkZUtOUit4dlhvVHhtcXJ1MjZrM1QwUGV4?=
 =?utf-8?B?TE9tNUJQd2Myd0dNS2wwUUZhRHVSZjAzT0thM3M5SjhxaDZBUHZBb3lkQzVI?=
 =?utf-8?B?ZytYYjZkMytuUEtiSlJpbXhNZFU3U0NPSTltOXVKRjF4clE0Nm5GbSt5Qy9Z?=
 =?utf-8?B?Y1JqdUs5dms0SjdBYi8yUGQ4TjhRRjkrODJsWXJ0NU5CRC8zRmpTS3ozQUpz?=
 =?utf-8?B?Z05LQU10bk13Y0k1N0FacG5vN29CVTkwQk5sQ2QxbDcyNnVsSjhTVUxHTlhq?=
 =?utf-8?B?UjVwTVZERWkwTEx3eEIwQllrRDRlTUV2MHB1Y1hmaXZOL0Q1UHI2SGpBWkhH?=
 =?utf-8?B?WTA5amVCTFFvYmkrb3M2QkIvbk9mVVB3TXV1QkpQZUJMNmwybjVTeGdMaGZn?=
 =?utf-8?B?MFJCZFNnZGJ4YXk3OGhTWFk2b1VrOEFDbzdCOUVSMkVLN3Y5WXF3cGFoY1la?=
 =?utf-8?B?akJWUmwzMWZGSzAzajdCOFUweWFMKy8rNVpaT1p5MmNHeFEwbTY4eWxTbmpu?=
 =?utf-8?B?UHkrbmRGSkIvWXBFVkp3MnRkdnlLK1RUbXV6TWVkZU80U1RzdDM1OVdOeEto?=
 =?utf-8?B?TkJ1MlFHcUNUdTBVY3VRSDc2NVpITDZ2WGtHWUZQZVE3VEtPOElneC9yeXRs?=
 =?utf-8?B?S0J1R2FLUkxRZ3lFWnFSVm0wUUJjN0FWQXQ4NDFwMnpBMFRaODRCV1Z0NTc3?=
 =?utf-8?B?VWNyZlBaWEVLMGYxUmhDbStJYjlrMzV5ZGcrSVRwUTdTSHcydFNwYzRTNGF5?=
 =?utf-8?B?UlJSWEh1NWNmWFBqQW5BbEs2ZnYwTXF0Y3VLd1ZHMHorMXNiTU4yd3Y3TUdk?=
 =?utf-8?B?WmI4T3k5TWFCbnhjNEJ3aEVRN3NucGtUVVZ2UXJjUW9GMldtUUR5cjAvL2VV?=
 =?utf-8?B?Z3FUUE5QTXRURzRCUmwrUHFGbXNCaC9FR0wyRmNxVmZxSmw3NVRuQkhlOUtC?=
 =?utf-8?B?RCs3Y0p1bmkyY1Y0czBDQ2Z6UGFQNWkzUEdFSHBSNUFOK0JtR2dBS0w4QnZi?=
 =?utf-8?B?ZjJpMkdRYXhxUHk3TERldHA5bjd5SitkbG16RndMQWMrbHEyajZGaUFtYUZs?=
 =?utf-8?B?R3NEMmVYVTdxd0ZaQ2lmdjQ2Qng2TVpvRHdNZUJKdDJlN2dBclpSd0pJWjl5?=
 =?utf-8?B?eEVTZGlTL2J2cFNqYlBYTDJFVUhVc2lkWVY4UW55eW0xK3MyVURBdWFYQ0RC?=
 =?utf-8?B?bXY2QWZJRHJCQTM0UXdOMzVpYWNKcVZFVWxlaWxkc0ZvUUozLzY5TElvalJP?=
 =?utf-8?B?WTZpdGVTdlpZdTEyMC8vQUxPcGhHSEpVQ0l4TmpnWEEwdDZ5OEp3Y2svdFVk?=
 =?utf-8?B?OUx4TGR5ZFZNZlp2NEhXUkpvbCtlUFNCd05pWmNmUyszTkMyNmxQOUptV0dE?=
 =?utf-8?B?bUdvRzhWRXVNNzVEOG96MjBXQjJPRXNPc29mS0Qxc0NKTjJObWY4M05NdEp4?=
 =?utf-8?Q?nmeGYOtCIIfN2cFWovdzOXGtPDBJCjMK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxSZ2pJbk9Cc29GazU2cmltcVh3ZEw4V0lGWWNRamVhL1c1R2FNNTJLNURO?=
 =?utf-8?B?THhsclJGSjd4UFBsNGtSdDE2WkNOb1hiK1NlWU9LcHBYTDUrMEVQU1V1Qi9q?=
 =?utf-8?B?OHZpZVRUWXJLVm1VdXFIdDAvWGZjMjZmV09nQVNjRmdCM3BRZzBvK1hVY21k?=
 =?utf-8?B?ZTJ5b0M2dGdIY3JkRFIvLzd6amhVdHQ0bzI2enBLZmRPZG1GM2E3RkJ6anZS?=
 =?utf-8?B?Vi9DZ0lmL2JYOW9uQTMxK1A0RWVxaGx3T2RHN2oxZEczbitLcWNrNWxwMDRE?=
 =?utf-8?B?ejJ4T1FaRDdzU3o0aW50cW1CMFFLcTJkSXFlUm1jT0VSOTlQa0ZwUE96N0da?=
 =?utf-8?B?OG5BVUNySFVuY0pkam9ZM2JsYkc1WGh5NFdUMUFiU3RDN28xam1zUnMrOWd2?=
 =?utf-8?B?ajJaMUpLT0hVaHFybjdLTDljbU1PNE9zbUtsOWJ6MUJZV08zdXJDajdNTWd0?=
 =?utf-8?B?MEJ3Mk5ldEMrbFpvczNOTjA4Vys5ZFdrbG9Kc1BtR2ZibG9Sc1B4alY1bzhq?=
 =?utf-8?B?Q2U0Z3hYcDFsOW1IbTg3SlRtZWVHRE5hb1hTNGdaeUpSOW12RWRHUU1nVEc3?=
 =?utf-8?B?TTJlMDVnOUxjaDIyUGI3R2F6dVMwejJFNitQQksxU3FZY1grejh1YlB4MHd1?=
 =?utf-8?B?TGMxQ3RFcGJMRTkrdW9vaE1qaFlOalQ5Rk1aZFNFd21yOUhHRTBmclUrZWla?=
 =?utf-8?B?dEdGMXBqUXNySkhMbVNmKzZGYmF5aEpkSzI1ZmhwcUcveFkxN2xvUlJUV2t3?=
 =?utf-8?B?R3VzOUlwNUNSbVdMY3gwV2h3Y3Rwa0xDUzJ0aXNzQnk5TklPSUxKWGhLdVJ6?=
 =?utf-8?B?eUZWT01oUElyYjR1OVd0Y0g4aVFPc1RpVmliUnJwV05heWpDR2RuSjUxZ0Jr?=
 =?utf-8?B?eENQZTVZVWR4TVhnTkZnRUttV1VSd1Njd0lzL3BqOGN1S05abHowQTNCcE4z?=
 =?utf-8?B?U1VxYjVhemxEQ09BVEJWWVJacjhlbkZiTTBBTkNwU2Y1dFlLcnJMcXlGcEtu?=
 =?utf-8?B?ZkNNZTJlUnd5L3RpSU91TGtRN1g0MzlOOE5UTU42QnVIRkJHOTVSSkZHRG0x?=
 =?utf-8?B?NnVFVnBxdFdlTFlpMktIeWJ2WU0zRXBNcXBlK0JJVWtla04xZi9FZU0zS1hS?=
 =?utf-8?B?Q0JNSGIzd3dJZFIwSkJKMFUzSjdRMVZma0t6VkZHOWdOcHoyTllielhCSCtx?=
 =?utf-8?B?Zy9vSzdvRFBmTGcwOG51eVdLMG1qQnNzcG5uYnhuWThlbVVrM2w0ZlJkaEI2?=
 =?utf-8?B?MEdiRU11bk1ZL05sakE2Q3dmci9VMEcxZUpDc210T1JOUU1zYXYyNGNML3ZS?=
 =?utf-8?B?VWNtWVNPMjlNNUh3aXZMNTVNOUZwS2xpdVdVcGs2dmtPc3VWSFJYZDNiS3VK?=
 =?utf-8?B?ak16QzdQbHoyM1NjazBQYTV6UEJsR0dyZ0p2azZnemhlTldZMmZrWG0yNmZC?=
 =?utf-8?B?bUliK2hlRmtQT1NIVW80eXlLR3RHcUYzUC85R2VNOVEvcTNucXNFYUd3TzVQ?=
 =?utf-8?B?RHdXT2h5cXRVcjNmNy83MkdGY2dWb055VXU0dnBZdHkwMVZ0MTBGSXZreG93?=
 =?utf-8?B?QXNXY1Njck0zSkxyMVdhMVJqbFNwNG8vMXY4R3hsZmVzQVM5Y1M0Z25WeHRZ?=
 =?utf-8?B?WmpEU1NGRlZYNWVPTkwvMTVLUmloODM3bzBrUTNWQlRXRkxudVliNVNERmFh?=
 =?utf-8?B?UWd6c3VzQm5vUUFHZmJ6TWpvUmxYUFNPQUVIcHhzYlE4eExVaUZNVi83amhK?=
 =?utf-8?B?TXU5bUVMUzB3UkhIREpIblFieXdGOWhiQWFRSlhGOExDS3c5cElndXNLS1pi?=
 =?utf-8?B?cUJFUEFGWitzVjUweE8yU1YzY0txZ0dWazdJQS9QMm5mQ3V0dHJuNkxVc2JY?=
 =?utf-8?B?YS9qVW5wMXFZeEpKa2FyWW5EbE5ES2J0MEhrdmNOQ016alJPTG9mQVgzWk5M?=
 =?utf-8?B?OUhjYTk0ZUtESG1Ja05KRnFzRi92ZURCZy81Y3JLSDhPUjJSVlhXYVNrNUJ1?=
 =?utf-8?B?UFd4azFrMUY4dlNPQ3l6WFpIVXczYWRQS2N5U2twbGFuUWJUcEZzUE5UR0wv?=
 =?utf-8?B?aWUwZDhlQXpxTHQvWDVBejNIblhGNENyMVVseXE1MkgwdFZ0SmFudHlaenNR?=
 =?utf-8?B?aTdWWFpDRDkwWjkvczZhbTJ2aXVHUFprV3JPbUY5UkMraG1YRjRBQXZOQVIx?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3112a4c3-e586-4b43-3887-08de170aaecd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:46:18.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Sm7ZSNPcFjXnDnRcEsEbJSl5FZVW0Gaqdf/nYQta++pqpMg8V25uYkZg50bdlPIhJMfHgc78DwvANkopgsSbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8456
X-OriginatorOrg: intel.com

On Wed, Oct 29, 2025 at 05:06:46AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Oct 28, 2025 at 01:16:43PM -0700, Matthew Brost wrote:
> > On Tue, Oct 28, 2025 at 10:32:54AM +0100, Christian König wrote:
> > > On 10/21/25 23:39, Matthew Brost wrote:
> > > > Drivers often use workqueues that are in the reclaim path (e.g., DRM
> > > > scheduler workqueues). It is useful to teach lockdep that memory cannot
> > > > be allocated on these workqueues. Add an interface to taint workqueue
> > > > lockdep with reclaim.
> > > 
> > > Oh that is so wonderfully evil. I'm absolutely in favor of doing this.
> > > 
> > > But can't we check for the existing WQ_MEM_RECLAIM flag in the workqueue handling instead?
> > > 
> > 
> > Tejun suggested tying the lockdep annotation to WQ_MEM_RECLAIM, but the
> > entire kernel explodes because many workqueues throughout Linux don’t
> > adhere to this rule. Here's a link to my latest reply to Tejun [1].
> 
> How about making it a WQ flag?
> 

That could work too. We want to enforce rules of drivers actually set
these flags setting passing workqueues to the DRM scheduler. Any
objection to adding helpers to the workqueue layer to fish the
information we'd like to enforce?

Matt

> Thanks.
> 
> -- 
> tejun

