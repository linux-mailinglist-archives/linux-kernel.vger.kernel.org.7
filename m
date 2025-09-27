Return-Path: <linux-kernel+bounces-834976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF12BBA5F2C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C89A2A28E4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADAE2DF148;
	Sat, 27 Sep 2025 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiJF/qb2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DFF72602
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976480; cv=fail; b=QKu5yWuTAAGYolxMmjwPEsvIjANL+ZfI1Ok77kwFDcxCy8DqkGiO8uLgRtUygeYD9gAiKV4COEHfoZ2A7V7T0BastWu/t3ME5Szo5QbNxvslzBcBeIEhQ4j0ODT7lRuuZHR6f/7X6loSj+XZXwOlfXZnkdChtcSMhm2KezNjfx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976480; c=relaxed/simple;
	bh=k9Fiy/58qE67q2GfE0uAK0HOVurX2Sa54gg5dHDEsgQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sq75MCeeSWewPfQrM8849CdtM879vugFEr81g5bx3bxOhw4bGX2yZ5Vurmv7ASugABmJ4KvPRUgN2VL5tphRoQuISXj8F4Bfwa+kVURsWs2K6iKK+9qi2GP/SXSm2FJTGxLD0zcdgV77tissdQLnTDTaHlfd6MI4oLfKvaySjw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiJF/qb2; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758976479; x=1790512479;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k9Fiy/58qE67q2GfE0uAK0HOVurX2Sa54gg5dHDEsgQ=;
  b=OiJF/qb2JfXEUiS9YZyfHh85lciC/Kzs6gAxFgO87xVwhKocxg7HCcQN
   PN+OgxBpModJB0fP9IKT62Oy/gkCW3/xAm4wniuDBI+/Izla65PoqZpLD
   U0l7Ncxw1vNBntKTWj9qT0jmmms/ZYHHOJA7rOlDa2UmztP/OVjBARewq
   3Gd/m0TFXsw7H1k+8ZVRwPLSyENhCBQYy71KRdXcwFW1GVi9cQvuXp0lt
   /vBjcRDuhKiXFV1znrD+R9zkJShGOGtbJi8v2ePvVJEvV/MKqhfzRL5Nx
   whz2EOnGn4s53Cg7XenQL7XbsK+IniRk/rVEDg4RlxDIMzlRYGX8Yd0Gw
   w==;
X-CSE-ConnectionGUID: U74io0ciQR+vSvaAoo6OjA==
X-CSE-MsgGUID: a7MXbldzTtGVdaDWGzouWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="60328143"
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="60328143"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 05:34:38 -0700
X-CSE-ConnectionGUID: /lyQMuzGRlymifOa+csHIQ==
X-CSE-MsgGUID: WfrZmV7wSnSqMHvbfYmtxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="181837690"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 05:34:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 27 Sep 2025 05:34:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 27 Sep 2025 05:34:37 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 27 Sep 2025 05:34:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHv3AaKzOWsE++GLswZXozsjBflyBoiBRgQuJwx8JP/OdHWmh3iCJD1ouHHDAn7EB7VZ8YfDa2N0sB4ks/4QQ4lkDKm4db8OV0bH37SI2QfdokvYt6SKsouzfO6oRm3d1Lg4nQaJcOfSwTxJLZXk+H6vhPeUfAxmi6RkJUktvDwuv7zB4yhsnndfaTAXZpp7aqmgeUxuOjya8O4jZqGLQqiwVd7nzCq7MhqX0Gy76JPAxkLPoyf7/LQdkOyYaRz4WtOtyeOafpfRjtFebFK01fu/lA3BFKgOXjMquHqpDlHvNTdtDphYyImnPIVcBpGttDcQIl1H/cWtUi6HhmnGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxLIXyf1Ucr2RHh0DyNYclDxFvHNnDMvfoLcIqgzTtg=;
 b=X2kwEMJvMC4in6llqxBQ5ZXY3ctOQVTZhFis8eRrAehQVFG0yaFJHF2Na3VMkc43VL8nK0FjN2GHSMNQ9WaQlgY33xEv+W/jUtT/o6daBIhBDJlEhhlfD51upyqzGXif1PGbriCcHgjbhRy/uMM/dO415oFrt1WlycNm/DzRpaOHw24U8CLux7LEp1QNUxag59Jcj03fZMgdB0xnRQcGXWG02JFLhqAeyUs5GKMqLk1fIH6uFTP86Nw01K+MnMqzqbBUYq29rhRCou2Z8cmfWv87DmWV7B4wsh6DrueP/pJCz4FCfUf3MBepg6WsMTxSlKe/4CeDlgXCpwjO+SA4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Sat, 27 Sep
 2025 12:34:34 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.014; Sat, 27 Sep 2025
 12:34:33 +0000
