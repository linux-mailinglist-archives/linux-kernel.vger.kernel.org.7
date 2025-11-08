Return-Path: <linux-kernel+bounces-891202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC80DC4223B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E8842355F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8AE281356;
	Sat,  8 Nov 2025 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iM40XbaT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B138DF9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562540; cv=fail; b=mA4Nu7gfxEWBdtOtjlfRLoAReToqsprSpgWq8GmE3Tj5KhDXr+XHW9GL7jpIfoC09e5RGOTjSn6IyONAu5fiy9vGTbvS1KxhCmAMe8bQOxXgEmDyg5kPscsEW8o4Wv+Nn7y1AL8QectfCTafFZY08X0JQ/otOMiZOXKxn/9KdHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562540; c=relaxed/simple;
	bh=e+CNZEt8ugG4Tu2ZvIqHBg37NZWYIBGgMpICQkIIhLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pWFhxYfO1cUQnTY2+JNSh0msvKSjgj288qSsLpQAGqt0oCOCIGRNH/CuoOK58DKmqAczF2Mtrl06yjQ3RO15xy29NoQf+YhHFgoECCeVest8NMCGnZ6QCrAaiY4D1u0hoXCzg3HOE2YvuZJvdh6Lf8siilX1Aju6i216JP0HsEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iM40XbaT; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762562538; x=1794098538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e+CNZEt8ugG4Tu2ZvIqHBg37NZWYIBGgMpICQkIIhLM=;
  b=iM40XbaTWyrdJhkmLfJc869rq7AlMJUcERrKieYLdxEfLPyZDoYZD1hC
   d1k/x0l8VduW973BWUiNlSZRePYrIIcKMnkLtkuOHdnzij7UoZsQGwusO
   x5OwZdfhstKoG/5fYl6ijlXML4yw+6fYu6ZYZh/0NRxNwHNLwU/mzbJWW
   Ku4lZNrr2nvyZq0h4C0tPeF1gT8A//DtgFJ/pDFtTmwHEsLByIjzMWSeT
   2AxKcZBEIuxDm1Kb53FgZpFsSRk3oxQFM97dLjgvvDjQKhpjoJKS3dp09
   qyHnkfSBvGdoIYUx0exrULd8dbOu1uaiDTBuNeAFS2OLSrxNeBFDQh0EP
   g==;
