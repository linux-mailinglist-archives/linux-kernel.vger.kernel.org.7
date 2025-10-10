Return-Path: <linux-kernel+bounces-847762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 510F8BCBA13
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42F5E4E31F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A42D1FF7B3;
	Fri, 10 Oct 2025 04:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdLxDCFp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32911E5B70
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760069960; cv=fail; b=h9iPcMN15DaLYvHTt6QCkXxzpnRMM5FF75BqhvPBED6KJf0ZSs19XD5D17324SQFxGo+2eyULZLQOOk5Qpe0no5EE3mrmoRJ1VtyVHuGxn7kGCkp8GlHgd082GjEOMM4AJc2L7z6qFVHkPKiwoRwajKSnDB6EEx2Yn3XS4/wkvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760069960; c=relaxed/simple;
	bh=NpZIukJnfWpnnre4qq3/QdJgj3eLafaNJOGANcSqVro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lI0Ij/r8LzHSPlDnxqq3oaWa0wIPTUXqedy/Y+CwqMuRmJ7CZhFVOUVq4BKXF5op6K54qCfA0u4UhXwAVcDEuQMsjJExh5o9E7mT6yCP8rzayO7qH6lhwo8kNTWLdbCBTthon4O328rA6ewgadCNB0h5i1IGMct7rB3c07W7Z94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdLxDCFp; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760069959; x=1791605959;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NpZIukJnfWpnnre4qq3/QdJgj3eLafaNJOGANcSqVro=;
  b=SdLxDCFpcvXV6zVKUHHh1mpc2sePq0GFnVzDbNj9tSxc79I5Q0L+Qx8L
   BnCVOABorbS7QYlpTGHthHbRgwmYNXN36OrMVeBngPmjhOWVfGH9pD1Lm
   NmMYxzgbUKJdcaxx4+23Ubp+PnFx7OmM5IwTE9we2hvY00/86y2iQ7zOX
   wOjsN6CzU41S5TX49+v5hr84PK6Pkqgoi36ccMHCnBdKhBDvkSQqcsvar
   BLfBZ2U0HPX9UeL7o9uJDQbvzsl7OvR60rcRKRnragYd8BPZcEEju9S4b
   4ReRFwMiknxLlhJarP9dRm7puspWieUOiX1dZpbXyxLJdYD2qQLv2xOWO
   g==;
