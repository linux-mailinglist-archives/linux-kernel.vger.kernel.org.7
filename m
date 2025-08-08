Return-Path: <linux-kernel+bounces-760669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FCCB1EE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470CE1894D80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22626560A;
	Fri,  8 Aug 2025 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3LP65Fy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAACE1E5205
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679166; cv=fail; b=FL47C18kk/P3/JC8PmVB9UnyuFGfXfXkF6fqXH7IyvyrtRvLBp3npUcU+GFctSwxpvcpvA1RcMR2p+nCp+yQ3SvB9D6vH+XkUQZ9CQo96O8iuDBXgTzEr6RYPrDFF+JaqGmv5GEHOFzcaEsmLrCgrqj142ReebkgDl1WuHbPUBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679166; c=relaxed/simple;
	bh=wGudk6Ud1oP4nIPzBguu8siOppy0JPmKuII0DnZ+xBc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IXXG6aPq+vGEmoBE2HZ8QIG49knsjpnkabnsAk6zmptOecy0VY8xJ4yFODSYrgoeBJmNKkmpVGodi4J/Pfbh2vw4SbRAawmesNUwwpEctxiA+XGqGmUcbE3WREbCEHiwFGYfXRLS6Ad+oAGtcu6rIc9vc3kWMKYUeckvZaLlcIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3LP65Fy; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754679164; x=1786215164;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wGudk6Ud1oP4nIPzBguu8siOppy0JPmKuII0DnZ+xBc=;
  b=i3LP65Fy4oo3lwi20IoE3/K4ToVxWLEvsDi/7+1MF8mL2AVtlwDLx6Iz
   BPXLicwH6OVGBgqY9qcIeE1d5Z5MwBmmXj1l3jpZa9z+Kjty5SMsM6qIR
   esX7z0QaqEr3U7SAkxeZgiLqZIn8s4jlYZS5U8kVWlpkq8RIPRaLvTC71
   mzzowD0Iriblagp+QIBQHFSBtp5A7jzhpBs4JO7OXahI9fxEu3F5vS5To
   GJNoMBvF59U9QTM3vRQ3M7mPM+ocnbtSRVv+xPXstep2yyxlB5lwb1vY5
   iF0mDwF9uXvOm05Mr+ZtzXJ8vNs5CUTSHlCpMlX4kqpNdCl++Ww3rjPH8
   A==;
