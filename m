Return-Path: <linux-kernel+bounces-870769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC6C0BA42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4BB1899342
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD0212572;
	Mon, 27 Oct 2025 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLo8R5IV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB117C21E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530476; cv=fail; b=miA3yfej9N7madRXeCKUiVTzZtI2aMu2Nl/xqiqnYJ6TSxDQ6EjNFhAN/9Rf2DuvBHblcxmgTSU21/OyBKHDFPHZTV0PeUY3FnsNxgyp0XoATakyXqEbTraTH3NYbQ/exDR77ZQQccnc777AK4koBmr7oGXd1/hlk7TnOWPFzmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530476; c=relaxed/simple;
	bh=gkqty+WKHLOtzCML4f0u/Y+o8Pv5d829Gtn/Liv9E+o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iAMIiFy+pXK4HXnfK00JvqMKNpPqvWpqlE1L05B0iQ6sE7pDZwh4abIgEmEg++FgwgOGt025FsfewSbjEEb7VlvQDPkm9STRwwciLfScyrvHyBZa+VrOAoy23NrCbpc2Jm6bYA4cChsGHJeFfCx3YwEJNK5OMbbTutSUKydBseU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLo8R5IV; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761530475; x=1793066475;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gkqty+WKHLOtzCML4f0u/Y+o8Pv5d829Gtn/Liv9E+o=;
  b=GLo8R5IVWciCJR0muGfTuQRnai2MUVgYBSzRAW+lrQ1CFCJjXoyyIbcj
   SvNI0515hdDyGvou1TP8rgR7h+daNKUx/BdWDS2hE0iRqBIHOWV4DI4cA
   7sy0E5myHlNRii74kystWAhwGb67JewQ8BTgfvKv0sDjJm7oDL36zt0H4
   u1rSS33Tw0GGjnMVZfzP/8xFSBCF9rfCoMVBPzVTZUvnf453dTwVazWgQ
   RMic7EWhElG//ewGiS8MXv4g38/meNcf/5HZWfjLIOB6iQLvn+acv6Rl5
   XUhSHtRYR3xzBkYNKwhl/nK3aYtMBMyxSPKUNAIAlT2OGyhU96/Fs79Lr
   A==;
X-CSE-ConnectionGUID: WUdUE0ISRWG0l92MT0/rZQ==
X-CSE-MsgGUID: 0ZB84kELQdmfJcPa9kKOjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86236694"
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="86236694"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 19:01:12 -0700
X-CSE-ConnectionGUID: 1WjF8b5nRdyAhX3nhG/p2w==
X-CSE-MsgGUID: agx9iFCTS5+TxQGRf+q1EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="215817338"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 19:01:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 19:01:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 26 Oct 2025 19:01:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 19:01:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nka6KiR7fVJyZvynU21ZrrdzJC7dj2pNuzbh4d2hDjInwaC06YW7mtMdSxn5GUDZDBcGzjT6ctO4OcFD7egXnV5gtX9Yrlinfy+XRoNJ6nvaLADTiwWp9NKaOJ+WNW4Dzg3xQ04pmuKv6Vm5qzB3YgkEokoKuXaDKMRcyjZA2tNXfPBtP6x/Q42CMICYXKsCCkOmMMJl9sU9v9fSfMtvZp/UOZqJz44bB3cLFvNTEIDrZkxG9Js9YVs8e7l2zB6Kqukt9g8LhABuVg5WJuMm4F630M5W2cj3G/RD9QMw2faSmPvyHIljMMctKMMSrAt4R0yKwN5VJ0jq/ya/cVkxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMvS6ZBoF/ICgKLPiqZ7OOaIW78kGdVqT5LatUM8l/g=;
 b=yOnYyNz53CvXxNEgzu9/25KuWHugH7BG0eEqMiywtEj8bOFt7kvZoFJ1x9kKp/HHWHSS1xpwO4MUOkW7ZWJ2UefOaExTGoxeY3x1U/4BhoFbYerfgOveiHsapYg6bceCH9rEFBq3sVXbsphl1QRl/v6abZbFYDR/2I6QvlpIgVVZ2pIUXVzbfdaRmn18/7xuQ8V3uL0PI0PZOyfuuHaWeMp+Uaj/BOYQgRRJ6MUOkI0RPpM/PgM+RgH1pCzeggyeyBO89cZbFo3rU/7il7bCkrkUvq2/Jgzrj+0nW2XSmKozCrDAE9ILJ7qIUI9GzFhEtwjogfM65TcIvbBcrW92lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.17; Mon, 27 Oct 2025 02:01:08 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 02:01:08 +0000
