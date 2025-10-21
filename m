Return-Path: <linux-kernel+bounces-863701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3692BF8DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EDF460F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D90288510;
	Tue, 21 Oct 2025 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fN2Mc3u2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0B23B605;
	Tue, 21 Oct 2025 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080492; cv=fail; b=QfeViGdfuxszBjnZSZCTOQREYNl2jxvzCHolD0t0iRfL/bK2j9nxMfy7RR+N2MofAfishKfe5zt88OTu72Y9m9+vNI+KYhPKEcoDyMEEn+50g90QTqAOdXbSWlza97AZ8qWZ+b7gxHk1S6K+Ufuo6uqNGi7Dbihx18wQiUwWa84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080492; c=relaxed/simple;
	bh=d9eAi+0s6rZxYJBSqo5D0AlAR5k/APkD8x226kxXKks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F6dd+nNkfh25/WnpqGR1xO0KZtVylk2UxYtp+4/8J6HuU6nHWmh96nzDgVCM5rtiu2NBPfoJYms1uBaZ4lzqNUzMvToDYr/iPfwHqZFOufANggoZgJtNI4Wo0q5MyEw/gR9Fhbdhha2iT9ZqdoaDFNjRo7gC28ynqGe6+9f+RjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fN2Mc3u2; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761080490; x=1792616490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d9eAi+0s6rZxYJBSqo5D0AlAR5k/APkD8x226kxXKks=;
  b=fN2Mc3u2z301pp22kguuvaubuwqwXdQIlxspr7gsl8hbURex1bzp6PF2
   cdjSFgY7pIezuH9El/Mv0ij6q9wYWX6XgXKbvdbcS/WKdoNw4RGAPJBMM
   vGjfeuqTt9f85qBWLy+EYCGsma9o01ILyDm3D3Suzhzw8bzD9czHoOA4D
   QGn/mJ6YTrzW8ZW0bIbFE6lZx9HNdfV0/Xxg9Fmce5c2/Dl7s+LnDm2MQ
   kViqyL0O6cR+9SSqAgFW12oE02+J45glE4+DBZKzUTsTfOZiR0vfznIYh
   pcxx9hx9IfwL7qUS3aMZDUdiQm0vbkadga3IW2m5/LJGeVxaY+65z55fo
   g==;
X-CSE-ConnectionGUID: 62pR5A/FSuKA7Aq6VEturQ==
X-CSE-MsgGUID: 3iHPrfAWR8GCJZvDvl7+TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62249912"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="62249912"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 14:01:29 -0700
X-CSE-ConnectionGUID: cJZku1cJT0iqWv8GJtDFCQ==
X-CSE-MsgGUID: nUng+l8WRU+bGuAtkw8pUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="187729966"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 14:01:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 14:01:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 14:01:27 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 14:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+oc0mgK+0X/eVPEetZmay43WzTKWDAh8VNuodEBN6UqbHWffIlBXKH9RgzRf7TLLzKXdpEYt+lb3e/nwDyYssr5ZUJ6X8Cx9Alqur+umQutJNavf0KKFMRstWG0uQBLpniBCd9WxL6n+gpBrL1Kp3mAFNbILp3hUVS2czfjUOQjNUoZ5wKChJAPJsP5O7Tz2vWWB8iN8Xx3hVbEPfZmXHDvNNUyxkM6tvN8c6zCwrU1XaworBWCOk+Qv7pNR+1XQOOz+q/8OzPvcMfH87RZToawTXq7YheUqzacTU9o4930EGxdWVrfuVSMUvLPH1LDzX9IODJIbsMjHcG1sjBUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9eAi+0s6rZxYJBSqo5D0AlAR5k/APkD8x226kxXKks=;
 b=Z2jiA6ck6Ukf+HiSGDaEYiUIIFMUyprmP5o0IZYLMtmUqx1UUhD2l++w9pBPGZvT+l5mMenzzcWSGLQM0twqXLmfIgU9XD8h8TFzZ8JlNqXEowYAIprwV6orjnU7NsrAGk2CzHiGlImFzAIyCqtvHGL24u8zf/p6mAe55EPQAPFZtO44c0Z3znwow1DsxuwKL7V+eR3IAyzCXW86WRG4hMKejqrg1AQa7EY3Dh+59ntqYf/mHHekwE5qhMu4GAdNK0yf1DkbM4DD96bYE9xh8BL7feLw8+DGOJu4tsvhnLj9Ml0A7Qa5WjER6tzUXivXM2AU9YZA9JK/bhY2d1HV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7)
 by DM3PPF3E6742BA8.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 21:01:24 +0000
