Return-Path: <linux-kernel+bounces-725548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0390B00098
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E63584A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3EA22331C;
	Thu, 10 Jul 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIg2Xg9r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283AC8EB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752147126; cv=fail; b=sndjBraFx5fvGFMhPkYkE5AkC0Sc/EU0VqFGIw9NLXxPKCbAQoP4bKy0rk724thGr2Dy5k6phoaYA3oF5Zqc3w50HgGs78SWA7L0bAS/AdWciSNqO4Ajp23CdNkBAp2TB89pHeuGwHJGjHAM7v4OXb96lz9QxLFAYAoMPMpl3H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752147126; c=relaxed/simple;
	bh=56wnYfXk8353v7sQlLLlS/6SldRkX6fYLZxoBwoHmjA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8/+unXq9Eddj+EWPBJIES/76Lu3MF3jVAgZYibEJsiXD4N5vgy1acc0T0MOl4oj9ytzazIl6CngERufA7ozPFxksfB3U+SvPcXhCX55w9ByDVBJib8sEuzwlIF+6GNPxRMlcEBeXsl1EOqW3VncKdRMN7NqMzHeZ1YsBAUHsPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIg2Xg9r; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752147125; x=1783683125;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=56wnYfXk8353v7sQlLLlS/6SldRkX6fYLZxoBwoHmjA=;
  b=LIg2Xg9rM2Q52xm+r65alpzVSvlcKAYIC8TLEJ6RQsYBS6LIlSfnVSom
   c5D3vcaqIXPfLQedeFa9vRQ/rbTLGiPpWdydSCfQig3ivqHsIKS87qBlD
   20wZRTQpDWvHaCcGM4F+Q2SCWc9KCph+YOXxXeFOyC9vVdQIOQTUF8irT
   ojdWfU8CCqF+3Y4X/3auhrRossL0jC4wuSpdEH5uXRKjyM84KUwLJfqie
   Ogf/IeZBhdN7ypVPVsBfB0v66jnM/gJMMpSwOKptFA9NOM8WXPfTyvDeY
   N8RUprXDx4zMgCMJ7Jbyn+oFuw2rTSMqcZu0lVAnVacur8Xl066UTZERt
   w==;
X-CSE-ConnectionGUID: a83CCQyVR9a+LZ4J5IONdw==
X-CSE-MsgGUID: vqn4y5a9TDiHHTwfbU2z4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="65125401"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="65125401"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 04:32:04 -0700
X-CSE-ConnectionGUID: X9yV6vTGT/apGRrJlvBk+Q==
X-CSE-MsgGUID: y+WCSwDtTOC/9/1L8MfdYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="179746635"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 04:32:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 04:32:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 04:32:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.77)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 04:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jegWLMmQhVpMxR/bXx0rmJay2FTO//TjqZsY2Qv81hz6wTAM+DK7OWqI0yf0dE/jtTpDqhEOhdcAin49kUC18Ip5BFqi7Lsfr8BOnV/DyHl8WUztqGtCI4WyW6ydFE42BD+KIxY1FEQ/Z1KW+p/idDcwn6h/WvhObePjmGNidkshdMPVaG0oKA6mAEf/e2U5b9OeBFBbW/tWY4fftcXRsQ31h2Fc466Q+94FtAmmhTpq5VguNAKl5ZcRuJyH8xsYoE0HULWPu44ZqcJPO4AKCbTMkodZ5SHpaym3hotjD7Rhr0gKrMN0bpFqk9yVogOVMOxEKWdHjSpHPD2Ut5pN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSa1sETE18HwG9xpnSXZMmQUl0ImElfd10MStVs5v88=;
 b=ZOM/RYSviVPUKis/AjbkeHL/S02v6rcsy8ZuzE8VG/RFlWoqscMlWOov/+gRAeD1z0a27Bf41pKGlYudocH0ZnF+RXdy3Fwg6B/EH7K4WFrSBZEBHmW4h+jw2UXCcyXgbq+BxZCyVh4mwrE7b7VGAdgqcqmHFtR7qwf+H45rGFcfTgdsY4vOWIXoOICxl63iGQwAdU7g4SL1gvrn/mSIseMt6I7L7TjhldlvdfEO0epmCYr1AqHOsplZYQAbXbCkX9X658yL34PIHvnOBaioAk4gVUAYedlV/P6leeHe9iA4iAxfPr757NdNqRtE5B1IfJzxAAPuwiB6eg8tDZTLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Thu, 10 Jul 2025 11:32:00 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Thu, 10 Jul 2025
 11:32:00 +0000
