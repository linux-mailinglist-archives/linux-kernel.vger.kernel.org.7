Return-Path: <linux-kernel+bounces-797608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F28B4126D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023EA3A43E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9486519E7F8;
	Wed,  3 Sep 2025 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V64eZx1G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7875809;
	Wed,  3 Sep 2025 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866918; cv=fail; b=lL+/WNJy5IMjsCLlnMN/Ac6UrL0/qUYzhMqhMbgVzPNTM0iDaiOjYORAVrg5RXEIaUuaru5XPbEEasT3d4T2Vm5MJWn/0ake4PldreXztlCSzfuQ8iZv02R/vq49EutRkbKJwiqj0uanyRLjAUDsaqCrPzAL/GSw4tkLoICoTog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866918; c=relaxed/simple;
	bh=h6VE/rPzrYexYFQFU15jfVg/Mts9nVe/rXeGo7HRF7k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tTm0eN3GPM7uV3caFl80/r4BvFopQQ3Y+WcOBVv8Q+h69sduLDHVwjIvBCgRjgPrPRuWv1vK6PLKAkqhsJlY8rvjHWSMRL1qSQRjhixpXUb3j8Nt6seDZHARQtDu+xoy775G/w/Xo+NcmQE/+lcRmpHET8vgxfik4F/I7cdrux4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V64eZx1G; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866917; x=1788402917;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h6VE/rPzrYexYFQFU15jfVg/Mts9nVe/rXeGo7HRF7k=;
  b=V64eZx1Gkk3+LAjE1Nl+GPVCjvbHyOFTgz85I6pA5IzjN8sn6evpWDES
   wmFs6x3v0Rsy9BB9QkIhxhY+lx6KmDr1KgIMXKE1coESZZzY0htfZxknQ
   EZKP2oTdWdvKfyKj57IC9eytkrjK4gHSGOJoengq8qN1ZEsfRTEO36hPe
   YDVJDGbfURttv9oYDsfP4oQfbgfsoxgCfRgFoT1usKViPD7zeoSudssKq
   97D76bThDWe9V+1MdA84ZnC0D17WJEY2aAcPIiBNNjTofgKmsH2D9bT4q
   pGUZa61jMHoEbkkmb5HAMLNnjpNVKWixqdqQbwgAelNekE0tittFNMaZq
   w==;
X-CSE-ConnectionGUID: zUOJIzaESzyBGmZIwGQrnA==
X-CSE-MsgGUID: oPZlh3wpQIaVY+c31Q+fMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="70599152"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="70599152"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:35:15 -0700
X-CSE-ConnectionGUID: nl2MfRbSQPCJ0QMNWkwrlw==
X-CSE-MsgGUID: /mRayDVBSou+Aq+2LZPLXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171910816"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:35:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:35:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:35:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.75)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:35:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDvH6RYVoQj7YOROCPERxmxOB9OZGmw0C+V71zyKWu21KJmigdMFHZuO1hBEJSsLQEHkT+vTIIlIsX6pifTS9fhn8sfj7nd+Dgk6owKTkFiCG0EEUNvurOow0m5wiLZYEbIjLqFn5Ve1hmHfmHBnIBPUImyV2mInsdw4FaQGzyFYXBN8bpxbGyCEtld1xpNWglOnes2/QaHC8pLLTsat+rwNrBkqdS3Xydm4EQsKhZfshcd6k7LXEAMSu6gxRqEv2g0u1YcVWXDmQ3gwYZdDeVKiAlDsxPxFvhTJkHsG/QB9Qie1GbsgcnQaTIG+KSgymwQ6sAL6bFoaiAk30Pcb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNWxzmFz9L54M8HeaSAeamS+YZuymZJN2DvPLcgr2kQ=;
 b=EmS9pxOhgbDNUCf0nZBDa9WL6iyAp6Eu6mbb43M7bw340qfFtLM2jt8h/2RhXI6wly7Wn5Mq/AJtI+b6PVYT8NVBWMs/6jLXHAhWKAwcViwvkT+EscPKPOIcNCT1dWFpmRCy1QBNYKjLAg5WHHk0LI/qMARmdAr/ifF0A4BznvQeovE7OkATdquiIbUK5/id9RgPKyjBGD/nNJlHjx/fBlOeIaeV8NwIiP6LSo6F4682hzmgcVx4jtunMnTX2OCAq7Spzf0Sl7jrKKy5EoIRWPBE9bimchnSI7gRIOe6QBDqHx+OG/+P38W8WJkfHOZRnlDx0rnTJVpWPMHtpkwR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:35:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:35:10 +0000
