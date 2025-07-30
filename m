Return-Path: <linux-kernel+bounces-751264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596E4B1670D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25747B1F94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B341E570D;
	Wed, 30 Jul 2025 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKfJKn8/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844042AA4;
	Wed, 30 Jul 2025 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753904836; cv=fail; b=G22GMqajtZmS19hdwr+JRS7/yxYybRHG38WNhLd156vqwwDYJvO/7Dyjqas0s3/kcKuX0MQzJDFwyQZu/ZWKS3M/wLm+hF7kKy2fY2vYC/reK04r2bzgj4jxPQRrOtBhdvYjqTKoI/NJor9J0oO8uyZnWn/7KVgZvobWrRldfAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753904836; c=relaxed/simple;
	bh=89UkyiKCqu5hpipYGdBArBInS8NPa+YhN4DJIlmF1bY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uEdStHaXWg8wtOhmjezLOa2Js9vTKxG3bTJYmzCbaKchgdrNm4xQRiYp+CJFZ/HnU04W8yL7ApLYFqOp3UmfWpxdckjwXaTAWXlWEnDj3N+DHJARUGlpp+OikqtW6iyTFjntqZg9+lEgW+tMPAlJG1O2iCzyE5kRkmQKsW4tHCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKfJKn8/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753904834; x=1785440834;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=89UkyiKCqu5hpipYGdBArBInS8NPa+YhN4DJIlmF1bY=;
  b=KKfJKn8/Mqmvo3nKtFVs0uliv3DZrLu6SsFLzxaW9z8FRwLo/hmmxn8G
   nPaoMdK+xLwXcQ3sR0ov4Te63Oebs5YqlIOepyPK171yks+rmbvQkfbwc
   A6WWUhUPc4lpoNfYmQjOO/XKpjTS26llbTE4K4mfTcga+zz8wr8zFi7z9
   3oh8OsjXdaaodum79Lt8sWE4LME9zqbFhWSPx1mfMfoxuB7Kh169exKNK
   4SKjAoTQfAXwgOZpPkFTXIWGA8NhSz5EYavd8KOs+CwlOU0f8IsrkABpt
   ChVMEd99yrgcPMvforQxKMiz+7Tb2wEP0kfMxZbMAvZrlg70aW0qjS11H
   Q==;
X-CSE-ConnectionGUID: dAYNZXL7Q2qp/81HuEdvqQ==
X-CSE-MsgGUID: ys1vxUTvRMOG44TQCqRrxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56150039"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56150039"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:47:14 -0700
X-CSE-ConnectionGUID: 3K+xhAkQRaSjF9o59IK7ag==
X-CSE-MsgGUID: JzfZGQ9sRvS68UPQ3UfAPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162334652"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:47:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:47:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 12:47:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:47:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2sFveMpnSiN/qK+rovWalwyybFvs+5bNNvb6BJqQ8TGpYaAye9HRKdcfZNbEdJh4+uYGDuOdFlxNv3DCLk9R16cP1ouvdUm3I/z+oz68SMoRs+IRU0AnuBuEw73FMeUbuCEcVxUTZkhcoLnlMgHrW7Xo+rFYktmTvTziG0ejeqiTE0WXSsvjU58ynxpWG21OnhCyd47IeyQSVA+2M4DYuZHQs3mO+e2qMCe8lXEoS6H/jG27ocCjWINJYnx/JvVk22tuEKZYVmrB/shyVoIpsppRIUrTkNoLiXNUrF80swYr+CMEUD1a2uKP+405RhMhW+qAJqQ5tXIaiIEH5lKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRcQD6jR5fQdtV9EVaasfkUhsYae+SzD0nNrzuVsZYk=;
 b=ud0sxSdj3XqbnARPpk6KNWK1wemBOZMeKXJgDM0JSAUmA6HkG3ukj/9hPeIdIc5HDfsyt6MgNVxcz0LnWO9J6TQFZ9qk0qB2/EB2PV0kSHPmxDKJHz3sZtZgwQpJmk0QANtm/2kz6164gmlF3IjGeEgyX6bqoL2k286E+wfm1teu3h3J/6gRnHveTJ0ZirYRJhih2Pv/b9w+Z7EiN4/dusIqMj1IDuXaRk2ThJqK08QvhOAfxFZqRofaitDjEcVYndgHXA2oxi0YkNH8o9OGOS5OsIofdymt2DFR/VHCJgJUTSvYYVWovhLg8dlKogO7B08XEF7ggblIZg3JQCzSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:47:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 19:47:08 +0000
