Return-Path: <linux-kernel+bounces-758398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A674B1CE77
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AF33A5DA0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1BC22AE7A;
	Wed,  6 Aug 2025 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4xyA+Th"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC222A1E1;
	Wed,  6 Aug 2025 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515884; cv=fail; b=gYlScw7yz98QIuEZPdoohzJhU4ejCDgoQh0g0mZTjyORlq8GqoMYBYFi+Z8ix7gOqql27fM3hq7vzMVAuwIb9NhwUVzqpsGeV9ipBDA1+0UM2HpeorhRGZcvJFz+ApHRe99w+6A0otBmCpRKvQt7eno9jhWIG6ebXDkpuWq4OkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515884; c=relaxed/simple;
	bh=mWTQckj59HCK743bk9Odd2oTc1KfxC/RDh8510Wjavk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F9EsbojCTzJMYnwfN88Li5w4h61Ve1oxW3sM8+di9frREfO4UsDuP71K9Dhhz8g3SSwK1ayMofghP5oHv8UutTRQiXjkdXwMUBgSU3+VuVg/DNNzcSXT/CfCnGHLlNr0JXsZGVgkGWrkAqA6Jpqrg+04G9ZSaohMKjEa4F6lS9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4xyA+Th; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754515883; x=1786051883;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mWTQckj59HCK743bk9Odd2oTc1KfxC/RDh8510Wjavk=;
  b=l4xyA+Th9SzNxkPFpH6LqEkl0SQa9oAKWrYHahRV9tw3Y0Ym89oKnlH1
   IKTNI0j4lE5rmnYWllKxdZ7AGPPbpdXesRXZtr532d/5Kn/9UisoCIYfH
   CXX6JEcWz7lZkWuvzJ+F9LXA/ZxiDwG7pc4MSM2rAu2v7wpTD+xbKJoYg
   YVK78GkbsHlioTKuIK3pHTqIGZQgxJTyOK2OVYZM0vmBnOE2oJN+D/1zK
   zKCM2U/tTRjJK3Pb1S8/y4uO2rql9daQjk4X+WRD4JdZxmvXqRsxHb7UW
   ndeiFmAjMh0Dga0D9UK+MayjFqijX6syVnVDZjPEUA+RBNzlP6DUosweh
   g==;
X-CSE-ConnectionGUID: E0pFcHg4R9Wt21Lmz44seQ==
X-CSE-MsgGUID: tt0UsuXcTSulWW0UYEF5Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67922714"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="67922714"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:31:22 -0700
X-CSE-ConnectionGUID: NdEmPwqxRYmjYVsMd8lZfw==
X-CSE-MsgGUID: KJadICWQSjGNjXywKT6TaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165678637"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:31:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:31:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 14:31:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.80)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1TMigz1ZLufRDkfkABd5cs9JcG4rqwOKHcQuCKSVv0A09iufNY5Ov0sO0sz7+B65EhbGWDD5e1rlZ2ckDelE7VXwBHcHqQg/iRnUq+ncII5cUb0Ei2jZ5HkkyLl8WtiG7RkRQi3X5y2gjox/YLz+OXNF5irPkoUVmmL2Cr+FeeYzYADdsJKzhEY87c3CJCTrMoqpp2NAGQFZDXKd66oul0ykJAx1dkl6PBEyb77GlxBM9xqUwRgOsNLHJ9heWD75psP2LWZ63hjvlauTZa3uahr38NQ0WRPaQk1JRUZkQF0qGG8QXN0lKm3gaVq80B21gNaqVtbn7Bwcx5k+fBFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xsD3J7DcHPuO8y17PHj+ZEdw6DkDzhiw2o4SSB0Mk8=;
 b=CvA5YVtBr9bOzC8pJLmmAIIps3u8CmQ4y7Eo9na3DBGVzfDnpsVR3/jYzWI07Ud34ODMambG71p/nIaVsBAxpa53hqmZePu4dfheR5xCX8+9i76hoW9oJc7BvWOCw2VHxI9HH1iEK/ZWjSpaqx6AdFJ2jekjlFXSyoVqWhIAAsvClEAnmeQs4aoq3EfCXlPk1wlcDHJOJsk80j53qR+Vo8v6DZuLYaOAcJL+lSOB4IBi0gSyryF+YUOAWftQnOt2jv8DBB+zotk1PYDcqEyfkhzS3YHLDRyJWuAk8GOtkmK+hMBmKwFiDE8AioHi8IvigUTnM7k41IM9qieILssOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 21:31:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 21:31:11 +0000
