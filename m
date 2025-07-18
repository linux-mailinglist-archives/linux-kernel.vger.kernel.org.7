Return-Path: <linux-kernel+bounces-736349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD8B09BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453435A2CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E73620B7F4;
	Fri, 18 Jul 2025 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gkno70RT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53C191F91
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752821926; cv=fail; b=Y+HUcpMBwrlXlIDq9Z9OuoixuATIZuLMoBYDU6z61hCV75zahSfZGr+znjV5v9jU2rQZxmJLf4zzUT4WpF5tUWjtCbramvLlBF0/k5fTmrd+nDMQgluyke/EvEeqe9qp56+qszQ4p6dxfbcFLQOr8V3mFObfNlStR47MzCx/OvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752821926; c=relaxed/simple;
	bh=dD1bGYffXY0AbrxE2Vj3fFzZDdrH9uqoKwfVQGwECxk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bn45BcXohbzl8L5DAAsBnJW7+IrkpPT933OC3iKEoXbV6xk3GYwHTWKPZj3Q5jN3AxGXaVh21fpmUrTqp23Rgxz0lewJeQfC6a8PKcsSH5xfWD9yBCFqwTgCPzJ62mq5FYGm0dTK2GQMF/Nm+o1oub3LflGL0+Q9R4VpMF663gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gkno70RT; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752821924; x=1784357924;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dD1bGYffXY0AbrxE2Vj3fFzZDdrH9uqoKwfVQGwECxk=;
  b=Gkno70RT1X5iACkJat0PQeLO8FN2So6R/Wu2hUB/PqrxrrYv8YQcWXh9
   oa6Ei3c5jiEpahrh1yrST7VoVRzkBVMDT9akmoJ8LMB9q+6gDZE4ULKjF
   fwyTpTbbOiBUBOQkWcAo2C4SY3fb3muFth6WhIgke7xuzuMRvx3iwOFAT
   e1xOlX6u6hN/KQ6XhppCfPsBNgJgfPiVSsvE2yogHiiqQBjJpa+Vnioxf
   /167fPqIEfF48dDmYxe6ONFT2j7jaHmOeAWZb+7W6aC0iOHSryh++RGjs
   WvUyygHBWUwI5fzvwQlmUjXaW9f8OzEuA8JHs1Cp+xHQJi1c1mhVsbBpK
   g==;
