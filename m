Return-Path: <linux-kernel+bounces-853763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8716ABDC8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E57C4E475C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF752F7442;
	Wed, 15 Oct 2025 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3LJHTkh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209992D3A7C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760504085; cv=fail; b=BzUU5hcnPCRwj2QQuFR2yBYTy76mt+bmehkQqO5Fv8PZUY4T6rdPG4RGJdP2zRrgDWi3Guzek1aWoPEQ1ICbKJCCxIa0hKh0BDe+GA/eB0c92HpCYkkhECyo010GD2IxjtdCM1Iz3IRt6GQZlY56gqUewUGZqY242ZZy6inZ9eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760504085; c=relaxed/simple;
	bh=h2Tni2Zz//MyCqgEJCPGn9ofvDI6Swxv7iyCLWZ599M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q229tNE7iDK1ATpLbBG+92+6HXwCP0BfvfiGB/7kJ1m2dRADbKEr72w0Q4z8OVyovnBvtrJ93HUOGHaMt4ieLC0zjC8PwLrJWaKvfHCZP6CtDU7xy0YvygT+hdSJwuzYR6jFvPCzTVdiaQJleQCB1WsTSvPHnWPYTGN2xzJWzFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3LJHTkh; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760504083; x=1792040083;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h2Tni2Zz//MyCqgEJCPGn9ofvDI6Swxv7iyCLWZ599M=;
  b=i3LJHTkhmnFWjRs1P0lqd3mHo8HzvxKqlzSrhndFtYDdOY2T7hbAGLR/
   wwSbHdzxbKT0NYlQuiuJBj9MY296IcqThxgybNrb2MbqVH14AJtoVoBW2
   5f8HWHnQySF2BQiR06R+9b3w3xJiv3F7vnV+Y7JTzTQbp2dERQ+oUNpUO
   8/ejqj3hQE+pxvxHf9TIVmIwC+kHDfOdo7GrwEmcv1l7T3EnyBP7EDfW1
   7Ab+RqAD+/ErypFSbVcmJCc7iTaH/68+nddVrRoyA0czwnnFTXsyDIJ2e
   MUX8koHETtXtYH9A42IrU1F/6KwoDapv7JfYwOFHPNg1iw6oiJkvinesh
   w==;
X-CSE-ConnectionGUID: Qzug2nRJTuKgl9R+5PJrNg==
X-CSE-MsgGUID: rbkP6Vd7RPebrOVlLdtW+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="85288358"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="85288358"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 21:54:40 -0700
X-CSE-ConnectionGUID: iK554NaIQruniEujiBYJ/g==
X-CSE-MsgGUID: EAleK9t5QRmdjkXqtUrlKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181743764"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 21:54:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 21:54:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 21:54:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 21:54:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPpL/KbdoO3GRq9tjsi/WnBStf6N17tWt4Ow2zuLHtAbp5lWCZfc/IrF6JzE1OyMVv9NP8ADIddmJsTc/bADGAMIXDsGOgip578fix2raup65/cfzr7s8vB0qjWDbzDhz22gSpo7JZ8ciUaxoDaZw+pK2Kg3ShOqeukYlfNJJlKXU/QXjzMJZ+yjzE7bTnt+JB7Z3M5TfDy/IFJ7h9c90oZ6cc4Yx5PJuYI3csQJq+PtYvLaNqjY6qn3KQN56HdUxrBpOxHyu0Zs013Tc2bpfkDzpj4WMatQhDkIrPsbrQiLt+5r+c28RLXXzintS8WjVtCvZCD+ONJ7iMBFpXGgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmJsuT7FOd+GchmuPhVGoCe/34i5tkYFn9E5ooiOtfw=;
 b=UJ+azbdj3t13M8sGKM/USnM4b7MuiprxTGYXk+9RwCmclvqWkHUzrGtUYeVMOiE9zA03E8tpDkgElifZInGLbRb23HFXIxSOdajsYLGBxDC1rednVcgwq3IWUSugmnaLaBjndWYIstrUTP9R3D/F0iU2RH9k17O9b8Dyk54mCXGMp93DPHUnFGju/F6XRH0oCWjSz2EZ6pjkINmbRCn/V3oxGSvBaWdguaJOE+8Kzx+SNVwFOYu1UqkuHHBp7njIMnr0BAQVv6K+lAp0MemRnCCSixsoirwYZ8nZBcQZGW6Jwbca1Y7FgpS2tymXPAxGTgBiyrtNBeDrYnMQ/DpLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:22b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 04:54:30 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 04:54:30 +0000
