Return-Path: <linux-kernel+bounces-739172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0317FB0C2C6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197DB1888108
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A171296178;
	Mon, 21 Jul 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+hJG649"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A0293C56
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097054; cv=fail; b=B7PH3oBtpP7y20RGIDJQgbRa3VDRj1U4xdKXjMCbI3LEWTwTubZG1d6KTLDO3S+uwBEdA8l0OSNnenPPi/4SFg/7z4XXqBDpBNi2KHG6GsPgZuGJth2JK4RlLgEqhW3HtDGjL1RY6J1Qk0XvdZYypKrEQrq1fX57J6LRnjGExkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097054; c=relaxed/simple;
	bh=sA0lOpSzD1/iyGRg36Ls5W1HZgWZ4600miSJ+kZ4KLE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TNLmw2uHZqH3Zpf/ui8XFfMGyZjPlOYjlpcnWcU8whK8EPzuzTBOEsfLWfmadzG6H6rBmSRSEIgD7PS+iKTEaSIWmOUKp7Hjdp0lneSt6Yxm9ZTSzv+KZeevJkCfe8pGLIsfCTniynBm8fXZocr8n7QAzDIojXUyauZ96Z4sDqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+hJG649; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753097053; x=1784633053;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sA0lOpSzD1/iyGRg36Ls5W1HZgWZ4600miSJ+kZ4KLE=;
  b=h+hJG649HI4yxA9AgUM6Z3JfzqccfknRN7KRsmifoPlZhfPVWFBz/V5k
   fb7OrAAoH/Db/rGfDv+B0SYMytBu6FfwFeSNSDKScW6pU0X3IPw2ljQWH
   sM7+9zXKKTWh8GS+ATZ8+SBbHjlW5jvMnEBxAh1IX+h/Fzt5y8Y9jjI/5
   d+x0baHpiPDuMH/rWWGlyFUsUutNQACg8CxGUvaaZYxx8qBxoCbEyMg1l
   ZEmQHS71ML1TiBgOHJqDiL1pDPJxmzdeP4L/glm5PdAcCnDZl9bQLSPFn
   +jvYU/ABOgZI8RJnMJepC4X50AL13AoiW1snwv0KUkWFV+SMqHjQ184aa
   g==;
