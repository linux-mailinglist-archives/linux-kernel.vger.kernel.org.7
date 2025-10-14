Return-Path: <linux-kernel+bounces-852534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EC7BD93B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C7E4221FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687DC3126C1;
	Tue, 14 Oct 2025 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1qujiP3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14427311C20
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443654; cv=fail; b=GKyH5J+/RInXeuAOJ5qBT6IValyeek+gij8UoV9XrybBsQF6oenx2Xyf1Inrg2HCoYgt/Ahbu4eTUecW8kgWzSLCjDzvGC5yGMMpeg7T9X38CiaHlr+lo6VZKAtK0CIQz0ddbFMeDbvbU9SWunqvk//XufmTpo8Hz7WKY7XPXS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443654; c=relaxed/simple;
	bh=Kb61WDPjUvQuJWCTP0XAa5cxplJT8ATayQDSY0IiDKI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nJTvzmvhRNG3wO5SvHohb5St+7zZtTqgtKpTXq6tsVw34iQ7vgZQ7UVAFpEBuzM9DYBuJajeBbUY60yCehWNlCGV8lDuSkP03wd6o7OcA1d7mO4xLs1EJIIYxRlWfGsAoF2e9AH97xBiWhu2RAa7a48w1omPcRnazPmh9konZUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1qujiP3; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760443651; x=1791979651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kb61WDPjUvQuJWCTP0XAa5cxplJT8ATayQDSY0IiDKI=;
  b=i1qujiP3K/PmxHttAVEx7kp3kF2MQrHxIph2Di8kMzwnQRLsCAoyyaiC
   MvtVg32ztGnzVlHRK8jOGxD10a6poHQdTV0JFJ3ywMklYFhv8CedqGmvm
   Vc7SaKeU8LO9aozpcQomk3kLizohwzH+WqmlsxKF9S+PN/OvmhtA0jlu0
   qXt8x3GzY1KqR4Tzgn57Izwdkic6hQMC5De7GejqIBxsQBPIDwfKwRBDR
   BIeAPzx2WOmjfrIsXM2LygioZoSm+YJBOwL6GNnvVJRkdbm/Hp8nyN4OF
   DnxEmrk2bK8IsiKxVDqalNKfeEKD0fHtqJOYBU/jLTVnRdZVPaxyeqHcv
   w==;
X-CSE-ConnectionGUID: 465+0QxqRBaNHJ8dWDekMg==
X-CSE-MsgGUID: 9fz7hlWxRPqqnm2DKOlNjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62696695"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="62696695"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 05:07:29 -0700
X-CSE-ConnectionGUID: eqTPZNMOT/GB1xzVZLJ+Wg==
X-CSE-MsgGUID: XFccN3LeQm6OV6eD9pGtkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="187166783"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 05:07:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 05:07:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 05:07:27 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 05:07:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDrbnbf1n8wbshF0bhSfBkz1ENYMIF8DXRPtA6MfaQ5pMg0BCMysmhyJkfOoC7HIT1jI4PZFAZ6mpWeqI+bmDclXC7lHcfAQg4Rg0g1XL9E/iVF+880aQHh9cPnJtgthn4+lzuGcbODP3IAKffK+bwJAt2y5F3z3FVzLtI7tNzIPvK8QbgaORwAemSRX1Tw2c8BlkLWzXFwcyUHok8PDjkJofKjPWnhN4V2wTs9OqEepzftPI2rWJH3A6GBEKtIl1vBxm72osNyZYFkwu2FXNxyYC9QceNaVpxLOUqLQxWnK8dWV7Y2d2twX8lR+Mv5qjKQ6SngXRyXqOMT9z7Sj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIMB4wgESG7VMUroohE6QNO/sppsRtBPOpHWm9NgUkE=;
 b=RkBfi1ZdCNdRO7CybTEOX7NnWuTA5PDyc6D03Hce2Cn+XzR0PUg3zyoRBDMdyu4nXY4dmbeyeltBIQC7lazw+yApYkFcO3RC8LKaX1MxfbXQYh+rs2kGBGICfySY2niDjjo2M2wfyoeG7rrhqerrSBo/Sr/ezYCK5Twbqj7Jd1PLtFw5oFMYyT6wqn0fPMfjfvBIflhFIUf5HB5x4x7/b25smAjZGTjAY8RFK/CakE+H2ekesMgzA52wcSmgFkasFjjz8k9czIF9BM6KG7wkgmwPC/snfQgYACQkElz9Kh1pdBDyLeYlsyhnk7eRAMbMqWgjnsn2EyikH6dHKPfJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH3PPF4E874A00C.namprd11.prod.outlook.com (2603:10b6:518:1::d1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 12:07:24 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 12:07:24 +0000
Message-ID: <f4a95e4b-93f6-4b36-b077-58d1c05bdfa2@intel.com>
Date: Tue, 14 Oct 2025 20:07:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] sched/fair: Only update stats for allowed CPUs
 when looking for dst group
