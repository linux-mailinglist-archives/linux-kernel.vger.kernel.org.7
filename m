Return-Path: <linux-kernel+bounces-858362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A06BEAC53
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A41962EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93829225788;
	Fri, 17 Oct 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsTC6g5Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C8322C88;
	Fri, 17 Oct 2025 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716809; cv=fail; b=FxVH2r0zre8Y0CiYZiwdWxEoqIeAOcX5Cj+T6cYUvbFAMmTXzDVlVdNZntg1TCjVFRufHzLRUvCFfLZ1U84Hy0n/bMxz36uN3zXf3yxNSXJoWnoWud0o3tYFI4mzuai0cTUgS9pKufJ9/fUPGg0eRJVSr93NI6tQMBewoI5HPVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716809; c=relaxed/simple;
	bh=gPyvXQqIjRoS496GtsY3XljTuOn+MkICwnPOy5r0RU0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wlht043hqTYBmyxrnFY0QYwFb/HAQHm3X3lEMPhmg78c1AsAwR4LOuUXDan6RDs+7byf0kANwaJy634zWaJ0GalYACENUsyLJYub0GczMOUFFtLMMsyhyuCDaab41jogD4AGK5Q8ts8XtL0LSDCYNYF65hFExxgp60iR91PSon4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsTC6g5Q; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760716807; x=1792252807;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gPyvXQqIjRoS496GtsY3XljTuOn+MkICwnPOy5r0RU0=;
  b=OsTC6g5Q26bZts2xi8BFZpjBTbmRHFY8bzR/L3cBo2YtxF5ufCnSkekL
   A2P92IPH6HUmXoOkHYI5VJG+GfcKYzhhThX8WGhvRhOYrml1SPoJviCmu
   Nh3YJnSwDC55FINvskGHe9PpH2fB1kxmRm8ZYvSg5qsWVf5u0v2d2O9x3
   ms5HB/Y7JuqjQrLo35oGZUX8hC5Nu4+TJhALuSjMsJdocETNmU/ta50Wr
   FxebVopyKo3Lj7Zr29w1IbQm+Avci+2vndAZPCk5+EO87XpTzzeQHykK+
   9wWN7K+qcuDlvPzong2HMJJVtKy4gRmSr6UKl90i2CizgL7OKYpVe8Pw0
   w==;
X-CSE-ConnectionGUID: MWwkIl3+TgSVtL6vm6KcZQ==
X-CSE-MsgGUID: khBFPUTqTG+cwQGuKirmiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="73215346"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="73215346"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 08:59:52 -0700
X-CSE-ConnectionGUID: jOBCkznrS5eUdCo8mEtVmw==
X-CSE-MsgGUID: 8O2UO0HqT1G67vJ6p/DkLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182318001"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 08:59:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 08:59:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 08:59:50 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 08:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+zT30T5RcJ0sBWjT3Md2yP6APIjLz/2snfRylfacdMsBqmixHeqz46cyKib3ZwPTwJHL3EvxhavqGO6fqnZQ4HLbIvR7fwfQkF+OQIejEWBzl6VwXaFEIMUWdQ0NU+8GvIhA6i+nG92b1SMAO3cyce4UEkgYcBheUolu4NM0f3pJpeaQa3mXKyCBTJ6OEyaSqvv+NrKc5t2MS8G2xtKMrY6o9/uqDZHX01113WByL3p3Pi8Rt3LtuSEDnsA07m0MqR59hI46S7vptU6ZqKXi09p8iZD2ZL4gFy1EiP8t7KholvpaXp85oEPoTqV/zYQzBwe0WYvdkEGXc9mnfTHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IafmSdSQvW5aHXqn7WQpRkOIEMpyZG4rIMq51ts+g6k=;
 b=lhbM9zR1G0mBpdUcUYuT6PKJPwxpTNQ4Q7g1YSSa2V96S1KK+K2qUOZJa6cOjt5mYAg5RaAD7bGAn/kZ0cjPsG3wRVe1OQ6cfo/trQddkcUN41BjQn2mPTudBnE0Nvl4dEF+A3kPGb+obfpJ4Bn1je0oIgckZp1VpLjMI58DG+wq9hj9i1uGEaucg8ce/Qq8layNi4OszCvUgdu8wUt+dKNQipq1A99POkV4YQcV/36wPVp4xffINuHkJiH3HmSm8UcNlgbJYkk8KdYMJsiA5e/EMjPP8xdp6NGVTNCF9fD5YPZw3k4vIZx9IPfc/xfQw33D4X4vQRAb2iAjBHXMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 15:59:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 15:59:47 +0000
