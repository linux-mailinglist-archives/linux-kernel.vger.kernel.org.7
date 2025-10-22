Return-Path: <linux-kernel+bounces-865221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F761BFC8DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A971888AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864234DB5D;
	Wed, 22 Oct 2025 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKohyauB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AAF337116
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143190; cv=fail; b=F+4IKKhYlWt/XV5qJoQoGyyWwAry8Y077JA5lrCbAKdv+BmIyipjLKAckiLDZ2wg8aWc52tY7PGJAp29TfOzf6gO1v/Ev71b3jBu5UjxJn+hcVGMnh5OaIpJKxsUUPqZwSYH4AhACSpR7LmpVYgf6pPDD2G6mF05NMbTxq6hw1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143190; c=relaxed/simple;
	bh=OPpOoT7vl77YkyvJVjCDDqY3PzzooirNc91neFsp3MI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h8WHneqvZX0svY5jo200RtC43+UJqjn184tmblVoffVvK6Hib81HOhfipFexipWl1i+xw07DrFlz7puNTL1RdFdBO9LXeKfDpNYMjZWTMpTuYT9UgR5uX03W7ecxg3mNaRtZExlYfh/FAn23ebt9QWzUrGPxz6nSw5IEheVyPmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKohyauB; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761143189; x=1792679189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OPpOoT7vl77YkyvJVjCDDqY3PzzooirNc91neFsp3MI=;
  b=SKohyauBFncX0WpMAswd8t4PsoQBxl6SU/npwiE5qZw0qrYK3YqnC+hg
   31oWXy83pU2+s7DGHnrZGbEmvVHEGGnPLSJRFijc7A8+rFEWb9wV3UEqv
   78wWhL7+ggmSr3SCaSDPTBrMIKlmvs290Q2ugWsnutMIxYSu7rLk3FX9v
   8l4MaRmAepfpyWBbJs5rXj55kPf3/+tDgvd1ytjSlh45sdu8feSg7M5G3
   5TTFOdiYsmroKxsVfIHNSahnGdiM8rTLls/Vbu95ISJjjLfEgH0L3wW4A
   IDuGFlf1Mm31RF923jHC60V5hNgsUtDYzMcQKck8Vvw/J1HOIj2PAtSRO
   A==;
