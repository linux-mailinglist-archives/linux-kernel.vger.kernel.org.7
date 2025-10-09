Return-Path: <linux-kernel+bounces-846159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7670BC72A4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4411898C04
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3F413A265;
	Thu,  9 Oct 2025 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxhHbRSu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FF4192B90
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975246; cv=fail; b=udZzroZxERpOUsjmxhsLmC4Hr2SM0O8RrEJddgtAGSJVutdgqZdzTd60Mm5IBnofw2WS+Mn2jDHj7y7D5Ucw1VVe3oMv9IRd52nmoZXT+Ln/1I5yw46e39lQMe/arMot1zKtkMAOEtG3vHDsKInAwMVK3HDfnXJjcv7ceLXvngw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975246; c=relaxed/simple;
	bh=RiRh7c1IcWbtjbhOZBElrzMVnQzF2hrP4JvL4okthy0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U6miRXEmY1jfNgoi3aabakl7n+vSOVT8zDlNYIf1/bgc67ph3ADbRcE2grldq+HCosteHfGQK/qQg97m/7tajD7tMkjCOGvphsG7FsVkgLmwVQ+K45lfYyWxp8ZdOVrTPiB0dV7rIqjFX0u9jQXvBagVGGrImcK/b37pMqFKwv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxhHbRSu; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759975242; x=1791511242;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RiRh7c1IcWbtjbhOZBElrzMVnQzF2hrP4JvL4okthy0=;
  b=FxhHbRSuycO86oHoFmqZEo84I/fZn0X/8z/zkCZLemChjW+r0xML7cvy
   stfApg63UwlLMRNjZF5N+fzcye1/WEA6BHYTZQEAS6o3BgljI7hh11Hb6
   OCg7bBeqYndqw+oB6Z7RIpxORtTWxo5Yws4ky02gAaikO1VgP76BwGhZ7
   3eX+EOqjY2ESET155I8dXK37dzkm3EzGvfZy+/fU/vQw9abDNMfDdmQ2A
   bamWeeXhosi0ZF4uNbqWij8iG11r5YraV3IEEFmIWQ224a1VMl2YIXlK5
   RnH+k2k+p1GWbxwob6c3KcPFElvGcCbc3OznAw5fNb4IBbpS8UfF9os9Q
   g==;
X-CSE-ConnectionGUID: UjjcB+AjSkCI8MINjx+JFQ==
X-CSE-MsgGUID: FJvrsnNJRTGeCp8Tg/S22A==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="61215836"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="scan'208";a="61215836"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 19:00:42 -0700
X-CSE-ConnectionGUID: ccDDoPewSGSf7SIEng3aRw==
X-CSE-MsgGUID: GSJKo+vBT7WAGCPAE4Kq5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="scan'208";a="180521600"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 19:00:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 19:00:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 19:00:41 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 19:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUiw88BbWD8J9kuHz+BxGe0PtYQ6QVaqrWhkI95a+U9dE71eLtj6nRjVAfRTJmL/PH0XKEmAbz5iVx+7vtLkY9yXsRPEJC8oQj3ot2vCpVbuA8YVaKvxufjo07XJEyvirq00oxcbyI+0ZGF0FRLoYDIJ+Fc5eBUKLzRo6W4/djgElhiKYCOWRNVCGNpT5/W15ndjTl4aeo8Dm8gbGwpfWWokxtVOk4NwWxyUW9Lf+sttleV0yyxFIz1cVg7Wkg3OeVj6dxwgsqMCtmaCazrCM4xWbfTqXTMO+19T83hddmzlw/D6Znehaz3HL6elocLutjIkoA+MYd/LhlEyvt+gKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcQbPn0hPayRcH6EPAMboXkCiGlFhHzkBk5tIs/wy5c=;
 b=Ebh27c0MYW3GnUPkBCUsikc556n3SCphIL3zJU6sluSEFnZTiX561ALyxrVVCrBh5tv752WF15OhpoF1EkI1QgFNuKRTr8u4Iruk6eg6Hx4Vwp9p4Mm7OmduxE5ARrnnQKPTGy6kXJr0hJ+B0uVaIUSO7X3kssL3/Of7UTSTfpIobLK8M9ZnKTNEW7///ADDpIwz1LXTghEQRSLebB5FdF+EGsQm59ku1GYaba0eM/DIeElomDpIyxPrzrC8rujRMRICvE910/VOUcwcQvp8+kb9Zm1xwhmIHzR2E6r/Hecin1E2gZapyX5u5mIoOivPCT8cXy0sFbqCpr9xPVIiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA4PR11MB9155.namprd11.prod.outlook.com (2603:10b6:208:569::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 9 Oct
 2025 02:00:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 02:00:37 +0000