Message-ID: <a259ff37-9e3e-4b4f-970f-04610c35f4cf@intel.com>
Date: Wed, 30 Jul 2025 12:47:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/34] x86,fs/resctrl: Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
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
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 522975a5-b35a-4843-ea84-08ddcfa1de85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3E0OEhIUktKQWJWZWZwTVNQdmsvWksvT1JrSVNzKzFYRjBFSmJIYWNLeU1X?=
 =?utf-8?B?U3lWbkFKQWJjUnZGdk52WWFoamJFcXZLdFBnU3RMdzdzQmpTMVRRbGVoUFFT?=
 =?utf-8?B?Uk41TWczR2UwSkRWSXRnbWpwVUNmMjVPdnVlMDMvRW4yYW5LYlRPQlBUUCtu?=
 =?utf-8?B?U0xKbTMrNFM3YjNJWDBpM0gyQXZIcVFDdUpBRTA5MXc2WWg0MWJsc1pRZVd6?=
 =?utf-8?B?d0tiRWlQL2s4T0MwREpEQTgvWFZ6V2cvWVhTRUJQbFRHQzRORjA0M0hUOVh5?=
 =?utf-8?B?cXpCZnFQanAwanVodUdHRmVwYm5KR2pEamxWalVManNGdVlsbEdGSmdKSWN3?=
 =?utf-8?B?M0VWeHRmYTVGTTlqcTBYVXV3ZHI3VHRNaTFmeFVkSUttNk5oNFZ6Z2NyVGd4?=
 =?utf-8?B?MGhDM2RzSHNmbUlGbTd1VjdwWWE1Q0c2QStTeDJ4ZGJTVVpkUE1kRnZTT3ZN?=
 =?utf-8?B?a0xpdThmUzVoSDB5YUE2M09GWk1CUU8yODF0cVEyV0ZqMHJoRmhPQkRpejhU?=
 =?utf-8?B?cGJLUGZEc2M5eUk5c2h4eUlsSER6VE1CZS9Ucm8wdW1IZ3FvcmYxVXkyeGZT?=
 =?utf-8?B?V0RMSVN0S3M3eFVhREhiOUFERVBkeDdSeXZjSEVpRktjNkpndmpJNDUxVGNM?=
 =?utf-8?B?RnFFbWRpWkNncTd4M0R2OGN1NVZLOEFVQi9XVjVTREpqbTFhY2FPRy9NeUov?=
 =?utf-8?B?b21odmhqZkRsV1N3Z0s0UTBmWUpkRndUblFqY3puRnpBMnhWcjJIU25la0pU?=
 =?utf-8?B?K3M2VTZKbUgwL09GcktsbXBIalBEejVrRDdEaUFHczJUdXNnS1c0dGk3Znk4?=
 =?utf-8?B?SXk2WkZqSDRFbzQ3Rzk0OU51NEVBZzJjVE5NZ21DeWNjUXcyVUNBc2NhZkhE?=
 =?utf-8?B?R1BFV0JwZGhPbStmaDFWNzJESmJBNUxVQTRQOEVwNXAvZGp6ZjhucmRJSHBa?=
 =?utf-8?B?clNySG1pMW42STlmTWt6bWI3N0YxN0RRVlk3cGZURWR4MmxNdTAyYjR2YzJn?=
 =?utf-8?B?U0s0R1MrdzhqSHBMMUpzbUhOQVBFWWYxbEhhV0tWWkV1S2xldWtPTVQ4bjRi?=
 =?utf-8?B?UzVTS0g1eFNTK0ttYlRITHJUcm1IWk8zMC9xN0ltM2VPNUZ1ZTM1ZjFrS1Mx?=
 =?utf-8?B?U2NFUEsrS2EvZTVPNnBuQnB6amRzSnJUU3c4TmxZcjh3dmhhdVlhaWlZWE1j?=
 =?utf-8?B?dk5HSS9QVW1SVU0vT3hxbzIwejltbjFyZEZwcmVzaktaT2l1WEVUdkZjbnda?=
 =?utf-8?B?NkhkdE5lVmIzSzZiZDdKUDA4emRhSGpvWWNROEhOa2w0RzI4eFJYY2h4dDlP?=
 =?utf-8?B?U3lFZHNRU2tLVEo2eVBUeW1aU1pEU25sQlZYTk5oNVkxNlVnVjVvZlN3NEor?=
 =?utf-8?B?Q0JvOW1mMnNTSEtDZ0RwQmh2TzBhTUFkVGVNOGM1cTgxZXlUd053dThsaWNE?=
 =?utf-8?B?dXNpQW81SU9lelFmdHlVRWNvUzliWi9ZQmNWeTRqOExkaDdva290Z1hvNzI0?=
 =?utf-8?B?bFd4UmxhLy9La2hxcmZ0dlNXWUV3RDIvVmFaak5wbUlGK3lQQll6NHUvYStq?=
 =?utf-8?B?ZytIVU5peDg1cVBPSHZaWlBvMXQwK2FaUW1SVnM4VkhJZlBIZkZlRU1VK0Ir?=
 =?utf-8?B?ZENaSG9rWDZKQUljWVB1NGtVZHpNcm1zY2dTb04xUWlUenlqRUhXNnpZMXVz?=
 =?utf-8?B?a0RmWlhPVFFoY0daNXBOQm9zQ2VTZ3NZRkFScERLWFFnUjlwajJGbnBOTFJP?=
 =?utf-8?B?aUQvVFV1Q0RyZWk3REF6QjV6RUVuYXdoa1pyVGZ2TG9YSzUvRzhCUlpPbzJG?=
 =?utf-8?B?WmNWZlE2VVdiMDRZSHVxWEtvcUxsNVFERHpNOFJWQzAzdmdNVko5clBRSzIv?=
 =?utf-8?B?VEIySG9OV0trYllKRUxzblNJRDR2SnZVcW9TSi9QOWkrOEVYcFBxVm5Yd3h4?=
 =?utf-8?Q?j1ziLOruQg8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJLLzY5TFQyUERIYVY4T2VBR1lPYUZGZjRzTEVzN0FBL2FiQi9kRFhlOWJ3?=
 =?utf-8?B?OWtMNUY1dEtiRk1XdE9jcG1QZGVBWHZWT0NRMW9rdHFNdytGcUVSbXNKRHdC?=
 =?utf-8?B?NHVhaG5lWGdsdDlVek1VSXQxYWtaekdlTjlVa1hNdHV6RnFpaWFSNFJhU2ts?=
 =?utf-8?B?U1AyTkp1czdiSzJyallDTUJ0WW1YdlhCY21QMFVIZ3FycGg4eGdSclpxTnBv?=
 =?utf-8?B?azNoNXRBL3NhY3Rzc1krSm5ObGljaWErU1VqVlJjMWlJNjZ2MkFWRUdHbk81?=
 =?utf-8?B?RTJkOExCaThvZ2djR21SYUFqQ0Y0ZjBhVjFnM24xU01OMHRXL0ZoZDRzZE5r?=
 =?utf-8?B?YUdZSldPZDRMTkEvZDdnUDRMeE1nb2J2alNkOWNZd3dpM093MWFhMTBiRkxG?=
 =?utf-8?B?L2NSbHRXbHRLOWRYbFd2dnJLby94UE1UQ0NXZklzNk5mamFLTm9FR1VEa09H?=
 =?utf-8?B?bXBPa2JldnU1cEJDalJoWlhUbVBNbnJiTDZpazlUM1kzZTlCejNjamNoUVRv?=
 =?utf-8?B?emZBS3A2S1diSUY3Wmd0MWM2Sy9TdFVHcDlSRjQvU1BVSVYwWFNxdUppTyt4?=
 =?utf-8?B?dTVHMDJYVUllZGF0OEhSN1A0ME1LQXVnbzBDSWFJaGg4aW80bXpTZmZ5dVRk?=
 =?utf-8?B?UkFSdWd1R0pNSTdUU3FKOURlanZXOWdYcVFyeFVEcUJ5US9MYjdSTi9zRzBm?=
 =?utf-8?B?Q0lRaHpvWGNsOGswMm1IQURVNjhBOGFCcy9tdndLaEJVNGZNclcrRStNYTQ2?=
 =?utf-8?B?NjQzMnBkcXlwVVdJNS9WWnEvNHJxakdFeXJpWHBvSG5CSTI1UVJ4T0wreUM1?=
 =?utf-8?B?aXlUN0pYQ3c1bGlSbGRSWjRNYk51cVNHRzhxVUZVNVlGUjNDWXdUeG5oVkVz?=
 =?utf-8?B?ek9FMXBJU0RFZlpmZDFtSWVRSG9DUXhDdGJkcnUzSlFsTmM0NEtESElNUUlV?=
 =?utf-8?B?TlJudkNNdUs3OTlBdTJzUDd3b2RoR0lqczFXTkl6N3MraURaMStSQ2pNSFZT?=
 =?utf-8?B?YzlKK1MxY1JqK1VoekJjdFFGME5zbzhaakVmZUE3cGxTNDlHZFdja29URUNK?=
 =?utf-8?B?N0p4b1ExbGg4V3JmZmNOb2paOTN1WXQ3QmtIbGRCT0VpSkpBRWdSTlNKZzhx?=
 =?utf-8?B?cGJLdjlNQzZIdnZXVHRoenBvS3U2NEJ6dW1HeFVkOE5Dc3B5QmdKOWxiZ0lU?=
 =?utf-8?B?cHQ3Sms0MXJwVndwdG5tc01VUXRmWGdvNnJSTjNSbGZOZHR1RWFtRWhvYnpU?=
 =?utf-8?B?Y0MyOERoRFQ2YjB5OGZ4QVNZZ3c1aURZT0dvQy96NXpvMDZmSjhoakJOaE5w?=
 =?utf-8?B?NVd3TVU2VUNEVVAyUW9GeFI5bGhMZXFzWnRHSkI3ZWdmVXNjRTQxeWJ5d3Qr?=
 =?utf-8?B?WE56VWdLNUpqbXBZRmdxUXpYZkJjQ3NzVEozR1RoVFhhdExDV0p2OVVSSDhK?=
 =?utf-8?B?dGdLcnhTUmdBK0Znd0Z4SkgzNG13bExCa2J0dlJBY1lOSC9RdnNTanpuVDZ0?=
 =?utf-8?B?aFJRQXZXMGlBZlNzRHlNSVU4ZHRZQXRXUVBsRitIK3lrK2FrWWtES3dqTFJw?=
 =?utf-8?B?RE1pQzdoQ0tXRHBBTUdudEtrUGJ2dzQwMWtrZWdxL3lkUmVwUVJmRTRZNFNh?=
 =?utf-8?B?SWxuTW9kbDhRNTdReFVNWXd3ck50cytrWWQyMnNEWmNiL20vMXZQZjlSTzBM?=
 =?utf-8?B?RG1ncmRNNGRTcko3S0V3RFNQdGtoWFNoa1dyR2pMRm53bUgxNzRXMkhSVllH?=
 =?utf-8?B?N0pKa01RUXlPNGl1cXhmbnVQeTVWalVqQlV3U2UzU1JVSENlS2FDMTBDLzJt?=
 =?utf-8?B?M1Z4MkxkaDk5Y3lwekJtVFBQMFdqeUJ6UmdxT0QzRWpTTTYxUTE4NS94b3JR?=
 =?utf-8?B?dXZSM3BpK0oyblNEaWpZcWNBYWpNNUxFcTFaVTc5OE1TN2VReWhmakgyL01R?=
 =?utf-8?B?aDluYXFocjF3RGx5cnZyRU9IWXFLRVkxY0JIRHlJOXBkVEpiWmVuWUQ1TzVC?=
 =?utf-8?B?ZXZYTUQyVy9DZSt4VStUbytzSWY3M21OdkZRTHdlUGRiSmZ6YlJvTnQ3Q1Ba?=
 =?utf-8?B?Q01BVTdKS1h2dm9SWExkS1pTQTBKckk2dGRzU2l6SjA5ZmNQaFpMYjU3c0c0?=
 =?utf-8?B?clpNU08vT2MrWnJrYWhxUjdITHFGRUpRbVBIRGZYeENPZzJkclpXbkpQVWVx?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 522975a5-b35a-4843-ea84-08ddcfa1de85
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:47:08.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykFA/5aOVDZIcbaJe6appRojwj8BUVcxZHnLb2lnYZ7Cdvxx98QOJCMMyluqyWpy7fQ5zuKCkoM4FDKJRzxM0wDDbc3JTvkZNhKrr4gj9Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7494
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> i. Change the event configuration for mbm_local_bytes.
> 
> 	# echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
> 	/sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 
> 	# cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 	local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads

Above are some more "counter_configs" stragglers.

Also, while considering our exchange in [1], I encountered quite a few functions doing
counter management work for which I believe monitor.c would be more appropriate. Centralizing
MBM counter management code to monitor.c was something that you planned for this version
so I may be missing why you decided to keep some of these functions in rdtgroup.c? I
highlighted these functions as I noticed them. 


Reinette

[1] https://lore.kernel.org/lkml/74f1b542-d489-4ff9-802c-5d6d5b8d50b4@amd.com/

