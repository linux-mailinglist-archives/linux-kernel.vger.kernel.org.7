Return-Path: <linux-kernel+bounces-723916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF50AFEC67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7205A3404
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557212E54A6;
	Wed,  9 Jul 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nj2QXn2k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E2135A53
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072144; cv=fail; b=AKHXwQ1SXveg/vPJIZM8oyX2lY1b+3v4OvCNq9qxO+hZo8veW3SbISQ4iN6yE/MY2/W+jpeAsL9m+s2QwO7LlckmVGFGP0u7WuaF69g3QcwkY+E1lvQ1T//FDWJsU/cDW6pgM46Lh+HBlIc8phWlj50ePGAoYZlRHPUDQ6sbD8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072144; c=relaxed/simple;
	bh=GPI+qal+x1Bp1XkNM8WB5b5KTbrz7+/V8hqRSpMd4Vc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnJ0PFpnqZClveZRQmuHwV4QVhIjCSn4dmiUalXMcTYQHeK09V7A840V4HNX20u+MGnTcoME3P6OouuWRJwyrdXhRuUnBwVKX6xtoTtFiKZsPxBHx0/WHzMmWnnwZqf74C5CyKPfvmJ1yRT1JgT5vRpZaZc6bQijyDwasxn6fiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nj2QXn2k; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752072143; x=1783608143;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GPI+qal+x1Bp1XkNM8WB5b5KTbrz7+/V8hqRSpMd4Vc=;
  b=nj2QXn2k5lU7m3P9P8xQUwoRWkmuFkFV8+3zscznyRT11yOwSaMuK6Ol
   2fxlofJwMjxe5jq5mZIyHpuausOUJST7EbM1SvCp0e1lfFDqadVU5xGUO
   T1akBRUH/fK/YjfaEwwai++GZkX4nebdPKLrUviuqxvBHq7BmLNfwsg1r
   yNnWPERog7uTzDybljUnGBK/+5LRz8V1yQyeJl8BXzlJfTWjd+GSu1UVY
   jHN7/TFdvAva03vWYo7lPFJOHLLZ+9dK3advuK2XbbwcCbXaHycEPWkaF
   JAmaUaoTg9XS8iVupLNZAx+CuNUOLWCQYxzLRjErN41qAzs/zBlqTzrx2
   w==;
X-CSE-ConnectionGUID: fxupCyLlRdGGwMlywllx4g==
X-CSE-MsgGUID: YodtxfysQXm5LFRXl4eIsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71782114"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71782114"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 07:42:22 -0700
X-CSE-ConnectionGUID: wdgGV8r0QdykSmafW7DOWg==
X-CSE-MsgGUID: PamNag75RD6To0+CAw9MDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156279631"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 07:42:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 07:42:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 07:42:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 07:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+jaNA9ajk7WVXaj47H3fL6U16QG7O79aa8Po8Vf5ppkVkSor2nZWoDLBUhLOsWGyOqICeoU0Laroqev+XcCkLgjU5bRCMlD2AD9EomZHkb6wXJvq3CTapMpr4padh7eH/u3Itqi12onAK2u4ULxkQ18BQPP4WchVNM/dJAW1CQqDSPcQjx0X2lBtmaw5q6lKJPv3AyBERLxneKKp0LAEmLrQjZn7kmTzVIm8qUqnhzlm+9k5K+a/q41pZJcZfyUmJf9hoIAMT05aSFwZsT2mHIev10uOLctHbx/dicAYOwcJeXnx5R5z4KlMPz6ijUrVEDVpfo48Zc1TFmiaXtqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZRUTak6USk+ZJ4v+PhXSdfMf9k5PO3vlEMd8npqq8U=;
 b=eIqktZ407Fm5krH7UMmjgUJfR1ieN7zrC/n8mexQtoSl+5EqlqKZC2sLm0S1ozk9gaCukAWIPSe6/hTYMVb+MXJQtI65RBQQxJgEnYYfiwKDVj2Lj/qkZt+w0MBEMBSPQi4p/c2KqZoG++jwkLha7bSdU+Sqa5qiT1x9E8W49FJ3cXv4kX42KaTK4g7M6WfVgD8+GMQifK1gM5+QOb8CqW3n0817NrsbTDxQfuPpo7cik6SNMYTosXfzKmyAnEwmcZRAqFHCSq9vtNL0xLVy2afONcUoTOwcpvfGASfJ7MuNVRLw1u+1q+0MxIDQKrnJFro95wqb+IV519u1Mm98LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA2PR11MB5004.namprd11.prod.outlook.com (2603:10b6:806:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 14:41:50 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Wed, 9 Jul 2025
 14:41:50 +0000
Message-ID: <0c0bd184-6926-424b-9ef2-f3910be18073@intel.com>
Date: Wed, 9 Jul 2025 22:41:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC patch v3 07/20] sched: Add helper function to decide whether
 to allow cache aware scheduling
