Return-Path: <linux-kernel+bounces-883742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CECAC2E39A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC48188E642
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7442EFD89;
	Mon,  3 Nov 2025 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMWfZW7c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AE2DF122;
	Mon,  3 Nov 2025 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208019; cv=fail; b=jEmzn2bRzePs3APEwpAhZBOWOPN8777jCDXOTGYZOR5g/0aznQHD2zeneyy8wDZU34+13bruL25R6oh9FcXeGv1Rmpbv/N4ojBQ86xYGz2ETzNXz1fA4aUTUKvZzeQIOEtdylC9z4xe4tRKR9kUHubmYtziBlocLMrUD7fVBvIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208019; c=relaxed/simple;
	bh=9bFIXObU8IlAsAbFZRVhJ17MDnSBaUkI3CPSjNkmK3g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mucDzW/KFmsTQoSJPP9LRamzix5iHOSokB3+OJWgJPbMP9AkPmWqSOVjizqxXvo4tKB8zNpttWTWYv24wEJTkEQGFKxA+J2p5rEW9aTXKqNwGhAXJOoEP0G/vECeO/Ht6+b6DwYQmUWDJIqBRY4bnnU/wbcYiIZ9pOn1l/ZXGLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMWfZW7c; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762208018; x=1793744018;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9bFIXObU8IlAsAbFZRVhJ17MDnSBaUkI3CPSjNkmK3g=;
  b=OMWfZW7cosGGDK6yzfFQVS1h6SsQnC+qYtPCpMQZXkECAIoekKH2oOfl
   EzpB3O+QdR9Gn9MXd9DEDwYlEW4j6aA/KiGAqIxJ4raU9PE+Bwti89wpE
   inIa2Pyd/R5COG7mN8/H/rPj2fhrFU92Sc3m6Ei2ZvRzruCe0F77Cq2ds
   twGfh2fhIzXcyOFwQfER9bKsUGhQWOglj/YWrjdMM+2h67AJFlzcv8Xc3
   LEmCheksd7yEShVh4DRNEMfuebMH9PyS0pitIYjcCPMqjXc8qeNoRPc2f
   FgXUfNInY2NcUV++lGqP6DvVbYPHKqQcqGyzBTu8DUv1vMdvdB6Co8y9B
   A==;