Message-ID: <e788ca62-ec63-4552-978b-9569f369afd5@intel.com>
Date: Fri, 17 Oct 2025 08:59:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>
CC: "Luck, Tony" <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>, "James
 Morse" <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <aO0Oazuxt54hQFbx@e133380.arm.com>
 <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
 <aO/CEuyaIyZ5L28d@e133380.arm.com>
 <dd5ba9e5-9809-4792-966a-e35368ab89f0@intel.com>
 <aPJP52jXJvRYAjjV@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aPJP52jXJvRYAjjV@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de3eb68-0a57-4e7f-1371-08de0d9631fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjdrbC9jVEtibGRsOFZjVGZuSWJUYy9iSDZHWjhVZFVjWmxEemw2b3gva0NZ?=
 =?utf-8?B?TlBTZ2NYZ2VHcFlqYUxySFlaUUxlTVdqNnNHRkZOYUp0LzdBZDdSVTNHV0Rx?=
 =?utf-8?B?aUJRZ0pyWmxOamlWYkxScG9UbWgxZ1dGVGx0bzZCK2QrR2hTTVg3MW01Z2dT?=
 =?utf-8?B?MHE3akNXWEwwblhYMmRVWllZRHI5eS8wakRyUjBqL0ZoZnV4elNKWkRnSnB2?=
 =?utf-8?B?Wm12RDRnZjZmMEFrTVIyRkNUZDdwRmVtWE1EVzNmaXlGdEd5a2xMYU1tLzJL?=
 =?utf-8?B?TmJNYTZDMEk1UHRkSkZ6Z0x1T0krckd2NEQxOEwwOUdMQWtwRjRGeTJSYmFp?=
 =?utf-8?B?QW5YU3Y4TCtGVGdqaEJDb0NvSEtqNVEwMndUVmNLcFdzNEYrNzM0dW9nTHNQ?=
 =?utf-8?B?VWVaMjRIMzhOYTVmOFd3NDdPNXVCMlBXaEpYQjVLSmdRQXZLTHFobFBtT0d4?=
 =?utf-8?B?elBiZHFpNEVhUmJXeVA1eHRud3VlZlZCK1RVSE05U2tUdi9EZzVCQWxJbGhL?=
 =?utf-8?B?OXp2MCtKbmRDV01DYTJ0SlFVM2thaEVGQlN5dmcvVzd0QXlNa2VreGZROUFB?=
 =?utf-8?B?cU5ESHdnM2x3K1JRS0NoVWovRlN0VWtVMndBZGNraVZrZTBwRXNFT3BjSHFS?=
 =?utf-8?B?WFhkV2hwZWh3bjRPT3JLYjVrTkNmSTNpaTdjZDBpelkzemJieG9SQWVPOTh5?=
 =?utf-8?B?ZVh6Y0R4Q0tINTFTbFlnaW52QlJpTDZHRXlYMDE2RzVZdnY0MmlRMHlLMmhk?=
 =?utf-8?B?MWFOWHNnREE0eXNuSVpId1BFeUdBMTdISlpvM01XcVNPNXZxOUlXUVZJQTlh?=
 =?utf-8?B?YVBYVm1FZHV2VnZuWFhBV25STzEvOXptQnR4R0diRHk5N1BzZkt3aWF2WXlU?=
 =?utf-8?B?aFpLUUMvc1hiYUJxM3dMemhFa0xuR1JISG1WRGlacGFDbFk2YUtHTGF2ZlZT?=
 =?utf-8?B?VktMRWc1a0N2UHZvUk81aHB4cDhaVUFEVFFkaUJEbjFyM25WSmNzMFA1RHVT?=
 =?utf-8?B?cTNxY1FGek85S0l2U3U0U3JVN0o1TkU4Vk8xVWJHRVJjTzZSbWRadktSc3Uv?=
 =?utf-8?B?Zm9EUVcvTEhXUkNKWVB4SXVreGtKcDc0SE9sS3M4aHpRRWhXdjExR1YyMTR1?=
 =?utf-8?B?MThQdFVKbDlWL0JNd3BjSFE2NHhBUTVlc2R1VEdKeElXTnhJNHQrdGc3dWcz?=
 =?utf-8?B?L0ZCbCswNmk4OEhFbXhhcHRueTNvNkIrWnN6MTQ0NGdIVHF5VjVQejZVYWZv?=
 =?utf-8?B?V2hRWnFsK3ZidGkyN3dxemNHb042WHBocEdhNDFQM3pnNUZnd3lPUFE0bXJT?=
 =?utf-8?B?eFZmLy94YmJBQ2FrK1hjeEo0cDZ2N09xV3Y4MTlhV2c3TkdPVGxFcllSM3dU?=
 =?utf-8?B?N3JBQlhHUXRKWmMvMWdZbW9ZY3VxSFM0dnBkSGc0cVY5d0l1YlkzbzFkUnhM?=
 =?utf-8?B?eVlSL29zT0h5bHhNUlVUZHYvKzBWcTR6d1BhUjYxeVVIWnYwdzNVd3B6bzMx?=
 =?utf-8?B?SWhzZElVM1licHlqSkpqT1VaT01jVFI3OTkwc2xyNHR5QllUZ1Frc2NhTDdW?=
 =?utf-8?B?SFZHRDlDYmtyWThNMUNka3ZVL3dNdTJsMTFRdjFzc1pHRW96OE5DekV5VHlz?=
 =?utf-8?B?QzN3MHZ5YzR5YWZSVkFyZVdlalQ3N1BKWmdWdGxJOWdlazRiZHRkODd5ejBZ?=
 =?utf-8?B?TGRBRW9Wa2t2WkVqUVdub1pXZk5DUFpqVzJ4Q3lYSDhjUXYybUs1WWgrQWRv?=
 =?utf-8?B?akdkSkhYblFvbURVTnZ4STJ3N2F0cy9QSjZHOXdXalZCWnJCVzM0cUs5dlpV?=
 =?utf-8?B?bHNmTWc0WXJoRkp6c2grNUxxVGNFWFBsbS81aEhJWVN5WlFRdTIvTHB6Rng4?=
 =?utf-8?B?SUVpVDVmY1RhNkVTZnJmTzAyZ2k3SHZMUlk2S2RiU1l4TlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHRhaTJqbkxheXRSbHZpK0pSYjhrTURBZGs3aENnbFl3RkdHZ2xiRXBOYkRM?=
 =?utf-8?B?RFd5T1h6Q3hLSVN2YUY2RmNEUmZkQlY2WUcwVmZFOGRJYm1DcmgyU2hhcEtz?=
 =?utf-8?B?MUhLbVpNR1NJM2xINUFDbFdveXJhV29mWmp4SVc0Si9VNDlFZGdzeFY0MmlO?=
 =?utf-8?B?NTB3Rmlyb3Fqb21wZGNOdktMUDVvVU90ZjVDbFMwOWVwRE1GekZ2cVRCc01R?=
 =?utf-8?B?U0JuWmVyV25BMHhVa1h4eHlyYmgxVVZLMFpyV2l3RU9aaTdFM1V4eGFpanJU?=
 =?utf-8?B?TDBEcDQ4bW90MDFHVmpXaXVPaTlaV29IWDBJNTFtcld1dVdLaEdXSEdDckd5?=
 =?utf-8?B?RlM1OGlWdnlrZmxkTE9FQzZJdjBFVXZYTkZWeXFmTjF0eU1YN3JIYVYrR1VZ?=
 =?utf-8?B?SlN6NVlsakdJOEgyMjRiOUxkcklhUFpWeXFWcGpPandKL1lMV3lsNDdBbHdB?=
 =?utf-8?B?b0wrLzE1UHpaQmhjQTF3SE9OYm56ZXlTMDdaRXlOdXRKNFFsMTNseFJqeVV5?=
 =?utf-8?B?SFE4aFE0SlVYaXlnaWxkc1NzNW9GZjFlZm5QeWgyOUJXaGF4LzJvQkJudDFp?=
 =?utf-8?B?RTVSdjUrZmVldjZtWHU3NVJYK1R2Vm90TnYveS96WVlvZ3V1UXpLdHRYZm1P?=
 =?utf-8?B?aEJ5TGZZcUxyRmlDVVlRMlVYMjNTYXVISjZ4L2RFUklvbmJIYU8rbVBpNk1v?=
 =?utf-8?B?WUFZWTVRNm1uU3pocnU3TFJjNmJhQnptZzgweEsxUkNrKzllUkJxdElvR2Vi?=
 =?utf-8?B?dTBGaVAzd2Uwc20zNlpway9aOHdCM1J1QlJEUXh2Tko3NXFhd0R4V2E3a2hi?=
 =?utf-8?B?Mkp2M09vdkg2OTlsbUFNU0xwRjN3RHlqYjBhOEpTa0NzM0NLNDZqWFp3bHlx?=
 =?utf-8?B?WlRZdHl4R0Z5dHpFVHQ4WUFLbEZVUEFlL1poMitiQjBaWFVkUEl1RkV0RnZr?=
 =?utf-8?B?dVc1bkIrTU5oZmU4ZzVyajdnZE94T0JadmlwT01SWS92NGNlVk02TWJHekts?=
 =?utf-8?B?SXJhWDZ3V251T1BZRVV2RmpOTW1Ub0RCMmtROWRycFZUa0Jranp4YzFIQmdQ?=
 =?utf-8?B?R2lJMUxZS0NYempzL2J0NER5Sm9jTkNlc1lUa3BQNzl3VkgrcDg5c3M1UkJn?=
 =?utf-8?B?VEpibGdsWjJmdUpZVU85TFBpakhxc0c1b3BodVNxM0R0UXpFc2xPcWw4NFpw?=
 =?utf-8?B?MGFGRGJBQUc5ZmpBWitvd1ZDM1QzbiswSzNVNXNWSXRTK0ZYZjV0Y25CeGZB?=
 =?utf-8?B?bkxWZjlLZ3JkdnJaWGs3emtsZHAwRzlUYmY2bzdSdFpTM29Gb3ptTmR0ZzlR?=
 =?utf-8?B?ME1nZEJ3eXpYVjhhenVKMnZDWGpIVllVVVVBaGtJWUk3ZjNhMzdRSnVUYktn?=
 =?utf-8?B?cDNaUWpDMWlPVGZ0MzRzbk0wNmYrRlFhYk5CQTdtVzNNT1ZlRWRXbE1lSU41?=
 =?utf-8?B?VWJpSklIWGVwQ0pESUh5bnpoRUMvL01rYkwxVXpoYnJaTkE4bkVyWTFmcklp?=
 =?utf-8?B?N0xLdzcvcmxGUlNMRmJxOWl4REtvWklQQjVEYlBnSTJ4ZzJVL1Y4OVpmeUFp?=
 =?utf-8?B?a29wUlRYS3lLa3U4TUxnUmFBbzdxVnl1Tm15ZGMrRWtVVjFxRmJwd1FmY0l3?=
 =?utf-8?B?M1RyRkRCOE5mSjBmRG95dDlyOHZKZlNRS1EvS3hMcFIrR1VLeEJ1cG1XQitV?=
 =?utf-8?B?NHcxUXRoeTRORkhCVDJXeHo3SVJDVnpmRzFndHlQSEM3cjZyY3RrSlUrT2hR?=
 =?utf-8?B?QWY1dkNIakQ3NGVISFRSR0dIcHp6d0lVclBQSGFHZnFiQVgrNU92dkNqMHQx?=
 =?utf-8?B?OEMybittbHc0cmU2Q1ZLTFUxcnhUS0lzNVUrRzVpRlU3TERZQ2ZmQ0FGTGZ4?=
 =?utf-8?B?c2MvQlppODNWV2JwdWEra1dzM1hBaTBJU2doMG9zdFVEOWh1TW9mcjE2amJ2?=
 =?utf-8?B?ZVA0UVRwMCtPdG5ZckFYa3pJNlFCMGVGVFR1Y21FMml3SVdvN1FMaGRTZ2Fw?=
 =?utf-8?B?cis2OG5VMGthVG43djMzZSs4bHk2Mm9mQTJKaDk0VlNTbUh0aDg4dUhMS25q?=
 =?utf-8?B?U1VKWjNnbml4OExtai9VZ0NsNTFBemxQeGZJeXA2ajgxSmRqMk5LTjVFeFRE?=
 =?utf-8?B?L2xxU1JBcnovblNtdHdOTnhCNFJhdENKbUoxdi9lTEYwWkpwN3BVVlFSSTdW?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de3eb68-0a57-4e7f-1371-08de0d9631fe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 15:59:47.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXIK2WI6eBoPLV8PyvKcpzXX7d+j7PKCaAx0UM8m20eGklWDJFMyxrn4nso8ITEaJ9HnFVHeYlbzFmwY3ekxukGqv4qmzPQ16nwsvVnaQhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5322
