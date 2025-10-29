Return-Path: <linux-kernel+bounces-876337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F420C1B7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64D65834B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED7267B89;
	Wed, 29 Oct 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dv9IvKc6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595A4261B8A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747845; cv=fail; b=svwHDUBzKzTCLClS9GQpQCHdOhX1mJHABH6JMxJPClS7vsZ51ae1TbzizgQ0vH8duDiYAdvlC8JQPHCoZKt6Rqj1RFtVPdUT03rSdXiLj4h0o1Y9cM3jdAbsqBVZzZF5CB8twhOZLh0nibB5oxPaLGcJh3AIXO3V3yNwNTEpzOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747845; c=relaxed/simple;
	bh=i4xlC2aPcSKtHabqv/qFUgI6ky4yNfqDI99H5EdEtTo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mgF3sPx47FN+DCAk9PrlzwanMHnpNGBgYdBFZDTcStItxL1VkX2c6T0bO1c/l0e16brGxKUJLsPPCk9aONw4WFP/goqXIZe5LE3tKWqw/QSY8Vm7GscYZM+0TfmTMfNe0ztYxKqrdYbl8S2dzNBounDMtc2gpK79H8GJ0WXgMdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dv9IvKc6; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761747843; x=1793283843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i4xlC2aPcSKtHabqv/qFUgI6ky4yNfqDI99H5EdEtTo=;
  b=Dv9IvKc6WuUQtLhCGPlJFOcnM4WcLAy+f9oo1i4yi+SiZ5lkPxBQwKWf
   nbcKMqZKyfTiATdIl0PN8uKXvt0qBsQf8wRMWXMGClhaBcii7NwiOwknb
   tB9J4332TiGv9p7H2b3BxRlDBd96IG/S3DyN3Ldhf7k4YSJI2lhXZdqKS
   CqI1RZObzlzFexQNoUPKirX8aUpr9vCulVf4+DsdAJDRT9h1A4gyXGEPk
   WL2woyldYeROnNjRLo5ncZrH4bQlkitG/9bKNSULCUYC80Rp5xJpCZn3y
   gSLSB1dIYUS+2fD9kyYp8MYbSu42TldXCxpw7khCsBPygW9syq2RiofuC
   A==;
