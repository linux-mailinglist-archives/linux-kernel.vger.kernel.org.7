Return-Path: <linux-kernel+bounces-748306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11973B13F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47E17A4DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B5272817;
	Mon, 28 Jul 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbgANjC1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3739020E715;
	Mon, 28 Jul 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718279; cv=fail; b=AwDxfuoyVubN3CuEWuujPOCo4klQzw7sroCicPgxbBuLjMR419A3omrRVqXdpjeyKbWjfO+smKjLO1RwvwJtHREin2vS9ThGlKKbbujMYGOFuwq+uepJo9raAGOMvVc3aMmJe1yu8wF3eqJy2Qo0MXnsfnDRlWWxBWB8yyN/C/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718279; c=relaxed/simple;
	bh=xEDWITTQwOBMQdUMDj2Ocy1Ygzh6GGoz4lq/lMG5PjQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Z+P0AEaK86jFklb8P/eUIAzieDtjsXy52s+kknHcHAXdKaOQBaDqVbGRhgVTlk7Ejnvt0zbmqbzgr8kJdZdKDeQvI2+d3iniajlQtUGwaOtXblbX1nMqOvfheZXNU82GZQve94c7+bcJekESnxG8HyhcOGpMBNOB2A/jcm1aK+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbgANjC1; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753718278; x=1785254278;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=xEDWITTQwOBMQdUMDj2Ocy1Ygzh6GGoz4lq/lMG5PjQ=;
  b=UbgANjC1IsaTR4XUhXKwgJG7go2+W43+kbFxfuHQk5Sj6hClBr83svgP
   mnYZZMs45886c1Eazq6C42C+eATosyDd6R4yQ31+cVpEVaF0pPdQod4db
   PyauVBmsAtmiHUWTumc+9opOFfmiuf7+jTUl4bs+AJETt+wnWCgnvxstO
   Y2ENgnkDy991x4EHY7Rp3ZwjJpl0nDjUDcrCEgyuABEnzsY9UnKq01ju7
   zZ5ffMMpK7lj04wQlowiZPOXZvsj+CiEdNVfm147yDpxpUNZfsSg90nSp
   s1CY221+0mprN6VcMzXR5I1xqnp6izd4tRting9OkMlxymaZqIRVy5NCr
   A==;
X-CSE-ConnectionGUID: 2Mu16uB0SvOpEsmd7NBQHA==
X-CSE-MsgGUID: gpSYg25pT6e9lGDMdVV6Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="43583339"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="43583339"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 08:57:57 -0700
X-CSE-ConnectionGUID: f7KlC5vfTfWllA2woh8P5Q==
X-CSE-MsgGUID: DE3SdJQDQFahaCM5cKcgSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="193299980"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 08:57:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 08:57:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 08:57:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 08:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUBqD+98FODCI3Ac/fWfvHgFgQhk9GdIrwSjWyyBGWt+6OJHagGot8/EG0ZQe25Ehq9cp6sXzPOBKgVuOd6k9xLTRr+n1wAhJo3EBT1rgGOu5XDJaRoce+nwGMTXc+5Bh5TOkUHkNF+y+xDGBsyeiRqA6VvCnVLMUCYWYcYhLQWv+kVc8uriowCi6Xi3QB0Jx4IwlJEVQSi6fBcU9oEFL2Pv4BxyIbB0XeujZdO0RwcNxuYYVjxqnb254R7gymnHgQpD0fzhO9sXw3AXoSHByOCnMzm0nIFB8fIuHNQTNEjkZPOv2xzRZ8et22JGBKT7eB+n1FNZM0vePi4aRUXdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WMaZaLP/oC+yOQSzeLDLuvIKPXz4ybJhdauWKSJL9Q=;
 b=pScQaZxGW5w6TBmLBDTKTWXQDBg4RE6gODRQ6i0SSYFBpfNKQGyBk0b9zHB2eUIFFPFcxtuXTCiOxfcORQW9FXBwYV5Wl9XPlDfliGvuKOp3E1B1Q8jFTHFG0WwFApk3KNMyfzfO/ldsRNwnek+aCp8gOUbJgENMRxlNClR9qg9WMuuzNAbZAByoKokOEv5bmRNh968j0A2QJQKzeeUo4ipe2QZ8tQJgcLiEo6U8b/ghwyPz0n/1aJWl5NXCQjZnwhhIPultNv5gfaYrFw9P0pu5fYas//oujmdHDfR99RCuvP4YcThukyJQ3MH+HaJDhQNKbvvpkAtzBN6Feqn1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7152.namprd11.prod.outlook.com (2603:10b6:303:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Mon, 28 Jul
 2025 15:57:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 15:57:23 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 28 Jul 2025 08:57:21 -0700
To: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
	<workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <konstantin@linuxfoundation.org>,
	<corbet@lwn.net>, <josh@joshtriplett.org>
