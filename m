Return-Path: <linux-kernel+bounces-759630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30572B1E05A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C48565382
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392F156236;
	Fri,  8 Aug 2025 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nzf7dDz9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121885C5E;
	Fri,  8 Aug 2025 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754618057; cv=fail; b=ZUZ+mkWQxNASRMoW5tfAEUlW/Nx3yWNENe71sMN339isYpL6E3AMGrs2LTngebPGH/2u6KGumnSHbc4h4qzChhVBnZUZPTY4mBIyFZATe/hZPGTcukj7GdXZB1lza5RqGxjERdRZKC8h/w0/vPfnyx43+Ev32jNmzIa/CC69Dsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754618057; c=relaxed/simple;
	bh=aEwyuYP24ml35eKXUNGBCohfn4i/WBnQZWsV5KEoRNY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ylw0pwXxPNO62KuNE6NHW3e5jUjCNtkLaW5jCtj4Qiig637rwoLIprt+d3Mx9pa+4wQ0wdpS2RIjNAfF3gJIx6h3HsFqXH/rjDVPYeT1eD3zaHMr2ixAu1Lvpuc34BNS8i7I+phR4QTHzxcByeOWNs0xzUTL/BfR0kS7Pv2tA+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nzf7dDz9; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754618055; x=1786154055;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aEwyuYP24ml35eKXUNGBCohfn4i/WBnQZWsV5KEoRNY=;
  b=Nzf7dDz9LjVhz3h9lLhFMOE4w0UTFHQF+dqIkevAVJRBbt/pz2HKUcoM
   ufeqSSALw9ecNFuB4i+qbx4LyWZHP2jAypQqw1otJOx3ZrIefhF8xZfdm
   IJfAHf29s7UfZQLObVOOF+xGFkDaQiDgjgL5Tg1SBegdsEZT2gRcfp+1J
   J/JEX5LFOjNkPPRR28LL5ZQHdDR0/XgjlSWTGaEzVeI+tGQkwAkmikgGM
   rLYEbMoBunxYAUDyFcv0CGKJnEKgFnSwll5hsJ9pk33Qf0hx0cPCvJ5CM
   FQP4dIVkCP4tGGutWG3ZHS3ZQ3Tmv80uHlVmbXfKQatv8WYJVT1SU9opG
   g==;
X-CSE-ConnectionGUID: 0Yr7NjgDRmCNRG0zPbtFag==
X-CSE-MsgGUID: 6WZntAPpSeWcDurVza/Hzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56885540"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56885540"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:54:14 -0700
X-CSE-ConnectionGUID: EtlykFk8Rd+Hbqqi95DenQ==
X-CSE-MsgGUID: h/GmbiE6Tl6r4//JdiTbkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="196039261"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:54:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:54:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 18:54:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.61)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:54:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiGo6HlPKZhzoQ21KB9cxJ6rqJM1QICfmJACDICCDkvMM2GDADFqLkq1wYtmAmrPTZgkby8Lh788Ye2ygk72pCdTGyr7NPgLOP6tEAnL01Tgum1LDFJBqXzRLpY/VK/3IuSen8XGFdJfNM2bsRfglu//Dg5wnjRzvS5SPHRxEJM9larzh+YH3w+LrvHVqJiCz5jbWG14WD4pUmYO5zJRgk+JRmFmX2AYH5OYb8GjBMCOrQR37dw0cujgPyjr646QEjs10o7kTQ3XQrZB4ZLRgsTgHnYiVwJy7G0e2ChadFU1IDwVPtSleUCqk22MCc9XIU8PqJZ8h+JOVsy0lGWcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7eD8XHVFPaMzUJ6SdS0anZyvgSeozr3jZYcv9WcngY=;
 b=Eb2PbbRq+EbnxZIuAdY8/rDrLa+EufKwVD98tACScXxGojEU32waxg+7OybQ/v6JzWSEjwBk1xkrTxxcgxDdMiu0suv/T8Um6I2RkPHKvnwJOcC7DWlDUgS7YH1jhX+MntD5f1sEDcrNngqS9zd7Vwp2uPYtE+ytfscUMU4cyLM5wbV4dKPmu62N2jVfTYVoq7U2cix5uSYfvKSb/8uFlb0mbX9ZCtG5y/ugxNDLVMPPmsWr6LeDA06MT5HA8g0eceVRnWQe3ifjTOLa3Tk5dyz7g/MlEhtiYDyB74PORkwrf0TvIVyMNgMGvQ7X5aRs30mPaZLxtR055gsQJ/D9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 01:54:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 01:54:11 +0000
