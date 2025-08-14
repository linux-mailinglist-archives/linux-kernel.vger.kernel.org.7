Return-Path: <linux-kernel+bounces-769345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D98B26D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0665C203B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4571C5499;
	Thu, 14 Aug 2025 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGbRVUNe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1F1E4BE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191023; cv=fail; b=O8ZftPOIawl86mC3ieqBC2wyfE5Cd9WbkWPIAYLT9998d+MHxJ5WG+whbb4VzI4PTSmTRCnNF3mo9tLWptwN6wJ2/M2taZ/N9H6RU2PWbjiIFVKj74TcrPaZD3eE6AG+OWrJAskP4J0fklYyo5HgzTilkRljr2PUquUTkRMy3iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191023; c=relaxed/simple;
	bh=Qdb6WnFx47F9Zgo3LSyjNKdDCDrtZwpdwwZdA0IDddo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H0K1QPhHGci46tBZ/EoK9+lRjkJCYh4o8JMXHhzpWpAwE0iOo1Y5xTmHFsT7k7mM85Lwj1+qZRwP3j292HhHuEOPYcig4EIbaliGNLggbNeiOSWBIptdFNz+rO/q8W2Wurp+ZBSUCRWEWVVvsLnJTyZRkFQyz85Xi1kTzvfFYos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGbRVUNe; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755191022; x=1786727022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qdb6WnFx47F9Zgo3LSyjNKdDCDrtZwpdwwZdA0IDddo=;
  b=oGbRVUNeK6JnN2CnbAwbk5HacxsqUUnD1brrsK6qyH/QYX8JbjRK7KOe
   H8AkJsA9Uu5mYsJ4pdQZD6AFyEvZTLHMnha9ZluFXpBS/fRTQ69g7JvsS
   S9EBwLXUuxckwPo9Cc6ZZG4+2ribSbSBUtPCImXjB2S8c4ec7OpsGNk6A
   pWvZhaC16B0YG8Dg7PHylqoAGjIsuRNXxyn4n7bGhY62u3ATZRucYoYwk
   EXS3iyF0PyQo8w9twXFGXFjc/e7fjw8apjRM1W+3HHHQ00ox8aXaQu4Q3
   N+vs45EGihkntYVu3nojj/CDRwsIfffJ17N4iMsWVhIR1DeGpNczz20Oc
   A==;
X-CSE-ConnectionGUID: /y/Q2QX6RZGxu5KxDlLN9A==
X-CSE-MsgGUID: duds4otCSBSSYgmHo+GhzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57467063"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57467063"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 10:03:41 -0700
X-CSE-ConnectionGUID: 2sL26mDwRL2RKCyNOiBDSg==
X-CSE-MsgGUID: xzTITQq7RZCxi3kl4TDlww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166718248"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 10:03:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 10:03:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 10:03:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.46)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 10:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwxIdhstR6BWQt5zHmDzzuBVe2fD8FighnTFuEx/FLlCfH29gB95Pyw7b48FzUkjevJsORLFLZy7CZwlaGfPPq2hsVLThMGSKwbx3iyws35jnZJwCwVwIJbug3bxyyKrOd2y0dQwXKo0PuWP+92gIKCa4fDhJU2xUmez4BRoulJfEnM0yXhw31ER+yAE1gLw6ezOdofB1VEeJbG0GyrkNdid5iYKR59dbgYL3L0qUMa+YjQCsQ99eNQllLyNqs7P7B+SwcLZ71lzCd0YdWFPg0oaRxFpNHNwaCpWdpdVB8+QSk4KMC3BTCcqQpdTU2hY/OmchRjbJZP+1G4xR0mrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qdb6WnFx47F9Zgo3LSyjNKdDCDrtZwpdwwZdA0IDddo=;
 b=dKMFc3l2LAFwqecgb/CC8ctsWUFp/0z6jpN5mBZ2+0FvoXoPm9dRLUAC3XWnG2dCjj4RDX2aYJVSO7mmxM8W29tGFNzMNrapTnP+m0wxUw/UHrBbf8fKj8Aa9rQ+DxznJz1BMrp1WCpQl7SuvFHvEsJL2LDzbyFPjKRr5OXs8zGPM5iS7mBsrEMZXTSOK0yOe7gCo6Wn5LCsDb6RlMyyWwidxB3XYMET5vYgu7HNMg2UhBCo5VzKYTy9KeVxMHWuGmUv3fjkXj698WMF4ytpoUIAqFX8Xo7FHAuxjup3dmpcqReegEu8oCu0uF+deSDP8xNPARdfs/eKkqqIMupq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM3PPF17031675B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f09) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Thu, 14 Aug
 2025 17:03:37 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 17:03:36 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "mingo@kernel.org" <mingo@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"oleg@redhat.com" <oleg@redhat.com>
