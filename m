Return-Path: <linux-kernel+bounces-849229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0C8BCFA49
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 19:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22FF0347545
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D727F736;
	Sat, 11 Oct 2025 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1xrAQfl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631671DF75C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760204565; cv=fail; b=DCv+iwHKQahxYBc3Hbf537cRSyk/FBDsYx+PblBunHDbzknxmTw5K0MptLQjFkJqwVXPAfQUD6/0mazTq05QWvuoyKhkzD7BOChbQh1TAQF8YLbscuvKlUQIK6bMKuHLfRW4oKyqv5ytKSPeuJCqZkD2R9Sc2Asp/O6meoa3naQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760204565; c=relaxed/simple;
	bh=f/eJQ5lLY2iBqMfJ06k/wnJv9xYPZvPiGvwFF9dffJE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pllQv5JOHDqFSZorrq6Ekr/iEq6CFj6CpyD1LAS5hO2wdaveF3wnDcps8Vuq+d8WoA6dtZgEgyH6MG732q9TRXj0977EcvsqPw61TwC2s+rXJeFa87t2Wt+Nn8juqOhBbB3NMGCi+IY3LvNyGEi4Q2vhqHi+ajoZriXB4xp++l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1xrAQfl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760204564; x=1791740564;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f/eJQ5lLY2iBqMfJ06k/wnJv9xYPZvPiGvwFF9dffJE=;
  b=L1xrAQflXrWrIqEWiih++UhLZe0YuK01EF4NxwkbIPvBCbQGww44H7f3
   LE2dZ8FCnJ8gWISNMs1KzQ+pmKy7h2CkChC+TFMm/log0NfoQhCGkGQ6F
   oQ/B7bcBzhgQWwQf4QgnA6Ena06mpvCGqn1y5wKT0MYnxH+LLgrjiPgmt
   MomnYbSMuB1LhhC+dAob4/McD2Sftw5u8QRQToMBk/bD4h8AY3/Kb8pDP
   1w8mYZ76czxC/7LloA8lAYDqAVyqPYM41T2KonHF8NXsAxIki4gDvGm6v
   GhMEWZtapwRkLaEg0HEzBu3CjjNvC6QaEyFgC909n4eYi/VwNAs0UELnn
   w==;