Message-ID: <78dcda7c-b3f2-4149-b6f8-3da695d83bdb@intel.com>
Date: Wed, 8 Oct 2025 19:00:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Fix buggy overflow when reactivating
 previously Unavailable RMID
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <2ead4ece804b0f61aab01f47385d9a125714991e.1759952394.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2ead4ece804b0f61aab01f47385d9a125714991e.1759952394.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA4PR11MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d7e19d-c17d-430d-366d-08de06d7a441
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RytDM1hYcjhIU0lEa1psS2xMY1A4UHQrRCtlUlA4MGlvQ3hsTG1Id1hiWi85?=
 =?utf-8?B?OUJiSkR6RkJHQm8rK21UL1o3WUN1c212LzkzVEdZd2VqZUd6UzZsVUFHelBI?=
 =?utf-8?B?TmF4c24vQlc3MVdiWldwa0xrZzNlbVkwdlI3dld1NXVYVTdKbTlUbGxvMzJC?=
 =?utf-8?B?V1dpN3IwV25xbVg4bnltZlpjbExQWW5sSTFsdVNnSW81bGdCMUxsVTRTWWRG?=
 =?utf-8?B?SWhNMGZqMWpVTGdtNXF0Umt6VTQwckRiTDJybTRZbmZHU2FQRU1zWDRwc3Av?=
 =?utf-8?B?bThWSUdWSHFZRWtFc3JrM0V4M1FCTHVVdWswWjMwaFkyaDZubCtTRnVTSnNC?=
 =?utf-8?B?VnZXempZOU85TjJ2Zk1WanhwWSsvNlArcmNpRG84SFp5NC9vYXIrb1ZjTGJB?=
 =?utf-8?B?VlZ1azJmZjg2OVdqY2t1ZnY1VEVUTEZVdU5acDgzTWVDd2IwNCtMU0c3L2VL?=
 =?utf-8?B?cGg3b2sxZFUzTTRwVXdNUGZiY21HSG5FOHBBZGJsOEFpQ2laR2RBMEpwcVR0?=
 =?utf-8?B?b3YydmFJZ29iTWM3NE54cmZZRUJ4bUs0WU14L3RiTW94SEhZeVpVeWRvY09v?=
 =?utf-8?B?OE10NEl5NUkxYkN0dEJGcEU0bzdrNXA2amc1MHBNTjdKZEFuWk83cjFFY0x3?=
 =?utf-8?B?UU1ZcStOckxSS2VsNXhIdGpDOEt3ZEhxNEtVUU9TRUpCQU56dUlTUUNNZ1A1?=
 =?utf-8?B?OVZFejFlK0srU0NOcWlpK3pBQ0N3RXE3dU14Unp6US9zTWVEM2VnTWczUTB5?=
 =?utf-8?B?eGYrRXlFd0grOWI1c1ZDV051NVgxTDczVjl5aVN3US9uWENVb2lVVUtoYVdn?=
 =?utf-8?B?ZjFBdHZiWWZlVytFcGkxdmVmVEVSQWh3SnZEMlNIOWRibkFBaDdJYTd6czRF?=
 =?utf-8?B?ZUlvTENKaDZjNWdFTUVHdzI0WXRnd0x2RXc1VnZjeEhQdzBFd1U3TzlEdE9F?=
 =?utf-8?B?N1ovV25VYXpXbWZpRy9nU3lGOWJiTFFsSFNzY2JZd3NoUTlRTENkcHkycWk4?=
 =?utf-8?B?V1RyYlZxQmRwYXFGMXJpU016eDBLWkFpeEVIaGpRcldKUmFVN3Z5MjBHNnJT?=
 =?utf-8?B?K0JnZXV3QlpoZVM5bm5hMVQ2R3AySWg0bE1YL1BPS2pSamFVQktxdjA0eU93?=
 =?utf-8?B?TlJFZHRiOTExazVHRGxnYnFIY0pJRVNqWElxTkRudEdFdU5NSVhrNXZ4UzRo?=
 =?utf-8?B?RFFoMHVPMGlEbFlTZ1ZXbytJdXY1akpRb3N3N1ZESmJQd0lFa25RUVlObmZR?=
 =?utf-8?B?SVlaa241VVdNeE1yVGNrVlRUY0hDc2VZTEQyMnF5STZiTkcxN3cxVlI4Nk5Z?=
 =?utf-8?B?eVRBcHVkRHNaQ3A5ZWZsdEtoK2tWdTYzL2tOYXkxbXVycTgxaTIrbFZTcG02?=
 =?utf-8?B?YlVIdVpkcU1wWTRza1dlV2w3UEFMVDh2clFRSVVneDhWa0JLcThoeVkwdWVi?=
 =?utf-8?B?SS9UdUJpeVd5Uld6Y0VGMmNhdlpqNzRuN1g0WEdiVWdlRy9TUWp3TWJ2VGFM?=
 =?utf-8?B?OXpaM216aDBoSThMcWlBWWVOY1c0Y2dmYjZvUi9iTFRneHhyNHZZemN4Y05B?=
 =?utf-8?B?VG5HdkU4UVJ6YXJGVmpJSUpySnAwNzR4WW92QXZJenpCMmNucWg5ejF3SkZM?=
 =?utf-8?B?ekVSdzhod25RbkRDK1BaYjJuQUNmeEt5SjU3WUdma1pJbFpkQ0ZucEJkUkhY?=
 =?utf-8?B?UmJtbGNKd1RDSnRWUDY5aDlWaXY2eTAxNkVDQnNWdFhsa29SRStYV09ya3hG?=
 =?utf-8?B?cWt4b2prTjF4SVA3dk0yTFhMdkN1NlBqcmUxVXRUWWpTN1hONWtPT04xby9h?=
 =?utf-8?B?Z3Q5K0ZzbVRwVXArWGE4Tzd2SUJYRmdLQzNiWER0alZNczlDeXFSTC9VSmdE?=
 =?utf-8?B?SXUycWNPSXFTOUxEcEhhelVjZFdLNEdWOU1KcC94ZkpLNkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1grSFFzYVF0RC9DbENKdTlZMHZSS3llNTZ0OUJyc0s3MHVkRzM1TmUvVDNw?=
 =?utf-8?B?MGxkSjR1L2RxU2xNTTZOTm1lWVdVV2l3WHlmZjAyOXlISWQ0UVlJZ3ZBV3ZM?=
 =?utf-8?B?cDZkbUplaDgxZ29DdEd5NXRlcW5VcHh0eEF4QXM3a0NGTlFQdCtpejNxeHQr?=
 =?utf-8?B?ckU1N09FUHROT3c3U2JmU3E4UjczUElUVW1jQVNqZzlyVHhFUWZ1bklFeXh5?=
 =?utf-8?B?d1MvbUZMRVFPcm9jSU9Icm83ZVc0ZEtnTkNha3Vad0xOTDNRYktObnRNMGxu?=
 =?utf-8?B?TWIrTHJyaXphNjNMTkEwS3Y0LzVVQjZGaHFmZ21POENvMEJYN0xzV3ROb0VP?=
 =?utf-8?B?N2g1MnJKRmhObWNXZlJhUmwwUVlBbUFyaHZ6R1lGRmZGbkhmQmEzVzN5bURx?=
 =?utf-8?B?U0YxWXBGOW1TZ1BUaGRlNTZhQlpZZ0dtOUxIU2NzVFc2YmdqNVlONG1nMDkz?=
 =?utf-8?B?QUF5ajZsUFFMcFhucmFpeTNlUm1WRDEyRjNNS0xaSEVOT1JNTjhDYUFlNDhL?=
 =?utf-8?B?UWZXUXdhV0t3UUc4OFZEMTMrV0pybTJqNzZ1QUIvc2FKZmVYRVc2RGY4N0U0?=
 =?utf-8?B?bFpUQnF6U1dJMjlwK1ljK2JaSzY1WFg5a0ZVUEhta1g5VXYzQWNzMkdCNHBo?=
 =?utf-8?B?QVVPejNxSXZhajRESjdTNy8vcEV2NUxjTnN4b3kwMk56dnJDWlRlUTE5YmZJ?=
 =?utf-8?B?L2VLM2c2UmhPdUV1VDcyVFI4Y3I1b1RYYVNOSEtHbC9NTGhuTDE2TmRGSVI1?=
 =?utf-8?B?SUkzUUxFK05qQVRBYzJJc0hYWExCdHNWOXJzVkdreFFxR2VOeC9RRGJ1Q1JS?=
 =?utf-8?B?SS93dEovMSsvNUhLSlBYMEVMZHRuWjlwSTNDVVBiYnZsN1I2RkZtQVVLeTlw?=
 =?utf-8?B?L2dOQVN5Z3NQdytCdzk4Z2VLeGxncDdUWWN3KzVOdDhlb3czTFJ1M1FQTU5w?=
 =?utf-8?B?WlNjQ2tGbm5USmVaQllrZ2V3cG1xV3hXaDFJZEVkS1AvcVhwQ21BMmEzNEZv?=
 =?utf-8?B?K1VkaVNPWGg2OFZrM0pVNk1CM0dsSEJvN3RpSFJQbUtFUXVHSU9kUXh6QUtW?=
 =?utf-8?B?WWtZTW50RlFJbjRZZ3JMa2FBbEl3TVo2VEdybktFY1NocjNZS1N3TFM3a05N?=
 =?utf-8?B?Slc3Z2tZUzZhL0FGYkFYVWRCRWpMTWZ5bVNSOU9ubDJBMTBObXprWkVLRGp2?=
 =?utf-8?B?Y0pENXNiRnF5WWZTYUhaYXpNbG5jL3JEeHVqb0FXU1ZGQ2lOaklNT2xidEpk?=
 =?utf-8?B?ODZwLy8zVERwck9Ob29xWW9WTVA5djk4WGZOS1FjdHF1M2N2R1ArWHp4N0Y1?=
 =?utf-8?B?L0xndysrbnYvWDJVd2pyWmN0TXJINWkvNDlSeDFLN0hUSnhWRm45NDlDNlRO?=
 =?utf-8?B?L1lqTmVlZVBZK00xWGNKSE9ZemJYQXFoRkptcXYyc3crelVOMVA0UHBCZkFp?=
 =?utf-8?B?Z2pkbWJibGtpMkJHNll1NkJRN2FrNWpmVnk5NVA5bHdteEdEMS9DNDI3U0pD?=
 =?utf-8?B?QkplT3lIak9MOURJWjZWVGhRSmx0S09Fd1c5TUNDWFBXSnJadlF6OEl4M1hC?=
 =?utf-8?B?Z3NjRkZPMlNCTjYwN2dJYmk2bXZLaEJlSktjN1VUYUxLK3EyMzdxbHZMU0Fr?=
 =?utf-8?B?WFpubUpsL2FJdDhCcWNwUG9SaDB6OWtVMVNTd0cydWJCY1gyZFBqMTdmODl3?=
 =?utf-8?B?a25GdWtvWFpFblM4bFZXS2dOWTB6VHlaT2hCSzRNOC9DQUNtbkh1aEdkWG10?=
 =?utf-8?B?M1ErenBWbzBlUlNwTDBCemQ5MDJsNTlQSW1vdnltSnIrL04zM052eGZUaVRy?=
 =?utf-8?B?SE9GNVdPZXRUUnZyV0tpVUF1RHllNFplV1hiSkQrTmVGWDNJQ1F6UERCMUgr?=
 =?utf-8?B?dWFsVGVhaFRlcVVZRlA2bU1MRDBXVURnTTNURTdSbm1wand1MjFWUFVkbzZN?=
 =?utf-8?B?dm9LeXJ2emxSbmNpZmRuaU4wenNUZDUzaUFJYTF1eklIeTBhbUpsWDVOL2sw?=
 =?utf-8?B?eHp4SEJ5WjdaU2ZaR01jNnhkVDYwUEpnYzlYL0V3WTRGM3l2Qmh6cnlKYWZl?=
 =?utf-8?B?TWQ3ZjBZRFltd0lGdVVlUGEva1lzWElwMGU2ZW1lSFUrTXV5QlkzRWJzWkhW?=
 =?utf-8?B?L01LVHJRMjVkQSt3SFdqaEFHUDJHNlMwd01lRTlzdHFaRWNITE1VREZhQXN2?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d7e19d-c17d-430d-366d-08de06d7a441
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 02:00:37.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THtQ+TsWBqTdCdRyrx392TWdjRdiH3Ny3MZG2ExTvCBeTuv0ooHvgWoXlN0wvqtvI/mdFYY9yMCYJ85FAkUay9ZhLtRERpYLjKSnPZ0DrDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9155
X-OriginatorOrg: intel.com

