Return-Path: <linux-kernel+bounces-836482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE40BA9D15
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B68189D64E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402D430C0F1;
	Mon, 29 Sep 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Br7srbix"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04830C0E2;
	Mon, 29 Sep 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160308; cv=fail; b=BqOXDIKn/h9rULjnNAF3ii7BiEzmACWyhVakPIYTBcP6bvUzNson4DsNLTW+G4GzGO5Jp5avp9Ts6bBzS9lxUA1K3PkQPHbNbwfyzmu140rUP+SkB7/Aj8Oflu/eSWfLrrk3XgIHIk76pDXQkTk4AAeMl5I6btK+QEO/Uqpt8tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160308; c=relaxed/simple;
	bh=hz/zeKmcEmTtkoumwvFq6oK6ymkfkriPucXZCLeOW5Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cd9jkKR+ql4simq4sJzjv0t9bSuoRpvjBOICdk8flJVeJv99J7wUKpMU753TuQ0JvxBMzVWQvOfsPfmF7sUI9nUBLt0qR612sgmqGgyXk81AMfGT0RgqvPDhmhvyOpDBRtqD7joiwrWii34su036NtJGQBU17KCpsCRyQDEGrqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Br7srbix; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759160306; x=1790696306;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hz/zeKmcEmTtkoumwvFq6oK6ymkfkriPucXZCLeOW5Y=;
  b=Br7srbixwsWK9KOIMt96iLDzDQylcyCIPKPY2J4twSo7VGX20hIFGZgj
   3q+0aKTBt4P2TsbdTumHBDW4BkqKqrDCquzt5fypvlSdzNpz7HlJTTl4r
   g+wlFb/b+uWu+mzDujKuSVlVDLYnWjSwKWOHUXhAEZ9vAPj/uieIksE+3
   A3nPI/BmE/lBpx9BZGJyamBmrXDlO3W4s+IQNpSbg5+GSXwUG4sJnl8PV
   pzODwvyJ7RpTymPu/DFTax9kXsflHm4ww6URXpk+Mc4hmBAYiodj6ds+L
   s1CJ3hkxrQfloVUm079ODef2ix469LqrG7kf3XjB/7QUgqqf++VlYfE+4
   Q==;
X-CSE-ConnectionGUID: ZKADNeX8TYCLcxHoXRdagw==
X-CSE-MsgGUID: LBIdHh1fRgmwZyZ8vB/2yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="78828443"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="78828443"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 08:38:25 -0700
X-CSE-ConnectionGUID: 641w3COXTjCDYRH/sx9xBw==
X-CSE-MsgGUID: Hz+FoXKTQ3OzUXUO90A5eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="177515576"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 08:38:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 08:38:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 08:38:24 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 08:38:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jX0JWVmrQ8NMGzGRO7hBL0U8Z1fnkfCKFAtf9D9v5CyyP3grAgQxSHWlQBph62kLPAXTeP+z4i55M2j6wbkMKbcAwbOiAOuCW/g+flKLlNVzyuMjHz3QuSKrhtndsrGIxnU08i8qRRBfyEQXdq5Kn75IoFGiu8YA9yHHktrHktnOjPXw8yaO7jW9da4RLefPOjHEzgwKtcsoyzs/W8vhlkU/M8bBrUfv5sSxBF+vLnetuBXsjyPMpX4eVYc6RRD7EnuqBJb0O9D8vPFeHDyquljSFa61GO+tcKLegFQEMX5TN9yV418paH41zYgxON4fEedsxQ6WdeTcxkT3mht2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOjD8CskKMpRuJxqhgD2GhQ4pb8N55L6crr5gW8R68E=;
 b=s+2KratI9cavwyP9Y227lcX8iQtOgpHT5WPIQXe3/eR7DCXdNKQxahNH+ivCRJHyvb4mZ+9GslMnB6/O9AJnod8rVp8JkYMsseRQInbQlzEjGoTSgU0qtAXVQpD0yz+vlignaBtW+y1IkZ479EhG8Jt8406XAWudGSHrCAYYGFHrzUNiPogw6akQg3KaBMMy3CG0H9mxM2NvQVTWUktr7pWyCbyRCNpyuWvZg9jvL6j/nIkNX/FE2cuOccXfaWu4oTCfMciesvKblMTNCoC5jVODKJXMpVAI1x1s5URK/EnVdw10b7EWsGP/O1EuzDQuxZ8lKtA7+95wMVcpOwwN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Mon, 29 Sep 2025 15:38:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 15:38:16 +0000
