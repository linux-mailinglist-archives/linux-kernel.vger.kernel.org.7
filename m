Return-Path: <linux-kernel+bounces-736113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732CCB098FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEE5A46F90
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5542A96;
	Fri, 18 Jul 2025 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjsdARkY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4E2AEF5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752799251; cv=fail; b=mu9oKTkdunZLRXUeyGtKvHtBr6Xm+H9fm4dLuQmnVsBCPowTIkDeF0Ktx+Lk836Msf6wh31ifpq6xYQP/PdDqJ82gYkbeN6PhCf0wUNvzLDkWrNKbXD9ROFKh+SEC0iKVNe36XKGjjglL5kgtd5x78qPEnJ7Ptt1uaHnYuZYbgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752799251; c=relaxed/simple;
	bh=BmzjjbHnCaCtTgeGRLIA7csiF8gkS4vcGb24AzSrYQM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ntJ+ctO+RPPdCPnK6I8LXM35EydtngC5OJSczvXzxZxEX+kwId13teSEmAP2E36nEWX57uPbN6Y3NlgUdFazjTxbLvYx2YOt8rXkbRbdLZ7SeYzPQEzuns0HdfgSkqgab9IwesGQ4n7hneoyhMY/+o4+bnxNAPtXyzDvubE12i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjsdARkY; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752799250; x=1784335250;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BmzjjbHnCaCtTgeGRLIA7csiF8gkS4vcGb24AzSrYQM=;
  b=gjsdARkYpr9d/udxuJGQmnbrneT+7/C7MC7xpj5j8d9eBMZIknWyU9BC
   Z1csBSi4Pa5ki3R9nlIwWHHhOLPu/gdCrErBsTO7EdLg8yJWjnuNYJ2BW
   ZdEtD1WMQl28hOvFxw+kxpcACiLxAjgfwnLxKqm74GKXF2TBxZK97SERA
   OJ13iBb9AsD/n/8FTRyspGrtl1XVoPlV9OseS0ZMbOWEUEIU/OWBQCAjN
   BzcLRMKwtz6qz8gleUC5pWvlXk7RoSYOT0Z4+ex/Ail9qu5Tvl2lh3V62
   etmHLE7Rqy7v8QpzwVjioR7aRumbl43P61Ryyk7N9Cl6JjweB213JN+hQ
   w==;
X-CSE-ConnectionGUID: ZZqKr57ORVWVBDd9WRwSjQ==
X-CSE-MsgGUID: IBxcrkOqS7Szw2Mu7AxySg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54947595"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="54947595"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 17:40:49 -0700
X-CSE-ConnectionGUID: lxnYHceNQ/e9F96MJjY2Qw==
X-CSE-MsgGUID: Sb7RxWbkTgaWHfzIIuBK5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="181645164"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 17:40:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 17:40:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 17:40:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 17:40:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZgKeW65SZqSqFhCZX4QztUZ8NqSvBTSV9k6GC6sZ2NucsjXlt9+tT6LC2JKJn7qW6K2g67vtNYmVz1Ex3vtHFa5eFtl9NBqCjTcWPcergccNKePsvCN26mROCCmQVy9GvCMGuSJFkK57JPcYhey+sDexKy0C3Sh0w/OS5iIXSx3tTwfUENzxXuhZ+wHYaa/IFKq+F7xcTVuwF4oPoleghn3gnsRMuiu07Q+DluR8kidsudbN+XHBDqciE1V4QCfxBc9IoZLwye28J4JwDnsDQwan0KEN8Q4I2ucUBStjmf7LzRgOcT7N6HwjKe73Q0OPKRZyfY/MJdkgtkLy5Vdsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdSTqTYRjabZCmMM4SVuV1nTO5GHvYovhlQ/uowi7ss=;
 b=YM30NhDVhn2vz1NUt/4l/NGv4pm2vSHGCSmND3vjYnsDKRkI1gHN3ttyHRghqh31n53Lwb5wj5lzmGMj699slRwxj83rpi8UjGDPD56j0d6E+K5CkbhkZW9Ac1zvXbKSTwIHg5MFe4k81h9ykq5aR3CRX7VogcV/K4h8r0qNkPkej/5ydQOJhI8rnw858yBlBJ/jxGJnKrBngP1dfUbswnUrTGpfebqKwd5lKz2rJZ1Z1u7nOxQNPxnoN58Cm6UJEagtiwbYLkqqijRYDczJDhyO0A61YDjkVzlwyoe7GUai7rm3v/DI6Zh4mFKsnPIWcLUNFcj+OuDus4Mk95TeFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 00:40:17 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Fri, 18 Jul 2025
 00:40:17 +0000