X-OriginatorOrg: intel.com

Hi Dave,

On 10/17/25 7:17 AM, Dave Martin wrote:
> Hi Reinette,
> 
> On Thu, Oct 16, 2025 at 09:31:45AM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 10/15/25 8:47 AM, Dave Martin wrote:
>>> Hi Reinette,
>>>
>>> On Tue, Oct 14, 2025 at 03:55:40PM -0700, Reinette Chatre wrote:
>>>> Hi Dave,
>>>>
>>>> On 10/13/25 7:36 AM, Dave Martin wrote:

...

>>>>> So long as the entries affecting a single resource are ordered so that
>>>>> each entry is strictly more specific than the previous entries (as
>>>>> illustrated above), then reading schemata and stripping all the hashes
>>>>> would allow a previous configuration to be restored; to change just one
>>>>> entry, userspace can uncomment just that one, or write only that entry
>>>>> (which is what I think we should recommend for new software).
>>>>
>>>> This is a good rule of thumb.
>>>
>>> To avoid printing entries in the wrong order, do we want to track some
>>> parent/child relationship between schemata.
>>>
>>> In the above example,
>>>
>>> 	* MB is the parent of MB_HW;
>>>
>>> 	* MB_HW is the parent of MB_MIN and MB_MAX.
>>>
>>> (for MPAM, at least).
>>
>> Could you please elaborate this relationship? I envisioned the MB_HW to be
>> something similar to Intel RDT's "optimal" bandwidth setting ... something
>> that is expected to be somewhere between the "min" and the "max".
>>
>> But, now I think I'm a bit lost in MPAM since it is not clear to me what
>> MB_HW represents ... would this be the "memory bandwidth portion
>> partitioning"? Although, that uses a completely different format from
>> "min" and "max".
> 
> I confess that I'm thinking with an MPAM mindset here.
> 
> Some pseudocode might help to illustrate how these might interact:
> 
> 	set_MB(partid, val) {
> 		set_MB_HW(partid, percent_to_hw_val(val));
> 	}
> 
> 	set_MB_HW(partid, val) {
> 		set_MB_MAX(partid, val);
> 
> 		/*
> 		 * Hysteresis to avoid steady flows from ping-ponging
> 		 * between low and high priority:
> 		 */
> 		if (hardware_has_MB_MIN())
> 			set_MB_MIN(partid, val * 95%);
> 	}
> 
> 	set_MB_MIN(partid, val) {
> 		mpam->MBW_MIN[partid] = val;
> 	}
> 
> 	set_MB_MAX(partid, val) {
> 		mpam->MBW_MAX[partid] = val;
> 	}
> 
> with
> 
> 	get_MB(partid) {
> 		return hw_val_to_percent(get_MB_HW(partid));
> 	}
> 
> 	get_MB_HW(partid) { return get_MB_MAX(partid); }
> 
> 	get_MB_MIN(partid) { return mpam->MBW_MIN[partid]; }
> 
> 	get_MB_MAX(partid) { return mpam->MBW_MAX[partid]; }
> 
> 
> The parent/child relationship I suggested is basically the call-graph
> of this pseudocode.  These could all be exposed as resctrl schemata,
> but the children provide finer / more broken-down control than the
> parents.  Reading a parent provides a merged or approximated view of
> the configuration of the child schemata.
> 
> In particular,
> 
> 	set_child(partid, get_child(partid));
> 	get_parent(partid);
> 
> yields the same result as
> 
> 	get_parent(partid);
> 
> but will not be true in general, if the roles of parent and child are
> reversed.
> 
> I think still this holds true if implementing an "MB_HW" schema for
> newer revisions of RDT.  The pseudocode would be different, but there
> will still be a tree-like call graph (?)

