Return-Path: <linux-kernel+bounces-850913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD87EBD4B85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F1D540B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18530FC29;
	Mon, 13 Oct 2025 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIZsJIc2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9730FC1B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369730; cv=fail; b=LBG7YMlO0p9U49+hW0frnSJaYs5GN7wsfFr1HqspZR7srXmpibiXjVwaIgKJDnpms4GUZ1jXutBovD/urPjMrmb00txNud+kpd+CUo9F25POYpONLaLwZCK4UEV0IJ4oDX/X4rhc/X7gdR5EJ9PjEWLJrZisAKBWgDYfT8h+tBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369730; c=relaxed/simple;
	bh=J+KQMbtm49rcSpyVQNQ+j93FGnXYI2MXVw0YGyzkjwU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IPeA1vtgUIuRTEQf2RyS6wxyDzDE2aUlU6blBTjFRPiNLse+3N8Y6hiz5P779VNmyu/R8gIfNDIvcEZ7y++xSP/c5rVu8G1wAX0NwbL0kClP/cBB3PVQ3g/5dBqZIm4DYBxwXyjPD6QpZeiPyngKP013Sq8LtjxnbYjxHMYrOo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIZsJIc2; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760369729; x=1791905729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J+KQMbtm49rcSpyVQNQ+j93FGnXYI2MXVw0YGyzkjwU=;
  b=lIZsJIc2uupQeXfi3U1nqs2N4WeqbBoMWn/SF1n7E7AaheuqHek8oAm1
   fv0wnr4lCZuhnBe205HKQEGBip6y1ON9tvLMYLdY0fQmjrgRFS4pnmjJR
   buomInozfcwb18CvmjW4C7QjElbwWs32vZgQWFVZ7t+sJlc6HnccrWoiY
   lSG6CxyKsaYgY3KtqJQsxWU8xSidaSyj9FleFOJlzVA4ZIKGJ8O0AlUKy
   v9c6bRFGmTntdFyhhxexmfpPjoueL21e/XZC6LfjEqFsCIooqDPPGhZXP
   Pf/qeoY0/H2k17+1oL+lcaevKg7gO0qpNLzQrODSz8O2LdiuBtB0Z0/hi
   w==;