Hi Babu,

On 10/8/25 12:39 PM, Babu Moger wrote:
> Users can create as many monitoring groups as the number of RMIDs supported
> by the hardware. However, on AMD systems, only a limited number of RMIDs
> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
> this limit are placed in an "Unavailable" state. When a bandwidth counter
> is read for such an RMID, the hardware sets MSR_IA32_QM_CTR.Unavailable
> (bit 62).

To make this context complete I think you can append something like: 
	When such an RMID starts being tracked again the hardware counter is
	reset to zero. MSR_IA32_QM_CTR.Unavailable remains set on first read after
	tracking re-starts and is clear on all subsequent reads as long as the
	RMID is tracked.

> 
> The problem occurs when an RMID transitions from the “Unavailable” state

Which problem? (Please let changelog stand on its own and not be continuation of subject)

> back to the active state. When this happens, the hardware resets the
> counter to zero, but the kernel compares this new smaller value with the
> previously saved MSR value and mistakenly interprets it as an overflow.

I do not think this is just about overflow. Certainly this is the
most visible symptom but the stored counter value may also be smaller than the new
counter value resulting in undercounting of bandwidth? (ignoring that not
counting at all while RMID is unavailable is technically also undercounting).

Would something like below be accurate?

	resctrl miscounts the bandwidth events after an RMID transitions
	from the "Unavailable" state back to being tracked. This happens
	because when the hardware starts counting again after resetting the counter to
	zero, resctrl in turn compares the new count against the counter value
	stored from the previous time the RMID was tracked. This results in resctrl
	computing an event value that is either undercounting (when new counter is more than
	stored counter)	or a mistaken overflow (when new counter is less than stored counter).