To: Libo Chen <libo.chen@oracle.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Abel Wu <wuyun.abel@bytedance.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>,
	"Len Brown" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>, Tim Chen
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
 <abb433c3345587d068e5381c65e9d0b3f50828d9.1750268218.git.tim.c.chen@linux.intel.com>
 <7f4f1684-fbe6-4148-bbe4-fc2e138abb98@oracle.com>
 <6a36eae1-7d1c-4c23-aec3-056d641e3edd@intel.com>
 <9e78f54c-f993-4505-814d-b8815f5c6bf0@oracle.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <9e78f54c-f993-4505-814d-b8815f5c6bf0@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:4:7c::15) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA2PR11MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0e5e52-4eaa-415d-3743-08ddbef6bd05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODVhb2xDc2UvbjBFSlFxV2c5eTlRZkJ5Qk5mWTJSZGZXVEpvcW5jcmdBZm12?=
 =?utf-8?B?KzhVZmRQdndPQVN4YjljbWhnWHh1dkxaN0JXR2FSaFNNdkxja2wvWFRTVDNa?=
 =?utf-8?B?cTgycjc3emdYTWFuRXcxd3IwZEFXdU1KSUJBajc5MTlJRm9Zc3Iyb0N3VEpE?=
 =?utf-8?B?dmhodVBibTRiOHNYN1BDbEplZkJuTXcvNmtHZ1A0cjdMTHM5RmxpdVpGWmhh?=
 =?utf-8?B?bmVKZVhOaDZPR3pQWXJFS05hMGNLcGR3QmpBd2NJcGlLb3B4SXhXVmRGUXl5?=
 =?utf-8?B?KzFHTy9VaDVMZGwrMXJGZFk5Ly9YYlRCL2JrZWJ1Q0EwVklSRGNtWjdKMTNU?=
 =?utf-8?B?MzBYT3N0Wk9DL1UxaXBscnNQcGpjdURVZHQ4cE1veXdlaWtVd1VFVENnUEp1?=
 =?utf-8?B?OW1aeldRNjUxdHdnMEJmWmJ4UUVPdUY0bkxyVFVUVUJ0SE9KZ0VEbENuaGVO?=
 =?utf-8?B?NTZxalErYmFBZzFBajh4NGltcUwxb1hSdHo3dGVXcUdFenNYVEFvWjd3VTBP?=
 =?utf-8?B?Rm5CRjJCV0xydVhxMmF4MlE2dnFXZFlQOHhib0UzQVV5UkswdFdLdENYRnI3?=
 =?utf-8?B?YnRsZDcvbXpZRjNIcEtQUCt5djNFTWhpVFgrZTBSYnBvNVZaT1Uvd2ZFMEpu?=
 =?utf-8?B?cTJia01RMlJYa3NhQmNLNnd0WXhSUTk1UFZ1a3poTVBrd2I2UkVmUzE2QTF0?=
 =?utf-8?B?ZDNMZkpDcGxOT2dYamw0ajlNaXNzMTlCWUczb0JqamkvRThPeCs0RGhKVE1o?=
 =?utf-8?B?ZnVpdlVlYnQzN25odytnMGtoeis4K1RmRXNBc0hnSytFbWdoYWRtUWlXUTcw?=
 =?utf-8?B?T0lPb2o4N1l4T3lYTTU0Z29ycGlXclBUM0N0Z1VDWkQzYW94QWpGWnpkNXEx?=
 =?utf-8?B?Q2lud3B0ZkFhV1FhN1dLbmJqcVNKMnJuR295V0wyQTMyeFhpeGtBT2t6NmNS?=
 =?utf-8?B?ZmtXbk9mRTJyd3VZc1I0SkliM1k2RmlRamVtSG8yRFlhOGNieE1zMmtqcXBC?=
 =?utf-8?B?OUpjamJqN1VJSXpvc2xUTElIMnduMnNxMzRXYk5KUm15bXdaZFV5eFpPVDZE?=
 =?utf-8?B?cHdTYkd1OWtScVlCK3FzS0l5SzI0cWJBbVlKK2VMQjBRVk1jRUJPV2MrenEy?=
 =?utf-8?B?MXY0Mjh3OVV2LzFrbWVjZ0tXbUxBOWtmNi9ySTJaczY5ZlpmdW5OMmtoQ3lO?=
 =?utf-8?B?ZlNiYUpXaXAyNU5PSGtpWnBlNGtUV0FRQmFScE1kMVhtRW1qck5iUTluZFN2?=
 =?utf-8?B?bERjQy9xNE9sdS9zNUJ0NFJLWTl2ZXVuZVcyUlJna0U4TVN2TWlrSDkzd2tv?=
 =?utf-8?B?aEp3QlNMTStjVDhualZyYTZWK0VhQlpMWlJPbzhYUGdvL0Q5ci8rSytXYVdZ?=
 =?utf-8?B?WnkyU1VZS3czc3FuRTY2VS9XYVlpZHZvS2swR0tuWHh4NGNmNlFVNXZtV2Nx?=
 =?utf-8?B?a1E1WXMvQmxRdlN6MXZyTnZTUXR2YlBZbWI2MVRpNEJMc2RPVWljbklwQ1N1?=
 =?utf-8?B?NExURmZrQ1RDNzBDdVpwL095ZWQ5bmtPVG4yeDBiWnFUaFIwWWFxVXNDdENR?=
 =?utf-8?B?djRxZFArZ3dzVlNtb0lpb2NoWE92eDNpVE9kN2ZxeDVYNmM5cjMyUFZhZlAz?=
 =?utf-8?B?V2NyY2k2QmZvdDYyZDF1cFl6SkZ1MnR3d1Ayc3lQak0rc0E5MW5SN3ZVNnJS?=
 =?utf-8?B?VVd6QnJhTWJUbzNBQkl5eFNhOFRBS3piVno5b2JZRmxOTE1Hdkk3eHNoVTUy?=
 =?utf-8?B?aUlaQmNKdkcwazVsUW83OCtFN0JjZC92MzVsRTMwSnBsRW1oWENJd052d25K?=
 =?utf-8?B?amxPQUNWN1NlMHlRMEJpaEo3d2JpNld1SjY0QUhHYUtMSDNUOUVDVkhGM3da?=
 =?utf-8?B?UHVlOUZxa1dMbEhpVm9UVnZkbGJlb0F0S2hsVS9ObUIvczFuZnNLZWhJNEdV?=
 =?utf-8?Q?cOUmfq4Ph0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M01Tc0NwWTZqcjZIM2xxemU5RXp5ZG9aR3RNRmxOeXh3dXNuUGZycExkY0Fh?=
 =?utf-8?B?MXRadnVjTDB5clYrNG5HL0ozQjdDZ29hcGlWaGdmenJIelp3d0FKNTFoTlky?=
 =?utf-8?B?dDZKS3p5eW9iVUFFc0FYejlBUzNza0o4ZnIyRHozOE1lZDhIUHlQbzR6OUZM?=
 =?utf-8?B?WmlaOCtsQzFibEVFZk5sajM4aFJ6UWZGd2k1azBpZC9TSUZDeUdvWUtYM285?=
 =?utf-8?B?eFVMeWFrUHNIUkY4Z3lnR0tEb3hYdFIvZDRkYUlCendyUXZCd2o1YUZMY0ZV?=
 =?utf-8?B?QXpsYjFKOENVZWJkRFFKNXp1TEFnRWZGMHRVa0I3QWpFbWJ4NEM0WlE1U0J5?=
 =?utf-8?B?bU1QTTBBVHdGM3lONlNJQk5UYm95UTZjZjh2dTR5OVpzYkQwYk9LcmhHMkF6?=
 =?utf-8?B?TStiYmx2cUQzaHZnREx0WXkzOXgvMkd0TUtjQzNQOHoxKzBRekIzcDlhaEhm?=
 =?utf-8?B?TXF5ZjY4S0ZMTHllQ1h1NVBOcEcrblc4blB6RUIzNGtLeUdrWHFDWGJaVTNK?=
 =?utf-8?B?c3VkaUtnWDU0Z29hQU02QzJHOTBDN25XVXhYTEEzTEVYUU9oaUxrN0pzeHdH?=
 =?utf-8?B?b0xxR3FnbWpoNUdhS05UemtyblJsQ0xrck1mRnliOXFyVHJpVVRlZ1lncTNR?=
 =?utf-8?B?VEVqY2Y3QUhKSEpjNzVzRjJwMU50TmhLN3ZkL2d1ZlZKaWFwNzdndk5SZUtT?=
 =?utf-8?B?STlBRXdKUGp5dGlwNFBSYUhRWUFhL1Q5M0pVYmgrVHUrRlhqdVNYOE5GT3Qy?=
 =?utf-8?B?SW1kdFRQUW04SnhnVHRrU1NDSFdQeGxjNnZpa1Zzbml5UEhFZzBkTFBRZkow?=
 =?utf-8?B?bkoyRmpTQlI1ODFDUTZlcVRzOCtWME8zTkJHU1VHSXJIcGNOVjJEL1FsR1l5?=
 =?utf-8?B?L0ZUTHUyRithL0kzaThBcWpsWmx2d090QlREVjZGL1U3M0pXZWFmQlU2aVdE?=
 =?utf-8?B?TTd2MVYzcVF2alZJaG9RZHYzL3pXbEV3TzBhM25YclVPbTZLU0hrbjRIa3VJ?=
 =?utf-8?B?VnkwNWlhZmRMbmJhTm5CNkVQSnBiMllSZjVoZENaNnBiazE5VTlMMDU3NTBN?=
 =?utf-8?B?MEtXVmVRV2lvVllvUFVyWVRmTDB5NEI2UDlUZXo2UGVoaWE4WncyQjlndEY0?=
 =?utf-8?B?eURCbnZvd1c3eEJ2bm5udVZ6MDlta201VUE1KzhON2pXeDlya2R3VnAvNlo0?=
 =?utf-8?B?NGNNbDRDVFBQeEgrNENzMGVZd1FNOWl6Mm1mSUxvS0M0ZW5obW1nWlRJdWM2?=
 =?utf-8?B?OTBzVGUwWHBHUHZqck4rVkFzSVhaOHFCZjRrSEFOZDkydDIxYjBNOTBnZE9v?=
 =?utf-8?B?c3kxWWtIYVd6Q0s4RGszc2l0QUxkeVdMRWMrVnlHZVNZaWZnQXI0d1d6N09u?=
 =?utf-8?B?QjFpOWVQSzdPVDBKRmFyMXg3UmE3Z2dXRFpzdWdCTkRhZ3c3bUhvbld2SDhB?=
 =?utf-8?B?MVJ6TW1xY0NNR0JZNExsMnBWcEhXSjNmWWZtbllIei9OSFF2Njlna0V4bnBU?=
 =?utf-8?B?UlpRK2ZwUTh5WDByellMTmt6MHRhMEJrbnV1MHl4SytwdjNISGhhSjdxWC83?=
 =?utf-8?B?RkhGaElxQXU4RWlsUTExZitXOWQrVTZQRnEzREdTLzNSWjRSTjRJaTZpWVVt?=
 =?utf-8?B?d2hnVUpXNExuclN1VE1kaWgxL0E1aUI3S3cwcFdVOUxaWmNuZ2NWQ2luTEZE?=
 =?utf-8?B?eEJaSjg5bHdrTEZJaDhITVJ4eFZCMC9FSE9JRlVDL3BPd2NZOGFlTWdXWlAw?=
 =?utf-8?B?dnFiYXVyNi9vMURiSlZoK0N0RzhyME5POG56VFhrV3QyaWNtRmxpcHJ3bEdq?=
 =?utf-8?B?dm1CaE5XcU91VWo0d08xNmJhYkxqbWZJMGRkcWlSQktvdlM2WkpCaERvZFlz?=
 =?utf-8?B?dVBHbktva0lOZnQ5SUliWThPS28vUy9YU0ZIK0pYSDRFeEVxT05vdFN5eExT?=
 =?utf-8?B?VElBZVRMNGhZaVNiclEzV05uYnU5anhldEoydUw4empjb0t6VnRaOUZSY2Nt?=
 =?utf-8?B?Yk1JREkvN0huN3Z5NlltWnIvZHV3eHZrWmtFOU12cnZYUEtObmNBc3RWL0lK?=
 =?utf-8?B?MVQ0azE5MUhHSEticjV3d1lvU2JZVzdIWVR3OG9EeUZqUStGd1lTQ0lhWmlS?=
 =?utf-8?Q?2nGEvEvecg4pxPDoz39fW2GO+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0e5e52-4eaa-415d-3743-08ddbef6bd05
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 14:41:50.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NKXd0CqviRcF8x/k8PusvLiPCAj4gpT4Qq5UKi7py7IdQyx/h0yajQASAbmiI2jKko+rg4au4ra4d5bkXFk0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5004
X-OriginatorOrg: intel.com

