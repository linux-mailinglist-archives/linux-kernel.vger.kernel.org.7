Return-Path: <linux-kernel+bounces-751271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AFDB16721
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B077B6C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E41FFC46;
	Wed, 30 Jul 2025 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/cqypFN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01F2AE74;
	Wed, 30 Jul 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905183; cv=fail; b=TkDWAuyh+UdBx6uMgwFcuTs6ksQimtQ2C5fpCp7ba/re4b7ccLLJVTuPn6pLg30YOgki9NIA7pNqYOrm/sy+6ToerqeUv/y9feh2LJ2VgUCFUheyGEDCLhHr2g/HlasE6wAv6FV6er4rwQCm0XqDx1LMZ/fg5DdQN2F6b8vUC04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905183; c=relaxed/simple;
	bh=tgaMzwRF2hgZVV2HXBqZ8OuMyD7AFLvi3ygkUJ/WTCU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cFqRSQ9zLF0Byq29Mpq83mA2GcMnQrCA2yPSn+Am3kaVL2j4xUhkYQbHLCgs4f+Epe4doaWLzEvXGgxwBCZmZ5F85O61GNOPrU8fM8FXWw1LYrfpND48039bf5qe6lLt7UfYyNgV0XNspH/nVkd826UurTiPokw5ozaWqm0kxnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/cqypFN; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905181; x=1785441181;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tgaMzwRF2hgZVV2HXBqZ8OuMyD7AFLvi3ygkUJ/WTCU=;
  b=k/cqypFNKciPwSIumHAN7q7IlC+/Xtiz9v+5TZPh/HqgMpfQaTteThh3
   W1CPNZycGcg0hxEjgZmGRmgIEgkqK517cVWEWl+zYD2yrXG54EQRQ/M+C
   luSmMx4F9XKGDGIYAz5iupH8Z5ktQzWx/vcJ2OGez2y+KPnN5LUT9VjGr
   AB0ULSIfNgMJyvBjpm+FrEvmHWNFUIwmmy66TZ9R9OP1hjGiCZJSf09sg
   EdR2IGpb2wpJkxZVBEUp04yZVmSEH6w7SOwV3njRyMDHVepmMhfRrq8KR
   9Tuu9tO7FDfORjU7qRVrYp+siM9Sw+TSrioPMFuZsrsLJiXbMgAATFCFh
   A==;
