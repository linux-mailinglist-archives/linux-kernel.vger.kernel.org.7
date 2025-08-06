Return-Path: <linux-kernel+bounces-758395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4949B1CE6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAC218C5F07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4F221C161;
	Wed,  6 Aug 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaLYhy5P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE7A95E;
	Wed,  6 Aug 2025 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515865; cv=fail; b=mWUMnyf7meJ/cMbMiEGA1eQTsC2yq3R7vQUaAz9t1bSfKuOwRg+JjcY8aAYs5PautqhQAafXUO6Zr+FvdaYAsj2Tmgjq5yP5uGO9z2qH7EILHRmkeH9d0Xi80ldSbic55v6P7gjb3n+U3CTRXLqK6dtkwtR7c3reqY4H7GdNBKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515865; c=relaxed/simple;
	bh=h9r/n480QvAqv++BrmSabVQDtpzrLaaf5fMFPzJnVis=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XQlfHRj1rkkLgvYjj+58+p/P82Z7yPpCvIrxpIo1F5AbUytA8JQ8XcicI60ysP49tWtUmc7zxUZebOqTCSp6mBmE1bRHt0Va4shitAgdprTbwNoB8UWmmgL3/b5v/qnQ3avyPXiAqNJ3sMxIZitUF9KzC83wHJQlt44ycF7H3iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaLYhy5P; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754515864; x=1786051864;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h9r/n480QvAqv++BrmSabVQDtpzrLaaf5fMFPzJnVis=;
  b=LaLYhy5PfCCm0zcCZQz/GAGYBcHYivYpllV+VipBK8/txGHzFdSHfWUd
   ckaNLXWQicIQaRsGXFNRiSMMsuHmyGWa5AlYmLM+aQ41GbgmpiySDEtog
   fuRMv5tdrVvKrcxXwH0oglezcgcUnAhu929roXHFpB96drYmOqmEvDBOA
   9OID/XXcds5UiTti6CBF3fY8Pc71//vE76LZmKrx/Rh3cyCledqNnTYnB
   SamO9vCPh3wVEY7dGO4A3KL+oT3ZMSOv19uhVJbmVslcON9ZGdhywhMtk
   a80SVtZW2NCNIVi7wECWBURmcOCN9nQYGnSGQGRBZ4czkNEL4oUKL1RB9
   w==;
