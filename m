Return-Path: <linux-kernel+bounces-871613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7490C0DC7B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9144C19C17B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993C42620E4;
	Mon, 27 Oct 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhkFU74L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF391C1F02
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569819; cv=fail; b=sKnPLd8JeBydFsIc6GLZXu3LcyNUKcwRZiigsTzT0nF3gILIJY/n1ftRBETx2hjeh1SaHUUWiICfBInXlfQUcN1WpBhNNbaQP8HfmgDvYLQ8ua651/4MeNHoNg/3e7+06arwn6Ru78eYYUYqdNCtXDxoFqadZJt+wophFs2I6Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569819; c=relaxed/simple;
	bh=h45ZQ7frLJyLqZhAz+YlKE48VCRkXgY4+CG9XoSTQiE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jtt2q8CV1mRjPR3dUIqyJtf3rE20BEq7XrVJvezVN/ZxwTtPoT0vK74pQyJobts/NPpJGnJtpSWapb6KBgMJZVfFmnoRlscJy0UF0t+zgqmK1eC2thYinJPfCZpNWGDGZnuWD6dcL/b8LPu0+S7KTDIIDr0TGuIgL0zOpnJ/+/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhkFU74L; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761569818; x=1793105818;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h45ZQ7frLJyLqZhAz+YlKE48VCRkXgY4+CG9XoSTQiE=;
  b=UhkFU74LKTQRG2VENNnf/WOg+yg9uX9e0D37Hz+eYZ9cjRFjQbnskFgx
   iBgsHYkgC4a2s3gazpqxEzxZBjlXiu+zEElkoW53Qx6uhUtgKlFtZWnhx
   ANMia1NGbl2FE3YggmH70TuvKX/ZBQo6uYNtxnZ+MIoCS+vVwN4r5l6JU
   OpKQrQuGbFkDLNUs6vphvqcePE+AMT5VuV8oGYl7Q7cTy4owR8BuOchrm
   IvnjoiXwiO4D8SllEenqc7jzW8xcr7JZlFwTP5a70MZROpQbn+37wT9ub
   IO3fR7UwkrBrUiMiZOSVqJuA95Fd/13CCgbrmFQSdynt2mHsXlv8RLL7g
   w==;
X-CSE-ConnectionGUID: kStSzTK+R/SwkdEhHzr/cw==
X-CSE-MsgGUID: iB5aZlIhRU+2Jo273fSx8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63546466"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63546466"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:56:57 -0700
X-CSE-ConnectionGUID: BEdidmAkSYGZzMjKphFFnA==
X-CSE-MsgGUID: 9rbNRrp7RxqM9GpeMr9c0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="208650790"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:56:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 05:56:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 05:56:56 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 05:56:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1DuSU2pzK5yrWFg92Khu6e16c3Wsgk7sxGqGPdkpXs+LGIRnzE0Aqw3rPYTRESVV/7bDnYgeRpnTjGlgM69jiyz0AjJAENtOArCXtrkFq4SEGRHhN+fM6/ucx2sYpounqjXsLg3nESACvgriR77hKkcqNao+n0MOsXNFGWsZD7SWYlAXdVfiNetTb6HmhXHR6D9eGTmuSLrXLbyFAmhwd5dhxiDRDfZGvg/FUnkOYJfJgBZSl+idbArboZyI//+Wjn7ruGUja0CjeyawdUBnSsrN+7T3saJU+0hroloM684BUUL0PI5bs9FxHz3QK3n3Ex9MaustLAat/d5jjtjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJVLfL6fk76AgIxVtBcxaLPp4lP7KNRoXIHNPlDi9bI=;
 b=Bhh7xD/XzKnhs1B1oayNTgvvjoqyKk4M0gqmPDNRVMheQGTMkQjYg4SdXOVwmVbPxRbtl5bGb/3+B2gjrfEubCEzuxZtrg/h0nacBwmX414uegYar2BD/Hrv7pLCwXrEnkx3sTlRZ97oGj3zdVilD3mFwgAzcpoVBzov30/7trMdldtQ+lasS4YsywvLe/+e7rT6FUred+GMeD5+3Xtg9Ksk5QfIaiHF05xkH8LGhUZA+75wm54ib7X1nB+9x6ITkNNDObp3RJWaqQUfwq1SjHY0gmRVdV4nPTNDkSsk6LPsNxdXho8pvvOvJGqEg2zWOzmugs07vNAKjB4O7A9r1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS7PR11MB7690.namprd11.prod.outlook.com (2603:10b6:8:e6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Mon, 27 Oct 2025 12:56:49 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:56:49 +0000
Message-ID: <ebc82974-7fe5-4e9a-8dae-7964cfdff471@intel.com>
Date: Mon, 27 Oct 2025 20:56:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable cache
 aware only for multi LLCs
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
 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
 <7ff17661-05fe-4137-b7e1-c799fe318c9f@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <7ff17661-05fe-4137-b7e1-c799fe318c9f@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::15) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS7PR11MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: d04b309d-f0f7-4864-e81c-08de15584ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0RRN3JwdXhMRkVPZnJJWEhUeGc5TjFyWGlZdEMrT3pIRFNUZHNwM2ZPQk9I?=
 =?utf-8?B?WnZzUk5EOTFLOWVXcDZYLzlwQzAzbXg2V05ZWFBhSldVdFk2MFpqOGo5N0M2?=
 =?utf-8?B?cjUvRlkyRUdHVzRVcXFGekJsK3htRTV5bnFhMS8yVVVESmZzRmFYTjRSQVJ1?=
 =?utf-8?B?TnhGTGZ3MmhMdG5TckRHQTkxNFEvRjJsbThlMHJEdDdWVzhsc2ZHTUZMZFhx?=
 =?utf-8?B?cndUcmROZSs3bFMwM1BIeFBZdVZ5UHRZMzl2RitZcFRKc3F2bWxzdmtsZGQ1?=
 =?utf-8?B?dnN0anRWWmVMLzlKS3dpNjV4MGcrbEp0alNTVUJidTJMVitxTWgyN29Da0lS?=
 =?utf-8?B?VWxXM3FMRGRLRlE2dnRnZGcxci9sMHdUdWd3cENuYVl6L2xsbGNaZ3dmRnVk?=
 =?utf-8?B?VXBNMWRpOGJnSWViSm8rRll5QmpuejFhM1VQc2JRSnpMeWd0aEZrc0VTUVRr?=
 =?utf-8?B?aXJIMVNsVUFrUE00ekMyRlNNSjBWSmlaVjBIdW1LaTI3RFVlVWdjd3pnaFdw?=
 =?utf-8?B?SFN0Zm5ac21zaEx2N2VuOVdiaVdXTmo4aGUrem1QSTAwSHZpN2lRN01SM21O?=
 =?utf-8?B?ZkxwV0NXenRjaUVsQlhXaW5rNjNKYmJzZmdFN3lOcWcyZXpLaTRIMHN6Z0ZG?=
 =?utf-8?B?bzhZZzltK3paU0J3S0ZqRms1Y1E0NDZEbDdaNEo1VzBLWENNaU4yMEtERjE2?=
 =?utf-8?B?M2UxbHVybVNBZitud2hTWWdZUmJZMm9ETVo4ZkN2Z1dtS0UxcHFmRENFRk1r?=
 =?utf-8?B?d1FSdWNrUjN2Z3MzVWIzbzNwaS9ySjdKMVBpNjJlNlRhYUVaY3Y5OW9ydVBW?=
 =?utf-8?B?V1hCNDBiSXhONWtEdGdESGhPMzNtcWRBSmxIRXB1a1RjdytoZnJvNEdKZHgx?=
 =?utf-8?B?bjc2cEpEdzNIYzdqbDhzU0JyYjlWRGk4RnNjbi9qZ090bUdBVlUvYi9xNjk5?=
 =?utf-8?B?ek5zdlVyNm9MdzJjWlBPaHZMQW9OMDBBaTl1RHkxRTA3WWwweVd6ZGEyVkZ2?=
 =?utf-8?B?MGVoTXF5RlduTUk2ZEhGY2U3RjlCalQ2cTRiTFJrTW5LQ0thOEIzMHNJUHZa?=
 =?utf-8?B?MnRsVjh3VFdkWVN0aXNJbGVRZkMxbE0waGdsRC9UWUhFUWtXbENsUDIzSTJY?=
 =?utf-8?B?R0YxUTIxaTByR3hESzhPT2JYZUljVjZLUkM4aDFSamJsditBZXdlcW0wVHFp?=
 =?utf-8?B?a0Y4VzgyVzBQUHdXVGd0R2hQSG1ZRVY2UEdIL3huU2I5alFEVlYvYjNhdkxq?=
 =?utf-8?B?dUI2OVVIL29aakZ1cTRQREQ4N1RzaU9naWpWd055YjFtenRTMm9QRXFwYmhO?=
 =?utf-8?B?SFE5S0V1V2lmeTRQK3lXSzNNT09WeHBsUldsR2NXbGV0Znl2dzRjVHFZMmcx?=
 =?utf-8?B?YkwvTWk0Q1pnV2hYZUZMMnpyZXdrbWpNMlVNVmtJdzlSa0FBSTIvSnFpbWxq?=
 =?utf-8?B?aVJZSU1lU1BoY1htYUZQN3g3UGxjd2JFbmRibXZjR29uTkc2VENXSENINDVx?=
 =?utf-8?B?WS8wVnFHUS9NRHp3Zjh3eHhjQzZTVHNURHA3T0ZDdVlHUFcvNm9WQmNtMWdx?=
 =?utf-8?B?RTlLeVpCbnh6ZjM5TDArSGd3S3BVV3ZCcnhnWWhIbXFMOUdxUlYvcEYvN2FL?=
 =?utf-8?B?Zi9wNnF2QlV4aXFZTU96TXFuazc2OGlCNGRNOTFaZWJINzhiQ1dWRGlOai9i?=
 =?utf-8?B?NUdja09lTVRkNGxyRzNWa2ZxWldYTFludWVUcXdwVDZFN0RrUnhkQytIQW9l?=
 =?utf-8?B?cy92MExRLzJxNzk2OTRGeXVjeVoxRDJmVTN0TFR6bDEzR0ZtN2NnTlJ5UTNa?=
 =?utf-8?B?OSsrOUg1K1V5d2V2b1pSYXVoOHBUMVU3MVI4NzBHTk1SenFINWZmYkFUbEpj?=
 =?utf-8?B?bmt2Y0xoVHJQaFd2SWx0YmxnTk1xUW9SUzFuOXRvdk8rbHd3eVJkLy94UEFB?=
 =?utf-8?Q?adSo/DYzuwPyrxHi4iOoWMn8shBxmTSC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0Jqam8xcjNyMExaMW1SUjdaNXpQWEtLNnBKWnpBaDNmbWdOZkdFUjIvWU1m?=
 =?utf-8?B?SUJYS1BzMXJjNDdDVnJHeGNXQU5lMXZTd2c3YjVudWtHVmtYdTRFdDRHNG5K?=
 =?utf-8?B?QWFPbDZKS1VJMmtDZkRwVW5mc3hXNU5BRmVhZ2VtSENQUU1Oek9ZeWlxR0xt?=
 =?utf-8?B?S2Jya0xZMG05Qm5zTXhid0FsbGR1ZUV3YnNLODZpYmZDRGw1L3BmVmdMbE5G?=
 =?utf-8?B?NU9iRGg3MjFmeXZ0NTNwZjE4YWw3L3hadXNOOVloczk5cGVXQ1FwTUNkaHhY?=
 =?utf-8?B?L21HdU9GQWI2WDFuL095eE9FdlZZem9ZSElKOGFSVExYbWduTXlUakVSMGhW?=
 =?utf-8?B?cWJsSnp2VTE4U25sRTlJUll4TVR0c0NQUWVKYVZwcE85amlBL280T0RRVkY1?=
 =?utf-8?B?b1R6bGRpaFNCTHdZTi9uNVgyQnYxOTRMVkNFMFVTREc0UitCNG5CcGI1THRq?=
 =?utf-8?B?Q2x0OUE2VTFEalkzdTRFeXd4Rm85YlJYcmIyR0F3R0NJUkFpOHNOOTZVbjNG?=
 =?utf-8?B?NTE4MDdMdlRoWThPRjk5UG9ocmNHSFpLYVBlV05uL2NxMzlIVnZJNmFkVE9S?=
 =?utf-8?B?NWpwcmUvNkhheU5tU0pKK2ZFeTdReXAvUzhGY3J6ZGo2QWVGcFFqZHhMeHRU?=
 =?utf-8?B?VVZieE56R29YbHhlTXZxVGsvSTB0NWZlZU4rdlhFSXZLK0FCd0FRWVg4TDl5?=
 =?utf-8?B?Z1ZKRWF6YWp4V1htWmNCTVE4SVkzNEtRSVA1L3ZYMlVXeEl5UkJZK3ByRHJJ?=
 =?utf-8?B?bUYwQm1kOWZ4dDBOaEJHU3V6K0RkU0Y5MFVObHY1eHB4eVBKZlZWY25HQ0pr?=
 =?utf-8?B?THlTOHR3R1hkMUNBVmdoK3JEYWpWMmJHVDhQbEhCQmtyRFAxc0Z3a2x1K2FF?=
 =?utf-8?B?UUdPZUVieGRpWGt2cUxNcWRXanFQMjhtTThQNHZpWmg0dWhYTHV6Rk02S0lx?=
 =?utf-8?B?UzRmZThxWFpieWxBVW03WldYOFZ3WmZoSmg2WlEyeThrc1VMWmt6SEJMN3Iv?=
 =?utf-8?B?NTI1MVhVWFlvQWd0c3JJVFRiQzdzdmpTSGg4N2tLTGp3dVpON01WNm1uMDMz?=
 =?utf-8?B?ZkRLNUd3bEpGanNsR1BHakg2QXZuR2U4NGU5NHlQeEt3Y3RydFJHcHlkZUVO?=
 =?utf-8?B?NFU1Q0IxWlVadTJwcXUyQXFyMjMrS01GVWZhamVBQXB5ZmZzM0s3bUdvaCt3?=
 =?utf-8?B?Qit2WFRlL2VJZ05KOGE2ejBSZks2VXQxbjZ3VXl4SEhZRXFBRE5Rc2xPK2Fx?=
 =?utf-8?B?dS9WL1IyTHA3ZzV0MExHQkFtamtnTjdDNlIxR3RJalJ0L2hWYjluNmFVbk9K?=
 =?utf-8?B?bC9kNlhMSGZXcUxCa0JzaEs3aERwOGhVSXZUY00rSFdqWWFxM1VlYnZRSEFY?=
 =?utf-8?B?dFJOdGUrOERzRCtZNnUvNGJHK3ZGRWQwU09SbUQ5Ny9aL01NVWkyK0xtUEN2?=
 =?utf-8?B?ckdIdTcycFQ0VEVxNUxpQkJSYTJYY1dGMXFlTEZuTDJKTlFXOGNyc2s5ZUVS?=
 =?utf-8?B?WFN6T1MrdmhaVmVPTjZOQmFuMFVka0s0QzhYUmdmcFBpc3NIUzNLdCtZaGFv?=
 =?utf-8?B?MCszY1RWVXFTY21lblVNeUNnZWlpa2hleUU2cUZPS3lCMEZ4a1VpaXA1MVdw?=
 =?utf-8?B?WnhNbVFhWVhNSStDVUZEaXJCTCtFKzRPWlc4Tk9sU1FBNnNGMkVpUk1obGdK?=
 =?utf-8?B?KzI3M2M1T2dHelI3VWNFNFlnN1Q4SGlFdnpod3cxdEszY1VTSkZueStHTEVk?=
 =?utf-8?B?NzJnUXZlMVNhckI2dFd2YXZNWlY3Z2FQYWRna1lvbjRSMWpSaDF4T0pnTVVT?=
 =?utf-8?B?S0Y2elBoM0c0Rk5od3d5OGRuL0phaXFBMkY3cERBSGtZcjRQZmtPbnQxMitN?=
 =?utf-8?B?aFhPaTloU1hvSDdBN3J4T2ZXTkc3WTJiWnorZ2MxdVRYSTAxU2RlWDZqOVdU?=
 =?utf-8?B?U0NPRlFjakNjd25qQStXYkNJL2dscE42VnY1N2V2Q250RVRIK1ZCM0twblpN?=
 =?utf-8?B?VUpETStYWHJzdlVmMHNnVStPTVRBSFRibmVUcmV5R0hvaGxLZzczVEFPL1RJ?=
 =?utf-8?B?Nk50b09yMEx6d3l5NEVsWEpycGZoQjNocVEyRG9Qemc2Q1d0ZFVnd0IrK3lM?=
 =?utf-8?Q?PVX+oeUxObPNqrcI5n+2T7u/Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d04b309d-f0f7-4864-e81c-08de15584ae6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:56:49.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibmF/5t0+VnCfnGaUVeGcb+cZ9bsUFEI3JPntzLBoMvg65ynFZfBIoKHA0G9zVP8WRdgXhcGVR1JlVm0QCHlUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7690