Received: from CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::9d32:3dfb:c2f1:40e2]) by CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::9d32:3dfb:c2f1:40e2%3]) with mapi id 15.20.9203.007; Tue, 21 Oct 2025
 21:01:23 +0000
From: "Winiarska, Iwona" <iwona.winiarska@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bmasney@redhat.com" <bmasney@redhat.com>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>
CC: "joel@jms.id.au" <joel@jms.id.au>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Thread-Topic: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Thread-Index: AQHcCkU9/Mtiofu43UmyoEi8nlGYDrSSyKAAgAEf6QCAMXIYgIAA7bGAgAAFLwCAAA0DAIAABGUAgAQk0ACAAwNeAA==
Date: Tue, 21 Oct 2025 21:01:23 +0000
Message-ID: <d53256b35ee7089607463c66bb4a8c3420faf058.camel@intel.com>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
		 <aMatZAX6eFI1RmDH@redhat.com>
		 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
		 <aPEZSY6RC-UVclxN@redhat.com>
		 <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>
		 <2025101759-runner-landing-374b@gregkh>
		 <2975918e3f3a7de245e93fbee52335acb78bb23a.camel@codeconstruct.com.au>
		 <2025101721-twiddling-huskiness-4852@gregkh>
	 <13566a08eeaed313ad789abcae1920d9b00483b0.camel@codeconstruct.com.au>
