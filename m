Return-Path: <linux-kernel+bounces-785713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FCCB34FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16B11890961
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5173AC22;
	Tue, 26 Aug 2025 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6W2dGtK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21898460
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166981; cv=fail; b=n022uEZhwZdCLM6CznbVO7TfC++wmaSqYk40ViTft1ULH5ZzpUkr+G35nF9WCEsdAQbNwk4ZC1C3MH3cD94mYjZPU0YK+w/Ji8t551r8eR+hbE0nrg20S83ar9SoV7XDk4zpvVAfDXYonRkuX0RrDYdncgV2tbvQBdcTqmdKQZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166981; c=relaxed/simple;
	bh=vKkS0lqIUgtBLX+3mR2Nc8790AlqgWKtDp8ZZZVyb10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tQ9vIvokUsmWM8bAzigoBlP3/nQdERMQcOXzrQArY1llRi7t5HZmp3UcTvdCPGSYnaT6c5uKJRrzRTHRfNfiSvwSsJgH43MVY53S/Sh0Ay94zHUsyxEG5VRXP3MVDwqgyCY4jKlBG9EHnw7oTQKA4n7QkJ7NMtwVP/xxirwJjmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6W2dGtK; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756166980; x=1787702980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vKkS0lqIUgtBLX+3mR2Nc8790AlqgWKtDp8ZZZVyb10=;
  b=I6W2dGtKQPd4DFcCdvnobHrkEA7QYDBpPqrqHevmkpUvj2pm8hyMqNDx
   tfR7xFq5HnP5EmPxx+MsZ9T/KSFbm8Q8FFIcnnAZx2P1heBXhCrHW8XvY
   B9GTL/afy6FpNYynvY1weT0vw3JABgqjq+/wdMePp1sta+YSxUEJqbjcY
   K0GA5TTWdKYocYhODzjX+DrIsk7gnTNEHCUawBX6SV5TVIVDHzX2qeRO+
   UFXfnT0BM5K9GlGy9G2qUmsdkRA0PgSVR+E82Olqk6sejRG2bdjxA9+Pr
   ub48s7vCFephMAfsPV2y21l0q9nO+s4wZcuNgDMnv8ZPif3j0Llr2rKVV
   g==;
X-CSE-ConnectionGUID: 3zDmiufAQfWl6niWVACHuA==
X-CSE-MsgGUID: yy1gCHdcSjyfeIIvOSBiwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68660520"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68660520"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 17:09:40 -0700
X-CSE-ConnectionGUID: i2QACQEMSpCRea0m4D/NxQ==
X-CSE-MsgGUID: BhvmS3xCQ+KKIw+8Pj9F5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="206586715"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 17:09:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 17:09:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 17:09:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.84)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 17:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAit1Slw7kOE8HwPnXSoeuPe5nXwFTR+KMzYmNg5D8LRAs1DMbKPC0AC5CZ9/CHIyeV1Jss72cjFq2YOvcTwAGZa/TT6Old1ml78J3gvqpIIPdnreO4biYzsdfVSOoTbzw9jPbeSSgINMrfWoidz4rIvtJtYZBYA8wsgdFJ2S32WJUyP0Y7uDusHH8L7t4zHfvkS9Dwi/YS75Fml4fsBjagfr6Lv51WU2xpQa+VHOLeOMYUVQcnVOLMtcULgQb8Le4r4vGnj2sgQe93RigXD+H0WuaEnFxJ9zZRy/isqA8M3+ceeNvpFtuBxA7qiO3SiN3wcolp6uzFFAL13fGZ1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKkS0lqIUgtBLX+3mR2Nc8790AlqgWKtDp8ZZZVyb10=;
 b=nL3m0AONeUg6/CR29GRh9ebK70Rk75vjjYL2jYTjmtJbWXGMl83AmsqNqQxIWs8NEuqQNZgSKtabFuM0Adx5C1PoN9u33tHkwvdX7bYwbyc3nMzz0zrTQNkVNysOgKo5FqjIyufqT65YHWD6KEjFWJl2nE+g7W0ybc0an9bCWi9b1MjvInBLlz6XYvCTt1wnDR9J3rOwfsBkS6yK43XH6sQWe52vKqYOPrdjMK8kThfB7n3kWj/pJ0jEf8AJfFLxulkSgdpcP4xu1o0G004YJw6pCfXYFfPHflTh34CCRrNViMQc3t9Fgp1jRvhYqZyShL27F1e90bOgWdWnGUkS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6275.namprd11.prod.outlook.com (2603:10b6:a03:456::14)
 by DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Tue, 26 Aug
 2025 00:09:36 +0000
