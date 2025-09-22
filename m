Return-Path: <linux-kernel+bounces-827803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C87B9325B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B7A1907F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD692F49E3;
	Mon, 22 Sep 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ko53A05d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BCC2E765E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570803; cv=fail; b=aVFdqO35eOTBuvIUnQ7te2ac0FgM2p3SvGqPewBwqN79JdJEXqsm5dDYFCzn1tcpqrTx82kr7yfcrYkJx/j4Tp3nW/dNl/f1rqFt5cs0NiyvfR07jGHdPTGg+wzoY0ErzR5c1X0raCov2I9K4BhfquzPPrPBlMnEPrupUI/cCEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570803; c=relaxed/simple;
	bh=JBWcmJllCJKrg2gC6JSG/GJEP0CtZ27uwah15qxC0L8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YRm7CPZX25PkdCSmnqWIplmnUtAgKT4CIS0oGWjUJAIM6cimSxhFafS+orakAd+xgBEYkFzAruFnQ/qGOR8H+9sdsm0EkoFkkw+k9IROoe5HBHADNv24ntSdsS0NCfBOr5LKt5MMcxo83nc6NFAJd1GZ/VjlelyyWDwJHskNwzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ko53A05d; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758570802; x=1790106802;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JBWcmJllCJKrg2gC6JSG/GJEP0CtZ27uwah15qxC0L8=;
  b=ko53A05dVCNOvbce60sBka28Pto1UvSyf0/DcAKxNpA8goU8g7FVJvHN
   4GmhHFxGNtWwjqWbWpVQ5aiu4fPfR7VOvqn1sXHjzT41rtqjFm0z1EB8w
   sMyh9DokZBDp8sQOA0scubbLKI4kgsh6dGooo4WWPd2Ndw1SL7yfADF8t
   pmOxitAemiRgXCXNDUhWaFgmxSCcnQPk+vxVcatzIgBjkgJwh3xxjpF4l
   a42x/SqUKfQnKdavAKJ4gopdkAlPeS/+D1kjfg14KQ4R2D87r83/0dy6g
   fkFbT9wk3tPeQ5skniuVaw2Z0Jcr6CPH5jpG1NZnlipzsgQBA7/Zr9Ux/
   w==;
X-CSE-ConnectionGUID: zIeqnxDOSZy1tOzt+QnL6Q==
X-CSE-MsgGUID: zwx3MDMgTOCvvkVEgL7/Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60541026"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="60541026"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 12:53:21 -0700
X-CSE-ConnectionGUID: MY69BlqWTfW0QZvFSvFvSA==
X-CSE-MsgGUID: NjEfdlqiSIC3z/nnPnzwjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="180955599"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 12:53:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 12:53:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 12:53:19 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 12:53:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRRXMXhXnPHxsH+4g2PEUEq1KvKjn+jOgC0zh+MHdYErVS5WHEUVbSg75E3VafTkFflgzxPCAUYD52AGpotMW/Wvsm5llbqPlga7t9lUBcILUhV+8zc0LMe14ocUE+pr3xS1HRT+MAUcmY90b6Jhnz7CbsFedowpmj6cquXSHeSOQbbFLWQ/Y+Vefu/3ba7/smiBteDoJqDjh72CPWKQ4U0s0rkrd6vH3KH3DYMPpTH/opMxsVYdZYZ5mGFECeNmfPJWqhqasWVZCIXRvzEl1fFjPPqS0XmTxpcZnjKt5+/6RjWZ7lMaKS9LJhuUSio0asqx9oqOtJxzj+7f1us9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFlWdDi1bcUyDf2dij7pIIohDbVb5KOiu0JNZeWpkCM=;
 b=vyniUH9ANfAb55elg2tOw9C3A796piMRDO/H3nhEDh8hswawC5lxnb/MT5nxfVKCMiN7/4+JsGcei6ryhCeCMUBA9mlBSMl1eMs/gfWtggxXm4QnrmYJY65FGGI+78C0VRsUS7jSzOmlT2eDNF+ByNEQz9iqCev0VNJsuiWci5ay1Vx8QHXEFaNi3kiehIK7dXvBNW2zI6y12dR8+Qmxd0W7OLAgqPda8O04P91kqIqA2Bo+i6FplVkv5N6sdrMdZEiK/6SWwEc84Kz86oUIJaw7RlQWmaCGtW+6P794AEZAFdFf8Xom9Qqw1yE2RkOV2ztg/crQYhKW/mUKNcSRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MW4PR11MB6713.namprd11.prod.outlook.com (2603:10b6:303:1e8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Mon, 22 Sep 2025 19:53:12 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 19:53:12 +0000
Message-ID: <36383b51-a119-4c67-974c-b497d5b19e21@intel.com>
Date: Mon, 22 Sep 2025 12:53:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] x86: Support for Intel Microcode Staging Feature
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <chao.gao@intel.com>,
	<abusse@amazon.de>, <tony.luck@intel.com>
