Return-Path: <linux-kernel+bounces-749686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA34B151A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B822318A3DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B17727C162;
	Tue, 29 Jul 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1OTHVwy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC5A4F5E0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807791; cv=fail; b=MjcTQWdtDPxD+oP36MRr40Q/c5LuH1p39surgW08SrKim71gFwW8bUz7Mt19OiubdMEdiND+dkO2FdxCqRPHqWVVXK5g9eaa7PX3IhUZZS7xWyssZfzahlrJnsGWWmWbVLE3YT3fF9LvnPcB+5qZCjpslVopqSP2P5rWMVrU5A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807791; c=relaxed/simple;
	bh=kkdsDro3zN15pPVIQVj3LFZ8QTx5HbV/lSdEBhiJTa8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qlu5rRr7SRx3MrYNYk1P+SPql6YAEZAlv+Ztms1vSbJ+VdIuPi9XE9jjFdKQNVTK6tWsZ9YzmSdnDzuGVWlNEJfbpl3blFwKq7JA9/ylkGWs3AODYfZU5GSVOGqa1mYL13eiVbcmVWQU/YSTXMwKq4kCZ0wKU2li+EVHz4ptmm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1OTHVwy; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753807790; x=1785343790;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kkdsDro3zN15pPVIQVj3LFZ8QTx5HbV/lSdEBhiJTa8=;
  b=h1OTHVwygmduO0vq1SJIgRAcbl32S/DePM+sUjkaCtOVcPd7cvFCatqo
   95Sj1ujEY1SLWdHvl82Z/pOVPaWpuCWMbs4r/V2ynVtcRgNAgNJyebuIW
   vBe2uoafeV79JuU4k8nN9h+aTe1pTDR0eytDxmwtCKVKYIgsUl7OIoW2M
   50X/aqIKJgO4fvyISeFzn09IsY5e8WIiTxCai8fDf4vKQIkabjXvMyFgU
   Mo2d6RuHNv47bVX/MLlTQf/yzghnH8jK8gd+bFXUqYQToGhbX2oZg8tZK
   rFc4GRpQxtDe49sHadm18DE2WB1G7s1PwScMbaCCrE7KO0NI688qKOpHZ
   g==;
X-CSE-ConnectionGUID: Qc9wqSJOQLSAQVfFSaNEew==
X-CSE-MsgGUID: Bijx7kaLQ42wRSi7dcsBlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="73674908"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="73674908"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 09:49:49 -0700
X-CSE-ConnectionGUID: y45x5IKjSq6f+epBovbMIg==
X-CSE-MsgGUID: i6707JBnQE+I07L/GhF8bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163094674"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 09:49:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 09:49:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 09:49:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 29 Jul 2025 09:49:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEh0n65oCUQZX7VM54sAlbcFKYNVnZbYmWDANHOMtQZ0sOqpQ/ml9DjS57rThINbcYYZ5e0vazF6jSwn4LOZEFNm9McIU1uTuKbHbj12leZTM7cLiLiuAReXIy2+xhGpjQDsGDvdBTnS8vjX3l7pXltcIO6GYrUUAcgJzP6R8aglzW+TB5AaBQ5SSYd4nFIsO8r0iXQliwfMlWYgzgZ7yo1EHjrWgRk+Nw5uzh+DugW3g9ECxHkMijwxJdguIKdUIX8bxyXrl4eTzr5EXm49pFgFHCfUEYkde/IubaUZLp5lubjpGIm5DJWolOOA68w5cNa6Q0y1vaxoiodpje1hGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxXltdFElHedDi4ylEYXiVqnv4O+3VUIr+vJOPD00pM=;
 b=Tk3c4xVIWRQh9RP910iXUj0RKlSp9Zr5csOi7ivY79sn7xzyyUNgMHUUTUNdTT1FBhBdFFIxfibzronfjVxA+WVuxnm8zVGu9HGyvQdBnTAhdVtrpDHGlbHJciMciCEHgQhFi1jU7S1ONZY3tX6GDXrRti00c2hGKs0YApDB9aBUveDY/sNUXjwR8pdXNGjAbTHRVYt15AZRo78qSOD8NOYV94ZFHSTGC7JG+B0VnvhmLB3PKnzp+N9psMbSkMcF2H9FHM9/R2sQcilPxFsAV3q5ozANcYgThc47FLHGTmN/IBSwUr2G2wpjAWWv1w/Kq05T0UPUJLuXi1sSAibA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 16:49:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 16:49:46 +0000
