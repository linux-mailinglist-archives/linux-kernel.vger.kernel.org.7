Return-Path: <linux-kernel+bounces-853883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DA9BDCCEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA2B4245E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4F3126CF;
	Wed, 15 Oct 2025 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fi0vooFR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64730FF28
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511486; cv=fail; b=fiNT6hWoXGpqJngclICDFnm/7YsEWHjmVKwoNV55/WHAirs0pdrX2rgsJk6y3oIINaN8NuGx0RI8VZFpblKvpCLo58RRaj0BHsZMuTLW2X31+mYFD7LBtdN0aXFNdUOWUf1qnSyKu2e9YgJbFSBLqps+sW1k/Tq1A9BcmZwJHG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511486; c=relaxed/simple;
	bh=lFwv47ucV06hJk4/bE/r0v3OVK0y2UzSmyhrsmgsz7M=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o+q362kt7NDRatJs3Ty9/mQowwAzI8u1wLnoBiSE3IqvKamOaxzQvBA+5mPawq2ncvZonFBkjnmCs/s9F7uB0Anserv+Zuvgk1aNDjzzzdNAYe/pYx9x2ArtSnde3IUNA0kwWfJYOW7gGjzRArRWqs9J892fDYSYz5u5u6BXAVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fi0vooFR; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760511485; x=1792047485;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=lFwv47ucV06hJk4/bE/r0v3OVK0y2UzSmyhrsmgsz7M=;
  b=Fi0vooFR0S43ezHFDBNviJ87hWVXKqi4Y6QUhXSvpKBsINjGBmO63Fow
   17krqjJMLwgiLsAHhdhDUdDCd73Qy4Cj5EoVLONMxCWmZR/C0JbUGCGMs
   TAfwH8yEvT8ukD2mqtfRVU21icTvqbzZMMvrR6DZNMoD9pjkFtT2lm0Cr
   AZetqd6iaf1qiFuheObR1qjf5HepPbwvvTlQ8sa5iFcUk09N3u68WeWqN
   ElGOqruZWM4jaXPLx30igDYLDXSRk+bImgjXltdym7bH/d08Q9BcmHaxl
   XohLiv4/q9L+FNOM+9lpQqu0Q1DK5BjynqGXErNry/bNnGIFdT1N8pYPo
   g==;
X-CSE-ConnectionGUID: zyLPMnSWQ7Oe4paX4NiSvg==
X-CSE-MsgGUID: gX6v1UoNRgarEjNqyeSYkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="74128020"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="74128020"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 23:58:04 -0700
X-CSE-ConnectionGUID: AhoqfYhGRFa0pk8L29rBbQ==
X-CSE-MsgGUID: zT1a9zgAT9ekPI8/cCrQiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181650143"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 23:58:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 23:58:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 23:58:03 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 23:58:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtMpQu672/nEOQGRuliiEX4sWnZLwldJbq5aTDz+D/7zmgGHcHWQRPctPONNKAa30s+N5EES2pqvBCcV1+dgO6wTcJpIltZpuT43KKKhBigml8AH8PZ2OVTQAoufzGsH+DEtwZsBO3CWQSeBkixlGbciYd8SH3/8x8PgiopMbHUOFVX6rBdkwoLlANGNPWuXJi1o3gyVjOvCqtXvhkeXfZHMzHLk0YnVj9aplal1P/7M+o21NkeaUWleYOREXR6oUmT6/unBK+jEGryYP06Tnh11UwhURmPOAUZS3HxDEmiS5xgIt3TtAfIbDzq2qsUeoIDMktOWRNfrF8bUmrwGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQVdMHUJ3BbmMQTMAsKuvNEkMBTptH3q8L0h2u83uYY=;
 b=tBHBDX13V3gb3w+xhfh/3zTytLy1TXqzKSorpLC0wEk2uUsnV/EF02rtiPdK+QGfPiuz/YUKLVlleonCY+pUo832r3nLdIsMidxE3UTm6LjPQl2Ic6m33Gv4A8mZRu4Nm1p3Vc3CLZFruZzJpMETXpBvarka9IVyDIYOvPLbpmL8CWMlzQ+G4xlOb2ehx0fsG408C8rHTqRz9NAbkMciNl334Pl5gAE1lGkwJdSz3JYJjF3mPdX1Cs3hwBUdrMbQbULmIyKfw2S0uzZU3MTZqRl9sznXA4O7Ie0vDe0sMAxhbRVYmHrurm4IOl/opQ1NPyMeK/ZOVn2Gx/72oUe5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 06:57:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 06:57:54 +0000
