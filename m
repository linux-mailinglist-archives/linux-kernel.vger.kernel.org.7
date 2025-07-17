Return-Path: <linux-kernel+bounces-735842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD380B0945C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF703AC2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9C1302CD1;
	Thu, 17 Jul 2025 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bq6HJzcI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB631E0E14;
	Thu, 17 Jul 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777978; cv=fail; b=D81G3Qm47S8yavAvmMEtcH6jh9BDDN/qwpoRWw8pZxyFavul011bn31g90RsPEen3JzUZYWG5w57DhFULzV/E/y8gqlkHkztGJvJ8FIytgULy5CSyXLbAiCkKSYkk2EVhNiyTMqzTHGqCwqoaEdPbLHoRdwhlFkUJLaqinlIFzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777978; c=relaxed/simple;
	bh=crqvdv5QGv1tytXOqqsBdclIzgquC4436YUnlL/SZ48=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BB+NtvPYoUG99/HJvUgCdrdL89KFz+FRicGwwX7b9vuagaPkoTQcxeQi59BbIcnO3pfYmbIt7UyFegCJoY44Hdfp4lJDFWTUz/u8IbJ9XD8hjLavzjm/+HxlY/W9GByornmOp8Uu3TM4Zi/Al8iS4UJSK8Mx8Bsu6PJ5GX76OLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bq6HJzcI; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777977; x=1784313977;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=crqvdv5QGv1tytXOqqsBdclIzgquC4436YUnlL/SZ48=;
  b=Bq6HJzcIxjV0VmkBoE7VJQzJ4KcSjffPFKR3soQn7a95CdsSGetleU3U
   lmJrpH5PoCBin+CtIst7ZAGXefkiy9ks9VMaBPffB7uFEv+SllDrtAcXb
   Rv0qnbF15WNR6FqhLNRIdfe51tCyKLE5fR1VJ6Km4mwgMt54J1cKTSmJo
   5O4UAGpQF8N7qBB3PfNqO7ti/jk/SlCpc4DRfi+GdgTGc90SPHzqERNTY
   C0xf3pRvNbnEVkRAZn5L/9ssg0+3uge8y4JuaGzq9/nL1qXFKFKvxHFQQ
   R5TQx2lEw7qr4G2RT5TlFdMpneQAPBNovrs97jHOFls+vts3y7x77DUnN
   w==;
X-CSE-ConnectionGUID: nZcd1UzmRPquddJO+Ycf0g==
X-CSE-MsgGUID: FXVCrZxDRmSxlT+d3kFeYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55192120"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55192120"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:46:16 -0700
X-CSE-ConnectionGUID: DF46wKwiS6+gEphGQyGxgg==
X-CSE-MsgGUID: n7AiwL7lRU+kuFWV5PqSUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158440612"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:46:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:46:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:46:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:46:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=in+BD2JYo8ogrYXwWnap0k51mLc9bh6gRVOeqphmFD67J9YJEhisCTj3HUiqq9hX+BK9f8DIoB/mWd5lWfoSJ6JieoDxKe6LAbS/lrHgNrU1NsIVwGDheZwsJkBGzVzSu8TfP90fBcxYUonKY94ZjYxfBJI3XP4jMGWqnCg0Qr94mjEDhUHVt2OhdfH1YmSYeJluluS3WOrDxQKSbFZnF7CJDmdn/RATpGheknXmNDSlRJKlRPAt/rtJxe2hjO/n7KhzBXm4Z94T4lRHeBAUrf4atHdrwg+cVYvmXgtM6pSBhnbOxJV9sOYvpSfYteEbcwbbisN/2vQkRSl+uvl1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu4Vv/26QL+uWlKuuvGB0P1x0em1dXjneeMzMY5z6qc=;
 b=Fd/zyOBgl57Ny2b/sNgpeWDYFDHsRBPV0RFhgI8k5SjvcC4Hdk1zLylxZy0iwK+cXwGmJfBtL+v8zvRVFTvAA/7JgLKMviCXc1/kLw1TaVP4DlpFNvLHJs9R/MuJmSPOfFDtwfpncCMPQH9r5cQR+M82rmldmUznLf515/+WEQy+5jHrwJVGeoD3vGMBkTr2RnaIhPifwN8dfgEmiDmrIdJ3KQ8poKym4MHJI+io8ZryCYxtIOQD0Ee8qeIH21fOfMMRlv/vhw02h1x5zNN+2P/EW+ySWQRgKsn5q+JdZsoedDm7f0Mn/DGNGTec2zpKqaaM+QdAhjnEWbZtW6LVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:45:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:45:54 +0000