X-CSE-ConnectionGUID: Lu0naZ4TRvmZWGM9xI5STg==
X-CSE-MsgGUID: 4BvFdGXBQr6d+EbeAkV0ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55919138"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="55919138"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:52:55 -0700
X-CSE-ConnectionGUID: yVO2TXRFRUav3gtLiqrjbQ==
X-CSE-MsgGUID: g0OHFA5qQUGVy9cLqA86hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162353759"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:52:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:52:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 12:52:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:52:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8mTP9vuSls4hEWtjD0By2F5ZVkTMu8nvv6G9V8H5r3AHMWcT7Fi2lDInlNVkT3c0fQpuFHmD1r2FBxqy0ALnMYTeMKOzB3Uugee/iqYMyWlUixCulfKtJ+6/bmol6OW/aKVJjyez5WwC+V4f2kdCLvn2DKoSgODFTIY8PLE0EAVp+FWFaimBN+eb27eZmFNF+ejJgnh1La8BeLiSBwVPWv4Zt6fg5GwPlMm22b2UWafBpXBzIRm0IG+IeIl0+B/3C7M8ls9JD6eFiYSB713dqFWr/bl/QGmEL5a2bYsGfOjxH73wpjfWr3IVyS3I1YwmT5Bl/svvtJURaXrsEDEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAtjJQ2A1QnLSGwAphdzD/ZimZ3/NMVCcLbDq7xLUm0=;
 b=w/BvuaxJJL2EXhp7/n+K+lzwuw/kyMo2Er8HOMckNmbVtHhJ7Isg0z57iOz3kCjw4hX/uk1seg6cEY0eqMJddZEQ4jLfE/9lcbnKc/yYMfiTmIGNs8TkGQml74mNdMFn6la+sqxXPPahIQ9sEP9BWh5e6OS33yPFIDBFAsomEBVjxStD8pbCElv7jY/cJtJNlrqzZ9fpqG2Pj7ApwGjZdxLoVIr0/wfqzY7h4RN3lgIprBUrxAx0efCCfjMz/YEizC3+v5vai7c4rF+XEyNZnv3G4pITnrtNOYQJhREUppg/CrYwzl1t1/V3dVi1vtyiWrc6bKskE58DHwl0KtTE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL4PR11MB8824.namprd11.prod.outlook.com (2603:10b6:208:5a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 19:52:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 19:52:20 +0000
Message-ID: <0b906083-8579-48e3-9f73-4d80c327a30b@intel.com>
Date: Wed, 30 Jul 2025 12:52:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 17/34] fs/resctrl: Add the functionality to assign MBM
 events
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <09e6eb24212047908127b8b9fbd1673d6892cad2.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <09e6eb24212047908127b8b9fbd1673d6892cad2.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0321.namprd04.prod.outlook.com
 (2603:10b6:303:82::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL4PR11MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b92370a-42a6-4484-3a31-08ddcfa29802
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXFPZkwvaGNOTzBvL3BRNTI1R0FhejB6M2pMTHh0VWxTakRnZk1uK3dBM0VF?=
 =?utf-8?B?TlAyRXZraU1ubjYxeVFDRHdiUW4xRjliSW5vUk9tTEtOZFJRVEJnbk5JbnNG?=
 =?utf-8?B?dUhpcnFmYUtFTzdrWGEvYkdHMFRDQS9XbnlJSWltVVhWRmsxc1ArYVA0dmRr?=
 =?utf-8?B?WU54Y2t1dDRZeGZMQVkweHJrY1ZMUXpJZmFzSW9IdkxRckFSZFU1MEZwQWRJ?=
 =?utf-8?B?UWs5T2xZRWNOdzY5dDljazdtWjM5MWR0eHhwVmdZdlZYOW14Si9LMWFXdHZR?=
 =?utf-8?B?TXA5RFlLdEQzOTA1VDg3UDM3QkwzMEU3K0h1aTVlbzhBeWwzZGgzNEtMY1N2?=
 =?utf-8?B?cnpIWHlZZlplYjVnNDgySHZZcXFaQ2RsN3dxK3Y5dHE0TGhTc2dGb1d3VW5i?=
 =?utf-8?B?Q1dWUWJCOVdVZmMwZHpMR3VwWHlReEZnc1U5MGRlVStlaDVmVmlEbkVIejh4?=
 =?utf-8?B?MUV3blpBSTVLanZOK0tWNHJydlNVWTkrRDZnVFZQdUFrY3pXaGpyNEJkOWQ0?=
 =?utf-8?B?RFBLTVplTk5uQ2hNMC83MG1qTzdadEo4WDZPYVNiQjVENnl2cndlRHpDeFRC?=
 =?utf-8?B?dll0SjF3V0tiRGxvNEhnV2NIZXI2dlkzejE3ZDJoSFFSWGkyMmtwdUlJUXlJ?=
 =?utf-8?B?dXNqcDkvTWJ3QTRjTlFsNFR5VW9MZExFY01rR0EwaHdPZjVkelNHZ2dOemR5?=
 =?utf-8?B?dXJZLzBWZkUrOVpLWkV2RFhrNnI0SFRMRXlxM09NWE9mS2d3eGg5UDNTMWlR?=
 =?utf-8?B?aDh5eHlEQjlRdzB4K00wTnd4YXd2NHA3ZVY3WW1XWjNUTzdKL2s3RjU3b0Rx?=
 =?utf-8?B?dXJkTmFSaE53VlBINGJTRGRSL2QyODJLcGdjcVRuTUFaeTF0QU9QZWVqTnlD?=
 =?utf-8?B?TEtZeVJkdk9GZytXdEdsV2U4anNCblRCODk5VDY3Y1J0MWRzRzFHUWJHMTFV?=
 =?utf-8?B?bzVaTTM2TGdhd3dyMDIxVWUrMW9xcCtteHFzUGZ3TDJTakI1K1ZRTVNKU1ZJ?=
 =?utf-8?B?OXVKM0hIeHJ4b2tQcmwvZUp4RS84RUtzWVhQeWhzT09KdDA5U1NONnNGMnlO?=
 =?utf-8?B?dloyYTlSWm9DK3lMdzcrRXZPQ3A4QkE5NnJwc2U4YlJ5bEJTeC9GSmlOazFk?=
 =?utf-8?B?UmFnbFZJWmlyQ3c4Qmc3UmNsU014SGhWUExScEh1eFdBUjhnMndiS2djQUpr?=
 =?utf-8?B?WXAwWGxVQjd2MXorK0RGR2phNkp5eHduRXg3UXhuV2NHOENTdDZubCtyZkJ1?=
 =?utf-8?B?cGtOTERIZ1RmcGhJYnFWZytwRDRSc3FBczRuTkpPRmZ5NXY3TTNoeTlyMmRz?=
 =?utf-8?B?Z1dUcUZnenFDVExSRkpJRHJYT1lJRHp1MXA5a2hQZXZvNWJac2N4NzBMTjBV?=
 =?utf-8?B?Q3lhVWtNcForRno2L0Q2QjVNS0FLTStxRWRxeUQ5cHlKN3R1MDQxKzJlcEVG?=
 =?utf-8?B?ak1WYVVUTElxNVZkdzYvdGVFMW9uMDgrcnVmRFUweklqbjFxS2tKUlN5TTEw?=
 =?utf-8?B?bDU1VXU3VXU5Wmd6TGdNU0dGeXBkaTl0VC9ocGxWNzFuRWxxd1puemxKS3hy?=
 =?utf-8?B?NmNqL05RWktYbFpIckFGTVRIRU9vbTNtL2p6M0xoclNndkNZdzYvQk15Sjgr?=
 =?utf-8?B?REpJWW90L25uR0JkWXd2UjlxejMybXFSV3RXendFV0QwN2dsTk84Ykh3b2R1?=
 =?utf-8?B?eUJpeHZRRmJXL3RyajEwS25YSDV3azQxUEE4WWIzU2lVbHNZUmhocFd5UWRz?=
 =?utf-8?B?VSs5YkJSRit6Zk80YWozcC9uMHNiMWQxSXhHakoySmNjQmM3dHcyS2pBcTlx?=
 =?utf-8?B?Ty9tbUlDSGFwdXorMkw4dzl4czlha1Z2MFQ0bmZnVXorZHhLV0FnQTUzWE9H?=
 =?utf-8?B?UmhvNkxxZFhRVWRxWE9mTmxMWWhTMXplV3dnMXFxWXoxdGd5VXBma3c3Zm5N?=
 =?utf-8?Q?iVXy5cPAAT4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWhXQ1VKbnJhb1h3STVCUStJbFIzTGRGQmpsZy9ueFFRYXNPNFNPaXpQb0Rl?=
 =?utf-8?B?dUNMOUM4blh1eDdacDZKTlM1RXZtRzRwSXhGWitzeFVGNDFBZVVIZjhwTWtR?=
 =?utf-8?B?UDNabG5FRzl6WEdtazZTZVBCcGR6dDRLQ2ZtQVNHKzh0bkd3SkFFNERrNU93?=
 =?utf-8?B?eUdDMm1XNnZJelRzdklycVdkY2JsT0VYYVJzWEM2YTlreTdSYWszRWlpalBM?=
 =?utf-8?B?LzMyVVhPVUxvSDVlREJRRUJnemd6QWFUcVRWMXk2WDRFelZBYklEbk1hWlNn?=
 =?utf-8?B?V3ZPS01XMEd5dDQ1Rld3aXpSZXhjR2tCMHZNazdBN3Y4MGpLUWRMa0lzb1kz?=
 =?utf-8?B?ai9HZk83ZGJmWVpTNmVkWWhDV21SUW1CNlNGTkRBandyWEhOWWc5K0NTdHlO?=
 =?utf-8?B?QiswaU9tZXRhUGpYWGluOXI1OTFQY0lkWDZUSlQ1RFN6QlVTamlXOFVQM2JK?=
 =?utf-8?B?ZTRMaEkxdlN5OU10RlcyV3R4NGFFNlhvMGdqRlN1bVBNSTBLQVNlT1RCNDkw?=
 =?utf-8?B?ek15eGI2N1FmRFRvaGF4cXlXb1NnZTI4Q0I5dm1ZQ09Gb2VuOHZDbFNtUGdj?=
 =?utf-8?B?NmFMNGJuNVZEYkpVMHRJMmJmSGlrK1VXQUpkRkRJYUFzSWd4SzBRWHpjdHhJ?=
 =?utf-8?B?SnZFQmgvMVZKdHZDRVU0ZkQ2Q29sK0lrQ3crWEhzWVAxdzVpcHZWRzJxT1dU?=
 =?utf-8?B?NFlmUU0zOEE1NmE0MVljZklVUzM5c2gxaHIxYzIxdVRhTnQ4aWlna1YyTm1I?=
 =?utf-8?B?ck1KaEF1dkM3Q0swOW05YTBKcFNtbHMvbm1DNWtNMU1JQWlnNDlvd1VNa3ox?=
 =?utf-8?B?T2lPZlJ6RGRkSGpobmhQaXkyYm9kUEhjSzNzZFRNblJCV0x6Z28zc3pnc2I3?=
 =?utf-8?B?OUtRNUdseVZKUW5zbmFSbmhEK0pkT0JMR2UzWDcxMTkyOVNXR3VqTEFMWW9o?=
 =?utf-8?B?L3JUWE1qVENjOHZwOWk1VmpRTGVtS016WVk3NVJVUVlwT2ZWeHpXcGp2WnZq?=
 =?utf-8?B?QWk2TnpkaHk1NmN5QndrSkIyUjNWNWN0amlSRmtUTk5rd3NKS0RUV0ZUeWJJ?=
 =?utf-8?B?TVA1S2Jock5WbVcrZEJuM1Y5TlJHcTVJOWNFNTMyYzU5TEpOcUkwa2EyTzl1?=
 =?utf-8?B?REk0ZVI4ekJERzhnRUY4OS9UOWF5OHpFUUMzdkQ1d3VVMUZ2R1VPUUVsdUk4?=
 =?utf-8?B?UU1SK3NOdVBKVHRBSm9odnFhM2ptbXBTelNta1RHYkloV29sWnlJQ0x0YXhW?=
 =?utf-8?B?ZEl1SEVSUk15THhQTDMyK09tdUE4ekErY3V4WnJpQXdIRU9vUHQ2azdGT3ZH?=
 =?utf-8?B?NVd5c1dSenRaa0xEYk8xeUpNa08rMnhIUzgrc05ad2VKZVdGVmwxUXcxLzNx?=
 =?utf-8?B?VXBGZ1F1TEpVSDBPMVdVNlpDVGxhZXhLbmtoNUdweU1nYjBEdjdaTUhLWGhi?=
 =?utf-8?B?eldTVkhDeDFmdk00OWJJU3J3bHhLYkNBdmN4aVBMQlYwTmRlZHROazk1VVQ2?=
 =?utf-8?B?SzloNGVOekZNNlJHNDE1aHJMT2wrRXUvakNIK0k4VzI4WVdvRXc3UzYzT3FN?=
 =?utf-8?B?eVVtSDY5ZXRkMFR0RnJkWU0wS3prRkJCWlI5NHFjTDd4VTdLSXhXdGRZNDlH?=
 =?utf-8?B?Z0lrdDRMVzFUNURqQ09IdDZvc3VzWWVaZ0s0WjJsQzVWTVZOS0M1SHJ2WmFP?=
 =?utf-8?B?R0JmM0FGM2xlVDQwYnFDa2lDNVJtN0pzYjRzZjR3ZDdZT2NOVksvM05ONGsw?=
 =?utf-8?B?NkthcDJDbzExcEdDd2ZoQkFOUmJ2dk05clFrbnNXWm5mNG9FV0NVSkFDcUtN?=
 =?utf-8?B?VStFYlBBRXJGZWltd1pQMkVzbzVPelRUMXhsNFpCU0I5MW85VFhsTzF4Ui95?=
 =?utf-8?B?S25wZ1BrR1oybHFjcFVNdHJxa0lnQmI1RERON0pqRjdPbkFDL2hLUnltcVA0?=
 =?utf-8?B?ZFhYQjYwZkQrN3VCR2Z1MjNHQjl1ZGNuWlMrSjUySkxTYkpKZ0wyMVcrbVli?=
 =?utf-8?B?cVdmd2JTRW1LMWxxWkZ0WVdobWdPNkpuNkJOdVRDVnl6QmtLd3RsSlVNOHVo?=
 =?utf-8?B?N2V6WVRIbmxlcWpjVXBwdFd0dTl2ay9nNW5DSk1YbC9tNEw2MDVZcmUwenlU?=
 =?utf-8?B?UVh4TmRyMXNSWHJpK1c2MitLUXFNWWsxek9ReTJHcEszOW53OG1mSXNmZG5n?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b92370a-42a6-4484-3a31-08ddcfa29802
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:52:20.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8X2LqD5LdswjoVuNrLky7vQMsWDjqfPO7PgM1WIB6rmBAu3JdvqS4iqQMzD55lgFvF2jDQHCaSkYZwG7xSdxOudKog5lbvT0FYqrh9AN5Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8824
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> When supported, "mbm_event" counter assignment mode offers "num_mbm_cntrs"
> number of counters that can be assigned to RMID, event pairs and monitor
> bandwidth usage as long as it is assigned.
> 
> Add the functionality to allocate and assign a counter to an RMID, event
> pair in the domain.
> 
> If all the counters are in use, kernel will log the error message

I think dropping "kernel will" will help the text to be imperative.

> "Failed to allocate counter for <event> in domain <id>" in
> /sys/fs/resctrl/info/last_cmd_status when a new assignment is requested.

"when a new assignment is requested" can be dropped. Or alternatively:
	Log the error message "Failed to allocate counter for <event> in domain
	<id>" in /sys/fs/resctrl/info/last_cmd_status if all the counters
	are in use.

> Exit on the first failure when assigning counters across all the domains.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  fs/resctrl/internal.h |   3 +
>  fs/resctrl/monitor.c  | 130 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 133 insertions(+)
> 
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index db3a0f12ad77..419423bdabdc 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -387,6 +387,9 @@ bool closid_allocated(unsigned int closid);
>  
>  int resctrl_find_cleanest_closid(void);
>  
> +int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
> +			       struct mon_evt *mevt);
> +

