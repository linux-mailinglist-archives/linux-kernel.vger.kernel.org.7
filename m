Return-Path: <linux-kernel+bounces-751267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ECCB16716
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016967A648C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C15D1F4180;
	Wed, 30 Jul 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHwPtzXC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9D42AA4;
	Wed, 30 Jul 2025 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905009; cv=fail; b=WdyPOW4230GEge+UDPG8f7zPXAsSadOm0FZEWW2hyoee6cR4wKWVd5IipUqiH9sid3DTa+1h1M/qdvZYkIRvNKoxomjrUyI3WuHjs1i4CA1JPstZM/j1HsCIodXUaFINQyr7etcH+73xLtjIazpbo8rZGDlANTnB68IhCvLnUA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905009; c=relaxed/simple;
	bh=aDf953LlvkabNhsfhUMaflMLMJNmsesO/SHKgnAVXm4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B3LjB67HE9qv/Q0Hmgn3nwV6bPXXSrTRMLNbTVi2y1KIGop7pFYi5yuhROrcLQiekWozArvafctuWYxunjDkYKa9B7qapqtWd0EhJZbeuTyFawklZ9AEm9+1DDk8CkSkw8enoxv8spEBcsidGhpL21zdfSHgkT4PTKwwXr2h/nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHwPtzXC; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905008; x=1785441008;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aDf953LlvkabNhsfhUMaflMLMJNmsesO/SHKgnAVXm4=;
  b=KHwPtzXCFylRw1+ZNsGJh3ITYqYShCTTXSnZKIh2+9CpAa8IjVQCXyAA
   2D7WEBbkMg9yGlaY1sj8a7asF9hrQm2E4Lf01ogaUqxI+eGwiJyEr4aGV
   JI+7hlLR3qrKL2Ifg6ccCil+Ku/IHC3hLBIY/l/0KNLOF+femqAtJ+RRL
   hsc9DgnGmSgLQt2ZwICvMwkz3w31qWUxW7+6C8l5AUjliuaIicWF2BaeS
   pOXTYh+pzk4zWzsN02TxLWhbcJNgpiGm1DPrnY6fvapMIu5DmVb6Q6Dnh
   FEVKxkJVDFdmY2DlDPGMBXhHb7/y+nhvQG64RC4L1q4F4/OVGUxeM2QyP
   w==;
X-CSE-ConnectionGUID: ZWhk+WTlR4CFG2ocvihgpg==
X-CSE-MsgGUID: P71WqEnwSt+oL8NppJsiZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="66914554"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="66914554"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:50:06 -0700
X-CSE-ConnectionGUID: vTCxIVmeQ3CYw5ZULBKdsw==
X-CSE-MsgGUID: v6RHxXyGR0m235Xjk8R1Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162658759"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:50:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:50:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 12:50:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:50:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrbIQZdfnKF7VIA8VVoD4Yilztrwtby/NdJuF6vpywu0YWRlCMkAkOPkkILOdfrXSG8VzLxIUbG+mjBbTNW7bKxAULo+I8NLN+nsXHNma1FxtNKXZGHQf4kKVWbExOD5E9uBn52tMl0CqyhwpF2IHA4lRle20xZH9CQdnPLCB4h8DGO4N3QsodflqBLSwaRJMYuCZ3zzS13ovu8VCxQxWji+ldbZRb45xbQSfOY78OAH2xg7NLaGoGJxrF7Pn+R/nU8fcF8Rw89q73tp8et85ojlL/V/Jw5UelbF8dbQo39DwympP/fFytgh9KaXDVyCxqHRRn3apuSNvsv8L+RpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kq4V7Cdx8dudZUA3UkHo2lk/UsehmDijb0BaJdwpGk=;
 b=gVzYyfPojkcue8FcqUrCtnVyniah9sva7PAvn+itliNkqzB90rV+TCWQAJ8lnCumxunFUa522nRScO371BYoCrKPR7aqCGlipsEOfbgoPX19vscXMXfNplITKOuAlBnyYpS7LN0ozZIguLN0jqcFH7spX/4NN/KZsIpZQKYAaW1MH2iMYXarb6P5DYkqmvGrj2XZj10rOVdyhyAlSn7mrk+hwfUTxnAtdWLlkYQ8/jHDPh20K/Ho0ljxMhFt0JJVCrJOQpBy43zfvb93pKv1IIDpHH3awYQCoUJ/5Qs74IRANJGo/myEgJDDmRKREXJuA83iD7m58TaNAdJm70gpIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:50:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 19:50:00 +0000
