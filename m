Return-Path: <linux-kernel+bounces-885526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B2FC333B0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0AC3A8518
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A0630BB8C;
	Tue,  4 Nov 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBhQ58E7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC7190664
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295195; cv=fail; b=jhoI4Z47yQkzC2hWaWuO44sVUqYCQLs838jzOywrUyW+pM98fc5bFqqcB8OyxD7Wp7q3PG88JpM/9rZRj0Sjm6OTcZ80wAhmJd7uYSHXdcgz1IQnKLJ1O9JdYXCjVjFpdeYFDRfeoaaMAPPkQnAfxZDCchjV1t3ZKmv1z0sG1sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295195; c=relaxed/simple;
	bh=yhk29A5bwh8+FkDs0r/ZP90UEM39o+n65tOfiM3BP+Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLqjtpCIa53PQwWpHGEHttc5AvSdzDJi6zFJhCYDHolymP+OtV63zikBznZblDr/jTc0qrzBuRpRToQA0MZaZ6zAecH3JhijQzCXOa9IYpeJEgcwQcOLUFvlZf/9oUZHxUifk+CSMp7z5gYCxTFzukr+Dgp5I24fGlPZF3s/Jp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBhQ58E7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762295192; x=1793831192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yhk29A5bwh8+FkDs0r/ZP90UEM39o+n65tOfiM3BP+Q=;
  b=iBhQ58E7IjKuK/Ya/yVC3MwsFpjpw76PmtCSrI/0MaAnS7Pca96rHh1I
   TnGAKN43JuGcG10xlfuXT7GnSayLq1il55XqM/Xa0zQ2ak3VobwKXDXnd
   zxriYn/d85IANZjjYTcUyCW9XZbtUD+/oCjivV1Jn6z8CopUqYVywSqyR
   +gSGF9qnBedV8O1jXDeUZFesMzJBqt3ZMceW4RpkYvlM/KUOgn8mePjLF
   jUdhKEvXmvRP52vqjllvwAEqaGgKdrXJWf3SRhvMxf/0IdUreEpiciBSB
   hFPI/ARzD85EbReyjUJxnwLlCRslD79zvX9sNgHbPNoPULj0cA4jFwpRF
   w==;
X-CSE-ConnectionGUID: WqV0XiYuQ/iK3rrr/kXzFA==
X-CSE-MsgGUID: HuM0bGwFQDumZ9Lj0aovCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64286844"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="64286844"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 14:26:32 -0800
X-CSE-ConnectionGUID: KtXhBvBXQqCbbenff9XY0g==
X-CSE-MsgGUID: FLI3hQJcQnKnQco8wxkz3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="218077320"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 14:26:32 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 14:26:31 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 14:26:31 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 14:26:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru/B7nxtGe0oT1X0aklhvgECBgBc7bCKwzyGGDfa9O1QbsAY3wTLEx0EAkCjDRBV+OQve4em6EMiyL2aibB06EuAscrmGijdLkZavTZ6v9jhD+ST5Fk3f9lrlIiiD6h/647C39SqyitRV7KXJjf0IpHqjvQuRT5+T4uNjdEVwGxGAvamWwWXXAkkd0kwAnipBUp4OswcTy0qkvAhAH6oUmQN//YBAFNWymBLu+z+6nEkGcTeOMjPgkD69fZHIplznlG186iVRpQs8/QoB0HVJ0EF1nxG2itbfORWDwcyWDSeJpU4ksl59gwr4vYVUIxhSZD+KnFlsXJVMwRHxXGE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HytGrFhN1Y2BryPZFoFTyTrFNYGRu1pI5gC0M6+Wtog=;
 b=j+jHZh2v1XMJOa58v4rh0CwKjDSJzhyIeuG/VFYM9xbV+HRD2OGA2T+J9sIq1kQeF1OB7Sewr9YrRd7QPfYi7DQC8jhwz8D/UZ+5W5FjMXXwUE762TK7HGqWbDMTvJZqtcxtSfBG1QjssWXNBnPNDL6BNWGjA8Zem+uNE4LVmcMJevdR7T2jLNfdSrv9fT0qhdr75SPFYf0Cr+wLZVaNf0TLwsTAoRKXRlLMYAKKXqoNEgSXJe7JGygHX4dHTLhuAO7+zOQBDxSHGG+DvdAkyez8M1I1FqCBb4cqIGp+gDgtHbTXroZCIq4Pe3K1NafVyJngE82qtLr7URDhl7xr2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ5PPF89507EDE4.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 22:26:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 22:26:19 +0000
