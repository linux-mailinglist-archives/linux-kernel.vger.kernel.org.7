Return-Path: <linux-kernel+bounces-873730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDF7C148DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221C73BC34E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B572314B83;
	Tue, 28 Oct 2025 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGR1D0zD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B03B2A0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653486; cv=fail; b=HWlss67t1wDRTTriAno6BVopTfvW7atwZAQqyszAfCJd1GStbstoIThmJeLnfirQu9BREqb3bwVE/tAU/GwPiXN3FnkEuyy2koB0g8rW6NEoKPte92ZOwxiuf2+M3UJexQWZYqJA3ImHMQPi4CRphgU+eUfFpy7Kdgxr4NJF2YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653486; c=relaxed/simple;
	bh=RIRegkUDOaleTreBsqHwrQ1NVOsL9vq6Fcj7OBenSZc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JEEwo33kZPoPwOtXpHhrmJwJAqdoUqE3R+wb1eOtPK4BhUNKw8EkzS8v9Q0+ZlqCBc02dOCYkYC2G6kcROyNHAwnNGrJPJFbP2xySqI8Za4RYzMBGTv+XDsnI1g42iPAk0CxpAeK74lDVjkRlpiI+WgoequAYruqiAbzFJJfugk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGR1D0zD; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761653485; x=1793189485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RIRegkUDOaleTreBsqHwrQ1NVOsL9vq6Fcj7OBenSZc=;
  b=BGR1D0zDDtlq4ZcC0HeCu+VtXl102uZRtffSCRBTz3HmcSziI/rnML6v
   W3JG8E3HPI1FTsKmz4YHTiJmhzl8yyVOBLzPpQyA1ZDH88J38/09DUeVO
   ZfQvsgNfgXuzhdUEbfCKKj95SW9g85JhY7aiZfpGEsbTAVWB1a5pS+FkU
   8EFONFkaFPgkBoSw+xog9Ws/GfeAB39E8tehsFKgUsy27XOP1LGeJpqOJ
   IAgazLXedK6iw0Nke6nH8K0wEHtkV8+mazvogbR1feYefhkVmvMqQIk8X
   3D1l9Ttui+2dwL3WqphTIbmasIpFtTIkPuUMAx405IcCMmghyt7Xwvhdf
   g==;
