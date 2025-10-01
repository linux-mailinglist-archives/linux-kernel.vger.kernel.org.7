Return-Path: <linux-kernel+bounces-838309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69403BAEEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 03:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB413C785D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 01:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A4023956E;
	Wed,  1 Oct 2025 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T63l1fwK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CEF199E89
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759281073; cv=fail; b=AhKwHaYV1ZeQBMTHxqeleN4GoHP+EMAfOcGsYbcb4YXl3BYoqG1xdOuUaB0ZiQ8+AF28u7VmqryloRBcQWRq6yQJ8E4OA10Lec4BF3HYzLycFrjYrTBZO5mVBSDrWB1MQuaOnvrreMODdpuU7rnFaJjCdhMH9LGWbBznXAyPWko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759281073; c=relaxed/simple;
	bh=zOcpSVRC8geRn9Ik3Q8r19r4zV1JEoaNSA84lHPqKQQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uEurVzaalP/7ngUJ53xKWbqqJBrn+uKOMkIrkRwjoInT7VTDQvmhDK/EmIkRTKP9PZNT33HG+G6yQUITeNw07IE+PRzYZDDOLVpgSpZT2qGZr3iFPlTt1e7sgk5NtlN4IHEQSgKMa4rRcmcl2ksCMQ6AdR85vN6WarRoHjj6x8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T63l1fwK; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759281070; x=1790817070;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zOcpSVRC8geRn9Ik3Q8r19r4zV1JEoaNSA84lHPqKQQ=;
  b=T63l1fwKCLJkVA83/16gq+e4oEICE6tQRz3JYmeazVrqyLgPe2ax4aEE
   Q3/ferXRdRKPRRS8fiiDNhh0+SgU6ttcDyNoY7lHvfRX12r6KvT3fxdiO
   6PfKZI2c2MRQ0vnMyng92TvOQnyB0RIlAd2Fjl72glCgwUJiif+Pftbe5
   ic42G/YBK283XHZr2TdM2mt7GEe0/YHT50OTyKzxOu41I7ElOrdGrraLv
   GXpe98xkMvS4BJeApg/Yv38o02ejMgFTTlRVdTR861Ggsc15D4qNGDWy4
   vsrEu4+/LfXYjTjRxaZwLVxIfQpCulTE2Vhw6GhtqBsZ/vKCwSqDHawtA
   Q==;
X-CSE-ConnectionGUID: fnRWesCCSeGF3DU8KWBVyA==
X-CSE-MsgGUID: 0Nu4i/mYSmatCfJAjjKBvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="72908879"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="72908879"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 18:11:08 -0700
X-CSE-ConnectionGUID: n/0NT+mERE+sCjNjzXPCaQ==
X-CSE-MsgGUID: 7K28q3XeTAqpqZTyPPEHIQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 18:11:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 18:11:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 18:11:08 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 18:11:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQa0OS5NzB48MAKkVPBIynDs0t8AgNbrwT1nhntJ/76Pw/KZn2jiBfI775s2JNkCZVdAC9VvOlgdDLoGKMTRePYW3OWIe8pameJqJvPW3/o6UNCXk6NlbEVixHzuKx1MM/7qcGxATERnnk4708uURHA33KV35Ddtn9hRJnfI+6iRYkqI8iOdtzKJFBf9fVW6gf7gXCzfGo+llpx6sv8lm0TebscdyoMptWandaU+BAWw/uVyQb2OGGpk8v5eErqYvSXs+OPj4afhKVVlTySSDtkTUUeKjal4TB5eCn3bsPuMj9BAWx/Tv9dhPidww713bgccx3UX7R/wR5hyGLIFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JilvTwwJ5sKfuJ3vyh043EP1HeJE4+Dgbctazzm7fUk=;
 b=rcMhx3fHF1QYmStPzyhB7pysfmpvyQqiJab6bJx/8XqhPqE8APdZ4hGFAjb7zN7yGy7JfZNSWi1+hqZqzfID9dO6aGQFvx/xgDmSx6V9jHtjl31mQTEQc7levI2Wh7telSDZFhDM8jMvbq5lGRkoTF1cUXeQrOUfazN+bz2s67CSWQghX843dkr9ndpLG+0vDSO4Kf/bB5NKLl3uX+q/H0xLBnB653rRSYaFuzLLstnb/vN08fD4SgSXs6lvmSDfzNCJ2tGTZ6eii/icGpPQ5cWm8HBvy5FJlvBFmtC/XcgMQCsVnellcNpKizaySxEx5uCOn34DfPnx+gjCNWb/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 BL1PR11MB6050.namprd11.prod.outlook.com (2603:10b6:208:392::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Wed, 1 Oct 2025 01:11:05 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 01:11:05 +0000
Message-ID: <10a7e801-6cb5-4f2f-b72b-5f6733054fe1@intel.com>
Date: Wed, 1 Oct 2025 09:10:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] sched: Create architecture specific sched domain
 distances
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Len
 Brown" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Zhao Liu" <zhao1.liu@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Arjan Van De Ven <arjan.van.de.ven@intel.com>