Message-ID: <a148b764-0609-433e-b6e9-932493f6c1b1@intel.com>
Date: Tue, 29 Jul 2025 09:49:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] x86/resctrl: unexpect mbm_local_bytes/mbm_total_bytes delta
 on AMD with multiple RMIDs in the same domain
To: Hc Zheng <zhenghc00@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Babu Moger
	<babu.moger@amd.com>
CC: <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>
References: <CAHCEFEyd0Y+wTrLWNMUNvwgJrCxAi66D17w3Zg-ikH5005k1-w@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CAHCEFEyd0Y+wTrLWNMUNvwgJrCxAi66D17w3Zg-ikH5005k1-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0265.namprd04.prod.outlook.com
 (2603:10b6:303:88::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 660d39de-2711-4f79-3b3a-08ddcebfec71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWg1ZnFVeTlqUjNiNFl0TWRlbkx3by9iM3dOeCtSeS9rbUd0U0E2WklZdkpR?=
 =?utf-8?B?WWkweDBMQmFrREJqMTBqbSs3YUdsUkRKdEF2WlhrbjNjVWJ0c0o5cEVBb1FH?=
 =?utf-8?B?ZXRya1UzTU1VbFdXYTkzdW04RFAzeVlSQ3F2YzlaQ1d1RVUwRzFsZThVRWw3?=
 =?utf-8?B?bWpEeGw5MERpVEtydy9NS1N5THJzRmRrWnRuMFQrQkI5ejVzcXdadFptUS92?=
 =?utf-8?B?SHJDZVB1VGdqa2hSVmtpSzRMYjcrbmFvSHd2TWhDbjJnRUtlYjdFVjBmeTdZ?=
 =?utf-8?B?aldib1RPRXFSYTkrYnY2MElpNEFzQk9aME9zaVFJZU01S2JuSktRb1lhdm52?=
 =?utf-8?B?alJWSXV6VDVrTHgyMEh4bHVHQWZIMWoyemxHZDZzT1lBSElmUTVnb2NYQXh3?=
 =?utf-8?B?TWtDWkQvdzRpaHQyVWZMTW85SzVFZUhGZmlacDB3WE9Ed3ZqU1JUTDlHU1Ax?=
 =?utf-8?B?OGdVeFJBYjBjQmVMc3RWeng2b2E2czVyRWZxNU9ObXVpSDdKVWd1anRyUTdW?=
 =?utf-8?B?b3MyMFc2N2RIRXdBejJ3YXZVVG5hYVM4aG85ck14ZVRiS1c4Y01lbkNGdGNQ?=
 =?utf-8?B?eGJIUUFnWVkyQTBQeTQ0TDZyR01naW5WTnprcGJSeGZCT1poRzZCVUt5ME9u?=
 =?utf-8?B?aXBaZjI3VmNPRXpac1JsRkRkbTEzOG85b3crZldWZEJhQXNneEhXYjRsaTM2?=
 =?utf-8?B?RXo5RnFDdWNDclIxUlovYU1FeWVRZDdyYmhGWnVzeVZFd3hYQ0JLbE5vWld3?=
 =?utf-8?B?OC9hRDVLb3FHd1VRTFVKTHlieHJNYmtNRmRlUVlVaEJEM2hPZHF0bysxOEVI?=
 =?utf-8?B?VzMwbk95L1BzZlovajVBOGhhRFlVL2gxa3YyTmgzNU9lRVIxQS9ZeGlwa0Fa?=
 =?utf-8?B?ZFNOWWVFdXcvQ1ExOHl6SG1QVVlzK3NWNzJ0VTdmOHdRR3pRcU53Zzl4NXdS?=
 =?utf-8?B?SEJya0xCelZNR3g2ZjRtOWpTUFBlbEg3WUhuVjJoVnhJZVlzWi9CSzJRbWEv?=
 =?utf-8?B?OHBhS1FnUUlQRGFpZ0V3OUtFWS8vazh4SUIzYk5FdWpQT1RiakVwb2tieWVn?=
 =?utf-8?B?WEpYTTZZQjd3SHBlYWtIcHRGVUM0aG1iK1lBcHEwWmxzRHkrenNlWjFuMDRW?=
 =?utf-8?B?cjdtdW8rWXgvam9VZEhiMWZQb0JsOGo4SHBsUGtrazZ0YlA0QmNxU043K3A3?=
 =?utf-8?B?VVlVSVJVdzYwVCtKY3A3R2Q5NWxIcDloLzN0OEd2dU9ucWNVS3ZoZmhINTZt?=
 =?utf-8?B?NCtBOFdWZlNTVEM2UnM1RUk2UlE0QzFxSVlxYkIrc2w2Nk8wTGNZajF1SUhO?=
 =?utf-8?B?bFdYR01tRzBLVWw3Z3RQbHlVRDVVblZtNjNESjl3WVdaV0pkcnEwTnNFa2wy?=
 =?utf-8?B?bUVpOUJ3TVNzTmZpN2J3ZWM3NEp6dFIraWYwNDlEVVBFYXdlbXlRek5EUGNO?=
 =?utf-8?B?b2R6T2psdGpicDM4RnU2cG9zT2hCMzg0WHptZlUwQkRLTXdwWjlKZko1eGE0?=
 =?utf-8?B?WDM4OW1kQ2pNNFJ3TlR1bEl3Y3Y1ZUhoRGR4TkF0dXNOaFlPaXppUmxKd1A4?=
 =?utf-8?B?SUROb0c4ZHcrNXVHNmRZRlBPMFdTWGtWMkQvUXlvSHJVamkrd0R1RExnV0M1?=
 =?utf-8?B?QXZUeUhFc05GTWJGNS9BdWxwcG9CMnNFaUREYk1peUlrMWJHazhhdnUybUEy?=
 =?utf-8?B?V1NKZGdOQ1QrU2JuMlY0Vk4wU3FObnZIZFlEemMzM0xCSDVIVXZsN1hzMXVR?=
 =?utf-8?B?RGlVZzVBdTVjOHRzRDVPcDI2c1VkYzY4dHkyRzRueHRCMHlWd25jSVNvUDEx?=
 =?utf-8?B?NXRKRk5QemJjUjc2bzNDTDNUS3VrTyt1bm81VVpVUDY5bjNRMHNudTBRMTFY?=
 =?utf-8?B?QnVmeHRZTW9HNks5S2hQaHZ6dUlSQTVaRXhORVBkbHR2bndmY0hOT0VtY29W?=
 =?utf-8?Q?a/k59hGi88g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1lXazE5emdNVE9MZ3NPN2hLMUhrMkMyNVMwd0h3UXFhWnFOaUE4cDFLcFBh?=
 =?utf-8?B?c2hDSkYxVEJ0VU9UMnZwcjJrNE03cWxjY0cwQ1lWRFNrVlhXczlKWThSTDFG?=
 =?utf-8?B?VFFEMnljTG5IMExLVkFvK3QvL1R0d1JEeHoyOWh3RSs2MFR2dlM5c0h3cHk3?=
 =?utf-8?B?dlRnQXd2VmtrSG1YNWdTOEtJbTRrblJiMlg1M2ZUUWo1ZE1SOXpKeWtMWExs?=
 =?utf-8?B?a0JmczVaRzB2RWhySWgwVXE3bVB3K2tWWnZWZWVYYVZJM0o3dEE0NGlnd0Vr?=
 =?utf-8?B?MHhneDFjL3lJSkVGdlN2UGxxYks1SVpLS3hWU0l1bmowRHhhTm5ndTRFWkpJ?=
 =?utf-8?B?RW5vV0dvV2cxclZmZ0lraHpIdDBVclZhN0VtZ0FwSktyQU1GNXhRRk9Bb1dK?=
 =?utf-8?B?K0QyTlduZFlONFBFeDFKaGREKzN2b2pWSG13b3hYY3lBeUhncFhLdHZqRjRS?=
 =?utf-8?B?S2VTdDdENUdtaHJmY2szelNqSWhsbHltVWd6WmVpdjhDS1NneCtGOFJ1Y3VQ?=
 =?utf-8?B?NC9VWW1sc3c5Q1BZWWg3YUl2QmQ0ekdVZ0RmT1lhT1BYRkltOEtVZ1dNcnZD?=
 =?utf-8?B?Ry90NXVNTzlhb0gweFd3aWFjZ3MzZ1FxNmN5RVYrQ3RJSHYvQnRjYlB4L0Rx?=
 =?utf-8?B?b0FJTEZidE5oVFpjVnVPV3NDOUNjL2FkQXo2RnpjdEdoSWJMWUpySTlmbW82?=
 =?utf-8?B?Z3BWR21KT1l1d1dzVnBROG5pUkdLdHFZd0ZHRUYzcjR6SXV3OFJCSTBhYm01?=
 =?utf-8?B?eXNOYkVUcUJtN3NYZ0FSZE5JbVMyUXQ3OXpNRzQ3WU5sSTVOY29wN0gyaUJp?=
 =?utf-8?B?Vkp4a3RkV2JQZmZLNWVkUS8vdGVnT1E0L09EdkRJWElxNEl5eEJ6NDlUaWkz?=
 =?utf-8?B?OTFvOW5TU0w0U3dCdWYra0ErNitYVkQvenV3a09UV1ZsSUt0aFBDaHlnbXlB?=
 =?utf-8?B?QkxwUDFvTzN5UmlxaldodUdqbmZ6TCs4TDlibWRHeW5sY0VxRy83RExhOUV1?=
 =?utf-8?B?a0ZWaVcxZ0pqYVN1ajhTYVlGS3I2QThRZnBHcTFxaFFNcFBLRFhTL3pSVW4x?=
 =?utf-8?B?SDgyV285cExUTjZVOGw4cWJtWHozZ2xZT292eDB2V3IwaDlHMWRZdkljQkZo?=
 =?utf-8?B?OVA4cjhaSWx3SlUzVEREVEtIVjc0TE54RGFhYzhHVjA0a1NEcS94dXN6SGN5?=
 =?utf-8?B?STdQd0NQQ3FwUzB1UHFmOTdhUHliMUtnYko4V0VUUVhTMnFWejRmdE1pUEJQ?=
 =?utf-8?B?OU9aa1dhbzRIRmFmd250VUZTMG1NSFlQNTJGbTdwMFF6aGxTNmwxRFdLVjBL?=
 =?utf-8?B?MTJXKzVhMkY0KzF3dFUxQ0dHdHo3Ty85Y1ZlS0xCOVdBSFM4Sjc1TlpKQWhj?=
 =?utf-8?B?Wk9FOFJvcEVyVzZLVXZNRElqMjFIK3lPa3dXcis3RFlwNUNweVFzWGdhKzJI?=
 =?utf-8?B?Q0hMTStLZ3E1aFpweVgyVmZZa2tma25iUkxuSkxpSE1ERzR6QlpwZ0swcFNO?=
 =?utf-8?B?YkZaQUNEUE4wcEduT2E4d3BEMGtXeVR2cEZ0NjJ3R1hnWE1NWXRmc2ltdzRX?=
 =?utf-8?B?OUlRK0dCK0k0L1dhQ21yZ3lzSUVpbHBHKytFMG94cUFDdlhDWEVwN3RuNnF3?=
 =?utf-8?B?L1dvOFBPVGRTUWdCbEdUZ3RmaTFFWk5sbThaVGJldkRGS1NYd2xKWHR6Mncx?=
 =?utf-8?B?TlVxdDhwSlJTNWVxVUVyaHh5ZkhwSDRTZ2pkdEVPVTBtRjg3Tk8yMlFtaVgr?=
 =?utf-8?B?Sis3QklyVmhKR0NFcHhESk1HUEQrdnRtZ3h5OFc0UmJFcTZqcFpxSGQ1WE5L?=
 =?utf-8?B?K01XbDZqUU1aa3VWSjRQUXk1azFTam5FcGxCcTBIL3JUQ0F3VWQ2ZDQ3cm1z?=
 =?utf-8?B?S3RVRFZxMjJYcWN2T1dzZno1eW9MMHl2V2VEUnRZdFRlSzNoQlQ5aXRXUUU2?=
 =?utf-8?B?dCthK2IvcHZTQ0w3QWk4dVVLRTNrZ25vVjJuQlZVd2Z3WTBQYnhHd0ZBT1Zi?=
 =?utf-8?B?ZlQ0Uk1xTjYwOG40Z2J6UUFja2JQeWpqY3hWVHBTQ1ZyUFV1VTRsU2JzOGlE?=
 =?utf-8?B?RFRENGF1eHN4Sjk1MVRSQ1I5WnhaR1NHZEtia2l3TktwTmVNK1l2VWIwNEds?=
 =?utf-8?B?Vk4zWG4xVjFVWUtVVDVJSmRBa2hCR2prSlNFVHdXYjB0cCtocERTQkZUendn?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 660d39de-2711-4f79-3b3a-08ddcebfec71
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 16:49:46.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nu4J2sHFpxkRjyJzC5fYJ17wjsmxolw6EBGHuF1hFwDYxiDYdadqy/P+ueLtkBD5FYy9fqS5M+6JjUJlIPXeJm76dVqRp8Ee/cKW9GJ//kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
X-OriginatorOrg: intel.com

+Babu

Hi Huaicheng Zheng,

On 7/29/25 12:53 AM, Hc Zheng wrote:
> Hi All,
> 
> We have enable resctrl on container platform. We notice some unexpect
> behaviors when multiple containers running in the same L3 domain.
> the  mbm_local_bytes/mbm_total_bytes for such mon_groups return
> Unavailable or delta with two consecutive reads is out of normal range
> (eg: 1000+GB/s)
> 
> after reading the AMD pqos manual(), it says
> """
> Potential causes of the “U” bit being set include
> (but are not limited to):
> 
> • RMID is not currently tracked by the hardware.
> • RMID was not tracked by the hardware at some time since it was last read.
> • RMID has not been read since it started being tracked by the hardware.
> """
> 
> but no explanations for unexpect large delta between 2 reads of the
> counters. After exam the kernel code, I suspect this would more likely
> to be a hardware bugs
> 
> here are the steps to reproduce it
> 
> 1. create mon_groups
> 
> $ for i in `seq 0 99`;do mkdir -p /sys/fs/resctrl/amdtest/mon_groups/test$i;done
> 
> 2. run stress command and assigned such pid to each mon_groups , (I
> have run such test on AMD Genoa. cpu 16-23,208-215 is on CCD 8)
> 
> $ cat stress.sh
> nohup numactl -C 16-23,208-215 stress -m  1 --vm-hang 1 > /dev/null &
> lastPid=$!
> echo $lastPid > /sys/fs/resctrl/amdtest/tasks
> echo $lastPid > /sys/fs/resctrl/amdtest/mon_groups/test$1/tasks
> $ for i in `seq 0 99`;do bash stress.sh $i ;done
> 
> 3. watch the resctrl counter every 10 seconds
> 
> $ while true ;do cat
> /sys/fs/resctrl/amdtest/mon_groups/test9/mon_data/mon_L3_08/mbm_local_bytes;sleep
> 10;done
> 
> ...
> Unavailable
> Unavailable
> Unavailable
> 61924495182825856
> 64176294690029568
> Unavailable
> Unavailable
> Unavailable
> ...
> 
> at some point the delta for 2 consecutive reads is out of normal
> range,  (64176294690029568 - 61924495182825856) / 1024 / 1024 / 1024 /
> 10 =  209715 Gb/s
> 
> if I lower the concurrecy to like 59 or lower, the delta is in normal
> range, and never return Unavailable. I have also tested on amd Rome
> cpu, the problem still existed.
> I have try this on intel platform, It does not have such problem, with
> even over 200+ RMIDs concurrently being monitored.
> 
> I can not find any documents about max RMID for AMD hardware can
> concurrently holds, or a explanations for such problems.
> I believe this could become even severe on AMD with more threads in
> the future, as we will run more workloads on a single server
> 
> Can some one help me to solve this problem, thanks

It looks to me as though you are encountering the issue that is addressed with AMD's
Assignable Bandwidth Monitoring Counters (ABMC) feature that Babu is currently enabling
in resctrl [1]. The feature itself is well documented in that series and includes links to
the AMD spec where you can learn more.
You show that the "Unavailable" is encountered when reading these counters from user
space and I deduce from that that resctrl's internal MBM overflow handler (it runs once
per second) likely encounters the same error with the consequence that overflows of the
counter are not handled correctly.

If you do have access to the AMD hardware with this feature, please do take a look at
the resctrl support for it and try it out. We would all appreciate your feedback to ensure
resctrl supports it well.

Reinette 

[1] https://lore.kernel.org/lkml/cover.1753467772.git.babu.moger@amd.com/