Thank you very much for the example. I missed in earlier examples that
MB_HW was being controlled via MB_MAX and MB_MIN.
I do not expect such a dependence or tree-like call graph for RDT where
the closest equivalent (termed "optimal") is programmed independently from
min and max.

> 
> 
> Going back to MPAM:
> 
> Re MPAM memory bandwidth portion partitioning (a.k.a., MBW_PART or
> MBWPBM), this is a bitmap-type control, analogous to RDT CAT: memory
> bandwidth is split into discrete, non-overlapping chunks, and each
> PARTID is configured with a bitmap saying which chunks it can use.
> This could be done by time-slicing, or controlling which memory
> controllers/ports a PARTID can issue requests to, or something like
> that.
> 
> If the MBW_MAX control isn't implemented, then the MPAM current driver
> maps this bitmap control onto the resctrl "MB" schema in a simple way,
> but we are considering dropping this, since the allocation model
> (explicit, static allocation of discrete resources) is not really the
> same as for RDT MBA (dynamic prioritisation based on recent resource
> consumption).
> 
> Programming MBW_MAX=50% for four PARTIDs means that the PARTIDs contend
> on an equal footing for memory bandwidth until one exceeds 50% (when it
> will start to be penalised).  Prorgamming bitmaps can't have the same
> effect.  For example, with { 1100, 0110, 0011, 1001 }, no group can use
> more than 50% of the full bandwidth, whatever happens.  Worse, certain
> pairs of groups are fully isolated from each other, while others are
> always in contention, not matter how little actual traffic is generated.
> This is potentially useful, but it's not the same as the MIN/MAX model.
> 
> So, it may make more sense to expose this as a separate, bitmap schema.
> 
> (The same goes for "Proportional stride" partitioning.  It's another,
> different, control for memory bandwidth.  As of today, I don't think
> that we have a reference platform for experimenting with either of
> these.)

