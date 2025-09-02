Return-Path: <linux-kernel+bounces-795600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0844BB3F515
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5CB47A5D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA912E2DC4;
	Tue,  2 Sep 2025 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lclsj9o9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415301A288
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793676; cv=fail; b=hGrT/QKZOGByuGtoCE9RaDtDhsHfGDJPDgv3tLIUgkOX7jDkw+bcgQr6yOac2m1Bd7e86HIHVPsnaBXfAbFlcU8MZTuKNbJKLEej1x1DbJDNP/Jbfr9pwzMko8vfVf4Ojxp+aarglQeiToauBkGjlLfBLtKOH6o+CacqDzqc3bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793676; c=relaxed/simple;
	bh=EsM0zF1IJ5hc4QDkt4Kurk/brSStg3qqAUaDd6zRfh0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lU+IqzNdjsoeRRwR4j9JSpwOfoo+iJWqvcSn4YKW3QwpbptP84syj/6bQMs8Uh56NKHIyczxv6WYnk4oaeBJEjP014q32odCSQUVOE6vFapP5tTV38m0GdqEXAza/JH8EC7we6usDTkwOLXp2YU8vfYPLRpDu7WYee4R+zHz5Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lclsj9o9; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756793674; x=1788329674;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EsM0zF1IJ5hc4QDkt4Kurk/brSStg3qqAUaDd6zRfh0=;
  b=Lclsj9o9soBmT3g2nigvGlIbpxom2K5UzfIQ9xtf6zL7/c/891Jvtztj
   A36kbdBaO/tuKoB7Pn+N6jvo0t0l3ucA9vria5P1GFbBzcPQSpLwFnc2z
   PJYDTQcyU5p0EYdpbc2QCGF006VHgGoREyuPeeRqBJ6Fz81sWRxxb12sc
   IRlCm/nHsh9SJjnGbAxsfDKqXAjwCff+Y5p4BHZ5xN/JYeajoqmWezmaT
   LL4DveWaroPmZYRf4RHWykAy6Gzvuuy+filvKn7gSGqqBXf2z2Xt1Lciu
   6Bc8pLkPW29n9OWhNN9GFDhZhVweviOEuCK5e1++xhERISxkhXk4gvBq7
   Q==;
X-CSE-ConnectionGUID: Wi/PNVaUQ4KNRYrq2hJq3g==
X-CSE-MsgGUID: bqGMZQqQS5OknZe/UgImoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="58749535"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="58749535"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:14:33 -0700
X-CSE-ConnectionGUID: wpd9CIegThKjCHaexK3h0A==
X-CSE-MsgGUID: SOyu2VAoSn6b2LycVRTs8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170744708"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:14:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 23:14:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 23:14:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 23:14:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTyFbFgTwVl1lNZRgs2jCc8aS/Q/AQceo7IHffcPJvI/0GyK26zOLy4swCOnbmVvhbylVNTnAXOWjroSr4vcCndPBu+VOPvm32SeUdlYi3HkSfe9jlbQgdPtshnKL4dJmm6TozAE6IwzXobp2pcx1HtLzXKsg41W2g0e2vQ3piZFvuh7a4Y9kPGPL5pOaSoOAdKUsSvWPN56ekaJnoK1Im3JcIyZbo6iCMklWdP2Th9qh5MWlXSYiAaDP9xki8vSem4OPzBor9JLQn+Q0l4mSPkjFNHD3wkuey+b+oi4pka5qHAMxy8xellMNiL7G14WVB31eXlANSkaW6aLtGX5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OoA4d3OniL+t+VPmHdomPNbLadawzHeNCXC34rQT8c=;
 b=OilRaAYu/+nl4kIHzegImbeRw/NXEusxLtJ1l0ZwyA3Tv63bKSbsEQLSRnNcgMtjWq2EjT6KlZ0d9GTN5bTrF0WOkQf6z6dT1+o0EOFwr9lORBdKU2LN71DAUKNHE4PNd4tp9psgWWJ15G3S3OD0RNXgygWGrvH7W21Vqpw7mJOq3BG/ApYb+H4+ho5sYDpbgHc7s4ww/OyuY3zEZM24rlPK8DcTgOIpSjCIAH7YwjsFI/YAP3gISTd61SxiBi4lVh7JliY6v5jOiiAOqh3twnDdILOLU8z6bLyWJOAVb0mxeHjEQAiyok8Y70xf1MOzEPNX/6xDrOYWc9+q7IKqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB6793.namprd11.prod.outlook.com (2603:10b6:510:1b7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Tue, 2 Sep 2025 06:14:29 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:14:28 +0000
Message-ID: <d6a19a7d-e435-4a27-9725-b2fb802a52fd@intel.com>
Date: Tue, 2 Sep 2025 14:14:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 25/28] sched: Skip cache aware scheduling if the
 process has many active threads