Message-ID: <aed0a452-9b16-46ca-8075-7be9eaa0cfd1@intel.com>
Date: Wed, 30 Jul 2025 12:49:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 08/34] x86,fs/resctrl: Detect Assignable Bandwidth
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <bb06941505a33df996fe0e8d997c2eb2c4f4b379.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <bb06941505a33df996fe0e8d997c2eb2c4f4b379.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:303:b6::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c1042c-9330-42a1-4415-08ddcfa24499
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3ZEbjlnRHZQd3ZGdjNzZlY3aTFSMVBNMk9DU2hmVEI2VGsvM0lGbGVLdUkx?=
 =?utf-8?B?TmZQc1k5RC9KOXNOcERsTWd3cS9iY0RPVXliSlpQZS9INDN3NUlBbDVzOGlF?=
 =?utf-8?B?a1BOSDdscDd3RWZvcjFwcnd4NkFBWlhDdnkrdWxZdCtQNUxzSVR2UGxUZ2Jj?=
 =?utf-8?B?WjIyNnJpc3ZxN05hQ3VXVzNQdGw5bDdqRU9FOWd4QWxqVXB0OXFGb1doOXJo?=
 =?utf-8?B?RjNGRUFIeVIwQ2k4TitMNm0yT2lvNzREQ0p4c09JdUJBK3YwblJ5bWFSK3M1?=
 =?utf-8?B?Zk1nNzlhK1VvM2hWWUgrWkJqU2VPNjJ2elpBQlMwSFdGZ1h3SzQ0eXlVcTdu?=
 =?utf-8?B?aUNuQnpoUVhqNTZNSWttQnFNN2ZocE9mOHNXdG5nM2JjRkRsWnIybWZTMmYw?=
 =?utf-8?B?T211dUdXQjVRd2dTOElodHBxL2xIb3cyWDBlZ0IyYWhvTGdsRjRTMkVSQmNk?=
 =?utf-8?B?cFFPVTZLSFlsYStEU05NSDlocHRGTDFIaHI4MDByWCtjcUNZMlpRaW9LVjBw?=
 =?utf-8?B?RVBJN1lWbm5pV3dKSThMMEhFazY4dVVPSDF3Qnl0KzI5dzU2YWF5L1UxbkFr?=
 =?utf-8?B?VEZYUnpCdC8vUS9ELzBndTNGTjlVWTVPTlphM2sxYnAyOXNJQVUzamZWbW9E?=
 =?utf-8?B?UGxMVnQ2cUVReVNxTzRsQXB1ME9EUU1GUU5odGpnWngvb2d1aEtQSUlYRnlO?=
 =?utf-8?B?K2lmNnl3RXNvbXUwbFB5U1Rzd2NTZ2tLR0RkMEkwK1VPeUl6d2NQWGdFdm91?=
 =?utf-8?B?b0c0dG5iTUdBWFdCeDNxbzFvMDR0dUwrSHV0WDR4NjAzcW1TNC96OWtwS2FQ?=
 =?utf-8?B?Q1lRa2pZcnNVcnNkUEVQOTRHS1crMy9kQTlnUXhxVlhuOTFCN1BXNXdQbTg1?=
 =?utf-8?B?UGYzcUhtQ214WTY0NU1tYmJiaVkzaWZzdDZIQkVLSHZ3NkZIamlCTUhtZ29G?=
 =?utf-8?B?R3V5TEpVUklpUHJLQ3Y2OVBqL2V1dXFrQkNGZlNXRUIxZVp3bEVFaU5wRktY?=
 =?utf-8?B?Q0dXSm45ZGZBMVZVVi93NzI2SjlUZGV2L1VySng4UFNGVGJMZlVtNnJzNHlv?=
 =?utf-8?B?dzlqMG40OFB6MHZzRUQwREZ4MGdVNGNRVVZoZTFJcmM4UnRPTk12ajV6RzZs?=
 =?utf-8?B?VDg2cFFVOG8yc3ZEVC9ka2FzQUVqN09acm5OcVVRKzAwOGtTQjZmTFVMa1NJ?=
 =?utf-8?B?N2RBSHBDTllqM2pFZm1DUUVjQkllQTE2SHNDVUVGa3dmVllmaVFrdERyekwv?=
 =?utf-8?B?dFNPY1BNb2M2WTBDbDF5MXBMZDlJTnNXNzg2UU5XbC93WmtpYmE5TFpFbTZn?=
 =?utf-8?B?ZTlOVEZQaDB1b2tQM2Y0K1ZJc0hZcXZFTTNyWE5YS2l1NHZGTkd6My9oTmti?=
 =?utf-8?B?aWtRS1JyNWM5TWc1NGhvdW9zRUpJNENZcmlSeFpPSnEvTVQ4YUFrb25uSGIw?=
 =?utf-8?B?SDBlekp5MXU4bFVDM09qYW1LVno3RklDRTh1Nkc2a1BJRE85UlZqaFh1OWtT?=
 =?utf-8?B?QjFjQWg0eHh2YlREVkZXY1E1ZUVQSHdUaDhpbmhmY2JrVU8wdWpNTC85Qlpn?=
 =?utf-8?B?Y0grS2lXVFdjWGF5TE5rOW1VYXRKVWxTeVBxQUx1eUdqYmhZYi9OYW5waG8r?=
 =?utf-8?B?b0owRG5LUUNUTjBOeiszdVZlNW9Rc0FkU1hzdUlXdVFGeXdXL210VDJQeWRt?=
 =?utf-8?B?MVlRdWZ5a1lwbEhRRGtXSTlML1QvNndvSkFEclJOdkNQWnE0aDBmRVBXdjkx?=
 =?utf-8?B?L1psWEJ1MjV0Z0dJbEVienRKZklCdkRTcmVUTHdseEUyczhNcUczejlBblpv?=
 =?utf-8?B?U1RLK3NtanNxcDNyVjF4cmR3aGtwUlRIWS9wYWMzdU5Xd1QwNnFYVVdMS3Nq?=
 =?utf-8?B?TVZNenlaVmVJcDB1NFJTVldraU1sM3UrUFdqRU9sOUxFUzYxUlhNNzNDaExC?=
 =?utf-8?Q?d5k6nYsanfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBCWDlIZEpBVU5ZM21YM25PRmRIVWtiSzh6TlNYSVlFSnRGcC9BNVBFQW5B?=
 =?utf-8?B?YXpWdUIrQmVMRHNWMXJUV0JyUHFZV09rem9SRDBiZDNQR2xMTDNIdzFLcjRw?=
 =?utf-8?B?VC94dk1FdzhyQ1FKaG05MGdkWUVtR3ZGMlRjN2dUZUs5Q0ZVd2IxVmhaRStY?=
 =?utf-8?B?aURoWTVGYTdtOGtFcGR6dU1YT3ZVT0czRFhxQVhHWjJ4TkFtYnYyUTJwcCt2?=
 =?utf-8?B?Sm4yL1NpUzcvMG1vclJ6ZUJJUlY3V3JOTmlJcmhHNlVUNVRNYU50N2pNV08w?=
 =?utf-8?B?NWd5c1ZQVkE5RFpPUGFMdy94UThjNmZLb1IxUHNEbFZPMnpaZlloVUM2eUFu?=
 =?utf-8?B?Vys0aC9yQkcrdlJFa203ZjR5Y2VqdW5RWWlRQU9uRHEvdHdENVFhaEd6Tzg0?=
 =?utf-8?B?YXlWR01ld2hrRksxOXIvdm1MblFsOVFSL0sreGZjdlFiVGRIVEJwVDIwaVEv?=
 =?utf-8?B?SmJzeVdNZ215YUhvK2NqMSt6WDBCT1ZGMytTbWkrUGJ3dUVWQytnL00wbklh?=
 =?utf-8?B?NEdaSjYzcTZXNzhKeU9Bem9hdmdaN3lzSTJiWHEvV1gvdWF0Nk40NFVEeE9S?=
 =?utf-8?B?K2dqbWZpV2RMZXBZMFNtQ2JNYjlhdnlnUzRpTlBDYjVVbWxaeVFVSklMT053?=
 =?utf-8?B?OXE3R0g0RG1ueXg4MEpqOEtLVEV6SEw3L0pZb2VhYmlBVUdMMlE2aFZZMDBT?=
 =?utf-8?B?UkgweHhLdmRIaUdXc3J4aXlVb0VURXRTQmU1eFZuTHNZYkVVekU2VkRVVldj?=
 =?utf-8?B?NVlJcEFHcXhOcnBQMmUvekVDeE1xR1RtbmV2QnA3SEVXaGZYM014cmhCWVJI?=
 =?utf-8?B?ZXp4eUxSMDF6NTFiOEN2bEkzN2xJb3ZvRHAxSWVlb3E0MEc4Q0txMWRZRjdy?=
 =?utf-8?B?UlVva0xzb3ZvS1g5Tk9oMnU1SDlqRnhnUHluK3dhM1FRR2UrMkZZb29hODkx?=
 =?utf-8?B?UERFdms0U3owc25mRTVISEJEeWZUSHpRV3JHcGZXS2pCSG1uc0FKS3FEOE00?=
 =?utf-8?B?cy9mZXFMSDBpTS9nMmNPV3BOb3ZrU2g1em1QNXVPQitkYUNjUFZtK29Fb2Nk?=
 =?utf-8?B?ZkUybzF0RU9qKzZBYjNvWFpSNlI5Q1JheTVRaUpoVVV3b0tCVkFZb1h6WGtj?=
 =?utf-8?B?eE9KVGQ5UUFZbThLWnVzUUlEYWRhY3JBMys3NVNwOEhxSnJFbWw3bitYZmo4?=
 =?utf-8?B?SldmR1g2M0hocUZuVU1XVkJiaEtGUVkwREIxbFV6MVNRVXJIMjZjTm5WKy9X?=
 =?utf-8?B?SXJGSm1WeW10c0pJREhZOU9TanlkaEY3OGFrL3FVVGRHUHpSVlNFM0hvcHh3?=
 =?utf-8?B?MnNIK0lWUFhCa1B1NFd4NkVzZnNjYjJ6b2tnUWg3S1EvZXlZN254aDcxM2hR?=
 =?utf-8?B?ajR0bFBKb2JZUTFpemVsNDBTTXBKRmVEU1dTMmdxTHEwcjhvQWJwUzVvL3E0?=
 =?utf-8?B?T1NFN040Z3E5c3JrbGhCMUdVcUxnYzdUVDU5MkxFY1NweFluQ1BlR1czVzJB?=
 =?utf-8?B?MElMY3RPdTVycWMwUDc2UWdTUTFXMjd6WmtSd0RLYklCd0hBK05TazY2V0wx?=
 =?utf-8?B?ZFhEblBmZnliVlJ6bjRRRURnaTdZYzJERjJSYUdWeGF4cnRIalhKbXRXbDZa?=
 =?utf-8?B?WTdkcGNiUmdLV2ZwNldXaGd5b29CRSt2YysvZU1CTnEwT2ZYV2NWS3NXTlhH?=
 =?utf-8?B?Uk1qRjlMMWtHMXk3TVV2VUlCYWZhUXI4MXhCU1oraTJPNWVrQkVZaGh6bVRZ?=
 =?utf-8?B?b3V1Wk1BbEVDTjRFaVNYZVZWbHd4SldYbStheHQ4WE0xOVA2T3lnTWU1L2c4?=
 =?utf-8?B?eVo3Z1JaOGt5Vm02UDhHdldoUFlqV01LRGhRWlF1d05ST2R5MUw4WHNBNFcz?=
 =?utf-8?B?NFhRakFBUHlkbFVzeldhbGQ2Z3ZMcytnTFM1Y2xjQVJMcmU1MitiLytudGQy?=
 =?utf-8?B?UldqMXpDVXVHRFFwcEpEbnc4L3Rzalo4YkljMmZwenMzUDFOblEzTXpRUWpP?=
 =?utf-8?B?MFlYcGxhN1c4THJ5V0RXVmRVVlAzcGtxWm4xM1g5ZnpUVEhZbUsyMitvK3lt?=
 =?utf-8?B?YmdXa2NxQjQ4S3NxS2ZDWmJibnNpQUlBTWV3ZjhaanV4RUoySUx6UGdHaFNq?=
 =?utf-8?B?MGRsaEF1MFd4NGZaNW9uZmVvditqU0h3M3VMbjNNTkVidk5MREdFYU8ybW9X?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c1042c-9330-42a1-4415-08ddcfa24499
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:50:00.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZYAyy6gj3dKGjfMr2889axjG7SfRAjWAoY2Dd5gq1W0VlrafY8qwYiy31eWDyFlyEppXtsAnE/X9cvuxzEWqOrCZc1LCcksFqbYRWXKf2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6422
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
> Bits Description
> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>      Monitoring Counter ID + 1
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Detect the feature and number of assignable counters supported. For
> backward compatibility, upon detecting the assignable counter feature,
> enable the mbm_total_bytes and mbm_local_bytes events that users are
> familiar with as part of original L3 MBM support.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 267e9206a999..09cb5a70b1cb 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -883,6 +883,8 @@ static __init bool get_rdt_mon_resources(void)
>  		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
>  		ret = true;
>  	}
> +	if (rdt_cpu_has(X86_FEATURE_ABMC))
> +		ret = true;
>  
>  	if (!ret)
>  		return false;
> @@ -990,7 +992,8 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>  

To complement the change below, shouldn't the snippet that precedes it look like:
	if (!cpu_has(c, X86_FEATURE_CQM_LLC) && !cpu_has(c, X86_FEATURE_ABMC)) {
		...
		return;
	}

>  	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
>  	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
> -	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
> +	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL) ||
> +	    cpu_has(c, X86_FEATURE_ABMC)) {
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

I interpret this mbm_cfg_mask initialization that an ABMC system will report which of
the memory transactions can be monitored. 
In patch #15 "fs/resctrl: Introduce event configuration field in struct mon_evt"
the event configurations of memory transactions that should be monitored are hardcoded
as below without taking into account what the system supports:

	resctrl_mon_resource_init() {
		...
		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = MAX_EVT_CONFIG_BITS;
		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM |
								   READS_TO_LOCAL_S_MEM |
								   NON_TEMP_WRITE_TO_LOCAL_MEM;
		...
	}

It may thus be that a system may not support all memory transactions it is configured to
monitor. It seems to me that the initialization done in resctrl_mon_resource_init() needs
to take r->mon.mbm_cfg_mask (what the system supports) into account? If so, then
the same hardcoding done by patch #32 in resctrl_mbm_assign_mode_write() should
also be changed.
	
Reinette