Message-ID: <79e7f426-e592-436d-aaee-f448282c66a2@intel.com>
Date: Thu, 7 Aug 2025 18:54:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] fs/resctrl: Update bit_usage to reflect io_alloc
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<manali.shukla@amd.com>, <gautham.shenoy@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
 <6d34357ee32bb519c607a0e2f0195194c1096d7c.1754436586.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <6d34357ee32bb519c607a0e2f0195194c1096d7c.1754436586.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e7178c-21d9-4a38-08d2-08ddd61e7894
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHQzYmV5bGhPUC9UbVpBaUxlU2NlUzRicmdYdWphb1c2MVp4Vnp4YThiMHZH?=
 =?utf-8?B?QW5PUm5MYXo2RG5PZ2p1RXVMcDYwUWZQR3hGaXRaK3JTaERRa0FtYndtVUVP?=
 =?utf-8?B?KzVhNTcveGI0YStrenZiZWpNb21FdTlSeEdycmEzTktwMEovbWtoY3lTU1pC?=
 =?utf-8?B?cE1WbVc5NGR4NE5oRnJ2cmhiWDhJNmo3bElqSElyaVVDd1J6QUNaMDJRdjdR?=
 =?utf-8?B?RlRzclk5RGc4VFVYV2dPczlqNXVxdUF6aGx2bVFXYURkRTV0WnlQWWpNbCt5?=
 =?utf-8?B?UWtwdlR2MU5TODNlN2p5ZzhJcXNVeWRNdklWdFJxa0QycVViaGlMRWNRczFV?=
 =?utf-8?B?NjYraVppUENNUjdIREswaXBaQlNMUEFtNWgvbS9aNVJLckVnUFd2SFdtcWtQ?=
 =?utf-8?B?QXBOYnFFeTZwR2RLSkFjZDZLTTBlMDdObDFRZVZySmJ4MFB0MkZaZ3AraFFk?=
 =?utf-8?B?akp1RkMyZmZueW1vUmRFOEh0YkUxQnF1WGZEc1BHN3F1VXY4dTV4YmJXSlFR?=
 =?utf-8?B?bkJmQlpUSDFIdTRTdHRPbDhNdUQwSUR3eGhNVHZweGlwNWxGQm9aOTBvWWpo?=
 =?utf-8?B?UFhRUWNwbzdOR1ZWTTFsNzdpd2lNOWx0MUxJYjRHaThFS0sxa0p3U0ovZC9w?=
 =?utf-8?B?UjNvRkNhcTRtREJTTUlwamVQbzNSRWhkNE1aTkl2VG9nUzJBYkRiZTM2eUhR?=
 =?utf-8?B?Rmh2N2ozeUdxZno5L1pWdndpUXV3dzQ3Wk9Ncmk2OExRRS8zUUk1aDJIQkZK?=
 =?utf-8?B?WWwxTmZPWmNuSjlhZGtmWXJEVXgxVkx4WDVUNXZBWDNXQzRmRE1ZNlcxYjcw?=
 =?utf-8?B?clR6N1pOTjluWTVxQU5SVDlBV2tiaDMyMkVRenNhQ0hlY2tjNml1NFlQcXBB?=
 =?utf-8?B?UXV2QWJZcFl0TFBIOGdsajFhOUZDQ0VqTzMxanNGczU5RDJNT1B3Ym5GMWRJ?=
 =?utf-8?B?TDNBRnhqSDBIMGZ2SVJaWWZUMjJZbTVnTlJjUVI4OEZiYUhITjV6bUVwdTdl?=
 =?utf-8?B?Z2IyYWRiZElzaWhDd0ZTeC9kZnJYdzNFb3VVUDVOczgvRVJPcUdGRUlqN1hY?=
 =?utf-8?B?VTRnMjA0K2t0SGpMV1ZyVHQ3K1FIVXRoUlZQZmhhR1k5aFo0OUZSYStGNnQr?=
 =?utf-8?B?ejZ4RHowNVBPMjBjazJDM2s2b2s4QWhhSU4wYnF1bktOZENjTnd3VFVQRmZo?=
 =?utf-8?B?YjVSNk4rWGgxOWVYSEdLVjlGSnl6NEtFaXVNcmtUOGlkV1NwS3JZWWtFOGNM?=
 =?utf-8?B?RXJoTkhvYXVGR2s3VzdYY1prMjlzTGRaZm9IWk9YRE1iMnN3SXExQzVkdUtv?=
 =?utf-8?B?L1A5WGFJNWU1REg4RXZ4WEllY2t3WEJrd0lDc0l5dFpiRTYxVzdGYUtoTGlH?=
 =?utf-8?B?bVlOS1FFY1laRVNzZ3hZdzcwRGRCZDhGcEF4dHlCcGo3Z1ppRzFBOXNkMksz?=
 =?utf-8?B?M1NLQTlCUXJUY0d5T2pJZ3gzenBneEhwdHpWK3NzTldTV0ZsOE42cmFaMlRB?=
 =?utf-8?B?L08vTFFMeURSNmlFQ1ptRFlJb1p2a1FIelhtMytzQWM3OExHSlV5endUejhn?=
 =?utf-8?B?TU1nSDVoUmNkMkU2bkpkUk5KYVhmeXMxbFJoR2FkL3pqc3pENVdsSVA1YXZG?=
 =?utf-8?B?bE44MGxHR2tOeDBIS1FwR3JHdjV1UFBwbm95YjRMa2pEalYzbERFbEJqaVBU?=
 =?utf-8?B?aDBkdlZOdER0YWZMM25BNFNkcnRQTmV5VC82OFBJYUFlSExXWkQ4N0NacSt0?=
 =?utf-8?B?WjdsZWtBYWdXU1hVeTc0bTlXekhHS2J2WHVzY3FzWlVFYUEwSytpRFJ4ZG1Q?=
 =?utf-8?B?OGNFUlhnNzBHNlRzTTROUWdYRHV4eVZoSVIyU3pPRWtXRlZoY01GMFRuWkZO?=
 =?utf-8?B?U0IwbW1TS3ZtcTNEbzIzMlNDRXBUc3I3Mk5lTFN0ZnhZZ3prdkFET3Z0YXRr?=
 =?utf-8?Q?LbhZaVoTMQs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFJJeTNHaFppOWpUSHcwQ0ZNQ3F3ZzhhdFBkcUJadEg3SnVtVmJET3c5bVdL?=
 =?utf-8?B?cTRHK1JYOXkxOGlEb0NHK2l5cWk2VEdLL3htKzBwTlBmc001eTNzZjhGQ0xM?=
 =?utf-8?B?bGdGb3gxYi9rNEN5dXYyaGlNdEpqWkZlN1JGbEpJS0RIU2p6Ky9jbW5aKzhB?=
 =?utf-8?B?OThQOUtPTStETXdxWEg3cUo2SzBhKzdhb2JJd2Z1SWFpOEM0OCt0ZzhXWDgw?=
 =?utf-8?B?eU5KQ2loMzFHMWxwTDNUTFdBeFBienZKTEVSeEJiTjRwYmp1VFEwNWcxcUF2?=
 =?utf-8?B?VnFpWXRPRnBMUzRmNWIxb0hXY3dpbGh5QzN0QkJrOC9yOStOYW81WVRLWGpw?=
 =?utf-8?B?TmNsRmdWL1l3cmxxUGljeHBEM1ViVE1PT0VOWVI0TlBsMFpCeGhtUkExMWNl?=
 =?utf-8?B?U0xPYTlxODVaQXpuUmNvemxUOGpEbk8weTF5Y3lZK05DWmVVdmpwVzZyeG9p?=
 =?utf-8?B?Zk8xM0Y3WUNINVdKRG9jaVhhQTkvUnNQdjNQMnRWWGtVdU14Zyt3eEd5a0t2?=
 =?utf-8?B?WGt2V3IvUDZwU0FFK0NWNDNqcVpwckpsdVh3T2JEeE12MVFGVDhVdVhrOElG?=
 =?utf-8?B?SStnUmw4V1ZEejlSS0p4RFVvSlFKbkJHL1JROVVVVlh1RUttS1dGSGxKeG5s?=
 =?utf-8?B?cFlUeUs0TFhlMFJ4RzZHTWc4MTMrS0dXR0p5amlGcExvM0g0QXZ0UWZWTkRs?=
 =?utf-8?B?UGpUZUtYZjVveUxIRTVaNGF4TDB5T3k4ZVRnVUdDenNIOGgvbWZkMmpRZVVP?=
 =?utf-8?B?MitaUUFqVjRETEpSZ3ROOFFwZHMwL2lVMzhxVW1UNDFkM0E0aFNubHRkS3RQ?=
 =?utf-8?B?L3ZOcEdiZ1NYczI4clM4R0lUREs4ZkNNZktMbjNPbS9VMUJiRGJBQWpaaWtG?=
 =?utf-8?B?c3FEVktBYk9nSTFOQmJVLy9qUVdIM3VVWTlGQms0RW5sK2dsbUc3WW1iRUxO?=
 =?utf-8?B?NlF4Y3F5aW9HaUtEeHN4YVFDQ3phbGo2VDgwRDQvWEN4L2JuOVNNREdDZ1ZI?=
 =?utf-8?B?UXJTVEVuM3hKakRKMVZweUljU3JHZ2pWRDNpL0ptSWJ1VHdTNmcySHpzejdS?=
 =?utf-8?B?azF0MFd1UCtiUzVaSkhqTTFHN2oyZjNMdy9tOC9yTEV1LzJhcjFxVjdjS1Bx?=
 =?utf-8?B?b0YxSWZzSlhtNUs1SEswdXNXcFZNMnBDNjlSd2x1RjZ1MjRselYvVURGcWU5?=
 =?utf-8?B?ZXRrT1p6UUF5SXFSNE96eHREYzVsQnFwSHhTNEVuUlFEUnJva3hveVFXZXls?=
 =?utf-8?B?SmZUMFIwSEJxUXVQWEVXeCtWU0lsbWV5RUF1dUxLMnJTU2hZd2toWExlZ2pE?=
 =?utf-8?B?aVpSbndBMit2SHo1MzZoa01SdEhSTEQrQTExSllqZjlZcWhSeHE3TVZyQ2dK?=
 =?utf-8?B?ZmU2eUVUdzMwZWtJcElsdThybERyak51TnUvcmFDK09KcGtYM3VaUHN3MkVx?=
 =?utf-8?B?Q2JUZ25sa2c3ZXpUcGRyeCtWbWhVQVNoQlprb21FNVErZ1lOVGx0QXc3VUV4?=
 =?utf-8?B?QmQvQ3U2SFNtZDBvM0hrYW8xT1JrY0x0eGViQ3pwVklYMXd1bG9JaEJyQXVJ?=
 =?utf-8?B?WURndExVQk1DdGN4a3JxWVQzdm1IQTJaS1BDN0ZxUXppOEF5b2NyekdqRU5N?=
 =?utf-8?B?S2cvZTdJVExQSUQ4MGNNOFc2eitnZ1RSUnkxT2Zsa2hpczdTc3o0dHlQYjFB?=
 =?utf-8?B?UjYrV0RzU09TcTlCN3Z6OE0zREt0UlhFREpRblR5Qm04bUdKYzRpSTd2V3Y3?=
 =?utf-8?B?dVJpSlZJQkgrN3BlNWRRYjBlUFdKeks1M0g2TEdrbWxiZXdOWWtyM29nWFhB?=
 =?utf-8?B?N3BiNjYwb3J1eEIwNDRTbHNCTU1pbU9VTi80Z1gxakNwaWcySFJLa29QS2M0?=
 =?utf-8?B?VldSZnl5WWVvVm5tL1QzM3NUU1NwM2svSFozVytyUVVQUVdiUFRxL2dSOS9T?=
 =?utf-8?B?bFRFS2FsSWxuT0g2NVU3Z2Q5UkY0ZU0zbXdXeTdOV2grWXhDWXF5bTV5WlM3?=
 =?utf-8?B?WGVmUVh2OXhMcG5GY2l0VjVmUUlISHNPZ3RJczltdWRnSlZqdkVTdUdSRGd1?=
 =?utf-8?B?bzMxOFU4R09JRmlRUXRuVGdsNHhaMnh0c0g1aE05NVZsOVZjeDU5TE9qd29O?=
 =?utf-8?B?TEFmZm5BYjJpdmNtU3NXbzNvUVl2YmdqTGJ1L2paK3RTcWJCREU1T3dEeU9G?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e7178c-21d9-4a38-08d2-08ddd61e7894
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 01:54:11.8105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUN1kg7fXWQqZcGBlpmnPRo7jxyF17ExDc65GS1gt7AI7ja8aGjAtzT6KXbcP0TICPAWzEfJ5lZROMbNyyDqvtghabcvxWUh3j8feR6Rhzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