X-CSE-ConnectionGUID: ZKfJCU7lSHG93/uGbeh+LA==
X-CSE-MsgGUID: XcrmItZIT0+NUYbjjyikYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80730220"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="80730220"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 07:26:29 -0700
X-CSE-ConnectionGUID: v6sVH72eRzCKfncAA7KA+g==
X-CSE-MsgGUID: izXN1pa6R+uylh8+WRwHAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="184285930"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 07:26:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 07:26:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 07:26:25 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 07:26:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWzV0h3mAl9eEq/J2mOuQjB/SfGrCsqTJ698ePxHYmFF4xc1yXyQ7YDw5L+viJoiJaDZsubMOYYCxn/P1hl71qCD6cprAVGFaqw8gfaj7a8IKmE6WAq0vuqYRaX8FSglP/mwMw6PpKr0sMKrOknjKvYX98SLacjclUcvUuTssdpW20/mjEKdAxaLJmsvfe5Y7qGHXi0HvTxiYArHhxVONGAxsfgrplIakvIllh/PLYwRy9abd+Qn93UAnDpfMyluqI9sNiOyDC1sE2XJFY1Wee4SD4oBA9cx7nCc3TU7677tieGuejxe6063TaYYZHtLIX3WGeJikxUtrOijSw1fRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPpOoT7vl77YkyvJVjCDDqY3PzzooirNc91neFsp3MI=;
 b=XyhaHgig7PKEBogCj6PsKqbrHVUhftchLHKkmAtPeCBGF57PcqMpahwSpz3pKu0yWxLl8j8/yaee/aq8tFp8hsvqZUpX9gCTFN/KV6b5us6H4ZJMdeDRLqTaWHO/jG0O8Z6lxs1bQXZSlbQTS39hsxSIs3oVBL6hS7FAt6hbo2lsNvw4clje4s9ZxJVOpxq8YEyKZ733eAHXXbNgk0IjY+wTx1IzZVdwASs8Drcukk2VXLOkC8V9KBpamJx5BeF/XuL/uVlVvcKDjMFJ+FEsyAQ+jbrjectB8BMKFQf4oj9ItF5gBkUp+j+dgyezsiy4ZP7AKrFwsQZDVaTAXCbrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA1PR11MB6613.namprd11.prod.outlook.com (2603:10b6:806:254::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:26:23 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:26:22 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, "Abliyev, Reuven"
	<reuven.abliyev@intel.com>, "De Marchi, Lucas" <lucas.demarchi@intel.com>
Subject: RE: [PATCH v2] mtd: intel-dg: wake card on operations
Thread-Topic: [PATCH v2] mtd: intel-dg: wake card on operations
Thread-Index: AQHcQolvORGnd1sEf0+OYSMjpAJgarTN8lr+gABHU9A=
Date: Wed, 22 Oct 2025 14:26:22 +0000
Message-ID: <CY5PR11MB6366CDF16D135064955D3842EDF3A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20251021123246.3629282-1-alexander.usyskin@intel.com>
 <87wm4ns10j.fsf@bootlin.com>
In-Reply-To: <87wm4ns10j.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SA1PR11MB6613:EE_
x-ms-office365-filtering-correlation-id: ac3f2665-fd8d-4890-9b4f-08de1176f9c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UEtIWWF0TWhDZGNodExtQlJTZnZFTnI0ZlpBWnRsd0owemNoV0FCM28zMlVZ?=
 =?utf-8?B?Sjh1M09BaU5LdVJOcGwvTG9XOTNvTCt3OVVRYmdzUWZaZDc0WWVzWm9ETUF3?=
 =?utf-8?B?YzAvUFQ5eWc5ek5qa1BKSWhZWldhODRROTBiZ2NZSmtEOVZuU1U3ajdwNTYw?=
 =?utf-8?B?eExuYWFxeHNzNU9zRmJsZmR0ZXpXUE9yYnl2bHFHNmRlWkI5aklXbjgyTmlQ?=
 =?utf-8?B?MkU5MnV2b2JjSms0cm1wNlBFNXJnWXlpNmlqMEVKcWdmMUEreDNEL3YrSUNN?=
 =?utf-8?B?SWtQdjg5UWtOWG5KZVNtN2NNT29MUlJUZk5kSmFtUTUvY3dKaEw0dS9FR3Fm?=
 =?utf-8?B?ZGNKVGRrUi9lSnJjNndTeTB4T1dNS21yWWZWdjY0ekc0a1RBS2pjRmhtMWds?=
 =?utf-8?B?c1lEZkVtaFpvdStyQUJxYVhJd3VxbFNvZS9oYkVNYWptTWlBSGd2R3hJaEFm?=
 =?utf-8?B?MmhBdXBIZjlMblFiMkI3cHBUMDdsUFJIK0ZoZjFyNFRTU0FmeXJwT3RxNnMw?=
 =?utf-8?B?S25tZ2JFVklzY3pyN2JSMVI2NVZzVkMzOEtUUVVpQVB6Qld0L29RNW5yVTlp?=
 =?utf-8?B?RVU4bzBKR3QzNnJtdndLUnJKeTFGQ1VVOWJLdjZrblJwVEt2TXRBTFd6QmVl?=
 =?utf-8?B?NmRlaktKMUFlWmMvMHdBdkt2NmQ3OWJubHk1S05WQW9hWWt1bWFFSmFxaW82?=
 =?utf-8?B?cnhCQ2x3dGl1dEdSNmlBQ0ZCTmQzM2pvcDZESmc4TGY1Ri9EREk2cTY3WlJ5?=
 =?utf-8?B?RjE5c05aNUhiZ3VGdnVxWnk0R1cwME8rMFpId2JCOGs2M0I5Sm11Tm95VHJv?=
 =?utf-8?B?OUlsV0hwY2tjdzZWRDRQOWJYR3NIcWZNenZWT3FMZUJUUE5hWFc5eTZvcXJh?=
 =?utf-8?B?d3Yrem1wQm9mT0FCVlBPT0xBWmswR21uN094MWhPKzRTd1FVejZrM3BHY0lz?=
 =?utf-8?B?VWU5OEVsb1R6SDhLTUg3Mlh4cVZkbmFXVzhrc3IyUGFObHdsQnF3YkJjMFQ4?=
 =?utf-8?B?WEJ1SjM5UEJ2WEt0SkZRVXp4VzB3ai9oYXliTlVld2hxS05DOE5GUjR2bDlH?=
 =?utf-8?B?djFMaURaT3o0aytaa2VjUWxIQkdORkw2bHQvaXdweHNrMHViZlgwelh0VFh3?=
 =?utf-8?B?N3FJVlM3elBDcGpoNktldkNUUXlmZ0wxQlNmSWZVaUFtM2gwbE5ldTcrQ3Aw?=
 =?utf-8?B?OVZYUks2emV4QnRWSWtrcWVUN2J0NHRYM3lVZ3M0UEgrUXdiVjhoTkJXWDNQ?=
 =?utf-8?B?TG9CTGY4VkE4c0pnOXhQSkRvam5zZGxYRmtuVnRGc1RKM0tncDZFNWJ5VlBN?=
 =?utf-8?B?OVZRbFIwYmJPREJVUU43ZlFTZnVrQ1BqWXZDNmhWOC9nVjM3bE1LemNRRDhz?=
 =?utf-8?B?OGYvWDRnNU1KelZQTHhDN0lIUlJpYStYdC9jc0g5a3V6WjVUTnpLa2xiVzFI?=
 =?utf-8?B?bG0yalZPdnRqZjJQcmRTOERtalRkK3IwWVNjVWk1UlhyNnh2MlhSZU4wdU9T?=
 =?utf-8?B?M0F2Y1ZmellJVlM2KzVTbE5kc0E2QjFSeHpJeVViS0RvTStzbUJDekM2bDZv?=
 =?utf-8?B?bWdIdm9kMkEzaEdSYzRQRGFEa1NpOHN0b3ZKdkZSZEcrYkVXT0JlZCtwUU5o?=
 =?utf-8?B?KzJtQXZmdFQ4SmI2aHZJcjhsNkJqYlRmaDRJOGpBRXBWR1lwSndHdjdSRlZQ?=
 =?utf-8?B?ekRLTFB2TXE5N013cngrWUg0WTFNQ3RkK205b1NudlNxMEVKdHFvd0UrdjFs?=
 =?utf-8?B?SUNTR3FzcE4vazBKbUJRb3VpMWw3YzVoSk5DdS9xSVNOc2g0ZFZsb0Exajkx?=
 =?utf-8?B?MEtoUDFMZ0ZPMkw5bFRtUHYwUkFIV2V6T1RQRUdkNDlRTFNQTCtwelQ4YUlV?=
 =?utf-8?B?OWkwUWxxM3dVRStCV3FjNmdyZ1BsS1NpcDVXYVFmcHE1TnlHaG4rdHlEdzlj?=
 =?utf-8?B?Q3V0NGh0NVd3Tm11RW5tNFR0Tmp4eTRVVkZ3TERLTjNxRXpNbUMxYTRDTzg4?=
 =?utf-8?B?Z2xsZlRveTJaYWxaVm40WnlQVHR6NXV1Z1pEcTZHUkEzOXlNNGZHQTErdmtV?=
 =?utf-8?Q?gIxZiB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGZrblJOcThHOHVGUXZFNS9nT0NvczB4WFZQMGxMZmUzeStvUHdnWTZUOFJm?=
 =?utf-8?B?NE1SMGErMUNueHh1QUNmeVBxdEF2cklSWnE4Z1lka1hKS0lXYmR3aHNkMWtx?=
 =?utf-8?B?Nk5BZFVnSmx1VzMwQklKUEhqQ0JKSC8zN1crZ3U2Q2hDa3hrT3lSV2g1T2pu?=
 =?utf-8?B?WGYzU2YyWUFpa2xlTHhmOEFXUG9UMUhhbzJySGdCUjI2bWRUdTVSbE1ncTJV?=
 =?utf-8?B?MzZPUktaZ3RKRGhTVE55clpZbEJjaEZIRVk0dUlXRGVid0dEZjlBUG5zb3BJ?=
 =?utf-8?B?SVV3Yi81dDJlRjRWd1pOdkN2NWVYZXp3SkliSjJMRTUxZm5kZ0R5UjhiZzhM?=
 =?utf-8?B?dGhLdjVEWUprSS9TZU9WOE1BUFYzQzhKdFJvL2JpYmlybTBINVh1YmNhKzVw?=
 =?utf-8?B?byt1Y0tDcjJKY2dNSk5tMTFsbDU1YUdMYVA5cXp4a0JCMDNBOWdPRkM0amRT?=
 =?utf-8?B?VkUvdk4rWC90alk2RVZtU0NsaUx1eUtuUFVzejJvTFRpcFE0M00yeDlGcHBy?=
 =?utf-8?B?MitqR2pqcU1GenN4cU9mTFZGOHEvTFM3bkpvVzBJSTFPKy9wZTZGQjZvRmtr?=
 =?utf-8?B?bEp6OTNneW1sZ0hTcnVRT1pvQmpCTll3dmdPRHo0NHdKVEluMEdOT3NldmJh?=
 =?utf-8?B?T3U5MUVMa3RWazNVWS9NYnZocjNUVUlwMUU5dlFPaTJwbjBVbFF1TjFCcmpE?=
 =?utf-8?B?dlk1WHVPeEljcDlhOWROS29OYXEzTTlWMDQrK21UWjJWRExJTkFrUlMwWUh1?=
 =?utf-8?B?YnkxVDJ6LzZUYUJ6a0VGcEpQU082czBsSVZvYnJtdjFIUHhRd2ZzSVRacWl1?=
 =?utf-8?B?VTdHKzFGSmdwSHUvb3VoY2o5aVZKMzh1elowM3ZzMWcxRjBvTWRweFNFUG9l?=
 =?utf-8?B?aGR3cGdGcXVIbEtWY21Pd2doaFU1RzkvbEltb0lGNUFRYXZ0RWpHTG53U3J0?=
 =?utf-8?B?NGxKdnVZZTRubWtDZTlsTXpNRmMvTnhPdmNJWnVySUVsT0hPeFV5V2ZNbEpv?=
 =?utf-8?B?Z1htNEpucmxQb2lia0lXN213NEkydGpHWjlxVGxSTWdzZGJVakl5bTJVK3pl?=
 =?utf-8?B?NWhBZFJFTHN5aHg0dWlpYklmcHFaL1poUzZ6aW9BSVFrYWFyL0p6ckpLY0ZS?=
 =?utf-8?B?bFhraHZWZ3Q3ZUFleUNhN3pST1NONlFlQ0ZmNTQ3NmpqZDhaSmNOMHVFMUtM?=
 =?utf-8?B?SFRndjNPZGZydEh2VjNLOFJCWWwxNzFXZWJNME9YSjhUU3dmUnpRcStWL1FW?=
 =?utf-8?B?VDZKV3dleWpPRnRyMGNleVNES0d0UFNTbHdRdHpsUkp0SExnd2s1c01Cendk?=
 =?utf-8?B?YlU1RUw5VnJOWE5jRy9WdnErNXdlUHNrNWhxZ3hBRlM1ZEw5a3AvREV5NTAv?=
 =?utf-8?B?NDlhT1FBVEtNMlR1dkx0NW1KOTd2QVZWQnFDVzVibHM5SmNFb3hPYk90OGJZ?=
 =?utf-8?B?Rkg3WkdQMTRMTDEvTE1RZWNSOUw3NVVsUElKYUFkdCtGQWIvOWljY3d6MlBq?=
 =?utf-8?B?S2ZOR0lsck9taXNiN0U4RUlxNE1xQXJaanhCN0JVb0dVUS9CMUtGSHNYTDFr?=
 =?utf-8?B?bkI1VlFxUlo4aWNEMzFUTFV1R28wRTFCWHJKMkc4eGlOTjRWVUlXUnVCai83?=
 =?utf-8?B?bFlhOEt1b3BQWTRHLy9RWVZKdkpaaEN0V2NkRjE3YnNvNDFWNFdwOFE0RmJv?=
 =?utf-8?B?d1h5TlhMRzZIQTE3Z1VaU0R2Z0JTbi9NcDZDRDc1bUJUdGNGZXFvUnU4bldj?=
 =?utf-8?B?d05RaWhGeHpTMW5NVjhvUGV3Y0FPM2pKN3hiWlJPQm4wVnozK0QwblpYWGhH?=
 =?utf-8?B?SDFLeUNrSHpNWWxRYks1RGh3c3MrZ3ZoTUVKd0tndVNYZjhjcFY5Q3FpNHJG?=
 =?utf-8?B?czQ0aTRkclZ2a3lkeGdIRnlnK0ExRk9xRlhBZWU4TWxYOHp6RExvd3dnRk9H?=
 =?utf-8?B?T3hJOWd6VWZPYmhmUXR0Y0h5RGNxQ0h2VE45dEhlemVjTTUzMFBnUHU3MnJQ?=
 =?utf-8?B?N2NnZjRKVVdaWnBRb0ZHdGNpN0JvUGM2NXBETkRVenJnc01yZFkzMm9pSC9p?=
 =?utf-8?B?bFhLZUJOdWZ5TDBzZ0VDenZ1TmF3QVFsRURTMlNaQTJMbjEvZHp0SU1TWFV5?=
 =?utf-8?Q?P+SodOfyTaNuzlr9IetgxFuSH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3f2665-fd8d-4890-9b4f-08de1176f9c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 14:26:22.6460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFWv7Ix3VF/5brs/LPZcRDpbrDOghaTKAUse84u/s/6EAg5iU2EiTE9W0dTUf6oIOdarYHyNxpztdfX3jdQv9o2UcVS0qixIcTGjFM1t9wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6613
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBtdGQ6IGludGVsLWRnOiB3YWtlIGNhcmQgb24gb3Bl
cmF0aW9ucw0KPiANCj4gSGkgQWxleGFuZGVyLA0KPiANCj4gT24gMjEvMTAvMjAyNSBhdCAxNToz
Mjo0NiArMDMsIEFsZXhhbmRlciBVc3lza2luDQo+IDxhbGV4YW5kZXIudXN5c2tpbkBpbnRlbC5j
b20+IHdyb3RlOg0KPiANCj4gPiBUaGUgSW50ZWwgREcgY2FyZHMgZG8gbm90IGhhdmUgc2VwYXJh
dGUgcG93ZXIgY29udHJvbCBmb3INCj4gPiBwZXJzaXN0ZW50IG1lbW9yeS4NCj4gPiBUaGUgbWVt
b3J5IGlzIGF2YWlsYWJsZSB3aGVuIHRoZSB3aG9sZSBjYXJkIGlzIGF3YWtlLg0KPiA+DQo+ID4g
RW5hYmxlIHJ1bnRpbWUgUE0gaW4gbXRkIGRyaXZlciB0byBub3RpZnkgcGFyZW50IGdyYXBoaWNz
IGRyaXZlcg0KPiA+IHRoYXQgd2hvbGUgY2FyZCBzaG91bGQgYmUga2VwdCBhd2FrZSB3aGlsZSBu
dm0gb3BlcmF0aW9ucyBhcmUNCj4gPiBwZXJmb3JtZWQgdGhyb3VnaCB0aGlzIGRyaXZlci4NCj4g
Pg0KPiA+IENDOiBMdWNhcyBEZSBNYXJjaGkgPGx1Y2FzLmRlbWFyY2hpQGludGVsLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgVXN5c2tpbiA8YWxleGFuZGVyLnVzeXNraW5AaW50
ZWwuY29tPg0KPiA+IC0tLQ0KPiANCj4gSSBhbSBjdXJpb3VzIHRvIGtub3cgd2h5IHRoaXMgbm93
IHdvcmtzLCB3aGVyZWFzIGluIHlvdXIgcHJldmlvdXMNCj4gYXR0ZW1wdCAod2hpY2ggaGFkIHRv
IGJlIHJldmVydGVkKSB3ZSBoYWQgdG8gZG8gYSBsb3QgbW9yZS4NCj4gDQoNClRoZSByZXZlcnRl
ZCBhdHRlbXB0IHdhcyB0byBhbHdheXMgY3JlYXRlIG10ZCBtYXN0ZXIgZGV2aWNlIGFuZCB1c2UN
Cm5vcm1hbCBkZXZpY2UgaGllcmFyY2h5IGluIHBvd2VyIG1hbmFnZW1lbnQuDQpIZXJlIHRoZSBw
b3dlciBtYW5hZ2VtZW50IG1hbmlwdWxhdGVkIGRpcmVjdGx5IG9uIHRoZSBwYXJlbnQgZGV2aWNl
DQp3aXRob3V0IGludm9sdmluZyBtdGQgbWFzdGVyIHRoYXQgbWF5IG5vdCBiZSBpbml0aWFsaXpl
ZC4NCg0KLSAtIA0KVGhhbmtzLA0KU2FzaGENCg0KDQo+IFRoYW5rcywNCj4gTWlxdcOobA0K

