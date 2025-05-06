Return-Path: <linux-kernel+bounces-636604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B693AACD8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 20:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726314E6336
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 18:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626C2868A5;
	Tue,  6 May 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvO/JuTU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA36280038;
	Tue,  6 May 2025 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557572; cv=fail; b=kAEWqZKBCZOS1KwEeFeq8sXloPtUFUv0EayavNka0i3mt2bYuHG303OQEcTD0wuku1AhiPmWYKAWbz3PA2Jruk7KJpIsw5lYQr9QY2G31/OjoHUVouVr0CLuSxEwRQQbwaOgi7G7MdqJI3a/GtFIVYWExvqmun9jGTgxIcvMJnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557572; c=relaxed/simple;
	bh=FhKsa/O71WXT+pqAGjCCNB1k69WkLs/HV/tTE5YhcP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kLTn1kNfWb1VvW/MJLZgHL9IHG1rwgXuZLI2jXlda5ZgtP2dgm9cBGQJ+hOgKNcMYFg0yPfO9O946Avwu4i1myZMhVe2QNYXamZuMLIbx4bTKUp2QbCZ6INhtxKkgzhPFwmzWsu7UgMmSqbbXCTEd1bI+CSE65M4tyu+SYVohrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvO/JuTU; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746557571; x=1778093571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FhKsa/O71WXT+pqAGjCCNB1k69WkLs/HV/tTE5YhcP0=;
  b=WvO/JuTUZ18o/SVQaEcJ2JSGAJvn7L9WMofF9Aszp0FhR2PmuB+GIlEu
   CRRn0wpfqx5LtS3ozYjRTCij8iKTleZLYTIb8OLWr0LICm/nNz7pld+fk
   53IlFzFhexMSCXYJkCb7r8sBSHArq/TgFJNMWNJ7AbJDkimsubk/q7jfV
   mvSpv6kFdz9N5t3tvqccp/L4lhqxEOyy0zJEFLXqawuBMbe/Q5FuR2EbY
   vMg9znd4Q4sabu4hNvvbmGqJAfLpc8CaKfrhl47VBRo2eTGsnEhEQralq
   ixFjfniA4/LXUqR9flfh+gVbg5nqbnfdbUcyf+w2fwO2f/bAw4Wdv0lPS
   w==;