X-CSE-ConnectionGUID: zZhOLcloT6q7iNCXk5aZ7g==
X-CSE-MsgGUID: E7eUw//0SYyBXFVJIWVbww==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55267469"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55267469"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:24:13 -0700
X-CSE-ConnectionGUID: Nt4XdyxBQWK2pnMVNmlJsg==
X-CSE-MsgGUID: WG/KyjJyQua3vGp1OgWY5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158124351"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:24:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 04:24:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 04:24:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 04:24:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uX32gYtTbhu4P0pwiJbLhrgUh/aF0MREMzrn7UNeucrDSkSrQuh3se3HuLZcuQD44UIjEmEZ15BwTFx05JZDhqKLg9wjGiLYn0oN6F8uUI5GIAKGd8588Bg5oX2Xw5LJC703iY4tEOaXIs03hnGqREqulrLY/v2AyIY7w3fyAt89RQrGPjt/m5TBQ14nLT1Y5RVAheyyux/MR5GG4D2Q/SLonGvOWlS9W0eUUXPBq38LK1mdCefekZLS3uB6y2vCZLrXpw0sPpqVOgBcxiEdlPpyMhRPwi7haHAE12tjQrSEhZ7Iblkj8FCVukYU5RjOfF7BScHCUt9AM+CsPwkCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBBAfEKY/HHKmKckttBePrUfDyjSKIYas3QWQ/W/BTM=;
 b=S10CiZPIT8n6EvHAc43RqiWEGvvAKyWWIfKnzcxPhKXqaOEIsk6OMQmfhkxMZEJOotVPpsKZ25IF+zvRtc7HQtRjcY4MGIIg8kThc1EW78oAhvOOJLZHmB5LqCtO3qwouGOQ1B7b08gEQPtvlfePszDyZiH5Ko1zUQpTwS6wfWDO0sP5YXQAaykKyfCdFGxBs0oVdPPg6bVWPwIjyABMhixAKhH6+cH1ZdI/JGXNsVOa1m9ih5+n8NrOTPWewZpsZbTrOInHHZeqmL2fXTUyMjaWAhwbbRsLr9gol4O8hGjZcRedHo4oqH1hLNE0DEN9MLCLO63mx0nQF/cTGaL1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB8083.namprd11.prod.outlook.com (2603:10b6:8:15e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Mon, 21 Jul 2025 11:24:08 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 11:24:08 +0000
Message-ID: <36eb3d2e-03f3-4829-b0f6-94b0f3371629@intel.com>
Date: Mon, 21 Jul 2025 19:23:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched/rt: Split cpupri_vec->cpumask to per NUMA node
 to reduce contention
To: Pan Deng <pan.deng@intel.com>
CC: <linux-kernel@vger.kernel.org>, <tianyou.li@intel.com>,
	<tim.c.chen@linux.intel.com>, <peterz@infradead.org>, <mingo@kernel.org>
References: <cover.1751852370.git.pan.deng@intel.com>
 <3755b9d2bf78da2ae593a9c92d8e79dddcaa9877.1751852370.git.pan.deng@intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <3755b9d2bf78da2ae593a9c92d8e79dddcaa9877.1751852370.git.pan.deng@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 581c13c8-9e5b-4928-64af-08ddc8491bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGtQbjhVY3JhUWJEM0FtUHhuWUx6cEVXdXg2c3ZRc0JpT0lsYWwzV0tMdzUx?=
 =?utf-8?B?Wnc1Lzd3WVZJQXprMW1UbTYxa2F0T1liTnlwZjFOdnlvUW1tMVMxbmF2YzRV?=
 =?utf-8?B?QVRvL0d5VTV0dnk1eTFFYzUyUnNOT2VmOVN4L1k5N2NJelU0QzNxczRqNkhQ?=
 =?utf-8?B?YTNvUXN6V3VkNUhOUSthUlo1L0ZBUXpQbXJYNFlYS2hKYVB1ckx4VHB6L3Zr?=
 =?utf-8?B?NUdWTVhQODAwRHpsbnhXNkZpalppYlFGcTZrVTJ5R1g1aFEzdHljR1VBakFW?=
 =?utf-8?B?ck81bzJWOVUyRElSMWN1NGxqWXY3bFJ5QnF6U2JtNTJlV1hYOWk1R3JpY2lw?=
 =?utf-8?B?eVVWeVU3QUtIWnRiUmlUTEFxclcrc3dxditjaW1VcGEvYjhmY242b0w0Z0RS?=
 =?utf-8?B?N3RMUW1SWFFqK3NSVWtPVkI1SnozNUlBcytBV2l3TWR3bllFUXFNVmlsVGtV?=
 =?utf-8?B?U01tdC9sSEduVFdIYzhFV29zdjl5THZIaWVyR2tTWTdqYVFpM2FrY0ZqY0wz?=
 =?utf-8?B?MFNRd3F0dHZ4YkI0enBlV25RMGE2ZGxRTFJLS3NSbitvdDR4am5RUkJISUlO?=
 =?utf-8?B?ZDVkenNLTzNRaTFYdkE5dkxJQ011VUQ4QW40YUdPdEdyRXBpRTRtSHp2eWVa?=
 =?utf-8?B?ME1yU2hMNHU4cUw3dWxkREtySVJPTWVJV080b1NCV1NPdXlrMUpCR2xvQWJE?=
 =?utf-8?B?RnZ4UVpLajJ5K2ZDaGpNdE1ROEVRQWxQQXhkVTFvczlWUkZEbXdvdlFxaGdu?=
 =?utf-8?B?Y05KOXlodXBHdWhhRmN4NnM1bmNTM0M3Mk9QZzNSd3RBZHVCN0lvZ1FVcy9U?=
 =?utf-8?B?OU1kRCtKWXVQTDRpNWFoc0NEdlBZUkt4a2FOV2lxOVZPeW85YVpKck9xalFi?=
 =?utf-8?B?VHRoc0Y4T2RtVy9CeEduWkdhTjBRRThwUjlsaFZZd3dsb2lZbDVRQUZUMGdj?=
 =?utf-8?B?SjdCVmFsaFVzUnUxS0xQVUVkOWVwdTNpbDVya2RzMVdJcDg4ZkxFWDh3dXpt?=
 =?utf-8?B?MmlJMVRGY0V1N3VHK254NFNvc2RYNnUrVnRRMGtTNTNiRDI3T3huWjljZ3FS?=
 =?utf-8?B?L1lnWnFSNmdLTjRkNFZVbmF4NGxXWjV0c0N6ckRwNzNEN3BkTHJ1NmN6MDll?=
 =?utf-8?B?bm01WUovai8vSWIrc1U4blhVeGwvZTFYcjdDV3E0QnZBOXhqVzQxNWZZeERF?=
 =?utf-8?B?ZVE3a3B6c2NNZDJhTEwwejlqWHV0UHRzSEt6UDNxOFptQ2gwU0xOQUZGUXFF?=
 =?utf-8?B?Rm5OVmVWZ3JBWHhNaG10R3pYMXUwK0RMMGdZTTZ6aTd3eEdCTmlxNkdEa3RK?=
 =?utf-8?B?THh5WU90RDFSZUNCMmZ2UUd3SUlMVXNpTjJzMWZGOXhMdFRMWElkM2JVR2tj?=
 =?utf-8?B?R3pRaWlsRElpeElLRFdpRDFTREhwdXdKbWx0dWlBeDdZYUZadi9DaTArejBK?=
 =?utf-8?B?NThkbGx1akVKNHlDQVkwL2pzbHFQNFlGbnZ4Vk9XUzU4MDZFay9FTnBiVTA0?=
 =?utf-8?B?TDVmOGJNUzVpUkV5WEw0VElnYndtbUw3VlV3ZVhrMUNDMzRxK0NSZTEwTDQ2?=
 =?utf-8?B?NkxjL012UmVNR1gwVFFnOEtRN3VOTG4xNFpNYkl4MFZYMHRJWGVVb0t5U0RZ?=
 =?utf-8?B?S1BuU0hzbytDU1B2Z0dyVEwwWWk5QUxaQzB6Z1FUR3BvYmFCZzA1d0VkczlH?=
 =?utf-8?B?S1ovZzVvNEtBUGtqM3JtMk4yTmhnaHZFM0w1UncvcXZIUU02TmZvT3VJTzdC?=
 =?utf-8?B?ZW8yc2lqUEVrWDlrK3lYdjg3RjA3Y3hGSWNjTnlINC9GUGdrak9IcXBnTU1w?=
 =?utf-8?B?T3JpSzdvMDNWS3I0bUhIQWZtUTlJMzcydEJHZEt3ZU1KWmFBUEt6eUtENXhC?=
 =?utf-8?B?Y25KV0xJL29yai9jOXU2OUlEdHl1RWsxSHJwdlpwWUErMFJYZnMrdjNPN2pa?=
 =?utf-8?Q?rOT4tHcmD7Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWZycVpnZEFZanFUYzZwTWkvYkRLR3F6YWNCZFE2eXdITFJzVkRCUzlOVTRt?=
 =?utf-8?B?WW9CVTlKV0Zka3gyU3U2RitXNXVQR1FINklueFUzang0MnpnSTRTZXdvTDVo?=
 =?utf-8?B?akpRY1RiaDlKTGNSYTR4cGJPQkVJMmRwTDdHaXBCSGVXZG4raUJwbE1LRk9n?=
 =?utf-8?B?NkoveFh6TlYyTFY2ZmxRdGhYektjRTRUcHdQcHl1bm8xTHV1TU9TRDM5eitW?=
 =?utf-8?B?VGhmQVhDQTZUYXRmWW5OdzNxRThVVmg3YjNNWDlVRit5RkZyWVBFNW9RQisy?=
 =?utf-8?B?U2FuVGtNSUNTYjUybXlYRFJlOFI4T2M4Uy8rNUdDbzlXbjJvZTlFZ3hLSDVQ?=
 =?utf-8?B?LzltUld2c2ZqUmN5Y3Bnb1FxNkF2NHBNSUp4SjZTMmlGSVFadVlwWXdVY3po?=
 =?utf-8?B?SWtDZGJlMEluMmpLL2NDTGtPcXdwQVdpK1hkM3VCb0J2TWtjU2ZXbFV3V1hY?=
 =?utf-8?B?ZllLSlB2RGFOcTJwaEcwWHNvUGV0czV0ODlROXpOakxNaDJqYTR5U1pIZHA1?=
 =?utf-8?B?K2E3MGttbGI0OFdhQUZuUzhNQlZZb09aajlYQ0hqODRiRVJIcGFtdUlzSlY3?=
 =?utf-8?B?ODVLZUljWFMvK256UDk5eG1ONGVoSHcwY0dsRDNKMUhTNzJPaGU3ZmZiVmxp?=
 =?utf-8?B?WmNFd2UrOUlTZUswQUZ3ajBzZVFDWE40Y3hkWUt1RWlUNk44RnFrSU4yK0J4?=
 =?utf-8?B?bXdHL1ArYnoxM0tyOWZmM1BLZGt1aDBEQ2hJU0g4cE4vMndiWFpaaTF1Q2xV?=
 =?utf-8?B?dWIvSDFIMThYNUJJK1Z3MUxnL2xOQnVTb3J4dnI2emhOTG9raDA2WmpkNWNw?=
 =?utf-8?B?d21IcitDNlY4TVc0QUh1ek5TMVcvNnBuMkRQVXRCdEJKOHBlamxUd21oZUQz?=
 =?utf-8?B?UGFoZzVFalUwSWxXdnQ3dGlTeXU5UEZUSGtaZFR5YmNCejJ1cFpRUGs2QnA2?=
 =?utf-8?B?MWR6d2FRTGdzR1pFbDFRM016U25NMjFBVzZVZzdhdUdhLy8zc3Z5cXRnbGVa?=
 =?utf-8?B?azBrSHdEMkdOVDdhbUdNZEZGS0lkR2Z5a1AwSG9qY3laMUhwQWo1V0d3R2tR?=
 =?utf-8?B?MVllSzZxK2dBbVhnLy84KzN0U3lhV0lBOUI4c2RScmJjdk1YWk5zdmVTejRG?=
 =?utf-8?B?Qy9SeFo4K0p2cDhJTG1XRmEyTFcycGtaeG9Ld0ZUQWRXZ0JBdm9nT09BWDI5?=
 =?utf-8?B?NVpKOWNZQzVaZ0UvaFJhKzFld3VQbVB3L1dPQ284eUVGWXRSdjYzTGVxaHc3?=
 =?utf-8?B?T1VZWUdBV21ieUFhcW9jL1JtMjlqZ1lUa2k3Y3FwelJLek4zSGRKWmtHNkZu?=
 =?utf-8?B?TG44dnRoSWlxdE1jYXkyUlFMZkl4dUw3UVo0TEFzVlEzdjVJaVJnUnZhWTVB?=
 =?utf-8?B?c3UrWDIwazR4YXdnb1VFd2ErUk00czFqdEJOK3ZJOU1GWFgwcXZvZk1KVFc2?=
 =?utf-8?B?QXJYQ1M4M0pCZC85MEVudm1HUEFBNHJ2RkxMQ2lZSmlDMU9sUnMzSjlPWjFY?=
 =?utf-8?B?MDl0WnRUZThBZ1haQVhQV0puVnFsSEs3MlJTdkUzTTErMXBYWXRyREFxcEk1?=
 =?utf-8?B?cVNlbGJUZmNtVURsYzN2NXZXcFVnTUV5UEJ2by9OSStTM3R1bzl1UU81R0pP?=
 =?utf-8?B?R2xxaVdzaTgyUytxYVd0TmlxWUx0MFNhM1RBUVc1eW9yOEw4Z1grWDJ4UEVw?=
 =?utf-8?B?OWdrOGt1Z3RGMEVMTG5YMWZRdm9RK0RWa0dtVHhQOU42OWRUaXpDK0lYdkZK?=
 =?utf-8?B?cmlHYWd4VDhLdS9PajRXeWJPWTFVMVd4MXFkSzdvcXZQWSs5dlludVdobWFD?=
 =?utf-8?B?RUNVSUVKejVqSTlObWpaNWRzNzRuaVY1cCtiN3dkTS90OVd5YlVoVG81WFlw?=
 =?utf-8?B?N2ZkMUpGNjdRd3RHM05INEtKUmlYckMwdTlwYWRHSkN4T3U4NlRjYXpXZndW?=
 =?utf-8?B?VDV1TVFjVU5jT2NDUm9nQm1SRG5rTk1LTnFNZjJsbXhRUHBWcjNiWHkxdGw3?=
 =?utf-8?B?dlJpZno1VGZ4VDB3eU1Za0g0OWRGR01qemIzRmZZMFVESG1KYmM2QnlEVWJI?=
 =?utf-8?B?OFlab0dvS3Zac0N1Rk9qL2hPRlhMcjJNZ0lEYXZURTRKNzJYbEJhanhrTUxa?=
 =?utf-8?Q?5gLfCMfTQhnWa6R13dtRJipvY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 581c13c8-9e5b-4928-64af-08ddc8491bc6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 11:24:08.3696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnJW7jD8bpnonuyfhfTRADyuMKtIzjM80GZEpwPX97ttKwAsX73+fzA8nTkporhwSsQ0szljbMUWerApdP59Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8083
X-OriginatorOrg: intel.com

On 7/7/2025 10:35 AM, Pan Deng wrote:
> When running a multi-instance FFmpeg workload on HCC system, significant
> contention is observed on bitmap of `cpupri_vec->cpumask`.
> 
> The SUT is a 2-socket machine with 240 physical cores and 480 logical
> CPUs. 60 FFmpeg instances are launched, each pinned to 4 physical cores
> (8 logical CPUs) for transcoding tasks. Sub-threads use RT priority 99
> with FIFO scheduling. FPS is used as score.
> 
> perf c2c tool reveals:
> cpumask (bitmap) cache line of `cpupri_vec->mask`:
> - bits are loaded during cpupri_find
> - bits are stored during cpupri_set
> - cycles per load: ~2.2K to 8.7K
> 
> This change splits `cpupri_vec->cpumask` into per-NUMA-node data to
> mitigate false sharing.
> 
> As a result:
> - FPS improves by ~3.8%
> - Kernel cycles% drops from ~20% to ~18.7%
> - Cache line contention is mitigated, perf-c2c shows cycles per load
>    drops from ~2.2K-8.7K to ~0.5K-2.2K
> 

This brings noticeable improvement for RT workload, and it would
be even more convincing if we can have try on normal task workload,
at least not bring regression(schbench/hackbenc, etc).

thanks,
Chenyu

> Note: CONFIG_CPUMASK_OFFSTACK=n remains unchanged.
> 



