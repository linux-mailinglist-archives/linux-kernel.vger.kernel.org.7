Return-Path: <linux-kernel+bounces-836537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1235BA9F67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4067A23F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1702630BF5A;
	Mon, 29 Sep 2025 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ny4kYSaY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAB2BB17;
	Mon, 29 Sep 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162186; cv=fail; b=W28fwZ80wl+PngUwGkhXwK4wcMLvb2wgG6kV+eM9ACH0RDKnHG4WNJAuUDWT0YOJmMZQmUetTD/c1BkpawiubehVxx5FowxwZ2kzw7XIEmEy0P1o6D8l0BIDaXFK2MZHEwRC6z8XLeEBlT6Jc9LgVDSZuyEl9xcfJVbI9KiE5Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162186; c=relaxed/simple;
	bh=/dBky24DB+aldmJw5k/Kfr8LR4gixhROUEaNGOYra0s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rS3BvSbWDyf7NarXyeKoDUhBy0R0RiwR+BXscGK/fqP5BZF1/jc4lQw8qYILGHEsWYAf9PdXFULNJAx5q3dJMmYjD6v0lb2ByC1eVvBOzjExrvHl3B7YkZ+9OrqEjL+8Vy/ePsTj2EWlsPiptYx6RuRQ4quIoRc14xf5d9XzgqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ny4kYSaY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759162184; x=1790698184;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/dBky24DB+aldmJw5k/Kfr8LR4gixhROUEaNGOYra0s=;
  b=Ny4kYSaYv6TlRLfmWaloYmZfBcN2U5vg+WPeLksiTrETuU4MHwVBHXDc
   HkI2KkBKfi9YsqBjJslus417i1f6DJ4jaCHfCA7Ildh2lPJagnEgxAy+D
   h4PbKPU0MWhZOemohe4pxF/OgaQKOQJ2FEfTTkIgi4dho18RCFoIVkGW8
   +0MFgmgWJo3JXcNA5OGV8QzVLWZhjoVPi7rl+mGOHe99lnBFEpLKQ/rne
   2XEwtDjaywZxyJMGyQboBm/5rlFP0YZdo9ZGxMkxBh43gBCsqjOpI2nT+
   7r9EqxYymMgkTaAyP6g3+O//ydb1k9XMwdlQ0Xx094XvBmQ1GAw5r2BZQ
   w==;
X-CSE-ConnectionGUID: djCguJX6TaagONHtYZ1M2g==
X-CSE-MsgGUID: sQejfPiiSvGefcsziq8cLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72020023"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="72020023"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:09:43 -0700
X-CSE-ConnectionGUID: jXExXq3+TASBVu60bGaL5Q==
X-CSE-MsgGUID: l1VfzGTmTmaZcDYubGi4xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="177876324"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:09:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 09:09:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 09:09:41 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 09:09:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqkCYsxkHFlDhrekzkut8TZYj+FEZklqEPaokqliZMhjjQk/HOQrVNYZx0lQdVrfMSBPlbyn0CJe2w1MnhdzFhRjcGOS5md2UEn3ZxgM18kZpq82/VSUnOHMQ3d5i7VVRRC10XszijxzeFsYbv9Ul/LMN9zvCKN8upEady4t/qzPyv5vRV6CezrEe0xjS7FUS24qlv8BhKVlHHOCbCL4NK3bkfF28+Ps+B9VNOzlymS71YH3HL7PuYSuUPOtbiuL0xTTlmOp5QxtoGXO4zyCqbDCc4lq0hj2jNM+Qaw2FoXZIlrY6kly6MnnznPpFXH4c57SyieptLvmmOM9lPEuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELJ96PiozJGeaLOxD3rwODC5EqQfPUwLq9rHPQPR7OI=;
 b=ggccHTLzy6KtdLVQS2ciYO3t6/IPrtWtDXwnujaH+tQZxWRSCPR2oBcsNh67xlrDQYVi0eZIAMxuKxuKPpKX575tx9y2/xVHXEAyeuADe/9ZbSg4Uc8RGXfUSPFUvPEKYH1dl2S1Mi6VjyG3/Mx5RM5fBJjuXgnCvqrjBVmzvzDA1KL+g4ZRqIfEapfTlM+uhYmRLc6aYFo84yZWE66zEvwbJ77hD2k0/VxBUzUXX0ASv3A5wmx2yzmhQfOvV8L1pMmDtAeR32PiFO1O6e1TKEhkq7tOa7I1P6ZxRBNu8sUbkqF/queTS49CmuBYfIi0B/oPxEIS4+kw5pleevFX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 16:09:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 16:09:37 +0000