Message-ID: <68879de1aaf4_e74a1008c@dwillia2-mobl4.notmuch>
In-Reply-To: <202507251356.4396F1F@keescook>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725114114.3b13e7b1@kernel.org>
 <20250725150046.3adb556c@gandalf.local.home>
 <202507251356.4396F1F@keescook>
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:254::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6f43b8-cd8a-4976-f0a0-08ddcdef70a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUJpMmc3TzJnL3ZodDhmUmU3dVgyTlZQZ2JBa0d6UVR1V2JFQ2pWSjVtM3BK?=
 =?utf-8?B?VG9mMldzMmowWDFiTzY0RHU3Q0VlYTRDcTVxRnZnN2pyd2FrMkJGYWpMc1VD?=
 =?utf-8?B?anI4L29BelZNWkVRb0NuVDN5T29FTjR1cGcvazVKZmFlWHNkcUZyaUpNU1JB?=
 =?utf-8?B?bDdVMW5wdUt3UXhKUUVsdnVYMG9GMmp1dWRhUGFtcG1ZMzYwaXZwV2JoV2Qz?=
 =?utf-8?B?TGFJbkRkT2k0UXFXVnhtL0pzeG5aM0NIUENZcHowc1VXK0c4eGN3Sndwcm1L?=
 =?utf-8?B?TW1WeWRYR1l5Ykg2bldPdm5waHVTVUpZVWU2US93aENoS0w4RjZySldxbE1s?=
 =?utf-8?B?cFdTMnVJSjFETWp6WXFJZ0F4REN4WTF6V0tKRDNvNUJSTisrZWZHZFNjWUJY?=
 =?utf-8?B?dmRWQ3liL3lxam1tSkRFM3Fncmk5YTF2bTFURzkzZ1Z2N1l2Y3RDVDJlc0lX?=
 =?utf-8?B?ckhSLzR2TmtSWXlIWEpROVpUWVpMT3cyR0s3M3E5TlhnRFhEcWdaY25JV0ho?=
 =?utf-8?B?VHFZdUtyMWcxc2pCaGk1c2NyZ2FxbU82VVVmaHJpdHNQd2Jjb2REakJ5ZGdN?=
 =?utf-8?B?VDZOLzR6NWZwYWpqMDZicy9PT201TTZQZVVkSUpCbWhEY042Z3A2NWlGb2Rn?=
 =?utf-8?B?MGk2NzN1eHRmWG5kejFPRktLN1ByeXh6WnR6YmlDQyt6RUlNczUvTllxWmgr?=
 =?utf-8?B?RUFlYWhyM2NKUnNZUUVjSlFWYm93b2xybGdlL3JQUk5GNTY0aXlFQW5aMVEv?=
 =?utf-8?B?UC85b0oyZUNweU9NVGVPQVkrTHB6L2R4LzBERkhKWVZWQmxUNWtoaWVUcmhw?=
 =?utf-8?B?dnhPZm5vb0NKRkp3Rk1Ob0FNd1ZzV2VnajRwcVY4UzlVT09yOXlKa3g5OUZh?=
 =?utf-8?B?OXJwODl3TG1Mby9JRG5RQUF3ZjVQakJLc3VLYXRaRUZPalFvNmlhKzZCOTBQ?=
 =?utf-8?B?MWdVY3ZIWWhmdWVldWUxeFVPbHNWT0t1WDNucjdCYldJOFRSQjBQek5rMzJt?=
 =?utf-8?B?SGhGYmRFZHc5dmJXT2ZQcWxwdlJ1UmZrQjMrNkF6dE1wcCsvZnprRlhlOUw5?=
 =?utf-8?B?SHZlZHBHOWt0VWlhQXl1cUxJd1krUFBFbEc4WmtuajZiSG1CcFdLNUlUYnlC?=
 =?utf-8?B?bGhIWGJGS245cU1DWDhmNnFieTI3T3Jta2tFc0FQaGIrNkUvdjBFTjh6ejFh?=
 =?utf-8?B?Z0laSXErSzVPSzhpcGs3dDczQlgwSi93ZzBCRmlhT3pIMWVaZ3E0bFArc2Rp?=
 =?utf-8?B?Sk5iamRjS3ZldzRGSzVER3ZNc1dyaEVDekFIL3dxejg3OUdVclltR1VZMmRK?=
 =?utf-8?B?UDcxaDBhUnlBQnlYMFlTRkhVZkNmcGxVSDdncnNDMHJlQ0hRNExtYjB4MDBh?=
 =?utf-8?B?Z2s5cCtSK0ZLR2ZDMXpYMm5jbEN6K0FXR0NDN2kyeGROaGRiM0pkRU1hcW1U?=
 =?utf-8?B?dkYrTWxkRlB0b1BBMStqbXZpUUVhN0lMTVpPUkxsbGdNUElreUF5enI4ZFpT?=
 =?utf-8?B?TFNUNmd2WVFSakZMaW50OS9aaTFMcmFqaTlpY3hUWVFBQlgwVkt6ODF6bEFQ?=
 =?utf-8?B?djNyMzl0RHNrZU5UMlU4NU9hRU4rM09lejlDQXdRTXBzdENDM3BDVUdrOFJ2?=
 =?utf-8?B?NFNpU2FQNG1UV0JUdWZMZ0V4ZXJ6UnhSQWI1MzNXVEYxSHhyOHZJUEluT1dE?=
 =?utf-8?B?ZnI3MzhReHZwTzZ6K3I2aW1ic3NxdFExa0thYXR4SXAyN1BuZWhuUTZ5UWRy?=
 =?utf-8?B?bTFFai9qQWdzNzZLVFVmTEZnTTZPbWFvSXppRVRlNlBTdHZ0UVIzV2VnSk5N?=
 =?utf-8?B?djBIa3NJZGp4L0dIbERRRWIyWjZBY2habVhrTjkxWmlrUllpa2k5OWQ0VkZ2?=
 =?utf-8?B?SGFNaktQU2FnUGErdTkvUDcyb3BlMDM0ZW42a01WVC9pOGZRNElxOHRyaDhQ?=
 =?utf-8?Q?M9slipSHLzc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3pxNWw3dVRnY2N0YmZkaHVSTElmTTU5VDBRTjFjQXVIWnJwRkJnM003bUtK?=
 =?utf-8?B?QW41aTZsWnMwZ2xST0xEbHVYTEVCWXZRK3FOOFdwZ0N1VUFYZWxuanRERU43?=
 =?utf-8?B?dEhBWVZnWEExVnk3WGtDOVBtMERMOXhNU1lMQVB0MFpNZlRUNmtSNTUwWkJq?=
 =?utf-8?B?d1BIVFhuRFpWNnhheWJrWjg1cVlvbkdVUGI0V1plT0RaRzFVeWE3WXg3dFRF?=
 =?utf-8?B?aTJFUUh5ekhCUHRFSVhPM2tmYUN0TEVIL251QWJaVk5JYWczMnI2K1hVVW1U?=
 =?utf-8?B?UTRiNFUzT3Nta1c2SEx2UXRER2orQ2taWUhnVnVUZ2RySEx2S2J3dTZuejdN?=
 =?utf-8?B?a3N2T0lDL21SSmJ4R3A1Vmx0V05tMEVlN0QyUlZZVkVmaGw1a2Q4eWJQc281?=
 =?utf-8?B?WEt5Ujdtc3R4dldJOGEwalEyNE9QYjBseEQ5b2gyKzd5Q1IwNzNuOGJ6aW9m?=
 =?utf-8?B?emhWNkVoUzhnSFdtNGp6SDlWTW50aHdsMnF3blZiWXRiSWozUXgxNlhsbkps?=
 =?utf-8?B?eFg3N2NRN0E0OGI5WlRXZjVacjNXbUpNajFRNW9MdFQzZjNLZXNDWTZMY3ps?=
 =?utf-8?B?ZjBqcjIzdnp3V1dLRE5BRHJaTVdBbFV4dWl6K01tN1J0MkdFM1ROSlFDejJE?=
 =?utf-8?B?bndmcDM0MWRaM2tmVTZvYzF6NkJtd0dkVndUZFVhMXhNVVFwL1pFWHRWUVM2?=
 =?utf-8?B?VXhJalFNTW1uS0dvK1VLL2xRMlNBZlFaZFcxa2NvTFFFenZwODdHd29mdzBi?=
 =?utf-8?B?dTdxMk9hVS8vdm4xdjd4Z2NFa0ZSblM5MUZWN3RNQTB0cnRmYWx5bGF1YitD?=
 =?utf-8?B?bGJnM1lYeExhY1hQd054eDE0NHZxQTZGSU1wQjZpVmwwQlZUb25wTXkzcHBC?=
 =?utf-8?B?dTZ5Z2UwTmVTQUl4ZkdMc2FJaVE0clNidUlpVk1ZOG1BUUtZVEF2bDg3azhu?=
 =?utf-8?B?UzFzNXpSdW8vYkI2M2kxM1BlMXpTa0pnR0lkbTBBZFoyVlJ2dWE4aDJzRlZO?=
 =?utf-8?B?cGp4bkQyZndiUGorTWNERS90S3o0RXg5YVd3dFdiZ1BLcXh5MHg3UGQramMx?=
 =?utf-8?B?c3EvM3diWjI1N3czYjJtZ0J0K0hKSlY5NW9YQ0VPdDdDUUZiRjRsQyt2K2d4?=
 =?utf-8?B?cW9hNExycUV4RVY5WVFZUlN1bEhTM0VWRk5GWDFHMkx3K0JMMXFhSzFFZ1U1?=
 =?utf-8?B?ejYwZ1l4dUZoRVluL0h4c0RyaHkwN1cxUnVUbGJKQWx5ZVlvOUwrK0EzS1lQ?=
 =?utf-8?B?N04xbXVYSEYydVhWbnJmRmVGaW1nUXMrZkUydG5XRWVwazMzcWp3eDNONlBt?=
 =?utf-8?B?TmhzK2VCa3dUYUdNWG9vazZHZXpBTm5WTVFTTkthUCtYUTN2NUk4T1FWKzRo?=
 =?utf-8?B?eHdpZEZYTDVXQWpyeVQxNk5udzd4emZuZjFaaEZyaUlkN2hrK3k1K1BHYkRw?=
 =?utf-8?B?V0I4eXdOWWdRMXBnWEVCVFIvL2F2ZmlJTDh3TTlEVmdtOHJ1RHhMTnBieVJR?=
 =?utf-8?B?eURYcFJoZk5DMVd3cDBGQVpNMnNBMzFVZ2hsZzlDVVREMnEvMlorR1RoTzNE?=
 =?utf-8?B?Q09lSzA5VEFXY0o5Vzk5SVZXa3FnSEJ3QjFoVHhWcEE5a3ZqWmtLb2RTNFhU?=
 =?utf-8?B?SE9zKzRsVUJuWVJXNlJ3RGJnN0lFeU1LeWdyc1dUSzREVDROc3o4SXJDbFFN?=
 =?utf-8?B?TFRVZ0JiaDMvRXZlV3owUkZqNFpvSmVWbmhzbzh3V1hTdFhxeExDSEJZUGZj?=
 =?utf-8?B?Tld4SG5ZTlYvaStOcUk0U05pcU1hdk5OdUxvKzNjNFl0cDIwU3EvY041ZitE?=
 =?utf-8?B?VS92WkVOUG1pMFc4V0pCZnVoVEJOcHNDOGRuaWNrb1JSSVQwRVlxMzhteTgx?=
 =?utf-8?B?anpYdHRndnBDSS90UEk4VGJ0TzhMVGNzaTUzM0lPa0JyRGE4VlBHTWY5Ujcz?=
 =?utf-8?B?Q2VwbnVVd1NOZ0V5dzEyZXpkRUs1c2lGQ3JmdUNwZ2VoRGoycnQ2QllFNmNE?=
 =?utf-8?B?cGkrdm4zZUhNbGZMNzdvYlJybWdQLzVZM3Z4S1A3U2RIY1Y0ZjFOZUF1aWFW?=
 =?utf-8?B?M1R3L2R4MFBLWis4RzhScENNSzJpMnNaMUkva1hCSkNNbjU2SC94MGVvOWpO?=
 =?utf-8?B?ZEJ4QmhIckJpRzBNRWdCRUFvejlIeXlVMXNLLzRENWRLZ0VtVVZaQXNBOTE3?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6f43b8-cd8a-4976-f0a0-08ddcdef70a6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 15:57:22.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaDAPxBIujWX2P2LD6/WK2XismPd7fVQEV7TFywbPZkdJadAe2co0nSdF6/EAW0TWVGcXeOrxQ8xhvHQaj22EuKk5cNqO8gxBDh+d49z3cY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7152