Date: Thu, 17 Jul 2025 17:41:58 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Zi Yan <ziy@nvidia.com>
CC: Balbir Singh <balbirs@nvidia.com>, <linux-mm@kvack.org>,
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
Message-ID: <aHmYVkNDRjz5JwNf@lstrano-desk.jf.intel.com>
References: <007E2728-5BFC-40F9-8B8F-25504863D217@nvidia.com>
 <aa4f94a3-f601-4379-b6ca-4389421ccca4@nvidia.com>
 <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
 <aHc5/pmNLf4e9brJ@lstrano-desk.jf.intel.com>
 <1DD0079E-0AF6-49F5-9CB3-E440F36D2D9B@nvidia.com>
 <aHfSTdoi/M9ORrXE@lstrano-desk.jf.intel.com>
 <a7e8485f-e9da-4edb-a809-a014517f26eb@nvidia.com>
 <aHl4IuMlE9D6yaET@lstrano-desk.jf.intel.com>
 <9E024BB0-7365-4A81-81E1-72CB44A07775@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9E024BB0-7365-4A81-81E1-72CB44A07775@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|CH3PR11MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 816ed2c4-81ed-45c1-d779-08ddc593aa64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHVXYjAzZ2ovZ0ZIa0IycnN5ci80c3FpVEQ2d2ZFNlZ4RjBaZU1pSkNYSjNq?=
 =?utf-8?B?UW51R3N3eGRmR0E0Tmh6SlNiekZLcG5FWmhkK3EwcFZzYkZ1QnBxcWpVMFMv?=
 =?utf-8?B?SUpDam5UZGR4UHIrMkNMWWptYm9VMVRidFBabFRCMDFOR3d6TTJ5SkpBMktK?=
 =?utf-8?B?MEd5Zmsrajl0SXRRTWhPSjhJQVBhYXJzeTduR0hwNS9TZnNsck5pbDhNdlND?=
 =?utf-8?B?TWFIRXE4R0p4Ly9nMmluRm9WZkZPWWlHQk9HOU56T2dTclU3Y1kySDQyMEl1?=
 =?utf-8?B?N2hjSElaRkNMV0NST1kyQ29WY3kwNDVzNUNNRWYwSHhQY1crZnhlRFpGdVZv?=
 =?utf-8?B?ZlZnS1hxekdmZGdaSHlLSytBSmk3ZnhEc1JZT0JkbklXYUhndUJxNFk4Q3Iw?=
 =?utf-8?B?UkdUa2ZkTWJaektVNzlibWZJNUNwNVpHZ0ZhclFheDR5RGxjWkgzS2R6UVBs?=
 =?utf-8?B?QWFRQWhtYzlaa0lRLzJlck9yR25zMC8rOXQxUjdVOU8yUmRRaGg1RU1BSVJt?=
 =?utf-8?B?Smx4T1NUZXBjMUNlK2NNR1RaVWFwaE85SHJ0ZjVRcUhaNWt1dVFRamQ1aUZ4?=
 =?utf-8?B?NnhxRXlBWGk5RDJwSElMazRheTlvMkhmYXYvTnZRby9VUUFtYjdsTWtrMjVj?=
 =?utf-8?B?bmQzR0g1cUxLbnAzWW4yUUhobmhNYWMrV0NkYWFzcE9EaG10cm5pZnRyeGp1?=
 =?utf-8?B?WWJkWDQvRzh6Y1VRNDVub243MjNhOHlQWXNRdEgweW1UdGgrS2hFNXNMVS9B?=
 =?utf-8?B?SG82d1BjZDlZVXpNaExYMm1hcitqUHpoL2tGb3pFd2lIck56VUxoOFBxYnYy?=
 =?utf-8?B?V2t0WUI1NnJyU3RRR01YVWV5d05UOE9CYVAxZWlvdXdUM2wrMkRIektkVEZP?=
 =?utf-8?B?OSswdG1uM3o4OTNuemZEb01LZ2dBQlFDanBkMkRVMWxLNk5tRmZTWTRySWJJ?=
 =?utf-8?B?N1ZyZ2lNY3dJN053Y3AxSXk2bEE4RTBkQnpqMWhEL093dTg1N2hQQUlpZjdR?=
 =?utf-8?B?MTAybzRIdlhCcTRsTVZheFFPNTM3VTVlMVkyVmRKM0hwM0tkWjc4S3B5Qm5L?=
 =?utf-8?B?bUtFY3RrenZUNzVPLzZhSHJzV1BGR3FKT3ltY1B0aDhUcjlKaXRHUm9nK0NG?=
 =?utf-8?B?Z0p2aE1iYjdCdUwybzEzeVdCTm1tUGJ0SFY3YVkzWlJHZFRJeVpVZ3BqQ3dz?=
 =?utf-8?B?d3pFNHlWTXFZMHlvMmdHYWZYZ0VxZDdwR25xNDBxNHFsbjVucEpwMzNQVGNh?=
 =?utf-8?B?S2hBaGZyRWN0bVQ1UElSUHNFdHVMem1CNGZOdy9BSlVoL0syeXdJM3V5YmZD?=
 =?utf-8?B?Y2FLYjRTbGMxcGllL3NHY2VMK2MyazBlYWcrOGVLdDU2YmlzYWlEZTVwYWl6?=
 =?utf-8?B?Z3YxM05iUnlwMU9JWlhpVCsxNllWT3lzY0g4T3VBdC9Ud25MSTRaMzl2N1pR?=
 =?utf-8?B?NjhVd05JNjJHc3RLaWlwTTY0Q0VkZUp2Wkl1QlJGUDhJaFRCSG5sMyttQTNL?=
 =?utf-8?B?T3ZYNTU2QTFqMmRSamd1N1hwTG5SbGhTZ1VwUXFsN1BXUmRMc1ZmMFNORWZE?=
 =?utf-8?B?VVUwbkRnZVFnUnp4N3g1bERib1Y0aU9WZFhUa291WlZwYXRGSTZmYnBkMmkx?=
 =?utf-8?B?Unl3ZW1KY0xGS0JpRDdTUDNuSjJ6QzUvMlJYZTJtVnAyeGNZaHNjaDJVbENM?=
 =?utf-8?B?YnpkbCs5aTZLNTdMTXBGM2JnQlRJSFN3Y0JQVDVDc1U3TVcxSDQwaEJUbWJT?=
 =?utf-8?B?OXRPaU9MVWFxZjltUHo5b1lld1FLTFUyZDduaEhoY2xyZXZ2dzRYRTU0QmJ0?=
 =?utf-8?B?akpTS0lwSzQ2ZmtIOEt3SXE5TG1UY3YybkpqWmNRNCtMTDdkaS90WVpxM2FY?=
 =?utf-8?B?QURCTFdCWkRKbzJtRnl5MVJrcVFtL29FSHpPNFhRNVJHK0M1UXlVK2dYUkhm?=
 =?utf-8?Q?DOQsgvKZHzg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xKTUlPNjBJSjMyeVprbFFOUVF3a0NKcDN6eE9Scm1hT0gwbTJuNWc1SHhQ?=
 =?utf-8?B?c3dnVHdkNHRkVGpVcVd5bUVVbTEwWHpMc1l6SEdwakpkakNDT1c3b1o0dFg0?=
 =?utf-8?B?Wm9sdzdjc3VwdnVrcVJoTUtmNGUzUDNpRDZxWFU2WUlwclNjcDhROW9DVDhy?=
 =?utf-8?B?L2I5R2dwaXF2YkpNQzdmdzJNUDU4OGRvQllrWnNROW03T0FUTDY1cWpEY1Jt?=
 =?utf-8?B?VXhMSXNuaURra3VUVStmMVdOVTFkNnBwdDFNMDZjbDRKZ3ozQk5hTmcyRzFP?=
 =?utf-8?B?S3c3QWpyYkhkYko3VEVZVHB6dXlBYjRRTVI5RWN1b1FDcDJRbDRkM1BUWWlQ?=
 =?utf-8?B?dmtLL3VjR01aOUN5dHFkODl6enFzWkR0UnFTWWNiQXdZNFlmOE1FMUF1SmZ6?=
 =?utf-8?B?NmVnY1lMQWJ0eEZRa1JSb3BYaUdHcHFWVEJnb2RJb0poaVFyVktuY3E5VnRS?=
 =?utf-8?B?SFR2bVYwZXZLa0RyeGVRaXcwRnJZYjd2VlNpQjI4TmtVQjN1ZXd1Mm5QQ25R?=
 =?utf-8?B?czJGOWI0dFM5WGhBcE0zeEJERVd3d0EzaHQxSTgrNzhkR0l3UUxhdmYveE5U?=
 =?utf-8?B?T2JmcTdPczBUa3FhNkRyOUdRUTFJOTNhb2QvbW5DQnlkNGtkRG9OMXRhUXQ3?=
 =?utf-8?B?S1JKOVowUlJtZlBqNFZ5cDBhNDBtbDR2RWI3ZXZKcm0vUUROZHRMUkZuUTJy?=
 =?utf-8?B?QkZSY0tEOWYxWmlDMlFpdW5VUXQ3K3hEdENoNHBiUzAvRjhVVlJES3hHZDFm?=
 =?utf-8?B?R2FNalloZ3hrb3ZrOXdpaC8wQ0hDeGwxdFBTMnBKNEJOaTA0Y0VQTWVjME9j?=
 =?utf-8?B?a1RyKzMvbHRlWmIvNzNFem12ZVAzaFp3dWd5S2Q3ZGxESGdIU0M2Rk95S20r?=
 =?utf-8?B?Yy8zQkJGdVNLd0dSTTE2elA3VXlYZVoxNTNXYkJ1aDhKWE1GT3RVSzNjK2NU?=
 =?utf-8?B?cXBaYWtxaE5XYXMwUmUxUFk0bjZVSTNEdGhTYlZQQlhhYTB6d2xQOHB5VCta?=
 =?utf-8?B?cG9vYldFNUViRGc2ZE9xZ1dxdWxjdHBSRTVnOHFMTEZjQllYd04wd2J6ejE5?=
 =?utf-8?B?WkRYSWxUdFVhRlB0RnZHSjgzTmd4WVk5SWRWY1czcFN3Vm5UaTdvK3R1T2Fu?=
 =?utf-8?B?WHBCOE41S3RCL0U0SkhIVWxmSmdKQVBnelQvd3N2a09sQTA2em9SZVhZVXdo?=
 =?utf-8?B?Q21vNlcwZUsyQUhCRmJSM0hyVDlFQzYxYXNPclh1SExBVjdBdE9PZ2hWcWRF?=
 =?utf-8?B?YWxRT0dqMFlpMXdoMWp5ZkoxMTZZd1BQVzRHQW1QWHB1U3gvMmxNODFPejZh?=
 =?utf-8?B?UjhzOXhLNWlLeXFtTjIxOFYxOTFyS3hrZXROUzFmU2x5ckRLd2lEb2ZtWVov?=
 =?utf-8?B?SEp6SjNxTHZpN2JXQnpHaW02Wi8vVWNLYktIRVJMMFhUQkNnQWp2VzlSNjhP?=
 =?utf-8?B?N0lmN3huTmlYd0ZrTFFwbkdkUXN3N1gwV0pmZ1Zhb3RLYmhWbFNnWGk4aXNu?=
 =?utf-8?B?Y0FLaHBoYWVOZXpMK0tqNDBNSUtlNlhYN3BWNnJnY2N0SDRNSWR4NVNrRkZD?=
 =?utf-8?B?N1BBc1oxTWJidzZId0V6VzNkSmIwZ3ppSGhHcHd3QlFXY0ZUUGN0VWQzanEz?=
 =?utf-8?B?ckZBVkthUTlHTktGaGwwc2tSRFJZUnNsNDhLTWhYbkdzWjVSUXlWQXJnRG02?=
 =?utf-8?B?d0JTWnpvRjV2RDBva1JYM3FXeG9EU0RyKzZRYUtMM1NHUUVxWlBwMjFmclFU?=
 =?utf-8?B?TG10L3ErTy9Ec3F0akd6bHlMcHgzMFZ4Nit5aFBBZHlUSTQ5aFNZM2w3ZjBQ?=
 =?utf-8?B?S3RuaHVNNlVwT2d6L1BWMUs2YVhHQlY0bFkyZi9qcEZuNmlVTEtqOWtVNzFY?=
 =?utf-8?B?U083V0MxVndVd0FFTU05UG1NcnMvanFHZm5QMWVVRXdiSXRxUVZxUFZFRUpz?=
 =?utf-8?B?MGk4Rk9vNDl1RWlGblN3Y3R3dm1hZlV5bjJjdnA2bklvczhuMnJYNUd6TTdm?=
 =?utf-8?B?dElKRFE4OGxidi9OdWtoZFBUZW5oZmEzbXlMWWRJVExUMmlkY1dkMGJCeXov?=
 =?utf-8?B?SUlyZ0puZ0EzcE0waXpIWFErYTVGRkduZ2hzckY2NnNHSVc5K0tJRkRSMTlJ?=
 =?utf-8?B?ZVo0R1o4ZllKYUNZV3hFUHg4SnQ3NzhvSFladDB4V3ovSldBWTEwYnZLbFBL?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 816ed2c4-81ed-45c1-d779-08ddc593aa64
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 00:40:17.1067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbQ1dFSK6xN+CExDlcBIK9UQ4JVtqLzqkGZd4F1J6Eo/wf7mdFmCcFhRo1K/99sPmYrERpg6+Gc50ycbkbeIKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8773
X-OriginatorOrg: intel.com

