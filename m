Return-Path: <linux-kernel+bounces-861331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA7BF2710
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5246C4F0817
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD128C2BF;
	Mon, 20 Oct 2025 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtPQvzvv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2728A705;
	Mon, 20 Oct 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977890; cv=fail; b=JseYUfFLzYXhUKfHxNNK69LXxy0u2VH6zLCMUeFzKsK/xN3AUgmVJ/6WJXf3tU6AlNFcwkpC6ZVBCIlzaHl58Dvpv8vJ+3mFdTPnOM+WztofEIMFZuysvSC1mDnnxMzsDml1PC9NDGjwXMzbRHyHQnnj93F2wABU5mRtGuR2bnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977890; c=relaxed/simple;
	bh=1i1DPQIqZocZrCWsFyug0HzeASYzX8bP82NS6DCbQew=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EdJ8RmBoRwXTcs62T4Rrm4wWG2YPogctM9fMK/B8sl7UqKZgJydnYF9uBhbjT3jd+xXQOD+NXUSxUDOhd1qgyvno/BOVV0txXi1nvpWjL9g9O+F6M2CGTAsKUx3WpV4dxZeiLQa5ZzHx7PSBfp0YTbxeSKAhPIC1NqorWzpHwr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtPQvzvv; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760977888; x=1792513888;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1i1DPQIqZocZrCWsFyug0HzeASYzX8bP82NS6DCbQew=;
  b=VtPQvzvvUByEc1APYUC9AqkzrSpv7tIy0/JilnRItqtTiPJrT/KXHe16
   dLDmXIBtziKgtMoflKh7RB5kVAiWuIGp8LJnnkzQjyUOmuZGxa34//QpR
   /6/LvCOZ5KWEZ4QHzB6aZZcZ24ppeuyNh3cmIupxw66E1U2dbXJoNSN1N
   m+8NxqfZurITYPeE/ki/G73PBjNvyjjqcWiNzJ0mbXli8Rto8v50zxsbY
   XkVQl3mjprg3saRgma0HZRa/q4AG4sL967TX3QZGIteOp/f1QBG11k2l9
   4xzwBsn1l/njkPBwQKIfiubkrq5x5tuWHnMHGUs49JYi/AOd/4HlU5YRg
   Q==;
X-CSE-ConnectionGUID: Z+LkXlERQzGgcr69QZzK4A==
X-CSE-MsgGUID: NO4rBTV0TB65L/0j2Khg5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63001212"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63001212"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 09:31:27 -0700
X-CSE-ConnectionGUID: 35jrgu4cS3qXHxpxRSFUpQ==
X-CSE-MsgGUID: yb1o49mzSp2fINVMzNUvyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="184139797"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 09:31:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 09:31:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 09:31:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 09:31:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHO6GGOy97s/1AwctmzmriwuBqvaRhKkdqoqQJW+ogL+au+CximrgYjbfr2BtMxpXls+NXUEc/vdqv6L4bkaR1PHNuGjtYH4RYXTAvmVPo4AQP0JxUpGRHWFovcCQYq1x02ZYxxqMczm3Ffl66EUgQiUX32Dkrij8p1XwddXOFu9Y/7aiJE4atPsX41qq4uXHzbmdAE7LQMg7TGs+WdbamBiMyILdrPo+8B0V0BUAjDEr/J73ziGtyFkvs0vIKzk897MGNOySVHF4Fj9udJYeYWPhO5aJsDsApFkswi+pGdmbLZhh7kKXYGk1Hj5I3JlUhI1RAPyTcmHZZuqLyE3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S2il5GctfU4EadpBlfkNdMAN/1hKwko1vdDvDfZBio=;
 b=Daaa7P/f1GqhuEJOQQLgxE39EN/tl20s44szZptyOCMKx48BTzzph+cDcNYyxizRv6Oucny1PFIrpffD5CLXUdss18HVxhZmPRFBGmxwNFA+YwWg7PIQdGOogjan2pztr0o63lx2p+5DS+n1zK0+ofYhF5lgkQdIjsnSVv0iyifKJ1t8btr950Ku0YUMT1HBuT33rN5uUesk/QwQMsUIBnv4iwWEyOtzvpgAh9lQ+Egh9qkhyL5D6ZLkOonAueGr2NuyumJ4Il7f+PBbyF5JYy2MQJn8TxdtaiVYDDUfZ1kce0zR+YshlP3yOz7NC88t1XiJTcpnLEdT/o77OeqR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 16:31:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 16:31:21 +0000
