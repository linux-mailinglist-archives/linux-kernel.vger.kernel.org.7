Return-Path: <linux-kernel+bounces-741745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD64B0E879
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB821562888
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8691B1A08DB;
	Wed, 23 Jul 2025 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVFPkK0T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D644A1A;
	Wed, 23 Jul 2025 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753236386; cv=fail; b=PvgjFVpGAp6Dvym8W3YFfzyXeajzkY8OwnnTa6k3EsvYe1GAaXapfDQAjWERvvHXbcWyWZp6g3hUY/cHMbhs6Hff0iygmalUHOyZYrHlYoi1BeogbhJ6E5JwklWD+zE7HhD0Os0/WOEPJM85N1HTH3cZBFVeFMxCdCXb06TXnIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753236386; c=relaxed/simple;
	bh=ELvnBtBCAE07b+DIKaE7wbQJgWeeBV5iXnCxSBFobwA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a7fFL8vjXSH9diwo1aTH46vRbUFSg9SzthBnCzy4XUzfQOMMtyfpbAoWnMXXUx4bULGG2WR/02Y3/7UrjolOJ/Nykn4PSIn0tbnfG73NWjfoWUjpfGQlSb10kJNnUVdZP0YAIKcWJQqPJWuA2csJNE1JvSgUrzncl0KiqAhClZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVFPkK0T; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753236385; x=1784772385;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ELvnBtBCAE07b+DIKaE7wbQJgWeeBV5iXnCxSBFobwA=;
  b=eVFPkK0TWUsM5tdGAZIMViAvKDPgOY14tNNz4OeUYisetedXhN45NFGx
   EebRhzmPlowRhYmVMFJffeNS3T9XMwcqZjmXBTlDZrTmQFBUiAhwOmnI/
   AKJT266CWYMr6MbfaskIleVrI4/vgSBUq3ab6g2mgrDq71tYWYtdhWRpB
   GLE/1PMcBWTWgzKNrBxz298zGqkGED2OoQ0NQ/zEdHTbJynfiO4OShEoP
   CWPi/8hv1j/mnYhinD07khYNNnJnDa0LStr6ud896kjuW3AL4DpkTl9EJ
   lIpj2VX9K0+nSruE9bIQiZnwymQKbUpKkQh9sXRcJvSHucTgXZ4GjKLe0
   w==;
X-CSE-ConnectionGUID: uwUFnfSvSluphqOxoiaCiw==
X-CSE-MsgGUID: bWITPqouQHKb6Mt4cr9LAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="43123472"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="43123472"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 19:06:23 -0700
X-CSE-ConnectionGUID: 53Fy6EUKQPuckMHCn11MiA==
X-CSE-MsgGUID: hwDXoQGUQdexVrzNwy9A5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="158606018"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 19:06:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 19:06:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 19:06:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 19:06:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgMLqdgNSEEsN/PHydsWTkOcfJWeCocpIa7paKw8flsXPIB4YSdDkSQ6AOLJmzCeWxeEepcXRDvvoWFki35mSC6DR/+dDOzoP5WGHT6+is0Q05gMsOcaKyO1bvcxOX+5c6WEOvTvBUvfaSbs8m2iOCyJ3SPPJ/yw1Utr7Q11ylxrJdNoqHtQJNQTl6R4INi3eE7jChcCYCc2uTYGN1+cmogioUkIhG6NFPaZ4fRaigQlBUDWii+G1AxMMCXhKd4QUZ5/RH4yCmMpyMJ+H84m05+BBZoDsQpAmkRWfJX1FnyCC96CYWBjN1pWBD998Aeg5rXIwKv2WaRha0z0Im3rcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ia2ksZhacqdDxDsgst+yGI+dPSMn4dOQcaycciLuug=;
 b=OjGmfU5XY/0HmTpbM4avCPjvWoWc4a57p8ZWK10C7ypUNpi41iiIviEv4DKbLhnnJqN066QhVPR5HPJRbjJWhS3SUlHv82bXPJjZ2ouXQa0kz/gC794TfmXlJZfFfquV3i0X2PL8lsTgMJNxa1PrNHFdtmkwmMT+YbC3CyaryJRwH4IERXnkHeV45oKV/Px9jByU+1R0E6OWwhZ23FKtcOEtX8dN6su/uBq96/kFva17mpHDSuCko1EJQbXeSkgw1f8Wa6RCiAGVa1kTz1/75DNBZAzLCo7S5aic7uAli4fB48Z3YNQc9yGlOHstgwAMCo0bqVLD+MjlR5t6m9e70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8373.namprd11.prod.outlook.com (2603:10b6:806:38d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 02:05:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 02:05:46 +0000
Message-ID: <0fd87712-0a71-4f4b-8780-648099e708fa@intel.com>
Date: Tue, 22 Jul 2025 19:05:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 24/34] fs/resctrl: Report 'Unassigned' for MBM events
 in mbm_event mode
