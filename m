Return-Path: <linux-kernel+bounces-796903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D714FB40910
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB5016B928
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91348312830;
	Tue,  2 Sep 2025 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hq8Jxpuz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69625EFBF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827420; cv=fail; b=KGeScC2vRkQRaYR2fCBt2oEcgHwKAk1ZLqbCID23Imx9R8IoyZpaKgdHHDiSyXy648FyEdu0oc/AExHWqo++pm6r/48oDAlo/ImFSIc5H0kahOT2NgM/QMSzz9HDSdPSqrvDMXZe8pbX9+sF+sUbQMVd5Lzs06mpmeCEzVRMFFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827420; c=relaxed/simple;
	bh=2MXw8hjQu2hlIom9SM9oLL6PTuxI2hfgiLkpHSengJk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nO2D/J49CTVYmPkq1HWZJPKglH9gNvQdxZsUOloRMFzi2neSvM2gzqrDRzfD0YCPwOKkml0SMy7dgh4wBfzrR/9R9NCIvqLqbQYKrH/9cAc4ZgY+zqy0KG2Fu9nU5ma7+YoS+YMxm6QPCvwNFRwdkZsBn0uFf23NBiwF7NHknKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hq8Jxpuz; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756827420; x=1788363420;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2MXw8hjQu2hlIom9SM9oLL6PTuxI2hfgiLkpHSengJk=;
  b=hq8Jxpuz/BNofiPSNvQiSYDJjzogGar2GnuZBxTZZSjpKuljgAsP1aCk
   OsibmX4zMS2iZGbCplG4kh0ecNGtCsGST/gtzCAk4gU5jBnDMyvgcgJ5s
   0iHHXsudIq4D+2mmYxegzEhHrr8fjH7RgnQPbWSf6wJThR3W+xjNngdjD
   VQG8zvmx4WAczlKy2do7AMoO1Kn/xXrKa0z7wKLrg9PMVyivCafoaGnz9
   OViE4arboTQ6aYvSAoM5FEWbhyt1JRt8Z7b16f89V7zLjeLyZsVO8YcUU
   FGba0dzYKdzi9tcRJWwCZOnG5gVqJlHyDltZJND2U6oBJXjhyqlAInSih
   w==;
X-CSE-ConnectionGUID: pEPiWjJbSV63BypyWXknaw==
X-CSE-MsgGUID: 4aV9MMnLTq+FrO5FUxAhiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59178859"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59178859"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:35:57 -0700
X-CSE-ConnectionGUID: MoR4FdZ6QZ+qOFC19oRyAQ==
X-CSE-MsgGUID: kJD3h86mRcKXHNldPowApA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171461268"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:35:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 08:35:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 08:35:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.88)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 08:35:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rK9xPaZIxnsf08wLcKTg6csFzzf87ts9/NCPxjykpsbxTk6tpW6tEwUl7wUtVK33KIvb9RUwHYaP5+4YrnUR4orlzBdcwvoT6Oc006ZWijEQ59uD8jRDVd5zhA02C074FMqPBlojvb2PcVzn3g2M8Cr9i6lhgACbqIFF8gHzf5bz7kJtsY4HLn5GgZQh0GgSQ6e48bJO9pH5kGt6lEm8Xb1tdPsNLw71sbUj7CdLi8J1K9IikIuuRAQskY/ZrRgSegFyHGYQuDXscIbOUQa5o+NEcmPXwH6UuOKkylamii0m4VVF+Y2KLtBdchAHXFN3ZmCteYA/Ksi9W7F/CzGorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwO8aGnveMto+Am/4L+mi5lMzbmhN8w91Qas2UWbFkY=;
 b=lKhYpI8YEWFA85JpnsA2fj2wW1xOLlCm+vKfmWhW8KHCtO3RjhK/m/YWGsbuz+WSkzUon4zBJQ6l4Z3+nNOjD4lmvdJzHwYkgN0owzugePXCAgykDzzHkrfeeH9uhrk2fYpxAtnEhQP1i4L+rZrum9T1Ufkzb/UlQChV2B5eHMlCsvIE1Cik+ilOTzx+chYW//9q7/xgy7V2+N5LWTp7uPV3558hi1DHfZDUeo5SP4NZzGC8ya2KBMsxDBfD18/0e97207Fc+TXp8oonKCgFlqOES1fz0bjNOmpyhqUf0xQEpR/KJWOa3TyHNcPEvBRzOJDdgZPQAlCRVNMFi1X3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by SA1PR11MB6920.namprd11.prod.outlook.com (2603:10b6:806:2bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 15:35:54 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:35:54 +0000