Message-ID: <ca71d550-86d1-40ac-a416-c02fbc1ed77e@intel.com>
Date: Thu, 17 Jul 2025 11:45:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 08/34] x86,fs/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1752013061.git.babu.moger@amd.com>
 <e48edcbf4fe2c258ab8d38d9ff78fdb8849c353b.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e48edcbf4fe2c258ab8d38d9ff78fdb8849c353b.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:907::21)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 595dddfd-2c64-4905-d3b6-08ddc562294e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2dHVmVSQmphdlU5TEh3L2dpL2psVDhiazJsWFAyNGk1bG5UaTlYZ3NLUmhv?=
 =?utf-8?B?dXMrQzRsTVYyYzRUSENDYkpybkozbDF3ZXl5MlVGV1NtQjdRbUdXdkdrSHlC?=
 =?utf-8?B?Mlc0QytncGtJVmdIR0s2OFBML2dPb0JJcG1Ka25ZdWt2WC9CN2dxeEp0M1FZ?=
 =?utf-8?B?WlVuSXpEb0ZGOGRhbWtZRmtwSktoZXBBWnlFNHM3NUtkT3ZGdmFyVGUwOTJN?=
 =?utf-8?B?emw5Tk5iN05aUHl3NmVVWURTUzhoWm04enB1YndjREdwb1BLcE1iWWI4bncv?=
 =?utf-8?B?VHQxb2RlSVdVUCs5aGFXcVpWRjN4QnpVOUxoUjBESDBxekpSTmZWbGw5Q1Zj?=
 =?utf-8?B?Wmg1ZkMxTkU1bWVRR0xRZXowQWdHL1dXMHN2S25XR280QVNmSEZYS0h1M2VR?=
 =?utf-8?B?VlNHdEFnNEIxaG9wNW9Qb2RFTnJmR0RwK08zL1N5WWFwQnZOa0h0V20xOXl5?=
 =?utf-8?B?TS8xdnUvWTlsellIOFVrbGJwZmRGTHBudThkVEw0bXVsODZsRVNBdUsyRDZU?=
 =?utf-8?B?cVR6OVE4bFdvaXR4OE1HNVY0M0kxd2xxdU1ZK2U2Z2tDRWcraE5NR1VZUGpu?=
 =?utf-8?B?M3V0MEhNb2ExckRrMnZRZlMvNTl1T1YzVldESmVuVnN2L1NHUzBXb3hGcnpD?=
 =?utf-8?B?VHNJZkxaQUNRSGZsQVFmd3JYWVM4RmwyU05HNlk2ZHpWdXBOaFhrSHcreHNO?=
 =?utf-8?B?UElLUDhNNmdNc3N0ZWtZQlV3aElCeGJ3REdDUThoK1N2SUlrakJiYzg3NVZZ?=
 =?utf-8?B?WEFWdElvWXFpV20rMUlFb3ZMa3RZL0ErNU8zdm1HMytPdnJpWUdhRWNBYUIr?=
 =?utf-8?B?WncyLzZieWE1WDkxa3FweVRmZ2pUak14bGJDQVphZHZaS3MrKzlJSTVGVGFn?=
 =?utf-8?B?R0d0cVZJYnJrc0V4bWZxUUNXWUVtNGNJWjBKVlVKQ1VhS3YwSGZqZHRYMVo3?=
 =?utf-8?B?amMzRnNUUnhseW83dXNnZ25QYkxqVnhsUXNGWEVzbC81Z3IxcS8yMi9oZzFt?=
 =?utf-8?B?ajI3L2Y3UmdqdW1sTjFiandrN1dxZmthRi9MZUE2eHR0U01aaE5RYnpxRzZ0?=
 =?utf-8?B?cDdERFVoWDhJU1F5NnNZRUdtU2lCUnNKdVJpL0xJQitGS0JVdmYxbFpQQ0hk?=
 =?utf-8?B?K296RldiUW9Qb08wSUVYR2g5bStoUithNXlJTDU3Z2V0bUVJa3kvUEFKL2Y2?=
 =?utf-8?B?a0VBeXNvaittZjE5NFN3K2szU0xRZkZGaGJCeDhjZWdvSzdaVEVwbnJRTE52?=
 =?utf-8?B?dHpHV05OVG1lVHpEU0xYS2poWkh3UGQyWEVoUWRTUU1ROEh4UHRXZ2l0N2E4?=
 =?utf-8?B?ZmF6RTJvWFc4aFJtdFlsRVdkQlZWRm1uMG9nVDM4QVZDZXUya04wNkVJUXdq?=
 =?utf-8?B?cEt1TTh0bllNZmlRZmRxdXh2V0hibVVoQVhtVnU1dGExNFRKbVpRVmdNempI?=
 =?utf-8?B?SXhLVENucDd4bE9jdUJIZEJYeEtXWk1sZnNwbm5iYmFWalJmMG51VllzMWND?=
 =?utf-8?B?a0RXRXQrT0ppYUU1SVRrU1p3SGtZVU8zZXBDUmdkcnRoYlYxT3hYK1BHbmk0?=
 =?utf-8?B?L1hodFY5cGxFK0Rta1dRWGhnUTNvRE9MejBISHBVN012SWV2M1FMalR5Y2xB?=
 =?utf-8?B?UUdqbjd3YUJyTHF2K2ZGZmxZSWwzY0VsQzNzeE1VUGQ0MHpzOVh4ZDRkVi9C?=
 =?utf-8?B?cHdhYVUxNXVJRjE0RmJlckhWZzlzU1pBL2xhUGIzTEk0eE5taEJZSzFhT2l1?=
 =?utf-8?B?STMxQ1dtb1VhQ2RSZ0tQcUxYQ1owZ2lCaEFmY1ZkUC9rOGkvVXZZb2d5UGc0?=
 =?utf-8?B?Nm14YzRWdUVtQUJKQTUrZ3ZWbWR5QjhvM09jOFNabG1ONFE3NFRrRUNYdWlY?=
 =?utf-8?B?bkYwSGRXSzNrblZ3WE9jR2pPaE9xMlNJUG40aHNKYk5ZYjR4RURmSVdLdVJL?=
 =?utf-8?Q?0GpdnNzuOgc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnFYMGRjeGEvRkdYMVhNY1gzSHdtTVFrRnZGR1NpempGNzdtTFdYV2kxRmt6?=
 =?utf-8?B?N1FTdTEybW5pRjVlTkhiYStGd2E2cHlZQUJqU0lSRXUwNlFycWRZN0lvQ2J5?=
 =?utf-8?B?bzlaVkdvMllTZTlxay9MRHN0ZGdYbzh3VTk3a1RMcm5pOUNxSDhoSU9teDRH?=
 =?utf-8?B?UTllRytXaW5pTGJKcXpDMGh5VGE2ZWw5akFNSGFiWHNORWFNVDVwR1lJSEhw?=
 =?utf-8?B?U0xNbEZxbUhlS2RGbmFKZE5EdXZ3eGMrUytwcnZNM0tIN2Q1emROTzFGS0k1?=
 =?utf-8?B?aFRlcHVXK3ZYWnNIMGJDVjVwZzJuUkFKclU2Q05TcnpaTnpFQWxpb3JwWkc4?=
 =?utf-8?B?L04wemVFNW5nR0tlZ2RlVVhjQWdtdFp3K2lqS2xsbFR5ZWRhd1ZiNEIzWDho?=
 =?utf-8?B?NlMzTjZIbFB4aGZpYWJac1lIb0pEbVA5ZlgvSDR3S3VsZjJXeUlkWnhVcXZ1?=
 =?utf-8?B?NTYxQ05uR2Y5T01Ec3UvWm42SGZDMS83OFNvemFNSFR6aEJKbllDaWF0TzZG?=
 =?utf-8?B?WUU2Q0hpR24rcUVyMnJHeFNHM2tFWUhobi80VTBhcW0yNHdkT3FQQWxZUG1k?=
 =?utf-8?B?d1ZsVmxUdFFXQnFlNXBqeTlhZ3RqZWM2cEQwanRhSjdwdENMb2w0bGN2TTBY?=
 =?utf-8?B?c05oSDcrTmZkUnNlTlAxYmw4cjNMS1ZHLzQ5SExPT1FJZnRSZS92RWoyZW5X?=
 =?utf-8?B?cmRLVUpVOWtSdXpaV0crckduUEZxUlBGYkpOcTJzc0JnM3ZEQm5PUUh4R2ZK?=
 =?utf-8?B?SnJOZm5VMlNwYUNlTXpXTkUxdkNFTHBnajR5Q3VvVzk0NU1ydDVqanVGZExY?=
 =?utf-8?B?cjMxSjhoSGJHYit3ci9IbjVqRDFoUmdvcDRjdVYzZ1dLREU5SmdYbE93djFx?=
 =?utf-8?B?K0svNEtEY2d6MzdoT3VabUpWdnN5YnVwejBWQjNtUmgyM3Y2N3VaOXBCVkNP?=
 =?utf-8?B?QXBpNjdBWUtEaEF1WWNTaHRhZEZlVWg3NXZYL2NkMXJ6aEsyenljcWZqNENq?=
 =?utf-8?B?dE1zK2hjZUpHbDNUY1FnNW0wV01MQTE2ZlY2cHFXUDZXVUFvMDhzNURvZkhk?=
 =?utf-8?B?ZFBWejZDQUJ1dDJvMlZVV3N1NU9vVGJFTEtBRDV3Ti85Q21jbjZiRVhQdkM2?=
 =?utf-8?B?aEgyVWJOQTJ4blgxcVlpZmd4Yk5xS1pKOWl1SSsyNHpUcHpiVzZTRnBFRXYz?=
 =?utf-8?B?eDlUTGo3MHhwWitFaHZ2S0ZmZmQwbnRJSlhrd2RKWmNtc0EwNU9JeTV3citl?=
 =?utf-8?B?Uk9wanlubWR4ZkNnNDFkd0pSQ0xUMWE4c0ErOXhQWVhkOUlLQ0FTU1dCTEZG?=
 =?utf-8?B?bnorQ2Zkd1FwUldLSHgzeXJNbW9Hck5jaUp4aThnZmIxSWNJN0hvNVdaZkdY?=
 =?utf-8?B?T0tNMU5tTzltRHpBemlFQWMxTFNGU1E0bTRXQ3haaGRBeGs5dUlCOHlwdkpj?=
 =?utf-8?B?UjVubk4rT3FkRXh2N0RhSnFqS2w0WkZVRnJOMkV5OUpIL0N3aml2ZUlMakZP?=
 =?utf-8?B?cjRzVFM1cEdhaHNVbWRsRjdWOE43V3pWVjVqeXQrN0Q0MVJjbWNTUllveStL?=
 =?utf-8?B?cGM1RUYyaTNrT1d2RWlzK0xPcXpyMXJyOVY2cWQrYURoNnljamt4OUVSYk1C?=
 =?utf-8?B?d1E4UVVKMXo0UU1MR25tcFhzQzE3enlXMEpOWTZhY2pnc3NWY2RNMGF1Q0dw?=
 =?utf-8?B?UGdzQUtjYUpIakZSbE12KzFyWE1EaitjbTdJRHBZRnRoOHVaOURWOVcwQ2hI?=
 =?utf-8?B?am5JQ2JHTzJrWXRBakIvMEJqS1VsUHVMVmxBSVNzUTVacTltZnViNDhoNFRX?=
 =?utf-8?B?QWFERS9ybXFiamE5VXpEVTk0aTlMQUIzTkFJcCs0S2l0RUo0eXRSb1ZrR1l2?=
 =?utf-8?B?UHVKamFqaDJ6R2xoS25PUEo4MWtLd3VoRTVUL0pGbjFQTnh1cFhrYXhuMVZU?=
 =?utf-8?B?bTFYRVpqNTljL0lFZW15ZHZLNWEzY0JBdklGTUdJN1I3TUYwRkNiM1k5OWth?=
 =?utf-8?B?dFA1SkVENEdNWEd1cllXSktFZ2t5eGw1MGNxbDFZelJmQkg5ajNWc1REMVJu?=
 =?utf-8?B?V0JBLzNOL0pyUGsvQkRsWW51QkFzT3VrK0Fvd1ZhL1lGdS9LS29uaXlicytW?=
 =?utf-8?B?dFY2TFdNMDhDbWxtYk9oVDBUTFQ1QmxSdloyUzlndXAxaHliU21oTStPUURt?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 595dddfd-2c64-4905-d3b6-08ddc562294e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:45:54.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ph7QkJr2HUe33mit6j/96oTe7+ve3j8YxMzNV731lEN0JGsZsUPDa+kvIgXFOZR31qescPTfffs9S661tzQrmJfmuI9z2ghln8DSZ/hUEpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 267e9206a999..b48cc67cbbe3 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -990,7 +990,8 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>  