Date: Mon, 20 Oct 2025 09:31:18 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>
CC: Reinette Chatre <reinette.chatre@intel.com>,
	<linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aPZj1nDVEYmYytY9@agluck-desk3>
References: <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <aO0Oazuxt54hQFbx@e133380.arm.com>
 <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
 <aO/CEuyaIyZ5L28d@e133380.arm.com>
 <dd5ba9e5-9809-4792-966a-e35368ab89f0@intel.com>
 <aPJP52jXJvRYAjjV@e133380.arm.com>
 <e788ca62-ec63-4552-978b-9569f369afd5@intel.com>
 <aPZaTk97RC6sg+uQ@e133380.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPZaTk97RC6sg+uQ@e133380.arm.com>
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 27431fd2-4f89-4619-785b-08de0ff619e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVB4aGZORjg5cGxqUk8rUUhxeFgvdDYxVnlPQkdCdmk4RjcyQnlna3MzcHhV?=
 =?utf-8?B?ekVxMGJNQUYyTlJZNHVEVXpoNlRZSjU2cUtDam1zcUlyWFRvMlpPb2hGeDFq?=
 =?utf-8?B?Y2ZEZ3RlUHJpMkxxdHRuZ0hsV1M5STFWUXpxckRsQlN2aGZtSktOTStoVVhV?=
 =?utf-8?B?WE8ycW9NTXVReHhVUlRYMDRocEFUZklLdlJiZUU0eVhNVEpOYlRISnNhOXll?=
 =?utf-8?B?OFNwY2RHL0NRY2gwTHFvV1QzbDFYSTVUQWxEWUNLQzBaTFpUbWMxQkpZZkZR?=
 =?utf-8?B?YXU3REtyQkI5bmFLUlNZSElwWHp1NHZzcFZ1c1N1bXkzOFJKMzZKR1FLRkM1?=
 =?utf-8?B?ZXdmdi9KL21OSXVpUi8zTjJUbWtRRDNqYlh5U0N3ck9ISDF1L0h0MnlORzZY?=
 =?utf-8?B?WGxIQlZjcFgrMjM1RHBNb3VuSEtjOWxmK1gvNDZPSWp3K3J4bnB5ZzllRkl6?=
 =?utf-8?B?S3dnMFdVUjZkYzVVVTJhcllYTmFLUUZBRlN6RVBHS25IdHEzdHdRWHFtTlpm?=
 =?utf-8?B?dDJIWTEwRXJOZ3N6WWRYT2t6T3JaeVRicXA3N0E2S1VmR1FiSU9SUlB0MkI5?=
 =?utf-8?B?V2ZpOVFqNHpVQmlXaWJ1bTdKNmUzK0o2YlVRY3FIRGFpOUptWGNnS0c5NUlz?=
 =?utf-8?B?ZFZtSWttZXFVbnJlTlpLb3Q0RjBKTmU3azVaZ1AvOWMwZ3loMkRyOXY5bEdh?=
 =?utf-8?B?QkE3ZSswQTJmQVdudndOMzM5cllTVndwZnZQaE8vOVI2ZjZLNENBTVdzK2xM?=
 =?utf-8?B?U2o4TEF2NWpueEp2N0ljM0ZqS3QxU0ZzcnIvOENET3RKQVoxRFphVE1CN1Nu?=
 =?utf-8?B?YmJiMm1CZkFDR3poTzM3TmcyVlBaZnVsL0tGNVhuUVdSSWh1YnkyY0Y1UStt?=
 =?utf-8?B?NWNnSnhxbk5OdEFZcm9hQ3JPZ3Y5YmphdUJidjNPU2d1ZmZvME1NS3o1eHl2?=
 =?utf-8?B?c3VxVGZnSHYwMk5seUJnekd2U1ZEL3doWnVGdUp1Tk16aGxCOHQ4eFRDMDds?=
 =?utf-8?B?cGZuT0gxbzBSak5ZZkRoTWVZM0J2RkF4UkhRNU9YdTFvd282Mjc5WjlZeVNC?=
 =?utf-8?B?aitrbkJMRFYvM254M2JhT2RtL0IvbXBJek8vZ2pWdGs4M2M0QVRMYlZRYVYx?=
 =?utf-8?B?V053T3JwSXNmemVXRCt3NlN4eWxDeHR4dlR5UndjRUVMbmlZc1A1cXJHSWl4?=
 =?utf-8?B?NXk5dmJ3cG1jOTBpL3VsMGRSTk9lR2UzdVB3VTdPanpUQkVzMXVDSUc2S3F4?=
 =?utf-8?B?M1ZRUnc2QnYxTThYalJxZzVBR2V6aFowSGtESFFvdlJTQnpBbk5LR1l5UmVL?=
 =?utf-8?B?U1ErRVpZZGRzVVpiUzJBOEpDRW1YRk5yUnFXRnhRK3hxanRYUUJOaHdqaXdH?=
 =?utf-8?B?ZWpvQTZzdjB2RTJQL216K3NHNTcwWEVEejlLZHlWMHE5WU5VZnd3SnZad2ls?=
 =?utf-8?B?VkNyRE52VkMwQ2QzVjMyMS80MVlUWTZtN1FVQlRJR0dVUGxicXZhTXlDMXBp?=
 =?utf-8?B?cjJSZE00djdPdWpzWnJoZU9BMHB2RE1HM2IrSUZUZVE1STgyZVlNc2RLZzY1?=
 =?utf-8?B?bGRlTHIxS0V4NFhXNEk2VlJvZWc5Yis3MzZDd2xaRm5sdCtuNWQvSzdWeGJZ?=
 =?utf-8?B?eDZDMk5yWEJIZDVoeWZEREpkby9WTjRHTm1rSklJU2tTdXhHUHlYMUtnMS9U?=
 =?utf-8?B?OUFEOFNxRk10MDVERVNSYk4zM3RlMlpyUkZ1ckFvT05zbitaL05NUHZ5VHMr?=
 =?utf-8?B?QW1lTGl1K2NrV2FnZHRscmQzWkxBOVNHZEwrM1B3S2JEMVhUTHpRTXAwUzBi?=
 =?utf-8?B?MG9TeVlYZUJkZm1wYnJPS1NESDJsczZUKzA5MG55NVNtRTJLWmJtMFVvc241?=
 =?utf-8?B?cngwMmRpY0dNVFdSMUZqV1FBSzJTVWdKWENHWHk5TEZXY29qS0NEbkUvbGY4?=
 =?utf-8?Q?CjPzGwYbksZlHvqiYxrZJfk4iziM96vN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGV1RjlVdjNQVGtMOHEvVTBBeWZ1b0FnYVJTZDd3a25QS1h0VGs4NHJhazZG?=
 =?utf-8?B?ekhRWFpjVEVoT0NPZzVDaFRiUHNwckFwVGw5QndPQnZZWXFLY1ZpT0Y5QzVh?=
 =?utf-8?B?WVFUVDBRRXVrMkt4a1lQVkMybVI4bjRmb1JraUFQc1IxNUY1ZDVXRE5VOWpq?=
 =?utf-8?B?RG42RjVadlRuUTVXVmdKUWpWbGluUDZLZyt3eFRPTzh0aC8rdUVHRmc4RGl3?=
 =?utf-8?B?OWIrUmhhbFNHUUlwSUNJbUFwU3kwTXAwM2JWeWQvUXRRdG05NU1YMDJsUXBw?=
 =?utf-8?B?NEdxZ2xlK0hVUkVZYkxKQmZudXpnb1NkcitVT0R1UHpZcWxtVys3UUhXTk1Q?=
 =?utf-8?B?MEViR1B4L01kVkRoQzNqWmxsbjR0RW5DOUlsa09wM1dlQ01LTEVJaVptSnVK?=
 =?utf-8?B?U0RUV2l1Z0ZMenlZalBlWTdEQUZWRGpiUnBRb3cxTFc2ZzNqVTdSSlBGUm5W?=
 =?utf-8?B?aXh2TlR3WStmU2dhRXVLUEttdGxrZ1l0cjZHMTA1cFRac2ZEK2w3aXVrcDhJ?=
 =?utf-8?B?YkV4SHlQNk9qUXpGUHV4Yno4dk5DZ0NFcndrOHJsOVRKUnpKalJsbW5yNS9l?=
 =?utf-8?B?b1FmZVpZbjA3VjJwK2FzNTc3Um0vTjk0YnVRd291dTVMdnRiV3FNRFBGclA1?=
 =?utf-8?B?eFlnSVRtYlIwSHJEVjJuREluMmh0QSs3TjlMcVFFa1U4MHhBc1luaWtMWXFk?=
 =?utf-8?B?d3RMUzVQWUFvVXdSUVNCbkM5cm55bzIyT2gxTnZKcFVmSkVBOHNabENVNVJL?=
 =?utf-8?B?VTE1UWh6TXdFOFVTT0hLWDFFU01TWXJUcUlBQkZqNU5XTHN3a3lMWUVrNHNZ?=
 =?utf-8?B?T2w0SUFQY1ZrZnQ5R2dIN0RiK25NZFBxNUZ6OHZBcTIyTnNmaTc0blRVaFox?=
 =?utf-8?B?QlhsU0hWSGFDUjFROFNNUDYyUWJHbHJyNW5DdW05cUFKTUFsckdOdE5Yei90?=
 =?utf-8?B?ZlQyRU56L3VVQ2I3Qnc5dlNZbU1PZzNmZlFhMlQvVXpqeUdxNCtQcDQvS3ZF?=
 =?utf-8?B?MmpTVklkbExMMHZObHpod3kwZmUwL2J1eUxuN3NtZ3dBbDd0alhVa0FTTDUv?=
 =?utf-8?B?SkFod2hKWjRHZjJNcmorTGhWSnZYaStOMGg0cCt5c0U4d2hjNU9OVnJMOVpr?=
 =?utf-8?B?RjFldW15N21oSUVFUHVKbWNMcGo2ZForUlhUdzc1dmF4bUwzOVd3MHVrVVlx?=
 =?utf-8?B?OWJJcWpTV3FpV2NMdWsyOU8veE5SVWpaSVRaZ2Fzc2JONlViRlRicndiSTJv?=
 =?utf-8?B?ZGxqTUlEOXBtS1dHdXRHU1hWYWlhRVVpMCtmVHlwekVvVUJQZTcxRStsaWN4?=
 =?utf-8?B?NmJhTVFvWEdVTFVhRldkRVpQYzNuTzQwN3YwdjJTTkQ2TE9kYXc5QTJ4Ty9E?=
 =?utf-8?B?cTA3Z2JsenAvU3VrOHdpZzNMR05aNHF3U1diNU5nN2ZnejU4OXU2a1dTWjFG?=
 =?utf-8?B?OWExTHpYYlU5WXcrbER5TjhySGFibHp4ekNGUU8rNW9YSjV5TUpHOGU5V3dr?=
 =?utf-8?B?Vk9KY2lJVVlnMDFOMy9UUGo5K2pia0IwM3JCRHRZemRUc2FqbGpUNEoxa1NC?=
 =?utf-8?B?QlY5dlZSM0hEOEdMeXdKMk1rKzVYMVBYNkJ3SHpaYmNDWVNrS3h4Y0k2R2pT?=
 =?utf-8?B?MmE0cTR5RmI1dGczenJqUVVCa3k2L0FDUVhoOWJpb3FSNnpKR0NPbUlsVmlN?=
 =?utf-8?B?QTJreldGd1FRVXc1d3IzZU5VSHlBKzhvQU5TWXk1RHBJMFJMV0Q0bjBXNGMz?=
 =?utf-8?B?NWs1QWdQVzJuc1hVNjdjalhGM1h4NjNsRnJOV2FNcytrWjNERk93aHpoczgv?=
 =?utf-8?B?ZjhjM2t4NDlYbDdzaHRsVTdrdWg3MmdTZUpDa3NBSVZRZ0d3TkNKMmpYVEZh?=
 =?utf-8?B?ZFV4a3FJOU1rL1dwQjY4N1E4eEEzOW53SDZhWmFSbUhTRVljZHlGTlp0L0hy?=
 =?utf-8?B?Vi9sU0JHY2t3VE1kT0pEYUR1Wk5ON043LzFnSG1ISHNVMWdMaEdacUpyaitk?=
 =?utf-8?B?SzBMdndneHdzTUcrUkg5TGtrS2gvVTE0WnZBWitWTTZXZ0pZZHdYRnV4MXJM?=
 =?utf-8?B?dUsrN1J4VlpmajVRNXJFdmRwMnVnbHg3dnhUWGNGNVZ2Zk0yRnEyVVhwQU42?=
 =?utf-8?Q?KaBth1WQzHxR7eRs62lnWupAZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27431fd2-4f89-4619-785b-08de0ff619e4
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:31:20.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSW71IiPSCDv3QkXIY0/o+VtrFNMy4H67FLcG+ALKk4LCVaVIfeO40ssxmcqcLKGz/cEW07Ge7t0DsVzizI8kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com