References: <cover.1758234869.git.tim.c.chen@linux.intel.com>
 <990005f249897c6ef2e7d998c68836eba604f346.1758234869.git.tim.c.chen@linux.intel.com>
 <6a650359-d106-453a-a5a3-24b3750a05d2@intel.com>
 <861e15234270eb3678390da2b0ddf3a7162d98dd.camel@linux.intel.com>
 <79db86a1-dc75-42ca-9cff-927539dc2104@intel.com>
 <6446b46bb8750deb28687b3e84d9b6062a35c86a.camel@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <6446b46bb8750deb28687b3e84d9b6062a35c86a.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::16) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|BL1PR11MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a957ee-a5a3-4c7e-27e7-08de00876530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bktqc0k2dEhVNnkrb29QSUpNRDBoTkZrSjU4aGdZaFZ4bW9pZEI4TmlnSnVT?=
 =?utf-8?B?N0xvU04xZmZuejQvTExpekVEN3NBUEVPVmdySmFyMGhyWkJWc21TTlVIZlZP?=
 =?utf-8?B?Q0tIRE03OFAyQ2JvUHh4WjFKUHN3THozb0ZPU09wQjlzbXhUV1Z6RHVNRHJW?=
 =?utf-8?B?VHVBLzBoYTl0dVo4YmV0Vm53bVQvY0NBR1Y2eEsvT25LOXMrSkcvbTR6Y3FH?=
 =?utf-8?B?Z0RXYkFHQlpZQUY1WjEzNlc0TzJiNW1PVCt4NXVic2tVbWtlbU82bEZpM1hq?=
 =?utf-8?B?dFpHbGJzN1RrM0FPSjR5S3RJZXJJaEFIZDZNZ1doVU5HbFhwVnQwZlV0aTVx?=
 =?utf-8?B?V3lHbEZaWlpKYlViYmxTWmxwNTQ2ZzhBbXd1TVZJaTdmS0NSNHFPNnM2N3lR?=
 =?utf-8?B?ZndBUUJuM0QrRlE5ejlDSWdBSktxVWRhUVVXVzVNek5QUzV0ZXp1MUJMZytv?=
 =?utf-8?B?ZHVaOFF1bEg3NGhDS09CZkhCbmZwaUgxY3kwd0w4S2lhWFB6ZnpYck92U21l?=
 =?utf-8?B?RzNpd3k2MFRTWUtOUHVSb0huRFovZ3FXb1ZQYmtiMkwzd21OMHkzaHJETjNj?=
 =?utf-8?B?ekZyZWNkU0Ewd1l6WVJndGdFbnpwNzhGV2doNjRmVjU0V1FHOCtWQ09aZ2pZ?=
 =?utf-8?B?NjNkd24vNTY4NHBzQjRhMUxBYVRCNnoxb3RmWmFpWjNNa0tSUkRLdk5zOHE3?=
 =?utf-8?B?ZE5KRzd0c1o4WnBhWXFxZnJVWDcvM1l0M3hDQnVsK2Q4YlhQSCtPeWxMTnl0?=
 =?utf-8?B?NlZ0clNGOFVLZDA1L1l6UjhWcDlqWW9KSHlIR2JQNCtYcGFDVlZSOEh4bFpw?=
 =?utf-8?B?MVIzZjJaVGhFT01YdHQ1RDU5WmhWekRZazhGTWFqR3VIemZ1cnpFTWtGdUVn?=
 =?utf-8?B?UzVRTjZWVkxiWGluM2tVYmZPZWZEU3R0bklyZlFHNUR0WXpzSlU1dUh1aGV3?=
 =?utf-8?B?U1MybEhRL3liUTgza2xOWitQdmZxbE1kaGZ4VEFxYkJwRjd2Ym9nVnFSTEV2?=
 =?utf-8?B?Z3lERVRacHdwZElqRVZtR1hFQVM0TytvK0pMMVowMytIMjQzbFJuam1TRXNv?=
 =?utf-8?B?VWwxT1hndERlY1k0emlOWkdjdmcxazI5bjhIb0FTWU5vRG9KZWU0ZGZvR1l3?=
 =?utf-8?B?QTQ5T1ZQVGJxUXBtby9JeW1GcTRMQVpVUThncnRhVHE0cmx3R3l5NlNVT3Rp?=
 =?utf-8?B?ZE9Zd1hSOHJ1Zkppc2NpeWxWOHFhVkttS0tXbVpIWXI5eHkwZXVIQm4wVmtU?=
 =?utf-8?B?cTNlMzN0M2N5U1psajRHQ3dwRWR4d01TMVBMaVJOd20wdEdUVlN5RkVNL29a?=
 =?utf-8?B?OFIwZldJeVE3UWZwU2c1Nnh5dk90bVJSZklRMEF3eXp3SW5KSDRHNFBHNWdt?=
 =?utf-8?B?b3pOL3lpZ3ZwOE90K2pxN0RQU3dNTmxCZU1Bb0RoTXM4bHBqS1ZwSGVXeXZz?=
 =?utf-8?B?WDVLQW9uVkdlMXpvalNTWERoUHlGU3FhZm02WkZnMWxDQkNxaURyQjlSUnRt?=
 =?utf-8?B?RTN3TnB5ZHhxK2tBcnJhUzl1dkh4TFlEV1NGQmd5ekRKUGovMndqNWJWckR6?=
 =?utf-8?B?RVpaZWJZQ3FOM2UyYWJRODVVdWJ4V1NsTUpCTjZmNERHbmZzTStPRW1LNW5u?=
 =?utf-8?B?KzdDenlnTVFML2pUYkU3OTFBSHRoRXVSc1pQSEFXSDBHMVFpd3FOZTNTek94?=
 =?utf-8?B?c01LTkhBT2tzWUkvdEVyWUhUM0hHNUR4SUZIQ2J1dTRMQWpaTk0xbGN6L2Nn?=
 =?utf-8?B?WS9zcVVXTXQ3blBsRkxEWTVaZ29maVJWYzNoVHl0cWNQNGZnNk92bGU2VTZy?=
 =?utf-8?B?NlQvQUltWWpML1EydGhDemYyOWZDeGxkYTRpd0I0T1dKVmN4bDd2NHpuYnFk?=
 =?utf-8?B?cnJ2UWd0WGo1a3FHckR0VmhiRWtqZGQwUGJPcVg5OWZ6U0FZcElaQzZLdlBp?=
 =?utf-8?Q?3k/MmeWoqm3d41cCbSizP1PR97XUGJXy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVJrMEZFcXQvRUJPUXlWZFJ2V1dmNHBXTDhuMm1pQjNDMGhKMlhZVkg4T0Iv?=
 =?utf-8?B?Lzc4dFFzUDFSQkpwTWNxNzJ5SllJbTlCejk0NVRraGhZTlk3V2hta05SNXll?=
 =?utf-8?B?S1RZMElmSXRQQnd1OUJPUWxLZUZlL0RqSndnQ1FDMWhVYU83a3RjeTBURGV3?=
 =?utf-8?B?OHZQYXAxUEZqcTVSZGpleHcxNk5ObEdPQ0ZWZkZJSmRmcStIK0VvZUphZkdr?=
 =?utf-8?B?a0tkeElvKzdBK1M0VGdqbTN5enQrRUhNWCsrUDdjYXZVcHJ3dHorcEZGV1Ry?=
 =?utf-8?B?NStaU3dUSHZ2YXBjSGtVcFZKRHJkbGpydUhGNVRUQ2VhUDB2dnh5bDF2dFlX?=
 =?utf-8?B?UFFjMkFxUXZsd04zSWhpejA3amt4dE5Fa2VqNjdPVENXVmc2a24xNzJBdXRD?=
 =?utf-8?B?eEJMbExLVm5BLy9YdkNZQ2xmTmtyV09UZW9oZTUwSStlNkxqN3F6ZWIzQk45?=
 =?utf-8?B?eTlJYk1yRVFJMm1SVFRweVZwMXVLR3FjNmhtZDBTajJzVnFoQ1RtVlYzSmF1?=
 =?utf-8?B?amVxWlgxbUxkaVhhR0EyUU9OQytUUXkwWEV1OGJOa1gyKysyaHBVOWdTaGFZ?=
 =?utf-8?B?UStTR2l3TnB6b21BRmRHWUM2OXNEaU0wSnVYM01QWjlTYkQ3anFOd3V6STA5?=
 =?utf-8?B?ZkxWV1ZuTk1HcFo0Y0Y3SXFmOXk1dWdrTG5lV0Jlb291dU4vWmgzdmp5eUpW?=
 =?utf-8?B?NFZZQ1RYUUpUT1BSQkZxTk9Cc25iRDhJZGN4SkFTejFMdDZvOUZqdnJjYU5o?=
 =?utf-8?B?YzZROGNPLzZ2aXhXM3JCNmlyWXpoTitkWVVsUlZxaHUxbVR6eHpPZkc4MFRt?=
 =?utf-8?B?amRpRXBzOFVPVlBRUm01QTVrQmZza1BCcHVKSnZISHVTMGFxQ0ZVWVVoS0JR?=
 =?utf-8?B?K01vcWhhZXYvemg1L0ZiZitkd0E5ZDVVRzY4NGxRTXVLWUhCaFhjdVI2SGg1?=
 =?utf-8?B?SEUrdFdoSjFsVmdHNk5CMHF6TGdmZ2pjVkZQdEN6dStQQUxNK0V0L2JDcXk5?=
 =?utf-8?B?MldpYmJJa2QvMkd5KzJXMFFSUWswcU9tcWVRRjRQOXhPNWVZekdxR21kZHNw?=
 =?utf-8?B?QkxqUTBlemtkUVVxdzRScThVQkorVWpETUxKdVZZNzQ0YUVoUFpSY3U1dXpV?=
 =?utf-8?B?Yjg2d05PYktJOE9YY1RVTklqWjd5M2x0bVBPZkxSYVhUMERpMVV1SVRLZmkw?=
 =?utf-8?B?VjJXR0xSRkNhcDdSN1JUek9xOC9NY0o3M2VDUmlab1JiS0cyallodWZmS2Rw?=
 =?utf-8?B?ME93dnliaFYxaVR1akZFTjdQRHAvbm1NY0h4dXpQK0pVajc0bnhzd1JaYmV1?=
 =?utf-8?B?QkxMZUwzd1M0S1ZicmhrUFo0dUErYk9DQ3YrdDV1bFpIVzNYNU83V1ZpSGZU?=
 =?utf-8?B?VmpwR1JHdElpbnNYeDhoelJpcEwxMlZ3U085K1FZaDlwbldWK1h2a0J2aUxQ?=
 =?utf-8?B?MlVqbzBQVDlHUWppd1dST01HOWJDUUI1d1BaNjV5L29ONVh6d05HVDdxYzBq?=
 =?utf-8?B?WVZYWXpGazJNV2xxRTEvQWdFWExhY2VZRHk1T3d2VEt5ZFY3bHp1M0pnNGs5?=
 =?utf-8?B?b0IzZHFrWkpjcmVFaG9tMFFrSE9hcUFlOW9mS1p6MnNWTDN0UzdUQmc0YlRV?=
 =?utf-8?B?em0rRDFTUU5CWEZvMUF2SlptUVdDV3lzSWRCL0crTmg2SVkwN3hVNWlUbnNm?=
 =?utf-8?B?MWNFMzV3Znp3bjV2clliM0FWS1FnSWphRENGZGRDNXI0NjRUMnNhN3RocnNF?=
 =?utf-8?B?UVdjV2I3TmJqOWVEV0x4ZTN3eWhQbTdrZ3VibUxSQ2Q5bWZvb3gxL2Q0OEtW?=
 =?utf-8?B?VjVhakVORUVUUXlGL1kwN3Z0dWl5UGlzUFQxOEIxUHlCR2RvNUdPOGtWZk5Z?=
 =?utf-8?B?U3VINjhxNGlsVnYyczRlc3Jid2dGdlN6QlVaM2hLQUhIOGtaNDhmblFwbXVp?=
 =?utf-8?B?ZVY3K0F2WmhXN0FKUldtQ2dSdzNWL2xlZndJZUNZNzNOaUM3RjQzc0w0Z1k1?=
 =?utf-8?B?dVdSaGQrL0wwUUJOMnlnSlRBcitTWmpmVkdXOUNmVmZTWkV5Vmx5NVRQcU9G?=
 =?utf-8?B?aGttSmpDNlNaL3BSc3J2UWlsSk1GdzFtWmpLR25pUDNFZ2dQMFV5Ylo0R2ps?=
 =?utf-8?Q?wahEwE5dUBnMdxbSfuY+ekDJn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a957ee-a5a3-4c7e-27e7-08de00876530
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 01:11:05.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84bklF2PoD/yVlYVIRsKZj0gPbILr4hWxJHN6U3UwGLNveZtRWB5tE8IvmpvVUcpNCg+uMN0ycYk5Av+0MgD/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6050
X-OriginatorOrg: intel.com

