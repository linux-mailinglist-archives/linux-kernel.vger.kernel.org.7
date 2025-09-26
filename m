Return-Path: <linux-kernel+bounces-834433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFDBBA4AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF99116F222
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7EC2FE580;
	Fri, 26 Sep 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRD2cmID"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCDE229B1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904744; cv=fail; b=rS5L9vHikuI+yOpTK9v+RJzLIP+xDZsZ99enUBxrxPVV85HlrSbBbpokhhoYNFGI6kFiBGXKhjGGVzTQlSPzc3D2GHj6ihoR9A7dvIzg+r9b190pApYA8wW8OklQ53PbtTVMeLaPWJ8hORbwd30XClzQQIjxclDQOrmgOsWpz8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904744; c=relaxed/simple;
	bh=hVPxRH2exikT5Nt7sfbgaqKMfGQEtQmLzsSy9Zf4WoY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLxqhtNDPVo15HYtPWpUmpPQz6fNlDYwjP59cXprUVxEcb/vX4V5zkoq1agmF8STDvV74aMFeM5AIUkELWgD8Oi/o5sG6th22OE9QKyEn3LU4R3EiZVFAXsxfgszg/M1s/YAwSfETR688rTFsE8pvQT3cUYaERvFpGl7UDkl4aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRD2cmID; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758904743; x=1790440743;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hVPxRH2exikT5Nt7sfbgaqKMfGQEtQmLzsSy9Zf4WoY=;
  b=PRD2cmIDwvv2SUXYkF6DMrs7ibO6UJn8KILHzqn3zaDTSxbpem4nS6+S
   y3oCo31M5GvanL4XbLrTC7M8PBIwVhUYxmejxiB4lBXLYrdD7rdV5Q5ii
   hrB8T9y/cjqcyT6gjdyzAUBOCzGLN0YIY8qdYdf+gXQAIegPuN+NGX4KM
   GB2TjgLHwqwGtmM27yjnAAVkZyMzGwaVwZ6OLKt+PkM+NvJCEmwBwhoIy
   smnlj26uCkfLyaZUhcfgtKbYkiQLxl4mNBs6jdSYXBqT8C5A/NoVKzEWp
   2mVXaZrw1bbU7NtxrJdDlqKG3XkweeaxJNTmM57ERj01GY6Srl6UIl4+1
   A==;