Message-ID: <f07836ca-8504-4619-861d-c2e9a6f517c0@intel.com>
Date: Wed, 6 Aug 2025 14:31:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 13/34] fs/resctrl: Introduce interface to display
 number of free MBM counters
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1753467772.git.babu.moger@amd.com>
 <9e805169d3fbc889a89b283d074a5dff23cb0e94.1753467772.git.babu.moger@amd.com>
 <a549c986-5914-4e00-81d0-994c933550c2@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a549c986-5914-4e00-81d0-994c933550c2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA4PR11MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: f705e9c4-7f28-400b-9868-08ddd5309058
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDhTbWVjSC9tOFF4MTJXSE9LSkVqSFliRlBQYjJZZVdER1BZclNoNFZ4VG9o?=
 =?utf-8?B?WEdmWENrWVFsV2hGYUc0SFFoMlllUlhiWi9jaGlxcldzVC8yTDZNOG5qMWRx?=
 =?utf-8?B?M0x1QW15QWczU2E4Y0YxanoyaFNvZlJVWjByaDlZVU1HTmwwbFQzZVJjeW9O?=
 =?utf-8?B?bkVQVEczZ25NU2NicU1wbjA0OFR5U3I3TXJpRlZZMW9GUTBta0FQY2NZVkxS?=
 =?utf-8?B?eGFnSDdmK1ozeVM0TWgvZzhKTDM5WlpFNTZwSUNZYUdrdDA0SktkRWQ0M2dJ?=
 =?utf-8?B?aUVVYkFKZnVhZHNGUWlPalBHRU9melRSd2txSC92YWNkZ2tEVzU4ZkFyS1Nw?=
 =?utf-8?B?QXlTVTluWVZXcjlMNkxQNFhkN1lJY1lvRmxvRnB1NnVQajRRY0JhV0tacTl0?=
 =?utf-8?B?OVFXSE81dll0R0YzTVRpVEhnN3doRVRZUklpRmt3Y2FEWExOUjRFZ3hDSDU1?=
 =?utf-8?B?YUJZZG10Slo4QVBNbUpacytPRDMweXZHNW8yKzBsY3dXdUJ0VUp5WDY0VHhJ?=
 =?utf-8?B?SWxMQ0t3SmtuUUxRMFNXUk94YjRJemluS0g4bTNEaUlKN2FoQm0vZEJEZ1N3?=
 =?utf-8?B?QitodEZvWkI2aG9DZUU0ZnlmTERoVDFneWE3VmFuc3gyUDlUeVY5d3phdGpq?=
 =?utf-8?B?S2pXZzg4THQ3Y0pKL0NQTDYxSnRxcUM5V1ltRFdhMGIzQkZCUHVwcklRbFhw?=
 =?utf-8?B?cTdFQjFUVHMwOUFXcnVUNG9aakVYN2pNaVExUHBCUGZ5RUlmNktROUNGODZ5?=
 =?utf-8?B?Wnl5Z21Zdy8zMFpTZW8ySkxvZHpVa1QvemRyKzFjckdRdzZpTEVpOEpnd2Rw?=
 =?utf-8?B?NUM4dXZqVklOR0NYQW9vcTV4N21CM3RHQU1VcW0zd0FPUVpGSlBDSnJyWVZZ?=
 =?utf-8?B?bUV6UGIxdURFaTBXY2xvRFhsUnJJU2dMQ0xqS3pxSG9walRmLy9LWmYvNzg0?=
 =?utf-8?B?M1d2citxV0J5Ty9JcS91NlNsQWVZcExUQjRIMFYzeW9Hb0hTNHA2N1VTd1RH?=
 =?utf-8?B?ajV3QlB0bUxpc2NWQWptOGFQc3AveHY0WSsxVXVKcHJ0dnZ6Q3BIUUlvZmta?=
 =?utf-8?B?MTArbS9rSWc2SkdCbk1oZGRoajRHbVppaThqOWc5bU00OVovRGJnK0J0Y1ht?=
 =?utf-8?B?OWcwUkdqM1lraU9WSFg4bDZUVTdFT3FkNHdOV1lyb1ZlTHJ5MTh4ZUQzTDh5?=
 =?utf-8?B?VXhYeTBMek9BNVNhYTJzcVZRb3lqNzZ5T1hYby9FQ1RFM1RIMTJyRisyd09E?=
 =?utf-8?B?MDBzU0xBQzJCTHhBdWJJYUxYUkxPSGcrNWNuR2VIVXM4QTgzYmF3L25oUHU1?=
 =?utf-8?B?bHNTcUx5dTlGZzdrV3NXZTA1allHR2p3Mk5nQjlBTkFaVHBkN2tUWUtkUnpU?=
 =?utf-8?B?bmY2anFMZTlmbm1qaFphM2s2NWJHTzFlaWxBUVltdFd4aytTd1JYTGxUQUsw?=
 =?utf-8?B?SWo4SzZDd1pkM1EvbEpteXBaNHo1NkFLR0VsZmhIUjFkVjkzQUR2M3A0T2FF?=
 =?utf-8?B?YStOUE53VndVYS8zazlSY2JZcXlCcjZoSUhCYXFmS0pSN09vMTNSODRSaUpJ?=
 =?utf-8?B?UjJ1Q081Uy84VXFWNDBLVGdHeTl0WUdmWUkzNCtkNjE3NGR5bS9ZNmdLSmZE?=
 =?utf-8?B?czExaGxXZ1hCM1ZKSW9CcXpLQVgxSlpRWnpNcy9QeHhpa1RIdHlCNXFRWW5G?=
 =?utf-8?B?NUlvU1p2S2VjKzhScVdPR21xUE9GenNPWHdTeUZJVVhGWmZhdzliVTlIMWFC?=
 =?utf-8?B?b3lwQVNXdVBtaFdjL21kV0JrUjNwU2tibXVSejh6OHZPUW5rMVFKWW8yL2Z6?=
 =?utf-8?B?R1prNEV0T2UwWEJ5dDljUmRBUWQyUDJxcmhoTmlCUk54YWVHd1hRM0d1cXlR?=
 =?utf-8?B?amxNNEZrRlNOaTVhc3p1ZmZSQjBpNndZSDJzcFdlQWJMMVp4WmNUc2N5OEc1?=
 =?utf-8?Q?xxz9RyFFnus=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1NYVXRnME80L1AxUUhQV1E5dzBuRWlQVjlXMmdQWFRma1gyZUh2bzZ2L0Iw?=
 =?utf-8?B?S0wzS2NNRk1jZmdEVlluenRvZG4yMG01bEY5K2YydUtHS0NuOGYyQTBPLzRn?=
 =?utf-8?B?ZmYvcUVzSlNMT0k1Y2lmQWVSUHVmYUtsODRsdDNscVIvMlB0bWYvWnFJQTQ0?=
 =?utf-8?B?TGdpcmhDZEFheHNpWnlIY2xIVjZYQUJTU2I3dDFrMHdxNGM5RXhWenN6c3Fk?=
 =?utf-8?B?ck5ic2tSZFE0dHFmL0V4Y2dwQnYzQVdLUXRYVlprVUhSd2xCbTRRRU9KVlRh?=
 =?utf-8?B?MCtLbUIweVJYbnZLenZuTit3dGx3cnBQSzd5a281MFBxcmxOdUZMSDFtZnJn?=
 =?utf-8?B?L2tkbWFhSFFVOUtTVnlqMk1WN1JyeXg4djdoVDJlUDNiY3dsYlZFSlNxejFj?=
 =?utf-8?B?VGU3Z2NmL01FZ0VtcjU1TUJMWGV2MmwxWFpjQnlCMzVoeEpDY3o1NGhjR2Zm?=
 =?utf-8?B?Y25oKzZkcXQrZmRSbFhDV2xFMU05bWJySldUamdZYktQSld6MkJyMXMzTVBQ?=
 =?utf-8?B?Sml1Zkh4dGdOck1uYTdNUENUT3R5WFdGYjBSOUlZOGNmeDlDRWRtYnMxR25X?=
 =?utf-8?B?RUxTTkZ5ZkZIbGp0Z1IwcTVlbXpvZkxtOG1oZDF6TkZvTXR5ZmpTb1RBWlZQ?=
 =?utf-8?B?dFZEbkQwQXFCa2xvaEs1TXVtOHVCZUpvZk5Yd2drSlUrY0lLd1g2ZExJNnpK?=
 =?utf-8?B?Vi9tUjJhNlFkMjBySHc1MzJDTGFDMzBsb2RLak1nd0hLMFU5TmJZc3k0SlJJ?=
 =?utf-8?B?U3h4TUdGTkF0ZXZwN28rSzJ1OUZ0NnhPQkhwYTZRWjZzMkxVd21KM1ozUUx1?=
 =?utf-8?B?cStqRUpLRTFvZkRqcjE0Nm55SmRMTklZR2QwVWw5ZUMxMUVNUWRCVUdKNW5D?=
 =?utf-8?B?ckUwR25mTlNFd1VCNnJGdWZ0TXZiNzZsMUdYOTdIT29OYkgwbkVGMGM4U3N3?=
 =?utf-8?B?ZHZjVGlFclhuREZEbHpqTTk3a0VyMUhIU2JMRCttMjltcEZhOUxrVGFwSGFp?=
 =?utf-8?B?VkhkWDNya1FzNkJaYU9heHhtOStXdjNndDA4YUVDK2hGdzhqaHJmbVFRSnJT?=
 =?utf-8?B?NmhlZUhDSnFuRTExUVFzOThEa3E0a0MwODlVZHd4L2J3RFh4M0V3QWxiR3lh?=
 =?utf-8?B?Umd6OEZZSFhiZXhuN3lWMndXYmE5LzJHU3FBMFhFR1hXb2pYVlkrblJSOW1L?=
 =?utf-8?B?eXVXbk1BQTY0amhpSVNxOHNzcllyVWtNZGFWWkxOcVRPUjZ0c1hHV2lVOE5h?=
 =?utf-8?B?YVRzbnZEM2hWWnhDWmtuUzRwNmJ3WjZBSGdxOG1YS1A2VThhNlB3UlNvYWFi?=
 =?utf-8?B?TDJvMDgwT3gzYW5OV0hhbHJOdTl2TGljVzRsWG0vM2thZTNBekRPVWdhTkZz?=
 =?utf-8?B?Uityd1hjaTVNODVOOHh1UGhCck5HdjBjTEF4TEY2UWhjOXN6cmR2RHB2UWJ5?=
 =?utf-8?B?VExydW1wUXBJQmVWV0ZyR1NoWTcvNmcxOTkvejJ3dmxycVlUM0orT2RLbmpQ?=
 =?utf-8?B?aDJzeXZDV3ZnZHh5YkhUbmpFSkk4d0cyYy9ZY3doQnhhZHVIQTkvcForV1l3?=
 =?utf-8?B?bTRYM0wxelFEc0RKeXBGSXo1UjJ0aHFkV1loeVc4SS9OTzkrOGxFSlN4Q1FL?=
 =?utf-8?B?Yk4yZlhCK0FhdkprRmc5Qi9PdXdjTjFxKzErYmo4WEc3NDA2UzFNc0duQnY0?=
 =?utf-8?B?ZThBRXhrNkh4ejkxckNIRCtkWFFscEJMUHBLWU45cE5aczh0NDJXNkx4ZmlD?=
 =?utf-8?B?YmlTcU5LTnhaelZxTnZvbmVhSUtnZGtZR1RVaURva2hDSjQ4SmIrQU5oVmNN?=
 =?utf-8?B?a0xDa2xnWU40VjZRcy9ha3pZaWRxWkZCM29YNGZmRGlidHdSSXZKa1Z6NEY2?=
 =?utf-8?B?SlRYWW5tYkx6SW9pYlZlZFhtTmlUN1hqYmQrY3R5NE9WUzd2bUZveXNxUHRj?=
 =?utf-8?B?NVJTc0lMcnlCdlROVkVQNUcwSzZmSkI4Y0ZwL2NHd0prMUY1N1pZK0x5cGRO?=
 =?utf-8?B?TUZDQndaUTkwWVp2OXBvQXF0Qk0vM25zVnRXbm5qYXdMMTVxWmJkdmFTcHRw?=
 =?utf-8?B?SWFzaFlsMnN5WVYvZTBVYVc3L3FOSVVmNlJlK01TZytLWjhZQWF2TE5BUFEv?=
 =?utf-8?B?akVHeHJsemZkWFFhd2wrTkxxVkdXUzZFYUhGeWZMQjhQdk5KWWhYTzZoK09p?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f705e9c4-7f28-400b-9868-08ddd5309058
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:31:11.4464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaoM4+3w6Xs5+mbPIX5uoieYK8PIzMGt46u1eX+WNRAfR843QXZJ8R07uqVIiGmEFTCBw0BCrfEjMeyiIazXouBjCZ6KtJJvtU2M5hvd5nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9204
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/25 2:19 PM, Moger, Babu wrote:
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index a09566720d4f..15d10c346307 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1853,6 +1853,48 @@ static int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
>> +					    struct seq_file *s, void *v)
>> +{
>> +	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
>> +	struct rdt_mon_domain *dom;
>> +	bool sep = false;
>> +	u32 cntrs, i;
>> +	int ret = 0;
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		rdt_last_cmd_puts("mbm_event mode is not enabled\n");
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>> +		if (sep)
>> +			seq_putc(s, ';');
>> +
>> +		cntrs = 0;
>> +		for (i = 0; i < r->mon.num_mbm_cntrs; i++) {
>> +			if (!dom->cntr_cfg[i].rdtgrp)
>> +				cntrs++;
>> +		}
>> +
>> +		seq_printf(s, "%d=%u", dom->hdr.id, cntrs);
>> +		sep = true;
>> +	}
>> +	seq_putc(s, '\n');
>> +
>> +out_unlock:
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +
>> +	return ret;
>> +}
>> +
> 
> This also can be moved to monitor.c.  What do you think?

Yes, I believe monitor.c is most appropriate for all the monitoring
related handlers [1].

Reinette

[1] https://lore.kernel.org/lkml/0fa9a12b-e900-4ceb-b59c-e653ec3db0ca@intel.com/