Message-ID: <08078c25-87fc-43e6-b062-f9945edcee80@intel.com>
Date: Tue, 4 Nov 2025 14:26:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fs/resctrl: Generic schema description
To: Dave Martin <Dave.Martin@arm.com>
CC: <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "James
 Morse" <james.morse@arm.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, <x86@kernel.org>
References: <aPtfMFfLV1l/RB0L@e133380.arm.com>
 <a9b49861-ff36-4550-ad29-a737eb5c1d63@intel.com>
 <aQOUAeVP9oc7RIn/@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aQOUAeVP9oc7RIn/@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:303:b9::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ5PPF89507EDE4:EE_
X-MS-Office365-Filtering-Correlation-Id: 0124413c-b704-49c8-351d-08de1bf12cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWxDaEN0MHNuQktLRW10L0lqMUdwMmNCMWdYVHFaSCtTUU9CUGZCR3haeG1p?=
 =?utf-8?B?eCtPZEU2Q1lnQzlJUlA2Rm5xb0ZjVGlBNTZUaUIzcUV0WWZYQUhPUUpXSHk1?=
 =?utf-8?B?Rm12UWt1RjdBS3V2SUdjSU05d3o0VFByUkcyeVlGOXptMkpTRlNpWHhNTS8w?=
 =?utf-8?B?SGk5dElyT3hFR0xzSWJJL2hzeElnRXR0K1pjSG1RZzM5QmRNTnQxTTlUSFZw?=
 =?utf-8?B?bmRLRSs1QmFzVkp5UDJZTUtBOXV3RTN1ZitSRERoTENsbzlDMnZ3blVEd0FV?=
 =?utf-8?B?NVhwVDhHWkhiSWlBTWpFRGkyU0k1eVFRenpyblZWTlhjWmZuTFRDazFsb3pC?=
 =?utf-8?B?eHRuemNPSDc5OWZmbU5jdGJTRXlSa0VVYUhGTVFJL1NRMWRhSVlsaDhhVE8v?=
 =?utf-8?B?TWFOZXlkRG44ZENMaURxaGhLenV4dCtjalFrWjQzT1dvWmJIUkhwMzJtN2lS?=
 =?utf-8?B?S09KR2FyZFVublpRcnlXeXF5RHlrWmY2bEQvUGRvb011THR5aVhKTThiYlp2?=
 =?utf-8?B?RzFBTzh3V1FzamdlcU5YcG1TRFRjaVQ5dldYOEpUNzFlUGx1Qkw5QXhTTEtx?=
 =?utf-8?B?Q1p1MExHL0tNcTVCNzFBSldGQUhMOXRaYTVtM0UxWUtMdzhhUytnQi9NNmkr?=
 =?utf-8?B?ZHEvMXdyd1ZQc1hCVVlEeUdWR05RR1Y5K0FmNW92TU56OXFmZzlhMndzK1lD?=
 =?utf-8?B?a09uM1piME9xS1ByRldZK3JZNER5QTNPRDVETkNRTTFiM2pXTHBTdHhSR3Mz?=
 =?utf-8?B?M1oyMEZZOXYvdUphdWwyVE1iRk12TFR1cEtvbWxpTkxwZVlzQkVHdllMRFpp?=
 =?utf-8?B?N3FqWWkwM1NGdThHSUErOStGM0hJelF3amVjc0ZmOGllaVJDUVhHNkx5bTJR?=
 =?utf-8?B?bTArOTdGOUx1Nmg5dDlRM1ZaSXhLdUd2dkpSekhlNFFrcjlxWURKSjQwaXZH?=
 =?utf-8?B?RlZtY3Yvbmt5cXRtbk9SakJZdzVrK0kyQWoyVHphODJjTE16NEZTcW5CMDU1?=
 =?utf-8?B?N1lqeFRKNHIxbVRhUVphMmlaTG0vYURzQkJETVB6WEJMYTlmcDZwakdBK1Rh?=
 =?utf-8?B?VDBxSkZwRUVaY1BVVCt4Nm15R2pFQUxyb25wMDJrUzdCRXBPYTRWclNEbDVv?=
 =?utf-8?B?SmhzWkVFeEEwdlJiREd4OWxIcVJXMWhFMElWRTFDQlJOdXpFR2NRUGE4ZUND?=
 =?utf-8?B?R2UzZW01NnFINTdDc3FSUlR0RTlEMFlnMUdCVklJaC8vYmhaZ3E0VHk4blBq?=
 =?utf-8?B?Q0lWSk0vZVcxTE9abk0rYlFnMEdPL0FUekVUZzN5UkNPUWZubVNnZzhic1dJ?=
 =?utf-8?B?THpXa1d2WndUNVZqdmtPUnQwN0c0OUFNUUJTbG5zaUtaa004L25XdFREWVJJ?=
 =?utf-8?B?Uk5VUERNdHZObjRFb0tCOHl6ZFF6U0IyMDRMejBKSlluKzdGTDZOTXVmd0cy?=
 =?utf-8?B?WXFwYmRENXArL3B3azNnV2lEbHljTzBxVTF4V0x4TUVRSEdleEt6V0ZHbmZj?=
 =?utf-8?B?K0pMT015K1Y4NWkvY1R0T1BpOWYya1VTOGRyRmRkYXFQU0ZJS0RHblBrSmtB?=
 =?utf-8?B?cVgvNWVRdTRld2NsWlVaNVY5bVpsV21Ra2NKaU8rMEc1Ky8xKzVhaVhKZFM4?=
 =?utf-8?B?UU9mdnNGUFVIK1AvNkN6SXNxbXBaZ3p0ZGpsbFpDTXJJWjRuU3JkSGltelJm?=
 =?utf-8?B?YjQ3SDZCODhlT3pzZkt5WEoxdkErWEVHcEQxcHBrUDRBRXIzaVNnQWZEdmVR?=
 =?utf-8?B?dmR3cUNxZUY3azRScHBiVUlVRC9URlV5TWJ6dXR1UEJGUHRPcjR5MmtKU1BF?=
 =?utf-8?B?RGFMaTdPZFV4MTk2eVFnSEhVTjFKUGNJWk9ncDhGNDlGTHFWMUhXWUg1bDdo?=
 =?utf-8?B?M1RGVk92ZVp0K1JVY3VodENFTHdiQmpPbTZjdlNiR3QxNEtMZmJSQnNyMXRS?=
 =?utf-8?B?Um1ydW4yU3R0KzZha3o1b093MWVlNzhnL3VFS211V2xzcXR5T3JXZ3J4YkhI?=
 =?utf-8?B?WTdPWVdTWkl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RklZQld0dkNzQ243MStMVHdpSXBwOFJ3QU5rdERuL3puTnA4V0lNQ3pVdGlR?=
 =?utf-8?B?SHVXRkxGUExHdTJoMVREcDJuUEpNdmFHVk14ZS9BTllLd2ZXanJUcWdtUHVC?=
 =?utf-8?B?MEV5QXpkTEQycEJVb2pHa1ZEM3NiMHBrRWE1cFY3WHlBN09SQk9LeFpydzBj?=
 =?utf-8?B?SlZQanZENGFwWUhrRk1jM1A1Vkx1dmg4VEpWY3NLNDFCZmVKcWFyaEVYRnRU?=
 =?utf-8?B?SFpIbHJmU20zR3J1cGoxWlU1WkQwa1J4WUdJOUVVVnA3c1NXRTltK25OaGNh?=
 =?utf-8?B?SmFvbnA3cE1HcExtdkNCWFV2UzNJcnFzNXVqOUlZZG9QUnRIQkI3MTRlS3pF?=
 =?utf-8?B?NG1Gc0l2VkVOVGM1SnNHbTJDaEdPR0pxakhkVHhXWU15K1owVG5RY0lvK29N?=
 =?utf-8?B?bW9jb0doc2wwaHFPV052b1ZySUx2dDhPYmFRR0t4TVlWR2dNd2xwMWNQZ1Ev?=
 =?utf-8?B?RFZIaGVqcVRNalZTSzduZkJaV2ZqeHM0RUpiZnpUNjFmZ01rcENpQUZEMUpD?=
 =?utf-8?B?RXFGK3FWNjEzdlVxaG5SN1JncmRwenRCT2RwTjViVU1ZWXlOc1Rka2huUVlt?=
 =?utf-8?B?V3duTkpCTUlIRzZYczV0Mlo1MkZjMHNKVmJxbHZtd1gvREhEUm95SHlEYUJq?=
 =?utf-8?B?a1RxWXRaMnppNk9sUndoSWJXUVM0Rmp5S0V3bkVUU2VuZ0JpWkduVHZiT1VV?=
 =?utf-8?B?NmZCUnJ4MTQzMGVzb1RRYVQ5RG9VbEJkMFJZSnZFUk5HR3hGNzlUS2RucEtv?=
 =?utf-8?B?VGhUNjlCQUQyN1ZNRXVySVRlQ1BTNkRMMjgvckl3bHNhT1hYWHU1eGhtbmUz?=
 =?utf-8?B?Snd4SldBc3A2NHdENHhqRTIyT2ZRTSs0dXpUTkZDNUtINjhlRU5YU2YwV21L?=
 =?utf-8?B?TTkyQURIbEcvaE5nREJtYTVTU2lMb2JnZWlZUnlvaHVzcHZ1d296dFhXTDlG?=
 =?utf-8?B?QlNOZzFJa0FFR0tlNDVramNrajZVRDFHd1BWdzJpaUNJTHdNVGF6YnJwdTJO?=
 =?utf-8?B?R1F1N2FwZXduQ0YzSzRzc05XbmFzT3JCdk1jYWhLckM1SWhoWk1ZUWFYYmxO?=
 =?utf-8?B?T21xZlh1UjNvbTdrSElXN0h2TGtXZGh6dVhPMEV4My9wTHhYdXppQVNWL09V?=
 =?utf-8?B?T0wvK0RlVGgxY2RaOXBkZFIraHN3WitSQit1bmNOWFVwSnNXRFFPR1IzWUda?=
 =?utf-8?B?cWk2QjRzQWFxVWFXaSthSHJ6N1NTV2JGYzZhRzh6cHJaTVZYWjZpci9kRFNC?=
 =?utf-8?B?aGcrTDZvUmtlWGFoWkMzTWZNdEs3Y3A4ODdJdnZTbENSdnFBRVRRa3lpblRh?=
 =?utf-8?B?VWhGcDF2WDF4K24zU01KWmJpeDRCaFRNckNFazkyMjNIQmdUT1ZmaHVCa0Q0?=
 =?utf-8?B?YlVub3BVakhtT3ZZdHVDbkNsWEVxODZpVU1veisrM0pDemM3M0VlWWpvQ25T?=
 =?utf-8?B?MEtBdnI5Z3lVL0l2MExkUTRLb0MweVdySHNFMSs1ZXJRQ0N4S1I5OFcxNHdE?=
 =?utf-8?B?RmNFazJUMjFGZjc5MWVGOHhlMDV5NGVQZEw4aTBOeEVwS1NSRWpES1VobzFw?=
 =?utf-8?B?RjIreUEydDJFSGtMU1VoVGdpSFFKMFdZTys2NzBmNG8wRWZHaTJQUG5XbTYr?=
 =?utf-8?B?VmFZM0svK1ZKNmVQakZIT1VPMGc5bjErZ0lkTGNZWDJEM0QzWkZ0SHFZUEdw?=
 =?utf-8?B?aTZHS2szVFVJUjRTa1ozeXB1ZXJpckNKZVNOM2NseCt2ZHFCUDVkZXd1REJ4?=
 =?utf-8?B?MVF1VVBZaVRWNTAwSGNqOWJ3L3VLbkFWSEFWcWRLdVhqcXlXSVZYRHY1WWVu?=
 =?utf-8?B?a2hLWitodGV1UjNPaWpOOWFYQ3BxSzdDM1FwTWZ4NTNQdm52YVNVcjlNZ004?=
 =?utf-8?B?ZVFHMkM2RkhlSUlPdDVWMkdObGhQRHhUOUNyc1lBRXFKMW5EN01WeGFCL1Nk?=
 =?utf-8?B?MHQwRVpSUzJNQ08xeFE1Y1BLZWdoMXc2QnI4a3kwT0F1dVRDczdiSThzVEly?=
 =?utf-8?B?TENIU3FoUmUvZlVNU0pkTXhqcDJ1UGg1OE5CZWxkLytXdldHb2xsMFk1N2xQ?=
 =?utf-8?B?YlZGb3Q3Vm5vRkNLSlVtaExaMzRZUzNKWVdLdjJjemRERDBQa3pzdE9XaVRn?=
 =?utf-8?B?SmUyVlFkNGZaTE9IdnN0dEgvKzZxUmxpN0diYnZCemJyaktaQTN1YWtvZ3g3?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0124413c-b704-49c8-351d-08de1bf12cf7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 22:26:19.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsfNYmJf552EBlI7CEpL5rSe/afw3/lMdjRiBE+BxYqs45up2RliBXLIlg4JMTDevE86aYUNpGXdbIlsaAaCxsl06yv2ajbSnG8NmgVh7ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF89507EDE4
