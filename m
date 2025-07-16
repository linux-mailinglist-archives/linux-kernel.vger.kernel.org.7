Return-Path: <linux-kernel+bounces-732884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C423BB06D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5313BDB39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629B02E7199;
	Wed, 16 Jul 2025 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qz2Qq1x4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C752E6D02
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644014; cv=fail; b=PDoHND6hKVrwdxZ6V0mUNB6jvJFNGKntCdyXN9q761jJqO1fM72xUL3aaVcX3sAhrCdPdkQ+ueiaQHFuaxnjgNH5l1N2UgfexrHQiguMoR9fP6xcRAwB/TzhIufQxNmylE94GhhF9zht7LbPF3rx49Z2YNvsQRKkokY+jVw6sKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644014; c=relaxed/simple;
	bh=6sJYIBxsh2jr13P0Et2iAmvyMytIhRd1zcNtTdfbkHQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lyecbRhukB2EQyXHi9A8xReoP3scYtdD54gJSkYOwXck0RR9KIsUeRU9IcgBHsXNPQun7bLDp/sEdiRmL71XwjaUAyP1pqu+35BhUBsKyGId5hlTAp80BqqdtxSc5QAmqaUxHPnxnxY3anOS7RO6MPcUYi/QJlX+E/Pt66jlvSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qz2Qq1x4; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752644013; x=1784180013;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6sJYIBxsh2jr13P0Et2iAmvyMytIhRd1zcNtTdfbkHQ=;
  b=Qz2Qq1x4xGp9iDNsG/RbSV62rjSFwsYt5mfLz60gmzx/r8TMVpkpqN9I
   lUdVjo0uflNcZ1ew6EPKZXkNiy8Lo/7TXP9sKYmpgafQFJLglK0dpeEgV
   Nxhy0KM1C4GgOo49WQWy8a2chT0jyqYurFqIMd1fzYI21zGcCdvFebiR2
   1DHsqyKNMVPHEozAsh2Ec/IBi4vwpHJk/BXS2zO+B8aMn8KWdzBspdPeQ
   vzI7XEQ0zPdW+Y3C3ejHVbrBuQcHpFYL/ubG0X+nmPazAjGHhThwLpf1N
   eVg1DJ5lmLlS+PNA33OmzKyM1lIgH6bSX6rnYooI7+1MvgM7mjKVH2cdk
   g==;
X-CSE-ConnectionGUID: Wb+YwqzESm2ughV00At6ZQ==
X-CSE-MsgGUID: TcLgBZX5SgmWTboZXO11WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="77409382"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="77409382"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 22:33:32 -0700
X-CSE-ConnectionGUID: k7QOnAMgRm2cXYu8AaybLg==
X-CSE-MsgGUID: so7S27lYReq+iumVAipRJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="156804714"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 22:33:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 22:33:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 22:33:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.54)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 22:33:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vH55BHkwHBoq0Ck5aJc4kVW5QcVd1OgVhl26ceQfVMn+p7VxaI92LbFHbFFx8yzGzyTs9iiDjnBdz3y8XdHV93eSiA98VW7rh+iF2LtfsrN0DJRxMzwb1UMUrXWnX0UzKytcEhe/SHmVB3FrC6poMYHA+dO+FjJM73k4d4jl1RNEgsalOSC0n21xIlvloAKE1zuUf3J/KTy0uVQjqeEJFTQhJm4Zb5RizYkecYU87BGKQyDxBdZhTtFyxn0fJUwajk42vNTtlBOarsUFz1adkfNywv6qMU1IHuiqqgkYoOgejg9epZhDYcoLQoLMgNIRtUNpb4YVddOBiSKKPhn2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9C8K3xgXt+EkLsydNe2yQgDPSqVP3WCw+O/r6XkLko8=;
 b=yjc1HWGH8MBRi4LFsva3bVnAY2g8pVSzbWR2fGdCZPB0FXRNos5C1VkAaOPp3fRPgdOsIg5Qra9hRWtOMbn2kdkJoci+rucmOg8FSYjFMTAjCAdFNWoCZaQeaVlyAlepk0+IVV8PHs34QPtKKiLOyPUTB8DNc/JVKTflSlVdEBuF+1qb9FKAjwOAI5iTaFwzWW3EJnbGm5//I6gIH3mbG4vLXP3BlBRCKOyBgt0OtBp1e+7iJeam3K7ULbPppC7PwPV7necmmxEqXv2RpGj6U+8QaVO9ABOBAJRcZhrrsuM9o7KiNBUnoTNeqneMwHpEPl63RlDyxAa8fmFsH+misw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 05:33:12 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Wed, 16 Jul 2025
 05:33:12 +0000
