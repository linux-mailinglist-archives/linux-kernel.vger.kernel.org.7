Return-Path: <linux-kernel+bounces-784342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE7B33A29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F117AF27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC52B2C08C0;
	Mon, 25 Aug 2025 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNqzAwE2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700F32BD5A8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112890; cv=fail; b=IOT7g8GM8ZgvZx8x2ddzYX+S3ff9Vhmwvje5VZe8tdKRdvT+raokm2APiNRAsGDS2kgl0lF38fbWVOFrIkHeD1ABe8gu/jf00UuU2SuDJ0povkLT4HBIAoSHuHAvkqKNDNkN61y0Z70ceaib9s44pya3zc4ngYvYCcmLnX6UCBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112890; c=relaxed/simple;
	bh=qcMl36PwOm8vz9W3mz/tT957VHY51Iuh+3B+QCyS6fw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ok+cAfrPVYQCJ9Nv1PIGd/nWkVl7CpeYuIzz3qPWQJ2yhHQFl9dZ9CzuArIY1hfk5A1Sz0S3urlN3pw0y086sWF9//SwxkYzeGDNzkIwO8x6N1m2ZtrGh04uupNf10C4tb+nfkUBpS5hh5psGgNERdIQtGhzgRvjY4MNvmx2EWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNqzAwE2; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756112889; x=1787648889;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qcMl36PwOm8vz9W3mz/tT957VHY51Iuh+3B+QCyS6fw=;
  b=VNqzAwE2OlIdxVe5D6AEmeZpSfiTFCxFYUa7KYzeIvWiKF95sbpkB4BB
   QP/pIUtvGLAWts875fGgF2WjXYuTdPftA7rj8bL1Hj3yn9eHeHWZTrQHN
   wquQ5irjmSUJiw6QyasK9w38xexc4grvcMm0+Tonexim48P0kvhCJrNTT
   bbOg9ZA+I+v9gTG47LmVOhHXpHECm2+EP/xo2GzdQwGxvQLVYB+LgTWlW
   aNOKa8OGWwzTZ3XdWNFL+gP2NUUuvEzO17XV8Y2G/OPf98C3zv2A4+0/j
   eei27eoNAcq2IBFavOUlwVrZaijm/0IPwy2ab6Auc2H8OWec1rsUq+3y/
   g==;