Message-ID: <cc8284e8-c8f2-4f2c-bcab-4920b80a5a87@intel.com>
Date: Mon, 27 Oct 2025 10:00:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] sched/fair: Prioritize tasks preferring destination
 LLC during balancing
To: Aaron Lu <ziqianlu@bytedance.com>, Tim Chen <tim.c.chen@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Jianyong Wu
	<jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan
	<tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown
	<len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Libo Chen
	<libo.chen@oracle.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
 <20251024093258.GA1630077@bytedance>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251024093258.GA1630077@bytedance>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0077.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::6) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DM6PR11MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: 46aeac2b-297b-4fe9-7113-08de14fcb198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REdSdmZDSVZ0bzJhUU4zNlFPQjlnc3dtdDJyWlpHUUlFQ2pWdVNvWDhIeS84?=
 =?utf-8?B?US9lRjVncUZ2eG8rRE9WRy9IYXFNbWl6V2hsbXgvSVJwUTAwT1UvM3p4K3Br?=
 =?utf-8?B?Ujk1SU9IS3Z1c1FnZlczWEZFbkZQeXRKNXlvMzJzU1JLM2F3enVGMmN5Mjhw?=
 =?utf-8?B?cDgrL3ZqbVU5RDJBekVmbHJkNUh4dm5IaVNhd1NZbGltV3BibEFhSi9aci9i?=
 =?utf-8?B?ZTlrTjZORGw3NTNQYmxMNWZGcEVHVGN2NWtFSlkrbzVIVjNvcE9Rc3FBUUtX?=
 =?utf-8?B?VENYNmt5VDhxbklMd1Rwd3JuSVJxREV6a0ljMVh0UERFMGNjeDBrYTlzRFJL?=
 =?utf-8?B?TGhYQTFCRFp4ZEcvWG5KTTFvcWVxbmI0b1JkcEd0NzZZU2U0NnF5bDZ6RStw?=
 =?utf-8?B?MTBheGFuMXRWeC9JcXdEWHZBRWxCQzk3ZWZpbjc5RDlGOWJFY3YxUlp6Y0o2?=
 =?utf-8?B?aWhHejRGT3h1UWkyUkVtMDIrZUxJWjdwRmppZmVUWWI1SHB3Rlp2aEY3U0tS?=
 =?utf-8?B?RmovQ3NSeUpNS0JtRkpXV0VlS1BjTmVHb3pSVG5Nam9DaVpUeE1XcEY1Si9l?=
 =?utf-8?B?ZkhXQnd1ODlJNCt6MjQ0UVRpTFlHRWZEbHpVTHkrM01McC92SzdqaDhTR1l2?=
 =?utf-8?B?RnVZNExhc2dLdVBqZkk4dEg3ODNkeTY1Mi96SnVQdTNaay8yMXNhakM2eVl4?=
 =?utf-8?B?b3RSbFpDZUZSL0tHNTl3ZDFQZEZVbkVnVnFrQkVHeGRSZ1B1Wmo4TStVWHEw?=
 =?utf-8?B?aFN1TjAwZ2g2MzhETXhVWHp1OGVuNlQycmZ6azVSZS83NzBCc01lQmFnNjhs?=
 =?utf-8?B?Q2VpV2RRbDYreFB0bjl5c2w0bjJDak9CV1lVZFJWUnk2UVRoWC9JcDVkcFdy?=
 =?utf-8?B?dGcxNU40NGRJekp1b2hTKzlRbHVZQXdGMVUrZCtMYW9vQzdSQUFxQW5vQU9H?=
 =?utf-8?B?UXpNWFhQNjJhdUhXS1lBUHpQYUpYYURINkUvSWZDUzNjcTR4NXdZazlteDZq?=
 =?utf-8?B?QTRJWVZ1WlB3NDZxNHRLcXd1OC85Wk1NaGV2NVNrb2VGMHIwTE1ueDZTNGdp?=
 =?utf-8?B?d0xWclBLTnl3UEQvUlpMbjFUNXJ2RUx3ZkFXd2VMTW8yOExGemtQNWJwN0p4?=
 =?utf-8?B?OS9jcHpIUmc3T0hma3ZVK3ZqaHB4Mkpkc1k2V2IrdnNDN1RWS3MvNWhzZFlG?=
 =?utf-8?B?eXdOSFdRNUU0cUtIUitMV3pCdHRuenhqbUg1Z1B6SHNyWTNyRzNCRHMzUGlH?=
 =?utf-8?B?Z3ZJM3I2MytBbC9ZUjl3UjJWdHJvdlhzNGhrN1RlZWNzdVQrcGdPSmt2cjBY?=
 =?utf-8?B?eWdRd2tSZkhBVDkvR3BzRldkamJHVy8waWsyZlVRdlR1VmdhNXNTMWovU0x4?=
 =?utf-8?B?dHRodEdQb1RKWjhpZ2xaNEU0aHlrM2pYOGl5ZkQ0dnMvdnlkK2pGSUtrUkxI?=
 =?utf-8?B?WHRyU0hFalN0MlNRaWtPanBBalArN0FrZk04WlhXWlRQZDVYZkdpSy85OGZI?=
 =?utf-8?B?Um4xZGNBbnFqaGFha1RiREFsa3BJNUVXeDhzU01FMGxRRmplY1k5SW53Zkhp?=
 =?utf-8?B?MU9QdUt4czBoM2lWMW92bzBGaVdZNnk4Yy84NmloVFB2VXJNMDRjMlFZUFg0?=
 =?utf-8?B?Nm9NdWdiQTRWYTdOSzNtU09VZEpKWnMrMmI2U01Lay83TkYwM3I4NTFqS3Qv?=
 =?utf-8?B?eVZsRHRiREpLK1BZZzVjdzZKNjhJaHJIVFQ1Wm5UOERCYlNCMU82OWo3T0Yr?=
 =?utf-8?B?bFhHY1FGUUg5dlZXc001RXNUb29uaEE5cnBGVTJtOU43aDltS3ZjeGFZWlRm?=
 =?utf-8?B?UjFTeGJLYXJOdVA3NXpVYkNrK3ZjU3RBb2NUVFpYdFA0V1NCWnExVTQ3d2ls?=
 =?utf-8?B?RzR1a2pYZ3NKWFA5TXpJOEJZK1RTSytZQm9DeGxMajIxR01GVEl0NmNESHJT?=
 =?utf-8?Q?sdw/zUny1+9hBC1ME1qH0Ij/wksRJC99?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WExaTnUxUGhzbDJYWERRYUdRRVMrbUhacU5CWmcwQ2ZtQk1VMGlsQjZWdVll?=
 =?utf-8?B?TDJtTXQ3bWp2NVhBN294RWNSTTk4Y2Z3bXNLeitWc09WeFgrWmt6U251c09F?=
 =?utf-8?B?TzJiUUhVaERTN0dUOEZDRkhXc0VRQlFGTzJ0cXZFVENsZWp3V2xrUVNTc2Ir?=
 =?utf-8?B?dHNHTlJxalA0UWg3bmZXRjIyV2dPOGFUV2huVlJGQksvREZDeEV6ejVrNk5J?=
 =?utf-8?B?UzU4aURyT2l2QmtpSlQ0Mk1XbGNUbFZnbGhjc3dsVjhXM0h3WGNVRjF6MWNu?=
 =?utf-8?B?VGVQc1hrVUo3Y25wZ3QyK0s0WGpzVzg5VHN6dS92T09KaHcvYzVQaGlEMXhO?=
 =?utf-8?B?Q2ZubXE4L1JmaTdIdEFqd2NHQlVkSEtqOXlPcTR3YjVnRS9RblcyN1I5TDM0?=
 =?utf-8?B?WmluaS9WTkx4QWhBU2NKTUhDVnZzVHF2cmZaNlptQkdwWW05bnMzUzZrb0dX?=
 =?utf-8?B?TE12TlQ2L3kxVHVmRGNSdVRGNXBqUlE3d0l0VU5ESFcxUkw0c2ZXODRGYndi?=
 =?utf-8?B?dUp6Q3V3dmFXaEdGWWl5d21Nek5uU29GN0VnbkJjdDJVVTlhM05iNnNxV2hX?=
 =?utf-8?B?d0Qwb0ZEUjlmV1pDSlVGNGdaZXQwdVlNV014MnVUYXgwL3Z1QkZOTzdsRnRC?=
 =?utf-8?B?bHdCVkZWa2VIWjA2WmlSSkgyLzkxZFcrTEV0RmhsOE54VnZ0MlduaTBmM2hK?=
 =?utf-8?B?WXA2bWdpWDBoNGZBdThpbGxQUXUzZVhoa0hQeVJINEtiTXRrZlNLc3hMenRj?=
 =?utf-8?B?d2dab21BYjlqNUpqTUwzUUphMUw1YnhQMUFtYnZMcHFCVjJWK3JxR1NtM1RJ?=
 =?utf-8?B?ZUhhMGRrN2tzM1hIL3Z6N3NzRGR3T2tLVUE1M0VjTkZuMzNxdUJFN2M0dTlE?=
 =?utf-8?B?b0FBVllTa21WZXYwekZlbWhiZnJ6Y0d5R0VKSXdXaEkvQWoxTlZmSE4rR2R0?=
 =?utf-8?B?bXRkaVJvZENqUVFNY1E0VVorUnVod3BRek14NXY2clVnSTFnY1VGTWY4a1hr?=
 =?utf-8?B?ZlF2U2t4LzlxWDBVQmhtUE1KM0gyOHVqUDNITm1nZUNITmN5S0t3SXRqc2g2?=
 =?utf-8?B?RU9HeXFKdm1uczRDd2FLUktzWk02NFpnNDluYzNNVFZuTzFTUkp0NTZLcTQ1?=
 =?utf-8?B?YnVqSm94cjcrWHlzTlRrangxZzhucjV2dW4zSXBjMXVsdHNreEptUDNTM1cr?=
 =?utf-8?B?MjVtSkNaUFVFMlpPTktITXhWQlM1S25XbzZUVzJTK21oQm9HK3krcklJc1lr?=
 =?utf-8?B?MktjbTNnc1Z5d0NwSHMvTG5LSmpCZHpFVk5Rcy9HRndsTEtabWZNUDZtS1E1?=
 =?utf-8?B?L2xabFlGVFRKcnBTU0pBWGhuNm5FVFE4VmVMMGxCcUFsTVAxRXdsMUZwTHFR?=
 =?utf-8?B?bGNIRk13dWJIMmt4SGNLZnZhNE5MaWllTWYwTGdOay9sSXBaL1ArcEpSSXVP?=
 =?utf-8?B?Q2pUM0RLeXpETjFVdHRPTmJEa2wyS0x4OFJMZmZudmo4YS96U1VRZnZwVlRs?=
 =?utf-8?B?eXhHdzlJQmU1UVlaSGJLaWVIWjNwNGxXaTM1THNxSEYvaDhKY0NMRW43ZkY2?=
 =?utf-8?B?NDdsVTU2T1JvTzZpdmcvMTZ1bG14STI0c25iaEdTRnBBMGZwL2w3TlU1TGFC?=
 =?utf-8?B?RXdkdTlVWU85RDVCQ09KbVQwbGwzSUdSZnZQR2J2MFhNcUZQZ2tFN2x0d29u?=
 =?utf-8?B?YzJMbnpPakRic2s2dHFHNFEzUGc3SWIrY0R0OS9ZdWdidEducTlWdXJpK0Iw?=
 =?utf-8?B?Z0l4M0Q5cnUzUHBoNkdKdXdNbzBvSFErclpmM3FKZDZUOVJlTVJzbXN2V2Fx?=
 =?utf-8?B?VndFL2dDUFFhWmtEZ1FBZDFyYnR4RVhBWGJMTzVRaThVK3JCTzcyWktPZE1k?=
 =?utf-8?B?SnpDUi9RcndoUHpwRlRNZ2xZTkJGWk9TOHhPQkNMR0RMYy90ckZVL1VkTHdP?=
 =?utf-8?B?aHJwQ1M2Y0p5bFF4YS9tOEZDNjVOQ0JSTUh5S3E3b0R0bXVwMHhaUDQ1RTlL?=
 =?utf-8?B?SFZNdUdLY0lGSW5Iem5SeXJsKzlVQVB4U0MzK1RUVnBrK044OEZRYUF0dDdw?=
 =?utf-8?B?YjB5TTV1NWtESjRBb0pIeDVOeHlPY2dmcEovVTBQbDB3aDBGbWV2NjdpOTJR?=
 =?utf-8?Q?iIKwnjh+OTRe3GAzZgnn8Rzk2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46aeac2b-297b-4fe9-7113-08de14fcb198
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:01:08.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hRPJXmyqySJ/iOQ/YMqtv+EJqcErii0yy3Xzn7TeBHoROTUw9fP5/70BXm7u9UM9+ENsJXvCOxs05dANsXVHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
X-OriginatorOrg: intel.com

