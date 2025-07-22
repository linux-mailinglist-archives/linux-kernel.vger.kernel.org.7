Return-Path: <linux-kernel+bounces-740175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BE6B0D0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05946C285B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14A28C039;
	Tue, 22 Jul 2025 04:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9vFxKOC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C124642D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160044; cv=fail; b=UcPGwH7M4KxDjtWvLpkAJQsc9X07I9eSVQKtNK8SagGct4D8Su2dDfzaJtVAreFP/qhjxbaO6EkRd3AU24WJvlHjrM1lku6Gwiqc5Tym18RYobsINlf1bgt3Y7hMyJ3v6GDwQ3ZHElDWU7CAbj+FC3tsslKoVqO6VGarMfl4Wm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160044; c=relaxed/simple;
	bh=i2uCoB8CAWpNslv+8L5s1+BVzngHWQQ0IcHZqOG0Ztk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rzW44KMjAoR/1NDP1VxhNkM9hJxhwzTmMM7RmoJtJuANA17JXJQxJKQpUiqZOAP1vHiJL2thnp+crHy0COjsSWW9AkjjufAj80jxm7HVQg136CIFy+QDhUJByKIk+BNXRvrNE0Xc+lGRs7DSFK/nmB6boQBanf0TvYXK28QIwWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9vFxKOC; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753160043; x=1784696043;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=i2uCoB8CAWpNslv+8L5s1+BVzngHWQQ0IcHZqOG0Ztk=;
  b=c9vFxKOCAR5rxLVWqIx3wqAo7/2TZynTpwH2DX0BWlrpQUWm+68p5Fn1
   55Oldryucc1BBz1eiSpH9XPIeqQ5IATuwiSoRbmb9qb0ez4bBkMFkj8qM
   uVsGylZkcW6g9oE5xMcCvnr7XuvBs5JQ/5Cg1kfsYyfnSpdDvb8NrZLaJ
   cvZyChq0HJhlpT0b/yp6j6cOxBNxoi/ROgIa0FJHJT3bFugskOgkHIQ0J
   YaGsMpu8hLYhewJYQfZthSRsVANXt48AL3Dy0WW1VFlUCTjWhMYjARYTr
   /r8n+ISNUlmhRWMMfjMlV93OSWN6D0j28FcZEfOrQP9IHNPYwRyMaWTgt
   w==;