X-CSE-ConnectionGUID: eGON3U5bSciWbJS2nSO4eQ==
X-CSE-MsgGUID: qr4Aj0u1RcWTYONhvTs4ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="51444403"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="51444403"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 07:24:03 -0700
X-CSE-ConnectionGUID: 7+UTsmMLRXu93ycZ3cYuIg==
X-CSE-MsgGUID: SO3gsxMKTbW7O2EsUkwc9Q==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 07:24:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 07:24:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 07:24:02 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 07:24:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lm9IcTyBZcYGExfgSSAyO1MGZPTp97NHpZUS0uGIeuZ+lBBbY7OS9kP+sGXvGtFpKAzZ3bNcCSHRxNMPip6prTgR5uPJwJQYba4geZah9d97mG36Cgj9bKY2LxSI+ubUO8m+KRU+HJHTksQD0auuEt2FSksIpB6Dd+yOjCVSC2Z+sReAK4avc8HxHocNvbqApRA84nypDL3zWcaeYYK46Pe1BXgD9x0F/6S7+f3mO8knUNFgeuH01/aL380kJ32jGgsGm8CGwlncwqAD50E8uuNbSHhfRSpfaTlF90D/VW+angsa+ArWSfS71N/d6uT6tm5t7LgWVjXV3MRYl9Sw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGHYVyhPUdmwmXBydhXoSz0i4HE/WIPkGTHZJ/ScR/c=;
 b=oXt6ew3vhzWUCkhVLlNCz1s9E515nBn46r58ITgG6BOUj9PZU7rHLrswJRaAk2xZDVBfcLy1ZPmkz/PTalEvFeO1EkbD2uJ08IToFbDVe+DtIjxrFqRMmDZxJ4e20hXMILVu5KtrxDzdmGv/hUXf4rrZbqkuu8gN2eK6/ezDfOIeSZTLIRD7Av0fRpSagQNzq4uR3eMmYi63bbPQAnrkHvCQSTfAttpwshaIGgvrYQT1oGFEUvOgoD/AhfKeDL69TosfMHhrHTG2kde+rI6+pckLhZHDQS0J0xJl7Hs0rGpw1ym8FLTplUTcoTGO3/RpkczvIljn9bQClYak5D5nvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH3PR11MB7390.namprd11.prod.outlook.com (2603:10b6:610:14e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 14:23:58 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 14:23:58 +0000
Message-ID: <91cbbdb7-53fd-483a-8bc3-cd4e63713485@intel.com>
Date: Wed, 29 Oct 2025 22:23:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] sched/fair: Respect LLC preference in task
 migration and detach
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>,
	"Yangyu Chen" <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern
 Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Tim Chen
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Gautham
 R . Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
 <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
 <0a81b5be-6edd-4231-859b-0c6d06c61595@intel.com>
 <2c57d76f-fb31-4e1b-a3ce-ca13713e1b86@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <2c57d76f-fb31-4e1b-a3ce-ca13713e1b86@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH3PR11MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: 347cacda-977e-49d0-cf13-08de16f6cca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L081MjRPdGh6TklkakZhV2FkUWZEcm1GbXZPVnM4QW5CUkVLQktQVG5XdkZG?=
 =?utf-8?B?WEZGcTlZcE56aUROYldsUSthMkVoUlRkZlhCRXVuSzQwb1RqZmdzTWNtclpt?=
 =?utf-8?B?c0Y0T0FYN1VRYlpvNVVCSjB0bTFOejZ2Ri9JMXVYRzZDV1lCQlNJazdSZHhm?=
 =?utf-8?B?ZFpNTlJkVDlxNTk4MDVmWjBYMlNNL3plb0tZTHVCemFmRVpadFgxQUFjbFNP?=
 =?utf-8?B?WTVDNkJMSlU1RTRubjQzWHN3NkN5TWRKaXAzaHFsM0xZMlJDYXNQS3FNRCtl?=
 =?utf-8?B?OEE2Q3o3UE1QT2ptTTNhSk45ZkxLT3IxYjdicVZpaWhDbTcwL1NQWHFxN3hR?=
 =?utf-8?B?YmNnaVlQbGVLVUpvWmtoSCs0VHJlNFZ4czJXWTlqTHVKN2VyY3dxaWprTHJz?=
 =?utf-8?B?ZDVqdHV5S0RNWXd1U05oR2hQOE5RWHVJUVByeWo4aEExMmx0dzBwOGlkZzl3?=
 =?utf-8?B?TmR5MlIyQkhVL2hweXk0RVYyY3dadExQU3oxckZPUi9LR2tpRGMzSFowa0Rx?=
 =?utf-8?B?QUVqUW1mL2pXK2c5RENYNmlOcnBNS203UnhDNXI0RUpJTkVwVjdrMWRlT0dm?=
 =?utf-8?B?eHZ5VERwTXgvUFVKWTUrVDN5YkpzT0cyaU9uaW1TM052dlBkdDZrelpDaDVw?=
 =?utf-8?B?bXFGMkpCbVhDcjJyRzRMeGZ1RURBMDBNL1pCaGlZNEN3UTFFY1pEVERZZ1Ju?=
 =?utf-8?B?VUsrd3lLYlNES3d4UGo4Si9wZDBwKyt6TW85YzRuQjIrNklYYUhsOE9LNjNI?=
 =?utf-8?B?Y0htT3FHbzdFSGdhR0U5emFuNGFwVzVlNll2U1c1Vks3QmJyaU5CVDRjRlpz?=
 =?utf-8?B?Y2xmUlV1ZUJhM1FTWDd6dVpHcDRCR3ZsdTZycnpHVVpRUUNSdnZXRytUMmQ4?=
 =?utf-8?B?YXZaZTlxajNMd2lOT2prOVpwYy8xUUtqMWhVaFpOK3JEZVArTE5sN0wrQ1FE?=
 =?utf-8?B?enJKMFF5VjBqZUVNOWYxNkVBRGVUNUZ1bDB1Zk9aWVViZjBvODhuZFF6Vnhw?=
 =?utf-8?B?cXBkWHNva2grVUZtN2hyMUdmaGpnTDJHVDFhbGtjTVAzM2hGZGorelVQczVM?=
 =?utf-8?B?RFBrMkt3UW5WNitxYmRhRkNNM3BHRUtEWHdya2Z5Y1hEZTN1TFRsQUtOcnVa?=
 =?utf-8?B?L05VMmVERFBHeHoxKzgrNVAzaXArUDdFRHp5RzFpZGxlT0VIK1BieVNQbTR6?=
 =?utf-8?B?MDNPQ1QyWEROaVF1TW5CandrZDJQT01yZTRkWWFLSXprS09GbUdRc1F0SERG?=
 =?utf-8?B?cEhHUTRaWTVIY1pscDI5cHllbWNZMXB2YUhRNEt5TjR1d3IvYlFoS0R5RUR5?=
 =?utf-8?B?SzFQc1FQNmxIWkx0MUQ2OERNYjE2UVVQekRoS2N6NVJobldYTnkzRDlRNmov?=
 =?utf-8?B?SWk2dTRHaGFPQTFGVkFyNVRTUkM0YkFOVWdWdWZjM2hoTko3dnRtMEQ2b1Zu?=
 =?utf-8?B?eFR0eHpNN3UvQy9YU1RreUc4Y3BNaTFwczN6Tmh2N1VNeU5Pc0srZlM0SzJL?=
 =?utf-8?B?SXl3b2NzQ2F6dmhMSitBSldUUGd1T0pxdUVjQnNNL2EyQnlsb3h1ak5sZUo2?=
 =?utf-8?B?ZEtyNXZ1eUJ5M2o1MmZROWxxeXpaamdORVlhWjZsZHJxbXNyQ1NZdVdnY0dN?=
 =?utf-8?B?aVcybjNZU2ZtSlBZdFN6cnIyY1ptbmVJT3BUd2xZWDljV0duZHBxekhkcmgr?=
 =?utf-8?B?dDlKNEtZSHN6YVIxemJFeVFaWUNHQ25TQklkaXBEWGx2aVRhbkZuT0Y2ZDho?=
 =?utf-8?B?cERhM2ZjOU1UNHFwL21pZmNRUEJNUG1JK3RLMHlUQ2s0ajNzbFZDZzdIMjE5?=
 =?utf-8?B?aC8vNzZGdy9FZjRaUEhWNmd6RG96dmRBdlNWWEVqODBITWJwYUVQOUV4cjZj?=
 =?utf-8?B?NnZlekhOYmMyYWhtUzhvdHpyTkIwQ1g0WlAyb3lxWW1NOU01OHF6VnhJcFNN?=
 =?utf-8?Q?cthlK+6tknb1WQ1bmAOFt46kKThSQu/k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZ2Z3VzcitYWEZzVEI4K0NYYk83YjZSY1hKTTBXSzcrazJEdFBlMENJZ2dz?=
 =?utf-8?B?QVJLYXRreUJQbXl2WUF4OEpQK3h5dkpsTzM4Ly9IbThhV2luRHVBMkhJUmY2?=
 =?utf-8?B?ejFOM2VUWTJKbVB3YmZDTDZHZSt5TWsxalNvRmpNNU8vNWlqMkliWXJ2RGRN?=
 =?utf-8?B?ZEg3RnBoN2E3MGRyVmtqRkVna25sR00xS0pVaU5ZdDAwdFlsaFlmeVhUZEc4?=
 =?utf-8?B?UGh0UTg3eFBUK1NWUmxMUzVhYXdWQVJZVG5qNWowamdpQzFKak9JR0laMnlp?=
 =?utf-8?B?b2JLaElPUko2M2FQcG00cHd6M1NweXkrajVLaGFOdXRFT0Vlb3hhZldsamk5?=
 =?utf-8?B?Ukc2akZLZGlIdHg4RW9sWmVEampyc2JVU0UyaDVLc203TmF1RDMzOExEdm1l?=
 =?utf-8?B?aVNsRWh2L1l2SVczTzVYUW9zNEhneFVkbFNuOXZsQWFyRXRRSVRLdlk5NVoy?=
 =?utf-8?B?SlhOTDRFbFF1R1VTc0dYcnBFeTErSlBBU2tFRkJ6a3U4M09acFB6TUZKR2o5?=
 =?utf-8?B?VVJSN25zZFRTV1VUWTlDLzlSbFZpNy82b3RiVWVpdTl4NEJ4cG1zS0J1RTJV?=
 =?utf-8?B?eUdRNHoydnRPZTljY3VrWkcwOUdVS1ZkZW02eURSL3J4L0l6NTEwYlVsdVEv?=
 =?utf-8?B?TmFWb2c4RFBzRFdZZjJaY0ZNZjdlMFhsR3pNK3o5aVBHbGd5UlcwbW1vTWQ4?=
 =?utf-8?B?R3QwQThpeW9VL0RKTWtOdUpmMkNpUnVUeVRqTzBtRXNUYUM2RjlQTWZiVUxh?=
 =?utf-8?B?RGV6U1ZMbmFPVGpZWmpVcUpYNE1rZFRjb3dzTDh5NlFFUC9kcWFrMWd6amww?=
 =?utf-8?B?VnNkVTJLNzVseERJc2FQcmRad29OcmNyRFQ0YVlkSVE3TjBna00zbmNiTkV2?=
 =?utf-8?B?engxUDR1UndrU2Z5YjVsM0ZSYjAydzBuMFdCL0pIZm1hMHhhekpjeXFRWjNi?=
 =?utf-8?B?TE1mMWZSdEl0ZW5OeVNGQ2RndFNCRjJwM2Nld0dRcUc1OFZvT2YrMlpqQWlZ?=
 =?utf-8?B?clZtZEhKdEw5blRDaFgvYVhqMTBsZ21mYnN6YTZJNVRISHMrNmhjbTBicm9U?=
 =?utf-8?B?Si9MQ0lFNzhKRUZqeFVDZ21MWE1ydGdxa1Zza1Fwdno2Qm9XUFc4Q0lVcG1B?=
 =?utf-8?B?Rjh1TnhWRDNWaGxFN2Z1ZGdVbi83ZmZKWFd4UWNwaE1RYWd2ZEZBWmVmRjhE?=
 =?utf-8?B?MW5RSkZuMnpKSWJmN0pjRjJ3UC9CRVlZaGhvVDJ3bFdwaGRubytIVGR5OGdU?=
 =?utf-8?B?dXIzQ3NrcHRHMlpMOXdSbS9IQjhzTGlmamM0WXI2V3d5b0tNRGs4V1ZmWXdQ?=
 =?utf-8?B?dEFjbStXc1FIVUlXRVVpMnpNQXF4WEpMZ08xbEcxOUZDK25LY2RNcG5ZTEhE?=
 =?utf-8?B?TmtZZVVGTWhqL1llelRDQ0VYZlhhNEE2VHg0ZEFKeUoreDlrOVQ4M1ZCdXRN?=
 =?utf-8?B?Zm1CVEd0bUhubHRvV1cya3dNRWtYY3FkMWljY0FRc0F4clA4VGwyVlhLSjhr?=
 =?utf-8?B?bUhTSS9TdEI1V1U5bFJ3a2FoZW80M1JSSERtalNSZkNjWnFXMVA2dmpqekVi?=
 =?utf-8?B?TC9TdStseEtsWHdyS1A5OUY1aTZQMzZkQzNrSCtHRURMdjdORmk0eTFUUk5j?=
 =?utf-8?B?VEY0U2pab21VbWxoaVJESWRpNmttMW9GbitBeUVaSlFPUC8wVW1jSk4xa3gv?=
 =?utf-8?B?R0c2L0UrSE1vb0JveWxmR1JxMGl6VDVBcGtNbDNTWEJKVlZOTU5qQ0dFWGJm?=
 =?utf-8?B?NWhlU1hLa2xOc2NJR0lSSTR2OUF0SUV4b3g3bXd1cnZmWkRiRkl1MDNFMHM1?=
 =?utf-8?B?NkdORzhacWRaMHRuL08rVWdPa3JETnhqNEZjb1FHMCtwbUJ0emtiZ01YcmFs?=
 =?utf-8?B?WUFaYUN6MzN2eER3Tk5VU2lsR1V5dlFoUlREdU1OVWxaM0V5VCthVFBWZW13?=
 =?utf-8?B?SzhyaUtVU2s2RjBHV3h2UXhSSHN1LzhyOGs0aHhvV0p4V1VWVkJLMVhPc3hB?=
 =?utf-8?B?T1ZYZlBOV3NVbGdQTkNVMlprS3NKZFRHNm1teUxUdXJ6NDZxNFFGWXFsQmFl?=
 =?utf-8?B?TzJYdXVrdGRBYVBGdmw5dm5xWk1RT29oWkkzem16UUZqa3hJU1V5UDh0aGQv?=
 =?utf-8?Q?0vm/LWZ+af7cDpvn+HFgo8GdK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 347cacda-977e-49d0-cf13-08de16f6cca6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 14:23:58.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpqHO+jyjTGtYvV7f0bF3mB69LzFuAgRahjI9T1YgWTwJAgSLZAFlMlM2CQn81mWgOKRSxTB042JefzO16/vIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7390
