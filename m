Return-Path: <linux-kernel+bounces-753542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6B6B18453
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4091C823D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89CC26FDA3;
	Fri,  1 Aug 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiPmsnuV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413C26E6FF;
	Fri,  1 Aug 2025 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060260; cv=fail; b=ZzbX7VOa/XhTZKzkOz8J8zI1rVeKjs+49LhFbqFEHxrfv1OiIJO0iFY50CoR8E/CJvSEh39ZtIdpEkF8XmLomjsdsyfQIdwflBUOad9VYG19YfD8SwDGnrdDfrTpuR2V1UDDdqECG72z+gZgRIFsrtrxNTzammkwcz2g13tQ+2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060260; c=relaxed/simple;
	bh=+zXzEuzsEEnPl4mj+1dTc9i0lLyBYrWj0jsGWzxbeyc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=olfW5MKN5RQIQhnT0NeSXC9tqIxHWN3F2NdyXPM7uuOZbb55kDhazHGMhD/F9huGkxWVcXVlj/JUFqBupYUerqDvpozkN5FPC7yswfi8fPxCZBpYFBKXPWOUKZEklPTPOnUVDL5NKDQo5Boz4jvDFJw4Oknh4g32x6jr9RxUph4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiPmsnuV; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754060259; x=1785596259;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+zXzEuzsEEnPl4mj+1dTc9i0lLyBYrWj0jsGWzxbeyc=;
  b=WiPmsnuVDEAtrwaSKgr1Oqg9KSz1FUN/QI5jUg4xMQ+Va86Ss4QmS9Ys
   FdYGxokZIkYxy25Vz09UQhIKOYjmcHsW/fuY1OH1XFFYOZ3MFBvU50K+Y
   pqdX6fyqIIptPkPUXVuOdgJQWWO/Myef1TqH5v/7GiOPMbgr+Yg1SaN/+
   5QBZPnjHy/2fmBVIeInr6XK/Gh+a9uVSjIhjrYaMcxF/DqKz3AdjkRfCd
   oDn5AxGiZtCEnOhVwX2GKTX+1MW1nCh17udPRSj5BqiYIci28puE+Ukgf
   ERzxOrN6oHR6BHrRW8X3kYjfNs1ASTXC3IQswNkpmPOQMJEUF+8AMBhtU
   A==;
X-CSE-ConnectionGUID: 6vwt+24wQkeuunbBIoYIlA==
X-CSE-MsgGUID: qU7tv6rWRxaUKQr4BOaQHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11509"; a="56367503"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56367503"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 07:57:37 -0700
X-CSE-ConnectionGUID: hdSzD2emQt2yrTp1aOTE/g==
X-CSE-MsgGUID: iNruokEWSx6zQs6iKNtPPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163597535"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 07:57:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 07:57:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 07:57:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 07:57:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxV5je1uYTWCzUxQ/91GeOW/HOgUqgjqnZgocFOQ9gtM2wHmnDY2QZimIBkzVph3JT5XozU3MIwG2CAePTSWF9BsePj3OZ9qlLLzdxs7KYu9Flm2LDjUMYskwInjiIi8FGJbkaY3Q/P7G5E9+tsjySwOvy8VWNPhcfaOJ70bBQJ/i3GvoGhkYipL7FKrYCmtalsF/WMYWy8L1GmTYbfLX/GgHjgaRZGfr/dTzsWlgITfeOL73pgKxY0OBHBjAlySbuKMc5QDt8tViv5ZBgkRDD+QoUlLVTAIWA3JQiGeCW46vdx7k/lZgA7yu1Uk2qDJjxUKLprILrrT55cTEShPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms/Kqza/+rD8ntETeHkV6qLdi325kAaGe1XVYMG90xE=;
 b=j2VyQlovDhdgZCFUjz2K09iGVB9GoJ1J/QtFbUd8bJEGjgTZh7XUPsDijjCT4rMgMKqAvagJpntIJmz5fXlUEse05otN02WD1QNjV4dM4sr5q5COrk6M7y/F3OneRp83pKXY61FCkKXmJ7vd6J6XaJXezBaETpjBU+kdFj0p+HkrAncWwVVWn/04mmtzbG+IqToB74s1Zj/yX2q5l/GJfsiJf5GlvAzTcU2AukgR2w0/0Wyr8WNP3GYJr/3WYHDsvngBc1nFCkIDiipHnu/7rxEKvk97pidhjU+KFudc+LqrAa/SeYfePvY9Qcq5uE/4NCwGn0FjZwf8WXBdhC5zDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by DS0PR11MB7405.namprd11.prod.outlook.com (2603:10b6:8:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 14:56:48 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267%5]) with mapi id 15.20.8989.017; Fri, 1 Aug 2025
 14:56:48 +0000