If you agree with the summary then please update the subject to match. For example,
"x86/resctrl: Fix miscount of bandwidth event when reactivating previously Unavailable RMID"

I think Dave's feedback about changelog length is valid. The changelog can present the
fix at this point and leave the detailed description of the overflow scenario to the end of
changelog with a heading that reader can use to decide to skip over if problem is clear or use as
reference to see the problem in action. 

I also recommend that the fix be specific and avoid vague statement like "to resolve the issue".
For example,

	Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to zero
	whenever the RMID is in the "Unavailable" state to ensure accurate
	counting after the RMID resets to zero when it starts to be tracked again

> 
> Problem scenario:

The portion below can have a heading to help reader identify its purpose. For example,

Example scenario that results in mistaken overflow
==================================================


> 1. The resctrl filesystem is mounted, and a task is assigned to a
>    monitoring group.
> 
>    $mount -t resctrl resctrl /sys/fs/resctrl
>    $mkdir /sys/fs/resctrl/mon_groups/test1/
>    $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks
> 
>    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>    21323            <- Total bytes on domain 0
>    "Unavailable"    <- Total bytes on domain 1
> 
>    Task is running on domain 0. Counter on domain 1 is "Unavailable".
> 
> 2. The task runs on domain 0 for a while and then moves to domain 1. The
>    counter starts incrementing on domain 1.
> 
>    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>    7345357          <- Total bytes on domain 0
>    4545             <- Total bytes on domain 1
> 
> 
> 3. At some point, the RMID in domain 0 transitions to the "Unavailable"
>    state because the task is no longer executing in that domain.
> 
>    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>    "Unavailable"    <- Total bytes on domain 0
>    434341           <- Total bytes on domain 1
> 
> 4.  Since the task continues to migrate between domains, it may eventually
>     return to domain 0.
> 
>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>     17592178699059  <- Overflow on domain 0
>     3232332         <- Total bytes on domain 1
> 