Date: Tue, 15 Jul 2025 22:34:54 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Karol Herbst
	<kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
	<dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, "Barry
 Song" <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu
	<jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>, Donet Tom
	<donettom@linux.ibm.com>
Subject: Re: [v1 resend 08/12] mm/thp: add split during migration support
Message-ID: <aHc5/pmNLf4e9brJ@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-9-balbirs@nvidia.com>
 <D129A3F2-D79C-482E-BC70-A26C781B149E@nvidia.com>
 <1a451d37-56c3-4d60-8e06-3abae72e6bbd@nvidia.com>
 <007E2728-5BFC-40F9-8B8F-25504863D217@nvidia.com>
 <aa4f94a3-f601-4379-b6ca-4389421ccca4@nvidia.com>
 <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
X-ClientProxiedBy: BYAPR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:40::25) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DS0PR11MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a5f22c-38b3-48e2-83a5-08ddc42a4162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qjd6QXFRMWVjV20rY0dJcXgxdUIvczhEY2lwZEt4azZxZDU4Nm9SK2lncml1?=
 =?utf-8?B?ZVB0cDUzUmR6dkptdzFSWVljZmsrc3l6ZEkyVUZkRHJZV1hGM1pFdUMrZE9n?=
 =?utf-8?B?RXVrOUlkbThJZStJU01weW9PQm14UlJhVHF2cXc0Z0dyZE42a2RST0o2bU00?=
 =?utf-8?B?blZrb0Jid2NsOWNidUR2eHFxVzdqYjlzTVQ3RzZNVjNvOW4yM0FmVlJpWkJi?=
 =?utf-8?B?ZmhXaHBTOEtHdXhCQnBYeStOd3lWOStqSTNSOW5YNW9TU0xPdFFydnVNY2R3?=
 =?utf-8?B?SVVSdzloelF5VVFPZXkzS25RNXA0NlNVSGxKcFM0dHpKNkhUSjFEVGd0Qnd5?=
 =?utf-8?B?cHBHVlJkd3VLbWpIOC9UL2VXclN3d2x6Y3JIMTBQa2tpSDNmdWoyQ0d5QmJv?=
 =?utf-8?B?em43bHZkT1E5aHpWcGttU2hKTHRyQmhUTnVMMGFxVUI1MkNJaUQvSXh6cmZk?=
 =?utf-8?B?b0hUNWNmT3NHbXNFTkduWlFmL3MwT0dxMEJyVEtaQ3pIVWpYYUxieTVsQlZv?=
 =?utf-8?B?UnF6YlV5ZzE4R1ZqSHVMYktIVWNaQm9kYlVwR3FQU2ZKOFlyYlpWV0xMNWYy?=
 =?utf-8?B?a1gzUEZxNHduNFZRZ3V5N3Y4VldIdmpUbUI0TXdmaDluRkQxeXM3d1NrNlZN?=
 =?utf-8?B?YnpJOFg3Z3Q1SmxVZE1kMWtuek81MXJBSVRrUS9XcDVQSUMxalNQQlRrQXZH?=
 =?utf-8?B?SWZnV2ovTDZCM1RVVFJldTIvK3RBSm5MQ2UrVGxyRFptYnpCUlNtV0VBbmlC?=
 =?utf-8?B?QTQ0TzB5Y2RsbERqZDRqSDlXYzQ3blhjRHFWaFlhdHFCcWNXNTJUQnArRkpx?=
 =?utf-8?B?RnBqR1N1cytlTkY5S3hLWXMxT2RYT0RiUFFBaGQ0azVRMWdrZ2YvNXd3VDQ2?=
 =?utf-8?B?a3lpTmxsdzMxbTBsb21PVXRoY0taRGMzRkpjSlJrVktSK2JsaTZWbWQ0ZDZU?=
 =?utf-8?B?a3FCNm51cSt6SkRzR0VMK3RYczVrcVkvdkNPV2tCK2syZUhFbU5KYk9IS2Va?=
 =?utf-8?B?QkxJT3FSZVFaNFNIeFFZNURaZ1pJcHpkWEpJZ0ZSdi9sU1kzKzFEOTFWSlZ6?=
 =?utf-8?B?eXA1dDdVUEh6c2wyZWRGNGg0QVJUZ2IwTTI0dG52L05BYjFiejA5d1ZKWlBG?=
 =?utf-8?B?d3ZlYTBKQXdROTdkWXVuWS8rWE5wMVdXT1VMQVNkdEZBbzVHMHhZa05yeTVm?=
 =?utf-8?B?ZEoxU1FUZ0YvT2l4RGpoa1J1OGQvOU9najFTSVZXdjRXZjkxRUZ5eFZDY0Jx?=
 =?utf-8?B?WjhXWFdnNEZBWjQ5YWd3ZlFiV21mV1ZnQzBCN1RWL1Iydm1OSy8vcWdVUEJt?=
 =?utf-8?B?OHkvK0ptSEVRWjZleUVoT0tIRzVOMGJ0SG4yNVB0YlNIVDFqRDZ4ci8rdExV?=
 =?utf-8?B?UXRCdTVORjBMSmxTSUc3ejdqdVVHM0prL0ZVQ255alBIakRHTWkvOUNCMUt1?=
 =?utf-8?B?Q3pRU3VZM3I3emlJWnE5dTkwWTQxNDFQNW1xbnNVc2VJc0d4UkIyRWlsWktS?=
 =?utf-8?B?dXZOaDl6UVY5MmY4ZWp5UGw0OS9GaFlZNmdjdHRtdGFaMTREaFMxc0I2RGJY?=
 =?utf-8?B?TFd0clNsV1BqZ0NMS2s0cE5BWmVUbWFPR1pobk0yTWVxZmRnTkZIYkdQemx0?=
 =?utf-8?B?OWJSWUN6VmVrb3l0cEVMTnQ1a3BxRDF4eVo0b1ZIYXRQYk93OGNpRlppNGpk?=
 =?utf-8?B?dENBVk85Q0pXUUdTWGs3NjAxTWNITzN2NWZhdDFhVGYyRElMQ0lOa28xdW9C?=
 =?utf-8?B?SEN1OExMU0pZdlh2VGczcWZmSC9aNWlmYzFIYk1pMUZPb1hMYmhMYUVzNEZ5?=
 =?utf-8?B?VzJXR1R2VlpOeEJzZnF0OFF1R2swczFseVNrRGlJOUlxMzJNb3hWMEZWSHFr?=
 =?utf-8?B?dWliR2w2SWQrT0I1OTdpNXhBRHI1MHBkZXZhQ29qMHFlY3I0S2J4MjZZZkpW?=
 =?utf-8?Q?O/NzAxhIRzM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjFPZkc1ZG1SS2htRkVGSzFlc2pleHBGZm9Samtaekprb3loZkg4NEl0VHVX?=
 =?utf-8?B?U1VMa0wybENkMjlvNjF5ZnY1OFVTa0NLRk0zRUlVSi82c3ZXZ2diclJKQWE1?=
 =?utf-8?B?Z1lzYVI0bnhVRnNKNU0raktIRVFsUzNsU205VXk4SVBNOGVwbU9ZVWR0ZVpK?=
 =?utf-8?B?RzI5b0xwM3BFKzllVFFSdnROQzZuREptZDBYZXBiN3JRdWhkR2krbXo1Q3Rx?=
 =?utf-8?B?SHZnSGxKZXhhR0tWVGI5RGVPZUpGcXZOUzh6NnVzL042UmdyL3RhVlUyWG44?=
 =?utf-8?B?aUR2Y21FQnVFTTNLZGlraWQ2bWxzbUp5R1FPYzN0b3pXYnpqcldXa2xRMXJY?=
 =?utf-8?B?SnlGS2xSOElSWk0xbHVEcWo5VkNVTktscG9kb2w4U2NZOGlDQmp2akVWU0RI?=
 =?utf-8?B?WmkrYzNFZmFWbHpTQ3JhcFY3NHBaL3hHdGhnZnQrTGtRbTI4YzF0NW43ekU1?=
 =?utf-8?B?aHE5S2xBVnc2MHVPQWlIQ3JXbnp0TW94K2tKMHFSa3BEY1V2YnVIb2h2QjNq?=
 =?utf-8?B?bnd0MmZyVW1nT2NiaWJMaDlRZTVBR2xOV2w0NFJaQ0Vvekk2Z2NDRE9pMDRR?=
 =?utf-8?B?WnBNOGJrUGxJLzdrdkt3SDJGWitsZHJlcnFhcHVxc1pWUHRMeUJ5T013NG5i?=
 =?utf-8?B?N09aSTYyaWIxbTBMM1BMRmFtdTllMVRxMGVQNWlobzFyendJTWF2d3F5eDNO?=
 =?utf-8?B?dUFFVzVWcFpGeGJtNkFuYWlKTHpZYzJKWjJUOGUyV2tjR1Z0QUhNallsTWxW?=
 =?utf-8?B?VjRGMHNIQzdLSld4d1JwOTAvelRXVGtxdTNXdUVub0JjNXZ3dHhtTnhqUXVJ?=
 =?utf-8?B?bjVVcjk4NFZiT0RSVC96YTZ1RXJVdTJNYXg2K0RTWW9YOE1Ma2tRYk5GeENo?=
 =?utf-8?B?L3dkV1lpSFpiS2NEVnc0UzhkM2hlOUU4WDc4aDBOZTdBVW1tQXQ2MFlyM2Ez?=
 =?utf-8?B?YXF4ZFdCbWJvUjFET1V3T0ZIbnUzc2p4ZlBlejJJZHBPNHgrck5KaGVlTWJI?=
 =?utf-8?B?b3BDSlNLOTQxdGQvdEJqcU9Ka2NpcDFhWWJxWjAySjhOMjA0Q2dmZnVIdEVU?=
 =?utf-8?B?VTFYYi82Z1VxWjQvL0tibytKNmtzUFZ3bzRJem1KK3FZVHN5Z0Z5SW5HWTRG?=
 =?utf-8?B?ZEVEMXo3akxUWkp0M1JlSzc2UUdWTWNTaHZWV29tVTlObEVxQWg3VHBqdTZP?=
 =?utf-8?B?SjZSWXJhUFk1VGIxUWpobWhuQ2NYb2V5cXUvWVNHOW56KzNLWWpoUmh6YTZj?=
 =?utf-8?B?eGNRQytQZ2xQYzM2YkNRekdPMkJHRUUzSC91ZXdRUTVKSm1uZ0NqclBuTVJQ?=
 =?utf-8?B?TTlvK0Q1MUM2ci9QU203MVF5STFMR3JNdVlKWUpmVG9FdzJBVUs0bWJIZmJH?=
 =?utf-8?B?Mk5QL0hkN2NRNkpOLzRxMnlpVmF1bkV3SWIrZHlkNkV1OEdzcVozcFBmeE1y?=
 =?utf-8?B?UndIZG5CeTlBMTkvSVZROFE1SHF4ZGgrOVYzRzkxMFdxemNXZmpVWU92V21l?=
 =?utf-8?B?MC9Ua3VVQmo0YXRLWi9jRHZqSG9ZNEZhT0IxTEk3b3A1U1BLWG5QZDEwRkx2?=
 =?utf-8?B?UTFwbjFad0R5V2w0QVVTY0t5cHpEdjAzcDB6T0hObW1HNGJjRGRzSDUwVXlO?=
 =?utf-8?B?UGFuaStqd0ZaSWI4RTZwTlRpdHVqdkdGN0JpSGxOU05USjFlUkdIYUMrTWhm?=
 =?utf-8?B?ODk2VXg5VDczSlg2S0RHVUY1SnpRWXg4YUVPVmFQSm1IQk9tbFpwYTRjYzU2?=
 =?utf-8?B?Yy9peFB6VUJ3OGFQdFA4K3dJT0FwRTVRZ3BqZUdPYkYzQmdpUXBIT1kvTVh4?=
 =?utf-8?B?b2s3bDBYbUZhTFZMYlM2VE5oWkZZTmxreVBnM3RlaFF3T0hwQVJOZXBrYzBr?=
 =?utf-8?B?ZzRNajA2UjdCQlYvYUo4UDh3ZUZaNzNnUWM1QVJqTmgrN2dRYmt0VVFTczRG?=
 =?utf-8?B?UXdRTGpzNUkxakJZYk0xNlhqRFdYRzI1UGprTzd5MDRpZVVaQXpoRFFTOXo2?=
 =?utf-8?B?WVZIN0xtckhWb2tzTHF0MEEvYkd5dTNRbnByVVUwc2Z6MjRxTTRDOVV0QmJy?=
 =?utf-8?B?NlJ2S1AxdWs5OWZXbU9lRGhGYlI3WFMvVnFlNlJNQlROMVprSVU1cnZVZkkx?=
 =?utf-8?B?ZzBFVnh2ano0UFBZVTFRZE5yZzRYV1ZNTC9hdDFvd29Pa1B3dWdkZVNUNnBu?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a5f22c-38b3-48e2-83a5-08ddc42a4162
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 05:33:12.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGcMG//5zVWqPj0mQJtvk/7gQWuoJsb66haRrFOrJN+4ffrTDSlWK1FW/GF8YzmI7pLpWEn5xzWDJ9NLgEvOBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com