X-CSE-ConnectionGUID: WEyVqnoCQr+NGfl23KhP7w==
X-CSE-MsgGUID: RH/aDSN5TsGWc6+693HtPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72845770"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="72845770"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 21:54:02 -0700
X-CSE-ConnectionGUID: if2SXTHUQJ6ez+oh91GPtg==
X-CSE-MsgGUID: lZyXfP8HR2+UE2ZTNiW4Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="163079834"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 21:54:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 21:54:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 21:54:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 21:53:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPyqOeyy+G0xXVg26eCK5/lx1pIufizChjmDNhsdBmT1oOFVxGzMUXuBe8esox9Um2LOrCx8aBTlCHB5S4q34cCZ6pnQurD5wWMLkCnu9SIEcbyJyJkxqtde3oaShen+ZlNHbQXfLeK7T+xQIxoRsy2PyU8wJWIj2GRl+bN+QrDNeABNYkaLQvoB2acrjiqVrDjbAXq4ctp+M2m/efeztOBUIAcXvJ6Y/kUq6TFI7aUMEUjXDse1QCkBCY88Mu5mGGYHzGBHgMkGHg0V+3IdKQ8SXEiselyzioLE0Vpma2ZseFcZP/XWp2rcSmhV4YwXVbjSq/QFtXvCthSlzkaaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ilTQ14MZzgMw3gqHEaPKkOcwJ7k2+5u2I7KSDfBGs0=;
 b=DGPcu8wjBYGJB+SdOn65obtylCydXZGPty8rXlLmXcLeyR9VFI3OSKHSI/wiFb7jbuUGL0bxoxIJ55s1FPZ4DiJJexscMHOWC6RkPVix0tTCRHbyb7cugaQ61m0F7leAlxr59n0vsqNiQ4vm1McCgCiL48dNma1LrxPxSi0IgMFpzADiPfhkcIbwJpn7DlaIEOMSh04SfheLLXbmndZgi+GfmkV2+YnJJ0FCmBJzVv9P1EgIBUv1noYDj2Xzd15etGvIyimsqb4AUHkUJT1sk3/50toInYm86S3mzFVMYOlReiAA42zKHTR0yHQWwINdG/zWM38hzDW78rdfIPmVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA2PR11MB5049.namprd11.prod.outlook.com (2603:10b6:806:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 04:53:15 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 04:53:14 +0000
Date: Mon, 21 Jul 2025 21:54:59 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, Karol Herbst <kherbst@redhat.com>, Lyude Paul
	<lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Shuah Khan
	<shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Barry Song
	<baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>, Alistair Popple
	<apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
Subject: Re: [v1 resend 04/12] mm/migrate_device: THP migration of zone
 device pages
Message-ID: <aH8Zo5q0gMeI8+yx@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-5-balbirs@nvidia.com>
 <aHnw0kEpIDYfFX3E@lstrano-desk.jf.intel.com>
 <83354b1f-8170-4f73-933f-5127f1d12dc6@nvidia.com>
 <aHn2AE+l5oVTQLox@lstrano-desk.jf.intel.com>
 <aHoEQAlGgRAb+cb8@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHoEQAlGgRAb+cb8@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: BY3PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:217::20) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA2PR11MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: a876dc5f-5f7c-49a9-c551-08ddc8dbaad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlNYNDBKdnNJSG1YOHpzRloyTWdIRmpwU1lFOEFNV0FhZGxPZEpKemFGdS85?=
 =?utf-8?B?eU5jK0xheVRsRXVQNnpSMXBCQzRqOFhHamdieUZPalZSWjhpbWQ4ZFB5UDZr?=
 =?utf-8?B?czZlem1CelNNRzhUcG9xTlhhVVJXRlRhdTFkcmJpQTYxMDBZRzJKaVoyYmZl?=
 =?utf-8?B?cUEvS21YOGVSRUNFYWh6cCtoV1BuQ2VWQTNJOGNCZnZsU2hrM0ZoRnF5SUZJ?=
 =?utf-8?B?cFFWQnVRRVBMdlBsLy9rRVlvWDR0V3JWbkRRQ1l5VEFWVE1SbnRkNVNSRjA3?=
 =?utf-8?B?NkkvcW9MQmJYVHF2RXFYQ2hqL1h3enBiWE81YlRMR1FvaTI5MkgxTXJDZkNE?=
 =?utf-8?B?WkV4YmNZdnVyeWRVT29RZE9QR25ubVlzWHR1QmFobEUxY1ljbS9LSXVaZXFS?=
 =?utf-8?B?MkhHa0J3VkhPcHEzRlZHMWhHTFVMbW9jUTZ6SGZ4b250NDRhSExXUkJ6cml0?=
 =?utf-8?B?NFBSUHZTUS9BOVlPVndBdTA1d1RzQndnSHlTVTVhZGdMRHhSQ0l3ajk0UHJD?=
 =?utf-8?B?dThXUGdTNnZpL1ZQb2VUeGJVdGpBbzhvQVgwdUUwSWR6RVRvcjIyWTVNRFJl?=
 =?utf-8?B?aXBpV0VKWGdaN3RTL0h2bXRobkxkQllBSEdxQjNSbzlKM1VvVEx3N2lSeERM?=
 =?utf-8?B?cGdqOXExanJJcGhDd1VORUFMa291SXlWUC9RY2I2YXVsRW44ZXIxb1NLbnRv?=
 =?utf-8?B?VFQyalBuNmdBcy9oVEtweGJ5VDRSRFZFQkovUUdETFhDd2lXdHNJdzFrUkVM?=
 =?utf-8?B?a0NRSk12T2tqN3l5YWM5eGgzK0RRcElPQUZqOTIyV3Q1TFhNYkQyb2RiZUR0?=
 =?utf-8?B?STUvSHkvallDTVhTU3JlMTdndWpXMWMyRG8zNWgzVzZWMEhBOWlrMnF1Z2ty?=
 =?utf-8?B?VTJTdHZoSXZpV1hobjdNcFozeVhQNGhnNWx0dU4zWHY4eWl2Z3YzUVFoTEhX?=
 =?utf-8?B?TVZpVmZpdEtBeHFoOUluaDI2SWJaMnE5dlNLYzZFcEZmekt0aE9XKzY1R1l3?=
 =?utf-8?B?eGhCRlJXNy9JNyszY0VMZWRUQWN5RnovZEZTTVc3OXdwOURyOHpCYUk0OTI5?=
 =?utf-8?B?QnV2RnZWMzhaT1I5NmdKYTM1RFJnbUpQYkpoZkJ3TDJqczFtVXV0amEzSHFm?=
 =?utf-8?B?bEJ5UFZPRlA0QVRmaWhqODBZcmx2ZXo1bnlHQndCQlFJM3V4NUY3RlNWOXEx?=
 =?utf-8?B?UkdTVitVbnVnRmptK2JLclI5Z0RmQ0lBN3ZkeW5xbE1teVBTOWNOdllZSnVw?=
 =?utf-8?B?YUVmaDV1ZHQxaDIxUEJIZTRZUEhZRFFpcWlWNVJjUjAxQXpSdmpZYmFUMzZx?=
 =?utf-8?B?eUFObnlJd0tTOWJLUTRaZHRtVWFzbGg1YWhPT0JuOFc4RzRUSDZGNnAxRGox?=
 =?utf-8?B?eURUWE5ieUJ0TUFRd1lPTjNDVzFrK1BwS0FUWkFLN2tFcWU0Yjh5NnBWY1lG?=
 =?utf-8?B?VkpMZzBOUmZZNm11eDhlR0lGbTYzWEhWdmRqQnF6ZEdFakxsZWtOejlWVDRM?=
 =?utf-8?B?RUw5K2ZFK2N1dTdRQlpOZnpDSXlNRENvN0ZVOVNnMk9MQ0ZMbUtoRHZmSjFG?=
 =?utf-8?B?ZVNsVDhNdzFZM0loUm4rcmNlZU90dG45bWltdWFwWnJESCtvOGc2L0haVVZw?=
 =?utf-8?B?L1k3QXd3MXUrSEV5emp2TGwwM2I5eWl2aXRtVXNHNWhXUFVNNVVaQXVjTTR4?=
 =?utf-8?B?OGFhZ2FwVzFDN1lyZEV1d3luK1gzd2FsdmVDd0xCemRxN2ljKzAyWjM3ZUtu?=
 =?utf-8?B?emFBOGNHK2ZMY1Nsa2FQWlhsME4wWGZYeGlWVmVKb204Tk5ZZ3J6bFVLSmdT?=
 =?utf-8?B?YUExTWw5N0tsZzNwWHpiU0h5VVdTUmR3QldoenVrM3BTNHhTQ0Q3UlNTZUIy?=
 =?utf-8?B?cFpJUnFVc2JkNkVCU0ExMFBRVjBlT0pjR25STHB3Qmt6SzZ4ZGZvM2IxQXBl?=
 =?utf-8?Q?BWYqS3NktGI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnA3cDhjN24xOGJpY3d1czVueVg0NnJnRFNyWDRaTzBmcHpHZU83V0NUSFZ6?=
 =?utf-8?B?YlFSUEZmT3llaEhhUU1ZNHc5azBrckVZZ2g3T0JWVWFwTUQ5VlZsc2E5d29x?=
 =?utf-8?B?VGFOVTM3S1c5WGlnMFppeUxFVG0rZUF0T3YzdHh0RjBuMU9sa0dXUjJCeHhJ?=
 =?utf-8?B?d2F4UERFM3NHUi8ydmRQVW5NQVc4L2dJOXZIMmFyNnNKSzZoMmV0dElrK3R0?=
 =?utf-8?B?NXphd3F3VnBKRUxoVzdsTURLVlYwb25WZU14dnlSamVxUUZPM08rR1grYngv?=
 =?utf-8?B?L2cwME9TU0dwcmhYNnE0VVZmWk14VG9YQU9lUWxQMktPY3QwUE9qdmlUUlB5?=
 =?utf-8?B?VWlUd2pZMFlHZGUvQndRQVRRNDJoTFMrM21KS2JNL1hJeVdaYjFVWk5NSWxz?=
 =?utf-8?B?WWVOazJoSjFrSVFyenBRZnV1UW1KMWxBZmQ1Y3RqYTM4aVlrL1kxMlBrY0Fp?=
 =?utf-8?B?Y1oydE1aZjhWYVd4QUhlZDhFSjl2WDVIRWVIbGttempWUENQb0xKUjBQK04r?=
 =?utf-8?B?bnNna25jNFl5dTkrc3ROWXY2WUhMTSs4WjFoNEZxZXA1eFhCb245N3J6LzlG?=
 =?utf-8?B?bVFnSmtwM2EwVGp0Nk5jdlhJNmlvZFlQcmJyU1BpMWlCdG03cDgxT2ZEYXRz?=
 =?utf-8?B?eC8wcnJaWW00UDV4WHFvWkZEVG55OWRMSUVUSFpVVG9SVExWNVBwMzRFRG5a?=
 =?utf-8?B?dlJUQTRGREE0cDc4OGplQzY2ME8zRlIxZnlGQWNKSmp0MlhjRm94SGt0Y3Ev?=
 =?utf-8?B?YXZKaTc5VDFucjlkZnVQS1pQZkppanZ5TUhBUmZZUzNPS3RseVZmdEptUEVi?=
 =?utf-8?B?R1dKVmYrSkd6WDF5T0R5SGpQSEJNbmg2bnBnckhBSDh1THcyUlkyNUJDSFpm?=
 =?utf-8?B?U2VBMWJjbE50dFhCMmExTk9aUFZXRGtqU2g2WkppUTRhazh5UVRRcnhiSGNZ?=
 =?utf-8?B?eU1ONVFyZC9EbE9obEpFRzNtbVNrVCt1NzRkTUVNOWsvaUZUOG5hcXcydmtO?=
 =?utf-8?B?QnNzTVdsWVhic2ZxaFhiQURUMk93MnVDSGp0TmplWnB0c2xyRlBxSjgycW5J?=
 =?utf-8?B?MXllNTZRWDZPSFdxZHhGblQ4S0tibklFeUE5NExFaWtuVjRLQWw2bmdaYzV5?=
 =?utf-8?B?OTVYem12UEx2U0MzVjU0S2FwaEl4K0FzWHc1NVBjc0E5SzM1RzVqNmtvYXc0?=
 =?utf-8?B?OWJER2dWSHJVTzBhc0kvODZncm0zR0JlTmlVZ25VNHhDYnpjL1AraU9aRWd6?=
 =?utf-8?B?ZFk1VlJqYnl1VTVmejVtbFFEQlFUSkNoWmo1VFVGb0libDgzYmovc1ZiSjBv?=
 =?utf-8?B?RWVaY1NwNzVYQkNYendoV0c5VSsrNzVKOWozaUU1ZmVqTEtvdFhNenlwTzBX?=
 =?utf-8?B?OW5MVXlmTGpxUzF1SERXcVFaZDNaNlJYRnJMUDlzZGpTTGpyUS9namZ3Mk8z?=
 =?utf-8?B?OU05cE45d080VzM4bGl5d0VEekhWdVNuenBsK0dHZ3RUV2FVL2xyOXhibm5v?=
 =?utf-8?B?clVack8rYktXSlI3M09tWFd0WDZYZStsQ2R5cTRicGhpZ0tiMlZYa09VNE8v?=
 =?utf-8?B?UlRjQ0FwOGM3Y0FxYkZHV05yaldjdHZuWGFXQ1ExQms5M0wzSW5zT0duYVd6?=
 =?utf-8?B?ZkxFLy95M3c0ejZzUFZ0dVN6Vnp1ZHpyRGFHa0ZmU2F3MVo3MnRvRTZmQmF1?=
 =?utf-8?B?Ky94c2MxOEVWV1FGT0hlS2ZBWXNTMlFtcXUzV2lPTlU5eDI3Uk5HcUs2UTZB?=
 =?utf-8?B?b2NiQm1zTjhmOTAzcHBuTjhQNHRKbTY5WjRlNWhZSXFuNGx2TVRDMGNUempK?=
 =?utf-8?B?d0c3cWgrdWZocWFzTmUrbDVGMFEzZEtmeUhqQmlWOEdsdE9zZ0RkTDNRbWRn?=
 =?utf-8?B?UnhJYmN1VStDaGM2M05seHREckNnVGUrelovbThWbG1IMy9YaTZXS3ZEeXFn?=
 =?utf-8?B?SnFIaEhqK1FrMGlyYU5lNFdEbExVZFRmRHFJeWE0Z1FtQnFSb1ViTHVFM1lP?=
 =?utf-8?B?RENWVlBaS3hRaVFHaTJ2cDhoVk5VWGhBajFMZjlLTjlrR3lTbGNqVWtka1pv?=
 =?utf-8?B?eUM3Y25IUVNZSTNySlM4QkRZL3B3Y2s0Vk05ZE1pOXhTTjJqQWZiRU9sRklL?=
 =?utf-8?B?VGJIWUpzOEREaXRWbXhPRWl5QjcxQVZqNC8zR25McFNUMm9EM0dTQmc4a1JU?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a876dc5f-5f7c-49a9-c551-08ddc8dbaad6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 04:53:14.7994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rALUPFduVPy4g3ET+9zmkJ99a26CU7071e5F2opN5YuCcYHXOkDMmzJl0CVwO5CBj0gkn5Td8lEAmjZSAMMTOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5049
