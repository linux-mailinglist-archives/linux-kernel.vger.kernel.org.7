Return-Path: <linux-kernel+bounces-791013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89BB3B121
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACADE582F19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A3F2222BB;
	Fri, 29 Aug 2025 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KC7MeDIc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DE21D3F3;
	Fri, 29 Aug 2025 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435677; cv=fail; b=fhzci0Vv7WTBQn07BbgUGo4/ICVG2ex29SB7vnzgLnrQnuZxqzypMJk8I1G3xZ5eD4w2OwUWSmUm6jHphz8y9kbgtGKHX2hHEpxpk742ZJjozK9ekQsYXB7mobk1Nc795+8jMmXtjLCsf0mboQrYUMJS7QsuS6wibMGYldK4ebA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435677; c=relaxed/simple;
	bh=IrC+0SC/6NUqbb1dUnruYrEUUKV2HmtU4DOT8FjHCEg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nXYdGAaWMO/yJNKvKIAfiYCiSN3fU5wrSJo+Zt2ApXn9Rl12vlVX+yb9k6ZYUnd95/kir5v+Llf8IaMTzmdAjfILjqimCJpwww16mLatt57ZLNVTdUxCBpWFvuN9UHIuHC2lNBqh/GMEX2Fg3Mnfw1LarHPwL+fATDdc2gTcFpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KC7MeDIc; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756435675; x=1787971675;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IrC+0SC/6NUqbb1dUnruYrEUUKV2HmtU4DOT8FjHCEg=;
  b=KC7MeDIcXHJ5qCVrPkDvaCHLTM5BlZvZfpQ/UsCgLRssdzLDNCFFPPCv
   rozA9Zf5/9mk4PdwfbgIMha5jdcyWb4LYvXEASHRntRTlfFImWzOqV9DN
   Y4BeJRf0zQxHMNeGRaYQDdHg44e59yv51awHvKZR9acfGtDooHLgLGdZS
   GAqsPSBLKiV7rcSWriH85v2iRWm9EtpxTEonooMTh72OfhRqhiKSERXtH
   9RwOibGZNrcC1fvWs2swlVDbl1GpS2XfI8U9GtGcA6gOkqSpX2knHjzi0
   aV305xgEWAMbNF3S+V+r7UymXsN7f7JJ4bNP1e6naZrnKT5dM33H3KUUu
   A==;
X-CSE-ConnectionGUID: TQDQX5yJSMSClnOcBMH9Hg==
X-CSE-MsgGUID: lBaxaoG2RlmNIzcaftMv+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69816872"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69816872"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 19:47:54 -0700
X-CSE-ConnectionGUID: h33TdnZsRAufm58tzeQhcQ==
X-CSE-MsgGUID: 06khqEddQJ+QqKE+RhQkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170444968"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 19:47:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 19:47:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 19:47:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 19:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb80Dzgpzls3j1iloFxRlCwWkQ0SnZGov53ljfmjMswIT/QdOERnMXARkmsgMDC0A8jPt93U11NUF93A6mCmLAoGt8k/DnPoDg9T6muB6TpFixYdG7RwNfGHGf/Lc5Zw5Dv7CO7iVA1KdxpkYKN0TAKbDCPtKDvscxiVkraTdckjORSY4BBkrzQ1VaFTSDiqUFLvHOFuEkBLV/TalQcIXwOCR/FquV9NQsriqfjPVhYfHSR9Oz+C06AFuVvuaIJdGIXCGBPYzYBz/opVST7WSTJ0ZZv8sXIUZNnOjKy85RiIShqWoKxuJUUfbKEvHfDpO44iVkjq7Yj2Q0APo2qaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG0t42xoFFlftQB/zZcRFwtgWWXO6s/EEuRtJAc/0n0=;
 b=kfpkJbf2s3McsMN3HUncvER/nQ0l80FT4TrTVlochxZKkkDTuyyewcJcGNFR5Dj2j1ouS9N2l0AHkqVaDOULGEPRy5YVLB4S+mj3nMOrLI8q4ZYKfCRPHyzFCxiHoHBnxlN6+yI/GG8/wcNvBuRYawNIcjovcbKBJOteUi6e7BZd1SI5M1iudwTVoWevl0klXRW/OS003xxPv4ELprHSvNOyoRVciT8BecIQQwta0DYzOXsDPya+NN+P/mRHjsyaat31VSk7bzduWu1spIFhubYzw4d4wokVlVxvmkWvzqrbzKq4NvYnbwg1c4XAthp4iZStwIy8sOKxYx6p1OSufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8503.namprd11.prod.outlook.com (2603:10b6:510:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 02:47:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 02:47:45 +0000
Message-ID: <cfe2a26f-59a7-4563-b6a8-aaa674f60636@intel.com>
Date: Thu, 28 Aug 2025 19:47:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] fs/resctrl: Add user interface to enable/disable
 io_alloc feature
