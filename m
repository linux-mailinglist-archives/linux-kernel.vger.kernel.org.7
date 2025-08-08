Return-Path: <linux-kernel+bounces-759627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86829B1E055
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2107565315
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D18156F3C;
	Fri,  8 Aug 2025 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LY/2bDsy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1697A13A;
	Fri,  8 Aug 2025 01:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617938; cv=fail; b=RaRLWnRJDuVGQ/9Nj+4vpjin5cpvlBOIIritqkzQ9oQ5H509aZbkiAvUe6benB96PLZ9jzkw2fnkmHI9259e9dD605/rCAzW80LCAqNKTKuRhHUmBoXmRHunJt+NTwzdVDy1r7vdRMFLwP+ZSaTvlnRD+osZDV+s69LY2p7JUjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617938; c=relaxed/simple;
	bh=OOJVkXZYQNdl/0AcuSU9FF6ReFixG/+Q7MlJcCY4+Kw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M17VYm2uvMpx1CAUuezUxnU0W/aQ9iAOmwslK6nngY7BvaZ5TnjPPWhAv3J5hbrlnKz58OgtsYNGx/QcLiI52BdzA5Xke/bgSc/xzIjl6k4Vdr/BUb4wZgKP7wBRnOwflatLYcdMe49lkTpkqt2Vp/sW43ejWo/05WPcWVxgC/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LY/2bDsy; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754617937; x=1786153937;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OOJVkXZYQNdl/0AcuSU9FF6ReFixG/+Q7MlJcCY4+Kw=;
  b=LY/2bDsy9soWVYSUAsOQcuJTbN0V7t9TrhD4D9PIulCum8VpV8oT8sW6
   RC05ItldhSbfFwFvf9CvCuTLrxsQc7yiquBIyifGUwH+EEo590LZanLUk
   DftoCJK+SUjd3iOvAVWdcwzJ1aFlxy4HpqJ4OZTd/nq+ad0Vpweqe8sV5
   bvI83tcLRiDeHrkFz8pn2czSvljKgsBbxg3Ox/zh4pXyjjNixY0Cx2tnD
   c80KvquukSdCKa+f1BKMk0RPnOMLG0kWKS/jXXYADftrKl0g7EmSVTGNb
   5Xan4sMW9y6QvlkIfXuerDpFLTMQb/Nr1krhYMiTcIPyG4mOx4ANs2ykG
   w==;
X-CSE-ConnectionGUID: l8miB12WR2S5CyNzR5bqdg==
X-CSE-MsgGUID: u4jHs/tdQ4S3clBzQZvu0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60772334"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60772334"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:52:16 -0700
X-CSE-ConnectionGUID: Z0JMv+0XQkqhh4o2amwU6g==
X-CSE-MsgGUID: GRcbW69TSS+pxhFm7oWMIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="164450278"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:52:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:52:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 18:52:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.77)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:52:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz0ONDbE180zjjKzNI88N5XG06iKjeIeGvb8+i7cutYo0dOjJDGU7Rwahj4WB3q0x6HUmJ5vNNruUwxCY9ntg6QqVQ99e4MK6sQyR6c5l+h7651xqk//xkgVWxld7dk/G0IxisWbdx8M9WKpGR/YzyLoyOpwpjc+0ioA+IK1+mEjw1/9P/UWTB7zZGVzCh/hmNCfYAg1q2FXlJxPPEGEHBf3SPBxJKe/94m1SJsfQKhBbdgAg1VrySLLT/ZaWtw6ClkQ7yltsOY6pDmJjyIc6XX3cW5uqRK7QCdnURbjmRyWi9eUhmlSUMnp0p4eOxLU1z54toh1+XhU3xXg950oqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fGe0VoFq+y9+uuGYuhbatHLkUrFIjl/BW6k8sx376Q=;
 b=Vc6osIuyHGoNSni9jKsN+tzhHkgXJaJHVGlUkTGofUQWuKQZQDRLPmaGTrSOYQ0wTcRc1hn7R8RlkEggwEvPUt1Rx5d4Qi6E5jw+eSnPPlJV81DHVSmWYGE34L+4XN3ydtnVqeHL8H8k0eC9i49tj5QoZ1f9UzpIDcVB8aBItjmNTG+95+udSLdqDMTpD1/w89vWVGoBSeB5gcC4SUOEgqAkOf7PnVJuobXdGAohPw4JMGgUcqE3Tr38bVMQ2q1t2XWThG9zMo8UyU8hbYh6MXUyQrTf/bUPtGaLyivJk2DBgEijBzOLF3Kkj0M/qtk2OA0BCqCpUIfUFG2Hni328A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 01:52:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 01:52:12 +0000
