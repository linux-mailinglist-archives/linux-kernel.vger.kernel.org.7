Return-Path: <linux-kernel+bounces-847438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D78ABBCAD53
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 811E34EB9F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57282737FC;
	Thu,  9 Oct 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDedg9bY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F06241690
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042928; cv=fail; b=ER0Y29JsJzOzh5EyLhkKSFi+8M3BmjiVbi/3LkQM0H2oQQXz2tmQ8qXSpL/vOag2IpzHnFc3Gk16DIpbkhUP20GRECg8S6N2d/vN+vw8QWrdgo9Kire6OKOYRxW/cKvgJTr7ccV+b4d+ejoIxZ7QU0XDzg/4FKUJwF9DFHXNHt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042928; c=relaxed/simple;
	bh=dMs+UQfFv7Lwbrw0gsB3xFB1LOCeg/bDH8XwHo1jE10=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mkUl/7ldFw51HohVZqSt5BEUBHFvKV+1yZkORnhBeNiABu6VV+ZPU9Cd1TJnYJ2RLPP/7J3xRwg/GbDzFTunBKziz/40UCQBveceqMo95+W/TBO69UqiccI7OhzKwK3PZbOCCkU2wZ+fKus2+4qC7MZ3K+CsKq3MRODTsjMVopo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDedg9bY; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760042927; x=1791578927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dMs+UQfFv7Lwbrw0gsB3xFB1LOCeg/bDH8XwHo1jE10=;
  b=kDedg9bYiuFI8oB85kGCnovvTvnjsT7xwafRPgnGDkHL+KQiPZv+v23y
   Kb0pekyk8U3H7QSx+0wbmG6LytsXgz0ZrMjnXDUwO2tj9X++rrJsbH49q
   tQHT3k7YrbfIqivZrRWDMeYr/v/PkfiH/+Zt0t/7D4IgGqGt6p3Or9pJy
   SrGsXgEsSQDzymJStFX5hF1gYyvIbZcBFhP4Jb039KjeYtIR3E1+22XOQ
   LGFVmBz34es2xpSXd7N/nRUv7ijskyKOtiG0P1olOifeyaK49VXtcz/TB
   mu0gKkMRZLK2YkKoTQKGIRW1dzHhShmrwDeRgSXGpmtcxvqGkUhZDl44s
   w==;
X-CSE-ConnectionGUID: 1qUkFvLBTFmgq4dYmyiMqQ==
X-CSE-MsgGUID: OatSz2OGSrmXPwn1ehBZkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66094717"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66094717"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 13:48:46 -0700
X-CSE-ConnectionGUID: daM+90azT+etvqtQfjIuig==
X-CSE-MsgGUID: TdLbvHT5RLOyRwA9YMj7cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="181582012"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 13:48:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 13:48:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 13:48:44 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 13:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=was/DGmcTQL5WWesVJ5rGpJcKeFh+ENQFizvbZQt/TvczaklriZx9YFKm0NmEyvRjKDlia6gorihelbcpZDM3taVpXnnGAYxHv8IH4ETw2YmkDClXXBBN6TVIGiauPREEL0sbHR4pst5dD5mulDXxnOBJDLckEX/4SqIgqLLAFCBerIHJx5vHnyxFUEbjp0FxHp4O3TCMkW2RDiOLLXG3f9N1G5Mry5hZem9YybNW85rSIIWY17IFPBr+N8cM0lVEMadhtKzU4E9ECk5Er8jszSBVUSxZ5ayYy01ZLOc6pw6oO3tdz/L2QIK+7/FX6Tco26wW2izO1hBUewh2Ry+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLiTT2hez1Hot2mrC4+V3GFbO+m0dnrCIVvA8ksgv/I=;
 b=AOsR9FPHlRAGLLLwMFYUfLWX2pYb+V+OqIIoCxsYK2tq2ENfAKDwoPt0rNA/2ynbEdGxG50u+tKXwSpMqkxpqIXyM2mMOWbV+Iojls6Qe7SA1qd7n1W1Dhif2U9tGejX8kMO94kiUi1TRq+Ae1foTmFDshsszNCFD35FO34xYYak20fMfpr23cILszLyt0dSEZGEF+o8a8acCbpQmp4v43Xfju6DHhn56BfVR2UVLXRbfqdcc1tUcuRdCIP1FNTMP9QwAg2abHCDpDlvzMXGZGqa3+LNw4WKzb/oH1lJU2q3DAdltYx1KW86vdo4s4Flt7zh0ATzTJHXw4vmOJ4KnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 20:48:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 20:48:41 +0000
