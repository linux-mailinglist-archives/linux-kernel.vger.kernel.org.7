Return-Path: <linux-kernel+bounces-736233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8417CB09A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EBC5627E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6821CBEB9;
	Fri, 18 Jul 2025 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3M2O8WJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9862D613;
	Fri, 18 Jul 2025 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810812; cv=fail; b=rrOhltgFFSKvUrBTq3IfsX1OqKhYWj2rn3Jdtwej0kW63nk4DRdHE2m4wxcwzHldyBGIiDYWDx3RAKvKVTlCfXI8AsABK6M1LlQtAuDPvE/R4LWkK9uglHxCzr7YtHHT4ADqlO3dDweZDsWp4sHg5TglREC33yA1P+W4jEc0Z4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810812; c=relaxed/simple;
	bh=wWBF+UIREm94sDq+JAbRB96ya4GMS+XT9rLulZ4Jerk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=duo+MCdkpX1oCO5nX/0b7sK+2ugs4kUNAJWyECwbLN7cHOpmEY5Rucjh2WFoW+r8uLEtkik8i4DvtKULa+mB/FEZmSsPSR4+Djxt0BRMzYxvynDLF9nn+cTrknwAokIMWvhukvPTucj4ZrUGeKfGh+NCJtAyC5eD9J5mc0MyVrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3M2O8WJ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752810810; x=1784346810;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wWBF+UIREm94sDq+JAbRB96ya4GMS+XT9rLulZ4Jerk=;
  b=c3M2O8WJnlGeGqQCdhojcdrCGtcptYAfQO/f+1Q8ybQB1Q/ewn6HGTG0
   RDrTnTa9/QKNkJJpnLPkIfpuBkBLUzNtlqxjcUyduy/UA26X7gZEo9BUk
   fR/okFiRzePsywsFWyFFgaxoHezrEQ9lvrON7IaPaaxTnlCrdRuNlLYwx
   sVNVvFXQhDV9CZcIOAM3bjfFI5KkQ0/DFKmVZvhJo/Htv4w1KaKbK0TdG
   Eze6BofR/G9ZxLqrIobwBmwk6ujg1UX6GFWxg2448xRpEH+GkNP+9aaec
   hKKrxp8tIust4iv8WHbgc1m2wVYHFT5REFgYhzjq2pAGTTSesJDdtCMy5
   A==;
X-CSE-ConnectionGUID: 4sg6Y8hiTEeNEzK7/WhtjA==
X-CSE-MsgGUID: 63JQEfhBR7Cu1BKHWzZ3qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55040507"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="55040507"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:53:28 -0700
X-CSE-ConnectionGUID: lN94kU8OT1miyhW3p1pxCg==
X-CSE-MsgGUID: +ZX5lWuyRl2nGLyMIiewtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188940721"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:53:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:53:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:53:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.76)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Jul 2025 20:53:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvaySW2JsEsM9Qt2/0Z4DdXeYbPMyZFRjgt2RHp1ok6uzqo4qjtuKsKQvcpXvdL7Y2GyLnP9wHBBFwjNmYWeqv2l5XlcayCu3Lx+mqDM9j99UPz6rQ4bvb9bN6l18JHX2lofzY/ZnaxwcBAPv2oy7xN2Gcqu5SfAS4zxxB6PVxvNICdTyua1HJLV+Fe8f9FKrtEPbyO2Okbz5XyRxk3WG2j/jGKD9Wu18cmJ+uD5VdGmuGUqqnY5ZNMhlrRX+oc8Lzv6J1V4RQK4pvilrSOQfmsZ9aU5xKBt+UlFuG4g0HeuoZYWOuQknpb08Ys6PLusyWeofvs8snA6oGtk7Q+q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAdSkO31fH/Z0Ic20K4DFEKj/jSLdlzhueu2QPO26mo=;
 b=dXiyNIuyU1T27XnO3tjcnMMo3owh3y0d9zWtfzrEmhavjlodeax+RNVVcpI+ttGpjElXeNPY91YmIrDGarwKfL+Le1lMeCy7FmDzx02SNRpDAV2HxL5rLnJKdHCpaddwrDqFe0+tTq+ux7Zpcy54eFmMKAFi0CDNtaAoibrnuU4z59cx7FpYwuvaBp3cy9Av+G0YpxAfcsGT7xIVjVNz5qYskhxjeTtNwGw+XJRzPsrJAECEbMO3ox+fAY5XP/99566f1Yriz2qS84XwJtE4dF6E3n8t2FMGnbvyqrgtyJ9jk3t0uGDfBktSTOxK7tUSXzo1qqPx6MT5L19uqOp9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 03:53:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:53:19 +0000
