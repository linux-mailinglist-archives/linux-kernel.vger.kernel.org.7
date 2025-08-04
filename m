Return-Path: <linux-kernel+bounces-754746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFDFB19BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8331B172B3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE47233711;
	Mon,  4 Aug 2025 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwrLOzQj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA982264DC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290394; cv=fail; b=kjODOHWeC0JkvPZzs//ynwVlZKnxZGsPhC9wOlNA2Ni2xiv1b2zDBgGoITGxPyZs6+Di/aWxWnZ7PIDrQ24XjviV2FMabJRn1TqtipQ/VlGfZ18zcZn9QfulVvrIc0IxhLXDOVjQH/6DUtg3crvboMnwYTwgsyYLE271rWr0JLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290394; c=relaxed/simple;
	bh=aqkORv1HNwX59CYgiy2NtDchKuSj2uhgY57onOliLhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VKgO6x+lcFqstTT1MHRhp1iKQwzTkqxPA01WwWk/2Fe+LZ9uteavkTxSfbJR3DQbebYD1wGsOeHhsyY+Q5f8N1p+dNz74hzXlNn3CTaka2yiZ1pOpoq7ooefo9NwnH6AmzRuddYz2IfJBzGOTwRzXk6BENFXPsE7M4LAkWyVtjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwrLOzQj; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754290392; x=1785826392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aqkORv1HNwX59CYgiy2NtDchKuSj2uhgY57onOliLhg=;
  b=jwrLOzQjNtfc883sli9AkweXszLWHV+gs3Z9Tkq+SmMZ9AtT6ZgeBvtH
   a+1IHlyZNCm6MADgOrtAwhNTv0Y8B3AhK6PXn3hyfvRDhiyD6roWuTb2H
   Rsdm2iaOSJSz/hTBpM4TDalRdjPP3ptQXGo5e3GOPsl95hRPWGJ8t1exo
   sk3ggA3KP4RyJYB8oaA1e6v3izpEhzn8Imzyt4yweH89/JYZ4Ip58TMim
   8+dJ8tt8WXnQtegBkPGRh2PFKXkrKegd9qlTqboiGu968V6gliZMf3Y4P
   5aygq02UUzUPw/PMNVbol6emn8ZYSIwakVx1/1hNrKYUVgc2rn9fU0aBp
   A==;
