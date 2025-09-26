Return-Path: <linux-kernel+bounces-834225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6EABA4389
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0EA18885DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957381DED49;
	Fri, 26 Sep 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtPezKNe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE91C4A0A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897078; cv=fail; b=e9FwEsjrHeZJ7zHNO8pCJqmZEbb8pxt4tkzy8IgwS0SUNT4yLYI8HXoHzlZAThyzIlhH3RFflLTSn0vsLSS4JkxLbo8BAQAWFjZ0W1k/SY9v4gCeEPg5YyK0UmnLaWtIGNZLff7c/Lu5NATMPSwklzFFz6d1bj1Vl3Xj2jxSRvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897078; c=relaxed/simple;
	bh=H3Ne9IcfxdtGa+L0tt8bTNohmgHy7MXfIh4K6Z79AyI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IjbD9FCTpXqC81PaQ4Zh5CcHlMDhHt4sqP1Y6b2Q14klsvsOqs8I63zJtjmBleRfMEYh5LNAQXB3kPBP2LHwhxIGwYhi6CgusTJGHymQ3eW0+A+DC6vvNvvN8z/EOKcf5VySfrCF4CQ17mCX6dY8bbYiKaJ1AE/fApCtC7w5LHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtPezKNe; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758897077; x=1790433077;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H3Ne9IcfxdtGa+L0tt8bTNohmgHy7MXfIh4K6Z79AyI=;
  b=DtPezKNebLCWZKIjqQ5JnJRmrEF9vh4Zt2aOEI9hDp4KDJ7gEG00+3Vn
   JC3OCKRlpJKgaryYQUWAjSiOzFFCo4bB2b8XG9eNWOq1ZHBdN7GqBXazb
   /NEpdnts8PTGCOvN/d80tyk3J7JsAbqtqtCDlucu1euLd5JZHCXRdY0pm
   Yz+njXlghYtmbzxH+ws1ex85WlyZ1+SS7zY+mdUr1nNiAjZZvCRUZw23P
   YoUWEPoVu6lq53SRqq8YIqfIuffAAg7+EMZ3g5jdXRddIaD4eyV/uURxw
   JzO4dm0ic+4a2oHH1rgFwFBG21J65rPRc8kYpSoVCNGjPWUPQlPMJS6AX
   w==;
X-CSE-ConnectionGUID: qKgik1+pRoqQZxlXtEcnSg==
X-CSE-MsgGUID: 9PBRrHC3QMy0RTL7uGhvwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61144537"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61144537"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 07:31:16 -0700
X-CSE-ConnectionGUID: G51M9a5WTuG82kWDDp7QfA==
X-CSE-MsgGUID: BAd4qv55Q1aiCNHSO4u82Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="182033445"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 07:31:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 07:31:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 07:31:14 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 07:31:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAvOZoRIUg2NQwDHHteuf9M3iDVD9ihDXuB4G5CW2Cvxd+uV4tRYNpK7HWDmjmjr0YDMf2iuNzRaiGFu30zjUlEeUQT1f0+OIQWHU6waGh56+XCh4BFTpmFs4L1w/Zj+niFEIq45giLaVOluQc9A/Bh5WFi0FftX5lPxkiqxYBNrl5rxcAarrXLFmhJ+ufxWah9MUHxggPTpySY+eRN400qG7y10/Dle5nRuCnEVhacIPkjAY8/006t3lqFnIRCodmn0IZ4Ch87MOQCmOW7NOtOLJhLiEs/hO1qz1CTNy3TPtdxu4DQIZsn6xJ0WVMRjVof18xjzUGEFIHXXCDsEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWeYvwfWwp3P+fUTJa4cBXTuJFkXNS+A/buMuvnijGI=;
 b=yENc3TZdHOQyuc2Lf7NQoIbeSaHOW+PWue5Bv+AiK82vDKzuiiScQfwSeWfdGQAxKORQVyvXazvIpc40itPPTxmdp5AQFeqfyJfY8mayuMJC6Js7+U2CltT6rYudMiH+1X74SHENHu4h2FoDVfG7WYh5cZvJNqcmguL4rkunXm9Q85nZ2knrF/+Mw1j+40N39I4Wnb8RWHBca3HnlGMpzKCmEUe9fJSANz/EQwJemRzGkMCSIgCWhKqwqyoOxt6yNHEIl81gfdQ5Du0cDKMy9M2Jx1aa/WVXQnlYzuO6eYsdZZKGCqtgVM13kGCFAStLWvdbtGIY0OSytu+MCJHqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB8738.namprd11.prod.outlook.com (2603:10b6:8:192::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.11; Fri, 26 Sep 2025 14:31:12 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 14:31:12 +0000
Message-ID: <ea4b4d45-0fa0-4be9-b6cf-706a1c9fc5f2@intel.com>
Date: Fri, 26 Sep 2025 22:30:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 26/28] sched: Do not enable cache aware scheduling
 for process with large RSS