X-CSE-ConnectionGUID: 0gw2cIlnSAOnpo4TRK4LYg==
X-CSE-MsgGUID: RFeZKu2hTZG6OXXDQ7ZAFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="65938877"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="65938877"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 21:19:18 -0700
X-CSE-ConnectionGUID: hdg1ZGQkQeuIrJecBcaMZg==
X-CSE-MsgGUID: G4AH0/7cSB+l71Sp0yoR5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="185134315"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 21:19:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 21:19:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 21:19:17 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 21:19:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCEVaf1oM4v7OTFxVqctNvGDTKRIwLJRv3JBJcD82KrraVrJZUjvdBpsNaHN0TIxffcOZJACSTdGPJFDbmG1a471dhWFZDv2k218FgVSHGaQaFYw09OH44NFq52N+7ILJNyQGHwTEfOSRA/p+df/E82PMaACa/755GBehlqY8cFx7LG6w/0v3n4iiO8yulM5etXDhMstaT/gJZFeQ3VMARNFhBvzE8t4ghQFzvBTGSdHf9Ru0NYcw96WJq0Q7fRXBZ0Jo/BFClh9KJI5Uw3ej6eL9hxWQJmrPgp+Ka6cPbTdz35toF7jmPkmgSwOTZ3utk92rzyGRm++S0abTT9yHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0YlY+BYgL6THyKSZrg87zu9qWIITmw94TO6fL5UoXM=;
 b=Vw3C98lITagX0WNg6nl/0TuMcvg0sud0uJwprsy25YC6KpdR1nBMR1y5cUxULV1TfZ9W1dl/lkV5t+5HEeRBdqrq4z+0TI92s2YFPIrjDojfZK30WOVSKs1st3KydtleJmSVn+tEFIxV+O8rnCABhwuyzfg8ciCkr9urMPyxxtpSxjbw2seQr1brq8V2OJt81V1Kv4YyzeB4CA2p4OnbPZVCOX/WXBXbjcTNSWf55JjMg3G3nVdCTiR6e9cjdI/Sli8oPfTjjQYkUBnKfgrnyucjUBn6CczQ0nniArJ7O1OSzgguan6CfMhDU5y99VlKUqBLmnFLVTlPSzpN4TjNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6614.namprd11.prod.outlook.com (2603:10b6:806:255::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 04:19:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 04:19:14 +0000
Message-ID: <3c428de8-f8a6-47a1-a5ca-768d1906ed24@intel.com>
Date: Thu, 9 Oct 2025 21:19:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously Unavailable RMID
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <8eace6e47bb7e124ffb6c10150d1b7d38c2f5494.1760034251.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <8eace6e47bb7e124ffb6c10150d1b7d38c2f5494.1760034251.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: f03c58eb-61d0-4620-11f5-08de07b42bdf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Si9QcXAzd2xJZnlSdUxSRDQwT0tmdmVCeDJjRE5ISWNOdlhpS0hiaW5BMzBP?=
 =?utf-8?B?NlJYMlcvejgyeXNOTzlHUVJJMWxlWXZyRHNxMU5IQWdES0JOemJ2bHhaYzdZ?=
 =?utf-8?B?RDFPTWZ5TU1Ea3ZmdUlINjllTEdKVllkQjlCRTRqdllZUVNLb3BqZFhpTVNk?=
 =?utf-8?B?c2ErcW5rTlorTS9DNTNiQ2xrYk9vejduQTZsSmkyRWUvNGR2T0hubkc0V3Bs?=
 =?utf-8?B?WTZKbkIvMjM4Z3Q2TG02V2piYlpJTG02MXZtdlZ0ck1UQWp3b3Q4T1JJc29v?=
 =?utf-8?B?ZzFYYmgweWNqQU5rVDZTNHNQUno4a1ZZWEI2WEgvYTd2elRMZVFTNmxHS3pL?=
 =?utf-8?B?ZFkzQ2tseTdzZ2JnTlJZUFFYbWNrV3V6RXJUTEpVYTdUN1BwMEc0MGE4UkdR?=
 =?utf-8?B?MkQ3TkQrdDQvYlpxK1poUGZLZ0YwTm9BSHE4V2dxSS84eEtJK2tsbWZLRi8w?=
 =?utf-8?B?MmUreS9LYTJHQnBiRVI3RjFCYVlnYjFxQ210cmtVd1cySVE2b0dVSjVyMkdS?=
 =?utf-8?B?bmlLZXlaWkU1VkE1eWpWUWU0b3JDdG5sMmJKVWxFV21mMWF5ME03ZG9jMmJ1?=
 =?utf-8?B?VUJGMlA1OGNWYmNOWVBCRVJNNzFmRXY3OFcvK2h3SGlvZisxZkNmeUFXZnhZ?=
 =?utf-8?B?bHpremlXVFRZYlQvWDNVdnhrTllIbUJhRGVTem5SWXlnWlhka1FOYjZ3eC9Q?=
 =?utf-8?B?WVZRQTErOERxUWZBQzVpcmVQZnZJd2FldGxCUWc0dXhhSWh0VDRpMWhaajNq?=
 =?utf-8?B?dG1hcm5lUFJWV2lPTTJrckh4RXcrUVd2WjZucXlOMFFtYjBOZ01TUUZyalJO?=
 =?utf-8?B?bktDR1VpRVhxZWFkcTcvR1ViSjRjRExDWm5oS0hzL1lKbUxwVWR1Sktqa24v?=
 =?utf-8?B?RE41TVFYbGtBRHBxUUk2RTkyNmFKYWl2Mmk2UDlPUUErSjNjSldCSTNHeTNj?=
 =?utf-8?B?VDJicjljbVdyZVR3aDYvVnZEMmRFcTdqM1h2Sm5NSmhXeEo5R3M5ZjhxenhB?=
 =?utf-8?B?SUd6ODk1RFNRT1JpQXJWZ1BDck85bzBheHBGZmR2eXpxZkhnNHoyaXJyZGE5?=
 =?utf-8?B?NjdLRzlkRk9WUnZkWlVadHA1QUVCeS9LMUlFSnJSZXlkREcyc28zTVgrWmFM?=
 =?utf-8?B?eW9nOFJPRjQrL2l0a3pqVHBCdjdkcEFKdko3MjV0b3RIYzl4dFNaZWxpTnZX?=
 =?utf-8?B?dE5XZzBYZE9MdkFaWFJwUTc1UHZqK0R2K1RIejRSM0ZHbzNRUHFTNktnbVpy?=
 =?utf-8?B?NVVKRS9oOG5DZHRTV042a2ZQb2YzNTE0enI1ZytLdFFsUW1aRkVOeFVLMXZw?=
 =?utf-8?B?YURuYlJIQnc2blpPd0lRNTdnclp2Zng0Q3g4VW5QZHdSdXZlOFkzTlBzZHZz?=
 =?utf-8?B?QWprLy9jRm14bjVNY0grUGkxK1dZYzdCL0h1QU5MZVFkY0tTcjN2ejZDMytC?=
 =?utf-8?B?TEt0UndxdmRFODlqU2t1blNtdjJvYzFCV2xGdDRvSUpIZG10NWEyVG1zWWpp?=
 =?utf-8?B?K1ByY0NZbWJWVC90OFJpSWNndElCMHA2OTNIelU3TzZCbFNZeDFqUVg4ZzNh?=
 =?utf-8?B?UW1qWEVwb1d6Vk9Fc3ZFUmRoaE9iQXpVZjg4dlZ0dUFnTlNRUGtPTTdtQ2FV?=
 =?utf-8?B?VXhhdHNJYklRUlNPQVZHRlhzajlUeDhGZG52dUZhOXd0Q1FpSTJqek1maTZm?=
 =?utf-8?B?b3dFSVFiR1JiSzltNkhnT05abDMwZ1c2ZkcxenVkTG8zNG1ZUU1RalRKck5z?=
 =?utf-8?B?TE0vQ0xtUmJwMVhwTHFzdTdxL3NjSVJ1UjNzT1B6b0h5UFJPTm4yNmE2NWNQ?=
 =?utf-8?B?dEx3MWdWcUNlWlc0dVBqQ1lQazl5aklYcEt0MDFnTUVBUzNGMnplVHlhQ1Nh?=
 =?utf-8?B?U2hwYWhtQWY5b0dUUnBncGZNK0hIR1hZRCs5akxwYmtSWGR3ekZqZzBiREVv?=
 =?utf-8?Q?/HLnIWfXurj70QJI0hvKaBI4EDSnPEBJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZNVHp4QXVjS1oxRFM2RFRDR3dRTEFCVHV6RU41ZUJKWXdQSVpUeU5VZmpT?=
 =?utf-8?B?Nm1qYThqckFKNUdLczhqSFpHQllONGY2dk54NlFCV1pyL0xpNlRtL0U2R0tM?=
 =?utf-8?B?VEFMNURHTVlSWkEvaW8velhnMmExNWxNSzZDMmNmS1pxL05ObU51ZFpkUlVl?=
 =?utf-8?B?bGtYb2V5RHRlMzVOT2JkTkxBa1hEcFpvSTdNT2Ywek9UOEtjN2ZCd1lES0xz?=
 =?utf-8?B?b29oRWJjTXN4KzZxZ0MvbXBsRGE0d2ZnNEUvUFI1eEtMZUpoMU00VDFWNXg4?=
 =?utf-8?B?RHZKTVlsdFNQQ0NlZS9CSitCT24zZ3RjYjBBajFJUURIYmxRaXBHb3BPRGls?=
 =?utf-8?B?QlluK2JTUVJFMmdvOC9yaDJyTmFkcUJ2ZDFSSUQ0TG5jbG5jVHUrSW85WGNG?=
 =?utf-8?B?Vis5bTcreStSVVNHaXRGWDY0d09YUVdBaHdVMmVkcTE4ckhLbzJhTmc5ZmdN?=
 =?utf-8?B?S2tSbDRSMU1ZMC8zN2lVcmVGSjYyR1F1Y3NnZk94aVNKU3ZFbGxxNnRBTnZI?=
 =?utf-8?B?YWxaOXlMaEtncThUZWNOS29SVmRnVm5jcXNJeHA0c3JQNkk5UkRWRUJjakhi?=
 =?utf-8?B?UlNLUjM3U3BuUU5qZjNyQ0MrZEJYNSswajVnUmFiV0ZqQTZoTHlNMkRsb3Aw?=
 =?utf-8?B?QytHd0laOVNTU1lqR3NhVDJLSmE3QmxLN1BnZHhxMWMyWGZiR0tGYTlMais5?=
 =?utf-8?B?cENDTnJSU0lWZGpyU1hCUVQwbS9WRGg5TXUyclgvc0t3MmlTSG9qWXJsRVFY?=
 =?utf-8?B?YWtjVldGNWp4bWp0UlNnRmUweDlSRFhGRUNWN2ZQekkvaHRlTm1uN1h0QW5s?=
 =?utf-8?B?dHNaRGZxQ1RvM3JiNXdMeExiZE85VWRaSlQ3aUJUSk9aYTNIckdpcFNxeXdP?=
 =?utf-8?B?QU14QTI3WFI2ckpGclZDQnRpYm1KMVZSTjg0Wm1EQ1ByQS83MzFCd3VRbUM0?=
 =?utf-8?B?RmVSSkJydGV6VG5yUXhSaDhOVXg3YmxEb3VhaThsSXg1QXB0OVdlYjQwbFFN?=
 =?utf-8?B?S2pKcGRPNlM5b1BIdlZDTVRCSDR0T0cweGdRdGZvR1JPZFg5VytUT2drdzVK?=
 =?utf-8?B?SHNZcW1ORG90dnI4VXJ5UkZEVFY0K2RobmpSWmFZSlR5L3dDYnphRVhyZmpP?=
 =?utf-8?B?WWtRNHRndm5xR3pKWXRVNmtvazFsZmI1VDBaUDJwOUxpengyVjcvaEhxL3R5?=
 =?utf-8?B?ZjdHQ1FkTVJoemU4RkRRb2doWlBHU2pubStNd1FYc0Q3b3ZxOWZGUnFNYlNa?=
 =?utf-8?B?UjNsb1pUN0QwMVpFV3lLUWRPUFdhcmRhTU1keURneVpzT1hLZXJNNnBrQlEz?=
 =?utf-8?B?M2w4Zno4YkFjQTB1SEhKUnRSV01ja1FocHIrZjRQMU1LUVlwSHdHOUphaGdG?=
 =?utf-8?B?Zk05NkhUakNzWDhQVlhyMVRKdTdUN1FHRzYyMlkwQjI1SG1QK0JHQVhBbWt1?=
 =?utf-8?B?YUN3REpRM2VTVGZwenAyaXhiZ0dXUXZKU0dHSmRLS1FwRVRTWTFZSG9xbS9z?=
 =?utf-8?B?Nkg2Q3owWlRLNXd6RUJCREZ0dko1enFjL2ZWS3BuQUVJVFlNNll6UllFMXFs?=
 =?utf-8?B?eDdhU3pEMDg4ZmNoUFBWS2NQWmcvMDAySWZSeVp0ZklqVDBkZmhXMSs4eFlC?=
 =?utf-8?B?Um43TXFqanBnNkFBd3JQYmNBU012dmdXMUp1Q0tvR1h6OFNnQVpUeHB2TGhk?=
 =?utf-8?B?anQ3azc4bkR4QVd3U2pnQlhjMEhNSzVmenZCZzNWaUsvNzkzdTNKVXRnL1RW?=
 =?utf-8?B?dHBoQmRFY2JmUk9pY0t2MzlMTzZlbjE5Q1Rsdk9ZYkd3ZUxZU2xtbTR0VVUx?=
 =?utf-8?B?V2ZNRWlEdSs0MWxPZEJiQThiU3RwNEphNXNpaWVTekRtYjc0ZTVKeWJiKzk4?=
 =?utf-8?B?VkF1NCtVRlM0Rm54RVRhcVI2TjlKVDF5cHdnR3hPTTArNTVJSitqTm5ObWdw?=
 =?utf-8?B?a0RmcjV5NE5GanBNMVFrWDVqamF4Z3FUL0JvMkgrV1FKVnJUTWJaYnFUd1pL?=
 =?utf-8?B?cks1eHlSWHlHc2NFN3l1STlLUjdCTG9DaXQ3QTBCM0dxSTBFbkUzQzJ2ZC85?=
 =?utf-8?B?aDZrcUFOaXV5c0FHb3hUTDI2NTQ5cVNYOEtmRzFnaS9jcmQ4WXB5N3Y5Qzlu?=
 =?utf-8?B?NFYreEMvY25rV011Ujk4a00yby84WXF1TVlXOXUveXFNZTA4Zk91aUNlZ2dx?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f03c58eb-61d0-4620-11f5-08de07b42bdf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 04:19:14.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+KWVUnpnV9UP/9WZcxbP7dMKjTG9e764KrW9IRQwQYMnggb59aZNNkvzpjByamt6/dDTdTiZaZTWRRAKz8JMySW0hlBPsx6Gqfb+1wmXGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6614
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/25 11:29 AM, Babu Moger wrote:
> Users can create as many monitoring groups as the number of RMIDs supported
> by the hardware. However, on AMD systems, only a limited number of RMIDs
> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
> this limit are placed in an "Unavailable" state. When a bandwidth counter
> is read for such an RMID, the hardware sets MSR_IA32_QM_CTR.Unavailable
> (bit 62). When such an RMID starts being tracked again the hardware counter
> is reset to zero. MSR_IA32_QM_CTR.Unavailable remains set on first read
> after tracking re-starts and is clear on all subsequent reads as long as
> the RMID is tracked.
> 
> resctrl miscounts the bandwidth events after an RMID transitions from the
> "Unavailable" state back to being tracked. This happens because when the
> hardware starts counting again after resetting the counter to zero, resctrl
> in turn compares the new count against the counter value stored from the
> previous time the RMID was tracked. This results in resctrl computing an
> event value that is either undercounting (when new counter is more than
> stored counter)	or a mistaken overflow (when new counter is less than

Since there is going to be a respin ... there is a stray tab above.

Reinette