Message-ID: <b08c1d64-8d19-48e7-853a-21947d61ff98@intel.com>
Date: Thu, 7 Aug 2025 18:52:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/10] fs/resctrl: Modify rdt_parse_data to pass mode
 and CLOSID
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
 <330b69d50c0161b7ac61986447a9867db7221f93.1754436586.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <330b69d50c0161b7ac61986447a9867db7221f93.1754436586.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b51d88b-6eb0-4f5f-61e4-08ddd61e316e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzNjSm9hc2w1NVZLQmVUdDgzMktkbmlPNy9NZ3dkRzloTGFyQlZOYzM3SC9P?=
 =?utf-8?B?cWw4UlY1VEJIQkVHS24rcGxLYzRTdWNBd0hsdmZicE1WNDk2bWZmbVRVYmVC?=
 =?utf-8?B?N2ltRDNQeHVyeHM0SzJ0M2xBdk1qV0hZMWxMZFY3anVnR2tFa2NWUWhEYWF4?=
 =?utf-8?B?UWk3ZStySitXcVRVcWdoUnpnamE5ajlvd1NjQ2Y2cUFhZ2RldEJHKyttVkxr?=
 =?utf-8?B?YlFsdGg4TFl4WkFheTZ5dHo1MzdZQmVxSUgvbzJSRnlXQXlHc0g3eXBpdllJ?=
 =?utf-8?B?Q3cwc1VZUjNCdmExYU15cE1VandWMFQrVmRCUFRjWEU5NGFHM0FYNGR6N2pu?=
 =?utf-8?B?RElwY0FldVVZZmlTQjhzSE1OdmRoTDJqcnlXdFhNYUlDWXVIVjExU1pwcWJT?=
 =?utf-8?B?S2FoWHJoUEZnM1l0dngvL0VpY3F0OVhYYUN5b1puRUJqRjlDdDdmWWMvajlB?=
 =?utf-8?B?aHhwR0EwbHF1WUttTW1WZWlxc1FEaytjTVdteUIwUTRwYk9FUkZaYXB6TGFU?=
 =?utf-8?B?WTg3RVQ4S0JsWTdNbkdvUFp0NngyNUhhQ1ZnRktnQ0x0dHN6RHRnaEMxem1y?=
 =?utf-8?B?NHIxNFgvYVMxM2luallyVGhIV2diMCt3dnhDcW9wTTR6Mzh0TWhWYzhqbDNa?=
 =?utf-8?B?azltR0UyZDdpMEVTUEszQlhmVUNlQTFSZ0UvVkJvRkpvL2F2enNJRCtrMW8y?=
 =?utf-8?B?YndVS1FtemJzMXZlTTV1SnNBUUZMQ1FjZVRwUzRoWU9PQlVKbEh0eHhOUDRH?=
 =?utf-8?B?bEVlMVV1RlEzVDBYb3NZV0Y4OFlPVEY1bDlKUjQxdG45QnE3dlBvRm1vUHk3?=
 =?utf-8?B?M1hPKzBDdURvVXNjOVpGNGhOcW5TRk1sWlFsNGtua1NNVER3YzJYT1piU2tX?=
 =?utf-8?B?V0VUbmVZRTU5Vmx3ZmFCbmpLZlZYeTFid2ZjM1FEWSt2TTFaN2R3RG9jc2FE?=
 =?utf-8?B?VU1TSXlSS3FkZm4zVUp1bytKemo3U29JZzZBN0J4a0Nsc2tlL3hyZlBsc0N5?=
 =?utf-8?B?MGpPRUNueTlqbENENnBpMlZOWDRVczNpWmxQSWx2dU8yc2t5YXRDQU9pY05q?=
 =?utf-8?B?QkdzcjhSQU9rbFh4TUN3Qk9ZY3o1SXdPUEI4ZUlPSTNoQXphVWVGQURGREYx?=
 =?utf-8?B?S09oNjBLNm9SMnd3TDBjMXlzQU1XTDVobWhnN2Y2K043T0VZRHVTVWo4SStm?=
 =?utf-8?B?aHFMWEM5YVB2WGo0WnNGdm5jMmZtMUo2ZDVVM0hYSkgrQ2Uzd2tKcTJMQ000?=
 =?utf-8?B?em9aV3FjbWl0YWQvMTljNHcwRVlVQlY4eEFCZ2xhVi9EVFBrcE9HRVhMdmJH?=
 =?utf-8?B?dDloUWY4TVhIQXlQMVgvKzAxTE40eVYyMTJhS00rNEFpbG5oeTNFaUFyNG8v?=
 =?utf-8?B?TGMxb3V2K21zbnI3N3pBQ1hpNTc5WDNnYzdtK0dra2ZzVmNjc2pJdVdjdmFp?=
 =?utf-8?B?bjlmaSt6T2RPMGgzUkQyRE12Y0k0TzR0ZXlHcTd3OHdONHF4cFZJM2x2SWoz?=
 =?utf-8?B?N0RidldMUmJ4ejhva2FLT0ZxdlBaYXNDQ3RQRlpQWHl3NS9FOG1WVzQzSEdP?=
 =?utf-8?B?bEhDVnJBdTlKU3ZROEd5dUh3QVY2RmJNNW1RTzkrYzFYUXFtM2luTXdhRWJP?=
 =?utf-8?B?bzFMY3kzZ0U2S1E2NVhTOUNwNTl2azhXQk5UZmxNeGdLY21hNTJJbGZ2YW5T?=
 =?utf-8?B?Q0M1SjNOM0RwMFJ0K2JFZHFScjZqcDlyOVdYR0xXSWQrUndRazkzdmV2M0JP?=
 =?utf-8?B?WGVqRDh4cmJYaXIvZm5CWmN1RUJKa2Y0ZGhmRVRpOVk5eWFDVG5qRUo4RitB?=
 =?utf-8?B?S0FQSGVrZG1HcVI0bDZBbThWV3cwSmg5RER4bEhjZml5UzZMMUQvMVNYbmV5?=
 =?utf-8?B?ZmcxVElvbkZJQ2ZuWHkwOWlMNS9tZERKL1oxb2lUeVhRK3UrdUtHSDF4M3FB?=
 =?utf-8?Q?r5+Nj3HTZD0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnJOQjQ1c29PeUNzL1A1ZExSenRhYktnbld6U0t0cUlRcUwvQmwxRDJGdEVM?=
 =?utf-8?B?SDdCTzdQTyswc2MrWFI1dVo4YXhzUk9LNWtpaTgwQVRYWjVZT2Z5K25jeExP?=
 =?utf-8?B?UUlkTXhSTTY1SVFUMU16N2RmbGp5M2cxQkRaSFRwN1BZa3ZWS3lIaXBrbWEw?=
 =?utf-8?B?T3hTaEVha1hPemlyWTZNVHBONXNmQ1MvcGFIL2tlL1ZiRmkrb3dia0pZQ2Jy?=
 =?utf-8?B?aU9TN01mdngyWVQ2NnV1MkpNMmhYOTIzME4yMkZIb1JBK2lCWEZyY2NUVHJp?=
 =?utf-8?B?ZmdPZE01TjhsbmxNZHBmWWg0UjFzdVhYbG9WT0J3YUhHdWFDWTJOUktITy9p?=
 =?utf-8?B?QWZtckplTEdiQk1uRU9iTWhTVk9EZ3Azb0hSc2Vlc1JHeTU4c3VaaEs2R3pR?=
 =?utf-8?B?NUljaGR1UlE0Uy9EbmZUaUdXWTMzRlNqYU8vS0o2K2V3SHd5V0VSYjE0WEhI?=
 =?utf-8?B?WU9EY2VqMnV1M0ErOHQ2cjFhQksxZTdVc0tjcnkxc3dQeGFuZ1BRQkdnOW4z?=
 =?utf-8?B?ckpUVXJldmJGVThGZm15akxEa05zZmdzWEtEdk1pN2xzMFlaZGtXbW4wVHgx?=
 =?utf-8?B?TXN3WmhvVDlYcXFoVnI4VU5EakJrNEUzQ3FLV2srV3pzNnZFZGRxUStXVGla?=
 =?utf-8?B?TFNVRjU2SFlzWkY3b1pSVDJzRTg4Qzd0aUJ3WWtxOU82UUFabkJ3SlEyQUpG?=
 =?utf-8?B?OGxSUzMwK3BtUi9PeHJpcmNnVndONytPOHZ0eFFxaHd4cS9iNDYzVUwydmFi?=
 =?utf-8?B?YzhHT1Uzb25DcUlHMCtXUHBKYmc2VWxlVVlJQkdwTEZ5OTVpMEt6Umpwbkov?=
 =?utf-8?B?T2g0cUhIbFV1dTNNUnRaR2hKZXkyM1hnNHdCelRRYWFaay9KZW1Gem12REhS?=
 =?utf-8?B?WFpTbUViUTJXdlBOaWtzY2RXN0NGNEFPQlN4MUpyQUlxQkJVbHZRTnhqQm5R?=
 =?utf-8?B?NlMwdW9uR25ZazRHcDZzWHhsVEpqYkN5eU1oZ1dEVFZhTk9tcjBIaVhON25S?=
 =?utf-8?B?TmNtc1RUZ0pEc09IQlp1WVUrakcwNzZrOHlIMG9aZzk2V21nWUpYbmVkQWZ2?=
 =?utf-8?B?cFp2MHBYYk44M2lBYjJLUTR1ZEMxS3U0Ly93WGF5dVh6L0lHSjlFZnV4UFIr?=
 =?utf-8?B?Rno3REIyUDRpL1hqN1FpM24rSGxQSXBnVU1YYmNGZG1nVXp4OXVKU2VzT3pU?=
 =?utf-8?B?ZXI1UURSaHVlNktMUWpwVlRPdHpuVGtaOTFqcFdkaXVkUTRtYmxpMWlYMmN5?=
 =?utf-8?B?ZHArb0piaFEvVjg0MnZQSlNQZHZzQmMzSXhOOVIxdHlrSVFwOU1lbVZma21E?=
 =?utf-8?B?SVUvUGtZRkpORkFRelc4UUJaaHp0bFBYd3NJM3dRYzQ5NmhQcHkwejN1RzlE?=
 =?utf-8?B?bGM0TXQ0RS85ZnZaWldPdHd5SllsM2syZDc3M21ZU0xCUmMyU0wybk5YNk1t?=
 =?utf-8?B?K2psa0FFT0w4MUY3Njc3MElaRGZFUUxBNHpJNEExamtUbzNHVnlnT3g1d0JL?=
 =?utf-8?B?dGFtL2JHc0NaSXo2NkJEZFdJZlhGSytmN2VWcERPcTVDQVRhaE51L0phUDVS?=
 =?utf-8?B?d2ZpOWlmTlQ1M3M1b3QxZ3diZzk4S28vUWFUa2VDK2xYOFNxSERBZk4vazJI?=
 =?utf-8?B?Rmoyd2tiV1ZHSGFJbXJGY0VLTEdjc1VNYWRSSlc5ZzZtdVpKWk1UcjhobEZx?=
 =?utf-8?B?SCtxVWtlTlpWUGFvMzF3Unh6OFRLWnlQTHJNa1kybENYeDFIY3o5Mzl3T1Er?=
 =?utf-8?B?Snc3S2t4YU1LVVhOSE1HUDRpTDIzdkkxbHNWQkVBSW5FRVJTVzBrVVhFL0pG?=
 =?utf-8?B?NkhQQUtlZnBPL2U2dkRrSWo5ckpCOHdkQkJKZmdkV3doa0kyc1JSRW1BWkNl?=
 =?utf-8?B?ZFhjN1dSYnppZzR3QXhheWFicC9KQUljRzBLNlRsVWxrUVhOQlM2cGc3SmxP?=
 =?utf-8?B?NzNUU0pIN012TXgzYlAyR1U5dGdSSWRVTjFoMFpZOG5QbkpjV0syL29sUDBD?=
 =?utf-8?B?aUV5UFZKeTEyM0RUbGJ3Q0R2WWk0TkFUTHJvTEJMSzV1N0tiZktzT2FCVUlk?=
 =?utf-8?B?K0VMcm1pWUprTlFSVE9GNVBtZEpqeGt4by8wN1N5OForak5CYkJadExydWEv?=
 =?utf-8?B?WXd6cU9OY3BOZ1NpNTdHWTZsb2xlWWtlencyQUlrNUM3U2pPZFBueUZsSm1v?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b51d88b-6eb0-4f5f-61e4-08ddd61e316e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 01:52:12.4529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCOAQ2HCE/QGc0zB4ODo/O5IuO3DbiQ1tH9solgdC3vxPW7gQ2YOtAamqaxtdqF4cb2udtMOZmqLzWiBrUpD5iApK2X4gRORCStYTmHxQ/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