To: "Moger, Babu" <bmoger@amd.com>, <babu.moger@amd.com>, <corbet@lwn.net>,
	<tony.luck@intel.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1752013061.git.babu.moger@amd.com>
 <296c435e9bf63fc5031114cced00fbb4837ad327.1752013061.git.babu.moger@amd.com>
 <4b5eef45-9110-47f7-8e1b-a59028d66c52@intel.com>
 <1a7e2a89-4006-4180-88c6-aa7cad76fba1@amd.com>
 <791ff5e0-dcd8-4bfc-810c-b085bc4ca543@intel.com>
 <37f2b5b1-0e99-45dc-bba3-c8c22fb298cf@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <37f2b5b1-0e99-45dc-bba3-c8c22fb298cf@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:303:8f::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8035e2f0-70b9-477a-eae8-08ddc98d701c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUY3Y1hFd285U3hiekNhN1V1RnpETUdUbm1XSkFlNlYzLzhpMGlOemJlanNS?=
 =?utf-8?B?TlFEVmJBRWE2ZXNjR2JoZU9pQ01sREhLZTYwbHEvVStoMy9MNXo4MnJVQi9s?=
 =?utf-8?B?VW1KaUthZ0RvOXdvTVZmYzBhYlBialRhblRReGRCdGZ3VWxhcGNma1NRY05j?=
 =?utf-8?B?SWwwU000dS8xZ3R6LzVmTVlMMXNkWVhCMFpUSlVPSkpkVjhWSjNFM21jbzRD?=
 =?utf-8?B?YlpWUVg0U2FHRHJTeGlPT2JNR0ZsN3ZJM3VIY3kxbCtTekMraW8ra0pqQXE1?=
 =?utf-8?B?UTlrc211Z2dJbWs0cVFuYU1LcU12N3g3SzZFWGNtS1RXcHBCMlJtakVnRmlM?=
 =?utf-8?B?bnlGMXYzSE96QjRMYlVBRVhNbzByclFkb2lXMnZXTjRic0VoVG1QOFdObWZM?=
 =?utf-8?B?eWFTcDRnUFAwNkZPZDJLZjdBZWhXV2ZyY0x0YS9EZHd0Rk85SmxodFdVSWda?=
 =?utf-8?B?Z044V0ordGlhVERDbklzU1lLMnpKSVY2RWJaZlREcDlUTk1lYjNhemNlWm9M?=
 =?utf-8?B?anYxd2VKQkFwVENsRW9idzgwMERiMmNoSVJ0N05qTUVJVjVKaDJEZFl5YU5Q?=
 =?utf-8?B?UzFWRTFVZGZWK085RTJRazhrY1MwQ0o0UjlOYlpISURjRm41UGZNMFNkOG9S?=
 =?utf-8?B?TnFiaWRVamlpN2hoWDFLUVl0emtRYXZ2bEk5a3Irb3NRWlNhRDFwcE1aR3BY?=
 =?utf-8?B?U1YyVjJHYnFPQ3I4VzF3U2hCV2tPWWF2RGRUdlF4SjRKcW14OGU2dHNUNU54?=
 =?utf-8?B?dlpNc2ZDMkhsOUNHb3hHMlZLVC84K1RRUURSb1VhRTFRMzQ3Y21YWkZrWERV?=
 =?utf-8?B?OGFSVGVLbk5rZVM5ZEcrZDB0UFFGTFhGTnFya1huZ1RiYS9TZXdTVnl4RnFM?=
 =?utf-8?B?S2xxUHA4Y3NzdkExYzVZT0FPZEVlWGw3eG9rZGovNE9PUEl3VSs3Zk1NYkMv?=
 =?utf-8?B?WlRSM0hJUjhlYi9YaE4xa0lVdlAyR29FODdDL05MeW5WOUVTemdsNlZ5SDQ5?=
 =?utf-8?B?eGhkUXloRWFjSWlQejl1UDdqWEd5SVUzUllhV0FSZnVmTFdSM3BVd1RELzln?=
 =?utf-8?B?WGtrWHpRbmdZQlFwT2VpcTJibStJTXVkMkRISm1ud1JwQ2t3KzcrdWtndGJn?=
 =?utf-8?B?Qm91cHYrYjlDeHJidTBkb2FSQ2NKd1lpeS83TFJOaUUxNHVmalFJcGl3SzhO?=
 =?utf-8?B?V281aExkaVVWdHFieDB5b0xlUUtDM2JFOGtzMFFxakd3RXlDbGI5RFVNUmp0?=
 =?utf-8?B?V01qT2hSMlBHN0wwQ2pkOXN0QTBtTTc3VzhuME5rTTRRSVoxSkpmZENGMUI2?=
 =?utf-8?B?T3dIZFZ4azRvNkZTVEdCTzFKS0JhbWU5NnpkQzBTT3crUnJiTG1iSWE3OHBE?=
 =?utf-8?B?ME9oL0FUKzFJcjdWUGUrMFY2dURUVkhkMW9TRzRmNHJtZ0ZXb3E0dk16aFZ2?=
 =?utf-8?B?b0tadmVtWVZaSkIzbVlwNGlhVUFZalhsejhqcmdVdUc1Z3lUdDlFOEpQMnRE?=
 =?utf-8?B?OFRjU0lucCsydm8vUmtLRGtkc21wdFVNTi81UTFBdTRCUDNtTmtCb0h1RXov?=
 =?utf-8?B?allZL0VHeGsvQVNFN2RXU1VUeUVtWVBhMkVSK2pQVzE5R1d1Njdoc2tOYXFL?=
 =?utf-8?B?V0p1SXRqRitYZTJicDk5eFVTNlBMQVZmaERTUzZTN0k3cnV1dk9QNG9PWnQx?=
 =?utf-8?B?d0FPM3piM3JHWGpjUXRwNzAxSXY2N2kyWkYrWXdEMXJSSzlXejlzRVgyaDI0?=
 =?utf-8?B?RmJuSlNtZElvVlZ5VGVvS3VXUWFjeDNMS1NTTGZ5Zk1OVlRRUmFDLzBPaXR4?=
 =?utf-8?B?d2V6VE16YzA0YkJvb3FSOWZpUDlPVDd3bFp3VUFLeEdNblpiNHN0a2VYNzJo?=
 =?utf-8?B?L1VwdjVTZ1FhQ2RPQStYakhwc3FFempWOGJxUVV0bG5TTWdYNXZXaG93d240?=
 =?utf-8?B?aTJPVFNDSzFyTG1jQWJRYm9veHRWSmhUd0JCYUZWOGlKdTlibFJLVCtuQWdS?=
 =?utf-8?B?M3VNVy8xR3dBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTVoM2xSdklIek1kSFp0a2V5WVdXUEFhQ05DQkVkdW05MEFmUTYybUxLNDZT?=
 =?utf-8?B?OGN6UVRGclRYcU8xT3RGOHA5TUY0ZVJTZWZocmRUSGo5SjY3TFJKRFRueGo5?=
 =?utf-8?B?MWd4cVM5OC9lRmdjdGoxNkJDRHpsUm0zb24rMGhRcnJlTFE5dE1GNXNkRkpr?=
 =?utf-8?B?MlEzU3dJWTFZSC9uOEE0RVp3UTAvUVNwZW5KSTFUMUlxNTMxSVA1Y2J0cXd5?=
 =?utf-8?B?c2swd3EyUTl6eU5qZklyYmVYTEUzbGZBVkk1T1RNdVFxaWtaOFpqb2ViVHlS?=
 =?utf-8?B?QVhoemlqcXZlelBYOHR0K0R2RUVLdXdmSGR6WVpINVFJVEJKNnliWG03eWcw?=
 =?utf-8?B?NStqRjQ3RUxQTjVja2FnMmxVS1J1eDZkb0tmK2xQOS9yRGs1UExFeTkySVdh?=
 =?utf-8?B?KzFDNElYckIvSDMzSENWYTEzTHc4d0JwQ0NMWXZjTXczUlhQYW1MWE1weW15?=
 =?utf-8?B?QUJZd3RWdk00N09Sd3djWVA2WnlxUGZqeXpvazQzaTFydlpmL1cvazJQTzZt?=
 =?utf-8?B?ZUJ1QWlQM2tIRHF3SkVXeXBkekxRTEZ2R1dYQlNjY0xQWGxPcEFrQ2d2K3NY?=
 =?utf-8?B?VG91SENpRDFNeTFaRmpDd1ZXem9TL2JyNXFCK0RMQTdWaXgwN0JpSUg5N2hD?=
 =?utf-8?B?bVprdnhtWDRCVURYOGlKTkZuYXo1bEdvNGZ1bjZKelNsYXZBZ3hHUDZVVS85?=
 =?utf-8?B?WVYwbWRIMVBzR09KNWREUzhXUWpYNDQ2aDF0c3NRc09LWXpwQzdEakRjMW5k?=
 =?utf-8?B?LzBkVHBsTDBxb2lLQmJIeHhzdGNUb2lhVTVvSmlrZVpMQUtLdlFISXJmc29M?=
 =?utf-8?B?a0tneUNqdVpXZGZ1V3VWOHZ2RS8wTncvUmtCRTNTTFNSZnh2ZmpCcFJzellD?=
 =?utf-8?B?YUFtVmFIR3ZrTVV1SUpNbE5ITldUOGlPKzJORTBhMGIveWdkdFllRy9HTWtY?=
 =?utf-8?B?a242QXJrUlFHZHFMUFIvOG9tU0dURkNJbEZIQ0Q5ZVVtWVBicS9iRzh3ZSsv?=
 =?utf-8?B?Ym12OE5GMG11S0VqZUgrYnh3OUVYRklpNGwybWZNV2RLNzd4cGZoVWNNQjR5?=
 =?utf-8?B?T2ZMY1ZSeVgzZXN6azlYTHpxNFFLcTNXOXFQQmxZN0hFdE9CZE5Ed3RmN3VM?=
 =?utf-8?B?QTJLRklRREtSRThvVUlwcGVlbEJQZHFINUhYWUl0aUp3NG5oMExhSmJFNWNH?=
 =?utf-8?B?YkU1Uk1Qa2p2NHM3TkJNMUNkQXRraTg4dnRnekR6V3pXL1F2NzdvdEJNKy9p?=
 =?utf-8?B?WlhhcSt3aldHeUVxUThWSldZc3dGdTVqVTcxMVFkRmFiWDh5T1RabE1Da3ZX?=
 =?utf-8?B?emxQNHV3OGpJZDMxS3pDSUVCK3lwOFZJTHh0bDJvYnVkNVBkanIyNDl0Q0hM?=
 =?utf-8?B?b2F1am9kM2ZmTFFUNE50dXcwR1B1WXYrM1MzWjdobWFCTlBqQTBmZ0JNZ01D?=
 =?utf-8?B?eUFIeXF2TTUxWGRaUnZhTHB0NHc1VDdqV3lUTDBNeXVZc0NRV1oycVVLQm1n?=
 =?utf-8?B?eEFxbnZQN3JTdkY3blRJcTdMMXJMdEZndFBoRG82VVVqR0RGbWo5YnVNQS9q?=
 =?utf-8?B?SVY1MFl4V1FRdzRKUjh1cnBzMnZvR1pPcUQ1QzJEcXdxMko3Z0FEbDk5VUVw?=
 =?utf-8?B?RGNyZVk4R3JYMDJyS3RmaXRrTkEzNHVWMXV1K1B1QVN5dEE0UE9WR1padC9q?=
 =?utf-8?B?UkhZYkk4a0h5bElGcy9UdGNGNHdkRzh0ZHFlS05IVFhtQUZyNlpUNlFsTEwz?=
 =?utf-8?B?eFMwalRKRWt4L1FMQmo1eTdpR2tHMUFlSlBIOEovTXNIRG0ydVJuNjh0WE85?=
 =?utf-8?B?RmFqMnYrcHZseWp6YXd3ZERqdGZVV1o3Ym9OUE9USVkrekFFYzdhSlFIRlB0?=
 =?utf-8?B?SEkyd3VvVmtQZFk0ZjFYN1BVOGsyeU8rR2pYUlNCc3pOR3ZYdnJJUzNRSU43?=
 =?utf-8?B?UW5iKzVmeGN5TTRqUE1OTm9Da3c3VjRoODBHRERaNll1bUg0cWRiWTRaQk04?=
 =?utf-8?B?VzVnRWdyZ1ZNbmlDbVByYm5LS0YzSUlEL3lkTXQwMkRKRERmTkUxTjh2SW5t?=
 =?utf-8?B?U1VmcnhkcmgzeFhNTFQ1dy9zTTU1ckZEUXlhc3ZZWXJnYUZXTGZxbG9wTmw4?=
 =?utf-8?B?UHlXdVFmakhIcHBXbGFnTm4zanZFbEVyYitVTGFyeUQ1RHplOXJxK0kwenJI?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8035e2f0-70b9-477a-eae8-08ddc98d701c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 02:05:46.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcJrsgnABixsDFLaEvjnFjuBhdIW7+EiEFQN6dRGwfteONe1l4b7Zb/SasRFWonzLUL5Lmjf3yI07O88VacK5OVDdkqiEJ/L3zCV3Roh7wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8373
X-OriginatorOrg: intel.com

Hi Babu,

On 7/22/25 5:26 PM, Moger, Babu wrote:
> 
> There is no redundant text now. . Users can look up about "mbm_event" from "mbm_assign_mode". Here is the complete diff.
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 446736dbd97f..01c33f62ce74 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -434,6 +434,12 @@ When monitoring is enabled all MON groups will also contain:
>         for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>         where "YY" is the node number.
> 
> +       When the 'mbm_event' counter assignment mode is enabled, reading
> +       an MBM event of a MON group returns 'Unassigned' if no hardware
> +       counter is assigned to it. For CTRL_MON groups, 'Unassigned' is
> +       returned if none of the events in the CTRL_MON group or its
> +       associated MON groups have assigned counters.

The "none of the events" could be interpreted wrongly with only one MBM event
being read. How about the last sentence as:
	For CTRL_MON groups, 'Unassigned' is returned if the MBM event does not
	have an assigned counter in the CTRL_MON group nor in any of its associated
	MON groups.

Reinette


