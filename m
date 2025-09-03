Return-Path: <linux-kernel+bounces-797595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D1B41251
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3A45E7865
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A622172E;
	Wed,  3 Sep 2025 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3CLYjJx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A938E1F948;
	Wed,  3 Sep 2025 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866591; cv=fail; b=WhhAEWgq82xEcQtWump8xp0o25dQxB4baY8Ccdj2AFnPdxDewErt2quwF4CnxYWm9Ki34WwWb9t1aOoj9J6XoPNOC1ZNUZPiQjAuYTzGuTUPi6mg9thwh2OgWOjCfALnXRX/A2s/opmuvL14mz80S2OS6AY3G0HkQZqR97pwMyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866591; c=relaxed/simple;
	bh=1NDqk3X6qpHRAJiZT8pbcCv2WtAR0MzqjZ0PZv2LvKo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qLsvE+ORM2O46izfl9mx5v8QsBZIZHLNsXwFhPreQl8DgYUznNut2uTrfcLGqVHT3cOL43zzEMW/p5lmkRMeBx70O/Gw3ysVZXkAa6zO+Z+iOtoXSmRR+/wEwn6F3aL3vLrTFKfJS1wKy/0jAfDHQBLCuMNpm5LUdY8pMlnznGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3CLYjJx; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866590; x=1788402590;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1NDqk3X6qpHRAJiZT8pbcCv2WtAR0MzqjZ0PZv2LvKo=;
  b=S3CLYjJxWtYOw8zIrWV94jv/xucsnR7pVI5xZjnCf+5J7VMQYPt5SaGP
   A3NPEkF7HyBPjj564p1gxdvgSVSrLmdO6v46RUETz2uToC2dagaB1WUKp
   04LNwU3/4KmTonxul8GpizGq2HrOa9JzxdR9dzX5GYTLvh3zMG2VqZ+WH
   riTH+qtngvqy67FIRb9XfauulscxJUBFs7LV1Qxt/s7fcIQIstznCbmBN
   y0Lvxhi/6Ty4AxWPHrb/Y1SusYJaSe0qxqCu9N293QgHnz8gPsgv7dlfc
   yJH9zR89DvnosYgufaLsJqJnuxCDePI+f35WS1cIx+3hC2Am6G0Z2WtC2
   g==;
X-CSE-ConnectionGUID: +HSAVvrPTUiz1akIos4UBw==
X-CSE-MsgGUID: OYVf6024RHGYF6PIzwUMEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="62811753"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="62811753"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:29:50 -0700
X-CSE-ConnectionGUID: Fc5eEWMpRUSPbrqrXNRWgQ==
X-CSE-MsgGUID: bxg+oIBZTx2z5hIFWAIaDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="170735841"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:29:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:29:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:29:48 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:29:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRuuVdsXI8S8Ku4Lsk4YPRjOTbZjBmB0G5VYGR9qxhp0ZZE+2MrXqMtl/fjBxqDcCrxzbtb+Iawie2/RwSZnjzWbT5FprL+2uRBhjthf60nn0sbQQlDdA9DcZSpFCLYLLwL6mz5nzSUzCGNvwmBrjU4hKyki09dKekP3sFodos5A0GS7++Iajhpvd5LReoNc1ex7xWdVvHwHVa+QKnd6x7K+QXWAy/GPS9y+/Nv9kmTKB2eNdgzKuvURJEks6HbUDBRTxw0IdFDUzaFMEvNw2hln+T2He4IQCJssinT4khdDN4A4aon/ozANGHvwUDH7+apN1jHx8X7W3rzmP+7utA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFkLeyGjYjy6yn2ptQr7Mh0BgfFU2OZcTR6y3zoY6To=;
 b=A3C2fUO+f6LEeH9by6wG8uhVcKRRcmvcgCJcltN8ljOCNiEXmFRLukk+3d+fPG3wPgyiEHkVOS0rPsqktY4jdu9CWkKAfLGw1JaWa0YmQ6YRCYNnA76OOViJrb2G5ApGda5mwn1UCNrnKiVmRxebEv144ZwJvx16jwpXKmSRFXNWrUT52UzKt4r0mslVfdAhuinnoMgq0dLNtug6CK1Mj9OH3s+3CQ+I6x+liQFzlDBIauBEsKQrERZfHlojlre516H8tjQno+dOQrr71tMvO16+lLTM9ZFwEikSZ1EbLhY43y5cL+fZ89ijxxy0ssMlQMoxVLwvS2V3wfZljA0hsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:29:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:29:45 +0000
