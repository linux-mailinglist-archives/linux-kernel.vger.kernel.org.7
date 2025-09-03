Return-Path: <linux-kernel+bounces-797597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F68B41257
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3927207B74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5DF1E51EE;
	Wed,  3 Sep 2025 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShsgbJVr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05F1D63CD;
	Wed,  3 Sep 2025 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866654; cv=fail; b=rZjswQfI2k21BGKQDssZ+WxnKc7vwZNgjzpjwYwo2TSC01mPHF7+ZAoCJfULHNdWKJv0SY82UteQet/FAvsDQ/MllSoNvbDN9sFaBp9MoKl8zUSvO/VcrFqAApE9Kb6uJfch7nc/+uyGjaFBDJgsEfNp64cn/cROwDZkFehwybs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866654; c=relaxed/simple;
	bh=F7k6dMwRpNFG/CEzqSbDSeXvSugbj6iuVtNvDBeLvpw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=egnyG2qit9O5qfhIwJPMZeupapgngbheemRRcXQ5F9mziyRTipeF20sMHg8qVFX1XVPkcBvVACNYsBuuyK44XAEOR5GCgckd1VnvN32OxivmDQICGLoRkjulpSyfUpwr5v16a0KP0AZ9aPuYbqxMnm+iY4pZrdVVdVoFxNABbEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShsgbJVr; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866653; x=1788402653;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F7k6dMwRpNFG/CEzqSbDSeXvSugbj6iuVtNvDBeLvpw=;
  b=ShsgbJVrZnmKcX0OmwjNIcnGU/P9lzDIrzF4xnBrvpXGWWoEXrxY5a9Y
   8RnB5PoBn4CGFwZ4az1Y3aUXQ2kHmwV3NJrOKMILhfO1rKkt1VGLto1HL
   ifpFP79uxLEp1Kc2rAE/t19G6lDkLQjK6uk2uBD6ohtN2SRhgFXXY/YBe
   IP/M4BAjeeiKZN9v/SZrU4syPCnTnqAabuSgZRLXj2v0L0ubRxvm76uh2
   fj4Wia25kBn8YzNmpDIoOitPLKin8ccRJ2lS2T0p04TUl+yDTi+UZdAF4
   nHqPh/270bcUM0yxagWaOVDiYRtCaK4y1ZThmgH1CaCtAEWsTpY02OX+x
   A==;
X-CSE-ConnectionGUID: Us8hGO2/R1uWi97wZOpxkA==
X-CSE-MsgGUID: iCwnAyRuTiy3Bg+j1bmr9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58200312"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58200312"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:30:52 -0700
X-CSE-ConnectionGUID: a6RTvjh0Tvi+/e2wyqPGNw==
X-CSE-MsgGUID: ptnnNLu0QfmSeTjbGVBgIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="208668638"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:30:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:30:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:30:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:30:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6dgk+HSlkoYwaruGcDCZ6efFUlQk3JyGZwQIrRA7D5khctJKiMKkjR6eIWnHIx1gU272JYecG1y9nf2BeAGDAqGeO0Iicg0R8BIGeM2qrXUg6a66GZ60raoRKVrzTcLdAPgUky70N1XqRGV26UIt2aZKFbdDVnOsN/6Z0bo/Wyx2VeCczSH6LVDmxPHh7G1VsNWJi8a17yez519y9R80rCHAqy21999h3GegdHfPWC7UrKEN0Zv6RzgUF8HKbJrAujLqNuXXvRUlx3nHj0NucPQsHG4gTQ3QEqL6Z0/7evq3tqeYiXrMCk0L47WhC6LF+h63COG+017EGsU1VnsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n5T2DruqHooAwMLw677S/twRaNpxVxlCkvUfBZOIxk=;
 b=wIruFiXLGWQI25VBhzbZ+0JPiacvapa1ms2cbIr9Tw8FMvS1t7XbCRCIjMpmOZdwQEpBjC1sd6cPdGmZWUjGnOGDxWlXXEnkChzjmuvSRvK510UFl1slXbGJSkZ1uEhkC1w9moUuz7ylBrxh2hCQDuuHGUhLckaOsVGzNkd5oagdEtdgjpoCR6wnuPiUWcodYxZmwaAo4+gC94h6fjsqaHSaIEUU7uU0B/mqi+jNSmbXjJGIT9C2m/oNw7TMzFVMZ5yLZl7vEwt1XlMKFKQYSr1g697+ggjWP0V974yTZDzqKzIROOezBg7EveQYWesAaC1Ck/Xl/og1XROPwHQdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:30:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:30:47 +0000
