Return-Path: <linux-kernel+bounces-897521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BA5C53735
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AF0506209
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6387F346768;
	Wed, 12 Nov 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiurIXcj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD9345CCE;
	Wed, 12 Nov 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960032; cv=fail; b=flAY/PQ2rUQkoFsKaWPpuf7NmLNiCLrewrLZnvH/r2fALz1b3f2WootJEgmH/E/K2UPB29Wj5Xc1g1ISUQQ92fjuRYSmp+0RHPwXb7/o1Sp3Y8J9HIuvq73lf9ijZzL/hYEtPXbt0o7RX0QZsVKpar+sUN5kQQ5ZoKZdtMF8uLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960032; c=relaxed/simple;
	bh=e/XhTCKBhLNGVUsSfFxjmMjOgzB9fBe61psHxhid9SQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BS/DoRMI92SoxZbH89TWWh7i86Mwx/iSU3dIifbi13qc4jyuQjzqi4tT68tKUAIqjGNtVKu7BAVOTuj+zcM37sOiU9Dy1pba1VHzk6Rp7CYFfqLhRwP1JtMCJgdAsE0aS44rSm7ULWMX5tsLBorvDTNTtpZxrMd9QZ5YNCMku8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiurIXcj; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762960030; x=1794496030;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e/XhTCKBhLNGVUsSfFxjmMjOgzB9fBe61psHxhid9SQ=;
  b=TiurIXcjvlKB7HYIpOj6Tr5y9VeBZf8tWB1Nk3jhK6jbq4MBCIZ4vbuT
   JoAAHp3KJcpYmcnb6lFEnMcfXev+CdBTROdmcSFmh0vFEM3jonSlvMBmL
   drD/dL+h7k2KhUrxKBcn7oEji0RAz7YCWQzExoeIitWi+Z4pnUYASEqKa
   Ilu+WBAxJGuc7tMt98NSJ2iYmDC8FAWuAvup1nkm2SyrrrdTHCE7+fJLl
   XRKbchtBFnSos/BBEHtMw8x682vebZxnlozT+Tn3S/Zz7y5TdKmyryart
   JM3IQTRt0YxChYP7ZPTq+HZCsWNes8mCh0TnDHgU7pnKP2AjPGP52VfPw
   A==;