Message-ID: <5f140e59-23f9-46dd-bf5e-7bef0d897cd0@intel.com>
Date: Wed, 15 Oct 2025 12:54:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] sched/fair: Add infrastructure for cache-aware load
 balancing
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Tim Chen
	<tim.c.chen@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Hillf
 Danton" <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Jianyong Wu" <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len
 Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, <haoxing990@gmail.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
 <22750d4a-fdd6-48ad-a2ca-aa0c12af329c@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <22750d4a-fdd6-48ad-a2ca-aa0c12af329c@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA1PR11MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb24a14-7b37-4c28-0645-08de0ba6ece2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXI3UGYvRzRIcjNHVnhYNVpUa1JtdHN4UTFaek1mT1VySEtCZmhJRng1ZENO?=
 =?utf-8?B?WFRnc25wOW81OGIvS01jaklFTjVlTjZ0VUZUSTcrdmkrOTZRaDE0Qyt2RzVC?=
 =?utf-8?B?WHlzOUxwZHI4Sm5UMzQ5RklBa1haUnFRTjVlc1E1ZUM4cDVWd2FoZTlkRm1m?=
 =?utf-8?B?SjZydjVQWEVZVE96MlM1cG9rN2o3cWZkMW1KSlY4MWh1NWttSW11RUl5V0hl?=
 =?utf-8?B?dFJYNWZqTDNyR0h4MTlvQmlvSmNsUjBTR1V4YmxweFJBeHFOSHJyUXR5Tkhr?=
 =?utf-8?B?ckZEMDBlQnBBcCtjOHNBdExaRks3Yy9wNTJPbzFCcGFudHc2THZKcGZiSnpS?=
 =?utf-8?B?ZzlhWFk3NEVvOFlhOTZMa1lkdk8zd1lJdTRhSkhuTUcvWnNPUEdqWTlrdmJu?=
 =?utf-8?B?OEYvcUhtSFYvdzJBNFV3RktIVWdjMkU0WmIzTFhOZnVkMzBHZFZwVnl3NnI5?=
 =?utf-8?B?UGoxZjZ2dFRKZzBHVkR4SEQ5MFBrWXZtdm9nVk9KalJ6SW5iMHp6S3o0NGtH?=
 =?utf-8?B?NTJtZGNibEpPQ0VVb0srT1F6UGJOZEpuREpTbldXeVZISzllTk9DVWRqbnFw?=
 =?utf-8?B?aVZjdUkwc1lXa2tOdHJLZ2dIRUhCS2w2QytYZEhiQkdIN3ZSOXhPak1ZeGE1?=
 =?utf-8?B?eFdiVkVrUG1TdmdsbTdQKzhON2xaUGU2L3VGdEdIdXdURWdTRDNZaGJEcUpT?=
 =?utf-8?B?OUVVbExMMU1vS09zd1IvRlM4VEJ5cWVReHl5TmdlWnBFaE5QU3hwMk5XUlJG?=
 =?utf-8?B?ajVRbFk2M3oxbmNLc3BEUDBWVE9XcUZUQXp5d01WN0ZpYWNwckRMdXRCU0po?=
 =?utf-8?B?TWdFTjJoS3hmQTQwcFRWc05FSnpOanNEdVoxb1phMTR6dEFpeTJkOWY5Mzk0?=
 =?utf-8?B?NnVVSytrQWN3TGtlM25SR3N2cElPZTQzdWZHYzR2dHlQY2VYU3l1LzZhKy9s?=
 =?utf-8?B?MkJVSEVrT20rTEdQRTV4dVlvdnJyclFHZFNYOFR1c3l4RndOcXRUTkx2eGNy?=
 =?utf-8?B?WTBZM2VhNUhFWitNMjY5UXc0TzZUNDliUjl3SmQ0R3dWR0hKelBGcHRoYnpy?=
 =?utf-8?B?bURZY1J0V241RWhzVWtFcFR1ZS8vSTJic0JvZk5WSTBuYXhON2NwQnNzOTJx?=
 =?utf-8?B?M2ZLQlZOamJxVkIwVU1yalU4ejQyN0RuU2tmNUJiT2I1STJjSForaEN0SERY?=
 =?utf-8?B?TjhTaXErTW8zalJCaDBnWDVOT1lTYzBPRHFkWjRxTG5JdmRSNTlMZlVQK05W?=
 =?utf-8?B?bWJDdDBFcFJFdlNvWlkvcXRCWDUrVnJzRWtvUzFZU3Y5aThpbnJkb2luWksv?=
 =?utf-8?B?dmRaSXJWbmZMODgwa1BlZFdVMHJLS0YxR2U2WGNqeVNBZUx5UG15Mk9qcXI5?=
 =?utf-8?B?V2ZVQU5GUklhNkVpVWVJejZHQlBHZUhyaVRsQzRGQVpUdDAza1FBTGlUb1h4?=
 =?utf-8?B?QkxNbFdkODlFVnBnamhPV3NhZjNuemEwbXMzWUlVRXNJR0pyS3EzRG1UeGpv?=
 =?utf-8?B?Njd6WnNtNXFHVmdyTk1RSUIyMTJPYmpPME11bXRUU0Z6K1hTZGZ4a3Z2N1J6?=
 =?utf-8?B?bUwxWVUyTVdoOThuSkJhN1hEWHRRQlhPVUJFaUFSZ3BtUXRDL0lJVG0zNWNB?=
 =?utf-8?B?YlRQcnl3ZCtSbGVqOGRQclFxVm1QcEhSS001QjJTMmF3VWhNYVBBSWs5eGov?=
 =?utf-8?B?WjZ6WTVQd3pOcDJUU0pBcUx4a3crKzZrNGNISjRBVnQ2bEZDQ3ArZlFVTjVi?=
 =?utf-8?B?TGQ4cGszTWE5b2g3VlZuTGltVmtTdjZsU3lGUTg0MGlJM3R3SldGaGRNUHhR?=
 =?utf-8?B?V2w0ZG9ENzQ5Y3FmVzEzNk1YMjNrczV2VjRvUE14MnFnRWVzMHRyYnlVUk1y?=
 =?utf-8?B?K0Q5Nm00dEpSNllhL1lJa0dIZ00xR3l1eWlYV09xcDlRczJMV0g4Rjdta1E3?=
 =?utf-8?Q?HVC7DelSjEEORhmIhQlDKE0S7Xt4fvYI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG9DUDlsbDZxb1MvNjBBMnFJb0xuSHVBRi8vbHlEaUh3ZXNtbi9DMkNrdXFm?=
 =?utf-8?B?Q0RSTVlTZkUyMnp5aE5JbTA4OWFnL2tVL1BlYUhIa2NHY004YTBrWms4bXND?=
 =?utf-8?B?eHQrK09sUHNqUGVTTzhlbmZHa2U1ZzdHVFkrVWZMSXJ1L0k5bTJ6ajhTcFpM?=
 =?utf-8?B?b0MvaUJiZytrUXRwL2l2anhsSGdCcDFCWkowRXpLYWJ3SWthUDh3VUl0WkxO?=
 =?utf-8?B?K09qRHdTMHNZalliUEdTRkhnOFFqTGFZbnF4Tm1FWTlZeXlrWWJzSHlTQnVS?=
 =?utf-8?B?ZnVDbHJsWi9LWEg3U09zVFJBdkRnTGdXaDhBRm1TOWJvTkl0MGRBQWdlNDIw?=
 =?utf-8?B?bUlkd0E5ZGEzQ3ZqVlhEdHI2R1RtYmczUTQvb1RKcXQ5Y085c1loNEpITm9r?=
 =?utf-8?B?anJqcjF2KzNPWmpVZnY1REdyazhlUnByUjh3QUgwUGlTaVhIaUJKQlBkc3BE?=
 =?utf-8?B?U29DZU5aOUlKblFpdExuLzRiVm95THNWbXRIbm5ZU2ROWUwwVzVvSG1MQlVM?=
 =?utf-8?B?RWJnYk1FRTNNNUlvb0JsWU9haDdEVG1ZZ3YzVFhNVEFpclIxVEVCcmp6UXZ3?=
 =?utf-8?B?ZVFmN2U1eGZsVXJDbTgxQmJzMTA4WWJmYnZ3b1drbHprSkQ5V1lmd3JubDNW?=
 =?utf-8?B?RVBoT0Z2VUZXSXFwb0VnRzBCaUMyMmxTN2FhT1N2MzNDMnM1cHVRR2dsbWhv?=
 =?utf-8?B?YUxzYysxaGU4bUM0QWV5eS9GalBRcCt5K3ZyK2J6VG8zZnE3SjZWeGpJMnVk?=
 =?utf-8?B?aUlXTUc2VVc2d1U2Vkc1VFhEamp6Q0VDMWZmS0pSVW55SU1vV1pua1VxVEJo?=
 =?utf-8?B?V1poc25tRUUwTWFmLzIraTRZK0twYU1yT1NjbXgwLzFBV0lvV1BBeUllWXN2?=
 =?utf-8?B?NTkwUWdNRnVYK3JhSWVnbEJBbkVqNkhvSitENmlYVkZmS1BMMlhYa3NLYWl2?=
 =?utf-8?B?ZVgvbFp0N21DSlZsRllXV3ZVd3J6aTlCU1BGVGtiRlRtS3VOdzlyTTB6TUVp?=
 =?utf-8?B?TGFBYitObmRLTFA5ZjNwbHphR002N1c4cjlTa1BkRjhBWlM4Vm83c01jaktE?=
 =?utf-8?B?Q1l5YXdObWRkZVVoTzhWVTR5M1Q5ZjV4a2VwNUd3YXBWT0hhL1lOTGpLenNq?=
 =?utf-8?B?aDJRdnZIWlh3MEQrMVQwMnFaMm44MDBZZzZ3dWdCMVpRMHNCRTNGUG5jZita?=
 =?utf-8?B?OUVJWi93NUxoalBvYUo0K1Z5WU1YL1dsclI2VnpBbytLa3MrcUdtdW1pb3hF?=
 =?utf-8?B?cjZJUmkxa1FyZHNzY1J6SE5kYXpWRTNVd3FkMXErNU5DQ0YwOGsycmZ0MGdw?=
 =?utf-8?B?TElQZkQ5RFFybjJpZUFMdms4WmRwN1cvdm9lcnZSYmtmRUxmdjlUYkxlVWhQ?=
 =?utf-8?B?QW9zeW1vc1Q0ZVdVeEMyQjY3Nm9URk1sbjhnNWQwcXNrSEZaaVdsblFlb3Nl?=
 =?utf-8?B?L0piQ2tEY2grdEJucFZidlBiaGpSVmphRzYweXVXSGw2azBFQ2tGN1ZoL3Qv?=
 =?utf-8?B?Y254ZktXbE1URG13T1ZiaThSMHFtSkI3UVZldjNJR2Z1b2s4MElpOXVxcCtT?=
 =?utf-8?B?dGMvRy83OCtySjhlRDRjcjVQT1gzbkhPSmYwTzA3ekZlTHdmRE5GcEd1djF3?=
 =?utf-8?B?SkJ4UXZVNi9RVk9DUEdtSHA2MzU2WVp3ZVlaRnNHVW40ZEg3VVI5MHJ3TGZn?=
 =?utf-8?B?TDVMWUdaU2xKUjVTQlQ1alhGWHI2eEZNUnFHYjl0MVNtdWlDbUNEbzA3N1N3?=
 =?utf-8?B?WlpHM3lGRGRIWk9sQ1FGQmZ3d1EvbWVZZlVMNlo1cWtCYUg4R0hta293ODlt?=
 =?utf-8?B?YkN6UDhMd1oxSklBY3RzOEZYOFNVYWx2VlZLRGk5SzNENWI2YnBZWTE5b3Zr?=
 =?utf-8?B?eWQzdW1PMGRwZVJsMGRBd2RNNzZFQ0dRTGZxNktOUlFuVGUvME1mcVFaWnM4?=
 =?utf-8?B?MWJGdXRLa3I0cGg2c2VKUTA2SlFGemNZdDMwNDN0TUc2by9FQ3JHWkNlTkxQ?=
 =?utf-8?B?aDFKLzY1YVphUjJnbFMyMGJzTHJiMDUyS01keTltRkZqSmpPaGRrL1lVdlAy?=
 =?utf-8?B?TEdkWlBwRUgxSlZCWVdvNzFDczR0UE1kRGR3TWhseWl1UVVIR0luZTJsd0ZE?=
 =?utf-8?Q?fJbn6GS35ChD3cM303zUjZcUe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb24a14-7b37-4c28-0645-08de0ba6ece2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 04:54:30.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yk8bvxNQ+XCTsL/KvkqKG02V7G6tQ4bGtBDGJCRb+eLnJlYGCBFpA8IQbdtEFRI8QFAIB71w6lSGrX+fD1ozpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
