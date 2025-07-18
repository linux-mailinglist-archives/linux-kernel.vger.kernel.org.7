Return-Path: <linux-kernel+bounces-736227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F4DB09A43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61BFA60C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207A01C8632;
	Fri, 18 Jul 2025 03:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXsLb2M5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B082D613;
	Fri, 18 Jul 2025 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810531; cv=fail; b=qgAczEA2aY+wRUe72FL2i/Bbf7W3dFlhOosfS/kXZcsBgLTfS9OolVW1IqEmoaWMaAfOPEOwc8FT3ACVGqtC53ULvQA3f54x1V/t4pcEPYzfGVso1k0xGbJaq3SZs9lNaQbRX/KNHNVUHDHuOGkhRfaEhd4oPoVlUTsF4+7LUI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810531; c=relaxed/simple;
	bh=HiqQvHeccdnp7QSNVqdQT3i+9c0QxGF9FSChBgBDYU4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RGI9XdYjLxlxtRhE6uFzIRC1FF1i+f+QuJhcOjMebvAI/jrLtq/G9QoOficRrH6f2CWXnwgFrAvEBThexQS5RC3Brw8Ftj28UUwsSu70wy65OxLeWsggbV6PfaXbL5TXI7CpQDVElGSH8FGdF4jW8/MjM7StLhbJJfbu6+5MOPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXsLb2M5; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752810529; x=1784346529;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HiqQvHeccdnp7QSNVqdQT3i+9c0QxGF9FSChBgBDYU4=;
  b=UXsLb2M56SuTpioE84JVDZclMkDqgCz6beX2kWUtVubfZPQz+zptgQSj
   iGQurR1by/4bq3wyLmS04jBM+a6M8fpTHMJ4x65nffjGWDZnCMt+Wc+yB
   ZgauNEXGGp20Ba0D7c/u8+ZsX9dnG9CZ9/mBCFq5+Xu253DKtSD+A9zC6
   9vBun9fa1ChLV7TGfJl/P9AZZWJiTdDPVdjJkRq2PJmlVep9XRhsnNW6G
   2PbuYVf6MmS1pLbNN1qKRCZJHJR83NiOdhQ1FbyTyT8wzi4HAk4wlkWfl
   mASL9wbYp6pbE/OLI0G+9skCf+lJyS8lLAir0evBwzw90zM0GH3XL1RaJ
   g==;
X-CSE-ConnectionGUID: Tv8ptWWvQB+t6Q6eGkQsoA==
X-CSE-MsgGUID: 1L2Og789Shunf6SV3ibZFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="65357190"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="65357190"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:48:48 -0700
X-CSE-ConnectionGUID: /GVud1X6SU+ovLS+WSF9Cg==
X-CSE-MsgGUID: ssy2mq68TDu0nxGe5ae+Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="158076382"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:48:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:48:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:48:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:48:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8VjsK6Ea0W9mdLU2JOI1ckNJS7F/qbYFrmeLMRq9MhK+1p80GhsXH8WoJseKVoEUGw06KBrYf6wcHV85+cc3ozjvzfF6i7RE9c+n9PUuxDj5SJVYKVUNam+IsOrpeaIAryr2+jpiVKwqvyeYp3oiStDf/Mq1bbEYiBqiFtGp2UZJiwagW4cVxq07NII/KioINsNdIrmn1qAjibK8vh7/YUFbyiLZieAezj+SgHVOHlRI1JXpJwC7vUMeZZW+stYExyRHac3TkPjOabVO9qYbt3Fooq9sUDbYrADge19lyaZ/5l3mQoRs/9rJH1QJERk/Dcn8kflEouUGAKBnLKFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI5z0gpqZi3FeV2F96JTR8HchTGak1l7cG3vls31wWk=;
 b=JZjxw3oJ5ffHo6W4IKoX0YJ7aQNozC6kTCZC2ZjZSgBeS23W4hTWyNwJRhrqr7xLUjxuwq94Ly+/dlZGxvAHmatxT/aPTyUeoRR1eOU1DFtzpJ4Bb0Sxv5WJevzylO4Ot9HRnq4o7Yyw9HFZKVZTGKmVYOtq0D0oBlFY3HpUMqrkXHIGmu6ccvflwUWR0bLcE5Ua5YZ9WFWhGJqH7MgbPz5rA32mIHaPoS/N0oELiyZ8jxGcT0GAdO03MpppjDWxcQV8i1EcoF3DgzLV7lsdyTfKQFNSlRZkLlkTB2TBdkzP056MdZ+1vj5n8FeNlHNTqh7lU5dPDpCmrsXkR9XXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 03:48:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:48:35 +0000