X-CSE-ConnectionGUID: c/W+efuPTiOq1PCS71EDUg==
X-CSE-MsgGUID: W34MNY+aS5u6f05zMdARlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="87664547"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="87664547"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 07:07:10 -0800
X-CSE-ConnectionGUID: /1Az0vJpRtG1R97JXcn1Tw==
X-CSE-MsgGUID: Q6peQj6qSzm/P4/HDGEFhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="194222483"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 07:07:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 07:07:09 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 07:07:09 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 07:07:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzBX9M0N0t8MIfANmonHmopuw9UXmxElkRXpnC0iQG3rtZRLRZb/4J+zawRUhN9oUKHKP+vOw1JA7SbAAYpO1Vp0vGI6QiQfdsZjrh/kS/9sn0EmYQtRjEYbs2Xsfxr1mL57UEOyHCAo1lgW0y2OBTLSTm05bQBCcUv+Y/TKPRT0mCJPkUXpZp1fiE+tzg15LGXqaNeXCFw+GgixSRlP3dmdbJ0YHP3o9ALmic4tL8DkK0QPRGphxAa0DHdejW65W2byZe4niAgiGbo7ghFRfVog25s/RYXl+m/PIkuPnNU4PJC26SxZn9I7TeBCGGqxn2N24DBT+cmOkW0nkNVe6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzUEXFI1X30x2b9vMkbtKDs0cSxb1FnWnZxMJlAMDi4=;
 b=ymWVGmp4Qsr1dTQzEOlIxHSgSeuxAxPw727tfJiIldkg9nNpIC9oiqy3ecGZiuJ6DFSZxnhZrWK2lN4/VueCCS3QEIYXdcaLt1zeIeAQjxpkd8eFE5L1yMk5BtgTA5wZOV41jlvGulFrF5G8UOgHPnRqaLfgJq5PKGf4yrZntHpTKSUGSrd0/cfffDnUsJqkdxbORBTQSWGo5ONUIJo0fSHTBcogi3+D/XfGRZxIfgyxwBscO0/7WGkv6rQ2dRUWrO0W7boQA97cKcwkC/qeXAYI1ep29LO7/ADRQfYIq7JRoNRlgZYvjsFkGtPrlmDLYIDtXPg5PlveAYUU8o58ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by DS7PR11MB6078.namprd11.prod.outlook.com (2603:10b6:8:86::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Wed, 12 Nov 2025 15:07:05 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:07:04 +0000
Message-ID: <6d348789-dcfa-4119-8005-5e3e128fc76f@intel.com>
Date: Wed, 12 Nov 2025 16:06:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: avs: Replace snprintf() with scnprintf()
To: David Laight <david.laight.linux@gmail.com>, <hariconscious@gmail.com>
CC: <liam.r.girdwood@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<kai.vehmanen@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
	<amadeuszx.slawinski@linux.intel.com>, <sakari.ailus@linux.intel.com>,
	<khalid@kernel.org>, <shuah@kernel.org>, <david.hunter.linux@gmail.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251112120235.54328-2-hariconscious@gmail.com>
 <20251112135028.18921229@pumpkin>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20251112135028.18921229@pumpkin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0075.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::28) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|DS7PR11MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 557a6e7c-4b16-46cf-0208-08de21fd23d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blRjeHFlNTFVbDdoaUVZdWRKNU9KRlJ4VkpIQUFCMms2NWU5WXBuaVRFSFVv?=
 =?utf-8?B?OEg5akpobXNpSjVBOWN1Wjd6VFpzMTVjenpiVm1qWENiSmcvd05VVnhsVEpE?=
 =?utf-8?B?SWJ1bWpuZnhYcy9wWXA2a3JEaTBBYzgvanMxdkhHc01OM09seWJVMFhjMWpi?=
 =?utf-8?B?cnZxMXB1WmdUQytWa3BQYjlqUWloc1FYaVNoSGxXbng2dEEyNE1PeXBkK0Jl?=
 =?utf-8?B?eDZLcWFkUWl3UjFjL1NNM3pEeWFZcVozdTlaL1BmTEhnNHZBdEtxMjQ5dHBB?=
 =?utf-8?B?ZE5MVG9ROUpzQldFWTRGeC9EWjNENVRrK1VqYmVOemF4R2tmVVc1OGtpWUZ1?=
 =?utf-8?B?ZnErUG9xR0dUblF3Z2QwM0NnUmFhaGdENGlFdkRza3kzS2xFSG50Zng5QUFX?=
 =?utf-8?B?aWpaZ1FabTJyTXI5L2w2NXFTMjl0Z1FTdUdhSzI2RHJPTktUOXhudkhHcTV2?=
 =?utf-8?B?SjVucklHUEwySksydGhLMzM1RWNwdWRDTVg5N1d2bDduMGtUeVoybWVoU1Uv?=
 =?utf-8?B?bDdBNVFvRWwzR2JLamw1MUJlazRFdVlGQTBHaGlZQ20yTzVubXd2c0R6ZWQr?=
 =?utf-8?B?MVFCeHd4THlrcWgvdjVTbGJPVmdiOGJMRUJRZDhCNFY1MVRTTURoOHFybGg5?=
 =?utf-8?B?K1h2WVp4UHFQUXFkazU5NnU2STRVVkpiTjdRTWV1QVp0VFpIb2Vkek00a3Rn?=
 =?utf-8?B?OGViL0ZBRERJeklESzBSWXh5LzhqZVdOZXRWVk5yUHV2THRyQTIzMUZqUFhC?=
 =?utf-8?B?VXZpbGVObUV4UFpkMXhYUEV2ZktIanQwbFArM1k1NTU1WkM0Y2ZyTjhiZnNn?=
 =?utf-8?B?VmE5Z1h4UWJoTEcrSURSbGpMWmpZdEY4dzA5Zjd0d29Rby9hZEhHcFNYcksr?=
 =?utf-8?B?Sm5XK2NLMGJpQ1FMb0xEc2trN01qcnl2Rm9CNS9JMnltOW8ycGFJWWpXUTNG?=
 =?utf-8?B?NHF4NzNpa0t6Nm9VRTJzYklraWhIQUVhOW9TT2tHSE13WmpRakN1TW94bjBw?=
 =?utf-8?B?Z0Y4aFNIeEQ5QW5oRXVjbEVKL0N1SVdiWWJ1UHVnZU9Ja1RkNTNKandIbFR2?=
 =?utf-8?B?M2R3bHlzNUphayt2cDRrTE0rbkp6UXR1SEIyczJYakRZN1BDQXpHUlpJOEdu?=
 =?utf-8?B?ZFFGQWdjZDI3OFJ2TVgvS0xaWTdsVnVrVE5VYWR2M2d5Y3A1Z01LamRvWGNm?=
 =?utf-8?B?c0NpckZEck4wLzc5bkl0TFgvQ05ZK0F0K2UvMlVHNFNkazdxSDA5ekhGTnRW?=
 =?utf-8?B?SllXUmg5TXVacUQxR2hrS2tTZE94YStGTFpUTWthK2xtY2dGSWxobzdLMlRs?=
 =?utf-8?B?OFI1UjdGbjFxMkQza01MOUxzSGpqajBLUnJMOWpHSndRbTRZV0JlcEJQY0hT?=
 =?utf-8?B?Uk9qZ3V3OXRtUEpFci92a05jVGZjZktPczFVWUJ2VExuLzZZL2lVSnk4RDlr?=
 =?utf-8?B?WGVGdXJQWk03ODc5TDhJUWFDNi9vTE1WWHNYaHFmL1phZFRndHdLbjFaK0Jv?=
 =?utf-8?B?b2RKNzcyTFZQQXUwVmpKNGY3Rnlvd2hTQjJ6UWp4anhXSkNoM1MrWWFQRTlS?=
 =?utf-8?B?eGlDT1hnTXVEVzhyUDZMcGMraFJYd2xJU29GbmhDWVJhYk1VQlVUcmkxa0Q2?=
 =?utf-8?B?eERmSEVHMEU0RXIzS3Z4WG9xV0VoYk5EdFE0ZEh5VHNjbFp2WnVvVStlaDIw?=
 =?utf-8?B?bnJtT01CbFRQNklZcWhZL0plVmVzZTgyYitwYlU0Z2tNS0ZqQ2JuYzMyeHJX?=
 =?utf-8?B?VUw1RlFiYmQyUXViT1R0SmhDU3Jva0NVem9INDc2NEIxZlBJN2syOCtxRTFy?=
 =?utf-8?B?cXNvR2xwUmpkRkM3U3JNZW1RM29seDc5ZldITjgzaGlGbm9ad0FtWHc4U2t5?=
 =?utf-8?B?aXczUnRrcFFBSWRyaVJUT2owUDZqY29HSEV2ZHVNQy85WEpMb0JvU3hVZXpt?=
 =?utf-8?B?ZnFyUnFydGJDaGEyV2E5bjZFbmpBOUdZcHpYN1dVOUZNb3hLVTVwa1pQVDU3?=
 =?utf-8?B?bTliRERMVUl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2ZORjVBbGR6NzB5SVVvWlBSN1g4Z0dLQTFOZEs3WU1hZXE0L1NxS0k0VGdK?=
 =?utf-8?B?Z3FkT1h2dTAwZ1BCUmc4clNzMnM2TFQ5Lzc0ZTd6bTV0QW9WaHF3Z0hFUlg1?=
 =?utf-8?B?dktNaHYwWVBRYTc5MUdTcDB4OXJ6bTJGdnNmbUl5QzF4SDdJcE9BNGwvcnFK?=
 =?utf-8?B?blU2UEV1a05IU3IvNmo1L3preU1UUkJUWFlrNnplU3FmbFBUdWpzSDN1OGhR?=
 =?utf-8?B?eW93aEhxSGdlQnNPbUFvc0lEYmZFSWVmRm1wNXJ4MXg4ZUZxb0NnZVE1dm02?=
 =?utf-8?B?QkV1TGxJaUNDa2Y1RXRkckJaTEV3bWVXMWVzeGx2MmpmZ0pLTVpYV1orNTg5?=
 =?utf-8?B?OEV4RCtlL1p5ZmkzU3pia29mODZYWGI2OGs1dWhWT1BRU3BKOUlBNXY1V0RY?=
 =?utf-8?B?cEdpUW9aV1dZT2U3OFd6WlVYajkyYVFYckJBTFEzbEpRM1hjR3ErQ1JaaUdP?=
 =?utf-8?B?RE8veE5ZYlRDVitiMHd0OGkya1RwREZwQm9UcW5QYnBVVEdUUFM3TzlNZ2dq?=
 =?utf-8?B?aWVqZjZCQS9VamJzeTlHekxCVHRIY3Ixb0hHRkxCL1RmZkVjU1V0QVJac0lQ?=
 =?utf-8?B?eDlVWFNxUCtmUHdRMU5FbmpiUWhwY2RKdjVOZHBLcWtpMnRkS2ErWjI0ODU4?=
 =?utf-8?B?WWZlRzhXamhMam54ZFlXZUlEc1hQMExTVGdGVkRKZ1RTRHJ6THkyd3ZGQjBT?=
 =?utf-8?B?Q0ZpUm82b01WVlNHZmE4T210RnlycW5ta1ZtV25qMmpVT0dqOTZCZyt2Y3p1?=
 =?utf-8?B?U0Z1WElxNTJNUDdKbEEraUtrR3JFcHBNRWxRakVMUU1CcEppTFF2Z0JZRWV2?=
 =?utf-8?B?a2xEUUIvRms0RlkxckNzdzVKZ0k5VklQU2NaZ0t4ekJ6SjVxMkJ3eThWYXNH?=
 =?utf-8?B?STBIWUhrVDZkd0w5ZmtxNW1iUHVPRjJ1VlplNEE3SVJPT1lIL0o2czRjckJO?=
 =?utf-8?B?b3dKM2MzcHg3V2dwK2o3N2ZSOXl1L2w1ZThRTXlhZS9qMm8zWXIzTXE3S201?=
 =?utf-8?B?ZEFvcElQYW5PVUFCYUJURHM0SVBGVlNMbnI3TktWdXNvSXVYNDNsaUZVZDFE?=
 =?utf-8?B?dXlpYXN6TjVtTzd4a014aG1HcmV2RVF6R0plcW9rTjhxenJtQ3B3UENpeGs5?=
 =?utf-8?B?R3E3QVRwSWgwS1FPRkwxb09CeFJMQ05yMDRGOG9BUWN2eGhmZG14ejhEVkE5?=
 =?utf-8?B?eks1UXV2c1Zkd2pyT1BMbCtuNXpQZCtaK0pGRDRZQ3lob29VUjl6c2JUZ2JL?=
 =?utf-8?B?b1JUeDJSWDBHdUxOT25oZjcyT0wyajJQdUtRcGZqZ0g2elhSWWFTOEllbU5z?=
 =?utf-8?B?YXJtc1JUcGhYZXNTeXEyMW9nWlVDN095MHp4SDhyMGUyMVpaZWFrTGthZm1h?=
 =?utf-8?B?ZmpRTngvdmhtaDNSNDg3a3MwQ1pURkY0MWh2MjMraFJJeHpTQ2FPK2NwdGQv?=
 =?utf-8?B?TGErM08xVW1OUUNxd1Q3eDY1SVV2WFJ4TEFOaDloSXJpTkpOOWZRa042MU4r?=
 =?utf-8?B?NTZmVE1hTWpjRzh2aUhuRFVOSXpwNnVYVTBhSkIyL1lqL3A4Y3pMZUNoUVh1?=
 =?utf-8?B?RFg4akxhRnN6ejVJTzRwSzVnMTJOazNvZmZDaTY5U3MrNG5QendvS2hJWlVK?=
 =?utf-8?B?N0hKcHdtcEhzaFF6U3JMU0ViZWxqQWFqalBlTTRVSk55bHhwVzdvV2YxdC8y?=
 =?utf-8?B?YTNIbTUvSzJsQXBOeW5JY3pVeldWOXpBS002OW5uS0hQeGovVkFzQ1lwS1pv?=
 =?utf-8?B?cnlCY0Y0TkJISVNMbTFac1dXQjhvcDVYZ1pGUVp4SXNvUnNJaE1SWU9CZnll?=
 =?utf-8?B?T3dvckE5OVdyMW83MUx6eGJTY2xQaFNvdzJYcFQwNUtnVnN1U0l0SDhDemJa?=
 =?utf-8?B?WExXdWdRYUVpZ0ttV28vditrSkJYcnFjVWpqZUJDTmdBUVJ3dVRmamtRamRH?=
 =?utf-8?B?SU93QW85YmdHbjB6YlJyMmRTenZVTUliUnR6Z2hmdEwwWklsRUd1RHJvaGll?=
 =?utf-8?B?Y1NoS0ZPNk5ERGc2RFRGRW1FaWk4YkNnZVlrZEx1UW1BaEp5Zng3aEZaSUFq?=
 =?utf-8?B?d1FET2JxbFVDdVE1aUhFcnFTV2hQRDNkWWE2UlhTblRYTmZpS2dOWHNxMisw?=
 =?utf-8?B?elg2SVF0TkZRdS9jRXQ0d3NEalE0VlF2WXVVQVBDTUpHYTA5cld0ZjFIVTVQ?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 557a6e7c-4b16-46cf-0208-08de21fd23d7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:07:04.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vLhJ+HuAVdU874i+t3grj1aDCb+nLdZ2liDHxKIyJQjDfai/oHx2ESb1arM9or+kD3pD7k7BUsV2zyWG/5IiEeR04X3VZyPSRq1ebGKJFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6078