Message-ID: <862bd865-ac75-4e4b-8445-fe3987ce7f20@intel.com>
Date: Tue, 2 Sep 2025 19:29:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 08/33] x86,fs/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
 <57c33dd8ed98603d5b434b3f8f32c3c1b19dac00.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <57c33dd8ed98603d5b434b3f8f32c3c1b19dac00.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bc13ba-5a1d-40a0-d560-08ddea91be9d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bm9zNktFMHhpT0k1c01oMTdEZDBoVzgwSE5Pc0NQQUZGZko3eW9CaXB2a2ZK?=
 =?utf-8?B?MDhvRG9sS1F5QkZWTEE4bHcvTzIvV0VVSncyVW13VTZLcWhTQkFlZVVTUm5F?=
 =?utf-8?B?TU92c004U2pPS0xWV2FaWXFDL283MitpQkw4Wll5OEYzd05CdWlHZ1pKdllW?=
 =?utf-8?B?Yi9MYlprRzVScGViaUY2VUhaM3pNSnBpZk9mdWRXTHBJSWhTTENrYy9sV2Z2?=
 =?utf-8?B?aEROc05kcG9SN0d5dy9KSDcxdDJ0aExqemkxOFVwYWNscC9QZmFDMGpuMEhY?=
 =?utf-8?B?RnVCUmkzY0VJSHFKRGdGQzdiRTBLYmphWGM0ZEpNNDhqUGs4bVNYRnpLYVF3?=
 =?utf-8?B?c0JiMXdTcVVMb1IxZVk1RGRVVzlPenF1TTFvaktZVTVrL1VuUWxkRUZQRDIx?=
 =?utf-8?B?RG9uMk5VRG5YVEpBS0VEZmg0N0hNSzhqVWlYazVlMzBLb1MvODF4MnlwWDRG?=
 =?utf-8?B?VVJCK2kxYnRGRnF4RTVMOWU1QnZBcHp5Ukx6WlRRZ1pDMXMvOEF4TUNkdHBq?=
 =?utf-8?B?SDJBSUI3N0hNcUdsUVJrWVFnTmpid2tyVE5CVkNGTS9ENUdWZm85Q0FYSXA0?=
 =?utf-8?B?TERMWXczK3V6RnFiVTlTZ2Rla0J6V0ZCeFUrbnRUN1RqN0NQQ1prS3AwUGdC?=
 =?utf-8?B?R0ZrU05iQ0ZIaWxkZVVIM1p0Q3NnNjQwRHZYQm83TkY4bmF1NHoxdEhKeDdx?=
 =?utf-8?B?cEVXZ0xwK256c0d4eEZ2bW1sK201VmdDQXlLTlpNbEVjMGViK3U4YUx4M2tM?=
 =?utf-8?B?WGI3bWhkYkZweTFSU1VTTnpReUI0LzJKNDh1c25tM1dVMEljMFhJbVE4Z2hv?=
 =?utf-8?B?bnUyY2t5YVUvTkM4RkhnMDJGVzRYUzV4WG45eklNdXlFSWY5YkdYNGJ4dThE?=
 =?utf-8?B?VXMrWVl3aUs1TXIxZU5FWFI3d3p1U1lOYjlIb3VDM2JTbjdlaVgyVFY1QkJ6?=
 =?utf-8?B?TEJBNXpqeTRFM2Y4K0RucTlEQWVlVjE4emVyZlljVy9nVlQwek9TZEc4eCs2?=
 =?utf-8?B?VWM0SFRTUmhRaVlnakJsV3AraURHaXVjbzB2KzQwdDdUT0pKSTVyYWN1aE9W?=
 =?utf-8?B?UmI4YllTRXNjc0NGLzV3bXVkTlF4bFRYU243TUFKK0hNUFllVkJ1T0VIbW1W?=
 =?utf-8?B?UzFjZ2NJZVZ4bk51NFVJdDFCR2FlcFZHUUxmT29ZbzdGaGNZVWM3Nm9JRmVw?=
 =?utf-8?B?TnJDaEZpR2xlcjlxVHJ0LzlhSkw2VjZZSXMzMnhYYi9LM0lOWTVvTVM0WjNl?=
 =?utf-8?B?S1ZUVHpjS0Q2SXRZaTNKSjY3ckIrL0VTRVVtZjBRVzUyY1M0WE5PRlVXYU0y?=
 =?utf-8?B?NngwSTZxdmFUQ0NPalpmc1NvaU51RmY5UVJnUVczK2U3d1JGUE9RUkdOK1ZC?=
 =?utf-8?B?dENnOWRzamEvNVBhQVp2VEZLTGU4SHRBa0xNRk5nL0tOMlhUS21UMitLMmdI?=
 =?utf-8?B?SEd3OGVuUGhJR2Nnd2JJUDQ0NUxMdXF1RVZxeWhYekJFYWIyUFN2c0Q2TXRj?=
 =?utf-8?B?R1FKOXdHR2FnYkxxbXlTZWdvazA5TVQ1T0VrUHJENGF4TlpYMzYrU0RjWXN6?=
 =?utf-8?B?QmxramxPUy9CU1l6L2E5NlNOOGsrZkI4R21yUC92YmdPM0NBNlNoZ2w0ZXNI?=
 =?utf-8?B?K0M1V3JtaU5IMHB2c2libWM1aFp0bGpocllwN1NaNytrSmZQUk9nZndhWFF3?=
 =?utf-8?B?ZWFVQTJDT1gya0lxV2xFQnFLY2JpVWVwTUs5UFlpWnZvS3R0TjFOTzRRM3Fq?=
 =?utf-8?B?RW9ETEplOGNQQTFzcHlEVzl3NmE0Z2ZmVjVJbXZ1bldSVWpBM3VvNURYQlJ4?=
 =?utf-8?Q?jgjGRDwO02ACFPyNnHou0V/Mm26aAlw1C5Vfc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE1KakI0OEJKaXh0SVVERFFjNjRUMkptRXpKNUMvcGthZW5yTHRnSDF4SWtO?=
 =?utf-8?B?amwrTU5OeWdyQlJTektSOHEvSDREVVl5ZXdpamhkbnBCOHBTY3ZHbmRodFFw?=
 =?utf-8?B?bWtVbUhodmFJY3hNdk5rb3ZUUjJrdkFKU2J3ZlRtc3M3djFCMlA2WHhEMjFE?=
 =?utf-8?B?TTNveEdMQjc0SlkzL0ZCbmEwZ0JxTW5ncEo3d1BTQi9Xc0hwbS9ka3NRUE5R?=
 =?utf-8?B?OXRsbjNwUFFFeVZ2bmF1K2U1dXU4SmU3NTIzRkNLL1VjVERacitob1hkNlJr?=
 =?utf-8?B?azZJRGVMQldZSjJmSUpMNjlCVklIc1ZocDQyZ3Fwem5OTkwyQjlKVDZDWVdm?=
 =?utf-8?B?R0Q3QVZSU1lnREZiU0tkeEUwNVlQNWlpdDZVbDhrYnBSR0dCWmxvMUplTHRQ?=
 =?utf-8?B?dDN3N2pGU0JmUWZhUmNjUDVpemRKR0ZzZnRRTHpielg1TWRxVmlBM0ZSUXJ3?=
 =?utf-8?B?cHd4cy9HRStNbGtId05SUFJ1VlkyNmxWVE56b1pWc2ZDenFHV0g5NUZlSWx6?=
 =?utf-8?B?aEdrRmVwUjBRTWhSV09mME5ldHFLamY1VXNrOVJLc1NvZ0hibTFQUWt4eU1l?=
 =?utf-8?B?bVpVR0ZaVWoyQWluZlRQYUt6MEJURXVXOHlZUXF5MXFDcGlJRldQbEcwbXVl?=
 =?utf-8?B?bHJYVXJDbkZNSnVoZU1OWEF6MUdiYXBQbzFReW5kekdpS0orUkVtOGJ3Q0NH?=
 =?utf-8?B?L2lDZGNPVFpKK3FVOUpVRkRBWGNkNW5RbHpmRnFuZmtBR1FwL0VYNFQ5K0x6?=
 =?utf-8?B?MGMzVlZMYk5ka2RhYVNXZVUrYm9MOUdQQnpRNWhUWEJQS0tpcElaSWdPUXc2?=
 =?utf-8?B?RWFaZVVvRXRJZ21RbEJpUnRUVFA2b1BKODkzRnpLcXd0VkhNK2JVZHZjM055?=
 =?utf-8?B?cThWejFsZ3Nxa3BGVmJ5b3NOSW9GdmNXOE00Z3Y3dTNHRVpEZjZ0T05UWHQw?=
 =?utf-8?B?bVo3QkYvNTNSbzRDUG5hV3gxWTVHNEdrMjd3bitRbkNZMXZoTDFPQjZLQ2No?=
 =?utf-8?B?MnZHK25CTXlFWnUzVVlDQ1YyaUlFK3R3SVBJS2tUQ2JYZHFWV3hGNXZkZ2VF?=
 =?utf-8?B?Yk84YW55Yys4S1hOaUFzbll0a2xPMHhTa0lFNXBRSWZoVkkvUjhYSURydVJD?=
 =?utf-8?B?bzNZb09kNkFRMkZzL0JXNGdLNnByUUYwUGhNK3FGRzQxak1DK2xCdWVJTEto?=
 =?utf-8?B?bkJTVkVUMXF5amdVanBsczMzemJnTlBhZXBUVlJ1SjFCaTFWZjZnak5jMWs3?=
 =?utf-8?B?WStwckFSL3d3cG5RYktyUlNLTVBCM1ZQM1hWcUExRkp2TmE3MU5takdoRlll?=
 =?utf-8?B?ZTZBUHZWYjJHUERxdVczWnpnLytXbHdhZThsRVdpSlczZ0Z5RTNJUVIxd3M4?=
 =?utf-8?B?UlpXMEI3ak4vVWdzNVgrU0NjRncvTzlkNFFJOWJBVCt6YW9WVjQ5dytCWUZS?=
 =?utf-8?B?TkJNajRwVUJaS0VCa1NVd0kzamcrM3FRVUJucm1hY1g0dWJ0Qk9MUVdHSDlB?=
 =?utf-8?B?Qyt0ZmRmN1o0WXNlQXk4VmRldndaYm9DcHZvbG9sUzZJWWdaNUhVSlFGbFc2?=
 =?utf-8?B?ODgxN0pyUG9LMldkRnEySGdJSTMrWjNYMXFtU3JVUHBHZjBZbkJNQVRzTzVO?=
 =?utf-8?B?Vjl1ZHYybmRzNkF6c1hCaEFJUmV4SzZ6dTcxVFJIV3NqNFBwTlhlMUVuUEgr?=
 =?utf-8?B?bFBjK1I2Zlg1eFhCakd4dGtlb2NjMTNRYWZVdm5KK2NJakRYTnJYLzM5ZDBo?=
 =?utf-8?B?QlUwZUVnc2JZNnovbGkzTE1hdjFlWXp2dWdxbFdyUStMNzVWV3dYUE1GVjh3?=
 =?utf-8?B?QnBCSW1KUFVvOFAxYkZqbTRXV3RRMThVZUN1dlEvVWlxMVdwODVHd3o0Z2Mr?=
 =?utf-8?B?NTRHU2RzSE9WVlA1cmJQTkdtcXR5RW5oWGlxUUlqV1Q2VWVDNUc5TUhOYjJq?=
 =?utf-8?B?Zm5hQ2thRytKOFVyNTVtVFU1ZC9QSjFaZk5MaDFkTXN4WE9qTGZaU2h6WmRJ?=
 =?utf-8?B?ZWd6L2ZKOTRmeFBWZCtLZnRTSUc3N2RzNWRRbGhMaHVndnFMS0RLOStEY3RV?=
 =?utf-8?B?RnorZVlhK1lzcDU5VmpjOFJoUGpJYkxDdzRpSWRSaVFLMkVCb0graUZFYzVV?=
 =?utf-8?B?ZFFTZTJ0T1VuMEkwTktnMGNVZWxLWXJIMnh0UEpOenpQUEpqYlpmdXZPT0Np?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bc13ba-5a1d-40a0-d560-08ddea91be9d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:29:44.8732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P+XE+Sc0uE1Wjua7hmTL9WDymxmBod3FiQKfQWtZlgStMYI7hSmU0hzCj9HI3Wk6cEaDI4NqV1bK0RiXa+XzAcU5+417bYzYGp537hW8pA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
> Bits Description
> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>      Monitoring Counter ID + 1
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Detect the feature and number of assignable counters supported. For
> backward compatibility, upon detecting the assignable counter feature,
> enable the mbm_total_bytes and mbm_local_bytes events that users are
> familiar with as part of original L3 MBM support.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