X-OriginatorOrg: intel.com

Kees Cook wrote:
> On Fri, Jul 25, 2025 at 03:00:46PM -0400, Steven Rostedt wrote:
> > Also, I would argue that it would be useful in the change log as if there's
> > a bug in the generated code, you know who or *what* to blame. Especially if
> > there is a pattern to be found.
> 
> Yeah, this is where I feel like it's the most potentially useful. Since
> they are distinctly code-generators, we should include the info to
> identify it. We include version numbers and such the compilers and
> linkers, though they are only informally included in commit logs when
> dealing with specific problems.
> 
> Having had to do "find all commits from [set of authors]" research for
> security audits, I would be very unhappy if I had to do this again in
> the future for a specific Agent (used any author), and had to loop lore
> into the process. Yes, it's *doable*, but it'd be very annoying.

Oh, yes, that gives me pause. However, so too does the idea that AI
contributions, beyond mere mechanical code complete of trusted human
developers, would become more prevalent. *If* it gets to that point, I
agree that this forensic ability is necessary. Now, if it gets to that
point it also assumes that the "AI contribution review decimating human
reviewer bandwidth" problem has a mitigation.

So "doable, but very annoying" strikes me as a problem space where an AI
agent could help. It is not clear to me that a concise commit trailer
captures everything needed to help both the review and after the fact
forensics problem, especially when model fine tuning and prompting are
in play.