X-OriginatorOrg: intel.com

On 2025-11-12 2:50 PM, David Laight wrote:
> On Wed, 12 Nov 2025 17:32:35 +0530
> hariconscious@gmail.com wrote:
> 
>> From: HariKrishna Sagala <hariconscious@gmail.com>
>>
>> As per the C99 standard snprintf() returns the length of the data
>> that *would have been* written if there were enough space for it.
>> It's generally considered safer to use the scnprintf() variant.

Thank you for patch, HariKrishna.

> 
> Did you actually read the code?
> In this case the code is actually rather buggy and can read beyond
> the end of 'buf[]'.
> 
> Neither snprintf() nor scnprintf() ever return -1 on error.
> So the existing code will attempt to write past the end of buf[]
> if there are a lot of entries.
> Fortunately there is a test for negative lengths - so nothing is
> written past the end - but the read can return data off the end.
> 
> Changing to scnprintf() stops this happening, but the user will get
> truncated data.


Both may discard characters. Regardless, I agree, when building strings 
in iterative fashion, scnprintf() shall be used over snprintf(). 
Essentially, this patch is a fix, so a proper 'Fixes: ' tag is required 
along with update to the commit message.

I'd start with dropping "It's generally considered safer to use the 
scnprintf() variant." No guessing here. If you're wondering how to word 
it, I'd suggesting to use Takashi's message from commit ca3b7b9dc9bc 
("ASoC: Intel: avs: Fix potential buffer overflow by snprintf()") as a 
reference.

