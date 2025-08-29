Return-Path: <linux-kernel+bounces-791051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23831B3B17F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE13D3AC9A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFD2221FDA;
	Fri, 29 Aug 2025 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U32LWYKG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FEB1C5F39;
	Fri, 29 Aug 2025 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756437079; cv=fail; b=dyw6P/v1+doEEA56KrUmTcEMN222LbNUb6ahGw6t7Yf+cFhDBa2usDO0Gm/dxQzjK5z6GcThIUMs7oorPfpGpSLGEzAv59hOw7l+E5oqqqRpXBxoMctjL9gtM0pGMbOpjXW2uxD/AmsBNDPYGto/tPtOpX0LcjyUujgwU/RPURM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756437079; c=relaxed/simple;
	bh=r1eAn4nkN3YT2A4CQV6GhDTVbHin/govj4JoVj3tkTo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CjLslsYd7uqraRYenUi+Elb7FbMd0joRczmlURSotA/ot8CbNUFSJxSvTnSOrXtxsQW+3pWhxmFJu+gSSMIn6WQXrBbetbUACxnxPZkjdW7SotJjd4CyMpNMudeyFnr1yHKGF8ZJUzKaWz5/8nDQpESFbwKQVgta20f5/Yo1tY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U32LWYKG; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756437078; x=1787973078;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r1eAn4nkN3YT2A4CQV6GhDTVbHin/govj4JoVj3tkTo=;
  b=U32LWYKG3XfqQkv4aMT0/7dgdykXsjnGpJoOuGYliGJZVEMk79tuz78J
   hsYzg7D4UbYSt6h+4KXwp92PDWNyPpzIhYapCXvL669v9AI19Yy+5HiAr
   F/MH/89O8s+U9sr/YV8pSO7wHeX4RCYib+23nsyJ9jd5a3dJqmoYrGjZz
   3kptaQqlEF+uXKb1ByRzcyBrZIIQsfr38x2YLn63gHwwU6Cra8I3phPFV
   GVYPD8QpsvimPVAObUgBauUAmwThwiteuRO9Cq2L2ITtSv7M1LvFSp54d
   T7wLo4XRYRnQNGd1Euw4eh3AdedQbnHCXfEEJ/4NrmNA3y+GP4PIvew3H
   g==;
X-CSE-ConnectionGUID: 3D+CzuDPQH6BHxCBaY/P3w==
X-CSE-MsgGUID: H1Qk89UJRCGg+dASmRD2FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58784458"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58784458"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 20:11:16 -0700
X-CSE-ConnectionGUID: XJccGwnkS5KsBdDpvTy86g==
X-CSE-MsgGUID: js9rDbJYTgi8/BsZ65Speg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170180178"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 20:11:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 20:11:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 20:11:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.53)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 20:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2zLPl8pW9ziWgP8zI6AbRZFRZBCV5CQ3kixJ8RuUssI7A6CSDfC21/9hlkr4kDF14xuy+h2aW+F30QHsOh90E71L447w1pQQOlcBQ/f9Z1l01qzAloydk2Z6edqiKTvK3RygrErELNe98GUYeOUPW+SF6MK+L4BCis2Jm1BK9VTvge39wwEJU2n7aKCkzCJ4MXZiIL+m1ZhRvBANgn3C8+IrxKGC2N2RS+LvvtFwhf8P9kU2DiVvQnrJVfklU+fEPBtiV6Ys+d4Bt4Z3knXBcsO3a3dbQSwuomg4DTTywKevxGMvs1LeCao6ixyD/zmP7rG4fv4JrXGql0B54FAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnMU3BQ/rzfhjzt0Yy7mGAmxNaWGRISVznFoqv+E+0k=;
 b=Ux0OIfahwvGpsx9oXDY+aaufuW3wgdBPGKyiJXQUoUWUAAI3tTwc//wDOMLyyvOvBZMdRambecu+g7eMokt3LCASbq+yX2BTh5bf/KPjZd8If4nF1I6hKGw5s0gJ/fkkB1p68ViOpI4ddRot8OUj1kGshP4r/5uDuQO1+zjjO0QO5KhoNSFFKrJAgqAeJV+xRrUma9mLd4ecarocDNT5SR2CZROH69uOeYAVBowV8WyvMWfYRdFUaRwcweC2AAWxm1DqPzRoGfXKaalEgxBJXNYA6yl+iT3HnsL0TwrAyegLqHOGlTmYR4ae6n+lYivWQZuEyWZCT2tarAyT9R8nAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN6PR11MB8169.namprd11.prod.outlook.com (2603:10b6:208:47d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 03:11:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 03:11:05 +0000