X-CSE-ConnectionGUID: lF+oivkeQT2yT5P4tabPEA==
X-CSE-MsgGUID: XV/hQYiwRHCet5hBHGO0uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64751647"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="64751647"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 16:42:17 -0800
X-CSE-ConnectionGUID: jIWjRlY6S/mEqxU1hSYozw==
X-CSE-MsgGUID: L+dRZlFyRy2u0D/J/3jwoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="218911332"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 16:42:17 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 16:42:16 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 16:42:16 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 16:42:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti3cat39C9dvje5G9dJ6x5O4/mk7vmpPMcnqfywepzMf+1obHBOf9ela1rxLkQ0OehQcrnAsF0ua/BNdo4fP7fNt8tJtCCUeup/Pw6tMYr8HAFTG1kse0yMRHqSFTxWkO2COI3iuouux4yT0+VjbK3tzmj9HTh127vxjBtsskHz3sUQnLpwWDKY1ORYBDn1Ycc/moWtCJbTQ/i02xQKK7SdY8XTjAV3U+4LnHP6BTVnAuvQdOybYlosXTIcuesdlg7MYnxWyzR5IJ3vOGseVlYmfJ9H+tmjj+5BTe9+V/+OmG8x3zpX10e3126YpYtR+W7jSZ5Oa1FgVzSpxds9Akw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+CNZEt8ugG4Tu2ZvIqHBg37NZWYIBGgMpICQkIIhLM=;
 b=CNN+cDxMWl0UgdQ7MWwyZY6icnNe2LbD/d+5SjJ59xN2+bHi4SFniCTuNc7qhw2NOG+V+QxnxPvfIaJw6CA3f1ESmw6/KtpwtKEE8zb4xjMeHdF46892g2PJLyue0jwM7hrVfA4BRCDxJrhL0eAz8SuAC7Y5+d4zarx4mpnahQmVXpnJJSrsh0A5PDoglUpvEYYSf/H2rCeNqobEYNGV/pt5T+1ERVW5lLS0lAk58cu3NTQdsetaMmbUlxsW3NDGeHFg5CjuvkamwWWF3JhE+BfC6YCZyTrQGIdlLtcDWlU/aCTfNlDKx50RShhetOnfh3ka/wKrOKXzKxKpkC3ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CYXPR11MB8709.namprd11.prod.outlook.com (2603:10b6:930:dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 00:42:14 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 00:42:14 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, "Moger, Babu" <bmoger@amd.com>
CC: "Chatre, Reinette" <reinette.chatre@intel.com>, "Dave.Martin@arm.com"
	<Dave.Martin@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"babu.moger@amd.com" <babu.moger@amd.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Thread-Topic: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Thread-Index: AQHcT4VCMZzJIaIcpEO5HF/nc2I90rTnxWyAgAAGSYCAAAv9gIAAFBMAgAAE/TA=
Date: Sat, 8 Nov 2025 00:42:14 +0000
Message-ID: <SJ1PR11MB60831737A75EC2AA1409C944FCC0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
In-Reply-To: <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CYXPR11MB8709:EE_
x-ms-office365-filtering-correlation-id: d22146ba-90f4-4b52-2e8b-08de1e5fa949
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bGlnVlZtMHp1eUxZeExFcnhsbUhkR2lkcEQyNnNrcG5sNUtscFdTWHdLWjI2?=
 =?utf-8?B?dW9ydE1lREtkbUk1eml4VnR5dURsVTNXeGw5QmdSVDFiWXh1cW93V3lyZVA3?=
 =?utf-8?B?SFB2TTQ4NWFzbktMaStTQ1lvZTNrL3M3UHdEalRJeXhBcHlibkZwVG9IQis3?=
 =?utf-8?B?V2VOK0gvdXNRaUJ3TFplRlJpUEU2bzZ6STBoWkkzdllpU3lwTllxSjVVNHhO?=
 =?utf-8?B?NWZaTGpMUXQzaE5hZWt0bEFhYVAyS1VRa2VTUnVlREE5L3hUT05iQVc3L01s?=
 =?utf-8?B?UjJVMnNwVE81Wk1qbU85M0pkK1lCVzZ5MVRuSlU5RkdqakgySlcwL1ZueFdO?=
 =?utf-8?B?MkFId2xoRGdQQ2QyeEVBTTdKUnYycHhsaEhzRmJtU2dYSWRlcUxucG54bzMr?=
 =?utf-8?B?NVpyMDQyb3pjR0FpSzdWNXF5dmNHQ0YzNVl0RlgvNWIrN0lwVW92NjhNaTRs?=
 =?utf-8?B?VUptVXNSU1dITzNnRTVtbEg0OFNDVzdsWjJXZUhkb3hNL3Z1dUNMSHZ5eHJp?=
 =?utf-8?B?d21VTUxIOFFkc09tSGNoSlgwRUNrOGpucEEwVzU3WEhwVWlKNEVRSFh0WGNM?=
 =?utf-8?B?UnNMZzVwQkFoM1FHSzZmbWtBU0tlVnN0WnBIRUxLdUNWRDAxOW9nU1MvUGlw?=
 =?utf-8?B?Q2dQcmVuZU5RWmNiL0FpbzVaUC8rbTNnWngxMEl3QU5POXFtK21ybngyNEFM?=
 =?utf-8?B?b0x0Q1R0VGJBUUoyaVFMZVFNWGVSTU92ODd1U0dUbWd6c3pnQUlYbU1lTUVz?=
 =?utf-8?B?UUs2a3BVckwxT084WUZPREV0TTdGZWY4TCtibjRybUovdEpGSG84bENjN25X?=
 =?utf-8?B?Ri9WZjM2V2p1T3owS3kxbE52Y1hrUndBK09HdXhEeU9aRkxhWURhRlgxZFE5?=
 =?utf-8?B?bFRHUlNJUTMrMmxQWFpwY0ZnVFdSZHV3YjlTWmdhSTdFV2VacjBYbmdrdzN6?=
 =?utf-8?B?R1NRVjdKSDNaZTcyOWozTGNrMkJSb3RZWDBCVDZ6N1g3WjJkU2xtUVdHYUYr?=
 =?utf-8?B?bjMwUlNEUU5qbCtpNHdIQStNblRGdVkyTlVJNHQ2b0E2dFdhajBScjJrYXlT?=
 =?utf-8?B?bFdKb1dIRlZDKy9JbjA2Qlk2REFreUdJY3FhcXBHWGJjSlhkZmIzUGpzRk04?=
 =?utf-8?B?TkV1S3BrQnVMQ1NCR21MdlZsTm90dE9keW1mdnJoWUZSVE1KVFlPQWZSZEdl?=
 =?utf-8?B?czg1YlFiQkRQU1RtSVI3WFdaYUR1ZDlOTTZ6VkJjTU5Kb0RSTlV4NmM5NCtn?=
 =?utf-8?B?aUh1TDRsOXpVNmpqbzdPYUpVNmRMYnMwSzIrckFyNXovMXN2cFZRSDBtQml2?=
 =?utf-8?B?T0RBd0duNG5nWXJ2ZEY5Tm1xWjV5Y3JITmZUdGFhT3ZYemJHbFJCSkgwT0lx?=
 =?utf-8?B?V0laeVZGREJUWUx0ZDR2a3RCWlp0ZlAxRUVCdy9OYkxFSWo1TnhsZ1UwSkFB?=
 =?utf-8?B?dWhsK252Vld5SndYL0FUbU9oOHl6SkxXS3RiaTVlQVNOV1NBZ3ZvMGozOXlY?=
 =?utf-8?B?WkxxQ0ErVndzZjJMU0x2eUNuM2ZIR042R29kZEw3UzRiS0J1VCtQdnZuK28y?=
 =?utf-8?B?OXVOQkx1RTdoem5pUFZiY09FMzMzSVV4Q0xIMEtCenZ4NlBCZWJsY2xDUW90?=
 =?utf-8?B?bm5HT0dTblc2aGNFR2ovQWw5WVZxYUE1ZEpEcTNiMHcxS2QwTTRPaVNmR3JK?=
 =?utf-8?B?aHdZdWY3em9WTXBkekNPTTdVSjEvdUdTMzBDc0ErcEFjZU9QTGVRT2cwaFZi?=
 =?utf-8?B?Tjl4b0w1VC9hMUJqaVVvdUltMUNZRFlvSTZnZlpUN2lyLzJpckRTTkZYclRB?=
 =?utf-8?B?ZGI2a0w5dW5sV0ltc2pTZUNJdGZZRGVjVGlQaGpPTERlSnpuS2NhckdWRVl3?=
 =?utf-8?B?OXhxaGo4ZDNWLy9HVXZIRk9QUHpHeXBnaFcwQ3BhYXMxVUFBV2w3NmxnOGI3?=
 =?utf-8?B?U3Y2S1h5ZG5aWVFqQXdVWGo1Z0lLVnl0eXQ3RWIrRFRWb3hTak9kZ3lVRzdn?=
 =?utf-8?B?SlBDajVwbnViS0plNmExTXFGaUVKUFRtSzdadGdTS3NOSGtZZGRrZmVBd3J2?=
 =?utf-8?Q?neonBg?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WCtXTkZKbStlSHY2NUkrbEFBalk3cCtzTkIvVTc3UnU3SFJOc3VLMndKR2t5?=
 =?utf-8?B?VlVNdE96OFk1MlNTLzhTaGZyR1Ewd3g3M2xOVXRBdUwyelgrbHVjNFBMOS9S?=
 =?utf-8?B?NEdjUFRpTWtRRFViZjJjd2hTMk5VWEJleHhwYUx3ZmhjWk1UZDJYeGlWZUpM?=
 =?utf-8?B?a0p3WHZoNGllTVp0NlFEZHZkTTVUS2hlRmJlRG5senZjL2J1TStWbjl5Um5X?=
 =?utf-8?B?cVdERE43WFh3VnRkdTNGOGQyNWVFeUIyUFh1ckVGaFp5NkMyb2hPK20wellt?=
 =?utf-8?B?QmR1cFJUVEpMZ0lXbVRRYm8ySlppYnpCcCtxN0V0V0NYbXkvNFN6SHYxQkdu?=
 =?utf-8?B?TGVtMUY0a1NCTXJFeGYvcTFRd2p6M0tDSHFNRlRsV1ExL1VPV09yZVU1S1c3?=
 =?utf-8?B?bnN2cU9nUC9Udnl0VUFoWjd6dTdKWVZjVytBRVl3elBNTi9BQWx2SHA4bGhk?=
 =?utf-8?B?cnhLbGR6cG0vUWFrNGZQeWJ1Wk5YeGo4T0NtZDBqK0tPcVZDREpBWURlckJH?=
 =?utf-8?B?MTV4NVFVaXRLUWNjRmhZNHZIZm50d0c1VFlaQ3FHa3Q1cFpwckZMSTRjNjNi?=
 =?utf-8?B?VEtiRGc5RkNXTHVldW04azlzUkM1UFl3TUVmZDNjUkFWNktiUXhaMWt3eXBi?=
 =?utf-8?B?MWJuUGRyaHBKUTFwcnhocmltWURlbzU4Z09RNzFkWG5UZXJxazRDV0lNOFNz?=
 =?utf-8?B?cVRvRFdqWFVXbHJ4cVhlNmRHSDNETjdOc08wYVdheWZCNDhZTzVqanFKMlVJ?=
 =?utf-8?B?M1ZnUXpmbjVaWXJZVEV2R0dUUURERExwZEVmM1dKSDczZXVuUGJ2c3dsalFW?=
 =?utf-8?B?aW96L0VpdVVUVFFlQSthVTNidnV5QWVEWWNaZXMvM2dLSU51cGh5T3EvZDFE?=
 =?utf-8?B?UWxyeEZWYzUwd3o1S2g3cHFzU1lNb3h5d2p1ZlJoWDBrK2x2WGJKWmRXejF3?=
 =?utf-8?B?TzhFeTdqaXB1S1E5RSs3YWFFd0ZvRGxGZTJWWVFIOElKSDZpV1pkM0V1Ni9I?=
 =?utf-8?B?aGgzYW9KNXFCRCttSjJkUVJZdXR4TTM4ZEtZNWsvRW1QcVFCV2RTOGxYWXgv?=
 =?utf-8?B?NjlmanRyUUM4ckNQNUtSYkthcEVCZzhFMEg4QU02aXRMamJEb2tXTDNLNWxz?=
 =?utf-8?B?K0t6OUlXNzV5K2QreUJlU0FLRUxPQUFyL013dHBoSkFlNDNNbU5XbHp0TFhl?=
 =?utf-8?B?c0NCMmFibFhrbnExRCtOd2Fkc1ZFekZnVWpyRGRwbmxTZTJ2STd0OFBNWFJU?=
 =?utf-8?B?L2dHT1lyUElTWkFmK3FXaTZwZHlsaVhBa01xRUZMdzBjVXgwWk9ITjNocXlx?=
 =?utf-8?B?dUVwUTM5RjlRR1N3cDBSZ2RaVlhTZU5GdjZBdm1rbXE0anJwOTFmQ2o2T3A4?=
 =?utf-8?B?ZGJRWlpYNGo4WWtXWGozRHBVLytjb0xCblV4UmpmLzNadjg3K0Q4WVNlZ0VH?=
 =?utf-8?B?NmUrMUgvT2hMYXFUTU0zYTZXWWQxWmRTT1lpdTJQcE0xZXBWQnd3dldSa0Mz?=
 =?utf-8?B?bVVPWXJXVkZnS0JUNEZPTmFybXNVOHV4akVsNy9uRGZxVUYwa1NKUGFZZU1X?=
 =?utf-8?B?OFptdXVBSHViY0NOVERTTFJNSDg4YU9VSzJXTFNPb1RxNFZWdmN2ZVdXazdZ?=
 =?utf-8?B?elJNVVBDaE1VS3NrTlZKbVZkR3l4VXpWVUVqV1dSUnhyNjdudlRWNVd6dmdN?=
 =?utf-8?B?bzdSNVg4a2x6WTlQU09EUzRBejBHZ1FqMjhyQVRrVmx2MisyN3haOGNOZVRr?=
 =?utf-8?B?UE1YWFNtTGd6bDFjdGUzbjdRZGdqRWNTbElJNEh3V3BicnkvZElkbzBGOFY1?=
 =?utf-8?B?ZHh5MnlCT25jRzRCeHFjTW1rdDQyWGY3Yy9zYnRBYS9WU1hiczhiaENOWVhP?=
 =?utf-8?B?bldEREpNRXRVMDhmeFBBbXRrcTZ2RTJJc3JidlQrRlBLNGxMTWdxRlg0Zjha?=
 =?utf-8?B?dENxWW4yVHV6eGpRUEUxZ1RLSk5ZallaRWlPeHpub05EYlVINU5RODk0STk2?=
 =?utf-8?B?ZzEvaVg4Zk1JTXNhNXJlTW5tOEd6SUZmUUN2WFZEQzlxZGk0WnQvSDJtNFlr?=
 =?utf-8?B?NHI4aHhUMyszSGZIVWV3am0xR1FueTF4cXROcDRybTI3SFdsL3ZWSFFFeEpX?=
 =?utf-8?Q?1/lxmsbs/DpnaEth4Lh6W0QPC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22146ba-90f4-4b52-2e8b-08de1e5fa949
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2025 00:42:14.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9rbCqc111SsfMaTDvKqGeZL7M2rqItfQb0rH2cC3jp28hZOND8vbjASbq9DFquZ1P90DNV+pIMUN4CTU4g5SgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8709
X-OriginatorOrg: intel.com

PiBUaGUgaW50ZW50aW9uIG9mIHRoaXMgbmV3IGludGVyZmFjZSBpcyBub3QgdG8gaGlkZSBsb3dl
ci1sZXZlbCBkZXRhaWxzIGZyb20NCj4gdGhlIGFkbWluaXN0cmF0b3IsIGJ1dCByYXRoZXIgdG8g
c2ltcGxpZnkgYSBzcGVjaWZpYywgaGlnaC1vdmVyaGVhZA0KPiBhZG1pbmlzdHJhdGlvbiB0YXNr
IGFuZCBwcmV2ZW50IGh1bWFuIGVycm9yLCB3aGljaCBJIGVuY291bnRlcmVkIGR1cmluZw0KPiB0
ZXN0aW5nIG9mIHlvdXIgc2VyaWVzLg0KDQpJZiB5b3UgZG8gdGhpcyBvZnRlbiwgbWFrZSBhIGJh
c2ggc2NyaXB0IG9yIGZ1bmN0aW9uIHRvIGRvOg0KDQpzZWQgLWkgLWUgJ3MvXChbMC05XVswLTld
KlwpPVwoWzAtOWEtZl1bMC05YS1mXSpcKS9cMT0wL2cnIC9zeXMvZnMvcmVzY3RybC9pbmZvL0wz
L2lvX2FsbG9jX2NibQ0KDQpbVGhhdCByZWdleCB3b3VsZCBwcm9iYWJseSBiZSBtb3JlIHJlYWRh
YmxlIHVzaW5nIGV4dGVuZGVkIHN5bnRheF0NCg0KLVRvbnkNCg==