Message-ID: <9a4410c5-c72f-4a8b-ab64-9737e082c5b1@intel.com>
Date: Thu, 17 Jul 2025 20:53:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 23/34] fs/resctrl: Support counter read/reset with
 mbm_event assignment mode
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
References: <cover.1752013061.git.babu.moger@amd.com>
 <df215f02db88cad714755cd5275f20cf0ee4ae26.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <df215f02db88cad714755cd5275f20cf0ee4ae26.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 3262b6b4-5dc4-4969-6ffa-08ddc5aea21c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NS9nc1ZoRkI3dERMcTNpRU8zS0J4MnlQOWpObFF2dVBWSHg3dFl5Z1l5dUZF?=
 =?utf-8?B?aGxUSnlQQ2FhdURQdWdDOWtpOGNkZ2xHdFpocG1LRG8vdTlBdEdTeUhuVEdQ?=
 =?utf-8?B?ZCsxcENPdE9Yeko1Z2pXdFZZZlpnRmZzMGFkN2lQQUptOVJ3SjcwRUZhc0dR?=
 =?utf-8?B?UGIvNDBYWUYxRFl4Q2JUWktLaG1uV0ViTitHcUh6QmZiOVlEd0htZUhheVhw?=
 =?utf-8?B?YWlDMktpeUs1bng3Q0FLZVAvQnU4Q20rbnlqVWhNejY1ajRZYUhKOW16Tk1X?=
 =?utf-8?B?dmIrdTZCQjRmOERVbzRleWFMRHBKdDlOOVlWSWRsRmJpeU03VzE0L2RXMjll?=
 =?utf-8?B?cm1MZ01TNXhMcW1yOHRzYTI5YkNRTWEwSHdCZVVSOWRQV3ZwQXhJRks1a3RV?=
 =?utf-8?B?ZFBRSGh1UUlOaDA2bFVlU2ZYVStnY0JSU25Zc1ZOTG5heFNOWUV5aUkwaXhX?=
 =?utf-8?B?aUgwUllObDl6R2I2TjQ1N29zSlI3U1ZZWW9ndXBQSGdZQ1RNazlKdlc1T0V5?=
 =?utf-8?B?Y1RmY0EvdjF6amtKV2RsY3NlVVgrWTR3eWhBQ0tueFp5MURMM2E5L1NiVUJF?=
 =?utf-8?B?dzlDUThETExsNUpPYWw5L0g3ZmZWSkxITVk3STA5REVjQzBZbFFza1JSMkJ5?=
 =?utf-8?B?d2Y3bXk2bGtrNGducmFSTTlFYTN5NDVwbElVQWpVOUZpZ3ZNalVhUWdCd3BJ?=
 =?utf-8?B?UjNxTEk1Q3JtbmljZUFVOVdVdldLc1JDWG1tb1FCTjNKTCt0NmRCRTBBUUJL?=
 =?utf-8?B?ZGZsT2tVS2N4UGVKTWpsZjJ4bW90VHlLcjFwVm1YVktmQnZMd0MvcmE1NjZO?=
 =?utf-8?B?cGlEb0FZL1lUejFJY3dHbkJrcFlmU0UxSDJLR21JSHBvWTdCNHMwZFlPNmc4?=
 =?utf-8?B?dEZCSk9LQXFjSkgrVkpnUjVBYWp4dVJFUDMwUFFYZUFrSWppckJiYnRDM3ZK?=
 =?utf-8?B?UTRENVZBcWs5bEsyOFpsanN1K1g3TEdPdmZCR1JNUWhxS2QydUM5TDd3NDRw?=
 =?utf-8?B?ZGt5dUxEN1VMQ1MvSDlhRVRWcGNBTi84bHVLYzFZTi9tU2FlcFdwbXRadldv?=
 =?utf-8?B?L3JzVWVTUFZPaXR1MDJ5dytwUnFBd284dVpjclBmS2dGYjllSG1uSVBWZ1NH?=
 =?utf-8?B?VHF6cG1odHorQUdEdmkrU2lla041SUFnaHlQTjFkOEtJdTBteDh4S0hTZTR3?=
 =?utf-8?B?YXQ3YjdTWGNjQnZsNnNGenpBUktBTTErM21pQk9QaXJGYSs3SUppZU9OTmsv?=
 =?utf-8?B?YWlWaklRcG14N0xmSXNoYWxOMVRZRGRiV3dUb0RNejh4N0ZyV2p0aVNPamZy?=
 =?utf-8?B?M241dWZZcjNsQzZzMnI4VTlBUWVaSWlTSXM4SjliRm1QeVJsenhsNnd1ZEp0?=
 =?utf-8?B?c2NGeGVlUjVoN09nOEZCSjNvZkJITmFpb3NsUy9UQUU0dzlGNWdPekhYQnk4?=
 =?utf-8?B?YUhFeWhkaTdUWUFhbVNKK1h6TTBCaVkvYTBjanVUQnZlRUh3WFlLTmRTVVZt?=
 =?utf-8?B?UHNqY1ZmcGVwbjVNd3Q5amNLeStLc2JMMFVaVFFkSkJVeE93MzA0aVJnYkZI?=
 =?utf-8?B?aTByMGh5dzBIRUlVRlo1bGF0d3RMb3czSkVzTGIrRlRVbHFHV0FsbGhRRnp6?=
 =?utf-8?B?TXhySzB5bUtaK3pnZGJDRk5iWkh2azJkdTd0ejdpVzJLVjcxNEFjN0ZLd1F3?=
 =?utf-8?B?VjlBTkdoblVxU2JyK2dwSDR3Sk5WNDRtUVZlTkZSN2FYS24zQVR6UUg3VTZ0?=
 =?utf-8?B?a1laVFV2NDRpK3l5Z0V6MEFxaHVDeFVzekVrd251YzVMZ3RJc1hjb01JTFVh?=
 =?utf-8?B?UEkxck5BbnUyRHdBL3FLK1ErQVo0b2NyaTNPUGlXd3EwK05CR21sWDFMZXhz?=
 =?utf-8?B?N1JwYXlXclpLWERsaEcrMUtaL1I1dCtRN0VydHRoSzRpNGcrMm1FQzJFRmVs?=
 =?utf-8?Q?dph6nSmPNIs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0dMNFY0YXZqazVzUFdyZlFGbGV1Zk9SN2tFUG96Rk9wQ2NsdXNkS2FkcmlG?=
 =?utf-8?B?L1pqUFFXT0tjS0NHYnhzaWE2MTNBL1ZUUVNiWEo5L05SNURHaUdwcis1bUxU?=
 =?utf-8?B?R0ZYQkhkTmdvOXZLc3orQlNXOFBOd2Nqc3pZUGZjeTFsa1c1RnRXUHNROU5p?=
 =?utf-8?B?TThuaHhRckFqTkk2aUpIZi9rZ0NmR3JXM3k5NXRZY0k1WDg3b1JGMEtUZVgw?=
 =?utf-8?B?N0xla09DQjFNRzBOQnhXNWFENmJtNG9LbUc5OXA2bXVLYVVzOGZNMUNPQ3k1?=
 =?utf-8?B?ejJKR3NtNWtGUXdLTHdnN2tQTHpkVVZLMW5ocm5QKzdZNXYwVkZub2h3c0xr?=
 =?utf-8?B?UER0TU9BdlJOQkNGUCs3a0d5KzN5bXBScW95UTBCZ1Fkc1VxNUhOUitvdTZD?=
 =?utf-8?B?d3hYRERleXNOS1ExY1pGRzU2RUR0OUZSUkZtc2dFazlaK2svUTgyNWJadkY5?=
 =?utf-8?B?cjY4NmJSVmxJb0M0Y1Z2Tks0Y1hxNEhZOEV4VGhwYTkwbEhPYWZyTTNhdXhP?=
 =?utf-8?B?MkZWMDdRQzBiQTF0MXFSSjRPa3VPK2VBSTNJbFlWY1ZtVVg3clB3RkJVNUlX?=
 =?utf-8?B?bkZkT1phTFNSWHdnT0lKUnFjYzN2RE4ycDRVVmJrNGdMSHNmYlhvRnlsWDls?=
 =?utf-8?B?eUtLZ1dzaTJNT2wrYkJJYndhSWxycnhRT1l4UEFBZktKbEZTVzdiaUU4blNM?=
 =?utf-8?B?c091UERBRDhld2pYclFFaVMrU3A0Nkl6OFZxOTRoK1ZzV3k0blh5SkxaWUk0?=
 =?utf-8?B?dUdoMWpBT1VHMzllOEFVWnd4ZG43YnROcFRxM3B0b2NkcFBNcW5kMno3dE1H?=
 =?utf-8?B?bVJ3K0N5K0E5WG5Hc1h1ZEFQNjliSVlZTXZXQmVSYjc5WExRdkRKTWNhTGNP?=
 =?utf-8?B?ODNZeStweXR0ZkZ3MDEraUZ4WDhFd05ob0lSQmVCUWl4YjRHNFJXazUrYkwr?=
 =?utf-8?B?MXRDWXZvSkJtWXVyc2U0VFdXWG04N3FqWGJLRVdBZ21SdFB3b2tMZHMrUjBl?=
 =?utf-8?B?TUxNWUVSR2xUVXpGUy9pai9ZRVhYZVZlQXM0NnU3eDRTclIyYnRzamNOajFQ?=
 =?utf-8?B?aUpZREJ0TldrZHRvWVNaVksrU3NWZWllSjVqRlhNWGZFWTZrUk9qeWpJQVBP?=
 =?utf-8?B?VUk0TEVBYjdNVEtiRTBRaHlBMDJTc05CNGVpYTlpRmxyelg4T2ZPcjdaSWc2?=
 =?utf-8?B?QUJOQ0UwQ2wvV1EwVFdhNEhZK0oyV3cwaWVGWEFEZTd5eUhYUy9PK1MxNE1E?=
 =?utf-8?B?VTJ5akV0dndJNVE1ZVdLK1pzS1BSOS9QUWFUWm9ud09obTBIaC8xV2paQTZX?=
 =?utf-8?B?WDFQR2JqYWJXSzlvTTdzazhCbHlCc1RTQlo3YWVXaklOeFp6NFZIRzBNV2da?=
 =?utf-8?B?NjBvd0V4R0FtV3RLT0p4eDRSdnB3anFQclZBN1hKMkxBZ0VVd0puYTlMU2gw?=
 =?utf-8?B?U29TeDdNcGxSVGF6N1g0Y2kzTW5NWUsrU0FUZzFRTlY4TStCYjBUVjBrcEl4?=
 =?utf-8?B?SWVCTkdXemxOcEhpbzVWU1I0M1RyZGVHS1lOS0p4NFRTdEVXcVVJblpZY3Z1?=
 =?utf-8?B?NVA3RjRsenhmSGUxZDdKS0JjY0tRL3RLVVVpMkhXRlBlZjNDczJ0ZmcvcTdr?=
 =?utf-8?B?bzBaSlRad2dpWTJ0N3piTW5JeHNUWUU4TERHYkYyVHNyNUhXM3BuRVlqUEVL?=
 =?utf-8?B?Q0lkUUhWVXYvaDF0L0hwbkEwbFZta3p4MjZDSkxHUTc3ZDFiclhXdzVDU0JM?=
 =?utf-8?B?TTdkQmpvWFRqdHJlV1RQcDhvb3Bjdm1IUWhIbnk0RHQ5TCtraHNjbFd1WEpZ?=
 =?utf-8?B?MXU0aWlEcjB4a2ZqdTlvTXJKUjdwRUlTdnBFOGg5TktYdDU4MEZreVVGUDFr?=
 =?utf-8?B?T3M0ODlqTW1QbE53clU5QXN0bkJBZHJDZSt3S1k0bzBib2Y5YUFJRXJoeFdo?=
 =?utf-8?B?UnFkZjUyRVNsdzU2dUEzOUZzbkJ0RU94c0psR2hLdG9MTWwrN0VRL1Z2dW5m?=
 =?utf-8?B?b2xNYXlWK1NTOVE2WHdGU0pZZjFxKzRuYmljaGZsYjUzcUt5RS9NM25JZnk4?=
 =?utf-8?B?Y3JUUUwyRjRka1E2SmR2R1hSZWNWMmpOUTJrSFdTaTdBSW1UNzArd2RnZ3pT?=
 =?utf-8?B?eitMMlZmQUVodVE1TDNVeEdZVytNVG5hNjdQdlFud0NYbkc5NnA1VjBBU3hx?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3262b6b4-5dc4-4969-6ffa-08ddc5aea21c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:53:19.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKYWi5yXSiFfyxa64M2l0Xz+lN7qOdCF9DdXfyNybnwHK1svOXx87B9lmOQH5g0J2YBj1uM2eT03ZTIuSdm5rhvNxS4m7DG1d3GDtmJ6ssE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> When "mbm_event" counter assignment mode is enabled, the architecture