References: <20250921224841.3545-1-chang.seok.bae@intel.com>
 <20250922130924.GCaNFKhC8jkEGk8b7Y@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250922130924.GCaNFKhC8jkEGk8b7Y@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0049.namprd11.prod.outlook.com
 (2603:10b6:a03:80::26) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MW4PR11MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 9739e5d6-354b-47c6-ab16-08ddfa11a979
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnVLSDd5NmdDOGk1Mzc5Kzh5YlU3VmxDVXd5ZldPMGxYUENYUWNsdUx6L2Q1?=
 =?utf-8?B?K0Nnb2srTmdvSzc0cEo3QWJmMTVtWkNOMU5PMlc3K1BxQnNRTUpoenBxVEFh?=
 =?utf-8?B?dTF3NE5MWUtrQzk1ZmcyZWVpTzFtNGtObW9Fay9UVXF3NDJYMTVHY1U0R3g1?=
 =?utf-8?B?TW1FQXlscnBzbUE2NndHd2YrZzJFNCtkcVBGcGdPZ2NndEVJNmtVRE5ncDgv?=
 =?utf-8?B?a2sxY3VXV2JwZjZlOHltUE9VdU5PNUxlTm93SHJLNnV2aHlYVWh1UXBucXRn?=
 =?utf-8?B?bHNkcHo4QW4xUHJaWjVpRXdKVUVuNnI4L1ZEbXNOd2c3a1lxdytibEJNTjNP?=
 =?utf-8?B?Y1h2bWVPUEdZQ0U3M1Vrcnk0cVhMa3NyeGNJWjZ3RTB2YjdWaGtPaHEyckZj?=
 =?utf-8?B?bXlCQmgwTnQ2Q2JWZjFZQ3NrN2lPN0FBUWQ4Y2dveFVaWFJ4SzQ3WWtyUkhW?=
 =?utf-8?B?QkZ0bjRUNElTazlWUnBxZGppcE5PSGIxSk1mdUF2aGNwOGtIR3BpRUxpMUNs?=
 =?utf-8?B?SXdKQlpub1pmZ01EZWI3bTk4QWszQkVYUG1ZTHBkYVltOVMrRGF0a3ZmMXpK?=
 =?utf-8?B?dWtaWFkrdEJNeWtnaW5TN3hBMkcyd3NTa1R4dVB0LzJBVEJwQ2kwaW56RlVT?=
 =?utf-8?B?VHN5TGx3VHV0cFF0MWRtbU5HeVRlbjdTOW80RTEwUlNibE9GRGxuT05tTHNh?=
 =?utf-8?B?ZStpNkc4RUF6alFjcGxHZWQvLzIrZythZXRFVnhmODRrMktjNnVkNWcxR0Jp?=
 =?utf-8?B?TlBmY0ZNSzU0cTZESkExdndpanhkUXZSZGJhYVdZWkpGakFjSDdRbjVQTkY4?=
 =?utf-8?B?QTlnbm9NUEg3dlJwazA3R3dWcWRYbmdSeGtEVGtXajBoeXlZY3ZuSmJGNTJG?=
 =?utf-8?B?RGQxN1JWZWJKNFQwbWJhYkdJLzBoU0hLMUwxREY2RkREY2FwM3pCVW9ja1V2?=
 =?utf-8?B?VkRDK21YWjNDSXVtakJuanJFQWp0Si9QUFdINE1HK3IyMlZvWWlEbk95UjVM?=
 =?utf-8?B?VVdCNGdncnU1WG1pUUlTRWZvWUhJZ0RpN0RwN1BIUzFPVnNZWFJDNG5zRWNJ?=
 =?utf-8?B?amVUUThIOFRocnNLalR4T1RzdjBRdTJ4UjdPYnRMRFNybzgzekF6R3QwTmpM?=
 =?utf-8?B?ZE1BRTJkRlBscXFJTEdNMG0vSDF5aXF0SlJYcDlBSTQvY0U0Zm1qTE9WNVdr?=
 =?utf-8?B?OTZGc242L1Jsc2xxd1JzR2V2RlhUbkdkcHdqWVRFWWtwVWgvL0phbFRVSlRK?=
 =?utf-8?B?YmpXQU1CWE1VekZONXV5Um1RakxYM2NNRjhPK2JTZlF6SEtyOWF6QmVaNkxX?=
 =?utf-8?B?dVEzbFFuMG1xVjBCM1IwTnZrSjVDT3hBVDBuUjVWVnpYYm1NWGxYZDF2VU1Z?=
 =?utf-8?B?ZHNzNGtQZjUvYW5xdUt3K0NrSVJnTVloTVdTb1JoK3F6OVh1QmJybHZvS1l5?=
 =?utf-8?B?VGNzdDhLcWVHRHltOFRXdjk1a2JONEUyaWZ4L2diR05wOWdXdVF2clBhWEhz?=
 =?utf-8?B?cUJLNlBJTkZzc0hVendvdnZEcThIaTNxSHhxbW82ZXBwVHJUZkkvcUlWYTJE?=
 =?utf-8?B?UTlzQWpTNmN1b1NRL3NObWhCZmxRV29pWlg2RytvL20yaUpCVm9lTmFnS1ZK?=
 =?utf-8?B?NGYvcU0yMytZSGxZK0VnN3ovbDE3R3VJbmdCU1Y5QmFWWnBRQmF5Yk9WTjgz?=
 =?utf-8?B?cFJ4UnBkQ213TDFSNFN4S3dSRE9XMWQxM1RIVDZ2WjR4OXE0SlZsVEMxNEtm?=
 =?utf-8?B?UXJRQitjeTJVQUFjanZQWkhoanllb0ZjUmVBbzZveGdiaTZoc0xMNHZLTkVl?=
 =?utf-8?B?ZWhmYzgrQk9WNy9MYUpPWGpsZkdNbG11WmFqWnkvK0lLcW5jQVFwcEIyUjU0?=
 =?utf-8?B?VGphZTgrRXY4ejZIOWFuR2liMVpLa1R6d2MvZ2dxdEU1MkZOaVlTb2JYWjZH?=
 =?utf-8?Q?i7+kKfjXHnk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkRzYVVMajNYRVdmYkZKemxNUWxKUlZvMFRYNFlGV1ExaXA2T0lVeitwTDB3?=
 =?utf-8?B?aFZjc0xrRHdJOERhS0p6K3AzbzAzdVFXT2ZwL3NPbGN5MHJwcnRiN0tpZDRl?=
 =?utf-8?B?MjNaNTJhYUVIN2czWjR3SGpiSTBIZEhrdjZwSno3WjZVUkxGV200V01IbG1i?=
 =?utf-8?B?NE96bzcyQzVkaEFIN2pmS2ZBSlBSdXJFMERZSldIRWhBZkd5VzI5eVFSKzhU?=
 =?utf-8?B?M2hSa0VSSm5ibi83S3lrM3F3Y1hESmk0NFZNdEltT0M0WmF0YjhneTZGdDBE?=
 =?utf-8?B?ZTJ1RFN2Nmh4ODhDYTkzdnBPNTQzQmg2cmxPM1l4eXIrV3RvODkybTFoSU1Y?=
 =?utf-8?B?L3FVRm5yTGlxSHJPV0duVHpnQ2IxV1JLSXhWUWdsN2VhM1E3S3VxTzdnY0RW?=
 =?utf-8?B?S1p1UGtMMHpIT1BpLzlYQTVDTzJQRlZoSGpIRVVibzI0ZkowZ0pNL1FCWjNK?=
 =?utf-8?B?T2R3UzVtU1l3V2YwRFpBYUtPYklUVEZ3Y083bHRQNmRKWnZraFNmNEc4UFpo?=
 =?utf-8?B?M3poYXhCbEYxTEwzckdib1ppMWszZ29vT0RuVXpjTHpCNlErZ041VkNSMFQ1?=
 =?utf-8?B?ZlZKamJjSERVSnBCZHo1eEw2TFdJUVpRL1EwVmhudWpOUWhVdWY0RUFTZ2Vz?=
 =?utf-8?B?VHFyY0g2RTA2S0EzeHZwdG03UXJ2RldOOGJXUVdQSWdxMXk5cjZ3S24ySXVH?=
 =?utf-8?B?a28vdVJJMVJ4YmxBMkNiK3ZkMlB4K3JnTlpXSTZmTENOWUxvcUNnTXc0Uzl3?=
 =?utf-8?B?R3luTkMzZTNpRVhDODkwR1F6SDR4djJLalBVc1pUUUplSWE2QW9TT1NKb0sv?=
 =?utf-8?B?SkljQ0ZPaWgvR3VKQS9TcC9zU2lwZGxrdVdyOE9UNTlzK3JsQ28yc2dBbWZP?=
 =?utf-8?B?T3RTdDh0bmhXOW1hUmpyNThxaG1FQVBZNk1kb2JoSFkzemY4R1ZJajZQTlRR?=
 =?utf-8?B?WHcrUkEzS3Z3WnQ5RXRQV08yT3R6R0RiaDBNbGJLTUZmYWxrRmgwaHE1RTg2?=
 =?utf-8?B?MGJGTnRqZDN3TGZMSllsSVNuakYwd0RnR0FOcFJqQm9ENFg1OGxWSm4zZ2lI?=
 =?utf-8?B?a2NxSGFGY3IrMlNWU2s4eHprbnF1U1NMdjl1SDJBbGNoRWw5WTV4TjkzL1dX?=
 =?utf-8?B?R0t3WE14elFKZ1VKemt0QS9LSnZLTW82UXoxems3bnl0SW1sblYrMDVaMStw?=
 =?utf-8?B?Z2krQ0ZGMEd0MlNha0U2cWFrRkd0dmtlQ3l2RGs5T3BXa3lFOTh3L3N6SFg4?=
 =?utf-8?B?cjFVRnEySEYvY0NRSUliMjhnaUg4ZDJ0Q0lBenFUZmNLbFJQdDA1Q1htVUha?=
 =?utf-8?B?NGJ0WEIzYWtaYzhJa0ZUOTFnUjFhS1RCVEtMcStqaFNzZ3l5NG12eFpROHUv?=
 =?utf-8?B?YUFtWm5vYXVmVHBmckRwWENldGFMOTZIb3RsbTRFRW1RNXUxbTRwV1NlS2RY?=
 =?utf-8?B?dUljYlU3bWRYcjAzMzErWlZBWkg2WTFldWJ2T0gxQkZEaW1ubTExWWxGalVE?=
 =?utf-8?B?QXJqbHlRc1hiWGxuNVdnWHMwV1BmT2xOVGtkUFhIUW14NmorbUtEM2R6NnZM?=
 =?utf-8?B?aXEzbXNrdVFVT1ZnbWdwV0gvY2NqRmgxaHZaRHZNU2tPTktVYTJnRmJBbFQ3?=
 =?utf-8?B?M1NYT3ZXU0xXYldZT2lRZG5qZGc4b3lsQzhhM2RObnJ4M0ZvUXZaSkVmU3VB?=
 =?utf-8?B?b1ZwRloxbEdnakFKYnhON3ZkUFAvSVJKdjRpbkRXSmpqNWozRmY2dnF3ckxv?=
 =?utf-8?B?MlZXWTFZSFQvOGYwVXRaR2tNemhkUUk2T2hGb1pZd2ZtS1R1Z1RwaitIZmlG?=
 =?utf-8?B?Mk1WSmVHTlBpU21DcDNwd25Nck5XVXBYb3RoSWdueE1HYVdPdzgyTDJXczRW?=
 =?utf-8?B?bmp3czNHTXdhNUxMQ2x4Z1dZZEVveU9JV2hzWnZFRmNUMUN5RmJBRTdydXhu?=
 =?utf-8?B?cnA1bHdSb1ltZUVaVGJ0LzR2cFVGb1JScVRCNlE3bE93eElLMFd4anlnN0pI?=
 =?utf-8?B?eWtVYVpzMG56WXpETk5xWi9pNzFZTFoxTkhWK25nc2tKSVJVS1YyWU5kOW5M?=
 =?utf-8?B?RjdtSjhLNUNSa0xNdlBQRmNRLzlpVFI3SWY4SFhKY29kbVFid2kzYkk0TmdF?=
 =?utf-8?B?SUxNc3VqUERBYU9IQmJnZllaYTZCRUsxR1dSOFUzdVZBaUY2UFhVZk9RNWJL?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9739e5d6-354b-47c6-ab16-08ddfa11a979
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 19:53:12.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVWOt6+wT4+Wznlz9oK8lF7nm4vkBAQFETR/4y7YrrqBOSzbnGB24mlCK4UNi31b6UG0Sizfgy3rOnkPVWXpg8wSjR7tRzCo+z0QjzfOVm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6713
X-OriginatorOrg: intel.com

On 9/22/2025 6:09 AM, Borislav Petkov wrote:
> 
> My plan is to queue it *after* this merge window because we have
> less than a week and I'd prefer not to rush it unnecessarily.

Absolutely, I appreciate your consideration!