On Sun, Jul 06, 2025 at 11:47:10AM +1000, Balbir Singh wrote:
> On 7/6/25 11:34, Zi Yan wrote:
> > On 5 Jul 2025, at 21:15, Balbir Singh wrote:
> > 
> >> On 7/5/25 11:55, Zi Yan wrote:
> >>> On 4 Jul 2025, at 20:58, Balbir Singh wrote:
> >>>
> >>>> On 7/4/25 21:24, Zi Yan wrote:
> >>>>>
> >>>>> s/pages/folio
> >>>>>
> >>>>
> >>>> Thanks, will make the changes
> >>>>
> >>>>> Why name it isolated if the folio is unmapped? Isolated folios often mean
> >>>>> they are removed from LRU lists. isolated here causes confusion.
> >>>>>
> >>>>
> >>>> Ack, will change the name
> >>>>
> >>>>
> >>>>>>   *
> >>>>>>   * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
> >>>>>>   * It is in charge of checking whether the split is supported or not and
> >>>>>> @@ -3800,7 +3799,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
> >>>>>>   */
> >>>>>>  static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>  		struct page *split_at, struct page *lock_at,
> >>>>>> -		struct list_head *list, bool uniform_split)
> >>>>>> +		struct list_head *list, bool uniform_split, bool isolated)
> >>>>>>  {
> >>>>>>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
> >>>>>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> >>>>>> @@ -3846,14 +3845,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>  		 * is taken to serialise against parallel split or collapse
> >>>>>>  		 * operations.
> >>>>>>  		 */
> >>>>>> -		anon_vma = folio_get_anon_vma(folio);
> >>>>>> -		if (!anon_vma) {
> >>>>>> -			ret = -EBUSY;
> >>>>>> -			goto out;
> >>>>>> +		if (!isolated) {
> >>>>>> +			anon_vma = folio_get_anon_vma(folio);
> >>>>>> +			if (!anon_vma) {
> >>>>>> +				ret = -EBUSY;
> >>>>>> +				goto out;
> >>>>>> +			}
> >>>>>> +			anon_vma_lock_write(anon_vma);
> >>>>>>  		}
> >>>>>>  		end = -1;
> >>>>>>  		mapping = NULL;
> >>>>>> -		anon_vma_lock_write(anon_vma);
> >>>>>>  	} else {
> >>>>>>  		unsigned int min_order;
> >>>>>>  		gfp_t gfp;
> >>>>>> @@ -3920,7 +3921,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>  		goto out_unlock;
> >>>>>>  	}
> >>>>>>
> >>>>>> -	unmap_folio(folio);
> >>>>>> +	if (!isolated)
> >>>>>> +		unmap_folio(folio);
> >>>>>>
> >>>>>>  	/* block interrupt reentry in xa_lock and spinlock */
> >>>>>>  	local_irq_disable();
> >>>>>> @@ -3973,14 +3975,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>
> >>>>>>  		ret = __split_unmapped_folio(folio, new_order,
> >>>>>>  				split_at, lock_at, list, end, &xas, mapping,
> >>>>>> -				uniform_split);
> >>>>>> +				uniform_split, isolated);
> >>>>>>  	} else {
> >>>>>>  		spin_unlock(&ds_queue->split_queue_lock);
> >>>>>>  fail:
> >>>>>>  		if (mapping)
> >>>>>>  			xas_unlock(&xas);
> >>>>>>  		local_irq_enable();
> >>>>>> -		remap_page(folio, folio_nr_pages(folio), 0);
> >>>>>> +		if (!isolated)
> >>>>>> +			remap_page(folio, folio_nr_pages(folio), 0);
> >>>>>>  		ret = -EAGAIN;
> >>>>>>  	}
> >>>>>
> >>>>> These "isolated" special handlings does not look good, I wonder if there
> >>>>> is a way of letting split code handle device private folios more gracefully.
> >>>>> It also causes confusions, since why does "isolated/unmapped" folios
> >>>>> not need to unmap_page(), remap_page(), or unlock?
> >>>>>
> >>>>>
> >>>>
> >>>> There are two reasons for going down the current code path
> >>>
> >>> After thinking more, I think adding isolated/unmapped is not the right
> >>> way, since unmapped folio is a very generic concept. If you add it,
> >>> one can easily misuse the folio split code by first unmapping a folio
> >>> and trying to split it with unmapped = true. I do not think that is
> >>> supported and your patch does not prevent that from happening in the future.
> >>>
> >>
> >> I don't understand the misuse case you mention, I assume you mean someone can
> >> get the usage wrong? The responsibility is on the caller to do the right thing
> >> if calling the API with unmapped
> > 
> > Before your patch, there is no use case of splitting unmapped folios.
> > Your patch only adds support for device private page split, not any unmapped
> > folio split. So using a generic isolated/unmapped parameter is not OK.
> > 
> 
> There is a use for splitting unmapped folios (see below)
> 
> >>
> >>> You should teach different parts of folio split code path to handle
> >>> device private folios properly. Details are below.
> >>>
> >>>>
> >>>> 1. if the isolated check is not present, folio_get_anon_vma will fail and cause
> >>>>    the split routine to return with -EBUSY
> >>>
> >>> You do something below instead.
> >>>
> >>> if (!anon_vma && !folio_is_device_private(folio)) {
> >>> 	ret = -EBUSY;
> >>> 	goto out;
> >>> } else if (anon_vma) {
> >>> 	anon_vma_lock_write(anon_vma);
> >>> }
> >>>
> >>
> >> folio_get_anon() cannot be called for unmapped folios. In our case the page has
> >> already been unmapped. Is there a reason why you mix anon_vma_lock_write with
> >> the check for device private folios?
> > 
> > Oh, I did not notice that anon_vma = folio_get_anon_vma(folio) is also
> > in if (!isolated) branch. In that case, just do
> > 
> > if (folio_is_device_private(folio) {
> > ...
> > } else if (is_anon) {
> > ...
> > } else {
> > ...
> > }
> > 
> >>
> >>> People can know device private folio split needs a special handling.
> >>>
> >>> BTW, why a device private folio can also be anonymous? Does it mean
> >>> if a page cache folio is migrated to device private, kernel also
> >>> sees it as both device private and file-backed?
> >>>
> >>
> >> FYI: device private folios only work with anonymous private pages, hence
> >> the name device private.
> > 
> > OK.
> > 
> >>
> >>>
> >>>> 2. Going through unmap_page(), remap_page() causes a full page table walk, which
> >>>>    the migrate_device API has already just done as a part of the migration. The
> >>>>    entries under consideration are already migration entries in this case.
> >>>>    This is wasteful and in some case unexpected.
> >>>
> >>> unmap_folio() already adds TTU_SPLIT_HUGE_PMD to try to split
> >>> PMD mapping, which you did in migrate_vma_split_pages(). You probably
> >>> can teach either try_to_migrate() or try_to_unmap() to just split
> >>> device private PMD mapping. Or if that is not preferred,
> >>> you can simply call split_huge_pmd_address() when unmap_folio()
> >>> sees a device private folio.
> >>>
> >>> For remap_page(), you can simply return for device private folios
> >>> like it is currently doing for non anonymous folios.
> >>>
> >>
> >> Doing a full rmap walk does not make sense with unmap_folio() and
> >> remap_folio(), because
> >>
> >> 1. We need to do a page table walk/rmap walk again
> >> 2. We'll need special handling of migration <-> migration entries
> >>    in the rmap handling (set/remove migration ptes)
> >> 3. In this context, the code is already in the middle of migration,
> >>    so trying to do that again does not make sense.
> > 
> > Why doing split in the middle of migration? Existing split code
> > assumes to-be-split folios are mapped.
> > 
> > What prevents doing split before migration?
> > 
> 
> The code does do a split prior to migration if THP selection fails
> 
> Please see https://lore.kernel.org/lkml/20250703233511.2028395-5-balbirs@nvidia.com/
> and the fallback part which calls split_folio()
> 
> But the case under consideration is special since the device needs to allocate
> corresponding pfn's as well. The changelog mentions it:
> 
> "The common case that arises is that after setup, during migrate
> the destination might not be able to allocate MIGRATE_PFN_COMPOUND
> pages."
> 
> I can expand on it, because migrate_vma() is a multi-phase operation
> 
> 1. migrate_vma_setup()
> 2. migrate_vma_pages()
> 3. migrate_vma_finalize()
> 
> It can so happen that when we get the destination pfn's allocated the destination
> might not be able to allocate a large page, so we do the split in migrate_vma_pages().
> 
> The pages have been unmapped and collected in migrate_vma_setup()
> 
> The next patch in the series 9/12 (https://lore.kernel.org/lkml/20250703233511.2028395-10-balbirs@nvidia.com/)
> tests the split and emulates a failure on the device side to allocate large pages
> and tests it in 10/12 (https://lore.kernel.org/lkml/20250703233511.2028395-11-balbirs@nvidia.com/)
> 

Another use case I’ve seen is when a previously allocated high-order
folio, now in the free memory pool, is reallocated as a lower-order
page. For example, a 2MB fault allocates a folio, the memory is later
freed, and then a 4KB fault reuses a page from that previously allocated
folio. This will be actually quite common in Xe / GPU SVM. In such
cases, the folio in an unmapped state needs to be split. I’d suggest a
migrate_device_* helper built on top of the core MM __split_folio
function add here.

Matt

> 
> >>
> >>
> >>>
> >>> For lru_add_split_folio(), you can skip it if a device private
> >>> folio is seen.
> >>>
> >>> Last, for unlock part, why do you need to keep all after-split folios
> >>> locked? It should be possible to just keep the to-be-migrated folio
> >>> locked and unlock the rest for a later retry. But I could miss something
> >>> since I am not familiar with device private migration code.
> >>>
> >>
> >> Not sure I follow this comment
> > 
> > Because the patch is doing split in the middle of migration and existing
> > split code never supports. My comment is based on the assumption that
> > the split is done when a folio is mapped.
> > 
> 
> Understood, hopefully I've explained the reason for the split in the middle
> of migration
> 
> Thanks for the detailed review
> Balbir