To: "Moger, Babu" <babu.moger@amd.com>, <corbet@lwn.net>,
	<tony.luck@intel.com>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manali.shukla@amd.com>, <gautham.shenoy@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
 <f53db5c6dd7d0580c0cb1f252d947357d097842b.1754436586.git.babu.moger@amd.com>
 <0dbdff85-1d32-4540-984c-e8eb4b940cc6@intel.com>
 <d5438a53-c803-4704-84db-1da019f50a3d@amd.com>
 <d11e20c1-1162-422f-8915-97efa69644c7@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d11e20c1-1162-422f-8915-97efa69644c7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:303:83::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: fd00998a-4b1f-4f7a-a71f-08dde6a66e63
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkVSd2g1bGc5d1VKdlpMakI0MGszaHcveTFVU1cvc0IvUzVDbFBKb2QwbTlU?=
 =?utf-8?B?MTJnQ2dvOENkVjFrN0xEYzdhSWh0NFc4b2RyYnp2T2QyM0ZwNGxxWFJrOUNG?=
 =?utf-8?B?TmRjNENyV083cTN3ZnEwckxSUTkwWGhnRG9EOEIveXZQTEhDL0JCTEREQzZP?=
 =?utf-8?B?Zk5Jczg0dk10cHV4TFNhdUI2eHlXdnFLNUpXeXNZTzY5a1V0UlRzMWl4Y2lz?=
 =?utf-8?B?aHZZUU80SUJiUWlFQmRRSnhhY21UL2c0QjBNenpLbFNXSU5pbjBwUkZPR0Nt?=
 =?utf-8?B?V1lkdHRndlRGblpkOWVXWkhSNFBpN2ZHVUExYUZmNFl4ZkdMajRvQ25XVU9U?=
 =?utf-8?B?THVhTU1ydkkzV3dwQkJaSDFJMzVHWWE2YnhNcGFPdWNObFhCYzZhWm1YYUJn?=
 =?utf-8?B?b0R3dDkzV3BkWlZPS3VlbEtoRmIyTWllZFVkZzJqM0x1TUJNNzUrL1JvbXhx?=
 =?utf-8?B?Vll0VVp0SVl0VmdHOE55enhuNVFBQnRIczlraHRsWnRQS2tCKytsMDBnazk2?=
 =?utf-8?B?VXJ0TWxNSEs1eWcxajRnd0N4MUJTTlBtMUJNcW9OWktXTlEwblFWd1l3Y1FK?=
 =?utf-8?B?OTZGNnVUNS9wK1F1MlpUTzhJS3hhTG9zUTUrOUloajlPam1HZWJwRWNUNWFo?=
 =?utf-8?B?NmtjSW1FYkovRU11ZUxRdXF3Y1FnakVlb3lHbDFqMXZQajg2eVhPN25XYzdO?=
 =?utf-8?B?SDNrSFU5aHZieWJlSlhiMXRiekZldmxFZndlMDFaOUlrbG9xREpzU2xwV3dY?=
 =?utf-8?B?VjE5eFhvZlo0WW1hUWViZS9SQkFpbm4xUlg3cDB1VjFXdWNHc1o2c1A0L2RS?=
 =?utf-8?B?VUY5ZmxZSTlrTWZPdTlmKzh4NTJsQTNaV0g5M1VZSmExTEdNVEtpTFNMM2N2?=
 =?utf-8?B?Q0lOLzNnTnJrdmRXclNyVFVZMkJPSTlKa1AzeWZDbGNCcDJtV0pjQ2V3cFRR?=
 =?utf-8?B?clpSTjFKYzY1WE05aXBvNXFyNW1BcGNkVG1rWUFOQjN5ODVNWG03MFY0OWVX?=
 =?utf-8?B?SEdYVmFPYmtORk1CQUp1WjBQS0F4Vk4zOUJ2RWs2M0FNUHNwUDdHRU94bHRN?=
 =?utf-8?B?azlUdFNydXJnV3dtNEdqcmhTaHk5U1JqSTErSkE0WlBmbmZ2bklqWEJuS1ZS?=
 =?utf-8?B?K3hQQWJsM1pyalRGdlYxdjdKYUw3QlBqamdSTnF2UzlacEg1RlFJdm5MOCtr?=
 =?utf-8?B?VUZVMFBFclRQNEdQQnJWV1JON3IvZ2pBM25ZTVdtb1d6Ym1uUUNzMnNrOEkz?=
 =?utf-8?B?ci8wR3VnR0lWZ3F4Vklab3pNd3JBelFPNlRFWjZKdVY5Y2o2MXNaeHZSdzVJ?=
 =?utf-8?B?SEdlcXYySHNLL25tZ1BxUGtNV0FucEp6dmsyeDFRV1E0VDFhaU5mVmJCd0Uz?=
 =?utf-8?B?MTNDYTY1MEtMMWRXY2R0eU1zVjJSZlgrd2Q0Rm5WS1VqbEVabkRseTA2Y2sv?=
 =?utf-8?B?amJObExVVmRCUk5uVlhKWVFnK3lzZjUwdEFhRldMWkwyZFFTdHErZjdDL1pP?=
 =?utf-8?B?dUExYWVkQnRYNlpXU0RGMHFQYk9zdldxWVB1ODdpK05jTFdvUmRTMU55OXcw?=
 =?utf-8?B?SXpzbUdid2NJcnlKRm5HTWkxOGpBa2ZKNFhTOEpOZ0lXbTluRmt1MlpiOVlJ?=
 =?utf-8?B?QUl2ZlExNXhQb2JEVDlXS3c5Wnp5UDdQaXFZSml5ME02QVk2RHlqd25TY0dw?=
 =?utf-8?B?Z2NnSWxGdlZkdURVcU9CVGxCRjVXZEM0b1hFelRDZTVQeWVQQlA3c3JqSGJw?=
 =?utf-8?B?V1ZGdzRLek85dXBsb2lkUWlGWmJLMmwrQ3VTUUtRTUVGL0VGdWhpb3oyanBM?=
 =?utf-8?B?NHpJU0FDOUw0QldVNkc3ako2b1dZUWY2MkNHQ1llN0VxeVEzc2N5ZXR3K0p2?=
 =?utf-8?B?WWYzWHEydFo3RlZEcThITXMva0lHNFMxWjNVL0kxVWMyaXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1RjcU5SL0gvdy9XYkdmUXlueDZnSEhMMzJRUkJzVktYQWdObFlCbUJLOFBz?=
 =?utf-8?B?cCtSTWtOdkZrdTlNd1F0cXZOb0kwNTN2NU1zRU13bHdlamhkdFc1Z2w3YUlP?=
 =?utf-8?B?a3E4eHpwL2JOdVN1eEJab0cvNDRQYUdJL3lCZVRLemF2S2RrV0hWQkEvUCtC?=
 =?utf-8?B?YVNDUDVXUk02SlA5M0gxVzNlbmd4aWZ0S0ZWaUlLbDdkdWVqU1JKbDNEcWoz?=
 =?utf-8?B?M0VVNmMzdmVDakptaHVRR2hVT29JR3hSTXQ3bWt0TUQvTk5vSFlKSDZHdjVZ?=
 =?utf-8?B?U01vQi9CRHJLTVc5d3NxbzhVKzJyWjZ1QWxQY1Y2OThJc0tRdmpsY1MxV2RX?=
 =?utf-8?B?V01sdEJqYkcxM1pyUHhIMjVMM2ZmQS96ZUJ1QkVwajhQclJISDRvMUxwZzdR?=
 =?utf-8?B?SnhXRWtFMlBaNGFSOTE3d3lyVTlnSTF1cmRNUHJWNkdkcThNNjBVNlZpa0Yx?=
 =?utf-8?B?VS9HU2xsVU5KdEdBZGsyN1EyNlk5SlY1Z3BLUlZ2TVBoU0l0bHViVWRKWE41?=
 =?utf-8?B?bVlJUlJtS09zSDFLcUY2TWJTN3kwOE1JV2diaXhQTE10dzhNMk1jNThnMGta?=
 =?utf-8?B?YUd3d0ZkbzAwMzFKNEdZY3RsdXphRHd5M0hyRlE2bWZaQ1hmYjJiTWJkTGZJ?=
 =?utf-8?B?aW9USDdmZGp6Qk0wY3ZpcmZyY3VadWk3cUNZUXFBYWF6VGVoLzEzRjM3amJF?=
 =?utf-8?B?Y2p0OUp1L09Ic1JDMTJid3N2clBoOVhyREpnY0dEblh6U0o0T09YdThxY2Zh?=
 =?utf-8?B?YXRYTXVRUlR3ZVB0NElZTmcvQUIzWVh5QlBMUkdYbUNTNStOYmZ2ZGp6UEZh?=
 =?utf-8?B?U2RsVHAweU96ZU10QXM2ekFFenRDV2RzRmRCdGpkMTdvcEJrdzFPT2kxVjFZ?=
 =?utf-8?B?U2J0dVp6RmlLQS9aY2dDVnN1L1FXQkc2S0FOU1orMmhTSlQrbnF5V0Y0b3JH?=
 =?utf-8?B?NHVyMzJaVm1pRDhsQmdXc09TOXR2YW1vNVc0emR5aHNjNXZzMzR0aWRGYzlB?=
 =?utf-8?B?UnprSEVTWlZCRnpKclFuYjlLNGdOYUpsWU5JRDIveHgxeU9MeXYvZWhOb1Ax?=
 =?utf-8?B?NnVnOFFibDVBWHl4LytreVRGdmdGT2ZXQmxXTzluNWwvOERwMys5dFR4bmE5?=
 =?utf-8?B?bHhCQWc5ZjNuQ2JIbVQzZkdmRFpEMUNtaklwb2tMMHBFK25NRmFVcWs4bm1m?=
 =?utf-8?B?TVA1Ykl4WnJzUWRTNkVFTGx6cEpqMi95S3BnSXRqU2NsWDQ4R3FlTkpjTHRR?=
 =?utf-8?B?Rk9PTzVPd25NSWk5dWxueWZnaHdDMTlNRnZtVWs5cVlpYmY0S1l4blFyQXBw?=
 =?utf-8?B?cm1oaXZPUjJzRzQrc1dFU0ZWMis1bDZZa3B1elRRNlZ1d2lzK05DYzBzQUo2?=
 =?utf-8?B?b3d0cG5aQUpvNXFCcmkwc0tyS1M1YkdaVno1S0RKZWVFQWJsY3dDdUhDM0Jt?=
 =?utf-8?B?OGdQdElyOXQ3YXg2eEFkd01wcFRROEdhd1ZPVEZpTDRmR1E1bW9udDNhU25Q?=
 =?utf-8?B?cnJwNVR4R1FUcGh2dUhZK0dDeDV5RVpsUlJlTFFtNE5KS3FYSnBqVkhtaXJm?=
 =?utf-8?B?cFVJc2xZWG1OWjdjY1RHS01rRmpVbUZ6N2hPcmlBWHFoNGFBd1dZeXc4cFFJ?=
 =?utf-8?B?KzNSU3J4VkllZG9iODBMcC9iSXZkMUlDbGZaQjhiOGZFLzZSNkU3eGV0QnJJ?=
 =?utf-8?B?NlJ0cE03MGVMeHd4UUxFOVREUE1aMjFUWEdYM1IzbTN5YVk3R0J2M3AwbWxl?=
 =?utf-8?B?UEhJMUU4Z3FSQUZ2QUNieWtpcWlVWE1tdmlJYmhoMVM0MkZFZExiNnRDZ3VO?=
 =?utf-8?B?T1I0MVN0ZDk4ZjdsSXlHR2k4dlQ2UDVsNndEOTF0dlRCTnY5enZYcks4cHZ6?=
 =?utf-8?B?c3RVZitwYlF6aC93WmExQTcwSThQRVdKSTZ6ZUkwNkQyblk1R2tMOVJDVFRV?=
 =?utf-8?B?cVZ3c1lsNjVUVHBCRmx6NitLLzVOZVh0MThJa3pBY1R0SzBTQk05TGg3MXZo?=
 =?utf-8?B?aStKcGlRTG1hS2VENWZMOStXazl1Q2YzQW9TandNdXlBSVUycWVkRkhrQmg2?=
 =?utf-8?B?YkVVdk5QOFJMcVUxUzR4SDhRUTk0UUEybThNeWlyalI4SFhtUDVQcStORU94?=
 =?utf-8?B?MEJtbVEzdUlKVDYreDRhVjFsMTRRVjc1Q1d5NVNlWE5LeU0rS01CVzV2U0I5?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd00998a-4b1f-4f7a-a71f-08dde6a66e63
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 02:47:44.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4KWIr3AzGYGyAJ1+ovZ09VF9HwRlafO/Hz++Akszw/k+K8ttOFl0pyrJijlNJmKe7+BZ7NUmfcAxzvshcn+lOs6dsoNaEwL92N4b220ags=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
X-OriginatorOrg: intel.com

