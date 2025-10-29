Return-Path: <linux-kernel+bounces-876055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E29C1A77D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E006358909
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3930A2673AA;
	Wed, 29 Oct 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLxS07N5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C68257858
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742115; cv=fail; b=I7AdyVVA4BVTHTUc3+Ybo/nIaZpxeEyP2Tm2Q76pVxbxaC5e1965kD/CV2W8pKtoeUdweTPsA6UI9aVqZz/eqNZwZUTtxMLFxncBn1BkJkyn2GsSLF/YGVCywC/KiD8wA1hSSb3AIxkLQ980o6OGQ8meXSIUr19VIK0cpJMJ+wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742115; c=relaxed/simple;
	bh=6dY0h34tSflz6cAnrZ1GmHIHMixkNP77EvweWVHnS24=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cPhLpVFoLwFt+Fwz/fD8MZG6+bY209iefr1p0P582wyharKg1FZ8Eyt0ysC6xt2KwLGryCxyfvB/clBs8zdjzQu29x5YaMxX4JMSEobfvb8jtTsLJ0/cPBfGJCg/cDN85hqeA9CW5qbSvT/MYwMtk00v2Yb0EtCRchdh1qu+ELU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLxS07N5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761742113; x=1793278113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6dY0h34tSflz6cAnrZ1GmHIHMixkNP77EvweWVHnS24=;
  b=NLxS07N54psMVn8PjhsKlNcn7ayOXOZP9KTb8xtWB55WmqS6E9UrAKAl
   v0V6Cayu6rB6plDYWnX6VJ0vSNa4KE8OmF7jEBLkeSDyHg77qjwXk2KhF
   gLUUTnXw1ejfmoInpEHhHnPge2zK810ymvBAueWbxQFv5UR7qGzEdalPL
   elRYKY/XXhSf2U8cy+tw/KfQtSD5dfv4tsht15baUNGTSw7SQVpZZUIsb
   FeJggO4FyA2I4cO4i2gfNifcrVar9JwxguOc+y3u6YwVt5DTcYzM2xO1R
   uAXdNkmTaZOh8pZvxBRC9yItZuatzhrVqSYtiI/Y/dTi1IaQ2w5T740/8
   Q==;
