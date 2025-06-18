Return-Path: <linux-kernel+bounces-692887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C522ADF83C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 22:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED29F16FA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67720217659;
	Wed, 18 Jun 2025 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2LU2tQj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8756620551C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280295; cv=fail; b=ouhPrDkB1xi5naKwKpzLZ5zOu8XkGp2uLJA0rwGMRK7XFPcyl87FXssHpnpGvw78RS8olh9mgv4t3bQMHGR9bjnJkxhfEuje95UTH37aSDbab7GpsFlM6EJwHCoeqhXqoV80fWS0iI9r5kmanyn8DnWjroEF/jEmnD4pRv6b7cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280295; c=relaxed/simple;
	bh=RUlUfn9zXBU0LWRq3pL/YFOzxNVjpNC40+abAzrz3HU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lNhnNQDUqDyetJGReAyyxRggas3oUvyy4stW08kdsj7SbKNOe9xfQoffSHQmDB8YONPZsJ3feFBKH+xCoUA7fwRYTE+q+KgxpnbJNwlfvENZGwQ5HbcjsGaEg6P5GQGyTHAbMLX9KtosX8SrlDYKfvSBo4c8WIMrqsfB69LnLOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2LU2tQj; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750280294; x=1781816294;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RUlUfn9zXBU0LWRq3pL/YFOzxNVjpNC40+abAzrz3HU=;
  b=I2LU2tQjBJUiqgzKkIemjwvq4fvgeBYGRRqsqNs4IbrGWgEkvR4xnkJQ
   iudH95tkeBAyZK4NOMAa9dRKq6y8LJxRqiC1oovxy8CqlQAptwRnqJ5Rf
   vJ9oQqXdEeo7Lds4dqATPc4xbUq7K9m2JIp6uLVnryTXcHkE43Lx3GE/N
   qW4/OT6ZG0xtww1TSWe+iAG9DixBzU+GSsqMCSH0UH5Nme6Yp+IzjiOjN
   45IBnnzkSZODiy75QyO7+i5X3DRo6do0bij/eo7VFtM+PssFekX0hll9/
   +IxVlAF9g5BPOL7Tu/fxN3eUmqpoNQHQ/fRQxwmSpIBvOakQMbXXWE36V
   g==;
X-CSE-ConnectionGUID: a3M1ZvDuTUesLhjP+91v1Q==
X-CSE-MsgGUID: Y5FAZLtaS+yhBZxfL3pW1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56338847"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56338847"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 13:58:13 -0700
X-CSE-ConnectionGUID: +quO6Z0WSxGURjzqz+HRSA==
X-CSE-MsgGUID: jr+XQQT6SEe/X55XtWmnZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="181157303"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 13:58:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 13:58:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 13:58:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 13:58:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEEaVreObXLmue/AxTteXzJPe1M0BJ1aAfW+MKfsBlJmYBnKDIvn1eurLWGxDNbPok6xai4Q9vFVEdYK4CiM3FUGcr8UfdXOXIjrYfzFaWfYjEqL98yvALWENdRG5/umDErsg7BgXquRd+wYUPb8vBwZ4FE3TKAFO/3Ly59c39T2yl+aiwAWHy4vfiy/bpiGv5EPXnhrCDagA3vVl6twBg3ZC3Nn8bezliwmOn7YnqKYN0dU2PVnJRwi+tiar4NLv+iHFTR/ENcscGNH2APNv/RpDVfst1mWGGFZM8sDGxcmsJdokaNqwo8u8H5bGx/Hmc4ndeSIzYZLUCuZ2eZYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vNcuK4BZrYLGLrQl/wrKrfG/lzkvbAfyR/+waNKPAw=;
 b=mIFgq1KrC+M9xQQpId/5csob3y5W9A3gibmxjfgrux/JYLMUwwPwqFhNTBcHUnJPg5rId120VlRlJiEU6TO6pYpbpU1I2nJDkcD+ApmtasLvUqGJIWRsjZXWsxmnkmaCH+qFEIhUkH/VxRdbyOeh5qkukXbuVwcgnICAp/EbfBYIOGtU3hL4sBFkMOWdz6fZfb5WjAO7eDmRVbVBR4yBGI87A9D1yD/xdSbiLckkEs6IG0zCIcOLGHa+IeQLV1fbGlTxTSRpfXKFjXcnCO8n73S+LOD2fQB5bzatH08A9lNwsoYxtoqw910dtEZEaNIPrJfusNYzmUG1aa9RvCGTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 20:57:51 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 20:57:51 +0000