Message-ID: <a303c08d-f05d-41e5-932d-20bc96a17efd@intel.com>
Date: Thu, 9 Oct 2025 13:48:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Fix buggy overflow when reactivating
 previously Unavailable RMID
To: "Luck, Tony" <tony.luck@intel.com>, Babu Moger <bmoger@amd.com>, "Babu
 Moger" <babu.moger@amd.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peternewman@google.com" <peternewman@google.com>, "Eranian, Stephane"
	<eranian@google.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
References: <2ead4ece804b0f61aab01f47385d9a125714991e.1759952394.git.babu.moger@amd.com>
 <78dcda7c-b3f2-4149-b6f8-3da695d83bdb@intel.com>
 <091e40de-716c-47e5-85eb-ee09a7d6ae50@amd.com>
 <SJ1PR11MB6083BBB7FE524ADBE01C5DB6FCEEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB6083BBB7FE524ADBE01C5DB6FCEEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:303:86::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 78580aa8-0870-4592-8678-08de07753ab5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEhqYVY5RU5jQkZ3UHlaa0hwLzFaeVZtSWpnaDFsdXE3MFNDQ215UUlFckFL?=
 =?utf-8?B?bFFELzBQZEU0Ky9sN3VQdVBDcW50bVNUb3ZoNHFUYTNnUWFWK0d1UGhvOElj?=
 =?utf-8?B?NXJlMUtEemlDRmt2N1N2SVh0U2VPZXk4MDJ0WllNWEJEeW1xQURmbytCRllE?=
 =?utf-8?B?NWZOeGZKeTR2dlEzbnNHYVFpNHV2c0VRMmtmOWg1WHJPMHVYWU5wWldJYjBB?=
 =?utf-8?B?eFNaNm1Ub0xWUzYvRDJ6YlpCYlFvb3ZCQ1JIMkwyQlcvRGZGWEErSVpCeFdr?=
 =?utf-8?B?MGhOMHdMeTQzWENkN1RDM0llRnFtOG9aQ2ovdTFkT2ZCdmpLWXB2cUU5clB0?=
 =?utf-8?B?cVAvYzUxR1JiV2UzNzNLVTN1S3dvM2dXWS9pOE1DbG1PMUdWQkxlNGVuVWlk?=
 =?utf-8?B?WDhaeEJCVVZBQUZEV3g3c09QUzlzYzRjanJEUThqUmdnTkdlWXZrTWs3cGJl?=
 =?utf-8?B?K0YwdTNmbEU4ODRhMXBnQktQQWpoOEUvOTJjbU1YU3RpZEp6TEI4T2QwQkxk?=
 =?utf-8?B?S2RKT2xXZmcxZDJ1bThidmI3OHJMWWN6a0dhMlkzNVBtWHR5NGFoK3l2d1Vp?=
 =?utf-8?B?cDRuckNucVp1YUlpSDJFSysvc01PamJrOFY4V1RPdXBpUExaNXg2SUtmYlVC?=
 =?utf-8?B?WVJidGdWdWM2cjlmdHFrSGdPZzZvVjgyS3JvNEE2UU9qeHNGMkU5bmRkYXV1?=
 =?utf-8?B?RVc2QXpGL1ZKcFlQMldqQ0JDNmRYblN5VHhnVG1JRFE5LzFDM1BWYm54UGZZ?=
 =?utf-8?B?MWdFbXkzSDNoUDhvbkhsTUYweS9xK2JUdnVGTTJKSG11M0pzeEk1RFF2dk14?=
 =?utf-8?B?WklHM2JsWW9LcnA4bEdDVldzRVYyMGp6Y044MTNWMkVxcU1KdFhmWURGZFJr?=
 =?utf-8?B?TXAxQjVySzVCM3d1aE9MZWVyQVRjbzRCcDhZbnpyVDBTdVUvdW9DRTAvbWRE?=
 =?utf-8?B?NEF4MTA1blJWZXdDd0xGdTYyU0VjOXVNQUdvTFQxa0VGRkdZSVh5eXlrcFNp?=
 =?utf-8?B?MlREbTk0bHloakY1WU1VQjAxNnFxcHNwZWZ5L1EvbFZ4OW5tOVNvM3lWUCt5?=
 =?utf-8?B?Rk9WY2JMcyswdTB6ZGRUUEJmRDJ4OG1PRjNPUnJhNi8ydi9hbVk1WURNK09h?=
 =?utf-8?B?b2Z6YWtCNkNXTnR4eFRyS2EyS0dIYzFxL29VeUJWeVphM0c0akhFTDZ1cE0x?=
 =?utf-8?B?cEpKOU4yK3VLcEM3bHdzWEpMcnFoLzFJVDBnVGZqcmpPelNGaE8rcHVBVGtz?=
 =?utf-8?B?UmhJb0Qrb0NxbjNwK1NLRDgzWWFUVmRQakRlY2haVDVKc2Nva0JnZkwvNWxq?=
 =?utf-8?B?ZkVWTm9sVFFLd0NIRElnc1NWRlk4alJQK0kxZjV3cEFva2JvQlp5S2ZVQkN3?=
 =?utf-8?B?Z1ZnWDJGa3MxMFFOaU9RMklhdmlyNGo0bnh1UGpobVBidHZZdUl4QXBVMmR2?=
 =?utf-8?B?V25xd3o1MjZuY1liZWRmamZ0Ukt1RUFsb0x5UHJuamlMNjI0R0ZQT2lPWVdM?=
 =?utf-8?B?d29yTG1mdjVNMUQwSkpVSlNMUytCdVNxMlBxYkVQVExRcmFJamtDQXpLZlNy?=
 =?utf-8?B?RzNVb01tMElrV2ZLRU5KYmZicG5uSDZFUXVhU04rSUlmVWRZUU9XNEZEbEhh?=
 =?utf-8?B?amlZMXVyOGxmUnVPS21wenh1RXVRaDRtSXdzdzF2RExBaldBa3dlOVdlNGhx?=
 =?utf-8?B?Y1ZVbjdWZzJrSUJsRm93ZmN4SkNnSjYwTTkvNlNVUW1BSGtSQVZzN3E1aDQv?=
 =?utf-8?B?WHNNM3ZXUUlsckRzdEZlS0xQZ05ZU2E1WU5pWVVVcFdXUHE2WjI2Ry9rQzY1?=
 =?utf-8?B?UlRzRGwxVzBJZDhVUmJhSUJXQmQzOW5uSXZNUUpHWVA2ajljUkhUT1l1ZkZY?=
 =?utf-8?B?Wk1DRXFQai9LZmszNlk5Z2FTRXdobjRrZkhQbGZoRWY0NVpJTFlCbEprVjhD?=
 =?utf-8?B?bUJIQUNFT0hnN3RDcUtmbDJtTzR1RGFCbnhHbUVhYzRielBJSVVvLzJsZU9F?=
 =?utf-8?Q?D6QpbuIL+mkmCwqDMj3JN0PqwX61r0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHFqOXNuY0prN3Z5RWxBbE1jRXJERUpuKzZMYlpldGhzSnlFVlNqWFBCSlJL?=
 =?utf-8?B?N1crYzdMRms5UjVjVEdwY3ZMVG9yRjFnSGkxZ2J0MDB3Z0ZPTTRlUUFLMTJ4?=
 =?utf-8?B?TmxNN0tJdXRkRTZNVEw1NElNNE1TTUwzdS9vRWhiOUZ5dVRyU2ZaQ3MxQnZi?=
 =?utf-8?B?QlhZanlCa1FQYlNmU3ErRzd3R2JuUUFISHNRLzVGVEYzTXlkb1I4UTNjYUxr?=
 =?utf-8?B?cGJRZDd3Zm44NWFuSjVsb1o1OEJUOWFzZnlVandlL1p5Yk53bVhzYlBwZ2ht?=
 =?utf-8?B?aHA0L1dnKzZhNEdhZzlwYWFCR1pYY3gvOVVPRXNHT1p6WmthMFl5T3pQTUJy?=
 =?utf-8?B?bzNEN2l5TFBXUGxZQktLR2FJelNrUUxkZ0hCajRBSkhWazcya0lMTzhia3h3?=
 =?utf-8?B?b3haU3lHMSsvd21QWTlaSjRuM2V0Qk0wTllTU0krUWRKZnM5cWEvUnJPMjNa?=
 =?utf-8?B?cEhxdGlTZ0k2NmRwNE5kZU41ZXVhRlF4QnNYVXpycDk3NDcyRmVDOXUxdjh0?=
 =?utf-8?B?c2lmTG9WcWRQZ3dZdjNNbDg4MVlOTktydzcrbEdScGVseWl6TDJIaGtSRmFQ?=
 =?utf-8?B?UkU4V2Q5aEptYTZjUzFxbnowQllXM3lnV2JMSHZzQ3hLak4wYjh3UCtrb0lJ?=
 =?utf-8?B?ZUM1WlF3UjNuZkpUSmUyamV5VGlGdklMVkpNYmxDU2xzUW9pM1piaU5WMGhY?=
 =?utf-8?B?QUxDL0ZsYXJvL0lJVTJmVGRvQmYvUkMvMjNzbWcvTzNuWm14cFdZcjJKR1Az?=
 =?utf-8?B?MFNiU205dXdzWUtnM0U1TmFVdmpHNmFqVHJObmpyL3dNdlcvVEw3ZytWNGZF?=
 =?utf-8?B?eXNIeHg1aGplQTlxUmQrMkdzSHcvL1hEZnRXZXJhSWFLTnRMdUxUU1dSbitM?=
 =?utf-8?B?QUZHcFVYNmdFK3Q1aUxJWTBFMlU3L09lL0gwQTJlRkZhWDJBRjAxcUpTM1dL?=
 =?utf-8?B?eFRnYXFZM2tsQzZISUlpbjZMRG5hcnBQdVBGMndWUnlpWDdxWEM0ZG5EQmxq?=
 =?utf-8?B?SVNJUjdMMC9rT1BTOWhSaW1VSzBtZkxiY05FS0p6cS9sT1JlVWdOeDh6YWdz?=
 =?utf-8?B?dmUxdW90aEF2QlZMQ0FsQ3VteGZmdU1uYXhmU2lLejU5MU1XZVFSQzk1bTZH?=
 =?utf-8?B?bzN0cUVMV3dJaEpYWHA5MnUvTUlZU2MxMWZiVGcxSG0vSExCKzFHQkt6c3h2?=
 =?utf-8?B?R2NaR2dnSGhBWktUOUJwejBPb01KV2ZZVUZRMUNJamhndkk5cWJZUG12ZFhG?=
 =?utf-8?B?RHRuZVNqY1Jrb2FJd1dQaVRrR3FqY3RCZnBsOVBWRGZpazVTWW1waE8yMDBo?=
 =?utf-8?B?M243YldnUUc2T2xlSlFBVmFZQ2l3OEJtR2dCUmdJcFRsMWowams5dElEZ3VX?=
 =?utf-8?B?L0VyN2h2M1dQWjM0bTE1T002NDZyR081bDBrSkd5ZWxiN1NVemJTSlZxUnJZ?=
 =?utf-8?B?b0NScGtWdDllMXJQdEhDYlozTkRqWVBuNnNuTERjbkZKWG5kbkVnak1iWVZT?=
 =?utf-8?B?RHdvdEt0NkoxQ3BBTHlKNUZra1lhcjBWaUp1LzhqcW45TVZCRm03UnltNmJ2?=
 =?utf-8?B?YjJxa1RCWXdOeFJMNS92b0VUS2E3SmorY0ZlM0drNlVDNTR0cW50REw2VVEx?=
 =?utf-8?B?MGNoL0V4N21ZTWV1QVViRFJJellQZU1nU1o1Qk0za09nNHlPRnc5MUtzRFl0?=
 =?utf-8?B?MWdoUTZsUmRDQWQyakIrNis4dEl4c0RTL0x4TFFuN3pQYmlQK1Jyc0VQVS9n?=
 =?utf-8?B?RXA2OWMwcXI3bU8yT0tLNFoxaHJVaUN5UXEwNHNUVlBzTnhmNmcyc0tzYVlh?=
 =?utf-8?B?V3NVb2o0dTk1Unp0cXhleDluMFhMZnQ4c1A4TjQ3dkRxYWFhdnQzR1VpZ3pk?=
 =?utf-8?B?TjQrWGRzZ2tITFZoTXBuRGZFWVpLZlArSG1ucW5lV1dHaFBKZHVRVElHWmcw?=
 =?utf-8?B?Q0lEUVVGeEtDenNwRVc3YjNiNit3aEp4N3U5YjFtRGhwR0hDL0wrUTlMNkVG?=
 =?utf-8?B?TnR6NElqbDFOWWt0OW5UQzNQN1c0SVMrc2l5OE1aaW5WRlk3ZnNYbWJmNVVS?=
 =?utf-8?B?TklGcVpmOFAyUnIraXBFK3dPU3oybDZ5c2tybkVHT25NTm9SYkJLUjV6eXA0?=
 =?utf-8?B?OVM1RDI5NFJ0YmRjbW1CWU81TXJkUWVrQlhrNmhuNERsQURvSzZlTURteTR1?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78580aa8-0870-4592-8678-08de07753ab5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:48:41.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHrDsGVGF9iXHKFIRTo3EkdgdaipbMogT359Ajm189Mb1KgLCLBow91+lcZQdnB3xt1rlj1ATnNgbGRlk2x9Wa4qPHljgsVvBN7vM75U2KY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8424
X-OriginatorOrg: intel.com

Hi Tony,

On 10/9/25 11:39 AM, Luck, Tony wrote:
>> Here is what I do to check for non-ascii characters:
>> $ b4 am <message ID>
>> $ grep -P '[^\t\n\x20-\x7E]' <downloaded patch>
>>
>> Could you please try it out on this patch and fix the matches?
> 
> Does the non-ascii rule include the cover letter? Or just the patches
> that will be applied and included into the Linux GIT repository?
> 
> My AET patches are "clean", but the cover letter has some output
> from the tree(1) command. So the grep kicks out this:
> 
> ├── mon_PERF_PKG_00
> │   ├── activity
> │   └── core_energy
> └── mon_PERF_PKG_01
>     ├── activity
>     └── core_energy

I think this is fine. I do not know if there is an official rule about this but in
this case the problem is the subtle differences in the text when it, like in
this changelog, switches between ascii and non-ascii for the "same" character.
For example, like when this changelog switches the quotes between "Unavailable" and
“Unavailable”. This is unnecessary obfuscation.

Reinette

