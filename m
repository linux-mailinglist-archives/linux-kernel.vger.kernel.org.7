Return-Path: <linux-kernel+bounces-765467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A44B237BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59506587EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC82DA779;
	Tue, 12 Aug 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxaEy5wQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5529BDA9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026099; cv=fail; b=ZyN+TBwTmYf433FAnx6zIH0AhSlvrqQeJIyrhHGNxNpHu/5iDo5qRTwDs67wiMzMriEM3Y5h0ySdj3DGfmB3W4CTDFHW7lgS+tTLC6OP+OK+MQ1NrJMFzXSQVLAaotXqOoZ79f/eMz4HJtrIMDrwj+qdSbPUCfkBhVLXNkp9N48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026099; c=relaxed/simple;
	bh=cEwet7ykUES21OzF7C175e2LVhCv77BgVoo9Pm38P8Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PCKeictdjqzIWJOj9x97yJrqDKQf6b9IjalTMkyBbhthnVO9LJ7lcQDrsDcgrM4CRerYXXMKFzqZPWXBnNulpItlND9KaPrE7IQbvc4eY2d90dL4nFXUKAOuX2IbQNG5l7MGcKxoIxP8UVqWIPCqCFQr3UTWz2bq8mmWnhdW7q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxaEy5wQ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755026098; x=1786562098;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cEwet7ykUES21OzF7C175e2LVhCv77BgVoo9Pm38P8Q=;
  b=LxaEy5wQlrbRtyFB1+IE7cgSo81ofbQZ9HbChrWyh+I4T3V0VDtlZDx2
   180WCGKVnQPL8H260/05iAG7UMfOLZswNm+zHxAom/r0W5n4oj9KmMnz3
   Vp7UTV7SW3kRNL9kxkeIcluoVWNc5YIV4iAXUE+Mb0gYCYg41u+KT0M+B
   pHP9CKA5jrJza4jS2WN9CYxP2NUtEAAzaxA8P1a4oYzlxy+sM3ZnDnIdR
   1f2uxn2aTaU3376tF8Pwv4wxsT8EwP651CQq4nl1ZTW8cGr79jHrytqvq
   9upxpUv1UCnFBItW/fJ0ES1wFtr2yk2APOJpWPs3lkLOy58AVBgp54sXx
   w==;
