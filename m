Return-Path: <linux-kernel+bounces-737443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE993B0ACA7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 01:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10D25A6970
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6670422F74D;
	Fri, 18 Jul 2025 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSY4M8SS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E822DFB8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752882534; cv=fail; b=GsBpol1ltQQwLpAD+t6sy7RoW2MPN+gR0JdYC2oslsItsGMZoubuBcV+t5HE/1awmBGKS/oEmhcHmkS+7oXTaj3pi5+wWhqjD65W7sEcH2NUHeiNBAaRxOOa9zgQ5iagaUIE3P9ovDiwawAELuVu4YD1YVSxtgO13vW/Zsu+W6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752882534; c=relaxed/simple;
	bh=Pu71gfJVETpQ+9bMIXYLp0ZfdP46Yx14XZxN1FTjSHU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OHmmAymKa39cA4dofpNMoeILW4+2yAsu6PMCeluiMURH/sQMmOYTXh3aJ+AEXi8Hf+4epxuOw3ZiEPKGgY7jpWlzF9ENxTEcAROuLWsVoMZIFonjwSWqA2aNvm0BjaUQ4K/Ye3WYFXhoq0ZaIQTYh6fF2LTeifgZ3/cs7Isr6RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSY4M8SS; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752882532; x=1784418532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pu71gfJVETpQ+9bMIXYLp0ZfdP46Yx14XZxN1FTjSHU=;
  b=PSY4M8SSOZMWMqOUFPmDcYc9c4KiZXXg9R9/BNtmRoq9wRygLfUheA5Y
   FieCAiaUiOJG+vGDogubtF5j+4ksBvvfoV5BbfTY4uiXOG5+wNAlQrcOK
   usmxOs3li9DGwwibcq6rs5pwG+k5Fa5CAsrH9prAatYTTSfGp2my+4VN9
   4WSm3cZjhGc2hV8EPcqs63717AY7dX68rs8fVyuEyLkY9RWXW0faBl4oS
   qG3sFWMZ0lokuj1+YMW7at+D/p0p8DZOiVwQsh1LwMkhzVcK5CkGHx94I
   VxJhWl2DgvDUmYGZAaDU2oWJTMSxLV0GHonwiMPe6H3lCGMaTvNXEHww9
   A==;