X-CSE-ConnectionGUID: /OQyg8OES4WPzqzLXSMTjg==
X-CSE-MsgGUID: FYqA59sSRdeSLctUv0Vp5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67111492"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="67111492"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:30:58 -0700
X-CSE-ConnectionGUID: cHcp7iNSQhic770gnf955Q==
X-CSE-MsgGUID: K2fjHFpKTLWpnWUHhenuiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170148418"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:30:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:30:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 14:30:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:30:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NU9PYZCZwlHlMZm7trAB5xYD5XUfm2U0Q6uyXIyYKPUzd8owl2zShs3AwdC+2kKakohJ6fR/HsxSV8QDndRgOZcd/NiOjmtxXmRmDAw4aMV2aUqjsxMGXOuuMeWJv5D8SDL3Vz51LPVZoBGs+6uh/5WSgGjGO6vAHV9V3Hf3Ee6iDQkEtkK6VHccmPlDKHjrEJrHxkVyW+BqrjCsY7S56BlwpeGmvoEibOzSaGDTZpo1zVpJoP5Kg9Lm22r8NKQV9KknN61PffrVMiWJvLwFk6XAEGMORFaw1XUIzubvW568dKLSIoC66zV+2wX+XPbgeFxP6Vfn3RyFARcKZbICbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UImBAMAwCv3BIoRC3ivNi+df/RynIvK5MR2Uz9yhC2k=;
 b=EvPEQBtvMCv25tCileNMOh8L0uO4qapuBr4n8D5aoCD5CgeCqMMkteM0bgC5PYQA1iqU6dQVRuRz67G/Ij+IIYWz612ETlK0ThY3fVTCBOKahH12ZCn4/k/vOudfQMuGsKRXGf9KxeyeBAd1l513b0jSo9s2XER4/ETQLAK2QTddNRcEoZX3Qp4cGf3w8XGFcwcyWkpYs+l6I0rVz+ZxsZic7r7mrVv6JgsUwo1eHWc7eX9tANwQ63gzjpMaYrcP+GOrIZqSY6CUkyBzZ0xTzV3MdY1CDa2lD7Q/xahmh4S0oLKNZmvC+sMxxdtg3EtHngZ+qCYHDDxnLE4Xcu3BHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6813.namprd11.prod.outlook.com (2603:10b6:a03:47f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 21:30:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 21:30:51 +0000
Message-ID: <d23b35d5-497c-46ea-a8cc-c789f0aff3c9@intel.com>
Date: Wed, 6 Aug 2025 14:30:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 10/34] fs/resctrl: Introduce the interface to display
 monitoring modes
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
 <d336be7c2776ef08534031b4c1ef1f3c6850ba2a.1753467772.git.babu.moger@amd.com>
 <8ce71c26-395a-4d04-ae75-5d54dcaf51d4@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <8ce71c26-395a-4d04-ae75-5d54dcaf51d4@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:303:b9::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8d7be8-77bd-4a50-31ae-08ddd5308457
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk83Zll2V0trU0ViM1N6Tkxwd05YR3pwVTVXRGR4cVg3WmNpbWlBRlJEZEhO?=
 =?utf-8?B?NGJVNE9lcWhGUEZNVkVhN1hJTnBFWUhCUWplNzdvQnA4Mml4RGtBMXBHaFNw?=
 =?utf-8?B?bFZmeTgyTDdvSk1ONWRlUEEwaGhNbCtXcEVNUzh4R1RpWmY3bzZLVVpqYmhz?=
 =?utf-8?B?azh2RjRBYmY4a1B0WFhPMWNCVnV5aHkwdnlWNDlpTjJEVkJ3bEJLUWI4Mk9q?=
 =?utf-8?B?QkxSUUxweUdVRHF3UVFNcG0wcnZkaHR0ZGJtcTV2dFJDWVk5dlYwVXlic0pr?=
 =?utf-8?B?aVFmRmhKUTJrL1VVSVVXalYwM3QwdURzazAyKzlTWURkUnRJMHNSQWF3VC9C?=
 =?utf-8?B?YkJiK3ovRi9sY1lKZThoa0ZrV2hFbjJCUm9GTGloSm9QaFF1Y3NJNzhkTmxh?=
 =?utf-8?B?NElJanhNaSttOTFJM2FqQjdvYm9qNmVDRjhYMGRXcGJvMEdLYTZJZXFhUkMx?=
 =?utf-8?B?YmhJcnJGWHYwaUFXMnRzTS9yTllyR0tFcWFmOHh1K01Tak1Pd0xvSmExZ3hv?=
 =?utf-8?B?M0RNVXF6b3RkT1BPZ1JQTkh6QjFqWW0vZTRZV3lMa0tST1pudUpkekVQTWlr?=
 =?utf-8?B?eStJNDc3MExVczZWYW1UelV6SHNMRUJxdmlYYURLYWY4Mi83aDdvcVhQeWRO?=
 =?utf-8?B?aEU4QVBYaWR5K0c5cDFDL29tMDdWTTgybWx2Rk50THN3K2dCMUJPbDFBdTVP?=
 =?utf-8?B?WVl2YVk3eWxvQi9janNZenNPYklIRDJRS1RSWW1RTFZCbGpqOGhvUXE2QVcy?=
 =?utf-8?B?SjBnR2d6ekx2UnBkQ2hKWm5oNEVDSEZyVURkc051UzB5Tk91ME9MS0VvYWJv?=
 =?utf-8?B?NDI2L1F1aXNiTmp2S2tKdkZ1Y2x0d0xySVpnZmJIdTlRWlVucEpDcWd4ZUNQ?=
 =?utf-8?B?aWtqN2hHS3RtWVJqeDJjRXBzL2FDa0ExUHAyR3FYaUpjRHRNQ2tqV1V1QkNF?=
 =?utf-8?B?ampGVkM1eXg5akh0SUNCUHZFcDJUZXg0WGFLam45STFHWTc5VFhUaHFVS014?=
 =?utf-8?B?Y2dGQXF5WjI4a1lzS1Zmd1ZxZlBZOWdYNlZhV1hHL282MitabVAzM2loT212?=
 =?utf-8?B?U09NdlFYK0oxNlVjNHZla0thc2QwNmtMTlUvQzNmY2lYMWI5eXJKUE1xWWpn?=
 =?utf-8?B?dG5GYXgxd2ljZERnWG9uMGRtdjJDWVhpQ0ZOUkhhQ0pFaktoZ1dIcklubmlZ?=
 =?utf-8?B?cUQ1RnhIbWJzdjRyd0IwYXRMNnVWU29oNmJnV1JyUTBhQUxKcG1NQy9CYkxD?=
 =?utf-8?B?Y0tQYzZvS0VjdEwwdWFoK2ZuOTFFN0pFVU5ZR1p5S2h5eStxeEpIQnVIZHdh?=
 =?utf-8?B?ZXNDUFBBeHZHRlZRa0NBYjVPbFJLb1Rja25hazFZeFp2dTZiUFYwSzZwUDJ0?=
 =?utf-8?B?eWRNOWpvRkx6NzFQZjAreUkzek0yTlJyU2lVbXBrME1mOUI1QXhSSG40am53?=
 =?utf-8?B?aUpCUTFYcWJoWVI2ZDJYVUhCNUpWaVRwMno0YmtRZHk3ZnNnLzV4d2hua2dY?=
 =?utf-8?B?WWdWUzhoTlhqMVIrZjhycXQxS3JMVWNleStROXZkOC9EMDduZWEvc1h2Yno5?=
 =?utf-8?B?R2pLazRtY2xFRkVSNXdxN29SZzljZEJJK0c2YURvajBqRWpjNWJZS2hzWHVi?=
 =?utf-8?B?VGNzeHRtN3c0RHY0Z1BPRm9MMWYxdjVITmtESjJUMk9JNTBQNmloYzdFQWk2?=
 =?utf-8?B?Wnl4TVluMWJSUGhVTkJCbGRMdEhCZ21XUmM5WFl4aVdiNktWVENubUZuNmRy?=
 =?utf-8?B?L2QrQ3dKWlV1RW9zZjZ6Si81U0V6Y1puOUtQNEdZck5NY3lNaDVjNGJwOG92?=
 =?utf-8?B?K1pkNGY5RVFrNFVTRFNsOUlEUnB3N2NMZ3R4WCt4QnFTZk1RbDk5SmpWZGd1?=
 =?utf-8?B?K3o1VjAyOGtiLzUrWDZnUUFVMStUbjdCbE9iNkRlSXc1Z0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW1Ea0JzQnBIT0J5TTAzVHYrYmpyTUxiM3VSMDZ4cWh1WTJmN3pRVzlCd0Rn?=
 =?utf-8?B?SW9xcCtZUkVoanpQZmZsV2ZjYVZMKzZOaFJLakxnSjlIeHJqVXlSWTcvQzE2?=
 =?utf-8?B?OGpMS2dwSTZiNVAxOVNiTC90clJUOHl5b3BDTFhROXJVMVByNmR0aWlJR2ZQ?=
 =?utf-8?B?aUJ0eTdCWnRDYUlEVjJoaGpVYitkMDIxTXJCMzNqTVZ2K1dlTTk1UHlaOWhn?=
 =?utf-8?B?QWp5RTA5d09rUDY5QXFLZTVFY1hDOEgyZUh2bUtGWnNHTTlSS3B1YitWTDc4?=
 =?utf-8?B?MnNpbnVCUml6bnUwRGxPNTZlNFlkZzE3S0twbC8vYnBZMXBrYk8wQ0pRakFB?=
 =?utf-8?B?TWV0VGRab3o3NVlnaTFTYVU0N1FWS25aaG56QnptK0ZkQk1xelloaTNUZk5U?=
 =?utf-8?B?K3ZzYW9DMmQyRUs4Y3k4VFdJVFNlYmE4MUVhbVlZRDlVOTR1cWtWdGgweTB6?=
 =?utf-8?B?NUswTy9LRXM4dWM1ajR3ajQ0ZVVVWVRpcEtzVlZTejhQOWRZSjduWXRsc2kv?=
 =?utf-8?B?VG1aaUFaZ3hGTHVwMFBTQVd2S1hKTCtnTkg5MnU5TlJqL29SbjlzS1ExcitJ?=
 =?utf-8?B?NThDVHI4d3hhODdBZElONXlvejU3OTBEUGhNUlRZR0lYU1k2blZMVFpjNW4w?=
 =?utf-8?B?ZmlOa013ZkpPRUJXdWh5cGdjTUdCUnIvNGNieWo5OEZKV1Rjd2FZVDNwVVBS?=
 =?utf-8?B?VUw2QkxJbTdkYm5pRTU0NFE0Um4vcThjSTRxMUpscXVIMkRjU0oveUFKSVZn?=
 =?utf-8?B?RU81aWlvKzhLbEVVN05XeGtOK3JuNld0NFA4M085ekJCTWpqTGxsUXNDOEo4?=
 =?utf-8?B?ZjZ2c1ZIUVFQVkNqdGp2UnIzT0poMytCTHZFTyszWDVJMEkwUXhTMkZZNXVD?=
 =?utf-8?B?RUlDWWNqdmpIMHlwMDl3dWVDeWhOdnJnSSsyMHZXR0syeGxOUE4zWVh6N0pW?=
 =?utf-8?B?V2EvbUwvQms3WmwrTUtMbUozRkhnbFZ6U3VXVUR5YndONGcwM01GTXlERS84?=
 =?utf-8?B?RmQxb1FHY0hJVFZ3Szc1emh3Y3VEVzNMbHVodVNubURQcUVYQ1J0ZlR3NG5H?=
 =?utf-8?B?a0VhOHc0YU02Y0VQZHhtbVJ6bmJNbGViL05FVFliSjhRMURtVE5odGRoR3hn?=
 =?utf-8?B?NFFRQ2FWTTUzMFpudnhQdFpaV1Z2V2ZEMVc3UXRqbHZPSFl1UU1maU1QbnlE?=
 =?utf-8?B?UjhNRENXNXJqUGVuOGVvSlk5VVRvelBSdWQwRVhTVlN2STlML0p3N1czakJ0?=
 =?utf-8?B?Z0pjdHdGMU1XVWhFd2kwSVhwNi9xWTZWMkQveDJncDE4djU1OXpYVTgwWnJP?=
 =?utf-8?B?c01FbjVqVDJ6UXg0U08wUUd6dXJxbnhqZU1GZlB2OCtsZGo0dFhjNHAvSzdJ?=
 =?utf-8?B?b1FFMVphOWVMb2NYaFlrdFBBaElUaktTUUEzSGp4c0hIUmlZc3RMb1NPMmRO?=
 =?utf-8?B?dDkxRGtlaEdNSDRqT21vM0g0djF3TDE3cjBDRUJkWjVJWGUwVEJ3NDNXQ3lq?=
 =?utf-8?B?dWlzQTJiWlJhYW1oOTJyU2hvT1RnSjlMa21JOTB3b3FPallHUndWNGowVVJ3?=
 =?utf-8?B?Y054MHYvdk40cTRFVlZIRXFEamNsSmlkS21teTl6cCtXR0o1K1pyRGFtV2M5?=
 =?utf-8?B?S280eEZ5ek4weEdZcHFRYytIeGxpdFgyY01WYXFhTGZ4VEFsanVkamVDM0dh?=
 =?utf-8?B?Q1NzamEyTy83cWI0bTdxYU96bVNyVHlKR3YwSzdjODdMamk1MzlWZFNldHJE?=
 =?utf-8?B?V1l2SnZjblRzZHJMR3ZjR1QxLzNKMzJSRmF1SEl2cWlQWmlDRWcrb3BFak1Z?=
 =?utf-8?B?UTNkd0IrL2RqdzcrQkc1SDdZNTV4MGxPNHQydG1RNzF2V1JCTTFLMDJoNnh0?=
 =?utf-8?B?akIyMExBRzUxTnQ0NmROaVI2V0F2bkV1aXpsb0dscUUxN0JvYVZvVkZaekxQ?=
 =?utf-8?B?TmNrMDl6dGdUREdXZG12Z0xxZFNKK2VNcnBpSmZMNGszalhiSzl2Z2J4Yk5N?=
 =?utf-8?B?UXdqamhXNDl5UXdlVEZDcTBKTHdZeHZaVEtXamQzVGtzbXR6T1lWdWhWVm5j?=
 =?utf-8?B?VE9FUU5kVisxYjA2bk8zS2p1L1VEUGlraDVVV21NVGY0ak55Tk95Zks3QjVr?=
 =?utf-8?B?Mkt1QlJaQ01CNHBuOUgzSGdaaU9GSWFsUHg3c29ob09SWjI2eEN2Y0NUNzhK?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8d7be8-77bd-4a50-31ae-08ddd5308457
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:30:51.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oytnIakgZACrzsPzFNdw+lowY26reLwFq/tbq6wKeoaSfm7O0owi1dVZOxWivAl8pu1byAaxaYfZgpgJOinfQtFlmZO5WWLxnX/gl4QIDZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6813
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/25 2:02 PM, Moger, Babu wrote:
> On 7/25/25 13:29, Babu Moger wrote:
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index ca0475b75390..c7ca9113a12a 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1799,6 +1799,36 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>>  	return ret ?: nbytes;
>>  }
>>  
>> +static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
>> +					struct seq_file *s, void *v)
>> +{
>> +	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
>> +	bool enabled;
>> +
>> +	mutex_lock(&rdtgroup_mutex);
>> +	enabled = resctrl_arch_mbm_cntr_assign_enabled(r);
>> +
>> +	if (r->mon.mbm_cntr_assignable) {
>> +		if (enabled)
>> +			seq_puts(s, "[mbm_event]\n");
>> +		else
>> +			seq_puts(s, "[default]\n");
>> +
>> +		if (!IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED)) {
>> +			if (enabled)
>> +				seq_puts(s, "default\n");
>> +			else
>> +				seq_puts(s, "mbm_event\n");
>> +		}
>> +	} else {
>> +		seq_puts(s, "[default]\n");
>> +	}
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +
>> +	return 0;
>> +}
> 
> The resctrl_mbm_assign_mode_show() can also be moved to monitor.c.
> 
> What do you think?

I agree. monitor.c is appropriate for this code.

Reinette


