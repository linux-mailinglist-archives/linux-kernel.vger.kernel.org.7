Return-Path: <linux-kernel+bounces-787335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394F7B374CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB813362EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ED11F2382;
	Tue, 26 Aug 2025 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMQVBnO5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629D47F4A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756246538; cv=fail; b=MOZdGbKIiOM9RmxNvYkzfpYdyBKQQ0B27LzC+vViCZn+EkQxrJ1QJrX9UQeKldGLZzMfhNwusT0GfXqBR8EWRNA/I1ZZThNQzmDLASxyPaBk8KmRdBCT8faA5hemIjVz0Pq1n0KV07AiQ2EGxbch9wD370/rMQwkhJN48a4Z/tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756246538; c=relaxed/simple;
	bh=fIZG0Io2nrtIEj+Pk5pD0TdzK7eH3tAyB+Y32PTRj/8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K5ltMt+WIGzkcogWwyMFasVSBENEbgH3EEMiqtZlXvBf6yF8VOraC2mfJAX5g7OMwzJPULPNke/7oyF0z1pp4vPgucSnB2MzEdpB8VxuEL4mpliODnceCBNxfKl69K+5ZbGs9Wd95SU+z9uYN54qyBNiTgX/vhPb4jcLKBJggJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMQVBnO5; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756246537; x=1787782537;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fIZG0Io2nrtIEj+Pk5pD0TdzK7eH3tAyB+Y32PTRj/8=;
  b=bMQVBnO5TF4z5+vFQdiOzKFNv4Ff5v4TE7VDk0aUFGhP/y8w1ImJj3u2
   a8hUY5tn4bDVGweo9Ze52b9VQ6fU8D7130NhhbXxZKMkgLv8TXaAbplkd
   JGqY7Ha74VDUK+HRwv9TzMqXJQW+uI8uN0XqRKU7zIDvjPOvp8J+RC2D4
   +nrXV3gUSNjMTsX5gnLhNG7hsTb1vLopkfilfPjipd7oWLJvRfHCgLAeZ
   vkwPNvRWfwbpN9Qj9OD7u1bfPqICbF2IhRL66LZnaqEdOiQASB3brBRGw
   MIV1T03dIvrwxOXA0CLOM/t55Iiy38927JgyzNdUE37DPap5B1wo5zvwy
   Q==;
X-CSE-ConnectionGUID: GLimYkJbRv6MVeFFYAPQ2Q==
X-CSE-MsgGUID: rqvO7l4AQziFOgdQHEI0KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69210889"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69210889"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 15:15:29 -0700
X-CSE-ConnectionGUID: 9iYYPE/aSreV55KrMVtDFQ==
X-CSE-MsgGUID: XahyyWRNTCm8wo/7Sha6YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168931377"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 15:15:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 15:15:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 15:15:28 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 15:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVouz0iVp4QreslVy9g/hUGAxHQxhwzgdGSeXwQQFCFbb/c/Cddlz+t9dKN1GfTD/oCpv474RfOzar19MTn+bPPwfE+5RX/0lT8L7SVOzfbBLR7qpotHAsmdJywxpNFjbB47NOkE60qBpKfMM0jihTjlzY2vvkkLUnTAs6ssJVcDKesCHYMiumO+9iioHXI5oxmH3+ly/hXwYU0KTAT3LFHF1XbH8CcJf4UQ4KvEmzDaR2iKO042fw7f0tnJWa/+Vz21e7WrcWH0iuseQGumCjvNvXyvci+9SPG0UkCI49auB61Ah7+OZ/OaRnsIHIUNVFNJqJrQZrPs5u3kGCIuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6Dk9HcncLoSggkd5FJs7BV99D54WEShq/DZ8qCFiYw=;
 b=lUyDOvYc/PP1k3kUm32JY5Fit3IOt12XR+QtwGb62G5V8uWon8NmRuwEw6IbYMrE/VgZq0WkapuUSUFbS+2Cb0qt75k2ieSAqiE4eVvFX083048dRr7qd4dFAttPhxFbICYTbZQXYa/j65NA5jxpiOse4ACgYW1NzI5DF8XmJmZOnCoOawZXEzQhBZbotb3ZGhTE91C/S3KqGVbve44rOd9iCq++Pj/HZHiU74kAHrkb/fFyIEy/RH210Kp3DQzMEKZx2t5KWqPZQdpSyf7knOUXFf1UK4O9IrkHglq0K42PxSSeomwelHlOwib1T/P8b6fpOzYQqt4aFXmEloFBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 22:15:25 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 22:15:25 +0000
