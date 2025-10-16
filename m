Return-Path: <linux-kernel+bounces-855627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE90BE1CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09DFC4E6800
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E22EAB89;
	Thu, 16 Oct 2025 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1dTj6rj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F61FECB0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597297; cv=fail; b=SiBgYWW7/O41ND9AZxZ2ETa58FR8NPUJZXLV0ycdb6XFiCWe3Axq3dqKVZ/ETAFcQc1YTC6QFH71GIgdjo3A+qqUUyrp8IopnuhQGQoyzDeCdmBeVOJUfHHS13vqBmYmcp0OdfyDynWV7N9AgpElxwrIgt5wmSqssvN1gjQ1awo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597297; c=relaxed/simple;
	bh=3T6JWGJ7X7TQF9C3x6bxdtE/fKjacleIfpsSxCD9d74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQVlgaAYiG8yzSfRpPOnKxCApnL0Mlmm2zpzaz6eiIefMty4RHp1otabzwXh1rChGt8JENFjOwIKs8oZ45qfcYArBjUYaqbvoCuxYpu/JhMILu2DmDdMv7Z/Wx4V08gD5FYCpvnXEhQB/og3YZf3KJ2ORNXScREZD+/37wkdQA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1dTj6rj; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760597296; x=1792133296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3T6JWGJ7X7TQF9C3x6bxdtE/fKjacleIfpsSxCD9d74=;
  b=j1dTj6rjuDpJjVgCThP5LzjX1Tkxr3TqkTLyHphwOlP1ZouwjeaNdhvD
   TCm7LIdSmlhID2iBDmc807JlILzysIQ+9WWX4l8BItGZPr0KFlAvpW6E2
   5jdpnRKNqX6wltd1tl/7eh6UU+2o8czwI7qroGNyFw1h7ixTokXaaVrw5
   EbDVoGZpCf2h+qpfuLvNh/FOso6wW+tS4zF5l4rVsNGy3x0ltKehX8ikj
   qvpnxESJV9R0dVk4cRG6+qfUwa5f7WTtMVA3NWfxVlAKZUv41AzRTn81C
   ZqbPMIzS4LRoWujG6BSsvnKIMc8uBDA8enixInQZjW0CKKTGW1YNq1Zx5
   g==;
X-CSE-ConnectionGUID: RX7nvh+2S7u8nfyliyZKdg==
X-CSE-MsgGUID: pHo5y4lgQVirkQ3XR4/spg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73893404"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="73893404"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:48:15 -0700
X-CSE-ConnectionGUID: n6Z8t4xsQK+s5xDsUMC2Kg==
X-CSE-MsgGUID: K6k/829ITbaBkOuwkZjp7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="206080754"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:48:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:48:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 23:48:12 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM0+MfCQ2rblkawH/H42Q99KMFGBYMe7Heokq1A/cHegnTeKIbIzDxCp7D73H3ARXLu3EeoTiOLvKaqgAeoNIcmyAtRXgjl/iXQt+adj39p2JO+nkPkDmN5bgJiECuDSLBRjwjE0l4GrqZVZJgxvu3KqsuNGU6XH31XfyNodQgObQoa3RTH3XsmIwD7qlUjxFksqvb4wgdkObTLwHK4S2OgB50AogjYmQAZ0RlGav4ppGS1d8nD1eIb9grOjXWRuJLF8X3j3ymuz4B26uGk2Qm/MiyxjqOQySwRTJAwvCImg/zqw2cS53tACeZfJAehaxeud3QNwFlyfKv/aoCDLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T6JWGJ7X7TQF9C3x6bxdtE/fKjacleIfpsSxCD9d74=;
 b=aJ2Rhr/ZYlfnbmmYfl9lJGu5YsUSrR5mUJX5P7PaGhNh9wD089sh2KUhW9c8fxPerI5K5Vf91NX5UJ1eYEwa1TFTCrFP0VUDhjV0yYvIWLbFUHSobbpCmDGA3X5KxGVR7phdGaYD0WqbgF4sFrO5OlvuHsa8/JcXwlGYLuUtuySMMoOdogIx2Hr/Miy0WSUNca6NfPJRE/XlVCwmCN4ubTiDmohMGWW8BW8u0VHSUonSo4OE2+ncYWWQveY4n6IqBipvWcrtp2eu7dUG5CN6hdI53aGGuMDa60FebRpWMKMRYtJ6KKFXbk2RhoxBzTb4oMD/v5Wa4bB/E/cNKrYCxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB9495.namprd11.prod.outlook.com (2603:10b6:208:59f::17)
 by CYYPR11MB8330.namprd11.prod.outlook.com (2603:10b6:930:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 06:48:04 +0000
Received: from IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::fb49:1b0e:8ebc:254e]) by IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::fb49:1b0e:8ebc:254e%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 06:48:04 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Annapurve, Vishal" <vannapurve@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v2 00/21] Runtime TDX Module update support
Thread-Topic: [PATCH v2 00/21] Runtime TDX Module update support
Thread-Index: AQHcMn7PzLsl5dUPTEikD7KJ8NM7q7TB2pCAgAEhGdCAAFyngIABE88A
Date: Thu, 16 Oct 2025 06:48:04 +0000
Message-ID: <IA1PR11MB9495837A621D8F0C7DB8F2D5E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
 <CAGtprH_FzXjnC0Rbctpvm2_kqAAnUOfnaT4885fBiAi7s0jcXw@mail.gmail.com>
 <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH93h_f11-mBRExr7xwN284Otnk6vi9R-b5PfVtL+wvXaQ@mail.gmail.com>
