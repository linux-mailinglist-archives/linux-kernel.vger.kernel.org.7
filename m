Return-Path: <linux-kernel+bounces-736231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C8FB09A49
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907023AD3A2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF81CEAB2;
	Fri, 18 Jul 2025 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnSQJ9Y9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C91C861E;
	Fri, 18 Jul 2025 03:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810708; cv=fail; b=LFB/OpuK8sZloPQADMklFP1AAU94yNoCOZKyQ9GB+aA8NCCrQmV6O4z9SvLCChY2GaNmx1/zyH/bEsqqZtXjkK340K3du8dJI39AOZms7+e2WDLbN+C6m4mTM31c1Y+lFNtW7MvXwdgGIyucqL4cBKxf5J8MIneggaXD7o5N00w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810708; c=relaxed/simple;
	bh=atdCEX/HScG6DUYBVBk4gm/WLSBJZQl08/McdmsI3tQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ah8fOj/6sEI1q/ERFR9RR9CvUEb3VBAnlp1EKJiT7ZWbrGewTKRTzXPxgrYgkCHLFzn3BpEE13u+u+OHc42TadJvpBQWjIuBbXUNYRM63te4YA9uTCGdxq+RTkokcHGPyQGzU+Q1GfjUL9B7qeYlzLhqUjWn5OvIlU1DqY+Ra5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnSQJ9Y9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752810707; x=1784346707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=atdCEX/HScG6DUYBVBk4gm/WLSBJZQl08/McdmsI3tQ=;
  b=YnSQJ9Y9ci4QL3lNEF4syhB3RcaLuLOLzOULv5FN2t9NvFt2CkWI1JPI
   ROzQ2KduqCYUOVfK1gBhFxHuiayEKin4va5TU+tOu83FUSCQw3PFLzkPn
   2ElQf7su3APHLrqv7o4g/CvL+C+H6ghLmoMYUK3tQCBK7zIatouU9C7xq
   72CWY5DH4lE7IA8YFQ1p+/4UWPgxtJ6ttgFPglVJad7imb3JX3eCp0LZI
   4xn23qzLvAqsnkmFMtuRrjLy5U7vx9s8+c6Oq+1rUpLHgT190hCWUFy8g
   cYK7QST1IhWfxnXmErpoLAAgG7TsjQkJYJtjjkE3bqsuphPVCuJ6kJugW
   Q==;
X-CSE-ConnectionGUID: gWRLTPA3ScWpF032N/8MoA==
X-CSE-MsgGUID: XPL97UPeSCaB8T8gXX127Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55185231"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="55185231"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:51:46 -0700
X-CSE-ConnectionGUID: 73ucAfecRGG+hMfERSCtxg==
X-CSE-MsgGUID: vOo4qqykT8eUFjAjBros1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="161983108"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:51:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:51:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:51:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:51:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDUEYR+m5luDGHotrbJ+L5iuaNuJDvzWP+qDKL31f/69HTEQ6Ts2K3Lt3Zid24qm0NY1lRVyTJtyfD9mHjRMbmy2Nj2ojvuEMHN8TPy5PQOn1sojGaGekd3bcC6RMHWyLH/5stS05rnJ1yZWM+06Bb28UG4/eOlk7a1ntgD21hhcZ0sHeIeh/Uz94jZq0HsaHBDlB8y1KVECOzUDBAcoAYzrpxezo+sGBbSRvPxAuUbERjAfd6HK/OUvuuasafw/aGqHs5nePxkOA6yc4exOXF31LnUZFe9bTE4a1lghKfVEOqQ1zY8UXYGmcwFB4IFnna/SumEG7yyo55Du+nyO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3LnhHHpOIo6al3PngDt46VuQUa+2B70t1ZJb3m7v4c=;
 b=p0wd2deCN/V6GK7Kp2cxhzvM5qgTH+j8mDAQDCt9mQqxtEBBOeXTMgaONERSaDaMEypcXjyWWZZ3LsENXYI9PP/OE+YzV9ZHccbqqXwh2uBK6NmsFTrIKoFTzCd0eKXz9WdSyViKex/N93C/yIFHNLbJFfY2oS2jl/IECXt+GlHSyJ3Ik4fM9q9elk1cTyp+fHY6s8x/6VMrqTRSEx7QogxHRO2f6Qzyd6hPun5I8gqyqV8BEiHTwI9ajAgf3a88Hnm9HhpzG1x/0cg2f8aC2MReNDqVnmsz3Q9t6tWvb+CXZX2HZNtEvfWNQgSenr1LDYy5MeUoUvJu27hDhrXPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 03:50:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:50:40 +0000
