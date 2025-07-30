Return-Path: <linux-kernel+bounces-751286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C5B16744
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66AC67B1DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B9F217730;
	Wed, 30 Jul 2025 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgTRUId+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1841EA7FF;
	Wed, 30 Jul 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905638; cv=fail; b=MrwsA7fSmQmWghwHQjcleNY1Mdw587i3Elfbp2tGyiennyer76TN46RMp6Ho2xW3NYrnjs1P35zu55cZKLPuTrOP4+RnhvMk/6TeaipH1v7lNJav8chysiS62czFdyV9uH/EgpFgoSMbl7B1Vr6k7aEw/Cm3/Tml7fqxbcWpnII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905638; c=relaxed/simple;
	bh=Li7ZDp8G0R8r2wz1RcqBm0r33AawC0gjxuWkiGZBirA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=toIi0cKlHKw8/RLOrBIFS5RDOkzaEeGEcAr4Klg2p+pWDqPM3dQs7tzn173hi9xNtEuktKQ9zfnc8gntQq2zX01NewDX/4rpaDFsR4H3IgAXD0QOhNds5xl0NrkWiihF3eEELSkDGSqpojIYfWCOeRXvdKKKFLIXMzG1oynbBvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgTRUId+; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905636; x=1785441636;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Li7ZDp8G0R8r2wz1RcqBm0r33AawC0gjxuWkiGZBirA=;
  b=cgTRUId+/ADbd+bW6iN4iEFu44uXUlVOZicRLTF9Oax2sFcLnNCCTNk3
   HUnqB5RVGE24WavwWyWEH7DKtYisGeDxwKafkIG1zJxNgyaQ5VCnAI8Pg
   9DqeGmrNT3SQQCljCNeG6EYMgVtdUtUZTddj1ohYaT0+YhP40vdTee5LK
   3DZhx2cdjmWI3dBjDXdNt1aSfwznJ4OS95eLQJ55LVmVpKqYe4qOfqu+A
   Y/ZGQUvNUYKCGQWN/95rVgowalelG4JcdKT+2PjjJRUplgWX69khPHXzV
   ySg0QoMITbhJaBfiARh2tNsvlXrU5GFtXnClmbwZCMV8BLHUJXcvE7FC0
   Q==;
