Return-Path: <linux-kernel+bounces-736230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED0FB09A48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D954E3A5F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BAB1D5147;
	Fri, 18 Jul 2025 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCg0gnSG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9682D613;
	Fri, 18 Jul 2025 03:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810697; cv=fail; b=dubrwend4cAXRn6XqHk2FOiZrrRIv1m3zmZ1fJ8siak0mDvaRsAhaxWFr9cf/8IQbzsL9eWXKYFe1EhKepgsAvGWu1sU7EGPhAPg2XaTjoeItfggd/Fin74k9IHAHChG3563Mm8B4IR+QdutXUyHJoCANP1aTjlm9UdP8c7/264=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810697; c=relaxed/simple;
	bh=a/5W0WYtKZFekqr2ZlLw60Yo3ZgOnDVLGTl3TIhfYcY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cEGMV+KBgFY1TNBVdTGVQZZ85Ntn2gAk29nnrIaYB6gXMX/l770Vl7k47c4NG7+v78nf0zozlIZYYRO5sIVp2eYsdDOvzs8q3uSkbvGamnnrmEV0vVwgXtBehwepu1IKvsmixGIQLVnj2Jyvy4j96LwrQjci2gZ9KN2VIYHz6NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCg0gnSG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752810696; x=1784346696;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a/5W0WYtKZFekqr2ZlLw60Yo3ZgOnDVLGTl3TIhfYcY=;
  b=WCg0gnSGDBi/BKDFTJric5USdOYZKg5L1JDNUvGqEKwIMZyTu2ifhWfe
   53XvlnLqn7NMGdW22R3McBFw3twEoqsuyzLb0zz0R17gjGJ1b1YZvzBDj
   O+bnfElnEZqtmLBJ3Z5FuJItXfHlEq5Y9fldEpyPJ8KO5fOXfC+p59gBB
   rUIW56UvU2i9SjpcqJqVKNVrfuREFwVd62h98nNbymoImQ6MychWVPxhk
   b61rcQzITetyV9quFAuQk6oQoyHzdRgv2bctKxRIRiUXWZstC+vx0ADqF
   +yzM2z/F43xUMcRCg+JSpubxbPqO0v7Mej88377/ZBwyYUVIZfGGpkNZe
   g==;
X-CSE-ConnectionGUID: SH/k2a4XSKaOk4wSWHVzLQ==
X-CSE-MsgGUID: rck9ySxnTn6hdKDBBu9cMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="58879719"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="58879719"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:51:30 -0700
X-CSE-ConnectionGUID: oNwpLDt+R4yEUSvZOeJrHA==
X-CSE-MsgGUID: 8MW0End3RbK4UawwBkvIKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="157348902"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:51:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:51:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:51:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.73)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:51:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHK5zpve++P+HE9lU4rRcXRSnDy3JJNqGN+JOK49MmfpMLoP4J0mUbO1e+yYXY10zf3Z0Xe+jz8RLZXIxYyvvHfuMi4B3DFICkANmLj9FSu9GXdl8WMln2ESJwCw56nvUIU1IJeYeNmjscUC5Mq9qi/RqfQbE1seu1gZZP349Fz4EjsRbeos5KxkJUziXvkWLrnUAwDVAru6DT71qOncoOomZriOk3kthbsfwIhpwAEdtCWkdqqDoynxoRORPcSEuNmqTRB8M1GaUJTzOwI3Pwrq/e9cjF3HgyCS4T3BHmrm9wgu4Sr+gBdfGh2jwBTnL45GourGX66UIMjUOr8a0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iycCBqyLf8A4p4caFeD8KjSdKclFSc6Rdo1haBtaIoc=;
 b=r+K2GvEc8PBfV6Y9ukgFCnfvEeuEiWsJ/mbUPlYOl6TNc6aCJdAwu5Xi8jQtKwXIOFYWs/j48XOr4E4QIy8xQAtbixNx0NZoJ2broDx76OJtD8KZJmyskgr6HdbKNFt5BgwCBFYcz2gKwjNOfBeZCsiSJ5jF3f30eF0z50BVjp2Oy+TVQjB8wQ8ohuJLA9GZhJiUs4Jn5VidS3awxhSrXpcB5ICB6UEZd3QYBb0uqZBzM8WL1X7I8hEnAqdyhUpma2BS6Rdh9D3zPzoxL++q99UiFj5rjOKSqk/EhgwhLHlDkyNEt8V+XDJSeQJ7HMhUsgL5vaQ+ISHYqO0jtkXzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 03:51:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:51:15 +0000