Message-ID: <c91846ab-e08e-48e9-83bb-357eab4b9d87@intel.com>
Date: Mon, 29 Sep 2025 08:38:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>
CC: <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "James
 Morse" <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com>
 <5be54a14-a7ba-49ba-8ddc-db532f2cf318@intel.com>
 <aNU5nCklRhuc4u3X@e133380.arm.com>
 <9dba03c5-cf45-4510-ab6c-2a945e73fd1c@intel.com>
 <aNp+7yjrs36/hSPS@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <aNp+7yjrs36/hSPS@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dbfbd3-391a-4a10-0070-08ddff6e3503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXJuaElyd2NBRmRUTlVJQjZrUkM0UUZJR04yOTNmNzJKUjVmV2FhTFZ6ZW03?=
 =?utf-8?B?VnAwY1dXb1lUTmorTWZyYTlqZjZrM0hBaXdoV1VqanVGSEFXSVVZdERscTJq?=
 =?utf-8?B?TTRvRS9RekE5bFVLVCt4cXRiTnJtcVJldjJybHFSNkZyU2paeFdnRWtURUxB?=
 =?utf-8?B?enVlT2VXZTlLeDQwM25nTGc5NFRPZUcrYldtVTkrVzVIRFZhQWlqOGxXOHRa?=
 =?utf-8?B?L1FqTTVyNE5ORXQ2TFh5WmlZc0JaK0JGbkVGS1dTek9QT0RZTWIrMWVGUTBv?=
 =?utf-8?B?R3hqdWZhcW9EaDJHb1Q3ZEMxbkN0UkszMmVMMkk5R3ZtVit6WjVpZXI1Nk1G?=
 =?utf-8?B?NU5lcVloWjdIelc0aldrS1g0QXBjaWlyNWRpeFM0TkMvYVBNTk96M0JGQnNV?=
 =?utf-8?B?Q2pub2M5ZTg0V3VkZHA2YmVnMlBlaVdqQTA2RTViMlIzYWhXbHNvNlZhVDVK?=
 =?utf-8?B?dHN4dUVDZ08zSUN1ekIxckJUQUZuRW93aFRaMmNWczhOY3NMQUFjeEp2b2Zq?=
 =?utf-8?B?NkU1QzhFY1VnZnZMVDZhL1FqOEpQMFdKdGZRUWFheCtMUk56cTROOWNIVzFD?=
 =?utf-8?B?RDA2TklPNHIzNDdWSW9NR3N4ajV2bStvRVlkKzVaTFFydUR1dTFKV0RrMHRu?=
 =?utf-8?B?U2tPYVlYUEZ6M09YcWUwRnZHQmtKdWdWdXo2Z05BUnBOdzZHYnRuOEhkUm1P?=
 =?utf-8?B?QWhvci94QVN3QW9id3NEYktwUmFtMjZiWU1aTVEwamN2dHF0YnpBWTRqd3o0?=
 =?utf-8?B?OU9FY0lNcnh3Wk56b21XamRxWmJaVVVTUTkxRlpGK3VHcWdxMWdLc2w2cGVr?=
 =?utf-8?B?dFdFakVsRmtSaUdWanBqTGpFeHg3TCtVRXJkakJkbWpkZEpJMm11M0YwWnk2?=
 =?utf-8?B?c285a2JqUnNDeDA1UFFPak1pRTk4Wjl0L1c5YWFmNXRCeTVQcGx5YWYwYnA2?=
 =?utf-8?B?RDFNQmVIb2paWlVGdnI1YjNlR000VjY2QWU1VmdEc3RsV04rbGxBeFpKcm1X?=
 =?utf-8?B?bEdlc1IxakVnU0U1eFJlaVdaTW9nKzFnYWpVdkxQVGpjem81RGVTcHRzeVdz?=
 =?utf-8?B?MENGRks3ZUQ4R1BUQW5Iblh6aGtWa0F6ZGpWUW8xMW00TG1VNW10RzVkdnZY?=
 =?utf-8?B?dS95cnRCSXg2SFFwUnpQcThRL280a1REUXJYVDN6aTlFK05USWxvZmkyWEpu?=
 =?utf-8?B?UXQwaEFXSElpMUdMemg4Vk1yNHVmVUZhRmsvTFlvai9wSFRoQkR5aDRGc2dm?=
 =?utf-8?B?REpXd1VFRjBmMmo0UERnMlJoTTk0bXRnYXFSWC9oVEJOLzRpeFAzdUZ6R3JW?=
 =?utf-8?B?TVdIdllsczdZTXprMG03dWdZK3htMHFwNGdnQ3NaLy9uUld3TGtKR2VvTDN1?=
 =?utf-8?B?ZFo4SWFrd0dGVnM4cnZydHMzdEpXdkJWZlJ4VHZVeDJxQ3VNZTAySkl1OEFl?=
 =?utf-8?B?RDNmM0NTankrUzdQUFNobVNvOWdCRmVOZklCTHlXTUxIelhnRUJtNDNWSHYr?=
 =?utf-8?B?QnFWY1NvTXRhVTV3cGFObzVhenloOVhoZWhJWWJWakJmVC8ycGNZb2czQ045?=
 =?utf-8?B?WXBFQzNJZ2Y3c2pYbi84S0QzUmtPU0pkZDZSOStsTFdmMmwwdEh2Y0NpSmw0?=
 =?utf-8?B?Qk1JRStLaFFxTFdWT0RYdWxtLy9Fclc0RHNaZFd5Z29pTGdTd1BSZ3grZEkw?=
 =?utf-8?B?VzNqdHk5b2hmV0w0MU5na0tQdzllRTFmOWV0V1dXU1A5NldpVWtwRmZVelVz?=
 =?utf-8?B?dlFCaE1NSzFzOVIyWVRaUFZpWWwyT2IyNjcvM2Fuamo3aXJuMVZRWkRKNDN1?=
 =?utf-8?B?dW4wbjR4VG5Fd1E4dzJodlZjdWxDOFIvVXFlUGd5MXN2MkZoLy9jeW0vN05w?=
 =?utf-8?B?YXZ3K3BRUmVBQWVpaVJVSUZhRk8zbWM5bHYweFhyVXRkK2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RThHa2xTL01qYVhEYld4dE0xT2VtU2V4WUI3S3FZK2ROajk5ZUEyQ05xeHBR?=
 =?utf-8?B?a0JlcGg0MkxSbWloTEpVQk1PbVVxbmJ0QTJ2YzdhQThLREtVM2JjTGE2TDBl?=
 =?utf-8?B?bXZEVGFzdDNNU0tRN1FlaGQwcTlZUk9UbGMreGNZY3VSZVoycG5zaXJyWWla?=
 =?utf-8?B?TGMwU0oxL3BNVUVoa0tQOXIzZk5SQ2tqOVoxWTM5TVM2aXcweTdRL0xEV2pw?=
 =?utf-8?B?djdEbEFRYjZOL3lSN2dqRXQ4aHdzdE83UXgwRVBmNFJpaUNhajJVNDQ1ejQw?=
 =?utf-8?B?eWRtSzNNems2MlMycUN2b2RpeTJJZTVtcmkwV0Q4blY5R3J6ZkNNVG8waDB0?=
 =?utf-8?B?MVRveWEzYWNLU0ZpR0Exc1RZTHdmbjVZTVBvb3gvWTZGd2tKY2c3aUkxM2Mz?=
 =?utf-8?B?RlRWdGhiSGQxSXNWcUpBUDFiZ1RiYVVWNThGMnpqc1RxTjB2eDVFeE1ySFls?=
 =?utf-8?B?RHZwVjlHZnUyNnpTYXk4NFFEanU1TE1lejRIaVN0Wll0QWhUNk1udnN2OHRn?=
 =?utf-8?B?YlArQzEzcEFqbG1XZGUwUGxYK1YyR3hoM3EwaDdraUVTUVBiMGxES1kxODIr?=
 =?utf-8?B?UFVyR21sM3ZERUNoeUJyaGtKaDhwSVV1aTZPeGJINmh6Y0k4SUpQWFZ4Tjgy?=
 =?utf-8?B?RDNuaFJjeTB2ZXNkZ3RCYTBOVS95am5WQ3ZuUVI5UWp0ZlV2UXJQU0J5c1hZ?=
 =?utf-8?B?ajNZdTN2V21XeUI4Rng1RllMM1RTNVhvU0RZcStRZXhlRzBoaTFUZU5MUkp4?=
 =?utf-8?B?RzIyeUN0ZEpvWTVlVkJmcDJsN2c1SDVEQ29xNVlJUmRpc0hldjZjSlpRT1pL?=
 =?utf-8?B?eVNyUkhpbnpmZWRkVnc0MkEwZ3NmOS9NcFFXd1BydzZNdUFjKzJHNG1vMkFz?=
 =?utf-8?B?ZW8vVFE4cStnbVBQbDZYeEVMNHA1ZVJkT3AwY0pxR3RCUDNpYjRKU1V1bUZG?=
 =?utf-8?B?ZEFDcm1JdGloS2JxM0Fyd0lHNWozVTJRbm8yc3BXckdoMjRaZ3pEdHN4N1RW?=
 =?utf-8?B?OXIvT1V5aHB1NGpjSkFMZUNadU5TdDFtK1V0VWcraUdkeWQ0dkR1RlRxY0E2?=
 =?utf-8?B?Ty9VV1F5SVVtSnhGZzgyTUFCSkFteUd5Ymt2ZnlYS2d1cDE5aGtCK1Joamdh?=
 =?utf-8?B?UWxrMXMvdDRkU0ZjNW15VG9VWXVHUy9ueTdKMktRSjNYMkRQcndYUDJ5dTRw?=
 =?utf-8?B?TTU2TUM5NldxN2t0ZUp2bmducWV3OHBZYSttK3d2VFlsYlNwQ0tKV1pzREdL?=
 =?utf-8?B?SXl5Z3NZMGpoYnRkbUVQbUpCczBzcVk5a2pFYlFleXVtRkU0cHRIWTJJeitE?=
 =?utf-8?B?N1BvWVpkQlliRERlc0tkalFHb212WGt3SlBDWEoybS9OeG9GZjBIWi9BRHNM?=
 =?utf-8?B?RFlzWmExUU9zVUNqQ1N2Y3lPd2hwTzNpTUx0ZTdkVWlvaCtnV0pVU3c0dzJp?=
 =?utf-8?B?cndhb3p5dm1jTmZ3SDFNNUhTMHA2Nm11STd3YUVCQWpVOEF1S3E4RnBQaEVG?=
 =?utf-8?B?SHlqcnhzRXZkclcvT2RLMUx3aEFGRzc0QVRkU0l2M2pmaEltaUp1akVXQWVN?=
 =?utf-8?B?c2F6d2haNFg2K3Q2SW9SaUdYSW1IQVNZbzY4QlZFWUU3Q2orMTFMZml1d2RC?=
 =?utf-8?B?SFFJdXJxcmJrOGNQSmJtelROOEkwUWhvYzkzQjRHWUFxdEVsbit2eVpGaHRQ?=
 =?utf-8?B?Q0d3dGh6ckdiQ2VBdDBTdHhOLzZvMEtUNFhCZmNDRkowcXRra2N5UW1mQksy?=
 =?utf-8?B?VmNIUE03ZzlEM0NVTzRNWWs1U1h1RE43RHdwZVpOWFhtRDU3ejdZNmMvbndk?=
 =?utf-8?B?ektOOGZHWWNicVNMa3Q2S3ZBdjBGbk9PZ3NOd0JvMlMwV0R3WURNZjZqSGtv?=
 =?utf-8?B?Mm1LVEJVdkY5SU9DN0J2YU9UT1VYTU5JNkdhR3FCTUM5UFlwNThuYXcyZFpU?=
 =?utf-8?B?NWdtZ3k0Y1o3SjVVMmFqV0g3bThndVRMb2NHZG1lNHFWYmNoUHpDeU84L0E1?=
 =?utf-8?B?ejl0VWVlT3V2cVZwZWs0WVpOeVVLcjRhWHVMaVVRVVNrR0h0MmcxbmJJa1FZ?=
 =?utf-8?B?Q3l4L0o1SDNqMHN6UzVBbGtHN3I4dWVJdWJhWnlmWDNHNnFPTkQ3bWNHV3Bz?=
 =?utf-8?B?a0hacElORzRmOEtsclpJYnhQZmlCQ24rMkRhV2hBdWs0dUhvK1Yxa3ZIaFlH?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dbfbd3-391a-4a10-0070-08ddff6e3503
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 15:38:15.9300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBDVj4f/9cTqGDT4IrByZLmUnmT6zLwSSlNNsEtiJCoS2//KD/jCxeBXODozd2RvO5D2/NAJ09FLvhcc033VGAN9VN061WHKtg6uHvrJ/ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6502
X-OriginatorOrg: intel.com