X-OriginatorOrg: intel.com

Hi Dave,

On 10/30/25 9:36 AM, Dave Martin wrote:
> Hi Reinette,
> 
> On Tue, Oct 28, 2025 at 04:17:05PM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 10/24/25 4:12 AM, Dave Martin wrote:
>>> Hi all,
>>>
>>> Going forward, a single resctrl resource (such as memory bandwidth) is
>>> likely to require multiple schemata, either because we want to add new
>>> schemata that provide finer control, or because the hardware has
>>> multiple controls, covering different aspects of resource allocation.
>>>
>>> The fit between MPAM's memory bandwidth controls and the resctrl MB
>>> schema is already awkward, and later Intel RDT features such as Region
>>> Aware Memory Bandwidth Allocation are already pushing past what the MB
>>> schema can describe.  Both of these can involve multiple control
>>> values and finer resolution than the 100 steps offered by the current
>>> "MB" schema.
>>>
>>> The previous discussion went off in a few different directions [1], so
>>> I want to focus back onto defining an extended schema description that
>>> aims to cover the use cases that we know about or anticipate today, and
>>> allows for future extension as needed.
>>>
>>> (A separate discussion is needed on how new schemata interact with
>>> previously-defined schemata (such as the MB percentage schema). 
>>> suggest we pause that discussion for now, in the interests of getting
>>> the schema description nailed down.)
>>
>> ok, but let's keep this as "open #1"
>>
>>> Following on from the previous mail thread, I've tried to refine and
>>> flesh out the proposal for schema descriptions a bit, as follows.
>>>
>>> Proposal:
>>>
>>>   * Split resource names and schema names in resctrlfs.
>>>
>>>     Resources will be named for the unique, existing schema for each
>>>     resource.
>>
>> Are you referring to the implementation or how things are exposed to user
>> space? I am trying to understand how the existing L3CODE/L3DATA schemata
>> fit in ... they are presented to user space as two separate resources since
>> they each have their own directory in "info" while internally they are 
>> schema of the L3 resource.
> 
> Good question -- I didn't take into account here the fact that some
> physical resources already have multiple schemata exposed to userspace.
> 
> I've probably overformalised, here.  I'm not proposing to refactor the
> arrangement of existing schemata and resources.	
> 
> So we would continue to have
> info/L3CODE/resource_schemata/L3CODE/ and
> info/L3DATA/resource_schemata/L3DATA/.
> 
> 
> I think that the decision to combine these under a single resctrl
> resource internally is the most logical one, but I'm proposing just to
> extend the info/ content, without unnecssary changes.

