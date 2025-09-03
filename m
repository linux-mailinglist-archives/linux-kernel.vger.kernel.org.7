Return-Path: <linux-kernel+bounces-797607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B800B4126A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEDF1B276AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01121E5B72;
	Wed,  3 Sep 2025 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGOiaqb2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DEA2AC17;
	Wed,  3 Sep 2025 02:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866885; cv=fail; b=c33wLhPkNwWsuq2Eefrtmj1W1/xCbwXFGbewDG7WL3jjHt12WIN/AubA5MePlQ1R2Xn5WuPMx9Ndhb5P95zrsmhBBcT1Dx41n513XXiE+Mh5ibzSVmISJYaIG3LeMatY11mKOTpEdiHSZLyIZkxYBTyUa3ShxBCtgDLu9tkmOtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866885; c=relaxed/simple;
	bh=DiZHVTKufdIUlzGgsluNuDYkDdY1/npsupEjIyPwINQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G93HbbLP4ulYTcZKQM/HQQYUHEIqCf2DjkLLnn1qWyHw/Up+1QE2J8JfgRldpEH+NT1uL1DReIrXv2kJLz1J79CxcvL84YtQPMc8ifyG3brBsdI9op+rlfi932vUjRP6jdanz5EgRSm8+PQKSTsQM2D6Od1edYW680xceeDekvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGOiaqb2; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866884; x=1788402884;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DiZHVTKufdIUlzGgsluNuDYkDdY1/npsupEjIyPwINQ=;
  b=LGOiaqb2jEcecnR7Y2Db+hLrI2HGV2ldhdtwIeil/Kv2RN+YfesNnCtf
   6Mci48TinWyZwqFjssYbg8/wA+T95EI4dJNG32ZgRgRaVPgJv55EHi8Wi
   MT+9hY26xi0enbMLPpm/OIR/hMXCfx+cD5hrXS5HghxbaOIBkFBG2JeUL
   dBcU3UZULw6geliFPvhuep1L1ou9puFOiDCRYHDkgpzIH2uzwZsVNFLVE
   DGXBt+s+DdnyIsWfuDEDaMcm6x/O7C2QmN/rGns0xPO4C5T8jEzE1mwg8
   zcErm7Cvd8yd0oLOUtYabYpj3jlSF7azPRmN1RRrqWWUq9LiXaqeVOLyD
   g==;
X-CSE-ConnectionGUID: fmMdsE2dRpSg3+jCfnGB2A==
X-CSE-MsgGUID: EbCJIN1IRCWiVQHUSo67qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="76612171"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="76612171"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:34:44 -0700
X-CSE-ConnectionGUID: jrS0+/WfTW69gE9EulzIhA==
X-CSE-MsgGUID: HQLaIACrSXiqPASp2StKYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="202408676"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:34:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:34:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:34:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:34:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOvAgI9r8VlpOe27m1X9SvpJK3iZSRGeIpA+Pfx14vnzIxVEDIRQfKZF8xu7CAdFBo1P7r9w3nSlLJb7bCIlZO4VHfDHjZkw8/zIti0sqoRThNvegY0oEgvUL5m1Rf9RZ7/OMiGfKycYHvD3EokUSpVTZxpG9oNBROBbcN+r5MXosusu9Caaa3J6s9neCqwFBKo3chc0T2FSc5IJtRRVPuBfWFLh3DA/TuwQgos+4nHtnsx8Sz7Jaqf5JbR6fKLRIX7NTNxTeqpohA+3ECnop6YmcAkg2ShzlTB/Uxok+vHv756urfy+2CWqOp1ps3ZP6biMVsGOEeaTpz/YlviF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHOYHGBs5TsZacezTj9B/g1k5O313DSx4d3YrBqWkpk=;
 b=lKjzUUyesZU6YuggvTWzb1i/8K9ugY5oHp4aV6Z/yz+zvdq+QKLK+EYKjV1xdMtNryrWb1wC8B0jflmE9d08GeeRXx/uX7p1Fn1zH6/4PGylxs/kGInDTSdvTCMdm92SWy/iP7nUijDsq/wiZBCFgbAdG1TSs7OYpX8mN/1R3zCGzzu6NelgdXPP5ZqTWBuEcg76gMAeZjsG1t7o2+peklV6Oa1BdAX6/QPl+EEBd70o88MhN/9DGtjP6CYYobQqujQOZew45YuMcqsxSmvblbMm9Qxy9DlAH7ohzHwB4elcWn+oZAOwTVLujrPB8PRcp9z9XzejgJE5mzSAJ6LxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:34:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:34:39 +0000
