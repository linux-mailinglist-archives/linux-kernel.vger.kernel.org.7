Return-Path: <linux-kernel+bounces-682342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4587AD5EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 21:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6A017DFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3A728851A;
	Wed, 11 Jun 2025 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzvmJsc1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A20526E6EC;
	Wed, 11 Jun 2025 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668412; cv=fail; b=qW/7jTiOlKjArM1qEtT/e5wn8bbXyrvyyK1IyW/K4ogN4vVhVQZ4R3atir4uVXRtAIUQVz0fTxq3jLXPbbAlsAZmovw/BpcCeyWwcGCvAE6JH/gZfo2gkGP27/LoiAvOXxPqaD4eoqZGUSZ+2laoZ7pQ2bACV9m4xoNnX1LVEcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668412; c=relaxed/simple;
	bh=XLvhVR0G8830riNEvKP8/3MA0bQBUBOBdp1GZ3xNics=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B9QJgiUWL46J/OwsqKi/GPJsA1ZpHgq9PVGqNHGBC3T0KS0IIWPfRdmkJ7WI3HnlAhCBG2qy6wd291b9HURC+3AEqoInZlzIsZ0RrYGWKUneUFeqjptPaYOvJHsufjkaQ5uxDV3ltVW2Pa069CfG9hPgSYVVHnor9ecCeYi5V2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzvmJsc1; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749668410; x=1781204410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XLvhVR0G8830riNEvKP8/3MA0bQBUBOBdp1GZ3xNics=;
  b=JzvmJsc1zf3i2gcWW18m6UsjnhLY82b7h0prvU8YK5QpKC9YE1wOb/VQ
   4y/GDmFdFA+587OFQ4PYq6EtRfmFkjMaJqy15Cv8KVhQX0QSLOdJZRK0i
   lw7iCFHPoQepxvWRUUn34sysWkHONeqJSSee2mV7HwSfCk38CcATIhZsH
   uY211eDcWdn1kV0wPBSghiaRZYJ8i04tOaalo25eSOO3+GriE6s088bT+
   cJ1zHoBMJEGGL6+jQpQOw7rV34GxloS0NjNdoerlzWR4oE0EvyypQk7vG
   MM1iBpIDnTc8nBk70fDtV0wDV/bFNRGtUW6XuXbtA+R0gNhM5JXFJsTc9
   A==;