Thank you for confirming. This matches the way I was thinking about this work.

> 
> The current arrangement does have one shortcoming, which is that
> software doesn't know (other than by built-in knowledge) that L3CODE
> and L3DATA claim resource from the same hardware pool, so
> 
> 	L3CODE:0=0001
> 	L3DATA:0=0001
> 
> implies that the transactions on the I-side and D-side contend for
> cache lines (unless there are separate L3 I- and D-caches -- but I
> don't think that's a thing on any relevant system...)
> 
> So, we might want some way to indicate that L3CODE and L3DATA are
> linked.  But I think that CDP is a unique case where we can reasonably
> expect some built-in userspace knowledge.

I'll admit that it is not as obvious as this new interface would make it be
for new schemata but userspace is not entirely left to its own devices. 
resctrl will ensure that these resources do not overlap when, for example,
a resource group is exclusive. For example, an L3CODE allocation in one
resource group cannot be created to overlap with an L3DATA allocation in
another when one of the resource groups is exclusive.

> 
> I didn't currently plan to address this, but it could come later if we
> think it's important.
> 
>> Just trying to understand if you are talking about reverting
>> https://lore.kernel.org/all/20210728170637.25610-1-james.morse@arm.com/ ?
> 
> No...
> 
>> The current implementation appears to match this proposal so we may need to
>> have special cases to keep CDP backwards compatible.
>>
>> SMBA may also need some extra care ... especially if other architectures start
>> to allocate memory bandwidth to CXL resource via their "MB" resource.
> 
> Perhaps.  I think it may be necessary to hack up and implementation of
> these changes, to flush out things that don't quite fit.