Message-ID: <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
Date: Mon, 29 Sep 2025 09:09:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>, "Luck, Tony" <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aNqQAy8nOkLRYx4F@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:303:6a::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: d1af0f52-7be9-4d49-7a99-08ddff729686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2JiR2V5dVR3dXJ2aE5kTXJzY2Y5cGVwWjRuNlREc2NuTUxUd2NTY0kyeHJt?=
 =?utf-8?B?KzJNdWxhVkpvV0N5WWl5Y0dwcTBBQWFxZkRNMDBZS3pTTTFpNzhmQlZ1dTlY?=
 =?utf-8?B?RHZNMXZ3UTI1b1paZTVSZERVMGhEVEppOTRBdGsyMHN4M2xkS01vWnZLc2JT?=
 =?utf-8?B?Y2Z5L0FMWkpXYi8zd250QjRSVHJXeU1pSWlLOWcrUHBINzlpa0ZqRGdrdXZo?=
 =?utf-8?B?WWU4WEJIMStnQ0MveGJ1MUtFemRJR0tXVWFFd0FaK3hQSjJYUmN3ZE1lT0pn?=
 =?utf-8?B?NXFhZmYydTQrT0NaZ2g5MjV3WUlCU3FYMUxhTkR1R08zZGRHQTc3NFBESkRC?=
 =?utf-8?B?Z25GZEM3cVlqVE1rS2tBQlczVVRoL3pka2lqK21yUHJIQXJHdm5vU3B6ZEtW?=
 =?utf-8?B?UzNCcUVwaE5RYTlGVkl3UFBPeG0xMkhXQkI0TG1DVHhxWitwSVJWRGwwSncy?=
 =?utf-8?B?Z0ZKVlpPdTNYMTljeG1wTzljY0w2dm54VFlMZVZvWWl2ei9DUkZpd0cyTEtl?=
 =?utf-8?B?ZFI1Qnk3MEt1Tkk1VWxwVVVuamlzcFdHM2p1TjZSVU9XU3BSY1VObzVScjZy?=
 =?utf-8?B?OUoxVlR1azdtV0gveDExMnhGRXdGa0pIS01ZREh4SWR1bW9MaWhja29GT3Nt?=
 =?utf-8?B?TnVwZVNRQU1zcXNtVE5sZ3dnYjgrbUdmaFJVVGNjd0t3YTNyL1RVZU1uYTFu?=
 =?utf-8?B?VW9TOGEyWU1OamJrd2xBUTJkakRSNFFxY0VnT3lkMFgxaVdpanJ2UDVnWlFv?=
 =?utf-8?B?NWJ5Y2pnbXRnK1dSSXgrOUlET3h2NEZlMC81dlorSHNxSjNBMExOM1gzM0xZ?=
 =?utf-8?B?V0J0QXFWYXNaMTdRQmduU29DUWJnaWVoTCs4cjRRR0wyUWZQMXJUeFJ3Q3Ft?=
 =?utf-8?B?R1c0YlFIMFlqcmtVbUFxN2RWUlpFM2RNSkRvbjlLeldJT3lrU3pONHI3U3lZ?=
 =?utf-8?B?Tjl1NkRWb2hGclBkcHg0bzBsL1VXMEpRQ2lBd0lna2Y1WEhrbnR3b1piTGt1?=
 =?utf-8?B?OWpBTlNldmRwQTB4dU1rYTdpTUd1M3Z1eGZnTS9GODFPcHBpa3QwZHJ5TnVr?=
 =?utf-8?B?QlRaZERwRWFjYTVQN3IvOGRjZkRBTHlDN0hqMGhFdWMrWTdVcGdRQkJKbzMy?=
 =?utf-8?B?Ty9qRmJ5NTNpdFF4UlFzcGR2dS95Tk5jRm92b2VGMHBrR1ZFVFNSUmdhZTVW?=
 =?utf-8?B?dVhQdHc1RGtLZGQ1WVBuam82WU9zbXdUSGdzN1piQ1VicmRTV3VYOXA0QUVk?=
 =?utf-8?B?aGxlVnFLREtHODR0RUQ4RnpXdGhuaXRZOTk5elVCTmRyZTZ0RlBoQXFXN0k1?=
 =?utf-8?B?RDhVUlpaOFRnVnBHRmRJZ05zampjeDRnZEl5ZW16RXpsWTJIcHlVN2ErZndK?=
 =?utf-8?B?c0NxclI5NUZjeUt4NWNoL1FKR3pHUzU1VHZwdnB0d2lnZVd6R2lONVNaam9X?=
 =?utf-8?B?R0kySlhWZ0dLeEFTajQ0ejhrYU53VlZ2SUxhdnN3U0xBbVEyRUw5RnlvQVBK?=
 =?utf-8?B?a005VTNJT01kUkJSMjFjUkVTWnRNR2dseXVqbE9kT2NURTdTOVlUUW9Vd2tm?=
 =?utf-8?B?eC9vaXF3cklwMWhyWnlNOWdNRis5SDdGZ09icTVSaGNleEMvNzQ2b29DSytG?=
 =?utf-8?B?ZlFHVHdxVFROVW84U2xsY0dXZTFsR3NOT3hBNDBWOG5Xelh0MGl6ejRGZDd0?=
 =?utf-8?B?TWg5cGZuMWgwczdVdllnL2FwcjhmUmljQk1aVXZMUncvR1BmbzJRNmxlZndX?=
 =?utf-8?B?ZG9OaUdDY0w1UDY2N25mNUEzbzZiRGY1eENDSTBPODRkdWY3S0RSd2NqWko3?=
 =?utf-8?B?OTdtMExyYzBRQmhqNkloS0ljWXo2MmFVR1hVRmdDNzJlTGV3Y21Damk2REFv?=
 =?utf-8?B?dTJ3bVZldk1SU1g3VHMrRlVjb2hvTDkxbDhESXI2ajZEQ1p5WnN6bEpnbSta?=
 =?utf-8?Q?59qxTuJcVPIP9kagFFdG0H5v8dJHyo/t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1YyMEpiSWo1R2YzSS9OK0s0WWxFTVl5OTZHSVVDaE9Ud0NBSmNGdVA0ejJW?=
 =?utf-8?B?S2lmYUlwZ0lHVEVpUXUvbis5cXdKVTZVUGprKzRRbitpZHVxTW5ldjUyQnl0?=
 =?utf-8?B?MG1UY0RDL21MY0RrNm0wcS8rYWl5ek9QanhvU1llQ2FERCtsWnhkYTJYY1NH?=
 =?utf-8?B?UmFiTTlFZnVKYTlFcjVOMGg2dG1NcFNoK2QrT2ExSlpJZGFIMGwyT1hMa29k?=
 =?utf-8?B?SmQxbUl3YzRORmdnOU10MmlaM0dYTFh6dnZYY0dLajZMdEpYQlhTSDJZTUJM?=
 =?utf-8?B?QXZsaGVZQTZWNDQwSXlSZTFtWHloSS9RM0dWRXJJWlk4NloyVnlyNDM4VFJm?=
 =?utf-8?B?V2l1Q21JbndXSnlqM0FYMVhBZ1NjZHlBemY3M3dHeDRiUUFNeGhoem5SSjNC?=
 =?utf-8?B?SUQ3U1piYWNMM29FMm8yMHlmSys0dGhkWnNzb051YXFZbU8zTUpxQk1rZ1BV?=
 =?utf-8?B?QWZXMEtFQytlZHdXTzFhVGZjQ1ZMK1ByZDdZenhqSFgrNUtDdEpMRUxYRHhn?=
 =?utf-8?B?LzJYUHlDVWVFN2l1eDhKRWhEcnJ4dUtXYVlzS25vTkx5Y2RuVGJ4YWlZU0do?=
 =?utf-8?B?UDdMN1E5ZzdGMzg1ams0YWlGYVpMMVpqODFPdDNGWFNjVGJxWWp6THNUQzFz?=
 =?utf-8?B?MWliL0ZBSFlUMHBJcWU0UklvMzUrS1RWSUdjVHA4aTlqTmlabDdCUUtOOGdj?=
 =?utf-8?B?QjNJZnB5SjFEWlk5UGorSGVKUjJwZUVvV1Z3eDlzR2ZQYXZobjEyZSs2V0pk?=
 =?utf-8?B?aDhBeFg5bksxYSs4ZFVJYU1KVURNcGw0dWl1QUtYNXNPakdlems2V205ZHZy?=
 =?utf-8?B?SXhMVjJUejArd0ZPQ0lPa0NPQVpFYVp5b2JPclBmRll5U0FkdGNYSERJWWxS?=
 =?utf-8?B?Tmx5OGM4ampkcjllZ2ZTWCtNYlg0WmM2MHNqTWZqeTh1K3krYnNlRmw2ZTZL?=
 =?utf-8?B?dFFkaEtYbnJCOHN0dFpMZUlvSWpZSy96NmZES0N2dm9FcmNmL0FvMkhHL1do?=
 =?utf-8?B?RVE2Q1diM2lFd1Evc2x1UHRNdFJBWkEwYTRyWEJpTUdzdis3LytDMHVlWEVR?=
 =?utf-8?B?MGtNcG1UM3ZTU3JmRC85U0tIVEJEOENDR1FWTi9LMmpDT1JheVhQTGVKcVUy?=
 =?utf-8?B?QmNFTERpbSt5TWJZVnFZWGFGNnpOTlpPcEZHRVZJNnBDTTlxdldyd0lQQkly?=
 =?utf-8?B?MExMc0ZVYjN4Z3V0b1dDOENTdkRxRDBDeDdOOHd6YWJvQUlOaGZaT1d5aFNS?=
 =?utf-8?B?WmgyRlltWUxEVDEvKzd4aXRaeE40RGkrVnlhR1NNOUJMQVJIVTRWYXJsQVM2?=
 =?utf-8?B?TFNrdys4SVZybXZOblp4NUF3SGUwL3RveFBFRFFvVlI0SWVmSDRGZHZtRGlM?=
 =?utf-8?B?THkydlJnWHg1UnNqYmQrLzRPSHU0b2piQkhGN3JpaEl2SjdFcHJCYzdJWDV1?=
 =?utf-8?B?Nm41Yjk4c0E1YTdwaDB1ZGF4UkFRNnEyZzRaQXUwRk1udVlmb1RobWE5TjJs?=
 =?utf-8?B?ZG5JWE4xR0FVdWlta1M2TXZaaXdXaC8xSHd2TktjQTdiRTdueWRZYy90cDZK?=
 =?utf-8?B?OXh3WVo4dmRyalc1YUdFOEZTTGV6NGxRNGhsb3hUTWUvbHZpajcrWE40RlVB?=
 =?utf-8?B?VllteXUxMEgxUGZPMmxSS2ZPbW5sanJkblNjd0U0UUpsRUVmdTF2dWNVWFN4?=
 =?utf-8?B?QlVKcjlZRWQ5V1pKVGxBZEtMZWlmTEN2Vm55a0ZXZUlhdk9GU1E0cDRXTldy?=
 =?utf-8?B?Qm5ObEpWKzVkK1g1QWxNcldoWnNxYklmL3Bicm1vMVFtV3NEaHFCZG5zUDJF?=
 =?utf-8?B?SS9XSkE4UGU3YitJMUVpVEkxTXJGeUNBbXptamcwenMrc3FVT0tZSlBkZ2lS?=
 =?utf-8?B?eUhBaW5pSzNjQ0hmSk1PQ1hJR2RXM2M3TE1PaUtIMVNBdm1wY01CcUYrVjM5?=
 =?utf-8?B?Qy9WU3JESmQzSWU4d1ZzbVFuRGFBZ1NWL0hGa3F1eHJwM29mS3VUajMwSmlJ?=
 =?utf-8?B?aVcvRTRFQVcvQUxsL2YrZnp3Mnd4eUpUb3RkL3JqbjBwMUMvL2xGd3RRMHpW?=
 =?utf-8?B?cnBCTGNWclcwUmthZnErUXpRT0xQZmhQS0FrQS96ZldBdWJSbmJIdHNpMHdr?=
 =?utf-8?B?QVp3UWNvaW1pNXFIWVlsVmxrVU41TzBEeVFUY0ErVi9RMjV5azlkUk9FMnVM?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1af0f52-7be9-4d49-7a99-08ddff729686
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 16:09:37.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGdV7kyk8krYFMTNZlO60GmGiWAuABSy0Cdqe6DXb+XCLwkD2MF9VELjJcrvLuO8MtPUHr62YtXZDRN9/Dm/An0wb4lpM++JKRwbWZP0d8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-OriginatorOrg: intel.com