X-OriginatorOrg: intel.com

On 10/29/2025 11:54 AM, K Prateek Nayak wrote:

[snip]

>>>> @@ -10227,6 +10233,20 @@ static int detach_tasks(struct lb_env *env)
>>>>            if (env->imbalance <= 0)
>>>>                break;
>>>>    +#ifdef CONFIG_SCHED_CACHE
>>>> +        /*
>>>> +         * Don't detach more tasks if the remaining tasks want
>>>> +         * to stay. We know the remaining tasks all prefer the
>>>> +         * current LLC, because after order_tasks_by_llc(), the
>>>> +         * tasks that prefer the current LLC are at the tail of
>>>> +         * the list. The inhibition of detachment is to avoid too
>>>> +         * many tasks being migrated out of the preferred LLC.
>>>> +         */
>>>> +        if (sched_cache_enabled() && detached && p->preferred_llc != -1 &&
>>>> +            llc_id(env->src_cpu) == p->preferred_llc)
>>>> +            break;
>>>
>>> In all cases? Should we check can_migrate_llc() wrt to util migrated and
>>> then make a call if we should move the preferred LLC tasks or not?
>>>
>>
>> Prior to this "stop of detaching tasks", we performed a can_migrate_task(p)
>> to determine if the detached p is dequeued from its preferred LLC, and in
>> can_migrate_task(), we use can_migrate_llc_task() -> can_migrate_llc() to
>> carry out the check. That is to say, only when certain tasks have been
>> detached, will we stop further detaching.
>>
>>> Perhaps disallow it the first time if "nr_balance_failed" is 0 but
>>> subsequent failed attempts should perhaps explore breaking the preferred
>>> llc restriction if there is an imbalance and we are under
>>> "mig_unrestricted" conditions.
>>>
>>
>> I suppose you are suggesting that the threshold for stopping task detachment
>> should be higher. With the above can_migrate_llc() check, I suppose we have
>> raised the threshold for stopping "task detachment"?
> 
> Say the LLC is under heavy load and we only have overloaded groups.
> can_migrate_llc() would return "mig_unrestricted" since
> fits_llc_capacity() would return false.
> 
> Since we are under "migrate_load", sched_balance_find_src_rq() has
> returned the CPU with the highest load which could very well be the
> CPU with with a large number of preferred LLC tasks.
> 
> sched_cache_enabled() is still true and when detach_tasks() reaches
> one of these preferred llc tasks (which comes at the very end of the
> tasks list), we break out even if env->imbalance > 0 leaving
> potential imbalance for the "migrate_load" case.
> 
> Instead, we can account for the util moved out of the src_llc and
> after accounting for it, check if can_migrate_llc() would return
> "mig_forbid" for the src llc.
> 

I see your point, the original decision matrix intends to
spread the tasks when both LLCs are overloaded.
(src is the preferred LLC, dst is non-preferred LLC)

src \ dst      30%  40%  50%  60%
30%            N    N    N    N
40%            N    N    N    N
50%            N    N    G    G
60%            Y    N    G    G

  src :      src_util
  dst :      dst_util
  Y :        Yes, migrate
  N :        No, do not migrate
  G :        let the Generic load balance to even the load.

I suppose the reason why the code breaks the rule here is because
as Tim mentioned in another thread, to inhibit the task bouncing
between LLCs.

thanks,
Chenyu