To: Tingyin Duan <tingyin.duan@gmail.com>
CC: <aubrey.li@intel.com>, <bsegall@google.com>, <cyy@cyyself.name>,
	<dietmar.eggemann@arm.com>, <gautham.shenoy@amd.com>, <hdanton@sina.com>,
	<jianyong.wu@outlook.com>, <juri.lelli@redhat.com>, <kprateek.nayak@amd.com>,
	<len.brown@intel.com>, <libo.chen@oracle.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <sshegde@linux.ibm.com>,
	<tim.c.chen@linux.intel.com>, <vernhao@tencent.com>,
	<vincent.guittot@linaro.org>, <vineethr@linux.ibm.com>,
	<vschneid@redhat.com>, <yu.chen.surf@gmail.com>, <zhao1.liu@intel.com>
References: <463bc54a283c1b908ea286ce67f301e2d1d39ea1.1754712565.git.tim.c.chen@linux.intel.com>
 <20250902051608.4733-1-tingyin.duan@gmail.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250902051608.4733-1-tingyin.duan@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: a48b4498-1214-41c3-e12d-08dde9e7f965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWp4cDJPWU41Vm9yOU1lanRNcmVrSTlQekRFekJuZzFnUjZPdGhpQUVHVjNQ?=
 =?utf-8?B?ZmIrTy9QVVhyMCtrcGdqVFZPWU51d3Q4b0FEUktBcnIvZjcyN0NucDBKL1l2?=
 =?utf-8?B?Qk1pdzhpQXYyN2FpY3dMS1IvT1VsNzJBMEFxTisvRlJRYkNLNjd5b1pWV1Ry?=
 =?utf-8?B?Z1hnUHB2R28xcmM0ZXpEaEt0WEZsdzVzbXlGVFFxQXIwMjBkUlNqSkMrRnFi?=
 =?utf-8?B?VUg5dnFzbTlYM29veVRxYVF4VDdoblZvU3FNMnhkdnJvVHM1NXF5VnF6VnQy?=
 =?utf-8?B?THdxdGd5ZXpXeFVoN0ZJTExLSTNmRlFtcEVFREJiendMUGRGQmpVTHdnNXhW?=
 =?utf-8?B?bitPVHZ4eVRZNWxmK28yZlM3V0YvRzl0c3F0Q01KMXNUSGRzNVhjcm40L29k?=
 =?utf-8?B?SEs0L3IrMlZyeXRpRGNTaWdmdzJTMjZSbzRPRm44VmFLQU5EcVN5TGc0dVpo?=
 =?utf-8?B?RUczNlFTZG8xdHZiYmtWK2pDNW4zNzM3OTZIeEVjYitCc3IrVGlzR2xzQlhB?=
 =?utf-8?B?SVQ3UGlTOTZxNzZaUTNUakZRR3VjSldTNnh5K3E2M2UwaithUlZLVWt2U0d0?=
 =?utf-8?B?MzhuaGRFKzV4NVJwUkN1RGVINUFlQ0lnZnN0c09EYm1xMVZJZUtHaXYvODR0?=
 =?utf-8?B?S3M2a1JuYVZoSDc5SXhNdkJ4OGhUek5UKzZSemQ4b1NLNnhJQW5JSGZxOUdX?=
 =?utf-8?B?aElIaURlcDJGSENDUnpETTFseUVsOE1nRHZiL2Vxa3MwREc2R2N6K01KTjJ3?=
 =?utf-8?B?U05qOWM5MFBpNUtVd0FidFA4RmdxaENQNVJaN0tJUjY0b0F3cElTWlR2ZWlT?=
 =?utf-8?B?azRXRjNRZnN5N09PNkI3bDFZYmxRR2RKMXE1YlJpSWNqMXNDSTBPdVJJVlpx?=
 =?utf-8?B?UFMvV245YTVidHVCd3czamR0YklRaFVmdFMzZi94bHhMOEhaNWV1S1ZkdlMz?=
 =?utf-8?B?YW9RYnFHS3BhVHdvc3RFd3FzZCtYaFp4eElMVlIvRS9CdHBJaTN3SWxEekVu?=
 =?utf-8?B?MTlsbnVDSVVxWVgyQU1BYzhtRGFwNUo3eEptY2RLMGwrTjNkWlQ5b0ZNVW1U?=
 =?utf-8?B?MVhYQ0Zmd1YyamlkdzYxRmM0TjN0a1g4T2FOcndDK2FScUxKUDMyQ3BHazJH?=
 =?utf-8?B?aHUyeXE3L3dZL1BRTUdUUnMxU2dCZ1Z6WjJZTHhJZHRueXVTcFRDYkVJNWYv?=
 =?utf-8?B?OEFWRXFxa202cVhrN2pNNHl2SjFwMXZibFlhMmFvR2NqVHFoU0RjVEtSTmZs?=
 =?utf-8?B?T1g0MDF0RTRHakk1NDBPSjlVczN4QXRyMVl2YVFDS2hZSEFlQkFjK2J1M0ZS?=
 =?utf-8?B?WGYwTVFzeWQ5QlBmNXZXd3hMcjZldG9pdm5sK25GcmszZVF5WlE2d1pkWUFN?=
 =?utf-8?B?VldiWVNNb2cwOHhDTUpRZldEYVpKRnkrZzR0OVpSbWhhL0I2OEk5bGZhb3VX?=
 =?utf-8?B?cXN1Z0Q4SGhuK2pZTFpUTUVTbFBZZHF1MjhwTEFqSW8zK3JyQktaTmx0UmUw?=
 =?utf-8?B?R0VDY2p3MGJBUDl3bmt3dTFuc0JmdHo5VTJWbVNHZnU1aittdEVZalVrNzQ0?=
 =?utf-8?B?d2FKTXRSUDhBRHR0VWcvOWRDaHdlb2huc1FnSEt1c08yRGdlT3VSL2ZTNmFM?=
 =?utf-8?B?OVFPMGhDc3NlZER6OWEwSTNUV1ZFU3JGTmY0eGtNWUlZbTFvTElybGZXaVBr?=
 =?utf-8?B?V1BpUitFMXJXSng0OXQ4cGE4OVNxZzVZRVh4NDd6eGxoSzdKVWNuRWw1MDFn?=
 =?utf-8?B?WkpBdUdtT0lmVmhxSys2aEJmYW5tM0kzWTZLUDZsRkMzTkIxbnhSeWtMRE42?=
 =?utf-8?B?aVJTM1U2aDF0K2JVeitpald4cUdNeFl4OXhxS2NidllNc280OTloclZsYjMr?=
 =?utf-8?B?YW4rSjRCMG9KWGNYc3dZc0lIRERyanp2V0o5Y3VHbnBPS2g5bEExaSt1aXlU?=
 =?utf-8?Q?Vu1nItvI5bU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXNGeWdtMEZyaVlMcUVhdUNmQWNIRldCanNRUy9UOEEwTGlhdC9sQTk0OG5D?=
 =?utf-8?B?bGtWYnZ0TFVMeHd0dTJ4UzZTWGpyU3JWdWMybENSWjFiRzVVbmRaQlFDYVl0?=
 =?utf-8?B?LzFvSnBjM3F5dFZkM1pQZGhxWTRQdWpCL3pwQmpkVTJNSEdtbis0dWRIVHZ6?=
 =?utf-8?B?S2RKQ04wT0FBd2FDajJuQ0JBYy9VbjlUcGQzbTJkaE9XYU1KTW1RYXhWSzgr?=
 =?utf-8?B?RVBGUFZTYmF0cHVSU3liYWRkTitSV2ptVlNra2JZc2ZCeFNrSTN1Y3diZDVX?=
 =?utf-8?B?eFkwZXVuaEsvU3hVdFA5NGNxTjRXS3REZGVXSWFVZE03bTIxYm9oczNYeVB0?=
 =?utf-8?B?SE0rejY5SXZ2bURBenZyYmdNa1A1aUdRZ1ZBdUd5ZjRMQVhvMGRrdGFzL2Vq?=
 =?utf-8?B?cVEreW9lS2Nxb3pOMUJkVlMvWkhjRkIrOVhUcGlSSDdQcGgxWER4WmRyb01T?=
 =?utf-8?B?bEppU0VDazRwaVBTUWdYWUV5R1cvSXNvbmozQ3dXWWJPbGcvT2EycUZGMU8y?=
 =?utf-8?B?eGo3QXhHV2tJbXQ2ZmNWTkVJSWJqMDZjZWk4MzJ6YTAzWlUrZTVQM3JSOXli?=
 =?utf-8?B?dWRlbHQ4alJoY3JpMlBTb25JZ0RFYVE5UWdFNzVZa24yQktPT2J3VHBhSkty?=
 =?utf-8?B?L2crYm44U2J4MkpqMHRLZU55YTZjRVljS2pwQlRwMllHcWJZUU4zMEZnT090?=
 =?utf-8?B?amVra1YyazE3LzhRUE5Xc1BJaUZJakh3UTZxWVAxNEh5bW1HVzlmT0IrZ3lm?=
 =?utf-8?B?U20vdnltMDVWYzltc044VHR6MWpFeTZFdjJ5M2hyWm9FcFFSVmZzMlR0VEpT?=
 =?utf-8?B?bGZwR0VyR2E5Qy9sUTVZVmtZdWFwcnduY3NLYlhvTDgrT1NBNXQ5U2hEVjIx?=
 =?utf-8?B?YnNqbytvbDl4RXdnR3BvemIzMEttK1BvTGVsUVk4L1puVzg2WGcwWTBQYWNw?=
 =?utf-8?B?eDlGN1hPbE5GUmZSZTMvMjZ5T3VLcWxPTzBwM2tETXZNWHdWVEd1UlRFc3U5?=
 =?utf-8?B?dmN5VWNsV2lvbGdIbVhLVHBvUzdYWjVSR1h4RFg2QmtRdEhpanRLUlNmZHVT?=
 =?utf-8?B?ZzJVZ2lBOFVRVjFtcUNDS3kxcTU4Uk44S0pyamgrd3dFSE9YLzg4czkxUDZs?=
 =?utf-8?B?azZCbVlRMnE3M1pkYTdYSTBXMjJ2TnNQTG5hQTcwR3Z4d1dHYkhOZ1k1YkJq?=
 =?utf-8?B?TklJcXRlYWc3WjNpU0hpeXUyMFFHVDI1R0tFazEwSjIwaUJhUWwrKzBBeld3?=
 =?utf-8?B?bTVqY0FST1E4NHJ6VnV0aHpwakEvZzBVTWRLVmRyQ3pvb2w5RXB1dnYzTzZU?=
 =?utf-8?B?ZlFBc3JYZFdQUkQrd2NwT0FUQlorNjZENFBuNkN6UTI3S29ndVFzWTRIbUZh?=
 =?utf-8?B?UXVpbTJTUUJ5Zk9pK0hkdlFVcUxJbkJKNUpDM1UwZ0dHakVaZTN6N1Bsc3dp?=
 =?utf-8?B?RlE3UDVPc0dpaFdzNEQ2cEZMaVhyWmdXYnJwTldOSDd0TGhrVnE5MjZ5K0dl?=
 =?utf-8?B?eThiLytmZHlMVjd3UDlCZ281SGVXNjYvNXA5RXRZd3ZRZnZkM3NZbGNaNVNF?=
 =?utf-8?B?WlREbFdIUndiZmYxSThieG9JUU9BdUlPVDB3QjU2cnZNc0sydlViWGYxYUhY?=
 =?utf-8?B?SWJlejZOd0swZTVuT3J4ZVNFRndkcDJ3VXFES3lYSGs3b1JrNkNIZURtYkFV?=
 =?utf-8?B?SXE5dHlGZmpZSllzUW5GejVkbGw4YW9STWdZd215VytPRlZvV3VQZERvdU4z?=
 =?utf-8?B?YWdGeTQyTWM0cnd2NUFBUXV5R05vTC9DWlVYY2pld1hRbjFBZFZNemhya2tG?=
 =?utf-8?B?QnZsbGVvODRlSGZjMXJ3Uno4NXRMQmdqSXJpSHJIUndyUUtXSHFuVEY4MGZN?=
 =?utf-8?B?eXNBRVFPTTNsRmlDWCtGRnE3RGVHcC9WRW5WTW05QXZ1Lzd4VVdPUjJJYUc3?=
 =?utf-8?B?K2Vvd1YxZmgvLzFqR0tucTNlTHMzUmJHdjUyQ1AzS2w0ZnAxQTNwdzZkWGhP?=
 =?utf-8?B?KzF6VkhGK1RYRUlaUGdWbE1TM2JaaVlEUUNIMTc2d3ZQRE5nTjBscEszUFd6?=
 =?utf-8?B?UmhlKzgxYUxCRlNqd1BxR0t3eXFxR2JBdlcwQ3RZSWVnUFQwQ0NzbkRGVVlD?=
 =?utf-8?Q?iIJq0uI8hHyWqzvZ9YLO+AFaS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a48b4498-1214-41c3-e12d-08dde9e7f965
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:14:28.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9I0IbMl3SoXrfD5jfRGOKzTUa4y63vowxFYUeLM2vI2lbq3PeTu8xmqSWMjbtBa7qCR5rmDPllPvwKVUZEm0QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6793
X-OriginatorOrg: intel.com

