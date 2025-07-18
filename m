Return-Path: <linux-kernel+bounces-736210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0300B09A19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092B71C80336
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD63B19E806;
	Fri, 18 Jul 2025 03:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+K46F+I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB8EEBB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808412; cv=fail; b=CAbFUGHIejjXpiZpbjIWhs53HkkBlnDaL6a2WuTZVq8zOsD1vJiCZXzAAXlODHU3uNSk14juneX1pitU+dZDLthEBOP3LHEBPKU6xpeXJMbaKlr3IsOtbz9FA69lfb6BmfL4ego9J3mgu0z/46ep869QDDbhqLaEK1vghMIO7Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808412; c=relaxed/simple;
	bh=A3J3aHClyRejz3nDEmys1uaPYh/nEObXco/VER7rQu8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gyxAsHckeQ/Zi1C7QwkFNoIUUzV9W/nBn5vIq/n+Ocr4Aq7JfD4vh94nlKB5n9v49gCkV/4lhBRIDJ2vX3VcbiKdrWEhijyEJ9RONSOD0ALvNmVgGOYCis20v4Ub0M/Q73ihrLNdXeLEHimg5cG2tfokJfGE4Qd0qwBr53RKKNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+K46F+I; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752808411; x=1784344411;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=A3J3aHClyRejz3nDEmys1uaPYh/nEObXco/VER7rQu8=;
  b=T+K46F+Igp4xd5AsZI1j+d/1FBvaV6rvDzUS5HiERDVT7Ekn8huTqWJs
   7URciZgpCuP/tqofIWUb1Ly9yU+igzZ/8tpBFHEE7xU7gV04jxnYie251
   YkGwRhWqXrADIVmw/IEwcH0DrtirNKIXYI6b3pN9BJ6VqVgS8er+EHU7E
   TtcG4ijgSNtg2TrfTw1bHrjSiaMb9p4XytA2lh9sR/46dpmywZ1pA5bVl
   440UEHfOOtVjD0l1H36A72zQxlEtWkRtlfxji13TswpK1LjrxrwEo9WeY
   oU5O9nm4+unDQH5X4y4pq9ZiTPK+xKEhxZeGRFHgHFVs3FPbu8ZX7gjL/
   g==;
X-CSE-ConnectionGUID: mNNycOrISLqSQzimAANpLw==
X-CSE-MsgGUID: 6nKs1+vkQjCmwAqULb8vww==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="65671076"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="65671076"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:13:30 -0700
X-CSE-ConnectionGUID: EACEIc8ESdO+Egfs/K7Dzw==
X-CSE-MsgGUID: 7PRvpdXqQZ+DFr6TBXGGHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="181665200"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:13:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:13:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:13:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.71)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:13:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zxp2i7S1xaHdkKGpK465B4N7HW+DTp2tpbExF1zMPX4ScQHUIY+WqbTNufiSdIUodzqauiqU20JhBfyp6cLjuQgbcbsO/QMVCPbfVnyoQW696oq6poI9lrphP2N8FFfy8r0Cbj2FN0EnitTO1HhvyiFRfrXko9iSaaFHc1KmKsHppmVILe3iXKZWvxq+oFTn9+JJ6gSoAEngbpPnogP0Or/EgLJwapeAHt9bRde23go9r8aaDsay+PDYWPuXozPSpJISmPreQcydjKwK/e7Yg+I8Lo10u9Tr58tY912ZfvZZHkTrKEQ+7Z3OXDDSryt2184WrKDALySwUqr9g6GhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Zh1MBCC2Gk38HMrJPfkPrzzLDx5g2kiK4YGKjujovI=;
 b=Yv2ViZQ0efp/4U1rxdD9HXAfxkKCYvVkYFONsOHKL+IZzRrD6CXWKQcSEecq8e82drHwfQRDk06pCHTg4+Gja+oJLNGeBh8IDmyAyDcxtwMrmpiY52Vu6G2jGEvQk2pjKZUkYqVKA2jhAPpZfR6P1ouOlX/vGC8g9tfQlBqUoo4OkwVY9bExI8vb4K0lOPCxo/MM689JfwfGdHd0P/RWH8uhOmX9JS8MrFTrt/jVKzxen/VvSNLGpQ8IS4OPkZy+O5sRWJTYNvYJ5BY9h//cuh6iyWBarWib2pJXz8OJVQ42mEJeelBH7MvGosETQW0P0uoSnpUZwHOoPHluJLbFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 03:13:21 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Fri, 18 Jul 2025
 03:13:21 +0000