On 7/9/2025 1:22 AM, Libo Chen wrote:
> 
> 
> On 7/8/25 01:29, Chen, Yu C wrote:
>> On 7/8/2025 8:41 AM, Libo Chen wrote:
>>> Hi Tim and Chenyu,
>>>
>>>
>>> On 6/18/25 11:27, Tim Chen wrote:
>>>> Cache-aware scheduling is designed to aggregate threads into their
>>>> preferred LLC, either via the task wake up path or the load balancing
>>>> path. One side effect is that when the preferred LLC is saturated,
>>>> more threads will continue to be stacked on it, degrading the workload's
>>>> latency. A strategy is needed to prevent this aggregation from going too
>>>> far such that the preferred LLC is too overloaded.
>>>>
>>>> Introduce helper function _get_migrate_hint() to implement the LLC
>>>> migration policy:
>>>>
>>>> 1) A task is aggregated to its preferred LLC if both source/dest LLC
>>>>      are not too busy (<50% utilization, tunable), or the preferred
>>>>      LLC will not be too out of balanced from the non preferred LLC
>>>>      (>20% utilization, tunable, close to imbalance_pct of the LLC
>>>>      domain).
>>>> 2) Allow a task to be moved from the preferred LLC to the
>>>>      non-preferred one if the non-preferred LLC will not be too out
>>>>      of balanced from the preferred prompting an aggregation task
>>>>      migration later.  We are still experimenting with the aggregation
>>>>      and migration policy. Some other possibilities are policy based
>>>>      on LLC's load or average number of tasks running.  Those could
>>>>      be tried out by tweaking _get_migrate_hint().
>>>>
>>>> The function _get_migrate_hint() returns migration suggestions for the upper-le
>>>> +__read_mostly unsigned int sysctl_llc_aggr_cap       = 50;
>>>> +__read_mostly unsigned int sysctl_llc_aggr_imb       = 20;
>>>> +
>>>
>>>
>>> I think this patch has a great potential.
>>>
>>> Since _get_migrate_hint() is tied to an individual task anyway, why not add a
>>> per-task llc_aggr_imb which defaults to the sysctl one? Tasks have different
>>> preferences for llc stacking, they can all be running in the same system at the
>>> same time. This way you can offer a greater deal of optimization without much
>>> burden to others.
>>
>> Yes, this doable. It can be evaluated after the global generic strategy
>> has been verified to work, like NUMA balancing :)
>>
> 
> I will run some real-world workloads and get back to you (may take some time)
> 