Message-ID: <915ab800-510e-40a3-8228-373ae41bc3ec@intel.com>
Date: Tue, 2 Sep 2025 19:35:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 24/33] fs/resctrl: Add event configuration directory
 under info/L3_MON/
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
 <b09cc34a98f31ffbb913b26a64d9742ffa617dcf.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <b09cc34a98f31ffbb913b26a64d9742ffa617dcf.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:303:8f::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d7d793-0dae-46c0-de24-08ddea92806e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmxKZXdhVzlDekpEOHQvQ3RLVTBNam5jdGJDQ0V4VVBxMUpNODNnUXJUdEFP?=
 =?utf-8?B?OWVnalR2VkZLQnZBbWU1VnNVak9DQlpEUnRFc0RYZG16SzJBM0Y1alJMYTRr?=
 =?utf-8?B?ZE83OE84ejBadUhyTjhQd0dlSnh1Um1vU3NLVnhIZ3F6dEwxVVJwamx0a2R5?=
 =?utf-8?B?M1V5V1ZVbGRQeXVNaUdPT0FOQjFJWFVybEJxYUhXNGxqdEIrTDVYTUs1SXpW?=
 =?utf-8?B?SmYzaW9iSUZOT1k0V05VekNiUnk5bE0vUlUwTjNLSENBWmt4T240dEV4TThY?=
 =?utf-8?B?R3ZNNU03VkZzMTRIRy9zVUowM1B5MWloOVNJR2RLYXV5SE9UYU91dnhqNU51?=
 =?utf-8?B?enJtcUZrTHg2VDhIK2dIbzZwb0R4K1RSbnlTYzhaTzRvV0RVaWJhSC9kamxZ?=
 =?utf-8?B?ZGo1ZUpGVmlaZUN3eHZoTFJsR1NQSHlyaEROc1dmVW9OcFRYeUFFb2FOM2tj?=
 =?utf-8?B?bWFpR2t5cUpzNzhFTHBpWFplV0x3Z1lIaDNGWHhHS2lOc0hRVTZWSlUxd0I5?=
 =?utf-8?B?czhISnYvYlhGMmlHZlpjSmFxalVQdjBBRUY3K2hVTmtQNHkyN1RWMDY4b3Fh?=
 =?utf-8?B?R29qQlFoOG01bElUNHZLZmpvNmlEeXNnSEJ4d25Cam5oNGxsdWJZQkVFSmNH?=
 =?utf-8?B?OXFhTU83NndNdy80SjZ6SkcxWUltVFR4Mjc1Ti9GTkJ5Qk16cFFZN1B4SVFN?=
 =?utf-8?B?OHg4OURnMUdSVmpScGRtRFBuQ3JoM2tlOW12OGcrT2JNZUNhRHRUVGsyaHpQ?=
 =?utf-8?B?eGR4UWhHUWhuSVVzV05xejZvelEraFRIUTJkTTVvUkxub1FSZEpvOUFGNE0x?=
 =?utf-8?B?YjhLY0taV3ZnTTlxWlA2czl4eC9PVmZsV25PaEVBdDEvUkFwZ1NpSlBCYktl?=
 =?utf-8?B?TkJqK2QvaVVmelU1NkVPZGI2bzBKaWNkai9JL2toejlGUFdqVUVlTGtHZG4v?=
 =?utf-8?B?Y0Y3dW9GMVhobEdXdk1mSlVOR0IyL1BQNHV0WVRudS9EckpYdXZESWdoZWtm?=
 =?utf-8?B?REFrNjdlYVdOQ0pqS1ZVM3hGQi9OSDdMN1ZwVytqMUlsb1RRdlREa1I4djZG?=
 =?utf-8?B?V3EyR0ZSbFVtT3dsMWhOUFNrZW1EYVZCWDJiaWxZU3NpbDhhaHJyZDlHZ1RK?=
 =?utf-8?B?RVBXNmxDTUo2RWdpNE50Ykg5QVU1T3VUaWNEcitJNVVMb1ZhWnViY2Q3WTJ2?=
 =?utf-8?B?elVLSWtmaUh6MmFkNGZqRG5lSi9qREdFOUczSVMxQlFJaUhCVjJHSTc4K1hC?=
 =?utf-8?B?VGtJZjVtTUkvMk1sVHQwV2h1MHU1SjZqZ1ExMEFuWStyb1dBUVduU1lGSWNG?=
 =?utf-8?B?d1djK0JwS0duWEFqQldVVlhqVW03UENDSm1qdmIvd291R09kR0tiL2p1b25i?=
 =?utf-8?B?RVM0aFRYZnYxbjR5QldqVE5JMVZnQjlHOGRVWFNRWVB2Z0pFSGFTbEpHQjZO?=
 =?utf-8?B?eHhXbWpIVHJ4S1ZNdDRQNTIwdE44dm1mMitCTXc2NzNwOG8wcEdYZnltWFQw?=
 =?utf-8?B?ZEg3UlZ4bUtUWWh6STJSM3JQQ2gxaGt6aEYvVnJPT1RxQVM5bFA2aVpiR2o2?=
 =?utf-8?B?cUtEZWQ5SmVGS3AyTzhnb2hMSVVCcGNmb3U5WURFQ3MzNUM1a3pGeml4bTUy?=
 =?utf-8?B?UVRuV0x3MEgybXA2d25BelBpNEN0aVFzT3FDa1dnMHdjWWR1bkFoU0FIcHBL?=
 =?utf-8?B?djNVVUtNRFhKd1FobjZUVUZaYVFMWHRxWWkzeXNlVnp0RzhiN3liNjMySkxR?=
 =?utf-8?B?UU1mWDZjOGdOdmp2QWtLaUxmS0dIc3RjeUorSDVKQUFRYi8vNExmTkN1N0tH?=
 =?utf-8?B?dkcvRWRpQ05VS1R2eEdlSjhpRkVvQTh2YmNldkxqNUxobnFZbzVFd0Z1ZGs4?=
 =?utf-8?B?S2trUCsyeWdyVDlwaE95a2ZDejFrUk1UTUI4aUttOXVMWCt6QWNYNGh2Y1ZX?=
 =?utf-8?Q?iNAgoHWcLP8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTJBMStLbCsrVy85L1QzUmhkK01HR2dMSzVQcFZ4ZlpCZ1A4dGd5NzE3WjBT?=
 =?utf-8?B?ZFlVSkZ4bUpYNjlPckR0c29aazVGVTlIcVI4ZlBpSDdBODFzSE83SU4yTzFK?=
 =?utf-8?B?VjhLTUhtQUJlZkc0cWlVKzU3cmFETklQbExVMEJ2eXdiazFYZE1rVTc1L0xJ?=
 =?utf-8?B?RzFoa25OZzF5N3FJMjllS3N1OWdzLzNJYkd2czEreWZ4TFk2dmNsUHVicnBs?=
 =?utf-8?B?UW1weG9zWlhNbndlckh1N3orOGQrYVdQc1dQVUp3dVlGVXp6WmtDTmFoOVd3?=
 =?utf-8?B?OFEzOFBiVE03VGpxeUVWNDRXc2VocGViblVXU0xBV3lwaVF0SS82bVd6dVpM?=
 =?utf-8?B?K0k2WTJGZnF3WC9QV2NacVYzZ05zc2p3N2U0dlZBc2FMV2Z2bDFRVlZvZHFx?=
 =?utf-8?B?Wk5BTm16Qit0T08yb0ZwL0tFZHNDbGdhb1J0R0VTUjNyem0zdEhJQURZd2Fr?=
 =?utf-8?B?Uk1KdUZNaHpkWnltZTg4N3ZCZUtlRFFxQnV0R0xyKzRyWHUyR0FhVXR0SWs5?=
 =?utf-8?B?Qk9TMkZ5WnNmU1NlU09RQVAyaVYyMXFZQ2xRV29MV3FtMGJFdUlpNkNJSFBp?=
 =?utf-8?B?WXA0WFNsMGVpMU9pNmNUVWNoR2c5NDBlcEIxRWsvTFlsY1ZKbTdFZ2VVVEFi?=
 =?utf-8?B?N2ZZbk9JMHdhWEg2TEIxVXRLbVRsV201b3lqTTFITGtadGdPVVVtbUtTOXUr?=
 =?utf-8?B?anNIMWVxSDFuV1RXc05lM1c3WmVNenh4VlJ4aS9LK2JSQUdNWHFURkZiZ0xm?=
 =?utf-8?B?dmh4bHVUaW9aclRqUzV6b0JNb2Y2WjNoNWxtbWoyNFA4RStWMVNuVXdqU3Uv?=
 =?utf-8?B?NXQ2S1VmMXg2MVZsdUdnQXJFVGN0WHRmK2FnM2EwdmdBZ0Y4U1dUWkFzL3pr?=
 =?utf-8?B?aEExZkFnbnpkeitBV2JDT0V5VzJPL08vSmU5K2JRMzlOUm5qVk9SdS9aSitV?=
 =?utf-8?B?bGRqYS80QXBOKzhzUS82WHg3dkJ0R3g3VzEzbkJMbTVycFJvc3gybFdnT0Rs?=
 =?utf-8?B?YzMzZVFWNjdYaDArcjc5Mzh4V2o3T3dHeGFNRnFQRXk5VXBDUUplUGFWUmRW?=
 =?utf-8?B?KzkvK21VZzUrU3hGemtJWkdYaGhjbTZ2SS9QZzltYVQyN2NTbkNNOVpsRHRy?=
 =?utf-8?B?cG9MSDZRMGN1dk5JZlV5WUhZanh4ZE9udy91NEpOZFdUem5vb1RkcGpSRVdz?=
 =?utf-8?B?OGxhV2RJYmlWOHM5bzR1U2NuQjR1ZkkzenE1cDEwYlJUZjI1dXlQR0wyNXls?=
 =?utf-8?B?SDZhZ2d5V3MwM0o3WXlqZm91V2NQSHV5dFpPbmxCVE5FelkxcDhocklSRVcv?=
 =?utf-8?B?RGZhQnMvT2NxQ2RtQjdySGtBQ3FCQkRua2tsUU50VmEvRlpMdHZORTdsYk5I?=
 =?utf-8?B?TVBoS2JwcTlBZ1JxUnl1RVJUa2Ztekx4WElkRFFzTGVITk0vaHQwQTFnRnVI?=
 =?utf-8?B?SWdjUXhUNC9ncXp4MWMveWZiNmIzTW9XUWNiS09OdFRtYS85cXZxK0Vqc3Va?=
 =?utf-8?B?Mmsvbm9ZYkpjMmpjaUU3UzVpTFUzUThuQW5hQTJpRm5pcXdsVis5WlB3VDJS?=
 =?utf-8?B?d2h3Z1A1aXlCYTViV1k2aU5lZTNNN093WjBRa0R5UWFqVXg0ZVVKWnpsVFl1?=
 =?utf-8?B?SThrSmtpUnF5T1daVlFrVld0aDFScUFSTEZrMlRaN2piOVZCV0QwTy9LalBS?=
 =?utf-8?B?ZVA2eFpvdUc3cnA1bTVQRmdJUVlNOVJpY0pDR2JWT0J5dmFQUmtEeDJBS281?=
 =?utf-8?B?U29xUVlVWjA3TWVTbnRFTTV1aFMvQ1VnMklIZThaSjNDL0VabG9ZYWMxbWFL?=
 =?utf-8?B?ZmZzQTU0SzlIa0pMemYvL0YwRktzcWZXS3Nrc3RnV1BSN0l0a1liOXhEbDVW?=
 =?utf-8?B?VDRHZ0FRcHVNSUZXdWw3ZEJYYlc2NmRYa1R2TWVlUk9zUVIwczZ1K1YraUZ5?=
 =?utf-8?B?eGdlUmxEWWc5ajVNWnFrNnZkZ05NK2kzZkcveUt1UFR0YUtzQXREK3dtcEVB?=
 =?utf-8?B?ZzhOUnZsdDJlUHpNQ3RaTWNNZHhRRDRLdklFQnVaRkJkQVg0UDlobjNoSmpQ?=
 =?utf-8?B?Q1MwaG1vMVhhb0JoNUZFU1NPRXUyUTcwM3ZjdXdLMUdRQTVqdUtPWDBWcXVs?=
 =?utf-8?B?bnExZkJ5TWFmN25VdWdiZTJ6SnpLaDZBTTYveUhSK2FCQXZVRG9UTmNwK1RQ?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d7d793-0dae-46c0-de24-08ddea92806e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:35:10.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkhXh9XZPYXKTSXFcaFhQH6TystXEneg0k4x4Oieh+okTvUevasxGRzpNvRWUMjLMqYjFfBwEGRixHWJuRv3uqD6k1+EHY672rI9oy+nMKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> The "mbm_event" counter assignment mode allows the user to assign a
