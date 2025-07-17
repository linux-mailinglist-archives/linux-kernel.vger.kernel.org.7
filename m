Return-Path: <linux-kernel+bounces-735845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA9B09462
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7A9A645A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809552FBFEC;
	Thu, 17 Jul 2025 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiJeGiNs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34820213E6A;
	Thu, 17 Jul 2025 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778040; cv=fail; b=EcNc5Ewv10XZiKRfq8NHP9accsT3LsnESjfILncAtwT8Hw7kYwlEcg94L68mz4vR67m3fseK0Uacf3GIhU6h72i6dmKnoWlvcMEh4N8JIArWrOmH4T1y4aKJEM/jxYWo7qBNfrvLDdWUt34XfWN48Ung0BlIJvTV5ootKTQ5/gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778040; c=relaxed/simple;
	bh=Sq3ncRUUN3IFt2lPpcQ/9wbZD4lldJwRpxDZB0085Vs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mk2p3CalO6hJcr5vYhd8W+DD4yblbi4UCUDjWUc0KpYfXMcPj80hSyMcxUBebNXmFwOPAYzNkrNagVfHnvvETt7V75q8Jt4ArLMsarJLs+/C2evJG1iMYBFR70pT3uPXD/tMYKhHHkwuELG7r19lVlfxhKdHNxc3MHj2gckhfJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiJeGiNs; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752778040; x=1784314040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sq3ncRUUN3IFt2lPpcQ/9wbZD4lldJwRpxDZB0085Vs=;
  b=NiJeGiNs8jzcDdXMlJ3KHcgCKtUj23vk7urbYUiyOAtPb610QpmcoUjZ
   zbPyMn01yADLZYRzwo5mc1jd2JjOb15mbe85P9jNkU8FPAwwpurIkLpR3
   i93JEZfuvxzcHsHb0BKS9wxf1HWprDGWaRgkAEubqlJpiYVqp9i/0BN1t
   3tvHdO/e8kfemdNNFNCD709QD7q1UpIpumt0YK1vC1k6+JUOyHy2aVIpY
   pU1J0GcC5TGWRS7g+ipoFE+NahN/PykgfoXCS5tHrKy0fNMpNeOTVkOLr
   5MAXW0trcmiz65QFqvoF6WcS3UpaNjZQPpFxtPBij3hgIxe9isc6226u9
   A==;
X-CSE-ConnectionGUID: TgG9OEZDS/+LswHWqTOJKw==
X-CSE-MsgGUID: uuglsnCMTTGiOURNaFlzWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54946819"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54946819"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:19 -0700
X-CSE-ConnectionGUID: ozGfoUYsRjm8/99xohId1w==
X-CSE-MsgGUID: MrRCT63JSVS1CPsYa8XgSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="188852464"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:47:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:47:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.72)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:46:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwpEpyvSjFGSOLXs0o8M3KimGX7DCoNt20EgUsIZ6VN8j2cLLi9wxTsg+8nwcsg6mClL5hmw/K99MD0ZWV7inTLy3reYoVwRrr0ItmgpE1iQl2hSEG8T8nK1RbqsyXcmDaCUrvXsbPksqnYqbDGiqcI0eXcrGjOYLH/W3B7arNv6BkpxS12l4P9FWaCkT3sptgoNnXKNDCt5LlFUMImdDqDwgHl81YqLEeXp3N/P8cTaS3cMN25vA8fLfQzdQgxtQSmMS/M8v66aC/7Wytw275ykpwSS8xQ16WAYSVTSz7YSfkhTRlkdx+zylD84yzTH3CFJ7xMNyK9Y7fqnG9tlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeA+QP2nWfaG1sYsOg20uST2wLEscWZ5DSQIOHhAbBs=;
 b=iDbX+myZzoHdykuROOlGV7BPKD+jeBKRFSQPFmMdPoKCDEYgxk7hkPzbK+/h3iKZ9DJy1kNSk9iWhNwM/4vxxMKtEdviIcnaE0qXesDzRJ9p0Br5/fzw2knSENCpz2ijh6e7M2wBlrkwc2zMEZlgfSWZE9eKOc9Tud3hxO2V6DFPyStr5rpiQCCF8TE5rLUiOutCkDeVaFPLqJaDFmoT4ikWegEDeVE5yO3+y326Jf8+cSW44BUsROGXw9H77dmyYlGhX24C070dExBlVPkbVsACNB68TQg8abV4iiVfnL12AJtBOmW0QGrUeRaOh5dexACGxraaBzCctEDXL05e0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:46:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:46:25 +0000
