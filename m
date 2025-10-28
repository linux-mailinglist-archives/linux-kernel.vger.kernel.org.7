Return-Path: <linux-kernel+bounces-874887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2ADC1754E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1349188A539
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6B3354AE1;
	Tue, 28 Oct 2025 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9vdH4Eb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31AE34EF15
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693435; cv=fail; b=cRWnYc/cuiqaO5PS3egi1U0Mm7R3KS6bUpajAIdq2sAFNgtXGLj4WyHDwIKISEUMo9Cm0JQ45QJ4WMYXBETrMtSw7arQSi/HG9oQqru+XXvqoiGilA42qtTSr8+G5vsXFkKTxruX2/AK5hKabh8BjZiI9Kh6roUkKXBlThiF9ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693435; c=relaxed/simple;
	bh=5wgvnVzzS1+XxwUoJ5JWtC+pFWxOTRWJPJf2aOirWKw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lr0B72ZMAvbGmMIBjseuOCMx82MIw1C8ekEOl9kyOrGdx0rLh9z/5IBcxIwttag+FeCzIm9n8u938N9S3K7WZOpoPHbxNWkfk88RGhZu04X/eX9V2RYnrlKnJVEC3B9jdApSw+n3s+hcU4YazMAlbloeEZz8SarYVXum9Shl/h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9vdH4Eb; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761693434; x=1793229434;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5wgvnVzzS1+XxwUoJ5JWtC+pFWxOTRWJPJf2aOirWKw=;
  b=M9vdH4EbzUEwV3ZY1bUr5pIY9Yl6Xt7BcnYmwyQgtPP+a5w4JRWQFWZE
   X8xk6SSoluuBlc6ZgIk0FLaZf+Ksc5Opj/c1iFazuqG+Re13/DwmeROvn
   eIp+djyM7B5/Fw4QAaYrCj4hmknosNiGvPXCt4fF4SUZuM4QYjf9WyRcq
   OBlZLaUXDz4v5GRjVjB+GKA6tTSPVHaod6LHj1RGA3I/Edrt/kNOfaiLO
   PWosetgGdyuxXrhFvsZDKHQW2oGFfdEwz5TroC9J2A5BF8vr52BXBT1Hf
   nCLUKFTuHap87gWCkFjfY2b6EcP7+NzzaNRr+rVl9g6Jz4d3/v7XgiNj/
   w==;
X-CSE-ConnectionGUID: sQKAtUnmT2Gv19S8JWWJ2A==
X-CSE-MsgGUID: br1JLFjcRaCh1HJpn+V97A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63955574"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="63955574"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 16:17:12 -0700
X-CSE-ConnectionGUID: nbUAH4NxT7KhW9EsQZVFyg==
X-CSE-MsgGUID: 1xju/mujQWOWUQetL5Olag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="216360806"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 16:17:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 16:17:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 16:17:11 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 16:17:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLw7Es67fHT72UEHJ3pyYFUdABHpJsLbxwr7L2i8rF5J6QeXQSY2O4hQzjvoUv5DyWHxg7Y+Uoqr13FIZcYc9dAVJuz/CFxm3V/rg2Ql/grorlOcf5ypxCwygfWsmu0FNsx52tbk2oQ46NDHeCUBGvOA9SxH5DM0ZAIyvthA5LXfUAwR2Tzq5xLpKaoQ7FtS9uSwuGh2C0OHJdl8POijeg+jlymUvgkvZqNB7bkVB+0aAqD5PZeeVMX6n/nE+NY+k0wsA1ipIF730AOuQFS0oq6Xo8AOylW784Lx+rcleHh/RU7aF/mbNDIPeQGr8P5fEvkCz+gZc0fVDseA8Hui7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu7J/B1ixJl/LqgoCJiL2TyTS2ARV+ms7fS7FD0EuoA=;
 b=Dr9WTOWOPWxRcHFgCwdH7OdclVXggvBSxLIZ+tSNH3/YfuKoRP16vwfPekvTBwvjLzzfxRqA0J9VSuHSts3+r5/wtJT9waui5G2Yn1ftzJnu9l4z4LYfPWMA+VM2AovGuXWAVyAvfSJFw+yyhcOfuXsIIlmr6VpkjM05ESmPHBVZMVB4WjFcLQDg5rHyQR3kyF8BdRzHakAPh+fQIv/xD3pnSM3UVbw7IGjpnosxpdSekJ0++Xp9HDGZILWy3LZpNWAHbFU/cQTNACe7lwAP5gflkViUFhTivyXqWE0Bz8r7iIk+jyQkDPqeAVIB3AC11dfY4ne1cs3S5/3h17MMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 23:17:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Tue, 28 Oct 2025
 23:17:07 +0000