On 10/1/2025 1:30 AM, Tim Chen wrote:
> On Tue, 2025-09-30 at 10:28 +0800, Chen, Yu C wrote:
>> On 9/30/2025 6:18 AM, Tim Chen wrote:
>>> On Sat, 2025-09-27 at 20:34 +0800, Chen, Yu C wrote:
>>>>
> 
> [snip]
> 
>>>>
>>>> If our goal is to figure out whether the arch_sched_node_distance()
>>>> has been overridden, how about the following alias?
>>>>
>>>> int __weak arch_sched_node_distance(int from, int to)
>>>> {
>>>> 	return __node_distance(from, to);
>>>> }
>>>> int arch_sched_node_distance_original(int from, int to) __weak
>>>> __alias(arch_sched_node_distance);
>>>>
>>>> static bool arch_sched_node_distance_is_overridden(void)
>>>> {
>>>> 	return arch_sched_node_distance != arch_sched_node_distance_original;
>>>> }
>>>>
>>>> so arch_sched_node_distance_is_overridden() can replace
>>>> modified_sched_node_distance()
>>>>
>>>
>>> I think that the alias version will still point to the replaced function and not
>>> the originally defined one.
>>>
>>> How about not using __weak and just explicitly define arch_sched_node_distance
>>> as a function pointer.  Change the code like below.
>>>
>>
>> The arch_sched_node_distance_original is defined as __weak, so it
>> should point to the old function even if the function has been
>> overridden. I did a test on a X86 VM and it seems to be so.
>> But using the arch_sched_node_distance as a function point
>> should also be OK.
>>
> 
> How about changing the code as follow. I think this change is cleaner.
> I tested it in my VM and works for detecting sched distance substitution.
> Thanks.
> 