Message-ID: <273d8054-0537-43a7-bf0e-b65959592710@intel.com>
Date: Tue, 26 Aug 2025 15:15:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] x86: Support for Intel Microcode Staging Feature
To: "Luck, Tony" <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<chao.gao@intel.com>, <abusse@amazon.de>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <aK4xpRtQUU47tidf@agluck-desk3>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <aK4xpRtQUU47tidf@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:a03:332::13) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a23eb8-9c15-4553-9ac1-08dde4ee0e61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWpmdEJMdGZDckUwQk56QjZiKzF6MUs5V1BMbXNnVytMaEVoVTYzWWN0SkRS?=
 =?utf-8?B?cVptWENSakdBOHVpNU5CZGY4RWpnTVkzb21SeWNRY0ZRekdKWmxKVFA1NTh2?=
 =?utf-8?B?c1d3TWxYcXBJamJ5QjY1Y2NwM0YzMUkxaEVkVzJSWjdVc2QxWDNQOE5WUGtE?=
 =?utf-8?B?ZVExekF6L1dZMmVHTVljSFJ2ekhhUU1NTFNsZ0VzNVpOcE44L1IzY2RxVmdX?=
 =?utf-8?B?L2xqZ1R6Q1Jaa0xXMGR2cmVaYjB6N01MeFVYSzdlSm93SWpkWnVScldWU2ZR?=
 =?utf-8?B?d0IzaVR4THZ2L3JBeC9RdGkzN1dBQnZUN3g3VGNJV1Bhc1E0VWQ0VnJzMDF4?=
 =?utf-8?B?bExOam5RL3dRR29vT3JCWnlYOGtzaEdPZmlRTHNxMXY0YmhVb1ZYdmxpTk5Z?=
 =?utf-8?B?b3NNanNQUUk3WkNrK041NUk1djFUREIrK2ZLZHhXWkI3d2s1RlFIdGJHU3pQ?=
 =?utf-8?B?b0M0Z2NkMXpYdFM0NkxDTzM5bCtqclpjRWc4cktKTGJndThreGVMWnB0cWNK?=
 =?utf-8?B?OW9lS21ISkU4NGZMS3pZaG40MS80TzlCRExabHdLZUJCYjV1eXBucTUyN1JQ?=
 =?utf-8?B?eUdhZ2V4UGxtUW1nNW56TzdmZm1ZeGp4cElmQzA1cWZYS1RRcHZtL1hkSGFk?=
 =?utf-8?B?Q1hzeFFhSk4rSTFCNWZwWmNic2xEbEZ1VWRzOTdHWVZGR053SzhaYzhpV3dp?=
 =?utf-8?B?NWowajRCUGVvUEpvbjE5VXh4YUc2RS9YangwbXhNQkEyalpiUUFKWnZtVncw?=
 =?utf-8?B?ekVBbkw4bmwvSTNYTHFibHorRFgyUWp0dVRxbktoMGRzeHZlelNjQXlDdXNF?=
 =?utf-8?B?Y0tUVW9vN0I3d0NQM0dOZHFvbWhMemp0ZGtleDdUZFliM3ExQVZBVmJOdHdo?=
 =?utf-8?B?TUpVdVBFVkRHbkg1a3greUVsV1lWMUUrWTByMHp3V1ZXSDBWa3ZzY3RPM2dz?=
 =?utf-8?B?Ym5PUUpOMWNhckJqMGJBZXpzbG8yU2I4NXJFdWdQaXpvUmg4OXV6UGp5Q0Yw?=
 =?utf-8?B?OXVxZnJEQ1IwdzF5ZVc1REgvb0JBSW5udXpTY1d3ZFVlc3Rvd3ZXTE9vWkM4?=
 =?utf-8?B?UFdzOXk5WkFsUFUwL2lHWXhiV1llSkVpMnVvZkQxd1kydTlZaEtQcHV0VEtY?=
 =?utf-8?B?ZkdGMCtSN0YvSEtyNFMxbkl4dFF1NFBiVkN3dExsSEFTNHZJdDBQUkJCZVk2?=
 =?utf-8?B?NTIyUzJYSUJ5NHVncFUxV1czbDBxd1JHMmxpWVhWbjhXZFYzQmRoa09CdzBk?=
 =?utf-8?B?R1Jxd0hPb2QyN0E1UzhuNzdkRmNtWUYxZmZGQVZ1WTlBSjErbG1jL05EVUtw?=
 =?utf-8?B?dFBuV0w4NE8wS3dland6aWlGTWFmRVZRelJjSnZ2Q3Z2MFVSbk9XT215WTRJ?=
 =?utf-8?B?L2FrbmsvenB4TTdUbXk3eGtrRVZRcVpFbVpLVTRTd0N2TlBkbG9WYzhsNFBo?=
 =?utf-8?B?Z05DWHBsUjB5RzA5Y1NVNVBjUjV1dkxITWNldHVrZGFTZ0Uyeko2a2h3aWF5?=
 =?utf-8?B?ZFc0Kyt3cGpvYlN2Q2VJNTJJcU5HUHROMTJjaHJtZ01ra0hNeGZjTDE5RE51?=
 =?utf-8?B?V2R6Zldsc0M2TFN3Q1BFWExUU3JJd3RzY2M5TFVPNXRsREdIUDNYRno3Mk5R?=
 =?utf-8?B?Tk1kSXprVlRwSHhaYlc3U0JGYmVIRjRndWhPak9FeC9xbnF1YmgxcDlpNzZv?=
 =?utf-8?B?QWltMWE1bzJ3c1BMdjBwVzVIODB6ZDFjYjJyZlZxMlF5a3JHREg4RVgrSmN3?=
 =?utf-8?B?aXdvQUlwUmJnR1R2SnB2OHh3VDI0TUltUFgwSWk4QVN3ZlB0d1lQUFcxK1dX?=
 =?utf-8?B?UkZHQXhONFlrZHlUc1RIc2h0bGlzT1ZzZDgrc1lzcTJVYnZCZDVXTFM1UmFK?=
 =?utf-8?B?V21Xd0QxaXFjck1aUTlKTzNjYzZuNVgrVWtMZFpxNXFpTHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmI1Qy9Id2J3Z0NXa2tHUHB5Y0toa09MRXFVUDNGRVZqL3dLa3JBc3Z3Nzdp?=
 =?utf-8?B?d1RYRXNoSm9DZXFUMi9uM0UwK3dtZEFhUzZtdkhrRUhpdlBrU2ExWDBhbU5Y?=
 =?utf-8?B?REg2a1ZxSGR6QkViM0poakxHRTA1M3RDZkkyT1oyUmIxbjdkaU1sUFZiUGRV?=
 =?utf-8?B?RkJmc21UTDdpWFdUYUtEdlowZEJEUzVCMlZnWnd6K0p0SklqZXpKMmZuUUVW?=
 =?utf-8?B?Mm9iaDV6a2dBaDBiM0RGVVUyVC9IVW9WQ2NseG9hS2RGNHNxVmIzcGJwdVJ1?=
 =?utf-8?B?d3ZrZGJwQnVCeHc4U0pTR0VmUGY0YUVtYUVzT0VGRXlxMldjYmY4TC9BUFpL?=
 =?utf-8?B?ZnhrN3JGbjQzVkhuUEFIMkYxN0p4UnZLeDJodHV2T2dJeXQ0NjIvWWd0UEV1?=
 =?utf-8?B?K2swSGVOeVVjZjR4TTZYamJWV1dZbXllV1p1UFBXWlg5dEdmajZvcitjcThr?=
 =?utf-8?B?R3ZsTEtRY1N4aUF5QytYN3FPSW1obGV3VVZlY0pmNXQzY0xFdy9weDJINjVi?=
 =?utf-8?B?eGlmbXFRYkllR1JGVjdrYzBzZDVTbWZhTUNwZ1dzaVBVam5MSTUwL0s2OERC?=
 =?utf-8?B?WXBycUVsTjgrK3lXNlJ5RHR1SmlEM1ZPbEVtbzg4MkFWVmtRM0E2dGFGVUlZ?=
 =?utf-8?B?NTVyL2czYlZoYU9CWTAzMnlGZUtGRjZEZm9HTmp5Ty8wL004UjNJVjVjK2VQ?=
 =?utf-8?B?WW1yeDZLTldOUG5nbVZkL2lzMG5VOFhFbUZtSm5NY3Bqcmd3NFp0ay84UUpr?=
 =?utf-8?B?dGlmQU5FRUpra3BoeGVsS09lRjJYM3hHdlI4bDMycTZpTnVXUlBOZkhJQ1gw?=
 =?utf-8?B?TWF6WUQzaFBUTllrdVZXTVRTWmFqTXpXR1BnbUtiOHN0YVhFdGVzYVVBaUx3?=
 =?utf-8?B?c1FBM3Rmd0dLaXlZM08xLzJrMnJNbXFGeEZCM2c2NjRxcS9mczhsRm1lZkFh?=
 =?utf-8?B?aVBFL3BwUUt6cmk4L0ZYMjJtVHIwYVQ2NUdGUWRRSjU2Z1lYc1NTUDZ3YWhI?=
 =?utf-8?B?dVYwdWxRcHR4bThqaHRmOWVCelVrWlBVR1FGdzk1TTRtNnBKTDRLdExPcWNy?=
 =?utf-8?B?OXIxVmR5TERCOVMrUTU0U0hma2RKQmZ4ZllWRlBaQm5udkk3YldXNzhFTXgy?=
 =?utf-8?B?RzAySVg5RWF6cWZhanhYRXV3RGpSUUVwN21zMWtFNGgwSGV3dnZzclJST2Ft?=
 =?utf-8?B?VmdqQ1pwMjlXQXpMTWhjQlBicXdLQnBvb3NyNnJCQ0RkaDdSRnlkZVowYVd5?=
 =?utf-8?B?Qjd6MExjZHdLRmJBT3ZSdS83cjdONk1tbExtUVJCMUVOUVNpYkhHTXNZQzZK?=
 =?utf-8?B?QW90SUYxb2l5K0d6VVdNRm5xRG9LWkZQWVcyMGNpMlQ5TktDY0pvOEhaZitH?=
 =?utf-8?B?dDB5VWxzMUhJb2RkS3NpZFB3dVFvcFU5OHEra0RpUHQ0QUpvWTRNNUpZNUda?=
 =?utf-8?B?ZEM5Qjc0dzFycFp5TGN4VUNhWjc4WUg1VnpQNGd6dWdxOGlCTkhTays3WjVL?=
 =?utf-8?B?VFVSaUpMM3kwNlZ2U3IwUHVXRkNhVlJCKzJzdEJzV3lMblJGcnVORFNPaE5O?=
 =?utf-8?B?blVmUG9XU2dqUDJvRXZxYkh5M1ZJZU11K2dlbmExTDNjeHRKbHhqMU52dDlO?=
 =?utf-8?B?SVduOHh3Q2pZUVI4QTh4emhuQ2FaYlYzYy9yeW5XUS82cWhtbFg1KzVNQVZT?=
 =?utf-8?B?RkFFTmtwUUxBMXhNZ2FycDNNcEhXU2VqM0ZlQnl0SXZIVHlEOC9MbUtuSXFa?=
 =?utf-8?B?aEpOZUp2cnpzTzY5dmFmbnlhcXc5QTNBcE1UQUE1cEhCQ0syTzhmZ3NCMkRw?=
 =?utf-8?B?NTVVeWJ6STdIV0haRUgvYlJuNE14MHlEZU8rQm9FUWI2b3k4RWpoQVRSb05P?=
 =?utf-8?B?Q3diT2FnQnVsUGJFRWdKNmpsYjk4dkdGNllhaTh4c0lsM0xKUjZMWTY2cGlS?=
 =?utf-8?B?U3pka29QRExQSzJFRVE4dFdBRGkwS1FKdjl1WTVxZ1p2NWtJaFhKazBLRGxk?=
 =?utf-8?B?YXdIQXdtRWV0eTdNVjl3d3VaNnR1MEJPNzJyTFloV2s0ZkJESUNVMTl3R25Z?=
 =?utf-8?B?UGNjUFpmcnFldEx5bFU5bXl4ZCs5bUJvalhpVDVxaEtWdjFaQ25NbHRtT1lS?=
 =?utf-8?B?dEF0UXUyOXMrZzF3OHNDV3pXNzVOdFlQRlcvVHh2ekQxeHdaSmx3bUVtVTFM?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a23eb8-9c15-4553-9ac1-08dde4ee0e61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 22:15:25.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofaJIPaMt2XWTrWpop64yiwRvkEdBKdC1hgl0565eKR+9dUQk3/zigS77sEpE2M/kpquJfxIJgk6Fgh3XnSpyTaKyGOaiMhtxfiV4N5VmrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com

On 8/26/2025 3:13 PM, Luck, Tony wrote:
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Thanks!