On Thu, Jul 17, 2025 at 07:04:48PM -0400, Zi Yan wrote:
> On 17 Jul 2025, at 18:24, Matthew Brost wrote:
> 
> > On Thu, Jul 17, 2025 at 07:53:40AM +1000, Balbir Singh wrote:
> >> On 7/17/25 02:24, Matthew Brost wrote:
> >>> On Wed, Jul 16, 2025 at 07:19:10AM -0400, Zi Yan wrote:
> >>>> On 16 Jul 2025, at 1:34, Matthew Brost wrote:
> >>>>
> >>>>> On Sun, Jul 06, 2025 at 11:47:10AM +1000, Balbir Singh wrote:
> >>>>>> On 7/6/25 11:34, Zi Yan wrote:
> >>>>>>> On 5 Jul 2025, at 21:15, Balbir Singh wrote:
> >>>>>>>
> >>>>>>>> On 7/5/25 11:55, Zi Yan wrote:
> >>>>>>>>> On 4 Jul 2025, at 20:58, Balbir Singh wrote:
> >>>>>>>>>
> >>>>>>>>>> On 7/4/25 21:24, Zi Yan wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> s/pages/folio
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Thanks, will make the changes
> >>>>>>>>>>
> >>>>>>>>>>> Why name it isolated if the folio is unmapped? Isolated folios often mean
> >>>>>>>>>>> they are removed from LRU lists. isolated here causes confusion.
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Ack, will change the name
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>>   *
> >>>>>>>>>>>>   * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
> >>>>>>>>>>>>   * It is in charge of checking whether the split is supported or not and
> >>>>>>>>>>>> @@ -3800,7 +3799,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>>>   */
> >>>>>>>>>>>>  static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>>>  		struct page *split_at, struct page *lock_at,
> >>>>>>>>>>>> -		struct list_head *list, bool uniform_split)
> >>>>>>>>>>>> +		struct list_head *list, bool uniform_split, bool isolated)
> >>>>>>>>>>>>  {
> >>>>>>>>>>>>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
> >>>>>>>>>>>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> >>>>>>>>>>>> @@ -3846,14 +3845,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>>>  		 * is taken to serialise against parallel split or collapse
> >>>>>>>>>>>>  		 * operations.
> >>>>>>>>>>>>  		 */
> >>>>>>>>>>>> -		anon_vma = folio_get_anon_vma(folio);
> >>>>>>>>>>>> -		if (!anon_vma) {
> >>>>>>>>>>>> -			ret = -EBUSY;
> >>>>>>>>>>>> -			goto out;
> >>>>>>>>>>>> +		if (!isolated) {
> >>>>>>>>>>>> +			anon_vma = folio_get_anon_vma(folio);
> >>>>>>>>>>>> +			if (!anon_vma) {
> >>>>>>>>>>>> +				ret = -EBUSY;
> >>>>>>>>>>>> +				goto out;
> >>>>>>>>>>>> +			}
> >>>>>>>>>>>> +			anon_vma_lock_write(anon_vma);
> >>>>>>>>>>>>  		}
> >>>>>>>>>>>>  		end = -1;
> >>>>>>>>>>>>  		mapping = NULL;
> >>>>>>>>>>>> -		anon_vma_lock_write(anon_vma);
> >>>>>>>>>>>>  	} else {
> >>>>>>>>>>>>  		unsigned int min_order;
> >>>>>>>>>>>>  		gfp_t gfp;
> >>>>>>>>>>>> @@ -3920,7 +3921,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>>>  		goto out_unlock;
> >>>>>>>>>>>>  	}
> >>>>>>>>>>>>
> >>>>>>>>>>>> -	unmap_folio(folio);
> >>>>>>>>>>>> +	if (!isolated)
> >>>>>>>>>>>> +		unmap_folio(folio);
> >>>>>>>>>>>>
> >>>>>>>>>>>>  	/* block interrupt reentry in xa_lock and spinlock */
> >>>>>>>>>>>>  	local_irq_disable();
> >>>>>>>>>>>> @@ -3973,14 +3975,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>>>>>>>>>>>
> >>>>>>>>>>>>  		ret = __split_unmapped_folio(folio, new_order,
> >>>>>>>>>>>>  				split_at, lock_at, list, end, &xas, mapping,
> >>>>>>>>>>>> -				uniform_split);
> >>>>>>>>>>>> +				uniform_split, isolated);
> >>>>>>>>>>>>  	} else {
> >>>>>>>>>>>>  		spin_unlock(&ds_queue->split_queue_lock);
> >>>>>>>>>>>>  fail:
> >>>>>>>>>>>>  		if (mapping)
> >>>>>>>>>>>>  			xas_unlock(&xas);
> >>>>>>>>>>>>  		local_irq_enable();
> >>>>>>>>>>>> -		remap_page(folio, folio_nr_pages(folio), 0);
> >>>>>>>>>>>> +		if (!isolated)
> >>>>>>>>>>>> +			remap_page(folio, folio_nr_pages(folio), 0);
> >>>>>>>>>>>>  		ret = -EAGAIN;
> >>>>>>>>>>>>  	}
> >>>>>>>>>>>
> >>>>>>>>>>> These "isolated" special handlings does not look good, I wonder if there
> >>>>>>>>>>> is a way of letting split code handle device private folios more gracefully.
> >>>>>>>>>>> It also causes confusions, since why does "isolated/unmapped" folios
> >>>>>>>>>>> not need to unmap_page(), remap_page(), or unlock?
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> There are two reasons for going down the current code path
> >>>>>>>>>
> >>>>>>>>> After thinking more, I think adding isolated/unmapped is not the right
> >>>>>>>>> way, since unmapped folio is a very generic concept. If you add it,
> >>>>>>>>> one can easily misuse the folio split code by first unmapping a folio
> >>>>>>>>> and trying to split it with unmapped = true. I do not think that is
> >>>>>>>>> supported and your patch does not prevent that from happening in the future.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> I don't understand the misuse case you mention, I assume you mean someone can
> >>>>>>>> get the usage wrong? The responsibility is on the caller to do the right thing
> >>>>>>>> if calling the API with unmapped
> >>>>>>>
> >>>>>>> Before your patch, there is no use case of splitting unmapped folios.
> >>>>>>> Your patch only adds support for device private page split, not any unmapped
> >>>>>>> folio split. So using a generic isolated/unmapped parameter is not OK.
> >>>>>>>
> >>>>>>
> >>>>>> There is a use for splitting unmapped folios (see below)
> >>>>>>
> >>>>>>>>
> >>>>>>>>> You should teach different parts of folio split code path to handle
> >>>>>>>>> device private folios properly. Details are below.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> 1. if the isolated check is not present, folio_get_anon_vma will fail and cause
> >>>>>>>>>>    the split routine to return with -EBUSY
> >>>>>>>>>
> >>>>>>>>> You do something below instead.
> >>>>>>>>>
> >>>>>>>>> if (!anon_vma && !folio_is_device_private(folio)) {
> >>>>>>>>> 	ret = -EBUSY;
> >>>>>>>>> 	goto out;
> >>>>>>>>> } else if (anon_vma) {
> >>>>>>>>> 	anon_vma_lock_write(anon_vma);
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> folio_get_anon() cannot be called for unmapped folios. In our case the page has
> >>>>>>>> already been unmapped. Is there a reason why you mix anon_vma_lock_write with
> >>>>>>>> the check for device private folios?
> >>>>>>>
> >>>>>>> Oh, I did not notice that anon_vma = folio_get_anon_vma(folio) is also
> >>>>>>> in if (!isolated) branch. In that case, just do
> >>>>>>>
> >>>>>>> if (folio_is_device_private(folio) {
> >>>>>>> ...
> >>>>>>> } else if (is_anon) {
> >>>>>>> ...
> >>>>>>> } else {
> >>>>>>> ...
> >>>>>>> }
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> People can know device private folio split needs a special handling.
> >>>>>>>>>
> >>>>>>>>> BTW, why a device private folio can also be anonymous? Does it mean
> >>>>>>>>> if a page cache folio is migrated to device private, kernel also
> >>>>>>>>> sees it as both device private and file-backed?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> FYI: device private folios only work with anonymous private pages, hence
> >>>>>>>> the name device private.
> >>>>>>>
> >>>>>>> OK.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> 2. Going through unmap_page(), remap_page() causes a full page table walk, which
> >>>>>>>>>>    the migrate_device API has already just done as a part of the migration. The
> >>>>>>>>>>    entries under consideration are already migration entries in this case.
> >>>>>>>>>>    This is wasteful and in some case unexpected.
> >>>>>>>>>
> >>>>>>>>> unmap_folio() already adds TTU_SPLIT_HUGE_PMD to try to split
> >>>>>>>>> PMD mapping, which you did in migrate_vma_split_pages(). You probably
> >>>>>>>>> can teach either try_to_migrate() or try_to_unmap() to just split
> >>>>>>>>> device private PMD mapping. Or if that is not preferred,
> >>>>>>>>> you can simply call split_huge_pmd_address() when unmap_folio()
> >>>>>>>>> sees a device private folio.
> >>>>>>>>>
> >>>>>>>>> For remap_page(), you can simply return for device private folios
> >>>>>>>>> like it is currently doing for non anonymous folios.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Doing a full rmap walk does not make sense with unmap_folio() and
> >>>>>>>> remap_folio(), because
> >>>>>>>>
> >>>>>>>> 1. We need to do a page table walk/rmap walk again
> >>>>>>>> 2. We'll need special handling of migration <-> migration entries
> >>>>>>>>    in the rmap handling (set/remove migration ptes)
> >>>>>>>> 3. In this context, the code is already in the middle of migration,
> >>>>>>>>    so trying to do that again does not make sense.
> >>>>>>>
> >>>>>>> Why doing split in the middle of migration? Existing split code
> >>>>>>> assumes to-be-split folios are mapped.
> >>>>>>>
> >>>>>>> What prevents doing split before migration?
> >>>>>>>
> >>>>>>
> >>>>>> The code does do a split prior to migration if THP selection fails
> >>>>>>
> >>>>>> Please see https://lore.kernel.org/lkml/20250703233511.2028395-5-balbirs@nvidia.com/
> >>>>>> and the fallback part which calls split_folio()
> >>>>>>
> >>>>>> But the case under consideration is special since the device needs to allocate
> >>>>>> corresponding pfn's as well. The changelog mentions it:
> >>>>>>
> >>>>>> "The common case that arises is that after setup, during migrate
> >>>>>> the destination might not be able to allocate MIGRATE_PFN_COMPOUND
> >>>>>> pages."
> >>>>>>
> >>>>>> I can expand on it, because migrate_vma() is a multi-phase operation
> >>>>>>
> >>>>>> 1. migrate_vma_setup()
> >>>>>> 2. migrate_vma_pages()
> >>>>>> 3. migrate_vma_finalize()
> >>>>>>
> >>>>>> It can so happen that when we get the destination pfn's allocated the destination
> >>>>>> might not be able to allocate a large page, so we do the split in migrate_vma_pages().
> >>>>>>
> >>>>>> The pages have been unmapped and collected in migrate_vma_setup()
> >>>>>>
> >>>>>> The next patch in the series 9/12 (https://lore.kernel.org/lkml/20250703233511.2028395-10-balbirs@nvidia.com/)
> >>>>>> tests the split and emulates a failure on the device side to allocate large pages
> >>>>>> and tests it in 10/12 (https://lore.kernel.org/lkml/20250703233511.2028395-11-balbirs@nvidia.com/)
> >>>>>>
> >>>>>
> >>>>> Another use case I’ve seen is when a previously allocated high-order
> >>>>> folio, now in the free memory pool, is reallocated as a lower-order
> >>>>> page. For example, a 2MB fault allocates a folio, the memory is later
> >>>>
> >>>> That is different. If the high-order folio is free, it should be split
> >>>> using split_page() from mm/page_alloc.c.
> >>>>
> >>>
> >>> Ah, ok. Let me see if that works - it would easier.
> >>>
> >
> > This suggestion quickly blows up as PageCompound is true and page_count
> > here is zero.
> 
> OK, your folio has PageCompound set. Then you will need __split_unmapped_foio().
> 
> >
> >>>>> freed, and then a 4KB fault reuses a page from that previously allocated
> >>>>> folio. This will be actually quite common in Xe / GPU SVM. In such
> >>>>> cases, the folio in an unmapped state needs to be split. I’d suggest a
> >>>>
> >>>> This folio is unused, so ->flags, ->mapping, and etc. are not set,
> >>>> __split_unmapped_folio() is not for it, unless you mean free folio
> >>>> differently.
> >>>>
> >>>
> >>> This is right, those fields should be clear.
> >>>
> >>> Thanks for the tip.
> >>>
> >> I was hoping to reuse __split_folio_to_order() at some point in the future
> >> to split the backing pages in the driver, but it is not an immediate priority
> >>
> >
> > I think we need something for the scenario I describe here. I was to
> > make __split_huge_page_to_list_to_order with a couple of hacks but it
> > almostly certainig not right as Zi pointed out.
> >
> > New to the MM stuff, but play around with this a bit and see if I can
> > come up with something that will work here.
> 
> Can you try to write a new split_page function with __split_unmapped_folio()?
> Since based on your description, your folio is not mapped.
> 

Yes, page->mapping is NULL in this case - that was part of the hacks to
__split_huge_page_to_list_to_order (more specially __folio_split) I had
to make in order to get something working for this case.

I can try out something based on __split_unmapped_folio and report back.

Matt 

> 
> Best Regards,
> Yan, Zi