Message-ID: <a9b49861-ff36-4550-ad29-a737eb5c1d63@intel.com>
Date: Tue, 28 Oct 2025 16:17:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fs/resctrl: Generic schema description
To: Dave Martin <Dave.Martin@arm.com>, <linux-kernel@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Chen,
 Yu C" <yu.c.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>
References: <aPtfMFfLV1l/RB0L@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aPtfMFfLV1l/RB0L@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:303:b7::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be458a3-30eb-4447-a043-08de16781d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXNmVVEycjdLYkVwanhlU0VxUjhGRmMwU3VZdkxJWW9wbFMzQTlLWEQ3Z2J0?=
 =?utf-8?B?Z3FjRmk3QVpveHVtY1hVSEl3Z0tzb0V3K3RQa3YrT3NpcXpBbi9kODh1UnE3?=
 =?utf-8?B?VG4vbTJQNVRhcWtsTU0rdzFaak02SmFuV2x3N3pBUGpLNlhPVFgxUitnNnQx?=
 =?utf-8?B?OTNseW1qeTU5SmhnZ3pSdU1CVlVySWcwaW52UlNzcHEwZlNEOVFCS1d2d0k5?=
 =?utf-8?B?dEJodjA5cW50aFQyeXdEV0VrTHNPTFR6SjZZUUdyblcySm1KUmxNb3l1NS9j?=
 =?utf-8?B?N0grTklZZGVMb2VLOHJPL0ZlYUU5VkZLeE41OEg2UVlXWmJiZjlWQUUwYkdx?=
 =?utf-8?B?ekpFZWdZeXNXQ2l4eWtZK1BUNlRwVDYvNXMza2xOWHEycEhFa1hKOGVRZjhp?=
 =?utf-8?B?MDJvaXVhSGtxK1ZnRmlZVmNORGJkSENaL2ZDTWJjd3d3cXB1Nnk4aThoK3dG?=
 =?utf-8?B?UUxpZWM0bE9lUXBWUzd4YUpFOElCR2VoaGNvbm1YVGpFUm1GL2V2aXlmRGhS?=
 =?utf-8?B?UFhsN2FRc0ZhcHVUODBKSHUwSHhDRVFOMWppS2o1aGd5UGJMSGo1c0FueWx0?=
 =?utf-8?B?S01acW5RK0hDTlRJeVhXNndsb0tCL3hYTEFXaUJYSW1wckc2UG5wRkNWRHVF?=
 =?utf-8?B?K2U4RDl4ZUE1cElzNGIxR2FCWkJWVDF3REFCSDdBRDdpY041Tzc0aWdhMVFh?=
 =?utf-8?B?TnBuM0ZSbmcrdUdkdXhYSmFxYjhyOEd2MkNPUjJCajNieXdCWTE5RDJsbEVj?=
 =?utf-8?B?eXZPbmwzemQzT3RpWExTTlNXSE51YjErQVpvbXI5MjZKeE5rYjNYZ2RXRTYv?=
 =?utf-8?B?SEF5NzhucVdnM3ExNm9OSUlCNkNMa1FvWWFCd21xZlhOTkMxK2VGb0FrRDdJ?=
 =?utf-8?B?eHdwU0MvZXVPaEhWVEFnOEJEdlg0c2RGMWltRlVuYWNKbGVRdnU4QmRUNGlF?=
 =?utf-8?B?bWY3eEU2ZGJvU0VPczIyWEhFZ1AvMzFnRFRlSGZaZUlXUFRXNlpGZnFRU0NI?=
 =?utf-8?B?djE3aWllTUxoVjBxZy8ycWxMRUF5Q3VWc1BkZ1M2S09lOXIrdzIzSnV6V2p5?=
 =?utf-8?B?Y1JEOHNwNEQ0Y0E5QWIwaTdVMHVkV0craEY0b1ZIYjJvQkFGakVJVzl2YlIw?=
 =?utf-8?B?OS93QitwMjFMR3d3ZlFIL2ZxeEZTRlpVYUpXNjhIT0lTQzduOS8zaGltTmtz?=
 =?utf-8?B?UWczOW9vWCtLZ3U3M0FOVGZ6Mi9pZU1SRlBFOTl0SUdIL0o1NTRSR1FCYmFI?=
 =?utf-8?B?TW1kanhONGFMTm1CQ0xuV1IvdW96ckoxUHNKWVhDOTlUeHYyT3M4SUhuRDNk?=
 =?utf-8?B?Tm45L0FoMEZFNEE3WEQvMnJ6S210OWNMU0Yzdk9JbjRQZWZkVkpVMXZmVGtL?=
 =?utf-8?B?cDYya3czMDA3Y0Z2VEc3K3VPVk9EVGdyWFFZaVlNRGxSNXBKSE4xTGtJYkla?=
 =?utf-8?B?ZEpjV1NxRzdGeGlEejZPS3BOZU5CclU0akt5bFpOdXJqalpHeUxmamEwaEJQ?=
 =?utf-8?B?blVtMlFNMHd6QmJnMUZtN2FzZTJCdUdVUFI1cXppaGphTUNPNEtyb3dLdkMv?=
 =?utf-8?B?ak8xcnFabFg3dEw4UjVSUGtJbmF0VHg4N2JWMlZKbXZHQmJkLzdQVjlnT3lI?=
 =?utf-8?B?TWpmQWpXS2c1czdlNk95cjVpbE90YU9FVk9sV09rUi9WMjVUb2VEU292UWdz?=
 =?utf-8?B?ZUV2VGtxVmxsMHRGdGE3VE1HUEp2TU42T0ZFUWxySTVnOVh5ZUkwcnhGaXNz?=
 =?utf-8?B?REk5WXlMR1VuK1ZFUHhJb01UdnFSZm05RW12bFMzQ2V5eFB4Z1NiY1l4cXBU?=
 =?utf-8?B?NGVHeVVCUDJVajVUZ1JQQ0dCOWlyNmNhMVl5SkdaOWJaQ0hhYnh5aE9aUDk2?=
 =?utf-8?B?REZibDk5YWg1WWd3U01DdWhyVVhzKzZzb2JheGNlRis3K2ZVaVRId0x6cmRu?=
 =?utf-8?Q?HiODMb1W2hyF8s76WJRpFoVAVbYdXAtm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG83WnlTME9mNXJnM1VWZ0pYS2k5TjBoaURITGYxTy8rRU9uTnU2TDlWMmk1?=
 =?utf-8?B?d2NIWXJkQkxGeXFnRjlCaTR2SjlzZW1kSlc2S0Nmd2NUZHo3M2lMZENreWtZ?=
 =?utf-8?B?TGJjVWVHemtTS2plL2xOMnFXK1MzT242VTNBSG5IWlBpUktOUXpaYzd4M3dr?=
 =?utf-8?B?NktieVVnR0lsV2pvRGhIMHd6bHJrMFVlSWFDRnBsV3lpN2hOd2JYTURIYWI5?=
 =?utf-8?B?eVFIYVB1blMwTVloSGdjWW9uOEdtVjRhaldrNFN6S2REakQ3NExRVFR3SzBE?=
 =?utf-8?B?aU56WjlQWUtGajU0UlRaVjVnNHFYaTUybGM1dmZZU20velhVLzk3Q2RKcTdS?=
 =?utf-8?B?YWwvd2hNWjcwVEMzSFQ0Qm5WM2NuR2h6MytTaml3VDNJV0VKdGY1aEl1OVJM?=
 =?utf-8?B?M01lVGNKRk41elZDWjZUSHR6ejBGdzY4S0lrckp6VU9NRzdlUUowVkw5bDEr?=
 =?utf-8?B?K0RHUzZTRm81VkMvNjkwMkJTUGZPS3BVUmFqWXBwc3EwVGRCcmxjb284Y1Uv?=
 =?utf-8?B?MGpySjJwMzB3TzhFSHRMV2l6aWQ4eXYzNTJnNXdyVnhPYlJNRE4rVlh4ZXk5?=
 =?utf-8?B?a3paTDd3SGNyd2NZN3RIWjFkMlVJODJZTUZEV2VqbmprSTNoL1VrT1NFSzMv?=
 =?utf-8?B?Y2JPWUxnUTNrZXVPRnFCT21TdXNVZ1RWR2F3dmRtM0NIdEUyTEhkS1h1Rytk?=
 =?utf-8?B?K244WUtoTm5wazcwQzRtRlNEWDQ0Q3lQZ2hOOWZ5Tmlvc3dETWVPMnFOVzZ4?=
 =?utf-8?B?cE9IN0VhTHI5WFY2REF0Q1Ixdi9FUFNJdENoS29NbXhHaEhXdUhpNWo2Qy9w?=
 =?utf-8?B?SU1BcXlUMThzMTFJVUZmaEFveEZOdGpudTV1R2VxbHVtTE9tbkR6bDhZb24r?=
 =?utf-8?B?bVB3OG4vbXlnRjhBdDlTQjM3MWJIckQ0Z2RHL3dJSlpaWEYvdVgxWFFaUUdK?=
 =?utf-8?B?M1o1aFp5SzN4UURxMmNzNGRZSXRoUEJ0NXRSUDA3b2dhb0tHWjNJNjB2Y3ha?=
 =?utf-8?B?ZTIrUXplYkJtMktHdVRORWF2aGVEQngxVUxHaUgvSkV4SEJmbDBHTDVPeHc2?=
 =?utf-8?B?QndySDZqUC94MlI1RHZtRERKT2hROTJtVjFUVkQ4OXkvZDA5VDdEbVdYK28r?=
 =?utf-8?B?cFF3ZWUzRUJvVlhMZmpKcTdtalZTV3JOZ3pFRXhxYkZSYjFLNXpWNHJQRTRR?=
 =?utf-8?B?czJPbEVWajdFa205cC9ZaDJBaUdWSVhLSytFbENEQmwyQ2RhcG9yRFZjUi9z?=
 =?utf-8?B?L2xQRlJQUklveWR6SkQ1MHdXNHpHS0tpMzBBVFUreGJFNjNFK3lLeFIrbjk0?=
 =?utf-8?B?aXhkOWNYL0o1VXJ1YUY1bThNZVAraTBIaWYzTUJQSWwrNHloRzVBeEVnVmZO?=
 =?utf-8?B?blgrY1NWM2M4V1NhdXJHQVZrY3ZKTUFHS1hMWSt3MDVvcHJxai9jN0dvUjVm?=
 =?utf-8?B?bEJzK2M0WGRMc0ZhV2p2V0ZLZU0xbzVTNmtTam1NalY2NEhrSkNOeFIxbHZU?=
 =?utf-8?B?TVcvRlF0YVR1SXYxL0FjVHR6QXNxMkRkMnFpcldkVnd6QVdreXFPZ0pZcUV2?=
 =?utf-8?B?RVNYQXA0VHFjUVEyNWlPbHo1SUlDeXR6NkpuTy9hb0EzR2dWTDBtRDBsZUpW?=
 =?utf-8?B?RzQreHh6aG9VdmpWY0VoVWJPTHpFclVrNy9SeWZkWE52S3pEbTY1TFdCNWpv?=
 =?utf-8?B?YXVDSlJJYVpBUXovOVVycFNZamtXaVRMRG1CQmxRV0h3d3M5SlVVVlRIWUx3?=
 =?utf-8?B?ankrUUUyaDA2WnNHNm0vdnoyL1huek1GNWFYZGVhNk1kVWhUWlIyalk5VTJH?=
 =?utf-8?B?Y0NnU3dMaFlJQXhtOEd4eVJsK0NIak9ZV0ZvRUNIZjh6TUNpK0RYTnpORmtS?=
 =?utf-8?B?cWpPYkVwRzVDUk5xZ1BwcmU0ODAzcXEremtWS3NSU1NFMjErWnhlQzB4NlBX?=
 =?utf-8?B?cy9KUkxYaVNVV09mMHZDSmpEZC9HUEpySDJFK1U1YkhqSXNEU0RNVWN5aEJP?=
 =?utf-8?B?Z3VKajJWaVFOT29QaVc2bEZoenVJREhkWFN1QTkwZkpBcVhwb3RQeEM5ZVZl?=
 =?utf-8?B?RWpJenVXdjJCSVp5RTd5TUtIenZsMUE3UG8xL3g4SDdpK2thQzlubnRVYUs3?=
 =?utf-8?B?dkFmMm1Nei9VMTNtejQ2bFNtMzF2ZE54eCt4UHVnN2Z2dGdia0Z2ZnZvdFpX?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be458a3-30eb-4447-a043-08de16781d3b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 23:17:07.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNK5sBritcG0BgEAFcx56cODvakxzzrm+sz+7jQwZW/aAev9g+A4WNxMsq/TT5ijn/fN7fh1mNIFQvKdT6ceZ33qAxW4ohPpd0kX0Y4g05s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com