> requires a counter ID to read the event data.
> 
> Introduce an is_cntr field in struct rmid_read to indicate whether counter
> assignment mode is in use.
> 
> Update the logic to call resctrl_arch_cntr_read() and
> resctrl_arch_reset_cntr() when the assignment mode is active.
> 
> Declare mbm_cntr_get() in fs/resctrl/internal.h to make it accessible to
> other functions within fs/resctrl.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v15: New patch to add is_cntr in rmid_read as discussed in
>      https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
> ---
>  fs/resctrl/ctrlmondata.c |  8 ++++++++
>  fs/resctrl/internal.h    |  5 +++++
>  fs/resctrl/monitor.c     | 42 +++++++++++++++++++++++++++++++++-------
>  3 files changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index ad7ffc6acf13..ce766b2cdfc1 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -569,6 +569,14 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		return;
>  	}
>  
> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) && resctrl_is_mbm_event(evtid)) {
> +		if (mbm_cntr_get(r, d, rdtgrp, evtid) < 0) {
> +			rr->err = -ENOENT;

This introduces the new -ENOENT error code but rdtgroup_mondata_show() is not enabled to
handle it. Looks like the next patch needs to be squashed into this one.

> +			return;

Looking at this closer this does not seem the right place for this check. This is the
top level mon_event_read() when the user reads an event file. If this is an event
associated with a CTRL_MON group then resctrl should sum the data of the CTRL_MON group
and all of its MON groups.
It may be that the CTRL_MON group's event does not have a counter assigned, but one
or more of the MON groups do. In this case I do not think resctrl should fail reading
the CTRL_MON's event early as is done above but still provide the sum of the events that
can be counted in the MON groups that do have counters assigned. With that, only return
"Unassigned" if no counter is assigned in any CTRL_MON or MON group?


There also appears to be potential for a leak here with the early exit without calling
resctrl_arch_mon_ctx_free(). As mentioned earlier in series I do not think that
arch_mon_ctx is relevant to this counter assignment so I think mbm_update_one_event()
as well as mon_event_read() should make calling resctrl_arch_mon_ctx_alloc()
conditional on is_cntr/is_mbm_cntr. 


> +		}
> +		rr->is_cntr = true;
> +	}
> +
>  	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
>  
>  	/*
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index 647a0466ffa0..fb4fec4a4cdc 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -110,6 +110,8 @@ struct mon_data {
>   *	   domains in @r sharing L3 @ci.id
>   * @evtid: Which monitor event to read.
>   * @first: Initialize MBM counter when true.
> + * @is_cntr: Is the counter valid? true if "mbm_event" counter assignment mode is
> + *	   enabled and it is an MBM event.
>   * @ci_id: Cacheinfo id for L3. Only set when @d is NULL. Used when summing domains.
>   * @err:   Error encountered when reading counter.
>   * @val:   Returned value of event counter. If @rgrp is a parent resource group,
> @@ -124,6 +126,7 @@ struct rmid_read {
>  	struct rdt_mon_domain	*d;
>  	enum resctrl_event_id	evtid;
>  	bool			first;
> +	bool			is_cntr;

After seeing how this all comes together the "is_cntr" is very generic and not
matching the often used "mbm_cntr". What do you think of "is_mbm_cntr"?

>  	unsigned int		ci_id;
>  	int			err;
>  	u64			val;
> @@ -391,6 +394,8 @@ int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp
>  			       struct mon_evt *mevt);
>  void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>  				  struct mon_evt *mevt);
> +int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
> +		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
>  
>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 73f507942b6d..35faca7ff3b1 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -366,9 +366,21 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>  	struct mbm_state *m;
>  	int err, ret;
>  	u64 tval = 0;
> +	int cntr_id;

I've tried a couple of checkers and not all can pick up that cntr_id is always
assigned when it is used below. While it is not necessary it will be helpful to
initialize cntr_id here (-ENOENT?) just to avoid needing to prove that hypothetical
reports from these checkers are false positives.

> +
> +	if (rr->is_cntr) {
> +		cntr_id = mbm_cntr_get(rr->r, rr->d, rdtgrp, rr->evtid);
> +		if (cntr_id < 0) {
> +			rr->err = -ENOENT;
> +			return -EINVAL;
> +		}

This looks to be the right place for the mbm_cntr_get() check. Just keeping this one
avoids the duplication while also makeing the code match existing user ABI.
What do you think?

> +	}
>  
>  	if (rr->first) {
> -		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
> +		if (rr->is_cntr)
> +			resctrl_arch_reset_cntr(rr->r, rr->d, closid, rmid, cntr_id, rr->evtid);
> +		else
> +			resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
>  		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
>  		if (m)
>  			memset(m, 0, sizeof(struct mbm_state));
> @@ -379,8 +391,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>  		/* Reading a single domain, must be on a CPU in that domain. */
>  		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
>  			return -EINVAL;
> -		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
> -						 rr->evtid, &tval, rr->arch_mon_ctx);
> +		if (rr->is_cntr)
> +			rr->err = resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
> +							 rr->evtid, &tval, rr->arch_mon_ctx);
> +		else
> +			rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
> +							 rr->evtid, &tval, rr->arch_mon_ctx);
>  		if (rr->err)
>  			return rr->err;
>  
> @@ -405,8 +421,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>  	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
>  		if (d->ci_id != rr->ci_id)
>  			continue;
> -		err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
> -					     rr->evtid, &tval, rr->arch_mon_ctx);
> +		if (rr->is_cntr)
> +			err = resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
> +						     rr->evtid, &tval, rr->arch_mon_ctx);
> +		else
> +			err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
> +						     rr->evtid, &tval, rr->arch_mon_ctx);
>  		if (!err) {
>  			rr->val += tval;
>  			ret = 0;
> @@ -620,6 +640,14 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
>  		return;
>  	}
>  
> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) && resctrl_is_mbm_event(evtid)) {
> +		if (mbm_cntr_get(r, d, rdtgrp, evtid) < 0) {
> +			rr.err = -ENOENT;
> +			return;
> +		}

This can be dropped also? Only is_cntr/is_mbm_cntr needs to be set here, __mon_event_count()
called below duplicates above snippet and will set rr->err

Same comment here about missing call to resctrl_arch_mon_ctx_free().


> +		rr.is_cntr = true;
> +	}
> +
>  	__mon_event_count(rdtgrp, &rr);
>  
>  	/*
> @@ -982,8 +1010,8 @@ static void resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d
>   * Return:
>   * Valid counter ID on success, or -ENOENT on failure.
>   */
> -static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
> -			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
> +int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
> +		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
>  {
>  	int cntr_id;
>  

Reinette