X-CSE-ConnectionGUID: Jt2QDw7mS6WCjt4V0GJUBQ==
X-CSE-MsgGUID: O/lWLx4VTsmOYzqPOXHX4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11579"; a="49952496"
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="49952496"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 10:42:43 -0700
X-CSE-ConnectionGUID: pn/yPEJVR7StjTiSbUxoEg==
X-CSE-MsgGUID: vu0nn0zNTGWOpvrckipaUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="186511394"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 10:42:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 11 Oct 2025 10:42:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 11 Oct 2025 10:42:42 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 11 Oct 2025 10:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baogDH9hXmrg/54MTr1VzzTJJfcWBGFnmfCRzMHGgPQ6OhPDCvQQqVHkWuOz9ZVQ+BmE2Sp+nVkHUrGRhcluNi1kLyEjCdiPAxM50d3knv+7WcQtDxoZ5Jf+qtg29ELT3IjcFo2Fv31QSnfqYUAF58uWXhIQjzXATmhTeiNKRhadTdd30N2ERfUG/vz+3x5eRQY0F1I2ROMAflKZIkshnnmgTAOSSpWfV+q9H3Aj64AmVRImjFNR1KMWM2SYG2qmrdjVupKaAUq9B3pCuxQrD/H8qccdmqTFqwzyYyN8KDue8L5pxz2krT1kXFS5G2x97iCw7z43MREu+OY6570POg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaHH30vTkP8cEQyUQhX/F60hiDTUq2c6IgqlsOJjN0A=;
 b=MIi5aoRfSIfWj5V9zRqGPzIF8qQQMymVMJgHH9bVH/lKIxPg4MjPZLwDeuAz4HY0flsHHCand7IhoEyihbzTxJiiA8rZ5AXKq2NKLDKfoa0XLGqJ6q4cMypBKYbTZZx0pQwsQ2wHYMpRMq1k68AzmCazY3p+qisaNjK4nFQTfTJAS9c5+2EdRutbBzBVKZlJNkvBnDr1ESd2e+XbwKyozqGEAEaJjbek7WgJmCwFQlaqalZJD2+hI1FOMNGH0c1tONLYT2HUkIQzI8jFPKYUuC9fAtBpKsWowX1b/HExFbjH/jntZ7XzE16/df9Me3oB3gJziuadOpzWSpIwDeiHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH3PR11MB8442.namprd11.prod.outlook.com (2603:10b6:610:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 17:42:39 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 17:42:39 +0000
Message-ID: <90e7343e-7741-45d8-b076-d3852d1870fb@intel.com>
Date: Sun, 12 Oct 2025 01:42:30 +0800
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
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251011064322.8500-1-adamli@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::21) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH3PR11MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 930106d1-931f-46a0-4d46-08de08ed92c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFlXM1dBMlV3Wkg3cHdESlJ6ZytWMzNrNkpVQk01dENSVUZPdk9JcEl5QzAy?=
 =?utf-8?B?ZHlubnBBUjBhckVEWHVhWFpsbGEralZ2Y0xWR2xmMnQzV0NVM0JVZGZQdlBN?=
 =?utf-8?B?VDZmUndncVBsb0FObzdHZVRiUldjcVYyOVVqVHhQcm0rT29ETk5MUHVVbG1p?=
 =?utf-8?B?Z0Frd1FwS1FkTW9wdUNFekRjYTk4NGRrMTVqR1ZVQm9EV3VtNSt6bFA3eWFR?=
 =?utf-8?B?SHlnVDFVb3hIQWlqa2Y2Q3hOSWtMSWhMVzU3T2xWT3ZkUXArakJ2K0wxODBG?=
 =?utf-8?B?SEk1SUw4RkJQZkgxZmRZQzg2OVZJTDdVbTZ1U1pzbDVyNWdxcUQyQWFQUjJN?=
 =?utf-8?B?NmdqWCtrNklFNjEveXpaRlhpQVNicTFwbS91NzRoWVJkbU4rem9qMm9vc1h3?=
 =?utf-8?B?S2RhS2FLVlhvWXZ6cU1pcDVUYk5hbmR3d1ZjbVBjaUN2WTRJSHFBejUybnNk?=
 =?utf-8?B?L2k4QUl5MXd5K0doOUtETmVIT3NxQXV3V3ZiTHE2M09oWjk1QnEvdWxxeXNk?=
 =?utf-8?B?ZkNwbTlRZkwvdjZ2bnIvWWVnT3JueWJKTDVJNDBsVFNieTRVeDg5eUJZT1NK?=
 =?utf-8?B?U2liMnpINHZiVnIvemttS0k1ZXloV3ROS1JyUHV1TjNEQjVlaUJ6a3NIQk9W?=
 =?utf-8?B?VGdrTXByU3JYcjFUSGdkeURJaUZFYmtaTXFWeE1uak9ySU5qV0tBbWNWTEpk?=
 =?utf-8?B?WmxFbzd2WE81YnNmNkxVcW50OEhGMWdTZE1SR0FNWDZwbmdMelUrYm03UGdi?=
 =?utf-8?B?OC9HNU5xc3dIcktEdFZ4bVlVNEFxaWhHa3dFaHRSa0s0eFZEVWQ4a0ZwZFlW?=
 =?utf-8?B?cllxeGRuOFlEZ2cyd2o4RzhnT1pxZERLclVFam1vUFdYZ2dpRHp2NzdYdmV0?=
 =?utf-8?B?ci94SEVCNWNDeEs1ZHFpRStCbHpzVTdteXVXRy9nWi90bTltWDNnRDA5S0Jz?=
 =?utf-8?B?dHhkM2RZMWlJRVlOZFdJcFlnVmdPQjZZOVFqeTBrSldZL1VnaWZ6UFk0Z0R4?=
 =?utf-8?B?dVUrMHJXNG1OdExSVVJTVFF1SmI5cFJhTU9TcjlXQkZOWDVhTkNiaStDK0Fm?=
 =?utf-8?B?elV1bWdXMXJWVUEvSG1rNWVJOWVkUmZjOUd6ZTVNcmNCYk5JS21FODhkTnBQ?=
 =?utf-8?B?dDhSc2NHNTdnRHJoWHYxWjRGK1VwLy9LTFR0elUxYTNFR3RVOW9WeHpyS1V5?=
 =?utf-8?B?OWl1V21hT2V1T2kzL3NVZG9FWGZRR0M1ZXhlbGpJRFRjdWFzeTd1eS9mcHhH?=
 =?utf-8?B?LzZ4djZteVlTQ1d4Uy9qYWhIZ3NoZXBpNXM1ekdhSEJZejJ4bzl5RlhubzIy?=
 =?utf-8?B?SW0rWkNTQlJmV3ZSYlZSd2tJQWQ2VndhZngraHNzUjJTeHQyWVYyb1VBZVFC?=
 =?utf-8?B?YjVhelIvWnhURUNtZnVNaGhaNC9vVEZ3Wkd2NXgxWERFZEwzTXlqMlQ5QTdx?=
 =?utf-8?B?TnZMNXQwZUlGMFo0OXA5WFBvTHRpSWY0YXBHTHdBeDBSRDNwQ2E0SGhBdXhn?=
 =?utf-8?B?SnpiWHlwS3hHbHZ6VnhBeGQ0dVFnV3IvOUdNTlhPNVJHKzAyVUpQUW8wc24z?=
 =?utf-8?B?VWJlRTdaRjMwbUVjd2doN3J6emhGc3VHUXIrR0NxSkoyanAyMGtsdVJDNzU3?=
 =?utf-8?B?cjFWa0lia2p1Sk9PNXRnNElFelI4R2VMS0dOTUNxVzBSVkJpZUUzMjk0akpB?=
 =?utf-8?B?NlkzYU12V2pMVEZWTEhDaEZYN2xkV3BNdTI2N0tybVhIOEdqT1l2cHVqcGd6?=
 =?utf-8?B?N3ExL251ZllmNVpFZHRiS1ovbHg1eWM3THZyU2daYTBwVjExdmNYN3FoWVFH?=
 =?utf-8?B?T2tkeFZLdTRyZ0d6KzlYSkVxT0VScmM1VyszaGZwaEsxSUdMK3lSVDAyR3F6?=
 =?utf-8?B?djlrZG16M1Znb0Z1ajQ4S0pEaUZRdFc3RWtaYlNBcnQ5bGlaenZkckRnUHdK?=
 =?utf-8?Q?H4dWjszMyZTm9rh+gw6UgR15wWiAV1pI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjM5SGZneDJ6Tmg3SmVtcHltaCtXNVFLYUdGYWV2Mm9sR3ZMb2lOajlqd1lH?=
 =?utf-8?B?TEl6MDhOQzBXOW90S1hQZW1EV250aHBWb3lpUmRML1R5SHVmSWdMRW1lMVpU?=
 =?utf-8?B?K3JjOGNQZExpK0MvQi9aVkp0K2ZrTWxNazQvNVNjV1Z5S0FuZEdzTTBYTWlJ?=
 =?utf-8?B?VTl5VEY4T1ZldVM2a1dtV0hMUU1yOEMxOWJjYjIvWFBNekNJV1MyeXYyWU5z?=
 =?utf-8?B?OXJ2amFEYXIyY1NlL29Sd3Q0T0FaU0lWa2FBNTFiQkg2eUxNOWt3ZVRxdFdC?=
 =?utf-8?B?Y2gybnRxU1RIbnYvZjhsRW5ZaGlhWGc2QmMwQU5ma1U2RU9aV0NOendjQWRV?=
 =?utf-8?B?K1NLK05mT2JKc3NyRXAxc2NFdm5GV3RWLytNREc1aXU0QWZsZWhvRVhzWFRk?=
 =?utf-8?B?MnpIekFiM0ErdW0vOVVoS3duQVFwQitMWFVwWTNrYnZCK3dJMXJVTHgzSjRK?=
 =?utf-8?B?Y2haaWNNNjNONkpac1VrSnVsSmYxYVRQYytHbTV5Q1NmRjZJTWlHaU1iUzdz?=
 =?utf-8?B?L21tVms2V2tkaTN2WitYT2h0MVB4WkdXbTN1cFBaZVV6WUhVOURJLzBBbjZm?=
 =?utf-8?B?NWE3QzhzWHd0enVOYjA3NENTUVJnWWpySUhRWFpYU2dRUWJFMVFxQ2l0VXhW?=
 =?utf-8?B?d2toTGZxZ3lGbHR2WSs2RTQ2VVdITEtPTVlOOEtqSGZFSndXSHBSUlczc3pW?=
 =?utf-8?B?V3g2NHZBK0ZVaS9MbjJKUnplRGtEZkNKMjJxQ08wcE9BSWtrNmxaRnh3c2Fl?=
 =?utf-8?B?WVc5TTlCY1IvNXhWSjJUdURmNWk5clUvTW9ZdmlSbVFDNDNWbERsRFp3OVZH?=
 =?utf-8?B?L3JZaENaSDdLMXJ1QlBMU2VscVkzTW9jaXVlblZ5eDV5UFdVSHBlV3pNRFd2?=
 =?utf-8?B?UmxKVC9DZlZJOXArdEM3YjN1UG9zcDFIM1EyM25sNmQ0cWhMU3hqdEZtSmpF?=
 =?utf-8?B?dUVuUkpYNVRGbXNENCtnMllDQkw5cVBjNnl0UEFWeXVtS0JsZi9QWGNRRUE2?=
 =?utf-8?B?RkIvcGc0L3JiNEFhNmdHRE40ckR3TFhYcC9uYVB0dWZQZUszVVdRSmhyU2g5?=
 =?utf-8?B?UlpTNzRuSk5pQWxmNG1CYzk3cFhyaEJpNS9VM0sxaEdHcXpBYzk0VEQweG9n?=
 =?utf-8?B?MEpwZ2R4alJ6QUFkNkM3Tm91bVBRZHFMNFZrc3FEZ2phMmxxSHBaOUJxOVNF?=
 =?utf-8?B?RXp6ZmNWNUNLYVpTUlFiNFA1cFZXcVFqVmZYMFZ2UDl2OCtUSkRrYjRqZmxi?=
 =?utf-8?B?SnJ0UkExZVZnZ0dIdENMSE5KOGZiOTZIaTJtSHRLNDc0ZGZVREtDNHpLQ096?=
 =?utf-8?B?UytMNHRYMVZ0M0tWMG9yUVZwb0JYaUhFUkdpVkk0MnFGRU44VnY2ZmlwYVNt?=
 =?utf-8?B?alBTd1RibHAwYVRER1VMYmdONDVDZWlXNEFsc3A4NWNuVk5jL2h3cjZpSTVy?=
 =?utf-8?B?bE5aSDFvT1lud3lzNW53OHpReXpHc3NjMmFHK3Vvd254d3F2ZmIyamJkc0ty?=
 =?utf-8?B?Sk04eCtybHo1ZnZKWit0V2VQOXRGRDRjQ2czVmJia3BCUWNCdXRXZzdZZjlu?=
 =?utf-8?B?Y0R1RS9YTUQyRHJJTUxZSGxCVjBldCt2SDhicXJRcG5WWEdYNHhrMzdndTJG?=
 =?utf-8?B?dXFpakhKWk41Z2pUZGhqVGQrTTNlaER0WkpnNFFGSmVmclVySTAvU3Y0WTY1?=
 =?utf-8?B?c2UzWk4wMG9LQVZYMkpvSWJQVWFtYjNlb2ovY3o1RG9MV0lpSndIZWxxYThq?=
 =?utf-8?B?b090N1I4b3g1dDhUVldvRFdDaHJ0ZUhaRy9wd0FScE1yREJrRGlGZWRMVUx6?=
 =?utf-8?B?UHA1N1BWdHRLaVVxTkdGbk9VeGVnRkx3TTllZ0p5RlQvYzFFUVAzQ2xQYk5p?=
 =?utf-8?B?ZGZSVEQ5TGR1UFp5SjJPbm4zKzEvUHdoRkRJbVZjY2JFSlVpbUswUXUzYjY3?=
 =?utf-8?B?cUJMdWp6cDRtZ1VVTTBmbXhnNDdTZWxUQkRzQzYwM3VxeGd4TGk5MkU1QXJS?=
 =?utf-8?B?SGdLcXkrUW5iZWVQY2d6eHQ0aG1HelhkS1RIdjhCR1ErMkdxWFhQWGRuL0oy?=
 =?utf-8?B?Y3I5c2dsUHFBWFVXdVRSNUlxcXV1OUQwYXVlMUlUQzNEdDdNMHo5SDBXTTRn?=
 =?utf-8?Q?RQ/ccJZ5LS2ZPYLfHssCelfPK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 930106d1-931f-46a0-4d46-08de08ed92c3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 17:42:39.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDTv4a6xqYYzhFcgqIKdNApGf4qpG7Sv+BOx921Bz6h8F7RtJK9QHPpBsusOrGGsVMeSFMmIo3bUQ9Czc8RQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8442
X-OriginatorOrg: intel.com

On 10/11/2025 2:43 PM, Adam Li wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bc0b7ce8a65d..d5ec15050ebc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10671,7 +10671,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>   	if (sd->flags & SD_ASYM_CPUCAPACITY)
>   		sgs->group_misfit_task_load = 1;
>   
> -	for_each_cpu(i, sched_group_span(group)) {
> +	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {

Looks good to me. One minor question, would pre-calculating the mask be 
better?
Copied from select_idle_cpu():

cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
cpumask_and(cpus, sched_group_span(sd), p->cpus_ptr);
for_each_cpu(i, cpus) {

thanks,
Chenyu