Hi Aaron,

On 10/24/2025 5:32 PM, Aaron Lu wrote:
> Hi Tim,
> 
> On Sat, Oct 11, 2025 at 11:24:47AM -0700, Tim Chen wrote:
>> @@ -10849,11 +10849,45 @@ static void record_sg_llc_stats(struct lb_env *env,
>>   	if (unlikely(READ_ONCE(sd_share->capacity) != sgs->group_capacity))
>>   		WRITE_ONCE(sd_share->capacity, sgs->group_capacity);
>>   }
>> +
>> +/*
>> + * Do LLC balance on sched group that contains LLC, and have tasks preferring
>> + * to run on LLC in idle dst_cpu.
>> + */
>> +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
>> +			       struct sched_group *group)
>> +{
>> +	struct sched_domain *child = env->sd->child;
>> +	int llc;
>> +
>> +	if (!sched_cache_enabled())
>> +		return false;
>> +
>> +	if (env->sd->flags & SD_SHARE_LLC)
>> +		return false;
>> +
>> +	/* only care about task migration among LLCs */
>> +	if (child && !(child->flags & SD_SHARE_LLC))
>> +		return false;
>> +
>> +	llc = llc_idx(env->dst_cpu);
>> +	if (sgs->nr_pref_llc[llc] > 0 &&
>> +	    can_migrate_llc(env->src_cpu, env->dst_cpu, 0, true) == mig_llc)
> 
> llc_balance() is called from update_sg_lb_stats() and at that time,
> env->src_cpu is not determined yet so should not be used here?
> 

You are right, I think we should check the candidate group's first
CPU rather than the env->src_cpu. Will fix it in the next version.
Thanks a lot!

chenyu
>> +		return true;
>> +
>> +	return false;
>> +}