Message-ID: <6a5cc1e0-ea0a-4d7f-8834-20a371346d79@intel.com>
Date: Tue, 2 Sep 2025 17:35:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND] drm: Replace the deprecated DRM_* logging
 macros in gem helper files
To: <20250816152604.14667-1-krathul3152@gmail.com>, <tzimmermann@suse.de>
CC: <skhan@linuxfoundation.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel-mentees@lists.linux.dev>, <krathul3152@gmail.com>,
	<linux-kernel@vger.kernel.org>, <simona@ffwll.ch>, <mripard@kernel.org>
References: <aLcGnf_wrY5QuZZC@Terra>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <aLcGnf_wrY5QuZZC@Terra>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0303.eurprd07.prod.outlook.com
 (2603:10a6:800:130::31) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|SA1PR11MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: b35c0bc1-b210-4bfb-c0d6-08ddea36676d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUZiczRMWlBnZFVNQVNSVzNFdDlRL2p2KzN6N253SUp4ak96d2ZTcEltSjRI?=
 =?utf-8?B?WUNjNCtTZ0lyVmg4M0hUT2R0TkdpSGs4OXFzeWdTM0FwRHY1cDJsQXZ2RFh3?=
 =?utf-8?B?L0w5Z2hqK25PMEtkbktkK3B4S0lOYmMvdUttQnRGU080UGNIUUZDTXNkQzNR?=
 =?utf-8?B?YjlpbVRIaEdENG5hQXZjeFlUMlNSNGVzeWtWRDd3cm5ZQUhjN0huREJTbmt5?=
 =?utf-8?B?OU52bXJsb2hrWnJmcG9ZQmEwaWhYSUdabkFQaEkxN3JZNzZaWWRIdmhkbVJ2?=
 =?utf-8?B?SlJtVUJoaEZZNVMxak0vN1pQUjNBTnNoeVFscElKbFpua0JHMFd1NnYxM2k3?=
 =?utf-8?B?a3R6OVduMFFDU2gvaDdQZHc2RWc3NnBTdEdkYjRXc2IwL0pSSE15T0MzRkpS?=
 =?utf-8?B?TjFFYkZ2bmQyaWpTSllLNktkditSVXl3YmFZd2tMS1U3TE5JWVlpR3VlSjJp?=
 =?utf-8?B?QjFoZ25lUklicEVLbnZiOTFzV2tXWGExRVQ1dEVlZFJTVk9ENE9zRDIxRHVa?=
 =?utf-8?B?TDFLLzJRWVltZ1NaakpUaTNKZWFUSVhZdHYrM05xWHlweURRSlRWQ3Q4Y0tK?=
 =?utf-8?B?NENydWdoTUcydFo0eHNzS2dGRFNhai9oYllFMWlDU2NzRDkzbXpsZEhJOWFT?=
 =?utf-8?B?b01Xb0pacjEzRnpzbmtSSHF3Vk5WYUxVNmRvNzJPUVYyYi9zbG5CQnhTdisw?=
 =?utf-8?B?NmtwTm81K2lyZ0lJS1dBWHlEdSt6M2VGQSs2VFM1TU52bkNlYS85TGpod0Uz?=
 =?utf-8?B?MnBzYU1jM25pWUw5QWc1TFpmTVhVUGdaU0psVzFhN3J5aDd1TzE0UDVWVFVZ?=
 =?utf-8?B?TjdJREkvU1UyWktOZUw1bmt2cXpOSXhPeGFXc1FaUlJBSkwzWS9US1p5cXc3?=
 =?utf-8?B?ekQzYm1GaXJvM0xZK3lpa3FJd1N2RVg1Y2hpZlpLNXRYWjYxQ1dFeHhHUHpq?=
 =?utf-8?B?djVWanY2RktqbFBaK0h6YjdvclBzak9ra2Z3a2N0VTVrVGJCajlnbW1FeENZ?=
 =?utf-8?B?d28wSjEwZ054RGlzdjUrQk5IaHBlazdnNmdkSi9CT3E4aTBKMXdOdDZvTWRx?=
 =?utf-8?B?b2tPWnRwT0RHNUJDTHdNZUQ1TytXWGpIOGJMTU9seHhZbzFZc0xUUTd3aFF2?=
 =?utf-8?B?QmZzTWlORmU5MDRqbXN3Z2hHOFRpMlhYQzR1WUlGVXhHTWVhUnN2bHhGQ0ZX?=
 =?utf-8?B?cHQ3NTJNMTJha3lQd2xJc1A4QkhxVUhVVHU2ZEVHMGVnRXMwNlFDL244VXZv?=
 =?utf-8?B?MERpUHg0V1ZMeUhKd2FzQStMV3hvQ3VaVlN4ellSNTI0WG9WZWp0Z213Nkwr?=
 =?utf-8?B?dmIrczdIdTNIeFlUTkRTcGJwTEpxM2tRU2Q3amxwYkUyZ3Y0dGNWSmpGVFJa?=
 =?utf-8?B?bWEyRk1DR29wQmFVUjEvTE5nNjA5YytnSGNEUjhSL01qL1VZenU2eDlXZ2NN?=
 =?utf-8?B?OFdmaVkvM29CVzFTeHo0TDZBVUd5NTFaYlJRR3Y0dUJlMlBSMTN2eEIzeGt6?=
 =?utf-8?B?UnBvdHNhMGhyNG00RUNJbDIrejluMTlkajk5V2xmUzJBUXNQcW1qLzgxVmti?=
 =?utf-8?B?bGdjcFFmSnZWc0VZTGRZam9jdEQ5ck5jbVF3bjhudXZkS2Ftc2NaUUE1bmNw?=
 =?utf-8?B?anpyL3AzUVpESGM5cHhwcTYxclB4Q1hUUmNpaGZnZ0h4VkVwYnRVZ2QzODQ5?=
 =?utf-8?B?ZWRFVDFocHhYN2c5NmV1dFNHQ2xIMnVPelZhWFBTM1Y3aFpqRnhSWG56QkNO?=
 =?utf-8?B?Zk1qUEdtR2h4WGRMbWVTV3pQdzFxZ3VvMEpwQ25JK1NkVFRXaDUrOTJYZXpR?=
 =?utf-8?B?Tmt2Y1kvMUpNUWYyRlpRV0F4UEd0TUVXaExPL1pvUTNrZzRHMUMzVWo3ZWU3?=
 =?utf-8?B?L0c1YUFWRDI2VFEzOUtJZDJjU2M0UlZ1VElPUC9hZTRsUEFPUDZzNHJJNUJP?=
 =?utf-8?Q?6EWaD37LTVo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6011.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjdiZ3Q2aysvT21ndXQ4dmx1K0FVMXpNSGxXNGNJNzQ0NzJPSjkxbXVKcDFY?=
 =?utf-8?B?MTJQRWNNcUl6NkhtQ0NNMk1VZ2FWMUxYUlpEc1Y2VWtQT3M5ams2NTZsZUJt?=
 =?utf-8?B?d0d3emxOOUE0T2FFb1RXTjlrbjM3dXpwSzZBdjdrWDJIYmlVN3pRUEdmSElq?=
 =?utf-8?B?S0NjdUJPaEdGanZUVkVjMkFLb3ZOV09YeDltQURjcktLYkprdG1EcGNuTVBZ?=
 =?utf-8?B?UG9BblN0NWRrd3hzTkEyWHdPMkNwQWJIRnRTVWtjZk9uRzFqZk5QOUJjd3Fa?=
 =?utf-8?B?L1RqanFTMXY4ZkxSU2d2L1MvMDA0Sy81Wm9pd004Yk84bmpwMm1YcXBXbG1Z?=
 =?utf-8?B?V1VHMG1LV2NyTzJXSC9YTVIrNC90Vnc3NnlZd3B3aGRaVytXNE1xK3YyODg3?=
 =?utf-8?B?MnZMN2dkRWk5NWF4L0ptRnIyTWluTkVjTVNodWFYS3hNb0Jock4wUWd6Qmd0?=
 =?utf-8?B?Tlk0OTFWWGZmQ2dUNWh4VnQxVUx5Rm5DSlBTUklGSmgyQVBnb09rR253NmVT?=
 =?utf-8?B?ZEN1NHE3R05TZkkvclA3OEJJR3QySjQ2dkUzU0hKcVltdG1GTUhYNFhyVFBq?=
 =?utf-8?B?UzN4ZnFoU3JLcnNWMXZ5YjNFZVZ2OWtDblYwSGE5eXFhMEJScnB5SmxvLzVT?=
 =?utf-8?B?QjE2R2ZpSHQrdGk1bzYxMGVHUDFTcDJQdkVpQjV2eVlpTHlMWm85aXBhQ05w?=
 =?utf-8?B?YThBd0lIb1l1bkVSMTM5R0Z4R1M1VnpxMm5DUWM4K0xmR3dMMUJlOFVmdlBh?=
 =?utf-8?B?WFdtdnZ5YWtzREEwTEU5d29SVmhEMmJKUGtXWUpUL0s3K0pacVJmMnJ4UkVP?=
 =?utf-8?B?VlhjSjVPV0tscitjcDdnUFRRK3lPYkVQbXVlbkRBT0tQSithYVRLaGluQ1RS?=
 =?utf-8?B?K2JGdW9vbkQrWTd0TS9xUVRMamVLSExDZnZlSlV1YnZUZmVzU3JsMFo2d2hI?=
 =?utf-8?B?bnRmYXFsR0ZVTU9TOGgxKzBxREVsamtjMVNTYUVvaHBjeFVLZ2UvWEVIa0RI?=
 =?utf-8?B?Tnd0bUcrb1JUUS9LY09SNStmRVZ6MUd0dWlmUHIyZkdmSDAwMkdvd3pNQTc3?=
 =?utf-8?B?ckVwYXlIRUt5MTlFTmJJbmZZUytyNm1FRHVvQm0rREFQK2pDMHdEWmE1ZnNr?=
 =?utf-8?B?d21vREhjOVRtVEZVaHZsSDBycGo4QjVOYkNIeTFNYkpqbzE0UGpZUDIxWmhY?=
 =?utf-8?B?K25aWHFjdGtNQTdhSWlxWDhtSjVkMmMzZVJFWlpWdStOYXI5Z1d1NFdlQ2ZE?=
 =?utf-8?B?YlZINlNQNTd6azdYd282ODcvWmF4c0hnbHZManpvT1lieDArZ0s2Q0FXUEZm?=
 =?utf-8?B?Y0g2WjVpMVljSDB1Z1oxRWE3ejVjSEdhQ2FRUzBjUE9sdE01NWVlcXBpTEJ2?=
 =?utf-8?B?TXZ4YlNEcElURms5RDR5WXZNRTF4WHBNL1VyMmlidFd1ait0MFcxV0RCZyts?=
 =?utf-8?B?T0pzQk9GVTNGVlIydHZVNll2UldnSkRnY3QyRmN4dUNaNk83SVpTQ1o1RURt?=
 =?utf-8?B?VktLN1N4clJLejdCZ1FuR0g0dkZMK203WmpnWWVKUmp6Q3czc3NWUjN3cWtI?=
 =?utf-8?B?ZEw5S2Y1K1gvWXRSSjNQQVg5UG9nTlZGVkJ2N1luZDR2by9LS3NqOTZjaEJG?=
 =?utf-8?B?Y0RqOUhOYlArcC9jK2lOV3QyNVllWXNLaTNFSjFJbFRISHoyMi9XS2k4c3lH?=
 =?utf-8?B?ckRwWXp5TnZNN3RsbUVFNnFDZmxublZMWVBXa0VUS2dLWmIrRm5jRTFZOC9X?=
 =?utf-8?B?V2Y0aFJiSmU1KzBJamNkd2J0bEpMZnc2MXdXZ2Nud3Z2Y3dyTXlLN2F1MVJL?=
 =?utf-8?B?SnZJTTkwNGlBTUx6dFREM0tnWDl3VzhHOVJ2YzBFTlRWKzlYU2Y1M1FZZ1NL?=
 =?utf-8?B?aE05M2xFLzNOMlkvdTF6TkZVL3JnT0NTV0NnYkZIZnF2NWRaSGp5VGQwL0ZG?=
 =?utf-8?B?eGxka3UrcXJEQ2k5Y2psT21hNGZTMzIweGVua1cyRHVtclJGbkZxaVdkc1ZM?=
 =?utf-8?B?NnNMSDV5VnBENUNVeEhDd0N3Y3ZXTkRkS01nVU50TWNhMzB6eVQrNjU5eHFj?=
 =?utf-8?B?T0pRKzZYREliOWdobkRDOEREZm9HZDlwSG4wMHVSRWJvVTY4cUlVeGxsZzVQ?=
 =?utf-8?B?TmcvT3NvcXFZMVNHNUJPUmdOSFFnYVZXcGRUanc3c3NQSlJxNGN6bzJhN2RY?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b35c0bc1-b210-4bfb-c0d6-08ddea36676d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:35:54.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wp2YdCjtmlJwKENRoQro1kIHqpfg/Eoc6FnOxAfRWb1YAqkjgxzw4hY+9Ye+fqMI6juZ0uAMbPih3WueQxi+XhZxZJVGqLvuRMOjMTn2IBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6920