X-CSE-ConnectionGUID: BDARmJr7QFmp74i080bUUQ==
X-CSE-MsgGUID: paYh+L/pRHum8SmNaMbQXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52067699"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="52067699"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:52:50 -0700
X-CSE-ConnectionGUID: v4yf7UtqRbaADxIuGt+ReA==
X-CSE-MsgGUID: JFZ9W8v2T3Gg/JvxxJWCuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="159004862"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:52:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:52:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:52:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSadvsQdvjOrpOe1Kgb6lUtyo/yaL32stkYZzd39SzMTANVGJpOsoaIx86fWVoxgGYknI3dn0hHKH6v2AxDh/iZva4a7qv7YgNYfZDmuiJekNijs6GzhAgifoT7MgsOHJzM6ig7CNtJlkdK4PkoUCiXRbr/3bCb1ppeE9jolk+TKm7WmJ2NqKEib6ss5qN7iwjw3Vhq1UZB84vPZ2wrNKcJQ1X8iM6XEbk5TqhBqlwohjSAi0tc7+ijbQrK4XrxX7/B65EP33mTQ6gEjk3m3BlE3kd9POma/ilPb3F05tWskjGgfyp+EwQuG0owuEQdbmrKzEgg0IcTUoRBReyicwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhKsa/O71WXT+pqAGjCCNB1k69WkLs/HV/tTE5YhcP0=;
 b=KuQyfv7GDfTqmgWS/4S+cia+dUhGUU0nvA+pjmcdpjhtFzbYyFenu+S/eCmi6tkV89WjIywj0tklkxyCEGhGLpwWuMS8A+Dvm+UTKQ+rhwwzzv9jubKJfZREDj0kTtXURROqZ4fo/zJVNRGrMYosDkQcff0WuCabE0WZb4RfR0Mz1QGqG7wr9PLPN7gisSmVOOJLyc54Ke/QWh4NdkVzNRg1Dy/Z3MLu23ixJObyge1cvadgvgHi1fiCnLH9FcQGEPMaBz1ZL+jr+RY22XzNgMV7EmNzCg0KGiFAAxq3ovYt1eGi311HnbSy66/ArenoNKsIgFDNEUjQpf5VmICVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by IA4PR11MB8990.namprd11.prod.outlook.com (2603:10b6:208:56b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 18:52:43 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 18:52:42 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "acme@kernel.org" <acme@kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"irogers@google.com" <irogers@google.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>
Subject: Re: [PATCH] perf top: populate PMU capabilities data in perf_env
Thread-Topic: [PATCH] perf top: populate PMU capabilities data in perf_env
Thread-Index: AQHbusi8bCHGoKc1VUKR+vojmANVi7O+MekAgAAMuwCAB45PgIAADQQAgAAgjoA=
Date: Tue, 6 May 2025 18:52:42 +0000
Message-ID: <644107dbbae586096302f0bdfabd90955322bd2c.camel@intel.com>
References: <20250501184143.873536-1-thomas.falcon@intel.com>
	 <CAP-5=fXorDgm-oJS9kC6cxCEvS9-Gz5Uh_5V4MtzCYV3pXAxCA@mail.gmail.com>
	 <6732ac7aad986d682c6a36db5d435b113c7527d9.camel@intel.com>
	 <4aa48d010cdaa91355f9f77b1c3a1eefc4b1becb.camel@intel.com>
	 <aBo_KvXDmsequWng@x1>
In-Reply-To: <aBo_KvXDmsequWng@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|IA4PR11MB8990:EE_
x-ms-office365-filtering-correlation-id: fccfb05a-764d-47e1-299b-08dd8ccf2ebf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V2ZLZUhXMllNNjhlREZWTUlBTmF0K1FDbVl0QkZnd0I5eGxLWVRqT0NsS2lx?=
 =?utf-8?B?S3gySHBtSkFqSCtpQ25tRmxRT29CM0dReW5PZjhnWUx6T2NsWEgzVkFJZUwr?=
 =?utf-8?B?SmdKOFpGNytEcjRBZ0RGNG9QWTk4TnNOVU5NSlRzejkrenNTMUZ4ZERFVHhs?=
 =?utf-8?B?eko3UGs3VDBQN1oyRGRSeHo4YzcvL2h0RXBBZEg5YldBc1NJWTM1UDFRV2p3?=
 =?utf-8?B?MEFNcFVTS3RrZTkyaEJPaG1uRnlUalAyT2FGZHEyUlkwclBjdjRCY2dKU1lJ?=
 =?utf-8?B?VTlLR3dCRUh3YW5JcDRHeU95a054N2RERUhDczB6cTBYd1NLdko0NFhBSjhk?=
 =?utf-8?B?RDFEN1NBU0RSQkd5YWtCTWluSXd5MnVURUlTSlNaMjV5Mk5wRmtoWUtWYkEx?=
 =?utf-8?B?Vk8va04zdWowTTB6SlgrS2FrS0NBaXM1WUUwdWRrc2t3MFNqMXowSFlWbGVm?=
 =?utf-8?B?VEZRY0NYNXJGWjFrTGlsRFBLY0lJUFc2QjM3UlBqc0Z6MVRDYXhDQllER2Y0?=
 =?utf-8?B?UHN4MU0yMlQzbmh4WGxKWlRhQkdtekRUVUVaQmszaGptVXFqaTZhblQyVGlM?=
 =?utf-8?B?ZjdNdmVHWHBzZ2w4cEVCWk9FNU11ckhyV29kb1NseVpPU0JxVnJUUURYMGJT?=
 =?utf-8?B?RHdYdDlGcldmeStKY3p5eHUzdTlDTXZXNWpUcEtSUU9lTTlqT25XM1JreGtZ?=
 =?utf-8?B?S2lqVkhPMVJWalRGcnNkM3k5blM1UXZxODQ3NVBEYitLMHdpY25sNFpBOVlG?=
 =?utf-8?B?SlViOVA5d250V1JJdktzWWwvWENOSFZ6TEJuRjc0Y1RVaGNPR1F3ejc0SzFB?=
 =?utf-8?B?bDZ1VXpMSDF4ZmtOV0ZTVDVlN0RPcHd0NWt5ZnR6KzlOclgxbVExU1hvRlQ3?=
 =?utf-8?B?VUp6RkluNC9lRG8yZFJmWXlqQXJtd05oeUVvcUk5R0lIUmk5UVp1OE9USDIy?=
 =?utf-8?B?YW83OVdzSGdmaEgyL1J4czhwNFZtRE54SzZKUHl0YmRzU3VaUWtia3REeHo4?=
 =?utf-8?B?TmZSaGNUQmNPZnVkYnJTSE9RWkhkVmw1bzUrWkZFWHdmeisxbVI4djNiS1pC?=
 =?utf-8?B?RFlHcERMaDdndHp0TncwTWlyWlkraGYxdWhoOHcvbmMrMUl2NXJLdndpN1BE?=
 =?utf-8?B?NGJHbFE1VmxwQ05USVZBbExkSk9qRWJXMmJnRmc4MUJYUHYxbW1Oa0RTajZv?=
 =?utf-8?B?NWRkZU1NTzZoNm40OHVjSzErOE9kWXZtdDR3QTFjVlpzS0xSNWdqN2JONDJI?=
 =?utf-8?B?T3Y1ZFh5SGFvMGpFVFdPK0FBOVRnc2YyUE1CNGZNRFhVTlZZZ20wdGdEcWhH?=
 =?utf-8?B?NzJjVXhrS1BLb1FGZFIrS1VlK2FrN1hqTEdJQm1qbEt6WEdMek5zTUhvV1lw?=
 =?utf-8?B?Q2Q1V1FWYnRMckJUb0hyWnlZR2pLNWE5VHJSSXpqN2dDd0NybVJDVXNlckJs?=
 =?utf-8?B?ZU5pUnZmLzROb0xpV2VSa1N3TEg0MW0zTHNCOE9OVHZXUXJpTUhIZXFyVEFF?=
 =?utf-8?B?bVJjVG5YSURmLzdua1FjZXY4WjZWdE4vSHlPKzBPTGRwUXFCcVFXYVVuVFhl?=
 =?utf-8?B?Qk9TZm5FaDJTVVMrQTl2UGZ5aHZNMGVJQmZFVnduM2RETzJNanNPWEcxMXA4?=
 =?utf-8?B?TWdrUHJCcFFwMVBIZjhONFE4NmxWL0JFM1hFV2w5bjRoamJkZi84djdCOVI0?=
 =?utf-8?B?S09Oak1DcFhtOXdOYnBwZUF5K3JWTjMxZlBvOTlZMGNWcVU2S3FnM0V1S2p4?=
 =?utf-8?B?bkM1eWsrNThPZ2FFOGZlSlZtSGQzb0ZxVVBBTGRqWExzaTRiT0QyblA2MVIr?=
 =?utf-8?B?NVJDYkJ6amlrVVgzL1hNYXlnWis0eWo5VklCbzh6WDBFeEFSVyt6a2dCazg2?=
 =?utf-8?B?NE03akQvdnA4NHJLRS8wKy9DMmlydXVXdE8zUnp4aUgraG9YblBmb3RHQVJR?=
 =?utf-8?B?MFZuY1BHb2xPQlpPejA3VForeFB6SzlpeU8vOVBJZStGSVpNK1RlcStERzk2?=
 =?utf-8?Q?77v1TiHvTgiJxqXKXFWZnehAe6moS8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFg2dE9DTk8wVHF6UWZIQ2lQWGJnTEtZWjg2TDRtSXdRRmNQdU92YlZaSi8v?=
 =?utf-8?B?NlN0djYwbXVueWRSVFVpclJ0ZWFySm8zSGJMWHQya01lb2JSN0Zyd243cUpI?=
 =?utf-8?B?SS8yN0oza0V0Z0VLOUNiOUFvQlpBb3V0VllZdGxIMlpFNmtzTTI1cFVvbFJR?=
 =?utf-8?B?dVhML1pTa3d6d1FVeWlLd1FuR2d0OE9pZUNub0NkWlZpd1Y4ZGl0TXNRTVlJ?=
 =?utf-8?B?Z0QzLzBqNm1EcjlZWlljVVV2ZFl4MHJjOXNpNWJxOGYza0daM1hkRjViVEdQ?=
 =?utf-8?B?TzFRWm42dHFhTHEwenBZTWdPSFFwS0o4b2o2K1V4bUl6U1VYa3pRVm5WTlYw?=
 =?utf-8?B?Z0NZLzFjODFCTGg3aTZ6a0xOSUU0V0l2Z2EvSWhLMHo2WUhaY2hkNFlSRGFp?=
 =?utf-8?B?ZGg3RlBaUHl0VytkM2x5WU5jbjQyQ2FXYzgvWHNsZzg2UjM5TkRaSU91RDNm?=
 =?utf-8?B?ejl0a2FpM2F3RFVRK0Z6bHBJWitpZlBXNkRHNlJpNm0raXVBR3FRRHR4MEVx?=
 =?utf-8?B?K1F5Vy9jYlMvaUJYeGh3ajZPcEgyQlBoU2w3eEtjV3JublBpY1Vzbkd4L09z?=
 =?utf-8?B?UjdQaW5LVllCb2lSdEtjaWxxeUpwZFN3NEs1aEs5OTJGUkgyc2p1RU8yeFFF?=
 =?utf-8?B?Ym9nNzVudXMxc2thMVRrbHpMNS93MjlkamcySjg1L29EckxLWHNnUEVXU2NP?=
 =?utf-8?B?Sm5qbVd2VEV2UmRPZ05zeFFGUlc3ZGxUN1Y1T3UrQTdZN3c2dXk4MHdtVThG?=
 =?utf-8?B?WUpXeHBZYVA5dHNMKzZYdXJSUGRGUkI4cjBZcnFqaHdkY3JTYWdsZHhCcUE4?=
 =?utf-8?B?NUtwSG9maFl0NFA1b3JNVmR2Vy9weEIrRU5HMmpZSVI3M3pkZUpTWldzbGYv?=
 =?utf-8?B?ZXhZNnJaVWFmaUlJc2pIQUtxQ2JIaE1qUnpyTnduTzZjaUFITGtWenVldGgv?=
 =?utf-8?B?ckROQWdOK1lLQTN5azhRNGxJejZKQXRsQU5ObHRkUUo1ZzVEQXQxaTNWaDdK?=
 =?utf-8?B?Zm9yYkFCYkQyNTBlZ0RzUVR0ZjlvZEphemVFU2taVHVrSHpZMVZXWHF6QWl1?=
 =?utf-8?B?QUxZbjJadnlFL0NlL25HbHdGdUVlZHlnY1VkcnhSbTNVK2ZJZDZEa2JCK2Jy?=
 =?utf-8?B?aWJscXZxMDI3S1cxTE4vOGx3bDlyMXRlNHdadUFuWG5hWVRnQm15eHNiOUQv?=
 =?utf-8?B?YnNSOXA0NFFQaXQ3M0JHb3FKdGFqU1lQaWk5SEpXMVhoNXBrbi91T0U4OC9I?=
 =?utf-8?B?dWxQTjE2N1lxakhHYzFJZVV0RHRHbnpqWFRuWHJaTG9iRmZraElDNnVKeDN5?=
 =?utf-8?B?YlVuNmtzOG85aHBDbmE4TjZkaGRQNHA0WnRZeVhvRWZiMWhDV0xmcnZ0dmxt?=
 =?utf-8?B?Ym5wcUJaSFhENlUwYjNGbHJwS09COU9OVGdaZHZUV3BEUnJIQ2hDc083TUI1?=
 =?utf-8?B?ZG1WQ3pmTFkwL3FWV0laZmpNQWM5cENEc09iOEx4cXNCOVZjK1ErWjZTWjhB?=
 =?utf-8?B?TWlMQTFPSW9hV3hQT1EzV2JCc3BwdkpCenA1elJpeFY2azBPU2kybFByUFdi?=
 =?utf-8?B?dWlEN1FxSldLeTE5aE0rQ3d3UG8yQk1CcFpLZVM2ME04dm9jTHphM3Ewd0Vp?=
 =?utf-8?B?RDhCQ2F0YmR5eTBkc250N1lRcmNJVkwrVnVJWHVrUEtUQkl4QXpKVVBQMXRO?=
 =?utf-8?B?NDlQYjBwS2ExT2l5T2F1eHhSSlRXUFJhV1VPZURXR0ZNRGE1TzJSMllEcHRB?=
 =?utf-8?B?dWhZL01iRlZDejkyeE4wMElQc2xFeGJ5MWQ4blJyQ09IdmVmRXFWV0tNZ21J?=
 =?utf-8?B?MmhRZnd0L1hUSWRyTjFwUmc5c2dJUEM5NEZzeUZWR3ZTZWx6OWk4V1JXaW1D?=
 =?utf-8?B?N2M2SWVhbHI4TGVKc1NuUGJXeFg4RG90Q0NONTNtb2JTWFZiUFhSZ1hqc1Bz?=
 =?utf-8?B?WFhKQmc2NmJwd3NIczZnYmM0RTMvVnc4TlI2a21vaEJRSzB0LzBhbm1JSHB4?=
 =?utf-8?B?MWk0SHdzMGQ3MlMzR0VlZnhFdjdCSFdRNXpFazhleU9udXBiMU1odHFLWGRy?=
 =?utf-8?B?SHJaUE1IdDlFeWVXblVkT3lzckViZjFXUFZFU0VVclBYS3N1a0lxdzQ1Um1X?=
 =?utf-8?B?L1NEY2JtVWhjd0lNUGphazRRZUpTN3dmaDZURVBIbklpSnZBM2dGU0Npc2ZQ?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CFFAD15C2D50947ABC4D99893005892@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccfb05a-764d-47e1-299b-08dd8ccf2ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 18:52:42.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZQ/hFsTGPuoLHwLYKAPY6H+SH2iZ7xOUzpJ+S4av2unUqOTjQ15cm5mVu+q71z8vaPtBDO+HpJhbzHdreJTdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8990
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA1LTA2IGF0IDEzOjU2IC0wMzAwLCBBcm5hbGRvIENhcnZhbGhvIGRlIE1l
bG8gd3JvdGU6DQo+IE9uIFR1ZSwgTWF5IDA2LCAyMDI1IGF0IDA0OjA5OjM3UE0gKzAwMDAsIEZh
bGNvbiwgVGhvbWFzIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyNS0wNS0wMSBhdCAyMDo0NiArMDAw
MCwgRmFsY29uLCBUaG9tYXMgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDIwMjUtMDUtMDEgYXQgMTM6
MDAgLTA3MDAsIElhbiBSb2dlcnMgd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwgTWF5IDEsIDIwMjUg
YXQgMTE6NDLigK9BTSBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGludGVsLmNvbT4gd3Jv
dGU6DQo+ID4gPiA+ID4gQ2FsbGluZyBwZXJmIHRvcCB3aXRoIGJyYWNoIGZpbHRlcnMgZW5hYmxl
ZCBvbiBJbnRlbCBoeWJyaWQgQ1BVJ3MNCj4gPiA+ID4gPiB3aXRoIGJyYW5jaCBjb3VudGVyIGV2
ZW50IGxvZ2dpbmcgc3VwcG9ydCByZXN1bHRzIGluIGEgc2VnZmF1bHQuDQo+IA0KPiA+ID4gPiA+
ICQgLi9wZXJmIHRvcCAtZSAne2NwdV9jb3JlL2NwdS1jeWNsZXMvLGNwdV9jb3JlL2V2ZW50PTB4
YzYsdW1hc2s9MHgzLFwNCj4gPiA+ID4gPiAgICAgICAgIGZyb250ZW5kPTB4MTEsbmFtZT1mcm9u
dGVuZF9yZXRpcmVkX2RzYl9taXNzL30nIC1qIGFueSxjb3VudGVyDQo+ID4gPiA+ID4gcGVyZjog
U2VnbWVudGF0aW9uIGZhdWx0DQo+ID4gPiA+ID4gLS0tLS0tLS0gYmFja3RyYWNlIC0tLS0tLS0t
DQo+ID4gPiA+ID4gLi9wZXJmKCkgWzB4NTVmNDYwXQ0KPiA+ID4gPiA+IC9saWI2NC9saWJjLnNv
LjYoKzB4MWEwNTApIFsweDdmZDhiZTIyNzA1MF0NCj4gPiA+ID4gPiAuL3BlcmYoKSBbMHg1N2I0
YTddDQo+ID4gPiA+ID4gLi9wZXJmKCkgWzB4NTYxZTVhXQ0KPiA+ID4gPiA+IC4vcGVyZigpIFsw
eDYwNGE4MV0NCj4gPiA+ID4gPiAuL3BlcmYoKSBbMHg0Mzk1YjVdDQo+ID4gPiA+ID4gLi9wZXJm
KCkgWzB4NjAxNzMyXQ0KPiA+ID4gPiA+IC4vcGVyZigpIFsweDQzOWJjMV0NCj4gPiA+ID4gPiAu
L3BlcmYoKSBbMHg1ZDM1YjNdDQo+ID4gPiA+ID4gLi9wZXJmKCkgWzB4NDM5MzZjXQ0KPiA+ID4g
PiA+IC9saWI2NC9saWJjLnNvLjYoKzB4NzBiYTgpIFsweDdmZDhiZTI3ZGJhOF0NCj4gPiA+ID4g
PiAvbGliNjQvbGliYy5zby42KCsweGY0YjhjKSBbMHg3ZmQ4YmUzMDFiOGNdDQo+IA0KPiA+ID4g
SGkgSWFuLCB0aGFua3MgZm9yIHJldmlld2luZy4NCj4gDQo+ID4gPiA+IFRoYW5rcyBUaG9tYXMu
IENvdWxkIHlvdSBnZW5lcmF0ZSB0aGlzIGJhY2t0cmFjZSBpbiBHREI/IEkgZGlkIHdyaXRlIGEN
Cj4gPiA+ID4gcGF0Y2ggdG8gc3ltYm9saXplIGJhY2t0cmFjZXMgbGlrZSB0aGlzOg0KPiA+ID4g
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjUwMzEzMDUyOTUyLjg3MTk1OC0yLWly
b2dlcnNAZ29vZ2xlLmNvbS8NCj4gPiA+ID4gU2FkbHkgd2l0aG91dCBhbnkgcmV2aWV3ZWQgdGFn
cyBhbmQgdW5tZXJnZWQgLSB0aGUgY29kZSBjYWxscyByb3V0aW5lcw0KPiA+ID4gPiB0aGF0IG1h
bGxvYyBzbyBpdCBpc24ndCBzdHJpY3RseSBzb3VuZCBpZiBzYXkgdGhlIGJhY2t0cmFjZSB3YXMg
bmVlZGVkDQo+ID4gPiA+IGZyb20gYSBTRUdWIGluIHRoZSBtYWxsb2MgaW1wbGVtZW50YXRpb24s
IGl0IGlzIG5pY2VseQ0KPiA+ID4gPiBzZWxmLXJlZmVyZW5jaW5nIHRoZSBwZXJmIEFQSXMsIC4u
DQo+IA0KPiA+ID4gU29ycnkgYWJvdXQgdGhhdCwgaGVyZSBpcyB0aGUgYmFja3RyYWNlIEknbSBz
ZWVpbmcgd2hlbiBydW5uaW5nIHRoZSBwZXJmIHRvcCBjb21tYW5kIGluIGdkYjoNCj4gDQo+ID4g
PiBUaHJlYWQgMjcgInBlcmYiIHJlY2VpdmVkIHNpZ25hbCBTSUdTRUdWLCBTZWdtZW50YXRpb24g
ZmF1bHQuDQo+IA0KPiA+ID4gW1N3aXRjaGluZyB0byBUaHJlYWQgMHg3ZmZmY2I3ZmU2YzAgKExX
UCA4MTIxNjkpXQ0KPiA+ID4gMHgwMDAwMDAwMDAwNTdiNGE3IGluIHBlcmZfZW52LmZpbmRfYnJf
Y250cl9pbmZvICgpDQo+ID4gPiAoZ2RiKSBiYWNrdHJhY2UNCj4gPiA+ICMwICAweDAwMDAwMDAw
MDA1N2I0YTcgaW4gcGVyZl9lbnYuZmluZF9icl9jbnRyX2luZm8gKCkNCj4gPiA+ICMxICAweDAw
MDAwMDAwMDA1NjFlNWEgaW4gYWRkcl9tYXBfc3ltYm9sLmFjY291bnRfY3ljbGVzICgpDQo+ID4g
PiAjMiAgMHgwMDAwMDAwMDAwNjA0YTgxIGluIGhpc3QuYWNjb3VudF9jeWNsZXMgKCkNCj4gPiA+
ICMzICAweDAwMDAwMDAwMDA0Mzk1YjUgaW4gaGlzdF9pdGVyLnRvcF9jYWxsYmFjayAoKQ0KPiA+
ID4gIzQgIDB4MDAwMDAwMDAwMDYwMTczMiBpbiBoaXN0X2VudHJ5X2l0ZXIuYWRkICgpDQo+ID4g
PiAjNSAgMHgwMDAwMDAwMDAwNDM5YmMxIGluIGRlbGl2ZXJfZXZlbnQgKCkNCj4gPiA+ICM2ICAw
eDAwMDAwMDAwMDA1ZDM1YjMgaW4gX19vcmRlcmVkX2V2ZW50c19fZmx1c2ggKCkNCj4gPiA+ICM3
ICAweDAwMDAwMDAwMDA0MzkzNmMgaW4gcHJvY2Vzc190aHJlYWQgKCkNCj4gPiA+ICM4ICAweDAw
MDA3ZmZmZjZlN2RiYTggaW4gc3RhcnRfdGhyZWFkIChhcmc9PG9wdGltaXplZCBvdXQ+KSBhdCBw
dGhyZWFkX2NyZWF0ZS5jOjQ0OA0KPiA+ID4gIzkgIDB4MDAwMDdmZmZmNmYwMWI4YyBpbiBfX0dJ
X19fY2xvbmUzICgpIGF0IC4uL3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4Nl82NC9jbG9uZTMu
Uzo3OA0KPiAgDQo+ID4gU29ycnksIGxldCBtZSB0cnkgdGhpcyBhZ2Fpbi4uLg0KPiAgDQo+ID4g
VGhyZWFkIDI3ICJwZXJmIiByZWNlaXZlZCBzaWduYWwgU0lHU0VHViwgU2VnbWVudGF0aW9uIGZh
dWx0Lg0KPiA+IFtTd2l0Y2hpbmcgdG8gVGhyZWFkIDB4N2ZmZmNmN2ZlNmMwIChMV1AgOTQwMDQ2
KV0NCj4gPiBwZXJmX2Vudl9fZmluZF9icl9jbnRyX2luZm8gKGVudj0weGYzMjhjMCA8cGVyZl9l
bnY+LCBucj0weDAsIHdpZHRoPTB4N2ZmZmNmN2ZkMmMwKSBhdCB1dGlsL2Vudi5jOjY1Mw0KPiA+
IDY1MwkJCSp3aWR0aCA9IGVudi0+Y3B1X3BtdV9jYXBzID8gZW52LT5icl9jbnRyX3dpZHRoIDoN
Cj4gPiAoZ2RiKSBidA0KPiA+ICMwICBwZXJmX2Vudl9fZmluZF9icl9jbnRyX2luZm8gKGVudj0w
eGYzMjhjMCA8cGVyZl9lbnY+LCBucj0weDAsIHdpZHRoPTB4N2ZmZmNmN2ZkMmMwKSBhdCB1dGls
L2Vudi5jOjY1Mw0KPiA+ICMxICAweDAwMDAwMDAwMDA1YWQ4MjkgaW4gc3ltYm9sX19hY2NvdW50
X2JyX2NudHIgKGJyYW5jaD0weDdmZmZkMTFmOWMwMCwgZXZzZWw9MHhmYWU0ODAsIG9mZnNldD0y
MCwgYnJfY250cj00KSBhdCB1dGlsL2Fubm90YXRlLmM6MzQ1DQo+ID4gIzIgIDB4MDAwMDAwMDAw
MDVhZGE4YiBpbiBzeW1ib2xfX2FjY291bnRfY3ljbGVzIChhZGRyPTU1ODA0MzYsIHN0YXJ0PTU1
ODA0MzMsIHN5bT0weDdmZmZkMDBkMzAxMCwgY3ljbGVzPTEsIGV2c2VsPTB4ZmFlNDgwLCBicl9j
bnRyPTQpIGF0IHV0aWwvYW5ub3RhdGUuYzozODkNCj4gPiAjMyAgMHgwMDAwMDAwMDAwNWFkYzA2
IGluIGFkZHJfbWFwX3N5bWJvbF9fYWNjb3VudF9jeWNsZXMgKGFtcz0weDdmZmZkMTdiMWUyMCwg
c3RhcnQ9MHg3ZmZmZDE3YjFmMDAsIGN5Y2xlcz0xLCBldnNlbD0weGZhZTQ4MCwgYnJfY250cj00
KSBhdCB1dGlsL2Fubm90YXRlLmM6NDIyDQo+ID4gIzQgIDB4MDAwMDAwMDAwMDY4OGFiNCBpbiBo
aXN0X19hY2NvdW50X2N5Y2xlcyAoYnM9MHgxMGNiYWE4LCBhbD0weDdmZmZjZjdmZDU0MCwgc2Ft
cGxlPTB4N2ZmZmNmN2ZkNzYwLCBub25hbnlfYnJhbmNoX21vZGU9ZmFsc2UsIHRvdGFsX2N5Y2xl
cz0weDAsIGV2c2VsPTB4ZmFlNDgwKSBhdCB1dGlsL2hpc3QuYzoyNzc0DQo+ID4gIzUgIDB4MDAw
MDAwMDAwMDQ0NjAwNCBpbiBoaXN0X2l0ZXJfX3RvcF9jYWxsYmFjayAoaXRlcj0weDdmZmZjZjdm
ZDU5MCwgYWw9MHg3ZmZmY2Y3ZmQ1NDAsIHNpbmdsZT10cnVlLCBhcmc9MHg3ZmZmZmZmZjlkZTAp
IGF0IGJ1aWx0aW4tdG9wLmM6NzM3DQo+ID4gIzYgIDB4MDAwMDAwMDAwMDY4NGQyYSBpbiBoaXN0
X2VudHJ5X2l0ZXJfX2FkZCAoaXRlcj0weDdmZmZjZjdmZDU5MCwgYWw9MHg3ZmZmY2Y3ZmQ1NDAs
IG1heF9zdGFja19kZXB0aD0xMjcsIGFyZz0weDdmZmZmZmZmOWRlMCkgYXQgdXRpbC9oaXN0LmM6
MTI5MQ0KPiA+ICM3ICAweDAwMDAwMDAwMDA0NDY0ZmUgaW4gcGVyZl9ldmVudF9fcHJvY2Vzc19z
YW1wbGUgKHRvb2w9MHg3ZmZmZmZmZjlkZTAsIGV2ZW50PTB4MTBjYmE3MCwgZXZzZWw9MHhmYWU0
ODAsIHNhbXBsZT0weDdmZmZjZjdmZDc2MCwgbWFjaGluZT0weDEwNWVjNjgpIGF0IGJ1aWx0aW4t
dG9wLmM6ODQ1DQo+ID4gIzggIDB4MDAwMDAwMDAwMDQ0NzUyMyBpbiBkZWxpdmVyX2V2ZW50IChx
ZT0weDdmZmZmZmZmYTBmOCwgcWV2ZW50PTB4MTBjZGQ2MCkgYXQgYnVpbHRpbi10b3AuYzoxMjEx
DQo+ID4gIzkgIDB4MDAwMDAwMDAwMDY0OGFmZiBpbiBkb19mbHVzaCAob2U9MHg3ZmZmZmZmZmEw
ZjgsIHNob3dfcHJvZ3Jlc3M9ZmFsc2UpIGF0IHV0aWwvb3JkZXJlZC1ldmVudHMuYzoyNDUNCj4g
PiAjMTAgMHgwMDAwMDAwMDAwNjQ4ZTU2IGluIF9fb3JkZXJlZF9ldmVudHNfX2ZsdXNoIChvZT0w
eDdmZmZmZmZmYTBmOCwgaG93PU9FX0ZMVVNIX19UT1AsIHRpbWVzdGFtcD0wKSBhdCB1dGlsL29y
ZGVyZWQtZXZlbnRzLmM6MzI0DQo+ID4gIzExIDB4MDAwMDAwMDAwMDY0OGY0MCBpbiBvcmRlcmVk
X2V2ZW50c19fZmx1c2ggKG9lPTB4N2ZmZmZmZmZhMGY4LCBob3c9T0VfRkxVU0hfX1RPUCkgYXQg
dXRpbC9vcmRlcmVkLWV2ZW50cy5jOjM0Mg0KPiA+ICMxMiAweDAwMDAwMDAwMDA0NDcwOTcgaW4g
cHJvY2Vzc190aHJlYWQgKGFyZz0weDdmZmZmZmZmOWRlMCkgYXQgYnVpbHRpbi10b3AuYzoxMTIw
DQo+ID4gIzEzIDB4MDAwMDdmZmZmNmU3ZGJhOCBpbiBzdGFydF90aHJlYWQgKGFyZz08b3B0aW1p
emVkIG91dD4pIGF0IHB0aHJlYWRfY3JlYXRlLmM6NDQ4DQo+ID4gIzE0IDB4MDAwMDdmZmZmNmYw
MWI4YyBpbiBfX0dJX19fY2xvbmUzICgpIGF0IC4uL3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4
Nl82NC9jbG9uZTMuUzo3OA0KPiANCj4gSSdsbCB0ZXN0IG9uIGEgMTQ3MDAgbGF0ZXIgdG9kYXks
IGJ1dCBvbiB0aGlzIG9uZSBpdCBpcyB3b3JraW5nOg0KPiANCj4gcm9vdEB4MTp+IyBncmVwIC1t
MSAibW9kZWwgbmFtZSIgL3Byb2MvY3B1aW5mbyANCj4gbW9kZWwgbmFtZQk6IDEzdGggR2VuIElu
dGVsKFIpIENvcmUoVE0pIGk3LTEzNjVVDQo+IHJvb3RAeDE6fiMgcGVyZiAtdnYNCj4gcGVyZiB2
ZXJzaW9uIDYuMTUucmMyLmc4ZmVhZmJhNTljNTENCj4gICAgICAgICAgICAgICAgICAgIGFpbzog
WyBvbiAgXSAgIyBIQVZFX0FJT19TVVBQT1JUDQo+ICAgICAgICAgICAgICAgICAgICBicGY6IFsg
b24gIF0gICMgSEFWRV9MSUJCUEZfU1VQUE9SVA0KPiAgICAgICAgICBicGZfc2tlbGV0b25zOiBb
IG9uICBdICAjIEhBVkVfQlBGX1NLRUwNCj4gICAgICAgICAgICAgZGVidWdpbmZvZDogWyBvbiAg
XSAgIyBIQVZFX0RFQlVHSU5GT0RfU1VQUE9SVA0KPiAgICAgICAgICAgICAgICAgIGR3YXJmOiBb
IG9uICBdICAjIEhBVkVfTElCRFdfU1VQUE9SVA0KPiAgICAgZHdhcmZfZ2V0bG9jYXRpb25zOiBb
IG9uICBdICAjIEhBVkVfTElCRFdfU1VQUE9SVA0KPiAgICAgICAgICAgZHdhcmYtdW53aW5kOiBb
IG9uICBdICAjIEhBVkVfRFdBUkZfVU5XSU5EX1NVUFBPUlQNCj4gICAgICAgICAgICAgICBhdXh0
cmFjZTogWyBvbiAgXSAgIyBIQVZFX0FVWFRSQUNFX1NVUFBPUlQNCj4gICAgICAgICAgICAgICAg
IGxpYmJmZDogWyBPRkYgXSAgIyBIQVZFX0xJQkJGRF9TVVBQT1JUICggdGlwOiBEZXByZWNhdGVk
LCBsaWNlbnNlIGluY29tcGF0aWJpbGl0eSwgdXNlIEJVSUxEX05PTkRJU1RSTz0xIGFuZCBpbnN0
YWxsIGJpbnV0aWxzLWRldltlbF0gKQ0KPiAgICAgICAgICAgIGxpYmNhcHN0b25lOiBbIG9uICBd
ICAjIEhBVkVfTElCQ0FQU1RPTkVfU1VQUE9SVA0KPiAgICAgICAgICAgICAgbGliY3J5cHRvOiBb
IG9uICBdICAjIEhBVkVfTElCQ1JZUFRPX1NVUFBPUlQNCj4gICAgIGxpYmR3LWR3YXJmLXVud2lu
ZDogWyBvbiAgXSAgIyBIQVZFX0xJQkRXX1NVUFBPUlQNCj4gICAgICAgICAgICAgICAgIGxpYmVs
ZjogWyBvbiAgXSAgIyBIQVZFX0xJQkVMRl9TVVBQT1JUDQo+ICAgICAgICAgICAgICAgIGxpYm51
bWE6IFsgb24gIF0gICMgSEFWRV9MSUJOVU1BX1NVUFBPUlQNCj4gICAgICAgICAgICAgbGlib3Bl
bmNzZDogWyBvbiAgXSAgIyBIQVZFX0NTVFJBQ0VfU1VQUE9SVA0KPiAgICAgICAgICAgICAgICBs
aWJwZXJsOiBbIG9uICBdICAjIEhBVkVfTElCUEVSTF9TVVBQT1JUDQo+ICAgICAgICAgICAgICAg
IGxpYnBmbTQ6IFsgb24gIF0gICMgSEFWRV9MSUJQRk0NCj4gICAgICAgICAgICAgIGxpYnB5dGhv
bjogWyBvbiAgXSAgIyBIQVZFX0xJQlBZVEhPTl9TVVBQT1JUDQo+ICAgICAgICAgICAgICAgbGli
c2xhbmc6IFsgb24gIF0gICMgSEFWRV9TTEFOR19TVVBQT1JUDQo+ICAgICAgICAgIGxpYnRyYWNl
ZXZlbnQ6IFsgb24gIF0gICMgSEFWRV9MSUJUUkFDRUVWRU5UDQo+ICAgICAgICAgICAgICBsaWJ1
bndpbmQ6IFsgT0ZGIF0gICMgSEFWRV9MSUJVTldJTkRfU1VQUE9SVCAoIHRpcDogRGVwcmVjYXRl
ZCwgdXNlIExJQlVOV0lORD0xIGFuZCBpbnN0YWxsIGxpYnVud2luZC1kZXZbZWxdIHRvIGJ1aWxk
IHdpdGggaXQgKQ0KPiAgICAgICAgICAgICAgICAgICBsem1hOiBbIG9uICBdICAjIEhBVkVfTFpN
QV9TVVBQT1JUDQo+IG51bWFfbnVtX3Bvc3NpYmxlX2NwdXM6IFsgb24gIF0gICMgSEFWRV9MSUJO
VU1BX1NVUFBPUlQNCj4gICAgICAgICAgICAgICAgICAgemxpYjogWyBvbiAgXSAgIyBIQVZFX1pM
SUJfU1VQUE9SVA0KPiAgICAgICAgICAgICAgICAgICB6c3RkOiBbIG9uICBdICAjIEhBVkVfWlNU
RF9TVVBQT1JUDQo+IHJvb3RAeDE6fiMgcGVyZiB0b3AgLWUgJ3tjcHVfY29yZS9jcHUtY3ljbGVz
LyxjcHVfY29yZS9ldmVudD0weGM2LHVtYXNrPTB4Myxmcm9udGVuZD0weDExLG5hbWU9ZnJvbnRl
bmRfcmV0aXJlZF9kc2JfbWlzcy99JyAtaiBhbnksY291bnRlDQo+IA0KDQpJIHNob3VsZCBoYXZl
IGJlZW4gY2xlYXJlciBpbiBteSBjb21taXQgbWVzc2FnZSBidXQgaXQgcmVxdWlyZXMgUE1VJ3Mg
d2l0aCAiYnJhbmNoX2NvdW50ZXJfbnIiIGFuZA0KImJyYW5jaF9jb3VudGVyX3dpZHRoIiBjYXBh
YmlsaXRpZXMgdG8gcmVjcmVhdGUuDQoNCiQgbHMgL3N5cy9kZXZpY2VzL2NwdV9jb3JlL2NhcHMN
CmJyYW5jaF9jb3VudGVyX25yICBicmFuY2hfY291bnRlcl93aWR0aCAgYnJhbmNoZXMgIG1heF9w
cmVjaXNlICBwbXVfbmFtZQ0KDQokIHN1ZG8gcGVyZiB0b3AgLWUgJ3tjcHVfY29yZS9jcHUtDQpj
eWNsZXMvLGNwdV9jb3JlL2V2ZW50PTB4YzYsdW1hc2s9MHgzLGZyb250ZW5kPTB4MTEsbmFtZT1m
cm9udGVuZF9yZXRpcmVkX2RzYl9taXNzL30nIC1qIGFueSxjb3VudGVyDQpwZXJmOiBTZWdtZW50
YXRpb24gZmF1bHQNCi0tLS0tLS0tIGJhY2t0cmFjZSAtLS0tLS0tLQ0KcGVyZigrMHhmYTczNCkg
WzB4NTYxYjViMTlmNzM0XQ0KL2xpYjY0L2xpYmMuc28uNigrMHgxYTA1MCkgWzB4N2ZhYTc3YTI3
MDUwXQ0KcGVyZihwZXJmX2Vudl9fZmluZF9icl9jbnRyX2luZm8rMHg3NykgWzB4NTYxYjViMWI4
Mzc3XQ0KcGVyZihhZGRyX21hcF9zeW1ib2xfX2FjY291bnRfY3ljbGVzKzB4MjJlKSBbMHg1NjFi
NWIxYTI3ZGVdDQpwZXJmKGhpc3RfX2FjY291bnRfY3ljbGVzKzB4MjQxKSBbMHg1NjFiNWIyM2Rh
ZTFdDQpwZXJmKCsweDJjNDU5KSBbMHg1NjFiNWIwZDE0NTldDQpwZXJmKGhpc3RfZW50cnlfaXRl
cl9fYWRkKzB4ZTIpIFsweDU2MWI1YjIzOWEzMl0NCnBlcmYoKzB4MmNhMDgpIFsweDU2MWI1YjBk
MWEwOF0NCnBlcmYoKzB4MTY4MzczKSBbMHg1NjFiNWIyMGQzNzNdDQpwZXJmKCsweDJjMjE0KSBb
MHg1NjFiNWIwZDEyMTRdDQovbGliNjQvbGliYy5zby42KCsweDcxMTY4KSBbMHg3ZmFhNzdhN2Ux
NjhdDQovbGliNjQvbGliYy5zby42KCsweGY1MTRjKSBbMHg3ZmFhNzdiMDIxNGNdDQoNClRoYW5r
cywNClRvbQ0KDQo+IEFkZCAtLW9mZi1jcHUtdGhyZXNoIG9wdGlvbg0KPiA3NDA2OWEwMTYwOWVm
MGY0IHBlcmYgcmVjb3JkIC0tb2ZmLWNwdTogRHVtcCB0aGUgcmVtYWluaW5nIFBFUkZfU0FNUExF
XyBpbiBzYW1wbGVfdHlwZSBmcm9tIEJQRidzIHN0YWNrIHRyYWNlIG1hcA0KPiA4YWU3YTU3Njli
MGEzYWMyIHBlcmYgc2NyaXB0OiBEaXNwbGF5IG9mZi1jcHUgc2FtcGxlcyBjb3JyZWN0bHkNCj4g
N2RlMWE4N2YxZWU3NTc0MyBwZXJmIHJlY29yZCAtLW9mZi1jcHU6IERpc2FibGUgcGVyZl9ldmVu
dCdzIGNhbGxjaGFpbiBjb2xsZWN0aW9uDQo+IDdmOGY1NjQ3NWQ1ODUxMTcgcGVyZiBldnNlbDog
QXNzZW1ibGUgb2ZmLWNwdSBzYW1wbGVzDQo+IGQ2OTQ4ZjJhZjI0ZTA0ZWEgcGVyZiByZWNvcmQg
LS1vZmYtY3B1OiBEdW1wIG9mZi1jcHUgc2FtcGxlcyBpbiBCUEYNCj4gMjgyYzE5NTkwNmM3NmRk
ZiBwZXJmIHJlY29yZCAtLW9mZi1jcHU6IFByZXBhcmF0aW9uIG9mIG9mZi1jcHUgQlBGIHByb2dy
YW0NCj4gMGY3MjAyN2JiOWZiNzdhMiBwZXJmIHJlY29yZCAtLW9mZi1jcHU6IFBhcnNlIG9mZi1j
cHUgZXZlbnQNCj4gNjcxZTk0MzQ1MmIxODAwMSBwZXJmIGV2c2VsOiBFeHBvc2UgZXZzZWxfX2lz
X29mZmNwdV9ldmVudCgpIGZvciBmdXR1cmUgdXNlDQo+IOKsoiBbYWNtZUB0b29sYnggcGVyZi10
b29scy1uZXh0XSQgDQo+IA0KPiAtIEFybmFsZG8NCg0K

