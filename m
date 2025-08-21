Return-Path: <linux-kernel+bounces-778974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4CBB2ED63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E741BC7763
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFB321507F;
	Thu, 21 Aug 2025 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOyYTXT4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3613A3C17
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755752631; cv=fail; b=OnJzWB6GcNtl1UVichd7U94fMzABMGGkuLlHDxEZlnmt8GFkjAaNcJbEVfS4dOSeUqSQXYKHqS+6nVgdBgsSGGk0hqgSO+kBRGKOA4PEzwzaQJ3hKS5iSP5XKgw0Q1CMcx5aBHHLnBm/s7pDikf7r3XGTHXom6B2SNCgujzMXLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755752631; c=relaxed/simple;
	bh=T0uKaa9s2r17Y9V+UpIxP+OGi40eA1Fca74GOeHh+O8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uY5y5p22xcHcxi1dqsrWWn5VTlAZI/4nyB3Xl9hhrS4faK9ItZBYv/sK9P8FzlEI66qPy+3IXBoDdQty4177nOwz70I9qMf+N2PaiE5mdJ2B8ZDIPga8Iwuewa67GAZrMqU7aI+0oKxXvM7iow2/4dHfHQxWgHa6e3JQ1xsy8WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOyYTXT4; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755752629; x=1787288629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T0uKaa9s2r17Y9V+UpIxP+OGi40eA1Fca74GOeHh+O8=;
  b=fOyYTXT4Xos78mGWy7ZzTvQr5lnZcOQX4aqEtN6meJc3wwYPNPmFlkM7
   FXBrrKwYnGSznN0oN7PnXB7a05jIWDUvKUz+xYx6IXSSDWCaqAS0SGS+E
   KevqEMA69lRHiTRf6ioMvJQaHOyEiFawkNufjDdrz6Ty/RVl1tckYJAxP
   /jpyWMDSUpXuAPPa3GL2r5Xo2l2aNoDg33KEJu/gD4gxZB6RWbEJnOju8
   nm86l+kFrNwPn2HGDphcX+tIAn5kT/jTyNK2CZ2EgqMT5MRZA6RFHaQUv
   h3iPn3ht4EvDreIF3z7XHqdsIEkAF1jD/wgrMlLSal6QdSsGBtzqvILa1
   w==;
X-CSE-ConnectionGUID: BTZRgviYTiOR7w9I6nYdbw==
X-CSE-MsgGUID: 4Wo0MABAS3O06EHvt84iXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61843671"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61843671"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 22:03:48 -0700
X-CSE-ConnectionGUID: q123wmAFQDWYE28hbvCTRw==
X-CSE-MsgGUID: CGYPcx7gROelJz4nxRigbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168239876"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 22:03:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 22:03:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 22:03:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.63)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 22:03:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL99rcDL8YJumzt/8bBJFDC/bc8/AZ2q6yZ1/Yg0ugwU+8cXe1vTIFuZApoUArskT9dYGRwaVDu6ghJ4JtIAdQASKfBX9aQss/TY+Ek3Go98PojwGr2WNLPcehs+052dQL7TtW5qZFnCg76AxaN7212R7EagPnNywv+doiD0GlNZ6VmGTaQgmvIkyAL7WxulFz6my389G+7SkAwSQpG91Lti6rTftZPTvAbfxVeQp2NO5oKF2+kl8r7G7qunrGj3TweClypzjuIj5wPeFx/zLG/h7RhE/EHyM+PihuZQCrCKgmpaMetOgB711M9SXXSReD5j+ZAGnlaZ7T1Mg3WPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLOix0GD6dlUWWHno2M8rtKAcFFyYJPcOrdtZv/7ajI=;
 b=VmGwi67SEx//ytjGrNsDtteMIzA4ngtH7F6gTRVfrkhL/FG8ICnmIIU9/XsX5Us5tciKXPF2iIewG6XnQaKPSeQ0KC9SEpMrl09h5IKqryIH/D7HcFM+Fy+MhjITrV2hZ6e0Xj9mvmw1LR3b51wIrjuby9m2V8aHy+TgLBDrsu4O4apMUf/OZPAXIWzwD31fNV7bCwTNY/yvd8oXpt6aTYxBKlkoWQ0VG15V45ttOVsGn3nVp5LAk5AZ6EyFS+aEvHq5uSxo94WluFtjStiJg62aB+Q8/ON3AC0aoGAbWuW7psSR76MCL5r6XU2vcHnRyho4yc7kLrryaO+2IyA2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA3PR11MB7626.namprd11.prod.outlook.com (2603:10b6:806:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Thu, 21 Aug
 2025 05:03:37 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 05:03:37 +0000
