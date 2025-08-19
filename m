Return-Path: <linux-kernel+bounces-776094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E280B2C887
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906467A83E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93742327A3;
	Tue, 19 Aug 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxH2Zq/+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF823AB9C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617561; cv=fail; b=KspywKeYpBy4WmwIUZex4KqOYu/qtXR5Aqma2DkRPybSkVQXx6IalBIyTqnRl02s6AgkHDMSSMn1gEwAkEecgtB0i1cv/AH4B7oH45I+sG2tzPbnUTZ/CGHMf7V9bOnE2L6owJI5GjYXmfq81dkU8GSpXWczkyq/Ns5JAJQxZLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617561; c=relaxed/simple;
	bh=OF7EU4//QZmt5SByTnn+naIwLCDx/mk3aBvu57nb7ro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AaErjDI1o0AcNaEWpdqyLWNjtuRRRS/BMXxgVPlvCxVa/DSQ+UzM8qsVbrYQzTkFNCrLCZKdsWyVkEindHkVZmQ2HVvj0acpsi8KH+9K0v0r4BCMzmMzxrJvJhdP7+DOj8vymKPb0hBt3H/TR3tuHRNXWWdhTgheQY0aPKlWg0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxH2Zq/+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755617559; x=1787153559;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OF7EU4//QZmt5SByTnn+naIwLCDx/mk3aBvu57nb7ro=;
  b=SxH2Zq/+RDAoHPso/ZTPwREilX+B6gL1JclQ6y47jJ+ZTkFF76lzeLpL
   3c2TkGX0o7LNMco4i9yhSyezwanqj8TtlV/jEsWDgZfyYr9JDmj9jjzUL
   ZVl3W+9UVigLBmREVL3mjcIgQw6Km+cEQ6p+/klUmDjfjic302hLw0XWK
   e8eiExQ9z/TFecggaM9BV7ldDfoZOwGc73fsBRiHyi9B5grm+ViQIlD5E
   Z+F7niYYw1xMvhKQcmCYID0atrsnxtYrKdi2qUjLVNYdXTMNT6I0nxaHH
   dfMC4AWOxWzoZAAzT5YKJIVNjZ3IJI3l6d03v0c0aBvkEdDVb+lpHOHIT
   g==;
X-CSE-ConnectionGUID: dg67jO2+RVyGbbFrDbqnUw==
X-CSE-MsgGUID: VTPt7YyiTliWZkrk4pY/tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69317528"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69317528"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 08:32:37 -0700
X-CSE-ConnectionGUID: qKJuOjlQRwWch6P1628L4Q==
X-CSE-MsgGUID: beHBMcXARTeJ77KW33CoUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173238274"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 08:32:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 08:32:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 08:32:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.89)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 08:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKVzxpWpCK1KTGLqO/aJyqdvq5vwKktxtohg5JDc4Jychq8K51dHl7vt/o8dMFZI0/fLXezSblAgLRRVr8RvPXWVr+w6W6iH0x64XoxruIBnDnUgJsDeC5i7jGuQ9J9Bc3To9yW0NBXxsIuR/PJg/EKcfa16S53w92knmdval2OX3Z3kZvK79+N4RK7/AypX7qtFxRIzrWPOpFPTR2UXUeZoCltqr0kZL9OF4Jh87Fls9czYlihn3ylYSXP67W9/0vGZo8rPFw031++WvmUZ0Dp3TYVbZ5Mbeis8k2G+ggz72Iqv8pQAcsPf16lGM90+dzABfRfPg8nC7W/LOeU24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4rJOZUhtpRUaA8sTjCGBtCwWqy9nZR4WFhRftDKsxs=;
 b=Yk5jwsFt5zgX5coqRe6FdHbxFVUqcFYh4xLH3LqmUL4aHDssDybqxfhHcuOFrpoB3WzRiMD52I10Jf4UK58BJxUpUNKkKufdSl2DwcCLG8vy5mAYFSwzmTStt9AYw9QDKderHJV88fKz71VBTbF1CTxODiB9ADhWBSWhbRXnJ/oCsjLccIa0EUm9J49AK3PNUqdTHrmEkoW36esXaXueJp8OZMt3/9/5QmlgKLkdeHePjf+Y0lExdurQxXKV2U0BuM4a3mAto8+DaoWyVB+dcTq1spcUknheGReP4MUc85y020kPb8c0dxKDPDuEcWSLOFYjUHuL9qu/THvT1DgzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 15:32:35 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 15:32:35 +0000