To: Adam Li <adamli@os.amperecomputing.com>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <cl@linux.com>,
	<linux-kernel@vger.kernel.org>, <patches@amperecomputing.com>,
	<shkaushik@amperecomputing.com>, <mingo@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
References: <20251011064322.8500-1-adamli@os.amperecomputing.com>
 <90e7343e-7741-45d8-b076-d3852d1870fb@intel.com>
 <d6b78d12-298d-4316-91f4-bf7d3d7d5776@os.amperecomputing.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <d6b78d12-298d-4316-91f4-bf7d3d7d5776@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0088.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::28) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH3PPF4E874A00C:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8aecc1-82a4-454c-0d3c-08de0b1a3c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXU4aUdCLzNCYmtIdlFiOG40R1E3Qm95TU01R0U0eVdqKzBTcGR3Wm5iM3g0?=
 =?utf-8?B?V1FVOVFvYitHMk5YeE9EeDFZcURxTkhKVGpvWTVFUERiL1RTa1NYODJrUVFr?=
 =?utf-8?B?cXdFdTVZdUpIV0RVU2t4TXFuMFpuZmt0OEVkbDhqN3hCWEl0djR1bzRicU4v?=
 =?utf-8?B?OXJxTjlqWnNQYmNZNGRKV0JFZVNrSDlmeS93T2RSNDRXK056QS9BSHBncCsx?=
 =?utf-8?B?bVU5ZDdWeXViNHhjYWptNzQ2SGFYMi9HMFVmSjZIK1VoamRnU0UvSGxjZktq?=
 =?utf-8?B?WjQzOUpFdTU3MUE3VmhQWUkxYmlwRXVuTlplcUtKWGRVbmkweHg2TmMwczls?=
 =?utf-8?B?VXR6UzFRdHNmelV3SnFhekdPVFZ2N2F4UFlna1ltd3FoMXpoa0VsSExOMENP?=
 =?utf-8?B?dmVONy9GRExmQUFBbzNUdnVqYTlPYnZVZkMxem9jWVpLQ1JyOWhJYUliUGFH?=
 =?utf-8?B?dmMrRmZ2Y09nTmhvMlhFOXBLZ05vS1RBU0ZXWDI4TzNkTmNBdHNqTkxqRDF4?=
 =?utf-8?B?ZFArSmU0ampDSUZIZFNWVDVSMHVXbkdsRUs3SUU1akNKeXJmbmVnT2FDMEly?=
 =?utf-8?B?cnR3V3Nldnh1R3FzOVc0cmFvUlFZbXRyRWRCZnJLYk5hU1JyNHBacDY0QlY1?=
 =?utf-8?B?WlkzQUFFMzE1N2hVM3g1c3JmUmtDWUlGemhSUGJEeG82c0RpNkpuRnRwOVJs?=
 =?utf-8?B?R2hqM2VzQkRETkUzTk1HU2pFWXdTL0plbEdGZ2tOV1ZsTkpIeGpJYTY0cFpu?=
 =?utf-8?B?MC9pcFJIamxNVWorZ2NzNFNVaWE2c01nQ2JUR2Mwdk5hbGJzdlg3dGRvQXB5?=
 =?utf-8?B?OFVDdEdBVlluMUVhbnNrcHcxRXpidEMxajhabnRwQW9mcDVsYXNDUGd1eHRq?=
 =?utf-8?B?V1AxRFY1eFRveDZza0Nna3JBdll2M2s0RUNXSFdZeldiOFhFaHFQOSsrK0lR?=
 =?utf-8?B?ZEFDZmkxZ2RHcStkb0EzYzR5QXYwQTJvaGJWM3RTdkV3Zlo2UjJmU2hzMmQr?=
 =?utf-8?B?Ky9KeXdOb2dLTit6ZjNoRnR0M09mMVp4SmlRWXZwZU5LYVhsbXVHQlkrdkxw?=
 =?utf-8?B?dnNtS3BqMFNlNGJPQUtzclc2WXdzWUZHSUdmU1BKUWQ2dGdrcDExRTg4T2pI?=
 =?utf-8?B?SzZWVjdvaGFGcUFFZ3BOSDhUNGk1K1psUHVsZ0Z0cnQvUDQ5REFDcWwrUzlp?=
 =?utf-8?B?eUJVZzQyekJVeXhQMks1K25TeEdySHZReitpdUVHbUUrL2N6SUk4NGdPalV2?=
 =?utf-8?B?VEV6aGVIeWJoSmVWNU56TGpXaU9yTi9XOEowbzBZN3A0c0tId05GbHkvdldl?=
 =?utf-8?B?ZkRLSEQycWUzUjlzYngrL2RweEF2ZXIwYko1UnVVc2IzTkdLZEw2Tk9KdDQy?=
 =?utf-8?B?V1N5ME9YbHV1RjhTWEF5bTYzcFpWSnkwVGtpdEV0aWthREF1cWQyR2VYeGJX?=
 =?utf-8?B?NnZrOGw3UnZQaW5WUk0xbjMyRzJiU1ExTitGMFVBOGZiazN1and2VVoyTXhW?=
 =?utf-8?B?cTdQYUw5TlRXa0wyNXF6TmQ2cmFjOS9ldDZrVzUvUjcxdWkrdk1yVkFPa0JH?=
 =?utf-8?B?NkZzUHoxdnJPeDVidWNuanFlV051VWhpWWV6bGlnQ1h4WFdCWjhBYmRrZ0FL?=
 =?utf-8?B?ZU9rZDFCMGJPVFV2eWw3Ymd1Y0pkZkNsa0ZzSTVqQkUvZUFiTzN5dm9tMW04?=
 =?utf-8?B?MHR1V1h0cUtFbGJ5NHA4RDVRSEZ0WkxkSUVPbE9aVkFOVDYwQUVYTnJMb3Rk?=
 =?utf-8?B?VHMySk1vYkJwTG5MWWJyOFNtREdGdVlPNUY5QzBweXh0ZERVQk5MaTBKVWQ2?=
 =?utf-8?B?N1dwQ25jM0cvbGcxNlJzZDU2b2QxNW01WWZkeTc4WUdjUS8rNjV6UndUb3ZC?=
 =?utf-8?B?aXNqV2Q2MlFJbFJLZGhxNStSdVRleUxxZFlXWXZjWlk4ZElZbEVZQ0p0RWVS?=
 =?utf-8?Q?zjVLpTverOHDa35WRnbiOwlHg93e2bH1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGR3d0p4RngvOVM2dlh0a0lxc0o2UDRmbXV4ZW9ja1R0enRFQnZFR3ErYnNO?=
 =?utf-8?B?V3lrWkd1dnFxbjhUTHBNYjEyeTBKUnVyVHFXbElBRlRTOFNTRWczNm4zam1R?=
 =?utf-8?B?RnlKb1hNcjRHNFpiNm9GRVRIeVVoQkFNTnlmNlFyTGVRVUg3bE52dzJRN2ZI?=
 =?utf-8?B?TnZvLy95d0xmeHkvQmFGZERiREZtOVJ0LzlhWk9uL3E0c0oyb0V2Q254bmdP?=
 =?utf-8?B?MG9jY2NSc3VuSk9VZzIvQkEzQTc4Ulc4WGtmMnNOb3BReE9UWS9YeEhZVEV5?=
 =?utf-8?B?c29KMlN1TndmdWp2aFJycDJaYVU5bXh0eGRyZHZDRG5tT3BsTTZtMHhDdktY?=
 =?utf-8?B?dDNPMG5lYnhnRW1PNFUyOTJZdXNZeHNDN3hCeE83UGtGdzJ6bm5uVnNMYXdl?=
 =?utf-8?B?d0g2S29uaWJIbG1aSzJkSVIvNGEvVlA3T1dtbnNqZEQwSGYvS2RlaXk4bXhm?=
 =?utf-8?B?ek1mWStldk13WGJsMU5rOGthUjhiM3ZvOGFlWldJK0lvUGtXblBYbkdMVFV6?=
 =?utf-8?B?Z1V6aGFacSt0WHgwSDRJZVV0U01zcGdMbXFXVDVsUEFPdnJXTVZBYzBHWnB1?=
 =?utf-8?B?bVVCOFdyOTRjZG43RCtoT0ticDFwZjhRQldycy85ei80Z01KRXRUMjFnTHpp?=
 =?utf-8?B?VVZDWVlWc1FybFc1Y2RhbW4xYWVZVEgrbEFra1JEUnc0SUlBRzVqYlp2Z0t0?=
 =?utf-8?B?d3Z0dm1Wb0JBczd0VE5hbEhjWVJuYTNkYStoZmhTMFkvSGVEb1phN1FxV1Z0?=
 =?utf-8?B?K3IxK0ZwQ2o3cDZCNC9KTVhGeFpkcm9lbjc1L2VKc3pBM0QzTWVJZW0xMXMy?=
 =?utf-8?B?WDVEekJ0eTJjUkxpUnpSM2pRU0h1b1VCN21wTm5jS1lSa1BsQTBPV0VKVllD?=
 =?utf-8?B?RllVSVVJd0dLMW1pTGVSMk9PcXRDYmdxVHR5Y01ESHhZYTNFSTFjc1FQQVVU?=
 =?utf-8?B?K1lKbzBGTGY5cjk2ZWhkVFpocnhZcU05WFFnZ1JmOEdleHhEUGtwSUpTUUdX?=
 =?utf-8?B?a3gxcWVDY0h5cUUyT3BTRTZjU0l2eW5uQTFrN2J5TUp3OXp0amxrRlYxb0Vz?=
 =?utf-8?B?S0NCL0pLb0EzUVRadW5sNnNMUHdJY0FwMEw2Q1Fwc0tpWlh6eE80K0k0SzlD?=
 =?utf-8?B?NjN4NjloYXZiM3l2UlpNWHlZMm9Ycm83V2IzdFh6WGFyUmNYekxRaHFZMDJB?=
 =?utf-8?B?OG9ENDBETlR1U3hJOXhMRk5yRG1FNlkrWW9DWEN3VCtpamFvUWpxSS9MenRo?=
 =?utf-8?B?WU9pZE04TkFNRHNkcHk5djlsWnYwS2V5N1E1YVllTTN5MEtNSHFDdWtvNTFl?=
 =?utf-8?B?c01UT0hkQzJmdGkrblhYL2xWcXZuakpTTkRMZzlrS3dQdVE5cmkvMGZENnNR?=
 =?utf-8?B?ZENtSU9MNXdLSjE1SnZXN2RndWNtZ1JjMFJJcHlBOFVmLzkwdEN5RUlpVUpj?=
 =?utf-8?B?RmpsRGRQR2lTdTFBOTdraUtzOEl4V0FwdldGSE1kekRubXF4TFdqTzZscUVS?=
 =?utf-8?B?eWkvR1JVYVhRMnB2eFZ2a0dmOTZPTWVUeU8vRXk5aUlUY0tjTlBpWGVodGtT?=
 =?utf-8?B?eG84bGpEVXRSdXJ0R3pVNi9EN1l0VkFlTWNZTE11aDJibE1NcTVpRFlkYmtK?=
 =?utf-8?B?aUlOdkdqSHZRVVdsbzZnU2tqNzJuYm8vOHBrQ0RlUUJCYXBjNVBLaUtOWDI0?=
 =?utf-8?B?NG84VC8xRVMyaGhBTGlhYm5mWG5iYXMwV25sSDVNY0FkbXhwcW12bTIwbktZ?=
 =?utf-8?B?SXhXcUxpRTNhZFRUcU9tdjF6bThLSlVPb2hJeHUxVHNsZDBMTTVKRWFoSTNr?=
 =?utf-8?B?V0FFMGhDWEtsRFpzTXRhaWNsOUd1QXNIVVlOZnJxc2NPUE9BN0loSmJCTTIz?=
 =?utf-8?B?WVk3Uk1TNnVmSUduT2VGTEl2V0pqS3dsRVBiRTBGdDhNSEJNakUwaWpCZHJj?=
 =?utf-8?B?bjBsVW1sZUZlK1NOTDdEcHdyeFNjdHAxZTc0WERLcDNqd0JpWXBjNFJyeGlr?=
 =?utf-8?B?enQwYmd0bEg3bmNLdnVxbVh5MHpOUXdhUEtZbUJYNUxSMHcyUUhZOEZIWTQ2?=
 =?utf-8?B?Nlp4T2VPQzdLK0tVM2h5ZGs3NS9wZSsxNTBtY2d1TUxvbWZZMk84b3YxQlJp?=
 =?utf-8?Q?a50D+gEzaQOy0vno6zyT6jaJI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8aecc1-82a4-454c-0d3c-08de0b1a3c3e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 12:07:24.4382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGxOxsihF/qRP6PEC1rFgyvZGQ5JlznGFUY5XLZyuGV99rKMG6m0FFbhe3qkHd6WAXrbrp+FCRqzYj/dVQabNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4E874A00C