Yes, the following change looks good to me.

Thanks,
Chenyu> Tim
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index f25e4402c63e..3dc941258df3 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1897,31 +1897,17 @@ static void init_numa_topology_type(int offline_node)
>    * A NUMA level is created for each unique
>    * arch_sched_node_distance.
>    */
> -static bool __modified_sched_node_dist = true;
> -
> -int __weak arch_sched_node_distance(int from, int to)
> +static int numa_node_dist(int i, int j)
>   {
> -	if (__modified_sched_node_dist)
> -		__modified_sched_node_dist = false;
> -
> -	return node_distance(from, to);
> +	return node_distance(i, j);
>   }
>   
> -static bool modified_sched_node_distance(void)
> -{
> -	/*
> -	 * Call arch_sched_node_distance()
> -	 * to determine if arch_sched_node_distance
> -	 * has been modified from node_distance()
> -	 * to arch specific distance.
> -	 */
> -	arch_sched_node_distance(0, 0);
> -	return __modified_sched_node_dist;
> -}
> +int arch_sched_node_distance(int from, int to)
> +			     __weak __alias(numa_node_dist);
>   
> -static int numa_node_dist(int i, int j)
> +static bool modified_sched_node_distance(void)
>   {
> -	return node_distance(i, j);
> +	return numa_node_dist != arch_sched_node_distance;
>   }
>   
>   static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
> 