Thanks. It seems that there are pros and cons for different
workloads and we are evaluating adding the RSS/active nr_running
per process to deal with different type of workloads.

>>>
>>> Also with sysctl_llc_aggr_imb, do we really need SCHED_CACHE_WAKE?
>>
>> Do you mean the SCHED_CACHE_WAKE or SCHED_CACHE_LB?
>>
> 
> Ah I was thinking sysctl_llc_aggr_imb alone can help reduce overstacking on
> target LLC from a few hyperactive wakees (may consider to ratelimit those
> wakees as a solution), but just realize this can affect lb as well and doesn't
> really reduce overheads from frequent wakeups (no good idea on top of my head
> but we should find a better solution than sched_feat to address the overhead issue).
> 
> 
> 
>>> Does setting sysctl_llc_aggr_imb to 0 basically say no preference for either LLC, no?
>>>
>>
>> My understanding is that, if sysctl_llc_aggr_imb is 0, the task aggregation
>> might still consider other aspects, like if that target LLC's utilization has
>> exceeded 50% or not.
>>
> 
> which can be controlled by sysctl_llc_aggr_cap, right? Okay so if both LLCs have
> <$(sysctl_llc_aggr_cap)% utilization, should sysctl_llc_aggr_cap be the only
> determining factor here barring NUMA balancing?
> 

If both LLC are under (sysctl_llc_aggr_cap)%, then the strategy is still 
to allow
task to be aggregated to its preferred LLC, by either asking the task to 
not be
pulled out of its preferred LLC, or migrate task to its preferred LLC,
in _get_migrate_hint().

Thanks,
Chenyu