Hi Dave,

On 10/24/25 4:12 AM, Dave Martin wrote:
> Hi all,
> 
> Going forward, a single resctrl resource (such as memory bandwidth) is
> likely to require multiple schemata, either because we want to add new
> schemata that provide finer control, or because the hardware has
> multiple controls, covering different aspects of resource allocation.
> 
> The fit between MPAM's memory bandwidth controls and the resctrl MB
> schema is already awkward, and later Intel RDT features such as Region
> Aware Memory Bandwidth Allocation are already pushing past what the MB
> schema can describe.  Both of these can involve multiple control
> values and finer resolution than the 100 steps offered by the current
> "MB" schema.
> 
> The previous discussion went off in a few different directions [1], so
> I want to focus back onto defining an extended schema description that
> aims to cover the use cases that we know about or anticipate today, and
> allows for future extension as needed.
> 
> (A separate discussion is needed on how new schemata interact with
> previously-defined schemata (such as the MB percentage schema). 
> suggest we pause that discussion for now, in the interests of getting
> the schema description nailed down.)

ok, but let's keep this as "open #1"

> Following on from the previous mail thread, I've tried to refine and
> flesh out the proposal for schema descriptions a bit, as follows.
> 
> Proposal:
> 
>   * Split resource names and schema names in resctrlfs.
> 
>     Resources will be named for the unique, existing schema for each
>     resource.