X-CSE-ConnectionGUID: aXCgg777TSSOp3Tsq+NRow==
X-CSE-MsgGUID: /7msAVEvROGEaZLsht4qWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="74978928"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="74978928"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 05:48:32 -0700
X-CSE-ConnectionGUID: 7BqL0r3cSaGEmvGftFqpGA==
X-CSE-MsgGUID: LxXRH13yS5eG/jQHuBG4tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="186405770"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 05:48:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 05:48:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 05:48:32 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 05:48:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhZ9GTzbrmuCU+hEe6GN6+SC9u02onscHJcqSdztun1zFOd8I5WM/6wNmcs+gyDSmrU4IkkPUiuN+x0qEsxAheSsieAxXpjwQO2h46JHWxwwkBxLUfmnE8iTPGxoJL5B3MXyZXr4q5XIzPb0aLe78b/gtuRi/Aq52d0Z05so2b1Kcwludu8cxKGhIMOjJppRh1AC0gcZPhNlQvZofBXNJl71AS+xq2agQwgCFE/mky2Szs1gLODcWH0Yd2l0d+4HQJhm2sriufpy/1fqWUROp3DmLDbZiuXkA/VZfqv1aFirGm3zWRgfUZt7rVPZnpe72TM7c3mQKG9WCTsnnwbACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHGxNh3KcKuKC3TuGnqgxxW3fpUcH9qpPuVlLaEX3Uk=;
 b=dbiYlopE9ZHPYRcOWBjQdqisZMi/t4niO/NOt83iWJ2XkhJZe9CYa6XK8p1Dlkgh2BQxlCtj97xBS9LjO/76MjjoXnGFoWBMDLjIU4o71x3y/YE6Nq3RFHQBDejMpjorUlgTLVpiuB2j1HlPEKVUdmksBWHWgWcFSz6f/qMnyig4qEXSYSlygQ8EHiDM8G/MqHu97rIGiY/dVYhJBO4sRUMn1XP+NTv9mzUxBi384rW0woOeLmyfqhCAiGEAt2+PwvYWfWeGta2/2YQ9eiYoPCuLoM0oXd/r+BPb2z4AmC9LsltR4CICDynfXtxIcp9ARN7R/yP7qOxiqTDrCs6XzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA3PR11MB9400.namprd11.prod.outlook.com (2603:10b6:208:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 12:48:28 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 12:48:27 +0000
Message-ID: <f218ef23-3350-488f-a0ea-eb902475021f@intel.com>
Date: Wed, 29 Oct 2025 20:48:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] sched/fair: Track LLC-preferred tasks per runqueue
To: K Prateek Nayak <kprateek.nayak@amd.com>, Tim Chen
	<tim.c.chen@linux.intel.com>
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
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>
 <fe5eeffc-ff8f-4bfb-b0a1-5b25731afb88@amd.com>
 <ab01cb87-71f6-4893-833e-136e7acd777d@intel.com>
 <094de5bd4f1b5cd4552ae024f9254df26c9e47be.camel@linux.intel.com>
 <522c6c09-9d07-4417-b9d3-925bd2224627@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <522c6c09-9d07-4417-b9d3-925bd2224627@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA3PR11MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ce91b9-774b-4a85-790b-08de16e974bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFFDMy9pK2phVERPd2lzdG5qbVd0eVc5L1JJeUtWQ3NPakE1dmRGdVNDVHZu?=
 =?utf-8?B?RXppQ0EzOEFkWWhIYkYzQzRXS05uTUY4dlZxbktDcTBUcmFLZndTVXo5bmpD?=
 =?utf-8?B?T1dpNXJOalM3RE42ZXVjcmRiVENLUWphTi83VXhyNnU4NjNpMHdsTHBrNm5O?=
 =?utf-8?B?amYvY0poOEtqeFdjeHZZdUREenhLZitMRGJJMHBNZzZsVWt1SzhoVkhmcmJN?=
 =?utf-8?B?VXljYXdMT1pVS01UcDIybWlYMEM5UWRZL3dHa2U5Y2kwZ0xtMDFDRmtLOVo1?=
 =?utf-8?B?VjNObmlJNTV3MUIwSDYzQXFwNTZmNUI3NGlkaGdRL3RISHFPN0ZmTmY2dU1t?=
 =?utf-8?B?cGxnQnJ2NTQ3YzAzcnp6YldBNzBlTVFYTHJHUjA3bmQ1U3pTczhONmd6UGVa?=
 =?utf-8?B?NTl4K0xaVEMvcGd4MmYxVmtFT3NKZWZHZmt2akpGSzRrQTJxRnFjRzdYM1Vr?=
 =?utf-8?B?em9NWXJaMEQvM2Q4L2VEdmZEYlpoSXhuYThSWm5naGZvMkRQYzJYN1AxbDlh?=
 =?utf-8?B?MVFXdSt5clhaT3NkcWwrdk4wbENac3dLeW8zOEt2ZFZ6cVRYZTA1aVI3MFNI?=
 =?utf-8?B?OCtVVzZUZitNOVEvSWE5SmpBNXRONVMvNW5RRzBBVmdvZFRSa2xUTlZwb1VP?=
 =?utf-8?B?a1R5bE1mRWtNTjZJb2pvZ3N4QXc3TXlLOVV5QUxvZVQrNWljUW9ZdEdSbjd3?=
 =?utf-8?B?bGdCY2hZSFlkVXQrNG5XU3lCU2RvajIyTTFMekFra3ptcDhzUUV4em8reG56?=
 =?utf-8?B?S3UyekljQVZqdFhPYWluUjkxaFV0eldCcktlWnFUdTJjYldyZFBvMHJlWjBN?=
 =?utf-8?B?MWFNSUNzOFJLNmk4MGRpM2R6dlBtcjlrNzBSVmYxY2FudFpWU2xtcEwvMDZx?=
 =?utf-8?B?MEZHOS9MdC9abGduM1ExdTB0VnczbXpSRFpSV3JvYzY0NEF4TWU2THJNMExa?=
 =?utf-8?B?RTBPUEYxR0ZVS1Nnem5LNnRIc0pRWUNZT3FrdWozU01wS2ZuWGtENUh0TGJx?=
 =?utf-8?B?d1huQ25aNGNmT3dCZWsydnVuNW96VW50Q2FONTIzWnlPZ0o3UURTNjdDRUQr?=
 =?utf-8?B?SDQ2a3JWNG5IdXNQMVAxd0duU1M0Ym54RWxaS1lTQThDVW13ZDZqWmhMcnp2?=
 =?utf-8?B?bFJhcEt3NjNEQXRMSTJQUHdkcm8rQzF0cjZvNHc0aUZCMVBlSVhRWDc3WThp?=
 =?utf-8?B?RERya09IQ3NkclBlMnpleGsvczdkUnp3QzlxRmxLSU4rWnkvN1lySnNjYUhP?=
 =?utf-8?B?cG5BWml4aStiOFYwUnUvVnVza05PbkRoSDdrRVN4WjJzUFNJQVFFc1I4TjI5?=
 =?utf-8?B?ZHMyVlRzU1VIcFp2eGQ3OTZQVTFHenRza0NkYUZ3THRhR3l1dE9FcVdyOVZq?=
 =?utf-8?B?cVZ2UmNEWUQvVG84amo4MGZZeStxNHZJNlpTVU9iSUd3eHg0RTNFYy9jeE5s?=
 =?utf-8?B?UCszSVpZaTVkOHlnNExpUkpjSFdnNlhnUG1FL1VVbUMyM0pLdGZzYktHSk1L?=
 =?utf-8?B?anhlcXFCZTVvemtjVldlM1NOeE1jMVVveHRITnYvaS9XcUdlYmNLaU82bGxT?=
 =?utf-8?B?N1BaNlVaWnliUFBNNzRRTHlENlZxRkVoemtua2E5bnBKNWFNQWd6bGpxYzhD?=
 =?utf-8?B?ZXUrNXJVN2xNd25sV1JycmptRVUzWFFTbCtvcVFKMEZ3UnpTcWNSNGVHSVFD?=
 =?utf-8?B?UTVsN2pvZzg4eXcyQlk0MzlJb1djc2ZncVkyN1FJRUJsSWgrQUx0aFprNFhU?=
 =?utf-8?B?Z2hMUUxwV3RIaHVHdU43WDJWQVFmb2lDWmRXYkRLOXNkREE5NGhRbXRZaHVF?=
 =?utf-8?B?Q0k1dGF3alJ3SFYrZFBaTGpjMGw5N2pLSG92eXdZVXI0bFk0YjRTMkhXYlpQ?=
 =?utf-8?B?UzZyRTNyYWlVUFN2cHZlN2RrdFEzMnpIc2lrYTF4UlBMVFAvVnM1UjB0THlo?=
 =?utf-8?Q?xl/3awOpaW7pyewTuMTtk0NE17xNDoji?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkdqQktFUG5uc3pUZXA5OFIwNXZUb1p3SmNjRkR6OUs4eU82M29MclEzS1Z0?=
 =?utf-8?B?cW0vckJwMkdXVFJnTkZvRmxHWHVJWS9GUllSWE96UjRZQ0g1aCsvRy9vZkFz?=
 =?utf-8?B?bjVYZEpyaUQ4VEpXL01uNnlWNktGN1FMNHBESXJDbUtTenhoZTNBN1BXaDlK?=
 =?utf-8?B?U0owcVgwbDV6d0VtQWxNRHRtRjhzOXpXdTU1ZngyMXZLQ290MUQ3RTdYc2hx?=
 =?utf-8?B?K3FEVjJjTTdERjVyeXZBSlVtZk5MUzlhT0FIaTFacUlFb29RUG9qNlZhYnFh?=
 =?utf-8?B?TGtXU3hqQTE5VUxPeVFkUmFBQndUc1gyTTd5MWx0VjhFT2k3aGRadXBDVWRD?=
 =?utf-8?B?SUR6V216ZTlMME56cWlkMVdiaHVRL25BcHNnd2dpbXJPZ1FuajhidXcyTU5Y?=
 =?utf-8?B?YWhtV3c0amNrdktPUjF3NFhBZ1NkRU1CMXBmN0pjN3J1cjNnL04vR0FueDFP?=
 =?utf-8?B?aFo1clgrdVU3OHgrSHNrTjhGUE0wUTA4SlFKZzIwY1I3M3N2Qzd0U2JiVFdN?=
 =?utf-8?B?YWJXM2VFNktUTml5S3l4SFlmMjUydHlUUnhLbDc5MXZibGtsNjJuU0hVeEhM?=
 =?utf-8?B?cTNGUmlGUVBqb2F2UjhPaTFpMjJhL3cyWGVlcnZnR3hiM1VPL09WOTI2Wmlw?=
 =?utf-8?B?UUlHQ2xIVXl5Z0hGOWNIQmhKSEswRVF4T1hERk9nVFlMelQraHQxbElaM2dI?=
 =?utf-8?B?YXdwR1poUFVUSzF6ZTdOVGxURGg0WDRveUVNbEovZUpkWHhaNE1zYUs5K3hZ?=
 =?utf-8?B?N0ZHOHpLT1Q1ZnBtVHdJNjFMY0xDZVQxZG1CT2RLZTRBUzB2dG9adHNpYnZO?=
 =?utf-8?B?RmVDdXZ0b09udmwzR291emlxdWx4SVVWd2RaS2FIbzYrNEl5YnpObk43QjBn?=
 =?utf-8?B?bU1mam55bVcxL254ckswN0hia0h4S0VqTTZxOWQrb2djbzhZRXhpOGZ1NzBJ?=
 =?utf-8?B?NmduRnh5R3FUR1JjbUJqcTF0dmhkUDJScnAzUi9FeFNPVSs5RnRLT29UNi9q?=
 =?utf-8?B?MFVoTStRalNZcXlIVFhQS0Z4U2NuK1UyNDM3UC9JaDBoUk0xOUxxWGYxVHVL?=
 =?utf-8?B?QzNxRm9nVXd0cGtNdktKQm5CUGFqNW45elh3TWxIU0xLY2l3ckVwNW40eHIy?=
 =?utf-8?B?bXJmOHA0ZmhldWRjcUJZRnV3NFc2d2dlYWx4aW1mWXl5SUVjS2Y1Q2UxV1No?=
 =?utf-8?B?R2JCNzNPWkNmVkpOM1Q1T1JHSWp5eHR0Qk94TkRUTStRZ2k3WkF1Ky91ZGNN?=
 =?utf-8?B?ZXJwNDFLOUJDallBQ1AxSGhsVTJBSWFobUNncjA4WEdlMUMxbnhmcU9kTjBt?=
 =?utf-8?B?dlV1d1V2TFJ2ZUxmdWQxRjErTmlwWjBENDBsdDZFOHFZMlJwNmpaME9jc1hK?=
 =?utf-8?B?OStJdkRHZC81Smhzb3c5K3pVTXVIcmNlMDN1Q1BBT1QybnhLcmxEMFhab2x5?=
 =?utf-8?B?Z3VoRGtlZlZ2ODc2eVRrWUtNSVl3cVBlLzRISFhBTmtpdHgwVmxHK0JDdjFw?=
 =?utf-8?B?SnpzaFJ2Y2VjVWZkd28rS3l3M3VxcUVvdGNSUlBZZi9PenpKQVFleERrbVhS?=
 =?utf-8?B?UjcvZFh0L2Q3dFVkVUhsNTNhRldyeHFIdzNOTnlOMHNLQzNOL3UyTVBhUkZv?=
 =?utf-8?B?Y0dVcnhpWWtQNzNNWnh3bFp2UENQdll2Zm9LVUpucjhnaVcyN09mTTBPOXox?=
 =?utf-8?B?V1lOUlRvUCtQbDVmZ3R0Q0pmaFRTcGREbjhkZFhiYlo0UFZqOFlBTjV5SjRV?=
 =?utf-8?B?T1RvOFBwcFpZV0lsLzBwMkN3Q2dlbHl5bXJIOGZtRW4wSTZPNS9IcjBpTXNK?=
 =?utf-8?B?Z3NMdy9MeG5JNTI0b0R1aUpkR0JKQVpKUnUyVk9ySlpYSUVoeXRJMGx0eFpJ?=
 =?utf-8?B?MzZFUllkeWdDdGhzN3JUaEs2eGNsaTFqNXlWbWFkTlVWQmNuMDAxaldibVRk?=
 =?utf-8?B?NWFoaE1Hc1Z3ZFdGR2FBaGRCQUtDLytHWjJiaFNTc21ZdmpYWm9pL3JyMHpQ?=
 =?utf-8?B?QkZtazcxcGpFME1mczVtYU8xU2pvS3lnSXhGR3lsUDBPWVF6MXgvZVJNWkRD?=
 =?utf-8?B?M0FOb3RyRlR2V3Q1M1NVRFlDYk1EenVyVlhMd2RzeXBLZWRVdm1lbXZja3lG?=
 =?utf-8?Q?rulTQvYF8WIVU63xa2sPaAhdT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ce91b9-774b-4a85-790b-08de16e974bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 12:48:27.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLaKeKtyssbZ5YlyJQ8J0PcfvVLa6EbK+rmezsDLZ+O1CrJmobivkyEz3pnzCQV3pca1a79+K8jeOHmKDnE9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9400