X-CSE-ConnectionGUID: 6QfBRQDNQz6Afxgvgkk1oA==
X-CSE-MsgGUID: hIjmTEJvQQK/zcf69IfDHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73808198"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="73808198"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:00:31 -0700
X-CSE-ConnectionGUID: kgadjanjQpeDXOJZV6q4JQ==
X-CSE-MsgGUID: iAi1M2S3R4arSMww6OzoUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162956211"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:00:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:00:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:00:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:00:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR9/w3nRszDTTSBAoJSZjDURq7q73Qtknc/iTWrRzsXB81Jvo1T09WaNybPpTZXaOt1Aw/y+y8i/Nq04VpgdqNfA50lSdrfg9Put87YlDDD8SNRlH4TSwOaqlMqfhyAISsM1OpOR5PWrwx2Pw2yv4XW3yo7mm/CVBpS2bdjkqsby44koDs6mcYI666NsvnYTH8VX3YtpDtBfQ+emYq/jstbXUyiuTfUfvQwg4a8NBQAYtTro+wfX+e6nRc34c6aolBFnVR0XSqegBjm+iT0vV3PDsfsYli9MFu1cy0nlyxlgizJHbUhCowVmqB5lTG3iZm7Z85i62vQcvVBkJNlvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+Yn40P7stvG8cEFw/FILM8MJQnyEMjvfgowtEymWqQ=;
 b=yFkW0cAtoPcA+u4atTHJUfBQYPNw7C5XgNKHAFUVCWykh9MtSpHTLtxVMRgG6w+uWLkKiWdyrjP7Au6N2x+8fjpC0K2t3vXaJCPPjJyRI46FHR2jv312k3Pb6q6sqJqNqL9czkjm/oyL1jSUFOUCX+X+uUYoJN92Eku5Bjw7vooox2kmTBt4QQxuC+xJW3Lo7gGEmTYGeGVkvLXha+hmwxwTBD7DWXIIFA6pGYsXucR2Bk9/CjeQPhMcKhtQNq3URNvzgoHz2VQLTVf4YRx5HlEPtY+CZo2+OC7oO2bv4YjQ9i57Wdw3+ZXTnCa04gvARIGiYfx6v0y+eO7KMnnaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4852.namprd11.prod.outlook.com (2603:10b6:303:9f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Wed, 30 Jul
 2025 19:59:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 19:59:27 +0000
Message-ID: <3b0f08bf-9b44-4188-a3a8-b5175510016e@intel.com>
Date: Wed, 30 Jul 2025 12:59:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 20/34] fs/resctrl: Introduce counter ID read, reset
 calls in mbm_event mode
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <518b133429018f8b2f51055cfc2342536df98b84.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <518b133429018f8b2f51055cfc2342536df98b84.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fe4a5d-0f8a-409c-d576-08ddcfa396aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWU2bGNQRmFRZkFmTVVUbC9EaHJVdzdiSjBCWDhycWdQQ20yRHZOb0dOamRu?=
 =?utf-8?B?QnhKZ2hFYzZqbkVVbDBUb1k2c1pobDVxT1c3cU1jVVJYSHFGYXZ4cmZMelEv?=
 =?utf-8?B?WkUyeDlVdWFRYVlwUHd2NXRLMUZYQWJJNmQ1TjVFZUtLcmVkcHptVkRBSlVE?=
 =?utf-8?B?bDF5bThTVDlydk55cFFtdWU2QVYwT2M2Tk5JL2VBNFNQTlljSys0b01TRDlt?=
 =?utf-8?B?ekNYOHAvYmFHUkw1UmNGV1BYbFlSRFo0VGV6b1hLQnFuRURoQ1V3alo0N2xw?=
 =?utf-8?B?dENvczRSdUl2bW9xTzFPN0ZCaUk2MEZrUVJtd0d6TU81ek1qSjVUK0puSmRG?=
 =?utf-8?B?K2VxYzhkbHVsR0psM2ZrNEVoT3k5TEZqVlJNMGg2UFR3cmFaSVUvZnRJbW9H?=
 =?utf-8?B?NFBBdUFsT2ZvVzZTVk43b21LbDlmKzU1a3B2MTd2V2ZMVFYzTzFRdWQ3S1hm?=
 =?utf-8?B?WmlIRWFnQlVLVnBxc1dCNEkxa2N2bnozWjlRS0dRZkUwcDZpNDBFMWJTMGw3?=
 =?utf-8?B?RUlZMndBbFFmTy9hRlpxU2NWVUFxZlpGbm92dkVPdnA3VEhLdllzWnZIbGox?=
 =?utf-8?B?c0hYWDMzYzk3QU1nM1luOVJreG53NHZIQW5iMlBsdDVkaFFtQTFBRGxVOE8x?=
 =?utf-8?B?aWZEaHprREVzb2piZFJxalRXZW42dXVaZzBxTFJrR2N0cXhoeTVsV3FSbUxq?=
 =?utf-8?B?aGFQSUpkdmNQS1dBMjhsamt5cDdlZTduRDBScUNDQmVvYW1zZEhSbERKRmpH?=
 =?utf-8?B?UmFFeThKRlBJMWtvR2VlZTlBcWdjMHVyeEdLWWRxVEdHSDBCMDdOVjVDTmNy?=
 =?utf-8?B?MkNreFYzMnRKRC9kbVVidS81T3g5VWRKa2kyWlJhaEo4d1hVYTJFcTFHWWJl?=
 =?utf-8?B?ODBkOHhXRDhyZStzY2p4NkNLejljckZpN1FQeUp1MEZoQzRwTVpGWEpZZU1x?=
 =?utf-8?B?bVBUUWh2U0ppQ0szakdjZDl4b21CbEhzTGNXRUUrY0Z0NWkva3hXanFTVmVq?=
 =?utf-8?B?K3F5WXlZNlNVWVAxU1V0VjZNMVU0a3ZyYXNLMkVvOVhEU2E2RUdOckFCZ2lG?=
 =?utf-8?B?N3g1S1V3RTAxY2hQYlJCbjlhd3A0YWdZdFJQSzEvdFQyQkRjc3gydWVzenho?=
 =?utf-8?B?Y01yWmdsVXN0SVUyank4SVo4YWNkbUZhSVErVFV4dHl5TjM0TWUreGF3cjJK?=
 =?utf-8?B?a1IxUFRVK0hRRHdSdEFCbk1uYmpuakh3N05IZ05XZWRMV2FjTzBrV0ZmODQy?=
 =?utf-8?B?VmVadFI1OGR1ZXc4R1BLKzR4eUFyNnZyd2hESE51VkpxdzB4dWZFeTRDbitv?=
 =?utf-8?B?Rmg2WEIzdmxWempoZllLemIwL0hQaVRuUjZybGgvWnpHcEFaYWxneWE1L3Ju?=
 =?utf-8?B?RmNkZUpTZXZQMVN5d1NNdHl2VUJxSStMdDU3MjVtUnB2WFNidVhIY2IrOUZZ?=
 =?utf-8?B?N2hxaWxNcEw1MC9iSG13U2hjV3RTOEZBVWtzUFFCS29qUDRUYjlZaEtHbVha?=
 =?utf-8?B?Z3hiSnk0YXFPenJsVk9tU0JvcHJBL0NSTjJYbzd1Y2JYNWZsRkJjaVZhM25B?=
 =?utf-8?B?amcrL2xZcm14S0lBd2FVYkFWOHppeVhMM3ljV3QzNHJtRUZQK2w3bG81VFpp?=
 =?utf-8?B?QXJXS214MWFEZDZReWErMVpVY2tCZnJRNnNDa3FCSWV0Z0JsTmJoY2NBc3Jk?=
 =?utf-8?B?Q1YrNk5MTXd4M1M4VWxnUmF5NUxBSWpBbEpnZVJpN0pjcUFQVXB0a2lHTGN3?=
 =?utf-8?B?MnJ2S3k0dmFhR3kvcllQTnFPczY3V01icGhIeUo3OVFmWENyc2dJUEpkNU9D?=
 =?utf-8?B?d0ZqQmdkaW0wckg5NkVndTBLYkNxb2pQVWk2NXByZHJlMnRVVit2M1d3SU5O?=
 =?utf-8?B?ZmVzUkV2OGhiamRKK0lRZkpxakJyeGcxSkJmWFYzck5XNEswdVRxSHg0b1V2?=
 =?utf-8?Q?RpFyd3VBaWw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anhsdkFSOVdnb2tsQmFTNVd3QlVaUEZ0eWgzRTNuZFRWemRtK1Q2cnkrSnpr?=
 =?utf-8?B?YVlaUDIwM2h4QUxKcklqK3Y2TDhORmt1bS9YMmF6VmRxSlBpZytaM0lLT3cz?=
 =?utf-8?B?aVZDdU82enFJc0lLNkcyL0FYY0J5N1Zlc0cvd3Y1elFNNFFGam93cCtJcGhZ?=
 =?utf-8?B?STloR3N6TUZ4dGJKSllxY2dVVmc0N1F4aG12YnNsYWIvNGlrZW1wQWRJc3Bj?=
 =?utf-8?B?cEJpUWxVS0RmVHRxcXBEUnlhWTlxeTc1cGlEOW5yV2hTbWJnenhqR2syOUxu?=
 =?utf-8?B?bHpyNW0vYWF0UTJENURVNGlPODY5V0d4TkV6RVRUT0N0WmlHdHZCanpscmIy?=
 =?utf-8?B?bkRPcllVbWhkQzk3MDVIaU4xSjBIMUpPbmRCZ1JOekdGejlHeHQybDlQekFF?=
 =?utf-8?B?b3IxQ0F5dy9lRE9FQWU1dHdZQXFsRkQrMnFUMksrTklzbjFvU05lS3B3dWtR?=
 =?utf-8?B?Rm9kZzBnVkZZRUVDZnFDU1Q4S3BsY2tKNzlIbktFWFVWK0pibEkwUlk4Zjhx?=
 =?utf-8?B?bHZoaFBLSEJoek42NDJrU1Z2L0ltdHpFOUFQZ2hZLzFvanp1WjZqVzhycTZt?=
 =?utf-8?B?KzAxY0NXVVhkSUY2bkVLSVB3Tk1qSU5QUWRiMzZ3dHh3NUxLQVBSaE5aTDBW?=
 =?utf-8?B?TS9VaGxUSkd3Zk4vZklOVXZyYnJjS29vZ1k0ZUkyUnNvM2U4K3ZGRGxDMUpV?=
 =?utf-8?B?bThQa21ibjlDcE1heXdnekdNNENiNlQ1NzBIZEgwQ2k4dmhhSTBTeEExaUgw?=
 =?utf-8?B?cXJvR0ROQ2Joc2dNdW5NNGhzNHA0bEdoWUNHbkdKa1BZNUR5dWxxbUd3SzJB?=
 =?utf-8?B?bkRyYzB0QzZHdkhLOGIwekhKd3psbTBrMWR0NlRlZE5YR1dMc1d2QWJvT09v?=
 =?utf-8?B?dk1GTGJvbDdkSWw5Q25KVlVSN1Uwa3FVbjNZMng3MTdsRkRid0JXYWQzSkFx?=
 =?utf-8?B?S2thME9TdXkzNWtRYTJ2cmF3TjBrWDBBK0NaMURlbWZMTTYzRHl4SVZLMmhC?=
 =?utf-8?B?enJyUW5tcHVEZGYyZ0FURnA3bkIyU2FwSGsrbDJBdTE3cVlzYXdHZ1lHdXJr?=
 =?utf-8?B?WWdkclI4NzAxK042RFJhN2tGL0svbnVXUDczTVo0aTRKR3ptb3JNRk1vbm03?=
 =?utf-8?B?cnBBOWtFTXNCeWFIM0NCbVdrRTBWWnVoa0RKUmxJYUQyVzdvMGRxdXdpS2Fp?=
 =?utf-8?B?N20vRUxhdlU5SGpxbzA5Zy9TeitLZGVUTDdyb1VvdHZCNTFTcWltbUN6QXgw?=
 =?utf-8?B?Q2ZWZmMxdEN3Wi84dnNwZmVuZEdMZFRLWFpEQm5UNVRHZkNFQktSYkkwVk81?=
 =?utf-8?B?T29oTDhsMlhDVkNGNW5MSTJadzNhOWZCcTlMcTBBaHROL2FKQ3ozWTVUa1dZ?=
 =?utf-8?B?c2NuRDZhMVNVL0xzanoza3BuNDA0UlRvL0FvdjZxb3ZXUkt3bUZFMkRheDVR?=
 =?utf-8?B?ZEhCc1A2cXRTa0h5bjJDSEM5TTd5WndKM1QwRTc5aFpybGQvVVF1VlY5RGNo?=
 =?utf-8?B?OHc1dTkvdUI4aUF1Z041THRqRWlnSG1kL2hPSklweEEvbHNOclNIRFhDM0NK?=
 =?utf-8?B?d0xSeHlVTXhhaDhJZUNuRHluM1E1ZUZXSXlCWWZ0eExlbWx0QVh5UnowV3Nw?=
 =?utf-8?B?WlVXSUNzSEZlQ202OFRSWmUwYW10MmhndFc3UXBxS1ZrWVd0TVJpY3VvVXBO?=
 =?utf-8?B?cEtUTG1YQVdVYkplQ3krMGw5TjBuMEdPYVJPdlNuSWFxbCtTbW9YVnloVStX?=
 =?utf-8?B?VENPakQyUkgwYk9MejNGSUwwendQdVZqY0xOZGNoTkZndllCWEVrK0g0Q2cv?=
 =?utf-8?B?Q2pIWmY0UDFvRm9iZDJZcmZVOG1GT3pyajZJZHhqZ0FueVFSMHV6ZXRFZ2do?=
 =?utf-8?B?WDZ0SnR3SXNwd3A4OWdiZEh0MWlyQWk2bk8vS3pJY01qbUkzZm42cjI3bnJu?=
 =?utf-8?B?Q2R6Um9mQU9CbkZQNGN3NUxQYktabEljbzZPYm9BNm5mb1VxL3JvZjd5clli?=
 =?utf-8?B?UDdUMW5LOE9meVY1MUxWTXY2ZHpxUkV3YzJ6TlQ5T095dGRjWEdScDdnbjM2?=
 =?utf-8?B?YnA0NWR5OW9oeXVUYzdHM1RQU1VqUUlzTzl5V3pWT0g2ZDRoMExJdEMzS3Iw?=
 =?utf-8?B?VC9acDdudWU3TVdKaE1BZUJudjlNcFhXMzArbDVIY0hONDFvckdFdlBhY092?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fe4a5d-0f8a-409c-d576-08ddcfa396aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:59:27.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTmZ9xrvp37ubf0hcmsrnGEI1cnYY94Zw6+9QIuskUjkAuHvaR6owuxbWcYfOVmE6vTw6Jkgzxi30Cgd49auc/5bdG14zqNBFMINMkiIAyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4852
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> When supported, "mbm_event" counter assignment mode allows users to assign
> a hardware counter to an RMID, event pair and monitor the bandwidth usage
> as long as it is assigned. The hardware continues to track the assigned
> counter until it is explicitly unassigned by the user.
> 
> Introduce the architecture calls resctrl_arch_cntr_read() and
> resctrl_arch_reset_cntr() to read and reset event counters when "mbm_event"
> mode is supported. Function names are chosen to match existing