Are you referring to the implementation or how things are exposed to user
space? I am trying to understand how the existing L3CODE/L3DATA schemata
fit in ... they are presented to user space as two separate resources since
they each have their own directory in "info" while internally they are 
schema of the L3 resource.

Just trying to understand if you are talking about reverting
https://lore.kernel.org/all/20210728170637.25610-1-james.morse@arm.com/ ?

The current implementation appears to match this proposal so we may need to
have special cases to keep CDP backwards compatible.

SMBA may also need some extra care ... especially if other architectures start
to allocate memory bandwidth to CXL resource via their "MB" resource.
 
>     The existing schema will keep its name (the same as the resource
>     name), and new schemata defined for a resource will include that
>     name as a prefix (at least, by default).
> 
>     So, for example, we will have an MB resource with a schema called
>     MB (the schema that we have already).  But we may go on to define
>     additional schemata for the MB resource, with names such MB_MAX,
>     etc.
> 
>   * Stop adding new schema description information in the top-level
>     info/<resource>/ directory in resctrlfs.
> 
>     For backwards compatibilty, we can keep the existing property
>     files under the resource info directory to describe the previously
>     defined resource, but we seem to need something richer going
>     forward.
> 
>   * Add a hierarchy to list all the schemata for each resource, along
>     with their properties.  So far, the proposal looks like this,
>     taking the MB resource as an example:
> 
> 	info/
> 	 └─ MB/
> 	     └─ resource_schemata/
> 	         ├─ MB/
> 	         ├─ MB_MIN/
> 	         ├─ MB_MAX/
> 	         ┆
> 
>     Here, MB, MB_MIN and MB_MAX are all schemata for the "MB" resource.
>     In this proposal, what these just dummy schema names for
>     illustration purposes.  The important thing is that they all
>     control aspects of the "MB" resource, and that there can be more
>     than one of them.
> 
>     It may be appropriate to have a nested hierarchy, where some
>     schemata are presented as children of other schemata if they
>     affect the same hardware controls.  For now, let's put this issue
>     on one side, and consider what properties should be advertsed for
>     each schema.