Have you considered how MPAM may want to deal with different memory "types"?
With SMBA there is a "CXL memory" resource while the MB resource has mostly
been "anything that misses L3". From a user space perspective it is not obvious
to me how users prefer to refer to different memory types.

> 
>>  
>>>     The existing schema will keep its name (the same as the resource
>>>     name), and new schemata defined for a resource will include that
>>>     name as a prefix (at least, by default).

We may have to be explicit on expectations wrt which schema can be observed in
which area (schemata file vs new info hierarchy). resctrl.rst currently contains:
	"schemata":
		A list of all the resources available to this group.
With the above in existing documentation resctrl may be forced to always keep
existing schema/resource in the schemata file and be careful when considering to
drop them as mused in https://lore.kernel.org/lkml/aPkEb4CkJHZVDt0V@agluck-desk3/

Theoretically it may be possible in the future for it to vary which resources a
resource group may allocate. Consider for example when resources support different
numbers of CLOSID/PARTID and there is a desire to expose that to user space instead of
constraining all resource groups to lowest CLOSID/PARTID. In such a scenario it should
be clear to user space which resources it can allocate to a resource group so it is
reasonable to expect the existing documentation for "schemata" being "A list of all
the resources available to this group." to be respected.

On the flip side, it may not be required that a new schema in new info hierarchy always
appears in the schemata file. Reason I think this is after seeing in MPAM that
controls could be enabled/disabled (like MPAMCFG_MBW_PROP.EN for proportional-stride
partitioning).