X-CSE-ConnectionGUID: aPgf/Hp/QFGiunpK9UunWQ==
X-CSE-MsgGUID: e20evaEpSv6BqDprA3UIMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="66631614"
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="66631614"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 16:48:52 -0700
X-CSE-ConnectionGUID: rrxg21EbQeKCI+pcBPVRfw==
X-CSE-MsgGUID: wktsUwCcQsGOK3yRp6lQ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="182053569"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 16:48:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 16:48:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 16:48:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 16:48:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RL/ukEu+ous1IIjbvXztvVSA8Lao+9tFERx95t20HoRV1a8apS0Xc9nbfKI625hTN6wb03NnK+WzWfBrhXCffqGU1dga7esKNdaTyaYOJUj2kcptLq8JqNx9sLlhvfJGv7zaejZgFh46yekh3lhUbEzh8q9aFZSP3hR1QHBKL2HH9Rj7EDas0sSutjdVXSsxJ2socX4DXWPA4GDPlkQRSyZHaQukE4YK+Rd2rrkpCEtAHDD2OQx6pYUqJgEx19eOX93czM445EhJbnDem2z1I7z5IK0YM4FTUBe39z4aEtTmPxFpPdpEB2PzXDjA4Q8c0vfjCJjuPn4kZOcp6qTGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjsqsbFcwKkxPcVS/GNxhTmWACBpCGCvMfcKb5zYzkE=;
 b=OOjm1qdc1+tBng9Egu3W3ZPeOe/SpgATq41pAAIpnxAwGqriN1gKGR+xQzlfquG91l5PwBIwnhvZNHliR1DFucAML/Ny2tisDOSavL59h7F1yqmGoxu54JGFEs1fHxQW3giiCOow5R9AGa2s0Ot52wZFQ2+pxXq0z8hSldtFlD9G8LP2BWSdCiyr/cY5d1Juwzz5hm7UQV5DnjPhVnRCvM1YXu7Gy8UOEMVhckhUa5ylOq9xMBuWCcphqPrma+7G7lor5RgTP4OrfEjaYOg4tkvRUOPQZMj5sEnEfvQW7qFQGM84AgXl696smQn3bi9PTk+a9inY1SQ2UApcb80OWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA3PR11MB7625.namprd11.prod.outlook.com (2603:10b6:806:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 23:48:08 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 23:48:07 +0000
Message-ID: <99baa18c-ae1c-47e1-8bbe-e411570df8f1@intel.com>
Date: Fri, 18 Jul 2025 16:48:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: Fix potential NULL dereference in
 avx512_status()
Content-Language: en-US
To: Fushuai Wang <wangfushuai@baidu.com>
CC: <aruna.ramakrishna@oracle.com>, <aubrey.li@intel.com>, <bp@alien8.de>,
	<brgerst@gmail.com>, <chang.seok.bae@intel.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <oleg@redhat.com>,
	<peterz@infradead.org>, <rick.p.edgecombe@intel.com>, <seanjc@google.com>,
	<tglx@linutronix.de>, <vigbalas@amd.com>, <x86@kernel.org>
References: <89987231-37ce-4d49-a1d7-6e699e8ab0d2@intel.com>
 <20250718071250.36019-1-wangfushuai@baidu.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250718071250.36019-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA3PR11MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 1567eab8-d080-4e15-fc11-08ddc6558bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2UyVCtZTnc5MDVRTytsYzFUVmZnNlMrdkh2UXBMMlcxbHladUJwSlZ3MCsz?=
 =?utf-8?B?RTA2L1RCMEdBOURvSG1hRTZUUzNXUnhaV3NYSDhLeW1PVDFlc05UV1ZnWFUz?=
 =?utf-8?B?ZUJZeGxRRURlYU9rOG11aDZIWTFsTkhWNVVPVFZVVmRHYkExU0N1eUUzTUgr?=
 =?utf-8?B?bkpZVjFsc0FvYWVzRUlOOGVqSTg1dHhac3ZHa2ZRVlRzYnUrdWoxUVl6UU1i?=
 =?utf-8?B?dkFveHR0WnAxLzljbStaZ3JNWktuZ0dya25wZ2J3RGgwbnhxVW5CNEJ0MWtM?=
 =?utf-8?B?d29zN3I1RzZlb3M5NTM5azhUQlUxRENidzB5OFFudzFrQkJzQ3pLYlZRZzl2?=
 =?utf-8?B?TVg0N1dYMGt2bmxqWGJ4Y2tZVjUwR3BWQzdvbjVLdXRMVXlJWnZyYXBuZE5n?=
 =?utf-8?B?UTQvOTFJMGcxNmt4czdPcjIzM2xtTjVZQXhqWGZEL2RNTkNTckkrajFjVlkz?=
 =?utf-8?B?V1VaQ2JxaEF5cEw1cXVRTVBETEtRWUxNdmw2MnBGRWlSV2Z3eWdPY21TUWo4?=
 =?utf-8?B?a0hUWi9haUlrNmc3VjBKTENLRUx0ai85RysxdTJUZmpnSE44Y1VTR0dPYm04?=
 =?utf-8?B?RnZjb1RBUkpERE9MeHNxa2NRM1dSUXV3eEMzRml1SkRScW1EUGd6ak5rZ1l6?=
 =?utf-8?B?M0ZKWjlUZUp0aC84K2ZNRUd4VFg5TEpmdTlaRzdvZy9QT2p4V0tvYmxzaElP?=
 =?utf-8?B?VXJnQ214VDBuRWFiWUJCbkJrVHg4OUNRK0UrZkJUQTB0TEVpNEJVSkRUeVVm?=
 =?utf-8?B?MEk0eDZpWXZGSmJQLzJ1dDRBbmVTbkZVTXczU01rMnNiUC9GZVBSRGdLSEJv?=
 =?utf-8?B?endwL2JVcXlwQzQ3cVowcExhZjFQZDZXcWJXZFlkNzBEeE1sMnlxN1g5RTJl?=
 =?utf-8?B?OVNFT2pIQVZSK1dNUDVib2VzSWYzWmtSYVd1eTlBR29Ibnd6aXFzOVVzVlVU?=
 =?utf-8?B?dEg2UVFTeGRtcXFjUEl3TkRsZ0pmdUZCQkNwcDFPRjlNRTNVM254V3UrRUdE?=
 =?utf-8?B?TTlNeEhOS0hxV01ha2J1cHVwNzl6SERlcTFwcUxYWlZCVWhHNEZrTjJoMDFv?=
 =?utf-8?B?cktvcDNOTVF4TWVKMllHVHZ2QWJ1dGRoU1ZUOVBjWERkb21BbGhmNWRqM0hW?=
 =?utf-8?B?ZzdYYzdjdFY0M0NMamUzako0UTdHV1Z6dGFaTllKWTRqMU93c0RJTkszbEZQ?=
 =?utf-8?B?eHhJZUUreDhjM2tKMWJzYWFTaXVTYzd0VGdrQ0lOOW1MbHpkOWpoNE0yU2cv?=
 =?utf-8?B?SDJFaVpxQjV3WjNiUzQ5d0ZJVkpESmV4R2JBRTFQb2RDVm5wOTFlcjRUS2p5?=
 =?utf-8?B?Zk04QXUvMGxqODJISUlYbDZ4aUFGNFlQMEV1MENkY1B6S3VSdFpsMU9qeDE2?=
 =?utf-8?B?NTBGcFZKYkNkaEVzVEZqeE02ekhyQlFvTEYrYlZ1VFVyTXVmMWZtc08vck5t?=
 =?utf-8?B?SFF0WkpGUFBFMDVFcmc1MG1pWWF5cUlSYnhuUm9HUjNaSmJyaWI0NFlDVC9s?=
 =?utf-8?B?Wmt1R0FKL3VKQUFLb2RuakNHRzhtcWNIdXlPTEZueWNIbHRwU3NlbENWR3VE?=
 =?utf-8?B?V08rSmRGcERieTk5dGxjOS9USnJCQTVLUmVVK2NzdGRXSVN2ckRQNStWMDVY?=
 =?utf-8?B?MlduUlpFR2ZCNHc2UWFPbHM4SmdEbjR3S1lBYXY1ejNCTEhtY1A1TzZLYjBh?=
 =?utf-8?B?S082cm4wdWFzTGZWYkxzRkxtNEprclk3Zm9LTTJwNWhBbVQ1SldUaUhiRUJn?=
 =?utf-8?B?clhlbkhQbU1QTzVBczZpSnZNcUZhYmdnb1EvTVYvaml3aG1BVk12b2NLeG5t?=
 =?utf-8?B?M0hvaXNSS243MjE3dWIvZTdNS2pMM2FUNUU4VjNZTENLOW5YTmQxZGpPUlNT?=
 =?utf-8?B?ZTNGNmprRVhwU0UzTW83T2FnZ3pNa21kZVZWb09YeFpXV2pUa3NPWSthb1R1?=
 =?utf-8?Q?0awu2gPC5os=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDZQZXBKaXMyeHJqbVF0Zjhad2JZMW5xTUY3WitxMWxZb2NpcFZXOHVrWHRF?=
 =?utf-8?B?VjEvbWdBc3lnN1lRM084RlJ6K1RER3p6YVZmTXJua2M4V3NFNCt4M3JYVU8z?=
 =?utf-8?B?RG9kSjVkRHM0eXdNTm5nTURrR1hzQlJqVHduTGU0bUdhVkl6UHJYZnNTeXhS?=
 =?utf-8?B?dnBQVFd2dWh6R0c2MzhNdlFrbHYyWHFHcFIrNzZzbzR5T3FDcUlEYTBnRXZC?=
 =?utf-8?B?bGk2YXc1ODNldTVhNE5nMVpiM3dLR1JnamhwTzZxT3pweFZqMnVERCs2SUVM?=
 =?utf-8?B?aTJwcnFINi92SkFhcVRWUHBJYmpnRWZTNXVFMFgwMXhERGdPaDA4ZWVIbWJ6?=
 =?utf-8?B?UVdYZGpGN2RLYVBrVW9CbXJ5ZWl1RE0xeVhSVkVUcFBBb0NmSnRGcElCUmxa?=
 =?utf-8?B?NEY2a2JOV3ZNc1E3c2VISlFTRCtYcVVxaDA4TzEwbk5KN2ZtRDRSdXpLMVRH?=
 =?utf-8?B?bEJvaGdTU1lETHFmTjFDUUhVZkZUNVh6ZnBzQVkvamIwWVZIVVJvdk1idFBM?=
 =?utf-8?B?S1VRZDJmRU5pN3hucGh6cHZlOXQza0E3U3lvVllnTS9yMXB0Y2VlZ0VHVDFv?=
 =?utf-8?B?Y3IreHdjTGdvbUoyM3JOazE3dEc4R21IVkNlcjd0RzE5dWpIamZuSkRLY3c1?=
 =?utf-8?B?N0lKR3pDK3pyRTZacEM2R05wbCt2b3lPYmQzclhrQkloZHR5S3Vnc1RlczJp?=
 =?utf-8?B?dUFOMFB5QTh4MWpTUU5QRU44U0JTR1hMUXp0MkJER3AyUUNkMUd0eWIwbUNE?=
 =?utf-8?B?SXlPWjBmVGl5RDNrc0NTcWZqa0YzUTBjcVdQSEprRmE1cUErSTNRSitaUnZS?=
 =?utf-8?B?aGh3R0RnVThjZDZycEdZV09YeVFRQ1BOK0pwNjZMQXhnR2NnbUxPL0puVGlS?=
 =?utf-8?B?QVFveUVrb0lkdHVYS3dOa1ltRGRZUHp6ZnZjVnlsZ21jdHFvT1ZZclFsREk4?=
 =?utf-8?B?Ym45MmVUNnhXTDEwc2E1WE9TYnY5cDFkOFdzWTJHNXQrZWZoVU1jeE9vWFg0?=
 =?utf-8?B?NERzeTJkMk9aUUxnM1B0SjUvNzBaaUFqRTF5aUF0QTJ3OUNZZFZjN3NiN0dL?=
 =?utf-8?B?UXN2VDBTemM3K2tRbmo2TWc2WS9SRFdSVGNvRVVkSU1BQXo5dytvYVJ6blV1?=
 =?utf-8?B?ek5LU1NwYjFrVGN5VWhLckRWUWRCU3FtZnNGSjNyTXdyVUtqZG9xc1VSclNt?=
 =?utf-8?B?NTZmZ0t4ODROVUpuL0NQa1lHTHB0a1hIRzFLRkswQWdxbUdUbDFPa2FRWnl2?=
 =?utf-8?B?bC9sc2pJSlkvblFTRnppR3AxdHFJSkN4dTVOdUY3WjB5SGt5UWpZa2FEczRz?=
 =?utf-8?B?MXkyNXFNUG40KzNkcmw0ejR3SXFPekdxVnorN3dXaVMvaHpJTHNLWVBzZStH?=
 =?utf-8?B?c294Yzl0c0NUNGNHeUVLU1ppT0QxMXB4c3ZuanFKamQvV3MzUWVmSk52VHFS?=
 =?utf-8?B?Nlg5eFVaR3ZGS0Y5NldVbFdMYWpGSTB0MVhxekNBekIwQmdTQ2VIMnFJZ3k5?=
 =?utf-8?B?M0xTREdtU3N6VnV3dUZzemprb2lEVUtCQ3dyVmxLdmQwTUhXbStJckk4VkpH?=
 =?utf-8?B?MDNSSDRnMWdUUnhOOEhWWXlzWFpmQ3pVZ0JkM3Q4MFE0NVNid2VFVElyUTE3?=
 =?utf-8?B?TkhkUjJPaStvaFRxalQybnRBV0plRWNPR2R0R3VBU2Z1T3RLMHpWT1JxcytT?=
 =?utf-8?B?aGNvZDJPdjZmTFd4R0gzalJaWUsrSCtjSUlNUVZhSDdxd2hGRjZHUVVvQzVo?=
 =?utf-8?B?dEhHRTArcDBCeHZnQXN3Z3hUWnRST3ZhL3lmdVF0d3c5TXFyNDRCMG84V3JS?=
 =?utf-8?B?ZXg5VDB0VlZjTWNkUXlNZFI2NkE5QUFPWnBzenZlYldWSGhnci9zUzdQaTBC?=
 =?utf-8?B?My8zcmordmNqNWQ5Y0FBaU85a0xEYS9mbm5YenpYV3JtWFhmU3k0Y2xma0Qv?=
 =?utf-8?B?NEZZUkNBbVM0V3VhRXY0NGF1bnZSWElrWURHZ3hnUkZKVjh2RG0zeVhLcUZO?=
 =?utf-8?B?ejBsdk43TmVKZlVkSzdWOU50OXRUSkh1cjFQajhNNW4vTWg2b0ZvL3ExdVpr?=
 =?utf-8?B?cGVHUE9xd3gvMFoycFRpeThDbUxKdkM0R1lTNEZ4TWMyc1hEc1ROOVI3M2ls?=
 =?utf-8?Q?PIGY2duaWJZAysXKUzTs9EZvO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1567eab8-d080-4e15-fc11-08ddc6558bb9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 23:48:07.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiKFskvyF+Y0hScfAMNRZawcWJIvw7DjHM9S6NUGK2BIQYHPupov2b+0kpgaB2hRm3HgC6iswEhJFqxQBDzFMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7625
X-OriginatorOrg: intel.com


>> I am wondering if we ever need to expose the AVX512 usage for kernel
>> threads? If not, then we can do what you currently have but without the
>> CONFIG_X86_DEBUG_FPU restriction. All kernel threads would always print
>> the AVX512_elapsed_ms as -1.
>>

Let's go with this approach. See below.

>> However, this would be a user visible change so we should probably get
>> more inputs. I tried this experiment on an older kernel without the
>> above issue. Among all the active kthreads on my system a handful of
>> them show a valid value for AVX512 usage. The rest of them all show -1.
>>
>> PID: 2594
>> CMD: avahi-daemon: running [SAP.local]
>>  /proc/2594/arch_status content:
>> AVX512_elapsed_ms:      46032
>>
>> PID: 2729
>> CMD: sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
>>  /proc/2729/arch_status content:
>> AVX512_elapsed_ms:      396656
>>

Correction: These aren't really Kthreads. There was a slight error in
the script that I used.

Reporting AVX512 usage doesn't seem very useful for Kthreads. The usage
is mainly for userspace schedulers. Let's just report -1 for all Kthreads.

How about something like below. This should work with and without
CONFIG_X86_DEBUG_FPU.

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9aa9ac8399ae..10c3994295f2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1855,19 +1855,18 @@ long fpu_xstate_prctl(int option, unsigned long
arg2)
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
  * Report the amount of time elapsed in millisecond since last AVX512
- * use in the task.
+ * use in the task. Report -1 if no AVX512 usage.
  */
 static void avx512_status(struct seq_file *m, struct task_struct *task)
 {
-       unsigned long timestamp =
READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
-       long delta;
+       unsigned long timestamp = 0;
+       long delta = -1;

-       if (!timestamp) {
-               /*
-                * Report -1 if no AVX512 usage
-                */
-               delta = -1;
-       } else {
+       /* Do not report AVX512 usage for kernel threads */
+       if (!(task->flags & (PF_KTHREAD | PF_USER_WORKER)))
+               timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
+
+       if (timestamp) {
                delta = (long)(jiffies - timestamp);
                /*
                 * Cap to LONG_MAX if time difference > LONG_MAX