CC: "broonie@kernel.org" <broonie@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Thread-Topic: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Thread-Index: AQHcDQSAsgd3KMgRVUK3LV4xePzdnLRiYLSA
Date: Thu, 14 Aug 2025 17:03:36 +0000
Message-ID: <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
References: <20250814101435.GA17362@redhat.com>
In-Reply-To: <20250814101435.GA17362@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM3PPF17031675B:EE_
x-ms-office365-filtering-correlation-id: f02abb8d-cece-41e0-a60c-08dddb548240
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?d3lWUW10a3pUczRLRDdKeXNGTmFEVkF5MzBJdFhCcTd0K1lBOHR1d0s3Zmpt?=
 =?utf-8?B?NFZSTnkxcFhkb25JVVgwRGFKK3cwUWVOTlNWUDNiMGZ1RU5CakpKb2VmN2dP?=
 =?utf-8?B?L2VzWnVvL01ybGh3bWRUV2hEZVhlVXY4SDJPRy83c3hZZVdSTjZMMmdJMlVE?=
 =?utf-8?B?MkVsQ0ViUTNHcDNXNUFKZ09LeTVSTUJwWjF4cFozL25LTFBRd2NDZkdNQkQv?=
 =?utf-8?B?WlBxTzNObUJ5K2l3V1VxTW1MZmhTbEpUZmZxRWNLVFpYZTBNakFMa0UwSUlQ?=
 =?utf-8?B?bldoeEg5QzI1aWpMZTFBdHAvbHRoUGRuWjVJeDA5ODZYWkRPNEJnTUpOcDhD?=
 =?utf-8?B?cDVjQndRS1BIN1NGc0gxOENUZloxdjVBckVPMmhNeEVKWmU4dFVJS0FFZ0R6?=
 =?utf-8?B?RDhiVnB2V29zbXdxOTE2SVJqYUl3c2pQV1FnMU81TUlUeHlDZE9iR1o1bGFu?=
 =?utf-8?B?bktwN0hNZkhuSDU4VzhJWnFnWHQ1aUNFb1BxQkdxelhkNCtHWlUyK2VDVUJ1?=
 =?utf-8?B?UGx5N2ZPM202OHM4cGh6cjY0WjZtdWx2UU4vN2tqQ2dtYlVyWGZlQW5zTngr?=
 =?utf-8?B?eFdtWFhRTEZlcEdUblI4MDJhTXBXVmRrSmlrMEZKSnR0ellVcjdjS2xGc0lP?=
 =?utf-8?B?QTdPcXkyN1RITG91ZlFMNzBSeFI5OGR3WnAzWXo4Y0QvUDZlWEcrU1NuRzZL?=
 =?utf-8?B?QVBEeldQVmJaRklPTUJTamtsNkUvSjZKKzY4b2JUQWloTFVkTmZleXZNZEhr?=
 =?utf-8?B?K29QWlkxMmR1RG1kdUxuWU04MFlKemJSQ04xWDhkeEk1WnAxQWFuRGIrK3FD?=
 =?utf-8?B?b3R6RHFoK1BRcHUzMkxIekJUOEIvQjhWV0VtQ0krcDRSckN4RStpNWM1OFNK?=
 =?utf-8?B?bWdTUi9KUTBBeENET2h2SkhwSXFJaFZZV09GMStNRUhFcUlaTVhFaXk3b2tu?=
 =?utf-8?B?WmZrQVA0ZTUzbXVhK1k5eHRMeEhPMGlCamtqQ0ZVeEhaRnZKOUVwMk1tZnNs?=
 =?utf-8?B?NXc5SThUb0w2UEl5WDlhc1hnTU9mZ255TUhTMjRFUThURUgrVVI3VmtmQ3VY?=
 =?utf-8?B?MWJ5c0JNQmdwZ0pkWU55dnpVdWhMSkd1Q3JiZ1BtTXF2ZTFaWllVOE1WUU14?=
 =?utf-8?B?d3daVkZYTTdwTmNUdExIU0RjYm04RmtTdEp4bmdLWWpiMFJud2lKUk1hSi91?=
 =?utf-8?B?c1dXYWVkaUdVOGVTdnNDd2NpT0dwV3NWNmVjNVpmOXhIU2g0OHYrYThRQnd1?=
 =?utf-8?B?OXk4TkNMNGxDM1U4Smw0TGF5V1Jpalora2FyL09FSmxDVU9UWXRJRng5N21X?=
 =?utf-8?B?d1hPcUxTUklpL2FNV2Vkb1RXRkV5Ui9kTkFqMXFadEI4cVJRUi9iV1Nlai9L?=
 =?utf-8?B?OFRZY1lWV1Fha0thVGpnb0FFb1Q2anE4eWRDM0IzTmJNTnpsYUZMdWZEWnZI?=
 =?utf-8?B?ZERzRE9zYk44L3dFTzVvRVpSdUVsNzZ1cmZhM1NocDR1M2ZIcGx4QVVuOWxH?=
 =?utf-8?B?RXA0d0ZicUg0Z09idG53RVpBb0lwQVF6MEpqNVlKbGxXWTQ5RGVjWmJYVXRh?=
 =?utf-8?B?REJvSCtvQkIrUVJtSVRCRWR4a1F2bVExU2tSVFlJdWc0SkgrVTUxaUMrcWJ1?=
 =?utf-8?B?Y3EzQWRML0dZVGZiVE51WjcxZTJKY2VUc2xDQU1heFhseE4vcW9BREtKZnZS?=
 =?utf-8?B?QTZndytsQ0dVNkllTVRuVDlIeWx4KzQ4WkF3Z2hIM3ZpTHJnVlhTTHFzSUMw?=
 =?utf-8?B?dnovOWh5QzlwL3k3U2JLSWtKOW1ESk84OHA0WnRDbm1zQ3dBcjRWcm42R0F6?=
 =?utf-8?B?NmNHSCs1R1g2YXRTUDFSRGR4aU9OZGJIMFR0aWJpQTdudHB5aTJwRmdSTyto?=
 =?utf-8?B?R0FsTE96MWpINmIvZmsvODYvTU42RGYvZWpsVE1WaG5qaVhQU0UyUW9ZTElo?=
 =?utf-8?B?OEpxQmt4OFZORDhPb3BIc1BidmEvMnRjOU1YVTBrMzBIdjE0TEtFWENObWRj?=
 =?utf-8?Q?Os7qh/JjTOKa4X9UTYEfqOwtLSfEds=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bC8zMkdGRjVFME5TTyt5U2lKeSsrSGg3eVRNRTZhVE0rTk02Y1kzakVhbE9B?=
 =?utf-8?B?amlDUnJ2NXJLSmRMMVpIbjg3MDRxNktrVWJDNnhMblprWHVnbzkvWFNDWWx6?=
 =?utf-8?B?bFZVVVdYVGtrY1FYbFJNRFNEV01jUlUwYS9sV3JrT0JEUmpnV1pPa2h1NENj?=
 =?utf-8?B?NnJWeVZkT2dDT3k1YUNwSlAxanhQQ3crRFhqUWU4MUdYdWUyOGlBeDRjR3VI?=
 =?utf-8?B?L0hadExYVXhlWW5TMkdibnFUczc4Wi93QnJaTlFhKy9yNG5TQkJ1MHQ1U3Ra?=
 =?utf-8?B?MTRrbU9yMWpneW12dzZHY3greUV0QUhnVlFybDdMYnJtQnFRVG9qVHNrMTZR?=
 =?utf-8?B?MXJWSTJ1TnpNTDZQNk9hQ0cySGw2cnd1R0k2ajE1ZXJRWUF0V01kdU0wdjA1?=
 =?utf-8?B?TUxCL2tKL0Q3aXh3c0J6SkZaWTVxYnl4d0paRVpZNWVpQmpMcWpuckhwRUdi?=
 =?utf-8?B?RUd1Mkc5TDlWc2ZOdzE3TFdqRHhvWFdCTnFNWHY0R0xYOStUS2drd1JyWk5C?=
 =?utf-8?B?ZXpqdEg2NlQxZVpXdVdtc2JFdEVNZWhOM01xeUVRUmFxZkZNR0lrVjU1Z2ky?=
 =?utf-8?B?UjlHdjFuaUlxWjdTc1gvYk9rSlZubjlpU1E2UlVnL2lLcHhORituZTNyV0NI?=
 =?utf-8?B?Uko5UnUwN214RCtOd2huNEE3bldreHlCWjNOT1NDTnY2Lzc2SFVZNnJmZW1y?=
 =?utf-8?B?cEYxKzZwTGNRQXlKcWUxcCtjM2ZzWW5XOWhjVlBiNDJ1ZUhHZDFoS3U1MHhP?=
 =?utf-8?B?L0FDV2prbUdZYVd0WElrZ2tvZzBQWFJsRTJtdTIvRXorSm5HVEMzUXdEMCsv?=
 =?utf-8?B?MXNwcDdEV1laczRFM2lPbjFXaFdjNWpKeldpSDRYNTVQRHk2dFZoV09JM1BZ?=
 =?utf-8?B?Zk9vN0cybTdKZW1kT3VhTDI1akxCdFFGdjRpV1hqK3drclFkL0RHQjdDUXhB?=
 =?utf-8?B?NFZvcFVSblJyVjA1cFgwYVBXM3BIR0lFY0lDaWJDOGdBT2x6d3FzZ0F1RTJI?=
 =?utf-8?B?c2M2RURpM0lodVgwRGtuVlBwMTB3NkNyMmt1SXN4TFl1c1VDRFNmY3MvU0tM?=
 =?utf-8?B?alZyUzZKd3dpLzNkOUx1R3NQeHk4K09BQjZGNzVlekxTcCt3T2VDa1V0SzhL?=
 =?utf-8?B?OHJpWkg4Nmp1UEUyc1B5WTVWVnJ0ZlUwWm8wYlZwYWJUMmNKU3hZcDM0d24v?=
 =?utf-8?B?UUp1emxEcVY1dkVqdkNmRFJuV1hiNFhFQWwwNnNxOEkrSmg0d05UQzFNNU9q?=
 =?utf-8?B?a3pLcE1tM29kTjFSMlM4Z1hPZW9ZMnY2VWpJdFlZR3EyMDhwVThNZnYvNVBt?=
 =?utf-8?B?OXRWWUlhTVNhZ2JpUjBDM2lDL0JMWUdtaTBUN0wycWlrSytzSHdjZi9nMndD?=
 =?utf-8?B?V3JhNkdpei9lZlNsOEFuOSt0RWpYZEZXdjJpTHozbWJsTGJHYjdjQWl1WjdD?=
 =?utf-8?B?NjJFSWVRRXJCZW0wdmhWVkU2aFVwKzNGak9yUmRIeDR0UlNTNWdMQkZOeXNt?=
 =?utf-8?B?OTMrR1lnRE5pRGI1a1p6ZHFUd1FuU1NyTmRNZzZrOTFPUGFFWmkvR2RmQmtW?=
 =?utf-8?B?TkZuSGVuZThYUnRwUnQzdTgwSXlNbnV5RXphYTVDWDZsQzR0RWxZSitiYjBn?=
 =?utf-8?B?Vkc3Mm9VaEVnYjJTdExIdzl2YVNCamN2NEVyakVQb0tSc3N5NmFZZm9sT0x1?=
 =?utf-8?B?WkRSSUhwM05Jb2hOVGY5N3BidS9RaFQrWHVPQnVrWDlDcUZzaURWSjVqOXI0?=
 =?utf-8?B?UWE5TUN1UURFYkVKbTlpN1JTNkd0VnhvNVBhZHUvcU8ySFZ5VEdGWUVIUHZn?=
 =?utf-8?B?bitzbk51VXR1VFN2eGZzZm9pcEpGRXRHOUh3S2ZvYTduSWpqYnh3VVV0dk9j?=
 =?utf-8?B?Q0ZOQmtZMklDQ01Za2pMMVN5YmRvWUd6djUwSnZqa09NQ1hVV0dpbVd1RzhO?=
 =?utf-8?B?RTRNYzhHelp2V1g3dmVuQzNISmFQVEZKUi9wUUVFbUFrR25DN21xTUJ4YnBD?=
 =?utf-8?B?N2xXVFZCT1NUbHNjWjQwa2MrWDcvaEtlT2FwdGlEaFZOWVpKZVREN1M5NER2?=
 =?utf-8?B?bjdpNFBTayt1NllTZk5Ma1R4SnR6dWI0Y3VrZmo3Rm1ITExuRDFQRld1Z1JU?=
 =?utf-8?B?eG5wNjRlQTdrYS81d0xaNE93akM0bmx6Z0syVDJvbjFrNVVwa2xxbmozbFJS?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9DE2DA270D9564389255045939078A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02abb8d-cece-41e0-a60c-08dddb548240
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 17:03:36.5224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dp8z/4T9DyOYqgY7NSJBUP72iCF0FM1j1pBtmeoPM/RqzZ/mcedf4rmL03i/lWHp2iLg4TuuhH3LV4vO4u/R1gqKr5WNZbJTEUJdOxrDCs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF17031675B
X-OriginatorOrg: intel.com

