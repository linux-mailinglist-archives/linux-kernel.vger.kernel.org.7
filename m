Return-Path: <linux-kernel+bounces-866302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF24BFF6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090311A015A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F090278754;
	Thu, 23 Oct 2025 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kP+g0snb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0851D6194
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202569; cv=fail; b=jLMLDTzOzUgO0TbzCCS/7KF9SkkO/Afyv6R2YgeKiMYscbFkprQlvMXIgNx7KbO/5aB5auenj5q/0d8FwaMBUK+FGxM45W3Q4JrrySpzKOB5Do9t7fUg886nsOeqdbyKgmCiuA/8NTLvxYuCyi4mTIgdOp5Qyqho7cqxOGKAyl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202569; c=relaxed/simple;
	bh=G8ucpyhj2AWIPgDPFr0yEiemOMdeW3XLVYsT/VcUADM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HGdx9IJyQVw8i0gU8g4A4Jcqkd1+NIcD9hKjXg8rMheoKPn3qybhfqhyvZIPhQyNR+hQm3NosdWxcQdAdbt2ZFNRVUQjpQ2VJVOr+Ikn8tYm4/i3duC+40nqPg03ilnbnuMve3EcCmPUuWzJB9bWhGX2zdMTrvnUK01LQ7BooUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kP+g0snb; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761202567; x=1792738567;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G8ucpyhj2AWIPgDPFr0yEiemOMdeW3XLVYsT/VcUADM=;
  b=kP+g0snbS4jF9fy3XPOTKijWEaQwhAQGFf6aarykpHCUVt6DlcUjB4bv
   gmnW9JMfEd/SqInLgWFyFeblWLuQEhtJ4h7pzkvZmtrfHyUmikLXLnqa8
   HiBEJwv1LpkEh8LqNzDg+UMeMs6oKm3t0zLAlO9vj6pXEX1rShMfbOV1A
   LrarEOd80ZJSZMjBz8cucyu7+gYR7CntODmChiZ3DtYw6Z6jqor7CSwtO
   FoACuJ9yA0b5GTEdo9WpKnV1YvOIPmCUP/symxmY0sItHAyMOgvoPv59T
   BPCt/8/uWpyHBK4Y4ouDH9cLi/m+PYZzWDkX0hGp6qVBgYBK6PZo8DJaJ
   g==;
X-CSE-ConnectionGUID: egTaE7yuRxesC1stJSnyLA==
X-CSE-MsgGUID: DgYZsHZyQYqMWNsOYRxHDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74708384"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="74708384"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:56:06 -0700
X-CSE-ConnectionGUID: XlpqhUoFQ6qZ9LN60YI9mw==
X-CSE-MsgGUID: c/thkgPuR/emZFU+I1LnSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="221269703"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:56:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 23:56:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 23:56:05 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 23:56:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVSmRMmGMPXle7w/CoIK/98r3I7q448bqdXPkLTCHmq7FnFvWXWQSWvzTXXjsZi+SRcfr2z54O33e7pH/KeiTsr5Oaoh/A10D0K+ikiaSQgV5g3MFPAoRtgfCxdvVmdXy2RXUHHDh20Pe9KqJfqx+WQNOSr4SfeuSnEGmTGCaP3OdTScor4I/WznR6WLpwgapbr88imV48kEa/gyYXuEpCtzg4NJ46hmrOrL+HIhYfRCz5Tn+rKLFdWgwGUABFqjFivQ7QWfhGWAcn6QpHEqNAySKNMClG6HZM+GVrCBCAJS4k2ZBmBmDz/tE8Cdhe/infs+2zAn6HtvLYpNWJoLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktj1jm/sOJOJ7CilzJHifz/FwKscS/zxDAVtaUAba7E=;
 b=t0NQsgalQI/3CEM5URLwBj2qEk8WYMuCQl9IR/4pJzGYYiRpVUkTEhX+LpI5nl2OQoQJodYcjnrotmf406LUZC/iLI6XDZ2hVeItDikyEVYvVIwRBBIWXk0aj2bKqdf6zwG80WjYDaB+xV2BhfTvwaIRcf7KjnsFwTtFO+5jHkbnM5O9/i0WfSLIdf2x039H05YgV3qLFxhkZEbtlswyDvaNy8++w67n1+oq69Z+vZTVFqbJkp2MQSnCKf1gqXyxfDMcQtX/SzU0gwX0lcYaHHSflNmx/+RRCN3iW9EKhRCbnVuX6ESh57G0g+RulEGR4t5eEzlDZyRQeGriiaurgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Thu, 23 Oct 2025 06:56:03 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:56:03 +0000