Hi Babu,

On 8/27/25 1:39 PM, Moger, Babu wrote:
> On 8/22/25 17:53, Moger, Babu wrote:
>> On 8/7/2025 8:49 PM, Reinette Chatre wrote:
>>> On 8/5/25 4:30 PM, Babu Moger wrote:

>>>
>>>> +    enum resctrl_conf_type peer_type;
>>>> +    struct resctrl_schema *peer_s;
>>>> +    int ret;
>>>> +
>>>> +    rdt_staged_configs_clear();
>>>> +
>>>> +    ret = rdtgroup_init_cat(s, closid);
>>>> +    if (ret < 0)
>>>> +        goto out;
>>>> +
>>>> +    /* Initialize schema for both CDP_DATA and CDP_CODE when CDP is
>>>> enabled */
>>>> +    if (resctrl_arch_get_cdp_enabled(r->rid)) {
>>>> +        peer_type = resctrl_peer_type(s->conf_type);
>>>> +        peer_s = resctrl_get_schema(peer_type);
>>>> +        if (peer_s) {
>>>> +            ret = rdtgroup_init_cat(peer_s, closid);
>>> This is unexpected. In v7 I suggested that when parsing the CBM of one
>>> of the CDP
>>> resources it is not necessary to do so again for the peer. The CBM can be
>>> parsed *once* and the configuration just copied over. See:
>>> https://lore.kernel.org/
>>> lkml/82045638-2b26-4682-9374-1c3e400a580a@intel.com/
>>
>> Let met try to understand.
>>
>> So, rdtgroup_init_cat() sets up the staged _config for the specific CDP
>> type for all the domains.
>>
>> We need to apply those staged_configs to its peer type on all the domains.

To put it more directly, this implementation keeps the CBM of CDP_CODE and
CDP_DATA in sync. Skipping the unnecessary and duplicate parsing and instead
copying the CBM from one to the other makes that obvious.

>>
>> Something like this?
>>
>> /* Initialize staged_config of the peer type when CDP is enabled */
>>         if (resctrl_arch_get_cdp_enabled(r->rid)) {
>>                 list_for_each_entry(d, &s->res->ctrl_domains, hdr.list) {
>>                         cfg = &d->staged_config[s->conf_type];
>>                         cfg_peer = &d->staged_config[peer_type];
>>                         cfg_peer->new_ctrl = cfg->new_ctrl;
>>                         cfg_peer->have_new_ctrl = cfg->have_new_ctrl;
>>                 }
>>         }
>>
> 
> Replaced with following snippet.
> 
> /* Initialize schema for both CDP_DATA and CDP_CODE when CDP is enabled */

Could this be more specific? For example,
"Keep CDP_CODE and CDP_DATA of io_alloc CLOSID's CBM in sync."

> +	if (resctrl_arch_get_cdp_enabled(r->rid)) {
> +		peer_type = resctrl_peer_type(s->conf_type);
> +		list_for_each_entry(d, &s->res->ctrl_domains, hdr.list)
> +			memcpy(&d->staged_config[peer_type],
> +			       &d->staged_config[s->conf_type],
> +			       sizeof(*d->staged_config));

This looks good to me. To make it obvious what types are dealt with this
can instead use sizeof(d->staged_config[0]).

Thank you.

Reinette