X-OriginatorOrg: intel.com



On 9/2/2025 5:00 PM, Athul Raj Kollareth wrote:
> Replace the DRM_* logging macros used in gem helper files with the
> appropriate ones specified in /include/drm/drm_print.h.
> 
> Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
> ---
> Changes in v4:
>     - Some codestyle corrections.
>     - Remove OOM error logging in drm_gem_init().
> 
> Changes in v3:
>     - Revert all changes to drm_gem_objects_lookup().
>     - Use drm_device from minor.
> 
> Changes in v2:
>     - Change drm_gem_objects_lookup() to take a drm_device* argument.
>     - Make appropriate changes to all calls of drm_gem_objects_lookup().
> ---
>  drivers/gpu/drm/drm_gem.c            | 13 +++++++------
>  drivers/gpu/drm/drm_gem_dma_helper.c |  2 +-
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 4a89b6acb6af..dc3d6cfa692b 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -102,7 +102,6 @@ drm_gem_init(struct drm_device *dev)
>  	vma_offset_manager = drmm_kzalloc(dev, sizeof(*vma_offset_manager),
>  					  GFP_KERNEL);
>  	if (!vma_offset_manager) {
> -		DRM_ERROR("out of memory\n");
>  		return -ENOMEM;
>  	}

nit: you can now remove { }, didn't checkpatch.pl complain?

>  
> @@ -783,9 +782,10 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>  int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>  			   int count, struct drm_gem_object ***objs_out)
>  {
> -	int ret;
> -	u32 *handles;
> +	struct drm_device *dev = filp->minor->dev;
>  	struct drm_gem_object **objs;
> +	u32 *handles;
> +	int ret;
>  
>  	if (!count)
>  		return 0;
> @@ -805,7 +805,7 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>  
>  	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
>  		ret = -EFAULT;
> -		DRM_DEBUG("Failed to copy in GEM handles\n");
> +		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
>  		goto out;
>  	}
>  
> @@ -853,12 +853,13 @@ EXPORT_SYMBOL(drm_gem_object_lookup);
>  long drm_gem_dma_resv_wait(struct drm_file *filep, u32 handle,
>  				    bool wait_all, unsigned long timeout)
>  {
> -	long ret;
> +	struct drm_device *dev = filep->minor->dev;
>  	struct drm_gem_object *obj;
> +	long ret;
>  
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

otherwise LGTM, so with nit fixed:

	Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

but you still need someone else to merge it


