Return-Path: <linux-kernel+bounces-811354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34519B527F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F37B0E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B276F253939;
	Thu, 11 Sep 2025 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avA2ZYoq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9A24DD15
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757566603; cv=fail; b=cxuUtVwd5Is4djpVQKn+G7IR+uOM/WfVpS1WlprKjkWCvrAb0sfcOi00hJHs2LjYqZFsQ5nZIrexGjhNvxa62StGSBilXaGMHL+a7joo1L9rfviKcnkbIW7hb+1RvcwYs5Px5/Y4h/46DzUz+CnLyhGwAhvGidBDmo7xpbI23Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757566603; c=relaxed/simple;
	bh=ebl8cB41UAul3z0/Cxxr8UuRMxtjeX3HvwU0jEEJCBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qoxv5X++v08bH+TVQM0Dv904wgkIfbqkDN+Ojb7yjvspDHrSlGTOWpCdBOl3aC0aTvXZGEwiqsBCfRKLttQ0B+OPM8y/QSeDf8eHbQ2u9RsZ9zjcAZiW+lVUosj8wRQ/flOUy6anI+Q21MPXperEjFEdPR8aoBV8/nIBtKT3etY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avA2ZYoq; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757566602; x=1789102602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ebl8cB41UAul3z0/Cxxr8UuRMxtjeX3HvwU0jEEJCBE=;
  b=avA2ZYoqAJPQimO1syyXSCWptwbsUHbTpMfnOSgemPLFn4tntZSUdEro
   lhv2bDW6LEdLoIDHW7CoUpY7oegMFwR0qHfy1F3dcOU1FGwk7tv74kuVs
   GG8p7rHTnWn6uwfhePrdnWt6g+igsBhpgpU2CGKk/Ea1bagm4Xi+K0kRx
   Fcn95gPpIFz3eDoMeEVLkHZlWnEQzmRTkV11h4o5zakPH8hdTLksH0OZd
   oZ3Ik2AGOkVq8DcsINwukLbBx5P4sWmy/t4pLWq1Q1tewvq4gvr1T/Cpe
   xFVsdqfYPuPNNO1YC7ByZFoqtt9m43pZwTKrCYzTmhuPT99vFUF1/TwKN
   g==;
X-CSE-ConnectionGUID: sRm4zAMjSjmTTqXrq0Aefg==
X-CSE-MsgGUID: NiQISTF0SwaPzDqnQiZ+cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59953094"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59953094"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 21:56:41 -0700
X-CSE-ConnectionGUID: 3r+UuRyDSEiFetezNncGzw==
X-CSE-MsgGUID: g7Zc5bW6RSWBo3qGU8ksAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="172766624"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 21:56:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 21:56:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 21:56:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.45)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 21:56:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVq+VMCL04YJLtmH7oEiOM4Zz4V+vscyfukoTqWWOLJ7a0uElYEh3ulTAvdkBx0AQkbXjcnB85zRixNa7SXAijiMit8lid8AmGTuYf9yQkairwurWzVKgFNOLR9Vs6RT4sSwdLX33dn77FQ5hl1MFSeNGp6gWGqm2d/lGRSbXPgIOjEtkV+pZsKcRbThsEkP7ibAYtwhRLJp22hqgJZAJvI9hL8wz9NAYcRIGFjU5S5rrPFbDH+9uvKKJ9AvmbfNrhgjbaVXlmhDuFzN8/rqqH43oE/558LTYDugAmAqNzt6kv9zTdRZC8LhGWjUegzExtG5pNunov23mxRUtmsbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebl8cB41UAul3z0/Cxxr8UuRMxtjeX3HvwU0jEEJCBE=;
 b=nLmkEt8q5WQnnr53Nd6mcd7lZv6bRg7WtdWSgYy0joGPP+Amn4YJfDllaVoGIFU2KZ7EyyAbboDCItySIDtBWac5s+bpJmG5FzAvo5m/osl7R/H3+HmHSzX+mSwW1mTImFA7jGQNVa7swTcjOhgIYZPoNLXuP1S6HpzcaEvs8uzCec7z+6JB65W8nfV+mxrxI8nt/gwJtkkq4ZEsRqmCPG40u9pbSdHMlPGjcIwLnRK8OnQifufDVhN3uCc5LYAMEwEBeFvGec+cBWpDdgfr7WHCqdXuwoowiSlIKT5BksoD/y4WHE+L1+Q01RrMdHoc9akFMKeIw6b2ek5KxwRL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5525.namprd11.prod.outlook.com (2603:10b6:208:31f::10)
 by SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 04:56:37 +0000