Message-ID: <0689794b-994e-4644-a47f-595a3297a057@intel.com>
Date: Thu, 17 Jul 2025 20:48:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 18/34] fs/resctrl: Add the functionality to unassign
 MBM events
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
 <ef1e3ce931bbbf5ebbf4d3e745c0e260117375e5.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ef1e3ce931bbbf5ebbf4d3e745c0e260117375e5.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b864e1-2418-432c-ed60-08ddc5adf926
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUcxNTdhWUtXK3JqeGlQdHpzWnBEVStMRmZwR1hQUERNWUlJMUhIN2M1eUhM?=
 =?utf-8?B?UkNqWTBsblFsamRieFRCR3JITXN0bVNOMFJKN1B0dFFCSXlsUjRHN0NwUEth?=
 =?utf-8?B?RTdUakhsY24xeTZyRkxUZjIxSEIrYVlHVlZjQjFwa0YrS2dLQmlrUm1pMWsy?=
 =?utf-8?B?cjVmM3h3b2N2T1NJZG8rVnZKVGxXTTBRQkFlL1NWSVo2bTFXbWdwdU9MdXRv?=
 =?utf-8?B?Y1E5ZWQvdGNtRVkvTExjMW5VMG45eDR0OFNHcGJtWWZiWjFaRTl0QWpvQzJa?=
 =?utf-8?B?SHRsNWRudlc3VmpWSk1JbzNYdFZBWkc0Q2N1aTI5M0FkVWtycHFVZzFSbWVP?=
 =?utf-8?B?MjNnUnhZRGVhZGM0b2NoQnd5UWZpb00yNjVWYXZ0azUzekc3c1BkYTl2VlVN?=
 =?utf-8?B?VVhJcU5vSHN6UTFUSGZSNWQzTm1IUXVjaGFzSnpzaE9PWkhsdHNhR09VZnBK?=
 =?utf-8?B?MFRaVTZpTncwRkt0cmxqWHZtMEl0dGgwaU5mNkdlV0w1NGcySFN0VWxLd0JP?=
 =?utf-8?B?Um1BeFlWcEtOc0kySU1nbTh6c2tIQzh4RzBrN0Yvak9YYk5hN2xubzBwenZP?=
 =?utf-8?B?OVJ0b05FV2gvaDVzdS9VOVFqeUJoRUlvTVB0andEaVNTYnRaQXM1dytYUnpj?=
 =?utf-8?B?b3JCSk5ZMnR1OXVYbDc3RzRIVnp5QzhHckVDVGxrTjdaWEl5UFRBWkFQU08z?=
 =?utf-8?B?OFFMOEo3eG9IdldaQ0FpQ0wzOTVIQ1FXTGZETWpHYnVQNnZ2STcwaG1HOEhG?=
 =?utf-8?B?dHhMSkp6c2pabEpYOXh2bUVSTzNyVkN3aDZqSmF0VW9jSkdWVzdtczJ3Ukpa?=
 =?utf-8?B?UmpDYmN5Q2psdGl4ZzlWL1BqQWRaZWtxdFlFRzA0YlRjZm9CS0Q5RUp1b3Fl?=
 =?utf-8?B?U0VMQXF0eFdHemFGZktObTdtWGs2WnhlSzJ5ZllzbEgzenVwSXNabHdwa3FZ?=
 =?utf-8?B?ZjBTLzBXblhsblFFbVk5Rm5kb0xXOThQODMwcGtGQVUybFk4blF5bStGdFpa?=
 =?utf-8?B?T25ITkhsNWtJeFQ0V2RzREFUQzlzVmZqNndsQVFtYVg4UFFkVmdSV2JzbUNw?=
 =?utf-8?B?cXZpbW5ZUmpCZzZWbUFxd3I2NnREdFhseVZPeTg0Q1Z0VXRLbmxjYm1vSGNt?=
 =?utf-8?B?NVhzdklKMjZDb1RUZkdMQ0pXNEFWTjViaDV3OEQ4dk9vUkhNRVZYS0g5QSsw?=
 =?utf-8?B?SXZlTGs5VjN5ejc5ekFiMWJWeUdKaURpVUs0bHlNU2pkYXp6cU9VQWw1eDFT?=
 =?utf-8?B?M2Q0cFhrdWEzWm1zYjRZc1dTSEZYUmZiMnFXbFN5TnBXc2hwODdLVEplbWtH?=
 =?utf-8?B?SkNWRzJ0amI4YjgxcHZmRG5LNE9MU2EycWFqZ0JNa0dCUVpmdS92RDVYbENR?=
 =?utf-8?B?QWVjMTVyNzBpQWtpeGV4aVBGUXJydmFUc0RkR0htTVFPTENZdlVITUJRVXBk?=
 =?utf-8?B?QjNrL0k3OWNmbVlIZTZtOE1pa0p0dHc0cEd3VllYL0JTVUxJc1N6a2FMOSsr?=
 =?utf-8?B?WllYczdxenJjL28xK1NReS8xbUE1aW83NjdTKzFtVXQ0NlNhTVByMXlPVzBY?=
 =?utf-8?B?NGVXQk45RVEwd0sxQTF4bXI5dkUyUXQ2VjVBZFVERlNVYU9VaDNHMk9zZWYz?=
 =?utf-8?B?dmZ4T01FMTM3SU9JaVpFM1N2cmlkMmpBbnAreDd0OHVwZmI1eWxnbVV0eDNw?=
 =?utf-8?B?TWpDeDFnT3dTbk43cE1zdlEvV3IwRW9oZE42SlJZOFZIMis3LzdFUThSbDdj?=
 =?utf-8?B?aHZyKzBGTFpBSlNNRml3Q2R4a01jUDJyTEx4RDBXcmFpYTN3N1M1NndpWmdJ?=
 =?utf-8?B?QUk2RWdjKzlQRmpwWWNCNnhuSWMvYXFOM2g4ZmpiUjRqYXk4WmJwSGNGYWFV?=
 =?utf-8?B?NlJ4NW14S2RCUm9pNzZxRnd6VU5WUmhEM0ZUdTkrWGtJb1p0ZnZTNmJYTkl0?=
 =?utf-8?Q?bdAfW8asivc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWxxOFZxVkFhbGY5bmwrUUZqWEhTTHpoZm04NmkwYXNhSjdxaTUrMzJCT0lo?=
 =?utf-8?B?TFBHZUNWUmtKeWRGcE5zY2V4KzErQ2g5OHhqL2JOZjlnY2FRSStObWlEMCto?=
 =?utf-8?B?OHFaZGt1cUlFMjBKcjRBdHdYUWhhd2VaTkVMMTBDbENhbmdvTStvTG5sOE1m?=
 =?utf-8?B?L2VwTjBHYUE0U1Nkei9kaTdCSjRlUnhScHNqZVZZclhzNktKUmd0SnNEY0No?=
 =?utf-8?B?eVZRb3F6NVBnamEwNmFERnZESkQ2U2dqc0xjUHlZcmoybnFZRlZGZzkrNTV5?=
 =?utf-8?B?eEQ2MEhWR05PRnptUmNieHBsUStRN1NNZzVxWCtrOVZmWUhIZlAxY01wbzZP?=
 =?utf-8?B?eFBpUlZDZUxRb1E5cWptZi8xYmViS21RbVdqRWRVd0hDMy9JV1c2Zjl4UW1C?=
 =?utf-8?B?eWhUTEdaMVJqQzNtQVg2MHhLVHpPNEFpVGlCa0wxUFpyVmJWa3dOYjNXZEp1?=
 =?utf-8?B?OHUrZzNDZEVLbEZhZjdubGMvM2kwYlYzdUJnTHpFQ09QTnJDR21wblhBYmlN?=
 =?utf-8?B?VXAxL205UjBaSXBMUzFxNmFOcG5PcXJDdVcybVFRMmNrMW95eHM1NlorZUZs?=
 =?utf-8?B?MnJsMXdsQ3A2bWZhRnpocHE3QXVycGpmaTFVOXhLTW5QNEJMa0QyM2NKTFhk?=
 =?utf-8?B?OE15VVFMTmdhMTN1QWtUb3g2aXh6QmJRZ2pEZEw1bTVqbGtTV085eXhaanpv?=
 =?utf-8?B?YllpMTUyb1dZb3JmeEh4R0NVaDBpOWRqaWtIOTVUenV6ZHhRS2VXOUNzc2Qx?=
 =?utf-8?B?a0lhaXVjemV6QXlwUGh5UGVIWkVXTkVzNGd3RnFQdG5FQVIzRjNPTW02ZEJU?=
 =?utf-8?B?RlgyTDNRaTc3VW5nZFZCUVYyRmtVVU0yOFEzblE0MjV1bVpkaTY0amVQczc1?=
 =?utf-8?B?cDJqMFJkdW50SFhETWJwcE0wTGpKUzVaV1F0YnN0c3k0bjhSaEdURGdOSHcy?=
 =?utf-8?B?c1dLUkp1RmorTjdIdTBFYlcwVC85MEd1WEl0NEh2WHZTQkFtUnFONEVydG5I?=
 =?utf-8?B?Y0ppSmJvdWF2M2hMV3dIdUJDTTdZOGVVWFNyLzltUnJCbTdIUUtDalQrLzVF?=
 =?utf-8?B?bnJEM09Ubkx1aEpIUHd0WnQzcWRsa2g1NFIwMGtBQWtZZ3VXNVpjT2ZDUTVl?=
 =?utf-8?B?OWdLUGROTGplcVI3UEk2SnNCK1NNaS9NS1NNVkUyTlhxdXA1SXRTUkNDeEhN?=
 =?utf-8?B?NTYwRzB1eWZQcTBYRFppMnFUaXk2QnNtNlh6bUJqalEyZUd0YVY0bW9PL0RY?=
 =?utf-8?B?U2wrMm1qYlVqUUFHejFNK285a1UwRllJK1BPekRMZkdPOUIyRTRUaytqdVRG?=
 =?utf-8?B?S3oyMTVZQWdzaVZORmV4SHZqaWt1cVRWam9TVmp2OTN1U2tBQ0lUUm1zNHRm?=
 =?utf-8?B?NU1pNEJmaDF2aTUwSVc4VkMwOXVLNnFCQVdETk51MXB0cThhWHowa3oyZGFq?=
 =?utf-8?B?TlNOR0I5YTRQLzV2d052QzQ3UG1PL0dmcldXRmtweWJUU1VwdXF3dVgvY3M4?=
 =?utf-8?B?UkVsS1o4M1Zld0pCQ1pVcUZXR0JmMmRueGYrNjJtcVpiUHpUYjN4dW9kUzZp?=
 =?utf-8?B?SGpubzdINWFSWnNLUy9aZTFRR1FLeHlwYmo1U1JkYzF4K0lWMUFDaGVaNThJ?=
 =?utf-8?B?azF2OUV0cWJHQm1RL3VLZEZENkVYQ25nRW80ZGovWDRlVmFDL0RoK09mWS9P?=
 =?utf-8?B?YU5JVzAxYTBXYWxBTDdZVzRJWFlUKzZjTVM1ZWlicW5nb01yNk5QTjlHbWFr?=
 =?utf-8?B?VHNBRU1xNmY3elJXWFY3T1Nqb3Y2MHo0cVNCaDA5dTIvNUpmYXVCWHNlRlNQ?=
 =?utf-8?B?WlRTZUNOSm9DZWJha2NXcFpzb2VuL28yMVErZmJHVjNlcC9xTGtjMDNjS1Vw?=
 =?utf-8?B?THQrVEhRUXRZZFFiK0UzUlVmN1ZoMUdHVHA0WG4wb25uLzl3MGJXMUlQZm1Y?=
 =?utf-8?B?NDhpd3gwUEJSZjhsVlZNVFA0bndjZndpa0lOMC9ZeUF5NnRzUHZ3aStQcUly?=
 =?utf-8?B?dVAzK2xIWVVUUjBoYmFxZVVUZmwxZjdBeXpxenZ0VHFnZDNReHNkWUdKT1dV?=
 =?utf-8?B?VHhvVHIrci9jdFNyYjZYWC90MDVhT0l5RVpOQU5xN0Zrb0o0UkVEaDRYTWlr?=
 =?utf-8?B?TzAweDV4T1Bqb2k0ZjY1VmI2eERUaHNvVlRjb1ZMMHRyWVRlVVpYVDd2aXFh?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b864e1-2418-432c-ed60-08ddc5adf926
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:48:35.7798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayerSdyCsQd7L73XWHyYjyzbNzJ381r317DgazUnrKjpxGo79UUiIz6Rcwn0va6zofNmILDmSohblg36EuHK5m8sipL8YrfSan81SLNMwi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
> counters that can be assigned to RMID, event pairs and monitor bandwidth
> usage as long as it is assigned. If all the counters are in use, the
> kernel logs the error message "Unable to allocate counter in domain" in
> /sys/fs/resctrl/info/last_cmd_status when a new assignment is requested.
> 
> To make space for a new assignment, users must unassign an already
> assigned counter and retry the assignment again.
> 
> Add the functionality to unassign and free the counters in the domain.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index bb074773420d..6c0410cf0195 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -1022,6 +1022,14 @@ static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
>  	return -ENOSPC;
>  }
>  
> +/*
> + * mbm_cntr_free() - Clear the counter ID configuration details in the domain @d.
> + */
> +static void mbm_cntr_free(struct rdt_mon_domain *d, int cntr_id)
> +{
> +	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
> +}
> +
>  /*
>   * rdtgroup_alloc_config_cntr() - Allocate a counter ID and configure it for the
>   * event pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
> @@ -1083,3 +1091,42 @@ int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp
>  
>  	return ret;
>  }
> +
> +/*
> + * rdtgroup_free_config_cntr() - Unassign and reset the counter ID configuration

rdtgroup_free_config_cntr() -> rdtgroup_free_unassign_cntr() ?

> + * for the event pointed to by @mevt within the domain @d and resctrl group @rdtgrp.

@mevt -> @evtid

> + */
> +static void rdtgroup_free_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +				      struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
> +{
> +	int cntr_id;
> +
> +	cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
> +
> +	/* If there is no cntr_id assigned, nothing to do */
> +	if (cntr_id < 0)
> +		return;
> +
> +	resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid, rdtgrp->closid,
> +			    cntr_id, false);
> +
> +	mbm_cntr_free(d, cntr_id);
> +}
> +
> +/*
> + * rdtgroup_unassign_cntr_event() - Unassign a hardware counter associated with
> + * the event structure @mevt from the domain @d and the group @rdtgrp. Unassign
> + * the counters from all the domains if @d is NULL else unassign from @d.
> + */
> +void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
> +				  struct mon_evt *mevt)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
> +
> +	if (!d) {
> +		list_for_each_entry(d, &r->mon_domains, hdr.list)
> +			rdtgroup_free_config_cntr(r, d, rdtgrp, mevt->evtid);
> +	} else {
> +		rdtgroup_free_config_cntr(r, d, rdtgrp, mevt->evtid);
> +	}
> +}

Reinette