Message-ID: <d240b37c-e00e-4b6f-a0c2-267041aaf9de@intel.com>
Date: Thu, 17 Jul 2025 20:51:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 21/34] x86/resctrl: Refactor resctrl_arch_rmid_read()
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
 <7cab88ccc3e0e173271c9b12fce22785bbde9239.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <7cab88ccc3e0e173271c9b12fce22785bbde9239.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:303:dc::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: c41c6e67-ad21-410c-ec4b-08ddc5ae5854
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M25IcWtPZVowbG8yTWpqeGFMSmhRbDNvVGo1cDg0UlNVUWVvUzVMekYzZm9V?=
 =?utf-8?B?T0VrTzJMNE5YaERQL3RpNWwxZU80Q2ZMVG9SZkhhZFpvSVhrbUNEMHA4Tm1r?=
 =?utf-8?B?elpScVM2YkRxVTVPODdoR3h1NWRRdDU3ZVVETEJlZFVhbnpmVDVwTllqRTNt?=
 =?utf-8?B?K2F6WnVKVi9XQ1ZLZDJzUGVRb2NiUUEvRVA3eUlSaHRvVmZQSS9NVExoVm8y?=
 =?utf-8?B?R2ZKVUhndlVKTWg0OXp1RWZrWFpuUCsvVHZqdUNCaFB6RnRoSy8zclZ2Nklu?=
 =?utf-8?B?TkRPQ1NFMU9QZXVQeGVPTm8xc3BwZGZsNjBSU0dtU2tGOUcvOXk4bzAxbDhY?=
 =?utf-8?B?N2wyamFJNlRZdXN4cms2aFVQVzEybEtaS1pOK2hoVnFKd3MzTWZMV3A3NDI2?=
 =?utf-8?B?VEVoc2VNNFR6aDgxNUQ1S3pNTGFQVXl3YlJwbmk3K0VRMENNYVM5S1NUR29N?=
 =?utf-8?B?bktmYVlINFZ5SzU2eTNoelhCMm5RRkt1VVpUSFc4VmxFZzA0OW9YWGxLczRn?=
 =?utf-8?B?clU3aU1lZHNCM2U3TlFzQisxVTkxZWQvbXUvcGg3YWx4d1BmMTZ4UDdBWGpk?=
 =?utf-8?B?dTk5clNPcUtWd1NwdFg0RkwvZk5TdUFRNWZ3b1NUK1BJcUNvVDFlWWNiMnpt?=
 =?utf-8?B?czVMSzRYZDRZV2NiWFNiN1gyME12L3dqY2xFMnBrWTRHSjA2Sjk2TUw1VnlW?=
 =?utf-8?B?V3RCMmZjZ0VuWkNyK3NydTdoQkVrWStIZG5rNmYvSCt1cG9ZYmxuRGZibFpu?=
 =?utf-8?B?cExPQmxCMitFQ2dIVWp0cnJJZVZNYVFSRVl5Y1pwMzYzNlRLNWtRa1hoUldm?=
 =?utf-8?B?bGcyd1IrMTR3akRIZ3lvazVoS1V1YzdtMFE3YVIxTEFKSjM1WlhVMHlqN2R1?=
 =?utf-8?B?MEhGU09TMTM3V2dZYWIzYmdLbVVwcEJMS29sakwzNDZmbzNHWGhsRjMvRDMy?=
 =?utf-8?B?VXN0MTFTMVRsMWpmZUV4QzhXOTdiY3dIRXAvbEF0OE5ZUVpFLzhySFNheVV3?=
 =?utf-8?B?ZUxxb1FFejdLUVh5YXUzY3pNOGFvRGpTeGJ6aytDbUtQUFJVcndUTkpnZEVw?=
 =?utf-8?B?dDZuVU9aTDhHajhNMnpHSWdBWVlINkxhL2t0TXY3RTFaSHdUcUxnaU5sQjN2?=
 =?utf-8?B?cnZUSTl3dTZvUG9TY0xBQWlkYXpzTm93bHVFVklZZFEyOUR4eUZHVTVKSWF5?=
 =?utf-8?B?QXoyYmNNWDJMeVB5VlJqWDhiSWtONUFSQ3I5aFJNYTREQmFtenRWbmpYeiti?=
 =?utf-8?B?bmJ5NHo4SzlkUzY1SjVXeVRHY1ZoN2tyMHRMTFJvU2loblBLV09yQ1Z2SHdN?=
 =?utf-8?B?dmpPR1FqcldQS3g1OTYxcU9HVlk1Y3pTZ29JQXhsYU9rYTlIRDF2UnYwYXBU?=
 =?utf-8?B?Yy9mWjJ0TjE1cVVUTExGWjlENWkrR2hNZG41N1RFUmVWeHdKdHlscnhEY2Vn?=
 =?utf-8?B?QUc0R2RTSFlCWi92TExsSzMzL3JkYUoxSE9RakdsTFJRalBQbU1WZWcvNzYz?=
 =?utf-8?B?VTRkd3JXZkNoNzc4S0I2UkV1elk0SUE1bk5BL09BM01mMGRTU0M0cVFXck9r?=
 =?utf-8?B?c1JubkNyN29oMmxWNnU4UU5VQzRjemthemVocEowRmtTQnVsSTlLelQzdFhC?=
 =?utf-8?B?aWs4LzVVVHl4MU5vaVE3NmlNQnBtalRRa1ZlREVwZWpKajBzV3IwZE15ZTg3?=
 =?utf-8?B?MnZwL3lxaytJbDJzZ0krWllmSkFQdC9CdjZjSkgzTWgxMW5ZRDBIelRwY0wv?=
 =?utf-8?B?OXR6L21ka3BXNWU2M2RuR1ZWTW9WZE1JdHE5aTFaaExXVmt2U3lxUFQ2MW8y?=
 =?utf-8?B?cVJuRkk0aUZQelRXS1d6Z3ZTZzY0cEVFdlVNbUVtSDNwODlzTW5HRmIya0xo?=
 =?utf-8?B?Z205QWU1SWdaSUpYVC9LaW5GWm80aHQyYVVqa2VoRHN4Yk8xUS80bFZJSmhX?=
 =?utf-8?Q?fdNoHnygfoE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGc5c3NWZlVEUEd1UGNMcnNJZTY4SFV6MnNRNWlybVMwaWVBRG5pVE96Rzd6?=
 =?utf-8?B?YUtuSThyK0lsRkZyRGNaNkkyRlY4SGdHSGtBN09tMFdkR2ZTQzJ6blNpclJp?=
 =?utf-8?B?R2QrZ3l3Yk53SWFjbnROdG0vMHZFR2NLSEJLM3l0eU5aRWpSS0U3SURvUnBv?=
 =?utf-8?B?ZFdTVG56ZnNVNGpmek9wNU1BR2hsUUtBR05UbDNObVBGaWIwU1A2VHZybWJu?=
 =?utf-8?B?UzlXNjJ3a2cxWTg0Q25uL1pobjlIS1ViLy94Z1dHUDZWRFN1TVNTS1BIRmdN?=
 =?utf-8?B?STRzWk15ZmpmMnNUM3VuaU5LeFh3RTJDeHVsZ0FIUzRvYXJHUXhSTFU4N0NY?=
 =?utf-8?B?c0tMQTVRMnRvT0FxMFJtZUp1RnNESFFMaUNlR040NGRsN0FRM1JZRTRISWpn?=
 =?utf-8?B?QnlXSWlPWHR3eEt2dzRIc3gwVmpQcUhMRlFmTmkzYTFtSmpuRWFoSXkxYk43?=
 =?utf-8?B?akVwOEpiU0h2S0dyVG5GakdaU3Zlc2RBdGJveEE3cUdBUjJiM2RPQnlMb3lF?=
 =?utf-8?B?bFplRUlueVFQVmpqalp6NjYrc1VhYloraXZxQkFRNjM2UEl1Q0ZyK1NIVjBj?=
 =?utf-8?B?Sy9KM1VxWk9GVTQwUUozYWlsbW44NWdzeXZIMWRFLzloQ3RDSkQzZm1xYzBl?=
 =?utf-8?B?N1hOV0crbDVIS2RzL2xYSFgzeGZQbGhwcERzaVVRaVk2Tm5tcDNTSm9QL3JI?=
 =?utf-8?B?Q2FadS9uZWduZXBEVWdyQkp1Zk9NZVlpZzE0MFJtanVocThGWUZTM3A0ckhy?=
 =?utf-8?B?V3IzYlozMmlrV3ZhME9tYzJSUXo5TDR4L2dPL3o2SWZ1Ym1pQ3NGVGZiOTVh?=
 =?utf-8?B?U1lIYmg2WVk3ZW4wTDdFdEJUVVNSZnRrRzhnQTA5K1lhMzhhbGFmdmNneW1Q?=
 =?utf-8?B?MHJCQ2YrQW1HK1NuV1hrV0lJSExPblNkTnVIRDRISXUyVXQ0QVdqOGkwSUhm?=
 =?utf-8?B?M1ZjN1BteE5KaUZ2dyt4UENuVURRS3QwaGFrS2dFNU1qekoxZjRnTXJwY3Fj?=
 =?utf-8?B?VTFBdU51ZHJYckp1Y1h1YjZTTUN1ZG5CYklBYWcvQUwzdTBpWENhdk4zcGN3?=
 =?utf-8?B?dVk3bWpEZSthQUM3UlBMc1VnUG9ISW9WK1BqaGorL1JiWXRaQjBoclh4NGZi?=
 =?utf-8?B?L09tbGNVMUR6ZkRhREc0Ny9zMVdWUi9DOVp1MEV4YkM1RkJIK0o0YmF2TkdM?=
 =?utf-8?B?YnVCWjkvT2J2eHlabFF1K3B2dWpMZkZZL3hCcVdRMVlSMzRSMXhrZVlvWHE3?=
 =?utf-8?B?eHN2QS9rTzlSSlNzSlNQZVhUVGpFaWVwNEZTNkJISWg1WHNLSFB3UmwxanVi?=
 =?utf-8?B?QVBjL1RxT0kwVVBwSlV0OWVyZEN1L1dObFU0eS9sSFRMY3RGUzBYY2J0UzI4?=
 =?utf-8?B?MHdyUS84K3RCa0NPZlkxNTNjRlJMbHVkUlRSaFdZTW1qUjdpc3lXaDFnN0lo?=
 =?utf-8?B?aFptcDV2bUkyRXFlNkt2ejBZRjJiVzhoU1k4MVZHeTVoVXBMamVBS3ZnM2J2?=
 =?utf-8?B?QU5MbFRBMEovU0NYblVsdm5lU211V1E4MXZ0OHdsS3RKVjdOWEZRQVNDTzdz?=
 =?utf-8?B?L24yQnRiVnpvaHFOR3FYMjhWQzRJdXhQQjI1SUR5b05YbW1zTkZ3dW5scThy?=
 =?utf-8?B?MVN2Nk1XVFU1VXBKN3BQOXkyaUp5R3hFc3FGTTgvaUdVM3JrdGtGVndscGN2?=
 =?utf-8?B?WHprMXNzbDI2Qk1OYmkwbDhscVB6MS9LZXl4WGVrbDJkcVI3T1FWV3M5WFpB?=
 =?utf-8?B?RTVjZ216NHhLdG0wSkVmWjZNWTg0UTg5eit1UHdFOTFSUDIxZTlJajZLQW40?=
 =?utf-8?B?c0tIaVgrb0VGT2FHSWpTN1Npb2ZCWndXQnRVei9wYVB5eEMycGVPUE5qci9H?=
 =?utf-8?B?LzZ0V1RMUjZlRk9JbjZCT3JMTXBnTUl3eTBWa2FwV3h6VVdzUHhEbDJlVWRv?=
 =?utf-8?B?NmZSb0VHVGRFNlJsT1o1T3lkM2swUExzalM3cUc4dERsRXhHRHNIV0J5b2s2?=
 =?utf-8?B?R1YvSUNHYVdNRXh6eUJ4aUpvTS9ud0pEYlo2aGx5VVRTVjRaSVVtbnhZa0do?=
 =?utf-8?B?MnhHQ2w0TENHeXc0UnFMcVFCTzVpN0o1dWxiRjF6SHVQb210dEE2dUxKWjla?=
 =?utf-8?B?NlkrY3hNZlRvNUNTREwzWmsvcmFIZ1ZIaDBJMUhlQzg1ZHgwQmprd2Z6Zm8w?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c41c6e67-ad21-410c-ec4b-08ddc5ae5854
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:51:15.4840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gU9KDxLYY2ChU1Xt0JXORsfCgvnKkrKcCZDVQ6gUvvp1BmvzX7sjBjl4kW4xFt7Svr7vj/WNbENFUWVQMKnVMQxY+Y3UFQudDrzUxJp3eOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> resctrl_arch_rmid_read() modifies the value obtained from MSR_IA32_QM_CTR
> to account for overflow. This adjustment is common to both