ok to put this aside but I think we should keep including it, "open #2" ?

> 
>   * Current properties that I think we might want are:
> 
> 	info/
> 	 └─ SOME_RESOURCE/
> 	     └─ resource_schemata/
> 	         ├─ SOME_SCHEMA/
> 	         ┆   ├─ type
> 	             ├─ min
> 	             ├─ max
> 	             ├─ tolerance
> 	             ├─ resolution
> 	             ├─ scale
> 	             └─ unit
> 
>     (I've tweaked the properties a bit since previous postings.
>     "type" replaces "map"; "scale" is now the unit multiplier;
>     "resolution" is now a scaling divisor -- details below.)
> 
>     I assume that we expose the properties in individual files, but we
>     could also combine them into a single description file per schema,
>     per resource or (possibly) a single global file.
>     (I don't have a strong view on the best option.)
> 
> 
>     Either way, the following set of properties may be a reasonable
>     place to start:
> 
> 
>     type: the schema type, followed by optional flag specifiers:
> 
>       - "scalar": a single-valued numeric control
> 
>         A mandatory flag indicates how the control value written to
>         the schemata file is converted to an amount of resource for
>         hardware regulation.
> 
> 	The flag "linear" indicates a linear mapping.
> 
> 	In this case, the amount of resource E that is actually
> 	allocated is derived from the control value C written to the
> 	schemata file as follows:
> 
>     	E = C * scale * unit / resolution
> 
> 	Other flags values could be defined later, if we encounter
> 	hardware with non-linear controls.
> 
>       - "bitmap": a bitmap control
> 
>         The optional flag "sparse" is present if the control accepts
>         sparse bitmaps.
> 
> 	In this case, E = bitmap_weight(C) * scale * unit / resolution.
> 
> 	As before, each bit controls access to a specific chunk of
> 	resource in the hardware, such as a group of cache lines.  All
> 	chunks are equally sized.
> 
> 	(Different CTRL_MON groups may still contend within the
> 	allocation E, when they have bits in common between their
> 	bitmaps.)

Would it not be simpler to have the files/properties depend on the
schema type? It almost seems as though some of the properties are forced
to have some meaning for bitmap when they do not seem to be needed. Instead,
for a bitmap type there can be bitmap specific properties like, for example,
bit_usage. This may also create more flexibility when there is a future
mapping function needed that depends on some new property?

Reinette