Thank you.

> 
> 
>>> When schemata is read, parents should always be printed before their
>>> child schemata.  But really, we just need to make sure that the
>>> rdt_schema_all list is correctly ordered.
>>>
>>>
>>> Do you think that this relationship needs to be reported to userspace?
>>
>> You brought up the topic of relationships in
>> https://lore.kernel.org/lkml/aNv53UmFGDBL0z3O@e133380.arm.com/ that prompted me
>> to learn more from the MPAM spec where I learned and went on tangent about all
>> the other possible namespaces without circling back.
>>
>> I was hoping that the namespace prefix would make the relationships clear,
>> something like <resource>_<control>, but I did not expect another layer in
>> the hierarchy like your example above. The idea of "parent" and "child" is
>> also not obvious to me at this point. resctrl gives us a "resource" to start
>> with and we are now discussing multiple controls per resource. Could you please
>> elaborate what you see as "parent" and "child"?
> 
> See above -- the parent/child concept is not an MPAM thing; apologies
> if I didn't make that clear.
> 
>> We do have the info directory available to express relationships and a
>> hierarchy is already starting to taking shape there.
> 
> I'm wondering whether using a common prefix will be future-proof?  It
> may not always be clear which part of a name counts as the common
> prefix.

Apologies for my cryptic response. I was actually musing that we already
discussed using the info directory to express relationships between
controls and resources and it does not seem a big leap to expand
this to express relationships between controls. Consider something
like below for MPAM:

info
└── MB
    └── resource_schemata
        └── MB
            └── MB_HW
                ├── MB_MAX
                └── MB_MIN


On RDT it may then look different:

info
└── MB
    └── resource_schemata
        └── MB
            ├── MB_HW
            ├── MB_MAX
            └── MB_MIN

Having the resource name as common prefix does seem consistent and makes
clear to user space which controls apply to a resource. 

> 
> There were already discussions about appending a number to a schema
> name in order to control different memory regions -- that's another
> prefix/suffix relationship, if so...
> 
> We could handle all of this by documenting all the relationships
> explicitly.  But I'm thinking that it could be easier for maintanance
> if the resctrl core code has explicit knowledge of the relationships.

Not just for resctrl self but to make clear to user space which
controls impact others and which are independent. 
> That said, using a common prefix is still a good idea.  But maybe we
> shouldn't lean on it too heavily as a way of actually describing the
> relationships?
I do not think we can rely on order in schemata file though. For example,
I think MPAM's MB_HW is close enough to RDT's "optimal bandwidth" for RDT to
also use the MB_HW name (or maybe MPAM and RDT can both use MB_OPT?) in either
case the schemata may print something like below on both platforms (copied from
your original example) where for MPAM it implies a relationship but for RDT it
does not:

MB: 0=50, 1=50
# MB_HW: 0=32, 1=32
# MB_MIN: 0=31, 1=31
# MB_MAX: 0=32, 1=32

 
>>> Since the "#" convention is for backward compatibility, maybe we should
>>> not use this for new schemata, and place the burden of managing
>>> conflicts onto userspace going forward.  What do you think?
>>
>> I agree. The way I understand this is that the '#' will only be used for
>> new controls that shadow the default/current controls of the legacy resources.
>> I do not expect that the prefix will be needed for new resources, even if
>> the initial support of a new resource does not include all possible controls.
> 
> OK.  Note, relating this to the above, the # could be interpreted as
> meaning "this is a child of some other schema; don't mess with it
> unless you know what you are doing".