resctrl may thus have support for more partitioning controls than what is exposed by
schemata file with ability for user space to choose which partitioning controls to expose
in schemata file to use to manage a resource. It may then turn out that in addition to
(read-only) schema "properties" there may also be (writable) schema "controls" (bad name
since this would "control" a "partitioning control") where user space can modify behavior
of a partitioning control.

>>>
>>>     So, for example, we will have an MB resource with a schema called
>>>     MB (the schema that we have already).  But we may go on to define
>>>     additional schemata for the MB resource, with names such MB_MAX,
>>>     etc.
>>>
>>>   * Stop adding new schema description information in the top-level
>>>     info/<resource>/ directory in resctrlfs.
>>>
>>>     For backwards compatibilty, we can keep the existing property
>>>     files under the resource info directory to describe the previously
>>>     defined resource, but we seem to need something richer going
>>>     forward.

ack.

>>>
>>>   * Add a hierarchy to list all the schemata for each resource, along
>>>     with their properties.  So far, the proposal looks like this,
>>>     taking the MB resource as an example:
>>>
>>> 	info/
>>> 	 └─ MB/
>>> 	     └─ resource_schemata/
>>> 	         ├─ MB/
>>> 	         ├─ MB_MIN/
>>> 	         ├─ MB_MAX/
>>> 	         ┆
>>>
>>>     Here, MB, MB_MIN and MB_MAX are all schemata for the "MB" resource.
>>>     In this proposal, what these just dummy schema names for
>>>     illustration purposes.  The important thing is that they all
>>>     control aspects of the "MB" resource, and that there can be more
>>>     than one of them.
>>>
>>>     It may be appropriate to have a nested hierarchy, where some
>>>     schemata are presented as children of other schemata if they
>>>     affect the same hardware controls.  For now, let's put this issue
>>>     on one side, and consider what properties should be advertsed for
>>>     each schema.
>>
>> ok to put this aside but I think we should keep including it, "open #2" ?
> 
> Yes; I'm not abandoning this, but I wanted to focus on the schema
> description, here.

