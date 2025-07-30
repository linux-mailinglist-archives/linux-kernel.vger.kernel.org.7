Return-Path: <linux-kernel+bounces-751293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D80B16755
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B543B18C6B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE671F78E0;
	Wed, 30 Jul 2025 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiTy6U3A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B3A1EA7FF;
	Wed, 30 Jul 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905927; cv=fail; b=IV5/Do22UAEAZxKaVacJ45Im58GlJdBzdN0kEW2j3Io2JNa4BIqH9oJsZzIxSUsmcc6TahtQEyIhFTASaBpwmpT5vFmMZvf5USvngnxpH9SndkLthWQz/IRJ5APYbEopeLcnTco8dDj7yHotPjJKu6uvpDZveXeCrW7UVO/KC0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905927; c=relaxed/simple;
	bh=1ukpgIQ5KNdZ9mTiir06i5vGsFAJvQyY7VE2sInc2+0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kL1392WVyT1NNIQHrPxoRWiuI20Iac0/rXZ7PmiPyqtMV7WPQ6YhGTh+sEqAj30ap0HY/CUrFfQRM4m/XGjFY5oE3b7Us/vv7pvJY7x0N47HmD1w+GKZ/N2r4RBhyZrqGKWdDE9seF9K53CIP98+hYbaZgqeITxWNMrwDfLxykI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiTy6U3A; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905926; x=1785441926;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ukpgIQ5KNdZ9mTiir06i5vGsFAJvQyY7VE2sInc2+0=;
  b=LiTy6U3Ax+usUWjfVxhvRxEwZ0PNs73NSmvUeyXVANJFCkQka17v6TSu
   H/uK0Kxcel+CDQ8u4cVPo+se/7HwJ8uJ97aM4bxbs9V6uqGt24rGx/SFW
   kaI8wTcQzqv9+UOn710uO4UzlxRYltnzTVtvMCi7wEEt8BmoDgQGamhfN
   VTNUzlnLKS8ZM5IPOdqCXX9HnyMot548gJf+hCmSG5SdrwLwB2AtYwcti
   pn4s+BW39n/mz/cFoPItspE99tNin61Ow5CrEK1F+fA8bSwWf+5stXyri
   cslvUtHFvzxAGNWf18/WIu060wqTIIsFSHi4iNVDJWv8R3+2p2hdmGDXy
   w==;
X-CSE-ConnectionGUID: aXJRHWjRQj69IhwjOiAbPg==
X-CSE-MsgGUID: lpaFUJvbQMK/3Ez2O0uSDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67580288"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67580288"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:05:25 -0700
X-CSE-ConnectionGUID: tMXfI62GQf23HHEldmd2bA==
X-CSE-MsgGUID: qN/BxG79RNuinw7r6ttBZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="186770398"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:05:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:05:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:05:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.40)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 30 Jul 2025 13:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmCROi6yg0romKYQtc5OnwPmsEpni5VEbfyjdwLrxSlH7sgUQV5YyMVXyEc/6N6jcCXfZOTJb4Q/sACu3oFaPKbfJ+UTxnXC1ByiM/5HdQx+atFISea1QyNdBOpihd0Mq9VQtAn1KBcTh/QuWij1jOy3ZG7FuBt+3N4NpEvogz6xaA47ADOpBUYwnF7Pit/TmTdZuXoDnwJJAumzblTtMqZs1tljW7SRJLT/tOP+chBzpKPTpcjzcGUxuaO+gRo31u3FcdJ5hIbIrtWIATmtAXCginuRYhSSLjg6tGW67Q1Hm17Xz7TpIBsfGBNMYAweS/M5+48C1ob97x6WQxkMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pTmAqFARFZVSvNQ67K1AAaM8yURTA6mGIErd6ylGIM=;
 b=jjqWMkEWClBTuOJFTpfTXX28FZt/M219x1VlF3RiuSQaA02grDcoqZR/HgazNH5bnUbTmE3U7MZUNKDtcIyRoxZ3TvCM7R8+QCraRnhhHkwst9s670DQl/x2OqpjvehFMbmlIPe7SQ26LQ63odIt2mz7SvX8BDdtJ1xHEFSwL5bR2xtPoc2vTQLGYd6ADOydRrUDnqsZNuOcroGjpZPTdsak/yvgaW5PipaMcCGibcwAADuwuhPnSUR2R+bTH728n+f3rKENPRT7SKqkHWi11pzSO1E+eYyt2kaP586DqXhRe0wJ7iVljC8dyu9nQ3MGEOLZog9eA2i6gWaZ4R15mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 20:04:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:04:58 +0000