Is below intended to be indented?

>     In this case, the RMID on domain 0 transitions from “Unavailable”
>     state to the active state. The hardware sets MSR_IA32_QM_CTR.Unavailable

"active state" -> "tracked state" (to be consistent with terminology - not sure what
is preferred between "active" and "tracked" but please be consistent)

>     (bit 62) when the counter is read and begins tracking the RMID counting
>     from 0. Subsequent reads succeed but may return a value smaller than the

"may return" -> "returns"

>     previously saved MSR value (7345357). Consequently, the kernel’s overflow

"the kernel’s" -> "resctrl's"?

>     logic is triggered—it compares the previous value (7345357) with the new,
>     smaller value and incorrectly interprets this as a counter overflow,
>     adding a large delta. In reality, this is a false positive: the counter
>     did not overflow but was simply reset when the RMID transitioned from
>     “Unavailable” back to active.

Here is what I do to check for non-ascii characters:
$ b4 am <message ID>
$ grep -P '[^\t\n\x20-\x7E]' <downloaded patch>

Could you please try it out on this patch and fix the matches?

> 
> Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR, used
> for handling counter overflows, whenever the RMID transitions to the
> “Unavailable” state to resolve the issue.
> 
> Here is the text from APM [1] available from [2].
> 
> "In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
> first QM_CTR read when it begins tracking an RMID that it was not
> previously tracking. The U bit will be zero for all subsequent reads from
> that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
> read with the U bit set when that RMID is in use by a processor can be
> considered 0 when calculating the difference with a subsequent read."
> 
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>     Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
>     Bandwidth (MBM).
> 
> Cc: stable@vger.kernel.org # needs adjustments for <= v6.17

Tag ordering guide "Ordering of commit tags" found in
Documentation/process/maintainer-tip.rst places the "Cc" just before
the "Link:" tag.

> Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
> ---

Reinette