X-CSE-ConnectionGUID: f/hi9c8rSi+Z3LhAC+xU7g==
X-CSE-MsgGUID: Tzfkdc7oRd6dEDyKhvW0rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="67576867"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="67576867"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 12:14:57 -0700
X-CSE-ConnectionGUID: /L3emgxoRnmlS/rjoPyvOA==
X-CSE-MsgGUID: Z4zSQAb4R42GP2Rnru+31Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="171605197"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 12:14:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 12:14:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 12:14:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.77) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 12:14:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7EFj6aRdiBvfPtbM2znAmzw3DDhIoiAcewEu/xnvT//0DYqujRs4SWGQhrmB4vgs38gov7XixCdvwJM21OMPIB0YAI3ThV44SjlMFhd7BHIwf7KtxHn7oJkDEJ4B7AWujorjtCxB1Xxt/BMHXQuRt5MgS0xTqBw+KB9tvpgTBzQG2puk9d+qnWmtSp5mS49PNgeucZ9u1XgF4dGpLMk5zvgAzG57CJIVl70Hu4xQXxQh7PyDjSnjpuiltIEYv11KR62mWr7RBEOGMK3F3P+wnVRHHPZGeBwXnlXod8mQqCHuj+fzGLrVGfRm7oj9tu7LsjGY1DvJgDab6KWCjrw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg8RFgmlq9p/D9yvrJIF2cOV+fXILODmm0T1Ya5gRX0=;
 b=EnblNPvWve1hnAXs90uUzfXCChrT1+329k4N86Aenps2qjESHuObC1CYzOtYhxMU2Pvc6sv+eN/FMymeS7LrI89yRxEnPV1hoRPA0mq6IrjMAHc4O4i/P2s+ObJjfHZ3ZrfhPrd/8ga5sBx8dTn4ihLdzXi9O0L0gK7ed3cqyEfgJAmV+uME3Gv0lYo3mhgjARv39lnYTL1bkhWo2FaAAiFmpKv20rfhMzN6OknCS+BpyxsE0YTCLbV5I2VhjbFxm8DwGcC1pZu6Imejt5AKn0NUX7oXukahoWo5H408Dn0G55aQ3bJyj3DDxcbx8MzFlqmx1fbsyD7BPfH4rbBzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA2PR11MB5033.namprd11.prod.outlook.com (2603:10b6:806:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 19:14:53 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 19:14:53 +0000
Message-ID: <2952979d-3275-4a33-aadb-c946e1ce0100@intel.com>
Date: Tue, 12 Aug 2025 12:14:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/microcode: Add microcode= cmdline parsing
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-2-bp@kernel.org>
 <f641cc0f-e542-45ef-bdb9-d8364860688e@intel.com>
 <20250812102345.GAaJsWMTNvC2ULKtep@fat_crate.local>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250812102345.GAaJsWMTNvC2ULKtep@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:a03:54::23) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA2PR11MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: d0548c02-3697-493b-04a8-08ddd9d48464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzNHNUFhNUd5VmRKZTFwSEI2T2lraGMzM29CTGw5UTN0SWh2ZENIeEd3dUd1?=
 =?utf-8?B?N2RUYVVCbmxpRGhRcFh3RmZ3SmRiVnZ1TjEwZEF2d3cwdW9tcm11YXpZTWJP?=
 =?utf-8?B?bm5mVlptWTB6aUZWaitwRWJwWGVybXpRdUJnUU5NNXdoTmJodGRuQTFNWlF2?=
 =?utf-8?B?S3FHcm9HWldKK3ZyZjdVOHZheDRRcmo0K1NvbDZuWGdlOHR4VjZUMTF4aEJT?=
 =?utf-8?B?aXBOL0VyUmJEdXNRYWF3aTlXL1B3MTl0OXpVT1g0aXROWlAwY1gzcDB6dXpR?=
 =?utf-8?B?NUtxU2cwcmVTOGZIcVFkZlhNWUtRUWRkQlJvUzg1b2dSVENKbEt3bVNHZG0r?=
 =?utf-8?B?UGhkSjJscmd1ejBIY1dTMTdjd3A0SEhtK1o4RmNnaGVxNjIrWkM3cFJvaXY3?=
 =?utf-8?B?YkZaL2NEZEFmU2o0RjhRcWpUeUZ1VkZ6a0V1eE11dXhraHJDMTFUdHdNbGpa?=
 =?utf-8?B?Y3RpS0cvUmRQYWJqSmwrTGxmcEJzbzFSa3g3Z0tUTkFHbWFTanpmRGx6a0RW?=
 =?utf-8?B?ZDk4L1lMTDhFNytNTEtMQUFWdG05YjBEL0NTV1hPNXIrRFhQNjhXL3FtN04y?=
 =?utf-8?B?L2dERTE4Tlc1eWoycVdyeGtkdTB2OENqWkFuc0xhRXZDN1RUMWhLUXROaVox?=
 =?utf-8?B?YzRjL3drLzJzZEhHQWozZVB1NFpQdU85SkFjVGVPTmhnMDFaVzhndm1IbVFx?=
 =?utf-8?B?Vm5Sd0o0Z1d4WWpWZGIvenNtQmppL3p0dGtsb2pKQlhLclBwWHZhcURtNFZ5?=
 =?utf-8?B?RmtPdE1sQVRjMTB1VC9lcmgxSXJxbTd5M3pweXJnYWF3Zm9ydUNSaTdWK0pF?=
 =?utf-8?B?YUZCOUJIenlXd3MrK3hyWHZpa2c5QndtaFUrRnZ1TzBlZDVoL2dNNDVTTDNR?=
 =?utf-8?B?QWl2Y1J1clJFdVdrcTE3MmNKVkRHWVpLVnZRMXBJSUh0d3VDeGFibVl2NHlY?=
 =?utf-8?B?MFJnOXJYWFora2tva0UvalJQVHZQQ094aWNyL3gxMjEzTEhEd1hOZ2FmUVF6?=
 =?utf-8?B?dGc0MVhJTG9ISnJXMVVFSDQ2cDZGUlpGS2E4VmZPZmhIMUJpOFRjSG84NFls?=
 =?utf-8?B?MEtHNDQ1QVVNbkFrVmxlSGF4Z0NNcG11TlR6T1hSNmJRZmwvd0ZaNlhGRHE4?=
 =?utf-8?B?VlhMTlJhd2FFb0ZGcHV0SmxEVFFZUDdrMFA3QU1YbVRSam5tSnJiRHh1UTNH?=
 =?utf-8?B?cUtiRUpEelB3NGdoYjRPYjQ1M3NWVFZLODVVOGNjSGlDT0tTWFRybGQyZVRH?=
 =?utf-8?B?dTBlcjZuekhpYkswWklMS3NpNVNGQi9leFNGUFdzcTA0alo3Rit0ZGtCUnZN?=
 =?utf-8?B?blpuc0tsdlFIRnFzL09OU3JmNVNzQThrS0ZNcXluRGlHdUg2UXRrNVl2ckwz?=
 =?utf-8?B?NmJGdG5NOEpZSW9QVE1CT2JIZEx0VGR5RDM2L0JhY3RTcDRFRmd6V2d1SkJ3?=
 =?utf-8?B?R3h5cFZ3dnQ0SldMY1E5WUVLRVlHZGkvNkZOYlFrM0h6OGFieUtrcnN0c2xC?=
 =?utf-8?B?bG1nSUYxYm5Zbmxtb1BYdjdCcE1xMHJUU2Y5cTNxMGxMM1p2L1dKZjIyK1BQ?=
 =?utf-8?B?cUpDNE1LRHJqL0dham0rcVFJbXpGR0tkN2pSMVlsZzlkU3RjbmVJYkZLOXA5?=
 =?utf-8?B?aW1JL3J5RTlmeVNoK2YrT1lvY3VMMWJ1aUJWdGRSa1VUUTlBdklNVWlVMm9s?=
 =?utf-8?B?MDhKMXNOcHJMSWpWSjdCZzYvQXF6VGs1NHJkRGorVUU2VDBOWDJ5UEczeHFq?=
 =?utf-8?B?aDhLQ1JmVTZKcUk0U0Q5STVWUW91SXB4cmx4VUJvZEdBTGpDbTJWdS9teWhN?=
 =?utf-8?B?RGpYb083V1F0Y29NZWJ1c095TTJoQUU4NkFCZmNVOGE3eC9HSDBKUkNXQkUx?=
 =?utf-8?B?NnRWemQxRUQ1WGRoSjIzSGFvYUYzbUFBVEtpNFdnRURHZVg0bGlFNzMyU1Nz?=
 =?utf-8?Q?x37OLsulj/g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFg5SVhyamI5NzNqU1B4a2JuZGlaN0NPRkZGdXdYS1VQYUN6MXlaR1VkdDFF?=
 =?utf-8?B?UWFXVFpYdHM1Y20xL3FZTFgrQXlMSzVWZTV1enp0dU1MdlE3MGQ3ZHVyWndT?=
 =?utf-8?B?L2kwNENUOGRxaWljZWk0QjV4MXRKck9USnJGbGNKcHhRcm14a0haKzJwbDJE?=
 =?utf-8?B?dEx4cGwvQWZHaU45RXRaQmxsdithaC9nSEtOUG1BV0VIdmIrZW1zYWprWWR5?=
 =?utf-8?B?NEsySjJ4ZDNaVzlxM3RSL3pHQ0R1dWx5S095YXVIUnlkdkM4UFF3MVZ3dFUw?=
 =?utf-8?B?RWVOK2dicTU1QkpqMi9yd2ZFL2ljeWN3NjdRWDJST1laQU1tL0xmWDBkSGtr?=
 =?utf-8?B?MVhZOGNqc3d1LzkzazNTMkZPVWZyU1dZRHVMK2FPUmx4RUJXeFdoR0pNSnl2?=
 =?utf-8?B?Zmd1cU9WU0JlNnc2dXV3YjQ4Z3RNREtHNTl6YjBNdHN3NGpWR2RPV0QyOWlT?=
 =?utf-8?B?am5sazJ4b2tHbllQbEU4NkhaTkxxcWdiMThsUkRjUUxnUXhEVFdMMVZPQ0Vs?=
 =?utf-8?B?alZrMlYydy9yeklBSDFEUEQzSHVsQzBhMnRDNWEvYlhaVUxmbzM2dGFERmc2?=
 =?utf-8?B?Tkpwby8yQlRRQ2MzMnZtUHB6N0dobEZKY0NrUmQ3b2hlUXAreGpiQmpPWUpB?=
 =?utf-8?B?K09vU3VpN2M3cE9nN015VWN3WkpmMGFsYWhzV3VrSVNUVFROUjlGKzg5cDZR?=
 =?utf-8?B?L01qTFZVemFFdUpRZzNXeXF5WVArQU9sMm1sakpTaSs0eHlTRmtHanVRcXJ5?=
 =?utf-8?B?N0N3TlpNcFo5a09la1J5QUZMeUJ6bzRsVWlJc1VWQXZqMVBteGNjR2kwMzlU?=
 =?utf-8?B?MVFidjdEYUtsNGUwWGlOS2thUVc3RUZRVHZjcWF1eDR2clF5RWRnSHZrR2xX?=
 =?utf-8?B?MEhsNUdFYTM0amVHS3dwTDV2UE9jQjFUWm82VU9YK2JzZDhBN1k0aWw1UVZU?=
 =?utf-8?B?OXRld0NGYSsxZ3ROZU9LSUNtZG1VQkNTZzAzNnNNZGJzblVKbmVpTmF4eG12?=
 =?utf-8?B?RDFRZFlzYk53blNaejFxbGJIYTJPSVRkUDVMQTdlVm5UeVcyY1VoOW9LaC9u?=
 =?utf-8?B?eGVIWnE5OEhIamVFcm9vb25PVHNRcTlSK1gxQnFvN1ZKdUc4MWZjMXZlVXI2?=
 =?utf-8?B?OWUxS01aUGtKVEpQV3FFM1Rnd0Q2UDhBR3ZUTTJkbW13eVlEVU95a0xmdG5u?=
 =?utf-8?B?bkNRZHpZS0VScmtFd3NISnQ0QVQvdUxWSUY2T0xIVG9JbFQvUS95TFpINTIv?=
 =?utf-8?B?L3BmTXRqRFY1M3hwZGhWMlFhWHdxNXQ4R1NKZzJnOHlCWkRaOVZMWWs1a2d2?=
 =?utf-8?B?MUNNLzM3SFNOa3VjMEpYazV3QUNJZ01Sa0pramQyUlpWL3NZSndLV2w2Um1D?=
 =?utf-8?B?bEFvb3daL0l2UVV1S1pIMXhTRkxEY2JOR1h6Tk50VXQvc0s4ek4rRkNodVFB?=
 =?utf-8?B?MjZUdWhqckRXamVCZHp3Wm1FTmhoaDVvZ0FKSVFscGZ6TDY2MVczNkltMGlB?=
 =?utf-8?B?VHJhcndxZlo1Znl3MTA4QW9oY0FPYjVEbm04NFFFSFMyaytXZXlIRkt3THcv?=
 =?utf-8?B?cXBodzcxWjhRWGdkRUxJNktaNG0vK2VKS1Fjd3J0M0VwbTJyRzBVMjhjdHdY?=
 =?utf-8?B?Yk5tc0hkbVM4dmVhWHBWN1VMZ1dHbm9CNC8zMjZNcGs0ckYxYU9saEd2VDd4?=
 =?utf-8?B?cDJLczVwYktLYWh4d3J1VFFLTlJLeGwwZjQyc2tWaDlhdHl6OWdiVXV4UVQx?=
 =?utf-8?B?Nm5lWjZRMFppeHhsWjBQTHAzK3FzdFNEQlpWOEJCQ2hUNjRSMkREZGZuV2VW?=
 =?utf-8?B?a1g3c3d4K2s1Sk1VWjk4b3dlUEdoWUpkeG9NN0NoMWFtOWV3ZE5WN3BHR2x3?=
 =?utf-8?B?RW10WmNjMHZmaCtYM0NPbm5MbUY1QzZRZ1RzNnUwaDhEai9Tcm1Ub01TbERI?=
 =?utf-8?B?dGNQZnA3eDE0SkwvZU1aMXBwNGJ6bmlkQThrWUU5MmJUQVFyNHVoYkZoUFBv?=
 =?utf-8?B?TmxFaEx1UHh1cXJ3WkZVcWlTWm9kTnhqRWRPclc1S0NuRC9PcEdzTjdldGF2?=
 =?utf-8?B?bzUwSXpJRDZtWmhQWGpPK3VkZGdzcC9zUE5PWUZDeXRQbHZGUzhNYldXSEJJ?=
 =?utf-8?Q?r4qLm/MfcFpTlKcVJfBNRkSQT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0548c02-3697-493b-04a8-08ddd9d48464
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:14:53.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWG/i1Y7zq6M2nEULVGSkpg+Vsfo51mHuwCmVzZxaWi2NSyYUCwEMMhuqPAyFiT14Dh9rA4oi/uViqCu02stWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5033
X-OriginatorOrg: intel.com

On 8/12/2025 3:23 AM, Borislav Petkov wrote:
>> @@ -1211,7 +1211,7 @@
>>
>> -       dis_ucode_ldr   [X86] Disable the microcode loader.
>> +       dis_ucode_ldr   [X86] Same as microcode=disable_loader.
>>
>>
>> @@ -3770,6 +3770,9 @@
>>
>> +                       disable_loader
>> +                               Disable the microcode loader.
> 
> Because adding a new alias of a cmdline parameter doesn't belong in the same
> patch.
> 

But, this patch introduces code to support microcode=dis_ucode_ldr which
would then become ABI.

> And if anything, that thing should be
> 
> 	microcode=off
> 

Sure, a separate patch directly adding support for microcode=off works
as well.