X-CSE-ConnectionGUID: aEvl78KvQkqFsG12I9EZ+w==
X-CSE-MsgGUID: hqWiRBbURcuq+mNFuS6VIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68132953"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68132953"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 14:13:37 -0800
X-CSE-ConnectionGUID: oXw2gzcnSLOs2usdOdYkpw==
X-CSE-MsgGUID: s4cbq0FPR5KRVNJtGCdt5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186932888"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 14:13:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 14:13:36 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 14:13:36 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 14:13:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMqtJ3zS519J9loX6pILWh+LpqGtFYfjK+0n5ypnp3S1XLDyYq5mcG+6FGzejpsHu9RJxAYSKJtGQHa8iuXd67xYcmrVqSs2pLn0dGBIjGtUGsFDjhvRvYt1Tf77jYNSxcGgJww/bM4lEAEFv2DTEtjtLW7o4jvfCV32fPK/mFRQQ1PIsay+KS+KKGSfyxIKzLk4ACbpZNCeDwvU+S5BgTBT8BDM/EGqGlRprElQuQ+t9Q5/oC9yiIyeArJuWg9YgsjymQwWfmnjbCJX7E6ZqMizKTmnoZVhJn5Sr/6BfXY1fE91NTrAQiEaLz1yIIY8prYNmHS4gPY3BVuO49ORGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqhID1KaDQ5Ua3kBEwNUnU3yCY5a+p7QITYjN1zOiKc=;
 b=YYj6ZVJBCpd6NXIadRzw6V3Gvh7XlGsjFDtNsja6nPApcx2QrcoqK6+3YJt2pED6kqRcPS9Hvnoyaw+OdMaDpD3SNNgSxyGgCWXPlL7TBjHY9V/MHprsg2VJRuzloA6+bmZSOnKflWCridAJudnVrkIvLg/sefXybkidUzkaaN+uV7OqySbBhEBvki8W4br7vOcWFSCH7U9JLLtQi8XdFgNMatlGo/QURqmE8OJEjtUqstWaPd+7L57jZmuy6b1fjDnGFtVr4J8pwYDAirvvn6FzrxgMHjLYMEfuxCkD3zMtw2y/BTWWuDea9aWsjnEsDPHNKSWTqRZUFjslXeHmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB9454.namprd11.prod.outlook.com (2603:10b6:8:28c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:13:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 22:13:34 +0000
Message-ID: <4cf425c3-f952-435f-993e-a7750de23a7d@intel.com>
Date: Mon, 3 Nov 2025 14:13:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl: Slightly optimize cbm_validate()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Tony Luck
	<tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>, James Morse
	<james.morse@arm.com>, Babu Moger <babu.moger@amd.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <c5807e73e0f4068392036a867d24a8e21c200421.1761464280.git.christophe.jaillet@wanadoo.fr>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c5807e73e0f4068392036a867d24a8e21c200421.1761464280.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c097c1-f2dc-42ff-b279-08de1b263ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c01lT3VLbWpDT3lHaE04ZFIvTHZmcUdHYUpxbTYxVjdTVkZyRDBKVVZKRnVY?=
 =?utf-8?B?ZmdXVlJNYXg2OEo4WDlhTk16bUdlSjF5MUxBRmMzTmVJMUhwd0RQRGdrcGxm?=
 =?utf-8?B?WE85aGJvU1lWV3IxazNsWmozQjUzdVdOcm5UZkl1dVFzT1BUK0xZZmd1Nkdy?=
 =?utf-8?B?NWZpRVFFUVYrZ2RERDB6OGpjdTVwNk9hdXBKcmVhM1dubUdBV1VPMHVjZlpv?=
 =?utf-8?B?MUtnTDhOV1hsem01SGp2VlVjSmFocmJqNEhHL3V0ekFNdVJWY0FOcWJFUmpx?=
 =?utf-8?B?STNqKy9ZMmkwejkvYkUrdFBIbFIzbVhQUVQvUGlRTmt2b0I0OUJOR2VkelVa?=
 =?utf-8?B?TmZOTVRLQ0Q0Z1pFSUw3SHJPVFNpbDFuYXJVek9QQXZZWmUvUnA5R3B2S3Z2?=
 =?utf-8?B?VkVHRGJIVWZZSitVOHhJWURNdi9wLy90WlJCVnZzNEFJUWxJeWw3SUgyeUxW?=
 =?utf-8?B?b3o1L2lxd0R3dGkrTXFzaE5IVWptNVZta2JvT1BFSVJWeE9PcjZDeWt2dmtw?=
 =?utf-8?B?TTNzMzFpVHZDVitXb0FrZ2huOVF6cFEwWWRLckVZN2dpNzVFVGlWYlJUNnhn?=
 =?utf-8?B?Tnoyc05Nc0VadE9lVkgvYzYyaHppNGMxeDYyelpaR2Y3Si9mcSt0OXBPZ1Qr?=
 =?utf-8?B?dmZubjBJaSs0Ky9xcUZtSldVRDFtZ083VlFOZ2ZUUjlnV09WazVGcEtUQms1?=
 =?utf-8?B?SlNpbnBIVGp0NzZkVFlScFpKUWlTT3BQV0g2S3kxMXNxSUNGQTRLbU41TVRG?=
 =?utf-8?B?d050QXNGZ1JEUjlYYkQzb0NEU05Ta0lkTXhkaEg0Y0tCY3ZJeVk4N0ZOanA3?=
 =?utf-8?B?YWo4Y1RGNllGT0lWVER6TEk5c1g5M1NHNEltSWdTZU9Sb1ExaWg2RHZxM1RP?=
 =?utf-8?B?L3FVNnF3YUg3VmE2T0JzZVRXZXVpcVYvOFk3V1NGRmtxUitBTXF6Nzk3RTd3?=
 =?utf-8?B?QmJ0UnM3NEdqRUNBbEhac0pFV0ZCQzh1K0krZkU5UjBCeExGZ04zWlluS2pz?=
 =?utf-8?B?K2U5Zlc2dit2a3NYTDlDOEd3Y1pRS1VjcHBUQXVWVFR5ekNBU21tUGV6QUgv?=
 =?utf-8?B?MjFEVnhwT3hqcmVXRWNuYmZ2VGRQblhzREFmR2Z5eGNFNlhCRVNrUi91a2dx?=
 =?utf-8?B?aHRCeFZZYWFPZnZ1RThIdkdSalg4Rm93TnNjTUFyYXVaR2RHSTJJTXIrTDl4?=
 =?utf-8?B?dis4aUh5UTAwUlFHVzRSaVJWZjBGMGsxL0tvWkwrSXJsZHRXQmJjT2J4NU0z?=
 =?utf-8?B?blErc0JwUzYvKy9YZ213T0tuMGM1UTJaRTlsNHJ2dHBZeE5QcTVGVFh1Zm5W?=
 =?utf-8?B?OGczbHdiTngvVDZFUXprWFlzNUZ0RGViODFzcWJtM2FocTEvVERSc2dSVDcz?=
 =?utf-8?B?VmJhQlhhaUNqQk5WSE42ZmE5dVdON283RlJEa2lzaEwzTW1BMWFrZ1hhV2VU?=
 =?utf-8?B?akZsbk5LUm44ZUxMdFhFYUdOeFlnUndlME5hWjZlOEYzZFZWZWZzWVBkSWRp?=
 =?utf-8?B?Mno3SkhjMmpCRlAzRHdNU3lWTzFLNnc4aU1FRTJKZVFXSHl2ZCtpRFoxZVdr?=
 =?utf-8?B?NlRJajlrM24xbHA1QmpzVFo3RVFKOXY0NU5Scks5L1pPanc4eDhMWUlWNU8x?=
 =?utf-8?B?WldPMkhmZzA4cjNGZXhOb21XRDdUQzhYU25MMTZXdmU0SUhmY0Z4V25KeVdo?=
 =?utf-8?B?QjNkTFhEMjdxbGlFZUdnbUwzck1YYWw2L0dhM1JTSEdHVWtwbkN4eDJuL2VV?=
 =?utf-8?B?d3JrUDNBMnIydW5pRUQyK0VFeTdBNFVzamtSNXBqbEVtdHNldThxZWRyNmtt?=
 =?utf-8?B?eGpWOHJ6VFNOK2ZKWXdzNzVuRFhJUHVXa3F0WHM3ZkhWckM2YlJMaTA4Y1l6?=
 =?utf-8?B?eWhyYnZBSmdMaVMrLzhYTnZ2T05FRFFvbzFRSTRvcEJ3VUJrS2liS2l0SCtS?=
 =?utf-8?Q?fS43GixaOkxm5qt1oZdBq2hbdM6T1K/H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2laeE1HWERxa3JFQkJyQkZVTStTbWZiMVdBMyswOCswNE9sdlR2QWgyNk53?=
 =?utf-8?B?VS9xWEpZRlJRVEQ4WnBGa01DYXFDejcvQUdwbnVLR2hiQUd2dnV1dVZheHFV?=
 =?utf-8?B?aW5HUDBna3VvVjlmNCsyQ2xYVS9IZ0Z3di8vRUxWMzk5Q1dxVC9JbXVzbWZv?=
 =?utf-8?B?WGErelhVTWRQYU9kNUVLcStFNFFNajlOTXA2NTRkRk8xaVo5b3lYWWtESkpL?=
 =?utf-8?B?NlNnN3dESUkydmhZMTNiWnJnSDlZUmJYZE9wV1RWZEw2NnUyTnV2QWNlN3Fx?=
 =?utf-8?B?dlQ3TzV6NU90cTJHYlJpay9oUFQ4M3JIVnIva1JrZm11cHFxZmQ0OUx6YSt4?=
 =?utf-8?B?VlVOOTYvNVFnY0kwcU9nQWZvOTUvOGxjVFc1TEhNL21ocTRSTGltaTBpMmtT?=
 =?utf-8?B?T0NTNFhoUXZiU2Z0ZlBsS0Jnem9TVElGMGNyaG1pRFZUZnhybFlEaTJwWGlJ?=
 =?utf-8?B?bmU1VEdwRndoaU5NZm0xdmNwNTUwMkVIbTJjb3BvTUxLRmNQOWJoeFYvRVRH?=
 =?utf-8?B?NFd1VmgwSE9Hb2VBZE5qa293QnU4VUpKVjZtWVE4dHN4ZzhpK2FRUFUydHpX?=
 =?utf-8?B?QUhkR2t5UnZnLzlidUloTUgzd1pLOEw2am5Icy9IOHJWQ2JFQnJUb1p6b1ho?=
 =?utf-8?B?eVQwdFI1cElWa0kwYXBGZThaVlVYOHF2OUFJazR5ZXUzdWJva2l4blZ3NkFH?=
 =?utf-8?B?WGF0aWI2d0dSa0FSZmxDcm9wRlE1M1JHTHRSdlYwc09ZSVk4M2NNbGo5TnFn?=
 =?utf-8?B?bVA3a2FTVW9IMTlpTDNuZXVNSlZVRjRTR1VpV050SlJmc2htb2hhYXVpbkgv?=
 =?utf-8?B?d01yRXg0MkFkNDgwU2M1cEtPVHZsdmxFMkJZTEd6Tkh6eld6MHhtV1psMU9o?=
 =?utf-8?B?VW8wWjFSdkRrdzJ5ajZBZUVGbVZ1Tmt0K2RKeTI5OFFSWGlMUHdQUUFyUE5K?=
 =?utf-8?B?bG41Uzd4Y3QxWitvbVlHOVRHcDRrbEVlbGVsdDBzZzZjeWM2b1J4Y1pTZkwz?=
 =?utf-8?B?Q0NLeEtiMDR5WC9PdENtMVdYaVVXYkUxYmZLZThkMTBKTmRYWnZEUy83MFM5?=
 =?utf-8?B?L2Nuc09STVpqc21Gem5sL0JpZ1NJUXo1L3ArOUFld0hzL2xLZ0kvaFNtR3ZN?=
 =?utf-8?B?RWw2bWtRZVgzQ1QvcGpIT244dDBndG1KcUVwN2ErTGwrTFM3dFp2NWtRNjJK?=
 =?utf-8?B?VHBsRW1wcjFlQWpRVHRWb3RZOUdRWW9JSG56TFhDZG9BV3VpakMxR05VOGlP?=
 =?utf-8?B?UHFmTUdpeE5DcSsxeDF1eFVOTkgrRURSaEt6eWQrUm9pM3RwZzRpeFdCWWJi?=
 =?utf-8?B?dzlQUXFKV0hrdVJMTzUyVmJ3YThCTDR0ZHBTVWwyT3ZqUVdYZ2pTN3lDOUxE?=
 =?utf-8?B?aHErWXFSY1hOMDZPQXc3TlhvUnEwMFlnSGF0L1dmN2xtQlJ2SGpNaDY2L3Rm?=
 =?utf-8?B?TElBTFZjYzlRRUFZVjdCZ0wzbHBxSTZKSlZIR3g0TTVOMC9zN2xra2R0RVFY?=
 =?utf-8?B?bkNoUnoxVFk0NENxYkI2M2R1eVZ3MzBPQWJYcXhNYkJRMXJYWjgwWDhEWHF3?=
 =?utf-8?B?a0MzaTVnOTkwWmtqNjBTNUIvYkJmQjR1OVZDalYwaDlzNzlZMzZiak5DbnJX?=
 =?utf-8?B?ci8waFhjQWtTenBSbFFvRk91NGZ4VFBqb2Y5S3JJdkkzd2FjSzA3UHI5Y3Z0?=
 =?utf-8?B?WmR1WHErYm5FZDBRNUtPdUkyLzNRWFBHaExBZGg1VkhyUlRjM2tzUWFNd3JG?=
 =?utf-8?B?N0VoZllPa01GL2ZZKzBsUXdKVkZRYXhhc3hEWHg0VGhYSjU2T09EeERub0V6?=
 =?utf-8?B?dmF2MzBoR2Q4UjBDY0NOZWVyb1RCaENVMmNubWVza2o1djd4YTBNQ0haQWRV?=
 =?utf-8?B?M08vY240YVU2Nng4KzV4cmpQc0VPVnlua3dYL3JNZVFCeVNLV0l0b0lRM2w0?=
 =?utf-8?B?T3BwZFVnaDFScWNHUGFUbUxvQlh4NTRiY05WeE05eW1mRHdDNXhSM0c4UWVy?=
 =?utf-8?B?NG5lbnFVOEViUGZJRVdiRUxDekFudkxWalhqUXkrcDhOczNiNUJYemhaZ0E4?=
 =?utf-8?B?Vzl2ZTVxVTJUalN2aE9wZ0dpYlF1Y2tqMTNaSGJzcS9xWnlWcFlRNTJpdzlR?=
 =?utf-8?B?SGRIRkhVK0VoblVRZ0RUeG1tYXMyZEptUjI3TlVRampGd2NOS1NEd29pblZo?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c097c1-f2dc-42ff-b279-08de1b263ac6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:13:34.4777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIwUSk6IIdYwuCgJm2Sh9Mez8PTw6eqQpDiAqGu4CzZnR2/aZ3C7lllnCSPdjFBcZRanFuWKj+ISY+lE4nYr+JXNg2DRthP2J7SwMuGm3e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9454
X-OriginatorOrg: intel.com

Hi Christophe,

On 10/26/25 12:39 AM, Christophe JAILLET wrote:
> 'first_bit' is known to be 1, so it can be skipped when searching for the
> next 0 bit. Doing so mimics bitmap_next_set_region() and can save a few
> cycles.

This is not part of a flow where cycles matter and may thus
not be considered unless it forms part of a larger series. We could
work more on getting this ready for inclusion but please be aware that it
may not be considered. This is up to the x86 maintainers so please also
include them in your next submission (x86@kernel.org).

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

...

> ---
>  fs/resctrl/ctrlmondata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index 0d0ef54fc4de..1ff479a2dbbc 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -130,7 +130,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  	}
>  
>  	first_bit = find_first_bit(&val, cbm_len);
> -	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> +	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit + 1);
>  

It looks like cbm_ensure_valid() has the same pattern so a similar change there would
help to make the code consistent.
sidenote: Not related to this patch but looks like cbm_ensure_valid() is missing taking
arch support for sparse masks into account.

>  	/* Are non-contiguous bitmasks allowed? */
>  	if (!r->cache.arch_has_sparse_bitmasks &&

Reinette

