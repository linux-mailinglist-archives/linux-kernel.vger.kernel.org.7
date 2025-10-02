Return-Path: <linux-kernel+bounces-840177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0563CBB3C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B83C57FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B9F2D7DD0;
	Thu,  2 Oct 2025 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGPY0SBS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8921B9C1
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404729; cv=fail; b=Uw3TwXzE8rhopjxnAcpWgszVKQHmzss/vHpGNqS6H2AlR402+0kAYppg6dT5IC9u/+FV+OSuMyxo3LH2cYeHvAuB+9w0nmCAP3z5TMM4gNLEqhfM9IvZYZeggHqFd+N4dYJJIjZfJt9EW8jmg/DFEpwxDLVY6DGtvoR6ntmI27Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404729; c=relaxed/simple;
	bh=3F5Ugvx7AR8jkzH7QBPzt6P1KK6brOCiIqfhMN93jbo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I3384sX2Fqeys5dDuPGjCpphfo58ZUcwGXZnLrpajl7j4mfUe8Rgybrja+6/UPNH0q8HJMVJPaP2npi11pmwzvKZlyzjhtI1SUCGBygBS6QF2XT9vcq1Q2Qn49EVM1MJvTuGgs/gyt3Gi11RYmP6o8zEOh+gsvK2GlPBTThIOnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGPY0SBS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759404727; x=1790940727;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3F5Ugvx7AR8jkzH7QBPzt6P1KK6brOCiIqfhMN93jbo=;
  b=LGPY0SBSRPuW/OJU6fwP8Qlupfu3OqPG33NjLE2drkYzL9jjnkuTasax
   dA8AwQ2mYgQ4TmpZmwU7UAz/XNa6jgQ2mY2fF3naZ6oi5fUVEmXTwY0bv
   NjGN14F4JxkSFzz54CHCdJWowb5BaJHmRw432WXrN0hMqGkj8Co3qADkQ
   fC/uur51RqTeRmiEgOzbAbRqJWvKLJnjIaq+Y0yibSuulCrJq84Jm4PrG
   c/E/lqPI0ROBEIRlWpftLsyzFp+lVpYAYSX/r1K5dxMzMn5OpZbss0Qk5
   D4NKrf1ndPsmcv93T6xTx692Myv9/Ru7otONrqpJ6sLxPUqBbmDGGWR5c
   w==;