Date: Thu, 17 Jul 2025 20:15:04 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, Karol Herbst <kherbst@redhat.com>, Lyude Paul
	<lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Shuah Khan
	<shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Barry Song
	<baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>, Alistair Popple
	<apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
Subject: Re: [v1 resend 02/12] mm/migrate_device: flags for selecting device
 private THP pages
Message-ID: <aHm8OJPDLd3muPC+@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-3-balbirs@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703233511.2028395-3-balbirs@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|IA4PR11MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7b4763-b248-4d9a-9a7d-08ddc5a90d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THJQZHh3dklKVXRLdzc5alJRRlhEOFBqRXB3WjNkVTBqZjAzVG1NQ3hnd3N1?=
 =?utf-8?B?V1RnTXB4bFZBeVZJQ3lialc2aGZnU25yRzRHdU9kNXNqUSswcUhOQUNXQ3dl?=
 =?utf-8?B?c3ZwRFRXT0ppd3RkbFFnMHlxN0tEMGkwT2V2V2txV2JOcWI0bXZZQWt4dnZU?=
 =?utf-8?B?M2pjTDFmOG11TThlVEdhakJUSnQ1RDNnTmJKMjBGTkwwU3RwU2hqUmJoRTM4?=
 =?utf-8?B?UGZ3YlVBOE1pa2Qvb0NuY1J1Smx1OXc4dEhmeEhWc0FWTEFZdEwxQmJqRk1h?=
 =?utf-8?B?STI2Q2JTbE5aQmtLNjU1R21iRE45MzNOUHV1TWlWUWRPYzlZbjBQMDZQZ3c2?=
 =?utf-8?B?VzlNcUFkaG1EWmVsYW14TjRLWHdsN1JERnFPTEw4VUhtVnVPOHNOdE5MbGNY?=
 =?utf-8?B?d1VTRzhuOXZmb2lheCtKKzdIL0Q0Yzc2NStHejQyNEkyZjNtYjNnKzJWR1Fj?=
 =?utf-8?B?bEE2bFVoK1VlUHlnd0p1MllOOWpIR0hnak1sbjZzWmxQS1RVT2IvT20yUWkx?=
 =?utf-8?B?ZUcwbWxRODhTTytjVG1IOWhJZkNGSVc2aE9IRXBJdjg4YUx6R1hyQlVGbUpK?=
 =?utf-8?B?d0Y5cVhmTzluYVhvaHR1SUFxeWZESmhYdG5BTFVKUDNEYmxjbVFSTzRUL2dI?=
 =?utf-8?B?ekg3Y0srdElJVHdhaXpaQmNCNCs2ZDFPRTlDUGNrdHp6VmxxeUpKOG5ZY2Fj?=
 =?utf-8?B?dWpEbnNjSDdYczVieDlXczdUeUJzT3JtcFd5TWZxUlJlWitRQ0Q1V3l1Q3J1?=
 =?utf-8?B?bENmekI1UmZKYmdpc1pHR3kxcUl3cnZjalF2ZU80eXk4cUtoa0lkZTcvcjhs?=
 =?utf-8?B?U2pGS0NlN0hDS3Y3bzZBdGNFZFVBNFg4VDdyQjhlallNSDBIelF3Zzd1K0pR?=
 =?utf-8?B?STI4Mjg3RzdGaFYyanFtVEJVNUJwb1h3NUpsM2tFamxGcFNHdFhTQXQ3cTNl?=
 =?utf-8?B?NktwQm5iNVNmMXNxS0gwOE1LUjZRcTVLVXRHTVRQNEU2ZFhSdG81b1VQSkpW?=
 =?utf-8?B?eXpIMEk5Y0xCLzA4NFdFOStPaUE1K2prUUNmNkE4U1VRcmhzZjJQREVMeTVL?=
 =?utf-8?B?MTNPQnRLckFQNUtRa21DVVNRM3VwcEVBZ0FCWTlTY3E3STBOT0ZUVWZTNlh4?=
 =?utf-8?B?TWxuUnViVGxsMk1yejNyU3hZelgzZEtnOWxEZVQvU2MxclhOTTYwU3NXekN2?=
 =?utf-8?B?NW1PSy9SenlCakN5cDNPWVM0b1ZXWSs4ZjkwYnBJZ0tka1B6REhiclZYbVBa?=
 =?utf-8?B?YTdsT0FoNUpVR2MwWjB1d1QycGx3OWVObzljSUFPb1R3ZVpvNGNlaXJ2aW83?=
 =?utf-8?B?MXZ5S3hzKzB4aGlDT3ZsSDdGdGZBOVBvdzY3RVp4YTNuelZ1N2hyWHhVdnVV?=
 =?utf-8?B?dFBTSWowQVUxWFZIdnZRYUNKUkd1OFhhY2hTbWg2VjBUMk1Vc0NvbmU2ZWFL?=
 =?utf-8?B?Ky9SSWYrMjIvQjlWKzl1MTlGN1E0ejN1S1NQemNnZU14dGNFdGhFU1ZrTk9n?=
 =?utf-8?B?cGw4NDIrcWpndUVQRzVPVjJ6YjJvS04zR1g4REdBOWR5YXM4WCtOOWVtK1dG?=
 =?utf-8?B?OTN5NEZzaFJ6NEliSmxUT3IyRFp2empDY1VFNEQyVG5VZG93SzFJYkFadFBE?=
 =?utf-8?B?Q3JPdGdMMW9OM0RmTEoxaW44WjAvZWM0OWZzYnpxNFJaOERIVVVBaGliZWVX?=
 =?utf-8?B?SG52a0hxWVplcDN0dEk1K0xOR0wwWWZXYlZEMEJrSE43R0VhVDIxaDhKQ1BE?=
 =?utf-8?B?cS9UbG9ST2hyN1RDRm1MOFBGemlDd0dYYWxDY0hndmdBWWxpZkJtdWtLdHlS?=
 =?utf-8?B?Qk1YNTB0SThNMTcrVXNpL0ZIOVNiUWJ1ckZhbXhhdG1iVGFSRW9TVUFJblZY?=
 =?utf-8?B?Q1lodnpkWERzOXY4TVVhZzkzT0FhZGVqQmxUbmVIYWFwYnRWMFkyTlVKc3d3?=
 =?utf-8?Q?YVEiGS78I5s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExUZHI3N01VZEZybng4NExpNVRQalI0bmxxc1dWbzN3TzVoRXVqVmFwbFBQ?=
 =?utf-8?B?bnlaNEtwY2o4N3lKWTFOTUdkWGhxMGNsWXhydm0wWEdLWmp6RGlhY3NaSGRZ?=
 =?utf-8?B?WVozNVB3U0FQYlpaTFBMUUhlR21YQmp1YWZqTDg4U2ZtbW9WWTZCQTZYaXRW?=
 =?utf-8?B?U2p0M1o4b3dzZXJKVFYzYXJPODZzYUtKaFRRNXZrOTNMandoc0pHNU54WTNR?=
 =?utf-8?B?V25IREdxemZVczdRQTVVRVBWTjVpN0Y1YkZzUGdtWXNlVzE0cUxLNnNDRm5K?=
 =?utf-8?B?OEpWaFltV3drNFlESEYyWkNZam1jRGNhR25Fdmw0eFN0Q0JoUVYvQ2RQL1VN?=
 =?utf-8?B?eU1MRlZkM3F4MDZQbU96WGJ0R1BCUjEwSnZCTWVCOUVUb0tNbFhuMlZXK3VV?=
 =?utf-8?B?L05SdTdqeCszM09yRlBUWjNnVjErSkhCVFRPODhmUjVuU2NPdC9DUDJJVEhm?=
 =?utf-8?B?bnlmeEhJSVVLcGhzQnpoRWVhZnl2OTVta3AyYitLSG1SWFliektXdnBjeTd0?=
 =?utf-8?B?S3RtR2NEa0l6ck4yMGk2Zmh2a3dlbGJUVnN0ZnZrYWRLbUpZMVhFNzFLMWVW?=
 =?utf-8?B?TXZ4dUhaTnN2Q0E0TnplMVBHaW8zNlBOeFR2L0gxM1hBTGdvSVNBSVJTeVRJ?=
 =?utf-8?B?VURJOS9LRjFkcXR2WnZPK0FmVkRSUnd3TTNoSzY5VE91dVFnRWkrbEtiYVFp?=
 =?utf-8?B?R3pVQzBmWFdtcGR5ODUwbC9sYm1tK3RrNkw5aUVlQklXT1dxUW1yY1V6M3Ur?=
 =?utf-8?B?RVlOK3Q3VTRzb0pDVnB0VG45eHFHamkwOGNqb2krWVZ1Y1NWUGQ2dlFpTThw?=
 =?utf-8?B?WnR1NmZHM1A1QVZIaSt6R1VCNzB0OUVRbFpxWTZiRHFaZHJnWVpVRmhWQmxx?=
 =?utf-8?B?VnBPMTQzUktnaUlPM2wrTlVVOFBkNkk4ZFBjamR3KzNYRUx5QjNWSElDV1Jl?=
 =?utf-8?B?ZGgxdTFJcVhqOG1EaGFSS1d4UDJFR0czRTNETGQ4dVE3NFQyNFNhV0pGeDZN?=
 =?utf-8?B?SktMSmJEdEZVYlh5czJxcjBoS1FYK2VtMVJxamhTR3AzamVMQzZTSTBoNzJK?=
 =?utf-8?B?VFhsbE9RK0ZJd1J6a0Y4L21kNTlwMklFQUF0eTVoaGYzc29sYjMzWHZSS05V?=
 =?utf-8?B?SzdFTit5UVJlcGxMLzZpZWw4azJkaHlndkJ6S3M4RlVqSGVjNVU5a2FKNGw2?=
 =?utf-8?B?VmhIQWtXWEhFaUJIQ2dMeEFxSDZIajZUU3ZoUlZENk9paGZ6d1p6VlZJVk1k?=
 =?utf-8?B?TE14MU03cGFROEVMY1R3R2d2cXk3OTlUZDVYdXk5Ti9Mb2hIeTVIVnFMb1c2?=
 =?utf-8?B?VGNRVlJOcWhCVmdpbDhTQmU3WlVCWm44cEwxOXU4QTJuT084N2pKM0hhSHVP?=
 =?utf-8?B?UVp3TUhLRkVmZkJLTmg2aktQT2MyVFlyWkhYV1F4bVd1cW15ZE83MWdDK1FZ?=
 =?utf-8?B?NlBKVWpGbHplK2t3RmdkMUlXOEF5Q21ybTd0WHVlUUNtcW4xR1VJQmVsalJt?=
 =?utf-8?B?ZXYyVmR2eURxMDdqc1BKbEdmR01qTkRlUE9SY0FaSHIxejR0SCtYYnNzcXFh?=
 =?utf-8?B?azczMXJXL1FzK3lOK0FWV2Jkem1OWWFtYVczdXFJR0x6QTZIUi9xa0dDaUpQ?=
 =?utf-8?B?WkhFeFlRV3A2RTR6R3cyckVEUHlMRFNveGRNZ3ppMmpGb2lETnEzdmlzczZY?=
 =?utf-8?B?eDlPNlBGRktaa3FIaUJ3WDliQW5FTmdaVGZ4M1ZKYmV4dk16MUhwK0tMYzBV?=
 =?utf-8?B?c1E5QkNpeWJJWE5uaTZWRE1XUG5zNW1rRnJOU09HUHN2Y3UvdTBySWdkOXZI?=
 =?utf-8?B?OERocEh5eEtDS3FUZXBGcGk1MWVmYk9uc3hEejJ1VkxKSlNDeWhXbi9NK0N0?=
 =?utf-8?B?N1krNTR3K0xIUW9sTlNPdlkvYW40dS9yeTlrRzRYZHdDNmtqZzN3ZjcrVkdx?=
 =?utf-8?B?SUk4aTg4aUlTYXRQd3pwTVFxMmorSC9McEJPWS9KVEdRWTZjb0J5WXV2dDF4?=
 =?utf-8?B?VjdBMHphdkhPdFFkOXNoTGxqdzhYcmVLdnFXUU83bFRCY0JQZGdFNHkzdEk0?=
 =?utf-8?B?YmdrTnBnSzhYck14bUJlODhaL3VzdEdFaFZuU2JKQjd6cWwvSUNJTVNKbE1O?=
 =?utf-8?B?SktiLzdYVnhvdzY4TjMvL1JFaHY4UjBHKzh4Q3lTTGtsNGZWOEpjWEV4Y3FH?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7b4763-b248-4d9a-9a7d-08ddc5a90d08
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:13:21.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESyGE18SpDfXEFsJzudTlT1b/4MbyCLCKYgxaYj3QmVN5gJ2KRJv+HKVqIYvG5YM1jIROyArIYbSYswBEv+tPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9204
X-OriginatorOrg: intel.com