K01hcmsgYW5kIERlZXBhaw0KDQpPbiBUaHUsIDIwMjUtMDgtMTQgYXQgMTI6MTQgKzAyMDAsIE9s
ZWcgTmVzdGVyb3Ygd3JvdGU6DQo+IElmIGEgZmVhdHVyZXNfZW5hYmxlZChBUkNIX1NIU1RLX1NI
U1RLKSB1c2Vyc3BhY2UgdGhyZWFkIGNyZWF0ZXMgYQ0KPiBQRl9VU0VSX1dPUktFUiB0aHJlYWQs
IHNoc3RrX2FsbG9jX3RocmVhZF9zdGFjaygpIGFsbG9jYXRlcyB0aGUgc2hhZG93DQo+IHN0YWNr
IGZvciBubyByZWFzb24sIHRoZSBuZXcgKGtlcm5lbCkgdGhyZWFkIHdpbGwgbmV2ZXIgcmV0dXJu
IHRvIHVzZXJtb2RlLg0KPiANCj4gUGx1cyB0aGUgY3VycmVudCBjb2RlIGRvZXNuJ3QgZXZlbiBs
b29rIGNvcnJlY3QsIGluIHRoaXMgY2FzZSBmcHVfY2xvbmUoKQ0KPiB3b24ndCBjYWxsIHVwZGF0
ZV9mcHVfc2hzdGsoKS4NCg0KVGhlIGFjdHVhbCBTU1AgcmVnaXN0ZXIgZ2V0cyBzZXQgd2hlbiBy
ZXR1cm5pbmcgdG8gdXNlcnNwYWNlLCBpdCB3aWxsIGdldCB0aGlzDQpmcm9tIE1TUl9JQTMyX1BM
M19TU1AsIHdoaWNoIGlzIHJlc3RvcmVkIGZyb20gdGhlIHhzYXZlIGJ1ZmZlci4gV2hhdCBJIGFt
IHNlZWluZw0KaXMgdGhhdCBmcHVfY2xvbmUoKSBjbGVhcnMgb3V0IHRoZSBidWZmZXIgaW4gdGhl
ICdtaW5pbWFsJyBjYXNlLiBTbyB0aGUgeHN0YXRlDQpjb3B5IG9mIHRoZSBTU1Agc2hvdWxkIGFs
cmVhZHkgYmUgemVybyBhbmQgdGhlIHByb2JsZW0gaXMganVzdCB0aGF0IGEgc2hhZG93DQpzdGFj
ayBnZXRzIGFsbG9jYXRlZCB3aGVuIG9uZSBkb2Vzbid0IG5lZWQgdG8gYmUuDQoNCkkgYWdyZWUg
d2UgZG9uJ3QgbmVlZCB0byBhbGxvY2F0ZSBhIHNoYWRvdyBzdGFjayBpbiB0aGlzIGNhc2UsIGJ1
dCBJJ20gbm90IHN1cmUNCml0IGlzIHJpZ2h0IHRvIGZ1bGx5IGRpc2FibGUgc2hhZG93IHN0YWNr
IGluIHRocmVhZC5mZWF0dXJlcy4gRmlyc3Qgb2YgYWxsLA0KZGlzYWJsaW5nIGl0IGZyb20gc2hz
dGtfYWxsb2NfdGhyZWFkX3N0YWNrKCkgc2VlbXMgd2VpcmQuIEl0IGp1c3QgaGFuZGxlcw0KYWxs
b2NhdGluZyBzaGFkb3cgc3RhY2tzLg0KDQpCdXQgYWxzbyBpdCBzZWVtcyB0aGUgcmVxdWlyZW1l
bnRzIGFyZSB2ZXJ5IHNpbWlsYXIgdG8gdGhlIHZmb3JrIGNhc2Ugd2hlcmUgd2UNCmRvbid0IGFs
bG9jYXRlIGEgc2hhZG93IHN0YWNrLiBJZiB3ZSBpbXBsZW1lbnQgaXQgc2ltaWxhcmx5IHdlIGNh
biBoYXZlIGxlc3MNCnNwZWNpYWwgY2FzZXMuDQoNCkxhc3RseSwgaXQgZG9lc24ndCBzZWVtIHRo
ZXJlIGlzIGFueSB3YXkgdG8gY2xvbmUgZnJvbSBJTyB1cmluZyB0b2RheSwgYnV0IHRoZXJlDQp3
ZXJlIHByb3Bvc2Fscy4gVGhlIGdlbmVyYWwgaWRlYSBmcm9tIHRoZSBzZWN1cml0eSBQT1YgaXMg
dGhhdCBjb3BpZWQgdGhyZWFkcw0Kd2lsbCBrZWVwIHNoYWRvdyBzdGFjayBlbmFibGVkLiBTbyBp
dCBzZWVtcyB0byBmaXQgYmV0dGVyIHdpdGggdGhlIGNvbmNlcHRzDQppbnZvbHZlZCB0byBub3Qg
Y2xlYXIgdGhlIHRocmVhZC5mZWF0dXJlcy4NCg0KSG93IGFib3V0IGp1c3QgYWRkaW5nIHRoZSAn
bWluaW1hbCcgY29uZGl0aW9uIHRvOg0KCWlmIChjbG9uZV9mbGFncyAmIENMT05FX1ZGT1JLKSB7
DQoJCXNoc3RrLT5iYXNlID0gMDsNCgkJc2hzdGstPnNpemUgPSAwOw0KCQlyZXR1cm4gMDsNCgl9
DQouLi50aGVuIHVwZGF0ZSBhbGwgdGhlIGNvbW1lbnRzIHdoZXJlIHZmb3JrIGlzIGNhbGxlZCBv
dXQgYXMgdGhlIG9ubHkgY2FzZSB0aGF0DQpkb2VzIHRoaXM/DQoNCj4gDQo+IEFkZCB0aGUgbmV3
ICJib29sIG1pbmltYWwgPSAhIWFyZ3MtPmZuIiBhcmd1bWVudCAod2hpY2ggbWF0Y2hlcyB0aGF0
IG9mDQo+IGZwdV9jbG9uZSgpKSB0byBzaHN0a19hbGxvY190aHJlYWRfc3RhY2soKSBhbmQgY2hh
bmdlIGl0IHRvIGRvDQo+IHJlc2V0X3RocmVhZF9mZWF0dXJlcyh0c2spIGlmICJtaW5pbWFsIiBp
cyB0cnVlLg0KPiANCj4gV2l0aCB0aGlzIHBhdGNoIHNzcF9nZXQoKSAtPiBzc3BfYWN0aXZlKHRh
cmdldCkgc2hvdWxkIG5ldmVyIHJldHVybiB0cnVlDQo+IGlmIHRhcmdldC0+ZmxhZ3MgJiBQRl9V
U0VSX1dPUktFUi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWcgTmVzdGVyb3YgPG9sZWdAcmVk
aGF0LmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaHN0ay5oIHwgIDQgKyst
LQ0KPiAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYyAgICB8ICAyICstDQo+ICBhcmNoL3g4Ni9r
ZXJuZWwvc2hzdGsuYyAgICAgIHwgMTEgKysrKysrKysrKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9zaHN0ay5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc2hzdGsuaA0K
PiBpbmRleCA5MmQ0NDljYzM1MmEuLmRmYjJhZWViYzI1ZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vc2hzdGsuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaHN0
ay5oDQo+IEBAIC0xNyw3ICsxNyw3IEBAIHN0cnVjdCB0aHJlYWRfc2hzdGsgew0KPiAgbG9uZyBz
aHN0a19wcmN0bChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIGludCBvcHRpb24sIHVuc2lnbmVk
IGxvbmcgYXJnMik7DQo+ICB2b2lkIHJlc2V0X3RocmVhZF9mZWF0dXJlcyhzdHJ1Y3QgdGFza19z
dHJ1Y3QgKnRhc2spOw0KPiAgdW5zaWduZWQgbG9uZyBzaHN0a19hbGxvY190aHJlYWRfc3RhY2so
c3RydWN0IHRhc2tfc3RydWN0ICpwLCB1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLA0KPiAtCQkJ
CSAgICAgICB1bnNpZ25lZCBsb25nIHN0YWNrX3NpemUpOw0KPiArCQkJCSAgICAgICBib29sIG1p
bmltYWwsIHVuc2lnbmVkIGxvbmcgc3RhY2tfc2l6ZSk7DQo+ICB2b2lkIHNoc3RrX2ZyZWUoc3Ry
dWN0IHRhc2tfc3RydWN0ICpwKTsNCj4gIGludCBzZXR1cF9zaWduYWxfc2hhZG93X3N0YWNrKHN0
cnVjdCBrc2lnbmFsICprc2lnKTsNCj4gIGludCByZXN0b3JlX3NpZ25hbF9zaGFkb3dfc3RhY2so
dm9pZCk7DQo+IEBAIC0yOCw3ICsyOCw3IEBAIHN0YXRpYyBpbmxpbmUgbG9uZyBzaHN0a19wcmN0
bChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIGludCBvcHRpb24sDQo+ICAJCQkgICAgICAgdW5z
aWduZWQgbG9uZyBhcmcyKSB7IHJldHVybiAtRUlOVkFMOyB9DQo+ICBzdGF0aWMgaW5saW5lIHZv
aWQgcmVzZXRfdGhyZWFkX2ZlYXR1cmVzKHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaykge30NCj4g
IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBzaHN0a19hbGxvY190aHJlYWRfc3RhY2soc3Ry
dWN0IHRhc2tfc3RydWN0ICpwLA0KPiAtCQkJCQkJICAgICB1bnNpZ25lZCBsb25nIGNsb25lX2Zs
YWdzLA0KPiArCQkJCQkJICAgICB1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLCBib29sIG1pbmlt
YWwsDQo+ICAJCQkJCQkgICAgIHVuc2lnbmVkIGxvbmcgc3RhY2tfc2l6ZSkgeyByZXR1cm4gMDsg
fQ0KPiAgc3RhdGljIGlubGluZSB2b2lkIHNoc3RrX2ZyZWUoc3RydWN0IHRhc2tfc3RydWN0ICpw
KSB7fQ0KPiAgc3RhdGljIGlubGluZSBpbnQgc2V0dXBfc2lnbmFsX3NoYWRvd19zdGFjayhzdHJ1
Y3Qga3NpZ25hbCAqa3NpZykgeyByZXR1cm4gMDsgfQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCj4gaW5kZXggMWI3
OTYwY2Y2ZWIwLi5lOTMyZTBlNTM5NzIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9w
cm9jZXNzLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYw0KPiBAQCAtMjA5LDcg
KzIwOSw3IEBAIGludCBjb3B5X3RocmVhZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGNvbnN0IHN0
cnVjdCBrZXJuZWxfY2xvbmVfYXJncyAqYXJncykNCj4gIAkgKiBpcyBkaXNhYmxlZCwgbmV3X3Nz
cCB3aWxsIHJlbWFpbiAwLCBhbmQgZnB1X2Nsb25lKCkgd2lsbCBrbm93IG5vdCB0bw0KPiAgCSAq
IHVwZGF0ZSBpdC4NCj4gIAkgKi8NCj4gLQluZXdfc3NwID0gc2hzdGtfYWxsb2NfdGhyZWFkX3N0
YWNrKHAsIGNsb25lX2ZsYWdzLCBhcmdzLT5zdGFja19zaXplKTsNCj4gKwluZXdfc3NwID0gc2hz
dGtfYWxsb2NfdGhyZWFkX3N0YWNrKHAsIGNsb25lX2ZsYWdzLCBhcmdzLT5mbiwgYXJncy0+c3Rh
Y2tfc2l6ZSk7DQo+ICAJaWYgKElTX0VSUl9WQUxVRShuZXdfc3NwKSkNCj4gIAkJcmV0dXJuIFBU
Ul9FUlIoKHZvaWQgKiluZXdfc3NwKTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2Vy
bmVsL3Noc3RrLmMgYi9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYw0KPiBpbmRleCBlNmQzYjEzNzFi
MTEuLjNkYTIyYzZmNTg3NCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3Noc3RrLmMN
Cj4gKysrIGIvYXJjaC94ODYva2VybmVsL3Noc3RrLmMNCj4gQEAgLTE5MiwxMSArMTkyLDIwIEBA
IHZvaWQgcmVzZXRfdGhyZWFkX2ZlYXR1cmVzKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKQ0KPiAg
fQ0KPiAgDQo+ICB1bnNpZ25lZCBsb25nIHNoc3RrX2FsbG9jX3RocmVhZF9zdGFjayhzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnRzaywgdW5zaWduZWQgbG9uZyBjbG9uZV9mbGFncywNCj4gLQkJCQkgICAg
ICAgdW5zaWduZWQgbG9uZyBzdGFja19zaXplKQ0KPiArCQkJCSAgICAgICBib29sIG1pbmltYWws
IHVuc2lnbmVkIGxvbmcgc3RhY2tfc2l6ZSkNCj4gIHsNCj4gIAlzdHJ1Y3QgdGhyZWFkX3Noc3Rr
ICpzaHN0ayA9ICZ0c2stPnRocmVhZC5zaHN0azsNCj4gIAl1bnNpZ25lZCBsb25nIGFkZHIsIHNp
emU7DQo+ICANCj4gKwkvKg0KPiArCSAqIEtlcm5lbCB0aHJlYWRzIGNsb25lZCBmcm9tIHVzZXJz
cGFjZSB0aHJlYWQgbmV2ZXIgcmV0dXJuIHRvDQo+ICsJICogdXNlcm1vZGUuDQo+ICsJICovDQo+
ICsJaWYgKG1pbmltYWwpIHsNCj4gKwkJcmVzZXRfdGhyZWFkX2ZlYXR1cmVzKHRzayk7DQo+ICsJ
CXJldHVybiAwOw0KPiArCX0NCj4gKw0KPiAgCS8qDQo+ICAJICogSWYgc2hhZG93IHN0YWNrIGlz
IG5vdCBlbmFibGVkIG9uIHRoZSBuZXcgdGhyZWFkLCBza2lwIGFueQ0KPiAgCSAqIHN3aXRjaCB0
byBhIG5ldyBzaGFkb3cgc3RhY2suDQoNCg==