On Mon, Oct 20, 2025 at 04:50:38PM +0100, Dave Martin wrote:
> Hi Reinette,
> 
> On Fri, Oct 17, 2025 at 08:59:45AM -0700, Reinette Chatre wrote:
> > Hi Dave,
> > 
> > On 10/17/25 7:17 AM, Dave Martin wrote:
> > > Hi Reinette,
> > > 
> > > On Thu, Oct 16, 2025 at 09:31:45AM -0700, Reinette Chatre wrote:
> > >> Hi Dave,
> > >>
> > >> On 10/15/25 8:47 AM, Dave Martin wrote:
> 
> [...]
> 
> > >>> To avoid printing entries in the wrong order, do we want to track some
> > >>> parent/child relationship between schemata.
> > >>>
> > >>> In the above example,
> > >>>
> > >>> 	* MB is the parent of MB_HW;
> > >>>
> > >>> 	* MB_HW is the parent of MB_MIN and MB_MAX.
> > >>>
> > >>> (for MPAM, at least).
> > >>
> > >> Could you please elaborate this relationship? I envisioned the MB_HW to be
> > >> something similar to Intel RDT's "optimal" bandwidth setting ... something
> > >> that is expected to be somewhere between the "min" and the "max".
> > >>
> > >> But, now I think I'm a bit lost in MPAM since it is not clear to me what
> > >> MB_HW represents ... would this be the "memory bandwidth portion
> > >> partitioning"? Although, that uses a completely different format from
> > >> "min" and "max".
> > > 
> > > I confess that I'm thinking with an MPAM mindset here.
> > > 
> > > Some pseudocode might help to illustrate how these might interact:
> > > 
> > > 	set_MB(partid, val) {
> > > 		set_MB_HW(partid, percent_to_hw_val(val));
> 
> [...]
> 
> > > 	get_MB_MAX(partid) { return mpam->MBW_MAX[partid]; }
> > > 
> > > 
> > > The parent/child relationship I suggested is basically the call-graph
> > > of this pseudocode.  These could all be exposed as resctrl schemata,
> > > but the children provide finer / more broken-down control than the
> > > parents.  Reading a parent provides a merged or approximated view of
> > > the configuration of the child schemata.
> > > 
> > > In particular,
> > > 
> > > 	set_child(partid, get_child(partid));
> > > 	get_parent(partid);
> > > 
> > > yields the same result as
> > > 
> > > 	get_parent(partid);
> > > 
> > > but will not be true in general, if the roles of parent and child are
> > > reversed.
> > > 
> > > I think still this holds true if implementing an "MB_HW" schema for
> > > newer revisions of RDT.  The pseudocode would be different, but there
> > > will still be a tree-like call graph (?)
> > 
> > Thank you very much for the example. I missed in earlier examples that
> > MB_HW was being controlled via MB_MAX and MB_MIN.
> > I do not expect such a dependence or tree-like call graph for RDT where
> > the closest equivalent (termed "optimal") is programmed independently from
> > min and max.
> 
> I hadn't realised that this RDT feature as three control thresholds.
> 
> I'll comment in more detail on your sample info/ hierarchy, below.
> 
> > > 
> > > Going back to MPAM:
> 
> [...]
> 
> > > So, it may make more sense to expose [MBWPBM] as a separate, bitmap schema.
> > > 
> > > (The same goes for "Proportional stride" partitioning.  It's another,
> > > different, control for memory bandwidth.  As of today, I don't think
> > > that we have a reference platform for experimenting with either of
> > > these.)
> > 
> > Thank you.
> > 
> > > 
> > > 
> > >>> When schemata is read, parents should always be printed before their
> > >>> child schemata.  But really, we just need to make sure that the
> > >>> rdt_schema_all list is correctly ordered.
> > >>>
> > >>>
> > >>> Do you think that this relationship needs to be reported to userspace?
> 
> [...]
> 
> > >> We do have the info directory available to express relationships and a
> > >> hierarchy is already starting to taking shape there.
> > > 
> > > I'm wondering whether using a common prefix will be future-proof?  It
> > > may not always be clear which part of a name counts as the common
> > > prefix.
> > 
> > Apologies for my cryptic response. I was actually musing that we already
> > discussed using the info directory to express relationships between
> > controls and resources and it does not seem a big leap to expand
> > this to express relationships between controls. Consider something
> > like below for MPAM:
> > 
> > info
> > └── MB
> >     └── resource_schemata
> >         └── MB
> >             └── MB_HW
> >                 ├── MB_MAX
> >                 └── MB_MIN
> > 
> > 
> > On RDT it may then look different:
> > 
> > info
> > └── MB
> >     └── resource_schemata
> >         └── MB
> >             ├── MB_HW
> >             ├── MB_MAX
> >             └── MB_MIN
> > 
> > Having the resource name as common prefix does seem consistent and makes
> > clear to user space which controls apply to a resource. 
> 
> Ack.
> 
> The above hierarchies make sense, but I wonder whether we should be
> forcing software to understand the MIN and MAX limits?
> 
> I can still see a benefit in having MB_HW be a generic, software-
> defined control, even on RDT.  Then, this can always be available,
> with similar behaviour, on all resctrl instances that support memory
> bandwidth controls.  The precise set of child controls will vary per
> arch (and on MPAM at least, between different hardware
> implementations) -- so these look like they will work less well as a
> generic interface.
> 
> 
> Considering RDT: to avoid random regulation behaviour, RDT says that
> you need MIN <= OPT <= MAX, so a generic "MB_HW" control that does not
> require software to understand the individual MIN, OPT and MAX
> thresholds would still need to program all of these under the hood so
> as to avoid an invalid combination being set in the hardware.
> 
> If I have understood the definition of the MARC table correctly, then
> there is a separate flag to report the presence of each of MIN, MAX and
> OPT, so software _might_ be expected to use a random subset of them(?)
> (If so, that's somewhat like the MPAM situation.)
> 
> So, I wonder whether we could actually have the following on RDT?
> 
>   info
>   ├── MB
>   ┆   └── resource_schemata
>           ├── MB
>           ┆   └── MB_HW
>                   ├── MB_MAX
>                   ├── MB_MIN
>                   └── MB_OPT
> 
> If MB_HW is programmed by software, then MB_MAX, MB_OPT and MB_MIN
> would be programmed with some reasonable default spread (or possibly,
> all with the same value).
> 
> That way, software that wants independent control over MIN, OPT and MAX
> can have it (and sweat the problem of dealing with hardware where they
> aren't all implemented -- if that's a thing).  But software that
> doesn't need this fine control gets a single MB_HW knob that is more-or-
> less portable between platforms.
> 
> Does that makes sense, or is it an abstraction too far?
> 
> 
> (Going one step further, maybe we can actually put MPAM and RDT
> together with a 3-threshold model.  For MPAM, we could possibly express
> the HARDLIM option using the extra threshold...  that probably needs a
> bit more thought, though.)
> 
> > > There were already discussions about appending a number to a schema
> > > name in order to control different memory regions -- that's another
> > > prefix/suffix relationship, if so...
> > > 
> > > We could handle all of this by documenting all the relationships
> > > explicitly.  But I'm thinking that it could be easier for maintanance
> > > if the resctrl core code has explicit knowledge of the relationships.
> > 
> > Not just for resctrl self but to make clear to user space which
> > controls impact others and which are independent. 
> > > That said, using a common prefix is still a good idea.  But maybe we
> > > shouldn't lean on it too heavily as a way of actually describing the
> > > relationships?
> > I do not think we can rely on order in schemata file though. For example,
> > I think MPAM's MB_HW is close enough to RDT's "optimal bandwidth" for RDT to
> > also use the MB_HW name (or maybe MPAM and RDT can both use MB_OPT?) in either
> > case the schemata may print something like below on both platforms (copied from
> > your original example) where for MPAM it implies a relationship but for RDT it
> > does not:
> > 
> > MB: 0=50, 1=50
> > # MB_HW: 0=32, 1=32
> > # MB_MIN: 0=31, 1=31
> > # MB_MAX: 0=32, 1=32
> 
> This still DTRT though?  If MB_HW maps into the "optimal bandwidth"
> control on RDT, then it is still safe to program it first, before
> MB_{MIN,MAX}.
> 
> The contents of the schemata file won't be suffucient to figure out the
> relationships, but that wasn't my intention.  We have info/ for that.
> 
> Instead, the schemata file just needs to be ordered in a way that is
> compatible with those relationships, so that one line does not
> unintentionally clobber the effect of a subsequent line.
> 
> 
> My concern was that if we rely totally on manual maintenance to keep the
> schemata file in a compatible order, we'll probably get that wrong
> sooner or later...
> 
> > >>> Since the "#" convention is for backward compatibility, maybe we should
> > >>> not use this for new schemata, and place the burden of managing
> > >>> conflicts onto userspace going forward.  What do you think?
> > >>
> > >> I agree. The way I understand this is that the '#' will only be used for
> > >> new controls that shadow the default/current controls of the legacy resources.
> > >> I do not expect that the prefix will be needed for new resources, even if
> > >> the initial support of a new resource does not include all possible controls.
> > > 
> > > OK.  Note, relating this to the above, the # could be interpreted as
> > > meaning "this is a child of some other schema; don't mess with it
> > > unless you know what you are doing".
> > 
> > Could it be made more specific to be "this is a child of a legacy schema created
> > before this new format existed; don't mess with it unless you know what you are
> > doing"?
> > That is, any schema created after this new format is established does not need
> > the '#' prefix even if there is a parent/child relationship?
> 
> Yes, I think so.
> 
> Except: if some schema is advertised and documented with no children,
> then is it reasonable for software to assume that it will never have
> children?
> 
> I think that the answer is probably "yes", in which case would it make
> sense to # any schema that is a child of some schema that did not have
> children in some previous upstream kernel?
> 
> > > 
> > > Older software doesn't understand the relationships, so this is just
> > > there to stop it from shooting itself in the foot.
> > 
> > ack.
> > 
> > By extension I assume that software that understands a schema that is introduced
> > after the "relationship" format is established can be expected to understand the
> > format and thus these new schemata do not require the '#' prefix. Even if
> > a new schema is introduced with a single control it can be followed by a new child
> > control without a '#' prefix a couple of kernel releases later. By this point it
> > should hopefully be understood by user space that it should not write entries it does
> > not understand.
> 
> Generally, yes.
> 
> I think that boils down to: "OK, previously you could just tweak bits
> of the whole schemata file you read and write the whole thing back,
> and the effect would be what you inuitively expected.  But in future
> different schemata in the file may not be independent of one another.
> We'll warn you which things might not be independent, but we may not
> describe exactly how they affect each other.

Changes to the schemata file are currently "staged" and then applied.
There's some filesystem level error/sanity checking during the parsing
phase, but maybe for MB some parts can also be delayed, and re-ordered
when architecture code applies the changes.

E.g. while filesystem code could check min <= opt <= max. Architecture
code would be responsible to write the values to h/w in a sane manner
(assuming architecture cares about transient effects when things don't
conform to the ordering).

E.g. User requests moving from min,opt,max = 10,20,30 to 40,50,60
Regardless of the order those requests appeared in the write(2) syscall
architecture bumps max to 60, then opt to 50, and finally min to 40.

> 
> "So, from now on, only write the things that you actually want to set."
> 
> Does that sound about right?

Users might still use their favorite editor on the schemata file and
so write everything, while only changing a subset. So if we don't go
for the full two-phase update I describe above this would be:

  "only *change* the things that you actually want to set".

> [...]
> 
> > >>>
> > >>> OK -- note, I don't think we have any immediate plan to support [HARDLIM] in
> > >>> the MPAM driver, but it may land eventually in some form.
> > >>>
> > >>
> > >> ack.
> > > 
> > > (Or, of course, anything else that achieves the same goal...)
> > 
> > Right ... I did not dig into syntax that could be made to match existing
> > schema formats etc. that can be filled in later.
> 
> Ack
> 
> > ...
> > 
> > >>> I'll try to pull the state of this discussion together -- maybe as a
> > >>> draft update to the documentation, describing the interface as proposed
> > >>> so far.  Does that work for you?
> > >>
> > >> It does. Thank you very much for taking this on.
> > >>
> > >> Reinette
> > > 
> > > OK, I'll aim to follow up on this next week.
> > 
> > Thank you very much.
> > 
> > Reinette
> 
> Cheers
> ---Dave

-Tony