Message-ID: <42d5e1e1-f418-46a3-9b80-67173609d390@intel.com>
Date: Thu, 10 Jul 2025 19:31:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:sched/core] [sched/smp] 06ddd17521:
 BUG:using_smp_processor_id()in_preemptible
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: kernel test robot <oliver.sang@intel.com>, Ingo Molnar <mingo@kernel.org>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, <aubrey.li@linux.intel.com>
References: <202507100448.6b88d6f1-lkp@intel.com>
 <6cf071f3-ff5b-4025-8ce7-2f2cceb03984@intel.com>
 <20250710062528.T-Obm39T@linutronix.de>
 <292e70ed-aae5-4f52-8f85-80cba7ff301d@intel.com>
 <20250710081114.5wnABNG7@linutronix.de>
 <99573578-95e8-4b97-b2c8-d8229e4816e5@intel.com>
 <20250710104740.XLv9MRX1@linutronix.de>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250710104740.XLv9MRX1@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 90401aef-651c-4d32-537c-08ddbfa5628d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjBGZ3FMU210WFF6TWF6dmdwK2dYUzY5ZjFYTGRlbFFlTnlaT0FzQkFBWTB2?=
 =?utf-8?B?QnlsSHNJbHhxK25xaUVJd1ZmTVR0MkhUcmlpRlU0ZjA5Qzdhclp4T0lwMU50?=
 =?utf-8?B?OWQyanVJMWZDQ3dsaEd6eEhnN0V5KzZMdGgyRVFlSGlIdHExekx6V2VwT0g1?=
 =?utf-8?B?bDRyS0kzRkg3N1NQaW5MMnNKUE1vdjdDalJQbzYyMFdNM1hGT2E3Y0VLd25Z?=
 =?utf-8?B?eUpMaUliTmFQbTlIVGd4NWZuaDVHNUhseHQzdm1Oek9rT0JqeXdwSUJpQTg1?=
 =?utf-8?B?Y1k2S0hNWW9xbU53V1p0NDdxQ2gvU3VJTHdtbnhVWHl4d3h3OEJtSytNRG1S?=
 =?utf-8?B?TzNJcS9jd2lOeVg2Uk0yQVo2YklGL1I4SjdJY3FRSjlyUUQ2RC9VOHFhUU9L?=
 =?utf-8?B?eHZDdFdIcFJkUkJtV0k4TjE4Z3lQTFhpSk1sVVBMOGw0UE9mT2R6MXlRNDdy?=
 =?utf-8?B?c0dUOGlUMEJrMFZBVERNd0psbGg1b0QweEFic0w3U1c4MlB4K2d6MDJNSk9H?=
 =?utf-8?B?aWhVSEtTUEU4QzlSYTQ0N3pxUm14K0toTy9kRkczR0tnT1VqdldoajJlVEFn?=
 =?utf-8?B?N2szMlc2S0VYSWdOTVk4UkhwYm1KNXNCUExZZkJZU2dMNERjSVJMRzlrRFkv?=
 =?utf-8?B?QVlqWlZJbU9vek9hY1hQTW5FaFN6SkNSbUNFend2UzNjOEtFM0xBS1M3OG1I?=
 =?utf-8?B?c3cwNmJDL1ljWkR3dlVrNVNWV1dGb0VHb3JYNE0vcmFlZmt0Zm1oQWNNV0Vi?=
 =?utf-8?B?VlBDSVcvN3hyZWx1M016aHJOT1NGY04vNFhTeTNBRkIybUJma1gvcWpoMXdP?=
 =?utf-8?B?YVNGRHhya3hoMml3dDFkMnVFQlBtTDdUNG10a1E2U3I1N1BFS2ZmMktkYUVy?=
 =?utf-8?B?UFdwVW1BeW9UU29qd0luemt6SlQ1NlczN251ZTlIbWpkbW1lZFh1djlMQk5B?=
 =?utf-8?B?L1hRQytuU2wvUjRMb2VJa1YxUmtwNU1pZHduV1BNSTIwNmE2WmJQNkZQQzNH?=
 =?utf-8?B?UG5VOGtjbS9BOFlNMHBmWTBtM2tiU3lPMHlPbHdmZkZNQnBPc0FGM1dGTkNQ?=
 =?utf-8?B?VmdLZWRURHZIOGJibXorT2FWaVZGSFZwclNaUForYWkyQjFqR1UxY3RYQUsv?=
 =?utf-8?B?OTFHOHdzZUdSbEZac3VJdHcxRTRlSnlWdC85dW9yWks3Z1lMSm04bjFKYjlx?=
 =?utf-8?B?Q3hXcGkwTnFxZkg0Qnp5Q1Z6NUxSZ0N0TGhtemErcUhUZjhaMG42MHBHellY?=
 =?utf-8?B?eGl4Z25Kb1R2S3RPTDloL0VIRUVaZ2w5Y09nVjN4TlYxcFpVcStMR09LTVF3?=
 =?utf-8?B?VjEyRUo2aGtqeTBCUVFPL20wdlIyRXlTWkVUOHZzY0lSMXh1SmVtK3liNERL?=
 =?utf-8?B?OHY1UmloY2tyWE5IUENvbFcrcU1CQnZCVnhsb3VBN0ZGMnVmQm9IRjF6bHY1?=
 =?utf-8?B?NXRVY2dCb0tndGFxZEd6bmhUSmpjVzd0eVlsRTNIYzZrZXIrZEg4RllJMWJX?=
 =?utf-8?B?UWYrRGRTQW9Tb3kza0YxcW1yQUNhT2VNNmQ2Z1BKRGFCTlM1RVY0T09zRnF4?=
 =?utf-8?B?MHZRZ24relNUQWtFc1VCdndMNHBVOWR0ZHpiUGZxZEkrcnJLaUVlSUVtRFBy?=
 =?utf-8?B?Uzl3Y08zdThVVjQxWldaS1FEbjl3MmZXYzViU3Avc2ROS2NoSGgrblBXaHpG?=
 =?utf-8?B?UkNBOG9uV0VjTmhSNWhYWjlxNE8yakFHOG4zZVY5V1ZJN29lb0lXR3FhVnQ4?=
 =?utf-8?B?ZjB3dGYxYUthZTByL2oxYno0RGlsSG1Rd3hidU84SVhvZ21lQXRXdFVXVWFo?=
 =?utf-8?B?R0RWeGpEQnZtRXRwMW5Da25iNTZMaE5XZkljcU1xb0llenZLWFBGMXVmbzZt?=
 =?utf-8?B?ZjgzYXdzbzBzenRJTWdQanJtUTFWRGYvdzVRTXpnNWIxSXZyK2wrcEk2UTdv?=
 =?utf-8?Q?fwF/az6X9SM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHZnUjlHYk9SdGFsQ3AvWEExcmpQZTFrTmhWa09UeDRqeHF6V2tBMndaYUV4?=
 =?utf-8?B?RTRpczZjcDVPRjFrSHk0OEEyQU85THBDOEdJMzhZdjNoR0pzZjdtSnFBVEtY?=
 =?utf-8?B?TXpBM2RWMWluenhwWUhFZ0pRV1l6SFFIY0k4OFdQbTU1VzJFOGZjZFp2RDRI?=
 =?utf-8?B?aTN5SnVUcEVZa21hc0d5SkNVMmIvVTY1NTZvREswK1dnbXhJaHI3N0hpN0V4?=
 =?utf-8?B?aHJwREVhek5WYS8wU3MzR3VOdUtFU282dkh1VXIvUDFpUkNwOUVFUXl1Yzlm?=
 =?utf-8?B?TU5HYmRaWUg0QVBnTFZRVU85alAvakRXMkJhTUtkK202N2I2ZDRyS2tuMVpD?=
 =?utf-8?B?TzYwQUZmcktJejkvZDlvc0tacW5DT1ZtdExFUjVjdUpjV2Vrb2lKeXBwUFNz?=
 =?utf-8?B?WHd0MEZmQTZxWkZJSjU2N3pVVGgrdVIwZ1l2dlBJOHJEN1R6ZEY3ak1ucVB1?=
 =?utf-8?B?UEU1ZXBvdk9kOW5QcDJEenl6MkRIWFZ4Ykt4VTJtY1FrQjJ1VXNSUENRTVBY?=
 =?utf-8?B?RFFpdW56UzhBRldERk5kSExBdG92Uis3aE1lMFpTcG5ZcndGa1RqK2s1cHd4?=
 =?utf-8?B?VTZINHk5WlBPcDlXaWtibzdjVE1lbVBXK2cyYlRWMmlOZFhLRnlvVHluSEph?=
 =?utf-8?B?TWJ2MGg4NWFLTnhZMWU3dUhzL0xEY0dKQWQwVUdYR2tmVGJiK2pGeWE1aDNo?=
 =?utf-8?B?NWVqZ2lOeHhqdVhwRW95Y1JsQVZFUFVKUC9VWVVhSXdjMGYySFlvZjY4UXZL?=
 =?utf-8?B?cGlyaVFtRDM0YmtnZWwrN3pyTlF4WkZvalI4S3d3WVFDd084WnJWM0RRS2x6?=
 =?utf-8?B?aitQYzU1UUI0emVRQThpdWlCbEJxdkhRV1Y2QzFKMEFTTEVSZlQ4WGk4RGNV?=
 =?utf-8?B?SmF0dE1MWmk2dkZvWXBZWlpldnNkVlgvYUxaU3lsOFphU3dJVWcwQ21IYUxO?=
 =?utf-8?B?NHNGR2M4YzR5UnkyUW5pTDBVbXJsZzJDUTVXNno1bDRjYnFLTmc0djY1NElX?=
 =?utf-8?B?ZVVSUGYyZ1dLek9zcWdMYnJieGhVMEJ1VUFQNkE4WlB6THk0cmswYW11emRI?=
 =?utf-8?B?R0crL1k4dnJVNUxkYWMvVGZrencyTjVRY0JEYmRxcFRYZWUvb3EvOS9abVFT?=
 =?utf-8?B?U0dDT1h0NVRyTWJqL3VIamlrd3dRTFc0VWxEWDNyb0ZPcytCTWZBRnRaQVUv?=
 =?utf-8?B?ZzdGaVcwRFVuYVJ0dzdycW14NUZDNjUvUDFHa1BjQ0xaemRuOXcvT3pKQlNr?=
 =?utf-8?B?T0tobG1uME5meFcvTXg5STlRdkFuaHR0VDBUcnZqM29HWFJKd216SXpVbGpx?=
 =?utf-8?B?QzgrRDdLdk1JclhhN3ZuWVQ4ZFpESjB3dWZUOVU1eW1leG5rNUdUVi9yaSs3?=
 =?utf-8?B?QTc0ZHowUlBsaHo1R1hrckhNOFFKQzA2K0VIVjNlMHZQY2JJaWhaZHJ4bzNk?=
 =?utf-8?B?Qk1SMm1qaU55MHhQQVFHYU1KQU5Qbi92MFErK2xyU0pxcStaMHgyTmlPbjYv?=
 =?utf-8?B?YmZuNVRYVzE5WUNnMHd4WlNYN3dZSjY5YmRSeGRpQ0FrU2E1T2dnRXlsbHNK?=
 =?utf-8?B?WTdKMjJDZEdVYkJlMmx5V1hXMjl5OUh4dW5aRXNtRjFyam00bUNqSFFCWWFn?=
 =?utf-8?B?bzVERDdXL3VLcjhOZlFBa29jb3dRNjNoQ2lxVUJYcm5SY1hwZzJURURBREww?=
 =?utf-8?B?dDRNczVBaCtSWlFvakljekxTakM4R1RVcTNwWjZNQWhOcG1jZ1BsQVlQQ1cx?=
 =?utf-8?B?SEorTm9VUFNVU0FZRENZVFdleFIxQ0cyZXNYNkR6ZTZhbEZTaWYwck9pTWxR?=
 =?utf-8?B?cXNJT3hRRzVMWEc3MXpVZVZpa3pHc0pUS1dFSTVtYWZ0TmEzMnR1a09POUph?=
 =?utf-8?B?QVhvbStxQmFJL1lkYlhNVVF4NWl2RHpkSEl1Y0E5b1pBelZpaTdmUXYwNDBz?=
 =?utf-8?B?bVRneWtjS0Fsakt3M3cyUVlqalNDVDcxZkNzamtPUGEySkFncVFzVEN0SXNo?=
 =?utf-8?B?NTdCNFE1K1dHaUNzWVRtVkNUaHBPYytoSzd4TnpRZVBObldwOVBxQ2ZzQlJJ?=
 =?utf-8?B?QmpUb0VONFdUdFlsNUs5L1k5bnl5UktXRG9Bdkdid1ZYUlVmdHBTaVgvOVNL?=
 =?utf-8?Q?o0a4jqHegXR2yYAC503dQIgAj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90401aef-651c-4d32-537c-08ddbfa5628d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 11:32:00.6241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ0aA9zc2//hvGDcd9Xeujv6Bxsq2TEtUDCNKn+CFaEUmq3y2ftMSPArCfEhK0JcoDFPpxSLO0KuaYTZN2W8QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com

On 7/10/2025 6:47 PM, Sebastian Andrzej Siewior wrote:
> On 2025-07-10 16:29:51 [+0800], Chen, Yu C wrote:
>> I see. So there is still a CONFIG_SMP to check migrate_disbled
>> in debug_smp_processor_id(), and that was skipped if we do not
>> have CONFIG_SMP set.
> 
> Exactly, sorry for that.
> I planned to let you do the figuring out and sending the patch but got
> confused midway, had to look it up and then had the patch ready and
> decided to send it…
> 

No worries! Thanks for the patch. Glad it’s sorted.

thanks,
Chenyu>> thanks,
>> Chenyu>> Thanks,
> Sebastian