Message-ID: <e13c922f-2b51-4b4e-bcf8-617e4799522a@intel.com>
Date: Tue, 19 Aug 2025 23:32:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/fair: Remove sched_idle_cpu() usages in
 select_task_rq_fair()
To: Christian Loehle <christian.loehle@arm.com>, Chengming Zhou
	<chengming.zhou@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <bsegall@google.com>,
	<vschneid@redhat.com>, <juri.lelli@redhat.com>, <rostedt@goodmis.org>,
	<mgorman@suse.de>, <dietmar.eggemann@arm.com>, <vincent.guittot@linaro.org>,
	<peterz@infradead.org>
References: <20250818124702.163271-1-chengming.zhou@linux.dev>
 <87212818-1f59-45e4-9a51-dca62ddb9633@arm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <87212818-1f59-45e4-9a51-dca62ddb9633@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: be5b21cf-2c1d-43eb-d35f-08dddf359ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm50STVBV3M4UW9yaWI2ODZ2azBIN3ZnT0xqd3dVcmZLUGZja0JSbTZwL0RY?=
 =?utf-8?B?b25Qc2tSTlJTN0FLaFhUZUJIRXdaWlNSS3RHbGhBcnNXL1h2dkNDWHJuMUpw?=
 =?utf-8?B?YThDbFdsRGcyMWY5TnFPd1pnVjNKd0wydGVZdkFFRFl0YWN2aDhJN3V5UVNC?=
 =?utf-8?B?R1daaVpBZ3M5bmQ1c3RqQ0JpZDUrWkVLbFAzdUF2MHA5ZmFHTGJxTjNFYS9a?=
 =?utf-8?B?bUlvVVoyamdpTUk5NXdNZHpVVDYzaUdWZlV1ejZwRDZvaTlXSmFlTmdxN3Yr?=
 =?utf-8?B?RDFIeEdQaGhSeWFyWVdRVVFHTTJTTHIvUENmenBoTUJmeEJJZXBVTm5TOFFF?=
 =?utf-8?B?N2RhampaeU5kM3FtdU1VM2Z5SVRpMkxIR0VHZWRXcms1STNZdmNFalk2TjhD?=
 =?utf-8?B?K2NpM0xpMTdINUd3RVEybkk3TENuYTk1cVY0bXZwSkQvRnd3cS9pUk5zNStM?=
 =?utf-8?B?ajhOajNDMWJ3NDg3ZjJpU1J0MVU5QXpVV1l4RkZITTFSdWs2UVNjKzFLVldZ?=
 =?utf-8?B?MHhIZ2NGWjVlZUppNHBOK2xrYWxYQ0lQRlVKd2FNTXE1QmprM3FqNU9QVHVP?=
 =?utf-8?B?OElnYTF6Z1VJcDR0aitULy9zNEtrb294Zm5Vckc2VHY1bUpENVU2NWFoUXlt?=
 =?utf-8?B?NU5BQ2F5dytzR3N4d05PQStlN05qTnoySjRmdjZWWWduN0pjTXY3aXZndXN1?=
 =?utf-8?B?bmd6a0pab1J5UWJhK1UrS1dMTlA1SmNxcm5hN3FyUVpBK1VzemxxYzBXN2xw?=
 =?utf-8?B?bGlEQUQyZDg4QlBNZDhwSnRvSEFGTWRSUEtBcmFHbVEvYzdiWHNpWUoxc1BU?=
 =?utf-8?B?VUtkUTJOem9FMmMzL2RLNnZYNWQ0S1prTGpXWGkxOXVGN3RzbnNzczBpbi9U?=
 =?utf-8?B?VTlKRllwMVlKak43R0tldU5EMW1sb0NxZGNHZmhJWVBqQ0d0MGFZZHpRUGJR?=
 =?utf-8?B?b3dzaHBsS09rN3czRytPWE45OXNNclE3azV1Z2pieHdKWVNUMTJCQ05scGlU?=
 =?utf-8?B?RXRzN3RhSnBubWV5Zy90d3B4TDVSQmZwT1NDSlo1ekRmcHh0NjIwSTIyeHVB?=
 =?utf-8?B?Sjh0TkRqRmEzcktWUGloKytPS29KcU4ySklidm5XZWdvVW5ZdUpZUFJlQmtP?=
 =?utf-8?B?NG5IMDZDeXEyMkdDNkRIS0JacXI5S3BNZld2U3RPNHNQZWU0QmNiQ3pXTDk0?=
 =?utf-8?B?aTVLNWNNaWJwdnJuM2xJblpGTml2MmlJaFJLQ1p6RDZGV2RLM3dtYVJxTUl0?=
 =?utf-8?B?Y3NzY0cxWDUvdzAwSDRxa01sVmJCejRDMFNYeVFMOXpnNlpFd1M2eng0MDE0?=
 =?utf-8?B?QmlWNmlRcXBRRFhDVlV6dmtUMzRxZ0x3aVB3YlczWnFreVBSRXBFRVk4cUha?=
 =?utf-8?B?YWMrOWJjaGVDZlNQK1phdnNjMXI1Q0tTUDRJTVE4K2xYaU9SeGxKZEpQcUQv?=
 =?utf-8?B?ekpMTzVOR1V5Y2pwemV1MFdUL2FDOS85ZUtuTDRLUWt3cWY0VnJhMlNVRUNO?=
 =?utf-8?B?V2MrTEc4d2U0T0FjTFVNY0JjZ1RiYWxvTXRHWjd3UkxqN3Zwb2xkZDRuZXpE?=
 =?utf-8?B?aXhzUzkvcVg0ZVFCNjJvRU8zZS91eTE2L3ljSmNXSytRSlo4MmNIUmNQZkdP?=
 =?utf-8?B?U0lYMlRJcUQvL2R5NUVUOUc4YVVNNWhkeWlnN2dZdnNUMC9HN25yY3RHZTdX?=
 =?utf-8?B?cTUyL0ZNUzFmcUd2YmpvQWVmemQ4T3BHY0lTdlBiREQrK3pTcmVaejZRY2xt?=
 =?utf-8?B?MjZCbnFZMnRuVmdUblNQOStFTEJUMDZWd0owMDh1V2E3SFVFK3J1Z0E4aW1s?=
 =?utf-8?B?QXUzdFhCU21PN0ZHVEFPWEdIRkNqRkxjUU9hL0ZQbUVmMFNSSXhmWCtyVG1N?=
 =?utf-8?B?eUpmY2w4QndrN3ErSFprbWpnOTJsbm5IOXdmYmVERUtubDk0M3dPaFZjUDQz?=
 =?utf-8?Q?7fPFH8+v9cQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHRDQlFabkM3eElHUDFka0w2N2t2UFZEUzIxQjBUdnhXaU5Zb2pwUnE5SW9W?=
 =?utf-8?B?UnZ4UGJUMEJMVk5ETjZLNWlLWldkMmpVSmF4QzhKYWlJYW9FOTJZWGdmUHBM?=
 =?utf-8?B?UWIzdUdmMmJxa1hlMDNVazJ0YnEzcUNZWWJkTGpJeFJQQ2lxMGs1MngveHM5?=
 =?utf-8?B?N1F5b0Rjc0Nad1ZCekkvQXRFTGhYNkJsajUzOUhXRTlwRzdUQkdwZ1M3Vi9I?=
 =?utf-8?B?Z053SW14SnZXTGgzYVk2SEpGbTFpNzQ2RFNNWU1Pcmp0SENLSkZKcTJuUDV4?=
 =?utf-8?B?ZlpZOCtneDEzeG5Gdys0LzkwZUJDVzNTdmp5ZU8rNkdmL2F6UFlabzRudXNu?=
 =?utf-8?B?Qnd4QWpsQXQrSGdYd1NjWWwrOUVYb3gvM2ZHNzl5YnptcXlldDFleFVzQXQw?=
 =?utf-8?B?Skp4cnVqY0hsUm5BTEludWdJL2JMZmp2Ty8xRUNJeE5wN2RVYVFHaUJmZjg4?=
 =?utf-8?B?L2VxTjJoNzVxL0xpb1gzQ2pwWG5kTmhRWGkvNDRXZVdqV0R6MWFnZEpYMWNJ?=
 =?utf-8?B?MkxVTFM5RFNnai9PZHZoVmNlN0FBQjlpWXRtdGtCcHBocmVPL2k1bU9lc01J?=
 =?utf-8?B?ZXU3azJidUJyYStQZ3pxYjJmZTJvbEt5Szhod283aFRXMlpHenkzYmRaeXBY?=
 =?utf-8?B?aEN2RFBpYkQyTUx3Z2toUGZ0dk9tSlRqVFk2TkNkQ2pIYlJ0MEY1Sk5oWFNk?=
 =?utf-8?B?NTNLUXlEbmpUVDZVdmNrbFkreE0vR3lrWmhpRXhrdFNQOHlMb1MrNFdpTVp3?=
 =?utf-8?B?eU12R3VobHZFT0NVNU1sdDBFTVVVOHB1U1VWWng0SzRxN1JIZ2d4V005Uzc4?=
 =?utf-8?B?ejRvKzIrd21teHkxMmlvVXlIMTBFY3UyQy9tMzlyR0pzaGNRTjY5OS85RkEz?=
 =?utf-8?B?TloreHpzYWxCY09aTVViOGl2WVRoVUtEZU9FNWdNNDZvbFhlSDdvcFpUdm5r?=
 =?utf-8?B?MHFMN0kyUVJuQndIS3pBQzJmV3dIZ3BWMEpnOUYxU3BZaTRGMWF4ZVNqRDBx?=
 =?utf-8?B?OUpON1QrcVBFSkdQa3pLbjg0RFZHaFlWTFIvOU9hU3NFZ1VzNWgvSThRbUsv?=
 =?utf-8?B?alRIek83dE1rU3RTOWJBeDl6QmU3ZG5nVlg2ejFSRk1DNGdJbWIwb0Z3Qk8x?=
 =?utf-8?B?eHJUaUNIcUd0L1I0SnAweHhKT2kwZ1lVdmtaTHNEbTQ3MmhEUldvSDBIcTlm?=
 =?utf-8?B?SmxnK2VvdnRPaFFZcnlZRHpTa1Bpa2RMbFFkOGs0Rmd4M09wT1F3Q0V1T3BG?=
 =?utf-8?B?K1dFbXZCeUN1WEdvL0hFWGdGWmNaaWxFVmtMc3RSbk81czhIM2hnd1VjeGtv?=
 =?utf-8?B?NlJBY2puby83bG94eXF2UEp3ZVJ6UmhDRGh2L0JwR3JpNjQ1TXVidDdsNTdW?=
 =?utf-8?B?TitrVy90eDBLSUdpZDJ4V3hhN1JBRElyNWpRY0dMZER5bVJndURMNHZtZWk0?=
 =?utf-8?B?VVdyMXUzWGQwdHZSUzFFaWpiRmtBZTEvQmVvU1VtNDVDMm5jTk9uUEdHMk5Y?=
 =?utf-8?B?eXBpTmdxZjlGTWdMTTdBT1B6dW10SnNJck90eW1FNWtIRldQQWEyQkZFcW1h?=
 =?utf-8?B?RTBmc0EzbExvWndnejJWREZSVCttcTJXZjFkVno0dTgvNnhYVDBSemRwZjYw?=
 =?utf-8?B?SkxNNTNJeVl2cEJKN3VYc3NTQU5ZTTZXQTAwT3dZcW5idDNaeHpaTGh4NGxt?=
 =?utf-8?B?OTdYUGhwSy9UZmsraEM3VXE1T0JPZmxNMjNtcklDaExDeVZxSSsyVU1ZeVV2?=
 =?utf-8?B?MFVGd0lmcTZVU1VSVDF3K0xFRkhHTTlneTJ1OUZzNStJTDNCSGlYL1NnWHZ2?=
 =?utf-8?B?SU9aNVNkd1VueWtET3pqRThCWkZhTDJjVWRZeCtXSDRRVzJrSGczNVBwRkRa?=
 =?utf-8?B?SkU2bVVLcVRjSHZ5MDdmSXdkcFU2VTJNQ2dLVWE0LzdWNjMvdTRzYm00YW05?=
 =?utf-8?B?T2czMUdkT2NEc2FMS0hCUlZiRFNqdkFRSXVicWE5M1dNZlBNN0VCOTc5OXBi?=
 =?utf-8?B?cTNsVXJyRW94akJ4L1pMckhpeDIvYmlFSkpXWThhZGZEbjNsL1diRXdha1JZ?=
 =?utf-8?B?OFpqY2Vtb1Jzb1lWeitSS0h4eFEvUjUrMTljUnlaYVAxOStZUUpKSmFDSlNN?=
 =?utf-8?Q?xZ7xEIjqZ+ymf094hsTG+Zgr8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be5b21cf-2c1d-43eb-d35f-08dddf359ee1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:32:35.0044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLD59NvNr3fjZAOLRUsKoWRjIIxD7b8r35/YUd23m7WcAt2Hyw4Zx3BVVCS4oG0Td99rGxCR5pPvPIWRRiIESQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