Received: from SJ1PR11MB6275.namprd11.prod.outlook.com
 ([fe80::ca54:f21d:695:9e42]) by SJ1PR11MB6275.namprd11.prod.outlook.com
 ([fe80::ca54:f21d:695:9e42%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 00:09:36 +0000
From: "Tham, Mun Yew" <mun.yew.tham@intel.com>
To: "Ang, Tien Sung  (Altera Corp)" <tien.sung.ang@altera.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ang Tien
 Sung" <tiensung.ang@altera.com>
Subject: RE: [PATCH] MAINTAINERS: Change mailbox-altera maintainer
Thread-Topic: [PATCH] MAINTAINERS: Change mailbox-altera maintainer
Thread-Index: AQHcFZuspyZI15hs6EiWbuVk4lM2CrR0DwRg
Date: Tue, 26 Aug 2025 00:09:36 +0000
Message-ID: <SJ1PR11MB6275641A3B2C63D61D8BC2A4C239A@SJ1PR11MB6275.namprd11.prod.outlook.com>
References: <20250825083643.43882-1-tien.sung.ang@altera.com>
In-Reply-To: <20250825083643.43882-1-tien.sung.ang@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6275:EE_|DM4PR11MB5328:EE_
x-ms-office365-filtering-correlation-id: 88a90ee4-4903-4bea-5320-08dde434d7d3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VFRtT1BWYWh3RE1vL3A0ZjV4Qi9SZGVsN1cvWE1RN25pVU1IY3Zlbmt1WW5y?=
 =?utf-8?B?R3J3ZnBvbTdkc2lZbjVoWWo4Y1JtUEZwN0t6Z3lyY3QwMXJrQWlpalRxUkZB?=
 =?utf-8?B?bzkyWm9lbEdhb1lFMGQrSjYvT2hqT3NINmQzS2dnc08xdzMxb0xWaXVXMklM?=
 =?utf-8?B?bGM5ZS9wYllmUjhDTzdPWDVsZUxWQStkQWdvYW1YaXZrNXorY0RCUXp5Rmxz?=
 =?utf-8?B?NndZaG10a1doT0ZYMTExa2k2cWtKL3FEYTlESmR5dGpDNWRIQXM4MUh3QWRs?=
 =?utf-8?B?QjBnZWFkV2FTdkE1YmlNYnFVRkdwM29XdWxua2lJVTFJdzVFQndhTDZzREV3?=
 =?utf-8?B?VjFvWHFEVDAxUWtBSzBZSWFjWUl2VzdQMmt1OWNremNLY2E2V1gvNFRoWTRu?=
 =?utf-8?B?VnI1MTBOZzM3Mk9DV3VBMU8wUEtFcUxqemR1WkZDL09xZHo5TVBrUThqOS9x?=
 =?utf-8?B?QnhSYXgwT1NlVG8rRjczVWVOczA1RWZUWWxWZkpnVUYwN3VUM3FPdWpJZXBj?=
 =?utf-8?B?T0lzRVZuZ1FTc2NGeGhxZE02SGUvQjZ5aTBLRERuTTdZaTNNbUhIamhSekhu?=
 =?utf-8?B?YTlFdGV3QnBXbnBENzh0aGtqU0hlOGJhSHZFVW5nMm5iaFNUV0Z1UUpZVzVB?=
 =?utf-8?B?TVUxc2tHRXRjRS9xWmI0ZGlxbU5CZ1A3bEZDVTlvR2oxQnNJUE9rT3orNjBC?=
 =?utf-8?B?ZzFyN2szbHNvd1hndVd2dG9keU8wK2pqcERudGdEVmhqZTFPQWplSmVmSGRa?=
 =?utf-8?B?SEZkMGJZZEJ0TlUrVnJPREZOd3RrS253S0E1MFcvOTFURkQ2SGRTMlc0bmMr?=
 =?utf-8?B?RmNEWmNiMm14OCtGZmNhNW9KNUQ4VmNIQkY3WTdmNzd4ZUVTdTlkbXlLTVlM?=
 =?utf-8?B?TkVnZzRIMkllZWZWeEx1OHZhUFFEVitaUHR4ZC96cXR1bjRPZTFsVURZNElD?=
 =?utf-8?B?cVFHU29BWFJ1SDhFN0RZdmQxSURIK2lGQnEzWis4Uk11ekkvUU5oSjYxb1Fu?=
 =?utf-8?B?RmZyQW5OM0hHbEdDVHpiaXh2ZjZWQm52WGc2Nkt0YTdwdVZCOEhDWUw4NVlW?=
 =?utf-8?B?cTdjRTZUTUs1VkI1dDhtdW8wekxpOVp4M0xpWnUrQjF6Vm5sb3VHR3lNSm1M?=
 =?utf-8?B?bzU2Z1FUR3E1TDlCWW9vYmRBcDJPTjJvTUlhdG9SNEpYSVo3UmFlQis5RVFS?=
 =?utf-8?B?RWx2dGQ2U0FpMnVUeWxodkFCNW04TWdUMmlHZ0dGQ3A4YUN2Z2x4cG9hY21w?=
 =?utf-8?B?NzVSc0NETUhpdkZFQVlrMXVhSEFFbTlNQ2lGTnpRLzBVQUtmcWRuL0UwZVZQ?=
 =?utf-8?B?Zm5KQlloTFlYME00Y3p5M044NFd0a2ZPaEI4NjBzQTdGMmRnWkw0TU1kbEx4?=
 =?utf-8?B?RjdKWDFGL2FyUVMvbklhcy9KOVM0WTZxekJHc2pxYy8rd2gyc3g0MytQQXJa?=
 =?utf-8?B?bS9VS1RjYmQzNHU2ZG51ZjdMMHp2ZmxSUTFkT3R6Ui8vbjdWcyt1c1BWcWFz?=
 =?utf-8?B?M0w0aEpOMEFZeTZJYktxMURRZzlHSitsbUtoVGVwL09JTDFqNjFNbGNKekNq?=
 =?utf-8?B?Q2VHZlk0M1EvTDZNbzRyK3hRME5GOElJSGRUTUYyTVlOWGtXNElvTFFldTQ0?=
 =?utf-8?B?K0pDRUU3OGdMZzRianVDTTZObzNNOC9Fa0ErU1c5clA2WGk3MkZZVGVaelRo?=
 =?utf-8?B?TUJkYXJWNk4yWWFtZFJseXJpQ0Q2bDcvN3p3VExwaUNSMzdEczhjanBEWWJS?=
 =?utf-8?B?R1pOQURDdExFcTI3ZlF0WWZKelU1OGJHVDk2NmxQSXpLcTF0U3lOL3RnQlQ0?=
 =?utf-8?B?UTRzY05YQWlSeFFBVkZ5cUxtSVJKdmNLR0tvVzlMeHBaM0pTTWRwWHFQRnhD?=
 =?utf-8?B?c0pQa2w3MEVjcVB0ZnRmWmlCSzd4eU1jZVNVTHZSakhYc3NtenlwTG1uNlRm?=
 =?utf-8?B?L2pjTDFYU1F2VTQxY2s4VXVPcElMVnlXaGZyaVFZS0MrcS8yTGNsSjdJTHJE?=
 =?utf-8?B?VUNtRXd2ZklBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6275.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzhTS2MwVHNQeWU1L0s0VG83T0czK2lNbjNKZzNWSjhndUtvaVMvc3ZiUEdu?=
 =?utf-8?B?aWNuSWd0UFAzeXBqanRWc29RZ1N5UzU1c3B2RXFpRkxoNitReEhISnBVSHBu?=
 =?utf-8?B?ZVVXMVI4S3Q1VExmVFFYdnk0elFJaVAzRDdxZ3dKR1hSWXhNQ1NyejRwaWtr?=
 =?utf-8?B?ZDN5V3pibk9TTHZhU2tsdnhXWHNsbnZJQW9ZbjV4SUdFeWVURHJTSFh4UUUv?=
 =?utf-8?B?MHFETXRLUFV4a1h3L1R2WHB6N0pyTmU1eUxzVFJKUythQ0djVDh6OUI5T0Uw?=
 =?utf-8?B?cW5PTW1idkdKaTJtQlZRWC9HMCtMV0dQWmUwSmdiYWRLSmk0TjQ3SFNTV2s0?=
 =?utf-8?B?RmZWSWVoYzNINTI0VytlSU90NFlEOVRudlN5NUxhMDJJK1JZV3d6WVhvRnRQ?=
 =?utf-8?B?d0xrZkdOdUVSMUNpbW5nSTVESUVKczhZQWdSd2RuMlk4cFBvSUFyOE9vWmkx?=
 =?utf-8?B?cFp3MU5ieXZlbXJZNUVaMXpRbUFMbXc2UjhsUFRueXFpMzRmVURtTkk5dHk4?=
 =?utf-8?B?TE5ZOGllcUhzTlFvUWtCRGdDQkFnSXZlQ21TYUNjM0VGTWRYYlBTOGR1elpR?=
 =?utf-8?B?ZXZreDcrOGg0QVNXc3FIVytSeW9uV0pYMk9VQW5UekVUc2pTeWJjNnZSaG42?=
 =?utf-8?B?V1JIb2ZpWEgwZTc1ZUJzWVI4TlN6Sm8yLzZyUnNrUjRVYmN4UDIrZ0FJam8w?=
 =?utf-8?B?eHJCUWhOTS9SdDBCVEdjWjhsSEFBcCtGT3ZkWFFMcy8vZXR2emJ5Rm1jcjBr?=
 =?utf-8?B?bktPRUh3ek9ubTl3S1pTbEVhRUh3YU9GRDN3K0MxQlVGSUhCbGt4TVdROGlw?=
 =?utf-8?B?MnZ4Tk1iN2Nhd1RiZHc1OGVRaXduNURlNk1MMUxxOU5jTGs4Um8yZnhvOXNt?=
 =?utf-8?B?SHdlQ1RqTjl2UndWOXdzVlQwZDNKci9wZHBkam1HeTVoUmIrVWc3QW1kYlU0?=
 =?utf-8?B?cWs0b2JUN3IrWFZHRkdxakRKR2ZlUGU1ekxqeFlHSXR4ejA0b1hPaHA3a1Vq?=
 =?utf-8?B?aFhVSTRXQ0ZOWFlsdC9ETlhhZlhWbU9xa3lyZEhuNVI4ZERHWXo2cEF6eUxr?=
 =?utf-8?B?NStFRm5wRS9Jc1lTa0pzYjhRL2tUMlJUMlBHTkhVZHUrOHVuRHkxbUtBanRL?=
 =?utf-8?B?bkNBbFRNM1VVRE92WkczQlVIektpZnVrVlRVbC8rRGJpYk5jTG5TK2VScnVW?=
 =?utf-8?B?SFNDTFY2UGpKazNnVFNkRVVlL2ozZFB0Q2x2TmFGdVI1ckNpdUZ1MGYyaU9W?=
 =?utf-8?B?Y1hEeTZJMThGcS9lclFiWWtSWmprZjkrMHNNMlpJak9raW1xT1FrTXRZSndr?=
 =?utf-8?B?QTJ5Y1VPM0tSa1JDeFR5WUl6RU4yKzVSSlNwWXN0czR3MjJQRGNOc2NhWUQ0?=
 =?utf-8?B?Q0R3L0RxZHl1bTIyZXZNOUg3aDB4d2IxTzBTUzBCbkVhc0VFZ2dsNUdHNVhO?=
 =?utf-8?B?NnlEMXZibEs5dGpQdnVSSWc3Y0QrTWtpT1RlZ01nRFlTWnh1S0JZY2wvOVMx?=
 =?utf-8?B?NUtTK2R6NVpON05DQ3JhMVg0QVBDdmJlOWNnSnJrMkxqMVNnZ05iOXptZ2tT?=
 =?utf-8?B?S3RJTGJlNCszWkVXTW5pbFJJd05hNUR2NU1pdnQ4SkU3elVSWW9Cb3ZhaS9I?=
 =?utf-8?B?Sk1BdCsxWTRqb2s0bkV1SUdIUWJiOHRCZWd5NTlCcFE4TzBTd1pVSWpuR2F0?=
 =?utf-8?B?QnRUWGdxWjdjM2VTN1Q0NDBJNEVvK2owcGp3cGwrUDlLR0xjamthcjNZVXh4?=
 =?utf-8?B?elBuSXVwdzhuRnUvUXJ1SEtyazVxZXFtTDl2c3Z4QitFNzZ5S2cwYVlWTllZ?=
 =?utf-8?B?QlpkblJ2SXViU0FkSklWWjV4VG1RRmFodFBGYk5UNWRzNkJTdnExRVJiMmIz?=
 =?utf-8?B?VzZ0R1IrSjJSWlZvVG4wdUxRb1ErZXVpYzF2N0VTTEpsZzNHa2FVR1FPdzVu?=
 =?utf-8?B?OVZGTC9KVWtyNGxTYTE2Wjc2ZC9oelBBRlI1OGNkSjR4Ukpyb1hLNmQzQS9r?=
 =?utf-8?B?MFJVWDFWMWRCY1dMK0wvZlB0LzVJSWZhTHIyUlJEYWZ0S0tseTFka0xWTVdG?=
 =?utf-8?B?ZEM2RHRwaS9XcUFmbmRaRVl2QU40SkgzNkNzb1lDdUlVL1YvbXdZVVhRdXdI?=
 =?utf-8?B?bVQxTHdNN3JoRXROaGZ4SlNTcXVrVjJ1T2tRTUozQXovU1hpTVpJTnNlU2xm?=
 =?utf-8?Q?2nCG8HYx9Gl8IlORXJCO2l8Kt6HPsonnq5h1DQ2FJB8L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6275.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a90ee4-4903-4bea-5320-08dde434d7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 00:09:36.6216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/yqgz6UFyGsg8UA43BT5ESx1Q93f/0w1j5vboguFyDoZepsnFOBzg0OjPUpK1CKDZ5fp6sEHToeMeBSajHEhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com

DQo+IFN1YmplY3Q6IFtQQVRDSF0gTUFJTlRBSU5FUlM6IENoYW5nZSBtYWlsYm94LWFsdGVyYSBt
YWludGFpbmVyDQo+IA0KPiBGcm9tOiBBbmcgVGllbiBTdW5nIDx0aWVuc3VuZy5hbmdAYWx0ZXJh
LmNvbT4NCj4gDQo+IFVwZGF0ZSB0aGUgbWFpbGJveC1hbHRlcnMgbWFpbnRhaW5lciBmcm9tIDxt
dW4ueWV3LnRoYW1AaW50ZWwuY29tPiB0bw0KPiA8dGllbnN1bmcuYW5nQGFsdGVyYS5jb20+IGFz
IFRoYW0gbXVuIHlldyBpcyBubyBsb25nZXIgd2l0aCBBbHRlcmEuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBBbmcgVGllbiBTdW5nIDx0aWVuc3VuZy5hbmdAYWx0ZXJhLmNvbT4NCg0KQWNrZWQtYnk6
IE11biBZZXcgVGhhbSA8bXVuLnlldy50aGFtQGludGVsLmNvbT4NCg==