Message-ID: <ed40e9b2-8a6b-4b7c-8c42-80b087314679@intel.com>
Date: Wed, 18 Jun 2025 13:57:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] drm/xe/xe_late_bind_fw: Load late binding
 firmware
To: Badal Nilawar <badal.nilawar@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rodrigo.vivi@intel.com>,
	<alexander.usyskin@intel.com>, <gregkh@linuxfoundation.org>, <jgg@nvidia.com>
References: <20250618190007.2932322-1-badal.nilawar@intel.com>
 <20250618190007.2932322-6-badal.nilawar@intel.com>
Content-Language: en-US
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <20250618190007.2932322-6-badal.nilawar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To PH7PR11MB7605.namprd11.prod.outlook.com
 (2603:10b6:510:277::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7605:EE_|PH0PR11MB4792:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2873f6-521a-48d6-57ed-08ddaeaaca01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0VJL0hDUkZjNmNQOE5DVUJEY3RIRHYveWExTmNRS1Y2MXlGRnZqZ29zaGVx?=
 =?utf-8?B?SGlwT0FwZ0dSU3RGQzFpd1drL0ovUENKbzZpd2NrdnBTd2FmUUJock1KTTl3?=
 =?utf-8?B?Sjd0aCtEOUlnOW9BUWlMM05yZUFMZ1oyZklXUTVjM090QXlpNUJnc1prVVFI?=
 =?utf-8?B?cTdOeHN1WXZNU0wralFoc0RFNzRnYjA1UG9KSEh6VVNGaGlRSE9nbDFKamJs?=
 =?utf-8?B?cHZ3cGxQeTdpTFJkY2xOSXFEN2oxazlsSkFpZ21jL1NJTTJDSUVRdFJ5RVEy?=
 =?utf-8?B?Z3FnbFBvUkZJMTdvRHRCMDIzZVFGOStrOGdDTzQybmlxcUJ6QU5PK21Hc3dx?=
 =?utf-8?B?eVJPODVKUnl2L2xqUW5ZeW9ObG80S0Z0SzYzZlBqWVlBZHhxU0lWZHNFWjNu?=
 =?utf-8?B?b2RCMHNZQSs4ZmJWdFRaajdyMkllTEl0T1VCT1FXaWtWVW4rRzNzdmYvdENE?=
 =?utf-8?B?akxHVTZNZTZ1RURNL0g4aUtZRlFsbXIwYnlPbmNQdGNVeUgvdTF6ZVMvVE1B?=
 =?utf-8?B?cU5UOHdkOGJMRTY1eWpoaHNPSUdDcmpVUUZzQmhtM2hhdFVIS2NKU29LdHho?=
 =?utf-8?B?UVg3Vk8yZzhlVnhpYkFNeGQyWGRNSER5MHkwK2lSNW9YL3ozSDVrdklybUZx?=
 =?utf-8?B?T1JuRXg4V1VmdTNCYXltUVgxUEl4d2xJYkl1TE9JNlQ3ZUZyYVlZeXRRMXRL?=
 =?utf-8?B?Q2xSRnI5VThZaW5zQUhQaXBjd1ZyMWtReHBFdERSbWxGY3ZvVHZ5SjVDbkUv?=
 =?utf-8?B?c0UwMzBJbEhmRWlENjJMeFh5RDVjWEVSTklpeVlUR0k1SDFnbUl2b2tObllt?=
 =?utf-8?B?aFkyODB1aEZpb2FUM3NwWUFyNEp6UEd3K3daQnY5Y3BBWGtXVU84K0ozdjRi?=
 =?utf-8?B?QjVXQXo1b0dQclQ5NjE4TW9OamZRMTZrOXFzSnQrdGZjOHhPaTA4THZ0YVl3?=
 =?utf-8?B?MUFlUjc2dWRpYW4yY0Jtd09ONHozeW9vaUdTeU82R29vbzRuNEVzUHpNUHVZ?=
 =?utf-8?B?L2d1UXRMTThFRUZ3a2EyN08raGFVK0pMYytpMHpVUXUzcnF2VmNIS3NCWlQx?=
 =?utf-8?B?SllET1hRMFJtOE5YMHNkNjRaNTZPaldjZXNwRTRSV1h2WndXT3AzS05waTd2?=
 =?utf-8?B?b1FqOUxKK2NpQ1VYWXg3MkROR2kwV1pJVG53dkFkUGZ2MEV4T1hjVjNCcHJv?=
 =?utf-8?B?cUplTElqN0xTdERzYWRoUHRGckNPeUpWN29SaGFSMXNNTHcrK0RCWWRZM0J5?=
 =?utf-8?B?QTdoY2ZjdUhxdEFPc0FnZkt0OUVNaDRzb0FtOEloTHU0ZFFGSUppSDE3TXhC?=
 =?utf-8?B?cndtbDlyVTNYcnpyN0VWSkdWQzRSWDB1eFpNUzhCNTBDUVEzN3VMMVJaWnV0?=
 =?utf-8?B?RFpsTmR6QmxyN0VIdnBldHZBLzN2azJVZUx6Z3FSaGlmOVZLQ3R6elZvM0Vz?=
 =?utf-8?B?RGhibmtjRVRqL0UwbkpVWmM0eHRqUXluOGlWbis0MzV3ckFPUjBIdnJCSUxH?=
 =?utf-8?B?VmRwRXlXVEIycm9oUnRZRzM4YjlKRkZodUdmamMvZm9vYjF0K3NTdjM1aGUv?=
 =?utf-8?B?VXF0WTRjaXYzV2FYWDN2U0NlTWxRT1Z1VTBUVmYwYWRyOFpGbTRibTc4dVQw?=
 =?utf-8?B?d3gwWExGcWdyQXcwcVk3dEhYUzdKM0pyMWFXSG9OYjA3eW8xaGt5R00zdk84?=
 =?utf-8?B?Ulp6SGhGQjNHZ3k0RGd1dDlTNWIxTjdWazdSTUhvL1NkUmtyMy9xMFduZUJU?=
 =?utf-8?B?QzVFZVNYa2x6M1FqOTlJY1JYMW9FUlF2N0paWkFZR1RFaHMybG56WXRUeVpH?=
 =?utf-8?B?RW0zWU9rUS94SXgxMkhRdGtFNzgzMEYwWlFSUU9xc2x3Z0NkN0FFQUVzYnhT?=
 =?utf-8?B?WDRTTVBNMk43dUo5NytWeGtvWEw2em9RdHIvUm1Ud0pPZlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCt5QVlvMDVmZ1JiM1NKb3JDMTcvSE8zc2FaMkRjVHRhZlhtTDFSa2xVbk9L?=
 =?utf-8?B?MVFYOGZrbjJFQlhVemtkV2tPeDZzVStmR3VYdFJPTUJzbGJhZHVRelViNXFX?=
 =?utf-8?B?ZEpkNDJqRUYrVzRTMHlZS1I3Z0dMdlBENFJXRFI4R0FDc3hza08yTmw5SGlw?=
 =?utf-8?B?Q2p2QTk5b1dTU2NtUUw4aDV0QkVnYkhleUhBeWZGSStmUkdjV2kzQnlkQ0Fs?=
 =?utf-8?B?ZUZaZ0VJZ0V6ZTdrMnA3VG9CTlNKMG1lQ3dzVDZSNTRTNDBiVmRPTlU4cFcx?=
 =?utf-8?B?NlJBclBJY21NK3pxZk5uVXNqZ1EyYzQrMlVKZWovYVY1a1dqNlZZK1pkbXp3?=
 =?utf-8?B?WkZBL0oxNDRpSXpzcE9rSmROdThJbXhSVFpxOVhZSnk3dTJ1SG5xRWRrb0sr?=
 =?utf-8?B?ZzRLZW1HWS9yT0tSQlNIVm03d2kzUUs1QWVheGJlQU9YQ3htTVc2M0FwRWFn?=
 =?utf-8?B?TkgxZXNoNUYyaU1xaXJYdXJwcFVtbFBaSGhPL1FvQ1JKWTMxSitlZEZaeGkw?=
 =?utf-8?B?eXZTOG1tUk1meUJZR3lKYUphNWNCYW81dXpORlVZa2ZId3FTSUo2dGRGVUlu?=
 =?utf-8?B?ZWZ6UHViOXF5UnNtbGhjZ1E2K1U3eVFCYVBZWVAzeWdQZncwZmtnWnRGUUNj?=
 =?utf-8?B?T2ZnWjJIejg3YzBOUkdoNFBvaU0ydlZ3aG1sUGt1dGtFRWYrYmlUb2NJRjQx?=
 =?utf-8?B?cWYzU0JhV0hFcXpzNUZ0SGFuQml5RytNQTZwNXBHOS93Y1pHQkdNZDAyOHMr?=
 =?utf-8?B?NXlUUUY1Q1JaclI1SVZHWFlxakJYZys0TGZtaWo0Y090cXpoMjRicWdBRXpZ?=
 =?utf-8?B?YUhzeXdaS3ZDaWs0SXdQdllmWG9jVFF0YzErdmdYS29kVFIzUE9DVmd6dm9z?=
 =?utf-8?B?RWFiaDZpNFVxV1J3d0JsKzhxemZqdlFvejNxVElEN0dtMGl3KzJQVWpRbk5a?=
 =?utf-8?B?elJjTFhEbk5EbUJHUFhOK3EwL3dnWW9kbDhBZVgxODRzMHAwWFV4SzMrMjFo?=
 =?utf-8?B?UC8wZVdSblpPNTlNQjZTZEFYMVJiSkY1Unc1SzNWUW9iYWdpU0YwUXhlaytx?=
 =?utf-8?B?QzkvSU5KY3NBcTRmbTkrLzRMN3FkV0lpZEdaOUJYak5WZVh3QmRvL2RGRUFE?=
 =?utf-8?B?YlJkT3FwS3ZJa3YzQTlSNDRCVzRucC8vb04wSm5zQzZwV3oybzEyOW5yemsv?=
 =?utf-8?B?a2ZwZFI5bTN3R3pQZ2F4NkNJWU9oM2VVMGZTUDZjdlhxUU40UUMzRWxXK2tu?=
 =?utf-8?B?YnZlY0Q0L3hieWpBdWpkNVJrSERoWHhDS0NSZHdiNHdPTHpISXVNSFRFZmx0?=
 =?utf-8?B?NmFFeWJwRUR4L3NOZ1JsUlNsRWJBcEFtMStNZTVBQ09NdXQ2RW1jR09ua0hs?=
 =?utf-8?B?MzJIS1BCdnlNNERpL3RmYkRrTnNOSWcyTm5GdVNCNnJtdWhuanZRT01XdTdy?=
 =?utf-8?B?UTFQQk96SlBNTWNUV0Mvc3o3TXdrR3FiM0g5RTljc3FmdHNrRVovNXpYVVM5?=
 =?utf-8?B?enlrSkxIWXRqM0lGbUdtVjd1Q3puQ293WUVzaWUzcnorUk1qTG9EcFFjRGxH?=
 =?utf-8?B?clByOWhYZmFxYlhXR2ZQV05iaHlJb3BtM1Y2Yk1SaGdiWTRxcWxGOGU4VE05?=
 =?utf-8?B?OWZjR0kvVHExQU5TUnhpVHNMdDdwbE5YN2hhV0x4RDVFdnhDNUE1dDcvYk1T?=
 =?utf-8?B?SVgrTmE1eENzRWtYWTN0dkRQb21zZzlBUXFiR0FHUzVQSk16Q3dqdE5JN1B0?=
 =?utf-8?B?bG5kOW1XRWdRL0FrNStGb1dYNVd1emE2eXhlY2kxY25MNFBjelhmSlFSVXhU?=
 =?utf-8?B?UktXMlZZNHJ3ZzZzdjJkaG9jLzZtY1lTazUzTXVEZytiaVMzNWRFNHpDS05P?=
 =?utf-8?B?K1RWTmxDdnJTeFRsZE5NL3d2YjlXL0xXaXZUZDdkRFRxTVU2T2tBWEZ1Uk9j?=
 =?utf-8?B?S0szSmd4ZFlhTTArZEdxOUJOZ1VJcjJCQ2UyUDhLU0ZCUzRuRzNOWUMyWThl?=
 =?utf-8?B?aENhSVQzSjFDa0FqTDRCUGd0OW15MHE0YS9DUWR1WDNiNE5Gc05CZUxoYko1?=
 =?utf-8?B?ZVhqOFRqbGdhcFZLOEhTamRVYkkyVUp1b2YwNGZLTms3TDhFSC84N2t2ZjYw?=
 =?utf-8?B?bC90OHNOVnpBTFJydUU0TjZsQnFOWHNGZ29zVEpYeTdMRjgwY3R4bVQ4WTRa?=
 =?utf-8?Q?vYykAVElRw5gqFyHRFj6t4k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2873f6-521a-48d6-57ed-08ddaeaaca01
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 20:57:51.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we4pPgH7lMSN465Oe3pllEL4K75LwM2fimafNoBKQig9egGnqheVpriFwDAmgWAfV548Cqxfp6HGGIP77UjXYWTkWauZx4F8CN9uuUlwb6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4792
X-OriginatorOrg: intel.com



On 6/18/2025 12:00 PM, Badal Nilawar wrote:
> Load late binding firmware
>
> v2:
>   - s/EAGAIN/EBUSY/
>   - Flush worker in suspend and driver unload (Daniele)
> v3:
>   - Use retry interval of 6s, in steps of 200ms, to allow
>     other OS components release MEI CL handle (Sasha)
>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_late_bind_fw.c       | 113 ++++++++++++++++++++-
>   drivers/gpu/drm/xe/xe_late_bind_fw.h       |   1 +
>   drivers/gpu/drm/xe/xe_late_bind_fw_types.h |   5 +
>   3 files changed, 118 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.c b/drivers/gpu/drm/xe/xe_late_bind_fw.c
> index d416d6cc1fa2..54aa08c6bdfd 100644
> --- a/drivers/gpu/drm/xe/xe_late_bind_fw.c
> +++ b/drivers/gpu/drm/xe/xe_late_bind_fw.c
> @@ -16,6 +16,20 @@
>   #include "xe_late_bind_fw.h"
>   #include "xe_pcode.h"
>   #include "xe_pcode_api.h"
> +#include "xe_pm.h"
> +
> +/*
> + * The component should load quite quickly in most cases, but it could take
> + * a bit. Using a very big timeout just to cover the worst case scenario
> + */
> +#define LB_INIT_TIMEOUT_MS 20000
> +
> +/*
> + * Retry interval set to 6 seconds, in steps of 200 ms, to allow time for
> + * other OS components to release the MEI CL handle
> + */
> +#define LB_FW_LOAD_RETRY_MAXCOUNT 30
> +#define LB_FW_LOAD_RETRY_PAUSE_MS 200
>   
>   static const u32 fw_id_to_type[] = {
>   		[FAN_CONTROL_FW_ID] = CSC_LATE_BINDING_TYPE_FAN_CONTROL,
> @@ -44,6 +58,85 @@ static int xe_late_bind_fw_num_fans(struct xe_late_bind *late_bind)
>   		return 0;
>   }
>   
> +static void xe_late_bind_wait_for_worker_completion(struct xe_late_bind *late_bind)
> +{
> +	struct xe_device *xe = late_bind_to_xe(late_bind);
> +	struct xe_late_bind_fw *lbfw;
> +	int fw_id;
> +
> +	for (fw_id = 0; fw_id < MAX_FW_ID; fw_id++) {
> +		lbfw = &late_bind->late_bind_fw[fw_id];
> +		if (lbfw->valid && late_bind->wq) {
> +			drm_dbg(&xe->drm, "Flush work: load %s firmware\n",
> +				fw_id_to_name[lbfw->id]);
> +				flush_work(&lbfw->work);

incorrect indent here for flush_work

> +		}
> +	}
> +}
> +
> +static void late_bind_work(struct work_struct *work)
> +{
> +	struct xe_late_bind_fw *lbfw = container_of(work, struct xe_late_bind_fw, work);
> +	struct xe_late_bind *late_bind = container_of(lbfw, struct xe_late_bind,
> +						      late_bind_fw[lbfw->id]);
> +	struct xe_device *xe = late_bind_to_xe(late_bind);
> +	int retry = LB_FW_LOAD_RETRY_MAXCOUNT;
> +	int ret;
> +	int slept;
> +
> +	/* we can queue this before the component is bound */
> +	for (slept = 0; slept < LB_INIT_TIMEOUT_MS; slept += 100) {
> +		if (late_bind->component.ops)
> +			break;
> +		msleep(100);
> +	}
> +
> +	xe_pm_runtime_get(xe);
> +	mutex_lock(&late_bind->mutex);
> +
> +	if (!late_bind->component.ops) {
> +		drm_err(&xe->drm, "Late bind component not bound\n");
> +		goto out;
> +	}
> +
> +	drm_dbg(&xe->drm, "Load %s firmware\n", fw_id_to_name[lbfw->id]);
> +
> +	do {
> +		ret = late_bind->component.ops->push_config(late_bind->component.mei_dev,
> +							    lbfw->type, lbfw->flags,
> +							    lbfw->payload, lbfw->payload_size);
> +		if (!ret)
> +			break;
> +		msleep(LB_FW_LOAD_RETRY_PAUSE_MS);
> +	} while (--retry && ret == -EBUSY);
> +
> +	if (ret)
> +		drm_err(&xe->drm, "Load %s firmware failed with err %d\n",
> +			fw_id_to_name[lbfw->id], ret);
> +	else
> +		drm_dbg(&xe->drm, "Load %s firmware successful\n",
> +			fw_id_to_name[lbfw->id]);
> +out:
> +	mutex_unlock(&late_bind->mutex);
> +	xe_pm_runtime_put(xe);
> +}
> +
> +int xe_late_bind_fw_load(struct xe_late_bind *late_bind)
> +{
> +	struct xe_late_bind_fw *lbfw;
> +	int fw_id;
> +
> +	if (!late_bind->component_added)
> +		return -EINVAL;

-ENODEV instead? This should only happen if we don't support late_bind 
or if the component was not built.

> +
> +	for (fw_id = 0; fw_id < MAX_FW_ID; fw_id++) {
> +		lbfw = &late_bind->late_bind_fw[fw_id];
> +		if (lbfw->valid)
> +			queue_work(late_bind->wq, &lbfw->work);
> +	}
> +	return 0;
> +}
> +
>   static int __xe_late_bind_fw_init(struct xe_late_bind *late_bind, u32 fw_id)
>   {
>   	struct xe_device *xe = late_bind_to_xe(late_bind);
> @@ -93,6 +186,7 @@ static int __xe_late_bind_fw_init(struct xe_late_bind *late_bind, u32 fw_id)
>   
>   	memcpy(lb_fw->payload, fw->data, lb_fw->payload_size);
>   	release_firmware(fw);
> +	INIT_WORK(&lb_fw->work, late_bind_work);
>   	lb_fw->valid = true;
>   
>   	return 0;
> @@ -103,11 +197,16 @@ static int xe_late_bind_fw_init(struct xe_late_bind *late_bind)
>   	int ret;
>   	int fw_id;
>   
> +	late_bind->wq = alloc_ordered_workqueue("late-bind-ordered-wq", 0);
> +	if (!late_bind->wq)
> +		return -ENOMEM;
> +
>   	for (fw_id = 0; fw_id < MAX_FW_ID; fw_id++) {
>   		ret = __xe_late_bind_fw_init(late_bind, fw_id);
>   		if (ret)
>   			return ret;
>   	}
> +

nit: this newline could be moved to the patch that adds this code.

>   	return ret;
>   }
>   
> @@ -131,6 +230,8 @@ static void xe_late_bind_component_unbind(struct device *xe_kdev,
>   	struct xe_device *xe = kdev_to_xe_device(xe_kdev);
>   	struct xe_late_bind *late_bind = &xe->late_bind;
>   
> +	xe_late_bind_wait_for_worker_completion(late_bind);

I don't see this called for full suspend (not rpm), even if follow up 
patches. Am I just not seeing it, or is it missing?

Daniele

> +
>   	mutex_lock(&late_bind->mutex);
>   	late_bind->component.ops = NULL;
>   	mutex_unlock(&late_bind->mutex);
> @@ -146,8 +247,14 @@ static void xe_late_bind_remove(void *arg)
>   	struct xe_late_bind *late_bind = arg;
>   	struct xe_device *xe = late_bind_to_xe(late_bind);
>   
> +	xe_late_bind_wait_for_worker_completion(late_bind);
> +
>   	component_del(xe->drm.dev, &xe_late_bind_component_ops);
>   	late_bind->component_added = false;
> +	if (late_bind->wq) {
> +		destroy_workqueue(late_bind->wq);
> +		late_bind->wq = NULL;
> +	}
>   	mutex_destroy(&late_bind->mutex);
>   }
>   
> @@ -184,5 +291,9 @@ int xe_late_bind_init(struct xe_late_bind *late_bind)
>   	if (err)
>   		return err;
>   
> -	return xe_late_bind_fw_init(late_bind);
> +	err = xe_late_bind_fw_init(late_bind);
> +	if (err)
> +		return err;
> +
> +	return xe_late_bind_fw_load(late_bind);
>   }
> diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.h b/drivers/gpu/drm/xe/xe_late_bind_fw.h
> index 4c73571c3e62..28d56ed2bfdc 100644
> --- a/drivers/gpu/drm/xe/xe_late_bind_fw.h
> +++ b/drivers/gpu/drm/xe/xe_late_bind_fw.h
> @@ -11,5 +11,6 @@
>   struct xe_late_bind;
>   
>   int xe_late_bind_init(struct xe_late_bind *late_bind);
> +int xe_late_bind_fw_load(struct xe_late_bind *late_bind);
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
> index c6fd33fd5484..d256f53d59e6 100644
> --- a/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
> +++ b/drivers/gpu/drm/xe/xe_late_bind_fw_types.h
> @@ -9,6 +9,7 @@
>   #include <linux/iosys-map.h>
>   #include <linux/mutex.h>
>   #include <linux/types.h>
> +#include <linux/workqueue.h>
>   
>   #define MAX_PAYLOAD_SIZE (1024 * 4)
>   
> @@ -38,6 +39,8 @@ struct xe_late_bind_fw {
>   	u8  payload[MAX_PAYLOAD_SIZE];
>   	/** @late_bind_fw.payload_size: late binding blob payload_size */
>   	size_t payload_size;
> +	/** @late_bind_fw.work: worker to upload latebind blob */
> +	struct work_struct work;
>   };
>   
>   /**
> @@ -66,6 +69,8 @@ struct xe_late_bind {
>   	struct mutex mutex;
>   	/** @late_bind.late_bind_fw: late binding firmware array */
>   	struct xe_late_bind_fw late_bind_fw[MAX_FW_ID];
> +	/** @late_bind.wq: workqueue to submit request to download late bind blob */
> +	struct workqueue_struct *wq;
>   };
>   
>   #endif