The portion factored out does not just handle MBM overflow counts but also
handles counter scaling for *all* events, including cache occupancy.

> resctrl_arch_rmid_read() and resctrl_arch_cntr_read().
> 
> To prepare for the implementation of resctrl_arch_cntr_read(), refactor
> this logic into a new function called mbm_corrected_val().

This thus cannot be made specific to MBM. More accurate may be
get_corrected_val().

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v15: New patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
>      with mbm_event mode.
>      https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 38 ++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 017f3b8e28f9..a230d98e9d73 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -217,15 +217,33 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>  	return chunks >> shift;
>  }
>  
> +static u64 mbm_corrected_val(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			     u32 rmid, enum resctrl_event_id eventid, u64 msr_val)
> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	struct arch_mbm_state *am;
> +	u64 chunks;
> +
> +	am = get_arch_mbm_state(hw_dom, rmid, eventid);
> +	if (am) {

These are MBM counter adjustments.

> +		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
> +				hw_res->mbm_width);

Above can be aligned to open parentheses.

> +		chunks = get_corrected_mbm_count(rmid, am->chunks);
> +		am->prev_msr = msr_val;
> +	} else {

Cache occupancy handled here.

> +		chunks = msr_val;
> +	}
> +
Both MBM and cache occupancy scaled below:
> +	return chunks * hw_res->mon_scale;
> +}
> +
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>  			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
>  			   u64 *val, void *ignored)
>  {
> -	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> -	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	int cpu = cpumask_any(&d->hdr.cpu_mask);
> -	struct arch_mbm_state *am;
> -	u64 msr_val, chunks;
> +	u64 msr_val;
>  	u32 prmid;
>  	int ret;
>  
> @@ -236,17 +254,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>  	if (ret)
>  		return ret;
>  
> -	am = get_arch_mbm_state(hw_dom, rmid, eventid);
> -	if (am) {
> -		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
> -						 hw_res->mbm_width);
> -		chunks = get_corrected_mbm_count(rmid, am->chunks);
> -		am->prev_msr = msr_val;
> -	} else {
> -		chunks = msr_val;
> -	}
> -
> -	*val = chunks * hw_res->mon_scale;
> +	*val = mbm_corrected_val(r, d, rmid, eventid, msr_val);
>  
>  	return 0;
>  }

Reinette