To: Adam Li <adamli@os.amperecomputing.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Libo Chen
	<libo.chen@oracle.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, "Hillf
 Danton" <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Jianyong Wu" <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len
 Brown <len.brown@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <881a665a94858d4fb6f13491f4dffe58c8fc3870.1754712565.git.tim.c.chen@linux.intel.com>
 <3cb6ebc7-a2fd-42b3-8739-b00e28a09cb6@os.amperecomputing.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <3cb6ebc7-a2fd-42b3-8739-b00e28a09cb6@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 0869a2ae-cdc5-42e8-5287-08ddfd09573e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVFYc2VUZGtCRzEvOXpEUnZZTFByMStYSU8ydU5jdW1pWWp6YUNpK3N4dlky?=
 =?utf-8?B?N1p4V2NHbExsUkNZYUVRa0hDUHZQS2kySWlIZEZCRHpaTnAwbmd6ODViNUJy?=
 =?utf-8?B?UXpvY3lWWWVXQnpaWUNTMlF2bnpZT3dtMHorQWNSRmFjOHRuZW1Td3Q1OVJ2?=
 =?utf-8?B?TlQ2cCsyV3J0VTFRUnhTcU5UMjd1Tll0UlpXbmdRdXBEWGc2clU1ZFdrUzlO?=
 =?utf-8?B?eWNWZ2gzRU15Lyt6dGMrSjZyc1RKRVRkRmdabWV2bzJlelUrb1FTdGlPR3lt?=
 =?utf-8?B?MytBNzFnQVQwR2NRT3k3NmZ0VDI4T0VSMi84UFpPdnh2SVdyamtUNmJpbmM5?=
 =?utf-8?B?K3pkUjV6TVlKRXVVTGp3V2Z1S1hrMUZQVk53Qm8yaWZHVVYrOEZwU2xYT2tI?=
 =?utf-8?B?RmpMaDYyS1N2c2IrSEYycVVxeVEzUmVzdFl0Z283YWpXcXFCYUlwY2UvZTU5?=
 =?utf-8?B?Zkl0YTQ0dE50YXdnWDU4ZGFiY3ZrOVBEY3VsRlE1bEFtZHlBY041dmpkV1c2?=
 =?utf-8?B?elpvYkozeUp0OVpGS2dMWGdVUnU2MU4vV1hvNDRVWHFRVGJsUElWc01nM1Jw?=
 =?utf-8?B?c295Y0lFM29hRnlJbEszNGlzaXk4OG1lWVBQNFlrckZwL1Q5TlpiNGRlcXRN?=
 =?utf-8?B?OHBQanlJZnlOR1ZIVFV5cTVjZ3I0ZlFJRThZcjFNdzZkQUdnT21kei9GMkhG?=
 =?utf-8?B?aENvek9iTUlZdEhHRUlGblhFL1NtL05vNnhjN21ZdlFsTGlBRjU4eHl2d1ky?=
 =?utf-8?B?MDQxa2Y4K1FteDNjRFR5RmpKbmE2ZnJxTXQwc2dGKzJTT1o0czFaNjZVMVMx?=
 =?utf-8?B?MHRnakVPYXhHSE5hbjczclp6MVA2M2pObXNpWjlMR3NHK2VSV21nSFlUOHdV?=
 =?utf-8?B?ZksvcUJvTnFDd1JBWXNiNUJtWHpNN1dmZXZkaGl2MHJHdzMrUWlSckxkOXBr?=
 =?utf-8?B?dmpTS2MvZ2M3N3pXT3IzQWpkM3B5SGN5SHZQNEovS2NlN1M1dzBpclZZK3lK?=
 =?utf-8?B?VVZTZ3NhalZ0c00vbVlpSCtmMm41aDl4SVJ6YWVnWk5QQW4wbVZJUnRnYjJs?=
 =?utf-8?B?aENGdXRRM2hmTGszLzlPRE1YdzZBSEhIZkJFUm1rOWZXYUpxdjg5MEdEU2gz?=
 =?utf-8?B?NG0wQnhXeUZUSWQ4TzUwT3hSTStXdmNGN2lXeEN5NHdDZlluOTRQTy91cnZX?=
 =?utf-8?B?WmVCKzlEUVZYR3lMWXpvaWV1OEFmS1U5bXJmSlRhN05vNEJtNWppdjUwN01V?=
 =?utf-8?B?VUdEYXpwV0d1b3Z1ajBqSk5yaTMvdWpqQmlHSkNPbEJjanAzaVFITnhOSDZE?=
 =?utf-8?B?bkorcjU2OEI4WmoyQnlzUmRJaStnU1J5VFJpTFVRRG1aOExpOTVtQVdQb3lq?=
 =?utf-8?B?ZmdPS3N2WEdNMEVnd2NaUGhkendnN1Rvc1pRZFpyU0EzMXkwVk12Q2djd1N6?=
 =?utf-8?B?UGxvSFROT0ZaTVF0eGhWeFJ2cElNL3BYNGkwSjd5QW9xZi9TWGhpK0hZbFNT?=
 =?utf-8?B?R0NCajlNRnRSR01GbEdWNGoreGo2RThFRW5QdnFUU01QNWltVGYrbHd0K1B6?=
 =?utf-8?B?dDNlQ3hhUURWTlUvRWEzOUl6QmkzamdmMXlnWWpiTU5iL2xRSzBJSWZPRGUy?=
 =?utf-8?B?bnVzMDFFbjRMbnh5c1ZDNDhPcmo5WXBuNlEyRmxTS2ZlUEpxVkMzbFBEWGJs?=
 =?utf-8?B?dUx1UnZsL0h5WmJOVVFjVS9hU1d1bHd0NHFYa1FPUlo0L3g4UTdSc3UrT3JC?=
 =?utf-8?B?VjdJaStWU1d0aG5hZnJ0TER0OHpWSjQrTjN1amEwTlRPZ2FKU0pwUlFWV0hj?=
 =?utf-8?Q?wJuVgB9mYnvmNkg4BYLuc2LNA8/rPCL/aGMkY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di84ZE1DVG1ndXpsYzBCTzg1aVlQZmNzSDBTRk9GZ0IvdHN1dFZSNlZ3ZTJN?=
 =?utf-8?B?bDFtNUtPQ2t3c0ZhUzh4NjVacHErcXpkZ1NZZUFmZlVrLytUZys4V3o5VWRN?=
 =?utf-8?B?dlQraWZEa2N0clB5SkNPWHpiaHNzM21Mc0dyTE5OYi91Uk1pcklWS0dMV0lv?=
 =?utf-8?B?bFQwVzdraTBlZ0lIY29hMldmNHByMUF4MWNhdCtySG1mK3RkZmlkdG5VMnJH?=
 =?utf-8?B?VG1VRDJLNUJXaUxiWWRlenFmU3RJTDBMeTZpOCtVWkY0dWZyUVZKeWJlaG5U?=
 =?utf-8?B?YVlwbGUzMFYyUThtVWJGQWppTHhKVjlidTQwdEM3T0ZoZmlGeFlVenJWTCt2?=
 =?utf-8?B?SXRhWGNnS0lXTTRKTWZWdFVwcHdCMis5ZzdtWDhnamtDU0p6VHNZZlF6QVJK?=
 =?utf-8?B?dXEwMTNEc2xKUlNBVCtMekxxMTRla3oxZjhRdjY3UmgwblBHM2c2Ui9rdVdK?=
 =?utf-8?B?TGFxUUFZSTA4aHVFUzFiWTJQTzE4TFhDNjVSczg2WlJWcGNJeTMvK0Vua0RT?=
 =?utf-8?B?V1ZBWk9jbnpEb1c0NUZUR1Y2NGlDNmVwYThpVEVTcnovUnZQUDg3RzRCT1hO?=
 =?utf-8?B?Y0E0TExraW9wblpaQjcwNnRacDVjOTgvV0F5aFJlWW90ekI3dmZtQlFVZ0or?=
 =?utf-8?B?akgrNzNPU3diT09qdnl6WXBkMzRFQlp0bkgrMHpEMUNNQkN1c1BXZ0ppWFlZ?=
 =?utf-8?B?WVhGQzFEak9BMzNvRmVVWXMrTkRIVHpaMy82YkIxQ01lWFAyRmRvTFRJYS9P?=
 =?utf-8?B?Nkt1bUR2UmdNSDNaOVp4YkFrdWUxWE8rQ2d5TjFOUUFGSVFvY1h1d1VUMThL?=
 =?utf-8?B?SVk3TWFSR1RLZW1CZk1mWjk0Sm16eVc5STFTaXlEMi9VWlcvSnF2TWM4Vm84?=
 =?utf-8?B?dmE1VEdNdm9pL0daY3ZrMnlMaWYwdlZFOUJacWhseFhjaFFYMmIrQUQwdy9W?=
 =?utf-8?B?MTBHdkp6b1FuZjJVcmd4NkVXckxkdk45dThpTEFqUHJmLzlNV3Nnc0JEZDFQ?=
 =?utf-8?B?RzFnUjBQYWE3WHF0bys4SFZETWR0Y0o3UEdPS3pya3NQRlZ1R2N4L05GRGVU?=
 =?utf-8?B?TnhJTXk3ZWZHZlorRmQ3QWV4WnVZRm8zT08vVUZETy9aSVh4VEN3NEJIYlZ1?=
 =?utf-8?B?TVliR3U5Z2kxSnZSUFZNWDJxZWdkWkRpTnFVYWsvNlpFbndiT0JQaGtyTkE1?=
 =?utf-8?B?UXFhVnJHaG5LMUFrMDczMnhsSmY5bmlHdHpxZ2NwMU1iaFJNODRhZ21XdmlK?=
 =?utf-8?B?c0owWE85TEx5a3AzZ3ZVZUwvcXRZL2dUc2FZY1Z4NFZJK2lGZEU4T3ZwS2RF?=
 =?utf-8?B?RGpZelREeDRvYTcvbWdIa3pqUkNkMlh5TnN2QUhYNkdRSVgzV2k5cE5COVV2?=
 =?utf-8?B?TE1RMWw3Zm1kVnZySyttK2hFZ0hJMzgwaU1NaWc2b0JudHlGcFhXSWk5T20y?=
 =?utf-8?B?WG1FSFRhNGRBdkVoZmhiRkQ2bmg4ai84WVptcnpWNjN6L3hCaWpIdHNPWHJP?=
 =?utf-8?B?TDk2ZktSMnJWRzZKUmJKdklsL0sxRlh2R2ljUU9uNnA5VW04Q0tROHYwa0xh?=
 =?utf-8?B?YVQxS3dKandqNmthUUQwbUFWbXRMYnl0by9HaDlIOFVyQzF2SkI3ZUlaMTMw?=
 =?utf-8?B?U1J2NHliM1dJTExyb3hyUzBsbDJ2d2xSWG9oU2RteWxsT2w4NTg1U1ByNmZY?=
 =?utf-8?B?MDVKaGdIdnQxSmFkSXprNlFhUENYVzFWanZ3b0JuNHF3TlNudjR3dE8vclR3?=
 =?utf-8?B?Um13LzNRbUllTGFQUXMxSlQ0NjJQRi80aFEwRnBWQTNZZ3V5bnRmeDYzWFgw?=
 =?utf-8?B?NWRZTW0rS3dNb1l0OUhUa01vc01QVVkxYkN5Q1JlVVNyVS80a0JjSytsWUlV?=
 =?utf-8?B?TUFzTVo3SWFZME44VzFmYktaaHRBcit5OHhmRUttU0ZDUVYxWkg3Mysvd2dM?=
 =?utf-8?B?cUdvMXh2dTBDU3MyNmhteVdjT0pNZ0RpQlFycnNTWWIyZURyczV3QTdTS01w?=
 =?utf-8?B?ek44OXpJVHJFaFhiNWU0cmRRYU5oNk84alh0Q1lMWTVYcW9sVXZVb3Mvc3h5?=
 =?utf-8?B?V0JobVk0WE1wSTZXTzdKUG1GdTBFYkcwbitVL2pCd2trRDhiNUxoOVgvOVRD?=
 =?utf-8?Q?sN/YOuB0MTC+zzK+gB/do8yBy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0869a2ae-cdc5-42e8-5287-08ddfd09573e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:31:12.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHrjVxCa37YJwZ0k/6VJVO1EzahnjSShwhz4zmlDrI4+Pdp68GRnd82hL75L8W1/wYl2yWFdIMcMUz4GD09w2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8738