Received: from BL1PR11MB5525.namprd11.prod.outlook.com
 ([fe80::1a2f:c489:24a5:da66]) by BL1PR11MB5525.namprd11.prod.outlook.com
 ([fe80::1a2f:c489:24a5:da66%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 04:56:37 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "bp@kernel.org" <bp@kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH] Documentation/maintainer-tip: Update Link tag rules
Thread-Topic: [PATCH] Documentation/maintainer-tip: Update Link tag rules
Thread-Index: AQHcIZGfbp0uoPDnnUeGwqsI5QwWD7SNbcCA
Date: Thu, 11 Sep 2025 04:56:37 +0000
Message-ID: <30015043cd7d5e4e74962ffa44ad2f1dd26710f7.camel@intel.com>
References: <20250909135119.10420-1-bp@kernel.org>
In-Reply-To: <20250909135119.10420-1-bp@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-1.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5525:EE_|SA1PR11MB8794:EE_
x-ms-office365-filtering-correlation-id: d9ba6897-8e28-435d-59fe-08ddf0ef96dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VU1ac1JSSExXN2ZpcUdkZHdJbHptR0xONnlKSStKWHJwTWhpY1plMEFmOHo1?=
 =?utf-8?B?bmp0ZkNKbTd0QlRrVG5vSEFvelRYclJyWlpXM2d1NWVydnJ4c1Z3ZnJweWhI?=
 =?utf-8?B?RElPMmptQ1gvSDV1UzBacEx1dkJiMDN3dEpWK0hjY0pna2tTVXhiNDRreUZm?=
 =?utf-8?B?WUNOYWJqaVZjYXhFNVNsRWJQUll2Y3BwUVRIc0MwV1BVdzIvL1llUktIRkt6?=
 =?utf-8?B?Y3FjeXVsaVJVWUdSdWt2YnpOVjVHcDNBdC9sOVFVcktuWUNZcEJVbUViUHYx?=
 =?utf-8?B?UHV2dUpNTjgwNlhLSzMzNVVLNkxYdVlzNzNnZkFwbUphdnR0VXM4VzYrNENu?=
 =?utf-8?B?RFdxU0ZHTHFGUEJPM2lFRld3VFB0eXAyci85WGZQOUc0ZUlUR1RnL2M1aytw?=
 =?utf-8?B?aU9QUUh5K0NDcTJVVkN2U25tOGdkaFFJN2dGL2VReHl5Uk5jQ1g0Wlg3RzBE?=
 =?utf-8?B?eFhDZnAxZlo0bUZJSXFuS05pS1ViQzlZSlVZS05qK0JSNmt3OWZlVnMreW5N?=
 =?utf-8?B?MmVNa0xnQUN4SHVFdkVUNTJzOW95RDgxQ1ZoSXUzUFFzak1LMDVXLzhtVDNQ?=
 =?utf-8?B?UUZvc0tkS3U3c1NIeHZsdEhzVzlkZ3FWeVE0WENGOTk5Z2grbitqT2FITFRu?=
 =?utf-8?B?ak1pL2VYZXFuNXVIa0hERUNLVmwzSXRxVUYxZ2Y0SEVTTk40MTRZYnpZdkFJ?=
 =?utf-8?B?Q2NRZ3BnWmdxeFREVk9nMDFaYjBzMkNuUisyV0h4MkZtMGptVTFDcDdhSXJo?=
 =?utf-8?B?d3BwNGZIa3g0cy9aUCtoRmpKT0haSzY5MWRFcDF1cEVveVhzMEZBa2dudHlS?=
 =?utf-8?B?cmhvYzdWblZ4MEExNmlObWszZ3A2K3FVdjlTcHdkVW9tUG5CeHE3NTBzdEtt?=
 =?utf-8?B?bW5FUjZXamhRY0plOFVJN1psTm5sZU5NZUZYR0xMWjVia2M4cDdOZUpmS2ZX?=
 =?utf-8?B?aHcwQXlqejNVUzA1anZhRmxvUzU4d2VnQWxMNUtQVjY5SDZnSkxaT3ZFK1VT?=
 =?utf-8?B?SXEwRG93c1FDSjJrbjMxNWFXSFlpZXYvR1VYREtyQXdhOWZpMW44ekJ0bWxm?=
 =?utf-8?B?cFJxY29jZko3SEtTaHVjSERabFhhOW5wZFV0enUwUlhMNFZWTXEzRmlrNDhP?=
 =?utf-8?B?YkovM0kvZjNWMVp3VjRJdkVhU01XaXdqQ0ZqTlVPVStHVllFME5DbUpvUkNP?=
 =?utf-8?B?a29TT09GSlRFM0pFWjMwNlh2SFV4ZWJIcVFlQW9oMERDdnRzcDRwdEFCaFhW?=
 =?utf-8?B?NVBHSGUzNDNNZmxVNDZkbWJ0M09MWWRXOE4vSC9QVlQvTHVDOHFIdnNnS3BQ?=
 =?utf-8?B?WFBjeE9LYzR0ZG0vcytLSVZzYUZtNzExVXVIcWlxTDd3MkR2TUJBQXdqWVZs?=
 =?utf-8?B?ODQwVzFIOVFDWnRmL3FET3ljdzQ1NzZMcHJKQ29rbGsvc3NLQWJsUFJnUFpl?=
 =?utf-8?B?QWhkbjcyYVh4aGp4UzFhNnBydUUvbGRtcTFqTnVrRVJHYzVodEQ4ejFwYTJx?=
 =?utf-8?B?WkRiMVFEQzYvbWd5SURtUHV4cURqTGM5OVlNYk1EaUZpaU1PVStNNWxHQkZI?=
 =?utf-8?B?TFo3NjBWZTlkTHFyVVpLL0JRS1J0bDR5cDRZZUxhUk9yNTgvTFBzMlJ2K2k4?=
 =?utf-8?B?elJ5NlRRdVVCaGFhamk0aVgvaldTZEFEcy9CbjFIVlFzTys5U25GVnNJSkt2?=
 =?utf-8?B?NG5DQjdweHEwd2dQVVd6WXcrelNjb1ZhMXprNVZPclY3Ym1iSXk0My9JZmha?=
 =?utf-8?B?aGNWdnhSemRMK2hWWGdWOGh5L1B6RjdJQ2JzaHp2SktWMXJzVUlNR050VnRP?=
 =?utf-8?B?dkVoOGRkdkdsbkNGbTNMSlZLU011Y2tMZWh5dU5BbS93clBaeU01Ly9MNFEv?=
 =?utf-8?B?ekRLRkJXWWVxSzI2emxWL2F6U2dJeVdvT2hBNUoxQmFwa2xZUTJ2Wi9NbHYr?=
 =?utf-8?Q?GqjWyB6gobkeSkmvA9AXrR41nEYUEEMR?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5525.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUMrSkpGWnlSUlJVeVpZd1NoMmt0SUxnK2UrbUc0bDdqdUlyMTUzR0NPbmpT?=
 =?utf-8?B?RTNRUDdXa2hYcWRYQWh1OTFKSXdTM1ZjaVZLM3BxZ0dNV3QzZEpDbGczMHNs?=
 =?utf-8?B?MysvYzlwekVPVlVKKzRhb1dvYXN4dTdmOTQzZ3ZmbEJJdTRTa3A2Sko0QVg4?=
 =?utf-8?B?TzJFWW0rVDhUcGtIM0JHVjVjSXJDcVpxYzQ1bk9FQWpVSUFhR1VmZVpDZWVD?=
 =?utf-8?B?bG5qeGJ2ZFBKNTREcWd1V1ZoZmVpcmI2UDBBM2FFREhOUERpUkQzOU94d1pG?=
 =?utf-8?B?VG9jYU93Y3lvQVl1ZXlJRWpnbmRRSkR0eTY0QVFXR216WTN2YVVBa3RaQlM1?=
 =?utf-8?B?dzRaS3NERUhFYjN6b0pFekNtVC9aTWFybC9CTVNUMFo1V0xjWW81Q3cyM0c0?=
 =?utf-8?B?dnphWEI4QnBrOWd4b1Qvc0ZjRm1MV2RIY0svclM1T1l6MVpPRXAwZmFzVVJT?=
 =?utf-8?B?VWRUa1RWU0EwUTNTOTZPMkdyeGNhek5IQVAyMjY3SUM2Q3lHQ0g2ZGZEWkgy?=
 =?utf-8?B?NlVVVDRoYzlNcFhpbHpQckVPRWw0OWZ2bytXaHZ0ZmhNVDNwN2dIa1JITG5k?=
 =?utf-8?B?NFVDWnQ0a1daRmJhdnFUTmo1eDRuQnVmcGNBdHNqRXlidllEbWJhUHl4OERp?=
 =?utf-8?B?bmFkZTJMUytNam13ZFE0QURUUHB2ei82SmNLV3RGVWFONFVCSDNhc2oyckxY?=
 =?utf-8?B?aHRYUzRyTnQ2SjRFRkNrY2k5bWRVSFZLMDJubitENFRpSDd2RjFRK2x5SlVY?=
 =?utf-8?B?MzlBa1ByRC9LYlFKekpjekhPUGxBVUlBRFBYb3NXYXl3NHB0RmRFdGxKME5W?=
 =?utf-8?B?VEVhUnVqQlJSNVZHYXZJQVU2aVdZblpYaDFSU1BsQkx0R2lKOGVONzlLWStV?=
 =?utf-8?B?MXBIMHVFemNNVWdpZFpKcWdOWU1rVFRWa2lNS0N4TTAreGpQTVpXYjBMVXJV?=
 =?utf-8?B?VE5Vak1Ca3MwUXNxVWZnbzQ0VFhxWXkyUEtwT3dTZ29Pa2RJNjlIeEdxWFhs?=
 =?utf-8?B?UG43QmJyUlBnQUs2dThjZWw4MkI0Y3pBR2ZGakJEeGFXbEI5TytrbEt2Ynox?=
 =?utf-8?B?ZHFaN0hQYUFSMmFtM1NPWG0yRUloeFpGSUFyZzRaY0J0Wmp2aXZxSDlUczlr?=
 =?utf-8?B?Ri91TU5IL2NJRGNHbFZtbUdxNnZnZE1UbVF0RnladHQ5N3QxMHZnNzBnaW5k?=
 =?utf-8?B?WWpidE1QTnYyN0tXM0YxS2JGSFFhaHpQTzRXWmg5RE5LczgzQnlGaVg1ZERP?=
 =?utf-8?B?ZitRTXlHNVhYRW03bndwUVYxb2NsRnF4S2FUVWd5RGlqclJNME9oTElEbEMw?=
 =?utf-8?B?ZHYrZ0RicEFoNWtCMHhyYUJpTmlrR3FDVkNOMTlzYWtEVnQxc2ZMejNpeFRE?=
 =?utf-8?B?SzFIdVdtZit4eVlGTzZwYTREV2pJbWlZUzZTV2l0KzBKSDRZakNKb3RxNWhD?=
 =?utf-8?B?T1MxQ1pRUEsvNDZtaWIwcjRaWnJUMEhKZVQ5bmNNU2FINllKMVFVbGpxMUVV?=
 =?utf-8?B?SFF5UGcrcjMxUzl2M2VidWliY3BBOUZud1VjTEd5TW53NmJTajhPbEV5bGI0?=
 =?utf-8?B?djVWZ1pweW1kNDkyUFVRV0sxRWRpRTRTcHUvWVdqNXplNVhPdnNla2o0d1Np?=
 =?utf-8?B?T3pncGJQRW9rVm0zSnZJUEdKOGRocmRrdkhrUEpHQ0hXQzY0KzJpOHJrSFhK?=
 =?utf-8?B?aEJLMGFPNWRyeEFBZW5JVXJ1YkswZ1oxTFVLUUsxdWFnZEJIZDQ4amdPM2FZ?=
 =?utf-8?B?QWFhT3VlVEVNNVk2RXZTcXVJSHlsb3U3VnQ5cjJjMEpnQndGVXB1ZE5yMFlX?=
 =?utf-8?B?STJ4M0VSdHdTMHVWY28ybXduc2NlcmowWjFKTG1iT0lDanR6V0d3MnIxZzBq?=
 =?utf-8?B?b0RlcnJjRXNON1UySktBM2pzbGFWc3hLYndGODJQUUNWbFFnbXBjTW1FVEFJ?=
 =?utf-8?B?bVZCQ0tPYVUwRS9qK2plNTd0OThkV1UvQU4vLzFLMC9iaFU4SkNGRTVRZ1pI?=
 =?utf-8?B?V25iQWpUV0dLMGJJbytINkgrS0dGUElwcWNQczh6OStHbXljMHlBU2F5ZnRw?=
 =?utf-8?B?SDczZVpHemM1R0psTlBSYnlzYUZHZjdQQ0FRZ2xsT2gzUGNCZ1dLeEFaVmdr?=
 =?utf-8?Q?HIQSHurmxQEuhxRtD+3mzAlTl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <388AFE3F29BC984E8E18F17CCDFEABF2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5525.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ba6897-8e28-435d-59fe-08ddf0ef96dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 04:56:37.5377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GGioRyRBmPsDea92y9Rh2ii4DIXoynFmyrBsEx4c6+BCYvfCelXibXm8z5cmniflTGFqJEHUxKcFdl7w16m1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8794
X-OriginatorOrg: intel.com

DQo+ICANCj4gLSAgIFRoaXMgVVJMIHNob3VsZCBiZSB1c2VkIHdoZW4gcmVmZXJyaW5nIHRvIHJl
bGV2YW50IG1haWxpbmcgbGlzdA0KPiAtICAgdG9waWNzLCByZWxhdGVkIHBhdGNoIHNldHMsIG9y
IG90aGVyIG5vdGFibGUgZGlzY3Vzc2lvbiB0aHJlYWRzLg0KPiArICAgVGhpcyBVUkwgc2hvdWxk
IGJlIHVzZWQgd2hlbiByZWZlcnJpbmcgdG8gcmVsZXZhbnQgbWFpbGluZyBsaXN0IHRvcGljcywN
Cj4gKyAgIHJlbGF0ZWQgcGF0Y2ggc2V0cywgb3Igb3RoZXIgbm90YWJsZSBkaXNjdXNzaW9uIHRo
cmVhZHMuICBEbyBub3QgYWRkIGEgTGluaw0KPiArICAgdGFnIHRvIHNpbXBseSBwb2ludCB0byB0
aGUgbWFpbCB3aGljaCBiZWNhbWUgdGhlIHVwc3RyZWFtIGNvbW1pdCAtIHRoZSBMaW5rDQo+ICsg
ICBzaG91bGQgY29udGFpbiBpbnRlcmVzdGluZyBhbmQgb3RoZXJ3aXNlIHJlbGV2YW50IGluZm9y
bWF0aW9uIHJlZ2FyZGxpbmcNCg0Kcy9yZWdhcmRsaW5nL3JlZ2FyZGluZyA/DQoNCj4gKyAgIHRo
ZSBldm9sdXRpb24gb2YgdGhlIGNoYW5nZSBvciBhbnkgcmVsYXRlZCBzaWRlLWRpc2N1c3Npb24u
IFNlZQ0KPiArICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9DQUhrLT13aDVBeXV2RWhOWTlh
NTd2LXZ3eXI3RWtQVlJVS01Qd2o5MnlGX0swZEpIVmdAbWFpbC5nbWFpbC5jb20NCj4gKyAgIGZv
ciBtb3JlIGluZm8uDQo+ICsNCj4gICAgIEEgY29udmVuaWVudCB3YXkgdG8gYXNzb2NpYXRlIGBg
TGluazpgYCB0cmFpbGVycyB3aXRoIHRoZSBjb21taXQNCj4gICAgIG1lc3NhZ2UgaXMgdG8gdXNl
IG1hcmtkb3duLWxpa2UgYnJhY2tldGVkIG5vdGF0aW9uLCBmb3IgZXhhbXBsZTo6DQo+ICANCj4g
Kw0KDQpUaGlzIGxvb2tzIGxpa2UgYW4gaW50ZW5kZWQgY2hhbmdlPw0KDQo+ICAgICAgIEEgc2lt
aWxhciBhcHByb2FjaCB3YXMgYXR0ZW1wdGVkIGJlZm9yZSBhcyBwYXJ0IG9mIGEgZGlmZmVyZW50
DQo+ICAgICAgIGVmZm9ydCBbMV0sIGJ1dCB0aGUgaW5pdGlhbCBpbXBsZW1lbnRhdGlvbiBjYXVz
ZWQgdG9vIG1hbnkNCj4gICAgICAgcmVncmVzc2lvbnMgWzJdLCBzbyBpdCB3YXMgYmFja2VkIG91
dCBhbmQgcmVpbXBsZW1lbnRlZC4NCj4gQEAgLTM4OSwxNSArMzk2LDYgQEAgZm9sbG93aW5nIHRh
ZyBvcmRlcmluZyBzY2hlbWU6DQo+ICAgICAgIExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3NvbWUtbXNnaWRAaGVyZSAjIFsxXQ0KPiAgICAgICBMaW5rOiBodHRwczovL2J1Z3ppbGxhLmV4
YW1wbGUub3JnL2J1Zy8xMjM0NSAgIyBbMl0NCj4gIA0KPiAtICAgWW91IGNhbiBhbHNvIHVzZSBg
YExpbms6YGAgdHJhaWxlcnMgdG8gaW5kaWNhdGUgdGhlIG9yaWdpbiBvZiB0aGUNCj4gLSAgIHBh
dGNoIHdoZW4gYXBwbHlpbmcgaXQgdG8geW91ciBnaXQgdHJlZS4gSW4gdGhhdCBjYXNlLCBwbGVh
c2UgdXNlIHRoZQ0KPiAtICAgZGVkaWNhdGVkIGBgcGF0Y2gubXNnaWQubGlua2BgIGRvbWFpbiBp
bnN0ZWFkIG9mIGBgbG9yZS5rZXJuZWwub3JnYGAuDQo+IC0gICBUaGlzIHByYWN0aWNlIG1ha2Vz
IGl0IHBvc3NpYmxlIGZvciBhdXRvbWF0ZWQgdG9vbGluZyB0byBpZGVudGlmeQ0KPiAtICAgd2hp
Y2ggbGluayB0byB1c2UgdG8gcmV0cmlldmUgdGhlIG9yaWdpbmFsIHBhdGNoIHN1Ym1pc3Npb24u
IEZvcg0KPiAtICAgZXhhbXBsZTo6DQo+IC0NCj4gLSAgICAgTGluazogaHR0cHM6Ly9wYXRjaC5t
c2dpZC5saW5rL3BhdGNoLXNvdXJjZS1tZXNzYWdlLWlkQGhlcmUNCj4gLQ0KPiAgUGxlYXNlIGRv
IG5vdCB1c2UgY29tYmluZWQgdGFncywgZS5nLiBgYFJlcG9ydGVkLWFuZC10ZXN0ZWQtYnlgYCwg
YXMNCj4gIHRoZXkganVzdCBjb21wbGljYXRlIGF1dG9tYXRlZCBleHRyYWN0aW9uIG9mIHRhZ3Mu
DQo+ICANCg==