On 8/18/2025 9:24 PM, Christian Loehle wrote:
> On 8/18/25 13:47, Chengming Zhou wrote:
>> These sched_idle_cpu() considerations in select_task_rq_fair() is based
>> on an assumption that the wakee task can pick a cpu running sched_idle
>> task and preempt it to run, faster than picking an idle cpu to preempt
>> the idle task.
>>
>> This assumption is correct, but it also brings some problems:
>>
>> 1. work conservation: Often sched_idle tasks are also picking the cpu
>> which is already running sched_idle task, instead of utilizing a real
>> idle cpu, so work conservation is somewhat broken.
>>
>> 2. sched_idle group: This sched_idle_cpu() is just not correct with
>> sched_idle group running. Look a simple example below.
>>
>> 		root
>> 	/		\
>> 	kubepods	system
>> 	/	\
>> burstable	besteffort
>> 		(cpu.idle == 1)
>>
>> When a sched_idle cpu is just running tasks from besteffort group,
>> sched_idle_cpu() will return true in this case, but this cpu pick
>> is bad for wakee task from system group. Because the system group
>> has lower weight than kubepods, work conservation is somewhat
>> broken too.
>>
>> In a nutshell, sched_idle_cpu() should consider the wakee task group's
>> relationship with sched_idle tasks running on the cpu.
>>
>> Obviously, it's hard to do so. This patch chooses the simple approach
>> to remove all sched_idle_cpu() considerations in select_task_rq_fair()
>> to bring back work conservation in these cases.
> 
> OTOH sched_idle_cpu() CPUs are guaranteed to not be in an idle state and
> potentially already have DVFS on some higher level...
> 
Is it because the schedutil governor considers the utilization
of SCHED_IDLE, thus causing schedutil to request a higher
frequency?

The commit 3c29e651e16d ("sched/fair: Fall back to sched-idle
CPU if an idle CPU isn't found") mentions that choosing a CPU
running a SCHED_IDLE task can avoid waking a CPU from a deep
sleep state.

If this is the case, can we say that if an administrator sets
the cpufreq governor to "performance" and disables deep idle
states, an idle CPU would be more preferable than a CPU running
a SCHED_IDLE task? On the other hand, if
per_cpu(cpufreq_update_util_data, cpu) is NULL and only shallow
idle states are enabled in idle_get_state(), should we skip
SCHED_IDLE to achieve work conservation?

thanks,
Chenyu