Message-ID: <c047e50b-13f4-4234-8590-0f82314bcb8f@intel.com>
Date: Thu, 23 Oct 2025 14:55:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] sched/fair: Disable cache aware scheduling for
 processes with high thread counts
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
 <a098a60d9b4fc8ccea3392096f8bb0cf03af070b.1760206683.git.tim.c.chen@linux.intel.com>
 <1a63ee2a-9c1e-4aa3-adb0-012e0eae5dcf@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <1a63ee2a-9c1e-4aa3-adb0-012e0eae5dcf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::23) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MN6PR11MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: cf474431-01df-4d4e-e038-08de12013b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cS9FcW5yaTRoR3ZTclNncndibGVHQkgzNG9vK3FYb0V6SmhIRVFpcXkxUm8y?=
 =?utf-8?B?T3dvM09pUE45cnZGWDdpQWtlZEdHbnJxZlFnL0NvY1RVQ1RxSUl6YUdRUjNa?=
 =?utf-8?B?R283dW81YmVhYVZZMXFQN2kyK0VuTmNEenMxRjlGdXNFMFdmVlZkZE9sVlk0?=
 =?utf-8?B?YWhsK00wTWNzcWEyeExDZVB5ZHlZV2QwcEtISE5nMHA2cTRRMVpkZ08xUkh3?=
 =?utf-8?B?SGxTVllMRlpOTFc3RGFob2N2N3NoNHhrTFlpREhSOWVtWmZ0clh4bFY1Tjc5?=
 =?utf-8?B?STZOaVZvcnd6TGEzTlMwN0IvTzhXTE4xT2ZpN2IvcFFwUERLcjdnUTR3RnVZ?=
 =?utf-8?B?NG9XMUNHNTlEeWRrSlpHRTM1NTd6OWY0cEhxZFQ0d2o3eTJhYUpKS2llU09t?=
 =?utf-8?B?SUV5S1VlendNQ3FYY0llYVA0bDFycjd6cy9kL1N0Tmh6MTZTMGkzRVQ4YWdw?=
 =?utf-8?B?RnJRV1pHZjM2NzEvamxBdFhGS3lEMGR2WGIwOWdlQXQ3MWc0VHh1TGx1bXVM?=
 =?utf-8?B?Mklwd0ZxRnZUSUVoY0dycjFSaVh5eE1GaVBtUEdKL1JQcDJIUGZRTHNoNFZ2?=
 =?utf-8?B?M0FYRHg3SEsxbUozdjlaK3ViMkRkekRUL1JWbTgrOXMrb1hCcHNsS1FBTHdW?=
 =?utf-8?B?WE1tV3ZGekxmQXNwRm5lY2cvdExFNnRRZFVmOVAxQ1prQ0JzR2U4REN0UmZN?=
 =?utf-8?B?ZDFuU0VXMXNPNi83WEFaR2RDc0dCM0dBZkxCRE1VdVpuZ3VabFl0TVU0YlRr?=
 =?utf-8?B?VEdFYklZL1Jsbm9GLzZ5aUZlY0RSTU43c0toSEsveU9DQktTZEpEeEdiZFVC?=
 =?utf-8?B?K2htUEFRVGpYc2hEV09JOGtwOC9Oc1FkVWZIZ3ZvR3NVQ1B0eFpSZGlQNncz?=
 =?utf-8?B?V1dKRmlxa2sxRkF0aXFvd3pNalh6bG9Xc29XVTFtZHd4aHdvM3NXaGFYbklh?=
 =?utf-8?B?eEErYml1M0pxcE5jUWQxRkd2Q0NOZ1JaMm0wL1RxcW93aXA0WnJtSnFIS3VY?=
 =?utf-8?B?V1UzVmN6SERMMEZzSU5QK3NidlNOcTEzbkJYUkU3RUtDazYvUXRMVklYTG8x?=
 =?utf-8?B?RXlRYkNUSy9HdFdoY3dWUnNnSnpOS0VKRUE2R2hhaUxzWFNuZld3NVIrRVY2?=
 =?utf-8?B?OVZKSlZIWWZuTDM3d3JxUkVnb2dzQW9VTVQ4N2UrVXFiU2RRRG9zUG1QUU01?=
 =?utf-8?B?Q2kxSHVTdGJQOE5BN0JReGE2NEJ6MXliZ0h3WWRvWW42UDlSK3RjNnBlekVE?=
 =?utf-8?B?eEFrMG1KVzhRdWVhZk5XTjFjczIybFlxYWFzejdzUk5Dd3hEc2l5N05VQW8y?=
 =?utf-8?B?Y3YvOHllbzhydUJ0dnFhSi8zWTlZZ3VJcGRrbkFKZnJkaW40NVFxWEJXeU9j?=
 =?utf-8?B?emM3dC92K1R2aEZRSU5NcnErMm9pcGxmcEpxaU1NNUxkZkdoeEZpWTZtc1Rz?=
 =?utf-8?B?SGprN0ZuaUYzVXY0dWptSWdtejNGZHdZUmI4VzBodW5lMHZaM3l0MlYwK1N0?=
 =?utf-8?B?anBnMTNlekRMK1dQeEZpaXNnZEtZbVI3M08xR3VnR2NUWWRIaGJpdDRxa2RP?=
 =?utf-8?B?UGgxbmlSOURrbVZtTDZtUHp6ZW1BUTZKdjg4YlpuMmx1dzZwWVE2NXlKamRJ?=
 =?utf-8?B?SWY1ZkN1S0hHRWlUbWJjZ1VZZE1QWml6eVdWRUlQSUZKZy9Mck8yc0dmOHlm?=
 =?utf-8?B?ZnVqSysrdTRidUZhc3pOeUlkcGtPSFdHYnlWaWt3aEFvcURVaEVzbG16TnM0?=
 =?utf-8?B?NmVmQkhLbWN2ZmdrYkRtUlkyYTFZS0FncGRNZzVSTTZQTklnWnQ0NE9nUW1s?=
 =?utf-8?B?VUUvNjg3NTRWcExmTEhxYmZidWt1MTl3L3oxb082dEFoTWx2b2owQitjc0pt?=
 =?utf-8?B?U2h0NUZ3QmxDZnVGeVZxZzRRM21qWWp6QXV4cXF4dlFsaGRsMWxBdUkvblZk?=
 =?utf-8?B?VHIrMTZ2c3MyR2F2bDdpV1Z0TzB0NGpvOUU0S0xKQ0toWGVUM0srZk1MNHNu?=
 =?utf-8?B?cjcwN01lZ0p3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ny9rK0NoYlo5QlRxY0poZHp4dWFMak9sSXk3U2Z6ZVlCcFVpamF4OE1yYTBt?=
 =?utf-8?B?ditTaC8rdHhJUEg5Wm5rZU9wWlk1VmhLdy8rNGE5QmRKOWM2S1o1cDZXOFFj?=
 =?utf-8?B?MTA3UmZqNXFrdUdYbmdjSEplbVRmTlhpcTVrci9MYWVJT0hjcERxWGZDOFZU?=
 =?utf-8?B?eTJPWnB4b0JZNjRjOUFXeUVpVlVRZDgxbWYvM24rUEtpdjBoeW5zaVRPUXpE?=
 =?utf-8?B?TWZMdHNYelRoMVQzY2VwVFNCYkltWjJpcDg3MFpWQk90MWJQTUwwdzdMeFRO?=
 =?utf-8?B?VkFrekVobzRxMHA0OTFjblN3ODF4NDBVd0J0ZE10WTFXS3JsZzZTcFQ1N0Zr?=
 =?utf-8?B?L0V5WTdRVzdEN284YXlYS3NhSFg3ME55VGhuMm0vUWs5TFB3ZFlTU1hzekND?=
 =?utf-8?B?bnVDTHRsR3RoaUQzTTE4WldLMlJnL3F0T3g5cU1rdzFqV2FVcWZ2cDk5Y282?=
 =?utf-8?B?bkV2bXZuNEtkZnNUa3Zici9XU0hoVG5ERW92RkNWQ1ZVbmxDNFdRQ0JuRXVI?=
 =?utf-8?B?U2QxRzB3STR6Y2VycjZSTzhZM2lsSjZiei9JN3VOcE1lbjZBd0gyR3JoS0dL?=
 =?utf-8?B?TlBkL09oVk54clJFSlYzYU1aYnQ4VTNvTEd2T1lCMGdNTlpNZXNsYmFmZmtX?=
 =?utf-8?B?RW5ObVIxQmpkZ1kyUmd0YXdtbmxIWmtacVNHMWRXUk94Mm1hV2hkb05aZ0M4?=
 =?utf-8?B?YTEyaTNXSFFNV0szd0JjSHVFODJ2Nk83WDl3S05jNlBZQ0h5UGFGeXBOYU1L?=
 =?utf-8?B?aTJaREJMbHBQTEVTdS9iZWJDMFdkREZYUU1RdC9wTXlUdEhVQ3NXQlJlV1Uy?=
 =?utf-8?B?RnpXVjNjK3Fja01DYkdzRmpiMVZvdmZsYkdpZXJzR1BmbkdkMUZkV3ZyOVRx?=
 =?utf-8?B?YUZCSjZqd3FqWlBTVmdMdzdWZTBmYXQ3T1hGc25Zb1Q3OE05ODFnZnNrYWVa?=
 =?utf-8?B?NU13TXVCRnVDRW5PRDA5Y3F1Z3MySFFpdmF4RkRXQTQrdnJZZGlxcU03aVZz?=
 =?utf-8?B?TUNnMnZweUVnaHlvcEpmejZxNU12ZnlUeVFmeWRJY1VvZjMrRndRZDZtU01T?=
 =?utf-8?B?anRnaFcwY2UwRVc1dDUyUzRaSG1lUHcvOGdheE5SbXpkUWV0blFPWVRCNlFn?=
 =?utf-8?B?ZUtYTHlKSU4yMENwaWtKRXQ2ZWNnZ3VmR1pyT1FoRHgrVXpKOWlUaTlPSlpn?=
 =?utf-8?B?RWw4Yk90YUVBWHlyUE1zMU9SSk82b0FOL05iN28zbjh3aVRTWXNSNnMwVkVn?=
 =?utf-8?B?aTdWMXphd3R6OUwrcXZPSTRmMzZOTVUwYW96SjBmTk9aUGFGdHBoNFlFT2lo?=
 =?utf-8?B?VlEvSGZUUTVFZ0h1YkJubFMvZjJta1dSbWpOQTBZY01iSW9YNlNwblo5dnBS?=
 =?utf-8?B?Q3VpZzZJalpXT25GdlpTVFdMdVJaU1NQU3crUHYzYXJpdkZKbDBpS3hiRmV5?=
 =?utf-8?B?QkZUbGhOZnZibm5FNUR6UEhmNUVGL2NZMGVzM3hjdk10Z0J5RUZjeG9ZbFZi?=
 =?utf-8?B?ZjRjZkZ3SnF0VXlGNmI4UmZFcW1vOWNIdlRSQXpTWVBnQkJpaFhLZXlNNzIx?=
 =?utf-8?B?dHk4L2Y4SGlrSmZNOTJOZ0ZNU3VGREh4bVJzUHBEOHNXSWxGaFBUTXFCbmwy?=
 =?utf-8?B?aVM1bmhzcEkvaTd4Y2FWMDArRmIzaUVFa0RLTHl4ekFidElISSswVVRaNXBx?=
 =?utf-8?B?M2JYazRPVkNJeCtpUElSQmJxd0dXRGxXOHVvMXRlZGZSd252QW9BU2l0dFVJ?=
 =?utf-8?B?UTJ3YktGQUZkNFlzRVR4Q08raWRlQWxzMVdZcmZFOWVoN0pVaWUwUUZxQTNw?=
 =?utf-8?B?dVVmblAweWtNSkMvRVJhYk95Y25icEZkMFpieHVGekVNR2hoVXB0czJ1QUI2?=
 =?utf-8?B?TzM2eTlwVEVubTl2TGtkclk3VlNlMjBCSXZJS09WWGJBS0JheFE5RXdQd21m?=
 =?utf-8?B?bXBzVE90aDdRKytjZWNLaWk2c0JnWDFJWXZqVkJnS2FwS1FxbmZOTFA2UVBI?=
 =?utf-8?B?amkwWWhibTFLOFdHak9aTmZWYmcyYWpzV0tMb3h6czFCYlFiVUNKck0vV0Q4?=
 =?utf-8?B?OXBSQW1YVGZQTmRXYW9qdjJkSlJtbHB1RkdibDVNZ3NzRUlMZ2l0WmxWZTNP?=
 =?utf-8?Q?Jl3khGUiGtEMk0zihMUhgHlvo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf474431-01df-4d4e-e038-08de12013b3e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:56:03.4167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnikEnV2qVTKozggWHKA5h6ucr4PLNXPqq+uU3Ms5fqK6l3yn9mlQunQJ4dUzpiwnkpnJV+jysD0+uxR2gYS7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com