X-CSE-ConnectionGUID: WPgzHAdwSjmq6CWnwbYXaQ==
X-CSE-MsgGUID: PgD8a2dTQHWqGhV40Vvgyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61398908"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="61398908"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 04:32:06 -0700
X-CSE-ConnectionGUID: gylsW58XS/GxigBAGt2kgg==
X-CSE-MsgGUID: cZ/XCiToTQizCC4gUOO77g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="209724311"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 04:32:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 04:32:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 04:32:06 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 04:32:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RD54ng2WbKr/N1KSn9UvwFh8vqczlY225hTTj2Wy0paX37P2R9ceFcUCGal1/tN0NLhoN1Tne9fPfj3nWGyB/GclruN/Eu9VWDnZP8vfit4orHT/rrld3npBmLTgYYGqkdxYidnzJLMgn42c+Z+jO+90a1GSmYdyWW4+NsD9MJjmozx5uGd1P912ACIchhqBostdriCVtKY4E7lOx9BDNomeia+HBpa4r5uffSEgD2dADNzgrJioGbgNZGUiI3TamE3ngtS96ASVGzmSkW7ir1h9A3ECEILGO+QXs33wPDFXDrnIyD4avHIj6R9I/wGeQncwcgjAAvGhn3+AHcwURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFT04dr9WfNF7PyhxkB50B1I4OOKsO8t10zmWvVmza4=;
 b=shEtKDwu02h75cjyBJkbHGTb8r4F0O/gCJwkWyQJ5DK3tEEb5I2EfUjaR4Eur3HIYS375JKIx3yQKcboMDKvEM3RBCBpFAAKg1bHoSQyhrzBga/ylkRop8la9v+4dPVfldrSAxhP0Oo7uTiyzJN9IzpeWjpFH43xetow0k8V6mq6aJ1/2QKTTUV6cnn6jEMEWecmsg2xEpIbNpGne/rbDSqoTCwCufI3zSGlZdL4NGhS4r3iMGtzKlhJ0v6dBdQH3E+9nphN2frDVNbuTziRTMUaggv+GFREhWWUyowIPmCI67O+/ugtNd/tuYpiyleiSkhRIKQz6yCPJ+O+V28cuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH8PR11MB7047.namprd11.prod.outlook.com (2603:10b6:510:215::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.19; Thu, 2 Oct 2025 11:31:55 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 11:31:55 +0000
Message-ID: <89c777b7-33bd-400d-8b6f-4e6d697dc632@intel.com>
Date: Thu, 2 Oct 2025 19:31:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/28] sched: Add helper function to decide whether
 to allow cache aware scheduling
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Libo Chen <libo.chen@oracle.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Jianyong Wu
	<jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan
	<tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown
	<len.brown@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, <linux-kernel@vger.kernel.org>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <701c7be7f0e69582d9ad0c25025ec2e133e73fbb.1754712565.git.tim.c.chen@linux.intel.com>
 <20251001131715.GO4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251001131715.GO4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH8PR11MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b95a7e9-533e-4a1c-e4cb-08de01a74a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGpSNndoTUw0bVhxdDNEVE5sb0VnclRmajJ5UUFtSjh2c3p0b3hDTHJoVmlm?=
 =?utf-8?B?M0FmK1FwWU55L3czbjNnYSsxMENqck83bERMa0I1dHlqRXBnTjh1b0dqa25Y?=
 =?utf-8?B?RVhFb3VRZk1rUkJMYzVHN2xvcUdMSnlqVVc1UDBpMEhLVkYvVWRscEdwYjJN?=
 =?utf-8?B?SmNTQjA5dlRxSTZsYVF3cnV4dkxIWDRNQWQ0eW5CYXQyWFpxb2o4QjJ0Zkt1?=
 =?utf-8?B?RE1ZakZjQ1dpVUNWOW5jV25NOVZoN3NTYmpvcUhRL0NydUNmMFJaai9WRXBi?=
 =?utf-8?B?NUtqb1FEMmw3TXkycWZOYlpZN01ZNjdmNVVmRGNRZTNNbmxtRU9jVXZ2OU5z?=
 =?utf-8?B?bmVOdDVFZWxSM3R4U2NNcW56VVlDNW5RRFNPTCs3cSsrSWVlMDRGencyVG5v?=
 =?utf-8?B?ZmM5Rm5iSXd4dUQ1MHpzVU5FSkRoRDFuMmJvSkdMSnNBMmtDcVVDSWIra1dy?=
 =?utf-8?B?MEhMTnpkZVBTNTFpc3gwUjNhU3gyem1nSTM1Tk8rM1Y4US9lTjI2VTdVeW1o?=
 =?utf-8?B?NjFlU0FCTGs5WDNmdmgzZmZKMkxPSFpFUHZkSmdSMzYzd0FwQnlnV1FBTVY2?=
 =?utf-8?B?Sk1EbHZXakVDTmZPT09LM1hJTTJtSGFMLy9ZM2hXTCt3WHRNekE2M016MkQz?=
 =?utf-8?B?dGZtZFNmNUJmeUE5NlJlajRBMWtSNzdQbmFvSDlnTDlNKytFdjhYZnlHL295?=
 =?utf-8?B?aitobjdqbVd0M0U4MWpaVW5qeGJpbCt3bVU0SitxRHYvRHVRT3J5V21nL2Vh?=
 =?utf-8?B?cm1waXpEVWlJeXAwdDRDdjRLTUZqZlJTeU5JYTNJK3dISm1qZExpL1RZOEhw?=
 =?utf-8?B?b0JtZ1Q3MEo5ZkJOSEZYZFpuNmQ4WDdmbkhxS2FsQXoyMHIvMWJscnVKbW9L?=
 =?utf-8?B?QkNuaGlEYXpBSzNzeXJjeEV5QWYxc1hnSWpCQ2M5RWNyZnlVamF3UXNKTW5h?=
 =?utf-8?B?VGtWWUpab0l4TlRrV0cxNWw4SXYwckFWVTFMSkFzcDIxRmRLQ2pMd01na09r?=
 =?utf-8?B?ZXVHR1lzUzFTTWZwY2tkbFZhQVMyWXVvMjdrb0RNbW5RZGl6bWhpL0p1NUcv?=
 =?utf-8?B?TnlINktlYnZJcDJuMEM4SndiTzhQcXdqeVRZY0tvcFhFOEhUZVlXcUwwOVl3?=
 =?utf-8?B?c3QvcHY3OWNaZWtKa2JXU0E1NkpPZWNrZXBONUNOeHl1bmtLREpZaFdnN2hS?=
 =?utf-8?B?SmlteWdBeDZ2cXV0cjA5RjYxSFc2RHp1TXYwazZ5UllabjUzR08rbStLMDlE?=
 =?utf-8?B?SGRtTThHMW1wOWlrMEoxNkJvajQrWVVnQlErbVhTK3ZyWEtkaWd0VzVuRnNY?=
 =?utf-8?B?aDVuVUVQeTE3b05CVW0wNDcvdjNFV0xkeGlLUjdQaFpyRVlRVER4SEZCRFBY?=
 =?utf-8?B?MkxXKytyOGVGSVg1enlRcG1Gc1B5MFh3TGpYdVVyMG4zcFo2SDRNSUp5SFBE?=
 =?utf-8?B?dkdyUkl0TTZHclVYMlVhUlhkVG9sN2FoSm52K01xcGg2cTF4L1ovUVJ1aW1O?=
 =?utf-8?B?Nklhb1JBbm10MjEreVdxTWpLeUhrVExBc0FFTnI1dHRBbmlaSDRTQVJkeGpX?=
 =?utf-8?B?K2FMMEd0Z1J2L1l1elRGdW5iaGpHMnZhb0w3cURQaitJbzJ5R2djN2R6NHR0?=
 =?utf-8?B?THBqNksvQzNab3NwZnNoYVAvVE03dDQyeGNCbUx0WC9Dblp3WE92R1AraXJP?=
 =?utf-8?B?cHQ0cGlqUWFhL05hQnU0a2RydXA4ZERjMUxRTzd6Z3VudFFjZXc0c1JUTDdn?=
 =?utf-8?B?eUFtUHdJKzRxVno1RUZHeEpaZ1BFZGNWaCtKOUxoQzVwbVdHNU4rdWpXSmFn?=
 =?utf-8?B?YVBaNFY5cCtXcmFENTBhRHZuQmFyQlhtKytXM3EyOTRGMEJ2S1FrK2tFMUJ3?=
 =?utf-8?B?MjdBZlljd1VkNEM4VzdhdTJsOWp3a2pDMUw5VTNDaW1XQkJ6bGJYR0UyU2Zp?=
 =?utf-8?Q?oxeaHXKH50ZM2L25YHLLxHOUnAh6y24k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRqZ2VRaWhIOG1aYVRDNngrbi81aERqeGt5SElxcjVXZUx4NlVXK21vaTk3?=
 =?utf-8?B?bDBxY3ZYcFR5SXMzak45MVBXZDZiNW81ekVwL2MrT0IzNDFDM3VEZUZQcko4?=
 =?utf-8?B?eDh2QXhTb2FQSDFFQUNoeXZHNFdFSXgwQTdFeWxzaUxicmgzSG5OUml2RUlq?=
 =?utf-8?B?L21QdzlxTTFqc2ppbGl1YTRSRTYvWDlORld0d0loRkpJaWd2U1llcjc3MmZG?=
 =?utf-8?B?ZWxVVW12VmpReW1LVHhSbHhHcXZXeHZHZGRCVkw3VDhJR2puRHpEZkRqbm5h?=
 =?utf-8?B?TnZiekNPeXRhK2Roa3Y2TktiV1JZOHIzZXNaM3B0aEgvRS80a2l4bHdOaWY2?=
 =?utf-8?B?ek5yTWRweHMwNWZvMHQ2c0JZV3czUHJleEpFcStRNUYwa0tiRHRkeDJObW9W?=
 =?utf-8?B?YjZvSFd5UEdwQkRzaUdBR2NjUWNNOXBQRS9pam5tSVF3WGVDVnkzNksrL2J5?=
 =?utf-8?B?enRaR01oTG82MytkWU5tVEVlNzhROWg4RytxRVhtYjFidDRhS1hCTUhLNDd4?=
 =?utf-8?B?RWRGTGZVcG10U2lqRC9jaFdKb3Z0MFBCWHNqejFoVUF2SDBBVGJEYk9QMEZp?=
 =?utf-8?B?M093a2NOWUpjYjBoZElsZ2YzL0RESHdtODh0US9MNksrOHFwVkZEUVRxZzZj?=
 =?utf-8?B?K1BRLzYzY2RMNkFEenI1K2tOV1RqaWVVaVhPY1o4MFFEVldId3BtOXFHbjJT?=
 =?utf-8?B?Uk9KMTlGREhhNGdlYmFpbkJyclN1bkFLbWVCYy84RjRYVys1N0F4K1RFTVVD?=
 =?utf-8?B?WFgxVFljV05IS3h0bU9HZ3NXYVZhRkVUNFZ1L2FXSWwxTXdiL1lQNlFhV2Q5?=
 =?utf-8?B?UFV1T2p5b2lCMnE3bTVUZ0tZclZGckZFVmsrL2lwcTFNMElOeWFmamRyenJn?=
 =?utf-8?B?U1h2L2ltV0RrWHR6RHdZVis0T1BkY3hSZmlxK0t2dnM3emtObi9qLzBXNFh1?=
 =?utf-8?B?K3krQ2lnS2dIZGZSME9Vc3J0OVpZdWxNRytITHNKYktPUmozTkdkb1RPZ0VB?=
 =?utf-8?B?Zy83Mm9ZUGI4RXNpT2w4c2hOaTJYdXRTVmRxbDFZbFNSZUJUaDRaWmlvbFhP?=
 =?utf-8?B?bVpscTZBd2ExR2dBN3JCWENEc2lQb0UyWDc0Z1FXYzliZmtXeGxkYUllUmE1?=
 =?utf-8?B?UlBJNzZiN2N6V1BaVkRaYzRhTksxWHErU1lCRXBPWGtqRUx0MkMyVWQ2THVM?=
 =?utf-8?B?QTdrS3BXZXV1ZUJ5eEViYmU2UlM2cWxCeDZlMjlWa0pQaXBMN2pseHBQTi82?=
 =?utf-8?B?cHJJU3hodDkwUHYvRUxTeUZTbUk3cTVBUW05azBXZ0dnNFN5ZDc1Y0hlZklw?=
 =?utf-8?B?WURsc29mSTcvMk4zQkxOaUxxbThOVTBTU1RGZlpVbmJmRXV6UkJCY3dWUXhZ?=
 =?utf-8?B?STRMS3UwUzYyYXF5TmRtQ3ViVlRHY1lnemllS0ZlT255UjluT2ZQMGVoR3BP?=
 =?utf-8?B?cVB4RVArQjNnME1oL29CT0pIQVBTbXI1czJrWWpVT3c0ZThqUlpuWHM0bjk3?=
 =?utf-8?B?cVc1SWY4UDM1M2dnVk9aNWx4VVQ2RlpVTFk5MUhnN2lTK09IZVpuc2JpU1Nt?=
 =?utf-8?B?eHZWQncwTHZreHZ1MWxnRlNxM1NPaWdTblUzSHlZbVc3WXcwTDRucTdMV2dD?=
 =?utf-8?B?MFIwS2hMcmpwWXlVNjB1YW95L1ZGQnZURE5aRFI4QWFaclVyRUZzYjhJWUhB?=
 =?utf-8?B?WXVKYU1RTU9TY0x2NnFjZzc4VCtGNjRZSlRkbWFPOTVla05udUZBV1lwRFpL?=
 =?utf-8?B?OEJwTkY4SllBV2VmWjRrQ0Rid1VpOG5YREdDOTFFbWROcVVWT0dsTzRqbmpN?=
 =?utf-8?B?RFliMVhhQ29ZL0NQNnZPVFRhVFBnMmVDNVYvNjJHaW9FRHBad3JQbjJZZnBF?=
 =?utf-8?B?QStwR2xhcXlxeitWTUNrMFd3M0ZIcCs4OE1qOEF4UXVsaytGcFlod2pLRWxT?=
 =?utf-8?B?RXNYQnI5aXRmbnRDSS9vOS9jSkxhaGQrWjNFR3VNenNuMDZKRWZ5RHQ0SnZj?=
 =?utf-8?B?dDNGQUJIdlZNRjRLa2RJNlEycW54d1JzbzZqT2lVSU5oNC9ZQ08xVGh1WXMz?=
 =?utf-8?B?bmtBQlQrVlFXVllYb3dyM21TY0hEQi9WdkZCWlQ0bEFDeVd6dVlGMW4yMUhQ?=
 =?utf-8?Q?F2X/RY42XFoWU44tnDng7jTRl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b95a7e9-533e-4a1c-e4cb-08de01a74a0e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 11:31:55.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAeEe8w+6zkMZ3uLPWHUTz67o3wq7P0eckxxKnpp5Xy1myWC9hs1htZmSi+R09z0iUierqFz2rM2vUUgrRfK6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7047