Message-ID: <cf9e1e9f-7d54-4eff-aac2-1bc5c4ec4f82@intel.com>
Date: Thu, 28 Aug 2025 20:11:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] fs/resctrl: Update bit_usage to reflect io_alloc
To: "Moger, Babu" <babu.moger@amd.com>, <corbet@lwn.net>,
	<tony.luck@intel.com>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manali.shukla@amd.com>, <gautham.shenoy@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
 <6d34357ee32bb519c607a0e2f0195194c1096d7c.1754436586.git.babu.moger@amd.com>
 <79e7f426-e592-436d-aaee-f448282c66a2@intel.com>
 <4145a0fc-138a-4a96-879d-34b07fd169a9@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <4145a0fc-138a-4a96-879d-34b07fd169a9@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0296.namprd04.prod.outlook.com
 (2603:10b6:303:89::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN6PR11MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: a15e0390-310e-4b47-5239-08dde6a9b0e0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjFtS1JpbFoyOWJSK2YwMDF1cFlXZHMxSUZRdHFmZHJaU2MvTERJZ0F3bDJT?=
 =?utf-8?B?RUNZNGoyYUVLS2VEY1A1VHIvUEVsem50Mlc0eVhtbVN4aEF6TnMzLzllamcx?=
 =?utf-8?B?S2hOZCtNQ3NsZFNoeCtHbGE3eWRvY1NqeTFPUFc2cWNwc1JNRXBFNzhjeGlU?=
 =?utf-8?B?Y05pcXZKSm82UkZmZHVnK3FacTZrZUR4czFVME1WS21oeXlnaXhMRm9obWow?=
 =?utf-8?B?OWowcE5ObEFKZkFoaERDczR1TGN6RmNlVlg0SnhOZ3d6WFBmVW91MUNqckcw?=
 =?utf-8?B?MzcySDlCOERFT0x4OFh4S3crWVlkMG1rQ3FEempGeHVFZ0JQbFdTYXNScUN6?=
 =?utf-8?B?MTJXdnF6YTJjd3o1REc1TW1ocUV3NE4zeHFyOGhvOXVVZWRqL2xtamFreFpu?=
 =?utf-8?B?UVY4c0VhcytVdmVkSlRNRHY0VnRwY04rT2ZQcXkyQlJqZWZSOWtVVlJrdmU0?=
 =?utf-8?B?c0U3ajFMcitSeDZFcm9Sckozb0xJZkhTdEJucWZBNzRZbFRiYXY0dVczRmg0?=
 =?utf-8?B?V0NPNFFETUVnMTNFY3YyT0Z4UFg0MXFJZXJNM3NBY2FnOGJIclFyM3lKYVA2?=
 =?utf-8?B?bE1IazN1UUg5YnlvWTJLVWprSnhFQ3EyaENvV2lNaTBJWmkvRHcwM0hnUlB3?=
 =?utf-8?B?TjhDWUwxNW1ndGY4dnY3clhaZElvLzFVTDB5d1VKUEVOTVgycko2eElUWXJO?=
 =?utf-8?B?czBGQmthd3A5M0RpMk9hc0Z0QlRuc0FpelpsbXpiM2l0V0x3QW1kSWJENDFZ?=
 =?utf-8?B?QWhYVzRzRVYwRkxiMVhJbFFyc09pMU1sNGdkYWlSMTF6MWFCRENHZ1ZWaEpW?=
 =?utf-8?B?RXJ0QVMyOTRyVlYyQUFEYXdYV0RHWnh2NmUrYVJ2SmpZL0xaaGlrOGZCTlVl?=
 =?utf-8?B?YkQ5RWJuaGhmT3d3VndGT2dGSnN5QUJtR2Q3OEFHcHBiL09wM3VtQVB2VTM4?=
 =?utf-8?B?cUFKZm1IM1l3L2wrV3QzS0t3TnBXcExOSFpxNFR2NE02SmV3YzMwaVVxMmNi?=
 =?utf-8?B?Z1I3SEJ0Z1VKTVFQVXQ5WktqWlNPNzhMbUdZdFZOM3BCcXhlZEVlT0o0dnM1?=
 =?utf-8?B?WGU0S0pqQWlIRE1sWlNTblU1SUhEYVBEV1kySEVpY1hiK3Fjc3Zyb2o2cFNu?=
 =?utf-8?B?TnFvV3NYM2oyMi9JWVR2TnV3RlM5STNoTHBid2podVNKcHZLKzdGZHdLQ0dh?=
 =?utf-8?B?UVZvbXJKL21hWnozSzFOK1hIY3hsTGZqZ2JQVmowOHJzT1lrSDNMeU9tcGho?=
 =?utf-8?B?VHY2N2UzeTczaDhubDBPOGtXdnRYLytaOVZIMjZrZkxnOGhtMUxRbVMzSk1s?=
 =?utf-8?B?QkRKUk50ODgrTmNqSzlrNXNhVkliM3dFUUppa1ZFMmY1SW9hZU1NQ05XTFpj?=
 =?utf-8?B?cGt3alc2YjhxQTNKUTVjdnhxWWROUWpFWFRtcDF5cVBaK2VROEdMVVFjMGpS?=
 =?utf-8?B?R3pDcGM0ODB2alNqbGJPUVI1bTBtbC9ZRExxc2IvaVVHa0dQL04xZ1hyVFkw?=
 =?utf-8?B?NFFlRTBlMWk4THVOUjRUVFF1aU4xQllUUFVERHpVWllWMUFzVEJFVmExV0p6?=
 =?utf-8?B?VHQrajlFNm9EeDVienh3SHBQQ2M4dGFKVFlBYUdNTEVEN1RzOVFDTTY0VUdo?=
 =?utf-8?B?dFd1MGVDdVVPeThOUm5mSVkzZzFUdnlkUDJsZm1xS2g0RzRLbWRFV3dsSTZj?=
 =?utf-8?B?U2RYSW9uZDFTOTlNWUJsTThvZWl2bWhCOWg4WERheDJtdjN5ZGswelk1clUy?=
 =?utf-8?B?c1RjVzVzZU8rcEpPMzY3aTFRL2M3amxnWDd1elFvOGwydzhrMGI2MG8vUFBu?=
 =?utf-8?B?aE0rNVorR215ZjVZMWpwS3UxTUVEQmpoclExbWxLbDA4TFRIWkR4WkhMdlJU?=
 =?utf-8?B?TkYvQ3FvRllMQm9xbUQzVzJBYXpqeEc0M0R4Wm9EMFVSanhqbWxqWEdmODJR?=
 =?utf-8?B?WHlzR3VBS0xqUXoyTnBIVmRlM1NqWjBQNG9MM3FldHVvaXVCdjFqVmJheEVh?=
 =?utf-8?B?bmpGdFFmUE1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTJoMkg4dGNBWW5DMVloVUx3REJlaW1pK2gra2RoQkhESjd6VS9XMmd0V2lN?=
 =?utf-8?B?RXJsb3VrZXNCeG9vZytxWHVPRjVOZFZsK3lnRHM3MGFDdHNrQjNxRWs0THJ5?=
 =?utf-8?B?NHdWYUhkR0xaOFVSSTJTWEV3KzBpUi9mTEVDTU1ia1BJU3Fac3pGV2p5SFk5?=
 =?utf-8?B?VWYrUlJiVG9mekhmaUVCZDB6SlY4c1VvQms5WUM1OEdmOTV3c3pxNVZjK3Y0?=
 =?utf-8?B?NzRla01Kd1dtb25tVC9PM2tIS1VuOWFZbmFqTjFTZkJ3VElMNWRNQmZHNDlo?=
 =?utf-8?B?SnZNd1V3VThrOUgvM09MMERlNHRhWkRiVklVVUY4ZVptdjlKRmZNVC9veGVJ?=
 =?utf-8?B?aW1KZG00aVdEUlZsVkY5NDkyKzNHSnQ0T2dnQ09LTWNhUUhGMEtIWEQxeUtH?=
 =?utf-8?B?d0FKYk0rZ3oxQnVCVDU1c1NzQndrbUs4WlNHc1ZjL200ZnpDL1d6US9Hdm1T?=
 =?utf-8?B?WmJxd3RGMU9SSVFOa1J3MUcrNkdyT0UxWU14Z0o5TkRQVHBGRzd3TFFuOVpo?=
 =?utf-8?B?UFpxNmF2RlhSeFUvdDRxRGxjWEVtSU10Y0gyY1lRdDRWUFVWbDVxM2ErZVBR?=
 =?utf-8?B?TzFBWVVzTDhjcDAvMVNUcWlUMFViL1VIN1c1RjUyS1JnSml2NkxadlRVc2Rl?=
 =?utf-8?B?WUVzT0UzamlOSTRNZFhITG5SdnZiZW83bXEwR04zNnlHd2tLNDUwck1Wa2Jp?=
 =?utf-8?B?SnVHTkRSZGIzNFN5ZWxxVHp6U3orZlVCMVViT3BQcFlEN3BVeVFERE1XbUZm?=
 =?utf-8?B?c3J1M3Q2b0ZqeEdyOWpET2MxWlBqckgxcW1EcG5PSmFHaVVUTjY0TGpBZGpw?=
 =?utf-8?B?dWpsRkRkZE1DdEo2ZTFmQ2FuYURsVUpCZGtVOUVxVGNOalEyK0h2L3o2QTQ1?=
 =?utf-8?B?RGxmUlJQaWpQUEVyTVlramNUVXE0UWVZZnZxL0RqR3Q2dkxwVDRNOE1YTGVP?=
 =?utf-8?B?Um5yN3cyT3FKZlNNYzVrdXpTVVRkZlpTWFI3VHJ5ZUhBZEtRT2s0dVp0RVlD?=
 =?utf-8?B?THJCK1cxVXRSbms2OE5MRFdtdVFmUGkvRnZjRlVUbThiMk9QNkNXWDBLWjdp?=
 =?utf-8?B?LzQ2SnNLWUNQVUFhS0d1TGVqN3UrVStNV1hkNGNQUUV0Z1kvRTZPWk9OV2Vq?=
 =?utf-8?B?T29JdWl0ZDNjTFZCclBhU2R4Ylo1S2JrL3NsaTcrb2k3ditmYWxRR3FVQUpF?=
 =?utf-8?B?VnIyTFErSjBGMXhTR1VQRTQ3L21xMjRyZEp3M2haaTd1c0NuLzE2QWYvZkQ2?=
 =?utf-8?B?ZWc3dkxHNDNlVCtrU2pwaWJ2MzZhTEFPUThhWWE0ZW9KeVN2d0V6ZCtVN0Vo?=
 =?utf-8?B?TlhhRG1KZHRVejIwaUtXNVpVQVBHZDN4WkpSSXo0MmQvVEdJNWgrSjRpT1NB?=
 =?utf-8?B?eDVHRWV6ZWZLL1dCZFhIUmtHV3lVU0lZSmpic0Jhc0FnU3REdGNIS29NSTZU?=
 =?utf-8?B?dzVkV2lsaGExWTRQVXBYbmtnUTl1VGxTaWpVWHdzU3hpUWxDQWJmSXNPeis0?=
 =?utf-8?B?eDlhaWlxaGthZWN5aG1hbTBMWWZka0l1SXNIQWZnb2RFOWdnU0w4cGZ2OHFt?=
 =?utf-8?B?YUJzN3c1bWVRQit0d28yNkVYdktZakN1VXprMzJYMDExQWxoNjhwSHdHajRj?=
 =?utf-8?B?aTBMZE1LNERLbDhFZnNWUmEzVXhNUzRERmlqOFd5Y28xbDFvMSs4QnQzcTN4?=
 =?utf-8?B?amtHcE5ycUdhQ2UxM0srWXB2Tm9IVzFkUTRlVzM4dmVPQ1oxVm50bGxxWXJC?=
 =?utf-8?B?WE4wYzJib0FFN24rSWF0SW5SQWFiY2ZVZjRValVYc2JNMVN6R2RUbUh6T002?=
 =?utf-8?B?MFhpWStWNVNZU0VGQSsxUVpXWUVVeVlUVGlQbGhRZDRVMGxuTWMxREFjK0Rs?=
 =?utf-8?B?VmE4dzVoSmozMEI1a3AwVGtQeCtUM0g3YXdRTXJ0V3JFR3NHSFlMc3FTT1Qw?=
 =?utf-8?B?RUhiSVdsSlVaTHdockVvckd0VUx0NTAxc0R1aUhFYmY3RCt6SEljbTk2b3E0?=
 =?utf-8?B?OWczZGxWd05FbWlTdnkzbzQyTzhNOTJhNzZQUWxFODdWQURoeDVGUE9YSXNN?=
 =?utf-8?B?OVQvTC93UVNDV3ZXbW5iN0Nzd2tWaitzbm1iYXdaTzBBRVRUV0FqazFrREcr?=
 =?utf-8?B?U3I2WHdXWmk1eGszVUFMdXJ5emgwTTlpZk51L1VvS2RSb3hJcFJpMHRKMXN5?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a15e0390-310e-4b47-5239-08dde6a9b0e0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 03:11:04.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Lx1NAoxbLx89VO398srD36mzzAcol/T308r+YsM0jR71ChbL5hvYXRbQMtKNuECJQvj9YjokUiKq2YGAKTjYuTOA1srYp+B0t6sfQCSamU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8169
X-OriginatorOrg: intel.com

Hi Babu,

On 8/26/25 3:51 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 8/7/2025 8:54 PM, Reinette Chatre wrote:
>> Hi Babu
>>
>> On 8/5/25 4:30 PM, Babu Moger wrote:
>>> When the io_alloc feature is enabled, a portion of the cache can be
>>> configured for shared use between hardware and software.
>>>
>>> Update the bit_usage representation to reflect the io_alloc configuration.
>> ... but no update to the bit_usage docs :(
> 
> 
> Yes. Missed that.  Will update the text.
> 
> 
>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>> ..
>>
>>> ---
>>>   Documentation/filesystems/resctrl.rst | 19 +++++++++++++------
>>>   fs/resctrl/ctrlmondata.c              |  2 +-
>>>   fs/resctrl/internal.h                 |  2 ++
>>>   fs/resctrl/rdtgroup.c                 | 18 ++++++++++++++++--
>>>   4 files changed, 32 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>>> index d955e8525af0..1e46231b929c 100644
>>> --- a/Documentation/filesystems/resctrl.rst
>>> +++ b/Documentation/filesystems/resctrl.rst
>>> @@ -90,12 +90,19 @@ related to allocation:
>>>           must be set when writing a mask.
>>>     "shareable_bits":
>>> -        Bitmask of shareable resource with other executing
>>> -        entities (e.g. I/O). User can use this when
>>> -        setting up exclusive cache partitions. Note that
>>> -        some platforms support devices that have their
>>> -        own settings for cache use which can over-ride
>>> -        these bits.
>>> +        Bitmask of shareable resource with other executing entities
>>> +        (e.g. I/O). Applies to all instances of this resource. User
>>> +        can use this when setting up exclusive cache partitions.
>>> +        Note that some platforms support devices that have their
>>> +        own settings for cache use which can over-ride these bits.
>>> +
>>> +        When "io_alloc" is enabled, a portion of each cache instance can
>>> +        be configured for shared use between hardware and software.
>>> +        "bit_usage" should be used to see which portions of each cache
>>> +        instance is configured for hardware use via "io_alloc" feature
>>> +        because every cache instance can have its "io_alloc" bitmask
>>> +        configured independently via io_alloc_cbm.
>>> +
>>>   "bit_usage":
>> More ignored feedback. I was expecting changes to the "bit_usage" section.
>> https://lore.kernel.org/lkml/94d075e0-6703-449f-9c0c-8e5973349dff@intel.com/
> 
> Yea.  Added following text now.
> 
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 273c9c9389a4..0a56829407c9 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -124,8 +124,11 @@ related to allocation:
>                         "X":
>                               Corresponding region is available for sharing and
>                               used by hardware and software. These are the
> -                             bits that appear in "shareable_bits" as
> -                             well as a resource group's allocation.
> +                             bits that appear in "shareable_bits" as well as a
> +                             resource group's allocation. When io_alloc is enabled,
> +                             the capacity bitmasks configured via io_alloc_cbm will
> +                             also appear here, indicating the cache regions shared
> +                             with I/O devices.

This sounds as though when a bit is set in io_alloc_cbm then its corresponding position
will contain an "X". An "X" will only be displayed if io_alloc_cbm has the corresponding
bit set *and* the bit appears in a resource group's allocation.

I think that patch #7 adds a very good definition of io_alloc_cbm and that it is
unnecessary to duplicate it. Simply referring to io_alloc_cbm should thus be fine with
user's search for it in the doc leading to a good description.

Considering this, how about just:
                "X":
                      Corresponding region is available for sharing and
                      used by hardware and software. These are the
                      bits that appear in "shareable_bits" or "io_alloc_cbm" as
                      well as a resource group's allocation.


Please also update the "H" section.

Reinette