This internal.h change does not look necessary? Looking ahead this is because 
rdtgroup.c:rdtgroup_assign_cntrs() needs it, but rdtgroup_assign_cntrs()
also belongs in monitor.c, no? 

>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>  

...

> +/*
> + * rdtgroup_alloc_assign_cntr() - Allocate a counter ID and assign it to the event
> + * pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
> + *
> + * Return:
> + * 0 on success, < 0 on failure.
> + */
> +static int rdtgroup_alloc_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +				      struct rdtgroup *rdtgrp, struct mon_evt *mevt)
> +{
> +	int cntr_id;
> +
> +	/* No action required if the counter is assigned already. */
> +	cntr_id = mbm_cntr_get(r, d, rdtgrp, mevt->evtid);
> +	if (cntr_id >= 0)
> +		return 0;
> +
> +	cntr_id = mbm_cntr_alloc(r, d, rdtgrp, mevt->evtid);
> +	if (cntr_id <  0) {

Extra space above.

> +		rdt_last_cmd_printf("Failed to allocate counter for %s in domain %d\n",
> +				    mevt->name, d->hdr.id);
> +		return cntr_id;
> +	}
> +
> +	rdtgroup_assign_cntr(r, d, mevt->evtid, rdtgrp->mon.rmid, rdtgrp->closid, cntr_id, true);
> +
> +	return 0;
> +}
> +

Reinette