On Fri, Jul 04, 2025 at 09:35:01AM +1000, Balbir Singh wrote:
> Add flags to mark zone device migration pages.
> 
> MIGRATE_VMA_SELECT_COMPOUND will be used to select THP pages during
> migrate_vma_setup() and MIGRATE_PFN_COMPOUND will make migrating
> device pages as compound pages during device pfn migration.
> 
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> 
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>  include/linux/migrate.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index aaa2114498d6..1661e2d5479a 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -167,6 +167,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>  #define MIGRATE_PFN_VALID	(1UL << 0)
>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>  #define MIGRATE_PFN_WRITE	(1UL << 3)
> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)

Can some documentation be added around the usage of MIGRATE_PFN_COMPOUND?

In particular, how the field is used in relation to the migrate_vma_* functions?

For example, when MIGRATE_PFN_COMPOUND is set in a returned mpfn, the caller
should check the order of the folio associated with that mpfn, and then expect
the next 1 << order entries in the source array to be unpopulated.

Likewise, when a caller populates an mpfn with MIGRATE_PFN_COMPOUND, the next 1
<< order entries should also be unpopulated.

This behavior wasn’t immediately obvious, so I think it would be helpful to
document it to avoid requiring readers to reverse-engineer the code.

>  #define MIGRATE_PFN_SHIFT	6
>  
>  static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
> @@ -185,6 +186,7 @@ enum migrate_vma_direction {

Maybe out of scope, but migrate_vma_direction is not a great name. While
we are here, it could be cleaned up.

>  	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
>  	MIGRATE_VMA_SELECT_DEVICE_COHERENT = 1 << 2,
> +	MIGRATE_VMA_SELECT_COMPOUND = 1 << 3,

Same here.

For example, what happens if MIGRATE_VMA_SELECT_COMPOUND is select vs unselected
when higher order folio is found.

Matt

>  };
>  
>  struct migrate_vma {
> -- 
> 2.49.0
> 