Message-ID: <469b7b94-6e96-4c12-8d27-94585bc1e681@intel.com>
Date: Tue, 2 Sep 2025 19:34:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 23/33] fs/resctrl: Support counter read/reset with
 mbm_event assignment mode
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <2aaa25da49e8fad9d6c71b7baf476f2d7977e8f0.1755224735.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2aaa25da49e8fad9d6c71b7baf476f2d7977e8f0.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:303:8f::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 20164db6-ca97-4913-3e91-08ddea926e3b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXRueDV4enIzVU9lQ2YzbCs5dlVRQkNTRnF1OTRKdGI0bU9JRk1Zb0ZwU3BP?=
 =?utf-8?B?NVBRVVRYNklxZElqc1dlalJ1eGNsV1UrYTF5ajdGdWRONEZPTldoQ0QwWHh5?=
 =?utf-8?B?RnRXRFNEd0RkemMxaEp0QnM2SlJQaFFDWXl2Skx4aFNDVFlFSGc2amgwZllS?=
 =?utf-8?B?anhpbDAyMGlpbzNSaVYrYjRMSGJMWElrWTBZSWhCSS9pSkl2cnR3dTBlOWtv?=
 =?utf-8?B?RWZOUTFVQm5JZ201bDI4NmNnUFU2S3FsNzNwS1J3ZDN4TVBOUzV5NGxXSkNx?=
 =?utf-8?B?a0E2R1BhSVFHNTBnL04wK0Z4QSt4Y0JBN1RZeTViRUhEN0IwdllINXBjWDZl?=
 =?utf-8?B?OWc5dXZseERub3NJQnQ1eGRsTEoxc2NKVEtPOTduL1BxNWFsMTdoOVlVRHVr?=
 =?utf-8?B?bk5yMEZlWkRCUzAzZmhIMDZoK1h1Uy84Q1dORFBtZWpvckk1M1owdGwyQWhk?=
 =?utf-8?B?cjlzMXhWNmREQTRrZ1FiWThXZTNXM0puRXRVYmhqSHZnbDByRWRuaHF3Nk5I?=
 =?utf-8?B?Rmt1c0RHelZYc01DMXpJQW1Dd2l0OFcvWktJT0J3aDlCdDZhOWhpVDhveHVY?=
 =?utf-8?B?djRiSWcyTDJpY3VrM0lSend4enpnajBOMDQ1VTZ2ODlyUXYvUGZZOVJ1bEsz?=
 =?utf-8?B?Q3FFZGxOQnpRWVJmZUQ5cERvTCtJRTZ6SWUvVmNRK0pVL3ZOZVk5NEM3UUNS?=
 =?utf-8?B?SjV4bFUzRFJVMWIyMDVoOTAzNzhMc2x1eXdOL1dXdTZiTlBIZi9PYWh0a1I5?=
 =?utf-8?B?SnA3eXdYTEN1a2owbjhFOW82eHJiL2lKQ3VIbm5FVGNRSmQ3dVV1bTY5OU1C?=
 =?utf-8?B?Nk1sVkdMY3NkRjB4YS9LMkNQL0dKUHJSMlV3bjRuS0ZGdlBwTUFSSGlmTnN5?=
 =?utf-8?B?VisyeTNUeXB6Szl3ckdkVWJwNVNOQ05ocWZ2MW9UUEVYUC9nWVlibDEwTnNI?=
 =?utf-8?B?QXZuUXVST01rODFOTFp2ays4UGM0eWs3VVRTRFdReTJWRkphUmw1TDRHTmpZ?=
 =?utf-8?B?OEEvbUh3eFAzWGhUZlRWZUVXNkFVb05WbGFIWXl2ZmZVUlFBaWdaeXRFaHZF?=
 =?utf-8?B?d2lmSHQwY0k3bVhMREJoOFRhSnA3dEtHeXdOMzBTZU96RUg3ODYyWExnSjgr?=
 =?utf-8?B?R0FlS05pODVWN0Y1NnUyUVh2cUo4TXR3Wk00aVBBVC84YmhYVUlua1ovM2k0?=
 =?utf-8?B?VW9WckR6ZjMzTnR4UUZDV2hVRXg2eDZ6cDJjZjMrUWNncFhrdUhTRHlka3VM?=
 =?utf-8?B?N25aQmhsbFRUMDR5NUdZSlpZbkVUVjRZUzZsaHVYQ2ZmZlFUVlRYTExDOG5l?=
 =?utf-8?B?a3FlM1gycEdTSXZTT1JmT3kvbHNUcE5aZEIvVXJxNHFyOXFaNTdnV09kOVFo?=
 =?utf-8?B?MWs4anFXY0NHTTJOM214ZGVNWUhHejRYSW9sMTZuTWZ6NmpPdlk3NWpQK21Y?=
 =?utf-8?B?REhRcGJ3djNndVpkZVFqaHhOaWV6NnlQazN6L3VwaC9ucXlzMVFQdFVMSitL?=
 =?utf-8?B?UjE2TFM2NUswTEtpaW1PeUJoZjlXNm9SN2Y2ODZxekFhem9YUEJNZ2ZMYy9U?=
 =?utf-8?B?OHpjRWpldk95WlpQbEhvQmFXQXBMU3lOZ2h6cmZwZTZDN0pmZG0zbElkaXB2?=
 =?utf-8?B?a0NjL2pweEVDWDE2K1RYSFF4OU1IU0kxSFl6QUNoYXF6SDV5MHFnbTRoZkp4?=
 =?utf-8?B?ZEY5ZUo5bU5STzFNa0tYeFlYQVZVWEFqanhRQWd3SjhzQnI2dVdFUE95cnVy?=
 =?utf-8?B?cXYvOGZKcWlhVVhMemFrb0RUM2xDbjRrUjJrUnpyS1hIMEd2L0d1dC9zcW94?=
 =?utf-8?B?MkMzUzV5YjluUnVlUGlzS1EyejdCMEIxRGVtZ1VOUUQwZkowY1U4dnpIYmVI?=
 =?utf-8?B?QnU5bGxlblV5LzF0UDNiTkxmR3EzYVN2cldVUjBxVm9rNElVOVo0aFVHdUUw?=
 =?utf-8?Q?yfvXsI5Emls=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjByZklLOWpZWVM4dFZLZlhkYTcvdlRLN0E1VWFMMWcrbFBCMzZNeEx5RnBD?=
 =?utf-8?B?S3pUYk5YamxxYjEwWVZTcVhlRFhnK2xvdktySVFndkhWT1c2eU5oc2o2MkVZ?=
 =?utf-8?B?aGlrcCtUU29RMzNuTEgxajlwNFVjUTZwelVtbjJVU3BWZ2Zjb0VycVlwTjBC?=
 =?utf-8?B?M1BaTDkvWllSK3NrS3RURnVYVUFjQlM3THN5eTlEbFVpaU42YWJycVFLWlM0?=
 =?utf-8?B?bUFDZnpLUGFtcTV5M1MyeEJUUnYzd2VPc3NMQUxWSzQ2clEzdVh4ZEJQa0pH?=
 =?utf-8?B?UDdkaTZ5aVk1N0xtVmFIemRqdHZoNVpGVGdqMVJ0VW55Q0dNOTZLeWhGRkNW?=
 =?utf-8?B?OVpHemFsQnNkTWFGMXBQLzBCbEd4TjEwbDRISWQ3WHpiSkZMVlNQbnJOaS9t?=
 =?utf-8?B?SCtNdGJ1SWMrZXk3d1hUcFpCT1BEYWpQM20zSndhcTdTV3ZqenZrZW9aZ2JP?=
 =?utf-8?B?aHBSMDA0czlHd0RSdVFCbE14U29lQVM2ZTk0OS9kODlFNlp6ZllMZmF3eVM0?=
 =?utf-8?B?WUNJQ3k4YUdCZWkrMDJoMk44MDBOODc1L1BVNG4vbU1CZWZKWjUvWkN5d2pD?=
 =?utf-8?B?cElGdE5QTnRXaGVBK0NZSDl2b1p3ODRBOXBuQUMzODNiakdycUFIdnF5MmFK?=
 =?utf-8?B?Z0doVmVHeFU5L1B0enRtdnQ4ZCtuRU5XckJzQUFwVk5JZnFwRmY4V29MVWR6?=
 =?utf-8?B?S2tZb2FGS1RiUEFMTGRpditXd3g5ME1PbEM5OE95ZlRqTWpJamhHSmltbENS?=
 =?utf-8?B?OWwyM1JiSGZkNkNwOWVwaHVIcXR0czZjWmcwbVNjaXhzQkc2SEFtZHlmb2lo?=
 =?utf-8?B?eE1xYW5nNDhkL1pyK0xCQkR2SFd1VG5jTDJDeUNiMTFQc3VJeHYraTMzdDlE?=
 =?utf-8?B?K2RnSFp6TUJUbGJOeWlnR2htUVA5cFpYa0taRjE1VFNrMDZFOGxCQ2h0T1FF?=
 =?utf-8?B?YlMzTkVYSXJvNHJkVVhWOGJkTHBKNW5Tak9KL0hCb0pCbU5IKzFKZ0hxTWlN?=
 =?utf-8?B?WDNlVmczU1VyYnEwWGFPZ256a2NYbXNOZ3dsbk9BcWJqRC9SUEgyVC9ZeWx1?=
 =?utf-8?B?YjRaUktBKzM4ODBUZVJJby95V3FjMmhXUGM5NDNoVFJ2QThCRXRYbHJoVzRm?=
 =?utf-8?B?cWFPczJGRTB2dyt6SGlhY3dKM1o3SW9NVU1iZUV2VE0vdHYyWkZUT3ZmOHps?=
 =?utf-8?B?dmhwdFlHVnZsdmc4SzBxK2IxQWd6QVdtWWtteWVEdnJRSDhWL2JiMjYxUktU?=
 =?utf-8?B?c2JUV0diTzdhSDZ3cVhia1BST0NVcGN4blFMK3RiTUl2c1haRmdzNjVSSVhv?=
 =?utf-8?B?RHpYaXI1eS9xNjdkWnZuTVA0SWpsNHZGKzNET1oyMTdERC80bVlHdS9xQ0VC?=
 =?utf-8?B?V0R3THhoUHpwMEJPSXNKVHVpR29LeXJRa3NOT0VMV0R6UEUxUDYwdGxJYUlW?=
 =?utf-8?B?YUFnVk44RHNyMVdZaWxGd2M1M2g3S2QzaExDamFFaWpNNTNIa0RmZlYrRWNC?=
 =?utf-8?B?TklkaGU0UlZnTlE5RjBPQTgyMXpreGZpTTQrbm1sSUJPS2RrcXRYNURuSEJZ?=
 =?utf-8?B?QzFiYnluazJNOEpSU0VyVVVpeGY1Q0VXQS9EVTM4RnZkSTFidzJia1c1TEpD?=
 =?utf-8?B?TnZxTGhKUWM2dit4K1Q4NlIzMmFoWWtLVkN2ZjY0OGI5c1kzS1NLUGRkaFB0?=
 =?utf-8?B?aVFXOTRUNGtHcEV3UHg1WVg1eHhXcGZzanRCT1pLajN1WHkyUXJpNkNSekFJ?=
 =?utf-8?B?c3dBZVBXOVN4dzA4K0tBVXZCR3dDMXIwK0xxemw3SE42UWdZUWhLMkJudWFT?=
 =?utf-8?B?WFhNNFY3Rk9rRm5XUjFkM2R0WGxvUkgrWGd5eU9oNlhRVytZejhPRzFSOGRz?=
 =?utf-8?B?R3p1R1lDK1ZiZUZnTFk5cUw3ZGxabXYyUGFkT2VqaWJGVEJnM2hHeVdiTEM3?=
 =?utf-8?B?cmFuc291SVRaUUNDSEZJa3RtUmp1UWIwa3AzMnMxa05jeVVIeVlSb3U0TklD?=
 =?utf-8?B?Q0xHRjk0M0pUMll0SFdrYVRWMWo1MXV1dXl0UkREdENyVmI5MitpalFMdTdD?=
 =?utf-8?B?Z2JqRFg1Sk1EL3ZnTWluWnNxbFprTkxWd1pKTERXeTd6Sk1EdENTaDgzWGZY?=
 =?utf-8?B?akFLSzhjLzZ0bnorZ1E5bTlEYW5WSFhFbU1VRmt4V2xheTdQakpiRUlMQmc4?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20164db6-ca97-4913-3e91-08ddea926e3b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:34:39.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GI8sZbwZiDsGPkmcJL505ZvNmydSJ+wSRaw8ZvtNhzg05+dwxspPpYaBziBW/92LXY0xkZqbA0k9KgGNuVVIRc9YmGlNDfGlYJr/r+9L4bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> When "mbm_event" counter assignment mode is enabled, the architecture
> requires a counter ID to read the event data.
> 
> Introduce an is_mbm_cntr field in struct rmid_read to indicate whether
> counter assignment mode is in use.
> 
> Update the logic to call resctrl_arch_cntr_read() and
> resctrl_arch_reset_cntr() when the assignment mode is active. Report
> 'Unassigned' in case the user attempts to read an event without assigning
> a hardware counter.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