Hi Babu,

On 8/5/25 4:30 PM, Babu Moger wrote:
> parse_cbm() and parse_bw() require mode and CLOSID to validate the Capacity

Again [1], parse_bw() does not validate any CBMs.

To be more specific: "mode" -> "resource group mode"?

> Bit Mask (CBM). It is passed via struct rdtgroup in struct rdt_parse_data.
> 
> The io_alloc feature also uses CBMs to indicate which portions of cache are
> allocated for I/O traffic. The CBMs are provided by user space and need to
> be validated the same as CBMs provided for general (CPU) cache allocation.
> parse_cbm() cannot be used as-is since io_alloc does not have rdtgroup
> context.
> 
> Pass the mode and CLOSID directly to parse_cbm() via struct rdt_parse_data
> instead of through the rdtgroup struct to facilitate calling parse_cbm() to
> verify the CBM of the io_alloc feature.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> @@ -156,9 +157,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>  		     struct rdt_ctrl_domain *d)
>  {
> -	struct rdtgroup *rdtgrp = data->rdtgrp;
> +	enum rdtgrp_mode mode = data->mode;
>  	struct resctrl_staged_config *cfg;
>  	struct rdt_resource *r = s->res;
> +	u32 closid = data->closid;
>  	u32 cbm_val;
>  
>  	cfg = &d->staged_config[s->conf_type];
> @@ -171,7 +173,7 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>  	 * Cannot set up more than one pseudo-locked region in a cache
>  	 * hierarchy.
>  	 */
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
> +	if (mode == RDT_MODE_PSEUDO_LOCKSETUP &&
>  	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
>  		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
>  		return -EINVAL;
> @@ -180,8 +182,8 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>  	if (!cbm_validate(data->buf, &cbm_val, r))
>  		return -EINVAL;
>  
> -	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
> -	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
> +	if ((mode == RDT_MODE_EXCLUSIVE ||
> +	     mode == RDT_MODE_SHAREABLE) &&

This can now be on one line?

>  	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
>  		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
>  		return -EINVAL;

Reinette

[1] https://lore.kernel.org/lkml/798ba4db-3ac2-44a9-9e0d-e9cbb0dbff45@intel.com/