In-Reply-To: <13566a08eeaed313ad789abcae1920d9b00483b0.camel@codeconstruct.com.au>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5330:EE_|DM3PPF3E6742BA8:EE_
x-ms-office365-filtering-correlation-id: e298cbed-9eb8-4cd0-0554-08de10e4fe5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UE5ab1ZxZjdNRVhKZTlpcXg2RDJiTis2KytaeGVLLzdVcTlZYkt4bzBtWDdi?=
 =?utf-8?B?RWpGVzdmaTRGaXlPNVhPSlk1NUdNU2V0eXhhWktRUGVkeFhrSEJIc0NaS0p2?=
 =?utf-8?B?bkxNTGhORTNaTG1JdHRFYzdpT0Z0b1NDOXFwd2JVYTV2SU5FT1dPV3Fxb2Jp?=
 =?utf-8?B?aTVuZVhsbUswMVdmOXNCazdrM0ZxZXFMOWNmY3EzNjd5VncxT2dYT0t2cTZ2?=
 =?utf-8?B?MTlrVEZuYzNEdVNxbEtlTkZ5dE9HOWR2bXZXZzFSTjFGblg0Z2dtT1FlZnNt?=
 =?utf-8?B?OWhTQmJ6L1QvMDd1dGJOZVlWU0tPUmJrQm8wRlkzVXhwL3ZIRXZZRDgxcDJO?=
 =?utf-8?B?T2NLV3Qzay9jaHpTSHA1TnE4SEpPamJtS2ZrVkgwOWxSMW41d05Dcy9OY2xZ?=
 =?utf-8?B?a1FNaUwrMXRLcnEwK21HTC9ZRDVFdHYzaWRzakRFZlVvOUhqdlZTa3RwaGgz?=
 =?utf-8?B?QU1VcmFDa0htOGh0dVdTL3hDeGN5UElieVR5UU9OaEtRSUs1S0hwSDV3ZGJJ?=
 =?utf-8?B?bWU1clYwZnJCampiOGZsVWdxOWcxZkNsNElOSDh2SlgzMXQvNmYvVTBtd1RT?=
 =?utf-8?B?dHRpU1VwTkh1YkFUcVpJSWRiRG01QW5udk1jWm5NcHN5eWpRSjB6Z1pRS2F4?=
 =?utf-8?B?c3JHRzlkbndLZUU2UDc3cFJGV2U2MGh1Z0RHRWNoRkJnak1QamJER2VLYTQ0?=
 =?utf-8?B?dTQzK3U3QTV0TG5EdExpMjZSTUJxbXBBR0tEOEFJUG1keDJzaHAxVzI2aGpl?=
 =?utf-8?B?bCszaXBPZU9WSS83YklWZ1JrRG1Lcnc1cC9RcjNsZHNzenVFZDFpV2NjWXFk?=
 =?utf-8?B?S2hWQ3RISTYwWmhybmhvRVdTTHhEVHVJOVZ4ZjhUUTRSUEZPVndZeC9DNFJP?=
 =?utf-8?B?c3lKekRJbWJpaXJWMVF5a3k0K3NwYUd5ZW1kMFowaGxndVhQaERmdnhrNklT?=
 =?utf-8?B?YjZoc0cyVDlPazZMaWFDUWhiMG1Fem0yZlVGYnZMMEcvdDFkd0psVVVkMmQy?=
 =?utf-8?B?MW5kMkJpRnd6ajlxQ016MEdFajlQOHN4OE56QzZzZGNWYlh1UEhQTUJ6NWUv?=
 =?utf-8?B?S1d3T0RIdjBzR2daV1Mrb29DMnBQdlJqL3JvYUNoMGthV1hUcVFFci8zYkR5?=
 =?utf-8?B?R1hGVHl2bEJ2czJvY0F6OUduUER2QndTK2JXdjAwWWF2eGV0ZTdFVmpiQVdI?=
 =?utf-8?B?R1dMWlNHa3ZYM3dnOGxOd0Qzb2I0VXFQWXZtRmhpTlg1VEhmK1gvM2o0N2c5?=
 =?utf-8?B?Ym5udkhVOXUwWm5kQXp5Y2tqVkllUC9kblA1YXE0K1VYN2dsa2VUQTVHNnpI?=
 =?utf-8?B?WHJONGkyOUNQSmNFU3NyOVFpZ0FFdTlRYmJUSlFuUjBnaHVmUXhwMFFqMjNy?=
 =?utf-8?B?ZmZiaThHR2NXNHFjR3hZdE1uV1pUS0VncFloNjM3eVhXYnlEd0swMmhOQ0VR?=
 =?utf-8?B?ME5ZT2xIL1dhREZTMmlUalNYU1dYb0NQMmdmb0VOK2RGYlNtL0xjYm5hYm9m?=
 =?utf-8?B?WHpHMlc2ZWRDNzA2eGZwdkpETVdFc215alkzK3Zub2V5UXNiM0xxcmNEVjgy?=
 =?utf-8?B?R3VadkpVT1h4R0J3cHFnM29sbnZoSmZmRERsZXU2UmprdlB4VSs0WUhTZkZJ?=
 =?utf-8?B?dkQ4R0pwYjdGdmJTSFB6Vng0c3hTUFIveXMzVUwxV3UxQjNBZDg0bnRaOE9Q?=
 =?utf-8?B?YjQ1TnZLdDdzaUFIM2RvZ1lFZWFEWmlncjNEWVhDTmVpdmVnYVNnSDljRFZW?=
 =?utf-8?B?UGV6MlhOcUVGTHpKTXRNUnhlMnlFUHNQcmd5ak1Pd0JaQ1RvRTZCYTJxOTVD?=
 =?utf-8?B?WHJqU1VxWkx5V3Yybnh0MTh4UTVOK3FzalVucHNlbTMrZnhISEEwWS9CenM1?=
 =?utf-8?B?WHhxODRPUHoya2c4S0grczFqMlVIdDNWbzEyWXhCdkdmS01NdGhHNm9jQ0Rw?=
 =?utf-8?B?OVEzUUV6NDdGVGNRbWRLSWxnQlF0eU1wSGpGdUZvYjAyUzVSQzlnS0R3L01j?=
 =?utf-8?B?dG1KRlhGM1ltTG42U21ORDVXMldlRjM2dHJOOEZ6NWdFU2dhc1RFUGpoYjFO?=
 =?utf-8?Q?rD6pMm?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5330.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkZleFhBdElod01BSWxCYy93NlFuNEtKRFFIZjA0R1lMbXk1b2NQYUt0OUZa?=
 =?utf-8?B?czkxWjNHa20zSEFLcyt3L0lNNzM1NE1ROGJuODV5anhSSWxMWnpVbnRWTWpJ?=
 =?utf-8?B?QmtPMXF6Zjg1YmJ1emtuN0pPTmwvbzU4Z0VSc0xCcGZQNGpWNUJCOUc4U2Yz?=
 =?utf-8?B?QS9hMlJyY0V2ZFRJT2g3SWJyS1NxQVhLMDNWSHFmV2lOMUFuaFdvdTh2cXhO?=
 =?utf-8?B?NWY1NG9hYTZleGdydkR4Y0pBa3MzejBvOEx4YkxKZkxjQmZBZFdLM2tUd1Ft?=
 =?utf-8?B?OXZQRlB4d1dlVG56RmFPUVZrMjJMSnVMODBtU21rR1REa2Yxd0lQbnpRRDJk?=
 =?utf-8?B?Q2p1SlM4K1ZXazVFQW1GMEltVXJUdURuWlZoTW53NUVEVTNiOFZIdnN0UnhM?=
 =?utf-8?B?Q0ZISTRJbWl3WFBSRzlrbWRSbzBGREcwQXVuWVNnR1YzQWEyZ2xLZDAvamM4?=
 =?utf-8?B?eUtNNithV1pTb3JNeGlKMXZ2alFzWENrV3UzZnBPRDV1cTAvNGRiT25PdmRW?=
 =?utf-8?B?Z0FrVUdnMFM1T0c0bkFRcmFCOE9KazA0QVdEUnZURGFZTncwQmkrNXJlcTJF?=
 =?utf-8?B?S1g2UFRFYmxPUlJRQlUxQU5LTGZzbXR4WTJUWTdNNko4bVNiU290MmxXSzVs?=
 =?utf-8?B?RkU0dHlsQ0lDdkt1TGZGYklFVjlqQWFmQjJxeDVoYXJyaTZ5UnFyOHdncWFz?=
 =?utf-8?B?cTBocmhlSzlsb2pqQm9IY2FSRWdiN3dmUGwvSEc4eXJtdW4zRWpRQ3M4c3Mx?=
 =?utf-8?B?TTUyVWQ1S2JBQUh0VjZEaVZlZzYxcmIxVFdOeFZtMnpwSmdXUE4rMDNkZ1l6?=
 =?utf-8?B?Y0tUMDRjUUtuNVM0MjA0U2NuOXFHajVnd1hxdHZhSjdTNGxJTk5IaEhSaVNR?=
 =?utf-8?B?YzZDeXdsMWVNbCtNaGw5WVlvamVnSjhwZ2N1eUEyQTlvWWpYZUJJeDVOZlIx?=
 =?utf-8?B?aEpaTEwxQUFYeDFlVi82STRIK2JrcElQVXJXQm9nNXV4RjE4Ui9QWTB4K1oy?=
 =?utf-8?B?WWpVTnRBQ3A5b0o1YWVkN0RMc2hiM2VLbSt4MXlOQXB2SWdrSEQyeTVwNm1N?=
 =?utf-8?B?Tms0d0I4UWY5MUlydlc1cUZMRVNsVEVGV0tLa3I5MnJjdG9seU9NRG1YTjZN?=
 =?utf-8?B?eTNwMDh5MUwxT2E1VjhBRWVLSVpYdVBkSm5Rd0hIVWM3WHdwdjRabUpocXhm?=
 =?utf-8?B?Um9DQVdFcmZXeWdCVkxiYnVGVWxlSlN1UUd3eGJWenpjVlBjVWZjRUNBYzYz?=
 =?utf-8?B?REs0cy9xZTFUZFhmOHMrNXlCMjhoVXlVQjd1d25aK28yQ2ZlN3ZtbTg2bDB2?=
 =?utf-8?B?RWI4b3lGbzUybGpMVGhOWVJwMXhqUHpHSFo5YWdkbHQzZXFYaDAvTjk1TC9i?=
 =?utf-8?B?azF1UVdrMDlNZkpQVG1QTURoU0RPZSs3RUo5Rm82KzhJSWprTWpmWWZ2dkpH?=
 =?utf-8?B?L01IbytsK2o5TE9MenZJUXVxM1FYeEJHUHF2MTUydFJPOUcrNDNuZlZOMWN4?=
 =?utf-8?B?NHQwYWR1UTNwK0QvZTJ6VXVHRXhtVzJGWkZ4RHZPMllhempBbU56c0hZTElS?=
 =?utf-8?B?OU9ONUFjTTUxRlhaZUh2WmJBYkZaR0FKdUVhKzduMDVmcVNaSzRNQVZKZlNz?=
 =?utf-8?B?NVNqVHB6aE5MZDFBc0RhQTNwWVdscnp2N21IcWxScVNUTkNkbUJtM0ZjUTdl?=
 =?utf-8?B?YW1FL2ZWb0RVR2U5dTNZUVN3STlkTytUNFFDNHdNbWk4aWVZWmRvZzF0SG04?=
 =?utf-8?B?NmFkWkdkVk9BWnpmS0ErYzh2bHh5SjhXWkdWcjY3RzBCU2pVZk4zY1FrRkU3?=
 =?utf-8?B?SG4vWGkwS2Y3a1pGMnl2dEw3d1RHejZTaWFLU0FTTHUxb0FIZXQyNThoR1ZR?=
 =?utf-8?B?SnoveXNZVFVDYjJoQVVrSW1pVnFPSEhYbGZUMStHWHE2R0RqU3QzTXNsTTZG?=
 =?utf-8?B?My9iRWNHVUIyNzZDSGhIL01EaDZ5TmZvNGs1Q3ZoQXB6MU5zd1d3UThmR3hL?=
 =?utf-8?B?RmNxd0IzejM4NGUreUo0Y3pBQ3czSUw5VnhaSS9RZWJBVTJvajJ0TnAwVWlG?=
 =?utf-8?B?SG4zVU9wVFRNSDgySHNEOVdzZ0xHWEJBSXd6NHhaRWVYeG9yZ214c3BqUUp1?=
 =?utf-8?B?LzhNSWJsMloxWTBtTngzajZCL08xeXIwVGpJZWZ5KzBTdElMUSs1dzRnOVRJ?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76A6DA06F4A50D489B6D9816CA3A20E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5330.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e298cbed-9eb8-4cd0-0554-08de10e4fe5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 21:01:23.8353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /5in5PP/oXpmWAmbZZ5i1aPlxYUHDenQcLVAGgAP9gPr9qihdahfzRnLJqBtbQzFHWXhs3DeuGqrpQa4T1o2Y6Cd9tINMh4Zb/uYG3/5Q+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF3E6742BA8
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTIwIGF0IDA5OjMwICsxMDMwLCBBbmRyZXcgSmVmZmVyeSB3cm90ZToN
Cj4gT24gRnJpLCAyMDI1LTEwLTE3IGF0IDA5OjQzICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4g
d3JvdGU6DQo+ID4gT24gRnJpLCBPY3QgMTcsIDIwMjUgYXQgMDU6NTc6NDRQTSArMTAzMCwgQW5k
cmV3IEplZmZlcnkgd3JvdGU6DQo+ID4gPiBPbiBGcmksIDIwMjUtMTAtMTcgYXQgMDg6NDEgKzAy
MDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiA+ID4gT24gRnJpLCBPY3QgMTcsIDIw
MjUgYXQgMDQ6NTI6MzdQTSArMTAzMCwgQW5kcmV3IEplZmZlcnkgd3JvdGU6DQo+ID4gPiA+ID4g
SGkgR3JlZywNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBUaHUsIDIwMjUtMTAtMTYgYXQgMTI6
MTEgLTA0MDAsIEJyaWFuIE1hc25leSB3cm90ZToNCj4gPiA+ID4gPiA+IEhpIEFuZHJldyBhbmQg
SXdvbmEsDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIE1vbiwgU2VwIDE1LCAyMDI1IGF0
IDAyOjM2OjQ4UE0gKzA5MzAsIEFuZHJldyBKZWZmZXJ5IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBI
aSBCcmlhbiwNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IE9uIFN1biwgMjAyNS0wOS0x
NCBhdCAwNzo1NiAtMDQwMCwgQnJpYW4gTWFzbmV5IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IEhp
IEl3b25hLCBKb2VsLCBhbmQgQW5kcmV3LA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiA+IE9uIFN1biwgQXVnIDEwLCAyMDI1IGF0IDA2OjIxOjUxUE0gLTA0MDAsIEJyaWFuIE1hc25l
eSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IFRoZSByb3VuZF9yYXRlKCkgY2xrIG9wcyBpcyBk
ZXByZWNhdGVkLCBzbyBtaWdyYXRlIHRoaXMNCj4gPiA+ID4gPiA+ID4gPiA+IGRyaXZlciBmcm9t
DQo+ID4gPiA+ID4gPiA+ID4gPiByb3VuZF9yYXRlKCkgdG8gZGV0ZXJtaW5lX3JhdGUoKSB1c2lu
ZyB0aGUgQ29jY2luZWxsZQ0KPiA+ID4gPiA+ID4gPiA+ID4gc2VtYW50aWMgcGF0Y2gNCj4gPiA+
ID4gPiA+ID4gPiA+IGFwcGVuZGVkIHRvIHRoZSAidW5kZXItdGhlLWN1dCIgcG9ydGlvbiBvZiB0
aGUgcGF0Y2guDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEJyaWFuIE1hc25leSA8Ym1hc25leUByZWRoYXQuY29tPg0KPiA+ID4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiA+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGdldCB0aGlzIHBpY2tl
ZCB1cCBmb3IgdjYuMTg/IEknZA0KPiA+ID4gPiA+ID4gPiA+IGxpa2UgdG8gcmVtb3ZlDQo+ID4g
PiA+ID4gPiA+ID4gdGhpcyBBUEkgZnJvbSBkcml2ZXJzL2NsayBpbiB2Ni4xOS4NCj4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+IE15IChzdHJvbmcpIHByZWZlcmVuY2UgaXMgdGhhdCBJd29u
YSBhcHBsaWVzIGl0LCBidXQgSSdsbCBrZWVwDQo+ID4gPiA+ID4gPiA+IGFuIGV5ZQ0KPiA+ID4g
PiA+ID4gPiBvdXQgZm9yIGFueSB1bnVzdWFsIGRlbGF5cy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gVGhpcyBwYXRjaCB3YXNuJ3QgcGlja2VkIHVwIGZvciB2Ni4xOC4gQW55IGNoYW5jZSB0
aGlzIGNhbiBnZXQNCj4gPiA+ID4gPiA+IHBpY2tlZCB1cA0KPiA+ID4gPiA+ID4gbm93IGZvciB2
Ni4xOT8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSdtIGhvcGluZyB0byBnZXQgdGhpcyBt
ZXJnZWQgc28gdGhhdCB3ZSBjYW4gcmVtb3ZlIHRoZQ0KPiA+ID4gPiA+ID4gcm91bmRfcmF0ZSgp
IGNsaw0KPiA+ID4gPiA+ID4gb3AgZnJvbSB0aGUgY2xrIGNvcmUuIFRoZSBjbGsgbWFpbnRhaW5l
ciAoU3RlcGhlbikgbWVudGlvbmVkIHRoaXMNCj4gPiA+ID4gPiA+IHdvcmsNCj4gPiA+ID4gPiA+
IGluIGhpcyBsYXN0IHB1bGwgdG8gTGludXMuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWNsay8yMDI1MTAwNzA1MTcyMC4xMTM4Ni0xLXNi
b3lkQGtlcm5lbC5vcmcvDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQXJlIHlvdSBoYXBweSB0byBw
aWNrIHRoaXMgdXAgZGlyZWN0bHkgaW4gSXdvbmEncyBhYnNlbmNlPw0KPiA+ID4gPiANCj4gPiA+
ID4gV2h5IG1lPw0KPiA+ID4gDQo+ID4gPiBJIGZpZ3VyZWQgdGhhdCB3b3VsZCBiZSBzZW5zaWJs
ZSBzaW5jZSBJd29uYSBoaXN0b3JpY2FsbHkgc2VudCB5b3UgUFJzDQo+ID4gPiBmb3IgdGhlIFBF
Q0kgc3Vic3lzdGVtLg0KPiA+IA0KPiA+IEkgZGlkIG5vdCByZW1lbWJlciB0aGF0LCBzb3JyeS4N
Cj4gPiANCj4gDQo+IE5vIHdvcnJpZXMuDQo+IA0KPiA+IMKgIFRoZSBNQUlOVEFJTkVSUyBmaWxl
IGRvZXMgbm90IG1lbnRpb24NCj4gPiB0aGlzIGF0IGFsbCwgYW5kIGl0IGxpc3RzIG1hbnkgb3Ro
ZXIgbWFpbnRhaW5lcnMgdGhhdCBzaG91bGQgYmUgYWJsZSB0bw0KPiA+IHRha2UgdGhpcyBwYXRj
aDoNCj4gPiAJJCAuL3NjcmlwdHMvZ2V0X21haW50YWluZXIucGzCoCBkcml2ZXJzL3BlY2kvY29u
dHJvbGxlci9wZWNpLQ0KPiA+IGFzcGVlZC5jDQo+ID4gCUl3b25hIFdpbmlhcnNrYSA8aXdvbmEu
d2luaWFyc2thQGludGVsLmNvbT4gKG1haW50YWluZXI6QVNQRUVEIFBFQ0kNCj4gPiBDT05UUk9M
TEVSKQ0KPiA+IAlKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PiAobWFpbnRhaW5lcjpBUk0v
QVNQRUVEIE1BQ0hJTkUNCj4gPiBTVVBQT1JUKQ0KPiA+IAlBbmRyZXcgSmVmZmVyeSA8YW5kcmV3
QGNvZGVjb25zdHJ1Y3QuY29tLmF1PiAobWFpbnRhaW5lcjpBUk0vQVNQRUVEDQo+ID4gTUFDSElO
RSBTVVBQT1JUKQ0KPiANCj4gSXdvbmEgY3VycmVudGx5IGFwcGVhcnMgdW5yZXNwb25zaXZlLCBh
cyBtZW50aW9uZWQuIEpvZWwncyBzdGVwcGVkIGJhY2sNCj4gZnJvbSBtYWludGFpbmluZyB0aGUg
QVNQRUVEIGJpdHMgYXMgb2YgZWFybGllciB0aGlzIHllYXI7IEkgd29ya2VkIHdpdGgNCj4gaGlt
IHRvIGFkZCBteXNlbGYgYXMgYSBtYWludGFpbmVyIHRoZXJlLCBoZW5jZSB0aGUgbGFzdCBlbnRy
eSwgYW5kIG5vdw0KPiBnZXR0aW5nIGluIHRvdWNoIHdpdGggeW91Lg0KPiANCj4gSSBjYW4gYXBw
bHkgdGhlIHBhdGNoIGFuZCBzZW5kIHlvdSBhIFBSIGlmIHRoYXQgaGVscHMsIGlmIEl3b25hIGRv
ZXNuJ3QNCj4gcmVzcG9uZCBpbiB0aGUgbWVhbiB0aW1lLg0KDQpIaSENCg0KU29ycnkgZm9yIHRo
ZSBkZWxheSAtIGZvciBzb21lIHJlYXNvbiB0aGlzIGVudGlyZSB0aHJlYWQgZGlkbid0IGxhbmQg
aW4gbXkgaW5ib3gNCmFuZCBJIGp1c3QgZm91bmQgaXQgbm93LCByYW5kb21seSBicm93c2luZyBt
YWlsaW5nIGxpc3QgOi8NCg0KSSB3aWxsIHNlbnQgaXQgYXMgYSBQUiBmb3IgdjYuMTkuDQoNCi1J
d29uYQ0KDQo+IA0KPiBBbmRyZXcNCj4gDQo+ID4gCWxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMu
b3JnwqAobW9kZXJhdGVkIGxpc3Q6QVNQRUVEIFBFQ0kNCj4gPiBDT05UUk9MTEVSKQ0KPiA+IAlv
cGVuYm1jQGxpc3RzLm96bGFicy5vcmfCoChtb2RlcmF0ZWQgbGlzdDpBU1BFRUQgUEVDSSBDT05U
Uk9MTEVSKQ0KPiA+IAlsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmfCoChtb2Rl
cmF0ZWQgbGlzdDpBUk0vQVNQRUVEDQo+ID4gTUFDSElORSBTVVBQT1JUKQ0KPiA+IAlsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnwqAob3BlbiBsaXN0KQ0KPiA+IAlBU1BFRUQgUEVDSSBDT05U
Uk9MTEVSIHN0YXR1czogU3VwcG9ydGVkDQo+ID4gCVBFQ0kgU1VCU1lTVEVNIHN0YXR1czogU3Vw
cG9ydGVkDQo+ID4gCUFSTS9BU1BFRUQgTUFDSElORSBTVVBQT1JUIHN0YXR1czogU3VwcG9ydGVk
DQo+ID4gDQo+ID4gdGhhbmtzLA0KPiA+IA0KPiA+IGdyZWcgay1oDQoNCg==