X-CSE-ConnectionGUID: KHMvc5UmSgCHiQ92E4tcgw==
X-CSE-MsgGUID: RNtnAj9kQ1iTyVM1NQnPvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="72337979"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="72337979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 09:39:03 -0700
X-CSE-ConnectionGUID: Z48PsfMRRZmiDT6yiaK93Q==
X-CSE-MsgGUID: AvQVuxRmRxWBiDZVPCsR1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="178412447"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 09:39:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 09:39:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 09:39:00 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 09:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqC6oGo5Jmi0/U6rOGh4id/Kp2hO0Wnlg5uItvT2Jj91Mihm7hlECSwxDFwHCUynZNhNp/4NrOgTdQvSDcFOHeGOwERk9oxTSHy3KUgn4GdB/K8/3rDJ0lxYA3d68Sdunkvzve3/Isn7dk40Q9bGt8oChS5fNDIUy1et4mWKO+QMjV3Sb9MqtQT4DwnkKxFt+0Vo5xSfvVLqH+KTNjBZXx5V+3shn1wDP61LWxU4BfeesAMw5bzfouktxJvPzKL7diIWCGhS8u5eg0MMHDk3uGXUbGYQbeBhrQiji449sqHQN9qouwCeplfDRTrmT+64wngeZEH7ZuZCuH/Eh5vHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8svpou2W2ab6pcLgfaz5+ZFtzZyHSCUOjfd1aqXVyPs=;
 b=s1YDWrT877Mm8mr/cfvChZYvslS6gnGkhg8cqUTVLjicXJQwY4CvoIlLPnXPhZbDfFatlPGpQpn45QT/ALxMYjlLPcDZhR/m+6X94svtFD8TV6IJk3S9Qvj0xGDZ5eK36j/9xDcClmGuvu3VNQzFKrFp95rfJAc1gNtjhAIATAXLDm5gEJp/uyTwmSL51rdG5PJcCz9wMw1CvpS+S5AM2b3n+D/vh4+PGrGYiy7w/Q9OHP9BUTTpHxLZaTn6q6dRdXVuEP3h0yFsQnTywmoOQtuFQgo1qr6CyofHDDsFT0Q0nmtnkz49YpXmPeq5tMrdXFGSG1HQHDEFucRoH4QXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW6PR11MB8438.namprd11.prod.outlook.com (2603:10b6:303:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Fri, 26 Sep
 2025 16:38:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 16:38:58 +0000
Message-ID: <cbb0369b-697e-4a44-a573-86ccce04025f@intel.com>
Date: Fri, 26 Sep 2025 09:38:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Support Sub-NUMA Cluster (SNC) mode on
 Clearwater Forest
To: Chen Yu <yu.c.chen@intel.com>, Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghuay@nvidia.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, "Drew
 Fustini" <dfustini@baylibre.com>, Dave Martin <Dave.Martin@arm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250926041722.510371-1-yu.c.chen@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250926041722.510371-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:303:2a::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW6PR11MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5e8483-8a51-4eb1-52d0-08ddfd1b30d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXpxeFZPQ3VxbG5CT01teVFaYjl2eXRUSXV3ZEduRU1KcHJmZjhtcU5WQUxM?=
 =?utf-8?B?djhDQlA1aWROL1NVTVMzMVQ1UXl6Zk02R0RoTnlNRjI3VWFJLy9tK0N4UnZv?=
 =?utf-8?B?TWNaUEQ4U3lKcENxUW1IZTBOZFdFSTRJS0Q1dE0yZHVtYXN4bGlQUUJoUVpq?=
 =?utf-8?B?ajhtMVZ1eHFYYjJLbjRyUWt5Y2pFUTJmSFg0YUxpblJDR3luYlk3RXdVenYz?=
 =?utf-8?B?aTJaNUk2cXpnZ2dheDNtU3Q4MllBTFdXcU1YaXJOZTI1M2haM1hRZVdEN2Fz?=
 =?utf-8?B?aHZpMDdXQXRIYlYxYmJXSXdhZU5tTFQ5SjhneHFJNW0xRDRFaWhhWks1aTFu?=
 =?utf-8?B?WnEyTnRHYzNQcVQ0anBJOXl4dFd4L2cwYTFDdjFkYVdLSXNZdUVwVVZodXc2?=
 =?utf-8?B?V0FIelJHcWpzOUZlVGxwUUhaaWNpZ0RvbXlPSFRhUkFsalBVcktrS0htamM0?=
 =?utf-8?B?UWZVY0pqYkthbjZGMUFCSDBKZFdrNFZjUGc5R1RZTVhqTUU4UlZUMXVTV25W?=
 =?utf-8?B?MzlmN1Fjby95QVdLeFgrREVsRmI4Z2ZBLzIxenhNRkU2L1AzRFp5Q2lGa01H?=
 =?utf-8?B?Z3ZFdkwyV2Yzay9JYVJjaVVlNnF5cUF6WVpoYmxrL0NzaXp3S2VGQkVMdXlX?=
 =?utf-8?B?eElhR1ovTXFPb2pjaGVsdUwrY1pzR0dVMVg2TlV5cG9FSEhQdmNlMU11WU1B?=
 =?utf-8?B?SFMxN3RaQ09hazRWRzY4TmgyTU1YUmk0Mitta05hSERJRDd1alUrbFdiaWlB?=
 =?utf-8?B?SGJ5YlBXRWJTMVhkTGtNVDk4R1hGY0N1ZzlhYm1kRWdTK20vNkkzMTR1UW9w?=
 =?utf-8?B?c2ZGSFRQTExidlgrUzJpU0haS1RwYm52WHpFbXRrdDh5RDZENnVOVm5wK3R4?=
 =?utf-8?B?dVRzU3BuOWVPcWpJaE8rWS8wdWs1RDhscXhuRG1zdnJacE9SOEhSUnYzUUwx?=
 =?utf-8?B?L0NOOFNlS3dMR0x6R3BZd3F0UGdsRkllUlpQdnFoNExDQi95S3ppeVFtM1Uv?=
 =?utf-8?B?TVA1Sy9sUWc2ZHN6NzJwWlJqdCtNbUJYOHhNKzJhWTd3czdDdHJVQnZKUHFQ?=
 =?utf-8?B?K3Q0OVA3bTRkaWJDSDZqZGNjRksyQStpLzhHM0JIM2FoSDVHUndSU2dSLzVT?=
 =?utf-8?B?Q2ljUTk1OUwyN0Y0SHpHNytlNHBhMSs4RUVmTndDdGx0QXRyUnlyQnZIRGRr?=
 =?utf-8?B?aWt2QnlHVGlFTmhBbjZJWEN4OE9QMU85SnpPYmJsLzFmSjQxa2hvYW9taTQy?=
 =?utf-8?B?SGFwM0hTRzhIYklwUGlRVGZkODdwZWpPZFVqN1pUOFZLclNoMTV6UVl2NlZM?=
 =?utf-8?B?aEZReWxSMVJTbnE3RWI3dVBzcWlKeGpad2JTNHdDcjNFcVN4RE1tbHZRcHZL?=
 =?utf-8?B?ckh6Tmk2UmMvaXcwMzZkQ3pTNmhaTVNlTHdQbmlzQXY3TGlGZjJDdlltOTVz?=
 =?utf-8?B?aEQxSXVRbjUwV0l1UTVRaWc2ZEpUMk1LWWlLbWwvTzE2YkJQVjgzWi9GMTQw?=
 =?utf-8?B?R3J4UVJOY3o5S0FwZ05zdVJNWSs0bmp5d2kvQ3hkdy9qaHFvMHhva3UyR25h?=
 =?utf-8?B?UXc4RllIeU9Oc1lXM2pwUXg5YVZKY1V1a0ViSzJuZzY1NDZQd2VuZkxoQ3FY?=
 =?utf-8?B?YlBuRWFDMjk4UC9PTzBrMFkyYnJWR056NllWaml0ZTNmbjRocFVQMFcwQW1E?=
 =?utf-8?B?VzNjc09VYlp1d0gvSE1qbzFOVW92ZWNxbnc4U1BnQmcwcEQzYWFySTRPcVZt?=
 =?utf-8?B?ZW9YeWI2WnhFRHRkTXVFSEpBdndZS1BjNHNRRVRDUzlzaDBnSTJBWVVEMGpE?=
 =?utf-8?B?WW1kQVNjSzQ0a0JYSkl4RzE3eWtZSEFKb2pTSktkcTFadW5JSEl1elJxeFNt?=
 =?utf-8?B?OGZYS2hLVHhBcUVKYTVHL2dEQk1YU0UrWE1pZU5PMFNEeVRrVndFZWhZWUlR?=
 =?utf-8?Q?S62F1pjovde4TQ8aGxkuKWiW32p/l3hi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUM5bWFQTTNyV0M0R0g3NEZldm4yZE5LUGt1Y1oyQkIzWng5M1BxZERyVThO?=
 =?utf-8?B?Q0JTSk9QL2ZEb2Y0WkFQU3JWKzArVC9qR3d6S1NjWjF4dEJ4QlFVZnEyS0V6?=
 =?utf-8?B?WTMvUThoaUNrdXFXYVl2N2RZdWlrbllMS25rRUNMaEpRS1BWVjV1aDNSeUdq?=
 =?utf-8?B?dTBxOWVzRWk3QmtRdEVIektqTlZBR1RMRzBtOERXcFRJSEVMRkVtSjNYYTFi?=
 =?utf-8?B?YzIzQitwM3lWNHMxbklGZkt1bmFVVUlRYXpRTkF6ZzM2NWhQb2NJUythU2tV?=
 =?utf-8?B?OHdEa2JBaGkyL1pSbUhxa3RFMCs5Yld1OHBXOXFWeFgzTCtseTdXUFRzN1JG?=
 =?utf-8?B?Ump3SlJNRzJlTUFIMnBwOUFHOHh2Y0Q3eWE2a0RHQWZYVVlQejRBb3ZLbUpC?=
 =?utf-8?B?OHRGQ2hNb1dBYlNwaFNBMWV6YTV2MTJYb1hvZ212dk9mMmFLd0Z3Q3RZUlh0?=
 =?utf-8?B?ZllSaExtaUpPNmlQeUlqb2tDcDdkaENocjZ4Y1VDVTNJZ3p4bjlpVFJkZjc4?=
 =?utf-8?B?YlVXMlZOaHBrSTFJRWZkenM3VnE5di9uYWMvTlRuSFgxMHFRU0VqbEd4OHc4?=
 =?utf-8?B?U25nZmo5ckZqZUVCZk5DcW9lR21NL3VqZ09NU1k1V1VYYzQ3d3N5QWRXeE9m?=
 =?utf-8?B?WitNOTB0dVNDbmZ5OGIzcGo4TmpEbzZlaGNlMnBKalBrdVZoQ2RpcnNIVEhV?=
 =?utf-8?B?dTVFVmMvK2xoMUtwVXpiYU1weEUrdHBCNFdsOEY2aGRJVVhHZE8ydmtUNmoy?=
 =?utf-8?B?ckZOYm02RVI2VUJ0UDdGTE9QSEhLSGYwcE1NSHdQbjViVHBVaDl6L0pYalE1?=
 =?utf-8?B?bEJGbGt0TlZWRjZlTUpyZzBBc1M3OWd5NmZ1a2k0MExMT25tWDdXckl1c3Z1?=
 =?utf-8?B?YUNvU0JHdks3NUczTjVjOU5JSGJCN0psMzB6cndDOFp5cVNPNStqU0FyUnZh?=
 =?utf-8?B?R0k4dXBVekM2R1daTm8wKzlxU1grRlRXeFV2akdDdzBCZHdsMnF4MHQ2d0FP?=
 =?utf-8?B?QzlCc0xZOFpFRlZOdmFwcHlFRHZtTTdtNEtueCszbDN5TkVaVXlkM1E1RHNv?=
 =?utf-8?B?R1NmSXhrWGQ0aXZONXlaMUNxNnFPSjRUUXEyZGUyMi91RERmYWZCNzJCVUNT?=
 =?utf-8?B?VnRZM2pxVjd3MU1odXdnY01kTHdQWmhVaW5iWUJXdXE2UkJ2RWZBVk81bWpz?=
 =?utf-8?B?ODI5WktQZFpWa25lMVFSZkdFMS9abUE4eUczQkgyWUVUN0E1Y2kxbDJhRWIx?=
 =?utf-8?B?SWVGeVJMcXFRWUJScHZ6Z0VPeUpCNG5Zb0RjaVVwMlkyYk1QZjVaOXZ6a1dT?=
 =?utf-8?B?cTRJaFdMclYrUzZPUnZrbTdBcTlycjhvK0ZPL0kxY3VUM2ZFMHk2UWc5OENB?=
 =?utf-8?B?V1lzMGUyaGFpckhramg5eHFCNGhVWjd3YXRjT2c0WXBXdmEzUmoxU3JGYkMv?=
 =?utf-8?B?TEljNHR2QkFTQ2M1R0FuQWZMQWdMKy8vVkdvL2lRZ1JSWG9lU3hEUkFVdUFL?=
 =?utf-8?B?S2h4dHlBYnh5TytnL2d6RDhlYVRWaS8wak5reExha1BPL2x0eitwR3ZLR0ZC?=
 =?utf-8?B?UXNpVVhlY3pzWkkrUUZrMXdYd0p3SXNtVTl2ckNULy8zOHJRTUZOTzk4SDJ1?=
 =?utf-8?B?R2lJZE1IWDhzTzNwT1IxemtYVkp2MER5NGR2TDFqM1lML0JEYm8vaXVBZnIr?=
 =?utf-8?B?QTIwdUhDTXdYSGhuSWVTdHF0dEVaWkZLKzFJSEovclJYQ2w1MUt4c0s1cnlo?=
 =?utf-8?B?SnJqWUczZitEdjVVSHlKQmF0cHI2MjMvSE8wNk15S1ptSXk5WW94L1BxSklp?=
 =?utf-8?B?U0RYUFhSeFZtY29mdXhtT0FFZ0hFWmhNS1pOdG1LMllEakwrZDFxY3J2Y2lt?=
 =?utf-8?B?SG5ldlNDcEMrTWhYSFZIWC95VmRwY3FBd2FEZlBmeEI4SW5scnUyY3Z3YUF1?=
 =?utf-8?B?b0NXdS85a1A3Ly9Hc0F0ZnBCMm9MaHcvbEE5akYvY3JRSTF3RmtiK3hEVUoy?=
 =?utf-8?B?Ymxmd0xwWFZNbEZGTjFMK3FFUmlKVlFXYnM4NU1wSHlVdGoyYjNHUHdhVjh1?=
 =?utf-8?B?Q1BNYWtEQldYN3lpTFJlNlhkMnVKVWQwM1hWQmJRR25ZaHIwTGtCWVN0NWc5?=
 =?utf-8?B?a09waVc4dHNyV1lwdGNDTEx5cndpZXBGdGNGN0pweTRZaWFUaWh0Q2Y2SjlT?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5e8483-8a51-4eb1-52d0-08ddfd1b30d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 16:38:58.3111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQ16oIXjFLsd5V+UoJEqasAcUL1yyzgKgx9x0DOORbOVdTAUDo45UlAhJM8B/eN62ljD9vHzzqaJ3y1CFPH534QBQXVRqX8jU4SUH8lYE1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8438
X-OriginatorOrg: intel.com

Hi Chenyu,

On 9/25/25 9:17 PM, Chen Yu wrote:
> Clearwater Forest supports SNC mode. Add it to the snc_cpu_ids[] table.
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