X-CSE-ConnectionGUID: vQtL4SAfQ+6znDVZRNERkw==
X-CSE-MsgGUID: QQVPPrlCRZWG4QH7Vx2uKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63453126"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63453126"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 05:11:24 -0700
X-CSE-ConnectionGUID: hCd0C4hbRCiA9AY61bUtdg==
X-CSE-MsgGUID: k4q8WkEMQ8CsSfLu0L+yfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="190521534"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 05:11:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 05:11:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 05:11:23 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 05:11:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BX0d+wM3tjdJfQatxfeXkkcP5/b10rrzARuqvJ7H6GTovEx2GOQ++ewZH6rPEe7QBEqqTOmwRcQmb7gPhJeqKU+OcoyQZZcK7fbQXcdp5reVz5tptH97lma8lDEUFrSYSPyip3ky55Ij3MpKem3EVahCYGGN85sjkZOhvaubFB+uQVP+RlkYw1Gq+GaG9vwQGupcCM8WVXr+Vhs5klANhNuspJRkGp9qPpklN+xHQxMI3PbmBCEXdJoEsh2NbXTvQEzz2IACond0B763YCmCsLVkec2OOxQfcxKftfMw3fORyg4VzpW2ttRpLbJKAGNuPjwo8CXG84Ap/gbSv2dV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1TFKC4kFdumuDfbAg6T/qLiQIeTaFSHp7WxEaW4UeY=;
 b=B9Pp/Z4sYvRr/nNNusx0jvUh7FnYJ8FF89li5M1Xg2WjDEzMy2rG3Bqa3qrtsk8y1x5nYN0CYgfVQhDANnTHSehAWjgBa9IuRyIDzr8dT1OJzBwFeDpFMNSxsuapopuEmi9kB2VzudRhs3DjHyeyYgkKPvvKH6MX5QDUqP6n+X4eies/P2vRHdnaLazpNoNn9nVcqx8VqaTlMphRI/xhAlj/mK8EaPuBrbrEHilsGY2Rok5BiE/ZSd42ReTDmUk6Z5Foo5SpzI5zGJzvNQS5Kc2p7HTglnsp9MSwRhZ/6LQPgZKs2eQ2P9LVmEqzmBqLqtK5Yi68JFQeuJ9ZFevNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB8525.namprd11.prod.outlook.com (2603:10b6:510:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 12:11:21 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 12:11:21 +0000
Message-ID: <a921e566-0490-4164-b329-93da0bde52a3@intel.com>
Date: Tue, 28 Oct 2025 20:11:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] sched/fair: Prioritize tasks preferring destination
 LLC during balancing
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
	<tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>, Peter Zijlstra <peterz@infradead.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
 <576e63aa-3b39-4d05-87d3-e894ab57dcd1@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <576e63aa-3b39-4d05-87d3-e894ab57dcd1@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::15) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 84686cdf-875f-40bf-5de6-08de161b1b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N29FcmEzd0xpNUFYR2pWaTFYRU8rMEFKQjkwTWI1L3NjQW5Pak16eTFLWVl6?=
 =?utf-8?B?dUk3STAzb0wxcEpTRWc3aTlaS01oL1RNZis1R21KYktNc3VBM1ovbmVwQWJY?=
 =?utf-8?B?NndSajN5aFVLWlN3WjA4cVRhRVdxWEhEZlF6Ym9VVHRiL1pVSmZBQUx3UXR4?=
 =?utf-8?B?WDcwRFowajEzMFJKN0NyYmtBUkcxQjJpUmZqL0pBRFMvdHQzc0NwNDJTdDRM?=
 =?utf-8?B?eU1TK2d5Y3kwSTJJN3dvZ3VtVzVnMERheTVETHVQdStESkNpMHM1SmF0N1I5?=
 =?utf-8?B?VnBoeGNLbmtmWGYrcExOZ3EzVzBleDR1WFRDRGt5ak5WTm4wMFhkSDFQNzdB?=
 =?utf-8?B?WU1ZblhVdndrMkZBdmxUcEtVaFBJSzM2U1JoK3V5UkVWSjBHOHFXNXpQVzdF?=
 =?utf-8?B?bFR5R3ZDZ2RRY3h3SGlsZk4zMHNqZXE3NmYrVzZiamdVaCtXcXdqS1VQUU5k?=
 =?utf-8?B?MXZlemZWbHpKZk52STFwUXpjSk10NUlvUXBQcTk2UmVxMS9KWk9TR2RaUStG?=
 =?utf-8?B?MSszUTVlLy9mZmM1NjV4eUlxVnRJWDVXK0xBT0hRUEZWaGNxYjdxYXFIZVU3?=
 =?utf-8?B?VGxuZFZnN0t5dWxzTTdGUWV3bmY2dlgwSk5OUkxqZWo3L09Qek4zdnUwTkly?=
 =?utf-8?B?Zml2WTRHeC9mMjh6ekVCVGhXSnc0NmppYy9LYldJSU1kL0huM0hGQXpqSmZL?=
 =?utf-8?B?c0tJaEtKWmtmVHF3V1RjaEJFU2hXMm52OE9OeG1PNjVXVFJGcWNwQXhjYUI3?=
 =?utf-8?B?NGpZY3ZWVmtBZXMyLzhvRlYyWTlvNVFzM1RvWTJlbkU4QWc3VXJnbEI1QUd5?=
 =?utf-8?B?TmF3MnJVaUdjeTI3Ky9qUlJ3QXhQSUVaakJKVjBzZkFobXhkYmRpbnFDbWcz?=
 =?utf-8?B?cVZvS05rNC8zK0F1anlnaTl5MmN5Q244UWprMGs0cHdscktvOEJUZmdSbFFJ?=
 =?utf-8?B?emhCanJ3bVR6cVBTYkh1OGcxbFAyUForUmovelBLbU1lYXZBNVYzMWtwT1hV?=
 =?utf-8?B?bzUxdXBRLzZDbVBVMFRERjdSUmdSSFROQTV2SUVDNlh3dVdkaGJ3bHk3RWlW?=
 =?utf-8?B?UXk1eVZNMldwZElndDljL0JGQitia05jeG9weGFmZDlkY1NONkU3VndWbS8r?=
 =?utf-8?B?enJvL1JTRDJqUm5JbmlKZTVxWC9FVEo2TGVzTW85aEdTRFpHZzlsNEI3MFQv?=
 =?utf-8?B?S1RKSFNjVEtJaVZxdFd6TEIzMUtkUjlaUytyQmJ1K09hVDNTR1pPbVlvL1Vy?=
 =?utf-8?B?RXd4SllCclFnb1lERjdHalhtOHRGY2xseVNqcGFFcEpwWWVUdjUxVy9hVkRG?=
 =?utf-8?B?ZlJHMjUxK1hvbWN0d1c2S1p0V3VXYXE1QlJLNFZsNC9iSmZsUmtmRVBXQmN3?=
 =?utf-8?B?NUJKbVhnc1h0NG1GTEg5WjhsMkNPQ2Era3I4bWdOMFJpVFlsdm1GT0lDaWxt?=
 =?utf-8?B?QXhoSk1kNUw5RDlvbTF3N1BrTEF5TTlPS2U4WkhOMWFMbURPU3B4WTdVUGxn?=
 =?utf-8?B?QmZFV2VNNU5VWnhWWThGS2dzZ3A4YWVCM2ZnOEhadTVqZGJWcFFGeFpGV1Fx?=
 =?utf-8?B?S3JPdW9vdkhwTnFCK3Z3RDFnYWxVNk9xd1Z2TFZ6U3EvRGQ2MTRheGpkTFFE?=
 =?utf-8?B?SGJUcE9mWE0vakdNNzJEQUNyZkswaXREYjlhV0MrdG9PZ0s2MVhDbzdqK0tj?=
 =?utf-8?B?VUI2YjY3UFVhbGhLRy9mSVZ3Wm9qWlJoeXB0cmRsS3BiTVRpUHN4TVAySURZ?=
 =?utf-8?B?eHdzR3J4WStsblgvTnVkcUdxTW5OT24zTzNYWUJ6MHNuMGdiNVp0YzJld0Jp?=
 =?utf-8?B?OStDOE14NnRvTTRtREdzanF4ZEMrTjBsWGJkMWpwNWxoaEpneEYyeUNtVmRz?=
 =?utf-8?B?TWdEdElxM0U0L1F4Q09CMGFFcTRZZ2ZzMEg5ajM5VWdTcXZKdDYxSnhjbGwr?=
 =?utf-8?Q?x+4kb7/y8BKAnFXkeg+5G+LZQ0oMEzSp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3htOUxyLzVjb1N5N2FSVmFOQUx6SzFDZEJnOXdCR2F2R21ZcFZpZkcrKzky?=
 =?utf-8?B?QVIvcmYzZFYxNG42N2hpR2xoNG1xdzlwcFNsOW52T0VZczZId2hLM3FaZUdJ?=
 =?utf-8?B?YUdLclJ2bEk3ekNUaVhzamJiYmxhZmZ5VjNRbk9NZklWcFpLblVzMS9pNG5k?=
 =?utf-8?B?Wm1EbERRK1RZbll2ODdvcldqeG1xNlI3M2FIUnNwSytLQnc5WGtBRUdOa0U0?=
 =?utf-8?B?UlJYWWsvcm5vc0R5UlhZNTE4TGJYekUvQ3Z3c1VaenFzbkNtSTVMbHFNYzM3?=
 =?utf-8?B?Z2E3YnJyL1kxOXR4QTNaSHlEakxDSElTSG5HbHcxbFI3aXlUQm93NEtUWEhO?=
 =?utf-8?B?M3pBdWZKSWhUci9pT2tkYkJ3Z0s1VmVGM2pKRjRsUW1BRE9pZ1RBU2labHBI?=
 =?utf-8?B?WnFzYllUUy85cUxIVU10em9vMHJ4dWx2M1NBRi9MTU9QSEdvTzJNVkVReEZQ?=
 =?utf-8?B?WUtuZGZCUWFRN3gwQUczNWNjdlBKVWxXdkM0TFdUN0xLMVRLTTlQNzhQUEM4?=
 =?utf-8?B?cTBFTmljM0M3ZXBORFpTbERVSlQ2SWtaM1BXenZReDROYW1pVnJOc29XWkwx?=
 =?utf-8?B?dndVWTV3VGxvWG5ndUlWcUM3VnBocDNsYXVRcnlDRkI3dmpRQVpQb0xRRlRF?=
 =?utf-8?B?VGFoNHNXQmlzL1RvdTdQQjRkbTU3VlZxWkJyQjlubURJLzFUaHU5d2hUL3RZ?=
 =?utf-8?B?V2wrK1c2YTVVVHZ2V2RVYVZ4VDZweVI2dVpWclJEZ3k4R0c2WGFrMDdXdXZP?=
 =?utf-8?B?M0dvbFRFdVJEcXNJQnI2SkpzSEdqV0VkYnFZT2c0MjV5d1ZSTGxBdEMvT2lC?=
 =?utf-8?B?eUpBdlVQV3dyL0dVRkZjTytra2dVQ0hMRmllTkFodmRmU3BhYTQ3Wi9WMm9W?=
 =?utf-8?B?dHVIb2I1cWVzODgrRU9vQ212RWxGa09YT3VocVlJMG5Ta25ZdmwvSU0yQzAy?=
 =?utf-8?B?UFFGV080YWhoZ0NxY3F6NW9Wb0JQTjl2d2FWbzkwZkdGaHVObHRSS2ZFMGlO?=
 =?utf-8?B?TG5FSWhveFhOaUh3UXpmbUlPTEtqZEt3OFFZSlA0Tk8zbHhGbTlmMk8vTFRO?=
 =?utf-8?B?TUpicHcySlhQc0pHaE00Wlg2WDBGSkM4encvak9ZUWNtU3V2Tk13bERpZWJM?=
 =?utf-8?B?S0EzNFk3SndYYlg2dTBScFpFWWRCYnQxRFRHbGE3ZDVraGNhcUdXVDBwUVAx?=
 =?utf-8?B?d2svWklFNmZNcEFZUGM4ZmlGRXlIZyt1UGZGczJBZFNXQUFVM01FbVBWUG82?=
 =?utf-8?B?dGpGRk5pbDByeDg2KzVxSHYyWDUwWXRKUC9XbHFaWWN2akxSWU5OcUR5RWpG?=
 =?utf-8?B?U3k1bVpSakJhVWhIQnhucVhsc084WmJpM2ZlclFVV0NuTno3MXMyNDV3Zkx1?=
 =?utf-8?B?Qm9rQldZZlhDOFVJNVEzalhEYy82UzVOZkdGampjSlhMUjBKekthVW9jQisy?=
 =?utf-8?B?bjU5UTZWY0cxZ0FydDNBU01DMVFERHhaL05TTjNzMjYveWxwMU5HNFhqNTRX?=
 =?utf-8?B?eFR6Tjc5ajdrOWFkNjh5TC9nWXJ0YldDUHI0SDkxeHZIZ0tOYjlsNE1xb1Ay?=
 =?utf-8?B?Ym5ZTmVQa1ZMUVFneEZrVkd3QVROOG9XL04vYjNnRUd3ZVRCa0hWeFVtZTZ6?=
 =?utf-8?B?d0tTU2Z5RnRwc2xELzZ3dXh3TVdzR3JXNFhKK3I1RE5zZTNzSGlobjlsc0Rl?=
 =?utf-8?B?MWoyU3lNUnVVMmcwSnNac1kxVzF6Uy84R1FyS293T3dKUDlQSHA3eVFobFpl?=
 =?utf-8?B?RUhud0lEdFBCME9PK2tpU2I0MHpPQ1JuUHFUamxBT3lkT2Zhd0JzTkZ4VVo2?=
 =?utf-8?B?dkZzSkc3RTVlM0lqQTFSc2poNUd6ckVHSVNOcHBUOG0wZWUwSlB4VzlkdWpy?=
 =?utf-8?B?U3lxTjhzb2NGYzFYc3JsNHpDVndGbjh4NkpKWFpqcTF2amFXR2pRVTlDU29w?=
 =?utf-8?B?eTlHM0RaWGt3OE10c0xTYm0zaVZjWkpWM1Q2WXpxRWcyTWRleUxHTXNPWVEx?=
 =?utf-8?B?elh3cDlkcFptTFJGVHQ4bHhQMjNMV25JR0htNHpiVytqTWVjeDZLRGFLL3RL?=
 =?utf-8?B?VCtTTWZ2dWtSTmxacWpzaUozTmxZcWpaYWw2UHpFQ1RtbmxWbTdTUnFhdDdZ?=
 =?utf-8?Q?Ag1krIdEZR96QoA2ASOOS6UYl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84686cdf-875f-40bf-5de6-08de161b1b4a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 12:11:21.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2afed571n9HHaXlt9oFlKwy9C1s3Z3WZLcAW1jmgwRl2UOQuOMKaXC3pZIdH8aWEtcIK1UOjG/gKLLW8iUH51g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8525
X-OriginatorOrg: intel.com

On 10/27/2025 2:29 PM, K Prateek Nayak wrote:
> Hello Tim,
> 
> On 10/11/2025 11:54 PM, Tim Chen wrote:
>> +/*
>> + * Do LLC balance on sched group that contains LLC, and have tasks preferring
>> + * to run on LLC in idle dst_cpu.
>> + */
>> +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
>> +			       struct sched_group *group)
>> +{
>> +	struct sched_domain *child = env->sd->child;
>> +	int llc;
>> +
>> +	if (!sched_cache_enabled())
>> +		return false;
>> +
>> +	if (env->sd->flags & SD_SHARE_LLC)
>> +		return false;
>> +
>> +	/* only care about task migration among LLCs */
>> +	if (child && !(child->flags & SD_SHARE_LLC))
> 
> nit. You can just check group->flags here.
> 

Got it, we will simplify the code.

thanks,
Chenyu