X-OriginatorOrg: intel.com

On 10/29/2025 12:32 PM, K Prateek Nayak wrote:
> Hello Tim,
> 
> On 10/28/2025 9:16 PM, Tim Chen wrote:
>> On Tue, 2025-10-28 at 23:15 +0800, Chen, Yu C wrote:
>>> On 10/27/2025 2:04 PM, K Prateek Nayak wrote:
>>>> Hello Tim,
>>>>
>>>> On 10/11/2025 11:54 PM, Tim Chen wrote:
>>>>> @@ -3999,6 +4038,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>>>    		struct rq *rq = rq_of(cfs_rq);
>>>>>    
>>>>>    		account_numa_enqueue(rq, task_of(se));
>>>>> +		account_llc_enqueue(rq, task_of(se));
>>>>>    		list_add(&se->group_node, &rq->cfs_tasks);
>>>>>    	}
>>>>>    	cfs_rq->nr_queued++;
>>>>> @@ -4010,9 +4050,14 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>>>    	update_load_sub(&cfs_rq->load, se->load.weight);
>>>>>    	if (entity_is_task(se)) {
>>>>>    		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
>>>>> +		account_llc_dequeue(rq_of(cfs_rq), task_of(se));
>>>>>    		list_del_init(&se->group_node);
>>>>>    	}
>>>>>    	cfs_rq->nr_queued--;
>>>>> +
>>>>> +	/* safeguard to clear the cache aware data */
>>>>> +	if (!parent_entity(se) && !cfs_rq->nr_queued)
>>>>> +		reset_llc_stats(rq_of(cfs_rq));
>>>>
>>>> Instead of relying on reset_llc_stats() hack, I think a better approach
>>>> would be to have a "p->se.llc_sched_active" flag similar to how uclamp
>>>> has "uc_se->active" and we set this in account_llc_enqueue() which will
>>>> still check for sched_cache_enabled() but account_llc_dequeue() would
>>>> only check for "p->se.llc_sched_active" to decrement the stats and then
>>>> unset the flag.
>>>>
>>>> That way, we cannot have an imbalanced accounting. Thoughts?
>>>>
>>>
>>> I suppose what you mean is to avoid the race condition between
>>> enabling sched_cache and EQ/DE_LLC, similar to uclamp:
>>>
>>>           enqueue(taskA)
>>>           // sched_cache gets enabled
>>>           enqueue(taskB)
>>>           dequeue(taskA)
>>>           // Must not decrement rq->llc_pref for taskA
>>
>> For this case, task A is already on rq when sched cache get
>> enabled. But task A's preferred_llc is still -1.
>>
>> If we dequeue it while its preferred_llc is still -1, it won't
>> affect rq->llc_pref.
>>
>> If we change its preferred_llc to llc_i before we dequeue it,
>> then rq->llc_pref[llc_i] will be incremented first.
>>
>> Then when we dequeue task A, we will decrement it. We are
>> still accounting rq->llc_pref[llc_i] correctly with current
>> code.
> 
> So what I really disliked was having reset_llc_stats() to
> reset the stat but looking at it again, that too is guarded
> by sched_cache_enabled() counter so I think the counters can
> still go out of balance if:
> 
>      /* Cache aware scheduling enabled */
>      enqueue(TaskA) /* nr_llc_running = 1 */
>      enqueue(TaskB) /* nr_llc_running = 2 */
>      enqueue(TaskC) /* nr_llc_running = 3 */
>      dequeue(TaskA) /* nr_llc_running = 2 */
> 
>      /* Cache aware scheduling disabled */
> 
>     dequeue(TaskB) /* nr_llc_running = 2 */

If we introduce the mechanism you suggested previously:
"enable p->llc_sched_active in account_llc_enqueue(), which will
still check sched_cache_enabled(), but account_llc_dequeue() only
checks p->llc_sched_active to decrement the stats. Then the above
scenario might be covered: dequeue(TaskB) will decrease nr_llc_running
even if cache aware is disabled. Another idea is to reset all CPU
statistics when cache aware scheduling is disabled at runtime, this
might also avoid several race conditions, for example cpu hotplug vs
cache aware scheduling.

thanks,
Chenyu

