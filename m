Return-Path: <linux-kernel+bounces-776468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82980B2CDAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1B71C40916
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B946A3431E8;
	Tue, 19 Aug 2025 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5vvBbGP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165C341ACB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634484; cv=fail; b=KIrRKjMUnuquJuD/iOKcM0t5RJz4hmXWf7h0JTOr3ch9VAs+maIVzPnxbQEGiUNVlDwkTN+k9XWr0lR4EChzOk2FB0Fxe2AVQRtPbBCEinDs8BuvitkZgiofh3OWg1yd5uMiXyg7YcEBZAJdDDrgg5nLnOlJpeSNvc+zRB8vPL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634484; c=relaxed/simple;
	bh=u4+68TuEJyghFiD1upDCBDIOMYGliPj7Xy0EqKv+XJ8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q0dxj7zcTdvS4MYfxu2qzZfodISGGBH6iKQ9Xdy5k60+N8yQ87OXX+vDMXltW/Ry88S7WchqGEEBv35pXCIVthQftaYc9B8Tmlh7wUEI6x++YCVEo9On4fDm0c3gGU3fPxjRJ5HLLRoVZOa9LWzSCiDREMzL/IvhhIbydCx0j/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5vvBbGP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755634483; x=1787170483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u4+68TuEJyghFiD1upDCBDIOMYGliPj7Xy0EqKv+XJ8=;
  b=k5vvBbGPrTKkPa60bA/FkqE2g0+KWSxbyjWzo5r0qRBys62kMZeM53F1
   GPuuNU+BxvI2f8G5uT3Yk0dTR0G6oz72gw/suNYskPKXepAR2a9nO6aro
   3KpvPmKshNZhqutD2lGO55uV+wDNKj5C1tv9j5g9zvd9EYfYbZgf6Zty1
   KPLNEbMDj8yAdZCm5PVNL1bKbx8QT/OBu1FU/QvmDZ4o/GVbL33w3c5KI
   rb98nwTlEkmlfSWa1lfrNRkdqmULK52M3sNlnzmbZD8olJ/sZqpF4KwGO
   zbIcnhJ4hY+sFaUjDsygX4HbISR2H6k9HYX6LjWIHVct1Da4GC8IjksHB
   g==;
