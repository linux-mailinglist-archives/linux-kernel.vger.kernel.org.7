Return-Path: <linux-kernel+bounces-876069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54174C1AC17
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3355F6242E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA853358CF;
	Wed, 29 Oct 2025 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8DlucLl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0437A3D4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742483; cv=fail; b=P3s2n6E+0mwDFzcoFEO5tPC8NMQc7vgaXXN2pLZtz9cBcT9ISE64BPWAtVe0hKXIC0bOK9zCimgMspR9HU3o2GE/LIl4Z1AkpKbgoCuErPamNoFMtJucv6EZQWV97YNPzWD4PaQ1rNpfZaIZ9wsLvc+SKOlujJgrjSPHcSE3CkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742483; c=relaxed/simple;
	bh=KT8hJiC3OxKUBhMEwc3C91QpjeWbxMLIwp7dt4YkEXU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DzKF5pvWfCTVNcwVEtOEEHoEI7ue0EsuSXCAUKNEESSHgjRAqClLsuffB2uoJK4oxOcE8Igdr214Qcsg597F5quu6MFmEhiMzjZWD3CLw9zhDw17STukX2v8VVeVMasZmCdNel3mnhngXWbGeS1aWbzPZd7GylPZBOCrdHaIVMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8DlucLl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761742481; x=1793278481;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KT8hJiC3OxKUBhMEwc3C91QpjeWbxMLIwp7dt4YkEXU=;
  b=b8DlucLlEYmSUeveNDvStIOa1Usl2dUmIm59Ls6bJAiJozhkpjPt/kW6
   15tUoX50BmuXYwgigIVAQKgsQwfmhTbZyssRiXytZEf4Dkxxpbx8RAHE0
   UqGVUdMSCnXVX4JbH0s8FW4bVy693tRMf+rmwy/mplrFjmbZORmIBySq8
   aNMdtMM/RbjM5pHZKuoxqnx1OVHgLwj3PZtuf7IJs0I7eUFxxAMMohylV
   Kot+o0yJ46yZlm8Q2LXwKSsWMlFTGm65L4tBnSJq7VoblYqXkl0tJUzx4
   oE6fidGEKBIC3jmInDFQGNN/+a8E4IzzKNgfaM2HZAcwwcoX9CnKgU5fb
   A==;
X-CSE-ConnectionGUID: ulNhY3ZqQS2++cuH5yt2EQ==
X-CSE-MsgGUID: OqpGQWlcRdWpONnUp7iv/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="51435457"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="51435457"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 05:54:40 -0700
X-CSE-ConnectionGUID: 3KejkFDdSpu3HNOCMwYyWQ==
X-CSE-MsgGUID: fRWkTFFER96QDUotsE5v7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="184898519"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 05:54:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 05:54:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 05:54:39 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 05:54:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZkN7XZvVmatuBtRTfcuR4mdrg+O2nQwUpH12flZJGhvjnDh+zkREBF/e20ElIRQAqUM5HqXIgO/edQl9CGsBy0fy4m6KYbs4AKCVlxlQXQdh38DC1XBU6SDQoa3sIVgwkMNKJST+zZOslydtXk4FnrtWKo3VpcefLn9sZmloqkku7GEm7mgY+hxx1xpWY6vhVpO7De+fBmixz4P4AN7T/JxxWS8IzoLaW2ZUiq874eib4oxLhnh9v5sZIAWxywAim+oLcxlTzX6soTQlOnm3+c9JB2sGkZCmh8Rsw8zXvM01jyUJ9SYAl0AwYWB8QrYhP8sLhBdPQErKa6dEP8+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESiWjfsE9WkxSHQ6jF+l8q75C6JVq3KePxJ+SM7Bf7Y=;
 b=s7sdxtKflyGz1iOQRC9fEGvrbEGRmUWFhnww7jgHNYzi2JslJCQK55+ULCvIgIy+IqXwWkhHuvQoki/JXycmFnwcG/Y4NK2J6TLpXWa8mLHF/UKDFAb8vNQsYXWaImvtl5BTIid7RlTo6xuH0Gx42Rr/Uvc1qAOLIlKLNo/um9ZVf3sJEL6DWUj4LXMmxSb4IPQIvLvao6oy+LHeXx/l4aypkw7VtrRv4KSjrBE6QZ8l/OuPM05NSMsqZb9Wtodq+H+cOjLYPoZg1pTaPd5ENTuShPz4da2yEgWS0ZhAfzsA/o63BQ7P1lxMFYjbaycz/0m0hsNYgMh3aTqhs6H/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Wed, 29 Oct 2025 12:54:31 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 12:54:31 +0000