On 9/2/2025 1:16 PM, Tingyin Duan wrote:
> Several different test cases with mysql and sysbench shows that this patch
> causes about 10% performance regressions on my computer with 256 cores.
> Perf-top shows exceed_llc_nr is high. Could you help to address this problems?

Thanks for bringing this to public for discussion. As we synced offline, the
performance regression is likely to be caused by the cache contention 
introduced
by the [25/28] patch:

The 1st issue:Multiple threads within the same process try to read the 
mm_struct->nr_running_avg
while the task_cache_work() modifies the mm_struct->mm_sched_cpu from 
time to time.
Since the mm_sched_cpu and nr_running_avg are in the same cacheline, 
this update
turns the cacheline into "Modified" and the read triggers the costly 
"HITM" event.
We should move nr_running_avg and mm_sched_cpu to different cachelines.

The 2nd issue:
If nr_running_avg remains consistently above the threshold in your test 
case,
exceed_llc_nr() will always return true. This might cause the frequent 
write of -1
to mm->mm_sched_cpu, even if mm->mm_sched_cpu is already -1. This causes 
another
cache contention that threads on other CPUs trying to read the 
mm->mm_sched_cpu.
We should update the mm_struct's mm_sched_cpu field only if the value 
has been
changed.

That is to say, the following patch should fix the regression:

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2cca039d6e4f..3c1c50134647 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1032,7 +1032,11 @@ struct mm_struct {
  		raw_spinlock_t mm_sched_lock;
  		unsigned long mm_sched_epoch;
  		int mm_sched_cpu;
-		u64 nr_running_avg;
+		/*
+		 * mm_sched_cpu and nr_running_avg are put into seperate
+		 * cachelines to avoid cache contention.
+		 */
+		u64 nr_running_avg ____cacheline_aligned_in_smp;
  #endif

  #ifdef CONFIG_MMU
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 026013c826d9..4ef28db57a37 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1428,7 +1428,8 @@ void account_mm_sched(struct rq *rq, struct 
task_struct *p, s64 delta_exec)
  	    get_nr_threads(p) <= 1 ||
  	    exceed_llc_nr(mm, cpu_of(rq)) ||
  	    exceed_llc_capacity(mm, cpu_of(rq))) {
-		mm->mm_sched_cpu = -1;
+		if (mm->mm_sched_cpu != -1)
+			mm->mm_sched_cpu = -1;
  		pcpu_sched->occ = 0;
  	}

-- 
2.25.1


With above change, the regression I mentioned in the cover letter, when
running multiple instances of hackbench on AMD Milan has disappeared.
And max latency improvement of sysbench+MariaDB are observed on Milan:
transactions per sec.: -0.72%
min latency: -0.00%
avg latency: -0.00%
max latency: +78.90%
95th percentile: -0.00%
events avg: -0.72%
events stddev: +50.72%

thanks,
Chenyu