Message-ID: <6a650359-d106-453a-a5a3-24b3750a05d2@intel.com>
Date: Sat, 27 Sep 2025 20:34:25 +0800
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
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <990005f249897c6ef2e7d998c68836eba604f346.1758234869.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::7) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA1PR11MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8b5937-a25a-49a2-efab-08ddfdc2367d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ankwK0Vud092Y3pEMGRLbzVyUlM2VmQwTlVmNHByem5DTnhtMmxDMDVWUnJN?=
 =?utf-8?B?aUEzaGNhYW9BRko2Z1BUMFhEcUkwa3luTTNtalhUYnRNaWxlSkZERjdtWmQz?=
 =?utf-8?B?OXNmenRqTFdGKzlCNlBEdS93VUdwRjQwUC9WSmRaTi9VZi9LWVpXQkpkMnQ1?=
 =?utf-8?B?allWaGRSeVFCUHRac2k3bnJ4OGhHOFp5VEpScWF3OFJuL2U2WkNJU0xFcUV2?=
 =?utf-8?B?bVZybCs0MTYzcDRMMFRrbEU3cGM2MGxCUitucVh4RXpnc1V6VUdZOVU0bksw?=
 =?utf-8?B?Sk5UenZjUS9ObFNRdURKUDRhMlMraUlwNWVxcWMrMytmQWlMeHg0eTlONGF3?=
 =?utf-8?B?N3RQbHorNmpmZkFkaFYwYjd4OTI0b0F0dllpcVJCUVZYV1RXZGxOTG5IU2dl?=
 =?utf-8?B?OWg5ZFZxWGRlblZtQzVBeTRvKzhEL2IwbndWWTJ2TlpkL09WWGd0VklnUDdD?=
 =?utf-8?B?azNENmh6aHR3Y3pzSjRMUHdUSFBGRThhVGNLZmtPY2R2V0QrNTkzb29aS0N6?=
 =?utf-8?B?UWt3ckkwS3RvNDB4ZkRWVUw3dHU5OUliblo4dFhrSzV3K3Q5MFlRbzVKVVFQ?=
 =?utf-8?B?UjA1L2h0N1p4KzRNbHpFbU1QaUhoYTQ0ZjN6a1VmekMvU2lMcDFncGwwNG1U?=
 =?utf-8?B?cUpBUUhvWGVJdFJ5ZWZ2VFRGTjYxSVRGcFBxc0o0MDR1d04vOFk5S0IvUXlD?=
 =?utf-8?B?TWk1ajNBaEJqaTZIZ1NkRVcrYzVFaG1saDJ0SGJ1Y2syY1FZWU1LVmkzQVY2?=
 =?utf-8?B?RE1ZczNHcEt5bk1HUkowcGo1WFlkditMSmJjdTJIQUVZVmFNcGNxSC95RW0r?=
 =?utf-8?B?aDVCaEczR3VTZlN5S1ZBMU5VQmZzT0RXVFFwMUJrT1NFYTdJeHRWUWdhWndF?=
 =?utf-8?B?Zkx4bG9CcE5nOERRNlNvYXU3YzlmYWFMSk9xOXZpTGs4NGJVd3F6WmZEa1hS?=
 =?utf-8?B?cGNDbmRPcDJsYjhvT1lJRGZwVVZlOWlmbHhRZDFXT2dyVmdySzluQ3I4YmEy?=
 =?utf-8?B?YzBiTEhlS1FhV05vT3VBT0FSaFduZzlsS1hsTFRpWEt3TVBwbjRqWnNmaEN1?=
 =?utf-8?B?YkdBMlI4ay9Bb1ZoTTRzLy84ZG5BZE02L09OdGdHRy9sZVpWRXRTZ1MrMU41?=
 =?utf-8?B?NHJxWmNZakp6QVZFOXNnb3oxUmNWOE5nQ2ZxUEdQazVlYU9UZlhaY2RZRERv?=
 =?utf-8?B?UnF6SUtrOHRVcEtEa1lJVnI2d1JMUDVnUndLS3MzVXNsUW1NRFMvbmNZQWZn?=
 =?utf-8?B?V05YRndyYzAvNW1LQjVxVWdzc1k3WmpZa3BoQk4vVHVlTDNKVm5yem91ZUxK?=
 =?utf-8?B?ZWNWNmV2dHIxY096d2FGUGk2WmZWOUt1ekNwQ0V6L1dyYU13NUhydzM2RjRW?=
 =?utf-8?B?Vi82S2N1OFYxUUNiMzVINW1TNlZFQU02dEkwellIRnNoQmRZRWx5QXd2ZXNo?=
 =?utf-8?B?VWpFZnZTNmpJd2F2alFaQlViZzVKczVGblhxV3p6QTRoR3VEOCtyRzRIbmN6?=
 =?utf-8?B?dS9JOGUzbGtEZElyWGVsOHFPVTlPc0luMHM5Q3FnUGhlT3cxeU1pNkw4SHI1?=
 =?utf-8?B?YU0zUlVZZERPZWNRQWdwYlFEWDJjMzd3VTJrdm1IRTVuVXJuOE55LzVhdmRV?=
 =?utf-8?B?YWFWdXFNNjhsbTQ5eDR0Z1JmMTBVeW1LVWRkSzJsNVdYdnZibVJ4TTRPbXp1?=
 =?utf-8?B?TzJxZ3VVTlo5bzdlak1RTlY2SlBuRjJVc2E5SkhyTnA4NzVvcVFrbDFpQVVX?=
 =?utf-8?B?Z0xudjhPYlVROTZWN2crQUcvZXg0WSt0a1NIdGNyeGdvNGpCVTNBNVM1MTZr?=
 =?utf-8?B?eEVLeVlia3pSUjVrcW1JRzBPMFdndTZnNFhjTk02Vkg5OGhKVk1WcCthUkx4?=
 =?utf-8?B?TE9DT0lralZCYnB2Y0FsZmJNbVNIbGVhUDhiMk4zSHVrY01EM1JVYVh1VDN2?=
 =?utf-8?Q?STbyfuoTUnwFNa6VEG/gOy9QpRlUPpXH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzJkeEsrY2J4Qnp0Q1ZXUTRaajlmSlpiNy9Ua1VkQnBBUGtyZ0ZlTHc5a2hm?=
 =?utf-8?B?Nmk0V2wxNWFyNUwxOGhneDFjV1JUT3JrNmN3UGorR2tEMjJ2V2hXMi9SaFFj?=
 =?utf-8?B?Z2pMeXVHaVp3NVBuL1FvTm5oM3QzTWZnZlNUM04xbThOMXZ4b0svais5QTdO?=
 =?utf-8?B?aGN2TDUxV0o1dmhHSVF2SEdFK3ZqeTE2OFpwdkJKc3FTT0tqSmIwUUdmTVll?=
 =?utf-8?B?dFB1MFp0M0NkOXY5MVNBblBaOXR5ZGZMZUtkc1NoQ1FOaUdQd0RTNVp6MGwy?=
 =?utf-8?B?V3pGVCtwWnBDRk5sbGd5SE04YitzVUlmTkxldklOK1phS0drVHJaaGs2ZlRx?=
 =?utf-8?B?YjcvSERHY0hCeUg5d2IrUitWVDBhSC9hNWFLSjJRU3ZDUk03MkZsc3k4RjdC?=
 =?utf-8?B?bkJqcng2RHQ0TzZYTmNEVkNJSUNSbzhQeUdhcmJTaHlMcCtPdE00NGlmTlJ4?=
 =?utf-8?B?U1NaNTliUmVURnRuQ25IWGlBTVk5dDQ4K241QmZieThhQ2xaQUZMWDZpR3Jr?=
 =?utf-8?B?Nktzc0JMZjZySm1iVjhtU1o3UTM0bXU1cHpTUHZUVS9LR09CeXF3TGFKaG1U?=
 =?utf-8?B?TUdkb0dsVGdHbDZSRTh1d0JEblRlTEtKYmd6MlYyby95Z2RiUk1oNW9Za0Fq?=
 =?utf-8?B?SUhKbXhQSDRoNFJrbWFBN2trdzdWMjVWb05HWk4zL3Y4VUZCeXd1SWVxTjB5?=
 =?utf-8?B?d1ZXNXdPT2l4a0ZDYUZUS0JjTnRzd1IzSkU5WTVGV0lHS1V4aU1UUlJxVGxk?=
 =?utf-8?B?MDZ5MDRWdXdtZU9Fb2kwZWpQRjhzSndFV0E5OUgydGhMbjdQdlMraW9KSGlY?=
 =?utf-8?B?TkYwUjR4azI2UVVQZ0VSMW8zaDFyc09UYXVZTmdOWG1ZWTNQM1VPOWltbGZF?=
 =?utf-8?B?NkRhdVBqUDVPc2NTV1Q4SUE1QVVuQUlFWGVOcDdmWUZFMXExZ05UekVuckl0?=
 =?utf-8?B?WFJZcnhLeHgzVStMRVh1bE1QRTVzSTVKYUh3WjZ4bFhlTTZtV2pHRUNzcjJI?=
 =?utf-8?B?SGthbFNCYWRXVnJNd0xzYncvQU1OcFBEZ3hhWVJSSitKeURQR3dnQ3pFNW5Q?=
 =?utf-8?B?S1BheUpaaTdNajB2S0JXSVRVcklHcXhLYTNySGFnd1hQK2FwR0lOdzYvc0ZQ?=
 =?utf-8?B?Q3NOK2ZQUFJOV2dkWnBzYXpDakRFdlY3L253UytFM1B1TVFuWFVnNU8vU05w?=
 =?utf-8?B?Z1ZXNld1Zmt6eW1ZVDNJUTRrQmdBZWk5eXEwcDM5eEhyN1lnMFE5V05pczFr?=
 =?utf-8?B?S1RYbGV1SDlpNGRhYkRtckFkQVNWQSt3Y2tpZjM4MjRDQkR0U2tYT25iMjBZ?=
 =?utf-8?B?RU9ESVBVeW03RXZNaXVVTWo0SzNFRUxlaEwvb1J0dGxBbG1KaVd1dWlIejZ5?=
 =?utf-8?B?OEJFQmpUNy92NTZZN2JFdktEY0Y5UFZ1N0JJWCtvUXNiUWZDSXlMODMzQXRJ?=
 =?utf-8?B?SEFqTGlwd2lLUTNWS2pidWRhUU5VQklhV3BiUUZNbk4wNm5Yb1ArNWJYbUxk?=
 =?utf-8?B?bmtwN083dkloRUZESFFjejJMcEhSTUpEcEJYS1lSbGE1L25ocGR0VmU2YVV0?=
 =?utf-8?B?QzIyN2V3UVJET3ErMFdtWFpNOFZNN3pSRXlRbHVLK0Q4M3dYMU9lR0JiMHFy?=
 =?utf-8?B?UWw1dDJJUU9iNE53UE5ZUDFPMjNMcGV5aUNuNUtSZjhobjZuLzFFMjdDUldJ?=
 =?utf-8?B?bGJSZURHYnVSNkhuQ0UyV1BsblBoUytORWlCalNlS1k1ZXYra1pacFBtVzdm?=
 =?utf-8?B?K1JybmRXY1hCbHp4dXhrb1dZYk5FZ0hxUnAwS1ZrZTRMOUF6VFVMSnVEWnlY?=
 =?utf-8?B?L0RYLzVMNkdUalFUUE41MVV6dUhzTFVJTW9VajZVRHlvaHZxRytiNnZaZmJB?=
 =?utf-8?B?UEpIaGFtQjlBelRTNTRKQ0lEOHhVa2dNdVNxS3NhcTBMT2RHZGRTdWJTVys2?=
 =?utf-8?B?cHR3UGJuS2dNaEhySGJ5TzJTMGxaK2xzL2E3T1dPRnpUNmpwZmUwV3o5dHpC?=
 =?utf-8?B?VTNjRUEydDJUSS9wZjZpMlpLSFI0WlFjbzNhQnBucGxyckQ0aWZHSGpZYTZR?=
 =?utf-8?B?RUhoKzhrUEt4SFZMbFplT2FTb1dTcHpuQWxsM2JxYTQ5azhWVjJoNGZ5WVhO?=
 =?utf-8?Q?pefehxXbDCHH5qVo3vstVvjCp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8b5937-a25a-49a2-efab-08ddfdc2367d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 12:34:33.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jk+JsWLeNm3gDFAhUl1jelxMc7P4sJx//5oOQWSWahs04diD3ejKcsfroZYi7N3onCJmhAMHJCwGqKkf5MaKPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6687