X-OriginatorOrg: intel.com

On 10/1/2025 9:17 PM, Peter Zijlstra wrote:
> On Sat, Aug 09, 2025 at 01:03:10PM +0800, Chen Yu wrote:
>> From: Tim Chen <tim.c.chen@linux.intel.com>
>>
>> Cache-aware scheduling is designed to aggregate threads into their
>> preferred LLC, either via the task wake up path or the load balancing
>> path. One side effect is that when the preferred LLC is saturated,
>> more threads will continue to be stacked on it, degrading the workload's
>> latency. A strategy is needed to prevent this aggregation from going too
>> far such that the preferred LLC is too overloaded.
> 
> So one of the ideas was to extend the preferred llc number to a mask.
> Update the preferred mask with (nr_threads / llc_size) bits, indicating
> the that many top llc as sorted by occupancy.
> 
> 

Having more than one preferred LLC helps prevent aggregation from going
too far on a single preferred LLC.

One question would be: if one LLC cannot hold all the threads of a process,
does a second preferred LLC help in this use case? Currently, this patch
gives up task aggregation and falls back to legacy load balancing if the
preferred LLC is overloaded. If we place threads across two preferred LLCs,
these threads might encounter cross-LLC latency anyway - so we may as 
well let
legacy load balancing spread them out IMO.

Another issue that Patch 7 tries to address is avoiding task
bouncing between preferred LLCs and non-preferred LLCs. If we
introduce a preferred LLC priority list, logic to prevent task
bouncing between different preferred LLCs might be needed in
load balancing, which could become complicated. Currently, we
mainly implement cache-aware scheduling in load balancing rather
than during task wakeup, because the wakeup path conflicts with
the load balance path and causes task migration bouncing.


thanks,
Chenyu