Message-ID: <bb3fd177-2d48-442d-94dd-636d06895973@intel.com>
Date: Thu, 17 Jul 2025 20:50:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 20/34] fs/resctrl: Introduce counter read, reset calls
 in mbm_event mode
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
 <abb2f418a54f46dc3e2a78716f5ab643e112ca67.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <abb2f418a54f46dc3e2a78716f5ab643e112ca67.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:303:dc::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d06bdb2-1bee-4a2f-35c5-08ddc5ae4331
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmZYam11OGFZMkl0ZFNlYk5xNTA4SlZOSWtkZ08yOGFOeUdXMi9Pd0p0Tjl4?=
 =?utf-8?B?RCtJUXI0Y3B3TmJ3NTZaUjl5VStWdm5EMzFHUWZrT1ROcUhTQThrVUlNKzNx?=
 =?utf-8?B?cTdwNXRRc0pNL0lFa3BwUGxWUTE5NFVtbUlXRktuSGRQRisxQy91Yk9DZ3dX?=
 =?utf-8?B?TWtrZWw3ME5yekhEQWQvV29PQkxPaC9rcjkzZHNldkJNLzZDUS9EUGMwRGpX?=
 =?utf-8?B?Rng5eGRFM0dLVG94YkZPUzRVYjRZQitKOFhTWHUweGlQd3RTMXVMYXpSYzFC?=
 =?utf-8?B?NkFPaWdnZUVDSTQ0dUtzaFlPQWwzWW5QZFhiNUJ4QVJsVzc2Qys5d2VrL0RO?=
 =?utf-8?B?c2ZIN1JYZlUwSnd1R3FIbHJOa0dWMlV6YWdRVndUS1ZRL2F6TDJHVHgwNk1k?=
 =?utf-8?B?aER5Yy9oa0czQ1lDWlZYZCtMenh3TjBPL1lFaXlkcEV1Z3Z2bWhBNlcvTE9a?=
 =?utf-8?B?cTB3b0NlekthQmFPajRuOTI2L280dFlnRjQxWUw3b3M1MWRHM2pEdkdHUU5y?=
 =?utf-8?B?eURFSW1PcGZjaWsrNWtvNlFMc2NBM2IrL1EvSExYaDNJRUlNQ2ZkeFZKRnRQ?=
 =?utf-8?B?UmZKbG53QzlnalZmcUI1bDBVbzh1QXYvZkJsTUgvNHU1N05pNXVKRnRKWHlE?=
 =?utf-8?B?aGJVajBXRWR6ZmdTL0hmd1pYeGM2SDBsMkRBc3dWZlR4aUF2V1orTTZEK0dG?=
 =?utf-8?B?QXFUZVpkY1NJZzMxUjR4RzNtbGt0aDhqMTQ2QmlDaG9yYXNISUVxdjZwVE9p?=
 =?utf-8?B?ZGFad3ZnR1FMMTI4b0g0WDVaQVRtcjc0KzIwREdLRlpYRHl5Y2t0a0x2TFdY?=
 =?utf-8?B?SmdoQUVmNzZxejFXamhEN3cxQTY1WkVZaExjZkpQb3ZJU0ZGdlBZZkZDS3NP?=
 =?utf-8?B?MnJNVlVDU1lXWjVteW02QmhFYldkdHJVRmlwazArdWRwdEMrcVc1Wm5NQ2RL?=
 =?utf-8?B?LzUwQW8yNis5QjJXeElMaXBDRWh3NjgzdHRabStTT2dkQm93aGJVTnd0K1NI?=
 =?utf-8?B?V05ZeHI2bG05ZGlxT2xWSnMrQnhURXphcXphMVE1Y2pZQ2FEWXFQQU9IRXNI?=
 =?utf-8?B?cFpvWUUzS1Vjdm1ZRWxrbHBFbzNtWkE5VkpERG9pb24rakM0bEhkcVgzVXo1?=
 =?utf-8?B?M3dIUW95bGluWE9sWjc4dERMY2RsaVNnU2ZNdkg2ZS9LYmVRS1Jpb29VRS95?=
 =?utf-8?B?eS9rZDIyR3pkNlNiMW9zbEZteFVXWFJadFhzNkdZUDNyaU95Yk5mUkRvT09H?=
 =?utf-8?B?SC9SQVNmRXg4VlJERWM3bzFPYXdpNzA0NDhvV0ErV0xxQ2JtWUtZZWcvTmJK?=
 =?utf-8?B?VDNkY2NyVG9tOHErVFNrUy9aS1ZYbkNOcHJCc1BlU25lZDh4UGFaMTJwTjcr?=
 =?utf-8?B?Q3dSdTBMQ3Z6UDNvNmlwVll6bEFhUnZFNlQ3RWdDQU9kcnBnbG5mRVh6aFpV?=
 =?utf-8?B?ZXQxYzY3blM5VWhIZ2N0Mi9vN2xVMHFTWTU3QW9saWwwdUJMa3BJaHFtNUJG?=
 =?utf-8?B?aUN4NFlrVERXdUdQOWhsaWpVc2hkVis3ODI5c082amJJUWtqTlBWTTluY2ZS?=
 =?utf-8?B?OWRlVjRaMFpOQjN4azJDZkNLc21PZ3R4RXV2UXEwRFdsNmZQMXQxSm9ibGs4?=
 =?utf-8?B?Z0pMaVo4Smh4TmZtV0JkbzVjSTNWQ3FqUk9wajNLdW4zVGthTDhtMFZzMU5h?=
 =?utf-8?B?SXg1Vng0ZEcvOTVoSlNHWkdnK3M0R3NBd1grbHBWa3lEVzlaNlJUNjJjOXpZ?=
 =?utf-8?B?SmVLMk1RN3l0dHB5bk5ZK0wyOXIrMUlaQ3FGN1FlREpHTnN6dVdiQmlqaGdl?=
 =?utf-8?B?NjNUNWVxUDFGN0VNQ1Z5L1F6L0hoRVlMMysxcUd4TDFXTXpmRnlaUVMxQjQ3?=
 =?utf-8?B?SVhjVWozeHYwd0ZJTnJCa1J4cXhZUXhNZFNZQS9mcVlIQ0RZbW45NS9PelhI?=
 =?utf-8?Q?65elkmwqnCM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXhtUklGVEpTM2d2R2I0cVBOOE1KZGFVcWRCMjloOWtaS3d4R0pBNHBxQTdE?=
 =?utf-8?B?cUkwWXhNd0VlZEp3TkFQZ1VHYXNWbGd4b0lhN1RMSlpURUpUUXhvNEUzNTVk?=
 =?utf-8?B?NlFaWG1SZEFUZHJIdUxZb1h2Y2ttNTl0ZGxBdFc3NkpUUFgrR2FCVGdMNUR5?=
 =?utf-8?B?dXNhWlQ4Q3VTREFJaTFsUUhJUHE0V043NVdBSGVZaHl4WGc0SDNCQnEvNjhH?=
 =?utf-8?B?Nm9qN0R6MXpWVXB5SXlmZC93NVQ5dE1nR2N4TVlJSDJqUDVEME10eThmL0hi?=
 =?utf-8?B?WUVVMmFoakRKOXk2L2VTcGROUEZCWGU4TStYR3Z6QjkwRGVVWGhlcFFiVDZS?=
 =?utf-8?B?bkMwV1R0RnVyUkJuWFZWbmlIV2dtRVVhYW1kUWI0NFpiNmJybStVZ1huUlpV?=
 =?utf-8?B?N0Rnam5xM3FBaGJNLzMrYjRkZmo4OGVtTnRYMzFYNHFGZU9aK04wUEhkNmdW?=
 =?utf-8?B?Y2JURlFnclczMGVLRHFvM2hjc1R0T0ZUVUdDY3REeTRhbWlNZUxqak9rdXFs?=
 =?utf-8?B?eGJCMjdNMWF6d1ZTTEpEMVNnbG1WTkxTU3pjNGNpeHpFS21OTHBRQzRjb1Qx?=
 =?utf-8?B?OFI0M2FHdTlHcmZtbGxjaGZvUklMcngwQW9ieWpIdlJSZUs2S2RpbytzbUU0?=
 =?utf-8?B?QmhDSGVyVGRTSGNDSmxJZGxWcEErNnd5K250bFZEZ3hwT1Rod0Npc2FHT1BU?=
 =?utf-8?B?eDMrRnBBTjVtMG9JRHpwQ3B0V3dCUWJqQWx6SnBoRk5sSEdjL1RhdHVCUmpv?=
 =?utf-8?B?MGFIRkhhWjlhWGovZ2VoY0VGYWpITlF6bFBOTFNSQjFPQ3c2VGtMTno5NFhM?=
 =?utf-8?B?Y0ZFbDlEcGdtQUhsdVhUamhQdVZyS0t2dmUyTEFmWGttMXlTMEF0RmVIZTFs?=
 =?utf-8?B?VnIyaXl5Tmt3YzRBQm82ci9xZEx1ZVJmTjM3Z1VTOUZHeWQrZDAvRkp0QzNU?=
 =?utf-8?B?ajJpVUxoT2lmNkZaSTgwTjJPaEVuUnhpNFVLTko0N1V1WVpEc3Y1Q1V4ak9G?=
 =?utf-8?B?Y21tS21EVGtYQ0k0TW9yWExWMWJpeEFkQWxpR1lVeWU3QjRWc0xQcEZNTEcx?=
 =?utf-8?B?WGJGbVhsTERRTWNWWWdhN3RXUm5sMGIyUUhxZWthN0JMT09XNlU4WFFEOFE3?=
 =?utf-8?B?RmpRV3drMkNIK1FWUmZWTVBvMUZ5V0RVazY5WmxmbytxOU1qdVNoQ2EvTFhZ?=
 =?utf-8?B?Z0hpcXY4MVlsdFdia2lxSEh1TUV6OFJMdW5sVisrTGFibTN0L01lSDAraWhn?=
 =?utf-8?B?a3BpRUdmT3Y4RzZyT3ZwUDYxdVUva1I4UmdrVVRMKzNUUFZ5aXRWcktkNW8r?=
 =?utf-8?B?ZStLd0g0Qzl6U1RnTytNMzJPc3VjNzkvM01oK3BMWG13ZHlHY3FZYUFOdllF?=
 =?utf-8?B?R0JFbHN6SUhLeW5xbElVazZPdHUzZ0ZmT3hEbENoRjk0eXM2UzRVUEduSmlO?=
 =?utf-8?B?aXc5MG8wSUNCQkR0RlNybTNycnRSakNsK3dwNUs0WDRSQVNtcWNHWUFPcExm?=
 =?utf-8?B?b0ZGZXFxbGlwNzVoWDBpcVZISnFvTUtacWNxeU1HYSs3WFp0VEpDTW9Oa3FW?=
 =?utf-8?B?RU52WE1TMDFZZUd2SGZvalpEVkpDSis0cFhDZ2NtVEsxdU9OTnhJcytZNTVV?=
 =?utf-8?B?Y1RlTlJSMENWZVhPeE5FRjQvdEhYN1NSMDNRUnRGd0s4VTBtbTlWZ0JuOU52?=
 =?utf-8?B?YzhLZjh2bmF3c3VMemJuT05uNjgvU1M1Z2w3QWlEWTQ4M2cvNXNWR1M3NEpZ?=
 =?utf-8?B?NGwvV2Eyb01VZnZDQ3lLSDY4aHdhdHkzUjRzSUdhOE95NUsrbVdSL1RmMjQ4?=
 =?utf-8?B?dUNrVWl6Q1Vibzh1ZjFjcTVzMm16c3RRTTE3Um5QWDE5djYwZzN5d3BsL0xF?=
 =?utf-8?B?WlFZdk56R20zREhQS0FjMW1RcTVSNERJa0V5aHdTb0VJWFdQNWdJYXE3dWRE?=
 =?utf-8?B?VUdSbGZ0TlV6MklpOEZZRDNvTnllQkpwYzFXTFF4STZQR2VGUHZSenlCRGsw?=
 =?utf-8?B?NjNiRFlRVVdqS08xVmpEZ1F1eTA4SjhhMHlkRVRoRDNsNDBsRkh1dm0wemxG?=
 =?utf-8?B?UVJESVVjRmpsdFFyOXZvYS92L0p5N2l5Z1BySUM2RTdhMmhlSXlBS3hVNjRv?=
 =?utf-8?B?VTBxZ2lIb0dSNVU0Sjl1Z2I1OEU4ZnRFYWZnRTNGZklWME1pWFVuWkhmUXFK?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d06bdb2-1bee-4a2f-35c5-08ddc5ae4331
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:50:40.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpt6qUS1PGQuDPq9qAz/tGEnnHbBTb0u6sybZN16Sff7jIEE3Soy9PGfQM5KWkNcnEgvEbTpioQIfJ+1gISpKDIwXIPndIHqkZqBygyXIW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> When supported, "mbm_event" counter assignment mode allows users to assign
> a hardware counter to an RMID, event pair and monitor the bandwidth usage
> as long as it is assigned. The hardware continues to track the assigned
> counter until it is explicitly unassigned by the user.
> 
> Introduce the architecture calls resctrl_arch_cntr_read() and
> resctrl_arch_reset_cntr() to read and reset event counters when "mbm_event"
> mode is supported.