X-CSE-ConnectionGUID: nLFxUV7aQ6+kN9c88OYRcQ==
X-CSE-MsgGUID: 0KEPhu5yTz26q/2JzMf6SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="69752455"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="69752455"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 02:08:08 -0700
X-CSE-ConnectionGUID: RIOz5bzmSgy3bKQeuFnXfg==
X-CSE-MsgGUID: s6/fmLHNQqSj5U3EqqyBoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173646777"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 02:08:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 02:08:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 02:08:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.46)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 02:08:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybHhSF2w9SNO0vnr/GXssRCz2Mf0Fnsvky2QX7Whd+u9EY9+1/MhiUISznIllEGY1qJXPH5G9+ZXFyJ678UDO4RIj6WTaILvwz5LNxbtqFqUAG6DGG1iFch0y7fcuOHIfq/hOFWwqjqLgrQ2SucIXn5gWQGOXj7SIJK3HxsPC71R0500ntXN9UDDR7SQTugF/snsNLfdu1PO0nf1MniaiUmtun22q2xrEAbnTEhl0rjlc9gclxGo3kj+PYMN94tx//xKl5KfwQfps2PfkUAguDUCL9cpr5x/jEpAm1aPBKWrVGGjB0nPYRIP0sX2RbNinUyu0GOjH1juJyw0Z4FBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ2A9zNrN2JhJzIx27cyDwQdl5dBc2ic5kTyd64UayI=;
 b=avWH2OpxsvLpGd9bnfKz7pti5h3Ufviu4d1WMvjsK8shxp02Cj5ksx+R1kOLkuOQDD0tWo2gCqGFWH/X2DL+IroUU+ieMrO5fwAETL+HgysKtcSohRFbIcZo7zNPqJzQuByKQMam+YsCunT+QUjwsk89/1MzLpQNq2p+jORgflvLmzx4vY6arGEqeIQVXl0N8/ioykDeLGy5Z+tZXH7c0/wxNSiJAIwU+VLEQWd3IW1G5F1wiN+R7QUnRq5r42lU7cP8RjXuG5MVQCGoFN+IM6N4aic0+rRSRmDnR7iXU93C6Oora0xWquskh1Lm/N+Cm8DDRUWeKcG7FzFHA1945A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB7988.namprd11.prod.outlook.com (2603:10b6:510:243::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 09:08:04 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 09:08:04 +0000
Message-ID: <c6e340a5-6d46-4548-8c42-001f2a4514ad@intel.com>
Date: Mon, 25 Aug 2025 12:07:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [POC PATCH 14/17] perf/x86/regs: Only support legacy regs for the
 PT and PERF_REGS_MASK for now
To: <kan.liang@linux.intel.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
	<dave.hansen@linux.intel.com>, <irogers@google.com>, <jolsa@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: <dapeng1.mi@linux.intel.com>, <ak@linux.intel.com>, <zide.chen@intel.com>,
	<mark.rutland@arm.com>, <broonie@kernel.org>, <ravi.bangoria@amd.com>,
	<eranian@google.com>
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
 <20250815213435.1702022-15-kan.liang@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250815213435.1702022-15-kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0306.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 61243650-53a7-4a3a-03f7-08dde3b6e5f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUcvdUU2U0JLLytRaXRBMVM3Y3JIUVJqclEzUU8vQzhBTnZtM29vd2tLMGhl?=
 =?utf-8?B?OHdCbFg4eW9paHlManNJS1J3UlZoL3V1cXhKazJTNXptR3ZiVEFFVVZjOFdu?=
 =?utf-8?B?Tm5HRStQNVpFT2FBOW1aU1pWdnMzTTRqcTdqSHI4Q0xrR2FzeHUrS1EyTFJ3?=
 =?utf-8?B?TDJTZDBKV3FCT1VRNWRPVDlSUnV1RWJPYmQrbHJERXFMNVZ5bTNVbDU1Ujdm?=
 =?utf-8?B?bkc2bVN2SG5UZC9oN09VaUxPcHJIR0ZobVUxVDBLVUJlUmxTSXBMYjJhb1g2?=
 =?utf-8?B?SFJINnBhVWlDYzJzNkRqNCsyMXd6K1hzdFEwanZScHk1ZS9WaHB4UjR6Zm1m?=
 =?utf-8?B?YlJYaEdIeGRHSW9IbEZTVzRQMmZ6U2R1Q2htWmY0WUI1cHpaWVVUVnRWVHF1?=
 =?utf-8?B?L0c2YWNFMjZpT0Q3VXYzTU4ySW1IU3QvbHVaUmw0Q2Y0MXFHWGlqM1I0YStR?=
 =?utf-8?B?R3NjdHp3djdkUEZyV0pRQkNFUm5qaEh0RXJ3akRXRE1kTDIvc0k1SllUYUcx?=
 =?utf-8?B?TlFqcXZYc0tDN1daeHV5bjR1bitZdy9MT2cxbU1LTWtnTi9XZzZTRlJZWXdF?=
 =?utf-8?B?aHFXMjBNL1pMeFRVVzJ5U0hodmhJR29wMEE1QjdnaGRvYmhIQkh3K3hGTm5X?=
 =?utf-8?B?WjhCWWRkZDFXd1BiSjMxZ2plcUNsZU93bGxGU2hGTGFKNzNGR1FEMmdFakFI?=
 =?utf-8?B?TVhSOWx0dEUra2J6OGMvMmNLMWxZQlZSb1JvRyt6YlRjc3YwRTZTcjR1R2Y1?=
 =?utf-8?B?SGJzSlBqSHVreU12eDc5L29mTjBzL3hQdGNHSUE5Z2lpcytFYjFVcE01enNJ?=
 =?utf-8?B?bGh1dzNpYkJLVjNWOXQxTzcxbW16aTNzMXpCamtBT2dTblBPSWdWQ1VuamM2?=
 =?utf-8?B?S2ozWWxrNmhJUGxFQlora1E1ZUF3UEowaWt1enQ4dzlqaDB0OUl5bk1jZGpF?=
 =?utf-8?B?U3JqekdZYWlRKzMzNVI5L1JQZGJXMy9rNGJWdGtobkdwL2xSeEN6OUIxeDJD?=
 =?utf-8?B?UWlHUWpDNlZQOW16TTZvNm15QWtDeGE0NGVuRkRSTjFQY2JBZUVHR3pzNVRQ?=
 =?utf-8?B?ZThGbE5FQk54UGprR0h1QitZVnZDSzhLUll3TWhLN2NIU1JWMk9lZHAzc3h6?=
 =?utf-8?B?cUJYaDV3ZmRCekk5MUNuYUdXcVFOeGxrcjFMZm93VGNtdTY5ckVjWW16Rzln?=
 =?utf-8?B?ODh4L2FmVkpiTGN6bDZNemNJU3JEaWRjYTdNMTNwcVRCUzU1MkpTbE1iWktB?=
 =?utf-8?B?MHhQUkc0eFpLTlJ5dzJ5VnNhNmhIVVpxdGRNcUg2TmMxRklGZ3ZOQjdrVGRj?=
 =?utf-8?B?NTFqVk52ZEdsRlJzdHMyK3E4Y0RwVVVBM0FCSVljVVJRaEF4VHZEL0MyRGxk?=
 =?utf-8?B?bnhWRHBBK000WmpCakc5NUVtdTJBaGhlZVhhK1RURlBJSEtENEl6TmMrZ3Mz?=
 =?utf-8?B?VlNTRTZPdjNnWnNKbTVoUWJ1NjhLZEZlK3JKM1VaNlhUNUhHc2JSUTdhaGht?=
 =?utf-8?B?OTRaZHBkYm5INHQ5cWtxSmhISWcxR0ZMbGVLeDhxemxaQVBZNklLeGh1dmxK?=
 =?utf-8?B?aGRmZW4rYjRmaUJsZ09tNlRYK2xCM0p1MXZDRklTdGdMNW1mbTl6V2xHYWZI?=
 =?utf-8?B?UlZCelV4blg5QmhNamdydklzTDE2UEc0MlpYYUNZWUl0UkQydVFURXcwRFVk?=
 =?utf-8?B?b1dFSUVRalB4bWJKSmZkRFQrWldGOEtFbnhUbDVxbnhnNWc5bkw1MjVTNVpn?=
 =?utf-8?B?cmFjTkNtRWxCeGlhb3B6SEJNRzR4R29NSUVEYlMvYUtIRUloeWhOdVlXNy9M?=
 =?utf-8?B?bk10cEdYZ0FNQkg3enVDd2p4ZTY0M1p4M3RTNFA0MlFWNnhxbjRNY2xmVXdy?=
 =?utf-8?B?SWFBK3o3d2dZUUxHSDk5RUVYL0FucVlSR1FFbmlubTZ3VEhIaytEMUh4Qmty?=
 =?utf-8?B?TnFkc0d1N2RtYm1aQmpUNjBlRWFLQ25yeVI0TjZsWmpZaG1CYm5tS3YzOHZP?=
 =?utf-8?B?MmpaNFhWcElnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1Nva0U2ZXB0Y2w5QjdLbzh3VDZOVS82MjRvWFprK1c1bXJiT2M3eWpIMnh3?=
 =?utf-8?B?WEJWbyszcXIzQS81SUZUN0pDUm95RHo4RE5tQzV3aEExTGwrLys1ODZTSUF2?=
 =?utf-8?B?ZVE2dmRUL0JnODM3RE9zd1VTSVp5Vm9xUEZ5SE9nc0dYdkVjRzJwQjdxZHNS?=
 =?utf-8?B?c2t4aUozZkwrZTR0R01yR0hjRHBIZEZlS01SUGkybTk3VVp0MHR5Y2tIMzNX?=
 =?utf-8?B?LzA1MmtDazBsYVpmdFhMMTZiV0l4SjFvOG5ySm5wUlRzbGRSU1ZZVlI2K2Qv?=
 =?utf-8?B?RmppRUlLMzhKSE92M2JXNDdhS1Y0NXBxZlpQelE3UE5FcXk1NEpJbkZ2OElD?=
 =?utf-8?B?TEh4Wk0xYnBrOG54NEJtdE9jdVQ3M3ZUOFBNVFZMUFBTWXhLaHFQL29SS01t?=
 =?utf-8?B?VUNvbU0wWVRhdE1USHc5TGVMQ2pMelJyVDBYWm1DemR0M3pjNTV5L0kvVXlF?=
 =?utf-8?B?MTZjbW5oSHk4RjFETk9mcHBvUGF0UEdmK2lTS1l4ckdLcnUxSkFjWVNVSlhS?=
 =?utf-8?B?ejV4OW5ieVA0WktQdTJrU1lGbUpKSTJmQm14UnJFMlpUR3RsWnhsMGw2ZFJL?=
 =?utf-8?B?eHhMamdFL2gzOVFMV2ZyOG12cHlqTXQ3ZWlVeW4wTE0ydTdGS1lVU0ZWT09x?=
 =?utf-8?B?OFdqaGppV1RPYXl4ZldLRVZZb0thUFNSb0puL3owNHdIL2x6aFduOXdBTzVZ?=
 =?utf-8?B?dC80NFFxbnFZdmowbFBacmNzcC9RMmVOZnhtS0NxYUFWT1dVTzhjL0hMSjFC?=
 =?utf-8?B?djdjZzE3UjVqaGpaTlNxVjVPUzBxVXNCUXdCZXNIeXBySDc2U3dYM1RSL3d0?=
 =?utf-8?B?UVIyWnRYNlFmZDhOY1d1V0l2dmhNOXAwdUx2cHlSTlc4bi9vVWZEK3VxOXV1?=
 =?utf-8?B?MkprVEJrNnpKanpLUG01dTNSTFU3bzFHa1d4ZDhsMmhDVjBUZFhqV0ltWnJv?=
 =?utf-8?B?V0R0ei9oYis2YnBIeUVIOEVOOWJ2Q2tWNGpweHpVaUthZWFzSERISzNxUWVm?=
 =?utf-8?B?WHFFTE1GUTN2K1h1azdEUFA5NktkcE1YakZyL3hXbGVORUNNOEFtMVdQb3NY?=
 =?utf-8?B?allNT3h5aDRER3JMLzB4RVcranJpWXh6UWlESHhRTnJ1ZW9BQldKNGNnOHZi?=
 =?utf-8?B?R1FtWGJCMVdpb2w2STlVRTVxNGIzbVpkV0FTWE83aFVYVDh3RkhqNzdReDVk?=
 =?utf-8?B?eklTczByQWdjQnpCZ3Jzd0ZEaXpvR0RoKy8vaEt0TkR6R0JZUzQxMnBtdkpP?=
 =?utf-8?B?bnpPNDkwa2FzcVBseUF1MEdyZ0xjRlpWNkMzTVFNZnpHeFltc3d5VStpWWJ5?=
 =?utf-8?B?WFpab2R6VWEyc1gzZ0F6QldtUWwxQXNPOTRRdUtxMW4wRGJtZXZoYmxWUitS?=
 =?utf-8?B?cVRjd3BpRmJ3TUNqY2tuS1Iwb0VIcVFmcVlsTk1DQmVDc2NwNTcyUkRyekNP?=
 =?utf-8?B?RExSZzhieXpJakkvNXNXYUlIL0lWMUJxY3M2bjBac1VXS2RZSnRLNC8ya0h4?=
 =?utf-8?B?eDN4L3JKaFh1eDNUQlFidks2TTBISlR4WUJlYmJUdEFjOVRlMFJzVEI0enhS?=
 =?utf-8?B?bUk4RnhnUDlXdXVzbld3dUtGRTRSWStiODZEUlIvczFTQzZscGhBUWxBNE5F?=
 =?utf-8?B?OHRaemdJMjJQd1JsQm9sRXRaS3ZtM09XZW53eERDQlJVU3MwWnpwR3FRaWhm?=
 =?utf-8?B?Qk5DZ2FDZFVSQTlPV3dLNVg1cUg3M1R5a3NtNDNIdTM1QXBlcGMyc2ZycGFQ?=
 =?utf-8?B?elJ2R2kyL2tzeC90Y2pkdW9HZ2ZCZlFGd3IvdXMyQ2pDcXVMZHhqL3dMVjVB?=
 =?utf-8?B?RzI5N0ZpeVJEVlljU3VkMVUzUVMrZUpPZkhDSTFNcEdtM1N3Z1kvS2lOeC9M?=
 =?utf-8?B?RGQvM2FBWXFCWCtTbVAxMTROUVd2WTdNNC9oS2NtSXlUZENNSUtCWDhZeE5R?=
 =?utf-8?B?VHFLNTYrSng0ckRFdm4yMGF5bEZYVGVyelBteDJPbjlHbVRmOHp3ZzZMcEdW?=
 =?utf-8?B?a1dRd2JiWUUyR3M3TS9LY3IxU3Z6bWdOK2l5VVg3a3hVejZ1SXllK1Q2d09q?=
 =?utf-8?B?YjVmZmprdDJvS2FqVnJIWFp3b0tGUk4wM2JndGhPeGpSZWE5YlRLR2ZuQmUv?=
 =?utf-8?B?bVNNdStEZnZNaGNlT0F6Si9YVHFzUzNBSytiUXNPeUlaNkRLR25sdEVEc2ps?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61243650-53a7-4a3a-03f7-08dde3b6e5f8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 09:08:04.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4SuGbEdcVvfauWoUXCHOsPyK0wCDAnUFXn6ZDtvLWT/RRXt/96W6gcRcmiZchWt+0t+B/83G81nRokccRXLgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7988
X-OriginatorOrg: intel.com

On 16/08/2025 00:34, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The PERF_REG_X86_64_MAX is going to be updated to support more regs,
> e.g., eGPRs.
> However, the PT and PERF_REGS_MASK will not be touched in the POC.
> Using the PERF_REG_X86_R15 + 1 to replace PERF_REG_X86_64_MAX.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

For intel-pt.c

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/x86/include/perf_regs.h | 2 +-
>  tools/perf/util/intel-pt.c              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
> index f209ce2c1dd9..793fb597b03f 100644
> --- a/tools/perf/arch/x86/include/perf_regs.h
> +++ b/tools/perf/arch/x86/include/perf_regs.h
> @@ -17,7 +17,7 @@ void perf_regs_load(u64 *regs);
>  		       (1ULL << PERF_REG_X86_ES) | \
>  		       (1ULL << PERF_REG_X86_FS) | \
>  		       (1ULL << PERF_REG_X86_GS))
> -#define PERF_REGS_MASK (((1ULL << PERF_REG_X86_64_MAX) - 1) & ~REG_NOSUPPORT)
> +#define PERF_REGS_MASK (((1ULL << (PERF_REG_X86_R15 + 1)) - 1) & ~REG_NOSUPPORT)
>  #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_64
>  #endif
>  
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 9b1011fe4826..a9585524f2e1 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -2181,7 +2181,7 @@ static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
>  	u32 bit;
>  	int i;
>  
> -	for (i = 0, bit = 1; i < PERF_REG_X86_64_MAX; i++, bit <<= 1) {
> +	for (i = 0, bit = 1; i < PERF_REG_X86_R15 + 1; i++, bit <<= 1) {
>  		/* Get the PEBS gp_regs array index */
>  		int n = pebs_gp_regs[i] - 1;
>  