X-CSE-ConnectionGUID: 9CSNQ2xrT4SgYwgCvEPFZQ==
X-CSE-MsgGUID: tM9zzwrdQ72UvZhYG/xXRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68989873"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="68989873"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 13:14:41 -0700
X-CSE-ConnectionGUID: Wq31EDwkSMORiKy023J1pg==
X-CSE-MsgGUID: qYXWdVPFS6SgYR40Y6Monw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172372272"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 13:14:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 13:14:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 13:14:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 13:14:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYZVjQcD+Tex97eSPP1A7ISWXt96LdqqgCcCLOo/6UxY8rVaQwJOVi6trBFGISWyWbdn0X1Kv2RBd/4UzedMsLFpzc7oCws3QR4//1ld4f9xHBlFRhKrVo3hzO9wq+Hhvptes6qxkWAo3X1QY8bVH7cZgyQVNpE1Dg1Z6UKYJPeW65sZ+4DjeSFQhlmB6r+mDvoW74s0uyNIKJmsG+P/Cw5V2AdgvxmRa1NwjXJFub/nQj6O20nkjM5jAkymYS1dApYxeBCixDXvfbOv6A+flQBj2ddwxipSAZqjoQoLgylxWRt0+3sm0ueWA9d22Stvt7L9+GSgaOctBqRLjl8ueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tcih62KW5DWPLwBTVdBj/TnYuwMbEcgkOv56j6qiCis=;
 b=ZutgKjAkSScdmWyec5D4Pc6qZqVs/7uvyW2sS7uSz7rrjBtnSHm9GqFcz+loiTsXYAYbiEdUKk3UcNqlqkvsnCMAi+mNyAVEo6SbUoYWJ1JQH+ZSlUNo1vkVpuQ+gk04tXw3sqIUt006vWF4ddfWsNIFuSkK+1OzpetbzbQK1p8qLaprltehHHFgIhaNwm2t/1KWFRQ9sTOamonAeypTpGLijhh4ALSlWcuHLWMGEq/bCAV88ClsUU1ZWGPUl8IzvqKQZbbcMnTfvMfdHbdmwaImNxwiEPnmejV1YYOJCylsLnEUoRyMAIrVRw0UIt4wWYjV2i57qRp1gAEkKSfwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by PH0PR11MB4840.namprd11.prod.outlook.com (2603:10b6:510:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 20:14:35 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 20:14:35 +0000
Message-ID: <a5d58430-1ae7-4b7e-8275-dad09a5c8cae@intel.com>
Date: Tue, 19 Aug 2025 22:14:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Replace the deprecated DRM_* logging macros in
 gem helper files
To: Athul Raj Kollareth <krathul3152@gmail.com>, <tzimmermann@suse.de>
CC: <airlied@gmail.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel-mentees@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <simona@ffwll.ch>,
	<skhan@linuxfoundation.org>
References: <90f79bba-bee6-47ea-9881-9ae37eae42e0@intel.com>
 <20250819121517.46998-2-krathul3152@gmail.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20250819121517.46998-2-krathul3152@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::22) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|PH0PR11MB4840:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e6573d-67cd-4c36-6f17-08dddf5d0446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG1lUk92c1U3SmVWSUZocmZyQ1czYVlWMjdXUldmNk9HMjM3ZUFFTXBOVWpt?=
 =?utf-8?B?ZE1oY1lqYmloSzNUZ002c1p5OW5hUnFrTUNUZDZzWTZpSFZZNkM4VXFFMVNu?=
 =?utf-8?B?RFpROElibENTSXRkZmVLT1hvOWdoQkVjQS9iYS9ETncvVE0wc3hzdGVsUWNm?=
 =?utf-8?B?MkUxNDE0THZFQkVscG4zOW42RVVoVUJyS3doR3Ava2tQRnZYM0U3d0dwRmlx?=
 =?utf-8?B?MXJDWDVrOGd1N1hnd1RxbHVoT1ZaU0lKQXRZZ09CSmJJYXNtRTFVME9vS05I?=
 =?utf-8?B?RnRZQWMzTnpTMlJoSjdIM2pjYWVjL3dvZ010djVTQldLTmYzQzZmS1lURWdI?=
 =?utf-8?B?SE9nM1djN2E1em0yUndXSDFQd3h2Mzg1OUUwbDVuK01rUityQnBYV25rM2FW?=
 =?utf-8?B?MjhhbGFBM1VsclU3OGhyaEJ2RWlTOVBabEVFZnlibDl3dHhzeVc2ZU1DM1Fu?=
 =?utf-8?B?RTMwWGRSRnNhY2pXaWh3WFVLR0FqRFJhK2ZwYTdWVzNLUmYzSU9UMVFPT0s1?=
 =?utf-8?B?bEZPWW9HYVpBSE5aSlBjeXVtb2hTOVNSamFac1QwdkJQMjZGU1Z6ekxLTXJO?=
 =?utf-8?B?bDhEdzhLQmN0bFNadVQ4Wk9YcUhxRk1pMDdqOWFES3c4dkJ5eU4rK24rTGxn?=
 =?utf-8?B?djBrZlJlclpzV0tBZkZTQU13NTZsVzRDRGdZRk84d1FxNkpPZTJIUnZqTWhn?=
 =?utf-8?B?bUMrR2JWV3RWTERMdnlEeDNzelhXbEN5S3BxeWo0RzRNVjJ1MjFLVjFnTlVi?=
 =?utf-8?B?SXZKa0daVTdDc0tGWjN3ZDhtOFJudTdLSkE4VlI3ZnJDY3lQYUN1cnR2OTdJ?=
 =?utf-8?B?YU9NNmZpNk9qTVhKaXpkdDcyUVJCWkJUS0ZFbjU5dUtQeENxV2VoK002L2lH?=
 =?utf-8?B?dWYwb2I0Rk9BQXNvVlU1aGhiWC9wVmJ1dHpnUEJWZUhnY1RDM0VteGg4Njdo?=
 =?utf-8?B?T2wyL2psOUc5UzRXWmtnSExWU1ExUFh5S1Z1QkI5SE1QbDAyR0pncjhGcjl5?=
 =?utf-8?B?b3FSUEZpMzRiZDJoOXB1WTBpazYzU25NMzJUVGRHSndubG5hRUI0UnQ3eEN4?=
 =?utf-8?B?dzJ3b3NKcG43NDk4RXJlZkZCNXl4SU90T1NMWVU5M1RGbkN5NmRBdDJWNVJN?=
 =?utf-8?B?eTBtVE9jS1djallRa0k3NmVyemcvNEFRTjNRNnQzM1ZIRTVaWXVCd2hFdi9Y?=
 =?utf-8?B?V1VnYWNqUkZKYXVEeEt5c1B5OS9aakNIZnQreWRHT2xkOE1ZT3FhTlFwRWFk?=
 =?utf-8?B?QStmVm1iVVprQUx4OWdXbVhSYkVHbnRrcUZRQkh5SnBrdDJud3l4RzFIVzNv?=
 =?utf-8?B?eUtMN3lqMlBHZXdBM29zVU52RVUxT3JFS1h1ZHUvN01RdUJOTHVmdlpYVGtE?=
 =?utf-8?B?QzU2enFoRzZHNUhKd2YzZFdJSkRkemhPUlIwazFQcDJsb2VhTlVQWXlzVGpm?=
 =?utf-8?B?UllQTjE4RjE2Z0tTZy81b3dncVZVUzdKczBxdTlnbFNFMkZWUnhlWDd0R2p6?=
 =?utf-8?B?Q2M4TGtrUUFTTEhVZ090N2kwUzJ1QXQ2MXY1Q1hVQWFEeUhWcnNOdkM3LzBp?=
 =?utf-8?B?SC94Ry8zR3J2c1kwUXhPYmZMTTU3Qjd6TkVkQXpGcWJBTE1sK2xCQnI0WGxK?=
 =?utf-8?B?eFNPSzN2MjNPU3Exbmt1ZzFmK0Z5b2grWTlvTjY1NEJvYkJvVy9xOTlVSTR0?=
 =?utf-8?B?VkFCcGRkNzlBbFpzOTNKQk9hb0I1SGJUNzc4cDdqVEFVQmxSZzIwajhoQXM1?=
 =?utf-8?B?d2hvUzNvd2xINHJDUG5ON0dIL1N3WDlkZHlsOHp4akRRRlpuQ20rWUhzRlAx?=
 =?utf-8?Q?OXt1ccbDBQMP5dSSic1LAjH8PlYd3MfEv4ghM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6011.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEFrWHVjc3NaSkNMVnJnbmxZMkR0eDIzNWt3cVNLaHJVVE85TTVONGxsVXZI?=
 =?utf-8?B?MWJYaDNWN0dlOHhkVkgzUTdCcVRrWElDcGJXbEV2M3F5Y0xCaW9NTytac2dJ?=
 =?utf-8?B?aTlDeFRsSFJBWjRjUHdaWU5VcDF0QUZvbUFRMUZUYks1UnFkSCtNUDk3b0li?=
 =?utf-8?B?cE1FMGJNSE5hM1kxdU9MNTE0YzRkRjRpaHowdzlXUTg5QS91bWV6S0g4NVBm?=
 =?utf-8?B?cGZwREx6UXFYRDV2aDJESk5jUmQyeE9LcGhNV1hCdFZkOUtsemtLV0pGYUhn?=
 =?utf-8?B?OGZoa2RxR2JQSmRlNzMwcU1OMkFIWFhQK1FiWVZsWDNmSC95Z2I3Z3RyVGFM?=
 =?utf-8?B?cXpLMlVjU2ZqcDlKc1BYRDc2OUJZUngxdWJuTW8zSVhnaGtOMGIxcEpBK0dr?=
 =?utf-8?B?b3RhOVdJUnFEd2dIeG9TdDFleGlpL1Job2JIR3M5OFNES2RqRlUwR00raTUx?=
 =?utf-8?B?Ymt2dnNlTi9wWlZkQ1AvUlNCYjR3NTYrVUc0K1poemJ5RzJRLzNUT2tneU16?=
 =?utf-8?B?NmpQZGF1MUpmWXZTbWpHcmVZOUNuejBBdTh3Tkw4L1JrSkk5T21Rck41YUUy?=
 =?utf-8?B?TXZFVE9QenJ5U2w5aEZwTXJrVk5NNWxFQVNDK1plTktJQmFWcmk3WGgxT0R2?=
 =?utf-8?B?ZkJHaVpEN2YrbWtlVmRkWjhCMFl3aTk2QmduMkZuWmZtbWtGSVdyWGVjckdL?=
 =?utf-8?B?TGlJdEUzd1dMd3pLMmZQMkVxV3NXbXZ0SHFrYzRKRWRBQnNhQVErM0htanBW?=
 =?utf-8?B?Q0tock9GTWV6ZldrUDNZVWRxbXhyZkZ0WGJiZDZuRUoyVzJnSDYzMEN3SGdY?=
 =?utf-8?B?RldCdDc2c2Z3YmUvRmNUVmpRUUZzemI4U3E5VFd1SXVxbXY3QnNnT2w5L0J1?=
 =?utf-8?B?R2NnVFVrZ2dONWQ2RlhiWDIzY2tWU1JkbnVMNEZQdWkxclBuT1JlUnlScVFs?=
 =?utf-8?B?WTdwRy9XYjY3Ky9jZFl2azUyQlU0d3p0cE9nMmhSOTV0UTNjMENyUTJXSFkw?=
 =?utf-8?B?aTN3WjV2MS9KZUdtMFhmWENFY0xIL1RxL2ZEOGdHNlFqaFVmSHFSZVR6UEhk?=
 =?utf-8?B?U3VBYStnOTFRSkRDcmZ5dzU0WHpXNnJoVW1MZUNnV0RWV2xWVkNhbHIvSXNk?=
 =?utf-8?B?Nlowbk5lYzJxNGdVOWNoYmVEdDgzdW5aWXRGcFQvQjVJVW94d1c4TVR6MHFw?=
 =?utf-8?B?RHg0djFES0x0bHkwelZCNythQXJWSGtwSnkrTlpEK2Nwb3AvcGpBa1IvYnZq?=
 =?utf-8?B?bXdNV3lmYlJQNk1ZbjJycENNVWVxUzBMc3ZMZlljellJTDRxS2NxUC9JSXkv?=
 =?utf-8?B?NVViTjFPbmpUK0dWYlFqZWRnSkxrWnhjdXhVbzZlWTlmMUFiYTBjZnY1SWZ0?=
 =?utf-8?B?ck5uTTdmTEU2UW5XOG9pVHl1dkhsU0NoQzZ3eEFOM3IvczhORnppdmx1VWFH?=
 =?utf-8?B?Zy9KRktQWDRDTCtHUFozNDh3S2srNTNpSVI5NU5GSmd4allFbTFDeFNwQVNM?=
 =?utf-8?B?RU8rcHErY3dXYVY0U3NtRHluZEoyREE0a2xCWE5IZ3MvYnpRUDhIckNJakEw?=
 =?utf-8?B?bmQ0NlFuakEzUlZYTkhhYWxaQmxveTVtd2NJeDYwcnZveFczdUVsUXVPZGl6?=
 =?utf-8?B?TmpXVVk1Zmc3M29FcmZFbGhXdGhxR2xCWUlwK2tSNXdEaXQ4Z0taeGxWeU1F?=
 =?utf-8?B?SVczV0dqdmZ4dXp2YlhjeXVYZ1hGRTNjdHFzamNlQ1ZEUlVlVFhVQVRqTGpu?=
 =?utf-8?B?NHhhRFhLSGVzOEZteklkVldZQTZPSjRGMlVXOHZ0WkpsdVlURFBScWlZUkFl?=
 =?utf-8?B?U2czZVlzc3gvWFVaOCswbEFIajJKaWIyWWUwMkJQcnBCZFNDVXppUlhvVGYv?=
 =?utf-8?B?SU1iL2V2dHhnYlZIbDVvWFVRWXgyT1h5Y25sNTBkblRhL0hGeHJab2dTc3pn?=
 =?utf-8?B?T2plbTlXV1VuNGFZWnpwakV6cVpFS0JheEZFVWFxZkw0K1J1MS9XaldnblFS?=
 =?utf-8?B?UzRvbm1QZ0ZqdC93WGpyZEwxK3RnOG5oM2h1Y1B0VGtXUW5SRHlGOVBLeUth?=
 =?utf-8?B?cnIxZWFDR0hiNHEzNUcrSWdDZ2tVeFdpZCt2aStlNC9Kc0Nja1ZNdmwxVzRT?=
 =?utf-8?B?MzRGOUx0ZzZnLzlqcFZqdk9PcDZNc2djUTVUMXBKNWt4NDZWUkhwd3V6MVZk?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e6573d-67cd-4c36-6f17-08dddf5d0446
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:14:35.4667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpwPiZlEIL5Xxv2N0eVIvAyjOzA18hg66Os9Nb8/mKk7BFfHu6EbZcxERS/5kTcvEW3yunBYXPLuU1guegVDfgcrTOhacc4sQi+QQA/JrTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4840
X-OriginatorOrg: intel.com