Message-ID: <25f561ca-869b-4388-b3de-949f9dbeb196@intel.com>
Date: Thu, 17 Jul 2025 11:46:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 10/34] fs/resctrl: Introduce the interface to display
 monitoring modes
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
 <5a819dc9d57feda5cced21f67b4b1d68e5a80500.1752013061.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5a819dc9d57feda5cced21f67b4b1d68e5a80500.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:303:dd::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: c5030308-7d9e-4c8a-2f5c-08ddc5623b4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z05DRmJ0L2pSeWdUMVlpZzRBM1BRaGJqS2J5MHR1eW9jZlBNK0J6SU40NmYw?=
 =?utf-8?B?K1NxbThlYWZuUGIwK2lWeGFCZklkaS8xWmkrVUx1bDhYUzEyOXJmNVFzUkty?=
 =?utf-8?B?K1NqbGhXenA2cGZkN2tOcGkxUUcvNmpCU29VRlB3Ykw5UWVzd0g0S3RPRTBJ?=
 =?utf-8?B?TElnYTFibXNwL29WT2RWTG50czBoZVEwQk1HLzA0WHQ1d1JYQ3d5cnJTUHVn?=
 =?utf-8?B?bXI4TkpNU1IwQWMvWGVJME0rbnA0a3ZGVFJ3eitBb1dIOGYwMlRxZHdaVnBz?=
 =?utf-8?B?Y0NhdzcyK2xYaUYyRWFhKzRPUjYzRDlSS2tQelRiUW0rbjRmVWVKbVU1U0FG?=
 =?utf-8?B?MC9tS1M5ZkRubDBQWnFWVlYyT2FuMDE4NTd2czJZWXhSbmNnS25hS1lLbFMv?=
 =?utf-8?B?MEpYVjE2aGxHRlRVb0p5a2l6dm9maVZiMXl0a0wzalIzcE5kdUY2dzhTb01x?=
 =?utf-8?B?QnZWbDVtRVJoVGJLTWVXdTRnc002TjVCUWpES1ZRL2dUR0pEajRnN01VZkwz?=
 =?utf-8?B?UVJEQW5WWTRBZFdMTzJtWXFncTRRRXhETDROaEdPeG1kWmVHN2h3KzNvQmp4?=
 =?utf-8?B?L2tENk5yU1FPN29yK3V6MHMwMjBPa0xzV1lURlhuVkpHZDROU3l1Ujk1dklW?=
 =?utf-8?B?SE5ORU1tUEJWOHIwZjl1T1g4OWZYNTYzbmtKOW45N3QyRmFvN0tnT3U5VVMz?=
 =?utf-8?B?UkJ6Y2tGV20xVTUzenR3Rk9uR0lUV1ZUcmhBWDVrTXZ0TlUxT3FqL2ZsQVdL?=
 =?utf-8?B?ejVqQVZQeTBOV3pZRjRZK25PZzBnWjlWR2JnL29rVTdGVEdiOWx6RGFLZndU?=
 =?utf-8?B?UzhpQ3JHdmZELytXZ3B3K1c0Z094ZFhUOHZlMy95TEdRTlBudDd6NDdBcUI5?=
 =?utf-8?B?Y2R4dXBXQmxTeGpMQ0x2Q2VGakg0TEdGbVBpK0h4SU81Nk9sUVo0SDc5NmR2?=
 =?utf-8?B?V1IwOHV5TTRMbENrazM5aTA2WGp0MFZoODhDRWNMaFdoZHFUd1RIUml0QjQ0?=
 =?utf-8?B?TjlPZVFqV0VIa2oxS3ZueUV6dm1vUjJNc0RzSmwwWlVQS2p0RlBPeTY5UWp2?=
 =?utf-8?B?SkxxQU1GZTgrMkEreUovUU5WTzZ0ZjRTc0lPRUw1b0lGVURPWWQzMTl3Q0Mw?=
 =?utf-8?B?VDl2K1I1dnkvQStrNFBMWGhrWWFYdW9VYU5vM3BBaEJNZHB4RVhraC9rVWVD?=
 =?utf-8?B?VFNSWUZ4ZXk4U0lrbTA5RmN0SmpoK3Rja2sybHROVmE5TXI2WUdOa3hvYjdS?=
 =?utf-8?B?azU4cEI5VEhudkFuWCtocklGS0FuU3hNWHZzd1I0T2xldUN1YUU3b0o1WU14?=
 =?utf-8?B?L1J6dEdha1hvZE9xODNpZnJiSFJmekpQUVQvRHJVUmhDUXViSndhQmI1cm0y?=
 =?utf-8?B?R1FzYTBPdlYrQUhHSjZxaWhsaFRPVms2ZVY4U0tmdlAxdDFJK1VuWXFHTXVS?=
 =?utf-8?B?SW03bkRYV2tVSGgrcW1uN2pqTDBDbmpONExWWDRFaEFBWHhDbHE2dFR5Zktr?=
 =?utf-8?B?cGc0dXBJeEJqcyt6RUhZSU9ldmNXdkhMcDM0NlN1L2pDYUlycVBIYzVmZ1Ni?=
 =?utf-8?B?U09ZYWhENWhUdlB3SjhXMjNvYWlWZ0ZCTnYxcmtmU2ZCVGRRWjFvK2crb1Rq?=
 =?utf-8?B?SW1FT1dGV0YxUFByZkc0dVliekJWSGdHL2x3N2x0U09RU0JGaDRaQytEcXpx?=
 =?utf-8?B?MGZ5Vjh0dUg2M1crRUdJSEIrWlhhWTA1VEFPK3FlNFVreEVnei9NVEduRkVI?=
 =?utf-8?B?RitoRkQ4TXBlakttdTRXdUJ0bVJqMVgybWJ3YmtZRDB0ZVppcDRhZ1ozb1hU?=
 =?utf-8?B?eUJ0clo2M3FjRGRqcmxLYkM4MU1YeUJ5N0I2VEwxSEJsNEJDODMxVnl3anZM?=
 =?utf-8?B?ZGpDZnVWbmtKOElqbVM5Z2QwT0FmT3lpMElVeFczeVpKeFFuVmF4RWgrZlZL?=
 =?utf-8?Q?7XlXbt+UV9k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SithSUdnQ1lLamVJcUpjNVJJK2NDZkptL0hWd0VhMHcrOFBFY1U3c1djT0Jz?=
 =?utf-8?B?S1BwZ0VhRkRiN29GeTNuZ2p3WVlhdDMzKzJrclVOVzd3ZnNtUXp0VWRTUU1M?=
 =?utf-8?B?NnFtbW5HQlIxYjd1Y1RuWWVlRjIyVWdoUUliS2lkWkI4dkNwdmp2Rk1Kdks5?=
 =?utf-8?B?Z0dGZnIxbk9yODJYMWlUVmxVTm93TFJGdUdjYlJvWEFWakhRVjhpLzIyUTZk?=
 =?utf-8?B?TERyQTVIL01Vb3ZIUWRFU01ud0l2NUtvOU94Snp2NTVHQ0VuWjdvdDBhc2tQ?=
 =?utf-8?B?SnlXeEU0YVlpVjJ0TGVRd2JCRFB5dFI2dkhxTmRTMExMYXlKc0sycTlTODVp?=
 =?utf-8?B?emdTN3Q4N0dhdWxnTnlsNjVrVld5VHRuNFE3RVBTcHV1bHFVVWpnUW50WjJ2?=
 =?utf-8?B?SUVOZmRldHovcXZORGJyZDh1ZDQyZ1BCblhkU0xyd0ZQSmNpZ1JZRUdmb0U0?=
 =?utf-8?B?M0lMaWwrbmZpYks5Mmw3dGFtcWM2N1V5SmhRN1NSOXZuejBFK0R0RWlPcm1j?=
 =?utf-8?B?RkJsalJ4SXh5VjZYSHdLV3JZT29WdkxqV3lOSXdJNXQzSkczZUUwd0Nzc0F3?=
 =?utf-8?B?bG5lVGVFNUFxbW8wUHQ0SjZ2SlE2WlZpdElZYXdzd3BvdGw5b2dUUU8rVTJ6?=
 =?utf-8?B?ayt0Sy80RmRmd21Ld3R4WjR2b3NBWEdnbU1WUlRQL01KeklkSnNVdCs1VENI?=
 =?utf-8?B?YVNNdGJmWE5IYlI4NFNCbXRiY1BFWS95bjFVREp1RUF2VjZpVWpTRVcySmhG?=
 =?utf-8?B?OWZnY21sQWcydTRBaUEveVNwZXBqY0hvWkdkL05RaEdvNElOY0RGRDFlUlhy?=
 =?utf-8?B?VVEwcHBPekNGM0x0VWdqRk9QNDNXaURLSEQ0c1RXM1hWVFVTSmRaMG5nMEV3?=
 =?utf-8?B?Q0hNOEpYK214bkVTNEpkalU1MHdRc1FyQTNsUnI0aTJ3Q0xKZ1dNNXRKU3g4?=
 =?utf-8?B?dkdEclBreHdpUnQ5UlNncTFNbGhwTWM4VDZtZ0xWcmpFbWZKWGRQaEJtdEJz?=
 =?utf-8?B?S0w4NVc3aUFmVVlUMUdMTUU4d2pKM1pVVXY2V2lvNURoVzl6SDNZSnA4K2Ex?=
 =?utf-8?B?Rmxmd1FFY3pRam9DcHYrYS9OdHZ5R0xDK3AyUHRKaCtwTDhlQWVVNHM4eW91?=
 =?utf-8?B?dnhvQlIrcTdsdUJsSmRrRVBacEVPVUJjNWwyY3JCSXpjcnF1cUd2MnI2ZEpZ?=
 =?utf-8?B?TG8yLzZZVVI3U1FjZ2tkQVkrNkkzVFdOYUk1OUZ1VGEwSVRFdVAweEp1SkFW?=
 =?utf-8?B?c2VPNEE1aTFIYVluV2ZXUjN4dmJMZmQ4dEpNSUlLTUY3OWgwa3RXTjFtOEtq?=
 =?utf-8?B?L3l4OWhIZjdsTlVDQzQrMjRhOUpBMmp3UUVTVXgvaFE3MGpTUzFiL1hKd2N6?=
 =?utf-8?B?NjVKSWpnc1Q1bWlYb3ZZWTgvckdpeWR6c0czc0wzMW5CRi92ekkvSG1UV2dV?=
 =?utf-8?B?TVZEMkNZRFBDd3E1bnV0cjF1eEl5Rmc1U0xnNDgzandoUUtJdnU4ckJhVVlH?=
 =?utf-8?B?ZjhGRXdzMUhDbXpZenVZdlJ6QW9CUE1ReW8zbWhodERpWllsRzFDTGxqRU5E?=
 =?utf-8?B?aE5IalM3Q1IxRXF2bjZUVHN3UDZFMGpnVVpMVko0UytiRGpta0Foa0trTU1H?=
 =?utf-8?B?VkcxSW9PdExHR1hnbFl6NWNYQXJIYU51TWE3NGVwZUhhSk9pSFNreGE1b0Jp?=
 =?utf-8?B?RXZTdFg2c3RPd29iWEJtMmNML0wxU1NKWnlBSVVlWk9vS1l5OVg2Nm5UcTVt?=
 =?utf-8?B?YVhKUE9VaXk4Wk52ZHRpYXl4YlVxYTExVVZmeGo3M2Yzck9ad1hOZ3dueWRY?=
 =?utf-8?B?NDhHUEFJUCtuTmxCQWJpc2tTV0Fqb3NodFRnS0ZEVC8yM3g1ZmI5cU9VUGRJ?=
 =?utf-8?B?bmtGbi9Sb2tDTVk4SUJyTkJHQkxXZWVFZzVXOWRlVjc2OWl1cU5NcGc0eFNj?=
 =?utf-8?B?UTJyN0VoaCthcVJPYktTbWFaZ0Q5enRDRUM1ajZuSjZXdm5YSDVRZ290czkv?=
 =?utf-8?B?TGxGSHUzczFra21GTXRtZmdxdUFqaE85bHhNVjBlSTZGYkRKVjdnSnlCU3Yz?=
 =?utf-8?B?WmtpdFdSdTcwS3Q3bVFwRzBUekMwdDV6K1hwaTU2dFEwWW9yY0VVM2t0UkVH?=
 =?utf-8?B?UEFtdnlpWnBsK29hMlViakVGeS9QNVVPaC80eEtDcWxkZGRzYm9aLzhVaFpP?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5030308-7d9e-4c8a-2f5c-08ddc5623b4a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:46:24.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDI+I7mKOKL263hdgYi/zAwz8Z0bVABTUJKw9SLOqaKgX+uUQr2H6/6Nk0rPo5QFM1Pqh1gnNhBdVxdpIRxRVUWhltSiBJLQ3rZgqOsGZaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> Introduce the resctrl file "mbm_assign_mode" to list the supported counter
> assignment modes.
> 
> The "mbm_event" counter assignment mode allows users to assign a hardware
> counter to an RMID, event pair and monitor bandwidth usage as long as it is
> assigned. The hardware continues to track the assigned counter until it is
> explicitly unassigned by the user. Each event within a resctrl group can be
> assigned independently in this mode.
> 
> On AMD systems "mbm_event" mode is backed by the ABMC (Assignable
> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
> 
> The "default" mode is the existing mode that works without the explicit
> counter assignment, instead relying on dynamic counter assignment by
> hardware that may result in hardware not dedicating a counter resulting
> in monitoring data reads returning "Unavailable".
> 
> Provide an interface to display the monitor modes on the system.
> 
> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> [mbm_event]
> default
> 
> Add IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) check to support Arm64.
> 
> On x86, CONFIG_RESCTRL_ASSIGN_FIXED is not defined. On Arm64, it will be
> defined when the "mbm_event" mode is supported.
> 
> Add IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) check early to ensure the user
> interface remains compatible with upcoming Arm64 support. IS_ENABLED()
> safely evaluates to 0 when the configuration is not defined.
> 
> As a result, for MPAM, the display would be either:
> [default]
> or
> [mbm_event]
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