Hi Dave,

On 9/29/25 6:56 AM, Dave Martin wrote:
> On Thu, Sep 25, 2025 at 03:58:35PM -0700, Luck, Tony wrote:
>> On Mon, Sep 22, 2025 at 04:04:40PM +0100, Dave Martin wrote:

...

>> The region aware h/w supports separate bandwidth controls for each
>> region. We could hope (or perhaps update the spec to define) that
>> region0 is always node-local DDR memory and keep the "MB" tag for
>> that.
> 
> Do you have concerns about existing software choking on the #-prefixed
> lines?

I am trying to understand the purpose of the #-prefix. I see two motivations
for the #-prefix with the primary point that multiple schema apply to the same
resource. 

1) Commented schema are "inactive"
This is unclear to me. In the MB example the commented lines show the 
finer grained controls. Since the original MB resource is an approximation
and the hardware must already be configured to support it, would the #-prefixed
lines not show the actual "active" configuration?

2) Commented schema are "conflicting"
The original proposal mentioned "write them back instead of (or in addition to)
the conflicting entries". I do not know how resctrl will be able to
handle a user requesting a change to both "MB" and "MB_HW". This seems like
something that should fail?

On a high level it is not clear to me why the # prefix is needed. As I understand the
schemata names will always be unique and the new features made backward
compatible to existing schemata names. That is, existing MB, L3, etc.
will also have the new info files that describe their values/ranges.

I expect that user space will ignore schema that it is not familiar
with so the # prefix seems unnecessary? 

I believe the motivation is to express a relationship between different
schema (you mentioned "shadow" initially). I think this relationship can
be expressed clearly by using a namespace prefix (like "MB_" in the examples).
This may help more when there are multiple schemata with this format where a #-prefix
does not make obvious which resource is shadowed. 
 
>> Then use some other tag naming for other regions. Remote DDR,
>> local CXL, remote CXL are the ones we think are next in the h/w
>> memory sequence. But the "region" concept would allow for other
>> options as other memory technologies come into use.
> 
> Would it be reasnable just to have a set of these schema instances, per
> region, so:
> 
> MB_HW: ... // implicitly region 0
> MB_HW_1: ...
> MB_HW_2: ...
> 
> etc.
> 
> Or, did you have something else in mind?
> 
> My thinking is that we avoid adding complexity in the schemata file if
> we treat mapping these schema instances onto the hardware topology as
> an orthogonal problem.  So long as we have unique names in the schemata
> file, we can describe elsewhere what they relate to in the hardware.

Agreed ... and "elsewhere" is expected to be unique depending on the resource.

Reinette