Hi Dave,

On 9/29/25 5:43 AM, Dave Martin wrote:
> Hi Reinette,
> 
> On Thu, Sep 25, 2025 at 09:53:37PM +0100, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 9/25/25 5:46 AM, Dave Martin wrote:
>>> On Tue, Sep 23, 2025 at 10:27:40AM -0700, Reinette Chatre wrote:
>>>> On 9/22/25 7:39 AM, Dave Martin wrote:
>>>>> On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:
>>>>>> Hi Dave,
> 
> [...]
> 
>>>>>> Also please use upper case for acronym mba->MBA.
>>>>>
>>>>> Ack (the local custom in the MPAM code is to use "mba", but arguably,
>>>>> the meaning is not quite the same -- I'll change it.)
>>>>
>>>> I am curious what the motivation is for the custom? Knowing this will help
>>>> me to keep things consistent when the two worlds meet.
>>>
>>> I think this has just evolved over time.  On the x86 side, MBA is a
>>> specific architectural feature, but on the MPAM side the architecture
>>> doesn't really have a name for the same thing.  Memory bandwidth is a
>>> concept, but a few different types of control are defined for it, with
>>> different names.
>>>
>>> So, for the MPAM driver "mba" is more of a software concept than
>>> something in a published spec: it's the glue that attaches to "MB"
>>> resource as seen through resctrl.
>>>
>>> (This isn't official though; it's just the mental model that I have
>>> formed.)
>>
>> I see. Thank you for the details. My mental model is simpler: write acronyms
>> in upper case.
> 
> Generally, I agree, although I'm not sure whether that acronym belongs
> in the MPAM-specific code.
> 
> For this patch, though, that's irrelevant.  I've changed it to "MBA"
> as requested.
> 

Thank you.

...

>>>> Considering the two statements:
>>>> - "The available steps are no larger than this value."
>>>> - "this value ... is not smaller than the apparent size of any individual rounding step"
>>>>
>>>> The "not larger" and "not smaller" sounds like all these words just end up saying that
>>>> this is the step size?
>>>
>>> They are intended to be the same statement: A <= B versus
>>> B >= A respectively.
>>
>> This is what I understood from the words ... and that made me think that it
>> can be simplified to A = B ... but no need to digress ... onto the alternatives below ...
> 
> Right...
> 
> [...]
> 
>>> Instead, maybe we can just say something like:
>>>
>>>  | The available steps are spaced at roughly equal intervals between the
>>>  | value reported by info/MB/min_bandwidth and 100%, inclusive.  Reading
>>>  | info/MB/bandwidth_gran gives the worst-case precision of these
>>>  | interval steps, in per cent.
>>>
>>> What do you think?
>>
>> I find "worst-case precision" a bit confusing, consider for example, what
>> would "best-case precision" be? What do you think of "info/MB/bandwidth_gran gives
>> the upper limit of these interval steps"? I believe this matches what you
>> mentioned a couple of messages ago: "The available steps are no larger than this
>> value."
> 
> Yes, that works.  "Worst case" implies a value judgement that smaller
> steps are "better" then large steps, since the goal is control.
> 
> But your wording, to the effect that this is the largest (apparent)
> step size, conveys all the needed information.

Thank you for considering it. My preference is for stating things succinctly
and not leave too much for interpretation.

> 
>> (and "per cent" -> "percent")
> 
> ( Note: https://en.wiktionary.org/wiki/per_cent )

Yes, in particular I note the "chiefly Commonwealth". I respect the differences
in the English language and was easily convinced in earlier MPAM work to
accept different spelling. I now regret doing so because after merge we now have a
supposedly coherent resctrl codebase with inconsistent spelling that is unpleasant
to encounter when reading the code and also complicates new work.

> (Though either is acceptable, the fused word has a more informal feel
> to it for me.  Happy to change it -- though your rewording below gets
> rid of it anyway.  (This word doesn't appear in resctrl.rst --
> evertying is "percentage" etc.)
> 
>>
>>> If that's adequate, then the wording under the definition of
>>> "bandwidth_gran" could be aligned with this.
>>
>> I think putting together a couple of your proposals and statements while making the
>> text more accurate may work:
>>
>> 	 "bandwidth_gran":
>> 		The approximate granularity in which the memory bandwidth
>>  		percentage is allocated. The allocated bandwidth percentage
>> 		is rounded up to the next control step available on the
>> 		hardware. The available hardware steps are no larger than
>> 		this value.
> 
> That's better, thanks.  I'm happy to pick this up and reword the text
> in both places along these lines.

Thank you very much. Please do feel free to rework.

> 
>> I assume "available" is needed because, even though the steps are not larger
>> than "bandwidth_gran", the steps may not be consistent across the "min_bandwidth"
>> to 100% range?
> 
> Yes -- or, rather, the steps _look_ inconsistent because they are
> rounded to exact percentages by the interface.
> 
> I don't think we expect the actual steps in the hardware to be
> irregular.
> 
Thank you for clarifying.

Reinette