X-CSE-ConnectionGUID: YAHPgapYR0+DDJBxbBUQNQ==
X-CSE-MsgGUID: 73SacHFSTJGj+BhkGO6jVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55074761"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="55074761"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 23:58:39 -0700
X-CSE-ConnectionGUID: b6R6G87VSCmNWKGCDDy+8g==
X-CSE-MsgGUID: TDbSfw1OQBOx0Zs9oYnoBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="188970421"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 23:58:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 23:58:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 23:58:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.85)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 23:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTBt/D9QecBz+FV2vSGNKLWae57VqqNyC8MSEWKj6ccFAvCIGJgEhpGJusMrOP5Z3liOjyRiaBWROkvjUqNcWg6xc5OfJIuG1XwZhEzPC571iGtRiWvCOKwtwwr/yz0cWpgR9dyX1GOKmJCihuf8rD8oPQX9XxWyyOMJdYESnsThVV4ppiT33yPnPOoyR1FvOh7rPmxULK4sy8CDPun4IHMxAAus6EpkVVXzuejPOs9E+dDSwXLG5Awe9pXZbx32CEYScGkfL/ZiKU5r9GSnSZoM+coNSQ+OMV/cC1Vv5uSCEbiJqpfZ+5ugacdGUwpVmY0PgGWMkSy+YbBRYPbnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmAh1+HdpJD+BEyPz3xU9Ukpjy60G9IAY5Co/2JQ85Q=;
 b=QKjGwyMZ7txd/DEfm51bvV0W7R76koDmTvs0s38+3vOIHOIReAIuyF7XhIhbKGCAV04kEqxTX/3KGHiqc1ITGlYPUABne0Vms5eoHkAsu03Ncr5EYv5mFS5dyzBmkwauY1mdPcJ31Isb9ZP9t5bCJyvTFDV+MkdqJOGjLoLmrlIJeHVV2ypqJIuj0MdCG5wiNXKTowRk1DMdP60KkDIVmeSql11fPXILGV7yGdKOlSW9naeYwAjucbm9sYk6PIZV5bKG4nvbA29HlUY7jIzErYRhhHSdjY+e1TzzNfyZtmhECQ4kuAo6lxz3bm/Bj5uCfwsWi4zop97zAVeUo22eHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by MW6PR11MB8438.namprd11.prod.outlook.com (2603:10b6:303:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 06:58:09 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Fri, 18 Jul 2025
 06:57:46 +0000
Date: Thu, 17 Jul 2025 23:59:30 -0700
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
Message-ID: <aHnw0kEpIDYfFX3E@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-5-balbirs@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703233511.2028395-5-balbirs@nvidia.com>
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|MW6PR11MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 978ec953-860d-42ec-7983-08ddc5c866b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjRoK2VGUjl0SWtycEtubU8zUU9Ndmx2WG1XbWJRT2hsRXFmVGdXYmxPVVJW?=
 =?utf-8?B?amdCZ3VQa2xWcVVrVEd5aDE1Y2tEQjRNT3ozWVRwa0dnWG5vL1oxZmdGUXRr?=
 =?utf-8?B?b3R2Z2orZDNXdzdzRWF3cHM0UFlwN1ZkbXk0UW1OSlk0SExLemFsUEhiT3cx?=
 =?utf-8?B?SmtvclZpTnljOVE1YXdmTDZEUXJBZUpBbXo4SCtsR25iZE42bUFWcWpacFVa?=
 =?utf-8?B?SVBZODdkemIyMXZUOHdEY1I4ck5PUFAyaXMxeHVYakltSFRQNVU2bjRVcUZy?=
 =?utf-8?B?UW1SSmtlQk5FS0h4SzFpaEtmZXRFMS9WTFgrckwzQnZWaGptaThWVG1zT3NF?=
 =?utf-8?B?aGRSOHFLOG82WUhZbFJUWHFlK1pHYkl1a2RBcFdpdmN2TjFzYldxakpma1FI?=
 =?utf-8?B?Sk9OV1FtMDBHVDIrRzE5WnZzc21uRVE5Q3ZkMXBON2c4NGxISVV0MWdRa0pO?=
 =?utf-8?B?QWQ1Qzg5dUQ3MkJiaXZXQzBUMVRNN0VROHdYYm1iTnVDemlMaHdSbk1NYVZP?=
 =?utf-8?B?SnVRdWR5MVFPeXhjY1NxUDhyUFB3K0dSL3R1ZEFlTE9JV3A5SFJ5RExHdXI1?=
 =?utf-8?B?TC9SZTlmZGtiM3JjRUxleDFuRjcyYjQ5cFAyVlhHMkR1VElENkRXbTgxSWxs?=
 =?utf-8?B?WDBWQkxSRjA3Z2Z3RWJoY0ZjUkEvRmoyaUxxdHNEVllLd3F2WXA0ZVlGd1Bp?=
 =?utf-8?B?V0ROYlRTcU9JWXRLaE5XOWNydVM5UjdIdVVNbCtBeWRoK2NpRUFmMmdXVmlx?=
 =?utf-8?B?YktUcW9tM3pVaUlNMjdlSWtMNDJLY05FN1ljVkx3NXdOS2NQQXZZQlpPK0dX?=
 =?utf-8?B?YTlac0ZqRmgzSXRScVkxbnJUeG9vV3RPclhDWEFHMTNVK3B6THA5YS81dDlC?=
 =?utf-8?B?Nnh2T0c5TDVxakkxMTlmK0VtN2N6UXFOb21JKzdvelhIKzV3Y1dIYU5NdmRL?=
 =?utf-8?B?VkJ5SU9NSWRLdTRMb09zY3FsSlpNejVzU20xaGdMUi9kT0o3d0FEWGZia0c2?=
 =?utf-8?B?dTF5dFBPNUNERzFMYTkzR0pVYjhZOVoxcjQzcjZNZUN5OEp5aFFaaFdTTW1M?=
 =?utf-8?B?cVhIRytqODFTQjN6eDI4anRyc0NtNkVNTUxTblpYZzZ5K0UrRks4VEpUT09a?=
 =?utf-8?B?T2tRbWZLWHFLYkU0dkE2RXVNSVJsREo5Q1dDSjdtVWtPVVNrUTdtOFUwd1Y0?=
 =?utf-8?B?SFBJbTZDYTZLbVlqUXlLdkx2SHZvUFN4QVUvS1hSaTE4OVpPQjZvcDN0VUZW?=
 =?utf-8?B?WGVJb1Q0TVZVU0dyTTNwK1ZnUU5WQ2hESFlOdGZ4dXErL2JlR0xCcVEyU0ly?=
 =?utf-8?B?UDJvQ1VMWkNkYWhjRUt1TldDK01Na2M3b3ZMZVllc2JTWEpHclJMRTRZVUMy?=
 =?utf-8?B?WVY3Z1R2cHFIWmhWNlRjTk5hcjZyUmwvWUNHeGhyUElsZHU2ZVRYQ3lhbFU3?=
 =?utf-8?B?dTNMeWFkKzZrVHp0RjAwdzlRRXFwV29hTk5Id0hUbWZkM1VsT1kycDdDWUc3?=
 =?utf-8?B?N0w5YWF1WWZzYVJDUVIxZ3FLdnphMzlvRzF1bHZxL2RFN1VNQ2F6YXRGQ0U1?=
 =?utf-8?B?My9pTWtqZU5LUndxZ3BwblQvcHpjN05CcklWSWsvVzB1a1AvYjN5OExMTVdk?=
 =?utf-8?B?dXhpT1ZYU0dhb1V6eGE0STZkcEptVGRYRFdtaFcxeDZkdEtuQmplTzlGcEpQ?=
 =?utf-8?B?TE5mYzNoQ2x5NmptTVF5aFdPWm9xMGJ6TE12aXFDaG0zMC83b0VZL3prVXR1?=
 =?utf-8?B?VmcraU9mOGRkOFNscW0xdTgwZGZCNit2TnNHY2xOaUxtSnd5d2pNQ1Z4Ymth?=
 =?utf-8?B?OUx3NnZtZCs2WmljWis1TVRTYS9Wak9hT2Z1NUNDeHVKNjBtUWZkZS9wVTNI?=
 =?utf-8?B?T3pjN3lkYW9GS1NuTVpiZnd2YS9pWEs2UXF0eEl6dndycm1kQTVsUTRId1N4?=
 =?utf-8?Q?nIXU8m2lr28=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktMOVRZZzJZWjZZcHFRcktRSXVhQ0RCUnhBclZWOFp0eE4rTy9saVV5cSta?=
 =?utf-8?B?WXBRN1RvRWtMbTVyWnVONVJ1bEJqQTB5TURWa0pUcmo3SWF0U1hpcG1Xbm9h?=
 =?utf-8?B?V3JvK3dFYmFyV1ZHUFhwOTJLM3BGK1AwcFRGWlFUNER6KzlzcG56QkNxUlZE?=
 =?utf-8?B?WHlsclk0bms4Z09oRGtEZHFHTktUWnlJUTRnRlErVHEyRHI0ZnRCWUN5RWRs?=
 =?utf-8?B?djRSRk1sQTBLTlE5THIwcStqQ05BZktXdVdwU2gvRlRCZ0pwcG5xUHpCd0FM?=
 =?utf-8?B?Z1RFSDFBQjkrL3ZWaFNsSUhQMEVSa1Y1OG1rL2IyVC9TUmhrRDJrcDRHWDB1?=
 =?utf-8?B?RzNmR0xYcmRvN0RwTjNXbVVtd0Y2TG51U3VVR0FYTUYwS3cxWHJvcXNXWXpj?=
 =?utf-8?B?bHQ3L2VKSTl3TEVEdEdudzdEc3hWSlJNVXdxN3dqZUpPczhoVlhtYU9uWXJV?=
 =?utf-8?B?b08xUTNSYjJFajVhMUZORDFIYnlpN2Jzc3JTNDNlbTJkMkFCa0lVTkVZdndM?=
 =?utf-8?B?SWl0VWpUbXBEeFRiNDdTVE1lek9SZWZFVlN3b3I4bGlhQi9WTXo1ZmJKS0JQ?=
 =?utf-8?B?dmFmcTArb3FzMGo5Qi9FVm5YcHlkU1pvS3o5dSs2U1Jnelo4V2JmVFdRd1BF?=
 =?utf-8?B?ZWxZOGFwdmlmUTBQNDVKWFRYd2ZoWFVNTXNSY21PYVV4cWFtdU50WnM3bVZu?=
 =?utf-8?B?K0c3aGF0WUxwZCtPcGNRdjBGVkZNdWh1ZlRHbis5YllYT1NVSkFFTVhSK2VN?=
 =?utf-8?B?em1SNFZlWmdWY1R4dHU1QWVvYXpySk9BK3Q1OGJ2UEhScTBwTGc1cllxUXk1?=
 =?utf-8?B?ZWovVUZnbk1saWNkdjdhUjJ2MGszYnl6N2syZ3JtOFBzOG1oWWszdjBlM3N2?=
 =?utf-8?B?Zm4vQTJ1SEtac05QclpabG5pc2p1dS9nTkR0Ui81eElQdmxudk5OUXd1ZVcy?=
 =?utf-8?B?SmU2bktxRjFBaUg3UkJOL3FnMWJoWHFyalBRMEkrOWRsM1JraVVhT2NLc0gv?=
 =?utf-8?B?aGRudjBsdVA0aThQYkkxMHhFdHh1SXJaSlJVc21tTDFBeWpwbXRHM21vcm9t?=
 =?utf-8?B?VEEwTnZUc3FZUjJCanRScTZSUTJKcFAzTStlU2ljSTJUSENDdkFMRFpzVUsw?=
 =?utf-8?B?TlpIb0VMOUNGRDZldndmblJqZjgyV2JyUG8yVzFxa1Q1SUVZQjI2a2F2MWRl?=
 =?utf-8?B?clZFNkRmR2JSc2JleWhIaThWUXI5bWJPdWFvL0liWVBVR3I2VVZqZ0ppSWhw?=
 =?utf-8?B?UjNoekdlNWFQRnI2b2tqaXB1NXRaNU9ONVpER2h6djdoMXJKSzI2NXdXa0FO?=
 =?utf-8?B?ejNNcmkvUE90bW40dk5UMXJmeGhPSDJNRDh1R2w4NXF4YXhOTi8yQUZtdytG?=
 =?utf-8?B?OW5PTmVlY2Q4M2ZRMlpISDAyWXpYRmt4QUhyMjBJOExoMjRaR0pLNVV1VnBh?=
 =?utf-8?B?S2krbmI2dUZMMUxlQTFTd2dOUGFQWFpSMlhwRWRYZHMycHJzRDg4QmlaSHV2?=
 =?utf-8?B?N0dIbXQwZTlWa0VoUTNybmRoSzRiRGpYVGZoVlR1YlplazRUT0hxM1l4Q004?=
 =?utf-8?B?Ky9GcUlpdjlTY3VwejZoS3dPZGl0QnpSM3JZQTJBVVIyRmVEN3prUmc0VFgx?=
 =?utf-8?B?N2hER3dHdUc1UHFSOG1nQVhIbmVSTkFJRGxmenRuNkVMTFBONCs0aHdOSEtU?=
 =?utf-8?B?bWwzZVhZNGhSK0VYSVZWOWVSLzNHUk5qVjNzSGNHQXVnYTNXYWVWSGo0Zzc1?=
 =?utf-8?B?d0ZqSmkyNVl3eFJuU29qaTFXSjNwR3NYRFdhRzU2TlorNzdGUVo1Vmt4WDlo?=
 =?utf-8?B?UUFCc0NXTU85T3JXdnlEM0NwR2tXZ3hDdHZpZWNnMVhJUHhCVGdZUUNMNU93?=
 =?utf-8?B?V2JmRisxOUZteU1tSktmbTNsZTZDaVQwSXVFVDFxUmRUSmordVlFbmRKeDRV?=
 =?utf-8?B?ckZLUkhhVGQ2UkNoL05SZjdiZVF3OStOUTR6a0QvVDAyTDJ5cXRXOVhxWG9L?=
 =?utf-8?B?NUlNVWpNRU1hZzFSWmNGaEVOcVgxVjR1ZTlnY3cyY2VGbVNYZytvUGZsVnlw?=
 =?utf-8?B?TDFoWGlyWlBqenRxQWRjbnUrUXh1cnU0SmxBWnhOcU1CTmE3VXhZc1RHaWRr?=
 =?utf-8?B?aWFsN2QwWjJLZi9kY1lISVFGWTVsL01yaERQTWljcUxPajBCbXNZVktmZ0RH?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 978ec953-860d-42ec-7983-08ddc5c866b6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 06:57:46.8052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZXOPEJAKzLtegjuIdF2FLaFnLa5ZoBv8QmUEmG+/V8Y9Cmh+AeUTp3qTUJ8kHc21hhS+UVU/WKjA8g1pkciVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8438
X-OriginatorOrg: intel.com

On Fri, Jul 04, 2025 at 09:35:03AM +1000, Balbir Singh wrote:
> migrate_device code paths go through the collect, setup
> and finalize phases of migration. Support for MIGRATE_PFN_COMPOUND
> was added earlier in the series to mark THP pages as
> MIGRATE_PFN_COMPOUND.
> 
> The entries in src and dst arrays passed to these functions still
> remain at a PAGE_SIZE granularity. When a compound page is passed,
> the first entry has the PFN along with MIGRATE_PFN_COMPOUND
> and other flags set (MIGRATE_PFN_MIGRATE, MIGRATE_PFN_VALID), the
> remaining entries (HPAGE_PMD_NR - 1) are filled with 0's. This
> representation allows for the compound page to be split into smaller
> page sizes.
> 
> migrate_vma_collect_hole(), migrate_vma_collect_pmd() are now THP
> page aware. Two new helper functions migrate_vma_collect_huge_pmd()
> and migrate_vma_insert_huge_pmd_page() have been added.
> 
> migrate_vma_collect_huge_pmd() can collect THP pages, but if for
> some reason this fails, there is fallback support to split the folio
> and migrate it.
> 
> migrate_vma_insert_huge_pmd_page() closely follows the logic of
> migrate_vma_insert_page()
> 
> Support for splitting pages as needed for migration will follow in
> later patches in this series.
> 
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> 
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>  mm/migrate_device.c | 437 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 376 insertions(+), 61 deletions(-)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index e05e14d6eacd..41d0bd787969 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -14,6 +14,7 @@
>  #include <linux/pagewalk.h>
>  #include <linux/rmap.h>
>  #include <linux/swapops.h>
> +#include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>  #include "internal.h"
>  
> @@ -44,6 +45,23 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	if (!vma_is_anonymous(walk->vma))
>  		return migrate_vma_collect_skip(start, end, walk);
>  
> +	if (thp_migration_supported() &&
> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE |
> +						MIGRATE_PFN_COMPOUND;
> +		migrate->dst[migrate->npages] = 0;
> +		migrate->npages++;
> +		migrate->cpages++;

It's a bit unclear what cpages and npages actually represent when
collecting a THP. In my opinion, they should reflect the total number of
minimum sized pages collected—i.e., we should increment by the shifted
order (512) here. I'm fairly certain the logic in migrate_device.c would
break if a 4MB range was requested and a THP was found first, followed by a
non-THP.

Matt

> +
> +		/*
> +		 * Collect the remaining entries as holes, in case we
> +		 * need to split later
> +		 */
> +		return migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
> +	}
> +
>  	for (addr = start; addr < end; addr += PAGE_SIZE) {
>  		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
>  		migrate->dst[migrate->npages] = 0;
> @@ -54,57 +72,148 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	return 0;
>  }
>  
> -static int migrate_vma_collect_pmd(pmd_t *pmdp,
> -				   unsigned long start,
> -				   unsigned long end,
> -				   struct mm_walk *walk)
> +/**
> + * migrate_vma_collect_huge_pmd - collect THP pages without splitting the
> + * folio for device private pages.
> + * @pmdp: pointer to pmd entry
> + * @start: start address of the range for migration
> + * @end: end address of the range for migration
> + * @walk: mm_walk callback structure
> + *
> + * Collect the huge pmd entry at @pmdp for migration and set the
> + * MIGRATE_PFN_COMPOUND flag in the migrate src entry to indicate that
> + * migration will occur at HPAGE_PMD granularity
> + */
> +static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
> +					unsigned long end, struct mm_walk *walk,
> +					struct folio *fault_folio)
>  {
> +	struct mm_struct *mm = walk->mm;
> +	struct folio *folio;
>  	struct migrate_vma *migrate = walk->private;
> -	struct folio *fault_folio = migrate->fault_page ?
> -		page_folio(migrate->fault_page) : NULL;
> -	struct vm_area_struct *vma = walk->vma;
> -	struct mm_struct *mm = vma->vm_mm;
> -	unsigned long addr = start, unmapped = 0;
>  	spinlock_t *ptl;
> -	pte_t *ptep;
> +	swp_entry_t entry;
> +	int ret;
> +	unsigned long write = 0;
>  
> -again:
> -	if (pmd_none(*pmdp))
> +	ptl = pmd_lock(mm, pmdp);
> +	if (pmd_none(*pmdp)) {
> +		spin_unlock(ptl);
>  		return migrate_vma_collect_hole(start, end, -1, walk);
> +	}
>  
>  	if (pmd_trans_huge(*pmdp)) {
> -		struct folio *folio;
> -
> -		ptl = pmd_lock(mm, pmdp);
> -		if (unlikely(!pmd_trans_huge(*pmdp))) {
> +		if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
>  			spin_unlock(ptl);
> -			goto again;
> +			return migrate_vma_collect_skip(start, end, walk);
>  		}
>  
>  		folio = pmd_folio(*pmdp);
>  		if (is_huge_zero_folio(folio)) {
>  			spin_unlock(ptl);
> -			split_huge_pmd(vma, pmdp, addr);
> -		} else {
> -			int ret;
> +			return migrate_vma_collect_hole(start, end, -1, walk);
> +		}
> +		if (pmd_write(*pmdp))
> +			write = MIGRATE_PFN_WRITE;
> +	} else if (!pmd_present(*pmdp)) {
> +		entry = pmd_to_swp_entry(*pmdp);
> +		folio = pfn_swap_entry_folio(entry);
> +
> +		if (!is_device_private_entry(entry) ||
> +			!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
> +			(folio->pgmap->owner != migrate->pgmap_owner)) {
> +			spin_unlock(ptl);
> +			return migrate_vma_collect_skip(start, end, walk);
> +		}
>  
> -			folio_get(folio);
> +		if (is_migration_entry(entry)) {
> +			migration_entry_wait_on_locked(entry, ptl);
>  			spin_unlock(ptl);
> -			/* FIXME: we don't expect THP for fault_folio */
> -			if (WARN_ON_ONCE(fault_folio == folio))
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
> -			if (unlikely(!folio_trylock(folio)))
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
> -			ret = split_folio(folio);
> -			if (fault_folio != folio)
> -				folio_unlock(folio);
> -			folio_put(folio);
> -			if (ret)
> -				return migrate_vma_collect_skip(start, end,
> -								walk);
> +			return -EAGAIN;
>  		}
> +
> +		if (is_writable_device_private_entry(entry))
> +			write = MIGRATE_PFN_WRITE;
> +	} else {
> +		spin_unlock(ptl);
> +		return -EAGAIN;
> +	}
> +
> +	folio_get(folio);
> +	if (folio != fault_folio && unlikely(!folio_trylock(folio))) {
> +		spin_unlock(ptl);
> +		folio_put(folio);
> +		return migrate_vma_collect_skip(start, end, walk);
> +	}
> +
> +	if (thp_migration_supported() &&
> +		(migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> +		(IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> +		 IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> +
> +		struct page_vma_mapped_walk pvmw = {
> +			.ptl = ptl,
> +			.address = start,
> +			.pmd = pmdp,
> +			.vma = walk->vma,
> +		};
> +
> +		unsigned long pfn = page_to_pfn(folio_page(folio, 0));
> +
> +		migrate->src[migrate->npages] = migrate_pfn(pfn) | write
> +						| MIGRATE_PFN_MIGRATE
> +						| MIGRATE_PFN_COMPOUND;
> +		migrate->dst[migrate->npages++] = 0;
> +		migrate->cpages++;
> +		ret = set_pmd_migration_entry(&pvmw, folio_page(folio, 0));
> +		if (ret) {
> +			migrate->npages--;
> +			migrate->cpages--;
> +			migrate->src[migrate->npages] = 0;
> +			migrate->dst[migrate->npages] = 0;
> +			goto fallback;
> +		}
> +		migrate_vma_collect_skip(start + PAGE_SIZE, end, walk);
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +
> +fallback:
> +	spin_unlock(ptl);
> +	ret = split_folio(folio);
> +	if (fault_folio != folio)
> +		folio_unlock(folio);
> +	folio_put(folio);
> +	if (ret)
> +		return migrate_vma_collect_skip(start, end, walk);
> +	if (pmd_none(pmdp_get_lockless(pmdp)))
> +		return migrate_vma_collect_hole(start, end, -1, walk);
> +
> +	return -ENOENT;
> +}
> +
> +static int migrate_vma_collect_pmd(pmd_t *pmdp,
> +				   unsigned long start,
> +				   unsigned long end,
> +				   struct mm_walk *walk)
> +{
> +	struct migrate_vma *migrate = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long addr = start, unmapped = 0;
> +	spinlock_t *ptl;
> +	struct folio *fault_folio = migrate->fault_page ?
> +		page_folio(migrate->fault_page) : NULL;
> +	pte_t *ptep;
> +
> +again:
> +	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
> +		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
> +
> +		if (ret == -EAGAIN)
> +			goto again;
> +		if (ret == 0)
> +			return 0;
>  	}
>  
>  	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> @@ -175,8 +284,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
>  		}
>  
> -		/* FIXME support THP */
> -		if (!page || !page->mapping || PageTransCompound(page)) {
> +		if (!page || !page->mapping) {
>  			mpfn = 0;
>  			goto next;
>  		}
> @@ -347,14 +455,6 @@ static bool migrate_vma_check_page(struct page *page, struct page *fault_page)
>  	 */
>  	int extra = 1 + (page == fault_page);
>  
> -	/*
> -	 * FIXME support THP (transparent huge page), it is bit more complex to
> -	 * check them than regular pages, because they can be mapped with a pmd
> -	 * or with a pte (split pte mapping).
> -	 */
> -	if (folio_test_large(folio))
> -		return false;
> -
>  	/* Page from ZONE_DEVICE have one extra reference */
>  	if (folio_is_zone_device(folio))
>  		extra++;
> @@ -385,17 +485,24 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
>  
>  	lru_add_drain();
>  
> -	for (i = 0; i < npages; i++) {
> +	for (i = 0; i < npages; ) {
>  		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>  		struct folio *folio;
> +		unsigned int nr = 1;
>  
>  		if (!page) {
>  			if (src_pfns[i] & MIGRATE_PFN_MIGRATE)
>  				unmapped++;
> -			continue;
> +			goto next;
>  		}
>  
>  		folio =	page_folio(page);
> +		nr = folio_nr_pages(folio);
> +
> +		if (nr > 1)
> +			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
> +
> +
>  		/* ZONE_DEVICE folios are not on LRU */
>  		if (!folio_is_zone_device(folio)) {
>  			if (!folio_test_lru(folio) && allow_drain) {
> @@ -407,7 +514,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
>  			if (!folio_isolate_lru(folio)) {
>  				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>  				restore++;
> -				continue;
> +				goto next;
>  			}
>  
>  			/* Drop the reference we took in collect */
> @@ -426,10 +533,12 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
>  
>  			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>  			restore++;
> -			continue;
> +			goto next;
>  		}
>  
>  		unmapped++;
> +next:
> +		i += nr;
>  	}
>  
>  	for (i = 0; i < npages && restore; i++) {
> @@ -575,6 +684,146 @@ int migrate_vma_setup(struct migrate_vma *args)
>  }
>  EXPORT_SYMBOL(migrate_vma_setup);
>  
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +/**
> + * migrate_vma_insert_huge_pmd_page: Insert a huge folio into @migrate->vma->vm_mm
> + * at @addr. folio is already allocated as a part of the migration process with
> + * large page.
> + *
> + * @folio needs to be initialized and setup after it's allocated. The code bits
> + * here follow closely the code in __do_huge_pmd_anonymous_page(). This API does
> + * not support THP zero pages.
> + *
> + * @migrate: migrate_vma arguments
> + * @addr: address where the folio will be inserted
> + * @folio: folio to be inserted at @addr
> + * @src: src pfn which is being migrated
> + * @pmdp: pointer to the pmd
> + */
> +static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
> +					 unsigned long addr,
> +					 struct page *page,
> +					 unsigned long *src,
> +					 pmd_t *pmdp)
> +{
> +	struct vm_area_struct *vma = migrate->vma;
> +	gfp_t gfp = vma_thp_gfp_mask(vma);
> +	struct folio *folio = page_folio(page);
> +	int ret;
> +	spinlock_t *ptl;
> +	pgtable_t pgtable;
> +	pmd_t entry;
> +	bool flush = false;
> +	unsigned long i;
> +
> +	VM_WARN_ON_FOLIO(!folio, folio);
> +	VM_WARN_ON_ONCE(!pmd_none(*pmdp) && !is_huge_zero_pmd(*pmdp));
> +
> +	if (!thp_vma_suitable_order(vma, addr, HPAGE_PMD_ORDER))
> +		return -EINVAL;
> +
> +	ret = anon_vma_prepare(vma);
> +	if (ret)
> +		return ret;
> +
> +	folio_set_order(folio, HPAGE_PMD_ORDER);
> +	folio_set_large_rmappable(folio);
> +
> +	if (mem_cgroup_charge(folio, migrate->vma->vm_mm, gfp)) {
> +		count_vm_event(THP_FAULT_FALLBACK);
> +		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +		ret = -ENOMEM;
> +		goto abort;
> +	}
> +
> +	__folio_mark_uptodate(folio);
> +
> +	pgtable = pte_alloc_one(vma->vm_mm);
> +	if (unlikely(!pgtable))
> +		goto abort;
> +
> +	if (folio_is_device_private(folio)) {
> +		swp_entry_t swp_entry;
> +
> +		if (vma->vm_flags & VM_WRITE)
> +			swp_entry = make_writable_device_private_entry(
> +						page_to_pfn(page));
> +		else
> +			swp_entry = make_readable_device_private_entry(
> +						page_to_pfn(page));
> +		entry = swp_entry_to_pmd(swp_entry);
> +	} else {
> +		if (folio_is_zone_device(folio) &&
> +		    !folio_is_device_coherent(folio)) {
> +			goto abort;
> +		}
> +		entry = folio_mk_pmd(folio, vma->vm_page_prot);
> +		if (vma->vm_flags & VM_WRITE)
> +			entry = pmd_mkwrite(pmd_mkdirty(entry), vma);
> +	}
> +
> +	ptl = pmd_lock(vma->vm_mm, pmdp);
> +	ret = check_stable_address_space(vma->vm_mm);
> +	if (ret)
> +		goto abort;
> +
> +	/*
> +	 * Check for userfaultfd but do not deliver the fault. Instead,
> +	 * just back off.
> +	 */
> +	if (userfaultfd_missing(vma))
> +		goto unlock_abort;
> +
> +	if (!pmd_none(*pmdp)) {
> +		if (!is_huge_zero_pmd(*pmdp))
> +			goto unlock_abort;
> +		flush = true;
> +	} else if (!pmd_none(*pmdp))
> +		goto unlock_abort;
> +
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> +	folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
> +	if (!folio_is_zone_device(folio))
> +		folio_add_lru_vma(folio, vma);
> +	folio_get(folio);
> +
> +	if (flush) {
> +		pte_free(vma->vm_mm, pgtable);
> +		flush_cache_page(vma, addr, addr + HPAGE_PMD_SIZE);
> +		pmdp_invalidate(vma, addr, pmdp);
> +	} else {
> +		pgtable_trans_huge_deposit(vma->vm_mm, pmdp, pgtable);
> +		mm_inc_nr_ptes(vma->vm_mm);
> +	}
> +	set_pmd_at(vma->vm_mm, addr, pmdp, entry);
> +	update_mmu_cache_pmd(vma, addr, pmdp);
> +
> +	spin_unlock(ptl);
> +
> +	count_vm_event(THP_FAULT_ALLOC);
> +	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
> +	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
> +
> +	return 0;
> +
> +unlock_abort:
> +	spin_unlock(ptl);
> +abort:
> +	for (i = 0; i < HPAGE_PMD_NR; i++)
> +		src[i] &= ~MIGRATE_PFN_MIGRATE;
> +	return 0;
> +}
> +#else /* !CONFIG_ARCH_ENABLE_THP_MIGRATION */
> +static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
> +					 unsigned long addr,
> +					 struct page *page,
> +					 unsigned long *src,
> +					 pmd_t *pmdp)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /*
>   * This code closely matches the code in:
>   *   __handle_mm_fault()
> @@ -585,9 +834,10 @@ EXPORT_SYMBOL(migrate_vma_setup);
>   */
>  static void migrate_vma_insert_page(struct migrate_vma *migrate,
>  				    unsigned long addr,
> -				    struct page *page,
> +				    unsigned long *dst,
>  				    unsigned long *src)
>  {
> +	struct page *page = migrate_pfn_to_page(*dst);
>  	struct folio *folio = page_folio(page);
>  	struct vm_area_struct *vma = migrate->vma;
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -615,8 +865,25 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
>  	pmdp = pmd_alloc(mm, pudp, addr);
>  	if (!pmdp)
>  		goto abort;
> -	if (pmd_trans_huge(*pmdp))
> -		goto abort;
> +
> +	if (thp_migration_supported() && (*dst & MIGRATE_PFN_COMPOUND)) {
> +		int ret = migrate_vma_insert_huge_pmd_page(migrate, addr, page,
> +								src, pmdp);
> +		if (ret)
> +			goto abort;
> +		return;
> +	}
> +
> +	if (!pmd_none(*pmdp)) {
> +		if (pmd_trans_huge(*pmdp)) {
> +			if (!is_huge_zero_pmd(*pmdp))
> +				goto abort;
> +			folio_get(pmd_folio(*pmdp));
> +			split_huge_pmd(vma, pmdp, addr);
> +		} else if (pmd_leaf(*pmdp))
> +			goto abort;
> +	}
> +
>  	if (pte_alloc(mm, pmdp))
>  		goto abort;
>  	if (unlikely(anon_vma_prepare(vma)))
> @@ -707,23 +974,24 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  	unsigned long i;
>  	bool notified = false;
>  
> -	for (i = 0; i < npages; i++) {
> +	for (i = 0; i < npages; ) {
>  		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
>  		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>  		struct address_space *mapping;
>  		struct folio *newfolio, *folio;
>  		int r, extra_cnt = 0;
> +		unsigned long nr = 1;
>  
>  		if (!newpage) {
>  			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> -			continue;
> +			goto next;
>  		}
>  
>  		if (!page) {
>  			unsigned long addr;
>  
>  			if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE))
> -				continue;
> +				goto next;
>  
>  			/*
>  			 * The only time there is no vma is when called from
> @@ -741,15 +1009,47 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  					migrate->pgmap_owner);
>  				mmu_notifier_invalidate_range_start(&range);
>  			}
> -			migrate_vma_insert_page(migrate, addr, newpage,
> +
> +			if ((src_pfns[i] & MIGRATE_PFN_COMPOUND) &&
> +				(!(dst_pfns[i] & MIGRATE_PFN_COMPOUND))) {
> +				nr = HPAGE_PMD_NR;
> +				src_pfns[i] &= ~MIGRATE_PFN_COMPOUND;
> +				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +				goto next;
> +			}
> +
> +			migrate_vma_insert_page(migrate, addr, &dst_pfns[i],
>  						&src_pfns[i]);
> -			continue;
> +			goto next;
>  		}
>  
>  		newfolio = page_folio(newpage);
>  		folio = page_folio(page);
>  		mapping = folio_mapping(folio);
>  
> +		/*
> +		 * If THP migration is enabled, check if both src and dst
> +		 * can migrate large pages
> +		 */
> +		if (thp_migration_supported()) {
> +			if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
> +				(src_pfns[i] & MIGRATE_PFN_COMPOUND) &&
> +				!(dst_pfns[i] & MIGRATE_PFN_COMPOUND)) {
> +
> +				if (!migrate) {
> +					src_pfns[i] &= ~(MIGRATE_PFN_MIGRATE |
> +							 MIGRATE_PFN_COMPOUND);
> +					goto next;
> +				}
> +				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +			} else if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
> +				(dst_pfns[i] & MIGRATE_PFN_COMPOUND) &&
> +				!(src_pfns[i] & MIGRATE_PFN_COMPOUND)) {
> +				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +			}
> +		}
> +
> +
>  		if (folio_is_device_private(newfolio) ||
>  		    folio_is_device_coherent(newfolio)) {
>  			if (mapping) {
> @@ -762,7 +1062,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  				if (!folio_test_anon(folio) ||
>  				    !folio_free_swap(folio)) {
>  					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> -					continue;
> +					goto next;
>  				}
>  			}
>  		} else if (folio_is_zone_device(newfolio)) {
> @@ -770,7 +1070,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  			 * Other types of ZONE_DEVICE page are not supported.
>  			 */
>  			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> -			continue;
> +			goto next;
>  		}
>  
>  		BUG_ON(folio_test_writeback(folio));
> @@ -782,6 +1082,8 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>  		else
>  			folio_migrate_flags(newfolio, folio);
> +next:
> +		i += nr;
>  	}
>  
>  	if (notified)
> @@ -943,10 +1245,23 @@ static unsigned long migrate_device_pfn_lock(unsigned long pfn)
>  int migrate_device_range(unsigned long *src_pfns, unsigned long start,
>  			unsigned long npages)
>  {
> -	unsigned long i, pfn;
> +	unsigned long i, j, pfn;
> +
> +	for (pfn = start, i = 0; i < npages; pfn++, i++) {
> +		struct page *page = pfn_to_page(pfn);
> +		struct folio *folio = page_folio(page);
> +		unsigned int nr = 1;
>  
> -	for (pfn = start, i = 0; i < npages; pfn++, i++)
>  		src_pfns[i] = migrate_device_pfn_lock(pfn);
> +		nr = folio_nr_pages(folio);
> +		if (nr > 1) {
> +			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
> +			for (j = 1; j < nr; j++)
> +				src_pfns[i+j] = 0;
> +			i += j - 1;
> +			pfn += j - 1;
> +		}
> +	}
>  
>  	migrate_device_unmap(src_pfns, npages, NULL);
>  
> -- 
> 2.49.0
> 