In fact, the existing code could be simplified, however, the 
simplification does not need to be part of the fix.

(for those wondering about the entry count - ~10 tops, AudioDSP firmware 
limitation, +/- 1 depending on the SoC generation)

> 
> 	David
> 
> 
>>
>> Link: https://github.com/KSPP/linux/issues/105
>> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
>> ---
>> This patch replaces snprintf() varaint with scnprintf() in
>> scenario to know the actual length of the data rather than *would
>> have been* written data of snprintf().
>> No functional changes intended.
>> Reference Links:
>> https://lwn.net/Articles/69419/
>> https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.snprintf
>>
>> Note:
>> Compile & boot tested with necessary config parameters.
>> Other areas of AVS uses scnprintf() variant.
>>
>>   sound/soc/intel/avs/debugfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/avs/debugfs.c b/sound/soc/intel/avs/debugfs.c
>> index 3534de46f9e4..100b95bfcd78 100644
>> --- a/sound/soc/intel/avs/debugfs.c
>> +++ b/sound/soc/intel/avs/debugfs.c
>> @@ -119,7 +119,7 @@ static ssize_t probe_points_read(struct file *file, char __user *to, size_t coun
>>   	}
>>   
>>   	for (i = 0; i < num_desc; i++) {
>> -		ret = snprintf(buf + len, PAGE_SIZE - len,
>> +		ret = scnprintf(buf + len, PAGE_SIZE - len,
>>   			       "Id: %#010x  Purpose: %d  Node id: %#x\n",
>>   			       desc[i].id.value, desc[i].purpose, desc[i].node_id.val);

Indentation is off, please adjust.

>>   		if (ret < 0)
>>
>> base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
> 