Message-ID: <99614342-b6ce-47ec-baf9-f5cdf42f77be@intel.com>
Date: Wed, 30 Jul 2025 13:04:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 25/34] fs/resctrl: Add event configuration directory
 under info/L3_MON/
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
 <13467b9a56bccf960974741741b4960a8f02e333.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <13467b9a56bccf960974741741b4960a8f02e333.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:303:6a::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: d21fd1b4-e09a-489a-7057-08ddcfa45be5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkNkbUhqYzJCVGl2Wks1Nk9FTTR5eGFMZUJnNFRNaW1hUUlvSDVXR24wQXRq?=
 =?utf-8?B?NkZnVDlydVNSZUNwNUNKaFJWVm1yY291QWhvNmR3S2tWdmNEckZpbXpUSVQ5?=
 =?utf-8?B?TlVEWXIvU3lOKzRMTHgvYVhITDJlQ0ZyV1VPbFFydTJUbTlDVXovakJwK014?=
 =?utf-8?B?dzJDU1RDZ1hPR2Mza0l1ZHVoeHZMRW9vTHJ4QndtcmFvQUYxb0Z3ZW5OM0dh?=
 =?utf-8?B?VGJRZWc5RGlLWHcrMHBQRTN4SHIwTFUzZWtTS1Z2dHlJK2xhYTF0eFhoSnRp?=
 =?utf-8?B?RHMreTJJMXlQMGtxQStQZUxrdDA5bnVCNFVTLzlWUVdib01RYmI0Z0lkMzJF?=
 =?utf-8?B?bURBSDZQWmJydGppejY4eGtQVTlPUkJkTFB1NDY1N1VsTFdBNFlOSm1RTkU1?=
 =?utf-8?B?VEZEV2xvUEhkWjlheFRqTTN3WVVOMGJHMGZ3dGNIQjdCOVZROGNKOUxwMmFC?=
 =?utf-8?B?N2lkWi9IaW1zamRsN0wyVHlRUEY5ZUtua0tTTTZnUXFXWmsrNDc4dlhldU9L?=
 =?utf-8?B?QzNZQ0pZZGUxKy93akRpYzAxQ1NqbWp0MG1Oem9SZnBteUpwbnNKS0dPMWRy?=
 =?utf-8?B?TlNWMmNkK3ZJb2FaTTc5dUtiYVpCa1R0SlNKcGV4c1B2bkNvVmlQN293K0k4?=
 =?utf-8?B?VXVwaTFFT2xpLzNPeUFsMERpNjB0dEFyMmJsOGVwRE1OazZVTzRldmtXMXky?=
 =?utf-8?B?WHhDUmZqaW9ORk05aTZhVDg3WjBPMzcrSi9Wc3BMdkVQVlBTdHhoZWxBV1V3?=
 =?utf-8?B?RklYVlQ1S29OMHpsOFBBVzhYdUh5aDJBZnhVZEluZmJKaUZ6Wk9yNnlvRWdF?=
 =?utf-8?B?M0piVzhTdjdzQXZrTHBTMmJCSklZNjdPWTBiczBKSG9LdmRHVFozYXhCd1hT?=
 =?utf-8?B?eFJwYitkaFdMMGF6ZnB0SXQvN0hVWVpweXYyOUdpYmlIbFpERk5Ud0RCNUgw?=
 =?utf-8?B?UFdYUWRXSTJTR1RMQXE1aGVXM216ajFXU21mdG5TaCsxUktpYkNSUUw2U3la?=
 =?utf-8?B?N09ZWURKN01GdUR0SXlLb1poTXFtUG1RQ3dzL0dadklFZ2dDYkFabmpSRXgx?=
 =?utf-8?B?akxCdU5ydzRFak5ENnhuRlRLUU0yWU9DWnhlRnl0dDhNTHdIY1c3NHRVeXVn?=
 =?utf-8?B?R2lhWXlPVGJNR0luZ3lnU2NIdG0rR0VUbVF6dS95eUpjcUVxRE9ER3VOMmlR?=
 =?utf-8?B?VmtQVUV3MkcveUhienFxdDJOUWZFNU9qdFlNRk04L2p0SVZ3Zkp0YzhUWUVE?=
 =?utf-8?B?SVROQjRGL0JDWFVXNHpaOUdhNjVORnkreDVTRGcydExRSnJ2eE9lN1JYQU9N?=
 =?utf-8?B?RnRJendnb1VFUGVoZ3lkRU9QNmFyUUd0TXBqTS9ybHlDbWsyMjJ5WUpENGlq?=
 =?utf-8?B?djBvMGNyZllvYWFDaUJ1cWRwMU1ZMmRsTVNZaGV4d0tMQ0NIL1UrZTBSSVZx?=
 =?utf-8?B?M2ZjU3NhbnUxMkw2aTVqRk1wU3R0RHF5WU9pS09BdURMeVNsbWtJYnpQU1Uy?=
 =?utf-8?B?ZENEYitReHB6RC9WL0FVanU5WmVjM3Z5UTVIZjAvRTcrblFDRGlBZng0Mk9H?=
 =?utf-8?B?VHRUWG8reFhSRCs3ZzhXVGZpejdJbE5NL1FaZWNGUVNnc21GTTl3VmwrVDZQ?=
 =?utf-8?B?MTg3WWVPblhIYUZ6dG1xaDJ3aWtrcUhteUdaU2lIUkZ6b3B1YmdtVGUxeVcr?=
 =?utf-8?B?NjcxS0M4eGpXb2JtVDRoV1llQndWMGJ3cG83UHlJUWJKZktxRDBKdW1mNTNn?=
 =?utf-8?B?bVRqRmd1TVY5aU1ZS0pjNkZ5dENaUHpjYjNnNzJuV3N5MWZscDIrSU9Mallh?=
 =?utf-8?B?aXFUcDNsOHJzaDdrSTYzNDZGbXlqdlhaY1NZT3NFSm9PSmxKdjI2QnZqcU1Z?=
 =?utf-8?B?bEV4aEJPNkdYbTByNVhwTGU2NjF4VzhUeVZNSW9URzNjdHluU1RhWHBzWk9v?=
 =?utf-8?Q?QYGfWXCB0jw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3hGem9aRWllWjJ1bFM2cUVDcGJKRGNmYlBDMi9yTU1TN0lQYTZ0MWJNN2ho?=
 =?utf-8?B?VmZZOS9GTnlBcDBBZWdqSjdTVUNuSGl3bVR0cDhONXV6c0RDNWhJY1JpanJJ?=
 =?utf-8?B?MmlvYlVXYWlweXZkbnF0azB5K0ZtblRsS2IxeFBFdW1RbXQra2hQK3pKcXNh?=
 =?utf-8?B?b2N4NXh1ZEo2VnRzL0I1YkFtRklBRDJZNitHNFlhYWN3QnNXUzh1M2pJYXJp?=
 =?utf-8?B?WUNhY0YvYWRQSmQyRWttalhGZlZOR1c1WEhEZjVlSjR1VXhVVGJXQWpnd2tE?=
 =?utf-8?B?RW5PSUVHa3MvS3dVdmY0MDlJSFYyTE9PY2pVQjE5enBkL1hmZjZUcFg0V2lF?=
 =?utf-8?B?YTlFQnlkSXZTdGFXTGQrVnhFR0ZzUWxrZGtabEpDYW5wK0E0bGlsTzR3SGV4?=
 =?utf-8?B?d3ZnbjZ1T0VrSE4zOTcyRXdMckRRZEN6NUU3NTVlaEVDUFJ0ZW94R3JVRnVo?=
 =?utf-8?B?K2ZNNVpVU0gwbFZKMFNFWGtZTDV5VXlMR3A5L3oxaGM2S2NyTkY4ZzdJVFBm?=
 =?utf-8?B?RWM2QzcyYlhVS1V0L3p3RXBpdlBha2NhbTJRb1IwZXJyZ1pBSWtRMkhBZDdC?=
 =?utf-8?B?ZFZnZnlVajg3NTFpNFhIMzdpVVo1VkcvMzU3b0xNUXJuT2gwWngwQmFRbHlq?=
 =?utf-8?B?a21DMmJwSk5GS1h1ZTBHWHFwZ1MxNHR4NXFxbEp3Vm1IRGw2UldzNU8rUlRv?=
 =?utf-8?B?VXE5S2R0Zlh2bUFpeExpb2FhcVJYYWJFRHFuVDJRSVhyNzlOaUs4bjBSd0R0?=
 =?utf-8?B?dkNzSGNIZ0FyMVhFeVpoK01vd2VtMTFKUSs3QUJYRWdRdEZLak9nM2pjUmlI?=
 =?utf-8?B?emtxTHlpeEFkRW5scEZtTkdYN3RzK09qODZ4ZE1PSXhGWERzM0YzWVRkbzJF?=
 =?utf-8?B?U3dIWnZuU3JaQnBpWlZNVTVaSTFYQVR1RjFPcVhCemEyTzhmT1hnemN1bFB2?=
 =?utf-8?B?Si9kS05XeFhZdXBnL1pLbEJiUEtLTmZsS3FhYkEwZlh2bzNSaWdYTDRtMDNY?=
 =?utf-8?B?WTNycGpEMGoyTWZyTkpPU3E1SWFxdTVkM2ZTVDhjVW9FOWJKVWFKSTRXL3Vv?=
 =?utf-8?B?MkdTaEFuTGU4OTdHYUMrWWVibndpcEFBMEp0SGRwSkdJdng5OFhUYTFGTmtG?=
 =?utf-8?B?VXRDTzl4M2FIcDR0T0VOZjZtaXlXc3Vjd09yYzFrVnlSQ2JsZzJSRi9DZUk0?=
 =?utf-8?B?d3BwbDA1ME5VQ3FXNS9NQytuMU04ZU1FOHZyd1pjVEFvUWdxM0lPWGw0NE9w?=
 =?utf-8?B?czluVUdvUG5Yc2FTZEJrTWVHbHF3RTIxTmVRbi9xKzdOVGRrbWpXQ2ZXRWxX?=
 =?utf-8?B?UnFibG9iREpKSFRqREZzclBqbHYxckMrRFhFcG85N2hXbXVBTU5YMENWbUp2?=
 =?utf-8?B?Wlo4ZXBjZGpJK0M3Zk43K3pqeHBUQm1xYWNmamE4QmEzZHVsdU1rTFN6bW1i?=
 =?utf-8?B?czBtYXhmVnJxQUE2U0s3VzBrWmhWOFZCNTYwdHh0TGdLblpaL0V6TXVKT1Ft?=
 =?utf-8?B?SEI3MTRKTjZQNjBFRG9CVU1EdkpQaSt3bStwVlhhTXBjWFc4NnhaS0lFelJB?=
 =?utf-8?B?enczUnlQdnNHK1NtcjdBOVptOXhoUVJuQ2ZUd1JyTi96aVR6cnpLalBmZjQw?=
 =?utf-8?B?UGhBYW1ad3JidWlabXFMVGVGbFJpNS9OWmNQSHdtMG1JMzBhOVhMb042aHRR?=
 =?utf-8?B?ZGVETEZ5L1NzeGs2eW9BRlVCK3JYN2xJWVB2WWVrVEd1ZklMMk9aQ09LS2Fi?=
 =?utf-8?B?MFliM0lRd25tbTFpQ212Mkc3WFQ4WjFMSXpBenpod3hBT2hzMmNmV2hTK2tC?=
 =?utf-8?B?YW41bmlxQnVQS2tJbG5LamVocHhkQWJVU3kzTEo5ZnN3Y1VFUWIxcisvZ1Bj?=
 =?utf-8?B?ckdXRFlmbjVuWEk1ZTZMVi8vNzFIWUxOTUMySVBmSjExKytNSkJaWFdyaWx3?=
 =?utf-8?B?aDExbHN4NTVhcW5LYkNwRmFxT0p4NE5KNU1kSmtZNnZSTWlFK2tSN05RUEl1?=
 =?utf-8?B?UjBTWGJlaVN0UHZmYSt2UzdlNitIazkxRlpQL1lOR1lpTUdoMWV5RTZKais0?=
 =?utf-8?B?S1o1RHBSdnJGNUNoRmQrZy85QjJwSFZ3Rm5vcWErRnFVVGZxaEhiOUoxeUhI?=
 =?utf-8?B?Y3NZcHc0OXFHU3JvdENkQWFwU3dGUWdBaFJ1bnF0cWF0K0ZabnFjOXZ4Z252?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d21fd1b4-e09a-489a-7057-08ddcfa45be5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:04:58.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUq+Z4FpxMFrh95wHHkEPwMkA7/60Whi/huSwNAI+UfllTJWmup7nXMroBlySppxPKITsGNC0Uhi5kLsHKQYnmpatqU6311x+u+07NOqT6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5322
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:


> ---
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 4c24c5f3f4c1..3dfc177f9792 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -310,6 +310,38 @@ with the following files:
>  	  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
>  	  0=30;1=30
>  
> +"event_configs":
> +	Directory that exists when "mbm_event" counter assignment mode is supported.
> +	Contains sub-directory for each MBM event that can be assigned to a counter.

"Contains sub-directory" -> "Contains a sub-directory"?

> +
> +	Two MBM events are supported by default: mbm_local_bytes and mbm_total_bytes.
> +	Each MBM event's sub-directory contains a file named "event_filter" that is
> +	used to view and modify which memory transactions the MBM event is configured
> +	with.
> +
> +	List of memory transaction types supported:
> +
> +	==========================  ========================================================
> +	Name			    Description
> +	==========================  ========================================================
> +	dirty_victim_writes_all     Dirty Victims from the QOS domain to all types of memory
> +	remote_reads_slow_memory    Reads to slow memory in the non-local NUMA domain
> +	local_reads_slow_memory     Reads to slow memory in the local NUMA domain
> +	remote_non_temporal_writes  Non-temporal writes to non-local NUMA domain
> +	local_non_temporal_writes   Non-temporal writes to local NUMA domain
> +	remote_reads                Reads to memory in the non-local NUMA domain
> +	local_reads                 Reads to memory in the local NUMA domain
> +	==========================  ========================================================
> +
> +	For example::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
> +	  local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_writes,
> +	  local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
> +	  local_reads,local_non_temporal_writes,local_reads_slow_memory
> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy

...

> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 16bcfeeb89e6..fa5f63126682 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -929,6 +929,29 @@ struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
>  	{"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
>  };
>  
> +int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
> +{
> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
> +	bool sep = false;
> +	int i;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +

There is inconsistency among the files introduced on how
"mbm_event mode disabled" case is handled. Some files return failure
from their _show()/_write() when "mbm_event mode is disabled", some don't. 

The "event_filter" file always prints the MBM transactions monitored
when assignable counters are supported, whether mbm_event mode is enabled
or not. This means that the MBM event's configuration values are printed
when "default" mode is enabled.  I have two concerns about this
1) This is potentially very confusing since switching to "default" will
   make the BMEC files visible that will enable the user to modify the
   event configurations per domain. Having this file print a global event
   configuration while there are potentially various different domain-specific
   configuration active will be confusing.
2) Can it be guaranteed that the MBM events will monitor the default
   assignable counter memory transactions when in "default" mode? It has
   never been possible to query which memory transactions are monitored by
   the default X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL features
   so this seems to use one feature to deduce capabilities or another?



> +	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
> +		if (mevt->evt_cfg & mbm_transactions[i].val) {
> +			if (sep)
> +				seq_putc(seq, ',');
> +			seq_printf(seq, "%s", mbm_transactions[i].name);
> +			sep = true;
> +		}
> +	}
> +	seq_putc(seq, '\n');
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return 0;
> +}
> +
>  /**
>   * resctrl_mon_resource_init() - Initialise global monitoring structures.
>   *
> @@ -982,6 +1005,7 @@ int resctrl_mon_resource_init(void)
>  					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>  		resctrl_file_fflags_init("available_mbm_cntrs",
>  					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
> +		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
>  	}
>  
>  	return 0;

...

> @@ -2295,6 +2339,18 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>  		return ret;
>  
>  	ret = rdtgroup_add_files(kn_subdir, fflags);
> +	if (ret)
> +		return ret;
> +
> +	if ((fflags & RFTYPE_MON_INFO) == RFTYPE_MON_INFO) {
> +		r = priv;
> +		if (r->mon.mbm_cntr_assignable) {
> +			ret = resctrl_mkdir_event_configs(r, kn_subdir);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>  	if (!ret)
>  		kernfs_activate(kn_subdir);
>  

Looks like the "if (!ret)" above can be dropped to always call "kernfs_activate(kn_subdir)"
on exit making it clear that this is success path and function exits early on any error.

Reinette