X-CSE-ConnectionGUID: TkPFvwjfQuKb6nhWIGWj9A==
X-CSE-MsgGUID: aH7K59FnSdal88pD4UcDZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="79953201"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="79953201"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 08:35:28 -0700
X-CSE-ConnectionGUID: zpIhI+z7R1Ss8xnNxxS9Kg==
X-CSE-MsgGUID: jaBiSZhrRMSKH1UwQxEXjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="218746675"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 08:35:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 08:35:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 08:35:27 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 08:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsFMiANsjcMD6ke6Le1Iodh9nTU6ZJYjnNzbkN+dZiZ0Rl/EmrcSMjqpFUQW5iaO38UKanfQlFhJkYxkqHJmZ+pmEgw6G8cFX2HYBSku/lrHXq6HfZS4hC9pjJg3DGVDsjsYFXIpBzf0m+Uo1Gw1pz45qcRvPYVeT7UwRqcEBLp961N2Zj1X+07aO55c5y/dS1h0xvUldrhf6cUIrNJ/hxU2DDyfAyhJv4L5OXJ9SlN6YeKzl0wMsyhiCXo4wBpqKYiKZdN9a2ByfqFEZICY6PFN2eO+IWc3Ly6NRoWcPYpj3pKiwbGg5zv2cDlJLK35q4MVUzDyo/f3Stqcnn0/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+KQMbtm49rcSpyVQNQ+j93FGnXYI2MXVw0YGyzkjwU=;
 b=OjYy8Kl2Hv7klctWutUyKVqNUxoqRgATpRJLASeVpQYLs50WQRB8mbUTEPsq1aW03TrWYkIPZxwu1aM/48Vvz6OFN0CzSZjXXfRl5WqHNBOIAWZ0zJsVkKBB/OUO7Lbn3+fYX1xVMva0D72ItAUYrVxdDBj8DJ0O9KK7EbmlD3UhxL0OrgLoC3FYaYCZyeMvXltL1vqGn+9HGS2Kan8hrttQuVnrVl1hPB3m7X+714A6KQHN6CosnwzdfxxD84kVuofCKD7x+B1UYd8UTVAmxQEdw04xutblO/qUNM52GOgSekE+sRiUnZ6vU07w56770jxx2sG7EtfcIzVBSyldOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7386.namprd11.prod.outlook.com (2603:10b6:208:422::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 15:35:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 15:35:24 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Moger, Babu" <bmoger@amd.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
	"Dave.Martin@arm.com" <Dave.Martin@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peternewman@google.com" <peternewman@google.com>, "Eranian, Stephane"
	<eranian@google.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
Subject: RE: [PATCH v4] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously Unavailable RMID
Thread-Topic: [PATCH v4] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously Unavailable RMID
Thread-Index: AQHcOgiP4L8gd57umkqRK265GO6eFrS740OAgAAmcwCABC3akA==
Date: Mon, 13 Oct 2025 15:35:24 +0000
Message-ID: <SJ1PR11MB608387EF18E2BEAE9F719899FCEAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <0475e18db309c3c912514a6c4e7f7626297faa2b.1760116015.git.babu.moger@amd.com>
 <9771a165-e7dc-4e34-960c-37b17bd996b6@intel.com>
 <3ad9c3ff-12be-47b8-8bcc-fdf4f1e8fbb7@amd.com>
In-Reply-To: <3ad9c3ff-12be-47b8-8bcc-fdf4f1e8fbb7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7386:EE_
x-ms-office365-filtering-correlation-id: 782a2117-1826-4691-5560-08de0a6e20f4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SmRMRTFHdVdzUXJlRFJScWNxUXhtNDl1VHZRRmdYc05EWUp3OUNlMy9FU1Uy?=
 =?utf-8?B?bjF3elJNc2NiUHpjek5QeERXOTZacjZJR2NzUkdWbldDRGhudVFndWtCWENI?=
 =?utf-8?B?cUpLMEs5VFVVSlpIcUdwWDJvL1dxUDdDaEJ5bWVVN3FjSjZzK3hsUHVnOUlM?=
 =?utf-8?B?N0FLTllQeWtaZkd0Zis5UVF3cjZIaGtIbmk1N2hNSGtMK3BSRnJyYVVlNmFU?=
 =?utf-8?B?bTV1VGpBcUUzRlFuN3BpaklNOVcyOEVndWF1U2lRbWJvOTNwK0RCS3QyTUlo?=
 =?utf-8?B?MXkrOElEa05mT0t0cGZDWHczbWgzeUxzNzFoc2JCbUNFSEh6QytvYXB6VVps?=
 =?utf-8?B?RFdYRXNkYlZVMGlxN2lqQmxIUEtQbkhJQllRZ2s3ZWl0eHJOVVpDVnhlbXUv?=
 =?utf-8?B?cTVRYVl5MHBnQWcrT3pzYkNsb0ZCUUo4M2NQQjkzS0E1bU5VaHZUa1c1eWhn?=
 =?utf-8?B?VG5wNXNXYkV5ZzkzRDY4aDZwS241cUFiTXFKMEdWclFsOXpXM1YrUUEzWTJu?=
 =?utf-8?B?TEl0UVc3d21WUW5DK1FsRWZUOUVCeW9KYkFZUklsbHJXcTdJVW96UTZzRW5w?=
 =?utf-8?B?T0E4REVBaHlLM1ovQ0xvTXUxYjJiZkkrRUt5ci9wcE11WWtvM0RhT2U1N1VK?=
 =?utf-8?B?eUJMVUUxUUpTNlBFN2lOR0RjcnNPWU9Bb3RBREpaWnlOTy9IQ2hFd3BEQzg4?=
 =?utf-8?B?SkV3MG9LTVBkSkVTN2VJaVZCdGxVVENaOTNUMkxJUDR6MnMrVmhvc1BGY2tS?=
 =?utf-8?B?UVBpUmNpbnUwM3h5S2FacGp4eDFpRENvK0h1SU5ybHo5eWR0anh0aTZvSFZQ?=
 =?utf-8?B?SXQ0WWxDT0lrMGdsMjNZanVPWk9QS1I3UDVDSEsrbVBpNXkwNmlEZUdKOUFt?=
 =?utf-8?B?NDB4UU04ZFdQc3FiQmdsVUFsUE1TVlFCNVNJNHp1Y1lVbW1sZEFBWmpFKzht?=
 =?utf-8?B?TzFxUnladVlCR1BrK3BYWW1yR2JSSDRVKzNXUDVBZU9nM2g1aWdtSG9SekVp?=
 =?utf-8?B?MXhGY1VMWGhaNm1tNml6aVlQdTFaaWVwSEl0MlpXNmRwN2ZXQmZpVkpwZzYw?=
 =?utf-8?B?Q0FzZzVOOW9xS1RUSVN1bUx2Yk5MUHRVdUIweFBYMnF3RStWeUQ0UFBtUTl5?=
 =?utf-8?B?b1FXcHZoK0Exa1htUFJMZVE2ZUlhVk1XSGdkTWw4dldFQnppYVRMZC9aUU5w?=
 =?utf-8?B?N3dDcWJiY2NiTlY3QU8vZzlNZmhZcFNXRUhhV3JRRGhtbU9aY1p1SHdIV2xC?=
 =?utf-8?B?eVVham9XZTVGTmJPc3RZcjk3Mlo2am42WHk1dFd1alZIc3d5OU9ZU3M3ZEtG?=
 =?utf-8?B?cmRBTGgwYzRJaTF2RVlWalhtRE55WFhlWitKR2dodWJmZUluMTd1M1Iya0NQ?=
 =?utf-8?B?REpycjhHd3ZGT1BaYThTV0RialdldUViUmFlVlp6QUQybnpUTlN5TnBUNmly?=
 =?utf-8?B?SVZtelVxSEM5MjJxWnNuazI4K1hBSjM0elB3eWpHdityU3V1SlY0NFVwSHRo?=
 =?utf-8?B?Nml0a0RERU1zVWtRQ2V4Z05ZM3E4YzdmRmdYaUZCcnJ3cGEyaVE1MFFIM0du?=
 =?utf-8?B?WWhXVWRxNTdMVG1lbktKVHRBbGJSZzNuOUJidlR5RG1yaktCQUF2VkxGSFIr?=
 =?utf-8?B?TENYOFV1bGplR2hhOXZPSVRiQ014T2NXb1JRYjVFSGV6UXlSZys3ek9NcUY0?=
 =?utf-8?B?TmV6WFlLU2RHRlB6VDVoYUdpSHJGMVhUNUtpV2tWS1lFd1FrUHhNRXJQQTU3?=
 =?utf-8?B?SEFXZ2ZJR1d0dXZWWGhQYlI1ZTVwMjdHbFRIQXpDdlhUaGlId0FwRFZpWDBl?=
 =?utf-8?B?NGtPS3QxbG5hZkl2azR1Qzc1anFiUmR3WFhvakpEN3FzVHI3S1l3THBRUlpi?=
 =?utf-8?B?MTEyc2VsR3F6UkU3WERTbUJoYS8yMEw2UU1KWlhHTXdzMm1rSzg4aHk1VFdE?=
 =?utf-8?B?UXk1QUdpZW9NQXQ1TmFxVmpTQkM2M210eCthRy9BZzJiWVFWdWoyYi9ma1Vj?=
 =?utf-8?B?dkduaGtFejlqMFJCcHJENXM4UXBxdHpNR0hXaHIzOStEc1JBUUdmVDZVMm9w?=
 =?utf-8?B?L2JYZ0hhcWl1dzVkMmtQZTZWMkV1V2RWN0hPUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WURYTzZzd25iMytSRjA1dzRUa1p1Sy9VS1M4dkJUQk0rZkI1eXFiYXptaHZu?=
 =?utf-8?B?eURtYmY2bGQzOE9JVm9wQVBOZCtaUitPQkJNQ0pVS0VEbC81alkwdkJxRHE3?=
 =?utf-8?B?b2pheWNQZVJZbk9rWGZoTEVBTVBMcnVZZmVNQjhDbWNxcHpndGU3YWJ2RDVH?=
 =?utf-8?B?TWU1cXhRN21nOFZUSFB5K2gvMjY5RWlKemdFZ2IzVEt2N2U1VjZBOW82N0do?=
 =?utf-8?B?ZU1YNWhFOHl1KzF5Y1dBZk1vb1plc0gxVktvVkJuZTdLZVYwN203ZnRhNEhX?=
 =?utf-8?B?V3V2S0NOSHljMVlZUXVUY1dwUHBqb2ZDcTkzNDd3T1hvdlBlN2JNRXNSSEdh?=
 =?utf-8?B?YzBQUWxsem1MamUyanpkcUFkemkzb0RDOUlvMEh6bXpLMDVTeFVwOS9UUTlF?=
 =?utf-8?B?U1NoSXhDRHFFSWcwTm9iR1NNd2VRSUcwaUZoQUowU28yWmJKNWJCdCtoNUxO?=
 =?utf-8?B?dGNFSjExeldJWEVSUm54b2Jva2ptcXdjcXpOakRhQ3l5eVFGL3lhaWcrQW9v?=
 =?utf-8?B?b3FaNHlIWThrM2VoNDI1NklXRWE2clVjQzdFOU9RTTVuNEJrbEFjNE9aempi?=
 =?utf-8?B?REorOWFjbjVuTFd4MjdJZ3FKUmY3bkZSUmtJc0ZWRXBQWjBiRHNTV2FIc3R0?=
 =?utf-8?B?aXdjcEVZK2ZtUWVrQncvWXpXYnhkazhSb2IraDlMWlVyNVRIT1dBVjl0aDBo?=
 =?utf-8?B?UldtcXBMQU1iWjhYYUpXaHhuQjljUXIxS2duSlJ1RGQ4NVRQbUVkeXJlUnh2?=
 =?utf-8?B?aFRCRzFXYzF0UGwyamc5MGZrb282TUkrczFyODlOWFhOYzBXd3V4aFQwN28w?=
 =?utf-8?B?VjNqUmdBRGIyazRxMGxwb2NnM2d2UVBUbjVYaUtlNTZLUmZjRys0R1NjdlAz?=
 =?utf-8?B?WDA2SmdNYjdvajh3WXJkRzlKZE50QUdDUmtmUDFCMFFDbk1RMG9acTBuZ1BH?=
 =?utf-8?B?dXFCOElCak1iMmJqcmpGd1FGbm9VSGZUcEVLOW4yNVpBck9YazgrckpSOVVZ?=
 =?utf-8?B?bGtRU3d2UVE5MlFYbEdQZ3BwYjM0b3F6STJnUkFDVEg3Nmp5cWxBWVdBNmRi?=
 =?utf-8?B?UnQ1VWp0aXpnSFZ4WGN3VlFtMzFvUXRqRkZyWVkvL01BdzNBRmxFaVFuVVdh?=
 =?utf-8?B?em9mbVkzREZtV2d1ejRxZ0Iwa1lNYzVTbTdtdXdpTWJwSEQwY3pXU3pCYXBE?=
 =?utf-8?B?ZzBoRmtFQ0MvWWFVeU8yN1NxUXh1ZG1JL2JQbVRESVUvZGJQME5OVjM3eVpn?=
 =?utf-8?B?L0ZKVWxHOHpnSWJQM1NkZ3BWR0NBT0VkRGJ2eHlvOTlYS2hHWkRkV2lncUta?=
 =?utf-8?B?aTNYYml0cHZnK1dQc1k4bXRhckozTUhvNWxmQ09hTDQyQlMxQW1ZY2xrbm1D?=
 =?utf-8?B?SFRDZkZtZ1FBc1Nmak5xNGhCQVU0S09oL2Izdm9XN2gzZkI2MDFWeGREK0RL?=
 =?utf-8?B?enJWM1ZBbjZBTU0xMVFzT3VsZ0ZCUktEeE5FQ3drNDdYQ3dKVzVmMXoxN082?=
 =?utf-8?B?dUxaNGJoZUViaUhsbjNpRWYyZmo1bWJqNmgrM0RBSldBNk1HdEFJektFWEYv?=
 =?utf-8?B?QjQ3Z29LSy84VExyLzNXM1l1WUhRZUNIRlg5SGNZY1lkK2pqZU0xUVZTNDZm?=
 =?utf-8?B?cEpXQWkyTEQ1OXdzNFB1eGg5NnBLZU5NOWxQZ1F4QjNuQllRcGtLVWJPVy9m?=
 =?utf-8?B?Y2hTNGRSOWkrc0Q3V1lNYTlvTm91YVpUcVYrcEdyM2ZGMFRqaExnK1BEN0NR?=
 =?utf-8?B?Uzk0ZDY1ZUxodTdtQ1Zwbldmazk0S3lLZnFDRUN6SlNCS0VEL1RPajRTLy9P?=
 =?utf-8?B?dG5HbWkxblhVUkxEdFQ3aHlqb3JkLzFaUXZCNGM1L2FrQUFleW10Y2RjZXRh?=
 =?utf-8?B?MWRGUTFVQWJYTTZyNTF5SnVUVCtmZ2d0cGFleDlUVkM2VTY3TWxMRUh5bGVJ?=
 =?utf-8?B?dXBjeTdZMVg3Y3hKb1dQbGFCeGJCNjZ6WGtJTHgzVGJZVXhHZWJGZlVxQUFD?=
 =?utf-8?B?c2FqMUVDd3RENFBiM1owWlJBeUpYaWk3cjFIcExieE9VRldxU1pvMUZBN29m?=
 =?utf-8?B?SHlCOFM0YzNsUks5T0lsYkE0VTcrWGdhSjdIR21rWS9XOGxWOFpPZ3Q5azNt?=
 =?utf-8?Q?16Vo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 782a2117-1826-4691-5560-08de0a6e20f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 15:35:24.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0t6/gELZB3DdqdIFva8adwKrrFPlFoKGX1rwEMQNGhq51mjrzXQRDTOO1CgeEIknCnQEeslhcQzxf87RqwW1Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7386
X-OriginatorOrg: intel.com

PiA+IFRoZSBiZWhhdmlvciBvZiB0aGUgY291bnRlciBpcyBkaWZmZXJlbnQgb24gSW50ZWwgd2hl
cmUgdGhlcmUgYXJlIGVub3VnaA0KPiA+IGNvdW50ZXJzIGJhY2tpbmcgdGhlIFJNSUQgYW5kIHRo
ZSAiVW5hdmFpbGFibGUiIGJpdCBpcyBub3Qgc2V0IHdoZW4gY291bnRlcg0KPiA+IHN0YXJ0cyBj
b3VudGluZyBidXQgaW5zdGVhZCB0aGUgY291bnRlciByZXR1cm5zICIwIi4gRm9yIGV4YW1wbGUs
IHdoZW4NCg0KTm90ZSB0aGF0IHRoZSBoL3cgY291bnRlciBkb2Vzbid0IHJlYWxseSByZXR1cm4g
IjAiIChleGNlcHQgZm9yIHRoZSBmaXJzdCB0aW1lDQphZnRlciBDUFUgcmVzZXQpLg0KDQo+ID4g
cnVubmluZyBlcXVpdmFsZW50IG9mICJzdGVwIDEiIG9uIGFuIEludGVsIHN5c3RlbSBpdCBsb29r
cyBsaWtlOg0KPiA+DQo+ID4gICAgICMgY2QgL3N5cy9mcy9yZXNjdHJsDQo+ID4gICAgICMgbWtk
aXIgbW9uX2dyb3Vwcy90ZXN0MQ0KDQpXaGlsZSBtYWtpbmcgdGhlIGRpcmVjdG9yeSBtb25fYWRk
X2FsbF9maWxlcygpIGRvZXMgdGhpczoNCg0KICAgICAgICAgICAgICAgIGlmICghZG9fc3VtICYm
IHJlc2N0cmxfaXNfbWJtX2V2ZW50KG1ldnQtPmV2dGlkKSkNCiAgICAgICAgICAgICAgICAgICAg
ICAgIG1vbl9ldmVudF9yZWFkKCZyciwgciwgZCwgcHJncnAsICZkLT5oZHIuY3B1X21hc2ssIG1l
dnQtPmV2dGlkLCB0cnVlKTsNCg0KV2hpY2ggaW4gX19tb25fZXZlbnRfY291bnQoKSBkb2VzOg0K
DQogICAgICAgIGlmIChyci0+Zmlyc3QpIHsNCiAgICAgICAgICAgICAgICBpZiAocnItPmlzX21i
bV9jbnRyKQ0KICAgICAgICAgICAgICAgICAgICAgICAgcmVzY3RybF9hcmNoX3Jlc2V0X2NudHIo
cnItPnIsIHJyLT5kLCBjbG9zaWQsIHJtaWQsIGNudHJfaWQsIHJyLT5ldnRpZCk7DQogICAgICAg
ICAgICAgICAgZWxzZQ0KICAgICAgICAgICAgICAgICAgICAgICAgcmVzY3RybF9hcmNoX3Jlc2V0
X3JtaWQocnItPnIsIHJyLT5kLCBjbG9zaWQsIHJtaWQsIHJyLT5ldnRpZCk7DQogICAgICAgICAg
ICAgICAgbSA9IGdldF9tYm1fc3RhdGUocnItPmQsIGNsb3NpZCwgcm1pZCwgcnItPmV2dGlkKTsN
CiAgICAgICAgICAgICAgICBpZiAobSkNCiAgICAgICAgICAgICAgICAgICAgICAgIG1lbXNldCht
LCAwLCBzaXplb2Yoc3RydWN0IG1ibV9zdGF0ZSkpOw0KICAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KICAgICAgICB9DQoNCklmIHlvdSBkaWcgaW50byByZXNjdHJsX2FyY2hfcmVzZXRfcm1pZCgp
IHlvdSB3aWxsIHNlZSB0aGF0IGl0IHJlYWRzIHRoZSBoL3cgY291bnRlciBhbmQNCnRoZW4gdGhh
dCBiZWNvbWVzIHRoZSBzdGFydCBwb2ludCBmb3Igc3Vic2VxdWVudCB2YWx1ZXMgcmVwb3J0ZWQg
d2hlbiBhIHVzZXIgcmVhZHMNCmZyb20gdGhlIHJlc2N0cmwgZXZlbnQgZmlsZS4NCg0KPiA+ICAg
ICAjIGVjaG8gJCQgPiBtb25fZ3JvdXBzL3Rlc3QxL3Rhc2tzDQo+ID4gICAgICMgY2F0IG1vbl9n
cm91cHMvdGVzdDEvbW9uX2RhdGEvKi9tYm1fdG90YWxfYnl0ZXMNCj4gPiAgICAgMA0KPiA+ICAg
ICAxODM1MDA4DQo+ID4NCj4NCj4gVGhhbmtzLiBUaGF0IGlzIGdvb2QgdG8ga25vdy4NCg0KLVRv
bnkNCg==