A reader may wonder about the inconsistent verb placement so I would
suggest adding something like: "Function names are chosen to match
existing resctrl_arch_rmid_read() and resctrl_arch_reset_rmid()."

> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v15: New patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
>      with mbm_event mode.
>      https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
> ---
>  include/linux/resctrl.h | 50 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 50e38445183a..96679ad49d66 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -613,6 +613,56 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>  			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
>  			      u32 cntr_id, bool assign);
>  
> +/**
> + * resctrl_arch_cntr_read() - Read the eventid counter corresponding to rmid

rmid -> RMID (throughout)

> + *			      for this resource and domain.
> + * @r:			resource that the counter should be read from.
> + * @d:			domain that the counter should be read from.
> + * @closid:		closid that matches the rmid. Depending on the architecture, the

closid -> CLOSID (throughout)

> + *			counter may match traffic of both @closid and @rmid, or @rmid
> + *			only.
> + * @rmid:		rmid of the counter to read.
> + * @cntr_id:		The counter ID whose event data should be reset. Valid when

"should be reset" -> "should be read"?

> + *			"mbm_event" mode is enabled and @eventid is MBM event.
> + * @eventid:		eventid to read, e.g. L3 occupancy.

This is resctrl_arch_cntr_read() that explicitly reads a *counter* and
just the previous line mentions that @cntr_id is only valid when "mbm_event" mode is
enabled. How could it thus be possible for "L3 occupancy" to be an example of
an @eventid?

> + * @val:		result of the counter read in bytes.
> + * @arch_mon_ctx:	An architecture specific value from
> + *			resctrl_arch_mon_ctx_alloc(), for MPAM this identifies
> + *			the hardware monitor allocated for this read request.

This is confusing. @cntr_id is intended to identify a hardware counter that
is allocated to this event yet @arch_mon_ctx points to an allocated "hardware monitor"?
What is difference between a "hardware counter" and a "hardware monitor"?
The @arch_mon_ctx does not seem relevant to reading of the hardware counters managed
by this series? 

> + *
> + * Some architectures need to sleep when first programming some of the counters.
> + * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'

Again the example of cache occupancy counters for an API that is unique to MBM
events. Very confusing. 
Would any needed hardware programming not occur when the counter is allocated
and assigned? What does this "first programming some of the counters" refer to?

> + *  for a short period of time). Call from a non-migrateable process context on
> + * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
> + * schedule_work_on(). This function can be called with interrupts masked,
> + * e.g. using smp_call_function_any(), but may consistently return an error.
> + *
> + * Return:
> + * 0 on success, or -EIO, -EINVAL etc on error.
> + */
> +int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			   u32 closid, u32 rmid, int cntr_id,
> +			   enum resctrl_event_id eventid, u64 *val,
> +			   void *arch_mon_ctx);
> +
> +/**
> + * resctrl_arch_reset_cntr() - Reset any private state associated with counter id
> + *			       and eventid.
> + * @r:		The domain's resource.
> + * @d:		The rmid's domain.
> + * @closid:	closid that matches the rmid. Depending on the architecture, the
> + *		counter may match traffic of both @closid and @rmid, or @rmid only.
> + * @rmid:	The rmid whose counter values should be reset.
> + * @cntr_id:	The counter ID whose event data should be reset. Valid when
> + *		"mbm_event" mode is enabled and @eventid is MBM event.
> + * @eventid:	The eventid whose counter values should be reset.
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

This is new API to create MBM counters. Please use API that is appropriate for
this purpose. I do not see why it is necessary to copy the RMID read API.
What am I missing?

Reinette