Hi Babu

On 8/5/25 4:30 PM, Babu Moger wrote:
> When the io_alloc feature is enabled, a portion of the cache can be
> configured for shared use between hardware and software.
> 
> Update the bit_usage representation to reflect the io_alloc configuration.

... but no update to the bit_usage docs :(

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

..

> ---
>  Documentation/filesystems/resctrl.rst | 19 +++++++++++++------
>  fs/resctrl/ctrlmondata.c              |  2 +-
>  fs/resctrl/internal.h                 |  2 ++
>  fs/resctrl/rdtgroup.c                 | 18 ++++++++++++++++--
>  4 files changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index d955e8525af0..1e46231b929c 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -90,12 +90,19 @@ related to allocation:
>  		must be set when writing a mask.
>  
>  "shareable_bits":
> -		Bitmask of shareable resource with other executing
> -		entities (e.g. I/O). User can use this when
> -		setting up exclusive cache partitions. Note that
> -		some platforms support devices that have their
> -		own settings for cache use which can over-ride
> -		these bits.
> +		Bitmask of shareable resource with other executing entities
> +		(e.g. I/O). Applies to all instances of this resource. User
> +		can use this when setting up exclusive cache partitions.
> +		Note that some platforms support devices that have their
> +		own settings for cache use which can over-ride these bits.
> +
> +		When "io_alloc" is enabled, a portion of each cache instance can
> +		be configured for shared use between hardware and software.
> +		"bit_usage" should be used to see which portions of each cache
> +		instance is configured for hardware use via "io_alloc" feature
> +		because every cache instance can have its "io_alloc" bitmask
> +		configured independently via io_alloc_cbm.
> +
>  "bit_usage":

More ignored feedback. I was expecting changes to the "bit_usage" section.
https://lore.kernel.org/lkml/94d075e0-6703-449f-9c0c-8e5973349dff@intel.com/

>  		Annotated capacity bitmasks showing how all
>  		instances of the resource are used. The legend is:
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index 1f69117f96f8..cfa766319189 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -754,7 +754,7 @@ static int resctrl_io_alloc_init_cbm(struct resctrl_schema *s, u32 closid)
>   * resource. Note that if Code Data Prioritization (CDP) is enabled, the number
>   * of available CLOSIDs is reduced by half.
>   */
> -static u32 resctrl_io_alloc_closid(struct rdt_resource *r)
> +u32 resctrl_io_alloc_closid(struct rdt_resource *r)
>  {
>  	if (resctrl_arch_get_cdp_enabled(r->rid))
>  		return resctrl_arch_get_num_closid(r) / 2  - 1;
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index 5467c3ad1b6d..98b87725508b 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -395,6 +395,8 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
>  ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
>  				   size_t nbytes, loff_t off);
>  
> +u32 resctrl_io_alloc_closid(struct rdt_resource *r);
> +
>  const char *rdtgroup_name_by_closid(int closid);
>  
>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index a3ab2851c6da..b85c2622c94b 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1068,15 +1068,17 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  
>  	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
> -	hw_shareable = r->cache.shareable_bits;
>  	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
>  		if (sep)
>  			seq_putc(seq, ';');
> +		hw_shareable = r->cache.shareable_bits;
>  		sw_shareable = 0;
>  		exclusive = 0;
>  		seq_printf(seq, "%d=", dom->hdr.id);
>  		for (i = 0; i < closids_supported(); i++) {
> -			if (!closid_allocated(i))
> +			if (!closid_allocated(i) ||
> +			    (resctrl_arch_get_io_alloc_enabled(r) &&
> +			     i == resctrl_io_alloc_closid(r)))
>  				continue;
>  			ctrl_val = resctrl_arch_get_config(r, dom, i,
>  							   s->conf_type);
> @@ -1104,6 +1106,18 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  				break;
>  			}
>  		}
> +
> +		/*
> +		 * When the "io_alloc" feature is enabled, a portion of the
> +		 * cache is configured for shared use between hardware and software.

Please add snippet to comment that highlights that CBM of CDP peers are kept in sync and the
CBM used for I/O can thus be obtained from either.

Reinette