(apologies if I gave you the text ... trying to polish with more focus on
imperative tone now)
"Function names are chosen to match" -> "Function names match"?

> resctrl_arch_rmid_read() and resctrl_arch_reset_rmid().
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  include/linux/resctrl.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 50e38445183a..4d37827121a6 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -613,6 +613,44 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>  			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
>  			      u32 cntr_id, bool assign);
>  
> +/**
> + * resctrl_arch_cntr_read() - Read the event data corresponding to the counter ID
> + *			      assigned to the RMID, event pair for this resource
> + *			      and domain.
> + * @r:			Resource that the counter should be read from.
> + * @d:			Domain that the counter should be read from.
> + * @closid:		CLOSID that matches the RMID.
> + * @rmid:		RMID used for counter ID assignment.

Can this be more specific, for example:
			The RMID to which @cntr_id is assigned.

> + * @cntr_id:		The counter ID whose event data should be read. Valid when
> + *			"mbm_event" mode is enabled and @eventid is MBM event.

Would the counter ID not always be valid? Specifically,  resctrl_arch_cntr_read() is
_only_ called when "mbm_event" mode is enabled and @eventid is _always_
an MBM event, no? If you agree, the @cntr_id description can be something like below
with the calling context details moved to general function description:

	 @cntr_id: The counter to read.

> + * @eventid:		eventid used for counter ID assignment, such as
> + *			QOS_L3_MBM_TOTAL_EVENT_ID or QOS_L3_MBM_LOCAL_EVENT_ID.

The "@eventid is an MBM event" can move here? For example:
			The MBM event to which @cntr_id is assigned.			

> + * @val:		Result of the counter read in bytes.
> + *

It looks to me as though some of the @cntr_id text could move to be the
function description. The description can also be expanded to include where this
will be called from. For example, 

	Called on a CPU that belongs to domain @d when "mbm_event" mode is enabled.
	Called from a non-migrateable process context via smp_call_on_cpu() unless
	all CPUs are nohz_full, in which case it is called via IPI (smp_call_function_any()).
	
The goal is to make information specific. Please feel free to improve.

> + * Return:
> + * 0 on success, or -EIO, -EINVAL etc on error.
> + */
> +int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			   u32 closid, u32 rmid, int cntr_id,
> +			   enum resctrl_event_id eventid, u64 *val);
> +
> +/**
> + * resctrl_arch_reset_cntr() - Reset any private state associated with counter ID.
> + * @r:		The domain's resource.
> + * @d:		The counter ID's domain.
> + * @closid:	CLOSID that matches the RMID.
> + * @rmid:	RMID used for counter ID assignment.
> + * @cntr_id:	The counter ID whose event data should be reset. Valid when
> + *		"mbm_event" mode is enabled and @eventid is MBM event.
> + * @eventid:	eventid used for counter ID assignment, such as
> + *		QOS_L3_MBM_TOTAL_EVENT_ID or QOS_L3_MBM_LOCAL_EVENT_ID.

Above should similarly be specific.

> + *
> + * This can be called from any CPU.
> + */
> +void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			     u32 closid, u32 rmid, int cntr_id,
> +			     enum resctrl_event_id eventid);
> +
>  extern unsigned int resctrl_rmid_realloc_threshold;
>  extern unsigned int resctrl_rmid_realloc_limit;
>  

Reinette