On 8/19/2025 2:11 PM, Athul Raj Kollareth wrote:
> Replace the DRM_* logging macros used in gem helper files with the appropriate
> ones specified in /include/drm/drm_print.h.
> 
> Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
> ---
> Changes in v3:
>     - Revert all changes to drm_gem_objects_lookup()
>     - Use drm_device as suggested in [1]. 
> Changes in v2:
>     - Change drm_gem_objects_lookup() to take a drm_device* argument.
>     - Make appropriate changes to all calls of drm_gem_objects_lookup().
> 
> [1]
> https://lore.kernel.org/dri-devel/90f79bba-bee6-47ea-9881-9ae37eae42e0@intel.com
> ---
>  drivers/gpu/drm/drm_gem.c            | 10 +++++++---
>  drivers/gpu/drm/drm_gem_dma_helper.c |  2 +-
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 4a89b6acb6af..fbea8c50f17c 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -102,7 +102,7 @@ drm_gem_init(struct drm_device *dev)
>  	vma_offset_manager = drmm_kzalloc(dev, sizeof(*vma_offset_manager),
>  					  GFP_KERNEL);
>  	if (!vma_offset_manager) {
> -		DRM_ERROR("out of memory\n");
> +		drm_err(dev, "out of memory\n");

IIRC we shouldn't additionally report OOM errors as there will be
already lot of messages when we hit this

>  		return -ENOMEM;
>  	}
>  
> @@ -787,6 +787,8 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>  	u32 *handles;
>  	struct drm_gem_object **objs;
>  