X-OriginatorOrg: intel.com

On 10/15/2025 3:12 AM, Madadi Vineeth Reddy wrote:
> On 11/10/25 23:54, Tim Chen wrote:
>> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>>
>> Cache-aware load balancing aims to aggregate tasks with potential
>> shared resources into the same cache domain. This approach enhances
>> cache locality, thereby optimizing system performance by reducing
>> cache misses and improving data access efficiency.
>>

[snip]

>> +static void __no_profile task_cache_work(struct callback_head *work)
>> +{
>> +	struct task_struct *p = current;
>> +	struct mm_struct *mm = p->mm;
>> +	unsigned long m_a_occ = 0;
>> +	unsigned long curr_m_a_occ = 0;
>> +	int cpu, m_a_cpu = -1, cache_cpu,
>> +	    pref_nid = NUMA_NO_NODE, curr_cpu;
>> +	cpumask_var_t cpus;
>> +
>> +	WARN_ON_ONCE(work != &p->cache_work);
>> +
>> +	work->next = work;
>> +
>> +	if (p->flags & PF_EXITING)
>> +		return;
>> +
>> +	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
>> +		return;
>> +
>> +	curr_cpu = task_cpu(p);
>> +	cache_cpu = mm->mm_sched_cpu;
>> +#ifdef CONFIG_NUMA_BALANCING
>> +	if (static_branch_likely(&sched_numa_balancing))
>> +		pref_nid = p->numa_preferred_nid;
>> +#endif
>> +
>> +	scoped_guard (cpus_read_lock) {
>> +		get_scan_cpumasks(cpus, cache_cpu,
>> +				  pref_nid, curr_cpu);
>> +
> 
> IIUC, `get_scan_cpumasks` ORs together the preferred NUMA node, cache CPU's node,
> and current CPU's node. This could result in scanning multiple nodes, not preferring
> the NUMA preferred node.
> 

Yes, it is possible, please see comments below.

>> +		for_each_cpu(cpu, cpus) {
>> +			/* XXX sched_cluster_active */
>> +			struct sched_domain *sd = per_cpu(sd_llc, cpu);
>> +			unsigned long occ, m_occ = 0, a_occ = 0;
>> +			int m_cpu = -1, i;
>> +
>> +			if (!sd)
>> +				continue;
>> +
>> +			for_each_cpu(i, sched_domain_span(sd)) {
>> +				occ = fraction_mm_sched(cpu_rq(i),
>> +							per_cpu_ptr(mm->pcpu_sched, i));
>> +				a_occ += occ;
>> +				if (occ > m_occ) {
>> +					m_occ = occ;
>> +					m_cpu = i;
>> +				}
>> +			}
>> +
>> +			/*
>> +			 * Compare the accumulated occupancy of each LLC. The
>> +			 * reason for using accumulated occupancy rather than average
>> +			 * per CPU occupancy is that it works better in asymmetric LLC
>> +			 * scenarios.
>> +			 * For example, if there are 2 threads in a 4CPU LLC and 3
>> +			 * threads in an 8CPU LLC, it might be better to choose the one
>> +			 * with 3 threads. However, this would not be the case if the
>> +			 * occupancy is divided by the number of CPUs in an LLC (i.e.,
>> +			 * if average per CPU occupancy is used).
>> +			 * Besides, NUMA balancing fault statistics behave similarly:
>> +			 * the total number of faults per node is compared rather than
>> +			 * the average number of faults per CPU. This strategy is also
>> +			 * followed here.
>> +			 */
>> +			if (a_occ > m_a_occ) {
>> +				m_a_occ = a_occ;
>> +				m_a_cpu = m_cpu;
>> +			}
>> +
>> +			if (llc_id(cpu) == llc_id(mm->mm_sched_cpu))
>> +				curr_m_a_occ = a_occ;
>> +
>> +			cpumask_andnot(cpus, cpus, sched_domain_span(sd));
>> +		}
> 
> This means NUMA preference has no effect on the selection, except in the
> unlikely case of exactly equal occupancy across LLCs on different nodes
> (where iteration order determines the winner).
> 
> How does it handle when cache locality and memory locality conflict?
> Shouldn't numa preferred node get preference? Also scanning multiple
> nodes add overhead, so can restricting it to numa preferred node be
> better and scan others only when there is no numa preferred node?
> 

Basically, yes, you're right. Ideally, we should prioritize the NUMA
preferred node as the top priority. There's one case I find hard to
handle: the NUMA preferred node is per task rather than per process.
It's possible that different threads of the same process have different
preferred nodes; as a result, the process-wide preferred LLC could bounce
between different nodes, which might cause costly task migrations across
nodes. As a workaround, we tried to keep the scan CPU mask covering the
process's current preferred LLC to ensure the old preferred LLC is included
in the candidates. After all, we have a 2X threshold for switching the
preferred LLC.

thanks,
Chenyu