> hardware counter to an RMID, event pair and monitor the bandwidth as long
> as it is assigned. The user can specify the memory transaction(s) for the
> counter to track.
> 
> When this mode is supported, the /sys/fs/resctrl/info/L3_MON/event_configs
> directory contains a sub-directory for each MBM event that can be assigned
> to a counter.  The MBM event sub-directory contains a file named
> "event_filter" that is used to view and modify which memory transactions
> the MBM event is configured with.
> 
> Create /sys/fs/resctrl/info/L3_MON/event_configs directory on resctrl mount
> and pre-populate it with directories for the two existing MBM events:
> mbm_total_bytes and mbm_local_bytes. Create the "event_filter" file within
> each MBM event directory with the needed *show() that displays the memory
> transactions with which the MBM event is configured.
> 
> Example:
> $ mount -t resctrl resctrl /sys/fs/resctrl
> $ cd /sys/fs/resctrl/
> $ cat info/L3_MON/event_configs/mbm_total_bytes/event_filter
>   local_reads,remote_reads,local_non_temporal_writes,
>   remote_non_temporal_writes,local_reads_slow_memory,
>   remote_reads_slow_memory,dirty_victim_writes_all
> 
> $ cat info/L3_MON/event_configs/mbm_local_bytes/event_filter
>   local_reads,local_non_temporal_writes,local_reads_slow_memory
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