X-OriginatorOrg: intel.com

On 10/14/2025 6:51 PM, Adam Li wrote:
> Hi Chenyu,
> 
> Thanks for your comments.
> On 10/12/2025 1:42 AM, Chen, Yu C wrote:
>> On 10/11/2025 2:43 PM, Adam Li wrote:
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index bc0b7ce8a65d..d5ec15050ebc 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -10671,7 +10671,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>>>        if (sd->flags & SD_ASYM_CPUCAPACITY)
>>>            sgs->group_misfit_task_load = 1;
>>>    -    for_each_cpu(i, sched_group_span(group)) {
>>> +    for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
>>
>> Looks good to me. One minor question, would pre-calculating the mask be better?
> 
> I do agree pre-calculating the cpumask can save cpu cycles, without
> doing mask AND at each loop.
> 
>> Copied from select_idle_cpu():
>>
>> cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
>> cpumask_and(cpus, sched_group_span(sd), p->cpus_ptr);
>> for_each_cpu(i, cpus) {
>>
> But I am not sure if it is safe to use the percpu 'select_rq_mask'
> in update_sg_wakeup_stats(). Or we have to allocate a 'struct cpumask'.
> 

Allocating dynamically would be costly. Using percpu select_rq_mask is
safe in this scenario: the waker's CPU has already disabled local irq
via raw_spinlock_irqsave(&p->pi_lock), so I suppose no one can modify
it simultaneously. Moreover, if the fast wakeup path select_idle_sibling()
  can use it, the slow path sched_balance_find_dst_cpu() should also be able
to do so IMO.

> I tested bellow patch. It can work and fix the bug.
> If it is safe to use 'select_rq_mask' , I can submit V2 patch.
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10664,6 +10664,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>                                            struct task_struct *p)
>   {
>          int i, nr_running;
> +       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> 
>          memset(sgs, 0, sizeof(*sgs));
> 
> @@ -10671,7 +10672,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>          if (sd->flags & SD_ASYM_CPUCAPACITY)
>                  sgs->group_misfit_task_load = 1;
> 
> -       for_each_cpu(i, sched_group_span(group)) {

nice-to-have:
maybe add a comment here that cpus is not empty, because
we have cpumask_intersects() check in sched_balance_find_dst_group(),
(just in case sgs->group_type incorrectly remain 0 which is 
group_has_spare, if
the cpus is empty)

> +       cpumask_and(cpus, sched_group_span(group), p->cpus_ptr);
> +       for_each_cpu(i, cpus) {
>                  struct rq *rq = cpu_rq(i);
>                  unsigned int local;
> 
> 

and from my understanding, for this percpu version,

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu

