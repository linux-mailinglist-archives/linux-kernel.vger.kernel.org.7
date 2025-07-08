Return-Path: <linux-kernel+bounces-721171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2226AFC5A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D70D7A5264
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1FA298999;
	Tue,  8 Jul 2025 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkkiEaHb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECC79CF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963418; cv=fail; b=TyGzJkx1cJE1FzMrtJVu3rgfSLV+l2xBUV7IYDj419xjsaFllHQd4v1xuUsKjc4KM5B2EzCEeSubYIEx8z3yygsTVcLfU+nACOtUFiCOb40zAqvdmH2jw13a6PE18/Py+nGqGGzqImGyP7o9JNhwElXfDMYpNGMXPlNZcUNMiDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963418; c=relaxed/simple;
	bh=6oXrKFA5EEdxZ28iy8jwt6NrksY6pr3Iugs4BPwLZeo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cEEpcnNYbeskhnHan2/X4OjbmOJgFlPpNwX6FMVbVEwIqpqIRwgLS5emDV5GhrrdKRylApVMDdLwPtlYady4Pg8f6tLaWZg8/F13CpTLbUm/B4HrrK0SuSJ9+S7/Cd03DYM70t+m8tVKiQgI3PuZyodLqzCYJZn63BK0nxwZ96E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkkiEaHb; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751963417; x=1783499417;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6oXrKFA5EEdxZ28iy8jwt6NrksY6pr3Iugs4BPwLZeo=;
  b=RkkiEaHbMRpeJD5hKBEVwlQMarGpgyfbdngVWSiBL9X38ZiR2Cw3bAXD
   sEBJYAqX/XKnw6yavkBaaYq4S0o0jbPLxIaEoLY4pj66BJnQgz82TkAmh
   97NDGCsSUq5/XeVlYEge1wCz2NAACyM4GCQg+Lv0wiNQf6MHRzmh09w5T
   q8dFYVIAMdxeHuSfVW1KLaTVirrfGYCz+6I9ymsl1S5gmyZ6IXhqswFhs
   o+O03dUJJr1lis6+fU5xrdEtqK1M3ag6tu1cWL5+oWUXAr2EpEjWVzxNb
   JCKSH4lvZVjPw8VNpkNsSB6cidi3UTgjRZnd1DPG6wkDll9DrccJidtDm
   w==;
X-CSE-ConnectionGUID: jIzUI9lWRBacC1y4LICCmg==
X-CSE-MsgGUID: lPcpb4jjTIq+Q5CnfdT/QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54321513"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="54321513"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 01:30:17 -0700
X-CSE-ConnectionGUID: sx1f9MY7QPS8yz4VKgp5uQ==
X-CSE-MsgGUID: NZAfRmEJRMeKbvFUb8g42g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="155564987"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 01:30:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 01:30:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 01:30:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 01:30:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9QiSJX2sN3fwvSZeSWzb3U3cJ5UDHeB5pa7uzF1q5NzyBY6xr41qkkaGhzwE4WG+Bql6J7w1yKY6YlGW7f4SABLDMzTqj60FAk3rWvsDrFpE2ZMt7IeG+z/8NKqD/WtCaTYWfB94sW4dGEu9Uq6a1qony2uWDElXx6eam8/iFuH43XM4s2qAObEEmpkf8fqpP+q82sFFifJPwMGNG1FLGgBiwgdqNI0MlXd8VMPr+jCfMqZGcRQ70s9HUQhTg1V+++5rS0viQdvt0tjGnupaIIa5FprCvNMHCdW/mnw6yHciP3qBkeM3UHL3rax3AsOs/aL6k4qYeEZ43rAqLJWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWZL1mFMclTbaXX/PuSLhDubwnXH7/hEgVsVtq8Kgpw=;
 b=sLCMwYR9Hac1DQ4O07fjZZMPGe/IiO1PbAiCG7D53hhzFFrD2bAM4YZPFARaGcZAmuTfkJNhV2YMn46OKdVGG7r+/qdRXvo0EJh6kvXDlbmH7zUrndKjPpZeeFfeeMN0Qy6HvXja3m8AU5h2I7zyax1S+PELXZxDvuikXruLplO9zWMYRYQUartA/kAkXaWUGa+Ijgdyh9pHqiCtBtElA67TooxsM4EPg2Lvor6bXsKLc1BvgstvBZqzIhnMHkSZ8Iu//UY/Jl27YmIYqoKGLB7eP9rsXvAUrANa0F3NSYswblFzQUlx+KnC1vr3jdDIuvm6DI3WnihGdOZFCn02GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ0PR11MB4877.namprd11.prod.outlook.com (2603:10b6:a03:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Tue, 8 Jul
 2025 08:30:01 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Tue, 8 Jul 2025
 08:30:00 +0000
Message-ID: <6a36eae1-7d1c-4c23-aec3-056d641e3edd@intel.com>
Date: Tue, 8 Jul 2025 16:29:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC patch v3 07/20] sched: Add helper function to decide whether
 to allow cache aware scheduling
To: Libo Chen <libo.chen@oracle.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Abel Wu <wuyun.abel@bytedance.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>,
	"Len Brown" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>, Tim Chen
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
 <abb433c3345587d068e5381c65e9d0b3f50828d9.1750268218.git.tim.c.chen@linux.intel.com>
 <7f4f1684-fbe6-4148-bbe4-fc2e138abb98@oracle.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <7f4f1684-fbe6-4148-bbe4-fc2e138abb98@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ0PR11MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: 574007ea-8db5-4ed2-c72c-08ddbdf9a148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDZJa1V5R0FGbnYxaDRRMU9ldXZhQlRNblMzT0RDdDhLRkw0b3NsZU13YTdn?=
 =?utf-8?B?aGhhU2pVd0dFSWptV3hnSkhEQ2ZtdGpyRVVmSEdvcWpiYk9Dd3A2RVJkeVE0?=
 =?utf-8?B?TTJmdjhBSWtnZ0pTR1VZaENxdGMyS3Z6N3BRUTBDRmp0bytNL3NJdkpOcVpV?=
 =?utf-8?B?b002bmllaFZVa3k0SzBkYjlESnYwMUN0d2xBV3FrUFNtcEFVUHlrZjZTeGFv?=
 =?utf-8?B?bThSeGlzVHg5R3B4UHlMS3hyRlhEclpqOURLZUUxaXBHWnhCYjRQOXBldlFh?=
 =?utf-8?B?Q1hKV3FrYk1jZ1YybHNtNWRWUE9iNGtRUksvWkptVGhYaTBnSTIrV01KOGJ0?=
 =?utf-8?B?VnVkRGs2eGpxRDhBRWM4OVd4b1NKc2xKcktFV2o0SVpRZHNyWGNxdTk0VVJl?=
 =?utf-8?B?TFZ6MHRtT3lBd3Y3enR6SXpLSTdLRVBVcVlwbHF0Y0diWDdHbUFJRGNPRTJR?=
 =?utf-8?B?SkdycWRBR3hQc3J5UXJoT3ZMNXcvNXZuRHBCTzBZdjJTM3pnOXBCSWhCb01B?=
 =?utf-8?B?dUM5Y2VIZ2YxTjFnQ0hVN0xWOUFEcWlWdlNTOHhjZ0pFNmxlMy90ci83R2RJ?=
 =?utf-8?B?Y0kwaUlDUDNqSmxLdndRVFpuTTJsNktzWmlJdTZWNUt0ZVllY0pBSmVNaWd1?=
 =?utf-8?B?UmVSMVJLY0RQLzFicmthUTJsNHNlTmdWK2pZMDVZYTkvcDNSOVBWZE9IMnBn?=
 =?utf-8?B?TythS0hOSGd6V3B0clUxWGk1UmtOeGRZOTE2dDhYSVpzdDg4RkJydkZGbEZD?=
 =?utf-8?B?dzhua2YzOVFsOGJCUUkrT0haajBYY2xoOHJ4elBjdzJKd2Y2c05uR283dVpj?=
 =?utf-8?B?WXZGVVBpMGlPZWRYL2lBTytmUC9jMWtIc1M2ZHJ1cnkyMlVNbzJFdUVHcmd3?=
 =?utf-8?B?Y3RaRkFLa0lCRkNCM2VrY2xIbzV2WmJLRlhkY3RJb3ZZY1R6N0FzVnRKeUI3?=
 =?utf-8?B?bWxFSjMvV3B5ZndLYTZRS2ZiLzZYUnNtVGcwTlc3ZE5hSFd6UXdGaEZjMHh5?=
 =?utf-8?B?RWo0azlXVTFCazVWODJmMTNmaVBQbk1BYjZvMWY1OGVpTDNTcmpKK1RkcWxm?=
 =?utf-8?B?MTRGd3FlZ3YzaTMxTEROQzdHcDVCOTZmYzZGY2g2ZjJZU2RabTljeWdyWG5I?=
 =?utf-8?B?L2E0QmptRStybFZqSW1KcWlSdk1MUEROMEl6T3VBaUd5S1UzRlhYamRDVlc5?=
 =?utf-8?B?N1pYckcybkt1VU1TQVg5TjdzYkhScGs0SWdjVVlJUTRSY0VzQ1ZhSm5HbGlJ?=
 =?utf-8?B?cW0vRGtFOGVtTEgwMHUwL3NDMUZ6MjBYUE5CeWF5ajNtZEFqckRUOTFJaFl0?=
 =?utf-8?B?ZU52RDRtZGtWcVRyNjY1TU9sdmZkWGZLNWJTK0hjLzhwZVBnWUVPVzNQQU1B?=
 =?utf-8?B?Slp2QXRnRkxaR1QyWHQ4NWV5cTRiN3FUWktYUHNVaE9yZFZJdWlYZ3JZdjVM?=
 =?utf-8?B?Zzl1Y1lqM1ZTbkQ2aU5icXBoQTVSd1FrZTdGc3JkbGJLYmc5aHp3QnBHN21r?=
 =?utf-8?B?ZzZ1c3JoMFVzTE5iK0VUNUNZRXdrZHZpODBYd3J2RFp6Y011RHhwcm44bGVz?=
 =?utf-8?B?N09rdmg3YVpNSVhKL2lOYXh0SHVGTFY4T2VqemluT2U3ZDNHMGhqRU0zQ2VC?=
 =?utf-8?B?WFdNYVdDL2ZCeW42ZzZBMlFUSlYyVU40S0dDWnpMZ0VFYXlVVnJCck9GWm8w?=
 =?utf-8?B?ODZMN2J5SlZFdk1lVmg3SE1HajBBL2haZlZHVlM5UFFmcUtoY0xTeEJ6TUZI?=
 =?utf-8?B?OVZrWi9aSkI4TzI3UzA2c0xpcU93a0xwMkIxbzJuQVpVcXdxdFdxaWJSeWhG?=
 =?utf-8?B?Y2JKaGR1WXM5QWFWazdyS1JzT013SlhrYTB6a3JrNGx2M0JaSWJNd2x0M1l3?=
 =?utf-8?B?UTZnck9KTS9tT3VZQnpGS1c5amtwdUJLN292THQ1RVFHQzF2ZzdzUGl0OFpu?=
 =?utf-8?Q?v5S58q9fyzQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJLUm53L29QSURnc2k1U0QrM2orZWRLS3RXdDNFcXU4NFg1TmxnbGhSNjNE?=
 =?utf-8?B?NTBwZHBvQm5NNzNna1FnNkw4UERlVUkrdVRnOUM4SitxZ3F6TUlHd1pGMzQ0?=
 =?utf-8?B?UHV4aUZKNEc5RDR5TG9uUVZ6R2ZKNlVGbVhIZHNCL0lDaWMyZzM5Z2pSRm9P?=
 =?utf-8?B?ZmZ2S04vMm1tMk41cFVPdFkvaTU3RXIyVVkyWXFsZWdIRVRIZ29mRXNyWkgy?=
 =?utf-8?B?UmNjcW5penBvNG41bGNLZWlRbWtlZWdBMmpXTGRab0NUZTNPbHNxSXMvZ3RI?=
 =?utf-8?B?MkNCWS9BM1BIUFQxODBQRFZyVkZXOHUzdzA2V0dRd0JJNGNhdFp2U2kzRFhH?=
 =?utf-8?B?ZXA3R2w0RHZBZkZLWWRHNUJBM1E4cXlpSHdvREI5bnU2b2VqS21LMGVWZzZO?=
 =?utf-8?B?OXM4cDVMamZpN2hDQnhSY05xM3liWGhoWmNxWjBzTVJqTE9yZ2NxM3A4Umw2?=
 =?utf-8?B?YUVQOXVTcjllSTZrSlB2Yml3V1VUeW9mZ0RqN0JTTDgwanQ0M2Q5SDBuanMr?=
 =?utf-8?B?Y0pLQlBYa2tJK1p3dHFPcjY2NVVTU1pTKzBwWTNFa01WTmhoajJLOFRvZ3Vo?=
 =?utf-8?B?b0FkcUZsdUxvc2kzM2kyWWNqUDJVMUtTRkJvOGdjOXpweTZhbXdMcnBsbkNk?=
 =?utf-8?B?ODFCZU54WmI2S1lPYXhsVC9wMlFnc1paUkFjdXA0RjhoTlRUd05pRUlZL0ha?=
 =?utf-8?B?S05IbWwydzdSNm9COCtQQk5PaWtoQjVwSFNibVV2dmNlSkRuREQ5T1dIenc3?=
 =?utf-8?B?clgzdThZdnlaZEpRSG5RaDBYSmdtZGVqRmVoYXBjS3Q3ZDdVVTVoN0FoL0Zj?=
 =?utf-8?B?bjJMNG9oQ2JXUWhKNzY4MldrcTZNYVJ2d2M5Z2VoUzBONzRGT1BISFhYL21W?=
 =?utf-8?B?UDNPKzdjQ01aa3NUT1ZVUTROdzBOdkYzbkR4MFpSSUltQXNNUDcrT1FSY3Bp?=
 =?utf-8?B?MWJadjlwYWIxVUp3SWg4Szh0YmJXUTFhRVh5OWZuL0w1WjhWTFViR21FbGlG?=
 =?utf-8?B?ck03anc4OWdOWmhoUmRiY2kraXZCZE9TR1NUd3F3bDNodVJHVzV3Y2Y1cVNG?=
 =?utf-8?B?TE9HNFVRcFlrVUxXSk9RaVU2ektmd2dkYkpDWSs2K1Q1V2J3WXJ3RndXdzhV?=
 =?utf-8?B?OTlTNDFNQnkxUDRHandaSjlSeEl2U0I2TWN0QWNFRVUrVWZBdTZrUGJNYk5o?=
 =?utf-8?B?eEZHTmthcWgrSTFXdmo4d0Q2RkV2WkFxVW9TdmRHWngrc3NQWjh3VjI2VzBS?=
 =?utf-8?B?b0taWmk4cFZsWTBxaGFEUjg0Nm1ZZnZjUDV4dkV1Rmk4Vmp1bURtT0FNRFVO?=
 =?utf-8?B?VjNWaklRelBUc1lmUkQ4UW9YMkk0QUE5S1lYV1IyWGtRdnNLMDU4ZFpjUlND?=
 =?utf-8?B?WDR0ZDBRTWh5S1FQY0tuaVR1Tlo3SHFGOFNXOFdTSHhHMm1rdGZnWk9TcURu?=
 =?utf-8?B?TjhCdERhc2luQkhZZE4yTHl4TFE2REM1TjdNQk8rdXgwcC9TUng3YkFmNzQ2?=
 =?utf-8?B?R2xWSnNtUFU4czRubU95THBFYTFkR3NQcDgvK2ZQaWNhQ0Z5dmM5OSsybzd6?=
 =?utf-8?B?VG1Qd0dkbWxJSU1WS3Evek1wWVhpcDFlMU53cTNUbWVyMjA3MlRCYThmMEVq?=
 =?utf-8?B?cHRZUHlwRmxRV1RjaFo1MnoxU0VXSklhUHFQVStBbnNqTzBwTi84SVZabE9K?=
 =?utf-8?B?anhqejNoYkIxVHNLa28zN2xJa0Jhdzk3NFBSNnUwQXlwZlpZRlRQbjNpNUw2?=
 =?utf-8?B?S2RHUkVHa0toeGwzTCtDd3BJajlXYnJkYldMN1cyazV4MDU1VnpWVlZEeUJa?=
 =?utf-8?B?emtUSklUNmtUdlprQkNoY3lXNXdnT2NhcEUwZjk3d2loNjRkSllYc2grMXA1?=
 =?utf-8?B?bUxHblpkSTFsU0tBQWFVVFFxdytVRSt3TTNyVmVhNGdlUFcwWnRMVjdkNm9u?=
 =?utf-8?B?KzFGeklNWk9rY3g5dFZITUd5WVdFQWI1cTRDYk1KSHpmZENoOUNuaUxzenRw?=
 =?utf-8?B?eHRzOEFETnNXa3dXYTNLTjJFMUgvWS94NC9VM2k4ZlpjcVI3RWlad3lWZWNF?=
 =?utf-8?B?VUc1RGlBNXE1dXNjTXNLL1RsTXZ3ZW9PTGM1TjhqVi9NZFNjZnRDbnRRemd5?=
 =?utf-8?Q?yARNBgJUCOo67U9HAry3YmaVh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 574007ea-8db5-4ed2-c72c-08ddbdf9a148
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 08:30:00.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZFgvB2/ugUB0I2ZZbiIdrEcwNozxuLLvBeGF2Gq2p+4qJ3xwYD7mwAfTp1EBmnhUnKAEPES8FtLGHbFCUiKaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4877
X-OriginatorOrg: intel.com

On 7/8/2025 8:41 AM, Libo Chen wrote:
> Hi Tim and Chenyu,
> 
> 
> On 6/18/25 11:27, Tim Chen wrote:
>> Cache-aware scheduling is designed to aggregate threads into their
>> preferred LLC, either via the task wake up path or the load balancing
>> path. One side effect is that when the preferred LLC is saturated,
>> more threads will continue to be stacked on it, degrading the workload's
>> latency. A strategy is needed to prevent this aggregation from going too
>> far such that the preferred LLC is too overloaded.
>>
>> Introduce helper function _get_migrate_hint() to implement the LLC
>> migration policy:
>>
>> 1) A task is aggregated to its preferred LLC if both source/dest LLC
>>     are not too busy (<50% utilization, tunable), or the preferred
>>     LLC will not be too out of balanced from the non preferred LLC
>>     (>20% utilization, tunable, close to imbalance_pct of the LLC
>>     domain).
>> 2) Allow a task to be moved from the preferred LLC to the
>>     non-preferred one if the non-preferred LLC will not be too out
>>     of balanced from the preferred prompting an aggregation task
>>     migration later.  We are still experimenting with the aggregation
>>     and migration policy. Some other possibilities are policy based
>>     on LLC's load or average number of tasks running.  Those could
>>     be tried out by tweaking _get_migrate_hint().
>>
>> The function _get_migrate_hint() returns migration suggestions for the upper-le
>> +__read_mostly unsigned int sysctl_llc_aggr_cap       = 50;
>> +__read_mostly unsigned int sysctl_llc_aggr_imb       = 20;
>> +
> 
> 
> I think this patch has a great potential.
> 
> Since _get_migrate_hint() is tied to an individual task anyway, why not add a
> per-task llc_aggr_imb which defaults to the sysctl one? Tasks have different
> preferences for llc stacking, they can all be running in the same system at the
> same time. This way you can offer a greater deal of optimization without much
> burden to others.

Yes, this doable. It can be evaluated after the global generic strategy
has been verified to work, like NUMA balancing :)

> 
> Also with sysctl_llc_aggr_imb, do we really need SCHED_CACHE_WAKE? 

Do you mean the SCHED_CACHE_WAKE or SCHED_CACHE_LB?

> Does setting sysctl_llc_aggr_imb to 0 basically say no preference for either LLC, no?
> 

My understanding is that, if sysctl_llc_aggr_imb is 0, the task aggregation
might still consider other aspects, like if that target LLC's 
utilization has
exceeded 50% or not.

thanks,
Chenyu> Thanks,
> Libo
> 
>> +static enum llc_mig_hint _get_migrate_hint(int src_cpu, int dst_cpu,
>> +					   unsigned long tsk_util,
>> +					   bool to_pref)
>> +{
>> +	unsigned long src_util, dst_util, src_cap, dst_cap;
>> +
>> +	if (cpus_share_cache(src_cpu, dst_cpu))
>> +		return mig_allow;
>> +
>> +	if (!get_llc_stats(src_cpu, &src_util, &src_cap) ||
>> +	    !get_llc_stats(dst_cpu, &dst_util, &dst_cap))
>> +		return mig_allow;
>> +
>> +	if (!fits_llc_capacity(dst_util, dst_cap) &&
>> +	    !fits_llc_capacity(src_util, src_cap))
>> +		return mig_ignore;
>> +
>> +	src_util = src_util < tsk_util ? 0 : src_util - tsk_util;
>> +	dst_util = dst_util + tsk_util;
>> +	if (to_pref) {
>> +		/*
>> +		 * sysctl_llc_aggr_imb is the imbalance allowed between
>> +		 * preferred LLC and non-preferred LLC.
>> +		 * Don't migrate if we will get preferred LLC too
>> +		 * heavily loaded and if the dest is much busier
>> +		 * than the src, in which case migration will
>> +		 * increase the imbalance too much.
>> +		 */
>> +		if (!fits_llc_capacity(dst_util, dst_cap) &&
>> +		    util_greater(dst_util, src_util))
>> +			return mig_forbid;
>> +	} else {
>> +		/*
>> +		 * Don't migrate if we will leave preferred LLC
>> +		 * too idle, or if this migration leads to the
>> +		 * non-preferred LLC falls within sysctl_aggr_imb percent
>> +		 * of preferred LLC, leading to migration again
>> +		 * back to preferred LLC.
>> +		 */
>> +		if (fits_llc_capacity(src_util, src_cap) ||
>> +		    !util_greater(src_util, dst_util))
>> +			return mig_forbid;
>> +	}
>> +	return mig_allow;
>> +}
> 
> 