remove extra line and please run checkpatch.pl as it should catch that

also consider declaring variables in reverse-xmas-tree order

> +	struct drm_device *dev = filp->minor->dev;
> +
>  	if (!count)
>  		return 0;
>  
> @@ -805,7 +807,7 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>  
>  	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
>  		ret = -EFAULT;
> -		DRM_DEBUG("Failed to copy in GEM handles\n");
> +		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
>  		goto out;
>  	}
>  
> @@ -856,9 +858,11 @@ long drm_gem_dma_resv_wait(struct drm_file *filep, u32 handle,
>  	long ret;
>  	struct drm_gem_object *obj;
>  

ditto

> +	struct drm_device *dev = filep->minor->dev;
> +
>  	obj = drm_gem_object_lookup(filep, handle);
>  	if (!obj) {
> -		DRM_DEBUG("Failed to look up GEM BO %d\n", handle);
> +		drm_dbg_core(dev, "Failed to look up GEM BO %d\n", handle);
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
> index 4f0320df858f..a507cf517015 100644
> --- a/drivers/gpu/drm/drm_gem_dma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_dma_helper.c
> @@ -582,7 +582,7 @@ drm_gem_dma_prime_import_sg_table_vmap(struct drm_device *dev,
>  
>  	ret = dma_buf_vmap_unlocked(attach->dmabuf, &map);
>  	if (ret) {
> -		DRM_ERROR("Failed to vmap PRIME buffer\n");
> +		drm_err(dev, "Failed to vmap PRIME buffer\n");
>  		return ERR_PTR(ret);
>  	}
>  


