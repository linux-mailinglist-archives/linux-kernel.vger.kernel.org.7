Return-Path: <linux-kernel+bounces-739994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB21B0CE53
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE51E7AE02D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D106C24676B;
	Mon, 21 Jul 2025 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNGUPcSY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927F1A5BA4;
	Mon, 21 Jul 2025 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141341; cv=fail; b=emTRMRFX9YOwYNOmMOHA6wwlBKjv7dndvDYKHR0NT4DHaYxPh2UTaJzDwWMB1kJIrlNcUzp5ivd+LxUNqTN/7uVDyLL1wA+JG3KsodEu+uqZZ1QA7LjvKhA1SdK3n0k0Nl3BhjBzYXS7/1adJ5A+h6zPDH+pPS6hctg/vyyjSGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141341; c=relaxed/simple;
	bh=hL8TUfQT1bLf7ZRax9FWBnKIVvuIsGI9C0bzeIL68ao=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PB4LkBuPO0rusSWg+Wi390KnHWpcQFKcOz3O4u8qo8pUQ6RzAz5R0HQRDr7zCprRnSogmakyzn/4UnGjJfLvMb+cVDTL20b4pHe40s6fqfIBT5+ImcL/Kl6x0boRW6Z7jxbJTAtrBTkldRMtW4c7/ltQ4C5Y/hO76dQNoGjAMhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNGUPcSY; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753141340; x=1784677340;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hL8TUfQT1bLf7ZRax9FWBnKIVvuIsGI9C0bzeIL68ao=;
  b=lNGUPcSYkbQw1wmFsqO00SL/NviqNVGS+iJSKVuGP3lK2dGO/S85sfUV
   TWdc9mC5Fy1eY33X25DfIdKodYeSimrZ90lY3O8gPLSALq17GGUuLEnyg
   6YN661i3dJUQ9GxK+b3qqWXgZnNu6dP9SdpcMcvhlZKMYopmnHp8FQNT3
   oy20eFT2lv6l8V8NajhdVHNLzMY6/NyhlSXY0uN7kIiUI8RHWiBolMlCn
   aCSbQCtPcLH9MAyT1tA3mRIGFstdtELeurYts1ClsDZrPHU12wJN7bfWC
   IKdsca9Npp40WECqi/6CLtwvNZjpoX6s69blsPcNGAM3A4GFm3t50zFHm
   g==;