Could it be made more specific to be "this is a child of a legacy schema created
before this new format existed; don't mess with it unless you know what you are
doing"?
That is, any schema created after this new format is established does not need
the '#' prefix even if there is a parent/child relationship?

> 
> Older software doesn't understand the relationships, so this is just
> there to stop it from shooting itself in the foot.

ack.

By extension I assume that software that understands a schema that is introduced
after the "relationship" format is established can be expected to understand the
format and thus these new schemata do not require the '#' prefix. Even if
a new schema is introduced with a single control it can be followed by a new child
control without a '#' prefix a couple of kernel releases later. By this point it
should hopefully be understood by user space that it should not write entries it does
not understand.

> 
> [...]
> 
>>>>>> MPAM has the "HARDLIM" distinction associated with these MAX values
>>>>>> and from what I can tell this is per PARTID. Is this something that needs
>>>>>> to be supported? To do this resctrl will need to support modifying
>>>>>> control properties per resource group.
>>>>>
>>>>> Possibly.  Since this is a boolean control that determines how the
>>>>> MBW_MAX control is applied, we could perhaps present it as an
>>>>> additional schema -- if so, it's basically orthogonal.
>>>>>
>>>>>  | MB_HARDMAX: 0=0, 1=1, 2=1, 3=0 [...]
>>>>>
>>>>> or
>>>>>
>>>>>  | MB_HARDMAX: 0=off, 1=on, 2=on, 3=off [...]
>>>>>
>>>>> Does this look reasonable?
>>>>
>>>> It does.
>>>
>>> OK -- note, I don't think we have any immediate plan to support this in
>>> the MPAM driver, but it may land eventually in some form.
>>>
>>
>> ack.
> 
> (Or, of course, anything else that achieves the same goal...)

Right ... I did not dig into syntax that could be made to match existing
schema formats etc. that can be filled in later.

...

>>> I'll try to pull the state of this discussion together -- maybe as a
>>> draft update to the documentation, describing the interface as proposed
>>> so far.  Does that work for you?
>>
>> It does. Thank you very much for taking this on.
>>
>> Reinette
> 
> OK, I'll aim to follow up on this next week.

Thank you very much.

Reinette