In-Reply-To: <CAGtprH93h_f11-mBRExr7xwN284Otnk6vi9R-b5PfVtL+wvXaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB9495:EE_|CYYPR11MB8330:EE_
x-ms-office365-filtering-correlation-id: 1c9398bd-ff23-4bee-457d-08de0c7ff53b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K1hmbDhQY3g0cFhsYmNwT3M4MlFwTm5Bc29TNXdSQ3V4RUJwLzFrdkRBVVhu?=
 =?utf-8?B?SkZvS09FNzk2SnY3ckJFSWFIanpuZGlDQXJjVDRTY3A2UGl6OTVLZEM4TUxl?=
 =?utf-8?B?cFdHc0Y3VlJ4ZWxNQy91MmxvN2IzK2xCOXp6ajlIU1EzTE1CNHptelQvdldm?=
 =?utf-8?B?TGIyZnJqeWdQVVhZZ1VKWG1iNGxyU2VnUG9LRVNiQ2NXbnpvY2RDcldMdTRN?=
 =?utf-8?B?bGFuVkh4VTF4VXJtRkdUUUQ4cnRPVnZsaTg0Ti9FOUQ0TnNubU1MOFhac2lh?=
 =?utf-8?B?aGxXaFp2emNaWVlyQUdTOFdTZ0lhRDZqYVdjZDdUV3NuVEpMZlhYSTdBcVdx?=
 =?utf-8?B?VkJKa2ZHUXIvTTQvU3NmQ1dydHNoaWp5ZlBuaEdrMmZqVmU1UzF6Ly83RjBM?=
 =?utf-8?B?b2FmQnJzNXNnUnZIQ1pkb1lVSyt0QjQyOEplV2czWm0yZ1NNbFlldVNjelEz?=
 =?utf-8?B?SXBMOVZYR1Q5NVNxamdNMkVoNURYUmM5MFp4eW1INUNZY0ZaYUlpS09TcmQw?=
 =?utf-8?B?MWhKVFRSTmhvdHpOTjlrMlVRVCtjZ0JxSmZ6cHp6L0tBZkhtQ3hzUHJLeGxO?=
 =?utf-8?B?elB0ejdkc2pKL1Q2aThEaUwvUlFmaVZTM1pUTzRpUkJNOWVVN0xySGMrLzkx?=
 =?utf-8?B?QU9lK3FXdVN0eVhRT3VqM09FV1hSb05LVncrZU94V3JqYTBmY056Q0ZZZHhP?=
 =?utf-8?B?eHBVQ1FSVjlXT1JGY3NvQ2hjOUI1UE5BK04xODF4OFhOMTI0ci9JdGUrUXlw?=
 =?utf-8?B?Z3JMMkZ3ajRRV01JRy9PZWZ1Q2lCRmpHN05JWVJ0OXArZlQvSStCMGZLRUJt?=
 =?utf-8?B?VkVLNUNldklTa0JtRC9lVEF4YjVxdUwySkFrZ3FId2N3cmwxdjVBYjNCZXJo?=
 =?utf-8?B?aG9PNTlnb2dMOWFQbUJHQkZ2UnIrWkpPNWtJSFY2bWp6Q2ZBNlBEQjB0VTUv?=
 =?utf-8?B?MXpJMTNkRFhBZFVKS1VDSWVZWE5HckpXWWVyUXE3cXRTSmlEblNjd2lqSTh5?=
 =?utf-8?B?NFFSS0lDdEpSYTZtNkZxVjdjaWorNzRYZkJZUmMwZmE4STc0UUFGNlFWZ0ZJ?=
 =?utf-8?B?Y25ONlhCY0puUmZEU0RDTWNYNFVXREhyaGY4c1Zkb0VudVJmQUlNK2ZyWGZo?=
 =?utf-8?B?K3VBWlZvZEN2eFhZMFNTclF4NERYQkx2OWxQQ0xXYlpnbkpuUXNzakdDSTZi?=
 =?utf-8?B?TDFxdkR1Y0pKS3lpSE1temNrWkpsRDlQZURHN25xZllFTTFNTGRjNFVKZUUw?=
 =?utf-8?B?dnlkS2lURE1ob2IyeTJIajYyUXM2eGY1RGVvZXJ3WmhFclQwTlFENlZENG43?=
 =?utf-8?B?V3kyRjBXbUp2NjZGUHZ4Ujl5Tk1OYUdBOURBRzBRdGRrWlk3a1Z5OU54UWVC?=
 =?utf-8?B?UllaeFBldGxpbHdxWGRkN091S0p1QytQa2ZUVnd1QTRZUkhvVmhHa0VKN0lk?=
 =?utf-8?B?VE1ZUHNEeUNnaEFydGt6MzNxZy9oVHFEWDg0UHlHRHQ2QVpRSEhnTklNRmpq?=
 =?utf-8?B?N3dFenZQMk5ZQ3FON2lJUFBIVFdMajhsNG9oME90UVZrTndkRHp5VWNIY3Nx?=
 =?utf-8?B?SmU4NWxlSkM0d1VsQm5NR3JXZkp0Z1VUSGoxMlE0eENMbkFFbjRscWVQcFBD?=
 =?utf-8?B?YkJxdEd0UE9jVVMyRDIra3o3d0FObzV0UkFNYkg0dWlMVFRQK1U4K1pDc2VR?=
 =?utf-8?B?anZzSWk3eG9QczN6L0VCNkVJVnF5MVJZZ2txa0g4ajlMRG9kQnJXV3NWaGJz?=
 =?utf-8?B?VEpwTlJFYzRncFZqbFZ4QWdGbVlBNXEvUUtLQUhDU29QR3J5ZDVlK1g5MjR0?=
 =?utf-8?B?bW1NOTZsbG9DcUhyc0UvSFBRNXU2RTBVRnRlS29PQWVsaTM4ZzB6a2F6ZWFy?=
 =?utf-8?B?SkpnWFdtazE1bmdBRVJTRU5wMk1teElMWGMzZUpZMTRzekdkeWJORk5GNTQr?=
 =?utf-8?B?UnRhNUYzU0xwVHpydGFzTFVNOElnclFocmR6OEt3cmJjdURxb2JDV0x3WE0x?=
 =?utf-8?B?UXJDSTBzTWtFdXpkSFlVVkxncFQ2SXBmWTR4cHZYOWNHb2x4ekN2VkRmWmxH?=
 =?utf-8?Q?NAAw1h?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB9495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzRIMlFUVmM4cVJSWS9kaEJYVnBFSWg4STJ5ckxpRi95UUpHc1JKM3haaGFF?=
 =?utf-8?B?ZmptanphelRteFRSSWhqQWU4cytDY3JhcDdrdVZMS3V5bHZ4RWJFUlhQbndh?=
 =?utf-8?B?c0tQYk1YSS9GcnAxclhlYlF0dWtOM1l3MGhXcnN3TmlWWGtnYVl3dVlGVFZO?=
 =?utf-8?B?Q2Y0SlNHeEh2aVFlMm5WMjJwZnA5SndFbVhQcE9CMlJkaGpOZGNRWlFrQk5U?=
 =?utf-8?B?Njk4T1o3TVd5ckYvQWVXdEZjVmRQV0UyNzdRaGFHQUxQbXJvZXJQTXowYjV0?=
 =?utf-8?B?czFaaFNGaGkzWncvQXViby9iWEVFaWlJa21PcEx3TXpwVy83M0kxUkZuWWpG?=
 =?utf-8?B?cEUyWXVmdTNIcEprWUF6bHYvYi9HQ09UU1BtMlpYdVBSUkNSbGk3Sm1FWjVx?=
 =?utf-8?B?YnlFaXJOUGNVaEh5dlZSQXcxWW1HUmpUMk5kK01kZW5LcklKcUk0NjkxdjVW?=
 =?utf-8?B?NEpjSkduTk1NZTlLcFZVTGxLZjU5S0s5Ni9lWnNaRk91ZkpCYkFwc1orblRB?=
 =?utf-8?B?VzdJS2xPR0oxS201eTVmSDRuVnYvS2RLMnNTMEF2cVlTK21UZkd0UHVrSWdD?=
 =?utf-8?B?N0JTWHlFdHphQk1acFZ1QjNwMkZnRFhmTlhYbjlTb3RYcmZuczd5bDRQaHcw?=
 =?utf-8?B?WWhVcktOT3EvUkpaeW0rcnFXdG5vNW5NUjZMMEI2T1VLNlE3VTQxc3orNHVn?=
 =?utf-8?B?NkgyL2dTSlZJaGN3VmNZa1lVNW1CNDBRR1pQNWNMbnZFK2pTTWxTY2xzSVBX?=
 =?utf-8?B?blg1SDBtN1NTM0lvcC9uMTMwQjJqakdLdTZsOGZhMllxTXJEQnJpanI1TVBW?=
 =?utf-8?B?M0xzMVc1NWdQRGJHdzJYTWhnRGNEVkgxNTFxWmxUNlNiRnBuSlVubGdoZEw3?=
 =?utf-8?B?THdUQ2JCczFZMFdVNm0zNzJUNGRjRUZCaDAya1ltSVpNdE1oSEtPakRVZm91?=
 =?utf-8?B?RzhuRkhEbFBLNHRzbHBqVXlHTnN6ckQvekdXa2ZMN2FhRllhOGVZamRQMmN4?=
 =?utf-8?B?MENsc2JmWUUrQjFmZkk5bTF1bG51UHlYMnIvdUYyVXZueG1nRisrRVpSdTZr?=
 =?utf-8?B?VE1SZDN5VVpGcS9iQzRqSll4VXI5cTdyTjUzTmQzQ0JoZmhtZGtoTlVuR1ov?=
 =?utf-8?B?RUF4R3NVVlVrUWxxTzJXNTFsS0J0dHIyd2QwMXd1VnlCeDRPZkhkWUlxSmUz?=
 =?utf-8?B?czZKcDkxVzNmNWtIN3RGUnJjVEwzSDV4WldEZGk5SWtQNTJIMllyUzhXN2xM?=
 =?utf-8?B?WnJ0NHVNMGIwQy8wdXU5R3FtblU5KzM2VmhTNE8zSmVGN2pEM1l5Mk43RjVS?=
 =?utf-8?B?YThsTlJhY1pZanB0NWhHcTh0WFllZ0hnaE5lMTcwbVNNNk04UktRVUFvUXUx?=
 =?utf-8?B?OGRqN0VUbjBKSTd5a2FDODlNYXA1eFQ5YXNBaGprS3ppckJmT3hibzBzWU9z?=
 =?utf-8?B?ZkJ5TlpydGJhT0lXcWNWRGovelo5Z3psZW9hcll4ZXFRL2tyLy9qSnpzd0Rq?=
 =?utf-8?B?Y2RieVl0T0VxaVE4ajZTbGJwNE5OdHo4YWhuTHBOdGNMUDM4czJvMFFRV0xp?=
 =?utf-8?B?ejdIWEhpQ0xyeWorWjROYmQzMkVSOUlHY1RaM3NTT3BjZitiOW8xa2cyQTJv?=
 =?utf-8?B?bnpGQ2EzdlJGdGxVYk0rRGNSN1VmeEJEMzNGTE82d2ZGMGhzZ3NLV3dpbjJ1?=
 =?utf-8?B?c3czTHY5ck16Um9RWTdxYTAvZUdyNGJUbnVGTmMrdjhkeTI1VUZkKzd0bFgy?=
 =?utf-8?B?ZURveVlqemk5aEdRSzc1OXJ3aENaTEdYOENUdmRwVUlhZlc2MUNFd0pubVRN?=
 =?utf-8?B?dkp5VTFCNHM1NGlrREtwVzhhak1PSGJWN3d2bVVlVEFFZmRNTDZpOWtoc2ox?=
 =?utf-8?B?djd6OFE1bTU0NEJHQXF2bUxNMTVRZUg4RllVN2FPS1VyaDludHhOUEFtaC81?=
 =?utf-8?B?OHc2ZzFKdlVkLzVySGcvNUNpVzcvbDV4dUFBaUp3MzBGQW9LWHA0bnNLNU9U?=
 =?utf-8?B?SU42d0JDV2hlZ2VzbkV6NWZBLzRJNkhkYkdLRlFZeUNZUFdSR0xUc1J3dmtx?=
 =?utf-8?B?K0svajgvQ05LckEwb2FTVnJObE1mNnppbDNWSHNTWi9LRDNHc2Vuc1ZTaWlX?=
 =?utf-8?B?NzNaNGpkSzlYT0w4S1QyV2d2TW5kL3pkdTE2cVNsQ1Y4Q2NUdlFncGxydm1i?=
 =?utf-8?Q?YRSW8ynMz79zQYJa7XvqWqPi9u92rhAecTmvSQUIDGjD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB9495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9398bd-ff23-4bee-457d-08de0c7ff53b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 06:48:04.7543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oM3Y3sgwNCOUMoDfzVduuJPvzsW64PslNIcuCYCRvwxzXqv1b4N1Y1+NaQZRpdUEtwQwIXGGgy00wSqNi9W2zo8B1uGRkURHz1zqCpKIAbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8330
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlzaGFsIEFubmFwdXJ2
ZSA8dmFubmFwdXJ2ZUBnb29nbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTUs
IDIwMjUgNToxOSBQTQ0KPiBUbzogUmVzaGV0b3ZhLCBFbGVuYSA8ZWxlbmEucmVzaGV0b3ZhQGlu
dGVsLmNvbT4NCj4gQ2M6IEdhbywgQ2hhbyA8Y2hhby5nYW9AaW50ZWwuY29tPjsgbGludXgtY29j
b0BsaXN0cy5saW51eC5kZXY7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyB4ODZA
a2VybmVsLm9yZzsgQ2hhdHJlLCBSZWluZXR0ZQ0KPiA8cmVpbmV0dGUuY2hhdHJlQGludGVsLmNv
bT47IFdlaW55LCBJcmEgPGlyYS53ZWlueUBpbnRlbC5jb20+OyBIdWFuZywgS2FpDQo+IDxrYWku
aHVhbmdAaW50ZWwuY29tPjsgV2lsbGlhbXMsIERhbiBKIDxkYW4uai53aWxsaWFtc0BpbnRlbC5j
b20+Ow0KPiB5aWx1bi54dUBsaW51eC5pbnRlbC5jb207IHNhZ2lzQGdvb2dsZS5jb207IHBhdWxt
Y2tAa2VybmVsLm9yZzsNCj4gbmlrLmJvcmlzb3ZAc3VzZS5jb207IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPjsgRGF2ZSBIYW5zZW4NCj4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNv
bT47IEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPjsgSW5nbyBNb2xuYXINCj4gPG1pbmdv
QHJlZGhhdC5jb20+OyBLaXJpbGwgQS4gU2h1dGVtb3YgPGthc0BrZXJuZWwub3JnPjsgUGFvbG8g
Qm9uemluaQ0KPiA8cGJvbnppbmlAcmVkaGF0LmNvbT47IEVkZ2Vjb21iZSwgUmljayBQIDxyaWNr
LnAuZWRnZWNvbWJlQGludGVsLmNvbT47DQo+IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJv
bml4LmRlPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAwLzIxXSBSdW50aW1lIFREWCBNb2R1
bGUgdXBkYXRlIHN1cHBvcnQNCj4gDQo+IE9uIFdlZCwgT2N0IDE1LCAyMDI1IGF0IDE6NTTigK9B
TSBSZXNoZXRvdmEsIEVsZW5hDQo+IDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPiB3cm90ZToN
Cj4gPg0KPiA+DQo+ID4gPiBPbiBUdWUsIFNlcCAzMCwgMjAyNSBhdCA3OjU04oCvUE0gQ2hhbyBH
YW8gPGNoYW8uZ2FvQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+ID09PSBURFgg
TW9kdWxlIERpc3RyaWJ1dGlvbiBNb2RlbCA9PT0NCj4gPiA+ID4NCj4gPiA+ID4gQXQgYSBoaWdo
IGxldmVsLCBJbnRlbCBwdWJsaXNoZXMgYWxsIFREWCBNb2R1bGVzIG9uIHRoZSBnaXRodWIgWzJd
LCBhbG9uZw0KPiA+ID4gPiB3aXRoIGEgbWFwcGluZ19maWxlLmpzb24gd2hpY2ggZG9jdW1lbnRz
IHRoZSBjb21wYXRpYmlsaXR5IGluZm9ybWF0aW9uDQo+ID4gPiA+IGFib3V0IGVhY2ggVERYIE1v
ZHVsZSBhbmQgYSB1c2Vyc3BhY2UgdG9vbCB0byBpbnN0YWxsIHRoZSBURFggTW9kdWxlLg0KPiBP
Uw0KPiA+ID4NCj4gPiA+IFsyXSBtZW50aW9ucyBhYm91dCBhIGxpbWl0YXRpb24gb2YgZG9pbmcg
cnVudGltZSBURFggbW9kdWxlIHVwZGF0ZToNCj4gPiA+DQo+ID4gPiAiUGVyZm9ybWluZyBURCBQ
cmVzZXJ2aW5nIGR1cmluZyBhIFREIEJ1aWxkIG9wZXJhdGlvbiBtaWdodCByZXN1bHQgaW4NCj4g
PiA+IGEgY29ycnVwdGVkIFREIGhhc2ggaW4gdGhlIFREIGF0dGVzdGF0aW9uIHJlcG9ydC4gVW50
aWwgZml4ZWQgaW4gYQ0KPiA+ID4gZnV0dXJlIEludGVsIFREWCBtb2R1bGUgdXBkYXRlLCBhIGhv
c3QgVk1NIGNhbiBhdm9pZCB0aGUgcHJvYmxlbSBieQ0KPiA+ID4gbm90IGNvbmR1Y3RpbmcgYSBU
RCBQcmVzZXJ2aW5nIFVwZGF0ZSB3aGlsZSBURCBCdWlsZCBvcGVyYXRpb24gaXMgaW4NCj4gPiA+
IHByb2dyZXNzLiINCj4gPiA+DQo+ID4gPiBEbyB5b3Uga25vdyBpZiB0aGlzIGlzc3VlIGlzIGZp
eGVkIGFscmVhZHk/IElmIHNvLCB3aGF0IHZlcnNpb24gb2YgVERYDQo+ID4gPiBtb2R1bGUgZml4
ZXMgdGhpcyBpc3N1ZT8NCj4gPg0KPiA+IEl0IGlzIG5vdCBmaXhlZCwgYmVjYXVzZSB0aGUgbGlt
aXRhdGlvbiBjb21lcyBmcm9tIHRoZSBpbnRlcm5hbCBjcnlwdG8gY29udGV4dA0KPiA+IG1haW50
YWluZWQgYnkgdGhlIElQUCBjcnlwdG8gbGlicmFyeS4gRGlmZmVyZW50IHZlcnNpb25zIG9mIFRE
WCBtb2R1bGUgY2FuDQo+ID4gdXNlIGRpZmZlcmVudCB2ZXJzaW9ucyBvZiBJUFAgbGlicmFyeSAo
YXMgYW55IGdvb2QgU1cgdGhhdCBhaW1zIHRvIHRha2UgbGF0ZXN0DQo+IGFuZA0KPiA+IGdyZWF0
ZXN0IHZlcnNpb24gb2YgaXRzIGRlcGVuZGVuY2llcykgYW5kIElQUCBsaWJyYXJ5IChhcyBhbnkg
bGlicmFyeSkgZG9lcyBub3QNCj4gPiBwcm92aWRlIGFueSBjb21wYXRpYmlsaXR5IGd1YXJhbnRl
ZXMgb24gaXRzIHJ1bnRpbWUgZGF0YSBzdHJ1Y3R1cmVzLg0KPiA+IFNvLCB0aGUgcHJvYmxlbSBj
YW4gc2hvdyB1cCBpZiB0aGUgb2xkIGFuZCBuZXcgVERYIG1vZHVsZSAocHJpb3IgYW5kIHBvc3QN
Cj4gPiBURCBwcmVzZXJ2aW5nIHVwZGF0ZSkgdXNlIGRpZmZlcmVudCBJUFAgdmVyc2lvbnMgYW5k
IElQUCBoYXBwZW5lZCB0byBjaGFuZ2UNCj4gPiBpbnRlcm5hbCBkYXRhIHN0cnVjdHVyZSBmb3Jt
YXQgaW4gYmV0d2VlbiB0aGVzZSB2ZXJzaW9ucy4gVGhlcmUgaXMgbm90aGluZw0KPiA+IFREWCBt
b2R1bGUgY2FuIHJlYWxseSBkbyBpbiB0aGlzIGNhc2UuDQo+ID4gQnV0IHRoZSBzaXR1YXRpb24g
Y2FuIGJlIGF2b2lkZWQgZnVsbHksIGlmIFREIHByZXNlcnZpbmcgdXBkYXRlIGlzIG5vdA0KPiBj
b25kdWN0ZWQNCj4gPiBkdXJpbmcgdGhlIFREIGJ1aWxkIHRpbWUuDQo+IA0KPiBGZXcgcXVlc3Rp
b25zOg0KPiAxKSBIb3cgaXMgVEQgYnVpbGQgdGltZSBkZWZpbmVkIGluIHRoaXMgc2NlbmFyaW8/
DQoNClREIGJ1aWxkIHRoYXQgaGFzIHN0YXJ0ZWQgYnkgVERILk1ORy5JTklUIHdpbGwgZW5kIG11
c3QgZW5kIGJ5IFRESC5NUi5GSU5BTElaRQ0Kb3IgYnkgdGVhcmluZyBkb3duIHRoZSBURDsgb3Ro
ZXJ3aXNlIHRoZSBURFggbW9kdWxlIHdpbGwgc3RpbGwgY291bnQgaXQgYXMgaW4tcHJvZ3Jlc3Mu
DQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hLg0K