X-OriginatorOrg: intel.com

On 9/20/2025 1:50 AM, Tim Chen wrote:
> Allow architecture specific sched domain NUMA distances that are
> modified from actual NUMA node distances for the purpose of building
> NUMA sched domains.
> 
> Keep actual NUMA distances separately if modified distances
> are used for building sched domains. Such distances
> are still needed as NUMA balancing benefits from finding the
> NUMA nodes that are actually closer to a task numa_group.
> 
> Consolidate the recording of unique NUMA distances in an array to
> sched_record_numa_dist() so the function can be reused to record NUMA
> distances when the NUMA distance metric is changed.
> 
> No functional change and additional distance array
> allocated if there're no arch specific NUMA distances
> being defined.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

[snip]

> @@ -1591,10 +1591,12 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
>   enum numa_topology_type sched_numa_topology_type;
>   
>   static int			sched_domains_numa_levels;
> +static int			sched_numa_node_levels;

I agree that the benefit of maintaining two NUMA distances - one for the
sched_domain and another for the NUMA balancing/page allocation policy - is
to avoid complicating the sched_domain hierarchy while preserving the
advantages of NUMA locality.

Meanwhile, I wonder if we could also add a "orig" prefix to the original
NUMA distance. This way, we can quickly understand its meaning later.
For example,
sched_orig_node_levels
sched_orig_node_distance