X-CSE-ConnectionGUID: WvHJsQpsR++BKulGl85pPA==
X-CSE-MsgGUID: p7iWTmn7SMGRcPy91NWATQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55486252"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="55486252"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:42:18 -0700
X-CSE-ConnectionGUID: +QYceohJSiu8KNEEMlJqKA==
X-CSE-MsgGUID: f2Hkvqn6QdG9LkyqEqkvAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="189924727"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:42:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:42:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:42:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:42:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnWRUqxXrl8JD53LYqq4LWIXMuhlkjUAJL+sO8R+bKXF+NVgsE/KZJ3O2V23PS6FvNB3gCU785RnG6YK3hdYh6TBB/DCJbAsmUvG/bJAJzagdK6xlCDKhTj4D98ywtliiUgpE2UDSmcxCzaTGLwWHz/ElbmeDkuiMAI4huK9Eb6JWCZMdlDeZXpkJWKdNoHm51Y8UYiqhmV6VpQyyiZDtNRgRFBxz94O4ASTr80ltRq9NxmuesoOWGXG+2q/g/9D5O0pcFs8YBo6Hxrhb+utte+Ct5cCHnEEPB9rGdQJEzmrK/6Li9BooqvvJCXLDPMIUgTF3pb5x5h+ywz56GDcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNb/bGElBNd1vuuPfC9kb3RWLJqCza1YJYKN2x+Kbi0=;
 b=xf1mUndUgP9jZ8JM/qHrNpX2Bzb2taAR0o+MQoTZVq09DrJq4VNhtkFUImim3yBp2ueyptYMY5jgV0Xx3fJPAyY9bwb13CMosuTqkhLS4zpn3y6By6528zsnljLeF0kglSJe4l7Pmy/vqlPHZgxQ1qAE6iwPvRAzCRP5u1O7pYwAkMAXkeDNLTDvxQx71q12AicQN93EuoM8LqCEs4gKXjdRc6qlqJEN+UnCFhZg2njbgq6MoFJIpkPkrZaOUcdG3TLuk4f8XYSRSuJY4YO2l+9Clh682sraXsgKUMArPk8oGCoWERdaNjFGovL7wgeIiPZgyvWacx8FalVbABQNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7386.namprd11.prod.outlook.com (2603:10b6:208:422::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:42:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:42:12 +0000
Message-ID: <7050592d-6c2c-40ea-a3c5-3e7fcf76c3dc@intel.com>
Date: Mon, 21 Jul 2025 16:42:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/10] fs/resctrl: Introduce interface to display
 io_alloc CBMs
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
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1752167718.git.babu.moger@amd.com>
 <7ca0bdcc27d4033d04131e2feca5921f85df0ac2.1752167718.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <7ca0bdcc27d4033d04131e2feca5921f85df0ac2.1752167718.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0143.namprd04.prod.outlook.com
 (2603:10b6:303:84::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 616bdfe8-f248-4edb-c0d7-08ddc8b0377f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWpaOEhXSDRBVE5XUjNtSHVrWjRZWHBhMDZNZWZ6MFJIK09iYno4SElpcS9C?=
 =?utf-8?B?dmtDOU1ESU9Pb2ZoT0hvYXVtOHJmRGRsRHdXVEc3ekR6WmpUQWRhSE56bDNx?=
 =?utf-8?B?cjl2UTJVQTl4UVE1RmNiZURpZk1xWUNWdDRtblZtZkF4N0d4NlkxSXdmczht?=
 =?utf-8?B?RHZmN3A2RkpYdExZakl2ZWc0NXZnNmZxUFJLS2NISWtza1p0U2Q3ZWxUc0JW?=
 =?utf-8?B?YzVjUk9jcWRBd0dQd3IzSVFzaWlFR3UzUDBYL2RWZ3BiU2h3UStaWmJ5d3dK?=
 =?utf-8?B?dEc3WnU4MWxUazRpanEyaGsvZENKRXFmUk55RHVHMlErSmM5UmR1WHJ2WitI?=
 =?utf-8?B?V25zQ1R4TWdhTG1HVGYyUnpSZ3h3Nm52M2Vqc2UxZzNCZGN3OTF6TjMzTkRi?=
 =?utf-8?B?V1pQRXl1OCt3YVJQRER6c3lVZ3ZGTkpqSmhnTGpuQ20zMkpZcTdrd2p1ZTJD?=
 =?utf-8?B?SGpUQTNHdWk1aU8zeGlHUWxFYWVBUExyRFl2OUUvNkNMWWxZNXdHQkxNRkg0?=
 =?utf-8?B?VU80dHliWFZNcmM1S3FDK2pHRXVDR1hvSUl1OFF4YmVyUCtuZzFQQXpNT2tG?=
 =?utf-8?B?Q05qLzZBakw1TTd5eVZJNjJLcmY4L1FsdHdIS3VIeTNDRGlramlENnVObTFx?=
 =?utf-8?B?SWFyNXRNdHhoOFZ3RElxRUszYUEzeGkrV3h5V0ZKSWRsNktCR0djSWJNNUdu?=
 =?utf-8?B?dGlJQnlGZVVjbm5sRUF6RW44VEl1ZWs4amVFbDVTUUJJblZlTkh0cXhRWnBQ?=
 =?utf-8?B?ZlFQZmNkV2xkWHJ5bkRHZ2Z4STZWTElnenVqMTJTMi9NL0FEdUt5T1NkZGo1?=
 =?utf-8?B?NjRzMkdBVlZKaE5ocHFYRC9OQUtCLzVLdEJEL1ErcU82R1NPUnhEbmUrazJT?=
 =?utf-8?B?ajI2THY3R3BxMmx1MnQrYlVrT09OK3BJUFd0Wi9LNTJ2anJEYW1QUVVkQWU1?=
 =?utf-8?B?RTh3ZXNXZk1lbjhvVnRnWFFJNzFGakg0T0tBWmg2NElTZmR1azFZcEhDWVhw?=
 =?utf-8?B?dlF0enJVWE1FL1UzUFI4WFZseXRqUjhGSFVpcjV3UERUTjVERjUydmZNWVR4?=
 =?utf-8?B?VTdXZFpEakpXTFUvNnpsK1VZamRhL0duUDk0allHSERYZHN6bHZDdDV5bWc1?=
 =?utf-8?B?eHladzZRVW1JbnNtQnIrazMzK3pJdkc3K2JnVHpnRWRWYU1JQlNoc2FzRWRM?=
 =?utf-8?B?R29ET01oR3RzcXBqNUE2NDBTLzA4WFhwYjRCWmh6YnhhOXlZOEg5ZlA2K1Fl?=
 =?utf-8?B?T1BHVzl2NlV2VERtK3FCRjNxL25SL3ppa0pNaWxSOWF5ZGFlbkM3V2xPWFdj?=
 =?utf-8?B?NFR3VVVHZ2phT3NVRkJUR3pZNktBM0xyeFRSNVZsKzZoZ1ZUNEI1eEVIMzdL?=
 =?utf-8?B?U2gwSW1KendpNkI2bUhUNFQwZXlvSkpsTVl5VTdrQVF1VFRiWnI1aDhER3Qv?=
 =?utf-8?B?L1VHZWIyaU5McWtJUk1ydFhURVpwVlp3TExkT3VqN2hBZTZvd3lwdWlHY0d5?=
 =?utf-8?B?QlRhUTRYNU05TURyTm84cTJRbTg3eHlKSmlQSUJHMkhCU2ZDWXAxMkpOOGkw?=
 =?utf-8?B?aGZnVFFYdEpRcXAzN2dwOFAvdkRXS2xkV3FlSXhRdGMwMFVBeUpDTnJEK3Bz?=
 =?utf-8?B?cy8rZUM2QmptTG1kbC9yVXVNSVlzTVQ0c2Fxb2JmRHdIUlQxZTQ2TFJxRDMr?=
 =?utf-8?B?NUlDVGtvOHhYSk9QUWtiNUpKVW5EaUpFWnVSSDc5RWtieDh3NTMzbEN6ZEtv?=
 =?utf-8?B?Y0x1aHdNTzBWQ2VvV3h0WWs0VjlGVWswbmg2bk5BTDJRU3JuS1k1cE56MXgw?=
 =?utf-8?B?YjdlT3RLS2x1VW96MzlNUXlHRllHQjQ3YTc1SFg3U01SNzBpdGJqMTBnQmR2?=
 =?utf-8?B?U05zN0Vka3lVc1lqOWU1aUt5SXpOYitnUmZJWkk1bkU1bmNpTi9NY29hd28y?=
 =?utf-8?Q?uyc2L1hbmzw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajgrU08wZGk0cEJqbWpxa3NJZnA1STZWZVZ6Yi82aDBzWXR0YS92R2xFekNW?=
 =?utf-8?B?T2YzNi9MeWVzNlVGeTFKNU1leTJDMUlwdmlyR1JoUUlIM1VaOXdOU2RiQmY1?=
 =?utf-8?B?S3EvZWUrOGpxS0J2U1U2eWlrSkN1UmwyRnhlY0xVSEFtdnM4Qkw0Mk9yR0Y2?=
 =?utf-8?B?bkNNVVB0czNvQ0xDNWdPeXN3dC9iWjlqMDV5cEFyQVZ3NlZpMkFvRy9OdlJ5?=
 =?utf-8?B?QXRQRExzVEJzTXh6WjBRN2FGL0YvYW1yV2EwaUMyMHNpK1l4UDZKMjg0VGpW?=
 =?utf-8?B?OXp6enF0TzZua3NLc3QrdTc0dXo1Nm1sQXlqUzFYbklhUmRKRG93WHZUUVZu?=
 =?utf-8?B?QmhkWjVDZnRMemJWSkRKQUFWWXZJYklBRkJydGl5ZWRLUkttNFFMS1kzUXJr?=
 =?utf-8?B?NUUrbFhWTTU2UHAweTZWTHBYaDR0ZzZaVmVPR0lYMGdzYXBGbUNhYXQ0NTNE?=
 =?utf-8?B?MjVKTDE2eWdkS0gyaEVXWVA3c2ZMSEFpTlljN1oxUE5lQUZ1RWpmeDBWY3kw?=
 =?utf-8?B?UlNCbXV2N2h6MjB6bnNqcGVOY2RJTi9OcWJEbnQwT2dpOEZlbHlJZzFYMG44?=
 =?utf-8?B?TjZjZG5ua2hpUjNCbUQ0QVl5all2NHo4ZFBXYlJ4RVJlaW1PRjVoZ1U4TUFx?=
 =?utf-8?B?VkFwYjNnV1lkdkxmZTBzd1RmK0VSVjI0Uzh2QU9xRHBQcHVVbWJBNTIwZUVX?=
 =?utf-8?B?M1NuMnl1ZzBvUlBvZkdJRnZFRkp1bWh2WjQ0WVhZOFByMXBSbXlvY1VLR2Zw?=
 =?utf-8?B?S1grTUNDenExbkNYMXZXK2p5OW1HL3RBakRXckVjbWNwSzIxU2VLem1nK3N5?=
 =?utf-8?B?bzUydEl6WnloYkZNOG0wakVWM1dFUUlJOVVDclB6RVJGc1FkS3FpcVZ0V0Za?=
 =?utf-8?B?UWk5dUFPQnBVUDhNYXZPYndwa3RqNE0zUlVNWVhyVDc4ZStISFNucjFZRGpY?=
 =?utf-8?B?KzVUYkNjS3N6bjBwdXlCeHhDbEl0V3NQN2pEK2VCTTNJeHIveC8wUzRoaUtC?=
 =?utf-8?B?d0kyWk82T3F1OHZvTGhIYllndUNnTVlhb2JqSEJZN2ZtRGs4RzRDeW9UcnVJ?=
 =?utf-8?B?VWxocFoxTVNqWXJjdWQ3by9GeUc4dkIvbXBsTndMb3hHQ1RCbjBsRldBejlj?=
 =?utf-8?B?VUYvY3FabDl5ajFJUklQcURaRTdZQkRpQW4vS2xMRVpqbE5TejB6YzA3Mk5y?=
 =?utf-8?B?WkFXdTc0amRmZkp1ZW9ncmtUanphRzNIWVd4UVNiOE5jM0JkQlhLeXZoUkVx?=
 =?utf-8?B?eXN1bXREdys0dkUwRStBc3V4L1dSOGhpSHpSazJ1Y1RaM2pReldnczBvcDEr?=
 =?utf-8?B?ME9vbXkyOUlEU2ptRTd0Zlk0andRUmlSdzdXckM4M3k4L3EvTVdWekEyWjBO?=
 =?utf-8?B?RnJDVUVVWDk4WStMSEZOY2lNb2g2Y3VxUExVdHViQTNsZWczY3NZRWFpQWgx?=
 =?utf-8?B?YmhkeGhhekIrVXFsU2VtVzU1V2UzbTFMbUhTK0RycEpmWmFJSDdURFBvdFo3?=
 =?utf-8?B?YVZVTlJURlNBYzhlYU94cFZudVNsd1NzcWF5YUhZbmVoN3dZOTQ1UGFKK3la?=
 =?utf-8?B?d0kzWk9GdHRhUDFhT0g3Njg0UWVKUktPMFFWQytkOEE0NXlpSXNaNmc1NFE1?=
 =?utf-8?B?VXU5Qkc5YkJFK3VKNW8zVmYrd1FvaFMvM2ZZU3o1eERZdFViZ0FIUFd2YWVn?=
 =?utf-8?B?dytsZ1FZL0NlOWJJM1dNZjBoaDNETmRUWlE5UlltQVlPc0NQWXJvVnBMOGJR?=
 =?utf-8?B?V01WWFBLSGFSaW1FQnh0STE1dXBlUkM0UGtzME9YTkNuMXlNY1ZhWEIrSzRz?=
 =?utf-8?B?elVEWlZSdDFVbUNQUUhtMks3QjBBbWh5Mk05cDhlTFhPN0VHeFBqN0lMUGVl?=
 =?utf-8?B?Q1RwZnNhQnBCSVJVZnRiTGdsRFFZenArVzZyY04vNDJ6em5JamgxWjMvbVJH?=
 =?utf-8?B?RmkrRHgzcStVMmVoU2hyUHh6ZFFJSjJibVo2cWdGUllrUXAvcHowQmZXVHJo?=
 =?utf-8?B?K29lc0NUZmlCek5zOHdZUnRWMEtwTFZmN2FpSzFObmVxZzVLZjdKWUZTZVRY?=
 =?utf-8?B?WGUzU1BGdEY5eUJpOHZLTjFONUpjY25ZTG4ySFFKZ2g3SDJBL2JPQitzdlFp?=
 =?utf-8?B?RlYreC8rSTRIVElXdlEzNlZLaVdSUmV4Zng4dkRDbzk2VmRDcnUxVTJxYnJ0?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 616bdfe8-f248-4edb-c0d7-08ddc8b0377f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:42:12.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBcJ07EzgEM+gCblafBCX6O4Ta9Nmvw8edz25pnX25Q6IM6IovbeiiqyRwopb1CLvVlOINaWD4LeGOidO++fv0VVInmVeE2r75U1GjNJcOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7386
X-OriginatorOrg: intel.com

Hi Babu,

On 7/10/25 10:16 AM, Babu Moger wrote:
> The io_alloc feature in resctrl enables system software to configure
> the portion of the cache allocated for I/O traffic.
> 
> Add "io_alloc_cbm" resctrl file to display CBMs (Capacity Bit Mask) o
> fio_alloc feature.

"o fio_alloc" -> "of the io_alloc"

> 
> The CBM interface file io_alloc_cbm will reside in the info directory

"will reside" -> "resides"

> (e.g., /sys/fs/resctrl/info/L3/). Displaying the resource name is not
> necessary. Pass the resource name to show_doms() and print it only if
> the name is valid. For io_alloc, pass NULL to suppress printing the
> resource name.
> 
> When CDP is enabled, io_alloc routes traffic using the highest CLOSID
> associated with an L3CODE resource. However, CBMs can be accessed via
> either L3CODE or L3DATA resources.

Seems like something is missing here since this is motivation for a behavior
but no mention of the behavior being motivated. Also please use imperative tone.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst | 18 +++++++++++
>  fs/resctrl/ctrlmondata.c              |  8 +++--
>  fs/resctrl/internal.h                 |  2 ++
>  fs/resctrl/rdtgroup.c                 | 43 ++++++++++++++++++++++++++-
>  4 files changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 189c1ccb92d6..c22a9dd667cd 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -176,6 +176,24 @@ related to allocation:
>  		When CDP is enabled, io_alloc routes I/O traffic using the highest
>  		CLOSID allocated for the instruction cache (L3CODE).
>  
> +"io_alloc_cbm":
> +		CBMs(Capacity Bit Masks) that describe the portions of cache instances
> +		to which I/O traffic from supported I/O devices are routed.

"are routed" -> "are routed when "io_alloc" is enabled"?

> +
> +		CBMs are displayed in the following format:
> +
> +			<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
> +
> +		Example::
> +
> +			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
> +			0=ffff;1=ffff
> +
> +		When CDP is enabled "io_alloc_cbm" associated with the DATA and CODE
> +		resources may reflect the same values. For example, values read from and
> +		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
> +		/sys/fs/resctrl/info/L3CODE/io_alloc_cbm and vice versa.
> +
>  Memory bandwidth(MB) subdirectory contains the following files
>  with respect to allocation:
>  
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index d98e0d2de09f..e78828b0408a 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -381,7 +381,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  	return ret ?: nbytes;
>  }
>  
> -static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
> +void show_doms(struct seq_file *s, struct resctrl_schema *schema, char *resource_name,

show_doms() can remain static within ctrlmondata.c by moving resctrl_io_alloc_cbm_show()
to ctrlmondata.c

Reinette