>  	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
>  	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
> -	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
> +	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL) ||
> +	    cpu_has(c, X86_FEATURE_ABMC)) {

I interpret this to mean that ABMC does not depend on any of the
"legacy" monitoring features.

>  		u32 eax, ebx, ecx, edx;
>  
>  		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 2558b1bdef8b..0a695ce68f46 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -339,6 +339,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	unsigned int threshold;
> +	u32 eax, ebx, ecx, edx;
>  
>  	snc_nodes_per_l3_cache = snc_get_config();
>  
> @@ -368,14 +369,18 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)

rdt_get_mon_l3_config() is only called when one or more of the "legacy" monitoring
features are supported ...

>  	 */
>  	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
>  
> -	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
> -		u32 eax, ebx, ecx, edx;
> -
> +	if (rdt_cpu_has(X86_FEATURE_BMEC) || rdt_cpu_has(X86_FEATURE_ABMC)) {
>  		/* Detect list of bandwidth sources that can be tracked */
>  		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
>  		r->mon.mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
>  	}
>  
> +	if (rdt_cpu_has(X86_FEATURE_ABMC)) {

... so having this check within rdt_get_mon_l3_config() implies that ABMC depends
on the "legacy" monitoring features. This contradicts the change to resctrl_cpu_detect()
though so it seems that get_rdt_mon_resources() is missing a check for ABMC to ensure
rdt_get_mon_l3_config() is called when ABMC is supported (but "legacy" monitoring features
are not)?

Reinette