>   static int			sched_domains_curr_level;
>   
>   int				sched_max_numa_distance;
>   static int			*sched_domains_numa_distance;
> +static int			*sched_numa_node_distance;
>   static struct cpumask		***sched_domains_numa_masks;
>   #endif /* CONFIG_NUMA */
>   
> @@ -1808,10 +1810,10 @@ bool find_numa_distance(int distance)
>   		return true;
>   
>   	rcu_read_lock();
> -	distances = rcu_dereference(sched_domains_numa_distance);
> +	distances = rcu_dereference(sched_numa_node_distance);
>   	if (!distances)
>   		goto unlock;
> -	for (i = 0; i < sched_domains_numa_levels; i++) {
> +	for (i = 0; i < sched_numa_node_levels; i++) {
>   		if (distances[i] == distance) {
>   			found = true;
>   			break;
> @@ -1887,14 +1889,48 @@ static void init_numa_topology_type(int offline_node)
>   
>   #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
>   
> -void sched_init_numa(int offline_node)
> +/*
> + * An architecture could modify its NUMA distance, to change
> + * grouping of NUMA nodes and number of NUMA levels when creating
> + * NUMA level sched domains.
> + *
> + * A NUMA level is created for each unique
> + * arch_sched_node_distance.
> + */
> +static bool __modified_sched_node_dist = true;
> +
> +int __weak arch_sched_node_distance(int from, int to)
>   {
> -	struct sched_domain_topology_level *tl;
> -	unsigned long *distance_map;
> +	if (__modified_sched_node_dist)
> +		__modified_sched_node_dist = false;
> +
> +	return node_distance(from, to);
> +}
> +
> +static bool modified_sched_node_distance(void)
> +{
> +	/*
> +	 * Call arch_sched_node_distance()
> +	 * to determine if arch_sched_node_distance
> +	 * has been modified from node_distance()
> +	 * to arch specific distance.
> +	 */
> +	arch_sched_node_distance(0, 0);
> +	return __modified_sched_node_dist;
> +}
> +

If our goal is to figure out whether the arch_sched_node_distance()
has been overridden, how about the following alias?

int __weak arch_sched_node_distance(int from, int to)
{
	return __node_distance(from, to);
}
int arch_sched_node_distance_original(int from, int to) __weak 
__alias(arch_sched_node_distance);

static bool arch_sched_node_distance_is_overridden(void)
{
	return arch_sched_node_distance != arch_sched_node_distance_original;
}

so arch_sched_node_distance_is_overridden() can replace 
modified_sched_node_distance()

thanks,
Chenyu