Message-ID: <32fe2f56-c479-4679-a9a5-12373c544016@intel.com>
Date: Wed, 29 Oct 2025 20:54:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] sched/fair: Add user control to adjust the
 tolerance of cache-aware scheduling
To: Aaron Lu <ziqianlu@bytedance.com>, Tim Chen <tim.c.chen@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Jianyong Wu
	<jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan
	<tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown
	<len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <afe7603c37fe76064d769ce9d78df494347a748c.1760206683.git.tim.c.chen@linux.intel.com>
 <CANCG0Gfud=g2zUQrDJUipiP0-id0_Jv4kkoWGnyYvwDJAR+gdw@mail.gmail.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <CANCG0Gfud=g2zUQrDJUipiP0-id0_Jv4kkoWGnyYvwDJAR+gdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DM4PR11MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 7601af1a-6c0c-4316-926f-08de16ea4d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2ppUlhYY2RPcFpTZEJZbWprai9nNm9EL2pCbE0yNHBOanR2bFRmMGhKR21w?=
 =?utf-8?B?SlJKM3czMHJVYVJ4SjN0V2pLc3Fpa1VnY3FaTGdVQVdtcktIa0VzdEJOQ0RE?=
 =?utf-8?B?TEJPaGNlSzJHbTBlTE5yOVMrbTFUbEV1STVUOHdmZGx0UWRBZEJlSGpjS0hs?=
 =?utf-8?B?RmJhcHNYYW96ajBuTmJ3VE0wVk83bVh0UTEyblFNQytiOUdYVEpkVXQ1Yy8y?=
 =?utf-8?B?cDNDQ2t3dmg0anVJZ0NSM05QT2dDUUZjeHlpeE9YbGdEZUNMa1dTM3Z6WXhY?=
 =?utf-8?B?cmVqSmUvTk9qNlAzTTNZMFM3Zkw5Y1I2SkJXODgxZ1ZTRVBlN0xBWUpiM3FE?=
 =?utf-8?B?SUk2bC94Skx4c0FvL0lFTHlYSDdPTjI3V1hxYVJyaXBpZUtXdFZIWFhuaVZu?=
 =?utf-8?B?SkxjYThCTzRQT0MycVhNZC9kaHBWb000bDdDOTA4NmNqd1FLZmF1NFZzZUNS?=
 =?utf-8?B?RDlTNWhtYUxwbWNZQXBJZmgvWURVNkVaakY4RWRjYnp3WE9jTUNJNG1LWWNL?=
 =?utf-8?B?a0lKdDVibm0xenVJQ2ZEU1VnbDRNanVZY0FaZ05YVk9OTDZ5VTFzcnhxZjNn?=
 =?utf-8?B?MXNHalovNTA2dzljSGdYbUx2a1Q1ZEdnZWFSek8rM0FidmcwSGYvUyswY3hZ?=
 =?utf-8?B?cVZOVU95NmVrZU1aYzV3em9ySWdIVkVndkdSVWdtUk10RnVTQVdlcW1wZkNC?=
 =?utf-8?B?ZExzQkI1WjRlNXZ5c3REQ0s2a0FXMk1kZ2poSXE0cnFDejhOSFRWcEM2KzEv?=
 =?utf-8?B?TjBXZGd5aVd5cTdqYzNPQU5vS3lPdUJCZ2ViYTdjb3lNd3BVUHJGVU9oNkNn?=
 =?utf-8?B?ME9CTXdXOFhoS2I5ZVlycXBONEhTOHVPNnpEdHg2OHV1WjVDU3FpbnRaMk5O?=
 =?utf-8?B?aWtURXlBWmpnT3RUQjVaaG1kek1UZVJYT1BvN012UjQ1U3FDMTg2bUNnNFBq?=
 =?utf-8?B?M1JYczgwMVQ1aG1NbS9ONlR6a3RmM3dlb2ZsMXV1UXNBeHh5d2NhMGw5bTRz?=
 =?utf-8?B?MHc0Qm1jWVlGSjViL2dqelhWb3dqdFdFY3lDTmMwZkhna0xZYkd0LzBGOVBR?=
 =?utf-8?B?VjI0SnNCc1NPMzdrZFBzTVRqd1B3VzRTeXlIckZFcW1MdFpvdnlvWGRzdVFB?=
 =?utf-8?B?bXZCV0JHNkpGNnhsUVZUdnJmbkJ6b2dNNVc3bkRBcjE2MlBrcHcxa3p0VFVI?=
 =?utf-8?B?aHRYNHhUbTFwMTAzS2paMi96YzdUVU95VlFiWC9CS09xNTMrVFErNzMyR0lL?=
 =?utf-8?B?ZElHVitMTlhNQ25JWEtpMXJhTEhudVYyVHY2bExUZURUVGJnNHVYQlRuOGtm?=
 =?utf-8?B?T0FtMUpMUmlTZ0dZa291NVR3Mkxwc0NURHBjNCtsNVA3azMwanFpZnlnamlo?=
 =?utf-8?B?dUY2NEJ6amEybFg4MGp2ZGlwOGJjMndIbjAxL2EzZTJXVGY3M3J3eVhVaS9P?=
 =?utf-8?B?bEd4S1ZDR1FlckN3eEpycnlLYSsyM0NFMUF4bmFlaXpPeG85VThNN3RWVVJS?=
 =?utf-8?B?NVYrTm9aWENiNGt3cVlWZ3FvLzZLcDcwVWw1Z3ptdnkxQkZRS29tRWo5dVpa?=
 =?utf-8?B?RDZaUmhNV1dMRmNWbmIwTVIrNGxYTVJ4aXNEbXN5d1liUzBua3ZBQXljK2pM?=
 =?utf-8?B?ejViN2FBajdHZVdtclVwSjVSYjNZT2M3VTYxdll4bW5EWWlBblNFMzkxaUp4?=
 =?utf-8?B?NFBqck0zK0tCbVQvd0pRUzliNWVDOXlhUk40WjFUdHFZY2pUM01kVklFNmhW?=
 =?utf-8?B?V2dOYnF2eU1sV1ZwaTB1SkRLMVNLR2xjbjRBbU9qaS9PRllsMzZzMFBmdnI4?=
 =?utf-8?B?U0x3UDJ2THdkK0l5ZFA3V2NTT0tKa1Y3QndrdnU0RTVYc29lYWMrSldGV1Zz?=
 =?utf-8?B?NnZUT1NQV2txRmFiV2JSc2t6Q0NjdXFJQmp4YjZoOTBDZlBRMWhuZVBldmc0?=
 =?utf-8?Q?v4vZJ43hOmBQyjttgzyPk+fObaZuf+LB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVlMExlUlpsd0NNNDZ3QXplMkpKc3pXNllISVFncytTdHMxaUxmcVdrR3ZL?=
 =?utf-8?B?UjhKUFh0ZmppU2MvdmJwTGJSY2hjeVJiMkp2bTZxL0liRTJJNG1DMGpPNEp4?=
 =?utf-8?B?NGd4Z0trUHAyQmNrcm9iZ25pRGE3TFMvRnZsREcrYXhpdHVHRFZ3TXliV1hQ?=
 =?utf-8?B?THpDWGFhdjZrN2pEQ3BKM2R1RXFKQUIwOGJMMi9Rc2ozUnl2SmlkY2JIZDFm?=
 =?utf-8?B?cXdvUEdUM3R2aXZzQmxNSHVsZEh5NmJHUjdYVklXUXFrcE1SMXhCM1FUYmJj?=
 =?utf-8?B?d1d6ZEh3aGpxL3hTZjFoTzBvWGNPQjgvRmMzUUQrVWdwdEdsMExoV1dPRG9a?=
 =?utf-8?B?MXBjTDIya0hHNHoyY2cyUzQ5dTc4U0NpeTVUVEg5eTVFbGt1eXJzTnNOVW41?=
 =?utf-8?B?c2xxcGgzU2dwU2p2bTg3Zy9wSG9ScmJYeGk2Nnk1TTc0S3hNQytWSjNWV2Yx?=
 =?utf-8?B?QzVqYSt5UTBnbTVSeUlJSFJhUlpuVDV2bHJMVExLcjh6ZXN0bDRaUmpVdkps?=
 =?utf-8?B?cmp6UVhlU2x0YkJ1akdvbURCZEVZNUhKVVAxOTF3aThCL1liMllLaE44OW1M?=
 =?utf-8?B?RkFLK0ZmdlNiY3RLYjZlOStmRmpWMDhTYWx0ODZCQkt2TmxiSG8xNkJzRUVa?=
 =?utf-8?B?ZEpBVlpCYkVZdTZyVnU4MDk2V0poZ0h3QTg5L3lEbFU2WFRndGF3anVBbVdB?=
 =?utf-8?B?TnphTFJOQ0kycEljVE43OVlZLzc1YmNJZDg5b3BVbHY5MGd1cUFuWjR6UU4y?=
 =?utf-8?B?Mi9md3V2bnJVWmlsUEtWVnRvaTNPdkVwMmV2WnJ5ZG8zaS9hOTQrdTRVc2hp?=
 =?utf-8?B?UjU5QUFnUUg1RDNsd0dtSHl2YzVJOS9sNTNQdzZJT1daRkFhM1hURUtReGxm?=
 =?utf-8?B?NFNSeXRVZkhXcG5rKzFyOUhYbk8ydDVDeDVrcXRmTDFEdzBiYmczWXNyRFRV?=
 =?utf-8?B?bmtRa29HZDg0Sm9JTFpmcWlXRXBwQlQySjFRdjJONGFoMzhScmtWWkorUTY5?=
 =?utf-8?B?emtYR2tqb3lKSkNzTlJqRGt5QzBBMzJpNVRRUDVkR3IrQWdiUEx4cmZDWFJw?=
 =?utf-8?B?RVIvTUJhK1RqQjV1WkVOdU11Wm1uUWx2ejhiVHF2cnZPYnhtTlpqTE53TjNB?=
 =?utf-8?B?eG5ONVY5dDZ5a1dhckxLdWd0dmFQSVJQSEZYWkNDMytaaEdUclMraXpEV3da?=
 =?utf-8?B?ZVpMUGUybSsybHUxRGpoVjZFaXgxLzYvTnIwSi9rdTVJcXRraS9MLzZnczNX?=
 =?utf-8?B?U2lsdkRrbDRYU0dDUUZhb2NHZDNFeW1pNGZLTGNkUW9GYVhOWURSeGFBbURj?=
 =?utf-8?B?cHoxWUJLUXlLcm9Id2NiMHZuL0lSQWgzZlBsUHdRV1hKRnZlWm5iYlJ5RjRy?=
 =?utf-8?B?ZC80MGQrQWNHeVM2c3Q4ci9qT3pBRWtBTzNGc01temFrcWxPaHV2UjArZXJm?=
 =?utf-8?B?TmZTdGc0UHh1T3JQcDZxWlVycWhsZVlFSDFtNW1WdGZvV2pMU2FLSGJhdTJS?=
 =?utf-8?B?NzN1KzJSR3M1UzlCamxicXpHZWlvbW9wZVdQMzMzR1NwcDNIOUtNblYwRFRv?=
 =?utf-8?B?OVdSQlpza3I1aW5ZUElybUtXdDU1TysvcTVNN2JKZmlzTHhmTUlsdWN2UFZO?=
 =?utf-8?B?QUErZkVnUXA5emVoZTRXdVAzSFRLaWI0NnBRYkRxRTB3dVNJczRjNDdEMzJD?=
 =?utf-8?B?VDlzRlB6SEsyaEtyRDFQcWdjRU43UTU5RFcrbFZGUVpEMUJwT1MvMnYwSHRp?=
 =?utf-8?B?a1ZQdXdyL0xYNk9wdExNeG1CNzFqNlNyd3QzOUlobUg1QklqSHQwQXJnZGN2?=
 =?utf-8?B?NWpvWFBxWHZVVEFpTThrRTlydVRtSjVjcnBVZC9OMS96QnVjdlpaMWZjNEdB?=
 =?utf-8?B?VEQ5T0lsekh0VkpRZE92UjY5ZmdRS21tQUxUQ2gyVzBhNXZ6Q2RrWlJhRzRr?=
 =?utf-8?B?QXFEUW9wajJZaHkzUXpOeGF6RUlldHVWVjdILzRoblhXcjRRY3QyQTlNSjlN?=
 =?utf-8?B?RlhTN3NkNnVhRUhLc2R1OVBYS2JBd3lsV0UxVWZpbWFWNXZMaUt1b0llQTJO?=
 =?utf-8?B?SG1WVFkrOFlHRi9HWGFLVEk1UG5EaGp2SURDaGQ0cmtPcXp6ZW5SdlY4YlNn?=
 =?utf-8?Q?zgpOuNrDiUKzRGxCYWuFdB7pX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7601af1a-6c0c-4316-926f-08de16ea4d11
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 12:54:30.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oHp4tOvdGuv5UBsYVVp0v1VHkZrJ+n/BgDu1hp4EB+YDp8mu2kxdtA0KX55QUF010AQOqQUWj0pn84wboIFEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6189
X-OriginatorOrg: intel.com

On 10/29/2025 4:07 PM, Aaron Lu wrote:
> On Sat, Oct 11, 2025 at 11:24:56AM -0700, Tim Chen wrote:
> ... ...
>> +static inline int get_sched_cache_cap_scale(void)
>> +{
>> +	return (llc_overload_pct / cpu_smt_num_threads);
>> +}
>> +
> ... ...
>> @@ -9749,7 +9811,7 @@ static inline int task_is_ineligible_on_dst_cpu(struct task_struct *p, int dest_
>>    * (default: ~50%)
>>    */
>>   #define fits_llc_capacity(util, max)	\
>> -	((util) * 100 < (max) * llc_overload_pct)
>> +	((util) * 100 < (max) * get_sched_cache_cap_scale())
>>
> 
> With this change, fits_llc_capacity() would be false if util is just 1/4
> of max(which is llc's total cpu capacity), is this intended?

Yes, it was changed to this because we want to avoid performance 
regressions
in some systems with a large number of SMTs per core-aggressive task 
aggregation
  is harmful to those systems. However, upon further thought, since we 
have a
user-space knob to control how aggressively users want to enable task 
aggregation,
we can try removing cpu_smt_num_threads and let users decide. I'll do some
tests to check the impact.

thanks,
Chenyu