Date: Wed, 15 Oct 2025 14:57:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>,
	"Yangyu Chen" <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern
 Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Libo Chen <libo.chen@oracle.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 18/19] sched/fair: Avoid cache-aware scheduling for
 memory-heavy processes
Message-ID: <202510151429.2c3f3413-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <00da49fd590b95baad0525660bda4c0ba178243d.1760206683.git.tim.c.chen@linux.intel.com>
X-ClientProxiedBy: KU2P306CA0012.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 4518105b-19be-4b16-4e62-08de0bb82a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+k9e1Za+EBwNpoxIQJQcR93l8GbFfWIkhiInixYl2hlm7Kmhw969LIO5r+0C?=
 =?us-ascii?Q?mb6oo42XzqyueW90/DZ3Xd3ClDNFcSN8yKsYuI8v9AyquSuiuIHbOjD5Rv0K?=
 =?us-ascii?Q?8hk6s0Ooo05G/sxSJl7aCY5bC5ahGs+B2wr5QkpY6SS84fnxAegEPoCPbxRq?=
 =?us-ascii?Q?n6//9N19CkVHQZ7Hr8rR3t7AIaOWxBvapT4/t8vXN9AmfVg2peav9PGqWDc/?=
 =?us-ascii?Q?VrMRI8ZZPkmxe0JyTSc0P4QPEnRFOj99Ossult1zEtrPVPS+BPlUYX2mT1eK?=
 =?us-ascii?Q?rUhCZhf9jXNCIW8ebwVDZnFkeLNGCqac36S9Od6eppQXh0ITF/lJgoDN5Its?=
 =?us-ascii?Q?3a3jbxh8vmsU4LObhUZAlsmEgcLeqEI2fQ86tSCUv1LnbxGjZYSg7+B/Q0OQ?=
 =?us-ascii?Q?D9bXmMpQmjpuD7STctenhiy+KU9CVj5tJTX+UtdZBjF4vTI5+Q3c68JK8RHj?=
 =?us-ascii?Q?E5nkvKKYArL20np+MzDgwMlDo+5LhF0Cz/wkds+kXIrIPuThNjYP1+qrhGjM?=
 =?us-ascii?Q?MaPGp/uootT5BhmeB2kP24BhKkewomERVeVV9qb6FsCF1YLnV7tcCcFBAX0z?=
 =?us-ascii?Q?eVNGO6kZND0Nx1GJ6PvHsMkmf1i2S94/U0GkN4xe25wfaDUpUKb/XYO8C9VK?=
 =?us-ascii?Q?PjMm6TICv6RGdd/dZzxpAjZ2ERG33D9rmpvjmI48P0HbTEJGVvODwGv4SWwq?=
 =?us-ascii?Q?QjWHH0kyFQkyJlMxGr0aXSORqfzK630tVEZWzZRewd96Oh8WTGyKePzw88OH?=
 =?us-ascii?Q?ZWLLgl+mmi620lx2hC1QTphPhTVDo221rEFFxNNgo/QqGn/+KfVrRBBSSQir?=
 =?us-ascii?Q?nR1kYeM9O8lIL0GIEmDkVWz2ByKK/1D/tfPpn4R3o618PyzRlx0kgYaZGMG9?=
 =?us-ascii?Q?2gkxfuKSf+5zfBWV6BUPJm8rLF6UbKBywi6bO+tlzwCuYGYdH1G1NZk2BhOd?=
 =?us-ascii?Q?e/SO2Wj8plunMveqIGgyM14X4gGDIm4fnNtea6kAQWA4TYpFMzVfEhnyWzv9?=
 =?us-ascii?Q?gg9y1fzn4n8W6Bdlj9dPuWkBaE/aOQtW6aYZo3ZmlpEY7sSBL9j5GwL/myPn?=
 =?us-ascii?Q?kPb0RSZMzILBdwnZCj6cC60x5HO7dvU8tAVOP1QDgP2RZaSM1U/VRNM7LmFh?=
 =?us-ascii?Q?LIP6AVTUw2MNKK2ANRkA93FKNM//fdnTdKVyl9a/Q3BYUGLfiCBewUlhzqJO?=
 =?us-ascii?Q?BSpMd3o5aQc3HdVMJGUVyaK99bKbmSDzYjXHTadUo5DGW1Zi7rlU5u6Mp1Xw?=
 =?us-ascii?Q?aBP9TIDvIVcFhDQRv2lEIhV6EB8p6Mbvj/9v0OJDalnCY396QMXMbdSCiQxC?=
 =?us-ascii?Q?kQhk1z97N7hJkaqrnaD6PzoZxel90s7lBJEkwCZzbaIRdDR95Up3RbpKPOvN?=
 =?us-ascii?Q?TlYX9KoOS27H4wdHO0GVN8vBD2JlUg3fV581QAo7XcRcdlpIF8ne66u99OzA?=
 =?us-ascii?Q?JVM09FX4llk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B3KJy5YaJJsSloOTawuCvi+O2Cj4oBvOh0cJxIhXmFUfwPRfg31qguLnzDOi?=
 =?us-ascii?Q?gV2v1ANtkRyPX//lkLSmlmDV3uS4j7erCrECviS6CGFuwzzXNnZIcfLQrlwe?=
 =?us-ascii?Q?0qi6p99f5ErQSyGNTpEYonGBvYvjz/J0YjkKtNLBwKkAjfAyJi1XtFKmOr8k?=
 =?us-ascii?Q?w38VzOORrIxRL7oHd5ta4aG5mzmFZvpSgrvMctnRdk3SxAX/K7fTYohTTeq4?=
 =?us-ascii?Q?B1Hzg+EJtNMhXOn3pBhK6X7UcOfUWKj+27Ksrd0Q0eYU0nVsEYpDWl9u2TST?=
 =?us-ascii?Q?DHdCvBxyrqGM/1DJkXGV1KUZK6SHPk7MAJ7ZjQTQnmfyou7KwpYMLzUA2+j1?=
 =?us-ascii?Q?IECMJ1Ld5uhtarWhujfnK6Mk8uyEkBbYfvh/crlmMLLCMvvDdAVwU47Ft2hA?=
 =?us-ascii?Q?TW8eFiCvDgFbDZxHoq+Ev2mEUeKVTxVxTiE5HLmSlpeR591BZ8zXZfxZyxYv?=
 =?us-ascii?Q?u5dIYlZ7wVv2ml5m4YwCQzp0SK8p82dQZqLF8T4tSIUaB8SYfSwYCRhCNWf9?=
 =?us-ascii?Q?PEN0Bz4DaIAJusQN8h6AuTlaKld8jPWLCHWTJVdIubeR9bBPveZ6n6m6QhFH?=
 =?us-ascii?Q?Jd4oh8SocCubqr/qL9Df3nP3GSPThiP8sOmwa8n17j3h7VrGMPXWO3aDzgYm?=
 =?us-ascii?Q?qadIv8GPeciHmQF3WC1CIPxnVElcot/WoLtSoPANTits2gHIPHdEJW7s89+0?=
 =?us-ascii?Q?SoaRc1cZ6yryBPlGPxYEcGwEqc8IRXRSES3AzEzsAyJcIdKEl9Z1D+s3jp5U?=
 =?us-ascii?Q?XDtHkT4cuMY6c/IoAhak8UDRjuNFRyQldJv2xtjrDsQoP13hbgh1StbQ9E+S?=
 =?us-ascii?Q?ubqsBFCpUrFG4H/CblCuR//XFcBm5WQ/g/qe2QbGcmxnYDknZMgjcV/Nxz5P?=
 =?us-ascii?Q?cn3UNBzMt2Y5xHG4MEScT6FwBdHg4HvoGqU6c0N8avCNGmT7puC9iFJkTZQS?=
 =?us-ascii?Q?E1luGfJz9lfSN0qkNxEreqiK6yQx+BSJHpiG+9FsOKWX479y+/Y92zU6OXy9?=
 =?us-ascii?Q?3GLNSgWlyQiGmAuBLV4xT7b9vsGPfuS471UKjMxlxn4pLbR0ZwvByR//VWbL?=
 =?us-ascii?Q?fqQuJuPYNOSimqdpcso0aqEHzgCsPyM1OdaEufcsGHT++yA37k20i4wsj+2T?=
 =?us-ascii?Q?1lOD8Bp9OticLlyJ6C9aoY44S5khwgS8NZ2s9MSjSnpuFlMWXnkVgu/NXh6I?=
 =?us-ascii?Q?/yXGLTdYQ/mnb+nric5N1PcGR1p6hU6Su9sBt5u8ASBBlNOXiLOAz0ZTniwC?=
 =?us-ascii?Q?bnp9tD8dx5CSoUlmCCtldW8TtXnTw09vea4gpWsXE9WmTzMFBzP8fUDdhjfz?=
 =?us-ascii?Q?Iljm3PRJu4BfmQRQ6q3mDJAy4jZJKYnI0VtRflWYlM0rB+IYewD0xqLz+JkF?=
 =?us-ascii?Q?Yt748RaqzFVMCKYs8sXpEvUtQUO4Ktw/EVtPb+wJQ+YxJNJil39fDNzfUMyh?=
 =?us-ascii?Q?0sZCpqoIIRFIwyiPrw1PUrtqZBZNmXT5jWr2Nq0zBKgqGVdrTKv76mBFOdW+?=
 =?us-ascii?Q?WLhLN+wxkKJUOMzY1CKPI+C+crdzVJk6RnqUvuOzBkWP9XeUerQgp2baTLHn?=
 =?us-ascii?Q?3ohtjnAhYM/FGMv1/odEAbZclXo4vyOafk85TvIErR35sMRe1RZO28pn4Xex?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4518105b-19be-4b16-4e62-08de0bb82a2e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 06:57:54.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phBGBK3jaGg1bpDYewcHDzFZddK68hS8yktY+GPDWp7nxxsxIX5vP84Yopb4OcTMAeQT7TNaLKG8xAZH4ggrVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_drivers/base/cacheinfo.c" on:

commit: e8b871200f11decae96692a3f5b385cdc25af231 ("[PATCH 18/19] sched/fair: Avoid cache-aware scheduling for memory-heavy processes")
url: https://github.com/intel-lab-lkp/linux/commits/Tim-Chen/sched-fair-Add-infrastructure-for-cache-aware-load-balancing/20251012-022248
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 45b7f780739a3145aeef24d2dfa02517a6c82ed6
patch link: https://lore.kernel.org/all/00da49fd590b95baad0525660bda4c0ba178243d.1760206683.git.tim.c.chen@linux.intel.com/
patch subject: [PATCH 18/19] sched/fair: Avoid cache-aware scheduling for memory-heavy processes

in testcase: boot

config: i386-randconfig-003-20251012
compiler: clang-20
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510151429.2c3f3413-lkp@intel.com


[   12.549731][   T83] ------------[ cut here ]------------
[   12.550388][   T83] UBSAN: array-index-out-of-bounds in drivers/base/cacheinfo.c:37:9
[   12.551060][   T83] index 4294967295 is out of range for type 'unsigned long[8]'
[   12.551580][   T83] CPU: 0 UID: 0 PID: 83 Comm: systemd-journal Not tainted 6.17.0-rc4-00035-ge8b871200f11 #1 PREEMPTLAZY
[   12.551585][   T83] Call Trace:
[   12.551588][   T83]  __dump_stack (lib/dump_stack.c:95)
[   12.551594][   T83]  dump_stack_lvl (lib/dump_stack.c:123)
[   12.551601][   T83]  ubsan_epilogue.llvm.16751680356772289369 (lib/dump_stack.c:129 lib/ubsan.c:233)
[   12.551607][   T83]  __ubsan_handle_out_of_bounds (lib/ubsan.c:?)
[   12.551621][   T83]  get_cpu_cacheinfo (drivers/base/cacheinfo.c:?)
[   12.551625][   T83]  exceed_llc_capacity (include/linux/cacheinfo.h:? kernel/sched/fair.c:1256)
[   12.551632][   T83]  task_cache_work.llvm.12119588225164800824 (kernel/sched/fair.c:1527)
[   12.551637][   T83]  ? task_work_run (kernel/task_work.c:?)
[   12.551641][   T83]  ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
[   12.551644][   T83]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:65)
[   12.551648][   T83]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4472)
[   12.551650][   T83]  ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
[   12.551652][   T83]  ? task_work_run (kernel/task_work.c:?)
[   12.551655][   T83]  ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80)
[   12.551662][   T83]  task_work_run (kernel/task_work.c:229)
[   12.551668][   T83]  resume_user_mode_work (include/linux/resume_user_mode.h:?)
[   12.551673][   T83]  irqentry_exit_to_user_mode (kernel/entry/common.c:53 include/linux/irq-entry-common.h:225 kernel/entry/common.c:73)
[   12.551676][   T83]  ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1050)
[   12.551681][   T83]  irqentry_exit (kernel/entry/common.c:210)
[   12.551684][   T83]  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050)
[   12.551689][   T83]  handle_exception (arch/x86/entry/entry_32.S:1055)
[   12.551691][   T83] EIP: 0x3764e8f0
[   12.551694][   T83] Code: 00 00 89 c2 eb d2 65 c7 05 28 02 00 00 ff ff ff ff 65 a1 08 00 00 00 f0 83 88 84 00 00 00 10 65 a1 80 00 00 00 e8 f0 02 00 00 <8b> 44 24 04 8b 54 24 08 89 10 8b 54 24 0c 89 50 04 65 8b 15 7c 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	89 c2                	mov    %eax,%edx
   4:	eb d2                	jmp    0xffffffffffffffd8
   6:	65 c7 05 28 02 00 00 	movl   $0xffffffff,%gs:0x228(%rip)        # 0x239
   d:	ff ff ff ff 
  11:	65 a1 08 00 00 00 f0 	movabs %gs:0x848883f000000008,%eax
  18:	83 88 84 
  1b:	00 00                	add    %al,(%rax)
  1d:	00 10                	add    %dl,(%rax)
  1f:	65 a1 80 00 00 00 e8 	movabs %gs:0x2f0e800000080,%eax
  26:	f0 02 00 
  29:*	00 8b 44 24 04 8b    	add    %cl,-0x74fbdbbc(%rbx)		<-- trapping instruction
  2f:	54                   	push   %rsp
  30:	24 08                	and    $0x8,%al
  32:	89 10                	mov    %edx,(%rax)
  34:	8b 54 24 0c          	mov    0xc(%rsp),%edx
  38:	89 50 04             	mov    %edx,0x4(%rax)
  3b:	65                   	gs
  3c:	8b                   	.byte 0x8b
  3d:	15                   	.byte 0x15
  3e:	7c 00                	jl     0x40

Code starting with the faulting instruction
===========================================
   0:	8b 44 24 04          	mov    0x4(%rsp),%eax
   4:	8b 54 24 08          	mov    0x8(%rsp),%edx
   8:	89 10                	mov    %edx,(%rax)
   a:	8b 54 24 0c          	mov    0xc(%rsp),%edx
   e:	89 50 04             	mov    %edx,0x4(%rax)
  11:	65                   	gs
  12:	8b                   	.byte 0x8b
  13:	15                   	.byte 0x15
  14:	7c 00                	jl     0x16
[   12.551696][   T83] EAX: 3fdacc1c EBX: 36a49ba8 ECX: 36a49d64 EDX: 00000001
[   12.551697][   T83] ESI: 00000000 EDI: 36a49b40 EBP: 00000000 ESP: 3fdacbdc
[   12.551699][   T83] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200212
[   12.551708][   T83]  ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1050)
[   12.551717][   T83] ---[ end trace ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251015/202510151429.2c3f3413-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