Understood. There may be some connection with this work if there is a hierarchy
since one schema's description may then be in terms of another. For example,
the relationships described via pseudocode in https://lore.kernel.org/lkml/aPJP52jXJvRYAjjV@e133380.arm.com/

As a sidenote (related to the '#' prefix discussion), while trying to understand how
this work may impact user expectations I did come across this in section
"Reading/writing the schemata file" of resctrl.rst:
	When writing you only need to specify those values which you wish to change.

This seems quite close to addressing the concern raised in
https://lore.kernel.org/lkml/aNv53UmFGDBL0z3O@e133380.arm.com/ :
	The reason why I think that this convention may be needed is that we
	never told (old) userspace what it was supposed to do with schemata 
	entries that it does not recognise.
 
>>>   * Current properties that I think we might want are:
>>>
>>> 	info/
>>> 	 └─ SOME_RESOURCE/
>>> 	     └─ resource_schemata/
>>> 	         ├─ SOME_SCHEMA/
>>> 	         ┆   ├─ type
>>> 	             ├─ min
>>> 	             ├─ max
>>> 	             ├─ tolerance
>>> 	             ├─ resolution
>>> 	             ├─ scale
>>> 	             └─ unit
>>>
>>>     (I've tweaked the properties a bit since previous postings.
>>>     "type" replaces "map"; "scale" is now the unit multiplier;
>>>     "resolution" is now a scaling divisor -- details below.)
>>>
>>>     I assume that we expose the properties in individual files, but we
>>>     could also combine them into a single description file per schema,
>>>     per resource or (possibly) a single global file.
>>>     (I don't have a strong view on the best option.)
>>>
>>>
>>>     Either way, the following set of properties may be a reasonable
>>>     place to start:
>>>
>>>
>>>     type: the schema type, followed by optional flag specifiers:
>>>
>>>       - "scalar": a single-valued numeric control
>>>
>>>         A mandatory flag indicates how the control value written to
>>>         the schemata file is converted to an amount of resource for
>>>         hardware regulation.
>>>
>>> 	The flag "linear" indicates a linear mapping.
>>>
>>> 	In this case, the amount of resource E that is actually
>>> 	allocated is derived from the control value C written to the
>>> 	schemata file as follows:
>>>
>>>     	E = C * scale * unit / resolution
>>>
>>> 	Other flags values could be defined later, if we encounter
>>> 	hardware with non-linear controls.
>>>
>>>       - "bitmap": a bitmap control
>>>
>>>         The optional flag "sparse" is present if the control accepts
>>>         sparse bitmaps.
>>>
>>> 	In this case, E = bitmap_weight(C) * scale * unit / resolution.
>>>
>>> 	As before, each bit controls access to a specific chunk of
>>> 	resource in the hardware, such as a group of cache lines.  All
>>> 	chunks are equally sized.
>>>
>>> 	(Different CTRL_MON groups may still contend within the
>>> 	allocation E, when they have bits in common between their
>>> 	bitmaps.)
>>
>> Would it not be simpler to have the files/properties depend on the
>> schema type? It almost seems as though some of the properties are forced
>> to have some meaning for bitmap when they do not seem to be needed. Instead,
>> for a bitmap type there can be bitmap specific properties like, for example,
>> bit_usage. This may also create more flexibility when there is a future
>> mapping function needed that depends on some new property?
>>
>> Reinette
> 
> Sure, there is no reason why the set of properties has to be identical
> for different schema types.
> 
> It turned out that a single set of properties fitted better than I
> expected, so I presented things that way to see what people thought
> about it.
> 
> For bitmaps, there isn't a strong need to change the set of properties
> already available in the top-level info/ directories.  These can be
> adopted into the new info under resource_schemata/, but I might be
> tempted to rename them to remove "cbm" string so that the names are
> applicable to all bitmap- style resources.  I might also rename the
> min_cbm_bits property if we can think of a more intuitive name -- it's
> not obvious how this should apply to sparse bitmaps.

yes, this is a good time to rename things.

> 
> 
> Thinking about bit_usage, is that really per-schema?

Good point. This is per resource.

This may create complexity if multiple controls are available for a resource. For
example, if there is a MB resource with both a proportional schema and a max then
it sounds like it may be possible to program the proportional schema with 100% while
setting the max to 50%. On the hardware side these values may be legal, albeit with
unpredictable performance, but it will be difficult for resctrl to visualize the
"bit_usage" of such an allocation.

> 
> If L3CODE and L3DATA are really allocating the same underlying
> resource, I wonder whether their bit_usage should be combined,
> somehow.

Related to earlier comment this is done internally by resctrl but not exposed to
user space. I earlier mentioned how exclusive groups take this into account, there
is also the bitmasks used when creating new resource groups. You will, for example,
find in __init_one_rdt_domain() that their bit usage is combined as below:

		if (resctrl_arch_get_cdp_enabled(r->rid))               
			peer_ctl = resctrl_arch_get_config(r, d, i, peer_type);  
		else                                                    
			peer_ctl = 0;                                   
		ctrl_val = resctrl_arch_get_config(r, d, i, s->conf_type);       
		used_b |= ctrl_val | peer_ctl;                     

> 
> This might be one for later, though.
> 
> It doesn't look necessary to adopt all existing properties into the
> extended schema description immediately -- if there are some that don't
> quite fit, we could adopt them later on without breaking backwards
> compatibilty.

It is not obvious to me that it will be simple to add a property to an
existing schema type. We may be forced to create new schema type when needing to
do so.

I also think there may be more schema types that will eventually need to be
supported, for example MPAM's priority partitioning?

Reinette