X-CSE-ConnectionGUID: JDoDOVy4TDeI1U6V3notww==
X-CSE-MsgGUID: oNfCdSbwSFalSjpRMQh3iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57111266"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57111266"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 11:52:44 -0700
X-CSE-ConnectionGUID: p1Fx2wlHTLWTeyXX9/i4YA==
X-CSE-MsgGUID: tb0CcG7cTxCefCyfzTe1oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="196213382"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 11:52:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 11:52:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 11:52:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.76)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 Aug 2025 11:52:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n85FmmBD+SwvXCpj+zW7khrrx/PkaNzjvhx80KxDQefscDPh10do7896PpKEHnO/9Izx9851dJzmI9sgF5iwCQt7xk4Y6Z0kEUMDeG2VqrWYYmxwqPsY5C4OLxkHH8/o8FzLF1Bqcrx0hvTwNLPDnKVfTH4zstSMXbManmasl8REBuivN0LKpAFNQg7S0kRTPqsp+6upUYyGBLLzVnUeHwjq0w2vZPKv2xImZXrNQGrVAdd6GlnyozyYdoWIWLRPxkT1dWS8WE8rke43cIg30VCoGGFHqkbwjDEL5aG6ecWIUx9aGf5x8iDIrkw0vME5NfwrNE6IVL3hFWwv3YFDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqlLwLDfL79GV5lKQChPtciyp9frGytBpD3HWilIx2M=;
 b=sn/P05X4+CO3hhQ/2TsfZ2oBaYtZTIyhrrKxoGBTMLKNbeOX/D+3H09UxVa5XE686OxEqNyhVDBpOKKgiUu3z8RxPOBzvjcGblzFVlnOXXdnBdBLH4KHF4bHxBdO1lYO+DxB8aESaCJRRBA7JF6OA/ohn/6GFadQGYDEXLlC3jI7Stt/dzXkCqPdUPHSnDloq7sqk4REqkhnnUdGmhp2kakJPxKGZwWYsjaQyyihtudQ1yx014x7n0M9oyAc5HG0B/sLj3XerunTemoeo31dytCWIwYwBzpaCb4HtrCd1hNJBoWn/ungaUBzimeTyVZTdvpi6e3ZB+Vc4a3c/ePtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CO1PR11MB4818.namprd11.prod.outlook.com (2603:10b6:303:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 18:52:40 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 18:52:40 +0000
Message-ID: <39edf291-d842-4ae1-b988-76dc3688673b@intel.com>
Date: Fri, 8 Aug 2025 11:52:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/fpu: Update the debug flow for x86_task_fpu()
To: Oleg Nesterov <oleg@redhat.com>
CC: "Lai, Yi" <yi1.lai@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@intel.com>, Sean Christopherson <seanjc@google.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Vignesh Balasubramanian <vigbalas@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, "Chang S . Bae"
	<chang.seok.bae@intel.com>, Brian Gerst <brgerst@gmail.com>, Eric Biggers
	<ebiggers@google.com>, Kees Cook <kees@kernel.org>, Chao Gao
	<chao.gao@intel.com>, Fushuai Wang <wangfushuai@baidu.com>,
	<linux-kernel@vger.kernel.org>, <yi1.lai@intel.com>
References: <20250724013422.307954-1-sohil.mehta@intel.com>
 <20250724013422.307954-2-sohil.mehta@intel.com>
 <aJVuZZgYjEMxiUYq@ly-workstation> <20250808074948.GA29612@redhat.com>
 <e46bab92-ee1f-478f-8076-d46bd3fe9411@intel.com>
 <20250808151131.GD21685@redhat.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250808151131.GD21685@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:332::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CO1PR11MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c43744-23f1-4627-4f1e-08ddd6acc02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWxJd1UyclpFQUM1aHRld3NFOUpBSWk1eExNODRZMTdGcVE1T3JLVC8ycVV4?=
 =?utf-8?B?UU9MVjFUOTR2NSs3OHRFcjRLQWs0ZkJzRGRKV2c4YzByeWVxOWx3OUxMeEYw?=
 =?utf-8?B?L0VwZDZ0NE1ySE1mS3dHcFl6TEM3WlFHVFRPeXNLdWQ0UFVWMFJKU0JWTkdy?=
 =?utf-8?B?S3V2N00yM2xWdWhNbkhjdmZ1WjJ1TnI0VVc2SkZoay9KNnBNdXZ1THNTdzV4?=
 =?utf-8?B?QmF3OVROV1d6RXNJcHVXMmI1ampmSmJIRmVyY21oeUlBSlRKNkhvK2lQZ212?=
 =?utf-8?B?d0hVR0R0NmVWdnJHNVVyM3QyemNJVkJWdW1xM3VMRmQ2OTJ1MVB0Nmt5UDh0?=
 =?utf-8?B?b3JkaXdKUi9CbVRDdkQ0aUg5NUpSeW9RRzZyMmFJSFllamdRaFluQXJjNUlH?=
 =?utf-8?B?RVd5UlJybTN5YUl3UmdwbW5wNDVUWGNTQ0JqNHhQV2RxM3gxOFM0Y0FQLzFh?=
 =?utf-8?B?a1JqM3BPY29xSXNtdW4xODNDWWl5T3dMdFlTZUtrdDZVM3JOa1IwNnZMM2Jm?=
 =?utf-8?B?UTRwMzdNVkhEVXVLbTF1T2F4RVJkZkpRSXdkSWQ2SEdleGRZZTR5YWdhQ1Bz?=
 =?utf-8?B?NUlKVEplN1ZlQjMzVDBNMUxaSXdmdDhoaVlnaGFremhwdi9rbE5rdlo2aVdQ?=
 =?utf-8?B?TDVsVkJGcC9jRXJ4d0VCaElqL0xndkVWdlZtWkwrRHRFZisrL0o3WWNnWjA1?=
 =?utf-8?B?ZUVsazBXOW5aOCtaa0ttSU52N2tjY1VMRUppdzF5ZXBwbEVYRCsvME12b21V?=
 =?utf-8?B?aFlBWnJhTnplTjYxOEh5aTlwQWVSMS9Fa1VzbXpDR2MxNWJhVmdzOXczQTMv?=
 =?utf-8?B?OVFwQkdQSkh3bkd2bFFJclZ6bURGMlhCRlM5UkNCalBUSnVISmFkWmJZdkhT?=
 =?utf-8?B?STVRR0ZqdTdhamt0UklZNVZlMTQ2clpjdWdONFVkWHNYaGlnbDlqb1FVak9F?=
 =?utf-8?B?V2RHazhYQ1lDY0NoRnZIUFRsd1pSYzdKYnRQUzZ6WDZ4VzZnQnIzVGZRcGM3?=
 =?utf-8?B?SmNiTXFTRXRXaFpFYklhZGU3TUxBVFZRY1dUK0JRRzhlcVJxL2lscmdiUVp5?=
 =?utf-8?B?MEpSQTVXczA1NExSZXRZZ1poWXBESDJWbndYRWR0ZE9UWTdHSzljK0xMK015?=
 =?utf-8?B?c0VtL0hKcVUyTGI3WEFRVlV5N0g2Umd6bVQyeHBxV3doajUyZXB6clBBam1G?=
 =?utf-8?B?ejZhYnY0Y25OaHhwd21ZZHh5Tm5mdnpzWWluYTR1VWF3VkhGUnh5dHo0ckJk?=
 =?utf-8?B?MG5pUmxScjRjL0F3OEt0UTVXREtCUjBNc2ljWlVhZUdZWWduY0ZYMEVmWUZq?=
 =?utf-8?B?cVYzTWVxSmdUVHZVVWE2T2RLUWVQQk1YU2J2Y2ZPanU0VVRUWHZDUjhKZzNU?=
 =?utf-8?B?Z2dDSTU4QlN5V2R0YVdHMExSRzBHT1gvbW04UkltZE5KK2M3bVF6QUlINy9z?=
 =?utf-8?B?MXhQUlNadWgvdnlwNHNoeTJhUHh4eG1jcWZHR1FEVHpkRjdlQ1R4M3NKVWNr?=
 =?utf-8?B?M0t5VzA0QW0zd2VlMnQ4TzhvN0lGSkpkTDZTZG5uMFQ4OUtOT3RuditnY2lD?=
 =?utf-8?B?Y2dYTG02UUN2UTVxR2lnMlpTTzRwcEhLaGo1SC9lOG54eXJ6ZGFkeEMzM2w2?=
 =?utf-8?B?alJiN3l2WEIzMEhEWUFSUkhoL1hIeG44cmFNZTE0NFphWjlXSXZtZTFYTWVE?=
 =?utf-8?B?UXQzSUVJRzB3SHNXeUhpNXB2MHNId2VPVnVrNjJoTjYzT0Q1dE9FRkUxZzND?=
 =?utf-8?B?alBJUlBHNzhodGV3VVQrSlluWE1hNTczQ2lhK3BVMTRsc1drTW9LTmw1cHBz?=
 =?utf-8?B?bk5TR2UzNGw4MHcxdHBvMEI5TURpRWtzU0g3alpiK2s5WEduN3RXU216OHF3?=
 =?utf-8?B?aGhYL0M0NTJ4dm5WODdJUzN6c2dra05tU2k3WFJyTDY0dnBMeWk3aXJYUFFh?=
 =?utf-8?Q?rE31Z5u+igg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0thTzNLOEZiYWNvcTgyUkI1WWtMSmhpeFRPZFhxVWtZRGRtYStQamdqM2RE?=
 =?utf-8?B?K2orY0FQVlptVjBXdDFHQklsSjBFVTAwSElnRG1VSFF2Nm9Xem1xMmRDZGdM?=
 =?utf-8?B?ZlNHUkpEeVluMkZuZDErQ3pIWTJ4bDhDSS96QjYwT0VUdm5mNG42M0s0TEdo?=
 =?utf-8?B?OVpDUU5LSVZjR2pzTXJtbi9NUFpIT0hJMlZPK2E4eEgyVVZFdm5UMjFLUlhk?=
 =?utf-8?B?UXhRU1VJbmRidHlzeHQ3T0FNaEo4RW1xZ09QbzFzTkxLNTdacVVCdFRrc1hX?=
 =?utf-8?B?OHZMWEJsMnJ5TXNjZUlMeFJqMFdGaEJSeWRHeUI2ZnpBbkZwdzFjRnNGN1E0?=
 =?utf-8?B?ME1PYkhYU3NoWUgwQnZUbUdTMTd4d0diOVhqTCtENHZzR2RwTjVzZlRhVTh3?=
 =?utf-8?B?RnFGTWZzelN1SWJqRzFRZ2ppWjhHRktidTJ1UXNJdTYvWlgzeGRIYTNIYW9M?=
 =?utf-8?B?aDFlWkQ0U2F0enRtTmhqTFJkb1NYWGtSY0lmMCt0cVJHM01vOTFib25MVURv?=
 =?utf-8?B?ZTJJZjZhZEliemwyOTZSQys3UVVFMWVQQ2dEUzBqM05qakY0RkNCd1psdWdM?=
 =?utf-8?B?NElKQnlwaTVJVlNsYW92eUNjeERoMGZQWmp2M25YalY5T1gyS0pLUVd3MWc0?=
 =?utf-8?B?Q0R1Yk1pVml4VzAvcUh3Zko1SU54TWZFRnVYVkpaa2xhN2xlVWhlWWFncTN1?=
 =?utf-8?B?bEJxS2d2d2JXT3NsNVUvOU90Z2dDSi9OcUVaRHRvb1lQRGg4V2dYN1V1RGNE?=
 =?utf-8?B?VUdNZDNKdHpGTzZiYUZGa0RFa21iWUpKd1ZCN3FGeHhZNkpmNE1yNlM4SnVK?=
 =?utf-8?B?U1p3ck93RHFNeEJST1N3WVhEdWZodUQ3M24zOTFab2U0bHVjRG5Hd0dUUzFm?=
 =?utf-8?B?WGZtREE3eXE2VXIwcE9DdXl0MUoyaXg3aXdpVEFldk1tMmNnNk84WXhuV1la?=
 =?utf-8?B?QzNtaFc1WS84V3A5dnNwa2IzSk9QcUdrQmFKVHRLU3lqTHYzUkEvNS8vdmpZ?=
 =?utf-8?B?a001b1JUditXSlBzRXFIZXBRTGRESDhKTTJEWE96S29KdjlHcXZGMTJLb0lG?=
 =?utf-8?B?Znh4Nk1JdFdnNC96UVRodGxRc1RvK21rVmx6Q3Bvcms1UTBmb256R0p4MURa?=
 =?utf-8?B?UUJJQklISFVZVXJNcUZzaFU5ZDJwNXVwbDFVSjhSejB6MWFsMTdBTFJvb3ZZ?=
 =?utf-8?B?dkdPVUF0YW0zMThnVmg3S05kblgxcUxVV21kY25RZU1sM2dHbThlZXh3Nmo1?=
 =?utf-8?B?NjU2OFlqTC9TUzFLbXczL0xDakJsaW1IeXJORUoybk82S2YyNktYYXJMd3NT?=
 =?utf-8?B?QTJoNFhoTG1oK296WDdtNGdSMzNKbnhUUDF4UFRveUFqRWpuMFpSUjlkRDYz?=
 =?utf-8?B?NTZJbVVKRTVFMG5STFVoZ3ZjUWRtZmNISEdaQ0RHMUNoOVdaRXdyQ1Y5TUdi?=
 =?utf-8?B?M3VuMWpVVzZTOENjcGI3TXluK1VNS0ZFTWdsNDMwY0xHN25PZW1VQVlwUVd0?=
 =?utf-8?B?ZU9JUGsxWVJod01YRVpIN2dIV01Sa0E1c2p5N0g5b3grUHBQdWEzQSs0MlZy?=
 =?utf-8?B?dUUwSFgzN0hlVjJQMnJPa0M0RGVpWGkwai8yeHBxMTZHODBqQ2hOSDZiVjI3?=
 =?utf-8?B?Q1NGdFIwM1U4ZXpFMW14bjhONEx2eVpiNjZjelBicHROQWRXYmhaOXU1VEVQ?=
 =?utf-8?B?L1BiRjVYU0YraFU5WFFXVXdDQTJHaXY1K2F5V3RLd2dTQ3d4S044VEFoL0d6?=
 =?utf-8?B?OWhFVTdHdHNvd1hxRk5RY0VzWEM5RVlNd1pmUm1EcmpVcFJNdks0cFE4MSsw?=
 =?utf-8?B?WnI4Mm9WOEtSeTNHQnJ0MTdYSXF2ak1wMkVrOTNqT2NYMy8wSmJTcGFacFUv?=
 =?utf-8?B?RjlUMFNRelpHb2lTbWFCOFJKTUxZUDgvSkZPOGNLT2loMVFPNzRDZnR4ZnFE?=
 =?utf-8?B?VjNkNUd5czNoZnF6UHlvV05uejVtdG9vRW43TE1XUCt5Qnh6YlZ6S3NFbW9y?=
 =?utf-8?B?c1FGVFo5NUM2ZEZOZ3BxbEdoRk9Sb29xbFRucmFjRVFPdmNkQWFvWWxZd29G?=
 =?utf-8?B?RTNScGRYSVVTVXE5NU9YODBDUjJkUGNYSENEYXE5Q0U0czRVNGZZdlcwejJU?=
 =?utf-8?Q?JNtNBG/PSgmLZ95pQfy1yNdPZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c43744-23f1-4627-4f1e-08ddd6acc02c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 18:52:40.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRdTV8ehmd+PO0HrQjfD90MgYQPcABkbgYBdqeLP2bDiHMufMwVfNxrpGGoNsA+w5YB5qcQKEmK9vnvpuikXuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
X-OriginatorOrg: intel.com

On 8/8/2025 8:11 AM, Oleg Nesterov wrote:
>> The warning here is mostly benign, right?
>>
>> x86_task_fpu(target) and x86_task_fpu(current) wouldn't match, causing
>> sync_fpstate() to return early.
> 
> Sorry, I am not sure I understand...
> 

I was mainly trying to confirm that the check in sync_fpstate():

	if (fpu == x86_task_fpu(current))
		fpu_sync_fpstate(fpu);

would always fail in the scenario reported by Yi Lai.

> I only meant that the PF_USER_WORKER check in x86_task_fpu() is not
> correct right now.
> 

Yes, agreed.

>> However, independent of this warning, can xfpregs_get()->sync_fpstate()
>> be called in the context of the PF_USER_WORKER thread?
> 
> Probably not but I need to recheck.

IIUC, if a PF_USER_WORKER thread encounters a fault, coredump could get
triggered in its context. That could cause the above check in
sync_fpstate() to pass. Maybe I am missing something?

> 
>> Yeah, I am wondering whether treating PF_USER_WORKER threads as
>> equivalent to PF_KTHREAD is truly accurate in the FPU.
> 
> I think it is more or less equivalent but needs some work. In fact
> I was thinking about it a long ago, see
> https://lore.kernel.org/all/20240606120038.GB22450@redhat.com/
> 
> I'll try to do something next week.

Sure! If it helps, you can add this patch to the end of your series. I
am not planning to pursue it any further.

Only patch 1 in this series is needed to fix the reported arch_status issue.