X-OriginatorOrg: intel.com

Hi Prateek,

On 10/27/2025 1:42 PM, K Prateek Nayak wrote:
> Hello Tim,
> 
> On 10/11/2025 11:54 PM, Tim Chen wrote:
>> @@ -2530,10 +2531,12 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>>   				 * between LLCs and memory channels.
>>   				 */
>>   				nr_llcs = sd->span_weight / child->span_weight;
>> -				if (nr_llcs == 1)
>> +				if (nr_llcs == 1) {
>>   					imb = sd->span_weight >> 3;
>> -				else
>> +				} else {
>>   					imb = nr_llcs;
>> +					has_multi_llcs = true;
> 
> One caution: this will not hold if all the CPUs aren't online during boot.
> One case I can think of is when the kernel is booted with "maxcpus" cmdline
> and CPUs are hotplugged later.
> 
> Unfortunately, I don't think we even have the raw topology data from the
> arch/ side under such scenario to accurately make a call if the system
> contains single or multiple LLC :(
> 
> I'm not sure if it is feasible but assuming the task_work() cannot run if
> &sched_cache_allowed is false, can the fist instance of the task work for
> sched_cache do the necessary setup?
> 

build_sched_domains() might get invoked to rebuild the corresponding sched
domains during CPU hotplug via cpuset subsystem. So if the CPU gets online
after bootup, we still have the chance to detect multiple LLCs I suppose?

I did a check on my VM:
root@ubuntu:/sys/devices/system/cpu# lscpu
CPU(s):                      32
   On-line CPU(s) list:       0-7
root@ubuntu:/sys/devices/system/cpu# echo 1 > cpu31/online
Tracing ... Hit Ctrl-C to end.
^C

@build_sched_domains[
     build_sched_domains+5
     partition_sched_domains+613
     cpuset_update_active_cpus+838
     sched_cpu_activate+272
     cpuhp_invoke_callback+340
     cpuhp_thread_fun+139
     smpboot_thread_fn+238
     kthread+249
     ret_from_fork+193
     ret_from_fork_asm+26
]: 1

thanks,
Chenyu