Message-ID: <2d875902-701c-44e0-8f6b-6e8ba9b074c1@intel.com>
Date: Fri, 1 Aug 2025 16:56:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drm/xe/vf: Fix IS_ERR() vs NULL check in
 xe_sriov_vf_ccs_init()
To: Dan Carpenter <dan.carpenter@linaro.org>, Satyanarayana K V P
	<satyanarayana.k.v.p@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Rodrigo Vivi" <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
	"Simona Vetter" <simona@ffwll.ch>, =?UTF-8?Q?Piotr_Pi=C3=B3rkowski?=
	<piotr.piorkowski@intel.com>, Matthew Brost <matthew.brost@intel.com>,
	<intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <aIzB8-Y6wtZvfNQT@stanley.mountain>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <aIzB8-Y6wtZvfNQT@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::15) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|DS0PR11MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: f4835906-185d-4d48-7662-08ddd10ba42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlpMT2MrMTdWZVlKRS93cnoya0FEcjFCN1pzNG9ubExyMzltVW00OVM1TG9D?=
 =?utf-8?B?N2ZpV2pPUllZZWRoUFRyVHRkNXh4aHFzNVZSZUpkeFhZUG5ycEJjcU00eVNV?=
 =?utf-8?B?a3pPdkRTYnFyenVqRnQvblpJUWhGTlZhVk1uN3RGSHJIM3JVQk5MZXNTL0hG?=
 =?utf-8?B?bjl3RCtyNWVMN24wRjI2YVowYlJlcXlRZDh3THozaHNxWHFhS0ZqU1IwSXFO?=
 =?utf-8?B?YmZyNlBlWHlYUjVFSkdwejc2eVo0N2RwMUpxQktUbEpaN3ppRTBLK3RGZmtq?=
 =?utf-8?B?eElsek41dUpGa1YrMFl1d1lXeEF0NlE2R1Z4OUVOeFlWcElnenpyMFBPelNG?=
 =?utf-8?B?NE1XKzZSNUp4VUJKNUdoMjl5dG8yRXhBMjlmc2kzMUNDUis0dEl2QTVKR3ZY?=
 =?utf-8?B?TEZaNnFBTnhad0t3WktVdU4vbEFsMXNoYlI5M1RiWWRXb3ZtRXVmamZxeUFz?=
 =?utf-8?B?bGhXSDl0S1VHeitYMThtdmtFTkJUdDJqK0dwRE9paTJ2Tk1Hck9hZ3dQOVhu?=
 =?utf-8?B?VGh5L28yWnpsOVdiQlkrcmxMQzNzQXcvQzk2L0ltc2RWZmtUUzZLM2cxWTVP?=
 =?utf-8?B?L0VlSHpIMTJXb1VkZDIvQ2MzeEhIVTlhTDhIMmZORlExbW9oUy83TGd1dW9U?=
 =?utf-8?B?Wm9pKzVScjBhWDhaRG0vN29zbnA0ZElMR0x2RWVwREVKWFplTGRWWE95cHV4?=
 =?utf-8?B?SmhMYVlCWFI1UXBkVE5UV1FaUlBobFpDSWRoYStaWjJIRThMR3hJR0lZcHA3?=
 =?utf-8?B?WEo0M1E1bmM1N3dqT2ZpOUJvS1BkemhsU3VpMnVHbVNLVm02VUtLbGQ3OUZD?=
 =?utf-8?B?aENYRUp5emIvbldDUmJUb2tOOVUwcEJmeXcvWFVYWDNoSE00QVRnZi9aWlps?=
 =?utf-8?B?TjVOdHBNeFNYdFdJZmRqVjJiS1RxRWh2blZxOTNXUGRwR1RucjFWd04rdzla?=
 =?utf-8?B?WjZGeUFQN2lRUVlkaDc5S1BNdnBvbk5rRWdSdVRDNUIvQWc1VUZtRThrRmhh?=
 =?utf-8?B?bnZldzVkb3VaTFA3RkJpTWh2MXhZdWNydlViUXA3eDd3cTdicjIyZW5YRStR?=
 =?utf-8?B?SXdTRE5DWmVoTWZkOVdnZDVSbHlUSlVqa0V1ZlVYRWYwOGptR2luS21oRzVB?=
 =?utf-8?B?RmcrSmJBM2Iwd2ZrUEJiZTVwN2ppU1pGMkE4OGJQbi8wejV3RzdaanlJb2oz?=
 =?utf-8?B?RW1aekpoS2tWUkFZQ2ZqUXEvcHI1ZDZXdjdSVTQ3S0F4ck4wRWNIR3JQNkE2?=
 =?utf-8?B?N0JYaDZudSttV2hQbmM3R0VpazZHZGdIUU4rOTh1dHJzMEU1S0M5MjN0aU9X?=
 =?utf-8?B?WGpyOTk0ZlkvMVdjb2pnOExNZ1pVTHkyUzRFN1FqWElFelVtcUdnY3FJb3gv?=
 =?utf-8?B?L2FSekptS3hsL1VKS3dhbm53cm5STDJSY1ZvV2dIeUFzZnNqK3ZyVlRrTzdq?=
 =?utf-8?B?b0VnSzBEd0ZldVlzZGI0QU9ra1lkcjRmR2dwSWxmUjB1ZS9mS1NxdXJRN00x?=
 =?utf-8?B?Y0Y1K0lmTjd4bWlBRUplQ3ZhV0dOVzY2RDU4N3NscTZMTXE1R1lkb0FDM1k5?=
 =?utf-8?B?WDR5OWNDMXJjb2lIc2RJQVg0L2pqb1NSbFdOd2JDU3NFdjlsVW1XWC9XWWxi?=
 =?utf-8?B?WXB5RWxibXR1ckZwM1lPSTJ3VkpVS3U1QlhaQnE5SVowajJJTW9QTlNjVTBV?=
 =?utf-8?B?UTdGcDF2emluT3NyVG00SVRNdHVCaW91a2w4aVlHQ0pKbVhtSVRtVzA4dHQ0?=
 =?utf-8?B?dTB4Zld1UlZmbG5NVWNId3pGT2VKSDBuVGM2SWY4anVEbWpzL0M0T1g0KzVU?=
 =?utf-8?B?eVdjd0k0S1lVczBhWDU3NVF0L0NOTkJSMWRXZmVaVEFGTS9naENEVzJaMmpZ?=
 =?utf-8?B?dCtNdHY5cjJpbVlTUk15ZG1Sc3lyVDIwTE1VRnE0QXIrT3k1TzhZZE91Q2I5?=
 =?utf-8?Q?OKVxb5KQC14=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6011.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3hMUEdlWmgvbCtINjRSNjVOaVVHbDRMV2ZycnpzNnZHWXhzSytsRlMyVE93?=
 =?utf-8?B?K2cwbkg4bllaM1hRRU9kbnpGelRZYXhnbE1wODdiYktXOHNFUVFXUkFBNFZa?=
 =?utf-8?B?ODl0RU9YZEIvenlVZDJUVHk3MHhvYSszek9VcFUxbWNDamVYeEs1YW5EQ0V5?=
 =?utf-8?B?L2cyckEyZDB6dFVZTDZ2RytaODZjRlhMTVFmMC9IZWMxb2JKVklUNXhkWTNl?=
 =?utf-8?B?aHRCZkN6Q1gvbExUS2JTSGhzOGJsbG5WRmpDTkxXU3UwUitNcmNiVXlwaHpD?=
 =?utf-8?B?REZVRFlOQ3RmcG4xY2h2WEFieHI2aTF4UlZ2UWR3OXJHMDZUUDFmNmRWTEE3?=
 =?utf-8?B?cDgxVmdqTndGSC9zZDRMNEVDT1M2elVLM0dDcENZMlIzOXVMQTZJOHlkbnEv?=
 =?utf-8?B?NlhqdUNOYTlxaWRMWnFSRWdObmtXcGwvZEt6WFlsVUpDSkdpUkhlZGlZaWpI?=
 =?utf-8?B?TjhVZUxGNzhmQnFWRmhId1FwdHBnaktvM2N4emc5L0x6Qy83ZjNJR2p5TGgw?=
 =?utf-8?B?bTZCc1VXK0dYN2FTejV6MkgxKzdhRlBzWjcydEovWE9DN1RpSkM5WDYwd0ly?=
 =?utf-8?B?ZVJxNGRnazErcFZGUE1nazNOaTJSSmVXVmNobUFweVVVdWxsWk9QZlF0bHp5?=
 =?utf-8?B?M20wMXFDWS9Fc0tNUzM5MFZrYW53ZlBKQllELzBuWmJQeUcvZHBVdHJUSzJz?=
 =?utf-8?B?dXVQTDYzVHhKWStFdkQyV1E4SFprcnUwY3hzRWFJZksyNmd5K0Jrbm9lSGdi?=
 =?utf-8?B?YTZFYTBwcWcxU1FWT1I2eFZDbHJ2NWg5VkNMWnRNd3pWditQOE5VT0FTcERw?=
 =?utf-8?B?bnFyeHRXL3prd1VWMjVvdXU0Sm5DMHNheTZmcnBXUmxCNHdGY2UyNG1aeXBt?=
 =?utf-8?B?b1ZSbTBzL1k2ZWJ3YUdQVTBrMEFKbDE1eFJYT3ozemd4MlMzeVR0T3ZpSzRC?=
 =?utf-8?B?YXlqNkhTMTIzdkNyZmI1QnRNUGt1dXpOYmVMOUVSWXFyNFdaV0JkYkhKRzhK?=
 =?utf-8?B?WnB6QTB1NTdibkFIMmNLcHdwTmlqbFBIUWZJb0gvMzVOUmJ1dGFlR0JCWVhi?=
 =?utf-8?B?K05TVG1GdVh6Rm5OR0FwRUJFb2lWakFSdmk2WjVPdzBNUTN2T29Da3dlUlNs?=
 =?utf-8?B?andQQjQ4WUg1T2szbThQem1lM1ROZmdlSktua2RqVG1WTlJWTlQwY1VXRkh3?=
 =?utf-8?B?T1NGblVpY05mdFNrWXpHYTNCSWlXQmlXcnp5Tkh5YVVrMFQrVGd4TjQyamo4?=
 =?utf-8?B?RDhMOW4vRnQ5cExZZUMwOXNFRHkyRHh1cG5vZE8vYndONWlxK0xzaXhWNmZz?=
 =?utf-8?B?NkVTcDlnUDZjemJ6Q3R5SGdxWnQxS3Ztb01RdUxsbXg4VHhyVmhkTU9oNmxa?=
 =?utf-8?B?VkhucmdJeW5RR2dldEFTL2FTbXlpeUhoejdWV1Z3dlJtS0lwbXNyMWViOE96?=
 =?utf-8?B?YjN0QWY2QjBoZDk2d05yU1NHMzU1UU03dlNvbXNnWGVXWmlwQ1JpeURNSlAy?=
 =?utf-8?B?cmptUDRTNkJ0ckJWVXBhendlcUQ4UXhuWFp3NUNxUGlEKzk2ZFlZWmY3ZVlU?=
 =?utf-8?B?SVoxRVJic3Z2bzF4KzBnMWpqUzBORGFZNmh2ZTVhRVBkejZYVmxLRDhER0JO?=
 =?utf-8?B?M3VidkpibndXc3QrM1FMZDFuRG1oUTJoNGZ1UmZicXZPM09kQXEvaWJPS0l1?=
 =?utf-8?B?bGw3N0FhTFYxY3BBMk40MXdxTndTeGkxK3cvUC9UV1BQSUZuV0FxZkRVYmlV?=
 =?utf-8?B?cjRnVno3aHltdGY2NDVpdEtrZDgxU3BKM2pEUlRneDZTNkJ6TXZyMVlWeEhm?=
 =?utf-8?B?b2JYbnpySERrWGg2eHJHSDhsS1c4bTJtK0Zpd0JPNG5NUVFKVTdkRW8xZmQv?=
 =?utf-8?B?UGZFZHRxYkNERm54TW9IckJyb0VQRHpBYk1EcGZFbzJ3STh1VUpyelVGdXpq?=
 =?utf-8?B?WTdiVFBNR1Y1UjBHRHJRZDNoOWMwKy9JbUxlZ1BQQTVLRnkzL29PRVNiYlEv?=
 =?utf-8?B?QkM4bCtLckYxbnZhY0ZaVmRHYktEM211MkVLQzMzVTRwVzRTS0kyYnN6RmlG?=
 =?utf-8?B?bDI5aWtySlJnRWFia2MxU2xJZUJBazhxOWFIU1pPL1FGNVRCemthVUJYZGE5?=
 =?utf-8?B?aXpQa0xWQWNDWG5QV3R4RTM3RUFvMDRxUC96UUxpWXFqbzJQYzNuNmk2aUF6?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4835906-185d-4d48-7662-08ddd10ba42e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:56:48.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RJ5UexdBafxU+MlSfDo9NjpUFeYLm8evm8ZyEQU+WzUW+XD3z0flJbbp7mi5ynavbPmF/3+oWv2enzu55sij5adyJKOzbZk0GB6lNwJjco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7405
X-OriginatorOrg: intel.com



On 8/1/2025 3:32 PM, Dan Carpenter wrote:
> The xe_migrate_alloc() function returns NULL on error.  It doesn't return
> error pointers.  Update the checking to match.
> 
> Fixes: a843b9894705 ("drm/xe/vf: Fix VM crash during VF driver release")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_sriov_vf_ccs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c b/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
> index bf9fa1238462..e363240a3455 100644
> --- a/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
> +++ b/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
> @@ -271,8 +271,8 @@ int xe_sriov_vf_ccs_init(struct xe_device *xe)
>  		ctx->ctx_id = ctx_id;
>  
>  		migrate = xe_migrate_alloc(tile);
> -		if (IS_ERR(migrate)) {
> -			err = PTR_ERR(migrate);
> +		if (!migrate) {
> +			err = -ENOMEM;
>  			goto err_ret;
>  		}
>  