X-CSE-ConnectionGUID: S7qNtg8hTYao2a7YcdWNIg==
X-CSE-MsgGUID: NwiSTsnuTniJDwB1C1URrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62437376"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="62437376"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:00:09 -0700
X-CSE-ConnectionGUID: 5NEJXZwRS6myxoFk7MwyWg==
X-CSE-MsgGUID: cO7oIuVeRg6MthZDL6qp4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="170449290"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:00:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 12:00:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 12:00:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.80) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 12:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyweoTLQUwUl50SXF2ptgLu/aEy6Qe4whWFvejdHu+XX3+IFdTQ0YlXuDEW93/Tzs8B9QTu4mj7N2jAPEfzqIZ6NkfG908dGt12Nx3w6BzA8MzcRa2P5jANoS80QM4mAU2N//JQ3OpFaMqnwSTL18C3vOtNiFPEoSBcPwoxHmoPH0RiXbZytppErcH088pqtHIJ8QnhhCngIlWP5LmcabXsgcTNhfSvETjRIV24TQyBIok8FX4+VNkl6PauV4vgU1uPJtQU3yMcNdAWl+mDYC+ceQQJl7gQ6cELhs6gP+wAb+yxKryjApmdCytstUrwPSpZAUVDBc6NzDGo1IM4qJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLvhVR0G8830riNEvKP8/3MA0bQBUBOBdp1GZ3xNics=;
 b=GvwijtBgjLDM+JLItRDOa8O1Us0Io6s41xOI0xrmkHioNjww/tqJt2rVE+dl836B1m/t6dS/ZjVCEBqIzsr0uZVW5rmEcoSZRnmkTohZ/XI/y4swaT8yLXIq+zCi25e5n7sgmfdBtEUNozrkkBvWKb5Z/BMJGhhfATDvXyEunZOJfcytOjMXx/z84n5qSn5V8G+wE/+Shh/AxqDk04i8GtxQ3+XT59pPPY4Y+3bvqLAQsMlzeLIlBQeM9k9vhRuACBsdvw9IBTv/JuriM/TImnFKz0zernlTvf2qeNFsEjtiOEMJcKaIJofGwsmoB+6gHxZNDdpvIBqjv8FbwLm6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SJ0PR11MB4878.namprd11.prod.outlook.com (2603:10b6:a03:2d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.33; Wed, 11 Jun
 2025 19:00:04 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 19:00:04 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "acme@kernel.org" <acme@kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "irogers@google.com"
	<irogers@google.com>
Subject: Re: [PATCH 2/2 v3] perf top: populate PMU capabilities data in
 perf_env
Thread-Topic: [PATCH 2/2 v3] perf top: populate PMU capabilities data in
 perf_env
Thread-Index: AQHbxF1Wi390zgPnOkKJ8kPrSTjDorP7LGwAgAHWZACAAXqIgA==
Date: Wed, 11 Jun 2025 19:00:04 +0000
Message-ID: <6445eecf1767aa7e4a64af2feed48075ac101a1c.camel@intel.com>
References: <20250513231813.13846-1-thomas.falcon@intel.com>
	 <20250513231813.13846-2-thomas.falcon@intel.com>
	 <a327dc2e5837a743a08403b5ad58dbe5e8c4f926.camel@intel.com>
	 <aEiUqtB9Zg9ZBQO6@x1>
In-Reply-To: <aEiUqtB9Zg9ZBQO6@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SJ0PR11MB4878:EE_
x-ms-office365-filtering-correlation-id: d84eb8c1-9e33-4013-8b2d-08dda91a2ce3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bzdRbUQvMTQ5a1dxN2dKd0JMTU9PTno3WDFwOGlNVHM2c2Z5R0V3NDNMVWwr?=
 =?utf-8?B?cUZsZmxibTdxNGpzdllrNE5jeE00aFpQS3FIT3RkMkFLZmsrSk9aOXpOVlc2?=
 =?utf-8?B?V05qbHA3bEo5ZExYK2FwbGVxVjB0TnkwVkJmQ2pLdklDdlRBVjdjWis3U0Jy?=
 =?utf-8?B?WUwzdDE3K1lqQ2V0bmpoNkNsckFLb1hYell1UnhFaERVYURESFMwVnBJR1NY?=
 =?utf-8?B?cFpsYnRVVlQxUDFGT1B2d3Urc3k5ckxtOHkxOVBxcFZWa0lMOTc0SHJ5Z0ow?=
 =?utf-8?B?L1ZHVEdVdHdBQU1yczM1c1h5eU1yalZ5N25JajNKa0pweHFGOE8zdm9aVERE?=
 =?utf-8?B?TGxyNGRFaTZlS09iOGhzeDBLYXhMWTV0Z2NFSXgyQVl0cHdrSUFERVdseW5E?=
 =?utf-8?B?clFTN1lKRUhtbFRhQUFicFo0WU42azB5OE8zbEgrWjdYQ1pkZDRyYVRTSzYr?=
 =?utf-8?B?ZTFiRnFRanZ2cy9CUm9SL0hUS2hEYlVVYitHOXlHd05Ydm1kQk9HRjY1dDRG?=
 =?utf-8?B?bzZPWmI3S1VXSVJRUUtZbEltVXhxb003OWVsUXc3KzJVNmZHbzJiZkZBbjVp?=
 =?utf-8?B?bnN5Sk8ydVZGdFM5UzcyNmlSNERvQzhPMGxTbWZMWU1ybzM4L3NnSjkzTlR5?=
 =?utf-8?B?NGREcmhJcVRTRW9wMmlhcVdYNTd4dndhRytzd09yUUZTNVl0a3JVVXppTDVI?=
 =?utf-8?B?UTJtTUdNazdmdnBSQXY4enpKaGt2bUtKQWtrakRPWm1sT2dvaHBra3VzR3M1?=
 =?utf-8?B?dGROUko2RVZDaVJBcTQwQXN0VmdvOW5jYW9DdG9DL3RpaFlMRlhpOXN4Z0p3?=
 =?utf-8?B?Q0RGRzZKVWZ5M3ZWTE5GaE43ZUlqdGpHcFFJY2lMZ1RVdC9seS9xUU1qQ1Zu?=
 =?utf-8?B?TGJKVE9oSGtLdGRXT05iN0xHOERsZGdKMkNoN0x5bWIxbEFmdFJnenFyam1T?=
 =?utf-8?B?RkhtMFloREpDT2ZTQkdYMXd2YTFFRWtuWEEvdFVLODQzNEJKSXpja2tmZkRn?=
 =?utf-8?B?QzJxZCs3VDNxbnVITlk2ZzRSUWFaLzhxcHcxaDFoa0hmVHo3SjlSMkRnWjZs?=
 =?utf-8?B?NStoSkNlK0QrZ0R3QjB4UXExM0NBUXVrMVJVdHhRaHNGWTE3bDhtMnpRellY?=
 =?utf-8?B?WGtOVFJseG5qdW5WeEhhYituUE82YStzdUFyS0d2eWhKRTUzR3ppd0loRzgz?=
 =?utf-8?B?SC9Vb01od0htaWszK3hLd3dsMFVnaVZ4MHNsOUtBS2ZWdWVJVXk0L0xmWXI4?=
 =?utf-8?B?dkJUVjBMT1FWd0MxeS96dE5Tc2tZTjc2NklQa0RrejBHZUxpYXBsRGc1RWo4?=
 =?utf-8?B?aktDNEF0ajc1WWw1NytsR3BTMjdNdURYMU1IOXlMYUVBWEVFU3c1TlMxemxY?=
 =?utf-8?B?TytqVlJTMEtTRWJXVzZ4SmxITUJrL1NSY2EzM2t3OWs0MXJzMzRRR2oyQzcx?=
 =?utf-8?B?Um05TUhxK0d3a3RwcFlhWGtDekt4WThuUUdYZFRTQlMvbVIrUE53T2N1QW5D?=
 =?utf-8?B?blljN1phdnduQzlrS0RHUCt4SEZZVzkrVXA3VlFpQ2lJSHhnY2ZtUlpzZW9B?=
 =?utf-8?B?YmZ4dGdHemIyWG9UKzBheXpMVitJOVBRbitnR1l1SXNIVDFKTmVoa0EzOW9z?=
 =?utf-8?B?WnNhV3c2eWFtNmp2dVhWdUpyK3pwYzFMeWp1YklxRFkwQWtTbWc4V21LY0J4?=
 =?utf-8?B?bllOUVNWbGhTcmIyUEtPYlpBdDJSbEVHdldoY24wb1ZHOXJZTkRkYjNINjZE?=
 =?utf-8?B?ak9jSnNRUHBLcGVEV0tGZkVRRXh0Y3o4NUY1SzdOUHZZaGNLbmpYREpaNmJn?=
 =?utf-8?B?V3A2QXZYZG9FRjBZVFNScjk4WTh2cFpaaFdkV2k3OVlJQkxGeVZnK2xsbmZ4?=
 =?utf-8?B?KzFNNXdMdktDcWViSHBLYk0veXBuVG1HSlVnb2RML2lzaURSMVVicmNwTGRI?=
 =?utf-8?Q?KkiEL9cNSYKkjQHAdEG9agAszlbEJrKP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mlptd3diVDYvR3VjWUxXN3ZJN053T2ZCRUc2STE2SVZEK1hrWVNOM0VxZWZ5?=
 =?utf-8?B?cVA4dmQ2MGR5dHRleitPQmhsOXV2bGF6c0hLKzNuRUttVk00WEZtNWpmSm91?=
 =?utf-8?B?b0J0b3Flazl5b3BWaktDM0JYa2hTd0xBbXlrdjZqdlY5UWFXNjdROEQrTk4z?=
 =?utf-8?B?blE3TXBuK0FyakJnak1nYUVheDRrampCWS9QM3UxM0xqaWo0UWNqanVQNGVz?=
 =?utf-8?B?WmFTK0sxOTlsTjZBUFl0N1UzcUVpSTdnbXdlQlFBblBPN1JxTVlSdmFzeVJ5?=
 =?utf-8?B?NEU3K1MrcEc4WGtXYWI3YTBuSktOenc3N01qUms3ZTRxakxDa3VocjZlbnBJ?=
 =?utf-8?B?OEEvd3NCSnUrL1M0MGhjcmRHTU44T284SE5va2dMUTg4N0RSQzNtelFHajBN?=
 =?utf-8?B?b1NNUzJsMFYwT3F1Tk8xUVZWb0ZHclNuY1hXS053ZUR1MXRIMnE5SmRocHFY?=
 =?utf-8?B?bFlxcjlhR0FaWnliVDlRYVVtZ29zdG1za1M3OTBwZVhkN1BQMXRVOW9BUnlK?=
 =?utf-8?B?VTVGSkkzWXJQNVdYY1p3YTUrNU9KQUMwNWJTRWZiRkh3ZUZuZGNCTTF6dXlP?=
 =?utf-8?B?NmV2V2FjMXRlWU1IQ05hOVo1MTZ2S2ZpMEFITm9idTYzRkh5dlBHZ2NYVDBu?=
 =?utf-8?B?SXNjeDZBbG5MN2hPLzErZmUweDJBaTVra0JobFlsdWIyYi9XSkxxSTdWMmFI?=
 =?utf-8?B?eVdPNnpDb2xQRFYremVOd3htNU1wLzBKU0ZEQ0VIeEI4eHYrU2EvOFd1NWNJ?=
 =?utf-8?B?MWdTUDMxd0tWdWljY2JVQ084NzVFMWw3bFVjZ05QS0RzWnZIazFvem9QT2hk?=
 =?utf-8?B?ZFFWamhDSFZWcHpRYy9EUThhTko5dm9NOE1Ic0tuMXV5TEdRTHZ1MUhJbHlp?=
 =?utf-8?B?K1RqNDdMME9YZUFuVzlTQWxwN3B4OU9HVTEzRXdRWGN4alpHdWJKcHJhR0wr?=
 =?utf-8?B?SzNSQlNXVTFqajgybmF6NjlzdmN2SGFnM1JsRGZDOHBHdDhFSWZHYXVSN1or?=
 =?utf-8?B?Z0EwbFVOMHlMcWVVdzlLU0F2ZzFqcHhaWXlkaWgrWTh6ZERxWmtXZnM0S3h6?=
 =?utf-8?B?eHRFSjBRbFVBaVJnN2xIQVRQNXBKWk1NY2NiUUU0TGlsQVkxalRjNDhzeCs5?=
 =?utf-8?B?a1BqRTBBUzMzOUxxVzBUQWN5aEpqbTR2cnFONngzczRTNWRmc0FqTmxnTTc2?=
 =?utf-8?B?SE5RRlNkVS92ZjA4aU9rTUR1NEVuWjBnSUtCR1VOOXdqUWl0SlRIS2dSRkNv?=
 =?utf-8?B?N1lYZTZhS0xhN0hSaUUyaS9zRkNsS0dUanNOWm85TjF6WDJ3dFZ4MTlOOEdW?=
 =?utf-8?B?M0Q5TUl0V0g4Z3hXZU9wTXNaMjJqWlEwL3lrOU5hd3hCbVlPQjN0RHQ3ZUlZ?=
 =?utf-8?B?R3IrdmtyQ1Z2VkdHaFFCZ2F0dUF4WW1SOFJldGxGbzB4NE9VQWs5RmlsVnd3?=
 =?utf-8?B?ZDlGeTdzWkF1amlNNXpsSXEvcmZFTlA5bUdFb3JrWVRnckd5UnhITEZaZkx2?=
 =?utf-8?B?aHFZUUhPVFRyM0tLeDJyY1VLaE5DZFVkQnYrSFZEckkvK0orc0xwbnRFdjF6?=
 =?utf-8?B?amlEaG8vRFJ6RmViWEQ1UlpGN3QxOWRRNEJqLzkzMjAxU21xWG12a0J2WUxn?=
 =?utf-8?B?YUNSREZIVTA1dHBaOXRFT0k2TjMrWWg1WGlEaVdncVFRd2IxNVpPdzRzYkFP?=
 =?utf-8?B?eWo1dVArUWNUR1llUmdmU1VvWENlRHNtSGhUOUthZDY5eG1DVDJQNkcxRDAv?=
 =?utf-8?B?MzVvZDlDM09maWF2Z2VCM2UxZVd0cGpRMWlYMTBLb2sxaFVaL1VzUThnTEdQ?=
 =?utf-8?B?d0pxZytjR0hnVnowbnBsaDdXREhxOHpoTUVOU1drVEc3d25XK0tNVnNSaFph?=
 =?utf-8?B?ZVFuYU5GUUM4Mk92b01QYWFJekFLZS9Ja0xuY1lyb21FMGUwL3NGeWJYNlVC?=
 =?utf-8?B?L3l0RGNPeUhWVUV0MGlnNTJPZW1ZaU5VY3psbU54TmhiQ3VPZjl0eWNkT0Mx?=
 =?utf-8?B?UFRibUlGUkpwc01ZSndPbVoyOEhvT3V4c1VlNkM3U0RtNnZUb1BoWmxjQnpX?=
 =?utf-8?B?NXY1SmcxVE92a3EwTkF4U21vdllwUS9BMCsxaHBYSm5zSzJKU2dueUFyV2RY?=
 =?utf-8?B?ZUdDS0Npb1dRT3FoejdXVlVHVUhwKzljSHJIZ1dzQjliM0hwRHNlcFFqTXlG?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F54768C2BDAE144EA769C2A76ECCB9E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84eb8c1-9e33-4013-8b2d-08dda91a2ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 19:00:04.3291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dh4zKFF5tVzn4fvvUyy+B/p4Tea/CYl6WiOK/ip5KpsMtTfcyqiWQvBIgp/6JA7/VGQqLIu8CE+Q40lBhYamzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4878
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA2LTEwIGF0IDE3OjI1IC0wMzAwLCBBcm5hbGRvIENhcnZhbGhvIGRlIE1l
bG8gd3JvdGU6DQo+IE9uIE1vbiwgSnVuIDA5LCAyMDI1IGF0IDA0OjIxOjM5UE0gKzAwMDAsIEZh
bGNvbiwgVGhvbWFzIHdyb3RlOg0KPiA+IFBpbmc/DQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFRv
bQ0KPiA+IA0KPiA+IE9uIFR1ZSwgMjAyNS0wNS0xMyBhdCAxODoxOCAtMDUwMCwgVGhvbWFzIEZh
bGNvbiB3cm90ZToNCj4gPiA+IENhbGxpbmcgcGVyZiB0b3Agd2l0aCBicmFuY2ggZmlsdGVycyBl
bmFibGVkIG9uIEludGVsIENQVSdzDQo+ID4gPiB3aXRoIGJyYW5jaCBjb3VudGVycyBsb2dnaW5n
IChBLksuQSBMQlIgZXZlbnQgbG9nZ2luZyBbMV0pIHN1cHBvcnQNCj4gPiA+IHJlc3VsdHMgaW4g
YSBzZWdmYXVsdC4NCj4gPiA+IA0KPiA+ID4gVGhyZWFkIDI3ICJwZXJmIiByZWNlaXZlZCBzaWdu
YWwgU0lHU0VHViwgU2VnbWVudGF0aW9uIGZhdWx0Lg0KPiA+ID4gW1N3aXRjaGluZyB0byBUaHJl
YWQgMHg3ZmZmYWZmZjc2YzAgKExXUCA5NDkwMDMpXQ0KPiA+ID4gcGVyZl9lbnZfX2ZpbmRfYnJf
Y250cl9pbmZvIChlbnY9MHhmNjZkYzAgPHBlcmZfZW52PiwgbnI9MHgwLCB3aWR0aD0weDdmZmZh
ZmZmNjJjMCkgYXQgdXRpbC9lbnYuYzo2NTMNCj4gPiA+IDY1MwkJCSp3aWR0aCA9IGVudi0+Y3B1
X3BtdV9jYXBzID8gZW52LT5icl9jbnRyX3dpZHRoIDoNCj4gPiA+IChnZGIpIGJ0DQo+ID4gPiAg
IzAgIHBlcmZfZW52X19maW5kX2JyX2NudHJfaW5mbyAoZW52PTB4ZjY2ZGMwIDxwZXJmX2Vudj4s
IG5yPTB4MCwgd2lkdGg9MHg3ZmZmYWZmZjYyYzApIGF0IHV0aWwvZW52LmM6NjUzDQo+ID4gPiAg
IzEgIDB4MDAwMDAwMDAwMDViMTU5OSBpbiBzeW1ib2xfX2FjY291bnRfYnJfY250ciAoYnJhbmNo
PTB4N2ZmZmNjM2RiNTgwLCBldnNlbD0weGZlYTJkMCwgb2Zmc2V0PTEyLCBicl9jbnRyPTgpIGF0
IHV0aWwvYW5ub3RhdGUuYzozNDUNCj4gPiA+ICAjMiAgMHgwMDAwMDAwMDAwNWIxN2ZiIGluIHN5
bWJvbF9fYWNjb3VudF9jeWNsZXMgKGFkZHI9NTY1ODE3Miwgc3RhcnQ9NTY1ODE2MCwgc3ltPTB4
N2ZmZmNjMGVlNDIwLCBjeWNsZXM9NTM5LCBldnNlbD0weGZlYTJkMCwgYnJfY250cj04KSBhdCB1
dGlsL2Fubm90YXRlLmM6Mzg5DQo+ID4gPiAgIzMgIDB4MDAwMDAwMDAwMDViMTk3NiBpbiBhZGRy
X21hcF9zeW1ib2xfX2FjY291bnRfY3ljbGVzIChhbXM9MHg3ZmZmY2Q3YjAxZDAsIHN0YXJ0PTB4
N2ZmZmNkN2IwMmIwLCBjeWNsZXM9NTM5LCBldnNlbD0weGZlYTJkMCwgYnJfY250cj04KSBhdCB1
dGlsL2Fubm90YXRlLmM6NDIyDQo+ID4gPiAgIzQgIDB4MDAwMDAwMDAwMDY4ZDU3ZiBpbiBoaXN0
X19hY2NvdW50X2N5Y2xlcyAoYnM9MHgxMTBkMjg4LCBhbD0weDdmZmZhZmZmNjU0MCwgc2FtcGxl
PTB4N2ZmZmFmZmY2NzYwLCBub25hbnlfYnJhbmNoX21vZGU9ZmFsc2UsIHRvdGFsX2N5Y2xlcz0w
eDAsIGV2c2VsPTB4ZmVhMmQwKSBhdCB1dGlsL2hpc3QuYzoyODUwDQo+ID4gPiAgIzUgIDB4MDAw
MDAwMDAwMDQ0NjIxNiBpbiBoaXN0X2l0ZXJfX3RvcF9jYWxsYmFjayAoaXRlcj0weDdmZmZhZmZm
NjU5MCwgYWw9MHg3ZmZmYWZmZjY1NDAsIHNpbmdsZT10cnVlLCBhcmc9MHg3ZmZmZmZmZjllMDAp
IGF0IGJ1aWx0aW4tdG9wLmM6NzM3DQo+ID4gPiAgIzYgIDB4MDAwMDAwMDAwMDY4OTc4NyBpbiBo
aXN0X2VudHJ5X2l0ZXJfX2FkZCAoaXRlcj0weDdmZmZhZmZmNjU5MCwgYWw9MHg3ZmZmYWZmZjY1
NDAsIG1heF9zdGFja19kZXB0aD0xMjcsIGFyZz0weDdmZmZmZmZmOWUwMCkgYXQgdXRpbC9oaXN0
LmM6MTM1OQ0KPiA+ID4gICM3ICAweDAwMDAwMDAwMDA0NDY3MTAgaW4gcGVyZl9ldmVudF9fcHJv
Y2Vzc19zYW1wbGUgKHRvb2w9MHg3ZmZmZmZmZjllMDAsIGV2ZW50PTB4MTEwZDI1MCwgZXZzZWw9
MHhmZWEyZDAsIHNhbXBsZT0weDdmZmZhZmZmNjc2MCwgbWFjaGluZT0weDEwOGM5NjgpIGF0IGJ1
aWx0aW4tdG9wLmM6ODQ1DQo+ID4gPiAgIzggIDB4MDAwMDAwMDAwMDQ0NzczNSBpbiBkZWxpdmVy
X2V2ZW50IChxZT0weDdmZmZmZmZmYTEyMCwgcWV2ZW50PTB4MTBmYzIwMCkgYXQgYnVpbHRpbi10
b3AuYzoxMjExDQo+ID4gPiAgIzkgIDB4MDAwMDAwMDAwMDY0Y2NhZSBpbiBkb19mbHVzaCAob2U9
MHg3ZmZmZmZmZmExMjAsIHNob3dfcHJvZ3Jlc3M9ZmFsc2UpIGF0IHV0aWwvb3JkZXJlZC1ldmVu
dHMuYzoyNDUNCj4gPiA+ICAjMTAgMHgwMDAwMDAwMDAwNjRkMDA1IGluIF9fb3JkZXJlZF9ldmVu
dHNfX2ZsdXNoIChvZT0weDdmZmZmZmZmYTEyMCwgaG93PU9FX0ZMVVNIX19UT1AsIHRpbWVzdGFt
cD0wKSBhdCB1dGlsL29yZGVyZWQtZXZlbnRzLmM6MzI0DQo+ID4gPiAgIzExIDB4MDAwMDAwMDAw
MDY0ZDBlZiBpbiBvcmRlcmVkX2V2ZW50c19fZmx1c2ggKG9lPTB4N2ZmZmZmZmZhMTIwLCBob3c9
T0VfRkxVU0hfX1RPUCkgYXQgdXRpbC9vcmRlcmVkLWV2ZW50cy5jOjM0Mg0KPiA+ID4gICMxMiAw
eDAwMDAwMDAwMDA0NDcyYTkgaW4gcHJvY2Vzc190aHJlYWQgKGFyZz0weDdmZmZmZmZmOWUwMCkg
YXQgYnVpbHRpbi10b3AuYzoxMTIwDQo+ID4gPiAgIzEzIDB4MDAwMDdmZmZmNmU3ZGJhOCBpbiBz
dGFydF90aHJlYWQgKGFyZz08b3B0aW1pemVkIG91dD4pIGF0IHB0aHJlYWRfY3JlYXRlLmM6NDQ4
DQo+ID4gPiAgIzE0IDB4MDAwMDdmZmZmNmYwMWI4YyBpbiBfX0dJX19fY2xvbmUzICgpIGF0IC4u
L3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4Nl82NC9jbG9uZTMuUzo3OA0KPiA+ID4gDQo+ID4g
PiBUaGUgY2F1c2UgaXMgdGhhdCBwZXJmX2Vudl9fZmluZF9icl9jbnRyX2luZm8gdHJpZXMgdG8g
YWNjZXNzIGENCj4gPiA+IG51bGwgcG9pbnRlciBwbXVfY2FwcyBpbiB0aGUgcGVyZl9lbnYgc3Ry
dWN0LiBBIHNpbWlsYXIgaXNzdWUgZXhpc3RzDQo+ID4gPiBmb3IgaG9tb2dlbmVvdXMgY29yZSBz
eXN0ZW1zIHdoaWNoIHVzZSB0aGUgY3B1X3BtdV9jYXBzIHN0cnVjdHVyZS4NCj4gPiA+IA0KPiA+
ID4gRml4IHRoaXMgYnkgcG9wdWxhdGluZyBjcHVfcG11X2NhcHMgYW5kIHBtdV9jYXBzIHN0cnVj
dHVyZXMgd2l0aA0KPiA+ID4gdmFsdWVzIGZyb20gc3lzZnMgd2hlbiBjYWxsaW5nIHBlcmYgdG9w
IHdpdGggYnJhbmNoIHN0YWNrIHNhbXBsaW5nDQo+ID4gPiBlbmFibGVkLg0KPiA+ID4gDQo+ID4g
PiBbMV0sIExCUiBldmVudCBsb2dnaW5nIGludHJvZHVjZWQgaGVyZToNCj4gPiA+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTAyNTIwMTYyNi4zMDAwMjI4LTUta2FuLmxpYW5nQGxp
bnV4LmludGVsLmNvbS8NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIEZhbGNv
biA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IHYzOiBjb25zdGlm
eSBzdHJ1Y3QgcGVyZl9wbXUgKnBtdSBpbiBfX3BlcmZfZW52X19yZWFkX2NvcmVfcG11X2NhcHMo
KQ0KPiA+ID4gICAgIHVzZSBwZXJmX3BtdXNfX2ZpbmRfY29yZV9wbXUoKSBpbnN0ZWFkIG9mIHBl
cmZfcG11c19fc2Nhbl9jb3JlKE5VTEwpDQo+ID4gPiANCj4gPiA+IHYyOiB1cGRhdGUgY29tbWl0
IG1lc3NhZ2Ugd2l0aCBtb3JlIG1lYW5pbmdmdWwgc3RhY2sgdHJhY2UgZnJvbQ0KPiA+ID4gICAg
IGdkYiBhbmQgaW5kaWNhdGUgdGhhdCBhZmZlY3RlZCBzeXN0ZW1zIGFyZSBsaW1pdGVkIHRvIENQ
VSdzDQo+ID4gPiAgICAgd2l0aCBMQlIgZXZlbnQgbG9nZ2luZyBzdXBwb3J0IGFuZCB0aGF0IGJv
dGggaHlicmlkIGFuZA0KPiA+ID4gICAgIG5vbi1oeWJyaWQgY29yZSBzeXN0ZW1zIGFyZSBhZmZl
Y3RlZC4NCj4gPiA+IC0tLQ0KPiA+ID4gIHRvb2xzL3BlcmYvYnVpbHRpbi10b3AuYyB8ICAgOCAr
KysNCj4gPiA+ICB0b29scy9wZXJmL3V0aWwvZW52LmMgICAgfCAxMTQgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgdG9vbHMvcGVyZi91dGlsL2Vudi5oICAg
IHwgICAxICsNCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEyMyBpbnNlcnRpb25zKCspDQo+ID4g
PiANCj4gPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL2J1aWx0aW4tdG9wLmMgYi90b29scy9w
ZXJmL2J1aWx0aW4tdG9wLmMNCj4gPiA+IGluZGV4IGY5ZjMxMzkxYmRkYi4uYzlkNjc5NDEwNTkx
IDEwMDY0NA0KPiA+ID4gLS0tIGEvdG9vbHMvcGVyZi9idWlsdGluLXRvcC5jDQo+ID4gPiArKysg
Yi90b29scy9wZXJmL2J1aWx0aW4tdG9wLmMNCj4gPiA+IEBAIC0xNzI5LDYgKzE3MjksMTQgQEAg
aW50IGNtZF90b3AoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KQ0KPiA+ID4gIAlpZiAob3B0
cy0+YnJhbmNoX3N0YWNrICYmIGNhbGxjaGFpbl9wYXJhbS5lbmFibGVkKQ0KPiA+ID4gIAkJc3lt
Ym9sX2NvbmYuc2hvd19icmFuY2hmbGFnX2NvdW50ID0gdHJ1ZTsNCj4gPiA+ICANCj4gPiA+ICsJ
aWYgKG9wdHMtPmJyYW5jaF9zdGFjaykgew0KPiA+ID4gKwkJc3RhdHVzID0gcGVyZl9lbnZfX3Jl
YWRfY29yZV9wbXVfY2FwcygmcGVyZl9lbnYpOw0KPiA+ID4gKwkJaWYgKHN0YXR1cykgew0KPiA+
ID4gKwkJCXByX2VycigiUE1VIGNhcGFiaWxpdHkgZGF0YSBpcyBub3QgYXZhaWxhYmxlXG4iKTsN
Cj4gPiA+ICsJCQlnb3RvIG91dF9kZWxldGVfZXZsaXN0Ow0KPiA+ID4gKwkJfQ0KPiA+ID4gKwl9
DQo+ID4gPiArDQo+ID4gPiAgCXNvcnRfX21vZGUgPSBTT1JUX01PREVfX1RPUDsNCj4gPiA+ICAJ
LyogZGlzcGxheSB0aHJlYWQgd2FudHMgZW50cmllcyB0byBiZSBjb2xsYXBzZWQgaW4gYSBkaWZm
ZXJlbnQgdHJlZSAqLw0KPiA+ID4gIAlwZXJmX2hwcF9saXN0Lm5lZWRfY29sbGFwc2UgPSAxOw0K
PiA+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9lbnYuYyBiL3Rvb2xzL3BlcmYvdXRp
bC9lbnYuYw0KPiA+ID4gaW5kZXggMzY0MTE3NDllMDA3Li42NzM1Nzg2YTFkMjIgMTAwNjQ0DQo+
ID4gPiAtLS0gYS90b29scy9wZXJmL3V0aWwvZW52LmMNCj4gPiA+ICsrKyBiL3Rvb2xzL3BlcmYv
dXRpbC9lbnYuYw0KPiA+ID4gQEAgLTQxNiw2ICs0MTYsMTIwIEBAIHN0YXRpYyBpbnQgcGVyZl9l
bnZfX3JlYWRfbnJfY3B1c19hdmFpbChzdHJ1Y3QgcGVyZl9lbnYgKmVudikNCj4gPiA+ICAJcmV0
dXJuIGVudi0+bnJfY3B1c19hdmFpbCA/IDAgOiAtRU5PRU5UOw0KPiA+ID4gIH0NCj4gPiA+ICAN
Cj4gPiA+ICtzdGF0aWMgaW50IF9fcGVyZl9lbnZfX3JlYWRfY29yZV9wbXVfY2Fwcyhjb25zdCBz
dHJ1Y3QgcGVyZl9wbXUgKnBtdSwNCj4gPiA+ICsJCQkJCSAgaW50ICpucl9jYXBzLCBjaGFyICoq
KmNhcHMsDQo+ID4gPiArCQkJCQkgIHVuc2lnbmVkIGludCAqbWF4X2JyYW5jaGVzLA0KPiA+ID4g
KwkJCQkJICB1bnNpZ25lZCBpbnQgKmJyX2NudHJfbnIsDQo+ID4gPiArCQkJCQkgIHVuc2lnbmVk
IGludCAqYnJfY250cl93aWR0aCkNCj4gPiA+ICt7DQo+ID4gPiArCXN0cnVjdCBwZXJmX3BtdV9j
YXBzICpwY2FwcyA9IE5VTEw7DQo+ID4gPiArCWNoYXIgKnB0ciwgKip0bXA7DQo+ID4gPiArCWlu
dCByZXQgPSAwOw0KPiA+ID4gKw0KPiA+ID4gKwkqbnJfY2FwcyA9IDA7DQo+ID4gPiArCSpjYXBz
ID0gTlVMTDsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKCFwbXUtPm5yX2NhcHMpDQo+ID4gPiArCQly
ZXR1cm4gMDsNCj4gPiA+ICsNCj4gPiA+ICsJKmNhcHMgPSB6YWxsb2Moc2l6ZW9mKGNoYXIgKikg
KiBwbXUtPm5yX2NhcHMpOw0KPiANCj4gY2FsbG9jPw0KDQpUaGFua3MgZm9yIHJldmlld2luZy4g
SXMgdGhlcmUgYSByZWFzb24gbm90IHRvIHVzZSB6YWxsb2MgaGVyZSBvciBpcyB0aGlzIHJlbGF0
ZWQgdG8gdXNpbmcgZnJlZQ0KaW5zdGVhZCBvZiB6ZnJlZSBsYXRlcj8NCg0KPiANCj4gPiA+ICsJ
aWYgKCEqY2FwcykNCj4gPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ID4gKw0KPiA+ID4gKwl0
bXAgPSAqY2FwczsNCj4gPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShwY2FwcywgJnBtdS0+Y2Fw
cywgbGlzdCkgew0KPiA+ID4gKw0KPiANCj4gTmVlZGxlc3MgYmxhbmsgbGluZQ0KPiANCj4gPiA+
ICsJCWlmIChhc3ByaW50ZigmcHRyLCAiJXM9JXMiLCBwY2Fwcy0+bmFtZSwgcGNhcHMtPnZhbHVl
KSA8IDApIHsNCj4gPiA+ICsJCQlyZXQgPSAtRU5PTUVNOw0KPiA+ID4gKwkJCWdvdG8gZXJyb3I7
DQo+ID4gPiArCQl9DQo+ID4gPiArDQo+ID4gPiArCQkqdG1wKysgPSBwdHI7DQo+ID4gPiArDQo+
ID4gPiArCQlpZiAoIXN0cmNtcChwY2Fwcy0+bmFtZSwgImJyYW5jaGVzIikpDQo+ID4gPiArCQkJ
Km1heF9icmFuY2hlcyA9IGF0b2kocGNhcHMtPnZhbHVlKTsNCj4gPiA+ICsNCj4gPiA+ICsJCWlm
ICghc3RyY21wKHBjYXBzLT5uYW1lLCAiYnJhbmNoX2NvdW50ZXJfbnIiKSkNCj4gPiA+ICsJCQkq
YnJfY250cl9uciA9IGF0b2kocGNhcHMtPnZhbHVlKTsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmICgh
c3RyY21wKHBjYXBzLT5uYW1lLCAiYnJhbmNoX2NvdW50ZXJfd2lkdGgiKSkNCj4gPiA+ICsJCQkq
YnJfY250cl93aWR0aCA9IGF0b2kocGNhcHMtPnZhbHVlKTsNCj4gDQo+IGVsc2UgaWY/DQo+IA0K
PiBJLmUuIHdoeSB0ZXN0IGl0IHJlcGVhdGVkbHkgd2hlbiBpdCBjYW4ndCBiZSB0aGUgdGhyZWUg
b2YgdGhlbT8NCg0KSSB3YXMgYm9ycm93aW5nIGZyb20gYSBzaW1pbGFyIGltcGxlbWVudGF0aW9u
IGhlcmUsDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL2FlZjE3Y2Iz
ZDNjNDM4NTQwMDI5NTZmMjRjMjRlYzhlMWEwZTM1NDYvdG9vbHMvcGVyZi91dGlsL2hlYWRlci5j
I0wzMjgzDQoNCmJ1dCBJIHNlZSB3aGF0IHlvdSBtZWFuLiBUaGF0IG1heSBleHBsYWluIHdoeSBJ
IHVzZWQgZnJlZSBpbnN0ZWFkIHpmcmVlIGFzIHdlbGwuDQoNCg0KPiANCj4gV2hhdCBpZiBpdCBp
cyBub3Qgb25lIG9mIHRoZXNlIHRocmVlPyBGcmVlIGFuZCBlcnJvciBvdXQ/DQo+IA0KDQpJbiB0
aGF0IGNhc2UsIHRoZSBjYXBhYmlsaXR5IGRhdGEgc2hvdWxkIHN0aWxsIGJlIHdyaXR0ZW4gdG8g
dGhlIGNhcHMgYXJyYXkgaW4gc3RydWN0IHBtdV9jYXBzLg0KVGhlc2UgbWVtYmVycyBzZWVtIHRv
IGJlIGFkZGVkIHRvIHBtdV9jYXBzIGZvciBjb252ZW5pZW5jZS4gDQoNCj4gPiA+ICsJfQ0KPiA+
ID4gKwkqbnJfY2FwcyA9IHBtdS0+bnJfY2FwczsNCj4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gPiAr
ZXJyb3I6DQo+ID4gPiArCXdoaWxlICh0bXAtLSAhPSAqY2FwcykNCj4gPiA+ICsJCWZyZWUoKnRt
cCk7DQo+IA0KPiB6ZnJlZSh0bXApDQo+IA0KPiA+ID4gKwlmcmVlKCpjYXBzKTsNCj4gPiA+ICsJ
KmNhcHMgPSBOVUxMOw0KPiANCj4gemZyZWUoY2FwcykNCj4gDQo+ID4gPiArCSpucl9jYXBzID0g
MDsNCj4gPiA+ICsJcmV0dXJuIHJldDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAraW50IHBl
cmZfZW52X19yZWFkX2NvcmVfcG11X2NhcHMoc3RydWN0IHBlcmZfZW52ICplbnYpDQo+ID4gPiAr
ew0KPiA+ID4gKwlzdHJ1Y3QgcGVyZl9wbXUgKnBtdSA9IE5VTEw7DQo+IA0KPiB3aHkgaW5pdCBp
dCB0byBOVUxMIGlmIGl0IHdpbGwgYmUgaW5pdGlhbGl6ZWQgdG8gc29tZXRoaW5nIGVsc2UgbGF0
ZXIgb24NCj4gYmVmb3JlIGJlaW5nIHVzZWQ/DQoNCkkgd2FudGVkIHRvIGluc3VyZSBpdCB3YXMg
TlVMTCBiZWZvcmUgcGFzc2luZyB0byBwZXJmX3BtdXNfX3NjYW5fY29yZSwganVzdCBiZWluZyBw
YXJhbm9pZCBJIGd1ZXNzLg0KDQo+IA0KPiA+ID4gKwlzdHJ1Y3QgcG11X2NhcHMgKnBtdV9jYXBz
Ow0KPiA+ID4gKwlpbnQgbnJfcG11ID0gMCwgaSA9IDAsIGo7DQo+ID4gPiArCWludCByZXQ7DQo+
ID4gPiArDQo+ID4gPiArCW5yX3BtdSA9IHBlcmZfcG11c19fbnVtX2NvcmVfcG11cygpOw0KPiAN
Cj4gbnJfcG11ID0gMCBmb2xsb3dlZCBieSB0aGlzIGNhbGw/DQo+IA0KPiA+ID4gKw0KPiA+ID4g
KwlpZiAoIW5yX3BtdSkNCj4gPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+ID4gKw0KPiA+ID4g
KwlpZiAobnJfcG11ID09IDEpIHsNCj4gPiA+ICsJCXBtdSA9IHBlcmZfcG11c19fZmluZF9jb3Jl
X3BtdSgpOw0KPiA+ID4gKwkJaWYgKCFwbXUpDQo+ID4gPiArCQkJcmV0dXJuIC1FTk9ERVY7DQo+
ID4gPiArCQlyZXQgPSBwZXJmX3BtdV9fY2Fwc19wYXJzZShwbXUpOw0KPiA+ID4gKwkJaWYgKHJl
dCA8IDApDQo+ID4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiA+ICsJCXJldHVybiBfX3BlcmZfZW52
X19yZWFkX2NvcmVfcG11X2NhcHMocG11LCAmZW52LT5ucl9jcHVfcG11X2NhcHMsDQo+ID4gPiAr
CQkJCQkJICAgICAgJmVudi0+Y3B1X3BtdV9jYXBzLA0KPiA+ID4gKwkJCQkJCSAgICAgICZlbnYt
Pm1heF9icmFuY2hlcywNCj4gPiA+ICsJCQkJCQkgICAgICAmZW52LT5icl9jbnRyX25yLA0KPiA+
ID4gKwkJCQkJCSAgICAgICZlbnYtPmJyX2NudHJfd2lkdGgpOw0KPiA+ID4gKwl9DQo+ID4gPiAr
DQo+ID4gPiArCXBtdV9jYXBzID0gemFsbG9jKHNpemVvZigqcG11X2NhcHMpICogbnJfcG11KTsN
Cj4gPiA+ICsJaWYgKCFwbXVfY2FwcykNCj4gPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ID4g
Kw0KPiA+ID4gKwl3aGlsZSAoKHBtdSA9IHBlcmZfcG11c19fc2Nhbl9jb3JlKHBtdSkpICE9IE5V
TEwpIHsNCj4gPiA+ICsJCWlmIChwZXJmX3BtdV9fY2Fwc19wYXJzZShwbXUpIDw9IDApDQo+ID4g
PiArCQkJY29udGludWU7DQo+ID4gPiArCQlyZXQgPSBfX3BlcmZfZW52X19yZWFkX2NvcmVfcG11
X2NhcHMocG11LCAmcG11X2NhcHNbaV0ubnJfY2FwcywNCj4gPiA+ICsJCQkJCQkgICAgICZwbXVf
Y2Fwc1tpXS5jYXBzLA0KPiA+ID4gKwkJCQkJCSAgICAgJnBtdV9jYXBzW2ldLm1heF9icmFuY2hl
cywNCj4gPiA+ICsJCQkJCQkgICAgICZwbXVfY2Fwc1tpXS5icl9jbnRyX25yLA0KPiA+ID4gKwkJ
CQkJCSAgICAgJnBtdV9jYXBzW2ldLmJyX2NudHJfd2lkdGgpOw0KPiA+ID4gKwkJaWYgKHJldCkN
Cj4gPiA+ICsJCQlnb3RvIGVycm9yOw0KPiA+ID4gKw0KPiA+ID4gKwkJcG11X2NhcHNbaV0ucG11
X25hbWUgPSBzdHJkdXAocG11LT5uYW1lKTsNCj4gPiA+ICsJCWlmICghcG11X2NhcHNbaV0ucG11
X25hbWUpIHsNCj4gPiA+ICsJCQlyZXQgPSAtRU5PTUVNOw0KPiA+ID4gKwkJCWdvdG8gZXJyb3I7
DQo+ID4gPiArCQl9DQo+ID4gPiArCQlpKys7DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJ
ZW52LT5ucl9wbXVzX3dpdGhfY2FwcyA9IG5yX3BtdTsNCj4gPiA+ICsJZW52LT5wbXVfY2FwcyA9
IHBtdV9jYXBzOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ICtlcnJvcjoNCj4g
PiA+ICsJZm9yIChpID0gMDsgaSA8IG5yX3BtdTsgaSsrKSB7DQo+ID4gPiArCQlmb3IgKGogPSAw
OyBqIDwgcG11X2NhcHNbaV0ubnJfY2FwczsgaisrKQ0KPiA+ID4gKwkJCWZyZWUocG11X2NhcHNb
aV0uY2Fwc1tqXSk7DQo+ID4gPiArCQlmcmVlKHBtdV9jYXBzW2ldLmNhcHMpOw0KPiA+ID4gKwkJ
ZnJlZShwbXVfY2Fwc1tpXS5wbXVfbmFtZSk7DQo+IA0KPiB6ZnJlZSBpbiBhbGwgdGhlIGZyZWVz
IGFib3ZlPw0KDQpUaGFua3MgYWdhaW4sIEkgY2FuIHVzZSB6ZnJlZSBoZXJlIGFuZCBhZGRyZXNz
IHRoZSByZXN0IG9mIHRoZSBjb21tZW50cyBpbiBhIG5ldyB2ZXJzaW9uIGlmIHRoaXMNCmhhc24n
dCBiZWVuIGFwcGxpZWQgYWxyZWFkeT8NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+ID4gPiArCX0N
Cj4gPiA+ICsJZnJlZShwbXVfY2Fwcyk7DQo+ID4gPiArCXJldHVybiByZXQ7DQo+ID4gPiArfQ0K
PiA+ID4gKw0KPiA+ID4gIGNvbnN0IGNoYXIgKnBlcmZfZW52X19yYXdfYXJjaChzdHJ1Y3QgcGVy
Zl9lbnYgKmVudikNCj4gPiA+ICB7DQo+ID4gPiAgCXJldHVybiBlbnYgJiYgIXBlcmZfZW52X19y
ZWFkX2FyY2goZW52KSA/IGVudi0+YXJjaCA6ICJ1bmtub3duIjsNCj4gPiA+IGRpZmYgLS1naXQg
YS90b29scy9wZXJmL3V0aWwvZW52LmggYi90b29scy9wZXJmL3V0aWwvZW52LmgNCj4gPiA+IGlu
ZGV4IGQ5MGUzNDNjZjFmYS4uMTM1YTFmNzE0OTA1IDEwMDY0NA0KPiA+ID4gLS0tIGEvdG9vbHMv
cGVyZi91dGlsL2Vudi5oDQo+ID4gPiArKysgYi90b29scy9wZXJmL3V0aWwvZW52LmgNCj4gPiA+
IEBAIC0xNTIsNiArMTUyLDcgQEAgc3RydWN0IGJ0Zl9ub2RlOw0KPiA+ID4gIA0KPiA+ID4gIGV4
dGVybiBzdHJ1Y3QgcGVyZl9lbnYgcGVyZl9lbnY7DQo+ID4gPiAgDQo+ID4gPiAraW50IHBlcmZf
ZW52X19yZWFkX2NvcmVfcG11X2NhcHMoc3RydWN0IHBlcmZfZW52ICplbnYpOw0KPiA+ID4gIHZv
aWQgcGVyZl9lbnZfX2V4aXQoc3RydWN0IHBlcmZfZW52ICplbnYpOw0KPiA+ID4gIA0KPiA+ID4g
IGludCBwZXJmX2Vudl9fa2VybmVsX2lzXzY0X2JpdChzdHJ1Y3QgcGVyZl9lbnYgKmVudik7DQo+
ID4gDQo+IA0KDQo=