On 10/23/2025 1:21 AM, Madadi Vineeth Reddy wrote:
> On 11/10/25 23:54, Tim Chen wrote:
>> From: Chen Yu <yu.c.chen@intel.com>
>>
>> If the number of active threads within the process
>> exceeds the number of Cores(divided by SMTs number)
>> in the LLC, do not enable cache-aware scheduling.
>> This is because there is a risk of cache contention
>> within the preferred LLC when too many threads are
>> present.
>>
>> Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>> ---
>>   kernel/sched/fair.c | 27 +++++++++++++++++++++++++--
>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 79d109f8a09f..6b8eace79eee 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1240,6 +1240,18 @@ static inline int pref_llc_idx(struct task_struct *p)
>>   	return llc_idx(p->preferred_llc);
>>   }
>>   
>> +static bool exceed_llc_nr(struct mm_struct *mm, int cpu)
>> +{
>> +	int smt_nr = 1;
>> +
>> +#ifdef CONFIG_SCHED_SMT
>> +	if (sched_smt_active())
>> +		smt_nr = cpumask_weight(cpu_smt_mask(cpu));
>> +#endif
>> +
>> +	return ((mm->nr_running_avg * smt_nr) > per_cpu(sd_llc_size, cpu));
> 
> In Power10 and Power11 that has SMT8 and LLC size of 4, this would disable
> cache aware scheduling even for one thread.
> 

Using smt_nr was mainly due to concerns about introducing regressions
on Power, as discussed in v3
https://lore.kernel.org/all/8f6c7c69-b6b3-4c82-8db3-96757f09245f@linux.ibm.com/
and
https://lore.kernel.org/all/ddb9d558-d114-41db-9d4b-296fc2ecdbb4@linux.ibm.com/

It seems that aggregating tasks on an LLC with many SMT
threads/smaller LLC size would pose a risk of cache
contention. Additionally, with patch [19/19], users can tune
/sys/kernel/debug/sched/llc_aggr_tolerance to adjust the threshold:

return ((mm->nr_running_avg * smt_nr) > (scale * per_cpu(sd_llc_size, 
cpu)));

> Also, llc_overload_pct already ensures the load on the  preferred LLC doesn't
> exceed certain capacity. Why is this exceed_llc_nr() check needed? Won't the
> existing overload_pct naturally prevent excessive task aggregation by blocking
> migrations when the destination LLC reaches ~50% utilization?
> 

Using exceed_llc_nr() was because some short-duration tasks could
  generate low utilization but still cause cache contention (for
some reason, the util_avg cannot track that properly), such as
schbench. Therefore, we inhibit task aggregation for a large number
of active threads.


thanks,
Chenyu