X-CSE-ConnectionGUID: oKNjSr5/TZGNxfdrzyaafg==
X-CSE-MsgGUID: 23/rY0VlSFqftPUvOCADsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56469534"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56469534"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 23:53:11 -0700
X-CSE-ConnectionGUID: FXhiXlmzQfm+wTH44wH56w==
X-CSE-MsgGUID: /kcTo0xJTneaG+s7YL1a7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168337912"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 23:53:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 3 Aug 2025 23:53:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 3 Aug 2025 23:53:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.79) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 3 Aug 2025 23:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLaUrXAkXAuyFy1K17hJ7BNM0D3QY7D1OmExl9Ea0OUpmLCqg3RVOBbnvdkqVy8uJBazOAMPoWLNuTNbGKqND81f5nixXka93w7KbGozomFG3cD3uhkpx6R/bLYi+poyDwJ1ak8HwxtW4YifI8Q3J0ybYVDR34gRN2XHUD1aUBWWhSv+o65N3iVNNCKUKYq5UBeMu319C1Dq4s3jTL8uZdu0itMA2SOQyo6aiMFXvrs8Ueo3KLJonKHRIBGlL5b8RGXhWS8otELQfIfA/uVSCpdyygtjAJlueFYctC0tUn0jdCCXa47ccQfaH3a0GrOINYd53n6exUiEO94AKGIIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqkORv1HNwX59CYgiy2NtDchKuSj2uhgY57onOliLhg=;
 b=fYumHVrjd2Jc3lGdMjebZjjcL1VavVrWM7K6AqFWwJvk4SdzVZnT3lswdXnJxyW/JxJHDmbvxO1ffQ+T4F5nCm3nfw6YcL56jhyeV985yhaQWKuDs3y+avXmYJK54eNFdnfzd4aU2d9CeRiEPR8jxZ36jXDcPTRzxWmRZ8ep/ryv/TCes58qAV0F098zy0RZv8aD/nknwx3kQFVwinw5CJ6CCV8wGG0KrAuZqukpnW7ic7HRk1iyZPvyt8/ed9lLnNEnMA9EHsyyLIBxUd/IF4DdoZPVnv3thkfirMWCPI1A5xiTHzC34paqvsvBkjuQ0T5L4frdf7PkeOrLlXozLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by IA3PR11MB9423.namprd11.prod.outlook.com
 (2603:10b6:208:582::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 06:53:03 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 06:53:03 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>
CC: lkp <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Berg, Johannes" <johannes.berg@intel.com>,
	"Stern, Avraham" <avraham.stern@intel.com>, "Gabay, Daniel"
	<daniel.gabay@intel.com>, "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"Anjaneyulu, Pagadala Yesu" <pagadala.yesu.anjaneyulu@intel.com>, "Ben
 Shimol, Yedidya" <yedidya.ben.shimol@intel.com>, "Berg, Benjamin"
	<benjamin.berg@intel.com>, "Triebitz, Shaul" <shaul.triebitz@intel.com>
Subject: RE: drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:2093
 iwl_mld_set_key_add() error: we previously assumed 'mld_sta' could be null
 (see line 2076)
Thread-Topic: drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:2093
 iwl_mld_set_key_add() error: we previously assumed 'mld_sta' could be null
 (see line 2076)
Thread-Index: AQHcBQo5XqzWkzaKQk60i1MqFzXbK7RSDl2A
Date: Mon, 4 Aug 2025 06:53:03 +0000
Message-ID: <DM3PPF63A6024A9B5D0F46BBAB9CADD604FA323A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <8bf5e723-f70f-4767-8d8e-476143c962c3@suswa.mountain>
In-Reply-To: <8bf5e723-f70f-4767-8d8e-476143c962c3@suswa.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|IA3PR11MB9423:EE_
x-ms-office365-filtering-correlation-id: d72f55f3-e707-4382-ebef-08ddd3238f27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Wng0RE83TVQxTmN6OTBiRzMrVnh1ZitWbFFjeUZ1aWNVSFBvS21hZDVEdXN4?=
 =?utf-8?B?N0ptOVRlZnR1RzlIMmoxYjVJc0VacmlXbkZ6SURMRDZSVU81M0NkeGE5ZVVQ?=
 =?utf-8?B?VGRDWVB2ZUczSHRaOE5paVQxTHhUUjlab1h0emg0cVphaUcybEZEWjNYSEZi?=
 =?utf-8?B?eSsrc3ZWdm1vakwxUDJlWUtYZUdXK0dhdXFtbzBGQU0vcFNudFExM2p5d1ln?=
 =?utf-8?B?NUtPSW41OGx2OVJROXd4Z3VjQ25MaVpmV2F1WlpKazdrTE9Yb3dsSFNlSmZh?=
 =?utf-8?B?U0NaQ0liZHByTy9ZelBUcy8rMnN6UGdnNnQ3RUJFaW5nWVMrOVlJU1lkcTJU?=
 =?utf-8?B?NS91Tm1Ec054QnUrNDFzd3dXdHNuZGUwRXFhS1VZWExOZ3Y1UDBoY1FTOUwx?=
 =?utf-8?B?UFVTb014WlFOQVI5NWQ3bkY2K0J0OXV3bjliL0ppaDUyWlJXYzVpMzRsenB3?=
 =?utf-8?B?SzFYbHhSQSsvcVdNcHZZNTlUNUNkU0dDUTF5TnBJaTJRS2ZCcExobUxLWjFR?=
 =?utf-8?B?RzZQWUs2OGhLZEUxQk5uK0ZhYTduZEpKb2VVZ1hLQ0xFRlNDQnYxRUhWYmN4?=
 =?utf-8?B?SXg2T0hVTFAyQ0gwYnp4ek9EZTlhZ0hKSmtwNEQwaHZ0SlJPaGhBeGYxaGVv?=
 =?utf-8?B?aEdKczVFdlMzZTNYdG5oNkNMUHZiNHBpdjNORk0ydnpvSERoNGJQaFR6UVgv?=
 =?utf-8?B?U3NHdEtOWkNTY0Y5bGYxQndqMTE0eDN3VU1GTmdPZW1YR3RQUWZnejVJeWpR?=
 =?utf-8?B?YnFLL3pMSXlrVmgveEJuUlBNVzcxT1MxQUVyM1dZMUdpbUxRRmU0bkhSSTFP?=
 =?utf-8?B?U1dYM1p0NG13L3pjYnY5SE1zTWprSHFOMWNLdjBHeFBrMVlWcGdFL0IvRkZ5?=
 =?utf-8?B?a1p3SVk3d3NsaU9TTVhPZ3VOQkxkQk9GM0J4eDA4UVpOa2c1OEI5dU1ZQU51?=
 =?utf-8?B?ekYrbUpKbDRUcllBVkttbkEvSmRXRGhRTWNGVlpDSHlmTUhrYyt1RnVRY1U0?=
 =?utf-8?B?Q1ZLcUFWQ2xhS1N2YmVQN2NYWXViQVFQUndFa0lCTDc4TSsyQzBKYkp4alQ5?=
 =?utf-8?B?dkxNMGFKNnR6NzlYV1VGUElXd2FLWUQvL3ZTMTc2OWY4cGlUZ0tRUmswUFlF?=
 =?utf-8?B?WEI0RVFndHY5dTBYQXFCcjRmd0ZNRmRQQXBSelpuaWc5dHZFUTcrSGQwQXJL?=
 =?utf-8?B?aENhTTgzK0U2VXQzcGFRaFJscElpdkVrbEdUZzZoWm5sUjBwNmE0TTZwN25D?=
 =?utf-8?B?aFdHM2Y0N3lKalM1V3dJa3lsWStqbkhnczV2SHZ3R2VjMnA5NmJHUW1PZm9V?=
 =?utf-8?B?WGxlR2dFSVlhQjVLQ0VOVTJ0NVRwcm55UGhOQncyOHNvTVhoclpWSjNwbWhB?=
 =?utf-8?B?Q1pQNE1rNzBPa1JsRU0xVlgvbDhIZkJhNVJLSEQyZWJLNWdYbUJSVHZENjJu?=
 =?utf-8?B?VzNTWmVDYVBjeFZ3N3BkcEYvK015bVUxYUtIVjlvTTJCVHpTUE45Ly9nU2dh?=
 =?utf-8?B?WnlFdlN4NGlUbTJ5OFlnaUp1MEFDUVZ0MWpsdGdEQ0xQL2xGUnFGeExTNTc2?=
 =?utf-8?B?K3JPdWNTYnVpTHd5Vnp2UkI3Y3p1RzVaZE4zTHhMeVpEZXJYMnJadWc4NExU?=
 =?utf-8?B?cGFlRHl0c1FlVVVqKzNIbGczZ21vdUtZUWZjanZzR3ZqL0xscXhTMDhKWWda?=
 =?utf-8?B?Tzk5bS9DUVE0VHhCSTByVnIxUUhiY05oSHgwZW9mbk1Ua2VkT0F2OWYvdi9m?=
 =?utf-8?B?NmJTTWExZFdRVk1zdjZnV0pvTGZNa2lnaGFYVm8xMHBmb3JmTnF1L0VEbkhU?=
 =?utf-8?B?QjFaOWk0ZWNHdTA2NkRoOXdCUEtZMy9iT2VtQjRUM21Ya2dYcXh2RzA2U3hL?=
 =?utf-8?B?QktVajIwUkhhUFdOZnpZZU9uN3NUcit2RGZoTll2dUVNcFg5dmtYSVpDVFNF?=
 =?utf-8?B?d2EzOG9JZEQ3OWdFSFo5aUx0Y0R3YU1uTDdQQmg2QlZnVTk2WmJZa3JZMm9q?=
 =?utf-8?Q?DNLhr7sDKWVgOjVg76mc7be/shkVL0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MiszNXNiT1VpYWdHRUxxMDJweVlhbWxzaTZ0WEx4dE1zaHd0dUhQZGIwYUtX?=
 =?utf-8?B?WEFlR0tSQWpPVUJnZVBtd0xIZ3RWZjgySVFhSDgrQllPbTZqTEhNdFlRZWlz?=
 =?utf-8?B?WlVUeU9RQ0RsTm1ucUI2TWtCWWg3Q1BWZDZHVzhTalp1cHhtcXQra01OdEcy?=
 =?utf-8?B?L28zU3Y5SWdXTFVHQzZCdk4yZVJnWWlURFlOSTVGNFFHT3hXRFBQQi9BSUZa?=
 =?utf-8?B?VkFaaldza1o3Q2pTdmRiOGswL0lTS0J1RTBlTGlBUmdBU1dMejBHZjREYXRE?=
 =?utf-8?B?ditkalBmd1VreEJYS3IxQ3FVODA1ejRiRXVWNHBRMVcrb1FLQi9od2xKZHF6?=
 =?utf-8?B?bHIxcmg4RmFSeldtRnkzL2lyZ0xlUEJCZVVMSHJiYUsyMTh4ckRkRGg1b0VK?=
 =?utf-8?B?V3VsYXdvaGxoVldpWktjOU1BZUhJcEpNUG4vS2hHeXF4RlUvUE9rcTVDYnhD?=
 =?utf-8?B?WEtnRGk3cklUc0QrL3hrRGovcHdrZWw0ckQwL1BUOWgyZ0pidlNNSWdyRmtC?=
 =?utf-8?B?bHBmbWdiakI2RHhtcHdITXBxU1hKU1J1amg5cWFIYjhCNHF6d1dWUDFIVHJ2?=
 =?utf-8?B?YW1BdFd2R0x5MkUrQXhnb0VmSnRlYkJHbzVwUnR3b1FZN084ODZsV2pJci9T?=
 =?utf-8?B?bm1xRUNTek9TYVp2RXBwelJ5S094ZlEwZ0xaLzRrVVNzOUdvTkFZNzNlYnlD?=
 =?utf-8?B?d0YrYnZ2WlJDeHVjNDVNSWN2MXFBMXJNRDA0ZUhMYWNJN2s5L0dzTFhaNVVE?=
 =?utf-8?B?TXZpLzJtc0VYdUEyQ1VqYWNKajdKbjE5dXNaYTkvMElpejB0d29PeTlQbHZH?=
 =?utf-8?B?U3VET0pYa25ZTlAzOTFYS290ejRINEhYcmtFRlJnNnFRRlRQWmhQdzlhYTVy?=
 =?utf-8?B?MVZGOXI2UjNHeHJyNWdPVmozM3RYTnprV01QY0xWMm9uTWljMjI5NlY4R0Y2?=
 =?utf-8?B?cHJJTHUydjY3bnErOFdGWWJ2VWFaTmVTT0R5aENQQ1NaeG1vVEQ3TFQwdmlQ?=
 =?utf-8?B?M2c0Nk5KZEtPd1BpZDA2M0oyS3JnSno1cW84RW8zRVkzVEZxUzJ2eXNsSG92?=
 =?utf-8?B?TFBpb3NHdndnMGtmb01adXNuUytmeVZpMC9KT0ZQTzlvNVBUV3pnYXBpQ2NX?=
 =?utf-8?B?Z1FNLzRGRjc1Zk9Jem0yMWVnLzUyVGx4TTRUNlVJd1hROVJzRnh5UzhKcWhz?=
 =?utf-8?B?eHFXWk9rVGxiZ1YrKzNoMmpjMDJ6Y09OUXlyTGFaWUt1QnJCWElEakpObzls?=
 =?utf-8?B?c0o5UURqMHpwVmpwWG9VRTNienFFREFNTnZkQ1NxUDZ0WG02dUtWSGlFL2pG?=
 =?utf-8?B?QkJHWkoyVFBBQTJ6ckVqU3Q3MHlUbld2WlJRa0wra1dDMDlOSGd0cHNtZTIy?=
 =?utf-8?B?WVNjRFozZnhWTXE1UXBiOFl6Rk9LUGhBR1A4ZXorT0lnVzZLNllyampycVV2?=
 =?utf-8?B?eWpQNDFic0FDSFZOOEYvRUJNUkl5ZU1aTUlmKzNNUm5LVWpXVVlId3pXZzND?=
 =?utf-8?B?NFNXaUhqazI2MWk2ZnZHNDFXT1kxODJzVmp5K3J4elhXaFMxUnljT2h2U1NP?=
 =?utf-8?B?TjloWmZ6eHhJQXVWeDYxVmRXSWo0VDluNk5jbjQ3bWRNUkZzYmNqaEM4TVov?=
 =?utf-8?B?ck55ZUgwZk9GOHZ3VUtLRUxGaWZwZzc1UG4wMjBkc1FSTkJ0Y0RuS2RLZUpn?=
 =?utf-8?B?TVdRNVhwWkdyNDM5ZHFYUkYxUlRINDR4SzZhMUJBMkFFK3dmTHJVNUVZSnVT?=
 =?utf-8?B?S1dKeWczTEp5Q0Fvd1pGUHRJWU96L3h1M2NiU2dNNkJueE5ROE1WVDMzaTRC?=
 =?utf-8?B?eDZXSFZiL01tV0xaTVc0YmxRZGFpTlM0dmF6amlqL0VOMENoMDFudmxIaEkz?=
 =?utf-8?B?MUpBMDU2OXJ3NDh5bzFzZ3pKQks3KzgyVDMvR0JMOVY0TDgxK2tHT1R0N0xu?=
 =?utf-8?B?cFJFUlg0amV3OGs3SVpheEhxMmY1MTQyQ3dYUWg5bFhaTi9RRzliSEw5OGtq?=
 =?utf-8?B?L3E5K2pUMTFGQVo5SmVDR2pCK0F6SEZQZVVOL0ZhaTJ6NndzYmI1eHNGV0Nj?=
 =?utf-8?B?UHpIdmJzRkpoS1hMclZmNU9SemUzSklPQ2xZVCtaK2YxekFCOXkvQ28zQ25I?=
 =?utf-8?B?aVFmSXRuM2hlbTh3MnhXTmRIRTFjWjlURDRSd1RRUXNhbnlNYVdyam5OSVhM?=
 =?utf-8?Q?9rkcTnj1qDViH20zAIx1UbA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72f55f3-e707-4382-ebef-08ddd3238f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 06:53:03.5404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkG/zVF/ow1ajirV2XKZVcsm35DagL5od/HWtkIfP10mhBUB2wh9RVRqnvN8mpFjwt1q/VKF3FhseER/eUTgVx2a1iZLZ661wh6AKKl8BqkRUSS07H2tW8Hg3bqmWxJP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9423
X-OriginatorOrg: intel.com

DQo+IGQxZTg3OWVjNjAwZjliIE1pcmkgS29yZW5ibGl0IDIwMjUtMDItMTYgIDIwNzUNCj4gZDFl
ODc5ZWM2MDBmOWIgTWlyaSBLb3JlbmJsaXQgMjAyNS0wMi0xNiBAMjA3NiAgCWlmICghbWxkLQ0K
PiA+Zndfc3RhdHVzLmluX2h3X3Jlc3RhcnQgJiYgbWxkX3N0YSAmJg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eIFRoaXMgY29kZSBhc3N1bWVzDQo+IHRoYXQg
bWxkX3N0YSBjYW4gYmUgTlVMTA0KPiANCj4gZDFlODc5ZWM2MDBmOWIgTWlyaSBLb3JlbmJsaXQg
MjAyNS0wMi0xNiAgMjA3NyAgCSAgICBrZXktPmZsYWdzICYNCj4gSUVFRTgwMjExX0tFWV9GTEFH
X1BBSVJXSVNFICYmDQo+IGQxZTg3OWVjNjAwZjliIE1pcmkgS29yZW5ibGl0IDIwMjUtMDItMTYg
IDIwNzggIAkgICAgKGtleS0+Y2lwaGVyID09DQo+IFdMQU5fQ0lQSEVSX1NVSVRFX0NDTVAgfHwN
Cj4gZDFlODc5ZWM2MDBmOWIgTWlyaSBLb3JlbmJsaXQgMjAyNS0wMi0xNiAgMjA3OSAgCSAgICAg
a2V5LT5jaXBoZXIgPT0NCj4gV0xBTl9DSVBIRVJfU1VJVEVfR0NNUCB8fA0KPiBkMWU4NzllYzYw
MGY5YiBNaXJpIEtvcmVuYmxpdCAyMDI1LTAyLTE2ICAyMDgwICAJICAgICBrZXktPmNpcGhlciA9
PQ0KPiBXTEFOX0NJUEhFUl9TVUlURV9HQ01QXzI1NikpIHsNCj4gZDFlODc5ZWM2MDBmOWIgTWly
aSBLb3JlbmJsaXQgMjAyNS0wMi0xNiAgMjA4MSAgCQlyZXQgPQ0KPiBpd2xfbWxkX2FsbG9jX3B0
a19wbihtbGQsIG1sZF9zdGEsIGtleSwgJnB0a19wbik7DQo+IGQxZTg3OWVjNjAwZjliIE1pcmkg
S29yZW5ibGl0IDIwMjUtMDItMTYgIDIwODIgIAkJaWYgKHJldCkNCj4gZDFlODc5ZWM2MDBmOWIg
TWlyaSBLb3JlbmJsaXQgMjAyNS0wMi0xNiAgMjA4MyAgCQkJcmV0dXJuDQo+IHJldDsNCg0KUHRr
X3BuIGlzIG5vdCBOVUxMIG9ubHkgaWYgbWxkX3N0YSBpcyBub3QgTlVMTC4NCg0KPiBkMWU4Nzll
YzYwMGY5YiBNaXJpIEtvcmVuYmxpdCAyMDI1LTAyLTE2ICAyMDkyICAJCWlmIChwdGtfcG4pIHsN
Cj4gZDFlODc5ZWM2MDBmOWIgTWlyaSBLb3JlbmJsaXQgMjAyNS0wMi0xNiBAMjA5Mw0KPiAJUkNV
X0lOSVRfUE9JTlRFUihtbGRfc3RhLT5wdGtfcG5ba2V5aWR4XSwgTlVMTCk7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl5eXl5eIEJ1dCBoZXJlIGl0J3MNCj4gZGVyZWZl
cmVuY2VkIHdpdGhvdXQgY2hlY2tpbmcuDQo+IA0KDQpTbywgY2hlY2tpbmcgdGhpcyBpcyBsaWtl
IGNoZWNraW5nIG1sZF9zdGENCg0KTWlyaQ0K