X-OriginatorOrg: intel.com

On 9/26/2025 4:48 PM, Adam Li wrote:
> Hi Chen Yu,
> 
> Thanks for your work.
> I tested the patch set on AmpereOne CPU with 192 cores.
> 
> With CONFIG_SCHED_CLUSTER enabled, and with certain firmware setting,
> every eight cores will be grouped into a 'cluster' schedule domain
> with 'SD_SHARE_LLC' flag.
> However, these eight cores do *no* share L3 cache in this setup.
> 
> In exceed_llc_capacity() of this patch, we have 'llc = l3_leaf->size',
> 'llc' will be zero if there is *no* L3 cache.
> So exceed_llc_capacity() will be true and 'Cache Aware Scheduling' will
> not work. Please see details bellow.
> 
> I read in patch 01/28 "sched: Cache aware load-balancing" [1],
> Peter mentioned:
> "It is an attempt at modelling cache affinity -- and while the patch
> really only targets LLC, it could very well be extended to also apply to
> clusters (L2). Specifically any case of multiple cache domains inside a
> node".
> 
> Do you have any idea how we can apply the cache aware load-balancing
> to clusters? The cores in the cluster may share L2 or LLC tags.

My understanding is that if there is no L3 cache, then the L2 becomes
the LLC. We don’t need to modify the code specific to L2-aware scheduling
because the L2 is now the last-level cache (LLC). However, as you observed,
there are some cases that need to be taken care of. For example, Patch 8
needs to be fixed so that it does not always retrieve the cache size of
L3.

On the other hand, if the system has both an L2 cluster and an L3, the
code might need to be changed if we want to perform L2 cache aggregation
rather than L3 cache aggregation.

> 
> [1]: https://lore.kernel.org/all/9157186cf9e3fd541f62c637579ff736b3704c51.1754712565.git.tim.c.chen@linux.intel.com/
> 
> On 8/9/2025 1:08 PM, Chen Yu wrote:
>> +
>> +	l3_leaf = this_cpu_ci->info_list + 3;
>> +	llc = l3_leaf->size;
>> +
> For some arm64 CPU topology, cores can be grouped into 'cluster'.
> Cores in a cluster may not share L3 cache. 'l3_leaf->size'
> will be 0.
> 
> It looks we assume LLC is L3 cache?

Right, but LLC should not always be L3, need a fix here.

> 
> Can we skip exceed_llc_capacity() check if no L3?

I thought we should return the size of L2 instead, no?

thanks,
Chenyu> Like this draft patch:
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1227,6 +1227,8 @@ static bool exceed_llc_capacity(struct mm_struct *mm, int cpu)
> 
>          l3_leaf = this_cpu_ci->info_list + 3;
>          llc = l3_leaf->size;
> +       if (!llc)
> +               return false;