X-OriginatorOrg: intel.com

On Fri, Jul 18, 2025 at 01:22:24AM -0700, Matthew Brost wrote:
> On Fri, Jul 18, 2025 at 12:21:36AM -0700, Matthew Brost wrote:
> > On Fri, Jul 18, 2025 at 05:04:39PM +1000, Balbir Singh wrote:
> > > On 7/18/25 16:59, Matthew Brost wrote:
> > > > On Fri, Jul 04, 2025 at 09:35:03AM +1000, Balbir Singh wrote:
> > > >> +	if (thp_migration_supported() &&
> > > >> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> > > >> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> > > >> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> > > >> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
> > > >> +						MIGRATE_PFN_COMPOUND;
> > > >> +		migrate->dst[migrate->npages] = 0;
> > > >> +		migrate->npages++;
> > > >> +		migrate->cpages++;
> > > > 
> > > > It's a bit unclear what cpages and npages actually represent when
> > > > collecting a THP. In my opinion, they should reflect the total number of
> > > > minimum sized pages collected—i.e., we should increment by the shifted
> > > > order (512) here. I'm fairly certain the logic in migrate_device.c would
> > > > break if a 4MB range was requested and a THP was found first, followed by a
> > > > non-THP.
> > > > 
> > > 
> > > cpages and npages represent entries in the array and when or'ed with MIGRATE_PFN_COMPOUND
> > > represent the right number of entries populated. If you have a test that shows
> > > the breakage, I'd be keen to see it. We do populate other entries in 4k size(s) when
> > > collecting to allow for a split of the folio.
> > > 
> > 
> > I don’t have a test case, but let me quickly point out a logic bug.
> > 
> > Look at migrate_device_unmap. The variable i is incremented by
> > folio_nr_pages, which seems correct. However, in the earlier code, we
> > populate migrate->src using migrate->npages as the index, then increment
> > it by 1. So, if two THPs are found back to back, they’ll occupy entries
> > 0 and 1, while migrate_device_unmap will access entries 0 and 512.
> > 

Ugh, ignore this logic bug explanation — I was wrong. I missed that
migrate_vma_collect_skip increments npages to create the desired holes
in the source array for folio splits or skip-over logic.

But my point still stands regarding what cpages should represent — the
total number of minimum-sized pages collected and unmapped, in an effort
to keep the meaning of npages and cpages consistent.

Matt

> > Given that we have no idea what mix of THP vs non-THP we’ll encounter,
> > the only sane approach is to populate the input array at minimum
> > page-entry alignment. Similarly, npages and cpages should reflect the
> > number of minimum-sized pages found, with the caller (and
> > migrate_device) understanding that src and dst will be sparsely
> > populated based on each entry’s folio order.
> > 
> 
> I looked into this further and found another case where the logic breaks.
> 
> In __migrate_device_pages, the call to migrate_vma_split_pages assumes
> that based on folio's order it can populate subsequent entries upon
> split. This requires the source array to reflect the folio order upon
> finding it.
> 
> Here’s a summary of how I believe the migrate_vma_setup interface should
> behave, assuming 4K pages and 2M THPs:
> 
> Example A: 4MB requested, 2 THPs found and unmapped
> src[0]:     folio, order 9, migrate flag set
> src[1–511]: not present
> src[512]:   folio, order 9, migrate flag set
> src[513–1023]: not present
> npages = 1024, cpages = 1024
> 
> Example B: 4MB requested, 2 THPs found, first THP unmap fails
> src[0]:     folio, order 9, migrate flag clear
> src[1–511]: not present
> src[512]:   folio, order 9, migrate flag set
> src[513–1023]: not present
> npages = 1024, cpages = 512
> 
> Example C: 4MB requested, 512 small pages + 1 THP found, some small pages fail to unmap
> src[0–7]:   folio, order 0, migrate flag clear  
> src[8–511]: folio, order 0, migrate flag set  
> src[512]:   folio, order 9, migrate flag set  
> src[513–1023]: not present  
> npages = 1024, cpages = 1016  
> 
> As I suggested in my previous reply to patch #2, this should be
> documented—preferably in kernel-doc—so the final behavior is clear to
> both migrate_device.c (and the structs in migrate.h) and the layers
> above. I can help take a pass at writing kernel-doc for both, as its
> behavior is fairly before you changes.
> 
> Matt
> 
> > Matt
> > 
> > > Thanks for the review,
> > > Balbir Singh