Message-ID: <185f12d4-90b9-4fd7-ace9-03f935b5030e@intel.com>
Date: Tue, 2 Sep 2025 19:30:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 11/33] fs/resctrl: Add resctrl file to display number
 of assignable counters
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <b5016487a7d72cc24134a36ef1a9acaf735f59b3.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <b5016487a7d72cc24134a36ef1a9acaf735f59b3.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: bca0ad92-94d5-4f1d-995c-08ddea91e3d7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXhNU1k0TGp2ZCtBVXVDVXEvcnFtR3ZENWVSLzc5NDZSWlhSSUs1aHdqMkJh?=
 =?utf-8?B?OVlaakRrOGVPZy9Dam0zSy92b3QraTJscFYxWVM5OXZJWEE4YUI0eUdoWSt5?=
 =?utf-8?B?bGREemU1YW1RNW1XL2lqQTJWTWNaN2NQYm8xYnY0d3FYMVRlRWhYT3pMRHRt?=
 =?utf-8?B?bEUvRmh4bTNBUG9YMXpjYXNEbHVOVkZEVllwZ0YvWW5WNGtmV0QrMEhiQmZ2?=
 =?utf-8?B?Z0o5Z3BnMFZZdk5wWVlCS1JwTmJqWldRTXVGQ21rY3JqME5EMkhvMTIvdndB?=
 =?utf-8?B?U0xNaDRwM0VFUUlRQUxsa3ZITk9FdHN6MTNhVmZZdVJCdTR0d0VLYVdiM3lt?=
 =?utf-8?B?aXB3MGkvWjY1Z3hsKzRzdW1QTnN2VklMdU9scUF5NkozTVBMd0ZNbUUweEda?=
 =?utf-8?B?aVVWNnZEOTN3NTFTMDllejZ5cld2cFBRRHVjZHd2NWY2OHFOUk90dXQxL2NM?=
 =?utf-8?B?MXpGQzN2dlRNVGw3ODUzM1llR3B5OFRpK3FzQ2xmN051aEl4SVFiRHRPdWI3?=
 =?utf-8?B?b2N6ZUZNUDV1cndLMGFwTTN6OUVIbWtLdnpUQ2pzZ1JzbHN6bWRZaXpTam5N?=
 =?utf-8?B?M0VQQVlXSEtuR0grRjV6UFlBL1pqVXFhdTd1MlFxQ1ErQU5SSEp6d3NNZEpy?=
 =?utf-8?B?VDIwcXZNdG5USXNnWnl1UDdTdW5YeC93Y0JIM3gwMUZSK1Z6VVRTNlhaWm4z?=
 =?utf-8?B?bmlPNUVyYy9TR290WDBUOWRTV2E1dkhqeDhYcjJYMHJpbE9aeXdvNE1DTjMx?=
 =?utf-8?B?MUoxL2IwSWE1QkhzSWpablhsbUExVGNRQkV6M1V5blkzQ0duaUxIRU15YW5w?=
 =?utf-8?B?T0dkQTRRSExwTlNXN0lpcWJ2ZDRxN1VqQXJQRmJuT2s4MnlpTnJ3MGtDeHJC?=
 =?utf-8?B?WGN4WWVJZU9rRVNUWGo2ODNiRkhBaDhYTVVyK2trcmFrbi9XcWdkL2JQdm8w?=
 =?utf-8?B?UnBYSWl6dDJubUc0NGx6Tk5ZZ1JLUHJQTGdhNGUzZFhIU1FtMU9NQkJCcCtx?=
 =?utf-8?B?WnVDUTQzMVhWMmI5VHlWOFIzVUlSS3NKZEw2ZElQOTRhOHI5VWhsemU3Z2xO?=
 =?utf-8?B?ZithZDU2YXNUelVSbGV6MDRRSWRGekhsdEFVckM2eUs3WmJFcVN4cHdVRHZz?=
 =?utf-8?B?dWF3d3RWVDZWYUtHUmZRbENzNkIvTGUzajlrMTVrNnBFYk5aN2owejhJRk5N?=
 =?utf-8?B?dTlFSHpPWXB1QWUrYzhKbVJoUUtUWitjNmpFL0FlOTMvOHB2Kzg4K1NuNEtm?=
 =?utf-8?B?OG9aam1WbTV0T05Wd1BQZTIzSW1LNzJxdUNYNmJjQVpYWWRqVXlXZHh6UGpQ?=
 =?utf-8?B?RHV0MGorMnpWdjZqaHBxejBTdEJscmJJZ2h2NUhubFBqNkJlaUM2Z3BtMzRH?=
 =?utf-8?B?RWdRZjdzbVo0c3NuN28wZnU3QmdZSHVBNXkxRmJqbEcyaGsxb2psdWZjVnJ4?=
 =?utf-8?B?R0ZlUmEwWnpVWTMvalF2UWswZE9tS2wwZFZDanJsWjVnN0UwclIyTXc2U05w?=
 =?utf-8?B?SzloMldWL3dLczhjdERYTXJqM1BpeE02ekN5bFhDbEpBcjZDOE9vR0Z1VTdo?=
 =?utf-8?B?RE1YdE84VzVHUWEzYVhiNWFFQXU1aFF0a1FPZDg1NDRZWXV3TnJTSVBuWFB1?=
 =?utf-8?B?S3dCUGZIOXc1eWZISThoS1FsL3N2Sk5nakxCZzZYRlFYV2tsYnRiL0R4NE80?=
 =?utf-8?B?d0FKZkxrbzhYZnkwb1U2TWFkb3B2VGNxcStxVkk3Ty9kMGFETlN2aXlYQ1cx?=
 =?utf-8?B?N1BEc2NobnIrS1RTeVhqY1VqeFAvUGVpSy9rK0dCK1l4Mnd3SE45bjdpck5a?=
 =?utf-8?B?aHV2TG5iUkFJcUJNcUVJSDlOdHE3eERRMyt6eC9pRVpBbG5VVmoxYktSWGRy?=
 =?utf-8?B?ekpROTc3VjBkYUNPQnMyK0hvaFdUOVNGVm9oMUVvKytQdFNNQzhHSnBCbUt5?=
 =?utf-8?Q?/1fH8vlqX/M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmJ4RW5qUi9lampHeE12MTd4dytlT2Zmbmo4b0N4Q0lJUnJMTEw0cUlHUFp5?=
 =?utf-8?B?bFMvaU43K3NWM3ROQnoxQk5QN1lwa0xSZDE4cFdXYlA2VWg4amRlK0NUNHNt?=
 =?utf-8?B?YWNSeDVqaGVjM2VOZGdGOEZLb3hvc3lBMC95alQySTAxV0RiY0ZydFloR3dY?=
 =?utf-8?B?bk4vV296TFE5YUQ1S1VlU2pjc0l5dkJjbzVYS0trN0oxWlFzV0dLWmk2NEtu?=
 =?utf-8?B?Z1JOek8vVWY2cFAzSlJuTXV2K0IxOUxQbjBmZXBtbTdIMG50TXR3SkJwZE51?=
 =?utf-8?B?MGsyd3F3ME1hQW9QNjFVbXlMQklDUHIraDlqRGZuN1lZQkRUaVpZWExDZWk3?=
 =?utf-8?B?WnliaTRxOGwvZWlMakNyNTFTdmlFVU41bTFMbzRkaWROcXFjN011U0FyTnN2?=
 =?utf-8?B?emFocENpRGh0OUxLYVRGRmJ3M2QvQWdWVU5jYjVGV0oydFQzMml6OHhDUEFm?=
 =?utf-8?B?b2FGVHpkT084YnVBajdOVWtvUjBtUnZocXUwZWlMeXg4bzJZRVZOZXhCZkM2?=
 =?utf-8?B?dWowK1hUY0dZQU5RQ1Z6eG4zRHpCak5SSElCYytBSndBWFNiVStBTWo4c2lU?=
 =?utf-8?B?RXdwNDg1bHNacDFyK2ZrUlROay9GLzgzaEoxTThnNGdxdldtZEpZaXg0OHR1?=
 =?utf-8?B?RVgxbEM5VnIzSld5V0tzUGVkVzd5VGYwNUJqOVdLUXQ1ZWE3dTVIeWdhUHJ2?=
 =?utf-8?B?T2lPaCtGVVNOejZ2RnN5cWhNMk1qMGVMenIzalV0eG5xd29ZN1NKRVZaNXZC?=
 =?utf-8?B?bEpXQUp2YllLTnB0LytPS2V0Rk1HMVJZSWhNcEpYZDBVS2k3T2J0MG4vdHZ6?=
 =?utf-8?B?TU05SnYrU0ZwWkpZYXpnaS82eSsxR24zYUJOYTUyREc1NkNNckZQNlA5SGo1?=
 =?utf-8?B?QlE3QUhpaGZZNHRyaTFsWDlvTm5FdU9rYm9hY1ZSdFZpT3FtRlBvNHpMWHg5?=
 =?utf-8?B?K0VnQ3hqY1FRNkFMTDZaZGtrNDBMcld4K1RXVklWTmtEZ01yNUlhZkFOYnhI?=
 =?utf-8?B?aEloQ0pKcitodE5hT2VRRGUyMTAzdzBFQTBmZkpKQ3dhdSs5SlhjSms1WmdM?=
 =?utf-8?B?OFNCS3JNSjhNK1FFSldJcE1tOG1NeHB3RHRuU2x0V3VMdkJZQTZtd005M1NR?=
 =?utf-8?B?M0hGM1dpRDQ0WG1ZNWNXRjQ5dGFFUTNTZmZ2Z014Q2lMbFo2ckh5Y29DbFAy?=
 =?utf-8?B?RzVkS1BxTlhkMjVPWExMQndVcUgrWnJQYUlZWFExK2syc1NIS1VySlorUXBX?=
 =?utf-8?B?Wi85NVovMzBlSHdlOWJnZjk0T2NrWDhRMGM3aGY2cm1WUVlodVBJSUsyMnZw?=
 =?utf-8?B?RXgxRStaL3VrVFlLakE4aFRSVjNZZ3NVTFRYeVE1Umg2Snk2SlF3bTlnNE5i?=
 =?utf-8?B?TWttMUhwQ1BzYm1aUUtyR2I2a3hCRVpzS0pxOTV0MDh4RFZrVjhHQjNpU0Yr?=
 =?utf-8?B?VCtxUUhTcDFpSzd3ck04eVZSaGUwdWM3dXlDVHFWN0owazFPcXE1eWVIRDRz?=
 =?utf-8?B?S21rR1p6TUNXeDNSNW54TTZ2U0lIaTBIQWJ5Z0ZoSEsySWFCZmNKcUxLdWlI?=
 =?utf-8?B?YURPakcxTDhWK1FWaTl3REpwL0JOUmY1NWlFNXF2eGhxYVZDNnkweEpJamsw?=
 =?utf-8?B?THBZN3RlRExCcFV6MlpHbm1SL3p1bG9KeGxDbEZaOE4yWkRKK04ycGdxcVVC?=
 =?utf-8?B?dlM1d2lNa3h6VTRiN1g3Z1BxUjI1bUlwTDNOZ2srbXFQMFdZZlBrRW5hOWNo?=
 =?utf-8?B?UWZ0TXR0aWpFcmJlU2pyZkpiS1ArNGdDUjVjMjN2UnNpYmJHWmhkcVcvbHMv?=
 =?utf-8?B?blRGcldvRmFPRTdJaTk5S3RCbW1QQTNCWXN1bG9Fc1U5M3NqRGJQVmp0b0M4?=
 =?utf-8?B?MFYxdC9GaDFiVjY5TnBJVGQ0YVZVQ3M2UnhEa21sYk9qN3hUc3hYb3Y3ZHFX?=
 =?utf-8?B?M2t0ajVPQ0pFaGlndjRnbTQxY2pkcW94UVRQOGNrR2FsK3pucHAxNVJYcThG?=
 =?utf-8?B?dXl6Z1Ywc0hWNkZReEp4MHRsOS93RGdsNFdEZ2xKN2ZUVzhjcldYWWdGZmtX?=
 =?utf-8?B?RUlZVURPL3BxOVZPWXdwZXFEeWxOVWJ1WFA0TUhRVTIyZGNpOHRuZitQZVpG?=
 =?utf-8?B?aElYZFJIQU9ZSytaMW5JSG9nNzlzdTFyZHF2c29mK0xrSW5RSlF5L2VON0hj?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bca0ad92-94d5-4f1d-995c-08ddea91e3d7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:30:47.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hc3PlALtjMF4Poao+MqaLEf0NDkuXLgMQFaKN/vk4arYbNxe+qQBvoJ8RU93xjCesYYBWgBzkxlZvtqnKLsYyWfNqPeL1RHbQerwLOrLgws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> The "mbm_event" counter assignment mode allows users to assign a hardware
> counter to an RMID, event pair and monitor bandwidth usage as long as it is
> assigned.  The hardware continues to track the assigned counter until it is
> explicitly unassigned by the user.
> 
> Create 'num_mbm_cntrs' resctrl file that displays the number of counters
> supported in each domain. 'num_mbm_cntrs' is only visible to user space
> when the system supports "mbm_event" mode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