Message-ID: <d8f416d4-a6cd-46bc-809f-b74cb4bbaff7@intel.com>
Date: Wed, 20 Aug 2025 22:03:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v1 1/2] x86/microcode: Add microcode= cmdline parsing
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
CC: "Chang S. Bae" <chang.seok.bae@intel.com>, LKML
	<linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>
References: <20250820135043.19048-1-bp@kernel.org>
 <20250820135043.19048-2-bp@kernel.org>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250820135043.19048-2-bp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA3PR11MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 4343f761-3f40-452b-8415-08dde070165d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1FUK2dDVGNWRURveUVGbXZ3UElZYXUrNEVySThiQ2tDQ2dHN0JLY21DU2Ny?=
 =?utf-8?B?TGVSOXBwSHNHTklCc1V1OHVwbE9vcUMzZFR2Y3hCSHd2eDkwMVBtWDEwWUkr?=
 =?utf-8?B?OXByWUdCTTUwbTBLUGVINVhOa1IwWlk5UU9RSUxBTHdOTk5sMkpKRFNtM3BG?=
 =?utf-8?B?ak9wUmVTT3hibHBXL3lLMjZYYmRGZmY4NjVrdXp1ZEluN0JtRGNlUHBRaE1H?=
 =?utf-8?B?WDlYRkFkblpmcGMxdS9aUXB3aElRMkRpU1VFQStRSzdnUTdkWHFxTU5GWkN4?=
 =?utf-8?B?TUlQa3I1VGxyd2pmV1dzbzlwSXBEbG1nRXJDSjdZcktLcDZzdUgxRWVhYUxa?=
 =?utf-8?B?U09yNXdFejdHbURYeFJUTkpBbWhSdU5zNGZ3aXRzbWtaU1hwcnlYcFZQamZl?=
 =?utf-8?B?eVVScmRqc0xQV2tTL3dYVWJqQXdDbkk1SHZzYnNQbkN3NE5rWXh1eWRVV1Ry?=
 =?utf-8?B?UkxHWUd5ZnV0dDZhNGpaTllQYk0weVF2L1NKR1RIQVllTVhRQnVFN2hNL0l4?=
 =?utf-8?B?eDRtNGFvd3o1WXlNelZQcHExWHhUci9oZ01zamN2Smdzd1lnbC8zU1Q3RUlS?=
 =?utf-8?B?Y200SjN3OUEzRWVBeERSaHlObnZEbHVLOWxoK1J5UCtUOVlDVHFwTG5GOU12?=
 =?utf-8?B?U0pYS0w1RjZuczlOYW12bVZzQTFSdmhvVU54K0xjVThPK2N4MHVvOGRXTFhl?=
 =?utf-8?B?d081WkVFR2ZMMEw1OFZYT2pOMDI3cUVIZkQ2d0x0TUV6cmFTVUY0N2tjcXFu?=
 =?utf-8?B?TFY0eWNLakd3ZzhWTXBPOTB2L0ZtMlFOK2hEbmFTdktSL3c3VFBwVTlZeVVG?=
 =?utf-8?B?UHZWbXRVVDFMU2FDM3hhazNjYmtSY3VFVmVuWUVUc3EzUDFEOUFzWXk5TkEv?=
 =?utf-8?B?cGhEb1JacXgrNzJ4NEhXY2o5dGo0aDJKekxrNTdrTitrZE5FQlR1Wk5ZOVdQ?=
 =?utf-8?B?bU5YSm5pTVl1cXJaZ0JHQnRkaStlczlMY0xkSmJIQ0JIWEtZandGK2pSREc1?=
 =?utf-8?B?RXZsN2MvcGlra1VtUTBTMDBvM0tWZWJpVkUzdDlmTEhPR2pOQktQeHJZTVZG?=
 =?utf-8?B?M3hqT1VUTVIyY2VHbGcwMkRUSnpXZFFNRm9qWTgxVWNjNmJObExhWjlrZDlI?=
 =?utf-8?B?d0k1dExWYTJ0a3I2a050disxUHg5SEk2QXArcDFwM2lrVUlVZ3Y0ajNWZDEr?=
 =?utf-8?B?c3FZUU9YblJTL2RhNnFsMmdqbXBJQ1lsMmg2L0JMVHlqeGFKcjhqUzhXcXVQ?=
 =?utf-8?B?UWpSVnY4ckc2cVlLQW1rU1BkcUkzOHYzeWREOGRRUHBlemp3aE1EOTNQd2ZH?=
 =?utf-8?B?OGR3WDlsRmg5MHd3T1ZHdVZ4MmFjQTI2enBmSDF6SVl3YXNxa1g3ZE0vVkRG?=
 =?utf-8?B?TllZMWoxQzg2UFhGZ3lGY3RmbUhWZnRhUlFua0k0RXlQLzdqWUpFSFM0MjBP?=
 =?utf-8?B?czNISXBabXJRSXBEaTl4OXpSbXdhWWRWNVdUbTRlT1I2azlkbzl2SnNVeVFM?=
 =?utf-8?B?ZExjR0ppVVlDbFVWZmYrWGJkQzZLd3BmVUl1U2VERHBDMmhPeFRGSlV2T05J?=
 =?utf-8?B?UC83RzBGZ2luS0hKa0M5WkIzZlphVFhqMnZiZjM4TWs4cG5yK0VlakZ6UWlF?=
 =?utf-8?B?Y1B6TUE3NVZtM1NWV09VUk13SjNHU3NGbXlKcFNjSnhyOXl5YTYrU0Rldmpj?=
 =?utf-8?B?WWdmcDNIQ3lGT0QzVG11d0h4dXdtOFZCSnZiTXUvUjluMllhdC9SVmtpd3hU?=
 =?utf-8?B?dlgwU1hOVkVQS09VUDh3T3hQZm44ekF1Q2RQTy9ScUUxekJsS3JzSWJWTjV5?=
 =?utf-8?B?dytxeUhxUHRnUlBTRmRycFE2NG1zZkJUUHU5UldrdWRCa3g3bzdRNUsyeXRa?=
 =?utf-8?B?TmhJNHhjWC9FTEYvR0NYenpBTlNEZ2cyZE10UFAydWYyWFQ5MW1zYmZQdGVS?=
 =?utf-8?Q?v7rb8ngEgd4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmtvS2t2Sm15OURlWEFiVi9XenpiNHMwdGJ2Z0JUVm1OTFdkNFZqZTk4ZEMv?=
 =?utf-8?B?MkxxVWs3Y2hZU2xCZ09CQ0ZDK3VKVUxEaHVYbkE0L21rdnd0czczWnBzRXV6?=
 =?utf-8?B?REowQ04zRmdteDlSSnhydTUxYzF0a3NMWlhDREJtT3JwSENBK3NKL2RUNDk5?=
 =?utf-8?B?eDd4QWpSRkhXRHhKZksyT1dtWFdVOW1zSDI0YjJGWGhsM3c2aEoxcXNxQk5J?=
 =?utf-8?B?ZzdjZUZHM1doZjRpbzJaeFh6Z3hRV292a0k2anJRZVAyK2MvUnkyYWhoYlRa?=
 =?utf-8?B?Q3lLODJIdEtCOFR5TWZpZ0xwbkF5RmZRb2VnYlcrcUllV240elI3T1grYld4?=
 =?utf-8?B?Q2VWck00dzNmRDhVSE1HZmtuS01vWHNjTEgzc0Q5NW5HMytWRkh3ekF0MnMw?=
 =?utf-8?B?SEEzd2pBdTJaR09PZFFQbkRyMDNvamRjK3FOeHJFWXBsUVpPOWJ2ZVNpcndL?=
 =?utf-8?B?cXVncS9lbGMzNVdKci95ZlR4NTFxZnJnb0g1RkVyN2gxRzRneTY0VFRPcTJq?=
 =?utf-8?B?NVEreThwb0M0dWtoc0pkZVJ2TFhmZ3c0VkRLdXNiS0ltOVRyb2NVWDM5U3VS?=
 =?utf-8?B?Y2NjOGhHTkJyVHZVRHZ3MlRibU4zYTYyUFI1cGdHemZhWHhRUEtOTlM5Vmda?=
 =?utf-8?B?UnFMbG5wSmZ1UVNTeWVOb3V6QUQrRkdaTGFiZ3pUZDZkcS9odEVPMjMrZlpn?=
 =?utf-8?B?b1hLbVg2SXJTQzdhaFhPU1JMNklMd25jeWlEU0kxOUdkYzN2ZW9oSjBxOElq?=
 =?utf-8?B?ZEN4eHk1cWp4a1AwSTV5c1ZtMlBDT29pZ2R0ejVWOHZ5ZDhqMzdua0lKV2Y0?=
 =?utf-8?B?VTdCZXgxcXhkeEhmMXhIeEo3Q2EzZWpsS2VaUjZaWEVGMHpjSzJpN2lhT05T?=
 =?utf-8?B?eTE0eGkzc29GeksrbUtxTkV6U0N1aVBGN0sxdFVOaXB4OHgwd0ZGUXBNSjl0?=
 =?utf-8?B?L0hLSnhrTUtKcFhTSzFRb3lkb1lXME5DTzA4RWtnWjFSL2JYOHdLMUNjdHFz?=
 =?utf-8?B?dnhlNmZiOVRkY1FkOFlwcEpFb3E5MGptdkVTYlhGK1FyT2dybUIzWGtkRDNJ?=
 =?utf-8?B?SWFPUzZFbEx2dFVxcW1CYzhXM3FlRkNINGVXV0VRTFVVZkdmVWdaclNOYXor?=
 =?utf-8?B?SU03STk4UVRLRlRTSnZTUTRDWGFJWTYzMm5kNjhvc2toZXF1MkpNS0MxczBO?=
 =?utf-8?B?SUtaMGorZThQR2JUNW1haTNWR2MxbVZqTzhmNWowWnc0S3hvTTNiZ0xZZGRW?=
 =?utf-8?B?UTJmMUpOMExGMEJ2cSt2dk91eEdwQmQxRytaam1ZSlpCbktXZkJCcTJMTjd0?=
 =?utf-8?B?TW9Jdk83U2NtcG00T2pGNko5YXNTelNXelhaSEJEa2dIMUg2SUxOR0ZiTVg3?=
 =?utf-8?B?eTFDY2tGN21uR0JqNnc3Wlg4cEhFTEJ5dXozN1lCYkt2WjFRaTFMeitDNmQ2?=
 =?utf-8?B?T0ZZZmc0WUV5UVJwYm5ScHVZMGROWG1sMVdOTVU2ek4zL3RVNEdZSjY5dlRX?=
 =?utf-8?B?UDZWci9aU0dMdTF4YnQralM3M3BoaVpSb2dObU55Qy85eS84aGZQZjhJMkZ5?=
 =?utf-8?B?UnlzSWd3b1d5dmxlaXZVQWNDbmhEaStXeGRLajlxRkRCL2xScW5xRThNcmZG?=
 =?utf-8?B?UGhPUXJVOStBbkdKOW12dG50WXdWK3N6aDFQMEZKL0ZMcDhaSEZVNmVLaGQw?=
 =?utf-8?B?aGRnRjZjV3lKL3hlNU9ZVDRMNkJrM01PbG9hVHREM0JzWGgycEtrZXhnUjh6?=
 =?utf-8?B?V2tpUDR2ZFYzYlIzZStNTWtwT2pmVDlEVW0yYkdEM0UwMWs0ZG5Rd0dwaEMv?=
 =?utf-8?B?eDR0dUcwQWZiZmR4bEVvV1NFeWVSR1kyMWlScnIxYW0xMUw2cHRxa1lmaXRw?=
 =?utf-8?B?LzZyVDZJTUIrWnlYZG5aVFo1bFhrVWlhTWVkRXdhMnFHU3FDaXFnbWQ4MmFq?=
 =?utf-8?B?a3dPbzh6dlpuTnpVR0lGVVIzSThLT1M5NjRydHRTdDBZQmpTdkFuN29MWlJY?=
 =?utf-8?B?algyTjFBTklnL2YyZzNtZ3dFMHRsejc4N1M5ZnczdjZCMXJRRmNGWFNiaG1Q?=
 =?utf-8?B?eFN2VHhBVG9uUUVjOHRHUnpBMGwweE1ieVFvTU05TW55Y3F3TGpMczhKODdu?=
 =?utf-8?Q?62ykdOFDpYJxKvgr9alwmBY1d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4343f761-3f40-452b-8415-08dde070165d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 05:03:37.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nX9gGe7fiCUbNYKsJ/uLbdXGX49QoFPjpfwYycOPW6YaQde+40v/ZtwIM+hP4uhm2GW8MI7Ty464f6Q3KrfDmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7626
X-OriginatorOrg: intel.com

On 8/20/2025 6:50 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Add a "microcode=" command line argument after which all options can be
> passed in a comma-separated list.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 ++++--
>  arch/x86/Kconfig                              |  4 +--
>  arch/x86/kernel/cpu/microcode/core.c          | 26 ++++++++++++++++---
>  3 files changed, 30 insertions(+), 8 deletions(-)
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

